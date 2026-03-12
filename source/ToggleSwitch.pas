unit ToggleSwitch;

interface

uses
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.Graphics,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ;

type
  TInteractionState = (isNormal, isHover, isPressed, isDisabled);

  TFluentToggleSwitch = class(TCustomControl)
  private
    FChecked: Boolean;
    FAnimated: Boolean;
    FAnimationDuration: Integer;
    FHovered: Boolean;
    FPressed: Boolean;
    FAnimTimer: TTimer;
    FAnimProgress: Single;
    FAnimStartProgress: Single;
    FAnimTarget: Single;
    FAnimStartTime: Int64;
    FAnimFrequency: Int64;
    FOnChange: TNotifyEvent;
    procedure SetChecked(Value: Boolean);
    procedure SetAnimationDuration(Value: Integer);
    procedure StartAnimation;
    procedure HandleAnimTimer(Sender: TObject);
    function GetInteractionState: TInteractionState;
    procedure Toggle;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Checked: Boolean read FChecked write SetChecked default False;
    property Animated: Boolean read FAnimated write FAnimated default True;
    property AnimationDuration: Integer read FAnimationDuration write SetAnimationDuration default 150;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property Color;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
  end;

procedure Register;

implementation

const
  TrackWidth  = 40;
  TrackHeight = 20;
  TrackRadius = 10;
  ThumbCenterOffX = 10;  // center of thumb from left edge of track (Off)
  ThumbCenterOnX  = 30;  // center of thumb from left edge of track (On)

  ThumbDiameters: array[TInteractionState] of Integer = (12, 14, 17, 12);

  // Off State — Track Fill (clNone = transparent / no fill)
  OffTrackFill: array[TInteractionState] of TColor = (clNone, clNone, $F9F9F9, clNone);
  // Off State — Track Stroke                           Normal    Hover     Pressed   Disabled
  OffTrackStroke: array[TInteractionState] of TColor = ($878787, $6B6B6B, $6B6B6B, $CECECE);
  // Off State — Thumb Fill
  OffThumbFill: array[TInteractionState] of TColor =  ($5C5C5C, $1A1A1A, $1A1A1A, $ADADAD);

  // On State — Track Fill (AccentColor / AccentDark1 / AccentDark2)
  //   RGB #0078D4 → TColor $D47800,  #006CBE → $BE6C00,  #005A9E → $9E5A00
  OnTrackFill: array[TInteractionState] of TColor =   ($D47800, $BE6C00, $9E5A00, $CECECE);
  // On State — Track Stroke (same as fill)
  OnTrackStroke: array[TInteractionState] of TColor =  ($D47800, $BE6C00, $9E5A00, $CECECE);
  // On State — Thumb Fill (always white)
  OnThumbFill: array[TInteractionState] of TColor =   ($FFFFFF, $FFFFFF, $FFFFFF, $FFFFFF);

function EaseOutCubic(T: Single): Single;
var
  U: Single;
begin
  U := 1.0 - T;
  Result := 1.0 - U * U * U;
end;

function ClampByte(V: Integer): Byte; inline;
begin
  if V < 0 then Result := 0
  else if V > 255 then Result := 255
  else Result := V;
end;

function LerpColor(C1, C2: TColor; T: Single): TColor;
var
  R1, G1, B1, R2, G2, B2: Byte;
begin
  C1 := ColorToRGB(C1);
  C2 := ColorToRGB(C2);
  R1 := C1 and $FF;         G1 := (C1 shr 8) and $FF;  B1 := (C1 shr 16) and $FF;
  R2 := C2 and $FF;         G2 := (C2 shr 8) and $FF;  B2 := (C2 shr 16) and $FF;
  Result := ClampByte(R1 + Round((R2 - R1) * T))
         or (ClampByte(G1 + Round((G2 - G1) * T)) shl 8)
         or (ClampByte(B1 + Round((B2 - B1) * T)) shl 16);
end;

function TColorToARGB(C: TColor): ARGB;
var
  R, G, B: Byte;
begin
  C := ColorToRGB(C);
  R := C and $FF;
  G := (C shr 8) and $FF;
  B := (C shr 16) and $FF;
  Result := MakeColor(255, R, G, B);
end;

procedure AddPillPath(Path: TGPGraphicsPath; X, Y, W, H: Single);
var
  R: Single;
begin
  R := H / 2;
  Path.StartFigure;
  Path.AddArc(X, Y, R * 2, H, 90, 180);
  Path.AddArc(X + W - R * 2, Y, R * 2, H, 270, 180);
  Path.CloseFigure;
end;

{ TFluentToggleSwitch }

constructor TFluentToggleSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  Width := 44;
  Height := 24;
  FChecked := False;
  FAnimated := True;
  FAnimationDuration := 150;
  FAnimProgress := 0.0;
  FAnimTarget := 0.0;
  QueryPerformanceFrequency(FAnimFrequency);
  FAnimTimer := TTimer.Create(Self);
  FAnimTimer.Interval := 16;
  FAnimTimer.Enabled := False;
  FAnimTimer.OnTimer := HandleAnimTimer;
  TabStop := True;
  DoubleBuffered := True;
end;

destructor TFluentToggleSwitch.Destroy;
begin
  FAnimTimer.Free;
  inherited;
end;

procedure TFluentToggleSwitch.SetChecked(Value: Boolean);
begin
  if FChecked = Value then
    Exit;
  FChecked := Value;
  if FAnimated and HandleAllocated then
    StartAnimation
  else
  begin
    FAnimProgress := Ord(FChecked);
    FAnimTarget := FAnimProgress;
  end;
  if Assigned(FOnChange) then
    FOnChange(Self);
  Invalidate;
end;

procedure TFluentToggleSwitch.StartAnimation;
begin
  FAnimStartProgress := FAnimProgress;
  FAnimTarget := Ord(FChecked);
  QueryPerformanceCounter(FAnimStartTime);
  FAnimTimer.Enabled := True;
end;

procedure TFluentToggleSwitch.HandleAnimTimer(Sender: TObject);
var
  Counter: Int64;
  Elapsed: Single;
  T: Single;
begin
  QueryPerformanceCounter(Counter);
  Elapsed := (Counter - FAnimStartTime) / FAnimFrequency * 1000;
  T := Elapsed / FAnimationDuration;
  if T >= 1.0 then
  begin
    T := 1.0;
    FAnimTimer.Enabled := False;
  end;
  T := EaseOutCubic(T);
  FAnimProgress := FAnimStartProgress + (FAnimTarget - FAnimStartProgress) * T;
  Invalidate;
end;

procedure TFluentToggleSwitch.SetAnimationDuration(Value: Integer);
begin
  if Value < 1 then
    Value := 1;
  FAnimationDuration := Value;
end;

procedure TFluentToggleSwitch.Toggle;
begin
  Checked := not FChecked;
end;

procedure TFluentToggleSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressed := True;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and FPressed then
  begin
    FPressed := False;
    if PtInRect(ClientRect, Point(X, Y)) then
      Toggle;
    Invalidate;
  end;
  inherited;
end;

procedure TFluentToggleSwitch.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  IsOver: Boolean;
begin
  inherited;
  IsOver := PtInRect(ClientRect, Point(X, Y));
  if IsOver <> FHovered then
  begin
    FHovered := IsOver;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FHovered := True;
  Invalidate;
end;

procedure TFluentToggleSwitch.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FHovered := False;
  FPressed := False;
  Invalidate;
end;

procedure TFluentToggleSwitch.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TFluentToggleSwitch.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TFluentToggleSwitch.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_SPACE) or (Key = VK_RETURN) then
    Toggle;
end;

function TFluentToggleSwitch.GetInteractionState: TInteractionState;
begin
  if not Enabled then
    Result := isDisabled
  else if FPressed then
    Result := isPressed
  else if FHovered then
    Result := isHover
  else
    Result := isNormal;
end;

procedure TFluentToggleSwitch.Paint;
var
  G: TGPGraphics;
  Path: TGPGraphicsPath;
  Brush: TGPSolidBrush;
  Pen: TGPPen;
  BgColor: TColor;
  TrackX, TrackY: Single;
  State: TInteractionState;
  OffFill, OnFill, FillColor: TColor;
  StrokeColor, ThumbColor: TColor;
  ThumbCX, ThumbCY: Single;
  ThumbD: Single;
begin
  // Background
  BgColor := Self.Color;
  if BgColor = clNone then
    BgColor := clBtnFace;
  Canvas.Brush.Color := BgColor;
  Canvas.FillRect(ClientRect);

  // Track position — centered in component
  TrackX := (Width - TrackWidth) / 2;
  TrackY := (Height - TrackHeight) / 2;

  State := GetInteractionState;

  // Interpolate colors based on FAnimProgress (0=Off, 1=On)
  OffFill := OffTrackFill[State];
  if OffFill = clNone then
    OffFill := BgColor;
  OnFill := OnTrackFill[State];
  FillColor := LerpColor(OffFill, OnFill, FAnimProgress);
  StrokeColor := LerpColor(OffTrackStroke[State], OnTrackStroke[State], FAnimProgress);
  ThumbColor := LerpColor(OffThumbFill[State], OnThumbFill[State], FAnimProgress);

  // Thumb geometry — position interpolated
  ThumbD := ThumbDiameters[State];
  ThumbCY := TrackY + TrackHeight / 2;
  ThumbCX := TrackX + ThumbCenterOffX
    + (ThumbCenterOnX - ThumbCenterOffX) * FAnimProgress;

  G := TGPGraphics.Create(Canvas.Handle);
  try
    G.SetSmoothingMode(SmoothingModeAntiAlias);

    // Draw track
    Path := TGPGraphicsPath.Create;
    try
      AddPillPath(Path, TrackX, TrackY, TrackWidth, TrackHeight);

      // Track fill
      Brush := TGPSolidBrush.Create(TColorToARGB(FillColor));
      try
        G.FillPath(Brush, Path);
      finally
        Brush.Free;
      end;

      // Track stroke
      Pen := TGPPen.Create(TColorToARGB(StrokeColor), 1.0);
      try
        Pen.SetAlignment(PenAlignmentInset);
        G.DrawPath(Pen, Path);
      finally
        Pen.Free;
      end;
    finally
      Path.Free;
    end;

    // Draw thumb
    Brush := TGPSolidBrush.Create(TColorToARGB(ThumbColor));
    try
      G.FillEllipse(Brush,
        ThumbCX - ThumbD / 2, ThumbCY - ThumbD / 2, ThumbD, ThumbD);
    finally
      Brush.Free;
    end;
  finally
    G.Free;
  end;

  // Focus rectangle
  if Focused then
    Canvas.DrawFocusRect(ClientRect);
end;

procedure Register;
begin
  RegisterComponents('ToggleSwitch', [TFluentToggleSwitch]);
end;

end.

unit ToggleSwitch;

interface

uses
  System.Classes,
  System.Math,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.Graphics,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ;

type
  TTextPosition = (tpLeft, tpRight);

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
    FTrackFrameColor: TColor;
    FTrackColorOff: TColor;
    FTrackColorOn: TColor;
    FThumbColorOff: TColor;
    FThumbColorOn: TColor;
    FTextOn: string;
    FTextOff: string;
    FShowText: Boolean;
    FTextPosition: TTextPosition;
    FTextSpacing: Integer;
    FTrackOffsetX: Integer;
    FScaledTrackAreaWidth: Integer;
    FScaledTrackAreaHeight: Integer;
    FScaledTrackWidth: Integer;
    FScaledTrackHeight: Integer;
    FScaledTrackRadius: Integer;
    FScaledThumbCenterOffX: Integer;
    FScaledThumbCenterOnX: Integer;
    FScaledThumbDiameters: array[TInteractionState] of Integer;
    procedure SetChecked(Value: Boolean);
    procedure SetAnimationDuration(Value: Integer);
    procedure StartAnimation;
    procedure HandleAnimTimer(Sender: TObject);
    function GetInteractionState: TInteractionState;
    procedure Toggle;
    procedure SetTrackFrameColor(Value: TColor);
    procedure SetTrackColorOff(Value: TColor);
    procedure SetTrackColorOn(Value: TColor);
    procedure SetThumbColorOff(Value: TColor);
    procedure SetThumbColorOn(Value: TColor);
    procedure SetTextOn(const Value: string);
    procedure SetTextOff(const Value: string);
    procedure SetShowText(Value: Boolean);
    procedure SetTextPosition(Value: TTextPosition);
    procedure SetTextSpacing(Value: Integer);
    procedure AdjustBounds;
    function GetTrackRect: TRect;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure Paint; override;
    procedure ChangeScale(M, D: Integer; isDpiChange: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CreateWnd; override;
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
    property TrackFrameColor: TColor read FTrackFrameColor write SetTrackFrameColor default clNone;
    property TrackColorOff: TColor read FTrackColorOff write SetTrackColorOff default clNone;
    property TrackColorOn: TColor read FTrackColorOn write SetTrackColorOn default clNone;
    property ThumbColorOff: TColor read FThumbColorOff write SetThumbColorOff default clNone;
    property ThumbColorOn: TColor read FThumbColorOn write SetThumbColorOn default clNone;
    property Font;
    property ShowText: Boolean read FShowText write SetShowText default False;
    property TextOn: string read FTextOn write SetTextOn;
    property TextOff: string read FTextOff write SetTextOff;
    property TextPosition: TTextPosition read FTextPosition write SetTextPosition default tpRight;
    property TextSpacing: Integer read FTextSpacing write SetTextSpacing default 8;
  end;

procedure Register;

implementation

const
  TrackAreaWidth  = 44;
  TrackAreaHeight = 24;
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
  FScaledTrackAreaWidth := TrackAreaWidth;
  FScaledTrackAreaHeight := TrackAreaHeight;
  FScaledTrackWidth := TrackWidth;
  FScaledTrackHeight := TrackHeight;
  FScaledTrackRadius := TrackRadius;
  FScaledThumbCenterOffX := ThumbCenterOffX;
  FScaledThumbCenterOnX := ThumbCenterOnX;
  for var S := Low(TInteractionState) to High(TInteractionState) do
    FScaledThumbDiameters[S] := ThumbDiameters[S];
  Width := FScaledTrackAreaWidth;
  Height := FScaledTrackAreaHeight;
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
  FTrackFrameColor := clNone;
  FTrackColorOff := clNone;
  FTrackColorOn := clNone;
  FThumbColorOff := clNone;
  FThumbColorOn := clNone;
  FTextOn := 'On';
  FTextOff := 'Off';
  FShowText := False;
  FTextPosition := tpRight;
  FTextSpacing := 8;
  FTrackOffsetX := 0;
end;

procedure TFluentToggleSwitch.SetTrackFrameColor(Value: TColor);
begin
  if FTrackFrameColor <> Value then
  begin
    FTrackFrameColor := Value;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTrackColorOff(Value: TColor);
begin
  if FTrackColorOff <> Value then
  begin
    FTrackColorOff := Value;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTrackColorOn(Value: TColor);
begin
  if FTrackColorOn <> Value then
  begin
    FTrackColorOn := Value;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetThumbColorOff(Value: TColor);
begin
  if FThumbColorOff <> Value then
  begin
    FThumbColorOff := Value;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetThumbColorOn(Value: TColor);
begin
  if FThumbColorOn <> Value then
  begin
    FThumbColorOn := Value;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTextOn(const Value: string);
begin
  if FTextOn <> Value then
  begin
    FTextOn := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTextOff(const Value: string);
begin
  if FTextOff <> Value then
  begin
    FTextOff := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetShowText(Value: Boolean);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTextPosition(Value: TTextPosition);
begin
  if FTextPosition <> Value then
  begin
    FTextPosition := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.SetTextSpacing(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FTextSpacing <> Value then
  begin
    FTextSpacing := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.AdjustBounds;
var
  TextW, TextH: Integer;
  NewWidth, NewHeight: Integer;
begin
  if not FShowText then
  begin
    FTrackOffsetX := 0;
    NewWidth := FScaledTrackAreaWidth;
    NewHeight := FScaledTrackAreaHeight;
  end
  else
  begin
    if not HandleAllocated then
      Exit;
    Canvas.Font.Assign(Font);
    TextW := Max(Canvas.TextWidth(FTextOn), Canvas.TextWidth(FTextOff));
    TextH := Canvas.TextHeight('Wg');
    NewWidth := FScaledTrackAreaWidth + FTextSpacing + TextW;
    NewHeight := Max(FScaledTrackAreaHeight, TextH);
    if FTextPosition = tpLeft then
      FTrackOffsetX := TextW + FTextSpacing
    else
      FTrackOffsetX := 0;
  end;
  SetBounds(Left, Top, NewWidth, NewHeight);
end;

function TFluentToggleSwitch.GetTrackRect: TRect;
begin
  Result := Rect(FTrackOffsetX, 0, FTrackOffsetX + FScaledTrackAreaWidth, Height);
end;

procedure TFluentToggleSwitch.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  AdjustBounds;
  Invalidate;
end;

procedure TFluentToggleSwitch.ChangeScale(M, D: Integer; isDpiChange: Boolean);
begin
  inherited;
  FScaledTrackAreaWidth := MulDiv(FScaledTrackAreaWidth, M, D);
  FScaledTrackAreaHeight := MulDiv(FScaledTrackAreaHeight, M, D);
  FScaledTrackWidth := MulDiv(FScaledTrackWidth, M, D);
  FScaledTrackHeight := MulDiv(FScaledTrackHeight, M, D);
  FScaledTrackRadius := MulDiv(FScaledTrackRadius, M, D);
  FScaledThumbCenterOffX := MulDiv(FScaledThumbCenterOffX, M, D);
  FScaledThumbCenterOnX := MulDiv(FScaledThumbCenterOnX, M, D);
  for var S := Low(TInteractionState) to High(TInteractionState) do
    FScaledThumbDiameters[S] := MulDiv(FScaledThumbDiameters[S], M, D);
  AdjustBounds;
end;

procedure TFluentToggleSwitch.CreateWnd;
begin
  inherited;
  AdjustBounds;
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
  begin
    Toggle;
    inherited Click;
  end;
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
  OffThumb, OnThumb: TColor;
  ThumbCX, ThumbCY: Single;
  ThumbD: Single;
  TextX, TextY: Integer;
  TextW, TextH: Integer;
  LabelText: string;
begin
  // Background
  BgColor := Self.Color;
  if BgColor = clNone then
    BgColor := clBtnFace;
  Canvas.Brush.Color := BgColor;
  Canvas.FillRect(ClientRect);

  // Text layout
  if FShowText then
  begin
    Canvas.Font.Assign(Font);
    TextW := Max(Canvas.TextWidth(FTextOn), Canvas.TextWidth(FTextOff));
    TextH := Canvas.TextHeight('Wg');

    if FTextPosition = tpLeft then
      TextX := 0
    else
      TextX := FScaledTrackAreaWidth + FTextSpacing;

    TextY := (Height - TextH) div 2;
  end;

  // Track position
  TrackX := FTrackOffsetX + (FScaledTrackAreaWidth - FScaledTrackWidth) / 2;
  TrackY := (Height - FScaledTrackHeight) / 2;

  State := GetInteractionState;

  // Track fill — Off
  if FTrackColorOff <> clNone then
    OffFill := FTrackColorOff
  else
  begin
    OffFill := OffTrackFill[State];
    if OffFill = clNone then
      OffFill := BgColor;
  end;

  // Track fill — On
  if FTrackColorOn <> clNone then
    OnFill := FTrackColorOn
  else
    OnFill := OnTrackFill[State];

  FillColor := LerpColor(OffFill, OnFill, FAnimProgress);

  // Track stroke (frame)
  if FTrackFrameColor <> clNone then
    StrokeColor := FTrackFrameColor
  else
    StrokeColor := LerpColor(OffTrackStroke[State], OnTrackStroke[State], FAnimProgress);

  // Thumb
  if FThumbColorOff <> clNone then
    OffThumb := FThumbColorOff
  else
    OffThumb := OffThumbFill[State];

  if FThumbColorOn <> clNone then
    OnThumb := FThumbColorOn
  else
    OnThumb := OnThumbFill[State];

  ThumbColor := LerpColor(OffThumb, OnThumb, FAnimProgress);

  // Thumb geometry — position interpolated
  ThumbD := FScaledThumbDiameters[State];
  ThumbCY := TrackY + FScaledTrackHeight / 2;
  ThumbCX := TrackX + FScaledThumbCenterOffX
    + (FScaledThumbCenterOnX - FScaledThumbCenterOffX) * FAnimProgress;

  G := TGPGraphics.Create(Canvas.Handle);
  try
    G.SetSmoothingMode(SmoothingModeAntiAlias);

    // Draw track
    Path := TGPGraphicsPath.Create;
    try
      AddPillPath(Path, TrackX, TrackY, FScaledTrackWidth, FScaledTrackHeight);

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

  // Text label
  if FShowText then
  begin
    if FChecked then
      LabelText := FTextOn
    else
      LabelText := FTextOff;

    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    if not Enabled then
      Canvas.Font.Color := clGrayText;
    Canvas.TextOut(TextX, TextY, LabelText);
  end;
end;

procedure Register;
begin
  RegisterComponents('ToggleSwitch', [TFluentToggleSwitch]);
end;

end.

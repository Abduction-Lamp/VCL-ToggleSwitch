unit ToggleSwitch;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Graphics,
  Winapi.Windows,
  Winapi.Messages,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ;

type
  TInteractionState = (isNormal, isHover, isPressed, isDisabled);

  TToggleSwitch = class(TCustomControl)
  private
    FChecked: Boolean;
    FAnimated: Boolean;
    FAnimationDuration: Integer;
    FHovered: Boolean;
    FPressed: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetChecked(Value: Boolean);
    procedure SetAnimationDuration(Value: Integer);
    function GetInteractionState: TInteractionState;
    function GetTrackFillColor: TColor;
    function GetTrackStrokeColor: TColor;
    function GetThumbFillColor: TColor;
    function GetThumbDiameter: Integer;
    procedure Toggle;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
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

{ TToggleSwitch }

constructor TToggleSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  Width := 44;
  Height := 24;
  FChecked := False;
  FAnimated := True;
  FAnimationDuration := 150;
  TabStop := True;
  DoubleBuffered := True;
end;

procedure TToggleSwitch.SetChecked(Value: Boolean);
begin
  if FChecked = Value then
    Exit;
  FChecked := Value;
  Invalidate;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TToggleSwitch.SetAnimationDuration(Value: Integer);
begin
  if Value < 1 then
    Value := 1;
  FAnimationDuration := Value;
end;

procedure TToggleSwitch.Toggle;
begin
  Checked := not FChecked;
end;

procedure TToggleSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    FPressed := True;
    Invalidate;
  end;
end;

procedure TToggleSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

procedure TToggleSwitch.MouseMove(Shift: TShiftState; X, Y: Integer);
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

procedure TToggleSwitch.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FHovered := True;
  Invalidate;
end;

procedure TToggleSwitch.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FHovered := False;
  FPressed := False;
  Invalidate;
end;

function TToggleSwitch.GetInteractionState: TInteractionState;
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

function TToggleSwitch.GetTrackFillColor: TColor;
var
  State: TInteractionState;
begin
  State := GetInteractionState;
  if FChecked then
    Result := OnTrackFill[State]
  else
    Result := OffTrackFill[State];
end;

function TToggleSwitch.GetTrackStrokeColor: TColor;
var
  State: TInteractionState;
begin
  State := GetInteractionState;
  if FChecked then
    Result := OnTrackStroke[State]
  else
    Result := OffTrackStroke[State];
end;

function TToggleSwitch.GetThumbFillColor: TColor;
var
  State: TInteractionState;
begin
  State := GetInteractionState;
  if FChecked then
    Result := OnThumbFill[State]
  else
    Result := OffThumbFill[State];
end;

function TToggleSwitch.GetThumbDiameter: Integer;
begin
  Result := ThumbDiameters[GetInteractionState];
end;

procedure TToggleSwitch.Paint;
var
  G: TGPGraphics;
  Path: TGPGraphicsPath;
  Brush: TGPSolidBrush;
  Pen: TGPPen;
  BgColor: TColor;
  TrackX, TrackY: Single;
  FillColor, StrokeColor, ThumbColor: TColor;
  ThumbCX, ThumbCY: Single;
  ThumbD: Integer;
  ThumbR: Single;
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

  // Colors
  FillColor := GetTrackFillColor;
  StrokeColor := GetTrackStrokeColor;
  ThumbColor := GetThumbFillColor;

  // Thumb geometry
  ThumbD := GetThumbDiameter;
  ThumbR := ThumbD / 2;
  ThumbCY := TrackY + TrackHeight / 2;
  if FChecked then
    ThumbCX := TrackX + ThumbCenterOnX
  else
    ThumbCX := TrackX + ThumbCenterOffX;

  G := TGPGraphics.Create(Canvas.Handle);
  try
    G.SetSmoothingMode(SmoothingModeAntiAlias);

    // Draw track
    Path := TGPGraphicsPath.Create;
    try
      AddPillPath(Path, TrackX, TrackY, TrackWidth, TrackHeight);

      // Track fill
      if FillColor <> clNone then
      begin
        Brush := TGPSolidBrush.Create(TColorToARGB(FillColor));
        try
          G.FillPath(Brush, Path);
        finally
          Brush.Free;
        end;
      end;

      // Track stroke (Off state only — On state is filled entirely)
      if not FChecked then
      begin
        Pen := TGPPen.Create(TColorToARGB(StrokeColor), 1.0);
        try
          Pen.SetAlignment(PenAlignmentInset);
          G.DrawPath(Pen, Path);
        finally
          Pen.Free;
        end;
      end;
    finally
      Path.Free;
    end;

    // Draw thumb
    Brush := TGPSolidBrush.Create(TColorToARGB(ThumbColor));
    try
      G.FillEllipse(Brush,
        ThumbCX - ThumbR, ThumbCY - ThumbR, ThumbD, ThumbD);
    finally
      Brush.Free;
    end;
  finally
    G.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('ToggleSwitch', [TToggleSwitch]);
end;

end.

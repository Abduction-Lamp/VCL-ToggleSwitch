unit ToggleSwitch;

interface

uses
  System.Classes,
  System.Math,
  System.Types,
  System.UITypes,
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
    FScalePPI: Integer;
    FScaledTrackAreaWidth: Integer;
    FScaledTrackAreaHeight: Integer;
    FScaledTrackWidth: Integer;
    FScaledTrackHeight: Integer;
    FScaledThumbWidths: array[TInteractionState] of Integer;
    FScaledThumbHeights: array[TInteractionState] of Integer;
    FScaledThumbCenterOffX: array[TInteractionState] of Single;
    FScaledThumbCenterOnX: array[TInteractionState] of Single;
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
    procedure Rescale;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    procedure ChangeScale(M, D: Integer; isDpiChange: Boolean); override;
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
    property ParentColor;
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
  // Thumb geometry per interaction state. When pressed the thumb becomes a
  // 17x14 pill hugging the track edge, so its center shifts inward.
  //                                                      Normal  Hover  Pressed  Disabled
  ThumbWidths:  array[TInteractionState] of Integer =   (12,     14,    17,      12);
  ThumbHeights: array[TInteractionState] of Integer =   (12,     14,    14,      12);
  // Thumb center from the left edge of the track
  ThumbCenterOffX: array[TInteractionState] of Single = (9.5,    9.5,   11.5,    9.5);
  ThumbCenterOnX:  array[TInteractionState] of Single = (29.5,   29.5,  28.5,    29.5);

  // Colors are ARGB ($AARRGGBB) from the WinUI 3 Light theme. Off-state colors
  // are translucent black blended over the parent background; the On track has
  // no stroke of its own.
  //                                                    Normal     Hover      Pressed    Disabled
  OffTrackFill:   array[TInteractionState] of ARGB = ($06000000, $0F000000, $18000000, $00000000);
  OffTrackStroke: array[TInteractionState] of ARGB = ($72000000, $72000000, $72000000, $37000000);
  OffThumbFill:   array[TInteractionState] of ARGB = ($9E000000, $9E000000, $9E000000, $5C000000);
  // On state: AccentColor #0078D4 / AccentDark1 #006CBE / AccentDark2 #005A9E
  OnTrackFill:    array[TInteractionState] of ARGB = ($FF0078D4, $FF006CBE, $FF005A9E, $37000000);
  OnThumbFill:    array[TInteractionState] of ARGB = ($FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF);

function EaseOutCubic(T: Single): Single;
var
  U: Single;
begin
  U := 1.0 - T;
  Result := 1.0 - U * U * U;
end;

function ScaleAlpha(C: ARGB; Opacity: Single): ARGB;
begin
  Result := MakeColor(Round(GetAlpha(C) * Opacity), GetRed(C), GetGreen(C), GetBlue(C));
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
  ParentColor := True;
  FScalePPI := USER_DEFAULT_SCREEN_DPI;
  Rescale;
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
  DC: HDC;
  SaveFont: HFONT;
  TM: TTextMetric;
  SizeOn, SizeOff: TSize;
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
    DC := GetDC(0);
    try
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextExtentPoint32(DC, PChar(FTextOn), Length(FTextOn), SizeOn);
      GetTextExtentPoint32(DC, PChar(FTextOff), Length(FTextOff), SizeOff);
      GetTextMetrics(DC, TM);
      SelectObject(DC, SaveFont);
    finally
      ReleaseDC(0, DC);
    end;
    TextW := Max(SizeOn.cx, SizeOff.cx);
    TextH := TM.tmHeight;
    NewWidth := FScaledTrackAreaWidth + FTextSpacing + TextW;
    NewHeight := Max(FScaledTrackAreaHeight, TextH);
    if FTextPosition = tpLeft then
      FTrackOffsetX := TextW + FTextSpacing
    else
      FTrackOffsetX := 0;
  end;
  SetBounds(Left, Top, NewWidth, NewHeight);
end;

procedure TFluentToggleSwitch.Rescale;
begin
  FScaledTrackAreaWidth := MulDiv(TrackAreaWidth, FScalePPI, USER_DEFAULT_SCREEN_DPI);
  FScaledTrackAreaHeight := MulDiv(TrackAreaHeight, FScalePPI, USER_DEFAULT_SCREEN_DPI);
  FScaledTrackWidth := MulDiv(TrackWidth, FScalePPI, USER_DEFAULT_SCREEN_DPI);
  FScaledTrackHeight := MulDiv(TrackHeight, FScalePPI, USER_DEFAULT_SCREEN_DPI);
  for var S := Low(TInteractionState) to High(TInteractionState) do
  begin
    FScaledThumbWidths[S] := MulDiv(ThumbWidths[S], FScalePPI, USER_DEFAULT_SCREEN_DPI);
    FScaledThumbHeights[S] := MulDiv(ThumbHeights[S], FScalePPI, USER_DEFAULT_SCREEN_DPI);
    FScaledThumbCenterOffX[S] := ThumbCenterOffX[S] * FScalePPI / USER_DEFAULT_SCREEN_DPI;
    FScaledThumbCenterOnX[S] := ThumbCenterOnX[S] * FScalePPI / USER_DEFAULT_SCREEN_DPI;
  end;
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
  FScalePPI := MulDiv(FScalePPI, M, D);
  Rescale;
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
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TFluentToggleSwitch.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    if CanFocus then
      SetFocus;
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
  TrackX, TrackY: Single;
  State: TInteractionState;
  OffFill, OffStroke, OnFill: ARGB;
  OffThumb, OnThumb: ARGB;
  OffOpacity: Single;
  StrokeWidth: Single;
  ThumbCX, ThumbCY: Single;
  ThumbW, ThumbH: Single;
  TextX, TextY: Integer;
  TextH: Integer;
  LabelText: string;

  procedure FillShape(Color: ARGB);
  var
    Brush: TGPSolidBrush;
  begin
    Brush := TGPSolidBrush.Create(Color);
    try
      G.FillPath(Brush, Path);
    finally
      Brush.Free;
    end;
  end;

  procedure StrokeShape(Color: ARGB);
  var
    Pen: TGPPen;
  begin
    Pen := TGPPen.Create(Color, StrokeWidth);
    try
      G.DrawPath(Pen, Path);
    finally
      Pen.Free;
    end;
  end;

begin
  TextX := 0;
  TextY := 0;

  // Background
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);

  // Text layout
  if FShowText then
  begin
    Canvas.Font.Assign(Font);
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
  OffOpacity := 1 - FAnimProgress;
  // Stroke is centered on the outline and scaled with DPI, as in WinUI
  StrokeWidth := FScalePPI / USER_DEFAULT_SCREEN_DPI;

  // Track colors; user colors override the theme
  if FTrackColorOff <> clNone then
    OffFill := TColorToARGB(FTrackColorOff)
  else
    OffFill := OffTrackFill[State];

  if FTrackFrameColor <> clNone then
    OffStroke := TColorToARGB(FTrackFrameColor)
  else
    OffStroke := OffTrackStroke[State];

  if FTrackColorOn <> clNone then
    OnFill := TColorToARGB(FTrackColorOn)
  else
    OnFill := OnTrackFill[State];

  // Thumb colors
  if FThumbColorOff <> clNone then
    OffThumb := TColorToARGB(FThumbColorOff)
  else
    OffThumb := OffThumbFill[State];

  if FThumbColorOn <> clNone then
    OnThumb := TColorToARGB(FThumbColorOn)
  else
    OnThumb := OnThumbFill[State];

  // Thumb geometry; position interpolated
  ThumbW := FScaledThumbWidths[State];
  ThumbH := FScaledThumbHeights[State];
  ThumbCY := TrackY + FScaledTrackHeight / 2;
  ThumbCX := TrackX + FScaledThumbCenterOffX[State]
    + (FScaledThumbCenterOnX[State] - FScaledThumbCenterOffX[State]) * FAnimProgress;

  G := TGPGraphics.Create(Canvas.Handle);
  try
    G.SetSmoothingMode(SmoothingModeAntiAlias);

    Path := TGPGraphicsPath.Create;
    try
      // Off and On tracks cross-fade, as in WinUI
      AddPillPath(Path, TrackX, TrackY, FScaledTrackWidth, FScaledTrackHeight);
      if OffOpacity > 0 then
      begin
        FillShape(ScaleAlpha(OffFill, OffOpacity));
        StrokeShape(ScaleAlpha(OffStroke, OffOpacity));
      end;
      if FAnimProgress > 0 then
      begin
        FillShape(ScaleAlpha(OnFill, FAnimProgress));
        if FTrackFrameColor <> clNone then
          StrokeShape(ScaleAlpha(TColorToARGB(FTrackFrameColor), FAnimProgress));
      end;

      // Thumb cross-fades the same way
      Path.Reset;
      AddPillPath(Path, ThumbCX - ThumbW / 2, ThumbCY - ThumbH / 2, ThumbW, ThumbH);
      if OffOpacity > 0 then
        FillShape(ScaleAlpha(OffThumb, OffOpacity));
      if FAnimProgress > 0 then
        FillShape(ScaleAlpha(OnThumb, FAnimProgress));
    finally
      Path.Free;
    end;
  finally
    G.Free;
  end;

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

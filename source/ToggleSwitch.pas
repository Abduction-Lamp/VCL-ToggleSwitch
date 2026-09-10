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

  // Everything an interaction state contributes to the drawing. Kept as values
  // so a state change can animate from whatever is currently on screen.
  TVisualState = record
    ThumbW, ThumbH: Single;
    ThumbOffX, ThumbOnX: Single;
    TrackOff, StrokeOff, TrackOn: ARGB;
    ThumbOff, ThumbOn: ARGB;
  end;

  TFluentToggleSwitch = class(TCustomControl)
  private
    FChecked: Boolean;
    FAnimated: Boolean;
    FAnimationDuration: Integer;
    FHovered: Boolean;
    FPressed: Boolean;
    FDragStartX: Integer;
    FDragDelta: Single;
    FDragged: Boolean;
    FAnimTimer: TTimer;
    FAnimProgress: Single;
    FAnimStartProgress: Single;
    FAnimTarget: Single;
    FAnimStartTime: Int64;
    FAnimFrequency: Int64;
    FSliding: Boolean;
    FState: TInteractionState;
    FStateFrom: TVisualState;
    FStateT: Single;
    FStateStartTime: Int64;
    FStateDuration: Integer;
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
    FTextHeight: Integer;
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
    procedure StartTimer;
    procedure StartAnimation;
    procedure SettleThumb;
    procedure HandleAnimTimer(Sender: TObject);
    function DragTravel: Single;
    procedure DragThumb(X: Integer);
    function GetInteractionState: TInteractionState;
    function TextGap: Integer;
    function StateVisual(S: TInteractionState): TVisualState;
    function CurrentVisual: TVisualState;
    procedure UpdateVisualState;
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
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
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
    property AnimationDuration: Integer read FAnimationDuration write SetAnimationDuration default 367;
    property Enabled;
    property TabStop default False;
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
    property TextSpacing: Integer read FTextSpacing write SetTextSpacing default 12;
  end;

procedure Register;

implementation

const
  TrackAreaWidth  = 44;
  TrackAreaHeight = 24;
  TrackWidth  = 40;
  TrackHeight = 20;
  DragThreshold = 4;  // pointer travel that turns a press into a drag
  // Animation timings from the WinUI template. The thumb waits out the delay,
  // then slides for AnimationDuration; interaction states cross-fade faster.
  ThumbSlideDelay = 33;
  StateDuration = 83;          // ControlFasterAnimationDuration
  DisabledStateDuration = 250; // ControlNormalAnimationDuration
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
  OnThumbFill:    array[TInteractionState] of ARGB = ($FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF);
  // Windows 11 default accent shade, used when the system palette is unreadable
  DefaultAccentDark1 = $FF0067C0;

var
  // On-state track fill: the accent shade at the opacity of each state. Hover
  // and Pressed are the same color at 0.9 and 0.8, so the track lightens toward
  // the background instead of darkening.
  OnTrackFill: array[TInteractionState] of ARGB;

// Cubic Bezier from (0,0) to (1,1) with the two control points on one axis
function BezierAxis(T, C1, C2: Single): Single; inline;
var
  U: Single;
begin
  U := 1.0 - T;
  Result := 3.0 * U * U * T * C1 + 3.0 * U * T * T * C2 + T * T * T;
end;

// Value of the curve at time X, the easing XAML expresses as a KeySpline
function BezierEase(X, X1, Y1, X2, Y2: Single): Single;
var
  Lo, Hi, T: Single;
  I: Integer;
begin
  if X <= 0 then
    Exit(0);
  if X >= 1 then
    Exit(1);
  Lo := 0;
  Hi := 1;
  for I := 1 to 12 do
  begin
    T := (Lo + Hi) / 2;
    if BezierAxis(T, X1, X2) < X then
      Lo := T
    else
      Hi := T;
  end;
  Result := BezierAxis((Lo + Hi) / 2, Y1, Y2);
end;

function LerpARGB(A, B: ARGB; T: Single): ARGB;
begin
  Result := MakeColor(
    Round(GetAlpha(A) + (GetAlpha(B) - GetAlpha(A)) * T),
    Round(GetRed(A) + (GetRed(B) - GetRed(A)) * T),
    Round(GetGreen(A) + (GetGreen(B) - GetGreen(A)) * T),
    Round(GetBlue(A) + (GetBlue(B) - GetBlue(A)) * T));
end;

function LerpVisual(const A, B: TVisualState; T: Single): TVisualState;
begin
  Result.ThumbW := A.ThumbW + (B.ThumbW - A.ThumbW) * T;
  Result.ThumbH := A.ThumbH + (B.ThumbH - A.ThumbH) * T;
  Result.ThumbOffX := A.ThumbOffX + (B.ThumbOffX - A.ThumbOffX) * T;
  Result.ThumbOnX := A.ThumbOnX + (B.ThumbOnX - A.ThumbOnX) * T;
  Result.TrackOff := LerpARGB(A.TrackOff, B.TrackOff, T);
  Result.StrokeOff := LerpARGB(A.StrokeOff, B.StrokeOff, T);
  Result.TrackOn := LerpARGB(A.TrackOn, B.TrackOn, T);
  Result.ThumbOff := LerpARGB(A.ThumbOff, B.ThumbOff, T);
  Result.ThumbOn := LerpARGB(A.ThumbOn, B.ThumbOn, T);
end;

function ScaleAlpha(C: ARGB; Opacity: Single): ARGB;
begin
  Result := MakeColor(Round(GetAlpha(C) * Opacity), GetRed(C), GetGreen(C), GetBlue(C));
end;

// SystemAccentColorDark1, the shade WinUI paints the On track with in the light
// theme. Windows stores the shades as eight RGBA entries; Dark1 is the fifth.
function SystemAccentDark1: ARGB;
const
  AccentKey = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Accent';
  Dark1 = 16;
var
  Key: HKEY;
  Palette: array[0..31] of Byte;
  Size, ValueType: DWORD;
begin
  Result := DefaultAccentDark1;
  if RegOpenKeyEx(HKEY_CURRENT_USER, AccentKey, 0, KEY_READ, Key) <> ERROR_SUCCESS then
    Exit;
  try
    Size := SizeOf(Palette);
    if (RegQueryValueEx(Key, 'AccentPalette', nil, @ValueType, @Palette[0], @Size) = ERROR_SUCCESS)
      and (ValueType = REG_BINARY) and (Size >= Dark1 + 3) then
      Result := MakeColor(255, Palette[Dark1], Palette[Dark1 + 1], Palette[Dark1 + 2]);
  finally
    RegCloseKey(Key);
  end;
end;

procedure InitAccentColors;
var
  Accent: ARGB;
begin
  Accent := SystemAccentDark1;
  OnTrackFill[isNormal] := Accent;
  OnTrackFill[isHover] := ScaleAlpha(Accent, 0.9);
  OnTrackFill[isPressed] := ScaleAlpha(Accent, 0.8);
  OnTrackFill[isDisabled] := $37000000;
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
  FAnimationDuration := 367;
  FAnimProgress := 0.0;
  FAnimTarget := 0.0;
  FState := isNormal;
  FStateT := 1.0;
  FStateDuration := StateDuration;
  QueryPerformanceFrequency(FAnimFrequency);
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
  FTextSpacing := 12;
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

// Distance from the edge of the track area to the text. TextSpacing is measured
// from the track outline, and the area is wider than the track by the room the
// stroke needs on each side.
function TFluentToggleSwitch.TextGap: Integer;
begin
  Result := MulDiv(FTextSpacing, FScalePPI, USER_DEFAULT_SCREEN_DPI)
    - (FScaledTrackAreaWidth - FScaledTrackWidth) div 2;
  if Result < 0 then
    Result := 0;
end;

procedure TFluentToggleSwitch.AdjustBounds;
var
  DC: HDC;
  SaveFont: HFONT;
  TM: TTextMetric;
  SizeOn, SizeOff: TSize;
  TextW: Integer;
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
    FTextHeight := TM.tmHeight;
    NewWidth := FScaledTrackAreaWidth + TextGap + TextW;
    NewHeight := Max(FScaledTrackAreaHeight, FTextHeight);
    if FTextPosition = tpLeft then
      FTrackOffsetX := TextW + TextGap
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
  // A snapshot taken at the old scale would be wrong now
  FStateT := 1.0;
end;

procedure TFluentToggleSwitch.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  AdjustBounds;
  Invalidate;
end;

procedure TFluentToggleSwitch.ChangeScale(M, D: Integer; isDpiChange: Boolean);
begin
  // Rescale first: inherited changes the font, and the CM_FONTCHANGED handler
  // it triggers measures the layout at the current scale
  FScalePPI := MulDiv(FScalePPI, M, D);
  Rescale;
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
  SettleThumb;
  Invalidate;
end;

// The timer, and the hidden window it owns, exist only once something animates
procedure TFluentToggleSwitch.StartTimer;
begin
  if FAnimTimer = nil then
  begin
    FAnimTimer := TTimer.Create(Self);
    FAnimTimer.Interval := 16;
    FAnimTimer.OnTimer := HandleAnimTimer;
  end;
  FAnimTimer.Enabled := True;
end;

procedure TFluentToggleSwitch.StartAnimation;
begin
  FAnimStartProgress := FAnimProgress;
  FAnimTarget := Ord(FChecked);
  FSliding := True;
  QueryPerformanceCounter(FAnimStartTime);
  StartTimer;
end;

// Moves the thumb from wherever it is to the rest position of the current state
procedure TFluentToggleSwitch.SettleThumb;
begin
  if FAnimated and HandleAllocated and Showing then
    StartAnimation
  else
  begin
    FSliding := False;
    FAnimProgress := Ord(FChecked);
    FAnimTarget := FAnimProgress;
  end;
end;

procedure TFluentToggleSwitch.HandleAnimTimer(Sender: TObject);
var
  Counter: Int64;
  T: Single;
  Busy: Boolean;
begin
  QueryPerformanceCounter(Counter);
  Busy := False;

  if FSliding then
  begin
    T := ((Counter - FAnimStartTime) / FAnimFrequency * 1000 - ThumbSlideDelay)
      / FAnimationDuration;
    if T >= 1.0 then
    begin
      T := 1.0;
      FSliding := False;
    end
    else
    begin
      Busy := True;
      if T < 0 then
        T := 0;
    end;
    FAnimProgress := FAnimStartProgress
      + (FAnimTarget - FAnimStartProgress) * BezierEase(T, 0.1, 0.9, 0.2, 1.0);
  end;

  if FStateT < 1.0 then
  begin
    T := (Counter - FStateStartTime) / FAnimFrequency * 1000 / FStateDuration;
    if T >= 1.0 then
      FStateT := 1.0
    else
    begin
      Busy := True;
      // ControlFastOutSlowInKeySpline
      FStateT := BezierEase(T, 0, 0, 0, 1);
    end;
  end;

  FAnimTimer.Enabled := Busy;
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
    FPressed := True;
    FDragStartX := X;
    FDragDelta := 0;
    FDragged := False;
    UpdateVisualState;
  end;
end;

procedure TFluentToggleSwitch.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and FPressed then
  begin
    FPressed := False;
    UpdateVisualState;
    if FDragged then
    begin
      // The thumb settles into the state on its side of the track
      FAnimProgress := Ord(FChecked) + FDragDelta / DragTravel;
      FDragDelta := 0;
      if (FAnimProgress >= 0.5) <> FChecked then
        Toggle
      else
        SettleThumb;
    end
    else
    begin
      // A click can nudge the thumb without reaching the drag threshold
      FDragDelta := 0;
      if PtInRect(ClientRect, Point(X, Y)) then
        Toggle;
    end;
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
    UpdateVisualState;
  end;
  if FPressed then
    DragThumb(X);
end;

function TFluentToggleSwitch.DragTravel: Single;
begin
  Result := FScaledThumbCenterOnX[isPressed] - FScaledThumbCenterOffX[isPressed];
end;

procedure TFluentToggleSwitch.DragThumb(X: Integer);
var
  Delta: Single;
begin
  Delta := X - FDragStartX;
  if Abs(Delta) >= MulDiv(DragThreshold, FScalePPI, USER_DEFAULT_SCREEN_DPI) then
    FDragged := True;
  // The thumb stays within the track
  if FChecked then
  begin
    if Delta > 0 then
      Delta := 0
    else if Delta < -DragTravel then
      Delta := -DragTravel;
  end
  else
  begin
    if Delta < 0 then
      Delta := 0
    else if Delta > DragTravel then
      Delta := DragTravel;
  end;
  if Delta <> FDragDelta then
  begin
    FDragDelta := Delta;
    Invalidate;
  end;
end;

procedure TFluentToggleSwitch.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FHovered := True;
  UpdateVisualState;
end;

procedure TFluentToggleSwitch.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FHovered := False;
  // The mouse is captured while pressed, so a drag may leave the control
  if not MouseCapture then
    FPressed := False;
  UpdateVisualState;
end;

procedure TFluentToggleSwitch.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
  begin
    // A disabled window loses the capture, so no MouseUp will arrive
    FPressed := False;
    FHovered := False;
  end;
  UpdateVisualState;
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

function TFluentToggleSwitch.StateVisual(S: TInteractionState): TVisualState;
begin
  Result.ThumbW := FScaledThumbWidths[S];
  Result.ThumbH := FScaledThumbHeights[S];
  Result.ThumbOffX := FScaledThumbCenterOffX[S];
  Result.ThumbOnX := FScaledThumbCenterOnX[S];
  Result.TrackOff := OffTrackFill[S];
  Result.StrokeOff := OffTrackStroke[S];
  Result.TrackOn := OnTrackFill[S];
  Result.ThumbOff := OffThumbFill[S];
  Result.ThumbOn := OnThumbFill[S];
end;

function TFluentToggleSwitch.CurrentVisual: TVisualState;
var
  Target: TVisualState;
begin
  Target := StateVisual(FState);
  if FStateT < 1.0 then
    Result := LerpVisual(FStateFrom, Target, FStateT)
  else
    Result := Target;
end;

procedure TFluentToggleSwitch.UpdateVisualState;
var
  NewState: TInteractionState;
begin
  NewState := GetInteractionState;
  if NewState = FState then
    Exit;
  // Animate away from whatever is on screen right now
  FStateFrom := CurrentVisual;
  FState := NewState;
  if NewState = isDisabled then
    FStateDuration := DisabledStateDuration
  else
    FStateDuration := StateDuration;
  if FAnimated and HandleAllocated and Showing then
  begin
    FStateT := 0;
    QueryPerformanceCounter(FStateStartTime);
    StartTimer;
  end
  else
    FStateT := 1.0;
  Invalidate;
end;

procedure TFluentToggleSwitch.Paint;
var
  G: TGPGraphics;
  Path: TGPGraphicsPath;
  Brush: TGPSolidBrush;
  Pen: TGPPen;
  TrackX, TrackY: Single;
  VS: TVisualState;
  OffFill, OffStroke, OnFill: ARGB;
  OffThumb, OnThumb: ARGB;
  OffOpacity: Single;
  ThumbCX, ThumbCY: Single;
  ThumbW, ThumbH: Single;
  TextX, TextY: Integer;
  LabelText: string;

  procedure FillShape(Color: ARGB);
  begin
    if GetAlpha(Color) = 0 then
      Exit;
    Brush.SetColor(Color);
    G.FillPath(Brush, Path);
  end;

  procedure StrokeShape(Color: ARGB);
  begin
    if GetAlpha(Color) = 0 then
      Exit;
    Pen.SetColor(Color);
    G.DrawPath(Pen, Path);
  end;

begin
  TextX := 0;
  TextY := 0;

  // Background. csOpaque suppresses WM_ERASEBKGND, so this is the only erase
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);

  // Text layout; the height was measured when the font or the text last changed
  if FShowText then
  begin
    if FTextPosition = tpLeft then
      TextX := 0
    else
      TextX := FScaledTrackAreaWidth + TextGap;

    TextY := (Height - FTextHeight) div 2;
  end;

  // Track position, kept on whole pixels so the outline stays crisp
  TrackX := FTrackOffsetX + Round((FScaledTrackAreaWidth - FScaledTrackWidth) / 2);
  TrackY := Round((Height - FScaledTrackHeight) / 2);

  VS := CurrentVisual;
  OffOpacity := 1 - FAnimProgress;

  // Track colors; user colors override the theme
  if FTrackColorOff <> clNone then
    OffFill := TColorToARGB(FTrackColorOff)
  else
    OffFill := VS.TrackOff;

  if FTrackFrameColor <> clNone then
    OffStroke := TColorToARGB(FTrackFrameColor)
  else
    OffStroke := VS.StrokeOff;

  if FTrackColorOn <> clNone then
    OnFill := TColorToARGB(FTrackColorOn)
  else
    OnFill := VS.TrackOn;

  // Thumb colors
  if FThumbColorOff <> clNone then
    OffThumb := TColorToARGB(FThumbColorOff)
  else
    OffThumb := VS.ThumbOff;

  if FThumbColorOn <> clNone then
    OnThumb := TColorToARGB(FThumbColorOn)
  else
    OnThumb := VS.ThumbOn;

  // Thumb geometry; position interpolated
  ThumbW := VS.ThumbW;
  ThumbH := VS.ThumbH;
  ThumbCY := TrackY + FScaledTrackHeight / 2;
  ThumbCX := TrackX + VS.ThumbOffX
    + (VS.ThumbOnX - VS.ThumbOffX) * FAnimProgress
    + FDragDelta;

  // One path, one brush and one pen serve the whole frame, recolored per shape.
  // GDI+ objects do not outlive Paint: the wrapper unit shuts GDI+ down in its
  // finalization, which can run before the last control is destroyed.
  G := nil;
  Path := nil;
  Brush := nil;
  Pen := nil;
  try
    G := TGPGraphics.Create(Canvas.Handle);
    G.SetSmoothingMode(SmoothingModeAntiAlias);
    Path := TGPGraphicsPath.Create;
    Brush := TGPSolidBrush.Create(0);
    // Stroke is centered on the outline and scaled with DPI, as in WinUI
    Pen := TGPPen.Create(0, FScalePPI / USER_DEFAULT_SCREEN_DPI);

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
        StrokeShape(ScaleAlpha(OffStroke, FAnimProgress));
    end;

    // Thumb cross-fades the same way
    Path.Reset;
    AddPillPath(Path, ThumbCX - ThumbW / 2, ThumbCY - ThumbH / 2, ThumbW, ThumbH);
    if OffOpacity > 0 then
      FillShape(ScaleAlpha(OffThumb, OffOpacity));
    if FAnimProgress > 0 then
      FillShape(ScaleAlpha(OnThumb, FAnimProgress));
  finally
    Pen.Free;
    Brush.Free;
    Path.Free;
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

initialization
  InitAccentColors;

end.

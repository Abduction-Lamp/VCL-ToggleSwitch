unit ToggleSwitch;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Graphics;

type
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
  protected
    procedure Paint; override;
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

type
  TInteractionState = (isNormal, isHover, isPressed, isDisabled);

const
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

procedure TToggleSwitch.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Self.Color;
  if Self.Color = clNone then
    Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(R);
end;

procedure Register;
begin
  RegisterComponents('ToggleSwitch', [TToggleSwitch]);
end;

end.

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
    FOnChange: TNotifyEvent;
    procedure SetChecked(Value: Boolean);
    procedure SetAnimationDuration(Value: Integer);
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

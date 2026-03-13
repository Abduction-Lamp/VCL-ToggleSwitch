unit Demo.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ToggleSwitch;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    FToggleDefault: TFluentToggleSwitch;
    FToggleOn: TFluentToggleSwitch;
    FToggleDisabledOff: TFluentToggleSwitch;
    FToggleDisabledOn: TFluentToggleSwitch;
    FToggleNoAnim: TFluentToggleSwitch;
    FToggleCustomColors: TFluentToggleSwitch;
    FToggleWithText: TFluentToggleSwitch;
    FToggleTextLeft: TFluentToggleSwitch;
    FStatusLabel: TLabel;
    procedure OnToggleChange(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
const
  LeftMargin = 20;
  LabelLeft = 165;
  RowGap = 16;
var
  Y: Integer;

  function CreateLabel(ATop: Integer; const ACaption: string): TLabel;
  begin
    Result := TLabel.Create(Self);
    Result.Parent := Self;
    Result.Left := LabelLeft;
    Result.Top := ATop + 3;
    Result.Caption := ACaption;
  end;

  function CreateToggle(ATop: Integer): TFluentToggleSwitch;
  begin
    Result := TFluentToggleSwitch.Create(Self);
    Result.Parent := Self;
    Result.Left := LeftMargin;
    Result.Top := ATop;
    Result.OnChange := OnToggleChange;
  end;

begin
  Caption := 'TFluentToggleSwitch Demo';

  Y := 20;

  FToggleDefault := CreateToggle(Y);
  CreateLabel(Y, 'Default (Off, Animated)');
  Y := Y + FToggleDefault.Height + RowGap;

  FToggleOn := CreateToggle(Y);
  FToggleOn.Checked := True;
  CreateLabel(Y, 'Initially On');
  Y := Y + FToggleOn.Height + RowGap;

  FToggleDisabledOff := CreateToggle(Y);
  FToggleDisabledOff.Enabled := False;
  CreateLabel(Y, 'Disabled (Off)');
  Y := Y + FToggleDisabledOff.Height + RowGap;

  FToggleDisabledOn := CreateToggle(Y);
  FToggleDisabledOn.Checked := True;
  FToggleDisabledOn.Enabled := False;
  CreateLabel(Y, 'Disabled (On)');
  Y := Y + FToggleDisabledOn.Height + RowGap;

  FToggleNoAnim := CreateToggle(Y);
  FToggleNoAnim.Animated := False;
  CreateLabel(Y, 'No Animation');
  Y := Y + FToggleNoAnim.Height + RowGap;

  FToggleCustomColors := CreateToggle(Y);
  FToggleCustomColors.TrackColorOn := clGreen;
  FToggleCustomColors.ThumbColorOn := clWhite;
  FToggleCustomColors.TrackFrameColor := clGray;
  CreateLabel(Y, 'Custom Colors');
  Y := Y + FToggleCustomColors.Height + RowGap;

  FToggleWithText := CreateToggle(Y);
  FToggleWithText.ShowText := True;
  FToggleWithText.TextPosition := tpRight;
  CreateLabel(Y, 'With Text (Right)');
  Y := Y + FToggleWithText.Height + RowGap;

  FToggleTextLeft := CreateToggle(Y);
  FToggleTextLeft.ShowText := True;
  FToggleTextLeft.TextPosition := tpLeft;
  CreateLabel(Y, 'With Text (Left)');
  Y := Y + FToggleTextLeft.Height + RowGap;

  FStatusLabel := TLabel.Create(Self);
  FStatusLabel.Parent := Self;
  FStatusLabel.Left := LeftMargin;
  FStatusLabel.Top := Y;
  FStatusLabel.Caption := 'Click a toggle to see state change';
  Y := Y + FStatusLabel.Height + RowGap;

  ClientWidth := 500;
  ClientHeight := Y;
end;

procedure TForm1.OnToggleChange(Sender: TObject);
var
  Toggle: TFluentToggleSwitch;
  StateName: string;
begin
  Toggle := Sender as TFluentToggleSwitch;
  if Toggle.Checked then
    StateName := 'On'
  else
    StateName := 'Off';
  FStatusLabel.Caption := Format('Toggle changed: %s', [StateName]);
end;

end.

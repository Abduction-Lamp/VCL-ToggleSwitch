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

  function CreateLabel(AParent: TWinControl; ATop, ALeft: Integer; const ACaption: string): TLabel;
  begin
    Result := TLabel.Create(Self);
    Result.Parent := AParent;
    Result.Left := ALeft + 15;
    Result.Top := ATop + 3;
    Result.Caption := ACaption;
  end;

  function CreateToggle(AParent: TWinControl; ATop: Integer): TFluentToggleSwitch;
  begin
    Result := TFluentToggleSwitch.Create(Self);
    Result.Parent := AParent;
    Result.Left := 20;
    Result.Top := ATop;
    Result.OnChange := OnToggleChange;
  end;

begin
  Caption := 'TFluentToggleSwitch Demo';
  ClientWidth := 320;
  ClientHeight := 360;

  FToggleDefault := CreateToggle(Self, 20);
  CreateLabel(Self, 20, 150, 'Default (Off, Animated)');

  FToggleOn := CreateToggle(Self, 60);
  FToggleOn.Checked := True;
  CreateLabel(Self, 60, 150, 'Initially On');

  FToggleDisabledOff := CreateToggle(Self, 100);
  FToggleDisabledOff.Enabled := False;
  CreateLabel(Self, 100, 150, 'Disabled (Off)');

  FToggleDisabledOn := CreateToggle(Self, 140);
  FToggleDisabledOn.Checked := True;
  FToggleDisabledOn.Enabled := False;
  CreateLabel(Self, 140, 150, 'Disabled (On)');

  FToggleNoAnim := CreateToggle(Self, 180);
  FToggleNoAnim.Animated := False;
  CreateLabel(Self, 180, 150, 'No Animation');

  FToggleCustomColors := CreateToggle(Self, 220);
  FToggleCustomColors.TrackColorOn := clGreen;
  FToggleCustomColors.ThumbColorOn := clWhite;
  FToggleCustomColors.TrackFrameColor := clGray;
  CreateLabel(Self, 220, 150, 'Custom Colors');

  FToggleWithText := CreateToggle(Self, 260);
  FToggleWithText.ShowText := True;
  FToggleWithText.TextPosition := tpRight;
  CreateLabel(Self, 260, 150, 'With Text (Right)');

  FToggleTextLeft := CreateToggle(Self, 300);
  FToggleTextLeft.ShowText := True;
  FToggleTextLeft.TextPosition := tpLeft;
  CreateLabel(Self, 300, 150, 'With Text (Left)');

  FStatusLabel := TLabel.Create(Self);
  FStatusLabel.Parent := Self;
  FStatusLabel.Left := 20;
  FStatusLabel.Top := 335;
  FStatusLabel.Caption := 'Click a toggle to see state change';
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

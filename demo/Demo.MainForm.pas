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
    FToggleDefault: TToggleSwitch;
    FToggleOn: TToggleSwitch;
    FToggleDisabledOff: TToggleSwitch;
    FToggleDisabledOn: TToggleSwitch;
    FToggleNoAnim: TToggleSwitch;
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

  function CreateToggle(AParent: TWinControl; ATop: Integer): TToggleSwitch;
  begin
    Result := TToggleSwitch.Create(Self);
    Result.Parent := AParent;
    Result.Left := 20;
    Result.Top := ATop;
    Result.OnChange := OnToggleChange;
  end;

begin
  Caption := 'TToggleSwitch Demo';
  ClientWidth := 320;
  ClientHeight := 260;

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

  FStatusLabel := TLabel.Create(Self);
  FStatusLabel.Parent := Self;
  FStatusLabel.Left := 20;
  FStatusLabel.Top := 225;
  FStatusLabel.Caption := 'Click a toggle to see state change';
end;

procedure TForm1.OnToggleChange(Sender: TObject);
var
  Toggle: TToggleSwitch;
  StateName: string;
begin
  Toggle := Sender as TToggleSwitch;
  if Toggle.Checked then
    StateName := 'On'
  else
    StateName := 'Off';
  FStatusLabel.Caption := Format('Toggle changed: %s', [StateName]);
end;

end.

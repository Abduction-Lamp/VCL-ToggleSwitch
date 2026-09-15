unit Demo.MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ToggleSwitch, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    GridPanel: TGridPanel;
    Label1: TLabel;
    FluentToggleSwitch1: TFluentToggleSwitch;
    Label6: TLabel;
    FluentToggleSwitch6: TFluentToggleSwitch;
    Label2: TLabel;
    FluentToggleSwitch2: TFluentToggleSwitch;
    Label7: TLabel;
    FluentToggleSwitch7: TFluentToggleSwitch;
    Label3: TLabel;
    FluentToggleSwitch3: TFluentToggleSwitch;
    Label8: TLabel;
    FluentToggleSwitch8: TFluentToggleSwitch;
    Label4: TLabel;
    FluentToggleSwitch4: TFluentToggleSwitch;
    Label9: TLabel;
    FluentToggleSwitch9: TFluentToggleSwitch;
    Label5: TLabel;
    FluentToggleSwitch5: TFluentToggleSwitch;
    Label10: TLabel;
    FluentToggleSwitch10: TFluentToggleSwitch;
    LabelGroupKeyboard: TLabel;
    LabelGroupNoKeyboard: TLabel;
    Label11: TLabel;
    FluentToggleSwitch11: TFluentToggleSwitch;
    Label12: TLabel;
    FluentToggleSwitch12: TFluentToggleSwitch;
    procedure FluentToggleSwitch2Change(Sender: TObject);
    procedure FluentToggleSwitch3Change(Sender: TObject);
    procedure FluentToggleSwitch8Change(Sender: TObject);
    procedure FluentToggleSwitch11Change(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FluentToggleSwitch2Change(Sender: TObject);
begin
  if FluentToggleSwitch2.Checked then
    Label2.Caption := 'Checked = True (On)'
  else
    Label2.Caption := 'Checked = False (Off)';
end;

// The two switches below are disabled, so these captions must never change.
// If one of them flips, the switch answered the pointer when it should not
procedure TForm1.FluentToggleSwitch3Change(Sender: TObject);
begin
  if FluentToggleSwitch3.Checked then
    Label3.Caption := 'Enable = False (On)'
  else
    Label3.Caption := 'Enable = False (Off)';
end;

procedure TForm1.FluentToggleSwitch8Change(Sender: TObject);
begin
  if FluentToggleSwitch8.Checked then
    Label8.Caption := 'Enable = False (On)'
  else
    Label8.Caption := 'Enable = False (Off)';
end;

// Proof that the keyboard reached the switch, whether or not a ring showed up
procedure TForm1.FluentToggleSwitch11Change(Sender: TObject);
begin
  if FluentToggleSwitch11.Checked then
    Label11.Caption := 'Header and text (On)'
  else
    Label11.Caption := 'Header and text (Off)';
end;

end.

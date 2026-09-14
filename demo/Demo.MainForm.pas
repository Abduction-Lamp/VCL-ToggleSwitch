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
    Panel1: TPanel;
    Label2: TLabel;
    FluentToggleSwitch2: TFluentToggleSwitch;
    Panel2: TPanel;
    Label3: TLabel;
    FluentToggleSwitch3: TFluentToggleSwitch;
    Panel3: TPanel;
    Label4: TLabel;
    FluentToggleSwitch4: TFluentToggleSwitch;
    Panel4: TPanel;
    Label5: TLabel;
    FluentToggleSwitch5: TFluentToggleSwitch;
    Panel5: TPanel;
    Label6: TLabel;
    FluentToggleSwitch6: TFluentToggleSwitch;
    Panel6: TPanel;
    Label7: TLabel;
    FluentToggleSwitch7: TFluentToggleSwitch;
    Panel7: TPanel;
    Label8: TLabel;
    FluentToggleSwitch8: TFluentToggleSwitch;
    Panel8: TPanel;
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

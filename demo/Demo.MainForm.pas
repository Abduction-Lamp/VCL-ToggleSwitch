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
    procedure FormShow(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

//uses
//  System.SysUtils;

{$R *.dfm}

// Temporary: shows what the control believes about the screen it is on
procedure TForm1.FormShow(Sender: TObject);
begin
  Caption := Format(
    'form PPI %d, scale %.2f | switch PPI %d, scale %.2f, %dx%d | monitor %d | font %d',
    [CurrentPPI, ScaleFactor,
     FluentToggleSwitch1.CurrentPPI, FluentToggleSwitch1.ScaleFactor,
     FluentToggleSwitch1.Width, FluentToggleSwitch1.Height,
     Monitor.PixelsPerInch, Font.Height]);
end;

end.

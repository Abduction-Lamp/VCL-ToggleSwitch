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
    Label6: TLabel;
    FluentToggleSwitch6: TFluentToggleSwitch;
    Panel6: TPanel;
    Label2: TLabel;
    FluentToggleSwitch2: TFluentToggleSwitch;
    Panel2: TPanel;
    Label7: TLabel;
    FluentToggleSwitch7: TFluentToggleSwitch;
    Panel7: TPanel;
    Label3: TLabel;
    FluentToggleSwitch3: TFluentToggleSwitch;
    Panel3: TPanel;
    Label8: TLabel;
    FluentToggleSwitch8: TFluentToggleSwitch;
    Panel8: TPanel;
    Label4: TLabel;
    FluentToggleSwitch4: TFluentToggleSwitch;
    Panel4: TPanel;
    Label9: TLabel;
    FluentToggleSwitch9: TFluentToggleSwitch;
    Panel9: TPanel;
    Label5: TLabel;
    FluentToggleSwitch5: TFluentToggleSwitch;
    Panel5: TPanel;
    Label10: TLabel;
    FluentToggleSwitch10: TFluentToggleSwitch;
    Panel10: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    function PanelOf(Toggle: TFluentToggleSwitch): TPanel;
    procedure ShowState(Toggle: TFluentToggleSwitch);
    procedure OnToggleChange(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to GridPanel.ControlCollection.Count - 1 do
  begin
    Control := GridPanel.ControlCollection[I].Control;
    if Control is TFluentToggleSwitch then
    begin
      TFluentToggleSwitch(Control).OnChange := OnToggleChange;
      ShowState(TFluentToggleSwitch(Control));
    end;
  end;
end;

// The panel sharing a row with the switch
function TForm1.PanelOf(Toggle: TFluentToggleSwitch): TPanel;
var
  Controls: TControlCollection;
  I, Row: Integer;
begin
  Result := nil;
  Controls := GridPanel.ControlCollection;
  I := Controls.IndexOf(Toggle);
  if I < 0 then
    Exit;
  Row := Controls[I].Row;
  for I := 0 to Controls.Count - 1 do
    if (Controls[I].Row = Row) and (Controls[I].Control is TPanel) then
      Exit(TPanel(Controls[I].Control));
end;

procedure TForm1.ShowState(Toggle: TFluentToggleSwitch);
var
  Panel: TPanel;
begin
  // The Left/Right row puts its label on the side it names
  if SameText(Toggle.TextOff, 'Left') and SameText(Toggle.TextOn, 'Right') then
    if Toggle.Checked then
      Toggle.TextPosition := tpRight
    else
      Toggle.TextPosition := tpLeft;

  Panel := PanelOf(Toggle);
  if Panel = nil then
    Exit;
  if Toggle.Checked then
    Panel.Caption := Toggle.TextOn
  else
    Panel.Caption := Toggle.TextOff;
end;

procedure TForm1.OnToggleChange(Sender: TObject);
begin
  ShowState(Sender as TFluentToggleSwitch);
end;

end.

unit ToggleSwitch.Design;

interface

uses
  System.Classes,
  System.UITypes,
  Vcl.Controls,
  DesignIntf,
  DesignEditors,
  VCLEditors,
  ToggleSwitch;

type
  // Publishes the baseline of the text label to the form designer, so the label
  // can be lined up with the captions of buttons and edits next to it. Edge and
  // margin guides come from the ancestor.
  TFluentToggleSwitchGuidelines = class(TWinControlGuidelines)
  protected
    function GetCount: Integer; override;
    function GetDesignerGuideType(Index: Integer): TDesignerGuideType; override;
    function GetDesignerGuideOffset(Index: Integer): Integer; override;
  end;

procedure Register;

implementation

{ TFluentToggleSwitchGuidelines }

function TFluentToggleSwitchGuidelines.GetCount: Integer;
begin
  Result := inherited GetCount;
  if TFluentToggleSwitch(Component).ShowText then
    Inc(Result);
end;

function TFluentToggleSwitchGuidelines.GetDesignerGuideType(Index: Integer): TDesignerGuideType;
begin
  if Index >= inherited GetCount then
    Result := gtBaseline
  else
    Result := inherited GetDesignerGuideType(Index);
end;

function TFluentToggleSwitchGuidelines.GetDesignerGuideOffset(Index: Integer): Integer;
begin
  if Index >= inherited GetCount then
    Result := GetTextBaseline(TControl(Component), tlCenter)
  else
    Result := inherited GetDesignerGuideOffset(Index);
end;

procedure Register;
begin
  RegisterComponentGuidelines(TFluentToggleSwitch, TFluentToggleSwitchGuidelines);
end;

end.

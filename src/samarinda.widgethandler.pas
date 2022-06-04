unit Samarinda.WidgetHandler;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, Samarinda.Widgets, Samarinda.Buttons, Samarinda.Panels,
  Samarinda.Labels, Samarinda.BCButtons;

procedure RegisterWidget(AClassName: string; AClass: TCustomWidgetClass);

type
  TCustomWidgetClassMap = specialize TFPGMap<string, TCustomWidgetClass>;

var
  WidgetClassMap: TCustomWidgetClassMap;
implementation

procedure RegisterWidget(AClassName: string; AClass: TCustomWidgetClass);
begin
  if not Assigned(WidgetClassMap) then
    WidgetClassMap := TCustomWidgetClassMap.Create;
  WidgetClassMap.Add(AClassName, AClass);
end;

finalization
if Assigned(WidgetClassMap) then
  WidgetClassMap.Free;
end.


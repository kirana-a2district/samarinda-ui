unit Samarinda.WidgetHandler;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fgl, Samarinda.Widgets;

type
  TCustomWidgetClassMap = specialize TFPGMap<string, TCustomWidgetClass>;

var
  WidgetClassMap: TCustomWidgetClassMap;
implementation

initialization

WidgetClassMap := TCustomWidgetClassMap.Create;

finalization

WidgetClassMap.Free;

end.


unit SamaUI.Components;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, BESEN, BESENNativeObject, BESENValue, BESENObject,
  BESENTypes, BESENObjectPrototype, fpjson, jsonparser, typinfo, Graphics,
  Controls, Dialogs,
  samaui_template_form;

type
  TSamaComponent = class(TBESENNativeObject)
  private
    tempCtrl: TWinControl;
    procedure SetParentASyncCall(Data: ptrInt);
  protected
    procedure ConstructObject(const ThisArgument: TBESENValue;
      Arguments: PPBESENValues; CountArguments: integer); override;
  public
    SamaControl: TWinControl;
    constructor Create(AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload; override;
    constructor Create(Owner: TComponent; AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload;
    destructor Destroy; override;
  published
    procedure Show; virtual;
    procedure setParent(const ThisArgument: TBESENValue; Arguments: PPBESENValues;
  CountArguments:integer;var AResult:TBESENValue); virtual;
  end;

implementation

constructor TSamaComponent.Create(AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  //SamaControl := TWinControl.Create(nil);
end;

constructor TSamaComponent.Create(Owner: TComponent; AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  //SamaControl := TWinControl.Create(Owner);

end;

procedure TSamaComponent.ConstructObject(const ThisArgument: TBESENValue; Arguments: PPBESENValues; CountArguments: integer);
var
  i: integer;
  jStr: string;
  jData: TJSONData;
  cInfo: pointer;
  cPropInfo: PPropInfo;
  unkVal: string;
  val: TBESENValue;
begin
  inherited ConstructObject(ThisArgument, Arguments, CountArguments);


  TBesen(Instance).ObjectJSON.NativeStringify(ThisArgument, Arguments, CountArguments, val);
  //ShowMessage(val.Str);
  if CountArguments > 0 then
  begin
    jStr := TBESEN(Instance).ToStr(TBESEN(Instance).JSONStringify(Arguments^[0]^));
    jData := GetJSON(jStr);
    for i := 0 to TJSONArray(jData).Count-1 do
    begin
      cInfo := SamaControl.ClassInfo;
      cPropInfo := GetPropInfo(cInfo, TJSONObject(jData).Names[i]);
      case TJSONArray(jData).Types[i] of
        jtString:
        begin

          WriteStr(unkVal, cPropInfo^.PropType^.Kind);

          if cPropInfo^.PropType^.Kind = tkString then
            SetStrProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkSString then
            SetStrProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkLString then
            SetStrProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkAString then
            SetStrProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkWString then
            SetStrProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkEnumeration then
            SetEnumProp(SamaControl, cPropInfo, TJSONArray(jData).Strings[i])
          else if cPropInfo^.PropType^.Kind = tkInteger then
            SetInt64Prop(SamaControl, cPropInfo, StringToColor(TJSONArray(jData).Strings[i]))
          else if cPropInfo^.PropType^.Kind = tkMethod then
          begin
            // to do
          end
          else
          begin
            ShowMessage('s: '+ unkVal);
          end;
        end;
        jtBoolean:
        begin
          if cPropInfo^.PropType^.Kind = tkBool then
          begin
            SetPropValue(SamaControl, cPropInfo, TJSONArray(jData).Booleans[i])
            //ShowMessage('Unknown');
          end
        end;
        jtNumber:
        begin

          if cPropInfo^.PropType^.Kind = tkUnknown then
          begin
            //SetInt64Prop(SamaControl, cPropInfo, TJSONArray(jData).Integers[i])
            //ShowMessage('Unknown');
          end

          else if cPropInfo^.PropType^.Kind = tkInteger then
            SetInt64Prop(SamaControl, cPropInfo, TJSONArray(jData).Integers[i])
          else if cPropInfo^.PropType^.Kind = tkFloat then
            SetFloatProp(SamaControl, cPropInfo, TJSONArray(jData).Floats[i]);
        end;
      //else ;
      end;
      //ShowMessage(TJSONArray(jData).Strings[i]);
    end;
  end;
  if CountArguments = 2 then
  begin
    SamaControl.Parent := TSamaComponent(TBESEN(Instance).ToObj(Arguments^[1]^))
      .SamaControl;
  end;
end;

destructor TSamaComponent.Destroy;
begin
  inherited Destroy;
end;

procedure TSamaComponent.Show;
begin
  SamaControl.Visible := True;
end;

procedure TSamaComponent.SetParentASyncCall(Data: ptrInt);
begin
  SamaControl.Parent := tempCtrl;
end;

procedure TSamaComponent.setParent(const ThisArgument: TBESENValue;
  Arguments: PPBESENValues; CountArguments:integer;var AResult:TBESENValue);
begin
  tempCtrl := TSamaComponent(TBESEN(Instance).ToObj(Arguments^[0]^))
    .SamaControl;
  Application.QueueAsyncCall(@SetParentASyncCall, 0);
end;

end.

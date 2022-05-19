unit Samarinda.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, resource, TypInfo,Controls,  Dialogs,
  samaui_template_form, fgl,
  Lapis.Lson, Samarinda.Widgets;

type
  TComponentMap = specialize TFPGMap<string, TComponent>;

  TSamaForm = class(TTemplateForm)
  private
    Parser: TLSONNode;
  public
    ComponentMap: TComponentMap;
    procedure LoadFromString(AVal: string);
    //procedure AfterLsonParse(AComponent: TComponent); virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TSamaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ComponentMap := TComponentMap.Create;
end;

destructor TSamaForm.Destroy;
begin
  ComponentMap.Free;
  if Assigned(Parser) then
    Parser.Free;
  inherited Destroy;
end;

procedure TSamaForm.LoadFromString(AVal: string);
var
  cInfo: pointer;
  cPropInfo: PPropInfo;
  i: integer;
  SL: TStrings;
begin
  if Assigned(Parser) then
    Parser.Free;
  Parser := TLSONNode.ParseLSON(AVal);
  Parser.HandledObject := Self;
  cInfo := Self.ClassInfo;

  for i := 0 to Parser.Childs.Count - 1 do begin
    case Parser.Childs.Data[i].AttrType of
      atvString:
      begin
        //ShowMessage(Parser.Childs.Keys[i] +', '+Parser.Childs.Data[i].AttrValue.AsString);
        cPropInfo := GetPropInfo(cInfo, Parser.Childs.Keys[i]);
        SetStrProp(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsString);

      end;
      atvInteger:
      begin
        cPropInfo := GetPropInfo(cInfo, Parser.Childs.Keys[i]);
        SetInt64Prop(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsInteger);
      end;
      atvHex:
      begin

        cPropInfo := GetPropInfo(cInfo, Parser.Childs.Keys[i]);
        SetOrdProp(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsHex);
        ShowMessage('!'+Parser.Childs.Keys[i]);
      end;
      atvIdentifier:
      begin
        cPropInfo := GetPropInfo(cInfo, Parser.Childs.Keys[i]);
        SetEnumProp(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsString);
      end;
      atvObject:
      begin
        //ShowMessage(Parser.Childs.Keys[i]);
        SL := TStringList.Create;
        SL.AddDelimitedText(Parser.Childs.Keys[i], '.', True);
        if ComponentMap.IndexOf(SL[1]) = -1 then
          ComponentMap[SL[1]] := TCustomWidgetClass(
            WidgetClassMap[SL[0]]).Create(Self);

        Parser.Childs.Data[i].HandledObject := ComponentMap[SL[1]];

        TCustomWidget(Parser.Childs.Data[i].HandledObject).FormInstance := Self;
        TCustomWidget(Parser.Childs.Data[i].HandledObject).InitNode(Parser.Childs.Data[i]);
        TCustomWidget(Parser.Childs.Data[i].HandledObject).WidgetControl.Parent
          := Self;
        SL.Free;
      end;
    end;
  end;
end;

end.


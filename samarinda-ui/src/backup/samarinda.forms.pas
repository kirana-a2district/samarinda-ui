unit Samarinda.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, resource, TypInfo,Controls,  Dialogs, samaui_template_form,
  Lapis.Lson, Samarinda.Buttons, Samarinda.Widgets;

type
  TSamaForm = class(TTemplateForm)
  private
    Parser: TLSONNode;
  public
    procedure LoadFromString(AVal: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TSamaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSamaForm.Destroy;
begin
  if Assigned(Parser) then
    Parser.Free;
  inherited Destroy;
end;

procedure TSamaForm.LoadFromString(AVal: string);
var
  cInfo: pointer;
  cPropInfo: PPropInfo;
  i: integer;
begin
  if Assigned(Parser) then
    Parser.Free;
  Parser := TLSONNode.ParseLSON(AVal);
  Parser.HandledObject := Self;
  cInfo := Self.ClassInfo;
  //ShowMessage('HALO');
  for i := 0 to Parser.Childs.Count - 1 do begin
    case Parser.Childs.Data[i].AttrType of
      atvString:
      begin
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
        //ShowMessage('!'+Parser.Childs.Keys[i]);
        SetOrdProp(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsHex);
        ShowMessage('!'+Parser.Childs.Keys[i]);
        //Print('[Hex] Node: ' + AName + '; Value: ' + IntToHex(ANode.AttrValue.AsHex));
      end;
      atvIdentifier:
      begin
        cPropInfo := GetPropInfo(cInfo, Parser.Childs.Keys[i]);
        SetEnumProp(Self, cPropInfo, Parser.Childs.Data[i].AttrValue.AsString);
      end;
      atvObject:
      begin
        Parser.Childs.Data[i].HandledObject := TCustomWidgetClass(
          WidgetClassMap[Parser.Childs.Keys[i]]).Create(Self);
        //ShowMessage(Parser.Childs.Keys[i]);
        TCustomWidget(Parser.Childs.Data[i].HandledObject).WidgetControl.Parent
          := Self;
      //  if Anode.Parent <> nil then
      //    Print('[Object] Node: ' + AName + '; Parent: ' + Anode.Parent.NodeName)
      //  else
      //    Print('[Object] Node: ' + AName);
      end;
    end;
  end;
end;

end.


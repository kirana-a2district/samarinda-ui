unit Samarinda.ComUtils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, TypInfo, StrUtils, Dialogs,
  Lapis.Lson;

type
  TSamaObjectProperty = class(TPersistent)
  private
    WidgetNode: TLSONNode;

  public
    WidgetControl: TPersistent;
    constructor Create;
    destructor Destroy; override;
    procedure InitNode(ANode: TLsonNode);
  end;

implementation
uses
  Samarinda.Forms;

constructor TSamaObjectProperty.Create;
begin
  inherited Create;
end;

destructor TSamaObjectProperty.Destroy;
begin
  inherited Destroy;
end;

procedure TSamaObjectProperty.InitNode(ANode: TLSONNode);
var
  cInfo: pointer;
  cPropInfo: PPropInfo;
  i: integer;
  SL: TStrings;
  ObjName, ClsName: string;
  WidgetObj: TObject;
  ObjProp: TSamaObjectProperty;
begin
  WidgetNode := ANode;
  WidgetNode.HandledObject := Self;
  cInfo := WidgetControl.ClassInfo;


  for i := 0 to WidgetNode.Childs.Count - 1 do begin

    case WidgetNode.Childs.Data[i].AttrType of
      atvString:
      begin
        //ShowMessage(WidgetNode.Childs.Keys[i]);
        cPropInfo := GetPropInfo(cInfo, WidgetNode.Childs.Keys[i]);
        SetStrProp(WidgetControl, cPropInfo, WidgetNode.Childs.Data[i].AttrValue.AsString);
      end;
      atvInteger:
      begin

        cPropInfo := GetPropInfo(cInfo, WidgetNode.Childs.Keys[i]);
        SetInt64Prop(WidgetControl, cPropInfo, WidgetNode.Childs.Data[i].AttrValue.AsInteger);
      end;
      atvHex:
      begin
        cPropInfo := GetPropInfo(cInfo, WidgetNode.Childs.Keys[i]);
        SetOrdProp(WidgetControl, cPropInfo, WidgetNode.Childs.Data[i].AttrValue.AsHex);
      end;
      atvIdentifier:
      begin
        cPropInfo := GetPropInfo(cInfo, WidgetNode.Childs.Keys[i]);
        SetEnumProp(WidgetControl, cPropInfo, WidgetNode.Childs.Data[i].AttrValue.AsString);
      end;
      atvObject:
      begin
        ObjProp := TSamaObjectProperty.Create;
          ObjProp.WidgetControl := TPersistent(GetPropInfo(WidgetControl, WidgetNode.Childs.Keys[i]));
          ObjProp.InitNode(WidgetNode.Childs.Data[i]);

          ObjProp.Free;
      end;
    end;

  end;

end;

end.


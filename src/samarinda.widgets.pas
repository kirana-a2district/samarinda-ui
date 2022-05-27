unit Samarinda.Widgets;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, Controls, TypInfo, Dialogs,
  Lapis.Lson;

type
  TCustomWidget = class(TComponent)
  protected

  private
    WidgetNode: TLSONNode;
  public
    WidgetControl: TControl;
    FormInstance: TComponent;
    procedure InitNode(ANode: TLSONNode); virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TCustomWidgetClass = class of TCustomWidget;

implementation
uses
  Samarinda.WidgetHandler,
  Samarinda.Forms;


constructor TCustomWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCustomWidget.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomWidget.InitNode(ANode: TLSONNode);
var
  cInfo: pointer;
  cPropInfo: PPropInfo;
  i: integer;
  SL: TStrings;
  ObjName, ClsName: string;
  WidgetObj: TObject;
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
        SL := TStringList.Create;
        SL.AddDelimitedText(WidgetNode.Childs.Keys[i], '/', True);
        ObjName := SL[1];
        ClsName := SL[0];
        //ShowMessage(SL[0] + ': ' +SL[1]);
        if TSamaForm(FormInstance).WidgetMap.IndexOf(ObjName)
          = -1 then
        begin
          WidgetObj := TCustomWidgetClass(WidgetClassMap[ClsName]).Create(Self);
          WidgetNode.Childs.Data[i].HandledObject := WidgetObj;
          TSamaForm(FormInstance).WidgetMap[ObjName] :=
            TCustomWidget(WidgetObj).WidgetControl;
          TSamaForm(FormInstance).WidgetNodeMap[ObjName] :=
            TCustomWidget(WidgetObj);
        end
        else
        begin
          WidgetNode.Childs.Data[i].HandledObject :=
            TSamaForm(FormInstance).WidgetNodeMap[ObjName];
        end;

        TSamaForm(FormInstance).WidgetMap[ObjName].Name := ObjName;
        //TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).Name := ObjName;

        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).FormInstance := Self.FormInstance;
        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).InitNode(WidgetNode.Childs.Data[i]);
        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).WidgetControl.Parent :=
          TWinControl(Self.WidgetControl);

        SL.Free;

      end;
    end;
  end;
  //ShowMessage(WidgetControl.Caption);
end;

end.


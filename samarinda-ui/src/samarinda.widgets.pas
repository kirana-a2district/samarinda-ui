unit Samarinda.Widgets;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, ComCtrls, Controls, TypInfo, Dialogs,
  Lapis.Lson;

type
  TCustomWidget = class(TComponent)
  protected

  private
    WidgetNode: TLSONNode;
  public
    WidgetControl: TWinControl;
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
begin
  WidgetNode := ANode;
  //Name := WidgetNode.FindNode('name').AttrValue.ToString;

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
        SL.AddDelimitedText(WidgetNode.Childs.Keys[i], '.', True);

        if TSamaForm(FormInstance).ComponentMap.IndexOf(SL[1])
          = -1 then
            TSamaForm(FormInstance).ComponentMap[SL[1]] :=
            TCustomWidgetClass(WidgetClassMap[SL[0]]).Create(Self);
        WidgetNode.Childs.Data[i].HandledObject :=
          TSamaForm(FormInstance).ComponentMap[SL[1]];

        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).FormInstance := Self.FormInstance;
        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).InitNode(WidgetNode.Childs.Data[i]);
        TCustomWidget(WidgetNode.Childs.Data[i].HandledObject).WidgetControl.Parent :=
          Self.WidgetControl;

        SL.Free;

      end;
    end;
  end;
end;

end.


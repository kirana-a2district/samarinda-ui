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
    procedure InitNode(ANode: TLSONNode); virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TCustomWidgetClass = class of TCustomWidget;

implementation
uses
  Samarinda.WidgetHandler;

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
begin
  WidgetNode := ANode;
  Name := WidgetNode.FindNode('name').AttrValue.ToString;

  WidgetNode.HandledObject := Self;
  cInfo := WidgetControl.ClassInfo;
  //ShowMessage('HALO');
  for i := 0 to WidgetNode.Childs.Count - 1 do begin
    //ShowMessage(WidgetNode.Childs.Keys[i] + ': ' + WidgetNode.Childs.Data[i].AttrValue.Value);
    case WidgetNode.Childs.Data[i].AttrType of
      atvString:
      begin
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
        WidgetNode.Childs.Data[i].HandledObject := TCustomWidgetClass(
          WidgetClassMap[WidgetNode.Childs.Keys[i]]).Create(Self);
        ShowMessage('object');
      //  if Anode.Parent <> nil then
      //    Print('[Object] Node: ' + AName + '; Parent: ' + Anode.Parent.NodeName)
      //  else
      //    Print('[Object] Node: ' + AName);
      end;
    end;
  end;
end;

end.


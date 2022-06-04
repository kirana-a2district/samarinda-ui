unit Samarinda.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, resource, TypInfo,Controls,  Dialogs,
  samaui_template_form, fgl, StrUtils, base_window, LCLType,
  Lapis.Lson,
  Samarinda.Widgets,
  Samarinda.ComUtils;

type
  TProcCallBack = procedure of object;

  TWidgetMap = specialize TFPGMap<string, TComponent>;

  TSamaForm = class(TTemplateForm)
  private
    Parser: TLSONNode;
    BaseWindow: TfrBaseWindow;
  protected
    procedure PaintWindow(dc: Hdc); override;
  public
    WidgetMap: TWidgetMap;
    WidgetNodeMap: TWidgetMap;
    procedure LoadFromString(AVal: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PostLoad; virtual;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TSamaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetMap := TWidgetMap.Create;
  WidgetNodeMap := TWidgetMap.Create;
  if not isDesigning then
  begin
    BaseWindow := TfrBaseWindow.Create(self);
    BaseWindow.embeddedForm := Self;
    OnShow := BaseWindow.OnShow;

  end;
end;

procedure TSamaForm.PaintWindow(dc: Hdc);
begin
  if Assigned(BaseWindow) then
  begin
    if BaseWindow.lbTitlebar.Caption <> Caption then
    begin
      BaseWindow.Caption := Caption;
      BaseWindow.lbTitlebar.Caption := Caption
    end;
  end;
  inherited PaintWindow(dc);
end;

destructor TSamaForm.Destroy;
begin
  WidgetMap.Free;
  WidgetNodeMap.Free;
  if Assigned(Parser) then
    Parser.Free;
  inherited Destroy;
end;

procedure TSamaForm.PostLoad;
begin

end;

procedure TSamaForm.LoadFromString(AVal: string);
var
  cInfo: pointer;
  cPropInfo: PPropInfo;
  i: integer;
  SL: TStrings;
  CallProc: TProcCallBack;
  ObjName, ClsName: string;
  WidgetObj: TObject;
  ObjProp: TSamaObjectProperty;
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
        if ContainsStr(Parser.Childs.Keys[i], '/') then
        begin
          SL := TStringList.Create;
          SL.AddDelimitedText(Parser.Childs.Keys[i], '/', True);
          ObjName := SL[1];
          ClsName := SL[0];

          //ShowMessage(SL[0] + ': ' +SL[1]);
          if WidgetMap.IndexOf(SL[1]) = -1 then
          begin
            WidgetObj := TCustomWidgetClass(
              WidgetClassMap[ClsName]).Create(Self);
            Parser.Childs.Data[i].HandledObject := WidgetObj;
            WidgetMap[ObjName] := TCustomWidget(WidgetObj).WidgetControl;
            WidgetNodeMap[ObjName] := TCustomWidget(WidgetObj);
          end
          else
          begin
            Parser.Childs.Data[i].HandledObject := WidgetNodeMap[ObjName];
          end;

          WidgetMap[ObjName].Name := ObjName;
          //TCustomWidget(Parser.Childs.Data[i].HandledObject).Name := ObjName;

          TCustomWidget(Parser.Childs.Data[i].HandledObject).FormInstance := Self;
          TCustomWidget(Parser.Childs.Data[i].HandledObject).InitNode(Parser.Childs.Data[i]);
          TCustomWidget(Parser.Childs.Data[i].HandledObject).WidgetControl.Parent
            := Self;
          SL.Free;
        end
        else
        begin
          ObjProp := TSamaObjectProperty.Create;
          ObjProp.WidgetControl := TPersistent(GetObjectProp(WidgetObj, Parser.Childs.Keys[i]));
          ObjProp.InitNode(Parser.Childs.Data[i]);

          ObjProp.Free;
        end;

      end;
    end;
  end;
  //if Self.MethodAddress('PostLoad') <> nil then
  //begin
  //  TMethod(CallProc).Code := Self.MethodAddress('PostLoad');
  //  TMethod(CallProc).Data := Self;
  //  CallProc;
  //  ShowMessage('not working');
  //end
  //else
  //  ShowMessage('not working');

  //ShowMessage('not working');
  PostLoad;
end;

end.


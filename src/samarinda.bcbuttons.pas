unit Samarinda.BCButtons;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,
  Lapis.Lson, Dialogs, BCButton, BCTypes, Graphics,
  Samarinda.Widgets;

type
  TButtonWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TSamaButton = class(TButtonWidget)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TButtonWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TBCButton.Create(Self);
  TButton(WidgetControl).AutoSize := True;
end;

destructor TButtonWidget.Destroy;
begin
  WidgetControl.Free;
  inherited Destroy;
end;

procedure TButtonWidget.InitNode(ANode: TLSONNode);
begin
  inherited InitNode(ANode);
end;

constructor TSamaButton.Create(AOwner: TComponent);
var
  btn: TBCButton;
begin
  inherited Create(AOwner);
  btn := TBCButton(WidgetControl);
  btn.StateNormal.Background.Style := bbsColor;
  btn.StateNormal.Background.Color := clWhite;
end;

initialization
RegisterWidget('bcbutton', TButtonWidget);
RegisterWidget('samabutton', TSamaButton);
end.

unit Samarinda.Buttons;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,
  Lapis.Lson, Dialogs,
  Samarinda.Widgets;

type
  TButtonWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TButtonWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TButton.Create(Self);
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

initialization
RegisterWidget('button', TButtonWidget);
end.


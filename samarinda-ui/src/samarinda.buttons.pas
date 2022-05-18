unit Samarinda.Buttons;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,
  Lapis.Lson,
  Samarinda.Widgets;

type
  TButtonWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TButtonWidgetClass = class of TButtonWidget;

implementation
uses
  Samarinda.WidgetHandler;

constructor TButtonWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TButton.Create(Self);
end;

destructor TButtonWidget.Destroy;
begin
  inherited Destroy;
  WidgetControl.Free;
end;

procedure TButtonWidget.InitNode(ANode: TLSONNode);
begin
  inherited InitNode(ANode);
end;

initialization

WidgetClassMap.Add('button', TButtonWidget);

end.


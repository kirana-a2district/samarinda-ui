unit Samarinda.Labels;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls,
  Lapis.Lson, Dialogs,
  Samarinda.Widgets;

type
  TLabelWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TLabelWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TLabel.Create(Self);
  TLabel(WidgetControl).AutoSize := True;
end;

destructor TLabelWidget.Destroy;
begin
  WidgetControl.Free;
  inherited Destroy;
end;

procedure TLabelWidget.InitNode(ANode: TLSONNode);
begin
  inherited InitNode(ANode);
end;

initialization
RegisterWidget('label', TLabelWidget);
end.


unit Samarinda.Panels;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Dialogs,
  Lapis.Lson,
  Samarinda.Widgets;

type
  TPanelWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TPanelWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TPanel.Create(Self);
  with TPanel(WidgetControl) do
  begin
    ChildSizing.EnlargeHorizontal := crsHomogenousSpaceResize;
    ChildSizing.EnlargeVertical := crsHomogenousSpaceResize;
    ChildSizing.Layout := cclLeftToRightThenTopToBottom;
    BorderStyle := bsNone;
  end;
end;

destructor TPanelWidget.Destroy;
begin
  WidgetControl.Free;
  inherited Destroy;
end;

procedure TPanelWidget.InitNode(ANode: TLSONNode);
begin
  inherited InitNode(ANode);
end;

initialization
RegisterWidget('panel', TPanelWidget);
end.


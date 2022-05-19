unit Samarinda.Containers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Dialogs,
  Lapis.Lson,
  Samarinda.Widgets;

type
  TContainerWidget = class(TCustomWidget)
  public
    procedure InitNode(ANode: TLSONNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses
  Samarinda.WidgetHandler;

constructor TContainerWidget.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  WidgetControl := TPanel.Create(Self);
  with TPanel(WidgetControl) do
  begin
    ChildSizing.EnlargeHorizontal := crsHomogenousSpaceResize;
    ChildSizing.EnlargeVertical := crsHomogenousSpaceResize;
    ChildSizing.Layout := cclLeftToRightThenTopToBottom;
  end;
end;

destructor TContainerWidget.Destroy;
begin
  inherited Destroy;
  WidgetControl.Free;
end;

procedure TContainerWidget.InitNode(ANode: TLSONNode);
begin
  inherited InitNode(ANode);
  WidgetControl := TPanel.Create(Self);
  with TPanel(WidgetControl) do
  begin
    ChildSizing.EnlargeHorizontal := crsHomogenousSpaceResize;
    ChildSizing.EnlargeVertical := crsHomogenousSpaceResize;
    ChildSizing.Layout := cclLeftToRightThenTopToBottom;
  end;
end;

initialization
RegisterWidget('container', TContainerWidget);
end.


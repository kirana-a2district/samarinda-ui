unit sample_form;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, StdCtrls, Dialogs,
  Samarinda.Forms,
  Samarinda.Buttons;

type
  TSample = class(TSamaForm)
    procedure ButtonClick(Sender: TObject);
    procedure PostLoad; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    //procedure PostLoad;
  end;

implementation

procedure TSample.PostLoad;
begin
  //ShowMessage(TWinControl(WidgetMap['btn1']).Caption);
  // we map the event here
  if WidgetMap.IndexOf('btn1') <> -1 then
    TButton(WidgetMap['btn1']).OnClick := @ButtonClick;
end;

Constructor TSample.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TSample.ButtonClick(Sender: TObject);
begin
  ShowMessage('Clicked');
end;

end.


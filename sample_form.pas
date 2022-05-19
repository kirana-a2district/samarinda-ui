unit sample_form;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  Samarinda.Forms,
  Samarinda.Buttons;

type
  TSample = class(TSamaForm)
    procedure ButtonClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

Constructor TSample.Create(AOwner: TComponent);
begin

end;

procedure TSample.ButtonClick(Sender: TObject);
begin

end;

end.


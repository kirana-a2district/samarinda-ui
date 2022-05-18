unit Samainda.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms;

type
  TSamaForm = class(TCustomForm)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

constructor TSamaForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSamaForm.Destroy;
begin

end;

end.


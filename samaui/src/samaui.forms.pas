unit SamaUI.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, BESENNativeObject, BESENValue, BESENObject,
  SamaUI.Components,
  samaui_template_form;

type
  TSamaForm = class(TSamaComponent)
  protected
    procedure ConstructObject(const ThisArgument: TBESENValue;
      Arguments: PPBESENValues; CountArguments: integer); override;
  public
    constructor Create(AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload; override;
    constructor Create(Owner: TComponent; AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload;
    destructor Destroy; override;
  published
    procedure Show; override;
  end;

implementation

constructor TSamaForm.Create(AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  SamaControl := TTemplateForm.Create(nil);
end;

constructor TSamaForm.Create(Owner: TComponent; AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  SamaControl := TTemplateForm.Create(Owner);
end;

procedure TSamaForm.ConstructObject(const ThisArgument: TBESENValue; Arguments: PPBESENValues; CountArguments: integer);
begin
  inherited ConstructObject(ThisArgument, Arguments, CountArguments);
end;

destructor TSamaForm.Destroy;
begin
  SamaControl.Free;
  inherited Destroy;
end;

procedure TSamaForm.Show;
begin
  inherited Show;
end;

end.


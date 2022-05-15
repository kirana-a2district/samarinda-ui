unit SamaUI.Buttons;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, BESENNativeObject, BESENValue, BESENObject,
  SamaUI.Components, Dialogs,
  samaui_template_form;

type
  TSamaButton = class(TSamaComponent)
  protected
    procedure ConstructObject(const ThisArgument: TBESENValue;
      Arguments: PPBESENValues; CountArguments: integer); override;
  public
    constructor Create(AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload; override;
    destructor Destroy; override;
  published
    procedure Show; override;
    procedure setParent(const ThisArgument: TBESENValue; Arguments: PPBESENValues;
  CountArguments:integer;var AResult:TBESENValue); override;
  end;

implementation

constructor TSamaButton.Create(AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  SamaControl := TButton.Create(nil);
end;

procedure TSamaButton.ConstructObject(const ThisArgument: TBESENValue; Arguments: PPBESENValues; CountArguments: integer);
begin
  inherited ConstructObject(ThisArgument, Arguments, CountArguments);
end;

destructor TSamaButton.Destroy;
begin
  SamaControl.Free;
  inherited Destroy;
end;

procedure TSamaButton.Show;
begin
  inherited Show;
end;

procedure TSamaButton.setParent(const ThisArgument: TBESENValue; Arguments: PPBESENValues;
  CountArguments:integer;var AResult:TBESENValue);
begin
  inherited setParent(ThisArgument, Arguments, CountArguments, AResult);
  //ShowMessage(TButton(AParent).Caption);
end;

end.

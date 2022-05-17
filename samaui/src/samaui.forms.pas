unit SamaUI.Forms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, BESENNativeObject, BESENValue, BESENObject,
  SamaUI.Components,
  samaui_template_form;

type
  TSamaForm = class(TSamaComponent)
  private
    procedure ShowFormASyncCall(Data: ptrInt);
    procedure CreateFormASyncCall(Data: ptrInt);
  protected
    procedure ConstructObject(const ThisArgument: TBESENValue;
      Arguments: PPBESENValues; CountArguments: integer); override;
  public
    ComponentMap: TSamaComponentMap;
    constructor Create(AInstance: TObject; APrototype: TBESENObject = nil;
      AHasPrototypeProperty: longbool=false); overload; override;
    destructor Destroy; override;
  published
    procedure Show; override;
  end;

implementation
uses
  SamaUI.FormHandler;

procedure RegisterSamaForm(AName: string; AForm: TSamaForm);
begin
  //SamaFormMap.Add(AName, AForm);
end;

procedure TSamaForm.CreateFormASyncCall(Data: ptrInt);
begin
  SamaControl := TTemplateForm.Create(nil);

  //SamaControl.Parent := nil;
end;

constructor TSamaForm.Create(AInstance: TObject;
  APrototype: TBESENObject = nil; AHasPrototypeProperty: longbool=false);
begin
  inherited Create(AInstance, APrototype, AHasPrototypeProperty);
  SamaControl := TTemplateForm.Create(nil);
  ComponentMap := TSamaComponentMap.Create;
end;

procedure TSamaForm.ConstructObject(const ThisArgument: TBESENValue; Arguments: PPBESENValues; CountArguments: integer);
begin
  inherited ConstructObject(ThisArgument, Arguments, CountArguments);
end;

destructor TSamaForm.Destroy;
begin
  SamaControl.Free;
  ComponentMap.Free;
  inherited Destroy;
end;

procedure TSamaForm.ShowFormAsyncCall(Data: ptrInt);
begin
  SamaControl.Show;
end;

procedure TSamaForm.Show;
begin
  Application.QueueAsyncCall(@ShowFormAsyncCall, 0);
  //inherited Show;
end;

end.

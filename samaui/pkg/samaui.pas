{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit samaui;

{$warn 5023 off : no warning about unused units}
interface

uses
  SamaUI.Forms, BESEN, BESENErrors, BESENNativeObject, BESENObject, 
  BESENValue, samaui_template_form, SamaUI.Components, SamaUI.Buttons, 
  SamaUI.FormHandler, BESENObjectPropertyDescriptor, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('samaui', @Register);
end.

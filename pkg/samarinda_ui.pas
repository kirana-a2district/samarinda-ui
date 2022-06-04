{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit samarinda_ui;

{$warn 5023 off : no warning about unused units}
interface

uses
  Samarinda.Buttons, Samarinda.Panels, Samarinda.Forms, 
  Samarinda.WidgetHandler, Samarinda.Widgets, samaui_template_form, 
  Samarinda.ComUtils, Samarinda.Labels, base_window, base_window_maximisehint, 
  Samarinda.BCButtons, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('samarinda_ui', @Register);
end.

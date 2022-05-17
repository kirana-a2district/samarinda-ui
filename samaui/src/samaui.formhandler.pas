unit SamaUI.FormHandler;
// SHOULD BE HANDLER

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SamaUI.Forms, Dialogs, BESEN, BESENValue, BESENObject,
  BESENErrors, BESENObjectPropertyDescriptor, fgl, Controls;

type

  TSamaFormMap = class(specialize TFPGMap<string, TComponent>) end;

  TSamaFormHandler = class(TComponent)

  end;

var
  BesenInst: TBesen;
  SamaFormMap: TSamaFormMap;
implementation

//constructor TCustomSamaUI.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//
//end;
//
//destructor TCustomSamaUI.Destroy;
//begin
//  inherited Destroy;
//
//end;
//
//procedure TCustomSamaUI.Init;
//var
//  objWindow: TBESENObject;
//begin
//  //ObjWindow:=TBESEN(Instance).ObjectGlobal;
//  //TBESEN(Instance).ObjectGlobal.OverwriteData('window',BESENObjectValue(ObjWindow),[bopaWRITABLE,bopaCONFIGURABLE]);
//  //ObjDocument.OverwriteData('window',BESENObjectValue(TBESEN(Instance).ObjectGlobal),[bopaWRITABLE,bopaCONFIGURABLE]);
//  //TBESEN(BesenInst).RegisterNativeObject(Name, TSamaForm);
//  //BesenInst.Execute(LowerCase(Name)+' = null;');
//  ShowMessage(BesenInst.GarbageCollector.Count.ToString);
//  SamaForm := TSamaForm.Create(BesenInst, TBESEN(BesenInst).ObjectPrototype, True);
//
//  BesenInst.GarbageCollector.Add(SamaForm);
//  BesenInst.ObjectGlobal.OverwriteData(LowerCase(Name), BESENObjectValue(SamaForm), [bopaWRITABLE,bopaCONFIGURABLE]);
//  //SamaForm.OverwriteData('show', );
//  //BesenInst.Execute('moyang = new Moyang();');
//  //TSamaForm(BesenInst.GarbageCollector.RootObjectList).Show;
//  //TSamaForm(BesenInst.NativeCodeMemoryManager.).Show;
//  //BesenInst.Execute('moyang.Show();');
//
//end;

initialization
  BesenInst := TBESEN.Create;
  SamaFormMap := TSamaFormMap.Create;

finalization
  BesenInst.Free;
  SamaFormMap.Free;

end.


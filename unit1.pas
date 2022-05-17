unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, SynEdit, SynHighlighterJScript, Besen, BESENValue, BESENObject,
  BESENErrors, BESENObjectPrototype, BESENNativeObject, BESENConstants,
  SamaUI.Forms, SamaUI.Components, SamaUI.Buttons, SamaUI.FormHandler;

type

  TProcCallback = procedure (Sender: TObject) of object;

  { TForm1 }

  TForm1 = class(TForm)
    btnExec: TButton;
    codeEditor: TSynEdit;
    lbMessages: TListBox;
    PageControl1: TPageControl;
    SynJScriptSyn1: TSynJScriptSyn;
    TabSheet1: TTabSheet;
    procedure btnExecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    BesenInst: TBesen;
  public
    procedure Info(const ThisArgument:TBESENValue;Arguments:PPBESENValues;CountArguments:integer;var AResult:TBESENValue);
    procedure RunScript(const Lines: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnExecClick(Sender: TObject);
var
  CallProc: TProcCallback;
begin
  RunScript(codeEditor.Text);
  //TMethod(CallProc).Code := MethodAddress('Panel1Click');
  //TMethod(CallProc).Data := Self;
  //CallProc(Sender);
end;

procedure TForm1.Info(const ThisArgument: TBESENValue; Arguments: PPBESENValues;
  CountArguments:integer;var AResult:TBESENValue);
begin
  //ShowMessage(TSamaForm(TBESEN(BesenInst).ToObj(Arguments^[0]^)).LCLForm.Caption);
  ShowMessage(TBESEN(BesenInst).ToStr(TBESEN(BesenInst).JSONStringify(Arguments^[0]^)));
end;


procedure TForm1.RunScript(const Lines: String);
//var
  //UI: TCustomSamaUI;
begin
  //UI := TCustomSamaUI.Create(nil);
  //UI.Name := 'Moyang';
  //UI.Init;

   try
      BesenInst.Execute(Lines);
   except
      on e: EBESENError do
        lbMessages.Items.Add(Format('(%s) Syntax error on line %d: %s', [e.Name,
          TBESEN(BesenInst).LineNumber, e.Message]));

      on e: exception do
        lbMessages.Items.Add(Format('(%s) Exception error on line %d: %s', ['Exception',
          TBESEN(BesenInst).LineNumber, e.Message]));
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Position:=;
  BesenInst := TBesen.Create;
  BesenInst.RegisterNativeObject('SamaComponent', TSamaComponent);
  BesenInst.RegisterNativeObject('SamaForm', TSamaForm);
  BesenInst.RegisterNativeObject('SamaButton', TSamaButton);
  TBESEN(BesenInst).ObjectGlobal.RegisterNativeFunction('info', @Info, 1, []);
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
  ShowMessage('WOW');
end;

end.


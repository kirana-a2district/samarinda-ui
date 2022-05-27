unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  SynEdit, SynHighlighterJScript, Samarinda.Forms, sample_form;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnExec: TButton;
    codeEditor: TSynEdit;
    lbMessages: TListBox;
    PageControl1: TPageControl;
    SynJScriptSyn1: TSynJScriptSyn;
    TabSheet1: TTabSheet;
    procedure btnExecClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Sama: TSample;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Sama.Show;
  Sama.LoadFromString('Caption: "s" Color: $00A04B5F');
end;

procedure TForm1.btnExecClick(Sender: TObject);
begin
  Sama.Show;
  Sama.LoadFromString(codeEditor.Text);
  codeEditor.HighlightAllColor;
  //btnExec.Constraints;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Sama := TSample.Create(nil);
  {$IFDEF UNIX}
  codeEditor.Font.Name := 'default';
  {$ENDIF}
end;

end.


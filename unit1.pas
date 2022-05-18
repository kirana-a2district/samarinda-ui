unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  SynEdit, SynHighlighterJScript, Samarinda.Forms;

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
    Sama: TSamaForm;
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
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Sama := TSamaForm.Create(nil);
end;

end.


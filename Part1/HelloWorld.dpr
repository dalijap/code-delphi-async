program HelloWorld;

uses
  Vcl.Forms;

{$R *.res}

var
  MainForm: TForm;

begin
  Application.Initialize;
  Application.CreateForm(TForm, MainForm);
  MainForm.Caption := 'Hello World!';
  Application.Run;
end.


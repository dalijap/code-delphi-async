program FutureApp;

uses
  Vcl.Forms,
  FutureMainF in 'FutureMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


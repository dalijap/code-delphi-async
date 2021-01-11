program GenFutureApp;

uses
  Vcl.Forms,
  GenFutureMainF in 'GenFutureMainF.pas' {MainForm},
  NX.GenFuture in 'NX.GenFuture.pas',
  NX.Core in 'NX.Core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


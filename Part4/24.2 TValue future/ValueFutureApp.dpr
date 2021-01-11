program ValueFutureApp;

uses
  Vcl.Forms,
  ValueFutureMainF in 'ValueFutureMainF.pas' {MainForm},
  NX.Future in 'NX.Future.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


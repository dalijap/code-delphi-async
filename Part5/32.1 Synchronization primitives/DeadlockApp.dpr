program DeadlockApp;

uses
  Vcl.Forms,
  DeadlockMainF in 'DeadlockMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


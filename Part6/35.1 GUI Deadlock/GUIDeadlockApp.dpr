program GUIDeadlockApp;

uses
  Vcl.Forms,
  GUIDeadlockMainF in 'GUIDeadlockMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


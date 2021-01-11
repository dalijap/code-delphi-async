program GUICleanupApp;

uses
  Vcl.Forms,
  GUICleanupMainF in 'GUICleanupMainF.pas' {MainForm},
  DestroyF in 'DestroyF.pas' {Form1},
  GuardianF in 'GuardianF.pas' {Form2},
  WaitF in 'WaitF.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


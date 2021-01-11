program GUICommApp;

uses
  Vcl.Forms,
  GUICommMainF in 'GUICommMainF.pas' {MainForm},
  ControlsF in 'ControlsF.pas' {Form2},
  MessagingF in 'MessagingF.pas' {Form4},
  ProgressF in 'ProgressF.pas' {Form1},
  SpeedF in 'SpeedF.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


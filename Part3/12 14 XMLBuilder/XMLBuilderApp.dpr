program XMLBuilderApp;

uses
  Vcl.Forms,
  XMLBuilderMainF in 'XMLBuilderMainF.pas' {MainForm},
  XMLBuilderU in 'XMLBuilderU.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


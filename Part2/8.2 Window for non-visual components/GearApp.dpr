program GearApp;

uses
  Vcl.Forms,
  GearMainF in 'GearMainF.pas' {MainForm},
  GearU in 'GearU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


program BackgroundApp;

uses
  Vcl.Forms,
  BackgroundMainF in 'BackgroundMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


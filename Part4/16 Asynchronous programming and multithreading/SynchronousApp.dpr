program SynchronousApp;

uses
  Vcl.Forms,
  SynchronousMainF in 'SynchronousMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


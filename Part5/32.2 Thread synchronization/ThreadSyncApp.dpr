program ThreadSyncApp;

uses
  Vcl.Forms,
  ThreadSyncMainF in 'ThreadSyncMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


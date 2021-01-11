program ProcessMsgApp;

uses
  Vcl.Forms,
  ProcessMsgMainF in 'ProcessMsgMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


program MsgApp;

uses
  Vcl.Forms,
  MsgMainF in 'MsgMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


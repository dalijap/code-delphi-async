program AsyncDlg;

uses
  System.StartUpCopy,
  FMX.Forms,
  AsyncDlgMainF in 'AsyncDlgMainF.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.


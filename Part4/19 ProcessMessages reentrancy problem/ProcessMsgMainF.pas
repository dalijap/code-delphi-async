unit ProcessMsgMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    BlockingBtn: TButton;
    Memo: TMemo;
    ReentrantProcessMsgBtn: TButton;
    ProcessMsgBtn: TButton;
    UIBtn: TButton;
    ProcessingBtn: TButton;
    procedure BlockingBtnClick(Sender: TObject);
    procedure ReentrantProcessMsgBtnClick(Sender: TObject);
    procedure ProcessMsgBtnClick(Sender: TObject);
    procedure UIBtnClick(Sender: TObject);
    procedure ProcessingBtnClick(Sender: TObject);
  private
    Processing: Boolean;
    procedure DoFoo;
    procedure DoBar;
    procedure DoFork;

    procedure EnableUI;
    procedure DisableUI;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.DoFoo;
begin
  Memo.Lines.Add('Foo');
  Sleep(1000);
end;

procedure TMainForm.DoBar;
begin
  Memo.Lines.Add('Bar');
  Sleep(1000);
end;

procedure TMainForm.DoFork;
begin
  Memo.Lines.Add('Fork');
end;

procedure TMainForm.BlockingBtnClick(Sender: TObject);
begin
  DoFoo;
  DoBar;
  DoFork;
end;

procedure TMainForm.ReentrantProcessMsgBtnClick(Sender: TObject);
begin
  DoFoo;
  Application.ProcessMessages;
  DoBar;
  Application.ProcessMessages;
  DoFork;
end;

procedure TMainForm.ProcessMsgBtnClick(Sender: TObject);
begin
  ProcessMsgBtn.Enabled := False;
  try
    DoFoo;
    Application.ProcessMessages;
    DoBar;
    Application.ProcessMessages;
    DoFork;
  finally
    ProcessMsgBtn.Enabled := True;
  end;
end;

procedure TMainForm.ProcessingBtnClick(Sender: TObject);
begin
  if Processing then
    Exit;

  Processing := True;
  try
    DoFoo;
    Application.ProcessMessages;
    DoBar;
    Application.ProcessMessages;
    DoFork;
  finally
    Processing := False;
  end;
end;

procedure TMainForm.EnableUI;
begin
  BlockingBtn.Enabled := True;
  ReentrantProcessMsgBtn.Enabled := True;
  ProcessMsgBtn.Enabled := True;
  ProcessingBtn.Enabled := True;
  UIBtn.Enabled := True;
end;

procedure TMainForm.DisableUI;
begin
  BlockingBtn.Enabled := False;
  ReentrantProcessMsgBtn.Enabled := False;
  ProcessMsgBtn.Enabled := False;
  ProcessingBtn.Enabled := False;
  UIBtn.Enabled := False;
end;

procedure TMainForm.UIBtnClick(Sender: TObject);
begin
  if Processing then
    Exit;

  Processing := True;
  try
    DisableUI;
    DoFoo;
    Application.ProcessMessages;
    DoBar;
    Application.ProcessMessages;
    DoFork;
  finally
    Processing := False;
    EnableUI;
  end;
end;

end.


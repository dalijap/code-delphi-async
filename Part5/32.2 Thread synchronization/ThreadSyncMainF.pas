unit ThreadSyncMainF;

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
    SyncBtn: TButton;
    Memo: TMemo;
    QueueBtn: TButton;
    procedure SyncBtnClick(Sender: TObject);
    procedure QueueBtnClick(Sender: TObject);
  private
    procedure DoFoo;
    procedure DoBar;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.DoFoo;
begin
  OutputDebugString('FOO');
  Sleep(1000);
end;

procedure TMainForm.DoBar;
begin
  OutputDebugString('BAR');
  Sleep(500);
end;

procedure TMainForm.SyncBtnClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      DoFoo;
      TThread.Synchronize(nil,
        procedure
        begin
          OutputDebugString('SYNC');
          Memo.Lines.Add('SYNC');
        end);
      DoBar;
    end).Start;
end;

procedure TMainForm.QueueBtnClick(Sender: TObject);
var
  Thread: TThread;
begin
  Thread := TThread.CreateAnonymousThread(
    procedure
    begin
      DoFoo;
      TThread.Queue(nil,
        procedure
        begin
          OutputDebugString('QUEUE');
          Memo.Lines.Add('QUEUE');
        end);
      DoBar;
    end);
  Thread.Start;
end;

end.

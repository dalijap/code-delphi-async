unit DeadlockMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.SyncObjs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    DeadlockBtn: TButton;
    Memo: TMemo;
    LivelockBtn: TButton;
    procedure DeadlockBtnClick(Sender: TObject);
    procedure LivelockBtnClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.DeadlockBtnClick(Sender: TObject);
var
  Lock1: TCriticalSection;
  Lock2: TCriticalSection;
begin
  Memo.Lines.Add('Deadlock example');

  Lock1 := TCriticalSection.Create;
  Lock2 := TCriticalSection.Create;

  TThread.CreateAnonymousThread(
    procedure
    begin
      Lock1.Enter;
      try
        OutputDebugString('THREAD1 LOCK1 ACQUIRED');
        Sleep(1000);
        Lock2.Enter;
        try
          OutputDebugString('THREAD1 LOCK2 ACQUIRED');
          OutputDebugString('THREAD1 WORKING');
        finally
          Lock2.Leave;
          OutputDebugString('THREAD1 LOCK2 RELEASED');
        end;
      finally
        Lock1.Leave;
        OutputDebugString('THREAD1 LOCK1 RELEASED');
      end;
    end).Start;

  TThread.CreateAnonymousThread(
    procedure
    begin
      Lock2.Enter;
      try
        OutputDebugString('THREAD2 LOCK2 ACQUIRED');
        Sleep(500);
        Lock1.Enter;
        try
          OutputDebugString('THREAD2 LOCK1 ACQUIRED');
          OutputDebugString('THREAD2 WORKING');
        finally
          Lock1.Leave;
          OutputDebugString('THREAD2 LOCK1 RELEASED');
        end;
      finally
        Lock2.Leave;
        OutputDebugString('THREAD2 LOCK2 RELEASED');
      end;
    end).Start;
end;

procedure TMainForm.LivelockBtnClick(Sender: TObject);
var
  Lock1: TCriticalSection;
  Lock2: TCriticalSection;
begin
  Memo.Lines.Add('Livelock example');

  Lock1 := TCriticalSection.Create;
  Lock2 := TCriticalSection.Create;

  TThread.CreateAnonymousThread(
    procedure
    begin
      while True do
        begin
          if Lock1.TryEnter then
            begin
              OutputDebugString('THREAD1 LOCK1 ACQUIRED');
              Sleep(1000);
              if Lock2.TryEnter then
                begin
                  OutputDebugString('THREAD1 LOCK2 ACQUIRED');
                  OutputDebugString('THREAD1 WORKING');
                  Break;
                end
              else
                begin
                  Lock1.Release;
                  OutputDebugString('THREAD1 LOCK1 RELEASED');
                end;
            end;
        end;
      Lock1.Leave;
      OutputDebugString('THREAD1 LOCK1 RELEASED');
      Lock2.Leave;
      OutputDebugString('THREAD1 LOCK2 RELEASED');
    end).Start;

  TThread.CreateAnonymousThread(
    procedure
    begin
      while True do
        begin
          if Lock2.TryEnter then
            begin
              OutputDebugString('THREAD2 LOCK2 ACQUIRED');
              Sleep(500);
              if Lock1.TryEnter then
                begin
                  OutputDebugString('THREAD2 LOCK1 ACQUIRED');
                  OutputDebugString('THREAD2 WORKING');
                  Break;
                end
              else
                begin
                  Lock2.Release;
                  OutputDebugString('THREAD2 LOCK2 RELEASED');
                end;
            end;
        end;
      Lock1.Leave;
      OutputDebugString('THREAD2 LOCK1 RELEASED');
      Lock2.Leave;
      OutputDebugString('THREAD2 LOCK2 RELEASED');
    end).Start;
end;

end.

unit GUIDeadlockMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.SyncObjs,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Deadlock1Btn: TButton;
    Memo: TMemo;
    Deadlock2Btn: TButton;
    Deadlock3Btn: TButton;
    procedure Deadlock1BtnClick(Sender: TObject);
    procedure Deadlock2BtnClick(Sender: TObject);
    procedure Deadlock3BtnClick(Sender: TObject);
  private
    FTask: ITask;
  public
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

destructor TMainForm.Destroy;
begin
  if Assigned(FTask) then
    FTask.Wait(INFINITE);
  inherited;
end;

procedure TMainForm.Deadlock1BtnClick(Sender: TObject);
var
  Lock1: TCriticalSection;
  Lock2: TCriticalSection;
begin
  Lock1 := TCriticalSection.Create;
  Lock2 := TCriticalSection.Create;
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
  Lock1.Enter;
  try
    OutputDebugString('GUI THREAD LOCK1 ACQUIRED');
    Sleep(1000);
    Lock2.Enter;
    try
      OutputDebugString('GUI THREAD LOCK2 ACQUIRED');
      OutputDebugString('GUI THREAD WORKING');
    finally
      Lock2.Leave;
      OutputDebugString('GUI THREAD LOCK2 RELEASED');
    end;
  finally
    Lock1.Leave;
    OutputDebugString('GUI THREAD LOCK1 RELEASED');
  end;
// this example leaks both locks, but this is not relevant
// for demonstrating the deadlock problem
end;

procedure TMainForm.Deadlock2BtnClick(Sender: TObject);
var
  Lock: TCriticalSection;
begin
  Lock := TCriticalSection.Create;
  TThread.CreateAnonymousThread(
    procedure
    begin
      Lock.Enter;
      OutputDebugString('THREAD LOCK ACQUIRED');
      try
        Sleep(1000);
        TThread.Synchronize(nil,
          procedure
          begin
            OutputDebugString('SYNCHRONIZED');
          end);
      finally
        Lock.Leave;
        OutputDebugString('THREAD LOCK RELEASED');
      end;
    end).Start;
  Sleep(200);
  Lock.Enter;
  try
    OutputDebugString('GUI THREAD LOCK ACQUIRED');
  finally
    Lock.Leave;
    OutputDebugString('GUI THREAD LOCK RELEASED');
  end;
// this example leaks the lock, but this is not relevant
// for demonstrating the deadlock problem
end;

procedure TMainForm.Deadlock3BtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  FTask := TTask.Run(
    procedure
    begin
      OutputDebugString('TASK RUNNING');
      Sleep(10000);
      TThread.Synchronize(nil,
        procedure
        begin
          OutputDebugString('TASK FINISHED');
          FTask := nil;
        end);
    end);
end;

end.

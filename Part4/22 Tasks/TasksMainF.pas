unit TasksMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
    TaskBtn: TButton;
    Memo: TMemo;
    TaskProcBtn: TButton;
    TaskLifetimeBtn: TButton;
    WaitTaskBtn: TButton;
    ParallelJoinBtn: TButton;
    ParallelForBtn: TButton;
    procedure TaskBtnClick(Sender: TObject);
    procedure TaskProcBtnClick(Sender: TObject);
    procedure TaskLifetimeBtnClick(Sender: TObject);
    procedure WaitTaskBtnClick(Sender: TObject);
    procedure ParallelJoinBtnClick(Sender: TObject);
    procedure ParallelForBtnClick(Sender: TObject);
  private
    Processing: Boolean;
    Canceled: Boolean;
    //
    TaskData: TObject;

    procedure EnableUI;
    procedure DisableUI;

    procedure DoFoo;
    procedure DoBar;
    procedure DoFork;

    procedure TaskProc(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  // actual data would be of some other class type
  TaskData := TObject.Create;
end;

destructor TMainForm.Destroy;
begin
  TaskData.Free;
  inherited;
end;

procedure TMainForm.DoFoo;
begin
  // interacting with the GUI must be done
  // in context of the main thread
  // this will not change output order
  // if you want to omit synchronization calls
  // you can use OutputDebugString

  TThread.Synchronize(nil,
    procedure
    begin
      Memo.Lines.Add('Foo');
    end);
  OutputDebugString('Foo');
  // simulate some work
  Sleep(1000);
end;

procedure TMainForm.DoBar;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      Memo.Lines.Add('Bar');
    end);
  OutputDebugString('Bar');
  Sleep(1000);
end;

procedure TMainForm.DoFork;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      Memo.Lines.Add('Fork');
    end);
  OutputDebugString('Fork');
end;

procedure TMainForm.EnableUI;
begin
  TaskBtn.Enabled := True;
  TaskProcBtn.Enabled := True;
  TaskLifetimeBtn.Enabled := True;
  WaitTaskBtn.Enabled := True;
  ParallelJoinBtn.Enabled := True;
  ParallelForBtn.Enabled := True;
end;

procedure TMainForm.DisableUI;
begin
  TaskBtn.Enabled := False;
  TaskProcBtn.Enabled := False;
  TaskLifetimeBtn.Enabled := False;
  WaitTaskBtn.Enabled := False;
  ParallelJoinBtn.Enabled := False;
  ParallelForBtn.Enabled := False;
end;

procedure TMainForm.TaskBtnClick(Sender: TObject);
begin
  if Processing then
    Exit;

  Processing := True;
  DisableUI;
  TTask.Run(
    procedure
    begin
      try
        DoFoo;
        DoBar;
        DoFork;
      finally
        TThread.Synchronize(nil,
          procedure
          begin
            EnableUI;
            Processing := False;
          end);
      end;
    end);
end;

procedure TMainForm.TaskProc(Sender: TObject);
begin
  try
    DoFoo;
    DoBar;
    DoFork;
  finally
    TThread.Synchronize(nil,
      procedure
      begin
        EnableUI;
        Processing := False;
      end);
  end;
end;

procedure TMainForm.TaskProcBtnClick(Sender: TObject);
begin
  if Processing then
    Exit;

  Processing := True;
  DisableUI;
  TTask.Run(TaskData, TaskProc);
end;

// Canceling task is not actually implemented in following method
// it is purely used to show how referencing task can create cycle and
// how to break such cycle
procedure TMainForm.TaskLifetimeBtnClick(Sender: TObject);
var
  Task: ITask;
begin
  Task := TTask.Create(
    procedure
    begin
      DoBar;
      Task.CheckCanceled;
      DoFoo;
      Task.CheckCanceled;
      DoFork;
      Task := nil;
    end);
  Task.Start;
end;

procedure TMainForm.WaitTaskBtnClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      t1, t2, t3: ITask;
      i: Integer;
    begin
      t1 := TTask.Run(
        procedure
        begin
          OutputDebugString('TASK 1 RUNNING');
          Sleep(1000);
          OutputDebugString('TASK 1 COMPLETED');
        end);
      t2 := TTask.Run(
        procedure
        begin
          OutputDebugString('TASK 2 RUNNING');
          Sleep(2000);
          OutputDebugString('TASK 2 COMPLETED');
        end);
      t3 := TTask.Run(
        procedure
        begin
          OutputDebugString('TASK 3 RUNNING');
          Sleep(500);
          OutputDebugString('TASK 3 COMPLETED');
        end);
      try
        TTask.WaitForAll([t1, t2, t3]);
      except
        on E: EAggregateException do
          begin
            for i := 0 to E.Count - 1 do
              begin
                // handle specific exceptions E.InnerExceptions[i]
              end;
          end;
      end;
    end).Start;
end;

procedure TMainForm.ParallelJoinBtnClick(Sender: TObject);
var
  Task: ITask;
begin
  Task := TParallel.Join([
    procedure
    begin
      OutputDebugString('TASK 1 RUNNING');
      if Assigned(Task) then Task.CheckCanceled;
      OutputDebugString('TASK 1 COMPLETED');
    end,
    procedure
    begin
      OutputDebugString('TASK 2 RUNNING');
      if Assigned(Task) then Task.CheckCanceled;
      OutputDebugString('TASK 2 COMPLETED');
    end,
    procedure
    begin
      OutputDebugString('TASK 3 RUNNING');
      if Assigned(Task) then Task.CheckCanceled;
      OutputDebugString('TASK 3 COMPLETED');
    end]);
  try
    Task.Wait;
  except
  // handle task exception
  end;
  // break reference cycle
  Task := nil;
end;

procedure TMainForm.ParallelForBtnClick(Sender: TObject);
var
  Res: TParallel.TLoopResult;
  Arr: array of Integer;
  x: Integer;
begin
  SetLength(Arr, 10);
  Res := TParallel.&For(1, 10,
    procedure(TaskIndex: Integer)
    var
      f, i: Integer;
    begin
      f := 1;
      for i := 1 to TaskIndex do f := f * i;
      Arr[TaskIndex - 1] := f;
    end);
  if Res.Completed then
    begin
      for x in Arr do
        Memo.Lines.Add(x.ToString);
    end;
end;

end.

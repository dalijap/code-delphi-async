unit WaitF;

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
  TForm3 = class(TForm)
    Panel1: TPanel;
    TaskBtn: TButton;
    Memo: TMemo;
    CancelBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBtnClick(Sender: TObject);
    procedure TaskBtnClick(Sender: TObject);
  private
    FTask: ITask;
  public
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

destructor TForm3.Destroy;
begin
  if Assigned(FTask) then
    FTask.Cancel;
  inherited;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm3.TaskBtnClick(Sender: TObject);
var
  LTask: ITask;
begin
// prevent reentrancy
  if Assigned(FTask) then
    Exit;

  Memo.Lines.Add('TASK STARTED');
  LTask := TTask.Create(
    procedure
    var
      i: Integer;
    begin
      try
        OutputDebugString('TASK RUNNING');
        for i := 0 to 20 do
          begin
            Sleep(500);
            LTask.CheckCanceled;
          end;
        TThread.Synchronize(nil,
          procedure
          begin
            try
              LTask.CheckCanceled;
              OutputDebugString('TASK FINISHED');
              Memo.Lines.Add('TASK FINISHD');
            except
              // GUI is already closed here
              // eat exception
            end;
          end);
      finally
        TThread.Queue(nil,
          procedure
          begin
            LTask := nil;
            FTask := nil;
          end);
      end;
    end);
  FTask := LTask;
  FTask.Start;
end;

procedure TForm3.CancelBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    begin
      Memo.Lines.Add('TASK CANCELED');
      FTask.Cancel;
      FTask := nil;
    end;
end;

end.

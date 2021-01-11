unit DestroyF;

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
  TForm1 = class(TForm)
    Panel1: TPanel;
    TaskBtn: TButton;
    Memo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TaskBtnClick(Sender: TObject);
  private
    FTask: ITask;
  end;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FTask) then
    begin
      CanClose := False;
      Memo.Lines.Add('Cannot close form - task in progress');
    end;
end;

procedure TForm1.TaskBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  Memo.Lines.Add('TASK STARTED');
  FTask := TTask.Run(
    procedure
    begin
      OutputDebugString('TASK RUNNING');
      Sleep(10000);
      TThread.Synchronize(nil,
        procedure
        begin
          OutputDebugString('TASK FINISHED');
          Memo.Lines.Add('TASK FINISHD');
          FTask := nil;
        end);
    end);
end;

end.

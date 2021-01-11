unit SynchronousMainF;

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
    ForceBtn: TButton;
    Memo: TMemo;
    ProcessBtn: TButton;
    CancelBtn: TButton;
    procedure ForceBtnClick(Sender: TObject);
    procedure ProcessBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    Canceled: Boolean;
    procedure AddLineForce(x, n: integer);
    procedure AddLineProcess(x, n: integer);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.AddLineForce(x, n: integer);
begin
  if (x > n) or Canceled then
    Exit;
  Memo.Lines.Add(x.ToString);
  inc(x);
  TThread.ForceQueue(nil,
    procedure
    begin
      AddLineForce(x, n);
    end, 5);
end;

procedure TMainForm.AddLineProcess(x, n: integer);
var
  i: integer;
begin
  for i := x to n do
    begin
      if Canceled then
        Exit;
      Memo.Lines.Add(i.ToString);
      Application.ProcessMessages;
    end;
end;

procedure TMainForm.ForceBtnClick(Sender: TObject);
begin
  Canceled := False;
  AddLineForce(1, 100);
  AddLineForce(201, 300);
end;

procedure TMainForm.ProcessBtnClick(Sender: TObject);
begin
  Canceled := False;
  AddLineProcess(1, 100);
  AddLineProcess(201, 300);
end;

procedure TMainForm.CancelBtnClick(Sender: TObject);
begin
  Canceled := True;
  Memo.Lines.Add('Button Cancel');
end;

end.

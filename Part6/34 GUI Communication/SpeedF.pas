unit SpeedF;

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
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    SlowTaskBtn: TButton;
    Memo: TMemo;
    FastTaskBtn: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SlowTaskBtnClick(Sender: TObject);
    procedure FastTaskBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FTask: ITask;
  end;

implementation

{$R *.dfm}

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FTask) then
    CanClose := False;
end;

procedure TForm3.SlowTaskBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  Memo.Lines.Clear;

  FTask := TTask.Run(
    procedure
    var
      I: Integer;
      Count: Integer;
      Items: TStringList;
    begin
      Items := TStringList.Create;
      try
        Count := 10000;
        for I := 1 to Count do
          Items.Add('Item ' + I.ToString);
      finally
        TThread.Queue(nil,
          procedure
          begin
            Memo.Lines := Items;
            Items.Free;
            FTask := nil;
          end);
      end;
    end);
end;

procedure TForm3.FastTaskBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  Memo.Lines.Clear;

  FTask := TTask.Run(
    procedure
    var
      I: Integer;
      Count: Integer;
      Items: TStringList;
      ItemsStr: string;
    begin
      Items := TStringList.Create;
      try
        Count := 10000;
        for I := 1 to Count do
          Items.Add('Item ' + I.ToString);
        ItemsStr := Items.Text;
      finally
        Items.Free;
        TThread.Queue(nil,
          procedure
          begin
            Memo.Lines.Text := ItemsStr;
            FTask := nil;
          end);
      end
    end);
end;

end.

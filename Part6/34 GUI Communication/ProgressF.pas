unit ProgressF;

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
  TForm1 = class(TForm)
    Panel1: TPanel;
    TaskBtn: TButton;
    Memo: TMemo;
    Panel2: TPanel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    ListView: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TaskBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FTask: ITask;
    procedure StartProgress;
    procedure StopProgress;
    procedure Progress(APercent: Integer; const ADescription: string);
  public
  end;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FTask) then CanClose := False;
end;

procedure TForm1.StartProgress;
begin
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  ProgressLabel.Caption := '';
  ProgressLabel.Visible := True;
end;

procedure TForm1.StopProgress;
begin
  ProgressBar.Visible := False;
  ProgressLabel.Visible := False;
end;

procedure TForm1.Progress(APercent: Integer; const ADescription: string);
begin
  TThread.Queue(nil,
    procedure
    begin
      ProgressBar.Position := APercent;
      ProgressLabel.Caption := ADescription;
    end);
end;

procedure TForm1.TaskBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  FTask := TTask.Run(
    procedure
    var
      I: Integer;
    begin
      for I := 1 to 100 do
        begin
          Sleep(100);
          Progress(I, ' Step ' + I.ToString);
        end;
      TThread.Queue(nil,
        procedure
        begin
          StopProgress;
          FTask := nil;
        end);
    end);
end;

end.

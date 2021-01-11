unit ControlsF;

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
  TForm2 = class(TForm)
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
    procedure GUIBeginUpdate;
    procedure GUIEndUpdate;
    procedure GUIAddItem(const AData: string; APercent: Integer; const ADescription: string);
  end;

implementation

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FTask) then
    CanClose := False;
end;

procedure TForm2.GUIBeginUpdate;
begin
  Memo.Lines.BeginUpdate;
  ListView.Items.BeginUpdate;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  ProgressLabel.Caption := '';
  ProgressLabel.Visible := True;
end;

procedure TForm2.GUIEndUpdate;
begin
  Memo.Lines.EndUpdate;
  ListView.Items.EndUpdate;
  ProgressBar.Visible := False;
  ProgressLabel.Visible := False;
  FTask := nil;
end;

procedure TForm2.GUIAddItem(const AData: string; APercent: Integer; const ADescription: string);
begin
  TThread.Queue(nil,
    procedure
    var
      Item: TListItem;
    begin
      Memo.Lines.Add(AData);
      Item := ListView.Items.Add;
      Item.Caption := AData;
      ProgressBar.Position := APercent;
      ProgressLabel.Caption := ADescription;
    end);
end;

procedure TForm2.TaskBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
    Exit;

  GUIBeginUpdate;
  try
    FTask := TTask.Run(
      procedure
      var
        I: Integer;
        Count: Integer;
      begin
        try
          Count := 100;
          for I := 1 to Count do
            begin
              Sleep(100);
              GUIAddItem('Item ' + I.ToString, Round((I / Count) * 100), 'Step ' + I.ToString);
            end;
        finally
          TThread.Queue(nil,
            procedure
            begin
              GUIEndUpdate;
            end);
        end;
      end);
  except
    GUIEndUpdate;
  end;
end;

end.

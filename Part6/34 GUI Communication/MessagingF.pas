unit MessagingF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  System.Messaging,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TProgressStartMessage = class(TMessage);
  TProgressStopMessage = class(TMessage);

  TProgressMessage = class(TMessage)
  public
    Percent: Integer;
    Description: string;
    constructor Create(APercent: Integer; const ADescription: string);
  end;

  TForm4 = class(TForm)
    Panel1: TPanel;
    TaskBtn: TButton;
    Memo: TMemo;
    Panel2: TPanel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    ListView: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TaskBtnClick(Sender: TObject);
  private
    FTask: ITask;
    FProgressStartID: Integer;
    FProgressStopID: Integer;
    FProgressID: Integer;
    procedure SendStartProgress;
    procedure SendStopProgress;
    procedure SendProgress(APercent: Integer; const ADescription: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor TProgressMessage.Create(APercent: Integer; const ADescription: string);
begin
  inherited Create;
  Percent := APercent;
  Description := ADescription;
end;

constructor TForm4.Create(AOwner: TComponent);
begin
  inherited;
  FProgressStartID := TMessageManager.DefaultManager.SubscribeToMessage(TProgressStartMessage,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      ProgressBar.Position := 0;
      ProgressBar.Visible := True;
      ProgressLabel.Caption := '';
      ProgressLabel.Visible := True;
    end);

  FProgressStopID := TMessageManager.DefaultManager.SubscribeToMessage(TProgressStopMessage,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      ProgressBar.Visible := False;
      ProgressLabel.Visible := False;
    end);

  FProgressID := TMessageManager.DefaultManager.SubscribeToMessage(TProgressMessage,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      with TProgressMessage(M) do
        begin
          ProgressBar.Position := Percent;
          ProgressLabel.Caption := Description;
        end;
    end);
end;

destructor TForm4.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TProgressStartMessage, FProgressStartID);
  TMessageManager.DefaultManager.Unsubscribe(TProgressStopMessage, FProgressStopID);
  TMessageManager.DefaultManager.Unsubscribe(TProgressMessage, FProgressID);
  inherited;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm4.SendStartProgress;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TProgressStartMessage.Create);
end;

procedure TForm4.SendStopProgress;
begin
  TMessageManager.DefaultManager.SendMessage(nil, TProgressStopMessage.Create);
  FTask := nil;
end;

procedure TForm4.SendProgress(APercent: Integer; const ADescription: string);
begin
  TThread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil, TProgressMessage.Create(APercent, ADescription));
    end);
end;

procedure TForm4.TaskBtnClick(Sender: TObject);
begin
// prevent reentrancy
  if Assigned(FTask) then
    Exit;

  SendStartProgress;
  FTask := TTask.Run(
    procedure
    var
      I: Integer;
    begin
      for I := 1 to 100 do
        begin
          Sleep(100);
          SendProgress(I, ' Step ' + I.ToString); // SendProgress calls Queue
        end;
      TThread.Queue(nil,
        procedure
        begin
          SendStopProgress;
        end);
    end);
end;

end.

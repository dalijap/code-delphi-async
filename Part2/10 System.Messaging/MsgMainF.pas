unit MsgMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Messaging,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    SendBtn: TButton;
    Memo: TMemo;
    SubscribeBtn: TButton;
    UnsubscribeBtn: TButton;
    procedure SendBtnClick(Sender: TObject);
    procedure SubscribeBtnClick(Sender: TObject);
    procedure UnsubscribeBtnClick(Sender: TObject);
  private
    IsSubscribed: Boolean;
    Id: Integer;
  end;

  TStringMessage = TMessage<string>;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.SubscribeBtnClick(Sender: TObject);
begin
  if IsSubscribed then
    Exit;

  IsSubscribed := True;
  Memo.Lines.Add('Subscribed');
  Id := TMessageManager.DefaultManager.SubscribeToMessage(TStringMessage,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      Memo.Lines.Add(TStringMessage(M).Value);
    end);
end;

procedure TMainForm.UnsubscribeBtnClick(Sender: TObject);
begin
  if not IsSubscribed then
    Exit;

  IsSubscribed := False;
  Memo.Lines.Add('Unsubscribed');
  TMessageManager.DefaultManager.Unsubscribe(TStringMessage, Id);
end;

procedure TMainForm.SendBtnClick(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self, TStringMessage.Create('Test'));
end;

end.

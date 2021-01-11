unit GenFutureMainF;

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
  Vcl.ExtCtrls,
  NX.GenFuture;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    FutureBtn: TButton;
    Memo: TMemo;
    RejectedFutureBtn: TButton;
    MultipleFuturesBtn: TButton;
    procedure FutureBtnClick(Sender: TObject);
    procedure RejectedFutureBtnClick(Sender: TObject);
    procedure MultipleFuturesBtnClick(Sender: TObject);
  private
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FutureBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture<string>.Async(
    procedure(const aPromise: INxPromise<string>)
    begin
      Sleep(1000); // simulate work
      aPromise.Resolve('First');
    end).Sync.OnCompleted(
    procedure(const Value: TNxFutureResult<string>)
    begin
      Memo.Lines.Add('COMPLETED');
      if Value.Error.IsEmpty then
        Memo.Lines.Add('SUCCESS ' + Value.Value)
      else
        Memo.Lines.Add('FAILURE ' + Value.Error);
    end);
  Memo.Lines.Add('AFTER');
end;

procedure TMainForm.RejectedFutureBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture<string>.Async(
    procedure(const aPromise: INxPromise<string>)
    begin
      Sleep(1000); // simulate work
      aPromise.Reject('Some Error');
    end).Sync.OnCompleted(
    procedure(const Value: TNxFutureResult<string>)
    begin
      Memo.Lines.Add('COMPLETED');
      if Value.Error.IsEmpty then
        Memo.Lines.Add('SUCCESS ' + Value.Value)
      else
        Memo.Lines.Add('FAILURE ' + Value.Error);
    end);
  Memo.Lines.Add('AFTER');
end;

procedure TMainForm.MultipleFuturesBtnClick(Sender: TObject);
var
  Future: INxFuture<string>;
begin
  Memo.Lines.Add('BEFORE');
  Future := TNxFuture<string>.Async(
    procedure(const aPromise: INxPromise<string>)
    begin
      Sleep(1000); // simulate work
      aPromise.Resolve('First');
    end);

  TNxFuture<string>(Future)
    .Then_<integer>(
      procedure(const aPromise: INxPromise<integer>; const aValue: string)
      begin
        aPromise.Resolve(Length(aValue));
      end)
    .Sync
    .OnCompleted(
      procedure(const Value: TNxFutureResult<integer>)
      begin
        Memo.Lines.Add('COMPLETED');
        if Value.Error.IsEmpty then
          Memo.Lines.Add('SUCCESS ' + IntToStr(Value.Value))
        else
          Memo.Lines.Add('FAILURE ' + Value.Error);
      end);
  Memo.Lines.Add('AFTER');
end;

end.

unit ValueFutureMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Rtti,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  NX.Future;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Memo: TMemo;
    FutureBtn: TButton;
    RejectedFutureBtn: TButton;
    MultipleFuturesBtn: TButton;
    HandlersBtn: TButton;
    procedure FutureBtnClick(Sender: TObject);
    procedure RejectedFutureBtnClick(Sender: TObject);
    procedure MultipleFuturesBtnClick(Sender: TObject);
    procedure HandlersBtnClick(Sender: TObject);
  private
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FutureBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture.Async(
    procedure(const aPromise: INxPromise)
    begin
      Sleep(1000);
      aPromise.Resolve('First');
    end)
  .Sync
  .OnCompleted(
    procedure(const Value: TNxFutureResult)
    begin
      Memo.Lines.Add('COMPLETED');
      if Value.Error.IsEmpty then
        Memo.Lines.Add('SUCCESS ' + Value.Value.AsString)
      else
        Memo.Lines.Add('FAILURE ' + Value.Error);
    end);
  Memo.Lines.Add('AFTER');
end;

procedure TMainForm.RejectedFutureBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture.Async(
    procedure(const aPromise: INxPromise)
    begin
      Sleep(1000);
      aPromise.Reject('Some Error');
    end)
  .Sync
  .OnCompleted(
    procedure(const Value: TNxFutureResult)
    begin
      Memo.Lines.Add('COMPLETED');
      if Value.Error.IsEmpty then
        Memo.Lines.Add('SUCCESS ' + Value.Value.AsString)
      else
        Memo.Lines.Add('FAILURE ' + Value.Error);
    end);
  Memo.Lines.Add('AFTER');
end;

procedure TMainForm.MultipleFuturesBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture.Async(
    procedure(const aPromise: INxPromise)
    begin
      Sleep(1000);
      aPromise.Resolve('First');
    end)
  .Then_(
    procedure(const aPromise: INxPromise; const aValue: TValue)
    begin
      aPromise.Resolve(Length(aValue.AsString));
    end)
  .Sync
  .OnCompleted(
    procedure(const Value: TNxFutureResult)
    begin
      Memo.Lines.Add('COMPLETED');
      if Value.Error.IsEmpty then
        Memo.Lines.Add('SUCCESS ' + IntToStr(Value.Value.AsInteger))
      else
        Memo.Lines.Add('FAILURE ' + Value.Error);
    end);
  Memo.Lines.Add('AFTER');
end;

procedure TMainForm.HandlersBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('BEFORE');
  TNxFuture.Async(
    procedure(const aPromise: INxPromise)
    begin
      Sleep(1000);
      aPromise.Resolve('First');
    end)
  .Then_(
    procedure(const aPromise: INxPromise; const aValue: TValue)
    begin
      aPromise.Resolve(Length(aValue.AsString));
    end)
  .Sync
  .OnCompleted(
    procedure(const Value: TNxFutureResult)
    begin
      Memo.Lines.Add('COMPLETED');
    end)
  .OnSuccess(
    procedure(const Value: TValue)
    begin
      Memo.Lines.Add('SUCCESS ' + IntToStr(Value.AsInteger))
    end)
  .OnFailure(
    procedure(const Error: string)
    begin
      Memo.Lines.Add('FAILURE ' + Error);
    end);
  Memo.Lines.Add('AFTER');
end;

end.

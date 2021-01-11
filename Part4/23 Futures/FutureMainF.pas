unit FutureMainF;

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
  TMainForm = class(TForm)
    Panel1: TPanel;
    BlockingFutureBtn: TButton;
    Memo: TMemo;
    SingleFutureBtn: TButton;
    MultipleFutures1Btn: TButton;
    SingleFutureMultiValuesBtn: TButton;
    MultipleFutures2Btn: TButton;
    procedure BlockingFutureBtnClick(Sender: TObject);
    procedure SingleFutureBtnClick(Sender: TObject);
    procedure MultipleFutures1BtnClick(Sender: TObject);
    procedure SingleFutureMultiValuesBtnClick(Sender: TObject);
    procedure MultipleFutures2BtnClick(Sender: TObject);
  private
    procedure Foo;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Foo;
begin
  Memo.Lines.Add('FOO');
end;

procedure TMainForm.BlockingFutureBtnClick(Sender: TObject);
var
  Future: IFuture<string>;
begin
  Memo.Lines.Add('WORKING...');
  Future := TTask.Future<string>(
    function: string
    begin
      Sleep(5000);
      Result := 'FUTURE';
    end);
  Foo;
  Memo.Lines.Add(Future.Value);
  Memo.Lines.Add('FINISHED');
end;

procedure TMainForm.SingleFutureBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('WORKING...');
  TThread.CreateAnonymousThread(
    procedure
    var
      Future: IFuture<string>;
      Value: string;
    begin
      Future := TTask.Future<string>(
        function: string
        begin
          Sleep(5000);
          Result := 'FUTURE';
        end);
      Value := Future.Value;
      TThread.Synchronize(nil,
        procedure
        begin
          Memo.Lines.Add(Value);
          Memo.Lines.Add('FINISHED');
        end);
    end).Start;
  Foo;
end;

procedure TMainForm.MultipleFutures1BtnClick(Sender: TObject);
begin
  Memo.Lines.Add('WORKING...');
  TThread.CreateAnonymousThread(
    procedure
    var
      Future: IFuture<string>;
      FutureInt: IFuture<Integer>;
      Value: Integer;
    begin
      OutputDebugString('THREAD BEGIN');
      Future := TTask.Future<string>(
        function: string
        begin
          OutputDebugString('STRING FUTURE BEGIN');
          Sleep(8000);
          Result := 'FUTURE';
          OutputDebugString('STRING FUTURE END');
        end);
      FutureInt := TTask.Future<Integer>(
        function: Integer
        begin
          OutputDebugString('INTEGER FUTURE BEGIN');
          Sleep(3000);
          Result := Length(Future.Value);
          OutputDebugString('INTEGER FUTURE END');
        end);
      OutputDebugString('FUTURE WAIT');
      Value := FutureInt.Value;
      TThread.Synchronize(nil,
        procedure
        begin
          Memo.Lines.Add(Value.ToString);
          Memo.Lines.Add('FINISHED');
        end);
      OutputDebugString('THREAD END');
    end).Start;
end;

procedure TMainForm.SingleFutureMultiValuesBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('WORKING...');
  TThread.CreateAnonymousThread(
    procedure
    var
      FutureInt: IFuture<Integer>;
      Value: Integer;
    begin
      FutureInt := TTask.Future<Integer>(
        function: Integer
        var
          StringValue: string;
        begin
          // do work with string
          Sleep(5000);
          StringValue := 'FUTURE';
          // do work with integer
          Sleep(3000);
          Result := Length(StringValue);
        end);

      Value := FutureInt.Value;

      TThread.Synchronize(nil,
        procedure
        begin
          Memo.Lines.Add(Value.ToString);
          Memo.Lines.Add('FINISHED');
        end);
    end).Start;
end;

procedure TMainForm.MultipleFutures2BtnClick(Sender: TObject);
begin
  Memo.Lines.Add('WORKING...');
  TThread.CreateAnonymousThread(
    procedure
    var
      Future: IFuture<string>;
      FutureInt: IFuture<Integer>;
      StringValue: string;
      Value: Integer;
    begin
      OutputDebugString('THREAD BEGIN');
      Future := TTask.Future<string>(
        function: string
        begin
          OutputDebugString('STRING FUTURE BEGIN');
          Sleep(8000);
          Result := 'FUTURE';
          OutputDebugString('STRING FUTURE END');
        end);
      OutputDebugString('STRING FUTURE WAIT');
      StringValue := Future.Value;
      OutputDebugString('STRING VALUE RETRIEVED');
      FutureInt := TTask.Future<Integer>(
        function: Integer
        begin
          OutputDebugString('INTEGER FUTURE BEGIN');
          Sleep(3000);
          Result := Length(StringValue);
          OutputDebugString('INTEGER FUTURE END');
        end);
      OutputDebugString('INTEGER FUTURE WAIT');
      Value := FutureInt.Value;
      TThread.Synchronize(nil,
        procedure
        begin
          Memo.Lines.Add(Value.ToString);
          Memo.Lines.Add('FINISHED');
        end);
      OutputDebugString('THREAD END');
    end).Start;
end;


end.

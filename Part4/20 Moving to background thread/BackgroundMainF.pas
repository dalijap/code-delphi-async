unit BackgroundMainF;

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
    AnonymousBtn: TButton;
    Memo: TMemo;
    ExtendingBtn: TButton;
    ReentrancyBtn: TButton;
    OnTerminateBtn: TButton;
    Panel2: TPanel;
    CancelingBtn: TButton;
    CancelBtn: TButton;
    procedure AnonymousBtnClick(Sender: TObject);
    procedure ReentrancyBtnClick(Sender: TObject);
    procedure OnTerminateBtnClick(Sender: TObject);
    procedure ExtendingBtnClick(Sender: TObject);
    procedure CancelingBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    Processing: Boolean;
    Canceled: Boolean;

    procedure EnableUI;
    procedure DisableUI;
    procedure ThreadTerminateEvent(Sender: TObject);
  end;

  TFooBarForkThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

procedure DoFoo;
procedure DoBar;
procedure DoFork;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure DoFoo;
begin
  // interacting with the GUI must be done
  // in context of the main thread
  // this will not change output order
  // if you want to omit synchronization calls
  // you can use OutputDebugString

  TThread.Synchronize(nil,
    procedure
    begin
      // WARNING - don't use global state (MainForm) like that
      // this is used merely to simplify examples
      // and to have some easy to observe output
      MainForm.Memo.Lines.Add('Foo');
    end);
  OutputDebugString('Foo');
  // simulate some work
  Sleep(1000);
end;

procedure DoBar;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      MainForm.Memo.Lines.Add('Bar');
    end);
  OutputDebugString('Bar');
  Sleep(1000);
end;

procedure DoFork;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      MainForm.Memo.Lines.Add('Fork');
    end);
  OutputDebugString('Fork');
end;

constructor TFooBarForkThread.Create;
begin
  // start automatically, unlike an anonymous thread,
  // which is constructed in suspended mode
  inherited Create(False);
  FreeOnTerminate := True;
end;

procedure TFooBarForkThread.Execute;
begin
  DoFoo;
  DoBar;
  DoFork;
end;

procedure TMainForm.AnonymousBtnClick(Sender: TObject);
begin
  Memo.Lines.Add('Button click enter');
  OutputDebugString('Button click enter');
  TThread.CreateAnonymousThread(
    procedure
    begin
      DoFoo;
      DoBar;
      DoFork;
    end).Start;
  Memo.Lines.Add('Button click exit');
  OutputDebugString('Button click exit');
end;

procedure TMainForm.ExtendingBtnClick(Sender: TObject);
begin
  TFooBarForkThread.Create;
end;

procedure TMainForm.ReentrancyBtnClick(Sender: TObject);
begin
  if Processing then
    Exit;
  Processing := True;
  try
    DisableUI;
    TThread.CreateAnonymousThread(
      procedure
      begin
        try
          DoFoo;
          DoBar;
          DoFork;
        finally
          TThread.Synchronize(nil,
            procedure
            begin
              EnableUI;
              Processing := False;
            end);
        end;
      end).Start;
  except
    EnableUI;
    Processing := False;
  end;
end;

procedure TMainForm.ThreadTerminateEvent(Sender: TObject);
var
  E: TObject;
begin
  EnableUI;
  Processing := False;
  // handle exceptions
  E := TThread(Sender).FatalException;
  if Assigned(E) then
    begin
      if E is Exception then Application.ShowException(Exception(E))
      else ShowMessage(E.ClassName);
    end;
end;

procedure TMainForm.OnTerminateBtnClick(Sender: TObject);
var
  Thread: TThread;
begin
  if Processing then
    Exit;

  Processing := True;
  try
    DisableUI;
    // uncomment following line to test exception handling
    // raise Exception.Create('Fake thread construction exception');
    Thread := TThread.CreateAnonymousThread(
      procedure
      begin
        DoFoo;
        DoBar;
        // uncomment following line to test exception handling
        // raise Exception.Create('Fake thread execution exception');
        DoFork;
      end);
    Thread.OnTerminate := ThreadTerminateEvent;
    Thread.Start;
  except
    on E: Exception do
      begin
        EnableUI;
        Processing := False;
        Application.ShowException(E);
      end;
  end;
end;

procedure TMainForm.EnableUI;
begin
  AnonymousBtn.Enabled := True;
  ExtendingBtn.Enabled := True;
  ReentrancyBtn.Enabled := True;
  OnTerminateBtn.Enabled := True;
end;

procedure TMainForm.DisableUI;
begin
  AnonymousBtn.Enabled := False;
  ExtendingBtn.Enabled := False;
  ReentrancyBtn.Enabled := False;
  OnTerminateBtn.Enabled := False;
end;

procedure TMainForm.CancelBtnClick(Sender: TObject);
begin
  Canceled := True;
  Memo.Lines.Add('Canceled');
end;

procedure TMainForm.CancelingBtnClick(Sender: TObject);
begin
  Canceled := False;
  TThread.CreateAnonymousThread(
    procedure
    begin
      if Canceled then Exit;
      DoFoo;
      if Canceled then Exit;
      DoBar;
      if Canceled then Exit;
      DoFork;
    end).Start;
end;

end.

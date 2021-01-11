unit EventsMainF;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.SyncObjs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    EventsBtn: TButton;
    Memo: TMemo;
    procedure EventsBtnClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.EventsBtnClick(Sender: TObject);
var
  Event: TEvent;
begin
  Event := TEvent.Create;
  TThread.CreateAnonymousThread(
    procedure
    begin
      OutputDebugString('THREAD1 WORKING');
      Sleep(1000);
      OutputDebugString('THREAD1 FINISHED');
      Event.SetEvent;
    end).Start;
  TThread.CreateAnonymousThread(
    procedure
    begin
      OutputDebugString('THREAD2 WORKING');
      Sleep(300);
      OutputDebugString('WAITING FOR THREAD1');
      if Event.WaitFor(INFINITE) = wrSignaled then OutputDebugString('THREAD2 CONTINUE WORK AFTER THREAD1 IS FINISHED')
      else OutputDebugString('THREAD2 UNSPECIFIED EVENT ERROR');
      OutputDebugString('THREAD2 FINISHED');
      // after this point it is safe to release the event object
      Event.Free;
    end).Start;
end;

end.

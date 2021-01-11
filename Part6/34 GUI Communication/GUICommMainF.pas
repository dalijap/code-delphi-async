unit GUICommMainF;

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
    ProgressBtn: TButton;
    ControlsBtn: TButton;
    SpeedBtn: TButton;
    MessagingBtn: TButton;
    procedure ProgressBtnClick(Sender: TObject);
    procedure ControlsBtnClick(Sender: TObject);
    procedure SpeedBtnClick(Sender: TObject);
    procedure MessagingBtnClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  ProgressF,
  ControlsF,
  SpeedF,
  MessagingF;

procedure TMainForm.ProgressBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm1, Form);
  Form.Show;
end;

procedure TMainForm.ControlsBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm2, Form);
  Form.Show;
end;

procedure TMainForm.SpeedBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm3, Form);
  Form.Show;
end;

procedure TMainForm.MessagingBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm4, Form);
  Form.Show;
end;

end.

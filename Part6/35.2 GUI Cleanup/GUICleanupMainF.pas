unit GUICleanupMainF;

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
    GUIDestroyBtn: TButton;
    GuardianBtn: TButton;
    WaitBtn: TButton;
    procedure GUIDestroyBtnClick(Sender: TObject);
    procedure GuardianBtnClick(Sender: TObject);
    procedure WaitBtnClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  DestroyF,
  GuardianF,
  WaitF;

procedure TMainForm.GUIDestroyBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm1, Form);
  Form.Show;
end;

procedure TMainForm.GuardianBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm2, Form);
  Form.Show;
end;

procedure TMainForm.WaitBtnClick(Sender: TObject);
var
  Form: TForm;
begin
  Application.CreateForm(TForm3, Form);
  Form.Show;
end;

end.

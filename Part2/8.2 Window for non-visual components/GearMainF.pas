unit GearMainF;

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
  GearU;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    MessageBtn: TButton;
    procedure MessageBtnClick(Sender: TObject);
  private
    FGear: TGear;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  FGear := TGear.Create;
end;

destructor TMainForm.Destroy;
begin
  FGear.Free;
  inherited;
end;

procedure TMainForm.MessageBtnClick(Sender: TObject);
begin
  PostMessage(FGear.WndHandle, CM_MY_EVENT, 0, 0);
end;

end.

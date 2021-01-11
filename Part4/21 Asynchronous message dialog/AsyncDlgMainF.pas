unit AsyncDlgMainF;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.DialogService, FMX.Layouts;

type
  TMainForm = class(TForm)
    DlgBtn: TButton;
    Memo1: TMemo;
    Layout1: TLayout;
    SyncChk: TCheckBox;
    procedure DlgBtnClick(Sender: TObject);
    procedure SyncChkChange(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.DlgBtnClick(Sender: TObject);
begin
  Memo1.Lines.Add('Button click begin');
  TDialogService.MessageDialog('Are you sure you want to delete selected item?',
    TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
      // this handler runs in context of main thread
      Memo1.Lines.Add('Handler');
      if AResult = mrOK then
        begin
        end;
    end);
  Memo1.Lines.Add('Button click end');
end;

procedure TMainForm.SyncChkChange(Sender: TObject);
begin
  if SyncChk.IsChecked then
    TDialogService.PreferredMode := TDialogService.TPreferredMode.Sync
  else
    TDialogService.PreferredMode := TDialogService.TPreferredMode.Async;
end;

end.

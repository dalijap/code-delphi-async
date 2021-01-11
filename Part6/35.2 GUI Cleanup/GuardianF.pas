unit GuardianF;

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
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  IGuardian = interface
    function GetIsDismantled: Boolean;
    procedure Dismantle;
    property IsDismantled: Boolean read GetIsDismantled;
  end;

  TGuardian = class(TInterfacedObject, IGuardian)
  private
    FIsDismantled: Boolean;
    function GetIsDismantled: Boolean;
  public
    procedure Dismantle;
    property IsDismantled: Boolean read GetIsDismantled;
  end;

  TForm2 = class(TForm)
    Panel1: TPanel;
    TaskBtn: TButton;
    Memo: TMemo;
    Panel2: TPanel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    ListView: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TaskBtnClick(Sender: TObject);
  private
    FGuardian: IGuardian;
    FTask: ITask;
    procedure GUIBeginUpdate;
    procedure GUIEndUpdate;
    procedure GUIAddItem(const AGuardian: IGuardian; const AData: string; APercent: Integer; const ADescription: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

procedure TGuardian.Dismantle;
begin
  FIsDismantled := True;
end;

function TGuardian.GetIsDismantled: Boolean;
begin
  Result := FIsDismantled;
end;

constructor TForm2.Create(AOwner: TComponent);
begin
  inherited;
  FGuardian := TGuardian.Create;
end;

destructor TForm2.Destroy;
begin
  FGuardian.Dismantle;
  inherited;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm2.GUIBeginUpdate;
begin
  Memo.Lines.BeginUpdate;
  ListView.Items.BeginUpdate;
  ProgressBar.Position := 0;
  ProgressBar.Visible := True;
  ProgressLabel.Caption := '';
  ProgressLabel.Visible := True;
end;

procedure TForm2.GUIEndUpdate;
begin
  Memo.Lines.EndUpdate;
  ListView.Items.EndUpdate;
  ProgressBar.Visible := False;
  ProgressLabel.Visible := False;
  FTask := nil;
end;

procedure TForm2.GUIAddItem(const AGuardian: IGuardian; const AData: string; APercent: Integer; const ADescription: string);
begin
  TThread.Queue(nil,
    procedure
    var
      Item: TListItem;
    begin
      if AGuardian.IsDismantled then
        Exit;

      Memo.Lines.Add(AData);
      Item := ListView.Items.Add;
      Item.Caption := AData;
      ProgressBar.Position := APercent;
      ProgressLabel.Caption := ADescription;
    end);
end;

procedure TForm2.TaskBtnClick(Sender: TObject);
var
  LGuardian: IGuardian;
begin
  if Assigned(FTask) then
    Exit;

  LGuardian := FGuardian;
  GUIBeginUpdate;
  try
    FTask := TTask.Run(
      procedure
      var
        I: Integer;
        Count: Integer;
      begin
        try
          Count := 100;
          for I := 1 to Count do
            begin
              Sleep(100);
              GUIAddItem(LGuardian, 'Item ' + I.ToString, Round((I / Count) * 100), 'Step ' + I.ToString);
            end;
        finally
          TThread.Queue(nil,
            procedure
            begin
              if not LGuardian.IsDismantled then
                GUIEndUpdate;
            end);
        end;
      end);
  except
    GUIEndUpdate;
  end;
end;

end.

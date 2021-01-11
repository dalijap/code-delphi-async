unit XMLBuilderMainF;

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
  XMLBuilderU;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    RecordBtn: TButton;
    Memo: TMemo;
    ObjectBtn: TButton;
    InterfaceBtn: TButton;
    InterfaceUnsafeBtn: TButton;
    WithBtn: TButton;
    ProceduralBtn: TButton;
    procedure RecordBtnClick(Sender: TObject);
    procedure ObjectBtnClick(Sender: TObject);
    procedure InterfaceBtnClick(Sender: TObject);
    procedure InterfaceUnsafeBtnClick(Sender: TObject);
    procedure WithBtnClick(Sender: TObject);
    procedure ProceduralBtnClick(Sender: TObject);
  private
  public
  end;

  TXMLBuilderHelper = class helper for TXMLBuilderObject
  public
    function AddValues(const Tag: string; Values: array of string): TXMLBuilderObject;
  end;

function TestRec: string;
function TestObject: string;
function TestInterface: string;
function TestInterfaceUnsafe: string;
function TestWith: string;
function TestProcedural: string;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TXMLBuilderHelper }

function TXMLBuilderHelper.AddValues(const Tag: string; Values: array of string): TXMLBuilderObject;
var
  Value: string;
begin
  Result := Self;
  Open(Tag);
  for Value in Values do
    Add('value', Value);
  Close(Tag);
end;

function TestRec: string;
var
  s: string;
  i: integer;
begin
  for i := 0 to 3 do
   s := TXMLBuilderRec.New
    .Open('root')
      .Open('data')
      .Close('data')
      .Open('items')
        .Add('item', '123')
        .Add('item', '456')
      .Close('items')
      .Add('xxx', 'yyy')
    .Close('root')
    .SaveToString;
  Result := s;
end;

function TestObject: string;
begin
  Result := TXMLBuilderObject.New
    .Open('root')
      .Open('data')
      .Close('data')
      .Open('items')
        .Add('item', '123')
        .Add('item', '456')
      .Close('items')
      .Add('xxx', 'yyy')
      .AddValues('values', ['aaa', 'bbb'])
    .Close('root')
    .SaveToString;
end;

function TestInterface: string;
begin
  Result := TXMLBuilder.New
    .Open('root')
      .Open('data')
      .Close('data')
      .Open('items')
        .Add('item', '123')
        .Add('item', '456')
      .Close('items')
      .Add('xxx', 'yyy')
    .Close('root')
    .SaveToString;
end;

function TestInterfaceUnsafe: string;
begin
  Result := TXMLBuilderUnsafe.New
    .Open('root')
      .Open('data')
      .Close('data')
      .Open('items')
        .Add('item', '123')
        .Add('item', '456')
      .Close('items')
      .Add('xxx', 'yyy')
    .Close('root')
    .SaveToString;
end;

function TestWith: string;
begin
  with TXMLBuilderProcedural.New do
    begin
      Open('root');
        Open('data');
        Close('data');
        Open('items');
          Add('item', '123');
          Add('item', '456');
        Close('items');
        Add('xxx', 'yyy');
      Close('root');
      Result := SaveToString;
    end;
end;

function TestProcedural: string;
var
  _: IXMLBuilderProcedural;
begin
  _ := TXMLBuilderProcedural.New;
  _.Open('root');
    _.Open('data');
    _.Close('data');
    _.Open('items');
      _.Add('item', '123');
      _.Add('item', '456');
    _.Close('items');
    _.Add('xxx', 'yyy');
  _.Close('root');
  Result := _.SaveToString;
end;

procedure TMainForm.RecordBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestRec;
  Memo.Lines.Add(s);
end;

procedure TMainForm.ObjectBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestObject;
  Memo.Lines.Add(s);
end;

procedure TMainForm.InterfaceBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestInterface;
  Memo.Lines.Add(s);
end;

procedure TMainForm.InterfaceUnsafeBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestInterfaceUnsafe;
  Memo.Lines.Add(s);
end;

procedure TMainForm.WithBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestWith;
  Memo.Lines.Add(s);
end;

procedure TMainForm.ProceduralBtnClick(Sender: TObject);
var
  s: string;
begin
  s := TestProcedural;
  Memo.Lines.Add(s);
end;

end.


unit XMLBuilderU;

interface

uses
  System.Classes;

type
  TXMLBuilderRec = record
  private
    Buf: string;
    Level: Integer;
    CRLF: Boolean;
  public
    class function New: TXMLBuilderRec; static;
    function Open(const Tag: string): TXMLBuilderRec;
    function Close(const Tag: string): TXMLBuilderRec;
    function Add(const Tag, Value: string): TXMLBuilderRec;
    function SaveToString: string;
  end;

  TXMLBuilderObject = class(TComponent)
  private
    Buf: string;
    Level: Integer;
    CRLF: Boolean;
  public
    class function New: TXMLBuilderObject; static;
    function Open(const Tag: string): TXMLBuilderObject;
    function Close(const Tag: string): TXMLBuilderObject;
    function Add(const Tag, Value: string): TXMLBuilderObject;
    function SaveToString: string;
  end;

  IXMLBuilder = interface
    function Open(const Tag: string): IXMLBuilder;
    function Close(const Tag: string): IXMLBuilder;
    function Add(const Tag, Value: string): IXMLBuilder;
    function SaveToString: string;
  end;

  TXMLBuilder = class(TInterfacedObject, IXMLBuilder)
  private
    Buf: string;
    Level: Integer;
    CRLF: Boolean;
  public
    class function New: IXMLBuilder; static;
    function Open(const Tag: string): IXMLBuilder;
    function Close(const Tag: string): IXMLBuilder;
    function Add(const Tag, Value: string): IXMLBuilder;
    function SaveToString: string;
  end;

  IXMLBuilderUnsafe = interface
    [Result:unsafe] function Open(const Tag: string): IXMLBuilderUnsafe;
    [Result:unsafe] function Close(const Tag: string): IXMLBuilderUnsafe;
    [Result:unsafe] function Add(const Tag, Value: string): IXMLBuilderUnsafe;
    function SaveToString: string;
  end;

  TXMLBuilderUnsafe = class(TInterfacedObject, IXMLBuilderUnsafe)
  private
    Buf: string;
    Level: Integer;
    CRLF: Boolean;
  public
    class function New: IXMLBuilderUnsafe; static;
    [Result:unsafe] function Open(const Tag: string): IXMLBuilderUnsafe;
    [Result:unsafe] function Close(const Tag: string): IXMLBuilderUnsafe;
    [Result:unsafe] function Add(const Tag, Value: string): IXMLBuilderUnsafe;
    function SaveToString: string;
  end;

  IXMLBuilderProcedural = interface
    procedure Open(const Tag: string);
    procedure Close(const Tag: string);
    procedure Add(const Tag, Value: string);
    function SaveToString: string;
  end;

  TXMLBuilderProcedural = class(TInterfacedObject, IXMLBuilderProcedural)
  private
    Buf: string;
    Level: Integer;
    CRLF: Boolean;
  public
    class function New: IXMLBuilderProcedural; static;
    procedure Open(const Tag: string);
    procedure Close(const Tag: string);
    procedure Add(const Tag, Value: string);
    function SaveToString: string;
  end;

implementation

function LevelString(Level: Integer; CRLF: Boolean): string;
begin
  if CRLF then
    Result := #13#10 + StringOfChar(' ', Level * 2)
  else
    Result := StringOfChar(' ', Level * 2);
end;

{ TXMLBuilderRec }

class function TXMLBuilderRec.New: TXMLBuilderRec;
begin
  Result := Default(TXMLBuilderRec);
end;

function TXMLBuilderRec.Open(const Tag: string): TXMLBuilderRec;
begin
  Result := Self;
  Result.Buf := Result.Buf + LevelString(Level, CRLF) + '<' + Tag + '>';
  Result.CRLF := True;
  Inc(Result.Level);
end;

function TXMLBuilderRec.Close(const Tag: string): TXMLBuilderRec;
begin
  Result := Self;
  Dec(Result.Level);
  Result.Buf := Result.Buf + LevelString(Result.Level, CRLF) + '</' + Tag + '>'#13#10;
  Result.CRLF := False;
end;

function TXMLBuilderRec.Add(const Tag, Value: string): TXMLBuilderRec;
begin
  Result := Open(Tag);
  Result.Buf := Result.Buf + Value;
  Result.CRLF := False;
  Result.Level := 0;
  Result := Result.Close(Tag);
  Result.Level := Level;
end;

function TXMLBuilderRec.SaveToString: string;
begin
  Result := Buf;
end;

{ TXMLBuilderObject }

class function TXMLBuilderObject.New: TXMLBuilderObject;
begin
  Result := TXMLBuilderObject.Create(nil);
end;

function TXMLBuilderObject.Open(const Tag: string): TXMLBuilderObject;
begin
  Result := Self;
  Buf := Buf + LevelString(Level, CRLF) + '<' + Tag + '>';
  CRLF := True;
  Inc(Level);
end;

function TXMLBuilderObject.Close(const Tag: string): TXMLBuilderObject;
begin
  Result := Self;
  Dec(Level);
  Buf := Buf + LevelString(Level, CRLF) + '</' + Tag + '>'#13#10;
  CRLF := False;
end;

function TXMLBuilderObject.Add(const Tag, Value: string): TXMLBuilderObject;
var
  TmpLevel: Integer;
begin
  Result := Open(Tag);
  Buf := Buf + Value;
  CRLF := False;
  TmpLevel := Level;
  Level := 0;
  Close(Tag);
  Level := TmpLevel - 1;
end;

function TXMLBuilderObject.SaveToString: string;
begin
  Result := Buf;
  Free;
end;

{ TXMLBuilder }

class function TXMLBuilder.New: IXMLBuilder;
begin
  Result := TXMLBuilder.Create;
end;

function TXMLBuilder.Open(const Tag: string): IXMLBuilder;
begin
  Result := Self;
  Buf := Buf + LevelString(Level, CRLF) + '<' + Tag + '>';
  CRLF := True;
  Inc(Level);
end;

function TXMLBuilder.Close(const Tag: string): IXMLBuilder;
begin
  Result := Self;
  Dec(Level);
  Buf := Buf + LevelString(Level, CRLF) + '</' + Tag + '>'#13#10;
  CRLF := False;
end;

function TXMLBuilder.Add(const Tag, Value: string): IXMLBuilder;
var
  TmpLevel: Integer;
begin
  Result := Open(Tag);
  Buf := Buf + Value;
  CRLF := False;
  TmpLevel := Level;
  Level := 0;
  Close(Tag);
  Level := TmpLevel - 1;
end;

function TXMLBuilder.SaveToString: string;
begin
  Result := Buf;
end;

{ TXMLBuilderUnsafe }

class function TXMLBuilderUnsafe.New: IXMLBuilderUnsafe;
begin
  Result := TXMLBuilderUnsafe.Create;
end;

function TXMLBuilderUnsafe.Open(const Tag: string): IXMLBuilderUnsafe;
begin
  Result := Self;
  Buf := Buf + LevelString(Level, CRLF) + '<' + Tag + '>';
  CRLF := True;
  Inc(Level);
end;

function TXMLBuilderUnsafe.Close(const Tag: string): IXMLBuilderUnsafe;
begin
  Result := Self;
  Dec(Level);
  Buf := Buf + LevelString(Level, CRLF) + '</' + Tag + '>'#13#10;
  CRLF := False;
end;

function TXMLBuilderUnsafe.Add(const Tag, Value: string): IXMLBuilderUnsafe;
var
  TmpLevel: Integer;
begin
  Result := Open(Tag);
  Buf := Buf + Value;
  CRLF := False;
  TmpLevel := Level;
  Level := 0;
  Close(Tag);
  Level := TmpLevel - 1;
end;

function TXMLBuilderUnsafe.SaveToString: string;
begin
  Result := Buf;
end;

{ TXMLBuilderProcedural }

class function TXMLBuilderProcedural.New: IXMLBuilderProcedural;
begin
  Result := TXMLBuilderProcedural.Create;
end;

procedure TXMLBuilderProcedural.Open(const Tag: string);
begin
  Buf := Buf + LevelString(Level, CRLF) + '<' + Tag + '>';
  CRLF := True;
  Inc(Level);
end;

procedure TXMLBuilderProcedural.Close(const Tag: string);
begin
  Dec(Level);
  Buf := Buf + LevelString(Level, CRLF) + '</' + Tag + '>'#13#10;
  CRLF := False;
end;

procedure TXMLBuilderProcedural.Add(const Tag, Value: string);
var
  TmpLevel: Integer;
begin
  Open(Tag);
  Buf := Buf + Value;
  CRLF := False;
  TmpLevel := Level;
  Level := 0;
  Close(Tag);
  Level := TmpLevel - 1;
end;

function TXMLBuilderProcedural.SaveToString: string;
begin
  Result := Buf;
end;

end.


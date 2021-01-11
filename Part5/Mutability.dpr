program Mutability;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TImmutableRecord = record
  strict private
    FIntValue: Integer;
    FStrValue: string;
    FArrValue: TBytes;
  public
    constructor Create(AIntValue: Integer; const AStrValue: string; const AArrValue: TBytes);
    procedure Print;
    property IntValue: Integer read FIntValue;
    property StrValue: string read FStrValue;
  end;

constructor TImmutableRecord.Create(AIntValue: Integer; const AStrValue: string; const AArrValue: TBytes);
begin
  FIntValue := AIntValue;
  FStrValue := AStrValue;
  FArrValue := AArrValue;
end;

procedure TImmutableRecord.Print;
var
  b: Byte;
begin
  Write('Record: ', FIntValue, ' ', FStrValue, ' ');
  for b in FArrValue do
    Write(b, ' ');
  Writeln;
end;

procedure TestRecord;
var
  Data: TImmutableRecord;
  IntVal: Integer;
  StrVal: string;
  ArrVal: TBytes;
begin
  IntVal := 50;
  StrVal := 'abc';
  ArrVal := [1,2,3];

  Data := TImmutableRecord.Create(IntVal, StrVal, ArrVal);
  Data.Print;

  IntVal := 60;
  Delete(StrVal, 1, 1);
  Delete(ArrVal, 1, 1);

  Data.Print;
end;

begin
  try
    TestRecord;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.



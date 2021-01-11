program CaptureLoopsObject;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TContentObject = class(TObject)
  public
    Number: Integer;
    constructor Create(ANumber: Integer);
  end;

constructor TContentObject.Create(ANumber: Integer);
begin
  Number := ANumber;
end;

function CreateFunction(Value: TContentObject): TFunc<TContentObject>;
begin
  Result := function: TContentObject
    begin
      Result := Value;
    end;
end;

procedure Test;
var
  List: array of TContentObject;
  Functions: array of TFunc<TContentObject>;
  Func: TFunc<TContentObject>;
  i: Integer;
begin
  SetLength(List, 5);
  for i := 0 to high(List) do
    List[i] := TContentObject.Create(i);

  SetLength(Functions, 5);
  for i := 0 to high(Functions) do
    Functions[i] := CreateFunction(List[i]);

  for Func in Functions do
    Writeln(Func.Number);

  for i := 0 to high(List) do
    List[i].Free;
end;

begin
  Test;
  Readln;
end.

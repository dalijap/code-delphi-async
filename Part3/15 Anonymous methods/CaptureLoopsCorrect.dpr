program CaptureLoopsCorrect;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

function CreateFunction(Value: Integer): TFunc<Integer>;
begin
  Result :=
    function: Integer
    begin
      Result := Value;
    end;
end;

procedure Test;
var
  Functions: array of TFunc<Integer>;
  Func: TFunc<Integer>;
  i: Integer;
begin
  SetLength(Functions, 5);

  for i := 0 to high(Functions) do
    Functions[i] := CreateFunction(i);

  for Func in Functions do
    Writeln(Func());
end;

begin
  Test;
  Readln;
end.

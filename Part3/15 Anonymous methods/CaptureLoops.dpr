program CaptureLoops;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

procedure Test;
var
  Functions: array of TFunc<Integer>;
  Func: TFunc<Integer>;
  i: Integer;
begin
  SetLength(Functions, 5);
  for i := 0 to high(Functions) do
    Functions[i] :=
      function: Integer
      begin
        Result := i;
      end;

  for Func in Functions do
    Writeln(Func());
end;

begin
  Test;
  Readln;
end.

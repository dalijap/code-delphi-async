program CycleWeak;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

function Factorial(x: Integer): Integer;
var
  [weak]
  Func: TFunc<Integer, Integer>;
begin
  Func := function(Value: Integer): Integer
    begin
      if Value = 0 then
        Result := 1
      else
        Result := Value * Func(Value - 1)
    end;
  Result := Func(x);
end;

procedure Test;
var
  f: Integer;
begin
  f := Factorial(5);
  Writeln(f);
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.

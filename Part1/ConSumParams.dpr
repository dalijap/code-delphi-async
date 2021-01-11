program ConSumParams;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  X, Y, Sum: Integer;
begin
  X := StrToIntDef(ParamStr(1), 0);
  Y := StrToIntDef(ParamStr(2), 0);
  Sum := X + Y;
  Writeln('Sum: ', Sum);
  Readln;
end.


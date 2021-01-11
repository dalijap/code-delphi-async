program ConSumRead;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  X, Y, Sum: Integer;
begin
  Write('X: ');
  Readln(X);
  Write('Y: ');
  Readln(Y);
  Sum := X + Y;
  Writeln('Sum: ', Sum);
  Readln;
end.


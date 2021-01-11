program ConSumLoop;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

var
  X, Y, Sum: Integer;
  Done: Char;
begin
  repeat
    Write('X: ');
    Readln(X);
    Write('Y: ');
    Readln(Y);
    Sum := X + Y;
    Writeln('Sum: ', Sum);
    Writeln('Enter 0 to exit, enter to continue');
    Readln(Done);
  until Done = '0';
end.


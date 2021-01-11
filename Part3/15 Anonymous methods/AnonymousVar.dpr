program AnonymousVar;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousProc = reference to procedure;

procedure Execute(Proc: TAnonymousProc);
begin
  // Execute passed anonymous method
  Proc;
end;

procedure Test;
var
  Number: Integer;
begin
  Number := 42;

  Execute(procedure
    begin
      Writeln('Anything ', Number);
    end);

  Number := 0;

  Execute(procedure
    begin
      Writeln('Bang ', Number);
      Number := 42;
    end);

  Execute(procedure
    begin
      Writeln('Resurrected ', Number);
    end);
end;

begin
  Test;
  Readln;
end.


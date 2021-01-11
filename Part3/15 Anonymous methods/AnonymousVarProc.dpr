program AnonymousVarProc;

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
  Proc1, Proc2, Proc3: TAnonymousProc;
begin
  Number := 42;

  Proc1 := procedure
    begin
      Writeln('Anything ', Number);
    end;

  Number := 0;

  Proc2 := procedure
    begin
      Writeln('Bang ', Number);
      Number := 42;
    end;

  Proc3 := procedure
    begin
      Writeln('Resurrected ', Number);
    end;

  Execute(Proc1);
  Execute(Proc2);
  Execute(Proc3);
end;

begin
  Test;
  Readln;
end.


program Cycle1;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousProc = reference to procedure;

procedure Test;
var
  Proc1, Proc2: TAnonymousProc;
begin
  Proc1 := procedure
    begin
      Writeln('Procedure 1');
    end;
  Proc2 := procedure
    begin
      Proc1;
      Writeln('Procedure 2');
    end;
  Proc2;
  // comment following line to cause memory leak
  Proc1 := nil;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.

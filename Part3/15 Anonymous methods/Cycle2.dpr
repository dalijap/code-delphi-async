program Cycle2;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousProc = reference to procedure;

  TAnonymousRec = record
    Number: Integer;
    Proc: TAnonymousProc;
  end;

procedure Test;
var
  Rec: TAnonymousRec;
begin
  Rec.Number := 5;
  Rec.Proc := procedure
    begin
      Writeln(Rec.Number);
    end;
  Rec.Proc();
  Rec.Proc := nil;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.

program Cycle3;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousProc = reference to procedure;

  TAnonymousObject = class(TObject)
  public
    Number: Integer;
    Proc: TAnonymousProc;
  end;

procedure Test;
var
  Obj: TAnonymousObject;
begin
  Obj := TAnonymousObject.Create;
  try
    Obj.Number := 5;
    Obj.Proc := procedure
      begin
        Writeln(Obj.Number);
      end;
    Obj.Proc();
  finally
    Obj.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.

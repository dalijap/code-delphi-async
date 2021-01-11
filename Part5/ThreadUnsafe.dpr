program ThreadUnsafe;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes;

var
  Data: IInterface;

procedure Test;
var
  Tmp: IInterface;
  i, j: Integer;
begin
  for i := 0 to 1000 do
    begin
      Data := TInterfacedObject.Create;
      TThread.CreateAnonymousThread(
        procedure
        var
          i: Integer;
        begin
          for i := 0 to 10 do Sleep(15);
          Data := nil;
        end).Start;
      for j := 0 to 1000000 do
        begin
          Tmp := Data;
          if not Assigned(Tmp) then break;
          Tmp := nil;
        end;
    end;
end;

begin
  try
    Test;
  except
    on E: Exception do Writeln(E.ClassName, ': ', E.Message);
  end;
  Writeln('Finished');
end.

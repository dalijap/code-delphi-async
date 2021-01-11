program Anonymous1;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousStringFunc = reference to function: string;

function Composer: TAnonymousStringFunc;
var
  Text: string;
  Number: Integer;
begin
  Text := 'Number';
  Number := 5;
  Result := function: string
    begin
      Inc(Number);
      Result := Text + ' ' + IntToStr(Number);
    end;
end;

procedure Test;
var
  Ref1, Ref2: TAnonymousStringFunc;
  Str: string;
begin
  // Get anonymous method
  Ref1 := Composer();
  // Call anonymous method
  Str := Ref1;
  Writeln(Str);
  // Call anonymous method
  Str := Ref1;
  Writeln(Str);

  // Get anonymous method again
  Ref2 := Composer();
  // Call new anonymous method
  Str := Ref2;
  Writeln(Str);

  // Call first anonymous method again
  Str := Ref1;
  Writeln(Str);
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.


program Anonymous5;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousStringFunc = reference to function: string;

  TContentObject = class(TObject)
  public
    Text: string;
    Number: Integer;
    constructor Create(const AText: string; ANumber: Integer);
  end;

constructor TContentObject.Create(const AText: string; ANumber: Integer);
begin
  Text := AText;
  Number := ANumber;
end;

function Composer: TAnonymousStringFunc;
var
  Content: TContentObject;
begin
  Content := TContentObject.Create('Number', 5);
  Result := function: string
    begin
      Inc(Content.Number);
      Result := Content.Text + ' ' + IntToStr(Content.Number);
      Content.Free;
      Content := nil;
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

procedure Test2;
var
  Ref1, Ref2: TAnonymousStringFunc;
  Str: string;
begin
  Ref1 := Composer();
  Str := Ref1;
  Writeln(Str);

  Ref2 := Composer();
  Str := Ref2;
  Writeln(Str);
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  try
    Test2;
  except
  end;
  Readln;
end.


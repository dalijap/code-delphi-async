program Cycle4;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

type
  TAnonymousProc = reference to procedure;

type
  IAnonymousObject = interface
    function GetNumber: Integer;
    function GetProc: TAnonymousProc;
    procedure SetNumber(Value: Integer);
    procedure SetProc(Value: TAnonymousProc);
    property Number: Integer read GetNumber write SetNumber;
    property Proc: TAnonymousProc read GetProc write SetProc;
  end;

  TAnonymousObject = class(TInterfacedObject, IAnonymousObject)
  private
    FNumber: Integer;
    FProc: TAnonymousProc;
    function GetNumber: Integer;
    function GetProc: TAnonymousProc;
    procedure SetNumber(Value: Integer);
    procedure SetProc(Value: TAnonymousProc);
  public
    property Number: Integer read GetNumber write SetNumber;
    property Proc: TAnonymousProc read GetProc write SetProc;
  end;

function TAnonymousObject.GetNumber: Integer;
begin
  Result := FNumber;
end;

function TAnonymousObject.GetProc: TAnonymousProc;
begin
  Result := FProc;
end;

procedure TAnonymousObject.SetNumber(Value: Integer);
begin
  FNumber := Value;
end;

procedure TAnonymousObject.SetProc(Value: TAnonymousProc);
begin
  FProc := Value;
end;

procedure Test;
var
  Obj: IAnonymousObject;
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
    Obj := nil;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := true;
  Test;
end.

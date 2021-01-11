unit IntegerList;

interface

uses
  System.SysUtils,
  System.SyncObjs;

type
  TIntegerList = class
  protected
    FLock: TCriticalSection;
    FItems: array of Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(Value: Integer);
    function Exists(Value: Integer): Boolean;
  end;

implementation

constructor TIntegerList.Create;
begin
  inherited;
  FLock := TCriticalSection.Create;
end;

destructor TIntegerList.Destroy;
begin
  FLock.Free;
  inherited;
end;

procedure TIntegerList.Add(Value: Integer);
begin
  FLock.Enter;
  try
    SetLength(FItems, Length(FItems) + 1);
    FItems[high(FItems)] := Value;
  finally
    FLock.Leave;
  end;
end;

function TIntegerList.Exists(Value: Integer): Boolean;
var
  X: Integer;
begin
  Result := False;
  FLock.Enter;
  try
    for X in FItems do
      if X = Value then
        begin
          Result := True;
          break;
        end;
  finally
    FLock.Leave;
  end;
end;

end.

unit InitializationPattern;

interface

uses
  System.SysUtils,
  System.SyncObjs;

type
  TFoo = class
  end;

  TFooFactory = class
  private
    class var FInstance: TFoo;
    class destructor ClassDestroy;
    class function GetInstance: TFoo;
  public
    property Instance: TFoo read GetInstance;
  end;

implementation

class destructor TFooFactory.ClassDestroy;
begin
  FreeAndNil(FInstance);
end;

class function TFooFactory.GetInstance: TFoo;
var
  LInstance: TFoo;
begin
  if FInstance = nil then
  begin
    LInstance := TFoo.Create;
    if TInterlocked.CompareExchange<TFoo>(FInstance, LInstance, nil) <> nil then
      LInstance.Free;
  end;
  Result := FInstance;
end;

end.


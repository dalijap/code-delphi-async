unit NX.Core;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Defaults,
  System.TypInfo;

type
  // https://blog.therealoracleatdelphi.com/2008/09/a-post_18.html

  Nullable<T> = record
  strict private
    fIsAssigned: IInterface;
    fValue: T;
    function GetValue: T;
    function GetIsAssigned: boolean;
    function GetIsNull: boolean;
  public
    constructor Create(aValue: T);
    procedure Clear;
    function GetValueOrDefault: T; overload;
    function GetValueOrDefault(Default: T): T; overload;
    property IsAssigned: boolean read GetIsAssigned;
    property IsNull: boolean read GetIsNull;
    property Value: T read GetValue;

    class operator Implicit(Value: Nullable<T>): T;
    class operator Implicit(Value: T): Nullable<T>;
    class operator Explicit(Value: Nullable<T>): T;
    class operator NotEqual(const Left, Right: Nullable<T>): boolean;
    class operator Equal(const Left, Right: Nullable<T>): boolean;
  end;

procedure FakeInterface(var Intf: IInterface);

implementation

{$REGION '***** Fake Interface *****'}

function NopAddRef(Inst: Pointer): integer; stdcall;
begin
  Result := -1;
end;

function NopRelease(Inst: Pointer): integer; stdcall;
begin
  Result := -1;
end;

function NopQueryInterface(Inst: Pointer; const IID: TGUID; out Obj): HResult; stdcall;
begin
  Result := E_NOINTERFACE;
end;

const
  FakeInterfaceVTable: array [0 .. 2] of Pointer = (@NopQueryInterface, @NopAddRef, @NopRelease);
  FakeInterfaceInstance: Pointer = @FakeInterfaceVTable;

procedure FakeInterface(var Intf: IInterface);
begin
  Intf := IInterface(@FakeInterfaceInstance);
end;

{$ENDREGION '***** Fake Interface *****'}

{$REGION '***** Nullable<T> *****'}

constructor Nullable<T>.Create(aValue: T);
begin
  fValue := aValue;
  FakeInterface(fIsAssigned);
end;

procedure Nullable<T>.Clear;
begin
  fIsAssigned := nil;
end;

function Nullable<T>.GetIsAssigned: boolean;
begin
  Result := fIsAssigned <> nil;
end;

function Nullable<T>.GetIsNull: boolean;
begin
  Result := fIsAssigned = nil;
end;

function Nullable<T>.GetValue: T;
begin
  if not IsAssigned then raise Exception.Create('Invalid operation, Nullable type has no value');
  Result := fValue;
end;

function Nullable<T>.GetValueOrDefault: T;
begin
  if IsAssigned then Result := fValue
  else Result := default(T);
end;

function Nullable<T>.GetValueOrDefault(Default: T): T;
begin
  if not IsAssigned then Result := default
  else Result := fValue;
end;

class operator Nullable<T>.Explicit(Value: Nullable<T>): T;
begin
  Result := Value.Value;
end;

class operator Nullable<T>.Implicit(Value: Nullable<T>): T;
begin
  Result := Value.Value;
end;

class operator Nullable<T>.Implicit(Value: T): Nullable<T>;
begin
  Result := Nullable<T>.Create(Value);
end;

class operator Nullable<T>.Equal(const Left, Right: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if Left.IsAssigned and Right.IsAssigned then
    begin
      Comparer := TEqualityComparer<T>.Default;
      Result := Comparer.Equals(Left.Value, Right.Value);
    end
  else Result := Left.IsAssigned = Right.IsAssigned;
end;

class operator Nullable<T>.NotEqual(const Left, Right: Nullable<T>): boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if Left.IsAssigned and Right.IsAssigned then
    begin
      Comparer := TEqualityComparer<T>.Default;
      Result := not Comparer.Equals(Left.Value, Right.Value);
    end
  else Result := Left.IsAssigned <> Right.IsAssigned;
end;

{$ENDREGION '***** Nullable<T> *****'}

end.



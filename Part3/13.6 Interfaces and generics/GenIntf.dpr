program GenIntf;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes;

type
  IGen<T> = interface
  ['{AF9649A9-B068-442A-9A7C-1BD52B4047D8}']
    function Description: string;
  end;

  TGen<T> = class(TInterfacedObject, IGen<T>)
  public
    function Description: string;
  end;

function TGen<T>.Description: string;
begin
  Result := ClassName;
end;

function IsStringIntf(const Intf: IInterface): boolean;
var
  IG: IGen<string>;
begin
  Result := Supports(Intf, IGen<string>, IG);
  if Result then
    Writeln(IG.Description)
  else
    Writeln('Not String');
end;

procedure Test;
var
  IntegerIntf: IGen<Integer>;
  StringIntf: IGen<string>;
  ObjectIntf: IGen<TObject>;

  Intf: IInterface;
begin
  IntegerIntf := TGen<Integer>.Create;
  StringIntf := TGen<string>.Create;
  ObjectIntf := TGen<TObject>.Create;

  IsStringIntf(ObjectIntf);
  IsStringIntf(IntegerIntf);
  IsStringIntf(StringIntf);

  Intf := StringIntf;
  ObjectIntf := Intf as IGen<TObject>;

  Writeln('This is Object: ', ObjectIntf.Description);
end;

begin
  try
    Test;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  Readln;
end.


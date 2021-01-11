unit XMLBuilderIntfU;

interface

type
  IXMLBuilder = interface
    [Result:unsafe] function Open(const Tag: string): IXMLBuilder;
    [Result:unsafe] function Close(const Tag: string): IXMLBuilder;
    [Result:unsafe] function Add(const Tag, Value: string): IXMLBuilder;
    function SaveToString: string;
  end;

  TXMLBuilder = class
  public
    class function New: IXMLBuilder; static;
  end;

implementation

type
  TXMLBuilderImpl = class(TInterfacedObject, IXMLBuilder)
  private
    Buf: string;
  public
    [Result:unsafe] function Open(const Tag: string): IXMLBuilder;
    [Result:unsafe] function Close(const Tag: string): IXMLBuilder;
    [Result:unsafe] function Add(const Tag, Value: string): IXMLBuilder;
    function SaveToString: string;
  end;

class function TXMLBuilder.New: IXMLBuilder;
begin
  Result := TXMLBuilderImpl.Create;
end;

{ TXMLBuilderImpl }

function TXMLBuilderImpl.Open(const Tag: string): IXMLBuilder;
begin
  Result := Self;
  // ...
end;

function TXMLBuilderImpl.Close(const Tag: string): IXMLBuilder;
begin
  Result := Self;
  // ...
end;

function TXMLBuilderImpl.Add(const Tag, Value: string): IXMLBuilder;
begin
  Result := Self;
  // ...
end;

function TXMLBuilderImpl.SaveToString: string;
begin
  Result := Buf;
end;

end.

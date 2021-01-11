unit NX.GenFuture;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  NX.Core;

type
  TNxFutureResult<V> = record
  public
    Value: Nullable<V>;
    Error: string;
    function IsNull: boolean;
  end;

  INxFuture<V> = interface;
  INxPromise<V> = interface;

  TNxCompletedCallback<V> = reference to procedure(const aResult: TNxFutureResult<V>);
  TNxThenPromiseCallback<V, T> = reference to procedure(const aPromise: INxPromise<T>; const aValue: V);
  TNxAsyncPromiseCallback<V> = reference to procedure(const aPromise: INxPromise<V>);

  INxFuture<V> = interface
    function Sync: INxFuture<V>;
    function OnCompleted(const aCallback: TNxCompletedCallback<V>): INxFuture<V>;
  end;

  INxPromise<V> = interface(INxFuture<V>)
    procedure Resolve(const aValue: V);
    procedure Reject(const aError: string);
  end;

  TNxFuture<V> = class(TInterfacedObject, INxFuture<V>)
  strict protected
    fResult: TNxFutureResult<V>;
    fSync: Boolean;
    fCompletedCallback: TNxCompletedCallback<V>;
    procedure SetResult(const aResult: TNxFutureResult<V>);
    procedure DoCompleted;
  public
    function Sync: INxFuture<V>;
    function OnCompleted(const aCallback: TNxCompletedCallback<V>): INxFuture<V>;
    function Then_<T>(const aCallback: TNxThenPromiseCallback<V, T>): INxFuture<T>;
    class function Async(const aCallback: TNxAsyncPromiseCallback<V>): INxFuture<V>; static;
  end;

  TNxPromise<V> = class(TNxFuture<V>, INxPromise<V>)
  public
    procedure Resolve(const aValue: V);
    procedure Reject(const aError: string);
  end;

implementation

{ TNxFutureResult<V> }

function TNxFutureResult<V>.IsNull: boolean;
begin
  Result := Value.IsNull and Error.IsEmpty;
end;

{ TNxFuture<V> }

procedure TNxFuture<V>.SetResult(const aResult: TNxFutureResult<V>);
begin
  fResult := aResult;
  if fSync then
    TThread.Synchronize(nil,
      procedure
      begin
        DoCompleted;
      end)
  else
    DoCompleted;
end;

function TNxFuture<V>.Sync: INxFuture<V>;
begin
  Result := Self;
  fSync := True;
end;

function TNxFuture<V>.Then_<T>(const aCallback: TNxThenPromiseCallback<V, T>): INxFuture<T>;
var
  Promise: INxPromise<T>;
begin
  Promise := TNxPromise<T>.Create;
  Result := Promise;
  OnCompleted(
    procedure(const aResult: TNxFutureResult<V>)
    begin
      if aResult.Error.IsEmpty then
        try
          aCallback(Promise, aResult.Value);
        except
          on E: Exception do
            Promise.Reject(E.Message);
        end
      else
        Promise.Reject(aResult.Error);
    end);
end;

procedure TNxFuture<V>.DoCompleted;
begin
  if Assigned(fCompletedCallback) then
    fCompletedCallback(fResult);
  fCompletedCallback := nil;
end;

function TNxFuture<V>.OnCompleted(const aCallback: TNxCompletedCallback<V>): INxFuture<V>;
begin
  Result := Self;
  if fResult.IsNull then
    fCompletedCallback := aCallback
  else
    aCallback(fResult);
end;

class function TNxFuture<V>.Async(const aCallback: TNxAsyncPromiseCallback<V>): INxFuture<V>;
var
  Promise: INxPromise<V>;
begin
  Promise := TNxPromise<V>.Create;
  Result := Promise;
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        aCallback(Promise);
      except
        on E: Exception do
          Promise.Reject(E.Message);
      end;
    end).Start;
end;

{ TNxPromise<V> }

procedure TNxPromise<V>.Resolve(const aValue: V);
var
  Result: TNxFutureResult<V>;
begin
  Result.Value := aValue;
  SetResult(Result);
end;

procedure TNxPromise<V>.Reject(const aError: string);
var
  Result: TNxFutureResult<V>;
begin
  Result.Error := aError;
  SetResult(Result);
end;

end.

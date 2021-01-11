unit NX.Future;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti;

type
  TNxFutureResult = record
  public
    Value: TValue;
    Error: string;
    function IsNull: boolean;
  end;

  INxFuture = interface;
  INxPromise = interface;

  TNxCompletedCallback = reference to procedure(const aResult: TNxFutureResult);
  TNxSuccessCallback = reference to procedure(const aValue: TValue);
  TNxFailureCallback = reference to procedure(const aError: string);
  TNxAsyncCallback = reference to procedure(const aPromise: INxPromise);
  TNxThenCallback = reference to procedure(const aPromise: INxPromise; const aValue: TValue);

  INxFuture = interface
    [Result:unsafe]
    function Sync: INxFuture;
    [Result:unsafe]
    function OnCompleted(const aCallback: TNxCompletedCallback): INxFuture;
    [Result:unsafe]
    function OnSuccess(const aCallback: TNxSuccessCallback): INxFuture;
    [Result:unsafe]
    function OnFailure(const aCallback: TNxFailureCallback): INxFuture;
    function Then_(const aCallback: TNxThenCallback): INxFuture;
  end;

  INxPromise = interface(INxFuture)
    procedure Resolve(const aValue: TValue);
    procedure Reject(const aError: string);
  end;

  TNxFuture = class(TInterfacedObject, INxFuture)
  strict protected
    fResult: TNxFutureResult;
    fSync: Boolean;
    fCompletedCallback: TNxCompletedCallback;
    fSuccessCallback: TNxSuccessCallback;
    fFailureCallback: TNxFailureCallback;

    procedure SetResult(const aResult: TNxFutureResult);
    procedure DoCompleted;
    procedure DoSuccess;
    procedure DoFailure;
  public
    [Result:unsafe]
    function Sync: INxFuture;
    [Result:unsafe]
    function OnCompleted(const aCallback: TNxCompletedCallback): INxFuture;
    [Result:unsafe]
    function OnSuccess(const aCallback: TNxSuccessCallback): INxFuture;
    [Result:unsafe]
    function OnFailure(const aCallback: TNxFailureCallback): INxFuture;
    function Then_(const aCallback: TNxThenCallback): INxFuture;
    class function Async(const aCallback: TNxAsyncCallback): INxFuture; static;
  end;

  TNxPromise = class(TNxFuture, INxPromise)
  public
    procedure Resolve(const aValue: TValue);
    procedure Reject(const aError: string);
  end;

implementation

{ TNxFutureResult }

function TNxFutureResult.IsNull: boolean;
begin
  Result := Value.IsEmpty and Error.IsEmpty;
end;

{ TNxFuture }

procedure TNxFuture.SetResult(const aResult: TNxFutureResult);
begin
  fResult := aResult;
  if fSync then
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          if not fResult.Value.IsEmpty then
            DoSuccess
          else
            DoFailure;
          DoCompleted;
        end);
    end
  else
    begin
      if not fResult.Value.IsEmpty then
        DoSuccess
      else
        DoFailure;
      DoCompleted;
    end;
end;

function TNxFuture.Sync: INxFuture;
begin
  Result := Self;
  fSync := True;
end;

function TNxFuture.Then_(const aCallback: TNxThenCallback): INxFuture;
var
  Promise: INxPromise;
begin
  Promise := TNxPromise.Create;
  Result := Promise;
  OnSuccess(
    procedure(const aValue: TValue)
    begin
      try
        aCallback(Promise, aValue);
      except
        on E: Exception do
          Promise.Reject(E.Message);
      end;
    end);
  OnFailure(
    procedure(const aError: string)
    begin
      Promise.Reject(aError);
    end);
end;

procedure TNxFuture.DoCompleted;
begin
  if Assigned(fCompletedCallback) then
    fCompletedCallback(fResult);
  fCompletedCallback := nil;
end;

procedure TNxFuture.DoSuccess;
begin
  if Assigned(fSuccessCallback) then
    fSuccessCallback(fResult.Value);
  fSuccessCallback := nil;
end;

procedure TNxFuture.DoFailure;
begin
  if Assigned(fFailureCallback) then
    fFailureCallback(fResult.Error);
  fFailureCallback := nil;
end;

function TNxFuture.OnCompleted(const aCallback: TNxCompletedCallback): INxFuture;
begin
  Result := Self;
  if fResult.IsNull then
    fCompletedCallback := aCallback
  else
    aCallback(fResult);
end;

function TNxFuture.OnSuccess(const aCallback: TNxSuccessCallback): INxFuture;
begin
  Result := Self;
  if fResult.IsNull then
    fSuccessCallback := aCallback
  else
  if not fResult.Value.IsEmpty then
    aCallback(fResult.Value);
end;

function TNxFuture.OnFailure(const aCallback: TNxFailureCallback): INxFuture;
begin
  Result := Self;
  if fResult.IsNull then
    fFailureCallback := aCallback
  else
  if not fResult.Error.IsEmpty then
    aCallback(fResult.Error);
end;

class function TNxFuture.Async(const aCallback: TNxAsyncCallback): INxFuture;
var
  Promise: INxPromise;
begin
  Promise := TNxPromise.Create;
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

{ TNxPromise }

procedure TNxPromise.Resolve(const aValue: TValue);
var
  Result: TNxFutureResult;
begin
  Result.Value := aValue;
  SetResult(Result);
end;

procedure TNxPromise.Reject(const aError: string);
var
  Result: TNxFutureResult;
begin
  Result.Error := aError;
  SetResult(Result);
end;

end.

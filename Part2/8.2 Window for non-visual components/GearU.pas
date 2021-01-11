unit GearU;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes;

const
  CM_MY_EVENT = WM_USER + 100;

type
  TGear = class(TObject)
  protected
    FWndHandle: THandle;
    procedure WndProc(var Msg: TMessage); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    property WndHandle: THandle read FWndHandle;
  end;

implementation

constructor TGear.Create;
begin
  inherited;
  FWndHandle := AllocateHWnd(WndProc);
end;

destructor TGear.Destroy;
begin
  DeallocateHWnd(FWndHandle);
  inherited;
end;

procedure TGear.WndProc(var Msg: TMessage);
begin
  case Msg.Msg of
    CM_MY_EVENT:
      begin
        OutputDebugString('GEAR MY EVENT');
      end;
    else
      // mandatory call to default message handler
      Msg.Result := DefWindowProc(FWndHandle, Msg.Msg, Msg.wParam, Msg.lParam);
  end;
end;

end.

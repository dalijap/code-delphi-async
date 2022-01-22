program WinApp;

{$R *.res}

uses
  System.SysUtils,
  Winapi.Windows,
  Winapi.Messages;

var
  AppHandle: HWND;
  AppWndClass: WNDCLASS;
  AppMsg: MSG;

const
  APP_CLASS_NAME = 'HelloWorldClass';
  APP_TITLE = 'Hello World';


function AppWndProc(WndHandle: HWND; uMsg: UINT; wp: wParam; lp: lParam): LRESULT; stdcall;
begin
  case uMsg of
    WM_DESTROY:
      begin
        if WndHandle = AppHandle then
          PostQuitMessage(0);
        Result := 0;
      end;
    else Result := DefWindowProc(WndHandle, uMsg, wp, lp);
  end;
end;

begin
  FillChar(AppWndClass, SizeOf(AppWndClass), 0);
  AppWndClass.lpfnWndProc := @AppWndProc;
  AppWndClass.hInstance := hInstance;
  AppWndClass.lpszClassName := APP_CLASS_NAME;

  RegisterClass(AppWndClass);

  AppHandle := CreateWindowEx(0, // Optional window styles.
    APP_CLASS_NAME,              // Window class
    APP_TITLE,                   // Window title
    WS_OVERLAPPEDWINDOW,         // Window style

    // Size and position
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), 480, 320,

    0,                           // Parent window
    0,                           // Menu
    hInstance,                   // Instance handle
    nil                          // Additional application data
    );

  if AppHandle = 0 then
    Exit;

  ShowWindow(AppHandle, CmdShow);

  while GetMessage(AppMsg, 0, 0, 0) do
    begin
      TranslateMessage(AppMsg);
      DispatchMessage(AppMsg);
    end;

end.


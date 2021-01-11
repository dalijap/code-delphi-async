object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 122
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 6
  Padding.Top = 6
  Padding.Right = 6
  Padding.Bottom = 6
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GUIDestroyBtn: TButton
    Left = 9
    Top = 9
    Width = 250
    Height = 25
    Caption = '35.2.1 Don'#8217't destroy the GUI'
    TabOrder = 0
    OnClick = GUIDestroyBtnClick
  end
  object GuardianBtn: TButton
    Left = 9
    Top = 45
    Width = 250
    Height = 25
    Caption = '35.2.2 Use guardian interface'
    TabOrder = 1
    OnClick = GuardianBtnClick
  end
  object WaitBtn: TButton
    Left = 9
    Top = 82
    Width = 250
    Height = 25
    Caption = '35.2.4 Waiting for a thread'
    TabOrder = 2
    OnClick = WaitBtnClick
  end
end

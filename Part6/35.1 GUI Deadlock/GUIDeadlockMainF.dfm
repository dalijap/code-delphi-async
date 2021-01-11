object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 281
  ClientWidth = 464
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
  object Panel1: TPanel
    Left = 6
    Top = 6
    Width = 452
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 3
    ExplicitTop = 9
    object Deadlock1Btn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = '35.1.1 Deadlock'
      TabOrder = 0
      OnClick = Deadlock1BtnClick
    end
    object Deadlock2Btn: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = '35.1.2 Deadlock'
      TabOrder = 1
      OnClick = Deadlock2BtnClick
    end
    object Deadlock3Btn: TButton
      Left = 220
      Top = 6
      Width = 100
      Height = 25
      Caption = '35.1.3 Deadlock'
      TabOrder = 2
      OnClick = Deadlock3BtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 452
    Height = 234
    Align = alClient
    TabOrder = 1
  end
end

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
    object SendBtn: TButton
      Left = 200
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Send Message'
      TabOrder = 2
      OnClick = SendBtnClick
    end
    object SubscribeBtn: TButton
      Left = 8
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Subscribe'
      TabOrder = 0
      OnClick = SubscribeBtnClick
    end
    object UnsubscribeBtn: TButton
      Left = 104
      Top = 4
      Width = 90
      Height = 25
      Caption = 'Unsubscribe'
      TabOrder = 1
      OnClick = UnsubscribeBtnClick
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

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
    object FutureBtn: TButton
      Left = 8
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Future'
      TabOrder = 0
      OnClick = FutureBtnClick
    end
    object RejectedFutureBtn: TButton
      Left = 114
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Rejected Future'
      TabOrder = 1
      OnClick = RejectedFutureBtnClick
    end
    object MultipleFuturesBtn: TButton
      Left = 220
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Multiple Futures'
      TabOrder = 2
      OnClick = MultipleFuturesBtnClick
    end
    object HandlersBtn: TButton
      Left = 326
      Top = 4
      Width = 100
      Height = 25
      Caption = 'Handlers'
      TabOrder = 3
      OnClick = HandlersBtnClick
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

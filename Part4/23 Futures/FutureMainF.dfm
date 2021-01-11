object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 441
  ClientWidth = 624
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
    Width = 612
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 452
    object BlockingFutureBtn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Blocking Future'
      TabOrder = 0
      OnClick = BlockingFutureBtnClick
    end
    object SingleFutureBtn: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Single Future'
      TabOrder = 1
      OnClick = SingleFutureBtnClick
    end
    object MultipleFutures1Btn: TButton
      Left = 220
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Multiple Futures 1'
      TabOrder = 2
      OnClick = MultipleFutures1BtnClick
    end
    object SingleFutureMultiValuesBtn: TButton
      Left = 346
      Top = 6
      Width = 140
      Height = 25
      Caption = 'Single Future Multi Values'
      TabOrder = 3
      OnClick = SingleFutureMultiValuesBtnClick
    end
    object MultipleFutures2Btn: TButton
      Left = 492
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Multiple Futures 2'
      TabOrder = 4
      OnClick = MultipleFutures2BtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 612
    Height = 394
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 452
    ExplicitHeight = 234
  end
end

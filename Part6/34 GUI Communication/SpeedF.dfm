object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
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
    object SlowTaskBtn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Slow Task'
      TabOrder = 0
      OnClick = SlowTaskBtnClick
    end
    object FastTaskBtn: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = 'FastTaskBtn'
      TabOrder = 1
      OnClick = FastTaskBtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 612
    Height = 394
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 129
    ExplicitWidth = 489
    ExplicitHeight = 359
  end
end

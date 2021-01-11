object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
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
  OnClose = FormClose
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
    object TaskBtn: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Task'
      TabOrder = 0
      OnClick = TaskBtnClick
    end
    object CancelBtn: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = CancelBtnClick
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

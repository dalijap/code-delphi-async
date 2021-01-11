object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
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
    object TaskBtn: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Task'
      TabOrder = 0
      OnClick = TaskBtnClick
    end
  end
  object Memo: TMemo
    Left = 129
    Top = 41
    Width = 489
    Height = 359
    Align = alClient
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 6
    Top = 400
    Width = 612
    Height = 35
    Align = alBottom
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    object ProgressLabel: TLabel
      Left = 172
      Top = 12
      Width = 67
      Height = 13
      Caption = 'ProgressLabel'
    end
    object ProgressBar: TProgressBar
      Left = 8
      Top = 8
      Width = 150
      Height = 17
      TabOrder = 0
    end
  end
  object ListView: TListView
    Left = 6
    Top = 41
    Width = 123
    Height = 359
    Align = alLeft
    Columns = <>
    TabOrder = 3
  end
end

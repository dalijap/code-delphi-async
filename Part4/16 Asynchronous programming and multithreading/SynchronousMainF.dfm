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
    object ForceBtn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Force Queue'
      TabOrder = 0
      OnClick = ForceBtnClick
    end
    object ProcessBtn: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Process Messages'
      TabOrder = 1
      OnClick = ProcessBtnClick
    end
    object CancelBtn: TButton
      Left = 224
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
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

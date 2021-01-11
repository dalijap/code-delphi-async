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
    object BlockingBtn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Blocking'
      TabOrder = 0
      OnClick = BlockingBtnClick
    end
    object ReentrantProcessMsgBtn: TButton
      Left = 114
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Reentrant Process Msg'
      TabOrder = 1
      OnClick = ReentrantProcessMsgBtnClick
    end
    object ProcessMsgBtn: TButton
      Left = 240
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Process Messages'
      TabOrder = 2
      OnClick = ProcessMsgBtnClick
    end
    object UIBtn: TButton
      Left = 472
      Top = 6
      Width = 100
      Height = 25
      Caption = 'Disable UI'
      TabOrder = 4
      OnClick = UIBtnClick
    end
    object ProcessingBtn: TButton
      Left = 366
      Top = 6
      Width = 100
      Height = 25
      Caption = 'ProcessingBtn'
      TabOrder = 3
      OnClick = ProcessingBtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 612
    Height = 394
    Align = alClient
    TabOrder = 1
  end
end

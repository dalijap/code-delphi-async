object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 441
  ClientWidth = 870
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
    Width = 858
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 612
    object AnonymousBtn: TButton
      Left = 8
      Top = 6
      Width = 140
      Height = 25
      Caption = '20.1 Anonymous thread'
      TabOrder = 0
      OnClick = AnonymousBtnClick
    end
    object ExtendingBtn: TButton
      Left = 154
      Top = 6
      Width = 140
      Height = 25
      Caption = '20.2 Extending thread'
      TabOrder = 1
      OnClick = ExtendingBtnClick
    end
    object ReentrancyBtn: TButton
      Left = 300
      Top = 6
      Width = 140
      Height = 25
      Caption = '20.3 Thread reentrancy'
      TabOrder = 2
      OnClick = ReentrancyBtnClick
    end
    object OnTerminateBtn: TButton
      Left = 446
      Top = 6
      Width = 140
      Height = 25
      Caption = '20.4 20.5 OnTerminate'
      TabOrder = 3
      OnClick = OnTerminateBtnClick
    end
    object CancelingBtn: TButton
      Left = 592
      Top = 6
      Width = 110
      Height = 25
      Caption = '20.6 Canceling'
      TabOrder = 4
      OnClick = CancelingBtnClick
    end
    object CancelBtn: TButton
      Left = 708
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 5
      OnClick = CancelBtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 858
    Height = 353
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 612
  end
  object Panel2: TPanel
    Left = 6
    Top = 394
    Width = 858
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 
      'WARNING - Closing form while threads are running can cause AV - ' +
      'this example does not handle GUI destruction'
    TabOrder = 2
    ExplicitWidth = 612
  end
end

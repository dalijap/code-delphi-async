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
    object RecordBtn: TButton
      Left = 8
      Top = 6
      Width = 88
      Height = 25
      Caption = 'Record'
      TabOrder = 0
      OnClick = RecordBtnClick
    end
    object ObjectBtn: TButton
      Left = 102
      Top = 6
      Width = 88
      Height = 25
      Caption = 'Object'
      TabOrder = 1
      OnClick = ObjectBtnClick
    end
    object InterfaceBtn: TButton
      Left = 196
      Top = 6
      Width = 88
      Height = 25
      Caption = 'Interface'
      TabOrder = 2
      OnClick = InterfaceBtnClick
    end
    object InterfaceUnsafeBtn: TButton
      Left = 290
      Top = 6
      Width = 120
      Height = 25
      Caption = 'Optimized Interface'
      TabOrder = 3
      OnClick = InterfaceUnsafeBtnClick
    end
    object WithBtn: TButton
      Left = 416
      Top = 6
      Width = 88
      Height = 25
      Caption = 'With'
      TabOrder = 4
      OnClick = WithBtnClick
    end
    object ProceduralBtn: TButton
      Left = 510
      Top = 6
      Width = 88
      Height = 25
      Caption = 'Procedural'
      TabOrder = 5
      OnClick = ProceduralBtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 612
    Height = 394
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
end

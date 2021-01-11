object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 201
  ClientWidth = 304
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
    Width = 292
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 452
    object MessageBtn: TButton
      Left = 8
      Top = 6
      Width = 90
      Height = 25
      Caption = 'Post Message'
      TabOrder = 0
      OnClick = MessageBtnClick
    end
  end
end

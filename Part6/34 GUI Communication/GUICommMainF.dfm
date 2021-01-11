object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 155
  ClientWidth = 279
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
  object ProgressBtn: TButton
    Left = 9
    Top = 9
    Width = 260
    Height = 25
    Caption = '34.1.2 Updating progress counter or description'
    TabOrder = 0
    OnClick = ProgressBtnClick
  end
  object ControlsBtn: TButton
    Left = 9
    Top = 45
    Width = 260
    Height = 25
    Caption = '34.1.3 Iteratively creating and populating controls'
    TabOrder = 1
    OnClick = ControlsBtnClick
  end
  object SpeedBtn: TButton
    Left = 9
    Top = 82
    Width = 260
    Height = 25
    Caption = '34.2 Speeding up GUI controls'
    TabOrder = 2
    OnClick = SpeedBtnClick
  end
  object MessagingBtn: TButton
    Left = 9
    Top = 118
    Width = 260
    Height = 25
    Caption = '34.3.1 Using System.Messaging'
    TabOrder = 3
    OnClick = MessagingBtnClick
  end
end

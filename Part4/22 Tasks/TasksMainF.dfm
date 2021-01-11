object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 441
  ClientWidth = 656
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
    Width = 644
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object TaskBtn: TButton
      Left = 8
      Top = 6
      Width = 100
      Height = 25
      Caption = '22 Task'
      TabOrder = 0
      OnClick = TaskBtnClick
    end
    object TaskProcBtn: TButton
      Left = 114
      Top = 6
      Width = 100
      Height = 25
      Caption = '22 Task Proc'
      TabOrder = 1
      OnClick = TaskProcBtnClick
    end
    object TaskLifetimeBtn: TButton
      Left = 220
      Top = 6
      Width = 100
      Height = 25
      Caption = '22.2 Task lifetime'
      TabOrder = 2
      OnClick = TaskLifetimeBtnClick
    end
    object WaitTaskBtn: TButton
      Left = 326
      Top = 6
      Width = 100
      Height = 25
      Caption = '22.3 Wait for task'
      TabOrder = 3
      OnClick = WaitTaskBtnClick
    end
    object ParallelJoinBtn: TButton
      Left = 432
      Top = 6
      Width = 100
      Height = 25
      Caption = '22.7 Parallel Join'
      TabOrder = 4
      OnClick = ParallelJoinBtnClick
    end
    object ParallelForBtn: TButton
      Left = 538
      Top = 6
      Width = 100
      Height = 25
      Caption = '22.7 Parallel For'
      TabOrder = 5
      OnClick = ParallelForBtnClick
    end
  end
  object Memo: TMemo
    Left = 6
    Top = 41
    Width = 644
    Height = 394
    Align = alClient
    TabOrder = 1
  end
end

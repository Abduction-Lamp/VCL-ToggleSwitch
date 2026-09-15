object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'TFluentToggleSwitch Demo'
  ClientHeight = 423
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 192
  TextHeight = 32
  object GridPanel: TGridPanel
    AlignWithMargins = True
    Left = 12
    Top = 6
    Width = 910
    Height = 411
    Margins.Left = 12
    Margins.Top = 6
    Margins.Right = 12
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAbsolute
        Value = 48.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Label1
        Row = 0
      end
      item
        Column = 1
        Control = FluentToggleSwitch1
        Row = 0
      end
      item
        Column = 3
        Control = Label6
        Row = 0
      end
      item
        Column = 4
        Control = FluentToggleSwitch6
        Row = 0
      end
      item
        Column = 0
        Control = Label2
        Row = 1
      end
      item
        Column = 1
        Control = FluentToggleSwitch2
        Row = 1
      end
      item
        Column = 3
        Control = Label7
        Row = 1
      end
      item
        Column = 4
        Control = FluentToggleSwitch7
        Row = 1
      end
      item
        Column = 0
        Control = Label3
        Row = 2
      end
      item
        Column = 1
        Control = FluentToggleSwitch3
        Row = 2
      end
      item
        Column = 3
        Control = Label8
        Row = 2
      end
      item
        Column = 4
        Control = FluentToggleSwitch8
        Row = 2
      end
      item
        Column = 0
        Control = Label4
        Row = 3
      end
      item
        Column = 1
        Control = FluentToggleSwitch4
        Row = 3
      end
      item
        Column = 3
        Control = Label9
        Row = 3
      end
      item
        Column = 4
        Control = FluentToggleSwitch9
        Row = 3
      end
      item
        Column = 0
        Control = Label5
        Row = 4
      end
      item
        Column = 1
        Control = FluentToggleSwitch5
        Row = 4
      end
      item
        Column = 3
        Control = Label10
        Row = 4
      end
      item
        Column = 4
        Control = FluentToggleSwitch10
        Row = 4
      end>
    ExpandStyle = emFixedSize
    RowCollection = <
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    DesignSize = (
      910
      411)
    object Label1: TLabel
      AlignWithMargins = True
      Left = 167
      Top = 6
      Width = 78
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Default'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 6
      Width = 88
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 570
      Top = 6
      Width = 113
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Left'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 731
      Top = 6
      Width = 142
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      ShowText = True
      TextPosition = tpLeft
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 24
      Top = 66
      Width = 221
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Checked = True (On)'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 66
      Width = 88
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 2
      OnChange = FluentToggleSwitch2Change
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 554
      Top = 66
      Width = 129
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Right'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 731
      Top = 66
      Width = 142
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 5
      ShowText = True
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 37
      Top = 126
      Width = 208
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (Off)'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 126
      Width = 88
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Enabled = False
      TabOrder = 8
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 477
      Top = 126
      Width = 206
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (On)'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 731
      Top = 126
      Width = 142
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      Enabled = False
      TabOrder = 3
      ShowText = True
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 103
      Top = 186
      Width = 142
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Custom color'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch4: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 205
      Width = 88
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 4
      TrackColorOff = clOrangered
      TrackColorOn = clGreen
      ThumbColorOff = clKhaki
      ThumbColorOn = clGold
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 606
      Top = 186
      Width = 77
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch9: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 758
      Top = 186
      Width = 88
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
      ShowHeader = True
      HeaderText = 'Top'
      HeaderAlignment = taCenter
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -24
      HeaderFont.Name = 'Consolas'
      HeaderFont.Style = [fsBold]
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 60
      Top = 284
      Width = 185
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Animated = False'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch5: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 303
      Width = 88
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Animated = False
      TabOrder = 7
    end
    object Label10: TLabel
      AlignWithMargins = True
      Left = 497
      Top = 284
      Width = 186
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header = Bottom'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch10: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 758
      Top = 284
      Width = 88
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 9
      ShowHeader = True
      HeaderText = 'Bottom'
      HeaderPosition = hpBottom
      HeaderAlignment = taCenter
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -24
      HeaderFont.Name = 'Segoe UI'
      HeaderFont.Style = [fsUnderline]
    end
  end
end

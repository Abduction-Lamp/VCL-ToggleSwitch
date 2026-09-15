object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'TFluentToggleSwitch Demo'
  ClientHeight = 553
  ClientWidth = 1013
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
    Width = 989
    Height = 541
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
        Value = 46.000000000000000000
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
        Control = LabelGroupKeyboard
        Row = 0
      end
      item
        Column = 3
        Control = LabelGroupNoKeyboard
        Row = 0
      end
      item
        Column = 0
        Control = Label1
        Row = 1
      end
      item
        Column = 1
        Control = FluentToggleSwitch1
        Row = 1
      end
      item
        Column = 3
        Control = Label6
        Row = 1
      end
      item
        Column = 4
        Control = FluentToggleSwitch6
        Row = 1
      end
      item
        Column = 0
        Control = Label2
        Row = 2
      end
      item
        Column = 1
        Control = FluentToggleSwitch2
        Row = 2
      end
      item
        Column = 3
        Control = Label7
        Row = 2
      end
      item
        Column = 4
        Control = FluentToggleSwitch7
        Row = 2
      end
      item
        Column = 0
        Control = Label3
        Row = 3
      end
      item
        Column = 1
        Control = FluentToggleSwitch3
        Row = 3
      end
      item
        Column = 3
        Control = Label8
        Row = 3
      end
      item
        Column = 4
        Control = FluentToggleSwitch8
        Row = 3
      end
      item
        Column = 0
        Control = Label4
        Row = 4
      end
      item
        Column = 1
        Control = FluentToggleSwitch4
        Row = 4
      end
      item
        Column = 3
        Control = Label9
        Row = 4
      end
      item
        Column = 4
        Control = FluentToggleSwitch9
        Row = 4
      end
      item
        Column = 0
        Control = Label5
        Row = 5
      end
      item
        Column = 1
        Control = FluentToggleSwitch5
        Row = 5
      end
      item
        Column = 3
        Control = Label10
        Row = 5
      end
      item
        Column = 4
        Control = FluentToggleSwitch10
        Row = 5
      end
      item
        Column = 0
        Control = Label11
        Row = 6
      end
      item
        Column = 1
        Control = FluentToggleSwitch11
        Row = 6
      end
      item
        Column = 3
        Control = Label12
        Row = 6
      end
      item
        Column = 4
        Control = FluentToggleSwitch12
        Row = 6
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
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    ExplicitWidth = 950
    DesignSize = (
      989
      541)
    object LabelGroupKeyboard: TLabel
      AlignWithMargins = True
      Left = 49
      Top = 6
      Width = 196
      Height = 32
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Tab, Space, focus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 47
    end
    object LabelGroupNoKeyboard: TLabel
      AlignWithMargins = True
      Left = 574
      Top = 6
      Width = 198
      Height = 32
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'No Tab, no Space'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 497
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 167
      Top = 50
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
      Left = 320
      Top = 50
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
      Left = 659
      Top = 50
      Width = 113
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Left'
      Layout = tlCenter
      ExplicitLeft = 622
      ExplicitHeight = 32
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 821
      Top = 50
      Width = 142
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabStop = False
      TabOrder = 1
      KeyboardToggle = False
      ShowText = True
      TextPosition = tpLeft
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 24
      Top = 110
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
      Left = 320
      Top = 110
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
      Left = 643
      Top = 110
      Width = 129
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Right'
      Layout = tlCenter
      ExplicitLeft = 606
      ExplicitHeight = 32
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 821
      Top = 110
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
      TabStop = False
      TabOrder = 5
      KeyboardToggle = False
      ShowText = True
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 37
      Top = 170
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
      Left = 320
      Top = 170
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
      OnChange = FluentToggleSwitch3Change
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 566
      Top = 170
      Width = 206
      Height = 48
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (On)'
      Layout = tlCenter
      ExplicitLeft = 529
      ExplicitHeight = 32
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 821
      Top = 170
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
      TabStop = False
      TabOrder = 3
      KeyboardToggle = False
      OnChange = FluentToggleSwitch8Change
      ShowText = True
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 103
      Top = 230
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
      Left = 320
      Top = 249
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
      Left = 695
      Top = 230
      Width = 77
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header'
      Layout = tlCenter
      ExplicitLeft = 658
      ExplicitHeight = 32
    end
    object FluentToggleSwitch9: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 848
      Top = 230
      Width = 88
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabStop = False
      TabOrder = 6
      KeyboardToggle = False
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
      Top = 328
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
      Left = 320
      Top = 347
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
      Left = 586
      Top = 328
      Width = 186
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header = Bottom'
      Layout = tlCenter
      ExplicitLeft = 549
      ExplicitHeight = 32
    end
    object FluentToggleSwitch10: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 848
      Top = 328
      Width = 88
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabStop = False
      TabOrder = 9
      KeyboardToggle = False
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
    object Label11: TLabel
      AlignWithMargins = True
      Left = 74
      Top = 426
      Width = 171
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header and text'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch11: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 293
      Top = 426
      Width = 142
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 10
      ShowText = True
      ShowHeader = True
      HeaderText = 'Header'
      HeaderAlignment = taCenter
    end
    object Label12: TLabel
      AlignWithMargins = True
      Left = 529
      Top = 426
      Width = 243
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Every colour of its own'
      Layout = tlCenter
      ExplicitLeft = 434
      ExplicitHeight = 32
    end
    object FluentToggleSwitch12: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 820
      Top = 426
      Width = 144
      Height = 86
      Margins.Left = 24
      Margins.Top = 6
      Margins.Right = 24
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentFont = False
      TabStop = False
      TabOrder = 11
      KeyboardToggle = False
      TrackColorOff = clYellow
      TrackColorOn = clPurple
      ThumbColorOff = clRed
      ThumbColorOn = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ShowText = True
      TextOn = 'Yes'
      TextOff = 'No'
      ShowHeader = True
      HeaderText = 'Colours'
      HeaderAlignment = taCenter
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clTeal
      HeaderFont.Height = -24
      HeaderFont.Name = 'Segoe UI'
      HeaderFont.Style = [fsBold]
    end
  end
end

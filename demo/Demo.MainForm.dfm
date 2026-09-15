object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'TFluentToggleSwitch Demo'
  ClientHeight = 653
  ClientWidth = 1401
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
    Top = 12
    Width = 1377
    Height = 635
    Margins.Left = 12
    Margins.Top = 12
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
        ColumnSpan = 2
        Control = LabelGroupKeyboard
        Row = 0
      end
      item
        Column = 3
        ColumnSpan = 2
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
    ExplicitTop = 6
    ExplicitWidth = 910
    ExplicitHeight = 569
    DesignSize = (
      1377
      635)
    object LabelGroupKeyboard: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 12
      Width = 9659
      Height = 20
      Margins.Left = 6
      Margins.Top = 12
      Margins.Right = 6
      Margins.Bottom = 12
      Align = alClient
      Alignment = taCenter
      Caption = 'Tab, Space and the focus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 0
      ExplicitTop = 6
      ExplicitWidth = 539
      ExplicitHeight = 32
    end
    object LabelGroupNoKeyboard: TLabel
      AlignWithMargins = True
      Left = 9725
      Top = 12
      Width = 9779
      Height = 20
      Margins.Left = 6
      Margins.Top = 12
      Margins.Right = 6
      Margins.Bottom = 12
      Align = alClient
      Alignment = taCenter
      Caption = 'TabStop = False, KeyboardToggle = False'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 623
      ExplicitTop = 6
      ExplicitWidth = 464
      ExplicitHeight = 32
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 9379
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
      ExplicitLeft = 167
      ExplicitTop = 6
      ExplicitHeight = 32
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9532
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
      ExplicitLeft = 412
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 19183
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
      ExplicitLeft = 570
      ExplicitTop = 6
      ExplicitHeight = 32
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 19344
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
      ExplicitLeft = 1104
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 9236
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
      ExplicitLeft = 24
      ExplicitTop = 66
      ExplicitHeight = 32
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9532
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
      ExplicitLeft = 412
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 19167
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
      ExplicitLeft = 554
      ExplicitTop = 66
      ExplicitHeight = 32
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 19344
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
      ExplicitLeft = 1104
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 9249
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
      ExplicitLeft = 37
      ExplicitTop = 126
      ExplicitHeight = 32
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9532
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
      ExplicitLeft = 412
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 19090
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
      ExplicitLeft = 477
      ExplicitTop = 126
      ExplicitHeight = 32
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 19344
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
      ExplicitLeft = 1104
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 9315
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
      ExplicitLeft = 103
      ExplicitTop = 186
      ExplicitHeight = 32
    end
    object FluentToggleSwitch4: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9532
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
      ExplicitLeft = 412
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 19219
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
      ExplicitLeft = 606
      ExplicitTop = 186
      ExplicitHeight = 32
    end
    object FluentToggleSwitch9: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 19371
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
      ExplicitLeft = 1131
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 9272
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
      ExplicitLeft = 60
      ExplicitTop = 284
      ExplicitHeight = 32
    end
    object FluentToggleSwitch5: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9532
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
      ExplicitLeft = 412
    end
    object Label10: TLabel
      AlignWithMargins = True
      Left = 19110
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
      ExplicitLeft = 497
      ExplicitTop = 284
      ExplicitHeight = 32
    end
    object FluentToggleSwitch10: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 19371
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
      ExplicitLeft = 1131
    end
    object Label11: TLabel
      AlignWithMargins = True
      Left = 9286
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
      ExplicitLeft = 60
      ExplicitTop = 471
      ExplicitHeight = 32
    end
    object FluentToggleSwitch11: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 9505
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
      ExplicitLeft = 385
    end
  end
end

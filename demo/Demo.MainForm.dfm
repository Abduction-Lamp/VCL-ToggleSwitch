object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'TFluentToggleSwitch Demo'
  ClientHeight = 506
  ClientWidth = 1594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 32
  object GridPanel: TGridPanel
    AlignWithMargins = True
    Left = 12
    Top = 6
    Width = 1570
    Height = 494
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
        Column = 2
        Control = Panel1
        Row = 0
      end
      item
        Column = 4
        Control = Label2
        Row = 0
      end
      item
        Column = 5
        Control = FluentToggleSwitch2
        Row = 0
      end
      item
        Column = 6
        Control = Panel2
        Row = 0
      end
      item
        Column = 0
        Control = Label3
        Row = 1
      end
      item
        Column = 1
        Control = FluentToggleSwitch3
        Row = 1
      end
      item
        Column = 2
        Control = Panel3
        Row = 1
      end
      item
        Column = 4
        Control = Label4
        Row = 1
      end
      item
        Column = 5
        Control = FluentToggleSwitch4
        Row = 1
      end
      item
        Column = 6
        Control = Panel4
        Row = 1
      end
      item
        Column = 0
        Control = Label5
        Row = 2
      end
      item
        Column = 1
        Control = FluentToggleSwitch5
        Row = 2
      end
      item
        Column = 2
        Control = Panel5
        Row = 2
      end
      item
        Column = 4
        Control = Label6
        Row = 2
      end
      item
        Column = 5
        Control = FluentToggleSwitch6
        Row = 2
      end
      item
        Column = 6
        Control = Panel6
        Row = 2
      end
      item
        Column = 0
        Control = Label7
        Row = 3
      end
      item
        Column = 1
        Control = FluentToggleSwitch7
        Row = 3
      end
      item
        Column = 2
        Control = Panel7
        Row = 3
      end
      item
        Column = 4
        Control = Label8
        Row = 3
      end
      item
        Column = 5
        Control = FluentToggleSwitch8
        Row = 3
      end
      item
        Column = 6
        Control = Panel8
        Row = 3
      end
      item
        Column = 0
        Control = Label9
        Row = 4
      end
      item
        Column = 1
        Control = FluentToggleSwitch9
        Row = 4
      end
      item
        Column = 2
        Control = Panel9
        Row = 4
      end
      item
        Column = 4
        Control = Label10
        Row = 4
      end
      item
        Column = 5
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
      1570
      494)
    object Label1: TLabel
      AlignWithMargins = True
      Left = 149
      Top = 6
      Width = 78
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Default'
      Layout = tlCenter
      ExplicitLeft = 6
      ExplicitHeight = 32
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 23
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 357
      Top = 6
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 874
      Top = 6
      Width = 113
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Left'
      Layout = tlCenter
      ExplicitLeft = 812
      ExplicitHeight = 32
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1011
      Top = 23
      Width = 142
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
      TextPosition = tpLeft
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 1171
      Top = 6
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 100
      Width = 221
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Checked = True (On)'
      Layout = tlCenter
      ExplicitHeight = 32
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 117
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 4
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 357
      Top = 100
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 858
      Top = 100
      Width = 129
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Right'
      Layout = tlCenter
      ExplicitLeft = 812
      ExplicitHeight = 32
    end
    object FluentToggleSwitch4: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1011
      Top = 117
      Width = 142
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 6
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 1171
      Top = 100
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 19
      Top = 194
      Width = 208
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (Off)'
      Layout = tlCenter
      ExplicitLeft = 6
      ExplicitHeight = 32
    end
    object FluentToggleSwitch5: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 211
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Enabled = False
      TabOrder = 8
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 357
      Top = 194
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 781
      Top = 194
      Width = 206
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (On)'
      Layout = tlCenter
      ExplicitLeft = 794
      ExplicitHeight = 32
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1011
      Top = 211
      Width = 142
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      Enabled = False
      TabOrder = 10
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 1038
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 1171
      Top = 194
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 85
      Top = 288
      Width = 142
      Height = 94
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Custom color'
      Layout = tlCenter
      ExplicitLeft = 6
      ExplicitHeight = 32
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 311
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Checked = True
      TabOrder = 12
      TrackColorOff = clOrangered
      TrackColorOn = clGreen
      ThumbColorOff = clKhaki
      ThumbColorOn = clGold
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel7: TPanel
      AlignWithMargins = True
      Left = 357
      Top = 294
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 910
      Top = 288
      Width = 77
      Height = 94
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header'
      Layout = tlCenter
      ExplicitLeft = 812
      ExplicitHeight = 32
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1038
      Top = 290
      Width = 88
      Height = 90
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 14
      TextOn = 'On'
      TextOff = 'Off'
      ShowHeader = True
      HeaderText = 'Top'
      HeaderAlignment = taCenter
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -24
      HeaderFont.Name = 'Consolas'
      HeaderFont.Style = [fsBold]
      ExplicitTop = 288
    end
    object Panel8: TPanel
      AlignWithMargins = True
      Left = 1171
      Top = 294
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 42
      Top = 394
      Width = 185
      Height = 94
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Animated = False'
      Layout = tlCenter
      ExplicitLeft = 6
      ExplicitTop = 382
      ExplicitHeight = 32
    end
    object FluentToggleSwitch9: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 417
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      Animated = False
      TabOrder = 16
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 357
      Top = 400
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      BevelOuter = bvNone
      Caption = 'Panel9'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
    end
    object Label10: TLabel
      AlignWithMargins = True
      Left = 801
      Top = 394
      Width = 186
      Height = 94
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header = Bottom'
      Layout = tlCenter
      ExplicitLeft = 812
      ExplicitTop = 382
      ExplicitHeight = 32
    end
    object FluentToggleSwitch10: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1038
      Top = 394
      Width = 88
      Height = 94
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 18
      TextOn = 'On'
      TextOff = 'Off'
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

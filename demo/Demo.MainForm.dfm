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
    object Label1: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Default'
      Layout = tlCenter
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 252
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
      Left = 376
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
      Left = 812
      Top = 6
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Left'
      Layout = tlCenter
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1058
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
      TabOrder = 2
      ShowText = True
      TextPosition = tpLeft
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 1200
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
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Checked = True (On)'
      Layout = tlCenter
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 252
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
      TabOrder = 4
      Checked = True
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 376
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
      Left = 812
      Top = 100
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Right'
      Layout = tlCenter
    end
    object FluentToggleSwitch4: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1058
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
      TabOrder = 6
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 1200
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
      Left = 6
      Top = 194
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (Off)'
      Layout = tlCenter
    end
    object FluentToggleSwitch5: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 252
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
      TabOrder = 8
      Enabled = False
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 376
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
      Left = 812
      Top = 194
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = True (On)'
      Layout = tlCenter
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1058
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
      TabOrder = 10
      Checked = True
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 1200
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
      Left = 6
      Top = 288
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Custom color'
      Layout = tlCenter
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 252
      Top = 305
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
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
      Left = 376
      Top = 288
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
      Left = 812
      Top = 288
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header'
      Layout = tlCenter
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1058
      Top = 305
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 14
      ShowHeader = True
      HeaderText = 'Header'
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel8: TPanel
      AlignWithMargins = True
      Left = 1200
      Top = 288
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
      Left = 6
      Top = 382
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Animated = False'
      Layout = tlCenter
    end
    object FluentToggleSwitch9: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 252
      Top = 399
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 16
      Animated = False
      TextOn = 'On'
      TextOff = 'Off'
    end
    object Panel9: TPanel
      AlignWithMargins = True
      Left = 376
      Top = 382
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
      Left = 812
      Top = 382
      Width = 240
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Header = Bottom'
      Layout = tlCenter
    end
    object FluentToggleSwitch10: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 1058
      Top = 399
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 18
      ShowHeader = True
      HeaderText = 'Header'
      HeaderPosition = hpBottom
      TextOn = 'On'
      TextOff = 'Off'
    end
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'TFluentToggleSwitch Demo'
  ClientHeight = 794
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 192
  DesignSize = (
    813
    794)
  TextHeight = 32
  object GridPanel: TGridPanel
    AlignWithMargins = True
    Left = 11
    Top = 1
    Width = 801
    Height = 782
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = []
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
        Column = 2
        Control = Panel2
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
        Column = 2
        Control = Panel3
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
        Column = 2
        Control = Panel4
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
        Column = 2
        Control = Panel5
        Row = 4
      end
      item
        Column = 0
        Control = Label6
        Row = 5
      end
      item
        Column = 1
        Control = FluentToggleSwitch6
        Row = 5
      end
      item
        Column = 2
        Control = Panel6
        Row = 5
      end
      item
        Column = 0
        Control = Label7
        Row = 6
      end
      item
        Column = 1
        Control = FluentToggleSwitch7
        Row = 6
      end
      item
        Column = 2
        Control = Panel7
        Row = 6
      end
      item
        Column = 0
        Control = Label8
        Row = 7
      end
      item
        Column = 1
        Control = FluentToggleSwitch8
        Row = 7
      end
      item
        Column = 2
        Control = Panel8
        Row = 7
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
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    DesignSize = (
      801
      782)
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
      Left = 278
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
      ExplicitLeft = 108
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 411
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
      ExplicitLeft = 214
    end
    object Label2: TLabel
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
      ExplicitTop = 125
      ExplicitHeight = 32
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 278
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
      TabOrder = 2
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 344
      ExplicitTop = 228
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 100
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
      ExplicitLeft = 696
      ExplicitTop = 210
    end
    object Label3: TLabel
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
      ExplicitTop = 219
      ExplicitHeight = 32
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 278
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
      TabOrder = 4
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 344
      ExplicitTop = 392
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 194
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
      ExplicitLeft = 696
      ExplicitTop = 374
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 21
      Top = 288
      Width = 206
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Enable = False (On)'
      Layout = tlCenter
      ExplicitLeft = 20
      ExplicitTop = 313
      ExplicitHeight = 32
    end
    object FluentToggleSwitch4: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 278
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
      Checked = True
      Enabled = False
      TabOrder = 6
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 344
      ExplicitTop = 556
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 288
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
      ExplicitLeft = 696
      ExplicitTop = 538
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 85
      Top = 382
      Width = 142
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Custom color'
      Layout = tlCenter
      ExplicitLeft = 49
      ExplicitTop = 407
      ExplicitHeight = 32
    end
    object FluentToggleSwitch5: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 278
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
      Checked = True
      TabOrder = 8
      TrackColorOff = clOrangered
      TrackColorOn = clGreen
      ThumbColorOff = clKhaki
      ThumbColorOn = clGold
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 344
      ExplicitTop = 720
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 382
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
      ExplicitLeft = 696
      ExplicitTop = 702
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 98
      Top = 476
      Width = 129
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Right'
      Layout = tlCenter
      ExplicitLeft = 56
      ExplicitTop = 495
      ExplicitHeight = 32
    end
    object FluentToggleSwitch6: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 493
      Width = 142
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 10
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitTop = 487
    end
    object Panel6: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 476
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
      ExplicitLeft = 898
      ExplicitTop = 962
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 114
      Top = 570
      Width = 113
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Caption = 'Text = Left'
      Layout = tlCenter
      ExplicitLeft = 64
      ExplicitTop = 577
      ExplicitHeight = 32
    end
    object FluentToggleSwitch7: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 587
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
      TabOrder = 12
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
      TextPosition = tpLeft
      ExplicitTop = 569
    end
    object Panel7: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 570
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
      ExplicitLeft = 898
      ExplicitTop = 1126
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 150
      Top = 664
      Width = 77
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Align = alRight
      Anchors = [akRight]
      Caption = 'Header'
      Layout = tlCenter
      ExplicitLeft = 82
      ExplicitTop = 659
      ExplicitHeight = 32
    end
    object FluentToggleSwitch8: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 251
      Top = 681
      Width = 142
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 14
      ShowText = True
      TextOn = 'On'
      TextOff = 'Off'
      TextPosition = tpLeft
      ExplicitTop = 651
    end
    object Panel8: TPanel
      AlignWithMargins = True
      Left = 411
      Top = 664
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
      ExplicitLeft = 898
      ExplicitTop = 1290
    end
  end
end

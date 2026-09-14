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
  TextHeight = 32
  object GridPanel: TGridPanel
    AlignWithMargins = True
    Left = 12
    Top = 6
    Width = 795
    Height = 782
    Margins.Left = 12
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAuto
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
        Value = 100.000000000000000000
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
      end>
    ExpandStyle = emFixedSize
    RowCollection = <
      item
        SizeStyle = ssAuto
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    ExplicitLeft = 144
    ExplicitTop = 320
    ExplicitWidth = 370
    ExplicitHeight = 82
    DesignSize = (
      795
      782)
    object Label1: TLabel
      AlignWithMargins = True
      Left = 68
      Top = 31
      Width = 78
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Default'
      ExplicitLeft = 40
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 233
      Top = 23
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      TabOrder = 0
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 162
      ExplicitTop = 31
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 339
      Top = 6
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Panel1'
      TabOrder = 1
      ExplicitLeft = 232
      ExplicitTop = 0
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 119
      Width = 221
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Checked = True (On)'
      ExplicitLeft = 0
    end
    object FluentToggleSwitch2: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 233
      Top = 111
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Checked = True
      Enabled = False
      TabOrder = 2
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 344
      ExplicitTop = 228
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 339
      Top = 100
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Panel2'
      TabOrder = 3
      ExplicitLeft = 696
      ExplicitTop = 210
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 201
      Width = 206
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Enable = False (On)'
      ExplicitLeft = 0
      ExplicitTop = 171
    end
    object FluentToggleSwitch3: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 233
      Top = 193
      Width = 88
      Height = 48
      Margins.Left = 12
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Enabled = False
      TabOrder = 4
      TextOn = 'On'
      TextOff = 'Off'
      ExplicitLeft = 510
      ExplicitTop = 360
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 339
      Top = 182
      Width = 370
      Height = 82
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = []
      Caption = 'Panel3'
      TabOrder = 5
      ExplicitLeft = 862
      ExplicitTop = 358
    end
  end
end

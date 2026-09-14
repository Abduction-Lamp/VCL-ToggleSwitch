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
    Left = 11
    Top = 1
    Width = 801
    Height = 782
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
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
      Left = 6
      Top = 6
      Width = 78
      Height = 32
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 12
      Margins.Bottom = 6
      Caption = 'Default'
    end
    object FluentToggleSwitch1: TFluentToggleSwitch
      AlignWithMargins = True
      Left = 108
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
      ExplicitLeft = 192
      ExplicitTop = 20
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 214
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
      ExplicitLeft = 416
      ExplicitTop = 18
    end
  end
end

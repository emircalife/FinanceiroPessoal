object frmImprDespesas: TfrmImprDespesas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Impress'#227'o de Despesas'
  ClientHeight = 150
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object lblMostrarDespesas: TLabel
    Left = 8
    Top = 91
    Width = 105
    Height = 15
    Caption = 'Mostrar as despesas'
  end
  object cboTiposDespesa: TComboBox
    Left = 136
    Top = 88
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 1
    Text = 'Somente N'#195'O Pagas'
    Items.Strings = (
      'Todas'
      'Somente N'#195'O Pagas'
      'Somente Pagas')
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 8
    Width = 273
    Height = 65
    Caption = '   Per'#237'odo   '
    TabOrder = 0
    object lblDe: TLabel
      Left = 24
      Top = 35
      Width = 13
      Height = 15
      Caption = 'de'
    end
    object lblAte: TLabel
      Left = 143
      Top = 35
      Width = 16
      Height = 15
      Caption = 'at'#233
    end
    object dtpDe: TDatePicker
      Left = 51
      Top = 30
      Width = 80
      Height = 25
      Date = 45721.000000000000000000
      DateFormat = 'dd/mm/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 0
    end
    object dtpAte: TDatePicker
      Left = 171
      Top = 30
      Width = 80
      Height = 25
      Date = 45721.000000000000000000
      DateFormat = 'dd/mm/yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      MaxYear = 3025
      MinYear = 2025
      TabOrder = 1
    end
  end
  object btnImprimir: TBitBtn
    Left = 114
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Im&primir'
    TabOrder = 2
    OnClick = btnImprimirClick
  end
  object btnCancelar: TBitBtn
    Left = 206
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Cancela&r'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
end

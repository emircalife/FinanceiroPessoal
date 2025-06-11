object frmExpoPlanExelAnual: TfrmExpoPlanExelAnual
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exportar para Excell - Planilha Anual'
  ClientHeight = 121
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object grpPastaDestino: TGroupBox
    Left = 8
    Top = 8
    Width = 649
    Height = 65
    Caption = '   Pasta de destino   '
    TabOrder = 0
    object edtCaminhoExportar: TEdit
      Left = 167
      Top = 24
      Width = 442
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnExportarExcell: TBitBtn
      Left = 615
      Top = 23
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnExportarExcellClick
    end
  end
  object btnExportar: TBitBtn
    Left = 496
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Exportar'
    TabOrder = 1
    OnClick = btnExportarClick
  end
  object btnCancelar: TBitBtn
    Left = 582
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancela&r'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object drvCboUnidades: TDriveComboBox
    Left = 24
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 3
  end
end

object frmGeracaoParcelas: TfrmGeracaoParcelas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Gera'#231#227'o de Parcelas'
  ClientHeight = 549
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    917
    549)
  TextHeight = 15
  object lblVencimento: TLabel
    Left = 20
    Top = 378
    Width = 80
    Height = 15
    Caption = 'DT Vencimento'
  end
  object lblDespesa: TLabel
    Left = 20
    Top = 407
    Width = 43
    Height = 15
    Caption = 'Despesa'
  end
  object lblCategoriaDespesa: TLabel
    Left = 255
    Top = 378
    Width = 51
    Height = 15
    Caption = 'Categoria'
    FocusControl = lkpCategoriaDespesa
  end
  object lblValorTotalAPagar: TLabel
    Left = 20
    Top = 436
    Width = 84
    Height = 15
    Caption = 'R$ Total a Pagar'
  end
  object lblQtdeParcelas: TLabel
    Left = 218
    Top = 436
    Width = 88
    Height = 15
    Caption = 'Qtde de Parcelas'
  end
  object lblTipoParcelamento: TLabel
    Left = 616
    Top = 434
    Width = 116
    Height = 15
    Caption = 'Tipo de Parcelamento'
  end
  object grdParcelasDespesas: TDBGrid
    Left = 1
    Top = 8
    Width = 908
    Height = 349
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsParcelasDespesas
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'dataVencimento'
        Title.Caption = 'DT Vencimento'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Despesa'
        Width = 344
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'categoriaDespesa'
        Title.Caption = 'Categoria'
        Width = 322
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valorAPagar'
        Title.Caption = 'R$ a Pagar'
        Width = 80
        Visible = True
      end>
  end
  object pnlBotoes: TPanel
    Left = 1
    Top = 470
    Width = 908
    Height = 78
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 8
    object btnAlterarParcela: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 100
      Height = 70
      Align = alLeft
      Caption = '&Alterar Parcela'
      TabOrder = 0
      OnClick = btnAlterarParcelaClick
    end
    object btnDesfazerParcelas: TBitBtn
      AlignWithMargins = True
      Left = 110
      Top = 4
      Width = 100
      Height = 70
      Align = alLeft
      Caption = '&Desfazer'
      TabOrder = 1
      OnClick = btnDesfazerParcelasClick
    end
    object btnGerarParcelas: TBitBtn
      AlignWithMargins = True
      Left = 223
      Top = 4
      Width = 100
      Height = 70
      Margins.Left = 10
      Align = alLeft
      Caption = '&Gerar Parcelas'
      TabOrder = 2
      OnClick = btnGerarParcelasClick
    end
    object btnSalvarParcelasGeradas: TBitBtn
      AlignWithMargins = True
      Left = 469
      Top = 4
      Width = 218
      Height = 70
      Margins.Left = 20
      Align = alLeft
      Caption = '&Salvar Parcelas Geradas'
      Enabled = False
      TabOrder = 3
      OnClick = btnSalvarParcelasGeradasClick
    end
    object btnSair: TBitBtn
      AlignWithMargins = True
      Left = 804
      Top = 4
      Width = 100
      Height = 70
      Align = alRight
      Caption = 'Sai&r'
      TabOrder = 4
      OnClick = btnSairClick
      ExplicitLeft = 784
    end
    object btnExcluirParcela: TBitBtn
      AlignWithMargins = True
      Left = 346
      Top = 4
      Width = 100
      Height = 70
      Margins.Left = 20
      Align = alLeft
      Caption = '&Excluir Parcela'
      TabOrder = 5
      OnClick = btnExcluirParcelaClick
    end
  end
  object lkpCategoriaDespesa: TDBLookupComboBox
    Left = 322
    Top = 375
    Width = 286
    Height = 23
    DataField = 'categoria'
    DataSource = dsParcelasDespesas
    KeyField = 'ID'
    ListField = 'DESCRICAO'
    ListSource = dslkpCategoriasDespesa
    TabOrder = 2
  end
  object edtQtdeParcelas: TEdit
    Left = 322
    Top = 433
    Width = 95
    Height = 23
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 5
    OnExit = edtQtdeParcelasExit
  end
  object edtValorAPagar: TEdit
    Left = 111
    Top = 433
    Width = 95
    Height = 23
    Alignment = taRightJustify
    TabOrder = 4
    OnExit = edtValorAPagarExit
  end
  object edtDespesa: TEdit
    Left = 111
    Top = 404
    Width = 497
    Height = 23
    TabOrder = 3
  end
  object cboTipoParcelamento: TComboBox
    Left = 748
    Top = 431
    Width = 143
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 7
    Text = 'Mensal'
    Items.Strings = (
      'Anual'
      'Mensal'
      'Semanal')
  end
  object edtDTVencimento: TMaskEdit
    Left = 111
    Top = 375
    Width = 98
    Height = 23
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object rgFormaParcelas: TRadioGroup
    Left = 616
    Top = 360
    Width = 293
    Height = 65
    Caption = '   Forma de parcela   '
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Valor de cada Parcela'
      'Valor Total das Parcelas')
    TabOrder = 6
    OnClick = rgFormaParcelasClick
  end
  object dsParcelasDespesas: TDataSource
    DataSet = cdsDespesas
    Left = 496
    Top = 224
  end
  object qrylkpCategoriasDespesa: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'SELECT id,'
      '       descricao'
      'FROM CategoriasDespesa'
      'order by descricao')
    Left = 384
    Top = 312
    object qrylkpCategoriasDespesaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrylkpCategoriasDespesaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 255
    end
  end
  object dslkpCategoriasDespesa: TDataSource
    DataSet = qrylkpCategoriasDespesa
    Left = 528
    Top = 312
  end
  object cdsDespesas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 136
    object cdsDespesasdataVencimento: TDateField
      FieldName = 'dataVencimento'
    end
    object cdsDespesascategoria: TIntegerField
      FieldName = 'categoria'
    end
    object cdsDespesasdescricao: TStringField
      FieldName = 'descricao'
      Size = 255
    end
    object cdsDespesascategoriaDespesa: TStringField
      FieldName = 'categoriaDespesa'
      Size = 255
    end
    object cdsDespesasvalorAPagar: TFloatField
      FieldName = 'valorAPagar'
      DisplayFormat = '#,##0.00'
    end
  end
end

object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Controle Financeiro'
  ClientHeight = 781
  ClientWidth = 1136
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnuMainMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1136
    781)
  TextHeight = 15
  object lblMesAno: TLabel
    Left = 9
    Top = 16
    Width = 49
    Height = 15
    Caption = 'M'#234's/Ano'
  end
  object lblPesquisa: TLabel
    Left = 163
    Top = 16
    Width = 46
    Height = 15
    Caption = 'Pesquisa'
  end
  object grpDespesas: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 45
    Width = 1120
    Height = 412
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '   Despesas   '
    TabOrder = 3
    DesignSize = (
      1120
      412)
    object lblTotalDespesas: TLabel
      Left = 904
      Top = 198
      Width = 205
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Caption = 'Total de Registros: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 189
    end
    object grdDespesas: TDBGrid
      Left = 3
      Top = 24
      Width = 1110
      Height = 169
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsDesepsas
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = grdDespesasDrawColumnCell
      OnMouseUp = grdDespesasMouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'SEQUENCIA'
          Title.Caption = ' '
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DATAVENCIMENTO'
          Title.Caption = 'DT Vencimento'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Despesa'
          Width = 370
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'categoriaDespesa'
          Title.Caption = 'Categoria'
          Width = 345
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORAPAGAR'
          Title.Caption = 'R$ a Pagar'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORPAGO'
          Title.Caption = 'R$ Pago'
          Width = 80
          Visible = True
        end>
    end
    object pnlDadosDespesas: TPanel
      Left = 3
      Top = 226
      Width = 1115
      Height = 183
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 1
      ExplicitTop = 225
      ExplicitWidth = 1051
      DesignSize = (
        1115
        183)
      object lblValorPago: TLabel
        Left = 744
        Top = 83
        Width = 43
        Height = 15
        Caption = 'R$ Pago'
        FocusControl = edtValorPago
      end
      object lblValorAPagar: TLabel
        Left = 602
        Top = 83
        Width = 55
        Height = 15
        Caption = 'R$ a Pagar'
        FocusControl = edtValorAPagar
      end
      object lblDespesa: TLabel
        Left = 7
        Top = 83
        Width = 43
        Height = 15
        Caption = 'Despesa'
        FocusControl = edtDespesa
      end
      object lblVencimento: TLabel
        Left = 7
        Top = 56
        Width = 80
        Height = 15
        Caption = 'DT Vencimento'
        FocusControl = edtDTVencimento
      end
      object lblCategoriaDespesa: TLabel
        Left = 204
        Top = 56
        Width = 51
        Height = 15
        Caption = 'Categoria'
        FocusControl = lkpCategoriaDespesa
      end
      object Label5: TLabel
        Left = 181
        Top = 8
        Width = 41
        Height = 15
        Caption = 'Vencida'
      end
      object Label4: TLabel
        Left = 83
        Top = 8
        Width = 59
        Height = 15
        Caption = 'Vence Hoje'
      end
      object Shape3: TShape
        Left = 158
        Top = 8
        Width = 17
        Height = 17
        Brush.Color = clRed
        Pen.Color = clRed
      end
      object Shape2: TShape
        Left = 60
        Top = 8
        Width = 17
        Height = 17
        Brush.Color = clOlive
        Pen.Color = clOlive
      end
      object Label3: TLabel
        Left = 27
        Top = 8
        Width = 27
        Height = 15
        Caption = 'Pago'
      end
      object Shape1: TShape
        Left = 4
        Top = 8
        Width = 17
        Height = 17
        Brush.Color = clGreen
        Pen.Color = clGreen
      end
      object Label6: TLabel
        Left = 673
        Top = 56
        Width = 78
        Height = 15
        Caption = 'DT Pagamento'
        FocusControl = edtDTPagamento
      end
      object pnlBotoesDespesas: TPanel
        AlignWithMargins = True
        Left = -8
        Top = 106
        Width = 1118
        Height = 78
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 7
        ExplicitWidth = 1054
        object btnNovoDespesa: TBitBtn
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 100
          Height = 70
          Align = alLeft
          Caption = '&Novo'
          TabOrder = 0
          OnClick = btnNovoDespesaClick
        end
        object btnAlterarDespesa: TBitBtn
          AlignWithMargins = True
          Left = 110
          Top = 4
          Width = 100
          Height = 70
          Align = alLeft
          Caption = '&Alterar'
          TabOrder = 1
          OnClick = btnAlterarDespesaClick
        end
        object btnDesfazerDespesa: TBitBtn
          AlignWithMargins = True
          Left = 216
          Top = 4
          Width = 100
          Height = 70
          Align = alLeft
          Caption = '&Desfazer'
          TabOrder = 2
          OnClick = btnDesfazerDespesaClick
        end
        object btnSalvarDespesa: TBitBtn
          AlignWithMargins = True
          Left = 329
          Top = 4
          Width = 100
          Height = 70
          Margins.Left = 10
          Align = alLeft
          Caption = '&Salvar'
          TabOrder = 3
          OnClick = btnSalvarDespesaClick
        end
        object btnExcluirDespesa: TBitBtn
          AlignWithMargins = True
          Left = 452
          Top = 4
          Width = 100
          Height = 70
          Margins.Left = 20
          Align = alLeft
          Caption = '&Excluir'
          TabOrder = 4
          OnClick = btnExcluirDespesaClick
        end
        object grpTotaisDespesas: TGroupBox
          Left = 559
          Top = 8
          Width = 410
          Height = 57
          Caption = '   Totais de Despesas   '
          TabOrder = 5
          object lblDepesaAPagar: TLabel
            Left = 16
            Top = 32
            Width = 105
            Height = 24
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'R$ 00,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblDepesaPaga: TLabel
            Left = 168
            Top = 32
            Width = 105
            Height = 24
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'R$ 00,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblFaltaPagar: TLabel
            Left = 296
            Top = 32
            Width = 105
            Height = 24
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'R$ 00,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clOlive
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotalAPagar: TLabel
            Left = 16
            Top = 16
            Width = 68
            Height = 15
            Caption = 'Total a Pagar'
          end
          object lblPago: TLabel
            Left = 152
            Top = 16
            Width = 27
            Height = 15
            Caption = 'Pago'
          end
          object lblValorFaltaPagar: TLabel
            Left = 288
            Top = 16
            Width = 58
            Height = 15
            Caption = 'Falta Pagar'
          end
        end
        object btnImprimirDespesasDoMes: TBitBtn
          AlignWithMargins = True
          Left = 1014
          Top = 4
          Width = 100
          Height = 70
          Align = alRight
          TabOrder = 6
          OnClick = btnImprimirDespesasDoMesClick
          ExplicitLeft = 950
        end
      end
      object btnGerarParcelasDoAno: TBitBtn
        Left = 1006
        Top = 9
        Width = 100
        Height = 70
        Anchors = [akTop, akRight]
        Caption = '&Gerar Parcelas'
        TabOrder = 8
        OnClick = btnGerarParcelasDoAnoClick
        ExplicitLeft = 942
      end
      object edtValorPago: TDBEdit
        Left = 793
        Top = 80
        Width = 72
        Height = 23
        DataField = 'VALORPAGO'
        DataSource = dsDesepsas
        TabOrder = 6
      end
      object edtValorAPagar: TDBEdit
        Left = 663
        Top = 80
        Width = 74
        Height = 23
        DataField = 'VALORAPAGAR'
        DataSource = dsDesepsas
        TabOrder = 5
      end
      object edtDespesa: TDBEdit
        Left = 94
        Top = 80
        Width = 500
        Height = 23
        DataField = 'DESCRICAO'
        DataSource = dsDesepsas
        TabOrder = 4
      end
      object edtDTVencimento: TDBEdit
        Left = 94
        Top = 51
        Width = 97
        Height = 23
        DataField = 'DATAVENCIMENTO'
        DataSource = dsDesepsas
        TabOrder = 1
      end
      object lkpCategoriaDespesa: TDBLookupComboBox
        Left = 261
        Top = 51
        Width = 333
        Height = 23
        DataField = 'IDCATEGORIA'
        DataSource = dsDesepsas
        KeyField = 'ID'
        ListField = 'DESCRICAO'
        ListSource = dslkpCategoriasDespesa
        TabOrder = 2
      end
      object rgMostrarDespesas: TRadioGroup
        Left = 413
        Top = 2
        Width = 419
        Height = 36
        Caption = '   Mostrar Despesas   '
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          'Todas'
          'Somente N'#227'o Pagas'
          'Somente Pagas')
        TabOrder = 0
        OnClick = rgMostrarDespesasClick
      end
      object edtDTPagamento: TDBEdit
        Left = 768
        Top = 51
        Width = 97
        Height = 23
        DataField = 'DATAPAGAMENTO'
        DataSource = dsDesepsas
        TabOrder = 3
      end
    end
  end
  object grpReceitas: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 474
    Width = 1120
    Height = 299
    Anchors = [akLeft, akRight, akBottom]
    Caption = '   Receitas   '
    TabOrder = 4
    DesignSize = (
      1120
      299)
    object lblDTRecebimento: TLabel
      Left = 750
      Top = 155
      Width = 87
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'DT Recebimento'
      FocusControl = edtDTRecebimento
    end
    object lblCategoriaReceita: TLabel
      Left = 207
      Top = 154
      Width = 51
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'Categoria'
      FocusControl = lkpCategoriaReceita
    end
    object lblReceita: TLabel
      Left = 7
      Top = 181
      Width = 38
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'Receita'
      FocusControl = edtReceita
    end
    object Label1: TLabel
      Left = 602
      Top = 181
      Width = 67
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'R$ a Receber'
      FocusControl = edtValorAReceber
    end
    object Label2: TLabel
      Left = 776
      Top = 181
      Width = 65
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'R$ Recebido'
      FocusControl = edtValorRecebido
    end
    object lblTotalReceitas: TLabel
      Left = 904
      Top = 144
      Width = 205
      Height = 15
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'Total de Registros: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 189
    end
    object lblDTAReceber: TLabel
      Left = 6
      Top = 155
      Width = 70
      Height = 15
      Caption = 'DT A Receber'
      FocusControl = edtDTAreceber
    end
    object grdReceitas: TDBGrid
      Left = 3
      Top = 24
      Width = 1112
      Height = 114
      TabStop = False
      Anchors = [akLeft, akRight, akBottom]
      DataSource = dsReceitas
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = grdReceitasDrawColumnCell
      OnMouseUp = grdReceitasMouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'SEQUENCIA'
          Title.Caption = ' '
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DATARECEBIMENTO'
          Title.Caption = 'DT Recebimento'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Receita'
          Width = 374
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'categoriaReceita'
          Title.Caption = 'Categoria'
          Width = 345
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORARECEBER'
          Title.Caption = 'R$ a Receber'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORRECEBIDO'
          Title.Caption = 'R$ Recebido'
          Width = 80
          Visible = True
        end>
    end
    object pnlBotoesReceitas: TPanel
      Left = 2
      Top = 219
      Width = 1116
      Height = 78
      Align = alBottom
      TabOrder = 7
      ExplicitWidth = 1052
      object btnNovoReceita: TBitBtn
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 100
        Height = 70
        Align = alLeft
        Caption = '&Novo'
        TabOrder = 0
        OnClick = btnNovoReceitaClick
      end
      object btnAlterarReceita: TBitBtn
        AlignWithMargins = True
        Left = 110
        Top = 4
        Width = 100
        Height = 70
        Align = alLeft
        Caption = '&Alterar'
        TabOrder = 1
        OnClick = btnAlterarReceitaClick
      end
      object btnDesfazerReceita: TBitBtn
        AlignWithMargins = True
        Left = 216
        Top = 4
        Width = 100
        Height = 70
        Align = alLeft
        Caption = '&Desfazer'
        TabOrder = 2
        OnClick = btnDesfazerReceitaClick
      end
      object btnSalvarReceita: TBitBtn
        AlignWithMargins = True
        Left = 329
        Top = 4
        Width = 100
        Height = 70
        Margins.Left = 10
        Align = alLeft
        Caption = '&Salvar'
        TabOrder = 3
        OnClick = btnSalvarReceitaClick
      end
      object btnExcluirReceita: TBitBtn
        AlignWithMargins = True
        Left = 452
        Top = 4
        Width = 100
        Height = 70
        Margins.Left = 20
        Align = alLeft
        Caption = '&Excluir'
        TabOrder = 4
        OnClick = btnExcluirReceitaClick
      end
      object btnSair: TBitBtn
        AlignWithMargins = True
        Left = 1012
        Top = 4
        Width = 100
        Height = 70
        Align = alRight
        Caption = 'Sai&r'
        TabOrder = 6
        OnClick = btnSairClick
        ExplicitLeft = 948
      end
      object grpTotaisReceitas: TGroupBox
        Left = 558
        Top = 8
        Width = 410
        Height = 57
        Caption = '   Totais de Receitas   '
        TabOrder = 5
        object lblReceitaAReceber: TLabel
          Left = 16
          Top = 27
          Width = 105
          Height = 30
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'R$ 00,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblReceitaRecebida: TLabel
          Left = 168
          Top = 27
          Width = 105
          Height = 30
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'R$ 00,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblFaltaReceber: TLabel
          Left = 297
          Top = 27
          Width = 105
          Height = 30
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'R$ 00,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clOlive
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTotalAReceber: TLabel
          Left = 12
          Top = 13
          Width = 80
          Height = 15
          Caption = 'Total a Receber'
        end
        object lblrecebido: TLabel
          Left = 148
          Top = 13
          Width = 49
          Height = 15
          Caption = 'Recebido'
        end
        object lblVlFaltaReceber: TLabel
          Left = 284
          Top = 13
          Width = 70
          Height = 15
          Caption = 'Falta Receber'
        end
      end
    end
    object edtDTRecebimento: TDBEdit
      Left = 847
      Top = 152
      Width = 97
      Height = 23
      Anchors = [akLeft, akBottom]
      DataField = 'DATARECEBIMENTO'
      DataSource = dsReceitas
      TabOrder = 3
    end
    object lkpCategoriaReceita: TDBLookupComboBox
      Left = 264
      Top = 151
      Width = 333
      Height = 23
      Anchors = [akLeft, akBottom]
      DataField = 'IDCATEGORIA'
      DataSource = dsReceitas
      KeyField = 'ID'
      ListField = 'DESCRICAO'
      ListSource = dslkpCategoriasReceita
      TabOrder = 2
    end
    object edtReceita: TDBEdit
      Left = 97
      Top = 178
      Width = 500
      Height = 23
      Anchors = [akLeft, akBottom]
      DataField = 'DESCRICAO'
      DataSource = dsReceitas
      TabOrder = 4
    end
    object edtValorAReceber: TDBEdit
      Left = 674
      Top = 178
      Width = 97
      Height = 23
      Anchors = [akLeft, akBottom]
      DataField = 'VALORARECEBER'
      DataSource = dsReceitas
      TabOrder = 5
    end
    object edtValorRecebido: TDBEdit
      Left = 847
      Top = 178
      Width = 97
      Height = 23
      Anchors = [akLeft, akBottom]
      DataField = 'VALORRECEBIDO'
      DataSource = dsReceitas
      TabOrder = 6
    end
    object edtDTAreceber: TDBEdit
      Left = 97
      Top = 151
      Width = 104
      Height = 23
      DataField = 'DATAARECEBER'
      DataSource = dsReceitas
      TabOrder = 1
    end
  end
  object cboMesAno: TComboBox
    Left = 64
    Top = 13
    Width = 92
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    OnChange = cboMesAnoChange
  end
  object btnCalendario: TBitBtn
    Left = 1017
    Top = 8
    Width = 100
    Height = 31
    Anchors = [akTop, akRight]
    Caption = '&Calend'#225'rio'
    TabOrder = 2
    OnClick = btnCalendarioClick
  end
  object edtPesquisa: TEdit
    Left = 220
    Top = 13
    Width = 753
    Height = 23
    TabOrder = 1
    OnChange = edtPesquisaChange
  end
  object mnuMainMenu: TMainMenu
    Left = 256
    Top = 96
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object Categorias1: TMenuItem
        Caption = '&Categorias'
        object Despesas1: TMenuItem
          Caption = '&Despesas'
          OnClick = Despesas1Click
        end
        object Receitas1: TMenuItem
          Caption = '&Receitas'
          OnClick = Receitas1Click
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Usurios1: TMenuItem
        Caption = '&Usu'#225'rios'
        OnClick = Usurios1Click
      end
    end
  end
  object dsDesepsas: TDataSource
    DataSet = DM.qryDespesas
    Left = 360
    Top = 128
  end
  object dsReceitas: TDataSource
    DataSet = DM.qryReceitas
    Left = 384
    Top = 544
  end
  object qrylkpCategoriasDespesa: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'SELECT id,'
      '       descricao'
      'FROM CategoriasDespesa'
      'order by descricao')
    Left = 536
    Top = 184
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
    Left = 392
    Top = 184
  end
  object qrylkpCategoriasReceita: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'SELECT id,'
      '       descricao'
      'FROM CategoriasReceita'
      'order by descricao')
    Left = 568
    Top = 552
    object IntegerField1: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 255
    end
  end
  object dslkpCategoriasReceita: TDataSource
    DataSet = qrylkpCategoriasReceita
    Left = 720
    Top = 552
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 995
    Top = 101
  end
  object frxDBDsReport: TfrxDBDataset
    UserName = 'frxDBDsReport'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'DESCRICAO=DESCRICAO'
      'DATAVENCIMENTO=DATAVENCIMENTO'
      'VALORAPAGAR=VALORAPAGAR'
      'VALORPAGO=VALORPAGO'
      'CATEGORIA=CATEGORIA'
      'CATEGORIADESPESA=CATEGORIADESPESA')
    DataSet = DM.qryDespesas
    BCDToCurrency = False
    Left = 959
    Top = 125
  end
  object frxRelDespesadDoMes: TfrxReport
    Version = '6.9.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45705.648651226900000000
    ReportOptions.LastChange = 45708.704542037030000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 1043
    Top = 181
    Datasets = <
      item
        DataSet = frxDBDsReport
        DataSetName = 'frxDBDsReport'
      end>
    Variables = <
      item
        Name = ' REPORT'
        Value = Null
      end
      item
        Name = 'TITULO'
        Value = Null
      end
      item
        Name = 'PAGO'
        Value = '<frxDBDsReport."VALORAPAGAR">=<frxDBDsReport."VALORPAGO">'
      end>
    Style = <
      item
        Name = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = clGray
      end
      item
        Name = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
      end
      item
        Name = 'Group header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 16053492
      end
      item
        Name = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
      end
      item
        Name = 'Group footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
      end
      item
        Name = 'Header line'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object TITULO: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO]')
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 68.031540000000000000
        Width = 718.110700000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Width = 718.110236220000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          Style = 'Header line'
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 22.000000000000000000
          Width = 79.866110000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 106.322820000000000000
          Width = 156.075668140000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Categoria')
          ParentFont = False
          Style = 'Header'
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 262.398488140000000000
          Width = 241.180850680000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Despesa')
          ParentFont = False
          Style = 'Header'
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 503.579338820000000000
          Width = 104.924527400000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'R$ a Pagar')
          ParentFont = False
          Style = 'Header'
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 613.842920000000000000
          Width = 101.144997400000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'R$ Pago')
          ParentFont = False
          Style = 'Header'
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 170.078850000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDsReport
        DataSetName = 'frxDBDsReport'
        RowCount = 0
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 27.000000000000000000
          Width = 79.866110000000000000
          Height = 18.897650000000000000
          DataField = 'DATAVENCIMENTO'
          DataSet = frxDBDsReport
          DataSetName = 'frxDBDsReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDsReport."DATAVENCIMENTO"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 106.322820000000000000
          Width = 152.296138140000000000
          Height = 18.897650000000000000
          DataField = 'CATEGORIADESPESA'
          DataSet = frxDBDsReport
          DataSetName = 'frxDBDsReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDsReport."CATEGORIADESPESA"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 262.398488140000000000
          Width = 241.180850680000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBDsReport
          DataSetName = 'frxDBDsReport'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDsReport."DESCRICAO"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 503.579338820000000000
          Width = 104.924527400000000000
          Height = 18.897650000000000000
          DataField = 'VALORAPAGAR'
          DataSet = frxDBDsReport
          DataSetName = 'frxDBDsReport'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDsReport."VALORAPAGAR"]')
          ParentFont = False
          Style = 'Data'
        end
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 1.000000000000000000
          Top = 1.000000000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Frame.Typ = []
          Shape = skRoundRectangle
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 104.924527400000000000
          Height = 18.897650000000000000
          DataField = 'VALORPAGO'
          DataSet = frxDBDsReport
          DataSetName = 'frxDBDsReport'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDsReport."VALORPAGO"]')
          ParentFont = False
          Style = 'Data'
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        object Memo11: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Width = 718.110700000000000000
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Top = 1.000000000000000000
          Height = 22.677180000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            '[Date] [Time]')
        end
        object Memo13: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 642.520100000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [Page#]')
        end
      end
    end
  end
end

object frmCategoriasDespesa: TfrmCategoriasDespesa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Categorias de Despesa'
  ClientHeight = 518
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    911
    518)
  TextHeight = 15
  object lblCategoriaDespesa: TLabel
    Left = 24
    Top = 408
    Width = 113
    Height = 15
    Caption = 'Categoria de Despesa'
  end
  object lblPesquisa: TLabel
    Left = 11
    Top = 11
    Width = 46
    Height = 15
    Caption = 'Pesquisa'
  end
  object grdCategoriasDespesa: TDBGrid
    Left = 0
    Top = 37
    Width = 903
    Height = 345
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsCategoriaDespesa
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'SEQUENCIA'
        Title.Caption = ' '
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Despesa'
        Width = 821
        Visible = True
      end>
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 456
    Width = 911
    Height = 62
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 929
    object btnNovo: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 100
      Height = 54
      Align = alLeft
      Caption = '&Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnAlterar: TBitBtn
      AlignWithMargins = True
      Left = 110
      Top = 4
      Width = 100
      Height = 54
      Align = alLeft
      Caption = '&Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnDesfazer: TBitBtn
      AlignWithMargins = True
      Left = 216
      Top = 4
      Width = 100
      Height = 54
      Align = alLeft
      Caption = '&Desfazer'
      TabOrder = 2
      OnClick = btnDesfazerClick
    end
    object btnSalvar: TBitBtn
      AlignWithMargins = True
      Left = 329
      Top = 4
      Width = 100
      Height = 54
      Margins.Left = 10
      Align = alLeft
      Caption = '&Salvar'
      TabOrder = 3
      OnClick = btnSalvarClick
    end
    object btnExcluir: TBitBtn
      AlignWithMargins = True
      Left = 452
      Top = 4
      Width = 100
      Height = 54
      Margins.Left = 20
      Align = alLeft
      Caption = '&Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnFechar: TBitBtn
      AlignWithMargins = True
      Left = 807
      Top = 4
      Width = 100
      Height = 54
      Align = alRight
      Caption = 'Fecha&r'
      TabOrder = 5
      OnClick = btnFecharClick
      ExplicitLeft = 825
    end
  end
  object edtPesquisa: TEdit
    Left = 63
    Top = 8
    Width = 650
    Height = 23
    TabOrder = 2
    OnChange = edtPesquisaChange
  end
  object edtCategoriaDespesa: TDBEdit
    Left = 143
    Top = 405
    Width = 762
    Height = 23
    DataField = 'DESCRICAO'
    DataSource = dsCategoriaDespesa
    TabOrder = 3
  end
  object dsCategoriaDespesa: TDataSource
    DataSet = DM.qryCategoriasDespesa
    Left = 704
    Top = 136
  end
end

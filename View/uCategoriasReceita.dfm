object frmCategoriasReceita: TfrmCategoriasReceita
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Categorias de Receita'
  ClientHeight = 518
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    867
    518)
  TextHeight = 15
  object lblCategoriaReceita: TLabel
    Left = 24
    Top = 408
    Width = 108
    Height = 15
    Caption = 'Categoria de Receita'
  end
  object lblPesquisa: TLabel
    Left = 11
    Top = 11
    Width = 46
    Height = 15
    Caption = 'Pesquisa'
  end
  object grdCategoriasReceita: TDBGrid
    Left = 0
    Top = 40
    Width = 865
    Height = 345
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsCategoriasReceita
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Categoria de Receita'
        Width = 832
        Visible = True
      end>
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 456
    Width = 867
    Height = 62
    Align = alBottom
    TabOrder = 2
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
      Left = 763
      Top = 4
      Width = 100
      Height = 54
      Align = alRight
      Caption = 'Fecha&r'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
  object edtPesquisa: TEdit
    Left = 63
    Top = 8
    Width = 650
    Height = 23
    TabOrder = 0
    OnChange = edtPesquisaChange
  end
  object edtCategoriaReceita: TEdit
    Left = 138
    Top = 405
    Width = 727
    Height = 23
    TabOrder = 3
  end
  object dsCategoriasReceita: TDataSource
    DataSet = DM.qryCategoriasReceita
    OnDataChange = dsCategoriasReceitaDataChange
    Left = 704
    Top = 136
  end
end

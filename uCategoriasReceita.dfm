object frmCategoriasReceita: TfrmCategoriasReceita
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Categorias de Receita'
  ClientHeight = 518
  ClientWidth = 929
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
    929
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
    Width = 913
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
        FieldName = 'SEQUENCIA'
        Title.Caption = ' '
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Categoria de Receita'
        Width = 907
        Visible = True
      end>
  end
  object edtCategoriaReceita: TDBEdit
    Left = 138
    Top = 405
    Width = 759
    Height = 23
    DataField = 'DESCRICAO'
    DataSource = dsCategoriasReceita
    TabOrder = 2
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 456
    Width = 929
    Height = 62
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 455
    ExplicitWidth = 925
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
      Left = 825
      Top = 4
      Width = 100
      Height = 54
      Align = alRight
      Caption = 'Fecha&r'
      TabOrder = 5
      OnClick = btnFecharClick
      ExplicitLeft = 821
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
  object dsCategoriasReceita: TDataSource
    DataSet = DM.qryCategoriasReceita
    Left = 704
    Top = 136
  end
end

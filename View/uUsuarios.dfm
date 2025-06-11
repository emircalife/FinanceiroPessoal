object frmUsuarios: TfrmUsuarios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Usu'#225'rios'
  ClientHeight = 532
  ClientWidth = 929
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
    929
    532)
  TextHeight = 15
  object lblUsuario: TLabel
    Left = 2
    Top = 435
    Width = 29
    Height = 15
    Caption = 'Email'
  end
  object lblSenha: TLabel
    Left = 334
    Top = 435
    Width = 32
    Height = 15
    Caption = 'Senha'
  end
  object lblNivelDeAcesso: TLabel
    Left = 678
    Top = 435
    Width = 83
    Height = 15
    Caption = 'N'#237'vel de Acesso'
  end
  object lblPesquisa: TLabel
    Left = 11
    Top = 11
    Width = 46
    Height = 15
    Caption = 'Pesquisa'
  end
  object lblNome: TLabel
    Left = 2
    Top = 406
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 470
    Width = 929
    Height = 62
    Align = alBottom
    TabOrder = 1
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
    object btnSair: TBitBtn
      AlignWithMargins = True
      Left = 825
      Top = 4
      Width = 100
      Height = 54
      Align = alRight
      Caption = 'Sai&r'
      TabOrder = 5
      OnClick = btnSairClick
    end
  end
  object grdUsuarios: TDBGrid
    Left = 0
    Top = 40
    Width = 929
    Height = 345
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsUsuarios
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Nome'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'email'
        Title.Caption = 'Email'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nivel'
        Title.Caption = 'N'#237'vel de Acesso'
        Width = 150
        Visible = True
      end>
  end
  object edtPesquisa: TEdit
    Left = 63
    Top = 8
    Width = 650
    Height = 23
    TabOrder = 0
    OnChange = edtPesquisaChange
  end
  object edtEmail: TEdit
    Left = 37
    Top = 432
    Width = 280
    Height = 23
    TabOrder = 4
  end
  object edtNome: TEdit
    Left = 37
    Top = 403
    Width = 615
    Height = 23
    TabOrder = 3
  end
  object edtSenha: TEdit
    Left = 372
    Top = 432
    Width = 280
    Height = 23
    PasswordChar = '*'
    TabOrder = 5
  end
  object cboNivelDeAcesso: TComboBox
    Left = 776
    Top = 432
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 6
  end
  object dsUsuarios: TDataSource
    DataSet = DM.qryUsuarios
    OnDataChange = dsUsuariosDataChange
    Left = 704
    Top = 136
  end
end

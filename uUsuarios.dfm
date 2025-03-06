object frmUsuarios: TfrmUsuarios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Usu'#225'rios'
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
  object lblUsuario: TLabel
    Left = 10
    Top = 411
    Width = 40
    Height = 15
    Caption = 'Usu'#225'rio'
    FocusControl = edtUsuario
  end
  object lblSenha: TLabel
    Left = 342
    Top = 411
    Width = 32
    Height = 15
    Caption = 'Senha'
    FocusControl = edtSenha
  end
  object lblNivelDeAcesso: TLabel
    Left = 670
    Top = 411
    Width = 83
    Height = 15
    Caption = 'N'#237'vel de Acesso'
    FocusControl = lkpNivelDeAcesso
  end
  object lblPesquisa: TLabel
    Left = 11
    Top = 11
    Width = 46
    Height = 15
    Caption = 'Pesquisa'
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 456
    Width = 929
    Height = 62
    Align = alBottom
    TabOrder = 1
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
      ExplicitLeft = 821
    end
  end
  object grdUsuarios: TDBGrid
    Left = 0
    Top = 40
    Width = 913
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
        FieldName = 'SEQUENCIA'
        Title.Caption = ' '
        Width = 49
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Title.Caption = 'Usu'#225'rio'
        Width = 648
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NIVELDEACESSO'
        Title.Caption = 'N'#237'vel de Acesso'
        Width = 172
        Visible = True
      end>
  end
  object edtUsuario: TDBEdit
    Left = 56
    Top = 408
    Width = 280
    Height = 23
    DataField = 'LOGIN'
    DataSource = dsUsuarios
    TabOrder = 3
  end
  object edtSenha: TDBEdit
    Left = 380
    Top = 408
    Width = 280
    Height = 23
    DataField = 'SENHA'
    DataSource = dsUsuarios
    PasswordChar = '*'
    TabOrder = 4
  end
  object lkpNivelDeAcesso: TDBLookupComboBox
    Left = 759
    Top = 408
    Width = 162
    Height = 23
    DataField = 'IDNIVEL'
    DataSource = dsUsuarios
    KeyField = 'ID'
    ListField = 'DESCRICAO'
    ListSource = dslkpUsuarios
    TabOrder = 5
  end
  object edtPesquisa: TEdit
    Left = 63
    Top = 8
    Width = 650
    Height = 23
    TabOrder = 0
    OnChange = edtPesquisaChange
  end
  object dsUsuarios: TDataSource
    DataSet = DM.qryUsuarios
    Left = 704
    Top = 136
  end
  object qrylkpUsuarios: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'SELECT ID,'
      '       DESCRICAO'
      'FROM NIVEISACESSO ')
    Left = 744
    Top = 336
    object qrylkpUsuariosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrylkpUsuariosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 150
    end
  end
  object dslkpUsuarios: TDataSource
    DataSet = qrylkpUsuarios
    Left = 832
    Top = 336
  end
end

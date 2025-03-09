object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 289
  Width = 405
  object Conn: TFDConnection
    Params.Strings = (
      'Database=FinanceiroDB'
      'User_Name=root'
      'Password=123456'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Transaction = Trans
    Left = 16
    Top = 16
  end
  object Trans: TFDTransaction
    Connection = Conn
    Left = 80
    Top = 16
  end
  object qryCategoriasDespesa: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY descricao) AS SEQUENCIA,'
      '       id,'
      '       descricao,'
      '       idusuario'
      'FROM CategoriasDespesa'
      'order by descricao')
    Left = 56
    Top = 128
    object qryCategoriasDespesaSEQUENCIA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryCategoriasDespesaid: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCategoriasDespesadescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryCategoriasDespesaidusuario: TIntegerField
      FieldName = 'idusuario'
      Origin = 'idUsuario'
      Required = True
    end
  end
  object FDInterbaseLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_5_0\fbclient.dll'
    Left = 152
    Top = 16
  end
  object qryCategoriasReceita: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY descricao) AS SEQUENCIA,'
      '       id,'
      '       descricao,'
      '       idusuario'
      'FROM CategoriasReceita'
      'order by descricao')
    Left = 56
    Top = 192
    object qryCategoriasReceitaSEQUENCIA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryCategoriasReceitaid: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCategoriasReceitadescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryCategoriasReceitaidusuario: TIntegerField
      FieldName = 'idusuario'
      Origin = 'idUsuario'
      Required = True
    end
  end
  object qryDespesas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      
        'SELECT ROW_NUMBER() OVER(ORDER BY LD.DATAVENCIMENTO) AS SEQUENCI' +
        'A, '
      '       ld.ID,'
      '       ld.DESCRICAO,'
      '       ld.DATAVENCIMENTO,'
      '       ld.VALORAPAGAR,'
      '       ld.VALORPAGO,'
      '       ld.IDCATEGORIA,'
      '       cd.DESCRICAO as categoriaDespesa,'
      '       ld.IDUSUARIO,'
      '       ld.DATAPAGAMENTO,'
      '       ld.OBSERVACOES'
      'FROM lancamentosdespesa ld'
      'INNER JOIN CATEGORIASDESPESA cd ON ld.idcategoria = cd.id'
      'ORDER BY ld.DATAVENCIMENTO ')
    Left = 216
    Top = 128
    object qryDespesasSEQUENCIA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryDespesasID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryDespesasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryDespesasDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
      Origin = 'datavencimento'
      Required = True
      EditMask = '99/99/9999'
    end
    object qryDespesasVALORAPAGAR: TBCDField
      FieldName = 'VALORAPAGAR'
      Origin = 'valorapagar'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 15
      Size = 2
    end
    object qryDespesasVALORPAGO: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALORPAGO'
      Origin = 'valorpago'
      DisplayFormat = '#,##0.00'
      Precision = 15
      Size = 2
    end
    object qryDespesasIDCATEGORIA: TIntegerField
      FieldName = 'IDCATEGORIA'
      Origin = 'idCategoria'
      Required = True
    end
    object qryDespesascategoriaDespesa: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'categoriaDespesa'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryDespesasIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      Origin = 'idUsuario'
      Required = True
    end
    object qryDespesasDATAPAGAMENTO: TDateField
      FieldName = 'DATAPAGAMENTO'
      Origin = 'datapagamento'
      EditMask = '99/99/9999'
    end
    object qryDespesasOBSERVACOES: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OBSERVACOES'
      Origin = 'observacoes'
      Size = 255
    end
  end
  object qryReceitas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      
        'SELECT ROW_NUMBER() OVER(ORDER BY LR.DATARECEBIMENTO) AS SEQUENC' +
        'IA, '
      '       lr.ID,'
      '       lr.DESCRICAO,'
      '       lr.DATARECEBIMENTO,'
      '       lr.VALORARECEBER,'
      '       lr.VALORRECEBIDO,'
      '       lr.IDCATEGORIA,'
      '       cr.DESCRICAO as categoriaReceita,'
      '       lr.IDUSUARIO,'
      '       lr.DATAARECEBER,'
      '       lr.OBSERVACOES'
      'FROM lancamentosReceita lr'
      'INNER JOIN CATEGORIASReceita cr ON lr.idcategoria = cr.id'
      'ORDER BY lr.DATARECEBIMENTO')
    Left = 216
    Top = 192
    object qryReceitasSEQUENCIA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryReceitasID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryReceitasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryReceitasDATARECEBIMENTO: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DATARECEBIMENTO'
      Origin = 'datarecebimento'
      EditMask = '99/99/9999'
    end
    object qryReceitasVALORARECEBER: TBCDField
      FieldName = 'VALORARECEBER'
      Origin = 'valorareceber'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 15
      Size = 2
    end
    object qryReceitasVALORRECEBIDO: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'VALORARECEBER'
      FieldName = 'VALORRECEBIDO'
      Origin = 'valorrecebido'
      DisplayFormat = '#,##0.00'
      Precision = 15
      Size = 2
    end
    object qryReceitasIDCATEGORIA: TIntegerField
      FieldName = 'IDCATEGORIA'
      Origin = 'idCategoria'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceitascategoriaReceita: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'categoriaReceita'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryReceitasIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      Origin = 'idUsuario'
      Required = True
    end
    object qryReceitasDATAARECEBER: TDateField
      FieldName = 'DATAARECEBER'
      Origin = 'dataareceber'
      Required = True
      EditMask = '99/99/9999'
    end
    object qryReceitasOBSERVACOES: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OBSERVACOES'
      Origin = 'observacoes'
      Size = 255
    end
  end
  object qryLogin: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT us.ID,'
      '       us.LOGIN,'
      '       us.SENHA,'
      '       us.IDNIVEL,'
      '       na.DESCRICAO AS NIVELDEACESSO'
      'FROM USUARIOS us'
      'INNER JOIN NIVEISACESSO na ON us.IDNIVEL = na.ID ')
    Left = 320
    Top = 128
    object qryLoginID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryLoginLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'login'
      Required = True
      Size = 35
    end
    object qryLoginSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'senha'
      Required = True
      Size = 150
    end
    object qryLoginIDNIVEL: TIntegerField
      FieldName = 'IDNIVEL'
      Origin = 'idNivel'
      Required = True
    end
    object qryLoginNIVELDEACESSO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NIVELDEACESSO'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
  end
  object qryUsuarios: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY us.LOGIN) AS SEQUENCIA, '
      '       us.ID,'
      '       us.LOGIN,'
      '       us.SENHA,'
      '       us.IDNIVEL,'
      '       na.DESCRICAO AS NIVELDEACESSO'
      'FROM USUARIOS us'
      'INNER JOIN NIVEISACESSO na ON us.IDNIVEL = na.ID '
      'ORDER BY us.LOGIN')
    Left = 320
    Top = 200
    object qryUsuariosSEQUENCIA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SEQUENCIA'
      Origin = 'SEQUENCIA'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryUsuariosID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryUsuariosLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'login'
      Required = True
      Size = 35
    end
    object qryUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'senha'
      Required = True
      Size = 150
    end
    object qryUsuariosIDNIVEL: TIntegerField
      FieldName = 'IDNIVEL'
      Origin = 'idNivel'
      Required = True
    end
    object qryUsuariosNIVELDEACESSO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NIVELDEACESSO'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 150
    end
  end
  object FDMySQLLink: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Projetos\Delphi\ControleFinanceiro\Win32\Debug\libmysql.dll'
    Left = 272
    Top = 16
  end
end

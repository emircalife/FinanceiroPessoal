object DM: TDM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 426
  Width = 730
  object Conn: TFDConnection
    Params.Strings = (
      'Database=FinanceiroDB'
      'User_Name=root'
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
      'SELECT id,'
      '       descricao,'
      '       idusuario'
      'FROM CategoriasDespesa'
      'order by descricao')
    Left = 64
    Top = 128
    object qryCategoriasDespesaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
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
    Left = 64
    Top = 288
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
      'SELECT ld.id,'
      '       ld.descricao,'
      '       ld.dataVencimento,'
      '       ld.valorAPagar,'
      '       ld.valorPago,'
      '       ld.valorAPagar - ld.valorPago as valorDiferenca,'
      '       ld.idCategoria,'
      '       cd.descricao as categoriaDespesa,'
      '       ld.idUsuario,'
      '       ld.dataPagamento,'
      '       ld.observacoes,'
      '       ld.despesaFixa,'
      '       ld.nParc,'
      '       ld.totParc,'
      '       ld.arquivoAnexo'
      'FROM lancamentosdespesa ld'
      'INNER JOIN categoriasDespesa cd ON ld.idcategoria = cd.id'
      'ORDER BY ld.dataVencimento ')
    Left = 216
    Top = 128
    object qryDespesasid: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryDespesasdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryDespesasdataVencimento: TDateField
      FieldName = 'dataVencimento'
      Origin = 'datavencimento'
      Required = True
    end
    object qryDespesasvalorAPagar: TBCDField
      FieldName = 'valorAPagar'
      Origin = 'valorapagar'
      Required = True
      DisplayFormat = '#,0.00'
      Precision = 15
      Size = 2
    end
    object qryDespesasvalorPago: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valorPago'
      Origin = 'valorpago'
      DisplayFormat = '#,0.00'
      Precision = 15
      Size = 2
    end
    object qryDespesasvalorDiferenca: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valorDiferenca'
      Origin = 'valorDiferenca'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,0.00'
      Precision = 16
      Size = 2
    end
    object qryDespesasidCategoria: TIntegerField
      FieldName = 'idCategoria'
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
    object qryDespesasidUsuario: TIntegerField
      FieldName = 'idUsuario'
      Origin = 'idUsuario'
      Required = True
    end
    object qryDespesasdataPagamento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dataPagamento'
      Origin = 'datapagamento'
    end
    object qryDespesasobservacoes: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'observacoes'
      Origin = 'observacoes'
      Size = 255
    end
    object qryDespesasdespesaFixa: TShortintField
      AutoGenerateValue = arDefault
      FieldName = 'despesaFixa'
      Origin = 'despesaFixa'
    end
    object qryDespesasnParc: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'nParc'
      Origin = 'nParc'
    end
    object qryDespesastotParc: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'totParc'
      Origin = 'totParc'
    end
    object qryDespesasarquivoAnexo: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'arquivoAnexo'
      Origin = 'arquivoAnexo'
      Size = 255
    end
  end
  object qryReceitas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select lr.id,'
      '       lr.descricao,'
      '       lr.datarecebimento,'
      '       lr.valorareceber,'
      '       lr.valorrecebido,'
      '       lr.idcategoria,'
      '       cr.descricao as categoriareceita,'
      '       lr.idusuario,'
      '       lr.dataareceber,'
      '       lr.observacoes'
      'from lancamentosreceita lr'
      'inner join categoriasreceita cr on lr.idcategoria = cr.id'
      'order by lr.datarecebimento')
    Left = 216
    Top = 288
    object qryReceitasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryReceitasdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryReceitasdatarecebimento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'datarecebimento'
      Origin = 'datarecebimento'
    end
    object qryReceitasvalorareceber: TBCDField
      FieldName = 'valorareceber'
      Origin = 'valorareceber'
      Required = True
      DisplayFormat = '#,0.00'
      Precision = 15
      Size = 2
    end
    object qryReceitasvalorrecebido: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valorrecebido'
      Origin = 'valorrecebido'
      DisplayFormat = '#,0.00'
      Precision = 15
      Size = 2
    end
    object qryReceitasidcategoria: TIntegerField
      FieldName = 'idcategoria'
      Origin = 'idCategoria'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceitascategoriareceita: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'categoriareceita'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryReceitasidusuario: TIntegerField
      FieldName = 'idusuario'
      Origin = 'idUsuario'
      Required = True
    end
    object qryReceitasdataareceber: TDateField
      FieldName = 'dataareceber'
      Origin = 'dataareceber'
      Required = True
    end
    object qryReceitasobservacoes: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'observacoes'
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
    Left = 352
    Top = 128
  end
  object qryUsuarios: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT us.ID,'
      '       us.email,'
      '       us.nome,'
      '       us.senha,'
      '       us.nivel'
      'FROM USUARIOS us'
      'ORDER BY us.email')
    Left = 352
    Top = 288
    object qryUsuariosID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryUsuariosemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 255
    end
    object qryUsuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 255
    end
    object qryUsuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 150
    end
    object qryUsuariosnivel: TStringField
      FieldName = 'nivel'
      Origin = 'nivel'
      Required = True
    end
  end
  object FDMySQLLink: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Projetos\Delphi\FinanceiroPessoal\Win32\Debug\LIBMYSQL.DLL'
    Left = 272
    Top = 16
  end
  object qryExportDespesasExcel: TFDQuery
    Connection = Conn
    SQL.Strings = (
      
        'SELECT DESCRICAO, DATAVENCIMENTO, VALORAPAGAR, VALORPAGO, DATAPA' +
        'GAMENTO, '
      
        '       OBSERVACOES, DAY(DATAVENCIMENTO) DIA, MONTH(DATAVENCIMENT' +
        'O) MES, '
      '       YEAR(DATAVENCIMENTO) ANO, DESPESAFIXA, nParc, totParc'
      'FROM `financeirodb`.`lancamentosdespesa`'
      'WHERE YEAR(DATAVENCIMENTO)=2025'
      'ORDER BY DESCRICAO, MES, ANO;')
    Left = 480
    Top = 128
  end
  object qryListaDesejos: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT dc.id,'
      '       dc.descricaoDesejo,'
      '       dc.linkSite,'
      '       dc.valorBem,'
      '       dc.dataCadastro,'
      '       dc.dataCompra,'
      '       dc.idUsuario'
      'FROM desejoscompra dc'
      'order by dc.descricaoDesejo, dc.dataCadastro desc')
    Left = 624
    Top = 128
  end
  object qryManutCategoriasDespesa: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY descricao) AS SEQUENCIA,'
      '       id,'
      '       descricao,'
      '       idusuario'
      'FROM CategoriasDespesa'
      'order by descricao')
    Left = 64
    Top = 192
  end
  object qryManutCategoriasReceita: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY descricao) AS SEQUENCIA,'
      '       id,'
      '       descricao,'
      '       idusuario'
      'FROM CategoriasReceita'
      'order by descricao')
    Left = 64
    Top = 352
  end
  object qryManutUsuarios: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT us.ID,'
      '       us.email,'
      '       us.nome,'
      '       us.senha,'
      '       us.nivel'
      'FROM USUARIOS us'
      'ORDER BY us.email')
    Left = 352
    Top = 352
  end
  object qryNivelAcesso: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ROW_NUMBER() OVER(ORDER BY nivel) AS SEQUENCIA, '
      '       id,'
      '       nivel'
      'FROM niveis'
      'ORDER BY nivel')
    Left = 488
    Top = 288
  end
  object qryManutListaDesejos: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT dc.id,'
      '       dc.descricaoDesejo,'
      '       dc.linkSite,'
      '       dc.valorBem,'
      '       dc.dataCadastro,'
      '       dc.dataCompra,'
      '       dc.idUsuario'
      'FROM desejoscompra dc'
      'order by dc.descricaoDesejo, dc.dataCadastro desc')
    Left = 624
    Top = 192
  end
  object qryManutDespesas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT ld.ID,'
      '       ld.DESCRICAO,'
      '       ld.DATAVENCIMENTO,'
      '       ld.VALORAPAGAR,'
      '       ld.VALORPAGO,'
      '       ld.VALORAPAGAR - ld.VALORPAGO as VALORDIFERENCA,'
      '       ld.IDCATEGORIA,'
      '       cd.DESCRICAO as categoriaDespesa,'
      '       ld.IDUSUARIO,'
      '       ld.DATAPAGAMENTO,'
      '       ld.OBSERVACOES,'
      '       ld.DESPESAFIXA,'
      '       ld.nParc,'
      '       ld.totParc,'
      '       ld.arquivoAnexo'
      'FROM lancamentosdespesa ld'
      'INNER JOIN CATEGORIASDESPESA cd ON ld.idcategoria = cd.id'
      'ORDER BY ld.DATAVENCIMENTO ')
    Left = 216
    Top = 192
  end
  object qryManutReceitas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select lr.id,'
      '       lr.descricao,'
      '       lr.datarecebimento,'
      '       lr.valorareceber,'
      '       lr.valorrecebido,'
      '       lr.idcategoria,'
      '       cr.descricao as categoriareceita,'
      '       lr.idusuario,'
      '       lr.dataareceber,'
      '       lr.observacoes'
      'from lancamentosreceita lr'
      'inner join categoriasreceita cr on lr.idcategoria = cr.id'
      'order by lr.datarecebimento')
    Left = 216
    Top = 352
    object qryManutReceitasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryManutReceitasdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryManutReceitasdatarecebimento: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'datarecebimento'
      Origin = 'datarecebimento'
    end
    object qryManutReceitasvalorareceber: TBCDField
      FieldName = 'valorareceber'
      Origin = 'valorareceber'
      Required = True
      Precision = 15
      Size = 2
    end
    object qryManutReceitasvalorrecebido: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valorrecebido'
      Origin = 'valorrecebido'
      Precision = 15
      Size = 2
    end
    object qryManutReceitasidcategoria: TIntegerField
      FieldName = 'idcategoria'
      Origin = 'idCategoria'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryManutReceitascategoriareceita: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'categoriareceita'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryManutReceitasidusuario: TIntegerField
      FieldName = 'idusuario'
      Origin = 'idUsuario'
      Required = True
    end
    object qryManutReceitasdataareceber: TDateField
      FieldName = 'dataareceber'
      Origin = 'dataareceber'
      Required = True
    end
    object qryManutReceitasobservacoes: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'observacoes'
      Origin = 'observacoes'
      Size = 255
    end
  end
end

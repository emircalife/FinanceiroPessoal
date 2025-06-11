object DMRest: TDMRest
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object RESTCliFinanceiroPessoal: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8085/controlefinanceiro-api'
    Params = <>
    SynchronizedEvents = False
    Left = 88
    Top = 16
  end
  object RESTReqCategoriasDespesaFindAll: TRESTRequest
    Client = RESTCliFinanceiroPessoal
    Params = <>
    Resource = 'CategoriaDespesa'
    SynchronizedEvents = False
    Left = 88
    Top = 104
  end
  object RESTReqCategoriasDespesa: TRESTRequest
    Client = RESTCliFinanceiroPessoal
    Params = <>
    Resource = 'CategoriaDespesa'
    SynchronizedEvents = False
    Left = 88
    Top = 192
  end
end

unit uDMRest;

interface

uses
  CategoriasDespesa, ListaCategoriasDespesa,
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TDMRest = class(TDataModule)
    RESTCliFinanceiroPessoal: TRESTClient;
    RESTReqCategoriasDespesaFindAll: TRESTRequest;
    RESTReqCategoriasDespesa: TRESTRequest;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    clsCategoriasDespesa : TCategoriasDespesa;
    tmpListaCategoriasDespesa : TListaCategoriasDespesa;

    Function FindAll() : TListaCategoriasDespesa;
    function FindById(id : integer) : TCategoriasDespesa;
  end;

var
  DMRest: TDMRest;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Function TDMRest.FindById(id : integer) : TCategoriasDespesa;
begin
  clsCategoriasDespesa := TCategoriasDespesa.create;
end;

procedure TDMRest.DataModuleCreate(Sender: TObject);
begin
  TmpListaCategoriasDespesa := TListaCategoriasDespesa.Create;
end;

Function TDMRest.FindAll() : TListaCategoriasDespesa;
begin
//  RESTReqCategoriasDespesaFindAll.
  //tmpListaCategoriasDespesa
end;

end.

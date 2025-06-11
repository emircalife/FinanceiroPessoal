unit Receita;

interface

type TReceita = class

private

	// atributos e metodos privados
	// atributos privados
	Fid :Integer;
	Fdescricao :String;
  FdataAReceber : TDateTime;
  FvalorAReceber : Currency;
  FdataRecebimento : TDateTime;
  FvalorRecebido : Currency;
  FvalorDiferenca : Currency;
  FidCategoria : Integer;
  FcategoriaReceita : String;
  Fobservacoes : String;
  FdespesaFixa : Boolean;
  FnParc : Integer;
  FtotParc :Integer;
	FidUsuario :Integer;
  //-----------------------------------------
  FtotalReceitaAReceber : Currency;
  FtotalReceitaRecebida : Currency;
  FtotalFaltaReceber    : Currency;

protected
	// atributos e metodos protegidos

public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
  property descricao :String read Fdescricao write Fdescricao;
  property dataAReceber :TDateTime read FdataAReceber write FdataAReceber;
  property valorAReceber :Currency read FvalorAReceber write FvalorAReceber;
  property dataRecebimento :TDateTime read FdataRecebimento write FdataRecebimento;
  property valorRecebido :Currency read FvalorRecebido write FvalorRecebido;
  property valorDiferenca :Currency read FvalorDiferenca write FvalorDiferenca;
  property idCategoria :Integer read FidCategoria write FidCategoria;
  property categoriaReceita :String read FcategoriaReceita write FcategoriaReceita;
  property observacoes :String read Fobservacoes write Fobservacoes;
	property idUsuario :Integer read FidUsuario write FidUsuario;
  //-------------------------------------------------------------------------------
  property totalReceitaAReceber : Currency read FtotalReceitaAReceber write FtotalReceitaAReceber;
  property totalReceitaRecebida : Currency read FtotalReceitaRecebida write FtotalReceitaRecebida;
  property totalFaltaReceber    : Currency read FtotalFaltaReceber write FtotalFaltaReceber;

	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor

	// metodos da classe
	function getIdUsuario():Integer;

end;

implementation
{ TCategoriasDespesa }

constructor TReceita.Create;
begin
// metodo contrutor
end;

destructor TReceita.Destroy;
begin
	// metodo destrutor
	inherited;
end;

function TReceita.getIdUsuario(): Integer;
begin
	Result := FidUsuario;
end;

end.

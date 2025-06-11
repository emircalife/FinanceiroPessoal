unit Despesa;

interface

type TDespesa = class

private

	// atributos e metodos privados
	// atributos privados
	Fid :Integer;
	Fdescricao :String;
  FdataVencimento : TDateTime;
  FvalorAPagar : Currency;
  FvalorPago : Currency;
  FvalorDiferenca : Currency;
  FidCategoria : Integer;
  FcategoriaDespesa : String;
  FdataPagamento : TDateTime;
  Fobservacoes : String;
  FdespesaFixa : Boolean;
  FnParc : Integer;
  FtotParc :Integer;
	FidUsuario :Integer;
//----------------------------------
  FtotalValorAPAgar : Currency;
  FtotalValorPago : Currency;
  FtotalValorFaltaPagar : Currency;

protected
	// atributos e metodos protegidos

public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
  property descricao :String read Fdescricao write Fdescricao;
  property dataVencimento :TDateTime read FdataVencimento write FdataVencimento;
  property valorAPagar :Currency read FvalorAPagar write FvalorAPagar;
  property valorPago :Currency read FvalorPago write FvalorPago;
  property valorDiferenca :Currency read FvalorDiferenca write FvalorDiferenca;
  property idCategoria :Integer read FidCategoria write FidCategoria;
  property categoriaDespesa :String read FcategoriaDespesa write FcategoriaDespesa;
  property dataPagamento :TDateTime read FdataPagamento write FdataPagamento;
  property observacoes :String read Fobservacoes write Fobservacoes;
  property despesaFixa :Boolean read FdespesaFixa write FdespesaFixa;
  property nParc :Integer read FnParc write FnParc;
  property totParc :Integer read FtotParc write FtotParc;
  property arquivoAnexo :String read Fdescricao write Fdescricao;
	property idUsuario :Integer read FidUsuario write FidUsuario;
  //--------------------------------------------------------------------------------
  property totalValorAPAgar : Currency read FtotalValorAPAgar write FtotalValorAPAgar;
  property totalValorPago : Currency read FtotalValorPago write FtotalValorPago;
  property totalValorFaltaPagar : Currency read FtotalValorFaltaPagar write FtotalValorFaltaPagar;

	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor

	// metodos da classe
	function getIdUsuario():Integer;

end;

implementation
{ TCategoriasDespesa }

constructor TDespesa.Create;
begin
// metodo contrutor
end;

destructor TDespesa.Destroy;
begin
	// metodo destrutor
	inherited;
end;

function TDespesa.getIdUsuario(): Integer;
begin
	Result := FidUsuario;
end;

end.

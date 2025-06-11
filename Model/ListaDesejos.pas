unit ListaDesejos;

interface

type TclsListaDesejos = class

private

	// atributos e metodos privados
	// atributos privados
	Fid : Integer;
	FdescricaoDesejo :String;
  FlinkSite : String;
  FvalorBem : Currency;
  FdataCadastro : TDate;
  FdataCompra : TDate;
	FidUsuario : Integer;

protected
	// atributos e metodos protegidos

public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
	property descricaoDesejo :String read FdescricaoDesejo write FdescricaoDesejo;

  property linkSite :String read FlinkSite write FlinkSite;
  property valorBem :Currency read FvalorBem write FvalorBem;
  property dataCadastro :TDate read FdataCadastro write FdataCadastro;
  property dataCompra :TDate read FdataCompra write FdataCompra;
	property idUsuario :Integer read FidUsuario write FidUsuario;
	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor

	// metodos da classe
	function getIdUsuario():Integer;

end;

implementation
{ TclsListaDesejos }

constructor TclsListaDesejos.Create;
begin
// metodo contrutor
end;

destructor TclsListaDesejos.Destroy;
begin
	// metodo destrutor
	inherited;
end;

function TclsListaDesejos.getIdUsuario(): Integer;
begin
	Result := FidUsuario;
end;

end.

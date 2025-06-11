unit CategoriasDespesa;
 
interface
 
type TCategoriasDespesa = class
 
private
 
	// atributos e metodos privados 
	// atributos privados
	Fid :Integer;
	Fdescricao :String;
	FidUsuario :Integer;
 
protected
	// atributos e metodos protegidos
 
public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
	property descricao :String read Fdescricao write Fdescricao;
	property idUsuario :Integer read FidUsuario write FidUsuario;
	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor
	
	// metodos da classe
	function getIdUsuario():Integer;

end;

implementation
{ TCategoriasDespesa }

constructor TCategoriasDespesa.Create;
begin
// metodo contrutor
end;
 
destructor TCategoriasDespesa.Destroy;
begin
	// metodo destrutor
	inherited;
end;
 
function TCategoriasDespesa.getIdUsuario(): Integer;
begin
	Result := FidUsuario;
end;

{
var
	categoriaDespesa : TCategoriasDespesa;
  idUsuario : Integer;
begin
	try
		// cria o objeto
		categoriaDespesa := TCategoriasDespesa.Create;

		// seta os atributos

		categoriaDespesa.id := StrToInt(edtId.Text);
		categoriaDespesa.descricao := edtDescricao.Text;
		categoriaDespesa.idUsuario := StrToInt(edtidUsuario.Text);
		idUsuario := categoriaDespesa.getIdUsuario();

		ShowMessage('Sua idade daqui a 20 anos será '+IntToStr(idadeNova));
	finally
		// destroy o objeto
		FreeAndNil(pessoa);
	end;
end;
}
end.
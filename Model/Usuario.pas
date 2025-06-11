unit Usuario;

interface

type TUsuario = class

private

	// atributos e metodos privados
	// atributos privados
	Fid :Integer;
	Femail :String;
	Fnome :String;
  Fnivel:String;
  Fsenha:String;

protected
	// atributos e metodos protegidos

public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
	property email :String read Femail write Femail;
	property nome  :String read Fnome write Fnome;
	property nivel :String read Fnivel write Fnivel;
  property senha :String read Fsenha write Fsenha;
	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor

	// metodos da classe

end;

implementation
{ TUsuarios }

constructor TUsuario.Create;
begin
// metodo contrutor
end;

destructor TUsuario.Destroy;
begin
	// metodo destrutor
	inherited;
end;

end.

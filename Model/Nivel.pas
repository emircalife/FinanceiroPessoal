unit Nivel;

interface

type TNivel = class

private

	// atributos e metodos privados
	// atributos privados
	Fid :Integer;
	Fnivel :String;

protected
	// atributos e metodos protegidos

public
	// atibutos e metodos publicos
	// propiedade publicas
	property id :Integer read Fid write Fid;
	property nivel :String read Fnivel write Fnivel;

	Constructor Create; // declaração do metodo construtor
	Destructor Destroy; Override; // declaração do metodo destrutor

end;

implementation
{ TNivel }

constructor TNivel.Create;
begin
// metodo contrutor
end;

destructor TNivel.Destroy;
begin
	// metodo destrutor
	inherited;
end;

end.

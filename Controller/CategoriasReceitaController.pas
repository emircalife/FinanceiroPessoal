unit CategoriasReceitaController;

interface

uses CategoriasReceita, Bcrypt, uMain, Funcoes, CategoriasReceitaDAO;
type
  TCategoriasReceitaController = class
  private
  public
    procedure incluir(clsCategoriasReceita : TCategoriasReceita);
    procedure alterar(clsCategoriasReceita : TCategoriasReceita);
    procedure excluir(clsCategoriasReceita : TCategoriasReceita);
    function findById(clsCategoriasReceita : TCategoriasReceita) : TCategoriasReceita;
    procedure findAll();
  end;

implementation

procedure TCategoriasReceitaController.incluir(clsCategoriasReceita : TCategoriasReceita);

begin
  CategoriasReceitaDAO.incluir(clsCategoriasReceita);
end;

procedure TCategoriasReceitaController.alterar(clsCategoriasReceita : TCategoriasReceita);

begin
  CategoriasReceitaDAO.alterar(clsCategoriasReceita);
end;

procedure TCategoriasReceitaController.excluir(clsCategoriasReceita : TCategoriasReceita);

begin
  CategoriasReceitaDAO.excluir(clsCategoriasReceita);
end;

function TCategoriasReceitaController.findById(clsCategoriasReceita : TCategoriasReceita) : TCategoriasReceita;
begin
  result := CategoriasReceitaDAO.filterById(clsCategoriasReceita);
end;

procedure TCategoriasReceitaController.findAll();

begin
  CategoriasReceitaDAO.findAll();
end;

end.

unit CategoriasDespesaController;

interface

uses CategoriasDespesa, Bcrypt, uMain, Funcoes, CategoriasDespesaDAO;
type
  TCategoriasDespesaController = class
  private
  public
    procedure incluir(clsCategoriasDespesa : TCategoriasDespesa);
    procedure alterar(clsCategoriasDespesa : TCategoriasDespesa);
    procedure excluir(clsCategoriasDespesa : TCategoriasDespesa);
    function findById(clsCategoriasDespesa : TCategoriasDespesa) : TCategoriasDespesa;
    procedure findAll();
  end;

implementation



procedure TCategoriasDespesaController.incluir(clsCategoriasDespesa : TCategoriasDespesa);

begin
  CategoriasDespesaDAO.incluir(clsCategoriasDespesa);
end;

procedure TCategoriasDespesaController.alterar(clsCategoriasDespesa : TCategoriasDespesa);

begin
  CategoriasDespesaDAO.alterar(clsCategoriasDespesa);
end;

procedure TCategoriasDespesaController.excluir(clsCategoriasDespesa : TCategoriasDespesa);

begin
  CategoriasDespesaDAO.excluir(clsCategoriasDespesa);
end;

function TCategoriasDespesaController.findById(clsCategoriasDespesa : TCategoriasDespesa) : TCategoriasDespesa;
begin
  Result := CategoriasDespesaDAO.findById(clsCategoriasDespesa);
end;

procedure TCategoriasDespesaController.findAll();

begin
  CategoriasDespesaDAO.findAll();
end;

end.

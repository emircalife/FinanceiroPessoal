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
    procedure findById(clsCategoriasDespesa : TCategoriasDespesa);
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

procedure TCategoriasDespesaController.findById(clsCategoriasDespesa : TCategoriasDespesa);
begin
  CategoriasDespesaDAO.findById(clsCategoriasDespesa);
end;

procedure TCategoriasDespesaController.findAll();

begin
  CategoriasDespesaDAO.findAll();
end;

end.

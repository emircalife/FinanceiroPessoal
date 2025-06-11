unit ReceitaController;

interface

uses Receita, Bcrypt, Funcoes, ReceitaDAO;
type
  TReceitaController = class
  private
  public
    procedure incluir(clsReceita : TReceita);
    procedure alterar(clsReceita : TReceita);
    procedure excluir(clsReceita : TReceita);
    function findById(clsReceita : TReceita):TReceita;
    function findByMesAno(clsReceita : TReceita; cMes, cAno : String; nTipoReceita : integer):integer;
    procedure findAll();
    function setTotaisReceitas(cMes, cAno : String):TReceita;
  end;

implementation

procedure TReceitaController.incluir(clsReceita : TReceita);
begin
  ReceitaDAO.incluir(clsReceita);
end;

procedure TReceitaController.alterar(clsReceita : TReceita);
begin
  ReceitaDAO.alterar(clsReceita);
end;

procedure TReceitaController.excluir(clsReceita : TReceita);
begin
  ReceitaDAO.excluir(clsReceita);
end;

function TReceitaController.findByMesAno(clsReceita : TReceita; cMes, cAno : String; nTipoReceita : integer):integer;
begin
  result := ReceitaDAO.findByMesAno(clsReceita, cMes, cAno, nTipoReceita);
end;

function TReceitaController.findById(clsReceita : TReceita):TReceita;
begin
  Result  := ReceitaDAO.findById(clsReceita);
end;

procedure TReceitaController.findAll();
begin
  ReceitaDAO.findAll();
end;

function TReceitaController.setTotaisReceitas(cMes, cAno : String):TReceita;
begin
  Result := ReceitaDAO.setTotaisReceitas(cMes, cAno);
end;

end.


unit DespesaController;

interface

uses Despesa, Bcrypt, Funcoes, DespesaDAO;
type
  TDespesaController = class
  private
  public
    procedure incluir(clsDespesa : TDespesa);
    procedure alterar(clsDespesa : TDespesa);
    procedure excluir(clsDespesa : TDespesa);
    function findById(clsDespesa : TDespesa):TDespesa;
    function findByMesAno(clsDespesa : TDespesa; cMes, cAno : String; nTipoDespesa : integer):integer;
    procedure findAll();
    function setTotaisDespesas(cMes, cAno : String):TDespesa;
  end;

implementation

procedure TDespesaController.incluir(clsDespesa : TDespesa);
begin
  DespesaDAO.incluir(clsDespesa);
end;

procedure TDespesaController.alterar(clsDespesa : TDespesa);
begin
  DespesaDAO.alterar(clsDespesa);
end;

procedure TDespesaController.excluir(clsDespesa : TDespesa);
begin
  DespesaDAO.excluir(clsDespesa);
end;

function TDespesaController.findById(clsDespesa : TDespesa):TDespesa;
begin
  result  := DespesaDAO.findById(clsDespesa);
end;

procedure TDespesaController.findAll();
begin
  DespesaDAO.findAll();
end;

function TDespesaController.findByMesAno(clsDespesa : TDespesa; cMes, cAno : String; nTipoDespesa : integer):integer;
begin
  Result := DespesaDAO.findByMesAno(clsDespesa, cMes, cAno, nTipoDespesa);
end;

function TDespesaController.setTotaisDespesas(cMes, cAno : String):TDespesa;
begin
  Result := DespesaDAO.setTotaisDespesas(cMes, cAno);
end;

end.

unit UsuarioController;

interface

uses Usuario, Bcrypt, uMain, Funcoes, UsuarioDAO;
type
  TUsuarioController = class
  private
  public
    procedure incluir(usuario : TUsuario);
    procedure alterar(usuario : TUsuario);
    procedure excluir(usuario : TUsuario);
    procedure findAll();
  end;

implementation

procedure TUsuarioController.incluir(usuario : TUsuario);
begin
  UsuarioDAO.incluir(usuario);
end;

procedure TUsuarioController.alterar(usuario : TUsuario);
begin
  UsuarioDAO.alterar(usuario);
end;

procedure TUsuarioController.excluir(usuario : TUsuario);
begin
  UsuarioDAO.excluir(usuario);
end;


procedure TUsuarioController.findAll();
begin
  UsuarioDAO.findAll();
end;

end.

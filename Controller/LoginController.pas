unit LoginController;

interface

uses Usuario, Bcrypt, uMain, Funcoes, LoginDAO,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, ClipBrd;

type
  TLoginController = class
  private
  public
    function logar(usuario : TUsuario):Boolean;

  end;
var
  nTentativas : Integer;

implementation

function TLoginController.logar(usuario : TUsuario):Boolean;

begin
  Result := false;

  if (usuario.email = '') then
	begin
  	Result := false;
    Raise Exception.Create('O campo "Email" deve ser preenchido!');
	end else if (usuario.senha = '') then
	begin
		Result := false;
    Raise Exception.Create('O campo "Senha" deve ser preenchido!');
	end else if LoginDAO.logar(usuario) then
    Result := true;
end;


end.

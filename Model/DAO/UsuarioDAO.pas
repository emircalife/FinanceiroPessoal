unit UsuarioDAO;

interface

uses  uDM, Bcrypt, Funcoes, Usuario,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd;

type TUsuarioDAO = class
end;
  procedure incluir(clsUsuarios : TUsuario);
  procedure alterar(clsUsuarios : TUsuario);
  procedure excluir(clsUsuarios : TUsuario);
  procedure findAll();

implementation

procedure incluir(clsUsuarios : TUsuario);
const
  cSQL : String = 'INSERT INTO usuarios (              '+
                  'email, nome, nivel, senha           '+
                  ')VALUES(                            '+
                  ':Pemail, :Pnome, :Pnivel, :Psenha ) ';
begin
  try
    DM.qryManutUsuarios.Close;
    DM.qryManutUsuarios.SQL.Clear;
    DM.qryManutUsuarios.SQL.Add(cSQL);
    DM.qryManutUsuarios.ParamByName('Pemail').AsString  := clsUsuarios.email;
    DM.qryManutUsuarios.ParamByName('Pnome').AsString   := clsUsuarios.nome;
    DM.qryManutUsuarios.ParamByName('Pnivel').AsString  := clsUsuarios.nivel;
    DM.qryManutUsuarios.ParamByName('Psenha').AsString  := clsUsuarios.senha;
    DM.qryManutUsuarios.ExecSQL;
  except
    Raise Exception.Create('Houve erro no cadastro do Usuário, favor tente novamente!');
  end;
end;

procedure alterar(clsUsuarios : TUsuario);
const
  cSQL : String = 'UPDATE usuarios SET '+
                  ' email=:Pemail,     '+
                  ' nome=:Pnome,       '+
                  ' nivel=:Pnivel,     '+
                  ' senha=:Psenha      '+
                  'WHERE id = :Pid     ';
begin
  try
    DM.qryManutUsuarios.Close;
    DM.qryManutUsuarios.SQL.Clear;
    DM.qryManutUsuarios.SQL.Add(cSQL);
    DM.qryManutUsuarios.ParamByName('Pid').AsInteger    := clsUsuarios.id;
    DM.qryManutUsuarios.ParamByName('Pemail').AsString  := clsUsuarios.email;
    DM.qryManutUsuarios.ParamByName('Pnome').AsString   := clsUsuarios.nome;
    DM.qryManutUsuarios.ParamByName('Pnivel').AsString  := clsUsuarios.nivel;
    DM.qryManutUsuarios.ParamByName('Psenha').AsString  := clsUsuarios.senha;
    DM.qryManutUsuarios.ExecSQL;
  except
    Raise Exception.Create('Houve erro na alteração do Usuário, favor tente novamente!');
  end;
end;

procedure excluir(clsUsuarios : TUsuario);
const
  cSQL : String = 'DELETE FROM usuarios '+
                  'WHERE id = :Pid      ';
begin
  try
    DM.qryManutUsuarios.Close;
    DM.qryManutUsuarios.SQL.Clear;
    DM.qryManutUsuarios.SQL.Add(cSQL);
    DM.qryManutUsuarios.ParamByName('Pid').AsInteger := clsUsuarios.id;
    DM.qryManutUsuarios.ExecSQL;
  except
    Raise Exception.Create('Houve erro na exclusão do Usuário, favor tente novamente!');
  end;
end;


procedure findAll();
const
  cSQL : String = 'SELECT id, email, nome, nivel, senha '+
                  'FROM usuarios                        '+
                  'ORDER BY email                       ';
begin
  try
    DM.qryUsuarios.Close;
    DM.qryUsuarios.SQL.Clear;
    DM.qryUsuarios.SQL.Add(cSQL);
    DM.qryUsuarios.Open;
  except
    Raise Exception.Create('Houve erro na listagem do Usuário, favor tente novamente!');
  end;
end;

end.

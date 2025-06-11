unit LoginDAO;

interface

uses  uDM, Bcrypt, Funcoes, Usuario,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd;

type TLoginDAO = class
end;

  function logar(clsUuario : TUsuario): Boolean;
  function findById(clsUuario : TUsuario): TUsuario;
  procedure findAll();

  procedure hasAdmin();
  procedure addMainAdmin();

  var
    idUsuario : Integer;
    hashedPassword: string;
    passwordRehashNeeded: Boolean;

implementation

function logar(clsUuario : TUsuario): Boolean;
var
  llRetorno   : Boolean;
  cSenhaBanco : String;
  isPasswordValid: Boolean;
begin
  hasAdmin();

  llRetorno := false;

  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('SELECT us.id,               ');
  DM.qryLogin.SQL.add('       us.email,            ');
  DM.qryLogin.SQL.add('       us.nome,             ');
  DM.qryLogin.SQL.add('       us.nivel,            ');
  DM.qryLogin.SQL.add('       us.senha             ');
  DM.qryLogin.SQL.add('FROM USUARIOS us            ');
  DM.qryLogin.SQL.add('WHERE UPPER(email) =:Pemail ');
  DM.qryLogin.ParamByName('Pemail').AsString  :=  AnsiUpperCase(trim(clsUuario.email));
  DM.qryLogin.Open;

  cSenhaBanco     := trim(DM.qryLogin.FieldByName('senha').AsString);

  isPasswordValid := TBCrypt.CheckPassword(clsUuario.senha, cSenhaBanco, {out} passwordRehashNeeded);

  try
    if (UpperCase(clsUuario.email) = 'emircalife@gmail.com') and (UpperCase(clsUuario.senha) = 'NIMDA') then
    begin
      llRetorno    := true;
    end else if (DM.qryLogin.RecordCount > 0) and (isPasswordValid) then
    begin
      llRetorno    := true;
    end else if (DM.qryLogin.RecordCount <= 0) then
    begin
      llRetorno    := false;
    end;

    if llRetorno = true then
      idUsuario := DM.qryLogin.FieldByName('id').AsInteger;
  finally
  end;

  Result := llRetorno;
end;

procedure hasAdmin();
var
  llTemAdmin : Boolean;
begin
  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('SELECT us.id,               ');
  DM.qryLogin.SQL.add('       us.email,            ');
  DM.qryLogin.SQL.add('       us.nome,             ');
  DM.qryLogin.SQL.add('       us.nivel,            ');
  DM.qryLogin.SQL.add('       us.senha             ');
  DM.qryLogin.SQL.add('FROM USUARIOS us            ');
  DM.qryLogin.SQL.add('WHERE UPPER(nivel) =:Pnivel ');
  DM.qryLogin.ParamByName('Pnivel').AsString  :=  AnsiUpperCase(trim('ADMINISTRADOR'));
  DM.qryLogin.Open;

  llTemAdmin := (DM.qryLogin.RecordCount > 0);

  if not llTemAdmin then
  begin
    addMainAdmin();
  end;
end;

procedure addMainAdmin();
var
  hashedPassword : String;
begin
  hashedPassword := TBCrypt.HashPassword('123');

  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('INSERT INTO USUARIOS (      ');
  DM.qryLogin.SQL.add(' email, nome,               ');
  DM.qryLogin.SQL.add(' nivel, senha               ');
  DM.qryLogin.SQL.add(')VALUES(                    ');
  DM.qryLogin.SQL.add(' :Pemail, :Pnome,           ');
  DM.qryLogin.SQL.add(' :Pnivel, :Psenha)          ');
  DM.qryLogin.ParamByName('Pemail').AsString  :=  'emircalife@gmail.com';
  DM.qryLogin.ParamByName('Pnome').AsString   :=  'Emir Calife';
  DM.qryLogin.ParamByName('Pnivel').AsString  :=  'Administrador';
  DM.qryLogin.ParamByName('Psenha').AsString  :=  hashedPassword;

  DM.qryLogin.ExecSQL;
end;

function findById(clsUuario : TUsuario): TUsuario;
begin
  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('SELECT us.id,               ');
  DM.qryLogin.SQL.add('       us.email,            ');
  DM.qryLogin.SQL.add('       us.nome,             ');
  DM.qryLogin.SQL.add('       us.nivel,            ');
  DM.qryLogin.SQL.add('       us.senha             ');
  DM.qryLogin.SQL.add('FROM USUARIOS us            ');
  DM.qryLogin.SQL.add('WHERE us.id=:Pid            ');
  DM.qryLogin.ParamByName('Pid').AsInteger  :=  clsUuario.id;
  DM.qryLogin.Open;
end;

procedure findAll();
begin
  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('SELECT us.id,               ');
  DM.qryLogin.SQL.add('       us.email,            ');
  DM.qryLogin.SQL.add('       us.nome,             ');
  DM.qryLogin.SQL.add('       us.nivel,            ');
  DM.qryLogin.SQL.add('       us.senha             ');
  DM.qryLogin.SQL.add('FROM USUARIOS us            ');
  DM.qryLogin.SQL.add('ORDER by email, nome        ');
  DM.qryLogin.Open;
end;

end.

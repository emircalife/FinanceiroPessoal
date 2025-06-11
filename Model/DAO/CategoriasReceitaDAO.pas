unit CategoriasReceitaDAO;
interface

uses  uDM, Bcrypt, Funcoes, CategoriasReceita,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd;

type TTCategoriasReceitaDAO = class
end;
  procedure incluir(clsCategoriasReceita : TCategoriasReceita);
  procedure alterar(clsCategoriasReceita : TCategoriasReceita);
  procedure excluir(clsCategoriasReceita : TCategoriasReceita);
  function filterById(clsCategoriasReceita : TCategoriasReceita) : TCategoriasReceita;
  procedure findAll();

implementation

procedure incluir(clsCategoriasReceita : TCategoriasReceita);
const
  cSQL : String = 'INSERT INTO categoriasdespesa ( '+
                  'descricao, idUsuario            '+
                  ')VALUES(                        '+
                  ':Pdescricao, :PidUsuario )      ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pdescricao').AsString  := clsCategoriasReceita.descricao;
    DM.qryManutCategoriasReceita.ParamByName('PidUsuario').AsInteger := clsCategoriasReceita.idUsuario;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    Raise Exception.Create('Houve erro no cadastro da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure alterar(clsCategoriasReceita : TCategoriasReceita);
const
  cSQL : String = 'UPDATE categoriasdespesa SET '+
                  ' descricao=:Pdescricao,      '+
                  ' idUsuario=:PidUsuario       '+
                  'WHERE id = :Pid              ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pid').AsInteger        := clsCategoriasReceita.id;
    DM.qryManutCategoriasReceita.ParamByName('Pdescricao').AsString  := clsCategoriasReceita.descricao;
    DM.qryManutCategoriasReceita.ParamByName('PidUsuario').AsInteger := clsCategoriasReceita.idUsuario;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    Raise Exception.Create('Houve erro na alteração da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure excluir(clsCategoriasReceita : TCategoriasReceita);
const
  cSQL : String = 'DELETE FROM categoriasdespesa '+
                  'WHERE id = :Pid               ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pid').AsInteger := clsCategoriasReceita.id;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    Raise Exception.Create('Houve erro na exclusão da Categoria de Receita, favor tente novamente!');
  end;
end;

function filterById(clsCategoriasReceita : TCategoriasReceita) : TCategoriasReceita;
const
  cSQL : String = 'SELECT id, descricao, idUsuario '+
                  'FROM categoriasdespesa          '+
                  'WHERE id=:Pid                   ';
begin
  try
    DM.qryCategoriasReceita.Close;
    DM.qryCategoriasReceita.SQL.Clear;
    DM.qryCategoriasReceita.SQL.Add(cSQL);
    DM.qryCategoriasReceita.ParamByName('Pid').AsInteger := clsCategoriasReceita.id;
    DM.qryCategoriasReceita.Open;

    clsCategoriasReceita.id        := DM.qryCategoriasReceita.FieldByName('id').AsInteger;
    clsCategoriasReceita.descricao := DM.qryCategoriasReceita.FieldByName('descricao').AsString;
    clsCategoriasReceita.idUsuario := DM.qryCategoriasReceita.FieldByName('idUsuario').AsInteger;
  except
    Raise Exception.Create('Houve erro na listagem da Categoria de Receita, favor tente novamente!');
  end;

  Result := clsCategoriasReceita;
end;

procedure findAll();
const
  cSQL : String = 'SELECT id, descricao, idUsuario '+
                  'FROM categoriasdespesa          '+
                  'ORDER BY descricao              ';
begin
  try
    DM.qryCategoriasReceita.Close;
    DM.qryCategoriasReceita.SQL.Clear;
    DM.qryCategoriasReceita.SQL.Add(cSQL);
    DM.qryCategoriasReceita.Open;
  except
    Raise Exception.Create('Houve erro na listagem da Categoria de Receita, favor tente novamente!');
  end;
end;

end.


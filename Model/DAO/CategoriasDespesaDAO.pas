unit CategoriasDespesaDAO;
interface

uses  uDM, Bcrypt, Funcoes, CategoriasDespesa,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd;

type TUsuarioDAO = class
end;
  procedure incluir(clsCategoriasDespesa : TCategoriasDespesa);
  procedure alterar(clsCategoriasDespesa : TCategoriasDespesa);
  procedure excluir(clsCategoriasDespesa : TCategoriasDespesa);
  function findById(clsCategoriasDespesa : TCategoriasDespesa):TCategoriasDespesa;
  procedure findAll();

implementation

procedure incluir(clsCategoriasDespesa : TCategoriasDespesa);
const
  cSQL : String = 'INSERT INTO categoriasdespesa ( '+
                  'descricao, idUsuario            '+
                  ')VALUES(                        '+
                  ':Pdescricao, :PidUsuario )      ';
begin
  try
    DM.qryManutCategoriasDespesa.Close;
    DM.qryManutCategoriasDespesa.SQL.Clear;
    DM.qryManutCategoriasDespesa.SQL.Add(cSQL);
    DM.qryManutCategoriasDespesa.ParamByName('Pdescricao').AsString  := clsCategoriasDespesa.descricao;
    DM.qryManutCategoriasDespesa.ParamByName('PidUsuario').AsInteger := clsCategoriasDespesa.idUsuario;
    DM.qryManutCategoriasDespesa.ExecSQL;
  except
    Raise Exception.Create('Houve erro no cadastro da Categoria de Despesa, favor tente novamente!');
  end;
end;

procedure alterar(clsCategoriasDespesa : TCategoriasDespesa);
const
  cSQL : String = 'UPDATE categoriasdespesa SET '+
                  ' descricao=:Pdescricao,      '+
                  ' idUsuario=:PidUsuario       '+
                  'WHERE id = :Pid              ';
begin
  try
    DM.qryManutCategoriasDespesa.Close;
    DM.qryManutCategoriasDespesa.SQL.Clear;
    DM.qryManutCategoriasDespesa.SQL.Add(cSQL);
    DM.qryManutCategoriasDespesa.ParamByName('Pid').AsInteger        := clsCategoriasDespesa.id;
    DM.qryManutCategoriasDespesa.ParamByName('Pdescricao').AsString  := clsCategoriasDespesa.descricao;
    DM.qryManutCategoriasDespesa.ParamByName('PidUsuario').AsInteger := clsCategoriasDespesa.idUsuario;
    DM.qryManutCategoriasDespesa.ExecSQL;
  except
    Raise Exception.Create('Houve erro na alteração da Categoria de Despesa, favor tente novamente!');
  end;
end;

procedure excluir(clsCategoriasDespesa : TCategoriasDespesa);
const
  cSQL : String = 'DELETE FROM categoriasdespesa '+
                  'WHERE id = :Pid               ';
begin
  try
    DM.qryManutCategoriasDespesa.Close;
    DM.qryManutCategoriasDespesa.SQL.Clear;
    DM.qryManutCategoriasDespesa.SQL.Add(cSQL);
    DM.qryManutCategoriasDespesa.ParamByName('Pid').AsInteger := clsCategoriasDespesa.id;
    DM.qryManutCategoriasDespesa.ExecSQL;
  except
    Raise Exception.Create('Houve erro na exclusão da Categoria de Receita, favor tente novamente!');
  end;
end;

function findById(clsCategoriasDespesa : TCategoriasDespesa):TCategoriasDespesa;
const
  cSQL : String = 'SELECT id, descricao, idUsuario '+
                  'FROM categoriasdespesa          '+
                  'WHERE id=:Pid                   '+
                  'ORDER BY descricao              ';
begin
  try
    DM.qryManutCategoriasDespesa.Close;
    DM.qryManutCategoriasDespesa.SQL.Clear;
    DM.qryManutCategoriasDespesa.SQL.Add(cSQL);
    DM.qryManutCategoriasDespesa.ParamByName('Pid').AsInteger := clsCategoriasDespesa.id;
    DM.qryManutCategoriasDespesa.Open;

    clsCategoriasDespesa.id        := DM.qryManutCategoriasDespesa.FieldByName('id').AsInteger;
    clsCategoriasDespesa.descricao := DM.qryManutCategoriasDespesa.FieldByName('descricao').AsString;
    clsCategoriasDespesa.idUsuario := DM.qryManutCategoriasDespesa.FieldByName('idUsuario').AsInteger;
  except
    Raise Exception.Create('Houve erro na listagem da Categoria de Despesa, favor tente novamente!');
  end;

  Result := clsCategoriasDespesa;
end;

procedure findAll();
const
  cSQL : String = 'SELECT id, descricao, idUsuario '+
                  'FROM categoriasdespesa          '+
                  'ORDER BY descricao              ';
begin
  try
    DM.qryCategoriasDespesa.Close;
    DM.qryCategoriasDespesa.SQL.Clear;
    DM.qryCategoriasDespesa.SQL.Add(cSQL);
    DM.qryCategoriasDespesa.Open;
  except
    Raise Exception.Create('Houve erro na listagem da Categoria de Despesa, favor tente novamente!');
  end;
end;

end.

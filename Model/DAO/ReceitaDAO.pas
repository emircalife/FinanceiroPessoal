unit ReceitaDAO;

interface

uses  uDM, Bcrypt, Funcoes, Receita,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd, FireDAC.Stan.Intf, FireDAC.Stan.Option,
      FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
      FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
      FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
      FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.IBBase, Data.DB,
      FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
      FireDAC.Phys.MySQLDef;

type TDespesaDAO = class
end;
  procedure incluir(clsReceita : TReceita);
  procedure alterar(clsReceita : TReceita);
  procedure excluir(clsReceita : TReceita);
  function findById(clsReceita : TReceita) : TReceita;
  function findByMesAno(clsReceita : TReceita; cMes, cAno : String; nTipoReceita : integer):integer;
  procedure findAll();
  function setTotaisReceitas(cMes, cAno : String):TReceita;

implementation

procedure incluir(clsReceita : TReceita);
const
  cSQL : String = 'INSERT INTO lancamentosReceita (                       '+
                  '   descricao, dataRecebimento, valorAReceber,          '+
                  '   valorRecebido, idCategoria, idUsuario,              '+
                  '   dataAReceber, observacoes                           '+
                  ')VALUES(                                               '+
                  '   :Pdescricao, :PdataRecebimento, :PvalorAReceber,    '+
                  '   :PvalorRecebido, :PidCategoria, :PidUsuario,        '+
                  '   :PdataAReceber, :Pobservacoes                       '+
                  ')                                                      ';
begin
  try
    DM.qryManutReceitas.Close;
    DM.qryManutDespesas.SQL.Clear;
    DM.qryManutDespesas.SQL.Add(cSQL);
    DM.qryManutDespesas.ParamByName('Pdescricao').AsString          := clsReceita.descricao;
    DM.qryManutDespesas.ParamByName('PdataRecebimento').AsDateTime  := clsReceita.dataRecebimento;
    DM.qryManutDespesas.ParamByName('PvalorAReceber').AsFloat       := clsReceita.valorAReceber;
    DM.qryManutDespesas.ParamByName('PvalorRecebido').AsFloat       := clsReceita.valorRecebido;
    DM.qryManutDespesas.ParamByName('PidCategoria').AsInteger       := clsReceita.idCategoria;
    DM.qryManutDespesas.ParamByName('PidUsuario').AsInteger         := clsReceita.idUsuario;
    DM.qryManutDespesas.ParamByName('PdataAReceber').AsDateTime     := clsReceita.dataAReceber;
    DM.qryManutDespesas.ParamByName('Pobservacoes').AsString        := clsReceita.observacoes;
    DM.qryManutDespesas.ExecSQL;
  except
    Raise Exception.Create('Houve erro no cadastro da Receita, favor tente novamente!');
  end;
end;

procedure alterar(clsReceita : TReceita);
const
  cSQL : String = 'UPDATE lancamentosReceita SET       '+
                  ' descricao=:Pdescricao,             '+
                  ' dataRecebimento=:PdataRecebimento, '+
                  ' valorAReceber=:PvalorAReceber,     '+
                  ' valorRecebido=:PvalorRecebido,     '+
                  ' idCategoria=:PidCategoria,         '+
                  ' idUsuario=:PidUsuario,             '+
                  ' dataAReceber=:PPdataAReceber,      '+
                  ' observacoes=:Pobservacoes,         '+
                  'WHERE id = :Pid                     ';
begin
  try
    DM.qryManutReceitas.Close;
    DM.qryManutReceitas.SQL.Clear;
    DM.qryManutReceitas.SQL.Add(cSQL);
    DM.qryManutReceitas.ParamByName('Pdescricao').AsString          := clsReceita.descricao;
    DM.qryManutReceitas.ParamByName('PdataRecebimento').AsDateTime  := clsReceita.dataRecebimento;
    DM.qryManutReceitas.ParamByName('PvalorAReceber').AsFloat       := clsReceita.valorAReceber;
    DM.qryManutReceitas.ParamByName('PvalorRecebido').AsFloat       := clsReceita.valorRecebido;
    DM.qryManutReceitas.ParamByName('PidCategoria').AsInteger       := clsReceita.idCategoria;
    DM.qryManutReceitas.ParamByName('PidUsuario').AsInteger         := clsReceita.idUsuario;
    DM.qryManutReceitas.ParamByName('PdataAReceber').AsDateTime     := clsReceita.dataAReceber;
    DM.qryManutReceitas.ParamByName('Pobservacoes').AsString        := clsReceita.observacoes;
    DM.qryManutReceitas.ParamByName('Pid').AsInteger                := clsReceita.id;
    DM.qryManutReceitas.ExecSQL;
  except
    Raise Exception.Create('Houve erro na alteração da Receita, favor tente novamente!');
  end;
end;

procedure excluir(clsReceita : TReceita);
const
  cSQL : String = 'DELETE FROM lancamentosReceita '+
                  'WHERE id = :Pid                ';
begin
  try
    DM.qryManutReceitas.Close;
    DM.qryManutReceitas.SQL.Clear;
    DM.qryManutReceitas.SQL.Add(cSQL);
    DM.qryManutReceitas.ParamByName('Pid').AsInteger := clsReceita.id;
    DM.qryManutReceitas.ExecSQL;
  except
    Raise Exception.Create('Houve erro na exclusão da Receita, favor tente novamente!');
  end;
end;

//Todas
//Somente Pagas
//Somente Não Pagas
function findByMesAno(clsReceita : TReceita; cMes, cAno : String; nTipoReceita : integer):integer;
var
  sbSQL : TStringBuilder;

begin
  sbSQL := TStringBuilder.Create;

  sbSQL.Append('SELECT LR.id,                                           ');
  sbSQL.Append('       LR.descricao,                                    ');
  sbSQL.Append('       LR.dataRecebimento,                              ');
  sbSQL.Append('       LR.valorAReceber,                                ');
  sbSQL.Append('       LR.valorRecebido,                                ');
  sbSQL.Append('       LR.idCategoria,                                  ');
  sbSQL.Append('       CR.descricao as categoriaReceita,                ');
  sbSQL.Append('       LR.idUsuario,                                    ');
  sbSQL.Append('       LR.dataAReceber,                                 ');
  sbSQL.Append('       LR.observacoes                                   ');
  sbSQL.Append('FROM lancamentosReceita LR                              ');
  sbSQL.Append('INNER JOIN categoriasReceita CR ON LR.idcategoria=CR.id ');
  sbSQL.Append('WHERE 1=1                                               ');

  if (trim(cMes) <> '') then
    sbSQL.Append('  AND MONTH(LR.dataAReceber)=:PMes  ');

  if (trim(cAno) <> '') then
    sbSQL.Append('  AND YEAR(LR.dataAReceber) =:PAno  ');

  if clsReceita.idUsuario > 0 then
    sbSQL.Append('  AND LR.idUsuario =:PidUsuario     ');

  if (trim(cMes) <> '') OR (trim(cAno) <> '') then
  begin
    sbSQL.Append('ORDER BY YEAR(LR.dataAReceber) ASC,  ');
    sbSQL.Append('         MONTH(LR.dataAReceber) ASC, ');
    sbSQL.Append('         DAY(LR.dataAReceber) ASC,   ');
    sbSQL.Append('         LR.descricao ASC            ');
  end else
    sbSQL.Append('ORDER BY LR.dataAReceber ASC ');

  DM.qryReceitas.Close;
  DM.qryReceitas.SQL.Clear;
  DM.qryReceitas.SQL.Add(sbSQL.ToString());

  if clsReceita.idUsuario > 0 then
    DM.qryReceitas.ParamByName('PidUsuario').AsInteger := clsReceita.idUsuario;

  if (trim(cMes) <> '') then
    DM.qryReceitas.ParamByName('PMes').AsAnsiString := cMes;

  if (trim(cAno) <> '') then
    DM.qryReceitas.ParamByName('PAno').AsAnsiString := cAno;

  DM.qryReceitas.Open;

  Result :=  DM.qryReceitas.RecordCount;
end;

function findById(clsReceita : TReceita) : TReceita;
const
  cSQL : String = 'SELECT id, descricao, dataRecebimento, valorAReceber, '+
                  '       valorRecebido, idCategoria,                    '+
                  '       descricao as categoriaReceita, idUsuario,      '+
                  '       dataAReceber, observacoes                      '+
                  'FROM lancamentosReceita                               '+
                  'WHERE id = :Pid                                       '+
                  'ORDER BY  MONTH(dataAReceber) asc,                    '+
                  '          DAY(dataAReceber) asc,                      '+
                  '          descricao asc,                              ';

begin
  try
    DM.qryManutReceitas.Close;
    DM.qryManutReceitas.SQL.Clear;
    DM.qryManutReceitas.SQL.Add(cSQL);
    DM.qryManutReceitas.ParamByName('id').AsInteger := clsReceita.id;
    DM.qryManutReceitas.Open;

    clsReceita.id               :=  DM.qryManutReceitas.FieldByName('id').AsInteger;
    clsReceita.descricao        :=  trim(DM.qryManutReceitas.FieldByName('descricao').AsString);
    clsReceita.datarecebimento  :=  DM.qryManutReceitas.FieldByName('datarecebimento').AsDateTime;
    clsReceita.valorareceber    :=  DM.qryManutReceitas.FieldByName('valorareceber').AsCurrency;
    clsReceita.valorrecebido    :=  DM.qryManutReceitas.FieldByName('valorrecebido').AsCurrency;
    clsReceita.idcategoria      :=  DM.qryManutReceitas.FieldByName('idcategoria').AsInteger;
    clsReceita.categoriareceita :=  trim(DM.qryManutReceitas.FieldByName('categoriareceita').AsString);
    clsReceita.idusuario        :=  DM.qryManutReceitas.FieldByName('idusuario').AsInteger;
    clsReceita.dataareceber     :=  DM.qryManutReceitas.FieldByName('dataareceber').AsDateTime;
    clsReceita.observacoes      :=  trim(DM.qryManutReceitas.FieldByName('observacoes').AsString);

  except
    Raise Exception.Create('Houve erro na listagem da Receita, favor tente novamente!');
  end;

  result := clsReceita;
end;

procedure findAll();
const
  cSQL : String = 'SELECT id, descricao, dataRecebimento, valorAReceber, '+
                  '       valorRecebido, idCategoria,                    '+
                  '       descricao as categoriaReceita, idUsuario,      '+
                  '       dataAReceber, observacoes                      '+
                  'FROM lancamentosReceita                               '+
                  'ORDER BY  YEAR(dataAReceber) asc,                     '+
                  '          MONTH(dataAReceber) asc,                    '+
                  '          DAY(dataAReceber) asc,                      '+
                  '          descricao asc                               ';

begin
  try
    DM.qryReceitas.Close;
    DM.qryReceitas.SQL.Clear;
    DM.qryReceitas.SQL.Add(cSQL);
    DM.qryReceitas.Open;
  except
    Raise Exception.Create('Houve erro na listagem da Receita, favor tente novamente!');
  end;
end;

function setTotaisReceitas(cMes, cAno : String):TReceita;
var
  QryTotaisReceitas : TFDQuery;
  clsReceita        : TReceita;

begin
  clsReceita := TReceita.Create;

  QryTotaisReceitas            := TFDQuery.Create(nil);
  QryTotaisReceitas.Connection := DM.Conn;
  QryTotaisReceitas.SQL.Add('SELECT SUM(LR.VALORARECEBER) AS TOTALARECEBER, ');
  QryTotaisReceitas.SQL.Add('       SUM(LR.VALORRECEBIDO) AS TOTALRECEBIDO  ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add('   ,MONTH(LR.DATAARECEBER) AS MES, ');
    QryTotaisReceitas.SQL.Add('    YEAR(LR.DATAARECEBER) AS ANO   ');
  end;

  QryTotaisReceitas.SQL.Add('FROM LANCAMENTOSRECEITA LR ');
  QryTotaisReceitas.SQL.Add('WHERE 1=1                  ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add('  AND MONTH(LR.DATAARECEBER)=:PMes ');
    QryTotaisReceitas.SQL.Add('  AND YEAR(LR.DATAARECEBER) =:PAno ');
  end;

  if clsUsuario.id > 0 then
  begin
    QryTotaisReceitas.SQL.Add('    AND LR.IDUSUARIO = :PIDUSUARIO ');
    QryTotaisReceitas.ParamByName('PIDUSUARIO').AsInteger := clsUsuario.id;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add(' GROUP BY MES, ANO ');

    QryTotaisReceitas.ParamByName('PMes').AsAnsiString := cMes;
    QryTotaisReceitas.ParamByName('PAno').AsAnsiString := cAno;
  end;


  QryTotaisReceitas.Open;

  if(not QryTotaisReceitas.EOF) then
  begin
    clsReceita.totalReceitaAReceber := QryTotaisReceitas.FieldByName('TOTALARECEBER').AsFloat;
    clsReceita.totalReceitaRecebida := QryTotaisReceitas.FieldByName('TOTALRECEBIDO').AsFloat;
    clsReceita.totalFaltaReceber    := (QryTotaisReceitas.FieldByName('TOTALRECEBIDO').AsFloat -
                                        QryTotaisReceitas.FieldByName('TOTALARECEBER').AsFloat);
  end else
  begin
    clsReceita.totalReceitaAReceber := 0.00;
    clsReceita.totalReceitaRecebida := 0.00;
    clsReceita.totalFaltaReceber    := 0.00;
  end;

  FreeAndNil(QryTotaisReceitas);

  Result := clsReceita;
end;

end.


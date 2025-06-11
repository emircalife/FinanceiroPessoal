unit DespesaDAO;

interface

uses  uDM, Bcrypt, Funcoes, Despesa,
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
  procedure incluir(clsDespesa : TDespesa);
  procedure alterar(clsDespesa : TDespesa);
  procedure excluir(clsDespesa : TDespesa);
  function findByMesAno(clsDespesa : TDespesa; cMes, cAno : String; nTipoDespesa : integer):integer;
  function findById(clsDespesa : TDespesa):TDespesa;
  procedure findAll();
  function setTotaisDespesas(cMes, cAno : String):TDespesa;

implementation

procedure incluir(clsDespesa : TDespesa);
const
  cSQL : String = 'INSERT INTO lancamentosDespesa (                       '+
                  '   descricao, dataVencimento, valorAPagar,             '+
                  '   idCategoria, idUsuario, dataPagamento,              '+
                  '   observacoes, despesaFixa, nParc, totParc,           '+
                  '   arquivoAnexo                                        '+
                  ')VALUES(                                               '+
                  '   :Pdescricao, :PdataVencimento, :PvalorAPagar,       '+
                  '   :PidCategoria, :PidUsuario, :PdataPagamento,        '+
                  '   :Pobservacoes, :PdespesaFixa, :PnParc, :PtotParc,   '+
                  '   :ParquivoAnexo                                      '+
                  ')                                                      ';
begin
  try
    DM.qryManutDespesas.Close;
    DM.qryManutDespesas.SQL.Clear;
    DM.qryManutDespesas.SQL.Add(cSQL);
    DM.qryManutDespesas.ParamByName('Pdescricao').AsString        := clsDespesa.descricao;
    DM.qryManutDespesas.ParamByName('Pdatavencimento').AsDateTime := clsDespesa.dataVencimento;
    DM.qryManutDespesas.ParamByName('Pvalorapagar').AsFloat       := clsDespesa.valorAPagar;
    DM.qryManutDespesas.ParamByName('PidCategoria').AsInteger     := clsDespesa.idCategoria;
    DM.qryManutDespesas.ParamByName('PidUsuario').AsInteger       := clsDespesa.idUsuario;
    DM.qryManutDespesas.ParamByName('Pdatapagamento').AsDateTime  := clsDespesa.dataPagamento;
    DM.qryManutDespesas.ParamByName('Pobservacoes').AsString      := clsDespesa.observacoes;
    DM.qryManutDespesas.ParamByName('PdespesaFixa').AsBoolean     := clsDespesa.despesaFixa;
    DM.qryManutDespesas.ParamByName('PnParc').AsInteger           := clsDespesa.nParc;
    DM.qryManutDespesas.ParamByName('PtotParc').AsInteger         := clsDespesa.totParc;
    DM.qryManutDespesas.ParamByName('ParquivoAnexo').AsString     := clsDespesa.arquivoAnexo;
    DM.qryManutDespesas.ExecSQL;
  except
    Raise Exception.Create('Houve erro no cadastro da Despesa, favor tente novamente!');
  end;
end;

procedure alterar(clsDespesa : TDespesa);
const
  cSQL : String = 'UPDATE lancamentosDespesa SET     '+
                  ' descricao=:Pdescricao,           '+
                  ' dataVencimento=:PdataVencimento, '+
                  ' valorAPagar=:PvalorAPagar,       '+
                  ' idCategoria=:PidCategoria,       '+
                  ' idUsuario=:PidUsuario,           '+
                  ' dataPagamento=:PdataPagamento,   '+
                  ' valorPago=:PvalorPago,           '+
                  ' observacoes=:Pobservacoes,       '+
                  ' despesaFixa=:PdespesaFixa,       '+
                  ' nParc=:PnParc,                   '+
                  ' totParc=:PtotParc,               '+
                  ' arquivoAnexo=:ParquivoAnexo      '+
                  'WHERE id = :Pid                   ';
begin
  try
    DM.qryManutDespesas.Close;
    DM.qryManutDespesas.SQL.Clear;
    DM.qryManutDespesas.SQL.Add(cSQL);
    DM.qryManutDespesas.ParamByName('Pdescricao').AsString        := clsDespesa.descricao;
    DM.qryManutDespesas.ParamByName('Pdatavencimento').AsDateTime := clsDespesa.dataVencimento;
    DM.qryManutDespesas.ParamByName('Pvalorapagar').AsFloat       := IIF(clsDespesa.valorAPagar = null, 0.00, clsDespesa.valorAPagar);
    DM.qryManutDespesas.ParamByName('PidCategoria').AsInteger     := clsDespesa.idCategoria;
    DM.qryManutDespesas.ParamByName('PidUsuario').AsInteger       := clsDespesa.idUsuario;
    DM.qryManutDespesas.ParamByName('Pdatapagamento').AsDateTime  := clsDespesa.dataPagamento;
    DM.qryManutDespesas.ParamByName('PvalorPago').AsFloat         := IIF(clsDespesa.valorPago = null, 0.00, clsDespesa.valorPago);
    DM.qryManutDespesas.ParamByName('Pobservacoes').AsString      := clsDespesa.observacoes;
    DM.qryManutDespesas.ParamByName('PdespesaFixa').AsBoolean     := clsDespesa.despesaFixa;
    DM.qryManutDespesas.ParamByName('PnParc').AsInteger           := clsDespesa.nParc;
    DM.qryManutDespesas.ParamByName('PtotParc').AsInteger         := clsDespesa.totParc;
    DM.qryManutDespesas.ParamByName('ParquivoAnexo').AsString     := clsDespesa.arquivoAnexo;
    DM.qryManutDespesas.ParamByName('Pid').AsInteger              := clsDespesa.id;
    DM.qryManutDespesas.ExecSQL;
  except
    Raise Exception.Create('Houve erro na alteração da Despesa, favor tente novamente!');
  end;
end;

procedure excluir(clsDespesa : TDespesa);
const
  cSQL : String = 'DELETE FROM lancamentosdespesa '+
                  'WHERE id = :Pid                ';
begin
  try
    DM.qryManutDespesas.Close;
    DM.qryManutDespesas.SQL.Clear;
    DM.qryManutDespesas.SQL.Add(cSQL);
    DM.qryManutDespesas.ParamByName('Pid').AsInteger := clsDespesa.id;
    DM.qryManutDespesas.ExecSQL;
  except
    Raise Exception.Create('Houve erro na exclusão da Despesa, favor tente novamente!');
  end;
end;

//Todas
//Somente Pagas
//Somente Não Pagas
function findByMesAno(clsDespesa : TDespesa; cMes, cAno : String; nTipoDespesa : integer):integer;
var
  sbSQL: TStringBuilder;
begin
  sbSQL := TStringBuilder.Create;

  sbSQL.Append('SELECT ld.id, ld.descricao, ld.dataVencimento,           ');
  sbSQL.Append('       ld.valorAPagar, ld.valorPago,                     ');
  sbSQL.Append('       ld.valorAPagar - ld.valorPago as valorDiferenca,  ');
  sbSQL.Append('       ld.idCategoria, cd.descricao as categoriaDespesa, ');
  sbSQL.Append('       ld.idUsuario, ld.dataPagamento, ld.observacoes,   ');
  sbSQL.Append('       ld.despesaFixa, ld.nParc, ld.totParc,             ');
  sbSQL.Append('       ld.arquivoAnexo                                   ');
  sbSQL.Append('FROM lancamentosDespesa ld                               ');
  sbSQL.Append('INNER JOIN categoriasDespesa cd ON ld.idCategoria=cd.id  ');
  sbSQL.Append('WHERE 1=1                                                ');

  case nTipoDespesa of
    //Somente Não Pagas
    1: sbSQL.Append('  AND (ld.valorAPagar <> ld.valorPago OR ld.valorPago IS NULL) ');
    //Somente Pagas
    2: sbSQL.Append('  AND ld.valorAPagar = ld.valorPago ');
  end;

  if (trim(cMes) <> '') then
    sbSQL.Append('  AND MONTH(ld.dataVencimento)=:PMes   ');

  if (trim(cAno) <> '') then
    sbSQL.Append('  AND YEAR(ld.dataVencimento) =:PAno    ');

  if clsDespesa.idUsuario > 0 then
    sbSQL.Append('    AND ld.idUsuario =:PidUsuario      ');


  if (trim(cMes) <> '') OR (trim(cAno) <> '') then
  begin
    sbSQL.Append('ORDER BY YEAR(ld.dataVencimento) ASC,  ');
    sbSQL.Append('         MONTH(ld.dataVencimento) ASC, ');
    sbSQL.Append('         DAY(ld.dataVencimento) ASC,   ');
    sbSQL.Append('         ld.descricao ASC              ');
  end else
    sbSQL.Append('ORDER BY LD.dataVencimento ASC         ');

  DM.qryDespesas.Close;
  DM.qryDespesas.SQL.Clear;
  DM.qryDespesas.sql.Add(sbSQL.ToString());

  if clsDespesa.idUsuario > 0 then
    DM.qryDespesas.ParamByName('PidUsuario').AsInteger := clsDespesa.idUsuario;

  if (trim(cMes) <> '') then
    DM.qryDespesas.ParamByName('PMes').AsAnsiString := cMes;

  if (trim(cAno) <> '') then
    DM.qryDespesas.ParamByName('PAno').AsAnsiString := cAno;

  DM.qryDespesas.Open;

  Result := DM.qryDespesas.RecordCount;
end;

function findById(clsDespesa : TDespesa) : TDespesa;
const
  cSQL : String = 'SELECT ld.id, ld.descricao, ld.dataVencimento, ld.valorAPagar, ld.valorPago, '+
                  '       ld.valorAPagar - ld.valorPago as valorDiferenca,                      '+
                  '       ld.idCategoria, ld.idUsuario, ld.dataPagamento, ld.observacoes,       '+
                  '       cd.descricao as categoriaDespesa,                                     '+
                  '       ld.despesaFixa, ld.nParc, ld.totParc, ld.arquivoAnexo                 '+
                  'FROM lancamentosdespesa ld                                                   '+
                  'INNER JOIN categoriasDespesa cd ON ld.idcategoria = cd.id                    '+
                  'WHERE ld.id = :Pid                                                           '+
                  'ORDER BY  YEAR(ld.datavencimento) asc,                                       '+
                  '          MONTH(ld.datavencimento) asc,                                      '+
                  '          DAY(ld.datavencimento) asc,                                        '+
                  '          ld.descricao asc                                                   ';
begin
  try
    DM.qryManutDespesas.Close;
    DM.qryManutDespesas.SQL.Clear;
    DM.qryManutDespesas.SQL.Add(cSQL);
    DM.qryManutDespesas.ParamByName('Pid').AsInteger := clsDespesa.id;
    DM.qryManutDespesas.Open;

    clsDespesa.id             := DM.qryManutDespesas.FieldByName('id').AsInteger;
    clsDespesa.descricao      := DM.qryManutDespesas.FieldByName('descricao').AsString;
    clsDespesa.datavencimento := DM.qryManutDespesas.FieldByName('datavencimento').AsDateTime;
    clsDespesa.valorapagar    := DM.qryManutDespesas.FieldByName('valorapagar').AsCurrency;
    clsDespesa.idCategoria    := DM.qryManutDespesas.FieldByName('idCategoria').AsInteger;
    clsDespesa.idUsuario      := DM.qryManutDespesas.FieldByName('idUsuario').AsInteger;
    clsDespesa.datapagamento  := DM.qryManutDespesas.FieldByName('datapagamento').AsDateTime;
    clsDespesa.valorPago      := DM.qryManutDespesas.FieldByName('valorPago').AsCurrency;
    clsDespesa.observacoes    := DM.qryManutDespesas.FieldByName('observacoes').AsString;
    clsDespesa.despesaFixa    := IIF(DM.qryManutDespesas.FieldByName('despesaFixa').AsInteger = 0, false, true);
    clsDespesa.nParc          := DM.qryManutDespesas.FieldByName('nParc').AsInteger;
    clsDespesa.totParc        := DM.qryManutDespesas.FieldByName('totParc').AsInteger;
    clsDespesa.arquivoAnexo   := DM.qryManutDespesas.FieldByName('arquivoAnexo').AsString;

    Result := clsDespesa;
  except
    Raise Exception.Create('Houve erro na busca da Despesa pelo id, favor tente novamente!');
  end;
end;

procedure findAll();
const
  cSQL : String = 'SELECT ld.id, ld.descricao, ld.dataVencimento, ld.valorAPagar, ld.valorPago, '+
                  '       ld.valorAPagar - ld.valorPago as valorDiferenca,                      '+
                  '       ld.idCategoria, ld.idUsuario, ld.dataPagamento, ld.observacoes,       '+
                  '       cd.descricao as categoriaDespesa,                                     '+
                  '       ld.despesaFixa, ld.nParc, ld.totParc, ld.arquivoAnexo                 '+
                  'FROM lancamentosdespesa ld                                                   '+
                  'INNER JOIN categoriasDespesa cd ON ld.idcategoria = cd.id                    '+
                  'ORDER BY  YEAR(ld.datavencimento) asc,                                       '+
                  '          MONTH(ld.datavencimento) asc,                                      '+
                  '          DAY(ld.datavencimento) asc,                                        '+
                  '          ld.descricao asc                                                   ';

begin
  try
    DM.qryDespesas.Close;
    DM.qryDespesas.SQL.Clear;
    DM.qryDespesas.SQL.Add(cSQL);
    DM.qryDespesas.Open;
  except
    Raise Exception.Create('Houve erro na listagem da Despesa, favor tente novamente!');
  end;
end;

function setTotaisDespesas(cMes, cAno : String):TDespesa;
var
  QryTotaisDespesas : TFDQuery;
  clsDespesa        : TDespesa;
begin
  clsDespesa := TDespesa.Create;

  QryTotaisDespesas            := TFDQuery.Create(nil);
  QryTotaisDespesas.Connection := DM.Conn;
  QryTotaisDespesas.SQL.Add('SELECT SUM(LD.valorAPagar) AS totalAPagar, ');
  QryTotaisDespesas.SQL.Add('       SUM(LD.valorPago) AS totalPago      ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add('   ,MONTH(LD.dataVencimento) AS MES, ');
    QryTotaisDespesas.SQL.Add('    YEAR(LD.dataVencimento) AS ANO   ');
  end;

  QryTotaisDespesas.SQL.Add('FROM lancamentosDespesa LD ');
  QryTotaisDespesas.SQL.Add('WHERE 1=1                  ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add('  AND MONTH(LD.dataVencimento)=:PMes ');
    QryTotaisDespesas.SQL.Add('  AND YEAR(LD.dataVencimento) =:PAno ');
  end;

  if clsUsuario.id > 0 then
  begin
    QryTotaisDespesas.SQL.Add('    AND lD.idUsuario = :PidUsuario ');
    QryTotaisDespesas.ParamByName('PIDUSUARIO').AsInteger := clsUsuario.id;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add(' GROUP BY MES, ANO ');

    QryTotaisDespesas.ParamByName('PMes').AsAnsiString := cMes;
    QryTotaisDespesas.ParamByName('PAno').AsAnsiString := cAno;
  end;

  QryTotaisDespesas.Open;

  if(not QryTotaisDespesas.EOF) then
  begin
    clsDespesa.totalValorAPAgar       := QryTotaisDespesas.FieldByName('totalAPagar').AsFloat;
    clsDespesa.totalValorPago         := QryTotaisDespesas.FieldByName('totalPago').AsFloat;
    clsDespesa.totalValorFaltaPagar   := (QryTotaisDespesas.FieldByName('totalPago').AsFloat -
                                          QryTotaisDespesas.FieldByName('totalAPagar').AsFloat );
  end else
  begin
    clsDespesa.totalValorAPAgar       := 0.00;
    clsDespesa.totalValorPago         := 0.00;
    clsDespesa.totalValorFaltaPagar   := 0.00;
  end;

  FreeAndNil(QryTotaisDespesas);

  Result := clsDespesa;
end;

end.

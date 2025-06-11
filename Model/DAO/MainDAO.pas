unit MainDAO;

interface

uses  uDM, Bcrypt, Funcoes, CategoriasDespesa,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd, FireDAC.Stan.Intf, FireDAC.Stan.Option,
      FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
      FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
      FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
      FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.IBBase, Data.DB,
      FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
      FireDAC.Phys.MySQLDef;

type TMainDAO = class
end;
  function CarregaComboMesAno:TStringList;

implementation

function CarregaComboMesAno:TStringList;
var
  QryListagemCombo : TFDQuery;
  cMes, cAno : String;
  Dia, Mes, Ano : Word;
  listaCombo: TStringList;
begin
  listaCombo := TStringList.Create;

  listaCombo.Add('TODOS');

  QryListagemCombo            := TFDQuery.Create(nil);
  QryListagemCombo.Connection := DM.Conn;
  QryListagemCombo.SQL.Clear;

  QryListagemCombo.SQL.Add('SELECT MES, ANO                                        ');
  QryListagemCombo.SQL.Add('      FROM (                                           ');
  QryListagemCombo.SQL.Add('            SELECT MONTH(lr.DATAARECEBER) AS MES,      ');
  QryListagemCombo.SQL.Add('                   YEAR(lr.DATAARECEBER) AS ANO        ');
  QryListagemCombo.SQL.Add('            FROM lancamentosReceita lr                 ');

  if clsUsuario.id > 0 then
    QryListagemCombo.SQL.Add('            WHERE lr.IDUSUARIO = :PIDUSUARIO         ');

  QryListagemCombo.SQL.Add('            UNION                                      ');

  QryListagemCombo.SQL.Add('            SELECT MONTH(ld.datavencimento) AS MES,    ');
  QryListagemCombo.SQL.Add('                   YEAR(ld.datavencimento) AS ANO      ');
  QryListagemCombo.SQL.Add('            FROM lancamentosDespesa ld                 ');

  if clsUsuario.id > 0 then
    QryListagemCombo.SQL.Add('            WHERE ld.IDUSUARIO = :PIDUSUARIO         ');

  QryListagemCombo.SQL.Add('            UNION                                      ');

  QryListagemCombo.SQL.Add('            SELECT MONTH(max(ld.datavencimento) + INTERVAL 1 DAY) AS MES, ');
  QryListagemCombo.SQL.Add('                   YEAR(max(ld.datavencimento)) AS ANO ');
  QryListagemCombo.SQL.Add('            FROM lancamentosDespesa ld                              ');

  if clsUsuario.id > 0 then
    QryListagemCombo.SQL.Add('            WHERE ld.IDUSUARIO = :PIDUSUARIO                      ');

  QryListagemCombo.SQL.Add('          ) tmpMesAno                                               ');
  QryListagemCombo.SQL.Add('      ORDER BY ANO DESC, MES DESC                                   ');

  if clsUsuario.id > 0 then
    QryListagemCombo.ParamByName('PIDUSUARIO').AsInteger := clsUsuario.id;

  QryListagemCombo.Open;

  if QryListagemCombo.FieldByName('MES').AsInteger = 0 then
  begin
    DecodeDate(Now, Ano, Mes, Dia);
    listaCombo.Add(StrZero(Mes, 2) + '/' + StrZero(Ano, 4));
  end;

  if(not QryListagemCombo.EOF) then
  begin
     QryListagemCombo.First;
     While Not QryListagemCombo.EOF do
     begin
        if QryListagemCombo.FieldByName('MES').AsInteger <> 0 then
        begin
          cMes := StrZero(QryListagemCombo.FieldByName('MES').AsInteger, 2);

          cAno := IntToStr(QryListagemCombo.FieldByName('ANO').AsInteger);
          listaCombo.Add(cMes + '/' + cAno);
        end;

        QryListagemCombo.Next;
     end;
  end;

  FreeAndNil(QryListagemCombo);

  Result := listaCombo;
end;

end.

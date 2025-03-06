unit uFuncoes;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
    Vcl.StdCtrls, Vcl.Buttons, IdGlobal, IdHash, IdHashMessageDigest,
    Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
    FireDAC.Comp.Client, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet;

  function Criptografar(cTexto : String) : String;
  function MessageDlgDefault(Msg :String;
    AType: TMsgDlgType; AButtons : TMsgDlgButtons; IndiceHelp : LongInt;
    DefButton : TModalResult=MrNone) : Word;
  function ExtensoMes(n: Integer): String;
  function getMaiorData(nIdUsuario : Integer): TDate;
implementation

uses uDM;

function Criptografar(cTexto : String) : String;
var
  hashMessageDigest5 : TIdHashMessageDigest5;
  cResult : String;
begin
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    cResult            := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(cTexto));
  finally
    hashMessageDigest5.Free;
  end;

  Result := cResult;
end;

function MessageDlgDefault(Msg :String;
  AType: TMsgDlgType; AButtons : TMsgDlgButtons; IndiceHelp : LongInt;
  DefButton : TModalResult=MrNone) : Word;
Var
  I:Integer;
  Mensagem:TForm;

Begin
  Mensagem:=CreateMessageDialog(Msg, AType, Abuttons);
  Mensagem.HelpConText:=IndiceHelp;

  With Mensagem Do
  Begin
    For i :=0 To ComponentCount -1 Do
    Begin
      If (Components[i] is TButton) Then
      Begin
        If (TButton(Components[i]).ModalResult=DefButton) Then
        Begin
          ActiveControl:=TWincontrol(Components[i]);
        end;
      end;
    end;

    If Atype=mtConfirmation Then Caption := 'Confirmação'
    else If AType=mtWarning      Then Caption := 'Atenção'
    else If AType=mtError        Then Caption := 'Erro'
    else If AType=mtInFormation  Then Caption := 'InFormação';

    TButton(Mensagem.FindComponent('YES')).Caption    := '&Sim';
    TButton(Mensagem.FindComponent('NO')).Caption     := '&Não';
    TButton(Mensagem.FindComponent('CANCEL')).Caption := '&Cancelar';
    TButton(Mensagem.FindComponent('ABORT')).Caption  := '&Abortar';
    TButton(Mensagem.FindComponent('RETRY')).Caption  := '&Repetir';
    TButton(Mensagem.FindComponent('IGNORE')).Caption := '&Ignorar';
    TButton(Mensagem.FindComponent('ALL')).Caption    := '&Todos';
    TButton(Mensagem.FindComponent('HELP')).Caption   := 'A&juda';
  end;

  Result := Mensagem.ShowModal;

  Mensagem.Free;
end;


function ExtensoMes(n: Integer): String;
var
  cMesExtenso : String;
begin
 Case n Of
    1 : cMesExtenso  := 'janeiro';
    2 : cMesExtenso  := 'fevereiro';
    3 : cMesExtenso  := 'março';
    4 : cMesExtenso  := 'abril';
    5 : cMesExtenso  := 'maio';
    6 : cMesExtenso  := 'junho';
    7 : cMesExtenso  := 'julho';
    8 : cMesExtenso  := 'agosto';
    9 : cMesExtenso  := 'setembro';
    10 : cMesExtenso  := 'outubro';
    11 : cMesExtenso  := 'novembro';
    12 : cMesExtenso  := 'dezembro';
  end;

  Result := cMesExtenso;
end;

function getMaiorData(nIdUsuario : Integer): TDate;
var
  QryMaxDate : TFDQuery;
  cMes, cAno, cMesAtual, cAnoAtual, cMesAnoAtual : String;
  nDia, nMes, nAno : Word;
  dDataMaior : TDate;

begin
  dDataMaior            := Date();

  QryMaxDate            := TFDQuery.Create(nil);
  QryMaxDate.Connection := DM.Conn;
  QryMaxDate.SQL.Clear;

  QryMaxDate.SQL.Add('SELECT MAX(data) AS dataMaior               ');
  QryMaxDate.SQL.Add('FROM(                                       ');
  QryMaxDate.SQL.Add('    SELECT MAX(lr.datarecebimento) AS data  ');
  QryMaxDate.SQL.Add('    FROM lancamentosReceita lr              ');

  if nIdUsuario > 0 then
    QryMaxDate.SQL.Add('WHERE lr.IDUSUARIO = :PIDUSUARIO          ');

  QryMaxDate.SQL.Add('    UNION                                   ');
  QryMaxDate.SQL.Add('    SELECT MAX(ld.datavencimento) AS data   ');
  QryMaxDate.SQL.Add('    FROM lancamentosDESPESA ld              ');

  if nIdUsuario > 0 then
    QryMaxDate.SQL.Add('WHERE ld.IDUSUARIO = :PIDUSUARIO          ');

  QryMaxDate.SQL.Add(') tmpDataMaior                              ');

  if nIdUsuario > 0 then
    QryMaxDate.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;

  QryMaxDate.Open;

  if QryMaxDate.RecordCount > 0 then
    dDataMaior := QryMaxDate.FieldByName('dataMaior').AsDateTime;

  Result  :=  dDataMaior;
end;

end.

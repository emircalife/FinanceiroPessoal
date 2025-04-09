unit uFuncoes;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
    Vcl.StdCtrls, Vcl.Buttons, IdGlobal, IdHash, IdHashMessageDigest,
    Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
    FireDAC.Comp.Client;

type
  TFeriados = (frPascoa, frCarnaval, frQuartaCinzas, frSextaSanta, frCorpusChristi);

  function Criptografar(cTexto : String) : String;
  function MessageDlgDefault(Msg :String; AType: TMsgDlgType;
           AButtons : TMsgDlgButtons; IndiceHelp : LongInt;
           DefButton : TModalResult=MrNone) : Word;
  function ExtensoMes(n: Integer): String;
  function getMaiorData(nIdUsuario : Integer): TDate;
  function DiasUteis(dataini, datafin: string): integer;
  function CalculaPascoa(AAno: Word): TDateTime;
  function CalculaFeriado(AAno: Word; ATipo: TFeriados): TDateTime;
  function IncYear(const DateTime: TDateTime; NumberOfYear: Integer):TDateTime;
  Function UltimoDiaMes(dData:TDate):String;
  function StrZero(iNumero, iComp: Integer): String;
  Function QtdeDiasUteis(cMes, cAno : String):String;
  function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;

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

function DiasUteis(dataini, datafin: String): Integer;
var
	dDataFim, dDataIni, dDataFim2 : TDatetime;
	nDiasUteis, s : Integer;
begin
	if StrToDate(DataFin) < StrtoDate(DataIni) then
	begin
		Result := 0;
		exit;
	end;

	nDiasUteis  := 0;
	s           := 1;
	dDataFim    := strtodate(dataFin);
	dDataIni    := strtodate(dataIni);

	if dDataFim > dDataIni then
	begin
		dDataFim2 := dDataFim;
		dDataFim  := dDataIni;
		dDataIni  := dDataFim2;
		s := 1;
	end;

	dDataFim := dDataFim + 1;

	while (dayofweek(dDataFim) <> 2) and (dDataFim <= dDataIni) do
	begin
		if dayofweek(dDataFim) in [2..6] then
			inc(nDiasUteis);

		dDataFim := dDataFim + 1;
	end;

	nDiasUteis := nDiasUteis + round((5 * int((dDataIni - dDataFim) / 7)));
	dDataFim  := dDataFim + (7 * int((dDataIni - dDataFim) / 7));

	while dDataFim <= dDataIni do
	begin
		if dayofweek(dDataFim) in [2..6] then
			inc(nDiasUteis);

		dDataFim := dDataFim + 1;
	end;

	if nDiasUteis < 0 then
		nDiasUteis := 0;

	result := s * nDiasUteis;
end;

function CalculaPascoa(AAno: Word): TDateTime;
var
  R1, R2, R3, R4, R5 : Longint;
  FPascoa : TDateTime;
  VJ, VM, VD : Word;
begin
  R1 := AAno mod 19;
  R2 := AAno mod 4;
  R3 := AAno mod 7;
  R4 := (19 * R1 + 24) mod 30;
  R5 := (6 * R4 + 4 * R3 + 2 * R2 + 5) mod 7;

  FPascoa := EncodeDate(AAno, 3, 22);
  FPascoa := FPascoa + R4 + R5;

  DecodeDate(FPascoa, VJ, VM, VD);

  case VD of
    26 : FPascoa := EncodeDate(Aano, 4, 19);
    25 :
      Begin
        if R1 > 10 then
          FPascoa := EncodeDate(AAno, 4, 18);
      End;
  end;

  Result:= FPascoa;
end;

function CalculaFeriado(AAno: Word; ATipo: TFeriados): TDateTime;
var
  Aux: TDateTime;

begin
  Aux := CalculaPascoa(AAno);

  Case ATipo of
    frCarnaval : Aux := Aux - 47;
    frQuartaCinzas : Aux := Aux - 46;
    frSextaSanta : Aux := Aux - 2;
    frCorpusChristi: Aux := Aux + 60;
  end;

  Result := Aux;
end;

function IncYear(const DateTime: TDateTime; NumberOfYear: Integer):TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);

  Year := Year + NumberOfYear;
  Result := EncodeDate(Year, Month, Day);
  ReplaceTime(Result, DateTime);
end;

Function UltimoDiaMes(dData:TDate):String;
var
  cMes, cAno, cData : string;
  cUltimoDiaDoMes : String;

begin
  cData :=  FormatDateTime('dd/mm/yyyy', dData);
  cMes  :=  Copy( cData, 4, 2 );
  cAno  :=  Copy( cData, 7, 4 );

  if Pos( cMes, '01 03 05 07 08 10 12' ) > 0 then
    cUltimoDiaDoMes := '31'
  else if cMes <> '02' then
    cUltimoDiaDoMes := '30'
  else if ( StrToInt( cAno ) mod 4 ) = 0 then
    cUltimoDiaDoMes := '29'
  else
    cUltimoDiaDoMes := '28';

  Result := cUltimoDiaDoMes;
end;

Function QtdeDiasUteis(cMes, cAno : String):String;
var
  nPrimeiroDia, nUltimoDia : Integer;
  dDataIni, dDataFim : TDate;
  nQtdeDiasUteis : Integer;

begin
  nPrimeiroDia  :=  1;
  dDataIni      := StrToDate('01/' + cMes + '/' + cAno);

  nUltimoDia    :=  StrToInt(UltimoDiaMes(dDataIni));
  dDataFim      :=  StrToDate(StrZero(nUltimoDia, 2) + '/' + cMes + '/' + cAno);

  nQtdeDiasUteis  :=  DiasUteis(FormatDateTime('dd/mm/yyyy', dDataIni), FormatDateTime('dd/mm/yyyy', dDataFim));
  result          :=  Trim(IntToStr(nQtdeDiasUteis));
end;

function StrZero(iNumero, iComp: Integer): String;
begin
  Result := StringOfChar('0', iComp - Length(IntToStr(iNumero))) +
            IntToStr(iNumero);
end;

function IIf(Expressao: Variant; ParteTRUE, ParteFALSE: Variant): Variant;
 begin
   if Expressao then
      Result := ParteTRUE
   else
      Result := ParteFALSE;
 end;

end.

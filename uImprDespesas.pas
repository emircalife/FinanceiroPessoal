unit uImprDespesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet,
  Vcl.WinXPickers;

type
  TfrmImprDespesas = class(TForm)
    frxRelDespesadDoMes: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBDsReport: TfrxDBDataset;
    cboTiposDespesa: TComboBox;
    GroupBox1: TGroupBox;
    lblDe: TLabel;
    lblAte: TLabel;
    lblMostrarDespesas: TLabel;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    dtpDe: TDatePicker;
    dtpAte: TDatePicker;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    QryRelDespesas : TFDQuery;
    procedure CarregaDespesas();
  public
    { Public declarations }
    nIdUsuario   : Integer;
    cNomeUsuario : String;
  end;

var
  frmImprDespesas: TfrmImprDespesas;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmImprDespesas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImprDespesas.btnImprimirClick(Sender: TObject);
var
  cTituloRel : String;
  cDataIni, cDataFim : String;
begin
  cDataIni  :=  trim(DateToStr(dtpDe.Date));
  cDataFim  :=  trim(DateToStr(dtpAte.Date));

  if cDataIni = '/  /' then
    cDataIni := '01/03/2025';

  if cDataFim = '/  /' then
    cDataFim := '31/03/2025';
    //cDataFim := DateToStr(uFuncoes.getMaiorData(nIdUsuario));

  CarregaDespesas();

  cTituloRel  := 'Lançamentos de ' + cDataIni + ' até ' + cDataFim;

  frxDBDsReport.DataSet :=  QryRelDespesas;
  frxRelDespesadDoMes.Variables['TITULO'] := QuotedStr(cTituloRel);
  frxRelDespesadDoMes.ShowReport();
end;

procedure TfrmImprDespesas.CarregaDespesas();
var
  cDataIni, cDataFim : String;
  cDataIniFormatada, cDataFimFormatada : String;
  cDiaIni, cMesIni, cAnoIni : String;
  cDiaFim, cMesFim, cAnoFim : String;

begin
  QryRelDespesas            := TFDQuery.Create(nil);
  QryRelDespesas.Connection := DM.Conn;
  QryRelDespesas.Close;
  QryRelDespesas.SQL.Clear;

  cDataIni  :=  trim(DateToStr(dtpDe.Date));
  cDataFim  :=  trim(DateToStr(dtpAte.Date));

  if cDataIni = '/  /' then
    cDataIni := '01/01/2025';

  if cDataFim = '/  /' then
    cDataFim := DateToStr(uFuncoes.getMaiorData(nIdUsuario));

  cDiaIni := Copy(cDataIni,1,2);
  cMesIni := Copy(cDataIni,4,2);
  cAnoIni := Copy(cDataIni,7,4);

  cDiaFim := Copy(cDataFim,1,2);
  cMesFim := Copy(cDataFim,4,2);
  cAnoFim := Copy(cDataFim,7,4);

  cDataIniFormatada  := cAnoIni + '-' + cMesIni + '-' + cDiaIni;
  cDataFimFormatada  := cAnoFim + '-' + cMesFim + '-' + cDiaFim;

  QryRelDespesas.SQL.Add('SELECT LD.id,                                           ');
  QryRelDespesas.SQL.Add('       LD.descricao,                                    ');
  QryRelDespesas.SQL.Add('       LD.datavencimento,                               ');
  QryRelDespesas.SQL.Add('       LD.valorapagar,                                  ');
  QryRelDespesas.SQL.Add('       LD.valorpago,                                    ');
  QryRelDespesas.SQL.Add('       LD.idcategoria,                                  ');
  QryRelDespesas.SQL.Add('       CD.descricao as categoriaDespesa,                ');
  QryRelDespesas.SQL.Add('       LD.idusuario,                                    ');
  QryRelDespesas.SQL.Add('       LD.datapagamento                                 ');
  QryRelDespesas.SQL.Add('FROM lancamentosdespesa LD                              ');
  QryRelDespesas.SQL.Add('INNER JOIN CATEGORIASDESPESA CD ON LD.idcategoria=CD.id ');
  QryRelDespesas.SQL.Add('WHERE 1=1                                               ');

  case cboTiposDespesa.ItemIndex of
    //Somente Não Pagas
    1: QryRelDespesas.SQL.Add('  AND (LD.VALORAPAGAR <> LD.VALORPAGO OR LD.VALORPAGO IS NULL  OR LD.VALORPAGO =0)');
    //Somente Pagas
    2: QryRelDespesas.SQL.Add('  AND LD.VALORAPAGAR = LD.VALORPAGO ');
  end;

  QryRelDespesas.SQL.Add('  AND LD.DATAVENCIMENTO BETWEEN :PDTINI AND :PDTFIM  ');

  QryRelDespesas.ParamByName('PDTINI').AsString   :=  cDataIniFormatada;
  QryRelDespesas.ParamByName('PDTFIM').AsString   :=  cDataFimFormatada;

  if nIdUsuario > 0 then
  begin
    QryRelDespesas.SQL.Add('    AND LD.IDUSUARIO =:PIDUSUARIO                   ');
    QryRelDespesas.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;
  end;

  QryRelDespesas.SQL.Add('ORDER BY LD.DATAVENCIMENTO ASC                          ');

  QryRelDespesas.Open;
end;

procedure TfrmImprDespesas.FormShow(Sender: TObject);
var
  nDia, nMes, nAno : Word;
  dData : TDate;

begin
  DecodeDate(date, nAno, nMes, nDia);

  dData       := StrToDate('01/' + trim(IntToStr(nMes)) + '/' + trim(IntToStr(nAno)));

  dtpDe.Date  :=  dData;
  dtpAte.Date :=  IncMonth(dData, 1) -1;
end;

end.

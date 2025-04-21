unit uExpoPlanExelAnual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMTBcd, ShellAPI, ComObj, Clipbrd, Vcl.FileCtrl;


type
  TfrmExpoPlanExelAnual = class(TForm)
    grpPastaDestino: TGroupBox;
    edtCaminhoExportar: TEdit;
    btnExportar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExportarExcell: TBitBtn;
    drvCboUnidades: TDriveComboBox;
    procedure btnExportarExcellClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ExportarExcell(cTitulo, cCaminhoSalvar : String);
    function SelectADirectory(Title : string) : string;
  public
    { Public declarations }
  end;

var
  frmExpoPlanExelAnual: TfrmExpoPlanExelAnual;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmExpoPlanExelAnual.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmExpoPlanExelAnual.btnExportarClick(Sender: TObject);
begin
  if trim(edtCaminhoExportar.Text) = '' then
    ShowMessage('É preciso escolher a pasta de destino!')
  else
    ExportarExcell('Finanças', trim(edtCaminhoExportar.Text))
end;

procedure TfrmExpoPlanExelAnual.btnExportarExcellClick(Sender: TObject);
var
  selDir : string;
begin
  SelectDirectory('Selecione uma pasta', trim(drvCboUnidades.Drive) + ':\', selDir);

  if DirectoryExists(selDir) then
    edtCaminhoExportar.Text := trim(selDir);
end;

function TfrmExpoPlanExelAnual.SelectADirectory(Title : string) : string;
var
  Pasta : String;
begin
  SelectDirectory(Title, '', Pasta);

  if (Trim(Pasta) <> '') then
    if (Pasta[Length(Pasta)] <> '\') then
      Pasta := Pasta + '\';

  Result := Pasta;
end;

procedure TfrmExpoPlanExelAnual.ExportarExcell(cTitulo, cCaminhoSalvar : String);
var
  objExcel, Sheet, Chart, s : Variant;
  i, nFim : integer;
  cDescriDespesa, cDiaDespesas, cMesDespesas, cAnoDespesas : String;
  nAno, nMes, nDia : Word;
  nHora, nMin, nSeg, nMilliSeg : Word;
  cEstrituraNome : String;

begin
  // Cria uma instancia para utilizar o Excel
  objExcel          := CreateOleObject('Excel.Application');

  objExcel.Visible  := False;
  objExcel.Caption  := cTitulo;

  DM.qryExportDespesasExcel.Open();

  DM.qryExportDespesasExcel.First;
  DM.qryExportDespesasExcel.DisableControls;

  nFim  :=  DM.qryExportDespesasExcel.RecordCount;

  cAnoDespesas    := StrZero(DM.qryExportDespesasExcel.FieldByName('ano').AsInteger, 4);

  if trim(cCaminhoSalvar) = '' then
    cCaminhoSalvar := 'd:\';

  cCaminhoSalvar  := cCaminhoSalvar + 'Controle Financeiro ' + cAnoDespesas;

  objExcel.Workbooks.Add();
  objExcel.Workbooks[1].Sheets.Add();
  objExcel.Workbooks[1].WorkSheets[1].Name  := cTitulo;
  Sheet                                     := objExcel.Workbooks[1].WorkSheets[cTitulo];

  Sheet.Range['A1']  := 'Dia';
  Sheet.Range['B1']  := 'Despesa';
  Sheet.Range['C1']  := 'Jan';
  Sheet.Range['D1']  := '';
  Sheet.Range['E1']  := 'Fev';
  Sheet.Range['F1']  := '';
  Sheet.Range['G1']  := 'Mar';
  Sheet.Range['H1']  := '';
  Sheet.Range['I1']  := 'Abr';
  Sheet.Range['J1']  := '';
  Sheet.Range['K1']  := 'Mai';
  Sheet.Range['L1']  := '';
  Sheet.Range['M1']  := 'Jun';
  Sheet.Range['N1']  := '';
  Sheet.Range['O1']  := 'Jul';
  Sheet.Range['P1']  := '';
  Sheet.Range['Q1']  := 'Ago';
  Sheet.Range['R1']  := '';
  Sheet.Range['S1']  := 'Set';
  Sheet.Range['T1']  := '';
  Sheet.Range['U1']  := 'Out';
  Sheet.Range['V1']  := '';
  Sheet.Range['W1']  := 'Nov';
  Sheet.Range['X1']  := '';
  Sheet.Range['Y1']  := 'Dez';
  Sheet.Range['Z1']  := '';

  Sheet.Range['C2'] := 'A Pagar';
  Sheet.Range['D2'] := 'Pago';

  Sheet.Range['E2'] := 'A Pagar';
  Sheet.Range['F2'] := 'Pago';

  Sheet.Range['G2'] := 'A Pagar';
  Sheet.Range['H2'] := 'Pago';

  Sheet.Range['I2'] := 'A Pagar';
  Sheet.Range['J2'] := 'Pago';

  Sheet.Range['K2'] := 'A Pagar';
  Sheet.Range['L2'] := 'Pago';

  Sheet.Range['M2'] := 'A Pagar';
  Sheet.Range['N2'] := 'Pago';

  Sheet.Range['O2'] := 'A Pagar';
  Sheet.Range['P2'] := 'Pago';

  Sheet.Range['Q2'] := 'A Pagar';
  Sheet.Range['R2'] := 'Pago';

  Sheet.Range['S2'] := 'A Pagar';
  Sheet.Range['T2'] := 'Pago';

  Sheet.Range['U2'] := 'A Pagar';
  Sheet.Range['V2'] := 'Pago';

  Sheet.Range['w2'] := 'A Pagar';
  Sheet.Range['x2'] := 'Pago';

  Sheet.Range['y2'] := 'A Pagar';
  Sheet.Range['z2'] := 'Pago';

  // No caso do FOR se torna interessante usar o SHEET.CELLS (veja como)
  // Atente que usei o FOR a partir do numero 2 desta forma pularemos a
  // primeira linha que ja contem um cabeçalho preenchido acima

  cDescriDespesa  := trim(DM.qryExportDespesasExcel.FieldByName('descricao').AsString);
  cDiaDespesas    := StrZero(DM.qryExportDespesasExcel.FieldByName('dia').AsInteger, 2);
  cMesDespesas    := StrZero(DM.qryExportDespesasExcel.FieldByName('mes').AsInteger, 2);
  cAnoDespesas    := StrZero(DM.qryExportDespesasExcel.FieldByName('ano').AsInteger, 4);

  try
    cDiaDespesas := StrZero(DM.qryExportDespesasExcel.FieldByName('dia').AsInteger, 2);

    //Dia da despesa
    Sheet.Cells[3, 1] := StrZero(DM.qryExportDespesasExcel.FieldByName('dia').AsInteger, 2);
    Sheet.Cells[3, 1].VerticalAlignment := 2;

    //Descrição da despesa
    Sheet.Cells[3, 2] := trim(DM.qryExportDespesasExcel.FieldByName('descricao').AsString);

    i := DM.qryExportDespesasExcel.RecNo + 2;

    while not DM.qryExportDespesasExcel.Eof do
    begin
      if (cDescriDespesa <> trim(DM.qryExportDespesasExcel.FieldByName('descricao').AsString)) then
      begin
        cDiaDespesas   := StrZero(DM.qryExportDespesasExcel.FieldByName('dia').AsInteger, 2);
        cMesDespesas   := StrZero(DM.qryExportDespesasExcel.FieldByName('mes').AsInteger, 2);
        cDescriDespesa := trim(DM.qryExportDespesasExcel.FieldByName('descricao').AsString);

        i              := i + 1;

        //Dia da despesa
        Sheet.Cells[i, 1] := cDiaDespesas;
        Sheet.Cells[i, 1].VerticalAlignment := 2;

        //Descrição da despesa
        Sheet.Cells[i, 2] := cDescriDespesa;
      end;

      cMesDespesas    := StrZero(DM.qryExportDespesasExcel.FieldByName('mes').AsInteger, 2);

      if cMesDespesas = '01' then
      begin
        // Formata o Numero para se tornar MOEDA
        Sheet.Cells[i, 3].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 3]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 4].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 4]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '02' then
      begin
        Sheet.Cells[i, 5].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 5]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 6].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 6]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '03' then
      begin
        Sheet.Cells[i, 7].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 7]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 8].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 8]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '04' then
      begin
        Sheet.Cells[i, 9].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 9]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 10].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 10]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '05' then
      begin
        Sheet.Cells[i, 11].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 11]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 12].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 12]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '06' then
      begin
        Sheet.Cells[i, 13].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 13]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 14].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 14]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '07' then
      begin
        Sheet.Cells[i, 15].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 15]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 16].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 16]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '08' then
      begin
        Sheet.Cells[i, 17].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 17]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 18].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 18]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '09' then
      begin
        Sheet.Cells[i, 19].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 19]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 20].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 20]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '10' then
      begin
        Sheet.Cells[i, 21].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 21]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 22].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 22]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '11' then
      begin
        Sheet.Cells[i, 23].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 23]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 24].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 24]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end else if cMesDespesas = '12' then
      begin
        Sheet.Cells[i, 25].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 25]               :=  DM.qryExportDespesasExcel.FieldByName('valorapagar').AsVariant;

        Sheet.Cells[i, 26].NumberFormat  :=  'R$ #.##0,00_);(R$ #.##0,00)';
        Sheet.Cells[i, 26]               :=  DM.qryExportDespesasExcel.FieldByName('valorpago').AsVariant;
      end;

      DM.qryExportDespesasExcel.Next;
    end;

    DM.qryExportDespesasExcel.First;
    DM.qryExportDespesasExcel.EnableControls;

    objExcel.columns.AutoFit;

    while FileExists(cCaminhoSalvar) do
    begin
      DecodeDate(date, nAno, nMes, nDia);
      DecodeTime(now, nHora, nMin, nSeg, nMilliSeg);
      cEstrituraNome := StrZero(nAno, 4) + StrZero(nMes, 2) + StrZero(nDia, 2);
      cEstrituraNome := cEstrituraNome + StrZero(nHora, 2) + StrZero(nMin, 2) + StrZero(nSeg, 2);

      cCaminhoSalvar := cCaminhoSalvar + '_'
    end;

    cCaminhoSalvar := cCaminhoSalvar + '.xlsx';

    objExcel.Workbooks[1].SaveAs(cCaminhoSalvar);

    objExcel.visible := True;
  Except
    on e : Exception do
        raise Exception.Create('Erro ao exportar planilha ' +#13+
                               '================'+#13+#13+
                               'Menssagem : ' + E.Message +#13+
                               'Classe : '    + E.ClassName);
  end;

  objExcel.Quit;
end;

end.

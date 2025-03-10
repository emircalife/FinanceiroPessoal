unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet,
  FMTBcd;

type
  TfrmMain = class(TForm)
    mnuMainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Categorias1: TMenuItem;
    Despesas1: TMenuItem;
    Receitas1: TMenuItem;
    grpDespesas: TGroupBox;
    grdDespesas: TDBGrid;
    grpReceitas: TGroupBox;
    grdReceitas: TDBGrid;
    pnlBotoesReceitas: TPanel;
    btnNovoReceita: TBitBtn;
    btnAlterarReceita: TBitBtn;
    btnDesfazerReceita: TBitBtn;
    btnSalvarReceita: TBitBtn;
    btnExcluirReceita: TBitBtn;
    btnSair: TBitBtn;
    dsDesepsas: TDataSource;
    dsReceitas: TDataSource;
    qrylkpCategoriasDespesa: TFDQuery;
    qrylkpCategoriasDespesaID: TIntegerField;
    qrylkpCategoriasDespesaDESCRICAO: TStringField;
    dslkpCategoriasDespesa: TDataSource;
    lblDTRecebimento: TLabel;
    edtDTRecebimento: TDBEdit;
    lblCategoriaReceita: TLabel;
    lkpCategoriaReceita: TDBLookupComboBox;
    lblReceita: TLabel;
    edtReceita: TDBEdit;
    Label1: TLabel;
    edtValorAReceber: TDBEdit;
    Label2: TLabel;
    edtValorRecebido: TDBEdit;
    grpTotaisReceitas: TGroupBox;
    lblReceitaAReceber: TLabel;
    lblReceitaRecebida: TLabel;
    lblFaltaReceber: TLabel;
    cboMesAno: TComboBox;
    lblMesAno: TLabel;
    qrylkpCategoriasReceita: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    dslkpCategoriasReceita: TDataSource;
    btnCalendario: TBitBtn;
    frxPDFExport: TfrxPDFExport;
    frxDBDsReport: TfrxDBDataset;
    frxRelDespesadDoMes: TfrxReport;
    N1: TMenuItem;
    Usurios1: TMenuItem;
    lblTotalDespesas: TLabel;
    lblTotalReceitas: TLabel;
    lblTotalAReceber: TLabel;
    lblrecebido: TLabel;
    lblVlFaltaReceber: TLabel;
    lblDTAReceber: TLabel;
    edtDTAreceber: TDBEdit;
    lblPesquisa: TLabel;
    rgMostrarDespesas: TRadioGroup;
    Label5: TLabel;
    Shape3: TShape;
    Label4: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    Shape1: TShape;
    edtPesquisa: TEdit;
    gerarParcelas1: TMenuItem;
    Despesas2: TMenuItem;
    Despesas3: TMenuItem;
    Despesas4: TMenuItem;
    lblVencimento: TLabel;
    edtDTVencimento: TDBEdit;
    lblCategoriaDespesa: TLabel;
    lkpCategoriaDespesa: TDBLookupComboBox;
    Label6: TLabel;
    edtDTPagamento: TDBEdit;
    edtValorPago: TDBEdit;
    lblValorPago: TLabel;
    edtValorAPagar: TDBEdit;
    lblValorAPagar: TLabel;
    edtDespesa: TDBEdit;
    lblDespesa: TLabel;
    lblObservacoesDespesas: TLabel;
    edtObservacoesDespesas: TDBMemo;
    pnlBotoesDespesas: TPanel;
    btnNovoDespesa: TBitBtn;
    btnAlterarDespesa: TBitBtn;
    btnDesfazerDespesa: TBitBtn;
    btnSalvarDespesa: TBitBtn;
    btnExcluirDespesa: TBitBtn;
    grpTotaisDespesas: TGroupBox;
    lblDepesaAPagar: TLabel;
    lblDepesaPaga: TLabel;
    lblFaltaPagar: TLabel;
    lblTotalAPagar: TLabel;
    lblPago: TLabel;
    lblValorFaltaPagar: TLabel;
    lblObservacoesReceitas: TLabel;
    edtObservacoesReceitas: TDBMemo;
    procedure Despesas1Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Receitas1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoDespesaClick(Sender: TObject);
    procedure btnAlterarDespesaClick(Sender: TObject);
    procedure btnDesfazerDespesaClick(Sender: TObject);
    procedure btnSalvarDespesaClick(Sender: TObject);
    procedure btnExcluirDespesaClick(Sender: TObject);
    procedure btnNovoReceitaClick(Sender: TObject);
    procedure btnAlterarReceitaClick(Sender: TObject);
    procedure btnDesfazerReceitaClick(Sender: TObject);
    procedure btnExcluirReceitaClick(Sender: TObject);
    procedure btnSalvarReceitaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboMesAnoChange(Sender: TObject);
    procedure grdDespesasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCalendarioClick(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure chkMostrarDespesasJaPagasClick(Sender: TObject);
    procedure rgMostrarDespesasClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure grdDespesasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdReceitasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdReceitasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Despesas2Click(Sender: TObject);
    procedure Despesas4Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaComboMesAno;
    function StrZero(iNumero, iComp: Integer): String;
    procedure setTotaisDespesas(cMes, cAno : String);
    procedure setTotaisReceitas(cMes, cAno : String);
    procedure CarregaReceitas(cMes, cAno : String);
    procedure CarregaDespesas(cMes, cAno : String);
    Procedure FiltrarReceitasEDespesas(cMesAtual, cAnoAtual:String);
  public
    { Public declarations }
    nIdUsuario   : Integer;
    cNomeUsuario : String;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uCategoriasDespesa, uDM, uCategoriasReceita, uGeracaoParcelas, uCalendario,
  uFuncoes, uLogin, uUsuarios, uImprDespesas;

procedure TfrmMain.btnAlterarDespesaClick(Sender: TObject);
begin
  if DM.qryDespesas.State = dsBrowse then
  begin
    DM.qryDespesas.Edit;
    edtDTVencimento.setFocus;
  end;
end;

procedure TfrmMain.btnAlterarReceitaClick(Sender: TObject);
begin
  if DM.qryDespesas.State = dsBrowse then
  begin
    DM.qryReceitas.Edit;
    edtDTAreceber.setFocus;
  end;
end;

procedure TfrmMain.btnCalendarioClick(Sender: TObject);
begin
  frmCalendario := TfrmCalendario.Create(self);
  frmCalendario.ShowModal;
  FreeAndNil(frmCalendario);
end;

procedure TfrmMain.btnDesfazerDespesaClick(Sender: TObject);
begin
  if DM.qryDespesas.State <> dsBrowse then
    DM.qryDespesas.Cancel;
end;

procedure TfrmMain.btnDesfazerReceitaClick(Sender: TObject);
begin
  if DM.qryReceitas.State <> dsBrowse then
    DM.qryReceitas.Cancel;
end;

procedure TfrmMain.btnExcluirDespesaClick(Sender: TObject);
begin
  if DM.qryDespesas.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes],
                                                          0, mrNo) = mrYes then
    begin
      DM.qryDespesas.Delete;

      CarregaComboMesAno;

      FiltrarReceitasEDespesas('','');
    end;
end;

procedure TfrmMain.btnExcluirReceitaClick(Sender: TObject);
begin
  if DM.qryReceitas.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes],
                                                          0, mrNo) = mrYes then
    begin
      DM.qryReceitas.Delete;

      CarregaComboMesAno;

      FiltrarReceitasEDespesas('','');
    end;
end;

procedure TfrmMain.btnNovoDespesaClick(Sender: TObject);
begin
  if DM.qryDespesas.State in [dsInactive, dsBrowse] then
  begin
    DM.qryDespesas.Append;

    DM.qryDespesasDATAVENCIMENTO.Value  :=  Date();

    edtDTVencimento.setFocus;
  end;
end;

procedure TfrmMain.btnNovoReceitaClick(Sender: TObject);
begin
  if DM.qryreceitas.State in [dsInactive, dsBrowse] then
  begin
    DM.qryReceitas.Append;

    DM.qryReceitasDATAARECEBER.Value    :=  Date();

    edtDTAreceber.setFocus;
  end;
end;

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnSalvarDespesaClick(Sender: TObject);
var
  mesAno, cMes, cAno : String;
  nRecNo : Integer;

begin
  if DM.qryDespesas.State <> dsBrowse then
  begin
    mesAno  := cboMesAno.Items[cboMesAno.ItemIndex];
    cMes    := '';
    cAno    := '';
    nRecNo  :=  0;

    if UpperCase(mesAno) <> 'TODOS' then
    begin
      cMes   := Copy(mesAno, 0, 2);
      cAno   := Copy(mesAno, 4, 6);
    end;

    if DM.qryDespesas.State = dsInsert then
    begin
//      DM.qryDespesasID.Value := DM.getNextId('LANCAMENTOSDESPESA');
    end else
      nRecNo := DM.qryDespesas.RecNo;

    DM.qryDespesasIDUSUARIO.AsInteger := nIdUsuario;

    DM.qryDespesas.Post;

    CarregaComboMesAno;

    cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(mesAno);

    FiltrarReceitasEDespesas(cMes, cAno);

    if DM.qryDespesas.State = dsInsert then
      DM.qryDespesas.Last
    else
      DM.qryDespesas.RecNo := nRecNo;
  end;
end;

procedure TfrmMain.btnSalvarReceitaClick(Sender: TObject);
var
  mesAno, cMes, cAno : String;
  nRecNo : Integer;

begin
  if DM.qryReceitas.State <> dsBrowse then
  begin
    mesAno := cboMesAno.Items[cboMesAno.ItemIndex];
    cMes   := '';
    cAno   := '';

    if UpperCase(mesAno) <> 'TODOS' then
    begin
      cMes   := Copy(mesAno, 0, 2);
      cAno   := Copy(mesAno, 4, 6);
    end;

    if DM.qryReceitas.State = dsInsert then
    begin
//      DM.qryReceitasID.Value := DM.getNextId('LANCAMENTOSRECEITA');
      nRecNo := DM.qryDespesas.RecNo + 1;
    end else
      nRecNo := DM.qryReceitas.RecNo;

    DM.qryReceitasIDUSUARIO.AsInteger := nIdUsuario;

    DM.qryReceitas.Post;

    CarregaComboMesAno;

    cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(mesAno);

    FiltrarReceitasEDespesas(cMes, cAno);

    if DM.qryReceitas.State = dsInsert then
      DM.qryReceitas.Last
    else
      DM.qryReceitas.RecNo := nRecNo;
  end;
end;

procedure TfrmMain.Despesas1Click(Sender: TObject);
begin
  frmCategoriasDespesa := TfrmCategoriasDespesa.Create(self);
  frmCategoriasDespesa.nIdUsuario   := nIdUsuario;
  frmCategoriasDespesa.cNomeUsuario := cNomeUsuario;

  frmCategoriasDespesa.ShowModal;
  freeAndNil(frmCategoriasDespesa);

  qrylkpCategoriasDespesa.Refresh;
end;

procedure TfrmMain.Despesas2Click(Sender: TObject);
var
  cMesAno, cMes, cAno : String;
begin
  cMesAno := cboMesAno.Items[cboMesAno.ItemIndex];
  cMes   := '';
  cAno   := '';

  if trim(UpperCase(cMesAno)) <> 'TODOS' then
  begin
    cMes    :=  Copy(cMesAno, 0, 2);
    cAno    :=  Copy(cMesAno, 4, 6);
  end;

  frmGeracaoParcelas := TfrmGeracaoParcelas.Create(self);
  frmGeracaoParcelas.nIdUsuario   := nIdUsuario;
  frmGeracaoParcelas.cNomeUsuario := cNomeUsuario;

  frmGeracaoParcelas.ShowModal;
  FreeAndNil(frmGeracaoParcelas);

  CarregaComboMesAno;

  cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(cMesAno);

  FiltrarReceitasEDespesas('','');
end;

procedure TfrmMain.Despesas4Click(Sender: TObject);
begin
  frmImprDespesas :=  TfrmImprDespesas.Create(self);
  frmImprDespesas.nIdUsuario    := nIdUsuario;
  frmImprDespesas.cNomeUsuario  := cNomeUsuario;

  frmImprDespesas.ShowModal;
  FreeAndNil(frmImprDespesas);
end;

procedure TfrmMain.edtPesquisaChange(Sender: TObject);
var
  cFiltro : String;
  mesAno, cMes, cAno : String;

begin
	mesAno  := cboMesAno.Items[cboMesAno.ItemIndex];
	cMes    := '';
	cAno    := '';
  cFiltro := '';

	if UpperCase(mesAno) <> 'TODOS' then
	begin
	  cMes   := Copy(mesAno, 0, 2);
	  cAno   := Copy(mesAno, 4, 6);

//    cFiltro := ' MONTH(LD.DATAVENCIMENTO)=' + QuotedStr(cMes) + 'AND YEAR(LD.DATAVENCIMENTO=' + QuotedStr(cAno) + ' AND ';
	end;


  cFiltro := cFiltro + ' UPPER(DESCRICAO) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryDespesas.Filtered := false;
  dm.qryDespesas.Filter   := cFiltro;
  dm.qryDespesas.Filtered := true;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  if DM.qryCategoriasReceita.Active = false then
    DM.qryCategoriasReceita.Active := true;

  if DM.qryCategoriasDespesa.Active = false then
    DM.qryCategoriasDespesa.Active := true;

  if DM.qryReceitas.Active = false then
    DM.qryReceitas.Active := true;

  if DM.qryDespesas.Active = false then
    DM.qryDespesas.Active := true;

  if qrylkpCategoriasDespesa.Active = false then
    qrylkpCategoriasDespesa.Active := true;

  if qrylkpCategoriasReceita.Active = false then
    qrylkpCategoriasReceita.Active := true;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  nDia, nMes, nAno : word;
  cMes, cAno : String;

begin
  DecodeDate(now, nAno, nMes, nDia);
  cMes  :=  StrZero(nMes, 2);
  cAno  :=  StrZero(nAno, 4);

  CarregaComboMesAno;
  FiltrarReceitasEDespesas(cMes, cAno);
end;

procedure TfrmMain.grdDespesasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  dDataVencimento : TDate;

begin
  dDataVencimento := date();

  if (DM.qryDespesasVALORPAGO.Value = DM.qryDespesasVALORAPAGAR.Value) then
  begin
    grdDespesas.Canvas.Brush.Color  := clGreen;
    grdDespesas.Canvas.Font.Color   := clWhite;
    grdDespesas.Canvas.Font.Style   := [fsBold];
  end
  else if (DM.qryDespesasDATAVENCIMENTO.Value = dDataVencimento) and
          (DM.qryDespesasVALORPAGO.Value <> DM.qryDespesasVALORAPAGAR.Value) then
  begin
    grdDespesas.Canvas.Brush.Color := clOlive;
    grdDespesas.Canvas.Font.Style := [fsBold];
  end
  else if (DM.qryDespesasDATAVENCIMENTO.Value < dDataVencimento) and
          (DM.qryDespesasVALORPAGO.Value <> DM.qryDespesasVALORAPAGAR.Value) then
  begin
    grdDespesas.Canvas.Brush.Color := clRed;
    grdDespesas.Canvas.Font.Style := [fsBold];
  end;

  grdDespesas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmMain.grdDespesasMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
  aux: string;
  lnTotalSelecionado : Double;

begin
  lnTotalSelecionado  := 0;

  //Make sure right button is clicked over the grid title
  if button = mbRight then
  begin
    for i := 0 to grdDespesas.SelectedRows.Count - 1 do
    begin
      dsDesepsas.Dataset.Bookmark:= grdDespesas.SelectedRows[i];
      lnTotalSelecionado := lnTotalSelecionado + BcdToDouble(DM.qryDespesasVALORAPAGAR.Value);
    end;

    MessageBox(Handle, PChar(formatfloat('0#.#0', lnTotalSelecionado)),
        'Total de Despesas Selecionadas', MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TfrmMain.grdReceitasDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (BcdToDouble(DM.qryReceitasVALORRECEBIDO.Value) < BcdToDouble(DM.qryReceitasVALORARECEBER.Value)) then
  begin
    grdReceitas.Canvas.Brush.Color  := clRed;
    grdReceitas.Canvas.Font.Style   := [fsBold];
  end
end;

procedure TfrmMain.grdReceitasMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
  aux: string;
  lnTotalSelecionado : Double;

begin
  lnTotalSelecionado  := 0;

  //Make sure right button is clicked over the grid title
  if button = mbRight then
  begin
    for i := 0 to grdReceitas.SelectedRows.Count - 1 do
    begin
      dsReceitas.Dataset.Bookmark:= grdReceitas.SelectedRows[i];
      lnTotalSelecionado := lnTotalSelecionado + BcdToDouble(DM.qryReceitasVALORARECEBER.Value);
    end;

    MessageBox(Handle, PChar(formatfloat('0#.#0', lnTotalSelecionado)),
        'Total de Receitas Selecionadas', MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TfrmMain.Receitas1Click(Sender: TObject);
begin
  frmCategoriasReceita := TfrmCategoriasReceita.Create(self);
  frmCategoriasReceita.nIdUsuario   := nIdUsuario;
  frmCategoriasReceita.cNomeUsuario := cNomeUsuario;

  frmCategoriasReceita.ShowModal;
  freeAndNil(frmCategoriasReceita);

  qrylkpCategoriasReceita.Refresh;
end;

procedure TfrmMain.rgMostrarDespesasClick(Sender: TObject);
begin
  FiltrarReceitasEDespesas('','');
end;

procedure TfrmMain.CarregaComboMesAno;
var
  QryListagemCombo : TFDQuery;
  cMes, cAno, cMesAtual, cAnoAtual, cMesAnoAtual : String;
  nDia, nMes, nAno : Word;
begin
  DecodeDate(date, nAno, nMes, nDia);
  cMesAtual     := StrZero(nMes, 2);
  cAnoAtual     := StrZero(nAno, 4);
  cMesAnoAtual  := cMesAtual + '/' + cAnoAtual;

  cboMesAno.Items.Clear;
  cboMesAno.Items.Add('TODOS');

  QryListagemCombo            := TFDQuery.Create(nil);
  QryListagemCombo.Connection := DM.Conn;
  QryListagemCombo.SQL.Clear;

  QryListagemCombo.SQL.Add('SELECT MES, ANO                                        ');
  QryListagemCombo.SQL.Add('      FROM (                                           ');
  QryListagemCombo.SQL.Add('            SELECT MONTH(lr.DATAARECEBER) AS MES,      ');
  QryListagemCombo.SQL.Add('                   YEAR(lr.DATAARECEBER) AS ANO        ');
  QryListagemCombo.SQL.Add('            FROM lancamentosReceita lr                 ');

  if nIdUsuario > 0 then
    QryListagemCombo.SQL.Add('            WHERE lr.IDUSUARIO = :PIDUSUARIO         ');

  QryListagemCombo.SQL.Add('            UNION                                      ');

  QryListagemCombo.SQL.Add('            SELECT MONTH(ld.datavencimento) AS MES,    ');
  QryListagemCombo.SQL.Add('                   YEAR(ld.datavencimento) AS ANO      ');
  QryListagemCombo.SQL.Add('            FROM lancamentosDESPESA ld                 ');

  if nIdUsuario > 0 then
    QryListagemCombo.SQL.Add('            WHERE ld.IDUSUARIO = :PIDUSUARIO         ');

  QryListagemCombo.SQL.Add('            UNION                                      ');

  QryListagemCombo.SQL.Add('            SELECT MONTH(max(ld.datavencimento) + INTERVAL 1 DAY) AS MES, ');
  QryListagemCombo.SQL.Add('                   YEAR(max(ld.datavencimento)) AS ANO ');
  QryListagemCombo.SQL.Add('            FROM lancamentosDESPESA ld                              ');

  if nIdUsuario > 0 then
    QryListagemCombo.SQL.Add('            WHERE ld.IDUSUARIO = :PIDUSUARIO                      ');

  QryListagemCombo.SQL.Add('          ) tmpMesAno                                               ');
  QryListagemCombo.SQL.Add('      ORDER BY ANO DESC, MES DESC                                   ');

  if nIdUsuario > 0 then
    QryListagemCombo.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;

  QryListagemCombo.Open;

  if(not QryListagemCombo.EOF) then
  begin
     QryListagemCombo.First;
     While Not QryListagemCombo.EOF do
     begin
        cMes := StrZero(
                QryListagemCombo.FieldByName('MES').AsInteger,
                2);

        cAno := IntToStr(QryListagemCombo.FieldByName('ANO').AsInteger);
        cboMesAno.Items.Add(cMes + '/' + cAno);
        QryListagemCombo.Next;
     end;

     cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(cMesAnoAtual);
     FiltrarReceitasEDespesas('', '');
  end;

  if (DM.qryDespesas.RecordCount <= 0) AND
     (DM.qryReceitas.RecordCount <= 0) then
    cboMesAno.Items.Clear;

  lblTotalDespesas.Caption := 'Total de Registros: ' + StrZero(DM.qryDespesas.RecordCount, 4);
  lblTotalReceitas.Caption := 'Total de Registros: ' + StrZero(DM.qryReceitas.RecordCount, 4);

  FreeAndNil(QryListagemCombo);
end;

procedure TfrmMain.cboMesAnoChange(Sender: TObject);
var
  mesAno, cMes, cAno, cFiltroDesp, cFiltroRec : String;
begin
	mesAno      :=  cboMesAno.Items[cboMesAno.ItemIndex];
	cMes        :=  '';
	cAno        :=  '';
  cFiltroDesp :=  '';
  cFiltroRec  :=  '';

	if UpperCase(mesAno) <> 'TODOS' then
	begin
	  cMes   := Copy(mesAno, 0, 2);
	  cAno   := Copy(mesAno, 4, 6);
  end;

  FiltrarReceitasEDespesas(cMes, cAno);

{
	if UpperCase(mesAno) <> 'TODOS' then
	begin
    cFiltroDesp := ' MONTH(LD.DATAVENCIMENTO)=' + QuotedStr(cMes) + ' AND YEAR(LD.DATAVENCIMENTO)=' + QuotedStr(cAno);
    cFiltroRec  := ' MONTH(LR.DATARECEBIMENTO)=' + QuotedStr(cMes) + ' AND YEAR(LR.DATARECEBIMENTO)=' + QuotedStr(cAno);

    dm.qryDespesas.Filtered := false;
    dm.qryDespesas.Filter   := cFiltroDesp;
    dm.qryDespesas.Filtered := true;

    dm.qryReceitas.Filtered := false;
    dm.qryReceitas.Filter   := cFiltroRec;
    dm.qryReceitas.Filtered := true;
	end;
}
end;

procedure TfrmMain.chkMostrarDespesasJaPagasClick(Sender: TObject);
var
  mesAno, cMes, cAno : String;
begin
	mesAno := cboMesAno.Items[cboMesAno.ItemIndex];
	cMes   := '';
	cAno   := '';

	if UpperCase(mesAno) <> 'TODOS' then
	begin
	  cMes   := Copy(mesAno, 0, 2);
	  cAno   := Copy(mesAno, 4, 6);
	end;

  FiltrarReceitasEDespesas(cMes, cAno);
end;

function TfrmMain.StrZero(iNumero, iComp: Integer): String;
begin
  Result := StringOfChar('0', iComp - Length(IntToStr(iNumero))) +
            IntToStr(iNumero);
end;

procedure TfrmMain.Usurios1Click(Sender: TObject);
begin
  frmUsuarios := TfrmUsuarios.create(self);
  frmUsuarios.ShowModal;
  FreeAndNil(frmUsuarios);
end;

procedure TfrmMain.setTotaisDespesas(cMes, cAno : String);
var
  QryTotaisDespesas : TFDQuery;

begin
  QryTotaisDespesas            := TFDQuery.Create(nil);
  QryTotaisDespesas.Connection := DM.Conn;
  QryTotaisDespesas.SQL.Add('SELECT SUM(LD.VALORAPAGAR) AS TOTALAPAGAR,          ');
  QryTotaisDespesas.SQL.Add('       SUM(LD.VALORPAGO) AS TOTALPAGO               ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add('   ,MONTH(LD.DATAVENCIMENTO) AS MES, ');
    QryTotaisDespesas.SQL.Add('    YEAR(LD.DATAVENCIMENTO) AS ANO   ');
  end;

  QryTotaisDespesas.SQL.Add('FROM LANCAMENTOSDESPESA LD                          ');
  QryTotaisDespesas.SQL.Add('WHERE 1=1                                           ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add('  AND MONTH(LD.DATAVENCIMENTO)=:PMes ');
    QryTotaisDespesas.SQL.Add('  AND YEAR(LD.DATAVENCIMENTO) =:PAno ');
  end;

  if nIdUsuario > 0 then
  begin
    QryTotaisDespesas.SQL.Add('    AND lD.IDUSUARIO = :PIDUSUARIO                ');
    QryTotaisDespesas.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisDespesas.SQL.Add(' GROUP BY MES, ANO                                ');

    QryTotaisDespesas.ParamByName('PMes').AsAnsiString := cMes;
    QryTotaisDespesas.ParamByName('PAno').AsAnsiString := cAno;
  end;

  QryTotaisDespesas.Open;

  if(not QryTotaisDespesas.EOF) then
  begin
    lblDepesaAPagar.Caption := 'R$ ' + FormatFloat( '#,##0.00' ,
                          QryTotaisDespesas.FieldByName('TOTALAPAGAR').AsFloat);
    lblDepesaPaga.Caption   := 'R$ ' + FormatFloat( '#,##0.00' ,
                          QryTotaisDespesas.FieldByName('TOTALPAGO').AsFloat);
    lblFaltaPagar.Caption   := 'R$ ' + FormatFloat( '#,##0.00' ,
                          (QryTotaisDespesas.FieldByName('TOTALPAGO').AsFloat -
                             QryTotaisDespesas.FieldByName('TOTALAPAGAR').AsFloat ));
  end else
  begin
    lblDepesaAPagar.Caption := 'R$ 0,00';
    lblDepesaPaga.Caption   := 'R$ 0,00';
    lblFaltaPagar.Caption   := 'R$ 0,00';
  end;

  FreeAndNil(QryTotaisDespesas);
end;

procedure TfrmMain.setTotaisReceitas(cMes, cAno : String);
var
  QryTotaisReceitas : TFDQuery;

begin
  QryTotaisReceitas            := TFDQuery.Create(nil);
  QryTotaisReceitas.Connection := DM.Conn;
  QryTotaisReceitas.SQL.Add('SELECT SUM(LR.VALORARECEBER) AS TOTALARECEBER,       ');
  QryTotaisReceitas.SQL.Add('       SUM(LR.VALORRECEBIDO) AS TOTALRECEBIDO        ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add('   ,MONTH(LR.DATARECEBIMENTO) AS MES, ');
    QryTotaisReceitas.SQL.Add('    YEAR(LR.DATARECEBIMENTO) AS ANO   ');
  end;

  QryTotaisReceitas.SQL.Add('FROM LANCAMENTOSRECEITA LR                           ');

  QryTotaisReceitas.SQL.Add('WHERE 1=1                                            ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add('  AND MONTH(LR.DATARECEBIMENTO)=:PMes ');
    QryTotaisReceitas.SQL.Add('  AND YEAR(LR.DATARECEBIMENTO) =:PAno ');
  end;

  if nIdUsuario > 0 then
  begin
    QryTotaisReceitas.SQL.Add('    AND LR.IDUSUARIO = :PIDUSUARIO                 ');
    QryTotaisReceitas.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    QryTotaisReceitas.SQL.Add(' GROUP BY MES, ANO                                 ');

    QryTotaisReceitas.ParamByName('PMes').AsAnsiString := cMes;
    QryTotaisReceitas.ParamByName('PAno').AsAnsiString := cAno;
  end;


  QryTotaisReceitas.Open;

  if(not QryTotaisReceitas.EOF) then
  begin
    lblReceitaAReceber.Caption := 'R$ ' + FormatFloat( '#,##0.00' ,
                        QryTotaisReceitas.FieldByName('TOTALARECEBER').AsFloat);
    lblReceitaRecebida.Caption   := 'R$ ' + FormatFloat( '#,##0.00' ,
                        QryTotaisReceitas.FieldByName('TOTALRECEBIDO').AsFloat);
    lblFaltaReceber.Caption   := 'R$ ' + FormatFloat( '#,##0.00' ,
                        (QryTotaisReceitas.FieldByName('TOTALRECEBIDO').AsFloat -
                           QryTotaisReceitas.FieldByName('TOTALARECEBER').AsFloat));
  end else
  begin
    lblReceitaAReceber.Caption  := 'R$ 0,00';
    lblReceitaRecebida.Caption  := 'R$ 0,00';
    lblFaltaReceber.Caption     := 'R$ 0,00';
  end;

  FreeAndNil(QryTotaisReceitas);
end;

procedure TfrmMain.CarregaReceitas(cMes, cAno : String);
begin
  DM.qryReceitas.Close;
  DM.qryReceitas.SQL.Clear;
  DM.qryReceitas.SQL.Add('SELECT                                                ');
  DM.qryReceitas.SQL.Add('       ROW_NUMBER() OVER(');
  DM.qryReceitas.SQL.Add('ORDER BY ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryReceitas.SQL.Add('YEAR(LR.DATARECEBIMENTO) ASC, ');
    DM.qryReceitas.SQL.Add('MONTH(LR.DATARECEBIMENTO) ASC, ');
    DM.qryReceitas.SQL.Add('DAY(LR.DATARECEBIMENTO) ASC');
  end else
    DM.qryReceitas.SQL.Add('LR.DATARECEBIMENTO');

  DM.qryReceitas.SQL.Add(') AS SEQUENCIA, ');
  DM.qryReceitas.SQL.Add('       LR.ID,                                         ');
  DM.qryReceitas.SQL.Add('       LR.DESCRICAO,                                  ');
  DM.qryReceitas.SQL.Add('       LR.DATARECEBIMENTO,                            ');
  DM.qryReceitas.SQL.Add('       LR.VALORARECEBER,                              ');
  DM.qryReceitas.SQL.Add('       LR.VALORRECEBIDO,                              ');
  DM.qryReceitas.SQL.Add('       LR.IDCATEGORIA,                                ');
  DM.qryReceitas.SQL.Add('       CR.descricao as categoriaReceita,              ');
  DM.qryReceitas.SQL.Add('       LR.IDUSUARIO,                                  ');
  DM.qryReceitas.SQL.Add('       LR.DATAARECEBER,                               ');
  DM.qryReceitas.SQL.Add('       LR.OBSERVACOES                                 ');
  DM.qryReceitas.SQL.Add('FROM lancamentosReceita LR                            ');
  DM.qryReceitas.SQL.Add('INNER JOIN CATEGORIASReceita CR ON LR.idcategoria=CR.id ');
  DM.qryReceitas.SQL.Add('WHERE 1=1                                             ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryReceitas.SQL.Add('  AND MONTH(LR.DATARECEBIMENTO)=:PMes  ');
    DM.qryReceitas.SQL.Add('  AND YEAR(LR.DATARECEBIMENTO) =:PAno  ');
  end;

  if nIdUsuario > 0 then
  begin
    DM.qryReceitas.SQL.Add('  AND LR.IDUSUARIO =:PIDUSUARIO                     ');
    DM.qryReceitas.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryReceitas.SQL.Add('ORDER BY YEAR(LR.DATARECEBIMENTO) ASC, ');
    DM.qryReceitas.SQL.Add('         MONTH(LR.DATARECEBIMENTO) ASC,');
    DM.qryReceitas.SQL.Add('         DAY(LR.DATARECEBIMENTO) ASC   ');

    DM.qryReceitas.ParamByName('PMes').AsAnsiString := cMes;
    DM.qryReceitas.ParamByName('PAno').AsAnsiString := cAno;
  end else
    DM.qryReceitas.SQL.Add('ORDER BY LR.DATARECEBIMENTO ASC                     ');

  DM.qryReceitas.Open;

  lblTotalReceitas.Caption := 'Total de Registros: ' + StrZero(DM.qryReceitas.RecordCount, 4);
end;

procedure TfrmMain.CarregaDespesas(cMes, cAno : String);
begin
  DM.qryDespesas.Close;
  DM.qryDespesas.SQL.Clear;
  DM.qryDespesas.SQL.Add('SELECT                                                ');
  DM.qryDespesas.SQL.Add('       ROW_NUMBER() OVER(');
  DM.qryDespesas.SQL.Add('ORDER BY ');

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryDespesas.SQL.Add('YEAR(LD.DATAVENCIMENTO) ASC, ');
    DM.qryDespesas.SQL.Add('MONTH(LD.DATAVENCIMENTO) ASC, ');
    DM.qryDespesas.SQL.Add('DAY(LD.DATAVENCIMENTO) ASC');
  end else
    DM.qryDespesas.SQL.Add('LD.DATAVENCIMENTO');

  DM.qryDespesas.SQL.Add(') AS SEQUENCIA, ');
  DM.qryDespesas.SQL.Add('       LD.ID,                                           ');
  DM.qryDespesas.SQL.Add('       LD.DESCRICAO,                                    ');
  DM.qryDespesas.SQL.Add('       LD.DATAVENCIMENTO,                               ');
  DM.qryDespesas.SQL.Add('       LD.VALORAPAGAR,                                  ');
  DM.qryDespesas.SQL.Add('       LD.VALORPAGO,                                    ');
  DM.qryDespesas.SQL.Add('       LD.IDCATEGORIA,                                  ');
  DM.qryDespesas.SQL.Add('       CD.DESCRICAO as categoriaDespesa,                ');
  DM.qryDespesas.SQL.Add('       LD.IDUSUARIO,                                    ');
  DM.qryDespesas.SQL.Add('       LD.DATAPAGAMENTO,                                ');
  DM.qryDespesas.SQL.Add('       LD.OBSERVACOES                                   ');
  DM.qryDespesas.SQL.Add('FROM lancamentosdespesa LD                              ');
  DM.qryDespesas.SQL.Add('INNER JOIN CATEGORIASDESPESA CD ON LD.idcategoria=CD.id ');
  DM.qryDespesas.SQL.Add('WHERE 1=1                                               ');

  case rgMostrarDespesas.ItemIndex of
    //Somente Não Pagas
    1: DM.qryDespesas.SQL.Add('  AND (LD.VALORAPAGAR <> LD.VALORPAGO OR LD.VALORPAGO IS NULL) ');
    //Somente Pagas
    2: DM.qryDespesas.SQL.Add('  AND LD.VALORAPAGAR = LD.VALORPAGO ');
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryDespesas.SQL.Add('  AND MONTH(LD.DATAVENCIMENTO)=:PMes   ');
    DM.qryDespesas.SQL.Add('  AND YEAR(LD.DATAVENCIMENTO) =:PAno   ');
  end;

  if nIdUsuario > 0 then
  begin
    DM.qryDespesas.SQL.Add('    AND LD.IDUSUARIO =:PIDUSUARIO                   ');
    DM.qryDespesas.ParamByName('PIDUSUARIO').AsInteger := nIdUsuario;
  end;

  if (trim(cMes) <> '') AND (trim(cAno) <> '') then
  begin
    DM.qryDespesas.SQL.Add('ORDER BY YEAR(LD.DATAVENCIMENTO) ASC,  ');
    DM.qryDespesas.SQL.Add('         MONTH(LD.DATAVENCIMENTO) ASC, ');
    DM.qryDespesas.SQL.Add('         DAY(LD.DATAVENCIMENTO) ASC    ');

    DM.qryDespesas.ParamByName('PMes').AsAnsiString := cMes;
    DM.qryDespesas.ParamByName('PAno').AsAnsiString := cAno;
  end else
    DM.qryDespesas.SQL.Add('ORDER BY LD.DATAVENCIMENTO ASC                      ');

  DM.qryDespesas.Open;

  lblTotalDespesas.Caption := 'Total de Registros: ' + StrZero(DM.qryDespesas.RecordCount, 4);
end;

Procedure TfrmMain.FiltrarReceitasEDespesas(cMesAtual, cAnoAtual:String);
var
  mesAno, cMes, cAno : String;
begin
  if (cMesAtual = '') AND (cAnoAtual = '') then
  begin
    mesAno := cboMesAno.Items[cboMesAno.ItemIndex];
    cMes   := '';
    cAno   := '';

    if (UpperCase(mesAno) <> 'TODOS') AND
       (trim(cMesAtual) = '') AND
       (trim(cAnoAtual) = '') then
    begin
      cMes   := Copy(mesAno, 0, 2);
      cAno   := Copy(mesAno, 4, 6);
    end;
  end else
  begin
    cMes := cMesAtual;
    cAno := cAnoAtual;
  end;

  setTotaisDespesas(cMes, cAno);
  setTotaisReceitas(cMes, cAno);

  CarregaDespesas(cMes, cAno);
  CarregaReceitas(cMes, cAno);
end;

end.

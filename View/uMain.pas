unit uMain;

interface

uses
  Usuario, Despesa, Receita, DespesaController, ReceitaController, MainController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMTBcd, ShellAPI, ComObj, Clipbrd;

type
  TOperacaoDespesa = (tpNoneDespesa, tpAlterarDespesa, tpIncluirDespesa);
  TOperacaoReceita = (tpNoneReceita, tpAlterarReceita, tpIncluirReceita);

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
    lblCategoriaReceita: TLabel;
    lkpCategoriaReceita: TDBLookupComboBox;
    lblReceita: TLabel;
    Label1: TLabel;
    Label2: TLabel;
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
    N1: TMenuItem;
    Usurios1: TMenuItem;
    lblTotalDespesas: TLabel;
    lblTotalReceitas: TLabel;
    lblTotalAReceber: TLabel;
    lblrecebido: TLabel;
    lblVlFaltaReceber: TLabel;
    lblDTAReceber: TLabel;
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
    lblCategoriaDespesa: TLabel;
    lkpCategoriaDespesa: TDBLookupComboBox;
    Label6: TLabel;
    lblValorPago: TLabel;
    lblValorAPagar: TLabel;
    lblDespesa: TLabel;
    lblObservacoesDespesas: TLabel;
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
    Aplicativos1: TMenuItem;
    Calculadora1: TMenuItem;
    Calendrio1: TMenuItem;
    lblDescrDiasUteisNoMes: TLabel;
    lblDiasUteisNoMes: TLabel;
    Exportar1: TMenuItem;
    ParaExcellPlanilhadoAno1: TMenuItem;
    lblArquivoAnexo: TLabel;
    btnArquivoAnexo: TBitBtn;
    odArquivoAnexo: TOpenDialog;
    btnAbirArquivo: TBitBtn;
    N2: TMenuItem;
    ListadeDesejos1: TMenuItem;
    edtDTVencimento: TMaskEdit;
    chkDespesaFixa: TCheckBox;
    edtDespesa: TEdit;
    edtArquivoAnexo: TEdit;
    edtObservacoesDespesas: TMemo;
    edtValorAPagar: TEdit;
    edtValorPago: TEdit;
    edtDTPagamento: TMaskEdit;
    edtDTAreceber: TMaskEdit;
    edtDTRecebimento: TMaskEdit;
    edtReceita: TEdit;
    edtValorAReceber: TEdit;
    edtValorRecebido: TEdit;
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
    procedure Calculadora1Click(Sender: TObject);
    procedure Calendrio1Click(Sender: TObject);
    procedure ParaExcellPlanilhadoAno1Click(Sender: TObject);
    procedure btnArquivoAnexoClick(Sender: TObject);
    procedure btnAbirArquivoClick(Sender: TObject);
    procedure ListadeDesejos1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsDesepsasDataChange(Sender: TObject; Field: TField);
    procedure dsReceitasDataChange(Sender: TObject; Field: TField);
    procedure edtValorAPagarExit(Sender: TObject);
    procedure edtValorPagoExit(Sender: TObject);
    procedure edtValorAReceberExit(Sender: TObject);
    procedure edtValorRecebidoExit(Sender: TObject);
  private
    { Private declarations }
    clsDespesa            : TDespesa;
    clsDespesaController  : TDespesaController;

    clsReceita            : TReceita;
    clsReceitaController  : TReceitaController;

    FOperacaoDespesa: TOperacaoDespesa;
    FOperacaoReceita: TOperacaoReceita;

    cMesAtual, cAnoAtual, cMesAnoAtual : String;

    procedure SetOperacaoDespesa(const operacaoDespesa: TOperacaoDespesa);
    procedure SetOperacaoReceita(const operacaoReceita: TOperacaoReceita);

    procedure CarregaComboMesAno;
    function StrZero(iNumero, iComp: Integer): String;
    procedure setTotaisDespesas(cMes, cAno : String);
    procedure setTotaisReceitas(cMes, cAno : String);
    procedure CarregaReceitas(cMes, cAno : String);
    procedure CarregaDespesas(cMes, cAno : String);
    Procedure FiltrarReceitasEDespesas(cMesAtual, cAnoAtual:String);
    function DisplayFormatter(AValue: double; ADisplayFormato: String): String;
    procedure limparCamposDespesa();
    procedure limparCamposReceita();
  public
    { Public declarations }
    clsDespesaManut : TDespesa;
    clsReceitaManut : TReceita;

    clsUsuario     : Tusuario;
    idUsuario      : integer;
    cQtdeDiasUteis : String;
    property OperacaoDespesa : TOperacaoDespesa read FOperacaoDespesa write SetOperacaoDespesa;
    property OperacaoReceita : TOperacaoReceita read FOperacaoReceita write SetOperacaoReceita;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uCategoriasDespesa, uDM, uCategoriasReceita, uGeracaoParcelas, uCalendario,
  Funcoes, uLogin, uImprDespesas, uExpoPlanExelAnual, uListaDesejos, uUsuarios;

procedure TfrmMain.SetOperacaoDespesa(const operacaoDespesa: TOperacaoDespesa);
begin
  FOperacaoDespesa := operacaoDespesa;

  btnNovoDespesa.Enabled      := FOperacaoDespesa = tpNoneDespesa;
  btnSalvarDespesa.Enabled    := (FOperacaoDespesa in [tpAlterarDespesa, tpIncluirDespesa]);
  btnExcluirDespesa.Enabled   := FOperacaoDespesa = tpNoneDespesa;
  btnDesfazerDespesa.Enabled  := not (FOperacaoDespesa = tpNoneDespesa);
end;

procedure TfrmMain.SetOperacaoReceita(const operacaoReceita: TOperacaoReceita);
begin
  FOperacaoReceita := operacaoReceita;

  btnNovoReceita.Enabled      := FOperacaoReceita = tpNoneReceita;
  btnSalvarReceita.Enabled    := (FOperacaoReceita in [tpAlterarReceita, tpIncluirReceita]);
  btnExcluirReceita.Enabled   := FOperacaoReceita = tpNoneReceita;
  btnDesfazerReceita.Enabled  := not (FOperacaoReceita = tpNoneReceita);
end;

procedure TfrmMain.btnAbirArquivoClick(Sender: TObject);
var
  Pdir: Pchar;
begin
  if FileExists(trim(dm.qryDespesas.FieldByName('arquivoAnexo').AsString)) then
  begin
    GetMem(pDir, 256);
    StrPCopy(pDir, trim(dm.qryDespesas.FieldByName('arquivoAnexo').AsString)); {Aqui vc coloca o caminho + o nome do arquivo}
    ShellExecute(0, nil, PChar(trim(dm.qryDespesas.FieldByName('arquivoAnexo').AsString)), nil, Pdir, SW_NORMAL);
    FreeMem(pdir,256);
  end;
end;

procedure TfrmMain.btnAlterarDespesaClick(Sender: TObject);
var
  clsDespesaMan       : TDespesa;
  clsDespesaController  : TDespesaController;
begin
  SetOperacaoDespesa(tpAlterarDespesa);


  try
    clsDespesaMan         := TDespesa.Create;
    clsDespesaController  := TDespesaController.Create;

    clsDespesaMan.id  := DM.qryDespesas.FieldByName('id').AsInteger;

    clsDespesaMan     := clsDespesaController.findById(clsDespesaMan);

    if clsDespesaMan <> nil then
    begin
      edtDespesa.Text               :=  clsDespesaMan.descricao;

      if clsDespesaMan.dataVencimento <> null then
        edtDTVencimento.Text          :=  DateToStr(clsDespesaMan.dataVencimento);

      edtValorAPagar.Text           :=  FormatFloat('#0.00', clsDespesaMan.valorAPagar);

       if clsDespesaMan.dataPagamento <> null then
        edtDTPagamento.Text           :=  DateToStr(clsDespesaMan.dataPagamento);

      edtValorPago.Text             :=  FormatFloat('#0.00', clsDespesaMan.valorPago);
      lkpCategoriaDespesa.KeyValue  :=  clsDespesaMan.idCategoria;
      edtObservacoesDespesas.Text   :=  clsDespesaMan.observacoes;
      chkDespesaFixa.Checked        :=  clsDespesaMan.despesaFixa; //IIF(clsDespesaMan.despesaFixa = 0, false, true);
      edtArquivoAnexo.Text          :=  clsDespesaMan.arquivoAnexo;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsDespesaMan);
  FreeAndNil(clsDespesaController);
end;

procedure TfrmMain.btnAlterarReceitaClick(Sender: TObject);
var
  clsReceitaMan        : TReceita;
  clsReceitaController : TReceitaController;
begin
  SetOperacaoReceita(tpAlterarReceita);

  try
    clsReceitaMan         := TReceita.Create;
    clsReceitaController  := TReceitaController.Create;

    clsReceitaMan.id  := DM.qryReceitas.FieldByName('id').AsInteger;

    clsReceitaMan     := clsReceitaController.findById(clsReceitaMan);

    if clsReceitaMan <> nil then
    begin
      edtDTAReceber.Text            :=  DateToStr(clsReceitaMan.dataAReceber);
      edtDTRecebimento.Text         :=  DateToStr(clsReceitaMan.dataRecebimento);

      edtReceita.Text               :=  clsReceitaMan.descricao;
      edtValorAReceber.Text         :=  FormatFloat('#0.00', clsReceitaMan.valorAReceber);
      edtValorRecebido.Text         :=  FormatFloat('#0.00', clsReceitaMan.valorRecebido);
      lkpCategoriaReceita.KeyValue  :=  clsReceitaMan.idCategoria;
      edtObservacoesReceitas.Text   :=  clsReceitaMan.observacoes;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsReceitaMan);
  FreeAndNil(clsReceitaController);
end;

procedure TfrmMain.btnArquivoAnexoClick(Sender: TObject);
begin
  if odArquivoAnexo.Execute() then
    if FileExists(odArquivoAnexo.FileName) then
    Begin
      edtArquivoAnexo.Text := trim(odArquivoAnexo.FileName);
    End;
end;

procedure TfrmMain.btnCalendarioClick(Sender: TObject);
begin
  frmCalendario := TfrmCalendario.Create(self);
  frmCalendario.ShowModal;
  FreeAndNil(frmCalendario);
end;

procedure TfrmMain.btnDesfazerDespesaClick(Sender: TObject);
begin
  SetOperacaoDespesa(tpNoneDespesa);

  limparCamposDespesa();
end;

procedure TfrmMain.btnDesfazerReceitaClick(Sender: TObject);
begin
  SetOperacaoReceita(tpNoneReceita);

  limparCamposReceita();
end;

procedure TfrmMain.btnExcluirDespesaClick(Sender: TObject);
var
  clsDespesa            : TDespesa;
  clsDespesaController  : TDespesaController;
begin
  if DM.qryDespesas.RecordCount > 0 then
    if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      cMesAnoAtual  := cboMesAno.Items[cboMesAno.ItemIndex];

      try
        clsDespesaController.excluir(clsDespesa);
      except
        On E: Exception do
          ShowMessage(e.Message);
      end;

      FreeAndNil(clsDespesa);
      FreeAndNil(clsDespesaController);

      CarregaComboMesAno;

      FiltrarReceitasEDespesas('','');
    end;

  SetOperacaoDespesa(tpNoneDespesa);
  limparCamposDespesa();
end;

procedure TfrmMain.btnExcluirReceitaClick(Sender: TObject);
var
  clsReceita            : TReceita;
  clsReceitaController  : TReceitaController;
  clsMainController     : TMainController;
  listaCombo            : TStringList;
  i                     : Integer;

begin
  if DM.qryReceitas.RecordCount > 0 then
    if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      cMesAnoAtual  := cboMesAno.Items[cboMesAno.ItemIndex];

      try
        clsReceitaController.excluir(clsReceita);
      except
        On E: Exception do
          ShowMessage(e.Message);
      end;

      FreeAndNil(clsReceita);
      FreeAndNil(clsReceitaController);

      CarregaComboMesAno;

      FiltrarReceitasEDespesas('','');
    end;

  SetOperacaoDespesa(tpNoneDespesa);
  limparCamposDespesa();
end;

procedure TfrmMain.btnNovoDespesaClick(Sender: TObject);
begin
  limparCamposDespesa();

  SetOperacaoDespesa(tpIncluirDespesa);

  edtDTVencimento.Text :=  DateToStr(Date());
  edtDTVencimento.setFocus;
end;

procedure TfrmMain.btnNovoReceitaClick(Sender: TObject);
begin
  SetOperacaoReceita(tpIncluirReceita);

  edtDTAreceber.Text := DateToStr(Date());
  edtDTAreceber.setFocus;
end;

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnSalvarDespesaClick(Sender: TObject);
var
  clsDespesa : TDespesa;
  clsDespesaController : TDespesaController;
  mesAno, cMes, cAno : String;

begin
  mesAno  := cboMesAno.Items[cboMesAno.ItemIndex];
  cMes    := '';
  cAno    := '';

  if UpperCase(mesAno) <> 'TODOS' then
  begin
    cMes   := Copy(mesAno, 0, 2);
    cAno   := Copy(mesAno, 4, 6);
  end;

  try
    clsDespesa            := TDespesa.Create;
    clsDespesaController  := TDespesaController.Create;

    clsDespesa.id               := DM.qryDespesas.FieldByName('id').AsInteger;
    clsDespesa.descricao        := edtDespesa.Text;
    if trim(edtDTVencimento.Text) <> '/  /' then
      clsDespesa.dataVencimento   := StrToDate(edtDTVencimento.Text);

    if trim(edtValorAPagar.Text) <> '' then
      clsDespesa.valorAPagar := StrToCurr(edtValorAPagar.Text)
    else
      clsDespesa.valorAPagar := 0.00;

    if trim(edtDTPagamento.Text) <> '/  /' then
      clsDespesa.dataPagamento   := StrToDate(edtDTPagamento.Text);

    if trim(edtValorPago.Text) <> '' then
      clsDespesa.valorPago         := StrToCurr(edtValorPago.Text)
    else
      clsDespesa.valorPago         := 0.00;

    clsDespesa.idCategoria       := lkpCategoriaDespesa.KeyValue;
    clsDespesa.observacoes       := edtObservacoesDespesas.Text;
    clsDespesa.despesaFixa       := IIF(chkDespesaFixa.Checked, true, false);
    clsDespesa.nParc             := DM.qryDespesas.FieldByName('nParc').AsInteger;
    clsDespesa.totParc           := DM.qryDespesas.FieldByName('totParc').AsInteger;
    clsDespesa.arquivoAnexo      := edtArquivoAnexo.Text;
    clsDespesa.valorDiferenca    := clsDespesa.valorAPagar - clsDespesa.valorPago;
    clsDespesa.idUsuario         := clsUsuario.id;

    if OperacaoDespesa = tpIncluirDespesa then
      clsDespesaController.incluir(clsDespesa)
    else if OperacaoDespesa = tpAlterarDespesa then
      clsDespesaController.alterar(clsDespesa);

    SetOperacaoDespesa(tpNoneDespesa);

    limparCamposDespesa();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  CarregaComboMesAno;

  cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(mesAno);

  clsDespesaController.findByMesAno(clsDespesa, cMes, cAno, rgMostrarDespesas.ItemIndex);


  FreeAndNil(clsDespesa);
  FreeAndNil(clsDespesaController);
end;

procedure TfrmMain.btnSalvarReceitaClick(Sender: TObject);
var
  mesAno, cMes, cAno : String;
  nRecNo : Integer;
  clsReceita : TReceita;
  clsReceitaController : TReceitaController;
begin
  mesAno := cboMesAno.Items[cboMesAno.ItemIndex];
  cMes   := '';
  cAno   := '';

  if UpperCase(mesAno) <> 'TODOS' then
  begin
    cMes   := Copy(mesAno, 0, 2);
    cAno   := Copy(mesAno, 4, 6);
  end;

  try
    clsReceita            :=  TReceita.Create;
    clsReceitaController  := TReceitaController.Create;

    clsReceita.id               := DM.qryDespesas.FieldByName('id').AsInteger;
    clsReceita.descricao        := trim(edtReceita.Text);

    if trim(edtDTAreceber.Text) <> '/  /' then
      clsReceita.dataAReceber     := StrToDate(edtDTAreceber.Text);

    if edtValorAReceber.text <> '' then
      clsReceita.valorAReceber    := StrToFloat(edtValorAReceber.Text)
    else
      clsReceita.valorAReceber    := 0.00;

    if trim(edtDTRecebimento.Text) <> '/  /' then
      clsReceita.dataRecebimento  := StrToDate(edtDTRecebimento.Text);

    if edtValorRecebido.text <> '' then
      clsReceita.valorRecebido    := StrToFloat(edtValorRecebido.Text)
    else
      clsReceita.valorRecebido    := 0.00;

    if(clsReceita.valorRecebido <>null) and (clsReceita.valorRecebido > 0)then
      clsReceita.valorDiferenca   := clsReceita.dataRecebimento - clsReceita.valorRecebido
    else
      clsReceita.valorDiferenca   := 0;

    clsReceita.idCategoria      := lkpCategoriaReceita.KeyValue;
    clsReceita.observacoes      := trim(edtObservacoesReceitas.Text);
  	clsReceita.idUsuario        := clsUsuario.id;

    if OperacaoReceita = tpIncluirReceita then
      clsReceitaController.incluir(clsReceita)
    else if OperacaoReceita = tpAlterarReceita then
      clsReceitaController.alterar(clsReceita);

    SetOperacaoReceita(tpNoneReceita);
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsReceita);
  FreeAndNil(clsReceitaController);

  CarregaComboMesAno;

  cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(mesAno);

  FiltrarReceitasEDespesas(cMes, cAno);

  limparCamposReceita();
end;

procedure TfrmMain.Despesas1Click(Sender: TObject);
begin
  frmCategoriasDespesa := TfrmCategoriasDespesa.Create(self);
  frmCategoriasDespesa.clsUsuario   := clsUsuario;

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
  frmGeracaoParcelas.clsUsuario   := clsUsuario;

  frmGeracaoParcelas.ShowModal;
  FreeAndNil(frmGeracaoParcelas);

  CarregaComboMesAno;

  cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(cMesAno);

  FiltrarReceitasEDespesas('','');
end;

procedure TfrmMain.Despesas4Click(Sender: TObject);
begin
  frmImprDespesas :=  TfrmImprDespesas.Create(self);
  frmImprDespesas.usuario    := clsUsuario;

  frmImprDespesas.ShowModal;
  FreeAndNil(frmImprDespesas);
end;

procedure TfrmMain.dsDesepsasDataChange(Sender: TObject; Field: TField);
begin
  if clsDespesaManut <> nil then
  begin
    clsDespesaManut.descricao       :=  trim(DM.qryDespesas.FieldByName('descricao').AsString);
    clsDespesaManut.dataVencimento  :=  DM.qryDespesas.FieldByName('datavencimento').AsDateTime;
    clsDespesaManut.valorAPagar     :=  DM.qryDespesas.FieldByName('valorapagar').AsCurrency;
    clsDespesaManut.dataPagamento   :=  DM.qryDespesas.FieldByName('datapagamento').AsDateTime;
    clsDespesaManut.valorPago       :=  DM.qryDespesas.FieldByName('valorpago').AsCurrency;
    clsDespesaManut.idCategoria     :=  DM.qryDespesas.FieldByName('idCategoria').AsInteger;
    clsDespesaManut.observacoes     :=  DM.qryDespesas.FieldByName('observacoes').AsString;
    clsDespesaManut.despesaFixa     :=  IIF(DM.qryDespesas.FieldByName('despesaFixa').AsInteger = 0, false, true);
    clsDespesaManut.arquivoAnexo    :=  DM.qryDespesas.FieldByName('arquivoAnexo').AsString;
    clsDespesaManut.id              :=  DM.qryDespesas.FieldByName('id').AsInteger;

    if (clsDespesaManut.valorPago <> null) and (clsDespesaManut.valorPago > 0) then
      clsDespesaManut.valorDiferenca  :=  (clsDespesaManut.valorAPagar - clsDespesaManut.valorPago)
    else
      clsDespesaManut.valorDiferenca  :=  0;

    clsDespesaManut.categoriaDespesa  :=  trim(DM.qryDespesas.FieldByName('categoriaDespesa').AsString);
    clsDespesaManut.nParc             :=  DM.qryDespesas.FieldByName('nParc').AsInteger;
    clsDespesaManut.totParc           :=  DM.qryDespesas.FieldByName('totPatrc').AsInteger;
    clsDespesaManut.idUsuario         :=  DM.qryDespesas.FieldByName('idUsuario').AsInteger;
  end;
end;

procedure TfrmMain.dsReceitasDataChange(Sender: TObject; Field: TField);
begin
  if clsReceitaManut <> nil then
  begin
    clsReceitaManut.descricao        := trim(DM.qryReceitas.FieldByName('descricao').AsString);
    clsReceitaManut.dataAReceber     := DM.qryReceitas.FieldByName('dataAReceber').AsDateTime;
    clsReceitaManut.valorAReceber    := DM.qryReceitas.FieldByName('valorAReceber').AsCurrency;
    clsReceitaManut.dataRecebimento  := DM.qryReceitas.FieldByName('dataRecebimento').AsDateTime;
    clsReceitaManut.valorRecebido    := DM.qryReceitas.FieldByName('valorRecebido').AsCurrency;

    if(clsReceitaManut.valorRecebido <> null) and (clsReceitaManut.valorRecebido > 0)then
      clsReceitaManut.valorDiferenca   := clsReceitaManut.valorAReceber - clsReceitaManut.valorRecebido;

    clsReceitaManut.idCategoria      := DM.qryReceitas.FieldByName('idCategoria').AsInteger;
    clsReceitaManut.categoriaReceita := trim(DM.qryReceitas.FieldByName('categoriaReceita').AsString);
    clsReceitaManut.observacoes      := trim(DM.qryReceitas.FieldByName('observacoes').AsString);
    clsReceitaManut.idUsuario        := DM.qryReceitas.FieldByName('idUsuario').AsInteger;
    clsReceitaManut.id               := DM.qryReceitas.FieldByName('id').AsInteger;
  end;
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
	end;


  cFiltro := cFiltro + ' UPPER(DESCRICAO) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryDespesas.Filtered := false;
  dm.qryDespesas.Filter   := cFiltro;
  dm.qryDespesas.Filtered := true;
end;

procedure TfrmMain.edtValorAPagarExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtValorAPagar.Text = EmptyStr) then
    edtValorAPagar.Text := '0';

  if TryStrToFloat(edtValorAPagar.Text, iAux) then
    edtValorAPagar.Text := DisplayFormatter(StrToFloat(edtValorAPagar.Text), ('#0.00'));
end;

procedure TfrmMain.edtValorAReceberExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtValorAReceber.Text = EmptyStr) then
    edtValorAReceber.Text := '0';

  if TryStrToFloat(edtValorAReceber.Text, iAux) then
    edtValorAReceber.Text := DisplayFormatter(StrToFloat(edtValorAReceber.Text), ('#0.00'));
end;

procedure TfrmMain.edtValorPagoExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtValorPago.Text = EmptyStr) then
    edtValorPago.Text := '0';

  if TryStrToFloat(edtValorPago.Text, iAux) then
    edtValorPago.Text := DisplayFormatter(StrToFloat(edtValorPago.Text), ('#0.00'));

end;

procedure TfrmMain.edtValorRecebidoExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtValorRecebido.Text = EmptyStr) then
    edtValorRecebido.Text := '0';

  if TryStrToFloat(edtValorRecebido.Text, iAux) then
    edtValorRecebido.Text := DisplayFormatter(StrToFloat(edtValorRecebido.Text), ('#0.00'));

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FreeAndNil(clsUsuario);
  FreeAndNil(clsDespesaManut);
  FreeAndNil(clsReceitaManut);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  nDia, nMes, nAno  : Word;
  clsDespesaManut   : TDespesa;
begin
  OperacaoDespesa := tpNoneDespesa;
  OperacaoReceita := tpNoneReceita;

  clsDespesaManut := TDespesa.Create;
  clsReceitaManut := TReceita.Create;

  clsUsuario  :=  Tusuario.Create;
  clsUsuario  :=  Funcoes.getObjUsuario(idUsuario);

  DecodeDate(date, nAno, nMes, nDia);

  cMesAtual     := StrZero(nMes, 2);
  cAnoAtual     := StrZero(nAno, 4);
  cMesAnoAtual  := cMesAtual + '/' + cAnoAtual;

  cQtdeDiasUteis := Funcoes.QtdeDiasUteis(cMesAtual, cAnoAtual);

  lblDiasUteisNoMes.Caption := cQtdeDiasUteis;

  if DM.qryCategoriasReceita.Active = false then
    DM.qryCategoriasReceita.Active := true;

  if DM.qryCategoriasDespesa.Active = false then
    DM.qryCategoriasDespesa.Active := true;

  if qrylkpCategoriasDespesa.Active = false then
    qrylkpCategoriasDespesa.Active := true;

  if qrylkpCategoriasReceita.Active = false then
    qrylkpCategoriasReceita.Active := true;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  nDia, nMes, nAno : word;
  cMes, cAno : String;
  clsDespesaController : TDespesaController;
  clsReceitaController : TReceitaController;

begin
  DecodeDate(now, nAno, nMes, nDia);
  cMes  :=  StrZero(nMes, 2);
  cAno  :=  StrZero(nAno, 4);

  CarregaComboMesAno;

  try
    clsDespesaController := TDespesaController.Create;
    clsDespesaController.findAll();

    clsReceitaController := TReceitaController.Create;
    clsReceitaController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsDespesaController);
  FreeAndNil(clsReceitaController);

  FiltrarReceitasEDespesas(cMes, cAno);
end;

procedure TfrmMain.grdDespesasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  dDataVencimento : TDate;

begin
  dDataVencimento := date();

  if( DM.qryDespesas.State <> dsInactive) then
  begin
    if (DM.qryDespesas.FieldByName('valorPago').Value = DM.qryDespesas.FieldByName('valorAPagar').Value) then
    begin
      grdDespesas.Canvas.Brush.Color  := clGreen;
      grdDespesas.Canvas.Font.Color   := clWhite;
      grdDespesas.Canvas.Font.Style   := [fsBold];
    end
    else if (DM.qryDespesas.FieldByName('dataVencimento').Value = dDataVencimento) and
            (DM.qryDespesas.FieldByName('valorPago').Value <> DM.qryDespesas.FieldByName('valorAPagar').Value) then
    begin
      grdDespesas.Canvas.Brush.Color := clOlive;
      grdDespesas.Canvas.Font.Style := [fsBold];
    end
    else if (DM.qryDespesas.FieldByName('dataVencimento').Value < dDataVencimento) and
            (DM.qryDespesas.FieldByName('valorPago').Value <> DM.qryDespesas.FieldByName('valorAPagar').Value) then
    begin
      grdDespesas.Canvas.Brush.Color := clRed;
      grdDespesas.Canvas.Font.Style := [fsBold];
    end;
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
      lnTotalSelecionado := lnTotalSelecionado + DM.qryDespesas.FieldByName('valorAPagar').Value;
    end;

    MessageBox(Handle, PChar(formatfloat('0#.#0', lnTotalSelecionado)),
        'Total de Despesas Selecionadas', MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TfrmMain.grdReceitasDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (DM.qryReceitas.FieldByName('valorRecebido').Value < DM.qryReceitas.FieldByName('valorAReceber').Value) then
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
      lnTotalSelecionado := lnTotalSelecionado + DM.qryReceitas.FieldByName('valorAReceber').Value;
    end;

    MessageBox(Handle, PChar(formatfloat('0#.#0', lnTotalSelecionado)),
        'Total de Receitas Selecionadas', MB_OK + MB_ICONINFORMATION);
  end;

end;

procedure TfrmMain.ListadeDesejos1Click(Sender: TObject);
begin
  frmListaDesejos := TfrmListaDesejos.Create(self);
  frmListaDesejos.clsUsuario   := clsUsuario;

  frmListaDesejos.ShowModal;
  freeAndNil(frmListaDesejos);
end;

procedure TfrmMain.ParaExcellPlanilhadoAno1Click(Sender: TObject);
begin
  frmExpoPlanExelAnual := TfrmExpoPlanExelAnual.Create(self);
  frmExpoPlanExelAnual.ShowModal;
  FreeAndNil(frmExpoPlanExelAnual);
end;

procedure TfrmMain.Receitas1Click(Sender: TObject);
begin
  frmCategoriasReceita := TfrmCategoriasReceita.Create(self);
  frmCategoriasReceita.clsUsuario   := clsUsuario;

  frmCategoriasReceita.ShowModal;
  freeAndNil(frmCategoriasReceita);

  qrylkpCategoriasReceita.Refresh;
end;

procedure TfrmMain.rgMostrarDespesasClick(Sender: TObject);
begin
  FiltrarReceitasEDespesas('','');
end;

procedure TfrmMain.Calculadora1Click(Sender: TObject);
begin
  ShellExecute(0, nil, PChar('CALC.EXE'), nil, nil, SW_ShowNORMAL);
end;

procedure TfrmMain.Calendrio1Click(Sender: TObject);
begin
  frmCalendario := TfrmCalendario.Create(self);
  frmCalendario.ShowModal;
  FreeAndNil(frmCalendario);
end;

procedure TfrmMain.CarregaComboMesAno;
var
  listaCombo : TStringList;
  clsMainController : TMainController;
  i : Integer;
begin
  try
    clsMainController  := TMainController.Create;

    listaCombo := clsMainController.CarregaComboMesAno();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsMainController);

  cboMesAno.Items.Clear();
  if listaCombo.Count > 0 then
  begin
    for i := 0 to Pred(listaCombo.Count) do
    begin
      cboMesAno.Items.add(listaCombo.Strings[i]);
    end;

    cboMesAno.ItemIndex := cboMesAno.Items.IndexOf(cMesAnoAtual);
  end;

  listaCombo.Free;

  FiltrarReceitasEDespesas('', '');

  lblTotalDespesas.Caption := 'Total de Registros: ' + StrZero(DM.qryDespesas.RecordCount, 4);
  lblTotalReceitas.Caption := 'Total de Registros: ' + StrZero(DM.qryReceitas.RecordCount, 4);
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

  cQtdeDiasUteis := Funcoes.QtdeDiasUteis(cMes, cAno);

  lblDiasUteisNoMes.Caption := cQtdeDiasUteis;

  FiltrarReceitasEDespesas(cMes, cAno);

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
  clsDespesaController : TDespesaController;
  clsDespesa           : TDespesa;
begin
  try
    clsDespesa           := TDespesa.Create;
    clsDespesaController := TDespesaController.Create;

    clsDespesa := clsDespesaController.setTotaisDespesas(cMes, cAno);
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  lblDepesaAPagar.Caption := 'R$ ' + FormatFloat( '#,##0.00' , clsDespesa.totalValorAPAgar);
  lblDepesaPaga.Caption   := 'R$ ' + FormatFloat( '#,##0.00' , clsDespesa.totalValorPago);
  lblFaltaPagar.Caption   := 'R$ ' + FormatFloat( '#,##0.00' , clsDespesa.totalValorFaltaPagar);

  FreeAndNil(clsDespesaController);
  FreeAndNil(clsDespesa);
end;

procedure TfrmMain.setTotaisReceitas(cMes, cAno : String);
var
  clsReceitaController : TReceitaController;
  clsReceita           : TReceita;
begin
  try
    clsReceita           := TReceita.Create;
    clsReceitaController := TReceitaController.Create;

    clsReceita := clsReceitaController.setTotaisReceitas(cMes, cAno);
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  lblReceitaAReceber.Caption := 'R$ ' + FormatFloat( '#,##0.00', clsReceita.totalReceitaAReceber);
  lblReceitaRecebida.Caption := 'R$ ' + FormatFloat( '#,##0.00', clsReceita.totalReceitaRecebida);
  lblFaltaReceber.Caption    := 'R$ ' + FormatFloat( '#,##0.00', clsReceita.totalFaltaReceber);
end;

procedure TfrmMain.CarregaReceitas(cMes, cAno : String);
var
  clsReceita           : TReceita;
  clsReceitaController : TReceitaController;
  nTotalRegistros      : integer;
begin
  nTotalRegistros := 0;

  try
    clsReceita            := TReceita.Create;
    clsReceitaController  := TReceitaController.Create;

    clsReceita.idUsuario  := clsUsuario.id;

    nTotalRegistros := clsReceitaController.findByMesAno(clsReceita, cMes, cAno, rgMostrarDespesas.ItemIndex);
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsReceita);
  FreeAndNil(clsReceitaController);

  lblTotalReceitas.Caption := 'Total de Registros: ' + StrZero(nTotalRegistros, 4);
end;

procedure TfrmMain.CarregaDespesas(cMes, cAno : String);
var
   clsDespesa          : TDespesa;
  clsDespesaController : TDespesaController;
  nTotalRegistros      : integer;
begin
  nTotalRegistros := 0;

  try
    clsDespesa            := TDespesa.Create;
    clsDespesaController  := TDespesaController.Create;

    clsDespesa.idUsuario  := clsUsuario.id;

    nTotalRegistros := clsDespesaController.findByMesAno(clsDespesa, cMes, cAno, rgMostrarDespesas.ItemIndex);
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsDespesa);
  FreeAndNil(clsDespesaController);

  lblTotalDespesas.Caption := 'Total de Registros: ' + StrZero(nTotalRegistros, 4);
end;

Procedure TfrmMain.FiltrarReceitasEDespesas(cMesAtual, cAnoAtual:String);
var
  mesAno, cDia, cMes, cAno : String;
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

function TfrmMain.DisplayFormatter(AValue: double; ADisplayFormato: String): String;
begin
  Result := FormatFloat(ADisplayFormato, AValue);
end;

procedure TfrmMain.limparCamposDespesa();
begin
  edtDTVencimento.Text        := '';
  edtDTPagamento.Text         := '';
  edtDespesa.Text             := '';
  edtValorAPagar.Text         := '';
  edtValorPago.Text           := '';
  edtArquivoAnexo.Text        := '';
  edtObservacoesDespesas.Text := '';
  chkDespesaFixa.Checked      := false;

end;

procedure TfrmMain.limparCamposReceita();
begin
  edtDTAReceber.Text          :=  '';
  edtDTRecebimento.Text       :=  '';
  edtReceita.Text             :=  '';
  edtValorAReceber.Text       :=  '';
  edtValorRecebido.Text       :=  '';
  edtObservacoesReceitas.Text :=  '';
end;

end.

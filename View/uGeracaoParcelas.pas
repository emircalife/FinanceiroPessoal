unit uGeracaoParcelas;

interface

uses
  Usuario, Despesa, DespesaController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, math, clipbrd, System.DateUtils;

type
  TOperacao = (tpNone, tpAlterar, tpIncluir);

  TfrmGeracaoParcelas = class(TForm)
    grdParcelasDespesas: TDBGrid;
    pnlBotoes: TPanel;
    btnAlterarParcela: TBitBtn;
    btnDesfazerParcelas: TBitBtn;
    btnGerarParcelas: TBitBtn;
    btnSalvarParcelasGeradas: TBitBtn;
    btnSair: TBitBtn;
    dsParcelasDespesas: TDataSource;
    qrylkpCategoriasDespesa: TFDQuery;
    dslkpCategoriasDespesa: TDataSource;
    cdsDespesas: TClientDataSet;
    cdsDespesasdataVencimento: TDateField;
    cdsDespesascategoria: TIntegerField;
    cdsDespesasdescricao: TStringField;
    cdsDespesascategoriaDespesa: TStringField;
    cdsDespesasvalorAPagar: TFloatField;
    btnExcluirParcela: TBitBtn;
    lblVencimento: TLabel;
    lblDespesa: TLabel;
    lblCategoriaDespesa: TLabel;
    lblValorTotalAPagar: TLabel;
    lblQtdeParcelas: TLabel;
    lkpCategoriaDespesa: TDBLookupComboBox;
    edtQtdeParcelas: TEdit;
    edtValorAPagar: TEdit;
    edtDespesa: TEdit;
    cboTipoParcelamento: TComboBox;
    lblTipoParcelamento: TLabel;
    rgFormaParcelas: TRadioGroup;
    lblObservacoesDespesas: TLabel;
    memObservacoes: TMemo;
    cdsDespesasobservacoes: TStringField;
    chkDespesaFixa: TCheckBox;
    cdsDespesasdespesaFixa: TBooleanField;
    cdsDespesasnParc: TIntegerField;
    cdsDespesastotParc: TIntegerField;
    edtDTVencimento: TMaskEdit;
    qrylkpCategoriasDespesaid: TFDAutoIncField;
    qrylkpCategoriasDespesadescricao: TStringField;
    procedure btnSairClick(Sender: TObject);
    procedure btnGerarParcelasClick(Sender: TObject);
    procedure edtValorAPagarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovaParcelaClick(Sender: TObject);
    procedure btnAlterarParcelaClick(Sender: TObject);
    procedure btnDesfazerParcelasClick(Sender: TObject);
    procedure btnExcluirParcelaClick(Sender: TObject);
    procedure btnSalvarParcelasGeradasClick(Sender: TObject);
    procedure rgFormaParcelasClick(Sender: TObject);
    procedure edtQtdeParcelasExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOperacao: TOperacao;
    clsDespesa           : TDespesa;
    clsDespesaController : TDespesaController;
    procedure SetOperacao(const Value: TOperacao);
    function ValidaParcelas:Boolean;
    function DisplayFormatter(AValue: double; ADisplayFormato: String): String;
    procedure GerarValorTotalParcelas();
    procedure GerarValorPorParcela();
    function ValidaCampos():boolean;
    procedure incluir();
    procedure alterar();

  public
    { Public declarations }
    clsUsuario   : TUsuario;
    property Operacao : TOperacao read FOperacao write SetOperacao;
  end;

var
  frmGeracaoParcelas: TfrmGeracaoParcelas;

implementation

{$R *.dfm}

uses uDM, Funcoes;

procedure TfrmGeracaoParcelas.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;
end;

procedure TfrmGeracaoParcelas.btnAlterarParcelaClick(Sender: TObject);
begin
  Operacao := tpAlterar;

  if (clsDespesa <> nil) and (DM.qryDespesas.RecordCount > 0) then
  begin
    clsDespesa.id               := DM.qryDespesas.FieldByName('id').AsInteger;
    clsDespesa.descricao        := DM.qryDespesas.FieldByName('descricao').AsString;
    clsDespesa.dataVencimento   := DM.qryDespesas.FieldByName('dataVencimento').AsDateTime;
    clsDespesa.valorAPagar      := DM.qryDespesas.FieldByName('valorAPagar').AsFloat;
    clsDespesa.valorPago        := DM.qryDespesas.FieldByName('valorPago').AsFloat;
    clsDespesa.valorDiferenca   := DM.qryDespesas.FieldByName('valorDiferenca').AsFloat;
    clsDespesa.idCategoria      := DM.qryDespesas.FieldByName('idCategoria').AsInteger;
    clsDespesa.categoriaDespesa := DM.qryDespesas.FieldByName('categoriaDespesa').AsString;
    clsDespesa.dataPagamento    := DM.qryDespesas.FieldByName('dataPagamento').AsDateTime;
    clsDespesa.observacoes      := DM.qryDespesas.FieldByName('observacoes').AsString;
    clsDespesa.despesaFixa      := IIF(DM.qryDespesas.FieldByName('despesaFixa').AsInteger = 0, FALSE, TRUE);
    clsDespesa.nParc            := DM.qryDespesas.FieldByName('nParc').AsInteger;
    clsDespesa.totParc          := DM.qryDespesas.FieldByName('totParc').AsInteger;
    clsDespesa.arquivoAnexo     := DM.qryDespesas.FieldByName('arquivoAnexo').AsString;
    clsDespesa.idUsuario        := DM.qryDespesas.FieldByName('idUsuario').AsInteger;
  end;

  edtDTVencimento.setFocus;
end;

procedure TfrmGeracaoParcelas.btnDesfazerParcelasClick(Sender: TObject);
begin
  Operacao := tpNone;
  Funcoes.LimpaCampos(frmGeracaoParcelas);

  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

procedure TfrmGeracaoParcelas.btnExcluirParcelaClick(Sender: TObject);
begin
  Operacao := tpNone;

  if cdsDespesas.RecordCount > 0 then
  begin
    if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes],
                                                          0, mrNo) = mrYes then
    begin
      cdsDespesas.Delete;
    end;
  end;

  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

procedure TfrmGeracaoParcelas.btnGerarParcelasClick(Sender: TObject);
begin
  Operacao := tpIncluir;

  if ValidaCampos() then
  begin
    if rgFormaParcelas.ItemIndex = 0 then
      GerarValorPorParcela()
    else if rgFormaParcelas.ItemIndex = 1 then
      GerarValorTotalParcelas();

    btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
  end;
end;

procedure TfrmGeracaoParcelas.btnNovaParcelaClick(Sender: TObject);
begin
//  cdsDespesas.EmptyDataSet;

  if cdsDespesas.State in [dsInactive, dsBrowse] then
  begin
    cdsDespesas.Append;
    edtDTVencimento.setFocus;
  end;
end;

procedure TfrmGeracaoParcelas.btnSairClick(Sender: TObject);
begin
  if cdsDespesas.RecordCount > 0 then
  begin
    if Funcoes.MessageDlgDefault('As parcelas geradas não foram salvas no banco, sair mesmo assim?',
        mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      cdsDespesas.EmptyDataSet;
      Close;
    end else
      btnSalvarParcelasGeradas.SetFocus;
  end else
    Close;
end;

procedure TfrmGeracaoParcelas.btnSalvarParcelasGeradasClick(Sender: TObject);
var
  clsDespesa : TDespesa;
  clsDespesaController : TDespesaController;
begin
  try
    clsDespesa           :=  TDespesa.Create;
    clsDespesaController := TDespesaController.Create;

    if (cdsDespesas.RecordCount > 0) then
    begin
      if Funcoes.MessageDlgDefault('Confirma a gravação das parcelas no banco de dados?',
            mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      begin
        cdsDespesas.DisableControls;
        cdsDespesas.First;

        while not cdsDespesas.EoF do
        begin

          clsDespesa.descricao      := cdsDespesasdescricao.Value;
          clsDespesa.dataVencimento := cdsDespesasdataVencimento.Value;
          clsDespesa.valorAPagar    := cdsDespesasvalorAPagar.Value;
          clsDespesa.idCategoria    := cdsDespesascategoria.Value;
          clsDespesa.observacoes    := trim(cdsDespesasobservacoes.Value);
          clsDespesa.despesaFixa    := Funcoes.IIf(cdsDespesasDespesaFixa.Value = false, 0, 1);
          clsDespesa.nParc          := cdsDespesasnParc.Value;
          clsDespesa.totParc        := cdsDespesastotParc.Value;
          clsDespesa.idUsuario      := clsUsuario.id;


          if Operacao = tpIncluir then
          begin
            clsDespesa.id := clsUsuario.id;
            clsDespesaController.incluir(clsDespesa);
          end
          else if (cdsDespesas.RecordCount > 0) and (Operacao = tpAlterar) then
          clsDespesaController.alterar(clsDespesa);

          cdsDespesas.Next;
        end;
      end;
      cdsDespesas.EmptyDataSet;

      cdsDespesas.EnableControls;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsDespesa);
end;

function TfrmGeracaoParcelas.DisplayFormatter(AValue: double; ADisplayFormato: String): String;
begin
  Result := FormatFloat(ADisplayFormato, AValue);
end;

procedure TfrmGeracaoParcelas.edtQtdeParcelasExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtQtdeParcelas.Text = EmptyStr) then
    edtQtdeParcelas.Text := '0';
end;

procedure TfrmGeracaoParcelas.edtValorAPagarExit(Sender: TObject);
var
  iAux: Double;

begin
  if (edtValorAPagar.Text = EmptyStr) then
    edtValorAPagar.Text := '0';

  if TryStrToFloat(edtValorAPagar.Text, iAux) then
    edtValorAPagar.Text := DisplayFormatter(StrToFloat(edtValorAPagar.Text), ('#0.00'));
end;

procedure TfrmGeracaoParcelas.FormCreate(Sender: TObject);
begin
  cdsDespesas.CreateDataSet;

  Operacao := tpNone;
  clsUsuario  := TUsuario.Create;
end;

procedure TfrmGeracaoParcelas.FormShow(Sender: TObject);
begin
 if qrylkpCategoriasDespesa.Active = false then
    qrylkpCategoriasDespesa.Active := true;
end;

function TfrmGeracaoParcelas.ValidaParcelas:Boolean;
var
  llValido : Boolean;

begin
  llValido  := true;
  result := llValido;
end;

procedure TfrmGeracaoParcelas.GerarValorTotalParcelas();
var
  lnCont, lnQtdeParcelas, lnCodCategoriaDespesa : Integer;
  ldDtVencimento : TDate;
  lnValorTotalParcela, lnValorParcela, lnValorPrimeiraParcela: double;
  lnSomaValoresParcelas, lnDiferencaParcelas: double;
  lcDescrCategoriaDespesa : String;
  lnAcumuladosParcela     : double;
  llDespesaFixa           : Boolean;

begin
  lnCodCategoriaDespesa   := lkpCategoriaDespesa.KeyValue;
  lcDescrCategoriaDespesa := trim(lkpCategoriaDespesa.Text);
  llDespesaFixa           := Funcoes.IIf(chkDespesaFixa.Checked, TRUE, FALSE);

  cdsDespesas.EmptyDataSet;

  lnQtdeParcelas          := StrToInt(edtQtdeParcelas.Text);
  ldDtVencimento          := StrToDate(edtDTVencimento.Text);
  lnValorTotalParcela     := StrToFloat(edtValorAPagar.Text);
  lnDiferencaParcelas     := 0.00;

  lnValorParcela          := (lnValorTotalParcela / lnQtdeParcelas);
  lnSomaValoresParcelas   := (lnValorParcela * lnQtdeParcelas);
  lnAcumuladosParcela     := 0.00;

  for lnCont := 1 to lnQtdeParcelas do
  begin
    lnAcumuladosParcela :=  lnAcumuladosParcela + RoundTo(lnValorParcela, -3);
  end;

  if lnAcumuladosParcela < lnValorTotalParcela then
    lnDiferencaParcelas := lnValorTotalParcela - lnAcumuladosParcela
  else if lnAcumuladosParcela > lnValorTotalParcela then
    lnDiferencaParcelas := lnAcumuladosParcela - lnValorTotalParcela;

  lnValorPrimeiraParcela := lnValorParcela + lnDiferencaParcelas;

  cdsDespesas.Cancel;

  for lnCont := 1 to lnQtdeParcelas do
  begin
    cdsDespesas.Append;
    cdsDespesas.FieldByName('dataVencimento').AsDateTime := ldDtVencimento;
    cdsDespesas.FieldByName('categoria').AsInteger       := lnCodCategoriaDespesa;
    cdsDespesas.FieldByName('categoriaDespesa').AsString := lcDescrCategoriaDespesa;
    cdsDespesas.FieldByName('descricao').AsString        := trim(edtDespesa.Text);
    cdsDespesas.FieldByName('observacoes').AsString      := trim(memObservacoes.Text);
    cdsDespesas.FieldByName('despesaFixa').AsBoolean     := llDespesaFixa;
    cdsDespesas.FieldByName('nParc').AsInteger           := lnCont;
    cdsDespesas.FieldByName('totParc').AsInteger         := StrToInt(edtQtdeParcelas.Text);

    if lnValorPrimeiraParcela <> lnValorParcela then
    begin
      cdsDespesas.FieldByName('valorAPagar').AsFloat := RoundTo(lnValorPrimeiraParcela, -3);
      lnValorPrimeiraParcela := lnValorParcela;
    end else
    begin
      cdsDespesas.FieldByName('valorAPagar').AsFloat := RoundTo(lnValorParcela, -3);
     end;
    cdsDespesas.Post;

    ldDtVencimento := IncMonth(ldDtVencimento, 1);
  end;

end;

procedure TfrmGeracaoParcelas.rgFormaParcelasClick(Sender: TObject);
begin
  case rgFormaParcelas.ItemIndex of
    //Valor de cada Parcela
    0:
    begin
      cboTipoParcelamento.Enabled   := true;
      cboTipoParcelamento.ItemIndex :=  0;
    end;
    //Valor Total das Parcelas
    1:
    begin
      cboTipoParcelamento.ItemIndex :=  1;
      cboTipoParcelamento.Enabled   := false;
    end;
  end;
end;

procedure TfrmGeracaoParcelas.GerarValorPorParcela();
var
  lnCont, lnQtdeParcelas, lnCodCategoriaDespesa : Integer;
  ldDtVencimento : TDate;
  lnValorTotalParcela, lnValorParcela, lnValorPrimeiraParcela: double;
  lnSomaValoresParcelas, lnDiferencaParcelas: double;
  lcDescrCategoriaDespesa : String;
  lnAcumuladosParcela     : double;
  llDespesaFixa           : Boolean;

begin
  lnCodCategoriaDespesa   := lkpCategoriaDespesa.KeyValue;
  lcDescrCategoriaDespesa := trim(lkpCategoriaDespesa.Text);

  cdsDespesas.EmptyDataSet;

  lnQtdeParcelas          := StrToInt(edtQtdeParcelas.Text);
  ldDtVencimento          := StrToDate(edtDTVencimento.Text);
  lnValorParcela          := StrToFloat(edtValorAPagar.Text);
  llDespesaFixa           := Funcoes.IIf(chkDespesaFixa.Checked, TRUE, FALSE);

  cdsDespesas.Cancel;

  for lnCont := 1 to lnQtdeParcelas do
  begin
    cdsDespesas.Append;
    cdsDespesas.FieldByName('dataVencimento').AsDateTime := ldDtVencimento;
    cdsDespesas.FieldByName('categoria').AsInteger       := lnCodCategoriaDespesa;
    cdsDespesas.FieldByName('categoriaDespesa').AsString := lcDescrCategoriaDespesa;
    cdsDespesas.FieldByName('descricao').AsString        := trim(edtDespesa.Text);
    cdsDespesas.FieldByName('valorAPagar').AsFloat       := RoundTo(lnValorParcela, -3);
    cdsDespesas.FieldByName('observacoes').AsString      := trim(memObservacoes.Text);
    cdsDespesas.FieldByName('despesaFixa').AsBoolean     := llDespesaFixa;
    cdsDespesas.FieldByName('nParc').AsInteger           := lnCont;
    cdsDespesas.FieldByName('totParc').AsInteger         := StrToInt(edtQtdeParcelas.Text);

    cdsDespesas.Post;

    case cboTipoParcelamento.ItemIndex of
      //Ano
      0: ldDtVencimento := Funcoes.IncYear(ldDtVencimento, 1);
      //Mês
      1: ldDtVencimento := IncMonth(ldDtVencimento, 1);
      //Semana
      2: ldDtVencimento := IncDay(ldDtVencimento, 7);
    end;
  end;

end;

function TfrmGeracaoParcelas.ValidaCampos():boolean;
var
  lRetorno : Boolean;
begin
  lRetorno := true;

  if trim(edtDTVencimento.Text) = '/  /' then
  begin
    lRetorno := false;
    ShowMessage('Campo data não pode ser vazio');
  end;

  if (lRetorno = true) and (cdsDespesascategoria.Value < 1) then
  begin
    lRetorno := false;
    ShowMessage('Campo categoria não pode ser vazio');
  end;

  if (lRetorno = true) and (trim(edtDespesa.Text) = '') then
  begin
    lRetorno := false;
    ShowMessage('Campo despesa não pode ser vazio');
  end;

  if (lRetorno = true) and
    ((trim(edtValorAPagar.Text) = '0,00') OR (trim(edtValorAPagar.Text) = '')) then
  begin
    lRetorno := false;
    ShowMessage('Campo valor a pagar não pode ser vazio');
  end;


  if (lRetorno = true) and
    ((trim(edtQtdeParcelas.Text) = '0') OR (trim(edtQtdeParcelas.Text) = ''))  then
  begin
    lRetorno := false;
    ShowMessage('Campo quantidade de parcelas não pode ser vazio');
  end;

  Result := lRetorno;
end;

procedure TfrmGeracaoParcelas.incluir();
const
  cSQL : String = 'INSERT INTO lancamentosdespesa ('+
                  'descricao, datavencimento,      '+
                  'valorapagar, idCategoria,       '+
                  'idUsuario, observacoes,         '+
                  'despesaFixa, nParc,             '+
                  'totParc                         '+
                  ')VALUES(                        '+
                  ':Pdescricao, :Pdatavencimento,  '+
                  ':Pvalorapagar, :PidCategoria,   '+
                  ':PidUsuario, :Pobservacoes,     '+
                  ':PdespesaFixa, :PnParc,         '+
                  ':PtotParc)                      ';
begin
  if (cdsDespesas.RecordCount > 0) then
  begin
    if Funcoes.MessageDlgDefault('Confirma a gravação das parcelas no banco de dados?',
          mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      cdsDespesas.DisableControls;
      cdsDespesas.First;

      while not cdsDespesas.EoF do
      begin
        DM.qryDespesas.Close;
        DM.qryDespesas.SQL.Clear;
        DM.qryDespesas.SQL.Add(cSQL);

        DM.qryDespesas.ParamByName('Pdescricao').AsString         := cdsDespesasdescricao.Value;
        DM.qryDespesas.ParamByName('Pdatavencimento').AsDateTime  := cdsDespesasdataVencimento.Value;
        DM.qryDespesas.ParamByName('Pvalorapagar').AsCurrency     := cdsDespesasvalorAPagar.Value;
        DM.qryDespesas.ParamByName('PidCategoria').AsInteger      := cdsDespesascategoria.Value;
        DM.qryDespesas.ParamByName('Pobservacoes').AsString       := trim(cdsDespesasobservacoes.Value);
        DM.qryDespesas.ParamByName('PdespesaFixa').AsBoolean      := Funcoes.IIf(cdsDespesasDespesaFixa.Value = false, 0, 1);
        DM.qryDespesas.ParamByName('PnParc').AsInteger            := cdsDespesasnParc.Value;
        DM.qryDespesas.ParamByName('PtotParc').AsInteger          := cdsDespesastotParc.Value;
        DM.qryDespesas.ParamByName('PidUsuario').AsInteger        := clsUsuario.id;

        DM.qryDespesas.ExecSQL;

        cdsDespesas.Next;
      end;
    end;
    cdsDespesas.EmptyDataSet;

    cdsDespesas.EnableControls;
  end;

  cdsDespesas.EmptyDataSet;
  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

procedure TfrmGeracaoParcelas.alterar();
begin

end;

end.

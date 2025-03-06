unit uGeracaoParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, math, clipbrd;

type
  TfrmGeracaoParcelas = class(TForm)
    grdParcelasDespesas: TDBGrid;
    pnlBotoes: TPanel;
    btnAlterarParcela: TBitBtn;
    btnDesfazerParcelas: TBitBtn;
    btnGerarParcelas: TBitBtn;
    btnSalvarParcelasGeradas: TBitBtn;
    btnSair: TBitBtn;
    dsParcelasDespesas: TDataSource;
    lblVencimento: TLabel;
    lblDespesa: TLabel;
    lblCategoriaDespesa: TLabel;
    lkpCategoriaDespesa: TDBLookupComboBox;
    qrylkpCategoriasDespesa: TFDQuery;
    qrylkpCategoriasDespesaID: TIntegerField;
    qrylkpCategoriasDespesaDESCRICAO: TStringField;
    dslkpCategoriasDespesa: TDataSource;
    lblValorTotalAPagar: TLabel;
    lblQtdeParcelas: TLabel;
    edtQtdeParcelas: TEdit;
    cdsDespesas: TClientDataSet;
    cdsDespesasdataVencimento: TDateField;
    cdsDespesascategoria: TIntegerField;
    cdsDespesasdescricao: TStringField;
    cdsDespesascategoriaDespesa: TStringField;
    edtDTVencimento: TMaskEdit;
    edtValorAPagar: TEdit;
    edtDespesa: TEdit;
    cdsDespesasvalorAPagar: TFloatField;
    btnExcluirParcela: TBitBtn;
    rgFormaParcelas: TRadioGroup;
    procedure btnSairClick(Sender: TObject);
    procedure btnGerarParcelasClick(Sender: TObject);
    procedure edtValorAPagarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovaParcelaClick(Sender: TObject);
    procedure btnAlterarParcelaClick(Sender: TObject);
    procedure btnDesfazerParcelasClick(Sender: TObject);
    procedure btnExcluirParcelaClick(Sender: TObject);
    procedure btnSalvarParcelasGeradasClick(Sender: TObject);
  private
    { Private declarations }
    function ValidaParcelas:Boolean;
    function DisplayFormatter(AValue: double; ADisplayFormato: String): String;
    procedure GerarValorTotalParcelas();
    procedure GerarValorPorParcela();
  public
    { Public declarations }
    nIdUsuario   : Integer;
    cNomeUsuario : String;
  end;

var
  frmGeracaoParcelas: TfrmGeracaoParcelas;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmGeracaoParcelas.btnAlterarParcelaClick(Sender: TObject);
begin
  if cdsDespesas.State = dsBrowse then
  begin
    cdsDespesas.Edit;
    edtDTVencimento.setFocus;
  end;
end;

procedure TfrmGeracaoParcelas.btnDesfazerParcelasClick(Sender: TObject);
begin
  if cdsDespesas.State <> dsBrowse then
    cdsDespesas.Cancel;

  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

procedure TfrmGeracaoParcelas.btnExcluirParcelaClick(Sender: TObject);
begin
  if cdsDespesas.RecordCount > 0 then
  begin
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes],
                                                          0, mrNo) = mrYes then
    begin
      cdsDespesas.Delete;
    end;
  end;

  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

procedure TfrmGeracaoParcelas.btnGerarParcelasClick(Sender: TObject);
begin
  if rgFormaParcelas.ItemIndex = 0 then
    GerarValorPorParcela()
  else if rgFormaParcelas.ItemIndex = 1 then
    GerarValorTotalParcelas();

  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
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
    if uFuncoes.MessageDlgDefault('As parcelas geradas não foram salvas no banco, sair mesmo assim?',
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
begin
  if cdsDespesas.RecordCount > 0 then
  begin
    if uFuncoes.MessageDlgDefault('Confirma a persistência das parcelas no banco de dados?',
        mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      cdsDespesas.DisableControls;
      cdsDespesas.First;

      while not cdsDespesas.EoF do
      begin
        DM.qryDespesas.Append;
//        DM.qryDespesasID.Value                  := DM.getNextId('LANCAMENTOSDESPESA');
        DM.qryDespesasIDUSUARIO.AsInteger       := nIdUsuario;
        DM.qryDespesasDATAVENCIMENTO.Value      := cdsDespesasdataVencimento.Value;
        DM.qryDespesasIDCATEGORIA.Value         := cdsDespesascategoria.Value;
        DM.qryDespesasVALORAPAGAR.Value         := cdsDespesasvalorAPagar.Value;
        DM.qryDespesasDESCRICAO.Value           := trim(cdsDespesasdescricao.Value);

        DM.qryDespesas.Post;

        cdsDespesas.Next;
      end;
    end;
    cdsDespesas.EmptyDataSet;

    cdsDespesas.EnableConstraints;
  end;

  cdsDespesas.EmptyDataSet;
  btnSalvarParcelasGeradas.Enabled := cdsDespesas.RecordCount > 0;
end;

function TfrmGeracaoParcelas.DisplayFormatter(AValue: double; ADisplayFormato: String): String;
begin
  Result := FormatFloat(ADisplayFormato, AValue);
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
  if qrylkpCategoriasDespesa.Active = false then
    qrylkpCategoriasDespesa.Active := true;

  cdsDespesas.CreateDataSet;
end;

function TfrmGeracaoParcelas.ValidaParcelas:Boolean;
var
  llValido : Boolean;

begin
  llValido  := true;


end;

procedure TfrmGeracaoParcelas.GerarValorTotalParcelas();
var
  lnCont, lnQtdeParcelas, lnCodCategoriaDespesa : Integer;
  ldDtVencimento : TDate;
  lnValorTotalParcela, lnValorParcela, lnValorPrimeiraParcela: double;
  lnSomaValoresParcelas, lnDiferencaParcelas: double;
  lcDescrCategoriaDespesa : String;
  lnAcumuladosParcela     : double;

begin
  lnCodCategoriaDespesa   := lkpCategoriaDespesa.KeyValue;
  lcDescrCategoriaDespesa := trim(lkpCategoriaDespesa.Text);

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

procedure TfrmGeracaoParcelas.GerarValorPorParcela();
var
  lnCont, lnQtdeParcelas, lnCodCategoriaDespesa : Integer;
  ldDtVencimento : TDate;
  lnValorTotalParcela, lnValorParcela, lnValorPrimeiraParcela: double;
  lnSomaValoresParcelas, lnDiferencaParcelas: double;
  lcDescrCategoriaDespesa : String;
  lnAcumuladosParcela     : double;

begin
  lnCodCategoriaDespesa   := lkpCategoriaDespesa.KeyValue;
  lcDescrCategoriaDespesa := trim(lkpCategoriaDespesa.Text);

  cdsDespesas.EmptyDataSet;

  lnQtdeParcelas          := StrToInt(edtQtdeParcelas.Text);
  ldDtVencimento          := StrToDate(edtDTVencimento.Text);
  lnValorParcela          := StrToFloat(edtValorAPagar.Text);

  cdsDespesas.Cancel;

  for lnCont := 1 to lnQtdeParcelas do
  begin
    cdsDespesas.Append;
    cdsDespesas.FieldByName('dataVencimento').AsDateTime := ldDtVencimento;
    cdsDespesas.FieldByName('categoria').AsInteger       := lnCodCategoriaDespesa;
    cdsDespesas.FieldByName('categoriaDespesa').AsString := lcDescrCategoriaDespesa;
    cdsDespesas.FieldByName('descricao').AsString        := trim(edtDespesa.Text);
    cdsDespesas.FieldByName('valorAPagar').AsFloat       := RoundTo(lnValorParcela, -3);

    cdsDespesas.Post;

    ldDtVencimento := IncMonth(ldDtVencimento, 1);
  end;

end;

end.

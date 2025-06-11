unit uCategoriasDespesa;

interface

uses
  Usuario, CategoriasDespesa, CategoriasDespesaController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons;

type
  TOperacao = (tpNone, tpAlterar, tpIncluir);

  TfrmCategoriasDespesa = class(TForm)
    grdCategoriasDespesa: TDBGrid;
    dsCategoriaDespesa: TDataSource;
    lblCategoriaDespesa: TLabel;
    pnlBotoes: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnDesfazer: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    edtCategoriaDespesa: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsCategoriaDespesaDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    clsCategoriasDespesa : TCategoriasDespesa;
    clsCategoriasDespesaController : TCategoriasDespesaController;

    FOperacao: TOperacao;
    procedure SetOperacao(const Value: TOperacao);

  public
    { Public declarations }
    clsUsuario   : TUsuario;
    property Operacao : TOperacao read FOperacao write SetOperacao;
  end;

var
  frmCategoriasDespesa: TfrmCategoriasDespesa;

implementation

{$R *.dfm}

uses uDM, Funcoes;

procedure TfrmCategoriasDespesa.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;

  btnNovo.Enabled      := FOperacao = tpNone;
  btnSalvar.Enabled    := (FOperacao in [tpAlterar, tpIncluir]);
  btnExcluir.Enabled   := FOperacao = tpNone;
  btnDesfazer.Enabled  := not (FOperacao = tpNone);
end;

procedure TfrmCategoriasDespesa.btnAlterarClick(Sender: TObject);
var
  clsCategoriasDespesaMan        : TCategoriasDespesa;
  clsCategoriasDespesaController : TCategoriasDespesaController;
begin
  SetOperacao(tpAlterar);


  try
    clsCategoriasDespesaMan         := TCategoriasDespesa.Create;
    clsCategoriasDespesaController  := TCategoriasDespesaController.Create;

    clsCategoriasDespesaMan.id  := DM.qryCategoriasDespesa.FieldByName('id').AsInteger;

    clsCategoriasDespesaMan     := clsCategoriasDespesaController.findById(clsCategoriasDespesaMan);

    if clsCategoriasDespesaMan <> nil then
    begin
      edtCategoriaDespesa.Text :=  clsCategoriasDespesaMan.descricao;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasDespesaMan);
  FreeAndNil(clsCategoriasDespesaController);
end;

procedure TfrmCategoriasDespesa.btnDesfazerClick(Sender: TObject);
begin
  SetOperacao(tpNone);

  edtCategoriaDespesa.Text := EmptyStr;
end;

procedure TfrmCategoriasDespesa.btnExcluirClick(Sender: TObject);
var
  clsCategoriasDespesa : TCategoriasDespesa;
  clsCategoriasDespesaController : TCategoriasDespesaController;

begin
  SetOperacao(tpNone);

  try
    clsCategoriasDespesa           :=  TCategoriasDespesa.Create;
    clsCategoriasDespesaController := TCategoriasDespesaController.Create;

    if DM.qryCategoriasDespesa.RecordCount > 0 then
    begin
      if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      begin
        clsCategoriasDespesa.id := DM.qryCategoriasDespesa.FieldByName('id').AsInteger;
        clsCategoriasDespesaController.excluir(clsCategoriasDespesa);

        clsCategoriasDespesaController.findAll();
      end;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasDespesa);
  FreeAndNil(clsCategoriasDespesaController);
end;

procedure TfrmCategoriasDespesa.btnNovoClick(Sender: TObject);
begin
  SetOperacao(tpIncluir);

  edtCategoriaDespesa.Text := EmptyStr;
  edtCategoriaDespesa.SetFocus;
end;

procedure TfrmCategoriasDespesa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategoriasDespesa.btnSalvarClick(Sender: TObject);
var
  clsCategoriasDespesa : TCategoriasDespesa;
  clsCategoriasDespesaController : TCategoriasDespesaController;

  llResult : Boolean;
begin
  try
    clsCategoriasDespesa            :=  TCategoriasDespesa.Create;
    clsCategoriasDespesaController  := TCategoriasDespesaController.Create;

    clsCategoriasDespesa.descricao := trim(edtCategoriaDespesa.Text);
    clsCategoriasDespesa.idUsuario := clsUsuario.id;

    if Operacao = tpIncluir then
      clsCategoriasDespesaController.incluir(clsCategoriasDespesa)
    else if Operacao = tpAlterar then
    begin
      clsCategoriasDespesa.id := DM.qryCategoriasDespesa.FieldByName('id').AsInteger;

      clsCategoriasDespesaController.alterar(clsCategoriasDespesa);
    end;

    clsCategoriasDespesaController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasDespesa);
  FreeAndNil(clsCategoriasDespesaController);

  edtCategoriaDespesa.Text := '';

  SetOperacao(tpNone);
end;

procedure TfrmCategoriasDespesa.dsCategoriaDespesaDataChange(Sender: TObject;
  Field: TField);
begin
  if clsCategoriasDespesa <> nil then
  begin
    clsCategoriasDespesa.id         := DM.qryCategoriasDespesa.FieldByName('id').AsInteger;
    clsCategoriasDespesa.descricao  := DM.qryCategoriasDespesa.FieldByName('descricao').AsString;
    clsCategoriasDespesa.idUsuario  := DM.qryCategoriasDespesa.FieldByName('idUsuario').AsInteger;
  end;
end;

procedure TfrmCategoriasDespesa.edtPesquisaChange(Sender: TObject);
var
  cFiltro : String;
begin
  cFiltro := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryCategoriasDespesa.Filtered := false;
  dm.qryCategoriasDespesa.Filter   := cFiltro;
  dm.qryCategoriasDespesa.Filtered := true;
end;

procedure TfrmCategoriasDespesa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FreeAndNil(clsCategoriasDespesa);
end;

procedure TfrmCategoriasDespesa.FormCreate(Sender: TObject);
begin
  Operacao := tpNone;
end;

procedure TfrmCategoriasDespesa.FormShow(Sender: TObject);
var
  clsCategoriasDespesaController : TCategoriasDespesaController;

begin
  try
    clsCategoriasDespesaController := TCategoriasDespesaController.Create;
    clsCategoriasDespesaController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasDespesaController);

end;

end.

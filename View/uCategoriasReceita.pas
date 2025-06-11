unit uCategoriasReceita;

interface

uses
  Usuario, CategoriasReceita, CategoriasReceitaController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons;

type
  TOperacao = (tpNone, tpAlterar, tpIncluir);

  TfrmCategoriasReceita = class(TForm)
    grdCategoriasReceita: TDBGrid;
    dsCategoriasReceita: TDataSource;
    lblCategoriaReceita: TLabel;
    pnlBotoes: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnDesfazer: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    edtCategoriaReceita: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsCategoriasReceitaDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    clsCategoriasReceita : TCategoriasReceita;
    clsCategoriasReceitaController : TCategoriasReceitaController;

    FOperacao: TOperacao;
    procedure SetOperacao(const Value: TOperacao);
    procedure incluir(clsCategoriaDespesa : TCategoriasReceita);
    procedure excluir(clsCategoriaDespesa : TCategoriasReceita);
    procedure alterar(clsCategoriaDespesa : TCategoriasReceita);
    procedure listarTodos();
  public
    { Public declarations }
    clsUsuario   : TUsuario;
    property Operacao : TOperacao read FOperacao write SetOperacao;
  end;

var
  frmCategoriasReceita: TfrmCategoriasReceita;

implementation

{$R *.dfm}

uses uDM, Funcoes;

procedure TfrmCategoriasReceita.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;

  btnNovo.Enabled      := FOperacao = tpNone;
  btnSalvar.Enabled    := (FOperacao in [tpAlterar, tpIncluir]);
  btnExcluir.Enabled   := FOperacao = tpNone;
  btnDesfazer.Enabled  := not (FOperacao = tpNone);
end;

procedure TfrmCategoriasReceita.btnAlterarClick(Sender: TObject);
begin
  Operacao := tpAlterar;

  edtCategoriaReceita.Text := clsCategoriasReceita.descricao;
end;

procedure TfrmCategoriasReceita.btnDesfazerClick(Sender: TObject);
begin
  Operacao := tpNone;

  edtCategoriaReceita.Text := EmptyStr;
end;

procedure TfrmCategoriasReceita.btnExcluirClick(Sender: TObject);
var
  clsCategoriasReceita : TCategoriasReceita;
  clsCategoriasReceitaController : TCategoriasReceitaController;

begin
  Operacao := tpNone;

  try
    clsCategoriasReceita           := TCategoriasReceita.Create;
    clsCategoriasReceitaController := TCategoriasReceitaController.Create;

    if DM.qryCategoriasDespesa.RecordCount > 0 then
    begin
      if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      begin
        clsCategoriasReceita.id := DM.qryCategoriasReceita.FieldByName('id').AsInteger;
        clsCategoriasReceitaController.excluir(clsCategoriasReceita);

        clsCategoriasReceitaController.findAll();
      end;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasReceita);
  FreeAndNil(clsCategoriasReceitaController);
end;

procedure TfrmCategoriasReceita.btnNovoClick(Sender: TObject);
begin
  Operacao := tpIncluir;

  edtCategoriaReceita.Text := EmptyStr;
  edtCategoriaReceita.SetFocus;
end;

procedure TfrmCategoriasReceita.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategoriasReceita.btnSalvarClick(Sender: TObject);
var
  clsCategoriasReceita : TCategoriasReceita;
  clsCategoriasReceitaController : TCategoriasReceitaController;

  llResult : Boolean;
begin
  try
    clsCategoriasReceita            :=  TCategoriasReceita.Create;
    clsCategoriasReceitaController  := TCategoriasReceitaController.Create;

    clsCategoriasReceita.descricao := trim(edtCategoriaReceita.Text);
    clsCategoriasReceita.idUsuario := clsUsuario.id;

    if Operacao = tpIncluir then
      clsCategoriasReceitaController.incluir(clsCategoriasReceita)
    else if Operacao = tpAlterar then
    begin
      clsCategoriasReceita.id := DM.qryCategoriasReceita.FieldByName('id').AsInteger;

      clsCategoriasReceitaController.alterar(clsCategoriasReceita);
    end;

    clsCategoriasReceitaController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasReceita);
  FreeAndNil(clsCategoriasReceitaController);
end;

procedure TfrmCategoriasReceita.dsCategoriasReceitaDataChange(Sender: TObject;
  Field: TField);
begin
  if clsCategoriasReceita <> nil then
  begin
    clsCategoriasReceita.id         := DM.qryCategoriasReceita.FieldByName('id').AsInteger;
    clsCategoriasReceita.descricao  := DM.qryCategoriasReceita.FieldByName('descricao').AsString;
    clsCategoriasReceita.idUsuario  := DM.qryCategoriasReceita.FieldByName('idUsuario').AsInteger;
  end;
end;

procedure TfrmCategoriasReceita.edtPesquisaChange(Sender: TObject);
var
  cFiltro : String;
begin
  cFiltro := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryCategoriasReceita.Filtered := false;
  dm.qryCategoriasReceita.Filter   := cFiltro;
  dm.qryCategoriasReceita.Filtered := true;

end;

procedure TfrmCategoriasReceita.incluir(clsCategoriaDespesa : TCategoriasReceita);
const
  cSQL : String = 'INSERT INTO categoriasReceita ('+
                  'descricao, idUsuario           '+
                  ')VALUES(                       '+
                  ':Pdescricao, :PidUsuario)      ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pdescricao').AsString := clsCategoriasReceita.descricao;
    DM.qryManutCategoriasReceita.ParamByName('PidUsuario').AsInteger:= clsCategoriasReceita.idUsuario;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    ShowMessage('Houve erro no cadastro da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure TfrmCategoriasReceita.alterar(clsCategoriaDespesa : TCategoriasReceita);
const
  cSQL : String = 'UPDATE categoriasReceita SET '+
                  'descricao=:Pdescricao        '+
                  'WHERE idUsuario =:PidUsuario '+
                  '  AND id = :Pid              ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pid').AsInteger:= clsCategoriasReceita.id;
    DM.qryManutCategoriasReceita.ParamByName('Pdescricao').AsString := clsCategoriasReceita.descricao;
    DM.qryManutCategoriasReceita.ParamByName('PidUsuario').AsInteger:= clsCategoriasReceita.idUsuario;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    ShowMessage('Houve erro na alteração da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure TfrmCategoriasReceita.listarTodos();
const
  cSQL : String = 'SELECT id, descricao, idUsuario '+
                  'FROM categoriasReceita          '+
                  'WHERE idUsuario =:PidUsuario    '+
                  'ORDER BY descricao              ';
begin
  try
    DM.qryCategoriasReceita.Close;
    DM.qryCategoriasReceita.SQL.Clear;
    DM.qryCategoriasReceita.SQL.Add(cSQL);
    DM.qryCategoriasReceita.ParamByName('PidUsuario').AsInteger:= clsUsuario.id;
    DM.qryCategoriasReceita.Open;
  except
    ShowMessage('Houve erro na listagem da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure TfrmCategoriasReceita.excluir(clsCategoriaDespesa : TCategoriasReceita);
const
  cSQL : String = 'DELETE FROM categoriasReceita '+
                  'WHERE id = :Pid               '+
                  '  AND idUsuario = :PidUsuario ';
begin
  try
    DM.qryManutCategoriasReceita.Close;
    DM.qryManutCategoriasReceita.SQL.Clear;
    DM.qryManutCategoriasReceita.SQL.Add(cSQL);
    DM.qryManutCategoriasReceita.ParamByName('Pid').AsInteger := clsCategoriasReceita.id;
    DM.qryManutCategoriasReceita.ParamByName('PidUsuario').AsInteger:= clsUsuario.id;
    DM.qryManutCategoriasReceita.ExecSQL;
  except
    ShowMessage('Houve erro na exclusão da Categoria de Receita, favor tente novamente!');
  end;
end;

procedure TfrmCategoriasReceita.FormCreate(Sender: TObject);
begin
  Operacao := tpNone;
end;

procedure TfrmCategoriasReceita.FormShow(Sender: TObject);
var
  clsCategoriasReceitaController : TCategoriasReceitaController;

begin
  try
    clsCategoriasReceitaController := TCategoriasReceitaController.Create;
    clsCategoriasReceitaController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsCategoriasReceitaController);

end;

end.

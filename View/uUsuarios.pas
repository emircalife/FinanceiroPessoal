unit uUsuarios;

interface

uses
  Usuario, UsuarioController, Nivel, NivelController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TOperacao = (tpNone, tpAlterar, tpIncluir);

  TfrmUsuarios = class(TForm)
    pnlBotoes: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnDesfazer: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    grdUsuarios: TDBGrid;
    dsUsuarios: TDataSource;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblNivelDeAcesso: TLabel;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    edtEmail: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    edtSenha: TEdit;
    cboNivelDeAcesso: TComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure dsUsuariosDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    clsUsuarioController : TUsuarioController;

    FOperacao: TOperacao;
    procedure SetOperacao(const Value: TOperacao);
    procedure carregaComboNiveisAcesso();
  public
    { Public declarations }
    clsUsuarios : TUsuario;
    property Operacao : TOperacao read FOperacao write SetOperacao;
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

uses uDM, Funcoes, Bcrypt;

procedure TfrmUsuarios.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;

  btnNovo.Enabled      := FOperacao = tpNone;
  btnSalvar.Enabled    := (FOperacao in [tpAlterar, tpIncluir]);
  btnExcluir.Enabled   := FOperacao = tpNone;
  btnDesfazer.Enabled  := not (FOperacao = tpNone);
end;

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  Operacao := tpAlterar;

  edtNome.Text                := clsUsuarios.nome;
  edtEmail.Text               := clsUsuarios.email;
  cboNivelDeAcesso.ItemIndex  := cboNivelDeAcesso.Items.IndexOf(clsUsuarios.nivel);
  edtSenha.Text               := clsUsuarios.senha;
end;

procedure TfrmUsuarios.btnDesfazerClick(Sender: TObject);
begin
  Operacao := tpNone;

  edtNome.Text  := EmptyStr;
  edtEmail.Text := EmptyStr;
  edtSenha.Text := EmptyStr;
end;

procedure TfrmUsuarios.btnExcluirClick(Sender: TObject);
var
  clsUsuario : TUsuario;
  clsUsuarioController : TUsuarioController;

begin
  Operacao := tpNone;

  try
    clsUsuario  :=  Tusuario.Create;
    clsUsuarioController := TUsuarioController.Create;

    if DM.qryUsuarios.RecordCount > 0 then
    begin
      if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      begin
        clsUsuario.id := clsUsuarios.id;
        clsUsuarioController.excluir(clsUsuarios);

        clsUsuarioController.findAll();
      end;
    end;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsUsuarioController);
end;

procedure TfrmUsuarios.btnNovoClick(Sender: TObject);
begin
  Operacao := tpIncluir;

  edtNome.Text  := EmptyStr;
  edtEmail.Text := EmptyStr;
  edtSenha.Text := EmptyStr;

  edtNome.SetFocus;
end;

procedure TfrmUsuarios.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  clsUsuario : TUsuario;
  clsUsuarioController : TUsuarioController;

begin
  try
    clsUsuario  :=  Tusuario.Create;
    clsUsuarioController := TUsuarioController.Create;

    clsUsuario.email  := trim(edtEmail.Text);
    clsUsuario.nome   := trim(edtNome.Text);
    clsUsuario.nivel  := cboNivelDeAcesso.Text;
    clsUsuario.senha  := TBCrypt.HashPassword(trim(edtSenha.Text));

    if Operacao = tpIncluir then
      clsUsuarioController.incluir(clsUsuario)
    else if Operacao = tpAlterar then
    begin
      clsUsuario.id := DM.qryUsuarios.FieldByName('id').AsInteger;

      clsUsuarioController.alterar(clsUsuario);
    end;

    clsUsuarioController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsUsuario);
  FreeAndNil(clsUsuarioController);
end;

procedure TfrmUsuarios.dsUsuariosDataChange(Sender: TObject; Field: TField);
begin
  if clsUsuarios <> nil then
  begin
    clsUsuarios.id     := DM.qryUsuarios.FieldByName('id').AsInteger;
    clsUsuarios.email  := DM.qryUsuarios.FieldByName('email').AsString;
    clsUsuarios.nome   := DM.qryUsuarios.FieldByName('nome').AsString;
    clsUsuarios.nivel  := DM.qryUsuarios.FieldByName('nivel').AsString;
    clsUsuarios.senha  := DM.qryUsuarios.FieldByName('senha').AsString;
  end;
end;

procedure TfrmUsuarios.edtPesquisaChange(Sender: TObject);
var
  cFiltro : String;
begin
  cFiltro := 'UPPER(email) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryUsuarios.Filtered := false;
  dm.qryUsuarios.Filter   := cFiltro;
  dm.qryUsuarios.Filtered := true;

end;

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  Operacao := tpNone;

  carregaComboNiveisAcesso();
end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
var
  clsUsuarioController : TUsuarioController;

begin
  try
    clsUsuarioController := TUsuarioController.Create;
    clsUsuarioController.findAll();
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsUsuarioController);

end;

//------------------------------------------------------------------------------------------

procedure TfrmUsuarios.carregaComboNiveisAcesso();
var
  clsNivel : TNivel;
  clsNivelController : TNivelController;
begin
  try
    clsNivel  :=  TNivel.Create;
    clsNivelController := TNivelController.Create;

    clsNivelController.findAll();

    if DM.qryNivelAcesso.RecordCount > 0 then
    begin
      cboNivelDeAcesso.Clear;
      DM.qryNivelAcesso.First;

      while not DM.qryNivelAcesso.Eof do
      begin

        cboNivelDeAcesso.Items.Add(trim(DM.qryNivelAcesso.FieldByName('nivel').AsString));

        DM.qryNivelAcesso.Next;
      end;
    end;
    cboNivelDeAcesso.ItemIndex := 0;

    DM.qryNivelAcesso.Close;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsNivel);
  FreeAndNil(clsNivelController);
end;

end.

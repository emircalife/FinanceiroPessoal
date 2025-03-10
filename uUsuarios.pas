unit uUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
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
    lkpNivelDeAcesso: TDBLookupComboBox;
    qrylkpUsuarios: TFDQuery;
    dslkpUsuarios: TDataSource;
    qrylkpUsuariosID: TIntegerField;
    qrylkpUsuariosDESCRICAO: TStringField;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    edtSenha: TDBEdit;
    edtUsuario: TDBEdit;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.State = dsBrowse then
  begin
    DM.qryUsuarios.Edit;
    DM.qryUsuariosSENHA.value := '';
    edtUsuario.setFocus;
  end;
end;

procedure TfrmUsuarios.btnDesfazerClick(Sender: TObject);
begin
  if DM.qryUsuarios.State <> dsBrowse then
    DM.qryUsuarios.Cancel;
end;

procedure TfrmUsuarios.btnExcluirClick(Sender: TObject);
begin
  if DM.qryUsuarios.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      DM.qryUsuarios.Delete;
end;

procedure TfrmUsuarios.btnNovoClick(Sender: TObject);
begin
  if DM.qryUsuarios.State in [dsInactive, dsBrowse] then
  begin
    DM.qryUsuarios.Append;
    edtUsuario.setFocus;
  end;
end;

procedure TfrmUsuarios.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  cSenha : String;
begin
  if DM.qryUsuarios.State <> dsBrowse then
  begin
    if Trim(DM.qryUsuariosSENHA.value) = '' then
    begin
      uFuncoes.MessageDlgDefault('A senha está vazia.', mtError,[mbOk], 0);
      edtSenha.SetFocus;
      exit;
    end;

    cSenha := uFuncoes.Criptografar(AnsiUpperCase(trim(DM.qryUsuariosSENHA.value)));
    DM.qryUsuariosSENHA.value := cSenha;

    DM.qryUsuarios.Post;

    DM.qryUsuarios.Refresh;
  end;
end;

procedure TfrmUsuarios.edtPesquisaChange(Sender: TObject);
var
  cFiltro : String;
begin
  cFiltro := 'UPPER(LOGIN) LIKE ' + QuotedStr('%' + trim(UpperCase(edtPesquisa.Text)) + '%');

  dm.qryUsuarios.Filtered := false;
  dm.qryUsuarios.Filter   := cFiltro;
  dm.qryUsuarios.Filtered := true;

end;

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  if DM.qryUsuarios.Active = false then
    DM.qryUsuarios.Active := true;

  if qrylkpUsuarios.Active = false then
    qrylkpUsuarios.Active := true;

end;

procedure TfrmUsuarios.FormDestroy(Sender: TObject);
begin
  if DM.qryUsuarios.Active = true then
    DM.qryUsuarios.Active := false;

  if qrylkpUsuarios.Active = true then
    qrylkpUsuarios.Active := false;
end;

end.

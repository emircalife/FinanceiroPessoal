unit uCategoriasReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons;

type
  TfrmCategoriasReceita = class(TForm)
    grdCategoriasReceita: TDBGrid;
    dsCategoriasReceita: TDataSource;
    edtCategoriaReceita: TDBEdit;
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
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nIdUsuario   : Integer;
    cNomeUsuario : String;
  end;

var
  frmCategoriasReceita: TfrmCategoriasReceita;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmCategoriasReceita.btnAlterarClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.State = dsBrowse then
  begin
    DM.qryCategoriasReceita.Edit;
    edtCategoriaReceita.setFocus;
  end;
end;

procedure TfrmCategoriasReceita.btnDesfazerClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.State <> dsBrowse then
    DM.qryCategoriasReceita.Cancel;
end;

procedure TfrmCategoriasReceita.btnExcluirClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      DM.qryCategoriasReceita.Delete;
end;

procedure TfrmCategoriasReceita.btnNovoClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.State in [dsInactive, dsBrowse] then
  begin
    DM.qryCategoriasReceita.Append;
    edtCategoriaReceita.setFocus;
  end;
end;

procedure TfrmCategoriasReceita.btnFecharClick(Sender: TObject);
begin
  DM.qryCategoriasReceita.Active := false;

  Close;
end;

procedure TfrmCategoriasReceita.btnSalvarClick(Sender: TObject);
begin
  if DM.qryCategoriasReceita.State <> dsBrowse then
  begin
    if DM.qryCategoriasReceita.State = dsInsert then
//      DM.qryCategoriasReceitaID.Value := DM.getNextId('CATEGORIASRECEITA');

    DM.qryCategoriasReceitaIDUSUARIO.AsInteger := nIdUsuario;
    DM.qryCategoriasReceita.Post;
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

procedure TfrmCategoriasReceita.FormCreate(Sender: TObject);
begin
  if DM.qryCategoriasReceita.Active = false then
    DM.qryCategoriasReceita.Active := true;
end;

procedure TfrmCategoriasReceita.FormDestroy(Sender: TObject);
begin
  if DM.qryCategoriasReceita.Active = true then
    DM.qryCategoriasReceita.Active := false;
end;

end.

unit uCategoriasDespesa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons;

type
  TfrmCategoriasDespesa = class(TForm)
    grdCategoriasDespesa: TDBGrid;
    dsCategoriasDespesa: TDataSource;
    lblCategoriaDespesa: TLabel;
    edtCategoriaDespesa: TDBEdit;
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
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
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
  frmCategoriasDespesa: TfrmCategoriasDespesa;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmCategoriasDespesa.btnAlterarClick(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.State = dsBrowse then
  begin
    DM.qryCategoriasDespesa.Edit;
    edtCategoriaDespesa.setFocus;
  end;
end;

procedure TfrmCategoriasDespesa.btnDesfazerClick(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.State <> dsBrowse then
    DM.qryCategoriasDespesa.Cancel;
end;

procedure TfrmCategoriasDespesa.btnExcluirClick(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
      DM.qryCategoriasDespesa.Delete;
end;

procedure TfrmCategoriasDespesa.btnNovoClick(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.State in [dsInactive, dsBrowse] then
  begin
    DM.qryCategoriasDespesa.Append;
    edtCategoriaDespesa.setFocus;
  end;
end;

procedure TfrmCategoriasDespesa.btnFecharClick(Sender: TObject);
begin
  DM.qryCategoriasDespesa.Active := false;

  Close;
end;

procedure TfrmCategoriasDespesa.btnSalvarClick(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.State <> dsBrowse then
  begin
    if DM.qryCategoriasDespesa.State = dsInsert then
//      DM.qryCategoriasDespesaID.Value := DM.getNextId('CATEGORIASDESPESA');

    DM.qryCategoriasDespesaIDUSUARIO.AsInteger := nIdUsuario;
    DM.qryCategoriasDespesa.Post;
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

procedure TfrmCategoriasDespesa.FormCreate(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.Active = false then
    DM.qryCategoriasDespesa.Active := true;

end;

procedure TfrmCategoriasDespesa.FormDestroy(Sender: TObject);
begin
  if DM.qryCategoriasDespesa.Active = true then
    DM.qryCategoriasDespesa.Active := false;
end;

end.

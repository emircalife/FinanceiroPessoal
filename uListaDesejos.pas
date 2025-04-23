unit uListaDesejos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, ShellAPI;

type
  TfrmListaDesejos = class(TForm)
    pnlBotoes: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnDesfazer: TBitBtn;
    btnSalvar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    grdListaDesejos: TDBGrid;
    dsListaDesejos: TDataSource;
    lblDesejo: TLabel;
    edtDesejo: TDBEdit;
    lblLinkSite: TLabel;
    edtLinkSite: TDBEdit;
    lblValorBem: TLabel;
    edtValorBem: TDBEdit;
    lblDataCadastro: TLabel;
    edtDataCadastro: TDBEdit;
    lblDataCompra: TLabel;
    edtDataCompra: TDBEdit;
    btnAbrirSite: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnAbrirSiteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nIdUsuario     : Integer;
    cNomeUsuario   : String;
  end;

var
  frmListaDesejos: TfrmListaDesejos;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmListaDesejos.btnAbrirSiteClick(Sender: TObject);
var
  lcLinkSite : String;

begin
  lcLinkSite := trim(dm.qryListaDesejoslinkSite.AsString);

  ShellExecute(Handle, 'open', PCHAR(lcLinkSite), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfrmListaDesejos.btnAlterarClick(Sender: TObject);
begin
  if DM.qryListaDesejos.State = dsBrowse then
  begin
    DM.qryListaDesejos.Edit;
    edtDesejo.setFocus;
  end;
end;

procedure TfrmListaDesejos.btnDesfazerClick(Sender: TObject);
begin
  if DM.qryListaDesejos.State <> dsBrowse then
    DM.qryListaDesejos.Cancel;
end;

procedure TfrmListaDesejos.btnExcluirClick(Sender: TObject);
begin
  if DM.qryListaDesejos.RecordCount > 0 then
    if uFuncoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes],
                                                          0, mrNo) = mrYes then
      DM.qryListaDesejos.Delete;
end;

procedure TfrmListaDesejos.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListaDesejos.btnNovoClick(Sender: TObject);
begin
  if DM.qryListaDesejos.State in [dsInactive, dsBrowse] then
  begin
    DM.qryListaDesejos.Append;

    DM.qryListaDesejosdataCadastro.Value  :=  Date();

    edtDesejo.setFocus;
  end;
end;

procedure TfrmListaDesejos.btnSalvarClick(Sender: TObject);
var
  mesAno, cMes, cAno : String;
  nRecNo : Integer;

begin
  if DM.qryListaDesejos.State <> dsBrowse then
  begin
    if DM.qryListaDesejos.State <> dsInsert then
      nRecNo := DM.qryListaDesejos.RecNo;

    DM.qryListaDesejosIDUSUARIO.AsInteger   := nIdUsuario;

    DM.qryListaDesejos.Post;

    if DM.qryListaDesejos.State = dsInsert then
      DM.qryListaDesejos.Last
    else
      DM.qryListaDesejos.RecNo := nRecNo;
  end;
end;

procedure TfrmListaDesejos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DM.qryListaDesejos.Active = true then
    DM.qryListaDesejos.Active := false;
end;

procedure TfrmListaDesejos.FormCreate(Sender: TObject);
begin
  if DM.qryListaDesejos.Active = false then
    DM.qryListaDesejos.Active := true;
end;

end.

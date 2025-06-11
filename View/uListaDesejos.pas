unit uListaDesejos;

interface

uses
  Usuario, ListaDesejos,
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
    lblLinkSite: TLabel;
    lblValorBem: TLabel;
    lblDataCadastro: TLabel;
    lblDataCompra: TLabel;
    btnAbrirSite: TBitBtn;
    edtDesejo: TEdit;
    edtLinkSite: TEdit;
    edtDataCadastro: TMaskEdit;
    edtDataCompra: TMaskEdit;
    edtValorBem: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnDesfazerClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAbrirSiteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsListaDesejosDataChange(Sender: TObject; Field: TField);
    procedure edtValorBemKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorBemExit(Sender: TObject);
  private
    { Private declarations }
    cOperacao : String; //(L)er, (A)lterar, (I)ncluir
    procedure findAll();
    procedure incluir(clsListaDesejos:TclsListaDesejos);
    procedure alterar(clsListaDesejos:TclsListaDesejos);
    procedure excluir(clsListaDesejos:TclsListaDesejos);
  public
    { Public declarations }
    clsUsuario     : TUsuario;
    clsListaDesejos : TclsListaDesejos;
  end;

var
  frmListaDesejos: TfrmListaDesejos;

implementation

{$R *.dfm}

uses uDM, Funcoes;

procedure TfrmListaDesejos.btnAbrirSiteClick(Sender: TObject);
var
  lcLinkSite : String;

begin
  lcLinkSite := trim(edtLinkSite.Text);

  if lcLinkSite <> '' then
    ShellExecute(Handle, 'open', PCHAR(lcLinkSite), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfrmListaDesejos.btnAlterarClick(Sender: TObject);
begin
  cOperacao := 'A';

  edtDesejo.Text        := clsListaDesejos.descricaoDesejo;
  edtLinkSite.Text      := clsListaDesejos.linkSite;
  edtValorBem.Text      := CurrToText(clsListaDesejos.valorBem);
  edtDataCadastro.Text  := FormatDateTime('DD/MM/YYYY', clsListaDesejos.dataCadastro);
  edtDataCompra.Text    := FormatDateTime('DD/MM/YYYY', clsListaDesejos.dataCompra);

  edtDesejo.setFocus;

end;

procedure TfrmListaDesejos.btnDesfazerClick(Sender: TObject);
begin
  cOperacao := 'L';

  Funcoes.limpaCampos(frmListaDesejos);
end;

procedure TfrmListaDesejos.btnExcluirClick(Sender: TObject);
begin
  cOperacao := 'L';

  if DM.qryListaDesejos.RecordCount > 0 then
  begin
    if Funcoes.MessageDlgDefault('Confirma a Exclusão?',mtWarning,[mbNo, mbYes], 0, mrNo) = mrYes then
    begin
      excluir(clsListaDesejos);

      findAll();
    end;
  end;
end;

procedure TfrmListaDesejos.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmListaDesejos.btnNovoClick(Sender: TObject);
begin
  cOperacao := 'I';

  edtDesejo.Text := EmptyStr;
  Funcoes.LimpaCampos(frmListaDesejos);
  edtDesejo.SetFocus;
end;

procedure TfrmListaDesejos.btnSalvarClick(Sender: TObject);
begin
  clsListaDesejos.descricaoDesejo := trim(edtDesejo.Text);
  clsListaDesejos.linkSite        := trim(edtLinkSite.Text);
  clsListaDesejos.valorBem        := Funcoes.TextToCurr(edtValorBem.Text);

  if trim(edtDataCadastro.Text) <> '/  /' then
    clsListaDesejos.dataCadastro    := StrToDate(edtDataCadastro.Text)
  else
    clsListaDesejos.dataCadastro    := null;

  if trim(edtDataCompra.Text) <> '/  /' then
    clsListaDesejos.dataCompra      := StrToDate(edtDataCompra.Text)
  else
    clsListaDesejos.dataCompra    := null;

  clsListaDesejos.idUsuario       := clsUsuario.id;

  if cOperacao = 'I' then
    incluir(clsListaDesejos)
  else if cOperacao = 'A' then
  begin
    clsListaDesejos.id := DM.qryListaDesejos.FieldByName('id').AsInteger;

    alterar(clsListaDesejos);
  end;

  findAll();
end;

procedure TfrmListaDesejos.dsListaDesejosDataChange(Sender: TObject;
  Field: TField);
begin
  if clsListaDesejos <> nil then
  begin
    clsListaDesejos.id               := DM.qryListaDesejos.FieldByName('id').AsInteger;
    clsListaDesejos.descricaoDesejo  := DM.qryListaDesejos.FieldByName('descricaoDesejo').AsString;
    clsListaDesejos.linkSite         := DM.qryListaDesejos.FieldByName('linkSite').AsString;
    clsListaDesejos.valorBem         := DM.qryListaDesejos.FieldByName('valorBem').AsCurrency;
    clsListaDesejos.dataCadastro     := DM.qryListaDesejos.FieldByName('dataCadastro').AsDateTime;
    clsListaDesejos.dataCompra       := DM.qryListaDesejos.FieldByName('dataCompra').AsDateTime;
    clsListaDesejos.idUsuario        := DM.qryListaDesejos.FieldByName('idUsuario').AsInteger;
  end;
end;

procedure TfrmListaDesejos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FreeAndNil(clsListaDesejos);
end;

procedure TfrmListaDesejos.FormCreate(Sender: TObject);
begin
  cOperacao             := 'C';
  clsUsuario            := TUsuario.Create;
  clsListaDesejos       := TclsListaDesejos.Create;
end;

procedure TfrmListaDesejos.FormShow(Sender: TObject);
begin
  findAll();
end;

//---------------------------------------------------------------------------------------------
procedure TfrmListaDesejos.incluir(clsListaDesejos : TclsListaDesejos);
const
  cSQL : String = 'INSERT INTO desejoscompra (    '+
                  'descricaoDesejo, linkSite,     '+
                  'valorBem, dataCadastro,        '+
                  'dataCompra, idUsuario          '+
                  ')VALUES(                       '+
                  ':PdescricaoDesejo, :PlinkSite, '+
                  ':PvalorBem, :PdataCadastro,    '+
                  ':PdataCompra, :PidUsuario)     ';
begin
  try
    DM.qryManutListaDesejos.Close;
    DM.qryManutListaDesejos.SQL.Clear;
    DM.qryManutListaDesejos.SQL.Add(cSQL);
    DM.qryManutListaDesejos.ParamByName('PdescricaoDesejo').AsString  := clsListaDesejos.descricaoDesejo;
    DM.qryManutListaDesejos.ParamByName('PlinkSite').AsString         := clsListaDesejos.linkSite;
    DM.qryManutListaDesejos.ParamByName('PvalorBem').AsCurrency       := clsListaDesejos.valorBem;
    DM.qryManutListaDesejos.ParamByName('PdataCadastro').AsDate       := clsListaDesejos.dataCadastro;
    DM.qryManutListaDesejos.ParamByName('PdataCompra').AsDate         := clsListaDesejos.dataCompra;
    DM.qryManutListaDesejos.ParamByName('PidUsuario').AsInteger       := clsListaDesejos.id;
    DM.qryManutListaDesejos.ExecSQL;
  except
    ShowMessage('Houve erro no cadastro da Lista de Desejo, favor tente novamente!');
  end;
end;

procedure TfrmListaDesejos.alterar(clsListaDesejos : TclsListaDesejos);
const
  cSQL : String = 'UPDATE desejoscompra SET           '+
                  'descricaoDesejo=:PdescricaoDesejo, '+
                  'linkSite=:PlinkSite,               '+
                  'valorBem=:PvalorBem,               '+
                  'dataCadastro=:PdataCadastro,       '+
                  'dataCompra=:PdataCompra            '+
                  'WHERE idUsuario =:PidUsuario       '+
                  '  AND id = :Pid                    ';
begin
  try
    DM.qryManutListaDesejos.Close;
    DM.qryManutListaDesejos.SQL.Clear;
    DM.qryManutListaDesejos.SQL.Add(cSQL);
    DM.qryManutListaDesejos.ParamByName('Pid').AsInteger              := clsListaDesejos.id;
    DM.qryManutListaDesejos.ParamByName('PdescricaoDesejo').AsString  := clsListaDesejos.descricaoDesejo;
    DM.qryManutListaDesejos.ParamByName('PlinkSite').AsString         := clsListaDesejos.linkSite;
    DM.qryManutListaDesejos.ParamByName('PvalorBem').AsCurrency       := clsListaDesejos.valorBem;
    DM.qryManutListaDesejos.ParamByName('PdataCadastro').AsDate       := clsListaDesejos.dataCadastro;
    DM.qryManutListaDesejos.ParamByName('PdataCompra').AsDate         := clsListaDesejos.dataCompra;
    DM.qryManutListaDesejos.ParamByName('PidUsuario').AsInteger       := clsListaDesejos.id;
    DM.qryManutListaDesejos.ExecSQL;
  except
    ShowMessage('Houve erro na alteração da Lista de Desejo, favor tente novamente!');
  end;
end;

procedure TfrmListaDesejos.findAll();
const
  cSQL : String = 'SELECT id, descricaoDesejo,         '+
                  'linkSite, valorBem,                 '+
                  'dataCadastro, dataCompra, idUsuario '+
                  'FROM desejoscompra                  '+
                  'WHERE idUsuario =:PidUsuario        '+
                  'ORDER BY descricaoDesejo            ';
begin
  try
    DM.qryListaDesejos.Close;
    DM.qryListaDesejos.SQL.Clear;
    DM.qryListaDesejos.SQL.Add(cSQL);
    DM.qryListaDesejos.ParamByName('PidUsuario').AsInteger:= clsUsuario.id;
    DM.qryListaDesejos.Open;
  except
    ShowMessage('Houve erro na listagem da Lista de Desejo, favor tente novamente!');
  end;
end;

procedure TfrmListaDesejos.edtValorBemExit(Sender: TObject);
begin
  if (trim(edtValorBem.Text) <> '') then
    edtValorBem.Text := CurrToText(TextToCurr(edtValorBem.Text));
end;

procedure TfrmListaDesejos.edtValorBemKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', ',', #08]) then
    key := #0;

end;

procedure TfrmListaDesejos.excluir(clsListaDesejos : TclsListaDesejos);
const
  cSQL : String = 'DELETE FROM desejoscompra     '+
                  'WHERE id = :Pid               '+
                  '  AND idUsuario = :PidUsuario ';
begin
  try
    DM.qryManutListaDesejos.Close;
    DM.qryManutListaDesejos.SQL.Clear;
    DM.qryManutListaDesejos.SQL.Add(cSQL);
    DM.qryManutListaDesejos.ParamByName('Pid').AsInteger        := clsListaDesejos.id;
    DM.qryManutListaDesejos.ParamByName('PidUsuario').AsInteger := clsListaDesejos.idUsuario;
    DM.qryManutListaDesejos.ExecSQL;
  except
    ShowMessage('Houve erro na exclusão da Lista de Desejo, favor tente novamente!');
  end;
end;
end.

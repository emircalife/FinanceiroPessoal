unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, INIFiles, Vcl.Dialogs, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TDM = class(TDataModule)
    Conn: TFDConnection;
    Trans: TFDTransaction;
    qryCategoriasDespesa: TFDQuery;
    FDInterbaseLink: TFDPhysFBDriverLink;

    qryCategoriasReceita: TFDQuery;

    qryDespesas: TFDQuery;
    qryReceitas: TFDQuery;

    qryLogin: TFDQuery;

    qryUsuarios: TFDQuery;
    FDMySQLLink: TFDPhysMySQLDriverLink;
    qryCategoriasReceitaid: TIntegerField;
    qryCategoriasReceitadescricao: TStringField;
    qryCategoriasReceitaidusuario: TIntegerField;
    qryExportDespesasExcel: TFDQuery;
    qryListaDesejos: TFDQuery;
    qryManutCategoriasDespesa: TFDQuery;
    qryCategoriasDespesaid: TFDAutoIncField;
    qryCategoriasDespesadescricao: TStringField;
    qryCategoriasDespesaidusuario: TIntegerField;
    qryManutCategoriasReceita: TFDQuery;
    qryManutUsuarios: TFDQuery;
    qryNivelAcesso: TFDQuery;
    qryUsuariosID: TFDAutoIncField;
    qryUsuariosemail: TStringField;
    qryUsuariosnome: TStringField;
    qryUsuariossenha: TStringField;
    qryUsuariosnivel: TStringField;
    qryManutListaDesejos: TFDQuery;
    qryManutDespesas: TFDQuery;
    qryManutReceitas: TFDQuery;
    qryManutReceitasid: TFDAutoIncField;
    qryManutReceitasdescricao: TStringField;
    qryManutReceitasdatarecebimento: TDateField;
    qryManutReceitasvalorareceber: TBCDField;
    qryManutReceitasvalorrecebido: TBCDField;
    qryManutReceitasidcategoria: TIntegerField;
    qryManutReceitascategoriareceita: TStringField;
    qryManutReceitasidusuario: TIntegerField;
    qryManutReceitasdataareceber: TDateField;
    qryManutReceitasobservacoes: TStringField;
    qryDespesasid: TIntegerField;
    qryDespesasdescricao: TStringField;
    qryDespesasdataVencimento: TDateField;
    qryDespesasvalorAPagar: TBCDField;
    qryDespesasvalorPago: TBCDField;
    qryDespesasvalorDiferenca: TBCDField;
    qryDespesasidCategoria: TIntegerField;
    qryDespesascategoriaDespesa: TStringField;
    qryDespesasidUsuario: TIntegerField;
    qryDespesasdataPagamento: TDateField;
    qryDespesasobservacoes: TStringField;
    qryDespesasdespesaFixa: TShortintField;
    qryDespesasnParc: TIntegerField;
    qryDespesastotParc: TIntegerField;
    qryDespesasarquivoAnexo: TStringField;
    qryReceitasid: TFDAutoIncField;
    qryReceitasdescricao: TStringField;
    qryReceitasdatarecebimento: TDateField;
    qryReceitasvalorareceber: TBCDField;
    qryReceitasvalorrecebido: TBCDField;
    qryReceitasidcategoria: TIntegerField;
    qryReceitascategoriareceita: TStringField;
    qryReceitasidusuario: TIntegerField;
    qryReceitasdataareceber: TDateField;
    qryReceitasobservacoes: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iIniFile : TIniFile;
  public
    { Public declarations }
    function LerIni(Chave1, Chave2: String; ValorPadrao: String = ''): String;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDM.LerIni(Chave1, Chave2: String; ValorPadrao: String = ''): String;
var
  Arquivo: String;
  FileIni: TIniFile;
begin
  Arquivo := ExtractFilePath(ParamStr(0)) + 'config.ini';
  result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
    begin
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
    end;
  finally
    FreeAndNil(FileIni)
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  cDriverID, cServer, cDatabase, cUser, cPassword, cBD : String;
begin
  cBD       := LerIni('Config', 'BD');

  if cBD = 'MySQL' then
  begin
    cDriverID := 'MySQL';
    try
      with Conn do
      begin
        cServer   :=  LerIni(cDriverID,'Server');
        cDatabase :=  LerIni(cDriverID,'Database');
        cUser     :=  LerIni(cDriverID,'User');
        cPassword :=  LerIni(cDriverID,'Password');

        Params.Clear;
        Params.Values['DriverID']   := cDriverID;
        Params.Values['Server']     := cServer;
        Params.Values['Database']   := cDatabase;
        Params.Values['User_name']  := cUser;
        //Params.Values['Password']   := cPassword;
        Connected := True;
      end;
    except
      ShowMessage('Ocorreu uma Falha na configuração no Banco de dados ' + QuotedStr(cDriverID));
    end;
  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  Conn.Connected := false;
end;

end.

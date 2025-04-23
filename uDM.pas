unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, INIFiles, Vcl.Dialogs;

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
    qryDespesasSEQUENCIA: TLargeintField;
    qryReceitasSEQUENCIA: TLargeintField;
    qryCategoriasDespesaSEQUENCIA: TLargeintField;
    qryCategoriasReceitaSEQUENCIA: TLargeintField;
    qryUsuariosSEQUENCIA: TLargeintField;
    FDMySQLLink: TFDPhysMySQLDriverLink;
    qryCategoriasDespesaid: TIntegerField;
    qryCategoriasDespesadescricao: TStringField;
    qryCategoriasDespesaidusuario: TIntegerField;
    qryCategoriasReceitaid: TIntegerField;
    qryCategoriasReceitadescricao: TStringField;
    qryCategoriasReceitaidusuario: TIntegerField;
    qryDespesasID: TIntegerField;
    qryDespesasDESCRICAO: TStringField;
    qryDespesasDATAVENCIMENTO: TDateField;
    qryDespesasVALORAPAGAR: TBCDField;
    qryDespesasVALORPAGO: TBCDField;
    qryDespesasIDCATEGORIA: TIntegerField;
    qryDespesascategoriaDespesa: TStringField;
    qryDespesasIDUSUARIO: TIntegerField;
    qryDespesasDATAPAGAMENTO: TDateField;
    qryReceitasID: TIntegerField;
    qryReceitasDESCRICAO: TStringField;
    qryReceitasDATARECEBIMENTO: TDateField;
    qryReceitasVALORARECEBER: TBCDField;
    qryReceitasVALORRECEBIDO: TBCDField;
    qryReceitasIDCATEGORIA: TIntegerField;
    qryReceitascategoriaReceita: TStringField;
    qryReceitasIDUSUARIO: TIntegerField;
    qryReceitasDATAARECEBER: TDateField;
    qryLoginID: TFDAutoIncField;
    qryLoginLOGIN: TStringField;
    qryLoginSENHA: TStringField;
    qryLoginIDNIVEL: TIntegerField;
    qryLoginNIVELDEACESSO: TStringField;
    qryUsuariosID: TIntegerField;
    qryUsuariosLOGIN: TStringField;
    qryUsuariosSENHA: TStringField;
    qryUsuariosIDNIVEL: TIntegerField;
    qryUsuariosNIVELDEACESSO: TStringField;
    qryDespesasOBSERVACOES: TStringField;
    qryReceitasOBSERVACOES: TStringField;
    qryDespesasVALORDIFERENCA: TBCDField;
    qryExportDespesasExcel: TFDQuery;
    qryDespesasDESPESAFIXA: TShortintField;
    qryDespesasnParc: TIntegerField;
    qryDespesastotParc: TIntegerField;
    qryDespesasarquivoAnexo: TStringField;
    qryListaDesejos: TFDQuery;
    qryListaDesejosSEQUENCIA: TLargeintField;
    qryListaDesejosid: TIntegerField;
    qryListaDesejosdescricaoDesejo: TStringField;
    qryListaDesejoslinkSite: TStringField;
    qryListaDesejosvalorBem: TBCDField;
    qryListaDesejosdataCadastro: TDateField;
    qryListaDesejosdataCompra: TDateField;
    qryListaDesejosidUsuario: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    iIniFile : TIniFile;
  public
    { Public declarations }
    function getNextId(vGen: String): integer;
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
        Params.Values['Password']   := cPassword;
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

function TDM.getNextId(vGen: String): integer;
var
  TMPsql: TFDQuery;
begin
  Result := -1;

  {
  try
    TMPsql := TFDQuery.Create(nil);
    TMPsql.Connection := Conn;
    TMPsql.SQL.Text := 'SELECT GEN_ID(GEN_' + trim(vGen) + '_ID' + ', 1) AS VLR FROM RDB$DATABASE';
    TMPsql.Active := True;
    Result := TMPsql.FieldByName('VLR').AsInteger;
  finally
    TMPsql.Free;
  end;
  }
end;

end.

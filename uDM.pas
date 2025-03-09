unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function getNextId(vGen: String): integer;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  driver  : String;
begin
  driver  :=  '';

  if driver = 'FB' then
  begin
    Conn.DriverName       :=  'FB';
    Conn.Params.UserName  :=  'SYSDBA';
    Conn.Params.Password  :=  'masterkey';
    Conn.Params.Database  :=  'D:\Projetos\Delphi\ControleFinanceiro\DB\FINANCEIRODB.FDB';
  end else if driver = 'MySQL' then
  begin
//    Conn.DriverName       :=  'MySQL';
//    Conn.Params.UserName  :=  'root';
//    Conn.Params.Password  :=  '123456';
//    Conn.Params.Database  :=  'FinanceiroDB';
//    Conn.Params.Server    :=  'localhost';
  end;

  Conn.Connected := true;
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

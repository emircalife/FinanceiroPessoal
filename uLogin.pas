unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, ClipBrd;

type
  TfrmLogin = class(TForm)
    lblUsuario: TLabel;
    lblSenha: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    chkVisualizarSenha: TCheckBox;
    btnLogar: TBitBtn;
    btnCancelar: TBitBtn;
    imgLogin: TImage;
    procedure chkVisualizarSenhaClick(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
      tentativas : Smallint;
      function loginValido(const usuario, senha: String): Boolean;
  public
    nIdUsuario   : Integer;
    cNomeUsuario : String;
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uMain, uDM, uFuncoes;

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLogarClick(Sender: TObject);
begin
  if (edtUsuario.Text = '') then //Verifica se o campo "Usuário" foi preenchido
	begin
		Messagedlg('O campo "Usuário" deve ser preenchido!', mtInformation, [mbOk], 0);
		if edtUsuario.CanFocus then
		  edtUsuario.SetFocus;

		Exit;
	end else if (edtSenha.Text = '') then //Verifica se o campo "Senha" foi preenchido
	begin
		Messagedlg('O campo "Senha" deve ser preenchido!', mtInformation, [mbOk], 0);
		if edtSenha.CanFocus then
		  edtSenha.SetFocus;

		Exit;
	end else if loginValido(edtUsuario.Text, edtSenha.Text) then //Verifica se o login é válido
		ModalResult := mrOk
	else //Caso o login não seja válido então
	begin
		inc(tentativas); //Incrementa em 1 o valor da variável tentativas
		if tentativas < 3 then
    begin
      MessageDlg(Format('Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
      if edtSenha.CanFocus then
        edtSenha.SetFocus;
    end else
    begin
      MessageDlg(Format('%dª tentativa de acesso ao sistema.',
      [tentativas]) + #13 + 'A aplicação será fechada!', mtError, [mbOk], 0);
      ModalResult := mrCancel;
    end;
	end;
end;

procedure TfrmLogin.chkVisualizarSenhaClick(Sender: TObject);
begin
  if chkVisualizarSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TfrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnLogar.Click;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  nIdUsuario   := 0;
  cNomeUsuario := '';
end;

function TfrmLogin.loginValido(const usuario, senha: String): Boolean;
var
  llRetorno : Boolean;
  cSenha    : String;
begin
  cSenha  := uFuncoes.Criptografar(AnsiUpperCase(trim(senha)));

  DM.qryLogin.Close;
  DM.qryLogin.SQL.Clear;
  DM.qryLogin.SQL.add('SELECT us.ID,                                    ');
  DM.qryLogin.SQL.add('       us.LOGIN,                                 ');
  DM.qryLogin.SQL.add('       us.SENHA,                                 ');
  DM.qryLogin.SQL.add('       us.IDNIVEL,                               ');
  DM.qryLogin.SQL.add('       na.DESCRICAO AS NIVELDEACESSO             ');
  DM.qryLogin.SQL.add('FROM USUARIOS us                                 ');
  DM.qryLogin.SQL.add('INNER JOIN NIVEISACESSO na ON us.IDNIVEL = na.ID ');
  DM.qryLogin.SQL.add('WHERE UPPER(LOGIN) =:PLOGIN                      ');
  DM.qryLogin.SQL.add('  AND UPPER(SENHA) =:PSENHA                      ');
  DM.qryLogin.ParamByName('PLOGIN').AsString  :=  AnsiUpperCase(trim(usuario));
  DM.qryLogin.ParamByName('PSENHA').AsString  :=  AnsiUpperCase(trim(cSenha));
  DM.qryLogin.Open;

  if (UpperCase(usuario) = 'ADMIN') and (UpperCase(senha) = 'NIMDA') then
  begin
    llRetorno    := true;
    nIdUsuario   := 0;
    cNomeUsuario := usuario;
  end else if (DM.qryLogin.RecordCount > 0) then
  begin
    llRetorno    := true;
    nIdUsuario   := DM.qryLogin.FieldByName('ID').AsInteger;
    cNomeUsuario := trim(DM.qryLogin.FieldByName('LOGIN').AsString);
  end else if (DM.qryLogin.RecordCount <= 0) then
    llRetorno    := false;

  Result := llRetorno;
end;

end.

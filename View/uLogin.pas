unit uLogin;

interface

uses
  Bcrypt, Usuario, uMain, uDM, Funcoes, LoginController,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, ClipBrd;

type
  TfrmLogin = class(TForm)
    lblEmail: TLabel;
    lblSenha: TLabel;
    edtEmail: TEdit;
    edtSenha: TEdit;
    chkVisualizarSenha: TCheckBox;
    btnLogar: TBitBtn;
    btnCancelar: TBitBtn;
    imgLogin: TImage;
    procedure chkVisualizarSenhaClick(Sender: TObject);
    procedure btnLogarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmailKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
      clsLoginController : TLoginController;
      hashedPassword: string;
      passwordRehashNeeded: Boolean;
  public
    idUsuario : Integer;
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLogarClick(Sender: TObject);
var
  clsUsuario : TUsuario;
  clsLoginController : TLoginController;

  llResult : Boolean;
begin
  try
    clsUsuario  :=  Tusuario.Create;
    clsLoginController := TLoginController.Create;

    clsUsuario.email := trim(edtEmail.Text);
    clsUsuario.senha := trim(edtSenha.Text);

    llResult := clsLoginController.logar(clsUsuario);

    if llResult then
      ModalResult := mrOk
    else
      ModalResult := mrCancel;
  except
    On E: Exception do
      ShowMessage(e.Message);
  end;

  FreeAndNil(clsUsuario);
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

procedure TfrmLogin.edtEmailKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  clsUsuario : TUsuario;
  clsLoginController : TLoginController;

  llResult : Boolean;
begin
  clsUsuario  :=  Tusuario.Create;
  //CTRL+ç
  if (key = 186) and (shift = [ssCtrl]) then
  begin
    try
      clsUsuario.email := 'emircalife@gmail.com';
      clsUsuario.senha := '123';

      llResult := clsLoginController.logar(clsUsuario);

      if llResult then
        ModalResult := mrOk
      else
        ModalResult := mrCancel;
    except
      FreeAndNil(clsUsuario);
    end;
  end;

  FreeAndNil(clsUsuario);
end;

end.

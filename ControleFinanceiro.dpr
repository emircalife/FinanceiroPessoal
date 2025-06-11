program ControleFinanceiro;

uses
  Vcl.Forms,
  Controls,
  SysUtils,
  uDM in 'uDM.pas' {DM: TDataModule},
  uDMRest in 'uDMRest.pas' {DMRest: TDataModule},
  CategoriasReceita in 'Model\CategoriasReceita.pas',
  Despesa in 'Model\Despesa.pas',
  ListaDesejos in 'Model\ListaDesejos.pas',
  Receita in 'Model\Receita.pas',
  Usuario in 'Model\Usuario.pas',
  CategoriasDespesa in 'Model\CategoriasDespesa.pas',
  Bcrypt in 'Controller\Utils\Bcrypt.pas',
  Funcoes in 'Controller\Utils\Funcoes.pas',
  ListaCategoriasDespesa in 'Model\ListaCategoriasDespesa.pas',
  uCalendario in 'View\uCalendario.pas' {frmCalendario},
  uCategoriasDespesa in 'View\uCategoriasDespesa.pas' {frmCategoriasDespesa},
  uCategoriasReceita in 'View\uCategoriasReceita.pas' {frmCategoriasReceita},
  uExpoPlanExelAnual in 'View\uExpoPlanExelAnual.pas' {frmExpoPlanExelAnual},
  uGeracaoParcelas in 'View\uGeracaoParcelas.pas' {frmGeracaoParcelas},
  uImprDespesas in 'View\uImprDespesas.pas' {frmImprDespesas},
  uListaDesejos in 'View\uListaDesejos.pas' {frmListaDesejos},
  uLogin in 'View\uLogin.pas' {frmLogin},
  uMain in 'View\uMain.pas' {frmMain},
  uRelDespesas in 'View\uRelDespesas.pas' {frmRelDespesas},
  uUsuarios in 'View\uUsuarios.pas' {frmUsuarios},
  LoginController in 'Controller\LoginController.pas',
  LoginDAO in 'Model\DAO\LoginDAO.pas',
  UsuarioDAO in 'Model\DAO\UsuarioDAO.pas',
  UsuarioController in 'Controller\UsuarioController.pas',
  Nivel in 'Model\Nivel.pas',
  NivelDAO in 'Model\DAO\NivelDAO.pas',
  CategoriasDespesaDAO in 'Model\DAO\CategoriasDespesaDAO.pas',
  CategoriasReceitaDAO in 'Model\DAO\CategoriasReceitaDAO.pas',
  CategoriasDespesaController in 'Controller\CategoriasDespesaController.pas',
  CategoriasReceitaController in 'Controller\CategoriasReceitaController.pas',
  DespesaController in 'Controller\DespesaController.pas',
  DespesaDAO in 'Model\DAO\DespesaDAO.pas',
  ReceitaDAO in 'Model\DAO\ReceitaDAO.pas',
  ReceitaController in 'Controller\ReceitaController.pas',
  NivelController in 'Controller\NivelController.pas',
  MainDAO in 'Model\DAO\MainDAO.pas',
  MainController in 'Controller\MainController.pas';

{$R *.res}
var
  idUsuario : Integer;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDMRest, DMRest);
  Application.CreateForm(TfrmLogin, frmLogin);
  if FrmLogin.ShowModal = mrOk then //Caso o retorno da tela seja Ok
  begin
    idUsuario := FrmLogin.idUsuario;
    FreeAndNil(FrmLogin); //Libera o form de Login da memória
    Application.CreateForm(TfrmMain, frmMain); //Cria a janela main
    frmMain.idUsuario := idUsuario;
    Application.Run; //Roda a aplicação
  end
  else //Caso o retorno da tela de Login seja mrCancel então
    Application.Terminate; //Encerra a aplicação
end.

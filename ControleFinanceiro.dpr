program ControleFinanceiro;

uses
  Vcl.Forms,
  Controls,
  SysUtils,
  uMain in 'uMain.pas' {frmMain},
  uDM in 'uDM.pas' {DM: TDataModule},
  uCategoriasDespesa in 'uCategoriasDespesa.pas' {frmCategoriasDespesa},
  uCategoriasReceita in 'uCategoriasReceita.pas' {frmCategoriasReceita},
  uGeracaoParcelas in 'uGeracaoParcelas.pas' {frmGeracaoParcelas},
  uCalendario in 'uCalendario.pas' {frmCalendario},
  uLogin in 'uLogin.pas' {frmLogin},
  uFuncoes in 'uFuncoes.pas',
  uUsuarios in 'uUsuarios.pas' {frmUsuarios},
  uImprDespesas in 'uImprDespesas.pas' {frmImprDespesas},
  uRelDespesas in 'uRelDespesas.pas' {frmRelDespesas},
  uExpoPlanExelAnual in 'uExpoPlanExelAnual.pas' {frmExpoPlanExelAnual},
  uListaDesejos in 'uListaDesejos.pas' {frmListaDesejos};

{$R *.res}
var
  nIdUsuario   : Integer;
  cNomeUsuario : String;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmListaDesejos, frmListaDesejos);
  if FrmLogin.ShowModal = mrOk then //Caso o retorno da tela seja Ok
  begin
    nIdUsuario   := frmLogin.nIdUsuario;
    cNomeUsuario := frmLogin.cNomeUsuario;

    FreeAndNil(FrmLogin); //Libera o form de Login da memória
    Application.CreateForm(TfrmMain, frmMain); //Cria a janela main

    frmMain.nIdUsuario := nIdUsuario;
    frmMain.cNomeUsuario := cNomeUsuario;

    Application.Run; //Roda a aplicação
  end
  else //Caso o retorno da tela de Login seja mrCancel então
    Application.Terminate; //Encerra a aplicação

  Application.Run;
end.

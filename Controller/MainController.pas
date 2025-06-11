unit MainController;

interface

uses Bcrypt, Funcoes, MainDAO, Winapi.Windows, Winapi.Messages,
     System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
     Vcl.ExtCtrls, Vcl.Imaging.jpeg, ClipBrd;
type
  TMainController = class
  private
  public
    function CarregaComboMesAno:TStringList;
  end;

implementation

function TMainController.CarregaComboMesAno:TStringList;

begin
  Result := MainDAO.CarregaComboMesAno;
end;

end.

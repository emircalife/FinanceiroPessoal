unit NivelController;

interface

uses Nivel, Bcrypt, uMain, Funcoes, NivelDAO;
type
  TNivelController = class
  private
  public
    procedure findAll();
  end;

implementation

procedure TNivelController.findAll();

begin
  NivelDAO.findAll();
end;

end.


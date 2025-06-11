unit NivelDAO;

interface

uses  uDM, Bcrypt, Funcoes, Nivel,
      Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
      Vcl.Imaging.jpeg, ClipBrd;

type TNivelDAO = class
end;
  procedure findAll();

implementation

procedure findAll();
const
  cSQL : String = 'SELECT id, nivel '+
                  'FROM niveis      '+
                  'ORDER BY nivel   ';
begin
  try
    DM.qryNivelAcesso.Close;
    DM.qryNivelAcesso.SQL.Clear;
    DM.qryNivelAcesso.SQL.Add(cSQL);
    DM.qryNivelAcesso.Open;
  except
    Raise Exception.Create('Houve erro na listagem dos Níveis de Acesso, favor tente novamente!');
  end;
end;

end.

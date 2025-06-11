unit ListaCategoriasDespesa;

interface

  uses Classes, CategoriasDespesa, Dialogs; {Observe que aqui fizemos referencias
as duas classes necessárias para fazer o Exemplo }

  Type
  TListaCategoriasDespesa = class
  private
    { private declarations }
    FListaCategoriasDespesa : TList;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    procedure Adicionar(pCategoriasDespesa: TCategoriasDespesa);
    procedure Remover(Index: Integer);
    function Count: Integer;
  published
    { published declarations }
  end;

implementation

constructor TListaCategoriasDespesa.Create;
begin
  inherited Create;
  FListaCategoriasDespesa := TList.Create;
end;

function TListaCategoriasDespesa.Count: Integer;
begin
  Result := FListaCategoriasDespesa.Count;
end;

procedure TListaCategoriasDespesa.Adicionar(pCategoriasDespesa: TCategoriasDespesa);
begin
  FListaCategoriasDespesa.Add(pCategoriasDespesa);
end;

procedure TListaCategoriasDespesa.Remover(Index: Integer);
begin
  if Index < Count then
     FListaCategoriasDespesa.Delete(Index)
  else
    ShowMessage('Item não encontrado!');
end;

end.

unit Controller.Produto;

interface

uses
  Controller;

type
  TProdutoController = class(TController)
  public
    constructor Create; override;
  end;

implementation

uses
  Model.Produto, DAO.Produto;

{ TProdutoController }

constructor TProdutoController.Create;
begin
  inherited;
  Model := TProduto.Create;
  DAO := TProdutoDAO.Create;
end;

end.

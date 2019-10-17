unit Controller.PedidoVenda;

interface

uses
  Controller;

type
  TPedidoVendaController = class(TController)
  public
    constructor Create; override;
  end;

implementation

uses
  Model.PedidoVenda, DAO.PedidoVenda;

{ TPedidoVendaController }

constructor TPedidoVendaController.Create;
begin
  inherited;
  Model := TPedidoVenda.Create;
  DAO := TPedidoVendaDAO.Create;
end;

end.

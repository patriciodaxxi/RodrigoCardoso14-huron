unit Controller.Cliente;

interface

uses
  Controller;

type
  TClienteController = class(TController)
  public
    constructor Create; override;
  end;

implementation

uses
  Model.Cliente, DAO.Cliente;

{ TClienteController }

constructor TClienteController.Create;
begin
  inherited;
  Model := TCliente.Create;
  DAO := TClienteDAO.Create;
end;

end.

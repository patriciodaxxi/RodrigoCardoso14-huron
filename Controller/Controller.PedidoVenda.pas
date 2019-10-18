unit Controller.PedidoVenda;

interface

uses
  Model, Controller, Util.Enum;

type
  TPedidoVendaController = class(TController)
  public
    constructor Create; override;
    procedure AfterSave(const AOperacao: TOperacao; const AModel: TModel); override;
  end;

implementation

uses
  Model.PedidoVenda, DAO.PedidoVenda, DAO.PedidoVendaItem, SysUtils;

{ TPedidoVendaController }

procedure TPedidoVendaController.AfterSave(const AOperacao: TOperacao; const AModel: TModel);
var
  LPedidoVendaItemDAO: TPedidoVendaItemDAO;
begin
  inherited;
  LPedidoVendaItemDAO := TPedidoVendaItemDAO.Create;
  try
    if AOperacao in [oCreate, oUpdate] then
    begin
      LPedidoVendaItemDAO.SaveList(AModel);
    end;
  finally
    FreeAndNil(LPedidoVendaItemDAO);
  end;
end;

constructor TPedidoVendaController.Create;
begin
  inherited;
  Model := TPedidoVenda.Create;
  DAO := TPedidoVendaDAO.Create;
end;

end.

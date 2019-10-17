unit DAO.PedidoVenda;

interface

uses
  Model, DAO, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils;

type
  TPedidoVendaDAO = class(TDAO)
    function StringInsert: string; override;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); override;
    function CreateModel: TModel; override;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; override;
  end;

implementation

uses
  Model.PedidoVenda, Model.Cliente, DAO.Cliente;

{ TPedidoVenda }

function TPedidoVendaDAO.CreateModel: TModel;
begin
  Result := TPedidoVenda.Create;
end;

function TPedidoVendaDAO.SetModelByDataSet(AFDQuery: TFDQuery): TModel;
var
  LClienteDAO: TClienteDAO;
begin
  Result := inherited;
  LClienteDAO := TClienteDAO.Create;
  try
    with TPedidoVenda(Result), AFDQuery do
    begin
      Cliente := TCliente(LClienteDAO.Find(FieldByName('IDCliente').AsInteger));
      ValorTotal := FieldByName('ValorTotal').AsFloat;
    end;
  finally
    FreeAndNil(LClienteDAO);
  end;
end;

procedure TPedidoVendaDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;
  with AFDQuery, TPedidoVenda(AModel) do
  begin
    ParamByName('IDCliente').AsInteger := Cliente.ID;
    ParamByName('ValorTotal').AsFloat := ValorTotal;
  end;
end;

function TPedidoVendaDAO.StringInsert: string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    SB.Append('UPDATE OR INSERT INTO PedidoVenda ( ').
         Append('ID, IDCliente, ValorTotal) ').
       Append('VALUES( ').
         Append(':ID, :IDCliente, :ValorTotal) ').
       Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.

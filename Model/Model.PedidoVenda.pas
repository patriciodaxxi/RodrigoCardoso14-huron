unit Model.PedidoVenda;

interface

uses
  Model, Model.Cliente, Model.Item, SysUtils, Generics.Collections;

type
  TPedidoVenda = class(TModel)
  private
    FCliente: TCliente;
    FValorTotal: Double;
    FListItem: TObjectList<TItem>;
    procedure SetCliente(const Value: TCliente);
    procedure SetValorTotal(const Value: Double);
    procedure SetListItem(const Value: TObjectList<TItem>);
  public
    constructor Create; override;
    destructor Destroy; override;
    function Validate: Boolean; override;

    property Cliente: TCliente read FCliente write SetCliente;
    property ValorTotal: Double read FValorTotal write SetValorTotal;
    property ListItem: TObjectList<TItem> read FListItem write SetListItem;
  end;

implementation

{ TPedidoVenda }

constructor TPedidoVenda.Create;
begin
  inherited;
  DataBaseObject.Table := 'PedidoVenda';
  DataBaseObject.View := 'VWPedidoVenda';
  Cliente := TCliente.Create;
  ListItem := TObjectList<TItem>.Create(False);
end;

destructor TPedidoVenda.Destroy;
begin
  FreeAndNil(FCliente);
  FreeAndNil(FListItem);
  inherited;
end;

procedure TPedidoVenda.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

procedure TPedidoVenda.SetListItem(const Value: TObjectList<TItem>);
begin
  FListItem := Value;
end;

procedure TPedidoVenda.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

function TPedidoVenda.Validate: Boolean;
begin
  Result := True;
end;

end.

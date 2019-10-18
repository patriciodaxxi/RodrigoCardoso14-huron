unit Model.Item;

interface

uses
  Model, Model.Produto, SysUtils;

type
  TItem = class(TModel)
  private
    FProduto: TProduto;
    FValorVenda: Double;
    FValorTotal: Double;
    FQuantidade: Double;
    procedure SetProduto(const Value: TProduto);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorTotal(const Value: Double);
    procedure SetValorVenda(const Value: Double);
    function GetProduto: TProduto;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Validate: Boolean; override;
    function Clone: TModel; override;

    property Produto: TProduto read GetProduto write SetProduto;
    property ValorVenda: Double read FValorVenda write SetValorVenda;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property ValorTotal: Double read FValorTotal write SetValorTotal;
  end;

implementation

{ TItem }

function TItem.Clone: TModel;
begin
  Result := TItem.Create;
  Result.ID := ID;
  Result.CreatedAt := CreatedAt;
  Result.UpdatedAt := UpdatedAt;
  TItem(Result).Produto := TProduto(FProduto.Clone);
  TItem(Result).ValorVenda := FValorVenda;
  TItem(Result).Quantidade := FQuantidade;
  TItem(Result).ValorTotal := FValorTotal;
end;

constructor TItem.Create;
begin
  inherited;
  DataBaseObject.Table := 'PedidoVendaItem';
  DataBaseObject.View := 'VWPedidoVendaItem';
  //Produto := TProduto.Create;
end;

destructor TItem.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
end;

function TItem.GetProduto: TProduto;
begin
  if not Assigned(FProduto) then
    FProduto := TProduto.Create;
  Result := FProduto;
end;

procedure TItem.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TItem.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TItem.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

procedure TItem.SetValorVenda(const Value: Double);
begin
  FValorVenda := Value;
end;

function TItem.Validate: Boolean;
begin
  Result := True;
end;

end.

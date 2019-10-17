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
  public
    constructor Create; override;
    destructor Destroy; override;
    function Validate: Boolean; override;

    property Produto: TProduto read FProduto write SetProduto;
    property ValorVenda: Double read FValorVenda write SetValorVenda;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property ValorTotal: Double read FValorTotal write SetValorTotal;
  end;

implementation

{ TItem }

constructor TItem.Create;
begin
  inherited;
  Produto := TProduto.Create;
end;

destructor TItem.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
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

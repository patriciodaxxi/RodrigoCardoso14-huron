unit Model.Produto;

interface

uses
  Model, SysUtils;

type
  TProduto = class(TModel)
  private
    FDescricao: string;
    FPrecoVenda: Double;
    FCusto: Double;
    procedure SetCusto(const Value: Double);
    procedure SetDescricao(const Value: string);
    procedure SetPrecoVenda(const Value: Double);
  public
    constructor Create; override;
    destructor Destroy; override;
    function ToStringModel: string; override;
    function Validate: Boolean; override;

    property Descricao: string read FDescricao write SetDescricao;
    property Custo: Double read FCusto write SetCusto;
    property PrecoVenda: Double read FPrecoVenda write SetPrecoVenda;
  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin
  inherited;

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

procedure TProduto.SetCusto(const Value: Double);
begin
  FCusto := Value;
end;

procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
  FPrecoVenda := Value;
end;

function TProduto.ToStringModel: string;
begin
  Result := EmptyStr;
end;

function TProduto.Validate: Boolean;
begin
  Result := True;
end;

end.

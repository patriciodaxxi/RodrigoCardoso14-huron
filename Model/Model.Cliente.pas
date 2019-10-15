unit Model.Cliente;

interface

uses
  Model, SysUtils;

type
  TCliente = class(TModel)
  private
    FCNPJ: string;
    FEmail: string;
    FRazaoSocial: string;
    FEndereco: string;
    FTelefone: string;
    FNomeFantasia: string;
    procedure SetCNPJ(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetNomeFantasia(const Value: string);
    procedure SetRazaoSocial(const Value: string);
    procedure SetTelefone(const Value: string);
  public
    constructor Create; override;
    destructor Destroy; override;
    function ToStringModel: string; override;
    function Validate: Boolean; override;

    property RazaoSocial: string read FRazaoSocial write SetRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write SetNomeFantasia;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property Endereco: string read FEndereco write SetEndereco;
    property Telefone: string read FTelefone write SetTelefone;
    property Email: string read FEmail write SetEmail;
  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited;

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.SetCNPJ(const Value: string);
begin
  FCNPJ := UpperCase(Value).Trim;
end;

procedure TCliente.SetEmail(const Value: string);
begin
  FEmail := UpperCase(Value).Trim;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := UpperCase(Value).Trim;
end;

procedure TCliente.SetNomeFantasia(const Value: string);
begin
  FNomeFantasia := UpperCase(Value).Trim;
end;

procedure TCliente.SetRazaoSocial(const Value: string);
begin
  FRazaoSocial := UpperCase(Value).Trim;
end;

procedure TCliente.SetTelefone(const Value: string);
begin
  FTelefone := UpperCase(Value).Trim;
end;

function TCliente.ToStringModel: string;
begin
  Result := EmptyStr;
end;

function TCliente.Validate: Boolean;
begin
  Result := True;
end;

end.

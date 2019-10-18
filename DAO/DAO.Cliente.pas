unit DAO.Cliente;

interface

uses
  Model, DAO, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils;

type
  TClienteDAO = class(TDAO)
    function StringInsert: string; override;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); override;
    function CreateModel: TModel; override;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; override;
  end;

implementation

uses
  Model.Cliente;

{ TClienteDAO }

function TClienteDAO.CreateModel: TModel;
begin
  Result := TCliente.Create;
end;

function TClienteDAO.SetModelByDataSet(AFDQuery: TFDQuery): TModel;
begin
  Result := inherited;
  with TCliente(Result), AFDQuery do
  begin
    RazaoSocial := FieldByName('RazaoSocial').AsString;
    NomeFantasia := FieldByName('NomeFantasia').AsString;
    CNPJ := FieldByName('CNPJ').AsString;
    Endereco := FieldByName('Endereco').AsString;
    Telefone := FieldByName('Telefone').AsString;
    Email := FieldByName('Email').AsString;
  end;
end;

procedure TClienteDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;
  with AFDQuery, TCliente(AModel) do
  begin
    ParamByName('RazaoSocial').AsString := RazaoSocial;
    ParamByName('NomeFantasia').AsString := NomeFantasia;
    ParamByName('CNPJ').AsString := CNPJ;
    ParamByName('Endereco').AsString := Endereco;
    ParamByName('Telefone').AsString := Telefone;
    ParamByName('Email').AsString := Email;
  end;
end;

function TClienteDAO.StringInsert: string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    SB.Append('UPDATE OR INSERT INTO Cliente ( ').
         Append('ID, RazaoSocial, NomeFantasia, CNPJ, ').
         Append('Endereco, Telefone, Email, UpdatedAt) ').
       Append('VALUES( ').
         Append(':ID, :RazaoSocial, :NomeFantasia, :CNPJ, ').
         Append(':Endereco, :Telefone, :Email, CURRENT_TIMESTAMP) ').
       Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.

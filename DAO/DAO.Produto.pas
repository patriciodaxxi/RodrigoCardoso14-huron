unit DAO.Produto;

interface

uses
  Model, DAO, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils;

type
  TProdutoDAO = class(TDAO)
    function StringInsert: string; override;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); override;
    function CreateModel: TModel; override;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; override;
  end;

implementation

uses
  Model.Produto;

{ TProdutoDAO }

function TProdutoDAO.CreateModel: TModel;
begin
  Result := TProduto.Create;
end;

function TProdutoDAO.SetModelByDataSet(AFDQuery: TFDQuery): TModel;
begin
  Result := inherited;
  with TProduto(Result), AFDQuery do
  begin
    Descricao := FieldByName('Descricao').AsString;
    Custo := FieldByName('Custo').AsFloat;
    PrecoVenda := FieldByName('PrecoVenda').AsFloat;
  end;
end;

procedure TProdutoDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;
  with AFDQuery, TProduto(AModel) do
  begin
    ParamByName('Descricao').AsString := Descricao;
    ParamByName('Custo').AsFloat := Custo;
    ParamByName('PrecoVenda').AsFloat := PrecoVenda;
  end;
end;

function TProdutoDAO.StringInsert: string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    SB.Append('UPDATE OR INSERT INTO Produto ( ').
         Append('ID, Descricao, Custo, ').
         Append('PrecoVenda) ').
       Append('VALUES( ').
         Append(':ID, :Descricao, :Custo, ').
         Append(':PrecoVenda) ').
       Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.

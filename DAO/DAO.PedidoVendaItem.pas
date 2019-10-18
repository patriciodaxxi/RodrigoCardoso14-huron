unit DAO.PedidoVendaItem;

interface

uses
  Model, DAO, FireDAC.Comp.Client;

type
  TPedidoVendaItemDAO = class(TDAO)
  public
    function StringDelete: string; override;
    function StringInsert: string; override;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); override;
    function CreateModel: TModel; override;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; override;

    procedure SaveList(const AModel: TModel);
  end;

implementation

uses
  Model.Produto, DAO.Produto, SysUtils, Model.Item, Singleton.Connection,
  Model.PedidoVenda;

{ TPedidoVendaItem }

function TPedidoVendaItemDAO.CreateModel: TModel;
begin
  Result := TItem.Create;
end;

procedure TPedidoVendaItemDAO.SaveList(const AModel: TModel);
var
  I: Integer;
  LItem: TItem;
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;

    Delete(AModel);

    FDQuery.Close;
    FDQuery.SQL.Text := StringInsert;
    FDQuery.Params.ArraySize := TPedidoVenda(AModel).ListItem.Count;

    I := 0;
    for LItem in TPedidoVenda(AModel).ListItem do
    begin
      FDQuery.ParamByName('ID').AsIntegers[I] := GenerateID;
      FDQuery.ParamByName('IDPedidoVenda').AsIntegers[I] := AModel.ID;
      FDQuery.ParamByName('IDProduto').AsIntegers[I] := LItem.Produto.ID;
      FDQuery.ParamByName('ValorVenda').AsFloats[I] := LItem.ValorVenda;
      FDQuery.ParamByName('Quantidade').AsFloats[I] := LItem.Quantidade;
      FDQuery.ParamByName('ValorTotal').AsFloats[I] := LItem.ValorTotal;
      FDQuery.ParamByName('Sequencia').AsIntegers[I] := I;
      Inc(I);
    end;

    FDQuery.Execute(TPedidoVenda(AModel).ListItem.Count, 0);
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TPedidoVendaItemDAO.SetModelByDataSet(AFDQuery: TFDQuery): TModel;
var
  LProdutoDAO: TProdutoDAO;
begin
  Result := inherited;
  LProdutoDAO := TProdutoDAO.Create;
  try
    with TItem(Result), AFDQuery do
    begin
      Produto := TProduto(LProdutoDAO.Find(FieldByName('IDProduto').AsInteger));
      ValorVenda := FieldByName('ValorVenda').AsFloat;
      Quantidade := FieldByName('Quantidade').AsFloat;
      ValorTotal := FieldByName('ValorTotal').AsFloat;
      Sequencia := FieldByName('Sequencia').AsInteger;
    end;
  finally
    FreeAndNil(LProdutoDAO);
  end;
end;

procedure TPedidoVendaItemDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;

end;

function TPedidoVendaItemDAO.StringDelete: string;
begin
  Result := 'DELETE FROM ' + Model.DataBaseObject.Table + ' WHERE IDPedidoVenda = :ID;';
end;

function TPedidoVendaItemDAO.StringInsert: string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    SB.Append('UPDATE OR INSERT INTO PedidoVendaItem ( ').
         Append('ID, IDPedidoVenda, IDProduto, Sequencia, ').
         Append('ValorVenda, Quantidade, ValorTotal) ').
       Append('VALUES( ').
         Append(':ID, :IDPedidoVenda, :IDProduto, :Sequencia, ').
         Append(':ValorVenda, :Quantidade, :ValorTotal) ').
       Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.

unit DAO;

interface

uses
  Model, FireDAC.Comp.Client, FireDAC.Stan.Param, Singleton.Connection, StrUtils;

type
  TDAO = class
  private
    FModel: TModel;
    procedure SetModel(const Value: TModel);
  public
    function StringInsert: string; virtual; abstract;
    function StringUpdate: string; virtual; abstract;
    function StringDelete: string; virtual;
    procedure Insert(const AModel: TModel); virtual;
    procedure Update(const AModel: TModel); virtual;
    procedure Delete(const AModel: TModel); virtual;

    property Model: TModel read FModel write SetModel;
  end;

implementation

{ TDAO }

procedure TDAO.Delete(const AModel: TModel);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Close;

    if not StringDelete.Trim.IsEmpty then
      FDQuery.SQL.Text := StringDelete
    else
      FDQuery.SQL.Text := 'DELETE FROM ' + Model.DataBaseObject.Table + ' WHERE ID = :ID;';

    FDQuery.ParamByName('ID').AsInteger := AModel.ID;
    FDQuery.Execute;
  finally
    FreeAndNil(FDQuery);
  end;
end;

procedure TDAO.Insert(const AModel: TModel);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
  try
    FDQuery .Close;
    FDQuery.SQL.Text := StringInsert;
    SetParameters(FDQuery, AModel);
    FDQuery.Open;

    AModel.ID := FDQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(FDQuery);
  end;
end;

procedure TDAO.SetModel(const Value: TModel);
begin
  FModel := Value;
end;

function TDAO.StringDelete: string;
begin
  Result := EmptyStr;
end;

procedure TDAO.Update(const AModel: TModel);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
  try
    FDQuery .Close;
    FDQuery.SQL.Text := StringUpdate;
    SetParameters(FDQuery, AModel);
    FDQuery.ExecSQL;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.

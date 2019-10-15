unit DAO;

interface

uses
  Model, FireDAC.Comp.Client, FireDAC.Stan.Param, Singleton.Connection, StrUtils,
  Generics.Collections, SysUtils, Data.DB;

type
  TDAO = class
  private
    FModel: TModel;
    procedure SetModel(const Value: TModel);
  public
    function CreateModel: TModel; virtual; abstract;
    function Find(const AID: Integer): TModel; overload;
    function Find(const ACondition: string = ''): TObjectList<TModel>; overload;
    function StringInsert: string; virtual; abstract;
    function StringUpdate: string; virtual; abstract;
    function StringDelete: string; virtual;
    procedure Insert(const AModel: TModel); virtual;
    procedure Update(const AModel: TModel); virtual;
    procedure Delete(const AModel: TModel); virtual;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); virtual;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; virtual;

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

function TDAO.Find(const ACondition: string): TObjectList<TModel>;
var
  FDQuery: TFDQuery;
begin
  Result := TObjectList<TModel>.Create;
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Close;
    FDQuery.SQL.Text := 'SELECT * FROM ' + Model.DataBaseObject.View + ' WHERE ' + ACondition + ' ORDER BY ID';
    FDQuery.Open;

    Result.Clear;
    while not FDQuery.Eof do
    begin
      Result.Add(SetModelByDataSet(FDQuery));
      FDQuery.Next;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TDAO.Find(const AID: Integer): TModel;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Close;
    FDQuery.SQL.Text := 'SELECT * FROM ' + Model.DataBaseObject.View + ' WHERE ID = :ID';
    FDQuery.ParamByName('ID').AsInteger := AID;
    FDQuery.Open;

    if (not FDQuery.IsEmpty) and (FDQuery.RecordCount = 1) then
    begin
      Result := SetModelByDataSet(FDQuery);
    end
    else
    begin
      Result := nil;
    end;
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

function TDAO.SetModelByDataSet(AFDQuery: TFDQuery): TModel;
begin
  Result := CreateModel;
  Result.ID := AFDQuery.FieldByName('ID').AsInteger;
end;

procedure TDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;
  if Assigned(AFDQuery.FindParam('ID')) then
    AFDQuery.ParamByName('ID').AsInteger := AModel.ID;

  if Assigned(AFDQuery.FindParam('CreatedAt')) then
    AFDQuery.ParamByName('CreatedAt').AsDateTime := AModel.CreatedAt;

  if Assigned(AFDQuery.FindParam('UpdatedAt')) then
    AFDQuery.ParamByName('UpdatedAt').AsDateTime := AModel.UpdatedAt;
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

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
    function CheckID(AID: Integer): Boolean;
    function GetNewID: Integer;
    procedure RefreshGenerator;
    function GetMaxID: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function CreateModel: TModel; virtual; abstract;
    function Find(const AID: Integer): TModel; overload;
    function Find(const ACondition: string = ''): TObjectList<TModel>; overload;
    function StringInsert: string; virtual; abstract;
    function StringDelete: string; virtual;
    procedure Save(const AModel: TModel); virtual;
    procedure Delete(const AModel: TModel); virtual;
    procedure SetParameters(var AFDQuery: TFDQuery; const AModel: TModel); virtual;
    function SetModelByDataSet(AFDQuery: TFDQuery): TModel; virtual;

    function GenerateID: Integer;
    property Model: TModel read FModel write SetModel;
  end;

implementation

{ TDAO }

constructor TDAO.Create;
begin
  Model := CreateModel;
end;

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

destructor TDAO.Destroy;
begin
  FreeAndNil(FModel);
end;

function TDAO.Find(const ACondition: string): TObjectList<TModel>;
var
  FDQuery: TFDQuery;
begin
  Result := TObjectList<TModel>.Create(False);
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Close;
    FDQuery.SQL.Text := 'SELECT * FROM ' + Model.DataBaseObject.View + ' WHERE ' + ACondition;
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

procedure TDAO.Save(const AModel: TModel);
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

  if Assigned(AFDQuery.Fields.FindField('CreatedAt')) then
    Result.CreatedAt := AFDQuery.FieldByName('CreatedAt').AsDateTime;

  if Assigned(AFDQuery.Fields.FindField('UpdatedAt')) then
    Result.UpdatedAt := AFDQuery.FieldByName('UpdatedAt').AsDateTime;
end;

procedure TDAO.SetParameters(var AFDQuery: TFDQuery; const AModel: TModel);
begin
  inherited;
  if Assigned(AFDQuery.FindParam('ID')) then
  begin
    if AModel.ID <= 0 then
    begin
      AModel.ID := GenerateID;
    end;
    AFDQuery.ParamByName('ID').AsInteger := AModel.ID;
  end;
end;

function TDAO.StringDelete: string;
begin
  Result := EmptyStr;
end;

function TDAO.GenerateID: Integer;
var
  LIDValido: Boolean;
begin
  repeat
    Result := GetNewID;
    LIDValido := CheckID(Result)
  until (LIDValido = False);
end;

function TDAO.GetNewID: Integer;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Open('SELECT GEN_ID(' + 'GEN_' + Model.DataBaseObject.Table + '_ID' + ', 1) FROM RDB$DATABASE; ');
    Result := FDQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TDAO.CheckID(AID: Integer): Boolean;
var
  FDQuery: TFDQuery;
begin
  Result := False;
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Open(Format('SELECT ID FROM %s where  ID = %d ', [Model.DataBaseObject.Table, AID]));
    if (FDQuery.Fields[0].AsInteger > 0) then
    begin
      RefreshGenerator;
      Result := True;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

procedure TDAO.RefreshGenerator;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Close;
    FDQuery.SQL.Text := ' SET Generator ' + 'GEN_' + Model.DataBaseObject.Table + '_ID TO ' + GetMaxID.ToString;
    FDQuery.ExecSQL;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TDAO.GetMaxID: Integer;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.FDConnection;
    FDQuery.Open('SELECT MAX(ID) FROM ' + Model.DataBaseObject.Table);
    Result := FDQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.

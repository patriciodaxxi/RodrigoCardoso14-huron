unit Model;

interface

type
  TDataBaseObject = class
  private
    FTable: string;
    FView: string;
    procedure SetTable(const Value: string);
    procedure SetView(const Value: string);
  public
    property Table: string read FTable write SetTable;
    property View: string read FView write SetView;
  end;


  TModel = class
  private
    FUpdatedAt: TDateTime;
    FCreatedAt: TDateTime;
    FID: Integer;
    FDataBaseObject: TDataBaseObject;
    procedure SetCreatedAt(const Value: TDateTime);
    procedure SetID(const Value: Integer);
    procedure SetUpdatedAt(const Value: TDateTime);
    procedure SetDataBaseObject(const Value: TDataBaseObject);
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Validate: Boolean; virtual;
    function ToStringModel: string; virtual; abstract;

    property ID: Integer read FID write SetID;
    property CreatedAt: TDateTime read FCreatedAt write SetCreatedAt;
    property UpdatedAt: TDateTime  read FUpdatedAt write SetUpdatedAt;
    property DataBaseObject: TDataBaseObject read FDataBaseObject write SetDataBaseObject;
  end;

implementation

{ TBaseModel }

constructor TModel.Create;
begin

end;

destructor TModel.Destroy;
begin

  inherited;
end;

procedure TModel.SetCreatedAt(const Value: TDateTime);
begin
  FCreatedAt := Value;
end;

procedure TModel.SetDataBaseObject(const Value: TDataBaseObject);
begin
  FDataBaseObject := Value;
end;

procedure TModel.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModel.SetUpdatedAt(const Value: TDateTime);
begin
  FUpdatedAt := Value;
end;

function TModel.Validate: Boolean;
begin
  Result := True;
end;

{ TDataBaseObject }

{ TDataBaseObject }

procedure TDataBaseObject.SetTable(const Value: string);
begin
  FTable := Value;
end;

procedure TDataBaseObject.SetView(const Value: string);
begin
  FView := Value;
end;

end.
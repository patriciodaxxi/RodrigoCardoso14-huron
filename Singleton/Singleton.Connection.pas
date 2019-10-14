unit Singleton.Connection;

interface

uses
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Stan.Intf, FireDAC.Comp.UI, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, FireDAC.Comp.Client, SysUtils, Forms;

type
  TConnectionSingleton = class
  strict private
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysPgDriverLink;
    constructor Create;
  private
    class var FInstance: TConnectionSingleton;
    procedure Free;
  public
    FDConnection: TFDConnection;
    class function GetInstance: TConnectionSingleton;
    class destructor Destroy;
  end;

implementation

constructor TConnectionSingleton.Create;
begin
  inherited;
  FDGUIxWaitCursor := TFDGUIxWaitCursor.Create(Application);
  FDPhysFBDriverLink := TFDPhysPgDriverLink.Create(Application);
  FDConnection := TFDConnection.Create(Application);

  FDConnection.LoginPrompt := False;
  FDConnection.DriverName := 'FB';
  FDConnection.ConnectionDefName := 'Huron';
  FDConnection.FetchOptions.Mode := FmAll;
  FDConnection.ResourceOptions.AutoReConnect := True;
  FDConnection.Connected := True;
end;

class destructor TConnectionSingleton.Destroy;
begin
  FInstance.Free;
  inherited;
end;

procedure TConnectionSingleton.Free;
begin
  if FInstance <> nil then
    inherited Free;
end;

class function TConnectionSingleton.GetInstance: TConnectionSingleton;
begin
  if not Assigned(FInstance) Then
    FInstance := Create;
  Result := FInstance;
end;

end.

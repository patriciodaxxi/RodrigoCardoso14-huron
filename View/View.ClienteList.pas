unit View.ClienteList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.TemplateList, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Menus,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, View.Cliente,
  Controller.Cliente, Util.Enum, View.Template;

type
  TClienteListView = class(TTemplateListView)
    procedure BTNPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
    procedure CreateController; override;
  end;

var
  ClienteListView: TClienteListView;

implementation

{$R *.dfm}

{ TTemplateListView1 }

procedure TClienteListView.BTNPesquisarClick(Sender: TObject);
begin
  inherited;
  FDQuery.Open('SELECT * FROM VWCliente');
end;

procedure TClienteListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TClienteController.Create;
end;

function TClienteListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TClienteView.Create(Self);
end;

end.

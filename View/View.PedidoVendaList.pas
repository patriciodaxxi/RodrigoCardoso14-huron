unit View.PedidoVendaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.TemplateList, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Menus,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Util.Enum,
  View.Template;

type
  TPedidoVendaListView = class(TTemplateListView)
    procedure BTNPesquisarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  private
  public
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
    procedure CreateController; override;
  end;

var
  PedidoVendaListView: TPedidoVendaListView;

implementation

uses
  Controller.PedidoVenda, View.PedidoVenda, Util.View;

{$R *.dfm}

procedure TPedidoVendaListView.BTNPesquisarClick(Sender: TObject);
begin
  inherited;
  FDQuery.Open('SELECT * FROM VWPedidoVenda');
end;

procedure TPedidoVendaListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TPedidoVendaController.Create;
end;

function TPedidoVendaListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TPedidoVendaView.Create(Self);
end;

procedure TPedidoVendaListView.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  TNumericField(DataSource.DataSet.FieldByName('ValorTotal')).DisplayFormat := '0.00';
end;

end.

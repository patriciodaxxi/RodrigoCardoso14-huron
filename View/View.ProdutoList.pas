unit View.ProdutoList;

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
  TProdutoListView = class(TTemplateListView)
    procedure BTNPesquisarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  private
  public
    procedure CreateController; override;
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
  end;

var
  ProdutoListView: TProdutoListView;

implementation

uses
  Controller.Produto, View.Produto, Util.View;

{$R *.dfm}

{ TProdutoListView }

procedure TProdutoListView.BTNPesquisarClick(Sender: TObject);
begin
  inherited;
  FDQuery.Open('SELECT * FROM VWProduto');
end;

procedure TProdutoListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TProdutoController.Create;
end;

function TProdutoListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TProdutoView.Create(Self);
end;

procedure TProdutoListView.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  TNumericField(DataSource.DataSet.FieldByName('Custo')).DisplayFormat := FormatoFloat;
  TNumericField(DataSource.DataSet.FieldByName('PrecoVenda')).DisplayFormat := FormatoFloat;
end;

end.

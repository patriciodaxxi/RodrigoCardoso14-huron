unit View.PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Template, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Model;

type
  TPedidoVendaView = class(TTemplateView)
    EDTCliente: TLabeledEdit;
    SGPedidoVendaItens: TStringGrid;
  private
  public
    procedure SetViewByModel(const AModel: TModel); override;
    procedure SetModelByView; override;
    function Validate: Boolean; override;
    procedure CreateController; override;
    procedure CleanModel; override;
  end;

var
  PedidoVendaView: TPedidoVendaView;

implementation

uses
  Model.PedidoVenda, Controller.PedidoVenda;

{$R *.dfm}

{ TPedidoVendaView }

procedure TPedidoVendaView.CleanModel;
begin
  inherited;
  Model := TPedidoVenda.Create;
end;

procedure TPedidoVendaView.CreateController;
begin
  inherited;
  Controller := TPedidoVendaController.Create;
end;

procedure TPedidoVendaView.SetModelByView;
begin
  inherited;
  with TPedidoVenda(Model) do
  begin
    Cliente.ID := EDTCliente.Tag;
    ValorTotal := 0;
    ListItem.Add(nil);
  end;
end;

procedure TPedidoVendaView.SetViewByModel(const AModel: TModel);
begin
  inherited;
  with TPedidoVenda(AModel) do
  begin
    EDTCliente.Text := Cliente.ID.ToString + ' - ' + Cliente.RazaoSocial;
    // LBLValorTotal.Caption
    // StringGrid  ListItem
  end;
end;

function TPedidoVendaView.Validate: Boolean;
begin
  Result := True;
end;

end.

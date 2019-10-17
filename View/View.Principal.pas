unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef,
  FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.ComCtrls;

type
  TPrincipalView = class(TForm)
    BTNCliente: TButton;
    Button1: TButton;
    StatusBar1: TStatusBar;
    BTNPedidoVenda: TButton;
    procedure BTNClienteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BTNPedidoVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalView: TPrincipalView;

implementation

uses
  View.ProdutoList, View.PedidoVendaList, View.ClienteList;

{$R *.dfm}

procedure TPrincipalView.BTNClienteClick(Sender: TObject);
begin
  ClienteListView := TClienteListView.Create(Self);
  try
    ClienteListView.ShowModal;
  finally
    FreeAndnil(ClienteListView);
  end;
end;

procedure TPrincipalView.BTNPedidoVendaClick(Sender: TObject);
begin
  PedidoVendaListView := TPedidoVendaListView.Create(Self);
  try
    PedidoVendaListView.ShowModal;
  finally
    FreeAndnil(PedidoVendaListView);
  end;
end;

procedure TPrincipalView.Button1Click(Sender: TObject);
begin
  ProdutoListView := TProdutoListView.Create(Self);
  try
    ProdutoListView.ShowModal;
  finally
    FreeAndnil(ProdutoListView);
  end;
end;

end.

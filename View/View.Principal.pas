unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef,
  FireDAC.Phys, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, Vcl.ComCtrls, Vcl.Menus;

type
  TPrincipalView = class(TForm)
    StatusBar1: TStatusBar;
    MMPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    MICliente: TMenuItem;
    MIProduto: TMenuItem;
    Movimentos1: TMenuItem;
    MIPedidoVenda: TMenuItem;
    procedure MIClienteClick(Sender: TObject);
    procedure MIProdutoClick(Sender: TObject);
    procedure MIPedidoVendaClick(Sender: TObject);
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

procedure TPrincipalView.MIClienteClick(Sender: TObject);
begin
  ClienteListView := TClienteListView.Create(Self);
  try
    ClienteListView.ShowModal;
  finally
    FreeAndNil(ClienteListView);
  end;
end;

procedure TPrincipalView.MIPedidoVendaClick(Sender: TObject);
begin
  PedidoVendaListView := TPedidoVendaListView.Create(Self);
  try
    PedidoVendaListView.ShowModal;
  finally
    FreeAndNil(PedidoVendaListView);
  end;
end;

procedure TPrincipalView.MIProdutoClick(Sender: TObject);
begin
  ProdutoListView := TProdutoListView.Create(Self);
  try
    ProdutoListView.ShowModal;
  finally
    FreeAndNil(ProdutoListView);
  end;
end;

end.

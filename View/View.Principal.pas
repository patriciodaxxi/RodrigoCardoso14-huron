unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, View.ClienteList, Singleton.Connection, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FBDef, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Stan.Intf, FireDAC.Comp.UI, Vcl.ComCtrls;

type
  TPrincipalView = class(TForm)
    BTNCliente: TButton;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure BTNClienteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalView: TPrincipalView;

implementation

uses
  View.ProdutoList;

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

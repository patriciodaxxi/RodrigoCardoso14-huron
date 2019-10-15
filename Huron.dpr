program Huron;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {PrincipalView},
  Model in 'Model\Model.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.PedidoVenda in 'Model\Model.PedidoVenda.pas',
  Model.Item in 'Model\Model.Item.pas',
  View.Template in 'View\View.Template.pas' {TemplateView},
  View.TemplateList in 'View\View.TemplateList.pas' {TemplateListView},
  Controller in 'Controller\Controller.pas',
  DAO in 'DAO\DAO.pas',
  Util.View in 'Util\Util.View.pas',
  Util.Enum in 'Util\Util.Enum.pas',
  DAO.Cliente in 'DAO\DAO.Cliente.pas',
  DAO.Produto in 'DAO\DAO.Produto.pas',
  DAO.PedidoVenda in 'DAO\DAO.PedidoVenda.pas',
  Controller.Cliente in 'Controller\Controller.Cliente.pas',
  Controller.Produto in 'Controller\Controller.Produto.pas',
  Controller.PedidoVenda in 'Controller\Controller.PedidoVenda.pas',
  Singleton.Connection in 'Singleton\Singleton.Connection.pas',
  View.Cliente in 'View\View.Cliente.pas' {ClienteView},
  View.ClienteList in 'View\View.ClienteList.pas' {TemplateListView1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalView, PrincipalView);
  Application.CreateForm(TClienteView, ClienteView);
  Application.CreateForm(TTemplateListView1, TemplateListView1);
  Application.Run;
end.

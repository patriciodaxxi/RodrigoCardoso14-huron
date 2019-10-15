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
  TTemplateListView1 = class(TTemplateListView)
  private
    { Private declarations }
  public
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
    procedure CreateController; override;
  end;

var
  TemplateListView1: TTemplateListView1;

implementation

{$R *.dfm}

{ TTemplateListView1 }

procedure TTemplateListView1.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TClienteController.Create;
end;

function TTemplateListView1.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TClienteView.Create(Self);
end;

end.

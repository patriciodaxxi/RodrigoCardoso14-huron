unit View.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Template, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Model;

type
  TProdutoView = class(TTemplateView)
    EDTDescricao: TLabeledEdit;
    EDTCusto: TLabeledEdit;
    EDTPrecoVenda: TLabeledEdit;
    procedure EDTPrecoVendaExit(Sender: TObject);
    procedure EDTCustoExit(Sender: TObject);
    procedure EDTCustoKeyPress(Sender: TObject; var Key: Char);
    procedure EDTPrecoVendaKeyPress(Sender: TObject; var Key: Char);
  private
  public
    procedure SetViewByModel(const AModel: TModel); override;
    procedure SetModelByView; override;
    function Validate: Boolean; override;
    procedure CreateController; override;
    procedure CleanModel; override;
  end;

var
  ProdutoView: TProdutoView;

implementation

uses
  Controller.Produto, Model.Produto, Util.View;

{$R *.dfm}

{ TProdutoView }

procedure TProdutoView.CleanModel;
begin
  inherited;
  Model := TProduto.Create;
end;

procedure TProdutoView.CreateController;
begin
  inherited;
  Controller := TProdutoController.Create;
end;

procedure TProdutoView.EDTCustoExit(Sender: TObject);
begin
  inherited;
  EDTCusto.Text := FormatFloat(FormatoFloat, StrToFloatDef(EDTCusto.Text, 0));
end;

procedure TProdutoView.EDTCustoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditFloatKeyPress(Sender, Key);
end;

procedure TProdutoView.EDTPrecoVendaExit(Sender: TObject);
begin
  inherited;
  EDTPrecoVenda.Text := FormatFloat(FormatoFloat, StrToFloatDef(EDTPrecoVenda.Text, 0));
end;

procedure TProdutoView.EDTPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditFloatKeyPress(Sender, Key);
end;

procedure TProdutoView.SetModelByView;
begin
  inherited;
  with TProduto(Model) do
  begin
    Descricao := EDTDescricao.Text;
    Custo := StrToFloatDef(EDTCusto.Text, 0);
    PrecoVenda := StrToFloatDef(EDTPrecoVenda.Text, 0);
  end;
end;

procedure TProdutoView.SetViewByModel(const AModel: TModel);
begin
  inherited;
  with TProduto(AModel) do
  begin
    EDTDescricao.Text := Descricao;
    EDTCusto.Text := FormatFloat(FormatoFloat, Custo);
    EDTPrecoVenda.Text := FormatFloat(FormatoFloat, PrecoVenda);
  end;
end;

function TProdutoView.Validate: Boolean;
var
  LMensagem: string;
begin
  LMensagem := EmptyStr;
  Result := True;
  if Trim(EDTDescricao.Text).IsEmpty then
  begin
    LMensagem := 'Informe a Descrição';
    EDTDescricao.SetFocus;
    Result := False;
  end;

  if not LMensagem.Trim.IsEmpty then
  begin
    Application.MessageBox(PWideChar(LMensagem), 'Atenção', MB_OK + MB_ICONWARNING);
  end;
end;

end.

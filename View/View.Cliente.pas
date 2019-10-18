unit View.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Template, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask,
  Model.Cliente, Model, Controller.Cliente;

type
  TClienteView = class(TTemplateView)
    EDTRazaoSocial: TLabeledEdit;
    EDTNomeFantasia: TLabeledEdit;
    MSKCNPJ: TMaskEdit;
    EDTEndereco: TLabeledEdit;
    EDTEmail: TLabeledEdit;
    LBLCNPJ: TLabel;
    LBLTelefone: TLabel;
    MSKTelefone: TMaskEdit;
  private
  public
    procedure SetViewByModel(const AModel: TModel); override;
    procedure SetModelByView; override;
    function Validate: Boolean; override;
    procedure CreateController; override;
    procedure CleanModel; override;
  end;

var
  ClienteView: TClienteView;

implementation

uses
  Util.View;

{$R *.dfm}

{ TClienteView }

procedure TClienteView.CleanModel;
begin
  inherited;
  Model := TCliente.Create;
end;

procedure TClienteView.CreateController;
begin
  inherited;
  Controller := TClienteController.Create;
end;

procedure TClienteView.SetModelByView;
begin
  inherited;
  with TCliente(Model) do
  begin
    RazaoSocial := EDTRazaoSocial.Text;
    NomeFantasia := EDTNomeFantasia.Text;
    CNPJ := MSKCNPJ.Text;
    Endereco := EDTEndereco.Text;
    Telefone := MSKTelefone.Text;
    Email := EDTEmail.Text;
  end;
end;

procedure TClienteView.SetViewByModel(const AModel: TModel);
begin
  inherited;
  with TCliente(AModel) do
  begin
    EDTRazaoSocial.Text := RazaoSocial;
    EDTNomeFantasia.Text := NomeFantasia;
    MSKCNPJ.Text := CNPJ;
    EDTEndereco.Text := Endereco;
    MSKTelefone.Text := Telefone;
    EDTEmail.Text := Email;
  end;
end;

function TClienteView.Validate: Boolean;
var
  LMensagem: string;
begin
  LMensagem := EmptyStr;
  Result := True;
  if Trim(EDTRazaoSocial.Text).IsEmpty then
  begin
    LMensagem := 'Informe a Razão Social';
    EDTRazaoSocial.SetFocus;
    Result := False;
  end
  else if Trim(EDTNomeFantasia.Text).IsEmpty then
  begin
    LMensagem := 'Informe o Nome Fantasia';
    EDTNomeFantasia.SetFocus;
    Result := False;
  end
  else if Length(Trim(MSKCNPJ.Text)) <> 14 then
  begin
    LMensagem := 'CNPJ inválido';
    MSKCNPJ.SetFocus;
    Result := False;
  end
  else if Trim(EDTEndereco.Text).IsEmpty then
  begin
    LMensagem := 'Informe o Endereço';
    EDTEndereco.SetFocus;
    Result := False;
  end
  else if Trim(MSKTelefone.Text).IsEmpty then
  begin
    LMensagem := 'Informe o Telefone';
    MSKTelefone.SetFocus;
    Result := False;
  end
  else if not ValidarEMail(EDTEmail.Text) then
  begin
    LMensagem := 'Informe um E-mail válido';
    EDTEmail.SetFocus;
    Result := False;
  end;

  if not LMensagem.Trim.IsEmpty then
  begin
    Application.MessageBox(PWideChar(LMensagem), 'Atenção', MB_OK + MB_ICONWARNING);
  end;
end;

end.

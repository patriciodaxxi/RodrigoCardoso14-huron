unit View.Template;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Util.Enum, Model,
  Controller;

type
  TTemplateView = class(TForm)
    stat1: TStatusBar;
    Panel1: TPanel;
    BtnGravar: TBitBtn;
    BtnCancelar: TBitBtn;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FOperacao: TOperacao;
    FModel: TModel;
    FController: TController;
    procedure SetOperacao(const Value: TOperacao);
    procedure SetController(const Value: TController);
    procedure SetModel(const Value: TModel);
  public
    procedure PrepareView; virtual;
    procedure SetViewByModel(const AModel: TModel); virtual; abstract;
    procedure SetModelByView; virtual;
    procedure CreateController; virtual; abstract;
    function Validate: Boolean; virtual; abstract;
    procedure CleanModel; virtual;

    property Operacao: TOperacao read FOperacao write SetOperacao;
    property Model: TModel read FModel write SetModel;
    property Controller: TController read FController write SetController;
  end;

var
  TemplateView: TTemplateView;

implementation

uses
  Util.View;

{$R *.dfm}

procedure TTemplateView.BtnCancelarClick(Sender: TObject);
begin
  case Operacao of
    oCreate: LimparCampos(Self);
    oRead: Close;
    oUpdate: SetViewByModel(Model);
  end;
end;

procedure TTemplateView.BtnGravarClick(Sender: TObject);
var
  LMensagem: string;
begin
  if Operacao = oRead then
  begin
    Close;
  end
  else
  begin
    if Validate then
    begin
      if Operacao in [oCreate, oUpdate] then
      begin
        SetModelByView;
      end;

      if Controller.Transaction(Operacao, Model, LMensagem) then
      begin
        Close;
      end
      else
      begin
        Application.MessageBox(PWideChar(LMensagem), 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;
  end;
end;

procedure TTemplateView.CleanModel;
begin
  if Assigned(FModel) then
    FreeAndNil(FModel);
end;

procedure TTemplateView.FormCreate(Sender: TObject);
begin
  CreateController;
end;

procedure TTemplateView.FormDestroy(Sender: TObject);
begin
  if Assigned(FController) then
    FreeAndNil(FController);
end;

procedure TTemplateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Perform(WM_NEXTDLGCTL, 1, 0);
end;

procedure TTemplateView.PrepareView;
begin
  case Operacao of
    oCreate:
      begin
        BtnGravar.Caption := 'Gravar';
        BtnCancelar.Caption := 'Limpar';
      end;

    oRead:
      begin
        BtnGravar.Caption := 'OK';
        BtnCancelar.Caption := 'Sair';
      end;

    oUpdate:
      begin
        BtnGravar.Caption := 'Alterar';
        BtnCancelar.Caption := 'Cancelar'
      end;

    oDelete:
      begin
        BtnGravar.Caption := 'Excluir';
        BtnCancelar.Caption := 'Cancelar'
      end;
  end;
end;

procedure TTemplateView.SetController(const Value: TController);
begin
  FController := Value;
end;

procedure TTemplateView.SetModel(const Value: TModel);
begin
  FModel := Value;
end;

procedure TTemplateView.SetModelByView;
begin
  if Operacao = oCreate then
    CleanModel;
end;

procedure TTemplateView.SetOperacao(const Value: TOperacao);
begin
  FOperacao := Value;
end;

end.

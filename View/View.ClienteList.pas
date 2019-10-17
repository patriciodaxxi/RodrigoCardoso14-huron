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
  Controller.Cliente, Util.Enum, View.Template, Vcl.Mask, Model;

type
  TClienteListView = class(TTemplateListView)
    LBLID: TLabel;
    LBLNomeFantasia: TLabel;
    LBLCNPJ: TLabel;
    EDTID: TEdit;
    EDTNomeFantasia: TEdit;
    MSKCNPJ: TMaskEdit;
    EDTRazaoSocial: TEdit;
    LBLRazaoSocial: TLabel;
    procedure BTNPesquisarClick(Sender: TObject);
  private
  public
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
    procedure CreateController; override;
    function Search(const ACondition: string): TModel; override;
  end;

var
  ClienteListView: TClienteListView;

implementation

{$R *.dfm}

{ TTemplateListView1 }

procedure TClienteListView.BTNPesquisarClick(Sender: TObject);
var
  SB: TStringBuilder;
begin
  inherited;
  SB := TStringBuilder.Create;
  try
    SB.Append('SELECT * ').
       Append('FROM ').Append(Controller.Model.DataBaseObject.View).
       Append(' WHERE 1 = 1 ');

    if StrToIntDef(EDTID.Text, 0) > 0 then
    begin
      SB.Append(' AND ID = ').Append(EDTID.Text);
    end;

    if not Trim(EDTRazaoSocial.Text).IsEmpty then
    begin
      SB.Append(' AND RazaoSocial LIKE ').Append(QuotedStr(Trim('%' + EDTRazaoSocial.Text + '%')));
    end;

    if not Trim(EDTNomeFantasia.Text).IsEmpty then
    begin
      SB.Append(' AND NomeFantasia LIKE ').Append(QuotedStr(Trim('%' + EDTNomeFantasia.Text + '%')));
    end;

    if not Trim(MSKCNPJ.Text).IsEmpty then
    begin
      SB.Append(' AND CNPJ LIKE ').Append(QuotedStr('%' + Trim(MSKCNPJ.Text) + '%'));
    end;

    SB.Append(' ORDER BY ID ');

    FDQuery.Open(SB.ToString);
  finally
    FreeAndNil(SB);
  end;
end;

procedure TClienteListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TClienteController.Create;
end;

function TClienteListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TClienteView.Create(Self);
end;

function TClienteListView.Search(const ACondition: string): TModel;
var
  LValue: Integer;
begin
  Result := nil;

  if not ACondition.Trim.IsEmpty then
  begin
    if TryStrToInt(ACondition, LValue) then
    begin
      ClienteListView.EDTID.Text := LValue.ToString;
    end
    else
    begin
      ClienteListView.EDTRazaoSocial.Text := ACondition;
    end;
  end;

  ClienteListView.BTNPesquisar.OnClick(nil);
  if (DataSource.DataSet.Active) and (DataSource.DataSet.RecordCount = 1) then
  begin
    IDReturnSearch := DataSource.DataSet.FieldByName('ID').AsInteger;
  end
  else
  begin
    ClienteListView.ModoViewList := mvlSearch;
    ClienteListView.ShowModal;
  end;

  if IDReturnSearch > 0 then
  begin
    Result := Controller.DAO.Find(IDReturnSearch);
  end;
end;

end.

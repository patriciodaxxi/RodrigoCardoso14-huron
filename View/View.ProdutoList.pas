unit View.ProdutoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.TemplateList, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Menus,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Util.Enum,
  View.Template, Model;

type
  TProdutoListView = class(TTemplateListView)
    LBLID: TLabel;
    LBLCusto: TLabel;
    EDTID: TEdit;
    EDTCusto: TEdit;
    EDTDescricao: TEdit;
    LBLDescricao: TLabel;
    EDTPrecoVenda: TEdit;
    LBLPrecoVenda: TLabel;
    procedure BTNPesquisarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure EDTCustoExit(Sender: TObject);
    procedure EDTPrecoVendaExit(Sender: TObject);
    procedure EDTPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure EDTCustoKeyPress(Sender: TObject; var Key: Char);
  private
  public
    procedure CreateController; override;
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;

    function Search(const ACondition: string = ''): TModel; override;
  end;

var
  ProdutoListView: TProdutoListView;

implementation

uses
  Controller.Produto, View.Produto, Util.View;

{$R *.dfm}

{ TProdutoListView }

procedure TProdutoListView.BTNPesquisarClick(Sender: TObject);
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

    if not Trim(EDTDescricao.Text).IsEmpty then
    begin
      SB.Append(' AND Descricao LIKE ').Append(QuotedStr(Trim('%' + EDTDescricao.Text + '%')));
    end;

    if StrToFloatDef(EDTCusto.Text, 0) > 0 then
    begin
      SB.Append(' AND Custo = ').Append(EDTCusto.Text);
    end;

    if StrToFloatDef(EDTPrecoVenda.Text, 0) > 0 then
    begin
      SB.Append(' AND PrecoVenda = ').Append(EDTPrecoVenda.Text);
    end;

    SB.Append(' ORDER BY ID ');

    FDQuery.Open(SB.ToString);
  finally
    FreeAndNil(SB);
  end;
end;

procedure TProdutoListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TProdutoController.Create;
end;

function TProdutoListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TProdutoView.Create(Self);
end;

procedure TProdutoListView.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  TNumericField(DataSource.DataSet.FieldByName('Custo')).DisplayFormat := FormatoFloat;
  TNumericField(DataSource.DataSet.FieldByName('PrecoVenda')).DisplayFormat := FormatoFloat;
end;

procedure TProdutoListView.EDTCustoExit(Sender: TObject);
begin
  inherited;
  if not Trim(EDTCusto.Text).IsEmpty then
    EDTCusto.Text := FormatFloat(FormatoFloat, StrToFloatDef(EDTCusto.Text, 0));
end;

procedure TProdutoListView.EDTCustoKeyPress(Sender: TObject; var Key: Char);
begin
  EditFloatKeyPress(Sender, Key);
end;

procedure TProdutoListView.EDTPrecoVendaExit(Sender: TObject);
begin
  inherited;
  if not Trim(EDTPrecoVenda.Text).IsEmpty then
  begin
    EDTPrecoVenda.Text := FormatFloat('0.00', StrToFloatDef(EDTPrecoVenda.Text, 0));
  end;
end;

procedure TProdutoListView.EDTPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  EditFloatKeyPress(Sender, Key);
end;

function TProdutoListView.Search(const ACondition: string): TModel;
var
  LValue: Integer;
begin
  Result := nil;

  if not ACondition.Trim.IsEmpty then
  begin
    if TryStrToInt(ACondition, LValue) then
    begin
      ProdutoListView.EDTID.Text := LValue.ToString;
    end
    else
    begin
      ProdutoListView.EDTDescricao.Text := ACondition;
    end;
  end;

  ProdutoListView.BTNPesquisar.OnClick(nil);
  if (DataSource.DataSet.Active) and (DataSource.DataSet.RecordCount = 1) then
  begin
    IDReturnSearch := DataSource.DataSet.FieldByName('ID').AsInteger;
  end
  else
  begin
    ProdutoListView.ModoViewList := mvlSearch;
    ProdutoListView.ShowModal;
  end;

  if IDReturnSearch > 0 then
  begin
    Result := Controller.DAO.Find(IDReturnSearch);
  end;
end;

end.

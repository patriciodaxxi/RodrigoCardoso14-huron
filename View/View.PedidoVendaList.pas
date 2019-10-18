unit View.PedidoVendaList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.TemplateList, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Menus,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Util.Enum,
  View.Template, Vcl.Mask, frxClass, frxDBSet;

type
  TPedidoVendaListView = class(TTemplateListView)
    LBLID: TLabel;
    LBLNomeFantasia: TLabel;
    EDTID: TEdit;
    EDTValorTotal: TEdit;
    EDTRazaoSocial: TEdit;
    LBLRazaoSocial: TLabel;
    MIImprimir: TMenuItem;
    BTNImprimir: TButton;
    FRXPedidoVenda: TfrxReport;
    FRXDBPedidoVenda: TfrxDBDataset;
    FDPedidoVenda: TFDQuery;
    FDPedidoVendaItem: TFDQuery;
    FRXDBPedidoVendaItem: TfrxDBDataset;
    procedure BTNPesquisarClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure EDTValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure EDTValorTotalExit(Sender: TObject);
    procedure BTNImprimirClick(Sender: TObject);
    procedure MIImprimirClick(Sender: TObject);
  private
  public
    function CreateViewTemplate(AOperacao: TOperacao): TTemplateView; override;
    procedure CreateController; override;
    procedure Imprimir;
  end;

var
  PedidoVendaListView: TPedidoVendaListView;

implementation

uses
  Controller.PedidoVenda, View.PedidoVenda, Util.View;

{$R *.dfm}

procedure TPedidoVendaListView.BTNImprimirClick(Sender: TObject);
begin
  inherited;
  Imprimir;
end;

procedure TPedidoVendaListView.BTNPesquisarClick(Sender: TObject);
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

    if StrToFloatDef(EDTValorTotal.Text, 0) > 0 then
    begin
      SB.Append(' AND ValorTotal = ').Append(EDTValorTotal.Text);
    end;

    SB.Append(' ORDER BY ID ');

    FDQuery.Open(SB.ToString);
  finally
    FreeAndNil(SB);
  end;
end;

procedure TPedidoVendaListView.CreateController;
begin
  inherited;
  if not Assigned(Controller) then
    Controller := TPedidoVendaController.Create;
end;

function TPedidoVendaListView.CreateViewTemplate(AOperacao: TOperacao): TTemplateView;
begin
  Result := TPedidoVendaView.Create(Self);
end;

procedure TPedidoVendaListView.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  TNumericField(DataSource.DataSet.FieldByName('ValorTotal')).DisplayFormat := '###,##0.00';
end;

procedure TPedidoVendaListView.EDTValorTotalExit(Sender: TObject);
begin
  inherited;
  if not Trim(EDTValorTotal.Text).IsEmpty then
    EDTValorTotal.Text := FormatFloat(FormatoFloat, StrToFloatDef(EDTValorTotal.Text, 0));
end;

procedure TPedidoVendaListView.EDTValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditFloatKeyPress(Sender, Key);
end;

procedure TPedidoVendaListView.Imprimir;
begin
  try
    try
      if (DataSource.DataSet.Active) and (not DataSource.DataSet.IsEmpty) then
      begin
        FDPedidoVenda.Close;
        FDPedidoVenda.SQL.Text := 'SELECT * FROM VWPedidoVendaPrint WHERE ID = :ID; ';
        FDPedidoVenda.ParamByName('ID').AsInteger := FDQuery.FieldByName('ID').AsInteger;
        FDPedidoVenda.Open;

        FDPedidoVendaItem.Close;
        FDPedidoVendaItem.SQL.Text := 'SELECT * FROM VWPedidoVendaItem WHERE IDPedidoVenda = :ID; ';
        FDPedidoVendaItem.ParamByName('ID').AsInteger := FDQuery.FieldByName('ID').AsInteger;
        FDPedidoVendaItem.Open;

        with FRXPedidoVenda do
        begin
          Clear;
          LoadFromFile(ExtractFilePath(Application.ExeName) + '..\..\Report\PedidoVenda.fr3');
          PrepareReport(True);
          ReportOptions.Name := 'Visualização de Impressão: Pedido de Venda';
          ShowReport(True);
        end;
      end;
    except
      on E: Exception do
      begin
        Application.MessageBox(PWideChar('Erro ao imprimir Pedido de Venda. Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;
  finally

  end;
end;

procedure TPedidoVendaListView.MIImprimirClick(Sender: TObject);
begin
  inherited;
  Imprimir;
end;

end.

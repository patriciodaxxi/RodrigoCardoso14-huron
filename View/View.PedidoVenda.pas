unit View.PedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  View.Template, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Model;

type
  TPedidoVendaView = class(TTemplateView)
    EDTCliente: TLabeledEdit;
    SGPedidoVendaItens: TStringGrid;
    LBLValorTotalRotulo: TLabel;
    LBLValorTotal: TLabel;
    LBLPesquisarCliente: TLabel;
    Label1: TLabel;
    LBLRemoverProduto: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SGPedidoVendaItensDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure EDTClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SGPedidoVendaItensKeyPress(Sender: TObject; var Key: Char);
    procedure SGPedidoVendaItensSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure SGPedidoVendaItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Colunas: TStringList;
    const COLOBJECT: Integer = 0;
  public
    procedure SetViewByModel(const AModel: TModel); override;
    procedure SetModelByView; override;
    function Validate: Boolean; override;
    procedure CreateController; override;
    procedure CleanModel; override;

    procedure PrepareStringGrid;
    function VerificarProduto(const ARow: Integer): Boolean;
  end;

var
  PedidoVendaView: TPedidoVendaView;

implementation

uses
  Model.PedidoVenda, Controller.PedidoVenda, View.ProdutoList, Model.Produto,
  View.ClienteList, Model.Cliente, Util.View, Model.Item;

{$R *.dfm}

{ TPedidoVendaView }

procedure TPedidoVendaView.CleanModel;
begin
  inherited;
  Model := TPedidoVenda.Create;
end;

procedure TPedidoVendaView.CreateController;
begin
  inherited;
  Controller := TPedidoVendaController.Create;
end;

procedure TPedidoVendaView.EDTClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LModel: TModel;
begin
  if Key = VK_F9 then
  begin
    ClienteListView := TClienteListView.Create(Self);
    try
      try
        LModel := ClienteListView.Search(EDTCliente.Text);
        if Assigned(LModel) then
        begin
          EDTCliente.Text := TCliente(LModel).ID.ToString + ' - ' + TCliente(LModel).RazaoSocial;
          EDTCliente.Tag := TCliente(LModel).ID;
        end;
      except
        on E: Exception do
        begin
          Application.MessageBox(PWideChar('Erro ao Buscar Produto! Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
        end;
      end;
    finally
      FreeAndNil(ClienteListView);
    end;
  end;
end;

procedure TPedidoVendaView.FormCreate(Sender: TObject);
begin
  inherited;
  Colunas := TStringList.Create;
end;

procedure TPedidoVendaView.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Colunas);
end;

procedure TPedidoVendaView.FormShow(Sender: TObject);
begin
  inherited;
  PrepareStringGrid;
end;

procedure TPedidoVendaView.PrepareStringGrid;
begin
  Colunas.Add('Produto');
  Colunas.Add('Quantidade');
  Colunas.Add('ValorVenda');
  Colunas.Add('ValorTotal');

  with SGPedidoVendaItens do
  begin
    ColCount := 4;
    RowCount := 2;
    FixedCols := 0;
    FixedRows := 1;
    Cells[Colunas.IndexOf('Produto'), 0] := 'Produto';
    Cells[Colunas.IndexOf('Quantidade'), 0] := 'Quantidade';
    Cells[Colunas.IndexOf('ValorVenda'), 0] := 'Valor';
    Cells[Colunas.IndexOf('ValorTotal'), 0] := 'Total';
    ColWidths[Colunas.IndexOf('Produto')] := 400;
    ColWidths[Colunas.IndexOf('Quantidade')] := 100;
    ColWidths[Colunas.IndexOf('ValorVenda')] := 100;
    ColWidths[Colunas.IndexOf('ValorTotal')] := 100;
  end;
end;

procedure TPedidoVendaView.SetModelByView;
var
  I: Integer;
begin
  inherited;
  with TPedidoVenda(Model) do
  begin
    Cliente.ID := EDTCliente.Tag;
    ValorTotal := 0;
    with SGPedidoVendaItens do
    begin
      for I := FixedRows to Pred(RowCount) do
      begin
        if VerifyObject(COLOBJECT, I) then
        begin
          if Assigned(TItem(Objects[COLOBJECT, I]).Produto) then
          begin
            if TItem(Objects[COLOBJECT, I]).Produto.ID > 0 then
            begin
              ListItem.Add(TItem(Objects[COLOBJECT, I]));
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TPedidoVendaView.SetViewByModel(const AModel: TModel);
var
  LRow: Integer;
  LItem: TItem;
begin
  inherited;
  with TPedidoVenda(AModel) do
  begin
    EDTCliente.Text := Cliente.ID.ToString + ' - ' + Cliente.RazaoSocial;
    EDTCliente.Tag := Cliente.ID;
    LBLValorTotal.Caption := FormatFloat('0.00', ValorTotal);

    LRow := 1;
    for LItem in ListItem do
    begin
      with SGPedidoVendaItens do
      begin
        if LRow > Pred(RowCount) then
          RowCount := RowCount + 1;
        Objects[COLOBJECT, LRow] := LItem;
        Cells[Colunas.IndexOf('Produto'), LRow] := LItem.Produto.ID.ToString + ' - ' + LItem.Produto.Descricao;
        Cells[Colunas.IndexOf('Quantidade'), LRow] := FormatFloat(FormatoFloat, LItem.Quantidade);
        Cells[Colunas.IndexOf('ValorVenda'), LRow] := FormatFloat(FormatoFloat, LItem.ValorVenda);
        Cells[Colunas.IndexOf('ValorTotal'), LRow] := FormatFloat('0.00', LItem.ValorTotal);
      end;
      Inc(LRow);
    end;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  with SGPedidoVendaItens do
  begin
    if (ARow <= FixedRows - 1) then
    begin
      Brush.Style := (bsSolid);
      Canvas.Font.Style := [fsBold];
      {Canvas.Rectangle(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.right,Rect.Top, Cells[ACol, ARow]);}
    end;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LModel: TModel;
begin
  inherited;
  if Key = VK_F9 then
  begin
    if not VerificarProduto(SGPedidoVendaItens.Row) then
    begin
      ProdutoListView := TProdutoListView.Create(Self);
      try
        try
          LModel := ProdutoListView.Search(SGPedidoVendaItens.Cells[Colunas.IndexOf('Produto'), SGPedidoVendaItens.Row]);
          if Assigned(LModel) then
          begin
            SGPedidoVendaItens.Rows[SGPedidoVendaItens.Row].Clear;
            SGPedidoVendaItens.Cells[Colunas.IndexOf('Produto'), SGPedidoVendaItens.Row] := TProduto(LModel).ID.ToString + ' - ' + TProduto(LModel).Descricao;
            SGPedidoVendaItens.Cells[Colunas.IndexOf('Quantidade'), SGPedidoVendaItens.Row] := FormatFloat(FormatoFloat, 1);
            SGPedidoVendaItens.Cells[Colunas.IndexOf('ValorVenda'), SGPedidoVendaItens.Row] := FormatFloat(FormatoFloat, TProduto(LModel).PrecoVenda);
            SGPedidoVendaItens.Cells[Colunas.IndexOf('ValorTotal'), SGPedidoVendaItens.Row] := FormatFloat('0.00', TProduto(LModel).PrecoVenda);

            SGPedidoVendaItens.Objects[COLOBJECT, SGPedidoVendaItens.Row] := TItem.Create;
            TItem(SGPedidoVendaItens.Objects[COLOBJECT, SGPedidoVendaItens.Row]).Produto := TProduto(LModel);
          end;
        except
          on E: Exception do
          begin
            Application.MessageBox(PWideChar('Erro ao Buscar Produto! Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
          end;
        end;
      finally
        FreeAndNil(ProdutoListView);
      end;
    end;
  end;

  if Key = VK_DOWN then
  begin
    if (SGPedidoVendaItens.Row = Pred(SGPedidoVendaItens.RowCount)) and VerificarProduto(SGPedidoVendaItens.Row) then
      SGPedidoVendaItens.RowCount := SGPedidoVendaItens.RowCount + 1;
  end;

  if Key = VK_DELETE then
  begin
    if Shift = [ssCtrl] then
    begin
      SGPedidoVendaItens.Rows[SGPedidoVendaItens.Row].Clear;
      SGPedidoVendaItens.Col := Colunas.IndexOf('Produto');
    end;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyUpperCase(Key);
end;

procedure TPedidoVendaView.SGPedidoVendaItensSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
var
  LValorTotal: Double;
begin
  inherited;
  with SGPedidoVendaItens do
  begin
    if ACol in [Colunas.IndexOf('Quantidade'), Colunas.IndexOf('ValorVenda')] then
    begin
      LValorTotal := StrToFloatDef(Cells[Colunas.IndexOf('Quantidade'), ARow], 0) * StrToFloatDef(Cells[Colunas.IndexOf('ValorVenda'), ARow], 0);
      Cells[Colunas.IndexOf('ValorTotal'), ARow] := FormatFloat('0.00', LValorTotal);
    end;
  end;
end;

function TPedidoVendaView.Validate: Boolean;
begin
  Result := True;
end;

function TPedidoVendaView.VerificarProduto(const ARow: Integer): Boolean;
begin
  with SGPedidoVendaItens do
  begin
    Result := VerifyObject(COLOBJECT, ARow) and Assigned(TItem(Objects[COLOBJECT, ARow]).Produto) and (TItem(Objects[COLOBJECT, ARow]).Produto.ID > 0);
  end;
end;

end.

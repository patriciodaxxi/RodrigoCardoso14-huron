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
    LBLQuantidadeItensRotulo: TLabel;
    LBLQuantidadeItens: TLabel;
    LBLDown: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SGPedidoVendaItensDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure EDTClienteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SGPedidoVendaItensKeyPress(Sender: TObject; var Key: Char);
    procedure SGPedidoVendaItensSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure SGPedidoVendaItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
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
    procedure TotalizarPedidoVenda;
    function VerificarProduto(const ARow: Integer): Boolean;
  end;

var
  PedidoVendaView: TPedidoVendaView;

implementation

uses
  Model.PedidoVenda, Controller.PedidoVenda, View.ProdutoList, Model.Produto,
  View.ClienteList, Model.Cliente, Util.View, Model.Item, Util.Enum;

{$R *.dfm}

{ TPedidoVendaView }

procedure TPedidoVendaView.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Operacao = oCreate then
  begin
    PrepareStringGrid;
  end;
end;

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
  PrepareStringGrid;
end;

procedure TPedidoVendaView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Colunas);
  inherited;
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
    ColWidths[Colunas.IndexOf('Quantidade')] := 120;
    ColWidths[Colunas.IndexOf('ValorVenda')] := 120;
    ColWidths[Colunas.IndexOf('ValorTotal')] := 120;
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
    ValorTotal := StrToFloatDef(LBLValorTotal.Caption, 0);
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
              TItem(Objects[COLOBJECT, I]).Quantidade := StrToFloatDef(Cells[Colunas.IndexOf('Quantidade'), I], 0);
              TItem(Objects[COLOBJECT, I]).ValorVenda := StrToFloatDef(Cells[Colunas.IndexOf('ValorVenda'), I], 0);
              TItem(Objects[COLOBJECT, I]).ValorTotal := StrToFloatDef(Cells[Colunas.IndexOf('Quantidade'), I], 0) * StrToFloatDef(Cells[Colunas.IndexOf('ValorVenda'), I], 0);
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
    SGPedidoVendaItens.RowCount := SGPedidoVendaItens.FixedRows + ListItem.Count;
    for LItem in ListItem do
    begin
      with SGPedidoVendaItens do
      begin
        Objects[COLOBJECT, LRow] := LItem;
        Cells[Colunas.IndexOf('Produto'), LRow] := LItem.Produto.ID.ToString + ' - ' + LItem.Produto.Descricao;
        Cells[Colunas.IndexOf('Quantidade'), LRow] := FormatFloat(FormatoFloat, LItem.Quantidade);
        Cells[Colunas.IndexOf('ValorVenda'), LRow] := FormatFloat(FormatoFloat, LItem.ValorVenda);
        Cells[Colunas.IndexOf('ValorTotal'), LRow] := FormatFloat('0.00', LItem.ValorTotal);
      end;
      Inc(LRow);
    end;
    TotalizarPedidoVenda;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  LText: string;
  X, Y: Integer;
begin
  inherited;
  LText := SGPedidoVendaItens.Cells[ACol, ARow];
  with SGPedidoVendaItens do
  begin
    if (ARow <= FixedRows - 1) then
    begin
      Brush.Style := (bsSolid);
      Canvas.Font.Style := [fsBold];
    end
    else
    begin
      if ACol in [Colunas.IndexOf('Quantidade'), Colunas.IndexOf('ValorVenda'), Colunas.IndexOf('ValorTotal')] then
      begin
        SGPedidoVendaItens.Canvas.FillRect(Rect);
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - Canvas.TextHeight(LText) div 2;
        X := Rect.Right - Canvas.TextWidth(LText) - 2;
        Canvas.TextRect(Rect, X, Y, LText);
      end;
    end;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LModel: TModel;
begin
  inherited;
  if Operacao in [oCreate, oUpdate] then
  begin
    if Key = VK_TAB then
    begin
      if (SGPedidoVendaItens.Col = Colunas.IndexOf('ValorTotal')) and (not VerificarProduto(SGPedidoVendaItens.Row)) then
      begin
        Perform(WM_NEXTDLGCTL, 0, 0)
      end;

      if VerificarProduto(SGPedidoVendaItens.Row) then
      begin
        if SGPedidoVendaItens.Col = Colunas.IndexOf('Quantidade') then
        begin
          SGPedidoVendaItens.Cells[Colunas.IndexOf('Quantidade'), SGPedidoVendaItens.Row] := FormatFloat(FormatoFloat, StrToFloatDef(SGPedidoVendaItens.Cells[Colunas.IndexOf('Quantidade'), SGPedidoVendaItens.Row], 0));
        end
        else if SGPedidoVendaItens.Col = Colunas.IndexOf('ValorVenda') then
        begin
          SGPedidoVendaItens.Cells[Colunas.IndexOf('ValorVenda'), SGPedidoVendaItens.Row] := FormatFloat(FormatoFloat, StrToFloatDef(SGPedidoVendaItens.Cells[Colunas.IndexOf('ValorVenda'), SGPedidoVendaItens.Row], 0));
        end;
      end;
    end;

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
      end
      else
      begin
        if SGPedidoVendaItens.Col = Colunas.IndexOf('ValorTotal') then
        begin
          Key := 0;
        end;
      end;
    end;
    TotalizarPedidoVenda;
  end;
end;

procedure TPedidoVendaView.SGPedidoVendaItensKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyUpperCase(Key);
  with SGPedidoVendaItens do
  begin
    if Col = Colunas.IndexOf('ValorTotal') then
    begin
      Key := #0;
    end;

    if Col in [Colunas.IndexOf('Quantidade'),
               Colunas.IndexOf('ValorVenda'),
               Colunas.IndexOf('ValorTotal')]
    then
    begin
      if Key <> #8  then
        DecimalOnly(Key, SGPedidoVendaItens);
    end;
  end;
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
  if Operacao in [oCreate, oUpdate] then
  begin
    TotalizarPedidoVenda;
  end;
end;

function TPedidoVendaView.Validate: Boolean;
var
  LMensagem: string;
begin
  LMensagem := EmptyStr;
  Result := True;

  if EDTCliente.Tag <= 0 then
  begin
    LMensagem := 'Informe o Cliente';
    EDTCliente.SetFocus;
    Result := False;
  end
  else if StrToIntDef(LBLQuantidadeItens.Caption, 0) = 0 then
  begin
    LMensagem := 'Informe os Produtos';
    SGPedidoVendaItens.SetFocus;
    Result := False;
  end;

  if not LMensagem.Trim.IsEmpty then
  begin
    Application.MessageBox(PWideChar(LMensagem), 'Atenção', MB_OK + MB_ICONWARNING);
  end;
end;

function TPedidoVendaView.VerificarProduto(const ARow: Integer): Boolean;
begin
  with SGPedidoVendaItens do
  begin
    Result := VerifyObject(COLOBJECT, ARow) and Assigned(TItem(Objects[COLOBJECT, ARow]).Produto) and (TItem(Objects[COLOBJECT, ARow]).Produto.ID > 0);
  end;
end;

procedure TPedidoVendaView.TotalizarPedidoVenda;
var
  I, LQuantidadeItens: Integer;
  LValorTotalPedidoVenda: Double;
begin
  LValorTotalPedidoVenda := 0;
  with SGPedidoVendaItens do
  begin
    LQuantidadeItens := 0;
    for I := FixedRows to Pred(RowCount) do
    begin
      if VerificarProduto(I) then
      begin
        Inc(LQuantidadeItens);
        LValorTotalPedidoVenda :=
          LValorTotalPedidoVenda +
          (StrToFloatDef(Cells[Colunas.IndexOf('Quantidade'), I], 0) * StrToFloatDef(Cells[Colunas.IndexOf('ValorVenda'), I], 0));
      end;
    end;
  end;
  LBLQuantidadeItens.Caption := LQuantidadeItens.ToString;
  LBLValorTotal.Caption := FormatFloat('0.00', LValorTotalPedidoVenda);
end;

end.

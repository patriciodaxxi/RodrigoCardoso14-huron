inherited ProdutoListView: TProdutoListView
  Caption = 'Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBGrid: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 473
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUSTO'
        Title.Caption = 'Custo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECOVENDA'
        Title.Caption = 'Pre'#231'o de Venda'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CREATEDAT'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'UPDATEDAT'
        Visible = False
      end>
  end
  inherited DataSource: TDataSource
    OnDataChange = DataSourceDataChange
  end
  inherited FDQuery: TFDQuery
    ConnectionName = 'Huron'
    SQL.Strings = (
      'SELECT * FROM VWPRODUTO')
  end
end

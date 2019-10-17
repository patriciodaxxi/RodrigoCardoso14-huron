inherited ClienteListView: TClienteListView
  Caption = 'Clientes'
  ExplicitWidth = 1131
  ExplicitHeight = 542
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBGrid: TDBGrid
    Font.Height = -13
    ParentFont = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAZAOSOCIAL'
        Title.Caption = 'Raz'#227'o Social'
        Width = 379
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEFANTASIA'
        Title.Caption = 'Nome Fantasia'
        Width = 253
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ'
        Width = 131
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDERECO'
        Title.Caption = 'Endereco'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Title.Caption = 'Telefone'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Caption = 'E-mail'
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
  inherited FDQuery: TFDQuery
    ConnectionName = 'Huron'
    SQL.Strings = (
      'SELECT * FROM VWCLIENTE')
  end
end

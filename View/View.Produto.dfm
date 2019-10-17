inherited ProdutoView: TProdutoView
  Caption = 'ProdutoView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    TabOrder = 4
  end
  object EDTDescricao: TLabeledEdit
    Left = 158
    Top = 144
    Width = 409
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Descri'#231#227'o:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 100
    TabOrder = 0
  end
  object EDTCusto: TLabeledEdit
    Left = 158
    Top = 194
    Width = 121
    Height = 21
    Alignment = taRightJustify
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = 'Custo:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 1
    Text = '0.00000'
    OnExit = EDTCustoExit
    OnKeyPress = EDTCustoKeyPress
  end
  object EDTPrecoVenda: TLabeledEdit
    Left = 158
    Top = 242
    Width = 121
    Height = 21
    Alignment = taRightJustify
    EditLabel.Width = 94
    EditLabel.Height = 13
    EditLabel.Caption = 'Pre'#231'o de Venda:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 2
    Text = '0.00000'
    OnExit = EDTPrecoVendaExit
    OnKeyPress = EDTPrecoVendaKeyPress
  end
end

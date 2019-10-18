inherited ProdutoView: TProdutoView
  Caption = 'Produto'
  ClientHeight = 366
  ClientWidth = 647
  ExplicitWidth = 663
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 13
  inherited stat1: TStatusBar
    Top = 338
    Width = 647
    Panels = <
      item
        Text = 'Criado em: 14/10/2019 10:10:10'
        Width = 200
      end
      item
        Text = 'Atualizado em: 14/10/2019 10:10:10'
        Width = 200
      end>
  end
  inherited Panel1: TPanel
    Top = 297
    Width = 647
    TabOrder = 4
    inherited BtnGravar: TBitBtn
      Left = 432
    end
    inherited BtnCancelar: TBitBtn
      Left = 538
    end
  end
  object EDTDescricao: TLabeledEdit
    Left = 158
    Top = 100
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
    Top = 150
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
    Top = 198
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

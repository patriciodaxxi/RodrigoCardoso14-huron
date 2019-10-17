inherited PedidoVendaView: TPedidoVendaView
  Caption = 'Pedido de Venda'
  ClientWidth = 788
  ExplicitWidth = 804
  PixelsPerInch = 96
  TextHeight = 13
  inherited stat1: TStatusBar
    Width = 788
  end
  inherited Panel1: TPanel
    Width = 788
    inherited BtnGravar: TBitBtn
      Left = 573
    end
    inherited BtnCancelar: TBitBtn
      Left = 679
    end
  end
  object EDTCliente: TLabeledEdit
    Left = 104
    Top = 56
    Width = 465
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Cliente:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 2
  end
  object SGPedidoVendaItens: TStringGrid
    Left = 24
    Top = 128
    Width = 755
    Height = 257
    TabOrder = 3
  end
end

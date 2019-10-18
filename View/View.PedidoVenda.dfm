inherited PedidoVendaView: TPedidoVendaView
  Caption = 'Pedido de Venda'
  ClientWidth = 788
  ExplicitWidth = 804
  PixelsPerInch = 96
  TextHeight = 13
  object LBLValorTotalRotulo: TLabel [0]
    Left = 593
    Top = 380
    Width = 65
    Height = 13
    Caption = 'Valor Total:'
  end
  object LBLValorTotal: TLabel [1]
    Left = 741
    Top = 376
    Width = 39
    Height = 18
    Alignment = taRightJustify
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LBLPesquisarCliente: TLabel [2]
    Left = 646
    Top = 26
    Width = 125
    Height = 13
    Caption = 'F9 - Pesquisar Cliente'
  end
  object Label1: TLabel [3]
    Left = 3
    Top = 380
    Width = 129
    Height = 13
    Caption = 'F9 - Pesquisar Produto'
  end
  object LBLRemoverProduto: TLabel [4]
    Left = 156
    Top = 380
    Width = 179
    Height = 13
    Caption = 'CTRL + Del - Remover Produto'
  end
  object LBLQuantidadeItensRotulo: TLabel [5]
    Left = 494
    Top = 380
    Width = 34
    Height = 13
    Caption = 'Itens:'
  end
  object LBLQuantidadeItens: TLabel [6]
    Left = 534
    Top = 380
    Width = 7
    Height = 13
    Caption = '0'
  end
  object LBLDown: TLabel [7]
    Left = 354
    Top = 380
    Width = 109
    Height = 13
    Caption = 'Down - Gerar linha'
  end
  inherited stat1: TStatusBar
    Width = 788
    Panels = <
      item
        Text = 'Criado em: 14/10/2019 10:10:10'
        Width = 200
      end
      item
        Text = 'Atualizado em: 14/10/2019 10:10:10'
        Width = 200
      end>
    ExplicitWidth = 788
  end
  inherited Panel1: TPanel
    Width = 788
    TabOrder = 3
    ExplicitWidth = 788
    inherited LBLID: TLabel
      Width = 9
      Caption = '0'
      ExplicitWidth = 9
    end
    inherited BtnGravar: TBitBtn
      Left = 573
      ExplicitLeft = 573
    end
    inherited BtnCancelar: TBitBtn
      Left = 679
      ExplicitLeft = 679
    end
  end
  object EDTCliente: TLabeledEdit
    Left = 104
    Top = 22
    Width = 537
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Cliente:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    TabOrder = 1
    OnKeyDown = EDTClienteKeyDown
  end
  object SGPedidoVendaItens: TStringGrid
    Left = 3
    Top = 64
    Width = 780
    Height = 305
    ColCount = 4
    Ctl3D = False
    DefaultRowHeight = 30
    DrawingStyle = gdsClassic
    FixedColor = clAppWorkSpace
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goTabs]
    ParentCtl3D = False
    TabOrder = 2
    OnDrawCell = SGPedidoVendaItensDrawCell
    OnKeyDown = SGPedidoVendaItensKeyDown
    OnKeyPress = SGPedidoVendaItensKeyPress
    OnSetEditText = SGPedidoVendaItensSetEditText
    ColWidths = (
      378
      109
      113
      103)
  end
end

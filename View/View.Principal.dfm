object PrincipalView: TPrincipalView
  Left = 0
  Top = 0
  Caption = 'Huron - Sistema de Pedido de Venda'
  ClientHeight = 351
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MMPrincipal
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 332
    Width = 686
    Height = 19
    Panels = <>
  end
  object MMPrincipal: TMainMenu
    Left = 256
    Top = 48
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object MICliente: TMenuItem
        Caption = 'Cliente'
        OnClick = MIClienteClick
      end
      object MIProduto: TMenuItem
        Caption = 'Produto'
        OnClick = MIProdutoClick
      end
    end
    object Movimentos1: TMenuItem
      Caption = 'Movimentos'
      object MIPedidoVenda: TMenuItem
        Caption = 'Pedido de Venda'
        OnClick = MIPedidoVendaClick
      end
    end
  end
end

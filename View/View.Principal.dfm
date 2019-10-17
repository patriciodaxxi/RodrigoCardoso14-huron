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
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object BTNCliente: TButton
    Left = 40
    Top = 56
    Width = 121
    Height = 97
    Caption = 'Cliente'
    TabOrder = 0
    OnClick = BTNClienteClick
  end
  object Button1: TButton
    Left = 192
    Top = 56
    Width = 129
    Height = 97
    Caption = 'Produto'
    TabOrder = 1
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 332
    Width = 686
    Height = 19
    Panels = <>
  end
  object BTNPedidoVenda: TButton
    Left = 360
    Top = 56
    Width = 129
    Height = 97
    Caption = 'Pedido de Venda'
    TabOrder = 3
    OnClick = BTNPedidoVendaClick
  end
end

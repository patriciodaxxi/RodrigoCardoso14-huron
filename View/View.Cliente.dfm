inherited ClienteView: TClienteView
  Caption = 'Cliente'
  ClientHeight = 435
  ClientWidth = 602
  ExplicitWidth = 618
  ExplicitHeight = 474
  PixelsPerInch = 96
  TextHeight = 13
  object LBLCNPJ: TLabel [0]
    Left = 151
    Top = 162
    Width = 34
    Height = 13
    Caption = 'CNPJ:'
  end
  object LBLTelefone: TLabel [1]
    Left = 132
    Top = 256
    Width = 53
    Height = 13
    Caption = 'Telefone:'
  end
  inherited stat1: TStatusBar
    Top = 407
    Width = 602
    Panels = <
      item
        Text = 'Criado em: 14/10/2019 10:10:10'
        Width = 200
      end
      item
        Text = 'Atualizado em: 14/10/2019 10:10:10'
        Width = 200
      end>
    ExplicitTop = 407
    ExplicitWidth = 602
  end
  inherited Panel1: TPanel
    Top = 366
    Width = 602
    TabOrder = 6
    ExplicitTop = 366
    ExplicitWidth = 602
    inherited BtnGravar: TBitBtn
      Left = 387
      ExplicitLeft = 387
    end
    inherited BtnCancelar: TBitBtn
      Left = 493
      ExplicitLeft = 493
    end
  end
  object EDTRazaoSocial: TLabeledEdit
    Left = 195
    Top = 69
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'Raz'#227'o Social:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 100
    TabOrder = 0
  end
  object EDTNomeFantasia: TLabeledEdit
    Left = 195
    Top = 113
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 92
    EditLabel.Height = 13
    EditLabel.Caption = ' Nome Fantasia:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 100
    TabOrder = 1
  end
  object MSKCNPJ: TMaskEdit
    Left = 195
    Top = 159
    Width = 302
    Height = 21
    CharCase = ecUpperCase
    EditMask = '99.999.999/9999-99;0;_'
    MaxLength = 18
    TabOrder = 2
    Text = ''
  end
  object EDTEndereco: TLabeledEdit
    Left = 195
    Top = 205
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'Endereco:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 100
    TabOrder = 3
  end
  object EDTEmail: TLabeledEdit
    Left = 195
    Top = 295
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'E-mail:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 50
    TabOrder = 5
  end
  object MSKTelefone: TMaskEdit
    Left = 195
    Top = 252
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 20
    TabOrder = 4
    Text = ''
  end
end

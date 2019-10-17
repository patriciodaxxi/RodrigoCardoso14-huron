inherited ClienteView: TClienteView
  Caption = 'Cliente'
  PixelsPerInch = 96
  TextHeight = 13
  object LBLCNPJ: TLabel [0]
    Left = 151
    Top = 173
    Width = 34
    Height = 13
    Caption = 'CNPJ:'
  end
  inherited Panel1: TPanel
    TabOrder = 6
  end
  object EDTRazaoSocial: TLabeledEdit
    Left = 195
    Top = 80
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
    Top = 124
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
    Top = 170
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
    Top = 216
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
  object EDTTelefone: TLabeledEdit
    Left = 195
    Top = 262
    Width = 303
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Telefone:'
    LabelPosition = lpLeft
    LabelSpacing = 10
    MaxLength = 20
    TabOrder = 4
  end
  object EDTEmail: TLabeledEdit
    Left = 195
    Top = 306
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
end

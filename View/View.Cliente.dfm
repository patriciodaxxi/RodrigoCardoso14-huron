inherited ClienteView: TClienteView
  Caption = 'ClienteView'
  Font.Charset = ANSI_CHARSET
  Font.Name = 'Verdana'
  PixelsPerInch = 96
  TextHeight = 13
  object EDTRazaoSocial: TLabeledEdit
    Left = 72
    Top = 64
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 92
    EditLabel.Height = 13
    EditLabel.Caption = 'EDTRazaoSocial'
    TabOrder = 2
  end
  object EDTNomeFantasia: TLabeledEdit
    Left = 72
    Top = 128
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 102
    EditLabel.Height = 13
    EditLabel.Caption = 'EDTNomeFantasia'
    TabOrder = 3
  end
  object MSKCNPJ: TMaskEdit
    Left = 72
    Top = 283
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 4
    Text = 'MSKCNPJ'
  end
  object EDTEndereco: TLabeledEdit
    Left = 72
    Top = 179
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 76
    EditLabel.Height = 13
    EditLabel.Caption = 'EDTEndereco'
    TabOrder = 5
  end
  object EDTTelefone: TLabeledEdit
    Left = 72
    Top = 232
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'EDTTelefone'
    TabOrder = 6
  end
  object EDTEmail: TLabeledEdit
    Left = 72
    Top = 331
    Width = 251
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = 'EDTEmail'
    TabOrder = 7
  end
end

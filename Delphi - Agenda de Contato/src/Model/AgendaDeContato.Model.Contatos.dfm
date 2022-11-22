object dmContatos: TdmContatos
  Height = 507
  Width = 693
  PixelsPerInch = 120
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\marco\OneDrive\'#193'rea de Trabalho\Delphi - Agend' +
        'a de Contato\AgendaDeContatosDB.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 184
    Top = 24
  end
end

program AgendaDeContatos;

uses
  Vcl.Forms,
  AgendaDeContato.View.Contatos in 'src\View\AgendaDeContato.View.Contatos.pas' {frmContatos},
  AgendaDeContato.Model.Contatos in 'src\Model\AgendaDeContato.Model.Contatos.pas' {dmContatos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmContatos, dmContatos);
  Application.CreateForm(TfrmContatos, frmContatos);
  Application.Run;
end.

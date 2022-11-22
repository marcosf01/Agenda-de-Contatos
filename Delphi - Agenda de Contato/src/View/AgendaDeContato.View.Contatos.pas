unit AgendaDeContato.View.Contatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg;

type
  TfrmContatos = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    pnlRodape: TPanel;
    pnlEsquerdo: TPanel;
    pnlDireito: TPanel;
    edtID: TEdit;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    lblID: TLabel;
    lblNome: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    mmoObservacoes: TMemo;
    lblObservacoes: TLabel;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnDeletar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Panel1: TPanel;
    btnSair: TSpeedButton;
    Panel2: TPanel;
    btnAvancar: TSpeedButton;
    btnVoltar: TSpeedButton;
    Panel3: TPanel;
    edtBarraDePesquisa: TEdit;
    Panel4: TPanel;
    btnPesquisar: TSpeedButton;
    lblStatusConexao: TLabel;
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    btnBuscarImagem: TSpeedButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscarImagemClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure carrega;
    procedure limpa;
    procedure bloqueia;
  end;

var
  frmContatos: TfrmContatos;

implementation

{$R *.dfm}

uses AgendaDeContato.Model.Contatos;

procedure TfrmContatos.bloqueia;
begin
  edtID.Enabled           := not edtID.Enabled;
  edtNome.Enabled         := not edtNome.Enabled;
  edtTelefone.Enabled     := not edtTelefone.Enabled;
  edtEmail.Enabled        := not edtEmail.Enabled;
  mmoObservacoes.Enabled  := not mmoObservacoes.Enabled;
  btnCancelar.Enabled     := not btnCancelar.Enabled;
  btnSalvar.Enabled       := not btnSalvar.Enabled;
  btnNovo.Enabled         := not btnNovo.Enabled;
  btnEditar.Enabled       := not btnEditar.Enabled;
  btnDeletar.Enabled      := not btnDeletar.Enabled;
  btnBuscarImagem.Enabled := not btnBuscarImagem.Enabled;
end;

procedure TfrmContatos.btnAvancarClick(Sender: TObject);
begin
  dmContatos.FDTable1.Next;
  carrega;
end;

procedure TfrmContatos.btnCancelarClick(Sender: TObject);
begin
  dmContatos.FDTable1.Cancel;
  carrega;
  bloqueia;
end;

procedure TfrmContatos.btnDeletarClick(Sender: TObject);
begin
  dmContatos.FDTable1.Delete;
  ShowMessage('Contato apagado!');
  carrega;
end;

procedure TfrmContatos.btnEditarClick(Sender: TObject);
begin
  dmContatos.FDTable1.Edit;
  bloqueia;

end;

procedure TfrmContatos.btnNovoClick(Sender: TObject);
begin
  dmContatos.FDTable1.Insert;
  limpa;
  bloqueia;

end;

procedure TfrmContatos.btnPesquisarClick(Sender: TObject);
begin
  if dmContatos.FDTable1.FindKey([edtBarraDePesquisa.Text]) then
    carrega
  else
    Application.MessageBox('O contato n�o foi encontrado!', 'Aten��o', MB_OK + MB_ICONWARNING);

end;

procedure TfrmContatos.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmContatos.btnSalvarClick(Sender: TObject);
begin

  if edtID.Text = '' then
  begin
    edtID.SetFocus;
    Application.MessageBox('O campo "ID" n�o pode ficar vazio!', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if edtNome.Text = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo "Nome" n�o pode ficar vazio!', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if edtTelefone.Text = '' then
  begin
    edtTelefone.SetFocus;
    Application.MessageBox('O campo "Telefone" n�o pode ficar vazio!', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if edtEmail.Text = '' then
  begin
    edtEmail.SetFocus;
    Application.MessageBox('O campo "E-mail" n�o pode ficar vazio!', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if mmoObservacoes.Text = '' then
  begin
    mmoObservacoes.SetFocus;
    Application.MessageBox('O campo "Observa��es" n�o pode ficar vazio!', 'Aten��o', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  dmContatos.FDTable1.FieldByName('id').Value          := edtID.Text;
  dmContatos.FDTable1.FieldByName('nome').Value        := edtNome.Text;
  dmContatos.FDTable1.FieldByName('telefone').Value    := edtTelefone.Text;
  dmContatos.FDTable1.FieldByName('email').Value       := edtEmail.Text;
  dmContatos.FDTable1.FieldByName('observacoes').Value := mmoObservacoes.Text;

  dmContatos.FDTable1.Post;
  ShowMessage('Registro salvo com sucesso!');
  bloqueia;
end;

procedure TfrmContatos.btnVoltarClick(Sender: TObject);
begin
  dmContatos.FDTable1.Prior;
  carrega;
end;

procedure TfrmContatos.Button1Click(Sender: TObject);
begin
  OpenDialog1.Execute();
  OpenDialog1.FileName;
  ShowMessage(OpenDialog1.FileName);
end;

procedure TfrmContatos.carrega;
begin
  edtID.Text          := dmContatos.FDTable1.FieldByName('id').Value;
  edtNome.Text        := dmContatos.FDTable1.FieldByName('nome').Value;
  edtTelefone.Text    := dmContatos.FDTable1.FieldByName('telefone').Value;
  edtEmail.Text       := dmContatos.FDTable1.FieldByName('email').Value;
  mmoObservacoes.Text := dmContatos.FDTable1.FieldByName('observacoes').Value;

  if dmContatos.FDTable1.FieldByName('foto').Value = NULL then
    Image1.Picture.LoadFromFile('C:\Users\marco\OneDrive\�rea de Trabalho\Delphi - Agenda de Contato\pessoas\img_no_photo.jpg')
  else
  Image1.Picture.LoadFromFile(dmContatos.FDTable1.FieldByName('foto').Value);
end;

procedure TfrmContatos.FormCreate(Sender: TObject);
begin
  dmContatos.FDConnection1.Connected := True;
  dmContatos.FDTable1.TableName      := 'contatos';
  dmContatos.FDTable1.Active         := True;

  if dmContatos.FDConnection1.Connected = True then
    lblStatusConexao.Caption    := '         Conectado';
    lblStatusConexao.Font.Color := $00F26558;
    carrega;
    bloqueia;

end;

procedure TfrmContatos.limpa;
begin
  edtID.Text          := '';
  edtNome.Text        := '';
  edtTelefone.Text    := '';
  edtEmail.Text       := '';
  mmoObservacoes.Text := '';
  Image1.Picture      := nil;
end;

procedure TfrmContatos.btnBuscarImagemClick(Sender: TObject);
begin
  OpenDialog1.Execute();
  Image1.Picture.LoadFromFile(OpenDialog1.FileName);
  dmContatos.FDTable1.FieldByName('foto').Value := OpenDialog1.FileName;
end;

end.

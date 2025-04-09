unit uRelDespesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, RLFilters, RLPDFFilter,
  Data.DB;

type
  TfrmRelDespesas = class(TForm)
    RelDespesas: TRLReport;
    RLBand1: TRLBand;
    RLPDFFilter: TRLPDFFilter;
    dsRelatorioDespesas: TDataSource;
    RLBand2: TRLBand;
    rlTitulo: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDraw1: TRLDraw;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    lblPago: TRLLabel;
    RLBand4: TRLBand;
    RLLabel6: TRLLabel;
    lblTotalAPagar: TRLLabel;
    lblTotalPago: TRLLabel;
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelDespesas: TfrmRelDespesas;

implementation

{$R *.dfm}

uses uDM, uFuncoes;

procedure TfrmRelDespesas.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  lblPago.Visible := dsRelatorioDespesas.DataSet.FieldByName('valoraPagar').AsVariant =
      dsRelatorioDespesas.DataSet.FieldByName('valorPago').AsVariant;
end;

end.

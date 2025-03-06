unit uCalendario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCalendars;

type
  TfrmCalendario = class(TForm)
    CalendarView: TCalendarView;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalendario: TfrmCalendario;

implementation

{$R *.dfm}

procedure TfrmCalendario.FormShow(Sender: TObject);
begin
  CalendarView.Date := Date();
end;

end.

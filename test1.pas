unit test1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Vcl.StdCtrls, Vcl.Controls,
  Vcl.Forms, System.Net.Mime, System.DateUtils, Vcl.Dialogs;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    NetHTTPClient1: TNetHTTPClient;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  lessonTimestamp: Int64;
  lessonDate: TDateTime;
  formattedDate: string;
begin
  lessonTimestamp := 1707091200;
  lessonDate := UnixToDateTime(lessonTimestamp);
  formattedDate := FormatDateTime('dd.mm.yyyy', lessonDate);

  // NetHTTPClient1.ContentType := 'application/json';
  // NetHTTPClient1.AcceptEncoding := 'UTF-8';
  // LResponse := TStringStream.Create
  // ('{"login": "999211100073","password": "DD7777777"}');
  // Memo1.Text := NetHTTPClient1.Post
  // ('https://student.buxdu.uz/rest/v1/auth/login', LResponse)
  // .ContentAsString();
end;

end.

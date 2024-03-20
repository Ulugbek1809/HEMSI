unit davomad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, FMX.TabControl,
  FMX.Objects;

type
  TFrame7 = class(TFrame)
    Button1: TButton;
    ListBox1: TListBox;
    NetHTTPClient1: TNetHTTPClient;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    AniIndicator1: TAniIndicator;
    TabItem3: TTabItem;
    GridPanelLayout1: TGridPanelLayout;
    Image1: TImage;
    Label1: TLabel;
    NetHTTPClient2: TNetHTTPClient;
    procedure NetHTTPClient1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPClient1RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPClient1RequestException(const Sender: TObject;
      const AError: Exception);
    procedure Button1Click(Sender: TObject);
    procedure NetHTTPClient2RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPClient2RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPClient2RequestException(const Sender: TObject;
      const AError: Exception);
  private
    { Private declarations }
  public
    internet: Boolean;
    strema: TStream;
  end;

var
  davomad_bolim: TFrame7;

implementation

{$R *.fmx}

uses malumotlar_tahlil, main;

procedure TFrame7.Button1Click(Sender: TObject);
begin
  if mainform.token <> '' then
  begin
    case mainform.tre of
      'd':
        mainform.ListBoxItem4Click(Sender);
      'n':
        mainform.ListBoxItem5Click(Sender);
    end;
  end
  else
    mainform.FormShow(Sender)
end;

procedure TFrame7.NetHTTPClient1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  davomad_bolim.internet := True;
  malumotlar_tahlil.davomad_tahlil;
end;

procedure TFrame7.NetHTTPClient1RequestError(const Sender: TObject;
  const AError: string);
begin
  davomad_bolim.internet := False;
  malumotlar_tahlil.davomad_tahlil;
end;

procedure TFrame7.NetHTTPClient1RequestException(const Sender: TObject;
  const AError: Exception);
begin
  davomad_bolim.internet := False;
  malumotlar_tahlil.davomad_tahlil;
end;

procedure TFrame7.NetHTTPClient2RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  internet := True;
  malumotlar_tahlil.nazorat_tahlil;
end;

procedure TFrame7.NetHTTPClient2RequestError(const Sender: TObject;
  const AError: string);
begin
  internet := False;
  malumotlar_tahlil.nazorat_tahlil;
end;

procedure TFrame7.NetHTTPClient2RequestException(const Sender: TObject;
  const AError: Exception);
begin
  internet := False;
  malumotlar_tahlil.nazorat_tahlil;
end;

end.

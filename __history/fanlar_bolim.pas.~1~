unit fanlar_bolim;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.TabControl, FMX.Controls.Presentation,
  System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TFrame1 = class(TFrame)
    ListBox1: TListBox;
    TabControl1: TTabControl;
    fanlar: TTabItem;
    loading: TTabItem;
    AniIndicator1: TAniIndicator;
    Button1: TButton;
    NetHTTPClient1: TNetHTTPClient;
    umumiy: TTabItem;
    TabControl2: TTabControl;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button2: TButton;
    procedure NetHTTPClient1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPClient1RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPClient1RequestException(const Sender: TObject;
      const AError: Exception);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    mal_fan: TStream;
    fan_internet: Boolean;
  end;

var
  fanlar_haqida: TFrame1;

implementation

{$R *.fmx}

uses malumotlar_tahlil, main;

procedure TFrame1.Button1Click(Sender: TObject);
begin
  if mainform.token <> '' then
  begin
    ToolBar1.Visible := false;
    mainform.MultiView1.Enabled := true;
    mainform.ToolBar1.Visible := true;
    mainform.ListBoxItem3Click(Sender);
  end
  else
    mainform.FormShow(Sender);
end;

procedure TFrame1.Button2Click(Sender: TObject);
begin
  ToolBar1.Visible := false;
  mainform.MultiView1.Enabled := true;
  mainform.ToolBar1.Visible := true;
  TabControl1.ActiveTab := fanlar;
end;

procedure TFrame1.NetHTTPClient1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  fan_internet := true;
  malumotlar_tahlil.fan_malumotlari_tahlil;
end;

procedure TFrame1.NetHTTPClient1RequestError(const Sender: TObject;
  const AError: string);
begin
  fan_internet := false;
  malumotlar_tahlil.fan_malumotlari_tahlil;
end;

procedure TFrame1.NetHTTPClient1RequestException(const Sender: TObject;
  const AError: Exception);
begin
  fan_internet := false;
  malumotlar_tahlil.fan_malumotlari_tahlil;
end;

end.

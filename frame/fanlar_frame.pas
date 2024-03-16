unit fanlar_frame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Ani;

type
  TFrame3 = class(TFrame)
    Rectangle1: TRectangle;
    Label2: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    Label3: TLabel;
    Layout1: TLayout;
    Arc1: TArc;
    progress: TArc;
    Label1: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
  private
    Procedure value(const val: integer);
  public
    overall, overall_max, overall_foiz, k: integer;
  end;

var
  fanlar_frame_item: array of TFrame3;
  fanlar_frame_item_click: array of TFrame3;
  fanlar_haqida_item: array of TListBoxItem;

implementation

{$R *.fmx}

uses interbase, json, fanlar_bolim, main, data, url;

{ TFrame3 }

procedure TFrame3.Rectangle1Click(Sender: TObject);
var
  k: Tujsonvalue;
  udata: Tdatabase;
  tk: string;
begin
  if fanlar_haqida.TabControl1.ActiveTab = fanlar_haqida.fanlar then
  begin
    fanlar_haqida.ToolBar1.Visible := True;
    udata.create;
    tk := mainform.token;
    mainform.MultiView1.Enabled := false;
    mainform.ToolBar1.Visible := false;
    k := udata.readjson('fan');
    if k.javob then
      json.fan_malumotlari2(Label2.Text, Label3.Text, k.value);
    udata.stop;
  end;
end;

procedure TFrame3.Timer1Timer(Sender: TObject);
begin
  if (k <= overall_foiz) then
  begin
    value(k);
    k := k + 1;
  end;
end;

procedure TFrame3.value(const val: integer);
begin
  Label1.Text := overall.ToString + '/' + overall_max.ToString;
  progress.EndAngle := (360 * val) / 100;
end;

end.

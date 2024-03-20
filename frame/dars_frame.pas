{*******************************************************}
{                       Talaba                          }
{                                                       }
{                   Yusupov Ulug'bek                    }
{                                                       }
{                     20.03.2024                        }
{                                                       }
{*******************************************************}

unit dars_frame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.ListBox,
  System.DateUtils;

type
  TFrame2 = class(TFrame)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    Rectangle3: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    procedure writeoqituvchi(const value: string);
    procedure writefan(const value: string);
    procedure writexona(const value: string);
    procedure Setdars_turi(const value: string);
    procedure start_time(const value: string);
    procedure end_tieme(const value: string);
    Function timeedit(const startt, endt: string): Boolean;
  public
    dars_kuni: TDate;
    property oqituvchi: string write writeoqituvchi;
    Property fan: string write writefan;
    Property dars_xonasi: string write writexona;
    property dars_turi: string write Setdars_turi;
    property start_dars: string write start_time;
    property end_dars: string write end_tieme;
  end;

var
  dars_jadvali_frame: Array of TFrame2;
  header: array of TListBoxItem;

implementation

{$R *.fmx}
{ TFrame2 }

procedure TFrame2.end_tieme(const value: string);
begin
  Label3.Text := value;
end;

procedure TFrame2.Setdars_turi(const value: string);
begin
  Label4.Text := value;
end;

procedure TFrame2.start_time(const value: string);
begin
  Label2.Text := value;
end;

function TFrame2.timeedit(const startt, endt: string): Boolean;
var
  StartTime, EndTime, CurrentTime: TDateTime;
begin
  StartTime := StrToTime(startt).GetTime;
  EndTime := StrToTime(endt).GetTime;
  CurrentTime := Now.GetTime;
  Result := (CurrentTime.GetTime >= StartTime.GetTime) and
    (CurrentTime.GetTime <= EndTime.GetTime);
end;

procedure TFrame2.Timer1Timer(Sender: TObject);
var
  hozir: TDate;
begin
  hozir := Now.GetDate;
  if dars_kuni > hozir then
  begin
    Rectangle2.Fill.Color := TAlphaColor($FFD78A2B);
    Rectangle3.Fill.Color := TAlphaColor($FFD78A2B);
    Rectangle1.Visible := true;
    exit;
  end;
  if dars_kuni < hozir then
  begin
    Rectangle2.Fill.Color := TAlphaColorRec.Darkgray;
    Rectangle3.Fill.Color := TAlphaColorRec.Darkgray;
    Rectangle1.Visible := true;
    exit;
  end;
  if timeedit(Label2.Text, Label3.Text) then
  begin
    Rectangle2.Fill.Color := TAlphaColorRec.Green;
    Rectangle3.Fill.Color := TAlphaColorRec.Green;
  end
  else
  begin
    if StrToTime(Label2.Text).GetTime > Now.GetTime then
    begin
      Rectangle2.Fill.Color := TAlphaColor($FFD78A2B);
      Rectangle3.Fill.Color := TAlphaColor($FFD78A2B);
    end
    else
    begin
      if StrToTime(Label3.Text).GetTime < Now.GetTime then
      begin
        Rectangle2.Fill.Color := TAlphaColorRec.Darkgray;
        Rectangle3.Fill.Color := TAlphaColorRec.Darkgray;
      end;
    end;
  end;
  Rectangle1.Visible := true;
end;

procedure TFrame2.writefan(const value: string);
begin
  Label1.Text := value;
end;

procedure TFrame2.writeoqituvchi(const value: string);
begin
  Label5.Text := value;
end;

procedure TFrame2.writexona(const value: string);
begin
  Label6.Text := value;
end;

end.

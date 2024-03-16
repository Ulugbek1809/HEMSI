unit timecolor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.StdCtrls, dars_frame;

type
  TForm2 = class(TForm)
    Frame21: TFrame2;
    ToolBar1: TToolBar;
    DateEdit1: TDateEdit;
    procedure DateEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.DateEdit1Change(Sender: TObject);
begin
  Frame21.dars_kuni := DateEdit1.Date;
end;

end.

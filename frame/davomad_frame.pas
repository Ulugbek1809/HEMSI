unit davomad_frame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TFrame6 = class(TFrame)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Label1: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    Rectangle3: TRectangle;
    Label6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  davomad_frame_item: array of TFrame6;
  davomad_list_item: array of TListBoxItem;

implementation

{$R *.fmx}

end.

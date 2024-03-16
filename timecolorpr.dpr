program timecolorpr;

uses
  System.StartUpCopy,
  FMX.Forms,
  timecolor in 'timecolor.pas' {Form2},
  dars_frame in 'frame\dars_frame.pas' {Frame2: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

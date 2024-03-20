unit interbase;

interface

uses system.SysUtils, system.Classes, system.IOUtils, data, {$IFDEF MSWINDOWS}
  winapi.Windows,
{$ENDIF}FireDAC.Stan.Param;

type
  Tujsonvalue = record
    javob: Boolean;
    value: string;
    datetime: string;
  end;

  Tdatabase = record
    Procedure create;
    procedure stop;
    Procedure save_universitet(const code: integer; const name, api: string);
    Function read_universitet(const index: byte): string;
    Procedure delete_universitet(const id: cardinal);
    Function read_user(const index: byte): string;
    Procedure delete_user(const login: string);
    procedure writejson(const name, json: string);
    Function readjson(const name: string): Tujsonvalue;
    Procedure save_user(const login, pas: string);
    procedure clear_db;
  end;

implementation

{ Tdatabase }

procedure Tdatabase.clear_db;
var
  sl: TStringList;
  i: integer;
begin
  sl := TStringList.create;
  DataModule1.FDConnection1.Connected := True;
  DataModule1.FDConnection1.GetTableNames('', '', '', sl);
  DataModule1.FDQuery1.Active := False;
  for i := 0 to sl.Count - 1 do
  begin
    DataModule1.FDQuery1.SQL.Text := 'DROP TABLE ' + sl[i];
    DataModule1.FDQuery1.ExecSQL;
  end;
  stop;
end;

procedure Tdatabase.create;
var
  res: TResourceStream;
  sl: TStringList;
begin
  sl := TStringList.create;
{$IFDEF MSWINDOWS}
  if not(FileExists(Tpath.GetHomePath + '\Talaba\database.ib')) then
  begin
    res := TResourceStream.create(HInstance, 'dat', RT_RCDATA);
    if ForceDirectories(Tpath.GetHomePath + '\Talaba') then
      res.SaveToFile(Tpath.GetHomePath + '\Talaba\database.ib');
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  DataModule1.FDConnection1.Params.Database := Tpath.GetHomePath +
    '\Talaba\database.ib';
{$ELSE}
  DataModule1.FDConnection1.Params.Database := Tpath.GetDocumentsPath +
    '/db.sqlite3';
{$ENDIF}
  DataModule1.FDConnection1.Params.UserName := '';
  DataModule1.FDConnection1.Params.UserName := '';
  DataModule1.FDConnection1.Connected := True;
  DataModule1.FDConnection1.GetTableNames('', '', '', sl);
  if sl.IndexOf('univer') = -1 then
  begin
    DataModule1.FDQuery1.SQL.Add('CREATE TABLE univer (');
    DataModule1.FDQuery1.SQL.Add('CODE VARCHAR(10),');
    DataModule1.FDQuery1.SQL.Add('UNIVER VARCHAR(1000),');
    DataModule1.FDQuery1.SQL.Add('API TEXT )');
    DataModule1.FDQuery1.Execute;
    DataModule1.FDQuery1.SQL.Clear;
  end;
  if sl.IndexOf('USER') = -1 then
  begin
    DataModule1.FDQuery1.SQL.Add('CREATE TABLE USER (');
    DataModule1.FDQuery1.SQL.Add('login VARCHAR(100),');
    DataModule1.FDQuery1.SQL.Add('pas VARCHAR(100))');
    DataModule1.FDQuery1.Execute;
    DataModule1.FDQuery1.SQL.Clear;
  end;
  if sl.IndexOf('JSON') = -1 then
  begin
    DataModule1.FDQuery1.SQL.Add('CREATE TABLE JSON (');
    DataModule1.FDQuery1.SQL.Add('KEY VARCHAR(50),');
    DataModule1.FDQuery1.SQL.Add('VALUE TEXT,');
    DataModule1.FDQuery1.SQL.Add('datatime VARCHAR(50))');
    DataModule1.FDQuery1.Execute;
    DataModule1.FDQuery1.SQL.Clear;
  end;
end;

procedure Tdatabase.delete_universitet(const id: cardinal);
begin
  DataModule1.FDQuery1.SQL.Text := 'SELECT * FROM univer';
  DataModule1.FDQuery1.Active := True;
  if (DataModule1.FDQuery1.Active) and (DataModule1.FDQuery1.RecordCount > 0)
  then
  begin
    DataModule1.FDQuery1.Active := False;
    DataModule1.FDQuery1.SQL.Text := 'DELETE FROM univer WHERE CODE = :ID';
    DataModule1.FDQuery1.ParamByName('ID').AsInteger := id;
    DataModule1.FDQuery1.ExecSQL;
  end;
end;

procedure Tdatabase.delete_user(const login: string);
begin
  DataModule1.FDQuery1.SQL.Text := 'SELECT * FROM USER';
  DataModule1.FDQuery1.Active := True;
  if (DataModule1.FDQuery1.Active) and (DataModule1.FDQuery1.RecordCount > 0)
  then
  begin
    DataModule1.FDQuery1.Active := False;
    DataModule1.FDQuery1.SQL.Text := 'DELETE FROM USER WHERE login = :ID';
    DataModule1.FDQuery1.ParamByName('ID').AsString := login;
    DataModule1.FDQuery1.ExecSQL;
  end;
end;

function Tdatabase.readjson(const name: string): Tujsonvalue;
var
  uj: Tujsonvalue;
  i: integer;
begin
  DataModule1.FDQuery1.SQL.Text := 'SELECT * FROM JSON';
  DataModule1.FDQuery1.Active := True;
  for i := 1 to DataModule1.FDQuery1.RecordCount do
  begin
    DataModule1.FDQuery1.RecNo := i;
    if DataModule1.FDQuery1.FieldList[0].AsString = name then
    begin
      uj.javob := True;
      uj.value := DataModule1.FDQuery1.FieldList[1].AsString;
      uj.datetime := DataModule1.FDQuery1.FieldList[2].AsString;
      Result := uj;
      exit;
    end;
  end;
  uj.javob := False;
  Result := uj;
end;

function Tdatabase.read_universitet(const index: byte): string;
begin
  DataModule1.FDQuery1.SQL.Text := 'SELECT * FROM univer';
  DataModule1.FDQuery1.Active := True;
  if (DataModule1.FDQuery1.Active) and (DataModule1.FDQuery1.RecordCount > 0)
  then
  begin
    DataModule1.FDQuery1.RecNo := 1;
    Result := DataModule1.FDQuery1.FieldList[index].AsString;
  end;
end;

function Tdatabase.read_user(const index: byte): string;
begin
  DataModule1.FDQuery1.SQL.Text := 'SELECT * FROM USER';
  DataModule1.FDQuery1.Active := True;
  if (DataModule1.FDQuery1.Active) and (DataModule1.FDQuery1.RecordCount > 0)
  then
  begin
    DataModule1.FDQuery1.RecNo := 1;
    Result := DataModule1.FDQuery1.FieldList[index].AsString;
  end;
end;

procedure Tdatabase.save_user(const login, pas: string);
begin
  if DataModule1.FDConnection1.Connected then
  begin
    DataModule1.FDQuery1.SQL.Text :=
      'INSERT INTO USER (login, pas) VALUES (:Value10, :Value20)';
    DataModule1.FDQuery1.ParamByName('Value10').value := login;
    DataModule1.FDQuery1.ParamByName('Value20').value := pas;
    DataModule1.FDQuery1.ExecSQL;
    DataModule1.FDQuery1.SQL.Clear;
  end;
end;

procedure Tdatabase.save_universitet(const code: integer;
  const name, api: string);
begin
  if DataModule1.FDConnection1.Connected then
  begin
    DataModule1.FDQuery1.SQL.Text :=
      'INSERT INTO univer (CODE, UNIVER, API) VALUES (:Value1, :Value2, :Value3)';
    DataModule1.FDQuery1.ParamByName('Value1').value := code;
    DataModule1.FDQuery1.ParamByName('Value2').value := name;
    DataModule1.FDQuery1.ParamByName('Value3').value := api;
    DataModule1.FDQuery1.Execute;
    DataModule1.FDQuery1.SQL.Clear;
  end;
end;

procedure Tdatabase.stop;
begin
  DataModule1.FDConnection1.Connected := False;
  DataModule1.FDQuery1.Active := False;
end;

procedure Tdatabase.writejson(const name, json: string);
begin
  if readjson(name).javob = False then
  begin
    if DataModule1.FDConnection1.Connected then
    begin
      DataModule1.FDQuery1.SQL.Text :=
        'INSERT INTO JSON (KEY, VALUE, datatime) VALUES (:Value1, :Value2, :Value3)';
      DataModule1.FDQuery1.ParamByName('Value1').value := name;
      DataModule1.FDQuery1.ParamByName('Value2').value := json;
      DataModule1.FDQuery1.ParamByName('Value3').value := DateToStr(now) + ' ' +
        TimeToStr(now);
      DataModule1.FDQuery1.Execute;
      DataModule1.FDQuery1.SQL.Clear;
    end;
  end
  else
  begin
    DataModule1.FDQuery1.SQL.Text :=
      'UPDATE JSON SET VALUE =:value1, datatime =:value2 WHERE KEY =:id';
    DataModule1.FDQuery1.ParamByName('value1').AsString := json;
    DataModule1.FDQuery1.ParamByName('value2').AsString := DateToStr(now) + ' '
      + TimeToStr(now);
    DataModule1.FDQuery1.ParamByName('id').AsString := name;
    DataModule1.FDQuery1.ExecSQL;
    DataModule1.FDQuery1.SQL.Clear;
  end;
end;

end.

unit data;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  data.Bind.Components, data.Bind.ObjectScope, REST.Client, System.IOUtils,
  FMX.Forms, FMX.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, IBX.IBDatabase,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.FMXUI.Wait, FireDAC.Phys.IB, FireDAC.Phys.IBLiteDef, System.JSON,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, url, System.ImageList, FMX.ImgList, JSON,
  FMX.DialogService, System.UITypes, FMX.ListBox
{$IFDEF ANDROID}, System.Generics.Collections, REST.Types, utoast_component
{$ENDIF};

type
  TDataModule1 = class(TDataModule)
    StyleBook1: TStyleBook;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    tekshirish: TTimer;
    qoshish: TTimer;
    ImageList1: TImageList;
    smestrgetclient: TNetHTTPClient;
    NetHTTPClient1: TNetHTTPClient;
    rasm_profile: TNetHTTPClient;
    procedure tekshirishTimer(Sender: TObject);
    procedure qoshishTimer(Sender: TObject);
    procedure NetHTTPClient1RequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure NetHTTPClient1RequestError(const Sender: TObject;
      const AError: string);
    procedure NetHTTPClient1RequestException(const Sender: TObject;
      const AError: Exception);
    procedure smestrgetclientRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure smestrgetclientRequestError(const Sender: TObject;
      const AError: string);
    procedure smestrgetclientRequestException(const Sender: TObject;
      const AError: Exception);
    procedure rasm_profileRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
  private
{$IFDEF ANDROID}
    i, n: integer;
    jsonArray: TJSONArray;
    JsonValue: TJSONValue;
    JsonObject: TJSONObject;
    sl: TStringList;
{$ENDIF}
  public
    amal: char;
    rasm: TStream;
    s: string;
    Procedure start;
    Procedure kirish;
    procedure talaba_malumotlari;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses main, file_name, interbase, malumotlar_tahlil, fanlar_bolim;
{$R *.dfm}

procedure TDataModule1.kirish;
var
  sl: TStringList;
  jobj, tjsont: TJSONObject;
  jvalue: TJSONValue;
  udata: Tdatabase;
  j: string;
begin
  if mainform.internet then
  begin
    udata.Create;
    sl := TStringList.Create;
    sl.LoadFromStream(mainform.stream);
    j := sl.Text;
    jvalue := TJSONObject.ParseJSONValue(sl.Text);
    jobj := TJSONObject(jvalue);
    mainform.stream := TMemoryStream.Create;
    if jobj.GetValue('success').Value.ToBoolean = True then
    begin
      tjsont := jobj.GetValue('data') as TJSONObject;
      mainform.token := tjsont.GetValue('token').Value;
      if (udata.read_user(0) <> mainform.Edit1.Text) or
        (udata.read_user(1) <> mainform.Edit2.Text) then
      begin
        udata.delete_user(mainform.Edit1.Text);
        udata.save_user(mainform.Edit1.Text, mainform.Edit2.Text);
      end;
      NetHTTPClient1.CustomHeaders['Authorization'] := 'Bearer ' +
        mainform.token;
      if not(udata.readjson('me').javob) then
      begin
        NetHTTPClient1.Get(udata.read_universitet(2) + url.me, mainform.stream);
        amal := '3';
        udata.stop;
        exit;
      end;
      talaba_malumotlari;
      udata.stop;
    end
    else
    begin
      mainform.Label7.Text := jobj.GetValue('error').Value;
      mainform.maintab.ActiveTab := mainform.login;
      mainform.AniIndicator1.Enabled := false;
      mainform.Label4.Text := udata.read_universitet(1);
      exit;
    end;
  end
  else
  begin
    if not(udata.readjson('me').javob) then
    begin
      NetHTTPClient1.Get(udata.read_universitet(2) + url.me, mainform.stream);
      amal := '3';
      udata.stop;
      mainform.maintab.ActiveTab := mainform.mainmenu;
      mainform.AniIndicator1.Enabled := false;
      exit;
    end
    else
    begin
      talaba_malumotlari;
    end;
  end;
end;

procedure TDataModule1.NetHTTPClient1RequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
var
  udata: Tdatabase;
begin
  udata.Create;
  mainform.internet := True;
  if AResponse.StatusCode = 200 then
  begin
    case amal of
      '1':
        kirish;
      '3':
        talaba_malumotlari;
      'd':
        begin
          malumotlar_tahlil.dars_jadvali;
        end;
    end;
  end
  else
  begin
    case amal of
      '1':
        begin
          mainform.Label7.Text := 'Serverga ulanib bo`lmadi.';
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end;
      '3':
        begin
          mainform.Label7.Text := 'Talaba ma`lumotlarini olib bo`lmadi.';
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end;
    end;
  end;
  udata.stop;
end;

procedure TDataModule1.NetHTTPClient1RequestError(const Sender: TObject;
  const AError: string);
var
  udata: Tdatabase;
begin
  udata.Create;
  mainform.internet := false;
  case amal of
    '1':
      begin
        if (udata.read_user(0) = '') and (udata.read_user(2) = '') then
        begin
          mainform.Label7.Text := 'Serverga ulanib bo`lmadi. ' + AError;
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end
        else
          kirish;
        exit;
      end;
    '3':
      begin
        if (udata.readjson('me').javob = false) then
        begin
          mainform.Label7.Text :=
            'Talaba ma`lumotlarini olib bo`lmadi. ' + AError;
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end
        else
          talaba_malumotlari;
        exit;
      end;
    'd':
      begin
        if (udata.readjson('dars').javob = false) then
        begin
          mainform.Button8.Text := 'Siz oflayn rejimdasiz !';
          mainform.Button8.Visible := True;
        end
        else
          malumotlar_tahlil.dars_jadvali;
        exit;
      end;
  end;
end;

procedure TDataModule1.NetHTTPClient1RequestException(const Sender: TObject;
  const AError: Exception);
var
  udata: Tdatabase;
begin
  mainform.internet := false;
  udata.Create;
  case amal of
    '1':
      begin
        if (udata.read_user(0) = '') and (udata.read_user(2) = '') then
        begin
          mainform.Label7.Text :=
            'Serverga ulanib bo`lmadi. Internetga ulanganingizni tekshiring.';
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end;
      end;
    '2':
      malumotlar_tahlil.smestr_malumotlari;
    '3':
      begin
        if (udata.readjson('me').javob = false) then
        begin
          mainform.Label7.Text :=
            'Talaba ma`lumotlarini olib bo`lmadi. Internetga ulanganingizni tekshiring.';
          mainform.maintab.ActiveTab := mainform.login;
          mainform.AniIndicator1.Enabled := false;
        end;
      end;
    'd':
      begin
        if (udata.readjson('dars').javob = false) then
        begin
          mainform.Button8.Text := 'Siz oflayn rejimdasiz !';
          mainform.Button8.Visible := True;
        end
        else
          malumotlar_tahlil.dars_jadvali;
      end;
  end;
  udata.stop;
end;

procedure TDataModule1.qoshishTimer(Sender: TObject);
{$IFDEF ANDROID}
var
  udata: Tdatabase;
  j: byte;
{$ENDIF}
begin
{$IFDEF ANDROID}
  qoshish.Enabled := false;
  j := 0;
  if i <> n then
    repeat
      j := j + 1;
      if ((jsonArray.Items[i] as TJSONObject).GetValue('api_url').Value <>
        'null') and (i <> n) and (i < n) then
      begin
        if (jsonArray.Items[i] as TJSONObject).GetValue('name').Value = s then
        begin
          udata.Create;
          udata.save_universitet((jsonArray.Items[i] as TJSONObject)
            .GetValue('code').Value.ToInteger,
            (jsonArray.Items[i] as TJSONObject).GetValue('name').Value,
            (jsonArray.Items[i] as TJSONObject).GetValue('api_url').Value);
          udata.stop;
          mainform.Label4.Text := (jsonArray.Items[i] as TJSONObject)
            .GetValue('name').Value;
          mainform.Label7.Text := '';
          main.mainform.Edit1.Enabled := True;
          main.mainform.Edit2.Enabled := True;
          main.mainform.Button3.Enabled := True;
          main.mainform.Button4.Enabled := True;
          s := 'S';
          mainform.maintab.ActiveTab := mainform.login;
          break;
        end
        else
        begin
          mainform.universitetbox.Items.Add((jsonArray.Items[i] as TJSONObject)
            .GetValue('name').Value);
          mainform.universitetbox.ItemByIndex
            (mainform.universitetbox.Items.IndexOf
            ((jsonArray.Items[i] as TJSONObject).GetValue('name').Value))
            .ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
        end;
      end;
      if i <> n then
      begin
        i := i + 1;
      end
      else
      begin
        break;
      end;
    until (j = 25);
  if s <> 'S' then
  begin
    tekshirish.Enabled := True;
  end
  else
  begin
    tekshirish.Enabled := false;
  end;
{$ELSE}
  exit;
{$ENDIF}
end;

procedure TDataModule1.rasm_profileRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  if AResponse.StatusCode = 200 then
  begin
    mainform.Circle1.Fill.Bitmap.Bitmap.LoadFromStream(rasm);
{$IFDEF MSWINDOWS}
    if ForceDirectories(TPath.GetHomePath + '\Talaba') then
      mainform.Circle1.Fill.Bitmap.Bitmap.SaveToFile
        (TPath.GetHomePath + '\Talaba\avatar.jpg');
{$ELSE}
    mainform.Circle1.Fill.Bitmap.Bitmap.SaveToFile(TPath.GetDocumentsPath +
      '/avatar.jpg');
{$ENDIF}
  end;
end;

procedure TDataModule1.smestrgetclientRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  malumotlar_tahlil.smestr_malumotlari;
end;

procedure TDataModule1.smestrgetclientRequestError(const Sender: TObject;
  const AError: string);
begin
  malumotlar_tahlil.smestr_malumotlari;
end;

procedure TDataModule1.smestrgetclientRequestException(const Sender: TObject;
  const AError: Exception);
begin
  malumotlar_tahlil.smestr_malumotlari;
end;

procedure TDataModule1.start;
begin
{$IFDEF ANDROID}
  sl := TStringList.Create;
  sl.LoadFromFile(TPath.GetDocumentsPath + '/universitet.json');
  JsonValue := TJSONObject.ParseJSONValue(sl.Text);
  JsonObject := TJSONObject(JsonValue);
  jsonArray := JsonObject.GetValue('data') as TJSONArray;
  mainform.universitetbox.Clear;
  i := 0;
  n := jsonArray.Count;
  tekshirish.Enabled := True;
{$ELSE}
  exit;
{$ENDIF}
end;

procedure TDataModule1.talaba_malumotlari;
var
  sl: TStringList;
  udata: Tdatabase;
  k: Tujsonvalue;
begin
  sl := TStringList.Create;
  udata.Create;
  k := udata.readjson('me');
  sl.LoadFromStream(mainform.stream);
  if k.javob then
  begin
    JSON.malumotlar_json(k.Value);
  end
  else
  begin
    if mainform.internet = True then
    begin
      JSON.malumotlar_json(sl.Text);
      udata.writejson('me', sl.Text);
    end
    else
    begin
      mainform.Label7.Text :=
        'Talaba ma`lumotlarini olib bo`lmadi. Internetga ulanganingizni tekshiring.';
      mainform.maintab.ActiveTab := mainform.login;
      mainform.AniIndicator1.Enabled := false;
    end;
  end;
  udata.stop;
end;

procedure TDataModule1.tekshirishTimer(Sender: TObject);
begin
{$IFDEF ANDROID}
  tekshirish.Enabled := false;
  n := jsonArray.Count;
  if (i <> n) and (i < n) then
    qoshish.Enabled := True
  else
  begin
    qoshish.Enabled := false;
  end;
{$ELSE}
  exit;
{$ENDIF}
end;

end.

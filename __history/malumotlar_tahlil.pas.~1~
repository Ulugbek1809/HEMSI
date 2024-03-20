unit malumotlar_tahlil;

interface

uses System.Classes;

procedure dars_jadvali;
procedure smestr_malumotlari;
procedure fan_malumotlari_tahlil;
procedure davomad_tahlil;
procedure nazorat_tahlil;

implementation

uses data, file_name, interbase, main, json, fanlar_bolim, davomad;

procedure nazorat_tahlil;
var
  udata: Tdatabase;
  s: Tujsonvalue;
  sl: TStringList;
begin
  udata.create;
  if davomad_bolim.internet then
  begin
    sl := TStringList.create;
    sl.LoadFromStream(davomad_bolim.strema);
    udata.writejson('naz', sl.Text);
    davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem1;
    davomad_bolim.AniIndicator1.Enabled := false;
    json.nazorat_json(sl.Text);
  end
  else
  begin
    s := udata.readjson('naz');
    if s.javob then
    begin
      davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem1;
      davomad_bolim.AniIndicator1.Enabled := false;
      davomad_bolim.Button1.Text := 'Oxirgi yangilanish ' + s.datetime;
      davomad_bolim.Button1.Visible := true;
      json.nazorat_json(s.value);
    end
    else
    begin
      mainform.FormShow(nil);
    end;
  end;
end;

procedure davomad_tahlil;
var
  udata: Tdatabase;
  s: Tujsonvalue;
  sl: TStringList;
begin
  udata.create;
  if davomad_bolim.internet then
  begin
    sl := TStringList.create;
    sl.LoadFromStream(davomad_bolim.strema);
    udata.writejson('dav', sl.Text);
    davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem1;
    davomad_bolim.AniIndicator1.Enabled := false;
    json.davomad_json(sl.Text);
  end
  else
  begin
    s := udata.readjson('dav');
    if s.javob then
    begin
      davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem1;
      davomad_bolim.AniIndicator1.Enabled := false;
      davomad_bolim.Button1.Text := 'Oxirgi yangilanish ' + s.datetime;
      davomad_bolim.Button1.Visible := true;
      json.davomad_json(s.value);
    end
    else
    begin
      mainform.FormShow(nil);
    end;
  end;
end;

procedure fan_malumotlari_tahlil;
var
  udata: Tdatabase;
  s: Tujsonvalue;
  sl: TStringList;
begin
  udata.create;
  sl := TStringList.create;
  if fanlar_haqida.fan_internet Then
  begin
    sl.LoadFromStream(fanlar_haqida.mal_fan);
    json.fan_malumotlari(sl.Text);
    udata.writejson('fan', sl.Text);
  end
  else
  begin
    s := udata.readjson('fan');
    if s.javob then
    begin
      json.fan_malumotlari(s.value);
      fanlar_haqida.Button1.Text := 'Oxirgi yangilanish ' + s.datetime;
      fanlar_haqida.Button1.Visible := true;
      fanlar_haqida.TabControl1.ActiveTab := fanlar_haqida.fanlar;
      fanlar_haqida.AniIndicator1.Enabled := false;
    end
    else
    begin
      mainform.FormShow(nil);
    end;
  end;
end;

procedure smestr_malumotlari;
var
  udata: Tdatabase;
  s: Tujsonvalue;
  sl: TStringList;
begin
  udata.create;
  sl := TStringList.create;
  if mainform.internet Then
  begin
    sl.LoadFromStream(mainform.stream);
    udata.writejson('smestr', sl.Text);
    json.smestr_malumotlari(sl.Text);
  end
  else
  begin
    s := udata.readjson('smestr');
    if s.javob then
    begin
      json.smestr_malumotlari(s.value);
    end
    else
    begin
      mainform.Label7.Text := 'Smestr ma`lumotlarini yuklab bo`lmadi.';
      mainform.maintab.ActiveTab := mainform.Login;
      mainform.AniIndicator1.Enabled := false;
    end;
  end;
end;

procedure dars_jadvali;
var
  udata: Tdatabase;
  sl: TStringList;
  k: Tujsonvalue;
begin
  udata.create;
  sl := TStringList.create;
  if (mainform.internet) then
  begin
    if (DataModule1.amal = 'd') then
    begin
      sl.LoadFromStream(mainform.stream);
      udata.writejson('dars', sl.Text);
      json.dars_jadvali_json(sl.Text);
    end
    else
    begin
      k := udata.readjson('dars');
      json.dars_jadvali_json(k.value);
    end;
  end
  else
  begin
    k := udata.readjson('dars');
    json.dars_jadvali_json(k.value);
    mainform.Button8.Text := 'Oxirgi yangilanish: ' + k.datetime;
    mainform.Button8.Visible := true;
  end;
end;

end.

unit json;

interface

uses system.json, system.Classes, system.SysUtils,
  system.Generics.Collections, fmx.Dialogs, fmx.Forms, fmx.Types,
  system.IOUtils, fmx.ListBox, system.DateUtils, dars_frame, system.UITypes,
  fmx.DialogService, fmx.TabControl
{$IFDEF MSWINDOWS}
    , Winapi.Windows
{$ENDIF};

procedure universitet_json(const tanlash: string);
procedure malumotlar_json(const value: string);
procedure dars_jadvali_json(const value: string);
procedure smestr_malumotlari(const value: string);
Function uformatdatatime(const date: Int64): Tdate;
procedure fan_malumotlari(const value: string);
procedure fan_malumotlari2(const fan, fan_m, value: string);
procedure nazorat_json(const value: string);
procedure davomad_json(const value: string);

var
  tablar: array of TTabItem;
  lisgroup: array of TListBoxGroupHeader;
  res: TResourceStream;

implementation

uses main, interbase, data, url, malumotlar_tahlil, fanlar_bolim, fanlar_frame,
  davomad_frame, davomad;

procedure nazorat_json(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject, subject: TJSONObject;
  data: TJSONArray;
  i: integer;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  data := JsonObject.GetValue('data') as TJSONArray;
  davomad_bolim.ListBox1.Clear;
  Delete(lisgroup, 0, high(lisgroup));
  Delete(dars_jadvali_frame, 0, high(dars_jadvali_frame));
  Delete(header, 0, HIGH(header));
  davomad_bolim.ListBox1.Clear;
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    SetLength(lisgroup, data.Count);
    SetLength(dars_jadvali_frame, data.Count);
    SetLength(header, data.Count);
    for i := 0 to data.Count - 1 do
    begin
      subject := data.Items[i] as TJSONObject;
      if (subject.GetValue('semester') as TJSONObject).GetValue('name')
        .value = mainform.smestr.ItemData.Detail then
      begin
        header[i] := TListBoxItem.Create(Application);
        lisgroup[i] := TListBoxGroupHeader.Create(Application);
        dars_jadvali_frame[i] := TFrame2.Create(Application);
        dars_jadvali_frame[i].Name := 'naz' + inttostr(i);
        dars_jadvali_frame[i].Parent := header[i];
        lisgroup[i].Text :=
          DateToStr(uformatdatatime(subject.GetValue('examDate')
          .value.ToInt64));
        if davomad_bolim.ListBox1.Items.IndexOf(lisgroup[i].Text) = -1 then
        begin
          lisgroup[i].Height := 40;
          davomad_bolim.ListBox1.AddObject(lisgroup[i]);
        end;
        dars_jadvali_frame[i].dars_kuni :=
          uformatdatatime(subject.GetValue('examDate').value.ToInt64);
        dars_jadvali_frame[i].dars_xonasi :=
          (subject.GetValue('auditorium') as TJSONObject)
          .GetValue('name').value;
        dars_jadvali_frame[i].dars_turi :=
          (subject.GetValue('examType') as TJSONObject).GetValue('name').value;
        dars_jadvali_frame[i].oqituvchi :=
          (subject.GetValue('employee') as TJSONObject).GetValue('name').value;
        dars_jadvali_frame[i].start_dars :=
          (subject.GetValue('lessonPair') as TJSONObject)
          .GetValue('start_time').value;
        dars_jadvali_frame[i].end_dars :=
          (subject.GetValue('lessonPair') as TJSONObject)
          .GetValue('end_time').value;
        dars_jadvali_frame[i].fan :=
          (subject.GetValue('subject') as TJSONObject).GetValue('name').value;
        dars_jadvali_frame[i].Timer1.Enabled := true;
        header[i].Height := 140;
        davomad_bolim.ListBox1.InsertObject
          (davomad_bolim.ListBox1.Items.IndexOf(lisgroup[i].Text) + 1,
          header[i])
      end;
    end;
    if davomad_bolim.ListBox1.Count = 0 then
    begin
{$IFDEF MSWINDOWS}
      res := TResourceStream.Create(HInstance, 'test', RT_RCDATA);
      davomad_bolim.Image1.Bitmap.LoadFromStream(res);
{$ELSE}
      davomad_bolim.Image1.Bitmap.LoadFromFile(TPath.GetDocumentsPath +
        '/Test.png');
{$ENDIF}
      davomad_bolim.Label1.Text := 'Ma`lumotlar mavjud emas !';
      davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem3;
    end;
  end
  else
  begin
    begin
{$IFDEF MSWINDOWS}
      MessageBox(0, Pwidechar(JsonObject.GetValue('error').value), 'ERROR',
        MB_OK + MB_ICONERROR);
{$ELSE}
      ShowMessage(JsonObject.GetValue('error').value);
{$ENDIF}
    end;
  end;

end;

procedure davomad_json(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject, subject: TJSONObject;
  data: TJSONArray;
  i: integer;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  data := JsonObject.GetValue('data') as TJSONArray;
  davomad_bolim.ListBox1.Clear;
  Delete(davomad_frame_item, 0, high(davomad_frame_item));
  Delete(davomad_list_item, 0, high(davomad_list_item));
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    data := JsonObject.GetValue('data') as TJSONArray;
    SetLength(davomad_list_item, data.Count);
    SetLength(davomad_frame_item, data.Count);
    for i := 0 to data.Count - 1 do
    begin
      subject := data.Items[i] as TJSONObject;
      if (subject.GetValue('semester') as TJSONObject).GetValue('code')
        .value.ToInteger = mainform.smestr_id then
      begin
        davomad_list_item[i] := TListBoxItem.Create(Application);
        davomad_frame_item[i] := TFrame6.Create(Application);
        davomad_frame_item[i].Parent := davomad_list_item[i];
        davomad_frame_item[i].Name := 'davomad_item' + inttostr(i);
        davomad_frame_item[i].Label1.Text :=
          (subject.GetValue('subject') as TJSONObject).GetValue('name').value;
        davomad_frame_item[i].Label5.Text :=
          (subject.GetValue('employee') as TJSONObject).GetValue('name').value;
        davomad_frame_item[i].Label4.Text :=
          (subject.GetValue('trainingType') as TJSONObject)
          .GetValue('name').value;
        davomad_frame_item[i].Label2.Text :=
          subject.GetValue('absent_off').value;
        davomad_frame_item[i].Label6.Text :=
          DateTimeToStr(UnixToDateTime(subject.GetValue('lesson_date')
          .value.ToInt64)) + ' ' +
          (subject.GetValue('lessonPair') as TJSONObject)
          .GetValue('start_time').value;
        davomad_list_item[i].Height := 140;
        davomad_bolim.ListBox1.AddObject(davomad_list_item[i]);
      end;
    end;
    if davomad_bolim.ListBox1.Count = 0 then
    begin
{$IFDEF MSWINDOWS}
      res := TResourceStream.Create(HInstance, 'ok', RT_RCDATA);
      davomad_bolim.Image1.Bitmap.LoadFromStream(res);
{$ELSE}
      davomad_bolim.Image1.Bitmap.LoadFromFile(TPath.GetDocumentsPath +
        '/ok.png');
{$ENDIF}
      davomad_bolim.Label1.Text := 'Siz hech qanday dars qoldirmagansiz !';
      davomad_bolim.TabControl1.ActiveTab := davomad_bolim.TabItem3;
    end;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    MessageBox(0, Pwidechar(JsonObject.GetValue('error').value), 'ERROR',
      MB_OK + MB_ICONERROR);
{$ELSE}
    ShowMessage(JsonObject.GetValue('error').value);
{$ENDIF}
  end;
end;

procedure fan_malumotlari2(const fan, fan_m, value: string);
var
  JsonValue: TJSONValue;
  JsonObject, curriculumSubject: TJSONObject;
  data, gradlesexsemple: TJSONArray;
  i, n: integer;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  data := JsonObject.GetValue('data') as TJSONArray;
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    Delete(fanlar_frame_item_click, 0, high(fanlar_frame_item_click));
    for i := 0 to fanlar_haqida.TabControl2.TabCount - 1 do
      fanlar_haqida.TabControl2.Tabs[i].Free;
    for i := 0 to data.Count - 1 do
    begin
      curriculumSubject := (data.Items[i] as TJSONObject)
        .GetValue('curriculumSubject') as TJSONObject;
      if (curriculumSubject.GetValue('subject') as TJSONObject).GetValue('name')
        .value = fan then
      begin
        gradlesexsemple := (data.Items[i] as TJSONObject)
          .GetValue('gradesByExam') as TJSONArray;
        Delete(tablar, 0, high(tablar));
        for n := 0 to fanlar_haqida.TabControl2.TabCount - 1 do
          fanlar_haqida.TabControl2.Tabs[n].Free;
        SetLength(tablar, gradlesexsemple.Count);
        SetLength(fanlar_frame_item_click, gradlesexsemple.Count);
        for n := 0 to gradlesexsemple.Count - 1 do
        begin
          fanlar_frame_item_click[n] := TFrame3.Create(Application);
          fanlar_frame_item_click[n].Name := 'fanlar_paneli' + inttostr(n);
          fanlar_frame_item_click[n].Label2.Text := fan;
          fanlar_frame_item_click[n].Label3.Text := fan_m;
          fanlar_frame_item_click[n].overall :=
            (gradlesexsemple.Items[n] as TJSONObject).GetValue('grade')
            .value.ToInteger;
          fanlar_frame_item_click[n].overall_max :=
            (gradlesexsemple.Items[n] as TJSONObject).GetValue('max_ball')
            .value.ToInteger;
          fanlar_frame_item_click[n].overall_foiz :=
            (gradlesexsemple.Items[n] as TJSONObject).GetValue('percent')
            .value.ToInteger;
          fanlar_frame_item_click[n].Timer1.Enabled := true;
          tablar[n] := TTabItem.Create(Application);
          tablar[n].Name := 'fanlar' + inttostr(n);
          tablar[n].Text := ((gradlesexsemple.Items[n] as TJSONObject)
            .GetValue('examType') as TJSONObject).GetValue('name').value;
          tablar[n].AutoSize := true;
          fanlar_frame_item_click[n].Image1.Visible := false;
          fanlar_haqida.TabControl2.AddObject(tablar[n]);
          fanlar_frame_item_click[n].Parent := fanlar_haqida.TabControl2.Tabs
            [fanlar_haqida.TabControl2.TabCount - 1];
          fanlar_frame_item_click[n].Timer1.Enabled := true;
        end;
      end;
    end;
    fanlar_haqida.TabControl1.ActiveTab := fanlar_haqida.umumiy;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    MessageBox(0, Pwidechar(JsonObject.GetValue('error').value), 'ERROR',
      MB_OK + MB_ICONERROR);
{$ELSE}
    ShowMessage(JsonObject.GetValue('error').value);
{$ENDIF}
  end;
end;

procedure fan_malumotlari(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject, curriculumSubject, overallScore: TJSONObject;
  data: TJSONArray;
  i: integer;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    data := JsonObject.GetValue('data') as TJSONArray;
    fanlar_haqida.ListBox1.Clear;
    Delete(fanlar_frame_item, 0, high(fanlar_frame_item));
    Delete(fanlar_haqida_item, 0, high(fanlar_haqida_item));
    Delete(fanlar_frame_item, 0, high(fanlar_frame_item));
    SetLength(fanlar_frame_item, data.Count);
    SetLength(fanlar_haqida_item, data.Count);
    for i := 0 to data.Count - 1 do
    begin
      if (data.Items[i] as TJSONObject).GetValue('_semester')
        .value.ToInteger = mainform.smestr_id then
      begin
        fanlar_frame_item[i] := TFrame3.Create(Application);
        fanlar_haqida_item[i] := TListBoxItem.Create(Application);
        fanlar_frame_item[i].Name := 'fan' + inttostr(i);
        fanlar_frame_item[i].Parent := fanlar_haqida_item[i];
        curriculumSubject := (data.Items[i] as TJSONObject)
          .GetValue('curriculumSubject') as TJSONObject;
        fanlar_frame_item[i].Label2.Text :=
          ((curriculumSubject.GetValue('subject')) as TJSONObject)
          .GetValue('name').value;
        fanlar_frame_item[i].Label3.Text :=
          ((curriculumSubject.GetValue('subjectType')) as TJSONObject)
          .GetValue('name').value;
        fanlar_frame_item[i].Label3.Text := fanlar_frame_item[i].Label3.Text +
          ' | ' + curriculumSubject.GetValue('total_acload').value + ' soat';
        overallScore := (data.Items[i] as TJSONObject).GetValue('overallScore')
          as TJSONObject;
        fanlar_frame_item[i].Label3.Text := fanlar_frame_item[i].Label3.Text +
          ' | ' + curriculumSubject.GetValue('credit').value + ' Kredit';
        fanlar_frame_item[i].overall := overallScore.GetValue('grade')
          .value.ToInteger;
        fanlar_frame_item[i].overall_max := overallScore.GetValue('max_ball')
          .value.ToInteger;
        fanlar_frame_item[i].overall_foiz := overallScore.GetValue('percent')
          .value.ToInteger;
        fanlar_haqida_item[i].Height := 140;
        fanlar_frame_item[i].Timer1.Enabled := true;
        fanlar_haqida.ListBox1.AddObject(fanlar_haqida_item[i]);
      end;
    end;
    fanlar_haqida.TabControl1.ActiveTab := fanlar_haqida.fanlar;
    fanlar_haqida.AniIndicator1.Enabled := false;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    MessageBox(0, Pwidechar(JsonObject.GetValue('error').value), 'ERROR',
      MB_OK + MB_ICONERROR);
{$ELSE}
    ShowMessage(JsonObject.GetValue('error').value);
{$ENDIF}
  end;
end;

Function uformatdatatime(const date: Int64): Tdate;
var
  lessonDate: Tdate;
begin
  lessonDate := UnixToDateTime(date);
  result := lessonDate;
end;

procedure smestr_malumotlari(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject: TJSONObject;
  data: TJSONArray;
  i: integer;
  k: string;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  mainform.smestrlar_royhati.Clear;
  mainform.smestrlar_royhati.Items.Add('Joriy smestr');
  mainform.smestrlar_royhati.ItemIndex := 0;
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    data := JsonObject.GetValue('data') as TJSONArray;
    for i := 0 to data.Count - 1 do
    begin
      k := (data.Items[i] as TJSONObject).GetValue('name').value;
      mainform.smestrlar_royhati.Items.Add(k);
      mainform.smestrlar_royhati.ItemByIndex
        (mainform.smestrlar_royhati.Items.IndexOf(k)).ItemData.Accessory :=
        TListBoxItemData.TAccessory.aMore;
      if (data.Items[i] as TJSONObject).GetValue('current').value.ToBoolean then
      begin
        mainform.joriy_smestr := k;
        mainform.smestr.ItemData.Detail := k;
      end;
    end;
    if mainform.token = '' then
      mainform.smestr.Enabled := false
    else
      mainform.smestr.Enabled := true;
    mainform.smestrlar_royhati.ItemIndex := 0;
    mainform.ListBoxItem2Click(mainform.ListBox2);
    mainform.MultiView1.Enabled := true;
    mainform.SMESTRTAB.ActiveTab := mainform.menu;
    mainform.ListBox2.ItemIndex := 2;
    mainform.maintab.ActiveTab := mainform.mainmenu;
    mainform.AniIndicator1.Enabled := false;
  end
  else
  begin
    mainform.Label7.Text := JsonObject.GetValue('error').value;
    mainform.maintab.ActiveTab := mainform.Login;
    mainform.AniIndicator1.Enabled := false;
  end;

end;

procedure dars_jadvali_json(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject, subject, auditoriya, type_trening, employe, smestr,
    lessonsoati: TJSONObject;
  i: integer;
  data: TJSONArray;
begin
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  if JsonObject.GetValue('success').value.ToBoolean then
  begin
    data := JsonObject.GetValue('data') as TJSONArray;
    mainform.ListBox1.Clear;
    Delete(dars_jadvali_frame, 0, High(dars_jadvali_frame));
    Delete(header, 0, High(header));
    SetLength(dars_jadvali_frame, data.Count);
    SetLength(header, data.Count);
    for i := 0 to data.Count - 1 do
    begin
      smestr := (data.Items[i] as TJSONObject).GetValue('semester')
        as TJSONObject;
      if (uformatdatatime((data.Items[i] as TJSONObject).GetValue('lesson_date')
        .value.ToInt64) = mainform.DateEdit1.date) and
        (smestr.GetValue('name').value = mainform.smestr.ItemData.Detail) then
      begin
        header[i] := TListBoxItem.Create(Application);
        dars_jadvali_frame[i] := TFrame2.Create(Application);
        dars_jadvali_frame[i].Name := 'dars' + inttostr(i);
        dars_jadvali_frame[i].Parent := header[i];
        header[i].Height := 130;
        subject := (data.Items[i] as TJSONObject).GetValue('subject')
          as TJSONObject;
        auditoriya := (data.Items[i] as TJSONObject).GetValue('auditorium')
          as TJSONObject;
        type_trening := (data.Items[i] as TJSONObject).GetValue('trainingType')
          as TJSONObject;
        employe := (data.Items[i] as TJSONObject).GetValue('employee')
          as TJSONObject;
        lessonsoati := (data.Items[i] as TJSONObject).GetValue('lessonPair')
          as TJSONObject;
        dars_jadvali_frame[i].oqituvchi := employe.GetValue('name').value;
        dars_jadvali_frame[i].dars_turi := type_trening.GetValue('name')
          .value + ' ';
        dars_jadvali_frame[i].fan := subject.GetValue('name').value;
        dars_jadvali_frame[i].dars_xonasi := auditoriya.GetValue('name').value;
        dars_jadvali_frame[i].start_dars :=
          lessonsoati.GetValue('start_time').value;
        dars_jadvali_frame[i].end_dars :=
          lessonsoati.GetValue('end_time').value;
        dars_jadvali_frame[i].dars_kuni :=
          UnixToDateTime((data.Items[i] as TJSONObject).GetValue('lesson_date')
          .value.ToInt64).GetDate;
{$IFDEF MSWINDOWS}
        dars_jadvali_frame[i].Label5.TextSettings.Font.Size := 12;
        dars_jadvali_frame[i].Label6.TextSettings.Font.Size := 12;
        dars_jadvali_frame[i].Label4.TextSettings.Font.Size := 12;
        dars_jadvali_frame[i].Label1.TextSettings.Font.Size := 14;
{$ENDIF}
        mainform.ListBox1.AddObject(header[i]);
      end;
    end;
    mainform.AniIndicator2.Enabled := false;
    if mainform.ListBox1.Items.Count > 0 then
      mainform.dars_jadvali_boshqaruv.ActiveTab := mainform.dars
    else
      mainform.dars_jadvali_boshqaruv.ActiveTab := mainform.dam;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    MessageBox(0, Pwidechar(JsonObject.GetValue('error').value), 'ERROR',
      MB_OK + MB_ICONERROR);
{$ELSE}
    ShowMessage(JsonObject.GetValue('error').value);
{$ENDIF}
  end;
end;

procedure malumotlar_json(const value: string);
var
  JsonValue: TJSONValue;
  JsonObject: TJSONObject;
  udata: Tdatabase;
  data, lavel, group: TJSONObject;
begin
  udata.Create;
  JsonValue := TJSONObject.ParseJSONValue(value);
  JsonObject := TJSONObject(JsonValue);
  if JsonObject.GetValue('success').value.ToBoolean = true then
  begin
    DataModule1.rasm := TMemoryStream.Create;
    data := JsonObject.GetValue('data') as TJSONObject;
    lavel := data.GetValue('level') as TJSONObject;
    group := data.GetValue('group') as TJSONObject;
    mainform.kurs.Text := lavel.GetValue('name').value;
    mainform.guruh.Text := group.GetValue('name').value + ' guruh talabasi';
    mainform.ism.Text := data.GetValue('first_name').value;
    mainform.familiya.Text := data.GetValue('second_name').value;
{$IFDEF MSWINDOWS}
    if FileExists(TPath.GetHomePath + '\Talaba\avatar.jpg') then
      mainform.Circle1.Fill.Bitmap.Bitmap.LoadFromFile
        (TPath.GetHomePath + '\Talaba\avatar.jpg')
{$ELSE}
    if FileExists(TPath.GetDocumentsPath + '/avatar.jpg') then
      mainform.Circle1.Fill.Bitmap.Bitmap.LoadFromFile(TPath.GetDocumentsPath +
        '/avatar.jpg')
{$ENDIF}
    else
    begin
      if mainform.internet = true then
      begin
        DataModule1.rasm_profile.Get(data.GetValue('image').value,
          DataModule1.rasm);
      end
      else
      begin
        mainform.Label7.Text :=
          'Talaba ma`lumotlarini olib bo`lmadi. Internetga ulanganingizni tekshiring.';
        mainform.maintab.ActiveTab := mainform.Login;
        mainform.AniIndicator1.Enabled := false;
        exit;
      end;
    end;
    if (mainform.token <> '') and (mainform.internet) then
    begin
      mainform.stream := TMemoryStream.Create;
      DataModule1.smestrgetclient.CustomHeaders['Authorization'] := 'Bearer ' +
        mainform.token;
      DataModule1.smestrgetclient.Get(udata.read_universitet(2) + url.smestr,
        mainform.stream);
      DataModule1.amal := '2';
    end
    else
      malumotlar_tahlil.smestr_malumotlari;
  end
  else
  begin
    mainform.Label7.Text := JsonObject.GetValue('error').value;
    mainform.maintab.ActiveTab := mainform.Login;
    mainform.AniIndicator1.Enabled := false;
  end;
end;

procedure universitet_json;
begin
{$IFDEF MSWINDOWS}
  TThread.CreateAnonymousThread(
    procedure
    var
      i: integer;
      jsonArray: TJSONArray;
      JsonValue: TJSONValue;
      JsonObject: TJSONObject;
      sl: TStringList;
      s: string;
      res: TStream;
      udata: Tdatabase;
    begin
      sl := TStringList.Create;
      res := TResourceStream.Create(HInstance, 'un', RT_RCDATA);
      sl.LoadFromStream(res);
      s := sl.Text;
      try
        JsonValue := TJSONObject.ParseJSONValue(s);
        JsonObject := TJSONObject(JsonValue);
        jsonArray := JsonObject.GetValue('data') as TJSONArray;
        mainform.universitetbox.Clear;
        for i := 0 to jsonArray.Count do
        begin
          if (jsonArray.Items[i] as TJSONObject).GetValue('api_url').value <> 'null'
          then
          begin
            if (jsonArray.Items[i] as TJSONObject).GetValue('name').value = tanlash
            then
            begin
              udata.Create;
              udata.save_universitet((jsonArray.Items[i] as TJSONObject)
                .GetValue('code').value.ToInteger,
                (jsonArray.Items[i] as TJSONObject).GetValue('name').value,
                (jsonArray.Items[i] as TJSONObject).GetValue('api_url').value);
              udata.stop;
              mainform.Label4.Text := (jsonArray.Items[i] as TJSONObject)
                .GetValue('name').value;
              mainform.Label7.Text := '';
              main.mainform.Edit1.Enabled := true;
              main.mainform.Edit2.Enabled := true;
              main.mainform.Button3.Enabled := true;
              main.mainform.Button4.Enabled := true;
              s := 'S';
              mainform.maintab.ActiveTab := mainform.Login;
              break;
            end
            else
              mainform.universitetbox.Items.Add
                ((jsonArray.Items[i] as TJSONObject).GetValue('name').value);
            mainform.universitetbox.ItemByIndex
              (mainform.universitetbox.Items.IndexOf((jsonArray.Items[i]
              as TJSONObject).GetValue('name').value)).ItemData.Accessory :=
              TListBoxItemData.TAccessory.aMore;
          end;
        end;
      finally
        if s <> 'S' then
        begin
          mainform.maintab.ActiveTab := mainform.universitetlar;
          sl.Free;
          res.Free;
        end;
      end;
    end).Start;
{$ELSE}
  exit;
{$ENDIF}
end;

end.

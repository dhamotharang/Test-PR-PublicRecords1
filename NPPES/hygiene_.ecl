import ut,SALT19;
export hygiene(dataset(NPPES.layout_Hygiene.layout_header) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_did_pcnt := ave(group,if(h.did = (typeof(h.did))'',0,100));
    maxlength_did := max(group,length(trim((string)h.did)));
    avelength_did := ave(group,length(trim((string)h.did)));
    populated_src_pcnt := ave(group,if(h.src = (typeof(h.src))'',0,100));
    maxlength_src := max(group,length(trim((string)h.src)));
    avelength_src := ave(group,length(trim((string)h.src)));
    populated_dt_first_seen_pcnt := ave(group,if(h.dt_first_seen = (typeof(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := max(group,length(trim((string)h.dt_first_seen)));
    avelength_dt_first_seen := ave(group,length(trim((string)h.dt_first_seen)));
    populated_dt_last_seen_pcnt := ave(group,if(h.dt_last_seen = (typeof(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := max(group,length(trim((string)h.dt_last_seen)));
    avelength_dt_last_seen := ave(group,length(trim((string)h.dt_last_seen)));
    populated_dt_vendor_first_reported_pcnt := ave(group,if(h.dt_vendor_first_reported = (typeof(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := max(group,length(trim((string)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := ave(group,length(trim((string)h.dt_vendor_first_reported)));
    populated_dt_vendor_last_reported_pcnt := ave(group,if(h.dt_vendor_last_reported = (typeof(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := max(group,length(trim((string)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := ave(group,length(trim((string)h.dt_vendor_last_reported)));
    populated_vendor_id_pcnt := ave(group,if(h.vendor_id = (typeof(h.vendor_id))'',0,100));
    maxlength_vendor_id := max(group,length(trim((string)h.vendor_id)));
    avelength_vendor_id := ave(group,length(trim((string)h.vendor_id)));
    populated_phone_pcnt := ave(group,if(h.phone = (typeof(h.phone))'',0,100));
    maxlength_phone := max(group,length(trim((string)h.phone)));
    avelength_phone := ave(group,length(trim((string)h.phone)));
    populated_title_pcnt := ave(group,if(h.title = (typeof(h.title))'',0,100));
    maxlength_title := max(group,length(trim((string)h.title)));
    avelength_title := ave(group,length(trim((string)h.title)));
    populated_fname_pcnt := ave(group,if(h.fname = (typeof(h.fname))'',0,100));
    maxlength_fname := max(group,length(trim((string)h.fname)));
    avelength_fname := ave(group,length(trim((string)h.fname)));
    populated_mname_pcnt := ave(group,if(h.mname = (typeof(h.mname))'',0,100));
    maxlength_mname := max(group,length(trim((string)h.mname)));
    avelength_mname := ave(group,length(trim((string)h.mname)));
    populated_lname_pcnt := ave(group,if(h.lname = (typeof(h.lname))'',0,100));
    maxlength_lname := max(group,length(trim((string)h.lname)));
    avelength_lname := ave(group,length(trim((string)h.lname)));
    populated_name_suffix_pcnt := ave(group,if(h.name_suffix = (typeof(h.name_suffix))'',0,100));
    maxlength_name_suffix := max(group,length(trim((string)h.name_suffix)));
    avelength_name_suffix := ave(group,length(trim((string)h.name_suffix)));
    populated_prim_range_pcnt := ave(group,if(h.prim_range = (typeof(h.prim_range))'',0,100));
    maxlength_prim_range := max(group,length(trim((string)h.prim_range)));
    avelength_prim_range := ave(group,length(trim((string)h.prim_range)));
    populated_predir_pcnt := ave(group,if(h.predir = (typeof(h.predir))'',0,100));
    maxlength_predir := max(group,length(trim((string)h.predir)));
    avelength_predir := ave(group,length(trim((string)h.predir)));
    populated_prim_name_pcnt := ave(group,if(h.prim_name = (typeof(h.prim_name))'',0,100));
    maxlength_prim_name := max(group,length(trim((string)h.prim_name)));
    avelength_prim_name := ave(group,length(trim((string)h.prim_name)));
    populated_suffix_pcnt := ave(group,if(h.suffix = (typeof(h.suffix))'',0,100));
    maxlength_suffix := max(group,length(trim((string)h.suffix)));
    avelength_suffix := ave(group,length(trim((string)h.suffix)));
    populated_postdir_pcnt := ave(group,if(h.postdir = (typeof(h.postdir))'',0,100));
    maxlength_postdir := max(group,length(trim((string)h.postdir)));
    avelength_postdir := ave(group,length(trim((string)h.postdir)));
    populated_unit_desig_pcnt := ave(group,if(h.unit_desig = (typeof(h.unit_desig))'',0,100));
    maxlength_unit_desig := max(group,length(trim((string)h.unit_desig)));
    avelength_unit_desig := ave(group,length(trim((string)h.unit_desig)));
    populated_sec_range_pcnt := ave(group,if(h.sec_range = (typeof(h.sec_range))'',0,100));
    maxlength_sec_range := max(group,length(trim((string)h.sec_range)));
    avelength_sec_range := ave(group,length(trim((string)h.sec_range)));
    populated_city_name_pcnt := ave(group,if(h.city_name = (typeof(h.city_name))'',0,100));
    maxlength_city_name := max(group,length(trim((string)h.city_name)));
    avelength_city_name := ave(group,length(trim((string)h.city_name)));
    populated_st_pcnt := ave(group,if(h.st = (typeof(h.st))'',0,100));
    maxlength_st := max(group,length(trim((string)h.st)));
    avelength_st := ave(group,length(trim((string)h.st)));
    populated_zip_pcnt := ave(group,if(h.zip = (typeof(h.zip))'',0,100));
    maxlength_zip := max(group,length(trim((string)h.zip)));
    avelength_zip := ave(group,length(trim((string)h.zip)));
    populated_zip4_pcnt := ave(group,if(h.zip4 = (typeof(h.zip4))'',0,100));
    maxlength_zip4 := max(group,length(trim((string)h.zip4)));
    avelength_zip4 := ave(group,length(trim((string)h.zip4)));
    populated_county_pcnt := ave(group,if(h.county = (typeof(h.county))'',0,100));
    maxlength_county := max(group,length(trim((string)h.county)));
    avelength_county := ave(group,length(trim((string)h.county)));
    populated_msa_pcnt := ave(group,if(h.msa = (typeof(h.msa))'',0,100));
    maxlength_msa := max(group,length(trim((string)h.msa)));
    avelength_msa := ave(group,length(trim((string)h.msa)));
    populated_geo_blk_pcnt := ave(group,if(h.geo_blk = (typeof(h.geo_blk))'',0,100));
    maxlength_geo_blk := max(group,length(trim((string)h.geo_blk)));
    avelength_geo_blk := ave(group,length(trim((string)h.geo_blk)));
    populated_RawAID_pcnt := ave(group,if(h.RawAID = (typeof(h.RawAID))'',0,100));
    maxlength_RawAID := max(group,length(trim((string)h.RawAID)));
    avelength_RawAID := ave(group,length(trim((string)h.RawAID)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT19.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.did),trim((string)le.src),trim((string)le.dt_first_seen),trim((string)le.dt_last_seen),trim((string)le.dt_vendor_first_reported),trim((string)le.dt_vendor_last_reported),trim((string)le.vendor_id),trim((string)le.phone),trim((string)le.title),trim((string)le.fname),trim((string)le.mname),trim((string)le.lname),trim((string)le.name_suffix),trim((string)le.prim_range),trim((string)le.predir),trim((string)le.prim_name),trim((string)le.suffix),trim((string)le.postdir),trim((string)le.unit_desig),trim((string)le.sec_range),trim((string)le.city_name),trim((string)le.st),trim((string)le.zip),trim((string)le.zip4),trim((string)le.county),trim((string)le.msa),trim((string)le.geo_blk),trim((string)le.RawAID)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'did'}
      ,{2,'src'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'vendor_id'}
      ,{8,'phone'}
      ,{9,'title'}
      ,{10,'fname'}
      ,{11,'mname'}
      ,{12,'lname'}
      ,{13,'name_suffix'}
      ,{14,'prim_range'}
      ,{15,'predir'}
      ,{16,'prim_name'}
      ,{17,'suffix'}
      ,{18,'postdir'}
      ,{19,'unit_desig'}
      ,{20,'sec_range'}
      ,{21,'city_name'}
      ,{22,'st'}
      ,{23,'zip'}
      ,{24,'zip4'}
      ,{25,'county'}
      ,{26,'msa'}
      ,{27,'geo_blk'}
      ,{28,'RawAID'}],SALT19.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT19.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export did_profile := All_Profiles(FldNo=1);
export src_profile := All_Profiles(FldNo=2);
export dt_first_seen_profile := All_Profiles(FldNo=3);
export dt_last_seen_profile := All_Profiles(FldNo=4);
export dt_vendor_first_reported_profile := All_Profiles(FldNo=5);
export dt_vendor_last_reported_profile := All_Profiles(FldNo=6);
export vendor_id_profile := All_Profiles(FldNo=7);
export phone_profile := All_Profiles(FldNo=8);
export title_profile := All_Profiles(FldNo=9);
export fname_profile := All_Profiles(FldNo=10);
export mname_profile := All_Profiles(FldNo=11);
export lname_profile := All_Profiles(FldNo=12);
export name_suffix_profile := All_Profiles(FldNo=13);
export prim_range_profile := All_Profiles(FldNo=14);
export predir_profile := All_Profiles(FldNo=15);
export prim_name_profile := All_Profiles(FldNo=16);
export suffix_profile := All_Profiles(FldNo=17);
export postdir_profile := All_Profiles(FldNo=18);
export unit_desig_profile := All_Profiles(FldNo=19);
export sec_range_profile := All_Profiles(FldNo=20);
export city_name_profile := All_Profiles(FldNo=21);
export st_profile := All_Profiles(FldNo=22);
export zip_profile := All_Profiles(FldNo=23);
export zip4_profile := All_Profiles(FldNo=24);
export county_profile := All_Profiles(FldNo=25);
export msa_profile := All_Profiles(FldNo=26);
export geo_blk_profile := All_Profiles(FldNo=27);
export RawAID_profile := All_Profiles(FldNo=28);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_did((string)le.did),
    Fields.InValid_src((string)le.src),
    Fields.InValid_dt_first_seen((string)le.dt_first_seen),
    Fields.InValid_dt_last_seen((string)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((string)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((string)le.dt_vendor_last_reported),
    Fields.InValid_vendor_id((string)le.vendor_id),
    Fields.InValid_phone((string)le.phone),
    Fields.InValid_title((string)le.title),
    Fields.InValid_fname((string)le.fname),
    Fields.InValid_mname((string)le.mname),
    Fields.InValid_lname((string)le.lname),
    Fields.InValid_name_suffix((string)le.name_suffix),
    Fields.InValid_prim_range((string)le.prim_range),
    Fields.InValid_predir((string)le.predir),
    Fields.InValid_prim_name((string)le.prim_name),
    Fields.InValid_suffix((string)le.suffix),
    Fields.InValid_postdir((string)le.postdir),
    Fields.InValid_unit_desig((string)le.unit_desig),
    Fields.InValid_sec_range((string)le.sec_range),
    Fields.InValid_city_name((string)le.city_name),
    Fields.InValid_st((string)le.st),
    Fields.InValid_zip((string)le.zip),
    Fields.InValid_zip4((string)le.zip4),
    Fields.InValid_county((string)le.county),
    Fields.InValid_msa((string)le.msa),
    Fields.InValid_geo_blk((string)le.geo_blk),
    Fields.InValid_RawAID((string)le.RawAID),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,28,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'did','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','vendor_id','phone','title','fname','mname','lname','name_suffix','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','county','msa','geo_blk','RawAID');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_RawAID(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
end;

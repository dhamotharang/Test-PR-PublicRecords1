import ut,SALT20;
export hygiene(dataset(layout_as_bh) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_rcid_pcnt := ave(group,if(h.rcid = (typeof(h.rcid))'',0,100));
    maxlength_rcid := max(group,length(trim((string)h.rcid)));
    avelength_rcid := ave(group,length(trim((string)h.rcid)));
    populated_bdid_pcnt := ave(group,if(h.bdid = (typeof(h.bdid))'',0,100));
    maxlength_bdid := max(group,length(trim((string)h.bdid)));
    avelength_bdid := ave(group,length(trim((string)h.bdid)));
    populated_source_pcnt := ave(group,if(h.source = (typeof(h.source))'',0,100));
    maxlength_source := max(group,length(trim((string)h.source)));
    avelength_source := ave(group,length(trim((string)h.source)));
    populated_source_group_pcnt := ave(group,if(h.source_group = (typeof(h.source_group))'',0,100));
    maxlength_source_group := max(group,length(trim((string)h.source_group)));
    avelength_source_group := ave(group,length(trim((string)h.source_group)));
    populated_pflag_pcnt := ave(group,if(h.pflag = (typeof(h.pflag))'',0,100));
    maxlength_pflag := max(group,length(trim((string)h.pflag)));
    avelength_pflag := ave(group,length(trim((string)h.pflag)));
    populated_group1_id_pcnt := ave(group,if(h.group1_id = (typeof(h.group1_id))'',0,100));
    maxlength_group1_id := max(group,length(trim((string)h.group1_id)));
    avelength_group1_id := ave(group,length(trim((string)h.group1_id)));
    populated_vendor_id_pcnt := ave(group,if(h.vendor_id = (typeof(h.vendor_id))'',0,100));
    maxlength_vendor_id := max(group,length(trim((string)h.vendor_id)));
    avelength_vendor_id := ave(group,length(trim((string)h.vendor_id)));
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
    populated_company_name_pcnt := ave(group,if(h.company_name = (typeof(h.company_name))'',0,100));
    maxlength_company_name := max(group,length(trim((string)h.company_name)));
    avelength_company_name := ave(group,length(trim((string)h.company_name)));
    populated_prim_range_pcnt := ave(group,if(h.prim_range = (typeof(h.prim_range))'',0,100));
    maxlength_prim_range := max(group,length(trim((string)h.prim_range)));
    avelength_prim_range := ave(group,length(trim((string)h.prim_range)));
    populated_predir_pcnt := ave(group,if(h.predir = (typeof(h.predir))'',0,100));
    maxlength_predir := max(group,length(trim((string)h.predir)));
    avelength_predir := ave(group,length(trim((string)h.predir)));
    populated_prim_name_pcnt := ave(group,if(h.prim_name = (typeof(h.prim_name))'',0,100));
    maxlength_prim_name := max(group,length(trim((string)h.prim_name)));
    avelength_prim_name := ave(group,length(trim((string)h.prim_name)));
    populated_addr_suffix_pcnt := ave(group,if(h.addr_suffix = (typeof(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := max(group,length(trim((string)h.addr_suffix)));
    avelength_addr_suffix := ave(group,length(trim((string)h.addr_suffix)));
    populated_postdir_pcnt := ave(group,if(h.postdir = (typeof(h.postdir))'',0,100));
    maxlength_postdir := max(group,length(trim((string)h.postdir)));
    avelength_postdir := ave(group,length(trim((string)h.postdir)));
    populated_unit_desig_pcnt := ave(group,if(h.unit_desig = (typeof(h.unit_desig))'',0,100));
    maxlength_unit_desig := max(group,length(trim((string)h.unit_desig)));
    avelength_unit_desig := ave(group,length(trim((string)h.unit_desig)));
    populated_sec_range_pcnt := ave(group,if(h.sec_range = (typeof(h.sec_range))'',0,100));
    maxlength_sec_range := max(group,length(trim((string)h.sec_range)));
    avelength_sec_range := ave(group,length(trim((string)h.sec_range)));
    populated_city_pcnt := ave(group,if(h.city = (typeof(h.city))'',0,100));
    maxlength_city := max(group,length(trim((string)h.city)));
    avelength_city := ave(group,length(trim((string)h.city)));
    populated_state_pcnt := ave(group,if(h.state = (typeof(h.state))'',0,100));
    maxlength_state := max(group,length(trim((string)h.state)));
    avelength_state := ave(group,length(trim((string)h.state)));
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
    populated_geo_lat_pcnt := ave(group,if(h.geo_lat = (typeof(h.geo_lat))'',0,100));
    maxlength_geo_lat := max(group,length(trim((string)h.geo_lat)));
    avelength_geo_lat := ave(group,length(trim((string)h.geo_lat)));
    populated_geo_long_pcnt := ave(group,if(h.geo_long = (typeof(h.geo_long))'',0,100));
    maxlength_geo_long := max(group,length(trim((string)h.geo_long)));
    avelength_geo_long := ave(group,length(trim((string)h.geo_long)));
    populated_phone_pcnt := ave(group,if(h.phone = (typeof(h.phone))'',0,100));
    maxlength_phone := max(group,length(trim((string)h.phone)));
    avelength_phone := ave(group,length(trim((string)h.phone)));
    populated_phone_score_pcnt := ave(group,if(h.phone_score = (typeof(h.phone_score))'',0,100));
    maxlength_phone_score := max(group,length(trim((string)h.phone_score)));
    avelength_phone_score := ave(group,length(trim((string)h.phone_score)));
    populated_fein_pcnt := ave(group,if(h.fein = (typeof(h.fein))'',0,100));
    maxlength_fein := max(group,length(trim((string)h.fein)));
    avelength_fein := ave(group,length(trim((string)h.fein)));
    populated_current_pcnt := ave(group,if(h.current = (typeof(h.current))'',0,100));
    maxlength_current := max(group,length(trim((string)h.current)));
    avelength_current := ave(group,length(trim((string)h.current)));
    populated_dppa_pcnt := ave(group,if(h.dppa = (typeof(h.dppa))'',0,100));
    maxlength_dppa := max(group,length(trim((string)h.dppa)));
    avelength_dppa := ave(group,length(trim((string)h.dppa)));
    populated_vl_id_pcnt := ave(group,if(h.vl_id = (typeof(h.vl_id))'',0,100));
    maxlength_vl_id := max(group,length(trim((string)h.vl_id)));
    avelength_vl_id := ave(group,length(trim((string)h.vl_id)));
    populated_RawAID_pcnt := ave(group,if(h.RawAID = (typeof(h.RawAID))'',0,100));
    maxlength_RawAID := max(group,length(trim((string)h.RawAID)));
    avelength_RawAID := ave(group,length(trim((string)h.RawAID)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT20.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.rcid),trim((string)le.bdid),trim((string)le.source),trim((string)le.source_group),trim((string)le.pflag),trim((string)le.group1_id),trim((string)le.vendor_id),trim((string)le.dt_first_seen),trim((string)le.dt_last_seen),trim((string)le.dt_vendor_first_reported),trim((string)le.dt_vendor_last_reported),trim((string)le.company_name),trim((string)le.prim_range),trim((string)le.predir),trim((string)le.prim_name),trim((string)le.addr_suffix),trim((string)le.postdir),trim((string)le.unit_desig),trim((string)le.sec_range),trim((string)le.city),trim((string)le.state),trim((string)le.zip),trim((string)le.zip4),trim((string)le.county),trim((string)le.msa),trim((string)le.geo_lat),trim((string)le.geo_long),trim((string)le.phone),trim((string)le.phone_score),trim((string)le.fein),trim((string)le.current),trim((string)le.dppa),trim((string)le.vl_id),trim((string)le.RawAID)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,34,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'rcid'}
      ,{2,'bdid'}
      ,{3,'source'}
      ,{4,'source_group'}
      ,{5,'pflag'}
      ,{6,'group1_id'}
      ,{7,'vendor_id'}
      ,{8,'dt_first_seen'}
      ,{9,'dt_last_seen'}
      ,{10,'dt_vendor_first_reported'}
      ,{11,'dt_vendor_last_reported'}
      ,{12,'company_name'}
      ,{13,'prim_range'}
      ,{14,'predir'}
      ,{15,'prim_name'}
      ,{16,'addr_suffix'}
      ,{17,'postdir'}
      ,{18,'unit_desig'}
      ,{19,'sec_range'}
      ,{20,'city'}
      ,{21,'state'}
      ,{22,'zip'}
      ,{23,'zip4'}
      ,{24,'county'}
      ,{25,'msa'}
      ,{26,'geo_lat'}
      ,{27,'geo_long'}
      ,{28,'phone'}
      ,{29,'phone_score'}
      ,{30,'fein'}
      ,{31,'current'}
      ,{32,'dppa'}
      ,{33,'vl_id'}
      ,{34,'RawAID'}],SALT20.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT20.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export rcid_profile := All_Profiles(FldNo=1);
export bdid_profile := All_Profiles(FldNo=2);
export source_profile := All_Profiles(FldNo=3);
export source_group_profile := All_Profiles(FldNo=4);
export pflag_profile := All_Profiles(FldNo=5);
export group1_id_profile := All_Profiles(FldNo=6);
export vendor_id_profile := All_Profiles(FldNo=7);
export dt_first_seen_profile := All_Profiles(FldNo=8);
export dt_last_seen_profile := All_Profiles(FldNo=9);
export dt_vendor_first_reported_profile := All_Profiles(FldNo=10);
export dt_vendor_last_reported_profile := All_Profiles(FldNo=11);
export company_name_profile := All_Profiles(FldNo=12);
export prim_range_profile := All_Profiles(FldNo=13);
export predir_profile := All_Profiles(FldNo=14);
export prim_name_profile := All_Profiles(FldNo=15);
export addr_suffix_profile := All_Profiles(FldNo=16);
export postdir_profile := All_Profiles(FldNo=17);
export unit_desig_profile := All_Profiles(FldNo=18);
export sec_range_profile := All_Profiles(FldNo=19);
export city_profile := All_Profiles(FldNo=20);
export state_profile := All_Profiles(FldNo=21);
export zip_profile := All_Profiles(FldNo=22);
export zip4_profile := All_Profiles(FldNo=23);
export county_profile := All_Profiles(FldNo=24);
export msa_profile := All_Profiles(FldNo=25);
export geo_lat_profile := All_Profiles(FldNo=26);
export geo_long_profile := All_Profiles(FldNo=27);
export phone_profile := All_Profiles(FldNo=28);
export phone_score_profile := All_Profiles(FldNo=29);
export fein_profile := All_Profiles(FldNo=30);
export current_profile := All_Profiles(FldNo=31);
export dppa_profile := All_Profiles(FldNo=32);
export vl_id_profile := All_Profiles(FldNo=33);
export RawAID_profile := All_Profiles(FldNo=34);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_rcid((string)le.rcid),
    Fields.InValid_bdid((string)le.bdid),
    Fields.InValid_source((string)le.source),
    Fields.InValid_source_group((string)le.source_group),
    Fields.InValid_pflag((string)le.pflag),
    Fields.InValid_group1_id((string)le.group1_id),
    Fields.InValid_vendor_id((string)le.vendor_id),
    Fields.InValid_dt_first_seen((string)le.dt_first_seen),
    Fields.InValid_dt_last_seen((string)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((string)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((string)le.dt_vendor_last_reported),
    Fields.InValid_company_name((string)le.company_name),
    Fields.InValid_prim_range((string)le.prim_range),
    Fields.InValid_predir((string)le.predir),
    Fields.InValid_prim_name((string)le.prim_name),
    Fields.InValid_addr_suffix((string)le.addr_suffix),
    Fields.InValid_postdir((string)le.postdir),
    Fields.InValid_unit_desig((string)le.unit_desig),
    Fields.InValid_sec_range((string)le.sec_range),
    Fields.InValid_city((string)le.city),
    Fields.InValid_state((string)le.state),
    Fields.InValid_zip((string)le.zip),
    Fields.InValid_zip4((string)le.zip4),
    Fields.InValid_county((string)le.county),
    Fields.InValid_msa((string)le.msa),
    Fields.InValid_geo_lat((string)le.geo_lat),
    Fields.InValid_geo_long((string)le.geo_long),
    Fields.InValid_phone((string)le.phone),
    Fields.InValid_phone_score((string)le.phone_score),
    Fields.InValid_fein((string)le.fein),
    Fields.InValid_current((string)le.current),
    Fields.InValid_dppa((string)le.dppa),
    Fields.InValid_vl_id((string)le.vl_id),
    Fields.InValid_RawAID((string)le.RawAID),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,34,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'rcid','bdid','source','source_group','pflag','group1_id','vendor_id','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city','state','zip','zip4','county','msa','geo_lat','geo_long','phone','phone_score','fein','current','dppa','vl_id','RawAID');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_rcid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_source_group(TotalErrors.ErrorNum),Fields.InValidMessage_pflag(TotalErrors.ErrorNum),Fields.InValidMessage_group1_id(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_phone_score(TotalErrors.ErrorNum),Fields.InValidMessage_fein(TotalErrors.ErrorNum),Fields.InValidMessage_current(TotalErrors.ErrorNum),Fields.InValidMessage_dppa(TotalErrors.ErrorNum),Fields.InValidMessage_vl_id(TotalErrors.ErrorNum),Fields.InValidMessage_RawAID(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
end;

import ut,SALT27;
export hygiene(dataset(layout_DOT_Base) h) := MODULE
 
//A simple summary record
export Summary(SALT27.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_hist_enterprise_number_pcnt := AVE(GROUP,IF(h.hist_enterprise_number = (TYPEOF(h.hist_enterprise_number))'',0,100));
    maxlength_hist_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_enterprise_number)));
    avelength_hist_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_enterprise_number)),h.hist_enterprise_number<>(typeof(h.hist_enterprise_number))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_ebr_file_number_pcnt := AVE(GROUP,IF(h.ebr_file_number = (TYPEOF(h.ebr_file_number))'',0,100));
    maxlength_ebr_file_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.ebr_file_number)));
    avelength_ebr_file_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.ebr_file_number)),h.ebr_file_number<>(typeof(h.ebr_file_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_iscorp_pcnt := AVE(GROUP,IF(h.iscorp = (TYPEOF(h.iscorp))'',0,100));
    maxlength_iscorp := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.iscorp)));
    avelength_iscorp := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.iscorp)),h.iscorp<>(typeof(h.iscorp))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_name_type_raw_pcnt := AVE(GROUP,IF(h.company_name_type_raw = (TYPEOF(h.company_name_type_raw))'',0,100));
    maxlength_company_name_type_raw := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name_type_raw)));
    avelength_company_name_type_raw := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name_type_raw)),h.company_name_type_raw<>(typeof(h.company_name_type_raw))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_cnp_hasnumber_pcnt := AVE(GROUP,IF(h.cnp_hasnumber = (TYPEOF(h.cnp_hasnumber))'',0,100));
    maxlength_cnp_hasnumber := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_hasnumber)));
    avelength_cnp_hasnumber := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_hasnumber)),h.cnp_hasnumber<>(typeof(h.cnp_hasnumber))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_foreign_domestic_pcnt := AVE(GROUP,IF(h.company_foreign_domestic = (TYPEOF(h.company_foreign_domestic))'',0,100));
    maxlength_company_foreign_domestic := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_foreign_domestic)));
    avelength_company_foreign_domestic := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_foreign_domestic)),h.company_foreign_domestic<>(typeof(h.company_foreign_domestic))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
  RETURN table(h,SummaryLayout);
END;
 
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT27.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT27.StrType)le.cnp_number),TRIM((SALT27.StrType)le.prim_range),TRIM((SALT27.StrType)le.prim_name),TRIM((SALT27.StrType)le.st),TRIM((SALT27.StrType)le.active_enterprise_number),TRIM((SALT27.StrType)le.hist_enterprise_number),TRIM((SALT27.StrType)le.hist_domestic_corp_key),TRIM((SALT27.StrType)le.unk_corp_key),TRIM((SALT27.StrType)le.ebr_file_number),TRIM((SALT27.StrType)le.active_duns_number),TRIM((SALT27.StrType)le.active_domestic_corp_key),TRIM((SALT27.StrType)le.hist_duns_number),TRIM((SALT27.StrType)le.foreign_corp_key),TRIM((SALT27.StrType)le.company_fein),TRIM((SALT27.StrType)le.company_phone),TRIM((SALT27.StrType)le.cnp_name),TRIM((SALT27.StrType)le.zip),TRIM((SALT27.StrType)le.sec_range),TRIM((SALT27.StrType)le.v_city_name),TRIM((SALT27.StrType)le.cnp_btype),TRIM((SALT27.StrType)le.iscorp),TRIM((SALT27.StrType)le.company_name),TRIM((SALT27.StrType)le.company_name_type_raw),TRIM((SALT27.StrType)le.company_name_type_derived),TRIM((SALT27.StrType)le.cnp_hasnumber),TRIM((SALT27.StrType)le.cnp_lowv),TRIM((SALT27.StrType)le.cnp_translated),TRIM((SALT27.StrType)le.cnp_classid),TRIM((SALT27.StrType)le.company_foreign_domestic),TRIM((SALT27.StrType)le.company_bdid),TRIM((SALT27.StrType)le.dt_first_seen),TRIM((SALT27.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,32,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'cnp_number'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'st'}
      ,{5,'active_enterprise_number'}
      ,{6,'hist_enterprise_number'}
      ,{7,'hist_domestic_corp_key'}
      ,{8,'unk_corp_key'}
      ,{9,'ebr_file_number'}
      ,{10,'active_duns_number'}
      ,{11,'active_domestic_corp_key'}
      ,{12,'hist_duns_number'}
      ,{13,'foreign_corp_key'}
      ,{14,'company_fein'}
      ,{15,'company_phone'}
      ,{16,'cnp_name'}
      ,{17,'zip'}
      ,{19,'sec_range'}
      ,{20,'v_city_name'}
      ,{21,'cnp_btype'}
      ,{22,'iscorp'}
      ,{23,'company_name'}
      ,{24,'company_name_type_raw'}
      ,{25,'company_name_type_derived'}
      ,{26,'cnp_hasnumber'}
      ,{27,'cnp_lowv'}
      ,{28,'cnp_translated'}
      ,{29,'cnp_classid'}
      ,{30,'company_foreign_domestic'}
      ,{31,'company_bdid'}
      ,{34,'dt_first_seen'}
      ,{35,'dt_last_seen'}],SALT27.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT27.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT27.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_cnp_number((SALT27.StrType)le.cnp_number),
    Fields.InValid_prim_range((SALT27.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT27.StrType)le.prim_name),
    Fields.InValid_st((SALT27.StrType)le.st),
    Fields.InValid_active_enterprise_number((SALT27.StrType)le.active_enterprise_number),
    Fields.InValid_hist_enterprise_number((SALT27.StrType)le.hist_enterprise_number),
    Fields.InValid_hist_domestic_corp_key((SALT27.StrType)le.hist_domestic_corp_key),
    Fields.InValid_unk_corp_key((SALT27.StrType)le.unk_corp_key),
    Fields.InValid_ebr_file_number((SALT27.StrType)le.ebr_file_number),
    Fields.InValid_active_duns_number((SALT27.StrType)le.active_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT27.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_duns_number((SALT27.StrType)le.hist_duns_number),
    Fields.InValid_foreign_corp_key((SALT27.StrType)le.foreign_corp_key),
    Fields.InValid_company_fein((SALT27.StrType)le.company_fein),
    Fields.InValid_company_phone((SALT27.StrType)le.company_phone),
    Fields.InValid_cnp_name((SALT27.StrType)le.cnp_name),
    Fields.InValid_zip((SALT27.StrType)le.zip),
    0, // Uncleanable field
    Fields.InValid_sec_range((SALT27.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT27.StrType)le.v_city_name),
    Fields.InValid_cnp_btype((SALT27.StrType)le.cnp_btype),
    Fields.InValid_iscorp((SALT27.StrType)le.iscorp),
    Fields.InValid_company_name((SALT27.StrType)le.company_name),
    Fields.InValid_company_name_type_raw((SALT27.StrType)le.company_name_type_raw),
    Fields.InValid_company_name_type_derived((SALT27.StrType)le.company_name_type_derived),
    Fields.InValid_cnp_hasnumber((SALT27.StrType)le.cnp_hasnumber),
    Fields.InValid_cnp_lowv((SALT27.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT27.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT27.StrType)le.cnp_classid),
    Fields.InValid_company_foreign_domestic((SALT27.StrType)le.company_foreign_domestic),
    Fields.InValid_company_bdid((SALT27.StrType)le.company_bdid),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_dt_first_seen((SALT27.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT27.StrType)le.dt_last_seen),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,35,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := record
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ebr_file_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),'',Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_iscorp(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_raw(TotalErrors.ErrorNum),Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasnumber(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_foreign_domestic(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),'','',Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT27.MOD_ClusterStats.Counts(h,Proxid);
end;

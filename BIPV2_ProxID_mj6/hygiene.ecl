import ut,SALT30;
export hygiene(dataset(layout_DOT_Base) h) := MODULE
 
//A simple summary record
export Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_derived_pcnt := AVE(GROUP,IF(h.prim_name_derived = (TYPEOF(h.prim_name_derived))'',0,100));
    maxlength_prim_name_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name_derived)));
    avelength_prim_name_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name_derived)),h.prim_name_derived<>(typeof(h.prim_name_derived))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_ebr_file_number_pcnt := AVE(GROUP,IF(h.ebr_file_number = (TYPEOF(h.ebr_file_number))'',0,100));
    maxlength_ebr_file_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ebr_file_number)));
    avelength_ebr_file_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ebr_file_number)),h.ebr_file_number<>(typeof(h.ebr_file_number))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_hist_enterprise_number_pcnt := AVE(GROUP,IF(h.hist_enterprise_number = (TYPEOF(h.hist_enterprise_number))'',0,100));
    maxlength_hist_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_enterprise_number)));
    avelength_hist_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hist_enterprise_number)),h.hist_enterprise_number<>(typeof(h.hist_enterprise_number))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
  RETURN table(h,SummaryLayout);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'cnp_name','cnp_number','prim_range','prim_name_derived','st','zip','hist_duns_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','ebr_file_number','active_duns_number','active_enterprise_number','active_domestic_corp_key','company_fein','company_phone','sec_range','v_city_name','hist_enterprise_number','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_cnp_name_pcnt,le.populated_cnp_number_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_derived_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_hist_duns_number_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_ebr_file_number_pcnt,le.populated_active_duns_number_pcnt,le.populated_active_enterprise_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_company_fein_pcnt,le.populated_company_phone_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_hist_enterprise_number_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_cnp_name,le.maxlength_cnp_number,le.maxlength_prim_range,le.maxlength_prim_name_derived,le.maxlength_st,le.maxlength_zip,le.maxlength_hist_duns_number,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_ebr_file_number,le.maxlength_active_duns_number,le.maxlength_active_enterprise_number,le.maxlength_active_domestic_corp_key,le.maxlength_company_fein,le.maxlength_company_phone,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_hist_enterprise_number,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_cnp_name,le.avelength_cnp_number,le.avelength_prim_range,le.avelength_prim_name_derived,le.avelength_st,le.avelength_zip,le.avelength_hist_duns_number,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_ebr_file_number,le.avelength_active_duns_number,le.avelength_active_enterprise_number,le.avelength_active_domestic_corp_key,le.avelength_company_fein,le.avelength_company_phone,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_hist_enterprise_number,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 21, invert(LEFT,COUNTER));
 
SrcCntRec := record
  h.source;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,source,few);
 
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name_derived),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.ebr_file_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.active_enterprise_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.hist_enterprise_number),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 21);
  SELF.FldNo2 := 1 + (C % 21);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name_derived),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.ebr_file_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.active_enterprise_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.hist_enterprise_number),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.cnp_name),TRIM((SALT30.StrType)le.cnp_number),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.prim_name_derived),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.hist_duns_number),TRIM((SALT30.StrType)le.hist_domestic_corp_key),TRIM((SALT30.StrType)le.foreign_corp_key),TRIM((SALT30.StrType)le.unk_corp_key),TRIM((SALT30.StrType)le.ebr_file_number),TRIM((SALT30.StrType)le.active_duns_number),TRIM((SALT30.StrType)le.active_enterprise_number),TRIM((SALT30.StrType)le.active_domestic_corp_key),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.hist_enterprise_number),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),21*21,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'cnp_name'}
      ,{2,'cnp_number'}
      ,{3,'prim_range'}
      ,{4,'prim_name_derived'}
      ,{5,'st'}
      ,{6,'zip'}
      ,{7,'hist_duns_number'}
      ,{8,'hist_domestic_corp_key'}
      ,{9,'foreign_corp_key'}
      ,{10,'unk_corp_key'}
      ,{11,'ebr_file_number'}
      ,{12,'active_duns_number'}
      ,{13,'active_enterprise_number'}
      ,{14,'active_domestic_corp_key'}
      ,{15,'company_fein'}
      ,{16,'company_phone'}
      ,{17,'sec_range'}
      ,{18,'v_city_name'}
      ,{19,'hist_enterprise_number'}
      ,{20,'dt_first_seen'}
      ,{21,'dt_last_seen'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_cnp_name((SALT30.StrType)le.cnp_name),
    Fields.InValid_cnp_number((SALT30.StrType)le.cnp_number),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_prim_name_derived((SALT30.StrType)le.prim_name_derived),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_hist_duns_number((SALT30.StrType)le.hist_duns_number),
    Fields.InValid_hist_domestic_corp_key((SALT30.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT30.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT30.StrType)le.unk_corp_key),
    Fields.InValid_ebr_file_number((SALT30.StrType)le.ebr_file_number),
    Fields.InValid_active_duns_number((SALT30.StrType)le.active_duns_number),
    Fields.InValid_active_enterprise_number((SALT30.StrType)le.active_enterprise_number),
    Fields.InValid_active_domestic_corp_key((SALT30.StrType)le.active_domestic_corp_key),
    Fields.InValid_company_fein((SALT30.StrType)le.company_fein),
    Fields.InValid_company_phone((SALT30.StrType)le.company_phone),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_hist_enterprise_number((SALT30.StrType)le.hist_enterprise_number),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,24,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','alpha','number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_derived(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ebr_file_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_hist_enterprise_number(TotalErrors.ErrorNum),'','','',Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,SourceCounts,LEFT.source=RIGHT.source,LOOKUP); // Add source group counts for STRATA compliance
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT30.MOD_ClusterStats.Counts(h,Proxid);
EXPORT ClusterSrc := SALT30.MOD_ClusterStats.Sources(h,Proxid,source);
END;

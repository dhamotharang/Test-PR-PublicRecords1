import ut,SALT24;
export hygiene(dataset(layout_Base) h) := MODULE
//A simple summary record
export Summary(SALT24.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_company_prim_range_pcnt := AVE(GROUP,IF(h.company_prim_range = (TYPEOF(h.company_prim_range))'',0,100));
    maxlength_company_prim_range := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_prim_range)));
    avelength_company_prim_range := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_prim_range)),h.company_prim_range<>(typeof(h.company_prim_range))'');
    populated_company_predir_pcnt := AVE(GROUP,IF(h.company_predir = (TYPEOF(h.company_predir))'',0,100));
    maxlength_company_predir := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_predir)));
    avelength_company_predir := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_predir)),h.company_predir<>(typeof(h.company_predir))'');
    populated_company_prim_name_pcnt := AVE(GROUP,IF(h.company_prim_name = (TYPEOF(h.company_prim_name))'',0,100));
    maxlength_company_prim_name := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_prim_name)));
    avelength_company_prim_name := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_prim_name)),h.company_prim_name<>(typeof(h.company_prim_name))'');
    populated_company_addr_suffix_pcnt := AVE(GROUP,IF(h.company_addr_suffix = (TYPEOF(h.company_addr_suffix))'',0,100));
    maxlength_company_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_addr_suffix)));
    avelength_company_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_addr_suffix)),h.company_addr_suffix<>(typeof(h.company_addr_suffix))'');
    populated_company_postdir_pcnt := AVE(GROUP,IF(h.company_postdir = (TYPEOF(h.company_postdir))'',0,100));
    maxlength_company_postdir := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_postdir)));
    avelength_company_postdir := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_postdir)),h.company_postdir<>(typeof(h.company_postdir))'');
    populated_company_unit_desig_pcnt := AVE(GROUP,IF(h.company_unit_desig = (TYPEOF(h.company_unit_desig))'',0,100));
    maxlength_company_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_unit_desig)));
    avelength_company_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_unit_desig)),h.company_unit_desig<>(typeof(h.company_unit_desig))'');
    populated_company_sec_range_pcnt := AVE(GROUP,IF(h.company_sec_range = (TYPEOF(h.company_sec_range))'',0,100));
    maxlength_company_sec_range := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_sec_range)));
    avelength_company_sec_range := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_sec_range)),h.company_sec_range<>(typeof(h.company_sec_range))'');
    populated_company_p_city_name_pcnt := AVE(GROUP,IF(h.company_p_city_name = (TYPEOF(h.company_p_city_name))'',0,100));
    maxlength_company_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_p_city_name)));
    avelength_company_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_p_city_name)),h.company_p_city_name<>(typeof(h.company_p_city_name))'');
    populated_company_v_city_name_pcnt := AVE(GROUP,IF(h.company_v_city_name = (TYPEOF(h.company_v_city_name))'',0,100));
    maxlength_company_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_v_city_name)));
    avelength_company_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_v_city_name)),h.company_v_city_name<>(typeof(h.company_v_city_name))'');
    populated_company_st_pcnt := AVE(GROUP,IF(h.company_st = (TYPEOF(h.company_st))'',0,100));
    maxlength_company_st := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_st)));
    avelength_company_st := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_st)),h.company_st<>(typeof(h.company_st))'');
    populated_company_zip5_pcnt := AVE(GROUP,IF(h.company_zip5 = (TYPEOF(h.company_zip5))'',0,100));
    maxlength_company_zip5 := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_zip5)));
    avelength_company_zip5 := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_zip5)),h.company_zip5<>(typeof(h.company_zip5))'');
    populated_company_zip4_pcnt := AVE(GROUP,IF(h.company_zip4 = (TYPEOF(h.company_zip4))'',0,100));
    maxlength_company_zip4 := MAX(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_zip4)));
    avelength_company_zip4 := AVE(GROUP,LENGTH(TRIM((SALT24.StrType)h.company_zip4)),h.company_zip4<>(typeof(h.company_zip4))'');
  END;
  RETURN table(h,SummaryLayout);
END;
SrcCntRec := record
  h.source;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,source,few);
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT24.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,trim((SALT24.StrType)le.dt_first_seen),trim((SALT24.StrType)le.dt_last_seen),trim((SALT24.StrType)le.source),trim((SALT24.StrType)le.company_name),trim((SALT24.StrType)le.company_fein),trim((SALT24.StrType)le.company_phone),trim((SALT24.StrType)le.company_url),trim((SALT24.StrType)le.company_prim_range),trim((SALT24.StrType)le.company_predir),trim((SALT24.StrType)le.company_prim_name),trim((SALT24.StrType)le.company_addr_suffix),trim((SALT24.StrType)le.company_postdir),trim((SALT24.StrType)le.company_unit_desig),trim((SALT24.StrType)le.company_sec_range),trim((SALT24.StrType)le.company_p_city_name),trim((SALT24.StrType)le.company_v_city_name),trim((SALT24.StrType)le.company_st),trim((SALT24.StrType)le.company_zip5),trim((SALT24.StrType)le.company_zip4),trim((SALT24.StrType)le.company_v_city_name)+' '+trim((SALT24.StrType)le.company_st)+' '+trim((SALT24.StrType)le.company_zip5)+' '+trim((SALT24.StrType)le.company_zip4),trim((SALT24.StrType)le.company_prim_range)+' '+trim((SALT24.StrType)le.company_predir)+' '+trim((SALT24.StrType)le.company_prim_name)+' '+trim((SALT24.StrType)le.company_addr_suffix)+' '+trim((SALT24.StrType)le.company_postdir)+' '+trim((SALT24.StrType)le.company_unit_desig)+' '+trim((SALT24.StrType)le.company_sec_range),trim((SALT24.StrType)le.company_prim_range)+' '+trim((SALT24.StrType)le.company_predir)+' '+trim((SALT24.StrType)le.company_prim_name)+' '+trim((SALT24.StrType)le.company_addr_suffix)+' '+trim((SALT24.StrType)le.company_postdir)+' '+trim((SALT24.StrType)le.company_unit_desig)+' '+trim((SALT24.StrType)le.company_sec_range)+' '+trim((SALT24.StrType)le.company_v_city_name)+' '+trim((SALT24.StrType)le.company_st)+' '+trim((SALT24.StrType)le.company_zip5)+' '+trim((SALT24.StrType)le.company_zip4)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'source'}
      ,{4,'company_name'}
      ,{5,'company_fein'}
      ,{6,'company_phone'}
      ,{7,'company_url'}
      ,{8,'company_prim_range'}
      ,{9,'company_predir'}
      ,{10,'company_prim_name'}
      ,{11,'company_addr_suffix'}
      ,{12,'company_postdir'}
      ,{13,'company_unit_desig'}
      ,{14,'company_sec_range'}
      ,{15,'company_p_city_name'}
      ,{16,'company_v_city_name'}
      ,{17,'company_st'}
      ,{18,'company_zip5'}
      ,{19,'company_zip4'}
      ,{20,'company_csz'}
      ,{21,'company_addr1'}
      ,{22,'company_address'}],SALT24.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT24.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT dt_first_seen_profile := AllProfiles(FldNo=1);
EXPORT dt_last_seen_profile := AllProfiles(FldNo=2);
EXPORT source_profile := AllProfiles(FldNo=3);
EXPORT company_name_profile := AllProfiles(FldNo=4);
EXPORT company_fein_profile := AllProfiles(FldNo=5);
EXPORT company_phone_profile := AllProfiles(FldNo=6);
EXPORT company_url_profile := AllProfiles(FldNo=7);
EXPORT company_prim_range_profile := AllProfiles(FldNo=8);
EXPORT company_predir_profile := AllProfiles(FldNo=9);
EXPORT company_prim_name_profile := AllProfiles(FldNo=10);
EXPORT company_addr_suffix_profile := AllProfiles(FldNo=11);
EXPORT company_postdir_profile := AllProfiles(FldNo=12);
EXPORT company_unit_desig_profile := AllProfiles(FldNo=13);
EXPORT company_sec_range_profile := AllProfiles(FldNo=14);
EXPORT company_p_city_name_profile := AllProfiles(FldNo=15);
EXPORT company_v_city_name_profile := AllProfiles(FldNo=16);
EXPORT company_st_profile := AllProfiles(FldNo=17);
EXPORT company_zip5_profile := AllProfiles(FldNo=18);
EXPORT company_zip4_profile := AllProfiles(FldNo=19);
EXPORT company_csz_profile := AllProfiles(FldNo=20);
EXPORT company_addr1_profile := AllProfiles(FldNo=21);
EXPORT company_address_profile := AllProfiles(FldNo=22);
EXPORT SrcProfiles := SALT24.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.source) source; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT24.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT24.StrType)le.dt_last_seen),
    Fields.InValid_source((SALT24.StrType)le.source),
    Fields.InValid_company_name((SALT24.StrType)le.company_name),
    Fields.InValid_company_fein((SALT24.StrType)le.company_fein),
    Fields.InValid_company_phone((SALT24.StrType)le.company_phone),
    Fields.InValid_company_url((SALT24.StrType)le.company_url),
    Fields.InValid_company_prim_range((SALT24.StrType)le.company_prim_range),
    Fields.InValid_company_predir((SALT24.StrType)le.company_predir),
    Fields.InValid_company_prim_name((SALT24.StrType)le.company_prim_name),
    Fields.InValid_company_addr_suffix((SALT24.StrType)le.company_addr_suffix),
    Fields.InValid_company_postdir((SALT24.StrType)le.company_postdir),
    Fields.InValid_company_unit_desig((SALT24.StrType)le.company_unit_desig),
    Fields.InValid_company_sec_range((SALT24.StrType)le.company_sec_range),
    Fields.InValid_company_p_city_name((SALT24.StrType)le.company_p_city_name),
    Fields.InValid_company_v_city_name((SALT24.StrType)le.company_v_city_name),
    Fields.InValid_company_st((SALT24.StrType)le.company_st),
    Fields.InValid_company_zip5((SALT24.StrType)le.company_zip5),
    Fields.InValid_company_zip4((SALT24.StrType)le.company_zip4),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.source := le.source;
end;
Errors := normalize(h,22,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.source;
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := record
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_company_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_company_predir(TotalErrors.ErrorNum),Fields.InValidMessage_company_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_company_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_company_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_company_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_company_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_st(TotalErrors.ErrorNum),Fields.InValidMessage_company_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_company_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_company_csz(TotalErrors.ErrorNum),Fields.InValidMessage_company_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_company_address(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.source=right.source,lookup); // Add source group counts for STRATA compliance
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT24.MOD_ClusterStats.Counts(h,Proxid);
EXPORT ClusterSrc := SALT24.MOD_ClusterStats.Sources(h,Proxid,source);
end;

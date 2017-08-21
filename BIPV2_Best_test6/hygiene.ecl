import ut,SALT27;
export hygiene(dataset(layout_Base) h) := MODULE
//A simple summary record
export Summary(SALT27.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_source_for_votes_pcnt := AVE(GROUP,IF(h.source_for_votes = (TYPEOF(h.source_for_votes))'',0,100));
    maxlength_source_for_votes := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.source_for_votes)));
    avelength_source_for_votes := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.source_for_votes)),h.source_for_votes<>(typeof(h.source_for_votes))'');
  END;
  RETURN table(h,SummaryLayout);
END;
SrcCntRec := record
  h.source_for_votes;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,source_for_votes,few);
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT27.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Src := le.source_for_votes;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT27.StrType)le.company_url),TRIM((SALT27.StrType)le.company_name),TRIM((SALT27.StrType)le.company_fein),TRIM((SALT27.StrType)le.company_phone),TRIM((SALT27.StrType)le.prim_name),TRIM((SALT27.StrType)le.zip),TRIM((SALT27.StrType)le.prim_range),TRIM((SALT27.StrType)le.zip4),TRIM((SALT27.StrType)le.sec_range),TRIM((SALT27.StrType)le.p_city_name),TRIM((SALT27.StrType)le.v_city_name),TRIM((SALT27.StrType)le.postdir),TRIM((SALT27.StrType)le.fips_county),TRIM((SALT27.StrType)le.predir),TRIM((SALT27.StrType)le.unit_desig),TRIM((SALT27.StrType)le.st),TRIM((SALT27.StrType)le.fips_state),TRIM((SALT27.StrType)le.addr_suffix),TRIM((SALT27.StrType)le.dt_first_seen),TRIM((SALT27.StrType)le.dt_last_seen),TRIM((SALT27.StrType)le.source_for_votes)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'company_url'}
      ,{2,'company_name'}
      ,{3,'company_fein'}
      ,{4,'company_phone'}
      ,{6,'prim_name'}
      ,{7,'zip'}
      ,{8,'prim_range'}
      ,{9,'zip4'}
      ,{10,'sec_range'}
      ,{11,'p_city_name'}
      ,{12,'v_city_name'}
      ,{13,'postdir'}
      ,{14,'fips_county'}
      ,{15,'predir'}
      ,{16,'unit_desig'}
      ,{17,'st'}
      ,{18,'fips_state'}
      ,{19,'addr_suffix'}
      ,{20,'dt_first_seen'}
      ,{21,'dt_last_seen'}
      ,{22,'source_for_votes'}],SALT27.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT27.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT27.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.source_for_votes) source_for_votes; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_company_url((SALT27.StrType)le.company_url),
    Fields.InValid_company_name((SALT27.StrType)le.company_name),
    Fields.InValid_company_fein((SALT27.StrType)le.company_fein),
    Fields.InValid_company_phone((SALT27.StrType)le.company_phone),
    0, // Uncleanable field
    Fields.InValid_prim_name((SALT27.StrType)le.prim_name),
    Fields.InValid_zip((SALT27.StrType)le.zip),
    Fields.InValid_prim_range((SALT27.StrType)le.prim_range),
    Fields.InValid_zip4((SALT27.StrType)le.zip4),
    Fields.InValid_sec_range((SALT27.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT27.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT27.StrType)le.v_city_name),
    Fields.InValid_postdir((SALT27.StrType)le.postdir),
    Fields.InValid_fips_county((SALT27.StrType)le.fips_county),
    Fields.InValid_predir((SALT27.StrType)le.predir),
    Fields.InValid_unit_desig((SALT27.StrType)le.unit_desig),
    Fields.InValid_st((SALT27.StrType)le.st),
    Fields.InValid_fips_state((SALT27.StrType)le.fips_state),
    Fields.InValid_addr_suffix((SALT27.StrType)le.addr_suffix),
    Fields.InValid_dt_first_seen((SALT27.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT27.StrType)le.dt_last_seen),
    Fields.InValid_source_for_votes((SALT27.StrType)le.source_for_votes),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.source_for_votes := le.source_for_votes;
end;
Errors := normalize(h,22,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
  Errors.source_for_votes;
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_for_votes,FEW);
PrettyErrorTotals := record
  TotalErrors.source_for_votes;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),'',Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_source_for_votes(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.source_for_votes=right.source_for_votes,lookup); // Add source group counts for STRATA compliance
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT27.MOD_ClusterStats.Counts(h,Proxid);
EXPORT ClusterSrc := SALT27.MOD_ClusterStats.Sources(h,Proxid,source_for_votes);
end;

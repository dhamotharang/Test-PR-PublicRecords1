import ut,SALT27;
export hygiene(dataset(layout_POWID_Down) h) := MODULE
 
//A simple summary record
export Summary(SALT27.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT27.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
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
SALT27.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.POWID;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT27.StrType)le.orgid),TRIM((SALT27.StrType)le.prim_range),TRIM((SALT27.StrType)le.prim_name),TRIM((SALT27.StrType)le.st),TRIM((SALT27.StrType)le.zip),TRIM((SALT27.StrType)le.v_city_name),TRIM((SALT27.StrType)le.company_name),TRIM((SALT27.StrType)le.dt_first_seen),TRIM((SALT27.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'orgid'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'st'}
      ,{5,'zip'}
      ,{7,'v_city_name'}
      ,{8,'company_name'}
      ,{11,'dt_first_seen'}
      ,{12,'dt_last_seen'}],SALT27.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT27.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT27.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
  typeof(h.source) source; // Track errors by source
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_orgid((SALT27.StrType)le.orgid),
    Fields.InValid_prim_range((SALT27.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT27.StrType)le.prim_name),
    Fields.InValid_st((SALT27.StrType)le.st),
    Fields.InValid_zip((SALT27.StrType)le.zip),
    0, // Uncleanable field
    Fields.InValid_v_city_name((SALT27.StrType)le.v_city_name),
    Fields.InValid_company_name((SALT27.StrType)le.company_name),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_dt_first_seen((SALT27.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT27.StrType)le.dt_last_seen),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  self.source := le.source;
end;
Errors := normalize(h,12,NoteErrors(left,counter));
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
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),'',Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),'','',Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := join(ValErr,SourceCounts,left.source=right.source,lookup); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT27.mac_srcfrequency_outliers(h,prim_range,source,prim_range_outliers)
  SALT27.mac_srcfrequency_outliers(h,prim_name,source,prim_name_outliers)
  SALT27.mac_srcfrequency_outliers(h,st,source,st_outliers)
  SALT27.mac_srcfrequency_outliers(h,v_city_name,source,v_city_name_outliers)
  SALT27.mac_srcfrequency_outliers(h,zip,source,zip_outliers)
EXPORT AllOutliers := prim_range_outliers + prim_name_outliers + st_outliers + v_city_name_outliers + zip_outliers;
//We have POWID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT27.MOD_ClusterStats.Counts(h,POWID);
EXPORT ClusterSrc := SALT27.MOD_ClusterStats.Sources(h,POWID,source);
end;

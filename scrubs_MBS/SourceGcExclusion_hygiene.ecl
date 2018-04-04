IMPORT SALT39,STD;
EXPORT SourceGcExclusion_hygiene(dataset(SourceGcExclusion_layout_SourceGcExclusion) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_gc_id_cnt := COUNT(GROUP,h.gc_id <> (TYPEOF(h.gc_id))'');
    populated_gc_id_pcnt := AVE(GROUP,IF(h.gc_id = (TYPEOF(h.gc_id))'',0,100));
    maxlength_gc_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)));
    avelength_gc_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)),h.gc_id<>(typeof(h.gc_id))'');
    populated_product_id_cnt := COUNT(GROUP,h.product_id <> (TYPEOF(h.product_id))'');
    populated_product_id_pcnt := AVE(GROUP,IF(h.product_id = (TYPEOF(h.product_id))'',0,100));
    maxlength_product_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.product_id)));
    avelength_product_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.product_id)),h.product_id<>(typeof(h.product_id))'');
    populated_company_id_cnt := COUNT(GROUP,h.company_id <> (TYPEOF(h.company_id))'');
    populated_company_id_pcnt := AVE(GROUP,IF(h.company_id = (TYPEOF(h.company_id))'',0,100));
    maxlength_company_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_id)));
    avelength_company_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.company_id)),h.company_id<>(typeof(h.company_id))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_user_added_cnt := COUNT(GROUP,h.user_added <> (TYPEOF(h.user_added))'');
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
    populated_date_changed_cnt := COUNT(GROUP,h.date_changed <> (TYPEOF(h.date_changed))'');
    populated_date_changed_pcnt := AVE(GROUP,IF(h.date_changed = (TYPEOF(h.date_changed))'',0,100));
    maxlength_date_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)));
    avelength_date_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)),h.date_changed<>(typeof(h.date_changed))'');
    populated_user_changed_cnt := COUNT(GROUP,h.user_changed <> (TYPEOF(h.user_changed))'');
    populated_user_changed_pcnt := AVE(GROUP,IF(h.user_changed = (TYPEOF(h.user_changed))'',0,100));
    maxlength_user_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)));
    avelength_user_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)),h.user_changed<>(typeof(h.user_changed))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_gc_id_pcnt *   0.00 / 100 + T.Populated_product_id_pcnt *   0.00 / 100 + T.Populated_company_id_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100 + T.Populated_date_changed_pcnt *   0.00 / 100 + T.Populated_user_changed_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'gc_id','product_id','company_id','status','date_added','user_added','date_changed','user_changed');
  SELF.populated_pcnt := CHOOSE(C,le.populated_gc_id_pcnt,le.populated_product_id_pcnt,le.populated_company_id_pcnt,le.populated_status_pcnt,le.populated_date_added_pcnt,le.populated_user_added_pcnt,le.populated_date_changed_pcnt,le.populated_user_changed_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_gc_id,le.maxlength_product_id,le.maxlength_company_id,le.maxlength_status,le.maxlength_date_added,le.maxlength_user_added,le.maxlength_date_changed,le.maxlength_user_changed);
  SELF.avelength := CHOOSE(C,le.avelength_gc_id,le.avelength_product_id,le.avelength_company_id,le.avelength_status,le.avelength_date_added,le.avelength_user_added,le.avelength_date_changed,le.avelength_user_changed);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.product_id <> 0,TRIM((SALT39.StrType)le.product_id), ''),IF (le.company_id <> 0,TRIM((SALT39.StrType)le.company_id), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.product_id <> 0,TRIM((SALT39.StrType)le.product_id), ''),IF (le.company_id <> 0,TRIM((SALT39.StrType)le.company_id), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),IF (le.product_id <> 0,TRIM((SALT39.StrType)le.product_id), ''),IF (le.company_id <> 0,TRIM((SALT39.StrType)le.company_id), ''),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'gc_id'}
      ,{2,'product_id'}
      ,{3,'company_id'}
      ,{4,'status'}
      ,{5,'date_added'}
      ,{6,'user_added'}
      ,{7,'date_changed'}
      ,{8,'user_changed'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    SourceGcExclusion_Fields.InValid_gc_id((SALT39.StrType)le.gc_id),
    SourceGcExclusion_Fields.InValid_product_id((SALT39.StrType)le.product_id),
    SourceGcExclusion_Fields.InValid_company_id((SALT39.StrType)le.company_id),
    SourceGcExclusion_Fields.InValid_status((SALT39.StrType)le.status),
    SourceGcExclusion_Fields.InValid_date_added((SALT39.StrType)le.date_added),
    SourceGcExclusion_Fields.InValid_user_added((SALT39.StrType)le.user_added),
    SourceGcExclusion_Fields.InValid_date_changed((SALT39.StrType)le.date_changed),
    SourceGcExclusion_Fields.InValid_user_changed((SALT39.StrType)le.user_changed),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := SourceGcExclusion_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,SourceGcExclusion_Fields.InValidMessage_gc_id(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_product_id(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_company_id(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_status(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_user_added(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_date_changed(TotalErrors.ErrorNum),SourceGcExclusion_Fields.InValidMessage_user_changed(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, SourceGcExclusion_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

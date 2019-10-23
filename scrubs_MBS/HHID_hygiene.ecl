IMPORT SALT39,STD;
EXPORT HHID_hygiene(dataset(HHID_layout_HHID) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_gc_id_cnt := COUNT(GROUP,h.gc_id <> (TYPEOF(h.gc_id))'');
    populated_gc_id_pcnt := AVE(GROUP,IF(h.gc_id = (TYPEOF(h.gc_id))'',0,100));
    maxlength_gc_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)));
    avelength_gc_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.gc_id)),h.gc_id<>(typeof(h.gc_id))'');
    populated_sub_account_id_cnt := COUNT(GROUP,h.sub_account_id <> (TYPEOF(h.sub_account_id))'');
    populated_sub_account_id_pcnt := AVE(GROUP,IF(h.sub_account_id = (TYPEOF(h.sub_account_id))'',0,100));
    maxlength_sub_account_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sub_account_id)));
    avelength_sub_account_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sub_account_id)),h.sub_account_id<>(typeof(h.sub_account_id))'');
    populated_hh_id_cnt := COUNT(GROUP,h.hh_id <> (TYPEOF(h.hh_id))'');
    populated_hh_id_pcnt := AVE(GROUP,IF(h.hh_id = (TYPEOF(h.hh_id))'',0,100));
    maxlength_hh_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.hh_id)));
    avelength_hh_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.hh_id)),h.hh_id<>(typeof(h.hh_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_gc_id_pcnt *   0.00 / 100 + T.Populated_sub_account_id_pcnt *   0.00 / 100 + T.Populated_hh_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'gc_id','sub_account_id','hh_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_gc_id_pcnt,le.populated_sub_account_id_pcnt,le.populated_hh_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_gc_id,le.maxlength_sub_account_id,le.maxlength_hh_id);
  SELF.avelength := CHOOSE(C,le.avelength_gc_id,le.avelength_sub_account_id,le.avelength_hh_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 3, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),TRIM((SALT39.StrType)le.sub_account_id),IF (le.hh_id <> 0,TRIM((SALT39.StrType)le.hh_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,3,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 3);
  SELF.FldNo2 := 1 + (C % 3);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),TRIM((SALT39.StrType)le.sub_account_id),IF (le.hh_id <> 0,TRIM((SALT39.StrType)le.hh_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.gc_id <> 0,TRIM((SALT39.StrType)le.gc_id), ''),TRIM((SALT39.StrType)le.sub_account_id),IF (le.hh_id <> 0,TRIM((SALT39.StrType)le.hh_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),3*3,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'gc_id'}
      ,{2,'sub_account_id'}
      ,{3,'hh_id'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    HHID_Fields.InValid_gc_id((SALT39.StrType)le.gc_id),
    HHID_Fields.InValid_sub_account_id((SALT39.StrType)le.sub_account_id),
    HHID_Fields.InValid_hh_id((SALT39.StrType)le.hh_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,3,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := HHID_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alphanumeric','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,HHID_Fields.InValidMessage_gc_id(TotalErrors.ErrorNum),HHID_Fields.InValidMessage_sub_account_id(TotalErrors.ErrorNum),HHID_Fields.InValidMessage_hh_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, HHID_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

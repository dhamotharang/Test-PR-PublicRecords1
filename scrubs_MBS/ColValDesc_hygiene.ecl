IMPORT SALT39,STD;
EXPORT ColValDesc_hygiene(dataset(ColValDesc_layout_ColValDesc) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_column_value_desc_id_cnt := COUNT(GROUP,h.column_value_desc_id <> (TYPEOF(h.column_value_desc_id))'');
    populated_column_value_desc_id_pcnt := AVE(GROUP,IF(h.column_value_desc_id = (TYPEOF(h.column_value_desc_id))'',0,100));
    maxlength_column_value_desc_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.column_value_desc_id)));
    avelength_column_value_desc_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.column_value_desc_id)),h.column_value_desc_id<>(typeof(h.column_value_desc_id))'');
    populated_table_column_id_cnt := COUNT(GROUP,h.table_column_id <> (TYPEOF(h.table_column_id))'');
    populated_table_column_id_pcnt := AVE(GROUP,IF(h.table_column_id = (TYPEOF(h.table_column_id))'',0,100));
    maxlength_table_column_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_column_id)));
    avelength_table_column_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_column_id)),h.table_column_id<>(typeof(h.table_column_id))'');
    populated_desc_value_cnt := COUNT(GROUP,h.desc_value <> (TYPEOF(h.desc_value))'');
    populated_desc_value_pcnt := AVE(GROUP,IF(h.desc_value = (TYPEOF(h.desc_value))'',0,100));
    maxlength_desc_value := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.desc_value)));
    avelength_desc_value := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.desc_value)),h.desc_value<>(typeof(h.desc_value))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_description_cnt := COUNT(GROUP,h.description <> (TYPEOF(h.description))'');
    populated_description_pcnt := AVE(GROUP,IF(h.description = (TYPEOF(h.description))'',0,100));
    maxlength_description := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.description)));
    avelength_description := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.description)),h.description<>(typeof(h.description))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_column_value_desc_id_pcnt *   0.00 / 100 + T.Populated_table_column_id_pcnt *   0.00 / 100 + T.Populated_desc_value_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'column_value_desc_id','table_column_id','desc_value','status','description');
  SELF.populated_pcnt := CHOOSE(C,le.populated_column_value_desc_id_pcnt,le.populated_table_column_id_pcnt,le.populated_desc_value_pcnt,le.populated_status_pcnt,le.populated_description_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_column_value_desc_id,le.maxlength_table_column_id,le.maxlength_desc_value,le.maxlength_status,le.maxlength_description);
  SELF.avelength := CHOOSE(C,le.avelength_column_value_desc_id,le.avelength_table_column_id,le.avelength_desc_value,le.avelength_status,le.avelength_description);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.column_value_desc_id <> 0,TRIM((SALT39.StrType)le.column_value_desc_id), ''),IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.desc_value),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.description)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.column_value_desc_id <> 0,TRIM((SALT39.StrType)le.column_value_desc_id), ''),IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.desc_value),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.description)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.column_value_desc_id <> 0,TRIM((SALT39.StrType)le.column_value_desc_id), ''),IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.desc_value),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.description)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'column_value_desc_id'}
      ,{2,'table_column_id'}
      ,{3,'desc_value'}
      ,{4,'status'}
      ,{5,'description'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    ColValDesc_Fields.InValid_column_value_desc_id((SALT39.StrType)le.column_value_desc_id),
    ColValDesc_Fields.InValid_table_column_id((SALT39.StrType)le.table_column_id),
    ColValDesc_Fields.InValid_desc_value((SALT39.StrType)le.desc_value),
    ColValDesc_Fields.InValid_status((SALT39.StrType)le.status),
    ColValDesc_Fields.InValid_description((SALT39.StrType)le.description),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,5,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := ColValDesc_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,ColValDesc_Fields.InValidMessage_column_value_desc_id(TotalErrors.ErrorNum),ColValDesc_Fields.InValidMessage_table_column_id(TotalErrors.ErrorNum),ColValDesc_Fields.InValidMessage_desc_value(TotalErrors.ErrorNum),ColValDesc_Fields.InValidMessage_status(TotalErrors.ErrorNum),ColValDesc_Fields.InValidMessage_description(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, ColValDesc_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

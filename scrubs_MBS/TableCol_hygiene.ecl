IMPORT SALT39,STD;
EXPORT TableCol_hygiene(dataset(TableCol_layout_TableCol) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_table_column_id_cnt := COUNT(GROUP,h.table_column_id <> (TYPEOF(h.table_column_id))'');
    populated_table_column_id_pcnt := AVE(GROUP,IF(h.table_column_id = (TYPEOF(h.table_column_id))'',0,100));
    maxlength_table_column_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_column_id)));
    avelength_table_column_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_column_id)),h.table_column_id<>(typeof(h.table_column_id))'');
    populated_table_name_cnt := COUNT(GROUP,h.table_name <> (TYPEOF(h.table_name))'');
    populated_table_name_pcnt := AVE(GROUP,IF(h.table_name = (TYPEOF(h.table_name))'',0,100));
    maxlength_table_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_name)));
    avelength_table_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.table_name)),h.table_name<>(typeof(h.table_name))'');
    populated_column_name_cnt := COUNT(GROUP,h.column_name <> (TYPEOF(h.column_name))'');
    populated_column_name_pcnt := AVE(GROUP,IF(h.column_name = (TYPEOF(h.column_name))'',0,100));
    maxlength_column_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.column_name)));
    avelength_column_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.column_name)),h.column_name<>(typeof(h.column_name))'');
    populated_is_column_value_cnt := COUNT(GROUP,h.is_column_value <> (TYPEOF(h.is_column_value))'');
    populated_is_column_value_pcnt := AVE(GROUP,IF(h.is_column_value = (TYPEOF(h.is_column_value))'',0,100));
    maxlength_is_column_value := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.is_column_value)));
    avelength_is_column_value := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.is_column_value)),h.is_column_value<>(typeof(h.is_column_value))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_table_column_id_pcnt *   0.00 / 100 + T.Populated_table_name_pcnt *   0.00 / 100 + T.Populated_column_name_pcnt *   0.00 / 100 + T.Populated_is_column_value_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'table_column_id','table_name','column_name','is_column_value');
  SELF.populated_pcnt := CHOOSE(C,le.populated_table_column_id_pcnt,le.populated_table_name_pcnt,le.populated_column_name_pcnt,le.populated_is_column_value_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_table_column_id,le.maxlength_table_name,le.maxlength_column_name,le.maxlength_is_column_value);
  SELF.avelength := CHOOSE(C,le.avelength_table_column_id,le.avelength_table_name,le.avelength_column_name,le.avelength_is_column_value);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.table_name),TRIM((SALT39.StrType)le.column_name),IF (le.is_column_value <> 0,TRIM((SALT39.StrType)le.is_column_value), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.table_name),TRIM((SALT39.StrType)le.column_name),IF (le.is_column_value <> 0,TRIM((SALT39.StrType)le.is_column_value), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.table_column_id <> 0,TRIM((SALT39.StrType)le.table_column_id), ''),TRIM((SALT39.StrType)le.table_name),TRIM((SALT39.StrType)le.column_name),IF (le.is_column_value <> 0,TRIM((SALT39.StrType)le.is_column_value), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'table_column_id'}
      ,{2,'table_name'}
      ,{3,'column_name'}
      ,{4,'is_column_value'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    TableCol_Fields.InValid_table_column_id((SALT39.StrType)le.table_column_id),
    TableCol_Fields.InValid_table_name((SALT39.StrType)le.table_name),
    TableCol_Fields.InValid_column_name((SALT39.StrType)le.column_name),
    TableCol_Fields.InValid_is_column_value((SALT39.StrType)le.is_column_value),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,4,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := TableCol_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,TableCol_Fields.InValidMessage_table_column_id(TotalErrors.ErrorNum),TableCol_Fields.InValidMessage_table_name(TotalErrors.ErrorNum),TableCol_Fields.InValidMessage_column_name(TotalErrors.ErrorNum),TableCol_Fields.InValidMessage_is_column_value(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, TableCol_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

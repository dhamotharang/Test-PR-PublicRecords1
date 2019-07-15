IMPORT SALT38,STD;
EXPORT CodesV3_hygiene(dataset(CodesV3_layout_Codes) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_file_name_cnt := COUNT(GROUP,h.file_name <> (TYPEOF(h.file_name))'');
    populated_file_name_pcnt := AVE(GROUP,IF(h.file_name = (TYPEOF(h.file_name))'',0,100));
    maxlength_file_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_name)));
    avelength_file_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_name)),h.file_name<>(typeof(h.file_name))'');
    populated_field_name_cnt := COUNT(GROUP,h.field_name <> (TYPEOF(h.field_name))'');
    populated_field_name_pcnt := AVE(GROUP,IF(h.field_name = (TYPEOF(h.field_name))'',0,100));
    maxlength_field_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.field_name)));
    avelength_field_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.field_name)),h.field_name<>(typeof(h.field_name))'');
    populated_field_name2_cnt := COUNT(GROUP,h.field_name2 <> (TYPEOF(h.field_name2))'');
    populated_field_name2_pcnt := AVE(GROUP,IF(h.field_name2 = (TYPEOF(h.field_name2))'',0,100));
    maxlength_field_name2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.field_name2)));
    avelength_field_name2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.field_name2)),h.field_name2<>(typeof(h.field_name2))'');
    populated_code_cnt := COUNT(GROUP,h.code <> (TYPEOF(h.code))'');
    populated_code_pcnt := AVE(GROUP,IF(h.code = (TYPEOF(h.code))'',0,100));
    maxlength_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.code)));
    avelength_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.code)),h.code<>(typeof(h.code))'');
    populated_long_flag_cnt := COUNT(GROUP,h.long_flag <> (TYPEOF(h.long_flag))'');
    populated_long_flag_pcnt := AVE(GROUP,IF(h.long_flag = (TYPEOF(h.long_flag))'',0,100));
    maxlength_long_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.long_flag)));
    avelength_long_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.long_flag)),h.long_flag<>(typeof(h.long_flag))'');
    populated_long_desc_cnt := COUNT(GROUP,h.long_desc <> (TYPEOF(h.long_desc))'');
    populated_long_desc_pcnt := AVE(GROUP,IF(h.long_desc = (TYPEOF(h.long_desc))'',0,100));
    maxlength_long_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.long_desc)));
    avelength_long_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.long_desc)),h.long_desc<>(typeof(h.long_desc))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_file_name_pcnt *   0.00 / 100 + T.Populated_field_name_pcnt *   0.00 / 100 + T.Populated_field_name2_pcnt *   0.00 / 100 + T.Populated_code_pcnt *   0.00 / 100 + T.Populated_long_flag_pcnt *   0.00 / 100 + T.Populated_long_desc_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'file_name','field_name','field_name2','code','long_flag','long_desc');
  SELF.populated_pcnt := CHOOSE(C,le.populated_file_name_pcnt,le.populated_field_name_pcnt,le.populated_field_name2_pcnt,le.populated_code_pcnt,le.populated_long_flag_pcnt,le.populated_long_desc_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_file_name,le.maxlength_field_name,le.maxlength_field_name2,le.maxlength_code,le.maxlength_long_flag,le.maxlength_long_desc);
  SELF.avelength := CHOOSE(C,le.avelength_file_name,le.avelength_field_name,le.avelength_field_name2,le.avelength_code,le.avelength_long_flag,le.avelength_long_desc);
END;
EXPORT invSummary := NORMALIZE(summary0, 6, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.file_name),TRIM((SALT38.StrType)le.field_name),TRIM((SALT38.StrType)le.field_name2),TRIM((SALT38.StrType)le.code),TRIM((SALT38.StrType)le.long_flag),TRIM((SALT38.StrType)le.long_desc)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,6,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 6);
  SELF.FldNo2 := 1 + (C % 6);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.file_name),TRIM((SALT38.StrType)le.field_name),TRIM((SALT38.StrType)le.field_name2),TRIM((SALT38.StrType)le.code),TRIM((SALT38.StrType)le.long_flag),TRIM((SALT38.StrType)le.long_desc)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.file_name),TRIM((SALT38.StrType)le.field_name),TRIM((SALT38.StrType)le.field_name2),TRIM((SALT38.StrType)le.code),TRIM((SALT38.StrType)le.long_flag),TRIM((SALT38.StrType)le.long_desc)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),6*6,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'file_name'}
      ,{2,'field_name'}
      ,{3,'field_name2'}
      ,{4,'code'}
      ,{5,'long_flag'}
      ,{6,'long_desc'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CodesV3_Fields.InValid_file_name((SALT38.StrType)le.file_name),
    CodesV3_Fields.InValid_field_name((SALT38.StrType)le.field_name),
    CodesV3_Fields.InValid_field_name2((SALT38.StrType)le.field_name2),
    CodesV3_Fields.InValid_code((SALT38.StrType)le.code),
    CodesV3_Fields.InValid_long_flag((SALT38.StrType)le.long_flag),
    CodesV3_Fields.InValid_long_desc((SALT38.StrType)le.long_desc),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,6,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := CodesV3_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','InvalidCode','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CodesV3_Fields.InValidMessage_file_name(TotalErrors.ErrorNum),CodesV3_Fields.InValidMessage_field_name(TotalErrors.ErrorNum),CodesV3_Fields.InValidMessage_field_name2(TotalErrors.ErrorNum),CodesV3_Fields.InValidMessage_code(TotalErrors.ErrorNum),CodesV3_Fields.InValidMessage_long_flag(TotalErrors.ErrorNum),CodesV3_Fields.InValidMessage_long_desc(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Codes, CodesV3_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

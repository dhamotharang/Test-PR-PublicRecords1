IMPORT SALT311,STD;
EXPORT Wireless_to_Wireline2_hygiene(dataset(Wireless_to_Wireline2_layout_Phone_TCPA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_cellphone_cnt := COUNT(GROUP,h.cellphone <> (TYPEOF(h.cellphone))'');
    populated_cellphone_pcnt := AVE(GROUP,IF(h.cellphone = (TYPEOF(h.cellphone))'',0,100));
    maxlength_cellphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphone)));
    avelength_cellphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphone)),h.cellphone<>(typeof(h.cellphone))'');
    populated_end_range_cnt := COUNT(GROUP,h.end_range <> (TYPEOF(h.end_range))'');
    populated_end_range_pcnt := AVE(GROUP,IF(h.end_range = (TYPEOF(h.end_range))'',0,100));
    maxlength_end_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.end_range)));
    avelength_end_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.end_range)),h.end_range<>(typeof(h.end_range))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_cellphone_pcnt *   0.00 / 100 + T.Populated_end_range_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'cellphone','end_range','lf','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_cellphone_pcnt,le.populated_end_range_pcnt,le.populated_lf_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_cellphone,le.maxlength_end_range,le.maxlength_lf,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_cellphone,le.avelength_end_range,le.avelength_lf,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.lf),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'cellphone'}
      ,{2,'end_range'}
      ,{3,'lf'}
      ,{4,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Wireless_to_Wireline2_Fields.InValid_cellphone((SALT311.StrType)le.cellphone),
    Wireless_to_Wireline2_Fields.InValid_end_range((SALT311.StrType)le.end_range),
    Wireless_to_Wireline2_Fields.InValid_lf((SALT311.StrType)le.lf),
    Wireless_to_Wireline2_Fields.InValid_filename((SALT311.StrType)le.filename),
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
  FieldNme := Wireless_to_Wireline2_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num_Space','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Wireless_to_Wireline2_Fields.InValidMessage_cellphone(TotalErrors.ErrorNum),Wireless_to_Wireline2_Fields.InValidMessage_end_range(TotalErrors.ErrorNum),Wireless_to_Wireline2_Fields.InValidMessage_lf(TotalErrors.ErrorNum),Wireless_to_Wireline2_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phone_TCPA, Wireless_to_Wireline2_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

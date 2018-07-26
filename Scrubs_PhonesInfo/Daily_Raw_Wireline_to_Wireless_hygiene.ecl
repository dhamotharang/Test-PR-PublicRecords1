IMPORT SALT39,STD;
EXPORT Daily_Raw_Wireline_to_Wireless_hygiene(dataset(Daily_Raw_Wireline_to_Wireless_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'phone','lf','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_lf_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_lf,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_lf,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 3, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.lf),TRIM((SALT39.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,3,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 3);
  SELF.FldNo2 := 1 + (C % 3);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.lf),TRIM((SALT39.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.lf),TRIM((SALT39.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),3*3,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'phone'}
      ,{2,'lf'}
      ,{3,'filename'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Daily_Raw_Wireline_to_Wireless_Fields.InValid_phone((SALT39.StrType)le.phone),
    Daily_Raw_Wireline_to_Wireless_Fields.InValid_lf((SALT39.StrType)le.lf),
    Daily_Raw_Wireline_to_Wireless_Fields.InValid_filename((SALT39.StrType)le.filename),
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
  FieldNme := Daily_Raw_Wireline_to_Wireless_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Phone','Unknown','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Daily_Raw_Wireline_to_Wireless_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Daily_Raw_Wireline_to_Wireless_Fields.InValidMessage_lf(TotalErrors.ErrorNum),Daily_Raw_Wireline_to_Wireless_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, Daily_Raw_Wireline_to_Wireless_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

IMPORT SALT38,STD;
EXPORT DeactRaw_hygiene(dataset(DeactRaw_layout_PhonesInfo) h) := MODULE

//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_timestamp_cnt := COUNT(GROUP,h.timestamp <> (TYPEOF(h.timestamp))'');
    populated_timestamp_pcnt := AVE(GROUP,IF(h.timestamp = (TYPEOF(h.timestamp))'',0,100));
    maxlength_timestamp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.timestamp)));
    avelength_timestamp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.timestamp)),h.timestamp<>(typeof(h.timestamp))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_swap_cnt := COUNT(GROUP,h.phone_swap <> (TYPEOF(h.phone_swap))'');
    populated_phone_swap_pcnt := AVE(GROUP,IF(h.phone_swap = (TYPEOF(h.phone_swap))'',0,100));
    maxlength_phone_swap := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_swap)));
    avelength_phone_swap := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone_swap)),h.phone_swap<>(typeof(h.phone_swap))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_timestamp_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_swap_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'action_code','timestamp','phone','phone_swap','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_action_code_pcnt,le.populated_timestamp_pcnt,le.populated_phone_pcnt,le.populated_phone_swap_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_action_code,le.maxlength_timestamp,le.maxlength_phone,le.maxlength_phone_swap,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_action_code,le.avelength_timestamp,le.avelength_phone,le.avelength_phone_swap,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.timestamp),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_swap),TRIM((SALT38.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.timestamp),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_swap),TRIM((SALT38.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.timestamp),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.phone_swap),TRIM((SALT38.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'action_code'}
      ,{2,'timestamp'}
      ,{3,'phone'}
      ,{4,'phone_swap'}
      ,{5,'filename'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DeactRaw_Fields.InValid_action_code((SALT38.StrType)le.action_code),
    DeactRaw_Fields.InValid_timestamp((SALT38.StrType)le.timestamp),
    DeactRaw_Fields.InValid_phone((SALT38.StrType)le.phone),
    DeactRaw_Fields.InValid_phone_swap((SALT38.StrType)le.phone_swap),
    DeactRaw_Fields.InValid_filename((SALT38.StrType)le.filename),
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
  FieldNme := DeactRaw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_Num_Blank','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DeactRaw_Fields.InValidMessage_action_code(TotalErrors.ErrorNum),DeactRaw_Fields.InValidMessage_timestamp(TotalErrors.ErrorNum),DeactRaw_Fields.InValidMessage_phone(TotalErrors.ErrorNum),DeactRaw_Fields.InValidMessage_phone_swap(TotalErrors.ErrorNum),DeactRaw_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, DeactRaw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

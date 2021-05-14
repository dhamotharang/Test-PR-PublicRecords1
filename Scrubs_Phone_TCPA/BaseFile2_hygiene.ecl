IMPORT SALT311,STD;
EXPORT BaseFile2_hygiene(dataset(BaseFile2_layout_Phone_TCPA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_num_cnt := COUNT(GROUP,h.num <> (TYPEOF(h.num))'');
    populated_num_pcnt := AVE(GROUP,IF(h.num = (TYPEOF(h.num))'',0,100));
    maxlength_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num)));
    avelength_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num)),h.num<>(typeof(h.num))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_end_range_cnt := COUNT(GROUP,h.end_range <> (TYPEOF(h.end_range))'');
    populated_end_range_pcnt := AVE(GROUP,IF(h.end_range = (TYPEOF(h.end_range))'',0,100));
    maxlength_end_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.end_range)));
    avelength_end_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.end_range)),h.end_range<>(typeof(h.end_range))'');
    populated_expand_end_range_cnt := COUNT(GROUP,h.expand_end_range <> (TYPEOF(h.expand_end_range))'');
    populated_expand_end_range_pcnt := AVE(GROUP,IF(h.expand_end_range = (TYPEOF(h.expand_end_range))'',0,100));
    maxlength_expand_end_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_end_range)));
    avelength_expand_end_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_end_range)),h.expand_end_range<>(typeof(h.expand_end_range))'');
    populated_expand_range_max_count_cnt := COUNT(GROUP,h.expand_range_max_count <> (TYPEOF(h.expand_range_max_count))'');
    populated_expand_range_max_count_pcnt := AVE(GROUP,IF(h.expand_range_max_count = (TYPEOF(h.expand_range_max_count))'',0,100));
    maxlength_expand_range_max_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_range_max_count)));
    avelength_expand_range_max_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_range_max_count)),h.expand_range_max_count<>(typeof(h.expand_range_max_count))'');
    populated_expand_phone_cnt := COUNT(GROUP,h.expand_phone <> (TYPEOF(h.expand_phone))'');
    populated_expand_phone_pcnt := AVE(GROUP,IF(h.expand_phone = (TYPEOF(h.expand_phone))'',0,100));
    maxlength_expand_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_phone)));
    avelength_expand_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.expand_phone)),h.expand_phone<>(typeof(h.expand_phone))'');
    populated_is_current_cnt := COUNT(GROUP,h.is_current <> (TYPEOF(h.is_current))'');
    populated_is_current_pcnt := AVE(GROUP,IF(h.is_current = (TYPEOF(h.is_current))'',0,100));
    maxlength_is_current := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)));
    avelength_is_current := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)),h.is_current<>(typeof(h.is_current))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_phone_type_cnt := COUNT(GROUP,h.phone_type <> (TYPEOF(h.phone_type))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_num_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_end_range_pcnt *   0.00 / 100 + T.Populated_expand_end_range_pcnt *   0.00 / 100 + T.Populated_expand_range_max_count_pcnt *   0.00 / 100 + T.Populated_expand_phone_pcnt *   0.00 / 100 + T.Populated_is_current_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'num','phone','end_range','expand_end_range','expand_range_max_count','expand_phone','is_current','dt_first_seen','dt_last_seen','phone_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_num_pcnt,le.populated_phone_pcnt,le.populated_end_range_pcnt,le.populated_expand_end_range_pcnt,le.populated_expand_range_max_count_pcnt,le.populated_expand_phone_pcnt,le.populated_is_current_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_phone_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_num,le.maxlength_phone,le.maxlength_end_range,le.maxlength_expand_end_range,le.maxlength_expand_range_max_count,le.maxlength_expand_phone,le.maxlength_is_current,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_phone_type);
  SELF.avelength := CHOOSE(C,le.avelength_num,le.avelength_phone,le.avelength_end_range,le.avelength_expand_end_range,le.avelength_expand_range_max_count,le.avelength_expand_phone,le.avelength_is_current,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_phone_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.num <> 0,TRIM((SALT311.StrType)le.num), ''),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.expand_end_range),IF (le.expand_range_max_count <> 0,TRIM((SALT311.StrType)le.expand_range_max_count), ''),TRIM((SALT311.StrType)le.expand_phone),TRIM((SALT311.StrType)le.is_current),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),TRIM((SALT311.StrType)le.phone_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.num <> 0,TRIM((SALT311.StrType)le.num), ''),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.expand_end_range),IF (le.expand_range_max_count <> 0,TRIM((SALT311.StrType)le.expand_range_max_count), ''),TRIM((SALT311.StrType)le.expand_phone),TRIM((SALT311.StrType)le.is_current),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),TRIM((SALT311.StrType)le.phone_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.num <> 0,TRIM((SALT311.StrType)le.num), ''),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.end_range),TRIM((SALT311.StrType)le.expand_end_range),IF (le.expand_range_max_count <> 0,TRIM((SALT311.StrType)le.expand_range_max_count), ''),TRIM((SALT311.StrType)le.expand_phone),TRIM((SALT311.StrType)le.is_current),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),TRIM((SALT311.StrType)le.phone_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'num'}
      ,{2,'phone'}
      ,{3,'end_range'}
      ,{4,'expand_end_range'}
      ,{5,'expand_range_max_count'}
      ,{6,'expand_phone'}
      ,{7,'is_current'}
      ,{8,'dt_first_seen'}
      ,{9,'dt_last_seen'}
      ,{10,'phone_type'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BaseFile2_Fields.InValid_num((SALT311.StrType)le.num),
    BaseFile2_Fields.InValid_phone((SALT311.StrType)le.phone),
    BaseFile2_Fields.InValid_end_range((SALT311.StrType)le.end_range),
    BaseFile2_Fields.InValid_expand_end_range((SALT311.StrType)le.expand_end_range),
    BaseFile2_Fields.InValid_expand_range_max_count((SALT311.StrType)le.expand_range_max_count),
    BaseFile2_Fields.InValid_expand_phone((SALT311.StrType)le.expand_phone),
    BaseFile2_Fields.InValid_is_current((SALT311.StrType)le.is_current),
    BaseFile2_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    BaseFile2_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    BaseFile2_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BaseFile2_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_Num_Space','Invalid_Num_Space','Invalid_Num_Space','Invalid_Num','Unknown','Invalid_Date','Invalid_Date','Invalid_PType');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BaseFile2_Fields.InValidMessage_num(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_phone(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_end_range(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_expand_end_range(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_expand_range_max_count(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_expand_phone(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_is_current(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),BaseFile2_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phone_TCPA, BaseFile2_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

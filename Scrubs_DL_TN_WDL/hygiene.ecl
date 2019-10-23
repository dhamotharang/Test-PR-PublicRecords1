IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_In_TN_WDL) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dl_number_cnt := COUNT(GROUP,h.dl_number <> (TYPEOF(h.dl_number))'');
    populated_dl_number_pcnt := AVE(GROUP,IF(h.dl_number = (TYPEOF(h.dl_number))'',0,100));
    maxlength_dl_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_number)));
    avelength_dl_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dl_number)),h.dl_number<>(typeof(h.dl_number))'');
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_event_date_cnt := COUNT(GROUP,h.event_date <> (TYPEOF(h.event_date))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_birthdate_cnt := COUNT(GROUP,h.birthdate <> (TYPEOF(h.birthdate))'');
    populated_birthdate_pcnt := AVE(GROUP,IF(h.birthdate = (TYPEOF(h.birthdate))'',0,100));
    maxlength_birthdate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.birthdate)));
    avelength_birthdate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.birthdate)),h.birthdate<>(typeof(h.birthdate))'');
    populated_post_date_cnt := COUNT(GROUP,h.post_date <> (TYPEOF(h.post_date))'');
    populated_post_date_pcnt := AVE(GROUP,IF(h.post_date = (TYPEOF(h.post_date))'',0,100));
    maxlength_post_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.post_date)));
    avelength_post_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.post_date)),h.post_date<>(typeof(h.post_date))'');
    populated_county_code_cnt := COUNT(GROUP,h.county_code <> (TYPEOF(h.county_code))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_action_type_cnt := COUNT(GROUP,h.action_type <> (TYPEOF(h.action_type))'');
    populated_action_type_pcnt := AVE(GROUP,IF(h.action_type = (TYPEOF(h.action_type))'',0,100));
    maxlength_action_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_type)));
    avelength_action_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_type)),h.action_type<>(typeof(h.action_type))'');
    populated_filler_cnt := COUNT(GROUP,h.filler <> (TYPEOF(h.filler))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dl_number_pcnt *   0.00 / 100 + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_birthdate_pcnt *   0.00 / 100 + T.Populated_post_date_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_action_type_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','dl_number','action_code','event_date','last_name','birthdate','post_date','county_code','action_type','filler');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_dl_number_pcnt,le.populated_action_code_pcnt,le.populated_event_date_pcnt,le.populated_last_name_pcnt,le.populated_birthdate_pcnt,le.populated_post_date_pcnt,le.populated_county_code_pcnt,le.populated_action_type_pcnt,le.populated_filler_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_dl_number,le.maxlength_action_code,le.maxlength_event_date,le.maxlength_last_name,le.maxlength_birthdate,le.maxlength_post_date,le.maxlength_county_code,le.maxlength_action_type,le.maxlength_filler);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_dl_number,le.avelength_action_code,le.avelength_event_date,le.avelength_last_name,le.avelength_birthdate,le.avelength_post_date,le.avelength_county_code,le.avelength_action_type,le.avelength_filler);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.dl_number),TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.event_date),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.birthdate),TRIM((SALT38.StrType)le.post_date),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.action_type),TRIM((SALT38.StrType)le.filler)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.dl_number),TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.event_date),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.birthdate),TRIM((SALT38.StrType)le.post_date),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.action_type),TRIM((SALT38.StrType)le.filler)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.dl_number),TRIM((SALT38.StrType)le.action_code),TRIM((SALT38.StrType)le.event_date),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.birthdate),TRIM((SALT38.StrType)le.post_date),TRIM((SALT38.StrType)le.county_code),TRIM((SALT38.StrType)le.action_type),TRIM((SALT38.StrType)le.filler)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'dl_number'}
      ,{3,'action_code'}
      ,{4,'event_date'}
      ,{5,'last_name'}
      ,{6,'birthdate'}
      ,{7,'post_date'}
      ,{8,'county_code'}
      ,{9,'action_type'}
      ,{10,'filler'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT38.StrType)le.process_date),
    Fields.InValid_dl_number((SALT38.StrType)le.dl_number),
    Fields.InValid_action_code((SALT38.StrType)le.action_code),
    Fields.InValid_event_date((SALT38.StrType)le.event_date),
    Fields.InValid_last_name((SALT38.StrType)le.last_name),
    Fields.InValid_birthdate((SALT38.StrType)le.birthdate),
    Fields.InValid_post_date((SALT38.StrType)le.post_date),
    Fields.InValid_county_code((SALT38.StrType)le.county_code),
    Fields.InValid_action_type((SALT38.StrType)le.action_type),
    Fields.InValid_filler((SALT38.StrType)le.filler),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_past_date','invalid_dl_nbr','invalid_action_code','invalid_past_date','invalid_lname','invalid_past_date','invalid_past_date','invalid_county_code','invalid_action_type','invalid_filler_data');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_action_code(TotalErrors.ErrorNum),Fields.InValidMessage_event_date(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_birthdate(TotalErrors.ErrorNum),Fields.InValidMessage_post_date(TotalErrors.ErrorNum),Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Fields.InValidMessage_action_type(TotalErrors.ErrorNum),Fields.InValidMessage_filler(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_TN_WDL, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

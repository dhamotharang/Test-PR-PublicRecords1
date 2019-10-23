IMPORT SALT39,STD;
EXPORT Activity_hygiene(dataset(Activity_layout_Civil_Court) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_file_cnt := COUNT(GROUP,h.source_file <> (TYPEOF(h.source_file))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_case_key_cnt := COUNT(GROUP,h.case_key <> (TYPEOF(h.case_key))'');
    populated_case_key_pcnt := AVE(GROUP,IF(h.case_key = (TYPEOF(h.case_key))'',0,100));
    maxlength_case_key := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)));
    avelength_case_key := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_key)),h.case_key<>(typeof(h.case_key))'');
    populated_court_code_cnt := COUNT(GROUP,h.court_code <> (TYPEOF(h.court_code))'');
    populated_court_code_pcnt := AVE(GROUP,IF(h.court_code = (TYPEOF(h.court_code))'',0,100));
    maxlength_court_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)));
    avelength_court_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court_code)),h.court_code<>(typeof(h.court_code))'');
    populated_court_cnt := COUNT(GROUP,h.court <> (TYPEOF(h.court))'');
    populated_court_pcnt := AVE(GROUP,IF(h.court = (TYPEOF(h.court))'',0,100));
    maxlength_court := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)));
    avelength_court := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.court)),h.court<>(typeof(h.court))'');
    populated_case_number_cnt := COUNT(GROUP,h.case_number <> (TYPEOF(h.case_number))'');
    populated_case_number_pcnt := AVE(GROUP,IF(h.case_number = (TYPEOF(h.case_number))'',0,100));
    maxlength_case_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)));
    avelength_case_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.case_number)),h.case_number<>(typeof(h.case_number))'');
    populated_event_date_cnt := COUNT(GROUP,h.event_date <> (TYPEOF(h.event_date))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_type_code_cnt := COUNT(GROUP,h.event_type_code <> (TYPEOF(h.event_type_code))'');
    populated_event_type_code_pcnt := AVE(GROUP,IF(h.event_type_code = (TYPEOF(h.event_type_code))'',0,100));
    maxlength_event_type_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_code)));
    avelength_event_type_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_code)),h.event_type_code<>(typeof(h.event_type_code))'');
    populated_event_type_description_1_cnt := COUNT(GROUP,h.event_type_description_1 <> (TYPEOF(h.event_type_description_1))'');
    populated_event_type_description_1_pcnt := AVE(GROUP,IF(h.event_type_description_1 = (TYPEOF(h.event_type_description_1))'',0,100));
    maxlength_event_type_description_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_description_1)));
    avelength_event_type_description_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_description_1)),h.event_type_description_1<>(typeof(h.event_type_description_1))'');
    populated_event_type_description_2_cnt := COUNT(GROUP,h.event_type_description_2 <> (TYPEOF(h.event_type_description_2))'');
    populated_event_type_description_2_pcnt := AVE(GROUP,IF(h.event_type_description_2 = (TYPEOF(h.event_type_description_2))'',0,100));
    maxlength_event_type_description_2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_description_2)));
    avelength_event_type_description_2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.event_type_description_2)),h.event_type_description_2<>(typeof(h.event_type_description_2))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_case_key_pcnt *   0.00 / 100 + T.Populated_court_code_pcnt *   0.00 / 100 + T.Populated_court_pcnt *   0.00 / 100 + T.Populated_case_number_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_type_code_pcnt *   0.00 / 100 + T.Populated_event_type_description_1_pcnt *   0.00 / 100 + T.Populated_event_type_description_2_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','source_file','case_key','court_code','court','case_number','event_date','event_type_code','event_type_description_1','event_type_description_2');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_source_file_pcnt,le.populated_case_key_pcnt,le.populated_court_code_pcnt,le.populated_court_pcnt,le.populated_case_number_pcnt,le.populated_event_date_pcnt,le.populated_event_type_code_pcnt,le.populated_event_type_description_1_pcnt,le.populated_event_type_description_2_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_process_date,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_source_file,le.maxlength_case_key,le.maxlength_court_code,le.maxlength_court,le.maxlength_case_number,le.maxlength_event_date,le.maxlength_event_type_code,le.maxlength_event_type_description_1,le.maxlength_event_type_description_2);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_process_date,le.avelength_vendor,le.avelength_state_origin,le.avelength_source_file,le.avelength_case_key,le.avelength_court_code,le.avelength_court,le.avelength_case_number,le.avelength_event_date,le.avelength_event_type_code,le.avelength_event_type_description_1,le.avelength_event_type_description_2);
END;
EXPORT invSummary := NORMALIZE(summary0, 14, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.event_date),TRIM((SALT39.StrType)le.event_type_code),TRIM((SALT39.StrType)le.event_type_description_1),TRIM((SALT39.StrType)le.event_type_description_2)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,14,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 14);
  SELF.FldNo2 := 1 + (C % 14);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.event_date),TRIM((SALT39.StrType)le.event_type_code),TRIM((SALT39.StrType)le.event_type_description_1),TRIM((SALT39.StrType)le.event_type_description_2)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.dt_first_reported),TRIM((SALT39.StrType)le.dt_last_reported),TRIM((SALT39.StrType)le.process_date),TRIM((SALT39.StrType)le.vendor),TRIM((SALT39.StrType)le.state_origin),TRIM((SALT39.StrType)le.source_file),TRIM((SALT39.StrType)le.case_key),TRIM((SALT39.StrType)le.court_code),TRIM((SALT39.StrType)le.court),TRIM((SALT39.StrType)le.case_number),TRIM((SALT39.StrType)le.event_date),TRIM((SALT39.StrType)le.event_type_code),TRIM((SALT39.StrType)le.event_type_description_1),TRIM((SALT39.StrType)le.event_type_description_2)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),14*14,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_reported'}
      ,{2,'dt_last_reported'}
      ,{3,'process_date'}
      ,{4,'vendor'}
      ,{5,'state_origin'}
      ,{6,'source_file'}
      ,{7,'case_key'}
      ,{8,'court_code'}
      ,{9,'court'}
      ,{10,'case_number'}
      ,{11,'event_date'}
      ,{12,'event_type_code'}
      ,{13,'event_type_description_1'}
      ,{14,'event_type_description_2'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Activity_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported),
    Activity_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported),
    Activity_Fields.InValid_process_date((SALT39.StrType)le.process_date),
    Activity_Fields.InValid_vendor((SALT39.StrType)le.vendor),
    Activity_Fields.InValid_state_origin((SALT39.StrType)le.state_origin),
    Activity_Fields.InValid_source_file((SALT39.StrType)le.source_file),
    Activity_Fields.InValid_case_key((SALT39.StrType)le.case_key),
    Activity_Fields.InValid_court_code((SALT39.StrType)le.court_code),
    Activity_Fields.InValid_court((SALT39.StrType)le.court),
    Activity_Fields.InValid_case_number((SALT39.StrType)le.case_number),
    Activity_Fields.InValid_event_date((SALT39.StrType)le.event_date),
    Activity_Fields.InValid_event_type_code((SALT39.StrType)le.event_type_code),
    Activity_Fields.InValid_event_type_description_1((SALT39.StrType)le.event_type_description_1),
    Activity_Fields.InValid_event_type_description_2((SALT39.StrType)le.event_type_description_2),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,14,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Activity_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_CapLetter','Unknown','Invalid_Char','Invalid_Char','Unknown','Invalid_Char','Invalid_Future_Date','Invalid_Char','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Activity_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_case_key(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_court_code(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_court(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_case_number(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_event_date(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_event_type_code(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_event_type_description_1(TotalErrors.ErrorNum),Activity_Fields.InValidMessage_event_type_description_2(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Civil_Court, Activity_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

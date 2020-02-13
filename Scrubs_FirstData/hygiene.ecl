IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_FirstData) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_filedate_cnt := COUNT(GROUP,h.filedate <> (TYPEOF(h.filedate))'');
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_cons_id_cnt := COUNT(GROUP,h.cons_id <> (TYPEOF(h.cons_id))'');
    populated_cons_id_pcnt := AVE(GROUP,IF(h.cons_id = (TYPEOF(h.cons_id))'',0,100));
    maxlength_cons_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cons_id)));
    avelength_cons_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cons_id)),h.cons_id<>(typeof(h.cons_id))'');
    populated_dl_state_cnt := COUNT(GROUP,h.dl_state <> (TYPEOF(h.dl_state))'');
    populated_dl_state_pcnt := AVE(GROUP,IF(h.dl_state = (TYPEOF(h.dl_state))'',0,100));
    maxlength_dl_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_state)));
    avelength_dl_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_state)),h.dl_state<>(typeof(h.dl_state))'');
    populated_dl_id_cnt := COUNT(GROUP,h.dl_id <> (TYPEOF(h.dl_id))'');
    populated_dl_id_pcnt := AVE(GROUP,IF(h.dl_id = (TYPEOF(h.dl_id))'',0,100));
    maxlength_dl_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_id)));
    avelength_dl_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl_id)),h.dl_id<>(typeof(h.dl_id))'');
    populated_first_seen_date_true_cnt := COUNT(GROUP,h.first_seen_date_true <> (TYPEOF(h.first_seen_date_true))'');
    populated_first_seen_date_true_pcnt := AVE(GROUP,IF(h.first_seen_date_true = (TYPEOF(h.first_seen_date_true))'',0,100));
    maxlength_first_seen_date_true := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_seen_date_true)));
    avelength_first_seen_date_true := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_seen_date_true)),h.first_seen_date_true<>(typeof(h.first_seen_date_true))'');
    populated_last_seen_date_cnt := COUNT(GROUP,h.last_seen_date <> (TYPEOF(h.last_seen_date))'');
    populated_last_seen_date_pcnt := AVE(GROUP,IF(h.last_seen_date = (TYPEOF(h.last_seen_date))'',0,100));
    maxlength_last_seen_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_seen_date)));
    avelength_last_seen_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_seen_date)),h.last_seen_date<>(typeof(h.last_seen_date))'');
    populated_dispute_status_cnt := COUNT(GROUP,h.dispute_status <> (TYPEOF(h.dispute_status))'');
    populated_dispute_status_pcnt := AVE(GROUP,IF(h.dispute_status = (TYPEOF(h.dispute_status))'',0,100));
    maxlength_dispute_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispute_status)));
    avelength_dispute_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispute_status)),h.dispute_status<>(typeof(h.dispute_status))'');
    populated_lex_id_cnt := COUNT(GROUP,h.lex_id <> (TYPEOF(h.lex_id))'');
    populated_lex_id_pcnt := AVE(GROUP,IF(h.lex_id = (TYPEOF(h.lex_id))'',0,100));
    maxlength_lex_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lex_id)));
    avelength_lex_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lex_id)),h.lex_id<>(typeof(h.lex_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_cons_id_pcnt *   0.00 / 100 + T.Populated_dl_state_pcnt *   0.00 / 100 + T.Populated_dl_id_pcnt *   0.00 / 100 + T.Populated_first_seen_date_true_pcnt *   0.00 / 100 + T.Populated_last_seen_date_pcnt *   0.00 / 100 + T.Populated_dispute_status_pcnt *   0.00 / 100 + T.Populated_lex_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','filedate','record_type','action_code','cons_id','dl_state','dl_id','first_seen_date_true','last_seen_date','dispute_status','lex_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_filedate_pcnt,le.populated_record_type_pcnt,le.populated_action_code_pcnt,le.populated_cons_id_pcnt,le.populated_dl_state_pcnt,le.populated_dl_id_pcnt,le.populated_first_seen_date_true_pcnt,le.populated_last_seen_date_pcnt,le.populated_dispute_status_pcnt,le.populated_lex_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_filedate,le.maxlength_record_type,le.maxlength_action_code,le.maxlength_cons_id,le.maxlength_dl_state,le.maxlength_dl_id,le.maxlength_first_seen_date_true,le.maxlength_last_seen_date,le.maxlength_dispute_status,le.maxlength_lex_id);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_filedate,le.avelength_record_type,le.avelength_action_code,le.avelength_cons_id,le.avelength_dl_state,le.avelength_dl_id,le.avelength_first_seen_date_true,le.avelength_last_seen_date,le.avelength_dispute_status,le.avelength_lex_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 11, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.filedate),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.cons_id),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dl_id),TRIM((SALT311.StrType)le.first_seen_date_true),TRIM((SALT311.StrType)le.last_seen_date),TRIM((SALT311.StrType)le.dispute_status),TRIM((SALT311.StrType)le.lex_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,11,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 11);
  SELF.FldNo2 := 1 + (C % 11);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.filedate),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.cons_id),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dl_id),TRIM((SALT311.StrType)le.first_seen_date_true),TRIM((SALT311.StrType)le.last_seen_date),TRIM((SALT311.StrType)le.dispute_status),TRIM((SALT311.StrType)le.lex_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.filedate),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.action_code),TRIM((SALT311.StrType)le.cons_id),TRIM((SALT311.StrType)le.dl_state),TRIM((SALT311.StrType)le.dl_id),TRIM((SALT311.StrType)le.first_seen_date_true),TRIM((SALT311.StrType)le.last_seen_date),TRIM((SALT311.StrType)le.dispute_status),TRIM((SALT311.StrType)le.lex_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),11*11,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'filedate'}
      ,{3,'record_type'}
      ,{4,'action_code'}
      ,{5,'cons_id'}
      ,{6,'dl_state'}
      ,{7,'dl_id'}
      ,{8,'first_seen_date_true'}
      ,{9,'last_seen_date'}
      ,{10,'dispute_status'}
      ,{11,'lex_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_filedate((SALT311.StrType)le.filedate),
    Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Fields.InValid_action_code((SALT311.StrType)le.action_code),
    Fields.InValid_cons_id((SALT311.StrType)le.cons_id),
    Fields.InValid_dl_state((SALT311.StrType)le.dl_state),
    Fields.InValid_dl_id((SALT311.StrType)le.dl_id),
    Fields.InValid_first_seen_date_true((SALT311.StrType)le.first_seen_date_true),
    Fields.InValid_last_seen_date((SALT311.StrType)le.last_seen_date),
    Fields.InValid_dispute_status((SALT311.StrType)le.dispute_status),
    Fields.InValid_lex_id((SALT311.StrType)le.lex_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,11,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_RecordType','Invalid_ActionType','Invalid_ConsID','Invalid_State','Unknown','Invalid_Date','Invalid_Date','Unknown','Invalid_LexID');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_action_code(TotalErrors.ErrorNum),Fields.InValidMessage_cons_id(TotalErrors.ErrorNum),Fields.InValidMessage_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_dl_id(TotalErrors.ErrorNum),Fields.InValidMessage_first_seen_date_true(TotalErrors.ErrorNum),Fields.InValidMessage_last_seen_date(TotalErrors.ErrorNum),Fields.InValidMessage_dispute_status(TotalErrors.ErrorNum),Fields.InValidMessage_lex_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FirstData, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

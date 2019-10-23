IMPORT SALT311,STD;
EXPORT Flag_hygiene(dataset(Flag_layout_Overrides) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_flag_file_id_cnt := COUNT(GROUP,h.flag_file_id <> (TYPEOF(h.flag_file_id))'');
    populated_flag_file_id_pcnt := AVE(GROUP,IF(h.flag_file_id = (TYPEOF(h.flag_file_id))'',0,100));
    maxlength_flag_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flag_file_id)));
    avelength_flag_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flag_file_id)),h.flag_file_id<>(typeof(h.flag_file_id))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_file_id_cnt := COUNT(GROUP,h.file_id <> (TYPEOF(h.file_id))'');
    populated_file_id_pcnt := AVE(GROUP,IF(h.file_id = (TYPEOF(h.file_id))'',0,100));
    maxlength_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_id)));
    avelength_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.file_id)),h.file_id<>(typeof(h.file_id))'');
    populated_record_id_cnt := COUNT(GROUP,h.record_id <> (TYPEOF(h.record_id))'');
    populated_record_id_pcnt := AVE(GROUP,IF(h.record_id = (TYPEOF(h.record_id))'',0,100));
    maxlength_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)));
    avelength_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_id)),h.record_id<>(typeof(h.record_id))'');
    populated_override_flag_cnt := COUNT(GROUP,h.override_flag <> (TYPEOF(h.override_flag))'');
    populated_override_flag_pcnt := AVE(GROUP,IF(h.override_flag = (TYPEOF(h.override_flag))'',0,100));
    maxlength_override_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.override_flag)));
    avelength_override_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.override_flag)),h.override_flag<>(typeof(h.override_flag))'');
    populated_in_dispute_flag_cnt := COUNT(GROUP,h.in_dispute_flag <> (TYPEOF(h.in_dispute_flag))'');
    populated_in_dispute_flag_pcnt := AVE(GROUP,IF(h.in_dispute_flag = (TYPEOF(h.in_dispute_flag))'',0,100));
    maxlength_in_dispute_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.in_dispute_flag)));
    avelength_in_dispute_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.in_dispute_flag)),h.in_dispute_flag<>(typeof(h.in_dispute_flag))'');
    populated_consumer_statement_flag_cnt := COUNT(GROUP,h.consumer_statement_flag <> (TYPEOF(h.consumer_statement_flag))'');
    populated_consumer_statement_flag_pcnt := AVE(GROUP,IF(h.consumer_statement_flag = (TYPEOF(h.consumer_statement_flag))'',0,100));
    maxlength_consumer_statement_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.consumer_statement_flag)));
    avelength_consumer_statement_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.consumer_statement_flag)),h.consumer_statement_flag<>(typeof(h.consumer_statement_flag))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_riskwise_uid_cnt := COUNT(GROUP,h.riskwise_uid <> (TYPEOF(h.riskwise_uid))'');
    populated_riskwise_uid_pcnt := AVE(GROUP,IF(h.riskwise_uid = (TYPEOF(h.riskwise_uid))'',0,100));
    maxlength_riskwise_uid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.riskwise_uid)));
    avelength_riskwise_uid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.riskwise_uid)),h.riskwise_uid<>(typeof(h.riskwise_uid))'');
    populated_user_added_cnt := COUNT(GROUP,h.user_added <> (TYPEOF(h.user_added))'');
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_known_missing_cnt := COUNT(GROUP,h.known_missing <> (TYPEOF(h.known_missing))'');
    populated_known_missing_pcnt := AVE(GROUP,IF(h.known_missing = (TYPEOF(h.known_missing))'',0,100));
    maxlength_known_missing := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.known_missing)));
    avelength_known_missing := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.known_missing)),h.known_missing<>(typeof(h.known_missing))'');
    populated_user_changed_cnt := COUNT(GROUP,h.user_changed <> (TYPEOF(h.user_changed))'');
    populated_user_changed_pcnt := AVE(GROUP,IF(h.user_changed = (TYPEOF(h.user_changed))'',0,100));
    maxlength_user_changed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_changed)));
    avelength_user_changed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_changed)),h.user_changed<>(typeof(h.user_changed))'');
    populated_date_changed_cnt := COUNT(GROUP,h.date_changed <> (TYPEOF(h.date_changed))'');
    populated_date_changed_pcnt := AVE(GROUP,IF(h.date_changed = (TYPEOF(h.date_changed))'',0,100));
    maxlength_date_changed := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_changed)));
    avelength_date_changed := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_changed)),h.date_changed<>(typeof(h.date_changed))'');
    populated_lf_cnt := COUNT(GROUP,h.lf <> (TYPEOF(h.lf))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_flag_file_id_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_file_id_pcnt *   0.00 / 100 + T.Populated_record_id_pcnt *   0.00 / 100 + T.Populated_override_flag_pcnt *   0.00 / 100 + T.Populated_in_dispute_flag_pcnt *   0.00 / 100 + T.Populated_consumer_statement_flag_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_riskwise_uid_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_known_missing_pcnt *   0.00 / 100 + T.Populated_user_changed_pcnt *   0.00 / 100 + T.Populated_date_changed_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'flag_file_id','did','file_id','record_id','override_flag','in_dispute_flag','consumer_statement_flag','fname','mname','lname','name_suffix','ssn','dob','riskwise_uid','user_added','date_added','known_missing','user_changed','date_changed','lf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_flag_file_id_pcnt,le.populated_did_pcnt,le.populated_file_id_pcnt,le.populated_record_id_pcnt,le.populated_override_flag_pcnt,le.populated_in_dispute_flag_pcnt,le.populated_consumer_statement_flag_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_riskwise_uid_pcnt,le.populated_user_added_pcnt,le.populated_date_added_pcnt,le.populated_known_missing_pcnt,le.populated_user_changed_pcnt,le.populated_date_changed_pcnt,le.populated_lf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_flag_file_id,le.maxlength_did,le.maxlength_file_id,le.maxlength_record_id,le.maxlength_override_flag,le.maxlength_in_dispute_flag,le.maxlength_consumer_statement_flag,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_ssn,le.maxlength_dob,le.maxlength_riskwise_uid,le.maxlength_user_added,le.maxlength_date_added,le.maxlength_known_missing,le.maxlength_user_changed,le.maxlength_date_changed,le.maxlength_lf);
  SELF.avelength := CHOOSE(C,le.avelength_flag_file_id,le.avelength_did,le.avelength_file_id,le.avelength_record_id,le.avelength_override_flag,le.avelength_in_dispute_flag,le.avelength_consumer_statement_flag,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_ssn,le.avelength_dob,le.avelength_riskwise_uid,le.avelength_user_added,le.avelength_date_added,le.avelength_known_missing,le.avelength_user_changed,le.avelength_date_changed,le.avelength_lf);
END;
EXPORT invSummary := NORMALIZE(summary0, 20, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.flag_file_id),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.override_flag),TRIM((SALT311.StrType)le.in_dispute_flag),TRIM((SALT311.StrType)le.consumer_statement_flag),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.riskwise_uid),TRIM((SALT311.StrType)le.user_added),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.known_missing),TRIM((SALT311.StrType)le.user_changed),TRIM((SALT311.StrType)le.date_changed),TRIM((SALT311.StrType)le.lf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,20,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 20);
  SELF.FldNo2 := 1 + (C % 20);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.flag_file_id),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.override_flag),TRIM((SALT311.StrType)le.in_dispute_flag),TRIM((SALT311.StrType)le.consumer_statement_flag),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.riskwise_uid),TRIM((SALT311.StrType)le.user_added),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.known_missing),TRIM((SALT311.StrType)le.user_changed),TRIM((SALT311.StrType)le.date_changed),TRIM((SALT311.StrType)le.lf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.flag_file_id),TRIM((SALT311.StrType)le.did),TRIM((SALT311.StrType)le.file_id),TRIM((SALT311.StrType)le.record_id),TRIM((SALT311.StrType)le.override_flag),TRIM((SALT311.StrType)le.in_dispute_flag),TRIM((SALT311.StrType)le.consumer_statement_flag),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.riskwise_uid),TRIM((SALT311.StrType)le.user_added),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.known_missing),TRIM((SALT311.StrType)le.user_changed),TRIM((SALT311.StrType)le.date_changed),TRIM((SALT311.StrType)le.lf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),20*20,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'flag_file_id'}
      ,{2,'did'}
      ,{3,'file_id'}
      ,{4,'record_id'}
      ,{5,'override_flag'}
      ,{6,'in_dispute_flag'}
      ,{7,'consumer_statement_flag'}
      ,{8,'fname'}
      ,{9,'mname'}
      ,{10,'lname'}
      ,{11,'name_suffix'}
      ,{12,'ssn'}
      ,{13,'dob'}
      ,{14,'riskwise_uid'}
      ,{15,'user_added'}
      ,{16,'date_added'}
      ,{17,'known_missing'}
      ,{18,'user_changed'}
      ,{19,'date_changed'}
      ,{20,'lf'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Flag_Fields.InValid_flag_file_id((SALT311.StrType)le.flag_file_id),
    Flag_Fields.InValid_did((SALT311.StrType)le.did),
    Flag_Fields.InValid_file_id((SALT311.StrType)le.file_id),
    Flag_Fields.InValid_record_id((SALT311.StrType)le.record_id),
    Flag_Fields.InValid_override_flag((SALT311.StrType)le.override_flag),
    Flag_Fields.InValid_in_dispute_flag((SALT311.StrType)le.in_dispute_flag),
    Flag_Fields.InValid_consumer_statement_flag((SALT311.StrType)le.consumer_statement_flag),
    Flag_Fields.InValid_fname((SALT311.StrType)le.fname),
    Flag_Fields.InValid_mname((SALT311.StrType)le.mname),
    Flag_Fields.InValid_lname((SALT311.StrType)le.lname),
    Flag_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Flag_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Flag_Fields.InValid_dob((SALT311.StrType)le.dob),
    Flag_Fields.InValid_riskwise_uid((SALT311.StrType)le.riskwise_uid),
    Flag_Fields.InValid_user_added((SALT311.StrType)le.user_added),
    Flag_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Flag_Fields.InValid_known_missing((SALT311.StrType)le.known_missing),
    Flag_Fields.InValid_user_changed((SALT311.StrType)le.user_changed),
    Flag_Fields.InValid_date_changed((SALT311.StrType)le.date_changed),
    Flag_Fields.InValid_lf((SALT311.StrType)le.lf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,20,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Flag_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_FlagID','Invalid_Num','Invalid_Letters','Unknown','Invalid_OverrideFlag','Unknown','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_SSN','Invalid_DOB','Invalid_Num','Unknown','Invalid_Date','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Flag_Fields.InValidMessage_flag_file_id(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_did(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_file_id(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_record_id(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_override_flag(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_in_dispute_flag(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_consumer_statement_flag(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_riskwise_uid(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_user_added(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_known_missing(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_user_changed(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_date_changed(TotalErrors.ErrorNum),Flag_Fields.InValidMessage_lf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, Flag_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

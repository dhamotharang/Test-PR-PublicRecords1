IMPORT SALT311,STD;
EXPORT Sources_hygiene(dataset(Sources_layout_PhoneFinder) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_auto_id_cnt := COUNT(GROUP,h.auto_id <> (TYPEOF(h.auto_id))'');
    populated_auto_id_pcnt := AVE(GROUP,IF(h.auto_id = (TYPEOF(h.auto_id))'',0,100));
    maxlength_auto_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.auto_id)));
    avelength_auto_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.auto_id)),h.auto_id<>(typeof(h.auto_id))'');
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_phonenumber_cnt := COUNT(GROUP,h.phonenumber <> (TYPEOF(h.phonenumber))'');
    populated_phonenumber_pcnt := AVE(GROUP,IF(h.phonenumber = (TYPEOF(h.phonenumber))'',0,100));
    maxlength_phonenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)));
    avelength_phonenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)),h.phonenumber<>(typeof(h.phonenumber))'');
    populated_lexid_cnt := COUNT(GROUP,h.lexid <> (TYPEOF(h.lexid))'');
    populated_lexid_pcnt := AVE(GROUP,IF(h.lexid = (TYPEOF(h.lexid))'',0,100));
    maxlength_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)));
    avelength_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)),h.lexid<>(typeof(h.lexid))'');
    populated_phone_id_cnt := COUNT(GROUP,h.phone_id <> (TYPEOF(h.phone_id))'');
    populated_phone_id_pcnt := AVE(GROUP,IF(h.phone_id = (TYPEOF(h.phone_id))'',0,100));
    maxlength_phone_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)));
    avelength_phone_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)),h.phone_id<>(typeof(h.phone_id))'');
    populated_identity_id_cnt := COUNT(GROUP,h.identity_id <> (TYPEOF(h.identity_id))'');
    populated_identity_id_pcnt := AVE(GROUP,IF(h.identity_id = (TYPEOF(h.identity_id))'',0,100));
    maxlength_identity_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_id)));
    avelength_identity_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_id)),h.identity_id<>(typeof(h.identity_id))'');
    populated_sequence_number_cnt := COUNT(GROUP,h.sequence_number <> (TYPEOF(h.sequence_number))'');
    populated_sequence_number_pcnt := AVE(GROUP,IF(h.sequence_number = (TYPEOF(h.sequence_number))'',0,100));
    maxlength_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)));
    avelength_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)),h.sequence_number<>(typeof(h.sequence_number))'');
    populated_totalsourcecount_cnt := COUNT(GROUP,h.totalsourcecount <> (TYPEOF(h.totalsourcecount))'');
    populated_totalsourcecount_pcnt := AVE(GROUP,IF(h.totalsourcecount = (TYPEOF(h.totalsourcecount))'',0,100));
    maxlength_totalsourcecount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalsourcecount)));
    avelength_totalsourcecount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.totalsourcecount)),h.totalsourcecount<>(typeof(h.totalsourcecount))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_auto_id_pcnt *   0.00 / 100 + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_phonenumber_pcnt *   0.00 / 100 + T.Populated_lexid_pcnt *   0.00 / 100 + T.Populated_phone_id_pcnt *   0.00 / 100 + T.Populated_identity_id_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_totalsourcecount_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'auto_id','transaction_id','phonenumber','lexid','phone_id','identity_id','sequence_number','totalsourcecount','date_added','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_auto_id_pcnt,le.populated_transaction_id_pcnt,le.populated_phonenumber_pcnt,le.populated_lexid_pcnt,le.populated_phone_id_pcnt,le.populated_identity_id_pcnt,le.populated_sequence_number_pcnt,le.populated_totalsourcecount_pcnt,le.populated_date_added_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_auto_id,le.maxlength_transaction_id,le.maxlength_phonenumber,le.maxlength_lexid,le.maxlength_phone_id,le.maxlength_identity_id,le.maxlength_sequence_number,le.maxlength_totalsourcecount,le.maxlength_date_added,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_auto_id,le.avelength_transaction_id,le.avelength_phonenumber,le.avelength_lexid,le.avelength_phone_id,le.avelength_identity_id,le.avelength_sequence_number,le.avelength_totalsourcecount,le.avelength_date_added,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.auto_id <> 0,TRIM((SALT311.StrType)le.auto_id), ''),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.lexid),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.identity_id <> 0,TRIM((SALT311.StrType)le.identity_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.totalsourcecount <> 0,TRIM((SALT311.StrType)le.totalsourcecount), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.auto_id <> 0,TRIM((SALT311.StrType)le.auto_id), ''),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.lexid),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.identity_id <> 0,TRIM((SALT311.StrType)le.identity_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.totalsourcecount <> 0,TRIM((SALT311.StrType)le.totalsourcecount), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.auto_id <> 0,TRIM((SALT311.StrType)le.auto_id), ''),TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.lexid),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.identity_id <> 0,TRIM((SALT311.StrType)le.identity_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),IF (le.totalsourcecount <> 0,TRIM((SALT311.StrType)le.totalsourcecount), ''),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'auto_id'}
      ,{2,'transaction_id'}
      ,{3,'phonenumber'}
      ,{4,'lexid'}
      ,{5,'phone_id'}
      ,{6,'identity_id'}
      ,{7,'sequence_number'}
      ,{8,'totalsourcecount'}
      ,{9,'date_added'}
      ,{10,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Sources_Fields.InValid_auto_id((SALT311.StrType)le.auto_id),
    Sources_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    Sources_Fields.InValid_phonenumber((SALT311.StrType)le.phonenumber),
    Sources_Fields.InValid_lexid((SALT311.StrType)le.lexid),
    Sources_Fields.InValid_phone_id((SALT311.StrType)le.phone_id),
    Sources_Fields.InValid_identity_id((SALT311.StrType)le.identity_id),
    Sources_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    Sources_Fields.InValid_totalsourcecount((SALT311.StrType)le.totalsourcecount),
    Sources_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Sources_Fields.InValid_filename((SALT311.StrType)le.filename),
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
  FieldNme := Sources_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_No','Invalid_ID','Invalid_Phone','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_No','Invalid_Date','Invalid_File');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Sources_Fields.InValidMessage_auto_id(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_phonenumber(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_lexid(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_phone_id(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_identity_id(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_totalsourcecount(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Sources_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Sources_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

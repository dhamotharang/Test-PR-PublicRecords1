IMPORT SALT38,STD;
EXPORT Airmen_Cert_hygiene(dataset(Airmen_Cert_layout_FAA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_current_flag_cnt := COUNT(GROUP,h.current_flag <> (TYPEOF(h.current_flag))'');
    populated_current_flag_pcnt := AVE(GROUP,IF(h.current_flag = (TYPEOF(h.current_flag))'',0,100));
    maxlength_current_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)));
    avelength_current_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)),h.current_flag<>(typeof(h.current_flag))'');
    populated_letter_cnt := COUNT(GROUP,h.letter <> (TYPEOF(h.letter))'');
    populated_letter_pcnt := AVE(GROUP,IF(h.letter = (TYPEOF(h.letter))'',0,100));
    maxlength_letter := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.letter)));
    avelength_letter := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.letter)),h.letter<>(typeof(h.letter))'');
    populated_unique_id_cnt := COUNT(GROUP,h.unique_id <> (TYPEOF(h.unique_id))'');
    populated_unique_id_pcnt := AVE(GROUP,IF(h.unique_id = (TYPEOF(h.unique_id))'',0,100));
    maxlength_unique_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_id)));
    avelength_unique_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_id)),h.unique_id<>(typeof(h.unique_id))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_cer_type_cnt := COUNT(GROUP,h.cer_type <> (TYPEOF(h.cer_type))'');
    populated_cer_type_pcnt := AVE(GROUP,IF(h.cer_type = (TYPEOF(h.cer_type))'',0,100));
    maxlength_cer_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_type)));
    avelength_cer_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_type)),h.cer_type<>(typeof(h.cer_type))'');
    populated_cer_type_mapped_cnt := COUNT(GROUP,h.cer_type_mapped <> (TYPEOF(h.cer_type_mapped))'');
    populated_cer_type_mapped_pcnt := AVE(GROUP,IF(h.cer_type_mapped = (TYPEOF(h.cer_type_mapped))'',0,100));
    maxlength_cer_type_mapped := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_type_mapped)));
    avelength_cer_type_mapped := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_type_mapped)),h.cer_type_mapped<>(typeof(h.cer_type_mapped))'');
    populated_cer_level_cnt := COUNT(GROUP,h.cer_level <> (TYPEOF(h.cer_level))'');
    populated_cer_level_pcnt := AVE(GROUP,IF(h.cer_level = (TYPEOF(h.cer_level))'',0,100));
    maxlength_cer_level := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_level)));
    avelength_cer_level := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_level)),h.cer_level<>(typeof(h.cer_level))'');
    populated_cer_level_mapped_cnt := COUNT(GROUP,h.cer_level_mapped <> (TYPEOF(h.cer_level_mapped))'');
    populated_cer_level_mapped_pcnt := AVE(GROUP,IF(h.cer_level_mapped = (TYPEOF(h.cer_level_mapped))'',0,100));
    maxlength_cer_level_mapped := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_level_mapped)));
    avelength_cer_level_mapped := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_level_mapped)),h.cer_level_mapped<>(typeof(h.cer_level_mapped))'');
    populated_cer_exp_date_cnt := COUNT(GROUP,h.cer_exp_date <> (TYPEOF(h.cer_exp_date))'');
    populated_cer_exp_date_pcnt := AVE(GROUP,IF(h.cer_exp_date = (TYPEOF(h.cer_exp_date))'',0,100));
    maxlength_cer_exp_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_exp_date)));
    avelength_cer_exp_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cer_exp_date)),h.cer_exp_date<>(typeof(h.cer_exp_date))'');
    populated_ratings_cnt := COUNT(GROUP,h.ratings <> (TYPEOF(h.ratings))'');
    populated_ratings_pcnt := AVE(GROUP,IF(h.ratings = (TYPEOF(h.ratings))'',0,100));
    maxlength_ratings := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ratings)));
    avelength_ratings := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ratings)),h.ratings<>(typeof(h.ratings))'');
    populated_filler_cnt := COUNT(GROUP,h.filler <> (TYPEOF(h.filler))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
    populated_lfcr_cnt := COUNT(GROUP,h.lfcr <> (TYPEOF(h.lfcr))'');
    populated_lfcr_pcnt := AVE(GROUP,IF(h.lfcr = (TYPEOF(h.lfcr))'',0,100));
    maxlength_lfcr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lfcr)));
    avelength_lfcr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lfcr)),h.lfcr<>(typeof(h.lfcr))'');
    populated_persistent_record_id_cnt := COUNT(GROUP,h.persistent_record_id <> (TYPEOF(h.persistent_record_id))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_current_flag_pcnt *   0.00 / 100 + T.Populated_letter_pcnt *   0.00 / 100 + T.Populated_unique_id_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_cer_type_pcnt *   0.00 / 100 + T.Populated_cer_type_mapped_pcnt *   0.00 / 100 + T.Populated_cer_level_pcnt *   0.00 / 100 + T.Populated_cer_level_mapped_pcnt *   0.00 / 100 + T.Populated_cer_exp_date_pcnt *   0.00 / 100 + T.Populated_ratings_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100 + T.Populated_lfcr_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'date_first_seen','date_last_seen','current_flag','letter','unique_id','rec_type','cer_type','cer_type_mapped','cer_level','cer_level_mapped','cer_exp_date','ratings','filler','lfcr','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_current_flag_pcnt,le.populated_letter_pcnt,le.populated_unique_id_pcnt,le.populated_rec_type_pcnt,le.populated_cer_type_pcnt,le.populated_cer_type_mapped_pcnt,le.populated_cer_level_pcnt,le.populated_cer_level_mapped_pcnt,le.populated_cer_exp_date_pcnt,le.populated_ratings_pcnt,le.populated_filler_pcnt,le.populated_lfcr_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_current_flag,le.maxlength_letter,le.maxlength_unique_id,le.maxlength_rec_type,le.maxlength_cer_type,le.maxlength_cer_type_mapped,le.maxlength_cer_level,le.maxlength_cer_level_mapped,le.maxlength_cer_exp_date,le.maxlength_ratings,le.maxlength_filler,le.maxlength_lfcr,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_current_flag,le.avelength_letter,le.avelength_unique_id,le.avelength_rec_type,le.avelength_cer_type,le.avelength_cer_type_mapped,le.avelength_cer_level,le.avelength_cer_level_mapped,le.avelength_cer_exp_date,le.avelength_ratings,le.avelength_filler,le.avelength_lfcr,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.letter),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.cer_type),TRIM((SALT38.StrType)le.cer_type_mapped),TRIM((SALT38.StrType)le.cer_level),TRIM((SALT38.StrType)le.cer_level_mapped),TRIM((SALT38.StrType)le.cer_exp_date),TRIM((SALT38.StrType)le.ratings),TRIM((SALT38.StrType)le.filler),TRIM((SALT38.StrType)le.lfcr),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.letter),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.cer_type),TRIM((SALT38.StrType)le.cer_type_mapped),TRIM((SALT38.StrType)le.cer_level),TRIM((SALT38.StrType)le.cer_level_mapped),TRIM((SALT38.StrType)le.cer_exp_date),TRIM((SALT38.StrType)le.ratings),TRIM((SALT38.StrType)le.filler),TRIM((SALT38.StrType)le.lfcr),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.letter),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.cer_type),TRIM((SALT38.StrType)le.cer_type_mapped),TRIM((SALT38.StrType)le.cer_level),TRIM((SALT38.StrType)le.cer_level_mapped),TRIM((SALT38.StrType)le.cer_exp_date),TRIM((SALT38.StrType)le.ratings),TRIM((SALT38.StrType)le.filler),TRIM((SALT38.StrType)le.lfcr),IF (le.persistent_record_id <> 0,TRIM((SALT38.StrType)le.persistent_record_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_first_seen'}
      ,{2,'date_last_seen'}
      ,{3,'current_flag'}
      ,{4,'letter'}
      ,{5,'unique_id'}
      ,{6,'rec_type'}
      ,{7,'cer_type'}
      ,{8,'cer_type_mapped'}
      ,{9,'cer_level'}
      ,{10,'cer_level_mapped'}
      ,{11,'cer_exp_date'}
      ,{12,'ratings'}
      ,{13,'filler'}
      ,{14,'lfcr'}
      ,{15,'persistent_record_id'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Airmen_Cert_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen),
    Airmen_Cert_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen),
    Airmen_Cert_Fields.InValid_current_flag((SALT38.StrType)le.current_flag),
    Airmen_Cert_Fields.InValid_letter((SALT38.StrType)le.letter),
    Airmen_Cert_Fields.InValid_unique_id((SALT38.StrType)le.unique_id),
    Airmen_Cert_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Airmen_Cert_Fields.InValid_cer_type((SALT38.StrType)le.cer_type),
    Airmen_Cert_Fields.InValid_cer_type_mapped((SALT38.StrType)le.cer_type_mapped),
    Airmen_Cert_Fields.InValid_cer_level((SALT38.StrType)le.cer_level),
    Airmen_Cert_Fields.InValid_cer_level_mapped((SALT38.StrType)le.cer_level_mapped),
    Airmen_Cert_Fields.InValid_cer_exp_date((SALT38.StrType)le.cer_exp_date),
    Airmen_Cert_Fields.InValid_ratings((SALT38.StrType)le.ratings),
    Airmen_Cert_Fields.InValid_filler((SALT38.StrType)le.filler),
    Airmen_Cert_Fields.InValid_lfcr((SALT38.StrType)le.lfcr),
    Airmen_Cert_Fields.InValid_persistent_record_id((SALT38.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,15,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Airmen_Cert_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Flag','Invalid_LetterCode','Invalid_Num','Invalid_RecType','Invalid_CerType','Unknown','Invalid_CerLevel','Unknown','Invalid_Num','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Airmen_Cert_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_current_flag(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_letter(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_unique_id(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_cer_type(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_cer_type_mapped(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_cer_level(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_cer_level_mapped(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_cer_exp_date(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_ratings(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_filler(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_lfcr(TotalErrors.ErrorNum),Airmen_Cert_Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Airmen_Cert_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

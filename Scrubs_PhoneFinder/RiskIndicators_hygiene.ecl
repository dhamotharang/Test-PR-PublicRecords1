IMPORT SALT311,STD;
EXPORT RiskIndicators_hygiene(dataset(RiskIndicators_layout_PhoneFinder) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_phone_id_cnt := COUNT(GROUP,h.phone_id <> (TYPEOF(h.phone_id))'');
    populated_phone_id_pcnt := AVE(GROUP,IF(h.phone_id = (TYPEOF(h.phone_id))'',0,100));
    maxlength_phone_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)));
    avelength_phone_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_id)),h.phone_id<>(typeof(h.phone_id))'');
    populated_sequence_number_cnt := COUNT(GROUP,h.sequence_number <> (TYPEOF(h.sequence_number))'');
    populated_sequence_number_pcnt := AVE(GROUP,IF(h.sequence_number = (TYPEOF(h.sequence_number))'',0,100));
    maxlength_sequence_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)));
    avelength_sequence_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sequence_number)),h.sequence_number<>(typeof(h.sequence_number))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_risk_indicator_id_cnt := COUNT(GROUP,h.risk_indicator_id <> (TYPEOF(h.risk_indicator_id))'');
    populated_risk_indicator_id_pcnt := AVE(GROUP,IF(h.risk_indicator_id = (TYPEOF(h.risk_indicator_id))'',0,100));
    maxlength_risk_indicator_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_id)));
    avelength_risk_indicator_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_id)),h.risk_indicator_id<>(typeof(h.risk_indicator_id))'');
    populated_risk_indicator_level_cnt := COUNT(GROUP,h.risk_indicator_level <> (TYPEOF(h.risk_indicator_level))'');
    populated_risk_indicator_level_pcnt := AVE(GROUP,IF(h.risk_indicator_level = (TYPEOF(h.risk_indicator_level))'',0,100));
    maxlength_risk_indicator_level := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_level)));
    avelength_risk_indicator_level := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_level)),h.risk_indicator_level<>(typeof(h.risk_indicator_level))'');
    populated_risk_indicator_text_cnt := COUNT(GROUP,h.risk_indicator_text <> (TYPEOF(h.risk_indicator_text))'');
    populated_risk_indicator_text_pcnt := AVE(GROUP,IF(h.risk_indicator_text = (TYPEOF(h.risk_indicator_text))'',0,100));
    maxlength_risk_indicator_text := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_text)));
    avelength_risk_indicator_text := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_text)),h.risk_indicator_text<>(typeof(h.risk_indicator_text))'');
    populated_risk_indicator_category_cnt := COUNT(GROUP,h.risk_indicator_category <> (TYPEOF(h.risk_indicator_category))'');
    populated_risk_indicator_category_pcnt := AVE(GROUP,IF(h.risk_indicator_category = (TYPEOF(h.risk_indicator_category))'',0,100));
    maxlength_risk_indicator_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_category)));
    avelength_risk_indicator_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator_category)),h.risk_indicator_category<>(typeof(h.risk_indicator_category))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_phone_id_pcnt *   0.00 / 100 + T.Populated_sequence_number_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_risk_indicator_id_pcnt *   0.00 / 100 + T.Populated_risk_indicator_level_pcnt *   0.00 / 100 + T.Populated_risk_indicator_text_pcnt *   0.00 / 100 + T.Populated_risk_indicator_category_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'transaction_id','phone_id','sequence_number','date_added','risk_indicator_id','risk_indicator_level','risk_indicator_text','risk_indicator_category','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_transaction_id_pcnt,le.populated_phone_id_pcnt,le.populated_sequence_number_pcnt,le.populated_date_added_pcnt,le.populated_risk_indicator_id_pcnt,le.populated_risk_indicator_level_pcnt,le.populated_risk_indicator_text_pcnt,le.populated_risk_indicator_category_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_transaction_id,le.maxlength_phone_id,le.maxlength_sequence_number,le.maxlength_date_added,le.maxlength_risk_indicator_id,le.maxlength_risk_indicator_level,le.maxlength_risk_indicator_text,le.maxlength_risk_indicator_category,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_transaction_id,le.avelength_phone_id,le.avelength_sequence_number,le.avelength_date_added,le.avelength_risk_indicator_id,le.avelength_risk_indicator_level,le.avelength_risk_indicator_text,le.avelength_risk_indicator_category,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.transaction_id),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.date_added),IF (le.risk_indicator_id <> 0,TRIM((SALT311.StrType)le.risk_indicator_id), ''),TRIM((SALT311.StrType)le.risk_indicator_level),TRIM((SALT311.StrType)le.risk_indicator_text),TRIM((SALT311.StrType)le.risk_indicator_category),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.transaction_id),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.date_added),IF (le.risk_indicator_id <> 0,TRIM((SALT311.StrType)le.risk_indicator_id), ''),TRIM((SALT311.StrType)le.risk_indicator_level),TRIM((SALT311.StrType)le.risk_indicator_text),TRIM((SALT311.StrType)le.risk_indicator_category),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.transaction_id),IF (le.phone_id <> 0,TRIM((SALT311.StrType)le.phone_id), ''),IF (le.sequence_number <> 0,TRIM((SALT311.StrType)le.sequence_number), ''),TRIM((SALT311.StrType)le.date_added),IF (le.risk_indicator_id <> 0,TRIM((SALT311.StrType)le.risk_indicator_id), ''),TRIM((SALT311.StrType)le.risk_indicator_level),TRIM((SALT311.StrType)le.risk_indicator_text),TRIM((SALT311.StrType)le.risk_indicator_category),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'transaction_id'}
      ,{2,'phone_id'}
      ,{3,'sequence_number'}
      ,{4,'date_added'}
      ,{5,'risk_indicator_id'}
      ,{6,'risk_indicator_level'}
      ,{7,'risk_indicator_text'}
      ,{8,'risk_indicator_category'}
      ,{9,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RiskIndicators_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    RiskIndicators_Fields.InValid_phone_id((SALT311.StrType)le.phone_id),
    RiskIndicators_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number),
    RiskIndicators_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    RiskIndicators_Fields.InValid_risk_indicator_id((SALT311.StrType)le.risk_indicator_id),
    RiskIndicators_Fields.InValid_risk_indicator_level((SALT311.StrType)le.risk_indicator_level),
    RiskIndicators_Fields.InValid_risk_indicator_text((SALT311.StrType)le.risk_indicator_text),
    RiskIndicators_Fields.InValid_risk_indicator_category((SALT311.StrType)le.risk_indicator_category),
    RiskIndicators_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,9,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RiskIndicators_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_ID','Invalid_No','Invalid_No','Invalid_Date','Invalid_No','Invalid_Alpha','Unknown','Invalid_Risk','Invalid_File');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RiskIndicators_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_phone_id(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_sequence_number(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_risk_indicator_id(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_risk_indicator_level(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_risk_indicator_text(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_risk_indicator_category(TotalErrors.ErrorNum),RiskIndicators_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, RiskIndicators_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

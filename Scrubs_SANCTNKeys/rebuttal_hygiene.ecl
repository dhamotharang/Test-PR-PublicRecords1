IMPORT SALT38,STD;
EXPORT rebuttal_hygiene(dataset(rebuttal_layout_SANCTNKeys) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_batch_number_cnt := COUNT(GROUP,h.batch_number <> (TYPEOF(h.batch_number))'');
    populated_batch_number_pcnt := AVE(GROUP,IF(h.batch_number = (TYPEOF(h.batch_number))'',0,100));
    maxlength_batch_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)));
    avelength_batch_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)),h.batch_number<>(typeof(h.batch_number))'');
    populated_incident_number_cnt := COUNT(GROUP,h.incident_number <> (TYPEOF(h.incident_number))'');
    populated_incident_number_pcnt := AVE(GROUP,IF(h.incident_number = (TYPEOF(h.incident_number))'',0,100));
    maxlength_incident_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)));
    avelength_incident_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)),h.incident_number<>(typeof(h.incident_number))'');
    populated_party_number_cnt := COUNT(GROUP,h.party_number <> (TYPEOF(h.party_number))'');
    populated_party_number_pcnt := AVE(GROUP,IF(h.party_number = (TYPEOF(h.party_number))'',0,100));
    maxlength_party_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)));
    avelength_party_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)),h.party_number<>(typeof(h.party_number))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_order_number_cnt := COUNT(GROUP,h.order_number <> (TYPEOF(h.order_number))'');
    populated_order_number_pcnt := AVE(GROUP,IF(h.order_number = (TYPEOF(h.order_number))'',0,100));
    maxlength_order_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)));
    avelength_order_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)),h.order_number<>(typeof(h.order_number))'');
    populated_party_text_cnt := COUNT(GROUP,h.party_text <> (TYPEOF(h.party_text))'');
    populated_party_text_pcnt := AVE(GROUP,IF(h.party_text = (TYPEOF(h.party_text))'',0,100));
    maxlength_party_text := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_text)));
    avelength_party_text := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_text)),h.party_text<>(typeof(h.party_text))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_number_pcnt *   0.00 / 100 + T.Populated_incident_number_pcnt *   0.00 / 100 + T.Populated_party_number_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_order_number_pcnt *   0.00 / 100 + T.Populated_party_text_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'batch_number','incident_number','party_number','record_type','order_number','party_text');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_number_pcnt,le.populated_incident_number_pcnt,le.populated_party_number_pcnt,le.populated_record_type_pcnt,le.populated_order_number_pcnt,le.populated_party_text_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch_number,le.maxlength_incident_number,le.maxlength_party_number,le.maxlength_record_type,le.maxlength_order_number,le.maxlength_party_text);
  SELF.avelength := CHOOSE(C,le.avelength_batch_number,le.avelength_incident_number,le.avelength_party_number,le.avelength_record_type,le.avelength_order_number,le.avelength_party_text);
END;
EXPORT invSummary := NORMALIZE(summary0, 6, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_text)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,6,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 6);
  SELF.FldNo2 := 1 + (C % 6);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_text)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_text)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),6*6,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch_number'}
      ,{2,'incident_number'}
      ,{3,'party_number'}
      ,{4,'record_type'}
      ,{5,'order_number'}
      ,{6,'party_text'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    rebuttal_Fields.InValid_batch_number((SALT38.StrType)le.batch_number),
    rebuttal_Fields.InValid_incident_number((SALT38.StrType)le.incident_number),
    rebuttal_Fields.InValid_party_number((SALT38.StrType)le.party_number),
    rebuttal_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    rebuttal_Fields.InValid_order_number((SALT38.StrType)le.order_number),
    rebuttal_Fields.InValid_party_text((SALT38.StrType)le.party_text),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,6,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := rebuttal_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,rebuttal_Fields.InValidMessage_batch_number(TotalErrors.ErrorNum),rebuttal_Fields.InValidMessage_incident_number(TotalErrors.ErrorNum),rebuttal_Fields.InValidMessage_party_number(TotalErrors.ErrorNum),rebuttal_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),rebuttal_Fields.InValidMessage_order_number(TotalErrors.ErrorNum),rebuttal_Fields.InValidMessage_party_text(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, rebuttal_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

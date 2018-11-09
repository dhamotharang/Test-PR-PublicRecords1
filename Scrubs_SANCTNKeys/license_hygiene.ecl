IMPORT SALT38,STD;
EXPORT license_hygiene(dataset(license_layout_SANCTNKeys) h) := MODULE
 
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
    populated_license_number_cnt := COUNT(GROUP,h.license_number <> (TYPEOF(h.license_number))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_license_type_cnt := COUNT(GROUP,h.license_type <> (TYPEOF(h.license_type))'');
    populated_license_type_pcnt := AVE(GROUP,IF(h.license_type = (TYPEOF(h.license_type))'',0,100));
    maxlength_license_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_type)));
    avelength_license_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_type)),h.license_type<>(typeof(h.license_type))'');
    populated_license_state_cnt := COUNT(GROUP,h.license_state <> (TYPEOF(h.license_state))'');
    populated_license_state_pcnt := AVE(GROUP,IF(h.license_state = (TYPEOF(h.license_state))'',0,100));
    maxlength_license_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_state)));
    avelength_license_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_state)),h.license_state<>(typeof(h.license_state))'');
    populated_cln_license_number_cnt := COUNT(GROUP,h.cln_license_number <> (TYPEOF(h.cln_license_number))'');
    populated_cln_license_number_pcnt := AVE(GROUP,IF(h.cln_license_number = (TYPEOF(h.cln_license_number))'',0,100));
    maxlength_cln_license_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_license_number)));
    avelength_cln_license_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_license_number)),h.cln_license_number<>(typeof(h.cln_license_number))'');
    populated_std_type_desc_cnt := COUNT(GROUP,h.std_type_desc <> (TYPEOF(h.std_type_desc))'');
    populated_std_type_desc_pcnt := AVE(GROUP,IF(h.std_type_desc = (TYPEOF(h.std_type_desc))'',0,100));
    maxlength_std_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.std_type_desc)));
    avelength_std_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.std_type_desc)),h.std_type_desc<>(typeof(h.std_type_desc))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_number_pcnt *   0.00 / 100 + T.Populated_incident_number_pcnt *   0.00 / 100 + T.Populated_party_number_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_order_number_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_license_type_pcnt *   0.00 / 100 + T.Populated_license_state_pcnt *   0.00 / 100 + T.Populated_cln_license_number_pcnt *   0.00 / 100 + T.Populated_std_type_desc_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'batch_number','incident_number','party_number','record_type','order_number','license_number','license_type','license_state','cln_license_number','std_type_desc');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_number_pcnt,le.populated_incident_number_pcnt,le.populated_party_number_pcnt,le.populated_record_type_pcnt,le.populated_order_number_pcnt,le.populated_license_number_pcnt,le.populated_license_type_pcnt,le.populated_license_state_pcnt,le.populated_cln_license_number_pcnt,le.populated_std_type_desc_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch_number,le.maxlength_incident_number,le.maxlength_party_number,le.maxlength_record_type,le.maxlength_order_number,le.maxlength_license_number,le.maxlength_license_type,le.maxlength_license_state,le.maxlength_cln_license_number,le.maxlength_std_type_desc);
  SELF.avelength := CHOOSE(C,le.avelength_batch_number,le.avelength_incident_number,le.avelength_party_number,le.avelength_record_type,le.avelength_order_number,le.avelength_license_number,le.avelength_license_type,le.avelength_license_state,le.avelength_cln_license_number,le.avelength_std_type_desc);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.license_type),TRIM((SALT38.StrType)le.license_state),TRIM((SALT38.StrType)le.cln_license_number),TRIM((SALT38.StrType)le.std_type_desc)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.license_type),TRIM((SALT38.StrType)le.license_state),TRIM((SALT38.StrType)le.cln_license_number),TRIM((SALT38.StrType)le.std_type_desc)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.license_type),TRIM((SALT38.StrType)le.license_state),TRIM((SALT38.StrType)le.cln_license_number),TRIM((SALT38.StrType)le.std_type_desc)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch_number'}
      ,{2,'incident_number'}
      ,{3,'party_number'}
      ,{4,'record_type'}
      ,{5,'order_number'}
      ,{6,'license_number'}
      ,{7,'license_type'}
      ,{8,'license_state'}
      ,{9,'cln_license_number'}
      ,{10,'std_type_desc'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    license_Fields.InValid_batch_number((SALT38.StrType)le.batch_number),
    license_Fields.InValid_incident_number((SALT38.StrType)le.incident_number),
    license_Fields.InValid_party_number((SALT38.StrType)le.party_number),
    license_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    license_Fields.InValid_order_number((SALT38.StrType)le.order_number),
    license_Fields.InValid_license_number((SALT38.StrType)le.license_number),
    license_Fields.InValid_license_type((SALT38.StrType)le.license_type),
    license_Fields.InValid_license_state((SALT38.StrType)le.license_state),
    license_Fields.InValid_cln_license_number((SALT38.StrType)le.cln_license_number),
    license_Fields.InValid_std_type_desc((SALT38.StrType)le.std_type_desc),
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
  FieldNme := license_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Invalid_LicenseNumber','Invalid_LicenseType','Invalid_State','Invalid_ClnLicenseNumber','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,license_Fields.InValidMessage_batch_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_incident_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_party_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),license_Fields.InValidMessage_order_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_license_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_license_type(TotalErrors.ErrorNum),license_Fields.InValidMessage_license_state(TotalErrors.ErrorNum),license_Fields.InValidMessage_cln_license_number(TotalErrors.ErrorNum),license_Fields.InValidMessage_std_type_desc(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, license_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

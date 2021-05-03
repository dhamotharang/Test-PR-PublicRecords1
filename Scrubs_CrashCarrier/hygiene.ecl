IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_In_CrashCarrier) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_carrier_id_cnt := COUNT(GROUP,h.carrier_id <> (TYPEOF(h.carrier_id))'');
    populated_carrier_id_pcnt := AVE(GROUP,IF(h.carrier_id = (TYPEOF(h.carrier_id))'',0,100));
    maxlength_carrier_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_id)));
    avelength_carrier_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_id)),h.carrier_id<>(typeof(h.carrier_id))'');
    populated_crash_id_cnt := COUNT(GROUP,h.crash_id <> (TYPEOF(h.crash_id))'');
    populated_crash_id_pcnt := AVE(GROUP,IF(h.crash_id = (TYPEOF(h.crash_id))'',0,100));
    maxlength_crash_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crash_id)));
    avelength_crash_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crash_id)),h.crash_id<>(typeof(h.crash_id))'');
    populated_carrier_source_code_cnt := COUNT(GROUP,h.carrier_source_code <> (TYPEOF(h.carrier_source_code))'');
    populated_carrier_source_code_pcnt := AVE(GROUP,IF(h.carrier_source_code = (TYPEOF(h.carrier_source_code))'',0,100));
    maxlength_carrier_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_source_code)));
    avelength_carrier_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_source_code)),h.carrier_source_code<>(typeof(h.carrier_source_code))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_carrier_street_cnt := COUNT(GROUP,h.carrier_street <> (TYPEOF(h.carrier_street))'');
    populated_carrier_street_pcnt := AVE(GROUP,IF(h.carrier_street = (TYPEOF(h.carrier_street))'',0,100));
    maxlength_carrier_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_street)));
    avelength_carrier_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_street)),h.carrier_street<>(typeof(h.carrier_street))'');
    populated_carrier_city_cnt := COUNT(GROUP,h.carrier_city <> (TYPEOF(h.carrier_city))'');
    populated_carrier_city_pcnt := AVE(GROUP,IF(h.carrier_city = (TYPEOF(h.carrier_city))'',0,100));
    maxlength_carrier_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city)));
    avelength_carrier_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city)),h.carrier_city<>(typeof(h.carrier_city))'');
    populated_carrier_city_code_cnt := COUNT(GROUP,h.carrier_city_code <> (TYPEOF(h.carrier_city_code))'');
    populated_carrier_city_code_pcnt := AVE(GROUP,IF(h.carrier_city_code = (TYPEOF(h.carrier_city_code))'',0,100));
    maxlength_carrier_city_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city_code)));
    avelength_carrier_city_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city_code)),h.carrier_city_code<>(typeof(h.carrier_city_code))'');
    populated_carrier_state_cnt := COUNT(GROUP,h.carrier_state <> (TYPEOF(h.carrier_state))'');
    populated_carrier_state_pcnt := AVE(GROUP,IF(h.carrier_state = (TYPEOF(h.carrier_state))'',0,100));
    maxlength_carrier_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_state)));
    avelength_carrier_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_state)),h.carrier_state<>(typeof(h.carrier_state))'');
    populated_carrier_zip_code_cnt := COUNT(GROUP,h.carrier_zip_code <> (TYPEOF(h.carrier_zip_code))'');
    populated_carrier_zip_code_pcnt := AVE(GROUP,IF(h.carrier_zip_code = (TYPEOF(h.carrier_zip_code))'',0,100));
    maxlength_carrier_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_zip_code)));
    avelength_carrier_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_zip_code)),h.carrier_zip_code<>(typeof(h.carrier_zip_code))'');
    populated_crash_colonia_cnt := COUNT(GROUP,h.crash_colonia <> (TYPEOF(h.crash_colonia))'');
    populated_crash_colonia_pcnt := AVE(GROUP,IF(h.crash_colonia = (TYPEOF(h.crash_colonia))'',0,100));
    maxlength_crash_colonia := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crash_colonia)));
    avelength_crash_colonia := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crash_colonia)),h.crash_colonia<>(typeof(h.crash_colonia))'');
    populated_docket_number_cnt := COUNT(GROUP,h.docket_number <> (TYPEOF(h.docket_number))'');
    populated_docket_number_pcnt := AVE(GROUP,IF(h.docket_number = (TYPEOF(h.docket_number))'',0,100));
    maxlength_docket_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.docket_number)));
    avelength_docket_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.docket_number)),h.docket_number<>(typeof(h.docket_number))'');
    populated_interstate_cnt := COUNT(GROUP,h.interstate <> (TYPEOF(h.interstate))'');
    populated_interstate_pcnt := AVE(GROUP,IF(h.interstate = (TYPEOF(h.interstate))'',0,100));
    maxlength_interstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.interstate)));
    avelength_interstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.interstate)),h.interstate<>(typeof(h.interstate))'');
    populated_no_id_flag_cnt := COUNT(GROUP,h.no_id_flag <> (TYPEOF(h.no_id_flag))'');
    populated_no_id_flag_pcnt := AVE(GROUP,IF(h.no_id_flag = (TYPEOF(h.no_id_flag))'',0,100));
    maxlength_no_id_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_id_flag)));
    avelength_no_id_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_id_flag)),h.no_id_flag<>(typeof(h.no_id_flag))'');
    populated_state_number_cnt := COUNT(GROUP,h.state_number <> (TYPEOF(h.state_number))'');
    populated_state_number_pcnt := AVE(GROUP,IF(h.state_number = (TYPEOF(h.state_number))'',0,100));
    maxlength_state_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_number)));
    avelength_state_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_number)),h.state_number<>(typeof(h.state_number))'');
    populated_state_issuing_number_cnt := COUNT(GROUP,h.state_issuing_number <> (TYPEOF(h.state_issuing_number))'');
    populated_state_issuing_number_pcnt := AVE(GROUP,IF(h.state_issuing_number = (TYPEOF(h.state_issuing_number))'',0,100));
    maxlength_state_issuing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_issuing_number)));
    avelength_state_issuing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_issuing_number)),h.state_issuing_number<>(typeof(h.state_issuing_number))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_carrier_id_pcnt *   0.00 / 100 + T.Populated_crash_id_pcnt *   0.00 / 100 + T.Populated_carrier_source_code_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_carrier_street_pcnt *   0.00 / 100 + T.Populated_carrier_city_pcnt *   0.00 / 100 + T.Populated_carrier_city_code_pcnt *   0.00 / 100 + T.Populated_carrier_state_pcnt *   0.00 / 100 + T.Populated_carrier_zip_code_pcnt *   0.00 / 100 + T.Populated_crash_colonia_pcnt *   0.00 / 100 + T.Populated_docket_number_pcnt *   0.00 / 100 + T.Populated_interstate_pcnt *   0.00 / 100 + T.Populated_no_id_flag_pcnt *   0.00 / 100 + T.Populated_state_number_pcnt *   0.00 / 100 + T.Populated_state_issuing_number_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'carrier_id','crash_id','carrier_source_code','carrier_name','carrier_street','carrier_city','carrier_city_code','carrier_state','carrier_zip_code','crash_colonia','docket_number','interstate','no_id_flag','state_number','state_issuing_number');
  SELF.populated_pcnt := CHOOSE(C,le.populated_carrier_id_pcnt,le.populated_crash_id_pcnt,le.populated_carrier_source_code_pcnt,le.populated_carrier_name_pcnt,le.populated_carrier_street_pcnt,le.populated_carrier_city_pcnt,le.populated_carrier_city_code_pcnt,le.populated_carrier_state_pcnt,le.populated_carrier_zip_code_pcnt,le.populated_crash_colonia_pcnt,le.populated_docket_number_pcnt,le.populated_interstate_pcnt,le.populated_no_id_flag_pcnt,le.populated_state_number_pcnt,le.populated_state_issuing_number_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_carrier_id,le.maxlength_crash_id,le.maxlength_carrier_source_code,le.maxlength_carrier_name,le.maxlength_carrier_street,le.maxlength_carrier_city,le.maxlength_carrier_city_code,le.maxlength_carrier_state,le.maxlength_carrier_zip_code,le.maxlength_crash_colonia,le.maxlength_docket_number,le.maxlength_interstate,le.maxlength_no_id_flag,le.maxlength_state_number,le.maxlength_state_issuing_number);
  SELF.avelength := CHOOSE(C,le.avelength_carrier_id,le.avelength_crash_id,le.avelength_carrier_source_code,le.avelength_carrier_name,le.avelength_carrier_street,le.avelength_carrier_city,le.avelength_carrier_city_code,le.avelength_carrier_state,le.avelength_carrier_zip_code,le.avelength_crash_colonia,le.avelength_docket_number,le.avelength_interstate,le.avelength_no_id_flag,le.avelength_state_number,le.avelength_state_issuing_number);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.carrier_id),TRIM((SALT311.StrType)le.crash_id),TRIM((SALT311.StrType)le.carrier_source_code),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_street),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_city_code),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip_code),TRIM((SALT311.StrType)le.crash_colonia),TRIM((SALT311.StrType)le.docket_number),TRIM((SALT311.StrType)le.interstate),TRIM((SALT311.StrType)le.no_id_flag),TRIM((SALT311.StrType)le.state_number),TRIM((SALT311.StrType)le.state_issuing_number)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.carrier_id),TRIM((SALT311.StrType)le.crash_id),TRIM((SALT311.StrType)le.carrier_source_code),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_street),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_city_code),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip_code),TRIM((SALT311.StrType)le.crash_colonia),TRIM((SALT311.StrType)le.docket_number),TRIM((SALT311.StrType)le.interstate),TRIM((SALT311.StrType)le.no_id_flag),TRIM((SALT311.StrType)le.state_number),TRIM((SALT311.StrType)le.state_issuing_number)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.carrier_id),TRIM((SALT311.StrType)le.crash_id),TRIM((SALT311.StrType)le.carrier_source_code),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_street),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_city_code),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip_code),TRIM((SALT311.StrType)le.crash_colonia),TRIM((SALT311.StrType)le.docket_number),TRIM((SALT311.StrType)le.interstate),TRIM((SALT311.StrType)le.no_id_flag),TRIM((SALT311.StrType)le.state_number),TRIM((SALT311.StrType)le.state_issuing_number)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'carrier_id'}
      ,{2,'crash_id'}
      ,{3,'carrier_source_code'}
      ,{4,'carrier_name'}
      ,{5,'carrier_street'}
      ,{6,'carrier_city'}
      ,{7,'carrier_city_code'}
      ,{8,'carrier_state'}
      ,{9,'carrier_zip_code'}
      ,{10,'crash_colonia'}
      ,{11,'docket_number'}
      ,{12,'interstate'}
      ,{13,'no_id_flag'}
      ,{14,'state_number'}
      ,{15,'state_issuing_number'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_carrier_id((SALT311.StrType)le.carrier_id),
    Fields.InValid_crash_id((SALT311.StrType)le.crash_id),
    Fields.InValid_carrier_source_code((SALT311.StrType)le.carrier_source_code),
    Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name),
    Fields.InValid_carrier_street((SALT311.StrType)le.carrier_street),
    Fields.InValid_carrier_city((SALT311.StrType)le.carrier_city),
    Fields.InValid_carrier_city_code((SALT311.StrType)le.carrier_city_code),
    Fields.InValid_carrier_state((SALT311.StrType)le.carrier_state),
    Fields.InValid_carrier_zip_code((SALT311.StrType)le.carrier_zip_code),
    Fields.InValid_crash_colonia((SALT311.StrType)le.crash_colonia),
    Fields.InValid_docket_number((SALT311.StrType)le.docket_number),
    Fields.InValid_interstate((SALT311.StrType)le.interstate),
    Fields.InValid_no_id_flag((SALT311.StrType)le.no_id_flag),
    Fields.InValid_state_number((SALT311.StrType)le.state_number),
    Fields.InValid_state_issuing_number((SALT311.StrType)le.state_issuing_number),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_id','Invalid_id','Unknown','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Unknown','Invalid_alpha','Invalid_alpha','Unknown','Invalid_Numeric_Optional','Invalid_interstate','Invalid_no_id_flag','Invalid_alpha','Invalid_alpha');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_carrier_id(TotalErrors.ErrorNum),Fields.InValidMessage_crash_id(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_street(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_city(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_city_code(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_state(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_crash_colonia(TotalErrors.ErrorNum),Fields.InValidMessage_docket_number(TotalErrors.ErrorNum),Fields.InValidMessage_interstate(TotalErrors.ErrorNum),Fields.InValidMessage_no_id_flag(TotalErrors.ErrorNum),Fields.InValidMessage_state_number(TotalErrors.ErrorNum),Fields.InValidMessage_state_issuing_number(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_CrashCarrier, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

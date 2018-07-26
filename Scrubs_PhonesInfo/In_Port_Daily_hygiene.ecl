IMPORT SALT39,STD;
EXPORT In_Port_Daily_hygiene(dataset(In_Port_Daily_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_action_code_cnt := COUNT(GROUP,h.action_code <> (TYPEOF(h.action_code))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_country_code_cnt := COUNT(GROUP,h.country_code <> (TYPEOF(h.country_code))'');
    populated_country_code_pcnt := AVE(GROUP,IF(h.country_code = (TYPEOF(h.country_code))'',0,100));
    maxlength_country_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.country_code)));
    avelength_country_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.country_code)),h.country_code<>(typeof(h.country_code))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_dial_type_cnt := COUNT(GROUP,h.dial_type <> (TYPEOF(h.dial_type))'');
    populated_dial_type_pcnt := AVE(GROUP,IF(h.dial_type = (TYPEOF(h.dial_type))'',0,100));
    maxlength_dial_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dial_type)));
    avelength_dial_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dial_type)),h.dial_type<>(typeof(h.dial_type))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_service_type_cnt := COUNT(GROUP,h.service_type <> (TYPEOF(h.service_type))'');
    populated_service_type_pcnt := AVE(GROUP,IF(h.service_type = (TYPEOF(h.service_type))'',0,100));
    maxlength_service_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.service_type)));
    avelength_service_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.service_type)),h.service_type<>(typeof(h.service_type))'');
    populated_routing_code_cnt := COUNT(GROUP,h.routing_code <> (TYPEOF(h.routing_code))'');
    populated_routing_code_pcnt := AVE(GROUP,IF(h.routing_code = (TYPEOF(h.routing_code))'',0,100));
    maxlength_routing_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.routing_code)));
    avelength_routing_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.routing_code)),h.routing_code<>(typeof(h.routing_code))'');
    populated_porting_dt_cnt := COUNT(GROUP,h.porting_dt <> (TYPEOF(h.porting_dt))'');
    populated_porting_dt_pcnt := AVE(GROUP,IF(h.porting_dt = (TYPEOF(h.porting_dt))'',0,100));
    maxlength_porting_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.porting_dt)));
    avelength_porting_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.porting_dt)),h.porting_dt<>(typeof(h.porting_dt))'');
    populated_country_abbr_cnt := COUNT(GROUP,h.country_abbr <> (TYPEOF(h.country_abbr))'');
    populated_country_abbr_pcnt := AVE(GROUP,IF(h.country_abbr = (TYPEOF(h.country_abbr))'',0,100));
    maxlength_country_abbr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.country_abbr)));
    avelength_country_abbr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.country_abbr)),h.country_abbr<>(typeof(h.country_abbr))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_country_code_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_dial_type_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_service_type_pcnt *   0.00 / 100 + T.Populated_routing_code_pcnt *   0.00 / 100 + T.Populated_porting_dt_pcnt *   0.00 / 100 + T.Populated_country_abbr_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_action_code_pcnt,le.populated_country_code_pcnt,le.populated_phone_pcnt,le.populated_dial_type_pcnt,le.populated_spid_pcnt,le.populated_service_type_pcnt,le.populated_routing_code_pcnt,le.populated_porting_dt_pcnt,le.populated_country_abbr_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_action_code,le.maxlength_country_code,le.maxlength_phone,le.maxlength_dial_type,le.maxlength_spid,le.maxlength_service_type,le.maxlength_routing_code,le.maxlength_porting_dt,le.maxlength_country_abbr,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_action_code,le.avelength_country_code,le.avelength_phone,le.avelength_dial_type,le.avelength_spid,le.avelength_service_type,le.avelength_routing_code,le.avelength_porting_dt,le.avelength_country_abbr,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.action_code),TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.action_code),TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.action_code),TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'action_code'}
      ,{2,'country_code'}
      ,{3,'phone'}
      ,{4,'dial_type'}
      ,{5,'spid'}
      ,{6,'service_type'}
      ,{7,'routing_code'}
      ,{8,'porting_dt'}
      ,{9,'country_abbr'}
      ,{10,'filename'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    In_Port_Daily_Fields.InValid_action_code((SALT39.StrType)le.action_code),
    In_Port_Daily_Fields.InValid_country_code((SALT39.StrType)le.country_code),
    In_Port_Daily_Fields.InValid_phone((SALT39.StrType)le.phone),
    In_Port_Daily_Fields.InValid_dial_type((SALT39.StrType)le.dial_type),
    In_Port_Daily_Fields.InValid_spid((SALT39.StrType)le.spid),
    In_Port_Daily_Fields.InValid_service_type((SALT39.StrType)le.service_type),
    In_Port_Daily_Fields.InValid_routing_code((SALT39.StrType)le.routing_code),
    In_Port_Daily_Fields.InValid_porting_dt((SALT39.StrType)le.porting_dt),
    In_Port_Daily_Fields.InValid_country_abbr((SALT39.StrType)le.country_abbr),
    In_Port_Daily_Fields.InValid_filename((SALT39.StrType)le.filename),
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
  FieldNme := In_Port_Daily_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_DCT','Invalid_Num','Invalid_TOS','Invalid_Num_Blank','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,In_Port_Daily_Fields.InValidMessage_action_code(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_country_code(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_phone(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_dial_type(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_spid(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_service_type(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_routing_code(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_porting_dt(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_country_abbr(TotalErrors.ErrorNum),In_Port_Daily_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, In_Port_Daily_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

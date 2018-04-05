IMPORT SALT39,STD;
EXPORT iConectivMain_hygiene(dataset(iConectivMain_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_service_provider_cnt := COUNT(GROUP,h.service_provider <> (TYPEOF(h.service_provider))'');
    populated_service_provider_pcnt := AVE(GROUP,IF(h.service_provider = (TYPEOF(h.service_provider))'',0,100));
    maxlength_service_provider := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.service_provider)));
    avelength_service_provider := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.service_provider)),h.service_provider<>(typeof(h.service_provider))'');
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
    populated_file_dt_time_cnt := COUNT(GROUP,h.file_dt_time <> (TYPEOF(h.file_dt_time))'');
    populated_file_dt_time_pcnt := AVE(GROUP,IF(h.file_dt_time = (TYPEOF(h.file_dt_time))'',0,100));
    maxlength_file_dt_time := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_dt_time)));
    avelength_file_dt_time := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.file_dt_time)),h.file_dt_time<>(typeof(h.file_dt_time))'');
    populated_vendor_first_reported_dt_cnt := COUNT(GROUP,h.vendor_first_reported_dt <> (TYPEOF(h.vendor_first_reported_dt))'');
    populated_vendor_first_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_first_reported_dt = (TYPEOF(h.vendor_first_reported_dt))'',0,100));
    maxlength_vendor_first_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_first_reported_dt)));
    avelength_vendor_first_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_first_reported_dt)),h.vendor_first_reported_dt<>(typeof(h.vendor_first_reported_dt))'');
    populated_vendor_last_reported_dt_cnt := COUNT(GROUP,h.vendor_last_reported_dt <> (TYPEOF(h.vendor_last_reported_dt))'');
    populated_vendor_last_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_last_reported_dt = (TYPEOF(h.vendor_last_reported_dt))'',0,100));
    maxlength_vendor_last_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_last_reported_dt)));
    avelength_vendor_last_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.vendor_last_reported_dt)),h.vendor_last_reported_dt<>(typeof(h.vendor_last_reported_dt))'');
    populated_port_start_dt_cnt := COUNT(GROUP,h.port_start_dt <> (TYPEOF(h.port_start_dt))'');
    populated_port_start_dt_pcnt := AVE(GROUP,IF(h.port_start_dt = (TYPEOF(h.port_start_dt))'',0,100));
    maxlength_port_start_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.port_start_dt)));
    avelength_port_start_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.port_start_dt)),h.port_start_dt<>(typeof(h.port_start_dt))'');
    populated_port_end_dt_cnt := COUNT(GROUP,h.port_end_dt <> (TYPEOF(h.port_end_dt))'');
    populated_port_end_dt_pcnt := AVE(GROUP,IF(h.port_end_dt = (TYPEOF(h.port_end_dt))'',0,100));
    maxlength_port_end_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.port_end_dt)));
    avelength_port_end_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.port_end_dt)),h.port_end_dt<>(typeof(h.port_end_dt))'');
    populated_remove_port_dt_cnt := COUNT(GROUP,h.remove_port_dt <> (TYPEOF(h.remove_port_dt))'');
    populated_remove_port_dt_pcnt := AVE(GROUP,IF(h.remove_port_dt = (TYPEOF(h.remove_port_dt))'',0,100));
    maxlength_remove_port_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.remove_port_dt)));
    avelength_remove_port_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.remove_port_dt)),h.remove_port_dt<>(typeof(h.remove_port_dt))'');
    populated_is_ported_cnt := COUNT(GROUP,h.is_ported <> (TYPEOF(h.is_ported))'');
    populated_is_ported_pcnt := AVE(GROUP,IF(h.is_ported = (TYPEOF(h.is_ported))'',0,100));
    maxlength_is_ported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.is_ported)));
    avelength_is_ported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.is_ported)),h.is_ported<>(typeof(h.is_ported))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_country_code_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_dial_type_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_service_provider_pcnt *   0.00 / 100 + T.Populated_service_type_pcnt *   0.00 / 100 + T.Populated_routing_code_pcnt *   0.00 / 100 + T.Populated_porting_dt_pcnt *   0.00 / 100 + T.Populated_country_abbr_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100 + T.Populated_file_dt_time_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_dt_pcnt *   0.00 / 100 + T.Populated_port_start_dt_pcnt *   0.00 / 100 + T.Populated_port_end_dt_pcnt *   0.00 / 100 + T.Populated_remove_port_dt_pcnt *   0.00 / 100 + T.Populated_is_ported_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'country_code','phone','dial_type','spid','service_provider','service_type','routing_code','porting_dt','country_abbr','filename','file_dt_time','vendor_first_reported_dt','vendor_last_reported_dt','port_start_dt','port_end_dt','remove_port_dt','is_ported');
  SELF.populated_pcnt := CHOOSE(C,le.populated_country_code_pcnt,le.populated_phone_pcnt,le.populated_dial_type_pcnt,le.populated_spid_pcnt,le.populated_service_provider_pcnt,le.populated_service_type_pcnt,le.populated_routing_code_pcnt,le.populated_porting_dt_pcnt,le.populated_country_abbr_pcnt,le.populated_filename_pcnt,le.populated_file_dt_time_pcnt,le.populated_vendor_first_reported_dt_pcnt,le.populated_vendor_last_reported_dt_pcnt,le.populated_port_start_dt_pcnt,le.populated_port_end_dt_pcnt,le.populated_remove_port_dt_pcnt,le.populated_is_ported_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_country_code,le.maxlength_phone,le.maxlength_dial_type,le.maxlength_spid,le.maxlength_service_provider,le.maxlength_service_type,le.maxlength_routing_code,le.maxlength_porting_dt,le.maxlength_country_abbr,le.maxlength_filename,le.maxlength_file_dt_time,le.maxlength_vendor_first_reported_dt,le.maxlength_vendor_last_reported_dt,le.maxlength_port_start_dt,le.maxlength_port_end_dt,le.maxlength_remove_port_dt,le.maxlength_is_ported);
  SELF.avelength := CHOOSE(C,le.avelength_country_code,le.avelength_phone,le.avelength_dial_type,le.avelength_spid,le.avelength_service_provider,le.avelength_service_type,le.avelength_routing_code,le.avelength_porting_dt,le.avelength_country_abbr,le.avelength_filename,le.avelength_file_dt_time,le.avelength_vendor_first_reported_dt,le.avelength_vendor_last_reported_dt,le.avelength_port_start_dt,le.avelength_port_end_dt,le.avelength_remove_port_dt,le.avelength_is_ported);
END;
EXPORT invSummary := NORMALIZE(summary0, 17, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_provider),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename),TRIM((SALT39.StrType)le.file_dt_time),TRIM((SALT39.StrType)le.vendor_first_reported_dt),TRIM((SALT39.StrType)le.vendor_last_reported_dt),TRIM((SALT39.StrType)le.port_start_dt),TRIM((SALT39.StrType)le.port_end_dt),TRIM((SALT39.StrType)le.remove_port_dt),TRIM((SALT39.StrType)le.is_ported)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,17,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 17);
  SELF.FldNo2 := 1 + (C % 17);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_provider),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename),TRIM((SALT39.StrType)le.file_dt_time),TRIM((SALT39.StrType)le.vendor_first_reported_dt),TRIM((SALT39.StrType)le.vendor_last_reported_dt),TRIM((SALT39.StrType)le.port_start_dt),TRIM((SALT39.StrType)le.port_end_dt),TRIM((SALT39.StrType)le.remove_port_dt),TRIM((SALT39.StrType)le.is_ported)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.country_code),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.dial_type),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.service_provider),TRIM((SALT39.StrType)le.service_type),TRIM((SALT39.StrType)le.routing_code),TRIM((SALT39.StrType)le.porting_dt),TRIM((SALT39.StrType)le.country_abbr),TRIM((SALT39.StrType)le.filename),TRIM((SALT39.StrType)le.file_dt_time),TRIM((SALT39.StrType)le.vendor_first_reported_dt),TRIM((SALT39.StrType)le.vendor_last_reported_dt),TRIM((SALT39.StrType)le.port_start_dt),TRIM((SALT39.StrType)le.port_end_dt),TRIM((SALT39.StrType)le.remove_port_dt),TRIM((SALT39.StrType)le.is_ported)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),17*17,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'country_code'}
      ,{2,'phone'}
      ,{3,'dial_type'}
      ,{4,'spid'}
      ,{5,'service_provider'}
      ,{6,'service_type'}
      ,{7,'routing_code'}
      ,{8,'porting_dt'}
      ,{9,'country_abbr'}
      ,{10,'filename'}
      ,{11,'file_dt_time'}
      ,{12,'vendor_first_reported_dt'}
      ,{13,'vendor_last_reported_dt'}
      ,{14,'port_start_dt'}
      ,{15,'port_end_dt'}
      ,{16,'remove_port_dt'}
      ,{17,'is_ported'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    iConectivMain_Fields.InValid_country_code((SALT39.StrType)le.country_code),
    iConectivMain_Fields.InValid_phone((SALT39.StrType)le.phone),
    iConectivMain_Fields.InValid_dial_type((SALT39.StrType)le.dial_type),
    iConectivMain_Fields.InValid_spid((SALT39.StrType)le.spid),
    iConectivMain_Fields.InValid_service_provider((SALT39.StrType)le.service_provider),
    iConectivMain_Fields.InValid_service_type((SALT39.StrType)le.service_type),
    iConectivMain_Fields.InValid_routing_code((SALT39.StrType)le.routing_code),
    iConectivMain_Fields.InValid_porting_dt((SALT39.StrType)le.porting_dt),
    iConectivMain_Fields.InValid_country_abbr((SALT39.StrType)le.country_abbr),
    iConectivMain_Fields.InValid_filename((SALT39.StrType)le.filename),
    iConectivMain_Fields.InValid_file_dt_time((SALT39.StrType)le.file_dt_time),
    iConectivMain_Fields.InValid_vendor_first_reported_dt((SALT39.StrType)le.vendor_first_reported_dt),
    iConectivMain_Fields.InValid_vendor_last_reported_dt((SALT39.StrType)le.vendor_last_reported_dt),
    iConectivMain_Fields.InValid_port_start_dt((SALT39.StrType)le.port_start_dt),
    iConectivMain_Fields.InValid_port_end_dt((SALT39.StrType)le.port_end_dt),
    iConectivMain_Fields.InValid_remove_port_dt((SALT39.StrType)le.remove_port_dt),
    iConectivMain_Fields.InValid_is_ported((SALT39.StrType)le.is_ported),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,17,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := iConectivMain_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Num','Invalid_DCT','Invalid_Num','Unknown','Invalid_TOS','Invalid_Num_Blank','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,iConectivMain_Fields.InValidMessage_country_code(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_phone(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_dial_type(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_spid(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_service_provider(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_service_type(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_routing_code(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_porting_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_country_abbr(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_filename(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_file_dt_time(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_vendor_first_reported_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_vendor_last_reported_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_port_start_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_port_end_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_remove_port_dt(TotalErrors.ErrorNum),iConectivMain_Fields.InValidMessage_is_ported(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, iConectivMain_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

IMPORT SALT39,STD;
EXPORT LIDBProcessed_hygiene(dataset(LIDBProcessed_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_reference_id_cnt := COUNT(GROUP,h.reference_id <> (TYPEOF(h.reference_id))'');
    populated_reference_id_pcnt := AVE(GROUP,IF(h.reference_id = (TYPEOF(h.reference_id))'',0,100));
    maxlength_reference_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.reference_id)));
    avelength_reference_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.reference_id)),h.reference_id<>(typeof(h.reference_id))'');
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_reply_code_cnt := COUNT(GROUP,h.reply_code <> (TYPEOF(h.reply_code))'');
    populated_reply_code_pcnt := AVE(GROUP,IF(h.reply_code = (TYPEOF(h.reply_code))'',0,100));
    maxlength_reply_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.reply_code)));
    avelength_reply_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.reply_code)),h.reply_code<>(typeof(h.reply_code))'');
    populated_local_routing_number_cnt := COUNT(GROUP,h.local_routing_number <> (TYPEOF(h.local_routing_number))'');
    populated_local_routing_number_pcnt := AVE(GROUP,IF(h.local_routing_number = (TYPEOF(h.local_routing_number))'',0,100));
    maxlength_local_routing_number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_routing_number)));
    avelength_local_routing_number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_routing_number)),h.local_routing_number<>(typeof(h.local_routing_number))'');
    populated_account_owner_cnt := COUNT(GROUP,h.account_owner <> (TYPEOF(h.account_owner))'');
    populated_account_owner_pcnt := AVE(GROUP,IF(h.account_owner = (TYPEOF(h.account_owner))'',0,100));
    maxlength_account_owner := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.account_owner)));
    avelength_account_owner := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.account_owner)),h.account_owner<>(typeof(h.account_owner))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_carrier_category_cnt := COUNT(GROUP,h.carrier_category <> (TYPEOF(h.carrier_category))'');
    populated_carrier_category_pcnt := AVE(GROUP,IF(h.carrier_category = (TYPEOF(h.carrier_category))'',0,100));
    maxlength_carrier_category := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_category)));
    avelength_carrier_category := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.carrier_category)),h.carrier_category<>(typeof(h.carrier_category))'');
    populated_local_area_transport_area_cnt := COUNT(GROUP,h.local_area_transport_area <> (TYPEOF(h.local_area_transport_area))'');
    populated_local_area_transport_area_pcnt := AVE(GROUP,IF(h.local_area_transport_area = (TYPEOF(h.local_area_transport_area))'',0,100));
    maxlength_local_area_transport_area := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_area_transport_area)));
    avelength_local_area_transport_area := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.local_area_transport_area)),h.local_area_transport_area<>(typeof(h.local_area_transport_area))'');
    populated_point_code_cnt := COUNT(GROUP,h.point_code <> (TYPEOF(h.point_code))'');
    populated_point_code_pcnt := AVE(GROUP,IF(h.point_code = (TYPEOF(h.point_code))'',0,100));
    maxlength_point_code := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.point_code)));
    avelength_point_code := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.point_code)),h.point_code<>(typeof(h.point_code))'');
    populated_serv_cnt := COUNT(GROUP,h.serv <> (TYPEOF(h.serv))'');
    populated_serv_pcnt := AVE(GROUP,IF(h.serv = (TYPEOF(h.serv))'',0,100));
    maxlength_serv := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.serv)));
    avelength_serv := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.serv)),h.serv<>(typeof(h.serv))'');
    populated_line_cnt := COUNT(GROUP,h.line <> (TYPEOF(h.line))'');
    populated_line_pcnt := AVE(GROUP,IF(h.line = (TYPEOF(h.line))'',0,100));
    maxlength_line := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.line)));
    avelength_line := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.line)),h.line<>(typeof(h.line))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_operator_fullname_cnt := COUNT(GROUP,h.operator_fullname <> (TYPEOF(h.operator_fullname))'');
    populated_operator_fullname_pcnt := AVE(GROUP,IF(h.operator_fullname = (TYPEOF(h.operator_fullname))'',0,100));
    maxlength_operator_fullname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.operator_fullname)));
    avelength_operator_fullname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.operator_fullname)),h.operator_fullname<>(typeof(h.operator_fullname))'');
    populated_activation_dt_cnt := COUNT(GROUP,h.activation_dt <> (TYPEOF(h.activation_dt))'');
    populated_activation_dt_pcnt := AVE(GROUP,IF(h.activation_dt = (TYPEOF(h.activation_dt))'',0,100));
    maxlength_activation_dt := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.activation_dt)));
    avelength_activation_dt := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.activation_dt)),h.activation_dt<>(typeof(h.activation_dt))'');
    populated_number_in_service_cnt := COUNT(GROUP,h.number_in_service <> (TYPEOF(h.number_in_service))'');
    populated_number_in_service_pcnt := AVE(GROUP,IF(h.number_in_service = (TYPEOF(h.number_in_service))'',0,100));
    maxlength_number_in_service := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.number_in_service)));
    avelength_number_in_service := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.number_in_service)),h.number_in_service<>(typeof(h.number_in_service))'');
    populated_high_risk_indicator_cnt := COUNT(GROUP,h.high_risk_indicator <> (TYPEOF(h.high_risk_indicator))'');
    populated_high_risk_indicator_pcnt := AVE(GROUP,IF(h.high_risk_indicator = (TYPEOF(h.high_risk_indicator))'',0,100));
    maxlength_high_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.high_risk_indicator)));
    avelength_high_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.high_risk_indicator)),h.high_risk_indicator<>(typeof(h.high_risk_indicator))'');
    populated_prepaid_cnt := COUNT(GROUP,h.prepaid <> (TYPEOF(h.prepaid))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_reply_code_pcnt *   0.00 / 100 + T.Populated_local_routing_number_pcnt *   0.00 / 100 + T.Populated_account_owner_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_carrier_category_pcnt *   0.00 / 100 + T.Populated_local_area_transport_area_pcnt *   0.00 / 100 + T.Populated_point_code_pcnt *   0.00 / 100 + T.Populated_serv_pcnt *   0.00 / 100 + T.Populated_line_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_operator_fullname_pcnt *   0.00 / 100 + T.Populated_activation_dt_pcnt *   0.00 / 100 + T.Populated_number_in_service_pcnt *   0.00 / 100 + T.Populated_high_risk_indicator_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'reference_id','dt_first_reported','dt_last_reported','phone','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','activation_dt','number_in_service','high_risk_indicator','prepaid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_reference_id_pcnt,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_phone_pcnt,le.populated_reply_code_pcnt,le.populated_local_routing_number_pcnt,le.populated_account_owner_pcnt,le.populated_carrier_name_pcnt,le.populated_carrier_category_pcnt,le.populated_local_area_transport_area_pcnt,le.populated_point_code_pcnt,le.populated_serv_pcnt,le.populated_line_pcnt,le.populated_spid_pcnt,le.populated_operator_fullname_pcnt,le.populated_activation_dt_pcnt,le.populated_number_in_service_pcnt,le.populated_high_risk_indicator_pcnt,le.populated_prepaid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_reference_id,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_phone,le.maxlength_reply_code,le.maxlength_local_routing_number,le.maxlength_account_owner,le.maxlength_carrier_name,le.maxlength_carrier_category,le.maxlength_local_area_transport_area,le.maxlength_point_code,le.maxlength_serv,le.maxlength_line,le.maxlength_spid,le.maxlength_operator_fullname,le.maxlength_activation_dt,le.maxlength_number_in_service,le.maxlength_high_risk_indicator,le.maxlength_prepaid);
  SELF.avelength := CHOOSE(C,le.avelength_reference_id,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_phone,le.avelength_reply_code,le.avelength_local_routing_number,le.avelength_account_owner,le.avelength_carrier_name,le.avelength_carrier_category,le.avelength_local_area_transport_area,le.avelength_point_code,le.avelength_serv,le.avelength_line,le.avelength_spid,le.avelength_operator_fullname,le.avelength_activation_dt,le.avelength_number_in_service,le.avelength_high_risk_indicator,le.avelength_prepaid);
END;
EXPORT invSummary := NORMALIZE(summary0, 19, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.reference_id),IF (le.dt_first_reported <> 0,TRIM((SALT39.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT39.StrType)le.dt_last_reported), ''),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code),TRIM((SALT39.StrType)le.serv),TRIM((SALT39.StrType)le.line),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.operator_fullname),IF (le.activation_dt <> 0,TRIM((SALT39.StrType)le.activation_dt), ''),TRIM((SALT39.StrType)le.number_in_service),TRIM((SALT39.StrType)le.high_risk_indicator),TRIM((SALT39.StrType)le.prepaid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,19,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 19);
  SELF.FldNo2 := 1 + (C % 19);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.reference_id),IF (le.dt_first_reported <> 0,TRIM((SALT39.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT39.StrType)le.dt_last_reported), ''),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code),TRIM((SALT39.StrType)le.serv),TRIM((SALT39.StrType)le.line),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.operator_fullname),IF (le.activation_dt <> 0,TRIM((SALT39.StrType)le.activation_dt), ''),TRIM((SALT39.StrType)le.number_in_service),TRIM((SALT39.StrType)le.high_risk_indicator),TRIM((SALT39.StrType)le.prepaid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.reference_id),IF (le.dt_first_reported <> 0,TRIM((SALT39.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT39.StrType)le.dt_last_reported), ''),TRIM((SALT39.StrType)le.phone),TRIM((SALT39.StrType)le.reply_code),TRIM((SALT39.StrType)le.local_routing_number),TRIM((SALT39.StrType)le.account_owner),TRIM((SALT39.StrType)le.carrier_name),TRIM((SALT39.StrType)le.carrier_category),TRIM((SALT39.StrType)le.local_area_transport_area),TRIM((SALT39.StrType)le.point_code),TRIM((SALT39.StrType)le.serv),TRIM((SALT39.StrType)le.line),TRIM((SALT39.StrType)le.spid),TRIM((SALT39.StrType)le.operator_fullname),IF (le.activation_dt <> 0,TRIM((SALT39.StrType)le.activation_dt), ''),TRIM((SALT39.StrType)le.number_in_service),TRIM((SALT39.StrType)le.high_risk_indicator),TRIM((SALT39.StrType)le.prepaid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),19*19,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'reference_id'}
      ,{2,'dt_first_reported'}
      ,{3,'dt_last_reported'}
      ,{4,'phone'}
      ,{5,'reply_code'}
      ,{6,'local_routing_number'}
      ,{7,'account_owner'}
      ,{8,'carrier_name'}
      ,{9,'carrier_category'}
      ,{10,'local_area_transport_area'}
      ,{11,'point_code'}
      ,{12,'serv'}
      ,{13,'line'}
      ,{14,'spid'}
      ,{15,'operator_fullname'}
      ,{16,'activation_dt'}
      ,{17,'number_in_service'}
      ,{18,'high_risk_indicator'}
      ,{19,'prepaid'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    LIDBProcessed_Fields.InValid_reference_id((SALT39.StrType)le.reference_id),
    LIDBProcessed_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported),
    LIDBProcessed_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported),
    LIDBProcessed_Fields.InValid_phone((SALT39.StrType)le.phone),
    LIDBProcessed_Fields.InValid_reply_code((SALT39.StrType)le.reply_code),
    LIDBProcessed_Fields.InValid_local_routing_number((SALT39.StrType)le.local_routing_number),
    LIDBProcessed_Fields.InValid_account_owner((SALT39.StrType)le.account_owner),
    LIDBProcessed_Fields.InValid_carrier_name((SALT39.StrType)le.carrier_name),
    LIDBProcessed_Fields.InValid_carrier_category((SALT39.StrType)le.carrier_category),
    LIDBProcessed_Fields.InValid_local_area_transport_area((SALT39.StrType)le.local_area_transport_area),
    LIDBProcessed_Fields.InValid_point_code((SALT39.StrType)le.point_code),
    LIDBProcessed_Fields.InValid_serv((SALT39.StrType)le.serv),
    LIDBProcessed_Fields.InValid_line((SALT39.StrType)le.line),
    LIDBProcessed_Fields.InValid_spid((SALT39.StrType)le.spid),
    LIDBProcessed_Fields.InValid_operator_fullname((SALT39.StrType)le.operator_fullname),
    LIDBProcessed_Fields.InValid_activation_dt((SALT39.StrType)le.activation_dt),
    LIDBProcessed_Fields.InValid_number_in_service((SALT39.StrType)le.number_in_service),
    LIDBProcessed_Fields.InValid_high_risk_indicator((SALT39.StrType)le.high_risk_indicator),
    LIDBProcessed_Fields.InValid_prepaid((SALT39.StrType)le.prepaid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,19,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := LIDBProcessed_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_RefID','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AccOwn','Invalid_Char','Invalid_Char','Unknown','Unknown','Invalid_Line_Serv','Invalid_Line_Serv','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num_In_Service','Invalid_Binary','Invalid_Binary');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,LIDBProcessed_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_phone(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_reply_code(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_local_routing_number(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_account_owner(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_carrier_category(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_local_area_transport_area(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_point_code(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_serv(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_line(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_spid(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_operator_fullname(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_activation_dt(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_number_in_service(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_high_risk_indicator(TotalErrors.ErrorNum),LIDBProcessed_Fields.InValidMessage_prepaid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, LIDBProcessed_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

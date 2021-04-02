IMPORT SALT311,STD;
EXPORT PhonesTypeMain_hygiene(dataset(PhonesTypeMain_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_vendor_first_reported_dt_cnt := COUNT(GROUP,h.vendor_first_reported_dt <> (TYPEOF(h.vendor_first_reported_dt))'');
    populated_vendor_first_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_first_reported_dt = (TYPEOF(h.vendor_first_reported_dt))'',0,100));
    maxlength_vendor_first_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported_dt)));
    avelength_vendor_first_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported_dt)),h.vendor_first_reported_dt<>(typeof(h.vendor_first_reported_dt))'');
    populated_vendor_first_reported_time_cnt := COUNT(GROUP,h.vendor_first_reported_time <> (TYPEOF(h.vendor_first_reported_time))'');
    populated_vendor_first_reported_time_pcnt := AVE(GROUP,IF(h.vendor_first_reported_time = (TYPEOF(h.vendor_first_reported_time))'',0,100));
    maxlength_vendor_first_reported_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported_time)));
    avelength_vendor_first_reported_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_first_reported_time)),h.vendor_first_reported_time<>(typeof(h.vendor_first_reported_time))'');
    populated_vendor_last_reported_dt_cnt := COUNT(GROUP,h.vendor_last_reported_dt <> (TYPEOF(h.vendor_last_reported_dt))'');
    populated_vendor_last_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_last_reported_dt = (TYPEOF(h.vendor_last_reported_dt))'',0,100));
    maxlength_vendor_last_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported_dt)));
    avelength_vendor_last_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported_dt)),h.vendor_last_reported_dt<>(typeof(h.vendor_last_reported_dt))'');
    populated_vendor_last_reported_time_cnt := COUNT(GROUP,h.vendor_last_reported_time <> (TYPEOF(h.vendor_last_reported_time))'');
    populated_vendor_last_reported_time_pcnt := AVE(GROUP,IF(h.vendor_last_reported_time = (TYPEOF(h.vendor_last_reported_time))'',0,100));
    maxlength_vendor_last_reported_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported_time)));
    avelength_vendor_last_reported_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_last_reported_time)),h.vendor_last_reported_time<>(typeof(h.vendor_last_reported_time))'');
    populated_reference_id_cnt := COUNT(GROUP,h.reference_id <> (TYPEOF(h.reference_id))'');
    populated_reference_id_pcnt := AVE(GROUP,IF(h.reference_id = (TYPEOF(h.reference_id))'',0,100));
    maxlength_reference_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference_id)));
    avelength_reference_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference_id)),h.reference_id<>(typeof(h.reference_id))'');
    populated_reply_code_cnt := COUNT(GROUP,h.reply_code <> (TYPEOF(h.reply_code))'');
    populated_reply_code_pcnt := AVE(GROUP,IF(h.reply_code = (TYPEOF(h.reply_code))'',0,100));
    maxlength_reply_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reply_code)));
    avelength_reply_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reply_code)),h.reply_code<>(typeof(h.reply_code))'');
    populated_local_routing_number_cnt := COUNT(GROUP,h.local_routing_number <> (TYPEOF(h.local_routing_number))'');
    populated_local_routing_number_pcnt := AVE(GROUP,IF(h.local_routing_number = (TYPEOF(h.local_routing_number))'',0,100));
    maxlength_local_routing_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.local_routing_number)));
    avelength_local_routing_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.local_routing_number)),h.local_routing_number<>(typeof(h.local_routing_number))'');
    populated_account_owner_cnt := COUNT(GROUP,h.account_owner <> (TYPEOF(h.account_owner))'');
    populated_account_owner_pcnt := AVE(GROUP,IF(h.account_owner = (TYPEOF(h.account_owner))'',0,100));
    maxlength_account_owner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_owner)));
    avelength_account_owner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.account_owner)),h.account_owner<>(typeof(h.account_owner))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_carrier_category_cnt := COUNT(GROUP,h.carrier_category <> (TYPEOF(h.carrier_category))'');
    populated_carrier_category_pcnt := AVE(GROUP,IF(h.carrier_category = (TYPEOF(h.carrier_category))'',0,100));
    maxlength_carrier_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_category)));
    avelength_carrier_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_category)),h.carrier_category<>(typeof(h.carrier_category))'');
    populated_local_area_transport_area_cnt := COUNT(GROUP,h.local_area_transport_area <> (TYPEOF(h.local_area_transport_area))'');
    populated_local_area_transport_area_pcnt := AVE(GROUP,IF(h.local_area_transport_area = (TYPEOF(h.local_area_transport_area))'',0,100));
    maxlength_local_area_transport_area := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.local_area_transport_area)));
    avelength_local_area_transport_area := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.local_area_transport_area)),h.local_area_transport_area<>(typeof(h.local_area_transport_area))'');
    populated_point_code_cnt := COUNT(GROUP,h.point_code <> (TYPEOF(h.point_code))'');
    populated_point_code_pcnt := AVE(GROUP,IF(h.point_code = (TYPEOF(h.point_code))'',0,100));
    maxlength_point_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.point_code)));
    avelength_point_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.point_code)),h.point_code<>(typeof(h.point_code))'');
    populated_serv_cnt := COUNT(GROUP,h.serv <> (TYPEOF(h.serv))'');
    populated_serv_pcnt := AVE(GROUP,IF(h.serv = (TYPEOF(h.serv))'',0,100));
    maxlength_serv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.serv)));
    avelength_serv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.serv)),h.serv<>(typeof(h.serv))'');
    populated_line_cnt := COUNT(GROUP,h.line <> (TYPEOF(h.line))'');
    populated_line_pcnt := AVE(GROUP,IF(h.line = (TYPEOF(h.line))'',0,100));
    maxlength_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line)));
    avelength_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line)),h.line<>(typeof(h.line))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_operator_fullname_cnt := COUNT(GROUP,h.operator_fullname <> (TYPEOF(h.operator_fullname))'');
    populated_operator_fullname_pcnt := AVE(GROUP,IF(h.operator_fullname = (TYPEOF(h.operator_fullname))'',0,100));
    maxlength_operator_fullname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.operator_fullname)));
    avelength_operator_fullname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.operator_fullname)),h.operator_fullname<>(typeof(h.operator_fullname))'');
    populated_high_risk_indicator_cnt := COUNT(GROUP,h.high_risk_indicator <> (TYPEOF(h.high_risk_indicator))'');
    populated_high_risk_indicator_pcnt := AVE(GROUP,IF(h.high_risk_indicator = (TYPEOF(h.high_risk_indicator))'',0,100));
    maxlength_high_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_risk_indicator)));
    avelength_high_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_risk_indicator)),h.high_risk_indicator<>(typeof(h.high_risk_indicator))'');
    populated_prepaid_cnt := COUNT(GROUP,h.prepaid <> (TYPEOF(h.prepaid))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_time_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_time_pcnt *   0.00 / 100 + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_reply_code_pcnt *   0.00 / 100 + T.Populated_local_routing_number_pcnt *   0.00 / 100 + T.Populated_account_owner_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_carrier_category_pcnt *   0.00 / 100 + T.Populated_local_area_transport_area_pcnt *   0.00 / 100 + T.Populated_point_code_pcnt *   0.00 / 100 + T.Populated_serv_pcnt *   0.00 / 100 + T.Populated_line_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_operator_fullname_pcnt *   0.00 / 100 + T.Populated_high_risk_indicator_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'phone','source','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','reference_id','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','serv','line','spid','operator_fullname','high_risk_indicator','prepaid','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_source_pcnt,le.populated_vendor_first_reported_dt_pcnt,le.populated_vendor_first_reported_time_pcnt,le.populated_vendor_last_reported_dt_pcnt,le.populated_vendor_last_reported_time_pcnt,le.populated_reference_id_pcnt,le.populated_reply_code_pcnt,le.populated_local_routing_number_pcnt,le.populated_account_owner_pcnt,le.populated_carrier_name_pcnt,le.populated_carrier_category_pcnt,le.populated_local_area_transport_area_pcnt,le.populated_point_code_pcnt,le.populated_serv_pcnt,le.populated_line_pcnt,le.populated_spid_pcnt,le.populated_operator_fullname_pcnt,le.populated_high_risk_indicator_pcnt,le.populated_prepaid_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_source,le.maxlength_vendor_first_reported_dt,le.maxlength_vendor_first_reported_time,le.maxlength_vendor_last_reported_dt,le.maxlength_vendor_last_reported_time,le.maxlength_reference_id,le.maxlength_reply_code,le.maxlength_local_routing_number,le.maxlength_account_owner,le.maxlength_carrier_name,le.maxlength_carrier_category,le.maxlength_local_area_transport_area,le.maxlength_point_code,le.maxlength_serv,le.maxlength_line,le.maxlength_spid,le.maxlength_operator_fullname,le.maxlength_high_risk_indicator,le.maxlength_prepaid,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_source,le.avelength_vendor_first_reported_dt,le.avelength_vendor_first_reported_time,le.avelength_vendor_last_reported_dt,le.avelength_vendor_last_reported_time,le.avelength_reference_id,le.avelength_reply_code,le.avelength_local_routing_number,le.avelength_account_owner,le.avelength_carrier_name,le.avelength_carrier_category,le.avelength_local_area_transport_area,le.avelength_point_code,le.avelength_serv,le.avelength_line,le.avelength_spid,le.avelength_operator_fullname,le.avelength_high_risk_indicator,le.avelength_prepaid,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.reference_id),TRIM((SALT311.StrType)le.reply_code),TRIM((SALT311.StrType)le.local_routing_number),TRIM((SALT311.StrType)le.account_owner),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_category),TRIM((SALT311.StrType)le.local_area_transport_area),TRIM((SALT311.StrType)le.point_code),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_fullname),TRIM((SALT311.StrType)le.high_risk_indicator),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.reference_id),TRIM((SALT311.StrType)le.reply_code),TRIM((SALT311.StrType)le.local_routing_number),TRIM((SALT311.StrType)le.account_owner),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_category),TRIM((SALT311.StrType)le.local_area_transport_area),TRIM((SALT311.StrType)le.point_code),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_fullname),TRIM((SALT311.StrType)le.high_risk_indicator),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.reference_id),TRIM((SALT311.StrType)le.reply_code),TRIM((SALT311.StrType)le.local_routing_number),TRIM((SALT311.StrType)le.account_owner),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.carrier_category),TRIM((SALT311.StrType)le.local_area_transport_area),TRIM((SALT311.StrType)le.point_code),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_fullname),TRIM((SALT311.StrType)le.high_risk_indicator),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'phone'}
      ,{2,'source'}
      ,{3,'vendor_first_reported_dt'}
      ,{4,'vendor_first_reported_time'}
      ,{5,'vendor_last_reported_dt'}
      ,{6,'vendor_last_reported_time'}
      ,{7,'reference_id'}
      ,{8,'reply_code'}
      ,{9,'local_routing_number'}
      ,{10,'account_owner'}
      ,{11,'carrier_name'}
      ,{12,'carrier_category'}
      ,{13,'local_area_transport_area'}
      ,{14,'point_code'}
      ,{15,'serv'}
      ,{16,'line'}
      ,{17,'spid'}
      ,{18,'operator_fullname'}
      ,{19,'high_risk_indicator'}
      ,{20,'prepaid'}
      ,{21,'global_sid'}
      ,{22,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    PhonesTypeMain_Fields.InValid_phone((SALT311.StrType)le.phone),
    PhonesTypeMain_Fields.InValid_source((SALT311.StrType)le.source),
    PhonesTypeMain_Fields.InValid_vendor_first_reported_dt((SALT311.StrType)le.vendor_first_reported_dt),
    PhonesTypeMain_Fields.InValid_vendor_first_reported_time((SALT311.StrType)le.vendor_first_reported_time),
    PhonesTypeMain_Fields.InValid_vendor_last_reported_dt((SALT311.StrType)le.vendor_last_reported_dt),
    PhonesTypeMain_Fields.InValid_vendor_last_reported_time((SALT311.StrType)le.vendor_last_reported_time),
    PhonesTypeMain_Fields.InValid_reference_id((SALT311.StrType)le.reference_id),
    PhonesTypeMain_Fields.InValid_reply_code((SALT311.StrType)le.reply_code),
    PhonesTypeMain_Fields.InValid_local_routing_number((SALT311.StrType)le.local_routing_number),
    PhonesTypeMain_Fields.InValid_account_owner((SALT311.StrType)le.account_owner),
    PhonesTypeMain_Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name),
    PhonesTypeMain_Fields.InValid_carrier_category((SALT311.StrType)le.carrier_category),
    PhonesTypeMain_Fields.InValid_local_area_transport_area((SALT311.StrType)le.local_area_transport_area),
    PhonesTypeMain_Fields.InValid_point_code((SALT311.StrType)le.point_code),
    PhonesTypeMain_Fields.InValid_serv((SALT311.StrType)le.serv),
    PhonesTypeMain_Fields.InValid_line((SALT311.StrType)le.line),
    PhonesTypeMain_Fields.InValid_spid((SALT311.StrType)le.spid),
    PhonesTypeMain_Fields.InValid_operator_fullname((SALT311.StrType)le.operator_fullname),
    PhonesTypeMain_Fields.InValid_high_risk_indicator((SALT311.StrType)le.high_risk_indicator),
    PhonesTypeMain_Fields.InValid_prepaid((SALT311.StrType)le.prepaid),
    PhonesTypeMain_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    PhonesTypeMain_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,22,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := PhonesTypeMain_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Src','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_AlphaNum','Invalid_Num','Invalid_Num','Invalid_AlphaNum','Unknown','Invalid_CharCat','Invalid_Num','Unknown','Invalid_Type','Invalid_Type','Invalid_AlphaNum','Unknown','Invalid_Indic','Invalid_Indic','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,PhonesTypeMain_Fields.InValidMessage_phone(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_source(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_vendor_first_reported_dt(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_vendor_first_reported_time(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_vendor_last_reported_dt(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_vendor_last_reported_time(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_reply_code(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_local_routing_number(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_account_owner(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_carrier_category(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_local_area_transport_area(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_point_code(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_serv(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_line(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_spid(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_operator_fullname(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_high_risk_indicator(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),PhonesTypeMain_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PhonesTypeMain_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

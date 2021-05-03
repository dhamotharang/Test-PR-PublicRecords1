IMPORT SALT311,STD;
EXPORT PhonesTransactionMain_hygiene(dataset(PhonesTransactionMain_layout_PhonesInfo) h) := MODULE
 
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
    populated_transaction_code_cnt := COUNT(GROUP,h.transaction_code <> (TYPEOF(h.transaction_code))'');
    populated_transaction_code_pcnt := AVE(GROUP,IF(h.transaction_code = (TYPEOF(h.transaction_code))'',0,100));
    maxlength_transaction_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_code)));
    avelength_transaction_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_code)),h.transaction_code<>(typeof(h.transaction_code))'');
    populated_transaction_start_dt_cnt := COUNT(GROUP,h.transaction_start_dt <> (TYPEOF(h.transaction_start_dt))'');
    populated_transaction_start_dt_pcnt := AVE(GROUP,IF(h.transaction_start_dt = (TYPEOF(h.transaction_start_dt))'',0,100));
    maxlength_transaction_start_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_start_dt)));
    avelength_transaction_start_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_start_dt)),h.transaction_start_dt<>(typeof(h.transaction_start_dt))'');
    populated_transaction_start_time_cnt := COUNT(GROUP,h.transaction_start_time <> (TYPEOF(h.transaction_start_time))'');
    populated_transaction_start_time_pcnt := AVE(GROUP,IF(h.transaction_start_time = (TYPEOF(h.transaction_start_time))'',0,100));
    maxlength_transaction_start_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_start_time)));
    avelength_transaction_start_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_start_time)),h.transaction_start_time<>(typeof(h.transaction_start_time))'');
    populated_transaction_end_dt_cnt := COUNT(GROUP,h.transaction_end_dt <> (TYPEOF(h.transaction_end_dt))'');
    populated_transaction_end_dt_pcnt := AVE(GROUP,IF(h.transaction_end_dt = (TYPEOF(h.transaction_end_dt))'',0,100));
    maxlength_transaction_end_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_end_dt)));
    avelength_transaction_end_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_end_dt)),h.transaction_end_dt<>(typeof(h.transaction_end_dt))'');
    populated_transaction_end_time_cnt := COUNT(GROUP,h.transaction_end_time <> (TYPEOF(h.transaction_end_time))'');
    populated_transaction_end_time_pcnt := AVE(GROUP,IF(h.transaction_end_time = (TYPEOF(h.transaction_end_time))'',0,100));
    maxlength_transaction_end_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_end_time)));
    avelength_transaction_end_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_end_time)),h.transaction_end_time<>(typeof(h.transaction_end_time))'');
    populated_transaction_count_cnt := COUNT(GROUP,h.transaction_count <> (TYPEOF(h.transaction_count))'');
    populated_transaction_count_pcnt := AVE(GROUP,IF(h.transaction_count = (TYPEOF(h.transaction_count))'',0,100));
    maxlength_transaction_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_count)));
    avelength_transaction_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_count)),h.transaction_count<>(typeof(h.transaction_count))'');
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
    populated_country_code_cnt := COUNT(GROUP,h.country_code <> (TYPEOF(h.country_code))'');
    populated_country_code_pcnt := AVE(GROUP,IF(h.country_code = (TYPEOF(h.country_code))'',0,100));
    maxlength_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_code)));
    avelength_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_code)),h.country_code<>(typeof(h.country_code))'');
    populated_country_abbr_cnt := COUNT(GROUP,h.country_abbr <> (TYPEOF(h.country_abbr))'');
    populated_country_abbr_pcnt := AVE(GROUP,IF(h.country_abbr = (TYPEOF(h.country_abbr))'',0,100));
    maxlength_country_abbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_abbr)));
    avelength_country_abbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.country_abbr)),h.country_abbr<>(typeof(h.country_abbr))'');
    populated_routing_code_cnt := COUNT(GROUP,h.routing_code <> (TYPEOF(h.routing_code))'');
    populated_routing_code_pcnt := AVE(GROUP,IF(h.routing_code = (TYPEOF(h.routing_code))'',0,100));
    maxlength_routing_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.routing_code)));
    avelength_routing_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.routing_code)),h.routing_code<>(typeof(h.routing_code))'');
    populated_dial_type_cnt := COUNT(GROUP,h.dial_type <> (TYPEOF(h.dial_type))'');
    populated_dial_type_pcnt := AVE(GROUP,IF(h.dial_type = (TYPEOF(h.dial_type))'',0,100));
    maxlength_dial_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dial_type)));
    avelength_dial_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dial_type)),h.dial_type<>(typeof(h.dial_type))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_phone_swap_cnt := COUNT(GROUP,h.phone_swap <> (TYPEOF(h.phone_swap))'');
    populated_phone_swap_pcnt := AVE(GROUP,IF(h.phone_swap = (TYPEOF(h.phone_swap))'',0,100));
    maxlength_phone_swap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_swap)));
    avelength_phone_swap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_swap)),h.phone_swap<>(typeof(h.phone_swap))'');
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
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
    UNSIGNED LinkingPotential :=  + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_transaction_code_pcnt *   0.00 / 100 + T.Populated_transaction_start_dt_pcnt *   0.00 / 100 + T.Populated_transaction_start_time_pcnt *   0.00 / 100 + T.Populated_transaction_end_dt_pcnt *   0.00 / 100 + T.Populated_transaction_end_time_pcnt *   0.00 / 100 + T.Populated_transaction_count_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_time_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_time_pcnt *   0.00 / 100 + T.Populated_country_code_pcnt *   0.00 / 100 + T.Populated_country_abbr_pcnt *   0.00 / 100 + T.Populated_routing_code_pcnt *   0.00 / 100 + T.Populated_dial_type_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_phone_swap_pcnt *   0.00 / 100 + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'phone','source','transaction_code','transaction_start_dt','transaction_start_time','transaction_end_dt','transaction_end_time','transaction_count','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','country_code','country_abbr','routing_code','dial_type','spid','carrier_name','phone_swap','ocn','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_source_pcnt,le.populated_transaction_code_pcnt,le.populated_transaction_start_dt_pcnt,le.populated_transaction_start_time_pcnt,le.populated_transaction_end_dt_pcnt,le.populated_transaction_end_time_pcnt,le.populated_transaction_count_pcnt,le.populated_vendor_first_reported_dt_pcnt,le.populated_vendor_first_reported_time_pcnt,le.populated_vendor_last_reported_dt_pcnt,le.populated_vendor_last_reported_time_pcnt,le.populated_country_code_pcnt,le.populated_country_abbr_pcnt,le.populated_routing_code_pcnt,le.populated_dial_type_pcnt,le.populated_spid_pcnt,le.populated_carrier_name_pcnt,le.populated_phone_swap_pcnt,le.populated_ocn_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_source,le.maxlength_transaction_code,le.maxlength_transaction_start_dt,le.maxlength_transaction_start_time,le.maxlength_transaction_end_dt,le.maxlength_transaction_end_time,le.maxlength_transaction_count,le.maxlength_vendor_first_reported_dt,le.maxlength_vendor_first_reported_time,le.maxlength_vendor_last_reported_dt,le.maxlength_vendor_last_reported_time,le.maxlength_country_code,le.maxlength_country_abbr,le.maxlength_routing_code,le.maxlength_dial_type,le.maxlength_spid,le.maxlength_carrier_name,le.maxlength_phone_swap,le.maxlength_ocn,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_source,le.avelength_transaction_code,le.avelength_transaction_start_dt,le.avelength_transaction_start_time,le.avelength_transaction_end_dt,le.avelength_transaction_end_time,le.avelength_transaction_count,le.avelength_vendor_first_reported_dt,le.avelength_vendor_first_reported_time,le.avelength_vendor_last_reported_dt,le.avelength_vendor_last_reported_time,le.avelength_country_code,le.avelength_country_abbr,le.avelength_routing_code,le.avelength_dial_type,le.avelength_spid,le.avelength_carrier_name,le.avelength_phone_swap,le.avelength_ocn,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.transaction_code),IF (le.transaction_start_dt <> 0,TRIM((SALT311.StrType)le.transaction_start_dt), ''),TRIM((SALT311.StrType)le.transaction_start_time),IF (le.transaction_end_dt <> 0,TRIM((SALT311.StrType)le.transaction_end_dt), ''),TRIM((SALT311.StrType)le.transaction_end_time),IF (le.transaction_count <> 0,TRIM((SALT311.StrType)le.transaction_count), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.country_code),TRIM((SALT311.StrType)le.country_abbr),TRIM((SALT311.StrType)le.routing_code),TRIM((SALT311.StrType)le.dial_type),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.phone_swap),TRIM((SALT311.StrType)le.ocn),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.transaction_code),IF (le.transaction_start_dt <> 0,TRIM((SALT311.StrType)le.transaction_start_dt), ''),TRIM((SALT311.StrType)le.transaction_start_time),IF (le.transaction_end_dt <> 0,TRIM((SALT311.StrType)le.transaction_end_dt), ''),TRIM((SALT311.StrType)le.transaction_end_time),IF (le.transaction_count <> 0,TRIM((SALT311.StrType)le.transaction_count), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.country_code),TRIM((SALT311.StrType)le.country_abbr),TRIM((SALT311.StrType)le.routing_code),TRIM((SALT311.StrType)le.dial_type),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.phone_swap),TRIM((SALT311.StrType)le.ocn),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.transaction_code),IF (le.transaction_start_dt <> 0,TRIM((SALT311.StrType)le.transaction_start_dt), ''),TRIM((SALT311.StrType)le.transaction_start_time),IF (le.transaction_end_dt <> 0,TRIM((SALT311.StrType)le.transaction_end_dt), ''),TRIM((SALT311.StrType)le.transaction_end_time),IF (le.transaction_count <> 0,TRIM((SALT311.StrType)le.transaction_count), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT311.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT311.StrType)le.vendor_last_reported_time),TRIM((SALT311.StrType)le.country_code),TRIM((SALT311.StrType)le.country_abbr),TRIM((SALT311.StrType)le.routing_code),TRIM((SALT311.StrType)le.dial_type),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.phone_swap),TRIM((SALT311.StrType)le.ocn),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'phone'}
      ,{2,'source'}
      ,{3,'transaction_code'}
      ,{4,'transaction_start_dt'}
      ,{5,'transaction_start_time'}
      ,{6,'transaction_end_dt'}
      ,{7,'transaction_end_time'}
      ,{8,'transaction_count'}
      ,{9,'vendor_first_reported_dt'}
      ,{10,'vendor_first_reported_time'}
      ,{11,'vendor_last_reported_dt'}
      ,{12,'vendor_last_reported_time'}
      ,{13,'country_code'}
      ,{14,'country_abbr'}
      ,{15,'routing_code'}
      ,{16,'dial_type'}
      ,{17,'spid'}
      ,{18,'carrier_name'}
      ,{19,'phone_swap'}
      ,{20,'ocn'}
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
    PhonesTransactionMain_Fields.InValid_phone((SALT311.StrType)le.phone),
    PhonesTransactionMain_Fields.InValid_source((SALT311.StrType)le.source),
    PhonesTransactionMain_Fields.InValid_transaction_code((SALT311.StrType)le.transaction_code),
    PhonesTransactionMain_Fields.InValid_transaction_start_dt((SALT311.StrType)le.transaction_start_dt),
    PhonesTransactionMain_Fields.InValid_transaction_start_time((SALT311.StrType)le.transaction_start_time),
    PhonesTransactionMain_Fields.InValid_transaction_end_dt((SALT311.StrType)le.transaction_end_dt),
    PhonesTransactionMain_Fields.InValid_transaction_end_time((SALT311.StrType)le.transaction_end_time),
    PhonesTransactionMain_Fields.InValid_transaction_count((SALT311.StrType)le.transaction_count),
    PhonesTransactionMain_Fields.InValid_vendor_first_reported_dt((SALT311.StrType)le.vendor_first_reported_dt),
    PhonesTransactionMain_Fields.InValid_vendor_first_reported_time((SALT311.StrType)le.vendor_first_reported_time),
    PhonesTransactionMain_Fields.InValid_vendor_last_reported_dt((SALT311.StrType)le.vendor_last_reported_dt),
    PhonesTransactionMain_Fields.InValid_vendor_last_reported_time((SALT311.StrType)le.vendor_last_reported_time),
    PhonesTransactionMain_Fields.InValid_country_code((SALT311.StrType)le.country_code),
    PhonesTransactionMain_Fields.InValid_country_abbr((SALT311.StrType)le.country_abbr),
    PhonesTransactionMain_Fields.InValid_routing_code((SALT311.StrType)le.routing_code),
    PhonesTransactionMain_Fields.InValid_dial_type((SALT311.StrType)le.dial_type),
    PhonesTransactionMain_Fields.InValid_spid((SALT311.StrType)le.spid),
    PhonesTransactionMain_Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name),
    PhonesTransactionMain_Fields.InValid_phone_swap((SALT311.StrType)le.phone_swap),
    PhonesTransactionMain_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    PhonesTransactionMain_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    PhonesTransactionMain_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
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
  FieldNme := PhonesTransactionMain_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Src','Invalid_TransCode','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_CountryCode','Invalid_CountryAbbr','Invalid_Num','Invalid_DialTypeCode','Invalid_AlphaNum','Unknown','Invalid_Num','Invalid_AlphaNum','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,PhonesTransactionMain_Fields.InValidMessage_phone(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_source(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_code(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_start_dt(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_start_time(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_end_dt(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_end_time(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_transaction_count(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_vendor_first_reported_dt(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_vendor_first_reported_time(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_vendor_last_reported_dt(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_vendor_last_reported_time(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_country_code(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_country_abbr(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_routing_code(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_dial_type(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_spid(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_phone_swap(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),PhonesTransactionMain_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PhonesTransactionMain_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

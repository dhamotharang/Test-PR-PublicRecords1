IMPORT SALT36;
EXPORT BaseSpoofing_hygiene(dataset(BaseSpoofing_layout_PhoneFraud) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_date_file_loaded_pcnt := AVE(GROUP,IF(h.date_file_loaded = (TYPEOF(h.date_file_loaded))'',0,100));
    maxlength_date_file_loaded := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_file_loaded)));
    avelength_date_file_loaded := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_file_loaded)),h.date_file_loaded<>(typeof(h.date_file_loaded))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_origin_pcnt := AVE(GROUP,IF(h.phone_origin = (TYPEOF(h.phone_origin))'',0,100));
    maxlength_phone_origin := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone_origin)));
    avelength_phone_origin := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone_origin)),h.phone_origin<>(typeof(h.phone_origin))'');
    populated_id_value_pcnt := AVE(GROUP,IF(h.id_value = (TYPEOF(h.id_value))'',0,100));
    maxlength_id_value := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.id_value)));
    avelength_id_value := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.id_value)),h.id_value<>(typeof(h.id_value))'');
    populated_reference_id_pcnt := AVE(GROUP,IF(h.reference_id = (TYPEOF(h.reference_id))'',0,100));
    maxlength_reference_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.reference_id)));
    avelength_reference_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.reference_id)),h.reference_id<>(typeof(h.reference_id))'');
    populated_mode_type_pcnt := AVE(GROUP,IF(h.mode_type = (TYPEOF(h.mode_type))'',0,100));
    maxlength_mode_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mode_type)));
    avelength_mode_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mode_type)),h.mode_type<>(typeof(h.mode_type))'');
    populated_account_name_pcnt := AVE(GROUP,IF(h.account_name = (TYPEOF(h.account_name))'',0,100));
    maxlength_account_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.account_name)));
    avelength_account_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.account_name)),h.account_name<>(typeof(h.account_name))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_time_pcnt := AVE(GROUP,IF(h.event_time = (TYPEOF(h.event_time))'',0,100));
    maxlength_event_time := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)));
    avelength_event_time := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)),h.event_time<>(typeof(h.event_time))'');
    populated_ip_address_pcnt := AVE(GROUP,IF(h.ip_address = (TYPEOF(h.ip_address))'',0,100));
    maxlength_ip_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_address)));
    avelength_ip_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ip_address)),h.ip_address<>(typeof(h.ip_address))'');
    populated_neustar_lower_bound_pcnt := AVE(GROUP,IF(h.neustar_lower_bound = (TYPEOF(h.neustar_lower_bound))'',0,100));
    maxlength_neustar_lower_bound := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.neustar_lower_bound)));
    avelength_neustar_lower_bound := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.neustar_lower_bound)),h.neustar_lower_bound<>(typeof(h.neustar_lower_bound))'');
    populated_neustar_upper_bound_pcnt := AVE(GROUP,IF(h.neustar_upper_bound = (TYPEOF(h.neustar_upper_bound))'',0,100));
    maxlength_neustar_upper_bound := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.neustar_upper_bound)));
    avelength_neustar_upper_bound := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.neustar_upper_bound)),h.neustar_upper_bound<>(typeof(h.neustar_upper_bound))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_time_added_pcnt := AVE(GROUP,IF(h.time_added = (TYPEOF(h.time_added))'',0,100));
    maxlength_time_added := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.time_added)));
    avelength_time_added := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.time_added)),h.time_added<>(typeof(h.time_added))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_file_loaded_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_origin_pcnt *   0.00 / 100 + T.Populated_id_value_pcnt *   0.00 / 100 + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_mode_type_pcnt *   0.00 / 100 + T.Populated_account_name_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_time_pcnt *   0.00 / 100 + T.Populated_ip_address_pcnt *   0.00 / 100 + T.Populated_neustar_lower_bound_pcnt *   0.00 / 100 + T.Populated_neustar_upper_bound_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_time_added_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'date_file_loaded','phone','phone_origin','id_value','reference_id','mode_type','account_name','event_date','event_time','ip_address','neustar_lower_bound','neustar_upper_bound','vendor','date_added','time_added');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_file_loaded_pcnt,le.populated_phone_pcnt,le.populated_phone_origin_pcnt,le.populated_id_value_pcnt,le.populated_reference_id_pcnt,le.populated_mode_type_pcnt,le.populated_account_name_pcnt,le.populated_event_date_pcnt,le.populated_event_time_pcnt,le.populated_ip_address_pcnt,le.populated_neustar_lower_bound_pcnt,le.populated_neustar_upper_bound_pcnt,le.populated_vendor_pcnt,le.populated_date_added_pcnt,le.populated_time_added_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_file_loaded,le.maxlength_phone,le.maxlength_phone_origin,le.maxlength_id_value,le.maxlength_reference_id,le.maxlength_mode_type,le.maxlength_account_name,le.maxlength_event_date,le.maxlength_event_time,le.maxlength_ip_address,le.maxlength_neustar_lower_bound,le.maxlength_neustar_upper_bound,le.maxlength_vendor,le.maxlength_date_added,le.maxlength_time_added);
  SELF.avelength := CHOOSE(C,le.avelength_date_file_loaded,le.avelength_phone,le.avelength_phone_origin,le.avelength_id_value,le.avelength_reference_id,le.avelength_mode_type,le.avelength_account_name,le.avelength_event_date,le.avelength_event_time,le.avelength_ip_address,le.avelength_neustar_lower_bound,le.avelength_neustar_upper_bound,le.avelength_vendor,le.avelength_date_added,le.avelength_time_added);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_origin),IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_origin),IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_origin),IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_file_loaded'}
      ,{2,'phone'}
      ,{3,'phone_origin'}
      ,{4,'id_value'}
      ,{5,'reference_id'}
      ,{6,'mode_type'}
      ,{7,'account_name'}
      ,{8,'event_date'}
      ,{9,'event_time'}
      ,{10,'ip_address'}
      ,{11,'neustar_lower_bound'}
      ,{12,'neustar_upper_bound'}
      ,{13,'vendor'}
      ,{14,'date_added'}
      ,{15,'time_added'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BaseSpoofing_Fields.InValid_date_file_loaded((SALT36.StrType)le.date_file_loaded),
    BaseSpoofing_Fields.InValid_phone((SALT36.StrType)le.phone),
    BaseSpoofing_Fields.InValid_phone_origin((SALT36.StrType)le.phone_origin),
    BaseSpoofing_Fields.InValid_id_value((SALT36.StrType)le.id_value),
    BaseSpoofing_Fields.InValid_reference_id((SALT36.StrType)le.reference_id),
    BaseSpoofing_Fields.InValid_mode_type((SALT36.StrType)le.mode_type),
    BaseSpoofing_Fields.InValid_account_name((SALT36.StrType)le.account_name),
    BaseSpoofing_Fields.InValid_event_date((SALT36.StrType)le.event_date),
    BaseSpoofing_Fields.InValid_event_time((SALT36.StrType)le.event_time),
    BaseSpoofing_Fields.InValid_ip_address((SALT36.StrType)le.ip_address),
    BaseSpoofing_Fields.InValid_neustar_lower_bound((SALT36.StrType)le.neustar_lower_bound),
    BaseSpoofing_Fields.InValid_neustar_upper_bound((SALT36.StrType)le.neustar_upper_bound),
    BaseSpoofing_Fields.InValid_vendor((SALT36.StrType)le.vendor),
    BaseSpoofing_Fields.InValid_date_added((SALT36.StrType)le.date_added),
    BaseSpoofing_Fields.InValid_time_added((SALT36.StrType)le.time_added),
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
  FieldNme := BaseSpoofing_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Phone','Invalid_Phone_Origin','Invalid_ID','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BaseSpoofing_Fields.InValidMessage_date_file_loaded(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_phone(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_phone_origin(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_id_value(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_mode_type(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_account_name(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_event_date(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_event_time(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_ip_address(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_neustar_lower_bound(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_neustar_upper_bound(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),BaseSpoofing_Fields.InValidMessage_time_added(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

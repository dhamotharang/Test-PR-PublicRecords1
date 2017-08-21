IMPORT SALT36;
EXPORT RawSpoofing_hygiene(dataset(RawSpoofing_layout_PhoneFraud) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_event_time_pcnt := AVE(GROUP,IF(h.event_time = (TYPEOF(h.event_time))'',0,100));
    maxlength_event_time := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)));
    avelength_event_time := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)),h.event_time<>(typeof(h.event_time))'');
    populated_spoofed_phone_number_pcnt := AVE(GROUP,IF(h.spoofed_phone_number = (TYPEOF(h.spoofed_phone_number))'',0,100));
    maxlength_spoofed_phone_number := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.spoofed_phone_number)));
    avelength_spoofed_phone_number := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.spoofed_phone_number)),h.spoofed_phone_number<>(typeof(h.spoofed_phone_number))'');
    populated_destination_number_pcnt := AVE(GROUP,IF(h.destination_number = (TYPEOF(h.destination_number))'',0,100));
    maxlength_destination_number := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.destination_number)));
    avelength_destination_number := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.destination_number)),h.destination_number<>(typeof(h.destination_number))'');
    populated_source_phone_number_pcnt := AVE(GROUP,IF(h.source_phone_number = (TYPEOF(h.source_phone_number))'',0,100));
    maxlength_source_phone_number := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.source_phone_number)));
    avelength_source_phone_number := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.source_phone_number)),h.source_phone_number<>(typeof(h.source_phone_number))'');
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
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_id_value_pcnt *   0.00 / 100 + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_mode_type_pcnt *   0.00 / 100 + T.Populated_account_name_pcnt *   0.00 / 100 + T.Populated_event_time_pcnt *   0.00 / 100 + T.Populated_spoofed_phone_number_pcnt *   0.00 / 100 + T.Populated_destination_number_pcnt *   0.00 / 100 + T.Populated_source_phone_number_pcnt *   0.00 / 100 + T.Populated_ip_address_pcnt *   0.00 / 100 + T.Populated_neustar_lower_bound_pcnt *   0.00 / 100 + T.Populated_neustar_upper_bound_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'id_value','reference_id','mode_type','account_name','event_time','spoofed_phone_number','destination_number','source_phone_number','ip_address','neustar_lower_bound','neustar_upper_bound','vendor','date_added','user_added');
  SELF.populated_pcnt := CHOOSE(C,le.populated_id_value_pcnt,le.populated_reference_id_pcnt,le.populated_mode_type_pcnt,le.populated_account_name_pcnt,le.populated_event_time_pcnt,le.populated_spoofed_phone_number_pcnt,le.populated_destination_number_pcnt,le.populated_source_phone_number_pcnt,le.populated_ip_address_pcnt,le.populated_neustar_lower_bound_pcnt,le.populated_neustar_upper_bound_pcnt,le.populated_vendor_pcnt,le.populated_date_added_pcnt,le.populated_user_added_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_id_value,le.maxlength_reference_id,le.maxlength_mode_type,le.maxlength_account_name,le.maxlength_event_time,le.maxlength_spoofed_phone_number,le.maxlength_destination_number,le.maxlength_source_phone_number,le.maxlength_ip_address,le.maxlength_neustar_lower_bound,le.maxlength_neustar_upper_bound,le.maxlength_vendor,le.maxlength_date_added,le.maxlength_user_added);
  SELF.avelength := CHOOSE(C,le.avelength_id_value,le.avelength_reference_id,le.avelength_mode_type,le.avelength_account_name,le.avelength_event_time,le.avelength_spoofed_phone_number,le.avelength_destination_number,le.avelength_source_phone_number,le.avelength_ip_address,le.avelength_neustar_lower_bound,le.avelength_neustar_upper_bound,le.avelength_vendor,le.avelength_date_added,le.avelength_user_added);
END;
EXPORT invSummary := NORMALIZE(summary0, 14, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.spoofed_phone_number),TRIM((SALT36.StrType)le.destination_number),TRIM((SALT36.StrType)le.source_phone_number),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.user_added)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,14,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 14);
  SELF.FldNo2 := 1 + (C % 14);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.spoofed_phone_number),TRIM((SALT36.StrType)le.destination_number),TRIM((SALT36.StrType)le.source_phone_number),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.user_added)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.id_value <> 0,TRIM((SALT36.StrType)le.id_value), ''),TRIM((SALT36.StrType)le.reference_id),TRIM((SALT36.StrType)le.mode_type),TRIM((SALT36.StrType)le.account_name),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.spoofed_phone_number),TRIM((SALT36.StrType)le.destination_number),TRIM((SALT36.StrType)le.source_phone_number),TRIM((SALT36.StrType)le.ip_address),TRIM((SALT36.StrType)le.neustar_lower_bound),TRIM((SALT36.StrType)le.neustar_upper_bound),TRIM((SALT36.StrType)le.vendor),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.user_added)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),14*14,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'id_value'}
      ,{2,'reference_id'}
      ,{3,'mode_type'}
      ,{4,'account_name'}
      ,{5,'event_time'}
      ,{6,'spoofed_phone_number'}
      ,{7,'destination_number'}
      ,{8,'source_phone_number'}
      ,{9,'ip_address'}
      ,{10,'neustar_lower_bound'}
      ,{11,'neustar_upper_bound'}
      ,{12,'vendor'}
      ,{13,'date_added'}
      ,{14,'user_added'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RawSpoofing_Fields.InValid_id_value((SALT36.StrType)le.id_value),
    RawSpoofing_Fields.InValid_reference_id((SALT36.StrType)le.reference_id),
    RawSpoofing_Fields.InValid_mode_type((SALT36.StrType)le.mode_type),
    RawSpoofing_Fields.InValid_account_name((SALT36.StrType)le.account_name),
    RawSpoofing_Fields.InValid_event_time((SALT36.StrType)le.event_time),
    RawSpoofing_Fields.InValid_spoofed_phone_number((SALT36.StrType)le.spoofed_phone_number),
    RawSpoofing_Fields.InValid_destination_number((SALT36.StrType)le.destination_number),
    RawSpoofing_Fields.InValid_source_phone_number((SALT36.StrType)le.source_phone_number),
    RawSpoofing_Fields.InValid_ip_address((SALT36.StrType)le.ip_address),
    RawSpoofing_Fields.InValid_neustar_lower_bound((SALT36.StrType)le.neustar_lower_bound),
    RawSpoofing_Fields.InValid_neustar_upper_bound((SALT36.StrType)le.neustar_upper_bound),
    RawSpoofing_Fields.InValid_vendor((SALT36.StrType)le.vendor),
    RawSpoofing_Fields.InValid_date_added((SALT36.StrType)le.date_added),
    RawSpoofing_Fields.InValid_user_added((SALT36.StrType)le.user_added),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,14,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RawSpoofing_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_ID','Unknown','Unknown','Unknown','Invalid_Event_Time','Invalid_Phone_Number','Invalid_Phone_Number','Invalid_Phone_Number','Unknown','Unknown','Unknown','Unknown','Invalid_Date_Added','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RawSpoofing_Fields.InValidMessage_id_value(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_mode_type(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_account_name(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_event_time(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_spoofed_phone_number(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_destination_number(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_source_phone_number(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_ip_address(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_neustar_lower_bound(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_neustar_upper_bound(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),RawSpoofing_Fields.InValidMessage_user_added(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

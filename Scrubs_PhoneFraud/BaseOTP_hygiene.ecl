IMPORT SALT36;
EXPORT BaseOTP_hygiene(dataset(BaseOTP_layout_PhoneFraud) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_date_file_loaded_pcnt := AVE(GROUP,IF(h.date_file_loaded = (TYPEOF(h.date_file_loaded))'',0,100));
    maxlength_date_file_loaded := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_file_loaded)));
    avelength_date_file_loaded := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_file_loaded)),h.date_file_loaded<>(typeof(h.date_file_loaded))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_time_pcnt := AVE(GROUP,IF(h.event_time = (TYPEOF(h.event_time))'',0,100));
    maxlength_event_time := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)));
    avelength_event_time := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.event_time)),h.event_time<>(typeof(h.event_time))'');
    populated_function_name_pcnt := AVE(GROUP,IF(h.function_name = (TYPEOF(h.function_name))'',0,100));
    maxlength_function_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.function_name)));
    avelength_function_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.function_name)),h.function_name<>(typeof(h.function_name))'');
    populated_account_id_pcnt := AVE(GROUP,IF(h.account_id = (TYPEOF(h.account_id))'',0,100));
    maxlength_account_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.account_id)));
    avelength_account_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.account_id)),h.account_id<>(typeof(h.account_id))'');
    populated_subject_id_pcnt := AVE(GROUP,IF(h.subject_id = (TYPEOF(h.subject_id))'',0,100));
    maxlength_subject_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.subject_id)));
    avelength_subject_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.subject_id)),h.subject_id<>(typeof(h.subject_id))'');
    populated_customer_subject_id_pcnt := AVE(GROUP,IF(h.customer_subject_id = (TYPEOF(h.customer_subject_id))'',0,100));
    maxlength_customer_subject_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.customer_subject_id)));
    avelength_customer_subject_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.customer_subject_id)),h.customer_subject_id<>(typeof(h.customer_subject_id))'');
    populated_otp_id_pcnt := AVE(GROUP,IF(h.otp_id = (TYPEOF(h.otp_id))'',0,100));
    maxlength_otp_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_id)));
    avelength_otp_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_id)),h.otp_id<>(typeof(h.otp_id))'');
    populated_verify_passed_pcnt := AVE(GROUP,IF(h.verify_passed = (TYPEOF(h.verify_passed))'',0,100));
    maxlength_verify_passed := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.verify_passed)));
    avelength_verify_passed := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.verify_passed)),h.verify_passed<>(typeof(h.verify_passed))'');
    populated_otp_delivery_method_pcnt := AVE(GROUP,IF(h.otp_delivery_method = (TYPEOF(h.otp_delivery_method))'',0,100));
    maxlength_otp_delivery_method := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_delivery_method)));
    avelength_otp_delivery_method := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_delivery_method)),h.otp_delivery_method<>(typeof(h.otp_delivery_method))'');
    populated_otp_preferred_delivery_pcnt := AVE(GROUP,IF(h.otp_preferred_delivery = (TYPEOF(h.otp_preferred_delivery))'',0,100));
    maxlength_otp_preferred_delivery := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_preferred_delivery)));
    avelength_otp_preferred_delivery := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_preferred_delivery)),h.otp_preferred_delivery<>(typeof(h.otp_preferred_delivery))'');
    populated_otp_phone_pcnt := AVE(GROUP,IF(h.otp_phone = (TYPEOF(h.otp_phone))'',0,100));
    maxlength_otp_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_phone)));
    avelength_otp_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_phone)),h.otp_phone<>(typeof(h.otp_phone))'');
    populated_otp_email_pcnt := AVE(GROUP,IF(h.otp_email = (TYPEOF(h.otp_email))'',0,100));
    maxlength_otp_email := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_email)));
    avelength_otp_email := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_email)),h.otp_email<>(typeof(h.otp_email))'');
    populated_reference_code_pcnt := AVE(GROUP,IF(h.reference_code = (TYPEOF(h.reference_code))'',0,100));
    maxlength_reference_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.reference_code)));
    avelength_reference_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.reference_code)),h.reference_code<>(typeof(h.reference_code))'');
    populated_product_id_pcnt := AVE(GROUP,IF(h.product_id = (TYPEOF(h.product_id))'',0,100));
    maxlength_product_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.product_id)));
    avelength_product_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.product_id)),h.product_id<>(typeof(h.product_id))'');
    populated_sub_product_id_pcnt := AVE(GROUP,IF(h.sub_product_id = (TYPEOF(h.sub_product_id))'',0,100));
    maxlength_sub_product_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sub_product_id)));
    avelength_sub_product_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sub_product_id)),h.sub_product_id<>(typeof(h.sub_product_id))'');
    populated_subject_unique_id_pcnt := AVE(GROUP,IF(h.subject_unique_id = (TYPEOF(h.subject_unique_id))'',0,100));
    maxlength_subject_unique_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.subject_unique_id)));
    avelength_subject_unique_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.subject_unique_id)),h.subject_unique_id<>(typeof(h.subject_unique_id))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_otp_type_pcnt := AVE(GROUP,IF(h.otp_type = (TYPEOF(h.otp_type))'',0,100));
    maxlength_otp_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_type)));
    avelength_otp_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_type)),h.otp_type<>(typeof(h.otp_type))'');
    populated_otp_length_pcnt := AVE(GROUP,IF(h.otp_length = (TYPEOF(h.otp_length))'',0,100));
    maxlength_otp_length := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_length)));
    avelength_otp_length := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_length)),h.otp_length<>(typeof(h.otp_length))'');
    populated_mobile_phone_pcnt := AVE(GROUP,IF(h.mobile_phone = (TYPEOF(h.mobile_phone))'',0,100));
    maxlength_mobile_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone)));
    avelength_mobile_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone)),h.mobile_phone<>(typeof(h.mobile_phone))'');
    populated_mobile_phone_country_pcnt := AVE(GROUP,IF(h.mobile_phone_country = (TYPEOF(h.mobile_phone_country))'',0,100));
    maxlength_mobile_phone_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone_country)));
    avelength_mobile_phone_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone_country)),h.mobile_phone_country<>(typeof(h.mobile_phone_country))'');
    populated_mobile_phone_carrier_pcnt := AVE(GROUP,IF(h.mobile_phone_carrier = (TYPEOF(h.mobile_phone_carrier))'',0,100));
    maxlength_mobile_phone_carrier := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone_carrier)));
    avelength_mobile_phone_carrier := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.mobile_phone_carrier)),h.mobile_phone_carrier<>(typeof(h.mobile_phone_carrier))'');
    populated_work_phone_pcnt := AVE(GROUP,IF(h.work_phone = (TYPEOF(h.work_phone))'',0,100));
    maxlength_work_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.work_phone)));
    avelength_work_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.work_phone)),h.work_phone<>(typeof(h.work_phone))'');
    populated_work_phone_country_pcnt := AVE(GROUP,IF(h.work_phone_country = (TYPEOF(h.work_phone_country))'',0,100));
    maxlength_work_phone_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.work_phone_country)));
    avelength_work_phone_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.work_phone_country)),h.work_phone_country<>(typeof(h.work_phone_country))'');
    populated_home_phone_pcnt := AVE(GROUP,IF(h.home_phone = (TYPEOF(h.home_phone))'',0,100));
    maxlength_home_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.home_phone)));
    avelength_home_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.home_phone)),h.home_phone<>(typeof(h.home_phone))'');
    populated_home_phone_country_pcnt := AVE(GROUP,IF(h.home_phone_country = (TYPEOF(h.home_phone_country))'',0,100));
    maxlength_home_phone_country := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.home_phone_country)));
    avelength_home_phone_country := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.home_phone_country)),h.home_phone_country<>(typeof(h.home_phone_country))'');
    populated_otp_language_pcnt := AVE(GROUP,IF(h.otp_language = (TYPEOF(h.otp_language))'',0,100));
    maxlength_otp_language := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_language)));
    avelength_otp_language := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.otp_language)),h.otp_language<>(typeof(h.otp_language))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_time_added_pcnt := AVE(GROUP,IF(h.time_added = (TYPEOF(h.time_added))'',0,100));
    maxlength_time_added := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.time_added)));
    avelength_time_added := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.time_added)),h.time_added<>(typeof(h.time_added))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_file_loaded_pcnt *   0.00 / 100 + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_time_pcnt *   0.00 / 100 + T.Populated_function_name_pcnt *   0.00 / 100 + T.Populated_account_id_pcnt *   0.00 / 100 + T.Populated_subject_id_pcnt *   0.00 / 100 + T.Populated_customer_subject_id_pcnt *   0.00 / 100 + T.Populated_otp_id_pcnt *   0.00 / 100 + T.Populated_verify_passed_pcnt *   0.00 / 100 + T.Populated_otp_delivery_method_pcnt *   0.00 / 100 + T.Populated_otp_preferred_delivery_pcnt *   0.00 / 100 + T.Populated_otp_phone_pcnt *   0.00 / 100 + T.Populated_otp_email_pcnt *   0.00 / 100 + T.Populated_reference_code_pcnt *   0.00 / 100 + T.Populated_product_id_pcnt *   0.00 / 100 + T.Populated_sub_product_id_pcnt *   0.00 / 100 + T.Populated_subject_unique_id_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_otp_type_pcnt *   0.00 / 100 + T.Populated_otp_length_pcnt *   0.00 / 100 + T.Populated_mobile_phone_pcnt *   0.00 / 100 + T.Populated_mobile_phone_country_pcnt *   0.00 / 100 + T.Populated_mobile_phone_carrier_pcnt *   0.00 / 100 + T.Populated_work_phone_pcnt *   0.00 / 100 + T.Populated_work_phone_country_pcnt *   0.00 / 100 + T.Populated_home_phone_pcnt *   0.00 / 100 + T.Populated_home_phone_country_pcnt *   0.00 / 100 + T.Populated_otp_language_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_time_added_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'date_file_loaded','transaction_id','event_date','event_time','function_name','account_id','subject_id','customer_subject_id','otp_id','verify_passed','otp_delivery_method','otp_preferred_delivery','otp_phone','otp_email','reference_code','product_id','sub_product_id','subject_unique_id','first_name','last_name','country','state','otp_type','otp_length','mobile_phone','mobile_phone_country','mobile_phone_carrier','work_phone','work_phone_country','home_phone','home_phone_country','otp_language','date_added','time_added');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_file_loaded_pcnt,le.populated_transaction_id_pcnt,le.populated_event_date_pcnt,le.populated_event_time_pcnt,le.populated_function_name_pcnt,le.populated_account_id_pcnt,le.populated_subject_id_pcnt,le.populated_customer_subject_id_pcnt,le.populated_otp_id_pcnt,le.populated_verify_passed_pcnt,le.populated_otp_delivery_method_pcnt,le.populated_otp_preferred_delivery_pcnt,le.populated_otp_phone_pcnt,le.populated_otp_email_pcnt,le.populated_reference_code_pcnt,le.populated_product_id_pcnt,le.populated_sub_product_id_pcnt,le.populated_subject_unique_id_pcnt,le.populated_first_name_pcnt,le.populated_last_name_pcnt,le.populated_country_pcnt,le.populated_state_pcnt,le.populated_otp_type_pcnt,le.populated_otp_length_pcnt,le.populated_mobile_phone_pcnt,le.populated_mobile_phone_country_pcnt,le.populated_mobile_phone_carrier_pcnt,le.populated_work_phone_pcnt,le.populated_work_phone_country_pcnt,le.populated_home_phone_pcnt,le.populated_home_phone_country_pcnt,le.populated_otp_language_pcnt,le.populated_date_added_pcnt,le.populated_time_added_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_file_loaded,le.maxlength_transaction_id,le.maxlength_event_date,le.maxlength_event_time,le.maxlength_function_name,le.maxlength_account_id,le.maxlength_subject_id,le.maxlength_customer_subject_id,le.maxlength_otp_id,le.maxlength_verify_passed,le.maxlength_otp_delivery_method,le.maxlength_otp_preferred_delivery,le.maxlength_otp_phone,le.maxlength_otp_email,le.maxlength_reference_code,le.maxlength_product_id,le.maxlength_sub_product_id,le.maxlength_subject_unique_id,le.maxlength_first_name,le.maxlength_last_name,le.maxlength_country,le.maxlength_state,le.maxlength_otp_type,le.maxlength_otp_length,le.maxlength_mobile_phone,le.maxlength_mobile_phone_country,le.maxlength_mobile_phone_carrier,le.maxlength_work_phone,le.maxlength_work_phone_country,le.maxlength_home_phone,le.maxlength_home_phone_country,le.maxlength_otp_language,le.maxlength_date_added,le.maxlength_time_added);
  SELF.avelength := CHOOSE(C,le.avelength_date_file_loaded,le.avelength_transaction_id,le.avelength_event_date,le.avelength_event_time,le.avelength_function_name,le.avelength_account_id,le.avelength_subject_id,le.avelength_customer_subject_id,le.avelength_otp_id,le.avelength_verify_passed,le.avelength_otp_delivery_method,le.avelength_otp_preferred_delivery,le.avelength_otp_phone,le.avelength_otp_email,le.avelength_reference_code,le.avelength_product_id,le.avelength_sub_product_id,le.avelength_subject_unique_id,le.avelength_first_name,le.avelength_last_name,le.avelength_country,le.avelength_state,le.avelength_otp_type,le.avelength_otp_length,le.avelength_mobile_phone,le.avelength_mobile_phone_country,le.avelength_mobile_phone_carrier,le.avelength_work_phone,le.avelength_work_phone_country,le.avelength_home_phone,le.avelength_home_phone_country,le.avelength_otp_language,le.avelength_date_added,le.avelength_time_added);
END;
EXPORT invSummary := NORMALIZE(summary0, 34, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.transaction_id),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.function_name),TRIM((SALT36.StrType)le.account_id),TRIM((SALT36.StrType)le.subject_id),TRIM((SALT36.StrType)le.customer_subject_id),TRIM((SALT36.StrType)le.otp_id),TRIM((SALT36.StrType)le.verify_passed),TRIM((SALT36.StrType)le.otp_delivery_method),TRIM((SALT36.StrType)le.otp_preferred_delivery),TRIM((SALT36.StrType)le.otp_phone),TRIM((SALT36.StrType)le.otp_email),TRIM((SALT36.StrType)le.reference_code),IF (le.product_id <> 0,TRIM((SALT36.StrType)le.product_id), ''),IF (le.sub_product_id <> 0,TRIM((SALT36.StrType)le.sub_product_id), ''),TRIM((SALT36.StrType)le.subject_unique_id),TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.otp_type),IF (le.otp_length <> 0,TRIM((SALT36.StrType)le.otp_length), ''),TRIM((SALT36.StrType)le.mobile_phone),TRIM((SALT36.StrType)le.mobile_phone_country),TRIM((SALT36.StrType)le.mobile_phone_carrier),TRIM((SALT36.StrType)le.work_phone),TRIM((SALT36.StrType)le.work_phone_country),TRIM((SALT36.StrType)le.home_phone),TRIM((SALT36.StrType)le.home_phone_country),TRIM((SALT36.StrType)le.otp_language),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,34,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 34);
  SELF.FldNo2 := 1 + (C % 34);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.transaction_id),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.function_name),TRIM((SALT36.StrType)le.account_id),TRIM((SALT36.StrType)le.subject_id),TRIM((SALT36.StrType)le.customer_subject_id),TRIM((SALT36.StrType)le.otp_id),TRIM((SALT36.StrType)le.verify_passed),TRIM((SALT36.StrType)le.otp_delivery_method),TRIM((SALT36.StrType)le.otp_preferred_delivery),TRIM((SALT36.StrType)le.otp_phone),TRIM((SALT36.StrType)le.otp_email),TRIM((SALT36.StrType)le.reference_code),IF (le.product_id <> 0,TRIM((SALT36.StrType)le.product_id), ''),IF (le.sub_product_id <> 0,TRIM((SALT36.StrType)le.sub_product_id), ''),TRIM((SALT36.StrType)le.subject_unique_id),TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.otp_type),IF (le.otp_length <> 0,TRIM((SALT36.StrType)le.otp_length), ''),TRIM((SALT36.StrType)le.mobile_phone),TRIM((SALT36.StrType)le.mobile_phone_country),TRIM((SALT36.StrType)le.mobile_phone_carrier),TRIM((SALT36.StrType)le.work_phone),TRIM((SALT36.StrType)le.work_phone_country),TRIM((SALT36.StrType)le.home_phone),TRIM((SALT36.StrType)le.home_phone_country),TRIM((SALT36.StrType)le.otp_language),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.date_file_loaded),TRIM((SALT36.StrType)le.transaction_id),TRIM((SALT36.StrType)le.event_date),TRIM((SALT36.StrType)le.event_time),TRIM((SALT36.StrType)le.function_name),TRIM((SALT36.StrType)le.account_id),TRIM((SALT36.StrType)le.subject_id),TRIM((SALT36.StrType)le.customer_subject_id),TRIM((SALT36.StrType)le.otp_id),TRIM((SALT36.StrType)le.verify_passed),TRIM((SALT36.StrType)le.otp_delivery_method),TRIM((SALT36.StrType)le.otp_preferred_delivery),TRIM((SALT36.StrType)le.otp_phone),TRIM((SALT36.StrType)le.otp_email),TRIM((SALT36.StrType)le.reference_code),IF (le.product_id <> 0,TRIM((SALT36.StrType)le.product_id), ''),IF (le.sub_product_id <> 0,TRIM((SALT36.StrType)le.sub_product_id), ''),TRIM((SALT36.StrType)le.subject_unique_id),TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.country),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.otp_type),IF (le.otp_length <> 0,TRIM((SALT36.StrType)le.otp_length), ''),TRIM((SALT36.StrType)le.mobile_phone),TRIM((SALT36.StrType)le.mobile_phone_country),TRIM((SALT36.StrType)le.mobile_phone_carrier),TRIM((SALT36.StrType)le.work_phone),TRIM((SALT36.StrType)le.work_phone_country),TRIM((SALT36.StrType)le.home_phone),TRIM((SALT36.StrType)le.home_phone_country),TRIM((SALT36.StrType)le.otp_language),TRIM((SALT36.StrType)le.date_added),TRIM((SALT36.StrType)le.time_added)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),34*34,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_file_loaded'}
      ,{2,'transaction_id'}
      ,{3,'event_date'}
      ,{4,'event_time'}
      ,{5,'function_name'}
      ,{6,'account_id'}
      ,{7,'subject_id'}
      ,{8,'customer_subject_id'}
      ,{9,'otp_id'}
      ,{10,'verify_passed'}
      ,{11,'otp_delivery_method'}
      ,{12,'otp_preferred_delivery'}
      ,{13,'otp_phone'}
      ,{14,'otp_email'}
      ,{15,'reference_code'}
      ,{16,'product_id'}
      ,{17,'sub_product_id'}
      ,{18,'subject_unique_id'}
      ,{19,'first_name'}
      ,{20,'last_name'}
      ,{21,'country'}
      ,{22,'state'}
      ,{23,'otp_type'}
      ,{24,'otp_length'}
      ,{25,'mobile_phone'}
      ,{26,'mobile_phone_country'}
      ,{27,'mobile_phone_carrier'}
      ,{28,'work_phone'}
      ,{29,'work_phone_country'}
      ,{30,'home_phone'}
      ,{31,'home_phone_country'}
      ,{32,'otp_language'}
      ,{33,'date_added'}
      ,{34,'time_added'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BaseOTP_Fields.InValid_date_file_loaded((SALT36.StrType)le.date_file_loaded),
    BaseOTP_Fields.InValid_transaction_id((SALT36.StrType)le.transaction_id),
    BaseOTP_Fields.InValid_event_date((SALT36.StrType)le.event_date),
    BaseOTP_Fields.InValid_event_time((SALT36.StrType)le.event_time),
    BaseOTP_Fields.InValid_function_name((SALT36.StrType)le.function_name),
    BaseOTP_Fields.InValid_account_id((SALT36.StrType)le.account_id),
    BaseOTP_Fields.InValid_subject_id((SALT36.StrType)le.subject_id),
    BaseOTP_Fields.InValid_customer_subject_id((SALT36.StrType)le.customer_subject_id),
    BaseOTP_Fields.InValid_otp_id((SALT36.StrType)le.otp_id),
    BaseOTP_Fields.InValid_verify_passed((SALT36.StrType)le.verify_passed),
    BaseOTP_Fields.InValid_otp_delivery_method((SALT36.StrType)le.otp_delivery_method),
    BaseOTP_Fields.InValid_otp_preferred_delivery((SALT36.StrType)le.otp_preferred_delivery),
    BaseOTP_Fields.InValid_otp_phone((SALT36.StrType)le.otp_phone),
    BaseOTP_Fields.InValid_otp_email((SALT36.StrType)le.otp_email),
    BaseOTP_Fields.InValid_reference_code((SALT36.StrType)le.reference_code),
    BaseOTP_Fields.InValid_product_id((SALT36.StrType)le.product_id),
    BaseOTP_Fields.InValid_sub_product_id((SALT36.StrType)le.sub_product_id),
    BaseOTP_Fields.InValid_subject_unique_id((SALT36.StrType)le.subject_unique_id),
    BaseOTP_Fields.InValid_first_name((SALT36.StrType)le.first_name),
    BaseOTP_Fields.InValid_last_name((SALT36.StrType)le.last_name),
    BaseOTP_Fields.InValid_country((SALT36.StrType)le.country),
    BaseOTP_Fields.InValid_state((SALT36.StrType)le.state),
    BaseOTP_Fields.InValid_otp_type((SALT36.StrType)le.otp_type),
    BaseOTP_Fields.InValid_otp_length((SALT36.StrType)le.otp_length),
    BaseOTP_Fields.InValid_mobile_phone((SALT36.StrType)le.mobile_phone),
    BaseOTP_Fields.InValid_mobile_phone_country((SALT36.StrType)le.mobile_phone_country),
    BaseOTP_Fields.InValid_mobile_phone_carrier((SALT36.StrType)le.mobile_phone_carrier),
    BaseOTP_Fields.InValid_work_phone((SALT36.StrType)le.work_phone),
    BaseOTP_Fields.InValid_work_phone_country((SALT36.StrType)le.work_phone_country),
    BaseOTP_Fields.InValid_home_phone((SALT36.StrType)le.home_phone),
    BaseOTP_Fields.InValid_home_phone_country((SALT36.StrType)le.home_phone_country),
    BaseOTP_Fields.InValid_otp_language((SALT36.StrType)le.otp_language),
    BaseOTP_Fields.InValid_date_added((SALT36.StrType)le.date_added),
    BaseOTP_Fields.InValid_time_added((SALT36.StrType)le.time_added),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,34,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BaseOTP_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Trans_ID','Invalid_Date','Invalid_Num','Invalid_Function','Invalid_Num','Invalid_Num','Non_Blank','Invalid_Num','Non_Blank','Invalid_Delivery','Invalid_Delivery','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_OTP_Type','Invalid_OTP_Length','Invalid_Phone','Invalid_Country','Invalid_Carrier','Invalid_Phone','Invalid_Country','Invalid_Phone','Invalid_Country','Invalid_OTP_Language','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BaseOTP_Fields.InValidMessage_date_file_loaded(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_event_date(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_event_time(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_function_name(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_account_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_subject_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_customer_subject_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_verify_passed(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_delivery_method(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_preferred_delivery(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_phone(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_email(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_reference_code(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_product_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_sub_product_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_subject_unique_id(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_country(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_state(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_type(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_length(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_mobile_phone(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_mobile_phone_country(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_mobile_phone_carrier(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_work_phone(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_work_phone_country(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_home_phone(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_home_phone_country(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_otp_language(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),BaseOTP_Fields.InValidMessage_time_added(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

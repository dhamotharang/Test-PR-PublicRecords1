IMPORT SALT311,STD;
EXPORT Transactions_hygiene(dataset(Transactions_layout_PhoneFinder) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_transaction_id_cnt := COUNT(GROUP,h.transaction_id <> (TYPEOF(h.transaction_id))'');
    populated_transaction_id_pcnt := AVE(GROUP,IF(h.transaction_id = (TYPEOF(h.transaction_id))'',0,100));
    maxlength_transaction_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)));
    avelength_transaction_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_id)),h.transaction_id<>(typeof(h.transaction_id))'');
    populated_transaction_date_cnt := COUNT(GROUP,h.transaction_date <> (TYPEOF(h.transaction_date))'');
    populated_transaction_date_pcnt := AVE(GROUP,IF(h.transaction_date = (TYPEOF(h.transaction_date))'',0,100));
    maxlength_transaction_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)));
    avelength_transaction_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)),h.transaction_date<>(typeof(h.transaction_date))'');
    populated_user_id_cnt := COUNT(GROUP,h.user_id <> (TYPEOF(h.user_id))'');
    populated_user_id_pcnt := AVE(GROUP,IF(h.user_id = (TYPEOF(h.user_id))'',0,100));
    maxlength_user_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_id)));
    avelength_user_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.user_id)),h.user_id<>(typeof(h.user_id))'');
    populated_product_code_cnt := COUNT(GROUP,h.product_code <> (TYPEOF(h.product_code))'');
    populated_product_code_pcnt := AVE(GROUP,IF(h.product_code = (TYPEOF(h.product_code))'',0,100));
    maxlength_product_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_code)));
    avelength_product_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.product_code)),h.product_code<>(typeof(h.product_code))'');
    populated_company_id_cnt := COUNT(GROUP,h.company_id <> (TYPEOF(h.company_id))'');
    populated_company_id_pcnt := AVE(GROUP,IF(h.company_id = (TYPEOF(h.company_id))'',0,100));
    maxlength_company_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_id)));
    avelength_company_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_id)),h.company_id<>(typeof(h.company_id))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_batch_job_id_cnt := COUNT(GROUP,h.batch_job_id <> (TYPEOF(h.batch_job_id))'');
    populated_batch_job_id_pcnt := AVE(GROUP,IF(h.batch_job_id = (TYPEOF(h.batch_job_id))'',0,100));
    maxlength_batch_job_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_job_id)));
    avelength_batch_job_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_job_id)),h.batch_job_id<>(typeof(h.batch_job_id))'');
    populated_batch_acctno_cnt := COUNT(GROUP,h.batch_acctno <> (TYPEOF(h.batch_acctno))'');
    populated_batch_acctno_pcnt := AVE(GROUP,IF(h.batch_acctno = (TYPEOF(h.batch_acctno))'',0,100));
    maxlength_batch_acctno := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_acctno)));
    avelength_batch_acctno := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.batch_acctno)),h.batch_acctno<>(typeof(h.batch_acctno))'');
    populated_response_time_cnt := COUNT(GROUP,h.response_time <> (TYPEOF(h.response_time))'');
    populated_response_time_pcnt := AVE(GROUP,IF(h.response_time = (TYPEOF(h.response_time))'',0,100));
    maxlength_response_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.response_time)));
    avelength_response_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.response_time)),h.response_time<>(typeof(h.response_time))'');
    populated_reference_code_cnt := COUNT(GROUP,h.reference_code <> (TYPEOF(h.reference_code))'');
    populated_reference_code_pcnt := AVE(GROUP,IF(h.reference_code = (TYPEOF(h.reference_code))'',0,100));
    maxlength_reference_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference_code)));
    avelength_reference_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.reference_code)),h.reference_code<>(typeof(h.reference_code))'');
    populated_phonefinder_type_cnt := COUNT(GROUP,h.phonefinder_type <> (TYPEOF(h.phonefinder_type))'');
    populated_phonefinder_type_pcnt := AVE(GROUP,IF(h.phonefinder_type = (TYPEOF(h.phonefinder_type))'',0,100));
    maxlength_phonefinder_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonefinder_type)));
    avelength_phonefinder_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonefinder_type)),h.phonefinder_type<>(typeof(h.phonefinder_type))'');
    populated_submitted_lexid_cnt := COUNT(GROUP,h.submitted_lexid <> (TYPEOF(h.submitted_lexid))'');
    populated_submitted_lexid_pcnt := AVE(GROUP,IF(h.submitted_lexid = (TYPEOF(h.submitted_lexid))'',0,100));
    maxlength_submitted_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_lexid)));
    avelength_submitted_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_lexid)),h.submitted_lexid<>(typeof(h.submitted_lexid))'');
    populated_submitted_phonenumber_cnt := COUNT(GROUP,h.submitted_phonenumber <> (TYPEOF(h.submitted_phonenumber))'');
    populated_submitted_phonenumber_pcnt := AVE(GROUP,IF(h.submitted_phonenumber = (TYPEOF(h.submitted_phonenumber))'',0,100));
    maxlength_submitted_phonenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_phonenumber)));
    avelength_submitted_phonenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_phonenumber)),h.submitted_phonenumber<>(typeof(h.submitted_phonenumber))'');
    populated_submitted_firstname_cnt := COUNT(GROUP,h.submitted_firstname <> (TYPEOF(h.submitted_firstname))'');
    populated_submitted_firstname_pcnt := AVE(GROUP,IF(h.submitted_firstname = (TYPEOF(h.submitted_firstname))'',0,100));
    maxlength_submitted_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_firstname)));
    avelength_submitted_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_firstname)),h.submitted_firstname<>(typeof(h.submitted_firstname))'');
    populated_submitted_lastname_cnt := COUNT(GROUP,h.submitted_lastname <> (TYPEOF(h.submitted_lastname))'');
    populated_submitted_lastname_pcnt := AVE(GROUP,IF(h.submitted_lastname = (TYPEOF(h.submitted_lastname))'',0,100));
    maxlength_submitted_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_lastname)));
    avelength_submitted_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_lastname)),h.submitted_lastname<>(typeof(h.submitted_lastname))'');
    populated_submitted_middlename_cnt := COUNT(GROUP,h.submitted_middlename <> (TYPEOF(h.submitted_middlename))'');
    populated_submitted_middlename_pcnt := AVE(GROUP,IF(h.submitted_middlename = (TYPEOF(h.submitted_middlename))'',0,100));
    maxlength_submitted_middlename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_middlename)));
    avelength_submitted_middlename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_middlename)),h.submitted_middlename<>(typeof(h.submitted_middlename))'');
    populated_submitted_streetaddress1_cnt := COUNT(GROUP,h.submitted_streetaddress1 <> (TYPEOF(h.submitted_streetaddress1))'');
    populated_submitted_streetaddress1_pcnt := AVE(GROUP,IF(h.submitted_streetaddress1 = (TYPEOF(h.submitted_streetaddress1))'',0,100));
    maxlength_submitted_streetaddress1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_streetaddress1)));
    avelength_submitted_streetaddress1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_streetaddress1)),h.submitted_streetaddress1<>(typeof(h.submitted_streetaddress1))'');
    populated_submitted_city_cnt := COUNT(GROUP,h.submitted_city <> (TYPEOF(h.submitted_city))'');
    populated_submitted_city_pcnt := AVE(GROUP,IF(h.submitted_city = (TYPEOF(h.submitted_city))'',0,100));
    maxlength_submitted_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_city)));
    avelength_submitted_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_city)),h.submitted_city<>(typeof(h.submitted_city))'');
    populated_submitted_state_cnt := COUNT(GROUP,h.submitted_state <> (TYPEOF(h.submitted_state))'');
    populated_submitted_state_pcnt := AVE(GROUP,IF(h.submitted_state = (TYPEOF(h.submitted_state))'',0,100));
    maxlength_submitted_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_state)));
    avelength_submitted_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_state)),h.submitted_state<>(typeof(h.submitted_state))'');
    populated_submitted_zip_cnt := COUNT(GROUP,h.submitted_zip <> (TYPEOF(h.submitted_zip))'');
    populated_submitted_zip_pcnt := AVE(GROUP,IF(h.submitted_zip = (TYPEOF(h.submitted_zip))'',0,100));
    maxlength_submitted_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_zip)));
    avelength_submitted_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.submitted_zip)),h.submitted_zip<>(typeof(h.submitted_zip))'');
    populated_phonenumber_cnt := COUNT(GROUP,h.phonenumber <> (TYPEOF(h.phonenumber))'');
    populated_phonenumber_pcnt := AVE(GROUP,IF(h.phonenumber = (TYPEOF(h.phonenumber))'',0,100));
    maxlength_phonenumber := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)));
    avelength_phonenumber := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phonenumber)),h.phonenumber<>(typeof(h.phonenumber))'');
    populated_data_source_cnt := COUNT(GROUP,h.data_source <> (TYPEOF(h.data_source))'');
    populated_data_source_pcnt := AVE(GROUP,IF(h.data_source = (TYPEOF(h.data_source))'',0,100));
    maxlength_data_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_source)));
    avelength_data_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_source)),h.data_source<>(typeof(h.data_source))'');
    populated_royalty_used_cnt := COUNT(GROUP,h.royalty_used <> (TYPEOF(h.royalty_used))'');
    populated_royalty_used_pcnt := AVE(GROUP,IF(h.royalty_used = (TYPEOF(h.royalty_used))'',0,100));
    maxlength_royalty_used := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.royalty_used)));
    avelength_royalty_used := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.royalty_used)),h.royalty_used<>(typeof(h.royalty_used))'');
    populated_carrier_cnt := COUNT(GROUP,h.carrier <> (TYPEOF(h.carrier))'');
    populated_carrier_pcnt := AVE(GROUP,IF(h.carrier = (TYPEOF(h.carrier))'',0,100));
    maxlength_carrier := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier)));
    avelength_carrier := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier)),h.carrier<>(typeof(h.carrier))'');
    populated_risk_indicator_cnt := COUNT(GROUP,h.risk_indicator <> (TYPEOF(h.risk_indicator))'');
    populated_risk_indicator_pcnt := AVE(GROUP,IF(h.risk_indicator = (TYPEOF(h.risk_indicator))'',0,100));
    maxlength_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator)));
    avelength_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.risk_indicator)),h.risk_indicator<>(typeof(h.risk_indicator))'');
    populated_phone_type_cnt := COUNT(GROUP,h.phone_type <> (TYPEOF(h.phone_type))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_phone_status_cnt := COUNT(GROUP,h.phone_status <> (TYPEOF(h.phone_status))'');
    populated_phone_status_pcnt := AVE(GROUP,IF(h.phone_status = (TYPEOF(h.phone_status))'',0,100));
    maxlength_phone_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_status)));
    avelength_phone_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_status)),h.phone_status<>(typeof(h.phone_status))'');
    populated_ported_count_cnt := COUNT(GROUP,h.ported_count <> (TYPEOF(h.ported_count))'');
    populated_ported_count_pcnt := AVE(GROUP,IF(h.ported_count = (TYPEOF(h.ported_count))'',0,100));
    maxlength_ported_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ported_count)));
    avelength_ported_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ported_count)),h.ported_count<>(typeof(h.ported_count))'');
    populated_last_ported_date_cnt := COUNT(GROUP,h.last_ported_date <> (TYPEOF(h.last_ported_date))'');
    populated_last_ported_date_pcnt := AVE(GROUP,IF(h.last_ported_date = (TYPEOF(h.last_ported_date))'',0,100));
    maxlength_last_ported_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_ported_date)));
    avelength_last_ported_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_ported_date)),h.last_ported_date<>(typeof(h.last_ported_date))'');
    populated_otp_count_cnt := COUNT(GROUP,h.otp_count <> (TYPEOF(h.otp_count))'');
    populated_otp_count_pcnt := AVE(GROUP,IF(h.otp_count = (TYPEOF(h.otp_count))'',0,100));
    maxlength_otp_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.otp_count)));
    avelength_otp_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.otp_count)),h.otp_count<>(typeof(h.otp_count))'');
    populated_last_otp_date_cnt := COUNT(GROUP,h.last_otp_date <> (TYPEOF(h.last_otp_date))'');
    populated_last_otp_date_pcnt := AVE(GROUP,IF(h.last_otp_date = (TYPEOF(h.last_otp_date))'',0,100));
    maxlength_last_otp_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_otp_date)));
    avelength_last_otp_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_otp_date)),h.last_otp_date<>(typeof(h.last_otp_date))'');
    populated_spoof_count_cnt := COUNT(GROUP,h.spoof_count <> (TYPEOF(h.spoof_count))'');
    populated_spoof_count_pcnt := AVE(GROUP,IF(h.spoof_count = (TYPEOF(h.spoof_count))'',0,100));
    maxlength_spoof_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spoof_count)));
    avelength_spoof_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spoof_count)),h.spoof_count<>(typeof(h.spoof_count))'');
    populated_last_spoof_date_cnt := COUNT(GROUP,h.last_spoof_date <> (TYPEOF(h.last_spoof_date))'');
    populated_last_spoof_date_pcnt := AVE(GROUP,IF(h.last_spoof_date = (TYPEOF(h.last_spoof_date))'',0,100));
    maxlength_last_spoof_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_spoof_date)));
    avelength_last_spoof_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_spoof_date)),h.last_spoof_date<>(typeof(h.last_spoof_date))'');
    populated_phone_forwarded_cnt := COUNT(GROUP,h.phone_forwarded <> (TYPEOF(h.phone_forwarded))'');
    populated_phone_forwarded_pcnt := AVE(GROUP,IF(h.phone_forwarded = (TYPEOF(h.phone_forwarded))'',0,100));
    maxlength_phone_forwarded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_forwarded)));
    avelength_phone_forwarded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_forwarded)),h.phone_forwarded<>(typeof(h.phone_forwarded))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_identity_count_cnt := COUNT(GROUP,h.identity_count <> (TYPEOF(h.identity_count))'');
    populated_identity_count_pcnt := AVE(GROUP,IF(h.identity_count = (TYPEOF(h.identity_count))'',0,100));
    maxlength_identity_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_count)));
    avelength_identity_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.identity_count)),h.identity_count<>(typeof(h.identity_count))'');
    populated_phone_verified_cnt := COUNT(GROUP,h.phone_verified <> (TYPEOF(h.phone_verified))'');
    populated_phone_verified_pcnt := AVE(GROUP,IF(h.phone_verified = (TYPEOF(h.phone_verified))'',0,100));
    maxlength_phone_verified := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_verified)));
    avelength_phone_verified := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_verified)),h.phone_verified<>(typeof(h.phone_verified))'');
    populated_verification_type_cnt := COUNT(GROUP,h.verification_type <> (TYPEOF(h.verification_type))'');
    populated_verification_type_pcnt := AVE(GROUP,IF(h.verification_type = (TYPEOF(h.verification_type))'',0,100));
    maxlength_verification_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verification_type)));
    avelength_verification_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verification_type)),h.verification_type<>(typeof(h.verification_type))'');
    populated_phone_star_rating_cnt := COUNT(GROUP,h.phone_star_rating <> (TYPEOF(h.phone_star_rating))'');
    populated_phone_star_rating_pcnt := AVE(GROUP,IF(h.phone_star_rating = (TYPEOF(h.phone_star_rating))'',0,100));
    maxlength_phone_star_rating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_star_rating)));
    avelength_phone_star_rating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_star_rating)),h.phone_star_rating<>(typeof(h.phone_star_rating))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_transaction_id_pcnt *   0.00 / 100 + T.Populated_transaction_date_pcnt *   0.00 / 100 + T.Populated_user_id_pcnt *   0.00 / 100 + T.Populated_product_code_pcnt *   0.00 / 100 + T.Populated_company_id_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_batch_job_id_pcnt *   0.00 / 100 + T.Populated_batch_acctno_pcnt *   0.00 / 100 + T.Populated_response_time_pcnt *   0.00 / 100 + T.Populated_reference_code_pcnt *   0.00 / 100 + T.Populated_phonefinder_type_pcnt *   0.00 / 100 + T.Populated_submitted_lexid_pcnt *   0.00 / 100 + T.Populated_submitted_phonenumber_pcnt *   0.00 / 100 + T.Populated_submitted_firstname_pcnt *   0.00 / 100 + T.Populated_submitted_lastname_pcnt *   0.00 / 100 + T.Populated_submitted_middlename_pcnt *   0.00 / 100 + T.Populated_submitted_streetaddress1_pcnt *   0.00 / 100 + T.Populated_submitted_city_pcnt *   0.00 / 100 + T.Populated_submitted_state_pcnt *   0.00 / 100 + T.Populated_submitted_zip_pcnt *   0.00 / 100 + T.Populated_phonenumber_pcnt *   0.00 / 100 + T.Populated_data_source_pcnt *   0.00 / 100 + T.Populated_royalty_used_pcnt *   0.00 / 100 + T.Populated_carrier_pcnt *   0.00 / 100 + T.Populated_risk_indicator_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_phone_status_pcnt *   0.00 / 100 + T.Populated_ported_count_pcnt *   0.00 / 100 + T.Populated_last_ported_date_pcnt *   0.00 / 100 + T.Populated_otp_count_pcnt *   0.00 / 100 + T.Populated_last_otp_date_pcnt *   0.00 / 100 + T.Populated_spoof_count_pcnt *   0.00 / 100 + T.Populated_last_spoof_date_pcnt *   0.00 / 100 + T.Populated_phone_forwarded_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_identity_count_pcnt *   0.00 / 100 + T.Populated_phone_verified_pcnt *   0.00 / 100 + T.Populated_verification_type_pcnt *   0.00 / 100 + T.Populated_phone_star_rating_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'transaction_id','transaction_date','user_id','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','reference_code','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','submitted_streetaddress1','submitted_city','submitted_state','submitted_zip','phonenumber','data_source','royalty_used','carrier','risk_indicator','phone_type','phone_status','ported_count','last_ported_date','otp_count','last_otp_date','spoof_count','last_spoof_date','phone_forwarded','date_added','identity_count','phone_verified','verification_type','phone_star_rating','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_transaction_id_pcnt,le.populated_transaction_date_pcnt,le.populated_user_id_pcnt,le.populated_product_code_pcnt,le.populated_company_id_pcnt,le.populated_source_code_pcnt,le.populated_batch_job_id_pcnt,le.populated_batch_acctno_pcnt,le.populated_response_time_pcnt,le.populated_reference_code_pcnt,le.populated_phonefinder_type_pcnt,le.populated_submitted_lexid_pcnt,le.populated_submitted_phonenumber_pcnt,le.populated_submitted_firstname_pcnt,le.populated_submitted_lastname_pcnt,le.populated_submitted_middlename_pcnt,le.populated_submitted_streetaddress1_pcnt,le.populated_submitted_city_pcnt,le.populated_submitted_state_pcnt,le.populated_submitted_zip_pcnt,le.populated_phonenumber_pcnt,le.populated_data_source_pcnt,le.populated_royalty_used_pcnt,le.populated_carrier_pcnt,le.populated_risk_indicator_pcnt,le.populated_phone_type_pcnt,le.populated_phone_status_pcnt,le.populated_ported_count_pcnt,le.populated_last_ported_date_pcnt,le.populated_otp_count_pcnt,le.populated_last_otp_date_pcnt,le.populated_spoof_count_pcnt,le.populated_last_spoof_date_pcnt,le.populated_phone_forwarded_pcnt,le.populated_date_added_pcnt,le.populated_identity_count_pcnt,le.populated_phone_verified_pcnt,le.populated_verification_type_pcnt,le.populated_phone_star_rating_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_transaction_id,le.maxlength_transaction_date,le.maxlength_user_id,le.maxlength_product_code,le.maxlength_company_id,le.maxlength_source_code,le.maxlength_batch_job_id,le.maxlength_batch_acctno,le.maxlength_response_time,le.maxlength_reference_code,le.maxlength_phonefinder_type,le.maxlength_submitted_lexid,le.maxlength_submitted_phonenumber,le.maxlength_submitted_firstname,le.maxlength_submitted_lastname,le.maxlength_submitted_middlename,le.maxlength_submitted_streetaddress1,le.maxlength_submitted_city,le.maxlength_submitted_state,le.maxlength_submitted_zip,le.maxlength_phonenumber,le.maxlength_data_source,le.maxlength_royalty_used,le.maxlength_carrier,le.maxlength_risk_indicator,le.maxlength_phone_type,le.maxlength_phone_status,le.maxlength_ported_count,le.maxlength_last_ported_date,le.maxlength_otp_count,le.maxlength_last_otp_date,le.maxlength_spoof_count,le.maxlength_last_spoof_date,le.maxlength_phone_forwarded,le.maxlength_date_added,le.maxlength_identity_count,le.maxlength_phone_verified,le.maxlength_verification_type,le.maxlength_phone_star_rating,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_transaction_id,le.avelength_transaction_date,le.avelength_user_id,le.avelength_product_code,le.avelength_company_id,le.avelength_source_code,le.avelength_batch_job_id,le.avelength_batch_acctno,le.avelength_response_time,le.avelength_reference_code,le.avelength_phonefinder_type,le.avelength_submitted_lexid,le.avelength_submitted_phonenumber,le.avelength_submitted_firstname,le.avelength_submitted_lastname,le.avelength_submitted_middlename,le.avelength_submitted_streetaddress1,le.avelength_submitted_city,le.avelength_submitted_state,le.avelength_submitted_zip,le.avelength_phonenumber,le.avelength_data_source,le.avelength_royalty_used,le.avelength_carrier,le.avelength_risk_indicator,le.avelength_phone_type,le.avelength_phone_status,le.avelength_ported_count,le.avelength_last_ported_date,le.avelength_otp_count,le.avelength_last_otp_date,le.avelength_spoof_count,le.avelength_last_spoof_date,le.avelength_phone_forwarded,le.avelength_date_added,le.avelength_identity_count,le.avelength_phone_verified,le.avelength_verification_type,le.avelength_phone_star_rating,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.user_id),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.batch_job_id),IF (le.batch_acctno <> 0,TRIM((SALT311.StrType)le.batch_acctno), ''),IF (le.response_time <> 0,TRIM((SALT311.StrType)le.response_time), ''),TRIM((SALT311.StrType)le.reference_code),TRIM((SALT311.StrType)le.phonefinder_type),TRIM((SALT311.StrType)le.submitted_lexid),TRIM((SALT311.StrType)le.submitted_phonenumber),TRIM((SALT311.StrType)le.submitted_firstname),TRIM((SALT311.StrType)le.submitted_lastname),TRIM((SALT311.StrType)le.submitted_middlename),TRIM((SALT311.StrType)le.submitted_streetaddress1),TRIM((SALT311.StrType)le.submitted_city),TRIM((SALT311.StrType)le.submitted_state),TRIM((SALT311.StrType)le.submitted_zip),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.data_source),TRIM((SALT311.StrType)le.royalty_used),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),IF (le.ported_count <> 0,TRIM((SALT311.StrType)le.ported_count), ''),TRIM((SALT311.StrType)le.last_ported_date),IF (le.otp_count <> 0,TRIM((SALT311.StrType)le.otp_count), ''),TRIM((SALT311.StrType)le.last_otp_date),IF (le.spoof_count <> 0,TRIM((SALT311.StrType)le.spoof_count), ''),TRIM((SALT311.StrType)le.last_spoof_date),TRIM((SALT311.StrType)le.phone_forwarded),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.phone_verified),TRIM((SALT311.StrType)le.verification_type),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.user_id),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.batch_job_id),IF (le.batch_acctno <> 0,TRIM((SALT311.StrType)le.batch_acctno), ''),IF (le.response_time <> 0,TRIM((SALT311.StrType)le.response_time), ''),TRIM((SALT311.StrType)le.reference_code),TRIM((SALT311.StrType)le.phonefinder_type),TRIM((SALT311.StrType)le.submitted_lexid),TRIM((SALT311.StrType)le.submitted_phonenumber),TRIM((SALT311.StrType)le.submitted_firstname),TRIM((SALT311.StrType)le.submitted_lastname),TRIM((SALT311.StrType)le.submitted_middlename),TRIM((SALT311.StrType)le.submitted_streetaddress1),TRIM((SALT311.StrType)le.submitted_city),TRIM((SALT311.StrType)le.submitted_state),TRIM((SALT311.StrType)le.submitted_zip),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.data_source),TRIM((SALT311.StrType)le.royalty_used),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),IF (le.ported_count <> 0,TRIM((SALT311.StrType)le.ported_count), ''),TRIM((SALT311.StrType)le.last_ported_date),IF (le.otp_count <> 0,TRIM((SALT311.StrType)le.otp_count), ''),TRIM((SALT311.StrType)le.last_otp_date),IF (le.spoof_count <> 0,TRIM((SALT311.StrType)le.spoof_count), ''),TRIM((SALT311.StrType)le.last_spoof_date),TRIM((SALT311.StrType)le.phone_forwarded),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.phone_verified),TRIM((SALT311.StrType)le.verification_type),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.transaction_id),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.user_id),TRIM((SALT311.StrType)le.product_code),TRIM((SALT311.StrType)le.company_id),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.batch_job_id),IF (le.batch_acctno <> 0,TRIM((SALT311.StrType)le.batch_acctno), ''),IF (le.response_time <> 0,TRIM((SALT311.StrType)le.response_time), ''),TRIM((SALT311.StrType)le.reference_code),TRIM((SALT311.StrType)le.phonefinder_type),TRIM((SALT311.StrType)le.submitted_lexid),TRIM((SALT311.StrType)le.submitted_phonenumber),TRIM((SALT311.StrType)le.submitted_firstname),TRIM((SALT311.StrType)le.submitted_lastname),TRIM((SALT311.StrType)le.submitted_middlename),TRIM((SALT311.StrType)le.submitted_streetaddress1),TRIM((SALT311.StrType)le.submitted_city),TRIM((SALT311.StrType)le.submitted_state),TRIM((SALT311.StrType)le.submitted_zip),TRIM((SALT311.StrType)le.phonenumber),TRIM((SALT311.StrType)le.data_source),TRIM((SALT311.StrType)le.royalty_used),TRIM((SALT311.StrType)le.carrier),TRIM((SALT311.StrType)le.risk_indicator),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.phone_status),IF (le.ported_count <> 0,TRIM((SALT311.StrType)le.ported_count), ''),TRIM((SALT311.StrType)le.last_ported_date),IF (le.otp_count <> 0,TRIM((SALT311.StrType)le.otp_count), ''),TRIM((SALT311.StrType)le.last_otp_date),IF (le.spoof_count <> 0,TRIM((SALT311.StrType)le.spoof_count), ''),TRIM((SALT311.StrType)le.last_spoof_date),TRIM((SALT311.StrType)le.phone_forwarded),TRIM((SALT311.StrType)le.date_added),IF (le.identity_count <> 0,TRIM((SALT311.StrType)le.identity_count), ''),TRIM((SALT311.StrType)le.phone_verified),TRIM((SALT311.StrType)le.verification_type),TRIM((SALT311.StrType)le.phone_star_rating),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'transaction_id'}
      ,{2,'transaction_date'}
      ,{3,'user_id'}
      ,{4,'product_code'}
      ,{5,'company_id'}
      ,{6,'source_code'}
      ,{7,'batch_job_id'}
      ,{8,'batch_acctno'}
      ,{9,'response_time'}
      ,{10,'reference_code'}
      ,{11,'phonefinder_type'}
      ,{12,'submitted_lexid'}
      ,{13,'submitted_phonenumber'}
      ,{14,'submitted_firstname'}
      ,{15,'submitted_lastname'}
      ,{16,'submitted_middlename'}
      ,{17,'submitted_streetaddress1'}
      ,{18,'submitted_city'}
      ,{19,'submitted_state'}
      ,{20,'submitted_zip'}
      ,{21,'phonenumber'}
      ,{22,'data_source'}
      ,{23,'royalty_used'}
      ,{24,'carrier'}
      ,{25,'risk_indicator'}
      ,{26,'phone_type'}
      ,{27,'phone_status'}
      ,{28,'ported_count'}
      ,{29,'last_ported_date'}
      ,{30,'otp_count'}
      ,{31,'last_otp_date'}
      ,{32,'spoof_count'}
      ,{33,'last_spoof_date'}
      ,{34,'phone_forwarded'}
      ,{35,'date_added'}
      ,{36,'identity_count'}
      ,{37,'phone_verified'}
      ,{38,'verification_type'}
      ,{39,'phone_star_rating'}
      ,{40,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Transactions_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id),
    Transactions_Fields.InValid_transaction_date((SALT311.StrType)le.transaction_date),
    Transactions_Fields.InValid_user_id((SALT311.StrType)le.user_id),
    Transactions_Fields.InValid_product_code((SALT311.StrType)le.product_code),
    Transactions_Fields.InValid_company_id((SALT311.StrType)le.company_id),
    Transactions_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Transactions_Fields.InValid_batch_job_id((SALT311.StrType)le.batch_job_id),
    Transactions_Fields.InValid_batch_acctno((SALT311.StrType)le.batch_acctno),
    Transactions_Fields.InValid_response_time((SALT311.StrType)le.response_time),
    Transactions_Fields.InValid_reference_code((SALT311.StrType)le.reference_code),
    Transactions_Fields.InValid_phonefinder_type((SALT311.StrType)le.phonefinder_type),
    Transactions_Fields.InValid_submitted_lexid((SALT311.StrType)le.submitted_lexid),
    Transactions_Fields.InValid_submitted_phonenumber((SALT311.StrType)le.submitted_phonenumber),
    Transactions_Fields.InValid_submitted_firstname((SALT311.StrType)le.submitted_firstname),
    Transactions_Fields.InValid_submitted_lastname((SALT311.StrType)le.submitted_lastname),
    Transactions_Fields.InValid_submitted_middlename((SALT311.StrType)le.submitted_middlename),
    Transactions_Fields.InValid_submitted_streetaddress1((SALT311.StrType)le.submitted_streetaddress1),
    Transactions_Fields.InValid_submitted_city((SALT311.StrType)le.submitted_city),
    Transactions_Fields.InValid_submitted_state((SALT311.StrType)le.submitted_state),
    Transactions_Fields.InValid_submitted_zip((SALT311.StrType)le.submitted_zip),
    Transactions_Fields.InValid_phonenumber((SALT311.StrType)le.phonenumber),
    Transactions_Fields.InValid_data_source((SALT311.StrType)le.data_source),
    Transactions_Fields.InValid_royalty_used((SALT311.StrType)le.royalty_used),
    Transactions_Fields.InValid_carrier((SALT311.StrType)le.carrier),
    Transactions_Fields.InValid_risk_indicator((SALT311.StrType)le.risk_indicator),
    Transactions_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    Transactions_Fields.InValid_phone_status((SALT311.StrType)le.phone_status),
    Transactions_Fields.InValid_ported_count((SALT311.StrType)le.ported_count),
    Transactions_Fields.InValid_last_ported_date((SALT311.StrType)le.last_ported_date),
    Transactions_Fields.InValid_otp_count((SALT311.StrType)le.otp_count),
    Transactions_Fields.InValid_last_otp_date((SALT311.StrType)le.last_otp_date),
    Transactions_Fields.InValid_spoof_count((SALT311.StrType)le.spoof_count),
    Transactions_Fields.InValid_last_spoof_date((SALT311.StrType)le.last_spoof_date),
    Transactions_Fields.InValid_phone_forwarded((SALT311.StrType)le.phone_forwarded),
    Transactions_Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Transactions_Fields.InValid_identity_count((SALT311.StrType)le.identity_count),
    Transactions_Fields.InValid_phone_verified((SALT311.StrType)le.phone_verified),
    Transactions_Fields.InValid_verification_type((SALT311.StrType)le.verification_type),
    Transactions_Fields.InValid_phone_star_rating((SALT311.StrType)le.phone_star_rating),
    Transactions_Fields.InValid_filename((SALT311.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Transactions_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_ID','Invalid_Date','Unknown','Invalid_Alpha','Invalid_No','Invalid_Code','Invalid_Code','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_Alpha','Invalid_Code','Invalid_Code','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Unknown','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_Binary','Invalid_Alpha','Invalid_AlphaChar','Invalid_Risk','Invalid_Phone_Type','Invalid_Phone_Status','Invalid_No','Invalid_Date','Invalid_No','Invalid_Date','Invalid_No','Invalid_Date','Invalid_Forward','Unknown','Invalid_No','Invalid_Code','Invalid_AlphaChar','Invalid_Rating','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Transactions_Fields.InValidMessage_transaction_id(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_transaction_date(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_user_id(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_product_code(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_company_id(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_batch_job_id(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_batch_acctno(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_response_time(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_reference_code(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phonefinder_type(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_lexid(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_phonenumber(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_firstname(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_lastname(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_middlename(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_streetaddress1(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_city(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_state(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_submitted_zip(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phonenumber(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_data_source(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_royalty_used(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_carrier(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_risk_indicator(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phone_status(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_ported_count(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_last_ported_date(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_otp_count(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_last_otp_date(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_spoof_count(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_last_spoof_date(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phone_forwarded(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_identity_count(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phone_verified(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_verification_type(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_phone_star_rating(TotalErrors.ErrorNum),Transactions_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhoneFinder, Transactions_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

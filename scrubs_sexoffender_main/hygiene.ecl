IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_sexoffender_main) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.orig_state_code);    NumberOfRecords := COUNT(GROUP);
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_score_pcnt := AVE(GROUP,IF(h.score = (TYPEOF(h.score))'',0,100));
    maxlength_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)));
    avelength_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.score)),h.score<>(typeof(h.score))'');
    populated_ssn_appended_pcnt := AVE(GROUP,IF(h.ssn_appended = (TYPEOF(h.ssn_appended))'',0,100));
    maxlength_ssn_appended := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_appended)));
    avelength_ssn_appended := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_appended)),h.ssn_appended<>(typeof(h.ssn_appended))'');
    populated_ssn_perms_pcnt := AVE(GROUP,IF(h.ssn_perms = (TYPEOF(h.ssn_perms))'',0,100));
    maxlength_ssn_perms := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_perms)));
    avelength_ssn_perms := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn_perms)),h.ssn_perms<>(typeof(h.ssn_perms))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_state_code_pcnt := AVE(GROUP,IF(h.orig_state_code = (TYPEOF(h.orig_state_code))'',0,100));
    maxlength_orig_state_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state_code)));
    avelength_orig_state_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_state_code)),h.orig_state_code<>(typeof(h.orig_state_code))'');
    populated_seisint_primary_key_pcnt := AVE(GROUP,IF(h.seisint_primary_key = (TYPEOF(h.seisint_primary_key))'',0,100));
    maxlength_seisint_primary_key := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.seisint_primary_key)));
    avelength_seisint_primary_key := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.seisint_primary_key)),h.seisint_primary_key<>(typeof(h.seisint_primary_key))'');
    populated_vendor_code_pcnt := AVE(GROUP,IF(h.vendor_code = (TYPEOF(h.vendor_code))'',0,100));
    maxlength_vendor_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_code)));
    avelength_vendor_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_code)),h.vendor_code<>(typeof(h.vendor_code))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_name_orig_pcnt := AVE(GROUP,IF(h.name_orig = (TYPEOF(h.name_orig))'',0,100));
    maxlength_name_orig := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_orig)));
    avelength_name_orig := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_orig)),h.name_orig<>(typeof(h.name_orig))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_nid_pcnt := AVE(GROUP,IF(h.nid = (TYPEOF(h.nid))'',0,100));
    maxlength_nid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nid)));
    avelength_nid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nid)),h.nid<>(typeof(h.nid))'');
    populated_ntype_pcnt := AVE(GROUP,IF(h.ntype = (TYPEOF(h.ntype))'',0,100));
    maxlength_ntype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ntype)));
    avelength_ntype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ntype)),h.ntype<>(typeof(h.ntype))'');
    populated_nindicator_pcnt := AVE(GROUP,IF(h.nindicator = (TYPEOF(h.nindicator))'',0,100));
    maxlength_nindicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.nindicator)));
    avelength_nindicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.nindicator)),h.nindicator<>(typeof(h.nindicator))'');
    populated_intnet_email_address_1_pcnt := AVE(GROUP,IF(h.intnet_email_address_1 = (TYPEOF(h.intnet_email_address_1))'',0,100));
    maxlength_intnet_email_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_1)));
    avelength_intnet_email_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_1)),h.intnet_email_address_1<>(typeof(h.intnet_email_address_1))'');
    populated_intnet_email_address_2_pcnt := AVE(GROUP,IF(h.intnet_email_address_2 = (TYPEOF(h.intnet_email_address_2))'',0,100));
    maxlength_intnet_email_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_2)));
    avelength_intnet_email_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_2)),h.intnet_email_address_2<>(typeof(h.intnet_email_address_2))'');
    populated_intnet_email_address_3_pcnt := AVE(GROUP,IF(h.intnet_email_address_3 = (TYPEOF(h.intnet_email_address_3))'',0,100));
    maxlength_intnet_email_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_3)));
    avelength_intnet_email_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_3)),h.intnet_email_address_3<>(typeof(h.intnet_email_address_3))'');
    populated_intnet_email_address_4_pcnt := AVE(GROUP,IF(h.intnet_email_address_4 = (TYPEOF(h.intnet_email_address_4))'',0,100));
    maxlength_intnet_email_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_4)));
    avelength_intnet_email_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_4)),h.intnet_email_address_4<>(typeof(h.intnet_email_address_4))'');
    populated_intnet_email_address_5_pcnt := AVE(GROUP,IF(h.intnet_email_address_5 = (TYPEOF(h.intnet_email_address_5))'',0,100));
    maxlength_intnet_email_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_5)));
    avelength_intnet_email_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_email_address_5)),h.intnet_email_address_5<>(typeof(h.intnet_email_address_5))'');
    populated_intnet_instant_message_addr_1_pcnt := AVE(GROUP,IF(h.intnet_instant_message_addr_1 = (TYPEOF(h.intnet_instant_message_addr_1))'',0,100));
    maxlength_intnet_instant_message_addr_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_1)));
    avelength_intnet_instant_message_addr_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_1)),h.intnet_instant_message_addr_1<>(typeof(h.intnet_instant_message_addr_1))'');
    populated_intnet_instant_message_addr_2_pcnt := AVE(GROUP,IF(h.intnet_instant_message_addr_2 = (TYPEOF(h.intnet_instant_message_addr_2))'',0,100));
    maxlength_intnet_instant_message_addr_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_2)));
    avelength_intnet_instant_message_addr_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_2)),h.intnet_instant_message_addr_2<>(typeof(h.intnet_instant_message_addr_2))'');
    populated_intnet_instant_message_addr_3_pcnt := AVE(GROUP,IF(h.intnet_instant_message_addr_3 = (TYPEOF(h.intnet_instant_message_addr_3))'',0,100));
    maxlength_intnet_instant_message_addr_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_3)));
    avelength_intnet_instant_message_addr_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_3)),h.intnet_instant_message_addr_3<>(typeof(h.intnet_instant_message_addr_3))'');
    populated_intnet_instant_message_addr_4_pcnt := AVE(GROUP,IF(h.intnet_instant_message_addr_4 = (TYPEOF(h.intnet_instant_message_addr_4))'',0,100));
    maxlength_intnet_instant_message_addr_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_4)));
    avelength_intnet_instant_message_addr_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_4)),h.intnet_instant_message_addr_4<>(typeof(h.intnet_instant_message_addr_4))'');
    populated_intnet_instant_message_addr_5_pcnt := AVE(GROUP,IF(h.intnet_instant_message_addr_5 = (TYPEOF(h.intnet_instant_message_addr_5))'',0,100));
    maxlength_intnet_instant_message_addr_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_5)));
    avelength_intnet_instant_message_addr_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_instant_message_addr_5)),h.intnet_instant_message_addr_5<>(typeof(h.intnet_instant_message_addr_5))'');
    populated_intnet_user_name_1_pcnt := AVE(GROUP,IF(h.intnet_user_name_1 = (TYPEOF(h.intnet_user_name_1))'',0,100));
    maxlength_intnet_user_name_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_1)));
    avelength_intnet_user_name_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_1)),h.intnet_user_name_1<>(typeof(h.intnet_user_name_1))'');
    populated_intnet_user_name_1_url_pcnt := AVE(GROUP,IF(h.intnet_user_name_1_url = (TYPEOF(h.intnet_user_name_1_url))'',0,100));
    maxlength_intnet_user_name_1_url := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_1_url)));
    avelength_intnet_user_name_1_url := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_1_url)),h.intnet_user_name_1_url<>(typeof(h.intnet_user_name_1_url))'');
    populated_intnet_user_name_2_pcnt := AVE(GROUP,IF(h.intnet_user_name_2 = (TYPEOF(h.intnet_user_name_2))'',0,100));
    maxlength_intnet_user_name_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_2)));
    avelength_intnet_user_name_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_2)),h.intnet_user_name_2<>(typeof(h.intnet_user_name_2))'');
    populated_intnet_user_name_2_url_pcnt := AVE(GROUP,IF(h.intnet_user_name_2_url = (TYPEOF(h.intnet_user_name_2_url))'',0,100));
    maxlength_intnet_user_name_2_url := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_2_url)));
    avelength_intnet_user_name_2_url := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_2_url)),h.intnet_user_name_2_url<>(typeof(h.intnet_user_name_2_url))'');
    populated_intnet_user_name_3_pcnt := AVE(GROUP,IF(h.intnet_user_name_3 = (TYPEOF(h.intnet_user_name_3))'',0,100));
    maxlength_intnet_user_name_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_3)));
    avelength_intnet_user_name_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_3)),h.intnet_user_name_3<>(typeof(h.intnet_user_name_3))'');
    populated_intnet_user_name_3_url_pcnt := AVE(GROUP,IF(h.intnet_user_name_3_url = (TYPEOF(h.intnet_user_name_3_url))'',0,100));
    maxlength_intnet_user_name_3_url := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_3_url)));
    avelength_intnet_user_name_3_url := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_3_url)),h.intnet_user_name_3_url<>(typeof(h.intnet_user_name_3_url))'');
    populated_intnet_user_name_4_pcnt := AVE(GROUP,IF(h.intnet_user_name_4 = (TYPEOF(h.intnet_user_name_4))'',0,100));
    maxlength_intnet_user_name_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_4)));
    avelength_intnet_user_name_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_4)),h.intnet_user_name_4<>(typeof(h.intnet_user_name_4))'');
    populated_intnet_user_name_4_url_pcnt := AVE(GROUP,IF(h.intnet_user_name_4_url = (TYPEOF(h.intnet_user_name_4_url))'',0,100));
    maxlength_intnet_user_name_4_url := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_4_url)));
    avelength_intnet_user_name_4_url := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_4_url)),h.intnet_user_name_4_url<>(typeof(h.intnet_user_name_4_url))'');
    populated_intnet_user_name_5_pcnt := AVE(GROUP,IF(h.intnet_user_name_5 = (TYPEOF(h.intnet_user_name_5))'',0,100));
    maxlength_intnet_user_name_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_5)));
    avelength_intnet_user_name_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_5)),h.intnet_user_name_5<>(typeof(h.intnet_user_name_5))'');
    populated_intnet_user_name_5_url_pcnt := AVE(GROUP,IF(h.intnet_user_name_5_url = (TYPEOF(h.intnet_user_name_5_url))'',0,100));
    maxlength_intnet_user_name_5_url := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_5_url)));
    avelength_intnet_user_name_5_url := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.intnet_user_name_5_url)),h.intnet_user_name_5_url<>(typeof(h.intnet_user_name_5_url))'');
    populated_offender_status_pcnt := AVE(GROUP,IF(h.offender_status = (TYPEOF(h.offender_status))'',0,100));
    maxlength_offender_status := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_status)));
    avelength_offender_status := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_status)),h.offender_status<>(typeof(h.offender_status))'');
    populated_offender_category_pcnt := AVE(GROUP,IF(h.offender_category = (TYPEOF(h.offender_category))'',0,100));
    maxlength_offender_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_category)));
    avelength_offender_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_category)),h.offender_category<>(typeof(h.offender_category))'');
    populated_risk_level_code_pcnt := AVE(GROUP,IF(h.risk_level_code = (TYPEOF(h.risk_level_code))'',0,100));
    maxlength_risk_level_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.risk_level_code)));
    avelength_risk_level_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.risk_level_code)),h.risk_level_code<>(typeof(h.risk_level_code))'');
    populated_risk_description_pcnt := AVE(GROUP,IF(h.risk_description = (TYPEOF(h.risk_description))'',0,100));
    maxlength_risk_description := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.risk_description)));
    avelength_risk_description := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.risk_description)),h.risk_description<>(typeof(h.risk_description))'');
    populated_police_agency_pcnt := AVE(GROUP,IF(h.police_agency = (TYPEOF(h.police_agency))'',0,100));
    maxlength_police_agency := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency)));
    avelength_police_agency := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency)),h.police_agency<>(typeof(h.police_agency))'');
    populated_police_agency_contact_name_pcnt := AVE(GROUP,IF(h.police_agency_contact_name = (TYPEOF(h.police_agency_contact_name))'',0,100));
    maxlength_police_agency_contact_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_contact_name)));
    avelength_police_agency_contact_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_contact_name)),h.police_agency_contact_name<>(typeof(h.police_agency_contact_name))'');
    populated_police_agency_address_1_pcnt := AVE(GROUP,IF(h.police_agency_address_1 = (TYPEOF(h.police_agency_address_1))'',0,100));
    maxlength_police_agency_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_address_1)));
    avelength_police_agency_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_address_1)),h.police_agency_address_1<>(typeof(h.police_agency_address_1))'');
    populated_police_agency_address_2_pcnt := AVE(GROUP,IF(h.police_agency_address_2 = (TYPEOF(h.police_agency_address_2))'',0,100));
    maxlength_police_agency_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_address_2)));
    avelength_police_agency_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_address_2)),h.police_agency_address_2<>(typeof(h.police_agency_address_2))'');
    populated_police_agency_phone_pcnt := AVE(GROUP,IF(h.police_agency_phone = (TYPEOF(h.police_agency_phone))'',0,100));
    maxlength_police_agency_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_phone)));
    avelength_police_agency_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.police_agency_phone)),h.police_agency_phone<>(typeof(h.police_agency_phone))'');
    populated_registration_type_pcnt := AVE(GROUP,IF(h.registration_type = (TYPEOF(h.registration_type))'',0,100));
    maxlength_registration_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_type)));
    avelength_registration_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_type)),h.registration_type<>(typeof(h.registration_type))'');
    populated_reg_date_1_pcnt := AVE(GROUP,IF(h.reg_date_1 = (TYPEOF(h.reg_date_1))'',0,100));
    maxlength_reg_date_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_1)));
    avelength_reg_date_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_1)),h.reg_date_1<>(typeof(h.reg_date_1))'');
    populated_reg_date_1_type_pcnt := AVE(GROUP,IF(h.reg_date_1_type = (TYPEOF(h.reg_date_1_type))'',0,100));
    maxlength_reg_date_1_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_1_type)));
    avelength_reg_date_1_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_1_type)),h.reg_date_1_type<>(typeof(h.reg_date_1_type))'');
    populated_reg_date_2_pcnt := AVE(GROUP,IF(h.reg_date_2 = (TYPEOF(h.reg_date_2))'',0,100));
    maxlength_reg_date_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_2)));
    avelength_reg_date_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_2)),h.reg_date_2<>(typeof(h.reg_date_2))'');
    populated_reg_date_2_type_pcnt := AVE(GROUP,IF(h.reg_date_2_type = (TYPEOF(h.reg_date_2_type))'',0,100));
    maxlength_reg_date_2_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_2_type)));
    avelength_reg_date_2_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_2_type)),h.reg_date_2_type<>(typeof(h.reg_date_2_type))'');
    populated_reg_date_3_pcnt := AVE(GROUP,IF(h.reg_date_3 = (TYPEOF(h.reg_date_3))'',0,100));
    maxlength_reg_date_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_3)));
    avelength_reg_date_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_3)),h.reg_date_3<>(typeof(h.reg_date_3))'');
    populated_reg_date_3_type_pcnt := AVE(GROUP,IF(h.reg_date_3_type = (TYPEOF(h.reg_date_3_type))'',0,100));
    maxlength_reg_date_3_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_3_type)));
    avelength_reg_date_3_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reg_date_3_type)),h.reg_date_3_type<>(typeof(h.reg_date_3_type))'');
    populated_registration_address_1_pcnt := AVE(GROUP,IF(h.registration_address_1 = (TYPEOF(h.registration_address_1))'',0,100));
    maxlength_registration_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_1)));
    avelength_registration_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_1)),h.registration_address_1<>(typeof(h.registration_address_1))'');
    populated_registration_address_2_pcnt := AVE(GROUP,IF(h.registration_address_2 = (TYPEOF(h.registration_address_2))'',0,100));
    maxlength_registration_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_2)));
    avelength_registration_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_2)),h.registration_address_2<>(typeof(h.registration_address_2))'');
    populated_registration_address_3_pcnt := AVE(GROUP,IF(h.registration_address_3 = (TYPEOF(h.registration_address_3))'',0,100));
    maxlength_registration_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_3)));
    avelength_registration_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_3)),h.registration_address_3<>(typeof(h.registration_address_3))'');
    populated_registration_address_4_pcnt := AVE(GROUP,IF(h.registration_address_4 = (TYPEOF(h.registration_address_4))'',0,100));
    maxlength_registration_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_4)));
    avelength_registration_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_4)),h.registration_address_4<>(typeof(h.registration_address_4))'');
    populated_registration_address_5_pcnt := AVE(GROUP,IF(h.registration_address_5 = (TYPEOF(h.registration_address_5))'',0,100));
    maxlength_registration_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_5)));
    avelength_registration_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_address_5)),h.registration_address_5<>(typeof(h.registration_address_5))'');
    populated_registration_county_pcnt := AVE(GROUP,IF(h.registration_county = (TYPEOF(h.registration_county))'',0,100));
    maxlength_registration_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_county)));
    avelength_registration_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_county)),h.registration_county<>(typeof(h.registration_county))'');
    populated_registration_home_phone_pcnt := AVE(GROUP,IF(h.registration_home_phone = (TYPEOF(h.registration_home_phone))'',0,100));
    maxlength_registration_home_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_home_phone)));
    avelength_registration_home_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_home_phone)),h.registration_home_phone<>(typeof(h.registration_home_phone))'');
    populated_registration_cell_phone_pcnt := AVE(GROUP,IF(h.registration_cell_phone = (TYPEOF(h.registration_cell_phone))'',0,100));
    maxlength_registration_cell_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_cell_phone)));
    avelength_registration_cell_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.registration_cell_phone)),h.registration_cell_phone<>(typeof(h.registration_cell_phone))'');
    populated_other_registration_address_1_pcnt := AVE(GROUP,IF(h.other_registration_address_1 = (TYPEOF(h.other_registration_address_1))'',0,100));
    maxlength_other_registration_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_1)));
    avelength_other_registration_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_1)),h.other_registration_address_1<>(typeof(h.other_registration_address_1))'');
    populated_other_registration_address_2_pcnt := AVE(GROUP,IF(h.other_registration_address_2 = (TYPEOF(h.other_registration_address_2))'',0,100));
    maxlength_other_registration_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_2)));
    avelength_other_registration_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_2)),h.other_registration_address_2<>(typeof(h.other_registration_address_2))'');
    populated_other_registration_address_3_pcnt := AVE(GROUP,IF(h.other_registration_address_3 = (TYPEOF(h.other_registration_address_3))'',0,100));
    maxlength_other_registration_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_3)));
    avelength_other_registration_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_3)),h.other_registration_address_3<>(typeof(h.other_registration_address_3))'');
    populated_other_registration_address_4_pcnt := AVE(GROUP,IF(h.other_registration_address_4 = (TYPEOF(h.other_registration_address_4))'',0,100));
    maxlength_other_registration_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_4)));
    avelength_other_registration_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_4)),h.other_registration_address_4<>(typeof(h.other_registration_address_4))'');
    populated_other_registration_address_5_pcnt := AVE(GROUP,IF(h.other_registration_address_5 = (TYPEOF(h.other_registration_address_5))'',0,100));
    maxlength_other_registration_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_5)));
    avelength_other_registration_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_address_5)),h.other_registration_address_5<>(typeof(h.other_registration_address_5))'');
    populated_other_registration_county_pcnt := AVE(GROUP,IF(h.other_registration_county = (TYPEOF(h.other_registration_county))'',0,100));
    maxlength_other_registration_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_county)));
    avelength_other_registration_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_county)),h.other_registration_county<>(typeof(h.other_registration_county))'');
    populated_other_registration_phone_pcnt := AVE(GROUP,IF(h.other_registration_phone = (TYPEOF(h.other_registration_phone))'',0,100));
    maxlength_other_registration_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_phone)));
    avelength_other_registration_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.other_registration_phone)),h.other_registration_phone<>(typeof(h.other_registration_phone))'');
    populated_temp_lodge_address_1_pcnt := AVE(GROUP,IF(h.temp_lodge_address_1 = (TYPEOF(h.temp_lodge_address_1))'',0,100));
    maxlength_temp_lodge_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_1)));
    avelength_temp_lodge_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_1)),h.temp_lodge_address_1<>(typeof(h.temp_lodge_address_1))'');
    populated_temp_lodge_address_2_pcnt := AVE(GROUP,IF(h.temp_lodge_address_2 = (TYPEOF(h.temp_lodge_address_2))'',0,100));
    maxlength_temp_lodge_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_2)));
    avelength_temp_lodge_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_2)),h.temp_lodge_address_2<>(typeof(h.temp_lodge_address_2))'');
    populated_temp_lodge_address_3_pcnt := AVE(GROUP,IF(h.temp_lodge_address_3 = (TYPEOF(h.temp_lodge_address_3))'',0,100));
    maxlength_temp_lodge_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_3)));
    avelength_temp_lodge_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_3)),h.temp_lodge_address_3<>(typeof(h.temp_lodge_address_3))'');
    populated_temp_lodge_address_4_pcnt := AVE(GROUP,IF(h.temp_lodge_address_4 = (TYPEOF(h.temp_lodge_address_4))'',0,100));
    maxlength_temp_lodge_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_4)));
    avelength_temp_lodge_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_4)),h.temp_lodge_address_4<>(typeof(h.temp_lodge_address_4))'');
    populated_temp_lodge_address_5_pcnt := AVE(GROUP,IF(h.temp_lodge_address_5 = (TYPEOF(h.temp_lodge_address_5))'',0,100));
    maxlength_temp_lodge_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_5)));
    avelength_temp_lodge_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_address_5)),h.temp_lodge_address_5<>(typeof(h.temp_lodge_address_5))'');
    populated_temp_lodge_county_pcnt := AVE(GROUP,IF(h.temp_lodge_county = (TYPEOF(h.temp_lodge_county))'',0,100));
    maxlength_temp_lodge_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_county)));
    avelength_temp_lodge_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_county)),h.temp_lodge_county<>(typeof(h.temp_lodge_county))'');
    populated_temp_lodge_phone_pcnt := AVE(GROUP,IF(h.temp_lodge_phone = (TYPEOF(h.temp_lodge_phone))'',0,100));
    maxlength_temp_lodge_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_phone)));
    avelength_temp_lodge_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.temp_lodge_phone)),h.temp_lodge_phone<>(typeof(h.temp_lodge_phone))'');
    populated_employer_pcnt := AVE(GROUP,IF(h.employer = (TYPEOF(h.employer))'',0,100));
    maxlength_employer := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer)));
    avelength_employer := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer)),h.employer<>(typeof(h.employer))'');
    populated_employer_address_1_pcnt := AVE(GROUP,IF(h.employer_address_1 = (TYPEOF(h.employer_address_1))'',0,100));
    maxlength_employer_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_1)));
    avelength_employer_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_1)),h.employer_address_1<>(typeof(h.employer_address_1))'');
    populated_employer_address_2_pcnt := AVE(GROUP,IF(h.employer_address_2 = (TYPEOF(h.employer_address_2))'',0,100));
    maxlength_employer_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_2)));
    avelength_employer_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_2)),h.employer_address_2<>(typeof(h.employer_address_2))'');
    populated_employer_address_3_pcnt := AVE(GROUP,IF(h.employer_address_3 = (TYPEOF(h.employer_address_3))'',0,100));
    maxlength_employer_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_3)));
    avelength_employer_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_3)),h.employer_address_3<>(typeof(h.employer_address_3))'');
    populated_employer_address_4_pcnt := AVE(GROUP,IF(h.employer_address_4 = (TYPEOF(h.employer_address_4))'',0,100));
    maxlength_employer_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_4)));
    avelength_employer_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_4)),h.employer_address_4<>(typeof(h.employer_address_4))'');
    populated_employer_address_5_pcnt := AVE(GROUP,IF(h.employer_address_5 = (TYPEOF(h.employer_address_5))'',0,100));
    maxlength_employer_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_5)));
    avelength_employer_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_address_5)),h.employer_address_5<>(typeof(h.employer_address_5))'');
    populated_employer_county_pcnt := AVE(GROUP,IF(h.employer_county = (TYPEOF(h.employer_county))'',0,100));
    maxlength_employer_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_county)));
    avelength_employer_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_county)),h.employer_county<>(typeof(h.employer_county))'');
    populated_employer_phone_pcnt := AVE(GROUP,IF(h.employer_phone = (TYPEOF(h.employer_phone))'',0,100));
    maxlength_employer_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_phone)));
    avelength_employer_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_phone)),h.employer_phone<>(typeof(h.employer_phone))'');
    populated_employer_comments_pcnt := AVE(GROUP,IF(h.employer_comments = (TYPEOF(h.employer_comments))'',0,100));
    maxlength_employer_comments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_comments)));
    avelength_employer_comments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.employer_comments)),h.employer_comments<>(typeof(h.employer_comments))'');
    populated_professional_licenses_1_pcnt := AVE(GROUP,IF(h.professional_licenses_1 = (TYPEOF(h.professional_licenses_1))'',0,100));
    maxlength_professional_licenses_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_1)));
    avelength_professional_licenses_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_1)),h.professional_licenses_1<>(typeof(h.professional_licenses_1))'');
    populated_professional_licenses_2_pcnt := AVE(GROUP,IF(h.professional_licenses_2 = (TYPEOF(h.professional_licenses_2))'',0,100));
    maxlength_professional_licenses_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_2)));
    avelength_professional_licenses_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_2)),h.professional_licenses_2<>(typeof(h.professional_licenses_2))'');
    populated_professional_licenses_3_pcnt := AVE(GROUP,IF(h.professional_licenses_3 = (TYPEOF(h.professional_licenses_3))'',0,100));
    maxlength_professional_licenses_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_3)));
    avelength_professional_licenses_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_3)),h.professional_licenses_3<>(typeof(h.professional_licenses_3))'');
    populated_professional_licenses_4_pcnt := AVE(GROUP,IF(h.professional_licenses_4 = (TYPEOF(h.professional_licenses_4))'',0,100));
    maxlength_professional_licenses_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_4)));
    avelength_professional_licenses_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_4)),h.professional_licenses_4<>(typeof(h.professional_licenses_4))'');
    populated_professional_licenses_5_pcnt := AVE(GROUP,IF(h.professional_licenses_5 = (TYPEOF(h.professional_licenses_5))'',0,100));
    maxlength_professional_licenses_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_5)));
    avelength_professional_licenses_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.professional_licenses_5)),h.professional_licenses_5<>(typeof(h.professional_licenses_5))'');
    populated_school_pcnt := AVE(GROUP,IF(h.school = (TYPEOF(h.school))'',0,100));
    maxlength_school := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school)));
    avelength_school := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school)),h.school<>(typeof(h.school))'');
    populated_school_address_1_pcnt := AVE(GROUP,IF(h.school_address_1 = (TYPEOF(h.school_address_1))'',0,100));
    maxlength_school_address_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_1)));
    avelength_school_address_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_1)),h.school_address_1<>(typeof(h.school_address_1))'');
    populated_school_address_2_pcnt := AVE(GROUP,IF(h.school_address_2 = (TYPEOF(h.school_address_2))'',0,100));
    maxlength_school_address_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_2)));
    avelength_school_address_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_2)),h.school_address_2<>(typeof(h.school_address_2))'');
    populated_school_address_3_pcnt := AVE(GROUP,IF(h.school_address_3 = (TYPEOF(h.school_address_3))'',0,100));
    maxlength_school_address_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_3)));
    avelength_school_address_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_3)),h.school_address_3<>(typeof(h.school_address_3))'');
    populated_school_address_4_pcnt := AVE(GROUP,IF(h.school_address_4 = (TYPEOF(h.school_address_4))'',0,100));
    maxlength_school_address_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_4)));
    avelength_school_address_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_4)),h.school_address_4<>(typeof(h.school_address_4))'');
    populated_school_address_5_pcnt := AVE(GROUP,IF(h.school_address_5 = (TYPEOF(h.school_address_5))'',0,100));
    maxlength_school_address_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_5)));
    avelength_school_address_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_address_5)),h.school_address_5<>(typeof(h.school_address_5))'');
    populated_school_county_pcnt := AVE(GROUP,IF(h.school_county = (TYPEOF(h.school_county))'',0,100));
    maxlength_school_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_county)));
    avelength_school_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_county)),h.school_county<>(typeof(h.school_county))'');
    populated_school_phone_pcnt := AVE(GROUP,IF(h.school_phone = (TYPEOF(h.school_phone))'',0,100));
    maxlength_school_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_phone)));
    avelength_school_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_phone)),h.school_phone<>(typeof(h.school_phone))'');
    populated_school_comments_pcnt := AVE(GROUP,IF(h.school_comments = (TYPEOF(h.school_comments))'',0,100));
    maxlength_school_comments := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_comments)));
    avelength_school_comments := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.school_comments)),h.school_comments<>(typeof(h.school_comments))'');
    populated_offender_id_pcnt := AVE(GROUP,IF(h.offender_id = (TYPEOF(h.offender_id))'',0,100));
    maxlength_offender_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_id)));
    avelength_offender_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_id)),h.offender_id<>(typeof(h.offender_id))'');
    populated_doc_number_pcnt := AVE(GROUP,IF(h.doc_number = (TYPEOF(h.doc_number))'',0,100));
    maxlength_doc_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.doc_number)));
    avelength_doc_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.doc_number)),h.doc_number<>(typeof(h.doc_number))'');
    populated_sor_number_pcnt := AVE(GROUP,IF(h.sor_number = (TYPEOF(h.sor_number))'',0,100));
    maxlength_sor_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sor_number)));
    avelength_sor_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sor_number)),h.sor_number<>(typeof(h.sor_number))'');
    populated_st_id_number_pcnt := AVE(GROUP,IF(h.st_id_number = (TYPEOF(h.st_id_number))'',0,100));
    maxlength_st_id_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.st_id_number)));
    avelength_st_id_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.st_id_number)),h.st_id_number<>(typeof(h.st_id_number))'');
    populated_fbi_number_pcnt := AVE(GROUP,IF(h.fbi_number = (TYPEOF(h.fbi_number))'',0,100));
    maxlength_fbi_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbi_number)));
    avelength_fbi_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fbi_number)),h.fbi_number<>(typeof(h.fbi_number))'');
    populated_ncic_number_pcnt := AVE(GROUP,IF(h.ncic_number = (TYPEOF(h.ncic_number))'',0,100));
    maxlength_ncic_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ncic_number)));
    avelength_ncic_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ncic_number)),h.ncic_number<>(typeof(h.ncic_number))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_dob_aka_pcnt := AVE(GROUP,IF(h.dob_aka = (TYPEOF(h.dob_aka))'',0,100));
    maxlength_dob_aka := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob_aka)));
    avelength_dob_aka := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dob_aka)),h.dob_aka<>(typeof(h.dob_aka))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_dna_pcnt := AVE(GROUP,IF(h.dna = (TYPEOF(h.dna))'',0,100));
    maxlength_dna := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dna)));
    avelength_dna := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dna)),h.dna<>(typeof(h.dna))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_ethnicity_pcnt := AVE(GROUP,IF(h.ethnicity = (TYPEOF(h.ethnicity))'',0,100));
    maxlength_ethnicity := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ethnicity)));
    avelength_ethnicity := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ethnicity)),h.ethnicity<>(typeof(h.ethnicity))'');
    populated_sex_pcnt := AVE(GROUP,IF(h.sex = (TYPEOF(h.sex))'',0,100));
    maxlength_sex := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex)));
    avelength_sex := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sex)),h.sex<>(typeof(h.sex))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_skin_tone_pcnt := AVE(GROUP,IF(h.skin_tone = (TYPEOF(h.skin_tone))'',0,100));
    maxlength_skin_tone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_tone)));
    avelength_skin_tone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.skin_tone)),h.skin_tone<>(typeof(h.skin_tone))'');
    populated_build_type_pcnt := AVE(GROUP,IF(h.build_type = (TYPEOF(h.build_type))'',0,100));
    maxlength_build_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.build_type)));
    avelength_build_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.build_type)),h.build_type<>(typeof(h.build_type))'');
    populated_scars_marks_tattoos_pcnt := AVE(GROUP,IF(h.scars_marks_tattoos = (TYPEOF(h.scars_marks_tattoos))'',0,100));
    maxlength_scars_marks_tattoos := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos)));
    avelength_scars_marks_tattoos := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.scars_marks_tattoos)),h.scars_marks_tattoos<>(typeof(h.scars_marks_tattoos))'');
    populated_shoe_size_pcnt := AVE(GROUP,IF(h.shoe_size = (TYPEOF(h.shoe_size))'',0,100));
    maxlength_shoe_size := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.shoe_size)));
    avelength_shoe_size := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.shoe_size)),h.shoe_size<>(typeof(h.shoe_size))'');
    populated_corrective_lense_flag_pcnt := AVE(GROUP,IF(h.corrective_lense_flag = (TYPEOF(h.corrective_lense_flag))'',0,100));
    maxlength_corrective_lense_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.corrective_lense_flag)));
    avelength_corrective_lense_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.corrective_lense_flag)),h.corrective_lense_flag<>(typeof(h.corrective_lense_flag))'');
    populated_addl_comments_1_pcnt := AVE(GROUP,IF(h.addl_comments_1 = (TYPEOF(h.addl_comments_1))'',0,100));
    maxlength_addl_comments_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addl_comments_1)));
    avelength_addl_comments_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addl_comments_1)),h.addl_comments_1<>(typeof(h.addl_comments_1))'');
    populated_addl_comments_2_pcnt := AVE(GROUP,IF(h.addl_comments_2 = (TYPEOF(h.addl_comments_2))'',0,100));
    maxlength_addl_comments_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addl_comments_2)));
    avelength_addl_comments_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addl_comments_2)),h.addl_comments_2<>(typeof(h.addl_comments_2))'');
    populated_orig_dl_number_pcnt := AVE(GROUP,IF(h.orig_dl_number = (TYPEOF(h.orig_dl_number))'',0,100));
    maxlength_orig_dl_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_number)));
    avelength_orig_dl_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_number)),h.orig_dl_number<>(typeof(h.orig_dl_number))'');
    populated_orig_dl_state_pcnt := AVE(GROUP,IF(h.orig_dl_state = (TYPEOF(h.orig_dl_state))'',0,100));
    maxlength_orig_dl_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_state)));
    avelength_orig_dl_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_state)),h.orig_dl_state<>(typeof(h.orig_dl_state))'');
    populated_orig_dl_link_pcnt := AVE(GROUP,IF(h.orig_dl_link = (TYPEOF(h.orig_dl_link))'',0,100));
    maxlength_orig_dl_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_link)));
    avelength_orig_dl_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_link)),h.orig_dl_link<>(typeof(h.orig_dl_link))'');
    populated_orig_dl_date_pcnt := AVE(GROUP,IF(h.orig_dl_date = (TYPEOF(h.orig_dl_date))'',0,100));
    maxlength_orig_dl_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_date)));
    avelength_orig_dl_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_dl_date)),h.orig_dl_date<>(typeof(h.orig_dl_date))'');
    populated_passport_type_pcnt := AVE(GROUP,IF(h.passport_type = (TYPEOF(h.passport_type))'',0,100));
    maxlength_passport_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_type)));
    avelength_passport_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_type)),h.passport_type<>(typeof(h.passport_type))'');
    populated_passport_code_pcnt := AVE(GROUP,IF(h.passport_code = (TYPEOF(h.passport_code))'',0,100));
    maxlength_passport_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_code)));
    avelength_passport_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_code)),h.passport_code<>(typeof(h.passport_code))'');
    populated_passport_number_pcnt := AVE(GROUP,IF(h.passport_number = (TYPEOF(h.passport_number))'',0,100));
    maxlength_passport_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_number)));
    avelength_passport_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_number)),h.passport_number<>(typeof(h.passport_number))'');
    populated_passport_first_name_pcnt := AVE(GROUP,IF(h.passport_first_name = (TYPEOF(h.passport_first_name))'',0,100));
    maxlength_passport_first_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_first_name)));
    avelength_passport_first_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_first_name)),h.passport_first_name<>(typeof(h.passport_first_name))'');
    populated_passport_given_name_pcnt := AVE(GROUP,IF(h.passport_given_name = (TYPEOF(h.passport_given_name))'',0,100));
    maxlength_passport_given_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_given_name)));
    avelength_passport_given_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_given_name)),h.passport_given_name<>(typeof(h.passport_given_name))'');
    populated_passport_nationality_pcnt := AVE(GROUP,IF(h.passport_nationality = (TYPEOF(h.passport_nationality))'',0,100));
    maxlength_passport_nationality := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_nationality)));
    avelength_passport_nationality := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_nationality)),h.passport_nationality<>(typeof(h.passport_nationality))'');
    populated_passport_dob_pcnt := AVE(GROUP,IF(h.passport_dob = (TYPEOF(h.passport_dob))'',0,100));
    maxlength_passport_dob := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_dob)));
    avelength_passport_dob := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_dob)),h.passport_dob<>(typeof(h.passport_dob))'');
    populated_passport_place_of_birth_pcnt := AVE(GROUP,IF(h.passport_place_of_birth = (TYPEOF(h.passport_place_of_birth))'',0,100));
    maxlength_passport_place_of_birth := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_place_of_birth)));
    avelength_passport_place_of_birth := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_place_of_birth)),h.passport_place_of_birth<>(typeof(h.passport_place_of_birth))'');
    populated_passport_sex_pcnt := AVE(GROUP,IF(h.passport_sex = (TYPEOF(h.passport_sex))'',0,100));
    maxlength_passport_sex := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_sex)));
    avelength_passport_sex := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_sex)),h.passport_sex<>(typeof(h.passport_sex))'');
    populated_passport_issue_date_pcnt := AVE(GROUP,IF(h.passport_issue_date = (TYPEOF(h.passport_issue_date))'',0,100));
    maxlength_passport_issue_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_issue_date)));
    avelength_passport_issue_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_issue_date)),h.passport_issue_date<>(typeof(h.passport_issue_date))'');
    populated_passport_authority_pcnt := AVE(GROUP,IF(h.passport_authority = (TYPEOF(h.passport_authority))'',0,100));
    maxlength_passport_authority := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_authority)));
    avelength_passport_authority := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_authority)),h.passport_authority<>(typeof(h.passport_authority))'');
    populated_passport_expiration_date_pcnt := AVE(GROUP,IF(h.passport_expiration_date = (TYPEOF(h.passport_expiration_date))'',0,100));
    maxlength_passport_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_expiration_date)));
    avelength_passport_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_expiration_date)),h.passport_expiration_date<>(typeof(h.passport_expiration_date))'');
    populated_passport_endorsement_pcnt := AVE(GROUP,IF(h.passport_endorsement = (TYPEOF(h.passport_endorsement))'',0,100));
    maxlength_passport_endorsement := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_endorsement)));
    avelength_passport_endorsement := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_endorsement)),h.passport_endorsement<>(typeof(h.passport_endorsement))'');
    populated_passport_link_pcnt := AVE(GROUP,IF(h.passport_link = (TYPEOF(h.passport_link))'',0,100));
    maxlength_passport_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_link)));
    avelength_passport_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_link)),h.passport_link<>(typeof(h.passport_link))'');
    populated_passport_date_pcnt := AVE(GROUP,IF(h.passport_date = (TYPEOF(h.passport_date))'',0,100));
    maxlength_passport_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_date)));
    avelength_passport_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.passport_date)),h.passport_date<>(typeof(h.passport_date))'');
    populated_orig_veh_year_1_pcnt := AVE(GROUP,IF(h.orig_veh_year_1 = (TYPEOF(h.orig_veh_year_1))'',0,100));
    maxlength_orig_veh_year_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_1)));
    avelength_orig_veh_year_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_1)),h.orig_veh_year_1<>(typeof(h.orig_veh_year_1))'');
    populated_orig_veh_color_1_pcnt := AVE(GROUP,IF(h.orig_veh_color_1 = (TYPEOF(h.orig_veh_color_1))'',0,100));
    maxlength_orig_veh_color_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_1)));
    avelength_orig_veh_color_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_1)),h.orig_veh_color_1<>(typeof(h.orig_veh_color_1))'');
    populated_orig_veh_make_model_1_pcnt := AVE(GROUP,IF(h.orig_veh_make_model_1 = (TYPEOF(h.orig_veh_make_model_1))'',0,100));
    maxlength_orig_veh_make_model_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_1)));
    avelength_orig_veh_make_model_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_1)),h.orig_veh_make_model_1<>(typeof(h.orig_veh_make_model_1))'');
    populated_orig_veh_plate_1_pcnt := AVE(GROUP,IF(h.orig_veh_plate_1 = (TYPEOF(h.orig_veh_plate_1))'',0,100));
    maxlength_orig_veh_plate_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_1)));
    avelength_orig_veh_plate_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_1)),h.orig_veh_plate_1<>(typeof(h.orig_veh_plate_1))'');
    populated_orig_registration_number_1_pcnt := AVE(GROUP,IF(h.orig_registration_number_1 = (TYPEOF(h.orig_registration_number_1))'',0,100));
    maxlength_orig_registration_number_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_1)));
    avelength_orig_registration_number_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_1)),h.orig_registration_number_1<>(typeof(h.orig_registration_number_1))'');
    populated_orig_veh_state_1_pcnt := AVE(GROUP,IF(h.orig_veh_state_1 = (TYPEOF(h.orig_veh_state_1))'',0,100));
    maxlength_orig_veh_state_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_1)));
    avelength_orig_veh_state_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_1)),h.orig_veh_state_1<>(typeof(h.orig_veh_state_1))'');
    populated_orig_veh_location_1_pcnt := AVE(GROUP,IF(h.orig_veh_location_1 = (TYPEOF(h.orig_veh_location_1))'',0,100));
    maxlength_orig_veh_location_1 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_1)));
    avelength_orig_veh_location_1 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_1)),h.orig_veh_location_1<>(typeof(h.orig_veh_location_1))'');
    populated_orig_veh_year_2_pcnt := AVE(GROUP,IF(h.orig_veh_year_2 = (TYPEOF(h.orig_veh_year_2))'',0,100));
    maxlength_orig_veh_year_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_2)));
    avelength_orig_veh_year_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_2)),h.orig_veh_year_2<>(typeof(h.orig_veh_year_2))'');
    populated_orig_veh_color_2_pcnt := AVE(GROUP,IF(h.orig_veh_color_2 = (TYPEOF(h.orig_veh_color_2))'',0,100));
    maxlength_orig_veh_color_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_2)));
    avelength_orig_veh_color_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_2)),h.orig_veh_color_2<>(typeof(h.orig_veh_color_2))'');
    populated_orig_veh_make_model_2_pcnt := AVE(GROUP,IF(h.orig_veh_make_model_2 = (TYPEOF(h.orig_veh_make_model_2))'',0,100));
    maxlength_orig_veh_make_model_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_2)));
    avelength_orig_veh_make_model_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_2)),h.orig_veh_make_model_2<>(typeof(h.orig_veh_make_model_2))'');
    populated_orig_veh_plate_2_pcnt := AVE(GROUP,IF(h.orig_veh_plate_2 = (TYPEOF(h.orig_veh_plate_2))'',0,100));
    maxlength_orig_veh_plate_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_2)));
    avelength_orig_veh_plate_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_2)),h.orig_veh_plate_2<>(typeof(h.orig_veh_plate_2))'');
    populated_orig_registration_number_2_pcnt := AVE(GROUP,IF(h.orig_registration_number_2 = (TYPEOF(h.orig_registration_number_2))'',0,100));
    maxlength_orig_registration_number_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_2)));
    avelength_orig_registration_number_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_2)),h.orig_registration_number_2<>(typeof(h.orig_registration_number_2))'');
    populated_orig_veh_state_2_pcnt := AVE(GROUP,IF(h.orig_veh_state_2 = (TYPEOF(h.orig_veh_state_2))'',0,100));
    maxlength_orig_veh_state_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_2)));
    avelength_orig_veh_state_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_2)),h.orig_veh_state_2<>(typeof(h.orig_veh_state_2))'');
    populated_orig_veh_location_2_pcnt := AVE(GROUP,IF(h.orig_veh_location_2 = (TYPEOF(h.orig_veh_location_2))'',0,100));
    maxlength_orig_veh_location_2 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_2)));
    avelength_orig_veh_location_2 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_2)),h.orig_veh_location_2<>(typeof(h.orig_veh_location_2))'');
    populated_orig_veh_year_3_pcnt := AVE(GROUP,IF(h.orig_veh_year_3 = (TYPEOF(h.orig_veh_year_3))'',0,100));
    maxlength_orig_veh_year_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_3)));
    avelength_orig_veh_year_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_3)),h.orig_veh_year_3<>(typeof(h.orig_veh_year_3))'');
    populated_orig_veh_color_3_pcnt := AVE(GROUP,IF(h.orig_veh_color_3 = (TYPEOF(h.orig_veh_color_3))'',0,100));
    maxlength_orig_veh_color_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_3)));
    avelength_orig_veh_color_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_3)),h.orig_veh_color_3<>(typeof(h.orig_veh_color_3))'');
    populated_orig_veh_make_model_3_pcnt := AVE(GROUP,IF(h.orig_veh_make_model_3 = (TYPEOF(h.orig_veh_make_model_3))'',0,100));
    maxlength_orig_veh_make_model_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_3)));
    avelength_orig_veh_make_model_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_3)),h.orig_veh_make_model_3<>(typeof(h.orig_veh_make_model_3))'');
    populated_orig_veh_plate_3_pcnt := AVE(GROUP,IF(h.orig_veh_plate_3 = (TYPEOF(h.orig_veh_plate_3))'',0,100));
    maxlength_orig_veh_plate_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_3)));
    avelength_orig_veh_plate_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_3)),h.orig_veh_plate_3<>(typeof(h.orig_veh_plate_3))'');
    populated_orig_registration_number_3_pcnt := AVE(GROUP,IF(h.orig_registration_number_3 = (TYPEOF(h.orig_registration_number_3))'',0,100));
    maxlength_orig_registration_number_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_3)));
    avelength_orig_registration_number_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_3)),h.orig_registration_number_3<>(typeof(h.orig_registration_number_3))'');
    populated_orig_veh_state_3_pcnt := AVE(GROUP,IF(h.orig_veh_state_3 = (TYPEOF(h.orig_veh_state_3))'',0,100));
    maxlength_orig_veh_state_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_3)));
    avelength_orig_veh_state_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_3)),h.orig_veh_state_3<>(typeof(h.orig_veh_state_3))'');
    populated_orig_veh_location_3_pcnt := AVE(GROUP,IF(h.orig_veh_location_3 = (TYPEOF(h.orig_veh_location_3))'',0,100));
    maxlength_orig_veh_location_3 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_3)));
    avelength_orig_veh_location_3 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_3)),h.orig_veh_location_3<>(typeof(h.orig_veh_location_3))'');
    populated_orig_veh_year_4_pcnt := AVE(GROUP,IF(h.orig_veh_year_4 = (TYPEOF(h.orig_veh_year_4))'',0,100));
    maxlength_orig_veh_year_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_4)));
    avelength_orig_veh_year_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_4)),h.orig_veh_year_4<>(typeof(h.orig_veh_year_4))'');
    populated_orig_veh_color_4_pcnt := AVE(GROUP,IF(h.orig_veh_color_4 = (TYPEOF(h.orig_veh_color_4))'',0,100));
    maxlength_orig_veh_color_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_4)));
    avelength_orig_veh_color_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_4)),h.orig_veh_color_4<>(typeof(h.orig_veh_color_4))'');
    populated_orig_veh_make_model_4_pcnt := AVE(GROUP,IF(h.orig_veh_make_model_4 = (TYPEOF(h.orig_veh_make_model_4))'',0,100));
    maxlength_orig_veh_make_model_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_4)));
    avelength_orig_veh_make_model_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_4)),h.orig_veh_make_model_4<>(typeof(h.orig_veh_make_model_4))'');
    populated_orig_veh_plate_4_pcnt := AVE(GROUP,IF(h.orig_veh_plate_4 = (TYPEOF(h.orig_veh_plate_4))'',0,100));
    maxlength_orig_veh_plate_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_4)));
    avelength_orig_veh_plate_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_4)),h.orig_veh_plate_4<>(typeof(h.orig_veh_plate_4))'');
    populated_orig_registration_number_4_pcnt := AVE(GROUP,IF(h.orig_registration_number_4 = (TYPEOF(h.orig_registration_number_4))'',0,100));
    maxlength_orig_registration_number_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_4)));
    avelength_orig_registration_number_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_4)),h.orig_registration_number_4<>(typeof(h.orig_registration_number_4))'');
    populated_orig_veh_state_4_pcnt := AVE(GROUP,IF(h.orig_veh_state_4 = (TYPEOF(h.orig_veh_state_4))'',0,100));
    maxlength_orig_veh_state_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_4)));
    avelength_orig_veh_state_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_4)),h.orig_veh_state_4<>(typeof(h.orig_veh_state_4))'');
    populated_orig_veh_location_4_pcnt := AVE(GROUP,IF(h.orig_veh_location_4 = (TYPEOF(h.orig_veh_location_4))'',0,100));
    maxlength_orig_veh_location_4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_4)));
    avelength_orig_veh_location_4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_4)),h.orig_veh_location_4<>(typeof(h.orig_veh_location_4))'');
    populated_orig_veh_year_5_pcnt := AVE(GROUP,IF(h.orig_veh_year_5 = (TYPEOF(h.orig_veh_year_5))'',0,100));
    maxlength_orig_veh_year_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_5)));
    avelength_orig_veh_year_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_year_5)),h.orig_veh_year_5<>(typeof(h.orig_veh_year_5))'');
    populated_orig_veh_color_5_pcnt := AVE(GROUP,IF(h.orig_veh_color_5 = (TYPEOF(h.orig_veh_color_5))'',0,100));
    maxlength_orig_veh_color_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_5)));
    avelength_orig_veh_color_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_color_5)),h.orig_veh_color_5<>(typeof(h.orig_veh_color_5))'');
    populated_orig_veh_make_model_5_pcnt := AVE(GROUP,IF(h.orig_veh_make_model_5 = (TYPEOF(h.orig_veh_make_model_5))'',0,100));
    maxlength_orig_veh_make_model_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_5)));
    avelength_orig_veh_make_model_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_make_model_5)),h.orig_veh_make_model_5<>(typeof(h.orig_veh_make_model_5))'');
    populated_orig_veh_plate_5_pcnt := AVE(GROUP,IF(h.orig_veh_plate_5 = (TYPEOF(h.orig_veh_plate_5))'',0,100));
    maxlength_orig_veh_plate_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_5)));
    avelength_orig_veh_plate_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_plate_5)),h.orig_veh_plate_5<>(typeof(h.orig_veh_plate_5))'');
    populated_orig_registration_number_5_pcnt := AVE(GROUP,IF(h.orig_registration_number_5 = (TYPEOF(h.orig_registration_number_5))'',0,100));
    maxlength_orig_registration_number_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_5)));
    avelength_orig_registration_number_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_registration_number_5)),h.orig_registration_number_5<>(typeof(h.orig_registration_number_5))'');
    populated_orig_veh_state_5_pcnt := AVE(GROUP,IF(h.orig_veh_state_5 = (TYPEOF(h.orig_veh_state_5))'',0,100));
    maxlength_orig_veh_state_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_5)));
    avelength_orig_veh_state_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_state_5)),h.orig_veh_state_5<>(typeof(h.orig_veh_state_5))'');
    populated_orig_veh_location_5_pcnt := AVE(GROUP,IF(h.orig_veh_location_5 = (TYPEOF(h.orig_veh_location_5))'',0,100));
    maxlength_orig_veh_location_5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_5)));
    avelength_orig_veh_location_5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.orig_veh_location_5)),h.orig_veh_location_5<>(typeof(h.orig_veh_location_5))'');
    populated_fingerprint_link_pcnt := AVE(GROUP,IF(h.fingerprint_link = (TYPEOF(h.fingerprint_link))'',0,100));
    maxlength_fingerprint_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fingerprint_link)));
    avelength_fingerprint_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fingerprint_link)),h.fingerprint_link<>(typeof(h.fingerprint_link))'');
    populated_fingerprint_date_pcnt := AVE(GROUP,IF(h.fingerprint_date = (TYPEOF(h.fingerprint_date))'',0,100));
    maxlength_fingerprint_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fingerprint_date)));
    avelength_fingerprint_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fingerprint_date)),h.fingerprint_date<>(typeof(h.fingerprint_date))'');
    populated_palmprint_link_pcnt := AVE(GROUP,IF(h.palmprint_link = (TYPEOF(h.palmprint_link))'',0,100));
    maxlength_palmprint_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.palmprint_link)));
    avelength_palmprint_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.palmprint_link)),h.palmprint_link<>(typeof(h.palmprint_link))'');
    populated_palmprint_date_pcnt := AVE(GROUP,IF(h.palmprint_date = (TYPEOF(h.palmprint_date))'',0,100));
    maxlength_palmprint_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.palmprint_date)));
    avelength_palmprint_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.palmprint_date)),h.palmprint_date<>(typeof(h.palmprint_date))'');
    populated_image_link_pcnt := AVE(GROUP,IF(h.image_link = (TYPEOF(h.image_link))'',0,100));
    maxlength_image_link := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_link)));
    avelength_image_link := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_link)),h.image_link<>(typeof(h.image_link))'');
    populated_image_date_pcnt := AVE(GROUP,IF(h.image_date = (TYPEOF(h.image_date))'',0,100));
    maxlength_image_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_date)));
    avelength_image_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.image_date)),h.image_date<>(typeof(h.image_date))'');
    populated_addr_dt_last_seen_pcnt := AVE(GROUP,IF(h.addr_dt_last_seen = (TYPEOF(h.addr_dt_last_seen))'',0,100));
    maxlength_addr_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_dt_last_seen)));
    avelength_addr_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_dt_last_seen)),h.addr_dt_last_seen<>(typeof(h.addr_dt_last_seen))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_clean_errors_pcnt := AVE(GROUP,IF(h.clean_errors = (TYPEOF(h.clean_errors))'',0,100));
    maxlength_clean_errors := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_errors)));
    avelength_clean_errors := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.clean_errors)),h.clean_errors<>(typeof(h.clean_errors))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_curr_incar_flag_pcnt := AVE(GROUP,IF(h.curr_incar_flag = (TYPEOF(h.curr_incar_flag))'',0,100));
    maxlength_curr_incar_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_incar_flag)));
    avelength_curr_incar_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_incar_flag)),h.curr_incar_flag<>(typeof(h.curr_incar_flag))'');
    populated_curr_parole_flag_pcnt := AVE(GROUP,IF(h.curr_parole_flag = (TYPEOF(h.curr_parole_flag))'',0,100));
    maxlength_curr_parole_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_parole_flag)));
    avelength_curr_parole_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_parole_flag)),h.curr_parole_flag<>(typeof(h.curr_parole_flag))'');
    populated_curr_probation_flag_pcnt := AVE(GROUP,IF(h.curr_probation_flag = (TYPEOF(h.curr_probation_flag))'',0,100));
    maxlength_curr_probation_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_probation_flag)));
    avelength_curr_probation_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.curr_probation_flag)),h.curr_probation_flag<>(typeof(h.curr_probation_flag))'');
    populated_fcra_conviction_flag_pcnt := AVE(GROUP,IF(h.fcra_conviction_flag = (TYPEOF(h.fcra_conviction_flag))'',0,100));
    maxlength_fcra_conviction_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)));
    avelength_fcra_conviction_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_conviction_flag)),h.fcra_conviction_flag<>(typeof(h.fcra_conviction_flag))'');
    populated_fcra_traffic_flag_pcnt := AVE(GROUP,IF(h.fcra_traffic_flag = (TYPEOF(h.fcra_traffic_flag))'',0,100));
    maxlength_fcra_traffic_flag := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)));
    avelength_fcra_traffic_flag := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_traffic_flag)),h.fcra_traffic_flag<>(typeof(h.fcra_traffic_flag))'');
    populated_fcra_date_pcnt := AVE(GROUP,IF(h.fcra_date = (TYPEOF(h.fcra_date))'',0,100));
    maxlength_fcra_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)));
    avelength_fcra_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date)),h.fcra_date<>(typeof(h.fcra_date))'');
    populated_fcra_date_type_pcnt := AVE(GROUP,IF(h.fcra_date_type = (TYPEOF(h.fcra_date_type))'',0,100));
    maxlength_fcra_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)));
    avelength_fcra_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.fcra_date_type)),h.fcra_date_type<>(typeof(h.fcra_date_type))'');
    populated_conviction_override_date_pcnt := AVE(GROUP,IF(h.conviction_override_date = (TYPEOF(h.conviction_override_date))'',0,100));
    maxlength_conviction_override_date := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)));
    avelength_conviction_override_date := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date)),h.conviction_override_date<>(typeof(h.conviction_override_date))'');
    populated_conviction_override_date_type_pcnt := AVE(GROUP,IF(h.conviction_override_date_type = (TYPEOF(h.conviction_override_date_type))'',0,100));
    maxlength_conviction_override_date_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)));
    avelength_conviction_override_date_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.conviction_override_date_type)),h.conviction_override_date_type<>(typeof(h.conviction_override_date_type))'');
    populated_offense_score_pcnt := AVE(GROUP,IF(h.offense_score = (TYPEOF(h.offense_score))'',0,100));
    maxlength_offense_score := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)));
    avelength_offense_score := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offense_score)),h.offense_score<>(typeof(h.offense_score))'');
    populated_offender_persistent_id_pcnt := AVE(GROUP,IF(h.offender_persistent_id = (TYPEOF(h.offender_persistent_id))'',0,100));
    maxlength_offender_persistent_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_persistent_id)));
    avelength_offender_persistent_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.offender_persistent_id)),h.offender_persistent_id<>(typeof(h.offender_persistent_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,orig_state_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_score_pcnt *   0.00 / 100 + T.Populated_ssn_appended_pcnt *   0.00 / 100 + T.Populated_ssn_perms_pcnt *   0.00 / 100 + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_state_code_pcnt *   0.00 / 100 + T.Populated_seisint_primary_key_pcnt *   0.00 / 100 + T.Populated_vendor_code_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_name_orig_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_nid_pcnt *   0.00 / 100 + T.Populated_ntype_pcnt *   0.00 / 100 + T.Populated_nindicator_pcnt *   0.00 / 100 + T.Populated_intnet_email_address_1_pcnt *   0.00 / 100 + T.Populated_intnet_email_address_2_pcnt *   0.00 / 100 + T.Populated_intnet_email_address_3_pcnt *   0.00 / 100 + T.Populated_intnet_email_address_4_pcnt *   0.00 / 100 + T.Populated_intnet_email_address_5_pcnt *   0.00 / 100 + T.Populated_intnet_instant_message_addr_1_pcnt *   0.00 / 100 + T.Populated_intnet_instant_message_addr_2_pcnt *   0.00 / 100 + T.Populated_intnet_instant_message_addr_3_pcnt *   0.00 / 100 + T.Populated_intnet_instant_message_addr_4_pcnt *   0.00 / 100 + T.Populated_intnet_instant_message_addr_5_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_1_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_1_url_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_2_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_2_url_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_3_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_3_url_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_4_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_4_url_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_5_pcnt *   0.00 / 100 + T.Populated_intnet_user_name_5_url_pcnt *   0.00 / 100 + T.Populated_offender_status_pcnt *   0.00 / 100 + T.Populated_offender_category_pcnt *   0.00 / 100 + T.Populated_risk_level_code_pcnt *   0.00 / 100 + T.Populated_risk_description_pcnt *   0.00 / 100 + T.Populated_police_agency_pcnt *   0.00 / 100 + T.Populated_police_agency_contact_name_pcnt *   0.00 / 100 + T.Populated_police_agency_address_1_pcnt *   0.00 / 100 + T.Populated_police_agency_address_2_pcnt *   0.00 / 100 + T.Populated_police_agency_phone_pcnt *   0.00 / 100 + T.Populated_registration_type_pcnt *   0.00 / 100 + T.Populated_reg_date_1_pcnt *   0.00 / 100 + T.Populated_reg_date_1_type_pcnt *   0.00 / 100 + T.Populated_reg_date_2_pcnt *   0.00 / 100 + T.Populated_reg_date_2_type_pcnt *   0.00 / 100 + T.Populated_reg_date_3_pcnt *   0.00 / 100 + T.Populated_reg_date_3_type_pcnt *   0.00 / 100 + T.Populated_registration_address_1_pcnt *   0.00 / 100 + T.Populated_registration_address_2_pcnt *   0.00 / 100 + T.Populated_registration_address_3_pcnt *   0.00 / 100 + T.Populated_registration_address_4_pcnt *   0.00 / 100 + T.Populated_registration_address_5_pcnt *   0.00 / 100 + T.Populated_registration_county_pcnt *   0.00 / 100 + T.Populated_registration_home_phone_pcnt *   0.00 / 100 + T.Populated_registration_cell_phone_pcnt *   0.00 / 100 + T.Populated_other_registration_address_1_pcnt *   0.00 / 100 + T.Populated_other_registration_address_2_pcnt *   0.00 / 100 + T.Populated_other_registration_address_3_pcnt *   0.00 / 100 + T.Populated_other_registration_address_4_pcnt *   0.00 / 100 + T.Populated_other_registration_address_5_pcnt *   0.00 / 100 + T.Populated_other_registration_county_pcnt *   0.00 / 100 + T.Populated_other_registration_phone_pcnt *   0.00 / 100 + T.Populated_temp_lodge_address_1_pcnt *   0.00 / 100 + T.Populated_temp_lodge_address_2_pcnt *   0.00 / 100 + T.Populated_temp_lodge_address_3_pcnt *   0.00 / 100 + T.Populated_temp_lodge_address_4_pcnt *   0.00 / 100 + T.Populated_temp_lodge_address_5_pcnt *   0.00 / 100 + T.Populated_temp_lodge_county_pcnt *   0.00 / 100 + T.Populated_temp_lodge_phone_pcnt *   0.00 / 100 + T.Populated_employer_pcnt *   0.00 / 100 + T.Populated_employer_address_1_pcnt *   0.00 / 100 + T.Populated_employer_address_2_pcnt *   0.00 / 100 + T.Populated_employer_address_3_pcnt *   0.00 / 100 + T.Populated_employer_address_4_pcnt *   0.00 / 100 + T.Populated_employer_address_5_pcnt *   0.00 / 100 + T.Populated_employer_county_pcnt *   0.00 / 100 + T.Populated_employer_phone_pcnt *   0.00 / 100 + T.Populated_employer_comments_pcnt *   0.00 / 100 + T.Populated_professional_licenses_1_pcnt *   0.00 / 100 + T.Populated_professional_licenses_2_pcnt *   0.00 / 100 + T.Populated_professional_licenses_3_pcnt *   0.00 / 100 + T.Populated_professional_licenses_4_pcnt *   0.00 / 100 + T.Populated_professional_licenses_5_pcnt *   0.00 / 100 + T.Populated_school_pcnt *   0.00 / 100 + T.Populated_school_address_1_pcnt *   0.00 / 100 + T.Populated_school_address_2_pcnt *   0.00 / 100 + T.Populated_school_address_3_pcnt *   0.00 / 100 + T.Populated_school_address_4_pcnt *   0.00 / 100 + T.Populated_school_address_5_pcnt *   0.00 / 100 + T.Populated_school_county_pcnt *   0.00 / 100 + T.Populated_school_phone_pcnt *   0.00 / 100 + T.Populated_school_comments_pcnt *   0.00 / 100 + T.Populated_offender_id_pcnt *   0.00 / 100 + T.Populated_doc_number_pcnt *   0.00 / 100 + T.Populated_sor_number_pcnt *   0.00 / 100 + T.Populated_st_id_number_pcnt *   0.00 / 100 + T.Populated_fbi_number_pcnt *   0.00 / 100 + T.Populated_ncic_number_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_dob_aka_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_dna_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_ethnicity_pcnt *   0.00 / 100 + T.Populated_sex_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_skin_tone_pcnt *   0.00 / 100 + T.Populated_build_type_pcnt *   0.00 / 100 + T.Populated_scars_marks_tattoos_pcnt *   0.00 / 100 + T.Populated_shoe_size_pcnt *   0.00 / 100 + T.Populated_corrective_lense_flag_pcnt *   0.00 / 100 + T.Populated_addl_comments_1_pcnt *   0.00 / 100 + T.Populated_addl_comments_2_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_pcnt *   0.00 / 100 + T.Populated_orig_dl_state_pcnt *   0.00 / 100 + T.Populated_orig_dl_link_pcnt *   0.00 / 100 + T.Populated_orig_dl_date_pcnt *   0.00 / 100 + T.Populated_passport_type_pcnt *   0.00 / 100 + T.Populated_passport_code_pcnt *   0.00 / 100 + T.Populated_passport_number_pcnt *   0.00 / 100 + T.Populated_passport_first_name_pcnt *   0.00 / 100 + T.Populated_passport_given_name_pcnt *   0.00 / 100 + T.Populated_passport_nationality_pcnt *   0.00 / 100 + T.Populated_passport_dob_pcnt *   0.00 / 100 + T.Populated_passport_place_of_birth_pcnt *   0.00 / 100 + T.Populated_passport_sex_pcnt *   0.00 / 100 + T.Populated_passport_issue_date_pcnt *   0.00 / 100 + T.Populated_passport_authority_pcnt *   0.00 / 100 + T.Populated_passport_expiration_date_pcnt *   0.00 / 100 + T.Populated_passport_endorsement_pcnt *   0.00 / 100 + T.Populated_passport_link_pcnt *   0.00 / 100 + T.Populated_passport_date_pcnt *   0.00 / 100 + T.Populated_orig_veh_year_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_color_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_make_model_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_plate_1_pcnt *   0.00 / 100 + T.Populated_orig_registration_number_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_state_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_location_1_pcnt *   0.00 / 100 + T.Populated_orig_veh_year_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_color_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_make_model_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_plate_2_pcnt *   0.00 / 100 + T.Populated_orig_registration_number_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_state_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_location_2_pcnt *   0.00 / 100 + T.Populated_orig_veh_year_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_color_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_make_model_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_plate_3_pcnt *   0.00 / 100 + T.Populated_orig_registration_number_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_state_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_location_3_pcnt *   0.00 / 100 + T.Populated_orig_veh_year_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_color_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_make_model_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_plate_4_pcnt *   0.00 / 100 + T.Populated_orig_registration_number_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_state_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_location_4_pcnt *   0.00 / 100 + T.Populated_orig_veh_year_5_pcnt *   0.00 / 100 + T.Populated_orig_veh_color_5_pcnt *   0.00 / 100 + T.Populated_orig_veh_make_model_5_pcnt *   0.00 / 100 + T.Populated_orig_veh_plate_5_pcnt *   0.00 / 100 + T.Populated_orig_registration_number_5_pcnt *   0.00 / 100 + T.Populated_orig_veh_state_5_pcnt *   0.00 / 100 + T.Populated_orig_veh_location_5_pcnt *   0.00 / 100 + T.Populated_fingerprint_link_pcnt *   0.00 / 100 + T.Populated_fingerprint_date_pcnt *   0.00 / 100 + T.Populated_palmprint_link_pcnt *   0.00 / 100 + T.Populated_palmprint_date_pcnt *   0.00 / 100 + T.Populated_image_link_pcnt *   0.00 / 100 + T.Populated_image_date_pcnt *   0.00 / 100 + T.Populated_addr_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_errors_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_curr_incar_flag_pcnt *   0.00 / 100 + T.Populated_curr_parole_flag_pcnt *   0.00 / 100 + T.Populated_curr_probation_flag_pcnt *   0.00 / 100 + T.Populated_fcra_conviction_flag_pcnt *   0.00 / 100 + T.Populated_fcra_traffic_flag_pcnt *   0.00 / 100 + T.Populated_fcra_date_pcnt *   0.00 / 100 + T.Populated_fcra_date_type_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_pcnt *   0.00 / 100 + T.Populated_conviction_override_date_type_pcnt *   0.00 / 100 + T.Populated_offense_score_pcnt *   0.00 / 100 + T.Populated_offender_persistent_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING orig_state_code1;
    STRING orig_state_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.orig_state_code1 := le.Source;
    SELF.orig_state_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_score_pcnt*ri.Populated_score_pcnt *   0.00 / 10000 + le.Populated_ssn_appended_pcnt*ri.Populated_ssn_appended_pcnt *   0.00 / 10000 + le.Populated_ssn_perms_pcnt*ri.Populated_ssn_perms_pcnt *   0.00 / 10000 + le.Populated_dt_first_reported_pcnt*ri.Populated_dt_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_last_reported_pcnt*ri.Populated_dt_last_reported_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_state_code_pcnt*ri.Populated_orig_state_code_pcnt *   0.00 / 10000 + le.Populated_seisint_primary_key_pcnt*ri.Populated_seisint_primary_key_pcnt *   0.00 / 10000 + le.Populated_vendor_code_pcnt*ri.Populated_vendor_code_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000 + le.Populated_record_type_pcnt*ri.Populated_record_type_pcnt *   0.00 / 10000 + le.Populated_name_orig_pcnt*ri.Populated_name_orig_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_nid_pcnt*ri.Populated_nid_pcnt *   0.00 / 10000 + le.Populated_ntype_pcnt*ri.Populated_ntype_pcnt *   0.00 / 10000 + le.Populated_nindicator_pcnt*ri.Populated_nindicator_pcnt *   0.00 / 10000 + le.Populated_intnet_email_address_1_pcnt*ri.Populated_intnet_email_address_1_pcnt *   0.00 / 10000 + le.Populated_intnet_email_address_2_pcnt*ri.Populated_intnet_email_address_2_pcnt *   0.00 / 10000 + le.Populated_intnet_email_address_3_pcnt*ri.Populated_intnet_email_address_3_pcnt *   0.00 / 10000 + le.Populated_intnet_email_address_4_pcnt*ri.Populated_intnet_email_address_4_pcnt *   0.00 / 10000 + le.Populated_intnet_email_address_5_pcnt*ri.Populated_intnet_email_address_5_pcnt *   0.00 / 10000 + le.Populated_intnet_instant_message_addr_1_pcnt*ri.Populated_intnet_instant_message_addr_1_pcnt *   0.00 / 10000 + le.Populated_intnet_instant_message_addr_2_pcnt*ri.Populated_intnet_instant_message_addr_2_pcnt *   0.00 / 10000 + le.Populated_intnet_instant_message_addr_3_pcnt*ri.Populated_intnet_instant_message_addr_3_pcnt *   0.00 / 10000 + le.Populated_intnet_instant_message_addr_4_pcnt*ri.Populated_intnet_instant_message_addr_4_pcnt *   0.00 / 10000 + le.Populated_intnet_instant_message_addr_5_pcnt*ri.Populated_intnet_instant_message_addr_5_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_1_pcnt*ri.Populated_intnet_user_name_1_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_1_url_pcnt*ri.Populated_intnet_user_name_1_url_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_2_pcnt*ri.Populated_intnet_user_name_2_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_2_url_pcnt*ri.Populated_intnet_user_name_2_url_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_3_pcnt*ri.Populated_intnet_user_name_3_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_3_url_pcnt*ri.Populated_intnet_user_name_3_url_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_4_pcnt*ri.Populated_intnet_user_name_4_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_4_url_pcnt*ri.Populated_intnet_user_name_4_url_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_5_pcnt*ri.Populated_intnet_user_name_5_pcnt *   0.00 / 10000 + le.Populated_intnet_user_name_5_url_pcnt*ri.Populated_intnet_user_name_5_url_pcnt *   0.00 / 10000 + le.Populated_offender_status_pcnt*ri.Populated_offender_status_pcnt *   0.00 / 10000 + le.Populated_offender_category_pcnt*ri.Populated_offender_category_pcnt *   0.00 / 10000 + le.Populated_risk_level_code_pcnt*ri.Populated_risk_level_code_pcnt *   0.00 / 10000 + le.Populated_risk_description_pcnt*ri.Populated_risk_description_pcnt *   0.00 / 10000 + le.Populated_police_agency_pcnt*ri.Populated_police_agency_pcnt *   0.00 / 10000 + le.Populated_police_agency_contact_name_pcnt*ri.Populated_police_agency_contact_name_pcnt *   0.00 / 10000 + le.Populated_police_agency_address_1_pcnt*ri.Populated_police_agency_address_1_pcnt *   0.00 / 10000 + le.Populated_police_agency_address_2_pcnt*ri.Populated_police_agency_address_2_pcnt *   0.00 / 10000 + le.Populated_police_agency_phone_pcnt*ri.Populated_police_agency_phone_pcnt *   0.00 / 10000 + le.Populated_registration_type_pcnt*ri.Populated_registration_type_pcnt *   0.00 / 10000 + le.Populated_reg_date_1_pcnt*ri.Populated_reg_date_1_pcnt *   0.00 / 10000 + le.Populated_reg_date_1_type_pcnt*ri.Populated_reg_date_1_type_pcnt *   0.00 / 10000 + le.Populated_reg_date_2_pcnt*ri.Populated_reg_date_2_pcnt *   0.00 / 10000 + le.Populated_reg_date_2_type_pcnt*ri.Populated_reg_date_2_type_pcnt *   0.00 / 10000 + le.Populated_reg_date_3_pcnt*ri.Populated_reg_date_3_pcnt *   0.00 / 10000 + le.Populated_reg_date_3_type_pcnt*ri.Populated_reg_date_3_type_pcnt *   0.00 / 10000 + le.Populated_registration_address_1_pcnt*ri.Populated_registration_address_1_pcnt *   0.00 / 10000 + le.Populated_registration_address_2_pcnt*ri.Populated_registration_address_2_pcnt *   0.00 / 10000 + le.Populated_registration_address_3_pcnt*ri.Populated_registration_address_3_pcnt *   0.00 / 10000 + le.Populated_registration_address_4_pcnt*ri.Populated_registration_address_4_pcnt *   0.00 / 10000 + le.Populated_registration_address_5_pcnt*ri.Populated_registration_address_5_pcnt *   0.00 / 10000 + le.Populated_registration_county_pcnt*ri.Populated_registration_county_pcnt *   0.00 / 10000 + le.Populated_registration_home_phone_pcnt*ri.Populated_registration_home_phone_pcnt *   0.00 / 10000 + le.Populated_registration_cell_phone_pcnt*ri.Populated_registration_cell_phone_pcnt *   0.00 / 10000 + le.Populated_other_registration_address_1_pcnt*ri.Populated_other_registration_address_1_pcnt *   0.00 / 10000 + le.Populated_other_registration_address_2_pcnt*ri.Populated_other_registration_address_2_pcnt *   0.00 / 10000 + le.Populated_other_registration_address_3_pcnt*ri.Populated_other_registration_address_3_pcnt *   0.00 / 10000 + le.Populated_other_registration_address_4_pcnt*ri.Populated_other_registration_address_4_pcnt *   0.00 / 10000 + le.Populated_other_registration_address_5_pcnt*ri.Populated_other_registration_address_5_pcnt *   0.00 / 10000 + le.Populated_other_registration_county_pcnt*ri.Populated_other_registration_county_pcnt *   0.00 / 10000 + le.Populated_other_registration_phone_pcnt*ri.Populated_other_registration_phone_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_address_1_pcnt*ri.Populated_temp_lodge_address_1_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_address_2_pcnt*ri.Populated_temp_lodge_address_2_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_address_3_pcnt*ri.Populated_temp_lodge_address_3_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_address_4_pcnt*ri.Populated_temp_lodge_address_4_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_address_5_pcnt*ri.Populated_temp_lodge_address_5_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_county_pcnt*ri.Populated_temp_lodge_county_pcnt *   0.00 / 10000 + le.Populated_temp_lodge_phone_pcnt*ri.Populated_temp_lodge_phone_pcnt *   0.00 / 10000 + le.Populated_employer_pcnt*ri.Populated_employer_pcnt *   0.00 / 10000 + le.Populated_employer_address_1_pcnt*ri.Populated_employer_address_1_pcnt *   0.00 / 10000 + le.Populated_employer_address_2_pcnt*ri.Populated_employer_address_2_pcnt *   0.00 / 10000 + le.Populated_employer_address_3_pcnt*ri.Populated_employer_address_3_pcnt *   0.00 / 10000 + le.Populated_employer_address_4_pcnt*ri.Populated_employer_address_4_pcnt *   0.00 / 10000 + le.Populated_employer_address_5_pcnt*ri.Populated_employer_address_5_pcnt *   0.00 / 10000 + le.Populated_employer_county_pcnt*ri.Populated_employer_county_pcnt *   0.00 / 10000 + le.Populated_employer_phone_pcnt*ri.Populated_employer_phone_pcnt *   0.00 / 10000 + le.Populated_employer_comments_pcnt*ri.Populated_employer_comments_pcnt *   0.00 / 10000 + le.Populated_professional_licenses_1_pcnt*ri.Populated_professional_licenses_1_pcnt *   0.00 / 10000 + le.Populated_professional_licenses_2_pcnt*ri.Populated_professional_licenses_2_pcnt *   0.00 / 10000 + le.Populated_professional_licenses_3_pcnt*ri.Populated_professional_licenses_3_pcnt *   0.00 / 10000 + le.Populated_professional_licenses_4_pcnt*ri.Populated_professional_licenses_4_pcnt *   0.00 / 10000 + le.Populated_professional_licenses_5_pcnt*ri.Populated_professional_licenses_5_pcnt *   0.00 / 10000 + le.Populated_school_pcnt*ri.Populated_school_pcnt *   0.00 / 10000 + le.Populated_school_address_1_pcnt*ri.Populated_school_address_1_pcnt *   0.00 / 10000 + le.Populated_school_address_2_pcnt*ri.Populated_school_address_2_pcnt *   0.00 / 10000 + le.Populated_school_address_3_pcnt*ri.Populated_school_address_3_pcnt *   0.00 / 10000 + le.Populated_school_address_4_pcnt*ri.Populated_school_address_4_pcnt *   0.00 / 10000 + le.Populated_school_address_5_pcnt*ri.Populated_school_address_5_pcnt *   0.00 / 10000 + le.Populated_school_county_pcnt*ri.Populated_school_county_pcnt *   0.00 / 10000 + le.Populated_school_phone_pcnt*ri.Populated_school_phone_pcnt *   0.00 / 10000 + le.Populated_school_comments_pcnt*ri.Populated_school_comments_pcnt *   0.00 / 10000 + le.Populated_offender_id_pcnt*ri.Populated_offender_id_pcnt *   0.00 / 10000 + le.Populated_doc_number_pcnt*ri.Populated_doc_number_pcnt *   0.00 / 10000 + le.Populated_sor_number_pcnt*ri.Populated_sor_number_pcnt *   0.00 / 10000 + le.Populated_st_id_number_pcnt*ri.Populated_st_id_number_pcnt *   0.00 / 10000 + le.Populated_fbi_number_pcnt*ri.Populated_fbi_number_pcnt *   0.00 / 10000 + le.Populated_ncic_number_pcnt*ri.Populated_ncic_number_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_dob_aka_pcnt*ri.Populated_dob_aka_pcnt *   0.00 / 10000 + le.Populated_age_pcnt*ri.Populated_age_pcnt *   0.00 / 10000 + le.Populated_dna_pcnt*ri.Populated_dna_pcnt *   0.00 / 10000 + le.Populated_race_pcnt*ri.Populated_race_pcnt *   0.00 / 10000 + le.Populated_ethnicity_pcnt*ri.Populated_ethnicity_pcnt *   0.00 / 10000 + le.Populated_sex_pcnt*ri.Populated_sex_pcnt *   0.00 / 10000 + le.Populated_hair_color_pcnt*ri.Populated_hair_color_pcnt *   0.00 / 10000 + le.Populated_eye_color_pcnt*ri.Populated_eye_color_pcnt *   0.00 / 10000 + le.Populated_height_pcnt*ri.Populated_height_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_skin_tone_pcnt*ri.Populated_skin_tone_pcnt *   0.00 / 10000 + le.Populated_build_type_pcnt*ri.Populated_build_type_pcnt *   0.00 / 10000 + le.Populated_scars_marks_tattoos_pcnt*ri.Populated_scars_marks_tattoos_pcnt *   0.00 / 10000 + le.Populated_shoe_size_pcnt*ri.Populated_shoe_size_pcnt *   0.00 / 10000 + le.Populated_corrective_lense_flag_pcnt*ri.Populated_corrective_lense_flag_pcnt *   0.00 / 10000 + le.Populated_addl_comments_1_pcnt*ri.Populated_addl_comments_1_pcnt *   0.00 / 10000 + le.Populated_addl_comments_2_pcnt*ri.Populated_addl_comments_2_pcnt *   0.00 / 10000 + le.Populated_orig_dl_number_pcnt*ri.Populated_orig_dl_number_pcnt *   0.00 / 10000 + le.Populated_orig_dl_state_pcnt*ri.Populated_orig_dl_state_pcnt *   0.00 / 10000 + le.Populated_orig_dl_link_pcnt*ri.Populated_orig_dl_link_pcnt *   0.00 / 10000 + le.Populated_orig_dl_date_pcnt*ri.Populated_orig_dl_date_pcnt *   0.00 / 10000 + le.Populated_passport_type_pcnt*ri.Populated_passport_type_pcnt *   0.00 / 10000 + le.Populated_passport_code_pcnt*ri.Populated_passport_code_pcnt *   0.00 / 10000 + le.Populated_passport_number_pcnt*ri.Populated_passport_number_pcnt *   0.00 / 10000 + le.Populated_passport_first_name_pcnt*ri.Populated_passport_first_name_pcnt *   0.00 / 10000 + le.Populated_passport_given_name_pcnt*ri.Populated_passport_given_name_pcnt *   0.00 / 10000 + le.Populated_passport_nationality_pcnt*ri.Populated_passport_nationality_pcnt *   0.00 / 10000 + le.Populated_passport_dob_pcnt*ri.Populated_passport_dob_pcnt *   0.00 / 10000 + le.Populated_passport_place_of_birth_pcnt*ri.Populated_passport_place_of_birth_pcnt *   0.00 / 10000 + le.Populated_passport_sex_pcnt*ri.Populated_passport_sex_pcnt *   0.00 / 10000 + le.Populated_passport_issue_date_pcnt*ri.Populated_passport_issue_date_pcnt *   0.00 / 10000 + le.Populated_passport_authority_pcnt*ri.Populated_passport_authority_pcnt *   0.00 / 10000 + le.Populated_passport_expiration_date_pcnt*ri.Populated_passport_expiration_date_pcnt *   0.00 / 10000 + le.Populated_passport_endorsement_pcnt*ri.Populated_passport_endorsement_pcnt *   0.00 / 10000 + le.Populated_passport_link_pcnt*ri.Populated_passport_link_pcnt *   0.00 / 10000 + le.Populated_passport_date_pcnt*ri.Populated_passport_date_pcnt *   0.00 / 10000 + le.Populated_orig_veh_year_1_pcnt*ri.Populated_orig_veh_year_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_color_1_pcnt*ri.Populated_orig_veh_color_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_make_model_1_pcnt*ri.Populated_orig_veh_make_model_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_plate_1_pcnt*ri.Populated_orig_veh_plate_1_pcnt *   0.00 / 10000 + le.Populated_orig_registration_number_1_pcnt*ri.Populated_orig_registration_number_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_state_1_pcnt*ri.Populated_orig_veh_state_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_location_1_pcnt*ri.Populated_orig_veh_location_1_pcnt *   0.00 / 10000 + le.Populated_orig_veh_year_2_pcnt*ri.Populated_orig_veh_year_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_color_2_pcnt*ri.Populated_orig_veh_color_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_make_model_2_pcnt*ri.Populated_orig_veh_make_model_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_plate_2_pcnt*ri.Populated_orig_veh_plate_2_pcnt *   0.00 / 10000 + le.Populated_orig_registration_number_2_pcnt*ri.Populated_orig_registration_number_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_state_2_pcnt*ri.Populated_orig_veh_state_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_location_2_pcnt*ri.Populated_orig_veh_location_2_pcnt *   0.00 / 10000 + le.Populated_orig_veh_year_3_pcnt*ri.Populated_orig_veh_year_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_color_3_pcnt*ri.Populated_orig_veh_color_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_make_model_3_pcnt*ri.Populated_orig_veh_make_model_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_plate_3_pcnt*ri.Populated_orig_veh_plate_3_pcnt *   0.00 / 10000 + le.Populated_orig_registration_number_3_pcnt*ri.Populated_orig_registration_number_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_state_3_pcnt*ri.Populated_orig_veh_state_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_location_3_pcnt*ri.Populated_orig_veh_location_3_pcnt *   0.00 / 10000 + le.Populated_orig_veh_year_4_pcnt*ri.Populated_orig_veh_year_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_color_4_pcnt*ri.Populated_orig_veh_color_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_make_model_4_pcnt*ri.Populated_orig_veh_make_model_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_plate_4_pcnt*ri.Populated_orig_veh_plate_4_pcnt *   0.00 / 10000 + le.Populated_orig_registration_number_4_pcnt*ri.Populated_orig_registration_number_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_state_4_pcnt*ri.Populated_orig_veh_state_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_location_4_pcnt*ri.Populated_orig_veh_location_4_pcnt *   0.00 / 10000 + le.Populated_orig_veh_year_5_pcnt*ri.Populated_orig_veh_year_5_pcnt *   0.00 / 10000 + le.Populated_orig_veh_color_5_pcnt*ri.Populated_orig_veh_color_5_pcnt *   0.00 / 10000 + le.Populated_orig_veh_make_model_5_pcnt*ri.Populated_orig_veh_make_model_5_pcnt *   0.00 / 10000 + le.Populated_orig_veh_plate_5_pcnt*ri.Populated_orig_veh_plate_5_pcnt *   0.00 / 10000 + le.Populated_orig_registration_number_5_pcnt*ri.Populated_orig_registration_number_5_pcnt *   0.00 / 10000 + le.Populated_orig_veh_state_5_pcnt*ri.Populated_orig_veh_state_5_pcnt *   0.00 / 10000 + le.Populated_orig_veh_location_5_pcnt*ri.Populated_orig_veh_location_5_pcnt *   0.00 / 10000 + le.Populated_fingerprint_link_pcnt*ri.Populated_fingerprint_link_pcnt *   0.00 / 10000 + le.Populated_fingerprint_date_pcnt*ri.Populated_fingerprint_date_pcnt *   0.00 / 10000 + le.Populated_palmprint_link_pcnt*ri.Populated_palmprint_link_pcnt *   0.00 / 10000 + le.Populated_palmprint_date_pcnt*ri.Populated_palmprint_date_pcnt *   0.00 / 10000 + le.Populated_image_link_pcnt*ri.Populated_image_link_pcnt *   0.00 / 10000 + le.Populated_image_date_pcnt*ri.Populated_image_date_pcnt *   0.00 / 10000 + le.Populated_addr_dt_last_seen_pcnt*ri.Populated_addr_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_clean_errors_pcnt*ri.Populated_clean_errors_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_curr_incar_flag_pcnt*ri.Populated_curr_incar_flag_pcnt *   0.00 / 10000 + le.Populated_curr_parole_flag_pcnt*ri.Populated_curr_parole_flag_pcnt *   0.00 / 10000 + le.Populated_curr_probation_flag_pcnt*ri.Populated_curr_probation_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_conviction_flag_pcnt*ri.Populated_fcra_conviction_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_traffic_flag_pcnt*ri.Populated_fcra_traffic_flag_pcnt *   0.00 / 10000 + le.Populated_fcra_date_pcnt*ri.Populated_fcra_date_pcnt *   0.00 / 10000 + le.Populated_fcra_date_type_pcnt*ri.Populated_fcra_date_type_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_pcnt*ri.Populated_conviction_override_date_pcnt *   0.00 / 10000 + le.Populated_conviction_override_date_type_pcnt*ri.Populated_conviction_override_date_type_pcnt *   0.00 / 10000 + le.Populated_offense_score_pcnt*ri.Populated_offense_score_pcnt *   0.00 / 10000 + le.Populated_offender_persistent_id_pcnt*ri.Populated_offender_persistent_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'did','score','ssn_appended','ssn_perms','dt_first_reported','dt_last_reported','orig_state','orig_state_code','seisint_primary_key','vendor_code','source_file','record_type','name_orig','lname','fname','mname','name_suffix','name_type','nid','ntype','nindicator','intnet_email_address_1','intnet_email_address_2','intnet_email_address_3','intnet_email_address_4','intnet_email_address_5','intnet_instant_message_addr_1','intnet_instant_message_addr_2','intnet_instant_message_addr_3','intnet_instant_message_addr_4','intnet_instant_message_addr_5','intnet_user_name_1','intnet_user_name_1_url','intnet_user_name_2','intnet_user_name_2_url','intnet_user_name_3','intnet_user_name_3_url','intnet_user_name_4','intnet_user_name_4_url','intnet_user_name_5','intnet_user_name_5_url','offender_status','offender_category','risk_level_code','risk_description','police_agency','police_agency_contact_name','police_agency_address_1','police_agency_address_2','police_agency_phone','registration_type','reg_date_1','reg_date_1_type','reg_date_2','reg_date_2_type','reg_date_3','reg_date_3_type','registration_address_1','registration_address_2','registration_address_3','registration_address_4','registration_address_5','registration_county','registration_home_phone','registration_cell_phone','other_registration_address_1','other_registration_address_2','other_registration_address_3','other_registration_address_4','other_registration_address_5','other_registration_county','other_registration_phone','temp_lodge_address_1','temp_lodge_address_2','temp_lodge_address_3','temp_lodge_address_4','temp_lodge_address_5','temp_lodge_county','temp_lodge_phone','employer','employer_address_1','employer_address_2','employer_address_3','employer_address_4','employer_address_5','employer_county','employer_phone','employer_comments','professional_licenses_1','professional_licenses_2','professional_licenses_3','professional_licenses_4','professional_licenses_5','school','school_address_1','school_address_2','school_address_3','school_address_4','school_address_5','school_county','school_phone','school_comments','offender_id','doc_number','sor_number','st_id_number','fbi_number','ncic_number','ssn','dob','dob_aka','age','dna','race','ethnicity','sex','hair_color','eye_color','height','weight','skin_tone','build_type','scars_marks_tattoos','shoe_size','corrective_lense_flag','addl_comments_1','addl_comments_2','orig_dl_number','orig_dl_state','orig_dl_link','orig_dl_date','passport_type','passport_code','passport_number','passport_first_name','passport_given_name','passport_nationality','passport_dob','passport_place_of_birth','passport_sex','passport_issue_date','passport_authority','passport_expiration_date','passport_endorsement','passport_link','passport_date','orig_veh_year_1','orig_veh_color_1','orig_veh_make_model_1','orig_veh_plate_1','orig_registration_number_1','orig_veh_state_1','orig_veh_location_1','orig_veh_year_2','orig_veh_color_2','orig_veh_make_model_2','orig_veh_plate_2','orig_registration_number_2','orig_veh_state_2','orig_veh_location_2','orig_veh_year_3','orig_veh_color_3','orig_veh_make_model_3','orig_veh_plate_3','orig_registration_number_3','orig_veh_state_3','orig_veh_location_3','orig_veh_year_4','orig_veh_color_4','orig_veh_make_model_4','orig_veh_plate_4','orig_registration_number_4','orig_veh_state_4','orig_veh_location_4','orig_veh_year_5','orig_veh_color_5','orig_veh_make_model_5','orig_veh_plate_5','orig_registration_number_5','orig_veh_state_5','orig_veh_location_5','fingerprint_link','fingerprint_date','palmprint_link','palmprint_date','image_link','image_date','addr_dt_last_seen','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','clean_errors','rawaid','curr_incar_flag','curr_parole_flag','curr_probation_flag','fcra_conviction_flag','fcra_traffic_flag','fcra_date','fcra_date_type','conviction_override_date','conviction_override_date_type','offense_score','offender_persistent_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_did_pcnt,le.populated_score_pcnt,le.populated_ssn_appended_pcnt,le.populated_ssn_perms_pcnt,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_orig_state_pcnt,le.populated_orig_state_code_pcnt,le.populated_seisint_primary_key_pcnt,le.populated_vendor_code_pcnt,le.populated_source_file_pcnt,le.populated_record_type_pcnt,le.populated_name_orig_pcnt,le.populated_lname_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_type_pcnt,le.populated_nid_pcnt,le.populated_ntype_pcnt,le.populated_nindicator_pcnt,le.populated_intnet_email_address_1_pcnt,le.populated_intnet_email_address_2_pcnt,le.populated_intnet_email_address_3_pcnt,le.populated_intnet_email_address_4_pcnt,le.populated_intnet_email_address_5_pcnt,le.populated_intnet_instant_message_addr_1_pcnt,le.populated_intnet_instant_message_addr_2_pcnt,le.populated_intnet_instant_message_addr_3_pcnt,le.populated_intnet_instant_message_addr_4_pcnt,le.populated_intnet_instant_message_addr_5_pcnt,le.populated_intnet_user_name_1_pcnt,le.populated_intnet_user_name_1_url_pcnt,le.populated_intnet_user_name_2_pcnt,le.populated_intnet_user_name_2_url_pcnt,le.populated_intnet_user_name_3_pcnt,le.populated_intnet_user_name_3_url_pcnt,le.populated_intnet_user_name_4_pcnt,le.populated_intnet_user_name_4_url_pcnt,le.populated_intnet_user_name_5_pcnt,le.populated_intnet_user_name_5_url_pcnt,le.populated_offender_status_pcnt,le.populated_offender_category_pcnt,le.populated_risk_level_code_pcnt,le.populated_risk_description_pcnt,le.populated_police_agency_pcnt,le.populated_police_agency_contact_name_pcnt,le.populated_police_agency_address_1_pcnt,le.populated_police_agency_address_2_pcnt,le.populated_police_agency_phone_pcnt,le.populated_registration_type_pcnt,le.populated_reg_date_1_pcnt,le.populated_reg_date_1_type_pcnt,le.populated_reg_date_2_pcnt,le.populated_reg_date_2_type_pcnt,le.populated_reg_date_3_pcnt,le.populated_reg_date_3_type_pcnt,le.populated_registration_address_1_pcnt,le.populated_registration_address_2_pcnt,le.populated_registration_address_3_pcnt,le.populated_registration_address_4_pcnt,le.populated_registration_address_5_pcnt,le.populated_registration_county_pcnt,le.populated_registration_home_phone_pcnt,le.populated_registration_cell_phone_pcnt,le.populated_other_registration_address_1_pcnt,le.populated_other_registration_address_2_pcnt,le.populated_other_registration_address_3_pcnt,le.populated_other_registration_address_4_pcnt,le.populated_other_registration_address_5_pcnt,le.populated_other_registration_county_pcnt,le.populated_other_registration_phone_pcnt,le.populated_temp_lodge_address_1_pcnt,le.populated_temp_lodge_address_2_pcnt,le.populated_temp_lodge_address_3_pcnt,le.populated_temp_lodge_address_4_pcnt,le.populated_temp_lodge_address_5_pcnt,le.populated_temp_lodge_county_pcnt,le.populated_temp_lodge_phone_pcnt,le.populated_employer_pcnt,le.populated_employer_address_1_pcnt,le.populated_employer_address_2_pcnt,le.populated_employer_address_3_pcnt,le.populated_employer_address_4_pcnt,le.populated_employer_address_5_pcnt,le.populated_employer_county_pcnt,le.populated_employer_phone_pcnt,le.populated_employer_comments_pcnt,le.populated_professional_licenses_1_pcnt,le.populated_professional_licenses_2_pcnt,le.populated_professional_licenses_3_pcnt,le.populated_professional_licenses_4_pcnt,le.populated_professional_licenses_5_pcnt,le.populated_school_pcnt,le.populated_school_address_1_pcnt,le.populated_school_address_2_pcnt,le.populated_school_address_3_pcnt,le.populated_school_address_4_pcnt,le.populated_school_address_5_pcnt,le.populated_school_county_pcnt,le.populated_school_phone_pcnt,le.populated_school_comments_pcnt,le.populated_offender_id_pcnt,le.populated_doc_number_pcnt,le.populated_sor_number_pcnt,le.populated_st_id_number_pcnt,le.populated_fbi_number_pcnt,le.populated_ncic_number_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_dob_aka_pcnt,le.populated_age_pcnt,le.populated_dna_pcnt,le.populated_race_pcnt,le.populated_ethnicity_pcnt,le.populated_sex_pcnt,le.populated_hair_color_pcnt,le.populated_eye_color_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_skin_tone_pcnt,le.populated_build_type_pcnt,le.populated_scars_marks_tattoos_pcnt,le.populated_shoe_size_pcnt,le.populated_corrective_lense_flag_pcnt,le.populated_addl_comments_1_pcnt,le.populated_addl_comments_2_pcnt,le.populated_orig_dl_number_pcnt,le.populated_orig_dl_state_pcnt,le.populated_orig_dl_link_pcnt,le.populated_orig_dl_date_pcnt,le.populated_passport_type_pcnt,le.populated_passport_code_pcnt,le.populated_passport_number_pcnt,le.populated_passport_first_name_pcnt,le.populated_passport_given_name_pcnt,le.populated_passport_nationality_pcnt,le.populated_passport_dob_pcnt,le.populated_passport_place_of_birth_pcnt,le.populated_passport_sex_pcnt,le.populated_passport_issue_date_pcnt,le.populated_passport_authority_pcnt,le.populated_passport_expiration_date_pcnt,le.populated_passport_endorsement_pcnt,le.populated_passport_link_pcnt,le.populated_passport_date_pcnt,le.populated_orig_veh_year_1_pcnt,le.populated_orig_veh_color_1_pcnt,le.populated_orig_veh_make_model_1_pcnt,le.populated_orig_veh_plate_1_pcnt,le.populated_orig_registration_number_1_pcnt,le.populated_orig_veh_state_1_pcnt,le.populated_orig_veh_location_1_pcnt,le.populated_orig_veh_year_2_pcnt,le.populated_orig_veh_color_2_pcnt,le.populated_orig_veh_make_model_2_pcnt,le.populated_orig_veh_plate_2_pcnt,le.populated_orig_registration_number_2_pcnt,le.populated_orig_veh_state_2_pcnt,le.populated_orig_veh_location_2_pcnt,le.populated_orig_veh_year_3_pcnt,le.populated_orig_veh_color_3_pcnt,le.populated_orig_veh_make_model_3_pcnt,le.populated_orig_veh_plate_3_pcnt,le.populated_orig_registration_number_3_pcnt,le.populated_orig_veh_state_3_pcnt,le.populated_orig_veh_location_3_pcnt,le.populated_orig_veh_year_4_pcnt,le.populated_orig_veh_color_4_pcnt,le.populated_orig_veh_make_model_4_pcnt,le.populated_orig_veh_plate_4_pcnt,le.populated_orig_registration_number_4_pcnt,le.populated_orig_veh_state_4_pcnt,le.populated_orig_veh_location_4_pcnt,le.populated_orig_veh_year_5_pcnt,le.populated_orig_veh_color_5_pcnt,le.populated_orig_veh_make_model_5_pcnt,le.populated_orig_veh_plate_5_pcnt,le.populated_orig_registration_number_5_pcnt,le.populated_orig_veh_state_5_pcnt,le.populated_orig_veh_location_5_pcnt,le.populated_fingerprint_link_pcnt,le.populated_fingerprint_date_pcnt,le.populated_palmprint_link_pcnt,le.populated_palmprint_date_pcnt,le.populated_image_link_pcnt,le.populated_image_date_pcnt,le.populated_addr_dt_last_seen_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_clean_errors_pcnt,le.populated_rawaid_pcnt,le.populated_curr_incar_flag_pcnt,le.populated_curr_parole_flag_pcnt,le.populated_curr_probation_flag_pcnt,le.populated_fcra_conviction_flag_pcnt,le.populated_fcra_traffic_flag_pcnt,le.populated_fcra_date_pcnt,le.populated_fcra_date_type_pcnt,le.populated_conviction_override_date_pcnt,le.populated_conviction_override_date_type_pcnt,le.populated_offense_score_pcnt,le.populated_offender_persistent_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_did,le.maxlength_score,le.maxlength_ssn_appended,le.maxlength_ssn_perms,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_orig_state,le.maxlength_orig_state_code,le.maxlength_seisint_primary_key,le.maxlength_vendor_code,le.maxlength_source_file,le.maxlength_record_type,le.maxlength_name_orig,le.maxlength_lname,le.maxlength_fname,le.maxlength_mname,le.maxlength_name_suffix,le.maxlength_name_type,le.maxlength_nid,le.maxlength_ntype,le.maxlength_nindicator,le.maxlength_intnet_email_address_1,le.maxlength_intnet_email_address_2,le.maxlength_intnet_email_address_3,le.maxlength_intnet_email_address_4,le.maxlength_intnet_email_address_5,le.maxlength_intnet_instant_message_addr_1,le.maxlength_intnet_instant_message_addr_2,le.maxlength_intnet_instant_message_addr_3,le.maxlength_intnet_instant_message_addr_4,le.maxlength_intnet_instant_message_addr_5,le.maxlength_intnet_user_name_1,le.maxlength_intnet_user_name_1_url,le.maxlength_intnet_user_name_2,le.maxlength_intnet_user_name_2_url,le.maxlength_intnet_user_name_3,le.maxlength_intnet_user_name_3_url,le.maxlength_intnet_user_name_4,le.maxlength_intnet_user_name_4_url,le.maxlength_intnet_user_name_5,le.maxlength_intnet_user_name_5_url,le.maxlength_offender_status,le.maxlength_offender_category,le.maxlength_risk_level_code,le.maxlength_risk_description,le.maxlength_police_agency,le.maxlength_police_agency_contact_name,le.maxlength_police_agency_address_1,le.maxlength_police_agency_address_2,le.maxlength_police_agency_phone,le.maxlength_registration_type,le.maxlength_reg_date_1,le.maxlength_reg_date_1_type,le.maxlength_reg_date_2,le.maxlength_reg_date_2_type,le.maxlength_reg_date_3,le.maxlength_reg_date_3_type,le.maxlength_registration_address_1,le.maxlength_registration_address_2,le.maxlength_registration_address_3,le.maxlength_registration_address_4,le.maxlength_registration_address_5,le.maxlength_registration_county,le.maxlength_registration_home_phone,le.maxlength_registration_cell_phone,le.maxlength_other_registration_address_1,le.maxlength_other_registration_address_2,le.maxlength_other_registration_address_3,le.maxlength_other_registration_address_4,le.maxlength_other_registration_address_5,le.maxlength_other_registration_county,le.maxlength_other_registration_phone,le.maxlength_temp_lodge_address_1,le.maxlength_temp_lodge_address_2,le.maxlength_temp_lodge_address_3,le.maxlength_temp_lodge_address_4,le.maxlength_temp_lodge_address_5,le.maxlength_temp_lodge_county,le.maxlength_temp_lodge_phone,le.maxlength_employer,le.maxlength_employer_address_1,le.maxlength_employer_address_2,le.maxlength_employer_address_3,le.maxlength_employer_address_4,le.maxlength_employer_address_5,le.maxlength_employer_county,le.maxlength_employer_phone,le.maxlength_employer_comments,le.maxlength_professional_licenses_1,le.maxlength_professional_licenses_2,le.maxlength_professional_licenses_3,le.maxlength_professional_licenses_4,le.maxlength_professional_licenses_5,le.maxlength_school,le.maxlength_school_address_1,le.maxlength_school_address_2,le.maxlength_school_address_3,le.maxlength_school_address_4,le.maxlength_school_address_5,le.maxlength_school_county,le.maxlength_school_phone,le.maxlength_school_comments,le.maxlength_offender_id,le.maxlength_doc_number,le.maxlength_sor_number,le.maxlength_st_id_number,le.maxlength_fbi_number,le.maxlength_ncic_number,le.maxlength_ssn,le.maxlength_dob,le.maxlength_dob_aka,le.maxlength_age,le.maxlength_dna,le.maxlength_race,le.maxlength_ethnicity,le.maxlength_sex,le.maxlength_hair_color,le.maxlength_eye_color,le.maxlength_height,le.maxlength_weight,le.maxlength_skin_tone,le.maxlength_build_type,le.maxlength_scars_marks_tattoos,le.maxlength_shoe_size,le.maxlength_corrective_lense_flag,le.maxlength_addl_comments_1,le.maxlength_addl_comments_2,le.maxlength_orig_dl_number,le.maxlength_orig_dl_state,le.maxlength_orig_dl_link,le.maxlength_orig_dl_date,le.maxlength_passport_type,le.maxlength_passport_code,le.maxlength_passport_number,le.maxlength_passport_first_name,le.maxlength_passport_given_name,le.maxlength_passport_nationality,le.maxlength_passport_dob,le.maxlength_passport_place_of_birth,le.maxlength_passport_sex,le.maxlength_passport_issue_date,le.maxlength_passport_authority,le.maxlength_passport_expiration_date,le.maxlength_passport_endorsement,le.maxlength_passport_link,le.maxlength_passport_date,le.maxlength_orig_veh_year_1,le.maxlength_orig_veh_color_1,le.maxlength_orig_veh_make_model_1,le.maxlength_orig_veh_plate_1,le.maxlength_orig_registration_number_1,le.maxlength_orig_veh_state_1,le.maxlength_orig_veh_location_1,le.maxlength_orig_veh_year_2,le.maxlength_orig_veh_color_2,le.maxlength_orig_veh_make_model_2,le.maxlength_orig_veh_plate_2,le.maxlength_orig_registration_number_2,le.maxlength_orig_veh_state_2,le.maxlength_orig_veh_location_2,le.maxlength_orig_veh_year_3,le.maxlength_orig_veh_color_3,le.maxlength_orig_veh_make_model_3,le.maxlength_orig_veh_plate_3,le.maxlength_orig_registration_number_3,le.maxlength_orig_veh_state_3,le.maxlength_orig_veh_location_3,le.maxlength_orig_veh_year_4,le.maxlength_orig_veh_color_4,le.maxlength_orig_veh_make_model_4,le.maxlength_orig_veh_plate_4,le.maxlength_orig_registration_number_4,le.maxlength_orig_veh_state_4,le.maxlength_orig_veh_location_4,le.maxlength_orig_veh_year_5,le.maxlength_orig_veh_color_5,le.maxlength_orig_veh_make_model_5,le.maxlength_orig_veh_plate_5,le.maxlength_orig_registration_number_5,le.maxlength_orig_veh_state_5,le.maxlength_orig_veh_location_5,le.maxlength_fingerprint_link,le.maxlength_fingerprint_date,le.maxlength_palmprint_link,le.maxlength_palmprint_date,le.maxlength_image_link,le.maxlength_image_date,le.maxlength_addr_dt_last_seen,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_clean_errors,le.maxlength_rawaid,le.maxlength_curr_incar_flag,le.maxlength_curr_parole_flag,le.maxlength_curr_probation_flag,le.maxlength_fcra_conviction_flag,le.maxlength_fcra_traffic_flag,le.maxlength_fcra_date,le.maxlength_fcra_date_type,le.maxlength_conviction_override_date,le.maxlength_conviction_override_date_type,le.maxlength_offense_score,le.maxlength_offender_persistent_id);
  SELF.avelength := CHOOSE(C,le.avelength_did,le.avelength_score,le.avelength_ssn_appended,le.avelength_ssn_perms,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_orig_state,le.avelength_orig_state_code,le.avelength_seisint_primary_key,le.avelength_vendor_code,le.avelength_source_file,le.avelength_record_type,le.avelength_name_orig,le.avelength_lname,le.avelength_fname,le.avelength_mname,le.avelength_name_suffix,le.avelength_name_type,le.avelength_nid,le.avelength_ntype,le.avelength_nindicator,le.avelength_intnet_email_address_1,le.avelength_intnet_email_address_2,le.avelength_intnet_email_address_3,le.avelength_intnet_email_address_4,le.avelength_intnet_email_address_5,le.avelength_intnet_instant_message_addr_1,le.avelength_intnet_instant_message_addr_2,le.avelength_intnet_instant_message_addr_3,le.avelength_intnet_instant_message_addr_4,le.avelength_intnet_instant_message_addr_5,le.avelength_intnet_user_name_1,le.avelength_intnet_user_name_1_url,le.avelength_intnet_user_name_2,le.avelength_intnet_user_name_2_url,le.avelength_intnet_user_name_3,le.avelength_intnet_user_name_3_url,le.avelength_intnet_user_name_4,le.avelength_intnet_user_name_4_url,le.avelength_intnet_user_name_5,le.avelength_intnet_user_name_5_url,le.avelength_offender_status,le.avelength_offender_category,le.avelength_risk_level_code,le.avelength_risk_description,le.avelength_police_agency,le.avelength_police_agency_contact_name,le.avelength_police_agency_address_1,le.avelength_police_agency_address_2,le.avelength_police_agency_phone,le.avelength_registration_type,le.avelength_reg_date_1,le.avelength_reg_date_1_type,le.avelength_reg_date_2,le.avelength_reg_date_2_type,le.avelength_reg_date_3,le.avelength_reg_date_3_type,le.avelength_registration_address_1,le.avelength_registration_address_2,le.avelength_registration_address_3,le.avelength_registration_address_4,le.avelength_registration_address_5,le.avelength_registration_county,le.avelength_registration_home_phone,le.avelength_registration_cell_phone,le.avelength_other_registration_address_1,le.avelength_other_registration_address_2,le.avelength_other_registration_address_3,le.avelength_other_registration_address_4,le.avelength_other_registration_address_5,le.avelength_other_registration_county,le.avelength_other_registration_phone,le.avelength_temp_lodge_address_1,le.avelength_temp_lodge_address_2,le.avelength_temp_lodge_address_3,le.avelength_temp_lodge_address_4,le.avelength_temp_lodge_address_5,le.avelength_temp_lodge_county,le.avelength_temp_lodge_phone,le.avelength_employer,le.avelength_employer_address_1,le.avelength_employer_address_2,le.avelength_employer_address_3,le.avelength_employer_address_4,le.avelength_employer_address_5,le.avelength_employer_county,le.avelength_employer_phone,le.avelength_employer_comments,le.avelength_professional_licenses_1,le.avelength_professional_licenses_2,le.avelength_professional_licenses_3,le.avelength_professional_licenses_4,le.avelength_professional_licenses_5,le.avelength_school,le.avelength_school_address_1,le.avelength_school_address_2,le.avelength_school_address_3,le.avelength_school_address_4,le.avelength_school_address_5,le.avelength_school_county,le.avelength_school_phone,le.avelength_school_comments,le.avelength_offender_id,le.avelength_doc_number,le.avelength_sor_number,le.avelength_st_id_number,le.avelength_fbi_number,le.avelength_ncic_number,le.avelength_ssn,le.avelength_dob,le.avelength_dob_aka,le.avelength_age,le.avelength_dna,le.avelength_race,le.avelength_ethnicity,le.avelength_sex,le.avelength_hair_color,le.avelength_eye_color,le.avelength_height,le.avelength_weight,le.avelength_skin_tone,le.avelength_build_type,le.avelength_scars_marks_tattoos,le.avelength_shoe_size,le.avelength_corrective_lense_flag,le.avelength_addl_comments_1,le.avelength_addl_comments_2,le.avelength_orig_dl_number,le.avelength_orig_dl_state,le.avelength_orig_dl_link,le.avelength_orig_dl_date,le.avelength_passport_type,le.avelength_passport_code,le.avelength_passport_number,le.avelength_passport_first_name,le.avelength_passport_given_name,le.avelength_passport_nationality,le.avelength_passport_dob,le.avelength_passport_place_of_birth,le.avelength_passport_sex,le.avelength_passport_issue_date,le.avelength_passport_authority,le.avelength_passport_expiration_date,le.avelength_passport_endorsement,le.avelength_passport_link,le.avelength_passport_date,le.avelength_orig_veh_year_1,le.avelength_orig_veh_color_1,le.avelength_orig_veh_make_model_1,le.avelength_orig_veh_plate_1,le.avelength_orig_registration_number_1,le.avelength_orig_veh_state_1,le.avelength_orig_veh_location_1,le.avelength_orig_veh_year_2,le.avelength_orig_veh_color_2,le.avelength_orig_veh_make_model_2,le.avelength_orig_veh_plate_2,le.avelength_orig_registration_number_2,le.avelength_orig_veh_state_2,le.avelength_orig_veh_location_2,le.avelength_orig_veh_year_3,le.avelength_orig_veh_color_3,le.avelength_orig_veh_make_model_3,le.avelength_orig_veh_plate_3,le.avelength_orig_registration_number_3,le.avelength_orig_veh_state_3,le.avelength_orig_veh_location_3,le.avelength_orig_veh_year_4,le.avelength_orig_veh_color_4,le.avelength_orig_veh_make_model_4,le.avelength_orig_veh_plate_4,le.avelength_orig_registration_number_4,le.avelength_orig_veh_state_4,le.avelength_orig_veh_location_4,le.avelength_orig_veh_year_5,le.avelength_orig_veh_color_5,le.avelength_orig_veh_make_model_5,le.avelength_orig_veh_plate_5,le.avelength_orig_registration_number_5,le.avelength_orig_veh_state_5,le.avelength_orig_veh_location_5,le.avelength_fingerprint_link,le.avelength_fingerprint_date,le.avelength_palmprint_link,le.avelength_palmprint_date,le.avelength_image_link,le.avelength_image_date,le.avelength_addr_dt_last_seen,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_clean_errors,le.avelength_rawaid,le.avelength_curr_incar_flag,le.avelength_curr_parole_flag,le.avelength_curr_probation_flag,le.avelength_fcra_conviction_flag,le.avelength_fcra_traffic_flag,le.avelength_fcra_date,le.avelength_fcra_date_type,le.avelength_conviction_override_date,le.avelength_conviction_override_date_type,le.avelength_offense_score,le.avelength_offender_persistent_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 227, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.orig_state_code;
  SELF.Fld := TRIM(CHOOSE(C,IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.ssn_appended),IF (le.ssn_perms <> 0,TRIM((SALT33.StrType)le.ssn_perms), ''),TRIM((SALT33.StrType)le.dt_first_reported),TRIM((SALT33.StrType)le.dt_last_reported),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.name_orig),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_type),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.intnet_email_address_1),TRIM((SALT33.StrType)le.intnet_email_address_2),TRIM((SALT33.StrType)le.intnet_email_address_3),TRIM((SALT33.StrType)le.intnet_email_address_4),TRIM((SALT33.StrType)le.intnet_email_address_5),TRIM((SALT33.StrType)le.intnet_instant_message_addr_1),TRIM((SALT33.StrType)le.intnet_instant_message_addr_2),TRIM((SALT33.StrType)le.intnet_instant_message_addr_3),TRIM((SALT33.StrType)le.intnet_instant_message_addr_4),TRIM((SALT33.StrType)le.intnet_instant_message_addr_5),TRIM((SALT33.StrType)le.intnet_user_name_1),TRIM((SALT33.StrType)le.intnet_user_name_1_url),TRIM((SALT33.StrType)le.intnet_user_name_2),TRIM((SALT33.StrType)le.intnet_user_name_2_url),TRIM((SALT33.StrType)le.intnet_user_name_3),TRIM((SALT33.StrType)le.intnet_user_name_3_url),TRIM((SALT33.StrType)le.intnet_user_name_4),TRIM((SALT33.StrType)le.intnet_user_name_4_url),TRIM((SALT33.StrType)le.intnet_user_name_5),TRIM((SALT33.StrType)le.intnet_user_name_5_url),TRIM((SALT33.StrType)le.offender_status),TRIM((SALT33.StrType)le.offender_category),TRIM((SALT33.StrType)le.risk_level_code),TRIM((SALT33.StrType)le.risk_description),TRIM((SALT33.StrType)le.police_agency),TRIM((SALT33.StrType)le.police_agency_contact_name),TRIM((SALT33.StrType)le.police_agency_address_1),TRIM((SALT33.StrType)le.police_agency_address_2),TRIM((SALT33.StrType)le.police_agency_phone),TRIM((SALT33.StrType)le.registration_type),TRIM((SALT33.StrType)le.reg_date_1),TRIM((SALT33.StrType)le.reg_date_1_type),TRIM((SALT33.StrType)le.reg_date_2),TRIM((SALT33.StrType)le.reg_date_2_type),TRIM((SALT33.StrType)le.reg_date_3),TRIM((SALT33.StrType)le.reg_date_3_type),TRIM((SALT33.StrType)le.registration_address_1),TRIM((SALT33.StrType)le.registration_address_2),TRIM((SALT33.StrType)le.registration_address_3),TRIM((SALT33.StrType)le.registration_address_4),TRIM((SALT33.StrType)le.registration_address_5),TRIM((SALT33.StrType)le.registration_county),TRIM((SALT33.StrType)le.registration_home_phone),TRIM((SALT33.StrType)le.registration_cell_phone),TRIM((SALT33.StrType)le.other_registration_address_1),TRIM((SALT33.StrType)le.other_registration_address_2),TRIM((SALT33.StrType)le.other_registration_address_3),TRIM((SALT33.StrType)le.other_registration_address_4),TRIM((SALT33.StrType)le.other_registration_address_5),TRIM((SALT33.StrType)le.other_registration_county),TRIM((SALT33.StrType)le.other_registration_phone),TRIM((SALT33.StrType)le.temp_lodge_address_1),TRIM((SALT33.StrType)le.temp_lodge_address_2),TRIM((SALT33.StrType)le.temp_lodge_address_3),TRIM((SALT33.StrType)le.temp_lodge_address_4),TRIM((SALT33.StrType)le.temp_lodge_address_5),TRIM((SALT33.StrType)le.temp_lodge_county),TRIM((SALT33.StrType)le.temp_lodge_phone),TRIM((SALT33.StrType)le.employer),TRIM((SALT33.StrType)le.employer_address_1),TRIM((SALT33.StrType)le.employer_address_2),TRIM((SALT33.StrType)le.employer_address_3),TRIM((SALT33.StrType)le.employer_address_4),TRIM((SALT33.StrType)le.employer_address_5),TRIM((SALT33.StrType)le.employer_county),TRIM((SALT33.StrType)le.employer_phone),TRIM((SALT33.StrType)le.employer_comments),TRIM((SALT33.StrType)le.professional_licenses_1),TRIM((SALT33.StrType)le.professional_licenses_2),TRIM((SALT33.StrType)le.professional_licenses_3),TRIM((SALT33.StrType)le.professional_licenses_4),TRIM((SALT33.StrType)le.professional_licenses_5),TRIM((SALT33.StrType)le.school),TRIM((SALT33.StrType)le.school_address_1),TRIM((SALT33.StrType)le.school_address_2),TRIM((SALT33.StrType)le.school_address_3),TRIM((SALT33.StrType)le.school_address_4),TRIM((SALT33.StrType)le.school_address_5),TRIM((SALT33.StrType)le.school_county),TRIM((SALT33.StrType)le.school_phone),TRIM((SALT33.StrType)le.school_comments),TRIM((SALT33.StrType)le.offender_id),TRIM((SALT33.StrType)le.doc_number),TRIM((SALT33.StrType)le.sor_number),TRIM((SALT33.StrType)le.st_id_number),TRIM((SALT33.StrType)le.fbi_number),TRIM((SALT33.StrType)le.ncic_number),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_aka),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.dna),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.skin_tone),TRIM((SALT33.StrType)le.build_type),TRIM((SALT33.StrType)le.scars_marks_tattoos),TRIM((SALT33.StrType)le.shoe_size),TRIM((SALT33.StrType)le.corrective_lense_flag),TRIM((SALT33.StrType)le.addl_comments_1),TRIM((SALT33.StrType)le.addl_comments_2),TRIM((SALT33.StrType)le.orig_dl_number),TRIM((SALT33.StrType)le.orig_dl_state),TRIM((SALT33.StrType)le.orig_dl_link),TRIM((SALT33.StrType)le.orig_dl_date),TRIM((SALT33.StrType)le.passport_type),TRIM((SALT33.StrType)le.passport_code),TRIM((SALT33.StrType)le.passport_number),TRIM((SALT33.StrType)le.passport_first_name),TRIM((SALT33.StrType)le.passport_given_name),TRIM((SALT33.StrType)le.passport_nationality),TRIM((SALT33.StrType)le.passport_dob),TRIM((SALT33.StrType)le.passport_place_of_birth),TRIM((SALT33.StrType)le.passport_sex),TRIM((SALT33.StrType)le.passport_issue_date),TRIM((SALT33.StrType)le.passport_authority),TRIM((SALT33.StrType)le.passport_expiration_date),TRIM((SALT33.StrType)le.passport_endorsement),TRIM((SALT33.StrType)le.passport_link),TRIM((SALT33.StrType)le.passport_date),TRIM((SALT33.StrType)le.orig_veh_year_1),TRIM((SALT33.StrType)le.orig_veh_color_1),TRIM((SALT33.StrType)le.orig_veh_make_model_1),TRIM((SALT33.StrType)le.orig_veh_plate_1),TRIM((SALT33.StrType)le.orig_registration_number_1),TRIM((SALT33.StrType)le.orig_veh_state_1),TRIM((SALT33.StrType)le.orig_veh_location_1),TRIM((SALT33.StrType)le.orig_veh_year_2),TRIM((SALT33.StrType)le.orig_veh_color_2),TRIM((SALT33.StrType)le.orig_veh_make_model_2),TRIM((SALT33.StrType)le.orig_veh_plate_2),TRIM((SALT33.StrType)le.orig_registration_number_2),TRIM((SALT33.StrType)le.orig_veh_state_2),TRIM((SALT33.StrType)le.orig_veh_location_2),TRIM((SALT33.StrType)le.orig_veh_year_3),TRIM((SALT33.StrType)le.orig_veh_color_3),TRIM((SALT33.StrType)le.orig_veh_make_model_3),TRIM((SALT33.StrType)le.orig_veh_plate_3),TRIM((SALT33.StrType)le.orig_registration_number_3),TRIM((SALT33.StrType)le.orig_veh_state_3),TRIM((SALT33.StrType)le.orig_veh_location_3),TRIM((SALT33.StrType)le.orig_veh_year_4),TRIM((SALT33.StrType)le.orig_veh_color_4),TRIM((SALT33.StrType)le.orig_veh_make_model_4),TRIM((SALT33.StrType)le.orig_veh_plate_4),TRIM((SALT33.StrType)le.orig_registration_number_4),TRIM((SALT33.StrType)le.orig_veh_state_4),TRIM((SALT33.StrType)le.orig_veh_location_4),TRIM((SALT33.StrType)le.orig_veh_year_5),TRIM((SALT33.StrType)le.orig_veh_color_5),TRIM((SALT33.StrType)le.orig_veh_make_model_5),TRIM((SALT33.StrType)le.orig_veh_plate_5),TRIM((SALT33.StrType)le.orig_registration_number_5),TRIM((SALT33.StrType)le.orig_veh_state_5),TRIM((SALT33.StrType)le.orig_veh_location_5),TRIM((SALT33.StrType)le.fingerprint_link),TRIM((SALT33.StrType)le.fingerprint_date),TRIM((SALT33.StrType)le.palmprint_link),TRIM((SALT33.StrType)le.palmprint_date),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.image_date),TRIM((SALT33.StrType)le.addr_dt_last_seen),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,227,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 227);
  SELF.FldNo2 := 1 + (C % 227);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.ssn_appended),IF (le.ssn_perms <> 0,TRIM((SALT33.StrType)le.ssn_perms), ''),TRIM((SALT33.StrType)le.dt_first_reported),TRIM((SALT33.StrType)le.dt_last_reported),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.name_orig),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_type),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.intnet_email_address_1),TRIM((SALT33.StrType)le.intnet_email_address_2),TRIM((SALT33.StrType)le.intnet_email_address_3),TRIM((SALT33.StrType)le.intnet_email_address_4),TRIM((SALT33.StrType)le.intnet_email_address_5),TRIM((SALT33.StrType)le.intnet_instant_message_addr_1),TRIM((SALT33.StrType)le.intnet_instant_message_addr_2),TRIM((SALT33.StrType)le.intnet_instant_message_addr_3),TRIM((SALT33.StrType)le.intnet_instant_message_addr_4),TRIM((SALT33.StrType)le.intnet_instant_message_addr_5),TRIM((SALT33.StrType)le.intnet_user_name_1),TRIM((SALT33.StrType)le.intnet_user_name_1_url),TRIM((SALT33.StrType)le.intnet_user_name_2),TRIM((SALT33.StrType)le.intnet_user_name_2_url),TRIM((SALT33.StrType)le.intnet_user_name_3),TRIM((SALT33.StrType)le.intnet_user_name_3_url),TRIM((SALT33.StrType)le.intnet_user_name_4),TRIM((SALT33.StrType)le.intnet_user_name_4_url),TRIM((SALT33.StrType)le.intnet_user_name_5),TRIM((SALT33.StrType)le.intnet_user_name_5_url),TRIM((SALT33.StrType)le.offender_status),TRIM((SALT33.StrType)le.offender_category),TRIM((SALT33.StrType)le.risk_level_code),TRIM((SALT33.StrType)le.risk_description),TRIM((SALT33.StrType)le.police_agency),TRIM((SALT33.StrType)le.police_agency_contact_name),TRIM((SALT33.StrType)le.police_agency_address_1),TRIM((SALT33.StrType)le.police_agency_address_2),TRIM((SALT33.StrType)le.police_agency_phone),TRIM((SALT33.StrType)le.registration_type),TRIM((SALT33.StrType)le.reg_date_1),TRIM((SALT33.StrType)le.reg_date_1_type),TRIM((SALT33.StrType)le.reg_date_2),TRIM((SALT33.StrType)le.reg_date_2_type),TRIM((SALT33.StrType)le.reg_date_3),TRIM((SALT33.StrType)le.reg_date_3_type),TRIM((SALT33.StrType)le.registration_address_1),TRIM((SALT33.StrType)le.registration_address_2),TRIM((SALT33.StrType)le.registration_address_3),TRIM((SALT33.StrType)le.registration_address_4),TRIM((SALT33.StrType)le.registration_address_5),TRIM((SALT33.StrType)le.registration_county),TRIM((SALT33.StrType)le.registration_home_phone),TRIM((SALT33.StrType)le.registration_cell_phone),TRIM((SALT33.StrType)le.other_registration_address_1),TRIM((SALT33.StrType)le.other_registration_address_2),TRIM((SALT33.StrType)le.other_registration_address_3),TRIM((SALT33.StrType)le.other_registration_address_4),TRIM((SALT33.StrType)le.other_registration_address_5),TRIM((SALT33.StrType)le.other_registration_county),TRIM((SALT33.StrType)le.other_registration_phone),TRIM((SALT33.StrType)le.temp_lodge_address_1),TRIM((SALT33.StrType)le.temp_lodge_address_2),TRIM((SALT33.StrType)le.temp_lodge_address_3),TRIM((SALT33.StrType)le.temp_lodge_address_4),TRIM((SALT33.StrType)le.temp_lodge_address_5),TRIM((SALT33.StrType)le.temp_lodge_county),TRIM((SALT33.StrType)le.temp_lodge_phone),TRIM((SALT33.StrType)le.employer),TRIM((SALT33.StrType)le.employer_address_1),TRIM((SALT33.StrType)le.employer_address_2),TRIM((SALT33.StrType)le.employer_address_3),TRIM((SALT33.StrType)le.employer_address_4),TRIM((SALT33.StrType)le.employer_address_5),TRIM((SALT33.StrType)le.employer_county),TRIM((SALT33.StrType)le.employer_phone),TRIM((SALT33.StrType)le.employer_comments),TRIM((SALT33.StrType)le.professional_licenses_1),TRIM((SALT33.StrType)le.professional_licenses_2),TRIM((SALT33.StrType)le.professional_licenses_3),TRIM((SALT33.StrType)le.professional_licenses_4),TRIM((SALT33.StrType)le.professional_licenses_5),TRIM((SALT33.StrType)le.school),TRIM((SALT33.StrType)le.school_address_1),TRIM((SALT33.StrType)le.school_address_2),TRIM((SALT33.StrType)le.school_address_3),TRIM((SALT33.StrType)le.school_address_4),TRIM((SALT33.StrType)le.school_address_5),TRIM((SALT33.StrType)le.school_county),TRIM((SALT33.StrType)le.school_phone),TRIM((SALT33.StrType)le.school_comments),TRIM((SALT33.StrType)le.offender_id),TRIM((SALT33.StrType)le.doc_number),TRIM((SALT33.StrType)le.sor_number),TRIM((SALT33.StrType)le.st_id_number),TRIM((SALT33.StrType)le.fbi_number),TRIM((SALT33.StrType)le.ncic_number),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_aka),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.dna),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.skin_tone),TRIM((SALT33.StrType)le.build_type),TRIM((SALT33.StrType)le.scars_marks_tattoos),TRIM((SALT33.StrType)le.shoe_size),TRIM((SALT33.StrType)le.corrective_lense_flag),TRIM((SALT33.StrType)le.addl_comments_1),TRIM((SALT33.StrType)le.addl_comments_2),TRIM((SALT33.StrType)le.orig_dl_number),TRIM((SALT33.StrType)le.orig_dl_state),TRIM((SALT33.StrType)le.orig_dl_link),TRIM((SALT33.StrType)le.orig_dl_date),TRIM((SALT33.StrType)le.passport_type),TRIM((SALT33.StrType)le.passport_code),TRIM((SALT33.StrType)le.passport_number),TRIM((SALT33.StrType)le.passport_first_name),TRIM((SALT33.StrType)le.passport_given_name),TRIM((SALT33.StrType)le.passport_nationality),TRIM((SALT33.StrType)le.passport_dob),TRIM((SALT33.StrType)le.passport_place_of_birth),TRIM((SALT33.StrType)le.passport_sex),TRIM((SALT33.StrType)le.passport_issue_date),TRIM((SALT33.StrType)le.passport_authority),TRIM((SALT33.StrType)le.passport_expiration_date),TRIM((SALT33.StrType)le.passport_endorsement),TRIM((SALT33.StrType)le.passport_link),TRIM((SALT33.StrType)le.passport_date),TRIM((SALT33.StrType)le.orig_veh_year_1),TRIM((SALT33.StrType)le.orig_veh_color_1),TRIM((SALT33.StrType)le.orig_veh_make_model_1),TRIM((SALT33.StrType)le.orig_veh_plate_1),TRIM((SALT33.StrType)le.orig_registration_number_1),TRIM((SALT33.StrType)le.orig_veh_state_1),TRIM((SALT33.StrType)le.orig_veh_location_1),TRIM((SALT33.StrType)le.orig_veh_year_2),TRIM((SALT33.StrType)le.orig_veh_color_2),TRIM((SALT33.StrType)le.orig_veh_make_model_2),TRIM((SALT33.StrType)le.orig_veh_plate_2),TRIM((SALT33.StrType)le.orig_registration_number_2),TRIM((SALT33.StrType)le.orig_veh_state_2),TRIM((SALT33.StrType)le.orig_veh_location_2),TRIM((SALT33.StrType)le.orig_veh_year_3),TRIM((SALT33.StrType)le.orig_veh_color_3),TRIM((SALT33.StrType)le.orig_veh_make_model_3),TRIM((SALT33.StrType)le.orig_veh_plate_3),TRIM((SALT33.StrType)le.orig_registration_number_3),TRIM((SALT33.StrType)le.orig_veh_state_3),TRIM((SALT33.StrType)le.orig_veh_location_3),TRIM((SALT33.StrType)le.orig_veh_year_4),TRIM((SALT33.StrType)le.orig_veh_color_4),TRIM((SALT33.StrType)le.orig_veh_make_model_4),TRIM((SALT33.StrType)le.orig_veh_plate_4),TRIM((SALT33.StrType)le.orig_registration_number_4),TRIM((SALT33.StrType)le.orig_veh_state_4),TRIM((SALT33.StrType)le.orig_veh_location_4),TRIM((SALT33.StrType)le.orig_veh_year_5),TRIM((SALT33.StrType)le.orig_veh_color_5),TRIM((SALT33.StrType)le.orig_veh_make_model_5),TRIM((SALT33.StrType)le.orig_veh_plate_5),TRIM((SALT33.StrType)le.orig_registration_number_5),TRIM((SALT33.StrType)le.orig_veh_state_5),TRIM((SALT33.StrType)le.orig_veh_location_5),TRIM((SALT33.StrType)le.fingerprint_link),TRIM((SALT33.StrType)le.fingerprint_date),TRIM((SALT33.StrType)le.palmprint_link),TRIM((SALT33.StrType)le.palmprint_date),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.image_date),TRIM((SALT33.StrType)le.addr_dt_last_seen),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.did <> 0,TRIM((SALT33.StrType)le.did), ''),IF (le.score <> 0,TRIM((SALT33.StrType)le.score), ''),TRIM((SALT33.StrType)le.ssn_appended),IF (le.ssn_perms <> 0,TRIM((SALT33.StrType)le.ssn_perms), ''),TRIM((SALT33.StrType)le.dt_first_reported),TRIM((SALT33.StrType)le.dt_last_reported),TRIM((SALT33.StrType)le.orig_state),TRIM((SALT33.StrType)le.orig_state_code),TRIM((SALT33.StrType)le.seisint_primary_key),TRIM((SALT33.StrType)le.vendor_code),TRIM((SALT33.StrType)le.source_file),TRIM((SALT33.StrType)le.record_type),TRIM((SALT33.StrType)le.name_orig),TRIM((SALT33.StrType)le.lname),TRIM((SALT33.StrType)le.fname),TRIM((SALT33.StrType)le.mname),TRIM((SALT33.StrType)le.name_suffix),TRIM((SALT33.StrType)le.name_type),IF (le.nid <> 0,TRIM((SALT33.StrType)le.nid), ''),TRIM((SALT33.StrType)le.ntype),IF (le.nindicator <> 0,TRIM((SALT33.StrType)le.nindicator), ''),TRIM((SALT33.StrType)le.intnet_email_address_1),TRIM((SALT33.StrType)le.intnet_email_address_2),TRIM((SALT33.StrType)le.intnet_email_address_3),TRIM((SALT33.StrType)le.intnet_email_address_4),TRIM((SALT33.StrType)le.intnet_email_address_5),TRIM((SALT33.StrType)le.intnet_instant_message_addr_1),TRIM((SALT33.StrType)le.intnet_instant_message_addr_2),TRIM((SALT33.StrType)le.intnet_instant_message_addr_3),TRIM((SALT33.StrType)le.intnet_instant_message_addr_4),TRIM((SALT33.StrType)le.intnet_instant_message_addr_5),TRIM((SALT33.StrType)le.intnet_user_name_1),TRIM((SALT33.StrType)le.intnet_user_name_1_url),TRIM((SALT33.StrType)le.intnet_user_name_2),TRIM((SALT33.StrType)le.intnet_user_name_2_url),TRIM((SALT33.StrType)le.intnet_user_name_3),TRIM((SALT33.StrType)le.intnet_user_name_3_url),TRIM((SALT33.StrType)le.intnet_user_name_4),TRIM((SALT33.StrType)le.intnet_user_name_4_url),TRIM((SALT33.StrType)le.intnet_user_name_5),TRIM((SALT33.StrType)le.intnet_user_name_5_url),TRIM((SALT33.StrType)le.offender_status),TRIM((SALT33.StrType)le.offender_category),TRIM((SALT33.StrType)le.risk_level_code),TRIM((SALT33.StrType)le.risk_description),TRIM((SALT33.StrType)le.police_agency),TRIM((SALT33.StrType)le.police_agency_contact_name),TRIM((SALT33.StrType)le.police_agency_address_1),TRIM((SALT33.StrType)le.police_agency_address_2),TRIM((SALT33.StrType)le.police_agency_phone),TRIM((SALT33.StrType)le.registration_type),TRIM((SALT33.StrType)le.reg_date_1),TRIM((SALT33.StrType)le.reg_date_1_type),TRIM((SALT33.StrType)le.reg_date_2),TRIM((SALT33.StrType)le.reg_date_2_type),TRIM((SALT33.StrType)le.reg_date_3),TRIM((SALT33.StrType)le.reg_date_3_type),TRIM((SALT33.StrType)le.registration_address_1),TRIM((SALT33.StrType)le.registration_address_2),TRIM((SALT33.StrType)le.registration_address_3),TRIM((SALT33.StrType)le.registration_address_4),TRIM((SALT33.StrType)le.registration_address_5),TRIM((SALT33.StrType)le.registration_county),TRIM((SALT33.StrType)le.registration_home_phone),TRIM((SALT33.StrType)le.registration_cell_phone),TRIM((SALT33.StrType)le.other_registration_address_1),TRIM((SALT33.StrType)le.other_registration_address_2),TRIM((SALT33.StrType)le.other_registration_address_3),TRIM((SALT33.StrType)le.other_registration_address_4),TRIM((SALT33.StrType)le.other_registration_address_5),TRIM((SALT33.StrType)le.other_registration_county),TRIM((SALT33.StrType)le.other_registration_phone),TRIM((SALT33.StrType)le.temp_lodge_address_1),TRIM((SALT33.StrType)le.temp_lodge_address_2),TRIM((SALT33.StrType)le.temp_lodge_address_3),TRIM((SALT33.StrType)le.temp_lodge_address_4),TRIM((SALT33.StrType)le.temp_lodge_address_5),TRIM((SALT33.StrType)le.temp_lodge_county),TRIM((SALT33.StrType)le.temp_lodge_phone),TRIM((SALT33.StrType)le.employer),TRIM((SALT33.StrType)le.employer_address_1),TRIM((SALT33.StrType)le.employer_address_2),TRIM((SALT33.StrType)le.employer_address_3),TRIM((SALT33.StrType)le.employer_address_4),TRIM((SALT33.StrType)le.employer_address_5),TRIM((SALT33.StrType)le.employer_county),TRIM((SALT33.StrType)le.employer_phone),TRIM((SALT33.StrType)le.employer_comments),TRIM((SALT33.StrType)le.professional_licenses_1),TRIM((SALT33.StrType)le.professional_licenses_2),TRIM((SALT33.StrType)le.professional_licenses_3),TRIM((SALT33.StrType)le.professional_licenses_4),TRIM((SALT33.StrType)le.professional_licenses_5),TRIM((SALT33.StrType)le.school),TRIM((SALT33.StrType)le.school_address_1),TRIM((SALT33.StrType)le.school_address_2),TRIM((SALT33.StrType)le.school_address_3),TRIM((SALT33.StrType)le.school_address_4),TRIM((SALT33.StrType)le.school_address_5),TRIM((SALT33.StrType)le.school_county),TRIM((SALT33.StrType)le.school_phone),TRIM((SALT33.StrType)le.school_comments),TRIM((SALT33.StrType)le.offender_id),TRIM((SALT33.StrType)le.doc_number),TRIM((SALT33.StrType)le.sor_number),TRIM((SALT33.StrType)le.st_id_number),TRIM((SALT33.StrType)le.fbi_number),TRIM((SALT33.StrType)le.ncic_number),TRIM((SALT33.StrType)le.ssn),TRIM((SALT33.StrType)le.dob),TRIM((SALT33.StrType)le.dob_aka),TRIM((SALT33.StrType)le.age),TRIM((SALT33.StrType)le.dna),TRIM((SALT33.StrType)le.race),TRIM((SALT33.StrType)le.ethnicity),TRIM((SALT33.StrType)le.sex),TRIM((SALT33.StrType)le.hair_color),TRIM((SALT33.StrType)le.eye_color),TRIM((SALT33.StrType)le.height),TRIM((SALT33.StrType)le.weight),TRIM((SALT33.StrType)le.skin_tone),TRIM((SALT33.StrType)le.build_type),TRIM((SALT33.StrType)le.scars_marks_tattoos),TRIM((SALT33.StrType)le.shoe_size),TRIM((SALT33.StrType)le.corrective_lense_flag),TRIM((SALT33.StrType)le.addl_comments_1),TRIM((SALT33.StrType)le.addl_comments_2),TRIM((SALT33.StrType)le.orig_dl_number),TRIM((SALT33.StrType)le.orig_dl_state),TRIM((SALT33.StrType)le.orig_dl_link),TRIM((SALT33.StrType)le.orig_dl_date),TRIM((SALT33.StrType)le.passport_type),TRIM((SALT33.StrType)le.passport_code),TRIM((SALT33.StrType)le.passport_number),TRIM((SALT33.StrType)le.passport_first_name),TRIM((SALT33.StrType)le.passport_given_name),TRIM((SALT33.StrType)le.passport_nationality),TRIM((SALT33.StrType)le.passport_dob),TRIM((SALT33.StrType)le.passport_place_of_birth),TRIM((SALT33.StrType)le.passport_sex),TRIM((SALT33.StrType)le.passport_issue_date),TRIM((SALT33.StrType)le.passport_authority),TRIM((SALT33.StrType)le.passport_expiration_date),TRIM((SALT33.StrType)le.passport_endorsement),TRIM((SALT33.StrType)le.passport_link),TRIM((SALT33.StrType)le.passport_date),TRIM((SALT33.StrType)le.orig_veh_year_1),TRIM((SALT33.StrType)le.orig_veh_color_1),TRIM((SALT33.StrType)le.orig_veh_make_model_1),TRIM((SALT33.StrType)le.orig_veh_plate_1),TRIM((SALT33.StrType)le.orig_registration_number_1),TRIM((SALT33.StrType)le.orig_veh_state_1),TRIM((SALT33.StrType)le.orig_veh_location_1),TRIM((SALT33.StrType)le.orig_veh_year_2),TRIM((SALT33.StrType)le.orig_veh_color_2),TRIM((SALT33.StrType)le.orig_veh_make_model_2),TRIM((SALT33.StrType)le.orig_veh_plate_2),TRIM((SALT33.StrType)le.orig_registration_number_2),TRIM((SALT33.StrType)le.orig_veh_state_2),TRIM((SALT33.StrType)le.orig_veh_location_2),TRIM((SALT33.StrType)le.orig_veh_year_3),TRIM((SALT33.StrType)le.orig_veh_color_3),TRIM((SALT33.StrType)le.orig_veh_make_model_3),TRIM((SALT33.StrType)le.orig_veh_plate_3),TRIM((SALT33.StrType)le.orig_registration_number_3),TRIM((SALT33.StrType)le.orig_veh_state_3),TRIM((SALT33.StrType)le.orig_veh_location_3),TRIM((SALT33.StrType)le.orig_veh_year_4),TRIM((SALT33.StrType)le.orig_veh_color_4),TRIM((SALT33.StrType)le.orig_veh_make_model_4),TRIM((SALT33.StrType)le.orig_veh_plate_4),TRIM((SALT33.StrType)le.orig_registration_number_4),TRIM((SALT33.StrType)le.orig_veh_state_4),TRIM((SALT33.StrType)le.orig_veh_location_4),TRIM((SALT33.StrType)le.orig_veh_year_5),TRIM((SALT33.StrType)le.orig_veh_color_5),TRIM((SALT33.StrType)le.orig_veh_make_model_5),TRIM((SALT33.StrType)le.orig_veh_plate_5),TRIM((SALT33.StrType)le.orig_registration_number_5),TRIM((SALT33.StrType)le.orig_veh_state_5),TRIM((SALT33.StrType)le.orig_veh_location_5),TRIM((SALT33.StrType)le.fingerprint_link),TRIM((SALT33.StrType)le.fingerprint_date),TRIM((SALT33.StrType)le.palmprint_link),TRIM((SALT33.StrType)le.palmprint_date),TRIM((SALT33.StrType)le.image_link),TRIM((SALT33.StrType)le.image_date),TRIM((SALT33.StrType)le.addr_dt_last_seen),TRIM((SALT33.StrType)le.prim_range),TRIM((SALT33.StrType)le.predir),TRIM((SALT33.StrType)le.prim_name),TRIM((SALT33.StrType)le.addr_suffix),TRIM((SALT33.StrType)le.postdir),TRIM((SALT33.StrType)le.unit_desig),TRIM((SALT33.StrType)le.sec_range),TRIM((SALT33.StrType)le.p_city_name),TRIM((SALT33.StrType)le.v_city_name),TRIM((SALT33.StrType)le.st),TRIM((SALT33.StrType)le.zip5),TRIM((SALT33.StrType)le.zip4),TRIM((SALT33.StrType)le.cart),TRIM((SALT33.StrType)le.cr_sort_sz),TRIM((SALT33.StrType)le.lot),TRIM((SALT33.StrType)le.lot_order),TRIM((SALT33.StrType)le.dbpc),TRIM((SALT33.StrType)le.chk_digit),TRIM((SALT33.StrType)le.rec_type),TRIM((SALT33.StrType)le.county),TRIM((SALT33.StrType)le.geo_lat),TRIM((SALT33.StrType)le.geo_long),TRIM((SALT33.StrType)le.msa),TRIM((SALT33.StrType)le.geo_blk),TRIM((SALT33.StrType)le.geo_match),TRIM((SALT33.StrType)le.err_stat),IF (le.clean_errors <> 0,TRIM((SALT33.StrType)le.clean_errors), ''),IF (le.rawaid <> 0,TRIM((SALT33.StrType)le.rawaid), ''),TRIM((SALT33.StrType)le.curr_incar_flag),TRIM((SALT33.StrType)le.curr_parole_flag),TRIM((SALT33.StrType)le.curr_probation_flag),TRIM((SALT33.StrType)le.fcra_conviction_flag),TRIM((SALT33.StrType)le.fcra_traffic_flag),TRIM((SALT33.StrType)le.fcra_date),TRIM((SALT33.StrType)le.fcra_date_type),TRIM((SALT33.StrType)le.conviction_override_date),TRIM((SALT33.StrType)le.conviction_override_date_type),TRIM((SALT33.StrType)le.offense_score),IF (le.offender_persistent_id <> 0,TRIM((SALT33.StrType)le.offender_persistent_id), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),227*227,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'did'}
      ,{2,'score'}
      ,{3,'ssn_appended'}
      ,{4,'ssn_perms'}
      ,{5,'dt_first_reported'}
      ,{6,'dt_last_reported'}
      ,{7,'orig_state'}
      ,{8,'orig_state_code'}
      ,{9,'seisint_primary_key'}
      ,{10,'vendor_code'}
      ,{11,'source_file'}
      ,{12,'record_type'}
      ,{13,'name_orig'}
      ,{14,'lname'}
      ,{15,'fname'}
      ,{16,'mname'}
      ,{17,'name_suffix'}
      ,{18,'name_type'}
      ,{19,'nid'}
      ,{20,'ntype'}
      ,{21,'nindicator'}
      ,{22,'intnet_email_address_1'}
      ,{23,'intnet_email_address_2'}
      ,{24,'intnet_email_address_3'}
      ,{25,'intnet_email_address_4'}
      ,{26,'intnet_email_address_5'}
      ,{27,'intnet_instant_message_addr_1'}
      ,{28,'intnet_instant_message_addr_2'}
      ,{29,'intnet_instant_message_addr_3'}
      ,{30,'intnet_instant_message_addr_4'}
      ,{31,'intnet_instant_message_addr_5'}
      ,{32,'intnet_user_name_1'}
      ,{33,'intnet_user_name_1_url'}
      ,{34,'intnet_user_name_2'}
      ,{35,'intnet_user_name_2_url'}
      ,{36,'intnet_user_name_3'}
      ,{37,'intnet_user_name_3_url'}
      ,{38,'intnet_user_name_4'}
      ,{39,'intnet_user_name_4_url'}
      ,{40,'intnet_user_name_5'}
      ,{41,'intnet_user_name_5_url'}
      ,{42,'offender_status'}
      ,{43,'offender_category'}
      ,{44,'risk_level_code'}
      ,{45,'risk_description'}
      ,{46,'police_agency'}
      ,{47,'police_agency_contact_name'}
      ,{48,'police_agency_address_1'}
      ,{49,'police_agency_address_2'}
      ,{50,'police_agency_phone'}
      ,{51,'registration_type'}
      ,{52,'reg_date_1'}
      ,{53,'reg_date_1_type'}
      ,{54,'reg_date_2'}
      ,{55,'reg_date_2_type'}
      ,{56,'reg_date_3'}
      ,{57,'reg_date_3_type'}
      ,{58,'registration_address_1'}
      ,{59,'registration_address_2'}
      ,{60,'registration_address_3'}
      ,{61,'registration_address_4'}
      ,{62,'registration_address_5'}
      ,{63,'registration_county'}
      ,{64,'registration_home_phone'}
      ,{65,'registration_cell_phone'}
      ,{66,'other_registration_address_1'}
      ,{67,'other_registration_address_2'}
      ,{68,'other_registration_address_3'}
      ,{69,'other_registration_address_4'}
      ,{70,'other_registration_address_5'}
      ,{71,'other_registration_county'}
      ,{72,'other_registration_phone'}
      ,{73,'temp_lodge_address_1'}
      ,{74,'temp_lodge_address_2'}
      ,{75,'temp_lodge_address_3'}
      ,{76,'temp_lodge_address_4'}
      ,{77,'temp_lodge_address_5'}
      ,{78,'temp_lodge_county'}
      ,{79,'temp_lodge_phone'}
      ,{80,'employer'}
      ,{81,'employer_address_1'}
      ,{82,'employer_address_2'}
      ,{83,'employer_address_3'}
      ,{84,'employer_address_4'}
      ,{85,'employer_address_5'}
      ,{86,'employer_county'}
      ,{87,'employer_phone'}
      ,{88,'employer_comments'}
      ,{89,'professional_licenses_1'}
      ,{90,'professional_licenses_2'}
      ,{91,'professional_licenses_3'}
      ,{92,'professional_licenses_4'}
      ,{93,'professional_licenses_5'}
      ,{94,'school'}
      ,{95,'school_address_1'}
      ,{96,'school_address_2'}
      ,{97,'school_address_3'}
      ,{98,'school_address_4'}
      ,{99,'school_address_5'}
      ,{100,'school_county'}
      ,{101,'school_phone'}
      ,{102,'school_comments'}
      ,{103,'offender_id'}
      ,{104,'doc_number'}
      ,{105,'sor_number'}
      ,{106,'st_id_number'}
      ,{107,'fbi_number'}
      ,{108,'ncic_number'}
      ,{109,'ssn'}
      ,{110,'dob'}
      ,{111,'dob_aka'}
      ,{112,'age'}
      ,{113,'dna'}
      ,{114,'race'}
      ,{115,'ethnicity'}
      ,{116,'sex'}
      ,{117,'hair_color'}
      ,{118,'eye_color'}
      ,{119,'height'}
      ,{120,'weight'}
      ,{121,'skin_tone'}
      ,{122,'build_type'}
      ,{123,'scars_marks_tattoos'}
      ,{124,'shoe_size'}
      ,{125,'corrective_lense_flag'}
      ,{126,'addl_comments_1'}
      ,{127,'addl_comments_2'}
      ,{128,'orig_dl_number'}
      ,{129,'orig_dl_state'}
      ,{130,'orig_dl_link'}
      ,{131,'orig_dl_date'}
      ,{132,'passport_type'}
      ,{133,'passport_code'}
      ,{134,'passport_number'}
      ,{135,'passport_first_name'}
      ,{136,'passport_given_name'}
      ,{137,'passport_nationality'}
      ,{138,'passport_dob'}
      ,{139,'passport_place_of_birth'}
      ,{140,'passport_sex'}
      ,{141,'passport_issue_date'}
      ,{142,'passport_authority'}
      ,{143,'passport_expiration_date'}
      ,{144,'passport_endorsement'}
      ,{145,'passport_link'}
      ,{146,'passport_date'}
      ,{147,'orig_veh_year_1'}
      ,{148,'orig_veh_color_1'}
      ,{149,'orig_veh_make_model_1'}
      ,{150,'orig_veh_plate_1'}
      ,{151,'orig_registration_number_1'}
      ,{152,'orig_veh_state_1'}
      ,{153,'orig_veh_location_1'}
      ,{154,'orig_veh_year_2'}
      ,{155,'orig_veh_color_2'}
      ,{156,'orig_veh_make_model_2'}
      ,{157,'orig_veh_plate_2'}
      ,{158,'orig_registration_number_2'}
      ,{159,'orig_veh_state_2'}
      ,{160,'orig_veh_location_2'}
      ,{161,'orig_veh_year_3'}
      ,{162,'orig_veh_color_3'}
      ,{163,'orig_veh_make_model_3'}
      ,{164,'orig_veh_plate_3'}
      ,{165,'orig_registration_number_3'}
      ,{166,'orig_veh_state_3'}
      ,{167,'orig_veh_location_3'}
      ,{168,'orig_veh_year_4'}
      ,{169,'orig_veh_color_4'}
      ,{170,'orig_veh_make_model_4'}
      ,{171,'orig_veh_plate_4'}
      ,{172,'orig_registration_number_4'}
      ,{173,'orig_veh_state_4'}
      ,{174,'orig_veh_location_4'}
      ,{175,'orig_veh_year_5'}
      ,{176,'orig_veh_color_5'}
      ,{177,'orig_veh_make_model_5'}
      ,{178,'orig_veh_plate_5'}
      ,{179,'orig_registration_number_5'}
      ,{180,'orig_veh_state_5'}
      ,{181,'orig_veh_location_5'}
      ,{182,'fingerprint_link'}
      ,{183,'fingerprint_date'}
      ,{184,'palmprint_link'}
      ,{185,'palmprint_date'}
      ,{186,'image_link'}
      ,{187,'image_date'}
      ,{188,'addr_dt_last_seen'}
      ,{189,'prim_range'}
      ,{190,'predir'}
      ,{191,'prim_name'}
      ,{192,'addr_suffix'}
      ,{193,'postdir'}
      ,{194,'unit_desig'}
      ,{195,'sec_range'}
      ,{196,'p_city_name'}
      ,{197,'v_city_name'}
      ,{198,'st'}
      ,{199,'zip5'}
      ,{200,'zip4'}
      ,{201,'cart'}
      ,{202,'cr_sort_sz'}
      ,{203,'lot'}
      ,{204,'lot_order'}
      ,{205,'dbpc'}
      ,{206,'chk_digit'}
      ,{207,'rec_type'}
      ,{208,'county'}
      ,{209,'geo_lat'}
      ,{210,'geo_long'}
      ,{211,'msa'}
      ,{212,'geo_blk'}
      ,{213,'geo_match'}
      ,{214,'err_stat'}
      ,{215,'clean_errors'}
      ,{216,'rawaid'}
      ,{217,'curr_incar_flag'}
      ,{218,'curr_parole_flag'}
      ,{219,'curr_probation_flag'}
      ,{220,'fcra_conviction_flag'}
      ,{221,'fcra_traffic_flag'}
      ,{222,'fcra_date'}
      ,{223,'fcra_date_type'}
      ,{224,'conviction_override_date'}
      ,{225,'conviction_override_date_type'}
      ,{226,'offense_score'}
      ,{227,'offender_persistent_id'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.orig_state_code) orig_state_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_did((SALT33.StrType)le.did),
    Fields.InValid_score((SALT33.StrType)le.score),
    Fields.InValid_ssn_appended((SALT33.StrType)le.ssn_appended),
    Fields.InValid_ssn_perms((SALT33.StrType)le.ssn_perms),
    Fields.InValid_dt_first_reported((SALT33.StrType)le.dt_first_reported),
    Fields.InValid_dt_last_reported((SALT33.StrType)le.dt_last_reported),
    Fields.InValid_orig_state((SALT33.StrType)le.orig_state),
    Fields.InValid_orig_state_code((SALT33.StrType)le.orig_state_code),
    Fields.InValid_seisint_primary_key((SALT33.StrType)le.seisint_primary_key),
    Fields.InValid_vendor_code((SALT33.StrType)le.vendor_code),
    Fields.InValid_source_file((SALT33.StrType)le.source_file),
    Fields.InValid_record_type((SALT33.StrType)le.record_type),
    Fields.InValid_name_orig((SALT33.StrType)le.name_orig),
    Fields.InValid_lname((SALT33.StrType)le.lname),
    Fields.InValid_fname((SALT33.StrType)le.fname),
    Fields.InValid_mname((SALT33.StrType)le.mname),
    Fields.InValid_name_suffix((SALT33.StrType)le.name_suffix),
    Fields.InValid_name_type((SALT33.StrType)le.name_type),
    Fields.InValid_nid((SALT33.StrType)le.nid),
    Fields.InValid_ntype((SALT33.StrType)le.ntype),
    Fields.InValid_nindicator((SALT33.StrType)le.nindicator),
    Fields.InValid_intnet_email_address_1((SALT33.StrType)le.intnet_email_address_1),
    Fields.InValid_intnet_email_address_2((SALT33.StrType)le.intnet_email_address_2),
    Fields.InValid_intnet_email_address_3((SALT33.StrType)le.intnet_email_address_3),
    Fields.InValid_intnet_email_address_4((SALT33.StrType)le.intnet_email_address_4),
    Fields.InValid_intnet_email_address_5((SALT33.StrType)le.intnet_email_address_5),
    Fields.InValid_intnet_instant_message_addr_1((SALT33.StrType)le.intnet_instant_message_addr_1),
    Fields.InValid_intnet_instant_message_addr_2((SALT33.StrType)le.intnet_instant_message_addr_2),
    Fields.InValid_intnet_instant_message_addr_3((SALT33.StrType)le.intnet_instant_message_addr_3),
    Fields.InValid_intnet_instant_message_addr_4((SALT33.StrType)le.intnet_instant_message_addr_4),
    Fields.InValid_intnet_instant_message_addr_5((SALT33.StrType)le.intnet_instant_message_addr_5),
    Fields.InValid_intnet_user_name_1((SALT33.StrType)le.intnet_user_name_1),
    Fields.InValid_intnet_user_name_1_url((SALT33.StrType)le.intnet_user_name_1_url),
    Fields.InValid_intnet_user_name_2((SALT33.StrType)le.intnet_user_name_2),
    Fields.InValid_intnet_user_name_2_url((SALT33.StrType)le.intnet_user_name_2_url),
    Fields.InValid_intnet_user_name_3((SALT33.StrType)le.intnet_user_name_3),
    Fields.InValid_intnet_user_name_3_url((SALT33.StrType)le.intnet_user_name_3_url),
    Fields.InValid_intnet_user_name_4((SALT33.StrType)le.intnet_user_name_4),
    Fields.InValid_intnet_user_name_4_url((SALT33.StrType)le.intnet_user_name_4_url),
    Fields.InValid_intnet_user_name_5((SALT33.StrType)le.intnet_user_name_5),
    Fields.InValid_intnet_user_name_5_url((SALT33.StrType)le.intnet_user_name_5_url),
    Fields.InValid_offender_status((SALT33.StrType)le.offender_status),
    Fields.InValid_offender_category((SALT33.StrType)le.offender_category),
    Fields.InValid_risk_level_code((SALT33.StrType)le.risk_level_code),
    Fields.InValid_risk_description((SALT33.StrType)le.risk_description),
    Fields.InValid_police_agency((SALT33.StrType)le.police_agency),
    Fields.InValid_police_agency_contact_name((SALT33.StrType)le.police_agency_contact_name),
    Fields.InValid_police_agency_address_1((SALT33.StrType)le.police_agency_address_1),
    Fields.InValid_police_agency_address_2((SALT33.StrType)le.police_agency_address_2),
    Fields.InValid_police_agency_phone((SALT33.StrType)le.police_agency_phone),
    Fields.InValid_registration_type((SALT33.StrType)le.registration_type),
    Fields.InValid_reg_date_1((SALT33.StrType)le.reg_date_1),
    Fields.InValid_reg_date_1_type((SALT33.StrType)le.reg_date_1_type),
    Fields.InValid_reg_date_2((SALT33.StrType)le.reg_date_2),
    Fields.InValid_reg_date_2_type((SALT33.StrType)le.reg_date_2_type),
    Fields.InValid_reg_date_3((SALT33.StrType)le.reg_date_3),
    Fields.InValid_reg_date_3_type((SALT33.StrType)le.reg_date_3_type),
    Fields.InValid_registration_address_1((SALT33.StrType)le.registration_address_1),
    Fields.InValid_registration_address_2((SALT33.StrType)le.registration_address_2),
    Fields.InValid_registration_address_3((SALT33.StrType)le.registration_address_3),
    Fields.InValid_registration_address_4((SALT33.StrType)le.registration_address_4),
    Fields.InValid_registration_address_5((SALT33.StrType)le.registration_address_5),
    Fields.InValid_registration_county((SALT33.StrType)le.registration_county),
    Fields.InValid_registration_home_phone((SALT33.StrType)le.registration_home_phone),
    Fields.InValid_registration_cell_phone((SALT33.StrType)le.registration_cell_phone),
    Fields.InValid_other_registration_address_1((SALT33.StrType)le.other_registration_address_1),
    Fields.InValid_other_registration_address_2((SALT33.StrType)le.other_registration_address_2),
    Fields.InValid_other_registration_address_3((SALT33.StrType)le.other_registration_address_3),
    Fields.InValid_other_registration_address_4((SALT33.StrType)le.other_registration_address_4),
    Fields.InValid_other_registration_address_5((SALT33.StrType)le.other_registration_address_5),
    Fields.InValid_other_registration_county((SALT33.StrType)le.other_registration_county),
    Fields.InValid_other_registration_phone((SALT33.StrType)le.other_registration_phone),
    Fields.InValid_temp_lodge_address_1((SALT33.StrType)le.temp_lodge_address_1),
    Fields.InValid_temp_lodge_address_2((SALT33.StrType)le.temp_lodge_address_2),
    Fields.InValid_temp_lodge_address_3((SALT33.StrType)le.temp_lodge_address_3),
    Fields.InValid_temp_lodge_address_4((SALT33.StrType)le.temp_lodge_address_4),
    Fields.InValid_temp_lodge_address_5((SALT33.StrType)le.temp_lodge_address_5),
    Fields.InValid_temp_lodge_county((SALT33.StrType)le.temp_lodge_county),
    Fields.InValid_temp_lodge_phone((SALT33.StrType)le.temp_lodge_phone),
    Fields.InValid_employer((SALT33.StrType)le.employer),
    Fields.InValid_employer_address_1((SALT33.StrType)le.employer_address_1),
    Fields.InValid_employer_address_2((SALT33.StrType)le.employer_address_2),
    Fields.InValid_employer_address_3((SALT33.StrType)le.employer_address_3),
    Fields.InValid_employer_address_4((SALT33.StrType)le.employer_address_4),
    Fields.InValid_employer_address_5((SALT33.StrType)le.employer_address_5),
    Fields.InValid_employer_county((SALT33.StrType)le.employer_county),
    Fields.InValid_employer_phone((SALT33.StrType)le.employer_phone),
    Fields.InValid_employer_comments((SALT33.StrType)le.employer_comments),
    Fields.InValid_professional_licenses_1((SALT33.StrType)le.professional_licenses_1),
    Fields.InValid_professional_licenses_2((SALT33.StrType)le.professional_licenses_2),
    Fields.InValid_professional_licenses_3((SALT33.StrType)le.professional_licenses_3),
    Fields.InValid_professional_licenses_4((SALT33.StrType)le.professional_licenses_4),
    Fields.InValid_professional_licenses_5((SALT33.StrType)le.professional_licenses_5),
    Fields.InValid_school((SALT33.StrType)le.school),
    Fields.InValid_school_address_1((SALT33.StrType)le.school_address_1),
    Fields.InValid_school_address_2((SALT33.StrType)le.school_address_2),
    Fields.InValid_school_address_3((SALT33.StrType)le.school_address_3),
    Fields.InValid_school_address_4((SALT33.StrType)le.school_address_4),
    Fields.InValid_school_address_5((SALT33.StrType)le.school_address_5),
    Fields.InValid_school_county((SALT33.StrType)le.school_county),
    Fields.InValid_school_phone((SALT33.StrType)le.school_phone),
    Fields.InValid_school_comments((SALT33.StrType)le.school_comments),
    Fields.InValid_offender_id((SALT33.StrType)le.offender_id),
    Fields.InValid_doc_number((SALT33.StrType)le.doc_number),
    Fields.InValid_sor_number((SALT33.StrType)le.sor_number),
    Fields.InValid_st_id_number((SALT33.StrType)le.st_id_number),
    Fields.InValid_fbi_number((SALT33.StrType)le.fbi_number),
    Fields.InValid_ncic_number((SALT33.StrType)le.ncic_number),
    Fields.InValid_ssn((SALT33.StrType)le.ssn),
    Fields.InValid_dob((SALT33.StrType)le.dob),
    Fields.InValid_dob_aka((SALT33.StrType)le.dob_aka),
    Fields.InValid_age((SALT33.StrType)le.age),
    Fields.InValid_dna((SALT33.StrType)le.dna),
    Fields.InValid_race((SALT33.StrType)le.race),
    Fields.InValid_ethnicity((SALT33.StrType)le.ethnicity),
    Fields.InValid_sex((SALT33.StrType)le.sex),
    Fields.InValid_hair_color((SALT33.StrType)le.hair_color),
    Fields.InValid_eye_color((SALT33.StrType)le.eye_color),
    Fields.InValid_height((SALT33.StrType)le.height),
    Fields.InValid_weight((SALT33.StrType)le.weight),
    Fields.InValid_skin_tone((SALT33.StrType)le.skin_tone),
    Fields.InValid_build_type((SALT33.StrType)le.build_type),
    Fields.InValid_scars_marks_tattoos((SALT33.StrType)le.scars_marks_tattoos),
    Fields.InValid_shoe_size((SALT33.StrType)le.shoe_size),
    Fields.InValid_corrective_lense_flag((SALT33.StrType)le.corrective_lense_flag),
    Fields.InValid_addl_comments_1((SALT33.StrType)le.addl_comments_1),
    Fields.InValid_addl_comments_2((SALT33.StrType)le.addl_comments_2),
    Fields.InValid_orig_dl_number((SALT33.StrType)le.orig_dl_number),
    Fields.InValid_orig_dl_state((SALT33.StrType)le.orig_dl_state),
    Fields.InValid_orig_dl_link((SALT33.StrType)le.orig_dl_link),
    Fields.InValid_orig_dl_date((SALT33.StrType)le.orig_dl_date),
    Fields.InValid_passport_type((SALT33.StrType)le.passport_type),
    Fields.InValid_passport_code((SALT33.StrType)le.passport_code),
    Fields.InValid_passport_number((SALT33.StrType)le.passport_number),
    Fields.InValid_passport_first_name((SALT33.StrType)le.passport_first_name),
    Fields.InValid_passport_given_name((SALT33.StrType)le.passport_given_name),
    Fields.InValid_passport_nationality((SALT33.StrType)le.passport_nationality),
    Fields.InValid_passport_dob((SALT33.StrType)le.passport_dob),
    Fields.InValid_passport_place_of_birth((SALT33.StrType)le.passport_place_of_birth),
    Fields.InValid_passport_sex((SALT33.StrType)le.passport_sex),
    Fields.InValid_passport_issue_date((SALT33.StrType)le.passport_issue_date),
    Fields.InValid_passport_authority((SALT33.StrType)le.passport_authority),
    Fields.InValid_passport_expiration_date((SALT33.StrType)le.passport_expiration_date),
    Fields.InValid_passport_endorsement((SALT33.StrType)le.passport_endorsement),
    Fields.InValid_passport_link((SALT33.StrType)le.passport_link),
    Fields.InValid_passport_date((SALT33.StrType)le.passport_date),
    Fields.InValid_orig_veh_year_1((SALT33.StrType)le.orig_veh_year_1),
    Fields.InValid_orig_veh_color_1((SALT33.StrType)le.orig_veh_color_1),
    Fields.InValid_orig_veh_make_model_1((SALT33.StrType)le.orig_veh_make_model_1),
    Fields.InValid_orig_veh_plate_1((SALT33.StrType)le.orig_veh_plate_1),
    Fields.InValid_orig_registration_number_1((SALT33.StrType)le.orig_registration_number_1),
    Fields.InValid_orig_veh_state_1((SALT33.StrType)le.orig_veh_state_1),
    Fields.InValid_orig_veh_location_1((SALT33.StrType)le.orig_veh_location_1),
    Fields.InValid_orig_veh_year_2((SALT33.StrType)le.orig_veh_year_2),
    Fields.InValid_orig_veh_color_2((SALT33.StrType)le.orig_veh_color_2),
    Fields.InValid_orig_veh_make_model_2((SALT33.StrType)le.orig_veh_make_model_2),
    Fields.InValid_orig_veh_plate_2((SALT33.StrType)le.orig_veh_plate_2),
    Fields.InValid_orig_registration_number_2((SALT33.StrType)le.orig_registration_number_2),
    Fields.InValid_orig_veh_state_2((SALT33.StrType)le.orig_veh_state_2),
    Fields.InValid_orig_veh_location_2((SALT33.StrType)le.orig_veh_location_2),
    Fields.InValid_orig_veh_year_3((SALT33.StrType)le.orig_veh_year_3),
    Fields.InValid_orig_veh_color_3((SALT33.StrType)le.orig_veh_color_3),
    Fields.InValid_orig_veh_make_model_3((SALT33.StrType)le.orig_veh_make_model_3),
    Fields.InValid_orig_veh_plate_3((SALT33.StrType)le.orig_veh_plate_3),
    Fields.InValid_orig_registration_number_3((SALT33.StrType)le.orig_registration_number_3),
    Fields.InValid_orig_veh_state_3((SALT33.StrType)le.orig_veh_state_3),
    Fields.InValid_orig_veh_location_3((SALT33.StrType)le.orig_veh_location_3),
    Fields.InValid_orig_veh_year_4((SALT33.StrType)le.orig_veh_year_4),
    Fields.InValid_orig_veh_color_4((SALT33.StrType)le.orig_veh_color_4),
    Fields.InValid_orig_veh_make_model_4((SALT33.StrType)le.orig_veh_make_model_4),
    Fields.InValid_orig_veh_plate_4((SALT33.StrType)le.orig_veh_plate_4),
    Fields.InValid_orig_registration_number_4((SALT33.StrType)le.orig_registration_number_4),
    Fields.InValid_orig_veh_state_4((SALT33.StrType)le.orig_veh_state_4),
    Fields.InValid_orig_veh_location_4((SALT33.StrType)le.orig_veh_location_4),
    Fields.InValid_orig_veh_year_5((SALT33.StrType)le.orig_veh_year_5),
    Fields.InValid_orig_veh_color_5((SALT33.StrType)le.orig_veh_color_5),
    Fields.InValid_orig_veh_make_model_5((SALT33.StrType)le.orig_veh_make_model_5),
    Fields.InValid_orig_veh_plate_5((SALT33.StrType)le.orig_veh_plate_5),
    Fields.InValid_orig_registration_number_5((SALT33.StrType)le.orig_registration_number_5),
    Fields.InValid_orig_veh_state_5((SALT33.StrType)le.orig_veh_state_5),
    Fields.InValid_orig_veh_location_5((SALT33.StrType)le.orig_veh_location_5),
    Fields.InValid_fingerprint_link((SALT33.StrType)le.fingerprint_link),
    Fields.InValid_fingerprint_date((SALT33.StrType)le.fingerprint_date),
    Fields.InValid_palmprint_link((SALT33.StrType)le.palmprint_link),
    Fields.InValid_palmprint_date((SALT33.StrType)le.palmprint_date),
    Fields.InValid_image_link((SALT33.StrType)le.image_link),
    Fields.InValid_image_date((SALT33.StrType)le.image_date),
    Fields.InValid_addr_dt_last_seen((SALT33.StrType)le.addr_dt_last_seen),
    Fields.InValid_prim_range((SALT33.StrType)le.prim_range),
    Fields.InValid_predir((SALT33.StrType)le.predir),
    Fields.InValid_prim_name((SALT33.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT33.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT33.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT33.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT33.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT33.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT33.StrType)le.v_city_name),
    Fields.InValid_st((SALT33.StrType)le.st),
    Fields.InValid_zip5((SALT33.StrType)le.zip5),
    Fields.InValid_zip4((SALT33.StrType)le.zip4),
    Fields.InValid_cart((SALT33.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT33.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT33.StrType)le.lot),
    Fields.InValid_lot_order((SALT33.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT33.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT33.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT33.StrType)le.rec_type),
    Fields.InValid_county((SALT33.StrType)le.county),
    Fields.InValid_geo_lat((SALT33.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT33.StrType)le.geo_long),
    Fields.InValid_msa((SALT33.StrType)le.msa),
    Fields.InValid_geo_blk((SALT33.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT33.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT33.StrType)le.err_stat),
    Fields.InValid_clean_errors((SALT33.StrType)le.clean_errors),
    Fields.InValid_rawaid((SALT33.StrType)le.rawaid),
    Fields.InValid_curr_incar_flag((SALT33.StrType)le.curr_incar_flag),
    Fields.InValid_curr_parole_flag((SALT33.StrType)le.curr_parole_flag),
    Fields.InValid_curr_probation_flag((SALT33.StrType)le.curr_probation_flag),
    Fields.InValid_fcra_conviction_flag((SALT33.StrType)le.fcra_conviction_flag),
    Fields.InValid_fcra_traffic_flag((SALT33.StrType)le.fcra_traffic_flag),
    Fields.InValid_fcra_date((SALT33.StrType)le.fcra_date),
    Fields.InValid_fcra_date_type((SALT33.StrType)le.fcra_date_type),
    Fields.InValid_conviction_override_date((SALT33.StrType)le.conviction_override_date),
    Fields.InValid_conviction_override_date_type((SALT33.StrType)le.conviction_override_date_type),
    Fields.InValid_offense_score((SALT33.StrType)le.offense_score),
    Fields.InValid_offender_persistent_id((SALT33.StrType)le.offender_persistent_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.orig_state_code := le.orig_state_code;
END;
Errors := NORMALIZE(h,227,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.orig_state_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,orig_state_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.orig_state_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_lname','invalid_fname','invalid_mname','invalid_sname','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_offender_status','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_registration_address_1','invalid_registration_address_2','invalid_registration_address_3','invalid_registration_address_4','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_doc_number','invalid_sor_number','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_age','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_height','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_image_link','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_score(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_appended(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_perms(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state_code(TotalErrors.ErrorNum),Fields.InValidMessage_seisint_primary_key(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_code(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_name_orig(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_nid(TotalErrors.ErrorNum),Fields.InValidMessage_ntype(TotalErrors.ErrorNum),Fields.InValidMessage_nindicator(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_email_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_email_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_email_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_email_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_email_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_instant_message_addr_1(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_instant_message_addr_2(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_instant_message_addr_3(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_instant_message_addr_4(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_instant_message_addr_5(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_1(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_1_url(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_2(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_2_url(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_3(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_3_url(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_4(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_4_url(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_5(TotalErrors.ErrorNum),Fields.InValidMessage_intnet_user_name_5_url(TotalErrors.ErrorNum),Fields.InValidMessage_offender_status(TotalErrors.ErrorNum),Fields.InValidMessage_offender_category(TotalErrors.ErrorNum),Fields.InValidMessage_risk_level_code(TotalErrors.ErrorNum),Fields.InValidMessage_risk_description(TotalErrors.ErrorNum),Fields.InValidMessage_police_agency(TotalErrors.ErrorNum),Fields.InValidMessage_police_agency_contact_name(TotalErrors.ErrorNum),Fields.InValidMessage_police_agency_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_police_agency_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_police_agency_phone(TotalErrors.ErrorNum),Fields.InValidMessage_registration_type(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_1(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_1_type(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_2(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_2_type(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_3(TotalErrors.ErrorNum),Fields.InValidMessage_reg_date_3_type(TotalErrors.ErrorNum),Fields.InValidMessage_registration_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_registration_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_registration_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_registration_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_registration_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_registration_county(TotalErrors.ErrorNum),Fields.InValidMessage_registration_home_phone(TotalErrors.ErrorNum),Fields.InValidMessage_registration_cell_phone(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_county(TotalErrors.ErrorNum),Fields.InValidMessage_other_registration_phone(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_county(TotalErrors.ErrorNum),Fields.InValidMessage_temp_lodge_phone(TotalErrors.ErrorNum),Fields.InValidMessage_employer(TotalErrors.ErrorNum),Fields.InValidMessage_employer_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_employer_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_employer_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_employer_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_employer_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_employer_county(TotalErrors.ErrorNum),Fields.InValidMessage_employer_phone(TotalErrors.ErrorNum),Fields.InValidMessage_employer_comments(TotalErrors.ErrorNum),Fields.InValidMessage_professional_licenses_1(TotalErrors.ErrorNum),Fields.InValidMessage_professional_licenses_2(TotalErrors.ErrorNum),Fields.InValidMessage_professional_licenses_3(TotalErrors.ErrorNum),Fields.InValidMessage_professional_licenses_4(TotalErrors.ErrorNum),Fields.InValidMessage_professional_licenses_5(TotalErrors.ErrorNum),Fields.InValidMessage_school(TotalErrors.ErrorNum),Fields.InValidMessage_school_address_1(TotalErrors.ErrorNum),Fields.InValidMessage_school_address_2(TotalErrors.ErrorNum),Fields.InValidMessage_school_address_3(TotalErrors.ErrorNum),Fields.InValidMessage_school_address_4(TotalErrors.ErrorNum),Fields.InValidMessage_school_address_5(TotalErrors.ErrorNum),Fields.InValidMessage_school_county(TotalErrors.ErrorNum),Fields.InValidMessage_school_phone(TotalErrors.ErrorNum),Fields.InValidMessage_school_comments(TotalErrors.ErrorNum),Fields.InValidMessage_offender_id(TotalErrors.ErrorNum),Fields.InValidMessage_doc_number(TotalErrors.ErrorNum),Fields.InValidMessage_sor_number(TotalErrors.ErrorNum),Fields.InValidMessage_st_id_number(TotalErrors.ErrorNum),Fields.InValidMessage_fbi_number(TotalErrors.ErrorNum),Fields.InValidMessage_ncic_number(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_dob_aka(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_dna(TotalErrors.ErrorNum),Fields.InValidMessage_race(TotalErrors.ErrorNum),Fields.InValidMessage_ethnicity(TotalErrors.ErrorNum),Fields.InValidMessage_sex(TotalErrors.ErrorNum),Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_weight(TotalErrors.ErrorNum),Fields.InValidMessage_skin_tone(TotalErrors.ErrorNum),Fields.InValidMessage_build_type(TotalErrors.ErrorNum),Fields.InValidMessage_scars_marks_tattoos(TotalErrors.ErrorNum),Fields.InValidMessage_shoe_size(TotalErrors.ErrorNum),Fields.InValidMessage_corrective_lense_flag(TotalErrors.ErrorNum),Fields.InValidMessage_addl_comments_1(TotalErrors.ErrorNum),Fields.InValidMessage_addl_comments_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_link(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_date(TotalErrors.ErrorNum),Fields.InValidMessage_passport_type(TotalErrors.ErrorNum),Fields.InValidMessage_passport_code(TotalErrors.ErrorNum),Fields.InValidMessage_passport_number(TotalErrors.ErrorNum),Fields.InValidMessage_passport_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_passport_given_name(TotalErrors.ErrorNum),Fields.InValidMessage_passport_nationality(TotalErrors.ErrorNum),Fields.InValidMessage_passport_dob(TotalErrors.ErrorNum),Fields.InValidMessage_passport_place_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_passport_sex(TotalErrors.ErrorNum),Fields.InValidMessage_passport_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_passport_authority(TotalErrors.ErrorNum),Fields.InValidMessage_passport_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_passport_endorsement(TotalErrors.ErrorNum),Fields.InValidMessage_passport_link(TotalErrors.ErrorNum),Fields.InValidMessage_passport_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_year_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_color_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_make_model_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_plate_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_registration_number_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_state_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_location_1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_year_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_color_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_make_model_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_plate_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_registration_number_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_state_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_location_2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_year_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_color_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_make_model_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_plate_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_registration_number_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_state_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_location_3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_year_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_color_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_make_model_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_plate_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_registration_number_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_state_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_location_4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_year_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_color_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_make_model_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_plate_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_registration_number_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_state_5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_veh_location_5(TotalErrors.ErrorNum),Fields.InValidMessage_fingerprint_link(TotalErrors.ErrorNum),Fields.InValidMessage_fingerprint_date(TotalErrors.ErrorNum),Fields.InValidMessage_palmprint_link(TotalErrors.ErrorNum),Fields.InValidMessage_palmprint_date(TotalErrors.ErrorNum),Fields.InValidMessage_image_link(TotalErrors.ErrorNum),Fields.InValidMessage_image_date(TotalErrors.ErrorNum),Fields.InValidMessage_addr_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_errors(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_curr_incar_flag(TotalErrors.ErrorNum),Fields.InValidMessage_curr_parole_flag(TotalErrors.ErrorNum),Fields.InValidMessage_curr_probation_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_conviction_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_traffic_flag(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_date(TotalErrors.ErrorNum),Fields.InValidMessage_fcra_date_type(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_override_date(TotalErrors.ErrorNum),Fields.InValidMessage_conviction_override_date_type(TotalErrors.ErrorNum),Fields.InValidMessage_offense_score(TotalErrors.ErrorNum),Fields.InValidMessage_offender_persistent_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.orig_state_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;

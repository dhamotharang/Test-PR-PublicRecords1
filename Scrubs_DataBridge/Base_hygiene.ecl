IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_DataBridge) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_clean_company_name_cnt := COUNT(GROUP,h.clean_company_name <> (TYPEOF(h.clean_company_name))'');
    populated_clean_company_name_pcnt := AVE(GROUP,IF(h.clean_company_name = (TYPEOF(h.clean_company_name))'',0,100));
    maxlength_clean_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_company_name)));
    avelength_clean_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_company_name)),h.clean_company_name<>(typeof(h.clean_company_name))'');
    populated_clean_telephone_num_cnt := COUNT(GROUP,h.clean_telephone_num <> (TYPEOF(h.clean_telephone_num))'');
    populated_clean_telephone_num_pcnt := AVE(GROUP,IF(h.clean_telephone_num = (TYPEOF(h.clean_telephone_num))'',0,100));
    maxlength_clean_telephone_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_telephone_num)));
    avelength_clean_telephone_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_telephone_num)),h.clean_telephone_num<>(typeof(h.clean_telephone_num))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code5_cnt := COUNT(GROUP,h.zip_code5 <> (TYPEOF(h.zip_code5))'');
    populated_zip_code5_pcnt := AVE(GROUP,IF(h.zip_code5 = (TYPEOF(h.zip_code5))'',0,100));
    maxlength_zip_code5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code5)));
    avelength_zip_code5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_code5)),h.zip_code5<>(typeof(h.zip_code5))'');
    populated_mail_score_cnt := COUNT(GROUP,h.mail_score <> (TYPEOF(h.mail_score))'');
    populated_mail_score_pcnt := AVE(GROUP,IF(h.mail_score = (TYPEOF(h.mail_score))'',0,100));
    maxlength_mail_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)));
    avelength_mail_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mail_score)),h.mail_score<>(typeof(h.mail_score))'');
    populated_name_gender_cnt := COUNT(GROUP,h.name_gender <> (TYPEOF(h.name_gender))'');
    populated_name_gender_pcnt := AVE(GROUP,IF(h.name_gender = (TYPEOF(h.name_gender))'',0,100));
    maxlength_name_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender)));
    avelength_name_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_gender)),h.name_gender<>(typeof(h.name_gender))'');
    populated_web_address_cnt := COUNT(GROUP,h.web_address <> (TYPEOF(h.web_address))'');
    populated_web_address_pcnt := AVE(GROUP,IF(h.web_address = (TYPEOF(h.web_address))'',0,100));
    maxlength_web_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)));
    avelength_web_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.web_address)),h.web_address<>(typeof(h.web_address))'');
    populated_sic8_1_cnt := COUNT(GROUP,h.sic8_1 <> (TYPEOF(h.sic8_1))'');
    populated_sic8_1_pcnt := AVE(GROUP,IF(h.sic8_1 = (TYPEOF(h.sic8_1))'',0,100));
    maxlength_sic8_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_1)));
    avelength_sic8_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_1)),h.sic8_1<>(typeof(h.sic8_1))'');
    populated_sic8_2_cnt := COUNT(GROUP,h.sic8_2 <> (TYPEOF(h.sic8_2))'');
    populated_sic8_2_pcnt := AVE(GROUP,IF(h.sic8_2 = (TYPEOF(h.sic8_2))'',0,100));
    maxlength_sic8_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_2)));
    avelength_sic8_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_2)),h.sic8_2<>(typeof(h.sic8_2))'');
    populated_sic8_3_cnt := COUNT(GROUP,h.sic8_3 <> (TYPEOF(h.sic8_3))'');
    populated_sic8_3_pcnt := AVE(GROUP,IF(h.sic8_3 = (TYPEOF(h.sic8_3))'',0,100));
    maxlength_sic8_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_3)));
    avelength_sic8_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_3)),h.sic8_3<>(typeof(h.sic8_3))'');
    populated_sic8_4_cnt := COUNT(GROUP,h.sic8_4 <> (TYPEOF(h.sic8_4))'');
    populated_sic8_4_pcnt := AVE(GROUP,IF(h.sic8_4 = (TYPEOF(h.sic8_4))'',0,100));
    maxlength_sic8_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_4)));
    avelength_sic8_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic8_4)),h.sic8_4<>(typeof(h.sic8_4))'');
    populated_sic6_1_cnt := COUNT(GROUP,h.sic6_1 <> (TYPEOF(h.sic6_1))'');
    populated_sic6_1_pcnt := AVE(GROUP,IF(h.sic6_1 = (TYPEOF(h.sic6_1))'',0,100));
    maxlength_sic6_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_1)));
    avelength_sic6_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_1)),h.sic6_1<>(typeof(h.sic6_1))'');
    populated_sic6_2_cnt := COUNT(GROUP,h.sic6_2 <> (TYPEOF(h.sic6_2))'');
    populated_sic6_2_pcnt := AVE(GROUP,IF(h.sic6_2 = (TYPEOF(h.sic6_2))'',0,100));
    maxlength_sic6_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_2)));
    avelength_sic6_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_2)),h.sic6_2<>(typeof(h.sic6_2))'');
    populated_sic6_3_cnt := COUNT(GROUP,h.sic6_3 <> (TYPEOF(h.sic6_3))'');
    populated_sic6_3_pcnt := AVE(GROUP,IF(h.sic6_3 = (TYPEOF(h.sic6_3))'',0,100));
    maxlength_sic6_3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_3)));
    avelength_sic6_3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_3)),h.sic6_3<>(typeof(h.sic6_3))'');
    populated_sic6_4_cnt := COUNT(GROUP,h.sic6_4 <> (TYPEOF(h.sic6_4))'');
    populated_sic6_4_pcnt := AVE(GROUP,IF(h.sic6_4 = (TYPEOF(h.sic6_4))'',0,100));
    maxlength_sic6_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_4)));
    avelength_sic6_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_4)),h.sic6_4<>(typeof(h.sic6_4))'');
    populated_sic6_5_cnt := COUNT(GROUP,h.sic6_5 <> (TYPEOF(h.sic6_5))'');
    populated_sic6_5_pcnt := AVE(GROUP,IF(h.sic6_5 = (TYPEOF(h.sic6_5))'',0,100));
    maxlength_sic6_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_5)));
    avelength_sic6_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic6_5)),h.sic6_5<>(typeof(h.sic6_5))'');
    populated_transaction_date_cnt := COUNT(GROUP,h.transaction_date <> (TYPEOF(h.transaction_date))'');
    populated_transaction_date_pcnt := AVE(GROUP,IF(h.transaction_date = (TYPEOF(h.transaction_date))'',0,100));
    maxlength_transaction_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)));
    avelength_transaction_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.transaction_date)),h.transaction_date<>(typeof(h.transaction_date))'');
    populated_database_site_id_cnt := COUNT(GROUP,h.database_site_id <> (TYPEOF(h.database_site_id))'');
    populated_database_site_id_pcnt := AVE(GROUP,IF(h.database_site_id = (TYPEOF(h.database_site_id))'',0,100));
    maxlength_database_site_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_site_id)));
    avelength_database_site_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_site_id)),h.database_site_id<>(typeof(h.database_site_id))'');
    populated_database_individual_id_cnt := COUNT(GROUP,h.database_individual_id <> (TYPEOF(h.database_individual_id))'');
    populated_database_individual_id_pcnt := AVE(GROUP,IF(h.database_individual_id = (TYPEOF(h.database_individual_id))'',0,100));
    maxlength_database_individual_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_individual_id)));
    avelength_database_individual_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.database_individual_id)),h.database_individual_id<>(typeof(h.database_individual_id))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_email_present_flag_cnt := COUNT(GROUP,h.email_present_flag <> (TYPEOF(h.email_present_flag))'');
    populated_email_present_flag_pcnt := AVE(GROUP,IF(h.email_present_flag = (TYPEOF(h.email_present_flag))'',0,100));
    maxlength_email_present_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_present_flag)));
    avelength_email_present_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_present_flag)),h.email_present_flag<>(typeof(h.email_present_flag))'');
    populated_site_source1_cnt := COUNT(GROUP,h.site_source1 <> (TYPEOF(h.site_source1))'');
    populated_site_source1_pcnt := AVE(GROUP,IF(h.site_source1 = (TYPEOF(h.site_source1))'',0,100));
    maxlength_site_source1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source1)));
    avelength_site_source1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source1)),h.site_source1<>(typeof(h.site_source1))'');
    populated_site_source2_cnt := COUNT(GROUP,h.site_source2 <> (TYPEOF(h.site_source2))'');
    populated_site_source2_pcnt := AVE(GROUP,IF(h.site_source2 = (TYPEOF(h.site_source2))'',0,100));
    maxlength_site_source2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source2)));
    avelength_site_source2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source2)),h.site_source2<>(typeof(h.site_source2))'');
    populated_site_source3_cnt := COUNT(GROUP,h.site_source3 <> (TYPEOF(h.site_source3))'');
    populated_site_source3_pcnt := AVE(GROUP,IF(h.site_source3 = (TYPEOF(h.site_source3))'',0,100));
    maxlength_site_source3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source3)));
    avelength_site_source3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source3)),h.site_source3<>(typeof(h.site_source3))'');
    populated_site_source4_cnt := COUNT(GROUP,h.site_source4 <> (TYPEOF(h.site_source4))'');
    populated_site_source4_pcnt := AVE(GROUP,IF(h.site_source4 = (TYPEOF(h.site_source4))'',0,100));
    maxlength_site_source4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source4)));
    avelength_site_source4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source4)),h.site_source4<>(typeof(h.site_source4))'');
    populated_site_source5_cnt := COUNT(GROUP,h.site_source5 <> (TYPEOF(h.site_source5))'');
    populated_site_source5_pcnt := AVE(GROUP,IF(h.site_source5 = (TYPEOF(h.site_source5))'',0,100));
    maxlength_site_source5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source5)));
    avelength_site_source5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source5)),h.site_source5<>(typeof(h.site_source5))'');
    populated_site_source6_cnt := COUNT(GROUP,h.site_source6 <> (TYPEOF(h.site_source6))'');
    populated_site_source6_pcnt := AVE(GROUP,IF(h.site_source6 = (TYPEOF(h.site_source6))'',0,100));
    maxlength_site_source6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source6)));
    avelength_site_source6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source6)),h.site_source6<>(typeof(h.site_source6))'');
    populated_site_source7_cnt := COUNT(GROUP,h.site_source7 <> (TYPEOF(h.site_source7))'');
    populated_site_source7_pcnt := AVE(GROUP,IF(h.site_source7 = (TYPEOF(h.site_source7))'',0,100));
    maxlength_site_source7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source7)));
    avelength_site_source7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source7)),h.site_source7<>(typeof(h.site_source7))'');
    populated_site_source8_cnt := COUNT(GROUP,h.site_source8 <> (TYPEOF(h.site_source8))'');
    populated_site_source8_pcnt := AVE(GROUP,IF(h.site_source8 = (TYPEOF(h.site_source8))'',0,100));
    maxlength_site_source8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source8)));
    avelength_site_source8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source8)),h.site_source8<>(typeof(h.site_source8))'');
    populated_site_source9_cnt := COUNT(GROUP,h.site_source9 <> (TYPEOF(h.site_source9))'');
    populated_site_source9_pcnt := AVE(GROUP,IF(h.site_source9 = (TYPEOF(h.site_source9))'',0,100));
    maxlength_site_source9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source9)));
    avelength_site_source9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source9)),h.site_source9<>(typeof(h.site_source9))'');
    populated_site_source10_cnt := COUNT(GROUP,h.site_source10 <> (TYPEOF(h.site_source10))'');
    populated_site_source10_pcnt := AVE(GROUP,IF(h.site_source10 = (TYPEOF(h.site_source10))'',0,100));
    maxlength_site_source10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source10)));
    avelength_site_source10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.site_source10)),h.site_source10<>(typeof(h.site_source10))'');
    populated_individual_source1_cnt := COUNT(GROUP,h.individual_source1 <> (TYPEOF(h.individual_source1))'');
    populated_individual_source1_pcnt := AVE(GROUP,IF(h.individual_source1 = (TYPEOF(h.individual_source1))'',0,100));
    maxlength_individual_source1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source1)));
    avelength_individual_source1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source1)),h.individual_source1<>(typeof(h.individual_source1))'');
    populated_individual_source2_cnt := COUNT(GROUP,h.individual_source2 <> (TYPEOF(h.individual_source2))'');
    populated_individual_source2_pcnt := AVE(GROUP,IF(h.individual_source2 = (TYPEOF(h.individual_source2))'',0,100));
    maxlength_individual_source2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source2)));
    avelength_individual_source2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source2)),h.individual_source2<>(typeof(h.individual_source2))'');
    populated_individual_source3_cnt := COUNT(GROUP,h.individual_source3 <> (TYPEOF(h.individual_source3))'');
    populated_individual_source3_pcnt := AVE(GROUP,IF(h.individual_source3 = (TYPEOF(h.individual_source3))'',0,100));
    maxlength_individual_source3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source3)));
    avelength_individual_source3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source3)),h.individual_source3<>(typeof(h.individual_source3))'');
    populated_individual_source4_cnt := COUNT(GROUP,h.individual_source4 <> (TYPEOF(h.individual_source4))'');
    populated_individual_source4_pcnt := AVE(GROUP,IF(h.individual_source4 = (TYPEOF(h.individual_source4))'',0,100));
    maxlength_individual_source4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source4)));
    avelength_individual_source4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source4)),h.individual_source4<>(typeof(h.individual_source4))'');
    populated_individual_source5_cnt := COUNT(GROUP,h.individual_source5 <> (TYPEOF(h.individual_source5))'');
    populated_individual_source5_pcnt := AVE(GROUP,IF(h.individual_source5 = (TYPEOF(h.individual_source5))'',0,100));
    maxlength_individual_source5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source5)));
    avelength_individual_source5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source5)),h.individual_source5<>(typeof(h.individual_source5))'');
    populated_individual_source6_cnt := COUNT(GROUP,h.individual_source6 <> (TYPEOF(h.individual_source6))'');
    populated_individual_source6_pcnt := AVE(GROUP,IF(h.individual_source6 = (TYPEOF(h.individual_source6))'',0,100));
    maxlength_individual_source6 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source6)));
    avelength_individual_source6 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source6)),h.individual_source6<>(typeof(h.individual_source6))'');
    populated_individual_source7_cnt := COUNT(GROUP,h.individual_source7 <> (TYPEOF(h.individual_source7))'');
    populated_individual_source7_pcnt := AVE(GROUP,IF(h.individual_source7 = (TYPEOF(h.individual_source7))'',0,100));
    maxlength_individual_source7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source7)));
    avelength_individual_source7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source7)),h.individual_source7<>(typeof(h.individual_source7))'');
    populated_individual_source8_cnt := COUNT(GROUP,h.individual_source8 <> (TYPEOF(h.individual_source8))'');
    populated_individual_source8_pcnt := AVE(GROUP,IF(h.individual_source8 = (TYPEOF(h.individual_source8))'',0,100));
    maxlength_individual_source8 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source8)));
    avelength_individual_source8 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source8)),h.individual_source8<>(typeof(h.individual_source8))'');
    populated_individual_source9_cnt := COUNT(GROUP,h.individual_source9 <> (TYPEOF(h.individual_source9))'');
    populated_individual_source9_pcnt := AVE(GROUP,IF(h.individual_source9 = (TYPEOF(h.individual_source9))'',0,100));
    maxlength_individual_source9 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source9)));
    avelength_individual_source9 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source9)),h.individual_source9<>(typeof(h.individual_source9))'');
    populated_individual_source10_cnt := COUNT(GROUP,h.individual_source10 <> (TYPEOF(h.individual_source10))'');
    populated_individual_source10_pcnt := AVE(GROUP,IF(h.individual_source10 = (TYPEOF(h.individual_source10))'',0,100));
    maxlength_individual_source10 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source10)));
    avelength_individual_source10 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.individual_source10)),h.individual_source10<>(typeof(h.individual_source10))'');
    populated_email_status_cnt := COUNT(GROUP,h.email_status <> (TYPEOF(h.email_status))'');
    populated_email_status_pcnt := AVE(GROUP,IF(h.email_status = (TYPEOF(h.email_status))'',0,100));
    maxlength_email_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_status)));
    avelength_email_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email_status)),h.email_status<>(typeof(h.email_status))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_clean_company_name_pcnt *   0.00 / 100 + T.Populated_clean_telephone_num_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code5_pcnt *   0.00 / 100 + T.Populated_mail_score_pcnt *   0.00 / 100 + T.Populated_name_gender_pcnt *   0.00 / 100 + T.Populated_web_address_pcnt *   0.00 / 100 + T.Populated_sic8_1_pcnt *   0.00 / 100 + T.Populated_sic8_2_pcnt *   0.00 / 100 + T.Populated_sic8_3_pcnt *   0.00 / 100 + T.Populated_sic8_4_pcnt *   0.00 / 100 + T.Populated_sic6_1_pcnt *   0.00 / 100 + T.Populated_sic6_2_pcnt *   0.00 / 100 + T.Populated_sic6_3_pcnt *   0.00 / 100 + T.Populated_sic6_4_pcnt *   0.00 / 100 + T.Populated_sic6_5_pcnt *   0.00 / 100 + T.Populated_transaction_date_pcnt *   0.00 / 100 + T.Populated_database_site_id_pcnt *   0.00 / 100 + T.Populated_database_individual_id_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_email_present_flag_pcnt *   0.00 / 100 + T.Populated_site_source1_pcnt *   0.00 / 100 + T.Populated_site_source2_pcnt *   0.00 / 100 + T.Populated_site_source3_pcnt *   0.00 / 100 + T.Populated_site_source4_pcnt *   0.00 / 100 + T.Populated_site_source5_pcnt *   0.00 / 100 + T.Populated_site_source6_pcnt *   0.00 / 100 + T.Populated_site_source7_pcnt *   0.00 / 100 + T.Populated_site_source8_pcnt *   0.00 / 100 + T.Populated_site_source9_pcnt *   0.00 / 100 + T.Populated_site_source10_pcnt *   0.00 / 100 + T.Populated_individual_source1_pcnt *   0.00 / 100 + T.Populated_individual_source2_pcnt *   0.00 / 100 + T.Populated_individual_source3_pcnt *   0.00 / 100 + T.Populated_individual_source4_pcnt *   0.00 / 100 + T.Populated_individual_source5_pcnt *   0.00 / 100 + T.Populated_individual_source6_pcnt *   0.00 / 100 + T.Populated_individual_source7_pcnt *   0.00 / 100 + T.Populated_individual_source8_pcnt *   0.00 / 100 + T.Populated_individual_source9_pcnt *   0.00 / 100 + T.Populated_individual_source10_pcnt *   0.00 / 100 + T.Populated_email_status_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_telephone_num','state','zip_code5','mail_score','name_gender','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_clean_company_name_pcnt,le.populated_clean_telephone_num_pcnt,le.populated_state_pcnt,le.populated_zip_code5_pcnt,le.populated_mail_score_pcnt,le.populated_name_gender_pcnt,le.populated_web_address_pcnt,le.populated_sic8_1_pcnt,le.populated_sic8_2_pcnt,le.populated_sic8_3_pcnt,le.populated_sic8_4_pcnt,le.populated_sic6_1_pcnt,le.populated_sic6_2_pcnt,le.populated_sic6_3_pcnt,le.populated_sic6_4_pcnt,le.populated_sic6_5_pcnt,le.populated_transaction_date_pcnt,le.populated_database_site_id_pcnt,le.populated_database_individual_id_pcnt,le.populated_email_pcnt,le.populated_email_present_flag_pcnt,le.populated_site_source1_pcnt,le.populated_site_source2_pcnt,le.populated_site_source3_pcnt,le.populated_site_source4_pcnt,le.populated_site_source5_pcnt,le.populated_site_source6_pcnt,le.populated_site_source7_pcnt,le.populated_site_source8_pcnt,le.populated_site_source9_pcnt,le.populated_site_source10_pcnt,le.populated_individual_source1_pcnt,le.populated_individual_source2_pcnt,le.populated_individual_source3_pcnt,le.populated_individual_source4_pcnt,le.populated_individual_source5_pcnt,le.populated_individual_source6_pcnt,le.populated_individual_source7_pcnt,le.populated_individual_source8_pcnt,le.populated_individual_source9_pcnt,le.populated_individual_source10_pcnt,le.populated_email_status_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_clean_company_name,le.maxlength_clean_telephone_num,le.maxlength_state,le.maxlength_zip_code5,le.maxlength_mail_score,le.maxlength_name_gender,le.maxlength_web_address,le.maxlength_sic8_1,le.maxlength_sic8_2,le.maxlength_sic8_3,le.maxlength_sic8_4,le.maxlength_sic6_1,le.maxlength_sic6_2,le.maxlength_sic6_3,le.maxlength_sic6_4,le.maxlength_sic6_5,le.maxlength_transaction_date,le.maxlength_database_site_id,le.maxlength_database_individual_id,le.maxlength_email,le.maxlength_email_present_flag,le.maxlength_site_source1,le.maxlength_site_source2,le.maxlength_site_source3,le.maxlength_site_source4,le.maxlength_site_source5,le.maxlength_site_source6,le.maxlength_site_source7,le.maxlength_site_source8,le.maxlength_site_source9,le.maxlength_site_source10,le.maxlength_individual_source1,le.maxlength_individual_source2,le.maxlength_individual_source3,le.maxlength_individual_source4,le.maxlength_individual_source5,le.maxlength_individual_source6,le.maxlength_individual_source7,le.maxlength_individual_source8,le.maxlength_individual_source9,le.maxlength_individual_source10,le.maxlength_email_status);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_clean_company_name,le.avelength_clean_telephone_num,le.avelength_state,le.avelength_zip_code5,le.avelength_mail_score,le.avelength_name_gender,le.avelength_web_address,le.avelength_sic8_1,le.avelength_sic8_2,le.avelength_sic8_3,le.avelength_sic8_4,le.avelength_sic6_1,le.avelength_sic6_2,le.avelength_sic6_3,le.avelength_sic6_4,le.avelength_sic6_5,le.avelength_transaction_date,le.avelength_database_site_id,le.avelength_database_individual_id,le.avelength_email,le.avelength_email_present_flag,le.avelength_site_source1,le.avelength_site_source2,le.avelength_site_source3,le.avelength_site_source4,le.avelength_site_source5,le.avelength_site_source6,le.avelength_site_source7,le.avelength_site_source8,le.avelength_site_source9,le.avelength_site_source10,le.avelength_individual_source1,le.avelength_individual_source2,le.avelength_individual_source3,le.avelength_individual_source4,le.avelength_individual_source5,le.avelength_individual_source6,le.avelength_individual_source7,le.avelength_individual_source8,le.avelength_individual_source9,le.avelength_individual_source10,le.avelength_email_status);
END;
EXPORT invSummary := NORMALIZE(summary0, 48, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code5),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,48,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 48);
  SELF.FldNo2 := 1 + (C % 48);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code5),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.clean_company_name),TRIM((SALT311.StrType)le.clean_telephone_num),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip_code5),TRIM((SALT311.StrType)le.mail_score),TRIM((SALT311.StrType)le.name_gender),TRIM((SALT311.StrType)le.web_address),TRIM((SALT311.StrType)le.sic8_1),TRIM((SALT311.StrType)le.sic8_2),TRIM((SALT311.StrType)le.sic8_3),TRIM((SALT311.StrType)le.sic8_4),TRIM((SALT311.StrType)le.sic6_1),TRIM((SALT311.StrType)le.sic6_2),TRIM((SALT311.StrType)le.sic6_3),TRIM((SALT311.StrType)le.sic6_4),TRIM((SALT311.StrType)le.sic6_5),TRIM((SALT311.StrType)le.transaction_date),TRIM((SALT311.StrType)le.database_site_id),TRIM((SALT311.StrType)le.database_individual_id),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.email_present_flag),TRIM((SALT311.StrType)le.site_source1),TRIM((SALT311.StrType)le.site_source2),TRIM((SALT311.StrType)le.site_source3),TRIM((SALT311.StrType)le.site_source4),TRIM((SALT311.StrType)le.site_source5),TRIM((SALT311.StrType)le.site_source6),TRIM((SALT311.StrType)le.site_source7),TRIM((SALT311.StrType)le.site_source8),TRIM((SALT311.StrType)le.site_source9),TRIM((SALT311.StrType)le.site_source10),TRIM((SALT311.StrType)le.individual_source1),TRIM((SALT311.StrType)le.individual_source2),TRIM((SALT311.StrType)le.individual_source3),TRIM((SALT311.StrType)le.individual_source4),TRIM((SALT311.StrType)le.individual_source5),TRIM((SALT311.StrType)le.individual_source6),TRIM((SALT311.StrType)le.individual_source7),TRIM((SALT311.StrType)le.individual_source8),TRIM((SALT311.StrType)le.individual_source9),TRIM((SALT311.StrType)le.individual_source10),TRIM((SALT311.StrType)le.email_status)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),48*48,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'process_date'}
      ,{6,'record_type'}
      ,{7,'clean_company_name'}
      ,{8,'clean_telephone_num'}
      ,{9,'state'}
      ,{10,'zip_code5'}
      ,{11,'mail_score'}
      ,{12,'name_gender'}
      ,{13,'web_address'}
      ,{14,'sic8_1'}
      ,{15,'sic8_2'}
      ,{16,'sic8_3'}
      ,{17,'sic8_4'}
      ,{18,'sic6_1'}
      ,{19,'sic6_2'}
      ,{20,'sic6_3'}
      ,{21,'sic6_4'}
      ,{22,'sic6_5'}
      ,{23,'transaction_date'}
      ,{24,'database_site_id'}
      ,{25,'database_individual_id'}
      ,{26,'email'}
      ,{27,'email_present_flag'}
      ,{28,'site_source1'}
      ,{29,'site_source2'}
      ,{30,'site_source3'}
      ,{31,'site_source4'}
      ,{32,'site_source5'}
      ,{33,'site_source6'}
      ,{34,'site_source7'}
      ,{35,'site_source8'}
      ,{36,'site_source9'}
      ,{37,'site_source10'}
      ,{38,'individual_source1'}
      ,{39,'individual_source2'}
      ,{40,'individual_source3'}
      ,{41,'individual_source4'}
      ,{42,'individual_source5'}
      ,{43,'individual_source6'}
      ,{44,'individual_source7'}
      ,{45,'individual_source8'}
      ,{46,'individual_source9'}
      ,{47,'individual_source10'}
      ,{48,'email_status'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Base_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Base_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_clean_company_name((SALT311.StrType)le.clean_company_name),
    Base_Fields.InValid_clean_telephone_num((SALT311.StrType)le.clean_telephone_num),
    Base_Fields.InValid_state((SALT311.StrType)le.state),
    Base_Fields.InValid_zip_code5((SALT311.StrType)le.zip_code5),
    Base_Fields.InValid_mail_score((SALT311.StrType)le.mail_score),
    Base_Fields.InValid_name_gender((SALT311.StrType)le.name_gender),
    Base_Fields.InValid_web_address((SALT311.StrType)le.web_address),
    Base_Fields.InValid_sic8_1((SALT311.StrType)le.sic8_1),
    Base_Fields.InValid_sic8_2((SALT311.StrType)le.sic8_2),
    Base_Fields.InValid_sic8_3((SALT311.StrType)le.sic8_3),
    Base_Fields.InValid_sic8_4((SALT311.StrType)le.sic8_4),
    Base_Fields.InValid_sic6_1((SALT311.StrType)le.sic6_1),
    Base_Fields.InValid_sic6_2((SALT311.StrType)le.sic6_2),
    Base_Fields.InValid_sic6_3((SALT311.StrType)le.sic6_3),
    Base_Fields.InValid_sic6_4((SALT311.StrType)le.sic6_4),
    Base_Fields.InValid_sic6_5((SALT311.StrType)le.sic6_5),
    Base_Fields.InValid_transaction_date((SALT311.StrType)le.transaction_date),
    Base_Fields.InValid_database_site_id((SALT311.StrType)le.database_site_id),
    Base_Fields.InValid_database_individual_id((SALT311.StrType)le.database_individual_id),
    Base_Fields.InValid_email((SALT311.StrType)le.email),
    Base_Fields.InValid_email_present_flag((SALT311.StrType)le.email_present_flag),
    Base_Fields.InValid_site_source1((SALT311.StrType)le.site_source1),
    Base_Fields.InValid_site_source2((SALT311.StrType)le.site_source2),
    Base_Fields.InValid_site_source3((SALT311.StrType)le.site_source3),
    Base_Fields.InValid_site_source4((SALT311.StrType)le.site_source4),
    Base_Fields.InValid_site_source5((SALT311.StrType)le.site_source5),
    Base_Fields.InValid_site_source6((SALT311.StrType)le.site_source6),
    Base_Fields.InValid_site_source7((SALT311.StrType)le.site_source7),
    Base_Fields.InValid_site_source8((SALT311.StrType)le.site_source8),
    Base_Fields.InValid_site_source9((SALT311.StrType)le.site_source9),
    Base_Fields.InValid_site_source10((SALT311.StrType)le.site_source10),
    Base_Fields.InValid_individual_source1((SALT311.StrType)le.individual_source1),
    Base_Fields.InValid_individual_source2((SALT311.StrType)le.individual_source2),
    Base_Fields.InValid_individual_source3((SALT311.StrType)le.individual_source3),
    Base_Fields.InValid_individual_source4((SALT311.StrType)le.individual_source4),
    Base_Fields.InValid_individual_source5((SALT311.StrType)le.individual_source5),
    Base_Fields.InValid_individual_source6((SALT311.StrType)le.individual_source6),
    Base_Fields.InValid_individual_source7((SALT311.StrType)le.individual_source7),
    Base_Fields.InValid_individual_source8((SALT311.StrType)le.individual_source8),
    Base_Fields.InValid_individual_source9((SALT311.StrType)le.individual_source9),
    Base_Fields.InValid_individual_source10((SALT311.StrType)le.individual_source10),
    Base_Fields.InValid_email_status((SALT311.StrType)le.email_status),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,48,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_generaldate','invalid_record_type','invalid_mandatory','invalid_phone','invalid_st','invalid_zip5','invalid_mail_score','invalid_gender_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_trans_date','invalid_numeric','invalid_numeric','invalid_email','invalid_email_present_flag','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_source_code','invalid_email_status');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Base_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_clean_telephone_num(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip_code5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_mail_score(TotalErrors.ErrorNum),Base_Fields.InValidMessage_name_gender(TotalErrors.ErrorNum),Base_Fields.InValidMessage_web_address(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic8_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_sic6_5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_transaction_date(TotalErrors.ErrorNum),Base_Fields.InValidMessage_database_site_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_database_individual_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_present_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_site_source10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source1(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source2(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source3(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source5(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source6(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source7(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source8(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source9(TotalErrors.ErrorNum),Base_Fields.InValidMessage_individual_source10(TotalErrors.ErrorNum),Base_Fields.InValidMessage_email_status(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DataBridge, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

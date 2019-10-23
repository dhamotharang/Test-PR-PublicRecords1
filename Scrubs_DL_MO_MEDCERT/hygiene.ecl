IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_In_MO_MEDCERT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_unique_key_cnt := COUNT(GROUP,h.unique_key <> (TYPEOF(h.unique_key))'');
    populated_unique_key_pcnt := AVE(GROUP,IF(h.unique_key = (TYPEOF(h.unique_key))'',0,100));
    maxlength_unique_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_key)));
    avelength_unique_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_key)),h.unique_key<>(typeof(h.unique_key))'');
    populated_license_number_cnt := COUNT(GROUP,h.license_number <> (TYPEOF(h.license_number))'');
    populated_license_number_pcnt := AVE(GROUP,IF(h.license_number = (TYPEOF(h.license_number))'',0,100));
    maxlength_license_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_number)));
    avelength_license_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_number)),h.license_number<>(typeof(h.license_number))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_cnt := COUNT(GROUP,h.middle_name <> (TYPEOF(h.middle_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_date_of_birth_cnt := COUNT(GROUP,h.date_of_birth <> (TYPEOF(h.date_of_birth))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_mailing_address1_cnt := COUNT(GROUP,h.mailing_address1 <> (TYPEOF(h.mailing_address1))'');
    populated_mailing_address1_pcnt := AVE(GROUP,IF(h.mailing_address1 = (TYPEOF(h.mailing_address1))'',0,100));
    maxlength_mailing_address1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_address1)));
    avelength_mailing_address1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_address1)),h.mailing_address1<>(typeof(h.mailing_address1))'');
    populated_mailing_address2_cnt := COUNT(GROUP,h.mailing_address2 <> (TYPEOF(h.mailing_address2))'');
    populated_mailing_address2_pcnt := AVE(GROUP,IF(h.mailing_address2 = (TYPEOF(h.mailing_address2))'',0,100));
    maxlength_mailing_address2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_address2)));
    avelength_mailing_address2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_address2)),h.mailing_address2<>(typeof(h.mailing_address2))'');
    populated_mailing_city_cnt := COUNT(GROUP,h.mailing_city <> (TYPEOF(h.mailing_city))'');
    populated_mailing_city_pcnt := AVE(GROUP,IF(h.mailing_city = (TYPEOF(h.mailing_city))'',0,100));
    maxlength_mailing_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_city)));
    avelength_mailing_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_city)),h.mailing_city<>(typeof(h.mailing_city))'');
    populated_mailing_state_cnt := COUNT(GROUP,h.mailing_state <> (TYPEOF(h.mailing_state))'');
    populated_mailing_state_pcnt := AVE(GROUP,IF(h.mailing_state = (TYPEOF(h.mailing_state))'',0,100));
    maxlength_mailing_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_state)));
    avelength_mailing_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_state)),h.mailing_state<>(typeof(h.mailing_state))'');
    populated_mailing_zip_cnt := COUNT(GROUP,h.mailing_zip <> (TYPEOF(h.mailing_zip))'');
    populated_mailing_zip_pcnt := AVE(GROUP,IF(h.mailing_zip = (TYPEOF(h.mailing_zip))'',0,100));
    maxlength_mailing_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_zip)));
    avelength_mailing_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mailing_zip)),h.mailing_zip<>(typeof(h.mailing_zip))'');
    populated_height_cnt := COUNT(GROUP,h.height <> (TYPEOF(h.height))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_eye_color_cnt := COUNT(GROUP,h.eye_color <> (TYPEOF(h.eye_color))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_operator_status_cnt := COUNT(GROUP,h.operator_status <> (TYPEOF(h.operator_status))'');
    populated_operator_status_pcnt := AVE(GROUP,IF(h.operator_status = (TYPEOF(h.operator_status))'',0,100));
    maxlength_operator_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.operator_status)));
    avelength_operator_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.operator_status)),h.operator_status<>(typeof(h.operator_status))'');
    populated_commercial_status_cnt := COUNT(GROUP,h.commercial_status <> (TYPEOF(h.commercial_status))'');
    populated_commercial_status_pcnt := AVE(GROUP,IF(h.commercial_status = (TYPEOF(h.commercial_status))'',0,100));
    maxlength_commercial_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.commercial_status)));
    avelength_commercial_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.commercial_status)),h.commercial_status<>(typeof(h.commercial_status))'');
    populated_sch_bus_status_cnt := COUNT(GROUP,h.sch_bus_status <> (TYPEOF(h.sch_bus_status))'');
    populated_sch_bus_status_pcnt := AVE(GROUP,IF(h.sch_bus_status = (TYPEOF(h.sch_bus_status))'',0,100));
    maxlength_sch_bus_status := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sch_bus_status)));
    avelength_sch_bus_status := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sch_bus_status)),h.sch_bus_status<>(typeof(h.sch_bus_status))'');
    populated_pending_act_code_cnt := COUNT(GROUP,h.pending_act_code <> (TYPEOF(h.pending_act_code))'');
    populated_pending_act_code_pcnt := AVE(GROUP,IF(h.pending_act_code = (TYPEOF(h.pending_act_code))'',0,100));
    maxlength_pending_act_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pending_act_code)));
    avelength_pending_act_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pending_act_code)),h.pending_act_code<>(typeof(h.pending_act_code))'');
    populated_must_test_ind_cnt := COUNT(GROUP,h.must_test_ind <> (TYPEOF(h.must_test_ind))'');
    populated_must_test_ind_pcnt := AVE(GROUP,IF(h.must_test_ind = (TYPEOF(h.must_test_ind))'',0,100));
    maxlength_must_test_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.must_test_ind)));
    avelength_must_test_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.must_test_ind)),h.must_test_ind<>(typeof(h.must_test_ind))'');
    populated_deceased_ind_cnt := COUNT(GROUP,h.deceased_ind <> (TYPEOF(h.deceased_ind))'');
    populated_deceased_ind_pcnt := AVE(GROUP,IF(h.deceased_ind = (TYPEOF(h.deceased_ind))'',0,100));
    maxlength_deceased_ind := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.deceased_ind)));
    avelength_deceased_ind := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.deceased_ind)),h.deceased_ind<>(typeof(h.deceased_ind))'');
    populated_prev_cdl_class_cnt := COUNT(GROUP,h.prev_cdl_class <> (TYPEOF(h.prev_cdl_class))'');
    populated_prev_cdl_class_pcnt := AVE(GROUP,IF(h.prev_cdl_class = (TYPEOF(h.prev_cdl_class))'',0,100));
    maxlength_prev_cdl_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prev_cdl_class)));
    avelength_prev_cdl_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prev_cdl_class)),h.prev_cdl_class<>(typeof(h.prev_cdl_class))'');
    populated_cdl_ptr_cnt := COUNT(GROUP,h.cdl_ptr <> (TYPEOF(h.cdl_ptr))'');
    populated_cdl_ptr_pcnt := AVE(GROUP,IF(h.cdl_ptr = (TYPEOF(h.cdl_ptr))'',0,100));
    maxlength_cdl_ptr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cdl_ptr)));
    avelength_cdl_ptr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cdl_ptr)),h.cdl_ptr<>(typeof(h.cdl_ptr))'');
    populated_pdps_ptr_cnt := COUNT(GROUP,h.pdps_ptr <> (TYPEOF(h.pdps_ptr))'');
    populated_pdps_ptr_pcnt := AVE(GROUP,IF(h.pdps_ptr = (TYPEOF(h.pdps_ptr))'',0,100));
    maxlength_pdps_ptr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.pdps_ptr)));
    avelength_pdps_ptr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.pdps_ptr)),h.pdps_ptr<>(typeof(h.pdps_ptr))'');
    populated_mvr_privacy_code_cnt := COUNT(GROUP,h.mvr_privacy_code <> (TYPEOF(h.mvr_privacy_code))'');
    populated_mvr_privacy_code_pcnt := AVE(GROUP,IF(h.mvr_privacy_code = (TYPEOF(h.mvr_privacy_code))'',0,100));
    maxlength_mvr_privacy_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mvr_privacy_code)));
    avelength_mvr_privacy_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mvr_privacy_code)),h.mvr_privacy_code<>(typeof(h.mvr_privacy_code))'');
    populated_brc_status_code_cnt := COUNT(GROUP,h.brc_status_code <> (TYPEOF(h.brc_status_code))'');
    populated_brc_status_code_pcnt := AVE(GROUP,IF(h.brc_status_code = (TYPEOF(h.brc_status_code))'',0,100));
    maxlength_brc_status_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.brc_status_code)));
    avelength_brc_status_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.brc_status_code)),h.brc_status_code<>(typeof(h.brc_status_code))'');
    populated_brc_status_date_cnt := COUNT(GROUP,h.brc_status_date <> (TYPEOF(h.brc_status_date))'');
    populated_brc_status_date_pcnt := AVE(GROUP,IF(h.brc_status_date = (TYPEOF(h.brc_status_date))'',0,100));
    maxlength_brc_status_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.brc_status_date)));
    avelength_brc_status_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.brc_status_date)),h.brc_status_date<>(typeof(h.brc_status_date))'');
    populated_lic_iss_code_cnt := COUNT(GROUP,h.lic_iss_code <> (TYPEOF(h.lic_iss_code))'');
    populated_lic_iss_code_pcnt := AVE(GROUP,IF(h.lic_iss_code = (TYPEOF(h.lic_iss_code))'',0,100));
    maxlength_lic_iss_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_iss_code)));
    avelength_lic_iss_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_iss_code)),h.lic_iss_code<>(typeof(h.lic_iss_code))'');
    populated_license_class_cnt := COUNT(GROUP,h.license_class <> (TYPEOF(h.license_class))'');
    populated_license_class_pcnt := AVE(GROUP,IF(h.license_class = (TYPEOF(h.license_class))'',0,100));
    maxlength_license_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_class)));
    avelength_license_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_class)),h.license_class<>(typeof(h.license_class))'');
    populated_lic_exp_date_cnt := COUNT(GROUP,h.lic_exp_date <> (TYPEOF(h.lic_exp_date))'');
    populated_lic_exp_date_pcnt := AVE(GROUP,IF(h.lic_exp_date = (TYPEOF(h.lic_exp_date))'',0,100));
    maxlength_lic_exp_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_exp_date)));
    avelength_lic_exp_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_exp_date)),h.lic_exp_date<>(typeof(h.lic_exp_date))'');
    populated_lic_seq_number_cnt := COUNT(GROUP,h.lic_seq_number <> (TYPEOF(h.lic_seq_number))'');
    populated_lic_seq_number_pcnt := AVE(GROUP,IF(h.lic_seq_number = (TYPEOF(h.lic_seq_number))'',0,100));
    maxlength_lic_seq_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_seq_number)));
    avelength_lic_seq_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_seq_number)),h.lic_seq_number<>(typeof(h.lic_seq_number))'');
    populated_lic_surrender_to_cnt := COUNT(GROUP,h.lic_surrender_to <> (TYPEOF(h.lic_surrender_to))'');
    populated_lic_surrender_to_pcnt := AVE(GROUP,IF(h.lic_surrender_to = (TYPEOF(h.lic_surrender_to))'',0,100));
    maxlength_lic_surrender_to := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_surrender_to)));
    avelength_lic_surrender_to := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_surrender_to)),h.lic_surrender_to<>(typeof(h.lic_surrender_to))'');
    populated_new_out_of_st_dl_num_cnt := COUNT(GROUP,h.new_out_of_st_dl_num <> (TYPEOF(h.new_out_of_st_dl_num))'');
    populated_new_out_of_st_dl_num_pcnt := AVE(GROUP,IF(h.new_out_of_st_dl_num = (TYPEOF(h.new_out_of_st_dl_num))'',0,100));
    maxlength_new_out_of_st_dl_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.new_out_of_st_dl_num)));
    avelength_new_out_of_st_dl_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.new_out_of_st_dl_num)),h.new_out_of_st_dl_num<>(typeof(h.new_out_of_st_dl_num))'');
    populated_license_endorsements_cnt := COUNT(GROUP,h.license_endorsements <> (TYPEOF(h.license_endorsements))'');
    populated_license_endorsements_pcnt := AVE(GROUP,IF(h.license_endorsements = (TYPEOF(h.license_endorsements))'',0,100));
    maxlength_license_endorsements := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_endorsements)));
    avelength_license_endorsements := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_endorsements)),h.license_endorsements<>(typeof(h.license_endorsements))'');
    populated_license_restrictions_cnt := COUNT(GROUP,h.license_restrictions <> (TYPEOF(h.license_restrictions))'');
    populated_license_restrictions_pcnt := AVE(GROUP,IF(h.license_restrictions = (TYPEOF(h.license_restrictions))'',0,100));
    maxlength_license_restrictions := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_restrictions)));
    avelength_license_restrictions := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_restrictions)),h.license_restrictions<>(typeof(h.license_restrictions))'');
    populated_license_trans_type_cnt := COUNT(GROUP,h.license_trans_type <> (TYPEOF(h.license_trans_type))'');
    populated_license_trans_type_pcnt := AVE(GROUP,IF(h.license_trans_type = (TYPEOF(h.license_trans_type))'',0,100));
    maxlength_license_trans_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_trans_type)));
    avelength_license_trans_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.license_trans_type)),h.license_trans_type<>(typeof(h.license_trans_type))'');
    populated_lic_print_date_cnt := COUNT(GROUP,h.lic_print_date <> (TYPEOF(h.lic_print_date))'');
    populated_lic_print_date_pcnt := AVE(GROUP,IF(h.lic_print_date = (TYPEOF(h.lic_print_date))'',0,100));
    maxlength_lic_print_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_print_date)));
    avelength_lic_print_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lic_print_date)),h.lic_print_date<>(typeof(h.lic_print_date))'');
    populated_permit_iss_code_cnt := COUNT(GROUP,h.permit_iss_code <> (TYPEOF(h.permit_iss_code))'');
    populated_permit_iss_code_pcnt := AVE(GROUP,IF(h.permit_iss_code = (TYPEOF(h.permit_iss_code))'',0,100));
    maxlength_permit_iss_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_iss_code)));
    avelength_permit_iss_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_iss_code)),h.permit_iss_code<>(typeof(h.permit_iss_code))'');
    populated_permit_class_cnt := COUNT(GROUP,h.permit_class <> (TYPEOF(h.permit_class))'');
    populated_permit_class_pcnt := AVE(GROUP,IF(h.permit_class = (TYPEOF(h.permit_class))'',0,100));
    maxlength_permit_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_class)));
    avelength_permit_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_class)),h.permit_class<>(typeof(h.permit_class))'');
    populated_permit_exp_date_cnt := COUNT(GROUP,h.permit_exp_date <> (TYPEOF(h.permit_exp_date))'');
    populated_permit_exp_date_pcnt := AVE(GROUP,IF(h.permit_exp_date = (TYPEOF(h.permit_exp_date))'',0,100));
    maxlength_permit_exp_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_exp_date)));
    avelength_permit_exp_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_exp_date)),h.permit_exp_date<>(typeof(h.permit_exp_date))'');
    populated_permit_seq_number_cnt := COUNT(GROUP,h.permit_seq_number <> (TYPEOF(h.permit_seq_number))'');
    populated_permit_seq_number_pcnt := AVE(GROUP,IF(h.permit_seq_number = (TYPEOF(h.permit_seq_number))'',0,100));
    maxlength_permit_seq_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_seq_number)));
    avelength_permit_seq_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_seq_number)),h.permit_seq_number<>(typeof(h.permit_seq_number))'');
    populated_permit_endorse_codes_cnt := COUNT(GROUP,h.permit_endorse_codes <> (TYPEOF(h.permit_endorse_codes))'');
    populated_permit_endorse_codes_pcnt := AVE(GROUP,IF(h.permit_endorse_codes = (TYPEOF(h.permit_endorse_codes))'',0,100));
    maxlength_permit_endorse_codes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_endorse_codes)));
    avelength_permit_endorse_codes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_endorse_codes)),h.permit_endorse_codes<>(typeof(h.permit_endorse_codes))'');
    populated_permit_restric_codes_cnt := COUNT(GROUP,h.permit_restric_codes <> (TYPEOF(h.permit_restric_codes))'');
    populated_permit_restric_codes_pcnt := AVE(GROUP,IF(h.permit_restric_codes = (TYPEOF(h.permit_restric_codes))'',0,100));
    maxlength_permit_restric_codes := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_restric_codes)));
    avelength_permit_restric_codes := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_restric_codes)),h.permit_restric_codes<>(typeof(h.permit_restric_codes))'');
    populated_permit_trans_type_cnt := COUNT(GROUP,h.permit_trans_type <> (TYPEOF(h.permit_trans_type))'');
    populated_permit_trans_type_pcnt := AVE(GROUP,IF(h.permit_trans_type = (TYPEOF(h.permit_trans_type))'',0,100));
    maxlength_permit_trans_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_trans_type)));
    avelength_permit_trans_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_trans_type)),h.permit_trans_type<>(typeof(h.permit_trans_type))'');
    populated_permit_print_date_cnt := COUNT(GROUP,h.permit_print_date <> (TYPEOF(h.permit_print_date))'');
    populated_permit_print_date_pcnt := AVE(GROUP,IF(h.permit_print_date = (TYPEOF(h.permit_print_date))'',0,100));
    maxlength_permit_print_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_print_date)));
    avelength_permit_print_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.permit_print_date)),h.permit_print_date<>(typeof(h.permit_print_date))'');
    populated_non_driver_code_cnt := COUNT(GROUP,h.non_driver_code <> (TYPEOF(h.non_driver_code))'');
    populated_non_driver_code_pcnt := AVE(GROUP,IF(h.non_driver_code = (TYPEOF(h.non_driver_code))'',0,100));
    maxlength_non_driver_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_code)));
    avelength_non_driver_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_code)),h.non_driver_code<>(typeof(h.non_driver_code))'');
    populated_non_driver_exp_date_cnt := COUNT(GROUP,h.non_driver_exp_date <> (TYPEOF(h.non_driver_exp_date))'');
    populated_non_driver_exp_date_pcnt := AVE(GROUP,IF(h.non_driver_exp_date = (TYPEOF(h.non_driver_exp_date))'',0,100));
    maxlength_non_driver_exp_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_exp_date)));
    avelength_non_driver_exp_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_exp_date)),h.non_driver_exp_date<>(typeof(h.non_driver_exp_date))'');
    populated_non_driver_seq_num_cnt := COUNT(GROUP,h.non_driver_seq_num <> (TYPEOF(h.non_driver_seq_num))'');
    populated_non_driver_seq_num_pcnt := AVE(GROUP,IF(h.non_driver_seq_num = (TYPEOF(h.non_driver_seq_num))'',0,100));
    maxlength_non_driver_seq_num := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_seq_num)));
    avelength_non_driver_seq_num := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_seq_num)),h.non_driver_seq_num<>(typeof(h.non_driver_seq_num))'');
    populated_non_driver_trans_type_cnt := COUNT(GROUP,h.non_driver_trans_type <> (TYPEOF(h.non_driver_trans_type))'');
    populated_non_driver_trans_type_pcnt := AVE(GROUP,IF(h.non_driver_trans_type = (TYPEOF(h.non_driver_trans_type))'',0,100));
    maxlength_non_driver_trans_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_trans_type)));
    avelength_non_driver_trans_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_trans_type)),h.non_driver_trans_type<>(typeof(h.non_driver_trans_type))'');
    populated_non_driver_print_date_cnt := COUNT(GROUP,h.non_driver_print_date <> (TYPEOF(h.non_driver_print_date))'');
    populated_non_driver_print_date_pcnt := AVE(GROUP,IF(h.non_driver_print_date = (TYPEOF(h.non_driver_print_date))'',0,100));
    maxlength_non_driver_print_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_print_date)));
    avelength_non_driver_print_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.non_driver_print_date)),h.non_driver_print_date<>(typeof(h.non_driver_print_date))'');
    populated_action_surrender_date_cnt := COUNT(GROUP,h.action_surrender_date <> (TYPEOF(h.action_surrender_date))'');
    populated_action_surrender_date_pcnt := AVE(GROUP,IF(h.action_surrender_date = (TYPEOF(h.action_surrender_date))'',0,100));
    maxlength_action_surrender_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_surrender_date)));
    avelength_action_surrender_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_surrender_date)),h.action_surrender_date<>(typeof(h.action_surrender_date))'');
    populated_action_counts_cnt := COUNT(GROUP,h.action_counts <> (TYPEOF(h.action_counts))'');
    populated_action_counts_pcnt := AVE(GROUP,IF(h.action_counts = (TYPEOF(h.action_counts))'',0,100));
    maxlength_action_counts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_counts)));
    avelength_action_counts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.action_counts)),h.action_counts<>(typeof(h.action_counts))'');
    populated_driv_priv_counts_cnt := COUNT(GROUP,h.driv_priv_counts <> (TYPEOF(h.driv_priv_counts))'');
    populated_driv_priv_counts_pcnt := AVE(GROUP,IF(h.driv_priv_counts = (TYPEOF(h.driv_priv_counts))'',0,100));
    maxlength_driv_priv_counts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.driv_priv_counts)));
    avelength_driv_priv_counts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.driv_priv_counts)),h.driv_priv_counts<>(typeof(h.driv_priv_counts))'');
    populated_conv_counts_cnt := COUNT(GROUP,h.conv_counts <> (TYPEOF(h.conv_counts))'');
    populated_conv_counts_pcnt := AVE(GROUP,IF(h.conv_counts = (TYPEOF(h.conv_counts))'',0,100));
    maxlength_conv_counts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.conv_counts)));
    avelength_conv_counts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.conv_counts)),h.conv_counts<>(typeof(h.conv_counts))'');
    populated_accidents_counts_cnt := COUNT(GROUP,h.accidents_counts <> (TYPEOF(h.accidents_counts))'');
    populated_accidents_counts_pcnt := AVE(GROUP,IF(h.accidents_counts = (TYPEOF(h.accidents_counts))'',0,100));
    maxlength_accidents_counts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.accidents_counts)));
    avelength_accidents_counts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.accidents_counts)),h.accidents_counts<>(typeof(h.accidents_counts))'');
    populated_aka_counts_cnt := COUNT(GROUP,h.aka_counts <> (TYPEOF(h.aka_counts))'');
    populated_aka_counts_pcnt := AVE(GROUP,IF(h.aka_counts = (TYPEOF(h.aka_counts))'',0,100));
    maxlength_aka_counts := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.aka_counts)));
    avelength_aka_counts := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.aka_counts)),h.aka_counts<>(typeof(h.aka_counts))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cleaning_score_cnt := COUNT(GROUP,h.cleaning_score <> (TYPEOF(h.cleaning_score))'');
    populated_cleaning_score_pcnt := AVE(GROUP,IF(h.cleaning_score = (TYPEOF(h.cleaning_score))'',0,100));
    maxlength_cleaning_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cleaning_score)));
    avelength_cleaning_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cleaning_score)),h.cleaning_score<>(typeof(h.cleaning_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_cln_zip5_cnt := COUNT(GROUP,h.cln_zip5 <> (TYPEOF(h.cln_zip5))'');
    populated_cln_zip5_pcnt := AVE(GROUP,IF(h.cln_zip5 = (TYPEOF(h.cln_zip5))'',0,100));
    maxlength_cln_zip5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_zip5)));
    avelength_cln_zip5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_zip5)),h.cln_zip5<>(typeof(h.cln_zip5))'');
    populated_cln_zip4_cnt := COUNT(GROUP,h.cln_zip4 <> (TYPEOF(h.cln_zip4))'');
    populated_cln_zip4_pcnt := AVE(GROUP,IF(h.cln_zip4 = (TYPEOF(h.cln_zip4))'',0,100));
    maxlength_cln_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_zip4)));
    avelength_cln_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cln_zip4)),h.cln_zip4<>(typeof(h.cln_zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_previous_dl_number_cnt := COUNT(GROUP,h.previous_dl_number <> (TYPEOF(h.previous_dl_number))'');
    populated_previous_dl_number_pcnt := AVE(GROUP,IF(h.previous_dl_number = (TYPEOF(h.previous_dl_number))'',0,100));
    maxlength_previous_dl_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.previous_dl_number)));
    avelength_previous_dl_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.previous_dl_number)),h.previous_dl_number<>(typeof(h.previous_dl_number))'');
    populated_previous_st_cnt := COUNT(GROUP,h.previous_st <> (TYPEOF(h.previous_st))'');
    populated_previous_st_pcnt := AVE(GROUP,IF(h.previous_st = (TYPEOF(h.previous_st))'',0,100));
    maxlength_previous_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.previous_st)));
    avelength_previous_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.previous_st)),h.previous_st<>(typeof(h.previous_st))'');
    populated_old_dl_number_cnt := COUNT(GROUP,h.old_dl_number <> (TYPEOF(h.old_dl_number))'');
    populated_old_dl_number_pcnt := AVE(GROUP,IF(h.old_dl_number = (TYPEOF(h.old_dl_number))'',0,100));
    maxlength_old_dl_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.old_dl_number)));
    avelength_old_dl_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.old_dl_number)),h.old_dl_number<>(typeof(h.old_dl_number))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_unique_key_pcnt *   0.00 / 100 + T.Populated_license_number_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_mailing_address1_pcnt *   0.00 / 100 + T.Populated_mailing_address2_pcnt *   0.00 / 100 + T.Populated_mailing_city_pcnt *   0.00 / 100 + T.Populated_mailing_state_pcnt *   0.00 / 100 + T.Populated_mailing_zip_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_operator_status_pcnt *   0.00 / 100 + T.Populated_commercial_status_pcnt *   0.00 / 100 + T.Populated_sch_bus_status_pcnt *   0.00 / 100 + T.Populated_pending_act_code_pcnt *   0.00 / 100 + T.Populated_must_test_ind_pcnt *   0.00 / 100 + T.Populated_deceased_ind_pcnt *   0.00 / 100 + T.Populated_prev_cdl_class_pcnt *   0.00 / 100 + T.Populated_cdl_ptr_pcnt *   0.00 / 100 + T.Populated_pdps_ptr_pcnt *   0.00 / 100 + T.Populated_mvr_privacy_code_pcnt *   0.00 / 100 + T.Populated_brc_status_code_pcnt *   0.00 / 100 + T.Populated_brc_status_date_pcnt *   0.00 / 100 + T.Populated_lic_iss_code_pcnt *   0.00 / 100 + T.Populated_license_class_pcnt *   0.00 / 100 + T.Populated_lic_exp_date_pcnt *   0.00 / 100 + T.Populated_lic_seq_number_pcnt *   0.00 / 100 + T.Populated_lic_surrender_to_pcnt *   0.00 / 100 + T.Populated_new_out_of_st_dl_num_pcnt *   0.00 / 100 + T.Populated_license_endorsements_pcnt *   0.00 / 100 + T.Populated_license_restrictions_pcnt *   0.00 / 100 + T.Populated_license_trans_type_pcnt *   0.00 / 100 + T.Populated_lic_print_date_pcnt *   0.00 / 100 + T.Populated_permit_iss_code_pcnt *   0.00 / 100 + T.Populated_permit_class_pcnt *   0.00 / 100 + T.Populated_permit_exp_date_pcnt *   0.00 / 100 + T.Populated_permit_seq_number_pcnt *   0.00 / 100 + T.Populated_permit_endorse_codes_pcnt *   0.00 / 100 + T.Populated_permit_restric_codes_pcnt *   0.00 / 100 + T.Populated_permit_trans_type_pcnt *   0.00 / 100 + T.Populated_permit_print_date_pcnt *   0.00 / 100 + T.Populated_non_driver_code_pcnt *   0.00 / 100 + T.Populated_non_driver_exp_date_pcnt *   0.00 / 100 + T.Populated_non_driver_seq_num_pcnt *   0.00 / 100 + T.Populated_non_driver_trans_type_pcnt *   0.00 / 100 + T.Populated_non_driver_print_date_pcnt *   0.00 / 100 + T.Populated_action_surrender_date_pcnt *   0.00 / 100 + T.Populated_action_counts_pcnt *   0.00 / 100 + T.Populated_driv_priv_counts_pcnt *   0.00 / 100 + T.Populated_conv_counts_pcnt *   0.00 / 100 + T.Populated_accidents_counts_pcnt *   0.00 / 100 + T.Populated_aka_counts_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_cleaning_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_cln_zip5_pcnt *   0.00 / 100 + T.Populated_cln_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_previous_dl_number_pcnt *   0.00 / 100 + T.Populated_previous_st_pcnt *   0.00 / 100 + T.Populated_old_dl_number_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','unique_key','license_number','last_name','first_name','middle_name','suffix','date_of_birth','gender','address','city','state','zip5','zip4','mailing_address1','mailing_address2','mailing_city','mailing_state','mailing_zip','height','eye_color','operator_status','commercial_status','sch_bus_status','pending_act_code','must_test_ind','deceased_ind','prev_cdl_class','cdl_ptr','pdps_ptr','mvr_privacy_code','brc_status_code','brc_status_date','lic_iss_code','license_class','lic_exp_date','lic_seq_number','lic_surrender_to','new_out_of_st_dl_num','license_endorsements','license_restrictions','license_trans_type','lic_print_date','permit_iss_code','permit_class','permit_exp_date','permit_seq_number','permit_endorse_codes','permit_restric_codes','permit_trans_type','permit_print_date','non_driver_code','non_driver_exp_date','non_driver_seq_num','non_driver_trans_type','non_driver_print_date','action_surrender_date','action_counts','driv_priv_counts','conv_counts','accidents_counts','aka_counts','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','previous_dl_number','previous_st','old_dl_number');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_unique_key_pcnt,le.populated_license_number_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_suffix_pcnt,le.populated_date_of_birth_pcnt,le.populated_gender_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_mailing_address1_pcnt,le.populated_mailing_address2_pcnt,le.populated_mailing_city_pcnt,le.populated_mailing_state_pcnt,le.populated_mailing_zip_pcnt,le.populated_height_pcnt,le.populated_eye_color_pcnt,le.populated_operator_status_pcnt,le.populated_commercial_status_pcnt,le.populated_sch_bus_status_pcnt,le.populated_pending_act_code_pcnt,le.populated_must_test_ind_pcnt,le.populated_deceased_ind_pcnt,le.populated_prev_cdl_class_pcnt,le.populated_cdl_ptr_pcnt,le.populated_pdps_ptr_pcnt,le.populated_mvr_privacy_code_pcnt,le.populated_brc_status_code_pcnt,le.populated_brc_status_date_pcnt,le.populated_lic_iss_code_pcnt,le.populated_license_class_pcnt,le.populated_lic_exp_date_pcnt,le.populated_lic_seq_number_pcnt,le.populated_lic_surrender_to_pcnt,le.populated_new_out_of_st_dl_num_pcnt,le.populated_license_endorsements_pcnt,le.populated_license_restrictions_pcnt,le.populated_license_trans_type_pcnt,le.populated_lic_print_date_pcnt,le.populated_permit_iss_code_pcnt,le.populated_permit_class_pcnt,le.populated_permit_exp_date_pcnt,le.populated_permit_seq_number_pcnt,le.populated_permit_endorse_codes_pcnt,le.populated_permit_restric_codes_pcnt,le.populated_permit_trans_type_pcnt,le.populated_permit_print_date_pcnt,le.populated_non_driver_code_pcnt,le.populated_non_driver_exp_date_pcnt,le.populated_non_driver_seq_num_pcnt,le.populated_non_driver_trans_type_pcnt,le.populated_non_driver_print_date_pcnt,le.populated_action_surrender_date_pcnt,le.populated_action_counts_pcnt,le.populated_driv_priv_counts_pcnt,le.populated_conv_counts_pcnt,le.populated_accidents_counts_pcnt,le.populated_aka_counts_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_cleaning_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_cln_zip5_pcnt,le.populated_cln_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_previous_dl_number_pcnt,le.populated_previous_st_pcnt,le.populated_old_dl_number_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_unique_key,le.maxlength_license_number,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_suffix,le.maxlength_date_of_birth,le.maxlength_gender,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_mailing_address1,le.maxlength_mailing_address2,le.maxlength_mailing_city,le.maxlength_mailing_state,le.maxlength_mailing_zip,le.maxlength_height,le.maxlength_eye_color,le.maxlength_operator_status,le.maxlength_commercial_status,le.maxlength_sch_bus_status,le.maxlength_pending_act_code,le.maxlength_must_test_ind,le.maxlength_deceased_ind,le.maxlength_prev_cdl_class,le.maxlength_cdl_ptr,le.maxlength_pdps_ptr,le.maxlength_mvr_privacy_code,le.maxlength_brc_status_code,le.maxlength_brc_status_date,le.maxlength_lic_iss_code,le.maxlength_license_class,le.maxlength_lic_exp_date,le.maxlength_lic_seq_number,le.maxlength_lic_surrender_to,le.maxlength_new_out_of_st_dl_num,le.maxlength_license_endorsements,le.maxlength_license_restrictions,le.maxlength_license_trans_type,le.maxlength_lic_print_date,le.maxlength_permit_iss_code,le.maxlength_permit_class,le.maxlength_permit_exp_date,le.maxlength_permit_seq_number,le.maxlength_permit_endorse_codes,le.maxlength_permit_restric_codes,le.maxlength_permit_trans_type,le.maxlength_permit_print_date,le.maxlength_non_driver_code,le.maxlength_non_driver_exp_date,le.maxlength_non_driver_seq_num,le.maxlength_non_driver_trans_type,le.maxlength_non_driver_print_date,le.maxlength_action_surrender_date,le.maxlength_action_counts,le.maxlength_driv_priv_counts,le.maxlength_conv_counts,le.maxlength_accidents_counts,le.maxlength_aka_counts,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_cleaning_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_cln_zip5,le.maxlength_cln_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_previous_dl_number,le.maxlength_previous_st,le.maxlength_old_dl_number);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_unique_key,le.avelength_license_number,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_name,le.avelength_suffix,le.avelength_date_of_birth,le.avelength_gender,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip5,le.avelength_zip4,le.avelength_mailing_address1,le.avelength_mailing_address2,le.avelength_mailing_city,le.avelength_mailing_state,le.avelength_mailing_zip,le.avelength_height,le.avelength_eye_color,le.avelength_operator_status,le.avelength_commercial_status,le.avelength_sch_bus_status,le.avelength_pending_act_code,le.avelength_must_test_ind,le.avelength_deceased_ind,le.avelength_prev_cdl_class,le.avelength_cdl_ptr,le.avelength_pdps_ptr,le.avelength_mvr_privacy_code,le.avelength_brc_status_code,le.avelength_brc_status_date,le.avelength_lic_iss_code,le.avelength_license_class,le.avelength_lic_exp_date,le.avelength_lic_seq_number,le.avelength_lic_surrender_to,le.avelength_new_out_of_st_dl_num,le.avelength_license_endorsements,le.avelength_license_restrictions,le.avelength_license_trans_type,le.avelength_lic_print_date,le.avelength_permit_iss_code,le.avelength_permit_class,le.avelength_permit_exp_date,le.avelength_permit_seq_number,le.avelength_permit_endorse_codes,le.avelength_permit_restric_codes,le.avelength_permit_trans_type,le.avelength_permit_print_date,le.avelength_non_driver_code,le.avelength_non_driver_exp_date,le.avelength_non_driver_seq_num,le.avelength_non_driver_trans_type,le.avelength_non_driver_print_date,le.avelength_action_surrender_date,le.avelength_action_counts,le.avelength_driv_priv_counts,le.avelength_conv_counts,le.avelength_accidents_counts,le.avelength_aka_counts,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_cleaning_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_cln_zip5,le.avelength_cln_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_previous_dl_number,le.avelength_previous_st,le.avelength_old_dl_number);
END;
EXPORT invSummary := NORMALIZE(summary0, 98, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.unique_key),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.middle_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.date_of_birth),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.mailing_address1),TRIM((SALT38.StrType)le.mailing_address2),TRIM((SALT38.StrType)le.mailing_city),TRIM((SALT38.StrType)le.mailing_state),TRIM((SALT38.StrType)le.mailing_zip),TRIM((SALT38.StrType)le.height),TRIM((SALT38.StrType)le.eye_color),TRIM((SALT38.StrType)le.operator_status),TRIM((SALT38.StrType)le.commercial_status),TRIM((SALT38.StrType)le.sch_bus_status),TRIM((SALT38.StrType)le.pending_act_code),TRIM((SALT38.StrType)le.must_test_ind),TRIM((SALT38.StrType)le.deceased_ind),TRIM((SALT38.StrType)le.prev_cdl_class),TRIM((SALT38.StrType)le.cdl_ptr),TRIM((SALT38.StrType)le.pdps_ptr),TRIM((SALT38.StrType)le.mvr_privacy_code),TRIM((SALT38.StrType)le.brc_status_code),TRIM((SALT38.StrType)le.brc_status_date),TRIM((SALT38.StrType)le.lic_iss_code),TRIM((SALT38.StrType)le.license_class),TRIM((SALT38.StrType)le.lic_exp_date),TRIM((SALT38.StrType)le.lic_seq_number),TRIM((SALT38.StrType)le.lic_surrender_to),TRIM((SALT38.StrType)le.new_out_of_st_dl_num),TRIM((SALT38.StrType)le.license_endorsements),TRIM((SALT38.StrType)le.license_restrictions),TRIM((SALT38.StrType)le.license_trans_type),TRIM((SALT38.StrType)le.lic_print_date),TRIM((SALT38.StrType)le.permit_iss_code),TRIM((SALT38.StrType)le.permit_class),TRIM((SALT38.StrType)le.permit_exp_date),TRIM((SALT38.StrType)le.permit_seq_number),TRIM((SALT38.StrType)le.permit_endorse_codes),TRIM((SALT38.StrType)le.permit_restric_codes),TRIM((SALT38.StrType)le.permit_trans_type),TRIM((SALT38.StrType)le.permit_print_date),TRIM((SALT38.StrType)le.non_driver_code),TRIM((SALT38.StrType)le.non_driver_exp_date),TRIM((SALT38.StrType)le.non_driver_seq_num),TRIM((SALT38.StrType)le.non_driver_trans_type),TRIM((SALT38.StrType)le.non_driver_print_date),TRIM((SALT38.StrType)le.action_surrender_date),IF (le.action_counts <> 0,TRIM((SALT38.StrType)le.action_counts), ''),IF (le.driv_priv_counts <> 0,TRIM((SALT38.StrType)le.driv_priv_counts), ''),IF (le.conv_counts <> 0,TRIM((SALT38.StrType)le.conv_counts), ''),IF (le.accidents_counts <> 0,TRIM((SALT38.StrType)le.accidents_counts), ''),IF (le.aka_counts <> 0,TRIM((SALT38.StrType)le.aka_counts), ''),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.cleaning_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.cln_zip5),TRIM((SALT38.StrType)le.cln_zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.previous_dl_number),TRIM((SALT38.StrType)le.previous_st),TRIM((SALT38.StrType)le.old_dl_number)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,98,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 98);
  SELF.FldNo2 := 1 + (C % 98);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.unique_key),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.middle_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.date_of_birth),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.mailing_address1),TRIM((SALT38.StrType)le.mailing_address2),TRIM((SALT38.StrType)le.mailing_city),TRIM((SALT38.StrType)le.mailing_state),TRIM((SALT38.StrType)le.mailing_zip),TRIM((SALT38.StrType)le.height),TRIM((SALT38.StrType)le.eye_color),TRIM((SALT38.StrType)le.operator_status),TRIM((SALT38.StrType)le.commercial_status),TRIM((SALT38.StrType)le.sch_bus_status),TRIM((SALT38.StrType)le.pending_act_code),TRIM((SALT38.StrType)le.must_test_ind),TRIM((SALT38.StrType)le.deceased_ind),TRIM((SALT38.StrType)le.prev_cdl_class),TRIM((SALT38.StrType)le.cdl_ptr),TRIM((SALT38.StrType)le.pdps_ptr),TRIM((SALT38.StrType)le.mvr_privacy_code),TRIM((SALT38.StrType)le.brc_status_code),TRIM((SALT38.StrType)le.brc_status_date),TRIM((SALT38.StrType)le.lic_iss_code),TRIM((SALT38.StrType)le.license_class),TRIM((SALT38.StrType)le.lic_exp_date),TRIM((SALT38.StrType)le.lic_seq_number),TRIM((SALT38.StrType)le.lic_surrender_to),TRIM((SALT38.StrType)le.new_out_of_st_dl_num),TRIM((SALT38.StrType)le.license_endorsements),TRIM((SALT38.StrType)le.license_restrictions),TRIM((SALT38.StrType)le.license_trans_type),TRIM((SALT38.StrType)le.lic_print_date),TRIM((SALT38.StrType)le.permit_iss_code),TRIM((SALT38.StrType)le.permit_class),TRIM((SALT38.StrType)le.permit_exp_date),TRIM((SALT38.StrType)le.permit_seq_number),TRIM((SALT38.StrType)le.permit_endorse_codes),TRIM((SALT38.StrType)le.permit_restric_codes),TRIM((SALT38.StrType)le.permit_trans_type),TRIM((SALT38.StrType)le.permit_print_date),TRIM((SALT38.StrType)le.non_driver_code),TRIM((SALT38.StrType)le.non_driver_exp_date),TRIM((SALT38.StrType)le.non_driver_seq_num),TRIM((SALT38.StrType)le.non_driver_trans_type),TRIM((SALT38.StrType)le.non_driver_print_date),TRIM((SALT38.StrType)le.action_surrender_date),IF (le.action_counts <> 0,TRIM((SALT38.StrType)le.action_counts), ''),IF (le.driv_priv_counts <> 0,TRIM((SALT38.StrType)le.driv_priv_counts), ''),IF (le.conv_counts <> 0,TRIM((SALT38.StrType)le.conv_counts), ''),IF (le.accidents_counts <> 0,TRIM((SALT38.StrType)le.accidents_counts), ''),IF (le.aka_counts <> 0,TRIM((SALT38.StrType)le.aka_counts), ''),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.cleaning_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.cln_zip5),TRIM((SALT38.StrType)le.cln_zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.previous_dl_number),TRIM((SALT38.StrType)le.previous_st),TRIM((SALT38.StrType)le.old_dl_number)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.process_date),TRIM((SALT38.StrType)le.unique_key),TRIM((SALT38.StrType)le.license_number),TRIM((SALT38.StrType)le.last_name),TRIM((SALT38.StrType)le.first_name),TRIM((SALT38.StrType)le.middle_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.date_of_birth),TRIM((SALT38.StrType)le.gender),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.mailing_address1),TRIM((SALT38.StrType)le.mailing_address2),TRIM((SALT38.StrType)le.mailing_city),TRIM((SALT38.StrType)le.mailing_state),TRIM((SALT38.StrType)le.mailing_zip),TRIM((SALT38.StrType)le.height),TRIM((SALT38.StrType)le.eye_color),TRIM((SALT38.StrType)le.operator_status),TRIM((SALT38.StrType)le.commercial_status),TRIM((SALT38.StrType)le.sch_bus_status),TRIM((SALT38.StrType)le.pending_act_code),TRIM((SALT38.StrType)le.must_test_ind),TRIM((SALT38.StrType)le.deceased_ind),TRIM((SALT38.StrType)le.prev_cdl_class),TRIM((SALT38.StrType)le.cdl_ptr),TRIM((SALT38.StrType)le.pdps_ptr),TRIM((SALT38.StrType)le.mvr_privacy_code),TRIM((SALT38.StrType)le.brc_status_code),TRIM((SALT38.StrType)le.brc_status_date),TRIM((SALT38.StrType)le.lic_iss_code),TRIM((SALT38.StrType)le.license_class),TRIM((SALT38.StrType)le.lic_exp_date),TRIM((SALT38.StrType)le.lic_seq_number),TRIM((SALT38.StrType)le.lic_surrender_to),TRIM((SALT38.StrType)le.new_out_of_st_dl_num),TRIM((SALT38.StrType)le.license_endorsements),TRIM((SALT38.StrType)le.license_restrictions),TRIM((SALT38.StrType)le.license_trans_type),TRIM((SALT38.StrType)le.lic_print_date),TRIM((SALT38.StrType)le.permit_iss_code),TRIM((SALT38.StrType)le.permit_class),TRIM((SALT38.StrType)le.permit_exp_date),TRIM((SALT38.StrType)le.permit_seq_number),TRIM((SALT38.StrType)le.permit_endorse_codes),TRIM((SALT38.StrType)le.permit_restric_codes),TRIM((SALT38.StrType)le.permit_trans_type),TRIM((SALT38.StrType)le.permit_print_date),TRIM((SALT38.StrType)le.non_driver_code),TRIM((SALT38.StrType)le.non_driver_exp_date),TRIM((SALT38.StrType)le.non_driver_seq_num),TRIM((SALT38.StrType)le.non_driver_trans_type),TRIM((SALT38.StrType)le.non_driver_print_date),TRIM((SALT38.StrType)le.action_surrender_date),IF (le.action_counts <> 0,TRIM((SALT38.StrType)le.action_counts), ''),IF (le.driv_priv_counts <> 0,TRIM((SALT38.StrType)le.driv_priv_counts), ''),IF (le.conv_counts <> 0,TRIM((SALT38.StrType)le.conv_counts), ''),IF (le.accidents_counts <> 0,TRIM((SALT38.StrType)le.accidents_counts), ''),IF (le.aka_counts <> 0,TRIM((SALT38.StrType)le.aka_counts), ''),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.cleaning_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.cln_zip5),TRIM((SALT38.StrType)le.cln_zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.previous_dl_number),TRIM((SALT38.StrType)le.previous_st),TRIM((SALT38.StrType)le.old_dl_number)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),98*98,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'unique_key'}
      ,{3,'license_number'}
      ,{4,'last_name'}
      ,{5,'first_name'}
      ,{6,'middle_name'}
      ,{7,'suffix'}
      ,{8,'date_of_birth'}
      ,{9,'gender'}
      ,{10,'address'}
      ,{11,'city'}
      ,{12,'state'}
      ,{13,'zip5'}
      ,{14,'zip4'}
      ,{15,'mailing_address1'}
      ,{16,'mailing_address2'}
      ,{17,'mailing_city'}
      ,{18,'mailing_state'}
      ,{19,'mailing_zip'}
      ,{20,'height'}
      ,{21,'eye_color'}
      ,{22,'operator_status'}
      ,{23,'commercial_status'}
      ,{24,'sch_bus_status'}
      ,{25,'pending_act_code'}
      ,{26,'must_test_ind'}
      ,{27,'deceased_ind'}
      ,{28,'prev_cdl_class'}
      ,{29,'cdl_ptr'}
      ,{30,'pdps_ptr'}
      ,{31,'mvr_privacy_code'}
      ,{32,'brc_status_code'}
      ,{33,'brc_status_date'}
      ,{34,'lic_iss_code'}
      ,{35,'license_class'}
      ,{36,'lic_exp_date'}
      ,{37,'lic_seq_number'}
      ,{38,'lic_surrender_to'}
      ,{39,'new_out_of_st_dl_num'}
      ,{40,'license_endorsements'}
      ,{41,'license_restrictions'}
      ,{42,'license_trans_type'}
      ,{43,'lic_print_date'}
      ,{44,'permit_iss_code'}
      ,{45,'permit_class'}
      ,{46,'permit_exp_date'}
      ,{47,'permit_seq_number'}
      ,{48,'permit_endorse_codes'}
      ,{49,'permit_restric_codes'}
      ,{50,'permit_trans_type'}
      ,{51,'permit_print_date'}
      ,{52,'non_driver_code'}
      ,{53,'non_driver_exp_date'}
      ,{54,'non_driver_seq_num'}
      ,{55,'non_driver_trans_type'}
      ,{56,'non_driver_print_date'}
      ,{57,'action_surrender_date'}
      ,{58,'action_counts'}
      ,{59,'driv_priv_counts'}
      ,{60,'conv_counts'}
      ,{61,'accidents_counts'}
      ,{62,'aka_counts'}
      ,{63,'title'}
      ,{64,'fname'}
      ,{65,'mname'}
      ,{66,'lname'}
      ,{67,'name_suffix'}
      ,{68,'cleaning_score'}
      ,{69,'prim_range'}
      ,{70,'predir'}
      ,{71,'prim_name'}
      ,{72,'addr_suffix'}
      ,{73,'postdir'}
      ,{74,'unit_desig'}
      ,{75,'sec_range'}
      ,{76,'p_city_name'}
      ,{77,'v_city_name'}
      ,{78,'st'}
      ,{79,'cln_zip5'}
      ,{80,'cln_zip4'}
      ,{81,'cart'}
      ,{82,'cr_sort_sz'}
      ,{83,'lot'}
      ,{84,'lot_order'}
      ,{85,'dpbc'}
      ,{86,'chk_digit'}
      ,{87,'rec_type'}
      ,{88,'ace_fips_st'}
      ,{89,'county'}
      ,{90,'geo_lat'}
      ,{91,'geo_long'}
      ,{92,'msa'}
      ,{93,'geo_blk'}
      ,{94,'geo_match'}
      ,{95,'err_stat'}
      ,{96,'previous_dl_number'}
      ,{97,'previous_st'}
      ,{98,'old_dl_number'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT38.StrType)le.process_date),
    Fields.InValid_unique_key((SALT38.StrType)le.unique_key),
    Fields.InValid_license_number((SALT38.StrType)le.license_number),
    Fields.InValid_last_name((SALT38.StrType)le.last_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.middle_name),
    Fields.InValid_first_name((SALT38.StrType)le.first_name,(SALT38.StrType)le.middle_name,(SALT38.StrType)le.last_name),
    Fields.InValid_middle_name((SALT38.StrType)le.middle_name,(SALT38.StrType)le.first_name,(SALT38.StrType)le.last_name),
    Fields.InValid_suffix((SALT38.StrType)le.suffix),
    Fields.InValid_date_of_birth((SALT38.StrType)le.date_of_birth),
    Fields.InValid_gender((SALT38.StrType)le.gender),
    Fields.InValid_address((SALT38.StrType)le.address),
    Fields.InValid_city((SALT38.StrType)le.city),
    Fields.InValid_state((SALT38.StrType)le.state),
    Fields.InValid_zip5((SALT38.StrType)le.zip5),
    Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Fields.InValid_mailing_address1((SALT38.StrType)le.mailing_address1),
    Fields.InValid_mailing_address2((SALT38.StrType)le.mailing_address2),
    Fields.InValid_mailing_city((SALT38.StrType)le.mailing_city),
    Fields.InValid_mailing_state((SALT38.StrType)le.mailing_state),
    Fields.InValid_mailing_zip((SALT38.StrType)le.mailing_zip),
    Fields.InValid_height((SALT38.StrType)le.height),
    Fields.InValid_eye_color((SALT38.StrType)le.eye_color),
    Fields.InValid_operator_status((SALT38.StrType)le.operator_status),
    Fields.InValid_commercial_status((SALT38.StrType)le.commercial_status),
    Fields.InValid_sch_bus_status((SALT38.StrType)le.sch_bus_status),
    Fields.InValid_pending_act_code((SALT38.StrType)le.pending_act_code),
    Fields.InValid_must_test_ind((SALT38.StrType)le.must_test_ind),
    Fields.InValid_deceased_ind((SALT38.StrType)le.deceased_ind),
    Fields.InValid_prev_cdl_class((SALT38.StrType)le.prev_cdl_class),
    Fields.InValid_cdl_ptr((SALT38.StrType)le.cdl_ptr),
    Fields.InValid_pdps_ptr((SALT38.StrType)le.pdps_ptr),
    Fields.InValid_mvr_privacy_code((SALT38.StrType)le.mvr_privacy_code),
    Fields.InValid_brc_status_code((SALT38.StrType)le.brc_status_code),
    Fields.InValid_brc_status_date((SALT38.StrType)le.brc_status_date),
    Fields.InValid_lic_iss_code((SALT38.StrType)le.lic_iss_code),
    Fields.InValid_license_class((SALT38.StrType)le.license_class),
    Fields.InValid_lic_exp_date((SALT38.StrType)le.lic_exp_date),
    Fields.InValid_lic_seq_number((SALT38.StrType)le.lic_seq_number),
    Fields.InValid_lic_surrender_to((SALT38.StrType)le.lic_surrender_to),
    Fields.InValid_new_out_of_st_dl_num((SALT38.StrType)le.new_out_of_st_dl_num),
    Fields.InValid_license_endorsements((SALT38.StrType)le.license_endorsements),
    Fields.InValid_license_restrictions((SALT38.StrType)le.license_restrictions),
    Fields.InValid_license_trans_type((SALT38.StrType)le.license_trans_type),
    Fields.InValid_lic_print_date((SALT38.StrType)le.lic_print_date),
    Fields.InValid_permit_iss_code((SALT38.StrType)le.permit_iss_code),
    Fields.InValid_permit_class((SALT38.StrType)le.permit_class),
    Fields.InValid_permit_exp_date((SALT38.StrType)le.permit_exp_date),
    Fields.InValid_permit_seq_number((SALT38.StrType)le.permit_seq_number),
    Fields.InValid_permit_endorse_codes((SALT38.StrType)le.permit_endorse_codes),
    Fields.InValid_permit_restric_codes((SALT38.StrType)le.permit_restric_codes),
    Fields.InValid_permit_trans_type((SALT38.StrType)le.permit_trans_type),
    Fields.InValid_permit_print_date((SALT38.StrType)le.permit_print_date),
    Fields.InValid_non_driver_code((SALT38.StrType)le.non_driver_code),
    Fields.InValid_non_driver_exp_date((SALT38.StrType)le.non_driver_exp_date),
    Fields.InValid_non_driver_seq_num((SALT38.StrType)le.non_driver_seq_num),
    Fields.InValid_non_driver_trans_type((SALT38.StrType)le.non_driver_trans_type),
    Fields.InValid_non_driver_print_date((SALT38.StrType)le.non_driver_print_date),
    Fields.InValid_action_surrender_date((SALT38.StrType)le.action_surrender_date),
    Fields.InValid_action_counts((SALT38.StrType)le.action_counts),
    Fields.InValid_driv_priv_counts((SALT38.StrType)le.driv_priv_counts),
    Fields.InValid_conv_counts((SALT38.StrType)le.conv_counts),
    Fields.InValid_accidents_counts((SALT38.StrType)le.accidents_counts),
    Fields.InValid_aka_counts((SALT38.StrType)le.aka_counts),
    Fields.InValid_title((SALT38.StrType)le.title),
    Fields.InValid_fname((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname),
    Fields.InValid_mname((SALT38.StrType)le.mname,(SALT38.StrType)le.fname,(SALT38.StrType)le.lname),
    Fields.InValid_lname((SALT38.StrType)le.lname,(SALT38.StrType)le.fname,(SALT38.StrType)le.mname),
    Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Fields.InValid_cleaning_score((SALT38.StrType)le.cleaning_score),
    Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Fields.InValid_predir((SALT38.StrType)le.predir),
    Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Fields.InValid_st((SALT38.StrType)le.st),
    Fields.InValid_cln_zip5((SALT38.StrType)le.cln_zip5),
    Fields.InValid_cln_zip4((SALT38.StrType)le.cln_zip4),
    Fields.InValid_cart((SALT38.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT38.StrType)le.lot),
    Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT38.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT38.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT38.StrType)le.county),
    Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Fields.InValid_msa((SALT38.StrType)le.msa),
    Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Fields.InValid_previous_dl_number((SALT38.StrType)le.previous_dl_number),
    Fields.InValid_previous_st((SALT38.StrType)le.previous_st),
    Fields.InValid_old_dl_number((SALT38.StrType)le.old_dl_number),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,98,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_Past_Date','invalid_Alpha_Numeric','invalid_Alpha_Numeric','invalid_last_name','invalid_first_name','invalid_mid_name','Unknown','invalid_Past_Date','invalid_gender','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_mandatory','Unknown','invalid_mandatory','invalid_state','invalid_mailing_zip','invalid_Num','invalid_eye_color','invalid_operator_status','invalid_commercial_status','invalid_sch_bus_status','invalid_pending_act_code','invalid_must_test_ind','invalid_deceased_ind','invalid_prev_cdl_class','invalid_cdl_ptr','invalid_pdps_ptr','invalid_mvr_privacy_code','Unknown','invalid_Past_Date','invalid_lic_iss_code','invalid_license_class','invalid_general_Date','invalid_Num','invalid_state','Unknown','invalid_license_endorsements','invalid_license_restrictions','invalid_license_trans_type','invalid_general_Date','invalid_permit_iss_code','invalid_permit_class','invalid_general_Date','invalid_Num','invalid_permit_endorse_codes','invalid_permit_restric_codes','invalid_permit_trans_type','invalid_Past_Date','invalid_non_driver_code','invalid_general_Date','invalid_Num','invalid_non_driver_trans_type','invalid_general_Date','invalid_Past_Date','invalid_action_counts','invalid_driv_priv_counts','invalid_conv_counts','invalid_accidents_counts','invalid_aka_counts','invalid_title','invalid_fname','invalid_mname','invalid_lname','Unknown','Unknown','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','Unknown','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','Unknown','invalid_geo_match','invalid_err_stat','invalid_Hyphen_Alpha_Numeric','invalid_state','invalid_Alpha_Numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_unique_key(TotalErrors.ErrorNum),Fields.InValidMessage_license_number(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_address1(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_address2(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_city(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_state(TotalErrors.ErrorNum),Fields.InValidMessage_mailing_zip(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_operator_status(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_status(TotalErrors.ErrorNum),Fields.InValidMessage_sch_bus_status(TotalErrors.ErrorNum),Fields.InValidMessage_pending_act_code(TotalErrors.ErrorNum),Fields.InValidMessage_must_test_ind(TotalErrors.ErrorNum),Fields.InValidMessage_deceased_ind(TotalErrors.ErrorNum),Fields.InValidMessage_prev_cdl_class(TotalErrors.ErrorNum),Fields.InValidMessage_cdl_ptr(TotalErrors.ErrorNum),Fields.InValidMessage_pdps_ptr(TotalErrors.ErrorNum),Fields.InValidMessage_mvr_privacy_code(TotalErrors.ErrorNum),Fields.InValidMessage_brc_status_code(TotalErrors.ErrorNum),Fields.InValidMessage_brc_status_date(TotalErrors.ErrorNum),Fields.InValidMessage_lic_iss_code(TotalErrors.ErrorNum),Fields.InValidMessage_license_class(TotalErrors.ErrorNum),Fields.InValidMessage_lic_exp_date(TotalErrors.ErrorNum),Fields.InValidMessage_lic_seq_number(TotalErrors.ErrorNum),Fields.InValidMessage_lic_surrender_to(TotalErrors.ErrorNum),Fields.InValidMessage_new_out_of_st_dl_num(TotalErrors.ErrorNum),Fields.InValidMessage_license_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_license_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_license_trans_type(TotalErrors.ErrorNum),Fields.InValidMessage_lic_print_date(TotalErrors.ErrorNum),Fields.InValidMessage_permit_iss_code(TotalErrors.ErrorNum),Fields.InValidMessage_permit_class(TotalErrors.ErrorNum),Fields.InValidMessage_permit_exp_date(TotalErrors.ErrorNum),Fields.InValidMessage_permit_seq_number(TotalErrors.ErrorNum),Fields.InValidMessage_permit_endorse_codes(TotalErrors.ErrorNum),Fields.InValidMessage_permit_restric_codes(TotalErrors.ErrorNum),Fields.InValidMessage_permit_trans_type(TotalErrors.ErrorNum),Fields.InValidMessage_permit_print_date(TotalErrors.ErrorNum),Fields.InValidMessage_non_driver_code(TotalErrors.ErrorNum),Fields.InValidMessage_non_driver_exp_date(TotalErrors.ErrorNum),Fields.InValidMessage_non_driver_seq_num(TotalErrors.ErrorNum),Fields.InValidMessage_non_driver_trans_type(TotalErrors.ErrorNum),Fields.InValidMessage_non_driver_print_date(TotalErrors.ErrorNum),Fields.InValidMessage_action_surrender_date(TotalErrors.ErrorNum),Fields.InValidMessage_action_counts(TotalErrors.ErrorNum),Fields.InValidMessage_driv_priv_counts(TotalErrors.ErrorNum),Fields.InValidMessage_conv_counts(TotalErrors.ErrorNum),Fields.InValidMessage_accidents_counts(TotalErrors.ErrorNum),Fields.InValidMessage_aka_counts(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cleaning_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_cln_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_cln_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_previous_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_previous_st(TotalErrors.ErrorNum),Fields.InValidMessage_old_dl_number(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DL_MO_MEDCERT, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

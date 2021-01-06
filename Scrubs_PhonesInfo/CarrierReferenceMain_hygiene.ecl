IMPORT SALT311,STD;
EXPORT CarrierReferenceMain_hygiene(dataset(CarrierReferenceMain_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_reported_cnt := COUNT(GROUP,h.dt_first_reported <> (TYPEOF(h.dt_first_reported))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_cnt := COUNT(GROUP,h.dt_last_reported <> (TYPEOF(h.dt_last_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_dt_start_cnt := COUNT(GROUP,h.dt_start <> (TYPEOF(h.dt_start))'');
    populated_dt_start_pcnt := AVE(GROUP,IF(h.dt_start = (TYPEOF(h.dt_start))'',0,100));
    maxlength_dt_start := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_start)));
    avelength_dt_start := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_start)),h.dt_start<>(typeof(h.dt_start))'');
    populated_dt_end_cnt := COUNT(GROUP,h.dt_end <> (TYPEOF(h.dt_end))'');
    populated_dt_end_pcnt := AVE(GROUP,IF(h.dt_end = (TYPEOF(h.dt_end))'',0,100));
    maxlength_dt_end := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_end)));
    avelength_dt_end := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_end)),h.dt_end<>(typeof(h.dt_end))'');
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
    populated_carrier_name_cnt := COUNT(GROUP,h.carrier_name <> (TYPEOF(h.carrier_name))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_serv_cnt := COUNT(GROUP,h.serv <> (TYPEOF(h.serv))'');
    populated_serv_pcnt := AVE(GROUP,IF(h.serv = (TYPEOF(h.serv))'',0,100));
    maxlength_serv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.serv)));
    avelength_serv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.serv)),h.serv<>(typeof(h.serv))'');
    populated_line_cnt := COUNT(GROUP,h.line <> (TYPEOF(h.line))'');
    populated_line_pcnt := AVE(GROUP,IF(h.line = (TYPEOF(h.line))'',0,100));
    maxlength_line := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line)));
    avelength_line := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line)),h.line<>(typeof(h.line))'');
    populated_prepaid_cnt := COUNT(GROUP,h.prepaid <> (TYPEOF(h.prepaid))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
    populated_high_risk_indicator_cnt := COUNT(GROUP,h.high_risk_indicator <> (TYPEOF(h.high_risk_indicator))'');
    populated_high_risk_indicator_pcnt := AVE(GROUP,IF(h.high_risk_indicator = (TYPEOF(h.high_risk_indicator))'',0,100));
    maxlength_high_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_risk_indicator)));
    avelength_high_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.high_risk_indicator)),h.high_risk_indicator<>(typeof(h.high_risk_indicator))'');
    populated_activation_dt_cnt := COUNT(GROUP,h.activation_dt <> (TYPEOF(h.activation_dt))'');
    populated_activation_dt_pcnt := AVE(GROUP,IF(h.activation_dt = (TYPEOF(h.activation_dt))'',0,100));
    maxlength_activation_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activation_dt)));
    avelength_activation_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activation_dt)),h.activation_dt<>(typeof(h.activation_dt))'');
    populated_number_in_service_cnt := COUNT(GROUP,h.number_in_service <> (TYPEOF(h.number_in_service))'');
    populated_number_in_service_pcnt := AVE(GROUP,IF(h.number_in_service = (TYPEOF(h.number_in_service))'',0,100));
    maxlength_number_in_service := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_in_service)));
    avelength_number_in_service := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.number_in_service)),h.number_in_service<>(typeof(h.number_in_service))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_operator_full_name_cnt := COUNT(GROUP,h.operator_full_name <> (TYPEOF(h.operator_full_name))'');
    populated_operator_full_name_pcnt := AVE(GROUP,IF(h.operator_full_name = (TYPEOF(h.operator_full_name))'',0,100));
    maxlength_operator_full_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.operator_full_name)));
    avelength_operator_full_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.operator_full_name)),h.operator_full_name<>(typeof(h.operator_full_name))'');
    populated_is_current_cnt := COUNT(GROUP,h.is_current <> (TYPEOF(h.is_current))'');
    populated_is_current_pcnt := AVE(GROUP,IF(h.is_current = (TYPEOF(h.is_current))'',0,100));
    maxlength_is_current := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)));
    avelength_is_current := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_current)),h.is_current<>(typeof(h.is_current))'');
    populated_override_file_cnt := COUNT(GROUP,h.override_file <> (TYPEOF(h.override_file))'');
    populated_override_file_pcnt := AVE(GROUP,IF(h.override_file = (TYPEOF(h.override_file))'',0,100));
    maxlength_override_file := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.override_file)));
    avelength_override_file := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.override_file)),h.override_file<>(typeof(h.override_file))'');
    populated_data_type_cnt := COUNT(GROUP,h.data_type <> (TYPEOF(h.data_type))'');
    populated_data_type_pcnt := AVE(GROUP,IF(h.data_type = (TYPEOF(h.data_type))'',0,100));
    maxlength_data_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)));
    avelength_data_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_type)),h.data_type<>(typeof(h.data_type))'');
    populated_ocn_state_cnt := COUNT(GROUP,h.ocn_state <> (TYPEOF(h.ocn_state))'');
    populated_ocn_state_pcnt := AVE(GROUP,IF(h.ocn_state = (TYPEOF(h.ocn_state))'',0,100));
    maxlength_ocn_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)));
    avelength_ocn_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)),h.ocn_state<>(typeof(h.ocn_state))'');
    populated_overall_ocn_cnt := COUNT(GROUP,h.overall_ocn <> (TYPEOF(h.overall_ocn))'');
    populated_overall_ocn_pcnt := AVE(GROUP,IF(h.overall_ocn = (TYPEOF(h.overall_ocn))'',0,100));
    maxlength_overall_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_ocn)));
    avelength_overall_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_ocn)),h.overall_ocn<>(typeof(h.overall_ocn))'');
    populated_target_ocn_cnt := COUNT(GROUP,h.target_ocn <> (TYPEOF(h.target_ocn))'');
    populated_target_ocn_pcnt := AVE(GROUP,IF(h.target_ocn = (TYPEOF(h.target_ocn))'',0,100));
    maxlength_target_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.target_ocn)));
    avelength_target_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.target_ocn)),h.target_ocn<>(typeof(h.target_ocn))'');
    populated_overall_target_ocn_cnt := COUNT(GROUP,h.overall_target_ocn <> (TYPEOF(h.overall_target_ocn))'');
    populated_overall_target_ocn_pcnt := AVE(GROUP,IF(h.overall_target_ocn = (TYPEOF(h.overall_target_ocn))'',0,100));
    maxlength_overall_target_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_target_ocn)));
    avelength_overall_target_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_target_ocn)),h.overall_target_ocn<>(typeof(h.overall_target_ocn))'');
    populated_ocn_abbr_name_cnt := COUNT(GROUP,h.ocn_abbr_name <> (TYPEOF(h.ocn_abbr_name))'');
    populated_ocn_abbr_name_pcnt := AVE(GROUP,IF(h.ocn_abbr_name = (TYPEOF(h.ocn_abbr_name))'',0,100));
    maxlength_ocn_abbr_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_abbr_name)));
    avelength_ocn_abbr_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_abbr_name)),h.ocn_abbr_name<>(typeof(h.ocn_abbr_name))'');
    populated_rural_lec_indicator_cnt := COUNT(GROUP,h.rural_lec_indicator <> (TYPEOF(h.rural_lec_indicator))'');
    populated_rural_lec_indicator_pcnt := AVE(GROUP,IF(h.rural_lec_indicator = (TYPEOF(h.rural_lec_indicator))'',0,100));
    maxlength_rural_lec_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rural_lec_indicator)));
    avelength_rural_lec_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rural_lec_indicator)),h.rural_lec_indicator<>(typeof(h.rural_lec_indicator))'');
    populated_small_ilec_indicator_cnt := COUNT(GROUP,h.small_ilec_indicator <> (TYPEOF(h.small_ilec_indicator))'');
    populated_small_ilec_indicator_pcnt := AVE(GROUP,IF(h.small_ilec_indicator = (TYPEOF(h.small_ilec_indicator))'',0,100));
    maxlength_small_ilec_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_ilec_indicator)));
    avelength_small_ilec_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.small_ilec_indicator)),h.small_ilec_indicator<>(typeof(h.small_ilec_indicator))'');
    populated_category_cnt := COUNT(GROUP,h.category <> (TYPEOF(h.category))'');
    populated_category_pcnt := AVE(GROUP,IF(h.category = (TYPEOF(h.category))'',0,100));
    maxlength_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)));
    avelength_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.category)),h.category<>(typeof(h.category))'');
    populated_carrier_address1_cnt := COUNT(GROUP,h.carrier_address1 <> (TYPEOF(h.carrier_address1))'');
    populated_carrier_address1_pcnt := AVE(GROUP,IF(h.carrier_address1 = (TYPEOF(h.carrier_address1))'',0,100));
    maxlength_carrier_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_address1)));
    avelength_carrier_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_address1)),h.carrier_address1<>(typeof(h.carrier_address1))'');
    populated_carrier_address2_cnt := COUNT(GROUP,h.carrier_address2 <> (TYPEOF(h.carrier_address2))'');
    populated_carrier_address2_pcnt := AVE(GROUP,IF(h.carrier_address2 = (TYPEOF(h.carrier_address2))'',0,100));
    maxlength_carrier_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_address2)));
    avelength_carrier_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_address2)),h.carrier_address2<>(typeof(h.carrier_address2))'');
    populated_carrier_floor_cnt := COUNT(GROUP,h.carrier_floor <> (TYPEOF(h.carrier_floor))'');
    populated_carrier_floor_pcnt := AVE(GROUP,IF(h.carrier_floor = (TYPEOF(h.carrier_floor))'',0,100));
    maxlength_carrier_floor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_floor)));
    avelength_carrier_floor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_floor)),h.carrier_floor<>(typeof(h.carrier_floor))'');
    populated_carrier_room_cnt := COUNT(GROUP,h.carrier_room <> (TYPEOF(h.carrier_room))'');
    populated_carrier_room_pcnt := AVE(GROUP,IF(h.carrier_room = (TYPEOF(h.carrier_room))'',0,100));
    maxlength_carrier_room := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_room)));
    avelength_carrier_room := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_room)),h.carrier_room<>(typeof(h.carrier_room))'');
    populated_carrier_city_cnt := COUNT(GROUP,h.carrier_city <> (TYPEOF(h.carrier_city))'');
    populated_carrier_city_pcnt := AVE(GROUP,IF(h.carrier_city = (TYPEOF(h.carrier_city))'',0,100));
    maxlength_carrier_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city)));
    avelength_carrier_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_city)),h.carrier_city<>(typeof(h.carrier_city))'');
    populated_carrier_state_cnt := COUNT(GROUP,h.carrier_state <> (TYPEOF(h.carrier_state))'');
    populated_carrier_state_pcnt := AVE(GROUP,IF(h.carrier_state = (TYPEOF(h.carrier_state))'',0,100));
    maxlength_carrier_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_state)));
    avelength_carrier_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_state)),h.carrier_state<>(typeof(h.carrier_state))'');
    populated_carrier_zip_cnt := COUNT(GROUP,h.carrier_zip <> (TYPEOF(h.carrier_zip))'');
    populated_carrier_zip_pcnt := AVE(GROUP,IF(h.carrier_zip = (TYPEOF(h.carrier_zip))'',0,100));
    maxlength_carrier_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_zip)));
    avelength_carrier_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_zip)),h.carrier_zip<>(typeof(h.carrier_zip))'');
    populated_carrier_phone_cnt := COUNT(GROUP,h.carrier_phone <> (TYPEOF(h.carrier_phone))'');
    populated_carrier_phone_pcnt := AVE(GROUP,IF(h.carrier_phone = (TYPEOF(h.carrier_phone))'',0,100));
    maxlength_carrier_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_phone)));
    avelength_carrier_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.carrier_phone)),h.carrier_phone<>(typeof(h.carrier_phone))'');
    populated_affiliated_to_cnt := COUNT(GROUP,h.affiliated_to <> (TYPEOF(h.affiliated_to))'');
    populated_affiliated_to_pcnt := AVE(GROUP,IF(h.affiliated_to = (TYPEOF(h.affiliated_to))'',0,100));
    maxlength_affiliated_to := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.affiliated_to)));
    avelength_affiliated_to := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.affiliated_to)),h.affiliated_to<>(typeof(h.affiliated_to))'');
    populated_overall_company_cnt := COUNT(GROUP,h.overall_company <> (TYPEOF(h.overall_company))'');
    populated_overall_company_pcnt := AVE(GROUP,IF(h.overall_company = (TYPEOF(h.overall_company))'',0,100));
    maxlength_overall_company := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_company)));
    avelength_overall_company := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.overall_company)),h.overall_company<>(typeof(h.overall_company))'');
    populated_contact_function_cnt := COUNT(GROUP,h.contact_function <> (TYPEOF(h.contact_function))'');
    populated_contact_function_pcnt := AVE(GROUP,IF(h.contact_function = (TYPEOF(h.contact_function))'',0,100));
    maxlength_contact_function := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_function)));
    avelength_contact_function := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_function)),h.contact_function<>(typeof(h.contact_function))'');
    populated_contact_name_cnt := COUNT(GROUP,h.contact_name <> (TYPEOF(h.contact_name))'');
    populated_contact_name_pcnt := AVE(GROUP,IF(h.contact_name = (TYPEOF(h.contact_name))'',0,100));
    maxlength_contact_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name)));
    avelength_contact_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name)),h.contact_name<>(typeof(h.contact_name))'');
    populated_contact_title_cnt := COUNT(GROUP,h.contact_title <> (TYPEOF(h.contact_title))'');
    populated_contact_title_pcnt := AVE(GROUP,IF(h.contact_title = (TYPEOF(h.contact_title))'',0,100));
    maxlength_contact_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_title)));
    avelength_contact_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_title)),h.contact_title<>(typeof(h.contact_title))'');
    populated_contact_address1_cnt := COUNT(GROUP,h.contact_address1 <> (TYPEOF(h.contact_address1))'');
    populated_contact_address1_pcnt := AVE(GROUP,IF(h.contact_address1 = (TYPEOF(h.contact_address1))'',0,100));
    maxlength_contact_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_address1)));
    avelength_contact_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_address1)),h.contact_address1<>(typeof(h.contact_address1))'');
    populated_contact_address2_cnt := COUNT(GROUP,h.contact_address2 <> (TYPEOF(h.contact_address2))'');
    populated_contact_address2_pcnt := AVE(GROUP,IF(h.contact_address2 = (TYPEOF(h.contact_address2))'',0,100));
    maxlength_contact_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_address2)));
    avelength_contact_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_address2)),h.contact_address2<>(typeof(h.contact_address2))'');
    populated_contact_city_cnt := COUNT(GROUP,h.contact_city <> (TYPEOF(h.contact_city))'');
    populated_contact_city_pcnt := AVE(GROUP,IF(h.contact_city = (TYPEOF(h.contact_city))'',0,100));
    maxlength_contact_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_city)));
    avelength_contact_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_city)),h.contact_city<>(typeof(h.contact_city))'');
    populated_contact_state_cnt := COUNT(GROUP,h.contact_state <> (TYPEOF(h.contact_state))'');
    populated_contact_state_pcnt := AVE(GROUP,IF(h.contact_state = (TYPEOF(h.contact_state))'',0,100));
    maxlength_contact_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_state)));
    avelength_contact_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_state)),h.contact_state<>(typeof(h.contact_state))'');
    populated_contact_zip_cnt := COUNT(GROUP,h.contact_zip <> (TYPEOF(h.contact_zip))'');
    populated_contact_zip_pcnt := AVE(GROUP,IF(h.contact_zip = (TYPEOF(h.contact_zip))'',0,100));
    maxlength_contact_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_zip)));
    avelength_contact_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_zip)),h.contact_zip<>(typeof(h.contact_zip))'');
    populated_contact_phone_cnt := COUNT(GROUP,h.contact_phone <> (TYPEOF(h.contact_phone))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_fax_cnt := COUNT(GROUP,h.contact_fax <> (TYPEOF(h.contact_fax))'');
    populated_contact_fax_pcnt := AVE(GROUP,IF(h.contact_fax = (TYPEOF(h.contact_fax))'',0,100));
    maxlength_contact_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_fax)));
    avelength_contact_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_fax)),h.contact_fax<>(typeof(h.contact_fax))'');
    populated_contact_email_cnt := COUNT(GROUP,h.contact_email <> (TYPEOF(h.contact_email))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_contact_information_cnt := COUNT(GROUP,h.contact_information <> (TYPEOF(h.contact_information))'');
    populated_contact_information_pcnt := AVE(GROUP,IF(h.contact_information = (TYPEOF(h.contact_information))'',0,100));
    maxlength_contact_information := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_information)));
    avelength_contact_information := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_information)),h.contact_information<>(typeof(h.contact_information))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_z5_cnt := COUNT(GROUP,h.z5 <> (TYPEOF(h.z5))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_append_rawaid_cnt := COUNT(GROUP,h.append_rawaid <> (TYPEOF(h.append_rawaid))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
    populated_address_type_cnt := COUNT(GROUP,h.address_type <> (TYPEOF(h.address_type))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_privacy_indicator_cnt := COUNT(GROUP,h.privacy_indicator <> (TYPEOF(h.privacy_indicator))'');
    populated_privacy_indicator_pcnt := AVE(GROUP,IF(h.privacy_indicator = (TYPEOF(h.privacy_indicator))'',0,100));
    maxlength_privacy_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.privacy_indicator)));
    avelength_privacy_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.privacy_indicator)),h.privacy_indicator<>(typeof(h.privacy_indicator))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_start_pcnt *   0.00 / 100 + T.Populated_dt_end_pcnt *   0.00 / 100 + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_serv_pcnt *   0.00 / 100 + T.Populated_line_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_high_risk_indicator_pcnt *   0.00 / 100 + T.Populated_activation_dt_pcnt *   0.00 / 100 + T.Populated_number_in_service_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_operator_full_name_pcnt *   0.00 / 100 + T.Populated_is_current_pcnt *   0.00 / 100 + T.Populated_override_file_pcnt *   0.00 / 100 + T.Populated_data_type_pcnt *   0.00 / 100 + T.Populated_ocn_state_pcnt *   0.00 / 100 + T.Populated_overall_ocn_pcnt *   0.00 / 100 + T.Populated_target_ocn_pcnt *   0.00 / 100 + T.Populated_overall_target_ocn_pcnt *   0.00 / 100 + T.Populated_ocn_abbr_name_pcnt *   0.00 / 100 + T.Populated_rural_lec_indicator_pcnt *   0.00 / 100 + T.Populated_small_ilec_indicator_pcnt *   0.00 / 100 + T.Populated_category_pcnt *   0.00 / 100 + T.Populated_carrier_address1_pcnt *   0.00 / 100 + T.Populated_carrier_address2_pcnt *   0.00 / 100 + T.Populated_carrier_floor_pcnt *   0.00 / 100 + T.Populated_carrier_room_pcnt *   0.00 / 100 + T.Populated_carrier_city_pcnt *   0.00 / 100 + T.Populated_carrier_state_pcnt *   0.00 / 100 + T.Populated_carrier_zip_pcnt *   0.00 / 100 + T.Populated_carrier_phone_pcnt *   0.00 / 100 + T.Populated_affiliated_to_pcnt *   0.00 / 100 + T.Populated_overall_company_pcnt *   0.00 / 100 + T.Populated_contact_function_pcnt *   0.00 / 100 + T.Populated_contact_name_pcnt *   0.00 / 100 + T.Populated_contact_title_pcnt *   0.00 / 100 + T.Populated_contact_address1_pcnt *   0.00 / 100 + T.Populated_contact_address2_pcnt *   0.00 / 100 + T.Populated_contact_city_pcnt *   0.00 / 100 + T.Populated_contact_state_pcnt *   0.00 / 100 + T.Populated_contact_zip_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_contact_fax_pcnt *   0.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100 + T.Populated_contact_information_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_append_rawaid_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_privacy_indicator_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_reported','dt_last_reported','dt_start','dt_end','ocn','carrier_name','serv','line','prepaid','high_risk_indicator','activation_dt','number_in_service','spid','operator_full_name','is_current','override_file','data_type','ocn_state','overall_ocn','target_ocn','overall_target_ocn','ocn_abbr_name','rural_lec_indicator','small_ilec_indicator','category','carrier_address1','carrier_address2','carrier_floor','carrier_room','carrier_city','carrier_state','carrier_zip','carrier_phone','affiliated_to','overall_company','contact_function','contact_name','contact_title','contact_address1','contact_address2','contact_city','contact_state','contact_zip','contact_phone','contact_fax','contact_email','contact_information','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','append_rawaid','address_type','privacy_indicator');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_dt_start_pcnt,le.populated_dt_end_pcnt,le.populated_ocn_pcnt,le.populated_carrier_name_pcnt,le.populated_serv_pcnt,le.populated_line_pcnt,le.populated_prepaid_pcnt,le.populated_high_risk_indicator_pcnt,le.populated_activation_dt_pcnt,le.populated_number_in_service_pcnt,le.populated_spid_pcnt,le.populated_operator_full_name_pcnt,le.populated_is_current_pcnt,le.populated_override_file_pcnt,le.populated_data_type_pcnt,le.populated_ocn_state_pcnt,le.populated_overall_ocn_pcnt,le.populated_target_ocn_pcnt,le.populated_overall_target_ocn_pcnt,le.populated_ocn_abbr_name_pcnt,le.populated_rural_lec_indicator_pcnt,le.populated_small_ilec_indicator_pcnt,le.populated_category_pcnt,le.populated_carrier_address1_pcnt,le.populated_carrier_address2_pcnt,le.populated_carrier_floor_pcnt,le.populated_carrier_room_pcnt,le.populated_carrier_city_pcnt,le.populated_carrier_state_pcnt,le.populated_carrier_zip_pcnt,le.populated_carrier_phone_pcnt,le.populated_affiliated_to_pcnt,le.populated_overall_company_pcnt,le.populated_contact_function_pcnt,le.populated_contact_name_pcnt,le.populated_contact_title_pcnt,le.populated_contact_address1_pcnt,le.populated_contact_address2_pcnt,le.populated_contact_city_pcnt,le.populated_contact_state_pcnt,le.populated_contact_zip_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_fax_pcnt,le.populated_contact_email_pcnt,le.populated_contact_information_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_z5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_append_rawaid_pcnt,le.populated_address_type_pcnt,le.populated_privacy_indicator_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_dt_start,le.maxlength_dt_end,le.maxlength_ocn,le.maxlength_carrier_name,le.maxlength_serv,le.maxlength_line,le.maxlength_prepaid,le.maxlength_high_risk_indicator,le.maxlength_activation_dt,le.maxlength_number_in_service,le.maxlength_spid,le.maxlength_operator_full_name,le.maxlength_is_current,le.maxlength_override_file,le.maxlength_data_type,le.maxlength_ocn_state,le.maxlength_overall_ocn,le.maxlength_target_ocn,le.maxlength_overall_target_ocn,le.maxlength_ocn_abbr_name,le.maxlength_rural_lec_indicator,le.maxlength_small_ilec_indicator,le.maxlength_category,le.maxlength_carrier_address1,le.maxlength_carrier_address2,le.maxlength_carrier_floor,le.maxlength_carrier_room,le.maxlength_carrier_city,le.maxlength_carrier_state,le.maxlength_carrier_zip,le.maxlength_carrier_phone,le.maxlength_affiliated_to,le.maxlength_overall_company,le.maxlength_contact_function,le.maxlength_contact_name,le.maxlength_contact_title,le.maxlength_contact_address1,le.maxlength_contact_address2,le.maxlength_contact_city,le.maxlength_contact_state,le.maxlength_contact_zip,le.maxlength_contact_phone,le.maxlength_contact_fax,le.maxlength_contact_email,le.maxlength_contact_information,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_z5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_append_rawaid,le.maxlength_address_type,le.maxlength_privacy_indicator);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_dt_start,le.avelength_dt_end,le.avelength_ocn,le.avelength_carrier_name,le.avelength_serv,le.avelength_line,le.avelength_prepaid,le.avelength_high_risk_indicator,le.avelength_activation_dt,le.avelength_number_in_service,le.avelength_spid,le.avelength_operator_full_name,le.avelength_is_current,le.avelength_override_file,le.avelength_data_type,le.avelength_ocn_state,le.avelength_overall_ocn,le.avelength_target_ocn,le.avelength_overall_target_ocn,le.avelength_ocn_abbr_name,le.avelength_rural_lec_indicator,le.avelength_small_ilec_indicator,le.avelength_category,le.avelength_carrier_address1,le.avelength_carrier_address2,le.avelength_carrier_floor,le.avelength_carrier_room,le.avelength_carrier_city,le.avelength_carrier_state,le.avelength_carrier_zip,le.avelength_carrier_phone,le.avelength_affiliated_to,le.avelength_overall_company,le.avelength_contact_function,le.avelength_contact_name,le.avelength_contact_title,le.avelength_contact_address1,le.avelength_contact_address2,le.avelength_contact_city,le.avelength_contact_state,le.avelength_contact_zip,le.avelength_contact_phone,le.avelength_contact_fax,le.avelength_contact_email,le.avelength_contact_information,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_z5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_append_rawaid,le.avelength_address_type,le.avelength_privacy_indicator);
END;
EXPORT invSummary := NORMALIZE(summary0, 77, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.high_risk_indicator),IF (le.activation_dt <> 0,TRIM((SALT311.StrType)le.activation_dt), ''),TRIM((SALT311.StrType)le.number_in_service),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_full_name),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.override_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.carrier_address1),TRIM((SALT311.StrType)le.carrier_address2),TRIM((SALT311.StrType)le.carrier_floor),TRIM((SALT311.StrType)le.carrier_room),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip),TRIM((SALT311.StrType)le.carrier_phone),TRIM((SALT311.StrType)le.affiliated_to),TRIM((SALT311.StrType)le.overall_company),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_name),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.contact_address1),TRIM((SALT311.StrType)le.contact_address2),TRIM((SALT311.StrType)le.contact_city),TRIM((SALT311.StrType)le.contact_state),TRIM((SALT311.StrType)le.contact_zip),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_fax),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.privacy_indicator)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,77,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 77);
  SELF.FldNo2 := 1 + (C % 77);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.high_risk_indicator),IF (le.activation_dt <> 0,TRIM((SALT311.StrType)le.activation_dt), ''),TRIM((SALT311.StrType)le.number_in_service),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_full_name),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.override_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.carrier_address1),TRIM((SALT311.StrType)le.carrier_address2),TRIM((SALT311.StrType)le.carrier_floor),TRIM((SALT311.StrType)le.carrier_room),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip),TRIM((SALT311.StrType)le.carrier_phone),TRIM((SALT311.StrType)le.affiliated_to),TRIM((SALT311.StrType)le.overall_company),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_name),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.contact_address1),TRIM((SALT311.StrType)le.contact_address2),TRIM((SALT311.StrType)le.contact_city),TRIM((SALT311.StrType)le.contact_state),TRIM((SALT311.StrType)le.contact_zip),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_fax),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.privacy_indicator)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dt_first_reported),TRIM((SALT311.StrType)le.dt_last_reported),TRIM((SALT311.StrType)le.dt_start),TRIM((SALT311.StrType)le.dt_end),TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.carrier_name),TRIM((SALT311.StrType)le.serv),TRIM((SALT311.StrType)le.line),TRIM((SALT311.StrType)le.prepaid),TRIM((SALT311.StrType)le.high_risk_indicator),IF (le.activation_dt <> 0,TRIM((SALT311.StrType)le.activation_dt), ''),TRIM((SALT311.StrType)le.number_in_service),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.operator_full_name),TRIM((SALT311.StrType)le.is_current),TRIM((SALT311.StrType)le.override_file),TRIM((SALT311.StrType)le.data_type),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.overall_ocn),TRIM((SALT311.StrType)le.target_ocn),TRIM((SALT311.StrType)le.overall_target_ocn),TRIM((SALT311.StrType)le.ocn_abbr_name),TRIM((SALT311.StrType)le.rural_lec_indicator),TRIM((SALT311.StrType)le.small_ilec_indicator),TRIM((SALT311.StrType)le.category),TRIM((SALT311.StrType)le.carrier_address1),TRIM((SALT311.StrType)le.carrier_address2),TRIM((SALT311.StrType)le.carrier_floor),TRIM((SALT311.StrType)le.carrier_room),TRIM((SALT311.StrType)le.carrier_city),TRIM((SALT311.StrType)le.carrier_state),TRIM((SALT311.StrType)le.carrier_zip),TRIM((SALT311.StrType)le.carrier_phone),TRIM((SALT311.StrType)le.affiliated_to),TRIM((SALT311.StrType)le.overall_company),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_name),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.contact_address1),TRIM((SALT311.StrType)le.contact_address2),TRIM((SALT311.StrType)le.contact_city),TRIM((SALT311.StrType)le.contact_state),TRIM((SALT311.StrType)le.contact_zip),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_fax),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.z5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.privacy_indicator)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),77*77,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_reported'}
      ,{2,'dt_last_reported'}
      ,{3,'dt_start'}
      ,{4,'dt_end'}
      ,{5,'ocn'}
      ,{6,'carrier_name'}
      ,{7,'serv'}
      ,{8,'line'}
      ,{9,'prepaid'}
      ,{10,'high_risk_indicator'}
      ,{11,'activation_dt'}
      ,{12,'number_in_service'}
      ,{13,'spid'}
      ,{14,'operator_full_name'}
      ,{15,'is_current'}
      ,{16,'override_file'}
      ,{17,'data_type'}
      ,{18,'ocn_state'}
      ,{19,'overall_ocn'}
      ,{20,'target_ocn'}
      ,{21,'overall_target_ocn'}
      ,{22,'ocn_abbr_name'}
      ,{23,'rural_lec_indicator'}
      ,{24,'small_ilec_indicator'}
      ,{25,'category'}
      ,{26,'carrier_address1'}
      ,{27,'carrier_address2'}
      ,{28,'carrier_floor'}
      ,{29,'carrier_room'}
      ,{30,'carrier_city'}
      ,{31,'carrier_state'}
      ,{32,'carrier_zip'}
      ,{33,'carrier_phone'}
      ,{34,'affiliated_to'}
      ,{35,'overall_company'}
      ,{36,'contact_function'}
      ,{37,'contact_name'}
      ,{38,'contact_title'}
      ,{39,'contact_address1'}
      ,{40,'contact_address2'}
      ,{41,'contact_city'}
      ,{42,'contact_state'}
      ,{43,'contact_zip'}
      ,{44,'contact_phone'}
      ,{45,'contact_fax'}
      ,{46,'contact_email'}
      ,{47,'contact_information'}
      ,{48,'prim_range'}
      ,{49,'predir'}
      ,{50,'prim_name'}
      ,{51,'addr_suffix'}
      ,{52,'postdir'}
      ,{53,'unit_desig'}
      ,{54,'sec_range'}
      ,{55,'p_city_name'}
      ,{56,'v_city_name'}
      ,{57,'st'}
      ,{58,'z5'}
      ,{59,'zip4'}
      ,{60,'cart'}
      ,{61,'cr_sort_sz'}
      ,{62,'lot'}
      ,{63,'lot_order'}
      ,{64,'dpbc'}
      ,{65,'chk_digit'}
      ,{66,'rec_type'}
      ,{67,'ace_fips_st'}
      ,{68,'fips_county'}
      ,{69,'geo_lat'}
      ,{70,'geo_long'}
      ,{71,'msa'}
      ,{72,'geo_blk'}
      ,{73,'geo_match'}
      ,{74,'err_stat'}
      ,{75,'append_rawaid'}
      ,{76,'address_type'}
      ,{77,'privacy_indicator'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    CarrierReferenceMain_Fields.InValid_dt_first_reported((SALT311.StrType)le.dt_first_reported),
    CarrierReferenceMain_Fields.InValid_dt_last_reported((SALT311.StrType)le.dt_last_reported),
    CarrierReferenceMain_Fields.InValid_dt_start((SALT311.StrType)le.dt_start),
    CarrierReferenceMain_Fields.InValid_dt_end((SALT311.StrType)le.dt_end),
    CarrierReferenceMain_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    CarrierReferenceMain_Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name),
    CarrierReferenceMain_Fields.InValid_serv((SALT311.StrType)le.serv),
    CarrierReferenceMain_Fields.InValid_line((SALT311.StrType)le.line),
    CarrierReferenceMain_Fields.InValid_prepaid((SALT311.StrType)le.prepaid),
    CarrierReferenceMain_Fields.InValid_high_risk_indicator((SALT311.StrType)le.high_risk_indicator),
    CarrierReferenceMain_Fields.InValid_activation_dt((SALT311.StrType)le.activation_dt),
    CarrierReferenceMain_Fields.InValid_number_in_service((SALT311.StrType)le.number_in_service),
    CarrierReferenceMain_Fields.InValid_spid((SALT311.StrType)le.spid),
    CarrierReferenceMain_Fields.InValid_operator_full_name((SALT311.StrType)le.operator_full_name),
    CarrierReferenceMain_Fields.InValid_is_current((SALT311.StrType)le.is_current),
    CarrierReferenceMain_Fields.InValid_override_file((SALT311.StrType)le.override_file),
    CarrierReferenceMain_Fields.InValid_data_type((SALT311.StrType)le.data_type),
    CarrierReferenceMain_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state),
    CarrierReferenceMain_Fields.InValid_overall_ocn((SALT311.StrType)le.overall_ocn),
    CarrierReferenceMain_Fields.InValid_target_ocn((SALT311.StrType)le.target_ocn),
    CarrierReferenceMain_Fields.InValid_overall_target_ocn((SALT311.StrType)le.overall_target_ocn),
    CarrierReferenceMain_Fields.InValid_ocn_abbr_name((SALT311.StrType)le.ocn_abbr_name),
    CarrierReferenceMain_Fields.InValid_rural_lec_indicator((SALT311.StrType)le.rural_lec_indicator),
    CarrierReferenceMain_Fields.InValid_small_ilec_indicator((SALT311.StrType)le.small_ilec_indicator),
    CarrierReferenceMain_Fields.InValid_category((SALT311.StrType)le.category),
    CarrierReferenceMain_Fields.InValid_carrier_address1((SALT311.StrType)le.carrier_address1),
    CarrierReferenceMain_Fields.InValid_carrier_address2((SALT311.StrType)le.carrier_address2),
    CarrierReferenceMain_Fields.InValid_carrier_floor((SALT311.StrType)le.carrier_floor),
    CarrierReferenceMain_Fields.InValid_carrier_room((SALT311.StrType)le.carrier_room),
    CarrierReferenceMain_Fields.InValid_carrier_city((SALT311.StrType)le.carrier_city),
    CarrierReferenceMain_Fields.InValid_carrier_state((SALT311.StrType)le.carrier_state),
    CarrierReferenceMain_Fields.InValid_carrier_zip((SALT311.StrType)le.carrier_zip),
    CarrierReferenceMain_Fields.InValid_carrier_phone((SALT311.StrType)le.carrier_phone),
    CarrierReferenceMain_Fields.InValid_affiliated_to((SALT311.StrType)le.affiliated_to),
    CarrierReferenceMain_Fields.InValid_overall_company((SALT311.StrType)le.overall_company),
    CarrierReferenceMain_Fields.InValid_contact_function((SALT311.StrType)le.contact_function),
    CarrierReferenceMain_Fields.InValid_contact_name((SALT311.StrType)le.contact_name),
    CarrierReferenceMain_Fields.InValid_contact_title((SALT311.StrType)le.contact_title),
    CarrierReferenceMain_Fields.InValid_contact_address1((SALT311.StrType)le.contact_address1),
    CarrierReferenceMain_Fields.InValid_contact_address2((SALT311.StrType)le.contact_address2),
    CarrierReferenceMain_Fields.InValid_contact_city((SALT311.StrType)le.contact_city),
    CarrierReferenceMain_Fields.InValid_contact_state((SALT311.StrType)le.contact_state),
    CarrierReferenceMain_Fields.InValid_contact_zip((SALT311.StrType)le.contact_zip),
    CarrierReferenceMain_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone),
    CarrierReferenceMain_Fields.InValid_contact_fax((SALT311.StrType)le.contact_fax),
    CarrierReferenceMain_Fields.InValid_contact_email((SALT311.StrType)le.contact_email),
    CarrierReferenceMain_Fields.InValid_contact_information((SALT311.StrType)le.contact_information),
    CarrierReferenceMain_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    CarrierReferenceMain_Fields.InValid_predir((SALT311.StrType)le.predir),
    CarrierReferenceMain_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    CarrierReferenceMain_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    CarrierReferenceMain_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    CarrierReferenceMain_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    CarrierReferenceMain_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    CarrierReferenceMain_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    CarrierReferenceMain_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    CarrierReferenceMain_Fields.InValid_st((SALT311.StrType)le.st),
    CarrierReferenceMain_Fields.InValid_z5((SALT311.StrType)le.z5),
    CarrierReferenceMain_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    CarrierReferenceMain_Fields.InValid_cart((SALT311.StrType)le.cart),
    CarrierReferenceMain_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    CarrierReferenceMain_Fields.InValid_lot((SALT311.StrType)le.lot),
    CarrierReferenceMain_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    CarrierReferenceMain_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    CarrierReferenceMain_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    CarrierReferenceMain_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    CarrierReferenceMain_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    CarrierReferenceMain_Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    CarrierReferenceMain_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    CarrierReferenceMain_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    CarrierReferenceMain_Fields.InValid_msa((SALT311.StrType)le.msa),
    CarrierReferenceMain_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    CarrierReferenceMain_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    CarrierReferenceMain_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    CarrierReferenceMain_Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid),
    CarrierReferenceMain_Fields.InValid_address_type((SALT311.StrType)le.address_type),
    CarrierReferenceMain_Fields.InValid_privacy_indicator((SALT311.StrType)le.privacy_indicator),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,77,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := CarrierReferenceMain_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Ocn_Name','Invalid_NotBlank','Invalid_Type','Invalid_Type','Invalid_Flag','Invalid_Flag','Unknown','Unknown','Invalid_Ocn_Name','Invalid_NotBlank','Unknown','Invalid_Alpha','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_AlphaNum','Unknown','Invalid_Indicator','Invalid_Indicator','Invalid_Alpha','Unknown','Unknown','Unknown','Unknown','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Num','Invalid_Num','Invalid_Email','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,CarrierReferenceMain_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_dt_start(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_dt_end(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_serv(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_line(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_high_risk_indicator(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_activation_dt(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_number_in_service(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_spid(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_operator_full_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_is_current(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_override_file(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_data_type(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_ocn_state(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_overall_ocn(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_target_ocn(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_overall_target_ocn(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_ocn_abbr_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_rural_lec_indicator(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_small_ilec_indicator(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_category(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_address1(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_address2(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_floor(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_room(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_city(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_state(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_zip(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_carrier_phone(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_affiliated_to(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_overall_company(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_function(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_title(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_address1(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_address2(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_city(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_state(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_zip(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_fax(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_contact_information(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_predir(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_st(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_z5(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_cart(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_lot(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_msa(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_address_type(TotalErrors.ErrorNum),CarrierReferenceMain_Fields.InValidMessage_privacy_indicator(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, CarrierReferenceMain_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;

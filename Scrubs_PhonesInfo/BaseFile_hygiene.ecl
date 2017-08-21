IMPORT ut,SALT33;
EXPORT BaseFile_hygiene(dataset(BaseFile_layout_PhonesInfo) h) := MODULE
//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_reference_id_pcnt := AVE(GROUP,IF(h.reference_id = (TYPEOF(h.reference_id))'',0,100));
    maxlength_reference_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reference_id)));
    avelength_reference_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reference_id)),h.reference_id<>(typeof(h.reference_id))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_dt_first_reported_pcnt := AVE(GROUP,IF(h.dt_first_reported = (TYPEOF(h.dt_first_reported))'',0,100));
    maxlength_dt_first_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_reported)));
    avelength_dt_first_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_first_reported)),h.dt_first_reported<>(typeof(h.dt_first_reported))'');
    populated_dt_last_reported_pcnt := AVE(GROUP,IF(h.dt_last_reported = (TYPEOF(h.dt_last_reported))'',0,100));
    maxlength_dt_last_reported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_reported)));
    avelength_dt_last_reported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dt_last_reported)),h.dt_last_reported<>(typeof(h.dt_last_reported))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phonetype_pcnt := AVE(GROUP,IF(h.phonetype = (TYPEOF(h.phonetype))'',0,100));
    maxlength_phonetype := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phonetype)));
    avelength_phonetype := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phonetype)),h.phonetype<>(typeof(h.phonetype))'');
    populated_reply_code_pcnt := AVE(GROUP,IF(h.reply_code = (TYPEOF(h.reply_code))'',0,100));
    maxlength_reply_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.reply_code)));
    avelength_reply_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.reply_code)),h.reply_code<>(typeof(h.reply_code))'');
    populated_local_routing_number_pcnt := AVE(GROUP,IF(h.local_routing_number = (TYPEOF(h.local_routing_number))'',0,100));
    maxlength_local_routing_number := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.local_routing_number)));
    avelength_local_routing_number := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.local_routing_number)),h.local_routing_number<>(typeof(h.local_routing_number))'');
    populated_account_owner_pcnt := AVE(GROUP,IF(h.account_owner = (TYPEOF(h.account_owner))'',0,100));
    maxlength_account_owner := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_owner)));
    avelength_account_owner := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.account_owner)),h.account_owner<>(typeof(h.account_owner))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_carrier_category_pcnt := AVE(GROUP,IF(h.carrier_category = (TYPEOF(h.carrier_category))'',0,100));
    maxlength_carrier_category := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.carrier_category)));
    avelength_carrier_category := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.carrier_category)),h.carrier_category<>(typeof(h.carrier_category))'');
    populated_local_area_transport_area_pcnt := AVE(GROUP,IF(h.local_area_transport_area = (TYPEOF(h.local_area_transport_area))'',0,100));
    maxlength_local_area_transport_area := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.local_area_transport_area)));
    avelength_local_area_transport_area := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.local_area_transport_area)),h.local_area_transport_area<>(typeof(h.local_area_transport_area))'');
    populated_point_code_pcnt := AVE(GROUP,IF(h.point_code = (TYPEOF(h.point_code))'',0,100));
    maxlength_point_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.point_code)));
    avelength_point_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.point_code)),h.point_code<>(typeof(h.point_code))'');
    populated_country_code_pcnt := AVE(GROUP,IF(h.country_code = (TYPEOF(h.country_code))'',0,100));
    maxlength_country_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.country_code)));
    avelength_country_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.country_code)),h.country_code<>(typeof(h.country_code))'');
    populated_dial_type_pcnt := AVE(GROUP,IF(h.dial_type = (TYPEOF(h.dial_type))'',0,100));
    maxlength_dial_type := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.dial_type)));
    avelength_dial_type := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.dial_type)),h.dial_type<>(typeof(h.dial_type))'');
    populated_routing_code_pcnt := AVE(GROUP,IF(h.routing_code = (TYPEOF(h.routing_code))'',0,100));
    maxlength_routing_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.routing_code)));
    avelength_routing_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.routing_code)),h.routing_code<>(typeof(h.routing_code))'');
    populated_porting_dt_pcnt := AVE(GROUP,IF(h.porting_dt = (TYPEOF(h.porting_dt))'',0,100));
    maxlength_porting_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.porting_dt)));
    avelength_porting_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.porting_dt)),h.porting_dt<>(typeof(h.porting_dt))'');
    populated_porting_time_pcnt := AVE(GROUP,IF(h.porting_time = (TYPEOF(h.porting_time))'',0,100));
    maxlength_porting_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.porting_time)));
    avelength_porting_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.porting_time)),h.porting_time<>(typeof(h.porting_time))'');
    populated_country_abbr_pcnt := AVE(GROUP,IF(h.country_abbr = (TYPEOF(h.country_abbr))'',0,100));
    maxlength_country_abbr := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.country_abbr)));
    avelength_country_abbr := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.country_abbr)),h.country_abbr<>(typeof(h.country_abbr))'');
    populated_vendor_first_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_first_reported_dt = (TYPEOF(h.vendor_first_reported_dt))'',0,100));
    maxlength_vendor_first_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_first_reported_dt)));
    avelength_vendor_first_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_first_reported_dt)),h.vendor_first_reported_dt<>(typeof(h.vendor_first_reported_dt))'');
    populated_vendor_first_reported_time_pcnt := AVE(GROUP,IF(h.vendor_first_reported_time = (TYPEOF(h.vendor_first_reported_time))'',0,100));
    maxlength_vendor_first_reported_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_first_reported_time)));
    avelength_vendor_first_reported_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_first_reported_time)),h.vendor_first_reported_time<>(typeof(h.vendor_first_reported_time))'');
    populated_vendor_last_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_last_reported_dt = (TYPEOF(h.vendor_last_reported_dt))'',0,100));
    maxlength_vendor_last_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_last_reported_dt)));
    avelength_vendor_last_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_last_reported_dt)),h.vendor_last_reported_dt<>(typeof(h.vendor_last_reported_dt))'');
    populated_vendor_last_reported_time_pcnt := AVE(GROUP,IF(h.vendor_last_reported_time = (TYPEOF(h.vendor_last_reported_time))'',0,100));
    maxlength_vendor_last_reported_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_last_reported_time)));
    avelength_vendor_last_reported_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.vendor_last_reported_time)),h.vendor_last_reported_time<>(typeof(h.vendor_last_reported_time))'');
    populated_port_start_dt_pcnt := AVE(GROUP,IF(h.port_start_dt = (TYPEOF(h.port_start_dt))'',0,100));
    maxlength_port_start_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_start_dt)));
    avelength_port_start_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_start_dt)),h.port_start_dt<>(typeof(h.port_start_dt))'');
    populated_port_start_time_pcnt := AVE(GROUP,IF(h.port_start_time = (TYPEOF(h.port_start_time))'',0,100));
    maxlength_port_start_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_start_time)));
    avelength_port_start_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_start_time)),h.port_start_time<>(typeof(h.port_start_time))'');
    populated_port_end_dt_pcnt := AVE(GROUP,IF(h.port_end_dt = (TYPEOF(h.port_end_dt))'',0,100));
    maxlength_port_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_end_dt)));
    avelength_port_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_end_dt)),h.port_end_dt<>(typeof(h.port_end_dt))'');
    populated_port_end_time_pcnt := AVE(GROUP,IF(h.port_end_time = (TYPEOF(h.port_end_time))'',0,100));
    maxlength_port_end_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_end_time)));
    avelength_port_end_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.port_end_time)),h.port_end_time<>(typeof(h.port_end_time))'');
    populated_remove_port_dt_pcnt := AVE(GROUP,IF(h.remove_port_dt = (TYPEOF(h.remove_port_dt))'',0,100));
    maxlength_remove_port_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.remove_port_dt)));
    avelength_remove_port_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.remove_port_dt)),h.remove_port_dt<>(typeof(h.remove_port_dt))'');
    populated_is_ported_pcnt := AVE(GROUP,IF(h.is_ported = (TYPEOF(h.is_ported))'',0,100));
    maxlength_is_ported := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_ported)));
    avelength_is_ported := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_ported)),h.is_ported<>(typeof(h.is_ported))'');
    populated_serv_pcnt := AVE(GROUP,IF(h.serv = (TYPEOF(h.serv))'',0,100));
    maxlength_serv := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.serv)));
    avelength_serv := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.serv)),h.serv<>(typeof(h.serv))'');
    populated_line_pcnt := AVE(GROUP,IF(h.line = (TYPEOF(h.line))'',0,100));
    maxlength_line := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.line)));
    avelength_line := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.line)),h.line<>(typeof(h.line))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_operator_fullname_pcnt := AVE(GROUP,IF(h.operator_fullname = (TYPEOF(h.operator_fullname))'',0,100));
    maxlength_operator_fullname := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.operator_fullname)));
    avelength_operator_fullname := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.operator_fullname)),h.operator_fullname<>(typeof(h.operator_fullname))'');
    populated_number_in_service_pcnt := AVE(GROUP,IF(h.number_in_service = (TYPEOF(h.number_in_service))'',0,100));
    maxlength_number_in_service := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_in_service)));
    avelength_number_in_service := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.number_in_service)),h.number_in_service<>(typeof(h.number_in_service))'');
    populated_high_risk_indicator_pcnt := AVE(GROUP,IF(h.high_risk_indicator = (TYPEOF(h.high_risk_indicator))'',0,100));
    maxlength_high_risk_indicator := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.high_risk_indicator)));
    avelength_high_risk_indicator := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.high_risk_indicator)),h.high_risk_indicator<>(typeof(h.high_risk_indicator))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
    populated_phone_swap_pcnt := AVE(GROUP,IF(h.phone_swap = (TYPEOF(h.phone_swap))'',0,100));
    maxlength_phone_swap := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_swap)));
    avelength_phone_swap := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.phone_swap)),h.phone_swap<>(typeof(h.phone_swap))'');
    populated_swap_start_dt_pcnt := AVE(GROUP,IF(h.swap_start_dt = (TYPEOF(h.swap_start_dt))'',0,100));
    maxlength_swap_start_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_start_dt)));
    avelength_swap_start_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_start_dt)),h.swap_start_dt<>(typeof(h.swap_start_dt))'');
    populated_swap_start_time_pcnt := AVE(GROUP,IF(h.swap_start_time = (TYPEOF(h.swap_start_time))'',0,100));
    maxlength_swap_start_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_start_time)));
    avelength_swap_start_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_start_time)),h.swap_start_time<>(typeof(h.swap_start_time))'');
    populated_swap_end_dt_pcnt := AVE(GROUP,IF(h.swap_end_dt = (TYPEOF(h.swap_end_dt))'',0,100));
    maxlength_swap_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_end_dt)));
    avelength_swap_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_end_dt)),h.swap_end_dt<>(typeof(h.swap_end_dt))'');
    populated_swap_end_time_pcnt := AVE(GROUP,IF(h.swap_end_time = (TYPEOF(h.swap_end_time))'',0,100));
    maxlength_swap_end_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_end_time)));
    avelength_swap_end_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.swap_end_time)),h.swap_end_time<>(typeof(h.swap_end_time))'');
    populated_deact_code_pcnt := AVE(GROUP,IF(h.deact_code = (TYPEOF(h.deact_code))'',0,100));
    maxlength_deact_code := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_code)));
    avelength_deact_code := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_code)),h.deact_code<>(typeof(h.deact_code))'');
    populated_deact_start_dt_pcnt := AVE(GROUP,IF(h.deact_start_dt = (TYPEOF(h.deact_start_dt))'',0,100));
    maxlength_deact_start_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_start_dt)));
    avelength_deact_start_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_start_dt)),h.deact_start_dt<>(typeof(h.deact_start_dt))'');
    populated_deact_start_time_pcnt := AVE(GROUP,IF(h.deact_start_time = (TYPEOF(h.deact_start_time))'',0,100));
    maxlength_deact_start_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_start_time)));
    avelength_deact_start_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_start_time)),h.deact_start_time<>(typeof(h.deact_start_time))'');
    populated_deact_end_dt_pcnt := AVE(GROUP,IF(h.deact_end_dt = (TYPEOF(h.deact_end_dt))'',0,100));
    maxlength_deact_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_end_dt)));
    avelength_deact_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_end_dt)),h.deact_end_dt<>(typeof(h.deact_end_dt))'');
    populated_deact_end_time_pcnt := AVE(GROUP,IF(h.deact_end_time = (TYPEOF(h.deact_end_time))'',0,100));
    maxlength_deact_end_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_end_time)));
    avelength_deact_end_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.deact_end_time)),h.deact_end_time<>(typeof(h.deact_end_time))'');
    populated_react_start_dt_pcnt := AVE(GROUP,IF(h.react_start_dt = (TYPEOF(h.react_start_dt))'',0,100));
    maxlength_react_start_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_start_dt)));
    avelength_react_start_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_start_dt)),h.react_start_dt<>(typeof(h.react_start_dt))'');
    populated_react_start_time_pcnt := AVE(GROUP,IF(h.react_start_time = (TYPEOF(h.react_start_time))'',0,100));
    maxlength_react_start_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_start_time)));
    avelength_react_start_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_start_time)),h.react_start_time<>(typeof(h.react_start_time))'');
    populated_react_end_dt_pcnt := AVE(GROUP,IF(h.react_end_dt = (TYPEOF(h.react_end_dt))'',0,100));
    maxlength_react_end_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_end_dt)));
    avelength_react_end_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_end_dt)),h.react_end_dt<>(typeof(h.react_end_dt))'');
    populated_react_end_time_pcnt := AVE(GROUP,IF(h.react_end_time = (TYPEOF(h.react_end_time))'',0,100));
    maxlength_react_end_time := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_end_time)));
    avelength_react_end_time := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.react_end_time)),h.react_end_time<>(typeof(h.react_end_time))'');
    populated_is_deact_pcnt := AVE(GROUP,IF(h.is_deact = (TYPEOF(h.is_deact))'',0,100));
    maxlength_is_deact := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_deact)));
    avelength_is_deact := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_deact)),h.is_deact<>(typeof(h.is_deact))'');
    populated_is_react_pcnt := AVE(GROUP,IF(h.is_react = (TYPEOF(h.is_react))'',0,100));
    maxlength_is_react := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_react)));
    avelength_is_react := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.is_react)),h.is_react<>(typeof(h.is_react))'');
    populated_call_forward_dt_pcnt := AVE(GROUP,IF(h.call_forward_dt = (TYPEOF(h.call_forward_dt))'',0,100));
    maxlength_call_forward_dt := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.call_forward_dt)));
    avelength_call_forward_dt := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.call_forward_dt)),h.call_forward_dt<>(typeof(h.call_forward_dt))'');
    populated_caller_id_pcnt := AVE(GROUP,IF(h.caller_id = (TYPEOF(h.caller_id))'',0,100));
    maxlength_caller_id := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.caller_id)));
    avelength_caller_id := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.caller_id)),h.caller_id<>(typeof(h.caller_id))'');
    populated_subpoena_company_name_pcnt := AVE(GROUP,IF(h.subpoena_company_name = (TYPEOF(h.subpoena_company_name))'',0,100));
    maxlength_subpoena_company_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_company_name)));
    avelength_subpoena_company_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_company_name)),h.subpoena_company_name<>(typeof(h.subpoena_company_name))'');
    populated_subpoena_contact_name_pcnt := AVE(GROUP,IF(h.subpoena_contact_name = (TYPEOF(h.subpoena_contact_name))'',0,100));
    maxlength_subpoena_contact_name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_name)));
    avelength_subpoena_contact_name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_name)),h.subpoena_contact_name<>(typeof(h.subpoena_contact_name))'');
    populated_subpoena_carrier_address_pcnt := AVE(GROUP,IF(h.subpoena_carrier_address = (TYPEOF(h.subpoena_carrier_address))'',0,100));
    maxlength_subpoena_carrier_address := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_address)));
    avelength_subpoena_carrier_address := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_address)),h.subpoena_carrier_address<>(typeof(h.subpoena_carrier_address))'');
    populated_subpoena_carrier_city_pcnt := AVE(GROUP,IF(h.subpoena_carrier_city = (TYPEOF(h.subpoena_carrier_city))'',0,100));
    maxlength_subpoena_carrier_city := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_city)));
    avelength_subpoena_carrier_city := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_city)),h.subpoena_carrier_city<>(typeof(h.subpoena_carrier_city))'');
    populated_subpoena_carrier_state_pcnt := AVE(GROUP,IF(h.subpoena_carrier_state = (TYPEOF(h.subpoena_carrier_state))'',0,100));
    maxlength_subpoena_carrier_state := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_state)));
    avelength_subpoena_carrier_state := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_state)),h.subpoena_carrier_state<>(typeof(h.subpoena_carrier_state))'');
    populated_subpoena_carrier_zip_pcnt := AVE(GROUP,IF(h.subpoena_carrier_zip = (TYPEOF(h.subpoena_carrier_zip))'',0,100));
    maxlength_subpoena_carrier_zip := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_zip)));
    avelength_subpoena_carrier_zip := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_carrier_zip)),h.subpoena_carrier_zip<>(typeof(h.subpoena_carrier_zip))'');
    populated_subpoena_email_pcnt := AVE(GROUP,IF(h.subpoena_email = (TYPEOF(h.subpoena_email))'',0,100));
    maxlength_subpoena_email := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_email)));
    avelength_subpoena_email := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_email)),h.subpoena_email<>(typeof(h.subpoena_email))'');
    populated_subpoena_contact_phone_pcnt := AVE(GROUP,IF(h.subpoena_contact_phone = (TYPEOF(h.subpoena_contact_phone))'',0,100));
    maxlength_subpoena_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_phone)));
    avelength_subpoena_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_phone)),h.subpoena_contact_phone<>(typeof(h.subpoena_contact_phone))'');
    populated_subpoena_contact_fax_pcnt := AVE(GROUP,IF(h.subpoena_contact_fax = (TYPEOF(h.subpoena_contact_fax))'',0,100));
    maxlength_subpoena_contact_fax := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_fax)));
    avelength_subpoena_contact_fax := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.subpoena_contact_fax)),h.subpoena_contact_fax<>(typeof(h.subpoena_contact_fax))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_reference_id_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_dt_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_last_reported_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phonetype_pcnt *   0.00 / 100 + T.Populated_reply_code_pcnt *   0.00 / 100 + T.Populated_local_routing_number_pcnt *   0.00 / 100 + T.Populated_account_owner_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_carrier_category_pcnt *   0.00 / 100 + T.Populated_local_area_transport_area_pcnt *   0.00 / 100 + T.Populated_point_code_pcnt *   0.00 / 100 + T.Populated_country_code_pcnt *   0.00 / 100 + T.Populated_dial_type_pcnt *   0.00 / 100 + T.Populated_routing_code_pcnt *   0.00 / 100 + T.Populated_porting_dt_pcnt *   0.00 / 100 + T.Populated_porting_time_pcnt *   0.00 / 100 + T.Populated_country_abbr_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_time_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_time_pcnt *   0.00 / 100 + T.Populated_port_start_dt_pcnt *   0.00 / 100 + T.Populated_port_start_time_pcnt *   0.00 / 100 + T.Populated_port_end_dt_pcnt *   0.00 / 100 + T.Populated_port_end_time_pcnt *   0.00 / 100 + T.Populated_remove_port_dt_pcnt *   0.00 / 100 + T.Populated_is_ported_pcnt *   0.00 / 100 + T.Populated_serv_pcnt *   0.00 / 100 + T.Populated_line_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_operator_fullname_pcnt *   0.00 / 100 + T.Populated_number_in_service_pcnt *   0.00 / 100 + T.Populated_high_risk_indicator_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_phone_swap_pcnt *   0.00 / 100 + T.Populated_swap_start_dt_pcnt *   0.00 / 100 + T.Populated_swap_start_time_pcnt *   0.00 / 100 + T.Populated_swap_end_dt_pcnt *   0.00 / 100 + T.Populated_swap_end_time_pcnt *   0.00 / 100 + T.Populated_deact_code_pcnt *   0.00 / 100 + T.Populated_deact_start_dt_pcnt *   0.00 / 100 + T.Populated_deact_start_time_pcnt *   0.00 / 100 + T.Populated_deact_end_dt_pcnt *   0.00 / 100 + T.Populated_deact_end_time_pcnt *   0.00 / 100 + T.Populated_react_start_dt_pcnt *   0.00 / 100 + T.Populated_react_start_time_pcnt *   0.00 / 100 + T.Populated_react_end_dt_pcnt *   0.00 / 100 + T.Populated_react_end_time_pcnt *   0.00 / 100 + T.Populated_is_deact_pcnt *   0.00 / 100 + T.Populated_is_react_pcnt *   0.00 / 100 + T.Populated_call_forward_dt_pcnt *   0.00 / 100 + T.Populated_caller_id_pcnt *   0.00 / 100 + T.Populated_subpoena_company_name_pcnt *   0.00 / 100 + T.Populated_subpoena_contact_name_pcnt *   0.00 / 100 + T.Populated_subpoena_carrier_address_pcnt *   0.00 / 100 + T.Populated_subpoena_carrier_city_pcnt *   0.00 / 100 + T.Populated_subpoena_carrier_state_pcnt *   0.00 / 100 + T.Populated_subpoena_carrier_zip_pcnt *   0.00 / 100 + T.Populated_subpoena_email_pcnt *   0.00 / 100 + T.Populated_subpoena_contact_phone_pcnt *   0.00 / 100 + T.Populated_subpoena_contact_fax_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
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
  SELF.FieldName := CHOOSE(C,'reference_id','source','dt_first_reported','dt_last_reported','phone','phonetype','reply_code','local_routing_number','account_owner','carrier_name','carrier_category','local_area_transport_area','point_code','country_code','dial_type','routing_code','porting_dt','porting_time','country_abbr','vendor_first_reported_dt','vendor_first_reported_time','vendor_last_reported_dt','vendor_last_reported_time','port_start_dt','port_start_time','port_end_dt','port_end_time','remove_port_dt','is_ported','serv','line','spid','operator_fullname','number_in_service','high_risk_indicator','prepaid','phone_swap','swap_start_dt','swap_start_time','swap_end_dt','swap_end_time','deact_code','deact_start_dt','deact_start_time','deact_end_dt','deact_end_time','react_start_dt','react_start_time','react_end_dt','react_end_time','is_deact','is_react','call_forward_dt','caller_id','subpoena_company_name','subpoena_contact_name','subpoena_carrier_address','subpoena_carrier_city','subpoena_carrier_state','subpoena_carrier_zip','subpoena_email','subpoena_contact_phone','subpoena_contact_fax');
  SELF.populated_pcnt := CHOOSE(C,le.populated_reference_id_pcnt,le.populated_source_pcnt,le.populated_dt_first_reported_pcnt,le.populated_dt_last_reported_pcnt,le.populated_phone_pcnt,le.populated_phonetype_pcnt,le.populated_reply_code_pcnt,le.populated_local_routing_number_pcnt,le.populated_account_owner_pcnt,le.populated_carrier_name_pcnt,le.populated_carrier_category_pcnt,le.populated_local_area_transport_area_pcnt,le.populated_point_code_pcnt,le.populated_country_code_pcnt,le.populated_dial_type_pcnt,le.populated_routing_code_pcnt,le.populated_porting_dt_pcnt,le.populated_porting_time_pcnt,le.populated_country_abbr_pcnt,le.populated_vendor_first_reported_dt_pcnt,le.populated_vendor_first_reported_time_pcnt,le.populated_vendor_last_reported_dt_pcnt,le.populated_vendor_last_reported_time_pcnt,le.populated_port_start_dt_pcnt,le.populated_port_start_time_pcnt,le.populated_port_end_dt_pcnt,le.populated_port_end_time_pcnt,le.populated_remove_port_dt_pcnt,le.populated_is_ported_pcnt,le.populated_serv_pcnt,le.populated_line_pcnt,le.populated_spid_pcnt,le.populated_operator_fullname_pcnt,le.populated_number_in_service_pcnt,le.populated_high_risk_indicator_pcnt,le.populated_prepaid_pcnt,le.populated_phone_swap_pcnt,le.populated_swap_start_dt_pcnt,le.populated_swap_start_time_pcnt,le.populated_swap_end_dt_pcnt,le.populated_swap_end_time_pcnt,le.populated_deact_code_pcnt,le.populated_deact_start_dt_pcnt,le.populated_deact_start_time_pcnt,le.populated_deact_end_dt_pcnt,le.populated_deact_end_time_pcnt,le.populated_react_start_dt_pcnt,le.populated_react_start_time_pcnt,le.populated_react_end_dt_pcnt,le.populated_react_end_time_pcnt,le.populated_is_deact_pcnt,le.populated_is_react_pcnt,le.populated_call_forward_dt_pcnt,le.populated_caller_id_pcnt,le.populated_subpoena_company_name_pcnt,le.populated_subpoena_contact_name_pcnt,le.populated_subpoena_carrier_address_pcnt,le.populated_subpoena_carrier_city_pcnt,le.populated_subpoena_carrier_state_pcnt,le.populated_subpoena_carrier_zip_pcnt,le.populated_subpoena_email_pcnt,le.populated_subpoena_contact_phone_pcnt,le.populated_subpoena_contact_fax_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_reference_id,le.maxlength_source,le.maxlength_dt_first_reported,le.maxlength_dt_last_reported,le.maxlength_phone,le.maxlength_phonetype,le.maxlength_reply_code,le.maxlength_local_routing_number,le.maxlength_account_owner,le.maxlength_carrier_name,le.maxlength_carrier_category,le.maxlength_local_area_transport_area,le.maxlength_point_code,le.maxlength_country_code,le.maxlength_dial_type,le.maxlength_routing_code,le.maxlength_porting_dt,le.maxlength_porting_time,le.maxlength_country_abbr,le.maxlength_vendor_first_reported_dt,le.maxlength_vendor_first_reported_time,le.maxlength_vendor_last_reported_dt,le.maxlength_vendor_last_reported_time,le.maxlength_port_start_dt,le.maxlength_port_start_time,le.maxlength_port_end_dt,le.maxlength_port_end_time,le.maxlength_remove_port_dt,le.maxlength_is_ported,le.maxlength_serv,le.maxlength_line,le.maxlength_spid,le.maxlength_operator_fullname,le.maxlength_number_in_service,le.maxlength_high_risk_indicator,le.maxlength_prepaid,le.maxlength_phone_swap,le.maxlength_swap_start_dt,le.maxlength_swap_start_time,le.maxlength_swap_end_dt,le.maxlength_swap_end_time,le.maxlength_deact_code,le.maxlength_deact_start_dt,le.maxlength_deact_start_time,le.maxlength_deact_end_dt,le.maxlength_deact_end_time,le.maxlength_react_start_dt,le.maxlength_react_start_time,le.maxlength_react_end_dt,le.maxlength_react_end_time,le.maxlength_is_deact,le.maxlength_is_react,le.maxlength_call_forward_dt,le.maxlength_caller_id,le.maxlength_subpoena_company_name,le.maxlength_subpoena_contact_name,le.maxlength_subpoena_carrier_address,le.maxlength_subpoena_carrier_city,le.maxlength_subpoena_carrier_state,le.maxlength_subpoena_carrier_zip,le.maxlength_subpoena_email,le.maxlength_subpoena_contact_phone,le.maxlength_subpoena_contact_fax);
  SELF.avelength := CHOOSE(C,le.avelength_reference_id,le.avelength_source,le.avelength_dt_first_reported,le.avelength_dt_last_reported,le.avelength_phone,le.avelength_phonetype,le.avelength_reply_code,le.avelength_local_routing_number,le.avelength_account_owner,le.avelength_carrier_name,le.avelength_carrier_category,le.avelength_local_area_transport_area,le.avelength_point_code,le.avelength_country_code,le.avelength_dial_type,le.avelength_routing_code,le.avelength_porting_dt,le.avelength_porting_time,le.avelength_country_abbr,le.avelength_vendor_first_reported_dt,le.avelength_vendor_first_reported_time,le.avelength_vendor_last_reported_dt,le.avelength_vendor_last_reported_time,le.avelength_port_start_dt,le.avelength_port_start_time,le.avelength_port_end_dt,le.avelength_port_end_time,le.avelength_remove_port_dt,le.avelength_is_ported,le.avelength_serv,le.avelength_line,le.avelength_spid,le.avelength_operator_fullname,le.avelength_number_in_service,le.avelength_high_risk_indicator,le.avelength_prepaid,le.avelength_phone_swap,le.avelength_swap_start_dt,le.avelength_swap_start_time,le.avelength_swap_end_dt,le.avelength_swap_end_time,le.avelength_deact_code,le.avelength_deact_start_dt,le.avelength_deact_start_time,le.avelength_deact_end_dt,le.avelength_deact_end_time,le.avelength_react_start_dt,le.avelength_react_start_time,le.avelength_react_end_dt,le.avelength_react_end_time,le.avelength_is_deact,le.avelength_is_react,le.avelength_call_forward_dt,le.avelength_caller_id,le.avelength_subpoena_company_name,le.avelength_subpoena_contact_name,le.avelength_subpoena_carrier_address,le.avelength_subpoena_carrier_city,le.avelength_subpoena_carrier_state,le.avelength_subpoena_carrier_zip,le.avelength_subpoena_email,le.avelength_subpoena_contact_phone,le.avelength_subpoena_contact_fax);
END;
EXPORT invSummary := NORMALIZE(summary0, 63, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.reference_id),TRIM((SALT33.StrType)le.source),IF (le.dt_first_reported <> 0,TRIM((SALT33.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT33.StrType)le.dt_last_reported), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.reply_code),TRIM((SALT33.StrType)le.local_routing_number),TRIM((SALT33.StrType)le.account_owner),TRIM((SALT33.StrType)le.carrier_name),TRIM((SALT33.StrType)le.carrier_category),TRIM((SALT33.StrType)le.local_area_transport_area),TRIM((SALT33.StrType)le.point_code),TRIM((SALT33.StrType)le.country_code),TRIM((SALT33.StrType)le.dial_type),TRIM((SALT33.StrType)le.routing_code),IF (le.porting_dt <> 0,TRIM((SALT33.StrType)le.porting_dt), ''),TRIM((SALT33.StrType)le.porting_time),TRIM((SALT33.StrType)le.country_abbr),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_last_reported_time),IF (le.port_start_dt <> 0,TRIM((SALT33.StrType)le.port_start_dt), ''),TRIM((SALT33.StrType)le.port_start_time),IF (le.port_end_dt <> 0,TRIM((SALT33.StrType)le.port_end_dt), ''),TRIM((SALT33.StrType)le.port_end_time),IF (le.remove_port_dt <> 0,TRIM((SALT33.StrType)le.remove_port_dt), ''),TRIM((SALT33.StrType)le.is_ported),TRIM((SALT33.StrType)le.serv),TRIM((SALT33.StrType)le.line),TRIM((SALT33.StrType)le.spid),TRIM((SALT33.StrType)le.operator_fullname),TRIM((SALT33.StrType)le.number_in_service),TRIM((SALT33.StrType)le.high_risk_indicator),TRIM((SALT33.StrType)le.prepaid),TRIM((SALT33.StrType)le.phone_swap),IF (le.swap_start_dt <> 0,TRIM((SALT33.StrType)le.swap_start_dt), ''),TRIM((SALT33.StrType)le.swap_start_time),IF (le.swap_end_dt <> 0,TRIM((SALT33.StrType)le.swap_end_dt), ''),TRIM((SALT33.StrType)le.swap_end_time),TRIM((SALT33.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT33.StrType)le.deact_start_dt), ''),TRIM((SALT33.StrType)le.deact_start_time),IF (le.deact_end_dt <> 0,TRIM((SALT33.StrType)le.deact_end_dt), ''),TRIM((SALT33.StrType)le.deact_end_time),IF (le.react_start_dt <> 0,TRIM((SALT33.StrType)le.react_start_dt), ''),TRIM((SALT33.StrType)le.react_start_time),IF (le.react_end_dt <> 0,TRIM((SALT33.StrType)le.react_end_dt), ''),TRIM((SALT33.StrType)le.react_end_time),TRIM((SALT33.StrType)le.is_deact),TRIM((SALT33.StrType)le.is_react),IF (le.call_forward_dt <> 0,TRIM((SALT33.StrType)le.call_forward_dt), ''),TRIM((SALT33.StrType)le.caller_id),TRIM((SALT33.StrType)le.subpoena_company_name),TRIM((SALT33.StrType)le.subpoena_contact_name),TRIM((SALT33.StrType)le.subpoena_carrier_address),TRIM((SALT33.StrType)le.subpoena_carrier_city),TRIM((SALT33.StrType)le.subpoena_carrier_state),TRIM((SALT33.StrType)le.subpoena_carrier_zip),TRIM((SALT33.StrType)le.subpoena_email),TRIM((SALT33.StrType)le.subpoena_contact_phone),TRIM((SALT33.StrType)le.subpoena_contact_fax)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,63,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 63);
  SELF.FldNo2 := 1 + (C % 63);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.reference_id),TRIM((SALT33.StrType)le.source),IF (le.dt_first_reported <> 0,TRIM((SALT33.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT33.StrType)le.dt_last_reported), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.reply_code),TRIM((SALT33.StrType)le.local_routing_number),TRIM((SALT33.StrType)le.account_owner),TRIM((SALT33.StrType)le.carrier_name),TRIM((SALT33.StrType)le.carrier_category),TRIM((SALT33.StrType)le.local_area_transport_area),TRIM((SALT33.StrType)le.point_code),TRIM((SALT33.StrType)le.country_code),TRIM((SALT33.StrType)le.dial_type),TRIM((SALT33.StrType)le.routing_code),IF (le.porting_dt <> 0,TRIM((SALT33.StrType)le.porting_dt), ''),TRIM((SALT33.StrType)le.porting_time),TRIM((SALT33.StrType)le.country_abbr),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_last_reported_time),IF (le.port_start_dt <> 0,TRIM((SALT33.StrType)le.port_start_dt), ''),TRIM((SALT33.StrType)le.port_start_time),IF (le.port_end_dt <> 0,TRIM((SALT33.StrType)le.port_end_dt), ''),TRIM((SALT33.StrType)le.port_end_time),IF (le.remove_port_dt <> 0,TRIM((SALT33.StrType)le.remove_port_dt), ''),TRIM((SALT33.StrType)le.is_ported),TRIM((SALT33.StrType)le.serv),TRIM((SALT33.StrType)le.line),TRIM((SALT33.StrType)le.spid),TRIM((SALT33.StrType)le.operator_fullname),TRIM((SALT33.StrType)le.number_in_service),TRIM((SALT33.StrType)le.high_risk_indicator),TRIM((SALT33.StrType)le.prepaid),TRIM((SALT33.StrType)le.phone_swap),IF (le.swap_start_dt <> 0,TRIM((SALT33.StrType)le.swap_start_dt), ''),TRIM((SALT33.StrType)le.swap_start_time),IF (le.swap_end_dt <> 0,TRIM((SALT33.StrType)le.swap_end_dt), ''),TRIM((SALT33.StrType)le.swap_end_time),TRIM((SALT33.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT33.StrType)le.deact_start_dt), ''),TRIM((SALT33.StrType)le.deact_start_time),IF (le.deact_end_dt <> 0,TRIM((SALT33.StrType)le.deact_end_dt), ''),TRIM((SALT33.StrType)le.deact_end_time),IF (le.react_start_dt <> 0,TRIM((SALT33.StrType)le.react_start_dt), ''),TRIM((SALT33.StrType)le.react_start_time),IF (le.react_end_dt <> 0,TRIM((SALT33.StrType)le.react_end_dt), ''),TRIM((SALT33.StrType)le.react_end_time),TRIM((SALT33.StrType)le.is_deact),TRIM((SALT33.StrType)le.is_react),IF (le.call_forward_dt <> 0,TRIM((SALT33.StrType)le.call_forward_dt), ''),TRIM((SALT33.StrType)le.caller_id),TRIM((SALT33.StrType)le.subpoena_company_name),TRIM((SALT33.StrType)le.subpoena_contact_name),TRIM((SALT33.StrType)le.subpoena_carrier_address),TRIM((SALT33.StrType)le.subpoena_carrier_city),TRIM((SALT33.StrType)le.subpoena_carrier_state),TRIM((SALT33.StrType)le.subpoena_carrier_zip),TRIM((SALT33.StrType)le.subpoena_email),TRIM((SALT33.StrType)le.subpoena_contact_phone),TRIM((SALT33.StrType)le.subpoena_contact_fax)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.reference_id),TRIM((SALT33.StrType)le.source),IF (le.dt_first_reported <> 0,TRIM((SALT33.StrType)le.dt_first_reported), ''),IF (le.dt_last_reported <> 0,TRIM((SALT33.StrType)le.dt_last_reported), ''),TRIM((SALT33.StrType)le.phone),TRIM((SALT33.StrType)le.phonetype),TRIM((SALT33.StrType)le.reply_code),TRIM((SALT33.StrType)le.local_routing_number),TRIM((SALT33.StrType)le.account_owner),TRIM((SALT33.StrType)le.carrier_name),TRIM((SALT33.StrType)le.carrier_category),TRIM((SALT33.StrType)le.local_area_transport_area),TRIM((SALT33.StrType)le.point_code),TRIM((SALT33.StrType)le.country_code),TRIM((SALT33.StrType)le.dial_type),TRIM((SALT33.StrType)le.routing_code),IF (le.porting_dt <> 0,TRIM((SALT33.StrType)le.porting_dt), ''),TRIM((SALT33.StrType)le.porting_time),TRIM((SALT33.StrType)le.country_abbr),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_first_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_first_reported_time),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT33.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT33.StrType)le.vendor_last_reported_time),IF (le.port_start_dt <> 0,TRIM((SALT33.StrType)le.port_start_dt), ''),TRIM((SALT33.StrType)le.port_start_time),IF (le.port_end_dt <> 0,TRIM((SALT33.StrType)le.port_end_dt), ''),TRIM((SALT33.StrType)le.port_end_time),IF (le.remove_port_dt <> 0,TRIM((SALT33.StrType)le.remove_port_dt), ''),TRIM((SALT33.StrType)le.is_ported),TRIM((SALT33.StrType)le.serv),TRIM((SALT33.StrType)le.line),TRIM((SALT33.StrType)le.spid),TRIM((SALT33.StrType)le.operator_fullname),TRIM((SALT33.StrType)le.number_in_service),TRIM((SALT33.StrType)le.high_risk_indicator),TRIM((SALT33.StrType)le.prepaid),TRIM((SALT33.StrType)le.phone_swap),IF (le.swap_start_dt <> 0,TRIM((SALT33.StrType)le.swap_start_dt), ''),TRIM((SALT33.StrType)le.swap_start_time),IF (le.swap_end_dt <> 0,TRIM((SALT33.StrType)le.swap_end_dt), ''),TRIM((SALT33.StrType)le.swap_end_time),TRIM((SALT33.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT33.StrType)le.deact_start_dt), ''),TRIM((SALT33.StrType)le.deact_start_time),IF (le.deact_end_dt <> 0,TRIM((SALT33.StrType)le.deact_end_dt), ''),TRIM((SALT33.StrType)le.deact_end_time),IF (le.react_start_dt <> 0,TRIM((SALT33.StrType)le.react_start_dt), ''),TRIM((SALT33.StrType)le.react_start_time),IF (le.react_end_dt <> 0,TRIM((SALT33.StrType)le.react_end_dt), ''),TRIM((SALT33.StrType)le.react_end_time),TRIM((SALT33.StrType)le.is_deact),TRIM((SALT33.StrType)le.is_react),IF (le.call_forward_dt <> 0,TRIM((SALT33.StrType)le.call_forward_dt), ''),TRIM((SALT33.StrType)le.caller_id),TRIM((SALT33.StrType)le.subpoena_company_name),TRIM((SALT33.StrType)le.subpoena_contact_name),TRIM((SALT33.StrType)le.subpoena_carrier_address),TRIM((SALT33.StrType)le.subpoena_carrier_city),TRIM((SALT33.StrType)le.subpoena_carrier_state),TRIM((SALT33.StrType)le.subpoena_carrier_zip),TRIM((SALT33.StrType)le.subpoena_email),TRIM((SALT33.StrType)le.subpoena_contact_phone),TRIM((SALT33.StrType)le.subpoena_contact_fax)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),63*63,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'reference_id'}
      ,{2,'source'}
      ,{3,'dt_first_reported'}
      ,{4,'dt_last_reported'}
      ,{5,'phone'}
      ,{6,'phonetype'}
      ,{7,'reply_code'}
      ,{8,'local_routing_number'}
      ,{9,'account_owner'}
      ,{10,'carrier_name'}
      ,{11,'carrier_category'}
      ,{12,'local_area_transport_area'}
      ,{13,'point_code'}
      ,{14,'country_code'}
      ,{15,'dial_type'}
      ,{16,'routing_code'}
      ,{17,'porting_dt'}
      ,{18,'porting_time'}
      ,{19,'country_abbr'}
      ,{20,'vendor_first_reported_dt'}
      ,{21,'vendor_first_reported_time'}
      ,{22,'vendor_last_reported_dt'}
      ,{23,'vendor_last_reported_time'}
      ,{24,'port_start_dt'}
      ,{25,'port_start_time'}
      ,{26,'port_end_dt'}
      ,{27,'port_end_time'}
      ,{28,'remove_port_dt'}
      ,{29,'is_ported'}
      ,{30,'serv'}
      ,{31,'line'}
      ,{32,'spid'}
      ,{33,'operator_fullname'}
      ,{34,'number_in_service'}
      ,{35,'high_risk_indicator'}
      ,{36,'prepaid'}
      ,{37,'phone_swap'}
      ,{38,'swap_start_dt'}
      ,{39,'swap_start_time'}
      ,{40,'swap_end_dt'}
      ,{41,'swap_end_time'}
      ,{42,'deact_code'}
      ,{43,'deact_start_dt'}
      ,{44,'deact_start_time'}
      ,{45,'deact_end_dt'}
      ,{46,'deact_end_time'}
      ,{47,'react_start_dt'}
      ,{48,'react_start_time'}
      ,{49,'react_end_dt'}
      ,{50,'react_end_time'}
      ,{51,'is_deact'}
      ,{52,'is_react'}
      ,{53,'call_forward_dt'}
      ,{54,'caller_id'}
      ,{55,'subpoena_company_name'}
      ,{56,'subpoena_contact_name'}
      ,{57,'subpoena_carrier_address'}
      ,{58,'subpoena_carrier_city'}
      ,{59,'subpoena_carrier_state'}
      ,{60,'subpoena_carrier_zip'}
      ,{61,'subpoena_email'}
      ,{62,'subpoena_contact_phone'}
      ,{63,'subpoena_contact_fax'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    BaseFile_Fields.InValid_reference_id((SALT33.StrType)le.reference_id),
    BaseFile_Fields.InValid_source((SALT33.StrType)le.source),
    BaseFile_Fields.InValid_dt_first_reported((SALT33.StrType)le.dt_first_reported),
    BaseFile_Fields.InValid_dt_last_reported((SALT33.StrType)le.dt_last_reported),
    BaseFile_Fields.InValid_phone((SALT33.StrType)le.phone),
    BaseFile_Fields.InValid_phonetype((SALT33.StrType)le.phonetype),
    BaseFile_Fields.InValid_reply_code((SALT33.StrType)le.reply_code),
    BaseFile_Fields.InValid_local_routing_number((SALT33.StrType)le.local_routing_number),
    BaseFile_Fields.InValid_account_owner((SALT33.StrType)le.account_owner),
    BaseFile_Fields.InValid_carrier_name((SALT33.StrType)le.carrier_name),
    BaseFile_Fields.InValid_carrier_category((SALT33.StrType)le.carrier_category),
    BaseFile_Fields.InValid_local_area_transport_area((SALT33.StrType)le.local_area_transport_area),
    BaseFile_Fields.InValid_point_code((SALT33.StrType)le.point_code),
    BaseFile_Fields.InValid_country_code((SALT33.StrType)le.country_code),
    BaseFile_Fields.InValid_dial_type((SALT33.StrType)le.dial_type),
    BaseFile_Fields.InValid_routing_code((SALT33.StrType)le.routing_code),
    BaseFile_Fields.InValid_porting_dt((SALT33.StrType)le.porting_dt),
    BaseFile_Fields.InValid_porting_time((SALT33.StrType)le.porting_time),
    BaseFile_Fields.InValid_country_abbr((SALT33.StrType)le.country_abbr),
    BaseFile_Fields.InValid_vendor_first_reported_dt((SALT33.StrType)le.vendor_first_reported_dt),
    BaseFile_Fields.InValid_vendor_first_reported_time((SALT33.StrType)le.vendor_first_reported_time),
    BaseFile_Fields.InValid_vendor_last_reported_dt((SALT33.StrType)le.vendor_last_reported_dt),
    BaseFile_Fields.InValid_vendor_last_reported_time((SALT33.StrType)le.vendor_last_reported_time),
    BaseFile_Fields.InValid_port_start_dt((SALT33.StrType)le.port_start_dt),
    BaseFile_Fields.InValid_port_start_time((SALT33.StrType)le.port_start_time),
    BaseFile_Fields.InValid_port_end_dt((SALT33.StrType)le.port_end_dt),
    BaseFile_Fields.InValid_port_end_time((SALT33.StrType)le.port_end_time),
    BaseFile_Fields.InValid_remove_port_dt((SALT33.StrType)le.remove_port_dt),
    BaseFile_Fields.InValid_is_ported((SALT33.StrType)le.is_ported),
    BaseFile_Fields.InValid_serv((SALT33.StrType)le.serv),
    BaseFile_Fields.InValid_line((SALT33.StrType)le.line),
    BaseFile_Fields.InValid_spid((SALT33.StrType)le.spid),
    BaseFile_Fields.InValid_operator_fullname((SALT33.StrType)le.operator_fullname),
    BaseFile_Fields.InValid_number_in_service((SALT33.StrType)le.number_in_service),
    BaseFile_Fields.InValid_high_risk_indicator((SALT33.StrType)le.high_risk_indicator),
    BaseFile_Fields.InValid_prepaid((SALT33.StrType)le.prepaid),
    BaseFile_Fields.InValid_phone_swap((SALT33.StrType)le.phone_swap),
    BaseFile_Fields.InValid_swap_start_dt((SALT33.StrType)le.swap_start_dt),
    BaseFile_Fields.InValid_swap_start_time((SALT33.StrType)le.swap_start_time),
    BaseFile_Fields.InValid_swap_end_dt((SALT33.StrType)le.swap_end_dt),
    BaseFile_Fields.InValid_swap_end_time((SALT33.StrType)le.swap_end_time),
    BaseFile_Fields.InValid_deact_code((SALT33.StrType)le.deact_code),
    BaseFile_Fields.InValid_deact_start_dt((SALT33.StrType)le.deact_start_dt),
    BaseFile_Fields.InValid_deact_start_time((SALT33.StrType)le.deact_start_time),
    BaseFile_Fields.InValid_deact_end_dt((SALT33.StrType)le.deact_end_dt),
    BaseFile_Fields.InValid_deact_end_time((SALT33.StrType)le.deact_end_time),
    BaseFile_Fields.InValid_react_start_dt((SALT33.StrType)le.react_start_dt),
    BaseFile_Fields.InValid_react_start_time((SALT33.StrType)le.react_start_time),
    BaseFile_Fields.InValid_react_end_dt((SALT33.StrType)le.react_end_dt),
    BaseFile_Fields.InValid_react_end_time((SALT33.StrType)le.react_end_time),
    BaseFile_Fields.InValid_is_deact((SALT33.StrType)le.is_deact),
    BaseFile_Fields.InValid_is_react((SALT33.StrType)le.is_react),
    BaseFile_Fields.InValid_call_forward_dt((SALT33.StrType)le.call_forward_dt),
    BaseFile_Fields.InValid_caller_id((SALT33.StrType)le.caller_id),
    BaseFile_Fields.InValid_subpoena_company_name((SALT33.StrType)le.subpoena_company_name),
    BaseFile_Fields.InValid_subpoena_contact_name((SALT33.StrType)le.subpoena_contact_name),
    BaseFile_Fields.InValid_subpoena_carrier_address((SALT33.StrType)le.subpoena_carrier_address),
    BaseFile_Fields.InValid_subpoena_carrier_city((SALT33.StrType)le.subpoena_carrier_city),
    BaseFile_Fields.InValid_subpoena_carrier_state((SALT33.StrType)le.subpoena_carrier_state),
    BaseFile_Fields.InValid_subpoena_carrier_zip((SALT33.StrType)le.subpoena_carrier_zip),
    BaseFile_Fields.InValid_subpoena_email((SALT33.StrType)le.subpoena_email),
    BaseFile_Fields.InValid_subpoena_contact_phone((SALT33.StrType)le.subpoena_contact_phone),
    BaseFile_Fields.InValid_subpoena_contact_fax((SALT33.StrType)le.subpoena_contact_fax),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,63,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := BaseFile_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Invalid_Source','Invalid_Date','Invalid_Date','Invalid_Phone','Invalid_Phone_Type','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Unknown','Invalid_Num','Invalid_Dial_Type','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_ISO2','Invalid_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Future_Date','Unknown','Invalid_Zero_Three','Invalid_Zero_Three','Invalid_Num','Invalid_Char','Invalid_Num_In_Service','Invalid_YN','Invalid_YN','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Deact','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_Date','Invalid_Num','Invalid_Future_Date','Invalid_Num','Invalid_YN','Invalid_YN','Invalid_Date','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_State','Invalid_Num_Blank','Invalid_Char','Invalid_Phone','Invalid_Phone');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,BaseFile_Fields.InValidMessage_reference_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_source(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_dt_first_reported(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_dt_last_reported(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_phone(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_phonetype(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_reply_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_local_routing_number(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_account_owner(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_carrier_category(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_local_area_transport_area(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_point_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_country_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_dial_type(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_routing_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_porting_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_porting_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_country_abbr(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vendor_first_reported_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vendor_first_reported_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vendor_last_reported_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_vendor_last_reported_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_port_start_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_port_start_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_port_end_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_port_end_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_remove_port_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_is_ported(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_serv(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_line(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_spid(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_operator_fullname(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_number_in_service(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_high_risk_indicator(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_phone_swap(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_swap_start_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_swap_start_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_swap_end_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_swap_end_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_deact_code(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_deact_start_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_deact_start_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_deact_end_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_deact_end_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_react_start_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_react_start_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_react_end_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_react_end_time(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_is_deact(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_is_react(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_call_forward_dt(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_caller_id(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_company_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_contact_name(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_carrier_address(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_carrier_city(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_carrier_state(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_carrier_zip(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_email(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_contact_phone(TotalErrors.ErrorNum),BaseFile_Fields.InValidMessage_subpoena_contact_fax(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;

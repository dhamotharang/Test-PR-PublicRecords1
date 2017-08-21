IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_eCrash) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.report_code);    NumberOfRecords := COUNT(GROUP);
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_report_code_pcnt := AVE(GROUP,IF(h.report_code = (TYPEOF(h.report_code))'',0,100));
    maxlength_report_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_code)));
    avelength_report_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_code)),h.report_code<>(typeof(h.report_code))'');
    populated_report_category_pcnt := AVE(GROUP,IF(h.report_category = (TYPEOF(h.report_category))'',0,100));
    maxlength_report_category := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_category)));
    avelength_report_category := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_category)),h.report_category<>(typeof(h.report_category))'');
    populated_report_code_desc_pcnt := AVE(GROUP,IF(h.report_code_desc = (TYPEOF(h.report_code_desc))'',0,100));
    maxlength_report_code_desc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_code_desc)));
    avelength_report_code_desc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_code_desc)),h.report_code_desc<>(typeof(h.report_code_desc))'');
    populated_citation_id_pcnt := AVE(GROUP,IF(h.citation_id = (TYPEOF(h.citation_id))'',0,100));
    maxlength_citation_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_id)));
    avelength_citation_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_id)),h.citation_id<>(typeof(h.citation_id))'');
    populated_creation_date_pcnt := AVE(GROUP,IF(h.creation_date = (TYPEOF(h.creation_date))'',0,100));
    maxlength_creation_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.creation_date)));
    avelength_creation_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.creation_date)),h.creation_date<>(typeof(h.creation_date))'');
    populated_incident_id_pcnt := AVE(GROUP,IF(h.incident_id = (TYPEOF(h.incident_id))'',0,100));
    maxlength_incident_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_id)));
    avelength_incident_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_id)),h.incident_id<>(typeof(h.incident_id))'');
    populated_citation_issued_pcnt := AVE(GROUP,IF(h.citation_issued = (TYPEOF(h.citation_issued))'',0,100));
    maxlength_citation_issued := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_issued)));
    avelength_citation_issued := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_issued)),h.citation_issued<>(typeof(h.citation_issued))'');
    populated_citation_number1_pcnt := AVE(GROUP,IF(h.citation_number1 = (TYPEOF(h.citation_number1))'',0,100));
    maxlength_citation_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_number1)));
    avelength_citation_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_number1)),h.citation_number1<>(typeof(h.citation_number1))'');
    populated_citation_number2_pcnt := AVE(GROUP,IF(h.citation_number2 = (TYPEOF(h.citation_number2))'',0,100));
    maxlength_citation_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_number2)));
    avelength_citation_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_number2)),h.citation_number2<>(typeof(h.citation_number2))'');
    populated_section_number1_pcnt := AVE(GROUP,IF(h.section_number1 = (TYPEOF(h.section_number1))'',0,100));
    maxlength_section_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.section_number1)));
    avelength_section_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.section_number1)),h.section_number1<>(typeof(h.section_number1))'');
    populated_court_date_pcnt := AVE(GROUP,IF(h.court_date = (TYPEOF(h.court_date))'',0,100));
    maxlength_court_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_date)));
    avelength_court_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_date)),h.court_date<>(typeof(h.court_date))'');
    populated_court_time_pcnt := AVE(GROUP,IF(h.court_time = (TYPEOF(h.court_time))'',0,100));
    maxlength_court_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_time)));
    avelength_court_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.court_time)),h.court_time<>(typeof(h.court_time))'');
    populated_citation_detail1_pcnt := AVE(GROUP,IF(h.citation_detail1 = (TYPEOF(h.citation_detail1))'',0,100));
    maxlength_citation_detail1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_detail1)));
    avelength_citation_detail1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_detail1)),h.citation_detail1<>(typeof(h.citation_detail1))'');
    populated_local_code_pcnt := AVE(GROUP,IF(h.local_code = (TYPEOF(h.local_code))'',0,100));
    maxlength_local_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_code)));
    avelength_local_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_code)),h.local_code<>(typeof(h.local_code))'');
    populated_violation_code1_pcnt := AVE(GROUP,IF(h.violation_code1 = (TYPEOF(h.violation_code1))'',0,100));
    maxlength_violation_code1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_code1)));
    avelength_violation_code1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_code1)),h.violation_code1<>(typeof(h.violation_code1))'');
    populated_violation_code2_pcnt := AVE(GROUP,IF(h.violation_code2 = (TYPEOF(h.violation_code2))'',0,100));
    maxlength_violation_code2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_code2)));
    avelength_violation_code2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_code2)),h.violation_code2<>(typeof(h.violation_code2))'');
    populated_multiple_charges_indicator_pcnt := AVE(GROUP,IF(h.multiple_charges_indicator = (TYPEOF(h.multiple_charges_indicator))'',0,100));
    maxlength_multiple_charges_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.multiple_charges_indicator)));
    avelength_multiple_charges_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.multiple_charges_indicator)),h.multiple_charges_indicator<>(typeof(h.multiple_charges_indicator))'');
    populated_dui_indicator_pcnt := AVE(GROUP,IF(h.dui_indicator = (TYPEOF(h.dui_indicator))'',0,100));
    maxlength_dui_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dui_indicator)));
    avelength_dui_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dui_indicator)),h.dui_indicator<>(typeof(h.dui_indicator))'');
    populated_commercial_id_pcnt := AVE(GROUP,IF(h.commercial_id = (TYPEOF(h.commercial_id))'',0,100));
    maxlength_commercial_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_id)));
    avelength_commercial_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_id)),h.commercial_id<>(typeof(h.commercial_id))'');
    populated_vehicle_id_pcnt := AVE(GROUP,IF(h.vehicle_id = (TYPEOF(h.vehicle_id))'',0,100));
    maxlength_vehicle_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_id)));
    avelength_vehicle_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_id)),h.vehicle_id<>(typeof(h.vehicle_id))'');
    populated_commercial_info_source_pcnt := AVE(GROUP,IF(h.commercial_info_source = (TYPEOF(h.commercial_info_source))'',0,100));
    maxlength_commercial_info_source := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_info_source)));
    avelength_commercial_info_source := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_info_source)),h.commercial_info_source<>(typeof(h.commercial_info_source))'');
    populated_commercial_vehicle_type_pcnt := AVE(GROUP,IF(h.commercial_vehicle_type = (TYPEOF(h.commercial_vehicle_type))'',0,100));
    maxlength_commercial_vehicle_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_vehicle_type)));
    avelength_commercial_vehicle_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_vehicle_type)),h.commercial_vehicle_type<>(typeof(h.commercial_vehicle_type))'');
    populated_motor_carrier_id_dot_number_pcnt := AVE(GROUP,IF(h.motor_carrier_id_dot_number = (TYPEOF(h.motor_carrier_id_dot_number))'',0,100));
    maxlength_motor_carrier_id_dot_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_dot_number)));
    avelength_motor_carrier_id_dot_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_dot_number)),h.motor_carrier_id_dot_number<>(typeof(h.motor_carrier_id_dot_number))'');
    populated_motor_carrier_id_state_id_pcnt := AVE(GROUP,IF(h.motor_carrier_id_state_id = (TYPEOF(h.motor_carrier_id_state_id))'',0,100));
    maxlength_motor_carrier_id_state_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_state_id)));
    avelength_motor_carrier_id_state_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_state_id)),h.motor_carrier_id_state_id<>(typeof(h.motor_carrier_id_state_id))'');
    populated_motor_carrier_id_carrier_name_pcnt := AVE(GROUP,IF(h.motor_carrier_id_carrier_name = (TYPEOF(h.motor_carrier_id_carrier_name))'',0,100));
    maxlength_motor_carrier_id_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_carrier_name)));
    avelength_motor_carrier_id_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_carrier_name)),h.motor_carrier_id_carrier_name<>(typeof(h.motor_carrier_id_carrier_name))'');
    populated_motor_carrier_id_address_pcnt := AVE(GROUP,IF(h.motor_carrier_id_address = (TYPEOF(h.motor_carrier_id_address))'',0,100));
    maxlength_motor_carrier_id_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_address)));
    avelength_motor_carrier_id_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_address)),h.motor_carrier_id_address<>(typeof(h.motor_carrier_id_address))'');
    populated_motor_carrier_id_city_pcnt := AVE(GROUP,IF(h.motor_carrier_id_city = (TYPEOF(h.motor_carrier_id_city))'',0,100));
    maxlength_motor_carrier_id_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_city)));
    avelength_motor_carrier_id_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_city)),h.motor_carrier_id_city<>(typeof(h.motor_carrier_id_city))'');
    populated_motor_carrier_id_state_pcnt := AVE(GROUP,IF(h.motor_carrier_id_state = (TYPEOF(h.motor_carrier_id_state))'',0,100));
    maxlength_motor_carrier_id_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_state)));
    avelength_motor_carrier_id_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_state)),h.motor_carrier_id_state<>(typeof(h.motor_carrier_id_state))'');
    populated_motor_carrier_id_zipcode_pcnt := AVE(GROUP,IF(h.motor_carrier_id_zipcode = (TYPEOF(h.motor_carrier_id_zipcode))'',0,100));
    maxlength_motor_carrier_id_zipcode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_zipcode)));
    avelength_motor_carrier_id_zipcode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_zipcode)),h.motor_carrier_id_zipcode<>(typeof(h.motor_carrier_id_zipcode))'');
    populated_motor_carrier_id_commercial_indicator_pcnt := AVE(GROUP,IF(h.motor_carrier_id_commercial_indicator = (TYPEOF(h.motor_carrier_id_commercial_indicator))'',0,100));
    maxlength_motor_carrier_id_commercial_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_commercial_indicator)));
    avelength_motor_carrier_id_commercial_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_carrier_id_commercial_indicator)),h.motor_carrier_id_commercial_indicator<>(typeof(h.motor_carrier_id_commercial_indicator))'');
    populated_carrier_id_type_pcnt := AVE(GROUP,IF(h.carrier_id_type = (TYPEOF(h.carrier_id_type))'',0,100));
    maxlength_carrier_id_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_id_type)));
    avelength_carrier_id_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_id_type)),h.carrier_id_type<>(typeof(h.carrier_id_type))'');
    populated_carrier_unit_number_pcnt := AVE(GROUP,IF(h.carrier_unit_number = (TYPEOF(h.carrier_unit_number))'',0,100));
    maxlength_carrier_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_unit_number)));
    avelength_carrier_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_unit_number)),h.carrier_unit_number<>(typeof(h.carrier_unit_number))'');
    populated_dot_permit_number_pcnt := AVE(GROUP,IF(h.dot_permit_number = (TYPEOF(h.dot_permit_number))'',0,100));
    maxlength_dot_permit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_permit_number)));
    avelength_dot_permit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_permit_number)),h.dot_permit_number<>(typeof(h.dot_permit_number))'');
    populated_iccmc_number_pcnt := AVE(GROUP,IF(h.iccmc_number = (TYPEOF(h.iccmc_number))'',0,100));
    maxlength_iccmc_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.iccmc_number)));
    avelength_iccmc_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.iccmc_number)),h.iccmc_number<>(typeof(h.iccmc_number))'');
    populated_mcs_vehicle_inspection_pcnt := AVE(GROUP,IF(h.mcs_vehicle_inspection = (TYPEOF(h.mcs_vehicle_inspection))'',0,100));
    maxlength_mcs_vehicle_inspection := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_vehicle_inspection)));
    avelength_mcs_vehicle_inspection := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_vehicle_inspection)),h.mcs_vehicle_inspection<>(typeof(h.mcs_vehicle_inspection))'');
    populated_mcs_form_number_pcnt := AVE(GROUP,IF(h.mcs_form_number = (TYPEOF(h.mcs_form_number))'',0,100));
    maxlength_mcs_form_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_form_number)));
    avelength_mcs_form_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_form_number)),h.mcs_form_number<>(typeof(h.mcs_form_number))'');
    populated_mcs_out_of_service_pcnt := AVE(GROUP,IF(h.mcs_out_of_service = (TYPEOF(h.mcs_out_of_service))'',0,100));
    maxlength_mcs_out_of_service := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_out_of_service)));
    avelength_mcs_out_of_service := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_out_of_service)),h.mcs_out_of_service<>(typeof(h.mcs_out_of_service))'');
    populated_mcs_violation_related_pcnt := AVE(GROUP,IF(h.mcs_violation_related = (TYPEOF(h.mcs_violation_related))'',0,100));
    maxlength_mcs_violation_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_violation_related)));
    avelength_mcs_violation_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mcs_violation_related)),h.mcs_violation_related<>(typeof(h.mcs_violation_related))'');
    populated_number_of_axles_pcnt := AVE(GROUP,IF(h.number_of_axles = (TYPEOF(h.number_of_axles))'',0,100));
    maxlength_number_of_axles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_axles)));
    avelength_number_of_axles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_axles)),h.number_of_axles<>(typeof(h.number_of_axles))'');
    populated_number_of_tires_pcnt := AVE(GROUP,IF(h.number_of_tires = (TYPEOF(h.number_of_tires))'',0,100));
    maxlength_number_of_tires := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_tires)));
    avelength_number_of_tires := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_tires)),h.number_of_tires<>(typeof(h.number_of_tires))'');
    populated_gvw_over_10k_pounds_pcnt := AVE(GROUP,IF(h.gvw_over_10k_pounds = (TYPEOF(h.gvw_over_10k_pounds))'',0,100));
    maxlength_gvw_over_10k_pounds := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.gvw_over_10k_pounds)));
    avelength_gvw_over_10k_pounds := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.gvw_over_10k_pounds)),h.gvw_over_10k_pounds<>(typeof(h.gvw_over_10k_pounds))'');
    populated_weight_rating_pcnt := AVE(GROUP,IF(h.weight_rating = (TYPEOF(h.weight_rating))'',0,100));
    maxlength_weight_rating := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.weight_rating)));
    avelength_weight_rating := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.weight_rating)),h.weight_rating<>(typeof(h.weight_rating))'');
    populated_registered_gross_vehicle_weight_pcnt := AVE(GROUP,IF(h.registered_gross_vehicle_weight = (TYPEOF(h.registered_gross_vehicle_weight))'',0,100));
    maxlength_registered_gross_vehicle_weight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_gross_vehicle_weight)));
    avelength_registered_gross_vehicle_weight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_gross_vehicle_weight)),h.registered_gross_vehicle_weight<>(typeof(h.registered_gross_vehicle_weight))'');
    populated_vehicle_length_feet_pcnt := AVE(GROUP,IF(h.vehicle_length_feet = (TYPEOF(h.vehicle_length_feet))'',0,100));
    maxlength_vehicle_length_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_length_feet)));
    avelength_vehicle_length_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_length_feet)),h.vehicle_length_feet<>(typeof(h.vehicle_length_feet))'');
    populated_cargo_body_type_pcnt := AVE(GROUP,IF(h.cargo_body_type = (TYPEOF(h.cargo_body_type))'',0,100));
    maxlength_cargo_body_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cargo_body_type)));
    avelength_cargo_body_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cargo_body_type)),h.cargo_body_type<>(typeof(h.cargo_body_type))'');
    populated_load_type_pcnt := AVE(GROUP,IF(h.load_type = (TYPEOF(h.load_type))'',0,100));
    maxlength_load_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.load_type)));
    avelength_load_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.load_type)),h.load_type<>(typeof(h.load_type))'');
    populated_oversize_load_pcnt := AVE(GROUP,IF(h.oversize_load = (TYPEOF(h.oversize_load))'',0,100));
    maxlength_oversize_load := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_load)));
    avelength_oversize_load := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_load)),h.oversize_load<>(typeof(h.oversize_load))'');
    populated_vehicle_configuration_pcnt := AVE(GROUP,IF(h.vehicle_configuration = (TYPEOF(h.vehicle_configuration))'',0,100));
    maxlength_vehicle_configuration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_configuration)));
    avelength_vehicle_configuration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_configuration)),h.vehicle_configuration<>(typeof(h.vehicle_configuration))'');
    populated_trailer1_type_pcnt := AVE(GROUP,IF(h.trailer1_type = (TYPEOF(h.trailer1_type))'',0,100));
    maxlength_trailer1_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_type)));
    avelength_trailer1_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_type)),h.trailer1_type<>(typeof(h.trailer1_type))'');
    populated_trailer1_length_feet_pcnt := AVE(GROUP,IF(h.trailer1_length_feet = (TYPEOF(h.trailer1_length_feet))'',0,100));
    maxlength_trailer1_length_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_length_feet)));
    avelength_trailer1_length_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_length_feet)),h.trailer1_length_feet<>(typeof(h.trailer1_length_feet))'');
    populated_trailer1_width_feet_pcnt := AVE(GROUP,IF(h.trailer1_width_feet = (TYPEOF(h.trailer1_width_feet))'',0,100));
    maxlength_trailer1_width_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_width_feet)));
    avelength_trailer1_width_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer1_width_feet)),h.trailer1_width_feet<>(typeof(h.trailer1_width_feet))'');
    populated_trailer2_type_pcnt := AVE(GROUP,IF(h.trailer2_type = (TYPEOF(h.trailer2_type))'',0,100));
    maxlength_trailer2_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_type)));
    avelength_trailer2_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_type)),h.trailer2_type<>(typeof(h.trailer2_type))'');
    populated_trailer2_length_feet_pcnt := AVE(GROUP,IF(h.trailer2_length_feet = (TYPEOF(h.trailer2_length_feet))'',0,100));
    maxlength_trailer2_length_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_length_feet)));
    avelength_trailer2_length_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_length_feet)),h.trailer2_length_feet<>(typeof(h.trailer2_length_feet))'');
    populated_trailer2_width_feet_pcnt := AVE(GROUP,IF(h.trailer2_width_feet = (TYPEOF(h.trailer2_width_feet))'',0,100));
    maxlength_trailer2_width_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_width_feet)));
    avelength_trailer2_width_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trailer2_width_feet)),h.trailer2_width_feet<>(typeof(h.trailer2_width_feet))'');
    populated_federally_reportable_pcnt := AVE(GROUP,IF(h.federally_reportable = (TYPEOF(h.federally_reportable))'',0,100));
    maxlength_federally_reportable := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.federally_reportable)));
    avelength_federally_reportable := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.federally_reportable)),h.federally_reportable<>(typeof(h.federally_reportable))'');
    populated_vehicle_inspection_hazmat_pcnt := AVE(GROUP,IF(h.vehicle_inspection_hazmat = (TYPEOF(h.vehicle_inspection_hazmat))'',0,100));
    maxlength_vehicle_inspection_hazmat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_inspection_hazmat)));
    avelength_vehicle_inspection_hazmat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_inspection_hazmat)),h.vehicle_inspection_hazmat<>(typeof(h.vehicle_inspection_hazmat))'');
    populated_hazmat_form_number_pcnt := AVE(GROUP,IF(h.hazmat_form_number = (TYPEOF(h.hazmat_form_number))'',0,100));
    maxlength_hazmat_form_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_form_number)));
    avelength_hazmat_form_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_form_number)),h.hazmat_form_number<>(typeof(h.hazmat_form_number))'');
    populated_hazmt_out_of_service_pcnt := AVE(GROUP,IF(h.hazmt_out_of_service = (TYPEOF(h.hazmt_out_of_service))'',0,100));
    maxlength_hazmt_out_of_service := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmt_out_of_service)));
    avelength_hazmt_out_of_service := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmt_out_of_service)),h.hazmt_out_of_service<>(typeof(h.hazmt_out_of_service))'');
    populated_hazmat_violation_related_pcnt := AVE(GROUP,IF(h.hazmat_violation_related = (TYPEOF(h.hazmat_violation_related))'',0,100));
    maxlength_hazmat_violation_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_violation_related)));
    avelength_hazmat_violation_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_violation_related)),h.hazmat_violation_related<>(typeof(h.hazmat_violation_related))'');
    populated_hazardous_materials_placard_pcnt := AVE(GROUP,IF(h.hazardous_materials_placard = (TYPEOF(h.hazardous_materials_placard))'',0,100));
    maxlength_hazardous_materials_placard := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_placard)));
    avelength_hazardous_materials_placard := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_placard)),h.hazardous_materials_placard<>(typeof(h.hazardous_materials_placard))'');
    populated_hazardous_materials_class_number1_pcnt := AVE(GROUP,IF(h.hazardous_materials_class_number1 = (TYPEOF(h.hazardous_materials_class_number1))'',0,100));
    maxlength_hazardous_materials_class_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_class_number1)));
    avelength_hazardous_materials_class_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_class_number1)),h.hazardous_materials_class_number1<>(typeof(h.hazardous_materials_class_number1))'');
    populated_hazardous_materials_class_number2_pcnt := AVE(GROUP,IF(h.hazardous_materials_class_number2 = (TYPEOF(h.hazardous_materials_class_number2))'',0,100));
    maxlength_hazardous_materials_class_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_class_number2)));
    avelength_hazardous_materials_class_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_class_number2)),h.hazardous_materials_class_number2<>(typeof(h.hazardous_materials_class_number2))'');
    populated_hazmat_placard_name_pcnt := AVE(GROUP,IF(h.hazmat_placard_name = (TYPEOF(h.hazmat_placard_name))'',0,100));
    maxlength_hazmat_placard_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_placard_name)));
    avelength_hazmat_placard_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazmat_placard_name)),h.hazmat_placard_name<>(typeof(h.hazmat_placard_name))'');
    populated_hazardous_materials_released1_pcnt := AVE(GROUP,IF(h.hazardous_materials_released1 = (TYPEOF(h.hazardous_materials_released1))'',0,100));
    maxlength_hazardous_materials_released1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released1)));
    avelength_hazardous_materials_released1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released1)),h.hazardous_materials_released1<>(typeof(h.hazardous_materials_released1))'');
    populated_hazardous_materials_released2_pcnt := AVE(GROUP,IF(h.hazardous_materials_released2 = (TYPEOF(h.hazardous_materials_released2))'',0,100));
    maxlength_hazardous_materials_released2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released2)));
    avelength_hazardous_materials_released2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released2)),h.hazardous_materials_released2<>(typeof(h.hazardous_materials_released2))'');
    populated_hazardous_materials_released3_pcnt := AVE(GROUP,IF(h.hazardous_materials_released3 = (TYPEOF(h.hazardous_materials_released3))'',0,100));
    maxlength_hazardous_materials_released3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released3)));
    avelength_hazardous_materials_released3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released3)),h.hazardous_materials_released3<>(typeof(h.hazardous_materials_released3))'');
    populated_hazardous_materials_released4_pcnt := AVE(GROUP,IF(h.hazardous_materials_released4 = (TYPEOF(h.hazardous_materials_released4))'',0,100));
    maxlength_hazardous_materials_released4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released4)));
    avelength_hazardous_materials_released4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_released4)),h.hazardous_materials_released4<>(typeof(h.hazardous_materials_released4))'');
    populated_commercial_event1_pcnt := AVE(GROUP,IF(h.commercial_event1 = (TYPEOF(h.commercial_event1))'',0,100));
    maxlength_commercial_event1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event1)));
    avelength_commercial_event1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event1)),h.commercial_event1<>(typeof(h.commercial_event1))'');
    populated_commercial_event2_pcnt := AVE(GROUP,IF(h.commercial_event2 = (TYPEOF(h.commercial_event2))'',0,100));
    maxlength_commercial_event2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event2)));
    avelength_commercial_event2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event2)),h.commercial_event2<>(typeof(h.commercial_event2))'');
    populated_commercial_event3_pcnt := AVE(GROUP,IF(h.commercial_event3 = (TYPEOF(h.commercial_event3))'',0,100));
    maxlength_commercial_event3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event3)));
    avelength_commercial_event3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event3)),h.commercial_event3<>(typeof(h.commercial_event3))'');
    populated_commercial_event4_pcnt := AVE(GROUP,IF(h.commercial_event4 = (TYPEOF(h.commercial_event4))'',0,100));
    maxlength_commercial_event4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event4)));
    avelength_commercial_event4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event4)),h.commercial_event4<>(typeof(h.commercial_event4))'');
    populated_recommended_driver_reexam_pcnt := AVE(GROUP,IF(h.recommended_driver_reexam = (TYPEOF(h.recommended_driver_reexam))'',0,100));
    maxlength_recommended_driver_reexam := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.recommended_driver_reexam)));
    avelength_recommended_driver_reexam := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.recommended_driver_reexam)),h.recommended_driver_reexam<>(typeof(h.recommended_driver_reexam))'');
    populated_transporting_hazmat_pcnt := AVE(GROUP,IF(h.transporting_hazmat = (TYPEOF(h.transporting_hazmat))'',0,100));
    maxlength_transporting_hazmat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transporting_hazmat)));
    avelength_transporting_hazmat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transporting_hazmat)),h.transporting_hazmat<>(typeof(h.transporting_hazmat))'');
    populated_liquid_hazmat_volume_pcnt := AVE(GROUP,IF(h.liquid_hazmat_volume = (TYPEOF(h.liquid_hazmat_volume))'',0,100));
    maxlength_liquid_hazmat_volume := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.liquid_hazmat_volume)));
    avelength_liquid_hazmat_volume := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.liquid_hazmat_volume)),h.liquid_hazmat_volume<>(typeof(h.liquid_hazmat_volume))'');
    populated_oversize_vehicle_pcnt := AVE(GROUP,IF(h.oversize_vehicle = (TYPEOF(h.oversize_vehicle))'',0,100));
    maxlength_oversize_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_vehicle)));
    avelength_oversize_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_vehicle)),h.oversize_vehicle<>(typeof(h.oversize_vehicle))'');
    populated_overlength_vehicle_pcnt := AVE(GROUP,IF(h.overlength_vehicle = (TYPEOF(h.overlength_vehicle))'',0,100));
    maxlength_overlength_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.overlength_vehicle)));
    avelength_overlength_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.overlength_vehicle)),h.overlength_vehicle<>(typeof(h.overlength_vehicle))'');
    populated_oversize_vehicle_permitted_pcnt := AVE(GROUP,IF(h.oversize_vehicle_permitted = (TYPEOF(h.oversize_vehicle_permitted))'',0,100));
    maxlength_oversize_vehicle_permitted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_vehicle_permitted)));
    avelength_oversize_vehicle_permitted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.oversize_vehicle_permitted)),h.oversize_vehicle_permitted<>(typeof(h.oversize_vehicle_permitted))'');
    populated_overlength_vehicle_permitted_pcnt := AVE(GROUP,IF(h.overlength_vehicle_permitted = (TYPEOF(h.overlength_vehicle_permitted))'',0,100));
    maxlength_overlength_vehicle_permitted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.overlength_vehicle_permitted)));
    avelength_overlength_vehicle_permitted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.overlength_vehicle_permitted)),h.overlength_vehicle_permitted<>(typeof(h.overlength_vehicle_permitted))'');
    populated_carrier_phone_number_pcnt := AVE(GROUP,IF(h.carrier_phone_number = (TYPEOF(h.carrier_phone_number))'',0,100));
    maxlength_carrier_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_phone_number)));
    avelength_carrier_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.carrier_phone_number)),h.carrier_phone_number<>(typeof(h.carrier_phone_number))'');
    populated_commerce_type_pcnt := AVE(GROUP,IF(h.commerce_type = (TYPEOF(h.commerce_type))'',0,100));
    maxlength_commerce_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commerce_type)));
    avelength_commerce_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commerce_type)),h.commerce_type<>(typeof(h.commerce_type))'');
    populated_citation_issued_to_vehicle_pcnt := AVE(GROUP,IF(h.citation_issued_to_vehicle = (TYPEOF(h.citation_issued_to_vehicle))'',0,100));
    maxlength_citation_issued_to_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_issued_to_vehicle)));
    avelength_citation_issued_to_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_issued_to_vehicle)),h.citation_issued_to_vehicle<>(typeof(h.citation_issued_to_vehicle))'');
    populated_cdl_class_pcnt := AVE(GROUP,IF(h.cdl_class = (TYPEOF(h.cdl_class))'',0,100));
    maxlength_cdl_class := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cdl_class)));
    avelength_cdl_class := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cdl_class)),h.cdl_class<>(typeof(h.cdl_class))'');
    populated_dot_state_pcnt := AVE(GROUP,IF(h.dot_state = (TYPEOF(h.dot_state))'',0,100));
    maxlength_dot_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_state)));
    avelength_dot_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_state)),h.dot_state<>(typeof(h.dot_state))'');
    populated_fire_hazardous_materials_involvement_pcnt := AVE(GROUP,IF(h.fire_hazardous_materials_involvement = (TYPEOF(h.fire_hazardous_materials_involvement))'',0,100));
    maxlength_fire_hazardous_materials_involvement := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fire_hazardous_materials_involvement)));
    avelength_fire_hazardous_materials_involvement := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fire_hazardous_materials_involvement)),h.fire_hazardous_materials_involvement<>(typeof(h.fire_hazardous_materials_involvement))'');
    populated_commercial_event_description_pcnt := AVE(GROUP,IF(h.commercial_event_description = (TYPEOF(h.commercial_event_description))'',0,100));
    maxlength_commercial_event_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event_description)));
    avelength_commercial_event_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_event_description)),h.commercial_event_description<>(typeof(h.commercial_event_description))'');
    populated_supplment_required_hazmat_placard_pcnt := AVE(GROUP,IF(h.supplment_required_hazmat_placard = (TYPEOF(h.supplment_required_hazmat_placard))'',0,100));
    maxlength_supplment_required_hazmat_placard := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplment_required_hazmat_placard)));
    avelength_supplment_required_hazmat_placard := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplment_required_hazmat_placard)),h.supplment_required_hazmat_placard<>(typeof(h.supplment_required_hazmat_placard))'');
    populated_other_state_number1_pcnt := AVE(GROUP,IF(h.other_state_number1 = (TYPEOF(h.other_state_number1))'',0,100));
    maxlength_other_state_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_state_number1)));
    avelength_other_state_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_state_number1)),h.other_state_number1<>(typeof(h.other_state_number1))'');
    populated_other_state_number2_pcnt := AVE(GROUP,IF(h.other_state_number2 = (TYPEOF(h.other_state_number2))'',0,100));
    maxlength_other_state_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_state_number2)));
    avelength_other_state_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_state_number2)),h.other_state_number2<>(typeof(h.other_state_number2))'');
    populated_work_type_id_pcnt := AVE(GROUP,IF(h.work_type_id = (TYPEOF(h.work_type_id))'',0,100));
    maxlength_work_type_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_type_id)));
    avelength_work_type_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_type_id)),h.work_type_id<>(typeof(h.work_type_id))'');
    populated_report_id_pcnt := AVE(GROUP,IF(h.report_id = (TYPEOF(h.report_id))'',0,100));
    maxlength_report_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_id)));
    avelength_report_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_id)),h.report_id<>(typeof(h.report_id))'');
    populated_agency_id_pcnt := AVE(GROUP,IF(h.agency_id = (TYPEOF(h.agency_id))'',0,100));
    maxlength_agency_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_id)));
    avelength_agency_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_id)),h.agency_id<>(typeof(h.agency_id))'');
    populated_sent_to_hpcc_datetime_pcnt := AVE(GROUP,IF(h.sent_to_hpcc_datetime = (TYPEOF(h.sent_to_hpcc_datetime))'',0,100));
    maxlength_sent_to_hpcc_datetime := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sent_to_hpcc_datetime)));
    avelength_sent_to_hpcc_datetime := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sent_to_hpcc_datetime)),h.sent_to_hpcc_datetime<>(typeof(h.sent_to_hpcc_datetime))'');
    populated_corrected_incident_pcnt := AVE(GROUP,IF(h.corrected_incident = (TYPEOF(h.corrected_incident))'',0,100));
    maxlength_corrected_incident := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corrected_incident)));
    avelength_corrected_incident := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corrected_incident)),h.corrected_incident<>(typeof(h.corrected_incident))'');
    populated_cru_order_id_pcnt := AVE(GROUP,IF(h.cru_order_id = (TYPEOF(h.cru_order_id))'',0,100));
    maxlength_cru_order_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_order_id)));
    avelength_cru_order_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_order_id)),h.cru_order_id<>(typeof(h.cru_order_id))'');
    populated_cru_sequence_nbr_pcnt := AVE(GROUP,IF(h.cru_sequence_nbr = (TYPEOF(h.cru_sequence_nbr))'',0,100));
    maxlength_cru_sequence_nbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_sequence_nbr)));
    avelength_cru_sequence_nbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_sequence_nbr)),h.cru_sequence_nbr<>(typeof(h.cru_sequence_nbr))'');
    populated_loss_state_abbr_pcnt := AVE(GROUP,IF(h.loss_state_abbr = (TYPEOF(h.loss_state_abbr))'',0,100));
    maxlength_loss_state_abbr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_state_abbr)));
    avelength_loss_state_abbr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_state_abbr)),h.loss_state_abbr<>(typeof(h.loss_state_abbr))'');
    populated_report_type_id_pcnt := AVE(GROUP,IF(h.report_type_id = (TYPEOF(h.report_type_id))'',0,100));
    maxlength_report_type_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_type_id)));
    avelength_report_type_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_type_id)),h.report_type_id<>(typeof(h.report_type_id))'');
    populated_hash_key_pcnt := AVE(GROUP,IF(h.hash_key = (TYPEOF(h.hash_key))'',0,100));
    maxlength_hash_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hash_key)));
    avelength_hash_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hash_key)),h.hash_key<>(typeof(h.hash_key))'');
    populated_case_identifier_pcnt := AVE(GROUP,IF(h.case_identifier = (TYPEOF(h.case_identifier))'',0,100));
    maxlength_case_identifier := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_identifier)));
    avelength_case_identifier := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.case_identifier)),h.case_identifier<>(typeof(h.case_identifier))'');
    populated_crash_county_pcnt := AVE(GROUP,IF(h.crash_county = (TYPEOF(h.crash_county))'',0,100));
    maxlength_crash_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_county)));
    avelength_crash_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_county)),h.crash_county<>(typeof(h.crash_county))'');
    populated_county_cd_pcnt := AVE(GROUP,IF(h.county_cd = (TYPEOF(h.county_cd))'',0,100));
    maxlength_county_cd := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_cd)));
    avelength_county_cd := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_cd)),h.county_cd<>(typeof(h.county_cd))'');
    populated_crash_cityplace_pcnt := AVE(GROUP,IF(h.crash_cityplace = (TYPEOF(h.crash_cityplace))'',0,100));
    maxlength_crash_cityplace := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_cityplace)));
    avelength_crash_cityplace := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_cityplace)),h.crash_cityplace<>(typeof(h.crash_cityplace))'');
    populated_crash_city_pcnt := AVE(GROUP,IF(h.crash_city = (TYPEOF(h.crash_city))'',0,100));
    maxlength_crash_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_city)));
    avelength_crash_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_city)),h.crash_city<>(typeof(h.crash_city))'');
    populated_city_code_pcnt := AVE(GROUP,IF(h.city_code = (TYPEOF(h.city_code))'',0,100));
    maxlength_city_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_code)));
    avelength_city_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_code)),h.city_code<>(typeof(h.city_code))'');
    populated_first_harmful_event_pcnt := AVE(GROUP,IF(h.first_harmful_event = (TYPEOF(h.first_harmful_event))'',0,100));
    maxlength_first_harmful_event := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event)));
    avelength_first_harmful_event := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event)),h.first_harmful_event<>(typeof(h.first_harmful_event))'');
    populated_first_harmful_event_location_pcnt := AVE(GROUP,IF(h.first_harmful_event_location = (TYPEOF(h.first_harmful_event_location))'',0,100));
    maxlength_first_harmful_event_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_location)));
    avelength_first_harmful_event_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_location)),h.first_harmful_event_location<>(typeof(h.first_harmful_event_location))'');
    populated_manner_crash_impact1_pcnt := AVE(GROUP,IF(h.manner_crash_impact1 = (TYPEOF(h.manner_crash_impact1))'',0,100));
    maxlength_manner_crash_impact1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.manner_crash_impact1)));
    avelength_manner_crash_impact1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.manner_crash_impact1)),h.manner_crash_impact1<>(typeof(h.manner_crash_impact1))'');
    populated_weather_condition1_pcnt := AVE(GROUP,IF(h.weather_condition1 = (TYPEOF(h.weather_condition1))'',0,100));
    maxlength_weather_condition1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_condition1)));
    avelength_weather_condition1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_condition1)),h.weather_condition1<>(typeof(h.weather_condition1))'');
    populated_weather_condition2_pcnt := AVE(GROUP,IF(h.weather_condition2 = (TYPEOF(h.weather_condition2))'',0,100));
    maxlength_weather_condition2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_condition2)));
    avelength_weather_condition2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_condition2)),h.weather_condition2<>(typeof(h.weather_condition2))'');
    populated_light_condition1_pcnt := AVE(GROUP,IF(h.light_condition1 = (TYPEOF(h.light_condition1))'',0,100));
    maxlength_light_condition1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.light_condition1)));
    avelength_light_condition1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.light_condition1)),h.light_condition1<>(typeof(h.light_condition1))'');
    populated_light_condition2_pcnt := AVE(GROUP,IF(h.light_condition2 = (TYPEOF(h.light_condition2))'',0,100));
    maxlength_light_condition2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.light_condition2)));
    avelength_light_condition2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.light_condition2)),h.light_condition2<>(typeof(h.light_condition2))'');
    populated_road_surface_condition_pcnt := AVE(GROUP,IF(h.road_surface_condition = (TYPEOF(h.road_surface_condition))'',0,100));
    maxlength_road_surface_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_surface_condition)));
    avelength_road_surface_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_surface_condition)),h.road_surface_condition<>(typeof(h.road_surface_condition))'');
    populated_contributing_circumstances_environmental1_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental1 = (TYPEOF(h.contributing_circumstances_environmental1))'',0,100));
    maxlength_contributing_circumstances_environmental1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental1)));
    avelength_contributing_circumstances_environmental1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental1)),h.contributing_circumstances_environmental1<>(typeof(h.contributing_circumstances_environmental1))'');
    populated_contributing_circumstances_environmental2_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental2 = (TYPEOF(h.contributing_circumstances_environmental2))'',0,100));
    maxlength_contributing_circumstances_environmental2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental2)));
    avelength_contributing_circumstances_environmental2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental2)),h.contributing_circumstances_environmental2<>(typeof(h.contributing_circumstances_environmental2))'');
    populated_contributing_circumstances_environmental3_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental3 = (TYPEOF(h.contributing_circumstances_environmental3))'',0,100));
    maxlength_contributing_circumstances_environmental3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental3)));
    avelength_contributing_circumstances_environmental3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental3)),h.contributing_circumstances_environmental3<>(typeof(h.contributing_circumstances_environmental3))'');
    populated_contributing_circumstances_environmental4_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental4 = (TYPEOF(h.contributing_circumstances_environmental4))'',0,100));
    maxlength_contributing_circumstances_environmental4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental4)));
    avelength_contributing_circumstances_environmental4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental4)),h.contributing_circumstances_environmental4<>(typeof(h.contributing_circumstances_environmental4))'');
    populated_contributing_circumstances_road1_pcnt := AVE(GROUP,IF(h.contributing_circumstances_road1 = (TYPEOF(h.contributing_circumstances_road1))'',0,100));
    maxlength_contributing_circumstances_road1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road1)));
    avelength_contributing_circumstances_road1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road1)),h.contributing_circumstances_road1<>(typeof(h.contributing_circumstances_road1))'');
    populated_contributing_circumstances_road2_pcnt := AVE(GROUP,IF(h.contributing_circumstances_road2 = (TYPEOF(h.contributing_circumstances_road2))'',0,100));
    maxlength_contributing_circumstances_road2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road2)));
    avelength_contributing_circumstances_road2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road2)),h.contributing_circumstances_road2<>(typeof(h.contributing_circumstances_road2))'');
    populated_contributing_circumstances_road3_pcnt := AVE(GROUP,IF(h.contributing_circumstances_road3 = (TYPEOF(h.contributing_circumstances_road3))'',0,100));
    maxlength_contributing_circumstances_road3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road3)));
    avelength_contributing_circumstances_road3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road3)),h.contributing_circumstances_road3<>(typeof(h.contributing_circumstances_road3))'');
    populated_contributing_circumstances_road4_pcnt := AVE(GROUP,IF(h.contributing_circumstances_road4 = (TYPEOF(h.contributing_circumstances_road4))'',0,100));
    maxlength_contributing_circumstances_road4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road4)));
    avelength_contributing_circumstances_road4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_road4)),h.contributing_circumstances_road4<>(typeof(h.contributing_circumstances_road4))'');
    populated_relation_to_junction_pcnt := AVE(GROUP,IF(h.relation_to_junction = (TYPEOF(h.relation_to_junction))'',0,100));
    maxlength_relation_to_junction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.relation_to_junction)));
    avelength_relation_to_junction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.relation_to_junction)),h.relation_to_junction<>(typeof(h.relation_to_junction))'');
    populated_intersection_type_pcnt := AVE(GROUP,IF(h.intersection_type = (TYPEOF(h.intersection_type))'',0,100));
    maxlength_intersection_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersection_type)));
    avelength_intersection_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersection_type)),h.intersection_type<>(typeof(h.intersection_type))'');
    populated_school_bus_related_pcnt := AVE(GROUP,IF(h.school_bus_related = (TYPEOF(h.school_bus_related))'',0,100));
    maxlength_school_bus_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.school_bus_related)));
    avelength_school_bus_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.school_bus_related)),h.school_bus_related<>(typeof(h.school_bus_related))'');
    populated_work_zone_related_pcnt := AVE(GROUP,IF(h.work_zone_related = (TYPEOF(h.work_zone_related))'',0,100));
    maxlength_work_zone_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_related)));
    avelength_work_zone_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_related)),h.work_zone_related<>(typeof(h.work_zone_related))'');
    populated_work_zone_location_pcnt := AVE(GROUP,IF(h.work_zone_location = (TYPEOF(h.work_zone_location))'',0,100));
    maxlength_work_zone_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_location)));
    avelength_work_zone_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_location)),h.work_zone_location<>(typeof(h.work_zone_location))'');
    populated_work_zone_type_pcnt := AVE(GROUP,IF(h.work_zone_type = (TYPEOF(h.work_zone_type))'',0,100));
    maxlength_work_zone_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_type)));
    avelength_work_zone_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_type)),h.work_zone_type<>(typeof(h.work_zone_type))'');
    populated_work_zone_workers_present_pcnt := AVE(GROUP,IF(h.work_zone_workers_present = (TYPEOF(h.work_zone_workers_present))'',0,100));
    maxlength_work_zone_workers_present := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_workers_present)));
    avelength_work_zone_workers_present := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_workers_present)),h.work_zone_workers_present<>(typeof(h.work_zone_workers_present))'');
    populated_work_zone_law_enforcement_present_pcnt := AVE(GROUP,IF(h.work_zone_law_enforcement_present = (TYPEOF(h.work_zone_law_enforcement_present))'',0,100));
    maxlength_work_zone_law_enforcement_present := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_law_enforcement_present)));
    avelength_work_zone_law_enforcement_present := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_law_enforcement_present)),h.work_zone_law_enforcement_present<>(typeof(h.work_zone_law_enforcement_present))'');
    populated_crash_severity_pcnt := AVE(GROUP,IF(h.crash_severity = (TYPEOF(h.crash_severity))'',0,100));
    maxlength_crash_severity := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_severity)));
    avelength_crash_severity := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_severity)),h.crash_severity<>(typeof(h.crash_severity))'');
    populated_number_of_vehicles_pcnt := AVE(GROUP,IF(h.number_of_vehicles = (TYPEOF(h.number_of_vehicles))'',0,100));
    maxlength_number_of_vehicles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_vehicles)));
    avelength_number_of_vehicles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_vehicles)),h.number_of_vehicles<>(typeof(h.number_of_vehicles))'');
    populated_total_nonfatal_injuries_pcnt := AVE(GROUP,IF(h.total_nonfatal_injuries = (TYPEOF(h.total_nonfatal_injuries))'',0,100));
    maxlength_total_nonfatal_injuries := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_nonfatal_injuries)));
    avelength_total_nonfatal_injuries := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_nonfatal_injuries)),h.total_nonfatal_injuries<>(typeof(h.total_nonfatal_injuries))'');
    populated_total_fatal_injuries_pcnt := AVE(GROUP,IF(h.total_fatal_injuries = (TYPEOF(h.total_fatal_injuries))'',0,100));
    maxlength_total_fatal_injuries := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_fatal_injuries)));
    avelength_total_fatal_injuries := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_fatal_injuries)),h.total_fatal_injuries<>(typeof(h.total_fatal_injuries))'');
    populated_day_of_week_pcnt := AVE(GROUP,IF(h.day_of_week = (TYPEOF(h.day_of_week))'',0,100));
    maxlength_day_of_week := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.day_of_week)));
    avelength_day_of_week := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.day_of_week)),h.day_of_week<>(typeof(h.day_of_week))'');
    populated_roadway_curvature_pcnt := AVE(GROUP,IF(h.roadway_curvature = (TYPEOF(h.roadway_curvature))'',0,100));
    maxlength_roadway_curvature := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_curvature)));
    avelength_roadway_curvature := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_curvature)),h.roadway_curvature<>(typeof(h.roadway_curvature))'');
    populated_part_of_national_highway_system_pcnt := AVE(GROUP,IF(h.part_of_national_highway_system = (TYPEOF(h.part_of_national_highway_system))'',0,100));
    maxlength_part_of_national_highway_system := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.part_of_national_highway_system)));
    avelength_part_of_national_highway_system := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.part_of_national_highway_system)),h.part_of_national_highway_system<>(typeof(h.part_of_national_highway_system))'');
    populated_roadway_functional_class_pcnt := AVE(GROUP,IF(h.roadway_functional_class = (TYPEOF(h.roadway_functional_class))'',0,100));
    maxlength_roadway_functional_class := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_functional_class)));
    avelength_roadway_functional_class := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_functional_class)),h.roadway_functional_class<>(typeof(h.roadway_functional_class))'');
    populated_access_control_pcnt := AVE(GROUP,IF(h.access_control = (TYPEOF(h.access_control))'',0,100));
    maxlength_access_control := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.access_control)));
    avelength_access_control := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.access_control)),h.access_control<>(typeof(h.access_control))'');
    populated_rr_crossing_id_pcnt := AVE(GROUP,IF(h.rr_crossing_id = (TYPEOF(h.rr_crossing_id))'',0,100));
    maxlength_rr_crossing_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rr_crossing_id)));
    avelength_rr_crossing_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rr_crossing_id)),h.rr_crossing_id<>(typeof(h.rr_crossing_id))'');
    populated_roadway_lighting_pcnt := AVE(GROUP,IF(h.roadway_lighting = (TYPEOF(h.roadway_lighting))'',0,100));
    maxlength_roadway_lighting := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_lighting)));
    avelength_roadway_lighting := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_lighting)),h.roadway_lighting<>(typeof(h.roadway_lighting))'');
    populated_traffic_control_type_at_intersection1_pcnt := AVE(GROUP,IF(h.traffic_control_type_at_intersection1 = (TYPEOF(h.traffic_control_type_at_intersection1))'',0,100));
    maxlength_traffic_control_type_at_intersection1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_type_at_intersection1)));
    avelength_traffic_control_type_at_intersection1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_type_at_intersection1)),h.traffic_control_type_at_intersection1<>(typeof(h.traffic_control_type_at_intersection1))'');
    populated_traffic_control_type_at_intersection2_pcnt := AVE(GROUP,IF(h.traffic_control_type_at_intersection2 = (TYPEOF(h.traffic_control_type_at_intersection2))'',0,100));
    maxlength_traffic_control_type_at_intersection2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_type_at_intersection2)));
    avelength_traffic_control_type_at_intersection2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_type_at_intersection2)),h.traffic_control_type_at_intersection2<>(typeof(h.traffic_control_type_at_intersection2))'');
    populated_ncic_number_pcnt := AVE(GROUP,IF(h.ncic_number = (TYPEOF(h.ncic_number))'',0,100));
    maxlength_ncic_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ncic_number)));
    avelength_ncic_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ncic_number)),h.ncic_number<>(typeof(h.ncic_number))'');
    populated_state_report_number_pcnt := AVE(GROUP,IF(h.state_report_number = (TYPEOF(h.state_report_number))'',0,100));
    maxlength_state_report_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_report_number)));
    avelength_state_report_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_report_number)),h.state_report_number<>(typeof(h.state_report_number))'');
    populated_ori_number_pcnt := AVE(GROUP,IF(h.ori_number = (TYPEOF(h.ori_number))'',0,100));
    maxlength_ori_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ori_number)));
    avelength_ori_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ori_number)),h.ori_number<>(typeof(h.ori_number))'');
    populated_crash_date_pcnt := AVE(GROUP,IF(h.crash_date = (TYPEOF(h.crash_date))'',0,100));
    maxlength_crash_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_date)));
    avelength_crash_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_date)),h.crash_date<>(typeof(h.crash_date))'');
    populated_crash_time_pcnt := AVE(GROUP,IF(h.crash_time = (TYPEOF(h.crash_time))'',0,100));
    maxlength_crash_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_time)));
    avelength_crash_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_time)),h.crash_time<>(typeof(h.crash_time))'');
    populated_lattitude_pcnt := AVE(GROUP,IF(h.lattitude = (TYPEOF(h.lattitude))'',0,100));
    maxlength_lattitude := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lattitude)));
    avelength_lattitude := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lattitude)),h.lattitude<>(typeof(h.lattitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_milepost1_pcnt := AVE(GROUP,IF(h.milepost1 = (TYPEOF(h.milepost1))'',0,100));
    maxlength_milepost1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost1)));
    avelength_milepost1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost1)),h.milepost1<>(typeof(h.milepost1))'');
    populated_milepost2_pcnt := AVE(GROUP,IF(h.milepost2 = (TYPEOF(h.milepost2))'',0,100));
    maxlength_milepost2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost2)));
    avelength_milepost2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost2)),h.milepost2<>(typeof(h.milepost2))'');
    populated_address_number_pcnt := AVE(GROUP,IF(h.address_number = (TYPEOF(h.address_number))'',0,100));
    maxlength_address_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_number)));
    avelength_address_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_number)),h.address_number<>(typeof(h.address_number))'');
    populated_loss_street_pcnt := AVE(GROUP,IF(h.loss_street = (TYPEOF(h.loss_street))'',0,100));
    maxlength_loss_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street)));
    avelength_loss_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street)),h.loss_street<>(typeof(h.loss_street))'');
    populated_loss_street_route_number_pcnt := AVE(GROUP,IF(h.loss_street_route_number = (TYPEOF(h.loss_street_route_number))'',0,100));
    maxlength_loss_street_route_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_route_number)));
    avelength_loss_street_route_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_route_number)),h.loss_street_route_number<>(typeof(h.loss_street_route_number))'');
    populated_loss_street_type_pcnt := AVE(GROUP,IF(h.loss_street_type = (TYPEOF(h.loss_street_type))'',0,100));
    maxlength_loss_street_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_type)));
    avelength_loss_street_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_type)),h.loss_street_type<>(typeof(h.loss_street_type))'');
    populated_loss_street_speed_limit_pcnt := AVE(GROUP,IF(h.loss_street_speed_limit = (TYPEOF(h.loss_street_speed_limit))'',0,100));
    maxlength_loss_street_speed_limit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_speed_limit)));
    avelength_loss_street_speed_limit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_street_speed_limit)),h.loss_street_speed_limit<>(typeof(h.loss_street_speed_limit))'');
    populated_incident_location_indicator_pcnt := AVE(GROUP,IF(h.incident_location_indicator = (TYPEOF(h.incident_location_indicator))'',0,100));
    maxlength_incident_location_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_location_indicator)));
    avelength_incident_location_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_location_indicator)),h.incident_location_indicator<>(typeof(h.incident_location_indicator))'');
    populated_loss_cross_street_pcnt := AVE(GROUP,IF(h.loss_cross_street = (TYPEOF(h.loss_cross_street))'',0,100));
    maxlength_loss_cross_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street)));
    avelength_loss_cross_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street)),h.loss_cross_street<>(typeof(h.loss_cross_street))'');
    populated_loss_cross_street_route_number_pcnt := AVE(GROUP,IF(h.loss_cross_street_route_number = (TYPEOF(h.loss_cross_street_route_number))'',0,100));
    maxlength_loss_cross_street_route_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_route_number)));
    avelength_loss_cross_street_route_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_route_number)),h.loss_cross_street_route_number<>(typeof(h.loss_cross_street_route_number))'');
    populated_loss_cross_street_intersecting_route_segment_pcnt := AVE(GROUP,IF(h.loss_cross_street_intersecting_route_segment = (TYPEOF(h.loss_cross_street_intersecting_route_segment))'',0,100));
    maxlength_loss_cross_street_intersecting_route_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_intersecting_route_segment)));
    avelength_loss_cross_street_intersecting_route_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_intersecting_route_segment)),h.loss_cross_street_intersecting_route_segment<>(typeof(h.loss_cross_street_intersecting_route_segment))'');
    populated_loss_cross_street_type_pcnt := AVE(GROUP,IF(h.loss_cross_street_type = (TYPEOF(h.loss_cross_street_type))'',0,100));
    maxlength_loss_cross_street_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_type)));
    avelength_loss_cross_street_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_type)),h.loss_cross_street_type<>(typeof(h.loss_cross_street_type))'');
    populated_loss_cross_street_speed_limit_pcnt := AVE(GROUP,IF(h.loss_cross_street_speed_limit = (TYPEOF(h.loss_cross_street_speed_limit))'',0,100));
    maxlength_loss_cross_street_speed_limit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_speed_limit)));
    avelength_loss_cross_street_speed_limit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_speed_limit)),h.loss_cross_street_speed_limit<>(typeof(h.loss_cross_street_speed_limit))'');
    populated_loss_cross_street_number_of_lanes_pcnt := AVE(GROUP,IF(h.loss_cross_street_number_of_lanes = (TYPEOF(h.loss_cross_street_number_of_lanes))'',0,100));
    maxlength_loss_cross_street_number_of_lanes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_number_of_lanes)));
    avelength_loss_cross_street_number_of_lanes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_number_of_lanes)),h.loss_cross_street_number_of_lanes<>(typeof(h.loss_cross_street_number_of_lanes))'');
    populated_loss_cross_street_orientation_pcnt := AVE(GROUP,IF(h.loss_cross_street_orientation = (TYPEOF(h.loss_cross_street_orientation))'',0,100));
    maxlength_loss_cross_street_orientation := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_orientation)));
    avelength_loss_cross_street_orientation := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_orientation)),h.loss_cross_street_orientation<>(typeof(h.loss_cross_street_orientation))'');
    populated_loss_cross_street_route_sign_pcnt := AVE(GROUP,IF(h.loss_cross_street_route_sign = (TYPEOF(h.loss_cross_street_route_sign))'',0,100));
    maxlength_loss_cross_street_route_sign := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_route_sign)));
    avelength_loss_cross_street_route_sign := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.loss_cross_street_route_sign)),h.loss_cross_street_route_sign<>(typeof(h.loss_cross_street_route_sign))'');
    populated_at_node_number_pcnt := AVE(GROUP,IF(h.at_node_number = (TYPEOF(h.at_node_number))'',0,100));
    maxlength_at_node_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.at_node_number)));
    avelength_at_node_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.at_node_number)),h.at_node_number<>(typeof(h.at_node_number))'');
    populated_distance_from_node_feet_pcnt := AVE(GROUP,IF(h.distance_from_node_feet = (TYPEOF(h.distance_from_node_feet))'',0,100));
    maxlength_distance_from_node_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_from_node_feet)));
    avelength_distance_from_node_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_from_node_feet)),h.distance_from_node_feet<>(typeof(h.distance_from_node_feet))'');
    populated_distance_from_node_miles_pcnt := AVE(GROUP,IF(h.distance_from_node_miles = (TYPEOF(h.distance_from_node_miles))'',0,100));
    maxlength_distance_from_node_miles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_from_node_miles)));
    avelength_distance_from_node_miles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_from_node_miles)),h.distance_from_node_miles<>(typeof(h.distance_from_node_miles))'');
    populated_next_node_number_pcnt := AVE(GROUP,IF(h.next_node_number = (TYPEOF(h.next_node_number))'',0,100));
    maxlength_next_node_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_node_number)));
    avelength_next_node_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_node_number)),h.next_node_number<>(typeof(h.next_node_number))'');
    populated_next_roadway_node_number_pcnt := AVE(GROUP,IF(h.next_roadway_node_number = (TYPEOF(h.next_roadway_node_number))'',0,100));
    maxlength_next_roadway_node_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_roadway_node_number)));
    avelength_next_roadway_node_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_roadway_node_number)),h.next_roadway_node_number<>(typeof(h.next_roadway_node_number))'');
    populated_direction_of_travel_pcnt := AVE(GROUP,IF(h.direction_of_travel = (TYPEOF(h.direction_of_travel))'',0,100));
    maxlength_direction_of_travel := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_travel)));
    avelength_direction_of_travel := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_travel)),h.direction_of_travel<>(typeof(h.direction_of_travel))'');
    populated_next_street_pcnt := AVE(GROUP,IF(h.next_street = (TYPEOF(h.next_street))'',0,100));
    maxlength_next_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street)));
    avelength_next_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street)),h.next_street<>(typeof(h.next_street))'');
    populated_next_street_type_pcnt := AVE(GROUP,IF(h.next_street_type = (TYPEOF(h.next_street_type))'',0,100));
    maxlength_next_street_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_type)));
    avelength_next_street_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_type)),h.next_street_type<>(typeof(h.next_street_type))'');
    populated_next_street_suffix_pcnt := AVE(GROUP,IF(h.next_street_suffix = (TYPEOF(h.next_street_suffix))'',0,100));
    maxlength_next_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_suffix)));
    avelength_next_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_suffix)),h.next_street_suffix<>(typeof(h.next_street_suffix))'');
    populated_before_or_after_next_street_pcnt := AVE(GROUP,IF(h.before_or_after_next_street = (TYPEOF(h.before_or_after_next_street))'',0,100));
    maxlength_before_or_after_next_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.before_or_after_next_street)));
    avelength_before_or_after_next_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.before_or_after_next_street)),h.before_or_after_next_street<>(typeof(h.before_or_after_next_street))'');
    populated_next_street_distance_feet_pcnt := AVE(GROUP,IF(h.next_street_distance_feet = (TYPEOF(h.next_street_distance_feet))'',0,100));
    maxlength_next_street_distance_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_distance_feet)));
    avelength_next_street_distance_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_distance_feet)),h.next_street_distance_feet<>(typeof(h.next_street_distance_feet))'');
    populated_next_street_distance_miles_pcnt := AVE(GROUP,IF(h.next_street_distance_miles = (TYPEOF(h.next_street_distance_miles))'',0,100));
    maxlength_next_street_distance_miles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_distance_miles)));
    avelength_next_street_distance_miles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_distance_miles)),h.next_street_distance_miles<>(typeof(h.next_street_distance_miles))'');
    populated_next_street_direction_pcnt := AVE(GROUP,IF(h.next_street_direction = (TYPEOF(h.next_street_direction))'',0,100));
    maxlength_next_street_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_direction)));
    avelength_next_street_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_direction)),h.next_street_direction<>(typeof(h.next_street_direction))'');
    populated_next_street_route_segment_pcnt := AVE(GROUP,IF(h.next_street_route_segment = (TYPEOF(h.next_street_route_segment))'',0,100));
    maxlength_next_street_route_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_route_segment)));
    avelength_next_street_route_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_route_segment)),h.next_street_route_segment<>(typeof(h.next_street_route_segment))'');
    populated_continuing_toward_street_pcnt := AVE(GROUP,IF(h.continuing_toward_street = (TYPEOF(h.continuing_toward_street))'',0,100));
    maxlength_continuing_toward_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_toward_street)));
    avelength_continuing_toward_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_toward_street)),h.continuing_toward_street<>(typeof(h.continuing_toward_street))'');
    populated_continuing_street_suffix_pcnt := AVE(GROUP,IF(h.continuing_street_suffix = (TYPEOF(h.continuing_street_suffix))'',0,100));
    maxlength_continuing_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_street_suffix)));
    avelength_continuing_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_street_suffix)),h.continuing_street_suffix<>(typeof(h.continuing_street_suffix))'');
    populated_continuing_street_direction_pcnt := AVE(GROUP,IF(h.continuing_street_direction = (TYPEOF(h.continuing_street_direction))'',0,100));
    maxlength_continuing_street_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_street_direction)));
    avelength_continuing_street_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuing_street_direction)),h.continuing_street_direction<>(typeof(h.continuing_street_direction))'');
    populated_continuting_street_route_segment_pcnt := AVE(GROUP,IF(h.continuting_street_route_segment = (TYPEOF(h.continuting_street_route_segment))'',0,100));
    maxlength_continuting_street_route_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuting_street_route_segment)));
    avelength_continuting_street_route_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.continuting_street_route_segment)),h.continuting_street_route_segment<>(typeof(h.continuting_street_route_segment))'');
    populated_city_type_pcnt := AVE(GROUP,IF(h.city_type = (TYPEOF(h.city_type))'',0,100));
    maxlength_city_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_type)));
    avelength_city_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city_type)),h.city_type<>(typeof(h.city_type))'');
    populated_outside_city_indicator_pcnt := AVE(GROUP,IF(h.outside_city_indicator = (TYPEOF(h.outside_city_indicator))'',0,100));
    maxlength_outside_city_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_indicator)));
    avelength_outside_city_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_indicator)),h.outside_city_indicator<>(typeof(h.outside_city_indicator))'');
    populated_outside_city_direction_pcnt := AVE(GROUP,IF(h.outside_city_direction = (TYPEOF(h.outside_city_direction))'',0,100));
    maxlength_outside_city_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_direction)));
    avelength_outside_city_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_direction)),h.outside_city_direction<>(typeof(h.outside_city_direction))'');
    populated_outside_city_distance_feet_pcnt := AVE(GROUP,IF(h.outside_city_distance_feet = (TYPEOF(h.outside_city_distance_feet))'',0,100));
    maxlength_outside_city_distance_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_distance_feet)));
    avelength_outside_city_distance_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_distance_feet)),h.outside_city_distance_feet<>(typeof(h.outside_city_distance_feet))'');
    populated_outside_city_distance_miles_pcnt := AVE(GROUP,IF(h.outside_city_distance_miles = (TYPEOF(h.outside_city_distance_miles))'',0,100));
    maxlength_outside_city_distance_miles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_distance_miles)));
    avelength_outside_city_distance_miles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.outside_city_distance_miles)),h.outside_city_distance_miles<>(typeof(h.outside_city_distance_miles))'');
    populated_crash_type_pcnt := AVE(GROUP,IF(h.crash_type = (TYPEOF(h.crash_type))'',0,100));
    maxlength_crash_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_type)));
    avelength_crash_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_type)),h.crash_type<>(typeof(h.crash_type))'');
    populated_motor_vehicle_involved_with_pcnt := AVE(GROUP,IF(h.motor_vehicle_involved_with = (TYPEOF(h.motor_vehicle_involved_with))'',0,100));
    maxlength_motor_vehicle_involved_with := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with)));
    avelength_motor_vehicle_involved_with := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with)),h.motor_vehicle_involved_with<>(typeof(h.motor_vehicle_involved_with))'');
    populated_report_investigation_type_pcnt := AVE(GROUP,IF(h.report_investigation_type = (TYPEOF(h.report_investigation_type))'',0,100));
    maxlength_report_investigation_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_investigation_type)));
    avelength_report_investigation_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_investigation_type)),h.report_investigation_type<>(typeof(h.report_investigation_type))'');
    populated_incident_hit_and_run_pcnt := AVE(GROUP,IF(h.incident_hit_and_run = (TYPEOF(h.incident_hit_and_run))'',0,100));
    maxlength_incident_hit_and_run := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_hit_and_run)));
    avelength_incident_hit_and_run := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_hit_and_run)),h.incident_hit_and_run<>(typeof(h.incident_hit_and_run))'');
    populated_tow_away_pcnt := AVE(GROUP,IF(h.tow_away = (TYPEOF(h.tow_away))'',0,100));
    maxlength_tow_away := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.tow_away)));
    avelength_tow_away := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.tow_away)),h.tow_away<>(typeof(h.tow_away))'');
    populated_date_notified_pcnt := AVE(GROUP,IF(h.date_notified = (TYPEOF(h.date_notified))'',0,100));
    maxlength_date_notified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_notified)));
    avelength_date_notified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_notified)),h.date_notified<>(typeof(h.date_notified))'');
    populated_time_notified_pcnt := AVE(GROUP,IF(h.time_notified = (TYPEOF(h.time_notified))'',0,100));
    maxlength_time_notified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_notified)));
    avelength_time_notified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_notified)),h.time_notified<>(typeof(h.time_notified))'');
    populated_notification_method_pcnt := AVE(GROUP,IF(h.notification_method = (TYPEOF(h.notification_method))'',0,100));
    maxlength_notification_method := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.notification_method)));
    avelength_notification_method := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.notification_method)),h.notification_method<>(typeof(h.notification_method))'');
    populated_officer_arrival_time_pcnt := AVE(GROUP,IF(h.officer_arrival_time = (TYPEOF(h.officer_arrival_time))'',0,100));
    maxlength_officer_arrival_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_arrival_time)));
    avelength_officer_arrival_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_arrival_time)),h.officer_arrival_time<>(typeof(h.officer_arrival_time))'');
    populated_officer_report_date_pcnt := AVE(GROUP,IF(h.officer_report_date = (TYPEOF(h.officer_report_date))'',0,100));
    maxlength_officer_report_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_report_date)));
    avelength_officer_report_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_report_date)),h.officer_report_date<>(typeof(h.officer_report_date))'');
    populated_officer_report_time_pcnt := AVE(GROUP,IF(h.officer_report_time = (TYPEOF(h.officer_report_time))'',0,100));
    maxlength_officer_report_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_report_time)));
    avelength_officer_report_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_report_time)),h.officer_report_time<>(typeof(h.officer_report_time))'');
    populated_officer_id_pcnt := AVE(GROUP,IF(h.officer_id = (TYPEOF(h.officer_id))'',0,100));
    maxlength_officer_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_id)));
    avelength_officer_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_id)),h.officer_id<>(typeof(h.officer_id))'');
    populated_officer_department_pcnt := AVE(GROUP,IF(h.officer_department = (TYPEOF(h.officer_department))'',0,100));
    maxlength_officer_department := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_department)));
    avelength_officer_department := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_department)),h.officer_department<>(typeof(h.officer_department))'');
    populated_officer_rank_pcnt := AVE(GROUP,IF(h.officer_rank = (TYPEOF(h.officer_rank))'',0,100));
    maxlength_officer_rank := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_rank)));
    avelength_officer_rank := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_rank)),h.officer_rank<>(typeof(h.officer_rank))'');
    populated_officer_command_pcnt := AVE(GROUP,IF(h.officer_command = (TYPEOF(h.officer_command))'',0,100));
    maxlength_officer_command := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_command)));
    avelength_officer_command := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_command)),h.officer_command<>(typeof(h.officer_command))'');
    populated_officer_tax_id_number_pcnt := AVE(GROUP,IF(h.officer_tax_id_number = (TYPEOF(h.officer_tax_id_number))'',0,100));
    maxlength_officer_tax_id_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_tax_id_number)));
    avelength_officer_tax_id_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.officer_tax_id_number)),h.officer_tax_id_number<>(typeof(h.officer_tax_id_number))'');
    populated_completed_report_date_pcnt := AVE(GROUP,IF(h.completed_report_date = (TYPEOF(h.completed_report_date))'',0,100));
    maxlength_completed_report_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.completed_report_date)));
    avelength_completed_report_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.completed_report_date)),h.completed_report_date<>(typeof(h.completed_report_date))'');
    populated_supervisor_check_date_pcnt := AVE(GROUP,IF(h.supervisor_check_date = (TYPEOF(h.supervisor_check_date))'',0,100));
    maxlength_supervisor_check_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_check_date)));
    avelength_supervisor_check_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_check_date)),h.supervisor_check_date<>(typeof(h.supervisor_check_date))'');
    populated_supervisor_check_time_pcnt := AVE(GROUP,IF(h.supervisor_check_time = (TYPEOF(h.supervisor_check_time))'',0,100));
    maxlength_supervisor_check_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_check_time)));
    avelength_supervisor_check_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_check_time)),h.supervisor_check_time<>(typeof(h.supervisor_check_time))'');
    populated_supervisor_id_pcnt := AVE(GROUP,IF(h.supervisor_id = (TYPEOF(h.supervisor_id))'',0,100));
    maxlength_supervisor_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_id)));
    avelength_supervisor_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_id)),h.supervisor_id<>(typeof(h.supervisor_id))'');
    populated_supervisor_rank_pcnt := AVE(GROUP,IF(h.supervisor_rank = (TYPEOF(h.supervisor_rank))'',0,100));
    maxlength_supervisor_rank := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_rank)));
    avelength_supervisor_rank := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supervisor_rank)),h.supervisor_rank<>(typeof(h.supervisor_rank))'');
    populated_reviewers_name_pcnt := AVE(GROUP,IF(h.reviewers_name = (TYPEOF(h.reviewers_name))'',0,100));
    maxlength_reviewers_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.reviewers_name)));
    avelength_reviewers_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.reviewers_name)),h.reviewers_name<>(typeof(h.reviewers_name))'');
    populated_road_surface_pcnt := AVE(GROUP,IF(h.road_surface = (TYPEOF(h.road_surface))'',0,100));
    maxlength_road_surface := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_surface)));
    avelength_road_surface := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_surface)),h.road_surface<>(typeof(h.road_surface))'');
    populated_roadway_alignment_pcnt := AVE(GROUP,IF(h.roadway_alignment = (TYPEOF(h.roadway_alignment))'',0,100));
    maxlength_roadway_alignment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_alignment)));
    avelength_roadway_alignment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_alignment)),h.roadway_alignment<>(typeof(h.roadway_alignment))'');
    populated_traffic_way_description_pcnt := AVE(GROUP,IF(h.traffic_way_description = (TYPEOF(h.traffic_way_description))'',0,100));
    maxlength_traffic_way_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_way_description)));
    avelength_traffic_way_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_way_description)),h.traffic_way_description<>(typeof(h.traffic_way_description))'');
    populated_traffic_flow_pcnt := AVE(GROUP,IF(h.traffic_flow = (TYPEOF(h.traffic_flow))'',0,100));
    maxlength_traffic_flow := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_flow)));
    avelength_traffic_flow := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_flow)),h.traffic_flow<>(typeof(h.traffic_flow))'');
    populated_property_damage_involved_pcnt := AVE(GROUP,IF(h.property_damage_involved = (TYPEOF(h.property_damage_involved))'',0,100));
    maxlength_property_damage_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_involved)));
    avelength_property_damage_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_involved)),h.property_damage_involved<>(typeof(h.property_damage_involved))'');
    populated_property_damage_description1_pcnt := AVE(GROUP,IF(h.property_damage_description1 = (TYPEOF(h.property_damage_description1))'',0,100));
    maxlength_property_damage_description1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_description1)));
    avelength_property_damage_description1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_description1)),h.property_damage_description1<>(typeof(h.property_damage_description1))'');
    populated_property_damage_description2_pcnt := AVE(GROUP,IF(h.property_damage_description2 = (TYPEOF(h.property_damage_description2))'',0,100));
    maxlength_property_damage_description2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_description2)));
    avelength_property_damage_description2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_description2)),h.property_damage_description2<>(typeof(h.property_damage_description2))'');
    populated_property_damage_estimate1_pcnt := AVE(GROUP,IF(h.property_damage_estimate1 = (TYPEOF(h.property_damage_estimate1))'',0,100));
    maxlength_property_damage_estimate1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_estimate1)));
    avelength_property_damage_estimate1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_estimate1)),h.property_damage_estimate1<>(typeof(h.property_damage_estimate1))'');
    populated_property_damage_estimate2_pcnt := AVE(GROUP,IF(h.property_damage_estimate2 = (TYPEOF(h.property_damage_estimate2))'',0,100));
    maxlength_property_damage_estimate2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_estimate2)));
    avelength_property_damage_estimate2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_estimate2)),h.property_damage_estimate2<>(typeof(h.property_damage_estimate2))'');
    populated_incident_damage_over_limit_pcnt := AVE(GROUP,IF(h.incident_damage_over_limit = (TYPEOF(h.incident_damage_over_limit))'',0,100));
    maxlength_incident_damage_over_limit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_damage_over_limit)));
    avelength_incident_damage_over_limit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_damage_over_limit)),h.incident_damage_over_limit<>(typeof(h.incident_damage_over_limit))'');
    populated_property_owner_notified_pcnt := AVE(GROUP,IF(h.property_owner_notified = (TYPEOF(h.property_owner_notified))'',0,100));
    maxlength_property_owner_notified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_owner_notified)));
    avelength_property_owner_notified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_owner_notified)),h.property_owner_notified<>(typeof(h.property_owner_notified))'');
    populated_government_property_pcnt := AVE(GROUP,IF(h.government_property = (TYPEOF(h.government_property))'',0,100));
    maxlength_government_property := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.government_property)));
    avelength_government_property := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.government_property)),h.government_property<>(typeof(h.government_property))'');
    populated_accident_condition_pcnt := AVE(GROUP,IF(h.accident_condition = (TYPEOF(h.accident_condition))'',0,100));
    maxlength_accident_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_condition)));
    avelength_accident_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_condition)),h.accident_condition<>(typeof(h.accident_condition))'');
    populated_unusual_road_condition1_pcnt := AVE(GROUP,IF(h.unusual_road_condition1 = (TYPEOF(h.unusual_road_condition1))'',0,100));
    maxlength_unusual_road_condition1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition1)));
    avelength_unusual_road_condition1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition1)),h.unusual_road_condition1<>(typeof(h.unusual_road_condition1))'');
    populated_unusual_road_condition2_pcnt := AVE(GROUP,IF(h.unusual_road_condition2 = (TYPEOF(h.unusual_road_condition2))'',0,100));
    maxlength_unusual_road_condition2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition2)));
    avelength_unusual_road_condition2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition2)),h.unusual_road_condition2<>(typeof(h.unusual_road_condition2))'');
    populated_number_of_lanes_pcnt := AVE(GROUP,IF(h.number_of_lanes = (TYPEOF(h.number_of_lanes))'',0,100));
    maxlength_number_of_lanes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_lanes)));
    avelength_number_of_lanes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_lanes)),h.number_of_lanes<>(typeof(h.number_of_lanes))'');
    populated_divided_highway_pcnt := AVE(GROUP,IF(h.divided_highway = (TYPEOF(h.divided_highway))'',0,100));
    maxlength_divided_highway := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.divided_highway)));
    avelength_divided_highway := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.divided_highway)),h.divided_highway<>(typeof(h.divided_highway))'');
    populated_most_harmful_event_pcnt := AVE(GROUP,IF(h.most_harmful_event = (TYPEOF(h.most_harmful_event))'',0,100));
    maxlength_most_harmful_event := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.most_harmful_event)));
    avelength_most_harmful_event := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.most_harmful_event)),h.most_harmful_event<>(typeof(h.most_harmful_event))'');
    populated_second_harmful_event_pcnt := AVE(GROUP,IF(h.second_harmful_event = (TYPEOF(h.second_harmful_event))'',0,100));
    maxlength_second_harmful_event := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.second_harmful_event)));
    avelength_second_harmful_event := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.second_harmful_event)),h.second_harmful_event<>(typeof(h.second_harmful_event))'');
    populated_ems_notified_date_pcnt := AVE(GROUP,IF(h.ems_notified_date = (TYPEOF(h.ems_notified_date))'',0,100));
    maxlength_ems_notified_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_notified_date)));
    avelength_ems_notified_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_notified_date)),h.ems_notified_date<>(typeof(h.ems_notified_date))'');
    populated_ems_arrival_date_pcnt := AVE(GROUP,IF(h.ems_arrival_date = (TYPEOF(h.ems_arrival_date))'',0,100));
    maxlength_ems_arrival_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_arrival_date)));
    avelength_ems_arrival_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_arrival_date)),h.ems_arrival_date<>(typeof(h.ems_arrival_date))'');
    populated_hospital_arrival_date_pcnt := AVE(GROUP,IF(h.hospital_arrival_date = (TYPEOF(h.hospital_arrival_date))'',0,100));
    maxlength_hospital_arrival_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_arrival_date)));
    avelength_hospital_arrival_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_arrival_date)),h.hospital_arrival_date<>(typeof(h.hospital_arrival_date))'');
    populated_injured_taken_by_pcnt := AVE(GROUP,IF(h.injured_taken_by = (TYPEOF(h.injured_taken_by))'',0,100));
    maxlength_injured_taken_by := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injured_taken_by)));
    avelength_injured_taken_by := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injured_taken_by)),h.injured_taken_by<>(typeof(h.injured_taken_by))'');
    populated_injured_taken_to_pcnt := AVE(GROUP,IF(h.injured_taken_to = (TYPEOF(h.injured_taken_to))'',0,100));
    maxlength_injured_taken_to := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injured_taken_to)));
    avelength_injured_taken_to := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injured_taken_to)),h.injured_taken_to<>(typeof(h.injured_taken_to))'');
    populated_incident_transported_for_medical_care_pcnt := AVE(GROUP,IF(h.incident_transported_for_medical_care = (TYPEOF(h.incident_transported_for_medical_care))'',0,100));
    maxlength_incident_transported_for_medical_care := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_transported_for_medical_care)));
    avelength_incident_transported_for_medical_care := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_transported_for_medical_care)),h.incident_transported_for_medical_care<>(typeof(h.incident_transported_for_medical_care))'');
    populated_photographs_taken_pcnt := AVE(GROUP,IF(h.photographs_taken = (TYPEOF(h.photographs_taken))'',0,100));
    maxlength_photographs_taken := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographs_taken)));
    avelength_photographs_taken := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographs_taken)),h.photographs_taken<>(typeof(h.photographs_taken))'');
    populated_photographed_by_pcnt := AVE(GROUP,IF(h.photographed_by = (TYPEOF(h.photographed_by))'',0,100));
    maxlength_photographed_by := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographed_by)));
    avelength_photographed_by := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographed_by)),h.photographed_by<>(typeof(h.photographed_by))'');
    populated_photographer_id_pcnt := AVE(GROUP,IF(h.photographer_id = (TYPEOF(h.photographer_id))'',0,100));
    maxlength_photographer_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographer_id)));
    avelength_photographer_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.photographer_id)),h.photographer_id<>(typeof(h.photographer_id))'');
    populated_photography_agency_name_pcnt := AVE(GROUP,IF(h.photography_agency_name = (TYPEOF(h.photography_agency_name))'',0,100));
    maxlength_photography_agency_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.photography_agency_name)));
    avelength_photography_agency_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.photography_agency_name)),h.photography_agency_name<>(typeof(h.photography_agency_name))'');
    populated_agency_name_pcnt := AVE(GROUP,IF(h.agency_name = (TYPEOF(h.agency_name))'',0,100));
    maxlength_agency_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_name)));
    avelength_agency_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_name)),h.agency_name<>(typeof(h.agency_name))'');
    populated_judicial_district_pcnt := AVE(GROUP,IF(h.judicial_district = (TYPEOF(h.judicial_district))'',0,100));
    maxlength_judicial_district := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.judicial_district)));
    avelength_judicial_district := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.judicial_district)),h.judicial_district<>(typeof(h.judicial_district))'');
    populated_precinct_pcnt := AVE(GROUP,IF(h.precinct = (TYPEOF(h.precinct))'',0,100));
    maxlength_precinct := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.precinct)));
    avelength_precinct := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.precinct)),h.precinct<>(typeof(h.precinct))'');
    populated_beat_pcnt := AVE(GROUP,IF(h.beat = (TYPEOF(h.beat))'',0,100));
    maxlength_beat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.beat)));
    avelength_beat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.beat)),h.beat<>(typeof(h.beat))'');
    populated_location_type_pcnt := AVE(GROUP,IF(h.location_type = (TYPEOF(h.location_type))'',0,100));
    maxlength_location_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.location_type)));
    avelength_location_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.location_type)),h.location_type<>(typeof(h.location_type))'');
    populated_shoulder_type_pcnt := AVE(GROUP,IF(h.shoulder_type = (TYPEOF(h.shoulder_type))'',0,100));
    maxlength_shoulder_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.shoulder_type)));
    avelength_shoulder_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.shoulder_type)),h.shoulder_type<>(typeof(h.shoulder_type))'');
    populated_investigation_complete_pcnt := AVE(GROUP,IF(h.investigation_complete = (TYPEOF(h.investigation_complete))'',0,100));
    maxlength_investigation_complete := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_complete)));
    avelength_investigation_complete := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_complete)),h.investigation_complete<>(typeof(h.investigation_complete))'');
    populated_investigation_not_complete_why_pcnt := AVE(GROUP,IF(h.investigation_not_complete_why = (TYPEOF(h.investigation_not_complete_why))'',0,100));
    maxlength_investigation_not_complete_why := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_not_complete_why)));
    avelength_investigation_not_complete_why := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_not_complete_why)),h.investigation_not_complete_why<>(typeof(h.investigation_not_complete_why))'');
    populated_investigating_officer_name_pcnt := AVE(GROUP,IF(h.investigating_officer_name = (TYPEOF(h.investigating_officer_name))'',0,100));
    maxlength_investigating_officer_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigating_officer_name)));
    avelength_investigating_officer_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigating_officer_name)),h.investigating_officer_name<>(typeof(h.investigating_officer_name))'');
    populated_investigation_notification_issued_pcnt := AVE(GROUP,IF(h.investigation_notification_issued = (TYPEOF(h.investigation_notification_issued))'',0,100));
    maxlength_investigation_notification_issued := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_notification_issued)));
    avelength_investigation_notification_issued := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.investigation_notification_issued)),h.investigation_notification_issued<>(typeof(h.investigation_notification_issued))'');
    populated_agency_type_pcnt := AVE(GROUP,IF(h.agency_type = (TYPEOF(h.agency_type))'',0,100));
    maxlength_agency_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_type)));
    avelength_agency_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_type)),h.agency_type<>(typeof(h.agency_type))'');
    populated_no_injury_tow_involved_pcnt := AVE(GROUP,IF(h.no_injury_tow_involved = (TYPEOF(h.no_injury_tow_involved))'',0,100));
    maxlength_no_injury_tow_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.no_injury_tow_involved)));
    avelength_no_injury_tow_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.no_injury_tow_involved)),h.no_injury_tow_involved<>(typeof(h.no_injury_tow_involved))'');
    populated_injury_tow_involved_pcnt := AVE(GROUP,IF(h.injury_tow_involved = (TYPEOF(h.injury_tow_involved))'',0,100));
    maxlength_injury_tow_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_tow_involved)));
    avelength_injury_tow_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_tow_involved)),h.injury_tow_involved<>(typeof(h.injury_tow_involved))'');
    populated_lars_code1_pcnt := AVE(GROUP,IF(h.lars_code1 = (TYPEOF(h.lars_code1))'',0,100));
    maxlength_lars_code1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lars_code1)));
    avelength_lars_code1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lars_code1)),h.lars_code1<>(typeof(h.lars_code1))'');
    populated_lars_code2_pcnt := AVE(GROUP,IF(h.lars_code2 = (TYPEOF(h.lars_code2))'',0,100));
    maxlength_lars_code2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lars_code2)));
    avelength_lars_code2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lars_code2)),h.lars_code2<>(typeof(h.lars_code2))'');
    populated_private_property_incident_pcnt := AVE(GROUP,IF(h.private_property_incident = (TYPEOF(h.private_property_incident))'',0,100));
    maxlength_private_property_incident := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.private_property_incident)));
    avelength_private_property_incident := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.private_property_incident)),h.private_property_incident<>(typeof(h.private_property_incident))'');
    populated_accident_involvement_pcnt := AVE(GROUP,IF(h.accident_involvement = (TYPEOF(h.accident_involvement))'',0,100));
    maxlength_accident_involvement := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_involvement)));
    avelength_accident_involvement := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_involvement)),h.accident_involvement<>(typeof(h.accident_involvement))'');
    populated_local_use_pcnt := AVE(GROUP,IF(h.local_use = (TYPEOF(h.local_use))'',0,100));
    maxlength_local_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_use)));
    avelength_local_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_use)),h.local_use<>(typeof(h.local_use))'');
    populated_street_prefix_pcnt := AVE(GROUP,IF(h.street_prefix = (TYPEOF(h.street_prefix))'',0,100));
    maxlength_street_prefix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_prefix)));
    avelength_street_prefix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_prefix)),h.street_prefix<>(typeof(h.street_prefix))'');
    populated_street_suffix_pcnt := AVE(GROUP,IF(h.street_suffix = (TYPEOF(h.street_suffix))'',0,100));
    maxlength_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_suffix)));
    avelength_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_suffix)),h.street_suffix<>(typeof(h.street_suffix))'');
    populated_toll_road_pcnt := AVE(GROUP,IF(h.toll_road = (TYPEOF(h.toll_road))'',0,100));
    maxlength_toll_road := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.toll_road)));
    avelength_toll_road := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.toll_road)),h.toll_road<>(typeof(h.toll_road))'');
    populated_street_description_pcnt := AVE(GROUP,IF(h.street_description = (TYPEOF(h.street_description))'',0,100));
    maxlength_street_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_description)));
    avelength_street_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_description)),h.street_description<>(typeof(h.street_description))'');
    populated_cross_street_address_number_pcnt := AVE(GROUP,IF(h.cross_street_address_number = (TYPEOF(h.cross_street_address_number))'',0,100));
    maxlength_cross_street_address_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_address_number)));
    avelength_cross_street_address_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_address_number)),h.cross_street_address_number<>(typeof(h.cross_street_address_number))'');
    populated_cross_street_prefix_pcnt := AVE(GROUP,IF(h.cross_street_prefix = (TYPEOF(h.cross_street_prefix))'',0,100));
    maxlength_cross_street_prefix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_prefix)));
    avelength_cross_street_prefix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_prefix)),h.cross_street_prefix<>(typeof(h.cross_street_prefix))'');
    populated_cross_street_suffix_pcnt := AVE(GROUP,IF(h.cross_street_suffix = (TYPEOF(h.cross_street_suffix))'',0,100));
    maxlength_cross_street_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_suffix)));
    avelength_cross_street_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cross_street_suffix)),h.cross_street_suffix<>(typeof(h.cross_street_suffix))'');
    populated_report_complete_pcnt := AVE(GROUP,IF(h.report_complete = (TYPEOF(h.report_complete))'',0,100));
    maxlength_report_complete := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_complete)));
    avelength_report_complete := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_complete)),h.report_complete<>(typeof(h.report_complete))'');
    populated_dispatch_notified_pcnt := AVE(GROUP,IF(h.dispatch_notified = (TYPEOF(h.dispatch_notified))'',0,100));
    maxlength_dispatch_notified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dispatch_notified)));
    avelength_dispatch_notified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dispatch_notified)),h.dispatch_notified<>(typeof(h.dispatch_notified))'');
    populated_counter_report_pcnt := AVE(GROUP,IF(h.counter_report = (TYPEOF(h.counter_report))'',0,100));
    maxlength_counter_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.counter_report)));
    avelength_counter_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.counter_report)),h.counter_report<>(typeof(h.counter_report))'');
    populated_road_type_pcnt := AVE(GROUP,IF(h.road_type = (TYPEOF(h.road_type))'',0,100));
    maxlength_road_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_type)));
    avelength_road_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.road_type)),h.road_type<>(typeof(h.road_type))'');
    populated_agency_code_pcnt := AVE(GROUP,IF(h.agency_code = (TYPEOF(h.agency_code))'',0,100));
    maxlength_agency_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_code)));
    avelength_agency_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.agency_code)),h.agency_code<>(typeof(h.agency_code))'');
    populated_public_property_employee_pcnt := AVE(GROUP,IF(h.public_property_employee = (TYPEOF(h.public_property_employee))'',0,100));
    maxlength_public_property_employee := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.public_property_employee)));
    avelength_public_property_employee := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.public_property_employee)),h.public_property_employee<>(typeof(h.public_property_employee))'');
    populated_bridge_related_pcnt := AVE(GROUP,IF(h.bridge_related = (TYPEOF(h.bridge_related))'',0,100));
    maxlength_bridge_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bridge_related)));
    avelength_bridge_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bridge_related)),h.bridge_related<>(typeof(h.bridge_related))'');
    populated_ramp_indicator_pcnt := AVE(GROUP,IF(h.ramp_indicator = (TYPEOF(h.ramp_indicator))'',0,100));
    maxlength_ramp_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ramp_indicator)));
    avelength_ramp_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ramp_indicator)),h.ramp_indicator<>(typeof(h.ramp_indicator))'');
    populated_to_or_from_location_pcnt := AVE(GROUP,IF(h.to_or_from_location = (TYPEOF(h.to_or_from_location))'',0,100));
    maxlength_to_or_from_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.to_or_from_location)));
    avelength_to_or_from_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.to_or_from_location)),h.to_or_from_location<>(typeof(h.to_or_from_location))'');
    populated_complaint_number_pcnt := AVE(GROUP,IF(h.complaint_number = (TYPEOF(h.complaint_number))'',0,100));
    maxlength_complaint_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.complaint_number)));
    avelength_complaint_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.complaint_number)),h.complaint_number<>(typeof(h.complaint_number))'');
    populated_school_zone_related_pcnt := AVE(GROUP,IF(h.school_zone_related = (TYPEOF(h.school_zone_related))'',0,100));
    maxlength_school_zone_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.school_zone_related)));
    avelength_school_zone_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.school_zone_related)),h.school_zone_related<>(typeof(h.school_zone_related))'');
    populated_notify_dot_maintenance_pcnt := AVE(GROUP,IF(h.notify_dot_maintenance = (TYPEOF(h.notify_dot_maintenance))'',0,100));
    maxlength_notify_dot_maintenance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.notify_dot_maintenance)));
    avelength_notify_dot_maintenance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.notify_dot_maintenance)),h.notify_dot_maintenance<>(typeof(h.notify_dot_maintenance))'');
    populated_special_location_pcnt := AVE(GROUP,IF(h.special_location = (TYPEOF(h.special_location))'',0,100));
    maxlength_special_location := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_location)));
    avelength_special_location := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_location)),h.special_location<>(typeof(h.special_location))'');
    populated_route_segment_pcnt := AVE(GROUP,IF(h.route_segment = (TYPEOF(h.route_segment))'',0,100));
    maxlength_route_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_segment)));
    avelength_route_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_segment)),h.route_segment<>(typeof(h.route_segment))'');
    populated_route_sign_pcnt := AVE(GROUP,IF(h.route_sign = (TYPEOF(h.route_sign))'',0,100));
    maxlength_route_sign := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_sign)));
    avelength_route_sign := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_sign)),h.route_sign<>(typeof(h.route_sign))'');
    populated_route_category_street_pcnt := AVE(GROUP,IF(h.route_category_street = (TYPEOF(h.route_category_street))'',0,100));
    maxlength_route_category_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_street)));
    avelength_route_category_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_street)),h.route_category_street<>(typeof(h.route_category_street))'');
    populated_route_category_cross_street_pcnt := AVE(GROUP,IF(h.route_category_cross_street = (TYPEOF(h.route_category_cross_street))'',0,100));
    maxlength_route_category_cross_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_cross_street)));
    avelength_route_category_cross_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_cross_street)),h.route_category_cross_street<>(typeof(h.route_category_cross_street))'');
    populated_route_category_next_street_pcnt := AVE(GROUP,IF(h.route_category_next_street = (TYPEOF(h.route_category_next_street))'',0,100));
    maxlength_route_category_next_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_next_street)));
    avelength_route_category_next_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.route_category_next_street)),h.route_category_next_street<>(typeof(h.route_category_next_street))'');
    populated_lane_closed_pcnt := AVE(GROUP,IF(h.lane_closed = (TYPEOF(h.lane_closed))'',0,100));
    maxlength_lane_closed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_closed)));
    avelength_lane_closed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_closed)),h.lane_closed<>(typeof(h.lane_closed))'');
    populated_lane_closure_direction_pcnt := AVE(GROUP,IF(h.lane_closure_direction = (TYPEOF(h.lane_closure_direction))'',0,100));
    maxlength_lane_closure_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_closure_direction)));
    avelength_lane_closure_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_closure_direction)),h.lane_closure_direction<>(typeof(h.lane_closure_direction))'');
    populated_lane_direction_pcnt := AVE(GROUP,IF(h.lane_direction = (TYPEOF(h.lane_direction))'',0,100));
    maxlength_lane_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_direction)));
    avelength_lane_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_direction)),h.lane_direction<>(typeof(h.lane_direction))'');
    populated_traffic_detoured_pcnt := AVE(GROUP,IF(h.traffic_detoured = (TYPEOF(h.traffic_detoured))'',0,100));
    maxlength_traffic_detoured := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_detoured)));
    avelength_traffic_detoured := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_detoured)),h.traffic_detoured<>(typeof(h.traffic_detoured))'');
    populated_time_closed_pcnt := AVE(GROUP,IF(h.time_closed = (TYPEOF(h.time_closed))'',0,100));
    maxlength_time_closed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_closed)));
    avelength_time_closed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_closed)),h.time_closed<>(typeof(h.time_closed))'');
    populated_pedestrian_signals_pcnt := AVE(GROUP,IF(h.pedestrian_signals = (TYPEOF(h.pedestrian_signals))'',0,100));
    maxlength_pedestrian_signals := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedestrian_signals)));
    avelength_pedestrian_signals := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedestrian_signals)),h.pedestrian_signals<>(typeof(h.pedestrian_signals))'');
    populated_work_zone_speed_limit_pcnt := AVE(GROUP,IF(h.work_zone_speed_limit = (TYPEOF(h.work_zone_speed_limit))'',0,100));
    maxlength_work_zone_speed_limit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_speed_limit)));
    avelength_work_zone_speed_limit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_speed_limit)),h.work_zone_speed_limit<>(typeof(h.work_zone_speed_limit))'');
    populated_work_zone_shoulder_median_pcnt := AVE(GROUP,IF(h.work_zone_shoulder_median = (TYPEOF(h.work_zone_shoulder_median))'',0,100));
    maxlength_work_zone_shoulder_median := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_shoulder_median)));
    avelength_work_zone_shoulder_median := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_shoulder_median)),h.work_zone_shoulder_median<>(typeof(h.work_zone_shoulder_median))'');
    populated_work_zone_intermittent_moving_pcnt := AVE(GROUP,IF(h.work_zone_intermittent_moving = (TYPEOF(h.work_zone_intermittent_moving))'',0,100));
    maxlength_work_zone_intermittent_moving := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_intermittent_moving)));
    avelength_work_zone_intermittent_moving := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_intermittent_moving)),h.work_zone_intermittent_moving<>(typeof(h.work_zone_intermittent_moving))'');
    populated_work_zone_flagger_control_pcnt := AVE(GROUP,IF(h.work_zone_flagger_control = (TYPEOF(h.work_zone_flagger_control))'',0,100));
    maxlength_work_zone_flagger_control := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_flagger_control)));
    avelength_work_zone_flagger_control := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.work_zone_flagger_control)),h.work_zone_flagger_control<>(typeof(h.work_zone_flagger_control))'');
    populated_special_work_zone_characteristics_pcnt := AVE(GROUP,IF(h.special_work_zone_characteristics = (TYPEOF(h.special_work_zone_characteristics))'',0,100));
    maxlength_special_work_zone_characteristics := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_work_zone_characteristics)));
    avelength_special_work_zone_characteristics := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_work_zone_characteristics)),h.special_work_zone_characteristics<>(typeof(h.special_work_zone_characteristics))'');
    populated_lane_number_pcnt := AVE(GROUP,IF(h.lane_number = (TYPEOF(h.lane_number))'',0,100));
    maxlength_lane_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_number)));
    avelength_lane_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lane_number)),h.lane_number<>(typeof(h.lane_number))'');
    populated_offset_distance_feet_pcnt := AVE(GROUP,IF(h.offset_distance_feet = (TYPEOF(h.offset_distance_feet))'',0,100));
    maxlength_offset_distance_feet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_distance_feet)));
    avelength_offset_distance_feet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_distance_feet)),h.offset_distance_feet<>(typeof(h.offset_distance_feet))'');
    populated_offset_distance_miles_pcnt := AVE(GROUP,IF(h.offset_distance_miles = (TYPEOF(h.offset_distance_miles))'',0,100));
    maxlength_offset_distance_miles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_distance_miles)));
    avelength_offset_distance_miles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_distance_miles)),h.offset_distance_miles<>(typeof(h.offset_distance_miles))'');
    populated_offset_direction_pcnt := AVE(GROUP,IF(h.offset_direction = (TYPEOF(h.offset_direction))'',0,100));
    maxlength_offset_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_direction)));
    avelength_offset_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.offset_direction)),h.offset_direction<>(typeof(h.offset_direction))'');
    populated_asru_code_pcnt := AVE(GROUP,IF(h.asru_code = (TYPEOF(h.asru_code))'',0,100));
    maxlength_asru_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.asru_code)));
    avelength_asru_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.asru_code)),h.asru_code<>(typeof(h.asru_code))'');
    populated_mp_grid_pcnt := AVE(GROUP,IF(h.mp_grid = (TYPEOF(h.mp_grid))'',0,100));
    maxlength_mp_grid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mp_grid)));
    avelength_mp_grid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mp_grid)),h.mp_grid<>(typeof(h.mp_grid))'');
    populated_number_of_qualifying_units_pcnt := AVE(GROUP,IF(h.number_of_qualifying_units = (TYPEOF(h.number_of_qualifying_units))'',0,100));
    maxlength_number_of_qualifying_units := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_qualifying_units)));
    avelength_number_of_qualifying_units := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_qualifying_units)),h.number_of_qualifying_units<>(typeof(h.number_of_qualifying_units))'');
    populated_number_of_hazmat_vehicles_pcnt := AVE(GROUP,IF(h.number_of_hazmat_vehicles = (TYPEOF(h.number_of_hazmat_vehicles))'',0,100));
    maxlength_number_of_hazmat_vehicles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_hazmat_vehicles)));
    avelength_number_of_hazmat_vehicles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_hazmat_vehicles)),h.number_of_hazmat_vehicles<>(typeof(h.number_of_hazmat_vehicles))'');
    populated_number_of_buses_involved_pcnt := AVE(GROUP,IF(h.number_of_buses_involved = (TYPEOF(h.number_of_buses_involved))'',0,100));
    maxlength_number_of_buses_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_buses_involved)));
    avelength_number_of_buses_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_buses_involved)),h.number_of_buses_involved<>(typeof(h.number_of_buses_involved))'');
    populated_number_taken_to_treatment_pcnt := AVE(GROUP,IF(h.number_taken_to_treatment = (TYPEOF(h.number_taken_to_treatment))'',0,100));
    maxlength_number_taken_to_treatment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_taken_to_treatment)));
    avelength_number_taken_to_treatment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_taken_to_treatment)),h.number_taken_to_treatment<>(typeof(h.number_taken_to_treatment))'');
    populated_number_vehicles_towed_pcnt := AVE(GROUP,IF(h.number_vehicles_towed = (TYPEOF(h.number_vehicles_towed))'',0,100));
    maxlength_number_vehicles_towed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_vehicles_towed)));
    avelength_number_vehicles_towed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_vehicles_towed)),h.number_vehicles_towed<>(typeof(h.number_vehicles_towed))'');
    populated_vehicle_at_fault_unit_number_pcnt := AVE(GROUP,IF(h.vehicle_at_fault_unit_number = (TYPEOF(h.vehicle_at_fault_unit_number))'',0,100));
    maxlength_vehicle_at_fault_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_at_fault_unit_number)));
    avelength_vehicle_at_fault_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_at_fault_unit_number)),h.vehicle_at_fault_unit_number<>(typeof(h.vehicle_at_fault_unit_number))'');
    populated_time_officer_cleared_scene_pcnt := AVE(GROUP,IF(h.time_officer_cleared_scene = (TYPEOF(h.time_officer_cleared_scene))'',0,100));
    maxlength_time_officer_cleared_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_officer_cleared_scene)));
    avelength_time_officer_cleared_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.time_officer_cleared_scene)),h.time_officer_cleared_scene<>(typeof(h.time_officer_cleared_scene))'');
    populated_total_minutes_on_scene_pcnt := AVE(GROUP,IF(h.total_minutes_on_scene = (TYPEOF(h.total_minutes_on_scene))'',0,100));
    maxlength_total_minutes_on_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_minutes_on_scene)));
    avelength_total_minutes_on_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_minutes_on_scene)),h.total_minutes_on_scene<>(typeof(h.total_minutes_on_scene))'');
    populated_motorists_report_pcnt := AVE(GROUP,IF(h.motorists_report = (TYPEOF(h.motorists_report))'',0,100));
    maxlength_motorists_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorists_report)));
    avelength_motorists_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorists_report)),h.motorists_report<>(typeof(h.motorists_report))'');
    populated_fatality_involved_pcnt := AVE(GROUP,IF(h.fatality_involved = (TYPEOF(h.fatality_involved))'',0,100));
    maxlength_fatality_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fatality_involved)));
    avelength_fatality_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fatality_involved)),h.fatality_involved<>(typeof(h.fatality_involved))'');
    populated_local_dot_index_number_pcnt := AVE(GROUP,IF(h.local_dot_index_number = (TYPEOF(h.local_dot_index_number))'',0,100));
    maxlength_local_dot_index_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_dot_index_number)));
    avelength_local_dot_index_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.local_dot_index_number)),h.local_dot_index_number<>(typeof(h.local_dot_index_number))'');
    populated_dor_number_pcnt := AVE(GROUP,IF(h.dor_number = (TYPEOF(h.dor_number))'',0,100));
    maxlength_dor_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dor_number)));
    avelength_dor_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dor_number)),h.dor_number<>(typeof(h.dor_number))'');
    populated_hospital_code_pcnt := AVE(GROUP,IF(h.hospital_code = (TYPEOF(h.hospital_code))'',0,100));
    maxlength_hospital_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_code)));
    avelength_hospital_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hospital_code)),h.hospital_code<>(typeof(h.hospital_code))'');
    populated_special_jurisdiction_pcnt := AVE(GROUP,IF(h.special_jurisdiction = (TYPEOF(h.special_jurisdiction))'',0,100));
    maxlength_special_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_jurisdiction)));
    avelength_special_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_jurisdiction)),h.special_jurisdiction<>(typeof(h.special_jurisdiction))'');
    populated_document_type_pcnt := AVE(GROUP,IF(h.document_type = (TYPEOF(h.document_type))'',0,100));
    maxlength_document_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.document_type)));
    avelength_document_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.document_type)),h.document_type<>(typeof(h.document_type))'');
    populated_distance_was_measured_pcnt := AVE(GROUP,IF(h.distance_was_measured = (TYPEOF(h.distance_was_measured))'',0,100));
    maxlength_distance_was_measured := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_was_measured)));
    avelength_distance_was_measured := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.distance_was_measured)),h.distance_was_measured<>(typeof(h.distance_was_measured))'');
    populated_street_orientation_pcnt := AVE(GROUP,IF(h.street_orientation = (TYPEOF(h.street_orientation))'',0,100));
    maxlength_street_orientation := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_orientation)));
    avelength_street_orientation := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.street_orientation)),h.street_orientation<>(typeof(h.street_orientation))'');
    populated_intersecting_route_segment_pcnt := AVE(GROUP,IF(h.intersecting_route_segment = (TYPEOF(h.intersecting_route_segment))'',0,100));
    maxlength_intersecting_route_segment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersecting_route_segment)));
    avelength_intersecting_route_segment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersecting_route_segment)),h.intersecting_route_segment<>(typeof(h.intersecting_route_segment))'');
    populated_primary_fault_indicator_pcnt := AVE(GROUP,IF(h.primary_fault_indicator = (TYPEOF(h.primary_fault_indicator))'',0,100));
    maxlength_primary_fault_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_fault_indicator)));
    avelength_primary_fault_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_fault_indicator)),h.primary_fault_indicator<>(typeof(h.primary_fault_indicator))'');
    populated_first_harmful_event_pedestrian_pcnt := AVE(GROUP,IF(h.first_harmful_event_pedestrian = (TYPEOF(h.first_harmful_event_pedestrian))'',0,100));
    maxlength_first_harmful_event_pedestrian := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_pedestrian)));
    avelength_first_harmful_event_pedestrian := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_pedestrian)),h.first_harmful_event_pedestrian<>(typeof(h.first_harmful_event_pedestrian))'');
    populated_reference_markers_pcnt := AVE(GROUP,IF(h.reference_markers = (TYPEOF(h.reference_markers))'',0,100));
    maxlength_reference_markers := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.reference_markers)));
    avelength_reference_markers := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.reference_markers)),h.reference_markers<>(typeof(h.reference_markers))'');
    populated_other_officer_on_scene_pcnt := AVE(GROUP,IF(h.other_officer_on_scene = (TYPEOF(h.other_officer_on_scene))'',0,100));
    maxlength_other_officer_on_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_officer_on_scene)));
    avelength_other_officer_on_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_officer_on_scene)),h.other_officer_on_scene<>(typeof(h.other_officer_on_scene))'');
    populated_other_officer_badge_number_pcnt := AVE(GROUP,IF(h.other_officer_badge_number = (TYPEOF(h.other_officer_badge_number))'',0,100));
    maxlength_other_officer_badge_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_officer_badge_number)));
    avelength_other_officer_badge_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_officer_badge_number)),h.other_officer_badge_number<>(typeof(h.other_officer_badge_number))'');
    populated_supplemental_report_pcnt := AVE(GROUP,IF(h.supplemental_report = (TYPEOF(h.supplemental_report))'',0,100));
    maxlength_supplemental_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplemental_report)));
    avelength_supplemental_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplemental_report)),h.supplemental_report<>(typeof(h.supplemental_report))'');
    populated_supplemental_type_pcnt := AVE(GROUP,IF(h.supplemental_type = (TYPEOF(h.supplemental_type))'',0,100));
    maxlength_supplemental_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplemental_type)));
    avelength_supplemental_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.supplemental_type)),h.supplemental_type<>(typeof(h.supplemental_type))'');
    populated_amended_report_pcnt := AVE(GROUP,IF(h.amended_report = (TYPEOF(h.amended_report))'',0,100));
    maxlength_amended_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.amended_report)));
    avelength_amended_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.amended_report)),h.amended_report<>(typeof(h.amended_report))'');
    populated_corrected_report_pcnt := AVE(GROUP,IF(h.corrected_report = (TYPEOF(h.corrected_report))'',0,100));
    maxlength_corrected_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.corrected_report)));
    avelength_corrected_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.corrected_report)),h.corrected_report<>(typeof(h.corrected_report))'');
    populated_state_highway_related_pcnt := AVE(GROUP,IF(h.state_highway_related = (TYPEOF(h.state_highway_related))'',0,100));
    maxlength_state_highway_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_highway_related)));
    avelength_state_highway_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_highway_related)),h.state_highway_related<>(typeof(h.state_highway_related))'');
    populated_roadway_lighting_condition_pcnt := AVE(GROUP,IF(h.roadway_lighting_condition = (TYPEOF(h.roadway_lighting_condition))'',0,100));
    maxlength_roadway_lighting_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_lighting_condition)));
    avelength_roadway_lighting_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.roadway_lighting_condition)),h.roadway_lighting_condition<>(typeof(h.roadway_lighting_condition))'');
    populated_vendor_reference_number_pcnt := AVE(GROUP,IF(h.vendor_reference_number = (TYPEOF(h.vendor_reference_number))'',0,100));
    maxlength_vendor_reference_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_reference_number)));
    avelength_vendor_reference_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_reference_number)),h.vendor_reference_number<>(typeof(h.vendor_reference_number))'');
    populated_duplicate_copy_unit_number_pcnt := AVE(GROUP,IF(h.duplicate_copy_unit_number = (TYPEOF(h.duplicate_copy_unit_number))'',0,100));
    maxlength_duplicate_copy_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.duplicate_copy_unit_number)));
    avelength_duplicate_copy_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.duplicate_copy_unit_number)),h.duplicate_copy_unit_number<>(typeof(h.duplicate_copy_unit_number))'');
    populated_other_city_agency_description_pcnt := AVE(GROUP,IF(h.other_city_agency_description = (TYPEOF(h.other_city_agency_description))'',0,100));
    maxlength_other_city_agency_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_city_agency_description)));
    avelength_other_city_agency_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_city_agency_description)),h.other_city_agency_description<>(typeof(h.other_city_agency_description))'');
    populated_notifcation_description_pcnt := AVE(GROUP,IF(h.notifcation_description = (TYPEOF(h.notifcation_description))'',0,100));
    maxlength_notifcation_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.notifcation_description)));
    avelength_notifcation_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.notifcation_description)),h.notifcation_description<>(typeof(h.notifcation_description))'');
    populated_primary_collision_improper_driving_description_pcnt := AVE(GROUP,IF(h.primary_collision_improper_driving_description = (TYPEOF(h.primary_collision_improper_driving_description))'',0,100));
    maxlength_primary_collision_improper_driving_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_collision_improper_driving_description)));
    avelength_primary_collision_improper_driving_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.primary_collision_improper_driving_description)),h.primary_collision_improper_driving_description<>(typeof(h.primary_collision_improper_driving_description))'');
    populated_weather_other_description_pcnt := AVE(GROUP,IF(h.weather_other_description = (TYPEOF(h.weather_other_description))'',0,100));
    maxlength_weather_other_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_other_description)));
    avelength_weather_other_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.weather_other_description)),h.weather_other_description<>(typeof(h.weather_other_description))'');
    populated_crash_type_description_pcnt := AVE(GROUP,IF(h.crash_type_description = (TYPEOF(h.crash_type_description))'',0,100));
    maxlength_crash_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_type_description)));
    avelength_crash_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crash_type_description)),h.crash_type_description<>(typeof(h.crash_type_description))'');
    populated_motor_vehicle_involved_with_animal_description_pcnt := AVE(GROUP,IF(h.motor_vehicle_involved_with_animal_description = (TYPEOF(h.motor_vehicle_involved_with_animal_description))'',0,100));
    maxlength_motor_vehicle_involved_with_animal_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_animal_description)));
    avelength_motor_vehicle_involved_with_animal_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_animal_description)),h.motor_vehicle_involved_with_animal_description<>(typeof(h.motor_vehicle_involved_with_animal_description))'');
    populated_motor_vehicle_involved_with_fixed_object_description_pcnt := AVE(GROUP,IF(h.motor_vehicle_involved_with_fixed_object_description = (TYPEOF(h.motor_vehicle_involved_with_fixed_object_description))'',0,100));
    maxlength_motor_vehicle_involved_with_fixed_object_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_fixed_object_description)));
    avelength_motor_vehicle_involved_with_fixed_object_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_fixed_object_description)),h.motor_vehicle_involved_with_fixed_object_description<>(typeof(h.motor_vehicle_involved_with_fixed_object_description))'');
    populated_motor_vehicle_involved_with_other_object_description_pcnt := AVE(GROUP,IF(h.motor_vehicle_involved_with_other_object_description = (TYPEOF(h.motor_vehicle_involved_with_other_object_description))'',0,100));
    maxlength_motor_vehicle_involved_with_other_object_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_other_object_description)));
    avelength_motor_vehicle_involved_with_other_object_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motor_vehicle_involved_with_other_object_description)),h.motor_vehicle_involved_with_other_object_description<>(typeof(h.motor_vehicle_involved_with_other_object_description))'');
    populated_other_investigation_time_pcnt := AVE(GROUP,IF(h.other_investigation_time = (TYPEOF(h.other_investigation_time))'',0,100));
    maxlength_other_investigation_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_investigation_time)));
    avelength_other_investigation_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_investigation_time)),h.other_investigation_time<>(typeof(h.other_investigation_time))'');
    populated_milepost_detail_pcnt := AVE(GROUP,IF(h.milepost_detail = (TYPEOF(h.milepost_detail))'',0,100));
    maxlength_milepost_detail := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost_detail)));
    avelength_milepost_detail := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.milepost_detail)),h.milepost_detail<>(typeof(h.milepost_detail))'');
    populated_utility_pole_number1_pcnt := AVE(GROUP,IF(h.utility_pole_number1 = (TYPEOF(h.utility_pole_number1))'',0,100));
    maxlength_utility_pole_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number1)));
    avelength_utility_pole_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number1)),h.utility_pole_number1<>(typeof(h.utility_pole_number1))'');
    populated_utility_pole_number2_pcnt := AVE(GROUP,IF(h.utility_pole_number2 = (TYPEOF(h.utility_pole_number2))'',0,100));
    maxlength_utility_pole_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number2)));
    avelength_utility_pole_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number2)),h.utility_pole_number2<>(typeof(h.utility_pole_number2))'');
    populated_utility_pole_number3_pcnt := AVE(GROUP,IF(h.utility_pole_number3 = (TYPEOF(h.utility_pole_number3))'',0,100));
    maxlength_utility_pole_number3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number3)));
    avelength_utility_pole_number3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.utility_pole_number3)),h.utility_pole_number3<>(typeof(h.utility_pole_number3))'');
    populated_person_id_pcnt := AVE(GROUP,IF(h.person_id = (TYPEOF(h.person_id))'',0,100));
    maxlength_person_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_id)));
    avelength_person_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_id)),h.person_id<>(typeof(h.person_id))'');
    populated_person_number_pcnt := AVE(GROUP,IF(h.person_number = (TYPEOF(h.person_number))'',0,100));
    maxlength_person_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_number)));
    avelength_person_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_number)),h.person_number<>(typeof(h.person_number))'');
    populated_vehicle_unit_number_pcnt := AVE(GROUP,IF(h.vehicle_unit_number = (TYPEOF(h.vehicle_unit_number))'',0,100));
    maxlength_vehicle_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_unit_number)));
    avelength_vehicle_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_unit_number)),h.vehicle_unit_number<>(typeof(h.vehicle_unit_number))'');
    populated_sex_pcnt := AVE(GROUP,IF(h.sex = (TYPEOF(h.sex))'',0,100));
    maxlength_sex := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sex)));
    avelength_sex := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sex)),h.sex<>(typeof(h.sex))'');
    populated_person_type_pcnt := AVE(GROUP,IF(h.person_type = (TYPEOF(h.person_type))'',0,100));
    maxlength_person_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_type)));
    avelength_person_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_type)),h.person_type<>(typeof(h.person_type))'');
    populated_injury_status_pcnt := AVE(GROUP,IF(h.injury_status = (TYPEOF(h.injury_status))'',0,100));
    maxlength_injury_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_status)));
    avelength_injury_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_status)),h.injury_status<>(typeof(h.injury_status))'');
    populated_occupant_vehicle_unit_number_pcnt := AVE(GROUP,IF(h.occupant_vehicle_unit_number = (TYPEOF(h.occupant_vehicle_unit_number))'',0,100));
    maxlength_occupant_vehicle_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.occupant_vehicle_unit_number)));
    avelength_occupant_vehicle_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.occupant_vehicle_unit_number)),h.occupant_vehicle_unit_number<>(typeof(h.occupant_vehicle_unit_number))'');
    populated_seating_position1_pcnt := AVE(GROUP,IF(h.seating_position1 = (TYPEOF(h.seating_position1))'',0,100));
    maxlength_seating_position1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position1)));
    avelength_seating_position1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position1)),h.seating_position1<>(typeof(h.seating_position1))'');
    populated_safety_equipment_restraint1_pcnt := AVE(GROUP,IF(h.safety_equipment_restraint1 = (TYPEOF(h.safety_equipment_restraint1))'',0,100));
    maxlength_safety_equipment_restraint1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_restraint1)));
    avelength_safety_equipment_restraint1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_restraint1)),h.safety_equipment_restraint1<>(typeof(h.safety_equipment_restraint1))'');
    populated_safety_equipment_restraint2_pcnt := AVE(GROUP,IF(h.safety_equipment_restraint2 = (TYPEOF(h.safety_equipment_restraint2))'',0,100));
    maxlength_safety_equipment_restraint2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_restraint2)));
    avelength_safety_equipment_restraint2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_restraint2)),h.safety_equipment_restraint2<>(typeof(h.safety_equipment_restraint2))'');
    populated_safety_equipment_helmet_pcnt := AVE(GROUP,IF(h.safety_equipment_helmet = (TYPEOF(h.safety_equipment_helmet))'',0,100));
    maxlength_safety_equipment_helmet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_helmet)));
    avelength_safety_equipment_helmet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_helmet)),h.safety_equipment_helmet<>(typeof(h.safety_equipment_helmet))'');
    populated_air_bag_deployed_pcnt := AVE(GROUP,IF(h.air_bag_deployed = (TYPEOF(h.air_bag_deployed))'',0,100));
    maxlength_air_bag_deployed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.air_bag_deployed)));
    avelength_air_bag_deployed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.air_bag_deployed)),h.air_bag_deployed<>(typeof(h.air_bag_deployed))'');
    populated_ejection_pcnt := AVE(GROUP,IF(h.ejection = (TYPEOF(h.ejection))'',0,100));
    maxlength_ejection := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ejection)));
    avelength_ejection := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ejection)),h.ejection<>(typeof(h.ejection))'');
    populated_drivers_license_jurisdiction_pcnt := AVE(GROUP,IF(h.drivers_license_jurisdiction = (TYPEOF(h.drivers_license_jurisdiction))'',0,100));
    maxlength_drivers_license_jurisdiction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_jurisdiction)));
    avelength_drivers_license_jurisdiction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_jurisdiction)),h.drivers_license_jurisdiction<>(typeof(h.drivers_license_jurisdiction))'');
    populated_dl_number_class_pcnt := AVE(GROUP,IF(h.dl_number_class = (TYPEOF(h.dl_number_class))'',0,100));
    maxlength_dl_number_class := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_class)));
    avelength_dl_number_class := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_class)),h.dl_number_class<>(typeof(h.dl_number_class))'');
    populated_dl_number_cdl_pcnt := AVE(GROUP,IF(h.dl_number_cdl = (TYPEOF(h.dl_number_cdl))'',0,100));
    maxlength_dl_number_cdl := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl)));
    avelength_dl_number_cdl := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl)),h.dl_number_cdl<>(typeof(h.dl_number_cdl))'');
    populated_dl_number_endorsements_pcnt := AVE(GROUP,IF(h.dl_number_endorsements = (TYPEOF(h.dl_number_endorsements))'',0,100));
    maxlength_dl_number_endorsements := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_endorsements)));
    avelength_dl_number_endorsements := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_endorsements)),h.dl_number_endorsements<>(typeof(h.dl_number_endorsements))'');
    populated_driver_actions_at_time_of_crash1_pcnt := AVE(GROUP,IF(h.driver_actions_at_time_of_crash1 = (TYPEOF(h.driver_actions_at_time_of_crash1))'',0,100));
    maxlength_driver_actions_at_time_of_crash1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash1)));
    avelength_driver_actions_at_time_of_crash1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash1)),h.driver_actions_at_time_of_crash1<>(typeof(h.driver_actions_at_time_of_crash1))'');
    populated_driver_actions_at_time_of_crash2_pcnt := AVE(GROUP,IF(h.driver_actions_at_time_of_crash2 = (TYPEOF(h.driver_actions_at_time_of_crash2))'',0,100));
    maxlength_driver_actions_at_time_of_crash2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash2)));
    avelength_driver_actions_at_time_of_crash2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash2)),h.driver_actions_at_time_of_crash2<>(typeof(h.driver_actions_at_time_of_crash2))'');
    populated_driver_actions_at_time_of_crash3_pcnt := AVE(GROUP,IF(h.driver_actions_at_time_of_crash3 = (TYPEOF(h.driver_actions_at_time_of_crash3))'',0,100));
    maxlength_driver_actions_at_time_of_crash3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash3)));
    avelength_driver_actions_at_time_of_crash3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash3)),h.driver_actions_at_time_of_crash3<>(typeof(h.driver_actions_at_time_of_crash3))'');
    populated_driver_actions_at_time_of_crash4_pcnt := AVE(GROUP,IF(h.driver_actions_at_time_of_crash4 = (TYPEOF(h.driver_actions_at_time_of_crash4))'',0,100));
    maxlength_driver_actions_at_time_of_crash4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash4)));
    avelength_driver_actions_at_time_of_crash4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_actions_at_time_of_crash4)),h.driver_actions_at_time_of_crash4<>(typeof(h.driver_actions_at_time_of_crash4))'');
    populated_violation_codes_pcnt := AVE(GROUP,IF(h.violation_codes = (TYPEOF(h.violation_codes))'',0,100));
    maxlength_violation_codes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_codes)));
    avelength_violation_codes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.violation_codes)),h.violation_codes<>(typeof(h.violation_codes))'');
    populated_condition_at_time_of_crash1_pcnt := AVE(GROUP,IF(h.condition_at_time_of_crash1 = (TYPEOF(h.condition_at_time_of_crash1))'',0,100));
    maxlength_condition_at_time_of_crash1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.condition_at_time_of_crash1)));
    avelength_condition_at_time_of_crash1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.condition_at_time_of_crash1)),h.condition_at_time_of_crash1<>(typeof(h.condition_at_time_of_crash1))'');
    populated_condition_at_time_of_crash2_pcnt := AVE(GROUP,IF(h.condition_at_time_of_crash2 = (TYPEOF(h.condition_at_time_of_crash2))'',0,100));
    maxlength_condition_at_time_of_crash2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.condition_at_time_of_crash2)));
    avelength_condition_at_time_of_crash2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.condition_at_time_of_crash2)),h.condition_at_time_of_crash2<>(typeof(h.condition_at_time_of_crash2))'');
    populated_law_enforcement_suspects_alcohol_use_pcnt := AVE(GROUP,IF(h.law_enforcement_suspects_alcohol_use = (TYPEOF(h.law_enforcement_suspects_alcohol_use))'',0,100));
    maxlength_law_enforcement_suspects_alcohol_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_alcohol_use)));
    avelength_law_enforcement_suspects_alcohol_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_alcohol_use)),h.law_enforcement_suspects_alcohol_use<>(typeof(h.law_enforcement_suspects_alcohol_use))'');
    populated_alcohol_test_status_pcnt := AVE(GROUP,IF(h.alcohol_test_status = (TYPEOF(h.alcohol_test_status))'',0,100));
    maxlength_alcohol_test_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_status)));
    avelength_alcohol_test_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_status)),h.alcohol_test_status<>(typeof(h.alcohol_test_status))'');
    populated_alcohol_test_type_pcnt := AVE(GROUP,IF(h.alcohol_test_type = (TYPEOF(h.alcohol_test_type))'',0,100));
    maxlength_alcohol_test_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type)));
    avelength_alcohol_test_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type)),h.alcohol_test_type<>(typeof(h.alcohol_test_type))'');
    populated_alcohol_test_result_pcnt := AVE(GROUP,IF(h.alcohol_test_result = (TYPEOF(h.alcohol_test_result))'',0,100));
    maxlength_alcohol_test_result := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_result)));
    avelength_alcohol_test_result := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_result)),h.alcohol_test_result<>(typeof(h.alcohol_test_result))'');
    populated_law_enforcement_suspects_drug_use_pcnt := AVE(GROUP,IF(h.law_enforcement_suspects_drug_use = (TYPEOF(h.law_enforcement_suspects_drug_use))'',0,100));
    maxlength_law_enforcement_suspects_drug_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_drug_use)));
    avelength_law_enforcement_suspects_drug_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_drug_use)),h.law_enforcement_suspects_drug_use<>(typeof(h.law_enforcement_suspects_drug_use))'');
    populated_drug_test_given_pcnt := AVE(GROUP,IF(h.drug_test_given = (TYPEOF(h.drug_test_given))'',0,100));
    maxlength_drug_test_given := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_given)));
    avelength_drug_test_given := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_given)),h.drug_test_given<>(typeof(h.drug_test_given))'');
    populated_non_motorist_actions_prior_to_crash1_pcnt := AVE(GROUP,IF(h.non_motorist_actions_prior_to_crash1 = (TYPEOF(h.non_motorist_actions_prior_to_crash1))'',0,100));
    maxlength_non_motorist_actions_prior_to_crash1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_prior_to_crash1)));
    avelength_non_motorist_actions_prior_to_crash1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_prior_to_crash1)),h.non_motorist_actions_prior_to_crash1<>(typeof(h.non_motorist_actions_prior_to_crash1))'');
    populated_non_motorist_actions_prior_to_crash2_pcnt := AVE(GROUP,IF(h.non_motorist_actions_prior_to_crash2 = (TYPEOF(h.non_motorist_actions_prior_to_crash2))'',0,100));
    maxlength_non_motorist_actions_prior_to_crash2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_prior_to_crash2)));
    avelength_non_motorist_actions_prior_to_crash2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_prior_to_crash2)),h.non_motorist_actions_prior_to_crash2<>(typeof(h.non_motorist_actions_prior_to_crash2))'');
    populated_non_motorist_actions_at_time_of_crash_pcnt := AVE(GROUP,IF(h.non_motorist_actions_at_time_of_crash = (TYPEOF(h.non_motorist_actions_at_time_of_crash))'',0,100));
    maxlength_non_motorist_actions_at_time_of_crash := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_at_time_of_crash)));
    avelength_non_motorist_actions_at_time_of_crash := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_actions_at_time_of_crash)),h.non_motorist_actions_at_time_of_crash<>(typeof(h.non_motorist_actions_at_time_of_crash))'');
    populated_non_motorist_location_at_time_of_crash_pcnt := AVE(GROUP,IF(h.non_motorist_location_at_time_of_crash = (TYPEOF(h.non_motorist_location_at_time_of_crash))'',0,100));
    maxlength_non_motorist_location_at_time_of_crash := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_location_at_time_of_crash)));
    avelength_non_motorist_location_at_time_of_crash := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_location_at_time_of_crash)),h.non_motorist_location_at_time_of_crash<>(typeof(h.non_motorist_location_at_time_of_crash))'');
    populated_non_motorist_safety_equipment1_pcnt := AVE(GROUP,IF(h.non_motorist_safety_equipment1 = (TYPEOF(h.non_motorist_safety_equipment1))'',0,100));
    maxlength_non_motorist_safety_equipment1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_safety_equipment1)));
    avelength_non_motorist_safety_equipment1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_safety_equipment1)),h.non_motorist_safety_equipment1<>(typeof(h.non_motorist_safety_equipment1))'');
    populated_age_pcnt := AVE(GROUP,IF(h.age = (TYPEOF(h.age))'',0,100));
    maxlength_age := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.age)));
    avelength_age := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.age)),h.age<>(typeof(h.age))'');
    populated_driver_license_restrictions1_pcnt := AVE(GROUP,IF(h.driver_license_restrictions1 = (TYPEOF(h.driver_license_restrictions1))'',0,100));
    maxlength_driver_license_restrictions1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_restrictions1)));
    avelength_driver_license_restrictions1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_restrictions1)),h.driver_license_restrictions1<>(typeof(h.driver_license_restrictions1))'');
    populated_drug_test_type_pcnt := AVE(GROUP,IF(h.drug_test_type = (TYPEOF(h.drug_test_type))'',0,100));
    maxlength_drug_test_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type)));
    avelength_drug_test_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type)),h.drug_test_type<>(typeof(h.drug_test_type))'');
    populated_drug_test_result1_pcnt := AVE(GROUP,IF(h.drug_test_result1 = (TYPEOF(h.drug_test_result1))'',0,100));
    maxlength_drug_test_result1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result1)));
    avelength_drug_test_result1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result1)),h.drug_test_result1<>(typeof(h.drug_test_result1))'');
    populated_drug_test_result2_pcnt := AVE(GROUP,IF(h.drug_test_result2 = (TYPEOF(h.drug_test_result2))'',0,100));
    maxlength_drug_test_result2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result2)));
    avelength_drug_test_result2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result2)),h.drug_test_result2<>(typeof(h.drug_test_result2))'');
    populated_drug_test_result3_pcnt := AVE(GROUP,IF(h.drug_test_result3 = (TYPEOF(h.drug_test_result3))'',0,100));
    maxlength_drug_test_result3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result3)));
    avelength_drug_test_result3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result3)),h.drug_test_result3<>(typeof(h.drug_test_result3))'');
    populated_drug_test_result4_pcnt := AVE(GROUP,IF(h.drug_test_result4 = (TYPEOF(h.drug_test_result4))'',0,100));
    maxlength_drug_test_result4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result4)));
    avelength_drug_test_result4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_result4)),h.drug_test_result4<>(typeof(h.drug_test_result4))'');
    populated_injury_area_pcnt := AVE(GROUP,IF(h.injury_area = (TYPEOF(h.injury_area))'',0,100));
    maxlength_injury_area := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_area)));
    avelength_injury_area := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_area)),h.injury_area<>(typeof(h.injury_area))'');
    populated_injury_description_pcnt := AVE(GROUP,IF(h.injury_description = (TYPEOF(h.injury_description))'',0,100));
    maxlength_injury_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_description)));
    avelength_injury_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_description)),h.injury_description<>(typeof(h.injury_description))'');
    populated_motorcyclist_head_injury_pcnt := AVE(GROUP,IF(h.motorcyclist_head_injury = (TYPEOF(h.motorcyclist_head_injury))'',0,100));
    maxlength_motorcyclist_head_injury := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcyclist_head_injury)));
    avelength_motorcyclist_head_injury := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcyclist_head_injury)),h.motorcyclist_head_injury<>(typeof(h.motorcyclist_head_injury))'');
    populated_party_id_pcnt := AVE(GROUP,IF(h.party_id = (TYPEOF(h.party_id))'',0,100));
    maxlength_party_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_id)));
    avelength_party_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_id)),h.party_id<>(typeof(h.party_id))'');
    populated_same_as_driver_pcnt := AVE(GROUP,IF(h.same_as_driver = (TYPEOF(h.same_as_driver))'',0,100));
    maxlength_same_as_driver := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.same_as_driver)));
    avelength_same_as_driver := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.same_as_driver)),h.same_as_driver<>(typeof(h.same_as_driver))'');
    populated_address_same_as_driver_pcnt := AVE(GROUP,IF(h.address_same_as_driver = (TYPEOF(h.address_same_as_driver))'',0,100));
    maxlength_address_same_as_driver := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_same_as_driver)));
    avelength_address_same_as_driver := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address_same_as_driver)),h.address_same_as_driver<>(typeof(h.address_same_as_driver))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_name_suffx_pcnt := AVE(GROUP,IF(h.name_suffx = (TYPEOF(h.name_suffx))'',0,100));
    maxlength_name_suffx := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffx)));
    avelength_name_suffx := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffx)),h.name_suffx<>(typeof(h.name_suffx))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_home_phone_pcnt := AVE(GROUP,IF(h.home_phone = (TYPEOF(h.home_phone))'',0,100));
    maxlength_home_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_phone)));
    avelength_home_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_phone)),h.home_phone<>(typeof(h.home_phone))'');
    populated_business_phone_pcnt := AVE(GROUP,IF(h.business_phone = (TYPEOF(h.business_phone))'',0,100));
    maxlength_business_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.business_phone)));
    avelength_business_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.business_phone)),h.business_phone<>(typeof(h.business_phone))'');
    populated_insurance_company_pcnt := AVE(GROUP,IF(h.insurance_company = (TYPEOF(h.insurance_company))'',0,100));
    maxlength_insurance_company := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company)));
    avelength_insurance_company := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company)),h.insurance_company<>(typeof(h.insurance_company))'');
    populated_insurance_company_phone_number_pcnt := AVE(GROUP,IF(h.insurance_company_phone_number = (TYPEOF(h.insurance_company_phone_number))'',0,100));
    maxlength_insurance_company_phone_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_phone_number)));
    avelength_insurance_company_phone_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_phone_number)),h.insurance_company_phone_number<>(typeof(h.insurance_company_phone_number))'');
    populated_insurance_policy_number_pcnt := AVE(GROUP,IF(h.insurance_policy_number = (TYPEOF(h.insurance_policy_number))'',0,100));
    maxlength_insurance_policy_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_policy_number)));
    avelength_insurance_policy_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_policy_number)),h.insurance_policy_number<>(typeof(h.insurance_policy_number))'');
    populated_insurance_effective_date_pcnt := AVE(GROUP,IF(h.insurance_effective_date = (TYPEOF(h.insurance_effective_date))'',0,100));
    maxlength_insurance_effective_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_effective_date)));
    avelength_insurance_effective_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_effective_date)),h.insurance_effective_date<>(typeof(h.insurance_effective_date))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_drivers_license_number_pcnt := AVE(GROUP,IF(h.drivers_license_number = (TYPEOF(h.drivers_license_number))'',0,100));
    maxlength_drivers_license_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_number)));
    avelength_drivers_license_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_number)),h.drivers_license_number<>(typeof(h.drivers_license_number))'');
    populated_drivers_license_expiration_pcnt := AVE(GROUP,IF(h.drivers_license_expiration = (TYPEOF(h.drivers_license_expiration))'',0,100));
    maxlength_drivers_license_expiration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_expiration)));
    avelength_drivers_license_expiration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_expiration)),h.drivers_license_expiration<>(typeof(h.drivers_license_expiration))'');
    populated_eye_color_pcnt := AVE(GROUP,IF(h.eye_color = (TYPEOF(h.eye_color))'',0,100));
    maxlength_eye_color := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.eye_color)));
    avelength_eye_color := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.eye_color)),h.eye_color<>(typeof(h.eye_color))'');
    populated_hair_color_pcnt := AVE(GROUP,IF(h.hair_color = (TYPEOF(h.hair_color))'',0,100));
    maxlength_hair_color := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hair_color)));
    avelength_hair_color := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hair_color)),h.hair_color<>(typeof(h.hair_color))'');
    populated_height_pcnt := AVE(GROUP,IF(h.height = (TYPEOF(h.height))'',0,100));
    maxlength_height := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.height)));
    avelength_height := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.height)),h.height<>(typeof(h.height))'');
    populated_weight_pcnt := AVE(GROUP,IF(h.weight = (TYPEOF(h.weight))'',0,100));
    maxlength_weight := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.weight)));
    avelength_weight := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.weight)),h.weight<>(typeof(h.weight))'');
    populated_race_pcnt := AVE(GROUP,IF(h.race = (TYPEOF(h.race))'',0,100));
    maxlength_race := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.race)));
    avelength_race := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.race)),h.race<>(typeof(h.race))'');
    populated_pedestrian_cyclist_visibility_pcnt := AVE(GROUP,IF(h.pedestrian_cyclist_visibility = (TYPEOF(h.pedestrian_cyclist_visibility))'',0,100));
    maxlength_pedestrian_cyclist_visibility := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedestrian_cyclist_visibility)));
    avelength_pedestrian_cyclist_visibility := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedestrian_cyclist_visibility)),h.pedestrian_cyclist_visibility<>(typeof(h.pedestrian_cyclist_visibility))'');
    populated_first_aid_by_pcnt := AVE(GROUP,IF(h.first_aid_by = (TYPEOF(h.first_aid_by))'',0,100));
    maxlength_first_aid_by := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_aid_by)));
    avelength_first_aid_by := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_aid_by)),h.first_aid_by<>(typeof(h.first_aid_by))'');
    populated_person_first_aid_party_type_pcnt := AVE(GROUP,IF(h.person_first_aid_party_type = (TYPEOF(h.person_first_aid_party_type))'',0,100));
    maxlength_person_first_aid_party_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_first_aid_party_type)));
    avelength_person_first_aid_party_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_first_aid_party_type)),h.person_first_aid_party_type<>(typeof(h.person_first_aid_party_type))'');
    populated_person_first_aid_party_type_description_pcnt := AVE(GROUP,IF(h.person_first_aid_party_type_description = (TYPEOF(h.person_first_aid_party_type_description))'',0,100));
    maxlength_person_first_aid_party_type_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_first_aid_party_type_description)));
    avelength_person_first_aid_party_type_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_first_aid_party_type_description)),h.person_first_aid_party_type_description<>(typeof(h.person_first_aid_party_type_description))'');
    populated_deceased_at_scene_pcnt := AVE(GROUP,IF(h.deceased_at_scene = (TYPEOF(h.deceased_at_scene))'',0,100));
    maxlength_deceased_at_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.deceased_at_scene)));
    avelength_deceased_at_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.deceased_at_scene)),h.deceased_at_scene<>(typeof(h.deceased_at_scene))'');
    populated_death_date_pcnt := AVE(GROUP,IF(h.death_date = (TYPEOF(h.death_date))'',0,100));
    maxlength_death_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_date)));
    avelength_death_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_date)),h.death_date<>(typeof(h.death_date))'');
    populated_death_time_pcnt := AVE(GROUP,IF(h.death_time = (TYPEOF(h.death_time))'',0,100));
    maxlength_death_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_time)));
    avelength_death_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.death_time)),h.death_time<>(typeof(h.death_time))'');
    populated_extricated_pcnt := AVE(GROUP,IF(h.extricated = (TYPEOF(h.extricated))'',0,100));
    maxlength_extricated := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.extricated)));
    avelength_extricated := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.extricated)),h.extricated<>(typeof(h.extricated))'');
    populated_alcohol_drug_use_pcnt := AVE(GROUP,IF(h.alcohol_drug_use = (TYPEOF(h.alcohol_drug_use))'',0,100));
    maxlength_alcohol_drug_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_use)));
    avelength_alcohol_drug_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_use)),h.alcohol_drug_use<>(typeof(h.alcohol_drug_use))'');
    populated_physical_defects_pcnt := AVE(GROUP,IF(h.physical_defects = (TYPEOF(h.physical_defects))'',0,100));
    maxlength_physical_defects := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.physical_defects)));
    avelength_physical_defects := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.physical_defects)),h.physical_defects<>(typeof(h.physical_defects))'');
    populated_driver_residence_pcnt := AVE(GROUP,IF(h.driver_residence = (TYPEOF(h.driver_residence))'',0,100));
    maxlength_driver_residence := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_residence)));
    avelength_driver_residence := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_residence)),h.driver_residence<>(typeof(h.driver_residence))'');
    populated_id_type_pcnt := AVE(GROUP,IF(h.id_type = (TYPEOF(h.id_type))'',0,100));
    maxlength_id_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.id_type)));
    avelength_id_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.id_type)),h.id_type<>(typeof(h.id_type))'');
    populated_proof_of_insurance_pcnt := AVE(GROUP,IF(h.proof_of_insurance = (TYPEOF(h.proof_of_insurance))'',0,100));
    maxlength_proof_of_insurance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.proof_of_insurance)));
    avelength_proof_of_insurance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.proof_of_insurance)),h.proof_of_insurance<>(typeof(h.proof_of_insurance))'');
    populated_insurance_expired_pcnt := AVE(GROUP,IF(h.insurance_expired = (TYPEOF(h.insurance_expired))'',0,100));
    maxlength_insurance_expired := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_expired)));
    avelength_insurance_expired := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_expired)),h.insurance_expired<>(typeof(h.insurance_expired))'');
    populated_insurance_exempt_pcnt := AVE(GROUP,IF(h.insurance_exempt = (TYPEOF(h.insurance_exempt))'',0,100));
    maxlength_insurance_exempt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_exempt)));
    avelength_insurance_exempt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_exempt)),h.insurance_exempt<>(typeof(h.insurance_exempt))'');
    populated_insurance_type_pcnt := AVE(GROUP,IF(h.insurance_type = (TYPEOF(h.insurance_type))'',0,100));
    maxlength_insurance_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_type)));
    avelength_insurance_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_type)),h.insurance_type<>(typeof(h.insurance_type))'');
    populated_violent_crime_victim_notified_pcnt := AVE(GROUP,IF(h.violent_crime_victim_notified = (TYPEOF(h.violent_crime_victim_notified))'',0,100));
    maxlength_violent_crime_victim_notified := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.violent_crime_victim_notified)));
    avelength_violent_crime_victim_notified := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.violent_crime_victim_notified)),h.violent_crime_victim_notified<>(typeof(h.violent_crime_victim_notified))'');
    populated_insurance_company_code_pcnt := AVE(GROUP,IF(h.insurance_company_code = (TYPEOF(h.insurance_company_code))'',0,100));
    maxlength_insurance_company_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_code)));
    avelength_insurance_company_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_code)),h.insurance_company_code<>(typeof(h.insurance_company_code))'');
    populated_refused_medical_treatment_pcnt := AVE(GROUP,IF(h.refused_medical_treatment = (TYPEOF(h.refused_medical_treatment))'',0,100));
    maxlength_refused_medical_treatment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.refused_medical_treatment)));
    avelength_refused_medical_treatment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.refused_medical_treatment)),h.refused_medical_treatment<>(typeof(h.refused_medical_treatment))'');
    populated_safety_equipment_available_or_used_pcnt := AVE(GROUP,IF(h.safety_equipment_available_or_used = (TYPEOF(h.safety_equipment_available_or_used))'',0,100));
    maxlength_safety_equipment_available_or_used := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_available_or_used)));
    avelength_safety_equipment_available_or_used := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.safety_equipment_available_or_used)),h.safety_equipment_available_or_used<>(typeof(h.safety_equipment_available_or_used))'');
    populated_apartment_number_pcnt := AVE(GROUP,IF(h.apartment_number = (TYPEOF(h.apartment_number))'',0,100));
    maxlength_apartment_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.apartment_number)));
    avelength_apartment_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.apartment_number)),h.apartment_number<>(typeof(h.apartment_number))'');
    populated_licensed_driver_pcnt := AVE(GROUP,IF(h.licensed_driver = (TYPEOF(h.licensed_driver))'',0,100));
    maxlength_licensed_driver := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.licensed_driver)));
    avelength_licensed_driver := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.licensed_driver)),h.licensed_driver<>(typeof(h.licensed_driver))'');
    populated_physical_emotional_status_pcnt := AVE(GROUP,IF(h.physical_emotional_status = (TYPEOF(h.physical_emotional_status))'',0,100));
    maxlength_physical_emotional_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.physical_emotional_status)));
    avelength_physical_emotional_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.physical_emotional_status)),h.physical_emotional_status<>(typeof(h.physical_emotional_status))'');
    populated_driver_presence_pcnt := AVE(GROUP,IF(h.driver_presence = (TYPEOF(h.driver_presence))'',0,100));
    maxlength_driver_presence := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_presence)));
    avelength_driver_presence := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_presence)),h.driver_presence<>(typeof(h.driver_presence))'');
    populated_ejection_path_pcnt := AVE(GROUP,IF(h.ejection_path = (TYPEOF(h.ejection_path))'',0,100));
    maxlength_ejection_path := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ejection_path)));
    avelength_ejection_path := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ejection_path)),h.ejection_path<>(typeof(h.ejection_path))'');
    populated_state_person_id_pcnt := AVE(GROUP,IF(h.state_person_id = (TYPEOF(h.state_person_id))'',0,100));
    maxlength_state_person_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_person_id)));
    avelength_state_person_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_person_id)),h.state_person_id<>(typeof(h.state_person_id))'');
    populated_contributed_to_collision_pcnt := AVE(GROUP,IF(h.contributed_to_collision = (TYPEOF(h.contributed_to_collision))'',0,100));
    maxlength_contributed_to_collision := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributed_to_collision)));
    avelength_contributed_to_collision := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributed_to_collision)),h.contributed_to_collision<>(typeof(h.contributed_to_collision))'');
    populated_person_transported_for_medical_care_pcnt := AVE(GROUP,IF(h.person_transported_for_medical_care = (TYPEOF(h.person_transported_for_medical_care))'',0,100));
    maxlength_person_transported_for_medical_care := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_transported_for_medical_care)));
    avelength_person_transported_for_medical_care := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_transported_for_medical_care)),h.person_transported_for_medical_care<>(typeof(h.person_transported_for_medical_care))'');
    populated_transported_by_agency_type_pcnt := AVE(GROUP,IF(h.transported_by_agency_type = (TYPEOF(h.transported_by_agency_type))'',0,100));
    maxlength_transported_by_agency_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_by_agency_type)));
    avelength_transported_by_agency_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_by_agency_type)),h.transported_by_agency_type<>(typeof(h.transported_by_agency_type))'');
    populated_transported_to_pcnt := AVE(GROUP,IF(h.transported_to = (TYPEOF(h.transported_to))'',0,100));
    maxlength_transported_to := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_to)));
    avelength_transported_to := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_to)),h.transported_to<>(typeof(h.transported_to))'');
    populated_non_motorist_driver_license_number_pcnt := AVE(GROUP,IF(h.non_motorist_driver_license_number = (TYPEOF(h.non_motorist_driver_license_number))'',0,100));
    maxlength_non_motorist_driver_license_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_driver_license_number)));
    avelength_non_motorist_driver_license_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_driver_license_number)),h.non_motorist_driver_license_number<>(typeof(h.non_motorist_driver_license_number))'');
    populated_air_bag_type_pcnt := AVE(GROUP,IF(h.air_bag_type = (TYPEOF(h.air_bag_type))'',0,100));
    maxlength_air_bag_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.air_bag_type)));
    avelength_air_bag_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.air_bag_type)),h.air_bag_type<>(typeof(h.air_bag_type))'');
    populated_cell_phone_use_pcnt := AVE(GROUP,IF(h.cell_phone_use = (TYPEOF(h.cell_phone_use))'',0,100));
    maxlength_cell_phone_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cell_phone_use)));
    avelength_cell_phone_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cell_phone_use)),h.cell_phone_use<>(typeof(h.cell_phone_use))'');
    populated_driver_license_restriction_compliance_pcnt := AVE(GROUP,IF(h.driver_license_restriction_compliance = (TYPEOF(h.driver_license_restriction_compliance))'',0,100));
    maxlength_driver_license_restriction_compliance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_restriction_compliance)));
    avelength_driver_license_restriction_compliance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_restriction_compliance)),h.driver_license_restriction_compliance<>(typeof(h.driver_license_restriction_compliance))'');
    populated_driver_license_endorsement_compliance_pcnt := AVE(GROUP,IF(h.driver_license_endorsement_compliance = (TYPEOF(h.driver_license_endorsement_compliance))'',0,100));
    maxlength_driver_license_endorsement_compliance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_endorsement_compliance)));
    avelength_driver_license_endorsement_compliance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_endorsement_compliance)),h.driver_license_endorsement_compliance<>(typeof(h.driver_license_endorsement_compliance))'');
    populated_driver_license_compliance_pcnt := AVE(GROUP,IF(h.driver_license_compliance = (TYPEOF(h.driver_license_compliance))'',0,100));
    maxlength_driver_license_compliance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_compliance)));
    avelength_driver_license_compliance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_license_compliance)),h.driver_license_compliance<>(typeof(h.driver_license_compliance))'');
    populated_contributing_circumstances_p1_pcnt := AVE(GROUP,IF(h.contributing_circumstances_p1 = (TYPEOF(h.contributing_circumstances_p1))'',0,100));
    maxlength_contributing_circumstances_p1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p1)));
    avelength_contributing_circumstances_p1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p1)),h.contributing_circumstances_p1<>(typeof(h.contributing_circumstances_p1))'');
    populated_contributing_circumstances_p2_pcnt := AVE(GROUP,IF(h.contributing_circumstances_p2 = (TYPEOF(h.contributing_circumstances_p2))'',0,100));
    maxlength_contributing_circumstances_p2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p2)));
    avelength_contributing_circumstances_p2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p2)),h.contributing_circumstances_p2<>(typeof(h.contributing_circumstances_p2))'');
    populated_contributing_circumstances_p3_pcnt := AVE(GROUP,IF(h.contributing_circumstances_p3 = (TYPEOF(h.contributing_circumstances_p3))'',0,100));
    maxlength_contributing_circumstances_p3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p3)));
    avelength_contributing_circumstances_p3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p3)),h.contributing_circumstances_p3<>(typeof(h.contributing_circumstances_p3))'');
    populated_contributing_circumstances_p4_pcnt := AVE(GROUP,IF(h.contributing_circumstances_p4 = (TYPEOF(h.contributing_circumstances_p4))'',0,100));
    maxlength_contributing_circumstances_p4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p4)));
    avelength_contributing_circumstances_p4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_p4)),h.contributing_circumstances_p4<>(typeof(h.contributing_circumstances_p4))'');
    populated_passenger_number_pcnt := AVE(GROUP,IF(h.passenger_number = (TYPEOF(h.passenger_number))'',0,100));
    maxlength_passenger_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.passenger_number)));
    avelength_passenger_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.passenger_number)),h.passenger_number<>(typeof(h.passenger_number))'');
    populated_person_deleted_pcnt := AVE(GROUP,IF(h.person_deleted = (TYPEOF(h.person_deleted))'',0,100));
    maxlength_person_deleted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_deleted)));
    avelength_person_deleted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.person_deleted)),h.person_deleted<>(typeof(h.person_deleted))'');
    populated_owner_lessee_pcnt := AVE(GROUP,IF(h.owner_lessee = (TYPEOF(h.owner_lessee))'',0,100));
    maxlength_owner_lessee := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.owner_lessee)));
    avelength_owner_lessee := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.owner_lessee)),h.owner_lessee<>(typeof(h.owner_lessee))'');
    populated_driver_charged_pcnt := AVE(GROUP,IF(h.driver_charged = (TYPEOF(h.driver_charged))'',0,100));
    maxlength_driver_charged := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_charged)));
    avelength_driver_charged := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_charged)),h.driver_charged<>(typeof(h.driver_charged))'');
    populated_motorcycle_eye_protection_pcnt := AVE(GROUP,IF(h.motorcycle_eye_protection = (TYPEOF(h.motorcycle_eye_protection))'',0,100));
    maxlength_motorcycle_eye_protection := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_eye_protection)));
    avelength_motorcycle_eye_protection := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_eye_protection)),h.motorcycle_eye_protection<>(typeof(h.motorcycle_eye_protection))'');
    populated_motorcycle_long_sleeves_pcnt := AVE(GROUP,IF(h.motorcycle_long_sleeves = (TYPEOF(h.motorcycle_long_sleeves))'',0,100));
    maxlength_motorcycle_long_sleeves := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_long_sleeves)));
    avelength_motorcycle_long_sleeves := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_long_sleeves)),h.motorcycle_long_sleeves<>(typeof(h.motorcycle_long_sleeves))'');
    populated_motorcycle_long_pants_pcnt := AVE(GROUP,IF(h.motorcycle_long_pants = (TYPEOF(h.motorcycle_long_pants))'',0,100));
    maxlength_motorcycle_long_pants := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_long_pants)));
    avelength_motorcycle_long_pants := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_long_pants)),h.motorcycle_long_pants<>(typeof(h.motorcycle_long_pants))'');
    populated_motorcycle_over_ankle_boots_pcnt := AVE(GROUP,IF(h.motorcycle_over_ankle_boots = (TYPEOF(h.motorcycle_over_ankle_boots))'',0,100));
    maxlength_motorcycle_over_ankle_boots := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_over_ankle_boots)));
    avelength_motorcycle_over_ankle_boots := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_over_ankle_boots)),h.motorcycle_over_ankle_boots<>(typeof(h.motorcycle_over_ankle_boots))'');
    populated_contributing_circumstances_environmental_non_incident1_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental_non_incident1 = (TYPEOF(h.contributing_circumstances_environmental_non_incident1))'',0,100));
    maxlength_contributing_circumstances_environmental_non_incident1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental_non_incident1)));
    avelength_contributing_circumstances_environmental_non_incident1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental_non_incident1)),h.contributing_circumstances_environmental_non_incident1<>(typeof(h.contributing_circumstances_environmental_non_incident1))'');
    populated_contributing_circumstances_environmental_non_incident2_pcnt := AVE(GROUP,IF(h.contributing_circumstances_environmental_non_incident2 = (TYPEOF(h.contributing_circumstances_environmental_non_incident2))'',0,100));
    maxlength_contributing_circumstances_environmental_non_incident2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental_non_incident2)));
    avelength_contributing_circumstances_environmental_non_incident2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_environmental_non_incident2)),h.contributing_circumstances_environmental_non_incident2<>(typeof(h.contributing_circumstances_environmental_non_incident2))'');
    populated_alcohol_drug_test_given_pcnt := AVE(GROUP,IF(h.alcohol_drug_test_given = (TYPEOF(h.alcohol_drug_test_given))'',0,100));
    maxlength_alcohol_drug_test_given := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_given)));
    avelength_alcohol_drug_test_given := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_given)),h.alcohol_drug_test_given<>(typeof(h.alcohol_drug_test_given))'');
    populated_alcohol_drug_test_type_pcnt := AVE(GROUP,IF(h.alcohol_drug_test_type = (TYPEOF(h.alcohol_drug_test_type))'',0,100));
    maxlength_alcohol_drug_test_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_type)));
    avelength_alcohol_drug_test_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_type)),h.alcohol_drug_test_type<>(typeof(h.alcohol_drug_test_type))'');
    populated_alcohol_drug_test_result_pcnt := AVE(GROUP,IF(h.alcohol_drug_test_result = (TYPEOF(h.alcohol_drug_test_result))'',0,100));
    maxlength_alcohol_drug_test_result := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_result)));
    avelength_alcohol_drug_test_result := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_drug_test_result)),h.alcohol_drug_test_result<>(typeof(h.alcohol_drug_test_result))'');
    populated_vin_pcnt := AVE(GROUP,IF(h.vin = (TYPEOF(h.vin))'',0,100));
    maxlength_vin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin)));
    avelength_vin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin)),h.vin<>(typeof(h.vin))'');
    populated_vin_status_pcnt := AVE(GROUP,IF(h.vin_status = (TYPEOF(h.vin_status))'',0,100));
    maxlength_vin_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_status)));
    avelength_vin_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_status)),h.vin_status<>(typeof(h.vin_status))'');
    populated_damaged_areas_derived1_pcnt := AVE(GROUP,IF(h.damaged_areas_derived1 = (TYPEOF(h.damaged_areas_derived1))'',0,100));
    maxlength_damaged_areas_derived1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_derived1)));
    avelength_damaged_areas_derived1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_derived1)),h.damaged_areas_derived1<>(typeof(h.damaged_areas_derived1))'');
    populated_damaged_areas_derived2_pcnt := AVE(GROUP,IF(h.damaged_areas_derived2 = (TYPEOF(h.damaged_areas_derived2))'',0,100));
    maxlength_damaged_areas_derived2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_derived2)));
    avelength_damaged_areas_derived2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_derived2)),h.damaged_areas_derived2<>(typeof(h.damaged_areas_derived2))'');
    populated_airbags_deployed_derived_pcnt := AVE(GROUP,IF(h.airbags_deployed_derived = (TYPEOF(h.airbags_deployed_derived))'',0,100));
    maxlength_airbags_deployed_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.airbags_deployed_derived)));
    avelength_airbags_deployed_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.airbags_deployed_derived)),h.airbags_deployed_derived<>(typeof(h.airbags_deployed_derived))'');
    populated_vehicle_towed_derived_pcnt := AVE(GROUP,IF(h.vehicle_towed_derived = (TYPEOF(h.vehicle_towed_derived))'',0,100));
    maxlength_vehicle_towed_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_towed_derived)));
    avelength_vehicle_towed_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_towed_derived)),h.vehicle_towed_derived<>(typeof(h.vehicle_towed_derived))'');
    populated_unit_type_pcnt := AVE(GROUP,IF(h.unit_type = (TYPEOF(h.unit_type))'',0,100));
    maxlength_unit_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type)));
    avelength_unit_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type)),h.unit_type<>(typeof(h.unit_type))'');
    populated_unit_number_pcnt := AVE(GROUP,IF(h.unit_number = (TYPEOF(h.unit_number))'',0,100));
    maxlength_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_number)));
    avelength_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_number)),h.unit_number<>(typeof(h.unit_number))'');
    populated_registration_state_pcnt := AVE(GROUP,IF(h.registration_state = (TYPEOF(h.registration_state))'',0,100));
    maxlength_registration_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_state)));
    avelength_registration_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_state)),h.registration_state<>(typeof(h.registration_state))'');
    populated_registration_year_pcnt := AVE(GROUP,IF(h.registration_year = (TYPEOF(h.registration_year))'',0,100));
    maxlength_registration_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_year)));
    avelength_registration_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_year)),h.registration_year<>(typeof(h.registration_year))'');
    populated_license_plate_pcnt := AVE(GROUP,IF(h.license_plate = (TYPEOF(h.license_plate))'',0,100));
    maxlength_license_plate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.license_plate)));
    avelength_license_plate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.license_plate)),h.license_plate<>(typeof(h.license_plate))'');
    populated_make_pcnt := AVE(GROUP,IF(h.make = (TYPEOF(h.make))'',0,100));
    maxlength_make := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.make)));
    avelength_make := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.make)),h.make<>(typeof(h.make))'');
    populated_model_yr_pcnt := AVE(GROUP,IF(h.model_yr = (TYPEOF(h.model_yr))'',0,100));
    maxlength_model_yr := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_yr)));
    avelength_model_yr := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_yr)),h.model_yr<>(typeof(h.model_yr))'');
    populated_model_pcnt := AVE(GROUP,IF(h.model = (TYPEOF(h.model))'',0,100));
    maxlength_model := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model)));
    avelength_model := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model)),h.model<>(typeof(h.model))'');
    populated_body_type_category_pcnt := AVE(GROUP,IF(h.body_type_category = (TYPEOF(h.body_type_category))'',0,100));
    maxlength_body_type_category := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.body_type_category)));
    avelength_body_type_category := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.body_type_category)),h.body_type_category<>(typeof(h.body_type_category))'');
    populated_total_occupants_in_vehicle_pcnt := AVE(GROUP,IF(h.total_occupants_in_vehicle = (TYPEOF(h.total_occupants_in_vehicle))'',0,100));
    maxlength_total_occupants_in_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_occupants_in_vehicle)));
    avelength_total_occupants_in_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.total_occupants_in_vehicle)),h.total_occupants_in_vehicle<>(typeof(h.total_occupants_in_vehicle))'');
    populated_special_function_in_transport_pcnt := AVE(GROUP,IF(h.special_function_in_transport = (TYPEOF(h.special_function_in_transport))'',0,100));
    maxlength_special_function_in_transport := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_function_in_transport)));
    avelength_special_function_in_transport := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_function_in_transport)),h.special_function_in_transport<>(typeof(h.special_function_in_transport))'');
    populated_special_function_in_transport_other_unit_pcnt := AVE(GROUP,IF(h.special_function_in_transport_other_unit = (TYPEOF(h.special_function_in_transport_other_unit))'',0,100));
    maxlength_special_function_in_transport_other_unit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_function_in_transport_other_unit)));
    avelength_special_function_in_transport_other_unit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_function_in_transport_other_unit)),h.special_function_in_transport_other_unit<>(typeof(h.special_function_in_transport_other_unit))'');
    populated_emergency_use_pcnt := AVE(GROUP,IF(h.emergency_use = (TYPEOF(h.emergency_use))'',0,100));
    maxlength_emergency_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.emergency_use)));
    avelength_emergency_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.emergency_use)),h.emergency_use<>(typeof(h.emergency_use))'');
    populated_posted_satutory_speed_limit_pcnt := AVE(GROUP,IF(h.posted_satutory_speed_limit = (TYPEOF(h.posted_satutory_speed_limit))'',0,100));
    maxlength_posted_satutory_speed_limit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.posted_satutory_speed_limit)));
    avelength_posted_satutory_speed_limit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.posted_satutory_speed_limit)),h.posted_satutory_speed_limit<>(typeof(h.posted_satutory_speed_limit))'');
    populated_direction_of_travel_before_crash_pcnt := AVE(GROUP,IF(h.direction_of_travel_before_crash = (TYPEOF(h.direction_of_travel_before_crash))'',0,100));
    maxlength_direction_of_travel_before_crash := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_travel_before_crash)));
    avelength_direction_of_travel_before_crash := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_travel_before_crash)),h.direction_of_travel_before_crash<>(typeof(h.direction_of_travel_before_crash))'');
    populated_trafficway_description_pcnt := AVE(GROUP,IF(h.trafficway_description = (TYPEOF(h.trafficway_description))'',0,100));
    maxlength_trafficway_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trafficway_description)));
    avelength_trafficway_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trafficway_description)),h.trafficway_description<>(typeof(h.trafficway_description))'');
    populated_traffic_control_device_type_pcnt := AVE(GROUP,IF(h.traffic_control_device_type = (TYPEOF(h.traffic_control_device_type))'',0,100));
    maxlength_traffic_control_device_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_device_type)));
    avelength_traffic_control_device_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_device_type)),h.traffic_control_device_type<>(typeof(h.traffic_control_device_type))'');
    populated_vehicle_maneuver_action_prior1_pcnt := AVE(GROUP,IF(h.vehicle_maneuver_action_prior1 = (TYPEOF(h.vehicle_maneuver_action_prior1))'',0,100));
    maxlength_vehicle_maneuver_action_prior1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior1)));
    avelength_vehicle_maneuver_action_prior1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior1)),h.vehicle_maneuver_action_prior1<>(typeof(h.vehicle_maneuver_action_prior1))'');
    populated_vehicle_maneuver_action_prior2_pcnt := AVE(GROUP,IF(h.vehicle_maneuver_action_prior2 = (TYPEOF(h.vehicle_maneuver_action_prior2))'',0,100));
    maxlength_vehicle_maneuver_action_prior2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior2)));
    avelength_vehicle_maneuver_action_prior2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior2)),h.vehicle_maneuver_action_prior2<>(typeof(h.vehicle_maneuver_action_prior2))'');
    populated_impact_area1_pcnt := AVE(GROUP,IF(h.impact_area1 = (TYPEOF(h.impact_area1))'',0,100));
    maxlength_impact_area1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.impact_area1)));
    avelength_impact_area1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.impact_area1)),h.impact_area1<>(typeof(h.impact_area1))'');
    populated_impact_area2_pcnt := AVE(GROUP,IF(h.impact_area2 = (TYPEOF(h.impact_area2))'',0,100));
    maxlength_impact_area2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.impact_area2)));
    avelength_impact_area2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.impact_area2)),h.impact_area2<>(typeof(h.impact_area2))'');
    populated_event_sequence1_pcnt := AVE(GROUP,IF(h.event_sequence1 = (TYPEOF(h.event_sequence1))'',0,100));
    maxlength_event_sequence1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence1)));
    avelength_event_sequence1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence1)),h.event_sequence1<>(typeof(h.event_sequence1))'');
    populated_event_sequence2_pcnt := AVE(GROUP,IF(h.event_sequence2 = (TYPEOF(h.event_sequence2))'',0,100));
    maxlength_event_sequence2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence2)));
    avelength_event_sequence2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence2)),h.event_sequence2<>(typeof(h.event_sequence2))'');
    populated_event_sequence3_pcnt := AVE(GROUP,IF(h.event_sequence3 = (TYPEOF(h.event_sequence3))'',0,100));
    maxlength_event_sequence3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence3)));
    avelength_event_sequence3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence3)),h.event_sequence3<>(typeof(h.event_sequence3))'');
    populated_event_sequence4_pcnt := AVE(GROUP,IF(h.event_sequence4 = (TYPEOF(h.event_sequence4))'',0,100));
    maxlength_event_sequence4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence4)));
    avelength_event_sequence4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.event_sequence4)),h.event_sequence4<>(typeof(h.event_sequence4))'');
    populated_most_harmful_event_for_vehicle_pcnt := AVE(GROUP,IF(h.most_harmful_event_for_vehicle = (TYPEOF(h.most_harmful_event_for_vehicle))'',0,100));
    maxlength_most_harmful_event_for_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.most_harmful_event_for_vehicle)));
    avelength_most_harmful_event_for_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.most_harmful_event_for_vehicle)),h.most_harmful_event_for_vehicle<>(typeof(h.most_harmful_event_for_vehicle))'');
    populated_bus_use_pcnt := AVE(GROUP,IF(h.bus_use = (TYPEOF(h.bus_use))'',0,100));
    maxlength_bus_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bus_use)));
    avelength_bus_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bus_use)),h.bus_use<>(typeof(h.bus_use))'');
    populated_vehicle_hit_and_run_pcnt := AVE(GROUP,IF(h.vehicle_hit_and_run = (TYPEOF(h.vehicle_hit_and_run))'',0,100));
    maxlength_vehicle_hit_and_run := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_hit_and_run)));
    avelength_vehicle_hit_and_run := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_hit_and_run)),h.vehicle_hit_and_run<>(typeof(h.vehicle_hit_and_run))'');
    populated_vehicle_towed_pcnt := AVE(GROUP,IF(h.vehicle_towed = (TYPEOF(h.vehicle_towed))'',0,100));
    maxlength_vehicle_towed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_towed)));
    avelength_vehicle_towed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_towed)),h.vehicle_towed<>(typeof(h.vehicle_towed))'');
    populated_contributing_circumstances_v1_pcnt := AVE(GROUP,IF(h.contributing_circumstances_v1 = (TYPEOF(h.contributing_circumstances_v1))'',0,100));
    maxlength_contributing_circumstances_v1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v1)));
    avelength_contributing_circumstances_v1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v1)),h.contributing_circumstances_v1<>(typeof(h.contributing_circumstances_v1))'');
    populated_contributing_circumstances_v2_pcnt := AVE(GROUP,IF(h.contributing_circumstances_v2 = (TYPEOF(h.contributing_circumstances_v2))'',0,100));
    maxlength_contributing_circumstances_v2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v2)));
    avelength_contributing_circumstances_v2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v2)),h.contributing_circumstances_v2<>(typeof(h.contributing_circumstances_v2))'');
    populated_contributing_circumstances_v3_pcnt := AVE(GROUP,IF(h.contributing_circumstances_v3 = (TYPEOF(h.contributing_circumstances_v3))'',0,100));
    maxlength_contributing_circumstances_v3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v3)));
    avelength_contributing_circumstances_v3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v3)),h.contributing_circumstances_v3<>(typeof(h.contributing_circumstances_v3))'');
    populated_contributing_circumstances_v4_pcnt := AVE(GROUP,IF(h.contributing_circumstances_v4 = (TYPEOF(h.contributing_circumstances_v4))'',0,100));
    maxlength_contributing_circumstances_v4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v4)));
    avelength_contributing_circumstances_v4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_v4)),h.contributing_circumstances_v4<>(typeof(h.contributing_circumstances_v4))'');
    populated_on_street_pcnt := AVE(GROUP,IF(h.on_street = (TYPEOF(h.on_street))'',0,100));
    maxlength_on_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.on_street)));
    avelength_on_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.on_street)),h.on_street<>(typeof(h.on_street))'');
    populated_vehicle_color_pcnt := AVE(GROUP,IF(h.vehicle_color = (TYPEOF(h.vehicle_color))'',0,100));
    maxlength_vehicle_color := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_color)));
    avelength_vehicle_color := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_color)),h.vehicle_color<>(typeof(h.vehicle_color))'');
    populated_estimated_speed_pcnt := AVE(GROUP,IF(h.estimated_speed = (TYPEOF(h.estimated_speed))'',0,100));
    maxlength_estimated_speed := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.estimated_speed)));
    avelength_estimated_speed := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.estimated_speed)),h.estimated_speed<>(typeof(h.estimated_speed))'');
    populated_accident_investigation_site_pcnt := AVE(GROUP,IF(h.accident_investigation_site = (TYPEOF(h.accident_investigation_site))'',0,100));
    maxlength_accident_investigation_site := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_investigation_site)));
    avelength_accident_investigation_site := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_investigation_site)),h.accident_investigation_site<>(typeof(h.accident_investigation_site))'');
    populated_car_fire_pcnt := AVE(GROUP,IF(h.car_fire = (TYPEOF(h.car_fire))'',0,100));
    maxlength_car_fire := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.car_fire)));
    avelength_car_fire := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.car_fire)),h.car_fire<>(typeof(h.car_fire))'');
    populated_vehicle_damage_amount_pcnt := AVE(GROUP,IF(h.vehicle_damage_amount = (TYPEOF(h.vehicle_damage_amount))'',0,100));
    maxlength_vehicle_damage_amount := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_damage_amount)));
    avelength_vehicle_damage_amount := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_damage_amount)),h.vehicle_damage_amount<>(typeof(h.vehicle_damage_amount))'');
    populated_contributing_factors1_pcnt := AVE(GROUP,IF(h.contributing_factors1 = (TYPEOF(h.contributing_factors1))'',0,100));
    maxlength_contributing_factors1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors1)));
    avelength_contributing_factors1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors1)),h.contributing_factors1<>(typeof(h.contributing_factors1))'');
    populated_contributing_factors2_pcnt := AVE(GROUP,IF(h.contributing_factors2 = (TYPEOF(h.contributing_factors2))'',0,100));
    maxlength_contributing_factors2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors2)));
    avelength_contributing_factors2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors2)),h.contributing_factors2<>(typeof(h.contributing_factors2))'');
    populated_contributing_factors3_pcnt := AVE(GROUP,IF(h.contributing_factors3 = (TYPEOF(h.contributing_factors3))'',0,100));
    maxlength_contributing_factors3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors3)));
    avelength_contributing_factors3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors3)),h.contributing_factors3<>(typeof(h.contributing_factors3))'');
    populated_contributing_factors4_pcnt := AVE(GROUP,IF(h.contributing_factors4 = (TYPEOF(h.contributing_factors4))'',0,100));
    maxlength_contributing_factors4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors4)));
    avelength_contributing_factors4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_factors4)),h.contributing_factors4<>(typeof(h.contributing_factors4))'');
    populated_other_contributing_factors1_pcnt := AVE(GROUP,IF(h.other_contributing_factors1 = (TYPEOF(h.other_contributing_factors1))'',0,100));
    maxlength_other_contributing_factors1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors1)));
    avelength_other_contributing_factors1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors1)),h.other_contributing_factors1<>(typeof(h.other_contributing_factors1))'');
    populated_other_contributing_factors2_pcnt := AVE(GROUP,IF(h.other_contributing_factors2 = (TYPEOF(h.other_contributing_factors2))'',0,100));
    maxlength_other_contributing_factors2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors2)));
    avelength_other_contributing_factors2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors2)),h.other_contributing_factors2<>(typeof(h.other_contributing_factors2))'');
    populated_other_contributing_factors3_pcnt := AVE(GROUP,IF(h.other_contributing_factors3 = (TYPEOF(h.other_contributing_factors3))'',0,100));
    maxlength_other_contributing_factors3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors3)));
    avelength_other_contributing_factors3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_contributing_factors3)),h.other_contributing_factors3<>(typeof(h.other_contributing_factors3))'');
    populated_vision_obscured1_pcnt := AVE(GROUP,IF(h.vision_obscured1 = (TYPEOF(h.vision_obscured1))'',0,100));
    maxlength_vision_obscured1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured1)));
    avelength_vision_obscured1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured1)),h.vision_obscured1<>(typeof(h.vision_obscured1))'');
    populated_vision_obscured2_pcnt := AVE(GROUP,IF(h.vision_obscured2 = (TYPEOF(h.vision_obscured2))'',0,100));
    maxlength_vision_obscured2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured2)));
    avelength_vision_obscured2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured2)),h.vision_obscured2<>(typeof(h.vision_obscured2))'');
    populated_vehicle_on_road_pcnt := AVE(GROUP,IF(h.vehicle_on_road = (TYPEOF(h.vehicle_on_road))'',0,100));
    maxlength_vehicle_on_road := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_on_road)));
    avelength_vehicle_on_road := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_on_road)),h.vehicle_on_road<>(typeof(h.vehicle_on_road))'');
    populated_ran_off_road_pcnt := AVE(GROUP,IF(h.ran_off_road = (TYPEOF(h.ran_off_road))'',0,100));
    maxlength_ran_off_road := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ran_off_road)));
    avelength_ran_off_road := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ran_off_road)),h.ran_off_road<>(typeof(h.ran_off_road))'');
    populated_skidding_occurred_pcnt := AVE(GROUP,IF(h.skidding_occurred = (TYPEOF(h.skidding_occurred))'',0,100));
    maxlength_skidding_occurred := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.skidding_occurred)));
    avelength_skidding_occurred := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.skidding_occurred)),h.skidding_occurred<>(typeof(h.skidding_occurred))'');
    populated_vehicle_incident_location1_pcnt := AVE(GROUP,IF(h.vehicle_incident_location1 = (TYPEOF(h.vehicle_incident_location1))'',0,100));
    maxlength_vehicle_incident_location1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location1)));
    avelength_vehicle_incident_location1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location1)),h.vehicle_incident_location1<>(typeof(h.vehicle_incident_location1))'');
    populated_vehicle_incident_location2_pcnt := AVE(GROUP,IF(h.vehicle_incident_location2 = (TYPEOF(h.vehicle_incident_location2))'',0,100));
    maxlength_vehicle_incident_location2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location2)));
    avelength_vehicle_incident_location2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location2)),h.vehicle_incident_location2<>(typeof(h.vehicle_incident_location2))'');
    populated_vehicle_incident_location3_pcnt := AVE(GROUP,IF(h.vehicle_incident_location3 = (TYPEOF(h.vehicle_incident_location3))'',0,100));
    maxlength_vehicle_incident_location3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location3)));
    avelength_vehicle_incident_location3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_incident_location3)),h.vehicle_incident_location3<>(typeof(h.vehicle_incident_location3))'');
    populated_vehicle_disabled_pcnt := AVE(GROUP,IF(h.vehicle_disabled = (TYPEOF(h.vehicle_disabled))'',0,100));
    maxlength_vehicle_disabled := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_disabled)));
    avelength_vehicle_disabled := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_disabled)),h.vehicle_disabled<>(typeof(h.vehicle_disabled))'');
    populated_vehicle_removed_to_pcnt := AVE(GROUP,IF(h.vehicle_removed_to = (TYPEOF(h.vehicle_removed_to))'',0,100));
    maxlength_vehicle_removed_to := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_removed_to)));
    avelength_vehicle_removed_to := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_removed_to)),h.vehicle_removed_to<>(typeof(h.vehicle_removed_to))'');
    populated_removed_by_pcnt := AVE(GROUP,IF(h.removed_by = (TYPEOF(h.removed_by))'',0,100));
    maxlength_removed_by := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.removed_by)));
    avelength_removed_by := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.removed_by)),h.removed_by<>(typeof(h.removed_by))'');
    populated_tow_requested_by_driver_pcnt := AVE(GROUP,IF(h.tow_requested_by_driver = (TYPEOF(h.tow_requested_by_driver))'',0,100));
    maxlength_tow_requested_by_driver := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.tow_requested_by_driver)));
    avelength_tow_requested_by_driver := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.tow_requested_by_driver)),h.tow_requested_by_driver<>(typeof(h.tow_requested_by_driver))'');
    populated_solicitation_pcnt := AVE(GROUP,IF(h.solicitation = (TYPEOF(h.solicitation))'',0,100));
    maxlength_solicitation := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.solicitation)));
    avelength_solicitation := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.solicitation)),h.solicitation<>(typeof(h.solicitation))'');
    populated_other_unit_vehicle_damage_amount_pcnt := AVE(GROUP,IF(h.other_unit_vehicle_damage_amount = (TYPEOF(h.other_unit_vehicle_damage_amount))'',0,100));
    maxlength_other_unit_vehicle_damage_amount := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vehicle_damage_amount)));
    avelength_other_unit_vehicle_damage_amount := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vehicle_damage_amount)),h.other_unit_vehicle_damage_amount<>(typeof(h.other_unit_vehicle_damage_amount))'');
    populated_other_unit_model_year_pcnt := AVE(GROUP,IF(h.other_unit_model_year = (TYPEOF(h.other_unit_model_year))'',0,100));
    maxlength_other_unit_model_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year)));
    avelength_other_unit_model_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year)),h.other_unit_model_year<>(typeof(h.other_unit_model_year))'');
    populated_other_unit_make_pcnt := AVE(GROUP,IF(h.other_unit_make = (TYPEOF(h.other_unit_make))'',0,100));
    maxlength_other_unit_make := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make)));
    avelength_other_unit_make := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make)),h.other_unit_make<>(typeof(h.other_unit_make))'');
    populated_other_unit_model_pcnt := AVE(GROUP,IF(h.other_unit_model = (TYPEOF(h.other_unit_model))'',0,100));
    maxlength_other_unit_model := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model)));
    avelength_other_unit_model := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model)),h.other_unit_model<>(typeof(h.other_unit_model))'');
    populated_other_unit_vin_pcnt := AVE(GROUP,IF(h.other_unit_vin = (TYPEOF(h.other_unit_vin))'',0,100));
    maxlength_other_unit_vin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin)));
    avelength_other_unit_vin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin)),h.other_unit_vin<>(typeof(h.other_unit_vin))'');
    populated_other_unit_vin_status_pcnt := AVE(GROUP,IF(h.other_unit_vin_status = (TYPEOF(h.other_unit_vin_status))'',0,100));
    maxlength_other_unit_vin_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin_status)));
    avelength_other_unit_vin_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin_status)),h.other_unit_vin_status<>(typeof(h.other_unit_vin_status))'');
    populated_other_unit_body_type_category_pcnt := AVE(GROUP,IF(h.other_unit_body_type_category = (TYPEOF(h.other_unit_body_type_category))'',0,100));
    maxlength_other_unit_body_type_category := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_body_type_category)));
    avelength_other_unit_body_type_category := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_body_type_category)),h.other_unit_body_type_category<>(typeof(h.other_unit_body_type_category))'');
    populated_other_unit_registration_state_pcnt := AVE(GROUP,IF(h.other_unit_registration_state = (TYPEOF(h.other_unit_registration_state))'',0,100));
    maxlength_other_unit_registration_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state)));
    avelength_other_unit_registration_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state)),h.other_unit_registration_state<>(typeof(h.other_unit_registration_state))'');
    populated_other_unit_registration_year_pcnt := AVE(GROUP,IF(h.other_unit_registration_year = (TYPEOF(h.other_unit_registration_year))'',0,100));
    maxlength_other_unit_registration_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year)));
    avelength_other_unit_registration_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year)),h.other_unit_registration_year<>(typeof(h.other_unit_registration_year))'');
    populated_other_unit_license_plate_pcnt := AVE(GROUP,IF(h.other_unit_license_plate = (TYPEOF(h.other_unit_license_plate))'',0,100));
    maxlength_other_unit_license_plate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate)));
    avelength_other_unit_license_plate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate)),h.other_unit_license_plate<>(typeof(h.other_unit_license_plate))'');
    populated_other_unit_color_pcnt := AVE(GROUP,IF(h.other_unit_color = (TYPEOF(h.other_unit_color))'',0,100));
    maxlength_other_unit_color := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_color)));
    avelength_other_unit_color := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_color)),h.other_unit_color<>(typeof(h.other_unit_color))'');
    populated_other_unit_type_pcnt := AVE(GROUP,IF(h.other_unit_type = (TYPEOF(h.other_unit_type))'',0,100));
    maxlength_other_unit_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type)));
    avelength_other_unit_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type)),h.other_unit_type<>(typeof(h.other_unit_type))'');
    populated_damaged_areas1_pcnt := AVE(GROUP,IF(h.damaged_areas1 = (TYPEOF(h.damaged_areas1))'',0,100));
    maxlength_damaged_areas1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas1)));
    avelength_damaged_areas1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas1)),h.damaged_areas1<>(typeof(h.damaged_areas1))'');
    populated_damaged_areas2_pcnt := AVE(GROUP,IF(h.damaged_areas2 = (TYPEOF(h.damaged_areas2))'',0,100));
    maxlength_damaged_areas2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas2)));
    avelength_damaged_areas2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas2)),h.damaged_areas2<>(typeof(h.damaged_areas2))'');
    populated_parked_vehicle_pcnt := AVE(GROUP,IF(h.parked_vehicle = (TYPEOF(h.parked_vehicle))'',0,100));
    maxlength_parked_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.parked_vehicle)));
    avelength_parked_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.parked_vehicle)),h.parked_vehicle<>(typeof(h.parked_vehicle))'');
    populated_damage_rating1_pcnt := AVE(GROUP,IF(h.damage_rating1 = (TYPEOF(h.damage_rating1))'',0,100));
    maxlength_damage_rating1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_rating1)));
    avelength_damage_rating1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_rating1)),h.damage_rating1<>(typeof(h.damage_rating1))'');
    populated_damage_rating2_pcnt := AVE(GROUP,IF(h.damage_rating2 = (TYPEOF(h.damage_rating2))'',0,100));
    maxlength_damage_rating2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_rating2)));
    avelength_damage_rating2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_rating2)),h.damage_rating2<>(typeof(h.damage_rating2))'');
    populated_vehicle_inventoried_pcnt := AVE(GROUP,IF(h.vehicle_inventoried = (TYPEOF(h.vehicle_inventoried))'',0,100));
    maxlength_vehicle_inventoried := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_inventoried)));
    avelength_vehicle_inventoried := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_inventoried)),h.vehicle_inventoried<>(typeof(h.vehicle_inventoried))'');
    populated_vehicle_defect_apparent_pcnt := AVE(GROUP,IF(h.vehicle_defect_apparent = (TYPEOF(h.vehicle_defect_apparent))'',0,100));
    maxlength_vehicle_defect_apparent := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_defect_apparent)));
    avelength_vehicle_defect_apparent := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_defect_apparent)),h.vehicle_defect_apparent<>(typeof(h.vehicle_defect_apparent))'');
    populated_defect_may_have_contributed1_pcnt := AVE(GROUP,IF(h.defect_may_have_contributed1 = (TYPEOF(h.defect_may_have_contributed1))'',0,100));
    maxlength_defect_may_have_contributed1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.defect_may_have_contributed1)));
    avelength_defect_may_have_contributed1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.defect_may_have_contributed1)),h.defect_may_have_contributed1<>(typeof(h.defect_may_have_contributed1))'');
    populated_defect_may_have_contributed2_pcnt := AVE(GROUP,IF(h.defect_may_have_contributed2 = (TYPEOF(h.defect_may_have_contributed2))'',0,100));
    maxlength_defect_may_have_contributed2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.defect_may_have_contributed2)));
    avelength_defect_may_have_contributed2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.defect_may_have_contributed2)),h.defect_may_have_contributed2<>(typeof(h.defect_may_have_contributed2))'');
    populated_registration_expiration_pcnt := AVE(GROUP,IF(h.registration_expiration = (TYPEOF(h.registration_expiration))'',0,100));
    maxlength_registration_expiration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_expiration)));
    avelength_registration_expiration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registration_expiration)),h.registration_expiration<>(typeof(h.registration_expiration))'');
    populated_owner_driver_type_pcnt := AVE(GROUP,IF(h.owner_driver_type = (TYPEOF(h.owner_driver_type))'',0,100));
    maxlength_owner_driver_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.owner_driver_type)));
    avelength_owner_driver_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.owner_driver_type)),h.owner_driver_type<>(typeof(h.owner_driver_type))'');
    populated_make_code_pcnt := AVE(GROUP,IF(h.make_code = (TYPEOF(h.make_code))'',0,100));
    maxlength_make_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_code)));
    avelength_make_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_code)),h.make_code<>(typeof(h.make_code))'');
    populated_number_trailing_units_pcnt := AVE(GROUP,IF(h.number_trailing_units = (TYPEOF(h.number_trailing_units))'',0,100));
    maxlength_number_trailing_units := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_trailing_units)));
    avelength_number_trailing_units := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_trailing_units)),h.number_trailing_units<>(typeof(h.number_trailing_units))'');
    populated_vehicle_position_pcnt := AVE(GROUP,IF(h.vehicle_position = (TYPEOF(h.vehicle_position))'',0,100));
    maxlength_vehicle_position := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_position)));
    avelength_vehicle_position := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_position)),h.vehicle_position<>(typeof(h.vehicle_position))'');
    populated_vehicle_type_pcnt := AVE(GROUP,IF(h.vehicle_type = (TYPEOF(h.vehicle_type))'',0,100));
    maxlength_vehicle_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type)));
    avelength_vehicle_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type)),h.vehicle_type<>(typeof(h.vehicle_type))'');
    populated_motorcycle_engine_size_pcnt := AVE(GROUP,IF(h.motorcycle_engine_size = (TYPEOF(h.motorcycle_engine_size))'',0,100));
    maxlength_motorcycle_engine_size := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_engine_size)));
    avelength_motorcycle_engine_size := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_engine_size)),h.motorcycle_engine_size<>(typeof(h.motorcycle_engine_size))'');
    populated_motorcycle_driver_educated_pcnt := AVE(GROUP,IF(h.motorcycle_driver_educated = (TYPEOF(h.motorcycle_driver_educated))'',0,100));
    maxlength_motorcycle_driver_educated := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_driver_educated)));
    avelength_motorcycle_driver_educated := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_driver_educated)),h.motorcycle_driver_educated<>(typeof(h.motorcycle_driver_educated))'');
    populated_motorcycle_helmet_type_pcnt := AVE(GROUP,IF(h.motorcycle_helmet_type = (TYPEOF(h.motorcycle_helmet_type))'',0,100));
    maxlength_motorcycle_helmet_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_type)));
    avelength_motorcycle_helmet_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_type)),h.motorcycle_helmet_type<>(typeof(h.motorcycle_helmet_type))'');
    populated_motorcycle_passenger_pcnt := AVE(GROUP,IF(h.motorcycle_passenger = (TYPEOF(h.motorcycle_passenger))'',0,100));
    maxlength_motorcycle_passenger := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_passenger)));
    avelength_motorcycle_passenger := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_passenger)),h.motorcycle_passenger<>(typeof(h.motorcycle_passenger))'');
    populated_motorcycle_helmet_stayed_on_pcnt := AVE(GROUP,IF(h.motorcycle_helmet_stayed_on = (TYPEOF(h.motorcycle_helmet_stayed_on))'',0,100));
    maxlength_motorcycle_helmet_stayed_on := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_stayed_on)));
    avelength_motorcycle_helmet_stayed_on := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_stayed_on)),h.motorcycle_helmet_stayed_on<>(typeof(h.motorcycle_helmet_stayed_on))'');
    populated_motorcycle_helmet_dot_snell_pcnt := AVE(GROUP,IF(h.motorcycle_helmet_dot_snell = (TYPEOF(h.motorcycle_helmet_dot_snell))'',0,100));
    maxlength_motorcycle_helmet_dot_snell := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_dot_snell)));
    avelength_motorcycle_helmet_dot_snell := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_helmet_dot_snell)),h.motorcycle_helmet_dot_snell<>(typeof(h.motorcycle_helmet_dot_snell))'');
    populated_motorcycle_saddlebag_trunk_pcnt := AVE(GROUP,IF(h.motorcycle_saddlebag_trunk = (TYPEOF(h.motorcycle_saddlebag_trunk))'',0,100));
    maxlength_motorcycle_saddlebag_trunk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_saddlebag_trunk)));
    avelength_motorcycle_saddlebag_trunk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_saddlebag_trunk)),h.motorcycle_saddlebag_trunk<>(typeof(h.motorcycle_saddlebag_trunk))'');
    populated_motorcycle_trailer_pcnt := AVE(GROUP,IF(h.motorcycle_trailer = (TYPEOF(h.motorcycle_trailer))'',0,100));
    maxlength_motorcycle_trailer := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_trailer)));
    avelength_motorcycle_trailer := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.motorcycle_trailer)),h.motorcycle_trailer<>(typeof(h.motorcycle_trailer))'');
    populated_pedacycle_passenger_pcnt := AVE(GROUP,IF(h.pedacycle_passenger = (TYPEOF(h.pedacycle_passenger))'',0,100));
    maxlength_pedacycle_passenger := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_passenger)));
    avelength_pedacycle_passenger := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_passenger)),h.pedacycle_passenger<>(typeof(h.pedacycle_passenger))'');
    populated_pedacycle_headlights_pcnt := AVE(GROUP,IF(h.pedacycle_headlights = (TYPEOF(h.pedacycle_headlights))'',0,100));
    maxlength_pedacycle_headlights := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_headlights)));
    avelength_pedacycle_headlights := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_headlights)),h.pedacycle_headlights<>(typeof(h.pedacycle_headlights))'');
    populated_pedacycle_helmet_pcnt := AVE(GROUP,IF(h.pedacycle_helmet = (TYPEOF(h.pedacycle_helmet))'',0,100));
    maxlength_pedacycle_helmet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_helmet)));
    avelength_pedacycle_helmet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_helmet)),h.pedacycle_helmet<>(typeof(h.pedacycle_helmet))'');
    populated_pedacycle_rear_reflectors_pcnt := AVE(GROUP,IF(h.pedacycle_rear_reflectors = (TYPEOF(h.pedacycle_rear_reflectors))'',0,100));
    maxlength_pedacycle_rear_reflectors := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_rear_reflectors)));
    avelength_pedacycle_rear_reflectors := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.pedacycle_rear_reflectors)),h.pedacycle_rear_reflectors<>(typeof(h.pedacycle_rear_reflectors))'');
    populated_cdl_required_pcnt := AVE(GROUP,IF(h.cdl_required = (TYPEOF(h.cdl_required))'',0,100));
    maxlength_cdl_required := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cdl_required)));
    avelength_cdl_required := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cdl_required)),h.cdl_required<>(typeof(h.cdl_required))'');
    populated_truck_bus_supplement_required_pcnt := AVE(GROUP,IF(h.truck_bus_supplement_required = (TYPEOF(h.truck_bus_supplement_required))'',0,100));
    maxlength_truck_bus_supplement_required := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.truck_bus_supplement_required)));
    avelength_truck_bus_supplement_required := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.truck_bus_supplement_required)),h.truck_bus_supplement_required<>(typeof(h.truck_bus_supplement_required))'');
    populated_unit_damage_amount_pcnt := AVE(GROUP,IF(h.unit_damage_amount = (TYPEOF(h.unit_damage_amount))'',0,100));
    maxlength_unit_damage_amount := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_damage_amount)));
    avelength_unit_damage_amount := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_damage_amount)),h.unit_damage_amount<>(typeof(h.unit_damage_amount))'');
    populated_airbag_switch_pcnt := AVE(GROUP,IF(h.airbag_switch = (TYPEOF(h.airbag_switch))'',0,100));
    maxlength_airbag_switch := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.airbag_switch)));
    avelength_airbag_switch := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.airbag_switch)),h.airbag_switch<>(typeof(h.airbag_switch))'');
    populated_underride_override_damage_pcnt := AVE(GROUP,IF(h.underride_override_damage = (TYPEOF(h.underride_override_damage))'',0,100));
    maxlength_underride_override_damage := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.underride_override_damage)));
    avelength_underride_override_damage := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.underride_override_damage)),h.underride_override_damage<>(typeof(h.underride_override_damage))'');
    populated_vehicle_attachment_pcnt := AVE(GROUP,IF(h.vehicle_attachment = (TYPEOF(h.vehicle_attachment))'',0,100));
    maxlength_vehicle_attachment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_attachment)));
    avelength_vehicle_attachment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_attachment)),h.vehicle_attachment<>(typeof(h.vehicle_attachment))'');
    populated_action_on_impact_pcnt := AVE(GROUP,IF(h.action_on_impact = (TYPEOF(h.action_on_impact))'',0,100));
    maxlength_action_on_impact := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.action_on_impact)));
    avelength_action_on_impact := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.action_on_impact)),h.action_on_impact<>(typeof(h.action_on_impact))'');
    populated_speed_detection_method_pcnt := AVE(GROUP,IF(h.speed_detection_method = (TYPEOF(h.speed_detection_method))'',0,100));
    maxlength_speed_detection_method := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.speed_detection_method)));
    avelength_speed_detection_method := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.speed_detection_method)),h.speed_detection_method<>(typeof(h.speed_detection_method))'');
    populated_non_motorist_direction_of_travel_from_pcnt := AVE(GROUP,IF(h.non_motorist_direction_of_travel_from = (TYPEOF(h.non_motorist_direction_of_travel_from))'',0,100));
    maxlength_non_motorist_direction_of_travel_from := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_direction_of_travel_from)));
    avelength_non_motorist_direction_of_travel_from := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_direction_of_travel_from)),h.non_motorist_direction_of_travel_from<>(typeof(h.non_motorist_direction_of_travel_from))'');
    populated_non_motorist_direction_of_travel_to_pcnt := AVE(GROUP,IF(h.non_motorist_direction_of_travel_to = (TYPEOF(h.non_motorist_direction_of_travel_to))'',0,100));
    maxlength_non_motorist_direction_of_travel_to := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_direction_of_travel_to)));
    avelength_non_motorist_direction_of_travel_to := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_direction_of_travel_to)),h.non_motorist_direction_of_travel_to<>(typeof(h.non_motorist_direction_of_travel_to))'');
    populated_vehicle_use_pcnt := AVE(GROUP,IF(h.vehicle_use = (TYPEOF(h.vehicle_use))'',0,100));
    maxlength_vehicle_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_use)));
    avelength_vehicle_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_use)),h.vehicle_use<>(typeof(h.vehicle_use))'');
    populated_department_unit_number_pcnt := AVE(GROUP,IF(h.department_unit_number = (TYPEOF(h.department_unit_number))'',0,100));
    maxlength_department_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.department_unit_number)));
    avelength_department_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.department_unit_number)),h.department_unit_number<>(typeof(h.department_unit_number))'');
    populated_equipment_in_use_at_time_of_accident_pcnt := AVE(GROUP,IF(h.equipment_in_use_at_time_of_accident = (TYPEOF(h.equipment_in_use_at_time_of_accident))'',0,100));
    maxlength_equipment_in_use_at_time_of_accident := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.equipment_in_use_at_time_of_accident)));
    avelength_equipment_in_use_at_time_of_accident := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.equipment_in_use_at_time_of_accident)),h.equipment_in_use_at_time_of_accident<>(typeof(h.equipment_in_use_at_time_of_accident))'');
    populated_actions_of_police_vehicle_pcnt := AVE(GROUP,IF(h.actions_of_police_vehicle = (TYPEOF(h.actions_of_police_vehicle))'',0,100));
    maxlength_actions_of_police_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.actions_of_police_vehicle)));
    avelength_actions_of_police_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.actions_of_police_vehicle)),h.actions_of_police_vehicle<>(typeof(h.actions_of_police_vehicle))'');
    populated_vehicle_command_id_pcnt := AVE(GROUP,IF(h.vehicle_command_id = (TYPEOF(h.vehicle_command_id))'',0,100));
    maxlength_vehicle_command_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_command_id)));
    avelength_vehicle_command_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_command_id)),h.vehicle_command_id<>(typeof(h.vehicle_command_id))'');
    populated_traffic_control_device_inoperative_pcnt := AVE(GROUP,IF(h.traffic_control_device_inoperative = (TYPEOF(h.traffic_control_device_inoperative))'',0,100));
    maxlength_traffic_control_device_inoperative := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_device_inoperative)));
    avelength_traffic_control_device_inoperative := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_device_inoperative)),h.traffic_control_device_inoperative<>(typeof(h.traffic_control_device_inoperative))'');
    populated_direction_of_impact1_pcnt := AVE(GROUP,IF(h.direction_of_impact1 = (TYPEOF(h.direction_of_impact1))'',0,100));
    maxlength_direction_of_impact1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_impact1)));
    avelength_direction_of_impact1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_impact1)),h.direction_of_impact1<>(typeof(h.direction_of_impact1))'');
    populated_direction_of_impact2_pcnt := AVE(GROUP,IF(h.direction_of_impact2 = (TYPEOF(h.direction_of_impact2))'',0,100));
    maxlength_direction_of_impact2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_impact2)));
    avelength_direction_of_impact2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.direction_of_impact2)),h.direction_of_impact2<>(typeof(h.direction_of_impact2))'');
    populated_ran_off_road_direction_pcnt := AVE(GROUP,IF(h.ran_off_road_direction = (TYPEOF(h.ran_off_road_direction))'',0,100));
    maxlength_ran_off_road_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ran_off_road_direction)));
    avelength_ran_off_road_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ran_off_road_direction)),h.ran_off_road_direction<>(typeof(h.ran_off_road_direction))'');
    populated_vin_other_unit_number_pcnt := AVE(GROUP,IF(h.vin_other_unit_number = (TYPEOF(h.vin_other_unit_number))'',0,100));
    maxlength_vin_other_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_other_unit_number)));
    avelength_vin_other_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_other_unit_number)),h.vin_other_unit_number<>(typeof(h.vin_other_unit_number))'');
    populated_damaged_area_generic_pcnt := AVE(GROUP,IF(h.damaged_area_generic = (TYPEOF(h.damaged_area_generic))'',0,100));
    maxlength_damaged_area_generic := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_area_generic)));
    avelength_damaged_area_generic := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_area_generic)),h.damaged_area_generic<>(typeof(h.damaged_area_generic))'');
    populated_vision_obscured_description_pcnt := AVE(GROUP,IF(h.vision_obscured_description = (TYPEOF(h.vision_obscured_description))'',0,100));
    maxlength_vision_obscured_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured_description)));
    avelength_vision_obscured_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vision_obscured_description)),h.vision_obscured_description<>(typeof(h.vision_obscured_description))'');
    populated_inattention_description_pcnt := AVE(GROUP,IF(h.inattention_description = (TYPEOF(h.inattention_description))'',0,100));
    maxlength_inattention_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.inattention_description)));
    avelength_inattention_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.inattention_description)),h.inattention_description<>(typeof(h.inattention_description))'');
    populated_contributing_circumstances_defect_description_pcnt := AVE(GROUP,IF(h.contributing_circumstances_defect_description = (TYPEOF(h.contributing_circumstances_defect_description))'',0,100));
    maxlength_contributing_circumstances_defect_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_defect_description)));
    avelength_contributing_circumstances_defect_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_defect_description)),h.contributing_circumstances_defect_description<>(typeof(h.contributing_circumstances_defect_description))'');
    populated_contributing_circumstances_other_descriptioin_pcnt := AVE(GROUP,IF(h.contributing_circumstances_other_descriptioin = (TYPEOF(h.contributing_circumstances_other_descriptioin))'',0,100));
    maxlength_contributing_circumstances_other_descriptioin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_other_descriptioin)));
    avelength_contributing_circumstances_other_descriptioin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.contributing_circumstances_other_descriptioin)),h.contributing_circumstances_other_descriptioin<>(typeof(h.contributing_circumstances_other_descriptioin))'');
    populated_vehicle_maneuver_action_prior_other_description_pcnt := AVE(GROUP,IF(h.vehicle_maneuver_action_prior_other_description = (TYPEOF(h.vehicle_maneuver_action_prior_other_description))'',0,100));
    maxlength_vehicle_maneuver_action_prior_other_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior_other_description)));
    avelength_vehicle_maneuver_action_prior_other_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_maneuver_action_prior_other_description)),h.vehicle_maneuver_action_prior_other_description<>(typeof(h.vehicle_maneuver_action_prior_other_description))'');
    populated_vehicle_special_use_pcnt := AVE(GROUP,IF(h.vehicle_special_use = (TYPEOF(h.vehicle_special_use))'',0,100));
    maxlength_vehicle_special_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_special_use)));
    avelength_vehicle_special_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_special_use)),h.vehicle_special_use<>(typeof(h.vehicle_special_use))'');
    populated_vehicle_type_extended1_pcnt := AVE(GROUP,IF(h.vehicle_type_extended1 = (TYPEOF(h.vehicle_type_extended1))'',0,100));
    maxlength_vehicle_type_extended1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_extended1)));
    avelength_vehicle_type_extended1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_extended1)),h.vehicle_type_extended1<>(typeof(h.vehicle_type_extended1))'');
    populated_vehicle_type_extended2_pcnt := AVE(GROUP,IF(h.vehicle_type_extended2 = (TYPEOF(h.vehicle_type_extended2))'',0,100));
    maxlength_vehicle_type_extended2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_extended2)));
    avelength_vehicle_type_extended2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_type_extended2)),h.vehicle_type_extended2<>(typeof(h.vehicle_type_extended2))'');
    populated_fixed_object_direction1_pcnt := AVE(GROUP,IF(h.fixed_object_direction1 = (TYPEOF(h.fixed_object_direction1))'',0,100));
    maxlength_fixed_object_direction1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction1)));
    avelength_fixed_object_direction1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction1)),h.fixed_object_direction1<>(typeof(h.fixed_object_direction1))'');
    populated_fixed_object_direction2_pcnt := AVE(GROUP,IF(h.fixed_object_direction2 = (TYPEOF(h.fixed_object_direction2))'',0,100));
    maxlength_fixed_object_direction2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction2)));
    avelength_fixed_object_direction2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction2)),h.fixed_object_direction2<>(typeof(h.fixed_object_direction2))'');
    populated_fixed_object_direction3_pcnt := AVE(GROUP,IF(h.fixed_object_direction3 = (TYPEOF(h.fixed_object_direction3))'',0,100));
    maxlength_fixed_object_direction3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction3)));
    avelength_fixed_object_direction3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction3)),h.fixed_object_direction3<>(typeof(h.fixed_object_direction3))'');
    populated_fixed_object_direction4_pcnt := AVE(GROUP,IF(h.fixed_object_direction4 = (TYPEOF(h.fixed_object_direction4))'',0,100));
    maxlength_fixed_object_direction4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction4)));
    avelength_fixed_object_direction4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fixed_object_direction4)),h.fixed_object_direction4<>(typeof(h.fixed_object_direction4))'');
    populated_vehicle_left_at_scene_pcnt := AVE(GROUP,IF(h.vehicle_left_at_scene = (TYPEOF(h.vehicle_left_at_scene))'',0,100));
    maxlength_vehicle_left_at_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_left_at_scene)));
    avelength_vehicle_left_at_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_left_at_scene)),h.vehicle_left_at_scene<>(typeof(h.vehicle_left_at_scene))'');
    populated_vehicle_impounded_pcnt := AVE(GROUP,IF(h.vehicle_impounded = (TYPEOF(h.vehicle_impounded))'',0,100));
    maxlength_vehicle_impounded := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_impounded)));
    avelength_vehicle_impounded := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_impounded)),h.vehicle_impounded<>(typeof(h.vehicle_impounded))'');
    populated_vehicle_driven_from_scene_pcnt := AVE(GROUP,IF(h.vehicle_driven_from_scene = (TYPEOF(h.vehicle_driven_from_scene))'',0,100));
    maxlength_vehicle_driven_from_scene := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_driven_from_scene)));
    avelength_vehicle_driven_from_scene := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_driven_from_scene)),h.vehicle_driven_from_scene<>(typeof(h.vehicle_driven_from_scene))'');
    populated_on_cross_street_pcnt := AVE(GROUP,IF(h.on_cross_street = (TYPEOF(h.on_cross_street))'',0,100));
    maxlength_on_cross_street := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.on_cross_street)));
    avelength_on_cross_street := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.on_cross_street)),h.on_cross_street<>(typeof(h.on_cross_street))'');
    populated_actions_of_police_vehicle_description_pcnt := AVE(GROUP,IF(h.actions_of_police_vehicle_description = (TYPEOF(h.actions_of_police_vehicle_description))'',0,100));
    maxlength_actions_of_police_vehicle_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.actions_of_police_vehicle_description)));
    avelength_actions_of_police_vehicle_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.actions_of_police_vehicle_description)),h.actions_of_police_vehicle_description<>(typeof(h.actions_of_police_vehicle_description))'');
    populated_vehicle_seg_pcnt := AVE(GROUP,IF(h.vehicle_seg = (TYPEOF(h.vehicle_seg))'',0,100));
    maxlength_vehicle_seg := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_seg)));
    avelength_vehicle_seg := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_seg)),h.vehicle_seg<>(typeof(h.vehicle_seg))'');
    populated_vehicle_seg_type_pcnt := AVE(GROUP,IF(h.vehicle_seg_type = (TYPEOF(h.vehicle_seg_type))'',0,100));
    maxlength_vehicle_seg_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_seg_type)));
    avelength_vehicle_seg_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_seg_type)),h.vehicle_seg_type<>(typeof(h.vehicle_seg_type))'');
    populated_model_year_pcnt := AVE(GROUP,IF(h.model_year = (TYPEOF(h.model_year))'',0,100));
    maxlength_model_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year)));
    avelength_model_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year)),h.model_year<>(typeof(h.model_year))'');
    populated_body_style_code_pcnt := AVE(GROUP,IF(h.body_style_code = (TYPEOF(h.body_style_code))'',0,100));
    maxlength_body_style_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.body_style_code)));
    avelength_body_style_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.body_style_code)),h.body_style_code<>(typeof(h.body_style_code))'');
    populated_engine_size_pcnt := AVE(GROUP,IF(h.engine_size = (TYPEOF(h.engine_size))'',0,100));
    maxlength_engine_size := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_size)));
    avelength_engine_size := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.engine_size)),h.engine_size<>(typeof(h.engine_size))'');
    populated_fuel_code_pcnt := AVE(GROUP,IF(h.fuel_code = (TYPEOF(h.fuel_code))'',0,100));
    maxlength_fuel_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_code)));
    avelength_fuel_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fuel_code)),h.fuel_code<>(typeof(h.fuel_code))'');
    populated_number_of_driving_wheels_pcnt := AVE(GROUP,IF(h.number_of_driving_wheels = (TYPEOF(h.number_of_driving_wheels))'',0,100));
    maxlength_number_of_driving_wheels := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_driving_wheels)));
    avelength_number_of_driving_wheels := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_driving_wheels)),h.number_of_driving_wheels<>(typeof(h.number_of_driving_wheels))'');
    populated_steering_type_pcnt := AVE(GROUP,IF(h.steering_type = (TYPEOF(h.steering_type))'',0,100));
    maxlength_steering_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.steering_type)));
    avelength_steering_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.steering_type)),h.steering_type<>(typeof(h.steering_type))'');
    populated_vina_series_pcnt := AVE(GROUP,IF(h.vina_series = (TYPEOF(h.vina_series))'',0,100));
    maxlength_vina_series := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_series)));
    avelength_vina_series := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_series)),h.vina_series<>(typeof(h.vina_series))'');
    populated_vina_model_pcnt := AVE(GROUP,IF(h.vina_model = (TYPEOF(h.vina_model))'',0,100));
    maxlength_vina_model := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_model)));
    avelength_vina_model := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_model)),h.vina_model<>(typeof(h.vina_model))'');
    populated_vina_make_pcnt := AVE(GROUP,IF(h.vina_make = (TYPEOF(h.vina_make))'',0,100));
    maxlength_vina_make := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_make)));
    avelength_vina_make := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_make)),h.vina_make<>(typeof(h.vina_make))'');
    populated_vina_body_style_pcnt := AVE(GROUP,IF(h.vina_body_style = (TYPEOF(h.vina_body_style))'',0,100));
    maxlength_vina_body_style := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_body_style)));
    avelength_vina_body_style := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vina_body_style)),h.vina_body_style<>(typeof(h.vina_body_style))'');
    populated_make_description_pcnt := AVE(GROUP,IF(h.make_description = (TYPEOF(h.make_description))'',0,100));
    maxlength_make_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_description)));
    avelength_make_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_description)),h.make_description<>(typeof(h.make_description))'');
    populated_model_description_pcnt := AVE(GROUP,IF(h.model_description = (TYPEOF(h.model_description))'',0,100));
    maxlength_model_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_description)));
    avelength_model_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_description)),h.model_description<>(typeof(h.model_description))'');
    populated_series_description_pcnt := AVE(GROUP,IF(h.series_description = (TYPEOF(h.series_description))'',0,100));
    maxlength_series_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.series_description)));
    avelength_series_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.series_description)),h.series_description<>(typeof(h.series_description))'');
    populated_car_cylinders_pcnt := AVE(GROUP,IF(h.car_cylinders = (TYPEOF(h.car_cylinders))'',0,100));
    maxlength_car_cylinders := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.car_cylinders)));
    avelength_car_cylinders := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.car_cylinders)),h.car_cylinders<>(typeof(h.car_cylinders))'');
    populated_other_vehicle_seg_pcnt := AVE(GROUP,IF(h.other_vehicle_seg = (TYPEOF(h.other_vehicle_seg))'',0,100));
    maxlength_other_vehicle_seg := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vehicle_seg)));
    avelength_other_vehicle_seg := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vehicle_seg)),h.other_vehicle_seg<>(typeof(h.other_vehicle_seg))'');
    populated_other_vehicle_seg_type_pcnt := AVE(GROUP,IF(h.other_vehicle_seg_type = (TYPEOF(h.other_vehicle_seg_type))'',0,100));
    maxlength_other_vehicle_seg_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vehicle_seg_type)));
    avelength_other_vehicle_seg_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vehicle_seg_type)),h.other_vehicle_seg_type<>(typeof(h.other_vehicle_seg_type))'');
    populated_other_model_year_pcnt := AVE(GROUP,IF(h.other_model_year = (TYPEOF(h.other_model_year))'',0,100));
    maxlength_other_model_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_model_year)));
    avelength_other_model_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_model_year)),h.other_model_year<>(typeof(h.other_model_year))'');
    populated_other_body_style_code_pcnt := AVE(GROUP,IF(h.other_body_style_code = (TYPEOF(h.other_body_style_code))'',0,100));
    maxlength_other_body_style_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_body_style_code)));
    avelength_other_body_style_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_body_style_code)),h.other_body_style_code<>(typeof(h.other_body_style_code))'');
    populated_other_engine_size_pcnt := AVE(GROUP,IF(h.other_engine_size = (TYPEOF(h.other_engine_size))'',0,100));
    maxlength_other_engine_size := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_engine_size)));
    avelength_other_engine_size := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_engine_size)),h.other_engine_size<>(typeof(h.other_engine_size))'');
    populated_other_fuel_code_pcnt := AVE(GROUP,IF(h.other_fuel_code = (TYPEOF(h.other_fuel_code))'',0,100));
    maxlength_other_fuel_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_fuel_code)));
    avelength_other_fuel_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_fuel_code)),h.other_fuel_code<>(typeof(h.other_fuel_code))'');
    populated_other_number_of_driving_wheels_pcnt := AVE(GROUP,IF(h.other_number_of_driving_wheels = (TYPEOF(h.other_number_of_driving_wheels))'',0,100));
    maxlength_other_number_of_driving_wheels := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_number_of_driving_wheels)));
    avelength_other_number_of_driving_wheels := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_number_of_driving_wheels)),h.other_number_of_driving_wheels<>(typeof(h.other_number_of_driving_wheels))'');
    populated_other_steering_type_pcnt := AVE(GROUP,IF(h.other_steering_type = (TYPEOF(h.other_steering_type))'',0,100));
    maxlength_other_steering_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_steering_type)));
    avelength_other_steering_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_steering_type)),h.other_steering_type<>(typeof(h.other_steering_type))'');
    populated_other_vina_series_pcnt := AVE(GROUP,IF(h.other_vina_series = (TYPEOF(h.other_vina_series))'',0,100));
    maxlength_other_vina_series := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_series)));
    avelength_other_vina_series := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_series)),h.other_vina_series<>(typeof(h.other_vina_series))'');
    populated_other_vina_model_pcnt := AVE(GROUP,IF(h.other_vina_model = (TYPEOF(h.other_vina_model))'',0,100));
    maxlength_other_vina_model := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_model)));
    avelength_other_vina_model := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_model)),h.other_vina_model<>(typeof(h.other_vina_model))'');
    populated_other_vina_make_pcnt := AVE(GROUP,IF(h.other_vina_make = (TYPEOF(h.other_vina_make))'',0,100));
    maxlength_other_vina_make := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_make)));
    avelength_other_vina_make := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_make)),h.other_vina_make<>(typeof(h.other_vina_make))'');
    populated_other_vina_body_style_pcnt := AVE(GROUP,IF(h.other_vina_body_style = (TYPEOF(h.other_vina_body_style))'',0,100));
    maxlength_other_vina_body_style := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_body_style)));
    avelength_other_vina_body_style := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_vina_body_style)),h.other_vina_body_style<>(typeof(h.other_vina_body_style))'');
    populated_other_make_description_pcnt := AVE(GROUP,IF(h.other_make_description = (TYPEOF(h.other_make_description))'',0,100));
    maxlength_other_make_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_make_description)));
    avelength_other_make_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_make_description)),h.other_make_description<>(typeof(h.other_make_description))'');
    populated_other_model_description_pcnt := AVE(GROUP,IF(h.other_model_description = (TYPEOF(h.other_model_description))'',0,100));
    maxlength_other_model_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_model_description)));
    avelength_other_model_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_model_description)),h.other_model_description<>(typeof(h.other_model_description))'');
    populated_other_series_description_pcnt := AVE(GROUP,IF(h.other_series_description = (TYPEOF(h.other_series_description))'',0,100));
    maxlength_other_series_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_series_description)));
    avelength_other_series_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_series_description)),h.other_series_description<>(typeof(h.other_series_description))'');
    populated_other_car_cylinders_pcnt := AVE(GROUP,IF(h.other_car_cylinders = (TYPEOF(h.other_car_cylinders))'',0,100));
    maxlength_other_car_cylinders := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_car_cylinders)));
    avelength_other_car_cylinders := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_car_cylinders)),h.other_car_cylinders<>(typeof(h.other_car_cylinders))'');
    populated_report_has_coversheet_pcnt := AVE(GROUP,IF(h.report_has_coversheet = (TYPEOF(h.report_has_coversheet))'',0,100));
    maxlength_report_has_coversheet := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_has_coversheet)));
    avelength_report_has_coversheet := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_has_coversheet)),h.report_has_coversheet<>(typeof(h.report_has_coversheet))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_z5_pcnt := AVE(GROUP,IF(h.z5 = (TYPEOF(h.z5))'',0,100));
    maxlength_z5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.z5)));
    avelength_z5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.z5)),h.z5<>(typeof(h.z5))'');
    populated_z4_pcnt := AVE(GROUP,IF(h.z4 = (TYPEOF(h.z4))'',0,100));
    maxlength_z4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.z4)));
    avelength_z4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.z4)),h.z4<>(typeof(h.z4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_code_pcnt := AVE(GROUP,IF(h.county_code = (TYPEOF(h.county_code))'',0,100));
    maxlength_county_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_code)));
    avelength_county_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county_code)),h.county_code<>(typeof(h.county_code))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_nametype_pcnt := AVE(GROUP,IF(h.nametype = (TYPEOF(h.nametype))'',0,100));
    maxlength_nametype := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.nametype)));
    avelength_nametype := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.nametype)),h.nametype<>(typeof(h.nametype))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_title2_pcnt := AVE(GROUP,IF(h.title2 = (TYPEOF(h.title2))'',0,100));
    maxlength_title2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title2)));
    avelength_title2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title2)),h.title2<>(typeof(h.title2))'');
    populated_fname2_pcnt := AVE(GROUP,IF(h.fname2 = (TYPEOF(h.fname2))'',0,100));
    maxlength_fname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname2)));
    avelength_fname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname2)),h.fname2<>(typeof(h.fname2))'');
    populated_mname2_pcnt := AVE(GROUP,IF(h.mname2 = (TYPEOF(h.mname2))'',0,100));
    maxlength_mname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname2)));
    avelength_mname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname2)),h.mname2<>(typeof(h.mname2))'');
    populated_lname2_pcnt := AVE(GROUP,IF(h.lname2 = (TYPEOF(h.lname2))'',0,100));
    maxlength_lname2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname2)));
    avelength_lname2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname2)),h.lname2<>(typeof(h.lname2))'');
    populated_suffix2_pcnt := AVE(GROUP,IF(h.suffix2 = (TYPEOF(h.suffix2))'',0,100));
    maxlength_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix2)));
    avelength_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.suffix2)),h.suffix2<>(typeof(h.suffix2))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_law_enforcement_suspects_alcohol_use1_pcnt := AVE(GROUP,IF(h.law_enforcement_suspects_alcohol_use1 = (TYPEOF(h.law_enforcement_suspects_alcohol_use1))'',0,100));
    maxlength_law_enforcement_suspects_alcohol_use1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_alcohol_use1)));
    avelength_law_enforcement_suspects_alcohol_use1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_alcohol_use1)),h.law_enforcement_suspects_alcohol_use1<>(typeof(h.law_enforcement_suspects_alcohol_use1))'');
    populated_law_enforcement_suspects_drug_use1_pcnt := AVE(GROUP,IF(h.law_enforcement_suspects_drug_use1 = (TYPEOF(h.law_enforcement_suspects_drug_use1))'',0,100));
    maxlength_law_enforcement_suspects_drug_use1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_drug_use1)));
    avelength_law_enforcement_suspects_drug_use1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.law_enforcement_suspects_drug_use1)),h.law_enforcement_suspects_drug_use1<>(typeof(h.law_enforcement_suspects_drug_use1))'');
    populated_ems_notified_time_pcnt := AVE(GROUP,IF(h.ems_notified_time = (TYPEOF(h.ems_notified_time))'',0,100));
    maxlength_ems_notified_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_notified_time)));
    avelength_ems_notified_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_notified_time)),h.ems_notified_time<>(typeof(h.ems_notified_time))'');
    populated_ems_arrival_time_pcnt := AVE(GROUP,IF(h.ems_arrival_time = (TYPEOF(h.ems_arrival_time))'',0,100));
    maxlength_ems_arrival_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_arrival_time)));
    avelength_ems_arrival_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ems_arrival_time)),h.ems_arrival_time<>(typeof(h.ems_arrival_time))'');
    populated_avoidance_maneuver2_pcnt := AVE(GROUP,IF(h.avoidance_maneuver2 = (TYPEOF(h.avoidance_maneuver2))'',0,100));
    maxlength_avoidance_maneuver2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver2)));
    avelength_avoidance_maneuver2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver2)),h.avoidance_maneuver2<>(typeof(h.avoidance_maneuver2))'');
    populated_avoidance_maneuver3_pcnt := AVE(GROUP,IF(h.avoidance_maneuver3 = (TYPEOF(h.avoidance_maneuver3))'',0,100));
    maxlength_avoidance_maneuver3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver3)));
    avelength_avoidance_maneuver3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver3)),h.avoidance_maneuver3<>(typeof(h.avoidance_maneuver3))'');
    populated_avoidance_maneuver4_pcnt := AVE(GROUP,IF(h.avoidance_maneuver4 = (TYPEOF(h.avoidance_maneuver4))'',0,100));
    maxlength_avoidance_maneuver4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver4)));
    avelength_avoidance_maneuver4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.avoidance_maneuver4)),h.avoidance_maneuver4<>(typeof(h.avoidance_maneuver4))'');
    populated_damaged_areas_severity1_pcnt := AVE(GROUP,IF(h.damaged_areas_severity1 = (TYPEOF(h.damaged_areas_severity1))'',0,100));
    maxlength_damaged_areas_severity1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_severity1)));
    avelength_damaged_areas_severity1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_severity1)),h.damaged_areas_severity1<>(typeof(h.damaged_areas_severity1))'');
    populated_damaged_areas_severity2_pcnt := AVE(GROUP,IF(h.damaged_areas_severity2 = (TYPEOF(h.damaged_areas_severity2))'',0,100));
    maxlength_damaged_areas_severity2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_severity2)));
    avelength_damaged_areas_severity2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas_severity2)),h.damaged_areas_severity2<>(typeof(h.damaged_areas_severity2))'');
    populated_vehicle_outside_city_indicator_pcnt := AVE(GROUP,IF(h.vehicle_outside_city_indicator = (TYPEOF(h.vehicle_outside_city_indicator))'',0,100));
    maxlength_vehicle_outside_city_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_indicator)));
    avelength_vehicle_outside_city_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_indicator)),h.vehicle_outside_city_indicator<>(typeof(h.vehicle_outside_city_indicator))'');
    populated_vehicle_outside_city_distance_miles_pcnt := AVE(GROUP,IF(h.vehicle_outside_city_distance_miles = (TYPEOF(h.vehicle_outside_city_distance_miles))'',0,100));
    maxlength_vehicle_outside_city_distance_miles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_distance_miles)));
    avelength_vehicle_outside_city_distance_miles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_distance_miles)),h.vehicle_outside_city_distance_miles<>(typeof(h.vehicle_outside_city_distance_miles))'');
    populated_vehicle_outside_city_direction_pcnt := AVE(GROUP,IF(h.vehicle_outside_city_direction = (TYPEOF(h.vehicle_outside_city_direction))'',0,100));
    maxlength_vehicle_outside_city_direction := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_direction)));
    avelength_vehicle_outside_city_direction := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_outside_city_direction)),h.vehicle_outside_city_direction<>(typeof(h.vehicle_outside_city_direction))'');
    populated_vehicle_crash_cityplace_pcnt := AVE(GROUP,IF(h.vehicle_crash_cityplace = (TYPEOF(h.vehicle_crash_cityplace))'',0,100));
    maxlength_vehicle_crash_cityplace := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_crash_cityplace)));
    avelength_vehicle_crash_cityplace := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_crash_cityplace)),h.vehicle_crash_cityplace<>(typeof(h.vehicle_crash_cityplace))'');
    populated_insurance_company_standardized_pcnt := AVE(GROUP,IF(h.insurance_company_standardized = (TYPEOF(h.insurance_company_standardized))'',0,100));
    maxlength_insurance_company_standardized := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_standardized)));
    avelength_insurance_company_standardized := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_company_standardized)),h.insurance_company_standardized<>(typeof(h.insurance_company_standardized))'');
    populated_insurance_expiration_date_pcnt := AVE(GROUP,IF(h.insurance_expiration_date = (TYPEOF(h.insurance_expiration_date))'',0,100));
    maxlength_insurance_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_expiration_date)));
    avelength_insurance_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_expiration_date)),h.insurance_expiration_date<>(typeof(h.insurance_expiration_date))'');
    populated_insurance_policy_holder_pcnt := AVE(GROUP,IF(h.insurance_policy_holder = (TYPEOF(h.insurance_policy_holder))'',0,100));
    maxlength_insurance_policy_holder := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_policy_holder)));
    avelength_insurance_policy_holder := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.insurance_policy_holder)),h.insurance_policy_holder<>(typeof(h.insurance_policy_holder))'');
    populated_is_tag_converted_pcnt := AVE(GROUP,IF(h.is_tag_converted = (TYPEOF(h.is_tag_converted))'',0,100));
    maxlength_is_tag_converted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.is_tag_converted)));
    avelength_is_tag_converted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.is_tag_converted)),h.is_tag_converted<>(typeof(h.is_tag_converted))'');
    populated_vin_original_pcnt := AVE(GROUP,IF(h.vin_original = (TYPEOF(h.vin_original))'',0,100));
    maxlength_vin_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_original)));
    avelength_vin_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vin_original)),h.vin_original<>(typeof(h.vin_original))'');
    populated_make_original_pcnt := AVE(GROUP,IF(h.make_original = (TYPEOF(h.make_original))'',0,100));
    maxlength_make_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_original)));
    avelength_make_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.make_original)),h.make_original<>(typeof(h.make_original))'');
    populated_model_original_pcnt := AVE(GROUP,IF(h.model_original = (TYPEOF(h.model_original))'',0,100));
    maxlength_model_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_original)));
    avelength_model_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_original)),h.model_original<>(typeof(h.model_original))'');
    populated_model_year_original_pcnt := AVE(GROUP,IF(h.model_year_original = (TYPEOF(h.model_year_original))'',0,100));
    maxlength_model_year_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year_original)));
    avelength_model_year_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.model_year_original)),h.model_year_original<>(typeof(h.model_year_original))'');
    populated_other_unit_vin_original_pcnt := AVE(GROUP,IF(h.other_unit_vin_original = (TYPEOF(h.other_unit_vin_original))'',0,100));
    maxlength_other_unit_vin_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin_original)));
    avelength_other_unit_vin_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin_original)),h.other_unit_vin_original<>(typeof(h.other_unit_vin_original))'');
    populated_other_unit_make_original_pcnt := AVE(GROUP,IF(h.other_unit_make_original = (TYPEOF(h.other_unit_make_original))'',0,100));
    maxlength_other_unit_make_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make_original)));
    avelength_other_unit_make_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make_original)),h.other_unit_make_original<>(typeof(h.other_unit_make_original))'');
    populated_other_unit_model_original_pcnt := AVE(GROUP,IF(h.other_unit_model_original = (TYPEOF(h.other_unit_model_original))'',0,100));
    maxlength_other_unit_model_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_original)));
    avelength_other_unit_model_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_original)),h.other_unit_model_original<>(typeof(h.other_unit_model_original))'');
    populated_other_unit_model_year_original_pcnt := AVE(GROUP,IF(h.other_unit_model_year_original = (TYPEOF(h.other_unit_model_year_original))'',0,100));
    maxlength_other_unit_model_year_original := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year_original)));
    avelength_other_unit_model_year_original := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year_original)),h.other_unit_model_year_original<>(typeof(h.other_unit_model_year_original))'');
    populated_source_id_pcnt := AVE(GROUP,IF(h.source_id = (TYPEOF(h.source_id))'',0,100));
    maxlength_source_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_id)));
    avelength_source_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_id)),h.source_id<>(typeof(h.source_id))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_initial_point_of_contact_pcnt := AVE(GROUP,IF(h.initial_point_of_contact = (TYPEOF(h.initial_point_of_contact))'',0,100));
    maxlength_initial_point_of_contact := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.initial_point_of_contact)));
    avelength_initial_point_of_contact := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.initial_point_of_contact)),h.initial_point_of_contact<>(typeof(h.initial_point_of_contact))'');
    populated_vehicle_driveable_pcnt := AVE(GROUP,IF(h.vehicle_driveable = (TYPEOF(h.vehicle_driveable))'',0,100));
    maxlength_vehicle_driveable := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_driveable)));
    avelength_vehicle_driveable := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vehicle_driveable)),h.vehicle_driveable<>(typeof(h.vehicle_driveable))'');
    populated_drivers_license_type_pcnt := AVE(GROUP,IF(h.drivers_license_type = (TYPEOF(h.drivers_license_type))'',0,100));
    maxlength_drivers_license_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_type)));
    avelength_drivers_license_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drivers_license_type)),h.drivers_license_type<>(typeof(h.drivers_license_type))'');
    populated_alcohol_test_type_refused_pcnt := AVE(GROUP,IF(h.alcohol_test_type_refused = (TYPEOF(h.alcohol_test_type_refused))'',0,100));
    maxlength_alcohol_test_type_refused := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_refused)));
    avelength_alcohol_test_type_refused := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_refused)),h.alcohol_test_type_refused<>(typeof(h.alcohol_test_type_refused))'');
    populated_alcohol_test_type_not_offered_pcnt := AVE(GROUP,IF(h.alcohol_test_type_not_offered = (TYPEOF(h.alcohol_test_type_not_offered))'',0,100));
    maxlength_alcohol_test_type_not_offered := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_not_offered)));
    avelength_alcohol_test_type_not_offered := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_not_offered)),h.alcohol_test_type_not_offered<>(typeof(h.alcohol_test_type_not_offered))'');
    populated_alcohol_test_type_field_pcnt := AVE(GROUP,IF(h.alcohol_test_type_field = (TYPEOF(h.alcohol_test_type_field))'',0,100));
    maxlength_alcohol_test_type_field := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_field)));
    avelength_alcohol_test_type_field := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_field)),h.alcohol_test_type_field<>(typeof(h.alcohol_test_type_field))'');
    populated_alcohol_test_type_pbt_pcnt := AVE(GROUP,IF(h.alcohol_test_type_pbt = (TYPEOF(h.alcohol_test_type_pbt))'',0,100));
    maxlength_alcohol_test_type_pbt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_pbt)));
    avelength_alcohol_test_type_pbt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_pbt)),h.alcohol_test_type_pbt<>(typeof(h.alcohol_test_type_pbt))'');
    populated_alcohol_test_type_breath_pcnt := AVE(GROUP,IF(h.alcohol_test_type_breath = (TYPEOF(h.alcohol_test_type_breath))'',0,100));
    maxlength_alcohol_test_type_breath := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_breath)));
    avelength_alcohol_test_type_breath := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_breath)),h.alcohol_test_type_breath<>(typeof(h.alcohol_test_type_breath))'');
    populated_alcohol_test_type_blood_pcnt := AVE(GROUP,IF(h.alcohol_test_type_blood = (TYPEOF(h.alcohol_test_type_blood))'',0,100));
    maxlength_alcohol_test_type_blood := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_blood)));
    avelength_alcohol_test_type_blood := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_blood)),h.alcohol_test_type_blood<>(typeof(h.alcohol_test_type_blood))'');
    populated_alcohol_test_type_urine_pcnt := AVE(GROUP,IF(h.alcohol_test_type_urine = (TYPEOF(h.alcohol_test_type_urine))'',0,100));
    maxlength_alcohol_test_type_urine := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_urine)));
    avelength_alcohol_test_type_urine := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.alcohol_test_type_urine)),h.alcohol_test_type_urine<>(typeof(h.alcohol_test_type_urine))'');
    populated_trapped_pcnt := AVE(GROUP,IF(h.trapped = (TYPEOF(h.trapped))'',0,100));
    maxlength_trapped := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trapped)));
    avelength_trapped := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trapped)),h.trapped<>(typeof(h.trapped))'');
    populated_dl_number_cdl_endorsements_pcnt := AVE(GROUP,IF(h.dl_number_cdl_endorsements = (TYPEOF(h.dl_number_cdl_endorsements))'',0,100));
    maxlength_dl_number_cdl_endorsements := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_endorsements)));
    avelength_dl_number_cdl_endorsements := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_endorsements)),h.dl_number_cdl_endorsements<>(typeof(h.dl_number_cdl_endorsements))'');
    populated_dl_number_cdl_restrictions_pcnt := AVE(GROUP,IF(h.dl_number_cdl_restrictions = (TYPEOF(h.dl_number_cdl_restrictions))'',0,100));
    maxlength_dl_number_cdl_restrictions := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_restrictions)));
    avelength_dl_number_cdl_restrictions := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_restrictions)),h.dl_number_cdl_restrictions<>(typeof(h.dl_number_cdl_restrictions))'');
    populated_dl_number_cdl_exempt_pcnt := AVE(GROUP,IF(h.dl_number_cdl_exempt = (TYPEOF(h.dl_number_cdl_exempt))'',0,100));
    maxlength_dl_number_cdl_exempt := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_exempt)));
    avelength_dl_number_cdl_exempt := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_exempt)),h.dl_number_cdl_exempt<>(typeof(h.dl_number_cdl_exempt))'');
    populated_dl_number_cdl_medical_card_pcnt := AVE(GROUP,IF(h.dl_number_cdl_medical_card = (TYPEOF(h.dl_number_cdl_medical_card))'',0,100));
    maxlength_dl_number_cdl_medical_card := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_medical_card)));
    avelength_dl_number_cdl_medical_card := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dl_number_cdl_medical_card)),h.dl_number_cdl_medical_card<>(typeof(h.dl_number_cdl_medical_card))'');
    populated_interlock_device_in_use_pcnt := AVE(GROUP,IF(h.interlock_device_in_use = (TYPEOF(h.interlock_device_in_use))'',0,100));
    maxlength_interlock_device_in_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.interlock_device_in_use)));
    avelength_interlock_device_in_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.interlock_device_in_use)),h.interlock_device_in_use<>(typeof(h.interlock_device_in_use))'');
    populated_drug_test_type_blood_pcnt := AVE(GROUP,IF(h.drug_test_type_blood = (TYPEOF(h.drug_test_type_blood))'',0,100));
    maxlength_drug_test_type_blood := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type_blood)));
    avelength_drug_test_type_blood := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type_blood)),h.drug_test_type_blood<>(typeof(h.drug_test_type_blood))'');
    populated_drug_test_type_urine_pcnt := AVE(GROUP,IF(h.drug_test_type_urine = (TYPEOF(h.drug_test_type_urine))'',0,100));
    maxlength_drug_test_type_urine := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type_urine)));
    avelength_drug_test_type_urine := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.drug_test_type_urine)),h.drug_test_type_urine<>(typeof(h.drug_test_type_urine))'');
    populated_traffic_control_condition_pcnt := AVE(GROUP,IF(h.traffic_control_condition = (TYPEOF(h.traffic_control_condition))'',0,100));
    maxlength_traffic_control_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_condition)));
    avelength_traffic_control_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_condition)),h.traffic_control_condition<>(typeof(h.traffic_control_condition))'');
    populated_intersection_related_pcnt := AVE(GROUP,IF(h.intersection_related = (TYPEOF(h.intersection_related))'',0,100));
    maxlength_intersection_related := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersection_related)));
    avelength_intersection_related := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.intersection_related)),h.intersection_related<>(typeof(h.intersection_related))'');
    populated_special_study_local_pcnt := AVE(GROUP,IF(h.special_study_local = (TYPEOF(h.special_study_local))'',0,100));
    maxlength_special_study_local := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_study_local)));
    avelength_special_study_local := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_study_local)),h.special_study_local<>(typeof(h.special_study_local))'');
    populated_special_study_state_pcnt := AVE(GROUP,IF(h.special_study_state = (TYPEOF(h.special_study_state))'',0,100));
    maxlength_special_study_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_study_state)));
    avelength_special_study_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.special_study_state)),h.special_study_state<>(typeof(h.special_study_state))'');
    populated_off_road_vehicle_involved_pcnt := AVE(GROUP,IF(h.off_road_vehicle_involved = (TYPEOF(h.off_road_vehicle_involved))'',0,100));
    maxlength_off_road_vehicle_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.off_road_vehicle_involved)));
    avelength_off_road_vehicle_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.off_road_vehicle_involved)),h.off_road_vehicle_involved<>(typeof(h.off_road_vehicle_involved))'');
    populated_location_type2_pcnt := AVE(GROUP,IF(h.location_type2 = (TYPEOF(h.location_type2))'',0,100));
    maxlength_location_type2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.location_type2)));
    avelength_location_type2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.location_type2)),h.location_type2<>(typeof(h.location_type2))'');
    populated_speed_limit_posted_pcnt := AVE(GROUP,IF(h.speed_limit_posted = (TYPEOF(h.speed_limit_posted))'',0,100));
    maxlength_speed_limit_posted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.speed_limit_posted)));
    avelength_speed_limit_posted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.speed_limit_posted)),h.speed_limit_posted<>(typeof(h.speed_limit_posted))'');
    populated_traffic_control_damage_notify_date_pcnt := AVE(GROUP,IF(h.traffic_control_damage_notify_date = (TYPEOF(h.traffic_control_damage_notify_date))'',0,100));
    maxlength_traffic_control_damage_notify_date := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_date)));
    avelength_traffic_control_damage_notify_date := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_date)),h.traffic_control_damage_notify_date<>(typeof(h.traffic_control_damage_notify_date))'');
    populated_traffic_control_damage_notify_time_pcnt := AVE(GROUP,IF(h.traffic_control_damage_notify_time = (TYPEOF(h.traffic_control_damage_notify_time))'',0,100));
    maxlength_traffic_control_damage_notify_time := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_time)));
    avelength_traffic_control_damage_notify_time := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_time)),h.traffic_control_damage_notify_time<>(typeof(h.traffic_control_damage_notify_time))'');
    populated_traffic_control_damage_notify_name_pcnt := AVE(GROUP,IF(h.traffic_control_damage_notify_name = (TYPEOF(h.traffic_control_damage_notify_name))'',0,100));
    maxlength_traffic_control_damage_notify_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_name)));
    avelength_traffic_control_damage_notify_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.traffic_control_damage_notify_name)),h.traffic_control_damage_notify_name<>(typeof(h.traffic_control_damage_notify_name))'');
    populated_public_property_damaged_pcnt := AVE(GROUP,IF(h.public_property_damaged = (TYPEOF(h.public_property_damaged))'',0,100));
    maxlength_public_property_damaged := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.public_property_damaged)));
    avelength_public_property_damaged := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.public_property_damaged)),h.public_property_damaged<>(typeof(h.public_property_damaged))'');
    populated_replacement_report_pcnt := AVE(GROUP,IF(h.replacement_report = (TYPEOF(h.replacement_report))'',0,100));
    maxlength_replacement_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.replacement_report)));
    avelength_replacement_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.replacement_report)),h.replacement_report<>(typeof(h.replacement_report))'');
    populated_deleted_report_pcnt := AVE(GROUP,IF(h.deleted_report = (TYPEOF(h.deleted_report))'',0,100));
    maxlength_deleted_report := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.deleted_report)));
    avelength_deleted_report := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.deleted_report)),h.deleted_report<>(typeof(h.deleted_report))'');
    populated_next_street_prefix_pcnt := AVE(GROUP,IF(h.next_street_prefix = (TYPEOF(h.next_street_prefix))'',0,100));
    maxlength_next_street_prefix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_prefix)));
    avelength_next_street_prefix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.next_street_prefix)),h.next_street_prefix<>(typeof(h.next_street_prefix))'');
    populated_violator_name_pcnt := AVE(GROUP,IF(h.violator_name = (TYPEOF(h.violator_name))'',0,100));
    maxlength_violator_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.violator_name)));
    avelength_violator_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.violator_name)),h.violator_name<>(typeof(h.violator_name))'');
    populated_type_hazardous_pcnt := AVE(GROUP,IF(h.type_hazardous = (TYPEOF(h.type_hazardous))'',0,100));
    maxlength_type_hazardous := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.type_hazardous)));
    avelength_type_hazardous := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.type_hazardous)),h.type_hazardous<>(typeof(h.type_hazardous))'');
    populated_type_other_pcnt := AVE(GROUP,IF(h.type_other = (TYPEOF(h.type_other))'',0,100));
    maxlength_type_other := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.type_other)));
    avelength_type_other := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.type_other)),h.type_other<>(typeof(h.type_other))'');
    populated_unit_type_and_axles1_pcnt := AVE(GROUP,IF(h.unit_type_and_axles1 = (TYPEOF(h.unit_type_and_axles1))'',0,100));
    maxlength_unit_type_and_axles1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles1)));
    avelength_unit_type_and_axles1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles1)),h.unit_type_and_axles1<>(typeof(h.unit_type_and_axles1))'');
    populated_unit_type_and_axles2_pcnt := AVE(GROUP,IF(h.unit_type_and_axles2 = (TYPEOF(h.unit_type_and_axles2))'',0,100));
    maxlength_unit_type_and_axles2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles2)));
    avelength_unit_type_and_axles2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles2)),h.unit_type_and_axles2<>(typeof(h.unit_type_and_axles2))'');
    populated_unit_type_and_axles3_pcnt := AVE(GROUP,IF(h.unit_type_and_axles3 = (TYPEOF(h.unit_type_and_axles3))'',0,100));
    maxlength_unit_type_and_axles3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles3)));
    avelength_unit_type_and_axles3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles3)),h.unit_type_and_axles3<>(typeof(h.unit_type_and_axles3))'');
    populated_unit_type_and_axles4_pcnt := AVE(GROUP,IF(h.unit_type_and_axles4 = (TYPEOF(h.unit_type_and_axles4))'',0,100));
    maxlength_unit_type_and_axles4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles4)));
    avelength_unit_type_and_axles4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_type_and_axles4)),h.unit_type_and_axles4<>(typeof(h.unit_type_and_axles4))'');
    populated_incident_damage_amount_pcnt := AVE(GROUP,IF(h.incident_damage_amount = (TYPEOF(h.incident_damage_amount))'',0,100));
    maxlength_incident_damage_amount := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_damage_amount)));
    avelength_incident_damage_amount := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.incident_damage_amount)),h.incident_damage_amount<>(typeof(h.incident_damage_amount))'');
    populated_dot_use_pcnt := AVE(GROUP,IF(h.dot_use = (TYPEOF(h.dot_use))'',0,100));
    maxlength_dot_use := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_use)));
    avelength_dot_use := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dot_use)),h.dot_use<>(typeof(h.dot_use))'');
    populated_number_of_persons_involved_pcnt := AVE(GROUP,IF(h.number_of_persons_involved = (TYPEOF(h.number_of_persons_involved))'',0,100));
    maxlength_number_of_persons_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_persons_involved)));
    avelength_number_of_persons_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_persons_involved)),h.number_of_persons_involved<>(typeof(h.number_of_persons_involved))'');
    populated_unusual_road_condition_other_description_pcnt := AVE(GROUP,IF(h.unusual_road_condition_other_description = (TYPEOF(h.unusual_road_condition_other_description))'',0,100));
    maxlength_unusual_road_condition_other_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition_other_description)));
    avelength_unusual_road_condition_other_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unusual_road_condition_other_description)),h.unusual_road_condition_other_description<>(typeof(h.unusual_road_condition_other_description))'');
    populated_number_of_narrative_sections_pcnt := AVE(GROUP,IF(h.number_of_narrative_sections = (TYPEOF(h.number_of_narrative_sections))'',0,100));
    maxlength_number_of_narrative_sections := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_narrative_sections)));
    avelength_number_of_narrative_sections := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.number_of_narrative_sections)),h.number_of_narrative_sections<>(typeof(h.number_of_narrative_sections))'');
    populated_cad_number_pcnt := AVE(GROUP,IF(h.cad_number = (TYPEOF(h.cad_number))'',0,100));
    maxlength_cad_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cad_number)));
    avelength_cad_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cad_number)),h.cad_number<>(typeof(h.cad_number))'');
    populated_visibility_pcnt := AVE(GROUP,IF(h.visibility = (TYPEOF(h.visibility))'',0,100));
    maxlength_visibility := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.visibility)));
    avelength_visibility := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.visibility)),h.visibility<>(typeof(h.visibility))'');
    populated_accident_at_intersection_pcnt := AVE(GROUP,IF(h.accident_at_intersection = (TYPEOF(h.accident_at_intersection))'',0,100));
    maxlength_accident_at_intersection := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_at_intersection)));
    avelength_accident_at_intersection := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_at_intersection)),h.accident_at_intersection<>(typeof(h.accident_at_intersection))'');
    populated_accident_not_at_intersection_pcnt := AVE(GROUP,IF(h.accident_not_at_intersection = (TYPEOF(h.accident_not_at_intersection))'',0,100));
    maxlength_accident_not_at_intersection := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_not_at_intersection)));
    avelength_accident_not_at_intersection := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.accident_not_at_intersection)),h.accident_not_at_intersection<>(typeof(h.accident_not_at_intersection))'');
    populated_first_harmful_event_within_interchange_pcnt := AVE(GROUP,IF(h.first_harmful_event_within_interchange = (TYPEOF(h.first_harmful_event_within_interchange))'',0,100));
    maxlength_first_harmful_event_within_interchange := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_within_interchange)));
    avelength_first_harmful_event_within_interchange := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.first_harmful_event_within_interchange)),h.first_harmful_event_within_interchange<>(typeof(h.first_harmful_event_within_interchange))'');
    populated_injury_involved_pcnt := AVE(GROUP,IF(h.injury_involved = (TYPEOF(h.injury_involved))'',0,100));
    maxlength_injury_involved := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_involved)));
    avelength_injury_involved := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.injury_involved)),h.injury_involved<>(typeof(h.injury_involved))'');
    populated_citation_status_pcnt := AVE(GROUP,IF(h.citation_status = (TYPEOF(h.citation_status))'',0,100));
    maxlength_citation_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_status)));
    avelength_citation_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.citation_status)),h.citation_status<>(typeof(h.citation_status))'');
    populated_commercial_vehicle_pcnt := AVE(GROUP,IF(h.commercial_vehicle = (TYPEOF(h.commercial_vehicle))'',0,100));
    maxlength_commercial_vehicle := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_vehicle)));
    avelength_commercial_vehicle := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.commercial_vehicle)),h.commercial_vehicle<>(typeof(h.commercial_vehicle))'');
    populated_not_in_transport_pcnt := AVE(GROUP,IF(h.not_in_transport = (TYPEOF(h.not_in_transport))'',0,100));
    maxlength_not_in_transport := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.not_in_transport)));
    avelength_not_in_transport := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.not_in_transport)),h.not_in_transport<>(typeof(h.not_in_transport))'');
    populated_other_unit_number_pcnt := AVE(GROUP,IF(h.other_unit_number = (TYPEOF(h.other_unit_number))'',0,100));
    maxlength_other_unit_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number)));
    avelength_other_unit_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number)),h.other_unit_number<>(typeof(h.other_unit_number))'');
    populated_other_unit_length_pcnt := AVE(GROUP,IF(h.other_unit_length = (TYPEOF(h.other_unit_length))'',0,100));
    maxlength_other_unit_length := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length)));
    avelength_other_unit_length := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length)),h.other_unit_length<>(typeof(h.other_unit_length))'');
    populated_other_unit_axles_pcnt := AVE(GROUP,IF(h.other_unit_axles = (TYPEOF(h.other_unit_axles))'',0,100));
    maxlength_other_unit_axles := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles)));
    avelength_other_unit_axles := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles)),h.other_unit_axles<>(typeof(h.other_unit_axles))'');
    populated_other_unit_plate_expiration_pcnt := AVE(GROUP,IF(h.other_unit_plate_expiration = (TYPEOF(h.other_unit_plate_expiration))'',0,100));
    maxlength_other_unit_plate_expiration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration)));
    avelength_other_unit_plate_expiration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration)),h.other_unit_plate_expiration<>(typeof(h.other_unit_plate_expiration))'');
    populated_other_unit_permanent_registration_pcnt := AVE(GROUP,IF(h.other_unit_permanent_registration = (TYPEOF(h.other_unit_permanent_registration))'',0,100));
    maxlength_other_unit_permanent_registration := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration)));
    avelength_other_unit_permanent_registration := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration)),h.other_unit_permanent_registration<>(typeof(h.other_unit_permanent_registration))'');
    populated_other_unit_model_year2_pcnt := AVE(GROUP,IF(h.other_unit_model_year2 = (TYPEOF(h.other_unit_model_year2))'',0,100));
    maxlength_other_unit_model_year2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year2)));
    avelength_other_unit_model_year2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year2)),h.other_unit_model_year2<>(typeof(h.other_unit_model_year2))'');
    populated_other_unit_make2_pcnt := AVE(GROUP,IF(h.other_unit_make2 = (TYPEOF(h.other_unit_make2))'',0,100));
    maxlength_other_unit_make2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make2)));
    avelength_other_unit_make2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make2)),h.other_unit_make2<>(typeof(h.other_unit_make2))'');
    populated_other_unit_vin2_pcnt := AVE(GROUP,IF(h.other_unit_vin2 = (TYPEOF(h.other_unit_vin2))'',0,100));
    maxlength_other_unit_vin2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin2)));
    avelength_other_unit_vin2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin2)),h.other_unit_vin2<>(typeof(h.other_unit_vin2))'');
    populated_other_unit_registration_state2_pcnt := AVE(GROUP,IF(h.other_unit_registration_state2 = (TYPEOF(h.other_unit_registration_state2))'',0,100));
    maxlength_other_unit_registration_state2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state2)));
    avelength_other_unit_registration_state2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state2)),h.other_unit_registration_state2<>(typeof(h.other_unit_registration_state2))'');
    populated_other_unit_registration_year2_pcnt := AVE(GROUP,IF(h.other_unit_registration_year2 = (TYPEOF(h.other_unit_registration_year2))'',0,100));
    maxlength_other_unit_registration_year2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year2)));
    avelength_other_unit_registration_year2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year2)),h.other_unit_registration_year2<>(typeof(h.other_unit_registration_year2))'');
    populated_other_unit_license_plate2_pcnt := AVE(GROUP,IF(h.other_unit_license_plate2 = (TYPEOF(h.other_unit_license_plate2))'',0,100));
    maxlength_other_unit_license_plate2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate2)));
    avelength_other_unit_license_plate2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate2)),h.other_unit_license_plate2<>(typeof(h.other_unit_license_plate2))'');
    populated_other_unit_number2_pcnt := AVE(GROUP,IF(h.other_unit_number2 = (TYPEOF(h.other_unit_number2))'',0,100));
    maxlength_other_unit_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number2)));
    avelength_other_unit_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number2)),h.other_unit_number2<>(typeof(h.other_unit_number2))'');
    populated_other_unit_length2_pcnt := AVE(GROUP,IF(h.other_unit_length2 = (TYPEOF(h.other_unit_length2))'',0,100));
    maxlength_other_unit_length2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length2)));
    avelength_other_unit_length2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length2)),h.other_unit_length2<>(typeof(h.other_unit_length2))'');
    populated_other_unit_axles2_pcnt := AVE(GROUP,IF(h.other_unit_axles2 = (TYPEOF(h.other_unit_axles2))'',0,100));
    maxlength_other_unit_axles2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles2)));
    avelength_other_unit_axles2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles2)),h.other_unit_axles2<>(typeof(h.other_unit_axles2))'');
    populated_other_unit_plate_expiration2_pcnt := AVE(GROUP,IF(h.other_unit_plate_expiration2 = (TYPEOF(h.other_unit_plate_expiration2))'',0,100));
    maxlength_other_unit_plate_expiration2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration2)));
    avelength_other_unit_plate_expiration2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration2)),h.other_unit_plate_expiration2<>(typeof(h.other_unit_plate_expiration2))'');
    populated_other_unit_permanent_registration2_pcnt := AVE(GROUP,IF(h.other_unit_permanent_registration2 = (TYPEOF(h.other_unit_permanent_registration2))'',0,100));
    maxlength_other_unit_permanent_registration2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration2)));
    avelength_other_unit_permanent_registration2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration2)),h.other_unit_permanent_registration2<>(typeof(h.other_unit_permanent_registration2))'');
    populated_other_unit_type2_pcnt := AVE(GROUP,IF(h.other_unit_type2 = (TYPEOF(h.other_unit_type2))'',0,100));
    maxlength_other_unit_type2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type2)));
    avelength_other_unit_type2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type2)),h.other_unit_type2<>(typeof(h.other_unit_type2))'');
    populated_other_unit_model_year3_pcnt := AVE(GROUP,IF(h.other_unit_model_year3 = (TYPEOF(h.other_unit_model_year3))'',0,100));
    maxlength_other_unit_model_year3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year3)));
    avelength_other_unit_model_year3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_model_year3)),h.other_unit_model_year3<>(typeof(h.other_unit_model_year3))'');
    populated_other_unit_make3_pcnt := AVE(GROUP,IF(h.other_unit_make3 = (TYPEOF(h.other_unit_make3))'',0,100));
    maxlength_other_unit_make3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make3)));
    avelength_other_unit_make3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_make3)),h.other_unit_make3<>(typeof(h.other_unit_make3))'');
    populated_other_unit_vin3_pcnt := AVE(GROUP,IF(h.other_unit_vin3 = (TYPEOF(h.other_unit_vin3))'',0,100));
    maxlength_other_unit_vin3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin3)));
    avelength_other_unit_vin3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_vin3)),h.other_unit_vin3<>(typeof(h.other_unit_vin3))'');
    populated_other_unit_registration_state3_pcnt := AVE(GROUP,IF(h.other_unit_registration_state3 = (TYPEOF(h.other_unit_registration_state3))'',0,100));
    maxlength_other_unit_registration_state3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state3)));
    avelength_other_unit_registration_state3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_state3)),h.other_unit_registration_state3<>(typeof(h.other_unit_registration_state3))'');
    populated_other_unit_registration_year3_pcnt := AVE(GROUP,IF(h.other_unit_registration_year3 = (TYPEOF(h.other_unit_registration_year3))'',0,100));
    maxlength_other_unit_registration_year3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year3)));
    avelength_other_unit_registration_year3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_registration_year3)),h.other_unit_registration_year3<>(typeof(h.other_unit_registration_year3))'');
    populated_other_unit_license_plate3_pcnt := AVE(GROUP,IF(h.other_unit_license_plate3 = (TYPEOF(h.other_unit_license_plate3))'',0,100));
    maxlength_other_unit_license_plate3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate3)));
    avelength_other_unit_license_plate3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_license_plate3)),h.other_unit_license_plate3<>(typeof(h.other_unit_license_plate3))'');
    populated_other_unit_number3_pcnt := AVE(GROUP,IF(h.other_unit_number3 = (TYPEOF(h.other_unit_number3))'',0,100));
    maxlength_other_unit_number3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number3)));
    avelength_other_unit_number3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_number3)),h.other_unit_number3<>(typeof(h.other_unit_number3))'');
    populated_other_unit_length3_pcnt := AVE(GROUP,IF(h.other_unit_length3 = (TYPEOF(h.other_unit_length3))'',0,100));
    maxlength_other_unit_length3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length3)));
    avelength_other_unit_length3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_length3)),h.other_unit_length3<>(typeof(h.other_unit_length3))'');
    populated_other_unit_axles3_pcnt := AVE(GROUP,IF(h.other_unit_axles3 = (TYPEOF(h.other_unit_axles3))'',0,100));
    maxlength_other_unit_axles3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles3)));
    avelength_other_unit_axles3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_axles3)),h.other_unit_axles3<>(typeof(h.other_unit_axles3))'');
    populated_other_unit_plate_expiration3_pcnt := AVE(GROUP,IF(h.other_unit_plate_expiration3 = (TYPEOF(h.other_unit_plate_expiration3))'',0,100));
    maxlength_other_unit_plate_expiration3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration3)));
    avelength_other_unit_plate_expiration3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_plate_expiration3)),h.other_unit_plate_expiration3<>(typeof(h.other_unit_plate_expiration3))'');
    populated_other_unit_permanent_registration3_pcnt := AVE(GROUP,IF(h.other_unit_permanent_registration3 = (TYPEOF(h.other_unit_permanent_registration3))'',0,100));
    maxlength_other_unit_permanent_registration3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration3)));
    avelength_other_unit_permanent_registration3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_permanent_registration3)),h.other_unit_permanent_registration3<>(typeof(h.other_unit_permanent_registration3))'');
    populated_other_unit_type3_pcnt := AVE(GROUP,IF(h.other_unit_type3 = (TYPEOF(h.other_unit_type3))'',0,100));
    maxlength_other_unit_type3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type3)));
    avelength_other_unit_type3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.other_unit_type3)),h.other_unit_type3<>(typeof(h.other_unit_type3))'');
    populated_damaged_areas3_pcnt := AVE(GROUP,IF(h.damaged_areas3 = (TYPEOF(h.damaged_areas3))'',0,100));
    maxlength_damaged_areas3 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas3)));
    avelength_damaged_areas3 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damaged_areas3)),h.damaged_areas3<>(typeof(h.damaged_areas3))'');
    populated_driver_distracted_by_pcnt := AVE(GROUP,IF(h.driver_distracted_by = (TYPEOF(h.driver_distracted_by))'',0,100));
    maxlength_driver_distracted_by := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_distracted_by)));
    avelength_driver_distracted_by := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.driver_distracted_by)),h.driver_distracted_by<>(typeof(h.driver_distracted_by))'');
    populated_non_motorist_type_pcnt := AVE(GROUP,IF(h.non_motorist_type = (TYPEOF(h.non_motorist_type))'',0,100));
    maxlength_non_motorist_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_type)));
    avelength_non_motorist_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.non_motorist_type)),h.non_motorist_type<>(typeof(h.non_motorist_type))'');
    populated_seating_position_row_pcnt := AVE(GROUP,IF(h.seating_position_row = (TYPEOF(h.seating_position_row))'',0,100));
    maxlength_seating_position_row := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_row)));
    avelength_seating_position_row := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_row)),h.seating_position_row<>(typeof(h.seating_position_row))'');
    populated_seating_position_seat_pcnt := AVE(GROUP,IF(h.seating_position_seat = (TYPEOF(h.seating_position_seat))'',0,100));
    maxlength_seating_position_seat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_seat)));
    avelength_seating_position_seat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_seat)),h.seating_position_seat<>(typeof(h.seating_position_seat))'');
    populated_seating_position_description_pcnt := AVE(GROUP,IF(h.seating_position_description = (TYPEOF(h.seating_position_description))'',0,100));
    maxlength_seating_position_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_description)));
    avelength_seating_position_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.seating_position_description)),h.seating_position_description<>(typeof(h.seating_position_description))'');
    populated_transported_id_number_pcnt := AVE(GROUP,IF(h.transported_id_number = (TYPEOF(h.transported_id_number))'',0,100));
    maxlength_transported_id_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_id_number)));
    avelength_transported_id_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.transported_id_number)),h.transported_id_number<>(typeof(h.transported_id_number))'');
    populated_witness_number_pcnt := AVE(GROUP,IF(h.witness_number = (TYPEOF(h.witness_number))'',0,100));
    maxlength_witness_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.witness_number)));
    avelength_witness_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.witness_number)),h.witness_number<>(typeof(h.witness_number))'');
    populated_date_of_birth_derived_pcnt := AVE(GROUP,IF(h.date_of_birth_derived = (TYPEOF(h.date_of_birth_derived))'',0,100));
    maxlength_date_of_birth_derived := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_of_birth_derived)));
    avelength_date_of_birth_derived := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_of_birth_derived)),h.date_of_birth_derived<>(typeof(h.date_of_birth_derived))'');
    populated_property_damage_id_pcnt := AVE(GROUP,IF(h.property_damage_id = (TYPEOF(h.property_damage_id))'',0,100));
    maxlength_property_damage_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_id)));
    avelength_property_damage_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_damage_id)),h.property_damage_id<>(typeof(h.property_damage_id))'');
    populated_property_owner_name_pcnt := AVE(GROUP,IF(h.property_owner_name = (TYPEOF(h.property_owner_name))'',0,100));
    maxlength_property_owner_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_owner_name)));
    avelength_property_owner_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.property_owner_name)),h.property_owner_name<>(typeof(h.property_owner_name))'');
    populated_damage_description_pcnt := AVE(GROUP,IF(h.damage_description = (TYPEOF(h.damage_description))'',0,100));
    maxlength_damage_description := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_description)));
    avelength_damage_description := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_description)),h.damage_description<>(typeof(h.damage_description))'');
    populated_damage_estimate_pcnt := AVE(GROUP,IF(h.damage_estimate = (TYPEOF(h.damage_estimate))'',0,100));
    maxlength_damage_estimate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_estimate)));
    avelength_damage_estimate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.damage_estimate)),h.damage_estimate<>(typeof(h.damage_estimate))'');
    populated_narrative_pcnt := AVE(GROUP,IF(h.narrative = (TYPEOF(h.narrative))'',0,100));
    maxlength_narrative := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.narrative)));
    avelength_narrative := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.narrative)),h.narrative<>(typeof(h.narrative))'');
    populated_narrative_continuance_pcnt := AVE(GROUP,IF(h.narrative_continuance = (TYPEOF(h.narrative_continuance))'',0,100));
    maxlength_narrative_continuance := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.narrative_continuance)));
    avelength_narrative_continuance := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.narrative_continuance)),h.narrative_continuance<>(typeof(h.narrative_continuance))'');
    populated_hazardous_materials_hazmat_placard_number1_pcnt := AVE(GROUP,IF(h.hazardous_materials_hazmat_placard_number1 = (TYPEOF(h.hazardous_materials_hazmat_placard_number1))'',0,100));
    maxlength_hazardous_materials_hazmat_placard_number1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_hazmat_placard_number1)));
    avelength_hazardous_materials_hazmat_placard_number1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_hazmat_placard_number1)),h.hazardous_materials_hazmat_placard_number1<>(typeof(h.hazardous_materials_hazmat_placard_number1))'');
    populated_hazardous_materials_hazmat_placard_number2_pcnt := AVE(GROUP,IF(h.hazardous_materials_hazmat_placard_number2 = (TYPEOF(h.hazardous_materials_hazmat_placard_number2))'',0,100));
    maxlength_hazardous_materials_hazmat_placard_number2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_hazmat_placard_number2)));
    avelength_hazardous_materials_hazmat_placard_number2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hazardous_materials_hazmat_placard_number2)),h.hazardous_materials_hazmat_placard_number2<>(typeof(h.hazardous_materials_hazmat_placard_number2))'');
    populated_vendor_code_pcnt := AVE(GROUP,IF(h.vendor_code = (TYPEOF(h.vendor_code))'',0,100));
    maxlength_vendor_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_code)));
    avelength_vendor_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_code)),h.vendor_code<>(typeof(h.vendor_code))'');
    populated_report_property_damage_pcnt := AVE(GROUP,IF(h.report_property_damage = (TYPEOF(h.report_property_damage))'',0,100));
    maxlength_report_property_damage := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_property_damage)));
    avelength_report_property_damage := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_property_damage)),h.report_property_damage<>(typeof(h.report_property_damage))'');
    populated_report_collision_type_pcnt := AVE(GROUP,IF(h.report_collision_type = (TYPEOF(h.report_collision_type))'',0,100));
    maxlength_report_collision_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_collision_type)));
    avelength_report_collision_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_collision_type)),h.report_collision_type<>(typeof(h.report_collision_type))'');
    populated_report_first_harmful_event_pcnt := AVE(GROUP,IF(h.report_first_harmful_event = (TYPEOF(h.report_first_harmful_event))'',0,100));
    maxlength_report_first_harmful_event := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_first_harmful_event)));
    avelength_report_first_harmful_event := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_first_harmful_event)),h.report_first_harmful_event<>(typeof(h.report_first_harmful_event))'');
    populated_report_light_condition_pcnt := AVE(GROUP,IF(h.report_light_condition = (TYPEOF(h.report_light_condition))'',0,100));
    maxlength_report_light_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_light_condition)));
    avelength_report_light_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_light_condition)),h.report_light_condition<>(typeof(h.report_light_condition))'');
    populated_report_weather_condition_pcnt := AVE(GROUP,IF(h.report_weather_condition = (TYPEOF(h.report_weather_condition))'',0,100));
    maxlength_report_weather_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_weather_condition)));
    avelength_report_weather_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_weather_condition)),h.report_weather_condition<>(typeof(h.report_weather_condition))'');
    populated_report_road_condition_pcnt := AVE(GROUP,IF(h.report_road_condition = (TYPEOF(h.report_road_condition))'',0,100));
    maxlength_report_road_condition := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_road_condition)));
    avelength_report_road_condition := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_road_condition)),h.report_road_condition<>(typeof(h.report_road_condition))'');
    populated_report_injury_status_pcnt := AVE(GROUP,IF(h.report_injury_status = (TYPEOF(h.report_injury_status))'',0,100));
    maxlength_report_injury_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_injury_status)));
    avelength_report_injury_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_injury_status)),h.report_injury_status<>(typeof(h.report_injury_status))'');
    populated_report_damage_extent_pcnt := AVE(GROUP,IF(h.report_damage_extent = (TYPEOF(h.report_damage_extent))'',0,100));
    maxlength_report_damage_extent := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_damage_extent)));
    avelength_report_damage_extent := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_damage_extent)),h.report_damage_extent<>(typeof(h.report_damage_extent))'');
    populated_report_vehicle_type_pcnt := AVE(GROUP,IF(h.report_vehicle_type = (TYPEOF(h.report_vehicle_type))'',0,100));
    maxlength_report_vehicle_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_type)));
    avelength_report_vehicle_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_type)),h.report_vehicle_type<>(typeof(h.report_vehicle_type))'');
    populated_report_traffic_control_device_type_pcnt := AVE(GROUP,IF(h.report_traffic_control_device_type = (TYPEOF(h.report_traffic_control_device_type))'',0,100));
    maxlength_report_traffic_control_device_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_traffic_control_device_type)));
    avelength_report_traffic_control_device_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_traffic_control_device_type)),h.report_traffic_control_device_type<>(typeof(h.report_traffic_control_device_type))'');
    populated_report_contributing_circumstances_v_pcnt := AVE(GROUP,IF(h.report_contributing_circumstances_v = (TYPEOF(h.report_contributing_circumstances_v))'',0,100));
    maxlength_report_contributing_circumstances_v := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_contributing_circumstances_v)));
    avelength_report_contributing_circumstances_v := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_contributing_circumstances_v)),h.report_contributing_circumstances_v<>(typeof(h.report_contributing_circumstances_v))'');
    populated_report_vehicle_maneuver_action_prior_pcnt := AVE(GROUP,IF(h.report_vehicle_maneuver_action_prior = (TYPEOF(h.report_vehicle_maneuver_action_prior))'',0,100));
    maxlength_report_vehicle_maneuver_action_prior := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_maneuver_action_prior)));
    avelength_report_vehicle_maneuver_action_prior := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_maneuver_action_prior)),h.report_vehicle_maneuver_action_prior<>(typeof(h.report_vehicle_maneuver_action_prior))'');
    populated_report_vehicle_body_type_pcnt := AVE(GROUP,IF(h.report_vehicle_body_type = (TYPEOF(h.report_vehicle_body_type))'',0,100));
    maxlength_report_vehicle_body_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_body_type)));
    avelength_report_vehicle_body_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_vehicle_body_type)),h.report_vehicle_body_type<>(typeof(h.report_vehicle_body_type))'');
    populated_cru_agency_name_pcnt := AVE(GROUP,IF(h.cru_agency_name = (TYPEOF(h.cru_agency_name))'',0,100));
    maxlength_cru_agency_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_agency_name)));
    avelength_cru_agency_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_agency_name)),h.cru_agency_name<>(typeof(h.cru_agency_name))'');
    populated_cru_agency_id_pcnt := AVE(GROUP,IF(h.cru_agency_id = (TYPEOF(h.cru_agency_id))'',0,100));
    maxlength_cru_agency_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_agency_id)));
    avelength_cru_agency_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cru_agency_id)),h.cru_agency_id<>(typeof(h.cru_agency_id))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_vendor_report_id_pcnt := AVE(GROUP,IF(h.vendor_report_id = (TYPEOF(h.vendor_report_id))'',0,100));
    maxlength_vendor_report_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_report_id)));
    avelength_vendor_report_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vendor_report_id)),h.vendor_report_id<>(typeof(h.vendor_report_id))'');
    populated_is_available_for_public_pcnt := AVE(GROUP,IF(h.is_available_for_public = (TYPEOF(h.is_available_for_public))'',0,100));
    maxlength_is_available_for_public := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.is_available_for_public)));
    avelength_is_available_for_public := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.is_available_for_public)),h.is_available_for_public<>(typeof(h.is_available_for_public))'');
    populated_has_addendum_pcnt := AVE(GROUP,IF(h.has_addendum = (TYPEOF(h.has_addendum))'',0,100));
    maxlength_has_addendum := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.has_addendum)));
    avelength_has_addendum := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.has_addendum)),h.has_addendum<>(typeof(h.has_addendum))'');
    populated_report_agency_ori_pcnt := AVE(GROUP,IF(h.report_agency_ori = (TYPEOF(h.report_agency_ori))'',0,100));
    maxlength_report_agency_ori := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_agency_ori)));
    avelength_report_agency_ori := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_agency_ori)),h.report_agency_ori<>(typeof(h.report_agency_ori))'');
    populated_report_status_pcnt := AVE(GROUP,IF(h.report_status = (TYPEOF(h.report_status))'',0,100));
    maxlength_report_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_status)));
    avelength_report_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.report_status)),h.report_status<>(typeof(h.report_status))'');
    populated_super_report_id_pcnt := AVE(GROUP,IF(h.super_report_id = (TYPEOF(h.super_report_id))'',0,100));
    maxlength_super_report_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.super_report_id)));
    avelength_super_report_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.super_report_id)),h.super_report_id<>(typeof(h.super_report_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,report_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_report_code_pcnt *   0.00 / 100 + T.Populated_report_category_pcnt *   0.00 / 100 + T.Populated_report_code_desc_pcnt *   0.00 / 100 + T.Populated_citation_id_pcnt *   0.00 / 100 + T.Populated_creation_date_pcnt *   0.00 / 100 + T.Populated_incident_id_pcnt *   0.00 / 100 + T.Populated_citation_issued_pcnt *   0.00 / 100 + T.Populated_citation_number1_pcnt *   0.00 / 100 + T.Populated_citation_number2_pcnt *   0.00 / 100 + T.Populated_section_number1_pcnt *   0.00 / 100 + T.Populated_court_date_pcnt *   0.00 / 100 + T.Populated_court_time_pcnt *   0.00 / 100 + T.Populated_citation_detail1_pcnt *   0.00 / 100 + T.Populated_local_code_pcnt *   0.00 / 100 + T.Populated_violation_code1_pcnt *   0.00 / 100 + T.Populated_violation_code2_pcnt *   0.00 / 100 + T.Populated_multiple_charges_indicator_pcnt *   0.00 / 100 + T.Populated_dui_indicator_pcnt *   0.00 / 100 + T.Populated_commercial_id_pcnt *   0.00 / 100 + T.Populated_vehicle_id_pcnt *   0.00 / 100 + T.Populated_commercial_info_source_pcnt *   0.00 / 100 + T.Populated_commercial_vehicle_type_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_dot_number_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_state_id_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_carrier_name_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_address_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_city_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_state_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_zipcode_pcnt *   0.00 / 100 + T.Populated_motor_carrier_id_commercial_indicator_pcnt *   0.00 / 100 + T.Populated_carrier_id_type_pcnt *   0.00 / 100 + T.Populated_carrier_unit_number_pcnt *   0.00 / 100 + T.Populated_dot_permit_number_pcnt *   0.00 / 100 + T.Populated_iccmc_number_pcnt *   0.00 / 100 + T.Populated_mcs_vehicle_inspection_pcnt *   0.00 / 100 + T.Populated_mcs_form_number_pcnt *   0.00 / 100 + T.Populated_mcs_out_of_service_pcnt *   0.00 / 100 + T.Populated_mcs_violation_related_pcnt *   0.00 / 100 + T.Populated_number_of_axles_pcnt *   0.00 / 100 + T.Populated_number_of_tires_pcnt *   0.00 / 100 + T.Populated_gvw_over_10k_pounds_pcnt *   0.00 / 100 + T.Populated_weight_rating_pcnt *   0.00 / 100 + T.Populated_registered_gross_vehicle_weight_pcnt *   0.00 / 100 + T.Populated_vehicle_length_feet_pcnt *   0.00 / 100 + T.Populated_cargo_body_type_pcnt *   0.00 / 100 + T.Populated_load_type_pcnt *   0.00 / 100 + T.Populated_oversize_load_pcnt *   0.00 / 100 + T.Populated_vehicle_configuration_pcnt *   0.00 / 100 + T.Populated_trailer1_type_pcnt *   0.00 / 100 + T.Populated_trailer1_length_feet_pcnt *   0.00 / 100 + T.Populated_trailer1_width_feet_pcnt *   0.00 / 100 + T.Populated_trailer2_type_pcnt *   0.00 / 100 + T.Populated_trailer2_length_feet_pcnt *   0.00 / 100 + T.Populated_trailer2_width_feet_pcnt *   0.00 / 100 + T.Populated_federally_reportable_pcnt *   0.00 / 100 + T.Populated_vehicle_inspection_hazmat_pcnt *   0.00 / 100 + T.Populated_hazmat_form_number_pcnt *   0.00 / 100 + T.Populated_hazmt_out_of_service_pcnt *   0.00 / 100 + T.Populated_hazmat_violation_related_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_placard_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_class_number1_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_class_number2_pcnt *   0.00 / 100 + T.Populated_hazmat_placard_name_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_released1_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_released2_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_released3_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_released4_pcnt *   0.00 / 100 + T.Populated_commercial_event1_pcnt *   0.00 / 100 + T.Populated_commercial_event2_pcnt *   0.00 / 100 + T.Populated_commercial_event3_pcnt *   0.00 / 100 + T.Populated_commercial_event4_pcnt *   0.00 / 100 + T.Populated_recommended_driver_reexam_pcnt *   0.00 / 100 + T.Populated_transporting_hazmat_pcnt *   0.00 / 100 + T.Populated_liquid_hazmat_volume_pcnt *   0.00 / 100 + T.Populated_oversize_vehicle_pcnt *   0.00 / 100 + T.Populated_overlength_vehicle_pcnt *   0.00 / 100 + T.Populated_oversize_vehicle_permitted_pcnt *   0.00 / 100 + T.Populated_overlength_vehicle_permitted_pcnt *   0.00 / 100 + T.Populated_carrier_phone_number_pcnt *   0.00 / 100 + T.Populated_commerce_type_pcnt *   0.00 / 100 + T.Populated_citation_issued_to_vehicle_pcnt *   0.00 / 100 + T.Populated_cdl_class_pcnt *   0.00 / 100 + T.Populated_dot_state_pcnt *   0.00 / 100 + T.Populated_fire_hazardous_materials_involvement_pcnt *   0.00 / 100 + T.Populated_commercial_event_description_pcnt *   0.00 / 100 + T.Populated_supplment_required_hazmat_placard_pcnt *   0.00 / 100 + T.Populated_other_state_number1_pcnt *   0.00 / 100 + T.Populated_other_state_number2_pcnt *   0.00 / 100 + T.Populated_work_type_id_pcnt *   0.00 / 100 + T.Populated_report_id_pcnt *   0.00 / 100 + T.Populated_agency_id_pcnt *   0.00 / 100 + T.Populated_sent_to_hpcc_datetime_pcnt *   0.00 / 100 + T.Populated_corrected_incident_pcnt *   0.00 / 100 + T.Populated_cru_order_id_pcnt *   0.00 / 100 + T.Populated_cru_sequence_nbr_pcnt *   0.00 / 100 + T.Populated_loss_state_abbr_pcnt *   0.00 / 100 + T.Populated_report_type_id_pcnt *   0.00 / 100 + T.Populated_hash_key_pcnt *   0.00 / 100 + T.Populated_case_identifier_pcnt *   0.00 / 100 + T.Populated_crash_county_pcnt *   0.00 / 100 + T.Populated_county_cd_pcnt *   0.00 / 100 + T.Populated_crash_cityplace_pcnt *   0.00 / 100 + T.Populated_crash_city_pcnt *   0.00 / 100 + T.Populated_city_code_pcnt *   0.00 / 100 + T.Populated_first_harmful_event_pcnt *   0.00 / 100 + T.Populated_first_harmful_event_location_pcnt *   0.00 / 100 + T.Populated_manner_crash_impact1_pcnt *   0.00 / 100 + T.Populated_weather_condition1_pcnt *   0.00 / 100 + T.Populated_weather_condition2_pcnt *   0.00 / 100 + T.Populated_light_condition1_pcnt *   0.00 / 100 + T.Populated_light_condition2_pcnt *   0.00 / 100 + T.Populated_road_surface_condition_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental1_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental2_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental3_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental4_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_road1_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_road2_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_road3_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_road4_pcnt *   0.00 / 100 + T.Populated_relation_to_junction_pcnt *   0.00 / 100 + T.Populated_intersection_type_pcnt *   0.00 / 100 + T.Populated_school_bus_related_pcnt *   0.00 / 100 + T.Populated_work_zone_related_pcnt *   0.00 / 100 + T.Populated_work_zone_location_pcnt *   0.00 / 100 + T.Populated_work_zone_type_pcnt *   0.00 / 100 + T.Populated_work_zone_workers_present_pcnt *   0.00 / 100 + T.Populated_work_zone_law_enforcement_present_pcnt *   0.00 / 100 + T.Populated_crash_severity_pcnt *   0.00 / 100 + T.Populated_number_of_vehicles_pcnt *   0.00 / 100 + T.Populated_total_nonfatal_injuries_pcnt *   0.00 / 100 + T.Populated_total_fatal_injuries_pcnt *   0.00 / 100 + T.Populated_day_of_week_pcnt *   0.00 / 100 + T.Populated_roadway_curvature_pcnt *   0.00 / 100 + T.Populated_part_of_national_highway_system_pcnt *   0.00 / 100 + T.Populated_roadway_functional_class_pcnt *   0.00 / 100 + T.Populated_access_control_pcnt *   0.00 / 100 + T.Populated_rr_crossing_id_pcnt *   0.00 / 100 + T.Populated_roadway_lighting_pcnt *   0.00 / 100 + T.Populated_traffic_control_type_at_intersection1_pcnt *   0.00 / 100 + T.Populated_traffic_control_type_at_intersection2_pcnt *   0.00 / 100 + T.Populated_ncic_number_pcnt *   0.00 / 100 + T.Populated_state_report_number_pcnt *   0.00 / 100 + T.Populated_ori_number_pcnt *   0.00 / 100 + T.Populated_crash_date_pcnt *   0.00 / 100 + T.Populated_crash_time_pcnt *   0.00 / 100 + T.Populated_lattitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_milepost1_pcnt *   0.00 / 100 + T.Populated_milepost2_pcnt *   0.00 / 100 + T.Populated_address_number_pcnt *   0.00 / 100 + T.Populated_loss_street_pcnt *   0.00 / 100 + T.Populated_loss_street_route_number_pcnt *   0.00 / 100 + T.Populated_loss_street_type_pcnt *   0.00 / 100 + T.Populated_loss_street_speed_limit_pcnt *   0.00 / 100 + T.Populated_incident_location_indicator_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_route_number_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_intersecting_route_segment_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_type_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_speed_limit_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_number_of_lanes_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_orientation_pcnt *   0.00 / 100 + T.Populated_loss_cross_street_route_sign_pcnt *   0.00 / 100 + T.Populated_at_node_number_pcnt *   0.00 / 100 + T.Populated_distance_from_node_feet_pcnt *   0.00 / 100 + T.Populated_distance_from_node_miles_pcnt *   0.00 / 100 + T.Populated_next_node_number_pcnt *   0.00 / 100 + T.Populated_next_roadway_node_number_pcnt *   0.00 / 100 + T.Populated_direction_of_travel_pcnt *   0.00 / 100 + T.Populated_next_street_pcnt *   0.00 / 100 + T.Populated_next_street_type_pcnt *   0.00 / 100 + T.Populated_next_street_suffix_pcnt *   0.00 / 100 + T.Populated_before_or_after_next_street_pcnt *   0.00 / 100 + T.Populated_next_street_distance_feet_pcnt *   0.00 / 100 + T.Populated_next_street_distance_miles_pcnt *   0.00 / 100 + T.Populated_next_street_direction_pcnt *   0.00 / 100 + T.Populated_next_street_route_segment_pcnt *   0.00 / 100 + T.Populated_continuing_toward_street_pcnt *   0.00 / 100 + T.Populated_continuing_street_suffix_pcnt *   0.00 / 100 + T.Populated_continuing_street_direction_pcnt *   0.00 / 100 + T.Populated_continuting_street_route_segment_pcnt *   0.00 / 100 + T.Populated_city_type_pcnt *   0.00 / 100 + T.Populated_outside_city_indicator_pcnt *   0.00 / 100 + T.Populated_outside_city_direction_pcnt *   0.00 / 100 + T.Populated_outside_city_distance_feet_pcnt *   0.00 / 100 + T.Populated_outside_city_distance_miles_pcnt *   0.00 / 100 + T.Populated_crash_type_pcnt *   0.00 / 100 + T.Populated_motor_vehicle_involved_with_pcnt *   0.00 / 100 + T.Populated_report_investigation_type_pcnt *   0.00 / 100 + T.Populated_incident_hit_and_run_pcnt *   0.00 / 100 + T.Populated_tow_away_pcnt *   0.00 / 100 + T.Populated_date_notified_pcnt *   0.00 / 100 + T.Populated_time_notified_pcnt *   0.00 / 100 + T.Populated_notification_method_pcnt *   0.00 / 100 + T.Populated_officer_arrival_time_pcnt *   0.00 / 100 + T.Populated_officer_report_date_pcnt *   0.00 / 100 + T.Populated_officer_report_time_pcnt *   0.00 / 100 + T.Populated_officer_id_pcnt *   0.00 / 100 + T.Populated_officer_department_pcnt *   0.00 / 100 + T.Populated_officer_rank_pcnt *   0.00 / 100 + T.Populated_officer_command_pcnt *   0.00 / 100 + T.Populated_officer_tax_id_number_pcnt *   0.00 / 100 + T.Populated_completed_report_date_pcnt *   0.00 / 100 + T.Populated_supervisor_check_date_pcnt *   0.00 / 100 + T.Populated_supervisor_check_time_pcnt *   0.00 / 100 + T.Populated_supervisor_id_pcnt *   0.00 / 100 + T.Populated_supervisor_rank_pcnt *   0.00 / 100 + T.Populated_reviewers_name_pcnt *   0.00 / 100 + T.Populated_road_surface_pcnt *   0.00 / 100 + T.Populated_roadway_alignment_pcnt *   0.00 / 100 + T.Populated_traffic_way_description_pcnt *   0.00 / 100 + T.Populated_traffic_flow_pcnt *   0.00 / 100 + T.Populated_property_damage_involved_pcnt *   0.00 / 100 + T.Populated_property_damage_description1_pcnt *   0.00 / 100 + T.Populated_property_damage_description2_pcnt *   0.00 / 100 + T.Populated_property_damage_estimate1_pcnt *   0.00 / 100 + T.Populated_property_damage_estimate2_pcnt *   0.00 / 100 + T.Populated_incident_damage_over_limit_pcnt *   0.00 / 100 + T.Populated_property_owner_notified_pcnt *   0.00 / 100 + T.Populated_government_property_pcnt *   0.00 / 100 + T.Populated_accident_condition_pcnt *   0.00 / 100 + T.Populated_unusual_road_condition1_pcnt *   0.00 / 100 + T.Populated_unusual_road_condition2_pcnt *   0.00 / 100 + T.Populated_number_of_lanes_pcnt *   0.00 / 100 + T.Populated_divided_highway_pcnt *   0.00 / 100 + T.Populated_most_harmful_event_pcnt *   0.00 / 100 + T.Populated_second_harmful_event_pcnt *   0.00 / 100 + T.Populated_ems_notified_date_pcnt *   0.00 / 100 + T.Populated_ems_arrival_date_pcnt *   0.00 / 100 + T.Populated_hospital_arrival_date_pcnt *   0.00 / 100 + T.Populated_injured_taken_by_pcnt *   0.00 / 100 + T.Populated_injured_taken_to_pcnt *   0.00 / 100 + T.Populated_incident_transported_for_medical_care_pcnt *   0.00 / 100 + T.Populated_photographs_taken_pcnt *   0.00 / 100 + T.Populated_photographed_by_pcnt *   0.00 / 100 + T.Populated_photographer_id_pcnt *   0.00 / 100 + T.Populated_photography_agency_name_pcnt *   0.00 / 100 + T.Populated_agency_name_pcnt *   0.00 / 100 + T.Populated_judicial_district_pcnt *   0.00 / 100 + T.Populated_precinct_pcnt *   0.00 / 100 + T.Populated_beat_pcnt *   0.00 / 100 + T.Populated_location_type_pcnt *   0.00 / 100 + T.Populated_shoulder_type_pcnt *   0.00 / 100 + T.Populated_investigation_complete_pcnt *   0.00 / 100 + T.Populated_investigation_not_complete_why_pcnt *   0.00 / 100 + T.Populated_investigating_officer_name_pcnt *   0.00 / 100 + T.Populated_investigation_notification_issued_pcnt *   0.00 / 100 + T.Populated_agency_type_pcnt *   0.00 / 100 + T.Populated_no_injury_tow_involved_pcnt *   0.00 / 100 + T.Populated_injury_tow_involved_pcnt *   0.00 / 100 + T.Populated_lars_code1_pcnt *   0.00 / 100 + T.Populated_lars_code2_pcnt *   0.00 / 100 + T.Populated_private_property_incident_pcnt *   0.00 / 100 + T.Populated_accident_involvement_pcnt *   0.00 / 100 + T.Populated_local_use_pcnt *   0.00 / 100 + T.Populated_street_prefix_pcnt *   0.00 / 100 + T.Populated_street_suffix_pcnt *   0.00 / 100 + T.Populated_toll_road_pcnt *   0.00 / 100 + T.Populated_street_description_pcnt *   0.00 / 100 + T.Populated_cross_street_address_number_pcnt *   0.00 / 100 + T.Populated_cross_street_prefix_pcnt *   0.00 / 100 + T.Populated_cross_street_suffix_pcnt *   0.00 / 100 + T.Populated_report_complete_pcnt *   0.00 / 100 + T.Populated_dispatch_notified_pcnt *   0.00 / 100 + T.Populated_counter_report_pcnt *   0.00 / 100 + T.Populated_road_type_pcnt *   0.00 / 100 + T.Populated_agency_code_pcnt *   0.00 / 100 + T.Populated_public_property_employee_pcnt *   0.00 / 100 + T.Populated_bridge_related_pcnt *   0.00 / 100 + T.Populated_ramp_indicator_pcnt *   0.00 / 100 + T.Populated_to_or_from_location_pcnt *   0.00 / 100 + T.Populated_complaint_number_pcnt *   0.00 / 100 + T.Populated_school_zone_related_pcnt *   0.00 / 100 + T.Populated_notify_dot_maintenance_pcnt *   0.00 / 100 + T.Populated_special_location_pcnt *   0.00 / 100 + T.Populated_route_segment_pcnt *   0.00 / 100 + T.Populated_route_sign_pcnt *   0.00 / 100 + T.Populated_route_category_street_pcnt *   0.00 / 100 + T.Populated_route_category_cross_street_pcnt *   0.00 / 100 + T.Populated_route_category_next_street_pcnt *   0.00 / 100 + T.Populated_lane_closed_pcnt *   0.00 / 100 + T.Populated_lane_closure_direction_pcnt *   0.00 / 100 + T.Populated_lane_direction_pcnt *   0.00 / 100 + T.Populated_traffic_detoured_pcnt *   0.00 / 100 + T.Populated_time_closed_pcnt *   0.00 / 100 + T.Populated_pedestrian_signals_pcnt *   0.00 / 100 + T.Populated_work_zone_speed_limit_pcnt *   0.00 / 100 + T.Populated_work_zone_shoulder_median_pcnt *   0.00 / 100 + T.Populated_work_zone_intermittent_moving_pcnt *   0.00 / 100 + T.Populated_work_zone_flagger_control_pcnt *   0.00 / 100 + T.Populated_special_work_zone_characteristics_pcnt *   0.00 / 100 + T.Populated_lane_number_pcnt *   0.00 / 100 + T.Populated_offset_distance_feet_pcnt *   0.00 / 100 + T.Populated_offset_distance_miles_pcnt *   0.00 / 100 + T.Populated_offset_direction_pcnt *   0.00 / 100 + T.Populated_asru_code_pcnt *   0.00 / 100 + T.Populated_mp_grid_pcnt *   0.00 / 100 + T.Populated_number_of_qualifying_units_pcnt *   0.00 / 100 + T.Populated_number_of_hazmat_vehicles_pcnt *   0.00 / 100 + T.Populated_number_of_buses_involved_pcnt *   0.00 / 100 + T.Populated_number_taken_to_treatment_pcnt *   0.00 / 100 + T.Populated_number_vehicles_towed_pcnt *   0.00 / 100 + T.Populated_vehicle_at_fault_unit_number_pcnt *   0.00 / 100 + T.Populated_time_officer_cleared_scene_pcnt *   0.00 / 100 + T.Populated_total_minutes_on_scene_pcnt *   0.00 / 100 + T.Populated_motorists_report_pcnt *   0.00 / 100 + T.Populated_fatality_involved_pcnt *   0.00 / 100 + T.Populated_local_dot_index_number_pcnt *   0.00 / 100 + T.Populated_dor_number_pcnt *   0.00 / 100 + T.Populated_hospital_code_pcnt *   0.00 / 100 + T.Populated_special_jurisdiction_pcnt *   0.00 / 100 + T.Populated_document_type_pcnt *   0.00 / 100 + T.Populated_distance_was_measured_pcnt *   0.00 / 100 + T.Populated_street_orientation_pcnt *   0.00 / 100 + T.Populated_intersecting_route_segment_pcnt *   0.00 / 100 + T.Populated_primary_fault_indicator_pcnt *   0.00 / 100 + T.Populated_first_harmful_event_pedestrian_pcnt *   0.00 / 100 + T.Populated_reference_markers_pcnt *   0.00 / 100 + T.Populated_other_officer_on_scene_pcnt *   0.00 / 100 + T.Populated_other_officer_badge_number_pcnt *   0.00 / 100 + T.Populated_supplemental_report_pcnt *   0.00 / 100 + T.Populated_supplemental_type_pcnt *   0.00 / 100 + T.Populated_amended_report_pcnt *   0.00 / 100 + T.Populated_corrected_report_pcnt *   0.00 / 100 + T.Populated_state_highway_related_pcnt *   0.00 / 100 + T.Populated_roadway_lighting_condition_pcnt *   0.00 / 100 + T.Populated_vendor_reference_number_pcnt *   0.00 / 100 + T.Populated_duplicate_copy_unit_number_pcnt *   0.00 / 100 + T.Populated_other_city_agency_description_pcnt *   0.00 / 100 + T.Populated_notifcation_description_pcnt *   0.00 / 100 + T.Populated_primary_collision_improper_driving_description_pcnt *   0.00 / 100 + T.Populated_weather_other_description_pcnt *   0.00 / 100 + T.Populated_crash_type_description_pcnt *   0.00 / 100 + T.Populated_motor_vehicle_involved_with_animal_description_pcnt *   0.00 / 100 + T.Populated_motor_vehicle_involved_with_fixed_object_description_pcnt *   0.00 / 100 + T.Populated_motor_vehicle_involved_with_other_object_description_pcnt *   0.00 / 100 + T.Populated_other_investigation_time_pcnt *   0.00 / 100 + T.Populated_milepost_detail_pcnt *   0.00 / 100 + T.Populated_utility_pole_number1_pcnt *   0.00 / 100 + T.Populated_utility_pole_number2_pcnt *   0.00 / 100 + T.Populated_utility_pole_number3_pcnt *   0.00 / 100 + T.Populated_person_id_pcnt *   0.00 / 100 + T.Populated_person_number_pcnt *   0.00 / 100 + T.Populated_vehicle_unit_number_pcnt *   0.00 / 100 + T.Populated_sex_pcnt *   0.00 / 100 + T.Populated_person_type_pcnt *   0.00 / 100 + T.Populated_injury_status_pcnt *   0.00 / 100 + T.Populated_occupant_vehicle_unit_number_pcnt *   0.00 / 100 + T.Populated_seating_position1_pcnt *   0.00 / 100 + T.Populated_safety_equipment_restraint1_pcnt *   0.00 / 100 + T.Populated_safety_equipment_restraint2_pcnt *   0.00 / 100 + T.Populated_safety_equipment_helmet_pcnt *   0.00 / 100 + T.Populated_air_bag_deployed_pcnt *   0.00 / 100 + T.Populated_ejection_pcnt *   0.00 / 100 + T.Populated_drivers_license_jurisdiction_pcnt *   0.00 / 100 + T.Populated_dl_number_class_pcnt *   0.00 / 100 + T.Populated_dl_number_cdl_pcnt *   0.00 / 100 + T.Populated_dl_number_endorsements_pcnt *   0.00 / 100 + T.Populated_driver_actions_at_time_of_crash1_pcnt *   0.00 / 100 + T.Populated_driver_actions_at_time_of_crash2_pcnt *   0.00 / 100 + T.Populated_driver_actions_at_time_of_crash3_pcnt *   0.00 / 100 + T.Populated_driver_actions_at_time_of_crash4_pcnt *   0.00 / 100 + T.Populated_violation_codes_pcnt *   0.00 / 100 + T.Populated_condition_at_time_of_crash1_pcnt *   0.00 / 100 + T.Populated_condition_at_time_of_crash2_pcnt *   0.00 / 100 + T.Populated_law_enforcement_suspects_alcohol_use_pcnt *   0.00 / 100 + T.Populated_alcohol_test_status_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_pcnt *   0.00 / 100 + T.Populated_alcohol_test_result_pcnt *   0.00 / 100 + T.Populated_law_enforcement_suspects_drug_use_pcnt *   0.00 / 100 + T.Populated_drug_test_given_pcnt *   0.00 / 100 + T.Populated_non_motorist_actions_prior_to_crash1_pcnt *   0.00 / 100 + T.Populated_non_motorist_actions_prior_to_crash2_pcnt *   0.00 / 100 + T.Populated_non_motorist_actions_at_time_of_crash_pcnt *   0.00 / 100 + T.Populated_non_motorist_location_at_time_of_crash_pcnt *   0.00 / 100 + T.Populated_non_motorist_safety_equipment1_pcnt *   0.00 / 100 + T.Populated_age_pcnt *   0.00 / 100 + T.Populated_driver_license_restrictions1_pcnt *   0.00 / 100 + T.Populated_drug_test_type_pcnt *   0.00 / 100 + T.Populated_drug_test_result1_pcnt *   0.00 / 100 + T.Populated_drug_test_result2_pcnt *   0.00 / 100 + T.Populated_drug_test_result3_pcnt *   0.00 / 100 + T.Populated_drug_test_result4_pcnt *   0.00 / 100 + T.Populated_injury_area_pcnt *   0.00 / 100 + T.Populated_injury_description_pcnt *   0.00 / 100 + T.Populated_motorcyclist_head_injury_pcnt *   0.00 / 100 + T.Populated_party_id_pcnt *   0.00 / 100 + T.Populated_same_as_driver_pcnt *   0.00 / 100 + T.Populated_address_same_as_driver_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_name_suffx_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_home_phone_pcnt *   0.00 / 100 + T.Populated_business_phone_pcnt *   0.00 / 100 + T.Populated_insurance_company_pcnt *   0.00 / 100 + T.Populated_insurance_company_phone_number_pcnt *   0.00 / 100 + T.Populated_insurance_policy_number_pcnt *   0.00 / 100 + T.Populated_insurance_effective_date_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_drivers_license_number_pcnt *   0.00 / 100 + T.Populated_drivers_license_expiration_pcnt *   0.00 / 100 + T.Populated_eye_color_pcnt *   0.00 / 100 + T.Populated_hair_color_pcnt *   0.00 / 100 + T.Populated_height_pcnt *   0.00 / 100 + T.Populated_weight_pcnt *   0.00 / 100 + T.Populated_race_pcnt *   0.00 / 100 + T.Populated_pedestrian_cyclist_visibility_pcnt *   0.00 / 100 + T.Populated_first_aid_by_pcnt *   0.00 / 100 + T.Populated_person_first_aid_party_type_pcnt *   0.00 / 100 + T.Populated_person_first_aid_party_type_description_pcnt *   0.00 / 100 + T.Populated_deceased_at_scene_pcnt *   0.00 / 100 + T.Populated_death_date_pcnt *   0.00 / 100 + T.Populated_death_time_pcnt *   0.00 / 100 + T.Populated_extricated_pcnt *   0.00 / 100 + T.Populated_alcohol_drug_use_pcnt *   0.00 / 100 + T.Populated_physical_defects_pcnt *   0.00 / 100 + T.Populated_driver_residence_pcnt *   0.00 / 100 + T.Populated_id_type_pcnt *   0.00 / 100 + T.Populated_proof_of_insurance_pcnt *   0.00 / 100 + T.Populated_insurance_expired_pcnt *   0.00 / 100 + T.Populated_insurance_exempt_pcnt *   0.00 / 100 + T.Populated_insurance_type_pcnt *   0.00 / 100 + T.Populated_violent_crime_victim_notified_pcnt *   0.00 / 100 + T.Populated_insurance_company_code_pcnt *   0.00 / 100 + T.Populated_refused_medical_treatment_pcnt *   0.00 / 100 + T.Populated_safety_equipment_available_or_used_pcnt *   0.00 / 100 + T.Populated_apartment_number_pcnt *   0.00 / 100 + T.Populated_licensed_driver_pcnt *   0.00 / 100 + T.Populated_physical_emotional_status_pcnt *   0.00 / 100 + T.Populated_driver_presence_pcnt *   0.00 / 100 + T.Populated_ejection_path_pcnt *   0.00 / 100 + T.Populated_state_person_id_pcnt *   0.00 / 100 + T.Populated_contributed_to_collision_pcnt *   0.00 / 100 + T.Populated_person_transported_for_medical_care_pcnt *   0.00 / 100 + T.Populated_transported_by_agency_type_pcnt *   0.00 / 100 + T.Populated_transported_to_pcnt *   0.00 / 100 + T.Populated_non_motorist_driver_license_number_pcnt *   0.00 / 100 + T.Populated_air_bag_type_pcnt *   0.00 / 100 + T.Populated_cell_phone_use_pcnt *   0.00 / 100 + T.Populated_driver_license_restriction_compliance_pcnt *   0.00 / 100 + T.Populated_driver_license_endorsement_compliance_pcnt *   0.00 / 100 + T.Populated_driver_license_compliance_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_p1_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_p2_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_p3_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_p4_pcnt *   0.00 / 100 + T.Populated_passenger_number_pcnt *   0.00 / 100 + T.Populated_person_deleted_pcnt *   0.00 / 100 + T.Populated_owner_lessee_pcnt *   0.00 / 100 + T.Populated_driver_charged_pcnt *   0.00 / 100 + T.Populated_motorcycle_eye_protection_pcnt *   0.00 / 100 + T.Populated_motorcycle_long_sleeves_pcnt *   0.00 / 100 + T.Populated_motorcycle_long_pants_pcnt *   0.00 / 100 + T.Populated_motorcycle_over_ankle_boots_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental_non_incident1_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_environmental_non_incident2_pcnt *   0.00 / 100 + T.Populated_alcohol_drug_test_given_pcnt *   0.00 / 100 + T.Populated_alcohol_drug_test_type_pcnt *   0.00 / 100 + T.Populated_alcohol_drug_test_result_pcnt *   0.00 / 100 + T.Populated_vin_pcnt *   0.00 / 100 + T.Populated_vin_status_pcnt *   0.00 / 100 + T.Populated_damaged_areas_derived1_pcnt *   0.00 / 100 + T.Populated_damaged_areas_derived2_pcnt *   0.00 / 100 + T.Populated_airbags_deployed_derived_pcnt *   0.00 / 100 + T.Populated_vehicle_towed_derived_pcnt *   0.00 / 100 + T.Populated_unit_type_pcnt *   0.00 / 100 + T.Populated_unit_number_pcnt *   0.00 / 100 + T.Populated_registration_state_pcnt *   0.00 / 100 + T.Populated_registration_year_pcnt *   0.00 / 100 + T.Populated_license_plate_pcnt *   0.00 / 100 + T.Populated_make_pcnt *   0.00 / 100 + T.Populated_model_yr_pcnt *   0.00 / 100 + T.Populated_model_pcnt *   0.00 / 100 + T.Populated_body_type_category_pcnt *   0.00 / 100 + T.Populated_total_occupants_in_vehicle_pcnt *   0.00 / 100 + T.Populated_special_function_in_transport_pcnt *   0.00 / 100 + T.Populated_special_function_in_transport_other_unit_pcnt *   0.00 / 100 + T.Populated_emergency_use_pcnt *   0.00 / 100 + T.Populated_posted_satutory_speed_limit_pcnt *   0.00 / 100 + T.Populated_direction_of_travel_before_crash_pcnt *   0.00 / 100 + T.Populated_trafficway_description_pcnt *   0.00 / 100 + T.Populated_traffic_control_device_type_pcnt *   0.00 / 100 + T.Populated_vehicle_maneuver_action_prior1_pcnt *   0.00 / 100 + T.Populated_vehicle_maneuver_action_prior2_pcnt *   0.00 / 100 + T.Populated_impact_area1_pcnt *   0.00 / 100 + T.Populated_impact_area2_pcnt *   0.00 / 100 + T.Populated_event_sequence1_pcnt *   0.00 / 100 + T.Populated_event_sequence2_pcnt *   0.00 / 100 + T.Populated_event_sequence3_pcnt *   0.00 / 100 + T.Populated_event_sequence4_pcnt *   0.00 / 100 + T.Populated_most_harmful_event_for_vehicle_pcnt *   0.00 / 100 + T.Populated_bus_use_pcnt *   0.00 / 100 + T.Populated_vehicle_hit_and_run_pcnt *   0.00 / 100 + T.Populated_vehicle_towed_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_v1_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_v2_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_v3_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_v4_pcnt *   0.00 / 100 + T.Populated_on_street_pcnt *   0.00 / 100 + T.Populated_vehicle_color_pcnt *   0.00 / 100 + T.Populated_estimated_speed_pcnt *   0.00 / 100 + T.Populated_accident_investigation_site_pcnt *   0.00 / 100 + T.Populated_car_fire_pcnt *   0.00 / 100 + T.Populated_vehicle_damage_amount_pcnt *   0.00 / 100 + T.Populated_contributing_factors1_pcnt *   0.00 / 100 + T.Populated_contributing_factors2_pcnt *   0.00 / 100 + T.Populated_contributing_factors3_pcnt *   0.00 / 100 + T.Populated_contributing_factors4_pcnt *   0.00 / 100 + T.Populated_other_contributing_factors1_pcnt *   0.00 / 100 + T.Populated_other_contributing_factors2_pcnt *   0.00 / 100 + T.Populated_other_contributing_factors3_pcnt *   0.00 / 100 + T.Populated_vision_obscured1_pcnt *   0.00 / 100 + T.Populated_vision_obscured2_pcnt *   0.00 / 100 + T.Populated_vehicle_on_road_pcnt *   0.00 / 100 + T.Populated_ran_off_road_pcnt *   0.00 / 100 + T.Populated_skidding_occurred_pcnt *   0.00 / 100 + T.Populated_vehicle_incident_location1_pcnt *   0.00 / 100 + T.Populated_vehicle_incident_location2_pcnt *   0.00 / 100 + T.Populated_vehicle_incident_location3_pcnt *   0.00 / 100 + T.Populated_vehicle_disabled_pcnt *   0.00 / 100 + T.Populated_vehicle_removed_to_pcnt *   0.00 / 100 + T.Populated_removed_by_pcnt *   0.00 / 100 + T.Populated_tow_requested_by_driver_pcnt *   0.00 / 100 + T.Populated_solicitation_pcnt *   0.00 / 100 + T.Populated_other_unit_vehicle_damage_amount_pcnt *   0.00 / 100 + T.Populated_other_unit_model_year_pcnt *   0.00 / 100 + T.Populated_other_unit_make_pcnt *   0.00 / 100 + T.Populated_other_unit_model_pcnt *   0.00 / 100 + T.Populated_other_unit_vin_pcnt *   0.00 / 100 + T.Populated_other_unit_vin_status_pcnt *   0.00 / 100 + T.Populated_other_unit_body_type_category_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_state_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_year_pcnt *   0.00 / 100 + T.Populated_other_unit_license_plate_pcnt *   0.00 / 100 + T.Populated_other_unit_color_pcnt *   0.00 / 100 + T.Populated_other_unit_type_pcnt *   0.00 / 100 + T.Populated_damaged_areas1_pcnt *   0.00 / 100 + T.Populated_damaged_areas2_pcnt *   0.00 / 100 + T.Populated_parked_vehicle_pcnt *   0.00 / 100 + T.Populated_damage_rating1_pcnt *   0.00 / 100 + T.Populated_damage_rating2_pcnt *   0.00 / 100 + T.Populated_vehicle_inventoried_pcnt *   0.00 / 100 + T.Populated_vehicle_defect_apparent_pcnt *   0.00 / 100 + T.Populated_defect_may_have_contributed1_pcnt *   0.00 / 100 + T.Populated_defect_may_have_contributed2_pcnt *   0.00 / 100 + T.Populated_registration_expiration_pcnt *   0.00 / 100 + T.Populated_owner_driver_type_pcnt *   0.00 / 100 + T.Populated_make_code_pcnt *   0.00 / 100 + T.Populated_number_trailing_units_pcnt *   0.00 / 100 + T.Populated_vehicle_position_pcnt *   0.00 / 100 + T.Populated_vehicle_type_pcnt *   0.00 / 100 + T.Populated_motorcycle_engine_size_pcnt *   0.00 / 100 + T.Populated_motorcycle_driver_educated_pcnt *   0.00 / 100 + T.Populated_motorcycle_helmet_type_pcnt *   0.00 / 100 + T.Populated_motorcycle_passenger_pcnt *   0.00 / 100 + T.Populated_motorcycle_helmet_stayed_on_pcnt *   0.00 / 100 + T.Populated_motorcycle_helmet_dot_snell_pcnt *   0.00 / 100 + T.Populated_motorcycle_saddlebag_trunk_pcnt *   0.00 / 100 + T.Populated_motorcycle_trailer_pcnt *   0.00 / 100 + T.Populated_pedacycle_passenger_pcnt *   0.00 / 100 + T.Populated_pedacycle_headlights_pcnt *   0.00 / 100 + T.Populated_pedacycle_helmet_pcnt *   0.00 / 100 + T.Populated_pedacycle_rear_reflectors_pcnt *   0.00 / 100 + T.Populated_cdl_required_pcnt *   0.00 / 100 + T.Populated_truck_bus_supplement_required_pcnt *   0.00 / 100 + T.Populated_unit_damage_amount_pcnt *   0.00 / 100 + T.Populated_airbag_switch_pcnt *   0.00 / 100 + T.Populated_underride_override_damage_pcnt *   0.00 / 100 + T.Populated_vehicle_attachment_pcnt *   0.00 / 100 + T.Populated_action_on_impact_pcnt *   0.00 / 100 + T.Populated_speed_detection_method_pcnt *   0.00 / 100 + T.Populated_non_motorist_direction_of_travel_from_pcnt *   0.00 / 100 + T.Populated_non_motorist_direction_of_travel_to_pcnt *   0.00 / 100 + T.Populated_vehicle_use_pcnt *   0.00 / 100 + T.Populated_department_unit_number_pcnt *   0.00 / 100 + T.Populated_equipment_in_use_at_time_of_accident_pcnt *   0.00 / 100 + T.Populated_actions_of_police_vehicle_pcnt *   0.00 / 100 + T.Populated_vehicle_command_id_pcnt *   0.00 / 100 + T.Populated_traffic_control_device_inoperative_pcnt *   0.00 / 100 + T.Populated_direction_of_impact1_pcnt *   0.00 / 100 + T.Populated_direction_of_impact2_pcnt *   0.00 / 100 + T.Populated_ran_off_road_direction_pcnt *   0.00 / 100 + T.Populated_vin_other_unit_number_pcnt *   0.00 / 100 + T.Populated_damaged_area_generic_pcnt *   0.00 / 100 + T.Populated_vision_obscured_description_pcnt *   0.00 / 100 + T.Populated_inattention_description_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_defect_description_pcnt *   0.00 / 100 + T.Populated_contributing_circumstances_other_descriptioin_pcnt *   0.00 / 100 + T.Populated_vehicle_maneuver_action_prior_other_description_pcnt *   0.00 / 100 + T.Populated_vehicle_special_use_pcnt *   0.00 / 100 + T.Populated_vehicle_type_extended1_pcnt *   0.00 / 100 + T.Populated_vehicle_type_extended2_pcnt *   0.00 / 100 + T.Populated_fixed_object_direction1_pcnt *   0.00 / 100 + T.Populated_fixed_object_direction2_pcnt *   0.00 / 100 + T.Populated_fixed_object_direction3_pcnt *   0.00 / 100 + T.Populated_fixed_object_direction4_pcnt *   0.00 / 100 + T.Populated_vehicle_left_at_scene_pcnt *   0.00 / 100 + T.Populated_vehicle_impounded_pcnt *   0.00 / 100 + T.Populated_vehicle_driven_from_scene_pcnt *   0.00 / 100 + T.Populated_on_cross_street_pcnt *   0.00 / 100 + T.Populated_actions_of_police_vehicle_description_pcnt *   0.00 / 100 + T.Populated_vehicle_seg_pcnt *   0.00 / 100 + T.Populated_vehicle_seg_type_pcnt *   0.00 / 100 + T.Populated_model_year_pcnt *   0.00 / 100 + T.Populated_body_style_code_pcnt *   0.00 / 100 + T.Populated_engine_size_pcnt *   0.00 / 100 + T.Populated_fuel_code_pcnt *   0.00 / 100 + T.Populated_number_of_driving_wheels_pcnt *   0.00 / 100 + T.Populated_steering_type_pcnt *   0.00 / 100 + T.Populated_vina_series_pcnt *   0.00 / 100 + T.Populated_vina_model_pcnt *   0.00 / 100 + T.Populated_vina_make_pcnt *   0.00 / 100 + T.Populated_vina_body_style_pcnt *   0.00 / 100 + T.Populated_make_description_pcnt *   0.00 / 100 + T.Populated_model_description_pcnt *   0.00 / 100 + T.Populated_series_description_pcnt *   0.00 / 100 + T.Populated_car_cylinders_pcnt *   0.00 / 100 + T.Populated_other_vehicle_seg_pcnt *   0.00 / 100 + T.Populated_other_vehicle_seg_type_pcnt *   0.00 / 100 + T.Populated_other_model_year_pcnt *   0.00 / 100 + T.Populated_other_body_style_code_pcnt *   0.00 / 100 + T.Populated_other_engine_size_pcnt *   0.00 / 100 + T.Populated_other_fuel_code_pcnt *   0.00 / 100 + T.Populated_other_number_of_driving_wheels_pcnt *   0.00 / 100 + T.Populated_other_steering_type_pcnt *   0.00 / 100 + T.Populated_other_vina_series_pcnt *   0.00 / 100 + T.Populated_other_vina_model_pcnt *   0.00 / 100 + T.Populated_other_vina_make_pcnt *   0.00 / 100 + T.Populated_other_vina_body_style_pcnt *   0.00 / 100 + T.Populated_other_make_description_pcnt *   0.00 / 100 + T.Populated_other_model_description_pcnt *   0.00 / 100 + T.Populated_other_series_description_pcnt *   0.00 / 100 + T.Populated_other_car_cylinders_pcnt *   0.00 / 100 + T.Populated_report_has_coversheet_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_z5_pcnt *   0.00 / 100 + T.Populated_z4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_code_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_nametype_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_title2_pcnt *   0.00 / 100 + T.Populated_fname2_pcnt *   0.00 / 100 + T.Populated_mname2_pcnt *   0.00 / 100 + T.Populated_lname2_pcnt *   0.00 / 100 + T.Populated_suffix2_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_law_enforcement_suspects_alcohol_use1_pcnt *   0.00 / 100 + T.Populated_law_enforcement_suspects_drug_use1_pcnt *   0.00 / 100 + T.Populated_ems_notified_time_pcnt *   0.00 / 100 + T.Populated_ems_arrival_time_pcnt *   0.00 / 100 + T.Populated_avoidance_maneuver2_pcnt *   0.00 / 100 + T.Populated_avoidance_maneuver3_pcnt *   0.00 / 100 + T.Populated_avoidance_maneuver4_pcnt *   0.00 / 100 + T.Populated_damaged_areas_severity1_pcnt *   0.00 / 100 + T.Populated_damaged_areas_severity2_pcnt *   0.00 / 100 + T.Populated_vehicle_outside_city_indicator_pcnt *   0.00 / 100 + T.Populated_vehicle_outside_city_distance_miles_pcnt *   0.00 / 100 + T.Populated_vehicle_outside_city_direction_pcnt *   0.00 / 100 + T.Populated_vehicle_crash_cityplace_pcnt *   0.00 / 100 + T.Populated_insurance_company_standardized_pcnt *   0.00 / 100 + T.Populated_insurance_expiration_date_pcnt *   0.00 / 100 + T.Populated_insurance_policy_holder_pcnt *   0.00 / 100 + T.Populated_is_tag_converted_pcnt *   0.00 / 100 + T.Populated_vin_original_pcnt *   0.00 / 100 + T.Populated_make_original_pcnt *   0.00 / 100 + T.Populated_model_original_pcnt *   0.00 / 100 + T.Populated_model_year_original_pcnt *   0.00 / 100 + T.Populated_other_unit_vin_original_pcnt *   0.00 / 100 + T.Populated_other_unit_make_original_pcnt *   0.00 / 100 + T.Populated_other_unit_model_original_pcnt *   0.00 / 100 + T.Populated_other_unit_model_year_original_pcnt *   0.00 / 100 + T.Populated_source_id_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_initial_point_of_contact_pcnt *   0.00 / 100 + T.Populated_vehicle_driveable_pcnt *   0.00 / 100 + T.Populated_drivers_license_type_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_refused_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_not_offered_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_field_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_pbt_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_breath_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_blood_pcnt *   0.00 / 100 + T.Populated_alcohol_test_type_urine_pcnt *   0.00 / 100 + T.Populated_trapped_pcnt *   0.00 / 100 + T.Populated_dl_number_cdl_endorsements_pcnt *   0.00 / 100 + T.Populated_dl_number_cdl_restrictions_pcnt *   0.00 / 100 + T.Populated_dl_number_cdl_exempt_pcnt *   0.00 / 100 + T.Populated_dl_number_cdl_medical_card_pcnt *   0.00 / 100 + T.Populated_interlock_device_in_use_pcnt *   0.00 / 100 + T.Populated_drug_test_type_blood_pcnt *   0.00 / 100 + T.Populated_drug_test_type_urine_pcnt *   0.00 / 100 + T.Populated_traffic_control_condition_pcnt *   0.00 / 100 + T.Populated_intersection_related_pcnt *   0.00 / 100 + T.Populated_special_study_local_pcnt *   0.00 / 100 + T.Populated_special_study_state_pcnt *   0.00 / 100 + T.Populated_off_road_vehicle_involved_pcnt *   0.00 / 100 + T.Populated_location_type2_pcnt *   0.00 / 100 + T.Populated_speed_limit_posted_pcnt *   0.00 / 100 + T.Populated_traffic_control_damage_notify_date_pcnt *   0.00 / 100 + T.Populated_traffic_control_damage_notify_time_pcnt *   0.00 / 100 + T.Populated_traffic_control_damage_notify_name_pcnt *   0.00 / 100 + T.Populated_public_property_damaged_pcnt *   0.00 / 100 + T.Populated_replacement_report_pcnt *   0.00 / 100 + T.Populated_deleted_report_pcnt *   0.00 / 100 + T.Populated_next_street_prefix_pcnt *   0.00 / 100 + T.Populated_violator_name_pcnt *   0.00 / 100 + T.Populated_type_hazardous_pcnt *   0.00 / 100 + T.Populated_type_other_pcnt *   0.00 / 100 + T.Populated_unit_type_and_axles1_pcnt *   0.00 / 100 + T.Populated_unit_type_and_axles2_pcnt *   0.00 / 100 + T.Populated_unit_type_and_axles3_pcnt *   0.00 / 100 + T.Populated_unit_type_and_axles4_pcnt *   0.00 / 100 + T.Populated_incident_damage_amount_pcnt *   0.00 / 100 + T.Populated_dot_use_pcnt *   0.00 / 100 + T.Populated_number_of_persons_involved_pcnt *   0.00 / 100 + T.Populated_unusual_road_condition_other_description_pcnt *   0.00 / 100 + T.Populated_number_of_narrative_sections_pcnt *   0.00 / 100 + T.Populated_cad_number_pcnt *   0.00 / 100 + T.Populated_visibility_pcnt *   0.00 / 100 + T.Populated_accident_at_intersection_pcnt *   0.00 / 100 + T.Populated_accident_not_at_intersection_pcnt *   0.00 / 100 + T.Populated_first_harmful_event_within_interchange_pcnt *   0.00 / 100 + T.Populated_injury_involved_pcnt *   0.00 / 100 + T.Populated_citation_status_pcnt *   0.00 / 100 + T.Populated_commercial_vehicle_pcnt *   0.00 / 100 + T.Populated_not_in_transport_pcnt *   0.00 / 100 + T.Populated_other_unit_number_pcnt *   0.00 / 100 + T.Populated_other_unit_length_pcnt *   0.00 / 100 + T.Populated_other_unit_axles_pcnt *   0.00 / 100 + T.Populated_other_unit_plate_expiration_pcnt *   0.00 / 100 + T.Populated_other_unit_permanent_registration_pcnt *   0.00 / 100 + T.Populated_other_unit_model_year2_pcnt *   0.00 / 100 + T.Populated_other_unit_make2_pcnt *   0.00 / 100 + T.Populated_other_unit_vin2_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_state2_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_year2_pcnt *   0.00 / 100 + T.Populated_other_unit_license_plate2_pcnt *   0.00 / 100 + T.Populated_other_unit_number2_pcnt *   0.00 / 100 + T.Populated_other_unit_length2_pcnt *   0.00 / 100 + T.Populated_other_unit_axles2_pcnt *   0.00 / 100 + T.Populated_other_unit_plate_expiration2_pcnt *   0.00 / 100 + T.Populated_other_unit_permanent_registration2_pcnt *   0.00 / 100 + T.Populated_other_unit_type2_pcnt *   0.00 / 100 + T.Populated_other_unit_model_year3_pcnt *   0.00 / 100 + T.Populated_other_unit_make3_pcnt *   0.00 / 100 + T.Populated_other_unit_vin3_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_state3_pcnt *   0.00 / 100 + T.Populated_other_unit_registration_year3_pcnt *   0.00 / 100 + T.Populated_other_unit_license_plate3_pcnt *   0.00 / 100 + T.Populated_other_unit_number3_pcnt *   0.00 / 100 + T.Populated_other_unit_length3_pcnt *   0.00 / 100 + T.Populated_other_unit_axles3_pcnt *   0.00 / 100 + T.Populated_other_unit_plate_expiration3_pcnt *   0.00 / 100 + T.Populated_other_unit_permanent_registration3_pcnt *   0.00 / 100 + T.Populated_other_unit_type3_pcnt *   0.00 / 100 + T.Populated_damaged_areas3_pcnt *   0.00 / 100 + T.Populated_driver_distracted_by_pcnt *   0.00 / 100 + T.Populated_non_motorist_type_pcnt *   0.00 / 100 + T.Populated_seating_position_row_pcnt *   0.00 / 100 + T.Populated_seating_position_seat_pcnt *   0.00 / 100 + T.Populated_seating_position_description_pcnt *   0.00 / 100 + T.Populated_transported_id_number_pcnt *   0.00 / 100 + T.Populated_witness_number_pcnt *   0.00 / 100 + T.Populated_date_of_birth_derived_pcnt *   0.00 / 100 + T.Populated_property_damage_id_pcnt *   0.00 / 100 + T.Populated_property_owner_name_pcnt *   0.00 / 100 + T.Populated_damage_description_pcnt *   0.00 / 100 + T.Populated_damage_estimate_pcnt *   0.00 / 100 + T.Populated_narrative_pcnt *   0.00 / 100 + T.Populated_narrative_continuance_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_hazmat_placard_number1_pcnt *   0.00 / 100 + T.Populated_hazardous_materials_hazmat_placard_number2_pcnt *   0.00 / 100 + T.Populated_vendor_code_pcnt *   0.00 / 100 + T.Populated_report_property_damage_pcnt *   0.00 / 100 + T.Populated_report_collision_type_pcnt *   0.00 / 100 + T.Populated_report_first_harmful_event_pcnt *   0.00 / 100 + T.Populated_report_light_condition_pcnt *   0.00 / 100 + T.Populated_report_weather_condition_pcnt *   0.00 / 100 + T.Populated_report_road_condition_pcnt *   0.00 / 100 + T.Populated_report_injury_status_pcnt *   0.00 / 100 + T.Populated_report_damage_extent_pcnt *   0.00 / 100 + T.Populated_report_vehicle_type_pcnt *   0.00 / 100 + T.Populated_report_traffic_control_device_type_pcnt *   0.00 / 100 + T.Populated_report_contributing_circumstances_v_pcnt *   0.00 / 100 + T.Populated_report_vehicle_maneuver_action_prior_pcnt *   0.00 / 100 + T.Populated_report_vehicle_body_type_pcnt *   0.00 / 100 + T.Populated_cru_agency_name_pcnt *   0.00 / 100 + T.Populated_cru_agency_id_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_vendor_report_id_pcnt *   0.00 / 100 + T.Populated_is_available_for_public_pcnt *   0.00 / 100 + T.Populated_has_addendum_pcnt *   0.00 / 100 + T.Populated_report_agency_ori_pcnt *   0.00 / 100 + T.Populated_report_status_pcnt *   0.00 / 100 + T.Populated_super_report_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING report_code1;
    STRING report_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.report_code1 := le.Source;
    SELF.report_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_report_code_pcnt*ri.Populated_report_code_pcnt *   0.00 / 10000 + le.Populated_report_category_pcnt*ri.Populated_report_category_pcnt *   0.00 / 10000 + le.Populated_report_code_desc_pcnt*ri.Populated_report_code_desc_pcnt *   0.00 / 10000 + le.Populated_citation_id_pcnt*ri.Populated_citation_id_pcnt *   0.00 / 10000 + le.Populated_creation_date_pcnt*ri.Populated_creation_date_pcnt *   0.00 / 10000 + le.Populated_incident_id_pcnt*ri.Populated_incident_id_pcnt *   0.00 / 10000 + le.Populated_citation_issued_pcnt*ri.Populated_citation_issued_pcnt *   0.00 / 10000 + le.Populated_citation_number1_pcnt*ri.Populated_citation_number1_pcnt *   0.00 / 10000 + le.Populated_citation_number2_pcnt*ri.Populated_citation_number2_pcnt *   0.00 / 10000 + le.Populated_section_number1_pcnt*ri.Populated_section_number1_pcnt *   0.00 / 10000 + le.Populated_court_date_pcnt*ri.Populated_court_date_pcnt *   0.00 / 10000 + le.Populated_court_time_pcnt*ri.Populated_court_time_pcnt *   0.00 / 10000 + le.Populated_citation_detail1_pcnt*ri.Populated_citation_detail1_pcnt *   0.00 / 10000 + le.Populated_local_code_pcnt*ri.Populated_local_code_pcnt *   0.00 / 10000 + le.Populated_violation_code1_pcnt*ri.Populated_violation_code1_pcnt *   0.00 / 10000 + le.Populated_violation_code2_pcnt*ri.Populated_violation_code2_pcnt *   0.00 / 10000 + le.Populated_multiple_charges_indicator_pcnt*ri.Populated_multiple_charges_indicator_pcnt *   0.00 / 10000 + le.Populated_dui_indicator_pcnt*ri.Populated_dui_indicator_pcnt *   0.00 / 10000 + le.Populated_commercial_id_pcnt*ri.Populated_commercial_id_pcnt *   0.00 / 10000 + le.Populated_vehicle_id_pcnt*ri.Populated_vehicle_id_pcnt *   0.00 / 10000 + le.Populated_commercial_info_source_pcnt*ri.Populated_commercial_info_source_pcnt *   0.00 / 10000 + le.Populated_commercial_vehicle_type_pcnt*ri.Populated_commercial_vehicle_type_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_dot_number_pcnt*ri.Populated_motor_carrier_id_dot_number_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_state_id_pcnt*ri.Populated_motor_carrier_id_state_id_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_carrier_name_pcnt*ri.Populated_motor_carrier_id_carrier_name_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_address_pcnt*ri.Populated_motor_carrier_id_address_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_city_pcnt*ri.Populated_motor_carrier_id_city_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_state_pcnt*ri.Populated_motor_carrier_id_state_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_zipcode_pcnt*ri.Populated_motor_carrier_id_zipcode_pcnt *   0.00 / 10000 + le.Populated_motor_carrier_id_commercial_indicator_pcnt*ri.Populated_motor_carrier_id_commercial_indicator_pcnt *   0.00 / 10000 + le.Populated_carrier_id_type_pcnt*ri.Populated_carrier_id_type_pcnt *   0.00 / 10000 + le.Populated_carrier_unit_number_pcnt*ri.Populated_carrier_unit_number_pcnt *   0.00 / 10000 + le.Populated_dot_permit_number_pcnt*ri.Populated_dot_permit_number_pcnt *   0.00 / 10000 + le.Populated_iccmc_number_pcnt*ri.Populated_iccmc_number_pcnt *   0.00 / 10000 + le.Populated_mcs_vehicle_inspection_pcnt*ri.Populated_mcs_vehicle_inspection_pcnt *   0.00 / 10000 + le.Populated_mcs_form_number_pcnt*ri.Populated_mcs_form_number_pcnt *   0.00 / 10000 + le.Populated_mcs_out_of_service_pcnt*ri.Populated_mcs_out_of_service_pcnt *   0.00 / 10000 + le.Populated_mcs_violation_related_pcnt*ri.Populated_mcs_violation_related_pcnt *   0.00 / 10000 + le.Populated_number_of_axles_pcnt*ri.Populated_number_of_axles_pcnt *   0.00 / 10000 + le.Populated_number_of_tires_pcnt*ri.Populated_number_of_tires_pcnt *   0.00 / 10000 + le.Populated_gvw_over_10k_pounds_pcnt*ri.Populated_gvw_over_10k_pounds_pcnt *   0.00 / 10000 + le.Populated_weight_rating_pcnt*ri.Populated_weight_rating_pcnt *   0.00 / 10000 + le.Populated_registered_gross_vehicle_weight_pcnt*ri.Populated_registered_gross_vehicle_weight_pcnt *   0.00 / 10000 + le.Populated_vehicle_length_feet_pcnt*ri.Populated_vehicle_length_feet_pcnt *   0.00 / 10000 + le.Populated_cargo_body_type_pcnt*ri.Populated_cargo_body_type_pcnt *   0.00 / 10000 + le.Populated_load_type_pcnt*ri.Populated_load_type_pcnt *   0.00 / 10000 + le.Populated_oversize_load_pcnt*ri.Populated_oversize_load_pcnt *   0.00 / 10000 + le.Populated_vehicle_configuration_pcnt*ri.Populated_vehicle_configuration_pcnt *   0.00 / 10000 + le.Populated_trailer1_type_pcnt*ri.Populated_trailer1_type_pcnt *   0.00 / 10000 + le.Populated_trailer1_length_feet_pcnt*ri.Populated_trailer1_length_feet_pcnt *   0.00 / 10000 + le.Populated_trailer1_width_feet_pcnt*ri.Populated_trailer1_width_feet_pcnt *   0.00 / 10000 + le.Populated_trailer2_type_pcnt*ri.Populated_trailer2_type_pcnt *   0.00 / 10000 + le.Populated_trailer2_length_feet_pcnt*ri.Populated_trailer2_length_feet_pcnt *   0.00 / 10000 + le.Populated_trailer2_width_feet_pcnt*ri.Populated_trailer2_width_feet_pcnt *   0.00 / 10000 + le.Populated_federally_reportable_pcnt*ri.Populated_federally_reportable_pcnt *   0.00 / 10000 + le.Populated_vehicle_inspection_hazmat_pcnt*ri.Populated_vehicle_inspection_hazmat_pcnt *   0.00 / 10000 + le.Populated_hazmat_form_number_pcnt*ri.Populated_hazmat_form_number_pcnt *   0.00 / 10000 + le.Populated_hazmt_out_of_service_pcnt*ri.Populated_hazmt_out_of_service_pcnt *   0.00 / 10000 + le.Populated_hazmat_violation_related_pcnt*ri.Populated_hazmat_violation_related_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_placard_pcnt*ri.Populated_hazardous_materials_placard_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_class_number1_pcnt*ri.Populated_hazardous_materials_class_number1_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_class_number2_pcnt*ri.Populated_hazardous_materials_class_number2_pcnt *   0.00 / 10000 + le.Populated_hazmat_placard_name_pcnt*ri.Populated_hazmat_placard_name_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_released1_pcnt*ri.Populated_hazardous_materials_released1_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_released2_pcnt*ri.Populated_hazardous_materials_released2_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_released3_pcnt*ri.Populated_hazardous_materials_released3_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_released4_pcnt*ri.Populated_hazardous_materials_released4_pcnt *   0.00 / 10000 + le.Populated_commercial_event1_pcnt*ri.Populated_commercial_event1_pcnt *   0.00 / 10000 + le.Populated_commercial_event2_pcnt*ri.Populated_commercial_event2_pcnt *   0.00 / 10000 + le.Populated_commercial_event3_pcnt*ri.Populated_commercial_event3_pcnt *   0.00 / 10000 + le.Populated_commercial_event4_pcnt*ri.Populated_commercial_event4_pcnt *   0.00 / 10000 + le.Populated_recommended_driver_reexam_pcnt*ri.Populated_recommended_driver_reexam_pcnt *   0.00 / 10000 + le.Populated_transporting_hazmat_pcnt*ri.Populated_transporting_hazmat_pcnt *   0.00 / 10000 + le.Populated_liquid_hazmat_volume_pcnt*ri.Populated_liquid_hazmat_volume_pcnt *   0.00 / 10000 + le.Populated_oversize_vehicle_pcnt*ri.Populated_oversize_vehicle_pcnt *   0.00 / 10000 + le.Populated_overlength_vehicle_pcnt*ri.Populated_overlength_vehicle_pcnt *   0.00 / 10000 + le.Populated_oversize_vehicle_permitted_pcnt*ri.Populated_oversize_vehicle_permitted_pcnt *   0.00 / 10000 + le.Populated_overlength_vehicle_permitted_pcnt*ri.Populated_overlength_vehicle_permitted_pcnt *   0.00 / 10000 + le.Populated_carrier_phone_number_pcnt*ri.Populated_carrier_phone_number_pcnt *   0.00 / 10000 + le.Populated_commerce_type_pcnt*ri.Populated_commerce_type_pcnt *   0.00 / 10000 + le.Populated_citation_issued_to_vehicle_pcnt*ri.Populated_citation_issued_to_vehicle_pcnt *   0.00 / 10000 + le.Populated_cdl_class_pcnt*ri.Populated_cdl_class_pcnt *   0.00 / 10000 + le.Populated_dot_state_pcnt*ri.Populated_dot_state_pcnt *   0.00 / 10000 + le.Populated_fire_hazardous_materials_involvement_pcnt*ri.Populated_fire_hazardous_materials_involvement_pcnt *   0.00 / 10000 + le.Populated_commercial_event_description_pcnt*ri.Populated_commercial_event_description_pcnt *   0.00 / 10000 + le.Populated_supplment_required_hazmat_placard_pcnt*ri.Populated_supplment_required_hazmat_placard_pcnt *   0.00 / 10000 + le.Populated_other_state_number1_pcnt*ri.Populated_other_state_number1_pcnt *   0.00 / 10000 + le.Populated_other_state_number2_pcnt*ri.Populated_other_state_number2_pcnt *   0.00 / 10000 + le.Populated_work_type_id_pcnt*ri.Populated_work_type_id_pcnt *   0.00 / 10000 + le.Populated_report_id_pcnt*ri.Populated_report_id_pcnt *   0.00 / 10000 + le.Populated_agency_id_pcnt*ri.Populated_agency_id_pcnt *   0.00 / 10000 + le.Populated_sent_to_hpcc_datetime_pcnt*ri.Populated_sent_to_hpcc_datetime_pcnt *   0.00 / 10000 + le.Populated_corrected_incident_pcnt*ri.Populated_corrected_incident_pcnt *   0.00 / 10000 + le.Populated_cru_order_id_pcnt*ri.Populated_cru_order_id_pcnt *   0.00 / 10000 + le.Populated_cru_sequence_nbr_pcnt*ri.Populated_cru_sequence_nbr_pcnt *   0.00 / 10000 + le.Populated_loss_state_abbr_pcnt*ri.Populated_loss_state_abbr_pcnt *   0.00 / 10000 + le.Populated_report_type_id_pcnt*ri.Populated_report_type_id_pcnt *   0.00 / 10000 + le.Populated_hash_key_pcnt*ri.Populated_hash_key_pcnt *   0.00 / 10000 + le.Populated_case_identifier_pcnt*ri.Populated_case_identifier_pcnt *   0.00 / 10000 + le.Populated_crash_county_pcnt*ri.Populated_crash_county_pcnt *   0.00 / 10000 + le.Populated_county_cd_pcnt*ri.Populated_county_cd_pcnt *   0.00 / 10000 + le.Populated_crash_cityplace_pcnt*ri.Populated_crash_cityplace_pcnt *   0.00 / 10000 + le.Populated_crash_city_pcnt*ri.Populated_crash_city_pcnt *   0.00 / 10000 + le.Populated_city_code_pcnt*ri.Populated_city_code_pcnt *   0.00 / 10000 + le.Populated_first_harmful_event_pcnt*ri.Populated_first_harmful_event_pcnt *   0.00 / 10000 + le.Populated_first_harmful_event_location_pcnt*ri.Populated_first_harmful_event_location_pcnt *   0.00 / 10000 + le.Populated_manner_crash_impact1_pcnt*ri.Populated_manner_crash_impact1_pcnt *   0.00 / 10000 + le.Populated_weather_condition1_pcnt*ri.Populated_weather_condition1_pcnt *   0.00 / 10000 + le.Populated_weather_condition2_pcnt*ri.Populated_weather_condition2_pcnt *   0.00 / 10000 + le.Populated_light_condition1_pcnt*ri.Populated_light_condition1_pcnt *   0.00 / 10000 + le.Populated_light_condition2_pcnt*ri.Populated_light_condition2_pcnt *   0.00 / 10000 + le.Populated_road_surface_condition_pcnt*ri.Populated_road_surface_condition_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental1_pcnt*ri.Populated_contributing_circumstances_environmental1_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental2_pcnt*ri.Populated_contributing_circumstances_environmental2_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental3_pcnt*ri.Populated_contributing_circumstances_environmental3_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental4_pcnt*ri.Populated_contributing_circumstances_environmental4_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_road1_pcnt*ri.Populated_contributing_circumstances_road1_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_road2_pcnt*ri.Populated_contributing_circumstances_road2_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_road3_pcnt*ri.Populated_contributing_circumstances_road3_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_road4_pcnt*ri.Populated_contributing_circumstances_road4_pcnt *   0.00 / 10000 + le.Populated_relation_to_junction_pcnt*ri.Populated_relation_to_junction_pcnt *   0.00 / 10000 + le.Populated_intersection_type_pcnt*ri.Populated_intersection_type_pcnt *   0.00 / 10000 + le.Populated_school_bus_related_pcnt*ri.Populated_school_bus_related_pcnt *   0.00 / 10000 + le.Populated_work_zone_related_pcnt*ri.Populated_work_zone_related_pcnt *   0.00 / 10000 + le.Populated_work_zone_location_pcnt*ri.Populated_work_zone_location_pcnt *   0.00 / 10000 + le.Populated_work_zone_type_pcnt*ri.Populated_work_zone_type_pcnt *   0.00 / 10000 + le.Populated_work_zone_workers_present_pcnt*ri.Populated_work_zone_workers_present_pcnt *   0.00 / 10000 + le.Populated_work_zone_law_enforcement_present_pcnt*ri.Populated_work_zone_law_enforcement_present_pcnt *   0.00 / 10000 + le.Populated_crash_severity_pcnt*ri.Populated_crash_severity_pcnt *   0.00 / 10000 + le.Populated_number_of_vehicles_pcnt*ri.Populated_number_of_vehicles_pcnt *   0.00 / 10000 + le.Populated_total_nonfatal_injuries_pcnt*ri.Populated_total_nonfatal_injuries_pcnt *   0.00 / 10000 + le.Populated_total_fatal_injuries_pcnt*ri.Populated_total_fatal_injuries_pcnt *   0.00 / 10000 + le.Populated_day_of_week_pcnt*ri.Populated_day_of_week_pcnt *   0.00 / 10000 + le.Populated_roadway_curvature_pcnt*ri.Populated_roadway_curvature_pcnt *   0.00 / 10000 + le.Populated_part_of_national_highway_system_pcnt*ri.Populated_part_of_national_highway_system_pcnt *   0.00 / 10000 + le.Populated_roadway_functional_class_pcnt*ri.Populated_roadway_functional_class_pcnt *   0.00 / 10000 + le.Populated_access_control_pcnt*ri.Populated_access_control_pcnt *   0.00 / 10000 + le.Populated_rr_crossing_id_pcnt*ri.Populated_rr_crossing_id_pcnt *   0.00 / 10000 + le.Populated_roadway_lighting_pcnt*ri.Populated_roadway_lighting_pcnt *   0.00 / 10000 + le.Populated_traffic_control_type_at_intersection1_pcnt*ri.Populated_traffic_control_type_at_intersection1_pcnt *   0.00 / 10000 + le.Populated_traffic_control_type_at_intersection2_pcnt*ri.Populated_traffic_control_type_at_intersection2_pcnt *   0.00 / 10000 + le.Populated_ncic_number_pcnt*ri.Populated_ncic_number_pcnt *   0.00 / 10000 + le.Populated_state_report_number_pcnt*ri.Populated_state_report_number_pcnt *   0.00 / 10000 + le.Populated_ori_number_pcnt*ri.Populated_ori_number_pcnt *   0.00 / 10000 + le.Populated_crash_date_pcnt*ri.Populated_crash_date_pcnt *   0.00 / 10000 + le.Populated_crash_time_pcnt*ri.Populated_crash_time_pcnt *   0.00 / 10000 + le.Populated_lattitude_pcnt*ri.Populated_lattitude_pcnt *   0.00 / 10000 + le.Populated_longitude_pcnt*ri.Populated_longitude_pcnt *   0.00 / 10000 + le.Populated_milepost1_pcnt*ri.Populated_milepost1_pcnt *   0.00 / 10000 + le.Populated_milepost2_pcnt*ri.Populated_milepost2_pcnt *   0.00 / 10000 + le.Populated_address_number_pcnt*ri.Populated_address_number_pcnt *   0.00 / 10000 + le.Populated_loss_street_pcnt*ri.Populated_loss_street_pcnt *   0.00 / 10000 + le.Populated_loss_street_route_number_pcnt*ri.Populated_loss_street_route_number_pcnt *   0.00 / 10000 + le.Populated_loss_street_type_pcnt*ri.Populated_loss_street_type_pcnt *   0.00 / 10000 + le.Populated_loss_street_speed_limit_pcnt*ri.Populated_loss_street_speed_limit_pcnt *   0.00 / 10000 + le.Populated_incident_location_indicator_pcnt*ri.Populated_incident_location_indicator_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_pcnt*ri.Populated_loss_cross_street_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_route_number_pcnt*ri.Populated_loss_cross_street_route_number_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_intersecting_route_segment_pcnt*ri.Populated_loss_cross_street_intersecting_route_segment_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_type_pcnt*ri.Populated_loss_cross_street_type_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_speed_limit_pcnt*ri.Populated_loss_cross_street_speed_limit_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_number_of_lanes_pcnt*ri.Populated_loss_cross_street_number_of_lanes_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_orientation_pcnt*ri.Populated_loss_cross_street_orientation_pcnt *   0.00 / 10000 + le.Populated_loss_cross_street_route_sign_pcnt*ri.Populated_loss_cross_street_route_sign_pcnt *   0.00 / 10000 + le.Populated_at_node_number_pcnt*ri.Populated_at_node_number_pcnt *   0.00 / 10000 + le.Populated_distance_from_node_feet_pcnt*ri.Populated_distance_from_node_feet_pcnt *   0.00 / 10000 + le.Populated_distance_from_node_miles_pcnt*ri.Populated_distance_from_node_miles_pcnt *   0.00 / 10000 + le.Populated_next_node_number_pcnt*ri.Populated_next_node_number_pcnt *   0.00 / 10000 + le.Populated_next_roadway_node_number_pcnt*ri.Populated_next_roadway_node_number_pcnt *   0.00 / 10000 + le.Populated_direction_of_travel_pcnt*ri.Populated_direction_of_travel_pcnt *   0.00 / 10000 + le.Populated_next_street_pcnt*ri.Populated_next_street_pcnt *   0.00 / 10000 + le.Populated_next_street_type_pcnt*ri.Populated_next_street_type_pcnt *   0.00 / 10000 + le.Populated_next_street_suffix_pcnt*ri.Populated_next_street_suffix_pcnt *   0.00 / 10000 + le.Populated_before_or_after_next_street_pcnt*ri.Populated_before_or_after_next_street_pcnt *   0.00 / 10000 + le.Populated_next_street_distance_feet_pcnt*ri.Populated_next_street_distance_feet_pcnt *   0.00 / 10000 + le.Populated_next_street_distance_miles_pcnt*ri.Populated_next_street_distance_miles_pcnt *   0.00 / 10000 + le.Populated_next_street_direction_pcnt*ri.Populated_next_street_direction_pcnt *   0.00 / 10000 + le.Populated_next_street_route_segment_pcnt*ri.Populated_next_street_route_segment_pcnt *   0.00 / 10000 + le.Populated_continuing_toward_street_pcnt*ri.Populated_continuing_toward_street_pcnt *   0.00 / 10000 + le.Populated_continuing_street_suffix_pcnt*ri.Populated_continuing_street_suffix_pcnt *   0.00 / 10000 + le.Populated_continuing_street_direction_pcnt*ri.Populated_continuing_street_direction_pcnt *   0.00 / 10000 + le.Populated_continuting_street_route_segment_pcnt*ri.Populated_continuting_street_route_segment_pcnt *   0.00 / 10000 + le.Populated_city_type_pcnt*ri.Populated_city_type_pcnt *   0.00 / 10000 + le.Populated_outside_city_indicator_pcnt*ri.Populated_outside_city_indicator_pcnt *   0.00 / 10000 + le.Populated_outside_city_direction_pcnt*ri.Populated_outside_city_direction_pcnt *   0.00 / 10000 + le.Populated_outside_city_distance_feet_pcnt*ri.Populated_outside_city_distance_feet_pcnt *   0.00 / 10000 + le.Populated_outside_city_distance_miles_pcnt*ri.Populated_outside_city_distance_miles_pcnt *   0.00 / 10000 + le.Populated_crash_type_pcnt*ri.Populated_crash_type_pcnt *   0.00 / 10000 + le.Populated_motor_vehicle_involved_with_pcnt*ri.Populated_motor_vehicle_involved_with_pcnt *   0.00 / 10000 + le.Populated_report_investigation_type_pcnt*ri.Populated_report_investigation_type_pcnt *   0.00 / 10000 + le.Populated_incident_hit_and_run_pcnt*ri.Populated_incident_hit_and_run_pcnt *   0.00 / 10000 + le.Populated_tow_away_pcnt*ri.Populated_tow_away_pcnt *   0.00 / 10000 + le.Populated_date_notified_pcnt*ri.Populated_date_notified_pcnt *   0.00 / 10000 + le.Populated_time_notified_pcnt*ri.Populated_time_notified_pcnt *   0.00 / 10000 + le.Populated_notification_method_pcnt*ri.Populated_notification_method_pcnt *   0.00 / 10000 + le.Populated_officer_arrival_time_pcnt*ri.Populated_officer_arrival_time_pcnt *   0.00 / 10000 + le.Populated_officer_report_date_pcnt*ri.Populated_officer_report_date_pcnt *   0.00 / 10000 + le.Populated_officer_report_time_pcnt*ri.Populated_officer_report_time_pcnt *   0.00 / 10000 + le.Populated_officer_id_pcnt*ri.Populated_officer_id_pcnt *   0.00 / 10000 + le.Populated_officer_department_pcnt*ri.Populated_officer_department_pcnt *   0.00 / 10000 + le.Populated_officer_rank_pcnt*ri.Populated_officer_rank_pcnt *   0.00 / 10000 + le.Populated_officer_command_pcnt*ri.Populated_officer_command_pcnt *   0.00 / 10000 + le.Populated_officer_tax_id_number_pcnt*ri.Populated_officer_tax_id_number_pcnt *   0.00 / 10000 + le.Populated_completed_report_date_pcnt*ri.Populated_completed_report_date_pcnt *   0.00 / 10000 + le.Populated_supervisor_check_date_pcnt*ri.Populated_supervisor_check_date_pcnt *   0.00 / 10000 + le.Populated_supervisor_check_time_pcnt*ri.Populated_supervisor_check_time_pcnt *   0.00 / 10000 + le.Populated_supervisor_id_pcnt*ri.Populated_supervisor_id_pcnt *   0.00 / 10000 + le.Populated_supervisor_rank_pcnt*ri.Populated_supervisor_rank_pcnt *   0.00 / 10000 + le.Populated_reviewers_name_pcnt*ri.Populated_reviewers_name_pcnt *   0.00 / 10000 + le.Populated_road_surface_pcnt*ri.Populated_road_surface_pcnt *   0.00 / 10000 + le.Populated_roadway_alignment_pcnt*ri.Populated_roadway_alignment_pcnt *   0.00 / 10000 + le.Populated_traffic_way_description_pcnt*ri.Populated_traffic_way_description_pcnt *   0.00 / 10000 + le.Populated_traffic_flow_pcnt*ri.Populated_traffic_flow_pcnt *   0.00 / 10000 + le.Populated_property_damage_involved_pcnt*ri.Populated_property_damage_involved_pcnt *   0.00 / 10000 + le.Populated_property_damage_description1_pcnt*ri.Populated_property_damage_description1_pcnt *   0.00 / 10000 + le.Populated_property_damage_description2_pcnt*ri.Populated_property_damage_description2_pcnt *   0.00 / 10000 + le.Populated_property_damage_estimate1_pcnt*ri.Populated_property_damage_estimate1_pcnt *   0.00 / 10000 + le.Populated_property_damage_estimate2_pcnt*ri.Populated_property_damage_estimate2_pcnt *   0.00 / 10000 + le.Populated_incident_damage_over_limit_pcnt*ri.Populated_incident_damage_over_limit_pcnt *   0.00 / 10000 + le.Populated_property_owner_notified_pcnt*ri.Populated_property_owner_notified_pcnt *   0.00 / 10000 + le.Populated_government_property_pcnt*ri.Populated_government_property_pcnt *   0.00 / 10000 + le.Populated_accident_condition_pcnt*ri.Populated_accident_condition_pcnt *   0.00 / 10000 + le.Populated_unusual_road_condition1_pcnt*ri.Populated_unusual_road_condition1_pcnt *   0.00 / 10000 + le.Populated_unusual_road_condition2_pcnt*ri.Populated_unusual_road_condition2_pcnt *   0.00 / 10000 + le.Populated_number_of_lanes_pcnt*ri.Populated_number_of_lanes_pcnt *   0.00 / 10000 + le.Populated_divided_highway_pcnt*ri.Populated_divided_highway_pcnt *   0.00 / 10000 + le.Populated_most_harmful_event_pcnt*ri.Populated_most_harmful_event_pcnt *   0.00 / 10000 + le.Populated_second_harmful_event_pcnt*ri.Populated_second_harmful_event_pcnt *   0.00 / 10000 + le.Populated_ems_notified_date_pcnt*ri.Populated_ems_notified_date_pcnt *   0.00 / 10000 + le.Populated_ems_arrival_date_pcnt*ri.Populated_ems_arrival_date_pcnt *   0.00 / 10000 + le.Populated_hospital_arrival_date_pcnt*ri.Populated_hospital_arrival_date_pcnt *   0.00 / 10000 + le.Populated_injured_taken_by_pcnt*ri.Populated_injured_taken_by_pcnt *   0.00 / 10000 + le.Populated_injured_taken_to_pcnt*ri.Populated_injured_taken_to_pcnt *   0.00 / 10000 + le.Populated_incident_transported_for_medical_care_pcnt*ri.Populated_incident_transported_for_medical_care_pcnt *   0.00 / 10000 + le.Populated_photographs_taken_pcnt*ri.Populated_photographs_taken_pcnt *   0.00 / 10000 + le.Populated_photographed_by_pcnt*ri.Populated_photographed_by_pcnt *   0.00 / 10000 + le.Populated_photographer_id_pcnt*ri.Populated_photographer_id_pcnt *   0.00 / 10000 + le.Populated_photography_agency_name_pcnt*ri.Populated_photography_agency_name_pcnt *   0.00 / 10000 + le.Populated_agency_name_pcnt*ri.Populated_agency_name_pcnt *   0.00 / 10000 + le.Populated_judicial_district_pcnt*ri.Populated_judicial_district_pcnt *   0.00 / 10000 + le.Populated_precinct_pcnt*ri.Populated_precinct_pcnt *   0.00 / 10000 + le.Populated_beat_pcnt*ri.Populated_beat_pcnt *   0.00 / 10000 + le.Populated_location_type_pcnt*ri.Populated_location_type_pcnt *   0.00 / 10000 + le.Populated_shoulder_type_pcnt*ri.Populated_shoulder_type_pcnt *   0.00 / 10000 + le.Populated_investigation_complete_pcnt*ri.Populated_investigation_complete_pcnt *   0.00 / 10000 + le.Populated_investigation_not_complete_why_pcnt*ri.Populated_investigation_not_complete_why_pcnt *   0.00 / 10000 + le.Populated_investigating_officer_name_pcnt*ri.Populated_investigating_officer_name_pcnt *   0.00 / 10000 + le.Populated_investigation_notification_issued_pcnt*ri.Populated_investigation_notification_issued_pcnt *   0.00 / 10000 + le.Populated_agency_type_pcnt*ri.Populated_agency_type_pcnt *   0.00 / 10000 + le.Populated_no_injury_tow_involved_pcnt*ri.Populated_no_injury_tow_involved_pcnt *   0.00 / 10000 + le.Populated_injury_tow_involved_pcnt*ri.Populated_injury_tow_involved_pcnt *   0.00 / 10000 + le.Populated_lars_code1_pcnt*ri.Populated_lars_code1_pcnt *   0.00 / 10000 + le.Populated_lars_code2_pcnt*ri.Populated_lars_code2_pcnt *   0.00 / 10000 + le.Populated_private_property_incident_pcnt*ri.Populated_private_property_incident_pcnt *   0.00 / 10000 + le.Populated_accident_involvement_pcnt*ri.Populated_accident_involvement_pcnt *   0.00 / 10000 + le.Populated_local_use_pcnt*ri.Populated_local_use_pcnt *   0.00 / 10000 + le.Populated_street_prefix_pcnt*ri.Populated_street_prefix_pcnt *   0.00 / 10000 + le.Populated_street_suffix_pcnt*ri.Populated_street_suffix_pcnt *   0.00 / 10000 + le.Populated_toll_road_pcnt*ri.Populated_toll_road_pcnt *   0.00 / 10000 + le.Populated_street_description_pcnt*ri.Populated_street_description_pcnt *   0.00 / 10000 + le.Populated_cross_street_address_number_pcnt*ri.Populated_cross_street_address_number_pcnt *   0.00 / 10000 + le.Populated_cross_street_prefix_pcnt*ri.Populated_cross_street_prefix_pcnt *   0.00 / 10000 + le.Populated_cross_street_suffix_pcnt*ri.Populated_cross_street_suffix_pcnt *   0.00 / 10000 + le.Populated_report_complete_pcnt*ri.Populated_report_complete_pcnt *   0.00 / 10000 + le.Populated_dispatch_notified_pcnt*ri.Populated_dispatch_notified_pcnt *   0.00 / 10000 + le.Populated_counter_report_pcnt*ri.Populated_counter_report_pcnt *   0.00 / 10000 + le.Populated_road_type_pcnt*ri.Populated_road_type_pcnt *   0.00 / 10000 + le.Populated_agency_code_pcnt*ri.Populated_agency_code_pcnt *   0.00 / 10000 + le.Populated_public_property_employee_pcnt*ri.Populated_public_property_employee_pcnt *   0.00 / 10000 + le.Populated_bridge_related_pcnt*ri.Populated_bridge_related_pcnt *   0.00 / 10000 + le.Populated_ramp_indicator_pcnt*ri.Populated_ramp_indicator_pcnt *   0.00 / 10000 + le.Populated_to_or_from_location_pcnt*ri.Populated_to_or_from_location_pcnt *   0.00 / 10000 + le.Populated_complaint_number_pcnt*ri.Populated_complaint_number_pcnt *   0.00 / 10000 + le.Populated_school_zone_related_pcnt*ri.Populated_school_zone_related_pcnt *   0.00 / 10000 + le.Populated_notify_dot_maintenance_pcnt*ri.Populated_notify_dot_maintenance_pcnt *   0.00 / 10000 + le.Populated_special_location_pcnt*ri.Populated_special_location_pcnt *   0.00 / 10000 + le.Populated_route_segment_pcnt*ri.Populated_route_segment_pcnt *   0.00 / 10000 + le.Populated_route_sign_pcnt*ri.Populated_route_sign_pcnt *   0.00 / 10000 + le.Populated_route_category_street_pcnt*ri.Populated_route_category_street_pcnt *   0.00 / 10000 + le.Populated_route_category_cross_street_pcnt*ri.Populated_route_category_cross_street_pcnt *   0.00 / 10000 + le.Populated_route_category_next_street_pcnt*ri.Populated_route_category_next_street_pcnt *   0.00 / 10000 + le.Populated_lane_closed_pcnt*ri.Populated_lane_closed_pcnt *   0.00 / 10000 + le.Populated_lane_closure_direction_pcnt*ri.Populated_lane_closure_direction_pcnt *   0.00 / 10000 + le.Populated_lane_direction_pcnt*ri.Populated_lane_direction_pcnt *   0.00 / 10000 + le.Populated_traffic_detoured_pcnt*ri.Populated_traffic_detoured_pcnt *   0.00 / 10000 + le.Populated_time_closed_pcnt*ri.Populated_time_closed_pcnt *   0.00 / 10000 + le.Populated_pedestrian_signals_pcnt*ri.Populated_pedestrian_signals_pcnt *   0.00 / 10000 + le.Populated_work_zone_speed_limit_pcnt*ri.Populated_work_zone_speed_limit_pcnt *   0.00 / 10000 + le.Populated_work_zone_shoulder_median_pcnt*ri.Populated_work_zone_shoulder_median_pcnt *   0.00 / 10000 + le.Populated_work_zone_intermittent_moving_pcnt*ri.Populated_work_zone_intermittent_moving_pcnt *   0.00 / 10000 + le.Populated_work_zone_flagger_control_pcnt*ri.Populated_work_zone_flagger_control_pcnt *   0.00 / 10000 + le.Populated_special_work_zone_characteristics_pcnt*ri.Populated_special_work_zone_characteristics_pcnt *   0.00 / 10000 + le.Populated_lane_number_pcnt*ri.Populated_lane_number_pcnt *   0.00 / 10000 + le.Populated_offset_distance_feet_pcnt*ri.Populated_offset_distance_feet_pcnt *   0.00 / 10000 + le.Populated_offset_distance_miles_pcnt*ri.Populated_offset_distance_miles_pcnt *   0.00 / 10000 + le.Populated_offset_direction_pcnt*ri.Populated_offset_direction_pcnt *   0.00 / 10000 + le.Populated_asru_code_pcnt*ri.Populated_asru_code_pcnt *   0.00 / 10000 + le.Populated_mp_grid_pcnt*ri.Populated_mp_grid_pcnt *   0.00 / 10000 + le.Populated_number_of_qualifying_units_pcnt*ri.Populated_number_of_qualifying_units_pcnt *   0.00 / 10000 + le.Populated_number_of_hazmat_vehicles_pcnt*ri.Populated_number_of_hazmat_vehicles_pcnt *   0.00 / 10000 + le.Populated_number_of_buses_involved_pcnt*ri.Populated_number_of_buses_involved_pcnt *   0.00 / 10000 + le.Populated_number_taken_to_treatment_pcnt*ri.Populated_number_taken_to_treatment_pcnt *   0.00 / 10000 + le.Populated_number_vehicles_towed_pcnt*ri.Populated_number_vehicles_towed_pcnt *   0.00 / 10000 + le.Populated_vehicle_at_fault_unit_number_pcnt*ri.Populated_vehicle_at_fault_unit_number_pcnt *   0.00 / 10000 + le.Populated_time_officer_cleared_scene_pcnt*ri.Populated_time_officer_cleared_scene_pcnt *   0.00 / 10000 + le.Populated_total_minutes_on_scene_pcnt*ri.Populated_total_minutes_on_scene_pcnt *   0.00 / 10000 + le.Populated_motorists_report_pcnt*ri.Populated_motorists_report_pcnt *   0.00 / 10000 + le.Populated_fatality_involved_pcnt*ri.Populated_fatality_involved_pcnt *   0.00 / 10000 + le.Populated_local_dot_index_number_pcnt*ri.Populated_local_dot_index_number_pcnt *   0.00 / 10000 + le.Populated_dor_number_pcnt*ri.Populated_dor_number_pcnt *   0.00 / 10000 + le.Populated_hospital_code_pcnt*ri.Populated_hospital_code_pcnt *   0.00 / 10000 + le.Populated_special_jurisdiction_pcnt*ri.Populated_special_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_document_type_pcnt*ri.Populated_document_type_pcnt *   0.00 / 10000 + le.Populated_distance_was_measured_pcnt*ri.Populated_distance_was_measured_pcnt *   0.00 / 10000 + le.Populated_street_orientation_pcnt*ri.Populated_street_orientation_pcnt *   0.00 / 10000 + le.Populated_intersecting_route_segment_pcnt*ri.Populated_intersecting_route_segment_pcnt *   0.00 / 10000 + le.Populated_primary_fault_indicator_pcnt*ri.Populated_primary_fault_indicator_pcnt *   0.00 / 10000 + le.Populated_first_harmful_event_pedestrian_pcnt*ri.Populated_first_harmful_event_pedestrian_pcnt *   0.00 / 10000 + le.Populated_reference_markers_pcnt*ri.Populated_reference_markers_pcnt *   0.00 / 10000 + le.Populated_other_officer_on_scene_pcnt*ri.Populated_other_officer_on_scene_pcnt *   0.00 / 10000 + le.Populated_other_officer_badge_number_pcnt*ri.Populated_other_officer_badge_number_pcnt *   0.00 / 10000 + le.Populated_supplemental_report_pcnt*ri.Populated_supplemental_report_pcnt *   0.00 / 10000 + le.Populated_supplemental_type_pcnt*ri.Populated_supplemental_type_pcnt *   0.00 / 10000 + le.Populated_amended_report_pcnt*ri.Populated_amended_report_pcnt *   0.00 / 10000 + le.Populated_corrected_report_pcnt*ri.Populated_corrected_report_pcnt *   0.00 / 10000 + le.Populated_state_highway_related_pcnt*ri.Populated_state_highway_related_pcnt *   0.00 / 10000 + le.Populated_roadway_lighting_condition_pcnt*ri.Populated_roadway_lighting_condition_pcnt *   0.00 / 10000 + le.Populated_vendor_reference_number_pcnt*ri.Populated_vendor_reference_number_pcnt *   0.00 / 10000 + le.Populated_duplicate_copy_unit_number_pcnt*ri.Populated_duplicate_copy_unit_number_pcnt *   0.00 / 10000 + le.Populated_other_city_agency_description_pcnt*ri.Populated_other_city_agency_description_pcnt *   0.00 / 10000 + le.Populated_notifcation_description_pcnt*ri.Populated_notifcation_description_pcnt *   0.00 / 10000 + le.Populated_primary_collision_improper_driving_description_pcnt*ri.Populated_primary_collision_improper_driving_description_pcnt *   0.00 / 10000 + le.Populated_weather_other_description_pcnt*ri.Populated_weather_other_description_pcnt *   0.00 / 10000 + le.Populated_crash_type_description_pcnt*ri.Populated_crash_type_description_pcnt *   0.00 / 10000 + le.Populated_motor_vehicle_involved_with_animal_description_pcnt*ri.Populated_motor_vehicle_involved_with_animal_description_pcnt *   0.00 / 10000 + le.Populated_motor_vehicle_involved_with_fixed_object_description_pcnt*ri.Populated_motor_vehicle_involved_with_fixed_object_description_pcnt *   0.00 / 10000 + le.Populated_motor_vehicle_involved_with_other_object_description_pcnt*ri.Populated_motor_vehicle_involved_with_other_object_description_pcnt *   0.00 / 10000 + le.Populated_other_investigation_time_pcnt*ri.Populated_other_investigation_time_pcnt *   0.00 / 10000 + le.Populated_milepost_detail_pcnt*ri.Populated_milepost_detail_pcnt *   0.00 / 10000 + le.Populated_utility_pole_number1_pcnt*ri.Populated_utility_pole_number1_pcnt *   0.00 / 10000 + le.Populated_utility_pole_number2_pcnt*ri.Populated_utility_pole_number2_pcnt *   0.00 / 10000 + le.Populated_utility_pole_number3_pcnt*ri.Populated_utility_pole_number3_pcnt *   0.00 / 10000 + le.Populated_person_id_pcnt*ri.Populated_person_id_pcnt *   0.00 / 10000 + le.Populated_person_number_pcnt*ri.Populated_person_number_pcnt *   0.00 / 10000 + le.Populated_vehicle_unit_number_pcnt*ri.Populated_vehicle_unit_number_pcnt *   0.00 / 10000 + le.Populated_sex_pcnt*ri.Populated_sex_pcnt *   0.00 / 10000 + le.Populated_person_type_pcnt*ri.Populated_person_type_pcnt *   0.00 / 10000 + le.Populated_injury_status_pcnt*ri.Populated_injury_status_pcnt *   0.00 / 10000 + le.Populated_occupant_vehicle_unit_number_pcnt*ri.Populated_occupant_vehicle_unit_number_pcnt *   0.00 / 10000 + le.Populated_seating_position1_pcnt*ri.Populated_seating_position1_pcnt *   0.00 / 10000 + le.Populated_safety_equipment_restraint1_pcnt*ri.Populated_safety_equipment_restraint1_pcnt *   0.00 / 10000 + le.Populated_safety_equipment_restraint2_pcnt*ri.Populated_safety_equipment_restraint2_pcnt *   0.00 / 10000 + le.Populated_safety_equipment_helmet_pcnt*ri.Populated_safety_equipment_helmet_pcnt *   0.00 / 10000 + le.Populated_air_bag_deployed_pcnt*ri.Populated_air_bag_deployed_pcnt *   0.00 / 10000 + le.Populated_ejection_pcnt*ri.Populated_ejection_pcnt *   0.00 / 10000 + le.Populated_drivers_license_jurisdiction_pcnt*ri.Populated_drivers_license_jurisdiction_pcnt *   0.00 / 10000 + le.Populated_dl_number_class_pcnt*ri.Populated_dl_number_class_pcnt *   0.00 / 10000 + le.Populated_dl_number_cdl_pcnt*ri.Populated_dl_number_cdl_pcnt *   0.00 / 10000 + le.Populated_dl_number_endorsements_pcnt*ri.Populated_dl_number_endorsements_pcnt *   0.00 / 10000 + le.Populated_driver_actions_at_time_of_crash1_pcnt*ri.Populated_driver_actions_at_time_of_crash1_pcnt *   0.00 / 10000 + le.Populated_driver_actions_at_time_of_crash2_pcnt*ri.Populated_driver_actions_at_time_of_crash2_pcnt *   0.00 / 10000 + le.Populated_driver_actions_at_time_of_crash3_pcnt*ri.Populated_driver_actions_at_time_of_crash3_pcnt *   0.00 / 10000 + le.Populated_driver_actions_at_time_of_crash4_pcnt*ri.Populated_driver_actions_at_time_of_crash4_pcnt *   0.00 / 10000 + le.Populated_violation_codes_pcnt*ri.Populated_violation_codes_pcnt *   0.00 / 10000 + le.Populated_condition_at_time_of_crash1_pcnt*ri.Populated_condition_at_time_of_crash1_pcnt *   0.00 / 10000 + le.Populated_condition_at_time_of_crash2_pcnt*ri.Populated_condition_at_time_of_crash2_pcnt *   0.00 / 10000 + le.Populated_law_enforcement_suspects_alcohol_use_pcnt*ri.Populated_law_enforcement_suspects_alcohol_use_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_status_pcnt*ri.Populated_alcohol_test_status_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_pcnt*ri.Populated_alcohol_test_type_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_result_pcnt*ri.Populated_alcohol_test_result_pcnt *   0.00 / 10000 + le.Populated_law_enforcement_suspects_drug_use_pcnt*ri.Populated_law_enforcement_suspects_drug_use_pcnt *   0.00 / 10000 + le.Populated_drug_test_given_pcnt*ri.Populated_drug_test_given_pcnt *   0.00 / 10000 + le.Populated_non_motorist_actions_prior_to_crash1_pcnt*ri.Populated_non_motorist_actions_prior_to_crash1_pcnt *   0.00 / 10000 + le.Populated_non_motorist_actions_prior_to_crash2_pcnt*ri.Populated_non_motorist_actions_prior_to_crash2_pcnt *   0.00 / 10000 + le.Populated_non_motorist_actions_at_time_of_crash_pcnt*ri.Populated_non_motorist_actions_at_time_of_crash_pcnt *   0.00 / 10000 + le.Populated_non_motorist_location_at_time_of_crash_pcnt*ri.Populated_non_motorist_location_at_time_of_crash_pcnt *   0.00 / 10000 + le.Populated_non_motorist_safety_equipment1_pcnt*ri.Populated_non_motorist_safety_equipment1_pcnt *   0.00 / 10000 + le.Populated_age_pcnt*ri.Populated_age_pcnt *   0.00 / 10000 + le.Populated_driver_license_restrictions1_pcnt*ri.Populated_driver_license_restrictions1_pcnt *   0.00 / 10000 + le.Populated_drug_test_type_pcnt*ri.Populated_drug_test_type_pcnt *   0.00 / 10000 + le.Populated_drug_test_result1_pcnt*ri.Populated_drug_test_result1_pcnt *   0.00 / 10000 + le.Populated_drug_test_result2_pcnt*ri.Populated_drug_test_result2_pcnt *   0.00 / 10000 + le.Populated_drug_test_result3_pcnt*ri.Populated_drug_test_result3_pcnt *   0.00 / 10000 + le.Populated_drug_test_result4_pcnt*ri.Populated_drug_test_result4_pcnt *   0.00 / 10000 + le.Populated_injury_area_pcnt*ri.Populated_injury_area_pcnt *   0.00 / 10000 + le.Populated_injury_description_pcnt*ri.Populated_injury_description_pcnt *   0.00 / 10000 + le.Populated_motorcyclist_head_injury_pcnt*ri.Populated_motorcyclist_head_injury_pcnt *   0.00 / 10000 + le.Populated_party_id_pcnt*ri.Populated_party_id_pcnt *   0.00 / 10000 + le.Populated_same_as_driver_pcnt*ri.Populated_same_as_driver_pcnt *   0.00 / 10000 + le.Populated_address_same_as_driver_pcnt*ri.Populated_address_same_as_driver_pcnt *   0.00 / 10000 + le.Populated_last_name_pcnt*ri.Populated_last_name_pcnt *   0.00 / 10000 + le.Populated_first_name_pcnt*ri.Populated_first_name_pcnt *   0.00 / 10000 + le.Populated_middle_name_pcnt*ri.Populated_middle_name_pcnt *   0.00 / 10000 + le.Populated_name_suffx_pcnt*ri.Populated_name_suffx_pcnt *   0.00 / 10000 + le.Populated_date_of_birth_pcnt*ri.Populated_date_of_birth_pcnt *   0.00 / 10000 + le.Populated_address_pcnt*ri.Populated_address_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip_code_pcnt*ri.Populated_zip_code_pcnt *   0.00 / 10000 + le.Populated_home_phone_pcnt*ri.Populated_home_phone_pcnt *   0.00 / 10000 + le.Populated_business_phone_pcnt*ri.Populated_business_phone_pcnt *   0.00 / 10000 + le.Populated_insurance_company_pcnt*ri.Populated_insurance_company_pcnt *   0.00 / 10000 + le.Populated_insurance_company_phone_number_pcnt*ri.Populated_insurance_company_phone_number_pcnt *   0.00 / 10000 + le.Populated_insurance_policy_number_pcnt*ri.Populated_insurance_policy_number_pcnt *   0.00 / 10000 + le.Populated_insurance_effective_date_pcnt*ri.Populated_insurance_effective_date_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_drivers_license_number_pcnt*ri.Populated_drivers_license_number_pcnt *   0.00 / 10000 + le.Populated_drivers_license_expiration_pcnt*ri.Populated_drivers_license_expiration_pcnt *   0.00 / 10000 + le.Populated_eye_color_pcnt*ri.Populated_eye_color_pcnt *   0.00 / 10000 + le.Populated_hair_color_pcnt*ri.Populated_hair_color_pcnt *   0.00 / 10000 + le.Populated_height_pcnt*ri.Populated_height_pcnt *   0.00 / 10000 + le.Populated_weight_pcnt*ri.Populated_weight_pcnt *   0.00 / 10000 + le.Populated_race_pcnt*ri.Populated_race_pcnt *   0.00 / 10000 + le.Populated_pedestrian_cyclist_visibility_pcnt*ri.Populated_pedestrian_cyclist_visibility_pcnt *   0.00 / 10000 + le.Populated_first_aid_by_pcnt*ri.Populated_first_aid_by_pcnt *   0.00 / 10000 + le.Populated_person_first_aid_party_type_pcnt*ri.Populated_person_first_aid_party_type_pcnt *   0.00 / 10000 + le.Populated_person_first_aid_party_type_description_pcnt*ri.Populated_person_first_aid_party_type_description_pcnt *   0.00 / 10000 + le.Populated_deceased_at_scene_pcnt*ri.Populated_deceased_at_scene_pcnt *   0.00 / 10000 + le.Populated_death_date_pcnt*ri.Populated_death_date_pcnt *   0.00 / 10000 + le.Populated_death_time_pcnt*ri.Populated_death_time_pcnt *   0.00 / 10000 + le.Populated_extricated_pcnt*ri.Populated_extricated_pcnt *   0.00 / 10000 + le.Populated_alcohol_drug_use_pcnt*ri.Populated_alcohol_drug_use_pcnt *   0.00 / 10000 + le.Populated_physical_defects_pcnt*ri.Populated_physical_defects_pcnt *   0.00 / 10000 + le.Populated_driver_residence_pcnt*ri.Populated_driver_residence_pcnt *   0.00 / 10000 + le.Populated_id_type_pcnt*ri.Populated_id_type_pcnt *   0.00 / 10000 + le.Populated_proof_of_insurance_pcnt*ri.Populated_proof_of_insurance_pcnt *   0.00 / 10000 + le.Populated_insurance_expired_pcnt*ri.Populated_insurance_expired_pcnt *   0.00 / 10000 + le.Populated_insurance_exempt_pcnt*ri.Populated_insurance_exempt_pcnt *   0.00 / 10000 + le.Populated_insurance_type_pcnt*ri.Populated_insurance_type_pcnt *   0.00 / 10000 + le.Populated_violent_crime_victim_notified_pcnt*ri.Populated_violent_crime_victim_notified_pcnt *   0.00 / 10000 + le.Populated_insurance_company_code_pcnt*ri.Populated_insurance_company_code_pcnt *   0.00 / 10000 + le.Populated_refused_medical_treatment_pcnt*ri.Populated_refused_medical_treatment_pcnt *   0.00 / 10000 + le.Populated_safety_equipment_available_or_used_pcnt*ri.Populated_safety_equipment_available_or_used_pcnt *   0.00 / 10000 + le.Populated_apartment_number_pcnt*ri.Populated_apartment_number_pcnt *   0.00 / 10000 + le.Populated_licensed_driver_pcnt*ri.Populated_licensed_driver_pcnt *   0.00 / 10000 + le.Populated_physical_emotional_status_pcnt*ri.Populated_physical_emotional_status_pcnt *   0.00 / 10000 + le.Populated_driver_presence_pcnt*ri.Populated_driver_presence_pcnt *   0.00 / 10000 + le.Populated_ejection_path_pcnt*ri.Populated_ejection_path_pcnt *   0.00 / 10000 + le.Populated_state_person_id_pcnt*ri.Populated_state_person_id_pcnt *   0.00 / 10000 + le.Populated_contributed_to_collision_pcnt*ri.Populated_contributed_to_collision_pcnt *   0.00 / 10000 + le.Populated_person_transported_for_medical_care_pcnt*ri.Populated_person_transported_for_medical_care_pcnt *   0.00 / 10000 + le.Populated_transported_by_agency_type_pcnt*ri.Populated_transported_by_agency_type_pcnt *   0.00 / 10000 + le.Populated_transported_to_pcnt*ri.Populated_transported_to_pcnt *   0.00 / 10000 + le.Populated_non_motorist_driver_license_number_pcnt*ri.Populated_non_motorist_driver_license_number_pcnt *   0.00 / 10000 + le.Populated_air_bag_type_pcnt*ri.Populated_air_bag_type_pcnt *   0.00 / 10000 + le.Populated_cell_phone_use_pcnt*ri.Populated_cell_phone_use_pcnt *   0.00 / 10000 + le.Populated_driver_license_restriction_compliance_pcnt*ri.Populated_driver_license_restriction_compliance_pcnt *   0.00 / 10000 + le.Populated_driver_license_endorsement_compliance_pcnt*ri.Populated_driver_license_endorsement_compliance_pcnt *   0.00 / 10000 + le.Populated_driver_license_compliance_pcnt*ri.Populated_driver_license_compliance_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_p1_pcnt*ri.Populated_contributing_circumstances_p1_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_p2_pcnt*ri.Populated_contributing_circumstances_p2_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_p3_pcnt*ri.Populated_contributing_circumstances_p3_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_p4_pcnt*ri.Populated_contributing_circumstances_p4_pcnt *   0.00 / 10000 + le.Populated_passenger_number_pcnt*ri.Populated_passenger_number_pcnt *   0.00 / 10000 + le.Populated_person_deleted_pcnt*ri.Populated_person_deleted_pcnt *   0.00 / 10000 + le.Populated_owner_lessee_pcnt*ri.Populated_owner_lessee_pcnt *   0.00 / 10000 + le.Populated_driver_charged_pcnt*ri.Populated_driver_charged_pcnt *   0.00 / 10000 + le.Populated_motorcycle_eye_protection_pcnt*ri.Populated_motorcycle_eye_protection_pcnt *   0.00 / 10000 + le.Populated_motorcycle_long_sleeves_pcnt*ri.Populated_motorcycle_long_sleeves_pcnt *   0.00 / 10000 + le.Populated_motorcycle_long_pants_pcnt*ri.Populated_motorcycle_long_pants_pcnt *   0.00 / 10000 + le.Populated_motorcycle_over_ankle_boots_pcnt*ri.Populated_motorcycle_over_ankle_boots_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental_non_incident1_pcnt*ri.Populated_contributing_circumstances_environmental_non_incident1_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_environmental_non_incident2_pcnt*ri.Populated_contributing_circumstances_environmental_non_incident2_pcnt *   0.00 / 10000 + le.Populated_alcohol_drug_test_given_pcnt*ri.Populated_alcohol_drug_test_given_pcnt *   0.00 / 10000 + le.Populated_alcohol_drug_test_type_pcnt*ri.Populated_alcohol_drug_test_type_pcnt *   0.00 / 10000 + le.Populated_alcohol_drug_test_result_pcnt*ri.Populated_alcohol_drug_test_result_pcnt *   0.00 / 10000 + le.Populated_vin_pcnt*ri.Populated_vin_pcnt *   0.00 / 10000 + le.Populated_vin_status_pcnt*ri.Populated_vin_status_pcnt *   0.00 / 10000 + le.Populated_damaged_areas_derived1_pcnt*ri.Populated_damaged_areas_derived1_pcnt *   0.00 / 10000 + le.Populated_damaged_areas_derived2_pcnt*ri.Populated_damaged_areas_derived2_pcnt *   0.00 / 10000 + le.Populated_airbags_deployed_derived_pcnt*ri.Populated_airbags_deployed_derived_pcnt *   0.00 / 10000 + le.Populated_vehicle_towed_derived_pcnt*ri.Populated_vehicle_towed_derived_pcnt *   0.00 / 10000 + le.Populated_unit_type_pcnt*ri.Populated_unit_type_pcnt *   0.00 / 10000 + le.Populated_unit_number_pcnt*ri.Populated_unit_number_pcnt *   0.00 / 10000 + le.Populated_registration_state_pcnt*ri.Populated_registration_state_pcnt *   0.00 / 10000 + le.Populated_registration_year_pcnt*ri.Populated_registration_year_pcnt *   0.00 / 10000 + le.Populated_license_plate_pcnt*ri.Populated_license_plate_pcnt *   0.00 / 10000 + le.Populated_make_pcnt*ri.Populated_make_pcnt *   0.00 / 10000 + le.Populated_model_yr_pcnt*ri.Populated_model_yr_pcnt *   0.00 / 10000 + le.Populated_model_pcnt*ri.Populated_model_pcnt *   0.00 / 10000 + le.Populated_body_type_category_pcnt*ri.Populated_body_type_category_pcnt *   0.00 / 10000 + le.Populated_total_occupants_in_vehicle_pcnt*ri.Populated_total_occupants_in_vehicle_pcnt *   0.00 / 10000 + le.Populated_special_function_in_transport_pcnt*ri.Populated_special_function_in_transport_pcnt *   0.00 / 10000 + le.Populated_special_function_in_transport_other_unit_pcnt*ri.Populated_special_function_in_transport_other_unit_pcnt *   0.00 / 10000 + le.Populated_emergency_use_pcnt*ri.Populated_emergency_use_pcnt *   0.00 / 10000 + le.Populated_posted_satutory_speed_limit_pcnt*ri.Populated_posted_satutory_speed_limit_pcnt *   0.00 / 10000 + le.Populated_direction_of_travel_before_crash_pcnt*ri.Populated_direction_of_travel_before_crash_pcnt *   0.00 / 10000 + le.Populated_trafficway_description_pcnt*ri.Populated_trafficway_description_pcnt *   0.00 / 10000 + le.Populated_traffic_control_device_type_pcnt*ri.Populated_traffic_control_device_type_pcnt *   0.00 / 10000 + le.Populated_vehicle_maneuver_action_prior1_pcnt*ri.Populated_vehicle_maneuver_action_prior1_pcnt *   0.00 / 10000 + le.Populated_vehicle_maneuver_action_prior2_pcnt*ri.Populated_vehicle_maneuver_action_prior2_pcnt *   0.00 / 10000 + le.Populated_impact_area1_pcnt*ri.Populated_impact_area1_pcnt *   0.00 / 10000 + le.Populated_impact_area2_pcnt*ri.Populated_impact_area2_pcnt *   0.00 / 10000 + le.Populated_event_sequence1_pcnt*ri.Populated_event_sequence1_pcnt *   0.00 / 10000 + le.Populated_event_sequence2_pcnt*ri.Populated_event_sequence2_pcnt *   0.00 / 10000 + le.Populated_event_sequence3_pcnt*ri.Populated_event_sequence3_pcnt *   0.00 / 10000 + le.Populated_event_sequence4_pcnt*ri.Populated_event_sequence4_pcnt *   0.00 / 10000 + le.Populated_most_harmful_event_for_vehicle_pcnt*ri.Populated_most_harmful_event_for_vehicle_pcnt *   0.00 / 10000 + le.Populated_bus_use_pcnt*ri.Populated_bus_use_pcnt *   0.00 / 10000 + le.Populated_vehicle_hit_and_run_pcnt*ri.Populated_vehicle_hit_and_run_pcnt *   0.00 / 10000 + le.Populated_vehicle_towed_pcnt*ri.Populated_vehicle_towed_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_v1_pcnt*ri.Populated_contributing_circumstances_v1_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_v2_pcnt*ri.Populated_contributing_circumstances_v2_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_v3_pcnt*ri.Populated_contributing_circumstances_v3_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_v4_pcnt*ri.Populated_contributing_circumstances_v4_pcnt *   0.00 / 10000 + le.Populated_on_street_pcnt*ri.Populated_on_street_pcnt *   0.00 / 10000 + le.Populated_vehicle_color_pcnt*ri.Populated_vehicle_color_pcnt *   0.00 / 10000 + le.Populated_estimated_speed_pcnt*ri.Populated_estimated_speed_pcnt *   0.00 / 10000 + le.Populated_accident_investigation_site_pcnt*ri.Populated_accident_investigation_site_pcnt *   0.00 / 10000 + le.Populated_car_fire_pcnt*ri.Populated_car_fire_pcnt *   0.00 / 10000 + le.Populated_vehicle_damage_amount_pcnt*ri.Populated_vehicle_damage_amount_pcnt *   0.00 / 10000 + le.Populated_contributing_factors1_pcnt*ri.Populated_contributing_factors1_pcnt *   0.00 / 10000 + le.Populated_contributing_factors2_pcnt*ri.Populated_contributing_factors2_pcnt *   0.00 / 10000 + le.Populated_contributing_factors3_pcnt*ri.Populated_contributing_factors3_pcnt *   0.00 / 10000 + le.Populated_contributing_factors4_pcnt*ri.Populated_contributing_factors4_pcnt *   0.00 / 10000 + le.Populated_other_contributing_factors1_pcnt*ri.Populated_other_contributing_factors1_pcnt *   0.00 / 10000 + le.Populated_other_contributing_factors2_pcnt*ri.Populated_other_contributing_factors2_pcnt *   0.00 / 10000 + le.Populated_other_contributing_factors3_pcnt*ri.Populated_other_contributing_factors3_pcnt *   0.00 / 10000 + le.Populated_vision_obscured1_pcnt*ri.Populated_vision_obscured1_pcnt *   0.00 / 10000 + le.Populated_vision_obscured2_pcnt*ri.Populated_vision_obscured2_pcnt *   0.00 / 10000 + le.Populated_vehicle_on_road_pcnt*ri.Populated_vehicle_on_road_pcnt *   0.00 / 10000 + le.Populated_ran_off_road_pcnt*ri.Populated_ran_off_road_pcnt *   0.00 / 10000 + le.Populated_skidding_occurred_pcnt*ri.Populated_skidding_occurred_pcnt *   0.00 / 10000 + le.Populated_vehicle_incident_location1_pcnt*ri.Populated_vehicle_incident_location1_pcnt *   0.00 / 10000 + le.Populated_vehicle_incident_location2_pcnt*ri.Populated_vehicle_incident_location2_pcnt *   0.00 / 10000 + le.Populated_vehicle_incident_location3_pcnt*ri.Populated_vehicle_incident_location3_pcnt *   0.00 / 10000 + le.Populated_vehicle_disabled_pcnt*ri.Populated_vehicle_disabled_pcnt *   0.00 / 10000 + le.Populated_vehicle_removed_to_pcnt*ri.Populated_vehicle_removed_to_pcnt *   0.00 / 10000 + le.Populated_removed_by_pcnt*ri.Populated_removed_by_pcnt *   0.00 / 10000 + le.Populated_tow_requested_by_driver_pcnt*ri.Populated_tow_requested_by_driver_pcnt *   0.00 / 10000 + le.Populated_solicitation_pcnt*ri.Populated_solicitation_pcnt *   0.00 / 10000 + le.Populated_other_unit_vehicle_damage_amount_pcnt*ri.Populated_other_unit_vehicle_damage_amount_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_year_pcnt*ri.Populated_other_unit_model_year_pcnt *   0.00 / 10000 + le.Populated_other_unit_make_pcnt*ri.Populated_other_unit_make_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_pcnt*ri.Populated_other_unit_model_pcnt *   0.00 / 10000 + le.Populated_other_unit_vin_pcnt*ri.Populated_other_unit_vin_pcnt *   0.00 / 10000 + le.Populated_other_unit_vin_status_pcnt*ri.Populated_other_unit_vin_status_pcnt *   0.00 / 10000 + le.Populated_other_unit_body_type_category_pcnt*ri.Populated_other_unit_body_type_category_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_state_pcnt*ri.Populated_other_unit_registration_state_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_year_pcnt*ri.Populated_other_unit_registration_year_pcnt *   0.00 / 10000 + le.Populated_other_unit_license_plate_pcnt*ri.Populated_other_unit_license_plate_pcnt *   0.00 / 10000 + le.Populated_other_unit_color_pcnt*ri.Populated_other_unit_color_pcnt *   0.00 / 10000 + le.Populated_other_unit_type_pcnt*ri.Populated_other_unit_type_pcnt *   0.00 / 10000 + le.Populated_damaged_areas1_pcnt*ri.Populated_damaged_areas1_pcnt *   0.00 / 10000 + le.Populated_damaged_areas2_pcnt*ri.Populated_damaged_areas2_pcnt *   0.00 / 10000 + le.Populated_parked_vehicle_pcnt*ri.Populated_parked_vehicle_pcnt *   0.00 / 10000 + le.Populated_damage_rating1_pcnt*ri.Populated_damage_rating1_pcnt *   0.00 / 10000 + le.Populated_damage_rating2_pcnt*ri.Populated_damage_rating2_pcnt *   0.00 / 10000 + le.Populated_vehicle_inventoried_pcnt*ri.Populated_vehicle_inventoried_pcnt *   0.00 / 10000 + le.Populated_vehicle_defect_apparent_pcnt*ri.Populated_vehicle_defect_apparent_pcnt *   0.00 / 10000 + le.Populated_defect_may_have_contributed1_pcnt*ri.Populated_defect_may_have_contributed1_pcnt *   0.00 / 10000 + le.Populated_defect_may_have_contributed2_pcnt*ri.Populated_defect_may_have_contributed2_pcnt *   0.00 / 10000 + le.Populated_registration_expiration_pcnt*ri.Populated_registration_expiration_pcnt *   0.00 / 10000 + le.Populated_owner_driver_type_pcnt*ri.Populated_owner_driver_type_pcnt *   0.00 / 10000 + le.Populated_make_code_pcnt*ri.Populated_make_code_pcnt *   0.00 / 10000 + le.Populated_number_trailing_units_pcnt*ri.Populated_number_trailing_units_pcnt *   0.00 / 10000 + le.Populated_vehicle_position_pcnt*ri.Populated_vehicle_position_pcnt *   0.00 / 10000 + le.Populated_vehicle_type_pcnt*ri.Populated_vehicle_type_pcnt *   0.00 / 10000 + le.Populated_motorcycle_engine_size_pcnt*ri.Populated_motorcycle_engine_size_pcnt *   0.00 / 10000 + le.Populated_motorcycle_driver_educated_pcnt*ri.Populated_motorcycle_driver_educated_pcnt *   0.00 / 10000 + le.Populated_motorcycle_helmet_type_pcnt*ri.Populated_motorcycle_helmet_type_pcnt *   0.00 / 10000 + le.Populated_motorcycle_passenger_pcnt*ri.Populated_motorcycle_passenger_pcnt *   0.00 / 10000 + le.Populated_motorcycle_helmet_stayed_on_pcnt*ri.Populated_motorcycle_helmet_stayed_on_pcnt *   0.00 / 10000 + le.Populated_motorcycle_helmet_dot_snell_pcnt*ri.Populated_motorcycle_helmet_dot_snell_pcnt *   0.00 / 10000 + le.Populated_motorcycle_saddlebag_trunk_pcnt*ri.Populated_motorcycle_saddlebag_trunk_pcnt *   0.00 / 10000 + le.Populated_motorcycle_trailer_pcnt*ri.Populated_motorcycle_trailer_pcnt *   0.00 / 10000 + le.Populated_pedacycle_passenger_pcnt*ri.Populated_pedacycle_passenger_pcnt *   0.00 / 10000 + le.Populated_pedacycle_headlights_pcnt*ri.Populated_pedacycle_headlights_pcnt *   0.00 / 10000 + le.Populated_pedacycle_helmet_pcnt*ri.Populated_pedacycle_helmet_pcnt *   0.00 / 10000 + le.Populated_pedacycle_rear_reflectors_pcnt*ri.Populated_pedacycle_rear_reflectors_pcnt *   0.00 / 10000 + le.Populated_cdl_required_pcnt*ri.Populated_cdl_required_pcnt *   0.00 / 10000 + le.Populated_truck_bus_supplement_required_pcnt*ri.Populated_truck_bus_supplement_required_pcnt *   0.00 / 10000 + le.Populated_unit_damage_amount_pcnt*ri.Populated_unit_damage_amount_pcnt *   0.00 / 10000 + le.Populated_airbag_switch_pcnt*ri.Populated_airbag_switch_pcnt *   0.00 / 10000 + le.Populated_underride_override_damage_pcnt*ri.Populated_underride_override_damage_pcnt *   0.00 / 10000 + le.Populated_vehicle_attachment_pcnt*ri.Populated_vehicle_attachment_pcnt *   0.00 / 10000 + le.Populated_action_on_impact_pcnt*ri.Populated_action_on_impact_pcnt *   0.00 / 10000 + le.Populated_speed_detection_method_pcnt*ri.Populated_speed_detection_method_pcnt *   0.00 / 10000 + le.Populated_non_motorist_direction_of_travel_from_pcnt*ri.Populated_non_motorist_direction_of_travel_from_pcnt *   0.00 / 10000 + le.Populated_non_motorist_direction_of_travel_to_pcnt*ri.Populated_non_motorist_direction_of_travel_to_pcnt *   0.00 / 10000 + le.Populated_vehicle_use_pcnt*ri.Populated_vehicle_use_pcnt *   0.00 / 10000 + le.Populated_department_unit_number_pcnt*ri.Populated_department_unit_number_pcnt *   0.00 / 10000 + le.Populated_equipment_in_use_at_time_of_accident_pcnt*ri.Populated_equipment_in_use_at_time_of_accident_pcnt *   0.00 / 10000 + le.Populated_actions_of_police_vehicle_pcnt*ri.Populated_actions_of_police_vehicle_pcnt *   0.00 / 10000 + le.Populated_vehicle_command_id_pcnt*ri.Populated_vehicle_command_id_pcnt *   0.00 / 10000 + le.Populated_traffic_control_device_inoperative_pcnt*ri.Populated_traffic_control_device_inoperative_pcnt *   0.00 / 10000 + le.Populated_direction_of_impact1_pcnt*ri.Populated_direction_of_impact1_pcnt *   0.00 / 10000 + le.Populated_direction_of_impact2_pcnt*ri.Populated_direction_of_impact2_pcnt *   0.00 / 10000 + le.Populated_ran_off_road_direction_pcnt*ri.Populated_ran_off_road_direction_pcnt *   0.00 / 10000 + le.Populated_vin_other_unit_number_pcnt*ri.Populated_vin_other_unit_number_pcnt *   0.00 / 10000 + le.Populated_damaged_area_generic_pcnt*ri.Populated_damaged_area_generic_pcnt *   0.00 / 10000 + le.Populated_vision_obscured_description_pcnt*ri.Populated_vision_obscured_description_pcnt *   0.00 / 10000 + le.Populated_inattention_description_pcnt*ri.Populated_inattention_description_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_defect_description_pcnt*ri.Populated_contributing_circumstances_defect_description_pcnt *   0.00 / 10000 + le.Populated_contributing_circumstances_other_descriptioin_pcnt*ri.Populated_contributing_circumstances_other_descriptioin_pcnt *   0.00 / 10000 + le.Populated_vehicle_maneuver_action_prior_other_description_pcnt*ri.Populated_vehicle_maneuver_action_prior_other_description_pcnt *   0.00 / 10000 + le.Populated_vehicle_special_use_pcnt*ri.Populated_vehicle_special_use_pcnt *   0.00 / 10000 + le.Populated_vehicle_type_extended1_pcnt*ri.Populated_vehicle_type_extended1_pcnt *   0.00 / 10000 + le.Populated_vehicle_type_extended2_pcnt*ri.Populated_vehicle_type_extended2_pcnt *   0.00 / 10000 + le.Populated_fixed_object_direction1_pcnt*ri.Populated_fixed_object_direction1_pcnt *   0.00 / 10000 + le.Populated_fixed_object_direction2_pcnt*ri.Populated_fixed_object_direction2_pcnt *   0.00 / 10000 + le.Populated_fixed_object_direction3_pcnt*ri.Populated_fixed_object_direction3_pcnt *   0.00 / 10000 + le.Populated_fixed_object_direction4_pcnt*ri.Populated_fixed_object_direction4_pcnt *   0.00 / 10000 + le.Populated_vehicle_left_at_scene_pcnt*ri.Populated_vehicle_left_at_scene_pcnt *   0.00 / 10000 + le.Populated_vehicle_impounded_pcnt*ri.Populated_vehicle_impounded_pcnt *   0.00 / 10000 + le.Populated_vehicle_driven_from_scene_pcnt*ri.Populated_vehicle_driven_from_scene_pcnt *   0.00 / 10000 + le.Populated_on_cross_street_pcnt*ri.Populated_on_cross_street_pcnt *   0.00 / 10000 + le.Populated_actions_of_police_vehicle_description_pcnt*ri.Populated_actions_of_police_vehicle_description_pcnt *   0.00 / 10000 + le.Populated_vehicle_seg_pcnt*ri.Populated_vehicle_seg_pcnt *   0.00 / 10000 + le.Populated_vehicle_seg_type_pcnt*ri.Populated_vehicle_seg_type_pcnt *   0.00 / 10000 + le.Populated_model_year_pcnt*ri.Populated_model_year_pcnt *   0.00 / 10000 + le.Populated_body_style_code_pcnt*ri.Populated_body_style_code_pcnt *   0.00 / 10000 + le.Populated_engine_size_pcnt*ri.Populated_engine_size_pcnt *   0.00 / 10000 + le.Populated_fuel_code_pcnt*ri.Populated_fuel_code_pcnt *   0.00 / 10000 + le.Populated_number_of_driving_wheels_pcnt*ri.Populated_number_of_driving_wheels_pcnt *   0.00 / 10000 + le.Populated_steering_type_pcnt*ri.Populated_steering_type_pcnt *   0.00 / 10000 + le.Populated_vina_series_pcnt*ri.Populated_vina_series_pcnt *   0.00 / 10000 + le.Populated_vina_model_pcnt*ri.Populated_vina_model_pcnt *   0.00 / 10000 + le.Populated_vina_make_pcnt*ri.Populated_vina_make_pcnt *   0.00 / 10000 + le.Populated_vina_body_style_pcnt*ri.Populated_vina_body_style_pcnt *   0.00 / 10000 + le.Populated_make_description_pcnt*ri.Populated_make_description_pcnt *   0.00 / 10000 + le.Populated_model_description_pcnt*ri.Populated_model_description_pcnt *   0.00 / 10000 + le.Populated_series_description_pcnt*ri.Populated_series_description_pcnt *   0.00 / 10000 + le.Populated_car_cylinders_pcnt*ri.Populated_car_cylinders_pcnt *   0.00 / 10000 + le.Populated_other_vehicle_seg_pcnt*ri.Populated_other_vehicle_seg_pcnt *   0.00 / 10000 + le.Populated_other_vehicle_seg_type_pcnt*ri.Populated_other_vehicle_seg_type_pcnt *   0.00 / 10000 + le.Populated_other_model_year_pcnt*ri.Populated_other_model_year_pcnt *   0.00 / 10000 + le.Populated_other_body_style_code_pcnt*ri.Populated_other_body_style_code_pcnt *   0.00 / 10000 + le.Populated_other_engine_size_pcnt*ri.Populated_other_engine_size_pcnt *   0.00 / 10000 + le.Populated_other_fuel_code_pcnt*ri.Populated_other_fuel_code_pcnt *   0.00 / 10000 + le.Populated_other_number_of_driving_wheels_pcnt*ri.Populated_other_number_of_driving_wheels_pcnt *   0.00 / 10000 + le.Populated_other_steering_type_pcnt*ri.Populated_other_steering_type_pcnt *   0.00 / 10000 + le.Populated_other_vina_series_pcnt*ri.Populated_other_vina_series_pcnt *   0.00 / 10000 + le.Populated_other_vina_model_pcnt*ri.Populated_other_vina_model_pcnt *   0.00 / 10000 + le.Populated_other_vina_make_pcnt*ri.Populated_other_vina_make_pcnt *   0.00 / 10000 + le.Populated_other_vina_body_style_pcnt*ri.Populated_other_vina_body_style_pcnt *   0.00 / 10000 + le.Populated_other_make_description_pcnt*ri.Populated_other_make_description_pcnt *   0.00 / 10000 + le.Populated_other_model_description_pcnt*ri.Populated_other_model_description_pcnt *   0.00 / 10000 + le.Populated_other_series_description_pcnt*ri.Populated_other_series_description_pcnt *   0.00 / 10000 + le.Populated_other_car_cylinders_pcnt*ri.Populated_other_car_cylinders_pcnt *   0.00 / 10000 + le.Populated_report_has_coversheet_pcnt*ri.Populated_report_has_coversheet_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_z5_pcnt*ri.Populated_z5_pcnt *   0.00 / 10000 + le.Populated_z4_pcnt*ri.Populated_z4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_code_pcnt*ri.Populated_county_code_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_nametype_pcnt*ri.Populated_nametype_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_title2_pcnt*ri.Populated_title2_pcnt *   0.00 / 10000 + le.Populated_fname2_pcnt*ri.Populated_fname2_pcnt *   0.00 / 10000 + le.Populated_mname2_pcnt*ri.Populated_mname2_pcnt *   0.00 / 10000 + le.Populated_lname2_pcnt*ri.Populated_lname2_pcnt *   0.00 / 10000 + le.Populated_suffix2_pcnt*ri.Populated_suffix2_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_bdid_score_pcnt*ri.Populated_bdid_score_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_law_enforcement_suspects_alcohol_use1_pcnt*ri.Populated_law_enforcement_suspects_alcohol_use1_pcnt *   0.00 / 10000 + le.Populated_law_enforcement_suspects_drug_use1_pcnt*ri.Populated_law_enforcement_suspects_drug_use1_pcnt *   0.00 / 10000 + le.Populated_ems_notified_time_pcnt*ri.Populated_ems_notified_time_pcnt *   0.00 / 10000 + le.Populated_ems_arrival_time_pcnt*ri.Populated_ems_arrival_time_pcnt *   0.00 / 10000 + le.Populated_avoidance_maneuver2_pcnt*ri.Populated_avoidance_maneuver2_pcnt *   0.00 / 10000 + le.Populated_avoidance_maneuver3_pcnt*ri.Populated_avoidance_maneuver3_pcnt *   0.00 / 10000 + le.Populated_avoidance_maneuver4_pcnt*ri.Populated_avoidance_maneuver4_pcnt *   0.00 / 10000 + le.Populated_damaged_areas_severity1_pcnt*ri.Populated_damaged_areas_severity1_pcnt *   0.00 / 10000 + le.Populated_damaged_areas_severity2_pcnt*ri.Populated_damaged_areas_severity2_pcnt *   0.00 / 10000 + le.Populated_vehicle_outside_city_indicator_pcnt*ri.Populated_vehicle_outside_city_indicator_pcnt *   0.00 / 10000 + le.Populated_vehicle_outside_city_distance_miles_pcnt*ri.Populated_vehicle_outside_city_distance_miles_pcnt *   0.00 / 10000 + le.Populated_vehicle_outside_city_direction_pcnt*ri.Populated_vehicle_outside_city_direction_pcnt *   0.00 / 10000 + le.Populated_vehicle_crash_cityplace_pcnt*ri.Populated_vehicle_crash_cityplace_pcnt *   0.00 / 10000 + le.Populated_insurance_company_standardized_pcnt*ri.Populated_insurance_company_standardized_pcnt *   0.00 / 10000 + le.Populated_insurance_expiration_date_pcnt*ri.Populated_insurance_expiration_date_pcnt *   0.00 / 10000 + le.Populated_insurance_policy_holder_pcnt*ri.Populated_insurance_policy_holder_pcnt *   0.00 / 10000 + le.Populated_is_tag_converted_pcnt*ri.Populated_is_tag_converted_pcnt *   0.00 / 10000 + le.Populated_vin_original_pcnt*ri.Populated_vin_original_pcnt *   0.00 / 10000 + le.Populated_make_original_pcnt*ri.Populated_make_original_pcnt *   0.00 / 10000 + le.Populated_model_original_pcnt*ri.Populated_model_original_pcnt *   0.00 / 10000 + le.Populated_model_year_original_pcnt*ri.Populated_model_year_original_pcnt *   0.00 / 10000 + le.Populated_other_unit_vin_original_pcnt*ri.Populated_other_unit_vin_original_pcnt *   0.00 / 10000 + le.Populated_other_unit_make_original_pcnt*ri.Populated_other_unit_make_original_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_original_pcnt*ri.Populated_other_unit_model_original_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_year_original_pcnt*ri.Populated_other_unit_model_year_original_pcnt *   0.00 / 10000 + le.Populated_source_id_pcnt*ri.Populated_source_id_pcnt *   0.00 / 10000 + le.Populated_orig_fname_pcnt*ri.Populated_orig_fname_pcnt *   0.00 / 10000 + le.Populated_orig_lname_pcnt*ri.Populated_orig_lname_pcnt *   0.00 / 10000 + le.Populated_orig_mname_pcnt*ri.Populated_orig_mname_pcnt *   0.00 / 10000 + le.Populated_initial_point_of_contact_pcnt*ri.Populated_initial_point_of_contact_pcnt *   0.00 / 10000 + le.Populated_vehicle_driveable_pcnt*ri.Populated_vehicle_driveable_pcnt *   0.00 / 10000 + le.Populated_drivers_license_type_pcnt*ri.Populated_drivers_license_type_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_refused_pcnt*ri.Populated_alcohol_test_type_refused_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_not_offered_pcnt*ri.Populated_alcohol_test_type_not_offered_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_field_pcnt*ri.Populated_alcohol_test_type_field_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_pbt_pcnt*ri.Populated_alcohol_test_type_pbt_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_breath_pcnt*ri.Populated_alcohol_test_type_breath_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_blood_pcnt*ri.Populated_alcohol_test_type_blood_pcnt *   0.00 / 10000 + le.Populated_alcohol_test_type_urine_pcnt*ri.Populated_alcohol_test_type_urine_pcnt *   0.00 / 10000 + le.Populated_trapped_pcnt*ri.Populated_trapped_pcnt *   0.00 / 10000 + le.Populated_dl_number_cdl_endorsements_pcnt*ri.Populated_dl_number_cdl_endorsements_pcnt *   0.00 / 10000 + le.Populated_dl_number_cdl_restrictions_pcnt*ri.Populated_dl_number_cdl_restrictions_pcnt *   0.00 / 10000 + le.Populated_dl_number_cdl_exempt_pcnt*ri.Populated_dl_number_cdl_exempt_pcnt *   0.00 / 10000 + le.Populated_dl_number_cdl_medical_card_pcnt*ri.Populated_dl_number_cdl_medical_card_pcnt *   0.00 / 10000 + le.Populated_interlock_device_in_use_pcnt*ri.Populated_interlock_device_in_use_pcnt *   0.00 / 10000 + le.Populated_drug_test_type_blood_pcnt*ri.Populated_drug_test_type_blood_pcnt *   0.00 / 10000 + le.Populated_drug_test_type_urine_pcnt*ri.Populated_drug_test_type_urine_pcnt *   0.00 / 10000 + le.Populated_traffic_control_condition_pcnt*ri.Populated_traffic_control_condition_pcnt *   0.00 / 10000 + le.Populated_intersection_related_pcnt*ri.Populated_intersection_related_pcnt *   0.00 / 10000 + le.Populated_special_study_local_pcnt*ri.Populated_special_study_local_pcnt *   0.00 / 10000 + le.Populated_special_study_state_pcnt*ri.Populated_special_study_state_pcnt *   0.00 / 10000 + le.Populated_off_road_vehicle_involved_pcnt*ri.Populated_off_road_vehicle_involved_pcnt *   0.00 / 10000 + le.Populated_location_type2_pcnt*ri.Populated_location_type2_pcnt *   0.00 / 10000 + le.Populated_speed_limit_posted_pcnt*ri.Populated_speed_limit_posted_pcnt *   0.00 / 10000 + le.Populated_traffic_control_damage_notify_date_pcnt*ri.Populated_traffic_control_damage_notify_date_pcnt *   0.00 / 10000 + le.Populated_traffic_control_damage_notify_time_pcnt*ri.Populated_traffic_control_damage_notify_time_pcnt *   0.00 / 10000 + le.Populated_traffic_control_damage_notify_name_pcnt*ri.Populated_traffic_control_damage_notify_name_pcnt *   0.00 / 10000 + le.Populated_public_property_damaged_pcnt*ri.Populated_public_property_damaged_pcnt *   0.00 / 10000 + le.Populated_replacement_report_pcnt*ri.Populated_replacement_report_pcnt *   0.00 / 10000 + le.Populated_deleted_report_pcnt*ri.Populated_deleted_report_pcnt *   0.00 / 10000 + le.Populated_next_street_prefix_pcnt*ri.Populated_next_street_prefix_pcnt *   0.00 / 10000 + le.Populated_violator_name_pcnt*ri.Populated_violator_name_pcnt *   0.00 / 10000 + le.Populated_type_hazardous_pcnt*ri.Populated_type_hazardous_pcnt *   0.00 / 10000 + le.Populated_type_other_pcnt*ri.Populated_type_other_pcnt *   0.00 / 10000 + le.Populated_unit_type_and_axles1_pcnt*ri.Populated_unit_type_and_axles1_pcnt *   0.00 / 10000 + le.Populated_unit_type_and_axles2_pcnt*ri.Populated_unit_type_and_axles2_pcnt *   0.00 / 10000 + le.Populated_unit_type_and_axles3_pcnt*ri.Populated_unit_type_and_axles3_pcnt *   0.00 / 10000 + le.Populated_unit_type_and_axles4_pcnt*ri.Populated_unit_type_and_axles4_pcnt *   0.00 / 10000 + le.Populated_incident_damage_amount_pcnt*ri.Populated_incident_damage_amount_pcnt *   0.00 / 10000 + le.Populated_dot_use_pcnt*ri.Populated_dot_use_pcnt *   0.00 / 10000 + le.Populated_number_of_persons_involved_pcnt*ri.Populated_number_of_persons_involved_pcnt *   0.00 / 10000 + le.Populated_unusual_road_condition_other_description_pcnt*ri.Populated_unusual_road_condition_other_description_pcnt *   0.00 / 10000 + le.Populated_number_of_narrative_sections_pcnt*ri.Populated_number_of_narrative_sections_pcnt *   0.00 / 10000 + le.Populated_cad_number_pcnt*ri.Populated_cad_number_pcnt *   0.00 / 10000 + le.Populated_visibility_pcnt*ri.Populated_visibility_pcnt *   0.00 / 10000 + le.Populated_accident_at_intersection_pcnt*ri.Populated_accident_at_intersection_pcnt *   0.00 / 10000 + le.Populated_accident_not_at_intersection_pcnt*ri.Populated_accident_not_at_intersection_pcnt *   0.00 / 10000 + le.Populated_first_harmful_event_within_interchange_pcnt*ri.Populated_first_harmful_event_within_interchange_pcnt *   0.00 / 10000 + le.Populated_injury_involved_pcnt*ri.Populated_injury_involved_pcnt *   0.00 / 10000 + le.Populated_citation_status_pcnt*ri.Populated_citation_status_pcnt *   0.00 / 10000 + le.Populated_commercial_vehicle_pcnt*ri.Populated_commercial_vehicle_pcnt *   0.00 / 10000 + le.Populated_not_in_transport_pcnt*ri.Populated_not_in_transport_pcnt *   0.00 / 10000 + le.Populated_other_unit_number_pcnt*ri.Populated_other_unit_number_pcnt *   0.00 / 10000 + le.Populated_other_unit_length_pcnt*ri.Populated_other_unit_length_pcnt *   0.00 / 10000 + le.Populated_other_unit_axles_pcnt*ri.Populated_other_unit_axles_pcnt *   0.00 / 10000 + le.Populated_other_unit_plate_expiration_pcnt*ri.Populated_other_unit_plate_expiration_pcnt *   0.00 / 10000 + le.Populated_other_unit_permanent_registration_pcnt*ri.Populated_other_unit_permanent_registration_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_year2_pcnt*ri.Populated_other_unit_model_year2_pcnt *   0.00 / 10000 + le.Populated_other_unit_make2_pcnt*ri.Populated_other_unit_make2_pcnt *   0.00 / 10000 + le.Populated_other_unit_vin2_pcnt*ri.Populated_other_unit_vin2_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_state2_pcnt*ri.Populated_other_unit_registration_state2_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_year2_pcnt*ri.Populated_other_unit_registration_year2_pcnt *   0.00 / 10000 + le.Populated_other_unit_license_plate2_pcnt*ri.Populated_other_unit_license_plate2_pcnt *   0.00 / 10000 + le.Populated_other_unit_number2_pcnt*ri.Populated_other_unit_number2_pcnt *   0.00 / 10000 + le.Populated_other_unit_length2_pcnt*ri.Populated_other_unit_length2_pcnt *   0.00 / 10000 + le.Populated_other_unit_axles2_pcnt*ri.Populated_other_unit_axles2_pcnt *   0.00 / 10000 + le.Populated_other_unit_plate_expiration2_pcnt*ri.Populated_other_unit_plate_expiration2_pcnt *   0.00 / 10000 + le.Populated_other_unit_permanent_registration2_pcnt*ri.Populated_other_unit_permanent_registration2_pcnt *   0.00 / 10000 + le.Populated_other_unit_type2_pcnt*ri.Populated_other_unit_type2_pcnt *   0.00 / 10000 + le.Populated_other_unit_model_year3_pcnt*ri.Populated_other_unit_model_year3_pcnt *   0.00 / 10000 + le.Populated_other_unit_make3_pcnt*ri.Populated_other_unit_make3_pcnt *   0.00 / 10000 + le.Populated_other_unit_vin3_pcnt*ri.Populated_other_unit_vin3_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_state3_pcnt*ri.Populated_other_unit_registration_state3_pcnt *   0.00 / 10000 + le.Populated_other_unit_registration_year3_pcnt*ri.Populated_other_unit_registration_year3_pcnt *   0.00 / 10000 + le.Populated_other_unit_license_plate3_pcnt*ri.Populated_other_unit_license_plate3_pcnt *   0.00 / 10000 + le.Populated_other_unit_number3_pcnt*ri.Populated_other_unit_number3_pcnt *   0.00 / 10000 + le.Populated_other_unit_length3_pcnt*ri.Populated_other_unit_length3_pcnt *   0.00 / 10000 + le.Populated_other_unit_axles3_pcnt*ri.Populated_other_unit_axles3_pcnt *   0.00 / 10000 + le.Populated_other_unit_plate_expiration3_pcnt*ri.Populated_other_unit_plate_expiration3_pcnt *   0.00 / 10000 + le.Populated_other_unit_permanent_registration3_pcnt*ri.Populated_other_unit_permanent_registration3_pcnt *   0.00 / 10000 + le.Populated_other_unit_type3_pcnt*ri.Populated_other_unit_type3_pcnt *   0.00 / 10000 + le.Populated_damaged_areas3_pcnt*ri.Populated_damaged_areas3_pcnt *   0.00 / 10000 + le.Populated_driver_distracted_by_pcnt*ri.Populated_driver_distracted_by_pcnt *   0.00 / 10000 + le.Populated_non_motorist_type_pcnt*ri.Populated_non_motorist_type_pcnt *   0.00 / 10000 + le.Populated_seating_position_row_pcnt*ri.Populated_seating_position_row_pcnt *   0.00 / 10000 + le.Populated_seating_position_seat_pcnt*ri.Populated_seating_position_seat_pcnt *   0.00 / 10000 + le.Populated_seating_position_description_pcnt*ri.Populated_seating_position_description_pcnt *   0.00 / 10000 + le.Populated_transported_id_number_pcnt*ri.Populated_transported_id_number_pcnt *   0.00 / 10000 + le.Populated_witness_number_pcnt*ri.Populated_witness_number_pcnt *   0.00 / 10000 + le.Populated_date_of_birth_derived_pcnt*ri.Populated_date_of_birth_derived_pcnt *   0.00 / 10000 + le.Populated_property_damage_id_pcnt*ri.Populated_property_damage_id_pcnt *   0.00 / 10000 + le.Populated_property_owner_name_pcnt*ri.Populated_property_owner_name_pcnt *   0.00 / 10000 + le.Populated_damage_description_pcnt*ri.Populated_damage_description_pcnt *   0.00 / 10000 + le.Populated_damage_estimate_pcnt*ri.Populated_damage_estimate_pcnt *   0.00 / 10000 + le.Populated_narrative_pcnt*ri.Populated_narrative_pcnt *   0.00 / 10000 + le.Populated_narrative_continuance_pcnt*ri.Populated_narrative_continuance_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_hazmat_placard_number1_pcnt*ri.Populated_hazardous_materials_hazmat_placard_number1_pcnt *   0.00 / 10000 + le.Populated_hazardous_materials_hazmat_placard_number2_pcnt*ri.Populated_hazardous_materials_hazmat_placard_number2_pcnt *   0.00 / 10000 + le.Populated_vendor_code_pcnt*ri.Populated_vendor_code_pcnt *   0.00 / 10000 + le.Populated_report_property_damage_pcnt*ri.Populated_report_property_damage_pcnt *   0.00 / 10000 + le.Populated_report_collision_type_pcnt*ri.Populated_report_collision_type_pcnt *   0.00 / 10000 + le.Populated_report_first_harmful_event_pcnt*ri.Populated_report_first_harmful_event_pcnt *   0.00 / 10000 + le.Populated_report_light_condition_pcnt*ri.Populated_report_light_condition_pcnt *   0.00 / 10000 + le.Populated_report_weather_condition_pcnt*ri.Populated_report_weather_condition_pcnt *   0.00 / 10000 + le.Populated_report_road_condition_pcnt*ri.Populated_report_road_condition_pcnt *   0.00 / 10000 + le.Populated_report_injury_status_pcnt*ri.Populated_report_injury_status_pcnt *   0.00 / 10000 + le.Populated_report_damage_extent_pcnt*ri.Populated_report_damage_extent_pcnt *   0.00 / 10000 + le.Populated_report_vehicle_type_pcnt*ri.Populated_report_vehicle_type_pcnt *   0.00 / 10000 + le.Populated_report_traffic_control_device_type_pcnt*ri.Populated_report_traffic_control_device_type_pcnt *   0.00 / 10000 + le.Populated_report_contributing_circumstances_v_pcnt*ri.Populated_report_contributing_circumstances_v_pcnt *   0.00 / 10000 + le.Populated_report_vehicle_maneuver_action_prior_pcnt*ri.Populated_report_vehicle_maneuver_action_prior_pcnt *   0.00 / 10000 + le.Populated_report_vehicle_body_type_pcnt*ri.Populated_report_vehicle_body_type_pcnt *   0.00 / 10000 + le.Populated_cru_agency_name_pcnt*ri.Populated_cru_agency_name_pcnt *   0.00 / 10000 + le.Populated_cru_agency_id_pcnt*ri.Populated_cru_agency_id_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_vendor_report_id_pcnt*ri.Populated_vendor_report_id_pcnt *   0.00 / 10000 + le.Populated_is_available_for_public_pcnt*ri.Populated_is_available_for_public_pcnt *   0.00 / 10000 + le.Populated_has_addendum_pcnt*ri.Populated_has_addendum_pcnt *   0.00 / 10000 + le.Populated_report_agency_ori_pcnt*ri.Populated_report_agency_ori_pcnt *   0.00 / 10000 + le.Populated_report_status_pcnt*ri.Populated_report_status_pcnt *   0.00 / 10000 + le.Populated_super_report_id_pcnt*ri.Populated_super_report_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'date_vendor_first_reported','date_vendor_last_reported','dt_first_seen','dt_last_seen','report_code','report_category','report_code_desc','citation_id','creation_date','incident_id','citation_issued','citation_number1','citation_number2','section_number1','court_date','court_time','citation_detail1','local_code','violation_code1','violation_code2','multiple_charges_indicator','dui_indicator','commercial_id','vehicle_id','commercial_info_source','commercial_vehicle_type','motor_carrier_id_dot_number','motor_carrier_id_state_id','motor_carrier_id_carrier_name','motor_carrier_id_address','motor_carrier_id_city','motor_carrier_id_state','motor_carrier_id_zipcode','motor_carrier_id_commercial_indicator','carrier_id_type','carrier_unit_number','dot_permit_number','iccmc_number','mcs_vehicle_inspection','mcs_form_number','mcs_out_of_service','mcs_violation_related','number_of_axles','number_of_tires','gvw_over_10k_pounds','weight_rating','registered_gross_vehicle_weight','vehicle_length_feet','cargo_body_type','load_type','oversize_load','vehicle_configuration','trailer1_type','trailer1_length_feet','trailer1_width_feet','trailer2_type','trailer2_length_feet','trailer2_width_feet','federally_reportable','vehicle_inspection_hazmat','hazmat_form_number','hazmt_out_of_service','hazmat_violation_related','hazardous_materials_placard','hazardous_materials_class_number1','hazardous_materials_class_number2','hazmat_placard_name','hazardous_materials_released1','hazardous_materials_released2','hazardous_materials_released3','hazardous_materials_released4','commercial_event1','commercial_event2','commercial_event3','commercial_event4','recommended_driver_reexam','transporting_hazmat','liquid_hazmat_volume','oversize_vehicle','overlength_vehicle','oversize_vehicle_permitted','overlength_vehicle_permitted','carrier_phone_number','commerce_type','citation_issued_to_vehicle','cdl_class','dot_state','fire_hazardous_materials_involvement','commercial_event_description','supplment_required_hazmat_placard','other_state_number1','other_state_number2','work_type_id','report_id','agency_id','sent_to_hpcc_datetime','corrected_incident','cru_order_id','cru_sequence_nbr','loss_state_abbr','report_type_id','hash_key','case_identifier','crash_county','county_cd','crash_cityplace','crash_city','city_code','first_harmful_event','first_harmful_event_location','manner_crash_impact1','weather_condition1','weather_condition2','light_condition1','light_condition2','road_surface_condition','contributing_circumstances_environmental1','contributing_circumstances_environmental2','contributing_circumstances_environmental3','contributing_circumstances_environmental4','contributing_circumstances_road1','contributing_circumstances_road2','contributing_circumstances_road3','contributing_circumstances_road4','relation_to_junction','intersection_type','school_bus_related','work_zone_related','work_zone_location','work_zone_type','work_zone_workers_present','work_zone_law_enforcement_present','crash_severity','number_of_vehicles','total_nonfatal_injuries','total_fatal_injuries','day_of_week','roadway_curvature','part_of_national_highway_system','roadway_functional_class','access_control','rr_crossing_id','roadway_lighting','traffic_control_type_at_intersection1','traffic_control_type_at_intersection2','ncic_number','state_report_number','ori_number','crash_date','crash_time','lattitude','longitude','milepost1','milepost2','address_number','loss_street','loss_street_route_number','loss_street_type','loss_street_speed_limit','incident_location_indicator','loss_cross_street','loss_cross_street_route_number','loss_cross_street_intersecting_route_segment','loss_cross_street_type','loss_cross_street_speed_limit','loss_cross_street_number_of_lanes','loss_cross_street_orientation','loss_cross_street_route_sign','at_node_number','distance_from_node_feet','distance_from_node_miles','next_node_number','next_roadway_node_number','direction_of_travel','next_street','next_street_type','next_street_suffix','before_or_after_next_street','next_street_distance_feet','next_street_distance_miles','next_street_direction','next_street_route_segment','continuing_toward_street','continuing_street_suffix','continuing_street_direction','continuting_street_route_segment','city_type','outside_city_indicator','outside_city_direction','outside_city_distance_feet','outside_city_distance_miles','crash_type','motor_vehicle_involved_with','report_investigation_type','incident_hit_and_run','tow_away','date_notified','time_notified','notification_method','officer_arrival_time','officer_report_date','officer_report_time','officer_id','officer_department','officer_rank','officer_command','officer_tax_id_number','completed_report_date','supervisor_check_date','supervisor_check_time','supervisor_id','supervisor_rank','reviewers_name','road_surface','roadway_alignment','traffic_way_description','traffic_flow','property_damage_involved','property_damage_description1','property_damage_description2','property_damage_estimate1','property_damage_estimate2','incident_damage_over_limit','property_owner_notified','government_property','accident_condition','unusual_road_condition1','unusual_road_condition2','number_of_lanes','divided_highway','most_harmful_event','second_harmful_event','ems_notified_date','ems_arrival_date','hospital_arrival_date','injured_taken_by','injured_taken_to','incident_transported_for_medical_care','photographs_taken','photographed_by','photographer_id','photography_agency_name','agency_name','judicial_district','precinct','beat','location_type','shoulder_type','investigation_complete','investigation_not_complete_why','investigating_officer_name','investigation_notification_issued','agency_type','no_injury_tow_involved','injury_tow_involved','lars_code1','lars_code2','private_property_incident','accident_involvement','local_use','street_prefix','street_suffix','toll_road','street_description','cross_street_address_number','cross_street_prefix','cross_street_suffix','report_complete','dispatch_notified','counter_report','road_type','agency_code','public_property_employee','bridge_related','ramp_indicator','to_or_from_location','complaint_number','school_zone_related','notify_dot_maintenance','special_location','route_segment','route_sign','route_category_street','route_category_cross_street','route_category_next_street','lane_closed','lane_closure_direction','lane_direction','traffic_detoured','time_closed','pedestrian_signals','work_zone_speed_limit','work_zone_shoulder_median','work_zone_intermittent_moving','work_zone_flagger_control','special_work_zone_characteristics','lane_number','offset_distance_feet','offset_distance_miles','offset_direction','asru_code','mp_grid','number_of_qualifying_units','number_of_hazmat_vehicles','number_of_buses_involved','number_taken_to_treatment','number_vehicles_towed','vehicle_at_fault_unit_number','time_officer_cleared_scene','total_minutes_on_scene','motorists_report','fatality_involved','local_dot_index_number','dor_number','hospital_code','special_jurisdiction','document_type','distance_was_measured','street_orientation','intersecting_route_segment','primary_fault_indicator','first_harmful_event_pedestrian','reference_markers','other_officer_on_scene','other_officer_badge_number','supplemental_report','supplemental_type','amended_report','corrected_report','state_highway_related','roadway_lighting_condition','vendor_reference_number','duplicate_copy_unit_number','other_city_agency_description','notifcation_description','primary_collision_improper_driving_description','weather_other_description','crash_type_description','motor_vehicle_involved_with_animal_description','motor_vehicle_involved_with_fixed_object_description','motor_vehicle_involved_with_other_object_description','other_investigation_time','milepost_detail','utility_pole_number1','utility_pole_number2','utility_pole_number3','person_id','person_number','vehicle_unit_number','sex','person_type','injury_status','occupant_vehicle_unit_number','seating_position1','safety_equipment_restraint1','safety_equipment_restraint2','safety_equipment_helmet','air_bag_deployed','ejection','drivers_license_jurisdiction','dl_number_class','dl_number_cdl','dl_number_endorsements','driver_actions_at_time_of_crash1','driver_actions_at_time_of_crash2','driver_actions_at_time_of_crash3','driver_actions_at_time_of_crash4','violation_codes','condition_at_time_of_crash1','condition_at_time_of_crash2','law_enforcement_suspects_alcohol_use','alcohol_test_status','alcohol_test_type','alcohol_test_result','law_enforcement_suspects_drug_use','drug_test_given','non_motorist_actions_prior_to_crash1','non_motorist_actions_prior_to_crash2','non_motorist_actions_at_time_of_crash','non_motorist_location_at_time_of_crash','non_motorist_safety_equipment1','age','driver_license_restrictions1','drug_test_type','drug_test_result1','drug_test_result2','drug_test_result3','drug_test_result4','injury_area','injury_description','motorcyclist_head_injury','party_id','same_as_driver','address_same_as_driver','last_name','first_name','middle_name','name_suffx','date_of_birth','address','city','state','zip_code','home_phone','business_phone','insurance_company','insurance_company_phone_number','insurance_policy_number','insurance_effective_date','ssn','drivers_license_number','drivers_license_expiration','eye_color','hair_color','height','weight','race','pedestrian_cyclist_visibility','first_aid_by','person_first_aid_party_type','person_first_aid_party_type_description','deceased_at_scene','death_date','death_time','extricated','alcohol_drug_use','physical_defects','driver_residence','id_type','proof_of_insurance','insurance_expired','insurance_exempt','insurance_type','violent_crime_victim_notified','insurance_company_code','refused_medical_treatment','safety_equipment_available_or_used','apartment_number','licensed_driver','physical_emotional_status','driver_presence','ejection_path','state_person_id','contributed_to_collision','person_transported_for_medical_care','transported_by_agency_type','transported_to','non_motorist_driver_license_number','air_bag_type','cell_phone_use','driver_license_restriction_compliance','driver_license_endorsement_compliance','driver_license_compliance','contributing_circumstances_p1','contributing_circumstances_p2','contributing_circumstances_p3','contributing_circumstances_p4','passenger_number','person_deleted','owner_lessee','driver_charged','motorcycle_eye_protection','motorcycle_long_sleeves','motorcycle_long_pants','motorcycle_over_ankle_boots','contributing_circumstances_environmental_non_incident1','contributing_circumstances_environmental_non_incident2','alcohol_drug_test_given','alcohol_drug_test_type','alcohol_drug_test_result','vin','vin_status','damaged_areas_derived1','damaged_areas_derived2','airbags_deployed_derived','vehicle_towed_derived','unit_type','unit_number','registration_state','registration_year','license_plate','make','model_yr','model','body_type_category','total_occupants_in_vehicle','special_function_in_transport','special_function_in_transport_other_unit','emergency_use','posted_satutory_speed_limit','direction_of_travel_before_crash','trafficway_description','traffic_control_device_type','vehicle_maneuver_action_prior1','vehicle_maneuver_action_prior2','impact_area1','impact_area2','event_sequence1','event_sequence2','event_sequence3','event_sequence4','most_harmful_event_for_vehicle','bus_use','vehicle_hit_and_run','vehicle_towed','contributing_circumstances_v1','contributing_circumstances_v2','contributing_circumstances_v3','contributing_circumstances_v4','on_street','vehicle_color','estimated_speed','accident_investigation_site','car_fire','vehicle_damage_amount','contributing_factors1','contributing_factors2','contributing_factors3','contributing_factors4','other_contributing_factors1','other_contributing_factors2','other_contributing_factors3','vision_obscured1','vision_obscured2','vehicle_on_road','ran_off_road','skidding_occurred','vehicle_incident_location1','vehicle_incident_location2','vehicle_incident_location3','vehicle_disabled','vehicle_removed_to','removed_by','tow_requested_by_driver','solicitation','other_unit_vehicle_damage_amount','other_unit_model_year','other_unit_make','other_unit_model','other_unit_vin','other_unit_vin_status','other_unit_body_type_category','other_unit_registration_state','other_unit_registration_year','other_unit_license_plate','other_unit_color','other_unit_type','damaged_areas1','damaged_areas2','parked_vehicle','damage_rating1','damage_rating2','vehicle_inventoried','vehicle_defect_apparent','defect_may_have_contributed1','defect_may_have_contributed2','registration_expiration','owner_driver_type','make_code','number_trailing_units','vehicle_position','vehicle_type','motorcycle_engine_size','motorcycle_driver_educated','motorcycle_helmet_type','motorcycle_passenger','motorcycle_helmet_stayed_on','motorcycle_helmet_dot_snell','motorcycle_saddlebag_trunk','motorcycle_trailer','pedacycle_passenger','pedacycle_headlights','pedacycle_helmet','pedacycle_rear_reflectors','cdl_required','truck_bus_supplement_required','unit_damage_amount','airbag_switch','underride_override_damage','vehicle_attachment','action_on_impact','speed_detection_method','non_motorist_direction_of_travel_from','non_motorist_direction_of_travel_to','vehicle_use','department_unit_number','equipment_in_use_at_time_of_accident','actions_of_police_vehicle','vehicle_command_id','traffic_control_device_inoperative','direction_of_impact1','direction_of_impact2','ran_off_road_direction','vin_other_unit_number','damaged_area_generic','vision_obscured_description','inattention_description','contributing_circumstances_defect_description','contributing_circumstances_other_descriptioin','vehicle_maneuver_action_prior_other_description','vehicle_special_use','vehicle_type_extended1','vehicle_type_extended2','fixed_object_direction1','fixed_object_direction2','fixed_object_direction3','fixed_object_direction4','vehicle_left_at_scene','vehicle_impounded','vehicle_driven_from_scene','on_cross_street','actions_of_police_vehicle_description','vehicle_seg','vehicle_seg_type','model_year','body_style_code','engine_size','fuel_code','number_of_driving_wheels','steering_type','vina_series','vina_model','vina_make','vina_body_style','make_description','model_description','series_description','car_cylinders','other_vehicle_seg','other_vehicle_seg_type','other_model_year','other_body_style_code','other_engine_size','other_fuel_code','other_number_of_driving_wheels','other_steering_type','other_vina_series','other_vina_model','other_vina_make','other_vina_body_style','other_make_description','other_model_description','other_series_description','other_car_cylinders','report_has_coversheet','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5','z4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','county_code','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','nametype','title','fname','mname','lname','suffix','title2','fname2','mname2','lname2','suffix2','name_score','did','did_score','bdid','bdid_score','rawaid','law_enforcement_suspects_alcohol_use1','law_enforcement_suspects_drug_use1','ems_notified_time','ems_arrival_time','avoidance_maneuver2','avoidance_maneuver3','avoidance_maneuver4','damaged_areas_severity1','damaged_areas_severity2','vehicle_outside_city_indicator','vehicle_outside_city_distance_miles','vehicle_outside_city_direction','vehicle_crash_cityplace','insurance_company_standardized','insurance_expiration_date','insurance_policy_holder','is_tag_converted','vin_original','make_original','model_original','model_year_original','other_unit_vin_original','other_unit_make_original','other_unit_model_original','other_unit_model_year_original','source_id','orig_fname','orig_lname','orig_mname','initial_point_of_contact','vehicle_driveable','drivers_license_type','alcohol_test_type_refused','alcohol_test_type_not_offered','alcohol_test_type_field','alcohol_test_type_pbt','alcohol_test_type_breath','alcohol_test_type_blood','alcohol_test_type_urine','trapped','dl_number_cdl_endorsements','dl_number_cdl_restrictions','dl_number_cdl_exempt','dl_number_cdl_medical_card','interlock_device_in_use','drug_test_type_blood','drug_test_type_urine','traffic_control_condition','intersection_related','special_study_local','special_study_state','off_road_vehicle_involved','location_type2','speed_limit_posted','traffic_control_damage_notify_date','traffic_control_damage_notify_time','traffic_control_damage_notify_name','public_property_damaged','replacement_report','deleted_report','next_street_prefix','violator_name','type_hazardous','type_other','unit_type_and_axles1','unit_type_and_axles2','unit_type_and_axles3','unit_type_and_axles4','incident_damage_amount','dot_use','number_of_persons_involved','unusual_road_condition_other_description','number_of_narrative_sections','cad_number','visibility','accident_at_intersection','accident_not_at_intersection','first_harmful_event_within_interchange','injury_involved','citation_status','commercial_vehicle','not_in_transport','other_unit_number','other_unit_length','other_unit_axles','other_unit_plate_expiration','other_unit_permanent_registration','other_unit_model_year2','other_unit_make2','other_unit_vin2','other_unit_registration_state2','other_unit_registration_year2','other_unit_license_plate2','other_unit_number2','other_unit_length2','other_unit_axles2','other_unit_plate_expiration2','other_unit_permanent_registration2','other_unit_type2','other_unit_model_year3','other_unit_make3','other_unit_vin3','other_unit_registration_state3','other_unit_registration_year3','other_unit_license_plate3','other_unit_number3','other_unit_length3','other_unit_axles3','other_unit_plate_expiration3','other_unit_permanent_registration3','other_unit_type3','damaged_areas3','driver_distracted_by','non_motorist_type','seating_position_row','seating_position_seat','seating_position_description','transported_id_number','witness_number','date_of_birth_derived','property_damage_id','property_owner_name','damage_description','damage_estimate','narrative','narrative_continuance','hazardous_materials_hazmat_placard_number1','hazardous_materials_hazmat_placard_number2','vendor_code','report_property_damage','report_collision_type','report_first_harmful_event','report_light_condition','report_weather_condition','report_road_condition','report_injury_status','report_damage_extent','report_vehicle_type','report_traffic_control_device_type','report_contributing_circumstances_v','report_vehicle_maneuver_action_prior','report_vehicle_body_type','cru_agency_name','cru_agency_id','cname','name_type','vendor_report_id','is_available_for_public','has_addendum','report_agency_ori','report_status','super_report_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_report_code_pcnt,le.populated_report_category_pcnt,le.populated_report_code_desc_pcnt,le.populated_citation_id_pcnt,le.populated_creation_date_pcnt,le.populated_incident_id_pcnt,le.populated_citation_issued_pcnt,le.populated_citation_number1_pcnt,le.populated_citation_number2_pcnt,le.populated_section_number1_pcnt,le.populated_court_date_pcnt,le.populated_court_time_pcnt,le.populated_citation_detail1_pcnt,le.populated_local_code_pcnt,le.populated_violation_code1_pcnt,le.populated_violation_code2_pcnt,le.populated_multiple_charges_indicator_pcnt,le.populated_dui_indicator_pcnt,le.populated_commercial_id_pcnt,le.populated_vehicle_id_pcnt,le.populated_commercial_info_source_pcnt,le.populated_commercial_vehicle_type_pcnt,le.populated_motor_carrier_id_dot_number_pcnt,le.populated_motor_carrier_id_state_id_pcnt,le.populated_motor_carrier_id_carrier_name_pcnt,le.populated_motor_carrier_id_address_pcnt,le.populated_motor_carrier_id_city_pcnt,le.populated_motor_carrier_id_state_pcnt,le.populated_motor_carrier_id_zipcode_pcnt,le.populated_motor_carrier_id_commercial_indicator_pcnt,le.populated_carrier_id_type_pcnt,le.populated_carrier_unit_number_pcnt,le.populated_dot_permit_number_pcnt,le.populated_iccmc_number_pcnt,le.populated_mcs_vehicle_inspection_pcnt,le.populated_mcs_form_number_pcnt,le.populated_mcs_out_of_service_pcnt,le.populated_mcs_violation_related_pcnt,le.populated_number_of_axles_pcnt,le.populated_number_of_tires_pcnt,le.populated_gvw_over_10k_pounds_pcnt,le.populated_weight_rating_pcnt,le.populated_registered_gross_vehicle_weight_pcnt,le.populated_vehicle_length_feet_pcnt,le.populated_cargo_body_type_pcnt,le.populated_load_type_pcnt,le.populated_oversize_load_pcnt,le.populated_vehicle_configuration_pcnt,le.populated_trailer1_type_pcnt,le.populated_trailer1_length_feet_pcnt,le.populated_trailer1_width_feet_pcnt,le.populated_trailer2_type_pcnt,le.populated_trailer2_length_feet_pcnt,le.populated_trailer2_width_feet_pcnt,le.populated_federally_reportable_pcnt,le.populated_vehicle_inspection_hazmat_pcnt,le.populated_hazmat_form_number_pcnt,le.populated_hazmt_out_of_service_pcnt,le.populated_hazmat_violation_related_pcnt,le.populated_hazardous_materials_placard_pcnt,le.populated_hazardous_materials_class_number1_pcnt,le.populated_hazardous_materials_class_number2_pcnt,le.populated_hazmat_placard_name_pcnt,le.populated_hazardous_materials_released1_pcnt,le.populated_hazardous_materials_released2_pcnt,le.populated_hazardous_materials_released3_pcnt,le.populated_hazardous_materials_released4_pcnt,le.populated_commercial_event1_pcnt,le.populated_commercial_event2_pcnt,le.populated_commercial_event3_pcnt,le.populated_commercial_event4_pcnt,le.populated_recommended_driver_reexam_pcnt,le.populated_transporting_hazmat_pcnt,le.populated_liquid_hazmat_volume_pcnt,le.populated_oversize_vehicle_pcnt,le.populated_overlength_vehicle_pcnt,le.populated_oversize_vehicle_permitted_pcnt,le.populated_overlength_vehicle_permitted_pcnt,le.populated_carrier_phone_number_pcnt,le.populated_commerce_type_pcnt,le.populated_citation_issued_to_vehicle_pcnt,le.populated_cdl_class_pcnt,le.populated_dot_state_pcnt,le.populated_fire_hazardous_materials_involvement_pcnt,le.populated_commercial_event_description_pcnt,le.populated_supplment_required_hazmat_placard_pcnt,le.populated_other_state_number1_pcnt,le.populated_other_state_number2_pcnt,le.populated_work_type_id_pcnt,le.populated_report_id_pcnt,le.populated_agency_id_pcnt,le.populated_sent_to_hpcc_datetime_pcnt,le.populated_corrected_incident_pcnt,le.populated_cru_order_id_pcnt,le.populated_cru_sequence_nbr_pcnt,le.populated_loss_state_abbr_pcnt,le.populated_report_type_id_pcnt,le.populated_hash_key_pcnt,le.populated_case_identifier_pcnt,le.populated_crash_county_pcnt,le.populated_county_cd_pcnt,le.populated_crash_cityplace_pcnt,le.populated_crash_city_pcnt,le.populated_city_code_pcnt,le.populated_first_harmful_event_pcnt,le.populated_first_harmful_event_location_pcnt,le.populated_manner_crash_impact1_pcnt,le.populated_weather_condition1_pcnt,le.populated_weather_condition2_pcnt,le.populated_light_condition1_pcnt,le.populated_light_condition2_pcnt,le.populated_road_surface_condition_pcnt,le.populated_contributing_circumstances_environmental1_pcnt,le.populated_contributing_circumstances_environmental2_pcnt,le.populated_contributing_circumstances_environmental3_pcnt,le.populated_contributing_circumstances_environmental4_pcnt,le.populated_contributing_circumstances_road1_pcnt,le.populated_contributing_circumstances_road2_pcnt,le.populated_contributing_circumstances_road3_pcnt,le.populated_contributing_circumstances_road4_pcnt,le.populated_relation_to_junction_pcnt,le.populated_intersection_type_pcnt,le.populated_school_bus_related_pcnt,le.populated_work_zone_related_pcnt,le.populated_work_zone_location_pcnt,le.populated_work_zone_type_pcnt,le.populated_work_zone_workers_present_pcnt,le.populated_work_zone_law_enforcement_present_pcnt,le.populated_crash_severity_pcnt,le.populated_number_of_vehicles_pcnt,le.populated_total_nonfatal_injuries_pcnt,le.populated_total_fatal_injuries_pcnt,le.populated_day_of_week_pcnt,le.populated_roadway_curvature_pcnt,le.populated_part_of_national_highway_system_pcnt,le.populated_roadway_functional_class_pcnt,le.populated_access_control_pcnt,le.populated_rr_crossing_id_pcnt,le.populated_roadway_lighting_pcnt,le.populated_traffic_control_type_at_intersection1_pcnt,le.populated_traffic_control_type_at_intersection2_pcnt,le.populated_ncic_number_pcnt,le.populated_state_report_number_pcnt,le.populated_ori_number_pcnt,le.populated_crash_date_pcnt,le.populated_crash_time_pcnt,le.populated_lattitude_pcnt,le.populated_longitude_pcnt,le.populated_milepost1_pcnt,le.populated_milepost2_pcnt,le.populated_address_number_pcnt,le.populated_loss_street_pcnt,le.populated_loss_street_route_number_pcnt,le.populated_loss_street_type_pcnt,le.populated_loss_street_speed_limit_pcnt,le.populated_incident_location_indicator_pcnt,le.populated_loss_cross_street_pcnt,le.populated_loss_cross_street_route_number_pcnt,le.populated_loss_cross_street_intersecting_route_segment_pcnt,le.populated_loss_cross_street_type_pcnt,le.populated_loss_cross_street_speed_limit_pcnt,le.populated_loss_cross_street_number_of_lanes_pcnt,le.populated_loss_cross_street_orientation_pcnt,le.populated_loss_cross_street_route_sign_pcnt,le.populated_at_node_number_pcnt,le.populated_distance_from_node_feet_pcnt,le.populated_distance_from_node_miles_pcnt,le.populated_next_node_number_pcnt,le.populated_next_roadway_node_number_pcnt,le.populated_direction_of_travel_pcnt,le.populated_next_street_pcnt,le.populated_next_street_type_pcnt,le.populated_next_street_suffix_pcnt,le.populated_before_or_after_next_street_pcnt,le.populated_next_street_distance_feet_pcnt,le.populated_next_street_distance_miles_pcnt,le.populated_next_street_direction_pcnt,le.populated_next_street_route_segment_pcnt,le.populated_continuing_toward_street_pcnt,le.populated_continuing_street_suffix_pcnt,le.populated_continuing_street_direction_pcnt,le.populated_continuting_street_route_segment_pcnt,le.populated_city_type_pcnt,le.populated_outside_city_indicator_pcnt,le.populated_outside_city_direction_pcnt,le.populated_outside_city_distance_feet_pcnt,le.populated_outside_city_distance_miles_pcnt,le.populated_crash_type_pcnt,le.populated_motor_vehicle_involved_with_pcnt,le.populated_report_investigation_type_pcnt,le.populated_incident_hit_and_run_pcnt,le.populated_tow_away_pcnt,le.populated_date_notified_pcnt,le.populated_time_notified_pcnt,le.populated_notification_method_pcnt,le.populated_officer_arrival_time_pcnt,le.populated_officer_report_date_pcnt,le.populated_officer_report_time_pcnt,le.populated_officer_id_pcnt,le.populated_officer_department_pcnt,le.populated_officer_rank_pcnt,le.populated_officer_command_pcnt,le.populated_officer_tax_id_number_pcnt,le.populated_completed_report_date_pcnt,le.populated_supervisor_check_date_pcnt,le.populated_supervisor_check_time_pcnt,le.populated_supervisor_id_pcnt,le.populated_supervisor_rank_pcnt,le.populated_reviewers_name_pcnt,le.populated_road_surface_pcnt,le.populated_roadway_alignment_pcnt,le.populated_traffic_way_description_pcnt,le.populated_traffic_flow_pcnt,le.populated_property_damage_involved_pcnt,le.populated_property_damage_description1_pcnt,le.populated_property_damage_description2_pcnt,le.populated_property_damage_estimate1_pcnt,le.populated_property_damage_estimate2_pcnt,le.populated_incident_damage_over_limit_pcnt,le.populated_property_owner_notified_pcnt,le.populated_government_property_pcnt,le.populated_accident_condition_pcnt,le.populated_unusual_road_condition1_pcnt,le.populated_unusual_road_condition2_pcnt,le.populated_number_of_lanes_pcnt,le.populated_divided_highway_pcnt,le.populated_most_harmful_event_pcnt,le.populated_second_harmful_event_pcnt,le.populated_ems_notified_date_pcnt,le.populated_ems_arrival_date_pcnt,le.populated_hospital_arrival_date_pcnt,le.populated_injured_taken_by_pcnt,le.populated_injured_taken_to_pcnt,le.populated_incident_transported_for_medical_care_pcnt,le.populated_photographs_taken_pcnt,le.populated_photographed_by_pcnt,le.populated_photographer_id_pcnt,le.populated_photography_agency_name_pcnt,le.populated_agency_name_pcnt,le.populated_judicial_district_pcnt,le.populated_precinct_pcnt,le.populated_beat_pcnt,le.populated_location_type_pcnt,le.populated_shoulder_type_pcnt,le.populated_investigation_complete_pcnt,le.populated_investigation_not_complete_why_pcnt,le.populated_investigating_officer_name_pcnt,le.populated_investigation_notification_issued_pcnt,le.populated_agency_type_pcnt,le.populated_no_injury_tow_involved_pcnt,le.populated_injury_tow_involved_pcnt,le.populated_lars_code1_pcnt,le.populated_lars_code2_pcnt,le.populated_private_property_incident_pcnt,le.populated_accident_involvement_pcnt,le.populated_local_use_pcnt,le.populated_street_prefix_pcnt,le.populated_street_suffix_pcnt,le.populated_toll_road_pcnt,le.populated_street_description_pcnt,le.populated_cross_street_address_number_pcnt,le.populated_cross_street_prefix_pcnt,le.populated_cross_street_suffix_pcnt,le.populated_report_complete_pcnt,le.populated_dispatch_notified_pcnt,le.populated_counter_report_pcnt,le.populated_road_type_pcnt,le.populated_agency_code_pcnt,le.populated_public_property_employee_pcnt,le.populated_bridge_related_pcnt,le.populated_ramp_indicator_pcnt,le.populated_to_or_from_location_pcnt,le.populated_complaint_number_pcnt,le.populated_school_zone_related_pcnt,le.populated_notify_dot_maintenance_pcnt,le.populated_special_location_pcnt,le.populated_route_segment_pcnt,le.populated_route_sign_pcnt,le.populated_route_category_street_pcnt,le.populated_route_category_cross_street_pcnt,le.populated_route_category_next_street_pcnt,le.populated_lane_closed_pcnt,le.populated_lane_closure_direction_pcnt,le.populated_lane_direction_pcnt,le.populated_traffic_detoured_pcnt,le.populated_time_closed_pcnt,le.populated_pedestrian_signals_pcnt,le.populated_work_zone_speed_limit_pcnt,le.populated_work_zone_shoulder_median_pcnt,le.populated_work_zone_intermittent_moving_pcnt,le.populated_work_zone_flagger_control_pcnt,le.populated_special_work_zone_characteristics_pcnt,le.populated_lane_number_pcnt,le.populated_offset_distance_feet_pcnt,le.populated_offset_distance_miles_pcnt,le.populated_offset_direction_pcnt,le.populated_asru_code_pcnt,le.populated_mp_grid_pcnt,le.populated_number_of_qualifying_units_pcnt,le.populated_number_of_hazmat_vehicles_pcnt,le.populated_number_of_buses_involved_pcnt,le.populated_number_taken_to_treatment_pcnt,le.populated_number_vehicles_towed_pcnt,le.populated_vehicle_at_fault_unit_number_pcnt,le.populated_time_officer_cleared_scene_pcnt,le.populated_total_minutes_on_scene_pcnt,le.populated_motorists_report_pcnt,le.populated_fatality_involved_pcnt,le.populated_local_dot_index_number_pcnt,le.populated_dor_number_pcnt,le.populated_hospital_code_pcnt,le.populated_special_jurisdiction_pcnt,le.populated_document_type_pcnt,le.populated_distance_was_measured_pcnt,le.populated_street_orientation_pcnt,le.populated_intersecting_route_segment_pcnt,le.populated_primary_fault_indicator_pcnt,le.populated_first_harmful_event_pedestrian_pcnt,le.populated_reference_markers_pcnt,le.populated_other_officer_on_scene_pcnt,le.populated_other_officer_badge_number_pcnt,le.populated_supplemental_report_pcnt,le.populated_supplemental_type_pcnt,le.populated_amended_report_pcnt,le.populated_corrected_report_pcnt,le.populated_state_highway_related_pcnt,le.populated_roadway_lighting_condition_pcnt,le.populated_vendor_reference_number_pcnt,le.populated_duplicate_copy_unit_number_pcnt,le.populated_other_city_agency_description_pcnt,le.populated_notifcation_description_pcnt,le.populated_primary_collision_improper_driving_description_pcnt,le.populated_weather_other_description_pcnt,le.populated_crash_type_description_pcnt,le.populated_motor_vehicle_involved_with_animal_description_pcnt,le.populated_motor_vehicle_involved_with_fixed_object_description_pcnt,le.populated_motor_vehicle_involved_with_other_object_description_pcnt,le.populated_other_investigation_time_pcnt,le.populated_milepost_detail_pcnt,le.populated_utility_pole_number1_pcnt,le.populated_utility_pole_number2_pcnt,le.populated_utility_pole_number3_pcnt,le.populated_person_id_pcnt,le.populated_person_number_pcnt,le.populated_vehicle_unit_number_pcnt,le.populated_sex_pcnt,le.populated_person_type_pcnt,le.populated_injury_status_pcnt,le.populated_occupant_vehicle_unit_number_pcnt,le.populated_seating_position1_pcnt,le.populated_safety_equipment_restraint1_pcnt,le.populated_safety_equipment_restraint2_pcnt,le.populated_safety_equipment_helmet_pcnt,le.populated_air_bag_deployed_pcnt,le.populated_ejection_pcnt,le.populated_drivers_license_jurisdiction_pcnt,le.populated_dl_number_class_pcnt,le.populated_dl_number_cdl_pcnt,le.populated_dl_number_endorsements_pcnt,le.populated_driver_actions_at_time_of_crash1_pcnt,le.populated_driver_actions_at_time_of_crash2_pcnt,le.populated_driver_actions_at_time_of_crash3_pcnt,le.populated_driver_actions_at_time_of_crash4_pcnt,le.populated_violation_codes_pcnt,le.populated_condition_at_time_of_crash1_pcnt,le.populated_condition_at_time_of_crash2_pcnt,le.populated_law_enforcement_suspects_alcohol_use_pcnt,le.populated_alcohol_test_status_pcnt,le.populated_alcohol_test_type_pcnt,le.populated_alcohol_test_result_pcnt,le.populated_law_enforcement_suspects_drug_use_pcnt,le.populated_drug_test_given_pcnt,le.populated_non_motorist_actions_prior_to_crash1_pcnt,le.populated_non_motorist_actions_prior_to_crash2_pcnt,le.populated_non_motorist_actions_at_time_of_crash_pcnt,le.populated_non_motorist_location_at_time_of_crash_pcnt,le.populated_non_motorist_safety_equipment1_pcnt,le.populated_age_pcnt,le.populated_driver_license_restrictions1_pcnt,le.populated_drug_test_type_pcnt,le.populated_drug_test_result1_pcnt,le.populated_drug_test_result2_pcnt,le.populated_drug_test_result3_pcnt,le.populated_drug_test_result4_pcnt,le.populated_injury_area_pcnt,le.populated_injury_description_pcnt,le.populated_motorcyclist_head_injury_pcnt,le.populated_party_id_pcnt,le.populated_same_as_driver_pcnt,le.populated_address_same_as_driver_pcnt,le.populated_last_name_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_name_suffx_pcnt,le.populated_date_of_birth_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_home_phone_pcnt,le.populated_business_phone_pcnt,le.populated_insurance_company_pcnt,le.populated_insurance_company_phone_number_pcnt,le.populated_insurance_policy_number_pcnt,le.populated_insurance_effective_date_pcnt,le.populated_ssn_pcnt,le.populated_drivers_license_number_pcnt,le.populated_drivers_license_expiration_pcnt,le.populated_eye_color_pcnt,le.populated_hair_color_pcnt,le.populated_height_pcnt,le.populated_weight_pcnt,le.populated_race_pcnt,le.populated_pedestrian_cyclist_visibility_pcnt,le.populated_first_aid_by_pcnt,le.populated_person_first_aid_party_type_pcnt,le.populated_person_first_aid_party_type_description_pcnt,le.populated_deceased_at_scene_pcnt,le.populated_death_date_pcnt,le.populated_death_time_pcnt,le.populated_extricated_pcnt,le.populated_alcohol_drug_use_pcnt,le.populated_physical_defects_pcnt,le.populated_driver_residence_pcnt,le.populated_id_type_pcnt,le.populated_proof_of_insurance_pcnt,le.populated_insurance_expired_pcnt,le.populated_insurance_exempt_pcnt,le.populated_insurance_type_pcnt,le.populated_violent_crime_victim_notified_pcnt,le.populated_insurance_company_code_pcnt,le.populated_refused_medical_treatment_pcnt,le.populated_safety_equipment_available_or_used_pcnt,le.populated_apartment_number_pcnt,le.populated_licensed_driver_pcnt,le.populated_physical_emotional_status_pcnt,le.populated_driver_presence_pcnt,le.populated_ejection_path_pcnt,le.populated_state_person_id_pcnt,le.populated_contributed_to_collision_pcnt,le.populated_person_transported_for_medical_care_pcnt,le.populated_transported_by_agency_type_pcnt,le.populated_transported_to_pcnt,le.populated_non_motorist_driver_license_number_pcnt,le.populated_air_bag_type_pcnt,le.populated_cell_phone_use_pcnt,le.populated_driver_license_restriction_compliance_pcnt,le.populated_driver_license_endorsement_compliance_pcnt,le.populated_driver_license_compliance_pcnt,le.populated_contributing_circumstances_p1_pcnt,le.populated_contributing_circumstances_p2_pcnt,le.populated_contributing_circumstances_p3_pcnt,le.populated_contributing_circumstances_p4_pcnt,le.populated_passenger_number_pcnt,le.populated_person_deleted_pcnt,le.populated_owner_lessee_pcnt,le.populated_driver_charged_pcnt,le.populated_motorcycle_eye_protection_pcnt,le.populated_motorcycle_long_sleeves_pcnt,le.populated_motorcycle_long_pants_pcnt,le.populated_motorcycle_over_ankle_boots_pcnt,le.populated_contributing_circumstances_environmental_non_incident1_pcnt,le.populated_contributing_circumstances_environmental_non_incident2_pcnt,le.populated_alcohol_drug_test_given_pcnt,le.populated_alcohol_drug_test_type_pcnt,le.populated_alcohol_drug_test_result_pcnt,le.populated_vin_pcnt,le.populated_vin_status_pcnt,le.populated_damaged_areas_derived1_pcnt,le.populated_damaged_areas_derived2_pcnt,le.populated_airbags_deployed_derived_pcnt,le.populated_vehicle_towed_derived_pcnt,le.populated_unit_type_pcnt,le.populated_unit_number_pcnt,le.populated_registration_state_pcnt,le.populated_registration_year_pcnt,le.populated_license_plate_pcnt,le.populated_make_pcnt,le.populated_model_yr_pcnt,le.populated_model_pcnt,le.populated_body_type_category_pcnt,le.populated_total_occupants_in_vehicle_pcnt,le.populated_special_function_in_transport_pcnt,le.populated_special_function_in_transport_other_unit_pcnt,le.populated_emergency_use_pcnt,le.populated_posted_satutory_speed_limit_pcnt,le.populated_direction_of_travel_before_crash_pcnt,le.populated_trafficway_description_pcnt,le.populated_traffic_control_device_type_pcnt,le.populated_vehicle_maneuver_action_prior1_pcnt,le.populated_vehicle_maneuver_action_prior2_pcnt,le.populated_impact_area1_pcnt,le.populated_impact_area2_pcnt,le.populated_event_sequence1_pcnt,le.populated_event_sequence2_pcnt,le.populated_event_sequence3_pcnt,le.populated_event_sequence4_pcnt,le.populated_most_harmful_event_for_vehicle_pcnt,le.populated_bus_use_pcnt,le.populated_vehicle_hit_and_run_pcnt,le.populated_vehicle_towed_pcnt,le.populated_contributing_circumstances_v1_pcnt,le.populated_contributing_circumstances_v2_pcnt,le.populated_contributing_circumstances_v3_pcnt,le.populated_contributing_circumstances_v4_pcnt,le.populated_on_street_pcnt,le.populated_vehicle_color_pcnt,le.populated_estimated_speed_pcnt,le.populated_accident_investigation_site_pcnt,le.populated_car_fire_pcnt,le.populated_vehicle_damage_amount_pcnt,le.populated_contributing_factors1_pcnt,le.populated_contributing_factors2_pcnt,le.populated_contributing_factors3_pcnt,le.populated_contributing_factors4_pcnt,le.populated_other_contributing_factors1_pcnt,le.populated_other_contributing_factors2_pcnt,le.populated_other_contributing_factors3_pcnt,le.populated_vision_obscured1_pcnt,le.populated_vision_obscured2_pcnt,le.populated_vehicle_on_road_pcnt,le.populated_ran_off_road_pcnt,le.populated_skidding_occurred_pcnt,le.populated_vehicle_incident_location1_pcnt,le.populated_vehicle_incident_location2_pcnt,le.populated_vehicle_incident_location3_pcnt,le.populated_vehicle_disabled_pcnt,le.populated_vehicle_removed_to_pcnt,le.populated_removed_by_pcnt,le.populated_tow_requested_by_driver_pcnt,le.populated_solicitation_pcnt,le.populated_other_unit_vehicle_damage_amount_pcnt,le.populated_other_unit_model_year_pcnt,le.populated_other_unit_make_pcnt,le.populated_other_unit_model_pcnt,le.populated_other_unit_vin_pcnt,le.populated_other_unit_vin_status_pcnt,le.populated_other_unit_body_type_category_pcnt,le.populated_other_unit_registration_state_pcnt,le.populated_other_unit_registration_year_pcnt,le.populated_other_unit_license_plate_pcnt,le.populated_other_unit_color_pcnt,le.populated_other_unit_type_pcnt,le.populated_damaged_areas1_pcnt,le.populated_damaged_areas2_pcnt,le.populated_parked_vehicle_pcnt,le.populated_damage_rating1_pcnt,le.populated_damage_rating2_pcnt,le.populated_vehicle_inventoried_pcnt,le.populated_vehicle_defect_apparent_pcnt,le.populated_defect_may_have_contributed1_pcnt,le.populated_defect_may_have_contributed2_pcnt,le.populated_registration_expiration_pcnt,le.populated_owner_driver_type_pcnt,le.populated_make_code_pcnt,le.populated_number_trailing_units_pcnt,le.populated_vehicle_position_pcnt,le.populated_vehicle_type_pcnt,le.populated_motorcycle_engine_size_pcnt,le.populated_motorcycle_driver_educated_pcnt,le.populated_motorcycle_helmet_type_pcnt,le.populated_motorcycle_passenger_pcnt,le.populated_motorcycle_helmet_stayed_on_pcnt,le.populated_motorcycle_helmet_dot_snell_pcnt,le.populated_motorcycle_saddlebag_trunk_pcnt,le.populated_motorcycle_trailer_pcnt,le.populated_pedacycle_passenger_pcnt,le.populated_pedacycle_headlights_pcnt,le.populated_pedacycle_helmet_pcnt,le.populated_pedacycle_rear_reflectors_pcnt,le.populated_cdl_required_pcnt,le.populated_truck_bus_supplement_required_pcnt,le.populated_unit_damage_amount_pcnt,le.populated_airbag_switch_pcnt,le.populated_underride_override_damage_pcnt,le.populated_vehicle_attachment_pcnt,le.populated_action_on_impact_pcnt,le.populated_speed_detection_method_pcnt,le.populated_non_motorist_direction_of_travel_from_pcnt,le.populated_non_motorist_direction_of_travel_to_pcnt,le.populated_vehicle_use_pcnt,le.populated_department_unit_number_pcnt,le.populated_equipment_in_use_at_time_of_accident_pcnt,le.populated_actions_of_police_vehicle_pcnt,le.populated_vehicle_command_id_pcnt,le.populated_traffic_control_device_inoperative_pcnt,le.populated_direction_of_impact1_pcnt,le.populated_direction_of_impact2_pcnt,le.populated_ran_off_road_direction_pcnt,le.populated_vin_other_unit_number_pcnt,le.populated_damaged_area_generic_pcnt,le.populated_vision_obscured_description_pcnt,le.populated_inattention_description_pcnt,le.populated_contributing_circumstances_defect_description_pcnt,le.populated_contributing_circumstances_other_descriptioin_pcnt,le.populated_vehicle_maneuver_action_prior_other_description_pcnt,le.populated_vehicle_special_use_pcnt,le.populated_vehicle_type_extended1_pcnt,le.populated_vehicle_type_extended2_pcnt,le.populated_fixed_object_direction1_pcnt,le.populated_fixed_object_direction2_pcnt,le.populated_fixed_object_direction3_pcnt,le.populated_fixed_object_direction4_pcnt,le.populated_vehicle_left_at_scene_pcnt,le.populated_vehicle_impounded_pcnt,le.populated_vehicle_driven_from_scene_pcnt,le.populated_on_cross_street_pcnt,le.populated_actions_of_police_vehicle_description_pcnt,le.populated_vehicle_seg_pcnt,le.populated_vehicle_seg_type_pcnt,le.populated_model_year_pcnt,le.populated_body_style_code_pcnt,le.populated_engine_size_pcnt,le.populated_fuel_code_pcnt,le.populated_number_of_driving_wheels_pcnt,le.populated_steering_type_pcnt,le.populated_vina_series_pcnt,le.populated_vina_model_pcnt,le.populated_vina_make_pcnt,le.populated_vina_body_style_pcnt,le.populated_make_description_pcnt,le.populated_model_description_pcnt,le.populated_series_description_pcnt,le.populated_car_cylinders_pcnt,le.populated_other_vehicle_seg_pcnt,le.populated_other_vehicle_seg_type_pcnt,le.populated_other_model_year_pcnt,le.populated_other_body_style_code_pcnt,le.populated_other_engine_size_pcnt,le.populated_other_fuel_code_pcnt,le.populated_other_number_of_driving_wheels_pcnt,le.populated_other_steering_type_pcnt,le.populated_other_vina_series_pcnt,le.populated_other_vina_model_pcnt,le.populated_other_vina_make_pcnt,le.populated_other_vina_body_style_pcnt,le.populated_other_make_description_pcnt,le.populated_other_model_description_pcnt,le.populated_other_series_description_pcnt,le.populated_other_car_cylinders_pcnt,le.populated_report_has_coversheet_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_z5_pcnt,le.populated_z4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_code_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_nametype_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_title2_pcnt,le.populated_fname2_pcnt,le.populated_mname2_pcnt,le.populated_lname2_pcnt,le.populated_suffix2_pcnt,le.populated_name_score_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_rawaid_pcnt,le.populated_law_enforcement_suspects_alcohol_use1_pcnt,le.populated_law_enforcement_suspects_drug_use1_pcnt,le.populated_ems_notified_time_pcnt,le.populated_ems_arrival_time_pcnt,le.populated_avoidance_maneuver2_pcnt,le.populated_avoidance_maneuver3_pcnt,le.populated_avoidance_maneuver4_pcnt,le.populated_damaged_areas_severity1_pcnt,le.populated_damaged_areas_severity2_pcnt,le.populated_vehicle_outside_city_indicator_pcnt,le.populated_vehicle_outside_city_distance_miles_pcnt,le.populated_vehicle_outside_city_direction_pcnt,le.populated_vehicle_crash_cityplace_pcnt,le.populated_insurance_company_standardized_pcnt,le.populated_insurance_expiration_date_pcnt,le.populated_insurance_policy_holder_pcnt,le.populated_is_tag_converted_pcnt,le.populated_vin_original_pcnt,le.populated_make_original_pcnt,le.populated_model_original_pcnt,le.populated_model_year_original_pcnt,le.populated_other_unit_vin_original_pcnt,le.populated_other_unit_make_original_pcnt,le.populated_other_unit_model_original_pcnt,le.populated_other_unit_model_year_original_pcnt,le.populated_source_id_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_mname_pcnt,le.populated_initial_point_of_contact_pcnt,le.populated_vehicle_driveable_pcnt,le.populated_drivers_license_type_pcnt,le.populated_alcohol_test_type_refused_pcnt,le.populated_alcohol_test_type_not_offered_pcnt,le.populated_alcohol_test_type_field_pcnt,le.populated_alcohol_test_type_pbt_pcnt,le.populated_alcohol_test_type_breath_pcnt,le.populated_alcohol_test_type_blood_pcnt,le.populated_alcohol_test_type_urine_pcnt,le.populated_trapped_pcnt,le.populated_dl_number_cdl_endorsements_pcnt,le.populated_dl_number_cdl_restrictions_pcnt,le.populated_dl_number_cdl_exempt_pcnt,le.populated_dl_number_cdl_medical_card_pcnt,le.populated_interlock_device_in_use_pcnt,le.populated_drug_test_type_blood_pcnt,le.populated_drug_test_type_urine_pcnt,le.populated_traffic_control_condition_pcnt,le.populated_intersection_related_pcnt,le.populated_special_study_local_pcnt,le.populated_special_study_state_pcnt,le.populated_off_road_vehicle_involved_pcnt,le.populated_location_type2_pcnt,le.populated_speed_limit_posted_pcnt,le.populated_traffic_control_damage_notify_date_pcnt,le.populated_traffic_control_damage_notify_time_pcnt,le.populated_traffic_control_damage_notify_name_pcnt,le.populated_public_property_damaged_pcnt,le.populated_replacement_report_pcnt,le.populated_deleted_report_pcnt,le.populated_next_street_prefix_pcnt,le.populated_violator_name_pcnt,le.populated_type_hazardous_pcnt,le.populated_type_other_pcnt,le.populated_unit_type_and_axles1_pcnt,le.populated_unit_type_and_axles2_pcnt,le.populated_unit_type_and_axles3_pcnt,le.populated_unit_type_and_axles4_pcnt,le.populated_incident_damage_amount_pcnt,le.populated_dot_use_pcnt,le.populated_number_of_persons_involved_pcnt,le.populated_unusual_road_condition_other_description_pcnt,le.populated_number_of_narrative_sections_pcnt,le.populated_cad_number_pcnt,le.populated_visibility_pcnt,le.populated_accident_at_intersection_pcnt,le.populated_accident_not_at_intersection_pcnt,le.populated_first_harmful_event_within_interchange_pcnt,le.populated_injury_involved_pcnt,le.populated_citation_status_pcnt,le.populated_commercial_vehicle_pcnt,le.populated_not_in_transport_pcnt,le.populated_other_unit_number_pcnt,le.populated_other_unit_length_pcnt,le.populated_other_unit_axles_pcnt,le.populated_other_unit_plate_expiration_pcnt,le.populated_other_unit_permanent_registration_pcnt,le.populated_other_unit_model_year2_pcnt,le.populated_other_unit_make2_pcnt,le.populated_other_unit_vin2_pcnt,le.populated_other_unit_registration_state2_pcnt,le.populated_other_unit_registration_year2_pcnt,le.populated_other_unit_license_plate2_pcnt,le.populated_other_unit_number2_pcnt,le.populated_other_unit_length2_pcnt,le.populated_other_unit_axles2_pcnt,le.populated_other_unit_plate_expiration2_pcnt,le.populated_other_unit_permanent_registration2_pcnt,le.populated_other_unit_type2_pcnt,le.populated_other_unit_model_year3_pcnt,le.populated_other_unit_make3_pcnt,le.populated_other_unit_vin3_pcnt,le.populated_other_unit_registration_state3_pcnt,le.populated_other_unit_registration_year3_pcnt,le.populated_other_unit_license_plate3_pcnt,le.populated_other_unit_number3_pcnt,le.populated_other_unit_length3_pcnt,le.populated_other_unit_axles3_pcnt,le.populated_other_unit_plate_expiration3_pcnt,le.populated_other_unit_permanent_registration3_pcnt,le.populated_other_unit_type3_pcnt,le.populated_damaged_areas3_pcnt,le.populated_driver_distracted_by_pcnt,le.populated_non_motorist_type_pcnt,le.populated_seating_position_row_pcnt,le.populated_seating_position_seat_pcnt,le.populated_seating_position_description_pcnt,le.populated_transported_id_number_pcnt,le.populated_witness_number_pcnt,le.populated_date_of_birth_derived_pcnt,le.populated_property_damage_id_pcnt,le.populated_property_owner_name_pcnt,le.populated_damage_description_pcnt,le.populated_damage_estimate_pcnt,le.populated_narrative_pcnt,le.populated_narrative_continuance_pcnt,le.populated_hazardous_materials_hazmat_placard_number1_pcnt,le.populated_hazardous_materials_hazmat_placard_number2_pcnt,le.populated_vendor_code_pcnt,le.populated_report_property_damage_pcnt,le.populated_report_collision_type_pcnt,le.populated_report_first_harmful_event_pcnt,le.populated_report_light_condition_pcnt,le.populated_report_weather_condition_pcnt,le.populated_report_road_condition_pcnt,le.populated_report_injury_status_pcnt,le.populated_report_damage_extent_pcnt,le.populated_report_vehicle_type_pcnt,le.populated_report_traffic_control_device_type_pcnt,le.populated_report_contributing_circumstances_v_pcnt,le.populated_report_vehicle_maneuver_action_prior_pcnt,le.populated_report_vehicle_body_type_pcnt,le.populated_cru_agency_name_pcnt,le.populated_cru_agency_id_pcnt,le.populated_cname_pcnt,le.populated_name_type_pcnt,le.populated_vendor_report_id_pcnt,le.populated_is_available_for_public_pcnt,le.populated_has_addendum_pcnt,le.populated_report_agency_ori_pcnt,le.populated_report_status_pcnt,le.populated_super_report_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_report_code,le.maxlength_report_category,le.maxlength_report_code_desc,le.maxlength_citation_id,le.maxlength_creation_date,le.maxlength_incident_id,le.maxlength_citation_issued,le.maxlength_citation_number1,le.maxlength_citation_number2,le.maxlength_section_number1,le.maxlength_court_date,le.maxlength_court_time,le.maxlength_citation_detail1,le.maxlength_local_code,le.maxlength_violation_code1,le.maxlength_violation_code2,le.maxlength_multiple_charges_indicator,le.maxlength_dui_indicator,le.maxlength_commercial_id,le.maxlength_vehicle_id,le.maxlength_commercial_info_source,le.maxlength_commercial_vehicle_type,le.maxlength_motor_carrier_id_dot_number,le.maxlength_motor_carrier_id_state_id,le.maxlength_motor_carrier_id_carrier_name,le.maxlength_motor_carrier_id_address,le.maxlength_motor_carrier_id_city,le.maxlength_motor_carrier_id_state,le.maxlength_motor_carrier_id_zipcode,le.maxlength_motor_carrier_id_commercial_indicator,le.maxlength_carrier_id_type,le.maxlength_carrier_unit_number,le.maxlength_dot_permit_number,le.maxlength_iccmc_number,le.maxlength_mcs_vehicle_inspection,le.maxlength_mcs_form_number,le.maxlength_mcs_out_of_service,le.maxlength_mcs_violation_related,le.maxlength_number_of_axles,le.maxlength_number_of_tires,le.maxlength_gvw_over_10k_pounds,le.maxlength_weight_rating,le.maxlength_registered_gross_vehicle_weight,le.maxlength_vehicle_length_feet,le.maxlength_cargo_body_type,le.maxlength_load_type,le.maxlength_oversize_load,le.maxlength_vehicle_configuration,le.maxlength_trailer1_type,le.maxlength_trailer1_length_feet,le.maxlength_trailer1_width_feet,le.maxlength_trailer2_type,le.maxlength_trailer2_length_feet,le.maxlength_trailer2_width_feet,le.maxlength_federally_reportable,le.maxlength_vehicle_inspection_hazmat,le.maxlength_hazmat_form_number,le.maxlength_hazmt_out_of_service,le.maxlength_hazmat_violation_related,le.maxlength_hazardous_materials_placard,le.maxlength_hazardous_materials_class_number1,le.maxlength_hazardous_materials_class_number2,le.maxlength_hazmat_placard_name,le.maxlength_hazardous_materials_released1,le.maxlength_hazardous_materials_released2,le.maxlength_hazardous_materials_released3,le.maxlength_hazardous_materials_released4,le.maxlength_commercial_event1,le.maxlength_commercial_event2,le.maxlength_commercial_event3,le.maxlength_commercial_event4,le.maxlength_recommended_driver_reexam,le.maxlength_transporting_hazmat,le.maxlength_liquid_hazmat_volume,le.maxlength_oversize_vehicle,le.maxlength_overlength_vehicle,le.maxlength_oversize_vehicle_permitted,le.maxlength_overlength_vehicle_permitted,le.maxlength_carrier_phone_number,le.maxlength_commerce_type,le.maxlength_citation_issued_to_vehicle,le.maxlength_cdl_class,le.maxlength_dot_state,le.maxlength_fire_hazardous_materials_involvement,le.maxlength_commercial_event_description,le.maxlength_supplment_required_hazmat_placard,le.maxlength_other_state_number1,le.maxlength_other_state_number2,le.maxlength_work_type_id,le.maxlength_report_id,le.maxlength_agency_id,le.maxlength_sent_to_hpcc_datetime,le.maxlength_corrected_incident,le.maxlength_cru_order_id,le.maxlength_cru_sequence_nbr,le.maxlength_loss_state_abbr,le.maxlength_report_type_id,le.maxlength_hash_key,le.maxlength_case_identifier,le.maxlength_crash_county,le.maxlength_county_cd,le.maxlength_crash_cityplace,le.maxlength_crash_city,le.maxlength_city_code,le.maxlength_first_harmful_event,le.maxlength_first_harmful_event_location,le.maxlength_manner_crash_impact1,le.maxlength_weather_condition1,le.maxlength_weather_condition2,le.maxlength_light_condition1,le.maxlength_light_condition2,le.maxlength_road_surface_condition,le.maxlength_contributing_circumstances_environmental1,le.maxlength_contributing_circumstances_environmental2,le.maxlength_contributing_circumstances_environmental3,le.maxlength_contributing_circumstances_environmental4,le.maxlength_contributing_circumstances_road1,le.maxlength_contributing_circumstances_road2,le.maxlength_contributing_circumstances_road3,le.maxlength_contributing_circumstances_road4,le.maxlength_relation_to_junction,le.maxlength_intersection_type,le.maxlength_school_bus_related,le.maxlength_work_zone_related,le.maxlength_work_zone_location,le.maxlength_work_zone_type,le.maxlength_work_zone_workers_present,le.maxlength_work_zone_law_enforcement_present,le.maxlength_crash_severity,le.maxlength_number_of_vehicles,le.maxlength_total_nonfatal_injuries,le.maxlength_total_fatal_injuries,le.maxlength_day_of_week,le.maxlength_roadway_curvature,le.maxlength_part_of_national_highway_system,le.maxlength_roadway_functional_class,le.maxlength_access_control,le.maxlength_rr_crossing_id,le.maxlength_roadway_lighting,le.maxlength_traffic_control_type_at_intersection1,le.maxlength_traffic_control_type_at_intersection2,le.maxlength_ncic_number,le.maxlength_state_report_number,le.maxlength_ori_number,le.maxlength_crash_date,le.maxlength_crash_time,le.maxlength_lattitude,le.maxlength_longitude,le.maxlength_milepost1,le.maxlength_milepost2,le.maxlength_address_number,le.maxlength_loss_street,le.maxlength_loss_street_route_number,le.maxlength_loss_street_type,le.maxlength_loss_street_speed_limit,le.maxlength_incident_location_indicator,le.maxlength_loss_cross_street,le.maxlength_loss_cross_street_route_number,le.maxlength_loss_cross_street_intersecting_route_segment,le.maxlength_loss_cross_street_type,le.maxlength_loss_cross_street_speed_limit,le.maxlength_loss_cross_street_number_of_lanes,le.maxlength_loss_cross_street_orientation,le.maxlength_loss_cross_street_route_sign,le.maxlength_at_node_number,le.maxlength_distance_from_node_feet,le.maxlength_distance_from_node_miles,le.maxlength_next_node_number,le.maxlength_next_roadway_node_number,le.maxlength_direction_of_travel,le.maxlength_next_street,le.maxlength_next_street_type,le.maxlength_next_street_suffix,le.maxlength_before_or_after_next_street,le.maxlength_next_street_distance_feet,le.maxlength_next_street_distance_miles,le.maxlength_next_street_direction,le.maxlength_next_street_route_segment,le.maxlength_continuing_toward_street,le.maxlength_continuing_street_suffix,le.maxlength_continuing_street_direction,le.maxlength_continuting_street_route_segment,le.maxlength_city_type,le.maxlength_outside_city_indicator,le.maxlength_outside_city_direction,le.maxlength_outside_city_distance_feet,le.maxlength_outside_city_distance_miles,le.maxlength_crash_type,le.maxlength_motor_vehicle_involved_with,le.maxlength_report_investigation_type,le.maxlength_incident_hit_and_run,le.maxlength_tow_away,le.maxlength_date_notified,le.maxlength_time_notified,le.maxlength_notification_method,le.maxlength_officer_arrival_time,le.maxlength_officer_report_date,le.maxlength_officer_report_time,le.maxlength_officer_id,le.maxlength_officer_department,le.maxlength_officer_rank,le.maxlength_officer_command,le.maxlength_officer_tax_id_number,le.maxlength_completed_report_date,le.maxlength_supervisor_check_date,le.maxlength_supervisor_check_time,le.maxlength_supervisor_id,le.maxlength_supervisor_rank,le.maxlength_reviewers_name,le.maxlength_road_surface,le.maxlength_roadway_alignment,le.maxlength_traffic_way_description,le.maxlength_traffic_flow,le.maxlength_property_damage_involved,le.maxlength_property_damage_description1,le.maxlength_property_damage_description2,le.maxlength_property_damage_estimate1,le.maxlength_property_damage_estimate2,le.maxlength_incident_damage_over_limit,le.maxlength_property_owner_notified,le.maxlength_government_property,le.maxlength_accident_condition,le.maxlength_unusual_road_condition1,le.maxlength_unusual_road_condition2,le.maxlength_number_of_lanes,le.maxlength_divided_highway,le.maxlength_most_harmful_event,le.maxlength_second_harmful_event,le.maxlength_ems_notified_date,le.maxlength_ems_arrival_date,le.maxlength_hospital_arrival_date,le.maxlength_injured_taken_by,le.maxlength_injured_taken_to,le.maxlength_incident_transported_for_medical_care,le.maxlength_photographs_taken,le.maxlength_photographed_by,le.maxlength_photographer_id,le.maxlength_photography_agency_name,le.maxlength_agency_name,le.maxlength_judicial_district,le.maxlength_precinct,le.maxlength_beat,le.maxlength_location_type,le.maxlength_shoulder_type,le.maxlength_investigation_complete,le.maxlength_investigation_not_complete_why,le.maxlength_investigating_officer_name,le.maxlength_investigation_notification_issued,le.maxlength_agency_type,le.maxlength_no_injury_tow_involved,le.maxlength_injury_tow_involved,le.maxlength_lars_code1,le.maxlength_lars_code2,le.maxlength_private_property_incident,le.maxlength_accident_involvement,le.maxlength_local_use,le.maxlength_street_prefix,le.maxlength_street_suffix,le.maxlength_toll_road,le.maxlength_street_description,le.maxlength_cross_street_address_number,le.maxlength_cross_street_prefix,le.maxlength_cross_street_suffix,le.maxlength_report_complete,le.maxlength_dispatch_notified,le.maxlength_counter_report,le.maxlength_road_type,le.maxlength_agency_code,le.maxlength_public_property_employee,le.maxlength_bridge_related,le.maxlength_ramp_indicator,le.maxlength_to_or_from_location,le.maxlength_complaint_number,le.maxlength_school_zone_related,le.maxlength_notify_dot_maintenance,le.maxlength_special_location,le.maxlength_route_segment,le.maxlength_route_sign,le.maxlength_route_category_street,le.maxlength_route_category_cross_street,le.maxlength_route_category_next_street,le.maxlength_lane_closed,le.maxlength_lane_closure_direction,le.maxlength_lane_direction,le.maxlength_traffic_detoured,le.maxlength_time_closed,le.maxlength_pedestrian_signals,le.maxlength_work_zone_speed_limit,le.maxlength_work_zone_shoulder_median,le.maxlength_work_zone_intermittent_moving,le.maxlength_work_zone_flagger_control,le.maxlength_special_work_zone_characteristics,le.maxlength_lane_number,le.maxlength_offset_distance_feet,le.maxlength_offset_distance_miles,le.maxlength_offset_direction,le.maxlength_asru_code,le.maxlength_mp_grid,le.maxlength_number_of_qualifying_units,le.maxlength_number_of_hazmat_vehicles,le.maxlength_number_of_buses_involved,le.maxlength_number_taken_to_treatment,le.maxlength_number_vehicles_towed,le.maxlength_vehicle_at_fault_unit_number,le.maxlength_time_officer_cleared_scene,le.maxlength_total_minutes_on_scene,le.maxlength_motorists_report,le.maxlength_fatality_involved,le.maxlength_local_dot_index_number,le.maxlength_dor_number,le.maxlength_hospital_code,le.maxlength_special_jurisdiction,le.maxlength_document_type,le.maxlength_distance_was_measured,le.maxlength_street_orientation,le.maxlength_intersecting_route_segment,le.maxlength_primary_fault_indicator,le.maxlength_first_harmful_event_pedestrian,le.maxlength_reference_markers,le.maxlength_other_officer_on_scene,le.maxlength_other_officer_badge_number,le.maxlength_supplemental_report,le.maxlength_supplemental_type,le.maxlength_amended_report,le.maxlength_corrected_report,le.maxlength_state_highway_related,le.maxlength_roadway_lighting_condition,le.maxlength_vendor_reference_number,le.maxlength_duplicate_copy_unit_number,le.maxlength_other_city_agency_description,le.maxlength_notifcation_description,le.maxlength_primary_collision_improper_driving_description,le.maxlength_weather_other_description,le.maxlength_crash_type_description,le.maxlength_motor_vehicle_involved_with_animal_description,le.maxlength_motor_vehicle_involved_with_fixed_object_description,le.maxlength_motor_vehicle_involved_with_other_object_description,le.maxlength_other_investigation_time,le.maxlength_milepost_detail,le.maxlength_utility_pole_number1,le.maxlength_utility_pole_number2,le.maxlength_utility_pole_number3,le.maxlength_person_id,le.maxlength_person_number,le.maxlength_vehicle_unit_number,le.maxlength_sex,le.maxlength_person_type,le.maxlength_injury_status,le.maxlength_occupant_vehicle_unit_number,le.maxlength_seating_position1,le.maxlength_safety_equipment_restraint1,le.maxlength_safety_equipment_restraint2,le.maxlength_safety_equipment_helmet,le.maxlength_air_bag_deployed,le.maxlength_ejection,le.maxlength_drivers_license_jurisdiction,le.maxlength_dl_number_class,le.maxlength_dl_number_cdl,le.maxlength_dl_number_endorsements,le.maxlength_driver_actions_at_time_of_crash1,le.maxlength_driver_actions_at_time_of_crash2,le.maxlength_driver_actions_at_time_of_crash3,le.maxlength_driver_actions_at_time_of_crash4,le.maxlength_violation_codes,le.maxlength_condition_at_time_of_crash1,le.maxlength_condition_at_time_of_crash2,le.maxlength_law_enforcement_suspects_alcohol_use,le.maxlength_alcohol_test_status,le.maxlength_alcohol_test_type,le.maxlength_alcohol_test_result,le.maxlength_law_enforcement_suspects_drug_use,le.maxlength_drug_test_given,le.maxlength_non_motorist_actions_prior_to_crash1,le.maxlength_non_motorist_actions_prior_to_crash2,le.maxlength_non_motorist_actions_at_time_of_crash,le.maxlength_non_motorist_location_at_time_of_crash,le.maxlength_non_motorist_safety_equipment1,le.maxlength_age,le.maxlength_driver_license_restrictions1,le.maxlength_drug_test_type,le.maxlength_drug_test_result1,le.maxlength_drug_test_result2,le.maxlength_drug_test_result3,le.maxlength_drug_test_result4,le.maxlength_injury_area,le.maxlength_injury_description,le.maxlength_motorcyclist_head_injury,le.maxlength_party_id,le.maxlength_same_as_driver,le.maxlength_address_same_as_driver,le.maxlength_last_name,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_name_suffx,le.maxlength_date_of_birth,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_home_phone,le.maxlength_business_phone,le.maxlength_insurance_company,le.maxlength_insurance_company_phone_number,le.maxlength_insurance_policy_number,le.maxlength_insurance_effective_date,le.maxlength_ssn,le.maxlength_drivers_license_number,le.maxlength_drivers_license_expiration,le.maxlength_eye_color,le.maxlength_hair_color,le.maxlength_height,le.maxlength_weight,le.maxlength_race,le.maxlength_pedestrian_cyclist_visibility,le.maxlength_first_aid_by,le.maxlength_person_first_aid_party_type,le.maxlength_person_first_aid_party_type_description,le.maxlength_deceased_at_scene,le.maxlength_death_date,le.maxlength_death_time,le.maxlength_extricated,le.maxlength_alcohol_drug_use,le.maxlength_physical_defects,le.maxlength_driver_residence,le.maxlength_id_type,le.maxlength_proof_of_insurance,le.maxlength_insurance_expired,le.maxlength_insurance_exempt,le.maxlength_insurance_type,le.maxlength_violent_crime_victim_notified,le.maxlength_insurance_company_code,le.maxlength_refused_medical_treatment,le.maxlength_safety_equipment_available_or_used,le.maxlength_apartment_number,le.maxlength_licensed_driver,le.maxlength_physical_emotional_status,le.maxlength_driver_presence,le.maxlength_ejection_path,le.maxlength_state_person_id,le.maxlength_contributed_to_collision,le.maxlength_person_transported_for_medical_care,le.maxlength_transported_by_agency_type,le.maxlength_transported_to,le.maxlength_non_motorist_driver_license_number,le.maxlength_air_bag_type,le.maxlength_cell_phone_use,le.maxlength_driver_license_restriction_compliance,le.maxlength_driver_license_endorsement_compliance,le.maxlength_driver_license_compliance,le.maxlength_contributing_circumstances_p1,le.maxlength_contributing_circumstances_p2,le.maxlength_contributing_circumstances_p3,le.maxlength_contributing_circumstances_p4,le.maxlength_passenger_number,le.maxlength_person_deleted,le.maxlength_owner_lessee,le.maxlength_driver_charged,le.maxlength_motorcycle_eye_protection,le.maxlength_motorcycle_long_sleeves,le.maxlength_motorcycle_long_pants,le.maxlength_motorcycle_over_ankle_boots,le.maxlength_contributing_circumstances_environmental_non_incident1,le.maxlength_contributing_circumstances_environmental_non_incident2,le.maxlength_alcohol_drug_test_given,le.maxlength_alcohol_drug_test_type,le.maxlength_alcohol_drug_test_result,le.maxlength_vin,le.maxlength_vin_status,le.maxlength_damaged_areas_derived1,le.maxlength_damaged_areas_derived2,le.maxlength_airbags_deployed_derived,le.maxlength_vehicle_towed_derived,le.maxlength_unit_type,le.maxlength_unit_number,le.maxlength_registration_state,le.maxlength_registration_year,le.maxlength_license_plate,le.maxlength_make,le.maxlength_model_yr,le.maxlength_model,le.maxlength_body_type_category,le.maxlength_total_occupants_in_vehicle,le.maxlength_special_function_in_transport,le.maxlength_special_function_in_transport_other_unit,le.maxlength_emergency_use,le.maxlength_posted_satutory_speed_limit,le.maxlength_direction_of_travel_before_crash,le.maxlength_trafficway_description,le.maxlength_traffic_control_device_type,le.maxlength_vehicle_maneuver_action_prior1,le.maxlength_vehicle_maneuver_action_prior2,le.maxlength_impact_area1,le.maxlength_impact_area2,le.maxlength_event_sequence1,le.maxlength_event_sequence2,le.maxlength_event_sequence3,le.maxlength_event_sequence4,le.maxlength_most_harmful_event_for_vehicle,le.maxlength_bus_use,le.maxlength_vehicle_hit_and_run,le.maxlength_vehicle_towed,le.maxlength_contributing_circumstances_v1,le.maxlength_contributing_circumstances_v2,le.maxlength_contributing_circumstances_v3,le.maxlength_contributing_circumstances_v4,le.maxlength_on_street,le.maxlength_vehicle_color,le.maxlength_estimated_speed,le.maxlength_accident_investigation_site,le.maxlength_car_fire,le.maxlength_vehicle_damage_amount,le.maxlength_contributing_factors1,le.maxlength_contributing_factors2,le.maxlength_contributing_factors3,le.maxlength_contributing_factors4,le.maxlength_other_contributing_factors1,le.maxlength_other_contributing_factors2,le.maxlength_other_contributing_factors3,le.maxlength_vision_obscured1,le.maxlength_vision_obscured2,le.maxlength_vehicle_on_road,le.maxlength_ran_off_road,le.maxlength_skidding_occurred,le.maxlength_vehicle_incident_location1,le.maxlength_vehicle_incident_location2,le.maxlength_vehicle_incident_location3,le.maxlength_vehicle_disabled,le.maxlength_vehicle_removed_to,le.maxlength_removed_by,le.maxlength_tow_requested_by_driver,le.maxlength_solicitation,le.maxlength_other_unit_vehicle_damage_amount,le.maxlength_other_unit_model_year,le.maxlength_other_unit_make,le.maxlength_other_unit_model,le.maxlength_other_unit_vin,le.maxlength_other_unit_vin_status,le.maxlength_other_unit_body_type_category,le.maxlength_other_unit_registration_state,le.maxlength_other_unit_registration_year,le.maxlength_other_unit_license_plate,le.maxlength_other_unit_color,le.maxlength_other_unit_type,le.maxlength_damaged_areas1,le.maxlength_damaged_areas2,le.maxlength_parked_vehicle,le.maxlength_damage_rating1,le.maxlength_damage_rating2,le.maxlength_vehicle_inventoried,le.maxlength_vehicle_defect_apparent,le.maxlength_defect_may_have_contributed1,le.maxlength_defect_may_have_contributed2,le.maxlength_registration_expiration,le.maxlength_owner_driver_type,le.maxlength_make_code,le.maxlength_number_trailing_units,le.maxlength_vehicle_position,le.maxlength_vehicle_type,le.maxlength_motorcycle_engine_size,le.maxlength_motorcycle_driver_educated,le.maxlength_motorcycle_helmet_type,le.maxlength_motorcycle_passenger,le.maxlength_motorcycle_helmet_stayed_on,le.maxlength_motorcycle_helmet_dot_snell,le.maxlength_motorcycle_saddlebag_trunk,le.maxlength_motorcycle_trailer,le.maxlength_pedacycle_passenger,le.maxlength_pedacycle_headlights,le.maxlength_pedacycle_helmet,le.maxlength_pedacycle_rear_reflectors,le.maxlength_cdl_required,le.maxlength_truck_bus_supplement_required,le.maxlength_unit_damage_amount,le.maxlength_airbag_switch,le.maxlength_underride_override_damage,le.maxlength_vehicle_attachment,le.maxlength_action_on_impact,le.maxlength_speed_detection_method,le.maxlength_non_motorist_direction_of_travel_from,le.maxlength_non_motorist_direction_of_travel_to,le.maxlength_vehicle_use,le.maxlength_department_unit_number,le.maxlength_equipment_in_use_at_time_of_accident,le.maxlength_actions_of_police_vehicle,le.maxlength_vehicle_command_id,le.maxlength_traffic_control_device_inoperative,le.maxlength_direction_of_impact1,le.maxlength_direction_of_impact2,le.maxlength_ran_off_road_direction,le.maxlength_vin_other_unit_number,le.maxlength_damaged_area_generic,le.maxlength_vision_obscured_description,le.maxlength_inattention_description,le.maxlength_contributing_circumstances_defect_description,le.maxlength_contributing_circumstances_other_descriptioin,le.maxlength_vehicle_maneuver_action_prior_other_description,le.maxlength_vehicle_special_use,le.maxlength_vehicle_type_extended1,le.maxlength_vehicle_type_extended2,le.maxlength_fixed_object_direction1,le.maxlength_fixed_object_direction2,le.maxlength_fixed_object_direction3,le.maxlength_fixed_object_direction4,le.maxlength_vehicle_left_at_scene,le.maxlength_vehicle_impounded,le.maxlength_vehicle_driven_from_scene,le.maxlength_on_cross_street,le.maxlength_actions_of_police_vehicle_description,le.maxlength_vehicle_seg,le.maxlength_vehicle_seg_type,le.maxlength_model_year,le.maxlength_body_style_code,le.maxlength_engine_size,le.maxlength_fuel_code,le.maxlength_number_of_driving_wheels,le.maxlength_steering_type,le.maxlength_vina_series,le.maxlength_vina_model,le.maxlength_vina_make,le.maxlength_vina_body_style,le.maxlength_make_description,le.maxlength_model_description,le.maxlength_series_description,le.maxlength_car_cylinders,le.maxlength_other_vehicle_seg,le.maxlength_other_vehicle_seg_type,le.maxlength_other_model_year,le.maxlength_other_body_style_code,le.maxlength_other_engine_size,le.maxlength_other_fuel_code,le.maxlength_other_number_of_driving_wheels,le.maxlength_other_steering_type,le.maxlength_other_vina_series,le.maxlength_other_vina_model,le.maxlength_other_vina_make,le.maxlength_other_vina_body_style,le.maxlength_other_make_description,le.maxlength_other_model_description,le.maxlength_other_series_description,le.maxlength_other_car_cylinders,le.maxlength_report_has_coversheet,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_z5,le.maxlength_z4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county_code,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_nametype,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_title2,le.maxlength_fname2,le.maxlength_mname2,le.maxlength_lname2,le.maxlength_suffix2,le.maxlength_name_score,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_rawaid,le.maxlength_law_enforcement_suspects_alcohol_use1,le.maxlength_law_enforcement_suspects_drug_use1,le.maxlength_ems_notified_time,le.maxlength_ems_arrival_time,le.maxlength_avoidance_maneuver2,le.maxlength_avoidance_maneuver3,le.maxlength_avoidance_maneuver4,le.maxlength_damaged_areas_severity1,le.maxlength_damaged_areas_severity2,le.maxlength_vehicle_outside_city_indicator,le.maxlength_vehicle_outside_city_distance_miles,le.maxlength_vehicle_outside_city_direction,le.maxlength_vehicle_crash_cityplace,le.maxlength_insurance_company_standardized,le.maxlength_insurance_expiration_date,le.maxlength_insurance_policy_holder,le.maxlength_is_tag_converted,le.maxlength_vin_original,le.maxlength_make_original,le.maxlength_model_original,le.maxlength_model_year_original,le.maxlength_other_unit_vin_original,le.maxlength_other_unit_make_original,le.maxlength_other_unit_model_original,le.maxlength_other_unit_model_year_original,le.maxlength_source_id,le.maxlength_orig_fname,le.maxlength_orig_lname,le.maxlength_orig_mname,le.maxlength_initial_point_of_contact,le.maxlength_vehicle_driveable,le.maxlength_drivers_license_type,le.maxlength_alcohol_test_type_refused,le.maxlength_alcohol_test_type_not_offered,le.maxlength_alcohol_test_type_field,le.maxlength_alcohol_test_type_pbt,le.maxlength_alcohol_test_type_breath,le.maxlength_alcohol_test_type_blood,le.maxlength_alcohol_test_type_urine,le.maxlength_trapped,le.maxlength_dl_number_cdl_endorsements,le.maxlength_dl_number_cdl_restrictions,le.maxlength_dl_number_cdl_exempt,le.maxlength_dl_number_cdl_medical_card,le.maxlength_interlock_device_in_use,le.maxlength_drug_test_type_blood,le.maxlength_drug_test_type_urine,le.maxlength_traffic_control_condition,le.maxlength_intersection_related,le.maxlength_special_study_local,le.maxlength_special_study_state,le.maxlength_off_road_vehicle_involved,le.maxlength_location_type2,le.maxlength_speed_limit_posted,le.maxlength_traffic_control_damage_notify_date,le.maxlength_traffic_control_damage_notify_time,le.maxlength_traffic_control_damage_notify_name,le.maxlength_public_property_damaged,le.maxlength_replacement_report,le.maxlength_deleted_report,le.maxlength_next_street_prefix,le.maxlength_violator_name,le.maxlength_type_hazardous,le.maxlength_type_other,le.maxlength_unit_type_and_axles1,le.maxlength_unit_type_and_axles2,le.maxlength_unit_type_and_axles3,le.maxlength_unit_type_and_axles4,le.maxlength_incident_damage_amount,le.maxlength_dot_use,le.maxlength_number_of_persons_involved,le.maxlength_unusual_road_condition_other_description,le.maxlength_number_of_narrative_sections,le.maxlength_cad_number,le.maxlength_visibility,le.maxlength_accident_at_intersection,le.maxlength_accident_not_at_intersection,le.maxlength_first_harmful_event_within_interchange,le.maxlength_injury_involved,le.maxlength_citation_status,le.maxlength_commercial_vehicle,le.maxlength_not_in_transport,le.maxlength_other_unit_number,le.maxlength_other_unit_length,le.maxlength_other_unit_axles,le.maxlength_other_unit_plate_expiration,le.maxlength_other_unit_permanent_registration,le.maxlength_other_unit_model_year2,le.maxlength_other_unit_make2,le.maxlength_other_unit_vin2,le.maxlength_other_unit_registration_state2,le.maxlength_other_unit_registration_year2,le.maxlength_other_unit_license_plate2,le.maxlength_other_unit_number2,le.maxlength_other_unit_length2,le.maxlength_other_unit_axles2,le.maxlength_other_unit_plate_expiration2,le.maxlength_other_unit_permanent_registration2,le.maxlength_other_unit_type2,le.maxlength_other_unit_model_year3,le.maxlength_other_unit_make3,le.maxlength_other_unit_vin3,le.maxlength_other_unit_registration_state3,le.maxlength_other_unit_registration_year3,le.maxlength_other_unit_license_plate3,le.maxlength_other_unit_number3,le.maxlength_other_unit_length3,le.maxlength_other_unit_axles3,le.maxlength_other_unit_plate_expiration3,le.maxlength_other_unit_permanent_registration3,le.maxlength_other_unit_type3,le.maxlength_damaged_areas3,le.maxlength_driver_distracted_by,le.maxlength_non_motorist_type,le.maxlength_seating_position_row,le.maxlength_seating_position_seat,le.maxlength_seating_position_description,le.maxlength_transported_id_number,le.maxlength_witness_number,le.maxlength_date_of_birth_derived,le.maxlength_property_damage_id,le.maxlength_property_owner_name,le.maxlength_damage_description,le.maxlength_damage_estimate,le.maxlength_narrative,le.maxlength_narrative_continuance,le.maxlength_hazardous_materials_hazmat_placard_number1,le.maxlength_hazardous_materials_hazmat_placard_number2,le.maxlength_vendor_code,le.maxlength_report_property_damage,le.maxlength_report_collision_type,le.maxlength_report_first_harmful_event,le.maxlength_report_light_condition,le.maxlength_report_weather_condition,le.maxlength_report_road_condition,le.maxlength_report_injury_status,le.maxlength_report_damage_extent,le.maxlength_report_vehicle_type,le.maxlength_report_traffic_control_device_type,le.maxlength_report_contributing_circumstances_v,le.maxlength_report_vehicle_maneuver_action_prior,le.maxlength_report_vehicle_body_type,le.maxlength_cru_agency_name,le.maxlength_cru_agency_id,le.maxlength_cname,le.maxlength_name_type,le.maxlength_vendor_report_id,le.maxlength_is_available_for_public,le.maxlength_has_addendum,le.maxlength_report_agency_ori,le.maxlength_report_status,le.maxlength_super_report_id);
  SELF.avelength := CHOOSE(C,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_report_code,le.avelength_report_category,le.avelength_report_code_desc,le.avelength_citation_id,le.avelength_creation_date,le.avelength_incident_id,le.avelength_citation_issued,le.avelength_citation_number1,le.avelength_citation_number2,le.avelength_section_number1,le.avelength_court_date,le.avelength_court_time,le.avelength_citation_detail1,le.avelength_local_code,le.avelength_violation_code1,le.avelength_violation_code2,le.avelength_multiple_charges_indicator,le.avelength_dui_indicator,le.avelength_commercial_id,le.avelength_vehicle_id,le.avelength_commercial_info_source,le.avelength_commercial_vehicle_type,le.avelength_motor_carrier_id_dot_number,le.avelength_motor_carrier_id_state_id,le.avelength_motor_carrier_id_carrier_name,le.avelength_motor_carrier_id_address,le.avelength_motor_carrier_id_city,le.avelength_motor_carrier_id_state,le.avelength_motor_carrier_id_zipcode,le.avelength_motor_carrier_id_commercial_indicator,le.avelength_carrier_id_type,le.avelength_carrier_unit_number,le.avelength_dot_permit_number,le.avelength_iccmc_number,le.avelength_mcs_vehicle_inspection,le.avelength_mcs_form_number,le.avelength_mcs_out_of_service,le.avelength_mcs_violation_related,le.avelength_number_of_axles,le.avelength_number_of_tires,le.avelength_gvw_over_10k_pounds,le.avelength_weight_rating,le.avelength_registered_gross_vehicle_weight,le.avelength_vehicle_length_feet,le.avelength_cargo_body_type,le.avelength_load_type,le.avelength_oversize_load,le.avelength_vehicle_configuration,le.avelength_trailer1_type,le.avelength_trailer1_length_feet,le.avelength_trailer1_width_feet,le.avelength_trailer2_type,le.avelength_trailer2_length_feet,le.avelength_trailer2_width_feet,le.avelength_federally_reportable,le.avelength_vehicle_inspection_hazmat,le.avelength_hazmat_form_number,le.avelength_hazmt_out_of_service,le.avelength_hazmat_violation_related,le.avelength_hazardous_materials_placard,le.avelength_hazardous_materials_class_number1,le.avelength_hazardous_materials_class_number2,le.avelength_hazmat_placard_name,le.avelength_hazardous_materials_released1,le.avelength_hazardous_materials_released2,le.avelength_hazardous_materials_released3,le.avelength_hazardous_materials_released4,le.avelength_commercial_event1,le.avelength_commercial_event2,le.avelength_commercial_event3,le.avelength_commercial_event4,le.avelength_recommended_driver_reexam,le.avelength_transporting_hazmat,le.avelength_liquid_hazmat_volume,le.avelength_oversize_vehicle,le.avelength_overlength_vehicle,le.avelength_oversize_vehicle_permitted,le.avelength_overlength_vehicle_permitted,le.avelength_carrier_phone_number,le.avelength_commerce_type,le.avelength_citation_issued_to_vehicle,le.avelength_cdl_class,le.avelength_dot_state,le.avelength_fire_hazardous_materials_involvement,le.avelength_commercial_event_description,le.avelength_supplment_required_hazmat_placard,le.avelength_other_state_number1,le.avelength_other_state_number2,le.avelength_work_type_id,le.avelength_report_id,le.avelength_agency_id,le.avelength_sent_to_hpcc_datetime,le.avelength_corrected_incident,le.avelength_cru_order_id,le.avelength_cru_sequence_nbr,le.avelength_loss_state_abbr,le.avelength_report_type_id,le.avelength_hash_key,le.avelength_case_identifier,le.avelength_crash_county,le.avelength_county_cd,le.avelength_crash_cityplace,le.avelength_crash_city,le.avelength_city_code,le.avelength_first_harmful_event,le.avelength_first_harmful_event_location,le.avelength_manner_crash_impact1,le.avelength_weather_condition1,le.avelength_weather_condition2,le.avelength_light_condition1,le.avelength_light_condition2,le.avelength_road_surface_condition,le.avelength_contributing_circumstances_environmental1,le.avelength_contributing_circumstances_environmental2,le.avelength_contributing_circumstances_environmental3,le.avelength_contributing_circumstances_environmental4,le.avelength_contributing_circumstances_road1,le.avelength_contributing_circumstances_road2,le.avelength_contributing_circumstances_road3,le.avelength_contributing_circumstances_road4,le.avelength_relation_to_junction,le.avelength_intersection_type,le.avelength_school_bus_related,le.avelength_work_zone_related,le.avelength_work_zone_location,le.avelength_work_zone_type,le.avelength_work_zone_workers_present,le.avelength_work_zone_law_enforcement_present,le.avelength_crash_severity,le.avelength_number_of_vehicles,le.avelength_total_nonfatal_injuries,le.avelength_total_fatal_injuries,le.avelength_day_of_week,le.avelength_roadway_curvature,le.avelength_part_of_national_highway_system,le.avelength_roadway_functional_class,le.avelength_access_control,le.avelength_rr_crossing_id,le.avelength_roadway_lighting,le.avelength_traffic_control_type_at_intersection1,le.avelength_traffic_control_type_at_intersection2,le.avelength_ncic_number,le.avelength_state_report_number,le.avelength_ori_number,le.avelength_crash_date,le.avelength_crash_time,le.avelength_lattitude,le.avelength_longitude,le.avelength_milepost1,le.avelength_milepost2,le.avelength_address_number,le.avelength_loss_street,le.avelength_loss_street_route_number,le.avelength_loss_street_type,le.avelength_loss_street_speed_limit,le.avelength_incident_location_indicator,le.avelength_loss_cross_street,le.avelength_loss_cross_street_route_number,le.avelength_loss_cross_street_intersecting_route_segment,le.avelength_loss_cross_street_type,le.avelength_loss_cross_street_speed_limit,le.avelength_loss_cross_street_number_of_lanes,le.avelength_loss_cross_street_orientation,le.avelength_loss_cross_street_route_sign,le.avelength_at_node_number,le.avelength_distance_from_node_feet,le.avelength_distance_from_node_miles,le.avelength_next_node_number,le.avelength_next_roadway_node_number,le.avelength_direction_of_travel,le.avelength_next_street,le.avelength_next_street_type,le.avelength_next_street_suffix,le.avelength_before_or_after_next_street,le.avelength_next_street_distance_feet,le.avelength_next_street_distance_miles,le.avelength_next_street_direction,le.avelength_next_street_route_segment,le.avelength_continuing_toward_street,le.avelength_continuing_street_suffix,le.avelength_continuing_street_direction,le.avelength_continuting_street_route_segment,le.avelength_city_type,le.avelength_outside_city_indicator,le.avelength_outside_city_direction,le.avelength_outside_city_distance_feet,le.avelength_outside_city_distance_miles,le.avelength_crash_type,le.avelength_motor_vehicle_involved_with,le.avelength_report_investigation_type,le.avelength_incident_hit_and_run,le.avelength_tow_away,le.avelength_date_notified,le.avelength_time_notified,le.avelength_notification_method,le.avelength_officer_arrival_time,le.avelength_officer_report_date,le.avelength_officer_report_time,le.avelength_officer_id,le.avelength_officer_department,le.avelength_officer_rank,le.avelength_officer_command,le.avelength_officer_tax_id_number,le.avelength_completed_report_date,le.avelength_supervisor_check_date,le.avelength_supervisor_check_time,le.avelength_supervisor_id,le.avelength_supervisor_rank,le.avelength_reviewers_name,le.avelength_road_surface,le.avelength_roadway_alignment,le.avelength_traffic_way_description,le.avelength_traffic_flow,le.avelength_property_damage_involved,le.avelength_property_damage_description1,le.avelength_property_damage_description2,le.avelength_property_damage_estimate1,le.avelength_property_damage_estimate2,le.avelength_incident_damage_over_limit,le.avelength_property_owner_notified,le.avelength_government_property,le.avelength_accident_condition,le.avelength_unusual_road_condition1,le.avelength_unusual_road_condition2,le.avelength_number_of_lanes,le.avelength_divided_highway,le.avelength_most_harmful_event,le.avelength_second_harmful_event,le.avelength_ems_notified_date,le.avelength_ems_arrival_date,le.avelength_hospital_arrival_date,le.avelength_injured_taken_by,le.avelength_injured_taken_to,le.avelength_incident_transported_for_medical_care,le.avelength_photographs_taken,le.avelength_photographed_by,le.avelength_photographer_id,le.avelength_photography_agency_name,le.avelength_agency_name,le.avelength_judicial_district,le.avelength_precinct,le.avelength_beat,le.avelength_location_type,le.avelength_shoulder_type,le.avelength_investigation_complete,le.avelength_investigation_not_complete_why,le.avelength_investigating_officer_name,le.avelength_investigation_notification_issued,le.avelength_agency_type,le.avelength_no_injury_tow_involved,le.avelength_injury_tow_involved,le.avelength_lars_code1,le.avelength_lars_code2,le.avelength_private_property_incident,le.avelength_accident_involvement,le.avelength_local_use,le.avelength_street_prefix,le.avelength_street_suffix,le.avelength_toll_road,le.avelength_street_description,le.avelength_cross_street_address_number,le.avelength_cross_street_prefix,le.avelength_cross_street_suffix,le.avelength_report_complete,le.avelength_dispatch_notified,le.avelength_counter_report,le.avelength_road_type,le.avelength_agency_code,le.avelength_public_property_employee,le.avelength_bridge_related,le.avelength_ramp_indicator,le.avelength_to_or_from_location,le.avelength_complaint_number,le.avelength_school_zone_related,le.avelength_notify_dot_maintenance,le.avelength_special_location,le.avelength_route_segment,le.avelength_route_sign,le.avelength_route_category_street,le.avelength_route_category_cross_street,le.avelength_route_category_next_street,le.avelength_lane_closed,le.avelength_lane_closure_direction,le.avelength_lane_direction,le.avelength_traffic_detoured,le.avelength_time_closed,le.avelength_pedestrian_signals,le.avelength_work_zone_speed_limit,le.avelength_work_zone_shoulder_median,le.avelength_work_zone_intermittent_moving,le.avelength_work_zone_flagger_control,le.avelength_special_work_zone_characteristics,le.avelength_lane_number,le.avelength_offset_distance_feet,le.avelength_offset_distance_miles,le.avelength_offset_direction,le.avelength_asru_code,le.avelength_mp_grid,le.avelength_number_of_qualifying_units,le.avelength_number_of_hazmat_vehicles,le.avelength_number_of_buses_involved,le.avelength_number_taken_to_treatment,le.avelength_number_vehicles_towed,le.avelength_vehicle_at_fault_unit_number,le.avelength_time_officer_cleared_scene,le.avelength_total_minutes_on_scene,le.avelength_motorists_report,le.avelength_fatality_involved,le.avelength_local_dot_index_number,le.avelength_dor_number,le.avelength_hospital_code,le.avelength_special_jurisdiction,le.avelength_document_type,le.avelength_distance_was_measured,le.avelength_street_orientation,le.avelength_intersecting_route_segment,le.avelength_primary_fault_indicator,le.avelength_first_harmful_event_pedestrian,le.avelength_reference_markers,le.avelength_other_officer_on_scene,le.avelength_other_officer_badge_number,le.avelength_supplemental_report,le.avelength_supplemental_type,le.avelength_amended_report,le.avelength_corrected_report,le.avelength_state_highway_related,le.avelength_roadway_lighting_condition,le.avelength_vendor_reference_number,le.avelength_duplicate_copy_unit_number,le.avelength_other_city_agency_description,le.avelength_notifcation_description,le.avelength_primary_collision_improper_driving_description,le.avelength_weather_other_description,le.avelength_crash_type_description,le.avelength_motor_vehicle_involved_with_animal_description,le.avelength_motor_vehicle_involved_with_fixed_object_description,le.avelength_motor_vehicle_involved_with_other_object_description,le.avelength_other_investigation_time,le.avelength_milepost_detail,le.avelength_utility_pole_number1,le.avelength_utility_pole_number2,le.avelength_utility_pole_number3,le.avelength_person_id,le.avelength_person_number,le.avelength_vehicle_unit_number,le.avelength_sex,le.avelength_person_type,le.avelength_injury_status,le.avelength_occupant_vehicle_unit_number,le.avelength_seating_position1,le.avelength_safety_equipment_restraint1,le.avelength_safety_equipment_restraint2,le.avelength_safety_equipment_helmet,le.avelength_air_bag_deployed,le.avelength_ejection,le.avelength_drivers_license_jurisdiction,le.avelength_dl_number_class,le.avelength_dl_number_cdl,le.avelength_dl_number_endorsements,le.avelength_driver_actions_at_time_of_crash1,le.avelength_driver_actions_at_time_of_crash2,le.avelength_driver_actions_at_time_of_crash3,le.avelength_driver_actions_at_time_of_crash4,le.avelength_violation_codes,le.avelength_condition_at_time_of_crash1,le.avelength_condition_at_time_of_crash2,le.avelength_law_enforcement_suspects_alcohol_use,le.avelength_alcohol_test_status,le.avelength_alcohol_test_type,le.avelength_alcohol_test_result,le.avelength_law_enforcement_suspects_drug_use,le.avelength_drug_test_given,le.avelength_non_motorist_actions_prior_to_crash1,le.avelength_non_motorist_actions_prior_to_crash2,le.avelength_non_motorist_actions_at_time_of_crash,le.avelength_non_motorist_location_at_time_of_crash,le.avelength_non_motorist_safety_equipment1,le.avelength_age,le.avelength_driver_license_restrictions1,le.avelength_drug_test_type,le.avelength_drug_test_result1,le.avelength_drug_test_result2,le.avelength_drug_test_result3,le.avelength_drug_test_result4,le.avelength_injury_area,le.avelength_injury_description,le.avelength_motorcyclist_head_injury,le.avelength_party_id,le.avelength_same_as_driver,le.avelength_address_same_as_driver,le.avelength_last_name,le.avelength_first_name,le.avelength_middle_name,le.avelength_name_suffx,le.avelength_date_of_birth,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_home_phone,le.avelength_business_phone,le.avelength_insurance_company,le.avelength_insurance_company_phone_number,le.avelength_insurance_policy_number,le.avelength_insurance_effective_date,le.avelength_ssn,le.avelength_drivers_license_number,le.avelength_drivers_license_expiration,le.avelength_eye_color,le.avelength_hair_color,le.avelength_height,le.avelength_weight,le.avelength_race,le.avelength_pedestrian_cyclist_visibility,le.avelength_first_aid_by,le.avelength_person_first_aid_party_type,le.avelength_person_first_aid_party_type_description,le.avelength_deceased_at_scene,le.avelength_death_date,le.avelength_death_time,le.avelength_extricated,le.avelength_alcohol_drug_use,le.avelength_physical_defects,le.avelength_driver_residence,le.avelength_id_type,le.avelength_proof_of_insurance,le.avelength_insurance_expired,le.avelength_insurance_exempt,le.avelength_insurance_type,le.avelength_violent_crime_victim_notified,le.avelength_insurance_company_code,le.avelength_refused_medical_treatment,le.avelength_safety_equipment_available_or_used,le.avelength_apartment_number,le.avelength_licensed_driver,le.avelength_physical_emotional_status,le.avelength_driver_presence,le.avelength_ejection_path,le.avelength_state_person_id,le.avelength_contributed_to_collision,le.avelength_person_transported_for_medical_care,le.avelength_transported_by_agency_type,le.avelength_transported_to,le.avelength_non_motorist_driver_license_number,le.avelength_air_bag_type,le.avelength_cell_phone_use,le.avelength_driver_license_restriction_compliance,le.avelength_driver_license_endorsement_compliance,le.avelength_driver_license_compliance,le.avelength_contributing_circumstances_p1,le.avelength_contributing_circumstances_p2,le.avelength_contributing_circumstances_p3,le.avelength_contributing_circumstances_p4,le.avelength_passenger_number,le.avelength_person_deleted,le.avelength_owner_lessee,le.avelength_driver_charged,le.avelength_motorcycle_eye_protection,le.avelength_motorcycle_long_sleeves,le.avelength_motorcycle_long_pants,le.avelength_motorcycle_over_ankle_boots,le.avelength_contributing_circumstances_environmental_non_incident1,le.avelength_contributing_circumstances_environmental_non_incident2,le.avelength_alcohol_drug_test_given,le.avelength_alcohol_drug_test_type,le.avelength_alcohol_drug_test_result,le.avelength_vin,le.avelength_vin_status,le.avelength_damaged_areas_derived1,le.avelength_damaged_areas_derived2,le.avelength_airbags_deployed_derived,le.avelength_vehicle_towed_derived,le.avelength_unit_type,le.avelength_unit_number,le.avelength_registration_state,le.avelength_registration_year,le.avelength_license_plate,le.avelength_make,le.avelength_model_yr,le.avelength_model,le.avelength_body_type_category,le.avelength_total_occupants_in_vehicle,le.avelength_special_function_in_transport,le.avelength_special_function_in_transport_other_unit,le.avelength_emergency_use,le.avelength_posted_satutory_speed_limit,le.avelength_direction_of_travel_before_crash,le.avelength_trafficway_description,le.avelength_traffic_control_device_type,le.avelength_vehicle_maneuver_action_prior1,le.avelength_vehicle_maneuver_action_prior2,le.avelength_impact_area1,le.avelength_impact_area2,le.avelength_event_sequence1,le.avelength_event_sequence2,le.avelength_event_sequence3,le.avelength_event_sequence4,le.avelength_most_harmful_event_for_vehicle,le.avelength_bus_use,le.avelength_vehicle_hit_and_run,le.avelength_vehicle_towed,le.avelength_contributing_circumstances_v1,le.avelength_contributing_circumstances_v2,le.avelength_contributing_circumstances_v3,le.avelength_contributing_circumstances_v4,le.avelength_on_street,le.avelength_vehicle_color,le.avelength_estimated_speed,le.avelength_accident_investigation_site,le.avelength_car_fire,le.avelength_vehicle_damage_amount,le.avelength_contributing_factors1,le.avelength_contributing_factors2,le.avelength_contributing_factors3,le.avelength_contributing_factors4,le.avelength_other_contributing_factors1,le.avelength_other_contributing_factors2,le.avelength_other_contributing_factors3,le.avelength_vision_obscured1,le.avelength_vision_obscured2,le.avelength_vehicle_on_road,le.avelength_ran_off_road,le.avelength_skidding_occurred,le.avelength_vehicle_incident_location1,le.avelength_vehicle_incident_location2,le.avelength_vehicle_incident_location3,le.avelength_vehicle_disabled,le.avelength_vehicle_removed_to,le.avelength_removed_by,le.avelength_tow_requested_by_driver,le.avelength_solicitation,le.avelength_other_unit_vehicle_damage_amount,le.avelength_other_unit_model_year,le.avelength_other_unit_make,le.avelength_other_unit_model,le.avelength_other_unit_vin,le.avelength_other_unit_vin_status,le.avelength_other_unit_body_type_category,le.avelength_other_unit_registration_state,le.avelength_other_unit_registration_year,le.avelength_other_unit_license_plate,le.avelength_other_unit_color,le.avelength_other_unit_type,le.avelength_damaged_areas1,le.avelength_damaged_areas2,le.avelength_parked_vehicle,le.avelength_damage_rating1,le.avelength_damage_rating2,le.avelength_vehicle_inventoried,le.avelength_vehicle_defect_apparent,le.avelength_defect_may_have_contributed1,le.avelength_defect_may_have_contributed2,le.avelength_registration_expiration,le.avelength_owner_driver_type,le.avelength_make_code,le.avelength_number_trailing_units,le.avelength_vehicle_position,le.avelength_vehicle_type,le.avelength_motorcycle_engine_size,le.avelength_motorcycle_driver_educated,le.avelength_motorcycle_helmet_type,le.avelength_motorcycle_passenger,le.avelength_motorcycle_helmet_stayed_on,le.avelength_motorcycle_helmet_dot_snell,le.avelength_motorcycle_saddlebag_trunk,le.avelength_motorcycle_trailer,le.avelength_pedacycle_passenger,le.avelength_pedacycle_headlights,le.avelength_pedacycle_helmet,le.avelength_pedacycle_rear_reflectors,le.avelength_cdl_required,le.avelength_truck_bus_supplement_required,le.avelength_unit_damage_amount,le.avelength_airbag_switch,le.avelength_underride_override_damage,le.avelength_vehicle_attachment,le.avelength_action_on_impact,le.avelength_speed_detection_method,le.avelength_non_motorist_direction_of_travel_from,le.avelength_non_motorist_direction_of_travel_to,le.avelength_vehicle_use,le.avelength_department_unit_number,le.avelength_equipment_in_use_at_time_of_accident,le.avelength_actions_of_police_vehicle,le.avelength_vehicle_command_id,le.avelength_traffic_control_device_inoperative,le.avelength_direction_of_impact1,le.avelength_direction_of_impact2,le.avelength_ran_off_road_direction,le.avelength_vin_other_unit_number,le.avelength_damaged_area_generic,le.avelength_vision_obscured_description,le.avelength_inattention_description,le.avelength_contributing_circumstances_defect_description,le.avelength_contributing_circumstances_other_descriptioin,le.avelength_vehicle_maneuver_action_prior_other_description,le.avelength_vehicle_special_use,le.avelength_vehicle_type_extended1,le.avelength_vehicle_type_extended2,le.avelength_fixed_object_direction1,le.avelength_fixed_object_direction2,le.avelength_fixed_object_direction3,le.avelength_fixed_object_direction4,le.avelength_vehicle_left_at_scene,le.avelength_vehicle_impounded,le.avelength_vehicle_driven_from_scene,le.avelength_on_cross_street,le.avelength_actions_of_police_vehicle_description,le.avelength_vehicle_seg,le.avelength_vehicle_seg_type,le.avelength_model_year,le.avelength_body_style_code,le.avelength_engine_size,le.avelength_fuel_code,le.avelength_number_of_driving_wheels,le.avelength_steering_type,le.avelength_vina_series,le.avelength_vina_model,le.avelength_vina_make,le.avelength_vina_body_style,le.avelength_make_description,le.avelength_model_description,le.avelength_series_description,le.avelength_car_cylinders,le.avelength_other_vehicle_seg,le.avelength_other_vehicle_seg_type,le.avelength_other_model_year,le.avelength_other_body_style_code,le.avelength_other_engine_size,le.avelength_other_fuel_code,le.avelength_other_number_of_driving_wheels,le.avelength_other_steering_type,le.avelength_other_vina_series,le.avelength_other_vina_model,le.avelength_other_vina_make,le.avelength_other_vina_body_style,le.avelength_other_make_description,le.avelength_other_model_description,le.avelength_other_series_description,le.avelength_other_car_cylinders,le.avelength_report_has_coversheet,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_z5,le.avelength_z4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county_code,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_nametype,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_title2,le.avelength_fname2,le.avelength_mname2,le.avelength_lname2,le.avelength_suffix2,le.avelength_name_score,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_rawaid,le.avelength_law_enforcement_suspects_alcohol_use1,le.avelength_law_enforcement_suspects_drug_use1,le.avelength_ems_notified_time,le.avelength_ems_arrival_time,le.avelength_avoidance_maneuver2,le.avelength_avoidance_maneuver3,le.avelength_avoidance_maneuver4,le.avelength_damaged_areas_severity1,le.avelength_damaged_areas_severity2,le.avelength_vehicle_outside_city_indicator,le.avelength_vehicle_outside_city_distance_miles,le.avelength_vehicle_outside_city_direction,le.avelength_vehicle_crash_cityplace,le.avelength_insurance_company_standardized,le.avelength_insurance_expiration_date,le.avelength_insurance_policy_holder,le.avelength_is_tag_converted,le.avelength_vin_original,le.avelength_make_original,le.avelength_model_original,le.avelength_model_year_original,le.avelength_other_unit_vin_original,le.avelength_other_unit_make_original,le.avelength_other_unit_model_original,le.avelength_other_unit_model_year_original,le.avelength_source_id,le.avelength_orig_fname,le.avelength_orig_lname,le.avelength_orig_mname,le.avelength_initial_point_of_contact,le.avelength_vehicle_driveable,le.avelength_drivers_license_type,le.avelength_alcohol_test_type_refused,le.avelength_alcohol_test_type_not_offered,le.avelength_alcohol_test_type_field,le.avelength_alcohol_test_type_pbt,le.avelength_alcohol_test_type_breath,le.avelength_alcohol_test_type_blood,le.avelength_alcohol_test_type_urine,le.avelength_trapped,le.avelength_dl_number_cdl_endorsements,le.avelength_dl_number_cdl_restrictions,le.avelength_dl_number_cdl_exempt,le.avelength_dl_number_cdl_medical_card,le.avelength_interlock_device_in_use,le.avelength_drug_test_type_blood,le.avelength_drug_test_type_urine,le.avelength_traffic_control_condition,le.avelength_intersection_related,le.avelength_special_study_local,le.avelength_special_study_state,le.avelength_off_road_vehicle_involved,le.avelength_location_type2,le.avelength_speed_limit_posted,le.avelength_traffic_control_damage_notify_date,le.avelength_traffic_control_damage_notify_time,le.avelength_traffic_control_damage_notify_name,le.avelength_public_property_damaged,le.avelength_replacement_report,le.avelength_deleted_report,le.avelength_next_street_prefix,le.avelength_violator_name,le.avelength_type_hazardous,le.avelength_type_other,le.avelength_unit_type_and_axles1,le.avelength_unit_type_and_axles2,le.avelength_unit_type_and_axles3,le.avelength_unit_type_and_axles4,le.avelength_incident_damage_amount,le.avelength_dot_use,le.avelength_number_of_persons_involved,le.avelength_unusual_road_condition_other_description,le.avelength_number_of_narrative_sections,le.avelength_cad_number,le.avelength_visibility,le.avelength_accident_at_intersection,le.avelength_accident_not_at_intersection,le.avelength_first_harmful_event_within_interchange,le.avelength_injury_involved,le.avelength_citation_status,le.avelength_commercial_vehicle,le.avelength_not_in_transport,le.avelength_other_unit_number,le.avelength_other_unit_length,le.avelength_other_unit_axles,le.avelength_other_unit_plate_expiration,le.avelength_other_unit_permanent_registration,le.avelength_other_unit_model_year2,le.avelength_other_unit_make2,le.avelength_other_unit_vin2,le.avelength_other_unit_registration_state2,le.avelength_other_unit_registration_year2,le.avelength_other_unit_license_plate2,le.avelength_other_unit_number2,le.avelength_other_unit_length2,le.avelength_other_unit_axles2,le.avelength_other_unit_plate_expiration2,le.avelength_other_unit_permanent_registration2,le.avelength_other_unit_type2,le.avelength_other_unit_model_year3,le.avelength_other_unit_make3,le.avelength_other_unit_vin3,le.avelength_other_unit_registration_state3,le.avelength_other_unit_registration_year3,le.avelength_other_unit_license_plate3,le.avelength_other_unit_number3,le.avelength_other_unit_length3,le.avelength_other_unit_axles3,le.avelength_other_unit_plate_expiration3,le.avelength_other_unit_permanent_registration3,le.avelength_other_unit_type3,le.avelength_damaged_areas3,le.avelength_driver_distracted_by,le.avelength_non_motorist_type,le.avelength_seating_position_row,le.avelength_seating_position_seat,le.avelength_seating_position_description,le.avelength_transported_id_number,le.avelength_witness_number,le.avelength_date_of_birth_derived,le.avelength_property_damage_id,le.avelength_property_owner_name,le.avelength_damage_description,le.avelength_damage_estimate,le.avelength_narrative,le.avelength_narrative_continuance,le.avelength_hazardous_materials_hazmat_placard_number1,le.avelength_hazardous_materials_hazmat_placard_number2,le.avelength_vendor_code,le.avelength_report_property_damage,le.avelength_report_collision_type,le.avelength_report_first_harmful_event,le.avelength_report_light_condition,le.avelength_report_weather_condition,le.avelength_report_road_condition,le.avelength_report_injury_status,le.avelength_report_damage_extent,le.avelength_report_vehicle_type,le.avelength_report_traffic_control_device_type,le.avelength_report_contributing_circumstances_v,le.avelength_report_vehicle_maneuver_action_prior,le.avelength_report_vehicle_body_type,le.avelength_cru_agency_name,le.avelength_cru_agency_id,le.avelength_cname,le.avelength_name_type,le.avelength_vendor_report_id,le.avelength_is_available_for_public,le.avelength_has_addendum,le.avelength_report_agency_ori,le.avelength_report_status,le.avelength_super_report_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 840, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.report_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.report_code),TRIM((SALT30.StrType)le.report_category),TRIM((SALT30.StrType)le.report_code_desc),TRIM((SALT30.StrType)le.citation_id),TRIM((SALT30.StrType)le.creation_date),TRIM((SALT30.StrType)le.incident_id),TRIM((SALT30.StrType)le.citation_issued),TRIM((SALT30.StrType)le.citation_number1),TRIM((SALT30.StrType)le.citation_number2),TRIM((SALT30.StrType)le.section_number1),TRIM((SALT30.StrType)le.court_date),TRIM((SALT30.StrType)le.court_time),TRIM((SALT30.StrType)le.citation_detail1),TRIM((SALT30.StrType)le.local_code),TRIM((SALT30.StrType)le.violation_code1),TRIM((SALT30.StrType)le.violation_code2),TRIM((SALT30.StrType)le.multiple_charges_indicator),TRIM((SALT30.StrType)le.dui_indicator),TRIM((SALT30.StrType)le.commercial_id),TRIM((SALT30.StrType)le.vehicle_id),TRIM((SALT30.StrType)le.commercial_info_source),TRIM((SALT30.StrType)le.commercial_vehicle_type),TRIM((SALT30.StrType)le.motor_carrier_id_dot_number),TRIM((SALT30.StrType)le.motor_carrier_id_state_id),TRIM((SALT30.StrType)le.motor_carrier_id_carrier_name),TRIM((SALT30.StrType)le.motor_carrier_id_address),TRIM((SALT30.StrType)le.motor_carrier_id_city),TRIM((SALT30.StrType)le.motor_carrier_id_state),TRIM((SALT30.StrType)le.motor_carrier_id_zipcode),TRIM((SALT30.StrType)le.motor_carrier_id_commercial_indicator),TRIM((SALT30.StrType)le.carrier_id_type),TRIM((SALT30.StrType)le.carrier_unit_number),TRIM((SALT30.StrType)le.dot_permit_number),TRIM((SALT30.StrType)le.iccmc_number),TRIM((SALT30.StrType)le.mcs_vehicle_inspection),TRIM((SALT30.StrType)le.mcs_form_number),TRIM((SALT30.StrType)le.mcs_out_of_service),TRIM((SALT30.StrType)le.mcs_violation_related),TRIM((SALT30.StrType)le.number_of_axles),TRIM((SALT30.StrType)le.number_of_tires),TRIM((SALT30.StrType)le.gvw_over_10k_pounds),TRIM((SALT30.StrType)le.weight_rating),TRIM((SALT30.StrType)le.registered_gross_vehicle_weight),TRIM((SALT30.StrType)le.vehicle_length_feet),TRIM((SALT30.StrType)le.cargo_body_type),TRIM((SALT30.StrType)le.load_type),TRIM((SALT30.StrType)le.oversize_load),TRIM((SALT30.StrType)le.vehicle_configuration),TRIM((SALT30.StrType)le.trailer1_type),TRIM((SALT30.StrType)le.trailer1_length_feet),TRIM((SALT30.StrType)le.trailer1_width_feet),TRIM((SALT30.StrType)le.trailer2_type),TRIM((SALT30.StrType)le.trailer2_length_feet),TRIM((SALT30.StrType)le.trailer2_width_feet),TRIM((SALT30.StrType)le.federally_reportable),TRIM((SALT30.StrType)le.vehicle_inspection_hazmat),TRIM((SALT30.StrType)le.hazmat_form_number),TRIM((SALT30.StrType)le.hazmt_out_of_service),TRIM((SALT30.StrType)le.hazmat_violation_related),TRIM((SALT30.StrType)le.hazardous_materials_placard),TRIM((SALT30.StrType)le.hazardous_materials_class_number1),TRIM((SALT30.StrType)le.hazardous_materials_class_number2),TRIM((SALT30.StrType)le.hazmat_placard_name),TRIM((SALT30.StrType)le.hazardous_materials_released1),TRIM((SALT30.StrType)le.hazardous_materials_released2),TRIM((SALT30.StrType)le.hazardous_materials_released3),TRIM((SALT30.StrType)le.hazardous_materials_released4),TRIM((SALT30.StrType)le.commercial_event1),TRIM((SALT30.StrType)le.commercial_event2),TRIM((SALT30.StrType)le.commercial_event3),TRIM((SALT30.StrType)le.commercial_event4),TRIM((SALT30.StrType)le.recommended_driver_reexam),TRIM((SALT30.StrType)le.transporting_hazmat),TRIM((SALT30.StrType)le.liquid_hazmat_volume),TRIM((SALT30.StrType)le.oversize_vehicle),TRIM((SALT30.StrType)le.overlength_vehicle),TRIM((SALT30.StrType)le.oversize_vehicle_permitted),TRIM((SALT30.StrType)le.overlength_vehicle_permitted),TRIM((SALT30.StrType)le.carrier_phone_number),TRIM((SALT30.StrType)le.commerce_type),TRIM((SALT30.StrType)le.citation_issued_to_vehicle),TRIM((SALT30.StrType)le.cdl_class),TRIM((SALT30.StrType)le.dot_state),TRIM((SALT30.StrType)le.fire_hazardous_materials_involvement),TRIM((SALT30.StrType)le.commercial_event_description),TRIM((SALT30.StrType)le.supplment_required_hazmat_placard),TRIM((SALT30.StrType)le.other_state_number1),TRIM((SALT30.StrType)le.other_state_number2),TRIM((SALT30.StrType)le.work_type_id),TRIM((SALT30.StrType)le.report_id),TRIM((SALT30.StrType)le.agency_id),TRIM((SALT30.StrType)le.sent_to_hpcc_datetime),TRIM((SALT30.StrType)le.corrected_incident),TRIM((SALT30.StrType)le.cru_order_id),TRIM((SALT30.StrType)le.cru_sequence_nbr),TRIM((SALT30.StrType)le.loss_state_abbr),TRIM((SALT30.StrType)le.report_type_id),TRIM((SALT30.StrType)le.hash_key),TRIM((SALT30.StrType)le.case_identifier),TRIM((SALT30.StrType)le.crash_county),TRIM((SALT30.StrType)le.county_cd),TRIM((SALT30.StrType)le.crash_cityplace),TRIM((SALT30.StrType)le.crash_city),TRIM((SALT30.StrType)le.city_code),TRIM((SALT30.StrType)le.first_harmful_event),TRIM((SALT30.StrType)le.first_harmful_event_location),TRIM((SALT30.StrType)le.manner_crash_impact1),TRIM((SALT30.StrType)le.weather_condition1),TRIM((SALT30.StrType)le.weather_condition2),TRIM((SALT30.StrType)le.light_condition1),TRIM((SALT30.StrType)le.light_condition2),TRIM((SALT30.StrType)le.road_surface_condition),TRIM((SALT30.StrType)le.contributing_circumstances_environmental1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental2),TRIM((SALT30.StrType)le.contributing_circumstances_environmental3),TRIM((SALT30.StrType)le.contributing_circumstances_environmental4),TRIM((SALT30.StrType)le.contributing_circumstances_road1),TRIM((SALT30.StrType)le.contributing_circumstances_road2),TRIM((SALT30.StrType)le.contributing_circumstances_road3),TRIM((SALT30.StrType)le.contributing_circumstances_road4),TRIM((SALT30.StrType)le.relation_to_junction),TRIM((SALT30.StrType)le.intersection_type),TRIM((SALT30.StrType)le.school_bus_related),TRIM((SALT30.StrType)le.work_zone_related),TRIM((SALT30.StrType)le.work_zone_location),TRIM((SALT30.StrType)le.work_zone_type),TRIM((SALT30.StrType)le.work_zone_workers_present),TRIM((SALT30.StrType)le.work_zone_law_enforcement_present),TRIM((SALT30.StrType)le.crash_severity),TRIM((SALT30.StrType)le.number_of_vehicles),TRIM((SALT30.StrType)le.total_nonfatal_injuries),TRIM((SALT30.StrType)le.total_fatal_injuries),TRIM((SALT30.StrType)le.day_of_week),TRIM((SALT30.StrType)le.roadway_curvature),TRIM((SALT30.StrType)le.part_of_national_highway_system),TRIM((SALT30.StrType)le.roadway_functional_class),TRIM((SALT30.StrType)le.access_control),TRIM((SALT30.StrType)le.rr_crossing_id),TRIM((SALT30.StrType)le.roadway_lighting),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection1),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection2),TRIM((SALT30.StrType)le.ncic_number),TRIM((SALT30.StrType)le.state_report_number),TRIM((SALT30.StrType)le.ori_number),TRIM((SALT30.StrType)le.crash_date),TRIM((SALT30.StrType)le.crash_time),TRIM((SALT30.StrType)le.lattitude),TRIM((SALT30.StrType)le.longitude),TRIM((SALT30.StrType)le.milepost1),TRIM((SALT30.StrType)le.milepost2),TRIM((SALT30.StrType)le.address_number),TRIM((SALT30.StrType)le.loss_street),TRIM((SALT30.StrType)le.loss_street_route_number),TRIM((SALT30.StrType)le.loss_street_type),TRIM((SALT30.StrType)le.loss_street_speed_limit),TRIM((SALT30.StrType)le.incident_location_indicator),TRIM((SALT30.StrType)le.loss_cross_street),TRIM((SALT30.StrType)le.loss_cross_street_route_number),TRIM((SALT30.StrType)le.loss_cross_street_intersecting_route_segment),TRIM((SALT30.StrType)le.loss_cross_street_type),TRIM((SALT30.StrType)le.loss_cross_street_speed_limit),TRIM((SALT30.StrType)le.loss_cross_street_number_of_lanes),TRIM((SALT30.StrType)le.loss_cross_street_orientation),TRIM((SALT30.StrType)le.loss_cross_street_route_sign),TRIM((SALT30.StrType)le.at_node_number),TRIM((SALT30.StrType)le.distance_from_node_feet),TRIM((SALT30.StrType)le.distance_from_node_miles),TRIM((SALT30.StrType)le.next_node_number),TRIM((SALT30.StrType)le.next_roadway_node_number),TRIM((SALT30.StrType)le.direction_of_travel),TRIM((SALT30.StrType)le.next_street),TRIM((SALT30.StrType)le.next_street_type),TRIM((SALT30.StrType)le.next_street_suffix),TRIM((SALT30.StrType)le.before_or_after_next_street),TRIM((SALT30.StrType)le.next_street_distance_feet),TRIM((SALT30.StrType)le.next_street_distance_miles),TRIM((SALT30.StrType)le.next_street_direction),TRIM((SALT30.StrType)le.next_street_route_segment),TRIM((SALT30.StrType)le.continuing_toward_street),TRIM((SALT30.StrType)le.continuing_street_suffix),TRIM((SALT30.StrType)le.continuing_street_direction),TRIM((SALT30.StrType)le.continuting_street_route_segment),TRIM((SALT30.StrType)le.city_type),TRIM((SALT30.StrType)le.outside_city_indicator),TRIM((SALT30.StrType)le.outside_city_direction),TRIM((SALT30.StrType)le.outside_city_distance_feet),TRIM((SALT30.StrType)le.outside_city_distance_miles),TRIM((SALT30.StrType)le.crash_type),TRIM((SALT30.StrType)le.motor_vehicle_involved_with),TRIM((SALT30.StrType)le.report_investigation_type),TRIM((SALT30.StrType)le.incident_hit_and_run),TRIM((SALT30.StrType)le.tow_away),TRIM((SALT30.StrType)le.date_notified),TRIM((SALT30.StrType)le.time_notified),TRIM((SALT30.StrType)le.notification_method),TRIM((SALT30.StrType)le.officer_arrival_time),TRIM((SALT30.StrType)le.officer_report_date),TRIM((SALT30.StrType)le.officer_report_time),TRIM((SALT30.StrType)le.officer_id),TRIM((SALT30.StrType)le.officer_department),TRIM((SALT30.StrType)le.officer_rank),TRIM((SALT30.StrType)le.officer_command),TRIM((SALT30.StrType)le.officer_tax_id_number),TRIM((SALT30.StrType)le.completed_report_date),TRIM((SALT30.StrType)le.supervisor_check_date),TRIM((SALT30.StrType)le.supervisor_check_time),TRIM((SALT30.StrType)le.supervisor_id),TRIM((SALT30.StrType)le.supervisor_rank),TRIM((SALT30.StrType)le.reviewers_name),TRIM((SALT30.StrType)le.road_surface),TRIM((SALT30.StrType)le.roadway_alignment),TRIM((SALT30.StrType)le.traffic_way_description),TRIM((SALT30.StrType)le.traffic_flow),TRIM((SALT30.StrType)le.property_damage_involved),TRIM((SALT30.StrType)le.property_damage_description1),TRIM((SALT30.StrType)le.property_damage_description2),TRIM((SALT30.StrType)le.property_damage_estimate1),TRIM((SALT30.StrType)le.property_damage_estimate2),TRIM((SALT30.StrType)le.incident_damage_over_limit),TRIM((SALT30.StrType)le.property_owner_notified),TRIM((SALT30.StrType)le.government_property),TRIM((SALT30.StrType)le.accident_condition),TRIM((SALT30.StrType)le.unusual_road_condition1),TRIM((SALT30.StrType)le.unusual_road_condition2),TRIM((SALT30.StrType)le.number_of_lanes),TRIM((SALT30.StrType)le.divided_highway),TRIM((SALT30.StrType)le.most_harmful_event),TRIM((SALT30.StrType)le.second_harmful_event),TRIM((SALT30.StrType)le.ems_notified_date),TRIM((SALT30.StrType)le.ems_arrival_date),TRIM((SALT30.StrType)le.hospital_arrival_date),TRIM((SALT30.StrType)le.injured_taken_by),TRIM((SALT30.StrType)le.injured_taken_to),TRIM((SALT30.StrType)le.incident_transported_for_medical_care),TRIM((SALT30.StrType)le.photographs_taken),TRIM((SALT30.StrType)le.photographed_by),TRIM((SALT30.StrType)le.photographer_id),TRIM((SALT30.StrType)le.photography_agency_name),TRIM((SALT30.StrType)le.agency_name),TRIM((SALT30.StrType)le.judicial_district),TRIM((SALT30.StrType)le.precinct),TRIM((SALT30.StrType)le.beat),TRIM((SALT30.StrType)le.location_type),TRIM((SALT30.StrType)le.shoulder_type),TRIM((SALT30.StrType)le.investigation_complete),TRIM((SALT30.StrType)le.investigation_not_complete_why),TRIM((SALT30.StrType)le.investigating_officer_name),TRIM((SALT30.StrType)le.investigation_notification_issued),TRIM((SALT30.StrType)le.agency_type),TRIM((SALT30.StrType)le.no_injury_tow_involved),TRIM((SALT30.StrType)le.injury_tow_involved),TRIM((SALT30.StrType)le.lars_code1),TRIM((SALT30.StrType)le.lars_code2),TRIM((SALT30.StrType)le.private_property_incident),TRIM((SALT30.StrType)le.accident_involvement),TRIM((SALT30.StrType)le.local_use),TRIM((SALT30.StrType)le.street_prefix),TRIM((SALT30.StrType)le.street_suffix),TRIM((SALT30.StrType)le.toll_road),TRIM((SALT30.StrType)le.street_description),TRIM((SALT30.StrType)le.cross_street_address_number),TRIM((SALT30.StrType)le.cross_street_prefix),TRIM((SALT30.StrType)le.cross_street_suffix),TRIM((SALT30.StrType)le.report_complete),TRIM((SALT30.StrType)le.dispatch_notified),TRIM((SALT30.StrType)le.counter_report),TRIM((SALT30.StrType)le.road_type),TRIM((SALT30.StrType)le.agency_code),TRIM((SALT30.StrType)le.public_property_employee),TRIM((SALT30.StrType)le.bridge_related),TRIM((SALT30.StrType)le.ramp_indicator),TRIM((SALT30.StrType)le.to_or_from_location),TRIM((SALT30.StrType)le.complaint_number),TRIM((SALT30.StrType)le.school_zone_related),TRIM((SALT30.StrType)le.notify_dot_maintenance),TRIM((SALT30.StrType)le.special_location),TRIM((SALT30.StrType)le.route_segment),TRIM((SALT30.StrType)le.route_sign),TRIM((SALT30.StrType)le.route_category_street),TRIM((SALT30.StrType)le.route_category_cross_street),TRIM((SALT30.StrType)le.route_category_next_street),TRIM((SALT30.StrType)le.lane_closed),TRIM((SALT30.StrType)le.lane_closure_direction),TRIM((SALT30.StrType)le.lane_direction),TRIM((SALT30.StrType)le.traffic_detoured),TRIM((SALT30.StrType)le.time_closed),TRIM((SALT30.StrType)le.pedestrian_signals),TRIM((SALT30.StrType)le.work_zone_speed_limit),TRIM((SALT30.StrType)le.work_zone_shoulder_median),TRIM((SALT30.StrType)le.work_zone_intermittent_moving),TRIM((SALT30.StrType)le.work_zone_flagger_control),TRIM((SALT30.StrType)le.special_work_zone_characteristics),TRIM((SALT30.StrType)le.lane_number),TRIM((SALT30.StrType)le.offset_distance_feet),TRIM((SALT30.StrType)le.offset_distance_miles),TRIM((SALT30.StrType)le.offset_direction),TRIM((SALT30.StrType)le.asru_code),TRIM((SALT30.StrType)le.mp_grid),TRIM((SALT30.StrType)le.number_of_qualifying_units),TRIM((SALT30.StrType)le.number_of_hazmat_vehicles),TRIM((SALT30.StrType)le.number_of_buses_involved),TRIM((SALT30.StrType)le.number_taken_to_treatment),TRIM((SALT30.StrType)le.number_vehicles_towed),TRIM((SALT30.StrType)le.vehicle_at_fault_unit_number),TRIM((SALT30.StrType)le.time_officer_cleared_scene),TRIM((SALT30.StrType)le.total_minutes_on_scene),TRIM((SALT30.StrType)le.motorists_report),TRIM((SALT30.StrType)le.fatality_involved),TRIM((SALT30.StrType)le.local_dot_index_number),TRIM((SALT30.StrType)le.dor_number),TRIM((SALT30.StrType)le.hospital_code),TRIM((SALT30.StrType)le.special_jurisdiction),TRIM((SALT30.StrType)le.document_type),TRIM((SALT30.StrType)le.distance_was_measured),TRIM((SALT30.StrType)le.street_orientation),TRIM((SALT30.StrType)le.intersecting_route_segment),TRIM((SALT30.StrType)le.primary_fault_indicator),TRIM((SALT30.StrType)le.first_harmful_event_pedestrian),TRIM((SALT30.StrType)le.reference_markers),TRIM((SALT30.StrType)le.other_officer_on_scene),TRIM((SALT30.StrType)le.other_officer_badge_number),TRIM((SALT30.StrType)le.supplemental_report),TRIM((SALT30.StrType)le.supplemental_type),TRIM((SALT30.StrType)le.amended_report),TRIM((SALT30.StrType)le.corrected_report),TRIM((SALT30.StrType)le.state_highway_related),TRIM((SALT30.StrType)le.roadway_lighting_condition),TRIM((SALT30.StrType)le.vendor_reference_number),TRIM((SALT30.StrType)le.duplicate_copy_unit_number),TRIM((SALT30.StrType)le.other_city_agency_description),TRIM((SALT30.StrType)le.notifcation_description),TRIM((SALT30.StrType)le.primary_collision_improper_driving_description),TRIM((SALT30.StrType)le.weather_other_description),TRIM((SALT30.StrType)le.crash_type_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_animal_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_fixed_object_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_other_object_description),TRIM((SALT30.StrType)le.other_investigation_time),TRIM((SALT30.StrType)le.milepost_detail),TRIM((SALT30.StrType)le.utility_pole_number1),TRIM((SALT30.StrType)le.utility_pole_number2),TRIM((SALT30.StrType)le.utility_pole_number3),TRIM((SALT30.StrType)le.person_id),TRIM((SALT30.StrType)le.person_number),TRIM((SALT30.StrType)le.vehicle_unit_number),TRIM((SALT30.StrType)le.sex),TRIM((SALT30.StrType)le.person_type),TRIM((SALT30.StrType)le.injury_status),TRIM((SALT30.StrType)le.occupant_vehicle_unit_number),TRIM((SALT30.StrType)le.seating_position1),TRIM((SALT30.StrType)le.safety_equipment_restraint1),TRIM((SALT30.StrType)le.safety_equipment_restraint2),TRIM((SALT30.StrType)le.safety_equipment_helmet),TRIM((SALT30.StrType)le.air_bag_deployed),TRIM((SALT30.StrType)le.ejection),TRIM((SALT30.StrType)le.drivers_license_jurisdiction),TRIM((SALT30.StrType)le.dl_number_class),TRIM((SALT30.StrType)le.dl_number_cdl),TRIM((SALT30.StrType)le.dl_number_endorsements),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash1),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash2),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash3),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash4),TRIM((SALT30.StrType)le.violation_codes),TRIM((SALT30.StrType)le.condition_at_time_of_crash1),TRIM((SALT30.StrType)le.condition_at_time_of_crash2),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use),TRIM((SALT30.StrType)le.alcohol_test_status),TRIM((SALT30.StrType)le.alcohol_test_type),TRIM((SALT30.StrType)le.alcohol_test_result),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use),TRIM((SALT30.StrType)le.drug_test_given),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash1),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash2),TRIM((SALT30.StrType)le.non_motorist_actions_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_location_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_safety_equipment1),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.driver_license_restrictions1),TRIM((SALT30.StrType)le.drug_test_type),TRIM((SALT30.StrType)le.drug_test_result1),TRIM((SALT30.StrType)le.drug_test_result2),TRIM((SALT30.StrType)le.drug_test_result3),TRIM((SALT30.StrType)le.drug_test_result4),TRIM((SALT30.StrType)le.injury_area),TRIM((SALT30.StrType)le.injury_description),TRIM((SALT30.StrType)le.motorcyclist_head_injury),TRIM((SALT30.StrType)le.party_id),TRIM((SALT30.StrType)le.same_as_driver),TRIM((SALT30.StrType)le.address_same_as_driver),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.name_suffx),TRIM((SALT30.StrType)le.date_of_birth),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip_code),TRIM((SALT30.StrType)le.home_phone),TRIM((SALT30.StrType)le.business_phone),TRIM((SALT30.StrType)le.insurance_company),TRIM((SALT30.StrType)le.insurance_company_phone_number),TRIM((SALT30.StrType)le.insurance_policy_number),TRIM((SALT30.StrType)le.insurance_effective_date),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.drivers_license_number),TRIM((SALT30.StrType)le.drivers_license_expiration),TRIM((SALT30.StrType)le.eye_color),TRIM((SALT30.StrType)le.hair_color),TRIM((SALT30.StrType)le.height),TRIM((SALT30.StrType)le.weight),TRIM((SALT30.StrType)le.race),TRIM((SALT30.StrType)le.pedestrian_cyclist_visibility),TRIM((SALT30.StrType)le.first_aid_by),TRIM((SALT30.StrType)le.person_first_aid_party_type),TRIM((SALT30.StrType)le.person_first_aid_party_type_description),TRIM((SALT30.StrType)le.deceased_at_scene),TRIM((SALT30.StrType)le.death_date),TRIM((SALT30.StrType)le.death_time),TRIM((SALT30.StrType)le.extricated),TRIM((SALT30.StrType)le.alcohol_drug_use),TRIM((SALT30.StrType)le.physical_defects),TRIM((SALT30.StrType)le.driver_residence),TRIM((SALT30.StrType)le.id_type),TRIM((SALT30.StrType)le.proof_of_insurance),TRIM((SALT30.StrType)le.insurance_expired),TRIM((SALT30.StrType)le.insurance_exempt),TRIM((SALT30.StrType)le.insurance_type),TRIM((SALT30.StrType)le.violent_crime_victim_notified),TRIM((SALT30.StrType)le.insurance_company_code),TRIM((SALT30.StrType)le.refused_medical_treatment),TRIM((SALT30.StrType)le.safety_equipment_available_or_used),TRIM((SALT30.StrType)le.apartment_number),TRIM((SALT30.StrType)le.licensed_driver),TRIM((SALT30.StrType)le.physical_emotional_status),TRIM((SALT30.StrType)le.driver_presence),TRIM((SALT30.StrType)le.ejection_path),TRIM((SALT30.StrType)le.state_person_id),TRIM((SALT30.StrType)le.contributed_to_collision),TRIM((SALT30.StrType)le.person_transported_for_medical_care),TRIM((SALT30.StrType)le.transported_by_agency_type),TRIM((SALT30.StrType)le.transported_to),TRIM((SALT30.StrType)le.non_motorist_driver_license_number),TRIM((SALT30.StrType)le.air_bag_type),TRIM((SALT30.StrType)le.cell_phone_use),TRIM((SALT30.StrType)le.driver_license_restriction_compliance),TRIM((SALT30.StrType)le.driver_license_endorsement_compliance),TRIM((SALT30.StrType)le.driver_license_compliance),TRIM((SALT30.StrType)le.contributing_circumstances_p1),TRIM((SALT30.StrType)le.contributing_circumstances_p2),TRIM((SALT30.StrType)le.contributing_circumstances_p3),TRIM((SALT30.StrType)le.contributing_circumstances_p4),TRIM((SALT30.StrType)le.passenger_number),TRIM((SALT30.StrType)le.person_deleted),TRIM((SALT30.StrType)le.owner_lessee),TRIM((SALT30.StrType)le.driver_charged),TRIM((SALT30.StrType)le.motorcycle_eye_protection),TRIM((SALT30.StrType)le.motorcycle_long_sleeves),TRIM((SALT30.StrType)le.motorcycle_long_pants),TRIM((SALT30.StrType)le.motorcycle_over_ankle_boots),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident2),TRIM((SALT30.StrType)le.alcohol_drug_test_given),TRIM((SALT30.StrType)le.alcohol_drug_test_type),TRIM((SALT30.StrType)le.alcohol_drug_test_result),TRIM((SALT30.StrType)le.vin),TRIM((SALT30.StrType)le.vin_status),TRIM((SALT30.StrType)le.damaged_areas_derived1),TRIM((SALT30.StrType)le.damaged_areas_derived2),TRIM((SALT30.StrType)le.airbags_deployed_derived),TRIM((SALT30.StrType)le.vehicle_towed_derived),TRIM((SALT30.StrType)le.unit_type),TRIM((SALT30.StrType)le.unit_number),TRIM((SALT30.StrType)le.registration_state),TRIM((SALT30.StrType)le.registration_year),TRIM((SALT30.StrType)le.license_plate),TRIM((SALT30.StrType)le.make),TRIM((SALT30.StrType)le.model_yr),TRIM((SALT30.StrType)le.model),TRIM((SALT30.StrType)le.body_type_category),TRIM((SALT30.StrType)le.total_occupants_in_vehicle),TRIM((SALT30.StrType)le.special_function_in_transport),TRIM((SALT30.StrType)le.special_function_in_transport_other_unit),TRIM((SALT30.StrType)le.emergency_use),TRIM((SALT30.StrType)le.posted_satutory_speed_limit),TRIM((SALT30.StrType)le.direction_of_travel_before_crash),TRIM((SALT30.StrType)le.trafficway_description),TRIM((SALT30.StrType)le.traffic_control_device_type),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior1),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior2),TRIM((SALT30.StrType)le.impact_area1),TRIM((SALT30.StrType)le.impact_area2),TRIM((SALT30.StrType)le.event_sequence1),TRIM((SALT30.StrType)le.event_sequence2),TRIM((SALT30.StrType)le.event_sequence3),TRIM((SALT30.StrType)le.event_sequence4),TRIM((SALT30.StrType)le.most_harmful_event_for_vehicle),TRIM((SALT30.StrType)le.bus_use),TRIM((SALT30.StrType)le.vehicle_hit_and_run),TRIM((SALT30.StrType)le.vehicle_towed),TRIM((SALT30.StrType)le.contributing_circumstances_v1),TRIM((SALT30.StrType)le.contributing_circumstances_v2),TRIM((SALT30.StrType)le.contributing_circumstances_v3),TRIM((SALT30.StrType)le.contributing_circumstances_v4),TRIM((SALT30.StrType)le.on_street),TRIM((SALT30.StrType)le.vehicle_color),TRIM((SALT30.StrType)le.estimated_speed),TRIM((SALT30.StrType)le.accident_investigation_site),TRIM((SALT30.StrType)le.car_fire),TRIM((SALT30.StrType)le.vehicle_damage_amount),TRIM((SALT30.StrType)le.contributing_factors1),TRIM((SALT30.StrType)le.contributing_factors2),TRIM((SALT30.StrType)le.contributing_factors3),TRIM((SALT30.StrType)le.contributing_factors4),TRIM((SALT30.StrType)le.other_contributing_factors1),TRIM((SALT30.StrType)le.other_contributing_factors2),TRIM((SALT30.StrType)le.other_contributing_factors3),TRIM((SALT30.StrType)le.vision_obscured1),TRIM((SALT30.StrType)le.vision_obscured2),TRIM((SALT30.StrType)le.vehicle_on_road),TRIM((SALT30.StrType)le.ran_off_road),TRIM((SALT30.StrType)le.skidding_occurred),TRIM((SALT30.StrType)le.vehicle_incident_location1),TRIM((SALT30.StrType)le.vehicle_incident_location2),TRIM((SALT30.StrType)le.vehicle_incident_location3),TRIM((SALT30.StrType)le.vehicle_disabled),TRIM((SALT30.StrType)le.vehicle_removed_to),TRIM((SALT30.StrType)le.removed_by),TRIM((SALT30.StrType)le.tow_requested_by_driver),TRIM((SALT30.StrType)le.solicitation),TRIM((SALT30.StrType)le.other_unit_vehicle_damage_amount),TRIM((SALT30.StrType)le.other_unit_model_year),TRIM((SALT30.StrType)le.other_unit_make),TRIM((SALT30.StrType)le.other_unit_model),TRIM((SALT30.StrType)le.other_unit_vin),TRIM((SALT30.StrType)le.other_unit_vin_status),TRIM((SALT30.StrType)le.other_unit_body_type_category),TRIM((SALT30.StrType)le.other_unit_registration_state),TRIM((SALT30.StrType)le.other_unit_registration_year),TRIM((SALT30.StrType)le.other_unit_license_plate),TRIM((SALT30.StrType)le.other_unit_color),TRIM((SALT30.StrType)le.other_unit_type),TRIM((SALT30.StrType)le.damaged_areas1),TRIM((SALT30.StrType)le.damaged_areas2),TRIM((SALT30.StrType)le.parked_vehicle),TRIM((SALT30.StrType)le.damage_rating1),TRIM((SALT30.StrType)le.damage_rating2),TRIM((SALT30.StrType)le.vehicle_inventoried),TRIM((SALT30.StrType)le.vehicle_defect_apparent),TRIM((SALT30.StrType)le.defect_may_have_contributed1),TRIM((SALT30.StrType)le.defect_may_have_contributed2),TRIM((SALT30.StrType)le.registration_expiration),TRIM((SALT30.StrType)le.owner_driver_type),TRIM((SALT30.StrType)le.make_code),TRIM((SALT30.StrType)le.number_trailing_units),TRIM((SALT30.StrType)le.vehicle_position),TRIM((SALT30.StrType)le.vehicle_type),TRIM((SALT30.StrType)le.motorcycle_engine_size),TRIM((SALT30.StrType)le.motorcycle_driver_educated),TRIM((SALT30.StrType)le.motorcycle_helmet_type),TRIM((SALT30.StrType)le.motorcycle_passenger),TRIM((SALT30.StrType)le.motorcycle_helmet_stayed_on),TRIM((SALT30.StrType)le.motorcycle_helmet_dot_snell),TRIM((SALT30.StrType)le.motorcycle_saddlebag_trunk),TRIM((SALT30.StrType)le.motorcycle_trailer),TRIM((SALT30.StrType)le.pedacycle_passenger),TRIM((SALT30.StrType)le.pedacycle_headlights),TRIM((SALT30.StrType)le.pedacycle_helmet),TRIM((SALT30.StrType)le.pedacycle_rear_reflectors),TRIM((SALT30.StrType)le.cdl_required),TRIM((SALT30.StrType)le.truck_bus_supplement_required),TRIM((SALT30.StrType)le.unit_damage_amount),TRIM((SALT30.StrType)le.airbag_switch),TRIM((SALT30.StrType)le.underride_override_damage),TRIM((SALT30.StrType)le.vehicle_attachment),TRIM((SALT30.StrType)le.action_on_impact),TRIM((SALT30.StrType)le.speed_detection_method),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_from),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_to),TRIM((SALT30.StrType)le.vehicle_use),TRIM((SALT30.StrType)le.department_unit_number),TRIM((SALT30.StrType)le.equipment_in_use_at_time_of_accident),TRIM((SALT30.StrType)le.actions_of_police_vehicle),TRIM((SALT30.StrType)le.vehicle_command_id),TRIM((SALT30.StrType)le.traffic_control_device_inoperative),TRIM((SALT30.StrType)le.direction_of_impact1),TRIM((SALT30.StrType)le.direction_of_impact2),TRIM((SALT30.StrType)le.ran_off_road_direction),TRIM((SALT30.StrType)le.vin_other_unit_number),TRIM((SALT30.StrType)le.damaged_area_generic),TRIM((SALT30.StrType)le.vision_obscured_description),TRIM((SALT30.StrType)le.inattention_description),TRIM((SALT30.StrType)le.contributing_circumstances_defect_description),TRIM((SALT30.StrType)le.contributing_circumstances_other_descriptioin),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior_other_description),TRIM((SALT30.StrType)le.vehicle_special_use),TRIM((SALT30.StrType)le.vehicle_type_extended1),TRIM((SALT30.StrType)le.vehicle_type_extended2),TRIM((SALT30.StrType)le.fixed_object_direction1),TRIM((SALT30.StrType)le.fixed_object_direction2),TRIM((SALT30.StrType)le.fixed_object_direction3),TRIM((SALT30.StrType)le.fixed_object_direction4),TRIM((SALT30.StrType)le.vehicle_left_at_scene),TRIM((SALT30.StrType)le.vehicle_impounded),TRIM((SALT30.StrType)le.vehicle_driven_from_scene),TRIM((SALT30.StrType)le.on_cross_street),TRIM((SALT30.StrType)le.actions_of_police_vehicle_description),TRIM((SALT30.StrType)le.vehicle_seg),TRIM((SALT30.StrType)le.vehicle_seg_type),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.body_style_code),TRIM((SALT30.StrType)le.engine_size),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.number_of_driving_wheels),TRIM((SALT30.StrType)le.steering_type),TRIM((SALT30.StrType)le.vina_series),TRIM((SALT30.StrType)le.vina_model),TRIM((SALT30.StrType)le.vina_make),TRIM((SALT30.StrType)le.vina_body_style),TRIM((SALT30.StrType)le.make_description),TRIM((SALT30.StrType)le.model_description),TRIM((SALT30.StrType)le.series_description),TRIM((SALT30.StrType)le.car_cylinders),TRIM((SALT30.StrType)le.other_vehicle_seg),TRIM((SALT30.StrType)le.other_vehicle_seg_type),TRIM((SALT30.StrType)le.other_model_year),TRIM((SALT30.StrType)le.other_body_style_code),TRIM((SALT30.StrType)le.other_engine_size),TRIM((SALT30.StrType)le.other_fuel_code),TRIM((SALT30.StrType)le.other_number_of_driving_wheels),TRIM((SALT30.StrType)le.other_steering_type),TRIM((SALT30.StrType)le.other_vina_series),TRIM((SALT30.StrType)le.other_vina_model),TRIM((SALT30.StrType)le.other_vina_make),TRIM((SALT30.StrType)le.other_vina_body_style),TRIM((SALT30.StrType)le.other_make_description),TRIM((SALT30.StrType)le.other_model_description),TRIM((SALT30.StrType)le.other_series_description),TRIM((SALT30.StrType)le.other_car_cylinders),TRIM((SALT30.StrType)le.report_has_coversheet),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.z4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county_code),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.nametype),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.title2),TRIM((SALT30.StrType)le.fname2),TRIM((SALT30.StrType)le.mname2),TRIM((SALT30.StrType)le.lname2),TRIM((SALT30.StrType)le.suffix2),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use1),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use1),TRIM((SALT30.StrType)le.ems_notified_time),TRIM((SALT30.StrType)le.ems_arrival_time),TRIM((SALT30.StrType)le.avoidance_maneuver2),TRIM((SALT30.StrType)le.avoidance_maneuver3),TRIM((SALT30.StrType)le.avoidance_maneuver4),TRIM((SALT30.StrType)le.damaged_areas_severity1),TRIM((SALT30.StrType)le.damaged_areas_severity2),TRIM((SALT30.StrType)le.vehicle_outside_city_indicator),TRIM((SALT30.StrType)le.vehicle_outside_city_distance_miles),TRIM((SALT30.StrType)le.vehicle_outside_city_direction),TRIM((SALT30.StrType)le.vehicle_crash_cityplace),TRIM((SALT30.StrType)le.insurance_company_standardized),TRIM((SALT30.StrType)le.insurance_expiration_date),TRIM((SALT30.StrType)le.insurance_policy_holder),TRIM((SALT30.StrType)le.is_tag_converted),TRIM((SALT30.StrType)le.vin_original),TRIM((SALT30.StrType)le.make_original),TRIM((SALT30.StrType)le.model_original),TRIM((SALT30.StrType)le.model_year_original),TRIM((SALT30.StrType)le.other_unit_vin_original),TRIM((SALT30.StrType)le.other_unit_make_original),TRIM((SALT30.StrType)le.other_unit_model_original),TRIM((SALT30.StrType)le.other_unit_model_year_original),TRIM((SALT30.StrType)le.source_id),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.initial_point_of_contact),TRIM((SALT30.StrType)le.vehicle_driveable),TRIM((SALT30.StrType)le.drivers_license_type),TRIM((SALT30.StrType)le.alcohol_test_type_refused),TRIM((SALT30.StrType)le.alcohol_test_type_not_offered),TRIM((SALT30.StrType)le.alcohol_test_type_field),TRIM((SALT30.StrType)le.alcohol_test_type_pbt),TRIM((SALT30.StrType)le.alcohol_test_type_breath),TRIM((SALT30.StrType)le.alcohol_test_type_blood),TRIM((SALT30.StrType)le.alcohol_test_type_urine),TRIM((SALT30.StrType)le.trapped),TRIM((SALT30.StrType)le.dl_number_cdl_endorsements),TRIM((SALT30.StrType)le.dl_number_cdl_restrictions),TRIM((SALT30.StrType)le.dl_number_cdl_exempt),TRIM((SALT30.StrType)le.dl_number_cdl_medical_card),TRIM((SALT30.StrType)le.interlock_device_in_use),TRIM((SALT30.StrType)le.drug_test_type_blood),TRIM((SALT30.StrType)le.drug_test_type_urine),TRIM((SALT30.StrType)le.traffic_control_condition),TRIM((SALT30.StrType)le.intersection_related),TRIM((SALT30.StrType)le.special_study_local),TRIM((SALT30.StrType)le.special_study_state),TRIM((SALT30.StrType)le.off_road_vehicle_involved),TRIM((SALT30.StrType)le.location_type2),TRIM((SALT30.StrType)le.speed_limit_posted),TRIM((SALT30.StrType)le.traffic_control_damage_notify_date),TRIM((SALT30.StrType)le.traffic_control_damage_notify_time),TRIM((SALT30.StrType)le.traffic_control_damage_notify_name),TRIM((SALT30.StrType)le.public_property_damaged),TRIM((SALT30.StrType)le.replacement_report),TRIM((SALT30.StrType)le.deleted_report),TRIM((SALT30.StrType)le.next_street_prefix),TRIM((SALT30.StrType)le.violator_name),TRIM((SALT30.StrType)le.type_hazardous),TRIM((SALT30.StrType)le.type_other),TRIM((SALT30.StrType)le.unit_type_and_axles1),TRIM((SALT30.StrType)le.unit_type_and_axles2),TRIM((SALT30.StrType)le.unit_type_and_axles3),TRIM((SALT30.StrType)le.unit_type_and_axles4),TRIM((SALT30.StrType)le.incident_damage_amount),TRIM((SALT30.StrType)le.dot_use),TRIM((SALT30.StrType)le.number_of_persons_involved),TRIM((SALT30.StrType)le.unusual_road_condition_other_description),TRIM((SALT30.StrType)le.number_of_narrative_sections),TRIM((SALT30.StrType)le.cad_number),TRIM((SALT30.StrType)le.visibility),TRIM((SALT30.StrType)le.accident_at_intersection),TRIM((SALT30.StrType)le.accident_not_at_intersection),TRIM((SALT30.StrType)le.first_harmful_event_within_interchange),TRIM((SALT30.StrType)le.injury_involved),TRIM((SALT30.StrType)le.citation_status),TRIM((SALT30.StrType)le.commercial_vehicle),TRIM((SALT30.StrType)le.not_in_transport),TRIM((SALT30.StrType)le.other_unit_number),TRIM((SALT30.StrType)le.other_unit_length),TRIM((SALT30.StrType)le.other_unit_axles),TRIM((SALT30.StrType)le.other_unit_plate_expiration),TRIM((SALT30.StrType)le.other_unit_permanent_registration),TRIM((SALT30.StrType)le.other_unit_model_year2),TRIM((SALT30.StrType)le.other_unit_make2),TRIM((SALT30.StrType)le.other_unit_vin2),TRIM((SALT30.StrType)le.other_unit_registration_state2),TRIM((SALT30.StrType)le.other_unit_registration_year2),TRIM((SALT30.StrType)le.other_unit_license_plate2),TRIM((SALT30.StrType)le.other_unit_number2),TRIM((SALT30.StrType)le.other_unit_length2),TRIM((SALT30.StrType)le.other_unit_axles2),TRIM((SALT30.StrType)le.other_unit_plate_expiration2),TRIM((SALT30.StrType)le.other_unit_permanent_registration2),TRIM((SALT30.StrType)le.other_unit_type2),TRIM((SALT30.StrType)le.other_unit_model_year3),TRIM((SALT30.StrType)le.other_unit_make3),TRIM((SALT30.StrType)le.other_unit_vin3),TRIM((SALT30.StrType)le.other_unit_registration_state3),TRIM((SALT30.StrType)le.other_unit_registration_year3),TRIM((SALT30.StrType)le.other_unit_license_plate3),TRIM((SALT30.StrType)le.other_unit_number3),TRIM((SALT30.StrType)le.other_unit_length3),TRIM((SALT30.StrType)le.other_unit_axles3),TRIM((SALT30.StrType)le.other_unit_plate_expiration3),TRIM((SALT30.StrType)le.other_unit_permanent_registration3),TRIM((SALT30.StrType)le.other_unit_type3),TRIM((SALT30.StrType)le.damaged_areas3),TRIM((SALT30.StrType)le.driver_distracted_by),TRIM((SALT30.StrType)le.non_motorist_type),TRIM((SALT30.StrType)le.seating_position_row),TRIM((SALT30.StrType)le.seating_position_seat),TRIM((SALT30.StrType)le.seating_position_description),TRIM((SALT30.StrType)le.transported_id_number),TRIM((SALT30.StrType)le.witness_number),TRIM((SALT30.StrType)le.date_of_birth_derived),TRIM((SALT30.StrType)le.property_damage_id),TRIM((SALT30.StrType)le.property_owner_name),TRIM((SALT30.StrType)le.damage_description),TRIM((SALT30.StrType)le.damage_estimate),TRIM((SALT30.StrType)le.narrative),TRIM((SALT30.StrType)le.narrative_continuance),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number1),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number2),TRIM((SALT30.StrType)le.vendor_code),TRIM((SALT30.StrType)le.report_property_damage),TRIM((SALT30.StrType)le.report_collision_type),TRIM((SALT30.StrType)le.report_first_harmful_event),TRIM((SALT30.StrType)le.report_light_condition),TRIM((SALT30.StrType)le.report_weather_condition),TRIM((SALT30.StrType)le.report_road_condition),TRIM((SALT30.StrType)le.report_injury_status),TRIM((SALT30.StrType)le.report_damage_extent),TRIM((SALT30.StrType)le.report_vehicle_type),TRIM((SALT30.StrType)le.report_traffic_control_device_type),TRIM((SALT30.StrType)le.report_contributing_circumstances_v),TRIM((SALT30.StrType)le.report_vehicle_maneuver_action_prior),TRIM((SALT30.StrType)le.report_vehicle_body_type),TRIM((SALT30.StrType)le.cru_agency_name),TRIM((SALT30.StrType)le.cru_agency_id),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.vendor_report_id),TRIM((SALT30.StrType)le.is_available_for_public),TRIM((SALT30.StrType)le.has_addendum),TRIM((SALT30.StrType)le.report_agency_ori),TRIM((SALT30.StrType)le.report_status),TRIM((SALT30.StrType)le.super_report_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,840,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 840);
  SELF.FldNo2 := 1 + (C % 840);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.report_code),TRIM((SALT30.StrType)le.report_category),TRIM((SALT30.StrType)le.report_code_desc),TRIM((SALT30.StrType)le.citation_id),TRIM((SALT30.StrType)le.creation_date),TRIM((SALT30.StrType)le.incident_id),TRIM((SALT30.StrType)le.citation_issued),TRIM((SALT30.StrType)le.citation_number1),TRIM((SALT30.StrType)le.citation_number2),TRIM((SALT30.StrType)le.section_number1),TRIM((SALT30.StrType)le.court_date),TRIM((SALT30.StrType)le.court_time),TRIM((SALT30.StrType)le.citation_detail1),TRIM((SALT30.StrType)le.local_code),TRIM((SALT30.StrType)le.violation_code1),TRIM((SALT30.StrType)le.violation_code2),TRIM((SALT30.StrType)le.multiple_charges_indicator),TRIM((SALT30.StrType)le.dui_indicator),TRIM((SALT30.StrType)le.commercial_id),TRIM((SALT30.StrType)le.vehicle_id),TRIM((SALT30.StrType)le.commercial_info_source),TRIM((SALT30.StrType)le.commercial_vehicle_type),TRIM((SALT30.StrType)le.motor_carrier_id_dot_number),TRIM((SALT30.StrType)le.motor_carrier_id_state_id),TRIM((SALT30.StrType)le.motor_carrier_id_carrier_name),TRIM((SALT30.StrType)le.motor_carrier_id_address),TRIM((SALT30.StrType)le.motor_carrier_id_city),TRIM((SALT30.StrType)le.motor_carrier_id_state),TRIM((SALT30.StrType)le.motor_carrier_id_zipcode),TRIM((SALT30.StrType)le.motor_carrier_id_commercial_indicator),TRIM((SALT30.StrType)le.carrier_id_type),TRIM((SALT30.StrType)le.carrier_unit_number),TRIM((SALT30.StrType)le.dot_permit_number),TRIM((SALT30.StrType)le.iccmc_number),TRIM((SALT30.StrType)le.mcs_vehicle_inspection),TRIM((SALT30.StrType)le.mcs_form_number),TRIM((SALT30.StrType)le.mcs_out_of_service),TRIM((SALT30.StrType)le.mcs_violation_related),TRIM((SALT30.StrType)le.number_of_axles),TRIM((SALT30.StrType)le.number_of_tires),TRIM((SALT30.StrType)le.gvw_over_10k_pounds),TRIM((SALT30.StrType)le.weight_rating),TRIM((SALT30.StrType)le.registered_gross_vehicle_weight),TRIM((SALT30.StrType)le.vehicle_length_feet),TRIM((SALT30.StrType)le.cargo_body_type),TRIM((SALT30.StrType)le.load_type),TRIM((SALT30.StrType)le.oversize_load),TRIM((SALT30.StrType)le.vehicle_configuration),TRIM((SALT30.StrType)le.trailer1_type),TRIM((SALT30.StrType)le.trailer1_length_feet),TRIM((SALT30.StrType)le.trailer1_width_feet),TRIM((SALT30.StrType)le.trailer2_type),TRIM((SALT30.StrType)le.trailer2_length_feet),TRIM((SALT30.StrType)le.trailer2_width_feet),TRIM((SALT30.StrType)le.federally_reportable),TRIM((SALT30.StrType)le.vehicle_inspection_hazmat),TRIM((SALT30.StrType)le.hazmat_form_number),TRIM((SALT30.StrType)le.hazmt_out_of_service),TRIM((SALT30.StrType)le.hazmat_violation_related),TRIM((SALT30.StrType)le.hazardous_materials_placard),TRIM((SALT30.StrType)le.hazardous_materials_class_number1),TRIM((SALT30.StrType)le.hazardous_materials_class_number2),TRIM((SALT30.StrType)le.hazmat_placard_name),TRIM((SALT30.StrType)le.hazardous_materials_released1),TRIM((SALT30.StrType)le.hazardous_materials_released2),TRIM((SALT30.StrType)le.hazardous_materials_released3),TRIM((SALT30.StrType)le.hazardous_materials_released4),TRIM((SALT30.StrType)le.commercial_event1),TRIM((SALT30.StrType)le.commercial_event2),TRIM((SALT30.StrType)le.commercial_event3),TRIM((SALT30.StrType)le.commercial_event4),TRIM((SALT30.StrType)le.recommended_driver_reexam),TRIM((SALT30.StrType)le.transporting_hazmat),TRIM((SALT30.StrType)le.liquid_hazmat_volume),TRIM((SALT30.StrType)le.oversize_vehicle),TRIM((SALT30.StrType)le.overlength_vehicle),TRIM((SALT30.StrType)le.oversize_vehicle_permitted),TRIM((SALT30.StrType)le.overlength_vehicle_permitted),TRIM((SALT30.StrType)le.carrier_phone_number),TRIM((SALT30.StrType)le.commerce_type),TRIM((SALT30.StrType)le.citation_issued_to_vehicle),TRIM((SALT30.StrType)le.cdl_class),TRIM((SALT30.StrType)le.dot_state),TRIM((SALT30.StrType)le.fire_hazardous_materials_involvement),TRIM((SALT30.StrType)le.commercial_event_description),TRIM((SALT30.StrType)le.supplment_required_hazmat_placard),TRIM((SALT30.StrType)le.other_state_number1),TRIM((SALT30.StrType)le.other_state_number2),TRIM((SALT30.StrType)le.work_type_id),TRIM((SALT30.StrType)le.report_id),TRIM((SALT30.StrType)le.agency_id),TRIM((SALT30.StrType)le.sent_to_hpcc_datetime),TRIM((SALT30.StrType)le.corrected_incident),TRIM((SALT30.StrType)le.cru_order_id),TRIM((SALT30.StrType)le.cru_sequence_nbr),TRIM((SALT30.StrType)le.loss_state_abbr),TRIM((SALT30.StrType)le.report_type_id),TRIM((SALT30.StrType)le.hash_key),TRIM((SALT30.StrType)le.case_identifier),TRIM((SALT30.StrType)le.crash_county),TRIM((SALT30.StrType)le.county_cd),TRIM((SALT30.StrType)le.crash_cityplace),TRIM((SALT30.StrType)le.crash_city),TRIM((SALT30.StrType)le.city_code),TRIM((SALT30.StrType)le.first_harmful_event),TRIM((SALT30.StrType)le.first_harmful_event_location),TRIM((SALT30.StrType)le.manner_crash_impact1),TRIM((SALT30.StrType)le.weather_condition1),TRIM((SALT30.StrType)le.weather_condition2),TRIM((SALT30.StrType)le.light_condition1),TRIM((SALT30.StrType)le.light_condition2),TRIM((SALT30.StrType)le.road_surface_condition),TRIM((SALT30.StrType)le.contributing_circumstances_environmental1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental2),TRIM((SALT30.StrType)le.contributing_circumstances_environmental3),TRIM((SALT30.StrType)le.contributing_circumstances_environmental4),TRIM((SALT30.StrType)le.contributing_circumstances_road1),TRIM((SALT30.StrType)le.contributing_circumstances_road2),TRIM((SALT30.StrType)le.contributing_circumstances_road3),TRIM((SALT30.StrType)le.contributing_circumstances_road4),TRIM((SALT30.StrType)le.relation_to_junction),TRIM((SALT30.StrType)le.intersection_type),TRIM((SALT30.StrType)le.school_bus_related),TRIM((SALT30.StrType)le.work_zone_related),TRIM((SALT30.StrType)le.work_zone_location),TRIM((SALT30.StrType)le.work_zone_type),TRIM((SALT30.StrType)le.work_zone_workers_present),TRIM((SALT30.StrType)le.work_zone_law_enforcement_present),TRIM((SALT30.StrType)le.crash_severity),TRIM((SALT30.StrType)le.number_of_vehicles),TRIM((SALT30.StrType)le.total_nonfatal_injuries),TRIM((SALT30.StrType)le.total_fatal_injuries),TRIM((SALT30.StrType)le.day_of_week),TRIM((SALT30.StrType)le.roadway_curvature),TRIM((SALT30.StrType)le.part_of_national_highway_system),TRIM((SALT30.StrType)le.roadway_functional_class),TRIM((SALT30.StrType)le.access_control),TRIM((SALT30.StrType)le.rr_crossing_id),TRIM((SALT30.StrType)le.roadway_lighting),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection1),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection2),TRIM((SALT30.StrType)le.ncic_number),TRIM((SALT30.StrType)le.state_report_number),TRIM((SALT30.StrType)le.ori_number),TRIM((SALT30.StrType)le.crash_date),TRIM((SALT30.StrType)le.crash_time),TRIM((SALT30.StrType)le.lattitude),TRIM((SALT30.StrType)le.longitude),TRIM((SALT30.StrType)le.milepost1),TRIM((SALT30.StrType)le.milepost2),TRIM((SALT30.StrType)le.address_number),TRIM((SALT30.StrType)le.loss_street),TRIM((SALT30.StrType)le.loss_street_route_number),TRIM((SALT30.StrType)le.loss_street_type),TRIM((SALT30.StrType)le.loss_street_speed_limit),TRIM((SALT30.StrType)le.incident_location_indicator),TRIM((SALT30.StrType)le.loss_cross_street),TRIM((SALT30.StrType)le.loss_cross_street_route_number),TRIM((SALT30.StrType)le.loss_cross_street_intersecting_route_segment),TRIM((SALT30.StrType)le.loss_cross_street_type),TRIM((SALT30.StrType)le.loss_cross_street_speed_limit),TRIM((SALT30.StrType)le.loss_cross_street_number_of_lanes),TRIM((SALT30.StrType)le.loss_cross_street_orientation),TRIM((SALT30.StrType)le.loss_cross_street_route_sign),TRIM((SALT30.StrType)le.at_node_number),TRIM((SALT30.StrType)le.distance_from_node_feet),TRIM((SALT30.StrType)le.distance_from_node_miles),TRIM((SALT30.StrType)le.next_node_number),TRIM((SALT30.StrType)le.next_roadway_node_number),TRIM((SALT30.StrType)le.direction_of_travel),TRIM((SALT30.StrType)le.next_street),TRIM((SALT30.StrType)le.next_street_type),TRIM((SALT30.StrType)le.next_street_suffix),TRIM((SALT30.StrType)le.before_or_after_next_street),TRIM((SALT30.StrType)le.next_street_distance_feet),TRIM((SALT30.StrType)le.next_street_distance_miles),TRIM((SALT30.StrType)le.next_street_direction),TRIM((SALT30.StrType)le.next_street_route_segment),TRIM((SALT30.StrType)le.continuing_toward_street),TRIM((SALT30.StrType)le.continuing_street_suffix),TRIM((SALT30.StrType)le.continuing_street_direction),TRIM((SALT30.StrType)le.continuting_street_route_segment),TRIM((SALT30.StrType)le.city_type),TRIM((SALT30.StrType)le.outside_city_indicator),TRIM((SALT30.StrType)le.outside_city_direction),TRIM((SALT30.StrType)le.outside_city_distance_feet),TRIM((SALT30.StrType)le.outside_city_distance_miles),TRIM((SALT30.StrType)le.crash_type),TRIM((SALT30.StrType)le.motor_vehicle_involved_with),TRIM((SALT30.StrType)le.report_investigation_type),TRIM((SALT30.StrType)le.incident_hit_and_run),TRIM((SALT30.StrType)le.tow_away),TRIM((SALT30.StrType)le.date_notified),TRIM((SALT30.StrType)le.time_notified),TRIM((SALT30.StrType)le.notification_method),TRIM((SALT30.StrType)le.officer_arrival_time),TRIM((SALT30.StrType)le.officer_report_date),TRIM((SALT30.StrType)le.officer_report_time),TRIM((SALT30.StrType)le.officer_id),TRIM((SALT30.StrType)le.officer_department),TRIM((SALT30.StrType)le.officer_rank),TRIM((SALT30.StrType)le.officer_command),TRIM((SALT30.StrType)le.officer_tax_id_number),TRIM((SALT30.StrType)le.completed_report_date),TRIM((SALT30.StrType)le.supervisor_check_date),TRIM((SALT30.StrType)le.supervisor_check_time),TRIM((SALT30.StrType)le.supervisor_id),TRIM((SALT30.StrType)le.supervisor_rank),TRIM((SALT30.StrType)le.reviewers_name),TRIM((SALT30.StrType)le.road_surface),TRIM((SALT30.StrType)le.roadway_alignment),TRIM((SALT30.StrType)le.traffic_way_description),TRIM((SALT30.StrType)le.traffic_flow),TRIM((SALT30.StrType)le.property_damage_involved),TRIM((SALT30.StrType)le.property_damage_description1),TRIM((SALT30.StrType)le.property_damage_description2),TRIM((SALT30.StrType)le.property_damage_estimate1),TRIM((SALT30.StrType)le.property_damage_estimate2),TRIM((SALT30.StrType)le.incident_damage_over_limit),TRIM((SALT30.StrType)le.property_owner_notified),TRIM((SALT30.StrType)le.government_property),TRIM((SALT30.StrType)le.accident_condition),TRIM((SALT30.StrType)le.unusual_road_condition1),TRIM((SALT30.StrType)le.unusual_road_condition2),TRIM((SALT30.StrType)le.number_of_lanes),TRIM((SALT30.StrType)le.divided_highway),TRIM((SALT30.StrType)le.most_harmful_event),TRIM((SALT30.StrType)le.second_harmful_event),TRIM((SALT30.StrType)le.ems_notified_date),TRIM((SALT30.StrType)le.ems_arrival_date),TRIM((SALT30.StrType)le.hospital_arrival_date),TRIM((SALT30.StrType)le.injured_taken_by),TRIM((SALT30.StrType)le.injured_taken_to),TRIM((SALT30.StrType)le.incident_transported_for_medical_care),TRIM((SALT30.StrType)le.photographs_taken),TRIM((SALT30.StrType)le.photographed_by),TRIM((SALT30.StrType)le.photographer_id),TRIM((SALT30.StrType)le.photography_agency_name),TRIM((SALT30.StrType)le.agency_name),TRIM((SALT30.StrType)le.judicial_district),TRIM((SALT30.StrType)le.precinct),TRIM((SALT30.StrType)le.beat),TRIM((SALT30.StrType)le.location_type),TRIM((SALT30.StrType)le.shoulder_type),TRIM((SALT30.StrType)le.investigation_complete),TRIM((SALT30.StrType)le.investigation_not_complete_why),TRIM((SALT30.StrType)le.investigating_officer_name),TRIM((SALT30.StrType)le.investigation_notification_issued),TRIM((SALT30.StrType)le.agency_type),TRIM((SALT30.StrType)le.no_injury_tow_involved),TRIM((SALT30.StrType)le.injury_tow_involved),TRIM((SALT30.StrType)le.lars_code1),TRIM((SALT30.StrType)le.lars_code2),TRIM((SALT30.StrType)le.private_property_incident),TRIM((SALT30.StrType)le.accident_involvement),TRIM((SALT30.StrType)le.local_use),TRIM((SALT30.StrType)le.street_prefix),TRIM((SALT30.StrType)le.street_suffix),TRIM((SALT30.StrType)le.toll_road),TRIM((SALT30.StrType)le.street_description),TRIM((SALT30.StrType)le.cross_street_address_number),TRIM((SALT30.StrType)le.cross_street_prefix),TRIM((SALT30.StrType)le.cross_street_suffix),TRIM((SALT30.StrType)le.report_complete),TRIM((SALT30.StrType)le.dispatch_notified),TRIM((SALT30.StrType)le.counter_report),TRIM((SALT30.StrType)le.road_type),TRIM((SALT30.StrType)le.agency_code),TRIM((SALT30.StrType)le.public_property_employee),TRIM((SALT30.StrType)le.bridge_related),TRIM((SALT30.StrType)le.ramp_indicator),TRIM((SALT30.StrType)le.to_or_from_location),TRIM((SALT30.StrType)le.complaint_number),TRIM((SALT30.StrType)le.school_zone_related),TRIM((SALT30.StrType)le.notify_dot_maintenance),TRIM((SALT30.StrType)le.special_location),TRIM((SALT30.StrType)le.route_segment),TRIM((SALT30.StrType)le.route_sign),TRIM((SALT30.StrType)le.route_category_street),TRIM((SALT30.StrType)le.route_category_cross_street),TRIM((SALT30.StrType)le.route_category_next_street),TRIM((SALT30.StrType)le.lane_closed),TRIM((SALT30.StrType)le.lane_closure_direction),TRIM((SALT30.StrType)le.lane_direction),TRIM((SALT30.StrType)le.traffic_detoured),TRIM((SALT30.StrType)le.time_closed),TRIM((SALT30.StrType)le.pedestrian_signals),TRIM((SALT30.StrType)le.work_zone_speed_limit),TRIM((SALT30.StrType)le.work_zone_shoulder_median),TRIM((SALT30.StrType)le.work_zone_intermittent_moving),TRIM((SALT30.StrType)le.work_zone_flagger_control),TRIM((SALT30.StrType)le.special_work_zone_characteristics),TRIM((SALT30.StrType)le.lane_number),TRIM((SALT30.StrType)le.offset_distance_feet),TRIM((SALT30.StrType)le.offset_distance_miles),TRIM((SALT30.StrType)le.offset_direction),TRIM((SALT30.StrType)le.asru_code),TRIM((SALT30.StrType)le.mp_grid),TRIM((SALT30.StrType)le.number_of_qualifying_units),TRIM((SALT30.StrType)le.number_of_hazmat_vehicles),TRIM((SALT30.StrType)le.number_of_buses_involved),TRIM((SALT30.StrType)le.number_taken_to_treatment),TRIM((SALT30.StrType)le.number_vehicles_towed),TRIM((SALT30.StrType)le.vehicle_at_fault_unit_number),TRIM((SALT30.StrType)le.time_officer_cleared_scene),TRIM((SALT30.StrType)le.total_minutes_on_scene),TRIM((SALT30.StrType)le.motorists_report),TRIM((SALT30.StrType)le.fatality_involved),TRIM((SALT30.StrType)le.local_dot_index_number),TRIM((SALT30.StrType)le.dor_number),TRIM((SALT30.StrType)le.hospital_code),TRIM((SALT30.StrType)le.special_jurisdiction),TRIM((SALT30.StrType)le.document_type),TRIM((SALT30.StrType)le.distance_was_measured),TRIM((SALT30.StrType)le.street_orientation),TRIM((SALT30.StrType)le.intersecting_route_segment),TRIM((SALT30.StrType)le.primary_fault_indicator),TRIM((SALT30.StrType)le.first_harmful_event_pedestrian),TRIM((SALT30.StrType)le.reference_markers),TRIM((SALT30.StrType)le.other_officer_on_scene),TRIM((SALT30.StrType)le.other_officer_badge_number),TRIM((SALT30.StrType)le.supplemental_report),TRIM((SALT30.StrType)le.supplemental_type),TRIM((SALT30.StrType)le.amended_report),TRIM((SALT30.StrType)le.corrected_report),TRIM((SALT30.StrType)le.state_highway_related),TRIM((SALT30.StrType)le.roadway_lighting_condition),TRIM((SALT30.StrType)le.vendor_reference_number),TRIM((SALT30.StrType)le.duplicate_copy_unit_number),TRIM((SALT30.StrType)le.other_city_agency_description),TRIM((SALT30.StrType)le.notifcation_description),TRIM((SALT30.StrType)le.primary_collision_improper_driving_description),TRIM((SALT30.StrType)le.weather_other_description),TRIM((SALT30.StrType)le.crash_type_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_animal_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_fixed_object_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_other_object_description),TRIM((SALT30.StrType)le.other_investigation_time),TRIM((SALT30.StrType)le.milepost_detail),TRIM((SALT30.StrType)le.utility_pole_number1),TRIM((SALT30.StrType)le.utility_pole_number2),TRIM((SALT30.StrType)le.utility_pole_number3),TRIM((SALT30.StrType)le.person_id),TRIM((SALT30.StrType)le.person_number),TRIM((SALT30.StrType)le.vehicle_unit_number),TRIM((SALT30.StrType)le.sex),TRIM((SALT30.StrType)le.person_type),TRIM((SALT30.StrType)le.injury_status),TRIM((SALT30.StrType)le.occupant_vehicle_unit_number),TRIM((SALT30.StrType)le.seating_position1),TRIM((SALT30.StrType)le.safety_equipment_restraint1),TRIM((SALT30.StrType)le.safety_equipment_restraint2),TRIM((SALT30.StrType)le.safety_equipment_helmet),TRIM((SALT30.StrType)le.air_bag_deployed),TRIM((SALT30.StrType)le.ejection),TRIM((SALT30.StrType)le.drivers_license_jurisdiction),TRIM((SALT30.StrType)le.dl_number_class),TRIM((SALT30.StrType)le.dl_number_cdl),TRIM((SALT30.StrType)le.dl_number_endorsements),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash1),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash2),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash3),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash4),TRIM((SALT30.StrType)le.violation_codes),TRIM((SALT30.StrType)le.condition_at_time_of_crash1),TRIM((SALT30.StrType)le.condition_at_time_of_crash2),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use),TRIM((SALT30.StrType)le.alcohol_test_status),TRIM((SALT30.StrType)le.alcohol_test_type),TRIM((SALT30.StrType)le.alcohol_test_result),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use),TRIM((SALT30.StrType)le.drug_test_given),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash1),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash2),TRIM((SALT30.StrType)le.non_motorist_actions_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_location_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_safety_equipment1),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.driver_license_restrictions1),TRIM((SALT30.StrType)le.drug_test_type),TRIM((SALT30.StrType)le.drug_test_result1),TRIM((SALT30.StrType)le.drug_test_result2),TRIM((SALT30.StrType)le.drug_test_result3),TRIM((SALT30.StrType)le.drug_test_result4),TRIM((SALT30.StrType)le.injury_area),TRIM((SALT30.StrType)le.injury_description),TRIM((SALT30.StrType)le.motorcyclist_head_injury),TRIM((SALT30.StrType)le.party_id),TRIM((SALT30.StrType)le.same_as_driver),TRIM((SALT30.StrType)le.address_same_as_driver),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.name_suffx),TRIM((SALT30.StrType)le.date_of_birth),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip_code),TRIM((SALT30.StrType)le.home_phone),TRIM((SALT30.StrType)le.business_phone),TRIM((SALT30.StrType)le.insurance_company),TRIM((SALT30.StrType)le.insurance_company_phone_number),TRIM((SALT30.StrType)le.insurance_policy_number),TRIM((SALT30.StrType)le.insurance_effective_date),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.drivers_license_number),TRIM((SALT30.StrType)le.drivers_license_expiration),TRIM((SALT30.StrType)le.eye_color),TRIM((SALT30.StrType)le.hair_color),TRIM((SALT30.StrType)le.height),TRIM((SALT30.StrType)le.weight),TRIM((SALT30.StrType)le.race),TRIM((SALT30.StrType)le.pedestrian_cyclist_visibility),TRIM((SALT30.StrType)le.first_aid_by),TRIM((SALT30.StrType)le.person_first_aid_party_type),TRIM((SALT30.StrType)le.person_first_aid_party_type_description),TRIM((SALT30.StrType)le.deceased_at_scene),TRIM((SALT30.StrType)le.death_date),TRIM((SALT30.StrType)le.death_time),TRIM((SALT30.StrType)le.extricated),TRIM((SALT30.StrType)le.alcohol_drug_use),TRIM((SALT30.StrType)le.physical_defects),TRIM((SALT30.StrType)le.driver_residence),TRIM((SALT30.StrType)le.id_type),TRIM((SALT30.StrType)le.proof_of_insurance),TRIM((SALT30.StrType)le.insurance_expired),TRIM((SALT30.StrType)le.insurance_exempt),TRIM((SALT30.StrType)le.insurance_type),TRIM((SALT30.StrType)le.violent_crime_victim_notified),TRIM((SALT30.StrType)le.insurance_company_code),TRIM((SALT30.StrType)le.refused_medical_treatment),TRIM((SALT30.StrType)le.safety_equipment_available_or_used),TRIM((SALT30.StrType)le.apartment_number),TRIM((SALT30.StrType)le.licensed_driver),TRIM((SALT30.StrType)le.physical_emotional_status),TRIM((SALT30.StrType)le.driver_presence),TRIM((SALT30.StrType)le.ejection_path),TRIM((SALT30.StrType)le.state_person_id),TRIM((SALT30.StrType)le.contributed_to_collision),TRIM((SALT30.StrType)le.person_transported_for_medical_care),TRIM((SALT30.StrType)le.transported_by_agency_type),TRIM((SALT30.StrType)le.transported_to),TRIM((SALT30.StrType)le.non_motorist_driver_license_number),TRIM((SALT30.StrType)le.air_bag_type),TRIM((SALT30.StrType)le.cell_phone_use),TRIM((SALT30.StrType)le.driver_license_restriction_compliance),TRIM((SALT30.StrType)le.driver_license_endorsement_compliance),TRIM((SALT30.StrType)le.driver_license_compliance),TRIM((SALT30.StrType)le.contributing_circumstances_p1),TRIM((SALT30.StrType)le.contributing_circumstances_p2),TRIM((SALT30.StrType)le.contributing_circumstances_p3),TRIM((SALT30.StrType)le.contributing_circumstances_p4),TRIM((SALT30.StrType)le.passenger_number),TRIM((SALT30.StrType)le.person_deleted),TRIM((SALT30.StrType)le.owner_lessee),TRIM((SALT30.StrType)le.driver_charged),TRIM((SALT30.StrType)le.motorcycle_eye_protection),TRIM((SALT30.StrType)le.motorcycle_long_sleeves),TRIM((SALT30.StrType)le.motorcycle_long_pants),TRIM((SALT30.StrType)le.motorcycle_over_ankle_boots),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident2),TRIM((SALT30.StrType)le.alcohol_drug_test_given),TRIM((SALT30.StrType)le.alcohol_drug_test_type),TRIM((SALT30.StrType)le.alcohol_drug_test_result),TRIM((SALT30.StrType)le.vin),TRIM((SALT30.StrType)le.vin_status),TRIM((SALT30.StrType)le.damaged_areas_derived1),TRIM((SALT30.StrType)le.damaged_areas_derived2),TRIM((SALT30.StrType)le.airbags_deployed_derived),TRIM((SALT30.StrType)le.vehicle_towed_derived),TRIM((SALT30.StrType)le.unit_type),TRIM((SALT30.StrType)le.unit_number),TRIM((SALT30.StrType)le.registration_state),TRIM((SALT30.StrType)le.registration_year),TRIM((SALT30.StrType)le.license_plate),TRIM((SALT30.StrType)le.make),TRIM((SALT30.StrType)le.model_yr),TRIM((SALT30.StrType)le.model),TRIM((SALT30.StrType)le.body_type_category),TRIM((SALT30.StrType)le.total_occupants_in_vehicle),TRIM((SALT30.StrType)le.special_function_in_transport),TRIM((SALT30.StrType)le.special_function_in_transport_other_unit),TRIM((SALT30.StrType)le.emergency_use),TRIM((SALT30.StrType)le.posted_satutory_speed_limit),TRIM((SALT30.StrType)le.direction_of_travel_before_crash),TRIM((SALT30.StrType)le.trafficway_description),TRIM((SALT30.StrType)le.traffic_control_device_type),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior1),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior2),TRIM((SALT30.StrType)le.impact_area1),TRIM((SALT30.StrType)le.impact_area2),TRIM((SALT30.StrType)le.event_sequence1),TRIM((SALT30.StrType)le.event_sequence2),TRIM((SALT30.StrType)le.event_sequence3),TRIM((SALT30.StrType)le.event_sequence4),TRIM((SALT30.StrType)le.most_harmful_event_for_vehicle),TRIM((SALT30.StrType)le.bus_use),TRIM((SALT30.StrType)le.vehicle_hit_and_run),TRIM((SALT30.StrType)le.vehicle_towed),TRIM((SALT30.StrType)le.contributing_circumstances_v1),TRIM((SALT30.StrType)le.contributing_circumstances_v2),TRIM((SALT30.StrType)le.contributing_circumstances_v3),TRIM((SALT30.StrType)le.contributing_circumstances_v4),TRIM((SALT30.StrType)le.on_street),TRIM((SALT30.StrType)le.vehicle_color),TRIM((SALT30.StrType)le.estimated_speed),TRIM((SALT30.StrType)le.accident_investigation_site),TRIM((SALT30.StrType)le.car_fire),TRIM((SALT30.StrType)le.vehicle_damage_amount),TRIM((SALT30.StrType)le.contributing_factors1),TRIM((SALT30.StrType)le.contributing_factors2),TRIM((SALT30.StrType)le.contributing_factors3),TRIM((SALT30.StrType)le.contributing_factors4),TRIM((SALT30.StrType)le.other_contributing_factors1),TRIM((SALT30.StrType)le.other_contributing_factors2),TRIM((SALT30.StrType)le.other_contributing_factors3),TRIM((SALT30.StrType)le.vision_obscured1),TRIM((SALT30.StrType)le.vision_obscured2),TRIM((SALT30.StrType)le.vehicle_on_road),TRIM((SALT30.StrType)le.ran_off_road),TRIM((SALT30.StrType)le.skidding_occurred),TRIM((SALT30.StrType)le.vehicle_incident_location1),TRIM((SALT30.StrType)le.vehicle_incident_location2),TRIM((SALT30.StrType)le.vehicle_incident_location3),TRIM((SALT30.StrType)le.vehicle_disabled),TRIM((SALT30.StrType)le.vehicle_removed_to),TRIM((SALT30.StrType)le.removed_by),TRIM((SALT30.StrType)le.tow_requested_by_driver),TRIM((SALT30.StrType)le.solicitation),TRIM((SALT30.StrType)le.other_unit_vehicle_damage_amount),TRIM((SALT30.StrType)le.other_unit_model_year),TRIM((SALT30.StrType)le.other_unit_make),TRIM((SALT30.StrType)le.other_unit_model),TRIM((SALT30.StrType)le.other_unit_vin),TRIM((SALT30.StrType)le.other_unit_vin_status),TRIM((SALT30.StrType)le.other_unit_body_type_category),TRIM((SALT30.StrType)le.other_unit_registration_state),TRIM((SALT30.StrType)le.other_unit_registration_year),TRIM((SALT30.StrType)le.other_unit_license_plate),TRIM((SALT30.StrType)le.other_unit_color),TRIM((SALT30.StrType)le.other_unit_type),TRIM((SALT30.StrType)le.damaged_areas1),TRIM((SALT30.StrType)le.damaged_areas2),TRIM((SALT30.StrType)le.parked_vehicle),TRIM((SALT30.StrType)le.damage_rating1),TRIM((SALT30.StrType)le.damage_rating2),TRIM((SALT30.StrType)le.vehicle_inventoried),TRIM((SALT30.StrType)le.vehicle_defect_apparent),TRIM((SALT30.StrType)le.defect_may_have_contributed1),TRIM((SALT30.StrType)le.defect_may_have_contributed2),TRIM((SALT30.StrType)le.registration_expiration),TRIM((SALT30.StrType)le.owner_driver_type),TRIM((SALT30.StrType)le.make_code),TRIM((SALT30.StrType)le.number_trailing_units),TRIM((SALT30.StrType)le.vehicle_position),TRIM((SALT30.StrType)le.vehicle_type),TRIM((SALT30.StrType)le.motorcycle_engine_size),TRIM((SALT30.StrType)le.motorcycle_driver_educated),TRIM((SALT30.StrType)le.motorcycle_helmet_type),TRIM((SALT30.StrType)le.motorcycle_passenger),TRIM((SALT30.StrType)le.motorcycle_helmet_stayed_on),TRIM((SALT30.StrType)le.motorcycle_helmet_dot_snell),TRIM((SALT30.StrType)le.motorcycle_saddlebag_trunk),TRIM((SALT30.StrType)le.motorcycle_trailer),TRIM((SALT30.StrType)le.pedacycle_passenger),TRIM((SALT30.StrType)le.pedacycle_headlights),TRIM((SALT30.StrType)le.pedacycle_helmet),TRIM((SALT30.StrType)le.pedacycle_rear_reflectors),TRIM((SALT30.StrType)le.cdl_required),TRIM((SALT30.StrType)le.truck_bus_supplement_required),TRIM((SALT30.StrType)le.unit_damage_amount),TRIM((SALT30.StrType)le.airbag_switch),TRIM((SALT30.StrType)le.underride_override_damage),TRIM((SALT30.StrType)le.vehicle_attachment),TRIM((SALT30.StrType)le.action_on_impact),TRIM((SALT30.StrType)le.speed_detection_method),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_from),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_to),TRIM((SALT30.StrType)le.vehicle_use),TRIM((SALT30.StrType)le.department_unit_number),TRIM((SALT30.StrType)le.equipment_in_use_at_time_of_accident),TRIM((SALT30.StrType)le.actions_of_police_vehicle),TRIM((SALT30.StrType)le.vehicle_command_id),TRIM((SALT30.StrType)le.traffic_control_device_inoperative),TRIM((SALT30.StrType)le.direction_of_impact1),TRIM((SALT30.StrType)le.direction_of_impact2),TRIM((SALT30.StrType)le.ran_off_road_direction),TRIM((SALT30.StrType)le.vin_other_unit_number),TRIM((SALT30.StrType)le.damaged_area_generic),TRIM((SALT30.StrType)le.vision_obscured_description),TRIM((SALT30.StrType)le.inattention_description),TRIM((SALT30.StrType)le.contributing_circumstances_defect_description),TRIM((SALT30.StrType)le.contributing_circumstances_other_descriptioin),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior_other_description),TRIM((SALT30.StrType)le.vehicle_special_use),TRIM((SALT30.StrType)le.vehicle_type_extended1),TRIM((SALT30.StrType)le.vehicle_type_extended2),TRIM((SALT30.StrType)le.fixed_object_direction1),TRIM((SALT30.StrType)le.fixed_object_direction2),TRIM((SALT30.StrType)le.fixed_object_direction3),TRIM((SALT30.StrType)le.fixed_object_direction4),TRIM((SALT30.StrType)le.vehicle_left_at_scene),TRIM((SALT30.StrType)le.vehicle_impounded),TRIM((SALT30.StrType)le.vehicle_driven_from_scene),TRIM((SALT30.StrType)le.on_cross_street),TRIM((SALT30.StrType)le.actions_of_police_vehicle_description),TRIM((SALT30.StrType)le.vehicle_seg),TRIM((SALT30.StrType)le.vehicle_seg_type),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.body_style_code),TRIM((SALT30.StrType)le.engine_size),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.number_of_driving_wheels),TRIM((SALT30.StrType)le.steering_type),TRIM((SALT30.StrType)le.vina_series),TRIM((SALT30.StrType)le.vina_model),TRIM((SALT30.StrType)le.vina_make),TRIM((SALT30.StrType)le.vina_body_style),TRIM((SALT30.StrType)le.make_description),TRIM((SALT30.StrType)le.model_description),TRIM((SALT30.StrType)le.series_description),TRIM((SALT30.StrType)le.car_cylinders),TRIM((SALT30.StrType)le.other_vehicle_seg),TRIM((SALT30.StrType)le.other_vehicle_seg_type),TRIM((SALT30.StrType)le.other_model_year),TRIM((SALT30.StrType)le.other_body_style_code),TRIM((SALT30.StrType)le.other_engine_size),TRIM((SALT30.StrType)le.other_fuel_code),TRIM((SALT30.StrType)le.other_number_of_driving_wheels),TRIM((SALT30.StrType)le.other_steering_type),TRIM((SALT30.StrType)le.other_vina_series),TRIM((SALT30.StrType)le.other_vina_model),TRIM((SALT30.StrType)le.other_vina_make),TRIM((SALT30.StrType)le.other_vina_body_style),TRIM((SALT30.StrType)le.other_make_description),TRIM((SALT30.StrType)le.other_model_description),TRIM((SALT30.StrType)le.other_series_description),TRIM((SALT30.StrType)le.other_car_cylinders),TRIM((SALT30.StrType)le.report_has_coversheet),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.z4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county_code),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.nametype),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.title2),TRIM((SALT30.StrType)le.fname2),TRIM((SALT30.StrType)le.mname2),TRIM((SALT30.StrType)le.lname2),TRIM((SALT30.StrType)le.suffix2),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use1),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use1),TRIM((SALT30.StrType)le.ems_notified_time),TRIM((SALT30.StrType)le.ems_arrival_time),TRIM((SALT30.StrType)le.avoidance_maneuver2),TRIM((SALT30.StrType)le.avoidance_maneuver3),TRIM((SALT30.StrType)le.avoidance_maneuver4),TRIM((SALT30.StrType)le.damaged_areas_severity1),TRIM((SALT30.StrType)le.damaged_areas_severity2),TRIM((SALT30.StrType)le.vehicle_outside_city_indicator),TRIM((SALT30.StrType)le.vehicle_outside_city_distance_miles),TRIM((SALT30.StrType)le.vehicle_outside_city_direction),TRIM((SALT30.StrType)le.vehicle_crash_cityplace),TRIM((SALT30.StrType)le.insurance_company_standardized),TRIM((SALT30.StrType)le.insurance_expiration_date),TRIM((SALT30.StrType)le.insurance_policy_holder),TRIM((SALT30.StrType)le.is_tag_converted),TRIM((SALT30.StrType)le.vin_original),TRIM((SALT30.StrType)le.make_original),TRIM((SALT30.StrType)le.model_original),TRIM((SALT30.StrType)le.model_year_original),TRIM((SALT30.StrType)le.other_unit_vin_original),TRIM((SALT30.StrType)le.other_unit_make_original),TRIM((SALT30.StrType)le.other_unit_model_original),TRIM((SALT30.StrType)le.other_unit_model_year_original),TRIM((SALT30.StrType)le.source_id),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.initial_point_of_contact),TRIM((SALT30.StrType)le.vehicle_driveable),TRIM((SALT30.StrType)le.drivers_license_type),TRIM((SALT30.StrType)le.alcohol_test_type_refused),TRIM((SALT30.StrType)le.alcohol_test_type_not_offered),TRIM((SALT30.StrType)le.alcohol_test_type_field),TRIM((SALT30.StrType)le.alcohol_test_type_pbt),TRIM((SALT30.StrType)le.alcohol_test_type_breath),TRIM((SALT30.StrType)le.alcohol_test_type_blood),TRIM((SALT30.StrType)le.alcohol_test_type_urine),TRIM((SALT30.StrType)le.trapped),TRIM((SALT30.StrType)le.dl_number_cdl_endorsements),TRIM((SALT30.StrType)le.dl_number_cdl_restrictions),TRIM((SALT30.StrType)le.dl_number_cdl_exempt),TRIM((SALT30.StrType)le.dl_number_cdl_medical_card),TRIM((SALT30.StrType)le.interlock_device_in_use),TRIM((SALT30.StrType)le.drug_test_type_blood),TRIM((SALT30.StrType)le.drug_test_type_urine),TRIM((SALT30.StrType)le.traffic_control_condition),TRIM((SALT30.StrType)le.intersection_related),TRIM((SALT30.StrType)le.special_study_local),TRIM((SALT30.StrType)le.special_study_state),TRIM((SALT30.StrType)le.off_road_vehicle_involved),TRIM((SALT30.StrType)le.location_type2),TRIM((SALT30.StrType)le.speed_limit_posted),TRIM((SALT30.StrType)le.traffic_control_damage_notify_date),TRIM((SALT30.StrType)le.traffic_control_damage_notify_time),TRIM((SALT30.StrType)le.traffic_control_damage_notify_name),TRIM((SALT30.StrType)le.public_property_damaged),TRIM((SALT30.StrType)le.replacement_report),TRIM((SALT30.StrType)le.deleted_report),TRIM((SALT30.StrType)le.next_street_prefix),TRIM((SALT30.StrType)le.violator_name),TRIM((SALT30.StrType)le.type_hazardous),TRIM((SALT30.StrType)le.type_other),TRIM((SALT30.StrType)le.unit_type_and_axles1),TRIM((SALT30.StrType)le.unit_type_and_axles2),TRIM((SALT30.StrType)le.unit_type_and_axles3),TRIM((SALT30.StrType)le.unit_type_and_axles4),TRIM((SALT30.StrType)le.incident_damage_amount),TRIM((SALT30.StrType)le.dot_use),TRIM((SALT30.StrType)le.number_of_persons_involved),TRIM((SALT30.StrType)le.unusual_road_condition_other_description),TRIM((SALT30.StrType)le.number_of_narrative_sections),TRIM((SALT30.StrType)le.cad_number),TRIM((SALT30.StrType)le.visibility),TRIM((SALT30.StrType)le.accident_at_intersection),TRIM((SALT30.StrType)le.accident_not_at_intersection),TRIM((SALT30.StrType)le.first_harmful_event_within_interchange),TRIM((SALT30.StrType)le.injury_involved),TRIM((SALT30.StrType)le.citation_status),TRIM((SALT30.StrType)le.commercial_vehicle),TRIM((SALT30.StrType)le.not_in_transport),TRIM((SALT30.StrType)le.other_unit_number),TRIM((SALT30.StrType)le.other_unit_length),TRIM((SALT30.StrType)le.other_unit_axles),TRIM((SALT30.StrType)le.other_unit_plate_expiration),TRIM((SALT30.StrType)le.other_unit_permanent_registration),TRIM((SALT30.StrType)le.other_unit_model_year2),TRIM((SALT30.StrType)le.other_unit_make2),TRIM((SALT30.StrType)le.other_unit_vin2),TRIM((SALT30.StrType)le.other_unit_registration_state2),TRIM((SALT30.StrType)le.other_unit_registration_year2),TRIM((SALT30.StrType)le.other_unit_license_plate2),TRIM((SALT30.StrType)le.other_unit_number2),TRIM((SALT30.StrType)le.other_unit_length2),TRIM((SALT30.StrType)le.other_unit_axles2),TRIM((SALT30.StrType)le.other_unit_plate_expiration2),TRIM((SALT30.StrType)le.other_unit_permanent_registration2),TRIM((SALT30.StrType)le.other_unit_type2),TRIM((SALT30.StrType)le.other_unit_model_year3),TRIM((SALT30.StrType)le.other_unit_make3),TRIM((SALT30.StrType)le.other_unit_vin3),TRIM((SALT30.StrType)le.other_unit_registration_state3),TRIM((SALT30.StrType)le.other_unit_registration_year3),TRIM((SALT30.StrType)le.other_unit_license_plate3),TRIM((SALT30.StrType)le.other_unit_number3),TRIM((SALT30.StrType)le.other_unit_length3),TRIM((SALT30.StrType)le.other_unit_axles3),TRIM((SALT30.StrType)le.other_unit_plate_expiration3),TRIM((SALT30.StrType)le.other_unit_permanent_registration3),TRIM((SALT30.StrType)le.other_unit_type3),TRIM((SALT30.StrType)le.damaged_areas3),TRIM((SALT30.StrType)le.driver_distracted_by),TRIM((SALT30.StrType)le.non_motorist_type),TRIM((SALT30.StrType)le.seating_position_row),TRIM((SALT30.StrType)le.seating_position_seat),TRIM((SALT30.StrType)le.seating_position_description),TRIM((SALT30.StrType)le.transported_id_number),TRIM((SALT30.StrType)le.witness_number),TRIM((SALT30.StrType)le.date_of_birth_derived),TRIM((SALT30.StrType)le.property_damage_id),TRIM((SALT30.StrType)le.property_owner_name),TRIM((SALT30.StrType)le.damage_description),TRIM((SALT30.StrType)le.damage_estimate),TRIM((SALT30.StrType)le.narrative),TRIM((SALT30.StrType)le.narrative_continuance),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number1),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number2),TRIM((SALT30.StrType)le.vendor_code),TRIM((SALT30.StrType)le.report_property_damage),TRIM((SALT30.StrType)le.report_collision_type),TRIM((SALT30.StrType)le.report_first_harmful_event),TRIM((SALT30.StrType)le.report_light_condition),TRIM((SALT30.StrType)le.report_weather_condition),TRIM((SALT30.StrType)le.report_road_condition),TRIM((SALT30.StrType)le.report_injury_status),TRIM((SALT30.StrType)le.report_damage_extent),TRIM((SALT30.StrType)le.report_vehicle_type),TRIM((SALT30.StrType)le.report_traffic_control_device_type),TRIM((SALT30.StrType)le.report_contributing_circumstances_v),TRIM((SALT30.StrType)le.report_vehicle_maneuver_action_prior),TRIM((SALT30.StrType)le.report_vehicle_body_type),TRIM((SALT30.StrType)le.cru_agency_name),TRIM((SALT30.StrType)le.cru_agency_id),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.vendor_report_id),TRIM((SALT30.StrType)le.is_available_for_public),TRIM((SALT30.StrType)le.has_addendum),TRIM((SALT30.StrType)le.report_agency_ori),TRIM((SALT30.StrType)le.report_status),TRIM((SALT30.StrType)le.super_report_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.report_code),TRIM((SALT30.StrType)le.report_category),TRIM((SALT30.StrType)le.report_code_desc),TRIM((SALT30.StrType)le.citation_id),TRIM((SALT30.StrType)le.creation_date),TRIM((SALT30.StrType)le.incident_id),TRIM((SALT30.StrType)le.citation_issued),TRIM((SALT30.StrType)le.citation_number1),TRIM((SALT30.StrType)le.citation_number2),TRIM((SALT30.StrType)le.section_number1),TRIM((SALT30.StrType)le.court_date),TRIM((SALT30.StrType)le.court_time),TRIM((SALT30.StrType)le.citation_detail1),TRIM((SALT30.StrType)le.local_code),TRIM((SALT30.StrType)le.violation_code1),TRIM((SALT30.StrType)le.violation_code2),TRIM((SALT30.StrType)le.multiple_charges_indicator),TRIM((SALT30.StrType)le.dui_indicator),TRIM((SALT30.StrType)le.commercial_id),TRIM((SALT30.StrType)le.vehicle_id),TRIM((SALT30.StrType)le.commercial_info_source),TRIM((SALT30.StrType)le.commercial_vehicle_type),TRIM((SALT30.StrType)le.motor_carrier_id_dot_number),TRIM((SALT30.StrType)le.motor_carrier_id_state_id),TRIM((SALT30.StrType)le.motor_carrier_id_carrier_name),TRIM((SALT30.StrType)le.motor_carrier_id_address),TRIM((SALT30.StrType)le.motor_carrier_id_city),TRIM((SALT30.StrType)le.motor_carrier_id_state),TRIM((SALT30.StrType)le.motor_carrier_id_zipcode),TRIM((SALT30.StrType)le.motor_carrier_id_commercial_indicator),TRIM((SALT30.StrType)le.carrier_id_type),TRIM((SALT30.StrType)le.carrier_unit_number),TRIM((SALT30.StrType)le.dot_permit_number),TRIM((SALT30.StrType)le.iccmc_number),TRIM((SALT30.StrType)le.mcs_vehicle_inspection),TRIM((SALT30.StrType)le.mcs_form_number),TRIM((SALT30.StrType)le.mcs_out_of_service),TRIM((SALT30.StrType)le.mcs_violation_related),TRIM((SALT30.StrType)le.number_of_axles),TRIM((SALT30.StrType)le.number_of_tires),TRIM((SALT30.StrType)le.gvw_over_10k_pounds),TRIM((SALT30.StrType)le.weight_rating),TRIM((SALT30.StrType)le.registered_gross_vehicle_weight),TRIM((SALT30.StrType)le.vehicle_length_feet),TRIM((SALT30.StrType)le.cargo_body_type),TRIM((SALT30.StrType)le.load_type),TRIM((SALT30.StrType)le.oversize_load),TRIM((SALT30.StrType)le.vehicle_configuration),TRIM((SALT30.StrType)le.trailer1_type),TRIM((SALT30.StrType)le.trailer1_length_feet),TRIM((SALT30.StrType)le.trailer1_width_feet),TRIM((SALT30.StrType)le.trailer2_type),TRIM((SALT30.StrType)le.trailer2_length_feet),TRIM((SALT30.StrType)le.trailer2_width_feet),TRIM((SALT30.StrType)le.federally_reportable),TRIM((SALT30.StrType)le.vehicle_inspection_hazmat),TRIM((SALT30.StrType)le.hazmat_form_number),TRIM((SALT30.StrType)le.hazmt_out_of_service),TRIM((SALT30.StrType)le.hazmat_violation_related),TRIM((SALT30.StrType)le.hazardous_materials_placard),TRIM((SALT30.StrType)le.hazardous_materials_class_number1),TRIM((SALT30.StrType)le.hazardous_materials_class_number2),TRIM((SALT30.StrType)le.hazmat_placard_name),TRIM((SALT30.StrType)le.hazardous_materials_released1),TRIM((SALT30.StrType)le.hazardous_materials_released2),TRIM((SALT30.StrType)le.hazardous_materials_released3),TRIM((SALT30.StrType)le.hazardous_materials_released4),TRIM((SALT30.StrType)le.commercial_event1),TRIM((SALT30.StrType)le.commercial_event2),TRIM((SALT30.StrType)le.commercial_event3),TRIM((SALT30.StrType)le.commercial_event4),TRIM((SALT30.StrType)le.recommended_driver_reexam),TRIM((SALT30.StrType)le.transporting_hazmat),TRIM((SALT30.StrType)le.liquid_hazmat_volume),TRIM((SALT30.StrType)le.oversize_vehicle),TRIM((SALT30.StrType)le.overlength_vehicle),TRIM((SALT30.StrType)le.oversize_vehicle_permitted),TRIM((SALT30.StrType)le.overlength_vehicle_permitted),TRIM((SALT30.StrType)le.carrier_phone_number),TRIM((SALT30.StrType)le.commerce_type),TRIM((SALT30.StrType)le.citation_issued_to_vehicle),TRIM((SALT30.StrType)le.cdl_class),TRIM((SALT30.StrType)le.dot_state),TRIM((SALT30.StrType)le.fire_hazardous_materials_involvement),TRIM((SALT30.StrType)le.commercial_event_description),TRIM((SALT30.StrType)le.supplment_required_hazmat_placard),TRIM((SALT30.StrType)le.other_state_number1),TRIM((SALT30.StrType)le.other_state_number2),TRIM((SALT30.StrType)le.work_type_id),TRIM((SALT30.StrType)le.report_id),TRIM((SALT30.StrType)le.agency_id),TRIM((SALT30.StrType)le.sent_to_hpcc_datetime),TRIM((SALT30.StrType)le.corrected_incident),TRIM((SALT30.StrType)le.cru_order_id),TRIM((SALT30.StrType)le.cru_sequence_nbr),TRIM((SALT30.StrType)le.loss_state_abbr),TRIM((SALT30.StrType)le.report_type_id),TRIM((SALT30.StrType)le.hash_key),TRIM((SALT30.StrType)le.case_identifier),TRIM((SALT30.StrType)le.crash_county),TRIM((SALT30.StrType)le.county_cd),TRIM((SALT30.StrType)le.crash_cityplace),TRIM((SALT30.StrType)le.crash_city),TRIM((SALT30.StrType)le.city_code),TRIM((SALT30.StrType)le.first_harmful_event),TRIM((SALT30.StrType)le.first_harmful_event_location),TRIM((SALT30.StrType)le.manner_crash_impact1),TRIM((SALT30.StrType)le.weather_condition1),TRIM((SALT30.StrType)le.weather_condition2),TRIM((SALT30.StrType)le.light_condition1),TRIM((SALT30.StrType)le.light_condition2),TRIM((SALT30.StrType)le.road_surface_condition),TRIM((SALT30.StrType)le.contributing_circumstances_environmental1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental2),TRIM((SALT30.StrType)le.contributing_circumstances_environmental3),TRIM((SALT30.StrType)le.contributing_circumstances_environmental4),TRIM((SALT30.StrType)le.contributing_circumstances_road1),TRIM((SALT30.StrType)le.contributing_circumstances_road2),TRIM((SALT30.StrType)le.contributing_circumstances_road3),TRIM((SALT30.StrType)le.contributing_circumstances_road4),TRIM((SALT30.StrType)le.relation_to_junction),TRIM((SALT30.StrType)le.intersection_type),TRIM((SALT30.StrType)le.school_bus_related),TRIM((SALT30.StrType)le.work_zone_related),TRIM((SALT30.StrType)le.work_zone_location),TRIM((SALT30.StrType)le.work_zone_type),TRIM((SALT30.StrType)le.work_zone_workers_present),TRIM((SALT30.StrType)le.work_zone_law_enforcement_present),TRIM((SALT30.StrType)le.crash_severity),TRIM((SALT30.StrType)le.number_of_vehicles),TRIM((SALT30.StrType)le.total_nonfatal_injuries),TRIM((SALT30.StrType)le.total_fatal_injuries),TRIM((SALT30.StrType)le.day_of_week),TRIM((SALT30.StrType)le.roadway_curvature),TRIM((SALT30.StrType)le.part_of_national_highway_system),TRIM((SALT30.StrType)le.roadway_functional_class),TRIM((SALT30.StrType)le.access_control),TRIM((SALT30.StrType)le.rr_crossing_id),TRIM((SALT30.StrType)le.roadway_lighting),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection1),TRIM((SALT30.StrType)le.traffic_control_type_at_intersection2),TRIM((SALT30.StrType)le.ncic_number),TRIM((SALT30.StrType)le.state_report_number),TRIM((SALT30.StrType)le.ori_number),TRIM((SALT30.StrType)le.crash_date),TRIM((SALT30.StrType)le.crash_time),TRIM((SALT30.StrType)le.lattitude),TRIM((SALT30.StrType)le.longitude),TRIM((SALT30.StrType)le.milepost1),TRIM((SALT30.StrType)le.milepost2),TRIM((SALT30.StrType)le.address_number),TRIM((SALT30.StrType)le.loss_street),TRIM((SALT30.StrType)le.loss_street_route_number),TRIM((SALT30.StrType)le.loss_street_type),TRIM((SALT30.StrType)le.loss_street_speed_limit),TRIM((SALT30.StrType)le.incident_location_indicator),TRIM((SALT30.StrType)le.loss_cross_street),TRIM((SALT30.StrType)le.loss_cross_street_route_number),TRIM((SALT30.StrType)le.loss_cross_street_intersecting_route_segment),TRIM((SALT30.StrType)le.loss_cross_street_type),TRIM((SALT30.StrType)le.loss_cross_street_speed_limit),TRIM((SALT30.StrType)le.loss_cross_street_number_of_lanes),TRIM((SALT30.StrType)le.loss_cross_street_orientation),TRIM((SALT30.StrType)le.loss_cross_street_route_sign),TRIM((SALT30.StrType)le.at_node_number),TRIM((SALT30.StrType)le.distance_from_node_feet),TRIM((SALT30.StrType)le.distance_from_node_miles),TRIM((SALT30.StrType)le.next_node_number),TRIM((SALT30.StrType)le.next_roadway_node_number),TRIM((SALT30.StrType)le.direction_of_travel),TRIM((SALT30.StrType)le.next_street),TRIM((SALT30.StrType)le.next_street_type),TRIM((SALT30.StrType)le.next_street_suffix),TRIM((SALT30.StrType)le.before_or_after_next_street),TRIM((SALT30.StrType)le.next_street_distance_feet),TRIM((SALT30.StrType)le.next_street_distance_miles),TRIM((SALT30.StrType)le.next_street_direction),TRIM((SALT30.StrType)le.next_street_route_segment),TRIM((SALT30.StrType)le.continuing_toward_street),TRIM((SALT30.StrType)le.continuing_street_suffix),TRIM((SALT30.StrType)le.continuing_street_direction),TRIM((SALT30.StrType)le.continuting_street_route_segment),TRIM((SALT30.StrType)le.city_type),TRIM((SALT30.StrType)le.outside_city_indicator),TRIM((SALT30.StrType)le.outside_city_direction),TRIM((SALT30.StrType)le.outside_city_distance_feet),TRIM((SALT30.StrType)le.outside_city_distance_miles),TRIM((SALT30.StrType)le.crash_type),TRIM((SALT30.StrType)le.motor_vehicle_involved_with),TRIM((SALT30.StrType)le.report_investigation_type),TRIM((SALT30.StrType)le.incident_hit_and_run),TRIM((SALT30.StrType)le.tow_away),TRIM((SALT30.StrType)le.date_notified),TRIM((SALT30.StrType)le.time_notified),TRIM((SALT30.StrType)le.notification_method),TRIM((SALT30.StrType)le.officer_arrival_time),TRIM((SALT30.StrType)le.officer_report_date),TRIM((SALT30.StrType)le.officer_report_time),TRIM((SALT30.StrType)le.officer_id),TRIM((SALT30.StrType)le.officer_department),TRIM((SALT30.StrType)le.officer_rank),TRIM((SALT30.StrType)le.officer_command),TRIM((SALT30.StrType)le.officer_tax_id_number),TRIM((SALT30.StrType)le.completed_report_date),TRIM((SALT30.StrType)le.supervisor_check_date),TRIM((SALT30.StrType)le.supervisor_check_time),TRIM((SALT30.StrType)le.supervisor_id),TRIM((SALT30.StrType)le.supervisor_rank),TRIM((SALT30.StrType)le.reviewers_name),TRIM((SALT30.StrType)le.road_surface),TRIM((SALT30.StrType)le.roadway_alignment),TRIM((SALT30.StrType)le.traffic_way_description),TRIM((SALT30.StrType)le.traffic_flow),TRIM((SALT30.StrType)le.property_damage_involved),TRIM((SALT30.StrType)le.property_damage_description1),TRIM((SALT30.StrType)le.property_damage_description2),TRIM((SALT30.StrType)le.property_damage_estimate1),TRIM((SALT30.StrType)le.property_damage_estimate2),TRIM((SALT30.StrType)le.incident_damage_over_limit),TRIM((SALT30.StrType)le.property_owner_notified),TRIM((SALT30.StrType)le.government_property),TRIM((SALT30.StrType)le.accident_condition),TRIM((SALT30.StrType)le.unusual_road_condition1),TRIM((SALT30.StrType)le.unusual_road_condition2),TRIM((SALT30.StrType)le.number_of_lanes),TRIM((SALT30.StrType)le.divided_highway),TRIM((SALT30.StrType)le.most_harmful_event),TRIM((SALT30.StrType)le.second_harmful_event),TRIM((SALT30.StrType)le.ems_notified_date),TRIM((SALT30.StrType)le.ems_arrival_date),TRIM((SALT30.StrType)le.hospital_arrival_date),TRIM((SALT30.StrType)le.injured_taken_by),TRIM((SALT30.StrType)le.injured_taken_to),TRIM((SALT30.StrType)le.incident_transported_for_medical_care),TRIM((SALT30.StrType)le.photographs_taken),TRIM((SALT30.StrType)le.photographed_by),TRIM((SALT30.StrType)le.photographer_id),TRIM((SALT30.StrType)le.photography_agency_name),TRIM((SALT30.StrType)le.agency_name),TRIM((SALT30.StrType)le.judicial_district),TRIM((SALT30.StrType)le.precinct),TRIM((SALT30.StrType)le.beat),TRIM((SALT30.StrType)le.location_type),TRIM((SALT30.StrType)le.shoulder_type),TRIM((SALT30.StrType)le.investigation_complete),TRIM((SALT30.StrType)le.investigation_not_complete_why),TRIM((SALT30.StrType)le.investigating_officer_name),TRIM((SALT30.StrType)le.investigation_notification_issued),TRIM((SALT30.StrType)le.agency_type),TRIM((SALT30.StrType)le.no_injury_tow_involved),TRIM((SALT30.StrType)le.injury_tow_involved),TRIM((SALT30.StrType)le.lars_code1),TRIM((SALT30.StrType)le.lars_code2),TRIM((SALT30.StrType)le.private_property_incident),TRIM((SALT30.StrType)le.accident_involvement),TRIM((SALT30.StrType)le.local_use),TRIM((SALT30.StrType)le.street_prefix),TRIM((SALT30.StrType)le.street_suffix),TRIM((SALT30.StrType)le.toll_road),TRIM((SALT30.StrType)le.street_description),TRIM((SALT30.StrType)le.cross_street_address_number),TRIM((SALT30.StrType)le.cross_street_prefix),TRIM((SALT30.StrType)le.cross_street_suffix),TRIM((SALT30.StrType)le.report_complete),TRIM((SALT30.StrType)le.dispatch_notified),TRIM((SALT30.StrType)le.counter_report),TRIM((SALT30.StrType)le.road_type),TRIM((SALT30.StrType)le.agency_code),TRIM((SALT30.StrType)le.public_property_employee),TRIM((SALT30.StrType)le.bridge_related),TRIM((SALT30.StrType)le.ramp_indicator),TRIM((SALT30.StrType)le.to_or_from_location),TRIM((SALT30.StrType)le.complaint_number),TRIM((SALT30.StrType)le.school_zone_related),TRIM((SALT30.StrType)le.notify_dot_maintenance),TRIM((SALT30.StrType)le.special_location),TRIM((SALT30.StrType)le.route_segment),TRIM((SALT30.StrType)le.route_sign),TRIM((SALT30.StrType)le.route_category_street),TRIM((SALT30.StrType)le.route_category_cross_street),TRIM((SALT30.StrType)le.route_category_next_street),TRIM((SALT30.StrType)le.lane_closed),TRIM((SALT30.StrType)le.lane_closure_direction),TRIM((SALT30.StrType)le.lane_direction),TRIM((SALT30.StrType)le.traffic_detoured),TRIM((SALT30.StrType)le.time_closed),TRIM((SALT30.StrType)le.pedestrian_signals),TRIM((SALT30.StrType)le.work_zone_speed_limit),TRIM((SALT30.StrType)le.work_zone_shoulder_median),TRIM((SALT30.StrType)le.work_zone_intermittent_moving),TRIM((SALT30.StrType)le.work_zone_flagger_control),TRIM((SALT30.StrType)le.special_work_zone_characteristics),TRIM((SALT30.StrType)le.lane_number),TRIM((SALT30.StrType)le.offset_distance_feet),TRIM((SALT30.StrType)le.offset_distance_miles),TRIM((SALT30.StrType)le.offset_direction),TRIM((SALT30.StrType)le.asru_code),TRIM((SALT30.StrType)le.mp_grid),TRIM((SALT30.StrType)le.number_of_qualifying_units),TRIM((SALT30.StrType)le.number_of_hazmat_vehicles),TRIM((SALT30.StrType)le.number_of_buses_involved),TRIM((SALT30.StrType)le.number_taken_to_treatment),TRIM((SALT30.StrType)le.number_vehicles_towed),TRIM((SALT30.StrType)le.vehicle_at_fault_unit_number),TRIM((SALT30.StrType)le.time_officer_cleared_scene),TRIM((SALT30.StrType)le.total_minutes_on_scene),TRIM((SALT30.StrType)le.motorists_report),TRIM((SALT30.StrType)le.fatality_involved),TRIM((SALT30.StrType)le.local_dot_index_number),TRIM((SALT30.StrType)le.dor_number),TRIM((SALT30.StrType)le.hospital_code),TRIM((SALT30.StrType)le.special_jurisdiction),TRIM((SALT30.StrType)le.document_type),TRIM((SALT30.StrType)le.distance_was_measured),TRIM((SALT30.StrType)le.street_orientation),TRIM((SALT30.StrType)le.intersecting_route_segment),TRIM((SALT30.StrType)le.primary_fault_indicator),TRIM((SALT30.StrType)le.first_harmful_event_pedestrian),TRIM((SALT30.StrType)le.reference_markers),TRIM((SALT30.StrType)le.other_officer_on_scene),TRIM((SALT30.StrType)le.other_officer_badge_number),TRIM((SALT30.StrType)le.supplemental_report),TRIM((SALT30.StrType)le.supplemental_type),TRIM((SALT30.StrType)le.amended_report),TRIM((SALT30.StrType)le.corrected_report),TRIM((SALT30.StrType)le.state_highway_related),TRIM((SALT30.StrType)le.roadway_lighting_condition),TRIM((SALT30.StrType)le.vendor_reference_number),TRIM((SALT30.StrType)le.duplicate_copy_unit_number),TRIM((SALT30.StrType)le.other_city_agency_description),TRIM((SALT30.StrType)le.notifcation_description),TRIM((SALT30.StrType)le.primary_collision_improper_driving_description),TRIM((SALT30.StrType)le.weather_other_description),TRIM((SALT30.StrType)le.crash_type_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_animal_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_fixed_object_description),TRIM((SALT30.StrType)le.motor_vehicle_involved_with_other_object_description),TRIM((SALT30.StrType)le.other_investigation_time),TRIM((SALT30.StrType)le.milepost_detail),TRIM((SALT30.StrType)le.utility_pole_number1),TRIM((SALT30.StrType)le.utility_pole_number2),TRIM((SALT30.StrType)le.utility_pole_number3),TRIM((SALT30.StrType)le.person_id),TRIM((SALT30.StrType)le.person_number),TRIM((SALT30.StrType)le.vehicle_unit_number),TRIM((SALT30.StrType)le.sex),TRIM((SALT30.StrType)le.person_type),TRIM((SALT30.StrType)le.injury_status),TRIM((SALT30.StrType)le.occupant_vehicle_unit_number),TRIM((SALT30.StrType)le.seating_position1),TRIM((SALT30.StrType)le.safety_equipment_restraint1),TRIM((SALT30.StrType)le.safety_equipment_restraint2),TRIM((SALT30.StrType)le.safety_equipment_helmet),TRIM((SALT30.StrType)le.air_bag_deployed),TRIM((SALT30.StrType)le.ejection),TRIM((SALT30.StrType)le.drivers_license_jurisdiction),TRIM((SALT30.StrType)le.dl_number_class),TRIM((SALT30.StrType)le.dl_number_cdl),TRIM((SALT30.StrType)le.dl_number_endorsements),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash1),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash2),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash3),TRIM((SALT30.StrType)le.driver_actions_at_time_of_crash4),TRIM((SALT30.StrType)le.violation_codes),TRIM((SALT30.StrType)le.condition_at_time_of_crash1),TRIM((SALT30.StrType)le.condition_at_time_of_crash2),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use),TRIM((SALT30.StrType)le.alcohol_test_status),TRIM((SALT30.StrType)le.alcohol_test_type),TRIM((SALT30.StrType)le.alcohol_test_result),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use),TRIM((SALT30.StrType)le.drug_test_given),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash1),TRIM((SALT30.StrType)le.non_motorist_actions_prior_to_crash2),TRIM((SALT30.StrType)le.non_motorist_actions_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_location_at_time_of_crash),TRIM((SALT30.StrType)le.non_motorist_safety_equipment1),TRIM((SALT30.StrType)le.age),TRIM((SALT30.StrType)le.driver_license_restrictions1),TRIM((SALT30.StrType)le.drug_test_type),TRIM((SALT30.StrType)le.drug_test_result1),TRIM((SALT30.StrType)le.drug_test_result2),TRIM((SALT30.StrType)le.drug_test_result3),TRIM((SALT30.StrType)le.drug_test_result4),TRIM((SALT30.StrType)le.injury_area),TRIM((SALT30.StrType)le.injury_description),TRIM((SALT30.StrType)le.motorcyclist_head_injury),TRIM((SALT30.StrType)le.party_id),TRIM((SALT30.StrType)le.same_as_driver),TRIM((SALT30.StrType)le.address_same_as_driver),TRIM((SALT30.StrType)le.last_name),TRIM((SALT30.StrType)le.first_name),TRIM((SALT30.StrType)le.middle_name),TRIM((SALT30.StrType)le.name_suffx),TRIM((SALT30.StrType)le.date_of_birth),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zip_code),TRIM((SALT30.StrType)le.home_phone),TRIM((SALT30.StrType)le.business_phone),TRIM((SALT30.StrType)le.insurance_company),TRIM((SALT30.StrType)le.insurance_company_phone_number),TRIM((SALT30.StrType)le.insurance_policy_number),TRIM((SALT30.StrType)le.insurance_effective_date),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.drivers_license_number),TRIM((SALT30.StrType)le.drivers_license_expiration),TRIM((SALT30.StrType)le.eye_color),TRIM((SALT30.StrType)le.hair_color),TRIM((SALT30.StrType)le.height),TRIM((SALT30.StrType)le.weight),TRIM((SALT30.StrType)le.race),TRIM((SALT30.StrType)le.pedestrian_cyclist_visibility),TRIM((SALT30.StrType)le.first_aid_by),TRIM((SALT30.StrType)le.person_first_aid_party_type),TRIM((SALT30.StrType)le.person_first_aid_party_type_description),TRIM((SALT30.StrType)le.deceased_at_scene),TRIM((SALT30.StrType)le.death_date),TRIM((SALT30.StrType)le.death_time),TRIM((SALT30.StrType)le.extricated),TRIM((SALT30.StrType)le.alcohol_drug_use),TRIM((SALT30.StrType)le.physical_defects),TRIM((SALT30.StrType)le.driver_residence),TRIM((SALT30.StrType)le.id_type),TRIM((SALT30.StrType)le.proof_of_insurance),TRIM((SALT30.StrType)le.insurance_expired),TRIM((SALT30.StrType)le.insurance_exempt),TRIM((SALT30.StrType)le.insurance_type),TRIM((SALT30.StrType)le.violent_crime_victim_notified),TRIM((SALT30.StrType)le.insurance_company_code),TRIM((SALT30.StrType)le.refused_medical_treatment),TRIM((SALT30.StrType)le.safety_equipment_available_or_used),TRIM((SALT30.StrType)le.apartment_number),TRIM((SALT30.StrType)le.licensed_driver),TRIM((SALT30.StrType)le.physical_emotional_status),TRIM((SALT30.StrType)le.driver_presence),TRIM((SALT30.StrType)le.ejection_path),TRIM((SALT30.StrType)le.state_person_id),TRIM((SALT30.StrType)le.contributed_to_collision),TRIM((SALT30.StrType)le.person_transported_for_medical_care),TRIM((SALT30.StrType)le.transported_by_agency_type),TRIM((SALT30.StrType)le.transported_to),TRIM((SALT30.StrType)le.non_motorist_driver_license_number),TRIM((SALT30.StrType)le.air_bag_type),TRIM((SALT30.StrType)le.cell_phone_use),TRIM((SALT30.StrType)le.driver_license_restriction_compliance),TRIM((SALT30.StrType)le.driver_license_endorsement_compliance),TRIM((SALT30.StrType)le.driver_license_compliance),TRIM((SALT30.StrType)le.contributing_circumstances_p1),TRIM((SALT30.StrType)le.contributing_circumstances_p2),TRIM((SALT30.StrType)le.contributing_circumstances_p3),TRIM((SALT30.StrType)le.contributing_circumstances_p4),TRIM((SALT30.StrType)le.passenger_number),TRIM((SALT30.StrType)le.person_deleted),TRIM((SALT30.StrType)le.owner_lessee),TRIM((SALT30.StrType)le.driver_charged),TRIM((SALT30.StrType)le.motorcycle_eye_protection),TRIM((SALT30.StrType)le.motorcycle_long_sleeves),TRIM((SALT30.StrType)le.motorcycle_long_pants),TRIM((SALT30.StrType)le.motorcycle_over_ankle_boots),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident1),TRIM((SALT30.StrType)le.contributing_circumstances_environmental_non_incident2),TRIM((SALT30.StrType)le.alcohol_drug_test_given),TRIM((SALT30.StrType)le.alcohol_drug_test_type),TRIM((SALT30.StrType)le.alcohol_drug_test_result),TRIM((SALT30.StrType)le.vin),TRIM((SALT30.StrType)le.vin_status),TRIM((SALT30.StrType)le.damaged_areas_derived1),TRIM((SALT30.StrType)le.damaged_areas_derived2),TRIM((SALT30.StrType)le.airbags_deployed_derived),TRIM((SALT30.StrType)le.vehicle_towed_derived),TRIM((SALT30.StrType)le.unit_type),TRIM((SALT30.StrType)le.unit_number),TRIM((SALT30.StrType)le.registration_state),TRIM((SALT30.StrType)le.registration_year),TRIM((SALT30.StrType)le.license_plate),TRIM((SALT30.StrType)le.make),TRIM((SALT30.StrType)le.model_yr),TRIM((SALT30.StrType)le.model),TRIM((SALT30.StrType)le.body_type_category),TRIM((SALT30.StrType)le.total_occupants_in_vehicle),TRIM((SALT30.StrType)le.special_function_in_transport),TRIM((SALT30.StrType)le.special_function_in_transport_other_unit),TRIM((SALT30.StrType)le.emergency_use),TRIM((SALT30.StrType)le.posted_satutory_speed_limit),TRIM((SALT30.StrType)le.direction_of_travel_before_crash),TRIM((SALT30.StrType)le.trafficway_description),TRIM((SALT30.StrType)le.traffic_control_device_type),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior1),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior2),TRIM((SALT30.StrType)le.impact_area1),TRIM((SALT30.StrType)le.impact_area2),TRIM((SALT30.StrType)le.event_sequence1),TRIM((SALT30.StrType)le.event_sequence2),TRIM((SALT30.StrType)le.event_sequence3),TRIM((SALT30.StrType)le.event_sequence4),TRIM((SALT30.StrType)le.most_harmful_event_for_vehicle),TRIM((SALT30.StrType)le.bus_use),TRIM((SALT30.StrType)le.vehicle_hit_and_run),TRIM((SALT30.StrType)le.vehicle_towed),TRIM((SALT30.StrType)le.contributing_circumstances_v1),TRIM((SALT30.StrType)le.contributing_circumstances_v2),TRIM((SALT30.StrType)le.contributing_circumstances_v3),TRIM((SALT30.StrType)le.contributing_circumstances_v4),TRIM((SALT30.StrType)le.on_street),TRIM((SALT30.StrType)le.vehicle_color),TRIM((SALT30.StrType)le.estimated_speed),TRIM((SALT30.StrType)le.accident_investigation_site),TRIM((SALT30.StrType)le.car_fire),TRIM((SALT30.StrType)le.vehicle_damage_amount),TRIM((SALT30.StrType)le.contributing_factors1),TRIM((SALT30.StrType)le.contributing_factors2),TRIM((SALT30.StrType)le.contributing_factors3),TRIM((SALT30.StrType)le.contributing_factors4),TRIM((SALT30.StrType)le.other_contributing_factors1),TRIM((SALT30.StrType)le.other_contributing_factors2),TRIM((SALT30.StrType)le.other_contributing_factors3),TRIM((SALT30.StrType)le.vision_obscured1),TRIM((SALT30.StrType)le.vision_obscured2),TRIM((SALT30.StrType)le.vehicle_on_road),TRIM((SALT30.StrType)le.ran_off_road),TRIM((SALT30.StrType)le.skidding_occurred),TRIM((SALT30.StrType)le.vehicle_incident_location1),TRIM((SALT30.StrType)le.vehicle_incident_location2),TRIM((SALT30.StrType)le.vehicle_incident_location3),TRIM((SALT30.StrType)le.vehicle_disabled),TRIM((SALT30.StrType)le.vehicle_removed_to),TRIM((SALT30.StrType)le.removed_by),TRIM((SALT30.StrType)le.tow_requested_by_driver),TRIM((SALT30.StrType)le.solicitation),TRIM((SALT30.StrType)le.other_unit_vehicle_damage_amount),TRIM((SALT30.StrType)le.other_unit_model_year),TRIM((SALT30.StrType)le.other_unit_make),TRIM((SALT30.StrType)le.other_unit_model),TRIM((SALT30.StrType)le.other_unit_vin),TRIM((SALT30.StrType)le.other_unit_vin_status),TRIM((SALT30.StrType)le.other_unit_body_type_category),TRIM((SALT30.StrType)le.other_unit_registration_state),TRIM((SALT30.StrType)le.other_unit_registration_year),TRIM((SALT30.StrType)le.other_unit_license_plate),TRIM((SALT30.StrType)le.other_unit_color),TRIM((SALT30.StrType)le.other_unit_type),TRIM((SALT30.StrType)le.damaged_areas1),TRIM((SALT30.StrType)le.damaged_areas2),TRIM((SALT30.StrType)le.parked_vehicle),TRIM((SALT30.StrType)le.damage_rating1),TRIM((SALT30.StrType)le.damage_rating2),TRIM((SALT30.StrType)le.vehicle_inventoried),TRIM((SALT30.StrType)le.vehicle_defect_apparent),TRIM((SALT30.StrType)le.defect_may_have_contributed1),TRIM((SALT30.StrType)le.defect_may_have_contributed2),TRIM((SALT30.StrType)le.registration_expiration),TRIM((SALT30.StrType)le.owner_driver_type),TRIM((SALT30.StrType)le.make_code),TRIM((SALT30.StrType)le.number_trailing_units),TRIM((SALT30.StrType)le.vehicle_position),TRIM((SALT30.StrType)le.vehicle_type),TRIM((SALT30.StrType)le.motorcycle_engine_size),TRIM((SALT30.StrType)le.motorcycle_driver_educated),TRIM((SALT30.StrType)le.motorcycle_helmet_type),TRIM((SALT30.StrType)le.motorcycle_passenger),TRIM((SALT30.StrType)le.motorcycle_helmet_stayed_on),TRIM((SALT30.StrType)le.motorcycle_helmet_dot_snell),TRIM((SALT30.StrType)le.motorcycle_saddlebag_trunk),TRIM((SALT30.StrType)le.motorcycle_trailer),TRIM((SALT30.StrType)le.pedacycle_passenger),TRIM((SALT30.StrType)le.pedacycle_headlights),TRIM((SALT30.StrType)le.pedacycle_helmet),TRIM((SALT30.StrType)le.pedacycle_rear_reflectors),TRIM((SALT30.StrType)le.cdl_required),TRIM((SALT30.StrType)le.truck_bus_supplement_required),TRIM((SALT30.StrType)le.unit_damage_amount),TRIM((SALT30.StrType)le.airbag_switch),TRIM((SALT30.StrType)le.underride_override_damage),TRIM((SALT30.StrType)le.vehicle_attachment),TRIM((SALT30.StrType)le.action_on_impact),TRIM((SALT30.StrType)le.speed_detection_method),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_from),TRIM((SALT30.StrType)le.non_motorist_direction_of_travel_to),TRIM((SALT30.StrType)le.vehicle_use),TRIM((SALT30.StrType)le.department_unit_number),TRIM((SALT30.StrType)le.equipment_in_use_at_time_of_accident),TRIM((SALT30.StrType)le.actions_of_police_vehicle),TRIM((SALT30.StrType)le.vehicle_command_id),TRIM((SALT30.StrType)le.traffic_control_device_inoperative),TRIM((SALT30.StrType)le.direction_of_impact1),TRIM((SALT30.StrType)le.direction_of_impact2),TRIM((SALT30.StrType)le.ran_off_road_direction),TRIM((SALT30.StrType)le.vin_other_unit_number),TRIM((SALT30.StrType)le.damaged_area_generic),TRIM((SALT30.StrType)le.vision_obscured_description),TRIM((SALT30.StrType)le.inattention_description),TRIM((SALT30.StrType)le.contributing_circumstances_defect_description),TRIM((SALT30.StrType)le.contributing_circumstances_other_descriptioin),TRIM((SALT30.StrType)le.vehicle_maneuver_action_prior_other_description),TRIM((SALT30.StrType)le.vehicle_special_use),TRIM((SALT30.StrType)le.vehicle_type_extended1),TRIM((SALT30.StrType)le.vehicle_type_extended2),TRIM((SALT30.StrType)le.fixed_object_direction1),TRIM((SALT30.StrType)le.fixed_object_direction2),TRIM((SALT30.StrType)le.fixed_object_direction3),TRIM((SALT30.StrType)le.fixed_object_direction4),TRIM((SALT30.StrType)le.vehicle_left_at_scene),TRIM((SALT30.StrType)le.vehicle_impounded),TRIM((SALT30.StrType)le.vehicle_driven_from_scene),TRIM((SALT30.StrType)le.on_cross_street),TRIM((SALT30.StrType)le.actions_of_police_vehicle_description),TRIM((SALT30.StrType)le.vehicle_seg),TRIM((SALT30.StrType)le.vehicle_seg_type),TRIM((SALT30.StrType)le.model_year),TRIM((SALT30.StrType)le.body_style_code),TRIM((SALT30.StrType)le.engine_size),TRIM((SALT30.StrType)le.fuel_code),TRIM((SALT30.StrType)le.number_of_driving_wheels),TRIM((SALT30.StrType)le.steering_type),TRIM((SALT30.StrType)le.vina_series),TRIM((SALT30.StrType)le.vina_model),TRIM((SALT30.StrType)le.vina_make),TRIM((SALT30.StrType)le.vina_body_style),TRIM((SALT30.StrType)le.make_description),TRIM((SALT30.StrType)le.model_description),TRIM((SALT30.StrType)le.series_description),TRIM((SALT30.StrType)le.car_cylinders),TRIM((SALT30.StrType)le.other_vehicle_seg),TRIM((SALT30.StrType)le.other_vehicle_seg_type),TRIM((SALT30.StrType)le.other_model_year),TRIM((SALT30.StrType)le.other_body_style_code),TRIM((SALT30.StrType)le.other_engine_size),TRIM((SALT30.StrType)le.other_fuel_code),TRIM((SALT30.StrType)le.other_number_of_driving_wheels),TRIM((SALT30.StrType)le.other_steering_type),TRIM((SALT30.StrType)le.other_vina_series),TRIM((SALT30.StrType)le.other_vina_model),TRIM((SALT30.StrType)le.other_vina_make),TRIM((SALT30.StrType)le.other_vina_body_style),TRIM((SALT30.StrType)le.other_make_description),TRIM((SALT30.StrType)le.other_model_description),TRIM((SALT30.StrType)le.other_series_description),TRIM((SALT30.StrType)le.other_car_cylinders),TRIM((SALT30.StrType)le.report_has_coversheet),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.z5),TRIM((SALT30.StrType)le.z4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dpbc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county_code),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.nametype),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.suffix),TRIM((SALT30.StrType)le.title2),TRIM((SALT30.StrType)le.fname2),TRIM((SALT30.StrType)le.mname2),TRIM((SALT30.StrType)le.lname2),TRIM((SALT30.StrType)le.suffix2),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.did_score),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.bdid_score),TRIM((SALT30.StrType)le.rawaid),TRIM((SALT30.StrType)le.law_enforcement_suspects_alcohol_use1),TRIM((SALT30.StrType)le.law_enforcement_suspects_drug_use1),TRIM((SALT30.StrType)le.ems_notified_time),TRIM((SALT30.StrType)le.ems_arrival_time),TRIM((SALT30.StrType)le.avoidance_maneuver2),TRIM((SALT30.StrType)le.avoidance_maneuver3),TRIM((SALT30.StrType)le.avoidance_maneuver4),TRIM((SALT30.StrType)le.damaged_areas_severity1),TRIM((SALT30.StrType)le.damaged_areas_severity2),TRIM((SALT30.StrType)le.vehicle_outside_city_indicator),TRIM((SALT30.StrType)le.vehicle_outside_city_distance_miles),TRIM((SALT30.StrType)le.vehicle_outside_city_direction),TRIM((SALT30.StrType)le.vehicle_crash_cityplace),TRIM((SALT30.StrType)le.insurance_company_standardized),TRIM((SALT30.StrType)le.insurance_expiration_date),TRIM((SALT30.StrType)le.insurance_policy_holder),TRIM((SALT30.StrType)le.is_tag_converted),TRIM((SALT30.StrType)le.vin_original),TRIM((SALT30.StrType)le.make_original),TRIM((SALT30.StrType)le.model_original),TRIM((SALT30.StrType)le.model_year_original),TRIM((SALT30.StrType)le.other_unit_vin_original),TRIM((SALT30.StrType)le.other_unit_make_original),TRIM((SALT30.StrType)le.other_unit_model_original),TRIM((SALT30.StrType)le.other_unit_model_year_original),TRIM((SALT30.StrType)le.source_id),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.initial_point_of_contact),TRIM((SALT30.StrType)le.vehicle_driveable),TRIM((SALT30.StrType)le.drivers_license_type),TRIM((SALT30.StrType)le.alcohol_test_type_refused),TRIM((SALT30.StrType)le.alcohol_test_type_not_offered),TRIM((SALT30.StrType)le.alcohol_test_type_field),TRIM((SALT30.StrType)le.alcohol_test_type_pbt),TRIM((SALT30.StrType)le.alcohol_test_type_breath),TRIM((SALT30.StrType)le.alcohol_test_type_blood),TRIM((SALT30.StrType)le.alcohol_test_type_urine),TRIM((SALT30.StrType)le.trapped),TRIM((SALT30.StrType)le.dl_number_cdl_endorsements),TRIM((SALT30.StrType)le.dl_number_cdl_restrictions),TRIM((SALT30.StrType)le.dl_number_cdl_exempt),TRIM((SALT30.StrType)le.dl_number_cdl_medical_card),TRIM((SALT30.StrType)le.interlock_device_in_use),TRIM((SALT30.StrType)le.drug_test_type_blood),TRIM((SALT30.StrType)le.drug_test_type_urine),TRIM((SALT30.StrType)le.traffic_control_condition),TRIM((SALT30.StrType)le.intersection_related),TRIM((SALT30.StrType)le.special_study_local),TRIM((SALT30.StrType)le.special_study_state),TRIM((SALT30.StrType)le.off_road_vehicle_involved),TRIM((SALT30.StrType)le.location_type2),TRIM((SALT30.StrType)le.speed_limit_posted),TRIM((SALT30.StrType)le.traffic_control_damage_notify_date),TRIM((SALT30.StrType)le.traffic_control_damage_notify_time),TRIM((SALT30.StrType)le.traffic_control_damage_notify_name),TRIM((SALT30.StrType)le.public_property_damaged),TRIM((SALT30.StrType)le.replacement_report),TRIM((SALT30.StrType)le.deleted_report),TRIM((SALT30.StrType)le.next_street_prefix),TRIM((SALT30.StrType)le.violator_name),TRIM((SALT30.StrType)le.type_hazardous),TRIM((SALT30.StrType)le.type_other),TRIM((SALT30.StrType)le.unit_type_and_axles1),TRIM((SALT30.StrType)le.unit_type_and_axles2),TRIM((SALT30.StrType)le.unit_type_and_axles3),TRIM((SALT30.StrType)le.unit_type_and_axles4),TRIM((SALT30.StrType)le.incident_damage_amount),TRIM((SALT30.StrType)le.dot_use),TRIM((SALT30.StrType)le.number_of_persons_involved),TRIM((SALT30.StrType)le.unusual_road_condition_other_description),TRIM((SALT30.StrType)le.number_of_narrative_sections),TRIM((SALT30.StrType)le.cad_number),TRIM((SALT30.StrType)le.visibility),TRIM((SALT30.StrType)le.accident_at_intersection),TRIM((SALT30.StrType)le.accident_not_at_intersection),TRIM((SALT30.StrType)le.first_harmful_event_within_interchange),TRIM((SALT30.StrType)le.injury_involved),TRIM((SALT30.StrType)le.citation_status),TRIM((SALT30.StrType)le.commercial_vehicle),TRIM((SALT30.StrType)le.not_in_transport),TRIM((SALT30.StrType)le.other_unit_number),TRIM((SALT30.StrType)le.other_unit_length),TRIM((SALT30.StrType)le.other_unit_axles),TRIM((SALT30.StrType)le.other_unit_plate_expiration),TRIM((SALT30.StrType)le.other_unit_permanent_registration),TRIM((SALT30.StrType)le.other_unit_model_year2),TRIM((SALT30.StrType)le.other_unit_make2),TRIM((SALT30.StrType)le.other_unit_vin2),TRIM((SALT30.StrType)le.other_unit_registration_state2),TRIM((SALT30.StrType)le.other_unit_registration_year2),TRIM((SALT30.StrType)le.other_unit_license_plate2),TRIM((SALT30.StrType)le.other_unit_number2),TRIM((SALT30.StrType)le.other_unit_length2),TRIM((SALT30.StrType)le.other_unit_axles2),TRIM((SALT30.StrType)le.other_unit_plate_expiration2),TRIM((SALT30.StrType)le.other_unit_permanent_registration2),TRIM((SALT30.StrType)le.other_unit_type2),TRIM((SALT30.StrType)le.other_unit_model_year3),TRIM((SALT30.StrType)le.other_unit_make3),TRIM((SALT30.StrType)le.other_unit_vin3),TRIM((SALT30.StrType)le.other_unit_registration_state3),TRIM((SALT30.StrType)le.other_unit_registration_year3),TRIM((SALT30.StrType)le.other_unit_license_plate3),TRIM((SALT30.StrType)le.other_unit_number3),TRIM((SALT30.StrType)le.other_unit_length3),TRIM((SALT30.StrType)le.other_unit_axles3),TRIM((SALT30.StrType)le.other_unit_plate_expiration3),TRIM((SALT30.StrType)le.other_unit_permanent_registration3),TRIM((SALT30.StrType)le.other_unit_type3),TRIM((SALT30.StrType)le.damaged_areas3),TRIM((SALT30.StrType)le.driver_distracted_by),TRIM((SALT30.StrType)le.non_motorist_type),TRIM((SALT30.StrType)le.seating_position_row),TRIM((SALT30.StrType)le.seating_position_seat),TRIM((SALT30.StrType)le.seating_position_description),TRIM((SALT30.StrType)le.transported_id_number),TRIM((SALT30.StrType)le.witness_number),TRIM((SALT30.StrType)le.date_of_birth_derived),TRIM((SALT30.StrType)le.property_damage_id),TRIM((SALT30.StrType)le.property_owner_name),TRIM((SALT30.StrType)le.damage_description),TRIM((SALT30.StrType)le.damage_estimate),TRIM((SALT30.StrType)le.narrative),TRIM((SALT30.StrType)le.narrative_continuance),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number1),TRIM((SALT30.StrType)le.hazardous_materials_hazmat_placard_number2),TRIM((SALT30.StrType)le.vendor_code),TRIM((SALT30.StrType)le.report_property_damage),TRIM((SALT30.StrType)le.report_collision_type),TRIM((SALT30.StrType)le.report_first_harmful_event),TRIM((SALT30.StrType)le.report_light_condition),TRIM((SALT30.StrType)le.report_weather_condition),TRIM((SALT30.StrType)le.report_road_condition),TRIM((SALT30.StrType)le.report_injury_status),TRIM((SALT30.StrType)le.report_damage_extent),TRIM((SALT30.StrType)le.report_vehicle_type),TRIM((SALT30.StrType)le.report_traffic_control_device_type),TRIM((SALT30.StrType)le.report_contributing_circumstances_v),TRIM((SALT30.StrType)le.report_vehicle_maneuver_action_prior),TRIM((SALT30.StrType)le.report_vehicle_body_type),TRIM((SALT30.StrType)le.cru_agency_name),TRIM((SALT30.StrType)le.cru_agency_id),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.vendor_report_id),TRIM((SALT30.StrType)le.is_available_for_public),TRIM((SALT30.StrType)le.has_addendum),TRIM((SALT30.StrType)le.report_agency_ori),TRIM((SALT30.StrType)le.report_status),TRIM((SALT30.StrType)le.super_report_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),840*840,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'date_vendor_first_reported'}
      ,{2,'date_vendor_last_reported'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'report_code'}
      ,{6,'report_category'}
      ,{7,'report_code_desc'}
      ,{8,'citation_id'}
      ,{9,'creation_date'}
      ,{10,'incident_id'}
      ,{11,'citation_issued'}
      ,{12,'citation_number1'}
      ,{13,'citation_number2'}
      ,{14,'section_number1'}
      ,{15,'court_date'}
      ,{16,'court_time'}
      ,{17,'citation_detail1'}
      ,{18,'local_code'}
      ,{19,'violation_code1'}
      ,{20,'violation_code2'}
      ,{21,'multiple_charges_indicator'}
      ,{22,'dui_indicator'}
      ,{23,'commercial_id'}
      ,{24,'vehicle_id'}
      ,{25,'commercial_info_source'}
      ,{26,'commercial_vehicle_type'}
      ,{27,'motor_carrier_id_dot_number'}
      ,{28,'motor_carrier_id_state_id'}
      ,{29,'motor_carrier_id_carrier_name'}
      ,{30,'motor_carrier_id_address'}
      ,{31,'motor_carrier_id_city'}
      ,{32,'motor_carrier_id_state'}
      ,{33,'motor_carrier_id_zipcode'}
      ,{34,'motor_carrier_id_commercial_indicator'}
      ,{35,'carrier_id_type'}
      ,{36,'carrier_unit_number'}
      ,{37,'dot_permit_number'}
      ,{38,'iccmc_number'}
      ,{39,'mcs_vehicle_inspection'}
      ,{40,'mcs_form_number'}
      ,{41,'mcs_out_of_service'}
      ,{42,'mcs_violation_related'}
      ,{43,'number_of_axles'}
      ,{44,'number_of_tires'}
      ,{45,'gvw_over_10k_pounds'}
      ,{46,'weight_rating'}
      ,{47,'registered_gross_vehicle_weight'}
      ,{48,'vehicle_length_feet'}
      ,{49,'cargo_body_type'}
      ,{50,'load_type'}
      ,{51,'oversize_load'}
      ,{52,'vehicle_configuration'}
      ,{53,'trailer1_type'}
      ,{54,'trailer1_length_feet'}
      ,{55,'trailer1_width_feet'}
      ,{56,'trailer2_type'}
      ,{57,'trailer2_length_feet'}
      ,{58,'trailer2_width_feet'}
      ,{59,'federally_reportable'}
      ,{60,'vehicle_inspection_hazmat'}
      ,{61,'hazmat_form_number'}
      ,{62,'hazmt_out_of_service'}
      ,{63,'hazmat_violation_related'}
      ,{64,'hazardous_materials_placard'}
      ,{65,'hazardous_materials_class_number1'}
      ,{66,'hazardous_materials_class_number2'}
      ,{67,'hazmat_placard_name'}
      ,{68,'hazardous_materials_released1'}
      ,{69,'hazardous_materials_released2'}
      ,{70,'hazardous_materials_released3'}
      ,{71,'hazardous_materials_released4'}
      ,{72,'commercial_event1'}
      ,{73,'commercial_event2'}
      ,{74,'commercial_event3'}
      ,{75,'commercial_event4'}
      ,{76,'recommended_driver_reexam'}
      ,{77,'transporting_hazmat'}
      ,{78,'liquid_hazmat_volume'}
      ,{79,'oversize_vehicle'}
      ,{80,'overlength_vehicle'}
      ,{81,'oversize_vehicle_permitted'}
      ,{82,'overlength_vehicle_permitted'}
      ,{83,'carrier_phone_number'}
      ,{84,'commerce_type'}
      ,{85,'citation_issued_to_vehicle'}
      ,{86,'cdl_class'}
      ,{87,'dot_state'}
      ,{88,'fire_hazardous_materials_involvement'}
      ,{89,'commercial_event_description'}
      ,{90,'supplment_required_hazmat_placard'}
      ,{91,'other_state_number1'}
      ,{92,'other_state_number2'}
      ,{93,'work_type_id'}
      ,{94,'report_id'}
      ,{95,'agency_id'}
      ,{96,'sent_to_hpcc_datetime'}
      ,{97,'corrected_incident'}
      ,{98,'cru_order_id'}
      ,{99,'cru_sequence_nbr'}
      ,{100,'loss_state_abbr'}
      ,{101,'report_type_id'}
      ,{102,'hash_key'}
      ,{103,'case_identifier'}
      ,{104,'crash_county'}
      ,{105,'county_cd'}
      ,{106,'crash_cityplace'}
      ,{107,'crash_city'}
      ,{108,'city_code'}
      ,{109,'first_harmful_event'}
      ,{110,'first_harmful_event_location'}
      ,{111,'manner_crash_impact1'}
      ,{112,'weather_condition1'}
      ,{113,'weather_condition2'}
      ,{114,'light_condition1'}
      ,{115,'light_condition2'}
      ,{116,'road_surface_condition'}
      ,{117,'contributing_circumstances_environmental1'}
      ,{118,'contributing_circumstances_environmental2'}
      ,{119,'contributing_circumstances_environmental3'}
      ,{120,'contributing_circumstances_environmental4'}
      ,{121,'contributing_circumstances_road1'}
      ,{122,'contributing_circumstances_road2'}
      ,{123,'contributing_circumstances_road3'}
      ,{124,'contributing_circumstances_road4'}
      ,{125,'relation_to_junction'}
      ,{126,'intersection_type'}
      ,{127,'school_bus_related'}
      ,{128,'work_zone_related'}
      ,{129,'work_zone_location'}
      ,{130,'work_zone_type'}
      ,{131,'work_zone_workers_present'}
      ,{132,'work_zone_law_enforcement_present'}
      ,{133,'crash_severity'}
      ,{134,'number_of_vehicles'}
      ,{135,'total_nonfatal_injuries'}
      ,{136,'total_fatal_injuries'}
      ,{137,'day_of_week'}
      ,{138,'roadway_curvature'}
      ,{139,'part_of_national_highway_system'}
      ,{140,'roadway_functional_class'}
      ,{141,'access_control'}
      ,{142,'rr_crossing_id'}
      ,{143,'roadway_lighting'}
      ,{144,'traffic_control_type_at_intersection1'}
      ,{145,'traffic_control_type_at_intersection2'}
      ,{146,'ncic_number'}
      ,{147,'state_report_number'}
      ,{148,'ori_number'}
      ,{149,'crash_date'}
      ,{150,'crash_time'}
      ,{151,'lattitude'}
      ,{152,'longitude'}
      ,{153,'milepost1'}
      ,{154,'milepost2'}
      ,{155,'address_number'}
      ,{156,'loss_street'}
      ,{157,'loss_street_route_number'}
      ,{158,'loss_street_type'}
      ,{159,'loss_street_speed_limit'}
      ,{160,'incident_location_indicator'}
      ,{161,'loss_cross_street'}
      ,{162,'loss_cross_street_route_number'}
      ,{163,'loss_cross_street_intersecting_route_segment'}
      ,{164,'loss_cross_street_type'}
      ,{165,'loss_cross_street_speed_limit'}
      ,{166,'loss_cross_street_number_of_lanes'}
      ,{167,'loss_cross_street_orientation'}
      ,{168,'loss_cross_street_route_sign'}
      ,{169,'at_node_number'}
      ,{170,'distance_from_node_feet'}
      ,{171,'distance_from_node_miles'}
      ,{172,'next_node_number'}
      ,{173,'next_roadway_node_number'}
      ,{174,'direction_of_travel'}
      ,{175,'next_street'}
      ,{176,'next_street_type'}
      ,{177,'next_street_suffix'}
      ,{178,'before_or_after_next_street'}
      ,{179,'next_street_distance_feet'}
      ,{180,'next_street_distance_miles'}
      ,{181,'next_street_direction'}
      ,{182,'next_street_route_segment'}
      ,{183,'continuing_toward_street'}
      ,{184,'continuing_street_suffix'}
      ,{185,'continuing_street_direction'}
      ,{186,'continuting_street_route_segment'}
      ,{187,'city_type'}
      ,{188,'outside_city_indicator'}
      ,{189,'outside_city_direction'}
      ,{190,'outside_city_distance_feet'}
      ,{191,'outside_city_distance_miles'}
      ,{192,'crash_type'}
      ,{193,'motor_vehicle_involved_with'}
      ,{194,'report_investigation_type'}
      ,{195,'incident_hit_and_run'}
      ,{196,'tow_away'}
      ,{197,'date_notified'}
      ,{198,'time_notified'}
      ,{199,'notification_method'}
      ,{200,'officer_arrival_time'}
      ,{201,'officer_report_date'}
      ,{202,'officer_report_time'}
      ,{203,'officer_id'}
      ,{204,'officer_department'}
      ,{205,'officer_rank'}
      ,{206,'officer_command'}
      ,{207,'officer_tax_id_number'}
      ,{208,'completed_report_date'}
      ,{209,'supervisor_check_date'}
      ,{210,'supervisor_check_time'}
      ,{211,'supervisor_id'}
      ,{212,'supervisor_rank'}
      ,{213,'reviewers_name'}
      ,{214,'road_surface'}
      ,{215,'roadway_alignment'}
      ,{216,'traffic_way_description'}
      ,{217,'traffic_flow'}
      ,{218,'property_damage_involved'}
      ,{219,'property_damage_description1'}
      ,{220,'property_damage_description2'}
      ,{221,'property_damage_estimate1'}
      ,{222,'property_damage_estimate2'}
      ,{223,'incident_damage_over_limit'}
      ,{224,'property_owner_notified'}
      ,{225,'government_property'}
      ,{226,'accident_condition'}
      ,{227,'unusual_road_condition1'}
      ,{228,'unusual_road_condition2'}
      ,{229,'number_of_lanes'}
      ,{230,'divided_highway'}
      ,{231,'most_harmful_event'}
      ,{232,'second_harmful_event'}
      ,{233,'ems_notified_date'}
      ,{234,'ems_arrival_date'}
      ,{235,'hospital_arrival_date'}
      ,{236,'injured_taken_by'}
      ,{237,'injured_taken_to'}
      ,{238,'incident_transported_for_medical_care'}
      ,{239,'photographs_taken'}
      ,{240,'photographed_by'}
      ,{241,'photographer_id'}
      ,{242,'photography_agency_name'}
      ,{243,'agency_name'}
      ,{244,'judicial_district'}
      ,{245,'precinct'}
      ,{246,'beat'}
      ,{247,'location_type'}
      ,{248,'shoulder_type'}
      ,{249,'investigation_complete'}
      ,{250,'investigation_not_complete_why'}
      ,{251,'investigating_officer_name'}
      ,{252,'investigation_notification_issued'}
      ,{253,'agency_type'}
      ,{254,'no_injury_tow_involved'}
      ,{255,'injury_tow_involved'}
      ,{256,'lars_code1'}
      ,{257,'lars_code2'}
      ,{258,'private_property_incident'}
      ,{259,'accident_involvement'}
      ,{260,'local_use'}
      ,{261,'street_prefix'}
      ,{262,'street_suffix'}
      ,{263,'toll_road'}
      ,{264,'street_description'}
      ,{265,'cross_street_address_number'}
      ,{266,'cross_street_prefix'}
      ,{267,'cross_street_suffix'}
      ,{268,'report_complete'}
      ,{269,'dispatch_notified'}
      ,{270,'counter_report'}
      ,{271,'road_type'}
      ,{272,'agency_code'}
      ,{273,'public_property_employee'}
      ,{274,'bridge_related'}
      ,{275,'ramp_indicator'}
      ,{276,'to_or_from_location'}
      ,{277,'complaint_number'}
      ,{278,'school_zone_related'}
      ,{279,'notify_dot_maintenance'}
      ,{280,'special_location'}
      ,{281,'route_segment'}
      ,{282,'route_sign'}
      ,{283,'route_category_street'}
      ,{284,'route_category_cross_street'}
      ,{285,'route_category_next_street'}
      ,{286,'lane_closed'}
      ,{287,'lane_closure_direction'}
      ,{288,'lane_direction'}
      ,{289,'traffic_detoured'}
      ,{290,'time_closed'}
      ,{291,'pedestrian_signals'}
      ,{292,'work_zone_speed_limit'}
      ,{293,'work_zone_shoulder_median'}
      ,{294,'work_zone_intermittent_moving'}
      ,{295,'work_zone_flagger_control'}
      ,{296,'special_work_zone_characteristics'}
      ,{297,'lane_number'}
      ,{298,'offset_distance_feet'}
      ,{299,'offset_distance_miles'}
      ,{300,'offset_direction'}
      ,{301,'asru_code'}
      ,{302,'mp_grid'}
      ,{303,'number_of_qualifying_units'}
      ,{304,'number_of_hazmat_vehicles'}
      ,{305,'number_of_buses_involved'}
      ,{306,'number_taken_to_treatment'}
      ,{307,'number_vehicles_towed'}
      ,{308,'vehicle_at_fault_unit_number'}
      ,{309,'time_officer_cleared_scene'}
      ,{310,'total_minutes_on_scene'}
      ,{311,'motorists_report'}
      ,{312,'fatality_involved'}
      ,{313,'local_dot_index_number'}
      ,{314,'dor_number'}
      ,{315,'hospital_code'}
      ,{316,'special_jurisdiction'}
      ,{317,'document_type'}
      ,{318,'distance_was_measured'}
      ,{319,'street_orientation'}
      ,{320,'intersecting_route_segment'}
      ,{321,'primary_fault_indicator'}
      ,{322,'first_harmful_event_pedestrian'}
      ,{323,'reference_markers'}
      ,{324,'other_officer_on_scene'}
      ,{325,'other_officer_badge_number'}
      ,{326,'supplemental_report'}
      ,{327,'supplemental_type'}
      ,{328,'amended_report'}
      ,{329,'corrected_report'}
      ,{330,'state_highway_related'}
      ,{331,'roadway_lighting_condition'}
      ,{332,'vendor_reference_number'}
      ,{333,'duplicate_copy_unit_number'}
      ,{334,'other_city_agency_description'}
      ,{335,'notifcation_description'}
      ,{336,'primary_collision_improper_driving_description'}
      ,{337,'weather_other_description'}
      ,{338,'crash_type_description'}
      ,{339,'motor_vehicle_involved_with_animal_description'}
      ,{340,'motor_vehicle_involved_with_fixed_object_description'}
      ,{341,'motor_vehicle_involved_with_other_object_description'}
      ,{342,'other_investigation_time'}
      ,{343,'milepost_detail'}
      ,{344,'utility_pole_number1'}
      ,{345,'utility_pole_number2'}
      ,{346,'utility_pole_number3'}
      ,{347,'person_id'}
      ,{348,'person_number'}
      ,{349,'vehicle_unit_number'}
      ,{350,'sex'}
      ,{351,'person_type'}
      ,{352,'injury_status'}
      ,{353,'occupant_vehicle_unit_number'}
      ,{354,'seating_position1'}
      ,{355,'safety_equipment_restraint1'}
      ,{356,'safety_equipment_restraint2'}
      ,{357,'safety_equipment_helmet'}
      ,{358,'air_bag_deployed'}
      ,{359,'ejection'}
      ,{360,'drivers_license_jurisdiction'}
      ,{361,'dl_number_class'}
      ,{362,'dl_number_cdl'}
      ,{363,'dl_number_endorsements'}
      ,{364,'driver_actions_at_time_of_crash1'}
      ,{365,'driver_actions_at_time_of_crash2'}
      ,{366,'driver_actions_at_time_of_crash3'}
      ,{367,'driver_actions_at_time_of_crash4'}
      ,{368,'violation_codes'}
      ,{369,'condition_at_time_of_crash1'}
      ,{370,'condition_at_time_of_crash2'}
      ,{371,'law_enforcement_suspects_alcohol_use'}
      ,{372,'alcohol_test_status'}
      ,{373,'alcohol_test_type'}
      ,{374,'alcohol_test_result'}
      ,{375,'law_enforcement_suspects_drug_use'}
      ,{376,'drug_test_given'}
      ,{377,'non_motorist_actions_prior_to_crash1'}
      ,{378,'non_motorist_actions_prior_to_crash2'}
      ,{379,'non_motorist_actions_at_time_of_crash'}
      ,{380,'non_motorist_location_at_time_of_crash'}
      ,{381,'non_motorist_safety_equipment1'}
      ,{382,'age'}
      ,{383,'driver_license_restrictions1'}
      ,{384,'drug_test_type'}
      ,{385,'drug_test_result1'}
      ,{386,'drug_test_result2'}
      ,{387,'drug_test_result3'}
      ,{388,'drug_test_result4'}
      ,{389,'injury_area'}
      ,{390,'injury_description'}
      ,{391,'motorcyclist_head_injury'}
      ,{392,'party_id'}
      ,{393,'same_as_driver'}
      ,{394,'address_same_as_driver'}
      ,{395,'last_name'}
      ,{396,'first_name'}
      ,{397,'middle_name'}
      ,{398,'name_suffx'}
      ,{399,'date_of_birth'}
      ,{400,'address'}
      ,{401,'city'}
      ,{402,'state'}
      ,{403,'zip_code'}
      ,{404,'home_phone'}
      ,{405,'business_phone'}
      ,{406,'insurance_company'}
      ,{407,'insurance_company_phone_number'}
      ,{408,'insurance_policy_number'}
      ,{409,'insurance_effective_date'}
      ,{410,'ssn'}
      ,{411,'drivers_license_number'}
      ,{412,'drivers_license_expiration'}
      ,{413,'eye_color'}
      ,{414,'hair_color'}
      ,{415,'height'}
      ,{416,'weight'}
      ,{417,'race'}
      ,{418,'pedestrian_cyclist_visibility'}
      ,{419,'first_aid_by'}
      ,{420,'person_first_aid_party_type'}
      ,{421,'person_first_aid_party_type_description'}
      ,{422,'deceased_at_scene'}
      ,{423,'death_date'}
      ,{424,'death_time'}
      ,{425,'extricated'}
      ,{426,'alcohol_drug_use'}
      ,{427,'physical_defects'}
      ,{428,'driver_residence'}
      ,{429,'id_type'}
      ,{430,'proof_of_insurance'}
      ,{431,'insurance_expired'}
      ,{432,'insurance_exempt'}
      ,{433,'insurance_type'}
      ,{434,'violent_crime_victim_notified'}
      ,{435,'insurance_company_code'}
      ,{436,'refused_medical_treatment'}
      ,{437,'safety_equipment_available_or_used'}
      ,{438,'apartment_number'}
      ,{439,'licensed_driver'}
      ,{440,'physical_emotional_status'}
      ,{441,'driver_presence'}
      ,{442,'ejection_path'}
      ,{443,'state_person_id'}
      ,{444,'contributed_to_collision'}
      ,{445,'person_transported_for_medical_care'}
      ,{446,'transported_by_agency_type'}
      ,{447,'transported_to'}
      ,{448,'non_motorist_driver_license_number'}
      ,{449,'air_bag_type'}
      ,{450,'cell_phone_use'}
      ,{451,'driver_license_restriction_compliance'}
      ,{452,'driver_license_endorsement_compliance'}
      ,{453,'driver_license_compliance'}
      ,{454,'contributing_circumstances_p1'}
      ,{455,'contributing_circumstances_p2'}
      ,{456,'contributing_circumstances_p3'}
      ,{457,'contributing_circumstances_p4'}
      ,{458,'passenger_number'}
      ,{459,'person_deleted'}
      ,{460,'owner_lessee'}
      ,{461,'driver_charged'}
      ,{462,'motorcycle_eye_protection'}
      ,{463,'motorcycle_long_sleeves'}
      ,{464,'motorcycle_long_pants'}
      ,{465,'motorcycle_over_ankle_boots'}
      ,{466,'contributing_circumstances_environmental_non_incident1'}
      ,{467,'contributing_circumstances_environmental_non_incident2'}
      ,{468,'alcohol_drug_test_given'}
      ,{469,'alcohol_drug_test_type'}
      ,{470,'alcohol_drug_test_result'}
      ,{471,'vin'}
      ,{472,'vin_status'}
      ,{473,'damaged_areas_derived1'}
      ,{474,'damaged_areas_derived2'}
      ,{475,'airbags_deployed_derived'}
      ,{476,'vehicle_towed_derived'}
      ,{477,'unit_type'}
      ,{478,'unit_number'}
      ,{479,'registration_state'}
      ,{480,'registration_year'}
      ,{481,'license_plate'}
      ,{482,'make'}
      ,{483,'model_yr'}
      ,{484,'model'}
      ,{485,'body_type_category'}
      ,{486,'total_occupants_in_vehicle'}
      ,{487,'special_function_in_transport'}
      ,{488,'special_function_in_transport_other_unit'}
      ,{489,'emergency_use'}
      ,{490,'posted_satutory_speed_limit'}
      ,{491,'direction_of_travel_before_crash'}
      ,{492,'trafficway_description'}
      ,{493,'traffic_control_device_type'}
      ,{494,'vehicle_maneuver_action_prior1'}
      ,{495,'vehicle_maneuver_action_prior2'}
      ,{496,'impact_area1'}
      ,{497,'impact_area2'}
      ,{498,'event_sequence1'}
      ,{499,'event_sequence2'}
      ,{500,'event_sequence3'}
      ,{501,'event_sequence4'}
      ,{502,'most_harmful_event_for_vehicle'}
      ,{503,'bus_use'}
      ,{504,'vehicle_hit_and_run'}
      ,{505,'vehicle_towed'}
      ,{506,'contributing_circumstances_v1'}
      ,{507,'contributing_circumstances_v2'}
      ,{508,'contributing_circumstances_v3'}
      ,{509,'contributing_circumstances_v4'}
      ,{510,'on_street'}
      ,{511,'vehicle_color'}
      ,{512,'estimated_speed'}
      ,{513,'accident_investigation_site'}
      ,{514,'car_fire'}
      ,{515,'vehicle_damage_amount'}
      ,{516,'contributing_factors1'}
      ,{517,'contributing_factors2'}
      ,{518,'contributing_factors3'}
      ,{519,'contributing_factors4'}
      ,{520,'other_contributing_factors1'}
      ,{521,'other_contributing_factors2'}
      ,{522,'other_contributing_factors3'}
      ,{523,'vision_obscured1'}
      ,{524,'vision_obscured2'}
      ,{525,'vehicle_on_road'}
      ,{526,'ran_off_road'}
      ,{527,'skidding_occurred'}
      ,{528,'vehicle_incident_location1'}
      ,{529,'vehicle_incident_location2'}
      ,{530,'vehicle_incident_location3'}
      ,{531,'vehicle_disabled'}
      ,{532,'vehicle_removed_to'}
      ,{533,'removed_by'}
      ,{534,'tow_requested_by_driver'}
      ,{535,'solicitation'}
      ,{536,'other_unit_vehicle_damage_amount'}
      ,{537,'other_unit_model_year'}
      ,{538,'other_unit_make'}
      ,{539,'other_unit_model'}
      ,{540,'other_unit_vin'}
      ,{541,'other_unit_vin_status'}
      ,{542,'other_unit_body_type_category'}
      ,{543,'other_unit_registration_state'}
      ,{544,'other_unit_registration_year'}
      ,{545,'other_unit_license_plate'}
      ,{546,'other_unit_color'}
      ,{547,'other_unit_type'}
      ,{548,'damaged_areas1'}
      ,{549,'damaged_areas2'}
      ,{550,'parked_vehicle'}
      ,{551,'damage_rating1'}
      ,{552,'damage_rating2'}
      ,{553,'vehicle_inventoried'}
      ,{554,'vehicle_defect_apparent'}
      ,{555,'defect_may_have_contributed1'}
      ,{556,'defect_may_have_contributed2'}
      ,{557,'registration_expiration'}
      ,{558,'owner_driver_type'}
      ,{559,'make_code'}
      ,{560,'number_trailing_units'}
      ,{561,'vehicle_position'}
      ,{562,'vehicle_type'}
      ,{563,'motorcycle_engine_size'}
      ,{564,'motorcycle_driver_educated'}
      ,{565,'motorcycle_helmet_type'}
      ,{566,'motorcycle_passenger'}
      ,{567,'motorcycle_helmet_stayed_on'}
      ,{568,'motorcycle_helmet_dot_snell'}
      ,{569,'motorcycle_saddlebag_trunk'}
      ,{570,'motorcycle_trailer'}
      ,{571,'pedacycle_passenger'}
      ,{572,'pedacycle_headlights'}
      ,{573,'pedacycle_helmet'}
      ,{574,'pedacycle_rear_reflectors'}
      ,{575,'cdl_required'}
      ,{576,'truck_bus_supplement_required'}
      ,{577,'unit_damage_amount'}
      ,{578,'airbag_switch'}
      ,{579,'underride_override_damage'}
      ,{580,'vehicle_attachment'}
      ,{581,'action_on_impact'}
      ,{582,'speed_detection_method'}
      ,{583,'non_motorist_direction_of_travel_from'}
      ,{584,'non_motorist_direction_of_travel_to'}
      ,{585,'vehicle_use'}
      ,{586,'department_unit_number'}
      ,{587,'equipment_in_use_at_time_of_accident'}
      ,{588,'actions_of_police_vehicle'}
      ,{589,'vehicle_command_id'}
      ,{590,'traffic_control_device_inoperative'}
      ,{591,'direction_of_impact1'}
      ,{592,'direction_of_impact2'}
      ,{593,'ran_off_road_direction'}
      ,{594,'vin_other_unit_number'}
      ,{595,'damaged_area_generic'}
      ,{596,'vision_obscured_description'}
      ,{597,'inattention_description'}
      ,{598,'contributing_circumstances_defect_description'}
      ,{599,'contributing_circumstances_other_descriptioin'}
      ,{600,'vehicle_maneuver_action_prior_other_description'}
      ,{601,'vehicle_special_use'}
      ,{602,'vehicle_type_extended1'}
      ,{603,'vehicle_type_extended2'}
      ,{604,'fixed_object_direction1'}
      ,{605,'fixed_object_direction2'}
      ,{606,'fixed_object_direction3'}
      ,{607,'fixed_object_direction4'}
      ,{608,'vehicle_left_at_scene'}
      ,{609,'vehicle_impounded'}
      ,{610,'vehicle_driven_from_scene'}
      ,{611,'on_cross_street'}
      ,{612,'actions_of_police_vehicle_description'}
      ,{613,'vehicle_seg'}
      ,{614,'vehicle_seg_type'}
      ,{615,'model_year'}
      ,{616,'body_style_code'}
      ,{617,'engine_size'}
      ,{618,'fuel_code'}
      ,{619,'number_of_driving_wheels'}
      ,{620,'steering_type'}
      ,{621,'vina_series'}
      ,{622,'vina_model'}
      ,{623,'vina_make'}
      ,{624,'vina_body_style'}
      ,{625,'make_description'}
      ,{626,'model_description'}
      ,{627,'series_description'}
      ,{628,'car_cylinders'}
      ,{629,'other_vehicle_seg'}
      ,{630,'other_vehicle_seg_type'}
      ,{631,'other_model_year'}
      ,{632,'other_body_style_code'}
      ,{633,'other_engine_size'}
      ,{634,'other_fuel_code'}
      ,{635,'other_number_of_driving_wheels'}
      ,{636,'other_steering_type'}
      ,{637,'other_vina_series'}
      ,{638,'other_vina_model'}
      ,{639,'other_vina_make'}
      ,{640,'other_vina_body_style'}
      ,{641,'other_make_description'}
      ,{642,'other_model_description'}
      ,{643,'other_series_description'}
      ,{644,'other_car_cylinders'}
      ,{645,'report_has_coversheet'}
      ,{646,'prim_range'}
      ,{647,'predir'}
      ,{648,'prim_name'}
      ,{649,'addr_suffix'}
      ,{650,'postdir'}
      ,{651,'unit_desig'}
      ,{652,'sec_range'}
      ,{653,'p_city_name'}
      ,{654,'v_city_name'}
      ,{655,'st'}
      ,{656,'z5'}
      ,{657,'z4'}
      ,{658,'cart'}
      ,{659,'cr_sort_sz'}
      ,{660,'lot'}
      ,{661,'lot_order'}
      ,{662,'dpbc'}
      ,{663,'chk_digit'}
      ,{664,'rec_type'}
      ,{665,'county_code'}
      ,{666,'geo_lat'}
      ,{667,'geo_long'}
      ,{668,'msa'}
      ,{669,'geo_blk'}
      ,{670,'geo_match'}
      ,{671,'err_stat'}
      ,{672,'nametype'}
      ,{673,'title'}
      ,{674,'fname'}
      ,{675,'mname'}
      ,{676,'lname'}
      ,{677,'suffix'}
      ,{678,'title2'}
      ,{679,'fname2'}
      ,{680,'mname2'}
      ,{681,'lname2'}
      ,{682,'suffix2'}
      ,{683,'name_score'}
      ,{684,'did'}
      ,{685,'did_score'}
      ,{686,'bdid'}
      ,{687,'bdid_score'}
      ,{688,'rawaid'}
      ,{689,'law_enforcement_suspects_alcohol_use1'}
      ,{690,'law_enforcement_suspects_drug_use1'}
      ,{691,'ems_notified_time'}
      ,{692,'ems_arrival_time'}
      ,{693,'avoidance_maneuver2'}
      ,{694,'avoidance_maneuver3'}
      ,{695,'avoidance_maneuver4'}
      ,{696,'damaged_areas_severity1'}
      ,{697,'damaged_areas_severity2'}
      ,{698,'vehicle_outside_city_indicator'}
      ,{699,'vehicle_outside_city_distance_miles'}
      ,{700,'vehicle_outside_city_direction'}
      ,{701,'vehicle_crash_cityplace'}
      ,{702,'insurance_company_standardized'}
      ,{703,'insurance_expiration_date'}
      ,{704,'insurance_policy_holder'}
      ,{705,'is_tag_converted'}
      ,{706,'vin_original'}
      ,{707,'make_original'}
      ,{708,'model_original'}
      ,{709,'model_year_original'}
      ,{710,'other_unit_vin_original'}
      ,{711,'other_unit_make_original'}
      ,{712,'other_unit_model_original'}
      ,{713,'other_unit_model_year_original'}
      ,{714,'source_id'}
      ,{715,'orig_fname'}
      ,{716,'orig_lname'}
      ,{717,'orig_mname'}
      ,{718,'initial_point_of_contact'}
      ,{719,'vehicle_driveable'}
      ,{720,'drivers_license_type'}
      ,{721,'alcohol_test_type_refused'}
      ,{722,'alcohol_test_type_not_offered'}
      ,{723,'alcohol_test_type_field'}
      ,{724,'alcohol_test_type_pbt'}
      ,{725,'alcohol_test_type_breath'}
      ,{726,'alcohol_test_type_blood'}
      ,{727,'alcohol_test_type_urine'}
      ,{728,'trapped'}
      ,{729,'dl_number_cdl_endorsements'}
      ,{730,'dl_number_cdl_restrictions'}
      ,{731,'dl_number_cdl_exempt'}
      ,{732,'dl_number_cdl_medical_card'}
      ,{733,'interlock_device_in_use'}
      ,{734,'drug_test_type_blood'}
      ,{735,'drug_test_type_urine'}
      ,{736,'traffic_control_condition'}
      ,{737,'intersection_related'}
      ,{738,'special_study_local'}
      ,{739,'special_study_state'}
      ,{740,'off_road_vehicle_involved'}
      ,{741,'location_type2'}
      ,{742,'speed_limit_posted'}
      ,{743,'traffic_control_damage_notify_date'}
      ,{744,'traffic_control_damage_notify_time'}
      ,{745,'traffic_control_damage_notify_name'}
      ,{746,'public_property_damaged'}
      ,{747,'replacement_report'}
      ,{748,'deleted_report'}
      ,{749,'next_street_prefix'}
      ,{750,'violator_name'}
      ,{751,'type_hazardous'}
      ,{752,'type_other'}
      ,{753,'unit_type_and_axles1'}
      ,{754,'unit_type_and_axles2'}
      ,{755,'unit_type_and_axles3'}
      ,{756,'unit_type_and_axles4'}
      ,{757,'incident_damage_amount'}
      ,{758,'dot_use'}
      ,{759,'number_of_persons_involved'}
      ,{760,'unusual_road_condition_other_description'}
      ,{761,'number_of_narrative_sections'}
      ,{762,'cad_number'}
      ,{763,'visibility'}
      ,{764,'accident_at_intersection'}
      ,{765,'accident_not_at_intersection'}
      ,{766,'first_harmful_event_within_interchange'}
      ,{767,'injury_involved'}
      ,{768,'citation_status'}
      ,{769,'commercial_vehicle'}
      ,{770,'not_in_transport'}
      ,{771,'other_unit_number'}
      ,{772,'other_unit_length'}
      ,{773,'other_unit_axles'}
      ,{774,'other_unit_plate_expiration'}
      ,{775,'other_unit_permanent_registration'}
      ,{776,'other_unit_model_year2'}
      ,{777,'other_unit_make2'}
      ,{778,'other_unit_vin2'}
      ,{779,'other_unit_registration_state2'}
      ,{780,'other_unit_registration_year2'}
      ,{781,'other_unit_license_plate2'}
      ,{782,'other_unit_number2'}
      ,{783,'other_unit_length2'}
      ,{784,'other_unit_axles2'}
      ,{785,'other_unit_plate_expiration2'}
      ,{786,'other_unit_permanent_registration2'}
      ,{787,'other_unit_type2'}
      ,{788,'other_unit_model_year3'}
      ,{789,'other_unit_make3'}
      ,{790,'other_unit_vin3'}
      ,{791,'other_unit_registration_state3'}
      ,{792,'other_unit_registration_year3'}
      ,{793,'other_unit_license_plate3'}
      ,{794,'other_unit_number3'}
      ,{795,'other_unit_length3'}
      ,{796,'other_unit_axles3'}
      ,{797,'other_unit_plate_expiration3'}
      ,{798,'other_unit_permanent_registration3'}
      ,{799,'other_unit_type3'}
      ,{800,'damaged_areas3'}
      ,{801,'driver_distracted_by'}
      ,{802,'non_motorist_type'}
      ,{803,'seating_position_row'}
      ,{804,'seating_position_seat'}
      ,{805,'seating_position_description'}
      ,{806,'transported_id_number'}
      ,{807,'witness_number'}
      ,{808,'date_of_birth_derived'}
      ,{809,'property_damage_id'}
      ,{810,'property_owner_name'}
      ,{811,'damage_description'}
      ,{812,'damage_estimate'}
      ,{813,'narrative'}
      ,{814,'narrative_continuance'}
      ,{815,'hazardous_materials_hazmat_placard_number1'}
      ,{816,'hazardous_materials_hazmat_placard_number2'}
      ,{817,'vendor_code'}
      ,{818,'report_property_damage'}
      ,{819,'report_collision_type'}
      ,{820,'report_first_harmful_event'}
      ,{821,'report_light_condition'}
      ,{822,'report_weather_condition'}
      ,{823,'report_road_condition'}
      ,{824,'report_injury_status'}
      ,{825,'report_damage_extent'}
      ,{826,'report_vehicle_type'}
      ,{827,'report_traffic_control_device_type'}
      ,{828,'report_contributing_circumstances_v'}
      ,{829,'report_vehicle_maneuver_action_prior'}
      ,{830,'report_vehicle_body_type'}
      ,{831,'cru_agency_name'}
      ,{832,'cru_agency_id'}
      ,{833,'cname'}
      ,{834,'name_type'}
      ,{835,'vendor_report_id'}
      ,{836,'is_available_for_public'}
      ,{837,'has_addendum'}
      ,{838,'report_agency_ori'}
      ,{839,'report_status'}
      ,{840,'super_report_id'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.report_code) report_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_report_code((SALT30.StrType)le.report_code),
    Fields.InValid_report_category((SALT30.StrType)le.report_category),
    Fields.InValid_report_code_desc((SALT30.StrType)le.report_code_desc),
    Fields.InValid_citation_id((SALT30.StrType)le.citation_id),
    Fields.InValid_creation_date((SALT30.StrType)le.creation_date),
    Fields.InValid_incident_id((SALT30.StrType)le.incident_id),
    Fields.InValid_citation_issued((SALT30.StrType)le.citation_issued),
    Fields.InValid_citation_number1((SALT30.StrType)le.citation_number1),
    Fields.InValid_citation_number2((SALT30.StrType)le.citation_number2),
    Fields.InValid_section_number1((SALT30.StrType)le.section_number1),
    Fields.InValid_court_date((SALT30.StrType)le.court_date),
    Fields.InValid_court_time((SALT30.StrType)le.court_time),
    Fields.InValid_citation_detail1((SALT30.StrType)le.citation_detail1),
    Fields.InValid_local_code((SALT30.StrType)le.local_code),
    Fields.InValid_violation_code1((SALT30.StrType)le.violation_code1),
    Fields.InValid_violation_code2((SALT30.StrType)le.violation_code2),
    Fields.InValid_multiple_charges_indicator((SALT30.StrType)le.multiple_charges_indicator),
    Fields.InValid_dui_indicator((SALT30.StrType)le.dui_indicator),
    Fields.InValid_commercial_id((SALT30.StrType)le.commercial_id),
    Fields.InValid_vehicle_id((SALT30.StrType)le.vehicle_id),
    Fields.InValid_commercial_info_source((SALT30.StrType)le.commercial_info_source),
    Fields.InValid_commercial_vehicle_type((SALT30.StrType)le.commercial_vehicle_type),
    Fields.InValid_motor_carrier_id_dot_number((SALT30.StrType)le.motor_carrier_id_dot_number),
    Fields.InValid_motor_carrier_id_state_id((SALT30.StrType)le.motor_carrier_id_state_id),
    Fields.InValid_motor_carrier_id_carrier_name((SALT30.StrType)le.motor_carrier_id_carrier_name),
    Fields.InValid_motor_carrier_id_address((SALT30.StrType)le.motor_carrier_id_address),
    Fields.InValid_motor_carrier_id_city((SALT30.StrType)le.motor_carrier_id_city),
    Fields.InValid_motor_carrier_id_state((SALT30.StrType)le.motor_carrier_id_state),
    Fields.InValid_motor_carrier_id_zipcode((SALT30.StrType)le.motor_carrier_id_zipcode),
    Fields.InValid_motor_carrier_id_commercial_indicator((SALT30.StrType)le.motor_carrier_id_commercial_indicator),
    Fields.InValid_carrier_id_type((SALT30.StrType)le.carrier_id_type),
    Fields.InValid_carrier_unit_number((SALT30.StrType)le.carrier_unit_number),
    Fields.InValid_dot_permit_number((SALT30.StrType)le.dot_permit_number),
    Fields.InValid_iccmc_number((SALT30.StrType)le.iccmc_number),
    Fields.InValid_mcs_vehicle_inspection((SALT30.StrType)le.mcs_vehicle_inspection),
    Fields.InValid_mcs_form_number((SALT30.StrType)le.mcs_form_number),
    Fields.InValid_mcs_out_of_service((SALT30.StrType)le.mcs_out_of_service),
    Fields.InValid_mcs_violation_related((SALT30.StrType)le.mcs_violation_related),
    Fields.InValid_number_of_axles((SALT30.StrType)le.number_of_axles),
    Fields.InValid_number_of_tires((SALT30.StrType)le.number_of_tires),
    Fields.InValid_gvw_over_10k_pounds((SALT30.StrType)le.gvw_over_10k_pounds),
    Fields.InValid_weight_rating((SALT30.StrType)le.weight_rating),
    Fields.InValid_registered_gross_vehicle_weight((SALT30.StrType)le.registered_gross_vehicle_weight),
    Fields.InValid_vehicle_length_feet((SALT30.StrType)le.vehicle_length_feet),
    Fields.InValid_cargo_body_type((SALT30.StrType)le.cargo_body_type),
    Fields.InValid_load_type((SALT30.StrType)le.load_type),
    Fields.InValid_oversize_load((SALT30.StrType)le.oversize_load),
    Fields.InValid_vehicle_configuration((SALT30.StrType)le.vehicle_configuration),
    Fields.InValid_trailer1_type((SALT30.StrType)le.trailer1_type),
    Fields.InValid_trailer1_length_feet((SALT30.StrType)le.trailer1_length_feet),
    Fields.InValid_trailer1_width_feet((SALT30.StrType)le.trailer1_width_feet),
    Fields.InValid_trailer2_type((SALT30.StrType)le.trailer2_type),
    Fields.InValid_trailer2_length_feet((SALT30.StrType)le.trailer2_length_feet),
    Fields.InValid_trailer2_width_feet((SALT30.StrType)le.trailer2_width_feet),
    Fields.InValid_federally_reportable((SALT30.StrType)le.federally_reportable),
    Fields.InValid_vehicle_inspection_hazmat((SALT30.StrType)le.vehicle_inspection_hazmat),
    Fields.InValid_hazmat_form_number((SALT30.StrType)le.hazmat_form_number),
    Fields.InValid_hazmt_out_of_service((SALT30.StrType)le.hazmt_out_of_service),
    Fields.InValid_hazmat_violation_related((SALT30.StrType)le.hazmat_violation_related),
    Fields.InValid_hazardous_materials_placard((SALT30.StrType)le.hazardous_materials_placard),
    Fields.InValid_hazardous_materials_class_number1((SALT30.StrType)le.hazardous_materials_class_number1),
    Fields.InValid_hazardous_materials_class_number2((SALT30.StrType)le.hazardous_materials_class_number2),
    Fields.InValid_hazmat_placard_name((SALT30.StrType)le.hazmat_placard_name),
    Fields.InValid_hazardous_materials_released1((SALT30.StrType)le.hazardous_materials_released1),
    Fields.InValid_hazardous_materials_released2((SALT30.StrType)le.hazardous_materials_released2),
    Fields.InValid_hazardous_materials_released3((SALT30.StrType)le.hazardous_materials_released3),
    Fields.InValid_hazardous_materials_released4((SALT30.StrType)le.hazardous_materials_released4),
    Fields.InValid_commercial_event1((SALT30.StrType)le.commercial_event1),
    Fields.InValid_commercial_event2((SALT30.StrType)le.commercial_event2),
    Fields.InValid_commercial_event3((SALT30.StrType)le.commercial_event3),
    Fields.InValid_commercial_event4((SALT30.StrType)le.commercial_event4),
    Fields.InValid_recommended_driver_reexam((SALT30.StrType)le.recommended_driver_reexam),
    Fields.InValid_transporting_hazmat((SALT30.StrType)le.transporting_hazmat),
    Fields.InValid_liquid_hazmat_volume((SALT30.StrType)le.liquid_hazmat_volume),
    Fields.InValid_oversize_vehicle((SALT30.StrType)le.oversize_vehicle),
    Fields.InValid_overlength_vehicle((SALT30.StrType)le.overlength_vehicle),
    Fields.InValid_oversize_vehicle_permitted((SALT30.StrType)le.oversize_vehicle_permitted),
    Fields.InValid_overlength_vehicle_permitted((SALT30.StrType)le.overlength_vehicle_permitted),
    Fields.InValid_carrier_phone_number((SALT30.StrType)le.carrier_phone_number),
    Fields.InValid_commerce_type((SALT30.StrType)le.commerce_type),
    Fields.InValid_citation_issued_to_vehicle((SALT30.StrType)le.citation_issued_to_vehicle),
    Fields.InValid_cdl_class((SALT30.StrType)le.cdl_class),
    Fields.InValid_dot_state((SALT30.StrType)le.dot_state),
    Fields.InValid_fire_hazardous_materials_involvement((SALT30.StrType)le.fire_hazardous_materials_involvement),
    Fields.InValid_commercial_event_description((SALT30.StrType)le.commercial_event_description),
    Fields.InValid_supplment_required_hazmat_placard((SALT30.StrType)le.supplment_required_hazmat_placard),
    Fields.InValid_other_state_number1((SALT30.StrType)le.other_state_number1),
    Fields.InValid_other_state_number2((SALT30.StrType)le.other_state_number2),
    Fields.InValid_work_type_id((SALT30.StrType)le.work_type_id),
    Fields.InValid_report_id((SALT30.StrType)le.report_id),
    Fields.InValid_agency_id((SALT30.StrType)le.agency_id),
    Fields.InValid_sent_to_hpcc_datetime((SALT30.StrType)le.sent_to_hpcc_datetime),
    Fields.InValid_corrected_incident((SALT30.StrType)le.corrected_incident),
    Fields.InValid_cru_order_id((SALT30.StrType)le.cru_order_id),
    Fields.InValid_cru_sequence_nbr((SALT30.StrType)le.cru_sequence_nbr),
    Fields.InValid_loss_state_abbr((SALT30.StrType)le.loss_state_abbr),
    Fields.InValid_report_type_id((SALT30.StrType)le.report_type_id),
    Fields.InValid_hash_key((SALT30.StrType)le.hash_key),
    Fields.InValid_case_identifier((SALT30.StrType)le.case_identifier),
    Fields.InValid_crash_county((SALT30.StrType)le.crash_county),
    Fields.InValid_county_cd((SALT30.StrType)le.county_cd),
    Fields.InValid_crash_cityplace((SALT30.StrType)le.crash_cityplace),
    Fields.InValid_crash_city((SALT30.StrType)le.crash_city),
    Fields.InValid_city_code((SALT30.StrType)le.city_code),
    Fields.InValid_first_harmful_event((SALT30.StrType)le.first_harmful_event),
    Fields.InValid_first_harmful_event_location((SALT30.StrType)le.first_harmful_event_location),
    Fields.InValid_manner_crash_impact1((SALT30.StrType)le.manner_crash_impact1),
    Fields.InValid_weather_condition1((SALT30.StrType)le.weather_condition1),
    Fields.InValid_weather_condition2((SALT30.StrType)le.weather_condition2),
    Fields.InValid_light_condition1((SALT30.StrType)le.light_condition1),
    Fields.InValid_light_condition2((SALT30.StrType)le.light_condition2),
    Fields.InValid_road_surface_condition((SALT30.StrType)le.road_surface_condition),
    Fields.InValid_contributing_circumstances_environmental1((SALT30.StrType)le.contributing_circumstances_environmental1),
    Fields.InValid_contributing_circumstances_environmental2((SALT30.StrType)le.contributing_circumstances_environmental2),
    Fields.InValid_contributing_circumstances_environmental3((SALT30.StrType)le.contributing_circumstances_environmental3),
    Fields.InValid_contributing_circumstances_environmental4((SALT30.StrType)le.contributing_circumstances_environmental4),
    Fields.InValid_contributing_circumstances_road1((SALT30.StrType)le.contributing_circumstances_road1),
    Fields.InValid_contributing_circumstances_road2((SALT30.StrType)le.contributing_circumstances_road2),
    Fields.InValid_contributing_circumstances_road3((SALT30.StrType)le.contributing_circumstances_road3),
    Fields.InValid_contributing_circumstances_road4((SALT30.StrType)le.contributing_circumstances_road4),
    Fields.InValid_relation_to_junction((SALT30.StrType)le.relation_to_junction),
    Fields.InValid_intersection_type((SALT30.StrType)le.intersection_type),
    Fields.InValid_school_bus_related((SALT30.StrType)le.school_bus_related),
    Fields.InValid_work_zone_related((SALT30.StrType)le.work_zone_related),
    Fields.InValid_work_zone_location((SALT30.StrType)le.work_zone_location),
    Fields.InValid_work_zone_type((SALT30.StrType)le.work_zone_type),
    Fields.InValid_work_zone_workers_present((SALT30.StrType)le.work_zone_workers_present),
    Fields.InValid_work_zone_law_enforcement_present((SALT30.StrType)le.work_zone_law_enforcement_present),
    Fields.InValid_crash_severity((SALT30.StrType)le.crash_severity),
    Fields.InValid_number_of_vehicles((SALT30.StrType)le.number_of_vehicles),
    Fields.InValid_total_nonfatal_injuries((SALT30.StrType)le.total_nonfatal_injuries),
    Fields.InValid_total_fatal_injuries((SALT30.StrType)le.total_fatal_injuries),
    Fields.InValid_day_of_week((SALT30.StrType)le.day_of_week),
    Fields.InValid_roadway_curvature((SALT30.StrType)le.roadway_curvature),
    Fields.InValid_part_of_national_highway_system((SALT30.StrType)le.part_of_national_highway_system),
    Fields.InValid_roadway_functional_class((SALT30.StrType)le.roadway_functional_class),
    Fields.InValid_access_control((SALT30.StrType)le.access_control),
    Fields.InValid_rr_crossing_id((SALT30.StrType)le.rr_crossing_id),
    Fields.InValid_roadway_lighting((SALT30.StrType)le.roadway_lighting),
    Fields.InValid_traffic_control_type_at_intersection1((SALT30.StrType)le.traffic_control_type_at_intersection1),
    Fields.InValid_traffic_control_type_at_intersection2((SALT30.StrType)le.traffic_control_type_at_intersection2),
    Fields.InValid_ncic_number((SALT30.StrType)le.ncic_number),
    Fields.InValid_state_report_number((SALT30.StrType)le.state_report_number),
    Fields.InValid_ori_number((SALT30.StrType)le.ori_number),
    Fields.InValid_crash_date((SALT30.StrType)le.crash_date),
    Fields.InValid_crash_time((SALT30.StrType)le.crash_time),
    Fields.InValid_lattitude((SALT30.StrType)le.lattitude),
    Fields.InValid_longitude((SALT30.StrType)le.longitude),
    Fields.InValid_milepost1((SALT30.StrType)le.milepost1),
    Fields.InValid_milepost2((SALT30.StrType)le.milepost2),
    Fields.InValid_address_number((SALT30.StrType)le.address_number),
    Fields.InValid_loss_street((SALT30.StrType)le.loss_street),
    Fields.InValid_loss_street_route_number((SALT30.StrType)le.loss_street_route_number),
    Fields.InValid_loss_street_type((SALT30.StrType)le.loss_street_type),
    Fields.InValid_loss_street_speed_limit((SALT30.StrType)le.loss_street_speed_limit),
    Fields.InValid_incident_location_indicator((SALT30.StrType)le.incident_location_indicator),
    Fields.InValid_loss_cross_street((SALT30.StrType)le.loss_cross_street),
    Fields.InValid_loss_cross_street_route_number((SALT30.StrType)le.loss_cross_street_route_number),
    Fields.InValid_loss_cross_street_intersecting_route_segment((SALT30.StrType)le.loss_cross_street_intersecting_route_segment),
    Fields.InValid_loss_cross_street_type((SALT30.StrType)le.loss_cross_street_type),
    Fields.InValid_loss_cross_street_speed_limit((SALT30.StrType)le.loss_cross_street_speed_limit),
    Fields.InValid_loss_cross_street_number_of_lanes((SALT30.StrType)le.loss_cross_street_number_of_lanes),
    Fields.InValid_loss_cross_street_orientation((SALT30.StrType)le.loss_cross_street_orientation),
    Fields.InValid_loss_cross_street_route_sign((SALT30.StrType)le.loss_cross_street_route_sign),
    Fields.InValid_at_node_number((SALT30.StrType)le.at_node_number),
    Fields.InValid_distance_from_node_feet((SALT30.StrType)le.distance_from_node_feet),
    Fields.InValid_distance_from_node_miles((SALT30.StrType)le.distance_from_node_miles),
    Fields.InValid_next_node_number((SALT30.StrType)le.next_node_number),
    Fields.InValid_next_roadway_node_number((SALT30.StrType)le.next_roadway_node_number),
    Fields.InValid_direction_of_travel((SALT30.StrType)le.direction_of_travel),
    Fields.InValid_next_street((SALT30.StrType)le.next_street),
    Fields.InValid_next_street_type((SALT30.StrType)le.next_street_type),
    Fields.InValid_next_street_suffix((SALT30.StrType)le.next_street_suffix),
    Fields.InValid_before_or_after_next_street((SALT30.StrType)le.before_or_after_next_street),
    Fields.InValid_next_street_distance_feet((SALT30.StrType)le.next_street_distance_feet),
    Fields.InValid_next_street_distance_miles((SALT30.StrType)le.next_street_distance_miles),
    Fields.InValid_next_street_direction((SALT30.StrType)le.next_street_direction),
    Fields.InValid_next_street_route_segment((SALT30.StrType)le.next_street_route_segment),
    Fields.InValid_continuing_toward_street((SALT30.StrType)le.continuing_toward_street),
    Fields.InValid_continuing_street_suffix((SALT30.StrType)le.continuing_street_suffix),
    Fields.InValid_continuing_street_direction((SALT30.StrType)le.continuing_street_direction),
    Fields.InValid_continuting_street_route_segment((SALT30.StrType)le.continuting_street_route_segment),
    Fields.InValid_city_type((SALT30.StrType)le.city_type),
    Fields.InValid_outside_city_indicator((SALT30.StrType)le.outside_city_indicator),
    Fields.InValid_outside_city_direction((SALT30.StrType)le.outside_city_direction),
    Fields.InValid_outside_city_distance_feet((SALT30.StrType)le.outside_city_distance_feet),
    Fields.InValid_outside_city_distance_miles((SALT30.StrType)le.outside_city_distance_miles),
    Fields.InValid_crash_type((SALT30.StrType)le.crash_type),
    Fields.InValid_motor_vehicle_involved_with((SALT30.StrType)le.motor_vehicle_involved_with),
    Fields.InValid_report_investigation_type((SALT30.StrType)le.report_investigation_type),
    Fields.InValid_incident_hit_and_run((SALT30.StrType)le.incident_hit_and_run),
    Fields.InValid_tow_away((SALT30.StrType)le.tow_away),
    Fields.InValid_date_notified((SALT30.StrType)le.date_notified),
    Fields.InValid_time_notified((SALT30.StrType)le.time_notified),
    Fields.InValid_notification_method((SALT30.StrType)le.notification_method),
    Fields.InValid_officer_arrival_time((SALT30.StrType)le.officer_arrival_time),
    Fields.InValid_officer_report_date((SALT30.StrType)le.officer_report_date),
    Fields.InValid_officer_report_time((SALT30.StrType)le.officer_report_time),
    Fields.InValid_officer_id((SALT30.StrType)le.officer_id),
    Fields.InValid_officer_department((SALT30.StrType)le.officer_department),
    Fields.InValid_officer_rank((SALT30.StrType)le.officer_rank),
    Fields.InValid_officer_command((SALT30.StrType)le.officer_command),
    Fields.InValid_officer_tax_id_number((SALT30.StrType)le.officer_tax_id_number),
    Fields.InValid_completed_report_date((SALT30.StrType)le.completed_report_date),
    Fields.InValid_supervisor_check_date((SALT30.StrType)le.supervisor_check_date),
    Fields.InValid_supervisor_check_time((SALT30.StrType)le.supervisor_check_time),
    Fields.InValid_supervisor_id((SALT30.StrType)le.supervisor_id),
    Fields.InValid_supervisor_rank((SALT30.StrType)le.supervisor_rank),
    Fields.InValid_reviewers_name((SALT30.StrType)le.reviewers_name),
    Fields.InValid_road_surface((SALT30.StrType)le.road_surface),
    Fields.InValid_roadway_alignment((SALT30.StrType)le.roadway_alignment),
    Fields.InValid_traffic_way_description((SALT30.StrType)le.traffic_way_description),
    Fields.InValid_traffic_flow((SALT30.StrType)le.traffic_flow),
    Fields.InValid_property_damage_involved((SALT30.StrType)le.property_damage_involved),
    Fields.InValid_property_damage_description1((SALT30.StrType)le.property_damage_description1),
    Fields.InValid_property_damage_description2((SALT30.StrType)le.property_damage_description2),
    Fields.InValid_property_damage_estimate1((SALT30.StrType)le.property_damage_estimate1),
    Fields.InValid_property_damage_estimate2((SALT30.StrType)le.property_damage_estimate2),
    Fields.InValid_incident_damage_over_limit((SALT30.StrType)le.incident_damage_over_limit),
    Fields.InValid_property_owner_notified((SALT30.StrType)le.property_owner_notified),
    Fields.InValid_government_property((SALT30.StrType)le.government_property),
    Fields.InValid_accident_condition((SALT30.StrType)le.accident_condition),
    Fields.InValid_unusual_road_condition1((SALT30.StrType)le.unusual_road_condition1),
    Fields.InValid_unusual_road_condition2((SALT30.StrType)le.unusual_road_condition2),
    Fields.InValid_number_of_lanes((SALT30.StrType)le.number_of_lanes),
    Fields.InValid_divided_highway((SALT30.StrType)le.divided_highway),
    Fields.InValid_most_harmful_event((SALT30.StrType)le.most_harmful_event),
    Fields.InValid_second_harmful_event((SALT30.StrType)le.second_harmful_event),
    Fields.InValid_ems_notified_date((SALT30.StrType)le.ems_notified_date),
    Fields.InValid_ems_arrival_date((SALT30.StrType)le.ems_arrival_date),
    Fields.InValid_hospital_arrival_date((SALT30.StrType)le.hospital_arrival_date),
    Fields.InValid_injured_taken_by((SALT30.StrType)le.injured_taken_by),
    Fields.InValid_injured_taken_to((SALT30.StrType)le.injured_taken_to),
    Fields.InValid_incident_transported_for_medical_care((SALT30.StrType)le.incident_transported_for_medical_care),
    Fields.InValid_photographs_taken((SALT30.StrType)le.photographs_taken),
    Fields.InValid_photographed_by((SALT30.StrType)le.photographed_by),
    Fields.InValid_photographer_id((SALT30.StrType)le.photographer_id),
    Fields.InValid_photography_agency_name((SALT30.StrType)le.photography_agency_name),
    Fields.InValid_agency_name((SALT30.StrType)le.agency_name),
    Fields.InValid_judicial_district((SALT30.StrType)le.judicial_district),
    Fields.InValid_precinct((SALT30.StrType)le.precinct),
    Fields.InValid_beat((SALT30.StrType)le.beat),
    Fields.InValid_location_type((SALT30.StrType)le.location_type),
    Fields.InValid_shoulder_type((SALT30.StrType)le.shoulder_type),
    Fields.InValid_investigation_complete((SALT30.StrType)le.investigation_complete),
    Fields.InValid_investigation_not_complete_why((SALT30.StrType)le.investigation_not_complete_why),
    Fields.InValid_investigating_officer_name((SALT30.StrType)le.investigating_officer_name),
    Fields.InValid_investigation_notification_issued((SALT30.StrType)le.investigation_notification_issued),
    Fields.InValid_agency_type((SALT30.StrType)le.agency_type),
    Fields.InValid_no_injury_tow_involved((SALT30.StrType)le.no_injury_tow_involved),
    Fields.InValid_injury_tow_involved((SALT30.StrType)le.injury_tow_involved),
    Fields.InValid_lars_code1((SALT30.StrType)le.lars_code1),
    Fields.InValid_lars_code2((SALT30.StrType)le.lars_code2),
    Fields.InValid_private_property_incident((SALT30.StrType)le.private_property_incident),
    Fields.InValid_accident_involvement((SALT30.StrType)le.accident_involvement),
    Fields.InValid_local_use((SALT30.StrType)le.local_use),
    Fields.InValid_street_prefix((SALT30.StrType)le.street_prefix),
    Fields.InValid_street_suffix((SALT30.StrType)le.street_suffix),
    Fields.InValid_toll_road((SALT30.StrType)le.toll_road),
    Fields.InValid_street_description((SALT30.StrType)le.street_description),
    Fields.InValid_cross_street_address_number((SALT30.StrType)le.cross_street_address_number),
    Fields.InValid_cross_street_prefix((SALT30.StrType)le.cross_street_prefix),
    Fields.InValid_cross_street_suffix((SALT30.StrType)le.cross_street_suffix),
    Fields.InValid_report_complete((SALT30.StrType)le.report_complete),
    Fields.InValid_dispatch_notified((SALT30.StrType)le.dispatch_notified),
    Fields.InValid_counter_report((SALT30.StrType)le.counter_report),
    Fields.InValid_road_type((SALT30.StrType)le.road_type),
    Fields.InValid_agency_code((SALT30.StrType)le.agency_code),
    Fields.InValid_public_property_employee((SALT30.StrType)le.public_property_employee),
    Fields.InValid_bridge_related((SALT30.StrType)le.bridge_related),
    Fields.InValid_ramp_indicator((SALT30.StrType)le.ramp_indicator),
    Fields.InValid_to_or_from_location((SALT30.StrType)le.to_or_from_location),
    Fields.InValid_complaint_number((SALT30.StrType)le.complaint_number),
    Fields.InValid_school_zone_related((SALT30.StrType)le.school_zone_related),
    Fields.InValid_notify_dot_maintenance((SALT30.StrType)le.notify_dot_maintenance),
    Fields.InValid_special_location((SALT30.StrType)le.special_location),
    Fields.InValid_route_segment((SALT30.StrType)le.route_segment),
    Fields.InValid_route_sign((SALT30.StrType)le.route_sign),
    Fields.InValid_route_category_street((SALT30.StrType)le.route_category_street),
    Fields.InValid_route_category_cross_street((SALT30.StrType)le.route_category_cross_street),
    Fields.InValid_route_category_next_street((SALT30.StrType)le.route_category_next_street),
    Fields.InValid_lane_closed((SALT30.StrType)le.lane_closed),
    Fields.InValid_lane_closure_direction((SALT30.StrType)le.lane_closure_direction),
    Fields.InValid_lane_direction((SALT30.StrType)le.lane_direction),
    Fields.InValid_traffic_detoured((SALT30.StrType)le.traffic_detoured),
    Fields.InValid_time_closed((SALT30.StrType)le.time_closed),
    Fields.InValid_pedestrian_signals((SALT30.StrType)le.pedestrian_signals),
    Fields.InValid_work_zone_speed_limit((SALT30.StrType)le.work_zone_speed_limit),
    Fields.InValid_work_zone_shoulder_median((SALT30.StrType)le.work_zone_shoulder_median),
    Fields.InValid_work_zone_intermittent_moving((SALT30.StrType)le.work_zone_intermittent_moving),
    Fields.InValid_work_zone_flagger_control((SALT30.StrType)le.work_zone_flagger_control),
    Fields.InValid_special_work_zone_characteristics((SALT30.StrType)le.special_work_zone_characteristics),
    Fields.InValid_lane_number((SALT30.StrType)le.lane_number),
    Fields.InValid_offset_distance_feet((SALT30.StrType)le.offset_distance_feet),
    Fields.InValid_offset_distance_miles((SALT30.StrType)le.offset_distance_miles),
    Fields.InValid_offset_direction((SALT30.StrType)le.offset_direction),
    Fields.InValid_asru_code((SALT30.StrType)le.asru_code),
    Fields.InValid_mp_grid((SALT30.StrType)le.mp_grid),
    Fields.InValid_number_of_qualifying_units((SALT30.StrType)le.number_of_qualifying_units),
    Fields.InValid_number_of_hazmat_vehicles((SALT30.StrType)le.number_of_hazmat_vehicles),
    Fields.InValid_number_of_buses_involved((SALT30.StrType)le.number_of_buses_involved),
    Fields.InValid_number_taken_to_treatment((SALT30.StrType)le.number_taken_to_treatment),
    Fields.InValid_number_vehicles_towed((SALT30.StrType)le.number_vehicles_towed),
    Fields.InValid_vehicle_at_fault_unit_number((SALT30.StrType)le.vehicle_at_fault_unit_number),
    Fields.InValid_time_officer_cleared_scene((SALT30.StrType)le.time_officer_cleared_scene),
    Fields.InValid_total_minutes_on_scene((SALT30.StrType)le.total_minutes_on_scene),
    Fields.InValid_motorists_report((SALT30.StrType)le.motorists_report),
    Fields.InValid_fatality_involved((SALT30.StrType)le.fatality_involved),
    Fields.InValid_local_dot_index_number((SALT30.StrType)le.local_dot_index_number),
    Fields.InValid_dor_number((SALT30.StrType)le.dor_number),
    Fields.InValid_hospital_code((SALT30.StrType)le.hospital_code),
    Fields.InValid_special_jurisdiction((SALT30.StrType)le.special_jurisdiction),
    Fields.InValid_document_type((SALT30.StrType)le.document_type),
    Fields.InValid_distance_was_measured((SALT30.StrType)le.distance_was_measured),
    Fields.InValid_street_orientation((SALT30.StrType)le.street_orientation),
    Fields.InValid_intersecting_route_segment((SALT30.StrType)le.intersecting_route_segment),
    Fields.InValid_primary_fault_indicator((SALT30.StrType)le.primary_fault_indicator),
    Fields.InValid_first_harmful_event_pedestrian((SALT30.StrType)le.first_harmful_event_pedestrian),
    Fields.InValid_reference_markers((SALT30.StrType)le.reference_markers),
    Fields.InValid_other_officer_on_scene((SALT30.StrType)le.other_officer_on_scene),
    Fields.InValid_other_officer_badge_number((SALT30.StrType)le.other_officer_badge_number),
    Fields.InValid_supplemental_report((SALT30.StrType)le.supplemental_report),
    Fields.InValid_supplemental_type((SALT30.StrType)le.supplemental_type),
    Fields.InValid_amended_report((SALT30.StrType)le.amended_report),
    Fields.InValid_corrected_report((SALT30.StrType)le.corrected_report),
    Fields.InValid_state_highway_related((SALT30.StrType)le.state_highway_related),
    Fields.InValid_roadway_lighting_condition((SALT30.StrType)le.roadway_lighting_condition),
    Fields.InValid_vendor_reference_number((SALT30.StrType)le.vendor_reference_number),
    Fields.InValid_duplicate_copy_unit_number((SALT30.StrType)le.duplicate_copy_unit_number),
    Fields.InValid_other_city_agency_description((SALT30.StrType)le.other_city_agency_description),
    Fields.InValid_notifcation_description((SALT30.StrType)le.notifcation_description),
    Fields.InValid_primary_collision_improper_driving_description((SALT30.StrType)le.primary_collision_improper_driving_description),
    Fields.InValid_weather_other_description((SALT30.StrType)le.weather_other_description),
    Fields.InValid_crash_type_description((SALT30.StrType)le.crash_type_description),
    Fields.InValid_motor_vehicle_involved_with_animal_description((SALT30.StrType)le.motor_vehicle_involved_with_animal_description),
    Fields.InValid_motor_vehicle_involved_with_fixed_object_description((SALT30.StrType)le.motor_vehicle_involved_with_fixed_object_description),
    Fields.InValid_motor_vehicle_involved_with_other_object_description((SALT30.StrType)le.motor_vehicle_involved_with_other_object_description),
    Fields.InValid_other_investigation_time((SALT30.StrType)le.other_investigation_time),
    Fields.InValid_milepost_detail((SALT30.StrType)le.milepost_detail),
    Fields.InValid_utility_pole_number1((SALT30.StrType)le.utility_pole_number1),
    Fields.InValid_utility_pole_number2((SALT30.StrType)le.utility_pole_number2),
    Fields.InValid_utility_pole_number3((SALT30.StrType)le.utility_pole_number3),
    Fields.InValid_person_id((SALT30.StrType)le.person_id),
    Fields.InValid_person_number((SALT30.StrType)le.person_number),
    Fields.InValid_vehicle_unit_number((SALT30.StrType)le.vehicle_unit_number),
    Fields.InValid_sex((SALT30.StrType)le.sex),
    Fields.InValid_person_type((SALT30.StrType)le.person_type),
    Fields.InValid_injury_status((SALT30.StrType)le.injury_status),
    Fields.InValid_occupant_vehicle_unit_number((SALT30.StrType)le.occupant_vehicle_unit_number),
    Fields.InValid_seating_position1((SALT30.StrType)le.seating_position1),
    Fields.InValid_safety_equipment_restraint1((SALT30.StrType)le.safety_equipment_restraint1),
    Fields.InValid_safety_equipment_restraint2((SALT30.StrType)le.safety_equipment_restraint2),
    Fields.InValid_safety_equipment_helmet((SALT30.StrType)le.safety_equipment_helmet),
    Fields.InValid_air_bag_deployed((SALT30.StrType)le.air_bag_deployed),
    Fields.InValid_ejection((SALT30.StrType)le.ejection),
    Fields.InValid_drivers_license_jurisdiction((SALT30.StrType)le.drivers_license_jurisdiction),
    Fields.InValid_dl_number_class((SALT30.StrType)le.dl_number_class),
    Fields.InValid_dl_number_cdl((SALT30.StrType)le.dl_number_cdl),
    Fields.InValid_dl_number_endorsements((SALT30.StrType)le.dl_number_endorsements),
    Fields.InValid_driver_actions_at_time_of_crash1((SALT30.StrType)le.driver_actions_at_time_of_crash1),
    Fields.InValid_driver_actions_at_time_of_crash2((SALT30.StrType)le.driver_actions_at_time_of_crash2),
    Fields.InValid_driver_actions_at_time_of_crash3((SALT30.StrType)le.driver_actions_at_time_of_crash3),
    Fields.InValid_driver_actions_at_time_of_crash4((SALT30.StrType)le.driver_actions_at_time_of_crash4),
    Fields.InValid_violation_codes((SALT30.StrType)le.violation_codes),
    Fields.InValid_condition_at_time_of_crash1((SALT30.StrType)le.condition_at_time_of_crash1),
    Fields.InValid_condition_at_time_of_crash2((SALT30.StrType)le.condition_at_time_of_crash2),
    Fields.InValid_law_enforcement_suspects_alcohol_use((SALT30.StrType)le.law_enforcement_suspects_alcohol_use),
    Fields.InValid_alcohol_test_status((SALT30.StrType)le.alcohol_test_status),
    Fields.InValid_alcohol_test_type((SALT30.StrType)le.alcohol_test_type),
    Fields.InValid_alcohol_test_result((SALT30.StrType)le.alcohol_test_result),
    Fields.InValid_law_enforcement_suspects_drug_use((SALT30.StrType)le.law_enforcement_suspects_drug_use),
    Fields.InValid_drug_test_given((SALT30.StrType)le.drug_test_given),
    Fields.InValid_non_motorist_actions_prior_to_crash1((SALT30.StrType)le.non_motorist_actions_prior_to_crash1),
    Fields.InValid_non_motorist_actions_prior_to_crash2((SALT30.StrType)le.non_motorist_actions_prior_to_crash2),
    Fields.InValid_non_motorist_actions_at_time_of_crash((SALT30.StrType)le.non_motorist_actions_at_time_of_crash),
    Fields.InValid_non_motorist_location_at_time_of_crash((SALT30.StrType)le.non_motorist_location_at_time_of_crash),
    Fields.InValid_non_motorist_safety_equipment1((SALT30.StrType)le.non_motorist_safety_equipment1),
    Fields.InValid_age((SALT30.StrType)le.age),
    Fields.InValid_driver_license_restrictions1((SALT30.StrType)le.driver_license_restrictions1),
    Fields.InValid_drug_test_type((SALT30.StrType)le.drug_test_type),
    Fields.InValid_drug_test_result1((SALT30.StrType)le.drug_test_result1),
    Fields.InValid_drug_test_result2((SALT30.StrType)le.drug_test_result2),
    Fields.InValid_drug_test_result3((SALT30.StrType)le.drug_test_result3),
    Fields.InValid_drug_test_result4((SALT30.StrType)le.drug_test_result4),
    Fields.InValid_injury_area((SALT30.StrType)le.injury_area),
    Fields.InValid_injury_description((SALT30.StrType)le.injury_description),
    Fields.InValid_motorcyclist_head_injury((SALT30.StrType)le.motorcyclist_head_injury),
    Fields.InValid_party_id((SALT30.StrType)le.party_id),
    Fields.InValid_same_as_driver((SALT30.StrType)le.same_as_driver),
    Fields.InValid_address_same_as_driver((SALT30.StrType)le.address_same_as_driver),
    Fields.InValid_last_name((SALT30.StrType)le.last_name),
    Fields.InValid_first_name((SALT30.StrType)le.first_name),
    Fields.InValid_middle_name((SALT30.StrType)le.middle_name),
    Fields.InValid_name_suffx((SALT30.StrType)le.name_suffx),
    Fields.InValid_date_of_birth((SALT30.StrType)le.date_of_birth),
    Fields.InValid_address((SALT30.StrType)le.address),
    Fields.InValid_city((SALT30.StrType)le.city),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_zip_code((SALT30.StrType)le.zip_code),
    Fields.InValid_home_phone((SALT30.StrType)le.home_phone),
    Fields.InValid_business_phone((SALT30.StrType)le.business_phone),
    Fields.InValid_insurance_company((SALT30.StrType)le.insurance_company),
    Fields.InValid_insurance_company_phone_number((SALT30.StrType)le.insurance_company_phone_number),
    Fields.InValid_insurance_policy_number((SALT30.StrType)le.insurance_policy_number),
    Fields.InValid_insurance_effective_date((SALT30.StrType)le.insurance_effective_date),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_drivers_license_number((SALT30.StrType)le.drivers_license_number),
    Fields.InValid_drivers_license_expiration((SALT30.StrType)le.drivers_license_expiration),
    Fields.InValid_eye_color((SALT30.StrType)le.eye_color),
    Fields.InValid_hair_color((SALT30.StrType)le.hair_color),
    Fields.InValid_height((SALT30.StrType)le.height),
    Fields.InValid_weight((SALT30.StrType)le.weight),
    Fields.InValid_race((SALT30.StrType)le.race),
    Fields.InValid_pedestrian_cyclist_visibility((SALT30.StrType)le.pedestrian_cyclist_visibility),
    Fields.InValid_first_aid_by((SALT30.StrType)le.first_aid_by),
    Fields.InValid_person_first_aid_party_type((SALT30.StrType)le.person_first_aid_party_type),
    Fields.InValid_person_first_aid_party_type_description((SALT30.StrType)le.person_first_aid_party_type_description),
    Fields.InValid_deceased_at_scene((SALT30.StrType)le.deceased_at_scene),
    Fields.InValid_death_date((SALT30.StrType)le.death_date),
    Fields.InValid_death_time((SALT30.StrType)le.death_time),
    Fields.InValid_extricated((SALT30.StrType)le.extricated),
    Fields.InValid_alcohol_drug_use((SALT30.StrType)le.alcohol_drug_use),
    Fields.InValid_physical_defects((SALT30.StrType)le.physical_defects),
    Fields.InValid_driver_residence((SALT30.StrType)le.driver_residence),
    Fields.InValid_id_type((SALT30.StrType)le.id_type),
    Fields.InValid_proof_of_insurance((SALT30.StrType)le.proof_of_insurance),
    Fields.InValid_insurance_expired((SALT30.StrType)le.insurance_expired),
    Fields.InValid_insurance_exempt((SALT30.StrType)le.insurance_exempt),
    Fields.InValid_insurance_type((SALT30.StrType)le.insurance_type),
    Fields.InValid_violent_crime_victim_notified((SALT30.StrType)le.violent_crime_victim_notified),
    Fields.InValid_insurance_company_code((SALT30.StrType)le.insurance_company_code),
    Fields.InValid_refused_medical_treatment((SALT30.StrType)le.refused_medical_treatment),
    Fields.InValid_safety_equipment_available_or_used((SALT30.StrType)le.safety_equipment_available_or_used),
    Fields.InValid_apartment_number((SALT30.StrType)le.apartment_number),
    Fields.InValid_licensed_driver((SALT30.StrType)le.licensed_driver),
    Fields.InValid_physical_emotional_status((SALT30.StrType)le.physical_emotional_status),
    Fields.InValid_driver_presence((SALT30.StrType)le.driver_presence),
    Fields.InValid_ejection_path((SALT30.StrType)le.ejection_path),
    Fields.InValid_state_person_id((SALT30.StrType)le.state_person_id),
    Fields.InValid_contributed_to_collision((SALT30.StrType)le.contributed_to_collision),
    Fields.InValid_person_transported_for_medical_care((SALT30.StrType)le.person_transported_for_medical_care),
    Fields.InValid_transported_by_agency_type((SALT30.StrType)le.transported_by_agency_type),
    Fields.InValid_transported_to((SALT30.StrType)le.transported_to),
    Fields.InValid_non_motorist_driver_license_number((SALT30.StrType)le.non_motorist_driver_license_number),
    Fields.InValid_air_bag_type((SALT30.StrType)le.air_bag_type),
    Fields.InValid_cell_phone_use((SALT30.StrType)le.cell_phone_use),
    Fields.InValid_driver_license_restriction_compliance((SALT30.StrType)le.driver_license_restriction_compliance),
    Fields.InValid_driver_license_endorsement_compliance((SALT30.StrType)le.driver_license_endorsement_compliance),
    Fields.InValid_driver_license_compliance((SALT30.StrType)le.driver_license_compliance),
    Fields.InValid_contributing_circumstances_p1((SALT30.StrType)le.contributing_circumstances_p1),
    Fields.InValid_contributing_circumstances_p2((SALT30.StrType)le.contributing_circumstances_p2),
    Fields.InValid_contributing_circumstances_p3((SALT30.StrType)le.contributing_circumstances_p3),
    Fields.InValid_contributing_circumstances_p4((SALT30.StrType)le.contributing_circumstances_p4),
    Fields.InValid_passenger_number((SALT30.StrType)le.passenger_number),
    Fields.InValid_person_deleted((SALT30.StrType)le.person_deleted),
    Fields.InValid_owner_lessee((SALT30.StrType)le.owner_lessee),
    Fields.InValid_driver_charged((SALT30.StrType)le.driver_charged),
    Fields.InValid_motorcycle_eye_protection((SALT30.StrType)le.motorcycle_eye_protection),
    Fields.InValid_motorcycle_long_sleeves((SALT30.StrType)le.motorcycle_long_sleeves),
    Fields.InValid_motorcycle_long_pants((SALT30.StrType)le.motorcycle_long_pants),
    Fields.InValid_motorcycle_over_ankle_boots((SALT30.StrType)le.motorcycle_over_ankle_boots),
    Fields.InValid_contributing_circumstances_environmental_non_incident1((SALT30.StrType)le.contributing_circumstances_environmental_non_incident1),
    Fields.InValid_contributing_circumstances_environmental_non_incident2((SALT30.StrType)le.contributing_circumstances_environmental_non_incident2),
    Fields.InValid_alcohol_drug_test_given((SALT30.StrType)le.alcohol_drug_test_given),
    Fields.InValid_alcohol_drug_test_type((SALT30.StrType)le.alcohol_drug_test_type),
    Fields.InValid_alcohol_drug_test_result((SALT30.StrType)le.alcohol_drug_test_result),
    Fields.InValid_vin((SALT30.StrType)le.vin),
    Fields.InValid_vin_status((SALT30.StrType)le.vin_status),
    Fields.InValid_damaged_areas_derived1((SALT30.StrType)le.damaged_areas_derived1),
    Fields.InValid_damaged_areas_derived2((SALT30.StrType)le.damaged_areas_derived2),
    Fields.InValid_airbags_deployed_derived((SALT30.StrType)le.airbags_deployed_derived),
    Fields.InValid_vehicle_towed_derived((SALT30.StrType)le.vehicle_towed_derived),
    Fields.InValid_unit_type((SALT30.StrType)le.unit_type),
    Fields.InValid_unit_number((SALT30.StrType)le.unit_number),
    Fields.InValid_registration_state((SALT30.StrType)le.registration_state),
    Fields.InValid_registration_year((SALT30.StrType)le.registration_year),
    Fields.InValid_license_plate((SALT30.StrType)le.license_plate),
    Fields.InValid_make((SALT30.StrType)le.make),
    Fields.InValid_model_yr((SALT30.StrType)le.model_yr),
    Fields.InValid_model((SALT30.StrType)le.model),
    Fields.InValid_body_type_category((SALT30.StrType)le.body_type_category),
    Fields.InValid_total_occupants_in_vehicle((SALT30.StrType)le.total_occupants_in_vehicle),
    Fields.InValid_special_function_in_transport((SALT30.StrType)le.special_function_in_transport),
    Fields.InValid_special_function_in_transport_other_unit((SALT30.StrType)le.special_function_in_transport_other_unit),
    Fields.InValid_emergency_use((SALT30.StrType)le.emergency_use),
    Fields.InValid_posted_satutory_speed_limit((SALT30.StrType)le.posted_satutory_speed_limit),
    Fields.InValid_direction_of_travel_before_crash((SALT30.StrType)le.direction_of_travel_before_crash),
    Fields.InValid_trafficway_description((SALT30.StrType)le.trafficway_description),
    Fields.InValid_traffic_control_device_type((SALT30.StrType)le.traffic_control_device_type),
    Fields.InValid_vehicle_maneuver_action_prior1((SALT30.StrType)le.vehicle_maneuver_action_prior1),
    Fields.InValid_vehicle_maneuver_action_prior2((SALT30.StrType)le.vehicle_maneuver_action_prior2),
    Fields.InValid_impact_area1((SALT30.StrType)le.impact_area1),
    Fields.InValid_impact_area2((SALT30.StrType)le.impact_area2),
    Fields.InValid_event_sequence1((SALT30.StrType)le.event_sequence1),
    Fields.InValid_event_sequence2((SALT30.StrType)le.event_sequence2),
    Fields.InValid_event_sequence3((SALT30.StrType)le.event_sequence3),
    Fields.InValid_event_sequence4((SALT30.StrType)le.event_sequence4),
    Fields.InValid_most_harmful_event_for_vehicle((SALT30.StrType)le.most_harmful_event_for_vehicle),
    Fields.InValid_bus_use((SALT30.StrType)le.bus_use),
    Fields.InValid_vehicle_hit_and_run((SALT30.StrType)le.vehicle_hit_and_run),
    Fields.InValid_vehicle_towed((SALT30.StrType)le.vehicle_towed),
    Fields.InValid_contributing_circumstances_v1((SALT30.StrType)le.contributing_circumstances_v1),
    Fields.InValid_contributing_circumstances_v2((SALT30.StrType)le.contributing_circumstances_v2),
    Fields.InValid_contributing_circumstances_v3((SALT30.StrType)le.contributing_circumstances_v3),
    Fields.InValid_contributing_circumstances_v4((SALT30.StrType)le.contributing_circumstances_v4),
    Fields.InValid_on_street((SALT30.StrType)le.on_street),
    Fields.InValid_vehicle_color((SALT30.StrType)le.vehicle_color),
    Fields.InValid_estimated_speed((SALT30.StrType)le.estimated_speed),
    Fields.InValid_accident_investigation_site((SALT30.StrType)le.accident_investigation_site),
    Fields.InValid_car_fire((SALT30.StrType)le.car_fire),
    Fields.InValid_vehicle_damage_amount((SALT30.StrType)le.vehicle_damage_amount),
    Fields.InValid_contributing_factors1((SALT30.StrType)le.contributing_factors1),
    Fields.InValid_contributing_factors2((SALT30.StrType)le.contributing_factors2),
    Fields.InValid_contributing_factors3((SALT30.StrType)le.contributing_factors3),
    Fields.InValid_contributing_factors4((SALT30.StrType)le.contributing_factors4),
    Fields.InValid_other_contributing_factors1((SALT30.StrType)le.other_contributing_factors1),
    Fields.InValid_other_contributing_factors2((SALT30.StrType)le.other_contributing_factors2),
    Fields.InValid_other_contributing_factors3((SALT30.StrType)le.other_contributing_factors3),
    Fields.InValid_vision_obscured1((SALT30.StrType)le.vision_obscured1),
    Fields.InValid_vision_obscured2((SALT30.StrType)le.vision_obscured2),
    Fields.InValid_vehicle_on_road((SALT30.StrType)le.vehicle_on_road),
    Fields.InValid_ran_off_road((SALT30.StrType)le.ran_off_road),
    Fields.InValid_skidding_occurred((SALT30.StrType)le.skidding_occurred),
    Fields.InValid_vehicle_incident_location1((SALT30.StrType)le.vehicle_incident_location1),
    Fields.InValid_vehicle_incident_location2((SALT30.StrType)le.vehicle_incident_location2),
    Fields.InValid_vehicle_incident_location3((SALT30.StrType)le.vehicle_incident_location3),
    Fields.InValid_vehicle_disabled((SALT30.StrType)le.vehicle_disabled),
    Fields.InValid_vehicle_removed_to((SALT30.StrType)le.vehicle_removed_to),
    Fields.InValid_removed_by((SALT30.StrType)le.removed_by),
    Fields.InValid_tow_requested_by_driver((SALT30.StrType)le.tow_requested_by_driver),
    Fields.InValid_solicitation((SALT30.StrType)le.solicitation),
    Fields.InValid_other_unit_vehicle_damage_amount((SALT30.StrType)le.other_unit_vehicle_damage_amount),
    Fields.InValid_other_unit_model_year((SALT30.StrType)le.other_unit_model_year),
    Fields.InValid_other_unit_make((SALT30.StrType)le.other_unit_make),
    Fields.InValid_other_unit_model((SALT30.StrType)le.other_unit_model),
    Fields.InValid_other_unit_vin((SALT30.StrType)le.other_unit_vin),
    Fields.InValid_other_unit_vin_status((SALT30.StrType)le.other_unit_vin_status),
    Fields.InValid_other_unit_body_type_category((SALT30.StrType)le.other_unit_body_type_category),
    Fields.InValid_other_unit_registration_state((SALT30.StrType)le.other_unit_registration_state),
    Fields.InValid_other_unit_registration_year((SALT30.StrType)le.other_unit_registration_year),
    Fields.InValid_other_unit_license_plate((SALT30.StrType)le.other_unit_license_plate),
    Fields.InValid_other_unit_color((SALT30.StrType)le.other_unit_color),
    Fields.InValid_other_unit_type((SALT30.StrType)le.other_unit_type),
    Fields.InValid_damaged_areas1((SALT30.StrType)le.damaged_areas1),
    Fields.InValid_damaged_areas2((SALT30.StrType)le.damaged_areas2),
    Fields.InValid_parked_vehicle((SALT30.StrType)le.parked_vehicle),
    Fields.InValid_damage_rating1((SALT30.StrType)le.damage_rating1),
    Fields.InValid_damage_rating2((SALT30.StrType)le.damage_rating2),
    Fields.InValid_vehicle_inventoried((SALT30.StrType)le.vehicle_inventoried),
    Fields.InValid_vehicle_defect_apparent((SALT30.StrType)le.vehicle_defect_apparent),
    Fields.InValid_defect_may_have_contributed1((SALT30.StrType)le.defect_may_have_contributed1),
    Fields.InValid_defect_may_have_contributed2((SALT30.StrType)le.defect_may_have_contributed2),
    Fields.InValid_registration_expiration((SALT30.StrType)le.registration_expiration),
    Fields.InValid_owner_driver_type((SALT30.StrType)le.owner_driver_type),
    Fields.InValid_make_code((SALT30.StrType)le.make_code),
    Fields.InValid_number_trailing_units((SALT30.StrType)le.number_trailing_units),
    Fields.InValid_vehicle_position((SALT30.StrType)le.vehicle_position),
    Fields.InValid_vehicle_type((SALT30.StrType)le.vehicle_type),
    Fields.InValid_motorcycle_engine_size((SALT30.StrType)le.motorcycle_engine_size),
    Fields.InValid_motorcycle_driver_educated((SALT30.StrType)le.motorcycle_driver_educated),
    Fields.InValid_motorcycle_helmet_type((SALT30.StrType)le.motorcycle_helmet_type),
    Fields.InValid_motorcycle_passenger((SALT30.StrType)le.motorcycle_passenger),
    Fields.InValid_motorcycle_helmet_stayed_on((SALT30.StrType)le.motorcycle_helmet_stayed_on),
    Fields.InValid_motorcycle_helmet_dot_snell((SALT30.StrType)le.motorcycle_helmet_dot_snell),
    Fields.InValid_motorcycle_saddlebag_trunk((SALT30.StrType)le.motorcycle_saddlebag_trunk),
    Fields.InValid_motorcycle_trailer((SALT30.StrType)le.motorcycle_trailer),
    Fields.InValid_pedacycle_passenger((SALT30.StrType)le.pedacycle_passenger),
    Fields.InValid_pedacycle_headlights((SALT30.StrType)le.pedacycle_headlights),
    Fields.InValid_pedacycle_helmet((SALT30.StrType)le.pedacycle_helmet),
    Fields.InValid_pedacycle_rear_reflectors((SALT30.StrType)le.pedacycle_rear_reflectors),
    Fields.InValid_cdl_required((SALT30.StrType)le.cdl_required),
    Fields.InValid_truck_bus_supplement_required((SALT30.StrType)le.truck_bus_supplement_required),
    Fields.InValid_unit_damage_amount((SALT30.StrType)le.unit_damage_amount),
    Fields.InValid_airbag_switch((SALT30.StrType)le.airbag_switch),
    Fields.InValid_underride_override_damage((SALT30.StrType)le.underride_override_damage),
    Fields.InValid_vehicle_attachment((SALT30.StrType)le.vehicle_attachment),
    Fields.InValid_action_on_impact((SALT30.StrType)le.action_on_impact),
    Fields.InValid_speed_detection_method((SALT30.StrType)le.speed_detection_method),
    Fields.InValid_non_motorist_direction_of_travel_from((SALT30.StrType)le.non_motorist_direction_of_travel_from),
    Fields.InValid_non_motorist_direction_of_travel_to((SALT30.StrType)le.non_motorist_direction_of_travel_to),
    Fields.InValid_vehicle_use((SALT30.StrType)le.vehicle_use),
    Fields.InValid_department_unit_number((SALT30.StrType)le.department_unit_number),
    Fields.InValid_equipment_in_use_at_time_of_accident((SALT30.StrType)le.equipment_in_use_at_time_of_accident),
    Fields.InValid_actions_of_police_vehicle((SALT30.StrType)le.actions_of_police_vehicle),
    Fields.InValid_vehicle_command_id((SALT30.StrType)le.vehicle_command_id),
    Fields.InValid_traffic_control_device_inoperative((SALT30.StrType)le.traffic_control_device_inoperative),
    Fields.InValid_direction_of_impact1((SALT30.StrType)le.direction_of_impact1),
    Fields.InValid_direction_of_impact2((SALT30.StrType)le.direction_of_impact2),
    Fields.InValid_ran_off_road_direction((SALT30.StrType)le.ran_off_road_direction),
    Fields.InValid_vin_other_unit_number((SALT30.StrType)le.vin_other_unit_number),
    Fields.InValid_damaged_area_generic((SALT30.StrType)le.damaged_area_generic),
    Fields.InValid_vision_obscured_description((SALT30.StrType)le.vision_obscured_description),
    Fields.InValid_inattention_description((SALT30.StrType)le.inattention_description),
    Fields.InValid_contributing_circumstances_defect_description((SALT30.StrType)le.contributing_circumstances_defect_description),
    Fields.InValid_contributing_circumstances_other_descriptioin((SALT30.StrType)le.contributing_circumstances_other_descriptioin),
    Fields.InValid_vehicle_maneuver_action_prior_other_description((SALT30.StrType)le.vehicle_maneuver_action_prior_other_description),
    Fields.InValid_vehicle_special_use((SALT30.StrType)le.vehicle_special_use),
    Fields.InValid_vehicle_type_extended1((SALT30.StrType)le.vehicle_type_extended1),
    Fields.InValid_vehicle_type_extended2((SALT30.StrType)le.vehicle_type_extended2),
    Fields.InValid_fixed_object_direction1((SALT30.StrType)le.fixed_object_direction1),
    Fields.InValid_fixed_object_direction2((SALT30.StrType)le.fixed_object_direction2),
    Fields.InValid_fixed_object_direction3((SALT30.StrType)le.fixed_object_direction3),
    Fields.InValid_fixed_object_direction4((SALT30.StrType)le.fixed_object_direction4),
    Fields.InValid_vehicle_left_at_scene((SALT30.StrType)le.vehicle_left_at_scene),
    Fields.InValid_vehicle_impounded((SALT30.StrType)le.vehicle_impounded),
    Fields.InValid_vehicle_driven_from_scene((SALT30.StrType)le.vehicle_driven_from_scene),
    Fields.InValid_on_cross_street((SALT30.StrType)le.on_cross_street),
    Fields.InValid_actions_of_police_vehicle_description((SALT30.StrType)le.actions_of_police_vehicle_description),
    Fields.InValid_vehicle_seg((SALT30.StrType)le.vehicle_seg),
    Fields.InValid_vehicle_seg_type((SALT30.StrType)le.vehicle_seg_type),
    Fields.InValid_model_year((SALT30.StrType)le.model_year),
    Fields.InValid_body_style_code((SALT30.StrType)le.body_style_code),
    Fields.InValid_engine_size((SALT30.StrType)le.engine_size),
    Fields.InValid_fuel_code((SALT30.StrType)le.fuel_code),
    Fields.InValid_number_of_driving_wheels((SALT30.StrType)le.number_of_driving_wheels),
    Fields.InValid_steering_type((SALT30.StrType)le.steering_type),
    Fields.InValid_vina_series((SALT30.StrType)le.vina_series),
    Fields.InValid_vina_model((SALT30.StrType)le.vina_model),
    Fields.InValid_vina_make((SALT30.StrType)le.vina_make),
    Fields.InValid_vina_body_style((SALT30.StrType)le.vina_body_style),
    Fields.InValid_make_description((SALT30.StrType)le.make_description),
    Fields.InValid_model_description((SALT30.StrType)le.model_description),
    Fields.InValid_series_description((SALT30.StrType)le.series_description),
    Fields.InValid_car_cylinders((SALT30.StrType)le.car_cylinders),
    Fields.InValid_other_vehicle_seg((SALT30.StrType)le.other_vehicle_seg),
    Fields.InValid_other_vehicle_seg_type((SALT30.StrType)le.other_vehicle_seg_type),
    Fields.InValid_other_model_year((SALT30.StrType)le.other_model_year),
    Fields.InValid_other_body_style_code((SALT30.StrType)le.other_body_style_code),
    Fields.InValid_other_engine_size((SALT30.StrType)le.other_engine_size),
    Fields.InValid_other_fuel_code((SALT30.StrType)le.other_fuel_code),
    Fields.InValid_other_number_of_driving_wheels((SALT30.StrType)le.other_number_of_driving_wheels),
    Fields.InValid_other_steering_type((SALT30.StrType)le.other_steering_type),
    Fields.InValid_other_vina_series((SALT30.StrType)le.other_vina_series),
    Fields.InValid_other_vina_model((SALT30.StrType)le.other_vina_model),
    Fields.InValid_other_vina_make((SALT30.StrType)le.other_vina_make),
    Fields.InValid_other_vina_body_style((SALT30.StrType)le.other_vina_body_style),
    Fields.InValid_other_make_description((SALT30.StrType)le.other_make_description),
    Fields.InValid_other_model_description((SALT30.StrType)le.other_model_description),
    Fields.InValid_other_series_description((SALT30.StrType)le.other_series_description),
    Fields.InValid_other_car_cylinders((SALT30.StrType)le.other_car_cylinders),
    Fields.InValid_report_has_coversheet((SALT30.StrType)le.report_has_coversheet),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_z5((SALT30.StrType)le.z5),
    Fields.InValid_z4((SALT30.StrType)le.z4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT30.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_county_code((SALT30.StrType)le.county_code),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_nametype((SALT30.StrType)le.nametype),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_suffix((SALT30.StrType)le.suffix),
    Fields.InValid_title2((SALT30.StrType)le.title2),
    Fields.InValid_fname2((SALT30.StrType)le.fname2),
    Fields.InValid_mname2((SALT30.StrType)le.mname2),
    Fields.InValid_lname2((SALT30.StrType)le.lname2),
    Fields.InValid_suffix2((SALT30.StrType)le.suffix2),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_did_score((SALT30.StrType)le.did_score),
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_bdid_score((SALT30.StrType)le.bdid_score),
    Fields.InValid_rawaid((SALT30.StrType)le.rawaid),
    Fields.InValid_law_enforcement_suspects_alcohol_use1((SALT30.StrType)le.law_enforcement_suspects_alcohol_use1),
    Fields.InValid_law_enforcement_suspects_drug_use1((SALT30.StrType)le.law_enforcement_suspects_drug_use1),
    Fields.InValid_ems_notified_time((SALT30.StrType)le.ems_notified_time),
    Fields.InValid_ems_arrival_time((SALT30.StrType)le.ems_arrival_time),
    Fields.InValid_avoidance_maneuver2((SALT30.StrType)le.avoidance_maneuver2),
    Fields.InValid_avoidance_maneuver3((SALT30.StrType)le.avoidance_maneuver3),
    Fields.InValid_avoidance_maneuver4((SALT30.StrType)le.avoidance_maneuver4),
    Fields.InValid_damaged_areas_severity1((SALT30.StrType)le.damaged_areas_severity1),
    Fields.InValid_damaged_areas_severity2((SALT30.StrType)le.damaged_areas_severity2),
    Fields.InValid_vehicle_outside_city_indicator((SALT30.StrType)le.vehicle_outside_city_indicator),
    Fields.InValid_vehicle_outside_city_distance_miles((SALT30.StrType)le.vehicle_outside_city_distance_miles),
    Fields.InValid_vehicle_outside_city_direction((SALT30.StrType)le.vehicle_outside_city_direction),
    Fields.InValid_vehicle_crash_cityplace((SALT30.StrType)le.vehicle_crash_cityplace),
    Fields.InValid_insurance_company_standardized((SALT30.StrType)le.insurance_company_standardized),
    Fields.InValid_insurance_expiration_date((SALT30.StrType)le.insurance_expiration_date),
    Fields.InValid_insurance_policy_holder((SALT30.StrType)le.insurance_policy_holder),
    Fields.InValid_is_tag_converted((SALT30.StrType)le.is_tag_converted),
    Fields.InValid_vin_original((SALT30.StrType)le.vin_original),
    Fields.InValid_make_original((SALT30.StrType)le.make_original),
    Fields.InValid_model_original((SALT30.StrType)le.model_original),
    Fields.InValid_model_year_original((SALT30.StrType)le.model_year_original),
    Fields.InValid_other_unit_vin_original((SALT30.StrType)le.other_unit_vin_original),
    Fields.InValid_other_unit_make_original((SALT30.StrType)le.other_unit_make_original),
    Fields.InValid_other_unit_model_original((SALT30.StrType)le.other_unit_model_original),
    Fields.InValid_other_unit_model_year_original((SALT30.StrType)le.other_unit_model_year_original),
    Fields.InValid_source_id((SALT30.StrType)le.source_id),
    Fields.InValid_orig_fname((SALT30.StrType)le.orig_fname),
    Fields.InValid_orig_lname((SALT30.StrType)le.orig_lname),
    Fields.InValid_orig_mname((SALT30.StrType)le.orig_mname),
    Fields.InValid_initial_point_of_contact((SALT30.StrType)le.initial_point_of_contact),
    Fields.InValid_vehicle_driveable((SALT30.StrType)le.vehicle_driveable),
    Fields.InValid_drivers_license_type((SALT30.StrType)le.drivers_license_type),
    Fields.InValid_alcohol_test_type_refused((SALT30.StrType)le.alcohol_test_type_refused),
    Fields.InValid_alcohol_test_type_not_offered((SALT30.StrType)le.alcohol_test_type_not_offered),
    Fields.InValid_alcohol_test_type_field((SALT30.StrType)le.alcohol_test_type_field),
    Fields.InValid_alcohol_test_type_pbt((SALT30.StrType)le.alcohol_test_type_pbt),
    Fields.InValid_alcohol_test_type_breath((SALT30.StrType)le.alcohol_test_type_breath),
    Fields.InValid_alcohol_test_type_blood((SALT30.StrType)le.alcohol_test_type_blood),
    Fields.InValid_alcohol_test_type_urine((SALT30.StrType)le.alcohol_test_type_urine),
    Fields.InValid_trapped((SALT30.StrType)le.trapped),
    Fields.InValid_dl_number_cdl_endorsements((SALT30.StrType)le.dl_number_cdl_endorsements),
    Fields.InValid_dl_number_cdl_restrictions((SALT30.StrType)le.dl_number_cdl_restrictions),
    Fields.InValid_dl_number_cdl_exempt((SALT30.StrType)le.dl_number_cdl_exempt),
    Fields.InValid_dl_number_cdl_medical_card((SALT30.StrType)le.dl_number_cdl_medical_card),
    Fields.InValid_interlock_device_in_use((SALT30.StrType)le.interlock_device_in_use),
    Fields.InValid_drug_test_type_blood((SALT30.StrType)le.drug_test_type_blood),
    Fields.InValid_drug_test_type_urine((SALT30.StrType)le.drug_test_type_urine),
    Fields.InValid_traffic_control_condition((SALT30.StrType)le.traffic_control_condition),
    Fields.InValid_intersection_related((SALT30.StrType)le.intersection_related),
    Fields.InValid_special_study_local((SALT30.StrType)le.special_study_local),
    Fields.InValid_special_study_state((SALT30.StrType)le.special_study_state),
    Fields.InValid_off_road_vehicle_involved((SALT30.StrType)le.off_road_vehicle_involved),
    Fields.InValid_location_type2((SALT30.StrType)le.location_type2),
    Fields.InValid_speed_limit_posted((SALT30.StrType)le.speed_limit_posted),
    Fields.InValid_traffic_control_damage_notify_date((SALT30.StrType)le.traffic_control_damage_notify_date),
    Fields.InValid_traffic_control_damage_notify_time((SALT30.StrType)le.traffic_control_damage_notify_time),
    Fields.InValid_traffic_control_damage_notify_name((SALT30.StrType)le.traffic_control_damage_notify_name),
    Fields.InValid_public_property_damaged((SALT30.StrType)le.public_property_damaged),
    Fields.InValid_replacement_report((SALT30.StrType)le.replacement_report),
    Fields.InValid_deleted_report((SALT30.StrType)le.deleted_report),
    Fields.InValid_next_street_prefix((SALT30.StrType)le.next_street_prefix),
    Fields.InValid_violator_name((SALT30.StrType)le.violator_name),
    Fields.InValid_type_hazardous((SALT30.StrType)le.type_hazardous),
    Fields.InValid_type_other((SALT30.StrType)le.type_other),
    Fields.InValid_unit_type_and_axles1((SALT30.StrType)le.unit_type_and_axles1),
    Fields.InValid_unit_type_and_axles2((SALT30.StrType)le.unit_type_and_axles2),
    Fields.InValid_unit_type_and_axles3((SALT30.StrType)le.unit_type_and_axles3),
    Fields.InValid_unit_type_and_axles4((SALT30.StrType)le.unit_type_and_axles4),
    Fields.InValid_incident_damage_amount((SALT30.StrType)le.incident_damage_amount),
    Fields.InValid_dot_use((SALT30.StrType)le.dot_use),
    Fields.InValid_number_of_persons_involved((SALT30.StrType)le.number_of_persons_involved),
    Fields.InValid_unusual_road_condition_other_description((SALT30.StrType)le.unusual_road_condition_other_description),
    Fields.InValid_number_of_narrative_sections((SALT30.StrType)le.number_of_narrative_sections),
    Fields.InValid_cad_number((SALT30.StrType)le.cad_number),
    Fields.InValid_visibility((SALT30.StrType)le.visibility),
    Fields.InValid_accident_at_intersection((SALT30.StrType)le.accident_at_intersection),
    Fields.InValid_accident_not_at_intersection((SALT30.StrType)le.accident_not_at_intersection),
    Fields.InValid_first_harmful_event_within_interchange((SALT30.StrType)le.first_harmful_event_within_interchange),
    Fields.InValid_injury_involved((SALT30.StrType)le.injury_involved),
    Fields.InValid_citation_status((SALT30.StrType)le.citation_status),
    Fields.InValid_commercial_vehicle((SALT30.StrType)le.commercial_vehicle),
    Fields.InValid_not_in_transport((SALT30.StrType)le.not_in_transport),
    Fields.InValid_other_unit_number((SALT30.StrType)le.other_unit_number),
    Fields.InValid_other_unit_length((SALT30.StrType)le.other_unit_length),
    Fields.InValid_other_unit_axles((SALT30.StrType)le.other_unit_axles),
    Fields.InValid_other_unit_plate_expiration((SALT30.StrType)le.other_unit_plate_expiration),
    Fields.InValid_other_unit_permanent_registration((SALT30.StrType)le.other_unit_permanent_registration),
    Fields.InValid_other_unit_model_year2((SALT30.StrType)le.other_unit_model_year2),
    Fields.InValid_other_unit_make2((SALT30.StrType)le.other_unit_make2),
    Fields.InValid_other_unit_vin2((SALT30.StrType)le.other_unit_vin2),
    Fields.InValid_other_unit_registration_state2((SALT30.StrType)le.other_unit_registration_state2),
    Fields.InValid_other_unit_registration_year2((SALT30.StrType)le.other_unit_registration_year2),
    Fields.InValid_other_unit_license_plate2((SALT30.StrType)le.other_unit_license_plate2),
    Fields.InValid_other_unit_number2((SALT30.StrType)le.other_unit_number2),
    Fields.InValid_other_unit_length2((SALT30.StrType)le.other_unit_length2),
    Fields.InValid_other_unit_axles2((SALT30.StrType)le.other_unit_axles2),
    Fields.InValid_other_unit_plate_expiration2((SALT30.StrType)le.other_unit_plate_expiration2),
    Fields.InValid_other_unit_permanent_registration2((SALT30.StrType)le.other_unit_permanent_registration2),
    Fields.InValid_other_unit_type2((SALT30.StrType)le.other_unit_type2),
    Fields.InValid_other_unit_model_year3((SALT30.StrType)le.other_unit_model_year3),
    Fields.InValid_other_unit_make3((SALT30.StrType)le.other_unit_make3),
    Fields.InValid_other_unit_vin3((SALT30.StrType)le.other_unit_vin3),
    Fields.InValid_other_unit_registration_state3((SALT30.StrType)le.other_unit_registration_state3),
    Fields.InValid_other_unit_registration_year3((SALT30.StrType)le.other_unit_registration_year3),
    Fields.InValid_other_unit_license_plate3((SALT30.StrType)le.other_unit_license_plate3),
    Fields.InValid_other_unit_number3((SALT30.StrType)le.other_unit_number3),
    Fields.InValid_other_unit_length3((SALT30.StrType)le.other_unit_length3),
    Fields.InValid_other_unit_axles3((SALT30.StrType)le.other_unit_axles3),
    Fields.InValid_other_unit_plate_expiration3((SALT30.StrType)le.other_unit_plate_expiration3),
    Fields.InValid_other_unit_permanent_registration3((SALT30.StrType)le.other_unit_permanent_registration3),
    Fields.InValid_other_unit_type3((SALT30.StrType)le.other_unit_type3),
    Fields.InValid_damaged_areas3((SALT30.StrType)le.damaged_areas3),
    Fields.InValid_driver_distracted_by((SALT30.StrType)le.driver_distracted_by),
    Fields.InValid_non_motorist_type((SALT30.StrType)le.non_motorist_type),
    Fields.InValid_seating_position_row((SALT30.StrType)le.seating_position_row),
    Fields.InValid_seating_position_seat((SALT30.StrType)le.seating_position_seat),
    Fields.InValid_seating_position_description((SALT30.StrType)le.seating_position_description),
    Fields.InValid_transported_id_number((SALT30.StrType)le.transported_id_number),
    Fields.InValid_witness_number((SALT30.StrType)le.witness_number),
    Fields.InValid_date_of_birth_derived((SALT30.StrType)le.date_of_birth_derived),
    Fields.InValid_property_damage_id((SALT30.StrType)le.property_damage_id),
    Fields.InValid_property_owner_name((SALT30.StrType)le.property_owner_name),
    Fields.InValid_damage_description((SALT30.StrType)le.damage_description),
    Fields.InValid_damage_estimate((SALT30.StrType)le.damage_estimate),
    Fields.InValid_narrative((SALT30.StrType)le.narrative),
    Fields.InValid_narrative_continuance((SALT30.StrType)le.narrative_continuance),
    Fields.InValid_hazardous_materials_hazmat_placard_number1((SALT30.StrType)le.hazardous_materials_hazmat_placard_number1),
    Fields.InValid_hazardous_materials_hazmat_placard_number2((SALT30.StrType)le.hazardous_materials_hazmat_placard_number2),
    Fields.InValid_vendor_code((SALT30.StrType)le.vendor_code),
    Fields.InValid_report_property_damage((SALT30.StrType)le.report_property_damage),
    Fields.InValid_report_collision_type((SALT30.StrType)le.report_collision_type),
    Fields.InValid_report_first_harmful_event((SALT30.StrType)le.report_first_harmful_event),
    Fields.InValid_report_light_condition((SALT30.StrType)le.report_light_condition),
    Fields.InValid_report_weather_condition((SALT30.StrType)le.report_weather_condition),
    Fields.InValid_report_road_condition((SALT30.StrType)le.report_road_condition),
    Fields.InValid_report_injury_status((SALT30.StrType)le.report_injury_status),
    Fields.InValid_report_damage_extent((SALT30.StrType)le.report_damage_extent),
    Fields.InValid_report_vehicle_type((SALT30.StrType)le.report_vehicle_type),
    Fields.InValid_report_traffic_control_device_type((SALT30.StrType)le.report_traffic_control_device_type),
    Fields.InValid_report_contributing_circumstances_v((SALT30.StrType)le.report_contributing_circumstances_v),
    Fields.InValid_report_vehicle_maneuver_action_prior((SALT30.StrType)le.report_vehicle_maneuver_action_prior),
    Fields.InValid_report_vehicle_body_type((SALT30.StrType)le.report_vehicle_body_type),
    Fields.InValid_cru_agency_name((SALT30.StrType)le.cru_agency_name),
    Fields.InValid_cru_agency_id((SALT30.StrType)le.cru_agency_id),
    Fields.InValid_cname((SALT30.StrType)le.cname),
    Fields.InValid_name_type((SALT30.StrType)le.name_type),
    Fields.InValid_vendor_report_id((SALT30.StrType)le.vendor_report_id),
    Fields.InValid_is_available_for_public((SALT30.StrType)le.is_available_for_public),
    Fields.InValid_has_addendum((SALT30.StrType)le.has_addendum),
    Fields.InValid_report_agency_ori((SALT30.StrType)le.report_agency_ori),
    Fields.InValid_report_status((SALT30.StrType)le.report_status),
    Fields.InValid_super_report_id((SALT30.StrType)le.super_report_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.report_code := le.report_code;
END;
Errors := NORMALIZE(h,840,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.report_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,report_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.report_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_date','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_case','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_name','invalid_name','invalid_name','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_report_code(TotalErrors.ErrorNum),Fields.InValidMessage_report_category(TotalErrors.ErrorNum),Fields.InValidMessage_report_code_desc(TotalErrors.ErrorNum),Fields.InValidMessage_citation_id(TotalErrors.ErrorNum),Fields.InValidMessage_creation_date(TotalErrors.ErrorNum),Fields.InValidMessage_incident_id(TotalErrors.ErrorNum),Fields.InValidMessage_citation_issued(TotalErrors.ErrorNum),Fields.InValidMessage_citation_number1(TotalErrors.ErrorNum),Fields.InValidMessage_citation_number2(TotalErrors.ErrorNum),Fields.InValidMessage_section_number1(TotalErrors.ErrorNum),Fields.InValidMessage_court_date(TotalErrors.ErrorNum),Fields.InValidMessage_court_time(TotalErrors.ErrorNum),Fields.InValidMessage_citation_detail1(TotalErrors.ErrorNum),Fields.InValidMessage_local_code(TotalErrors.ErrorNum),Fields.InValidMessage_violation_code1(TotalErrors.ErrorNum),Fields.InValidMessage_violation_code2(TotalErrors.ErrorNum),Fields.InValidMessage_multiple_charges_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_dui_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_id(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_id(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_info_source(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_vehicle_type(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_dot_number(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_state_id(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_carrier_name(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_address(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_city(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_state(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_motor_carrier_id_commercial_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_id_type(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_dot_permit_number(TotalErrors.ErrorNum),Fields.InValidMessage_iccmc_number(TotalErrors.ErrorNum),Fields.InValidMessage_mcs_vehicle_inspection(TotalErrors.ErrorNum),Fields.InValidMessage_mcs_form_number(TotalErrors.ErrorNum),Fields.InValidMessage_mcs_out_of_service(TotalErrors.ErrorNum),Fields.InValidMessage_mcs_violation_related(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_axles(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_tires(TotalErrors.ErrorNum),Fields.InValidMessage_gvw_over_10k_pounds(TotalErrors.ErrorNum),Fields.InValidMessage_weight_rating(TotalErrors.ErrorNum),Fields.InValidMessage_registered_gross_vehicle_weight(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_length_feet(TotalErrors.ErrorNum),Fields.InValidMessage_cargo_body_type(TotalErrors.ErrorNum),Fields.InValidMessage_load_type(TotalErrors.ErrorNum),Fields.InValidMessage_oversize_load(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_configuration(TotalErrors.ErrorNum),Fields.InValidMessage_trailer1_type(TotalErrors.ErrorNum),Fields.InValidMessage_trailer1_length_feet(TotalErrors.ErrorNum),Fields.InValidMessage_trailer1_width_feet(TotalErrors.ErrorNum),Fields.InValidMessage_trailer2_type(TotalErrors.ErrorNum),Fields.InValidMessage_trailer2_length_feet(TotalErrors.ErrorNum),Fields.InValidMessage_trailer2_width_feet(TotalErrors.ErrorNum),Fields.InValidMessage_federally_reportable(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_inspection_hazmat(TotalErrors.ErrorNum),Fields.InValidMessage_hazmat_form_number(TotalErrors.ErrorNum),Fields.InValidMessage_hazmt_out_of_service(TotalErrors.ErrorNum),Fields.InValidMessage_hazmat_violation_related(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_placard(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_class_number1(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_class_number2(TotalErrors.ErrorNum),Fields.InValidMessage_hazmat_placard_name(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_released1(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_released2(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_released3(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_released4(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_event1(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_event2(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_event3(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_event4(TotalErrors.ErrorNum),Fields.InValidMessage_recommended_driver_reexam(TotalErrors.ErrorNum),Fields.InValidMessage_transporting_hazmat(TotalErrors.ErrorNum),Fields.InValidMessage_liquid_hazmat_volume(TotalErrors.ErrorNum),Fields.InValidMessage_oversize_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_overlength_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_oversize_vehicle_permitted(TotalErrors.ErrorNum),Fields.InValidMessage_overlength_vehicle_permitted(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_commerce_type(TotalErrors.ErrorNum),Fields.InValidMessage_citation_issued_to_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_cdl_class(TotalErrors.ErrorNum),Fields.InValidMessage_dot_state(TotalErrors.ErrorNum),Fields.InValidMessage_fire_hazardous_materials_involvement(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_event_description(TotalErrors.ErrorNum),Fields.InValidMessage_supplment_required_hazmat_placard(TotalErrors.ErrorNum),Fields.InValidMessage_other_state_number1(TotalErrors.ErrorNum),Fields.InValidMessage_other_state_number2(TotalErrors.ErrorNum),Fields.InValidMessage_work_type_id(TotalErrors.ErrorNum),Fields.InValidMessage_report_id(TotalErrors.ErrorNum),Fields.InValidMessage_agency_id(TotalErrors.ErrorNum),Fields.InValidMessage_sent_to_hpcc_datetime(TotalErrors.ErrorNum),Fields.InValidMessage_corrected_incident(TotalErrors.ErrorNum),Fields.InValidMessage_cru_order_id(TotalErrors.ErrorNum),Fields.InValidMessage_cru_sequence_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_loss_state_abbr(TotalErrors.ErrorNum),Fields.InValidMessage_report_type_id(TotalErrors.ErrorNum),Fields.InValidMessage_hash_key(TotalErrors.ErrorNum),Fields.InValidMessage_case_identifier(TotalErrors.ErrorNum),Fields.InValidMessage_crash_county(TotalErrors.ErrorNum),Fields.InValidMessage_county_cd(TotalErrors.ErrorNum),Fields.InValidMessage_crash_cityplace(TotalErrors.ErrorNum),Fields.InValidMessage_crash_city(TotalErrors.ErrorNum),Fields.InValidMessage_city_code(TotalErrors.ErrorNum),Fields.InValidMessage_first_harmful_event(TotalErrors.ErrorNum),Fields.InValidMessage_first_harmful_event_location(TotalErrors.ErrorNum),Fields.InValidMessage_manner_crash_impact1(TotalErrors.ErrorNum),Fields.InValidMessage_weather_condition1(TotalErrors.ErrorNum),Fields.InValidMessage_weather_condition2(TotalErrors.ErrorNum),Fields.InValidMessage_light_condition1(TotalErrors.ErrorNum),Fields.InValidMessage_light_condition2(TotalErrors.ErrorNum),Fields.InValidMessage_road_surface_condition(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental2(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental3(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental4(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_road1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_road2(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_road3(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_road4(TotalErrors.ErrorNum),Fields.InValidMessage_relation_to_junction(TotalErrors.ErrorNum),Fields.InValidMessage_intersection_type(TotalErrors.ErrorNum),Fields.InValidMessage_school_bus_related(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_related(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_location(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_type(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_workers_present(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_law_enforcement_present(TotalErrors.ErrorNum),Fields.InValidMessage_crash_severity(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_vehicles(TotalErrors.ErrorNum),Fields.InValidMessage_total_nonfatal_injuries(TotalErrors.ErrorNum),Fields.InValidMessage_total_fatal_injuries(TotalErrors.ErrorNum),Fields.InValidMessage_day_of_week(TotalErrors.ErrorNum),Fields.InValidMessage_roadway_curvature(TotalErrors.ErrorNum),Fields.InValidMessage_part_of_national_highway_system(TotalErrors.ErrorNum),Fields.InValidMessage_roadway_functional_class(TotalErrors.ErrorNum),Fields.InValidMessage_access_control(TotalErrors.ErrorNum),Fields.InValidMessage_rr_crossing_id(TotalErrors.ErrorNum),Fields.InValidMessage_roadway_lighting(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_type_at_intersection1(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_type_at_intersection2(TotalErrors.ErrorNum),Fields.InValidMessage_ncic_number(TotalErrors.ErrorNum),Fields.InValidMessage_state_report_number(TotalErrors.ErrorNum),Fields.InValidMessage_ori_number(TotalErrors.ErrorNum),Fields.InValidMessage_crash_date(TotalErrors.ErrorNum),Fields.InValidMessage_crash_time(TotalErrors.ErrorNum),Fields.InValidMessage_lattitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_milepost1(TotalErrors.ErrorNum),Fields.InValidMessage_milepost2(TotalErrors.ErrorNum),Fields.InValidMessage_address_number(TotalErrors.ErrorNum),Fields.InValidMessage_loss_street(TotalErrors.ErrorNum),Fields.InValidMessage_loss_street_route_number(TotalErrors.ErrorNum),Fields.InValidMessage_loss_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_loss_street_speed_limit(TotalErrors.ErrorNum),Fields.InValidMessage_incident_location_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_route_number(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_intersecting_route_segment(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_speed_limit(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_number_of_lanes(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_orientation(TotalErrors.ErrorNum),Fields.InValidMessage_loss_cross_street_route_sign(TotalErrors.ErrorNum),Fields.InValidMessage_at_node_number(TotalErrors.ErrorNum),Fields.InValidMessage_distance_from_node_feet(TotalErrors.ErrorNum),Fields.InValidMessage_distance_from_node_miles(TotalErrors.ErrorNum),Fields.InValidMessage_next_node_number(TotalErrors.ErrorNum),Fields.InValidMessage_next_roadway_node_number(TotalErrors.ErrorNum),Fields.InValidMessage_direction_of_travel(TotalErrors.ErrorNum),Fields.InValidMessage_next_street(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_type(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_before_or_after_next_street(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_distance_feet(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_distance_miles(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_direction(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_route_segment(TotalErrors.ErrorNum),Fields.InValidMessage_continuing_toward_street(TotalErrors.ErrorNum),Fields.InValidMessage_continuing_street_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_continuing_street_direction(TotalErrors.ErrorNum),Fields.InValidMessage_continuting_street_route_segment(TotalErrors.ErrorNum),Fields.InValidMessage_city_type(TotalErrors.ErrorNum),Fields.InValidMessage_outside_city_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_outside_city_direction(TotalErrors.ErrorNum),Fields.InValidMessage_outside_city_distance_feet(TotalErrors.ErrorNum),Fields.InValidMessage_outside_city_distance_miles(TotalErrors.ErrorNum),Fields.InValidMessage_crash_type(TotalErrors.ErrorNum),Fields.InValidMessage_motor_vehicle_involved_with(TotalErrors.ErrorNum),Fields.InValidMessage_report_investigation_type(TotalErrors.ErrorNum),Fields.InValidMessage_incident_hit_and_run(TotalErrors.ErrorNum),Fields.InValidMessage_tow_away(TotalErrors.ErrorNum),Fields.InValidMessage_date_notified(TotalErrors.ErrorNum),Fields.InValidMessage_time_notified(TotalErrors.ErrorNum),Fields.InValidMessage_notification_method(TotalErrors.ErrorNum),Fields.InValidMessage_officer_arrival_time(TotalErrors.ErrorNum),Fields.InValidMessage_officer_report_date(TotalErrors.ErrorNum),Fields.InValidMessage_officer_report_time(TotalErrors.ErrorNum),Fields.InValidMessage_officer_id(TotalErrors.ErrorNum),Fields.InValidMessage_officer_department(TotalErrors.ErrorNum),Fields.InValidMessage_officer_rank(TotalErrors.ErrorNum),Fields.InValidMessage_officer_command(TotalErrors.ErrorNum),Fields.InValidMessage_officer_tax_id_number(TotalErrors.ErrorNum),Fields.InValidMessage_completed_report_date(TotalErrors.ErrorNum),Fields.InValidMessage_supervisor_check_date(TotalErrors.ErrorNum),Fields.InValidMessage_supervisor_check_time(TotalErrors.ErrorNum),Fields.InValidMessage_supervisor_id(TotalErrors.ErrorNum),Fields.InValidMessage_supervisor_rank(TotalErrors.ErrorNum),Fields.InValidMessage_reviewers_name(TotalErrors.ErrorNum),Fields.InValidMessage_road_surface(TotalErrors.ErrorNum),Fields.InValidMessage_roadway_alignment(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_way_description(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_flow(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_involved(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_description1(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_description2(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_estimate1(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_estimate2(TotalErrors.ErrorNum),Fields.InValidMessage_incident_damage_over_limit(TotalErrors.ErrorNum),Fields.InValidMessage_property_owner_notified(TotalErrors.ErrorNum),Fields.InValidMessage_government_property(TotalErrors.ErrorNum),Fields.InValidMessage_accident_condition(TotalErrors.ErrorNum),Fields.InValidMessage_unusual_road_condition1(TotalErrors.ErrorNum),Fields.InValidMessage_unusual_road_condition2(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_lanes(TotalErrors.ErrorNum),Fields.InValidMessage_divided_highway(TotalErrors.ErrorNum),Fields.InValidMessage_most_harmful_event(TotalErrors.ErrorNum),Fields.InValidMessage_second_harmful_event(TotalErrors.ErrorNum),Fields.InValidMessage_ems_notified_date(TotalErrors.ErrorNum),Fields.InValidMessage_ems_arrival_date(TotalErrors.ErrorNum),Fields.InValidMessage_hospital_arrival_date(TotalErrors.ErrorNum),Fields.InValidMessage_injured_taken_by(TotalErrors.ErrorNum),Fields.InValidMessage_injured_taken_to(TotalErrors.ErrorNum),Fields.InValidMessage_incident_transported_for_medical_care(TotalErrors.ErrorNum),Fields.InValidMessage_photographs_taken(TotalErrors.ErrorNum),Fields.InValidMessage_photographed_by(TotalErrors.ErrorNum),Fields.InValidMessage_photographer_id(TotalErrors.ErrorNum),Fields.InValidMessage_photography_agency_name(TotalErrors.ErrorNum),Fields.InValidMessage_agency_name(TotalErrors.ErrorNum),Fields.InValidMessage_judicial_district(TotalErrors.ErrorNum),Fields.InValidMessage_precinct(TotalErrors.ErrorNum),Fields.InValidMessage_beat(TotalErrors.ErrorNum),Fields.InValidMessage_location_type(TotalErrors.ErrorNum),Fields.InValidMessage_shoulder_type(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_complete(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_not_complete_why(TotalErrors.ErrorNum),Fields.InValidMessage_investigating_officer_name(TotalErrors.ErrorNum),Fields.InValidMessage_investigation_notification_issued(TotalErrors.ErrorNum),Fields.InValidMessage_agency_type(TotalErrors.ErrorNum),Fields.InValidMessage_no_injury_tow_involved(TotalErrors.ErrorNum),Fields.InValidMessage_injury_tow_involved(TotalErrors.ErrorNum),Fields.InValidMessage_lars_code1(TotalErrors.ErrorNum),Fields.InValidMessage_lars_code2(TotalErrors.ErrorNum),Fields.InValidMessage_private_property_incident(TotalErrors.ErrorNum),Fields.InValidMessage_accident_involvement(TotalErrors.ErrorNum),Fields.InValidMessage_local_use(TotalErrors.ErrorNum),Fields.InValidMessage_street_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_street_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_toll_road(TotalErrors.ErrorNum),Fields.InValidMessage_street_description(TotalErrors.ErrorNum),Fields.InValidMessage_cross_street_address_number(TotalErrors.ErrorNum),Fields.InValidMessage_cross_street_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_cross_street_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_report_complete(TotalErrors.ErrorNum),Fields.InValidMessage_dispatch_notified(TotalErrors.ErrorNum),Fields.InValidMessage_counter_report(TotalErrors.ErrorNum),Fields.InValidMessage_road_type(TotalErrors.ErrorNum),Fields.InValidMessage_agency_code(TotalErrors.ErrorNum),Fields.InValidMessage_public_property_employee(TotalErrors.ErrorNum),Fields.InValidMessage_bridge_related(TotalErrors.ErrorNum),Fields.InValidMessage_ramp_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_to_or_from_location(TotalErrors.ErrorNum),Fields.InValidMessage_complaint_number(TotalErrors.ErrorNum),Fields.InValidMessage_school_zone_related(TotalErrors.ErrorNum),Fields.InValidMessage_notify_dot_maintenance(TotalErrors.ErrorNum),Fields.InValidMessage_special_location(TotalErrors.ErrorNum),Fields.InValidMessage_route_segment(TotalErrors.ErrorNum),Fields.InValidMessage_route_sign(TotalErrors.ErrorNum),Fields.InValidMessage_route_category_street(TotalErrors.ErrorNum),Fields.InValidMessage_route_category_cross_street(TotalErrors.ErrorNum),Fields.InValidMessage_route_category_next_street(TotalErrors.ErrorNum),Fields.InValidMessage_lane_closed(TotalErrors.ErrorNum),Fields.InValidMessage_lane_closure_direction(TotalErrors.ErrorNum),Fields.InValidMessage_lane_direction(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_detoured(TotalErrors.ErrorNum),Fields.InValidMessage_time_closed(TotalErrors.ErrorNum),Fields.InValidMessage_pedestrian_signals(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_speed_limit(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_shoulder_median(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_intermittent_moving(TotalErrors.ErrorNum),Fields.InValidMessage_work_zone_flagger_control(TotalErrors.ErrorNum),Fields.InValidMessage_special_work_zone_characteristics(TotalErrors.ErrorNum),Fields.InValidMessage_lane_number(TotalErrors.ErrorNum),Fields.InValidMessage_offset_distance_feet(TotalErrors.ErrorNum),Fields.InValidMessage_offset_distance_miles(TotalErrors.ErrorNum),Fields.InValidMessage_offset_direction(TotalErrors.ErrorNum),Fields.InValidMessage_asru_code(TotalErrors.ErrorNum),Fields.InValidMessage_mp_grid(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_qualifying_units(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_hazmat_vehicles(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_buses_involved(TotalErrors.ErrorNum),Fields.InValidMessage_number_taken_to_treatment(TotalErrors.ErrorNum),Fields.InValidMessage_number_vehicles_towed(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_at_fault_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_time_officer_cleared_scene(TotalErrors.ErrorNum),Fields.InValidMessage_total_minutes_on_scene(TotalErrors.ErrorNum),Fields.InValidMessage_motorists_report(TotalErrors.ErrorNum),Fields.InValidMessage_fatality_involved(TotalErrors.ErrorNum),Fields.InValidMessage_local_dot_index_number(TotalErrors.ErrorNum),Fields.InValidMessage_dor_number(TotalErrors.ErrorNum),Fields.InValidMessage_hospital_code(TotalErrors.ErrorNum),Fields.InValidMessage_special_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_document_type(TotalErrors.ErrorNum),Fields.InValidMessage_distance_was_measured(TotalErrors.ErrorNum),Fields.InValidMessage_street_orientation(TotalErrors.ErrorNum),Fields.InValidMessage_intersecting_route_segment(TotalErrors.ErrorNum),Fields.InValidMessage_primary_fault_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_first_harmful_event_pedestrian(TotalErrors.ErrorNum),Fields.InValidMessage_reference_markers(TotalErrors.ErrorNum),Fields.InValidMessage_other_officer_on_scene(TotalErrors.ErrorNum),Fields.InValidMessage_other_officer_badge_number(TotalErrors.ErrorNum),Fields.InValidMessage_supplemental_report(TotalErrors.ErrorNum),Fields.InValidMessage_supplemental_type(TotalErrors.ErrorNum),Fields.InValidMessage_amended_report(TotalErrors.ErrorNum),Fields.InValidMessage_corrected_report(TotalErrors.ErrorNum),Fields.InValidMessage_state_highway_related(TotalErrors.ErrorNum),Fields.InValidMessage_roadway_lighting_condition(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_reference_number(TotalErrors.ErrorNum),Fields.InValidMessage_duplicate_copy_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_other_city_agency_description(TotalErrors.ErrorNum),Fields.InValidMessage_notifcation_description(TotalErrors.ErrorNum),Fields.InValidMessage_primary_collision_improper_driving_description(TotalErrors.ErrorNum),Fields.InValidMessage_weather_other_description(TotalErrors.ErrorNum),Fields.InValidMessage_crash_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_motor_vehicle_involved_with_animal_description(TotalErrors.ErrorNum),Fields.InValidMessage_motor_vehicle_involved_with_fixed_object_description(TotalErrors.ErrorNum),Fields.InValidMessage_motor_vehicle_involved_with_other_object_description(TotalErrors.ErrorNum),Fields.InValidMessage_other_investigation_time(TotalErrors.ErrorNum),Fields.InValidMessage_milepost_detail(TotalErrors.ErrorNum),Fields.InValidMessage_utility_pole_number1(TotalErrors.ErrorNum),Fields.InValidMessage_utility_pole_number2(TotalErrors.ErrorNum),Fields.InValidMessage_utility_pole_number3(TotalErrors.ErrorNum),Fields.InValidMessage_person_id(TotalErrors.ErrorNum),Fields.InValidMessage_person_number(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_sex(TotalErrors.ErrorNum),Fields.InValidMessage_person_type(TotalErrors.ErrorNum),Fields.InValidMessage_injury_status(TotalErrors.ErrorNum),Fields.InValidMessage_occupant_vehicle_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_seating_position1(TotalErrors.ErrorNum),Fields.InValidMessage_safety_equipment_restraint1(TotalErrors.ErrorNum),Fields.InValidMessage_safety_equipment_restraint2(TotalErrors.ErrorNum),Fields.InValidMessage_safety_equipment_helmet(TotalErrors.ErrorNum),Fields.InValidMessage_air_bag_deployed(TotalErrors.ErrorNum),Fields.InValidMessage_ejection(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_jurisdiction(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_class(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_cdl(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_driver_actions_at_time_of_crash1(TotalErrors.ErrorNum),Fields.InValidMessage_driver_actions_at_time_of_crash2(TotalErrors.ErrorNum),Fields.InValidMessage_driver_actions_at_time_of_crash3(TotalErrors.ErrorNum),Fields.InValidMessage_driver_actions_at_time_of_crash4(TotalErrors.ErrorNum),Fields.InValidMessage_violation_codes(TotalErrors.ErrorNum),Fields.InValidMessage_condition_at_time_of_crash1(TotalErrors.ErrorNum),Fields.InValidMessage_condition_at_time_of_crash2(TotalErrors.ErrorNum),Fields.InValidMessage_law_enforcement_suspects_alcohol_use(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_status(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_result(TotalErrors.ErrorNum),Fields.InValidMessage_law_enforcement_suspects_drug_use(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_given(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_actions_prior_to_crash1(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_actions_prior_to_crash2(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_actions_at_time_of_crash(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_location_at_time_of_crash(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_safety_equipment1(TotalErrors.ErrorNum),Fields.InValidMessage_age(TotalErrors.ErrorNum),Fields.InValidMessage_driver_license_restrictions1(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_type(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_result1(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_result2(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_result3(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_result4(TotalErrors.ErrorNum),Fields.InValidMessage_injury_area(TotalErrors.ErrorNum),Fields.InValidMessage_injury_description(TotalErrors.ErrorNum),Fields.InValidMessage_motorcyclist_head_injury(TotalErrors.ErrorNum),Fields.InValidMessage_party_id(TotalErrors.ErrorNum),Fields.InValidMessage_same_as_driver(TotalErrors.ErrorNum),Fields.InValidMessage_address_same_as_driver(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffx(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_home_phone(TotalErrors.ErrorNum),Fields.InValidMessage_business_phone(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_company(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_company_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_policy_number(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_effective_date(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_number(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_expiration(TotalErrors.ErrorNum),Fields.InValidMessage_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_height(TotalErrors.ErrorNum),Fields.InValidMessage_weight(TotalErrors.ErrorNum),Fields.InValidMessage_race(TotalErrors.ErrorNum),Fields.InValidMessage_pedestrian_cyclist_visibility(TotalErrors.ErrorNum),Fields.InValidMessage_first_aid_by(TotalErrors.ErrorNum),Fields.InValidMessage_person_first_aid_party_type(TotalErrors.ErrorNum),Fields.InValidMessage_person_first_aid_party_type_description(TotalErrors.ErrorNum),Fields.InValidMessage_deceased_at_scene(TotalErrors.ErrorNum),Fields.InValidMessage_death_date(TotalErrors.ErrorNum),Fields.InValidMessage_death_time(TotalErrors.ErrorNum),Fields.InValidMessage_extricated(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_drug_use(TotalErrors.ErrorNum),Fields.InValidMessage_physical_defects(TotalErrors.ErrorNum),Fields.InValidMessage_driver_residence(TotalErrors.ErrorNum),Fields.InValidMessage_id_type(TotalErrors.ErrorNum),Fields.InValidMessage_proof_of_insurance(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_expired(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_exempt(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_type(TotalErrors.ErrorNum),Fields.InValidMessage_violent_crime_victim_notified(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_company_code(TotalErrors.ErrorNum),Fields.InValidMessage_refused_medical_treatment(TotalErrors.ErrorNum),Fields.InValidMessage_safety_equipment_available_or_used(TotalErrors.ErrorNum),Fields.InValidMessage_apartment_number(TotalErrors.ErrorNum),Fields.InValidMessage_licensed_driver(TotalErrors.ErrorNum),Fields.InValidMessage_physical_emotional_status(TotalErrors.ErrorNum),Fields.InValidMessage_driver_presence(TotalErrors.ErrorNum),Fields.InValidMessage_ejection_path(TotalErrors.ErrorNum),Fields.InValidMessage_state_person_id(TotalErrors.ErrorNum),Fields.InValidMessage_contributed_to_collision(TotalErrors.ErrorNum),Fields.InValidMessage_person_transported_for_medical_care(TotalErrors.ErrorNum),Fields.InValidMessage_transported_by_agency_type(TotalErrors.ErrorNum),Fields.InValidMessage_transported_to(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_driver_license_number(TotalErrors.ErrorNum),Fields.InValidMessage_air_bag_type(TotalErrors.ErrorNum),Fields.InValidMessage_cell_phone_use(TotalErrors.ErrorNum),Fields.InValidMessage_driver_license_restriction_compliance(TotalErrors.ErrorNum),Fields.InValidMessage_driver_license_endorsement_compliance(TotalErrors.ErrorNum),Fields.InValidMessage_driver_license_compliance(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_p1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_p2(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_p3(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_p4(TotalErrors.ErrorNum),Fields.InValidMessage_passenger_number(TotalErrors.ErrorNum),Fields.InValidMessage_person_deleted(TotalErrors.ErrorNum),Fields.InValidMessage_owner_lessee(TotalErrors.ErrorNum),Fields.InValidMessage_driver_charged(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_eye_protection(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_long_sleeves(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_long_pants(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_over_ankle_boots(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental_non_incident1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_environmental_non_incident2(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_drug_test_given(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_drug_test_type(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_drug_test_result(TotalErrors.ErrorNum),Fields.InValidMessage_vin(TotalErrors.ErrorNum),Fields.InValidMessage_vin_status(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas_derived1(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas_derived2(TotalErrors.ErrorNum),Fields.InValidMessage_airbags_deployed_derived(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_towed_derived(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_registration_state(TotalErrors.ErrorNum),Fields.InValidMessage_registration_year(TotalErrors.ErrorNum),Fields.InValidMessage_license_plate(TotalErrors.ErrorNum),Fields.InValidMessage_make(TotalErrors.ErrorNum),Fields.InValidMessage_model_yr(TotalErrors.ErrorNum),Fields.InValidMessage_model(TotalErrors.ErrorNum),Fields.InValidMessage_body_type_category(TotalErrors.ErrorNum),Fields.InValidMessage_total_occupants_in_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_special_function_in_transport(TotalErrors.ErrorNum),Fields.InValidMessage_special_function_in_transport_other_unit(TotalErrors.ErrorNum),Fields.InValidMessage_emergency_use(TotalErrors.ErrorNum),Fields.InValidMessage_posted_satutory_speed_limit(TotalErrors.ErrorNum),Fields.InValidMessage_direction_of_travel_before_crash(TotalErrors.ErrorNum),Fields.InValidMessage_trafficway_description(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_device_type(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_maneuver_action_prior1(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_maneuver_action_prior2(TotalErrors.ErrorNum),Fields.InValidMessage_impact_area1(TotalErrors.ErrorNum),Fields.InValidMessage_impact_area2(TotalErrors.ErrorNum),Fields.InValidMessage_event_sequence1(TotalErrors.ErrorNum),Fields.InValidMessage_event_sequence2(TotalErrors.ErrorNum),Fields.InValidMessage_event_sequence3(TotalErrors.ErrorNum),Fields.InValidMessage_event_sequence4(TotalErrors.ErrorNum),Fields.InValidMessage_most_harmful_event_for_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_bus_use(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_hit_and_run(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_towed(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_v1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_v2(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_v3(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_v4(TotalErrors.ErrorNum),Fields.InValidMessage_on_street(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_color(TotalErrors.ErrorNum),Fields.InValidMessage_estimated_speed(TotalErrors.ErrorNum),Fields.InValidMessage_accident_investigation_site(TotalErrors.ErrorNum),Fields.InValidMessage_car_fire(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_damage_amount(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_factors1(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_factors2(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_factors3(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_factors4(TotalErrors.ErrorNum),Fields.InValidMessage_other_contributing_factors1(TotalErrors.ErrorNum),Fields.InValidMessage_other_contributing_factors2(TotalErrors.ErrorNum),Fields.InValidMessage_other_contributing_factors3(TotalErrors.ErrorNum),Fields.InValidMessage_vision_obscured1(TotalErrors.ErrorNum),Fields.InValidMessage_vision_obscured2(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_on_road(TotalErrors.ErrorNum),Fields.InValidMessage_ran_off_road(TotalErrors.ErrorNum),Fields.InValidMessage_skidding_occurred(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_incident_location1(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_incident_location2(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_incident_location3(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_disabled(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_removed_to(TotalErrors.ErrorNum),Fields.InValidMessage_removed_by(TotalErrors.ErrorNum),Fields.InValidMessage_tow_requested_by_driver(TotalErrors.ErrorNum),Fields.InValidMessage_solicitation(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vehicle_damage_amount(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model_year(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_make(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vin(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vin_status(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_body_type_category(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_state(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_year(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_license_plate(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_color(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_type(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas1(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas2(TotalErrors.ErrorNum),Fields.InValidMessage_parked_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_damage_rating1(TotalErrors.ErrorNum),Fields.InValidMessage_damage_rating2(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_inventoried(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_defect_apparent(TotalErrors.ErrorNum),Fields.InValidMessage_defect_may_have_contributed1(TotalErrors.ErrorNum),Fields.InValidMessage_defect_may_have_contributed2(TotalErrors.ErrorNum),Fields.InValidMessage_registration_expiration(TotalErrors.ErrorNum),Fields.InValidMessage_owner_driver_type(TotalErrors.ErrorNum),Fields.InValidMessage_make_code(TotalErrors.ErrorNum),Fields.InValidMessage_number_trailing_units(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_position(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_type(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_engine_size(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_driver_educated(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_helmet_type(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_passenger(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_helmet_stayed_on(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_helmet_dot_snell(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_saddlebag_trunk(TotalErrors.ErrorNum),Fields.InValidMessage_motorcycle_trailer(TotalErrors.ErrorNum),Fields.InValidMessage_pedacycle_passenger(TotalErrors.ErrorNum),Fields.InValidMessage_pedacycle_headlights(TotalErrors.ErrorNum),Fields.InValidMessage_pedacycle_helmet(TotalErrors.ErrorNum),Fields.InValidMessage_pedacycle_rear_reflectors(TotalErrors.ErrorNum),Fields.InValidMessage_cdl_required(TotalErrors.ErrorNum),Fields.InValidMessage_truck_bus_supplement_required(TotalErrors.ErrorNum),Fields.InValidMessage_unit_damage_amount(TotalErrors.ErrorNum),Fields.InValidMessage_airbag_switch(TotalErrors.ErrorNum),Fields.InValidMessage_underride_override_damage(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_attachment(TotalErrors.ErrorNum),Fields.InValidMessage_action_on_impact(TotalErrors.ErrorNum),Fields.InValidMessage_speed_detection_method(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_direction_of_travel_from(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_direction_of_travel_to(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_use(TotalErrors.ErrorNum),Fields.InValidMessage_department_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_equipment_in_use_at_time_of_accident(TotalErrors.ErrorNum),Fields.InValidMessage_actions_of_police_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_command_id(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_device_inoperative(TotalErrors.ErrorNum),Fields.InValidMessage_direction_of_impact1(TotalErrors.ErrorNum),Fields.InValidMessage_direction_of_impact2(TotalErrors.ErrorNum),Fields.InValidMessage_ran_off_road_direction(TotalErrors.ErrorNum),Fields.InValidMessage_vin_other_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_area_generic(TotalErrors.ErrorNum),Fields.InValidMessage_vision_obscured_description(TotalErrors.ErrorNum),Fields.InValidMessage_inattention_description(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_defect_description(TotalErrors.ErrorNum),Fields.InValidMessage_contributing_circumstances_other_descriptioin(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_maneuver_action_prior_other_description(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_special_use(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_type_extended1(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_type_extended2(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_object_direction1(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_object_direction2(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_object_direction3(TotalErrors.ErrorNum),Fields.InValidMessage_fixed_object_direction4(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_left_at_scene(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_impounded(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_driven_from_scene(TotalErrors.ErrorNum),Fields.InValidMessage_on_cross_street(TotalErrors.ErrorNum),Fields.InValidMessage_actions_of_police_vehicle_description(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_seg(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_seg_type(TotalErrors.ErrorNum),Fields.InValidMessage_model_year(TotalErrors.ErrorNum),Fields.InValidMessage_body_style_code(TotalErrors.ErrorNum),Fields.InValidMessage_engine_size(TotalErrors.ErrorNum),Fields.InValidMessage_fuel_code(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_driving_wheels(TotalErrors.ErrorNum),Fields.InValidMessage_steering_type(TotalErrors.ErrorNum),Fields.InValidMessage_vina_series(TotalErrors.ErrorNum),Fields.InValidMessage_vina_model(TotalErrors.ErrorNum),Fields.InValidMessage_vina_make(TotalErrors.ErrorNum),Fields.InValidMessage_vina_body_style(TotalErrors.ErrorNum),Fields.InValidMessage_make_description(TotalErrors.ErrorNum),Fields.InValidMessage_model_description(TotalErrors.ErrorNum),Fields.InValidMessage_series_description(TotalErrors.ErrorNum),Fields.InValidMessage_car_cylinders(TotalErrors.ErrorNum),Fields.InValidMessage_other_vehicle_seg(TotalErrors.ErrorNum),Fields.InValidMessage_other_vehicle_seg_type(TotalErrors.ErrorNum),Fields.InValidMessage_other_model_year(TotalErrors.ErrorNum),Fields.InValidMessage_other_body_style_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_engine_size(TotalErrors.ErrorNum),Fields.InValidMessage_other_fuel_code(TotalErrors.ErrorNum),Fields.InValidMessage_other_number_of_driving_wheels(TotalErrors.ErrorNum),Fields.InValidMessage_other_steering_type(TotalErrors.ErrorNum),Fields.InValidMessage_other_vina_series(TotalErrors.ErrorNum),Fields.InValidMessage_other_vina_model(TotalErrors.ErrorNum),Fields.InValidMessage_other_vina_make(TotalErrors.ErrorNum),Fields.InValidMessage_other_vina_body_style(TotalErrors.ErrorNum),Fields.InValidMessage_other_make_description(TotalErrors.ErrorNum),Fields.InValidMessage_other_model_description(TotalErrors.ErrorNum),Fields.InValidMessage_other_series_description(TotalErrors.ErrorNum),Fields.InValidMessage_other_car_cylinders(TotalErrors.ErrorNum),Fields.InValidMessage_report_has_coversheet(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_z5(TotalErrors.ErrorNum),Fields.InValidMessage_z4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county_code(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_nametype(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_title2(TotalErrors.ErrorNum),Fields.InValidMessage_fname2(TotalErrors.ErrorNum),Fields.InValidMessage_mname2(TotalErrors.ErrorNum),Fields.InValidMessage_lname2(TotalErrors.ErrorNum),Fields.InValidMessage_suffix2(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_law_enforcement_suspects_alcohol_use1(TotalErrors.ErrorNum),Fields.InValidMessage_law_enforcement_suspects_drug_use1(TotalErrors.ErrorNum),Fields.InValidMessage_ems_notified_time(TotalErrors.ErrorNum),Fields.InValidMessage_ems_arrival_time(TotalErrors.ErrorNum),Fields.InValidMessage_avoidance_maneuver2(TotalErrors.ErrorNum),Fields.InValidMessage_avoidance_maneuver3(TotalErrors.ErrorNum),Fields.InValidMessage_avoidance_maneuver4(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas_severity1(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas_severity2(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_outside_city_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_outside_city_distance_miles(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_outside_city_direction(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_crash_cityplace(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_company_standardized(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_insurance_policy_holder(TotalErrors.ErrorNum),Fields.InValidMessage_is_tag_converted(TotalErrors.ErrorNum),Fields.InValidMessage_vin_original(TotalErrors.ErrorNum),Fields.InValidMessage_make_original(TotalErrors.ErrorNum),Fields.InValidMessage_model_original(TotalErrors.ErrorNum),Fields.InValidMessage_model_year_original(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vin_original(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_make_original(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model_original(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model_year_original(TotalErrors.ErrorNum),Fields.InValidMessage_source_id(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_initial_point_of_contact(TotalErrors.ErrorNum),Fields.InValidMessage_vehicle_driveable(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_refused(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_not_offered(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_field(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_pbt(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_breath(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_blood(TotalErrors.ErrorNum),Fields.InValidMessage_alcohol_test_type_urine(TotalErrors.ErrorNum),Fields.InValidMessage_trapped(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_cdl_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_cdl_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_cdl_exempt(TotalErrors.ErrorNum),Fields.InValidMessage_dl_number_cdl_medical_card(TotalErrors.ErrorNum),Fields.InValidMessage_interlock_device_in_use(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_type_blood(TotalErrors.ErrorNum),Fields.InValidMessage_drug_test_type_urine(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_condition(TotalErrors.ErrorNum),Fields.InValidMessage_intersection_related(TotalErrors.ErrorNum),Fields.InValidMessage_special_study_local(TotalErrors.ErrorNum),Fields.InValidMessage_special_study_state(TotalErrors.ErrorNum),Fields.InValidMessage_off_road_vehicle_involved(TotalErrors.ErrorNum),Fields.InValidMessage_location_type2(TotalErrors.ErrorNum),Fields.InValidMessage_speed_limit_posted(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_damage_notify_date(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_damage_notify_time(TotalErrors.ErrorNum),Fields.InValidMessage_traffic_control_damage_notify_name(TotalErrors.ErrorNum),Fields.InValidMessage_public_property_damaged(TotalErrors.ErrorNum),Fields.InValidMessage_replacement_report(TotalErrors.ErrorNum),Fields.InValidMessage_deleted_report(TotalErrors.ErrorNum),Fields.InValidMessage_next_street_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_violator_name(TotalErrors.ErrorNum),Fields.InValidMessage_type_hazardous(TotalErrors.ErrorNum),Fields.InValidMessage_type_other(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type_and_axles1(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type_and_axles2(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type_and_axles3(TotalErrors.ErrorNum),Fields.InValidMessage_unit_type_and_axles4(TotalErrors.ErrorNum),Fields.InValidMessage_incident_damage_amount(TotalErrors.ErrorNum),Fields.InValidMessage_dot_use(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_persons_involved(TotalErrors.ErrorNum),Fields.InValidMessage_unusual_road_condition_other_description(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_narrative_sections(TotalErrors.ErrorNum),Fields.InValidMessage_cad_number(TotalErrors.ErrorNum),Fields.InValidMessage_visibility(TotalErrors.ErrorNum),Fields.InValidMessage_accident_at_intersection(TotalErrors.ErrorNum),Fields.InValidMessage_accident_not_at_intersection(TotalErrors.ErrorNum),Fields.InValidMessage_first_harmful_event_within_interchange(TotalErrors.ErrorNum),Fields.InValidMessage_injury_involved(TotalErrors.ErrorNum),Fields.InValidMessage_citation_status(TotalErrors.ErrorNum),Fields.InValidMessage_commercial_vehicle(TotalErrors.ErrorNum),Fields.InValidMessage_not_in_transport(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_number(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_length(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_axles(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_plate_expiration(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_permanent_registration(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model_year2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_make2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vin2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_state2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_year2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_license_plate2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_number2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_length2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_axles2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_plate_expiration2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_permanent_registration2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_type2(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_model_year3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_make3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_vin3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_state3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_registration_year3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_license_plate3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_number3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_length3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_axles3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_plate_expiration3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_permanent_registration3(TotalErrors.ErrorNum),Fields.InValidMessage_other_unit_type3(TotalErrors.ErrorNum),Fields.InValidMessage_damaged_areas3(TotalErrors.ErrorNum),Fields.InValidMessage_driver_distracted_by(TotalErrors.ErrorNum),Fields.InValidMessage_non_motorist_type(TotalErrors.ErrorNum),Fields.InValidMessage_seating_position_row(TotalErrors.ErrorNum),Fields.InValidMessage_seating_position_seat(TotalErrors.ErrorNum),Fields.InValidMessage_seating_position_description(TotalErrors.ErrorNum),Fields.InValidMessage_transported_id_number(TotalErrors.ErrorNum),Fields.InValidMessage_witness_number(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth_derived(TotalErrors.ErrorNum),Fields.InValidMessage_property_damage_id(TotalErrors.ErrorNum),Fields.InValidMessage_property_owner_name(TotalErrors.ErrorNum),Fields.InValidMessage_damage_description(TotalErrors.ErrorNum),Fields.InValidMessage_damage_estimate(TotalErrors.ErrorNum),Fields.InValidMessage_narrative(TotalErrors.ErrorNum),Fields.InValidMessage_narrative_continuance(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_hazmat_placard_number1(TotalErrors.ErrorNum),Fields.InValidMessage_hazardous_materials_hazmat_placard_number2(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_code(TotalErrors.ErrorNum),Fields.InValidMessage_report_property_damage(TotalErrors.ErrorNum),Fields.InValidMessage_report_collision_type(TotalErrors.ErrorNum),Fields.InValidMessage_report_first_harmful_event(TotalErrors.ErrorNum),Fields.InValidMessage_report_light_condition(TotalErrors.ErrorNum),Fields.InValidMessage_report_weather_condition(TotalErrors.ErrorNum),Fields.InValidMessage_report_road_condition(TotalErrors.ErrorNum),Fields.InValidMessage_report_injury_status(TotalErrors.ErrorNum),Fields.InValidMessage_report_damage_extent(TotalErrors.ErrorNum),Fields.InValidMessage_report_vehicle_type(TotalErrors.ErrorNum),Fields.InValidMessage_report_traffic_control_device_type(TotalErrors.ErrorNum),Fields.InValidMessage_report_contributing_circumstances_v(TotalErrors.ErrorNum),Fields.InValidMessage_report_vehicle_maneuver_action_prior(TotalErrors.ErrorNum),Fields.InValidMessage_report_vehicle_body_type(TotalErrors.ErrorNum),Fields.InValidMessage_cru_agency_name(TotalErrors.ErrorNum),Fields.InValidMessage_cru_agency_id(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_report_id(TotalErrors.ErrorNum),Fields.InValidMessage_is_available_for_public(TotalErrors.ErrorNum),Fields.InValidMessage_has_addendum(TotalErrors.ErrorNum),Fields.InValidMessage_report_agency_ori(TotalErrors.ErrorNum),Fields.InValidMessage_report_status(TotalErrors.ErrorNum),Fields.InValidMessage_super_report_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.report_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;

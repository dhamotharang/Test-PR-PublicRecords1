IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Watercraft_Coastguard) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_code);    NumberOfRecords := COUNT(GROUP);
    populated_watercraft_key_pcnt := AVE(GROUP,IF(h.watercraft_key = (TYPEOF(h.watercraft_key))'',0,100));
    maxlength_watercraft_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_key)));
    avelength_watercraft_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.watercraft_key)),h.watercraft_key<>(typeof(h.watercraft_key))'');
    populated_sequence_key_pcnt := AVE(GROUP,IF(h.sequence_key = (TYPEOF(h.sequence_key))'',0,100));
    maxlength_sequence_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sequence_key)));
    avelength_sequence_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sequence_key)),h.sequence_key<>(typeof(h.sequence_key))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_vessel_id_pcnt := AVE(GROUP,IF(h.vessel_id = (TYPEOF(h.vessel_id))'',0,100));
    maxlength_vessel_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_id)));
    avelength_vessel_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_id)),h.vessel_id<>(typeof(h.vessel_id))'');
    populated_vessel_database_key_pcnt := AVE(GROUP,IF(h.vessel_database_key = (TYPEOF(h.vessel_database_key))'',0,100));
    maxlength_vessel_database_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_database_key)));
    avelength_vessel_database_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_database_key)),h.vessel_database_key<>(typeof(h.vessel_database_key))'');
    populated_name_of_vessel_pcnt := AVE(GROUP,IF(h.name_of_vessel = (TYPEOF(h.name_of_vessel))'',0,100));
    maxlength_name_of_vessel := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_of_vessel)));
    avelength_name_of_vessel := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_of_vessel)),h.name_of_vessel<>(typeof(h.name_of_vessel))'');
    populated_call_sign_pcnt := AVE(GROUP,IF(h.call_sign = (TYPEOF(h.call_sign))'',0,100));
    maxlength_call_sign := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.call_sign)));
    avelength_call_sign := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.call_sign)),h.call_sign<>(typeof(h.call_sign))'');
    populated_official_number_pcnt := AVE(GROUP,IF(h.official_number = (TYPEOF(h.official_number))'',0,100));
    maxlength_official_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.official_number)));
    avelength_official_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.official_number)),h.official_number<>(typeof(h.official_number))'');
    populated_imo_number_pcnt := AVE(GROUP,IF(h.imo_number = (TYPEOF(h.imo_number))'',0,100));
    maxlength_imo_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.imo_number)));
    avelength_imo_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.imo_number)),h.imo_number<>(typeof(h.imo_number))'');
    populated_hull_number_pcnt := AVE(GROUP,IF(h.hull_number = (TYPEOF(h.hull_number))'',0,100));
    maxlength_hull_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_number)));
    avelength_hull_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_number)),h.hull_number<>(typeof(h.hull_number))'');
    populated_hull_identification_number_pcnt := AVE(GROUP,IF(h.hull_identification_number = (TYPEOF(h.hull_identification_number))'',0,100));
    maxlength_hull_identification_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_identification_number)));
    avelength_hull_identification_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_identification_number)),h.hull_identification_number<>(typeof(h.hull_identification_number))'');
    populated_vessel_service_type_pcnt := AVE(GROUP,IF(h.vessel_service_type = (TYPEOF(h.vessel_service_type))'',0,100));
    maxlength_vessel_service_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_service_type)));
    avelength_vessel_service_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_service_type)),h.vessel_service_type<>(typeof(h.vessel_service_type))'');
    populated_flag_pcnt := AVE(GROUP,IF(h.flag = (TYPEOF(h.flag))'',0,100));
    maxlength_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.flag)));
    avelength_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.flag)),h.flag<>(typeof(h.flag))'');
    populated_self_propelled_indicator_pcnt := AVE(GROUP,IF(h.self_propelled_indicator = (TYPEOF(h.self_propelled_indicator))'',0,100));
    maxlength_self_propelled_indicator := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.self_propelled_indicator)));
    avelength_self_propelled_indicator := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.self_propelled_indicator)),h.self_propelled_indicator<>(typeof(h.self_propelled_indicator))'');
    populated_registered_gross_tons_pcnt := AVE(GROUP,IF(h.registered_gross_tons = (TYPEOF(h.registered_gross_tons))'',0,100));
    maxlength_registered_gross_tons := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_gross_tons)));
    avelength_registered_gross_tons := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_gross_tons)),h.registered_gross_tons<>(typeof(h.registered_gross_tons))'');
    populated_registered_net_tons_pcnt := AVE(GROUP,IF(h.registered_net_tons = (TYPEOF(h.registered_net_tons))'',0,100));
    maxlength_registered_net_tons := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_net_tons)));
    avelength_registered_net_tons := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_net_tons)),h.registered_net_tons<>(typeof(h.registered_net_tons))'');
    populated_registered_length_pcnt := AVE(GROUP,IF(h.registered_length = (TYPEOF(h.registered_length))'',0,100));
    maxlength_registered_length := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_length)));
    avelength_registered_length := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_length)),h.registered_length<>(typeof(h.registered_length))'');
    populated_registered_breadth_pcnt := AVE(GROUP,IF(h.registered_breadth = (TYPEOF(h.registered_breadth))'',0,100));
    maxlength_registered_breadth := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_breadth)));
    avelength_registered_breadth := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_breadth)),h.registered_breadth<>(typeof(h.registered_breadth))'');
    populated_registered_depth_pcnt := AVE(GROUP,IF(h.registered_depth = (TYPEOF(h.registered_depth))'',0,100));
    maxlength_registered_depth := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_depth)));
    avelength_registered_depth := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.registered_depth)),h.registered_depth<>(typeof(h.registered_depth))'');
    populated_itc_gross_tons_pcnt := AVE(GROUP,IF(h.itc_gross_tons = (TYPEOF(h.itc_gross_tons))'',0,100));
    maxlength_itc_gross_tons := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_gross_tons)));
    avelength_itc_gross_tons := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_gross_tons)),h.itc_gross_tons<>(typeof(h.itc_gross_tons))'');
    populated_itc_net_tons_pcnt := AVE(GROUP,IF(h.itc_net_tons = (TYPEOF(h.itc_net_tons))'',0,100));
    maxlength_itc_net_tons := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_net_tons)));
    avelength_itc_net_tons := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_net_tons)),h.itc_net_tons<>(typeof(h.itc_net_tons))'');
    populated_itc_length_pcnt := AVE(GROUP,IF(h.itc_length = (TYPEOF(h.itc_length))'',0,100));
    maxlength_itc_length := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_length)));
    avelength_itc_length := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_length)),h.itc_length<>(typeof(h.itc_length))'');
    populated_itc_breadth_pcnt := AVE(GROUP,IF(h.itc_breadth = (TYPEOF(h.itc_breadth))'',0,100));
    maxlength_itc_breadth := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_breadth)));
    avelength_itc_breadth := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_breadth)),h.itc_breadth<>(typeof(h.itc_breadth))'');
    populated_itc_depth_pcnt := AVE(GROUP,IF(h.itc_depth = (TYPEOF(h.itc_depth))'',0,100));
    maxlength_itc_depth := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_depth)));
    avelength_itc_depth := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_depth)),h.itc_depth<>(typeof(h.itc_depth))'');
    populated_hailing_port_pcnt := AVE(GROUP,IF(h.hailing_port = (TYPEOF(h.hailing_port))'',0,100));
    maxlength_hailing_port := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port)));
    avelength_hailing_port := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port)),h.hailing_port<>(typeof(h.hailing_port))'');
    populated_hailing_port_state_pcnt := AVE(GROUP,IF(h.hailing_port_state = (TYPEOF(h.hailing_port_state))'',0,100));
    maxlength_hailing_port_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port_state)));
    avelength_hailing_port_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port_state)),h.hailing_port_state<>(typeof(h.hailing_port_state))'');
    populated_hailing_port_province_pcnt := AVE(GROUP,IF(h.hailing_port_province = (TYPEOF(h.hailing_port_province))'',0,100));
    maxlength_hailing_port_province := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port_province)));
    avelength_hailing_port_province := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hailing_port_province)),h.hailing_port_province<>(typeof(h.hailing_port_province))'');
    populated_home_port_name_pcnt := AVE(GROUP,IF(h.home_port_name = (TYPEOF(h.home_port_name))'',0,100));
    maxlength_home_port_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_name)));
    avelength_home_port_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_name)),h.home_port_name<>(typeof(h.home_port_name))'');
    populated_home_port_state_pcnt := AVE(GROUP,IF(h.home_port_state = (TYPEOF(h.home_port_state))'',0,100));
    maxlength_home_port_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_state)));
    avelength_home_port_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_state)),h.home_port_state<>(typeof(h.home_port_state))'');
    populated_home_port_province_pcnt := AVE(GROUP,IF(h.home_port_province = (TYPEOF(h.home_port_province))'',0,100));
    maxlength_home_port_province := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_province)));
    avelength_home_port_province := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.home_port_province)),h.home_port_province<>(typeof(h.home_port_province))'');
    populated_trade_ind_coastwise_unrestricted_pcnt := AVE(GROUP,IF(h.trade_ind_coastwise_unrestricted = (TYPEOF(h.trade_ind_coastwise_unrestricted))'',0,100));
    maxlength_trade_ind_coastwise_unrestricted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_coastwise_unrestricted)));
    avelength_trade_ind_coastwise_unrestricted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_coastwise_unrestricted)),h.trade_ind_coastwise_unrestricted<>(typeof(h.trade_ind_coastwise_unrestricted))'');
    populated_trade_ind_limited_coastwise_bowaters_only_pcnt := AVE(GROUP,IF(h.trade_ind_limited_coastwise_bowaters_only = (TYPEOF(h.trade_ind_limited_coastwise_bowaters_only))'',0,100));
    maxlength_trade_ind_limited_coastwise_bowaters_only := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_bowaters_only)));
    avelength_trade_ind_limited_coastwise_bowaters_only := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_bowaters_only)),h.trade_ind_limited_coastwise_bowaters_only<>(typeof(h.trade_ind_limited_coastwise_bowaters_only))'');
    populated_trade_ind_limited_coastwise_restricted_pcnt := AVE(GROUP,IF(h.trade_ind_limited_coastwise_restricted = (TYPEOF(h.trade_ind_limited_coastwise_restricted))'',0,100));
    maxlength_trade_ind_limited_coastwise_restricted := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_restricted)));
    avelength_trade_ind_limited_coastwise_restricted := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_restricted)),h.trade_ind_limited_coastwise_restricted<>(typeof(h.trade_ind_limited_coastwise_restricted))'');
    populated_trade_ind_limited_coastwise_oil_spill_response_only_pcnt := AVE(GROUP,IF(h.trade_ind_limited_coastwise_oil_spill_response_only = (TYPEOF(h.trade_ind_limited_coastwise_oil_spill_response_only))'',0,100));
    maxlength_trade_ind_limited_coastwise_oil_spill_response_only := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_oil_spill_response_only)));
    avelength_trade_ind_limited_coastwise_oil_spill_response_only := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_oil_spill_response_only)),h.trade_ind_limited_coastwise_oil_spill_response_only<>(typeof(h.trade_ind_limited_coastwise_oil_spill_response_only))'');
    populated_trade_ind_limited_coastwise_under_charter_to_citizen_pcnt := AVE(GROUP,IF(h.trade_ind_limited_coastwise_under_charter_to_citizen = (TYPEOF(h.trade_ind_limited_coastwise_under_charter_to_citizen))'',0,100));
    maxlength_trade_ind_limited_coastwise_under_charter_to_citizen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_under_charter_to_citizen)));
    avelength_trade_ind_limited_coastwise_under_charter_to_citizen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_coastwise_under_charter_to_citizen)),h.trade_ind_limited_coastwise_under_charter_to_citizen<>(typeof(h.trade_ind_limited_coastwise_under_charter_to_citizen))'');
    populated_trade_ind_fishery_pcnt := AVE(GROUP,IF(h.trade_ind_fishery = (TYPEOF(h.trade_ind_fishery))'',0,100));
    maxlength_trade_ind_fishery := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_fishery)));
    avelength_trade_ind_fishery := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_fishery)),h.trade_ind_fishery<>(typeof(h.trade_ind_fishery))'');
    populated_trade_ind_limited_fishery_only_pcnt := AVE(GROUP,IF(h.trade_ind_limited_fishery_only = (TYPEOF(h.trade_ind_limited_fishery_only))'',0,100));
    maxlength_trade_ind_limited_fishery_only := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_fishery_only)));
    avelength_trade_ind_limited_fishery_only := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_fishery_only)),h.trade_ind_limited_fishery_only<>(typeof(h.trade_ind_limited_fishery_only))'');
    populated_trade_ind_recreation_pcnt := AVE(GROUP,IF(h.trade_ind_recreation = (TYPEOF(h.trade_ind_recreation))'',0,100));
    maxlength_trade_ind_recreation := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_recreation)));
    avelength_trade_ind_recreation := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_recreation)),h.trade_ind_recreation<>(typeof(h.trade_ind_recreation))'');
    populated_trade_ind_limited_recreation_great_lakes_use_only_pcnt := AVE(GROUP,IF(h.trade_ind_limited_recreation_great_lakes_use_only = (TYPEOF(h.trade_ind_limited_recreation_great_lakes_use_only))'',0,100));
    maxlength_trade_ind_limited_recreation_great_lakes_use_only := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_recreation_great_lakes_use_only)));
    avelength_trade_ind_limited_recreation_great_lakes_use_only := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_recreation_great_lakes_use_only)),h.trade_ind_limited_recreation_great_lakes_use_only<>(typeof(h.trade_ind_limited_recreation_great_lakes_use_only))'');
    populated_trade_ind_registry_pcnt := AVE(GROUP,IF(h.trade_ind_registry = (TYPEOF(h.trade_ind_registry))'',0,100));
    maxlength_trade_ind_registry := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_registry)));
    avelength_trade_ind_registry := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_registry)),h.trade_ind_registry<>(typeof(h.trade_ind_registry))'');
    populated_trade_ind_limited_registry_cross_border_financing_pcnt := AVE(GROUP,IF(h.trade_ind_limited_registry_cross_border_financing = (TYPEOF(h.trade_ind_limited_registry_cross_border_financing))'',0,100));
    maxlength_trade_ind_limited_registry_cross_border_financing := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_cross_border_financing)));
    avelength_trade_ind_limited_registry_cross_border_financing := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_cross_border_financing)),h.trade_ind_limited_registry_cross_border_financing<>(typeof(h.trade_ind_limited_registry_cross_border_financing))'');
    populated_trade_ind_limited_registry_no_foreign_voyage_pcnt := AVE(GROUP,IF(h.trade_ind_limited_registry_no_foreign_voyage = (TYPEOF(h.trade_ind_limited_registry_no_foreign_voyage))'',0,100));
    maxlength_trade_ind_limited_registry_no_foreign_voyage := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_no_foreign_voyage)));
    avelength_trade_ind_limited_registry_no_foreign_voyage := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_no_foreign_voyage)),h.trade_ind_limited_registry_no_foreign_voyage<>(typeof(h.trade_ind_limited_registry_no_foreign_voyage))'');
    populated_trade_ind_limited_registry_trade_with_canada_only_pcnt := AVE(GROUP,IF(h.trade_ind_limited_registry_trade_with_canada_only = (TYPEOF(h.trade_ind_limited_registry_trade_with_canada_only))'',0,100));
    maxlength_trade_ind_limited_registry_trade_with_canada_only := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_trade_with_canada_only)));
    avelength_trade_ind_limited_registry_trade_with_canada_only := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_limited_registry_trade_with_canada_only)),h.trade_ind_limited_registry_trade_with_canada_only<>(typeof(h.trade_ind_limited_registry_trade_with_canada_only))'');
    populated_trade_ind_great_lakes_pcnt := AVE(GROUP,IF(h.trade_ind_great_lakes = (TYPEOF(h.trade_ind_great_lakes))'',0,100));
    maxlength_trade_ind_great_lakes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_great_lakes)));
    avelength_trade_ind_great_lakes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.trade_ind_great_lakes)),h.trade_ind_great_lakes<>(typeof(h.trade_ind_great_lakes))'');
    populated_vessel_complete_build_city_pcnt := AVE(GROUP,IF(h.vessel_complete_build_city = (TYPEOF(h.vessel_complete_build_city))'',0,100));
    maxlength_vessel_complete_build_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_city)));
    avelength_vessel_complete_build_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_city)),h.vessel_complete_build_city<>(typeof(h.vessel_complete_build_city))'');
    populated_vessel_complete_build_state_pcnt := AVE(GROUP,IF(h.vessel_complete_build_state = (TYPEOF(h.vessel_complete_build_state))'',0,100));
    maxlength_vessel_complete_build_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_state)));
    avelength_vessel_complete_build_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_state)),h.vessel_complete_build_state<>(typeof(h.vessel_complete_build_state))'');
    populated_vessel_complete_build_province_pcnt := AVE(GROUP,IF(h.vessel_complete_build_province = (TYPEOF(h.vessel_complete_build_province))'',0,100));
    maxlength_vessel_complete_build_province := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_province)));
    avelength_vessel_complete_build_province := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_province)),h.vessel_complete_build_province<>(typeof(h.vessel_complete_build_province))'');
    populated_vessel_complete_build_country_pcnt := AVE(GROUP,IF(h.vessel_complete_build_country = (TYPEOF(h.vessel_complete_build_country))'',0,100));
    maxlength_vessel_complete_build_country := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_country)));
    avelength_vessel_complete_build_country := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_complete_build_country)),h.vessel_complete_build_country<>(typeof(h.vessel_complete_build_country))'');
    populated_vessel_build_year_pcnt := AVE(GROUP,IF(h.vessel_build_year = (TYPEOF(h.vessel_build_year))'',0,100));
    maxlength_vessel_build_year := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_build_year)));
    avelength_vessel_build_year := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_build_year)),h.vessel_build_year<>(typeof(h.vessel_build_year))'');
    populated_vessel_hull_build_city_pcnt := AVE(GROUP,IF(h.vessel_hull_build_city = (TYPEOF(h.vessel_hull_build_city))'',0,100));
    maxlength_vessel_hull_build_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_city)));
    avelength_vessel_hull_build_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_city)),h.vessel_hull_build_city<>(typeof(h.vessel_hull_build_city))'');
    populated_vessel_hull_build_state_pcnt := AVE(GROUP,IF(h.vessel_hull_build_state = (TYPEOF(h.vessel_hull_build_state))'',0,100));
    maxlength_vessel_hull_build_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_state)));
    avelength_vessel_hull_build_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_state)),h.vessel_hull_build_state<>(typeof(h.vessel_hull_build_state))'');
    populated_vessel_hull_build_province_pcnt := AVE(GROUP,IF(h.vessel_hull_build_province = (TYPEOF(h.vessel_hull_build_province))'',0,100));
    maxlength_vessel_hull_build_province := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_province)));
    avelength_vessel_hull_build_province := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_province)),h.vessel_hull_build_province<>(typeof(h.vessel_hull_build_province))'');
    populated_vessel_hull_build_country_pcnt := AVE(GROUP,IF(h.vessel_hull_build_country = (TYPEOF(h.vessel_hull_build_country))'',0,100));
    maxlength_vessel_hull_build_country := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_country)));
    avelength_vessel_hull_build_country := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vessel_hull_build_country)),h.vessel_hull_build_country<>(typeof(h.vessel_hull_build_country))'');
    populated_party_identification_number_pcnt := AVE(GROUP,IF(h.party_identification_number = (TYPEOF(h.party_identification_number))'',0,100));
    maxlength_party_identification_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_identification_number)));
    avelength_party_identification_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_identification_number)),h.party_identification_number<>(typeof(h.party_identification_number))'');
    populated_main_hp_ahead_pcnt := AVE(GROUP,IF(h.main_hp_ahead = (TYPEOF(h.main_hp_ahead))'',0,100));
    maxlength_main_hp_ahead := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.main_hp_ahead)));
    avelength_main_hp_ahead := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.main_hp_ahead)),h.main_hp_ahead<>(typeof(h.main_hp_ahead))'');
    populated_main_hp_astern_pcnt := AVE(GROUP,IF(h.main_hp_astern = (TYPEOF(h.main_hp_astern))'',0,100));
    maxlength_main_hp_astern := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.main_hp_astern)));
    avelength_main_hp_astern := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.main_hp_astern)),h.main_hp_astern<>(typeof(h.main_hp_astern))'');
    populated_propulsion_type_pcnt := AVE(GROUP,IF(h.propulsion_type = (TYPEOF(h.propulsion_type))'',0,100));
    maxlength_propulsion_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.propulsion_type)));
    avelength_propulsion_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.propulsion_type)),h.propulsion_type<>(typeof(h.propulsion_type))'');
    populated_hull_material_pcnt := AVE(GROUP,IF(h.hull_material = (TYPEOF(h.hull_material))'',0,100));
    maxlength_hull_material := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_material)));
    avelength_hull_material := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_material)),h.hull_material<>(typeof(h.hull_material))'');
    populated_ship_yard_pcnt := AVE(GROUP,IF(h.ship_yard = (TYPEOF(h.ship_yard))'',0,100));
    maxlength_ship_yard := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ship_yard)));
    avelength_ship_yard := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ship_yard)),h.ship_yard<>(typeof(h.ship_yard))'');
    populated_hull_builder_name_pcnt := AVE(GROUP,IF(h.hull_builder_name = (TYPEOF(h.hull_builder_name))'',0,100));
    maxlength_hull_builder_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_builder_name)));
    avelength_hull_builder_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_builder_name)),h.hull_builder_name<>(typeof(h.hull_builder_name))'');
    populated_doc_certificate_status_pcnt := AVE(GROUP,IF(h.doc_certificate_status = (TYPEOF(h.doc_certificate_status))'',0,100));
    maxlength_doc_certificate_status := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.doc_certificate_status)));
    avelength_doc_certificate_status := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.doc_certificate_status)),h.doc_certificate_status<>(typeof(h.doc_certificate_status))'');
    populated_date_issued_pcnt := AVE(GROUP,IF(h.date_issued = (TYPEOF(h.date_issued))'',0,100));
    maxlength_date_issued := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_issued)));
    avelength_date_issued := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_issued)),h.date_issued<>(typeof(h.date_issued))'');
    populated_date_expires_pcnt := AVE(GROUP,IF(h.date_expires = (TYPEOF(h.date_expires))'',0,100));
    maxlength_date_expires := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_expires)));
    avelength_date_expires := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_expires)),h.date_expires<>(typeof(h.date_expires))'');
    populated_hull_design_type_pcnt := AVE(GROUP,IF(h.hull_design_type = (TYPEOF(h.hull_design_type))'',0,100));
    maxlength_hull_design_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_design_type)));
    avelength_hull_design_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.hull_design_type)),h.hull_design_type<>(typeof(h.hull_design_type))'');
    populated_sail_ind_pcnt := AVE(GROUP,IF(h.sail_ind = (TYPEOF(h.sail_ind))'',0,100));
    maxlength_sail_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sail_ind)));
    avelength_sail_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sail_ind)),h.sail_ind<>(typeof(h.sail_ind))'');
    populated_party_database_key_pcnt := AVE(GROUP,IF(h.party_database_key = (TYPEOF(h.party_database_key))'',0,100));
    maxlength_party_database_key := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_database_key)));
    avelength_party_database_key := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.party_database_key)),h.party_database_key<>(typeof(h.party_database_key))'');
    populated_itc_tons_cod_ind_pcnt := AVE(GROUP,IF(h.itc_tons_cod_ind = (TYPEOF(h.itc_tons_cod_ind))'',0,100));
    maxlength_itc_tons_cod_ind := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_tons_cod_ind)));
    avelength_itc_tons_cod_ind := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.itc_tons_cod_ind)),h.itc_tons_cod_ind<>(typeof(h.itc_tons_cod_ind))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_code,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_watercraft_key_pcnt *   0.00 / 100 + T.Populated_sequence_key_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_vessel_id_pcnt *   0.00 / 100 + T.Populated_vessel_database_key_pcnt *   0.00 / 100 + T.Populated_name_of_vessel_pcnt *   0.00 / 100 + T.Populated_call_sign_pcnt *   0.00 / 100 + T.Populated_official_number_pcnt *   0.00 / 100 + T.Populated_imo_number_pcnt *   0.00 / 100 + T.Populated_hull_number_pcnt *   0.00 / 100 + T.Populated_hull_identification_number_pcnt *   0.00 / 100 + T.Populated_vessel_service_type_pcnt *   0.00 / 100 + T.Populated_flag_pcnt *   0.00 / 100 + T.Populated_self_propelled_indicator_pcnt *   0.00 / 100 + T.Populated_registered_gross_tons_pcnt *   0.00 / 100 + T.Populated_registered_net_tons_pcnt *   0.00 / 100 + T.Populated_registered_length_pcnt *   0.00 / 100 + T.Populated_registered_breadth_pcnt *   0.00 / 100 + T.Populated_registered_depth_pcnt *   0.00 / 100 + T.Populated_itc_gross_tons_pcnt *   0.00 / 100 + T.Populated_itc_net_tons_pcnt *   0.00 / 100 + T.Populated_itc_length_pcnt *   0.00 / 100 + T.Populated_itc_breadth_pcnt *   0.00 / 100 + T.Populated_itc_depth_pcnt *   0.00 / 100 + T.Populated_hailing_port_pcnt *   0.00 / 100 + T.Populated_hailing_port_state_pcnt *   0.00 / 100 + T.Populated_hailing_port_province_pcnt *   0.00 / 100 + T.Populated_home_port_name_pcnt *   0.00 / 100 + T.Populated_home_port_state_pcnt *   0.00 / 100 + T.Populated_home_port_province_pcnt *   0.00 / 100 + T.Populated_trade_ind_coastwise_unrestricted_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_coastwise_bowaters_only_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_coastwise_restricted_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_coastwise_oil_spill_response_only_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_coastwise_under_charter_to_citizen_pcnt *   0.00 / 100 + T.Populated_trade_ind_fishery_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_fishery_only_pcnt *   0.00 / 100 + T.Populated_trade_ind_recreation_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_recreation_great_lakes_use_only_pcnt *   0.00 / 100 + T.Populated_trade_ind_registry_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_registry_cross_border_financing_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_registry_no_foreign_voyage_pcnt *   0.00 / 100 + T.Populated_trade_ind_limited_registry_trade_with_canada_only_pcnt *   0.00 / 100 + T.Populated_trade_ind_great_lakes_pcnt *   0.00 / 100 + T.Populated_vessel_complete_build_city_pcnt *   0.00 / 100 + T.Populated_vessel_complete_build_state_pcnt *   0.00 / 100 + T.Populated_vessel_complete_build_province_pcnt *   0.00 / 100 + T.Populated_vessel_complete_build_country_pcnt *   0.00 / 100 + T.Populated_vessel_build_year_pcnt *   0.00 / 100 + T.Populated_vessel_hull_build_city_pcnt *   0.00 / 100 + T.Populated_vessel_hull_build_state_pcnt *   0.00 / 100 + T.Populated_vessel_hull_build_province_pcnt *   0.00 / 100 + T.Populated_vessel_hull_build_country_pcnt *   0.00 / 100 + T.Populated_party_identification_number_pcnt *   0.00 / 100 + T.Populated_main_hp_ahead_pcnt *   0.00 / 100 + T.Populated_main_hp_astern_pcnt *   0.00 / 100 + T.Populated_propulsion_type_pcnt *   0.00 / 100 + T.Populated_hull_material_pcnt *   0.00 / 100 + T.Populated_ship_yard_pcnt *   0.00 / 100 + T.Populated_hull_builder_name_pcnt *   0.00 / 100 + T.Populated_doc_certificate_status_pcnt *   0.00 / 100 + T.Populated_date_issued_pcnt *   0.00 / 100 + T.Populated_date_expires_pcnt *   0.00 / 100 + T.Populated_hull_design_type_pcnt *   0.00 / 100 + T.Populated_sail_ind_pcnt *   0.00 / 100 + T.Populated_party_database_key_pcnt *   0.00 / 100 + T.Populated_itc_tons_cod_ind_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_code1;
    STRING source_code2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_code1 := le.Source;
    SELF.source_code2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_watercraft_key_pcnt*ri.Populated_watercraft_key_pcnt *   0.00 / 10000 + le.Populated_sequence_key_pcnt*ri.Populated_sequence_key_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_source_code_pcnt*ri.Populated_source_code_pcnt *   0.00 / 10000 + le.Populated_vessel_id_pcnt*ri.Populated_vessel_id_pcnt *   0.00 / 10000 + le.Populated_vessel_database_key_pcnt*ri.Populated_vessel_database_key_pcnt *   0.00 / 10000 + le.Populated_name_of_vessel_pcnt*ri.Populated_name_of_vessel_pcnt *   0.00 / 10000 + le.Populated_call_sign_pcnt*ri.Populated_call_sign_pcnt *   0.00 / 10000 + le.Populated_official_number_pcnt*ri.Populated_official_number_pcnt *   0.00 / 10000 + le.Populated_imo_number_pcnt*ri.Populated_imo_number_pcnt *   0.00 / 10000 + le.Populated_hull_number_pcnt*ri.Populated_hull_number_pcnt *   0.00 / 10000 + le.Populated_hull_identification_number_pcnt*ri.Populated_hull_identification_number_pcnt *   0.00 / 10000 + le.Populated_vessel_service_type_pcnt*ri.Populated_vessel_service_type_pcnt *   0.00 / 10000 + le.Populated_flag_pcnt*ri.Populated_flag_pcnt *   0.00 / 10000 + le.Populated_self_propelled_indicator_pcnt*ri.Populated_self_propelled_indicator_pcnt *   0.00 / 10000 + le.Populated_registered_gross_tons_pcnt*ri.Populated_registered_gross_tons_pcnt *   0.00 / 10000 + le.Populated_registered_net_tons_pcnt*ri.Populated_registered_net_tons_pcnt *   0.00 / 10000 + le.Populated_registered_length_pcnt*ri.Populated_registered_length_pcnt *   0.00 / 10000 + le.Populated_registered_breadth_pcnt*ri.Populated_registered_breadth_pcnt *   0.00 / 10000 + le.Populated_registered_depth_pcnt*ri.Populated_registered_depth_pcnt *   0.00 / 10000 + le.Populated_itc_gross_tons_pcnt*ri.Populated_itc_gross_tons_pcnt *   0.00 / 10000 + le.Populated_itc_net_tons_pcnt*ri.Populated_itc_net_tons_pcnt *   0.00 / 10000 + le.Populated_itc_length_pcnt*ri.Populated_itc_length_pcnt *   0.00 / 10000 + le.Populated_itc_breadth_pcnt*ri.Populated_itc_breadth_pcnt *   0.00 / 10000 + le.Populated_itc_depth_pcnt*ri.Populated_itc_depth_pcnt *   0.00 / 10000 + le.Populated_hailing_port_pcnt*ri.Populated_hailing_port_pcnt *   0.00 / 10000 + le.Populated_hailing_port_state_pcnt*ri.Populated_hailing_port_state_pcnt *   0.00 / 10000 + le.Populated_hailing_port_province_pcnt*ri.Populated_hailing_port_province_pcnt *   0.00 / 10000 + le.Populated_home_port_name_pcnt*ri.Populated_home_port_name_pcnt *   0.00 / 10000 + le.Populated_home_port_state_pcnt*ri.Populated_home_port_state_pcnt *   0.00 / 10000 + le.Populated_home_port_province_pcnt*ri.Populated_home_port_province_pcnt *   0.00 / 10000 + le.Populated_trade_ind_coastwise_unrestricted_pcnt*ri.Populated_trade_ind_coastwise_unrestricted_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_coastwise_bowaters_only_pcnt*ri.Populated_trade_ind_limited_coastwise_bowaters_only_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_coastwise_restricted_pcnt*ri.Populated_trade_ind_limited_coastwise_restricted_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_coastwise_oil_spill_response_only_pcnt*ri.Populated_trade_ind_limited_coastwise_oil_spill_response_only_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_coastwise_under_charter_to_citizen_pcnt*ri.Populated_trade_ind_limited_coastwise_under_charter_to_citizen_pcnt *   0.00 / 10000 + le.Populated_trade_ind_fishery_pcnt*ri.Populated_trade_ind_fishery_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_fishery_only_pcnt*ri.Populated_trade_ind_limited_fishery_only_pcnt *   0.00 / 10000 + le.Populated_trade_ind_recreation_pcnt*ri.Populated_trade_ind_recreation_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_recreation_great_lakes_use_only_pcnt*ri.Populated_trade_ind_limited_recreation_great_lakes_use_only_pcnt *   0.00 / 10000 + le.Populated_trade_ind_registry_pcnt*ri.Populated_trade_ind_registry_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_registry_cross_border_financing_pcnt*ri.Populated_trade_ind_limited_registry_cross_border_financing_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_registry_no_foreign_voyage_pcnt*ri.Populated_trade_ind_limited_registry_no_foreign_voyage_pcnt *   0.00 / 10000 + le.Populated_trade_ind_limited_registry_trade_with_canada_only_pcnt*ri.Populated_trade_ind_limited_registry_trade_with_canada_only_pcnt *   0.00 / 10000 + le.Populated_trade_ind_great_lakes_pcnt*ri.Populated_trade_ind_great_lakes_pcnt *   0.00 / 10000 + le.Populated_vessel_complete_build_city_pcnt*ri.Populated_vessel_complete_build_city_pcnt *   0.00 / 10000 + le.Populated_vessel_complete_build_state_pcnt*ri.Populated_vessel_complete_build_state_pcnt *   0.00 / 10000 + le.Populated_vessel_complete_build_province_pcnt*ri.Populated_vessel_complete_build_province_pcnt *   0.00 / 10000 + le.Populated_vessel_complete_build_country_pcnt*ri.Populated_vessel_complete_build_country_pcnt *   0.00 / 10000 + le.Populated_vessel_build_year_pcnt*ri.Populated_vessel_build_year_pcnt *   0.00 / 10000 + le.Populated_vessel_hull_build_city_pcnt*ri.Populated_vessel_hull_build_city_pcnt *   0.00 / 10000 + le.Populated_vessel_hull_build_state_pcnt*ri.Populated_vessel_hull_build_state_pcnt *   0.00 / 10000 + le.Populated_vessel_hull_build_province_pcnt*ri.Populated_vessel_hull_build_province_pcnt *   0.00 / 10000 + le.Populated_vessel_hull_build_country_pcnt*ri.Populated_vessel_hull_build_country_pcnt *   0.00 / 10000 + le.Populated_party_identification_number_pcnt*ri.Populated_party_identification_number_pcnt *   0.00 / 10000 + le.Populated_main_hp_ahead_pcnt*ri.Populated_main_hp_ahead_pcnt *   0.00 / 10000 + le.Populated_main_hp_astern_pcnt*ri.Populated_main_hp_astern_pcnt *   0.00 / 10000 + le.Populated_propulsion_type_pcnt*ri.Populated_propulsion_type_pcnt *   0.00 / 10000 + le.Populated_hull_material_pcnt*ri.Populated_hull_material_pcnt *   0.00 / 10000 + le.Populated_ship_yard_pcnt*ri.Populated_ship_yard_pcnt *   0.00 / 10000 + le.Populated_hull_builder_name_pcnt*ri.Populated_hull_builder_name_pcnt *   0.00 / 10000 + le.Populated_doc_certificate_status_pcnt*ri.Populated_doc_certificate_status_pcnt *   0.00 / 10000 + le.Populated_date_issued_pcnt*ri.Populated_date_issued_pcnt *   0.00 / 10000 + le.Populated_date_expires_pcnt*ri.Populated_date_expires_pcnt *   0.00 / 10000 + le.Populated_hull_design_type_pcnt*ri.Populated_hull_design_type_pcnt *   0.00 / 10000 + le.Populated_sail_ind_pcnt*ri.Populated_sail_ind_pcnt *   0.00 / 10000 + le.Populated_party_database_key_pcnt*ri.Populated_party_database_key_pcnt *   0.00 / 10000 + le.Populated_itc_tons_cod_ind_pcnt*ri.Populated_itc_tons_cod_ind_pcnt *   0.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'watercraft_key','sequence_key','state_origin','source_code','vessel_id','vessel_database_key','name_of_vessel','call_sign','official_number','imo_number','hull_number','hull_identification_number','vessel_service_type','flag','self_propelled_indicator','registered_gross_tons','registered_net_tons','registered_length','registered_breadth','registered_depth','itc_gross_tons','itc_net_tons','itc_length','itc_breadth','itc_depth','hailing_port','hailing_port_state','hailing_port_province','home_port_name','home_port_state','home_port_province','trade_ind_coastwise_unrestricted','trade_ind_limited_coastwise_bowaters_only','trade_ind_limited_coastwise_restricted','trade_ind_limited_coastwise_oil_spill_response_only','trade_ind_limited_coastwise_under_charter_to_citizen','trade_ind_fishery','trade_ind_limited_fishery_only','trade_ind_recreation','trade_ind_limited_recreation_great_lakes_use_only','trade_ind_registry','trade_ind_limited_registry_cross_border_financing','trade_ind_limited_registry_no_foreign_voyage','trade_ind_limited_registry_trade_with_canada_only','trade_ind_great_lakes','vessel_complete_build_city','vessel_complete_build_state','vessel_complete_build_province','vessel_complete_build_country','vessel_build_year','vessel_hull_build_city','vessel_hull_build_state','vessel_hull_build_province','vessel_hull_build_country','party_identification_number','main_hp_ahead','main_hp_astern','propulsion_type','hull_material','ship_yard','hull_builder_name','doc_certificate_status','date_issued','date_expires','hull_design_type','sail_ind','party_database_key','itc_tons_cod_ind','persistent_record_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_watercraft_key_pcnt,le.populated_sequence_key_pcnt,le.populated_state_origin_pcnt,le.populated_source_code_pcnt,le.populated_vessel_id_pcnt,le.populated_vessel_database_key_pcnt,le.populated_name_of_vessel_pcnt,le.populated_call_sign_pcnt,le.populated_official_number_pcnt,le.populated_imo_number_pcnt,le.populated_hull_number_pcnt,le.populated_hull_identification_number_pcnt,le.populated_vessel_service_type_pcnt,le.populated_flag_pcnt,le.populated_self_propelled_indicator_pcnt,le.populated_registered_gross_tons_pcnt,le.populated_registered_net_tons_pcnt,le.populated_registered_length_pcnt,le.populated_registered_breadth_pcnt,le.populated_registered_depth_pcnt,le.populated_itc_gross_tons_pcnt,le.populated_itc_net_tons_pcnt,le.populated_itc_length_pcnt,le.populated_itc_breadth_pcnt,le.populated_itc_depth_pcnt,le.populated_hailing_port_pcnt,le.populated_hailing_port_state_pcnt,le.populated_hailing_port_province_pcnt,le.populated_home_port_name_pcnt,le.populated_home_port_state_pcnt,le.populated_home_port_province_pcnt,le.populated_trade_ind_coastwise_unrestricted_pcnt,le.populated_trade_ind_limited_coastwise_bowaters_only_pcnt,le.populated_trade_ind_limited_coastwise_restricted_pcnt,le.populated_trade_ind_limited_coastwise_oil_spill_response_only_pcnt,le.populated_trade_ind_limited_coastwise_under_charter_to_citizen_pcnt,le.populated_trade_ind_fishery_pcnt,le.populated_trade_ind_limited_fishery_only_pcnt,le.populated_trade_ind_recreation_pcnt,le.populated_trade_ind_limited_recreation_great_lakes_use_only_pcnt,le.populated_trade_ind_registry_pcnt,le.populated_trade_ind_limited_registry_cross_border_financing_pcnt,le.populated_trade_ind_limited_registry_no_foreign_voyage_pcnt,le.populated_trade_ind_limited_registry_trade_with_canada_only_pcnt,le.populated_trade_ind_great_lakes_pcnt,le.populated_vessel_complete_build_city_pcnt,le.populated_vessel_complete_build_state_pcnt,le.populated_vessel_complete_build_province_pcnt,le.populated_vessel_complete_build_country_pcnt,le.populated_vessel_build_year_pcnt,le.populated_vessel_hull_build_city_pcnt,le.populated_vessel_hull_build_state_pcnt,le.populated_vessel_hull_build_province_pcnt,le.populated_vessel_hull_build_country_pcnt,le.populated_party_identification_number_pcnt,le.populated_main_hp_ahead_pcnt,le.populated_main_hp_astern_pcnt,le.populated_propulsion_type_pcnt,le.populated_hull_material_pcnt,le.populated_ship_yard_pcnt,le.populated_hull_builder_name_pcnt,le.populated_doc_certificate_status_pcnt,le.populated_date_issued_pcnt,le.populated_date_expires_pcnt,le.populated_hull_design_type_pcnt,le.populated_sail_ind_pcnt,le.populated_party_database_key_pcnt,le.populated_itc_tons_cod_ind_pcnt,le.populated_persistent_record_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_watercraft_key,le.maxlength_sequence_key,le.maxlength_state_origin,le.maxlength_source_code,le.maxlength_vessel_id,le.maxlength_vessel_database_key,le.maxlength_name_of_vessel,le.maxlength_call_sign,le.maxlength_official_number,le.maxlength_imo_number,le.maxlength_hull_number,le.maxlength_hull_identification_number,le.maxlength_vessel_service_type,le.maxlength_flag,le.maxlength_self_propelled_indicator,le.maxlength_registered_gross_tons,le.maxlength_registered_net_tons,le.maxlength_registered_length,le.maxlength_registered_breadth,le.maxlength_registered_depth,le.maxlength_itc_gross_tons,le.maxlength_itc_net_tons,le.maxlength_itc_length,le.maxlength_itc_breadth,le.maxlength_itc_depth,le.maxlength_hailing_port,le.maxlength_hailing_port_state,le.maxlength_hailing_port_province,le.maxlength_home_port_name,le.maxlength_home_port_state,le.maxlength_home_port_province,le.maxlength_trade_ind_coastwise_unrestricted,le.maxlength_trade_ind_limited_coastwise_bowaters_only,le.maxlength_trade_ind_limited_coastwise_restricted,le.maxlength_trade_ind_limited_coastwise_oil_spill_response_only,le.maxlength_trade_ind_limited_coastwise_under_charter_to_citizen,le.maxlength_trade_ind_fishery,le.maxlength_trade_ind_limited_fishery_only,le.maxlength_trade_ind_recreation,le.maxlength_trade_ind_limited_recreation_great_lakes_use_only,le.maxlength_trade_ind_registry,le.maxlength_trade_ind_limited_registry_cross_border_financing,le.maxlength_trade_ind_limited_registry_no_foreign_voyage,le.maxlength_trade_ind_limited_registry_trade_with_canada_only,le.maxlength_trade_ind_great_lakes,le.maxlength_vessel_complete_build_city,le.maxlength_vessel_complete_build_state,le.maxlength_vessel_complete_build_province,le.maxlength_vessel_complete_build_country,le.maxlength_vessel_build_year,le.maxlength_vessel_hull_build_city,le.maxlength_vessel_hull_build_state,le.maxlength_vessel_hull_build_province,le.maxlength_vessel_hull_build_country,le.maxlength_party_identification_number,le.maxlength_main_hp_ahead,le.maxlength_main_hp_astern,le.maxlength_propulsion_type,le.maxlength_hull_material,le.maxlength_ship_yard,le.maxlength_hull_builder_name,le.maxlength_doc_certificate_status,le.maxlength_date_issued,le.maxlength_date_expires,le.maxlength_hull_design_type,le.maxlength_sail_ind,le.maxlength_party_database_key,le.maxlength_itc_tons_cod_ind,le.maxlength_persistent_record_id);
  SELF.avelength := CHOOSE(C,le.avelength_watercraft_key,le.avelength_sequence_key,le.avelength_state_origin,le.avelength_source_code,le.avelength_vessel_id,le.avelength_vessel_database_key,le.avelength_name_of_vessel,le.avelength_call_sign,le.avelength_official_number,le.avelength_imo_number,le.avelength_hull_number,le.avelength_hull_identification_number,le.avelength_vessel_service_type,le.avelength_flag,le.avelength_self_propelled_indicator,le.avelength_registered_gross_tons,le.avelength_registered_net_tons,le.avelength_registered_length,le.avelength_registered_breadth,le.avelength_registered_depth,le.avelength_itc_gross_tons,le.avelength_itc_net_tons,le.avelength_itc_length,le.avelength_itc_breadth,le.avelength_itc_depth,le.avelength_hailing_port,le.avelength_hailing_port_state,le.avelength_hailing_port_province,le.avelength_home_port_name,le.avelength_home_port_state,le.avelength_home_port_province,le.avelength_trade_ind_coastwise_unrestricted,le.avelength_trade_ind_limited_coastwise_bowaters_only,le.avelength_trade_ind_limited_coastwise_restricted,le.avelength_trade_ind_limited_coastwise_oil_spill_response_only,le.avelength_trade_ind_limited_coastwise_under_charter_to_citizen,le.avelength_trade_ind_fishery,le.avelength_trade_ind_limited_fishery_only,le.avelength_trade_ind_recreation,le.avelength_trade_ind_limited_recreation_great_lakes_use_only,le.avelength_trade_ind_registry,le.avelength_trade_ind_limited_registry_cross_border_financing,le.avelength_trade_ind_limited_registry_no_foreign_voyage,le.avelength_trade_ind_limited_registry_trade_with_canada_only,le.avelength_trade_ind_great_lakes,le.avelength_vessel_complete_build_city,le.avelength_vessel_complete_build_state,le.avelength_vessel_complete_build_province,le.avelength_vessel_complete_build_country,le.avelength_vessel_build_year,le.avelength_vessel_hull_build_city,le.avelength_vessel_hull_build_state,le.avelength_vessel_hull_build_province,le.avelength_vessel_hull_build_country,le.avelength_party_identification_number,le.avelength_main_hp_ahead,le.avelength_main_hp_astern,le.avelength_propulsion_type,le.avelength_hull_material,le.avelength_ship_yard,le.avelength_hull_builder_name,le.avelength_doc_certificate_status,le.avelength_date_issued,le.avelength_date_expires,le.avelength_hull_design_type,le.avelength_sail_ind,le.avelength_party_database_key,le.avelength_itc_tons_cod_ind,le.avelength_persistent_record_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 69, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_code;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.vessel_id),TRIM((SALT30.StrType)le.vessel_database_key),TRIM((SALT30.StrType)le.name_of_vessel),TRIM((SALT30.StrType)le.call_sign),TRIM((SALT30.StrType)le.official_number),TRIM((SALT30.StrType)le.imo_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.hull_identification_number),TRIM((SALT30.StrType)le.vessel_service_type),TRIM((SALT30.StrType)le.flag),TRIM((SALT30.StrType)le.self_propelled_indicator),TRIM((SALT30.StrType)le.registered_gross_tons),TRIM((SALT30.StrType)le.registered_net_tons),TRIM((SALT30.StrType)le.registered_length),TRIM((SALT30.StrType)le.registered_breadth),TRIM((SALT30.StrType)le.registered_depth),TRIM((SALT30.StrType)le.itc_gross_tons),TRIM((SALT30.StrType)le.itc_net_tons),TRIM((SALT30.StrType)le.itc_length),TRIM((SALT30.StrType)le.itc_breadth),TRIM((SALT30.StrType)le.itc_depth),TRIM((SALT30.StrType)le.hailing_port),TRIM((SALT30.StrType)le.hailing_port_state),TRIM((SALT30.StrType)le.hailing_port_province),TRIM((SALT30.StrType)le.home_port_name),TRIM((SALT30.StrType)le.home_port_state),TRIM((SALT30.StrType)le.home_port_province),TRIM((SALT30.StrType)le.trade_ind_coastwise_unrestricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_bowaters_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_restricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_oil_spill_response_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_under_charter_to_citizen),TRIM((SALT30.StrType)le.trade_ind_fishery),TRIM((SALT30.StrType)le.trade_ind_limited_fishery_only),TRIM((SALT30.StrType)le.trade_ind_recreation),TRIM((SALT30.StrType)le.trade_ind_limited_recreation_great_lakes_use_only),TRIM((SALT30.StrType)le.trade_ind_registry),TRIM((SALT30.StrType)le.trade_ind_limited_registry_cross_border_financing),TRIM((SALT30.StrType)le.trade_ind_limited_registry_no_foreign_voyage),TRIM((SALT30.StrType)le.trade_ind_limited_registry_trade_with_canada_only),TRIM((SALT30.StrType)le.trade_ind_great_lakes),TRIM((SALT30.StrType)le.vessel_complete_build_city),TRIM((SALT30.StrType)le.vessel_complete_build_state),TRIM((SALT30.StrType)le.vessel_complete_build_province),TRIM((SALT30.StrType)le.vessel_complete_build_country),TRIM((SALT30.StrType)le.vessel_build_year),TRIM((SALT30.StrType)le.vessel_hull_build_city),TRIM((SALT30.StrType)le.vessel_hull_build_state),TRIM((SALT30.StrType)le.vessel_hull_build_province),TRIM((SALT30.StrType)le.vessel_hull_build_country),TRIM((SALT30.StrType)le.party_identification_number),TRIM((SALT30.StrType)le.main_hp_ahead),TRIM((SALT30.StrType)le.main_hp_astern),TRIM((SALT30.StrType)le.propulsion_type),TRIM((SALT30.StrType)le.hull_material),TRIM((SALT30.StrType)le.ship_yard),TRIM((SALT30.StrType)le.hull_builder_name),TRIM((SALT30.StrType)le.doc_certificate_status),TRIM((SALT30.StrType)le.date_issued),TRIM((SALT30.StrType)le.date_expires),TRIM((SALT30.StrType)le.hull_design_type),TRIM((SALT30.StrType)le.sail_ind),TRIM((SALT30.StrType)le.party_database_key),TRIM((SALT30.StrType)le.itc_tons_cod_ind),TRIM((SALT30.StrType)le.persistent_record_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,69,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 69);
  SELF.FldNo2 := 1 + (C % 69);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.vessel_id),TRIM((SALT30.StrType)le.vessel_database_key),TRIM((SALT30.StrType)le.name_of_vessel),TRIM((SALT30.StrType)le.call_sign),TRIM((SALT30.StrType)le.official_number),TRIM((SALT30.StrType)le.imo_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.hull_identification_number),TRIM((SALT30.StrType)le.vessel_service_type),TRIM((SALT30.StrType)le.flag),TRIM((SALT30.StrType)le.self_propelled_indicator),TRIM((SALT30.StrType)le.registered_gross_tons),TRIM((SALT30.StrType)le.registered_net_tons),TRIM((SALT30.StrType)le.registered_length),TRIM((SALT30.StrType)le.registered_breadth),TRIM((SALT30.StrType)le.registered_depth),TRIM((SALT30.StrType)le.itc_gross_tons),TRIM((SALT30.StrType)le.itc_net_tons),TRIM((SALT30.StrType)le.itc_length),TRIM((SALT30.StrType)le.itc_breadth),TRIM((SALT30.StrType)le.itc_depth),TRIM((SALT30.StrType)le.hailing_port),TRIM((SALT30.StrType)le.hailing_port_state),TRIM((SALT30.StrType)le.hailing_port_province),TRIM((SALT30.StrType)le.home_port_name),TRIM((SALT30.StrType)le.home_port_state),TRIM((SALT30.StrType)le.home_port_province),TRIM((SALT30.StrType)le.trade_ind_coastwise_unrestricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_bowaters_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_restricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_oil_spill_response_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_under_charter_to_citizen),TRIM((SALT30.StrType)le.trade_ind_fishery),TRIM((SALT30.StrType)le.trade_ind_limited_fishery_only),TRIM((SALT30.StrType)le.trade_ind_recreation),TRIM((SALT30.StrType)le.trade_ind_limited_recreation_great_lakes_use_only),TRIM((SALT30.StrType)le.trade_ind_registry),TRIM((SALT30.StrType)le.trade_ind_limited_registry_cross_border_financing),TRIM((SALT30.StrType)le.trade_ind_limited_registry_no_foreign_voyage),TRIM((SALT30.StrType)le.trade_ind_limited_registry_trade_with_canada_only),TRIM((SALT30.StrType)le.trade_ind_great_lakes),TRIM((SALT30.StrType)le.vessel_complete_build_city),TRIM((SALT30.StrType)le.vessel_complete_build_state),TRIM((SALT30.StrType)le.vessel_complete_build_province),TRIM((SALT30.StrType)le.vessel_complete_build_country),TRIM((SALT30.StrType)le.vessel_build_year),TRIM((SALT30.StrType)le.vessel_hull_build_city),TRIM((SALT30.StrType)le.vessel_hull_build_state),TRIM((SALT30.StrType)le.vessel_hull_build_province),TRIM((SALT30.StrType)le.vessel_hull_build_country),TRIM((SALT30.StrType)le.party_identification_number),TRIM((SALT30.StrType)le.main_hp_ahead),TRIM((SALT30.StrType)le.main_hp_astern),TRIM((SALT30.StrType)le.propulsion_type),TRIM((SALT30.StrType)le.hull_material),TRIM((SALT30.StrType)le.ship_yard),TRIM((SALT30.StrType)le.hull_builder_name),TRIM((SALT30.StrType)le.doc_certificate_status),TRIM((SALT30.StrType)le.date_issued),TRIM((SALT30.StrType)le.date_expires),TRIM((SALT30.StrType)le.hull_design_type),TRIM((SALT30.StrType)le.sail_ind),TRIM((SALT30.StrType)le.party_database_key),TRIM((SALT30.StrType)le.itc_tons_cod_ind),TRIM((SALT30.StrType)le.persistent_record_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.watercraft_key),TRIM((SALT30.StrType)le.sequence_key),TRIM((SALT30.StrType)le.state_origin),TRIM((SALT30.StrType)le.source_code),TRIM((SALT30.StrType)le.vessel_id),TRIM((SALT30.StrType)le.vessel_database_key),TRIM((SALT30.StrType)le.name_of_vessel),TRIM((SALT30.StrType)le.call_sign),TRIM((SALT30.StrType)le.official_number),TRIM((SALT30.StrType)le.imo_number),TRIM((SALT30.StrType)le.hull_number),TRIM((SALT30.StrType)le.hull_identification_number),TRIM((SALT30.StrType)le.vessel_service_type),TRIM((SALT30.StrType)le.flag),TRIM((SALT30.StrType)le.self_propelled_indicator),TRIM((SALT30.StrType)le.registered_gross_tons),TRIM((SALT30.StrType)le.registered_net_tons),TRIM((SALT30.StrType)le.registered_length),TRIM((SALT30.StrType)le.registered_breadth),TRIM((SALT30.StrType)le.registered_depth),TRIM((SALT30.StrType)le.itc_gross_tons),TRIM((SALT30.StrType)le.itc_net_tons),TRIM((SALT30.StrType)le.itc_length),TRIM((SALT30.StrType)le.itc_breadth),TRIM((SALT30.StrType)le.itc_depth),TRIM((SALT30.StrType)le.hailing_port),TRIM((SALT30.StrType)le.hailing_port_state),TRIM((SALT30.StrType)le.hailing_port_province),TRIM((SALT30.StrType)le.home_port_name),TRIM((SALT30.StrType)le.home_port_state),TRIM((SALT30.StrType)le.home_port_province),TRIM((SALT30.StrType)le.trade_ind_coastwise_unrestricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_bowaters_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_restricted),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_oil_spill_response_only),TRIM((SALT30.StrType)le.trade_ind_limited_coastwise_under_charter_to_citizen),TRIM((SALT30.StrType)le.trade_ind_fishery),TRIM((SALT30.StrType)le.trade_ind_limited_fishery_only),TRIM((SALT30.StrType)le.trade_ind_recreation),TRIM((SALT30.StrType)le.trade_ind_limited_recreation_great_lakes_use_only),TRIM((SALT30.StrType)le.trade_ind_registry),TRIM((SALT30.StrType)le.trade_ind_limited_registry_cross_border_financing),TRIM((SALT30.StrType)le.trade_ind_limited_registry_no_foreign_voyage),TRIM((SALT30.StrType)le.trade_ind_limited_registry_trade_with_canada_only),TRIM((SALT30.StrType)le.trade_ind_great_lakes),TRIM((SALT30.StrType)le.vessel_complete_build_city),TRIM((SALT30.StrType)le.vessel_complete_build_state),TRIM((SALT30.StrType)le.vessel_complete_build_province),TRIM((SALT30.StrType)le.vessel_complete_build_country),TRIM((SALT30.StrType)le.vessel_build_year),TRIM((SALT30.StrType)le.vessel_hull_build_city),TRIM((SALT30.StrType)le.vessel_hull_build_state),TRIM((SALT30.StrType)le.vessel_hull_build_province),TRIM((SALT30.StrType)le.vessel_hull_build_country),TRIM((SALT30.StrType)le.party_identification_number),TRIM((SALT30.StrType)le.main_hp_ahead),TRIM((SALT30.StrType)le.main_hp_astern),TRIM((SALT30.StrType)le.propulsion_type),TRIM((SALT30.StrType)le.hull_material),TRIM((SALT30.StrType)le.ship_yard),TRIM((SALT30.StrType)le.hull_builder_name),TRIM((SALT30.StrType)le.doc_certificate_status),TRIM((SALT30.StrType)le.date_issued),TRIM((SALT30.StrType)le.date_expires),TRIM((SALT30.StrType)le.hull_design_type),TRIM((SALT30.StrType)le.sail_ind),TRIM((SALT30.StrType)le.party_database_key),TRIM((SALT30.StrType)le.itc_tons_cod_ind),TRIM((SALT30.StrType)le.persistent_record_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),69*69,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'watercraft_key'}
      ,{2,'sequence_key'}
      ,{3,'state_origin'}
      ,{4,'source_code'}
      ,{5,'vessel_id'}
      ,{6,'vessel_database_key'}
      ,{7,'name_of_vessel'}
      ,{8,'call_sign'}
      ,{9,'official_number'}
      ,{10,'imo_number'}
      ,{11,'hull_number'}
      ,{12,'hull_identification_number'}
      ,{13,'vessel_service_type'}
      ,{14,'flag'}
      ,{15,'self_propelled_indicator'}
      ,{16,'registered_gross_tons'}
      ,{17,'registered_net_tons'}
      ,{18,'registered_length'}
      ,{19,'registered_breadth'}
      ,{20,'registered_depth'}
      ,{21,'itc_gross_tons'}
      ,{22,'itc_net_tons'}
      ,{23,'itc_length'}
      ,{24,'itc_breadth'}
      ,{25,'itc_depth'}
      ,{26,'hailing_port'}
      ,{27,'hailing_port_state'}
      ,{28,'hailing_port_province'}
      ,{29,'home_port_name'}
      ,{30,'home_port_state'}
      ,{31,'home_port_province'}
      ,{32,'trade_ind_coastwise_unrestricted'}
      ,{33,'trade_ind_limited_coastwise_bowaters_only'}
      ,{34,'trade_ind_limited_coastwise_restricted'}
      ,{35,'trade_ind_limited_coastwise_oil_spill_response_only'}
      ,{36,'trade_ind_limited_coastwise_under_charter_to_citizen'}
      ,{37,'trade_ind_fishery'}
      ,{38,'trade_ind_limited_fishery_only'}
      ,{39,'trade_ind_recreation'}
      ,{40,'trade_ind_limited_recreation_great_lakes_use_only'}
      ,{41,'trade_ind_registry'}
      ,{42,'trade_ind_limited_registry_cross_border_financing'}
      ,{43,'trade_ind_limited_registry_no_foreign_voyage'}
      ,{44,'trade_ind_limited_registry_trade_with_canada_only'}
      ,{45,'trade_ind_great_lakes'}
      ,{46,'vessel_complete_build_city'}
      ,{47,'vessel_complete_build_state'}
      ,{48,'vessel_complete_build_province'}
      ,{49,'vessel_complete_build_country'}
      ,{50,'vessel_build_year'}
      ,{51,'vessel_hull_build_city'}
      ,{52,'vessel_hull_build_state'}
      ,{53,'vessel_hull_build_province'}
      ,{54,'vessel_hull_build_country'}
      ,{55,'party_identification_number'}
      ,{56,'main_hp_ahead'}
      ,{57,'main_hp_astern'}
      ,{58,'propulsion_type'}
      ,{59,'hull_material'}
      ,{60,'ship_yard'}
      ,{61,'hull_builder_name'}
      ,{62,'doc_certificate_status'}
      ,{63,'date_issued'}
      ,{64,'date_expires'}
      ,{65,'hull_design_type'}
      ,{66,'sail_ind'}
      ,{67,'party_database_key'}
      ,{68,'itc_tons_cod_ind'}
      ,{69,'persistent_record_id'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_code) source_code; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_watercraft_key((SALT30.StrType)le.watercraft_key),
    Fields.InValid_sequence_key((SALT30.StrType)le.sequence_key),
    Fields.InValid_state_origin((SALT30.StrType)le.state_origin),
    Fields.InValid_source_code((SALT30.StrType)le.source_code),
    Fields.InValid_vessel_id((SALT30.StrType)le.vessel_id),
    Fields.InValid_vessel_database_key((SALT30.StrType)le.vessel_database_key),
    Fields.InValid_name_of_vessel((SALT30.StrType)le.name_of_vessel),
    Fields.InValid_call_sign((SALT30.StrType)le.call_sign),
    Fields.InValid_official_number((SALT30.StrType)le.official_number),
    Fields.InValid_imo_number((SALT30.StrType)le.imo_number),
    Fields.InValid_hull_number((SALT30.StrType)le.hull_number),
    Fields.InValid_hull_identification_number((SALT30.StrType)le.hull_identification_number),
    Fields.InValid_vessel_service_type((SALT30.StrType)le.vessel_service_type),
    Fields.InValid_flag((SALT30.StrType)le.flag),
    Fields.InValid_self_propelled_indicator((SALT30.StrType)le.self_propelled_indicator),
    Fields.InValid_registered_gross_tons((SALT30.StrType)le.registered_gross_tons),
    Fields.InValid_registered_net_tons((SALT30.StrType)le.registered_net_tons),
    Fields.InValid_registered_length((SALT30.StrType)le.registered_length),
    Fields.InValid_registered_breadth((SALT30.StrType)le.registered_breadth),
    Fields.InValid_registered_depth((SALT30.StrType)le.registered_depth),
    Fields.InValid_itc_gross_tons((SALT30.StrType)le.itc_gross_tons),
    Fields.InValid_itc_net_tons((SALT30.StrType)le.itc_net_tons),
    Fields.InValid_itc_length((SALT30.StrType)le.itc_length),
    Fields.InValid_itc_breadth((SALT30.StrType)le.itc_breadth),
    Fields.InValid_itc_depth((SALT30.StrType)le.itc_depth),
    Fields.InValid_hailing_port((SALT30.StrType)le.hailing_port),
    Fields.InValid_hailing_port_state((SALT30.StrType)le.hailing_port_state),
    Fields.InValid_hailing_port_province((SALT30.StrType)le.hailing_port_province),
    Fields.InValid_home_port_name((SALT30.StrType)le.home_port_name),
    Fields.InValid_home_port_state((SALT30.StrType)le.home_port_state),
    Fields.InValid_home_port_province((SALT30.StrType)le.home_port_province),
    Fields.InValid_trade_ind_coastwise_unrestricted((SALT30.StrType)le.trade_ind_coastwise_unrestricted),
    Fields.InValid_trade_ind_limited_coastwise_bowaters_only((SALT30.StrType)le.trade_ind_limited_coastwise_bowaters_only),
    Fields.InValid_trade_ind_limited_coastwise_restricted((SALT30.StrType)le.trade_ind_limited_coastwise_restricted),
    Fields.InValid_trade_ind_limited_coastwise_oil_spill_response_only((SALT30.StrType)le.trade_ind_limited_coastwise_oil_spill_response_only),
    Fields.InValid_trade_ind_limited_coastwise_under_charter_to_citizen((SALT30.StrType)le.trade_ind_limited_coastwise_under_charter_to_citizen),
    Fields.InValid_trade_ind_fishery((SALT30.StrType)le.trade_ind_fishery),
    Fields.InValid_trade_ind_limited_fishery_only((SALT30.StrType)le.trade_ind_limited_fishery_only),
    Fields.InValid_trade_ind_recreation((SALT30.StrType)le.trade_ind_recreation),
    Fields.InValid_trade_ind_limited_recreation_great_lakes_use_only((SALT30.StrType)le.trade_ind_limited_recreation_great_lakes_use_only),
    Fields.InValid_trade_ind_registry((SALT30.StrType)le.trade_ind_registry),
    Fields.InValid_trade_ind_limited_registry_cross_border_financing((SALT30.StrType)le.trade_ind_limited_registry_cross_border_financing),
    Fields.InValid_trade_ind_limited_registry_no_foreign_voyage((SALT30.StrType)le.trade_ind_limited_registry_no_foreign_voyage),
    Fields.InValid_trade_ind_limited_registry_trade_with_canada_only((SALT30.StrType)le.trade_ind_limited_registry_trade_with_canada_only),
    Fields.InValid_trade_ind_great_lakes((SALT30.StrType)le.trade_ind_great_lakes),
    Fields.InValid_vessel_complete_build_city((SALT30.StrType)le.vessel_complete_build_city),
    Fields.InValid_vessel_complete_build_state((SALT30.StrType)le.vessel_complete_build_state),
    Fields.InValid_vessel_complete_build_province((SALT30.StrType)le.vessel_complete_build_province),
    Fields.InValid_vessel_complete_build_country((SALT30.StrType)le.vessel_complete_build_country),
    Fields.InValid_vessel_build_year((SALT30.StrType)le.vessel_build_year),
    Fields.InValid_vessel_hull_build_city((SALT30.StrType)le.vessel_hull_build_city),
    Fields.InValid_vessel_hull_build_state((SALT30.StrType)le.vessel_hull_build_state),
    Fields.InValid_vessel_hull_build_province((SALT30.StrType)le.vessel_hull_build_province),
    Fields.InValid_vessel_hull_build_country((SALT30.StrType)le.vessel_hull_build_country),
    Fields.InValid_party_identification_number((SALT30.StrType)le.party_identification_number),
    Fields.InValid_main_hp_ahead((SALT30.StrType)le.main_hp_ahead),
    Fields.InValid_main_hp_astern((SALT30.StrType)le.main_hp_astern),
    Fields.InValid_propulsion_type((SALT30.StrType)le.propulsion_type),
    Fields.InValid_hull_material((SALT30.StrType)le.hull_material),
    Fields.InValid_ship_yard((SALT30.StrType)le.ship_yard),
    Fields.InValid_hull_builder_name((SALT30.StrType)le.hull_builder_name),
    Fields.InValid_doc_certificate_status((SALT30.StrType)le.doc_certificate_status),
    Fields.InValid_date_issued((SALT30.StrType)le.date_issued),
    Fields.InValid_date_expires((SALT30.StrType)le.date_expires),
    Fields.InValid_hull_design_type((SALT30.StrType)le.hull_design_type),
    Fields.InValid_sail_ind((SALT30.StrType)le.sail_ind),
    Fields.InValid_party_database_key((SALT30.StrType)le.party_database_key),
    Fields.InValid_itc_tons_cod_ind((SALT30.StrType)le.itc_tons_cod_ind),
    Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_code := le.source_code;
END;
Errors := NORMALIZE(h,69,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_code;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_code,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_code;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_blank','Unknown','invalid_state','invalid_source_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_hullnum','invalid_hullnum','Unknown','Unknown','Unknown','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','Unknown','Unknown','Unknown','Unknown','invalid_blank');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_watercraft_key(TotalErrors.ErrorNum),Fields.InValidMessage_sequence_key(TotalErrors.ErrorNum),Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_id(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_database_key(TotalErrors.ErrorNum),Fields.InValidMessage_name_of_vessel(TotalErrors.ErrorNum),Fields.InValidMessage_call_sign(TotalErrors.ErrorNum),Fields.InValidMessage_official_number(TotalErrors.ErrorNum),Fields.InValidMessage_imo_number(TotalErrors.ErrorNum),Fields.InValidMessage_hull_number(TotalErrors.ErrorNum),Fields.InValidMessage_hull_identification_number(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_service_type(TotalErrors.ErrorNum),Fields.InValidMessage_flag(TotalErrors.ErrorNum),Fields.InValidMessage_self_propelled_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_registered_gross_tons(TotalErrors.ErrorNum),Fields.InValidMessage_registered_net_tons(TotalErrors.ErrorNum),Fields.InValidMessage_registered_length(TotalErrors.ErrorNum),Fields.InValidMessage_registered_breadth(TotalErrors.ErrorNum),Fields.InValidMessage_registered_depth(TotalErrors.ErrorNum),Fields.InValidMessage_itc_gross_tons(TotalErrors.ErrorNum),Fields.InValidMessage_itc_net_tons(TotalErrors.ErrorNum),Fields.InValidMessage_itc_length(TotalErrors.ErrorNum),Fields.InValidMessage_itc_breadth(TotalErrors.ErrorNum),Fields.InValidMessage_itc_depth(TotalErrors.ErrorNum),Fields.InValidMessage_hailing_port(TotalErrors.ErrorNum),Fields.InValidMessage_hailing_port_state(TotalErrors.ErrorNum),Fields.InValidMessage_hailing_port_province(TotalErrors.ErrorNum),Fields.InValidMessage_home_port_name(TotalErrors.ErrorNum),Fields.InValidMessage_home_port_state(TotalErrors.ErrorNum),Fields.InValidMessage_home_port_province(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_coastwise_unrestricted(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_coastwise_bowaters_only(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_coastwise_restricted(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_coastwise_oil_spill_response_only(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_coastwise_under_charter_to_citizen(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_fishery(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_fishery_only(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_recreation(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_recreation_great_lakes_use_only(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_registry(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_registry_cross_border_financing(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_registry_no_foreign_voyage(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_limited_registry_trade_with_canada_only(TotalErrors.ErrorNum),Fields.InValidMessage_trade_ind_great_lakes(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_complete_build_city(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_complete_build_state(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_complete_build_province(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_complete_build_country(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_build_year(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_hull_build_city(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_hull_build_state(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_hull_build_province(TotalErrors.ErrorNum),Fields.InValidMessage_vessel_hull_build_country(TotalErrors.ErrorNum),Fields.InValidMessage_party_identification_number(TotalErrors.ErrorNum),Fields.InValidMessage_main_hp_ahead(TotalErrors.ErrorNum),Fields.InValidMessage_main_hp_astern(TotalErrors.ErrorNum),Fields.InValidMessage_propulsion_type(TotalErrors.ErrorNum),Fields.InValidMessage_hull_material(TotalErrors.ErrorNum),Fields.InValidMessage_ship_yard(TotalErrors.ErrorNum),Fields.InValidMessage_hull_builder_name(TotalErrors.ErrorNum),Fields.InValidMessage_doc_certificate_status(TotalErrors.ErrorNum),Fields.InValidMessage_date_issued(TotalErrors.ErrorNum),Fields.InValidMessage_date_expires(TotalErrors.ErrorNum),Fields.InValidMessage_hull_design_type(TotalErrors.ErrorNum),Fields.InValidMessage_sail_ind(TotalErrors.ErrorNum),Fields.InValidMessage_party_database_key(TotalErrors.ErrorNum),Fields.InValidMessage_itc_tons_cod_ind(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_code=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;

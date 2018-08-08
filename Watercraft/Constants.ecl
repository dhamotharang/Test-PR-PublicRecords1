export Constants := module

	export boolean Build_BID_Key_Flag := true;

	// DF-21844 Following fields need to be deprecated in thor_data400::key::watercraft::fcra::sid_qa.
	export fields_to_clear_sid := 'company_name,gender,orig_fips,orig_province,phone_2,title';

	// DF-21844 Following fields need to be deprecated in thor_data400::key::watercraft::fcra::cid_qa
	export fields_to_clear_cid := 'call_sign,date_expires,date_issued,doc_certificate_status,flag,hailing_port,hailing_port_province,' +
										 'hailing_port_state,home_port_name,home_port_province,home_port_state,hull_builder_name,hull_design_type,' +
										 'hull_identification_number,hull_material,imo_number,itc_breadth,itc_depth,itc_gross_tons,itc_net_tons,' +
										 'itc_tons_cod_ind,main_hp_ahead,main_hp_astern,name_of_vessel,official_number,party_database_key,' +
										 'party_identification_number,propulsion_type,registered_breadth,registered_depth,registered_gross_tons,' +
										 'registered_length,registered_net_tons,sail_ind,self_propelled_indicator,ship_yard,trade_ind_coastwise_unrestricted,' +
										 'trade_ind_fishery,trade_ind_great_lakes,trade_ind_limited_coastwise_bowaters_only,trade_ind_limited_coastwise_oil_spill_response_only,' +
										 'trade_ind_limited_coastwise_restricted,trade_ind_limited_coastwise_under_charter_to_citizen,' +
										 'trade_ind_limited_fishery_only,trade_ind_limited_recreation_great_lakes_use_only,' +
										 'trade_ind_limited_registry_cross_border_financing,trade_ind_limited_registry_no_foreign_voyage,' +
										 'trade_ind_limited_registry_trade_with_canada_only,trade_ind_recreation,trade_ind_registry,vessel_build_year,' +
										 'vessel_complete_build_city,vessel_complete_build_country,vessel_complete_build_province,' +
										 'vessel_complete_build_state,vessel_database_key,vessel_hull_build_city,vessel_hull_build_country,' +
										 'vessel_hull_build_province,vessel_hull_build_state,vessel_id,vessel_service_type';

	// DF-21844 Following fields need to be deprecated in thor_data400::key::watercraft::fcra::wid_qa
	export fields_to_clear_wid := 'additional_owner_count,coast_guard_documented_flag,coast_guard_number,coastguard_flag,county_registration,' +
										 'dealer,decal_number,engine_make_1,engine_make_2,engine_make_3,engine_model_1,engine_model_2,engine_model_3,' +
										 'engine_number_1,engine_number_2,engine_number_3,engine_year_1,engine_year_2,engine_year_3,fuel_code,fuel_description,' +
										 'lien_2_address_1,lien_2_address_2,lien_2_city,lien_2_date,lien_2_indicator,lien_2_name,lien_2_state,' +
										 'lien_2_zip,new_used_flag,propulsion_code,propulsion_description,purchase_date,purchase_price,' +
										 'registration_expiration_date,registration_renewal_date,registration_status_code,registration_status_date,' +
										 'registration_status_description,signatory,state_purchased,title_state,title_type_code,title_type_description,' +
										 'transaction_type_code,transaction_type_description,use_code,use_description,vehicle_type_code,' +
										 'watercraft_color_1_code,watercraft_color_1_description,watercraft_color_2_code,watercraft_color_2_description,' +
										 'watercraft_hp_1,watercraft_hp_2,watercraft_hp_3,watercraft_name,watercraft_number_of_engines,' +
										 'watercraft_status_code,watercraft_status_description,watercraft_toilet_code,watercraft_toilet_description,' +
										 'watercraft_weight,watercraft_width';

end;
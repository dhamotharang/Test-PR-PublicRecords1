// Layout for OKC property data extract
export layout_export_assessor_base := record
  string12	ln_id;
  string8		process_date;
  string1		current_record;
  string5		fips_code;
  string2		state_code;
  string30	county_name;
	string31 	old_apn;
  string45	apna_or_pin_number;
  string45	unformatted_apn;
  string2		duplicate_apn_multiple_address_id;
  string80	assessee_name;
  string60	second_assessee_name;
  string3		assessee_ownership_rights_code;
  string2		assessee_relationship_code;
  string10	assessee_phone_number;
  string30	tax_account_number;
  string45	contract_owner;
  string1		assessee_name_type_code;
  string1		second_assessee_name_type_code;
  string1		mail_care_of_name_type_code;
  string60	mailing_care_of_name;
  string80	mailing_full_street_address;
  string6		mailing_unit_number;
  string51	mailing_city_state_zip;
  string60	property_full_street_address;
  string6		property_unit_number;
  string51	property_city_state_zip;
  string3		property_country_code;
  string1		property_address_code;
  string2		legal_lot_code;
  string7		legal_lot_number;
  string10	legal_land_lot;
  string7		legal_block;
  string7		legal_section;
  string12	legal_district;
  string6		legal_unit;
  string30	legal_city_municipality_township;
  string40	legal_subdivision_name;
  string7		legal_phase_number;
  string10	legal_tract_number;
  string30	legal_sec_twn_rng_mer;
  string250	legal_brief_description;
  string15	legal_assessor_map_ref;
  string10	census_tract;
  string2		record_type_code;
  string2		ownership_type_code;
  string2		new_record_type_code;
	string10 	state_land_use_code;
  string10	county_land_use_code;
  string45	county_land_use_description;
  string4		standardized_land_use_code;
  string1		timeshare_code;
  string25	zoning;
  string1		owner_occupied;
  string20	recorder_document_number;
  string10	recorder_book_number;
  string10	recorder_page_number;
  string8		transfer_date;
  string8		recording_date;
  string8		sale_date;
  string25	document_type;
  string11	sales_price;
  string1		sales_price_code;
  string11	mortgage_loan_amount;
  string5		mortgage_loan_type_code;
  string60	mortgage_lender_name;
  string1		mortgage_lender_type_code;
  string8		prior_transfer_date;
  string8		prior_recording_date;
  string11	prior_sales_price;
  string1		prior_sales_price_code;
  string11	assessed_land_value;
  string11	assessed_improvement_value;
  string11	assessed_total_value;
  string4		assessed_value_year;
  string11	market_land_value;
  string11	market_improvement_value;
  string11	market_total_value;
  string4		market_value_year;
  string1		homestead_homeowner_exemption;
  string1		tax_exemption1_code;
  string1		tax_exemption2_code;
  string1		tax_exemption3_code;
  string1		tax_exemption4_code;
  string18	tax_rate_code_area;
  string13	tax_amount;
  string4		tax_year;
  string4		tax_delinquent_year;
  string15	school_tax_district1;
  string1		school_tax_district1_indicator;
  string15	school_tax_district2;
  string1		school_tax_district2_indicator;
  string15	school_tax_district3;
  string1		school_tax_district3_indicator;
	string20 	lot_size;
	string10 	lot_size_acres;
	string10 	lot_size_frontage_feet;
	string10 	lot_size_depth_feet;
  string30	land_acres;
  string30	land_square_footage;
  string30	land_dimensions;
  string9		building_area;
  string1		building_area_indicator;
  string8		building_area1;
  string2		building_area1_indicator;
  string8		building_area2;
  string2		building_area2_indicator;
  string8		building_area3;
  string2		building_area3_indicator;
  string8		building_area4;
  string2		building_area4_indicator;
  string8		building_area5;
  string2		building_area5_indicator;
  string8		building_area6;
  string2		building_area6_indicator;
  string8		building_area7;
  string2		building_area7_indicator;
  string4		year_built;
  string4		effective_year_built;
  string3		no_of_buildings;
  string5		no_of_stories;
  string5		no_of_units;
  string5		no_of_rooms;
  string5		no_of_bedrooms;
  string8		no_of_baths;
  string2		no_of_partial_baths;
	string3 	no_of_plumbing_fixtures;
  string3		garage_type_code;
  string5		parking_no_of_cars;
  string3		pool_code;
  string5		style_code;
  string3		type_construction_code;
  string3		foundation_code;
	string3 	building_quality_code;
	string3 	building_condition_code;
  string3		exterior_walls_code;
	string1 	interior_walls_code;
  string3		roof_cover_code;
  string5		roof_type_code;
	string3 	floor_cover_code;
	string3 	water_code;
	string3 	sewer_code;
  string3		heating_code;
  string3		heating_fuel_type_code;
  string3		air_conditioning_code;
  string1		air_conditioning_type_code;
  string1		elevator;
  string1		fireplace_indicator;
  string3		fireplace_number;
  string3		basement_code;
  string3		building_class_code;
  string3		site_influence1_code;
  string1		site_influence2_code;
  string1		site_influence3_code;
  string1		site_influence4_code;
  string1		site_influence5_code;
  string1		amenities1_code;
  string1		amenities2_code;
  string1		amenities3_code;
  string1		amenities4_code;
  string1		amenities5_code;
	string1 	amenities2_code1;
	string1 	amenities2_code2;
	string1 	amenities2_code3;
	string1 	amenities2_code4;
	string1 	amenities2_code5;
	string9 	extra_features1_area;
	string2 	extra_features1_indicator;
	string9 	extra_features2_area;
	string2 	extra_features2_indicator;
	string9 	extra_features3_area;	
	string2 	extra_features3_indicator;
	string9 	extra_features4_area;
	string2 	extra_features4_indicator;
  string3		other_buildings1_code;
  string1		other_buildings2_code;
  string1		other_buildings3_code;
  string1		other_buildings4_code;
  string1		other_buildings5_code;
	string2		other_impr_building1_indicator;
	string2		other_impr_building2_indicator;
	string2		other_impr_building3_indicator;
	string2		other_impr_building4_indicator;
	string2		other_impr_building5_indicator;
	string9 	other_impr_building_area1;
	string9 	other_impr_building_area2;
	string9 	other_impr_building_area3;
	string9 	other_impr_building_area4;
	string9 	other_impr_building_area5;
	string1 	topograpy_code;
  string9		neighborhood_code;
  string20	condo_project_or_building_name;
  string1		assessee_name_indicator;
  string1		second_assessee_name_indicator;
	string5 	other_rooms_indicator;
  string1		mail_care_of_name_indicator;  
  string120	comments;
	string6 	tape_cut_date;
	string8 	certification_date;
	string2 	edition_number;
	string1 	prop_addr_propagated_ind;
	string3	 	ln_ownership_rights;
  string2	 	ln_relationship_type;
	string3	 	ln_mailing_country_code;
  string50 	ln_property_name;
  string1	 	ln_property_name_type;
  string1	 	ln_land_use_category;
  string20 	ln_lot;
  string20 	ln_block;
  string6	 	ln_unit;
  string1	 	ln_mobile_home_indicator;
  string1	 	ln_condo_indicator;
  string1	 	ln_property_tax_exemption;
  string1	 	ln_veteran_status;
end;
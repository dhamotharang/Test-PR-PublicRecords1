export layout_watercraft_report := record, maxlength(50000)
     //the last few
	string30	watercraft_key := '';
	string30	sequence_key := '';
	string2	state_origin := '';
	string25  state_origin_full := '';
	boolean   nondmvsource := false;
	string30	hull_number := '';
	string50	name_of_vessel := '';
	string10	rec_type;
	string10	vessel_number := '';
	string8	date_last_seen := '';
	//description
	string5	watercraft_length := '';
	string5	watercraft_width := '';
	string10	watercraft_weight := '';
	string30	watercraft_make_description := '';
	string30	watercraft_model_description := '';
	string4	model_year := '';
	string20	hull_type_description := '';
	string20	use_description := '';
	string20	watercraft_color_1_description := '';
	string20	watercraft_color_2_description := '';
	string20	propulsion_description := '';
	string20	fuel_description := '';
	string6	registered_breadth := '';
	string6	registered_depth := '';
	string7	registered_length := '';
	string7	registered_gross_tons := '';
	string7	registered_net_tons := '';
	//registration
	string40	registration_status_description := '';
	string20	registration_number := '';
	string8	registration_date := '';
	string8	registration_expiration_date := '';
	//title
	string2	title_state := '';
	string40	title_status_description := '';
	string20	title_number := '';
	string20	title_type_description := '';
	string8	title_issue_date := '';
	//purchase
	string8	purchase_date := '';
	string10	purchase_price := '';
	string40	dealer := '';
	string2	state_purchased := '';
	//manufacturer
	string50	ship_yard := '';
	string50	hailing_port := '';
	string2	hailing_port_state := '';
	string50	hailing_port_province := '';
	string4	vessel_build_year := '';
	string50	vessel_complete_build_city := '';
	string2	vessel_complete_build_state := '';
	string50	vessel_complete_build_province := '';
	string64	vessel_complete_build_country := '';
	string50	vessel_hull_build_city := '';
	string2	vessel_hull_build_state := '';
	string50	vessel_hull_build_province := '';
	string64	vessel_hull_build_country := '';
	//owners info
     dataset(layout_watercraft_owner) owners;
	//LienHolders
	dataset(layout_watercraft_lien) lienholders; 
	//Engines
	dataset(layout_watercraft_engine) engines;
end;
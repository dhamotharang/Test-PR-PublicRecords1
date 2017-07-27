export layout_watercraft_report_append := record
	layout_watercraft_report;
	//to get the liens records
	string40	lien_1_name := '';
	string8	lien_1_date := '';
	string60	lien_1_address_1 := '';
	string60	lien_1_address_2 := '';
	string25	lien_1_city := '';
	string2	lien_1_state := '';
	string10	lien_1_zip := '';
	string40	lien_2_name := '';
	string8	lien_2_date := '';
	string60	lien_2_address_1 := '';
	string60	lien_2_address_2 := '';
	string25	lien_2_city := '';
	string2	lien_2_state := '';
	string10	lien_2_zip := '';
     //to get the engine records
	string5	watercraft_hp_1 := '';
	string5	watercraft_hp_2 := '';
	string5	watercraft_hp_3 := '';
	string20	engine_make_1 := '';
	string20	engine_make_2 := '';
	string20	engine_make_3 := '';
	string20	engine_model_1 := '';
	string20	engine_model_2 := '';
	string20	engine_model_3 := '';
end;
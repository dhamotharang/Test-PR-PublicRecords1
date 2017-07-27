IMPORT FFD;
export layout_FAR_engine := record
	string8 	filedate;
	string5 	engine_mfr_model_code;
	string10	engine_mfr_name;
	string13 	model_name;
	string1 	type_engine;
	string5 	engine_hp_or_thrust;
	string6 	fuel_consumed;
	string1 	lf;
	string20 engine_type_mapped := '';
	FFD.Layouts.CommonRawRecordElements;
end;
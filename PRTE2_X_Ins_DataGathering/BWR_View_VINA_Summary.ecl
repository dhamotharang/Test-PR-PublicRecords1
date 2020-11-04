IMPORT VINA;

MiniRec := RECORD
  string4 make_abbreviation;
  string35 make_name;
  string1 vehicle_type;
  string17 base_model;
  string10 series_name_full_spelling;
  string20 full_body_style_name;
END;

DS1 := PROJECT(VINA.key_vin,MiniRec);
DS2 := TABLE(DS1,
				{make_abbreviation,make_name,vehicle_type,base_model,series_name_full_spelling,full_body_style_name,unsigned2 vehCnt := COUNT(GROUP)}
				,make_abbreviation,make_name,vehicle_type,base_model,series_name_full_spelling,full_body_style_name);
COUNT(DS2);
OUTPUT(DS2,ALL);
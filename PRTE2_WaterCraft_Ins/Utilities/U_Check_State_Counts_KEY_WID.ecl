﻿/* *******************************************************************************************
Template to read keys.
to fill in 
KeyFileName - whatever key file name with/without foreign
Layout_In_EclWatch   - in ECL watch look up the key, hit contents then ECL tab - copy layout here.
IndexFields - on the contents ECL watch spot the fields with "i" flag, move them from above down to here
******************************************************************************************* */
IMPORT data_services;

KeyFileName := data_services.foreign_prod+'thor_data400::key::watercraft_wid_qa';

Layout_In_EclWatch := RECORD
RECORD
  string10 watercraft_id;
  string2 source_code;
  string2 st_registration;
  string15 county_registration;
  string20 registration_number;
  string30 hull_number;
  string2 propulsion_code;
  string20 propulsion_description;
  string2 vehicle_type_code;
  string20 vehicle_type_description;
  string1 fuel_code;
  string20 fuel_description;
  string5 hull_type_code;
  string20 hull_type_description;
  string5 use_code;
  string20 use_description;
  string4 model_year;
  string40 watercraft_name;
  string5 watercraft_class_code;
  string35 watercraft_class_description;
  string5 watercraft_make_code;
  string30 watercraft_make_description;
  string5 watercraft_model_code;
  string30 watercraft_model_description;
  string5 watercraft_length;
  string5 watercraft_width;
  string10 watercraft_weight;
  string3 watercraft_color_1_code;
  string20 watercraft_color_1_description;
  string3 watercraft_color_2_code;
  string20 watercraft_color_2_description;
  string2 watercraft_toilet_code;
  string40 watercraft_toilet_description;
  string2 watercraft_number_of_engines;
  string5 watercraft_hp_1;
  string5 watercraft_hp_2;
  string5 watercraft_hp_3;
  string20 engine_number_1;
  string20 engine_number_2;
  string20 engine_number_3;
  string20 engine_make_1;
  string20 engine_make_2;
  string20 engine_make_3;
  string20 engine_model_1;
  string20 engine_model_2;
  string20 engine_model_3;
  string4 engine_year_1;
  string4 engine_year_2;
  string4 engine_year_3;
  string1 coast_guard_documented_flag;
  string30 coast_guard_number;
  string8 registration_date;
  string8 registration_expiration_date;
  string5 registration_status_code;
  string40 registration_status_description;
  string8 registration_status_date;
  string8 registration_renewal_date;
  string20 decal_number;
  string5 transaction_type_code;
  string40 transaction_type_description;
  string2 title_state;
  string5 title_status_code;
  string40 title_status_description;
  string20 title_number;
  string8 title_issue_date;
  string5 title_type_code;
  string20 title_type_description;
  string1 additional_owner_count;
  string1 lien_1_indicator;
  string40 lien_1_name;
  string8 lien_1_date;
  string60 lien_1_address_1;
  string60 lien_1_address_2;
  string25 lien_1_city;
  string2 lien_1_state;
  string10 lien_1_zip;
  string1 lien_2_indicator;
  string40 lien_2_name;
  string8 lien_2_date;
  string60 lien_2_address_1;
  string60 lien_2_address_2;
  string25 lien_2_city;
  string2 lien_2_state;
  string10 lien_2_zip;
  string2 state_purchased;
  string8 purchase_date;
  string40 dealer;
  string10 purchase_price;
  string1 new_used_flag;
  string5 watercraft_status_code;
  string20 watercraft_status_description;
  string1 history_flag;
  string1 coastguard_flag;
  string4 signatory;
  unsigned8 persistent_record_id;
 END;
END;
IndexFields := RECORD
  string2 state_origin;
  string30 watercraft_key;
  string30 sequence_key;
END;

prct_data_key := INDEX({IndexFields}, Layout_In_EclWatch, keyFileName);

DataIn := prct_data_key;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.State_Origin;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,State_Origin);
OUTPUT(SORT(RepTable0,-GroupCount));

OUTPUT(prct_data_key);



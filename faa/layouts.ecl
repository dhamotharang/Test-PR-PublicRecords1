import Address,NID;
export layouts := module

// Airmen Raw Layouts

export airmen := module

 export pilotraw := record
  
   
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
   string30 orig_lname;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;   
   string906 Filler; 
   string2 lfcr;
end;

export nonpilotraw := record
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
   string30 orig_lname;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;    
   string2 lfcr;
end;

export nonpilotrawfill := record
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
   string30 orig_lname;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;   
   string906 Filler;
   string2 lfcr;
end;

export input := record
   string8	date_first_seen;
   string8	date_last_seen;
   string1	current_flag;
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
   string30 orig_lname;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;     
   string15 filler; 
   string2 lfcr;
end;

export temp := record
   string8 date_first_seen;
   string8 date_last_seen;
   string1 current_flag;
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
	 string30 orig_mname;
   string30 orig_lname;
	 string10 namesuffix;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;  	
   string2 oer;
   UNSIGNED8 raw_aid;
	UNSIGNED8 ace_aid;
  Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
end;

export clean := record
   string8 date_first_seen;
   string8 date_last_seen;
   string1 current_flag;
   string1 letter_code;
   string7 unique_id;
   string2 orig_rec_type;
   string30 orig_fname;
   string30 orig_lname;
   string33 street1;
   string33 street2;
   string17 city;
   string2 state;
   string10 zip_code;
   string18 country;
   string2 region;
   string1 med_class;
   string6 med_date;
   string6 med_exp_date;
   string8 basic_med_course_date;
   string8 basic_med_cmec_date;     
	string2 oer;
   UNSIGNED8 raw_aid;
	UNSIGNED8 ace_aid;
  Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
end;


end;

export aircraft_raw := module

export engine := record
   string CODE;
   string MFR;
   string MODEL;
   string MTYPE;
   string HORSEPOWER;
   string FUEL_CONSUMED;
   string lf;
end;

export master := record

   string N_NUMBER;
   string SERIAL_NUMBER;
   string MFR_MDL_CODE;
   string ENG_MFR_MDL;
   string YEAR_MFR;
   string TYPE_REGISTRANT;
   string NAME;
   string STREET;
   string STREET2;
   string CITY;
   string STATE;
   string ZIP_CODE;
   string REGION;
   string COUNTY;
   string COUNTRY;
   string LAST_ACTION_DATE;
   string CERT_ISSUE_DATE;
   string CERTIFICATION;
   string TYPE_AIRCRAFT;
   string TYPE_ENGINE;
   string STATUS_CODE;
   string MODE_S_CODE;
   string FRACT_OWNER;
   string crap;
end;


export acft :=  record
   string MFR_MDL_CODE;
   string MFR_NAME;
   string MODEL;
   string TYPE_ACFT;
   string TYPE_ENG;
   string AC_CAT;
   string AMAT_IND;
   string NO_ENG;
   string NO_SEATS;
   string AC_WEIGHT;
   string SPEED;
   string crlf;
end;

end;

export aircraft_fixed := module

export engine := record
	string8 	filedate;
	string5 	engine_mfr_model_code;
	string10	engine_mfr_name;
	string13 	model_name;
	string2 	type_engine;
	string5 	engine_hp_or_thrust;
	string6 	fuel_consumed;
	string1 	lf;
end;

export master := record
   string8	date_first_seen;
   string8	date_last_seen;
   string1	current_flag;
   string8 N_NUMBER;
   string30 SERIAL_NUMBER;
   string12 MFR_MDL_CODE;
   string11 ENG_MFR_MDL;
   string8 YEAR_MFR;
   string15 TYPE_REGISTRANT;
   string50 NAME;
   string33 STREET;
   string33 STREET2;
   string18 CITY;
   string5 STATE;
   string10 ZIP_CODE;
   string6 REGION;
   string6 COUNTY;
   string7 COUNTRY;
   string16 LAST_ACTION_DATE;
   string15 CERT_ISSUE_DATE;
   string13 CERTIFICATION;
   string13 TYPE_AIRCRAFT;
   string11 TYPE_ENGINE;
   string11 STATUS_CODE;
   string11 MODE_S_CODE;
   string11 FRACT_OWNER;
   string1 lf;
end;

export actref := record
   string8	filedate;
   string7 MFR_MDL_CODE;
   string30 MFR_NAME;
   string20 MODEL;
   string1 TYPE_ACFT;
   string2 TYPE_ENG;
   string1 AC_CAT;
   string1 AMAT_IND;
   string2 NO_ENG;
   string3 NO_SEATS;
   string7 AC_WEIGHT;
   string4 SPEED;
   string2 lf;
end;

end;

export aircraft_reg := module

export temp := record
   string8 date_first_seen;
   string8 date_last_seen;
   string1 current_flag;
   string8 n_number;
   string30 serial_number;
   string12 mfr_mdl_code;
   string11 eng_mfr_mdl;
   string8 year_mfr;
   string15 type_registrant;
   string50 name;
   string33 street;
   string33 street2;
   string18 city;
   string5 state;
   string10 zip_code;
   string6 region;
   string6 orig_county;
   string7 country;
   string16 last_action_date;
   string15 cert_issue_date;
   string13 certification;
   string13 type_aircraft;
   string11 type_engine;
   string11 status_code;
   string11 mode_s_code;
   string11 fract_owner;
   string30 aircraft_mfr_name;
   string20 model_name;
	 UNSIGNED8 raw_aid;
	 UNSIGNED8 ace_aid;
  Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
   string50 compname;
	 NID.Common.xNameString fullnm;
   string1 lf;
end;

export innew := record
   string8 date_first_seen;
   string8 date_last_seen;
   string1 current_flag;
   string8 n_number;
   string30 serial_number;
   string12 mfr_mdl_code;
   string11 eng_mfr_mdl;
   string8 year_mfr;
   string15 type_registrant;
   string50 name;
   string33 street;
   string33 street2;
   string18 city;
   string5 state;
   string10 zip_code;
   string6 region;
   string6 orig_county;
   string7 country;
   string16 last_action_date;
   string15 cert_issue_date;
   string13 certification;
   string13 type_aircraft;
   string11 type_engine;
   string11 status_code;
   string11 mode_s_code;
   string11 fract_owner;
   string30 aircraft_mfr_name;
   string20 model_name;
	 UNSIGNED8 raw_aid;
	 UNSIGNED8 ace_aid;
  Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
   string50 compname;
   string1 lf;
end;

end;
end;
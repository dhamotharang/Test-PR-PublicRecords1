export layout_common_aircraft_airman_cert:= record

//airman&aircraft
string2  source_type; //AR= Aircraft Registration AM=Airmen AC=Airmen Cert
string3	 d_score;
string9	 best_ssn;
UNSIGNED8 did_out;
UNSIGNED8 bdid_out;
string8  date_first_seen;
string8  date_last_seen;
string1  current_flag;

//name and address
string50 name;
string30 orig_fname;
string30 orig_lname;
string33 street1;
string33 street2;
string18 city;
string5  state;
string10 zip_code;
string6  region;
string6  orig_county;
string7  country; 

//aircraft
string8 	n_number;
string30 	serial_number;
string12 	mfr_mdl_code;
string11 	eng_mfr_mdl;
string8 	year_mfr;
string15 	type_registrant;
string16 	last_action_date;
string15 	cert_issue_date;
string13 	certification;
string13 	type_aircraft;
string11 	type_engine;
string11 	status_code;
string11 	mode_s_code;
string11 	fract_owner;
string30 	aircraft_mfr_name;
string20 	model_name;
string50 	compname;

//airman
string10 record_type;
string1 letter_code;
string1 med_class;
string6 med_date;
string6 med_exp_date;

//cert and airman
string7 unique_id;
string2 orig_rec_type;

//certification
string1 letter;
string1 cer_type;
string20	cer_type_mapped;
string1 cer_level;
string45	cer_level_mapped;
string8 cer_exp_date;
string99 ratings;

//cleaned fields
string10 prim_range;
string2 predir;
string28 prim_name;
string4 suffix;
string2 postdir;
string10 unit_desig;
string8 sec_range;
string25 p_city_name;
string25 v_city_name;
string2 st;
string5 zip;
string4 zip4;
string4 cart;
string1 cr_sort_sz;
string4 lot;
string1 lot_order;
string2 dpbc;
string1 chk_digit;
string2 rec_type;
string2 ace_fips_st;
string3  county;
string18 county_name;
string10 geo_lat;
string11 geo_long;
string4 msa;
string7 geo_blk;
string1 geo_match;
string4 err_stat;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;

//autokey
unsigned1 zero := 0;
unsigned6 aircraft_id;

end;

import address, standard;

export Layout_PCNSR := record
			standard.name;
STRING15 	fname_orig;
STRING1		mname_orig;
STRING20	lname_orig;
STRING2		name_suffix_orig;
STRING1		title_orig;
			address.Layout_Clean182;
			unsigned8 hhid ;
			UNSIGNED6 	did;
      UNSIGNED1 	did_score;
			STRING10 		phone_forDID;
      STRING1  		gender;
      STRING6  		date_of_birth;
      STRING1  		address_type;
      STRING1  		demographic_level_indicator;
      STRING2  		length_of_residence;
      STRING1  		location_type;
      STRING2  		dqi2_occupancy_count;
      STRING2  		delivery_unit_size;
      STRING4  		household_arrival_date;
  string3 npa;
  string3 nxx;
  string1 tb;
  string3 phone3;
  string1 telephone_number_type;
  string3 npa_2;
  string3 nxx_2;
  string1 tb_2;
  string3 phone3_2;
      STRING1  		telephone2_number_type;
      STRING1  		time_zone;
      STRING6  		refresh_date;
      STRING1  		name_address_verification_source;
      STRING1  		drop_indicator;
      STRING1  		do_not_mail_flag;
      STRING1  		do_not_call_flag;
      STRING1  		business_file_hit_flag;
      STRING5 		spouse_title;
      STRING20 		spouse_fname;
      STRING20 		spouse_mname;
      STRING20 		spouse_lname;
      STRING5  		spouse_name_suffix;
STRING15  spouse_fname_orig;
STRING1		spouse_mname_orig;
STRING20	spouse_lname_orig;
STRING2		spouse_name_suffix_orig;
STRING1		spouse_title_orig;
      STRING1  		spouse_gender;
      STRING6  		spouse_date_of_birth;
      STRING1  		spouse_indicator;
      STRING1  		household_income;
      STRING6  		find_income_in_1000s;
      STRING6  		phhincomeunder25k;
      STRING6  		phhincome50kplus;
      STRING6  		phhincome200kplus;
      STRING10  	medianhhincome;
      STRING1  		own_rent;
      STRING1  		homeowner_source_code;
end;
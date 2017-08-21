import ut, Hygenics_Soff;

df 	:= Hygenics_Soff.File_Accurint_In;
df2 := Hygenics_Soff.File_Accurint_Search_In;

	layout_common_person into(df L) := transform
		self.person_id 				:= L.seisint_primary_key[5..];
		self.record_type 			:= '';
		self.title 					:= '';
		self.reg_county 			:= L.registration_county;
		self.phone10 				:= '';
		self.process_date 			:= ut.getDate;
		self.minor_victim 			:= L.victim_minor_1;
	//	self.dc := L.doc_number;
		self.date_address_added 	:= L.reg_date_1;
		self.resident_Or_temp 		:= L.registration_type;
		self.status 				:= L.offender_status;
		self.did 					:= '';
		self.score 					:= '';
		self.ssn_appended 			:= '';
		self.rawaid 				:= 0;
		self.curr_incar_flag 		:= '';
		self.curr_parole_flag 		:= '';
		self.curr_probation_flag 	:= '';
		self 						:= L;
	end;

o1 := project(df,into(LEFT));

	o1 getdid(o1 L, df2 R) := transform
		self.did 			:= R.did;
		self.score 			:= R.did_score;
		self.ssn_appended 	:= R.ssn_appended;
		self.prim_range 	:= R.prim_range;
		self.predir 		:= R.predir;
		self.prim_name 		:= R.prim_name;
		self.addr_suffix 	:= R.addr_suffix;
		self.postdir 		:= R.postdir;
		self.unit_desig 	:= R.unit_desig;
		self.sec_range 		:= R.sec_range;
		self.p_city_name 	:= R.p_city_name;
		self.v_city_name 	:= R.v_city_name;
		self.st 			:= R.st;
		self.zip5 			:= R.zip;
		self.zip4 			:= R.zip4;
		self.geo_lat 		:= R.geo_lat;
		self.geo_long 		:= R.geo_long;
		self.geo_match 		:= R.geo_match;
		self.rawaid 		:= r.rawaid;
		self.lname 			:= r.lname;
		self.mname 			:= r.mname;
		self.fname 			:= r.fname;
		self.name_suffix 	:= r.name_suffix;
		self.record_type 	:= r.rec_type;
		// Added the following two values - bug 22000 ver. by CNG
		self.name_type 		:= r.name_type;
		self.nid					:= r.nid;
		self.ntype				:= r.ntype;
		self.nindicator		:= r.nindicator;
    self.offender_persistent_id := r.offender_persistent_id;
		self.dob 			:= r.dob;
		self 				:= L;
	end;

// Join the primary file with the search file
o2 :=join(o1
         ,df2
		 ,left.seisint_primary_key = right.seisint_primary_key
		 ,getdid(LEFT,RIGHT)
		 ,hash
		 ,left outer);

// Only keep the data when there is some kind of name
o3 := o1(   lname       <> '' 
         or mname       <> '' 
		 or fname       <> '' 
		 or name_suffix <> '');


	o3 get_new_recs(o3 L) := transform
		self := L;
	end;

o4 := join(o3, df2
		  ,left.seisint_primary_key                      		= right.seisint_primary_key 
	       and stringlib.StringToUpperCase(left.lname)       	= stringlib.StringToUpperCase(right.lname) 
	       and stringlib.StringToUpperCase(left.mname)       	= stringlib.StringToUpperCase(right.mname) 
	       and stringlib.StringToUpperCase(left.fname)      	 = stringlib.StringToUpperCase(right.fname) 
	       and stringlib.StringToUpperCase(left.name_suffix) 	= stringlib.StringToUpperCase(right.name_suffix)
	      ,get_new_recs(left)
		  ,hash
		  ,left only);

srt_df2 := sort(df2, seisint_primary_key, -(unsigned2)did_score);
dep_df2 := dedup(srt_df2, seisint_primary_key);

	o4 get_new_names(o4 L, dep_df2 R) := transform
		self.did 			:= R.did;
		self.score 			:= R.did_score;
		self.ssn_appended 	:= R.ssn_appended;
		self.prim_range 	:= R.prim_range;
		self.predir 		:= R.predir;
		self.prim_name 		:= R.prim_name;
		self.addr_suffix 	:= R.addr_suffix;
		self.postdir 		:= R.postdir;
		self.unit_desig 	:= R.unit_desig;
		self.sec_range 		:= R.sec_range;
		self.p_city_name 	:= R.p_city_name;
		self.v_city_name 	:= R.v_city_name;
		self.st 			:= R.st;
		self.zip5 			:= R.zip;
		self.zip4 			:= R.zip4;
		self.geo_lat 		:= R.geo_lat;
		self.geo_long 		:= R.geo_long;
		self.geo_match 		:= R.geo_match;
		self.rawaid 		:= r.rawaid;
		self.lname 			:= stringlib.StringToUpperCase(L.lname);
		self.mname 			:= stringlib.StringToUpperCase(L.mname);
		self.fname 			:= stringlib.StringToUpperCase(L.fname);
		self.name_suffix 	:= stringlib.StringToUpperCase(L.name_suffix);
		self 				:= L;
	end;

o5 := join(o4
          ,dep_df2
		  ,left.seisint_primary_key = right.seisint_primary_key
		  ,get_new_names(left, right)
		  ,hash
		  ,left outer);
		  
concat_file := o2 + o5 : persist('~thor_data400::Persist::hd::Accurint_Person_As_Common');

/*
dslayout := RECORD
  string23 person_id;
  string2 record_type;
  string5 title;
  string8 dt_first_reported;
  string8 dt_last_reported;
  string8 src_upload_date;
  string2 orig_state;
  string16 seisint_primary_key;
  string2 vendor_code;
  string320 intnet_email_address_1;
  string320 intnet_email_address_2;
  string320 intnet_email_address_3;
  string320 intnet_email_address_4;
  string320 intnet_email_address_5;
  string320 intnet_instant_message_addr_1;
  string320 intnet_instant_message_addr_2;
  string320 intnet_instant_message_addr_3;
  string320 intnet_instant_message_addr_4;
  string320 intnet_instant_message_addr_5;
  string320 intnet_user_name_1;
  string255 intnet_user_name_1_url;
  string320 intnet_user_name_2;
  string255 intnet_user_name_2_url;
  string320 intnet_user_name_3;
  string255 intnet_user_name_3_url;
  string320 intnet_user_name_4;
  string255 intnet_user_name_4_url;
  string320 intnet_user_name_5;
  string255 intnet_user_name_5_url;
  string20 source_file;
  string50 name_orig;
  string30 lname;
  string30 fname;
  string20 mname;
  string20 name_suffix;
  string1 name_type;
  string50 offender_status;
  string40 offender_category;
  string10 risk_level_code;
  string50 risk_description;
  string50 police_agency;
  string35 police_agency_contact_name;
  string55 police_agency_address_1;
  string35 police_agency_address_2;
  string10 police_agency_phone;
  string25 registration_type;
  string8 reg_date_1;
  string28 reg_date_1_type;
  string8 reg_date_2;
  string28 reg_date_2_type;
  string8 reg_date_3;
  string28 reg_date_3_type;
  string125 registration_address_1;
  string45 registration_address_2;
  string35 registration_address_3;
  string35 registration_address_4;
  string35 registration_address_5;
  string35 registration_county;
  string10 registration_home_phone;
  string10 registration_cell_phone;
  string125 other_registration_address_1;
  string45 other_registration_address_2;
  string35 other_registration_address_3;
  string35 other_registration_address_4;
  string35 other_registration_address_5;
  string35 other_registration_county;
  string10 other_registration_phone;
  string125 temp_lodge_address_1;
  string45 temp_lodge_address_2;
  string35 temp_lodge_address_3;
  string35 temp_lodge_address_4;
  string35 temp_lodge_address_5;
  string35 temp_lodge_county;
  string10 temp_lodge_phone;
  string55 employer;
  string55 employer_address_1;
  string35 employer_address_2;
  string35 employer_address_3;
  string35 employer_address_4;
  string35 employer_address_5;
  string35 employer_county;
  string10 employer_phone;
  string140 employer_comments;
  string75 professional_licenses_1;
  string75 professional_licenses_2;
  string75 professional_licenses_3;
  string75 professional_licenses_4;
  string75 professional_licenses_5;
  string55 school;
  string55 school_address_1;
  string35 school_address_2;
  string35 school_address_3;
  string35 school_address_4;
  string35 school_address_5;
  string35 school_county;
  string10 school_phone;
  string140 school_comments;
  string30 offender_id;
  string30 doc_number;
  string30 sor_number;
  string30 st_id_number;
  string30 fbi_number;
  string30 ncic_number;
  string9 ssn;
  string8 dob;
  string8 dob_aka;
  string3 age;
  string250 dna;
  string30 race;
  string30 ethnicity;
  string10 sex;
  string40 hair_color;
  string40 eye_color;
  string3 height;
  string3 weight;
  string20 skin_tone;
  string30 build_type;
  string200 scars_marks_tattoos;
  string6 shoe_size;
  string1 corrective_lense_flag;
  string8 arrest_date_1;
  string250 arrest_warrant_1;
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
  string8 arrest_date_2;
  string250 arrest_warrant_2;
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string180 offense_description_2;
  string180 offense_description_2_2;
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
  string8 arrest_date_3;
  string250 arrest_warrant_3;
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string180 offense_description_3;
  string180 offense_description_3_2;
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
  string8 arrest_date_4;
  string250 arrest_warrant_4;
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string180 offense_description_4;
  string180 offense_description_4_2;
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string30 victim_relationship_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string180 offense_description_5;
  string180 offense_description_5_2;
  string1 victim_minor_5;
  string3 victim_age_5;
  string10 victim_gender_5;
  string30 victim_relationship_5;
  string180 sentence_description_5;
  string180 sentence_description_5_2;
  string140 addl_comments_1;
  string140 addl_comments_2;
  string30 orig_dl_number;
  string2 orig_dl_state;
  string150 orig_dl_link;
  string8 orig_dl_date;
  string1 passport_type;
  string10 passport_code;
  string25 passport_number;
  string50 passport_first_name;
  string100 passport_given_name;
  string30 passport_nationality;
  string8 passport_dob;
  string55 passport_place_of_birth;
  string10 passport_sex;
  string8 passport_issue_date;
  string55 passport_authority;
  string8 passport_expiration_date;
  string50 passport_endorsement;
  string150 passport_link;
  string8 passport_date;
  string4 orig_veh_year_1;
  string40 orig_veh_color_1;
  string40 orig_veh_make_model_1;
  string40 orig_veh_plate_1;
  string17 orig_registration_number_1;
  string2 orig_veh_state_1;
  string50 orig_veh_location_1;
  string4 orig_veh_year_2;
  string40 orig_veh_color_2;
  string40 orig_veh_make_model_2;
  string40 orig_veh_plate_2;
  string17 orig_registration_number_2;
  string2 orig_veh_state_2;
  string50 orig_veh_location_2;
  string4 orig_veh_year_3;
  string40 orig_veh_color_3;
  string40 orig_veh_make_model_3;
  string40 orig_veh_plate_3;
  string17 orig_registration_number_3;
  string2 orig_veh_state_3;
  string50 orig_veh_location_3;
  string4 orig_veh_year_4;
  string40 orig_veh_color_4;
  string40 orig_veh_make_model_4;
  string40 orig_veh_plate_4;
  string17 orig_registration_number_4;
  string2 orig_veh_state_4;
  string50 orig_veh_location_4;
  string4 orig_veh_year_5;
  string40 orig_veh_color_5;
  string40 orig_veh_make_model_5;
  string40 orig_veh_plate_5;
  string17 orig_registration_number_5;
  string2 orig_veh_state_5;
  string50 orig_veh_location_5;
  string150 fingerprint_link;
  string8 fingerprint_date;
  string150 palmprint_link;
  string8 palmprint_date;
  string150 image_link;
  string8 image_date;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 addr_suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring25 v_city_name;
  string2 st;
  qstring5 zip5;
  qstring4 zip4;
  qstring4 cart;
  string1 cr_sort_sz;
  qstring4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  qstring5 county;
  qstring10 geo_lat;
  qstring11 geo_long;
  qstring4 msa;
  qstring7 geo_blk;
  string1 geo_match;
  qstring4 err_stat;
  unsigned1 clean_errors;
  unsigned8 rawaid;
  string21 reg_county;
  string10 phone10;
  string8 process_date;
  string1 minor_victim;
  string8 date_address_added;
  string10 resident_or_temp;
  string50 status;
  string12 did;
  string3 score;
  string9 ssn_appended;
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
 END;

concat_file := dataset('~thor_data400::persist::hd::accurint_person_as_common', dslayout, flat);
*/
export Mapping_Accurint_Person_As_Common := concat_file;
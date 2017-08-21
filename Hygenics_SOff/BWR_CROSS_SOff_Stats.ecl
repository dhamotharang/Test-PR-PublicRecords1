///////////////////////////////////////////////////////////
//GENERATE CROSS SOFF STATS////////////////////////////////
///////////////////////////////////////////////////////////

soff_offender:= RECORD 
  unsigned8 did;
  unsigned1 score;
  string9 ssn_appended;
  unsigned1 ssn_perms;
  string8 dt_first_reported;
  string8 dt_last_reported;
  string30 orig_state;
  string2 orig_state_code;
  string16 seisint_primary_key;
  string2 vendor_code;
  string20 source_file;
  string2 record_type;
  string50 name_orig;
  string30 lname;
  string30 fname;
  string20 mname;
  string20 name_suffix;
  string1 name_type;
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
  string6 addr_dt_last_seen;
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
  string1 curr_incar_flag;
  string1 curr_parole_flag;
  string1 curr_probation_flag;
END;

pMain := DATASET('~thor_data400::base::sex_offender_mainpublic' ,soff_offender, FLAT);

zz := RECORD
,maxLength(200000)
  string16 seisint_primary_key;
  string80 conviction_jurisdiction;
  string8 conviction_date;
  string30 court;
  string25 court_case_number;
  string8 offense_date;
  string20 offense_code_or_statute;
  string320 offense_description;
  string180 offense_description_2;
  string30 offense_category;
  string1 victim_minor;
  string3 victim_age;
  string10 victim_gender;
  string30 victim_relationship;
  string180 sentence_description;
  string180 sentence_description_2;
  string8 arrest_date;
  string250 arrest_warrant;
END;

poffenses := DATASET('~thor_data400::base::sex_offender_offensespublic', zz, FLAT);

rPopulationStats_SexOffender_file_Main :=
  record
    	CountGroup                              := count(group);
    	did_CountNonZero 			:= sum(group, if(pMain.did<>0,1,0));
	score_CountNonZero 			:= sum(group, if(pMain.score<>0,1,0));
	ssn_appended_CountNonBlank 		:= sum(group, if(pMain.ssn_appended<>'',1,0));
	ssn_perms_CountNonZero 			:= sum(group, if(pMain.ssn_perms<>0,1,0));
	dt_first_reported_CountNonBlank 	:= sum(group, if(pMain.dt_first_reported<>'',1,0));
	dt_last_reported_CountNonBlank 		:= sum(group, if(pMain.dt_last_reported<>'',1,0));
	orig_state_CountNonBlank 		:= sum(group, if(pMain.orig_state<>'',1,0));
	pMain.orig_state_code;
	seisint_primary_key_CountNonBlank 	:= sum(group, if(pMain.seisint_primary_key<>'',1,0));
	vendor_code_CountNonBlank 		:= sum(group, if(pMain.vendor_code<>'',1,0));
	pMain.source_file;
	record_type_CountNonBlank 		:= sum(group, if(pMain.record_type<>'',1,0));
	name_orig_CountNonBlank 		:= sum(group, if(pMain.name_orig<>'',1,0));
	lname_CountNonBlank 			:= sum(group, if(pMain.lname<>'',1,0));
	fname_CountNonBlank 			:= sum(group, if(pMain.fname<>'',1,0));
	mname_CountNonBlank 			:= sum(group, if(pMain.mname<>'',1,0));
	name_suffix_CountNonBlank 		:= sum(group, if(pMain.name_suffix<>'',1,0));
	name_type_CountNonBlank 		:= sum(group, if(pMain.name_type<>'',1,0));
	intnet_email_address_1_CountNonBlank 	:= sum(group, if(pMain.intnet_email_address_1<>'',1,0));
	intnet_email_address_2_CountNonBlank 	:= sum(group, if(pMain.intnet_email_address_2<>'',1,0));
	intnet_email_address_3_CountNonBlank 	:= sum(group, if(pMain.intnet_email_address_3<>'',1,0));
	intnet_email_address_4_CountNonBlank 	:= sum(group, if(pMain.intnet_email_address_4<>'',1,0));
	intnet_email_address_5_CountNonBlank 	:= sum(group, if(pMain.intnet_email_address_5<>'',1,0));
	intnet_instant_message_addr_1_CountNonBlank := sum(group, if(pMain.intnet_instant_message_addr_1<>'',1,0));
	intnet_instant_message_addr_2_CountNonBlank := sum(group, if(pMain.intnet_instant_message_addr_2<>'',1,0));
	intnet_instant_message_addr_3_CountNonBlank := sum(group, if(pMain.intnet_instant_message_addr_3<>'',1,0));
	intnet_instant_message_addr_4_CountNonBlank := sum(group, if(pMain.intnet_instant_message_addr_4<>'',1,0));
	intnet_instant_message_addr_5_CountNonBlank := sum(group, if(pMain.intnet_instant_message_addr_5<>'',1,0));
	intnet_user_name_1_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_1<>'',1,0));
	intnet_user_name_1_url_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_1_url<>'',1,0));
	intnet_user_name_2_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_2<>'',1,0));
	intnet_user_name_2_url_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_2_url<>'',1,0));
	intnet_user_name_3_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_3<>'',1,0));
	intnet_user_name_3_url_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_3_url<>'',1,0));
	intnet_user_name_4_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_4<>'',1,0));
	intnet_user_name_4_url_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_4_url<>'',1,0));
	intnet_user_name_5_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_5<>'',1,0));
	intnet_user_name_5_url_CountNonBlank 	:= sum(group, if(pMain.intnet_user_name_5_url<>'',1,0));
	offender_status_CountNonBlank 		:= sum(group, if(pMain.offender_status<>'',1,0));
	offender_category_CountNonBlank 	:= sum(group, if(pMain.offender_category<>'',1,0));
	risk_level_code_CountNonBlank 		:= sum(group, if(pMain.risk_level_code<>'',1,0));
	risk_description_CountNonBlank 		:= sum(group, if(pMain.risk_description<>'',1,0));
	police_agency_CountNonBlank 		:= sum(group, if(pMain.police_agency<>'',1,0));
	police_agency_contact_name_CountNonBlank := sum(group, if(pMain.police_agency_contact_name<>'',1,0));
	police_agency_address_1_CountNonBlank 	:= sum(group, if(pMain.police_agency_address_1<>'',1,0));
	police_agency_address_2_CountNonBlank 	:= sum(group, if(pMain.police_agency_address_2<>'',1,0));
	police_agency_phone_CountNonBlank 	:= sum(group, if(pMain.police_agency_phone<>'',1,0));
	registration_type_CountNonBlank 	:= sum(group, if(pMain.registration_type<>'',1,0));
	reg_date_1_CountNonBlank 		:= sum(group, if(pMain.reg_date_1<>'',1,0));
	reg_date_1_type_CountNonBlank 		:= sum(group, if(pMain.reg_date_1_type<>'',1,0));
	reg_date_2_CountNonBlank 		:= sum(group, if(pMain.reg_date_2<>'',1,0));
	reg_date_2_type_CountNonBlank 		:= sum(group, if(pMain.reg_date_2_type<>'',1,0));
	reg_date_3_CountNonBlank 		:= sum(group, if(pMain.reg_date_3<>'',1,0));
	reg_date_3_type_CountNonBlank 		:= sum(group, if(pMain.reg_date_3_type<>'',1,0));
	registration_address_1_CountNonBlank 	:= sum(group, if(pMain.registration_address_1<>'',1,0));
	registration_address_2_CountNonBlank 	:= sum(group, if(pMain.registration_address_2<>'',1,0));
	registration_address_3_CountNonBlank 	:= sum(group, if(pMain.registration_address_3<>'',1,0));
	registration_address_4_CountNonBlank 	:= sum(group, if(pMain.registration_address_4<>'',1,0));
	registration_address_5_CountNonBlank 	:= sum(group, if(pMain.registration_address_5<>'',1,0));
	registration_county_CountNonBlank 	:= sum(group, if(pMain.registration_county<>'',1,0));
	registration_home_phone_CountNonBlank 	:= sum(group, if(pMain.registration_home_phone<>'',1,0));
	registration_cell_phone_CountNonBlank 	:= sum(group, if(pMain.registration_cell_phone<>'',1,0));
	other_registration_address_1_CountNonBlank := sum(group, if(pMain.other_registration_address_1<>'',1,0));
	other_registration_address_2_CountNonBlank := sum(group, if(pMain.other_registration_address_2<>'',1,0));
	other_registration_address_3_CountNonBlank := sum(group, if(pMain.other_registration_address_3<>'',1,0));
	other_registration_address_4_CountNonBlank := sum(group, if(pMain.other_registration_address_4<>'',1,0));
	other_registration_address_5_CountNonBlank := sum(group, if(pMain.other_registration_address_5<>'',1,0));
	other_registration_county_CountNonBlank := sum(group, if(pMain.other_registration_county<>'',1,0));
	other_registration_phone_CountNonBlank 	:= sum(group, if(pMain.other_registration_phone<>'',1,0));
	temp_lodge_address_1_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_address_1<>'',1,0));
	temp_lodge_address_2_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_address_2<>'',1,0));
	temp_lodge_address_3_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_address_3<>'',1,0));
	temp_lodge_address_4_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_address_4<>'',1,0));
	temp_lodge_address_5_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_address_5<>'',1,0));
	temp_lodge_county_CountNonBlank 	:= sum(group, if(pMain.temp_lodge_county<>'',1,0));
	temp_lodge_phone_CountNonBlank 		:= sum(group, if(pMain.temp_lodge_phone<>'',1,0));
	employer_CountNonBlank 			:= sum(group, if(pMain.employer<>'',1,0));
	employer_address_1_CountNonBlank 	:= sum(group, if(pMain.employer_address_1<>'',1,0));
	employer_address_2_CountNonBlank 	:= sum(group, if(pMain.employer_address_2<>'',1,0));
	employer_address_3_CountNonBlank 	:= sum(group, if(pMain.employer_address_3<>'',1,0));
	employer_address_4_CountNonBlank 	:= sum(group, if(pMain.employer_address_4<>'',1,0));
	employer_address_5_CountNonBlank 	:= sum(group, if(pMain.employer_address_5<>'',1,0));
	employer_county_CountNonBlank 		:= sum(group, if(pMain.employer_county<>'',1,0));
	employer_phone_CountNonBlank 		:= sum(group, if(pMain.employer_phone<>'',1,0));
	employer_comments_CountNonBlank 	:= sum(group, if(pMain.employer_comments<>'',1,0));
	professional_licenses_1_CountNonBlank 	:= sum(group, if(pMain.professional_licenses_1<>'',1,0));
	professional_licenses_2_CountNonBlank 	:= sum(group, if(pMain.professional_licenses_2<>'',1,0));
	professional_licenses_3_CountNonBlank 	:= sum(group, if(pMain.professional_licenses_3<>'',1,0));
	professional_licenses_4_CountNonBlank 	:= sum(group, if(pMain.professional_licenses_4<>'',1,0));
	professional_licenses_5_CountNonBlank 	:= sum(group, if(pMain.professional_licenses_5<>'',1,0));
	school_CountNonBlank 			:= sum(group, if(pMain.school<>'',1,0));
	school_address_1_CountNonBlank 		:= sum(group, if(pMain.school_address_1<>'',1,0));
	school_address_2_CountNonBlank 		:= sum(group, if(pMain.school_address_2<>'',1,0));
	school_address_3_CountNonBlank 		:= sum(group, if(pMain.school_address_3<>'',1,0));
	school_address_4_CountNonBlank 		:= sum(group, if(pMain.school_address_4<>'',1,0));
	school_address_5_CountNonBlank 		:= sum(group, if(pMain.school_address_5<>'',1,0));
	school_county_CountNonBlank 		:= sum(group, if(pMain.school_county<>'',1,0));
	school_phone_CountNonBlank 		:= sum(group, if(pMain.school_phone<>'',1,0));
	school_comments_CountNonBlank 		:= sum(group, if(pMain.school_comments<>'',1,0));
	offender_id_CountNonBlank 		:= sum(group, if(pMain.offender_id<>'',1,0));
	doc_number_CountNonBlank 		:= sum(group, if(pMain.doc_number<>'',1,0));
	sor_number_CountNonBlank 		:= sum(group, if(pMain.sor_number<>'',1,0));
	st_id_number_CountNonBlank 		:= sum(group, if(pMain.st_id_number<>'',1,0));
	fbi_number_CountNonBlank 		:= sum(group, if(pMain.fbi_number<>'',1,0));
	ncic_number_CountNonBlank 		:= sum(group, if(pMain.ncic_number<>'',1,0));
	ssn_CountNonBlank 			:= sum(group, if(pMain.ssn<>'',1,0));
	dob_CountNonBlank 			:= sum(group, if(pMain.dob<>'',1,0));
	dob_aka_CountNonBlank 			:= sum(group, if(pMain.dob_aka<>'',1,0));
	age_CountNonBlank 			:= sum(group, if(pMain.age<>'',1,0));
	dna_CountNonBlank 			:= sum(group, if(pMain.dna<>'',1,0));
	race_CountNonBlank 			:= sum(group, if(pMain.race<>'',1,0));
	ethnicity_CountNonBlank 		:= sum(group, if(pMain.ethnicity<>'',1,0));
	sex_CountNonBlank 			:= sum(group, if(pMain.sex<>'',1,0));
	hair_color_CountNonBlank 		:= sum(group, if(pMain.hair_color<>'',1,0));
	eye_color_CountNonBlank 		:= sum(group, if(pMain.eye_color<>'',1,0));
	height_CountNonBlank 			:= sum(group, if(pMain.height<>'',1,0));
	weight_CountNonBlank 			:= sum(group, if(pMain.weight<>'',1,0));
	skin_tone_CountNonBlank 		:= sum(group, if(pMain.skin_tone<>'',1,0));
	build_type_CountNonBlank 		:= sum(group, if(pMain.build_type<>'',1,0));
	scars_marks_tattoos_CountNonBlank 	:= sum(group, if(pMain.scars_marks_tattoos<>'',1,0));
	shoe_size_CountNonBlank 		:= sum(group, if(pMain.shoe_size<>'',1,0));
	corrective_lense_flag_CountNonBlank 	:= sum(group, if(pMain.corrective_lense_flag<>'',1,0));
	addl_comments_1_CountNonBlank 		:= sum(group, if(pMain.addl_comments_1<>'',1,0));
	addl_comments_2_CountNonBlank 		:= sum(group, if(pMain.addl_comments_2<>'',1,0));
	orig_dl_number_CountNonBlank 		:= sum(group, if(pMain.orig_dl_number<>'',1,0));
	orig_dl_state_CountNonBlank 		:= sum(group, if(pMain.orig_dl_state<>'',1,0));
	orig_dl_link_CountNonBlank 		:= sum(group, if(pMain.orig_dl_link<>'',1,0));
	orig_dl_date_CountNonBlank 		:= sum(group, if(pMain.orig_dl_date<>'',1,0));
	passport_type_CountNonBlank 		:= sum(group, if(pMain.passport_type<>'',1,0));
	passport_code_CountNonBlank 		:= sum(group, if(pMain.passport_code<>'',1,0));
	passport_number_CountNonBlank 		:= sum(group, if(pMain.passport_number<>'',1,0));
	passport_first_name_CountNonBlank 	:= sum(group, if(pMain.passport_first_name<>'',1,0));
	passport_given_name_CountNonBlank 	:= sum(group, if(pMain.passport_given_name<>'',1,0));
	passport_nationality_CountNonBlank 	:= sum(group, if(pMain.passport_nationality<>'',1,0));
	passport_dob_CountNonBlank 		:= sum(group, if(pMain.passport_dob<>'',1,0));
	passport_place_of_birth_CountNonBlank 	:= sum(group, if(pMain.passport_place_of_birth<>'',1,0));
	passport_sex_CountNonBlank 		:= sum(group, if(pMain.passport_sex<>'',1,0));
	passport_issue_date_CountNonBlank 	:= sum(group, if(pMain.passport_issue_date<>'',1,0));
	passport_authority_CountNonBlank 	:= sum(group, if(pMain.passport_authority<>'',1,0));
	passport_expiration_date_CountNonBlank 	:= sum(group, if(pMain.passport_expiration_date<>'',1,0));
	passport_endorsement_CountNonBlank 	:= sum(group, if(pMain.passport_endorsement<>'',1,0));
	passport_link_CountNonBlank 		:= sum(group, if(pMain.passport_link<>'',1,0));
	passport_date_CountNonBlank 		:= sum(group, if(pMain.passport_date<>'',1,0));
	orig_veh_year_1_CountNonBlank 		:= sum(group, if(pMain.orig_veh_year_1<>'',1,0));
	orig_veh_color_1_CountNonBlank 		:= sum(group, if(pMain.orig_veh_color_1<>'',1,0));
	orig_veh_make_model_1_CountNonBlank 	:= sum(group, if(pMain.orig_veh_make_model_1<>'',1,0));
	orig_veh_plate_1_CountNonBlank 		:= sum(group, if(pMain.orig_veh_plate_1<>'',1,0));
	orig_registration_number_1_CountNonBlank := sum(group, if(pMain.orig_registration_number_1<>'',1,0));
	orig_veh_state_1_CountNonBlank 		:= sum(group, if(pMain.orig_veh_state_1<>'',1,0));
	orig_veh_location_1_CountNonBlank 	:= sum(group, if(pMain.orig_veh_location_1<>'',1,0));
	orig_veh_year_2_CountNonBlank 		:= sum(group, if(pMain.orig_veh_year_2<>'',1,0));
	orig_veh_color_2_CountNonBlank 		:= sum(group, if(pMain.orig_veh_color_2<>'',1,0));
	orig_veh_make_model_2_CountNonBlank 	:= sum(group, if(pMain.orig_veh_make_model_2<>'',1,0));
	orig_veh_plate_2_CountNonBlank 		:= sum(group, if(pMain.orig_veh_plate_2<>'',1,0));
	orig_registration_number_2_CountNonBlank := sum(group, if(pMain.orig_registration_number_2<>'',1,0));
	orig_veh_state_2_CountNonBlank 		:= sum(group, if(pMain.orig_veh_state_2<>'',1,0));
	orig_veh_location_2_CountNonBlank 	:= sum(group, if(pMain.orig_veh_location_2<>'',1,0));
	orig_veh_year_3_CountNonBlank 		:= sum(group, if(pMain.orig_veh_year_3<>'',1,0));
	orig_veh_color_3_CountNonBlank 		:= sum(group, if(pMain.orig_veh_color_3<>'',1,0));
	orig_veh_make_model_3_CountNonBlank 	:= sum(group, if(pMain.orig_veh_make_model_3<>'',1,0));
	orig_veh_plate_3_CountNonBlank 		:= sum(group, if(pMain.orig_veh_plate_3<>'',1,0));
	orig_registration_number_3_CountNonBlank := sum(group, if(pMain.orig_registration_number_3<>'',1,0));
	orig_veh_state_3_CountNonBlank 		:= sum(group, if(pMain.orig_veh_state_3<>'',1,0));
	orig_veh_location_3_CountNonBlank 	:= sum(group, if(pMain.orig_veh_location_3<>'',1,0));
	orig_veh_year_4_CountNonBlank 		:= sum(group, if(pMain.orig_veh_year_4<>'',1,0));
	orig_veh_color_4_CountNonBlank 		:= sum(group, if(pMain.orig_veh_color_4<>'',1,0));
	orig_veh_make_model_4_CountNonBlank 	:= sum(group, if(pMain.orig_veh_make_model_4<>'',1,0));
	orig_veh_plate_4_CountNonBlank 		:= sum(group, if(pMain.orig_veh_plate_4<>'',1,0));
	orig_registration_number_4_CountNonBlank := sum(group, if(pMain.orig_registration_number_4<>'',1,0));
	orig_veh_state_4_CountNonBlank 		:= sum(group, if(pMain.orig_veh_state_4<>'',1,0));
	orig_veh_location_4_CountNonBlank 	:= sum(group, if(pMain.orig_veh_location_4<>'',1,0));
	orig_veh_year_5_CountNonBlank 		:= sum(group, if(pMain.orig_veh_year_5<>'',1,0));
	orig_veh_color_5_CountNonBlank 		:= sum(group, if(pMain.orig_veh_color_5<>'',1,0));
	orig_veh_make_model_5_CountNonBlank 	:= sum(group, if(pMain.orig_veh_make_model_5<>'',1,0));
	orig_veh_plate_5_CountNonBlank 		:= sum(group, if(pMain.orig_veh_plate_5<>'',1,0));
	orig_registration_number_5_CountNonBlank := sum(group, if(pMain.orig_registration_number_5<>'',1,0));
	orig_veh_state_5_CountNonBlank 		:= sum(group, if(pMain.orig_veh_state_5<>'',1,0));
	orig_veh_location_5_CountNonBlank 	:= sum(group, if(pMain.orig_veh_location_5<>'',1,0));
	fingerprint_link_CountNonBlank 		:= sum(group, if(pMain.fingerprint_link<>'',1,0));
	fingerprint_date_CountNonBlank 		:= sum(group, if(pMain.fingerprint_date<>'',1,0));
	palmprint_link_CountNonBlank 		:= sum(group, if(pMain.palmprint_link<>'',1,0));
	palmprint_date_CountNonBlank 		:= sum(group, if(pMain.palmprint_date<>'',1,0));
	image_link_CountNonBlank 		:= sum(group, if(pMain.image_link<>'',1,0));
	image_date_CountNonBlank 		:= sum(group, if(pMain.image_date<>'',1,0));
	addr_dt_last_seen_CountNonBlank 	:= sum(group, if(pMain.addr_dt_last_seen<>'',1,0));
	prim_range_CountNonBlank 		:= sum(group, if(pMain.prim_range<>'',1,0));
	predir_CountNonBlank 			:= sum(group, if(pMain.predir<>'',1,0));
	prim_name_CountNonBlank 		:= sum(group, if(pMain.prim_name<>'',1,0));
	addr_suffix_CountNonBlank 		:= sum(group, if(pMain.addr_suffix<>'',1,0));
	postdir_CountNonBlank 			:= sum(group, if(pMain.postdir<>'',1,0));
	unit_desig_CountNonBlank 		:= sum(group, if(pMain.unit_desig<>'',1,0));
	sec_range_CountNonBlank 		:= sum(group, if(pMain.sec_range<>'',1,0));
	p_city_name_CountNonBlank 		:= sum(group, if(pMain.p_city_name<>'',1,0));
	v_city_name_CountNonBlank 		:= sum(group, if(pMain.v_city_name<>'',1,0));
	st_CountNonBlank 			:= sum(group, if(pMain.st<>'',1,0));
	zip5_CountNonBlank 			:= sum(group, if(pMain.zip5<>'',1,0));
	zip4_CountNonBlank 			:= sum(group, if(pMain.zip4<>'',1,0));
	cart_CountNonBlank 			:= sum(group, if(pMain.cart<>'',1,0));
	cr_sort_sz_CountNonBlank 		:= sum(group, if(pMain.cr_sort_sz<>'',1,0));
	lot_CountNonBlank 			:= sum(group, if(pMain.lot<>'',1,0));
	lot_order_CountNonBlank 		:= sum(group, if(pMain.lot_order<>'',1,0));
	dbpc_CountNonBlank 			:= sum(group, if(pMain.dbpc<>'',1,0));
	chk_digit_CountNonBlank 		:= sum(group, if(pMain.chk_digit<>'',1,0));
	rec_type_CountNonBlank 			:= sum(group, if(pMain.rec_type<>'',1,0));
	county_CountNonBlank 			:= sum(group, if(pMain.county<>'',1,0));
	geo_lat_CountNonBlank 			:= sum(group, if(pMain.geo_lat<>'',1,0));
	geo_long_CountNonBlank 			:= sum(group, if(pMain.geo_long<>'',1,0));
	msa_CountNonBlank 			:= sum(group, if(pMain.msa<>'',1,0));
	geo_blk_CountNonBlank 			:= sum(group, if(pMain.geo_blk<>'',1,0));
	geo_match_CountNonBlank 		:= sum(group, if(pMain.geo_match<>'',1,0));
	err_stat_CountNonBlank 			:= sum(group, if(pMain.err_stat<>'',1,0));
	clean_errors_CountNonZero 		:= sum(group, if(pMain.clean_errors<>0,1,0));
	rawaid_CountNonZero 			:= sum(group, if(pMain.rawaid<>0,1,0));
	curr_incar_flag_CountNonBlank 		:= sum(group, if(pMain.curr_incar_flag<>'',1,0));
	curr_parole_flag_CountNonBlank 		:= sum(group, if(pMain.curr_parole_flag<>'',1,0));
	curr_probation_flag_CountNonBlank 	:= sum(group, if(pMain.curr_probation_flag<>'',1,0));
  end;

rPopulationStats_File_Offenses :=
  record
    	CountGroup                              := count(group);
    	string2 state                           := pOffenses.Seisint_Primary_Key[3..4];
    	Seisint_Primary_Key_CountNonBlank       := sum(group,if(pOffenses.Seisint_Primary_Key<>'',1,0));
    	conviction_jurisdiction_CountNonBlank   := sum(group,if(pOffenses.conviction_jurisdiction<>'',1,0));
    	conviction_date_CountNonBlank           := sum(group,if(pOffenses.conviction_date<>'',1,0));
    	court_CountNonBlank                     := sum(group,if(pOffenses.court<>'',1,0));
    	court_case_number_CountNonBlank         := sum(group,if(pOffenses.court_case_number<>'',1,0));
    	offense_date_CountNonBlank              := sum(group,if(pOffenses.offense_date<>'',1,0));
    	offense_code_or_statute_CountNonBlank   := sum(group,if(pOffenses.offense_code_or_statute<>'',1,0));
    	offense_description_CountNonBlank       := sum(group,if(pOffenses.offense_description<>'',1,0));
    	offense_description_2_CountNonBlank     := sum(group,if(pOffenses.offense_description_2<>'',1,0));
    	offense_category_CountNonBlank          := sum(group,if(pOffenses.offense_category<>'',1,0));
    	victim_minor_CountNonBlank              := sum(group,if(pOffenses.victim_minor<>'',1,0));
    	victim_age_CountNonBlank                := sum(group,if(pOffenses.victim_age<>'',1,0));
    	victim_gender_CountNonBlank             := sum(group,if(pOffenses.victim_gender<>'',1,0));
    	victim_relationship_CountNonBlank       := sum(group,if(pOffenses.victim_relationship<>'',1,0));
    	sentence_description_CountNonBlank      := sum(group,if(pOffenses.sentence_description<>'',1,0));
    	sentence_description_2_CountNonBlank    := sum(group,if(pOffenses.sentence_description_2<>'',1,0));
	arrest_date_CountNonBlank      		:= sum(group,if(pOffenses.arrest_date<>'',1,0));
    	arrest_warrant_CountNonBlank    	:= sum(group,if(pOffenses.arrest_warrant<>'',1,0));
  end;


// Create Main table statistics
dPopulationStats_SexOffender_file_Main := table(pMain
							,rPopulationStats_SexOffender_file_Main
							,orig_state_code
							,source_file
							,few);

				 
// Create Offenses table statistics
dPopulationStats_File_Offenses 		:= table(pOffenses
							,rPopulationStats_File_Offenses
							,Seisint_Primary_Key[3..4]
							,few);

output(sort(dPopulationStats_SexOffender_file_Main, orig_state_code), all, named('Main_File_Stats'));
output(sort(dPopulationStats_File_Offenses, state), all, named('Offense_File_Stats'));



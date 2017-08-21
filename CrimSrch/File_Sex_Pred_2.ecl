import ut;

/*
ds_layout_new := RECORD
  string8 dt_first_reported;
  string8 dt_last_reported;
	 string8 src_upload_date; //New
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
   string40 offense_location_1; //New
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
	 string10 offense_level_1; //New
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
	 string8 disposition_dt_1; //New
  string8 arrest_date_2;
  string250 arrest_warrant_2;
	 string40 offense_location_2; //New
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string180 offense_description_2;
  string180 offense_description_2_2;
	 string10 offense_level_2; //New
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
	 string8 disposition_dt_2; //New
  string8 arrest_date_3;
  string250 arrest_warrant_3;
	 string40 offense_location_3; //New
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string180 offense_description_3;
  string180 offense_description_3_2;
	 string10 offense_level_3; //New
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
	 string8 disposition_dt_3 ; //New
  string8 arrest_date_4;
  string250 arrest_warrant_4;
	 string40  offense_location_4; //New
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string180 offense_description_4;
  string180 offense_description_4_2;
	 string8 disposition_dt_4; //New
	 string10 offense_level_4; //New
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string30 victim_relationship_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
	 string40 offense_location_5; //New
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string180 offense_description_5;
  string180 offense_description_5_2;
	 string8 disposition_dt_5; //New
	 string10 offense_level_5; //New
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
  string2 newline;
 END;
*/

ds_layout_new := record
    string8     dt_first_reported;
    string8     dt_last_reported;
	string8		src_upload_date;				//new field added for CROSS
    string2     orig_state;
	string30	orig_firstname;					//new field added
	string30	orig_middlename;				//new field added
	string30	orig_lastname;					//new field added
	string10	orig_suffix;					//new field added
    string16    seisint_primary_key;
    string2     vendor_code;
	string320	intnet_email_address_1;			//new field added
	string320	intnet_email_address_2;			//new field added
	string320	intnet_email_address_3;			//new field added
	string320	intnet_email_address_4;			//new field added
	string320	intnet_email_address_5;			//new field added
	string320	intnet_instant_message_addr_1;	//new field added
	string320	intnet_instant_message_addr_2;	//new field added
	string320	intnet_instant_message_addr_3;	//new field added
	string320	intnet_instant_message_addr_4;	//new field added
	string320	intnet_instant_message_addr_5;	//new field added
	string320	intnet_user_name_1;				//new field added
	string255	intnet_user_name_1_url;			//new field added
	string320	intnet_user_name_2;				//new field added
	string255	intnet_user_name_2_url;			//new field added
	string320	intnet_user_name_3;				//new field added
	string255	intnet_user_name_3_url;			//new field added
	string320	intnet_user_name_4;				//new field added
	string255	intnet_user_name_4_url;			//new field added
	string320	intnet_user_name_5;				//new field added
	string255	intnet_user_name_5_url;			//new field added
    string20   	source_file;
    string50   	name_orig;
    string30   	lname;
    string30   	fname;
    string20   	mname;
    string20   	name_suffix;
    string1    	name_type;
    string50   	offender_status;
    string40   	offender_category;
    string10   	risk_level_code;
    string50   	risk_description;
    string50   	police_agency;
    string35   	police_agency_contact_name;
    string55   	police_agency_address_1;
    string35   	police_agency_address_2;
    string10   	police_agency_phone;
    string25   	registration_type;
    string8    	reg_date_1;
    string28   	reg_date_1_type;
    string8    	reg_date_2;
    string28   	reg_date_2_type;
    string8    	reg_date_3;
    string28   	reg_date_3_type;
    string125  	registration_address_1;
    string45   	registration_address_2;
    string35   	registration_address_3;
    string35   	registration_address_4;
    string35   	registration_address_5;
    string35   	registration_county;
	string10	registration_home_phone;		//new field added
	string10	registration_cell_phone;		//new field added
	string125	other_registration_address_1;	//new field added
	string45	other_registration_address_2;	//new field added
	string35	other_registration_address_3;	//new field added
	string35	other_registration_address_4;	//new field added
	string35	other_registration_address_5;	//new field added
	string35	other_registration_county;		//new field added
	string10	other_registration_phone;		//new field added
	string125	temp_lodge_address_1;			//new field added
	string45	temp_lodge_address_2;			//new field added
	string35	temp_lodge_address_3;			//new field added
	string35	temp_lodge_address_4;			//new field added
	string35	temp_lodge_address_5;			//new field added
	string35	temp_lodge_county;				//new field added
	string10	temp_lodge_phone;				//new field added
    string55   	employer;
    string55   	employer_address_1;
    string35   	employer_address_2;
    string35   	employer_address_3;
    string35   	employer_address_4;
    string35   	employer_address_5;
    string35   	employer_county;
	string10	employer_phone;					//new field added
	string140	employer_comments;				//new field added
	string75	professional_licenses_1;		//new field added
	string75	professional_licenses_2;		//new field added
	string75	professional_licenses_3;		//new field added
	string75	professional_licenses_4;		//new field added
	string75	professional_licenses_5;		//new field added
	string55   	school;
    string55   	school_address_1;
    string35   	school_address_2;
    string35   	school_address_3;
    string35   	school_address_4;
    string35   	school_address_5;
    string35   	school_county;
	string10	school_phone;					//new field added
	string140	school_comments;				//new field added
    string30   	offender_id;
    string30   	doc_number;
    string30   	sor_number;
    string30   	st_id_number;
    string30   	fbi_number;
    string30   	ncic_number;
    string9    	ssn;
    string8    	dob;
    string8    	dob_aka;
    string3    	age;
	string250	dna;							//new field added
    string30   	race;
    string30   	ethnicity;
    string10   	sex;
    string40   	hair_color;
    string40   	eye_color;
    string3    	height;
    string3    	weight;
    string20   	skin_tone;
    string30   	build_type;
    string200  	scars_marks_tattoos;
    string6    	shoe_size;
    string1    	corrective_lense_flag;
	string8		arrest_date_1;					//new field added
	string250	arrest_warrant_1;				//new field added
	string40    offense_location_1;				//new field added for CROSS
    string80   	conviction_jurisdiction_1;
    string8    	conviction_date_1;
    string30   	court_1;
    string25   	court_case_number_1;
    string8    	offense_date_1;
    string20   	offense_code_or_statute_1;
    string320 	offense_description_1;
    string180 	offense_description_1_2;
	string10 	offense_level_1;				//new field added for CROSS
  string1    	victim_minor_1;
  string3    	victim_age_1;
  string10   	victim_gender_1;
  string30   	victim_relationship_1;
  string180 	sentence_description_1;
  string180 	sentence_description_1_2;
	string8		disposition_dt_1;				//new field added for CROSS
  string8		arrest_date_2;					//new field added
	string250	arrest_warrant_2;				//new field added
	string40    offense_location_2;				//new field added for CROSS
	string80   	conviction_jurisdiction_2;
  string8    	conviction_date_2;
  string30   	court_2;
  string25   	court_case_number_2;
  string8    	offense_date_2;
  string20   	offense_code_or_statute_2;
  string180 	offense_description_2;
  string180 	offense_description_2_2;
	string10 	offense_level_2;				//new field added for CROSS
  string1    	victim_minor_2;
  string3    	victim_age_2;
  string10   	victim_gender_2;
  string30   	victim_relationship_2;
  string180 	sentence_description_2;
  string180 	sentence_description_2_2;
	string8		disposition_dt_2;				//new field added for CROSS
	string8		arrest_date_3;					//new field added
	string250	arrest_warrant_3;				//new field added
	string40    offense_location_3;				//new field added for CROSS
  string80   	conviction_jurisdiction_3;
  string8    	conviction_date_3;
  string30   	court_3;
  string25   	court_case_number_3;
  string8    	offense_date_3;
  string20   	offense_code_or_statute_3;
  string180  	offense_description_3;
  string180 	offense_description_3_2;
	string10 	offense_level_3;				//new field added for CROSS
  string1    	victim_minor_3;
  string3    	victim_age_3;
  string10   	victim_gender_3;
  string30   	victim_relationship_3;
  string180 	sentence_description_3;
  string180 	sentence_description_3_2;
	string8		disposition_dt_3 ;				//new field added for CROSS
  string8		arrest_date_4;					//new field added
	string250	arrest_warrant_4;				//new field added
	string40    offense_location_4;				//new field added for CROSS
	string80   	conviction_jurisdiction_4;
  string8    	conviction_date_4;
  string30  court_4;
  string25  court_case_number_4;
  string8   offense_date_4;
  string20  offense_code_or_statute_4;
  string180 offense_description_4;
  string180 offense_description_4_2;
	string8		disposition_dt_4;				//new field added for CROSS
	string10 	offense_level_4;				//new field added for CROSS
  string1   victim_minor_4;
  string3   victim_age_4;
  string10  victim_gender_4;
  string30  victim_relationship_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
	string8		arrest_date_5;					//new field added
	string250	arrest_warrant_5;				//new field added
	string40  offense_location_5;				//new field added for CROSS
  string80  conviction_jurisdiction_5;
  string8   conviction_date_5;
  string30  court_5;
  string25  court_case_number_5;
  string8   offense_date_5;
  string20  offense_code_or_statute_5;
  string180 offense_description_5;
  string180 offense_description_5_2;
	string8		disposition_dt_5;				//new field added for CROSS
	string10 	offense_level_5;				//new field added for CROSS
  string1   victim_minor_5;
  string3   victim_age_5;
  string10  victim_gender_5;
  string30  victim_relationship_5;
  string180 sentence_description_5;
  string180 sentence_description_5_2;
  string140 addl_comments_1;
  string140 addl_comments_2;
  string30  orig_dl_number;
  string2   orig_dl_state;
	string150	orig_dl_link;					//new field added
	string8		orig_dl_date;					//new field added
	string1		passport_type;					//new field added
	string10	passport_code;					//new field added
	string25	passport_number;				//new field added
	string50	passport_first_name;			//new field added
	string100	passport_given_name;			//new field added
	string30	passport_nationality;			//new field added
	string8		passport_dob;					//new field added
	string55	passport_place_of_birth;		//new field added
	string10	passport_sex;					//new field added
	string8		passport_issue_date;			//new field added
	string55	passport_authority;				//new field added
	string8		passport_expiration_date;		//new field added
	string50	passport_endorsement;			//new field added
	string150	passport_link;					//new field added
	string8		passport_date;					//new field added
  string4   orig_veh_year_1;
  string40  orig_veh_color_1;
  string40  orig_veh_make_model_1;
  string40  orig_veh_plate_1;
  string17	orig_registration_number_1;		//new field added
	string2   orig_veh_state_1;
  string50	orig_veh_location_1;			//new field added
	string4   orig_veh_year_2;
  string40  orig_veh_color_2;
  string40  orig_veh_make_model_2;
  string40  orig_veh_plate_2;
  string17	orig_registration_number_2;		//new field added
	string2   orig_veh_state_2;
	string50	orig_veh_location_2;			//new field added
	string4		orig_veh_year_3;				//new field added
	string40	orig_veh_color_3;				//new field added
	string40	orig_veh_make_model_3;			//new field added
	string40	orig_veh_plate_3;				//new field added
	string17	orig_registration_number_3;		//new field added
	string2		orig_veh_state_3;				//new field added
	string50	orig_veh_location_3;			//new field added
	string4		orig_veh_year_4;				//new field added
	string40	orig_veh_color_4;				//new field added
	string40	orig_veh_make_model_4;			//new field added
	string40	orig_veh_plate_4;				//new field added
	string17	orig_registration_number_4;		//new field added
	string2		orig_veh_state_4;				//new field added
	string50	orig_veh_location_4;			//new field added
	string4		orig_veh_year_5;				//new field added
	string40	orig_veh_color_5;				//new field added
	string40	orig_veh_make_model_5;			//new field added
	string40	orig_veh_plate_5;				//new field added
	string17	orig_registration_number_5;		//new field added
	string2		orig_veh_state_5;				//new field added
	string50	orig_veh_location_5;			//new field added
	string150	fingerprint_link;				//new field added
	string8		fingerprint_date;				//new field added
	string150	palmprint_link;					//new field added
	string8		palmprint_date;					//new field added
  string150 	image_link;
  string8    	image_date;
	string2     newline;
end;
inputFile	:= dataset(ut.foreign_prod+'~thor_data400::in::sex_pred_2_' + CrimSrch.Version.SexPred,
							ds_layout_new,flat,unsorted
							);

CrimSrch.Layout_Sex_Pred_2 oldFormat(inputFile l):= transform
	self.state_of_origin 		:= l.orig_state;
	self.orig_ssn 				:= l.ssn;
	self.date_of_birth 			:= l.dob;
	self.name_last				:= l.lname;
	self.name_first				:= l.fname;
	self.name_middle			:= l.mname;
	self.date_of_birth_aka		:= l.dob_aka;
	self.vicition_relationship_1:= l.victim_relationship_1;
	self.vicition_relationship_2:= l.victim_relationship_2;
	self.vicition_relationship_3:= l.victim_relationship_3;
	self.vicition_relationship_4:= l.victim_relationship_4;
	self.vicition_relationship_5:= l.victim_relationship_5;
	self.crlf					:= l.newline;
	self := l;
end;

export File_Sex_Pred_2  := project(inputFile, oldFormat(left));

/*export File_Sex_Pred_2
 := dataset('~thor_data400::in::sex_pred_2_' + CrimSrch.Version.SexPred,
			CrimSrch.Layout_Sex_Pred_2,flat,unsorted
		   );*/
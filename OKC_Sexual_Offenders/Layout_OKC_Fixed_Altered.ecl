export Layout_OKC_Fixed_Altered := record
	string30  	source_file;
	string10	date_added;						//new field added 
    string10  	scrape_date;
    string2  	orig_state;
    string  	name_orig;	//*****************Length Altered****
    string  	name_aka;	//*****************Length Altered****
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
    string50  	offender_status;
    string40  	offender_category;
    string10  	risk_level_code;
    string50  	risk_description;
    string50  	police_agency;
    string50  	police_agency_contact_name;
    string55  	police_agency_address_1;
    string35  	police_agency_address_2;
    string10  	police_agency_phone;
    string35  	registration_type;
    string8 	reg_date_1;
    string28  	reg_date_1_type;
    string8  	reg_date_2;
    string28  	reg_date_2_type;
    string8  	reg_date_3;
    string28  	reg_date_3_type;
    string125  	registration_address_1;
    string45  	registration_address_2;
    string35  	registration_address_3;
    string35  	registration_address_4;
    string35  	registration_address_5;
    string35  	registration_county;
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
	string55  	employer;
    string55  	employer_address_1;
    string35  	employer_address_2;
    string35  	employer_address_3;
    string35  	employer_address_4;
    string35  	employer_address_5;
    string35  	employer_county;
	string10	employer_phone;					//new field added
	string140	employer_comments;				//new field added
	string75	professional_licenses_1;		//new field added
	string75	professional_licenses_2;		//new field added
	string75	professional_licenses_3;		//new field added
	string75	professional_licenses_4;		//new field added
	string75	professional_licenses_5;		//new field added
    string55  	school;
    string55  	school_address_1;
    string35  	school_address_2;
    string35  	school_address_3;
    string35  	school_address_4;
    string35  	school_address_5;
    string35  	school_county;
	string10	school_phone;					//new field added
	string140	school_comments;				//new field added
    string30  	offender_id;
    string30  	doc_number;
    string30  	sor_number;
    string30  	st_id_number;
    string30  	fbi_number;
    string30  	ncic_number;
    string9  	orig_ssn;
    string8  	date_of_birth;
    string  	date_of_birth_aka;//***********Length Altered****
    string3  	age;
    string250	dna;							//new field added
	string30  	race;
    string30  	ethnicity;
    string10  	sex;
    string40  	hair_color;
    string40  	eye_color;
    string3  	height;
    string3 	weight;
    string20  	skin_tone;
    string30  	build_type;
    string200  	scars_marks_tattoos;
    string6  	shoe_size;
    string1  	corrective_lense_flag;
    string8		arrest_date_1;					//new field added
	string250	arrest_warrant_1;				//new field added
	string80  	conviction_jurisdiction_1;
    string8  	conviction_date_1;
    string30  	court_1;
    string25  	court_case_number_1;
    string8  	offense_date_1;
    string20  	offense_code_or_statute_1;
    string320  	offense_description_1;
    string180  	offense_description_1_2;
    string1  	victim_minor_1;
    string3  	victim_age_1;
    string10  	victim_gender_1;
    string30  	victim_relationship_1;
    string180  	sentence_description_1;
    string180  	sentence_description_1_2;
	string8		arrest_date_2;					//new field added
	string250	arrest_warrant_2;				//new field added
    string80  	conviction_jurisdiction_2;
    string8  	conviction_date_2;
    string30  	court_2;
    string25  	court_case_number_2;
    string8  	offense_date_2;
    string20  	offense_code_or_statute_2;
    string320  	offense_description_2;
    string180  	offense_description_2_2;
    string1  	victim_minor_2;
    string3  	victim_age_2;
    string10  	victim_gender_2;
    string30  	victim_relationship_2;
    string180  	sentence_description_2;
    string180 	sentence_description_2_2;
    string8		arrest_date_3;					//new field added
	string250	arrest_warrant_3;				//new field added
	string80  	conviction_jurisdiction_3;
    string8  	conviction_date_3;
    string30  	court_3;
    string25  	court_case_number_3;
    string8  	offense_date_3;
    string20  	offense_code_or_statute_3;
    string320  	offense_description_3;
    string180  	offense_description_3_2;
    string1  	victim_minor_3;
    string3  	victim_age_3;
    string10  	victim_gender_3;
    string30  	victim_relationship_3;
    string180  	sentence_description_3;
    string180  	sentence_description_3_2;
    string8		arrest_date_4;					//new field added
	string250	arrest_warrant_4;				//new field added
	string80  	conviction_jurisdiction_4;
    string8  	conviction_date_4;
    string30  	court_4;
    string25  	court_case_number_4;
    string8  	offense_date_4;
    string20  	offense_code_or_statute_4;
    string320  	offense_description_4;
    string180  	offense_description_4_2;
    string1  	victim_minor_4;
    string3  	victim_age_4;
    string10  	victim_gender_4;
    string3  	victim_relationship_4;
    string180  	sentence_description_4;
    string180  	sentence_description_4_2;
    string8		arrest_date_5;					//new field added
	string250	arrest_warrant_5;				//new field added
	string80  	conviction_jurisdiction_5;
    string8  	conviction_date_5;
    string30  	court_5;
    string25  	court_case_number_5;
    string8  	offense_date_5;
    string20  	offense_code_or_statute_5;
    string320  	offense_description_5;
    string180  	offense_description_5_2;
    string1  	victim_minor_5;
    string3  	victim_age_5;
    string10  	victim_gender_5;
    string30  	victim_relationship_5;
    string180  	sentence_description_5;
    string180  	sentence_description_5_2;
    string140  	addl_comments_1;
    string140  	addl_comments_2;
    string30  	orig_dl_number;
    string2 	orig_dl_state;
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
	string4 	orig_veh_year_1;
    string40  	orig_veh_color_1;
    string40  	orig_veh_make_model_1;
    string40  	orig_veh_plate_1;
    string17	orig_registration_number_1;		//new field added
	string2  	orig_veh_state_1;
    string50	orig_veh_location_1;			//new field added
	string4  	orig_veh_year_2;
    string40  	orig_veh_color_2;
    string40  	orig_veh_make_model_2;
    string40  	orig_veh_plate_2;
    string17	orig_registration_number_2;		//new field added
	string2  	orig_veh_state_2;
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
	string150  	image_link;
	string8  	image_date;
end;
import Data_Services;
export Constants := module
	
	export Cluster		:= Data_Services.Data_location.SexOffender + 'thor_data400';
	export ak_keyname  := Cluster + '::key::sexoffender::autokey::';
	export ak_logical(string filedate='')	:= Cluster+'::key::sexoffender::'+filedate+'::autokey::';
	export ak_dataset	:= SexOffender.File_AutoKey_Main;
	export ak_skipSet	:= ['P','B'];  //skip personal phones and all business data
						//P in this set to skip personal phones
						//Q in this set to skip business phones
						//S in this set to skip SSN
						//F in this set to skip FEIN
						//C in this set to skip ALL personal (Contact) data
						//B in this set to skip ALL Business data
	export ak_typeStr	:= '\'AK\'';
	
	export stem			:= Cluster;
	export srcType		:= 'sexoffender';
	export qual			:= 'test';
	
	// These states have explicit text in "offense_description_2"
	export explicitOffenseStates := ['ND'];

	EXPORT OffenseCategory := MODULE
		export unsigned8 ABDUCTION := 2;
		export unsigned8 BURGLARY := 4;
		export unsigned8 COMPUTER_CRIME := 8;
		export unsigned8 CONTRIBUTING := 16777216;
		export unsigned8 CORRUPTION := 16;
		export unsigned8 ENDANGER_WELFARE_OF_MINORS := 32;
		export unsigned8 EXPLOITATION := 64;
		export unsigned8 EXPOSURE := 128;
		export unsigned8 FAILURE_TO_COMPLY := 256;
		export unsigned8 FALSE_IMPRISONMENT:= 512;
		export unsigned8 IMPORTUNING:= 1024;
		export unsigned8 INCEST:= 2048;
		export unsigned8 MURDER := 4096;
		export unsigned8 OTHER:= 8192;
		export unsigned8 PORNOGRAPHY:= 16384;
		export unsigned8 PROSTITUTION := 32768;
		export unsigned8 RAPE := 65536;
		export unsigned8 REGISTRATION:= 131072;
		export unsigned8 RESTRAINT:= 262144;
		export unsigned8 ROBBERY:= 524288;
		export unsigned8 SEXUAL_ASSAULT:= 1048576;
		export unsigned8 SEXUAL_ASSAULT_MINOR:= 2097152;
		export unsigned8 SOLICITATION:= 4194304;
		export unsigned8 UNLAWFUL_COMMUNICATION_MINOR:= 8388608;
	END;

	//DF-21836 Blank out following fields in thor_data400::key::sexoffender::fcra::spkpublic_qa
	export fields_to_clear_spkpublic := 'addl_comments_1,addl_comments_2,age,build_type,corrective_lense_flag,dna,dob_aka,doc_number,employer,employer_address_1,' +
										 'employer_address_2,employer_address_3,employer_address_4,employer_address_5,employer_comments,employer_county,' +
										 'employer_phone,ethnicity,fbi_number,fingerprint_date,fingerprint_link,image_date,image_link,intnet_email_address_1,' +
										 'intnet_email_address_2,intnet_email_address_3,intnet_email_address_4,intnet_email_address_5,intnet_instant_message_addr_1,' +
										 'intnet_instant_message_addr_2,intnet_instant_message_addr_3,intnet_instant_message_addr_4,intnet_instant_message_addr_5,intnet_user_name_1,' +
										 'intnet_user_name_1_url,intnet_user_name_2,intnet_user_name_2_url,intnet_user_name_3,intnet_user_name_3_url,' +
										 'intnet_user_name_4,intnet_user_name_4_url,intnet_user_name_5,intnet_user_name_5_url,ncic_number,' +
										 'offender_category,offender_status,orig_dl_date,orig_dl_link,orig_dl_number,' +
										 'orig_dl_state,orig_registration_number_1,orig_registration_number_2,orig_registration_number_3,orig_registration_number_4,' +
										 'orig_registration_number_5,orig_state,orig_state_code,orig_veh_color_1,orig_veh_color_2,' +
										 'orig_veh_color_3,orig_veh_color_4,orig_veh_color_5,orig_veh_location_1,orig_veh_location_2,' +
										 'orig_veh_location_3,orig_veh_location_4,orig_veh_location_5,orig_veh_make_model_1,orig_veh_make_model_2,' +
										 'orig_veh_make_model_3,orig_veh_make_model_4,orig_veh_make_model_5,orig_veh_plate_1,orig_veh_plate_2,' +
										 'orig_veh_plate_3,orig_veh_plate_4,orig_veh_plate_5,orig_veh_state_1,orig_veh_state_2,' +
										 'orig_veh_state_3,orig_veh_state_4,orig_veh_state_5,orig_veh_year_1,orig_veh_year_2,' +
										 'orig_veh_year_3,orig_veh_year_4,orig_veh_year_5,other_registration_address_1,other_registration_address_2,' +
										 'other_registration_address_3,other_registration_address_4,other_registration_address_5,other_registration_county,other_registration_phone,' +
										 'palmprint_date,palmprint_link,passport_authority,passport_code,passport_date,' +
										 'passport_dob,passport_endorsement,passport_expiration_date,passport_first_name,passport_given_name,' +
										 'passport_issue_date,passport_link,passport_nationality,passport_number,passport_place_of_birth,' +
										 'passport_sex,passport_type,police_agency,police_agency_address_1,police_agency_address_2,' +
										 'police_agency_contact_name,police_agency_phone,professional_licenses_1,professional_licenses_2,professional_licenses_3,' +
										 'professional_licenses_4,professional_licenses_5,reg_date_1_type,reg_date_2,reg_date_2_type,' +
										 'reg_date_3,reg_date_3_type,registration_address_3,registration_address_4,registration_address_5,' +
										 'registration_cell_phone,registration_home_phone,registration_type,risk_description,risk_level_code,' +
										 'scars_marks_tattoos,school,school_address_1,school_address_2,school_address_3,' +
										 'school_address_4,school_address_5,school_comments,school_county,school_phone,' +
										 'shoe_size,skin_tone,ssn,st_id_number,temp_lodge_address_1,' +
										 'temp_lodge_address_2,temp_lodge_address_3,temp_lodge_address_4,temp_lodge_address_5,temp_lodge_county,temp_lodge_phone';

	//DF-21836 Blank out following fields in thor_data400::key::sexoffender::fcra::offenses_public_qa
	export fields_to_clear_offenses_public := 'arrest_date,arrest_warrant,conviction_date,conviction_jurisdiction,court,court_case_number,offense_category,' +
										 'offense_code_or_statute,offense_date,offense_description,offense_description_2,sentence_description,sentence_description_2,' +
										 'victim_age,victim_gender,victim_minor,victim_relationship';
	
end;
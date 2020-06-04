
EXPORT Regulatory := module

		// copied from sex_offender.file_main - 10-10-19
		export SOff_Offndr_layout :=  record
			  unsigned8		did := 0;
			  unsigned1		score := 0;
			  string9			ssn_appended := '';
			  unsigned1		ssn_perms := 0;
			  string8			dt_first_reported := '';
			  string8 		dt_last_reported := '';
			  string30 		orig_state := '';
			  string2    	orig_state_code := '';
			  string60 		seisint_primary_key := '';
			  string2 		vendor_code := '';
			  string20 		source_file := '';
			  string2			record_type := '';
			  string50 		name_orig := '';
			  string30 		lname := '';
			  string30 		fname := '';
			  string20 		mname := '';
			  string20 		name_suffix := '';
			  string1 		name_type := '';
			  unsigned8		nid:= 0;
			  string1			ntype:= '';
			  unsigned2		nindicator:= 0;
			  string320		intnet_email_address_1 := '';		//new field added
			  string320		intnet_email_address_2 := '';		//new field added
			  string320		intnet_email_address_3 := '';		//new field added
			  string320		intnet_email_address_4 := '';		//new field added
			  string320		intnet_email_address_5 := '';		//new field added
			  string320		intnet_instant_message_addr_1 := '';//new field added
			  string320		intnet_instant_message_addr_2 := '';//new field added
			  string320		intnet_instant_message_addr_3 := '';//new field added
			  string320		intnet_instant_message_addr_4 := '';//new field added
			  string320		intnet_instant_message_addr_5 := '';//new field added
			  string320		intnet_user_name_1 := '';			//new field added
			  string255		intnet_user_name_1_url := '';		//new field added
			  string320		intnet_user_name_2 := '';			//new field added
			  string255		intnet_user_name_2_url := '';		//new field added
			  string320		intnet_user_name_3 := '';			//new field added
			  string255		intnet_user_name_3_url := '';		//new field added
			  string320		intnet_user_name_4 := '';			//new field added
			  string255		intnet_user_name_4_url := '';		//new field added
			  string320		intnet_user_name_5 := '';			//new field added
			  string255		intnet_user_name_5_url := '';		//new field added
			  string50 		offender_status := '';
			  string40 		offender_category := '';
			  string10 		risk_level_code := '';
			  string50 		risk_description := '';
			  string50 		police_agency := '';
				string35 		police_agency_contact_name := '';
				string55 		police_agency_address_1 := '';
				string35 		police_agency_address_2 := '';
				string10 		police_agency_phone := '';
				string25 		registration_type := '';
				string8 		reg_date_1 := '';
				string28 		reg_date_1_type := '';
				string8 		reg_date_2 := '';
				string28 		reg_date_2_type := '';
				string8 		reg_date_3 := '';
				string28 		reg_date_3_type := '';
				string125		registration_address_1 := '';
				string45 		registration_address_2 := '';
				string35 		registration_address_3 := '';
				string35 		registration_address_4 := '';
				string35 		registration_address_5 := '';
				string35 		registration_county := '';
				string10		registration_home_phone := '';		//new field added
				string10		registration_cell_phone := '';		//new field added
				string125		other_registration_address_1 := '';	//new field added
				string45		other_registration_address_2 := '';	//new field added
				string35		other_registration_address_3 := '';	//new field added
				string35		other_registration_address_4 := '';	//new field added
				string35		other_registration_address_5 := '';	//new field added
				string35		other_registration_county := '';	//new field added
				string10		other_registration_phone := '';		//new field added
				string125		temp_lodge_address_1 := '';			//new field added
				string45		temp_lodge_address_2 := '';			//new field added
				string35		temp_lodge_address_3 := '';			//new field added
				string35		temp_lodge_address_4 := '';			//new field added
				string35		temp_lodge_address_5 := '';			//new field added
				string35		temp_lodge_county := '';			//new field added
				string10		temp_lodge_phone:= '';				//new field added
				string55 		employer := '';
				string55 		employer_address_1 := '';
				string35 		employer_address_2 := '';
				string35 		employer_address_3 := '';
				string35 		employer_address_4 := '';
				string35 		employer_address_5 := '';
				string35 		employer_county := '';
				string10		employer_phone := '';				//new field added
				string140		employer_comments := '';			//new field added
				string75		professional_licenses_1 := '';		//new field added
				string75		professional_licenses_2 := '';		//new field added
				string75		professional_licenses_3 := '';		//new field added
				string75		professional_licenses_4 := '';		//new field added
				string75		professional_licenses_5 := '';		//new field added
				string55 		school := '';
				string55 		school_address_1 := '';
				string35 		school_address_2 := '';
				string35 		school_address_3 := '';
				string35 		school_address_4 := '';
				string35 		school_address_5 := '';
				string35 		school_county := '';
				string10		school_phone := '';					//new field added
				string140		school_comments := '';				//new field added
				string30 		offender_id := '';
				string30 		doc_number := '';
				string40 		sor_number := '';
				string30 		st_id_number := '';
				string30 		fbi_number := '';
				string30 		ncic_number := '';
				string9 		ssn := '';
				string8 		dob := '';
				string8 		dob_aka := '';
				string3 		age := '';
				string250		dna := '';							//new field added
				string30 		race := '';
				string30 		ethnicity := '';
				string10 		sex := '';
				string40 		hair_color := '';
				string40 		eye_color := '';
				string3 		height := '';
				string3 		weight := '';
				string20 		skin_tone := '';
				string30 		build_type := '';
				string200 	scars_marks_tattoos := '';
				string6 		shoe_size := '';
				string1 		corrective_lense_flag := '';
				string140 	addl_comments_1 := '';
				string140 	addl_comments_2 := '';
				string30 		orig_dl_number := '';
				string2 		orig_dl_state := '';
				string150		orig_dl_link := '';					//new field added
				string8			orig_dl_date := '';					//new field added
				string1			passport_type := '';				//new field added
				string10		passport_code := '';				//new field added
				string25		passport_number := '';				//new field added
				string50		passport_first_name := '';			//new field added
				string100		passport_given_name := '';			//new field added
				string30		passport_nationality := '';			//new field added
				string8			passport_dob := '';					//new field added
				string55		passport_place_of_birth := '';		//new field added
				string10		passport_sex := '';					//new field added
				string8			passport_issue_date := '';			//new field added
				string55		passport_authority := '';			//new field added
				string8			passport_expiration_date := '';		//new field added
				string50		passport_endorsement := '';			//new field added
				string150		passport_link := '';				//new field added
				string8			passport_date := '';				//new field added
				string4 		orig_veh_year_1 := '';
				string40 		orig_veh_color_1 := '';
				string40 		orig_veh_make_model_1 := '';
				string40 		orig_veh_plate_1 := '';
				string17		orig_registration_number_1 := '';	//new field added
				string2 		orig_veh_state_1 := '';
				string50		orig_veh_location_1 := '';			//new field added
				string4 		orig_veh_year_2 := '';
				string40 		orig_veh_color_2 := '';
				string40 		orig_veh_make_model_2 := '';
				string40 		orig_veh_plate_2 := '';
				string17		orig_registration_number_2 := '';	//new field added
				string2 		orig_veh_state_2 := '';
				string50		orig_veh_location_2 := '';			//new field added
				string4			orig_veh_year_3 := '';				//new field added
				string40		orig_veh_color_3 := '';				//new field added
				string40		orig_veh_make_model_3 := '';		//new field added
				string40		orig_veh_plate_3 := '';				//new field added
				string17		orig_registration_number_3 := '';	//new field added
				string2			orig_veh_state_3 := '';				//new field added
				string50		orig_veh_location_3 := '';			//new field added
				string4			orig_veh_year_4 := '';				//new field added
				string40		orig_veh_color_4 := '';				//new field added
				string40		orig_veh_make_model_4 := '';		//new field added
				string40		orig_veh_plate_4 := '';				//new field added
				string17		orig_registration_number_4 := '';	//new field added
				string2			orig_veh_state_4 := '';				//new field added
				string50		orig_veh_location_4 := '';			//new field added
				string4			orig_veh_year_5 := '';				//new field added
				string40		orig_veh_color_5 := '';				//new field added
				string40		orig_veh_make_model_5 := '';		//new field added
				string40		orig_veh_plate_5 := '';				//new field added
				string17		orig_registration_number_5 := '';	//new field added
				string2			orig_veh_state_5 := '';				//new field added
				string50		orig_veh_location_5 := '';			//new field added
				string150		fingerprint_link := '';				//new field added
				string8			fingerprint_date := '';				//new field added
				string150		palmprint_link := '';				//new field added
				string8			palmprint_date := '';				//new field added
				string150 	image_link := '';
				string8 		image_date := '';
				string6 		addr_dt_last_seen := '';
				// Address.Layout_Address_Clean_Components;  // copied 10-10-19
						qstring10 	prim_range := '';
						string2   	predir := '';
						qstring28 	prim_name := '';
						qstring4  	addr_suffix := '';
						string2   	postdir := '';
						qstring10 	unit_desig := '';
						qstring8  	sec_range := '';
						qstring25 	p_city_name := '';
						qstring25 	v_city_name := '';
						string2   	st := '';
						qstring5  	zip5 := '';
						qstring4  	zip4 := '';
						qstring4  	cart := '';
						string1   	cr_sort_sz := '';
						qstring4  	lot := '';
						string1   	lot_order := '';
						string2   	dbpc := '';
						string1   	chk_digit := '';
						string2   	rec_type := '';
						qstring5  	county := '';
						qstring10 	geo_lat := '';
						qstring11 	geo_long := '';
						qstring4  	msa := '';
						qstring7  	geo_blk := '';
						string1   	geo_match := '';
						qstring4  	err_stat := '';
						unsigned1 	clean_errors:= 0;			 // flag to indicate clean error type
				unsigned8 	rawaid:=0;
				string1     curr_incar_flag := '';
				string1     curr_parole_flag := '';
				string1     curr_probation_flag := '';
				//Address.layout_address_clean_return;
				string1			fcra_conviction_flag := '';
				string1			fcra_traffic_flag := '';
				string8			fcra_date := '';
				string1			fcra_date_type := '';
				string8			conviction_override_date := '';
				string1			conviction_override_date_type := '';
				string2			offense_score := '';
				unsigned8 	offender_persistent_id := 0;
		end;

		// copied from Hygenics_SOff.Layout_common_Offense_new - 10-10-19
		export SOff_Offense_Layout := record, maxlength(200000)
				string60 		Seisint_Primary_Key;
				string80 		conviction_jurisdiction := '';
				string8  		conviction_date := '';
				string30 		court := '';
				string25 		court_case_number := '';
				string8  		offense_date := '';
				string20 		offense_code_or_statute := '';
				string320   offense_description := '';
				string180   offense_description_2 := '';
				string30		offense_category:= '';
				string1  		victim_minor := '';
				string3 	 	victim_age := '';
				string10 		victim_gender := '';
				string30 		victim_relationship := '';
				string180   sentence_description := '';
				string180   sentence_description_2 := '';
				string8			arrest_date := '';			//new field added
				string250		arrest_warrant := '';		//new field added
				string1			fcra_conviction_flag;
				string1			fcra_traffic_flag;
				string8			fcra_date;
				string1			fcra_date_type;
				string8			conviction_override_date;
				string1			conviction_override_date_type;
				string2			offense_score;
				unsigned8 	offense_persistent_id;
		end;

		//
		// process Sex Offender information
		//
		export apply_SO_Offender_Main(ds) := 
				functionmacro
						Import Suppress;

						Soff_Offn_Prim_Key_Hash(recordof(ds) L) := hashmd5(trim(l.seisint_primary_key, left, right));
					
						ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_soff_offndr_sup.txt', Soff_Offn_Prim_Key_Hash);
						
						return Suppress.applyRegulatory.simple_append(ds1, 'file_soff_offndr_inj.thor', Hygenics_SOff.Regulatory.SOff_offndr_layout);
				endmacro; // apply_apply_SO_Offender_Main 

		//
		// process Sex Offender Offense information
		//
		export apply_SO_Offender_Offense(ds) := 
				functionmacro
						Import Suppress;

						Soff_Offs_Prim_Key_Hash(recordof(ds) L) := hashmd5(trim(l.seisint_primary_key, left, right));
			
						ds1 := Suppress.applyRegulatory.simple_sup(ds, 'file_soff_offense_sup.txt', Soff_Offs_Prim_Key_Hash);

						return Suppress.applyRegulatory.simple_append(ds1, 'file_soff_offense_inj.thor', Hygenics_SOff.Regulatory.SOff_offense_layout);
				endmacro; // apply_SO_Offender_Offense 									
						
		export apply_SO_enh_fdid(ds) := 
				functionmacro
						return (ds);
				endmacro; // apply_SO_enh_fdid 
					
end;
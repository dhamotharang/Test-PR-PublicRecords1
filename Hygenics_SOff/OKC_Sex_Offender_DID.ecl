import DID_Add, Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, sexoffender, idl_header;

	Lay_OKC_Sex_Off_WithDID := record
			Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final;
			unsigned6 DID             := 0;
			unsigned6 DID_Score_field := 0;
	end;

In_File := Hygenics_SOff.Cleaned_OKC_Sex_Offender;

//Add FlipFlop Macro///////////////////
ut.mac_flipnames(In_File, fname, mname, lname, In_Base_File);

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor
	matchSet := ['A','D','S'];

	//DID_Add.MAC_Match_Flex_Sensitive    // NOTE <- senstitive macro
	DID_Add.MAC_Match_Flex                // regular did macro
				(In_Base_File
				,matchSet
				,orig_ssn, date_of_birth
				,fname, mname,lname
				,name_suffix
				,prim_range, prim_name, sec_range, zip, st
				,''
				,DID
				,Lay_OKC_Sex_Off_WithDID, true, DID_Score_field
				,75                   // DIDs with a score below here will be dropped
				// ,90                   // DIDs with a score below here will be dropped
				,Ds_OKC_Sex_Off_WithDID					
				)

	Lay_OKC_Sex_Off_WithDidSsn := record
		Lay_OKC_Sex_Off_WithDID;
		string9	ssn := '';	
	end;

	Lay_OKC_Sex_Off_WithDidSsn tDefault_ssn(Ds_OKC_Sex_Off_WithDID l) := transform
		self.ssn := '';
		self := l;
	end;

In_OKC_Sex_off_WithDidSsn := project(Ds_OKC_Sex_Off_WithDID, tDefault_ssn(left)):persist('~thor40_241::persist::soff_did');

/*
Lay_OKC_Sex_Off_WithDidSsn := RECORD
  string8 dt_first_reported;
  string8 dt_last_reported;
  string60 seisint_primary_key;
  unsigned8 key;
  string2 vendor_code;
  string1 name_type;
  string30 source_file;
  string10 date_added;
  string10 scrape_date;
  string10 src_upload_date;
  string2 orig_state;
  string50 name_orig;
  string30 orig_firstname;
  string30 orig_middlename;
  string30 orig_lastname;
  string10 orig_suffix;
  string30 firstname;
  string30 middlename;
  string30 lastname;
  string10 suffix;
  string255 name_aka;
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
  string50 police_agency_contact_name;
  string55 police_agency_address_1;
  string35 police_agency_address_2;
  string10 police_agency_phone;
  string35 registration_type;
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
  string40 sor_number;
  string30 st_id_number;
  string30 fbi_number;
  string30 ncic_number;
  string9 orig_ssn;
  string8 date_of_birth;
  string8 date_of_birth_aka;
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
  string40 offense_location_1;
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
  string10 offense_level_1;
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string8 disposition_dt_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
  string8 arrest_date_2;
  string250 arrest_warrant_2;
  string40 offense_location_2;
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string320 offense_description_2;
  string180 offense_description_2_2;
  string10 offense_level_2;
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string8 disposition_dt_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
  string8 arrest_date_3;
  string250 arrest_warrant_3;
  string40 offense_location_3;
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string320 offense_description_3;
  string180 offense_description_3_2;
  string10 offense_level_3;
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string8 disposition_dt_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
  string8 arrest_date_4;
  string250 arrest_warrant_4;
  string40 offense_location_4;
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string320 offense_description_4;
  string180 offense_description_4_2;
  string10 offense_level_4;
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string3 victim_relationship_4;
  string8 disposition_dt_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
  string40 offense_location_5;
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string320 offense_description_5;
  string180 offense_description_5_2;
  string10 offense_level_5;
  string1 victim_minor_5;
  string3 victim_age_5;
  string10 victim_gender_5;
  string30 victim_relationship_5;
  string8 disposition_dt_5;
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
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
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
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned6 did;
  unsigned6 did_score_field;
  string9 ssn;
 END;

In_OKC_Sex_off_WithDidSsn := dataset('~thor40_241::persist::soff_did', Lay_OKC_Sex_Off_WithDidSsn, flat);
*/

did_add.MAC_Add_SSN_By_DID(In_OKC_Sex_off_WithDidSsn, did, ssn, Out_OKC_Sex_Off_WithDidSsn);
//output(Out_OKC_Sex_Off_WithDidSsn,,'~thor40_241::persist::Out_OKC_Sex_Off_WithDidSsn', overwrite);

	//Clean out invalid SSN values to ensure none of the wrong ones are appended 
	slim_Sex_Off_DID_SSN_rec := record
		string60  seisint_primary_key;
		string    name_orig;
		string1   name_type;
		string    date_of_birth;
		unsigned6 DID;
		unsigned6 did_score;
		string9	  ssn;	
	end;

	slim_Sex_Off_DID_SSN_rec tSlim_down_Sex_Off(Out_OKC_Sex_Off_WithDidSsn L) := transform
		self.did_score := L.DID_Score_field;
		self           := L;
	end;

In_OKC_Sex_Off_WithDidSsn_Slim := project(Out_OKC_Sex_Off_WithDidSsn
                                         ,tSlim_down_Sex_Off(left));

did_add.mac_BlankDIDWhenSSNInvalid(In_OKC_Sex_Off_WithDidSsn_Slim, Out_OKC_Sex_Off_WithDidSsn_Slim);

//output(Out_OKC_Sex_Off_WithDidSsn_Slim,,'~thor40_241::persist::soff_ssn');

//output('Count of slim records with DIDs after cleaning: ' + count(Out_OKC_Sex_Off_WithDidSsn_Slim(DID != 0)));

	Lay_OKC_Sex_Off_WithDidSsn tRejoin_SSNs(Out_OKC_Sex_Off_WithDidSsn      L
										   ,Out_OKC_Sex_Off_WithDidSsn_Slim R) := transform
		self.ssn := if(R.DID != 0
					  ,R.ssn
					  ,'');
		self := L;
	end;

Out_OKC_Sex_off_WithDidSsn2 := join(Out_OKC_Sex_Off_WithDidSsn
									,Out_OKC_Sex_Off_WithDidSsn_Slim
									,Left.seisint_primary_key = Right.seisint_primary_key
										AND Left.name_orig     = Right.name_orig
										AND Left.name_type     = Right.name_type
										AND Left.date_of_birth = Right.date_of_birth
										AND Left.ssn           = Right.ssn
								   ,tRejoin_SSNs(LEFT,RIGHT));

//End of process removing invalid SSN values

Ds_OKC_Sex_Off_with_did_ssn := Out_OKC_Sex_off_WithDidSsn2;

	Layout_outf := record
		string12 did;
		string3  did_score;
		string9  ssn;
		Hygenics_SOff.Layout_OKC_Sex_Offender_Common.final;
	end;

	Layout_outf trf(Ds_OKC_Sex_Off_with_did_ssn l) := TRANSFORM
		self.did := if((trim((string)l.did) != '' 
					   AND           l.did  != 0)
					  ,intformat(l.did, 12, 1)
					  ,'');
		self.did_score	:= (string3)L.did_score_field;
		self := l;
	end;
	
Ds_OKC_Sex_Off_WithDidSsn := Project(Ds_OKC_Sex_Off_with_did_ssn,trf(left));

//Suppress Records  ////////////////////////////
	// Bug: 80123. DID = 2074179303	score = 75	ssn append = 178546978
	//Bugzilla #Bug 80123, Added Bugzilla Bug #202131
	Ds_OKC_Sex_Off_WithDidSsn removeInfo(Ds_OKC_Sex_Off_WithDidSsn l):= transform
		self.ssn		:= if((l.ssn='353561176' and l.did='2275932305') or 
									(l.ssn='567086017' and l.did='000637548399') or
									(l.ssn='282920169' and l.did='166338675767') or
									(l.ssn='228677764' and l.did='173327970243') or
									(l.ssn='178546978' and l.did='002074179303') or
									(l.ssn='196364565' and l.did='000093428187') or
									(l.ssn=''          and l.did='107007223771') or
									(l.ssn='046561828' and l.did='000066048309') or
									(l.ssn='132663291' and l.did='002640241816') or
									(l.ssn='623211738' and l.did='122113244666') or
									(l.ssn='542089805' and l.did='002166694879') or
									(l.ssn='454931305' and l.did='001035336436') or
									(l.ssn='495742312' and l.did='001033147214'),
							'',
							l.ssn);
		self.did		:= if((l.ssn='353561176' and l.did='2275932305') or 
									(l.ssn='567086017' and l.did='000637548399') or
									(l.ssn='282920169' and l.did='166338675767') or
									(l.ssn='228677764' and l.did='173327970243') or
									(l.ssn='178546978' and l.did='002074179303') or
									(l.ssn='196364565' and l.did='000093428187') or
									(l.ssn=''          and l.did='107007223771') or
									(l.ssn='046561828' and l.did='000066048309') or
									(l.ssn='132663291' and l.did='002640241816') or
									(l.ssn='623211738' and l.did='122113244666') or
									(l.ssn='542089805' and l.did='002166694879') or
									(l.ssn='454931305' and l.did='001035336436') or
									(l.ssn='495742312' and l.did='001033147214'),
							'',
							l.did);
		self.did_score	:= if((l.ssn='353561176' and l.did='2275932305') or 
									(l.ssn='567086017' and l.did='000637548399') or
									(l.ssn='282920169' and l.did='166338675767') or
									(l.ssn='228677764' and l.did='173327970243') or
									(l.ssn='178546978' and l.did='002074179303') or
									(l.ssn='196364565' and l.did='000093428187') or
									(l.ssn=''          and l.did='107007223771') or
									(l.ssn='046561828' and l.did='000066048309') or
									(l.ssn='132663291' and l.did='002640241816') or
									(l.ssn='623211738' and l.did='122113244666') or
									(l.ssn='542089805' and l.did='002166694879') or
									(l.ssn='454931305' and l.did='001035336436') or
									(l.ssn='495742312' and l.did='001033147214'),
							'',
							l.did_score);
		self 			:= l;
	end;

	suppressed_records := project(Ds_OKC_Sex_Off_WithDidSsn, removeInfo(left));
/*	
dslayout := RECORD
  string12 did;
  string3 did_score;
  string9 ssn;
  string8 dt_first_reported;
  string8 dt_last_reported;
  string60 seisint_primary_key;
  unsigned8 key;
  string2 vendor_code;
  string1 name_type;
  string30 source_file;
  string10 date_added;
  string10 scrape_date;
  string10 src_upload_date;
  string2 orig_state;
  string50 name_orig;
  string30 orig_firstname;
  string30 orig_middlename;
  string30 orig_lastname;
  string10 orig_suffix;
  string30 firstname;
  string30 middlename;
  string30 lastname;
  string10 suffix;
  string255 name_aka;
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
  string50 police_agency_contact_name;
  string55 police_agency_address_1;
  string35 police_agency_address_2;
  string10 police_agency_phone;
  string35 registration_type;
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
  string40 sor_number;
  string30 st_id_number;
  string30 fbi_number;
  string30 ncic_number;
  string9 orig_ssn;
  string8 date_of_birth;
  string8 date_of_birth_aka;
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
  string40 offense_location_1;
  string80 conviction_jurisdiction_1;
  string8 conviction_date_1;
  string30 court_1;
  string25 court_case_number_1;
  string8 offense_date_1;
  string20 offense_code_or_statute_1;
  string320 offense_description_1;
  string180 offense_description_1_2;
  string10 offense_level_1;
  string1 victim_minor_1;
  string3 victim_age_1;
  string10 victim_gender_1;
  string30 victim_relationship_1;
  string8 disposition_dt_1;
  string180 sentence_description_1;
  string180 sentence_description_1_2;
  string8 arrest_date_2;
  string250 arrest_warrant_2;
  string40 offense_location_2;
  string80 conviction_jurisdiction_2;
  string8 conviction_date_2;
  string30 court_2;
  string25 court_case_number_2;
  string8 offense_date_2;
  string20 offense_code_or_statute_2;
  string320 offense_description_2;
  string180 offense_description_2_2;
  string10 offense_level_2;
  string1 victim_minor_2;
  string3 victim_age_2;
  string10 victim_gender_2;
  string30 victim_relationship_2;
  string8 disposition_dt_2;
  string180 sentence_description_2;
  string180 sentence_description_2_2;
  string8 arrest_date_3;
  string250 arrest_warrant_3;
  string40 offense_location_3;
  string80 conviction_jurisdiction_3;
  string8 conviction_date_3;
  string30 court_3;
  string25 court_case_number_3;
  string8 offense_date_3;
  string20 offense_code_or_statute_3;
  string320 offense_description_3;
  string180 offense_description_3_2;
  string10 offense_level_3;
  string1 victim_minor_3;
  string3 victim_age_3;
  string10 victim_gender_3;
  string30 victim_relationship_3;
  string8 disposition_dt_3;
  string180 sentence_description_3;
  string180 sentence_description_3_2;
  string8 arrest_date_4;
  string250 arrest_warrant_4;
  string40 offense_location_4;
  string80 conviction_jurisdiction_4;
  string8 conviction_date_4;
  string30 court_4;
  string25 court_case_number_4;
  string8 offense_date_4;
  string20 offense_code_or_statute_4;
  string320 offense_description_4;
  string180 offense_description_4_2;
  string10 offense_level_4;
  string1 victim_minor_4;
  string3 victim_age_4;
  string10 victim_gender_4;
  string3 victim_relationship_4;
  string8 disposition_dt_4;
  string180 sentence_description_4;
  string180 sentence_description_4_2;
  string8 arrest_date_5;
  string250 arrest_warrant_5;
  string40 offense_location_5;
  string80 conviction_jurisdiction_5;
  string8 conviction_date_5;
  string30 court_5;
  string25 court_case_number_5;
  string8 offense_date_5;
  string20 offense_code_or_statute_5;
  string320 offense_description_5;
  string180 offense_description_5_2;
  string10 offense_level_5;
  string1 victim_minor_5;
  string3 victim_age_5;
  string10 victim_gender_5;
  string30 victim_relationship_5;
  string8 disposition_dt_5;
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
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  unsigned8 nid;
  string1 ntype;
  unsigned2 nindicator;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
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
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 offender_persistent_id;
  unsigned8 offense_persistent_id;
 END;

ds := dataset('~thor_data400::persist::hd::cleaned_okc_sex_offender_with_did_ssn2_spk', dslayout, flat);	
*/
export OKC_Sex_Offender_DID := suppressed_records : persist('~thor_data400::Persist::hd::Cleaned_OKC_Sex_Offender_With_did_ssn2_spk');


IMPORT BusinessInstantID20_Services, iesp, Risk_Indicators, RiskWise, Seed_Files, STD, ut;

EXPORT BIIDV2_TestSeed_Function(DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) inData = DATASET([],BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo),
																STRING32 TestDataTableName_in = '',
																DATA16 hashval = HASHMD5('DEFAULT'),
																BusinessInstantID20_Services.iOptions Options) := FUNCTION
		
	// There at least three versions of this product:
	//   o  BASE
	//   o  COMPLIANCE (BASE plus other stuff)
	//   o  COMPLIANCE_PLUS_SBFE (BASE plus other stuff plus a few SBFE attributes)
	isComplianceVersion         := Options.BIID20_productType IN [ BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE, BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE ];
	isCompliancePlusSBFEVersion := Options.BIID20_productType = BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE;
	
	working_layout := RECORD
		// string30 in_seq;
		string20 dataset_name;
		data16 hashkey;
		iesp.businessinstantid20.t_BIID20AuthorizedRepresentativeResults;
	END;
	
	working_layout getSearchKey(BusinessInstantID20_Services.Layouts.InputCompanyAndAuthRepInfo le) := TRANSFORM
		// self.in_seq := (String)le.Seq;
		self.dataset_name := TestDataTableName_in;

		self.hashkey := Seed_Files.Hash_InstantID(
		                    StringLib.StringToUpperCase(trim(le.AuthReps[1].FirstName)), // fname,
		                    StringLib.StringToUpperCase(trim(le.AuthReps[1].LastName)),  // lname,
		                    risk_indicators.nullstring,  // ssn -- not used in business products,
		                    StringLib.StringToUpperCase(trim(le.FEIN)),         // fein,
		                    StringLib.StringToUpperCase(trim(le.Zip)),          // zip,
		                    StringLib.StringToUpperCase(trim(le.Phone10)),      // phone,
		                    StringLib.StringToUpperCase(trim(le.CompanyName))); // company_name
		self := [];
	END;
	
	inrecs := project(inData, getSearchKey(LEFT));
	
	_dataset_name := IF( hashval = HASHMD5('DEFAULT'), inrecs[1].dataset_name, TestDataTableName_in );
	_hashvalue    := IF( hashval = HASHMD5('DEFAULT'), inrecs[1].hashkey     , hashval );

	key1 := Seed_Files.BIID20_keys.BIID20keypart1( KEYED(dataset_name = _dataset_name AND hashvalue = _hashvalue) )[1];
	key2 := Seed_Files.BIID20_keys.BIID20keypart2( KEYED(dataset_name = _dataset_name AND hashvalue = _hashvalue) )[1];
	key3 := Seed_Files.BIID20_keys.BIID20keypart3( KEYED(dataset_name = _dataset_name AND hashvalue = _hashvalue) )[1];
	
  fn_CreateFakeDID( STRING fname, STRING lname ) := 
    (UNSIGNED6)(STD.Str.Filter( (STRING)(HASH(fname,lname)), '0123456789' )[1..12]);

	
//rep1	
	BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_buildConsumerInstantID_1 := 
		TRANSFORM
			// i.e. risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno,seq];
      SELF.did              := fn_CreateFakeDID( key1.rep1_firstname, key1.rep1_lastname );
      SELF.rep_whichone     := IF(key1.rep1_firstname <> '' AND key1.rep1_lastname <> '','1','');
      SELF.sequence         := IF(key1.rep1_firstname <> '' AND key1.rep1_lastname <> '','1','');
      SELF.title            := key1.rep1_titlename;
      SELF.fname            := key1.rep1_firstname;
      SELF.mname            := key1.rep1_middlename;
      SELF.lname            := key1.rep1_lastname;
      SELF.in_streetAddress := key1.rep1_addr1;
      SELF.in_city          := key1.rep1_city_name;
      SELF.in_state         := key1.rep1_st;
      SELF.in_zipCode       := key1.rep1_z5;
      SELF.ssn              := key1.rep1_ssn;
      SELF.dob              := key1.rep1_dob;
      SELF.age              := key1.rep1_age;
      SELF.phone10          := key1.rep1_phone10;
      SELF.dl_number        := key1.rep1_dlnumber;
      SELF.dl_state         := key1.rep1_dlstate;
      SELF.email_address    := key1.rep1_email;
			SELF.verfirst	     := key2.rep1_verfirst;
			SELF.verlast	     := key2.rep1_verlast;
			SELF.veraddr	     := key2.rep1_veraddr;
			SELF.vercity	     := key2.rep1_vercity;
			SELF.verstate	     := key2.rep1_verstate;
			SELF.verzip	       := key2.rep1_verzip;
			SELF.verzip4	     := key2.rep1_verzip4;
			SELF.vercounty	   := key2.rep1_vercounty;
			SELF.verssn	       := key2.rep1_verssn;
			SELF.verdob	       := key2.rep1_verdob;
			SELF.verhphone	   := key2.rep1_verhphone;
			SELF.verdl	       := key2.rep1_verdl;
			SELF.verify_addr	 := key2.rep1_verify_addr;
			SELF.verify_dob	   := key2.rep1_verify_dob;
			SELF.valid_ssn	   := key2.rep1_valid_ssn;
			SELF.nas_summary	 := (INTEGER)key2.rep1_nas_summary;
			SELF.nap_summary	 := (INTEGER)key2.rep1_nap_summary;
			SELF.nap_type	     := key2.rep1_nap_type;
			SELF.nap_status	   := key2.rep1_nap_status;
			SELF.cvi	         := key2.rep1_cvi;
			SELF.deceaseddate	 := key2.rep1_deceaseddate;
			SELF.deceaseddob	 := key2.rep1_deceaseddob;
			SELF.deceasedfirst := key2.rep1_deceasedfirst;
			SELF.deceasedlast  := key2.rep1_deceasedlast;
			SELF.dobmatchlevel := key2.rep1_dobmatchlevel;

			SELF.ri := 
					DATASET( 
						[
							{ 1, key2.rep1_hri_1, key2.rep1_hri_desc_1 },
							{ 2, key2.rep1_hri_2, key2.rep1_hri_desc_2 },
							{ 3, key2.rep1_hri_3, key2.rep1_hri_desc_3 },
							{ 4, key2.rep1_hri_4, key2.rep1_hri_desc_4 },
							{ 5, key2.rep1_hri_5, key2.rep1_hri_desc_5 },
							{ 6, key2.rep1_hri_6, key2.rep1_hri_desc_6 },
							{ 7, key2.rep1_hri_7, key2.rep1_hri_desc_7 },
							{ 8, key2.rep1_hri_8, key2.rep1_hri_desc_8 }
						], 
						Risk_Indicators.layouts.layout_desc_plus_seq 
					)(hri != '');

			SELF.fua :=
					DATASET( 
						[
							{ key2.rep1_fua_1, key2.rep1_fua_desc_1 },
							{ key2.rep1_fua_2, key2.rep1_fua_desc_2 },
							{ key2.rep1_fua_3, key2.rep1_fua_desc_3 },
							{ key2.rep1_fua_4, key2.rep1_fua_desc_4 }
						], 
						Risk_Indicators.Layout_Desc 
					)(hri != '');			

			SELF.corrected_lname	    := key2.rep1_corrected_lname;
			SELF.corrected_dob	      := key2.rep1_corrected_dob;
			SELF.corrected_phone	    := key2.rep1_corrected_phone;
			SELF.corrected_ssn	      := key2.rep1_corrected_ssn;
			SELF.corrected_address	  := key2.rep1_corrected_address;
			SELF.area_code_split	    := key2.rep1_area_code_split;
			SELF.area_code_split_date := key2.rep1_area_code_split_date;
			SELF.phone_fname	        := key2.rep1_phone_fname;
			SELF.phone_lname	        := key2.rep1_phone_lname;
			SELF.phone_address	      := key2.rep1_phone_address;
			SELF.phone_city	          := key2.rep1_phone_city;
			SELF.phone_st	            := key2.rep1_phone_st;
			SELF.phone_zip	          := key2.rep1_phone_zip;
			SELF.name_addr_phone	    := key2.rep1_name_addr_phone;
			SELF.ssa_date_first	      := key2.rep1_ssa_date_first;
			SELF.ssa_date_last	      := key2.rep1_ssa_date_last;
			SELF.ssa_state	          := key2.rep1_ssa_state;
			SELF.ssa_state_name	      := key2.rep1_ssa_state_name;
			SELF.current_fname	      := key2.rep1_current_fname;
			SELF.current_lname	      := key2.rep1_current_lname;
			
			SELF.chronology :=
					DATASET(
						[
							{1,key2.rep1_chron_address_1,'','','','','','','',key2.rep1_chron_city_1,key2.rep1_chron_st_1,key2.rep1_chron_zip_1,key2.rep1_chron_zip4_1,key2.rep1_chron_phone_1,key2.rep1_chron_dt_first_seen_1,key2.rep1_chron_dt_last_seen_1,false,''},
							{2,key2.rep1_chron_address_2,'','','','','','','',key2.rep1_chron_city_2,key2.rep1_chron_st_2,key2.rep1_chron_zip_2,key2.rep1_chron_zip4_2,key2.rep1_chron_phone_2,key2.rep1_chron_dt_first_seen_2,key2.rep1_chron_dt_last_seen_2,false,''},
							{3,key2.rep1_chron_address_3,'','','','','','','',key2.rep1_chron_city_3,key2.rep1_chron_st_3,key2.rep1_chron_zip_3,key2.rep1_chron_zip4_3,key2.rep1_chron_phone_3,key2.rep1_chron_dt_first_seen_3,key2.rep1_chron_dt_last_seen_3,false,''}
						],
						Risk_Indicators.Layout_AddressHistory
					)(Address != '');
			
			SELF.Additional_Lname := 
					DATASET(
						[
							{key2.rep1_addl_fname_1,key2.rep1_addl_lname_1,key2.rep1_addl_lname_date_last_1},
							{key2.rep1_addl_fname_2,key2.rep1_addl_lname_2,key2.rep1_addl_lname_date_last_2},
							{key2.rep1_addl_fname_3,key2.rep1_addl_lname_3,key2.rep1_addl_lname_date_last_3}
						],
						Risk_Indicators.Layout_LastNames
					)(lname1 != '');
					
			SELF.addresspobox	           := key2.rep1_addresspobox;
			SELF.addresscmra	           := key2.rep1_addresscmra;
			SELF.watchlist_table	       := key2.rep1_watchlist_table;
			SELF.watchlist_program	     := key2.rep1_watchlist_program;
			SELF.watchlist_record_number := key2.rep1_watchlist_record_number;
			SELF.watchlist_fname	       := key2.rep1_watchlist_fname;
			SELF.watchlist_lname	       := key2.rep1_watchlist_lname;
			SELF.watchlist_address	     := key2.rep1_watchlist_address;
			SELF.watchlist_city	         := key2.rep1_watchlist_city;
			SELF.watchlist_state	       := key2.rep1_watchlist_state;
			SELF.watchlist_zip	         := key2.rep1_watchlist_zip;
			SELF.Watchlist_contry	       := key2.rep1_watchlist_country;
			SELF.watchlist_entity_name	 := key2.rep1_watchlist_entity_name;
			
			SELF.watchlists :=
					DATASET(
						[
							{1,key2.rep1_watchlist_table  ,key2.rep1_watchlist_program  ,key2.rep1_watchlist_record_number  ,key2.rep1_watchlist_fname  ,key2.rep1_watchlist_lname  ,key2.rep1_watchlist_address  ,'','','','','','','',key2.rep1_watchlist_city  ,key2.rep1_watchlist_state  ,key2.rep1_watchlist_zip  ,key2.rep1_watchlist_country  ,key2.rep1_watchlist_entity_name},
							{2,key2.rep1_watchlist_table_2,key2.rep1_watchlist_program_2,key2.rep1_watchlist_record_number_2,key2.rep1_watchlist_fname_2,key2.rep1_watchlist_lname_2,key2.rep1_watchlist_address_2,'','','','','','','',key2.rep1_watchlist_city_2,key2.rep1_watchlist_state_2,key2.rep1_watchlist_zip_2,key2.rep1_watchlist_country_2,key2.rep1_watchlist_entity_name_2},
							{3,key2.rep1_watchlist_table_3,key2.rep1_watchlist_program_3,key2.rep1_watchlist_record_number_3,key2.rep1_watchlist_fname_3,key2.rep1_watchlist_lname_3,key2.rep1_watchlist_address_3,'','','','','','','',key2.rep1_watchlist_city_3,key2.rep1_watchlist_state_3,key2.rep1_watchlist_zip_3,key2.rep1_watchlist_country_3,key2.rep1_watchlist_entity_name_3},
							{4,key2.rep1_watchlist_table_4,key2.rep1_watchlist_program_4,key2.rep1_watchlist_record_number_4,key2.rep1_watchlist_fname_4,key2.rep1_watchlist_lname_4,key2.rep1_watchlist_address_4,'','','','','','','',key2.rep1_watchlist_city_4,key2.rep1_watchlist_state_4,key2.rep1_watchlist_zip_4,key2.rep1_watchlist_country_4,key2.rep1_watchlist_entity_name_4},
							{5,key2.rep1_watchlist_table_5,key2.rep1_watchlist_program_5,key2.rep1_watchlist_record_number_5,key2.rep1_watchlist_fname_5,key2.rep1_watchlist_lname_5,key2.rep1_watchlist_address_5,'','','','','','','',key2.rep1_watchlist_city_5,key2.rep1_watchlist_state_5,key2.rep1_watchlist_zip_5,key2.rep1_watchlist_country_5,key2.rep1_watchlist_entity_name_5},
							{6,key2.rep1_watchlist_table_6,key2.rep1_watchlist_program_6,key2.rep1_watchlist_record_number_6,key2.rep1_watchlist_fname_6,key2.rep1_watchlist_lname_6,key2.rep1_watchlist_address_6,'','','','','','','',key2.rep1_watchlist_city_6,key2.rep1_watchlist_state_6,key2.rep1_watchlist_zip_6,key2.rep1_watchlist_country_6,key2.rep1_watchlist_entity_name_6},
							{7,key2.rep1_watchlist_table_7,key2.rep1_watchlist_program_7,key2.rep1_watchlist_record_number_7,key2.rep1_watchlist_fname_7,key2.rep1_watchlist_lname_7,key2.rep1_watchlist_address_7,'','','','','','','',key2.rep1_watchlist_city_7,key2.rep1_watchlist_state_7,key2.rep1_watchlist_zip_7,key2.rep1_watchlist_country_7,key2.rep1_watchlist_entity_name_7}
						],
						Risk_Indicators.layouts.layout_watchlists_plus_seq
					)(Watchlist_Table != '');

			SELF := [];
		END;

//rep2

	BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_buildConsumerInstantID_2 := 
		TRANSFORM
			// i.e. risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno,seq];
      SELF.did              := fn_CreateFakeDID( key1.rep2_firstname, key1.rep2_lastname );
      SELF.rep_whichone     := IF(key1.rep2_firstname <> '' AND key1.rep2_lastname <> '','2','');
      SELF.sequence         := IF(key1.rep2_firstname <> '' AND key1.rep2_lastname <> '','2','');
      SELF.title            := key1.rep2_titlename;
      SELF.fname            := key1.rep2_firstname;
      SELF.mname            := key1.rep2_middlename;
      SELF.lname            := key1.rep2_lastname;
      SELF.in_streetAddress := key1.rep2_addr1;
      SELF.in_city          := key1.rep2_city_name;
      SELF.in_state         := key1.rep2_st;
      SELF.in_zipCode       := key1.rep2_z5;
      SELF.ssn              := key1.rep2_ssn;
      SELF.dob              := key1.rep2_dob;
      SELF.age              := key1.rep2_age;
      SELF.phone10          := key1.rep2_phone10;
      SELF.dl_number        := key1.rep2_dlnumber;
      SELF.dl_state         := key1.rep2_dlstate;
      SELF.email_address    := key1.rep2_email;
			SELF.verfirst	     := key2.rep2_verfirst;
			SELF.verlast	     := key2.rep2_verlast;
			SELF.veraddr	     := key2.rep2_veraddr;
			SELF.vercity	     := key2.rep2_vercity;
			SELF.verstate	     := key2.rep2_verstate;
			SELF.verzip	       := key2.rep2_verzip;
			SELF.verzip4	     := key2.rep2_verzip4;
			SELF.vercounty	   := key2.rep2_vercounty;
			SELF.verssn	       := key2.rep2_verssn;
			SELF.verdob	       := key2.rep2_verdob;
			SELF.verhphone	   := key2.rep2_verhphone;
			SELF.verdl	       := key2.rep2_verdl;
			SELF.verify_addr	 := key2.rep2_verify_addr;
			SELF.verify_dob	   := key2.rep2_verify_dob;
			SELF.valid_ssn	   := key2.rep2_valid_ssn;
			SELF.nas_summary	 := (INTEGER)key2.rep2_nas_summary;
			SELF.nap_summary	 := (INTEGER)key2.rep2_nap_summary;
			SELF.nap_type	     := key2.rep2_nap_type;
			SELF.nap_status	   := key2.rep2_nap_status;
			SELF.cvi	         := key2.rep2_cvi;
			SELF.deceaseddate	 := key2.rep2_deceaseddate;
			SELF.deceaseddob	 := key2.rep2_deceaseddob;
			SELF.deceasedfirst := key2.rep2_deceasedfirst;
			SELF.deceasedlast  := key2.rep2_deceasedlast;
			SELF.dobmatchlevel := key2.rep2_dobmatchlevel;

			SELF.ri := 
					DATASET( 
						[
							{ 1, key2.rep2_hri_1, key2.rep2_hri_desc_1 },
							{ 2, key2.rep2_hri_2, key2.rep2_hri_desc_2 },
							{ 3, key2.rep2_hri_3, key2.rep2_hri_desc_3 },
							{ 4, key2.rep2_hri_4, key2.rep2_hri_desc_4 },
							{ 5, key2.rep2_hri_5, key2.rep2_hri_desc_5 },
							{ 6, key2.rep2_hri_6, key2.rep2_hri_desc_6 },
							{ 7, key2.rep2_hri_7, key2.rep2_hri_desc_7 },
							{ 8, key2.rep2_hri_8, key2.rep2_hri_desc_8 }
						], 
						Risk_Indicators.layouts.layout_desc_plus_seq 
					)(hri != '');

			SELF.fua :=
					DATASET( 
						[
							{ key2.rep2_fua_1, key2.rep2_fua_desc_1 },
							{ key2.rep2_fua_2, key2.rep2_fua_desc_2 },
							{ key2.rep2_fua_3, key2.rep2_fua_desc_3 },
							{ key2.rep2_fua_4, key2.rep2_fua_desc_4 }
						], 
						Risk_Indicators.Layout_Desc 
					)(hri != '');			

			SELF.corrected_lname	    := key2.rep2_corrected_lname;
			SELF.corrected_dob	      := key2.rep2_corrected_dob;
			SELF.corrected_phone	    := key2.rep2_corrected_phone;
			SELF.corrected_ssn	      := key2.rep2_corrected_ssn;
			SELF.corrected_address	  := key2.rep2_corrected_address;
			SELF.area_code_split	    := key2.rep2_area_code_split;
			SELF.area_code_split_date := key2.rep2_area_code_split_date;
			SELF.phone_fname	        := key2.rep2_phone_fname;
			SELF.phone_lname	        := key2.rep2_phone_lname;
			SELF.phone_address	      := key2.rep2_phone_address;
			SELF.phone_city	          := key2.rep2_phone_city;
			SELF.phone_st	            := key2.rep2_phone_st;
			SELF.phone_zip	          := key2.rep2_phone_zip;
			SELF.name_addr_phone	    := key2.rep2_name_addr_phone;
			SELF.ssa_date_first	      := key2.rep2_ssa_date_first;
			SELF.ssa_date_last	      := key2.rep2_ssa_date_last;
			SELF.ssa_state	          := key2.rep2_ssa_state;
			SELF.ssa_state_name	      := key2.rep2_ssa_state_name;
			SELF.current_fname	      := key2.rep2_current_fname;
			SELF.current_lname	      := key2.rep2_current_lname;
			
			SELF.chronology :=
					DATASET(
						[
							{1,key2.rep2_chron_address_1,'','','','','','','',key2.rep2_chron_city_1,key2.rep2_chron_st_1,key2.rep2_chron_zip_1,key2.rep2_chron_zip4_1,key2.rep2_chron_phone_1,key2.rep2_chron_dt_first_seen_1,key2.rep2_chron_dt_last_seen_1,FALSE,''},
							{2,key2.rep2_chron_address_2,'','','','','','','',key2.rep2_chron_city_2,key2.rep2_chron_st_2,key2.rep2_chron_zip_2,key2.rep2_chron_zip4_2,key2.rep2_chron_phone_2,key2.rep2_chron_dt_first_seen_2,key2.rep2_chron_dt_last_seen_2,FALSE,''},
							{3,key2.rep2_chron_address_3,'','','','','','','',key2.rep2_chron_city_3,key2.rep2_chron_st_3,key2.rep2_chron_zip_3,key2.rep2_chron_zip4_3,key2.rep2_chron_phone_3,key2.rep2_chron_dt_first_seen_3,key2.rep2_chron_dt_last_seen_3,FALSE,''}
						],
						Risk_Indicators.Layout_AddressHistory
					)(Address != '');
			
			SELF.Additional_Lname := 
					DATASET(
						[
							{key2.rep2_addl_fname_1,key2.rep2_addl_lname_1,key2.rep2_addl_lname_date_last_1},
							{key2.rep2_addl_fname_2,key2.rep2_addl_lname_2,key2.rep2_addl_lname_date_last_2},
							{key2.rep2_addl_fname_3,key2.rep2_addl_lname_3,key2.rep2_addl_lname_date_last_3}
						],
						Risk_Indicators.Layout_LastNames
					)(lname1 != '');
					
			SELF.addresspobox	           := key2.rep2_addresspobox;
			SELF.addresscmra	           := key2.rep2_addresscmra;
			SELF.watchlist_table	       := key2.rep2_watchlist_table;
			SELF.watchlist_program	     := key2.rep2_watchlist_program;
			SELF.watchlist_record_number := key2.rep2_watchlist_record_number;
			SELF.watchlist_fname	       := key2.rep2_watchlist_fname;
			SELF.watchlist_lname	       := key2.rep2_watchlist_lname;
			SELF.watchlist_address	     := key2.rep2_watchlist_address;
			SELF.watchlist_city	         := key2.rep2_watchlist_city;
			SELF.watchlist_state	       := key2.rep2_watchlist_state;
			SELF.watchlist_zip	         := key2.rep2_watchlist_zip;
			SELF.Watchlist_contry	       := key2.rep2_watchlist_country;
			SELF.watchlist_entity_name	 := key2.rep2_watchlist_entity_name;
			
			SELF.watchlists :=
					DATASET(
						[
							{1,key2.rep2_watchlist_table  ,key2.rep2_watchlist_program  ,key2.rep2_watchlist_record_number  ,key2.rep2_watchlist_fname  ,key2.rep2_watchlist_lname  ,key2.rep2_watchlist_address  ,'','','','','','','',key2.rep2_watchlist_city  ,key2.rep2_watchlist_state  ,key2.rep2_watchlist_zip  ,key2.rep2_watchlist_country  ,key2.rep2_watchlist_entity_name},
							{2,key2.rep2_watchlist_table_2,key2.rep2_watchlist_program_2,key2.rep2_watchlist_record_number_2,key2.rep2_watchlist_fname_2,key2.rep2_watchlist_lname_2,key2.rep2_watchlist_address_2,'','','','','','','',key2.rep2_watchlist_city_2,key2.rep2_watchlist_state_2,key2.rep2_watchlist_zip_2,key2.rep2_watchlist_country_2,key2.rep2_watchlist_entity_name_2},
							{3,key2.rep2_watchlist_table_3,key2.rep2_watchlist_program_3,key2.rep2_watchlist_record_number_3,key2.rep2_watchlist_fname_3,key2.rep2_watchlist_lname_3,key2.rep2_watchlist_address_3,'','','','','','','',key2.rep2_watchlist_city_3,key2.rep2_watchlist_state_3,key2.rep2_watchlist_zip_3,key2.rep2_watchlist_country_3,key2.rep2_watchlist_entity_name_3},
							{4,key2.rep2_watchlist_table_4,key2.rep2_watchlist_program_4,key2.rep2_watchlist_record_number_4,key2.rep2_watchlist_fname_4,key2.rep2_watchlist_lname_4,key2.rep2_watchlist_address_4,'','','','','','','',key2.rep2_watchlist_city_4,key2.rep2_watchlist_state_4,key2.rep2_watchlist_zip_4,key2.rep2_watchlist_country_4,key2.rep2_watchlist_entity_name_4},
							{5,key2.rep2_watchlist_table_5,key2.rep2_watchlist_program_5,key2.rep2_watchlist_record_number_5,key2.rep2_watchlist_fname_5,key2.rep2_watchlist_lname_5,key2.rep2_watchlist_address_5,'','','','','','','',key2.rep2_watchlist_city_5,key2.rep2_watchlist_state_5,key2.rep2_watchlist_zip_5,key2.rep2_watchlist_country_5,key2.rep2_watchlist_entity_name_5},
							{6,key2.rep2_watchlist_table_6,key2.rep2_watchlist_program_6,key2.rep2_watchlist_record_number_6,key2.rep2_watchlist_fname_6,key2.rep2_watchlist_lname_6,key2.rep2_watchlist_address_6,'','','','','','','',key2.rep2_watchlist_city_6,key2.rep2_watchlist_state_6,key2.rep2_watchlist_zip_6,key2.rep2_watchlist_country_6,key2.rep2_watchlist_entity_name_6},
							{7,key2.rep2_watchlist_table_7,key2.rep2_watchlist_program_7,key2.rep2_watchlist_record_number_7,key2.rep2_watchlist_fname_7,key2.rep2_watchlist_lname_7,key2.rep2_watchlist_address_7,'','','','','','','',key2.rep2_watchlist_city_7,key2.rep2_watchlist_state_7,key2.rep2_watchlist_zip_7,key2.rep2_watchlist_country_7,key2.rep2_watchlist_entity_name_7}
						],
						Risk_Indicators.layouts.layout_watchlists_plus_seq
					)(Watchlist_Table != '');

			SELF := [];
		END;		
//rep3
	BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_buildConsumerInstantID_3 := 
		TRANSFORM
			// i.e. risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno,seq];
      SELF.did              := fn_CreateFakeDID( key1.rep3_firstname, key1.rep3_lastname );
      SELF.rep_whichone     := IF(key1.rep3_firstname <> '' AND key1.rep3_lastname <> '','3','');
      SELF.sequence         := IF(key1.rep3_firstname <> '' AND key1.rep3_lastname <> '','3','');
      SELF.title            := key1.rep3_titlename;
      SELF.fname            := key1.rep3_firstname;
      SELF.mname            := key1.rep3_middlename;
      SELF.lname            := key1.rep3_lastname;
      SELF.in_streetAddress := key1.rep3_addr1;
      SELF.in_city          := key1.rep3_city_name;
      SELF.in_state         := key1.rep3_st;
      SELF.in_zipCode       := key1.rep3_z5;
      SELF.ssn              := key1.rep3_ssn;
      SELF.dob              := key1.rep3_dob;
      SELF.age              := key1.rep3_age;
      SELF.phone10          := key1.rep3_phone10;
      SELF.dl_number        := key1.rep3_dlnumber;
      SELF.dl_state         := key1.rep3_dlstate;
      SELF.email_address    := key1.rep3_email;
			SELF.verfirst	     := key2.rep3_verfirst;
			SELF.verlast	     := key2.rep3_verlast;
			SELF.veraddr	     := key2.rep3_veraddr;
			SELF.vercity	     := key2.rep3_vercity;
			SELF.verstate	     := key2.rep3_verstate;
			SELF.verzip	       := key2.rep3_verzip;
			SELF.verzip4	     := key2.rep3_verzip4;
			SELF.vercounty	   := key2.rep3_vercounty;
			SELF.verssn	       := key2.rep3_verssn;
			SELF.verdob	       := key2.rep3_verdob;
			SELF.verhphone	   := key2.rep3_verhphone;
			SELF.verdl	       := key2.rep3_verdl;
			SELF.verify_addr	 := key2.rep3_verify_addr;
			SELF.verify_dob	   := key2.rep3_verify_dob;
			SELF.valid_ssn	   := key2.rep3_valid_ssn;
			SELF.nas_summary	 := (INTEGER)key2.rep3_nas_summary;
			SELF.nap_summary	 := (INTEGER)key2.rep3_nap_summary;
			SELF.nap_type	     := key2.rep3_nap_type;
			SELF.nap_status	   := key2.rep3_nap_status;
			SELF.cvi	         := key2.rep3_cvi;
			SELF.deceaseddate	 := key2.rep3_deceaseddate;
			SELF.deceaseddob	 := key2.rep3_deceaseddob;
			SELF.deceasedfirst := key2.rep3_deceasedfirst;
			SELF.deceasedlast  := key2.rep3_deceasedlast;
			SELF.dobmatchlevel := key2.rep3_dobmatchlevel;

			SELF.ri := 
					DATASET( 
						[
							{ 1, key2.rep3_hri_1, key2.rep3_hri_desc_1 },
							{ 2, key2.rep3_hri_2, key2.rep3_hri_desc_2 },
							{ 3, key2.rep3_hri_3, key2.rep3_hri_desc_3 },
							{ 4, key2.rep3_hri_4, key2.rep3_hri_desc_4 },
							{ 5, key2.rep3_hri_5, key2.rep3_hri_desc_5 },
							{ 6, key2.rep3_hri_6, key2.rep3_hri_desc_6 },
							{ 7, key2.rep3_hri_7, key2.rep3_hri_desc_7 },
							{ 8, key2.rep3_hri_8, key2.rep3_hri_desc_8 }
						], 
						Risk_Indicators.layouts.layout_desc_plus_seq 
					)(hri != '');

			SELF.fua :=
					DATASET( 
						[
							{ key2.rep3_fua_1, key2.rep3_fua_desc_1 },
							{ key2.rep3_fua_2, key2.rep3_fua_desc_2 },
							{ key2.rep3_fua_3, key2.rep3_fua_desc_3 },
							{ key2.rep3_fua_4, key2.rep3_fua_desc_4 }
						], 
						Risk_Indicators.Layout_Desc 
					)(hri != '');			

			SELF.corrected_lname	    := key2.rep3_corrected_lname;
			SELF.corrected_dob	      := key2.rep3_corrected_dob;
			SELF.corrected_phone	    := key2.rep3_corrected_phone;
			SELF.corrected_ssn	      := key2.rep3_corrected_ssn;
			SELF.corrected_address	  := key2.rep3_corrected_address;
			SELF.area_code_split	    := key2.rep3_area_code_split;
			SELF.area_code_split_date := key2.rep3_area_code_split_date;
			SELF.phone_fname	        := key2.rep3_phone_fname;
			SELF.phone_lname	        := key2.rep3_phone_lname;
			SELF.phone_address	      := key2.rep3_phone_address;
			SELF.phone_city	          := key2.rep3_phone_city;
			SELF.phone_st	            := key2.rep3_phone_st;
			SELF.phone_zip	          := key2.rep3_phone_zip;
			SELF.name_addr_phone	    := key2.rep3_name_addr_phone;
			SELF.ssa_date_first	      := key2.rep3_ssa_date_first;
			SELF.ssa_date_last	      := key2.rep3_ssa_date_last;
			SELF.ssa_state	          := key2.rep3_ssa_state;
			SELF.ssa_state_name	      := key2.rep3_ssa_state_name;
			SELF.current_fname	      := key2.rep3_current_fname;
			SELF.current_lname	      := key2.rep3_current_lname;
			
			SELF.chronology :=
					DATASET(
						[
							{1,key2.rep3_chron_address_1,'','','','','','','',key2.rep3_chron_city_1,key2.rep3_chron_st_1,key2.rep3_chron_zip_1,key2.rep3_chron_zip4_1,key2.rep3_chron_phone_1,key2.rep3_chron_dt_first_seen_1,key2.rep3_chron_dt_last_seen_1,false,''},
							{2,key2.rep3_chron_address_2,'','','','','','','',key2.rep3_chron_city_2,key2.rep3_chron_st_2,key2.rep3_chron_zip_2,key2.rep3_chron_zip4_2,key2.rep3_chron_phone_2,key2.rep3_chron_dt_first_seen_2,key2.rep3_chron_dt_last_seen_2,false,''},
							{3,key2.rep3_chron_address_3,'','','','','','','',key2.rep3_chron_city_3,key2.rep3_chron_st_3,key2.rep3_chron_zip_3,key2.rep3_chron_zip4_3,key2.rep3_chron_phone_3,key2.rep3_chron_dt_first_seen_3,key2.rep3_chron_dt_last_seen_3,false,''}
						],
						Risk_Indicators.Layout_AddressHistory
					)(Address != '');
			
			SELF.Additional_Lname := 
					DATASET(
						[
							{key2.rep3_addl_fname_1,key2.rep3_addl_lname_1,key2.rep3_addl_lname_date_last_1},
							{key2.rep3_addl_fname_2,key2.rep3_addl_lname_2,key2.rep3_addl_lname_date_last_2},
							{key2.rep3_addl_fname_3,key2.rep3_addl_lname_3,key2.rep3_addl_lname_date_last_3}
						],
						Risk_Indicators.Layout_LastNames
					)(lname1 != '');
					
			SELF.addresspobox	           := key2.rep3_addresspobox;
			SELF.addresscmra	           := key2.rep3_addresscmra;
			SELF.watchlist_table	       := key2.rep3_watchlist_table;
			SELF.watchlist_program	     := key2.rep3_watchlist_program;
			SELF.watchlist_record_number := key2.rep3_watchlist_record_number;
			SELF.watchlist_fname	       := key2.rep3_watchlist_fname;
			SELF.watchlist_lname	       := key2.rep3_watchlist_lname;
			SELF.watchlist_address	     := key2.rep3_watchlist_address;
			SELF.watchlist_city	         := key2.rep3_watchlist_city;
			SELF.watchlist_state	       := key2.rep3_watchlist_state;
			SELF.watchlist_zip	         := key2.rep3_watchlist_zip;
			SELF.Watchlist_contry	     := key2.rep3_watchlist_country;
			SELF.watchlist_entity_name	 := key2.rep3_watchlist_entity_name;
			
			SELF.watchlists :=
					DATASET(
						[
							{1,key2.rep3_watchlist_table  ,key2.rep3_watchlist_program  ,key2.rep3_watchlist_record_number  ,key2.rep3_watchlist_fname  ,key2.rep3_watchlist_lname  ,key2.rep3_watchlist_address  ,'','','','','','','',key2.rep3_watchlist_city  ,key2.rep3_watchlist_state  ,key2.rep3_watchlist_zip  ,key2.rep3_watchlist_country  ,key2.rep3_watchlist_entity_name},
							{2,key2.rep3_watchlist_table_2,key2.rep3_watchlist_program_2,key2.rep3_watchlist_record_number_2,key2.rep3_watchlist_fname_2,key2.rep3_watchlist_lname_2,key2.rep3_watchlist_address_2,'','','','','','','',key2.rep3_watchlist_city_2,key2.rep3_watchlist_state_2,key2.rep3_watchlist_zip_2,key2.rep3_watchlist_country_2,key2.rep3_watchlist_entity_name_2},
							{3,key2.rep3_watchlist_table_3,key2.rep3_watchlist_program_3,key2.rep3_watchlist_record_number_3,key2.rep3_watchlist_fname_3,key2.rep3_watchlist_lname_3,key2.rep3_watchlist_address_3,'','','','','','','',key2.rep3_watchlist_city_3,key2.rep3_watchlist_state_3,key2.rep3_watchlist_zip_3,key2.rep3_watchlist_country_3,key2.rep3_watchlist_entity_name_3},
							{4,key2.rep3_watchlist_table_4,key2.rep3_watchlist_program_4,key2.rep3_watchlist_record_number_4,key2.rep3_watchlist_fname_4,key2.rep3_watchlist_lname_4,key2.rep3_watchlist_address_4,'','','','','','','',key2.rep3_watchlist_city_4,key2.rep3_watchlist_state_4,key2.rep3_watchlist_zip_4,key2.rep3_watchlist_country_4,key2.rep3_watchlist_entity_name_4},
							{5,key2.rep3_watchlist_table_5,key2.rep3_watchlist_program_5,key2.rep3_watchlist_record_number_5,key2.rep3_watchlist_fname_5,key2.rep3_watchlist_lname_5,key2.rep3_watchlist_address_5,'','','','','','','',key2.rep3_watchlist_city_5,key2.rep3_watchlist_state_5,key2.rep3_watchlist_zip_5,key2.rep3_watchlist_country_5,key2.rep3_watchlist_entity_name_5},
							{6,key2.rep3_watchlist_table_6,key2.rep3_watchlist_program_6,key2.rep3_watchlist_record_number_6,key2.rep3_watchlist_fname_6,key2.rep3_watchlist_lname_6,key2.rep3_watchlist_address_6,'','','','','','','',key2.rep3_watchlist_city_6,key2.rep3_watchlist_state_6,key2.rep3_watchlist_zip_6,key2.rep3_watchlist_country_6,key2.rep3_watchlist_entity_name_6},
							{7,key2.rep3_watchlist_table_7,key2.rep3_watchlist_program_7,key2.rep3_watchlist_record_number_7,key2.rep3_watchlist_fname_7,key2.rep3_watchlist_lname_7,key2.rep3_watchlist_address_7,'','','','','','','',key2.rep3_watchlist_city_7,key2.rep3_watchlist_state_7,key2.rep3_watchlist_zip_7,key2.rep3_watchlist_country_7,key2.rep3_watchlist_entity_name_7}
						],
						Risk_Indicators.layouts.layout_watchlists_plus_seq
					)(Watchlist_Table != '');

			SELF := [];
		END;
//rep4	
	BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_buildConsumerInstantID_4 := 
		TRANSFORM
			// i.e. risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno,seq];
      SELF.did              := fn_CreateFakeDID( key1.rep4_firstname, key1.rep4_lastname );
      SELF.rep_whichone     := IF(key1.rep4_firstname <> '' AND key1.rep4_lastname <> '','4','');
      SELF.sequence         := IF(key1.rep4_firstname <> '' AND key1.rep4_lastname <> '','4','');
      SELF.title            := key1.rep4_titlename;
      SELF.fname            := key1.rep4_firstname;
      SELF.mname            := key1.rep4_middlename;
      SELF.lname            := key1.rep4_lastname;
      SELF.in_streetAddress := key1.rep4_addr1;
      SELF.in_city          := key1.rep4_city_name;
      SELF.in_state         := key1.rep4_st;
      SELF.in_zipCode       := key1.rep4_z5;
      SELF.ssn              := key1.rep4_ssn;
      SELF.dob              := key1.rep4_dob;
      SELF.age              := key1.rep4_age;
      SELF.phone10          := key1.rep4_phone10;
      SELF.dl_number        := key1.rep4_dlnumber;
      SELF.dl_state         := key1.rep4_dlstate;
      SELF.email_address    := key1.rep4_email;
			SELF.verfirst	     := key3.rep4_verfirst;
			SELF.verlast	     := key3.rep4_verlast;
			SELF.veraddr	     := key3.rep4_veraddr;
			SELF.vercity	     := key3.rep4_vercity;
			SELF.verstate	     := key3.rep4_verstate;
			SELF.verzip	       := key3.rep4_verzip;
			SELF.verzip4	     := key3.rep4_verzip4;
			SELF.vercounty	   := key3.rep4_vercounty;
			SELF.verssn	       := key3.rep4_verssn;
			SELF.verdob	       := key3.rep4_verdob;
			SELF.verhphone	   := key3.rep4_verhphone;
			SELF.verdl	       := key3.rep4_verdl;
			SELF.verify_addr	 := key3.rep4_verify_addr;
			SELF.verify_dob	   := key3.rep4_verify_dob;
			SELF.valid_ssn	   := key3.rep4_valid_ssn;
			SELF.nas_summary	 := (INTEGER)key3.rep4_nas_summary;
			SELF.nap_summary	 := (INTEGER)key3.rep4_nap_summary;
			SELF.nap_type	     := key3.rep4_nap_type;
			SELF.nap_status	   := key3.rep4_nap_status;
			SELF.cvi	         := key3.rep4_cvi;
			SELF.deceaseddate	 := key3.rep4_deceaseddate;
			SELF.deceaseddob	 := key3.rep4_deceaseddob;
			SELF.deceasedfirst := key3.rep4_deceasedfirst;
			SELF.deceasedlast  := key3.rep4_deceasedlast;
			SELF.dobmatchlevel := key3.rep4_dobmatchlevel;

			SELF.ri := 
					DATASET( 
						[
							{ 1, key3.rep4_hri_1, key3.rep4_hri_desc_1 },
							{ 2, key3.rep4_hri_2, key3.rep4_hri_desc_2 },
							{ 3, key3.rep4_hri_3, key3.rep4_hri_desc_3 },
							{ 4, key3.rep4_hri_4, key3.rep4_hri_desc_4 },
							{ 5, key3.rep4_hri_5, key3.rep4_hri_desc_5 },
							{ 6, key3.rep4_hri_6, key3.rep4_hri_desc_6 },
							{ 7, key3.rep4_hri_7, key3.rep4_hri_desc_7 },
							{ 8, key3.rep4_hri_8, key3.rep4_hri_desc_8 }
						], 
						Risk_Indicators.layouts.layout_desc_plus_seq 
					)(hri != '');

			SELF.fua :=
					DATASET( 
						[
							{ key3.rep4_fua_1, key3.rep4_fua_desc_1 },
							{ key3.rep4_fua_2, key3.rep4_fua_desc_2 },
							{ key3.rep4_fua_3, key3.rep4_fua_desc_3 },
							{ key3.rep4_fua_4, key3.rep4_fua_desc_4 }
						], 
						Risk_Indicators.Layout_Desc 
					)(hri != '');			

			SELF.corrected_lname	    := key3.rep4_corrected_lname;
			SELF.corrected_dob	      := key3.rep4_corrected_dob;
			SELF.corrected_phone	    := key3.rep4_corrected_phone;
			SELF.corrected_ssn	      := key3.rep4_corrected_ssn;
			SELF.corrected_address	  := key3.rep4_corrected_address;
			SELF.area_code_split	    := key3.rep4_area_code_split;
			SELF.area_code_split_date := key3.rep4_area_code_split_date;
			SELF.phone_fname	        := key3.rep4_phone_fname;
			SELF.phone_lname	        := key3.rep4_phone_lname;
			SELF.phone_address	      := key3.rep4_phone_address;
			SELF.phone_city	          := key3.rep4_phone_city;
			SELF.phone_st	            := key3.rep4_phone_st;
			SELF.phone_zip	          := key3.rep4_phone_zip;
			SELF.name_addr_phone	    := key3.rep4_name_addr_phone;
			SELF.ssa_date_first	      := key3.rep4_ssa_date_first;
			SELF.ssa_date_last	      := key3.rep4_ssa_date_last;
			SELF.ssa_state	          := key3.rep4_ssa_state;
			SELF.ssa_state_name	      := key3.rep4_ssa_state_name;
			SELF.current_fname	      := key3.rep4_current_fname;
			SELF.current_lname	      := key3.rep4_current_lname;
			
			SELF.chronology :=
					DATASET(
						[
							{1,key3.rep4_chron_address_1,'','','','','','','',key3.rep4_chron_city_1,key3.rep4_chron_st_1,key3.rep4_chron_zip_1,key3.rep4_chron_zip4_1,key3.rep4_chron_phone_1,key3.rep4_chron_dt_first_seen_1,key3.rep4_chron_dt_last_seen_1,false,''},
							{2,key3.rep4_chron_address_2,'','','','','','','',key3.rep4_chron_city_2,key3.rep4_chron_st_2,key3.rep4_chron_zip_2,key3.rep4_chron_zip4_2,key3.rep4_chron_phone_2,key3.rep4_chron_dt_first_seen_2,key3.rep4_chron_dt_last_seen_2,false,''},
							{3,key3.rep4_chron_address_3,'','','','','','','',key3.rep4_chron_city_3,key3.rep4_chron_st_3,key3.rep4_chron_zip_3,key3.rep4_chron_zip4_3,key3.rep4_chron_phone_3,key3.rep4_chron_dt_first_seen_3,key3.rep4_chron_dt_last_seen_3,false,''}
						],
						Risk_Indicators.Layout_AddressHistory
					)(Address != '');
			
			SELF.Additional_Lname := 
					DATASET(
						[
							{key3.rep4_addl_fname_1,key3.rep4_addl_lname_1,key3.rep4_addl_lname_date_last_1},
							{key3.rep4_addl_fname_2,key3.rep4_addl_lname_2,key3.rep4_addl_lname_date_last_2},
							{key3.rep4_addl_fname_3,key3.rep4_addl_lname_3,key3.rep4_addl_lname_date_last_3}
						],
						Risk_Indicators.Layout_LastNames
					)(lname1 != '');
					
			SELF.addresspobox	           := key3.rep4_addresspobox;
			SELF.addresscmra	           := key3.rep4_addresscmra;
			SELF.watchlist_table	       := key3.rep4_watchlist_table;
			SELF.watchlist_program	     := key3.rep4_watchlist_program;
			SELF.watchlist_record_number := key3.rep4_watchlist_record_number;
			SELF.watchlist_fname	       := key3.rep4_watchlist_fname;
			SELF.watchlist_lname	       := key3.rep4_watchlist_lname;
			SELF.watchlist_address	     := key3.rep4_watchlist_address;
			SELF.watchlist_city	         := key3.rep4_watchlist_city;
			SELF.watchlist_state	       := key3.rep4_watchlist_state;
			SELF.watchlist_zip	         := key3.rep4_watchlist_zip;
			SELF.Watchlist_contry	       := key3.rep4_watchlist_country;
			SELF.watchlist_entity_name	 := key3.rep4_watchlist_entity_name;
			
			SELF.watchlists :=
					DATASET(
						[
							{1,key3.rep4_watchlist_table  ,key3.rep4_watchlist_program  ,key3.rep4_watchlist_record_number  ,key3.rep4_watchlist_fname  ,key3.rep4_watchlist_lname  ,key3.rep4_watchlist_address  ,'','','','','','','',key3.rep4_watchlist_city  ,key3.rep4_watchlist_state  ,key3.rep4_watchlist_zip  ,key3.rep4_watchlist_country  ,key3.rep4_watchlist_entity_name},
							{2,key3.rep4_watchlist_table_2,key3.rep4_watchlist_program_2,key3.rep4_watchlist_record_number_2,key3.rep4_watchlist_fname_2,key3.rep4_watchlist_lname_2,key3.rep4_watchlist_address_2,'','','','','','','',key3.rep4_watchlist_city_2,key3.rep4_watchlist_state_2,key3.rep4_watchlist_zip_2,key3.rep4_watchlist_country_2,key3.rep4_watchlist_entity_name_2},
							{3,key3.rep4_watchlist_table_3,key3.rep4_watchlist_program_3,key3.rep4_watchlist_record_number_3,key3.rep4_watchlist_fname_3,key3.rep4_watchlist_lname_3,key3.rep4_watchlist_address_3,'','','','','','','',key3.rep4_watchlist_city_3,key3.rep4_watchlist_state_3,key3.rep4_watchlist_zip_3,key3.rep4_watchlist_country_3,key3.rep4_watchlist_entity_name_3},
							{4,key3.rep4_watchlist_table_4,key3.rep4_watchlist_program_4,key3.rep4_watchlist_record_number_4,key3.rep4_watchlist_fname_4,key3.rep4_watchlist_lname_4,key3.rep4_watchlist_address_4,'','','','','','','',key3.rep4_watchlist_city_4,key3.rep4_watchlist_state_4,key3.rep4_watchlist_zip_4,key3.rep4_watchlist_country_4,key3.rep4_watchlist_entity_name_4},
							{5,key3.rep4_watchlist_table_5,key3.rep4_watchlist_program_5,key3.rep4_watchlist_record_number_5,key3.rep4_watchlist_fname_5,key3.rep4_watchlist_lname_5,key3.rep4_watchlist_address_5,'','','','','','','',key3.rep4_watchlist_city_5,key3.rep4_watchlist_state_5,key3.rep4_watchlist_zip_5,key3.rep4_watchlist_country_5,key3.rep4_watchlist_entity_name_5},
							{6,key3.rep4_watchlist_table_6,key3.rep4_watchlist_program_6,key3.rep4_watchlist_record_number_6,key3.rep4_watchlist_fname_6,key3.rep4_watchlist_lname_6,key3.rep4_watchlist_address_6,'','','','','','','',key3.rep4_watchlist_city_6,key3.rep4_watchlist_state_6,key3.rep4_watchlist_zip_6,key3.rep4_watchlist_country_6,key3.rep4_watchlist_entity_name_6},
							{7,key3.rep4_watchlist_table_7,key3.rep4_watchlist_program_7,key3.rep4_watchlist_record_number_7,key3.rep4_watchlist_fname_7,key3.rep4_watchlist_lname_7,key3.rep4_watchlist_address_7,'','','','','','','',key3.rep4_watchlist_city_7,key3.rep4_watchlist_state_7,key3.rep4_watchlist_zip_7,key3.rep4_watchlist_country_7,key3.rep4_watchlist_entity_name_7}
						],
						Risk_Indicators.layouts.layout_watchlists_plus_seq
					)(Watchlist_Table != '');

			SELF := [];
		END;;

//rep5	
	BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_buildConsumerInstantID_5 := 
	TRANSFORM
			// i.e. risk_indicators.Layout_InstantID_NuGenPlus AND NOT [acctno,seq];
      SELF.did              := fn_CreateFakeDID( key1.rep5_firstname, key1.rep5_lastname );
      SELF.rep_whichone     := IF(key1.rep5_firstname <> '' AND key1.rep5_lastname <> '','5','');
      SELF.sequence         := IF(key1.rep5_firstname <> '' AND key1.rep5_lastname <> '','5','');
      SELF.title            := key1.rep5_titlename;
      SELF.fname            := key1.rep5_firstname;
      SELF.mname            := key1.rep5_middlename;
      SELF.lname            := key1.rep5_lastname;
      SELF.in_streetAddress := key1.rep5_addr1;
      SELF.in_city          := key1.rep5_city_name;
      SELF.in_state         := key1.rep5_st;
      SELF.in_zipCode       := key1.rep5_z5;
      SELF.ssn              := key1.rep5_ssn;
      SELF.dob              := key1.rep5_dob;
      SELF.age              := key1.rep5_age;
      SELF.phone10          := key1.rep5_phone10;
      SELF.dl_number        := key1.rep5_dlnumber;
      SELF.dl_state         := key1.rep5_dlstate;
      SELF.email_address    := key1.rep5_email;
			SELF.verfirst	     := key3.rep5_verfirst;
			SELF.verlast	     := key3.rep5_verlast;
			SELF.veraddr	     := key3.rep5_veraddr;
			SELF.vercity	     := key3.rep5_vercity;
			SELF.verstate	     := key3.rep5_verstate;
			SELF.verzip	       := key3.rep5_verzip;
			SELF.verzip4	     := key3.rep5_verzip4;
			SELF.vercounty	   := key3.rep5_vercounty;
			SELF.verssn	       := key3.rep5_verssn;
			SELF.verdob	       := key3.rep5_verdob;
			SELF.verhphone	   := key3.rep5_verhphone;
			SELF.verdl	       := key3.rep5_verdl;
			SELF.verify_addr	 := key3.rep5_verify_addr;
			SELF.verify_dob	   := key3.rep5_verify_dob;
			SELF.valid_ssn	   := key3.rep5_valid_ssn;
			SELF.nas_summary	 := (INTEGER)key3.rep5_nas_summary;
			SELF.nap_summary	 := (INTEGER)key3.rep5_nap_summary;
			SELF.nap_type	     := key3.rep5_nap_type;
			SELF.nap_status	   := key3.rep5_nap_status;
			SELF.cvi	         := key3.rep5_cvi;
			SELF.deceaseddate	 := key3.rep5_deceaseddate;
			SELF.deceaseddob	 := key3.rep5_deceaseddob;
			SELF.deceasedfirst := key3.rep5_deceasedfirst;
			SELF.deceasedlast  := key3.rep5_deceasedlast;
			SELF.dobmatchlevel := key3.rep5_dobmatchlevel;

			SELF.ri := 
					DATASET( 
						[
							{ 1, key3.rep5_hri_1, key3.rep5_hri_desc_1 },
							{ 2, key3.rep5_hri_2, key3.rep5_hri_desc_2 },
							{ 3, key3.rep5_hri_3, key3.rep5_hri_desc_3 },
							{ 4, key3.rep5_hri_4, key3.rep5_hri_desc_4 },
							{ 5, key3.rep5_hri_5, key3.rep5_hri_desc_5 },
							{ 6, key3.rep5_hri_6, key3.rep5_hri_desc_6 },
							{ 7, key3.rep5_hri_7, key3.rep5_hri_desc_7 },
							{ 8, key3.rep5_hri_8, key3.rep5_hri_desc_8 }
						], 
						Risk_Indicators.layouts.layout_desc_plus_seq 
					)(hri != '');

			SELF.fua :=
					DATASET( 
						[
							{ key3.rep5_fua_1, key3.rep5_fua_desc_1 },
							{ key3.rep5_fua_2, key3.rep5_fua_desc_2 },
							{ key3.rep5_fua_3, key3.rep5_fua_desc_3 },
							{ key3.rep5_fua_4, key3.rep5_fua_desc_4 }
						], 
						Risk_Indicators.Layout_Desc 
					)(hri != '');			

			SELF.corrected_lname	    := key3.rep5_corrected_lname;
			SELF.corrected_dob	      := key3.rep5_corrected_dob;
			SELF.corrected_phone	    := key3.rep5_corrected_phone;
			SELF.corrected_ssn	      := key3.rep5_corrected_ssn;
			SELF.corrected_address	  := key3.rep5_corrected_address;
			SELF.area_code_split	    := key3.rep5_area_code_split;
			SELF.area_code_split_date := key3.rep5_area_code_split_date;
			SELF.phone_fname	        := key3.rep5_phone_fname;
			SELF.phone_lname	        := key3.rep5_phone_lname;
			SELF.phone_address	      := key3.rep5_phone_address;
			SELF.phone_city	          := key3.rep5_phone_city;
			SELF.phone_st	            := key3.rep5_phone_st;
			SELF.phone_zip	          := key3.rep5_phone_zip;
			SELF.name_addr_phone	    := key3.rep5_name_addr_phone;
			SELF.ssa_date_first	      := key3.rep5_ssa_date_first;
			SELF.ssa_date_last	      := key3.rep5_ssa_date_last;
			SELF.ssa_state	          := key3.rep5_ssa_state;
			SELF.ssa_state_name	      := key3.rep5_ssa_state_name;
			SELF.current_fname	      := key3.rep5_current_fname;
			SELF.current_lname	      := key3.rep5_current_lname;
			
			SELF.chronology :=
					DATASET(
						[
							{1,key3.rep5_chron_address_1,'','','','','','','',key3.rep5_chron_city_1,key3.rep5_chron_st_1,key3.rep5_chron_zip_1,key3.rep5_chron_zip4_1,key3.rep5_chron_phone_1,key3.rep5_chron_dt_first_seen_1,key3.rep5_chron_dt_last_seen_1,false,''},
							{2,key3.rep5_chron_address_2,'','','','','','','',key3.rep5_chron_city_2,key3.rep5_chron_st_2,key3.rep5_chron_zip_2,key3.rep5_chron_zip4_2,key3.rep5_chron_phone_2,key3.rep5_chron_dt_first_seen_2,key3.rep5_chron_dt_last_seen_2,false,''},
							{3,key3.rep5_chron_address_3,'','','','','','','',key3.rep5_chron_city_3,key3.rep5_chron_st_3,key3.rep5_chron_zip_3,key3.rep5_chron_zip4_3,key3.rep5_chron_phone_3,key3.rep5_chron_dt_first_seen_3,key3.rep5_chron_dt_last_seen_3,false,''}
						],
						Risk_Indicators.Layout_AddressHistory
					)(Address != '');
			
			SELF.Additional_Lname := 
					DATASET(
						[
							{key3.rep5_addl_fname_1,key3.rep5_addl_lname_1,key3.rep5_addl_lname_date_last_1},
							{key3.rep5_addl_fname_2,key3.rep5_addl_lname_2,key3.rep5_addl_lname_date_last_2},
							{key3.rep5_addl_fname_3,key3.rep5_addl_lname_3,key3.rep5_addl_lname_date_last_3}
						],
						Risk_Indicators.Layout_LastNames
					)(lname1 != '');
					
			SELF.addresspobox	           := key3.rep5_addresspobox;
			SELF.addresscmra	           := key3.rep5_addresscmra;
			SELF.watchlist_table	       := key3.rep5_watchlist_table;
			SELF.watchlist_program	     := key3.rep5_watchlist_program;
			SELF.watchlist_record_number := key3.rep5_watchlist_record_number;
			SELF.watchlist_fname	       := key3.rep5_watchlist_fname;
			SELF.watchlist_lname	       := key3.rep5_watchlist_lname;
			SELF.watchlist_address	     := key3.rep5_watchlist_address;
			SELF.watchlist_city	         := key3.rep5_watchlist_city;
			SELF.watchlist_state	       := key3.rep5_watchlist_state;
			SELF.watchlist_zip	         := key3.rep5_watchlist_zip;
			SELF.Watchlist_contry	     := key3.rep5_watchlist_country;
			SELF.watchlist_entity_name	 := key3.rep5_watchlist_entity_name;
			
			SELF.watchlists :=
					DATASET(
						[
							{1,key3.rep5_watchlist_table  ,key3.rep5_watchlist_program  ,key3.rep5_watchlist_record_number  ,key3.rep5_watchlist_fname  ,key3.rep5_watchlist_lname  ,key3.rep5_watchlist_address  ,'','','','','','','',key3.rep5_watchlist_city  ,key3.rep5_watchlist_state  ,key3.rep5_watchlist_zip  ,key3.rep5_watchlist_country  ,key3.rep5_watchlist_entity_name},
							{2,key3.rep5_watchlist_table_2,key3.rep5_watchlist_program_2,key3.rep5_watchlist_record_number_2,key3.rep5_watchlist_fname_2,key3.rep5_watchlist_lname_2,key3.rep5_watchlist_address_2,'','','','','','','',key3.rep5_watchlist_city_2,key3.rep5_watchlist_state_2,key3.rep5_watchlist_zip_2,key3.rep5_watchlist_country_2,key3.rep5_watchlist_entity_name_2},
							{3,key3.rep5_watchlist_table_3,key3.rep5_watchlist_program_3,key3.rep5_watchlist_record_number_3,key3.rep5_watchlist_fname_3,key3.rep5_watchlist_lname_3,key3.rep5_watchlist_address_3,'','','','','','','',key3.rep5_watchlist_city_3,key3.rep5_watchlist_state_3,key3.rep5_watchlist_zip_3,key3.rep5_watchlist_country_3,key3.rep5_watchlist_entity_name_3},
							{4,key3.rep5_watchlist_table_4,key3.rep5_watchlist_program_4,key3.rep5_watchlist_record_number_4,key3.rep5_watchlist_fname_4,key3.rep5_watchlist_lname_4,key3.rep5_watchlist_address_4,'','','','','','','',key3.rep5_watchlist_city_4,key3.rep5_watchlist_state_4,key3.rep5_watchlist_zip_4,key3.rep5_watchlist_country_4,key3.rep5_watchlist_entity_name_4},
							{5,key3.rep5_watchlist_table_5,key3.rep5_watchlist_program_5,key3.rep5_watchlist_record_number_5,key3.rep5_watchlist_fname_5,key3.rep5_watchlist_lname_5,key3.rep5_watchlist_address_5,'','','','','','','',key3.rep5_watchlist_city_5,key3.rep5_watchlist_state_5,key3.rep5_watchlist_zip_5,key3.rep5_watchlist_country_5,key3.rep5_watchlist_entity_name_5},
							{6,key3.rep5_watchlist_table_6,key3.rep5_watchlist_program_6,key3.rep5_watchlist_record_number_6,key3.rep5_watchlist_fname_6,key3.rep5_watchlist_lname_6,key3.rep5_watchlist_address_6,'','','','','','','',key3.rep5_watchlist_city_6,key3.rep5_watchlist_state_6,key3.rep5_watchlist_zip_6,key3.rep5_watchlist_country_6,key3.rep5_watchlist_entity_name_6},
							{7,key3.rep5_watchlist_table_7,key3.rep5_watchlist_program_7,key3.rep5_watchlist_record_number_7,key3.rep5_watchlist_fname_7,key3.rep5_watchlist_lname_7,key3.rep5_watchlist_address_7,'','','','','','','',key3.rep5_watchlist_city_7,key3.rep5_watchlist_state_7,key3.rep5_watchlist_zip_7,key3.rep5_watchlist_country_7,key3.rep5_watchlist_entity_name_7}
						],
						Risk_Indicators.layouts.layout_watchlists_plus_seq
					)(Watchlist_Table != '');

			SELF := [];
		END;
  
	ConsumerInstantID_1 := DATASET( [xfm_buildConsumerInstantID_1] ); 
	ConsumerInstantID_2 := DATASET( [xfm_buildConsumerInstantID_2] );
	ConsumerInstantID_3 := DATASET( [xfm_buildConsumerInstantID_3] );
	ConsumerInstantID_4 := DATASET( [xfm_buildConsumerInstantID_4] );
	ConsumerInstantID_5 := DATASET( [xfm_buildConsumerInstantID_5] );
	
  
	BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_toIntermediateLayout :=
		TRANSFORM
			buildConsumerInstantIDDataset := (ConsumerInstantID_1 + ConsumerInstantID_2 + ConsumerInstantID_3 + ConsumerInstantID_4 + ConsumerInstantID_5)(lname != '');
				
			SELF.seq	 	                 	         := key1.seq;
			SELF.InputEcho.seq	 	                 := key1.seq;
			SELF.InputEcho.acctno	                 := key1.AcctNo;
			SELF.InputEcho.transaction_id	       	 := key1.transaction_id;
			SELF.InputEcho.NumberValidAuthRepsInput:= key1.numbervalidauthrepsinput;
			SELF.InputEcho.in_bus_name           	 := key1.bus_company_name;
			SELF.InputEcho.in_bus_alternatename  	 := key1.bus_alt_company_name;
			SELF.InputEcho.in_bus_streetaddress1 	 := key1.bus_addr1;
			SELF.InputEcho.in_bus_streetaddress2 	 := key1.bus_addr2;
			SELF.InputEcho.in_bus_city           	 := key1.bus_city_name;
			SELF.InputEcho.in_bus_state          	 := key1.bus_st;
			SELF.InputEcho.in_bus_zip            	 := key1.bus_z5;
			SELF.InputEcho.in_bus_fein           	 := key1.bus_fein;
			SELF.InputEcho.in_bus_phone10        	 := key1.bus_phone10;
			SELF.InputEcho.in_bus_fax            	 := key1.bus_fax;
			SELF.InputEcho.in_bus_ipaddr         	 := key1.bus_ipaddr;
			SELF.InputEcho.in_bus_url            	 := key1.bus_url;
      SELF.InputEcho.rep1_lexid              := fn_CreateFakeDID( key1.rep1_firstname, key1.rep1_lastname );
			// SELF.InputEcho.in_rep1_sequence        := key1.rep1_sequence;
      SELF.InputEcho.in_rep1_title         	 := key1.rep1_titlename;
			SELF.InputEcho.in_rep1_full          	 := key1.rep1_fullname;
			SELF.InputEcho.in_rep1_first         	 := key1.rep1_firstname;
			SELF.InputEcho.in_rep1_middle        	 := key1.rep1_middlename;
			SELF.InputEcho.in_rep1_last          	 := key1.rep1_lastname;
			SELF.InputEcho.in_rep1_streetaddress1	 := key1.rep1_addr1;
			SELF.InputEcho.in_rep1_streetaddress2	 := key1.rep1_addr2;
			SELF.InputEcho.in_rep1_city          	 := key1.rep1_city_name;
			SELF.InputEcho.in_rep1_state         	 := key1.rep1_st;
			SELF.InputEcho.in_rep1_zip           	 := key1.rep1_z5;
			SELF.InputEcho.in_rep1_ssn           	 := key1.rep1_ssn;
			SELF.InputEcho.in_rep1_dob           	 := key1.rep1_dob;
			SELF.InputEcho.in_rep1_age           	 := key1.rep1_age;
			SELF.InputEcho.in_rep1_phone10       	 := key1.rep1_phone10;
			SELF.InputEcho.in_rep1_dlnumber      	 := key1.rep1_dlnumber;
			SELF.InputEcho.in_rep1_dlstate       	 := key1.rep1_dlstate;
			SELF.InputEcho.in_rep1_email         	 := key1.rep1_email;
      SELF.InputEcho.rep2_lexid              := fn_CreateFakeDID( key1.rep2_firstname, key1.rep2_lastname );
			// SELF.InputEcho.in_rep2_sequence        := key1.rep2_sequence;
			SELF.InputEcho.in_rep2_title         	 := key1.rep2_titlename;
			SELF.InputEcho.in_rep2_full          	 := key1.rep2_fullname;
			SELF.InputEcho.in_rep2_first         	 := key1.rep2_firstname;
			SELF.InputEcho.in_rep2_middle        	 := key1.rep2_middlename;
			SELF.InputEcho.in_rep2_last          	 := key1.rep2_lastname;
			SELF.InputEcho.in_rep2_streetaddress1	 := key1.rep2_addr1;
			SELF.InputEcho.in_rep2_streetaddress2	 := key1.rep2_addr2;
			SELF.InputEcho.in_rep2_city          	 := key1.rep2_city_name;
			SELF.InputEcho.in_rep2_state         	 := key1.rep2_st;
			SELF.InputEcho.in_rep2_zip           	 := key1.rep2_z5;
			SELF.InputEcho.in_rep2_ssn           	 := key1.rep2_ssn;
			SELF.InputEcho.in_rep2_dob           	 := key1.rep2_dob;
			SELF.InputEcho.in_rep2_age           	 := key1.rep2_age;
			SELF.InputEcho.in_rep2_phone10       	 := key1.rep2_phone10;
			SELF.InputEcho.in_rep2_dlnumber      	 := key1.rep2_dlnumber;
			SELF.InputEcho.in_rep2_dlstate       	 := key1.rep2_dlstate;
			SELF.InputEcho.in_rep2_email         	 := key1.rep2_email;
      SELF.InputEcho.rep3_lexid              := fn_CreateFakeDID( key1.rep3_firstname, key1.rep3_lastname );
			// SELF.InputEcho.in_rep3_sequence        := key1.rep3_sequence;
			SELF.InputEcho.in_rep3_title         	 := key1.rep3_titlename;
			SELF.InputEcho.in_rep3_full          	 := key1.rep3_fullname;
			SELF.InputEcho.in_rep3_first         	 := key1.rep3_firstname;
			SELF.InputEcho.in_rep3_middle        	 := key1.rep3_middlename;
			SELF.InputEcho.in_rep3_last          	 := key1.rep3_lastname;
			SELF.InputEcho.in_rep3_streetaddress1	 := key1.rep3_addr1;
			SELF.InputEcho.in_rep3_streetaddress2	 := key1.rep3_addr2;
			SELF.InputEcho.in_rep3_city          	 := key1.rep3_city_name;
			SELF.InputEcho.in_rep3_state         	 := key1.rep3_st;
			SELF.InputEcho.in_rep3_zip           	 := key1.rep3_z5;
			SELF.InputEcho.in_rep3_ssn           	 := key1.rep3_ssn;
			SELF.InputEcho.in_rep3_dob           	 := key1.rep3_dob;
			SELF.InputEcho.in_rep3_age           	 := key1.rep3_age;
			SELF.InputEcho.in_rep3_phone10       	 := key1.rep3_phone10;
			SELF.InputEcho.in_rep3_dlnumber      	 := key1.rep3_dlnumber;
			SELF.InputEcho.in_rep3_dlstate       	 := key1.rep3_dlstate;
			SELF.InputEcho.in_rep3_email         	 := key1.rep3_email;
      SELF.InputEcho.rep4_lexid              := fn_CreateFakeDID( key1.rep4_firstname, key1.rep4_lastname );
			// SELF.InputEcho.in_rep4_sequence        := key1.rep4_sequence;
			SELF.InputEcho.in_rep4_title         	 := key1.rep4_titlename;
			SELF.InputEcho.in_rep4_full          	 := key1.rep4_fullname;
			SELF.InputEcho.in_rep4_first         	 := key1.rep4_firstname;
			SELF.InputEcho.in_rep4_middle        	 := key1.rep4_middlename;
			SELF.InputEcho.in_rep4_last          	 := key1.rep4_lastname;
			SELF.InputEcho.in_rep4_streetaddress1	 := key1.rep4_addr1;
			SELF.InputEcho.in_rep4_streetaddress2	 := key1.rep4_addr2;
			SELF.InputEcho.in_rep4_city          	 := key1.rep4_city_name;
			SELF.InputEcho.in_rep4_state         	 := key1.rep4_st;
			SELF.InputEcho.in_rep4_zip           	 := key1.rep4_z5;
			SELF.InputEcho.in_rep4_ssn           	 := key1.rep4_ssn;
			SELF.InputEcho.in_rep4_dob           	 := key1.rep4_dob;
			SELF.InputEcho.in_rep4_age           	 := key1.rep4_age;
			SELF.InputEcho.in_rep4_phone10       	 := key1.rep4_phone10;
			SELF.InputEcho.in_rep4_dlnumber      	 := key1.rep4_dlnumber;
			SELF.InputEcho.in_rep4_dlstate       	 := key1.rep4_dlstate;
			SELF.InputEcho.in_rep4_email         	 := key1.rep4_email;
      SELF.InputEcho.rep5_lexid              := fn_CreateFakeDID( key1.rep5_firstname, key1.rep5_lastname );
			// SELF.InputEcho.in_rep5_sequence        := key1.rep5_sequence;
			SELF.InputEcho.in_rep5_title         	 := key1.rep5_titlename;
			SELF.InputEcho.in_rep5_full          	 := key1.rep5_fullname;
			SELF.InputEcho.in_rep5_first         	 := key1.rep5_firstname;
			SELF.InputEcho.in_rep5_middle        	 := key1.rep5_middlename;
			SELF.InputEcho.in_rep5_last          	 := key1.rep5_lastname;
			SELF.InputEcho.in_rep5_streetaddress1	 := key1.rep5_addr1;
			SELF.InputEcho.in_rep5_streetaddress2	 := key1.rep5_addr2;
			SELF.InputEcho.in_rep5_city          	 := key1.rep5_city_name;
			SELF.InputEcho.in_rep5_state         	 := key1.rep5_st;
			SELF.InputEcho.in_rep5_zip           	 := key1.rep5_z5;
			SELF.InputEcho.in_rep5_ssn           	 := key1.rep5_ssn;
			SELF.InputEcho.in_rep5_dob           	 := key1.rep5_dob;
			SELF.InputEcho.in_rep5_age           	 := key1.rep5_age;
			SELF.InputEcho.in_rep5_phone10       	 := key1.rep5_phone10;
			SELF.InputEcho.in_rep5_dlnumber      	 := key1.rep5_dlnumber;
			SELF.InputEcho.in_rep5_dlstate       	 := key1.rep5_dlstate;
			SELF.InputEcho.in_rep5_email         	 := key1.rep5_email;
			
			SELF.VerifiedEcho.bus_ver_name 	 := key1.vercmpy;
			SELF.VerifiedEcho.bus_ver_addr 	 := key1.veraddr;
			SELF.VerifiedEcho.bus_ver_city 	 := key1.vercity;
			SELF.VerifiedEcho.bus_ver_state	 := key1.verstate;
			SELF.VerifiedEcho.bus_ver_zip  	 := key1.verzip;
			SELF.VerifiedEcho.bus_ver_phone	 := key1.verphone;
			SELF.VerifiedEcho.bus_ver_tin	   := key1.verfein;
			
			SELF.Verification.ver_name_indicator      	 := IF( TRIM(key1.vercmpy)  != '', '1', '0' );
      SELF.Verification.ver_altname_indicator      := '0';
			SELF.Verification.ver_streetaddr_indicator	 := IF( TRIM(key1.veraddr)  != '', '1', '0' );
			SELF.Verification.ver_city_indicator      	 := IF( TRIM(key1.vercity)  != '', '1', '0' );
			SELF.Verification.ver_state_indicator     	 := IF( TRIM(key1.verstate) != '', '1', '0' );
			SELF.Verification.ver_zip_indicator       	 := IF( TRIM(key1.verzip)   != '', '1', '0' );
			SELF.Verification.ver_phone_indicator	       := IF( TRIM(key1.verphone) != '', '1', '0' );
			SELF.Verification.ver_tin_indicator	         := IF( TRIM(key1.verfein)  != '', '1', '0' );
			
			SELF.BestEcho.best_bus_name	   := key1.bestcompanyname;
			SELF.BestEcho.best_bus_addr 	 := key1.bestaddr;
			SELF.BestEcho.best_bus_city 	 := key1.bestcity;
			SELF.BestEcho.best_bus_state	 := key1.beststate;
			SELF.BestEcho.best_bus_zip  	 := key1.bestzip;
			SELF.BestEcho.best_bus_zip4 	 := key1.bestzip4;
			SELF.BestEcho.best_bus_phone	 := key1.bestphone;
			SELF.BestEcho.best_bus_fein 	 := key1.bestfein;
			
			SELF.InputEcho.ultid 	 := key1.ultid;
			SELF.InputEcho.orgid 	 := key1.orgid;
			SELF.InputEcho.seleid	 := key1.seleid;
			SELF.InputEcho.proxid	 := key1.proxid;
			SELF.InputEcho.powid 	 := key1.powid;
			
			SELF.VerificationSummaries.bvi     	 := key1.bvi;
			SELF.VerificationSummaries.bvi_desc	 := key1.bvi_desc;
			
			SELF.RiskIndicators.bus_ri_1     	 := IF( TRIM(key1.bus_ri_1) = '', '00', key1.bus_ri_1 );
			SELF.RiskIndicators.bus_ri_desc_1	 := key1.bus_ri_desc_1;
			SELF.RiskIndicators.bus_ri_2     	 := IF( TRIM(key1.bus_ri_2) = '', '00', key1.bus_ri_2 );
			SELF.RiskIndicators.bus_ri_desc_2	 := key1.bus_ri_desc_2;
			SELF.RiskIndicators.bus_ri_3     	 := IF( TRIM(key1.bus_ri_3) = '', '00', key1.bus_ri_3 );
			SELF.RiskIndicators.bus_ri_desc_3	 := key1.bus_ri_desc_3;
			SELF.RiskIndicators.bus_ri_4     	 := IF( TRIM(key1.bus_ri_4) = '', '00', key1.bus_ri_4 );
			SELF.RiskIndicators.bus_ri_desc_4	 := key1.bus_ri_desc_4;
			SELF.RiskIndicators.bus_ri_5     	 := IF( TRIM(key1.bus_ri_5) = '', '00', key1.bus_ri_5 );
			SELF.RiskIndicators.bus_ri_desc_5	 := key1.bus_ri_desc_5;
			SELF.RiskIndicators.bus_ri_6     	 := IF( TRIM(key1.bus_ri_6) = '', '00', key1.bus_ri_6 );
			SELF.RiskIndicators.bus_ri_desc_6	 := key1.bus_ri_desc_6;
			SELF.RiskIndicators.bus_ri_7     	 := IF( TRIM(key1.bus_ri_7) = '', '00', key1.bus_ri_7 );
			SELF.RiskIndicators.bus_ri_desc_7	 := key1.bus_ri_desc_7;
			SELF.RiskIndicators.bus_ri_8     	 := IF( TRIM(key1.bus_ri_8) = '', '00', key1.bus_ri_8 );
			SELF.RiskIndicators.bus_ri_desc_8	 := key1.bus_ri_desc_8;
			
			SELF.Bus2Exec.bus2exec_index_rep1	 := key1.bus2exec_index_rep1;
			SELF.Bus2Exec.bus2exec_desc_rep1 	 := key1.bus2exec_desc_rep1;
			SELF.Bus2Exec.bus2exec_index_rep2	 := key1.bus2exec_index_rep2;
			SELF.Bus2Exec.bus2exec_desc_rep2 	 := key1.bus2exec_desc_rep2;
			SELF.Bus2Exec.bus2exec_index_rep3	 := key1.bus2exec_index_rep3;
			SELF.Bus2Exec.bus2exec_desc_rep3 	 := key1.bus2exec_desc_rep3;
			SELF.Bus2Exec.bus2exec_index_rep4	 := key1.bus2exec_index_rep4;
			SELF.Bus2Exec.bus2exec_desc_rep4 	 := key1.bus2exec_desc_rep4;
			SELF.Bus2Exec.bus2exec_index_rep5	 := key1.bus2exec_index_rep5;
			SELF.Bus2Exec.bus2exec_desc_rep5 	 := key1.bus2exec_desc_rep5;
			
			SELF.ResidentialBus.residential_bus_indicator	 := key1.residential_bus_indicator;
			SELF.ResidentialBus.residential_bus_desc     	 := key1.residential_bus_desc;
			
			SELF.VerificationSummaries.ver_phone_src_index          	 := key1.phone_verification;
			SELF.VerificationSummaries.ver_phone_desc               	 := key1.phone_ver_desc;
			SELF.VerificationSummaries.ver_bureau_src_index         	 := key1.bureau_verification;
			SELF.VerificationSummaries.ver_bureau_desc              	 := key1.bureau_ver_desc;
			SELF.VerificationSummaries.ver_govt_reg_src_index       	 := key1.govt_reg_verification;
			SELF.VerificationSummaries.ver_govt_reg_desc            	 := key1.govt_reg_ver_desc;
			SELF.VerificationSummaries.ver_pubrec_filing_src_index  	 := key1.pubrec_filings_verification;
			SELF.VerificationSummaries.ver_pubrec_filing_desc       	 := key1.pubrec_filings_ver_desc;
			SELF.VerificationSummaries.ver_bus_directories_src_index	 := key1.bus_directories_verification;
			SELF.VerificationSummaries.ver_bus_directories_desc     	 := key1.bus_directories_ver_desc;
			
			SELF.BusinessByPhone.bus_phone_match_company_1   	 := key1.bus_phone_match_company_1;
			SELF.BusinessByPhone.bus_phone_match_prim_range_1	 := key1.bus_phone_match_prim_range_1;
			SELF.BusinessByPhone.bus_phone_match_predir_1    	 := key1.bus_phone_match_predir_1;
			SELF.BusinessByPhone.bus_phone_match_prim_name_1 	 := key1.bus_phone_match_prim_name_1;
			SELF.BusinessByPhone.bus_phone_match_suffix_1    	 := key1.bus_phone_match_suffix_1;
			SELF.BusinessByPhone.bus_phone_match_postdir_1   	 := key1.bus_phone_match_postdir_1;
			SELF.BusinessByPhone.bus_phone_match_unit_desig_1	 := key1.bus_phone_match_unit_desig_1;
			SELF.BusinessByPhone.bus_phone_match_sec_range_1 	 := key1.bus_phone_match_sec_range_1;
			SELF.BusinessByPhone.bus_phone_match_addr_1      	 := key1.bus_phone_match_addr_1;
			SELF.BusinessByPhone.bus_phone_match_city_1      	 := key1.bus_phone_match_city_1;
			SELF.BusinessByPhone.bus_phone_match_state_1     	 := key1.bus_phone_match_state_1;
			SELF.BusinessByPhone.bus_phone_match_zip_1       	 := key1.bus_phone_match_zip_1;
			SELF.BusinessByPhone.bus_phone_match_zip4_1      	 := key1.bus_phone_match_zip4_1;
			SELF.BusinessByPhone.bus_phone_match_company_2   	 := key1.bus_phone_match_company_2;
			SELF.BusinessByPhone.bus_phone_match_prim_range_2	 := key1.bus_phone_match_prim_range_2;
			SELF.BusinessByPhone.bus_phone_match_predir_2    	 := key1.bus_phone_match_predir_2;
			SELF.BusinessByPhone.bus_phone_match_prim_name_2 	 := key1.bus_phone_match_prim_name_2;
			SELF.BusinessByPhone.bus_phone_match_suffix_2    	 := key1.bus_phone_match_suffix_2;
			SELF.BusinessByPhone.bus_phone_match_postdir_2   	 := key1.bus_phone_match_postdir_2;
			SELF.BusinessByPhone.bus_phone_match_unit_desig_2	 := key1.bus_phone_match_unit_desig_2;
			SELF.BusinessByPhone.bus_phone_match_sec_range_2 	 := key1.bus_phone_match_sec_range_2;
			SELF.BusinessByPhone.bus_phone_match_addr_2      	 := key1.bus_phone_match_addr_2;
			SELF.BusinessByPhone.bus_phone_match_city_2      	 := key1.bus_phone_match_city_2;
			SELF.BusinessByPhone.bus_phone_match_state_2     	 := key1.bus_phone_match_state_2;
			SELF.BusinessByPhone.bus_phone_match_zip_2       	 := key1.bus_phone_match_zip_2;
			SELF.BusinessByPhone.bus_phone_match_zip4_2      	 := key1.bus_phone_match_zip4_2;
			SELF.BusinessByPhone.bus_phone_match_company_3   	 := key1.bus_phone_match_company_3;
			SELF.BusinessByPhone.bus_phone_match_prim_range_3	 := key1.bus_phone_match_prim_range_3;
			SELF.BusinessByPhone.bus_phone_match_predir_3    	 := key1.bus_phone_match_predir_3;
			SELF.BusinessByPhone.bus_phone_match_prim_name_3 	 := key1.bus_phone_match_prim_name_3;
			SELF.BusinessByPhone.bus_phone_match_suffix_3    	 := key1.bus_phone_match_suffix_3;
			SELF.BusinessByPhone.bus_phone_match_postdir_3   	 := key1.bus_phone_match_postdir_3;
			SELF.BusinessByPhone.bus_phone_match_unit_desig_3	 := key1.bus_phone_match_unit_desig_3;
			SELF.BusinessByPhone.bus_phone_match_sec_range_3 	 := key1.bus_phone_match_sec_range_3;
			SELF.BusinessByPhone.bus_phone_match_addr_3      	 := key1.bus_phone_match_addr_3;
			SELF.BusinessByPhone.bus_phone_match_city_3      	 := key1.bus_phone_match_city_3;
			SELF.BusinessByPhone.bus_phone_match_state_3     	 := key1.bus_phone_match_state_3;
			SELF.BusinessByPhone.bus_phone_match_zip_3       	 := key1.bus_phone_match_zip_3;
			SELF.BusinessByPhone.bus_phone_match_zip4_3      	 := key1.bus_phone_match_zip4_3;
			
			SELF.PhonesByAddress.bus_addr_match_phone_1	 := key1.bus_addr_match_phone_1;
			SELF.PhonesByAddress.bus_addr_match_phone_2	 := key1.bus_addr_match_phone_2;
			SELF.PhonesByAddress.bus_addr_match_phone_3	 := key1.bus_addr_match_phone_3;
			
			SELF.BusinessByFEIN.bus_fein_match_company_1   	 := key1.bus_fein_match_company_1;
			SELF.BusinessByFEIN.bus_fein_match_prim_range_1	 := key1.bus_fein_match_prim_range_1;
			SELF.BusinessByFEIN.bus_fein_match_predir_1    	 := key1.bus_fein_match_predir_1;
			SELF.BusinessByFEIN.bus_fein_match_prim_name_1 	 := key1.bus_fein_match_prim_name_1;
			SELF.BusinessByFEIN.bus_fein_match_suffix_1    	 := key1.bus_fein_match_suffix_1;
			SELF.BusinessByFEIN.bus_fein_match_postdir_1   	 := key1.bus_fein_match_postdir_1;
			SELF.BusinessByFEIN.bus_fein_match_unit_desig_1	 := key1.bus_fein_match_unit_desig_1;
			SELF.BusinessByFEIN.bus_fein_match_sec_range_1 	 := key1.bus_fein_match_sec_range_1;
			SELF.BusinessByFEIN.bus_fein_match_addr_1      	 := key1.bus_fein_match_addr_1;
			SELF.BusinessByFEIN.bus_fein_match_city_1      	 := key1.bus_fein_match_city_1;
			SELF.BusinessByFEIN.bus_fein_match_state_1     	 := key1.bus_fein_match_state_1;
			SELF.BusinessByFEIN.bus_fein_match_zip_1       	 := key1.bus_fein_match_zip_1;
			SELF.BusinessByFEIN.bus_fein_match_zip4_1      	 := key1.bus_fein_match_zip4_1;
			SELF.BusinessByFEIN.bus_fein_match_company_2   	 := key1.bus_fein_match_company_2;
			SELF.BusinessByFEIN.bus_fein_match_prim_range_2	 := key1.bus_fein_match_prim_range_2;
			SELF.BusinessByFEIN.bus_fein_match_predir_2    	 := key1.bus_fein_match_predir_2;
			SELF.BusinessByFEIN.bus_fein_match_prim_name_2 	 := key1.bus_fein_match_prim_name_2;
			SELF.BusinessByFEIN.bus_fein_match_suffix_2    	 := key1.bus_fein_match_suffix_2;
			SELF.BusinessByFEIN.bus_fein_match_postdir_2   	 := key1.bus_fein_match_postdir_2;
			SELF.BusinessByFEIN.bus_fein_match_unit_desig_2	 := key1.bus_fein_match_unit_desig_2;
			SELF.BusinessByFEIN.bus_fein_match_sec_range_2 	 := key1.bus_fein_match_sec_range_2;
			SELF.BusinessByFEIN.bus_fein_match_addr_2      	 := key1.bus_fein_match_addr_2;
			SELF.BusinessByFEIN.bus_fein_match_city_2      	 := key1.bus_fein_match_city_2;
			SELF.BusinessByFEIN.bus_fein_match_state_2     	 := key1.bus_fein_match_state_2;
			SELF.BusinessByFEIN.bus_fein_match_zip_2       	 := key1.bus_fein_match_zip_2;
			SELF.BusinessByFEIN.bus_fein_match_zip4_2      	 := key1.bus_fein_match_zip4_2;
			SELF.BusinessByFEIN.bus_fein_match_company_3   	 := key1.bus_fein_match_company_3;
			SELF.BusinessByFEIN.bus_fein_match_prim_range_3	 := key1.bus_fein_match_prim_range_3;
			SELF.BusinessByFEIN.bus_fein_match_predir_3    	 := key1.bus_fein_match_predir_3;
			SELF.BusinessByFEIN.bus_fein_match_prim_name_3 	 := key1.bus_fein_match_prim_name_3;
			SELF.BusinessByFEIN.bus_fein_match_suffix_3    	 := key1.bus_fein_match_suffix_3;
			SELF.BusinessByFEIN.bus_fein_match_postdir_3   	 := key1.bus_fein_match_postdir_3;
			SELF.BusinessByFEIN.bus_fein_match_unit_desig_3	 := key1.bus_fein_match_unit_desig_3;
			SELF.BusinessByFEIN.bus_fein_match_sec_range_3 	 := key1.bus_fein_match_sec_range_3;
			SELF.BusinessByFEIN.bus_fein_match_addr_3      	 := key1.bus_fein_match_addr_3;
			SELF.BusinessByFEIN.bus_fein_match_city_3      	 := key1.bus_fein_match_city_3;
			SELF.BusinessByFEIN.bus_fein_match_state_3     	 := key1.bus_fein_match_state_3;
			SELF.BusinessByFEIN.bus_fein_match_zip_3       	 := key1.bus_fein_match_zip_3;
			SELF.BusinessByFEIN.bus_fein_match_zip4_3      	 := key1.bus_fein_match_zip4_3;

			
			SELF.Firmographic.ln_status	           := IF( isComplianceVersion, key1.ln_status, '' );
			SELF.Firmographic.sos_status	         := IF( isComplianceVersion, key1.sos_status, '' );
			SELF.Firmographic.sos_filing_name	     := IF( isComplianceVersion, key1.sos_filing_name, '' );
			SELF.Firmographic.time_on_sos	         := IF( isComplianceVersion, key1.time_on_sos, '' );
			
			SELF.BestEcho.best_sic_code	           := IF( isComplianceVersion, key1.sic, '' );
			SELF.BestEcho.best_sic_desc	           := IF( isComplianceVersion, key1.sic_desc, '' );
			SELF.BestEcho.best_naics_code	         := IF( isComplianceVersion, key1.naics, '' );
			SELF.BestEcho.best_naics_desc	         := IF( isComplianceVersion, key1.naics_desc, '' );
			
			SELF.Firmographic.Bus_firstseen_YYYY	 := IF( isComplianceVersion, key1.bus_firstseen_yyyy, '' );
			SELF.Firmographic.time_on_publicrecord := IF( isComplianceVersion, key1.time_on_publicrecord, '' );
			SELF.Firmographic.bus_description	     := IF( isComplianceVersion, key1.bus_description, '' );
			SELF.Firmographic.bus_county	         := IF( isComplianceVersion, key1.bus_county, '' );
			
			SELF.PersonRole.person_role_rep1	     := IF( isComplianceVersion, key1.rep1_title, '' );
			SELF.PersonRole.person_role_rep2	     := IF( isComplianceVersion, key1.rep2_title, '' );
			SELF.PersonRole.person_role_rep3	     := IF( isComplianceVersion, key1.rep3_title, '' );
			SELF.PersonRole.person_role_rep4	     := IF( isComplianceVersion, key1.rep4_title, '' );
			SELF.PersonRole.person_role_rep5	     := IF( isComplianceVersion, key1.rep5_title, '' );
			
			SELF.Parent.parent_seleid	                   := key1.parent_seleid;
			SELF.Parent.parent_best_bus_name	           := key1.parent_best_bus_name;
			SELF.SBFEVerification.time_on_sbfe        	 := IF( isCompliancePlusSBFEVersion AND Options.useSBFE, key1.time_on_sbfe, '' );
			SELF.SBFEVerification.last_seen_sbfe      	 := IF( isCompliancePlusSBFEVersion AND Options.useSBFE, key1.last_seen_sbfe, '' );
			SELF.SBFEVerification.count_of_trades_sbfe	 := IF( isCompliancePlusSBFEVersion AND Options.useSBFE, key1.count_of_trades_sbfe, '' );
			
			SELF.OFAC.bus_ofac_table_1        	 := key1.bus_watchlist_table_1;
			SELF.OFAC.bus_ofac_program_1      	 := key1.bus_watchlist_program_1;
			SELF.OFAC.bus_ofac_record_number_1	 := key1.bus_watchlist_record_number_1;
			SELF.OFAC.bus_ofac_companyname_1  	 := key1.bus_watchlist_companyname_1;
			SELF.OFAC.bus_ofac_address_1      	 := key1.bus_watchlist_address_1;
			SELF.OFAC.bus_ofac_city_1         	 := key1.bus_watchlist_city_1;
			SELF.OFAC.bus_ofac_state_1        	 := key1.bus_watchlist_state_1;
			SELF.OFAC.bus_ofac_zip_1          	 := key1.bus_watchlist_zip_1;
			SELF.OFAC.bus_ofac_country_1      	 := key1.bus_watchlist_country_1;
			SELF.OFAC.bus_ofac_entity_name_1  	 := key1.bus_watchlist_entity_name_1;
			SELF.OFAC.bus_ofac_sequence_1     	 := key1.bus_watchlist_sequence_1;
			SELF.OFAC.bus_ofac_table_2        	 := key1.bus_watchlist_table_2;
			SELF.OFAC.bus_ofac_program_2      	 := key1.bus_watchlist_program_2;
			SELF.OFAC.bus_ofac_record_number_2	 := key1.bus_watchlist_record_number_2;
			SELF.OFAC.bus_ofac_companyname_2  	 := key1.bus_watchlist_companyname_2;
			SELF.OFAC.bus_ofac_address_2      	 := key1.bus_watchlist_address_2;
			SELF.OFAC.bus_ofac_city_2         	 := key1.bus_watchlist_city_2;
			SELF.OFAC.bus_ofac_state_2        	 := key1.bus_watchlist_state_2;
			SELF.OFAC.bus_ofac_zip_2          	 := key1.bus_watchlist_zip_2;
			SELF.OFAC.bus_ofac_country_2      	 := key1.bus_watchlist_country_2;
			SELF.OFAC.bus_ofac_entity_name_2  	 := key1.bus_watchlist_entity_name_2;
			SELF.OFAC.bus_ofac_sequence_2     	 := key1.bus_watchlist_sequence_2;
			SELF.OFAC.bus_ofac_table_3        	 := key1.bus_watchlist_table_3;
			SELF.OFAC.bus_ofac_program_3      	 := key1.bus_watchlist_program_3;
			SELF.OFAC.bus_ofac_record_number_3	 := key1.bus_watchlist_record_number_3;
			SELF.OFAC.bus_ofac_companyname_3  	 := key1.bus_watchlist_companyname_3;
			SELF.OFAC.bus_ofac_address_3      	 := key1.bus_watchlist_address_3;
			SELF.OFAC.bus_ofac_city_3         	 := key1.bus_watchlist_city_3;
			SELF.OFAC.bus_ofac_state_3        	 := key1.bus_watchlist_state_3;
			SELF.OFAC.bus_ofac_zip_3          	 := key1.bus_watchlist_zip_3;
			SELF.OFAC.bus_ofac_country_3      	 := key1.bus_watchlist_country_3;
			SELF.OFAC.bus_ofac_entity_name_3  	 := key1.bus_watchlist_entity_name_3;
			SELF.OFAC.bus_ofac_sequence_3     	 := key1.bus_watchlist_sequence_3;
			SELF.OFAC.bus_ofac_table_4        	 := key1.bus_watchlist_table_4;
			SELF.OFAC.bus_ofac_program_4      	 := key1.bus_watchlist_program_4;
			SELF.OFAC.bus_ofac_record_number_4	 := key1.bus_watchlist_record_number_4;
			SELF.OFAC.bus_ofac_companyname_4  	 := key1.bus_watchlist_companyname_4;
			SELF.OFAC.bus_ofac_address_4      	 := key1.bus_watchlist_address_4;
			SELF.OFAC.bus_ofac_city_4         	 := key1.bus_watchlist_city_4;
			SELF.OFAC.bus_ofac_state_4        	 := key1.bus_watchlist_state_4;
			SELF.OFAC.bus_ofac_zip_4          	 := key1.bus_watchlist_zip_4;
			SELF.OFAC.bus_ofac_country_4      	 := key1.bus_watchlist_country_4;
			SELF.OFAC.bus_ofac_entity_name_4  	 := key1.bus_watchlist_entity_name_4;
			SELF.OFAC.bus_ofac_sequence_4     	 := key1.bus_watchlist_sequence_4;
			SELF.OFAC.bus_ofac_table_5        	 := key1.bus_watchlist_table_5;
			SELF.OFAC.bus_ofac_program_5      	 := key1.bus_watchlist_program_5;
			SELF.OFAC.bus_ofac_record_number_5	 := key1.bus_watchlist_record_number_5;
			SELF.OFAC.bus_ofac_companyname_5  	 := key1.bus_watchlist_companyname_5;
			SELF.OFAC.bus_ofac_address_5      	 := key1.bus_watchlist_address_5;
			SELF.OFAC.bus_ofac_city_5         	 := key1.bus_watchlist_city_5;
			SELF.OFAC.bus_ofac_state_5        	 := key1.bus_watchlist_state_5;
			SELF.OFAC.bus_ofac_zip_5          	 := key1.bus_watchlist_zip_5;
			SELF.OFAC.bus_ofac_country_5      	 := key1.bus_watchlist_country_5;
			SELF.OFAC.bus_ofac_entity_name_5  	 := key1.bus_watchlist_entity_name_5;
			SELF.OFAC.bus_ofac_sequence_5     	 := key1.bus_watchlist_sequence_5;
			SELF.OFAC.bus_ofac_table_6        	 := key1.bus_watchlist_table_6;
			SELF.OFAC.bus_ofac_program_6      	 := key1.bus_watchlist_program_6;
			SELF.OFAC.bus_ofac_record_number_6	 := key1.bus_watchlist_record_number_6;
			SELF.OFAC.bus_ofac_companyname_6  	 := key1.bus_watchlist_companyname_6;
			SELF.OFAC.bus_ofac_address_6      	 := key1.bus_watchlist_address_6;
			SELF.OFAC.bus_ofac_city_6         	 := key1.bus_watchlist_city_6;
			SELF.OFAC.bus_ofac_state_6        	 := key1.bus_watchlist_state_6;
			SELF.OFAC.bus_ofac_zip_6          	 := key1.bus_watchlist_zip_6;
			SELF.OFAC.bus_ofac_country_6      	 := key1.bus_watchlist_country_6;
			SELF.OFAC.bus_ofac_entity_name_6  	 := key1.bus_watchlist_entity_name_6;
			SELF.OFAC.bus_ofac_sequence_6     	 := key1.bus_watchlist_sequence_6;
			SELF.OFAC.bus_ofac_table_7        	 := key1.bus_watchlist_table_7;
			SELF.OFAC.bus_ofac_program_7      	 := key1.bus_watchlist_program_7;
			SELF.OFAC.bus_ofac_record_number_7	 := key1.bus_watchlist_record_number_7;
			SELF.OFAC.bus_ofac_companyname_7  	 := key1.bus_watchlist_companyname_7;
			SELF.OFAC.bus_ofac_address_7      	 := key1.bus_watchlist_address_7;
			SELF.OFAC.bus_ofac_city_7         	 := key1.bus_watchlist_city_7;
			SELF.OFAC.bus_ofac_state_7        	 := key1.bus_watchlist_state_7;
			SELF.OFAC.bus_ofac_zip_7          	 := key1.bus_watchlist_zip_7;
			SELF.OFAC.bus_ofac_country_7      	 := key1.bus_watchlist_country_7;
			SELF.OFAC.bus_ofac_entity_name_7  	 := key1.bus_watchlist_entity_name_7;
			SELF.OFAC.bus_ofac_sequence_7     	 := key1.bus_watchlist_sequence_7;

      SELF.BusinessAddressRisk.AddressIsCMRA := key1.AddressIsCMRA;
      // SELF.Models := key1.Models;
      // SELF.AttributeGroup := key1.AttributeGroup;
      
			SELF.ConsumerInstantID               := buildConsumerInstantIDDataset;
			SELF := [];		
		END;
		
	testseed_intermediateLayout := DATASET( [xfm_toIntermediateLayout] );
	
	// output(testseed_intermediateLayout);

	FinalSeed := PROJECT( testseed_intermediateLayout, BusinessInstantID20_Services.xfm_ToIespLayout(LEFT) );
	
	return FinalSeed;
END;

 
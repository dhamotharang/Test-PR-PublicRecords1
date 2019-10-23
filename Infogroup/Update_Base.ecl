IMPORT Address, AID, Infogroup, Business_Header_SS, DID_Add, Health_Provider_Services, NID, ut;

EXPORT Update_Base(STRING                          pversion,
                   BOOLEAN                         pUseProd = FALSE,
									 DATASET(Infogroup.Layouts.Base) pBaseFile) := FUNCTION

	Clean_Name(DATASET(Infogroup.Layouts.Base) pInput) := FUNCTION
		NID.Mac_CleanParsedNames(pInput, cleanNames, first_name, middle_name, last_name, suffix);

		Infogroup.Layouts.Base add_clean_name(cleanNames L) := TRANSFORM
			SELF.clean_name.title       := L.cln_title;
			SELF.clean_name.fname       := L.cln_fname;
			SELF.clean_name.mname       := L.cln_mname;
			SELF.clean_name.lname       := L.cln_lname;
			SELF.clean_name.name_suffix := L.cln_suffix;
		
			SELF := L;
		END;

		RETURN PROJECT(cleanNames, add_clean_name(LEFT));
	END;

	// Get the standardized input
	std_input := Infogroup.Standardize_Input(pversion, pUseProd);

	// Get the previous base file
	prev_base := pBaseFile;

  // Everything that happens with the common utilities (AID, NID, etc.) needs to happen to everything
  combinedBase := std_input + prev_base : INDEPENDENT;

	// Clean the names via NID
	cleanNames := Clean_name(combinedBase);

  // Get clean address
	Address_Rec := RECORD
		Infogroup.Layouts.Base;
		STRING prep_address1;
		STRING prep_address2;
	END;

	Address_Rec get_prep_address_fields(Infogroup.Layouts.Base L) := TRANSFORM
	  SELF.prep_address1 := StringLib.StringCleanSpaces(L.address);

		SELF.prep_address2 :=
		  StringLib.StringCleanSpaces(TRIM(L.city) +
									                   IF(L.city != '' AND (L.state != '' OR L.zip != ''),
																	      ', ',
																		    '') +
																		 TRIM(L.state + ' ' + L.zip));

		SELF := L;
	END;

  prepAddressBase := PROJECT(cleanNames, get_prep_address_fields(LEFT));

	HasAddress :=	prepAddressBase.prep_address2 != '';

	dBaseWith_address		 := prepAddressBase(HasAddress);
	dBaseWithout_address := prepAddressBase(NOT(HasAddress));

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dBaseWith_address, prep_address1, prep_address2, raw_aid, dwithAID, lFlags);

	cleanAddressBase := PROJECT(dwithAID,
														  TRANSFORM(Infogroup.Layouts.Base,
																			  SELF.ace_aid                   := LEFT.aidwork_acecache.aid;
																			  SELF.raw_aid                   := LEFT.aidwork_rawaid;
																			  SELF.clean_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
																			  SELF.clean_address.fips_county := LEFT.aidwork_acecache.county[3..];
																			  SELF.clean_address.zip         := LEFT.aidwork_acecache.zip5;
																			  SELF.clean_address             := LEFT.aidwork_acecache;

																			  SELF := LEFT;)) + PROJECT(dBaseWithout_address, Infogroup.Layouts.Base);

  // Add source_rec_id and rollup base
  Infogroup.Layouts.Base add_source_rec_id(Infogroup.Layouts.Base L) := TRANSFORM
	  // occupation_id not included because it's supposed to change every load
	  SELF.source_rec_id := IF(L.source_rec_id = 0,
		                         HASH64(HASHMD5(TRIM(L.first_name) + ',' +
																						TRIM(L.middle_name) + ',' +
																						TRIM(L.last_name) + ',' +
																						TRIM(L.suffix) + ',' +
																						TRIM(L.address) + ',' +
																						TRIM(L.city) + ',' +
																						TRIM(L.state) + ',' +
																						TRIM(L.zip) + ',' +
																						TRIM(L.employer_name) + ',' +
																						TRIM(L.family_id) + ',' +
																						TRIM(L.individual_id) + ',' +
																						TRIM(L.abi_number) + ',' +
																						TRIM(L.industry_title) + ',' +
																						TRIM(L.occupation_title) + ',' +
																						TRIM(L.specialty_title) + ',' +
																						TRIM(L.sic_code) + ',' +
																						TRIM(L.naics_group) + ',' +
																						TRIM(L.license_state) + ',' +
																						TRIM(L.license_id) + ',' +
																						TRIM(L.license_number) + ',' +
																						TRIM(L.exp_date) + ',' +
																						TRIM(L.status_code) + ',' +
																						TRIM(L.effective_date) + ',' +
																						TRIM(L.year_licensed))),
														 L.source_rec_id);

	  SELF := L;
	END;

  sourceRecIDBase := PROJECT(cleanAddressBase, add_source_rec_id(LEFT));

  sourceRecIDBase_dist :=
	  DISTRIBUTE(sourceRecIDBase,
	             HASH64(first_name, middle_name, last_name, suffix, address, city, state, zip,
							           employer_name, family_id, individual_id, abi_number, industry_title,
												 occupation_title, specialty_title, sic_code, naics_group, license_state,
												 license_id, license_number, exp_date, status_code, effective_date,
												 year_licensed));
  sourceRecIDBase_sort := SORT(sourceRecIDBase_dist,
		                              first_name,
																	middle_name,
																	last_name,
																	suffix,
																	address,
																	city,
																	state,
																	zip,
																	employer_name,
																	family_id,
																	individual_id,
																	abi_number,
																	industry_title,
																	occupation_title,
																	specialty_title,
																	sic_code,
																	naics_group,
																	license_state,
																	license_id,
																	license_number,
																	exp_date,
																	status_code,
																	effective_date,
																	year_licensed,
															 LOCAL);

  Infogroup.Layouts.Base rollup_base(Infogroup.Layouts.Base L, Infogroup.Layouts.Base R) := TRANSFORM
		SELF.dt_first_seen            := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
		SELF.dt_last_seen             := ut.LatestDate(L.dt_last_seen, R.dt_last_seen);
		SELF.change_date              := IF(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.change_date, R.change_date);
		SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.occupation_id            := IF(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L.occupation_id, R.occupation_id);
		SELF.source_rec_id            := IF(L.dt_vendor_first_reported < R.dt_vendor_first_reported, L.source_rec_id, R.source_rec_id);

    SELF := IF(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L, R);
	END;

  rollupBase := ROLLUP(sourceRecIDBase_sort, rollup_base(LEFT, RIGHT),
													first_name,
													middle_name,
													last_name,
													suffix,
													address,
													city,
													state,
													zip,
													employer_name,
													family_id,
													individual_id,
													abi_number,
													industry_title,
													occupation_title,
													specialty_title,
													sic_code,
													naics_group,
													license_state,
													license_id,
													license_number,
													exp_date,
													status_code,
													effective_date,
													year_licensed,
											 LOCAL);

  // Add the DID
	// Un-nest certain fields, the macro can't handle the dot-notation
	BasePlus := RECORD
		Infogroup.Layouts.Base;
		STRING20 clean_fname;
		STRING20 clean_mname;
		STRING40 clean_lname;
		STRING5  clean_name_suffix;
		STRING10 clean_prim_range;
		STRING28 clean_prim_name;
		STRING5	 clean_zip5;
		STRING8	 clean_sec_range;
		STRING2	 clean_st;
		STRING25 clean_p_city_name;
	END;

	BasePlus tForDiding(Infogroup.Layouts.Base L) := TRANSFORM
		SELF.clean_fname       := L.clean_name.fname;
		SELF.clean_mname       := L.clean_name.mname;
		SELF.clean_lname       := L.clean_name.lname;
		SELF.clean_name_suffix := L.clean_name.name_suffix;
		SELF.clean_prim_range  := L.clean_address.prim_range;
		SELF.clean_prim_name   := L.clean_address.prim_name;
		SELF.clean_zip5        := L.clean_address.zip;
		SELF.clean_sec_range   := L.clean_address.sec_range;
		SELF.clean_st          := L.clean_address.st;
		SELF.clean_p_city_name := L.clean_address.p_city_name;
		
		SELF := L;
	END;

	dForDiding := PROJECT(rollupBase, tForDiding(LEFT));

	// Match by Address
	Did_Matchset := ['A'];

	DID_Add.MAC_Match_Flex(
													dForDiding						// Input Dataset
												 ,Did_Matchset   				// Did_Matchset  what fields to match on
												 ,ssn_notexist        	// ssn
												 ,dob_notexist       		// dob
												 ,clean_fname						// fname
												 ,clean_mname						// mname
												 ,clean_lname						// lname
												 ,clean_name_suffix   	// name_suffix
												 ,clean_prim_range	  	// prim_range
												 ,clean_prim_name	    	// prim_name
												 ,clean_sec_range	    	// sec_range
												 ,clean_zip5				  	// zip5
												 ,clean_st			    		// state
												 ,phone_notexist				// phone10
												 ,did            				// Did
												 ,BasePlus	  					// output layout
												 ,FALSE          				// Does output record have the score
												 ,did_score_notexist		// did score field
												 ,75             				// score threshold
												 ,DIDBaseOut						// output dataset
	);

  // Add BIP information
	// Match by Address
	BDID_Matchset := ['A'];
	
	Business_Header_SS.MAC_Add_BDID_Flex(
		 DIDBaseOut									// Input Dataset                 
		,BDID_Matchset							// BDID Matchset what fields to match on           
		,employer_name							// company_name                 
		,clean_prim_range						// prim_range                   
		,clean_prim_name						// prim_name                    
		,clean_zip5									// zip5                            
		,clean_sec_range						// sec_range                    
		,clean_st										// state                        
		,phone_notexist							// phone                        
		,fein_notexist							// fein              
		,bdid												// bdid                                    
		,BasePlus										// Output Layout 
		,FALSE											// output layout has bdid score field?                       
		,bdid_score_notexist				// bdid_score                 
		,BIPBaseOut									// Output Dataset
		,														// score_threshold
		,														// file version (prod)
		,														// use other environment?
		,BIPV2.xlink_version_set  	// BIP2 ids
		,														// URL
		,							// email
		,clean_p_city_name					// city
		,clean_fname								// fname
		,clean_mname								// mname
		,clean_lname								// lname
		,														// contact ssn
		,src												// source
		,source_rec_id							// source_record_id
		,FALSE	 										// does MAC_Source_Match exist before Flex macro			                                        				 
	);                                         

  BIPBase := PROJECT(BIPBaseOut, Infogroup.Layouts.Base);

	Health_Provider_Services.mac_get_best_lnpid_on_thor(
		BIPBase
		,lnpid
		,clean_name.fname
		,clean_name.mname
		,clean_name.lname
		,clean_name.name_suffix
		,//GENDER
		,clean_address.prim_range
		,clean_address.prim_name
		,clean_address.sec_range
		,clean_address.v_city_name
		,clean_address.st
		,clean_address.zip
		,//SSN
		,//DOB
		,//PHONE
		,license_state
		,license_number
		,//TAX_ID
		,//DEA
		,//VENDOR_ID
		,//NPI
		,//UPIN
		,did
		,bdid
		,//SRC
		,source_rec_id
		,result,FALSE,38);

  RETURN result;

END;
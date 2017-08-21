IMPORT AID, ALC, Business_Header_SS, Data_Services, DID_Add, Health_Provider_Services, NID, ut;

EXPORT Update_Base(STRING                    pversion,
                   BOOLEAN                   pUseProd = FALSE,
									 DATASET(ALC.Layouts.Base) pBaseFile) := FUNCTION

	Clean_Name(DATASET(ALC.Layouts.Base) pInput) := FUNCTION
		BaseExtra_Rec := RECORD
			ALC.Layouts.Base;
			STRING complete_name;
		END;

    BaseExtra_Rec add_complete_name(ALC.Layouts.Base L) := TRANSFORM
		  SELF.complete_name := StringLib.StringCleanSpaces(L.fname + ' ' + L.lname);
		  SELF := L;
		END;

    input_w_complete_name := PROJECT(pInput, add_complete_name(LEFT));

		NID.Mac_CleanFullNames(input_w_complete_name, cleanNames, complete_name);

		ALC.Layouts.Base add_clean_name(cleanNames L) := TRANSFORM
			SELF.clean_name.title       := IF(L.cln_title IN ['MR', 'MS'], L.cln_title, '');
			SELF.clean_name.fname       := L.cln_fname;
			SELF.clean_name.mname       := L.cln_mname;
			SELF.clean_name.lname       := L.cln_lname;
			SELF.clean_name.name_suffix := ut.fGetSuffix(L.cln_suffix);
		
			SELF := L;
		END;

		RETURN PROJECT(cleanNames, add_clean_name(LEFT));
	END;

	// Get the standardized input
	std_input := ALC.Standardize_Input(pversion, pUseProd).Accountants +
	                ALC.Standardize_Input(pversion, pUseProd).Dental_Professionals +
									ALC.Standardize_Input(pversion, pUseProd).Insurance_Agents +
									ALC.Standardize_Input(pversion, pUseProd).Lawyers +
									ALC.Standardize_Input(pversion, pUseProd).Nurses +
									ALC.Standardize_Input(pversion, pUseProd).Pharmacists +
									ALC.Standardize_Input(pversion, pUseProd).Pilots +
									ALC.Standardize_Input(pversion, pUseProd).Professionals;

	// Get the previous base file
	prev_base := pBaseFile;

  // Everything that happens with the common utilities (AID, NID, etc.) needs to happen to everything
  combinedBase := std_input + prev_base : INDEPENDENT;

	// Clean the names via NID
	cleanNames := Clean_name(combinedBase);

  // Get clean address
	Address_Rec := RECORD
		ALC.Layouts.Base;
		STRING prep_address1;
		STRING prep_address2;
	END;

	Address_Rec get_prep_address_fields(ALC.Layouts.Base L) := TRANSFORM
	  SELF.prep_address1 := StringLib.StringCleanSpaces(L.address1 + ' ' + L.address2);

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
														  TRANSFORM(ALC.Layouts.Base,
																			  SELF.ace_aid                   := LEFT.aidwork_acecache.aid;
																			  SELF.raw_aid                   := LEFT.aidwork_rawaid;
																			  SELF.clean_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
																			  SELF.clean_address.fips_county := LEFT.aidwork_acecache.county[3..];
																			  SELF.clean_address.zip         := LEFT.aidwork_acecache.zip5;
																			  SELF.clean_address             := LEFT.aidwork_acecache;

																			  SELF := LEFT;)) + PROJECT(dBaseWithout_address, ALC.Layouts.Base);

  // Add source_rec_id and rollup base
  ALC.Layouts.Base add_source_rec_id(ALC.Layouts.Base L) := TRANSFORM
	  SELF.source_rec_id := IF(L.source_rec_id = 0,
	                           HASH64(HASHMD5(TRIM(L.fname) + ',' +
																						TRIM(L.lname) + ',' +
																						TRIM(L.company) + ',' +
																						TRIM(L.address1) + ',' +
																						TRIM(L.address2) + ',' +
																						TRIM(L.city) + ',' +
																						TRIM(L.state) + ',' +
																						TRIM(L.zip) + ',' +
																						TRIM(L.gender) + ',' +
																						TRIM(L.list_id) + ',' +
																						TRIM(L.scno) + ',' +
																						TRIM(L.custno) + ',' +
																						TRIM(L.phone) + ',' +
																						TRIM(L.fax) + ',' +
																						TRIM(L.email) + ',' +
																						TRIM(L.license_no) + ',' +
																						TRIM(L.dob) + ',' +
																						TRIM(L.orig_date) + ',' +
																						TRIM(L.exp_date) + ',' +
																						TRIM(L.degree) + ',' +
																						TRIM(L.specialty) + ',' +
																						TRIM(L.license_state) + ',' +
																						TRIM(L.license_type) + ',' +
																						TRIM(L.job_code) + ',' +
																						TRIM(L.source_code) + ',' +
																						TRIM(L.company_type) + ',' +
																						TRIM(L.specialty_code) + ',' +
																						TRIM(L.business_ind) + ',' +
																						TRIM(L.number_of_lawyers_range) + ',' +
																						TRIM(L.practice_area) + ',' +
																						TRIM(L.title_cd) + ',' +
																						TRIM(L.marital_status) + ',' +
																						TRIM(L.nurse_type) + ',' +
																						TRIM(L.reg_state) + ',' +
																						TRIM(L.cert_lvl) + ',' +
																						TRIM(L.cert_type) + ',' +
																						TRIM(L.cert_type_secondary) + ',' +
																						TRIM(L.rating) + ',' +
																						TRIM(L.license_class) + ',' +
																						TRIM(L.insurance_type) + ',' +
		// Due to normalization on the inputs, source_rec_id needs to use the various derived fields to
		//   help figure out the result.  A unique record has unique values for the attributes below.
																						TRIM(L.specialty_code_singular_desc) + ',' +
																						TRIM(L.practice_area_singular_desc) + ',' +
																						TRIM(L.cert_lvl_singular_desc) + ',' +
																						TRIM(L.cert_type_singular_desc) + ',' +
																						TRIM(L.cert_type_secondary_singular_desc) + ',' +
																						TRIM(L.rating_singular_desc) + ',' +
																						TRIM(L.license_class_singular_desc) + ',' +
																						TRIM(L.license_type_singular_desc) + ',' +
																						TRIM(L.specialty_singular_desc) + ',' +
																						TRIM(L.insurance_type_singular_desc))),
														 L.source_rec_id);

	  SELF := L;
	END;

  sourceRecIDBase := PROJECT(cleanAddressBase, add_source_rec_id(LEFT));

  sourceRecIDBase_dist :=
	  DISTRIBUTE(sourceRecIDBase,
	             HASH64(fname, lname, company, address1, address2, city, state, zip, gender, list_id,
							           scno, custno, phone, fax, email, license_no, dob, orig_date, exp_date,
												 degree, specialty, license_state, license_type, job_code,
												 source_code, company_type, specialty_code, business_ind,
												 number_of_lawyers_range, practice_area, title_cd,
												 marital_status, nurse_type, reg_state, cert_lvl, cert_type,
												 cert_type_secondary, rating, license_class, insurance_type,
												 specialty_code_singular_desc, practice_area_singular_desc,
												 cert_lvl_singular_desc, cert_type_singular_desc,
												 cert_type_secondary_singular_desc, rating_singular_desc,
												 license_class_singular_desc, license_type_singular_desc,
												 specialty_singular_desc, insurance_type_singular_desc));
  sourceRecIDBase_sort := SORT(sourceRecIDBase_dist,
	                                fname,
																	lname,
																	company,
																	address1,
																	address2,
																	city,
																	state,
																	zip,
																	gender,
																	list_id,
																	scno,
																	custno,
																	phone,
																	fax,
																	email,
																	license_no,
																	dob,
																	orig_date,
																	exp_date,
																	degree,
																	specialty,
																	license_state,
																	license_type,
																	job_code,
																	source_code,
																	company_type,
																	specialty_code,
																	business_ind,
																	number_of_lawyers_range,
																	practice_area,
																	title_cd,
																	marital_status,
																	nurse_type,
																	reg_state,
																	cert_lvl,
																	cert_type,
																	cert_type_secondary,
																	rating,
																	license_class,
																	insurance_type,
																	specialty_code_singular_desc,
																	practice_area_singular_desc,
																	cert_lvl_singular_desc,
																	cert_type_singular_desc,
																	cert_type_secondary_singular_desc,
																	rating_singular_desc,
																	license_class_singular_desc,
																	license_type_singular_desc,
																	specialty_singular_desc,
																	insurance_type_singular_desc,
															 LOCAL);

  ALC.Layouts.Base rollup_base(ALC.Layouts.Base L, ALC.Layouts.Base R) := TRANSFORM
		SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported  := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_first_seen            := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
		SELF.dt_last_seen             := MAX(L.dt_last_seen, R.dt_last_seen);
		SELF.source_rec_id            := IF(L.dt_vendor_first_reported < R.dt_vendor_first_reported, L.source_rec_id, R.source_rec_id);

    SELF := IF(L.dt_vendor_last_reported > R.dt_vendor_last_reported, L, R);
	END;

  rollupBase := ROLLUP(sourceRecIDBase_sort, rollup_base(LEFT, RIGHT),
													fname,
													lname,
													company,
													address1,
													address2,
													city,
													state,
													zip,
													gender,
													list_id,
													scno,
													custno,
													phone,
													fax,
													email,
													license_no,
													dob,
													orig_date,
													exp_date,
													degree,
													specialty,
													license_state,
													license_type,
													job_code,
													source_code,
													company_type,
													specialty_code,
													business_ind,
													number_of_lawyers_range,
													practice_area,
													title_cd,
													marital_status,
													nurse_type,
													reg_state,
													cert_lvl,
													cert_type,
													cert_type_secondary,
													rating,
													license_class,
													insurance_type,
													specialty_code_singular_desc,
													practice_area_singular_desc,
													cert_lvl_singular_desc,
													cert_type_singular_desc,
													cert_type_secondary_singular_desc,
													rating_singular_desc,
													license_class_singular_desc,
													license_type_singular_desc,
													specialty_singular_desc,
													insurance_type_singular_desc,
											 LOCAL);

  // Add the DID
	// Un-nest certain fields, the macro can't handle the dot-notation
	BasePlus := RECORD
		ALC.Layouts.Base;
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

	BasePlus tForDiding(ALC.Layouts.Base L) := TRANSFORM
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

	// Match by Address, DOB, and Phone
	Did_Matchset := ['A', 'D', 'P'];

	DID_Add.MAC_Match_Flex(
													dForDiding					// Input Dataset
												 ,Did_Matchset   			// Did_Matchset  what fields to match on
												 ,ssn_notexist        // ssn
												 ,clean_dob          	// dob
												 ,clean_fname					// fname
												 ,clean_mname					// mname
												 ,clean_lname					// lname
												 ,clean_name_suffix   // name_suffix
												 ,clean_prim_range	  // prim_range
												 ,clean_prim_name	    // prim_name
												 ,clean_sec_range	    // sec_range
												 ,clean_zip5				  // zip5
												 ,clean_st			    	// state
												 ,clean_phone					// phone10
												 ,did            			// Did
												 ,BasePlus	  				// output layout
												 ,FALSE          			// Does output record have the score
												 ,did_score_notexist	// did score field
												 ,75             			// score threshold
												 ,DIDBaseOut					// output dataset
	);

  // Add BIP information
	// Match by Address, and Phone
	BDID_Matchset := ['A','P'];
	
	Business_Header_SS.MAC_Add_BDID_Flex(
		 DIDBaseOut									// Input Dataset                 
		,BDID_Matchset							// BDID Matchset what fields to match on           
		,company										// company_name                 
		,clean_prim_range						// prim_range                   
		,clean_prim_name						// prim_name                    
		,clean_zip5									// zip5                            
		,clean_sec_range						// sec_range                    
		,clean_st										// state                        
		,clean_phone								// phone                        
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
		,email											// email
		,clean_p_city_name					// city
		,clean_fname								// fname
		,clean_mname								// mname
		,clean_lname								// lname
		,														// contact ssn
		,src												// source
		,source_rec_id							// source_record_id
		,FALSE	 										// does MAC_Source_Match exist before Flex macro			                                        				 
	);                                         

  BIPBase := PROJECT(BIPBaseOut, ALC.Layouts.Base);

	Health_Provider_Services.mac_get_best_lnpid_on_thor(
		BIPBase
		,lnpid
		,clean_name.fname
		,clean_name.mname
		,clean_name.lname
		,clean_name.name_suffix
		,clean_gender
		,clean_address.prim_range
		,clean_address.prim_name
		,clean_address.sec_range
		,clean_address.v_city_name
		,clean_address.st
		,clean_address.zip
		,//SSN
		,clean_dob
		,clean_phone
		,license_state
		,license_no
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
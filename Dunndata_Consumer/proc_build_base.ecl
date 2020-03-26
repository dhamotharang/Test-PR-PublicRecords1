IMPORT ut, PRTE2, std, did_Add, business_header_ss, BIPV2, PromoteSupers, MDR;

EXPORT proc_build_base(STRING	pVersion) := FUNCTION

	input_file := Files.Input_FieldsCleaned;                                               ;
	
	//Pre-process input file - populate date fields and persistent record id
	Layout_Basefile tPreprocess(Layout_Infile.Raw L) := TRANSFORM

		SELF.dt_first_seen										:= 0;				//date first seen by vendor, not available in input file
		SELF.dt_last_seen											:= 0;
		SELF.dt_vendor_first_reported			:= (UNSIGNED4) pVersion;
		SELF.dt_vendor_last_reported				:= (UNSIGNED4) pVersion;
		SELF.process_date											:= thorlib.WUID()[2..9];
		
		SELF.src																:= MDR.sourceTools.src_Dunndata_Consumer;
		SELF.persistent_record_id						:= SELF.src +
																									(STRING) HASH64(	L.MSNAME + ',' +
																																				L.MSADDR1 + ',' +
																																				L.MSADDR2 + ',' +
																																				L.MSCITY + ',' +
																																				L.MSSTATE + ',' +
																																				L.MSZIP5 + ',' +
																																				L.MSZIP4 );

		//map code to description
		SELF.append_income							:= fDecoders.fnDecodeIncomeCode(L.INC);
		SELF.append_occupation					:= fDecoders.fnDecodeOccupationCode(L.OCP);
		SELF.append_education					:= fDecoders.fnDecodeEducationLevelCode(L.EDU);
		SELF.append_religion						:= fDecoders.fnDecodeReligionCode(L.RELIG);
		SELF.append_dwell								:= fDecoders.fnDecodeDwellTypeCode(L.DWELL);
		SELF.append_ethnicity1					:= fDecoders.fnDecodeEth1Code(L.ETH1);
		SELF.append_ethnicity2					:= fDecoders.fnDecodeEth2Code(L.ETH2);
		SELF.append_language						:= fDecoders.fnDecodeLanguageCode(l.LANG);
		
		SELF																:= L;	
		SELF																:= [];
	END;
	EXPORT dPreProcessed		:= PROJECT(input_file, tPreprocess(LEFT));
	
	
	//Dedup multiple persistent record id
	Layout_Basefile tRollup(Layout_Basefile L, Layout_Basefile R) := TRANSFORM
		SELF.DOB				:= IF(L.DOB<>'',L.DOB,R.DOB);
		SELF.AGE				:= IF(L.AGE<>0,L.AGE,R.AGE);
		SELF							:= L;
	END;
	
	dSorted						:= SORT(DISTRIBUTE(dPreProcessed, HASH(persistent_record_id)),
																persistent_record_id,
																LMOS,
																MS_PUB_LMOS,
																MS_CAT_LMOS,
																MS_FUND_LMOS,
																MS_CONT_LMOS,
																MS_APP_LMOS,
																MS_WFSH_LMOS,
																MS_BIBLE_LMOS,
																MS_FAMILY_LMOS,
																MS_HLTH_LMOS,
																MS_HOME_LMOS,
																MS_MONEYMAKING_LMOS,
																MS_OUT_LMOS,
																MS_SPORTS_LMOS,
																MS_WOMAN_LMOS, LOCAL);
		dNewInput				:= Rollup(dSorted,
																		LEFT.persistent_record_id=RIGHT.persistent_record_id,
																		tRollup(LEFT,RIGHT),
																		LOCAL);
																
	//Ingest
	dCurrBase					:= Files.Basefile;

	//Use Machine generated INGEST function to populate rcid and rollup on raw data fields
	dNewBase_0				:= Ingest(FALSE,,dCurrBase,dNewInput).AllRecords;
	doStats						:= Ingest(FALSE,,dCurrBase,dNewInput).DoStats;
	vStats							:= Ingest(FALSE,,dCurrBase,dNewInput).ValidityStats;
	stdStats					:= OUTPUT(Ingest(FALSE,,dCurrBase,dNewInput).StandardStats(), ALL, NAMED('StandardStats'));

	Layout_Basefile tSetHistoryFlag(dNewBase_0 L) := TRANSFORM
		SELF.history_flag	:= IF(L.__Tpe=Ingest().RecordType.Old,'H','');
		SELF									:= L;
	END;
	dNewBase					:= PROJECT(dNewBase_0, tSetHistoryFlag(LEFT));
	
		//Clean names
	dsCleanedNames		:= fCleanNames(dNewBase);
	
	//Clean address
	dsCleanedAddress	:= fCleanAddresses(dsCleanedNames) : persist('~thor_data400::persist::dunndata_consumer::aid');

	//Append DID
	matchset :=['A','D','Z'];								//Address, DOB, Zip
	did_Add.MAC_Match_Flex(dsCleanedAddress, matchset,
													'', dob, clean_fname, clean_mname, clean_lname, clean_suffix, 
													prim_range, prim_name, sec_range, zip, st, '',
													did,   			
													Layout_Basefile, 
													true, did_score,	//these should default to zero in definition
													75,	  							//dids with a score below here will be dropped 
													dsCleanDID, true, src);

	//Append BDID
	bmatch	:=	['A'];

	business_header_ss.MAC_Match_Flex(
				 dsCleanDID													// input dataset						
				,bmatch				                		// bdid matchset what fields to match on           
				,clean_cname	                 		// company_name	              
				,prim_range		                 	// prim_range		              
				,prim_name		                   // prim_name		              
				,zip					                    	// zip5					              
				,sec_range		                   // sec_range		              
				,st				        		          	// state				              
				,foo						                   // phone				              
				,foo            			          	// fein              
				,bdid														     // bdid												
				,Layout_Basefile				    				// output layout 
				,true                           // output layout has bdid score field? 																	
				,bdid_score                     // bdid_score                 
				,dsCleanBDID				          			// output dataset
				,																				// keep count
				,																				// default threshold
				,																				// use prod version of superfiles
				,																				// default is to hit prod from dataland, and on prod hit prod.		
				,BIPV2.xlink_version_set					// create BIP keys only
				,																				// url
				,																				// email 
				,v_city_name													// city
				,clean_fname													// fname
				,clean_mname													// mname
				,clean_lname													// lname
				,																				// contact ssn
				,src																		// source
				,																				// source_record_id
				,true
			);																				
			
	//Append SSN
	did_add.MAC_Add_SSN_By_DID(dsCleanBDID,did,append_ssn,postSSN)

	//append FEIN 
	Business_Header_SS.MAC_Add_FEIN_By_BDID(postSSN,bdid,append_fein,postFEIN)

	PromoteSupers.Mac_SF_BuildProcess(postFEIN,Filenames().base,build_base,,,true);
  // VersionControl.macBuildNewLogicalFile(Filenames(pVersion).base.new	,postFEIN	,build_base	,TRUE);
	
	// EXPORT build_base := sequential(
								// output(dsCleanBDID,,'~thor_data400::temp::ddc_consumer_data::postFEIN',overwrite);
						// );
	RETURN sequential(build_base,
												doStats,
												vStats,
												stdStats);
	
END;

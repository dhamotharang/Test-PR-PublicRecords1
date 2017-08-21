import  Address, aid, NID, ut, _validate;


export Standardize_NameAddr :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fPreprocessInput 
	// -- Prepare data for name and address cleaning and map dt_fitst/last_seen and dt_vendor_first/last_reported
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreprocessInput( dataset(Layouts.input.sprayed) pVendorInput
													,string													pversion			) :=
	function
		
		PreprocessedInput := project( pVendorInput, transform(Layouts.Temporary.StandardizeInput, 
																	self.prep_addr_line1					:= address.Addr1FromComponents(left.prim_range, left.predir, left.prim_name, left.addr_suffix, left.postdir, left.unit_desig, left.sec_range),
																	self.prep_addr_line_last			:= address.Addr2FromComponents(left.city, left.st, left.zip),
																	self.dt_first_seen            := if (_validate.date.fIsValid(left.claim_date) and _validate.date.fIsValid(left.claim_date,_validate.date.rules.DateInPast), (unsigned6)left.claim_date,0);
																	self.dt_last_seen             := if (_validate.date.fIsValid(left.claim_date) and _validate.date.fIsValid(left.claim_date,_validate.date.rules.DateInPast), (unsigned6)left.claim_date,0);
																	self.dt_vendor_first_reported	:= 0,
																	self.dt_vendor_last_reported	:= 0,
																	//*** removed as the build is setup to replace the file in each run.
																	//self.dt_vendor_first_reported	:= if (_validate.date.fIsValid(pversion) and _validate.date.fIsValid(pversion,_validate.date.rules.DateInPast), (unsigned4)pversion, 0),
																	//self.dt_vendor_last_reported	:= if (_validate.date.fIsValid(pversion) and _validate.date.fIsValid(pversion,_validate.date.rules.DateInPast), (unsigned4)pversion, 0),
																	self 													:= left,
																	self													:= [])															
																);
		return PreprocessedInput;
			
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function

		//*** Cleaning persion names using the new NID name cleaner.
		NID.Mac_CleanFullNames(pPreProcessInput, cleaned_name_output, name);
		
		cleaned_name_PreProcessInput := cleaned_name_output;
		
		person_flags := ['P', 'D'];
		// An executive decision was made to consider Unclassifed and Invalid names as company names for UCC.
		business_flags := ['B', 'U', 'I'];

		Layouts.Temporary.StandardizeInput tStandardizeName(cleaned_name_PreProcessInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_Name.title		      := if (L.nametype in person_flags, l.cln_title,'');
			self.clean_Name.fname	        := if (L.nametype in person_flags, l.cln_fname,'');
			self.clean_Name.mname	        := if (L.nametype in person_flags, l.cln_mname,'');
			self.clean_Name.lname		      := if (L.nametype in person_flags, l.cln_lname,'');
			self.clean_Name.name_suffix	  := if (L.nametype in person_flags, l.cln_suffix,'');
			self.clean_Name.name_score	  := '';
			self.business_name						:= if (L.nametype in business_flags, l.name, '');

			self													:= l;
			
		end;
		
		dStandardizedName := project(cleaned_name_PreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pStandardizeNameInput) :=
	function

															
		HasAddress	:= trim(pStandardizeNameInput.prep_addr_line_last, left,right) != '';
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
		dBase := project(		
			dwithAID
			,transform(
				Layouts.Temporary.StandardizeInput
				,
				self.ace_aid									:= left.aidwork_acecache.aid					;
				self.raw_aid									:= left.aidwork_rawaid								;
				self.clean_addr.prim_range		:= left.aidwork_acecache.prim_range		;
				self.clean_addr.predir				:= left.aidwork_acecache.predir				;
				self.clean_addr.prim_name			:= left.aidwork_acecache.prim_name		;
				self.clean_addr.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
				self.clean_addr.postdir				:= left.aidwork_acecache.postdir			;
				self.clean_addr.unit_desig		:= left.aidwork_acecache.unit_desig		;
				self.clean_addr.sec_range			:= left.aidwork_acecache.sec_range		;
				self.clean_addr.p_city_name		:= left.aidwork_acecache.p_city_name	;
				self.clean_addr.v_city_name		:= left.aidwork_acecache.v_city_name	;
				self.clean_addr.st						:= left.aidwork_acecache.st						;
				self.clean_addr.zip						:= left.aidwork_acecache.zip5					;
				self.clean_addr.zip4					:= left.aidwork_acecache.zip4					;
				self.clean_addr.cart					:= left.aidwork_acecache.cart					;
				self.clean_addr.cr_sort_sz		:= left.aidwork_acecache.cr_sort_sz		;
				self.clean_addr.lot						:= left.aidwork_acecache.lot					;
				self.clean_addr.lot_order			:= left.aidwork_acecache.lot_order		;
				self.clean_addr.dbpc					:= left.aidwork_acecache.dbpc					;
				self.clean_addr.chk_digit			:= left.aidwork_acecache.chk_digit		;
				self.clean_addr.rec_type			:= left.aidwork_acecache.rec_type			;
				self.clean_addr.fips_state 		:= left.aidwork_acecache.county[1..2]	;
				self.clean_addr.fips_county		:= left.aidwork_acecache.county[3..]	;
				self.clean_addr.geo_lat				:= left.aidwork_acecache.geo_lat			;
				self.clean_addr.geo_long			:= left.aidwork_acecache.geo_long			;
				self.clean_addr.msa						:= left.aidwork_acecache.msa					;
				self.clean_addr.geo_blk				:= left.aidwork_acecache.geo_blk			;
				self.clean_addr.geo_match			:= left.aidwork_acecache.geo_match		;
				self.clean_addr.err_stat			:= left.aidwork_acecache.err_stat			;
								
				self													:= left																;
			)
		)
		+ project(dWithout_address,transform(Layouts.Temporary.StandardizeInput, self := left));

		return dBase;
		
	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	export fAll( dataset(Layouts.input.sprayed	) pInFile
							,string														pversion
							,string														pPersistname = persistnames().StandardizeNameAddr
	) :=
	function
	
		dPreprocessInput	:= fPreprocessInput			(pInFile, pversion		);
		
		dStandardizeName	:= fStandardizeName			(dPreprocessInput			);
				
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName			) : persist(pPersistname);		
		
		return dStandardizeAddr;
	
		//return dPreprocessInput;
	
	end;

end;
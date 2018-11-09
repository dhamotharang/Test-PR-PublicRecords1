IMPORT AID, ut, NID, codes, Address;

EXPORT Standardize_NameAddr := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes company names and phone numbers
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNamesPhone(DATASET(Equifax_Business_Data.Layouts.Base) pPreProcessInput) :=	FUNCTION
			
		// -- Mapping Clean company name and clean phone numbers
		Equifax_Business_Data.Layouts.Base tMapCleanCompanyName(pPreProcessInput L) := TRANSFORM   
			SELF.clean_company_name := L.normCompany_Name;
			SELF.clean_phone := ut.CleanPhone(L.EFX_PHONE); 
			SELF.clean_secondary_phone := ut.CleanPhone(L.EFX_FAXPHONE);											 						
			SELF								  := L;			
		END;
	
		dStandardizedNames := project(pPreProcessInput, tMapCleanCompanyName(LEFT)) : INDEPENDENT;
			
		RETURN dStandardizedNames;

	END;  //End fStandardizeNamesPhone
	
			
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	
	EXPORT fStandardizeAddresses(dataset(Equifax_Business_Data.Layouts.Base) pStandardizeNameInput) :=	function
		
		Equifax_Business_Data.Layouts.Base tprepAddr(Equifax_Business_Data.Layouts.Base L) :=	TRANSFORM
														 
			InvalidPart  := '%|UNKNOWN|UNKNOWN ADDRESS|PHYSICAL ADDRESS UNKNOWN|PYSICAL ADDRESS UNKNOWN|ADDRESS UNKNOWN|ADRESS UNKNOWN|UNKNOWN, UNKNOWN|ADDRESS UNKNOWN,|!|~';			
   				
			cleanStreet  := REGEXREPLACE(InvalidPart,L.norm_Address,'');
					
			prepAddrLast 	  :=	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.norm_city) + 
														IF(L.norm_city <> '' and L.norm_State <> '', ', ', '') + L.norm_State + ' ' +
													  IF(LENGTH(L.norm_Zip) >= 5 and Stringlib.StringFilterOut(L.norm_Zip[1..5], '0123456789') = ''
														, L.norm_Zip[1..5], ''));													
			
			clean_AddrPrep	:= IF(prepAddrLast <> '', Address.CleanAddress182(cleanStreet, prepAddrLast), '');	
			Address.Layout_Clean182_fips	clean_AddrRec	:=	transfer(clean_AddrPrep, Address.Layout_Clean182_fips);
																												 
			SELF.prep_Addr_line1     := IF(L.NORM_CTRYISOCD = 'USA' 
			                                and EFX_STATE_TABLE.STATE(L.norm_State) != ''
			                                and EFX_STATE_TABLE.STATE(L.norm_State) != 'INVALID'
																			and ut.CleanSpacesAndUpper(clean_AddrPrep[1..64]) not in ['0','.'] 
																			,Address.Addr1FromComponents(clean_AddrRec.prim_range,
																																	 clean_AddrRec.predir,
																																	 clean_AddrRec.prim_name,
																																	 clean_AddrRec.addr_suffix,
																																	 clean_AddrRec.postdir,
																																	 clean_AddrRec.unit_desig,
																																	 clean_AddrRec.sec_range)
																			,'');																																		
																			
			SELF.prep_Addr_line_last := IF(L.NORM_CTRYISOCD = 'USA' 
			                                and EFX_STATE_TABLE.STATE(L.norm_State) != ''
			                                and EFX_STATE_TABLE.STATE(L.norm_State) != 'INVALID'
																		  ,Address.Addr2FromComponents(clean_AddrRec.p_city_name,
																																	 clean_AddrRec.st,
																																	 clean_AddrRec.zip)
																			,'');																
			
			SELF											:= L;
		END;   
		
		pPrepAddresses := PROJECT(pStandardizeNameInput, tprepAddr(LEFT));
		
		HasAddress	:= trim(pPrepAddresses.prep_addr_line_last, left,right) != '';
										
		dWith_address			:= pPrepAddresses(HasAddress);
		dWithout_address	:= pPrepAddresses(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, raw_aid, dwithAID, lFlags);
		
		dBase := project(dwithAID
			,transform(Layouts.base,
			 self.ace_aid	      := left.aidwork_acecache.aid					;
				self.raw_aid        := left.aidwork_rawaid								;
				self.prim_range			:= left.aidwork_acecache.prim_range		;
				self.predir					:= left.aidwork_acecache.predir				;
				self.prim_name			:= left.aidwork_acecache.prim_name		;
				self.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
				self.postdir				:= left.aidwork_acecache.postdir			;
				self.unit_desig			:= left.aidwork_acecache.unit_desig		;
				self.sec_range			:= left.aidwork_acecache.sec_range		;
				self.p_city_name		:= left.aidwork_acecache.p_city_name	;
				self.v_city_name		:= left.aidwork_acecache.v_city_name	;
				self.st							:= left.aidwork_acecache.st						;
				self.zip						:= left.aidwork_acecache.zip5					;
				self.zip4						:= left.aidwork_acecache.zip4					;
				self.cart						:= left.aidwork_acecache.cart					;
				self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
				self.lot						:= left.aidwork_acecache.lot					;
				self.lot_order			:= left.aidwork_acecache.lot_order		;
				self.dbpc						:= left.aidwork_acecache.dbpc					;
				self.chk_digit			:= left.aidwork_acecache.chk_digit		;
				self.rec_type				:= left.aidwork_acecache.rec_type			;
				self.fips_state 		:= left.aidwork_acecache.county[1..2]	;
				self.fips_county		:= left.aidwork_acecache.county[3..]	;
				self.geo_lat				:= left.aidwork_acecache.geo_lat			;
				self.geo_long				:= left.aidwork_acecache.geo_long			;
				self.msa						:= left.aidwork_acecache.msa					;
				self.geo_blk				:= left.aidwork_acecache.geo_blk			;
				self.geo_match			:= left.aidwork_acecache.geo_match		;
				self.err_stat				:= left.aidwork_acecache.err_stat			;
				self								                      := left																;
			)
		)
		+ project(dWithout_address,transform(Equifax_Business_Data.Layouts.base, self := left));

		return dBase;
		
	end;   

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Equifax_Business_Data.Layouts.Base) pBaseFile
							,STRING pPersistname = Equifax_Business_Data.Persistnames().StandardizeNameAddr) := FUNCTION

  	dStandardizeName	:= fStandardizeNamesPhone(pBaseFile);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName) : PERSIST(pPersistname);		
		
		RETURN dStandardizeAddr;
	
	END;

END;
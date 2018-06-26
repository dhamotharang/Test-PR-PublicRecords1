IMPORT AID, ut, NID, codes, Address;

EXPORT Standardize_NameAddr := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes people and company names and phone numbers
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNamesPhone(DATASET(Infutor_NARB.Layouts.Base) pPreProcessInput) :=	FUNCTION

		// -- Mapping Clean Person Name - uses NID to clean names
		sendRecs		:= pPreProcessInput(trim(first_name + middle_name + surname) <> '');
		notSendRecs := pPreProcessInput(trim(first_name + middle_name + surname) = '');

		NID.Mac_CleanParsedNames(PROJECT(sendRecs, Infutor_NARB.Layouts.Base) 
																		,NID_output
																		,first_name ,middle_name ,surname,suffix);	
		
		Infutor_NARB.Layouts.Base tCleanPers(NID_output L) := TRANSFORM
			SELF.title		    := if(L.nameType in ['P','D'], L.cln_title,  '');
			SELF.fname	      := if(L.nameType in ['P','D'], L.cln_fname,  '');
			SELF.mname	      := if(L.nameType in ['P','D'], L.cln_mname,  '');
			SELF.lname		    := if(L.nameType in ['P','D'], L.cln_lname,  '');
			SELF.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF										            := L;			
		END;
		
		dStandardizedPerson := project(NID_output, tCleanPers(LEFT)) + notSendRecs : INDEPENDENT;
	
		
		// -- Mapping Clean company name and clean phone numbers
  	Infutor_NARB.Layouts.Base tMapCleanCompanyName(dStandardizedPerson L) := TRANSFORM
   	  
			InvalidNames  := '\\| NONE$|\\| N/A$|\\|$|\\| $';
			SELF.clean_company_name := REGEXREPLACE(InvalidNames,ut.CleanSpacesAndUpper(L.normCompany_Name),'');
			
			SELF.clean_phone        := if(length(ut.CleanPhone(L.normCompany_Phone)) in [7,10] and
																					 ut.CleanPhone(L.normCompany_Phone) not in [
																					 '0000000','0000000000','1111111','1111111111',
																					 '2222222','2222222222','3333333','3333333333',
																					 '4444444','4444444444','5555555','5555555555',
																					 '6666666','6666666666','7777777','7777777777',
																					 '8888888','8888888888','9999999','9999999999']
																		,ut.CleanPhone(L.normCompany_Phone) ,'');
			SELF								  := L;			
		END;
		
		dStandardizedNames := project(dStandardizedPerson, tMapCleanCompanyName(LEFT))(REGEXFIND('\\|', clean_company_name) = false) : INDEPENDENT;
			
		RETURN dStandardizedNames;

	END;  //End fStandardizeNamesPhone
	
			
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	
	EXPORT fStandardizeAddresses(dataset(Infutor_NARB.Layouts.Base) pStandardizeNameInput) :=	function
		
		Infutor_NARB.Layouts.Base tprepAddr(Infutor_NARB.Layouts.Base L) :=	TRANSFORM
			
			InvalidPart  := 'NONE GIVEN|^1 NONE$|^NONE$|^DEFAULT$|SERVING YOUR AREA';
			cleanStreet  := REGEXREPLACE(InvalidPart,L.normCompany_Street,'');			
			cleanCity    := REGEXREPLACE(InvalidPart,L.normCompany_City,'');	
			
			prepAddrLast 	  :=	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(cleanCity) + 
														IF(cleanCity <> '' and L.normCompany_State <> '', ', ', '') + L.normCompany_State + ' ' +
													  IF(LENGTH(L.normCompany_Zip) >= 5, L.normCompany_Zip[1..5], ''));
			
			string182	clean_AddrPrep	:= IF(prepAddrLast <> '', Address.CleanAddress182(cleanStreet, prepAddrLast), '');
			Address.Layout_Clean182_fips	clean_AddrRec	:=	transfer(clean_AddrPrep, Address.Layout_Clean182_fips);

			SELF.prep_Address_line1     := IF(Codes.St2Name(L.normCompany_State) <> '' and clean_AddrPrep not in ['','.'] and ut.CleanSpacesAndUpper(clean_AddrPrep[1..64]) not in ['0','.']  
																			,Address.Addr1FromComponents(clean_AddrRec.prim_range,
																																	 clean_AddrRec.predir,
																																	 clean_AddrRec.prim_name,
																																	 clean_AddrRec.addr_suffix,
																																	 clean_AddrRec.postdir,
																																	 clean_AddrRec.unit_desig,
																																	 clean_AddrRec.sec_range)
																			,'');
			SELF.prep_Address_line_last := IF(Codes.St2Name(L.normCompany_State) <> '' and clean_AddrPrep not in ['','.']
																			,Address.Addr2FromComponents(clean_AddrRec.p_city_name,
																																	 clean_AddrRec.st,
																																	 clean_AddrRec.zip)
																			,'');
			SELF											:= L;
		END;   
		
		pPrepAddresses := PROJECT(pStandardizeNameInput, tprepAddr(LEFT));
		
		HasAddress	:= trim(pPrepAddresses.prep_address_line_last, left,right) != '';
										
		dWith_address			:= pPrepAddresses(HasAddress);
		dWithout_address	:= pPrepAddresses(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_address_line1, prep_address_line_last, raw_aid, dwithAID, lFlags);
		
		dBase := project(dwithAID
			,transform(Layouts.base
			 ,self.ace_aid	      := left.aidwork_acecache.aid					;
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
		+ project(dWithout_address,transform(Infutor_NARB.Layouts.base, self := left));

		return dBase;
		
	end;   

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Infutor_NARB.Layouts.Base) pBaseFile
							,STRING pversion
							,STRING pPersistname = Infutor_NARB.Persistnames().StandardizeNameAddr) := FUNCTION

  	dStandardizeName	:= fStandardizeNamesPhone(pBaseFile);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName) : PERSIST(pPersistname);		
		
		RETURN dStandardizeAddr;
	
	END;

END;
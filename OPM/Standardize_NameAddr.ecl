IMPORT AID, ut, NID, codes, Address;

EXPORT Standardize_NameAddr := MODULE	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes people names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNames(DATASET(OPM.Layouts.Base) pPreProcessInput) :=	FUNCTION

		// -- Mapping Clean Person Name - uses NID to clean names
		sendRecs		  := pPreProcessInput(trim(Employee_Name) <> '');
		NotToSendRecs := pPreProcessInput(trim(Employee_Name) = '');

		NID.Mac_CleanFullNames(PROJECT(sendRecs, OPM.Layouts.Base), NID_output, Employee_Name );
		
		OPM.Layouts.Base tCleanPers(NID_output L) := TRANSFORM
			SELF.title		    := if(L.nameType in ['P','D'], L.cln_title,  '');
			SELF.fname	      := if(L.nameType in ['P','D'], L.cln_fname,  '');
			SELF.mname	      := if(L.nameType in ['P','D'], L.cln_mname,  '');
			SELF.lname		    := if(L.nameType in ['P','D'], L.cln_lname,  '');
			SELF.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF						  := L;			
		END;
		
		dStandardizedPerson := project(NID_output, tCleanPers(LEFT)) + NotToSendRecs : INDEPENDENT;
		
    RETURN dStandardizedPerson;

	END;  //End fStandardizeNames
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	
	EXPORT fStandardizeAddresses(dataset(OPM.Layouts.Base) pStandardizeNameInput) :=	function
		
		OPM.Layouts.Base tprepAddr(OPM.Layouts.Base L) :=	TRANSFORM
			
			SELF.prep_Address_line1     := '';
			SELF.prep_Address_line_last := ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.City) + 
																														IF(L.City <> '' and L.State_Code <> '', ', ', '') + 
																														L.State_Code + ' ' + IF(LENGTH(L.Zip5) = 5, L.Zip5, '')
																														);	
  		SELF											  := L;
		END;   
		
		pPrepAddresses    := PROJECT(pStandardizeNameInput, tprepAddr(LEFT));
		
		HasAddress	      := trim(pPrepAddresses.prep_address_line_last, left,right) != '';
										
		dWith_address			:= pPrepAddresses(HasAddress);
		dWithout_address	:= pPrepAddresses(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_address_line1, prep_address_line_last, raw_aid, dwithAID, lFlags);
		
		dBase := project(dwithAID
			               ,transform( Layouts.base
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
																	self							  := left																;
			                          )
		                ) + project(dWithout_address,transform(OPM.Layouts.base, self := left));

		return dBase;
		
	end;   

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(OPM.Layouts.Base) pBaseFile
							,STRING pPersistname = OPM.Persistnames().StandardizeNameAddr) := FUNCTION

  	dStandardizeName	:= fStandardizeNames(pBaseFile);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName) : PERSIST(pPersistname);		
		
		RETURN dStandardizeAddr;
	
	END;

END;
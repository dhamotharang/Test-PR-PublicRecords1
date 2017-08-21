import  Address, aid, NID, ut;

export Standardize_NameAddr :=module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.base) pPreProcessInput) :=function
    
		//Blanking out the name_suffix value for the updates, since we are not receiving suffix from vendor NID macro expects this field to be passed !  
		NID_PreProcessInput :=project(pPreProcessInput, transform(Layouts.base,self.name_suffix:=''; self:= left;));
		
		//*** Cleaning persion names using the new NID name cleaner.
		NID.Mac_CleanParsedNames(	NID_PreProcessInput
															, cleaned_name_output
															, Executive_First_Name
															, Executive_Middle_Initial
															, Executive_Last_Name
															, name_suffix
													  );
    cleaned_name_PreProcessInput := cleaned_name_output;
    
	Layouts.base tStandardizeName(cleaned_name_PreProcessInput l) :=transform
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.title		         	:= l.cln_title;
			self.fname	            := l.cln_fname;
			self.mname	            := l.cln_mname;
			self.lname		         	:= l.cln_lname;
			self.name_suffix	      := l.name_suffix;
			self										:= l;
	end;
	 dStandardizedName := project(cleaned_name_PreProcessInput, tStandardizeName(left));
				
/* *** Cleaning Business_Name field either contain company name or people name ....we are separating those two names 
   with â€œNID_nameâ€ cleaner macro & only true company names will be used in "As_business" likning attribute 
   as well as in Bdid macro. People names which are found in business name filed will be standardized and kept
   in base file and these will not be utilized any other processing at this time! */
		NID.Mac_CleanFullNames(dStandardizedName, VerifyBusRecs, Business_Name);

		person_flags 		:= ['P', 'D'];
		business_flags 	:= ['B', 'U', 'I'];

	  Layouts.base Trans_cleanBusName(VerifyBusRecs L) := TRANSFORM
			SELF.p_title        := IF(L.nametype IN person_flags, L.cln_title, '');
			SELF.p_fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
			SELF.p_mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
			SELF.p_lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
			SELF.p_name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
			SELF.company_name   := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.Business_Name), '');
			SELF 							  := L;
	  END;
		
    d_CleanFullNames      := PROJECT(VerifyBusRecs, Trans_cleanBusName(LEFT))   ;
		
		return d_CleanFullNames;

end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
export fStandardizeAddresses(dataset(Layouts.Base) pStandardizeNameInput) :=function
	
	  // Non-US territory addresses will not be going through AID cleaner since AID macro doesn't support cleaning of NON-US addresses !  
	  list :=['PR','AE','VI','AP','MP','FM','GU','MH','PW'];
		
		HasAddress				:= trim(pStandardizeNameInput.prep_addr_line_last, left,right) != '' and trim(pStandardizeNameInput.state,left,right) not in list;
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
		dBase := project( dwithAID
										  ,transform( Layouts.base
																	,self.ace_aid				:= left.aidwork_acecache.aid					;
																	self.raw_aid				:= left.aidwork_rawaid								;
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
																	self								:= left																;
														)
									)	+ project(dWithout_address,transform(Layouts.base, self := left));

		return dBase;
		
	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	export fAll(dataset(Layouts.Base						) pBaseFile
							,string														pversion
							,string														pPersistname = persistnames().StandardizeNameAddr
							):=function
	
			dStandardizeName	:= fStandardizeName				(pBaseFile);
				
			dStandardizeAddr	:= fStandardizeAddresses	(dStandardizeName) :  persist(pPersistname);

		  return dStandardizeAddr;
	
	end;

end;
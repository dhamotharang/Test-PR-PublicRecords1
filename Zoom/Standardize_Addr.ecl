import  Address, aid, ut, codes;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
export Standardize_Addr (
			
			dataset(Layouts.Base												) pBaseFile
	
	) :=
	function

	// Remove invalid address patterns that were discovered in the original data
  InvalidAddressPatterns	 	:= '^[0-9 ]+$|^P.O. BOX NULL$|^REMOTE$|^[, ]+|^ADDRESS$|^HOME OFFICE$';
  
	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Base l, unsigned8 cnt) :=
	transform
    
    US_Country := ['UNITED STATES','PUERTO RICO','NORTHERN MARIANA ISLANDS'];
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		trimmed_state := ut.CleanSpacesAndUpper(l.rawfields.Company_Address_State);
		trimmed_country := ut.CleanSpacesAndUpper(l.rawfields.Company_Address_Country);
		// Since the state might actually be spelled out, check and convert.
		state_abbr := if(length(trimmed_state) != 2,
		                 ut.st2abbrev(trimmed_state),
										 trimmed_state);
		is_likely_US_country := trimmed_country IN US_Country or
		                        StringLib.StringFind(trimmed_country, 'USA', 1) > 0;
		is_likely_US_address := codes.St2Name(state_abbr) != '' or is_likely_US_country;
		is_address2_ok := state_abbr != '' and regexfind('[0-9]{5}', l.rawfields.Company_Address_Postal[1..5]);

		address1 :=	if(is_likely_US_address,
		               ut.CleanSpacesAndUpper(l.rawfields.Company_Address_Street),
									 '');
		address2 := if(is_address2_ok,
		               if(trim(l.rawfields.Company_Address_City) <> '',
									    ut.CleanSpacesAndUpper(trim(l.rawfields.Company_Address_City) + ', ' +
									                       state_abbr + ' ' + l.rawfields.Company_Address_Postal[1..5]),
									    ut.CleanSpacesAndUpper(state_abbr + ' ' + l.rawfields.Company_Address_Postal[1..5])),
									 '');
			
    /* new changes */
		trimmed_p_state := ut.CleanSpacesAndUpper(l.rawfields.Person_State);
		trimmed_p_country := ut.CleanSpacesAndUpper(l.rawfields.Person_Country);
		// Since the state might actually be spelled out, check and convert.
		p_state_abbr := if(length(trimmed_p_state) != 2,
		                 ut.st2abbrev(trimmed_p_state),
										 trimmed_p_state);
		is_likely_US_p_country := trimmed_p_country IN US_Country or
		                        StringLib.StringFind(trimmed_p_country, 'USA', 1) > 0;
		is_likely_US_p_address := codes.St2Name(p_state_abbr) != '' or is_likely_US_p_country;
		is_p_address_ok := p_state_abbr != '' and regexfind('[0-9]{5}', l.rawfields.Person_ZIP[1..5]);

		per_address1 := if(is_likely_US_p_address,
                       regexreplace(InvalidAddressPatterns, ut.CleanSpacesAndUpper(l.rawfields.Person_Street), ''),		                   
                       // ut.CleanSpacesAndUpper(l.rawfields.Person_Street),
                       '');
		per_address2 := if(is_p_address_ok,
		                   if(trim(l.rawfields.Person_City) <> '',
									        ut.CleanSpacesAndUpper(trim(l.rawfields.Person_City) + ', ' +
									                               p_state_abbr + ' ' + l.rawfields.Person_ZIP[1..5]),
									        ut.CleanSpacesAndUpper(p_state_abbr + ' ' + l.rawfields.Person_ZIP[1..5])),
									        '');
		/* end of new changes*/
															
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////					
		SELF.address1 									:= address1;
		SELF.address2 									:= address2;
		SELF.per_address1 							:= per_address1;
    //The per_address fields are used to run AID.  If we do not have a full address, meaning if we don't have both an
    //address1 and an address2, then we do not want to run AID on the address.  To avoid running AID on an address
    //we blank out the address2 whenever address1 is empty.
		SELF.per_address2 							:= IF(per_address1 <> '', per_address2, '');
    //Historically we did not get the street address from the vendor, so we relied upon the old address.CleanAddress182()
    //function to clean the addresses.  However, recently the vendor has started sending some street addresses that have given
    //us some stronger addresses that we can now send to AID.  We still use the old cleaner if the street is missing. 
		SELF.Clean_Person_address       := IF(per_address1 = '' AND per_address2 <> '',
                                          Address.CleanAddressFieldsFips(address.CleanAddress182((QSTRING) '', per_address2)).addressrecord,
                                          l.Clean_Person_address); 
		SELF.unique_id									:= cnt;
		SELF														:= l; 
	end;
	
	
	dPreAddrRec := project(pBaseFile, tPreProcess(left, counter)) : INDEPENDENT;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- normalize address out into one file with addr1, addr2, type, and uniqueid, then pass to macro
	//////////////////////////////////////////////////////////////////////////////////////
	addresslayout := record
		unsigned8										unique_id			;	//to tie back to original record
		unsigned8										rawaid				;
		unsigned1								  	addr_type			;	// person or business
		string100 									address1	    ;
		string50										address2	    ;
	end;
		
	addresslayout tNormalizeAddress(dPreAddrRec l, unsigned1 cnt) := transform,
  SKIP((cnt = 1 AND trim(L.address2, left, right) = '') OR
       (cnt = 2 AND trim(L.per_address2, left, right) = ''))
		self.unique_id							:= l.unique_id;
		self.addr_type							:= cnt;
		self.address1							  := choose(cnt	,l.address1
																							,l.per_address1	
																);
		self.address2							  := choose(cnt	,l.address2	
																              ,l.per_address2
																);           
		self.rawaid									:= 0;																				 
	end;
		
	dNormAddr	:= normalize(dPreAddrRec, 2, tNormalizeAddress(left,counter));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	dWith_address			:= dNormAddr(trim(address2, left,right) != '');

	unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, RawAID, dwithAID, lFlags);

	// -- match back to dStandardizedFirstPass and append address
	dStandardizeNameInput_dist 	:= DISTRIBUTE(dPreAddrRec         	,unique_id);
	dStandardizeNameInput_sort 	:= SORT(dStandardizeNameInput_dist  ,unique_id, LOCAL);
	dwithAID_dist	            	:= DISTRIBUTE(dwithAID							,unique_id);
	dwithAID_sort	            	:= SORT(dwithAID_dist 							,unique_id, LOCAL);

	Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) := transform
		self.fips_state		:= pRow.county[1..2];
		self.fips_county	:= pRow.county[3..]	;
		self.zip					:= pRow.zip5				;
		self							:= pRow							;
	end;

	Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dwithAID_sort r) := transform
		aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));
		
		self.raw_aid							    := if(r.addr_type = 1	,r.AIDWork_RawAID				 ,l.raw_aid				        );
		self.ace_aid							    := if(r.addr_type = 1	,r.aidwork_acecache.aid	 ,l.ace_aid				        );
		self.Clean_Company_address		:= if(r.addr_type = 1	,aidwork_acecache				 ,l.Clean_Company_address	);

		self.person_raw_aid						:= if(r.addr_type = 2	,r.AIDWork_RawAID				,l.person_raw_aid				  );
		self.person_ace_aid						:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.person_ace_aid				  );
		self.Clean_Person_address			:= if(r.addr_type = 2	,aidwork_acecache				,l.Clean_Person_address	  );
		self 													:= l;
	end;
		
	dAddressAppended	:= denormalize(dStandardizeNameInput_sort
															     ,dwithAID_sort
															     ,left.unique_id = right.unique_id
															     ,tGetStandardizedAddress(left,right)
															     ,local
														      );

  dBase  := project(dAddressAppended,TRANSFORM(Layouts.Base,    self := LEFT));
	return dBase;
end;
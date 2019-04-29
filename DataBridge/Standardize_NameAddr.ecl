﻿IMPORT AID, ut, NID, codes, Address;

EXPORT Standardize_NameAddr := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes people and company names and phone numbers
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNamesPhone(DATASET(DataBridge.Layouts.Base) pPreProcessInput) :=	FUNCTION

		// -- Mapping Clean Person Name - uses NID to clean names
		sendRecs		:= pPreProcessInput(trim(Name_First + Name_Middle_Initial + Name_Last) <> '');
		notSendRecs := pPreProcessInput(trim(Name_First + Name_Middle_Initial + Name_Last) = '');

		NID.Mac_CleanParsedNames(PROJECT(sendRecs, DataBridge.Layouts.Base) 
																		,NID_output
																		,Name_First,Name_Middle_Initial,Name_Last,Suffix);
		
		DataBridge.Layouts.Base tCleanPers(NID_output L) := TRANSFORM
			SELF.title		    := if(L.nameType in ['P','D'], L.cln_title,  '');
			SELF.fname	      := if(L.nameType in ['P','D'], L.cln_fname,  '');
			SELF.mname	      := if(L.nameType in ['P','D'], L.cln_mname,  '');
			SELF.lname		    := if(L.nameType in ['P','D'], L.cln_lname,  '');
			SELF.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF						  := L;			
		END;
		
		dStandardizedPerson := project(NID_output, tCleanPers(LEFT)) + notSendRecs : INDEPENDENT;
	
		
		// -- Mapping Clean company name and clean phone numbers
  	DataBridge.Layouts.Base tMapCleanCompanyName(dStandardizedPerson L) := TRANSFORM
   	  
			SELF.clean_company_name  := ut.CleanSpacesAndUpper(L.Company);
			SELF.clean_area_code     := if(length(trim(L.area_code)) = 3 ,trim(L.area_code),'');
			SELF.clean_telephone_num := if(length(ut.CleanPhone(L.Telephone_Number)) in [7,10] and
																					 ut.CleanPhone(L.Telephone_Number) not in [
																					 '0000000','0000000000','1111111','1111111111',
																					 '2222222','2222222222','3333333','3333333333',
																					 '4444444','4444444444','5555555','5555555555',
																					 '6666666','6666666666','7777777','7777777777',
																					 '8888888','8888888888','9999999','9999999999']
																		,ut.CleanPhone(L.Telephone_Number) ,'');

			SELF								        := L;			
			
		END;
		
		dStandardizedNames := project(dStandardizedPerson, tMapCleanCompanyName(LEFT)) : INDEPENDENT;
			
		RETURN dStandardizedNames;

	END;  //End fStandardizeNamesPhone
	
			
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	
	EXPORT fStandardizeAddresses(dataset(DataBridge.Layouts.Base) pStandardizeNameInput) :=	function
		
		DataBridge.Layouts.Base tprepAddr(DataBridge.Layouts.Base L) :=	TRANSFORM
			
			SELF.prep_Address_line1     := ut.CleanSpacesAndUpper(L.Address + ' ' + L.Address2);	
			SELF.prep_Address_line_last := ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.City) + 
												                IF(L.City <> '' and L.State <> '', ', ', '') + L.State + ' ' +
											                  IF(LENGTH(L.Zip) = 5, L.Zip, ''));
  		SELF											  := L;
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
				self							  := left																;
			)
		)
		+ project(dWithout_address,transform(DataBridge.Layouts.base, self := left));

		return dBase;
		
	end;   

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(DataBridge.Layouts.Base) pBaseFile
							,STRING pversion
							,STRING pPersistname = DataBridge.Persistnames().StandardizeNameAddr) := FUNCTION

  	dStandardizeName	:= fStandardizeNamesPhone(pBaseFile);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName) : PERSIST(pPersistname);		
		
		RETURN dStandardizeAddr;
	
	END;

END;
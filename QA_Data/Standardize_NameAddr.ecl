IMPORT AID, ut, NID, codes, Address;

// Must use the alternate AID cache (non-header version) because the vendor does not send good addresses
// for many of the records
// #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT Standardize_NameAddr := MODULE	

  Layout_Base_Temp := RECORD
	  QA_Data.Layouts.Base;
	  STRING name_suffix  := '';
  END;
	
	Layout_Base_Temp_CName := RECORD
	  QA_Data.Layouts.Base;
	  STRING company_temp := '';
  END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeNames
	// -- Standardizes people and company names and phone numbers
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeNamesPhone(DATASET(QA_Data.Layouts.Base) pPreProcessInput) :=	FUNCTION

		// -- Mapping Clean Person Name - uses NID to clean names
		// The vendor places more importance on the Address File over the Transaction file, 
		// so here is the order of how we will try to populate Clean Person Name:
		//   #1 Check for person name in Addr File person name fields  - "AP" for clean_person_type
		//   #2 Check for person name in Addr File company name field  - "AC" for clean_person_type
		//   #3 Check for person name in Trans File person name field  - "TP" for clean_person_type
		//   #4 Check for person name in Trans File company name field - "TC" for clean_person_type
	
    // #1 "AP" - Check for person name in Addr File person name fields
		AP_send		 := pPreProcessInput(trim(rawAddr.FirstName + rawAddr.MiddleInitial + rawAddr.LastName) <> '');
		AP_notSend := pPreProcessInput(trim(rawAddr.FirstName + rawAddr.MiddleInitial + rawAddr.LastName) = '');

		NID.Mac_CleanParsedNames(PROJECT(AP_send, Layout_Base_Temp) 
																		,AP_output
																		,rawAddr.FirstName,rawAddr.MiddleInitial,rawAddr.LastName,name_suffix);	
		
		QA_Data.Layouts.Base tCleanPersAP(AP_output L) := TRANSFORM
			SELF.clean_person_name.title		    := if(L.nameType in ['P','D'], L.cln_title, '');
			SELF.clean_person_name.fname	      := if(L.nameType in ['P','D'], L.cln_fname, '');
			SELF.clean_person_name.mname	      := if(L.nameType in ['P','D'], L.cln_mname, '');
			SELF.clean_person_name.lname		    := if(L.nameType in ['P','D'], L.cln_lname, '');
			SELF.clean_person_name.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF.clean_person_type              := if(trim(SELF.clean_person_name.fname + SELF.clean_person_name.mname + SELF.clean_person_name.lname) <> ''
																								,'AP' ,'');
			SELF										            := L;			
		END;
		
		AP_Clean := project(AP_output, tCleanPersAP(LEFT)) + AP_notSend : INDEPENDENT;
									
													
	  // #2 "AC" - Check for person name in Addr File company name field 	
		AC_send    := AP_Clean(clean_person_type = '');
		AC_notSend := AP_Clean(clean_person_type <> '');
		
		NID.Mac_CleanFullNames(AC_send, AC_output, rawAddr.Company);
	
		QA_Data.Layouts.Base tCleanPersAC(AC_output L) := TRANSFORM
			SELF.clean_person_name.title		    := if(L.nameType in ['P','D'], L.cln_title, '');
			SELF.clean_person_name.fname	      := if(L.nameType in ['P','D'], L.cln_fname, '');
			SELF.clean_person_name.mname	      := if(L.nameType in ['P','D'], L.cln_mname, '');
			SELF.clean_person_name.lname		    := if(L.nameType in ['P','D'], L.cln_lname, '');
			SELF.clean_person_name.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF.clean_person_type              := if(SELF.clean_person_name.fname + SELF.clean_person_name.mname + SELF.clean_person_name.lname <> ''
																								,'AC' ,'');
		  SELF										            := L;			
		END;	
	
    AC_Clean := project(AC_output, tCleanPersAC(LEFT)) + AC_notSend : INDEPENDENT;
	
  
	  // #3 "TP" - Check for person name in Trans File person name field
		TP_send    := AC_Clean(clean_person_type = '');
		TP_notSend := AC_Clean(clean_person_type <> '');
		
		NID.Mac_CleanFullNames(TP_send, TP_output, rawTrans.Name);
	
		QA_Data.Layouts.Base tCleanPersTP(TP_output L) := TRANSFORM
			SELF.clean_person_name.title		    := if(L.nameType in ['P','D'], L.cln_title, '');
			SELF.clean_person_name.fname	      := if(L.nameType in ['P','D'], L.cln_fname, '');
			SELF.clean_person_name.mname	      := if(L.nameType in ['P','D'], L.cln_mname, '');
			SELF.clean_person_name.lname		    := if(L.nameType in ['P','D'], L.cln_lname, '');
			SELF.clean_person_name.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF.clean_person_type              := if(SELF.clean_person_name.fname + SELF.clean_person_name.mname + SELF.clean_person_name.lname <> ''
																								,'TP' ,'');
		  SELF										            := L;			
		END;	
	
    TP_Clean := project(TP_output, tCleanPersTP(LEFT)) + TP_notSend : INDEPENDENT;

	
	  // #4 "TC" - Check for person name in Trans File company name field 	
		TC_send    := TP_Clean(clean_person_type = '');
		TC_notSend := TP_Clean(clean_person_type <> '');
		
		NID.Mac_CleanFullNames(TC_send, TC_output, rawTrans.Company);
	
		QA_Data.Layouts.Base tCleanPersTC(TC_output L) := TRANSFORM
			SELF.clean_person_name.title		    := if(L.nameType in ['P','D'], L.cln_title, '');
			SELF.clean_person_name.fname	      := if(L.nameType in ['P','D'], L.cln_fname, '');
			SELF.clean_person_name.mname	      := if(L.nameType in ['P','D'], L.cln_mname, '');
			SELF.clean_person_name.lname		    := if(L.nameType in ['P','D'], L.cln_lname, '');
			SELF.clean_person_name.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF.clean_person_type              := if(SELF.clean_person_name.fname + SELF.clean_person_name.mname + SELF.clean_person_name.lname <> ''
																								,'TC' ,'');
		  SELF										            := L;			
		END;	
	
    dStandardizedPerson := project(TC_output, tCleanPersTC(LEFT)) + TC_notSend : INDEPENDENT;
		
		// -- Mapping Clean company name and clean phone numbers
		Layout_Base_Temp_CName tMapCleanCompanyName(dStandardizedPerson L) := TRANSFORM
      //The vendor places more importance on the Address File over the Transaction file, 
			//so we will first try to pull the company name from the Address File.  If the company name 
			//from the Address File is blank, we will try to pull it from the Transaction File.
			//Then if both of those company name fields are blank, we will check the DatabaseMatchCode
			//for 'B' (Business) or 'L' (Likely Business) and concatenate the Address File name fields
			//(First, MI, Last) and store it in company_temp.  That field will be sent through NID to be 
			//checked to see if it is a company name that we can use.
			
			//Clean company name
			SELF.clean_company := map(L.rawAddr.Company  <> '' => L.rawAddr.Company,
																L.rawTrans.Company <> '' => L.rawTrans.Company,
																'');
			SELF.company_temp  := if(SELF.clean_company = '' and L.rawAddr.DatabaseMatchCode in ['B','L']
													     ,ut.CleanSpacesAndUpper(L.rawaddr.FirstName + ' ' + L.rawaddr.MiddleInitial + ' ' + L.rawaddr.LastName)
															 ,'');	
			SELF.nameType      := ''; //blank this out before setting it in the next transform
			
			//Clean phone numbers
			SELF.clean_phone          := QA_Data.Functions.GetCleanPhone(L.rawAddr.Phone);
			SELF										  := L;			
		END;
		
		dtMapCleanCompanyName := project(dStandardizedPerson, tMapCleanCompanyName(LEFT)) : INDEPENDENT;
	
		sendToNID			:= dtMapCleanCompanyName(company_temp <> '');
		notSendToNID  := dtMapCleanCompanyName(company_temp = '');
		
		//*** Use NID name cleaner to identify company names
		NID.Mac_CleanFullNames(sendToNID, dCompany_name_output, company_temp);
		
		dCleanCompany := project(dcompany_name_output, transform(QA_Data.Layouts.Base,
															SELF.clean_company := IF(left.nameType = 'B' ,left.company_temp ,'');
															SELF.nameType      := IF(left.nameType = 'B' ,'B' ,'');
															SELF := left;))
									  + project(notSendToNID, transform(QA_Data.Layouts.Base,
															SELF := left;))	: INDEPENDENT;
									 
		// -- Strip any special (ascii) characters and known invalid names from clean_company
		QA_Data.Layouts.Base tClean(dCleanCompany L) := TRANSFORM
			SELF.clean_company := QA_Data.Functions.GetCleanCompany(l.clean_company);
			SELF							 := L;			
		END;
		
		dStandardizedNames := project(dCleanCompany, tClean(LEFT)) : INDEPENDENT;

		//***************** End of mapping clean company name **********************************
		//Drop records with no company name or person name
		RETURN dStandardizedNames(clean_company + clean_person_type <> '');

	END;  //End fStandardizeNamesPhone
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- fCleanAddress
	//////////////////////////////////////////////////////////////////////////////////////
  EXPORT fCleanAddress( STRING pAddress ) := FUNCTION
	  AddressPass1 := IF(REGEXFIND('^C/O|^ATTN|^GENERAL DELIVERY|STORE MGRFRITO LAY REP|STORE MGR FRITO LAY REP|FRITO-LAY SALES REP|FRNT DOOR|CO THD SHIP TO STORE|LEAVE AT FRONT DOOR|LEAVE AT BACK DOOR|LEAVE WITH DOORMAN|LEAVE ON PORCH|LEAVE ON FRONT PORCH|RECEIVING DEPT|^RECEIVING$|^REF$|^SEE LABEL$|SEE LABEL ON PACKAGE|^STORE$|\\d{3}[-. ]\\d{3}[-. ]\\d{4}', pAddress), '', pAddress);
		AddressPass2 := StringLib.StringSubstituteOut(AddressPass1, '¬µË^ÌØÊÆîåûï½¿ñùÄÍòýºìßÁäÕ¡çü­¤ó®°ÝíÀõ', ' ');
    RETURN AddressPass2;
	END;  //End fCleanAddress

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fStandardizeAddresses
	// -- Standardizes addresses  
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeAddresses(DATASET(QA_Data.Layouts.Base) pStandardizeNameInput, STRING pversion) := FUNCTION

		QA_Data.Layouts.Temporary.UniqueId tAddUniqueId(QA_Data.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
		
			SELF.unique_id						:= cnt;	
			
			// Prep TRANSACTIONS file Address
			prepTrans1 		  :=	ut.CleanSpacesAndUpper(fCleanAddress(L.rawTrans.AddressOne) + ' ' + fCleanAddress(L.rawTrans.AddressTwo));        
			prepTrans2 		  :=	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.rawTrans.City) + 
																			 IF(L.rawTrans.City <> '' and L.rawTrans.State <> '', ', ', '') + L.rawTrans.State + ' ' +
																			 IF(LENGTH(L.rawTrans.PostalCode) >= 5, L.rawTrans.PostalCode[1..5], ''));
 
			string182	clean_TransPrep	:=	Address.CleanAddress182(prepTrans1, prepTrans2);
			Address.Layout_Clean182_fips	clean_TransRec	:=	transfer(clean_TransPrep, Address.Layout_Clean182_fips);
					
			SELF.prep_trans_line1     := IF(clean_TransPrep not in ['','.']  and ut.CleanSpacesAndUpper(clean_TransPrep[1..64]) not in ['0','.']
																			,Address.Addr1FromComponents(clean_TransRec.prim_range,
																																	 clean_TransRec.predir,
																																	 clean_TransRec.prim_name,
																																	 clean_TransRec.addr_suffix,
																																	 clean_TransRec.postdir,
																																	 clean_TransRec.unit_desig,
																																	 clean_TransRec.sec_range)
																			,'');
			SELF.prep_trans_line_last := IF(clean_TransPrep not in ['','.']
																			,Address.Addr2FromComponents(clean_TransRec.p_city_name,
																																	 clean_TransRec.st,
																																	 clean_TransRec.zip)
																			,'');
																			
			// Prep ADDRESS file Address
			prepAddr1 		:=	fCleanAddress(ut.CleanSpacesAndUpper(L.rawAddr.StreetNumber  +' '+ L.rawAddr.PreDirection +' '+ 
																														 L.rawAddr.StreetName    +' '+ L.rawAddr.StreetType   +' '+ 
																														 L.rawAddr.PostDirection +' '+ L.rawAddr.Extension    +' '+ 
																														 L.rawAddr.ExtensionNumber));      
			prepAddr2 		:=	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.rawAddr.City) + 
																							 IF(L.rawAddr.City <> '', ', ', '') + L.rawAddr.State + ' ' +
																							 IF(LENGTH(L.rawAddr.ZipCode) >= 5, L.rawAddr.ZipCode[1..5], ''));
			
			string182	clean_AddrPrep	:=	Address.CleanAddress182(prepAddr1, prepAddr2);
			Address.Layout_Clean182_fips	clean_AddrRec	:=	transfer(clean_AddrPrep, Address.Layout_Clean182_fips);
					
			SELF.prep_addr_line1     := IF(clean_AddrPrep not in ['','.']  and ut.CleanSpacesAndUpper(clean_AddrPrep[1..64]) not in ['0','.']
																			,Address.Addr1FromComponents(clean_AddrRec.prim_range,
																																	 clean_AddrRec.predir,
																																	 clean_AddrRec.prim_name,
																																	 clean_AddrRec.addr_suffix,
																																	 clean_AddrRec.postdir,
																																	 clean_AddrRec.unit_desig,
																																	 clean_AddrRec.sec_range)
																			,'');
			SELF.prep_addr_line_last := IF(clean_AddrPrep not in ['','.']
																			,Address.Addr2FromComponents(clean_AddrRec.p_city_name,
																																	 clean_AddrRec.st,
																																	 clean_AddrRec.zip)
																			,'');

			SELF											:= L;
		END;   
		
		dAddUniqueId := PROJECT(pStandardizeNameInput, tAddUniqueId(LEFT,COUNTER));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro  
	  //////////////////////////////////////////////////////////////////////////////////////
		QA_Data.Layouts.Temporary.AID_prep tCleanInputAddr(QA_Data.Layouts.Temporary.UniqueId L, INTEGER CTR) := TRANSFORM
			//First time through, process Transaction addresses. Second time through process addresses from the Address file
			SELF.prep_line1     := CHOOSE(CTR, L.prep_trans_line1, L.prep_addr_line1);
      SELF.prep_line_last := CHOOSE(CTR, L.prep_trans_line_last, L.prep_addr_line_last);
      SELF.RawAID         := CHOOSE(CTR, L.Trans_RawAID, L.Addr_RawAID);
      SELF.state          := CHOOSE(CTR, L.rawTrans.State, L.rawAddr.State);
      SELF.record_type    := CHOOSE(CTR, 'T', 'A');  // 'T' Transaction file address, 'A' Address file address
			SELF                := L;
			SELF                := [];

    END;  //End tCleanInputAddr

    PreppedInput := NORMALIZE(dAddUniqueId, if(trim(left.prep_addr_line_last) <> '',2,1), tCleanInputAddr(LEFT, COUNTER)) : INDEPENDENT;	
		
		//Get AID for all of the Addresses
		dWith_address			:= PreppedInput(TRIM(prep_line_last, ALL) != '');

// -------------------------------------------------------------------------------------------------------
// USE THE ALTERNATE AID CACHE!!!!!!
// Must use the alternate AID cache (non-header version)
// #constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
// -------------------------------------------------------------------------------------------------------
		UNSIGNED4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
		AID.MacAppendFromRaw_2Line(dWith_address, prep_line1, prep_line_last, RawAID, dwithAID, lFlags);

		dAIDSlim := PROJECT(dwithAID
			,TRANSFORM(QA_Data.Layouts.Temporary.AID_prep,
				SELF.ACEAID				  := LEFT.aidwork_acecache.aid					;
				SELF.RawAID				  := LEFT.aidwork_rawaid								;
				SELF.prim_range			:= LEFT.aidwork_acecache.prim_range		;
				SELF.predir					:= LEFT.aidwork_acecache.predir				;
				SELF.prim_name			:= LEFT.aidwork_acecache.prim_name		;
				SELF.addr_suffix		:= LEFT.aidwork_acecache.addr_suffix	;
				SELF.postdir				:= LEFT.aidwork_acecache.postdir			;
				SELF.unit_desig			:= LEFT.aidwork_acecache.unit_desig		;
				SELF.sec_range			:= LEFT.aidwork_acecache.sec_range		;
				SELF.p_city_name		:= LEFT.aidwork_acecache.p_city_name	;
				SELF.v_city_name		:= LEFT.aidwork_acecache.v_city_name	;
				SELF.st							:= LEFT.aidwork_acecache.st						;
				SELF.zip						:= LEFT.aidwork_acecache.zip5					;
				SELF.zip4						:= LEFT.aidwork_acecache.zip4					;
				SELF.cart						:= LEFT.aidwork_acecache.cart					;
				SELF.cr_sort_sz			:= LEFT.aidwork_acecache.cr_sort_sz		;
				SELF.lot						:= LEFT.aidwork_acecache.lot					;
				SELF.lot_order			:= LEFT.aidwork_acecache.lot_order		;
				SELF.dbpc						:= LEFT.aidwork_acecache.dbpc					;
				SELF.chk_digit			:= LEFT.aidwork_acecache.chk_digit		;
				SELF.rec_type				:= LEFT.aidwork_acecache.rec_type			;
				SELF.fips_state 		:= LEFT.aidwork_acecache.county[1..2]	;
				SELF.fips_county		:= LEFT.aidwork_acecache.county[3..]	;
				SELF.geo_lat				:= LEFT.aidwork_acecache.geo_lat			;
				SELF.geo_long				:= LEFT.aidwork_acecache.geo_long			;
				SELF.msa						:= LEFT.aidwork_acecache.msa					;
				SELF.geo_blk				:= LEFT.aidwork_acecache.geo_blk			;
				SELF.geo_match			:= LEFT.aidwork_acecache.geo_match		;
				SELF.err_stat				:= LEFT.aidwork_acecache.err_stat			;								
				SELF							  := LEFT																;
			)
		);

		QA_Data.Layouts.Temporary.UniqueId tAssignTransAIDs(QA_Data.Layouts.Temporary.UniqueId L, QA_Data.Layouts.Temporary.AID_prep R) := TRANSFORM
		    SELF.prep_trans_line1			        := IF(R.record_type = 'T', R.prep_line1,    L.prep_trans_line1);
				SELF.prep_trans_line_last         := IF(R.record_type = 'T', R.prep_line_last,L.prep_trans_line_last);
		    SELF.Trans_ACEAID				          := IF(R.record_type = 'T', R.ACEAID,        L.Trans_ACEAID);
				SELF.Trans_RawAID				          := IF(R.record_type = 'T', R.RawAID,        L.Trans_RawAID);
				SELF.Trans_address.prim_range			:= IF(R.record_type = 'T', R.prim_range,    L.Trans_address.prim_range);
				SELF.Trans_address.predir					:= IF(R.record_type = 'T', R.predir,        L.Trans_address.predir);
				SELF.Trans_address.prim_name			:= IF(R.record_type = 'T', R.prim_name,     L.Trans_address.prim_name);
				SELF.Trans_address.addr_suffix		:= IF(R.record_type = 'T', R.addr_suffix,   L.Trans_address.addr_suffix);
				SELF.Trans_address.postdir				:= IF(R.record_type = 'T', R.postdir,       L.Trans_address.postdir);
				SELF.Trans_address.unit_desig			:= IF(R.record_type = 'T', R.unit_desig,    L.Trans_address.unit_desig);
				SELF.Trans_address.sec_range			:= IF(R.record_type = 'T', R.sec_range,     L.Trans_address.sec_range);
				SELF.Trans_address.p_city_name		:= IF(R.record_type = 'T', R.p_city_name,   L.Trans_address.p_city_name);
				SELF.Trans_address.v_city_name		:= IF(R.record_type = 'T', R.v_city_name,   L.Trans_address.v_city_name);
				SELF.Trans_address.st							:= IF(R.record_type = 'T', R.st,            L.Trans_address.st);
				SELF.Trans_address.zip						:= IF(R.record_type = 'T', R.zip,           L.Trans_address.zip);
				SELF.Trans_address.zip4						:= IF(R.record_type = 'T', R.zip4,          L.Trans_address.zip4);
				SELF.Trans_address.cart						:= IF(R.record_type = 'T', R.cart,          L.Trans_address.cart);
				SELF.Trans_address.cr_sort_sz			:= IF(R.record_type = 'T', R.cr_sort_sz,    L.Trans_address.cr_sort_sz);
				SELF.Trans_address.lot						:= IF(R.record_type = 'T', R.lot,           L.Trans_address.lot);
				SELF.Trans_address.lot_order			:= IF(R.record_type = 'T', R.lot_order,     L.Trans_address.lot_order);
				SELF.Trans_address.dbpc						:= IF(R.record_type = 'T', R.dbpc,          L.Trans_address.dbpc);
				SELF.Trans_address.chk_digit			:= IF(R.record_type = 'T', R.chk_digit,     L.Trans_address.chk_digit);
				SELF.Trans_address.rec_type				:= IF(R.record_type = 'T', R.rec_type,      L.Trans_address.rec_type);
				SELF.Trans_address.fips_state 		:= IF(R.record_type = 'T', R.fips_state,    L.Trans_address.fips_state);
				SELF.Trans_address.fips_county		:= IF(R.record_type = 'T', R.fips_county,   L.Trans_address.fips_county);
				SELF.Trans_address.geo_lat				:= IF(R.record_type = 'T', R.geo_lat,       L.Trans_address.geo_lat);
				SELF.Trans_address.geo_long				:= IF(R.record_type = 'T', R.geo_long,      L.Trans_address.geo_long);
				SELF.Trans_address.msa						:= IF(R.record_type = 'T', R.msa,           L.Trans_address.msa);
				SELF.Trans_address.geo_blk				:= IF(R.record_type = 'T', R.geo_blk,       L.Trans_address.geo_blk);
				SELF.Trans_address.geo_match			:= IF(R.record_type = 'T', R.geo_match,     L.Trans_address.geo_match);
				SELF.Trans_address.err_stat				:= IF(R.record_type = 'T', R.err_stat,      L.Trans_address.err_stat);
				SELF								              := L;
		END;
		
		QA_Data.Layouts.Base tAssignAddrAIDs(QA_Data.Layouts.Temporary.UniqueId L, QA_Data.Layouts.Temporary.AID_prep R) := TRANSFORM
		    SELF.prep_addr_line1			        := IF(R.record_type = 'A', R.prep_line1,    L.prep_addr_line1);
				SELF.prep_addr_line_last          := IF(R.record_type = 'A', R.prep_line_last,L.prep_addr_line_last);
				SELF.Addr_ACEAID				          := IF(R.record_type = 'A', R.ACEAID,        L.Addr_ACEAID);
				SELF.Addr_RawAID				          := IF(R.record_type = 'A', R.RawAID,        L.Addr_RawAID);
				SELF.Addr_address.prim_range			:= IF(R.record_type = 'A', R.prim_range,    L.Addr_address.prim_range);
				SELF.Addr_address.predir					:= IF(R.record_type = 'A', R.predir,        L.Addr_address.predir);
				SELF.Addr_address.prim_name				:= IF(R.record_type = 'A', R.prim_name,     L.Addr_address.prim_name);
				SELF.Addr_address.addr_suffix			:= IF(R.record_type = 'A', R.addr_suffix,   L.Addr_address.addr_suffix);
				SELF.Addr_address.postdir					:= IF(R.record_type = 'A', R.postdir,       L.Addr_address.postdir);
				SELF.Addr_address.unit_desig			:= IF(R.record_type = 'A', R.unit_desig,    L.Addr_address.unit_desig);
				SELF.Addr_address.sec_range				:= IF(R.record_type = 'A', R.sec_range,     L.Addr_address.sec_range);
				SELF.Addr_address.p_city_name			:= IF(R.record_type = 'A', R.p_city_name,   L.Addr_address.p_city_name);
				SELF.Addr_address.v_city_name			:= IF(R.record_type = 'A', R.v_city_name,   L.Addr_address.v_city_name);
				SELF.Addr_address.st							:= IF(R.record_type = 'A', R.st,            L.Addr_address.st);
				SELF.Addr_address.zip							:= IF(R.record_type = 'A', R.zip,           L.Addr_address.zip);
				SELF.Addr_address.zip4						:= IF(R.record_type = 'A', R.zip4,          L.Addr_address.zip4);
				SELF.Addr_address.cart						:= IF(R.record_type = 'A', R.cart,          L.Addr_address.cart);
				SELF.Addr_address.cr_sort_sz			:= IF(R.record_type = 'A', R.cr_sort_sz,    L.Addr_address.cr_sort_sz);
				SELF.Addr_address.lot							:= IF(R.record_type = 'A', R.lot,           L.Addr_address.lot);
				SELF.Addr_address.lot_order				:= IF(R.record_type = 'A', R.lot_order,     L.Addr_address.lot_order);
				SELF.Addr_address.dbpc						:= IF(R.record_type = 'A', R.dbpc,          L.Addr_address.dbpc);
				SELF.Addr_address.chk_digit				:= IF(R.record_type = 'A', R.chk_digit,     L.Addr_address.chk_digit);
				SELF.Addr_address.rec_type				:= IF(R.record_type = 'A', R.rec_type,      L.Addr_address.rec_type);
				SELF.Addr_address.fips_state 			:= IF(R.record_type = 'A', R.fips_state,    L.Addr_address.fips_state);
				SELF.Addr_address.fips_county			:= IF(R.record_type = 'A', R.fips_county,   L.Addr_address.fips_county);
				SELF.Addr_address.geo_lat					:= IF(R.record_type = 'A', R.geo_lat,       L.Addr_address.geo_lat);
				SELF.Addr_address.geo_long				:= IF(R.record_type = 'A', R.geo_long,      L.Addr_address.geo_long);
				SELF.Addr_address.msa							:= IF(R.record_type = 'A', R.msa,           L.Addr_address.msa);
				SELF.Addr_address.geo_blk					:= IF(R.record_type = 'A', R.geo_blk,       L.Addr_address.geo_blk);
				SELF.Addr_address.geo_match				:= IF(R.record_type = 'A', R.geo_match,     L.Addr_address.geo_match);
				SELF.Addr_address.err_stat				:= IF(R.record_type = 'A', R.err_stat,      L.Addr_address.err_stat);								
				SELF								              := L;
		END;	

    dAddUniqueId_dist := DISTRIBUTE(dAddUniqueId, unique_id);
    dAIDSlim_dist     := DISTRIBUTE(dAIDSlim, unique_id);
		
    dTransAIDBase := JOIN(dAddUniqueId_dist
													,dAIDSlim_dist(record_type = 'T')
													,LEFT.unique_id = RIGHT.unique_id
													,tAssignTransAIDs(LEFT, RIGHT)
													,LEFT OUTER
													,LOCAL);
													
		dTransAIDBase_dis := DISTRIBUTE(dTransAIDBase, unique_id);
													
		dFullAIDBase := JOIN(dTransAIDBase_dis
													,dAIDSlim_dist(record_type = 'A')
													,LEFT.unique_id = RIGHT.unique_id
													,tAssignAddrAIDs(LEFT, RIGHT)
													,LEFT OUTER
													,LOCAL);	
		
		// Add two fields that are a concatenation of state and county fips codes
		QA_Data.Layouts.Base tAdd(dFullAIDBase L) := TRANSFORM
			self.trans_address_fips_state_county := if( l.trans_address.fips_state <> '' and l.trans_address.fips_county <> ''
																								 ,l.trans_address.fips_state + l.trans_address.fips_county
																								 ,'');
			self.addr_address_fips_state_county  := if( l.addr_address.fips_state <> '' and l.addr_address.fips_county <> ''
																								 ,l.addr_address.fips_state + l.addr_address.fips_county
																								 ,'');
			self							                   := L;			
		END;

    dFullAIDBase_fips := project(dFullAIDBase, tAdd(LEFT));
		
		RETURN dFullAIDBase_fips;
		
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(QA_Data.Layouts.Base) pBaseFile
							,STRING pversion
							,STRING pPersistname = QA_Data.Persistnames().StandardizeNameAddr) := FUNCTION

    dPrepBase         := PROJECT(pBaseFile, TRANSFORM(QA_Data.Layouts.Base ,SELF.clean_person_type := ''; SELF := LEFT));
		dStandardizeName	:= fStandardizeNamesPhone(dPrepBase);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName,pversion) : PERSIST(pPersistname);		
		
		RETURN dStandardizeAddr;
	
	END;

END;
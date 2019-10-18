IMPORT ln_propertyv2,BKMortgage,Tools,ut,Address,Census_Data,nid,STD;

EXPORT Map_BK_AssignRelease_Base (STRING	pVersionDate
																	,DATASET(RECORDOF(BKMortgage.Layouts.AssignBase)) dsAssignBK
																	,DATASET(RECORDOF(BKMortgage.Layouts.ReleaseBase)) dsReleaseBK
																	) := MODULE
		SHARED common := MODULE
				EXPORT layout_prep_temp_deed := 
							{LN_Propertyv2.Layout_Prep.Temp.Deed, 
							STRING100 raw_file_name,
							STRING250 orig_borrower_name;
							STRING250 orig_lender_name;
							STRING8 dt_vendor_first_reported, 
							STRING8 dt_vendor_last_reported};
		END;

	SHARED PrepDataSet := MODULE
		//Combine Assignment and Release data into a common normalized layout
		iCombined	:= BKMortgage.Fn_Map_BK2Mortgage(dsAssignBK, dsReleaseBK);
	
		// Adjust layout for replacement records		
		iBkM_L		:=	{STRING1	ReplInd, RECORDOF(iCombined)};
		iBkM_L tRepl(iCombined L) := TRANSFORM
			//SELF.ReplInd := IF(REGEXFIND('REFRESH',L.bk_infile_type),'Y','N');
			SELF.ReplInd := 'N'; //For first run only.  Will uncomment above line after first run.
			SELF:=L;
		END;
	EXPORT	dMortgageRawCombined :=	PROJECT(iCombined, tRepl(LEFT));
		
	END;
		
	// ---------------------------------------------------------------------------------------------------------
	// Mortgage
	// ---------------------------------------------------------------------------------------------------------
	EXPORT mortgage := MODULE
		// Get max value for fares id

		maxLNDeedFaresID			:=MAX(	
																MAX( ln_propertyv2.Files.Prep.LNDeed(ln_fares_id[1..2]	=	'OM')
																		+ln_propertyv2.Files.Prep.LNDeedRepl(ln_fares_id[1..2]	=	'OM'),
																		(UNSIGNED)ln_fares_id[3..]
																	  ),
																MAX(LN_PropertyV2_Fast.Files.prep.deed_mortg (ln_fares_id[1..2]	=	'OM'),
																		(UNSIGNED)ln_fares_id[3..]
																	  )
																)	:	GLOBAL;
																
	code_lkp := Address.County_Names;
	StateCodes_dict	:= DICTIONARY(code_lkp, {state_code => state_alpha});
	CountyCodes_dict := DICTIONARY(code_lkp, {county_code => county_name});
  StCodeLkp(STRING code ) := StateCodes_dict[code].state_alpha;
	CntyCodeLkp(STRING code ) := CountyCodes_dict[code].county_name;
	
	common.layout_prep_temp_deed tMap2Common(RECORDOF(PrepDataSet.dMortgageRawCombined)	pInput,integer	cnt)	:=
		TRANSFORM
			// Temporary variables
			UNSIGNED	vFaresID					:=	maxLNDeedFaresID	+	cnt;
			STRING    vCleanBorrower		:=  LN_Propertyv2.Functions.fCleanName(pInput.ClnBorrowerName);
			
			STRING		vPrepBorrowerMailingUnitNumber		:=	ut.CleanSpacesAndUpper(pInput.BorrMailUnit);
			STRING		vPrepPropertyUnitNumber						:=	ut.CleanSpacesAndUpper(pInput.PropertyUnitNumber);
			
			STRING		vPrepBorrowerMailingStreetAddr		:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.BorrMailFullAddress));
			STRING		vPrepPropertyStreetAddr						:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.PropertyStreetAddress));
			
			// Check if the buyer mailing address unit number exists in the full street address
			UNSIGNED	vBorrowerMailStreetAddrSpaceCount		:=	StringLib.STRINGFindCount(vPrepBorrowerMailingStreetAddr,' ');
			UNSIGNED	vBorrowerMailStreetAddrSpaceRIndex	:=	StringLib.StringFind(vPrepBorrowerMailingStreetAddr,' ',vBorrowerMailStreetAddrSpaceCount);
			STRING		vBorrowerMailStreetAddrUnitNumber		:=	StringLib.StringFilterOut(vPrepBorrowerMailingStreetAddr[vBorrowerMailStreetAddrSpaceRIndex+1..vBorrowerMailStreetAddrSpaceRIndex+6],'#');
			
			STRING		vBorrowerMailingUnitNumber					:=	IF(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepBorrowerMailingStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vBorrowerMailStreetAddrUnitNumber)	AND	vPrepBorrowerMailingUnitNumber	!=	'',
																													'',
																													vPrepBorrowerMailingUnitNumber
																												);
																												
		 // Check if the property address unit number exists in the full street address
			UNSIGNED	vPropertyStreetAddrSpaceCount			:=	StringLib.STRINGFindCount(vPrepPropertyStreetAddr,' ');
			UNSIGNED	vPropertyStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepPropertyStreetAddr,' ',vPropertyStreetAddrSpaceCount);
			STRING		vPropertyStreetAddrUnitNumber			:=	StringLib.StringFilterOut(vPrepPropertyStreetAddr[vPropertyStreetAddrSpaceRIndex+1..vPropertyStreetAddrSpaceRIndex+6],'#');
			
			STRING		vPropertyUnitNumber								:=	IF(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vPropertyStreetAddrUnitNumber)	AND	vPrepPropertyUnitNumber	!=	'',
																													'',
																													vPrepPropertyUnitNumber
																												);
			
			STRING		vPrepHI_Situs_Unit_Number					:=	REGEXREPLACE('^[0]*$',ut.CleanSpacesAndUpper(pInput.HI_Situs_Unit_Number),''); 
			STRING6		vHawaiiPropertyAddressUnitNumber	:=	IF(	STRINGlib.STRINGfind(vPrepHI_Situs_Unit_Number,vPrepPropertyUnitNumber,1)	!=	0,
																													vPrepPropertyUnitNumber,
																													IF(	~REGEXFIND('[A-Za-z]+|[-]',vPrepHI_Situs_Unit_Number,NOCASE),
																															vPrepHI_Situs_Unit_Number,
																															''
																														)
																												);
			
			SELF.ln_fares_id													:=	'OM'	+	INTFORMAT(vFaresID,10,1);
			SELF.process_date													:=	pVersionDate;
			SELF.vendor_source_flag										:=	'O';
			SELF.from_file														:=	'M';
			SELF.fips_code														:=	pInput.FIPSCode;
			SELF.state																:=	StCodeLkp(pInput.FIPSCode[1..2]);
			SELF.county_name													:=	CntyCodeLkp(pInput.FIPSCode[3..5]);
			SELF.record_type													:=	pInput.RecType;
			SELF.apnt_or_pin_number										:=	pInput.APNNumber;
			SELF.multi_apn_flag												:=	pInput.MultiAPNFlag;
			SELF.tax_id_number												:=	pInput.TaxIDNumber;
			SELF.buyer_or_borrower_ind								:=	'B';
			SELF.name1																:=	vCleanBorrower;
			SELF.mailing_street												:=	vPrepBorrowerMailingStreetAddr;
			SELF.mailing_unit_number									:=	IF(SELF.state !=	'HI',
																												pInput.BorrMailUnit,
																												IF(LENGTH(ut.CleanSpacesAndUpper(vHawaiiPropertyAddressUnitNumber))	>	6,
																														vHawaiiPropertyAddressUnitNumber,
																														pInput.BorrMailUnit
																													)
																											);
			SELF.mailing_csz														:=	Address.Addr2FromComponentsWithZip4(	
																																													pInput.BorrMailCity,
																																													pInput.BorrMailState,
																																													pInput.BorrMailZip,
																																													pInput.BorrMailZip4
																																													);
			SELF.property_full_street_address						:=	vPrepPropertyStreetAddr;
			SELF.property_address_unit_number						:=	pInput.PropertyUnitNumber;
			SELF.property_address_citystatezip					:=	Address.Addr2FromComponentsWithZip4(pInput.PropertyCityName,
																																													pInput.PropertyState,
																																													pInput.PropertyZip,
																																													pInput.PropertyZip4
																																													);
			SELF.recording_date													:=	pInput.recording_date;																									
			SELF.contract_date													:=	pInput.contract_date;
			SELF.document_number												:=	pInput.document_number;
			SELF.document_type_code											:=	pInput.DocumentType;
			SELF.loan_number														:=	pInput.LoanNumber;
			SELF.recorder_book_number										:=	pInput.recorder_book_number;
			SELF.recorder_page_number										:=	pInput.recorder_page_number;
			SELF.first_td_loan_amount										:=	pInput.loan_amount;
			SELF.first_td_due_date											:=	pInput.MortgagePayoffDate;
			SELF.lender_name														:=	pInput.Clnlenderben;
			SELF.lender_name_id													:=	pInput.LenderNameID;
			SELF.lender_dba_aka_name										:=	pInput.DBALenderBen;
			SELF.hawaii_tct															:=	pInput.Hawaii_TCT;
			SELF.hawaii_condo_cpr_code									:=	pInput.HI_Condo_CPR_HPR;
			SELF.data_source_code												:=	pInput.DataSourceCode;
			SELF.main_record_id_code										:=	pInput.MainAddendum;
			SELF.Append_ReplRecordInd										:=	pInput.ReplInd;
			SELF.Append_PrepMailingAddr1								:=	ut.CleanSpacesAndUpper(vPrepBorrowerMailingStreetAddr	+	' '	+	vBorrowerMailingUnitNumber);
			SELF.Append_PrepMailingAddr2								:=	REGEXREPLACE(	'([0]{5}|[,])$',
																																		ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(SELF.mailing_csz)),
																																		''
																																	);
			SELF.Append_PrepPropertyAddr1								:=	ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr	+	' '	+	vPropertyUnitNumber);
			SELF.Append_PrepPropertyAddr2								:=	REGEXREPLACE(	'([0]{5}|[,])$',
																																		ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(SELF.property_address_citystatezip)),
																																		''
																																		);
	//Original names only needed for addl_name_info file
			SELF.orig_borrower_name											:=	pInput.BorrowerName;
			SELF.orig_lender_name												:=	pInput.lender_name;
	
	//BK builds weekly, so including file dates rather than process date for first/last seen dates
			SELF.dt_vendor_first_reported								:=	pInput.date_vendor_first_reported;
			SELF.dt_vendor_last_reported								:=	pInput.date_vendor_last_reported;
			SELF																				:=	pInput;
			SELF																				:=	[];
		end;

		EXPORT dMortgage2Common	:=	PROJECT(PrepDataSet.dMortgageRawCombined,tMap2Common(LEFT,COUNTER)) :INDEPENDENT;
		
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	PROJECT(dMortgage2Common,LN_PropertyV2_Fast.Layout_prep_deed_mortg);
			
	END;
	
		// ---------------------------------------------------------------------------------------------------------
	EXPORT AddlNameInfo 	:= MODULE
		
		// Generate other name records for lender and buyer names
		LN_PropertyV2.Layout_Prep.Temp.AddlNameInfo	tAddlNames(common.layout_prep_temp_deed	pInput)	:= TRANSFORM
			SELF.other_borrower_names	:=	IF(TRIM(pInput.name1,ALL) = TRIM(pInput.orig_borrower_name,ALL),'',pInput.orig_borrower_name);
			SELF.other_lender_names		:=	IF(TRIM(pInput.lender_name,ALL) = TRIM(pInput.orig_lender_name,ALL),'',pInput.orig_lender_name);
			SELF						:=	pInput;
		END;
		
		EXPORT dAddlNamesPrep	:=	PROJECT(mortgage.dMortgage2Common,tAddlNames(LEFT));
		
		// Filter to remove blanks
		EXPORT dNew			:=	dAddlNamesPrep(TRIM(other_borrower_names,ALL) <> '' or TRIM(other_lender_names,ALL) <> '');
	
	END;
	
	// ---------------------------------------------------------------------------------------------------------
	// Search
	// ---------------------------------------------------------------------------------------------------------
	EXPORT search 		:= MODULE	
		// --------- BUILD SEARCH FROM MORTGAGE
		// Normalize the Mortgage file by name to create an intial Mortgage search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageName(common.layout_prep_temp_deed	pInput)	:= TRANSFORM
			STRING	vDateSeen							:=	IF(	LENGTH(ut.CleanSpacesAndUpper(pInput.recording_date))	IN	[6,8]	AND	~REGEXFIND('^[0]+$',ut.CleanSpacesAndUpper(pInput.recording_date)),
																						ut.CleanSpacesAndUpper(pInput.recording_date)[1..6],
																						ut.CleanSpacesAndUpper(pInput.contract_date)[1..6]
																					);
			
			SELF.dt_first_seen						:=	(UNSIGNED3)vDateSeen;
			SELF.dt_last_seen							:=	(UNSIGNED3)vDateSeen;
			SELF.dt_vendor_first_reported	:=	(UNSIGNED3)pInput.dt_vendor_first_reported[1..6];
			SELF.dt_vendor_last_reported	:=	(UNSIGNED3)pInput.dt_vendor_last_reported[1..6];
			SELF.process_date							:=	pVersionDate;
			SELF.nameasis									:=	REGEXREPLACE('(, AND| ,AND)', pInput.name1, ' AND');
			SELF.which_orig								:=	'1';
			SELF.source_code							:=	'B';
			SELF													:=	pInput;
			SELF													:=	[];
		END;
		
		dMortgageName	:=	PROJECT(mortgage.dMortgage2Common,tMortgageName(LEFT));
		
		// Normalize the Mortgage search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		TRANSFORM
			SELF.Append_PrepAddr1									:=	CHOOSE(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			SELF.Append_PrepAddr2									:=	CHOOSE(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			SELF.ln_buyer_mailing_country_code 		:=  CHOOSE(cnt,pInput.ln_buyer_mailing_country_code,'', '');
			SELF.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	CHOOSE(cnt,'B','P');
			SELF																	:=	pInput;
		end;
		
		dMortgageNormAddr	:=	NORMALIZE(dMortgageName(nameasis	!=	''),2,tMortgageNormAddr(LEFT,COUNTER));
		dMortgageSearch	:=	dMortgageNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		
		// Clean name and addresses in the search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tSearchPrepAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput)	:= TRANSFORM
			SELF.Append_PrepAddr2	:=	IF(	pInput.Append_PrepAddr1	!=	''	and	pInput.Append_PrepAddr2	=	'',
																		'UNKNOWN 12345',
																		pInput.Append_PrepAddr2
																	);
			SELF									:=	pInput;
		end;
		
		dSearchPrepAddr	:=	PROJECT(dMortgageSearch,tSearchPrepAddr(LEFT));
		
		//Pull U.S. Mailing & Property Addresses for the Search File 
		prop_addr			:= dSearchPrepAddr(source_code[2]='P');	
		not_prop_addr	:= dSearchPrepAddr(source_code[2]<>'P');
		
		dom_buyer 		:= not_prop_addr(ln_buyer_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);

		domestic_filter := prop_addr + dom_buyer;
		
		//clean and normalize cleaned names
		nid.mac_cleanfullnames(domestic_filter, dSearchCleanName, nameasis, nid, ln_entity_type, title, fname, mname, lname, name_suffix,,,,,,,,,,true, c_name, true);
		dSearchCleanName tNormSearchCleanNames(dSearchCleanName L, integer C) := TRANSFORM
				SELF.title 					:= choose(c, if(L.ln_entity_type not in ['B','T'], L.title, ''), 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_title2<>'', L.cln_title2, 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_title2='', L.title, '')));
				SELF.fname 					:= choose(c, if(L.ln_entity_type not in ['B','T'], L.fname, ''), 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_fname2<>'', L.cln_fname2, 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_fname2='', L.fname, '')));
				SELF.mname 					:= choose(c, if(L.ln_entity_type not in ['B','T'], L.mname, ''), 
																						if(L.ln_entity_type not in ['B','T'] and (L.cln_mname2<>'' or L.cln_lname2<>''), L.cln_mname2, 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_mname2='' and L.cln_lname2='', L.mname, '')));
				SELF.lname 					:= choose(c, if(L.ln_entity_type not in ['B','T'], L.lname, ''), 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_lname2<>'', L.cln_lname2, 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_lname2='', L.lname, '')));
				SELF.name_suffix  	:= choose(c, if(L.ln_entity_type not in ['B','T'], L.name_suffix, ''), 
																						if(L.ln_entity_type not in ['B','T'] and (L.cln_suffix2<>'' or L.cln_lname2<>''), L.cln_suffix2, 
																						if(L.ln_entity_type not in ['B','T'] and L.cln_suffix2='' and L.cln_lname2='', L.name_suffix, '')));

				vStandardizeName					:= LN_PropertyV2.Prep_Name.fnStandardizeName(L.nameasis);	
				SELF.cname								:= if(L.ln_entity_type in ['B','T','U'] and l.c_name<>'', l.c_name, 
																				if(L.ln_entity_type in ['B','T','U'] and l.c_name='', LN_PropertyV2.Prep_Name.fnClean2Upper(vStandardizeName),''));
				SELF.conjunctive_name_seq := (string)c; // dedup will throw out duplicates for no second names
				SELF := L;
		END;
		
		dSearchCleanNormName := dedup(sort(normalize(dSearchCleanName,2,tNormSearchCleanNames(LEFT,counter)),
																	record,local),record, EXCEPT conjunctive_name_seq,local);
		
		LN_Propertyv2.Append_AID(dSearchCleanNormName,dSearchCleanAddr,false);
		dSearchAID	:=	dSearchCleanAddr;
		
		//Reformat to bring to base file layouts
		EXPORT dNew	:=	project(dSearchAID, LN_PropertyV2_Fast.Layout_prep_search_prp);
	
	END;
END;
IMPORT ln_propertyv2,BKMortgage,Tools,ut,Address,Census_Data,nid,STD;

EXPORT Map_BK_AssignRelease_Base (STRING	pVersionDate
																	,DATASET(RECORDOF(BKMortgage.Layouts.AssignBase)) dsAssignBK
																	,DATASET(RECORDOF(BKMortgage.Layouts.ReleaseBase)) dsReleaseBK
																	,DATASET(RECORDOF(LN_PropertyV2_Fast.Layout_prep_deed_mortg)) dBKMortgage
																	) := MODULE
		SHARED common := MODULE
				EXPORT layout_prep_temp_deed := 
							{LN_Propertyv2.Layout_Prep.Temp.Deed, 
							STRING100 raw_file_name,
							STRING500 OtherBorrowerName,
							STRING500 orig_borrower_name;
							STRING500 orig_lender_name;
							STRING8 dt_vendor_first_reported, 
							STRING8 dt_vendor_last_reported};
		
				EXPORT layout_prep_temp_addl_name :=
							{LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp,
							STRING8 dt_vendor_first_reported, //Needed for search file
							STRING8 dt_vendor_last_reported};
		END;

	SHARED ARPrepDataSet := MODULE
		//Combine Assignment and Release data into a common normalized layout
		iCombined	:= BKMortgage.Fn_Map_BK2Mortgage(dsAssignBK, dsReleaseBK);
	
		// Adjust layout for replacement records		
		iBkM_L		:=	{STRING1	ReplInd, RECORDOF(iCombined)};
		iBkM_L tRepl(iCombined L) := TRANSFORM
			SELF.ReplInd := IF(REGEXFIND('REFRESH',L.bk_infile_type),'Y','N');
			//SELF.ReplInd := 'N'; //For first run only.  Will uncomment above line after first run.
			SELF:=L;
		END;
		EXPORT dARMortgageRawCombined :=	PROJECT(iCombined, tRepl(LEFT));
		
	END;
		
	// ---------------------------------------------------------------------------------------------------------
	// Mortgage
	// ---------------------------------------------------------------------------------------------------------
	EXPORT armortgage := MODULE
		// Get max value for fares id

		maxLNFaresID			:=MAX(	
																MAX(     ln_propertyv2.Files.Prep.LNMortgage(ln_fares_id[1..2] = 'OM')
																	+	 ln_propertyv2.Files.Prep.LNMortgageRepl(ln_fares_id[1..2] = 'OM'),
																		(UNSIGNED)ln_fares_id[3..]),
																MAX(LN_PropertyV2_Fast.Files.prep.deed_mortg(ln_fares_id[1..2] = 'OM'),
																		(UNSIGNED)ln_fares_id[3..]),
																MAX(                             dBKMortgage(ln_fares_id[1..2] = 'OM'),
																		(UNSIGNED)ln_fares_id[3..])
																)	:	GLOBAL;
																
	code_lkp := Address.County_Names;
	StateCodes_dict	:= DICTIONARY(code_lkp, {state_code => state_alpha});
  StCodeLkp(STRING code ) := StateCodes_dict[code].state_alpha;
	CntyCodeLkp(STRING code ) := Address.County_Names(state_code = code[1..2] AND county_code = code[3..5])[1].county_name;
	
	common.layout_prep_temp_deed tMap2Common(RECORDOF(ARPrepDataSet.dARMortgageRawCombined)	pInput,integer	cnt)	:=
		TRANSFORM
			// Temporary variables
			UNSIGNED	vFaresID					:=	maxLNFaresID	+	cnt;
			STRING    vCleanBorrower1		:=  LN_Propertyv2.Functions.fCleanName(pInput.BorrowerName1);
			STRING    vCleanBorrower2		:=  LN_Propertyv2.Functions.fCleanName(pInput.BorrowerName2);
			
			STRING		vPrepBorrowerMailingUnitNumber		:=	ut.CleanSpacesAndUpper(pInput.BorrMailUnit);
			STRING		vPrepPropertyUnitNumber						:=	ut.CleanSpacesAndUpper(pInput.PropertyUnitNumber);
			
			STRING		vPrepBorrowerMailingStreetAddr		:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.BorrMailFullAddress));
			STRING		vPrepPropertyStreetAddr						:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.PropertyStreetAddress));
			
			STRING		vPropertyUnitNumber								:=	vPrepPropertyUnitNumber;
			
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
			SELF.county_name													:=	CntyCodeLkp(pInput.FIPSCode);
			SELF.record_type													:=	pInput.RecType;
			SELF.apnt_or_pin_number										:=	pInput.APNNumber;
			SELF.multi_apn_flag												:=	pInput.MultiAPNFlag;
			SELF.tax_id_number												:=	IF(REGEXFIND('[A-Z]',pInput.TaxIDNumber), '', pInput.TaxIDNumber);//Skewed records are causing invalid taxID's
			SELF.buyer_or_borrower_ind								:=	'B';
			SELF.name1																:=	vCleanBorrower1;
			SELF.name2																:=	vCleanBorrower2;
			SELF.mailing_street												:=	vPrepBorrowerMailingStreetAddr;
			SELF.mailing_unit_number									:=	IF(SELF.state !=	'HI',
																												pInput.BorrMailUnit,
																												IF(LENGTH(ut.CleanSpacesAndUpper(vHawaiiPropertyAddressUnitNumber))	>	6,
																														vHawaiiPropertyAddressUnitNumber,
																														pInput.BorrMailUnit
																													)
																											);
			SELF.mailing_csz														:=	Address.Addr2FromComponents(pInput.BorrMailCity,
																																									pInput.BorrMailState,
																																									pInput.BorrMailZip[1..5],
																																									);
			SELF.property_full_street_address						:=	vPrepPropertyStreetAddr;
			SELF.property_address_unit_number						:=	pInput.PropertyUnitNumber;
			SELF.property_address_citystatezip					:=	Address.Addr2FromComponents(pInput.PropertyCityName,
																																											pInput.PropertyState,
																																											pInput.PropertyZip[1..5],
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
			SELF.Append_PrepMailingAddr1								:=	Address.fn_addr_clean_prep(TRIM(vPrepBorrowerMailingStreetAddr)	+	' '	+	TRIM(vPrepBorrowerMailingUnitNumber),'first');
			SELF.Append_PrepMailingAddr2								:=	REGEXREPLACE(	'([0]{5}|[,])$',
																																		STD.Str.CleanSpaces(SELF.mailing_csz),
																																		''
																																	);
			SELF.Append_PrepPropertyAddr1								:=	Address.fn_addr_clean_prep(TRIM(vPrepPropertyStreetAddr)	+	' '	+	TRIM(vPrepPropertyUnitNumber),'first');
			SELF.Append_PrepPropertyAddr2								:=	REGEXREPLACE(	'([0]{5}|[,])$',
																																		STD.Str.CleanSpaces(SELF.property_address_citystatezip),
																																		''
																																		);
	//Original names only needed for addl_name_info file
			SELF.OtherBorrowerName											:= 	pInput.OtherBorrowerName; //additional borrower names
			SELF.orig_borrower_name											:=	pInput.BorrowerName;
			SELF.orig_lender_name												:=	pInput.lender_name;
	
			SELF.dt_vendor_first_reported								:=	pInput.date_vendor_first_reported;
			SELF.dt_vendor_last_reported								:=	pInput.date_vendor_last_reported;
			SELF																				:=	pInput;
			SELF																				:=	[];
		END;

		EXPORT dARMortgage2Common	:=	PROJECT(ARPrepDataSet.dARMortgageRawCombined,tMap2Common(LEFT,COUNTER)) :INDEPENDENT;
		
		// Reformat to bring to base file layouts
		pMortgage				:=	PROJECT(dARMortgage2Common,LN_PropertyV2_Fast.Layout_prep_deed_mortg);
		EXPORT dNew			:=	DEDUP(SORT(pMortgage,ln_fares_id,apnt_or_pin_number),RECORD,ALL);
			
	END;
	
		// ---------------------------------------------------------------------------------------------------------
	EXPORT AddlNameInfo 	:= MODULE
		
		// Original name records for lender and buyer names if input field exceeds base file field length
		LN_PropertyV2.Layout_Prep.Temp.AddlNameInfo	tAddlNames(common.layout_prep_temp_deed	pInput)	:= TRANSFORM
			SELF.other_borrower_names	:=	IF(TRIM(pInput.name1,ALL) = TRIM(pInput.orig_borrower_name,ALL),'',
																			IF(LENGTH(TRIM(pInput.orig_borrower_name)) > 80, pInput.orig_borrower_name, ''));
			SELF.other_lender_names		:=	IF(TRIM(pInput.lender_name,ALL) = TRIM(pInput.orig_lender_name,ALL),'',
																			IF(LENGTH(TRIM(pInput.orig_lender_name)) > 40, pInput.orig_lender_name, ''));
			SELF						:=	pInput;
		END;

		//Limit to only records that exceed the lender/borrower name length
		filterAddlNames := armortgage.dARMortgage2Common(LENGTH(TRIM(orig_borrower_name)) > 80 OR LENGTH(TRIM(orig_lender_name)) > 40);
		
		EXPORT dAddlNamesPrep	:=	PROJECT(filterAddlNames,tAddlNames(LEFT));
		
		// Filter to remove blanks
		EXPORT dNew			:=	dAddlNamesPrep(TRIM(other_borrower_names,ALL) <> '' OR TRIM(other_lender_names,ALL) <> '');
	
	END;
	
	// ---------------------------------------------------------------------------------------------------------
	// Additional Names (Borrower)
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlNames 	:= MODULE
		//Addl Borrower Names
		dAddlBorrower := armortgage.dARMortgage2Common(TRIM(OtherBorrowerName) <> '');
		// Addl buyer clean
		LN_Propertyv2.Functions.CleanFields(dAddlBorrower,dAddlBorrowerClean);
	
		// Populate fares id for addl borrower records
		common.layout_prep_temp_addl_name	tAddlNameFaresID(common.layout_prep_temp_deed	le)	:= TRANSFORM
			STRING	vDateSeen						:=	IF(STD.Str.CleanSpaces(le.recording_date) <> '', STD.Str.CleanSpaces(le.recording_date), STD.Str.CleanSpaces(le.contract_date));
			set of string words 				:=	STD.STr.SplitWords(le.OtherBorrowerName, ';');
			string	vBorrower3					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>0, words[1],le.OtherBorrowerName);
			string	vBorrower4					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>0, words[2],'');
			string	vBorrower5					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>1, words[3],'');
			string	vBorrower6					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>2, words[4],'');
			string	vBorrower7					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>3, words[5],'');
			string	vBorrower8					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>4, words[6],'');
			string	vBorrower9					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>5, words[7],'');
			string	vBorrower10					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>6, words[8],'');
			string	vBorrower11					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>7, words[9],'');
			string	vBorrower12					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>8, words[10],'');
			string	vBorrower13					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>9, words[11],'');
			string	vBorrower14					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>10, words[12],'');
			string	vBorrower15					:=	IF(STD.Str.FindCount(le.OtherBorrowerName,';')>11, words[13],'');
			
			self.ln_fares_id						:=	le.ln_fares_id;
			self.dt_first_seen					:=	vDateSeen;
			self.dt_last_seen						:=	vDateSeen;
			self.buyer_seller_ind				:=	'B';
			self.borrower3							:=	LN_Propertyv2.Functions.fCleanName(vBorrower3);
			self.borrower4							:=	LN_Propertyv2.Functions.fCleanName(vBorrower4);
			self.borrower5							:=	LN_Propertyv2.Functions.fCleanName(vBorrower5);
			self.borrower6							:=	LN_Propertyv2.Functions.fCleanName(vBorrower6);
			self.borrower7							:=	LN_Propertyv2.Functions.fCleanName(vBorrower7);
			self.borrower8							:=	LN_Propertyv2.Functions.fCleanName(vBorrower8);
			self.borrower9							:=	LN_Propertyv2.Functions.fCleanName(vBorrower9);
			self.borrower10							:=	LN_Propertyv2.Functions.fCleanName(vBorrower10);
			self.borrower11							:=	LN_Propertyv2.Functions.fCleanName(vBorrower11);
			self.borrower12							:=	LN_Propertyv2.Functions.fCleanName(vBorrower12);
			self.borrower13							:=	LN_Propertyv2.Functions.fCleanName(vBorrower13);
			self.borrower14							:=	LN_Propertyv2.Functions.fCleanName(vBorrower14);
			self.borrower15							:=	LN_Propertyv2.Functions.fCleanName(vBorrower15);
			SELF.replacement_record_ind	:=	le.Append_ReplRecordInd;
			self												:=	le;
			SELF												:=	[];
		end;
		
		EXPORT dAddlNameFaresID	:=	PROJECT(dAddlBorrowerClean,tAddlNameFaresID(LEFT));
		
		// Normalize combined addl borrower file to create base file
		LN_PropertyV2.Layout_Prep.Temp.AddlName	tNormalizeAddlName(common.layout_prep_temp_addl_name	pInput,integer	cnt)	:=
		TRANSFORM
			self.buyer_or_seller			:=	pInput.buyer_seller_ind;
			self.name_seq							:=	(string)(2	+	cnt);
			self.name									:=	STD.Str.CleanSpaces(choose(	cnt,
																												pInput.borrower3,
																												pInput.borrower4,
																												pInput.borrower5,
																												pInput.borrower6,
																												pInput.borrower7,
																												pInput.borrower8,
																												pInput.borrower9,
																												pInput.borrower10,
																												pInput.borrower11,
																												pInput.borrower12,
																												pInput.borrower13,
																												pInput.borrower14,
																												pInput.borrower15
																												));
			SELF.id_code							:=	'';
			self.Append_ReplRecordInd	:=	pInput.replacement_record_ind;
			self											:=	pInput;
		END;
		
		dAddlNamePrep	:=	NORMALIZE(dAddlNameFaresID,13,tNormalizeAddlName(left,counter));
		
		// Reformat to bring to base file layouts
		SHARED pAddlNamePrep	:= PROJECT(dAddlNamePrep(name	!=	''),LN_PropertyV2_Fast.Layout_prep_addl_names);
		EXPORT dNew						:= DEDUP(SORT(pAddlNamePrep,ln_fares_id,apnt_or_pin_number,name), RECORD, ALL);

	END;
	
	// ---------------------------------------------------------------------------------------------------------
	// Search
	// ---------------------------------------------------------------------------------------------------------
	EXPORT search 		:= MODULE	
		// --------- BUILD SEARCH FROM MORTGAGE
		// Normalize the Mortgage file by name to create an intial Mortgage search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageName(common.layout_prep_temp_deed	pInput,integer	cnt)	:= TRANSFORM
			STRING	vDateSeen							:=	IF(STD.Str.CleanSpaces(pInput.recording_date) <> '', STD.Str.CleanSpaces(pInput.recording_date), STD.Str.CleanSpaces(pInput.contract_date));		
			SELF.dt_first_seen						:=	(UNSIGNED3)vDateSeen;
			SELF.dt_last_seen							:=	(UNSIGNED3)vDateSeen;
			SELF.dt_vendor_first_reported	:=	(UNSIGNED3)pInput.dt_vendor_first_reported[1..6];
			SELF.dt_vendor_last_reported	:=	(UNSIGNED3)pInput.dt_vendor_last_reported[1..6];
			SELF.process_date							:=	pVersionDate;
			SELF.nameasis									:=	CHOOSE(cnt,pInput.name1,pInput.name2);
			//SELF.nameasis									:=	REGEXREPLACE('(, AND| ,AND)', TempName, ' AND');
			SELF.which_orig								:=	CHOOSE(cnt,'1','2');
			SELF.source_code							:=	'B';
			SELF													:=	pInput;
			SELF													:=	[];
		END;
		
		dMortgageNormName	:=	normalize(armortgage.dARMortgage2Common,2,tMortgageName(left,counter));	
		
		// Normalize the Mortgage search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		TRANSFORM
			SELF.Append_PrepAddr1									:=	CHOOSE(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			SELF.Append_PrepAddr2									:=	CHOOSE(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			SELF.ln_buyer_mailing_country_code 		:=  CHOOSE(cnt,pInput.ln_buyer_mailing_country_code,'');
			SELF.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	CHOOSE(cnt,'B','P');
			SELF																	:=	pInput;
		end;
		
		dMortgageNormAddr	:=	NORMALIZE(dMortgageNormName(nameasis	!=	''),2,tMortgageNormAddr(LEFT,COUNTER));
		dMortgageSearch	:=	dMortgageNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		
		// --------- BUILD SEARCH FROM DEED ADDL NAMES SPLIT
		// Normalize addl name file by name
			LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(common.layout_prep_temp_addl_name	pInput,integer	cnt)	:=
			transform
				self.Append_ReplRecordInd			:=	pInput.replacement_record_ind;
				self.dt_vendor_first_reported	:=	(UNSIGNED3)pInput.dt_vendor_first_reported[1..6];
				self.dt_vendor_last_reported	:=	(UNSIGNED3)pInput.dt_vendor_last_reported[1..6];
				self.dt_first_seen						:=	(unsigned3)pInput.dt_first_seen;
				self.dt_last_seen							:=	(unsigned3)pInput.dt_last_seen;
				self.vendor_source_flag				:=	'O';
				self.process_date							:=	pVersionDate;
				self.source_code							:=	pInput.buyer_seller_ind;
				self.which_orig								:=	(string)(2	+	cnt);
				self.nameasis									:=	choose(	cnt,
																									pInput.borrower3,
																									pInput.borrower4,
																									pInput.borrower5,
																									pInput.borrower6,
																									pInput.borrower7,
																									pInput.borrower8,
																									pInput.borrower9,
																									pInput.borrower10,
																									pInput.borrower11,
																									pInput.borrower12,
																									pInput.borrower13,
																									pInput.borrower14,
																									pInput.borrower15
																								);
				
				self													:=	pInput;
				self													:=	[];
			end;
			
		dAddlNameNormName	:=	normalize(addlNames.dAddlNameFaresID,13,tNormalizeAddlNameSearch(left,counter));
		// Normalize addl name search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		transform
			self.Append_PrepAddr1									:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2									:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 		:=  choose(cnt,pInput.ln_buyer_mailing_country_code,'');
			self.ln_seller_mailing_country_code 	:=  '';		
			self.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'B','P');
			self																	:=	pInput;
		end;
		dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),2,tNormalizeAddlNameAddr(left,counter));	
		dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- COMBINE DEED AND ADDL NAME SEARCHES
		// Combine all the search files (normalized files from addl names and Mortgage)
		dSearchCombined	:=	dAddlNameSearch	+	dMortgageSearch;

		// Clean name and addresses in the search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tSearchPrepAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput)	:= TRANSFORM
			SELF.nameasis					:=	REGEXREPLACE('(, AND| ,AND)', pInput.nameasis, ' AND'); //Making it consistent for cleaner
			SELF.Append_PrepAddr2	:=	IF(	pInput.Append_PrepAddr1	!=	''	and	pInput.Append_PrepAddr2	=	'',
																		'UNKNOWN 12345',
																		pInput.Append_PrepAddr2
																	);
			SELF									:=	pInput;
		end;
		
		dSearchPrepAddr	:=	PROJECT(dSearchCombined,tSearchPrepAddr(LEFT));
		
		//Pull U.S. Mailing & Property Addresses for the Search File 
		prop_addr			:= dSearchPrepAddr(source_code[2]='P');	
		not_prop_addr	:= dSearchPrepAddr(source_code[2]<>'P');
		
		//dom_buyer 		:= not_prop_addr(ln_buyer_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']); //Not Applicable

		domestic_filter := prop_addr + not_prop_addr;
		
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
		
		//LN_Propertyv2.Append_AID(dSearchCleanNormName,dSearchCleanAddr,false); // DF-28245 unify multiple calls to AID into a single call
		//dSearchAID	:=	dSearchCleanAddr;
		
		//Reformat to bring to base file layouts
		EXPORT dNew	:=	project(dSearchCleanNormName(nameasis	!=	''), LN_PropertyV2_Fast.Layout_prep_search_prp);
	
	END;
END;
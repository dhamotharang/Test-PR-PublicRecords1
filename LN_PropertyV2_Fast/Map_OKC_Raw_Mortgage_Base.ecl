/*2014-07-11T21:47:48Z (Gabriel Marcan_prod)
updated to latest dev version
*/
IMPORT ln_propertyv2,Tools,ut,Address,Census_Data,nid;

EXPORT Map_OKC_Raw_Mortgage_Base(string	pVersionDate,
																	dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage)) iRokMn,
																	dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_mortgage)) iRokMr
																) := MODULE
		SHARED common := MODULE
					EXPORT layout_prep_temp_deed := {LN_Propertyv2.Layout_Prep.Temp.Deed, string100 raw_file_name};
		END;

	SHARED PrepDataSet := MODULE

		// Adjust layout for replacement records
		iRokM_L		:=	{string1	ReplInd, recordof(iRokMn)};
		iRokM_L tRepl(iRokMn L, string1 isRepl) := TRANSFORM
			SELF.ReplInd := isRepl;
			SELF:=L;
		END;
		dMortgageRawCombined :=	PROJECT(iRokMn, tRepl(LEFT,'N')) + PROJECT(iRokMr, tRepl(LEFT,'Y'));		
		
		// Split out the addl buyer, seller and main records from the combined file
		dAddlBorrowerRaw	:=	dMortgageRawCombined(RecordID	=	'D');
		dMortgageMainRaw	:=	dMortgageRawCombined(RecordID	=	'M');
		dMortgageUnusedRaw := dMortgageRawCombined(RecordID	not in ['M','D']);
		
		// Redefine format the layout
		//l := {LN_Propertyv2.Layout_Prep.In.Mortgage, string100 raw_file_name};
		Tools.mac_RedefineFormat(dAddlBorrowerRaw,LN_Propertyv2.Layout_Prep.In.AddlBorrower	,dAddlBorrowerReformat,pShouldExport	:=	false);
		//Tools.mac_RedefineFormat(dMortgageMainRaw,l,dMortgageMainReformat,pShouldExport	:=	false);
		
		EXPORT reformatted := MODULE
			EXPORT dAddlBorrowerRef := dAddlBorrowerReformat;
			EXPORT dMortgageRef := LN_PropertyV2_Fast.Reformat_raw_bk_mortgage(dMortgageMainRaw);
		END;
		
	END;
	
	// ---------------------------------------------------------------------------------------------------------
	// Mortgage
	// ---------------------------------------------------------------------------------------------------------
	EXPORT mortgage := MODULE
		// Get max value for fares id
		
		maxLNMortgageFaresID			:=	MAX(
																		MAX(     ln_propertyv2.Files.Prep.LNMortgage(ln_fares_id[1..2]	=	'OM')
																			+  ln_propertyv2.Files.Prep.LNMortgageRepl(ln_fares_id[1..2]	=	'OM'),
																			(UNSIGNED)ln_fares_id[3..]),
																		MAX(LN_PropertyV2_Fast.Files.prep.deed_mortg(ln_fares_id[1..2]	=	'OM'),
																			(UNSIGNED)ln_fares_id[3..])
																		)	:	global;
		
	
		// Remove names with start with SG and map to common layout
		common.layout_prep_temp_deed	tMap2Common(PrepDataSet.reformatted.dMortgageRef	pInput,integer	cnt)	:=
			transform
			// Temporary variables
			unsigned	vFaresID													:=	maxLNMortgageFaresID	+	cnt;
			
			string		vBorrower1												:=		pInput.borrower1_last_or_corp_name
																											+	if(pInput.borrower1_last_or_corp_name	!=	''	and	pInput.borrower1_first_middle_name	!=	'',', ','')
																											+	pInput.borrower1_first_middle_name;
			string		vBorrower2												:=		pInput.borrower2_last_or_corp_name
																											+	if(pInput.borrower2_last_or_corp_name	!=	''	and	pInput.borrower2_first_middle_name	!=	'',', ','')
																											+	pInput.borrower2_first_middle_name;
			
			//Fix Truncated Names
			trNameB1           := LN_PropertyV2_Fast.Functions_Truncated_Names(vBorrower1);
			trNameB2           := LN_PropertyV2_Fast.Functions_Truncated_Names(vBorrower2);

			string     vCleanBorrower1             :=            LN_Propertyv2.Functions.fCleanName(trNameB1);
			string     vCleanBorrower2             :=            LN_Propertyv2.Functions.fCleanName(trNameB2);

			string		vPrepBorrowerMailingUnitNumber		:=	ut.CleanSpacesAndUpper(pInput.borrower_mailing_unit_number);
			string		vPrepPropertyUnitNumber						:=	ut.CleanSpacesAndUpper(pInput.property_address_unit_number);
			
			string		vPrepBorrowerMailingStreetAddr		:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.borrower_mailing_full_street_address));
			string		vPrepPropertyStreetAddr						:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.property_full_street_address));
			
			// Check if the Borrower mailing address unit number exists in the full street address
			unsigned	vBorrowerMailStreetAddrSpaceCount	:=	StringLib.stringFindCount(vPrepBorrowerMailingStreetAddr,' ');
			unsigned	vBorrowerMailStreetAddrSpaceRIndex:=	StringLib.StringFind(vPrepBorrowerMailingStreetAddr,' ',vBorrowerMailStreetAddrSpaceCount);
			string		vBorrowerMailStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vPrepBorrowerMailingStreetAddr[vBorrowerMailStreetAddrSpaceRIndex+1..vBorrowerMailStreetAddrSpaceRIndex+6],'#');
			
			string		vBorrowerMailingUnitNumber				:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepBorrowerMailingStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vBorrowerMailStreetAddrUnitNumber)	and	vPrepBorrowerMailingUnitNumber	!=	'',
																													'',
																													vPrepBorrowerMailingUnitNumber
																												);
			
			// Check if the property address unit number exists in the full street address
			unsigned	vPropertyStreetAddrSpaceCount			:=	StringLib.stringFindCount(vPrepPropertyStreetAddr,' ');
			unsigned	vPropertyStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepPropertyStreetAddr,' ',vPropertyStreetAddrSpaceCount);
			string		vPropertyStreetAddrUnitNumber			:=	StringLib.StringFilterOut(vPrepPropertyStreetAddr[vPropertyStreetAddrSpaceRIndex+1..vPropertyStreetAddrSpaceRIndex+6],'#');
			
			string		vPropertyUnitNumber								:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vPropertyStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
																													'',
																													vPrepPropertyUnitNumber
																												);
			
			self.ln_fares_id														:=	'OM'	+	intformat(vFaresID,10,1);
			self.process_date														:=	pVersionDate;
			self.vendor_source_flag											:=	'O';
			self.from_file															:=	'M';
			self.buyer_or_borrower_ind									:=	'B';
			self.apnt_or_pin_number											:=	pInput.apn_number;
			self.name1_id_code													:=	pInput.borrower1_id_code;
			self.name2_id_code													:=	pInput.borrower2_id_code;
			self.name1																	:=	vCleanBorrower1;
			self.name2																	:=	vCleanBorrower2;
			self.vesting_code														:=	pInput.borrower_vesting_code;
			self.mailing_street													:=	pInput.borrower_mailing_full_street_address;
			self.mailing_unit_number										:=	pInput.borrower_mailing_unit_number;
			self.mailing_csz														:=	Address.Addr2FromComponentsWithZip4(	pInput.borrower_mailing_city,
																																														pInput.borrower_mailing_state,
																																														pInput.borrower_mailing_zip_code,
																																														pInput.borrower_mailing_zip_4
																																													);
			self.property_address_citystatezip					:=	Address.Addr2FromComponentsWithZip4(	pInput.property_address_city,
																																														pInput.property_address_state,
																																														pInput.property_address_zip_code,
																																														pInput.property_address_zip_4
																																													);
			self.property_address_unit_number						:=	pInput.property_address_unit_number;
			self.lender_address_citystatezip						:=	Address.Addr2FromComponentsWithZip4(	pInput.lender_address_city,
																																														pInput.lender_address_state,
																																														pInput.lender_address_zip_code,
																																														pInput.lender_address_zip_4
																																													);
			self.recording_date													:=	case(	length(ut.CleanSpacesAndUpper(pInput.recording_date)),
																														8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																														6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																														pInput.recording_date
																													);
			self.contract_date													:=	case(	length(ut.CleanSpacesAndUpper(pInput.contract_date)),
																														8	=>	pInput.contract_date[5..8]	+	pInput.contract_date[1..4],
																														6	=>	pInput.contract_date[3..6]	+	pInput.contract_date[1..2],
																														pInput.contract_date
																													);
			self.first_td_due_date											:=	case(	length(ut.CleanSpacesAndUpper(pInput.first_td_due_date)),
																														8	=>	pInput.first_td_due_date[5..8]	+	pInput.first_td_due_date[1..4],
																														6	=>	pInput.first_td_due_date[3..6]	+	pInput.first_td_due_date[1..2],
																														pInput.first_td_due_date
																													);
			self.rate_change_frequency									:=	if(	length(ut.CleanSpacesAndUpper(pInput.rate_change_frequency))	>	1,
																													'',
																													ut.CleanSpacesAndUpper(pInput.rate_change_frequency)
																												);
			self.Append_ReplRecordInd										:=	pInput.replacement_record_ind;
			self.Append_PrepMailingAddr1								:=	ut.CleanSpacesAndUpper(vPrepBorrowerMailingStreetAddr	+	' '	+	vBorrowerMailingUnitNumber);
			self.Append_PrepMailingAddr2								:=	regexreplace(	'([0]{5}|[,])$',
																																		ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.mailing_csz)),
																																		''
																																	);
			self.Append_PrepPropertyAddr1								:=	ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr	+	' '	+	vPropertyUnitNumber);
			self.Append_PrepPropertyAddr2								:=	regexreplace(	'([0]{5}|[,])$',
																																		ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.property_address_citystatezip)),
																																		''
																																	);
			
			self																				:=	pInput;
			self																				:=	[];
		end;
		
		dMortgage2Common	:=	project(PrepDataSet.reformatted.dMortgageRef,tMap2Common(left,counter)) :independent;

		// Populate fipscode
		common.layout_prep_temp_deed tMortgageFipscode(dMortgage2Common L, Census_Data.File_Fips2County R) := 
			TRANSFORM
					self.fips_code	:=	if(L.fips_code	!=	'',L.fips_code,R.state_fips	+	R.county_fips);
					self						:=	L;
			END;
			
		dFipsCode	:= join(	dMortgage2Common,
																Census_Data.File_Fips2County,
																ut.CleanSpacesAndUpper(left.state)				=	ut.CleanSpacesAndUpper(right.state_code)	and
																ut.CleanSpacesAndUpper(left.county_name)	=	ut.CleanSpacesAndUpper(right.county_name),
																tMortgageFipscode(LEFT,RIGHT), left outer,lookup);
		
		LN_PropertyV2_Fast.MAC_CtryCodeOwnSellDeed(dFipsCode, dDeedCommon);
		
		EXPORT dMortgageFipscode :=	dDeedCommon;
		
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	project(dMortgageFipscode,LN_PropertyV2_Fast.Layout_prep_deed_mortg);
			
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Additional Names (Borrower)
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlNames 	:= MODULE
		// Addl buyer clean
		LN_Propertyv2.Functions.CleanFields(PrepDataSet.reformatted.dAddlBorrowerRef,dAddlBorrowerClean);
		// Distribute files
		LN_Propertyv2.Layout_Prep.In.AddlBorrower tAddlBorrowerClean(dAddlBorrowerClean L) :=
			TRANSFORM
				self.recording_date	:= 	LN_PropertyV2_Fast.fn_formatDate(L.recording_date);
				self								:=	L;
			END;
		dAddlBorrowerCleanDist		:=	distribute(	project(dAddlBorrowerClean,tAddlBorrowerClean(LEFT)),
																								hash32(record_type,state,county_name,fips_code,apnt_or_pin_number));
		// Distribute Mortgage file
		dMortgageFipscodeDist	:=	distribute(mortgage.dMortgageFipscode,hash32(record_type,state,county_name,fips_code,apnt_or_pin_number));
		
		// Populate fares id for addl borrower records
		LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp	tAddlNameFaresID(common.layout_prep_temp_deed	le,LN_PropertyV2.Layout_Prep.In.AddlBorrower	ri)	:=
			TRANSFORM
			string	vDateSeen						:=	if(	length(ut.CleanSpacesAndUpper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(le.recording_date)),
																					ut.CleanSpacesAndUpper(le.recording_date)[1..6],
																					ut.CleanSpacesAndUpper(le.contract_date)[1..6]
																				);
			string	vBorrower3					:=		ri.borrower3_last_or_corp_name
																			+	if(ri.borrower3_last_or_corp_name	!=	''	and	ri.borrower3_first_middle_name	!=	'',', ','')
																			+	ri.borrower3_first_middle_name;
			string	vBorrower4					:=		ri.borrower4_last_or_corp_name
																			+	if(ri.borrower4_last_or_corp_name	!=	''	and	ri.borrower4_first_middle_name	!=	'',', ','')
																			+	ri.borrower4_first_middle_name;
			string	vBorrower5					:=		ri.borrower5_last_or_corp_name
																			+	if(ri.borrower5_last_or_corp_name	!=	''	and	ri.borrower5_first_middle_name	!=	'',', ','')
																			+	ri.borrower5_first_middle_name;
			string	vBorrower6					:=		ri.borrower6_last_or_corp_name
																			+	if(ri.borrower6_last_or_corp_name	!=	''	and	ri.borrower6_first_middle_name	!=	'',', ','')
																			+	ri.borrower6_first_middle_name;
			string	vBorrower7					:=		ri.borrower7_last_or_corp_name
																			+	if(ri.borrower7_last_or_corp_name	!=	''	and	ri.borrower7_first_middle_name	!=	'',', ','')
																			+	ri.borrower7_first_middle_name;
			string	vBorrower8					:=		ri.borrower8_last_or_corp_name
																			+	if(ri.borrower8_last_or_corp_name	!=	''	and	ri.borrower8_first_middle_name	!=	'',', ','')
																			+	ri.borrower8_first_middle_name;
			string	vBorrower9					:=		ri.borrower9_last_or_corp_name
																			+	if(ri.borrower9_last_or_corp_name	!=	''	and	ri.borrower9_first_middle_name	!=	'',', ','')
																			+	ri.borrower9_first_middle_name;
			// to address Jira DF-13391
			string	vBorrower10					:=		regexreplace('0',ri.borrower10_last_or_corp_name,' ')
																			+	if(regexreplace('0',ri.borrower10_last_or_corp_name,' ')	!=	''	and	ri.borrower10_first_middle_name	!=	'',', ','')
																			+	regexreplace('0',ri.borrower10_first_middle_name,' ');
			// ** end Jira DF-13391 **
			string	vBorrower11					:=		ri.borrower11_last_or_corp_name
																			+	if(ri.borrower11_last_or_corp_name	!=	''	and	ri.borrower11_first_middle_name	!=	'',', ','')
																			+	ri.borrower11_first_middle_name;
			string	vBorrower12					:=		ri.borrower12_last_or_corp_name
																			+	if(ri.borrower12_last_or_corp_name	!=	''	and	ri.borrower12_first_middle_name	!=	'',', ','')
																			+	ri.borrower12_first_middle_name;
			string	vBorrower13					:=		ri.borrower13_last_or_corp_name
																			+	if(ri.borrower13_last_or_corp_name	!=	''	and	ri.borrower13_first_middle_name	!=	'',', ','')
																			+	ri.borrower13_first_middle_name;
			string	vBorrower14					:=		ri.borrower14_last_or_corp_name
																			+	if(ri.borrower14_last_or_corp_name	!=	''	and	ri.borrower14_first_middle_name	!=	'',', ','')
																			+	ri.borrower14_first_middle_name;
			string	vBorrower15					:=		ri.borrower15_last_or_corp_name
																			+	if(ri.borrower15_last_or_corp_name	!=	''	and	ri.borrower15_first_middle_name	!=	'',', ','')
																			+	ri.borrower15_first_middle_name;
			
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
			self												:=	le;
			self												:=	ri;
		end;
		
		EXPORT dAddlNameFaresID	:=	join(	dMortgageFipscodeDist,
																dAddlBorrowerCleanDist,
																left.Append_ReplRecordInd	=	right.replacement_record_ind	and
																left.record_type					=	right.record_type							and
																left.state								=	right.state										and
																left.county_name					=	right.county_name							and
																left.fips_code						=	right.fips_code								and
																left.apnt_or_pin_number		=	right.apnt_or_pin_number			and
																left.recording_date				=	right.recording_date					and
																left.recorder_book_number	=	right.recorder_book_number		and
																left.recorder_page_number	=	right.recorder_page_number		and
																left.document_number			=	right.document_number,
																tAddlNameFaresID(left,right),
																local
															);
		
		// Normalize combined addl borrower file to create base file
		LN_PropertyV2.Layout_Prep.Temp.AddlName	tNormalizeAddlName(LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp	pInput,integer	cnt)	:=
		TRANSFORM
			self.buyer_or_seller			:=	pInput.buyer_seller_ind;
			self.name_seq							:=	(string)(2	+	cnt);
			self.name									:=	choose(	cnt,
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
			self.id_code							:=	choose(	cnt,
																						pInput.borrower3_id_code,
																						pInput.borrower4_id_code,
																						pInput.borrower5_id_code,
																						pInput.borrower6_id_code,
																						pInput.borrower7_id_code,
																						pInput.borrower8_id_code,
																						pInput.borrower9_id_code,
																						pInput.borrower10_id_code,
																						pInput.borrower11_id_code,
																						pInput.borrower12_id_code,
																						pInput.borrower13_id_code,
																						pInput.borrower14_id_code,
																						pInput.borrower15_id_code
																					);
			self.Append_ReplRecordInd	:=	pInput.replacement_record_ind;
			self											:=	pInput;
		end;
		
		SHARED dAddlNamePrep	:=	normalize(dAddlNameFaresID,13,tNormalizeAddlName(left,counter));
		
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	project(dAddlNamePrep(name	!=	''),LN_PropertyV2_Fast.Layout_prep_addl_names);

	END;
	// ---------------------------------------------------------------------------------------------------------
	// Search
	// ---------------------------------------------------------------------------------------------------------
	EXPORT search 		:= MODULE	
		// --------- BUILD SEARCH FROM MORTGAGE
		// Normalize the Mortgage file by name to create an intial Mortgage search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageNormName(common.layout_prep_temp_deed	pInput,integer	cnt)	:=
		transform
			string	vDateSeen							:=	if(	length(ut.CleanSpacesAndUpper(pInput.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(pInput.recording_date)),
																						ut.CleanSpacesAndUpper(pInput.recording_date)[1..6],
																						ut.CleanSpacesAndUpper(pInput.contract_date)[1..6]
																					);
			
			self.dt_first_seen						:=	(unsigned3)vDateSeen;
			self.dt_last_seen							:=	(unsigned3)vDateSeen;
			self.dt_vendor_first_reported	:=	(unsigned3)pVersionDate[1..6];
			self.dt_vendor_last_reported	:=	(unsigned3)pVersionDate[1..6];
			self.process_date							:=	pVersionDate;
			self.nameasis									:=	choose(cnt,pInput.name1,pInput.name2);
			self.which_orig								:=	choose(cnt,'1','2');
			self.source_code							:=	'B';
			self													:=	pInput;
			self													:=	[];
		end;
		
		dMortgageNormName	:=	normalize(mortgage.dMortgageFipscode,2,tMortgageNormName(left,counter));
		// Normalize the Mortgage search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		transform
			self.Append_PrepAddr1									:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2									:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 		:=  choose(cnt,pInput.ln_buyer_mailing_country_code,'', '');
			self.ln_seller_mailing_country_code 	:=  choose(cnt,'',pInput.ln_seller_mailing_country_code, '');	
			self.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'B','P');
			self																	:=	pInput;
		end;
		
		dMortgageNormAddr	:=	normalize(dMortgageNormName(nameasis	!=	''),2,tMortgageNormAddr(left,counter));
		dMortgageSearch	:=	dMortgageNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- BUILD SEARCH FROM DEED ADDL NAMES SPLIT
		// Normalize addl name file by name
			LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp	pInput,integer	cnt)	:=
			transform
				self.Append_ReplRecordInd			:=	pInput.replacement_record_ind;
				self.dt_vendor_first_reported	:=	(unsigned3)pVersionDate[1..6];
				self.dt_vendor_last_reported	:=	(unsigned3)pVersionDate[1..6];
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
			self.ln_buyer_mailing_country_code 		:=  choose(cnt,pInput.ln_buyer_mailing_country_code,'', '');
			self.ln_seller_mailing_country_code 	:=  choose(cnt,'',pInput.ln_seller_mailing_country_code, '');		
			self.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'B','P');
			self																	:=	pInput;
		end;
		dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),2,tNormalizeAddlNameAddr(left,counter));	
		dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- COMBINE DEED AND ADDL NAME SEARCHES
		// Combine all the search files (normalized files from addl names and Mortgage)
		dSearchCombined	:=	dAddlNameSearch	+	dMortgageSearch;
		
		// Clean name and addresses in the search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tSearchPrepAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput)	:=
		transform
			self.Append_PrepAddr2	:=	if(	pInput.Append_PrepAddr1	!=	''	and	pInput.Append_PrepAddr2	=	'',
																		'UNKNOWN 12345',
																		pInput.Append_PrepAddr2
																	);
			self									:=	pInput;
		end;
		
		dSearchPrepAddr	:=	project(dSearchCombined,tSearchPrepAddr(left));
		
		//Pull U.S. Mailing & Property Addresses for the Search File 
		prop_addr			:= dSearchPrepAddr(source_code[2]='P');	
		not_prop_addr	:= dSearchPrepAddr(source_code[2]<>'P');
		
		dom_buyer 		:= not_prop_addr(ln_buyer_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);
		dom_seller 		:= not_prop_addr(ln_seller_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);

		domestic_filter := prop_addr + dom_buyer + dom_seller;
		
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
				SELF.cname								:= if(L.ln_entity_type in ['B','T'] and l.c_name<>'', l.c_name, 
																				if(L.ln_entity_type in ['B','T'] and l.c_name='', LN_PropertyV2.Prep_Name.fnClean2Upper(vStandardizeName),''));
				SELF.conjunctive_name_seq := (string)c; // dedup will throw out duplicates for no second names
				SELF := L;
		END;
		
		dSearchCleanNormName := dedup(sort(normalize(dSearchCleanName,2,tNormSearchCleanNames(LEFT,counter)),
																	record,local),record, EXCEPT conjunctive_name_seq,local);
		
		// LN_Propertyv2.Append_AID(dSearchCleanNormName,dSearchCleanAddr,false); // DF-28245 unify multiple calls to AID into a single call
		// dSearchAID	:=	dSearchCleanAddr;
		
		//Reformat to bring to base file layouts
		EXPORT dNew	:=	project(dSearchCleanNormName, LN_PropertyV2_Fast.Layout_prep_search_prp);
	
	END;
END;
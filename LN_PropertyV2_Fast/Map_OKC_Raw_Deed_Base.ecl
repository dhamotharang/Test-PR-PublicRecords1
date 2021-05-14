/*2014-08-21T00:14:42Z (Gabriel Marcan_prod)
 Epic: Multi-APN deed transactions https://bugzilla.seisint.com/show_bug.cgi?id=162911
*/
IMPORT aid,ln_propertyv2,Tools,ut,Address,Census_Data,LN_PropertyV2_Fast,nid;

EXPORT Map_OKC_Raw_Deed_Base(string	pVersionDate,
														dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_deed)) iRokDn,
														dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_deed)) iRokDr
														) := MODULE
		SHARED common := MODULE
					EXPORT layout_prep_temp_deed := {LN_Propertyv2.Layout_Prep.Temp.Deed, string100 raw_file_name};
		END;
	SHARED PrepDataSet := MODULE
		// Adjust layout for replacement records
		iRokD_Lr		:=	{																string1 ReplInd, recordof(iRokDn)};
		iRokD_Lra		:=	{string1 BuyerSellerInd := '', 	string1	ReplInd, recordof(iRokDn)};
		
		iRokD_Lr tRepl(iRokDn L, string1 isRepl) := TRANSFORM
			SELF.ReplInd := isRepl;
			SELF := L;
		END;
	
		dDeedRawCombined :=	PROJECT(iRokDn, tRepl(LEFT,'N')) + PROJECT(iRokDr, tRepl(LEFT,'Y'));
		
		iRokD_Lra tBOInd(dDeedRawCombined L, string1 boInd) := TRANSFORM
			SELF.BuyerSellerInd := boInd;
			SELF := L;
		END;
		dAddlBuyerSellerRaw :=	PROJECT(dDeedRawCombined(MainRecordCode = 'B'), tBOInd(LEFT,'O'))
													+ PROJECT(dDeedRawCombined(MainRecordCode = 'S'), tBOInd(LEFT,'S'));
		
		// Split out datasets
		// Split out the addl name, legal and main records from the combined file
	
		dDeedMainRaw		:=	dDeedRawCombined(MainRecordCode	in ['M','A']);
		
		dDeedUnusedRaw	:=	dDeedRawCombined(MainRecordCode	not in	['B','M','S','A']);
		
		// Redefine format the layout
		//l := {LN_Propertyv2.Layout_Prep.In.Deed, string100 raw_file_name};
		//Tools.mac_RedefineFormat(dDeedMainRaw,l,dDeedMainReformat,pShouldExport	:=	false);
		
		Tools.mac_RedefineFormat(dAddlBuyerSellerRaw,LN_Propertyv2.Layout_Prep.In.AddlBuyerSeller	,dAddlBuyerSellerReformat	,pShouldExport	:=	false);
	
		EXPORT reformatted := MODULE
			EXPORT dAddlNamesRef := dAddlBuyerSellerReformat;
			EXPORT dDeedsRef := LN_PropertyV2_Fast.Reformat_raw_bk_deed(dDeedMainRaw);
			EXPORT dDeedRawCombine := dDeedRawCombined;
		END;
	END;
	EXPORT debug := PrepDataSet.reformatted.dDeedRawCombine;
	// ---------------------------------------------------------------------------------------------------------
	// Deed
	// ---------------------------------------------------------------------------------------------------------
	EXPORT deed := MODULE
		// Get max value for fares id

		maxLNDeedFaresID			:=max(	
																max( ln_propertyv2.Files.Prep.LNDeed(ln_fares_id[1..2]	=	'OD')
																		+ln_propertyv2.Files.Prep.LNDeedRepl(ln_fares_id[1..2]	=	'OD'),
																		(unsigned)ln_fares_id[3..]
																	  ),
																max(LN_PropertyV2_Fast.Files.prep.deed_mortg (ln_fares_id[1..2]	=	'OD'),
																		(unsigned)ln_fares_id[3..]
																	  )
																)	:	global;
		// Remove names with start with SG and map to common layout
		
		common.layout_prep_temp_deed tMap2Common(recordof(PrepDataSet.reformatted.dDeedsRef)	pInput,integer	cnt)	:=
		TRANSFORM
			// Temporary variables
			unsigned	vFaresID													:=	maxLNDeedFaresID	+	cnt;
			
			string		vBuyer1														:=		pInput.buyer1_last_or_corp_name
																											+	if(pInput.buyer1_last_or_corp_name	!=	''	and	pInput.buyer1_first_middle_name	!=	'',', ','')
																											+	pInput.buyer1_first_middle_name;
			string		vBuyer2														:=		pInput.buyer2_last_or_corp_name
																											+	if(pInput.buyer2_last_or_corp_name	!=	''	and	pInput.buyer2_first_middle_name	!=	'',', ','')
																											+	pInput.buyer2_first_middle_name;
			string		vSeller1													:=		pInput.seller1_last_or_corp_name
																											+	if(pInput.seller1_last_or_corp_name	!=	''	and	pInput.seller1_first_middle_name	!=	'',', ','')
																											+	pInput.seller1_first_middle_name;
			string		vSeller2													:=		pInput.seller2_last_or_corp_name
																											+	if(pInput.seller2_last_or_corp_name	!=	''	and	pInput.seller2_first_middle_name	!=	'',', ','')
																											+	pInput.seller2_first_middle_name;
			
			//Fix Truncated Names
			trNameB1           := LN_PropertyV2_Fast.Functions_Truncated_Names(vBuyer1);
			trNameB2           := LN_PropertyV2_Fast.Functions_Truncated_Names(vBuyer2);
			trNameS1           := LN_PropertyV2_Fast.Functions_Truncated_Names(vSeller1);
			trNameS2           := LN_PropertyV2_Fast.Functions_Truncated_Names(vSeller2);

			string     vCleanBuyer1    :=            LN_Propertyv2.Functions.fCleanName(trNameB1);
			string     vCleanBuyer2    :=            LN_Propertyv2.Functions.fCleanName(trNameB2);
			string     vCleanSeller1   :=            LN_Propertyv2.Functions.fCleanName(trNameS1);
			string     vCleanSeller2   :=            LN_Propertyv2.Functions.fCleanName(trNameS2);         

			
			string		vPrepBuyerMailingUnitNumber				:=	ut.CleanSpacesAndUpper(pInput.buyer_mailing_address_unit_number);
			string		vPrepSellerMailingUnitNumber			:=	ut.CleanSpacesAndUpper(pInput.seller_mailing_address_unit_number);
			string		vPrepPropertyUnitNumber						:=	ut.CleanSpacesAndUpper(pInput.property_address_unit_number);
			
			string		vPrepBuyerMailingStreetAddr				:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.buyer_mailing_full_street_address));
			string		vPrepSellerMailingStreetAddr			:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.seller_mailing_full_street_address));
			string		vPrepPropertyStreetAddr						:=	ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(pInput.property_full_street_address));
			
			// Check if the buyer mailing address unit number exists in the full street address
			unsigned	vBuyerMailStreetAddrSpaceCount		:=	StringLib.stringFindCount(vPrepBuyerMailingStreetAddr,' ');
			unsigned	vBuyerMailStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepBuyerMailingStreetAddr,' ',vBuyerMailStreetAddrSpaceCount);
			string		vBuyerMailStreetAddrUnitNumber		:=	StringLib.StringFilterOut(vPrepBuyerMailingStreetAddr[vBuyerMailStreetAddrSpaceRIndex+1..vBuyerMailStreetAddrSpaceRIndex+6],'#');
			
			string		vBuyerMailingUnitNumber						:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepBuyerMailingStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vBuyerMailStreetAddrUnitNumber)	and	vPrepBuyerMailingUnitNumber	!=	'',
																													'',
																													vPrepBuyerMailingUnitNumber
																												);
			
			// Check if the seller mailing address unit number exists in the full street address
			unsigned	vSellerMailStreetAddrSpaceCount		:=	StringLib.stringFindCount(vPrepSellerMailingStreetAddr,' ');
			unsigned	vSellerMailStreetAddrSpaceRIndex	:=	StringLib.StringFind(vPrepSellerMailingStreetAddr,' ',vSellerMailStreetAddrSpaceCount);
			string		vSellerMailStreetAddrUnitNumber		:=	StringLib.StringFilterOut(vPrepSellerMailingStreetAddr[vSellerMailStreetAddrSpaceRIndex+1..vSellerMailStreetAddrSpaceRIndex+6],'#');
			
			string		vSellerMailingUnitNumber					:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepSellerMailingStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vSellerMailStreetAddrUnitNumber)	and	vPrepSellerMailingUnitNumber	!=	'',
																													'',
																													vPrepSellerMailingUnitNumber
																												);
			
			// Check if the property address unit number exists in the full street address
			unsigned	vPropertyStreetAddrSpaceCount			:=	StringLib.stringFindCount(vPrepPropertyStreetAddr,' ');
			unsigned	vPropertyStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepPropertyStreetAddr,' ',vPropertyStreetAddrSpaceCount);
			string		vPropertyStreetAddrUnitNumber			:=	StringLib.StringFilterOut(vPrepPropertyStreetAddr[vPropertyStreetAddrSpaceRIndex+1..vPropertyStreetAddrSpaceRIndex+6],'#');
			
			string		vPropertyUnitNumber								:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr),'#')	=	ut.CleanSpacesAndUpper(vPropertyStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
																													'',
																													vPrepPropertyUnitNumber
																												);
			
			string		vPrepPhoneOrHawaiiPropAddrUnitNum	:=	regexreplace('^[0]*$',ut.CleanSpacesAndUpper(pInput.phone_number_or_hawaii_property_address_unit_number),'');
			string6		vHawaiiPropertyAddressUnitNumber	:=	if(	stringlib.stringfind(vPrepPhoneOrHawaiiPropAddrUnitNum,vPrepPropertyUnitNumber,1)	!=	0,
																													vPrepPropertyUnitNumber,
																													if(	~regexfind('[A-Za-z]+|[-]',vPrepPhoneOrHawaiiPropAddrUnitNum,nocase),
																															vPrepPhoneOrHawaiiPropAddrUnitNum,
																															''
																														)
																												);
			
			self.ln_fares_id													:=	'OD'	+	intformat(vFaresID,10,1);
			self.process_date													:=	pVersionDate;
			self.vendor_source_flag										:=	'O';
			self.from_file														:=	'D';
			self.buyer_or_borrower_ind								:=	'O';
			self.name1_id_code												:=	pInput.buyer1_id_code;
			self.name2_id_code												:=	pInput.buyer2_id_code;
			self.name1																:=	vCleanBuyer1;
			self.name2																:=	vCleanBuyer2;
			self.seller1															:=	vCleanSeller1;
			self.seller2															:=	vCleanSeller2;
			self.vesting_code													:=	pInput.buyer_vesting_code;
			self.addendum_flag												:=	pInput.buyer_addendum_flag;
			self.mailing_care_of											:=	LN_Propertyv2.Functions.fCleanName(pInput.buyer_mailing_address_care_of_name);
			self.mailing_street												:=	ln_propertyv2_fast.fn_clean_address(pInput.buyer_mailing_full_street_address);
			self.mailing_unit_number									:=	if(	ut.CleanSpacesAndUpper(pInput.state)	!=	'HI',
																												pInput.buyer_mailing_address_unit_number,
																												if(	length(ut.CleanSpacesAndUpper(vHawaiiPropertyAddressUnitNumber))	>	6	and	stringlib.stringfind(vHawaiiPropertyAddressUnitNumber,'-',1)	!=	0,
																														vHawaiiPropertyAddressUnitNumber[stringlib.stringfind(vHawaiiPropertyAddressUnitNumber,'-',1)+1..],
																														pInput.buyer_mailing_address_unit_number
																													)
																											);
			self.mailing_csz													:=	ln_propertyv2_fast.fn_clean_address(Address.Addr2FromComponentsWithZip4(	
																																													pInput.buyer_mailing_address_city,
																																													pInput.buyer_mailing_address_state,
																																													pInput.buyer_mailing_address_zip_code,
																																													pInput.buyer_mailing_address_zip_4
																																												));
			self.seller_mailing_address_citystatezip	:=	ln_propertyv2_fast.fn_clean_address(Address.Addr2FromComponentsWithZip4(	
																																													pInput.seller_mailing_address_city,
																																													pInput.seller_mailing_address_state,
																																													pInput.seller_mailing_address_zip_code,
																																													pInput.seller_mailing_address_zip_4
																																												));
			self.property_address_citystatezip				:=	ln_propertyv2_fast.fn_clean_address(Address.Addr2FromComponentsWithZip4(	
																																													pInput.property_address_city,
																																													pInput.property_address_state,
																																													pInput.property_address_zip_code,
																																													pInput.property_address_zip_4
																																												));
			self.property_address_unit_number					:=	if(	ut.CleanSpacesAndUpper(pInput.state)	=	'HI',
																												vHawaiiPropertyAddressUnitNumber,
																												pInput.property_address_unit_number
																											);
			self.lender_address_citystatezip					:=	ln_propertyv2_fast.fn_clean_address(pInput.lender_address_zip_code);
			self.phone_number													:=	if(	ut.CleanSpacesAndUpper(pInput.state)	!=	'HI',
																												pInput.phone_number_or_hawaii_property_address_unit_number,
																												''
																											);
			self.legal_sec_twn_rng_mer								:=	if(	ut.CleanSpacesAndUpper(pInput.state)	!=	'HI',
																												pInput.legal_sec_twn_rng_mer_opt_hawaii_condo_name,
																												''
																												);
			self.legal_brief_description							:=	if(	ut.CleanSpacesAndUpper(pInput.state)	=	'HI',
																												pInput.legal_brief_description_opt_hawaii_condo_cpr_code[1..96],
																												pInput.legal_brief_description_opt_hawaii_condo_cpr_code
																											);
			self.hawaii_condo_cpr_code								:=	if(	ut.CleanSpacesAndUpper(pInput.state)	=	'HI',
																												pInput.legal_brief_description_opt_hawaii_condo_cpr_code[97..100],
																												''
																											);
			self.hawaii_condo_name										:=	if(	ut.CleanSpacesAndUpper(pInput.state)	=	'HI',
																												pInput.legal_sec_twn_rng_mer_opt_hawaii_condo_name,
																												''
																											);
			self.first_td_loan_type_code							:=	pInput.first_td_loan_type;
			self.recording_date												:=	case(	length(ut.CleanSpacesAndUpper(pInput.recording_date)),
																													8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																													6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																													pInput.recording_date
																												);
			self.contract_date												:=	case(	length(ut.CleanSpacesAndUpper(pInput.contract_date)),
																													8	=>	pInput.contract_date[5..8]	+	pInput.contract_date[1..4],
																													6	=>	pInput.contract_date[3..6]	+	pInput.contract_date[1..2],
																													pInput.contract_date
																												);
			self.first_td_due_date										:=	case(	length(ut.CleanSpacesAndUpper(pInput.first_td_due_date)),
																													8	=>	pInput.first_td_due_date[5..8]	+	pInput.first_td_due_date[1..4],
																													6	=>	pInput.first_td_due_date[3..6]	+	pInput.first_td_due_date[1..2],
																													pInput.first_td_due_date
																												);
			self.Append_ReplRecordInd									:=	pInput.replacement_record_ind;
			self.Append_HawaiiLegal										:=	pInput.hawaii_legal;
			self.Append_PrepMailingAddr1							:=	ut.CleanSpacesAndUpper(vPrepBuyerMailingStreetAddr	+	' '	+	vBuyerMailingUnitNumber);
			self.Append_PrepMailingAddr2							:=	regexreplace(	'([0]{5}|[,])$',
																																	ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.mailing_csz)),
																																	''
																																);
			self.Append_PrepSellerMailingAddr1				:=	ut.CleanSpacesAndUpper(vPrepSellerMailingStreetAddr	+	' '	+	vSellerMailingUnitNumber);
			self.Append_PrepSellerMailingAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																																	ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.seller_mailing_address_citystatezip)),
																																	''
																																);
			self.Append_PrepPropertyAddr1							:=	ut.CleanSpacesAndUpper(vPrepPropertyStreetAddr	+	' '	+	if(ut.CleanSpacesAndUpper(pInput.state)	!=	'HI',vPropertyUnitNumber,vHawaiiPropertyAddressUnitNumber));
			self.Append_PrepPropertyAddr2							:=	regexreplace(	'([0]{5}|[,])$',
																																	ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.property_address_citystatezip)),
																																	''
																																);
			
			self																			:=	pInput;
			self																			:=	[];
		END;
	
		
		dDeed2Common	:=	project(PrepDataSet.reformatted.dDeedsRef,tMap2Common(left,counter)) :independent;
		
		// Populate fipscode
		common.layout_prep_temp_deed tDeedFipscode(recordof(dDeed2Common) L,recordof(Census_Data.File_Fips2County) R) :=
		TRANSFORM
				self.fips_code	:=	if(L.fips_code	!=	'',L.fips_code,R.state_fips	+	R.county_fips);
				self						:=	L;
		END;
		
		dFipsCode :=	join(dDeed2Common, Census_Data.File_Fips2County,
														ut.CleanSpacesAndUpper(left.state)				=	ut.CleanSpacesAndUpper(right.state_code)	and
														ut.CleanSpacesAndUpper(left.county_name)	=	ut.CleanSpacesAndUpper(right.county_name),
														tDeedFipscode(LEFT,RIGHT), left outer, lookup);
														
		LN_PropertyV2_Fast.MAC_CtryCodeOwnSellDeed(dFipsCode, dDeedCommon);
		
		EXPORT dDeedFipscode := dDeedCommon;	

		// Distribute Deed file
		EXPORT dDeedFipscodeDist	:=	distribute(dDeedFipscode,hash32(data_source_code,record_type,state,county_name,fips_code));
		
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	project(dDeedFipscode,LN_PropertyV2_Fast.Layout_prep_deed_mortg);
	
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Additional Names
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlNames 	:= MODULE
		// Addl buyer clean
		LN_Propertyv2.Functions.CleanFields(PrepDataSet.reformatted.dAddlNamesRef,dAddlBuyerSellerClean);
		LN_Propertyv2.Layout_Prep.In.AddlBuyerSeller tCleanAddlNameDate(dAddlBuyerSellerClean L) :=
			TRANSFORM
				self.recording_date	:=	LN_PropertyV2_Fast.fn_formatDate(L.recording_date);
				self								:=	L;
			END;
		dAddlBuyerSellerClean2 := project(dAddlBuyerSellerClean, tCleanAddlNameDate(LEFT));
		
		// Distribute files
		dAddlBuyerSellerCleanDist		:=	distribute(	dAddlBuyerSellerClean2,hash32(data_source_code,record_type,state,county_name,fips_code));
		// Populate fares id for addl buyer seller records
		LN_PropertyV2.Layout_Prep.Temp.AddlBuyerSellerTemp	tAddlNameFaresID(common.layout_prep_temp_deed	le,LN_PropertyV2.Layout_Prep.In.AddlBuyerSeller	ri)	:=
		transform
			string	vDateSeen						:=	if(	length(ut.CleanSpacesAndUpper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(le.recording_date)),
																					ut.CleanSpacesAndUpper(le.recording_date)[1..6],
																					ut.CleanSpacesAndUpper(le.contract_date)[1..6]
																				);
			string	vBuyerSeller3				:=		ri.buyer_seller3_last_or_corp_name
																			+	if(ri.buyer_seller3_last_or_corp_name	!=	''	and	ri.buyer_seller3_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller3_first_middle_name;
			string	vBuyerSeller4				:=		ri.buyer_seller4_last_or_corp_name
																			+	if(ri.buyer_seller4_last_or_corp_name	!=	''	and	ri.buyer_seller4_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller4_first_middle_name;
			string	vBuyerSeller5				:=		ri.buyer_seller5_last_or_corp_name
																			+	if(ri.buyer_seller5_last_or_corp_name	!=	''	and	ri.buyer_seller5_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller5_first_middle_name;
			string	vBuyerSeller6				:=		ri.buyer_seller6_last_or_corp_name
																			+	if(ri.buyer_seller6_last_or_corp_name	!=	''	and	ri.buyer_seller6_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller6_first_middle_name;
			string	vBuyerSeller7				:=		ri.buyer_seller7_last_or_corp_name
																			+	if(ri.buyer_seller7_last_or_corp_name	!=	''	and	ri.buyer_seller7_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller7_first_middle_name;
			string	vBuyerSeller8				:=		ri.buyer_seller8_last_or_corp_name
																			+	if(ri.buyer_seller8_last_or_corp_name	!=	''	and	ri.buyer_seller8_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller8_first_middle_name;
			string	vBuyerSeller9				:=		ri.buyer_seller9_last_or_corp_name
																			+	if(ri.buyer_seller9_last_or_corp_name	!=	''	and	ri.buyer_seller9_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller9_first_middle_name;
			string	vBuyerSeller10			:=		ri.buyer_seller10_last_or_corp_name
																			+	if(ri.buyer_seller10_last_or_corp_name	!=	''	and	ri.buyer_seller10_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller10_first_middle_name;
			string	vBuyerSeller11			:=		ri.buyer_seller11_last_or_corp_name
																			+	if(ri.buyer_seller11_last_or_corp_name	!=	''	and	ri.buyer_seller11_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller11_first_middle_name;
			string	vBuyerSeller12			:=		ri.buyer_seller12_last_or_corp_name
																			+	if(ri.buyer_seller12_last_or_corp_name	!=	''	and	ri.buyer_seller12_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller12_first_middle_name;
			string	vBuyerSeller13			:=		ri.buyer_seller13_last_or_corp_name
																			+	if(ri.buyer_seller13_last_or_corp_name	!=	''	and	ri.buyer_seller13_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller13_first_middle_name;
			string	vBuyerSeller14			:=		ri.buyer_seller14_last_or_corp_name
																			+	if(ri.buyer_seller14_last_or_corp_name	!=	''	and	ri.buyer_seller14_first_middle_name	!=	'',', ','')
																			+	ri.buyer_seller14_first_middle_name;
			// to address Jira DF-13391
			string	vBuyerSeller15			:=		regexreplace('0',ri.buyer_seller15_last_or_corp_name,' ')
																			+	if(regexreplace('0',ri.buyer_seller15_last_or_corp_name,' ')	!=	''	and	ri.buyer_seller15_first_middle_name	!=	'',', ','')
																			+	regexreplace('0',ri.buyer_seller15_first_middle_name,' ');
			string	vBuyerSeller16			:=		regexreplace('0',ri.buyer_seller16_last_or_corp_name,' ')
																			+	if(regexreplace('0',ri.buyer_seller16_last_or_corp_name,' ')	!=	''	and	ri.buyer_seller16_first_middle_name	!=	'',', ','')
																			+	regexreplace('0',ri.buyer_seller16_first_middle_name,' ');
			// ** end Jira DF-13391 **
			
			self.ln_fares_id						:=	le.ln_fares_id;
			self.dt_first_seen					:=	vDateSeen;
			self.dt_last_seen						:=	vDateSeen;
			self.buyer_seller3					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller3);
			self.buyer_seller4					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller4);
			self.buyer_seller5					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller5);
			self.buyer_seller6					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller6);
			self.buyer_seller7					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller7);
			self.buyer_seller8					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller8);
			self.buyer_seller9					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller9);
			self.buyer_seller10					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller10);
			self.buyer_seller11					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller11);
			self.buyer_seller12					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller12);
			self.buyer_seller13					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller13);
			self.buyer_seller14					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller14);
			self.buyer_seller15					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller15);
			self.buyer_seller16					:=	LN_Propertyv2.Functions.fCleanName(vBuyerSeller16);
			self.Append_ApntOrPinNumber	:=	le.apnt_or_pin_number;
			self												:=	le;
			self												:=	ri;
		end;
		
		EXPORT dAddlNameFaresID	:=	join(	deed.dDeedFipscodeDist,
																dAddlBuyerSellerCleanDist,
																left.Append_ReplRecordInd	=	right.replacement_record_ind	and
																left.data_source_code			=	right.data_source_code				and
																left.record_type					=	right.record_type							and
																left.state								=	right.state										and
																left.county_name					=	right.county_name							and
																left.fips_code						=	right.fips_code								and
																left.recording_date				=	right.recording_date					and
																left.recorder_book_number	=	right.recorder_book_number		and
																left.recorder_page_number	=	right.recorder_page_number		and
																left.document_number			=	right.document_number,
																tAddlNameFaresID(left,right),
																local
															);
		
		// Normalize combined addl buyer seller file to create base file
		LN_PropertyV2.Layout_Prep.Temp.AddlName	tNormalizeAddlName(LN_PropertyV2.Layout_Prep.Temp.AddlBuyerSellerTemp	pInput,integer	cnt)	:=
		transform
			self.apnt_or_pin_number		:=	pInput.Append_ApntOrPinNumber;
			self.buyer_or_seller			:=	pInput.buyer_seller_ind;
			self.name_seq							:=	(string)(2	+	cnt);
			self.name									:=	choose(	cnt,
																						pInput.buyer_seller3,
																						pInput.buyer_seller4,
																						pInput.buyer_seller5,
																						pInput.buyer_seller6,
																						pInput.buyer_seller7,
																						pInput.buyer_seller8,
																						pInput.buyer_seller9,
																						pInput.buyer_seller10,
																						pInput.buyer_seller11,
																						pInput.buyer_seller12,
																						pInput.buyer_seller13,
																						pInput.buyer_seller14,
																						pInput.buyer_seller15,
																						pInput.buyer_seller16
																					);
			self.id_code							:=	choose(	cnt,
																						pInput.buyer_seller3_id_code,
																						pInput.buyer_seller4_id_code,
																						pInput.buyer_seller5_id_code,
																						pInput.buyer_seller6_id_code,
																						pInput.buyer_seller7_id_code,
																						pInput.buyer_seller8_id_code,
																						pInput.buyer_seller9_id_code,
																						pInput.buyer_seller10_id_code,
																						pInput.buyer_seller11_id_code,
																						pInput.buyer_seller12_id_code,
																						pInput.buyer_seller13_id_code,
																						pInput.buyer_seller14_id_code,
																						pInput.buyer_seller15_id_code,
																						pInput.buyer_seller16_id_code
																					);
			self.Append_ReplRecordInd	:=	pInput.replacement_record_ind;
			self											:=	pInput;
		end;
		
		SHARED dAddlNamePrep	:=	normalize(dAddlNameFaresID,14,tNormalizeAddlName(left,counter));
		
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	project(dAddlNamePrep(name	!=	''),LN_PropertyV2_Fast.Layout_prep_addl_names);
		
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Additional Legal
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlLegal 	:= MODULE
		
		// Generate addl legal records which are available only for Hawaii
		LN_PropertyV2.Layout_Prep.Temp.AddlLegal	tAddlLegalFaresID(common.layout_prep_temp_deed	pInput)	:=
		transform
			self.addl_legal	:=	pInput.Append_HawaiiLegal;
			self						:=	pInput;
		end;
		
		SHARED dAddlLegalPrep	:=	project(	deed.dDeedFipscodeDist(ut.CleanSpacesAndUpper(state)	=	'HI'	and	Append_HawaiiLegal	!=	''),
																	tAddlLegalFaresID(left)
																);
		// Reformat to bring to base file layouts
		EXPORT dNew			:=	project(dAddlLegalPrep,LN_PropertyV2_Fast.Layout_prep_addl_legal);
	
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Search
	// ---------------------------------------------------------------------------------------------------------
	EXPORT search 		:= MODULE	
		// --------- BUILD SEARCH FROM DEED
		// Normalize the Deed file by name to create an intial Deed search file
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tDeedNormName(common.layout_prep_temp_deed	pInput,integer	cnt)	:=
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
			self.nameasis									:=	choose(cnt,pInput.name1,pInput.name2,pInput.mailing_care_of,pInput.seller1,pInput.seller2);
			self.which_orig								:=	choose(cnt,'1','2','1','1','2');
			self.source_code							:=	choose(cnt,'O','O','C','S','S');
			self													:=	pInput;
			self													:=	[];
		end;
		
		dDeedNormName	:=	normalize(deed.dDeedFipscode,5,tDeedNormName(left,counter));	
		// Normalize the Deed search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tDeedNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		transform
			self.Append_PrepAddr1									:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepSellerMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2									:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepSellerMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 		:=  choose(cnt,pInput.ln_buyer_mailing_country_code,'', '');
			self.ln_seller_mailing_country_code 	:=  choose(cnt,'',pInput.ln_seller_mailing_country_code, '');		
			self.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'O','S','P');
			self																	:=	pInput;
		end;
		
		dDeedNormAddr	:=	normalize(dDeedNormName(nameasis	!=	''),3,tDeedNormAddr(left,counter));
	
		//drop invalid source code 
		dDeedNormAddr0 := dDeedNormAddr(source_code!='OS' and source_code!='SO'); 
	
		dDeedSearch	:=	dDeedNormAddr0(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- BUILD SEARCH FROM DEED ADDL NAMES SPLIT
	// Normalize addl name file by name
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlBuyerSellerTemp	pInput,integer	cnt)	:=
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
																								pInput.buyer_seller3,
																								pInput.buyer_seller4,
																								pInput.buyer_seller5,
																								pInput.buyer_seller6,
																								pInput.buyer_seller7,
																								pInput.buyer_seller8,
																								pInput.buyer_seller9,
																								pInput.buyer_seller10,
																								pInput.buyer_seller11,
																								pInput.buyer_seller12,
																								pInput.buyer_seller13,
																								pInput.buyer_seller14,
																								pInput.buyer_seller15,
																								pInput.buyer_seller16
																							);
			
			self													:=	pInput;
			self													:=	[];
		end;
		
		dAddlNameNormName	:=	normalize(addlNames.dAddlNameFaresID,14,tNormalizeAddlNameSearch(left,counter));
		// Normalize addl name search file by address
		LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp pInput,integer	cnt)	:=
		transform
			self.Append_PrepAddr1									:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepSellerMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2									:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepSellerMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 		:=  choose(cnt,pInput.ln_buyer_mailing_country_code,'', '');
			self.ln_seller_mailing_country_code 	:=  choose(cnt,'',pInput.ln_seller_mailing_country_code, '');		
			self.source_code											:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'O','S','P');
			self																	:=	pInput;
		end;
	
		dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),3,tNormalizeAddlNameAddr(left,counter));
		dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- COMBINE DEED AND ADDL NAME SEARCHES
		// Combine all the search files (normalized files from addl names and Deed)
		dSearchCombined	:=	dAddlNameSearch	+	dDeedSearch;
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
		
		dDeedNormSearchName := dedup(sort(normalize(dSearchCleanName,2,tNormSearchCleanNames(LEFT,counter)),
																	record,local),record, EXCEPT conjunctive_name_seq,local);
		
		// LN_Propertyv2.Append_AID(dDeedNormSearchName,dSearchCleanAddr,false); // DF-28245 unify multiple calls to AID into a single call
		// dSearchAID	:=	dSearchCleanAddr;
		
		//Reformat to bring to base file layouts
		EXPORT dNew	:=	project(dDeedNormSearchName, LN_PropertyV2_Fast.Layout_prep_search_prp);
		
	END;
END;
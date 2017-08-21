import	Address,Census_Data,Tools,ut;

export	Prep_OKC_Deeds(string	pVersionDate)	:=
function
	// Get max value for fares id
	maxLNDeedFaresID			:= max(		ln_propertyv2.Files.Prep.LNDeed(ln_fares_id[1..2]	=	'OD')
																	+	ln_propertyv2.Files.Prep.LNDeedRepl(ln_fares_id[1..2]	=	'OD'),
																	(unsigned)ln_fares_id[3..]
																)	:	global;
	
	// Deed vendor files
	dDeedRaw			:=	ln_propertyv2.Files.In.LNDeed;
	dDeedRawRepl	:=	ln_propertyv2.Files.In.LNDeedRepl;
	
	// Dedup the files so as to remove duplicate records
	dDeedRawDedup			:=	dedup(dDeedRaw,record,all);
	dDeedRawReplDedup	:=	dedup(dDeedRawRepl,record,all);
	
	// Add replacement record indicator for Deeds
	rAppendReplIndicator_Layout	:=
	record
		string1	ReplRecordInd;
		LN_Propertyv2.Layout_Prep.In.DeedPayload;
	end;
	
	// Add replacement record and buyer seller indicator for Deeds
	rAppendBuyerSellerIndicator_Layout	:=
	record
		string1	BuyerSellerInd;
		rAppendReplIndicator_Layout;
	end;
	
	rAppendReplIndicator_Layout	tAppendReplInd(LN_Propertyv2.Layout_Prep.In.DeedPayload	pInput,boolean	isRepl)	:=
	transform
		self.ReplRecordInd	:=	if(isRepl,'Y','N');
		self.MainRecordCode	:=	ut.fnTrim2Upper(pInput.MainRecordCode);
		self								:=	pInput;
	end;
	
	dDeedRawAppendReplInd			:=	project(dDeedRawDedup,tAppendReplInd(left,false));
	dDeedRawReplAppendReplInd	:=	project(dDeedRawReplDedup,tAppendReplInd(left,true));
	
	// Combine replacement and non replacement files
	dDeedRawCombined	:=	dDeedRawAppendReplInd	+	dDeedRawReplAppendReplInd;
	
	// Split out the addl buyer, seller and main records from the combined file
	dAddlBuyerRaw		:=	project(	dDeedRawCombined(MainRecordCode	=	'B'),
																transform(rAppendBuyerSellerIndicator_Layout,self.BuyerSellerInd	:=	'O';self	:=	left;)
															);
	dAddlSellerRaw	:=	project(	dDeedRawCombined(MainRecordCode	=	'S'),
																transform(rAppendBuyerSellerIndicator_Layout,self.BuyerSellerInd	:=	'S';self	:=	left;)
															);
	dDeedMainRaw		:=	dDeedRawCombined(MainRecordCode	=	'M');
	dDeedUnusedRaw	:=	dDeedRawCombined(MainRecordCode	not in	['B','M','S']);
	
	// Combine the addl buyer and seller records
	dAddlBuyerSellerRaw	:=	dAddlBuyerRaw	+	dAddlSellerRaw;
	
	// Redefine format the layout
	Tools.mac_RedefineFormat(dAddlBuyerSellerRaw,LN_Propertyv2.Layout_Prep.In.AddlBuyerSeller	,dAddlBuyerSellerReformat	,pShouldExport	:=	false);
	Tools.mac_RedefineFormat(dDeedMainRaw				,LN_Propertyv2.Layout_Prep.In.Deed						,dDeedMainReformat				,pShouldExport	:=	false);
	
	// Addl buyer clean
	LN_Propertyv2.Functions.CleanFields(dAddlBuyerSellerReformat,dAddlBuyerSellerClean);
	
	// Distribute files
	dAddlBuyerSellerCleanDist		:=	distribute(	project(	dAddlBuyerSellerClean,
																												transform(	LN_Propertyv2.Layout_Prep.In.AddlBuyerSeller,
																																		self.recording_date	:=	case(	length(ut.fnTrim2Upper(left.recording_date)),
																																																	8	=>	left.recording_date[5..8]	+	left.recording_date[1..4],
																																																	6	=>	left.recording_date[3..6]	+	left.recording_date[1..2],
																																																	left.recording_date
																																																);
																																		self								:=	left;
																																	)
																											),
																							hash32(data_source_code,record_type,state,county_name,fips_code)
																						);
	
	// Remove names with start with SG and map to common layout
	LN_Propertyv2.Layout_Prep.Temp.Deed	tMap2Common(dDeedMainReformat	pInput,integer	cnt)	:=
	transform
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
		
		string		vCleanBuyer1											:=	LN_Propertyv2.Functions.fCleanName(vBuyer1);
		string		vCleanBuyer2											:=	LN_Propertyv2.Functions.fCleanName(vBuyer2);
		string		vCleanSeller1											:=	LN_Propertyv2.Functions.fCleanName(vSeller1);
		string		vCleanSeller2											:=	LN_Propertyv2.Functions.fCleanName(vSeller2);
		
		string		vPrepBuyerMailingUnitNumber				:=	ut.fnTrim2Upper(pInput.buyer_mailing_address_unit_number);
		string		vPrepSellerMailingUnitNumber			:=	ut.fnTrim2Upper(pInput.seller_mailing_address_unit_number);
		string		vPrepPropertyUnitNumber						:=	ut.fnTrim2Upper(pInput.property_address_unit_number);
		
		string		vPrepBuyerMailingStreetAddr				:=	ut.fnTrim2Upper(pInput.buyer_mailing_full_street_address);
		string		vPrepSellerMailingStreetAddr			:=	ut.fnTrim2Upper(pInput.seller_mailing_full_street_address);
		string		vPrepPropertyStreetAddr						:=	ut.fnTrim2Upper(pInput.property_full_street_address);
		
		// Check if the buyer mailing address unit number exists in the full street address
		unsigned	vBuyerMailStreetAddrSpaceCount		:=	StringLib.stringFindCount(vPrepBuyerMailingStreetAddr,' ');
		unsigned	vBuyerMailStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepBuyerMailingStreetAddr,' ',vBuyerMailStreetAddrSpaceCount);
		string		vBuyerMailStreetAddrUnitNumber		:=	StringLib.StringFilterOut(vPrepBuyerMailingStreetAddr[vBuyerMailStreetAddrSpaceRIndex+1..vBuyerMailStreetAddrSpaceRIndex+6],'#');
		
		string		vBuyerMailingUnitNumber						:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepBuyerMailingStreetAddr),'#')	=	ut.fnTrim2Upper(vBuyerMailStreetAddrUnitNumber)	and	vPrepBuyerMailingUnitNumber	!=	'',
																												'',
																												vPrepBuyerMailingUnitNumber
																											);
		
		// Check if the seller mailing address unit number exists in the full street address
		unsigned	vSellerMailStreetAddrSpaceCount		:=	StringLib.stringFindCount(vPrepSellerMailingStreetAddr,' ');
		unsigned	vSellerMailStreetAddrSpaceRIndex	:=	StringLib.StringFind(vPrepSellerMailingStreetAddr,' ',vSellerMailStreetAddrSpaceCount);
		string		vSellerMailStreetAddrUnitNumber		:=	StringLib.StringFilterOut(vPrepSellerMailingStreetAddr[vSellerMailStreetAddrSpaceRIndex+1..vSellerMailStreetAddrSpaceRIndex+6],'#');
		
		string		vSellerMailingUnitNumber					:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepSellerMailingStreetAddr),'#')	=	ut.fnTrim2Upper(vSellerMailStreetAddrUnitNumber)	and	vPrepSellerMailingUnitNumber	!=	'',
																												'',
																												vPrepSellerMailingUnitNumber
																											);
		
		// Check if the property address unit number exists in the full street address
		unsigned	vPropertyStreetAddrSpaceCount			:=	StringLib.stringFindCount(vPrepPropertyStreetAddr,' ');
		unsigned	vPropertyStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepPropertyStreetAddr,' ',vPropertyStreetAddrSpaceCount);
		string		vPropertyStreetAddrUnitNumber			:=	StringLib.StringFilterOut(vPrepPropertyStreetAddr[vPropertyStreetAddrSpaceRIndex+1..vPropertyStreetAddrSpaceRIndex+6],'#');
		
		string		vPropertyUnitNumber								:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepPropertyStreetAddr),'#')	=	ut.fnTrim2Upper(vPropertyStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
																												'',
																												vPrepPropertyUnitNumber
																											);
		
		string		vPrepPhoneOrHawaiiPropAddrUnitNum	:=	regexreplace('^[0]*$',ut.fnTrim2Upper(pInput.phone_number_or_hawaii_property_address_unit_number),'');
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
		self.mailing_street												:=	pInput.buyer_mailing_full_street_address;
		self.mailing_unit_number									:=	if(	ut.fnTrim2Upper(pInput.state)	!=	'HI',
																											pInput.buyer_mailing_address_unit_number,
																											if(	length(ut.fnTrim2Upper(vHawaiiPropertyAddressUnitNumber))	>	6	and	stringlib.stringfind(vHawaiiPropertyAddressUnitNumber,'-',1)	!=	0,
																													vHawaiiPropertyAddressUnitNumber[stringlib.stringfind(vHawaiiPropertyAddressUnitNumber,'-',1)+1..],
																													pInput.buyer_mailing_address_unit_number
																												)
																										);
		self.mailing_csz													:=	Address.Addr2FromComponentsWithZip4(	pInput.buyer_mailing_address_city,
																																												pInput.buyer_mailing_address_state,
																																												pInput.buyer_mailing_address_zip_code,
																																												pInput.buyer_mailing_address_zip_4
																																											);
		self.seller_mailing_address_citystatezip	:=	Address.Addr2FromComponentsWithZip4(	pInput.seller_mailing_address_city,
																																												pInput.seller_mailing_address_state,
																																												pInput.seller_mailing_address_zip_code,
																																												pInput.seller_mailing_address_zip_4
																																											);
		self.property_address_citystatezip				:=	Address.Addr2FromComponentsWithZip4(	pInput.property_address_city,
																																												pInput.property_address_state,
																																												pInput.property_address_zip_code,
																																												pInput.property_address_zip_4
																																											);
		self.property_address_unit_number					:=	if(	ut.fnTrim2Upper(pInput.state)	=	'HI',
																											vHawaiiPropertyAddressUnitNumber,
																											pInput.property_address_unit_number
																										);
		self.lender_address_citystatezip					:=	pInput.lender_address_zip_code;
		self.phone_number													:=	if(	ut.fnTrim2Upper(pInput.state)	!=	'HI',
																											pInput.phone_number_or_hawaii_property_address_unit_number,
																											''
																										);
		self.legal_sec_twn_rng_mer								:=	if(	ut.fnTrim2Upper(pInput.state)	!=	'HI',
																											pInput.legal_sec_twn_rng_mer_opt_hawaii_condo_name,
																											''
																										);
		self.legal_brief_description							:=	if(	ut.fnTrim2Upper(pInput.state)	=	'HI',
																											pInput.legal_brief_description_opt_hawaii_condo_cpr_code[1..96],
																											pInput.legal_brief_description_opt_hawaii_condo_cpr_code
																										);
		self.hawaii_condo_cpr_code								:=	if(	ut.fnTrim2Upper(pInput.state)	=	'HI',
																											pInput.legal_brief_description_opt_hawaii_condo_cpr_code[97..100],
																											''
																										);
		self.hawaii_condo_name										:=	if(	ut.fnTrim2Upper(pInput.state)	=	'HI',
																											pInput.legal_sec_twn_rng_mer_opt_hawaii_condo_name,
																											''
																										);
		self.first_td_loan_type_code							:=	pInput.first_td_loan_type;
		self.recording_date												:=	case(	length(ut.fnTrim2Upper(pInput.recording_date)),
																												8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																												6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																												pInput.recording_date
																											);
		self.contract_date												:=	case(	length(ut.fnTrim2Upper(pInput.contract_date)),
																												8	=>	pInput.contract_date[5..8]	+	pInput.contract_date[1..4],
																												6	=>	pInput.contract_date[3..6]	+	pInput.contract_date[1..2],
																												pInput.contract_date
																											);
		self.first_td_due_date										:=	case(	length(ut.fnTrim2Upper(pInput.first_td_due_date)),
																												8	=>	pInput.first_td_due_date[5..8]	+	pInput.first_td_due_date[1..4],
																												6	=>	pInput.first_td_due_date[3..6]	+	pInput.first_td_due_date[1..2],
																												pInput.first_td_due_date
																											);
		self.Append_ReplRecordInd									:=	pInput.replacement_record_ind;
		self.Append_HawaiiLegal										:=	pInput.hawaii_legal;
		self.Append_PrepMailingAddr1							:=	ut.fnTrim2Upper(vPrepBuyerMailingStreetAddr	+	' '	+	vBuyerMailingUnitNumber);
		self.Append_PrepMailingAddr2							:=	regexreplace(	'([0]{5}|[,])$',
																																ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.mailing_csz)),
																																''
																															);
		self.Append_PrepSellerMailingAddr1				:=	ut.fnTrim2Upper(vPrepSellerMailingStreetAddr	+	' '	+	vSellerMailingUnitNumber);
		self.Append_PrepSellerMailingAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																																ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.seller_mailing_address_citystatezip)),
																																''
																															);
		self.Append_PrepPropertyAddr1							:=	ut.fnTrim2Upper(vPrepPropertyStreetAddr	+	' '	+	if(ut.fnTrim2Upper(pInput.state)	!=	'HI',vPropertyUnitNumber,vHawaiiPropertyAddressUnitNumber));
		self.Append_PrepPropertyAddr2							:=	regexreplace(	'([0]{5}|[,])$',
																																ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.property_address_citystatezip)),
																																''
																															);
		
		self																			:=	pInput;
		self																			:=	[];
	end;
	
	dDeed2Common	:=	project(dDeedMainReformat,tMap2Common(left,counter)) :independent;
	
	// Populate fipscode
	dDeedFipscode	:=	join(	dDeed2Common,
													Census_Data.File_Fips2County,
													ut.fnTrim2Upper(left.state)				=	ut.fnTrim2Upper(right.state_code)	and
													ut.fnTrim2Upper(left.county_name)	=	ut.fnTrim2Upper(right.county_name),
													transform(	LN_Propertyv2.Layout_Prep.Temp.Deed,
																			self.fips_code	:=	if(left.fips_code	!=	'',left.fips_code,right.state_fips	+	right.county_fips);
																			self						:=	left;
																		),
													left outer,
													lookup
												);
	
	// Reformat to bring to base file layouts
	dDeed			:=	project(dDeedFipscode(Append_ReplRecordInd	=	'N'),LN_PropertyV2.Layouts.PreProcess_Deed_Layout);
	dDeedRepl	:=	project(dDeedFipscode(Append_ReplRecordInd	=	'Y'),LN_PropertyV2.Layouts.PreProcess_Deed_Layout);
	
	// Distribute Deed file
	dDeedFipscodeDist	:=	distribute(dDeedFipscode,hash32(data_source_code,record_type,state,county_name,fips_code));
	
	// Generate addl legal records which are available only for Hawaii
	LN_PropertyV2.Layout_Prep.Temp.AddlLegal	tAddlLegalFaresID(LN_Propertyv2.Layout_Prep.Temp.Deed	pInput)	:=
	transform
		self.addl_legal	:=	pInput.Append_HawaiiLegal;
		self						:=	pInput;
	end;
	
	dAddlLegalPrep	:=	project(	dDeedFipscodeDist(ut.fnTrim2Upper(state)	=	'HI'	and	Append_HawaiiLegal	!=	''),
																tAddlLegalFaresID(left)
															);
	
	// Reformat to bring to base file layouts
	dAddlLegal			:=	project(dAddlLegalPrep(Append_ReplRecordInd	=	'N'),LN_Propertyv2.Layout_Addl_Legal);
	dAddlLegalRepl	:=	project(dAddlLegalPrep(Append_ReplRecordInd	=	'Y'),LN_Propertyv2.Layout_Addl_Legal);
	
	// Populate fares id for addl buyer seller records
	LN_PropertyV2.Layout_Prep.Temp.AddlBuyerSellerTemp	tAddlNameFaresID(LN_Propertyv2.Layout_Prep.Temp.Deed	le,LN_PropertyV2.Layout_Prep.In.AddlBuyerSeller	ri)	:=
	transform
		string	vDateSeen						:=	if(	length(ut.fnTrim2Upper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(le.recording_date)),
																				ut.fnTrim2Upper(le.recording_date)[1..6],
																				ut.fnTrim2Upper(le.contract_date)[1..6]
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
		string	vBuyerSeller15			:=		ri.buyer_seller15_last_or_corp_name
																		+	if(ri.buyer_seller15_last_or_corp_name	!=	''	and	ri.buyer_seller15_first_middle_name	!=	'',', ','')
																		+	ri.buyer_seller15_first_middle_name;
		string	vBuyerSeller16			:=		ri.buyer_seller16_last_or_corp_name
																		+	if(ri.buyer_seller16_last_or_corp_name	!=	''	and	ri.buyer_seller16_first_middle_name	!=	'',', ','')
																		+	ri.buyer_seller16_first_middle_name;
		
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
	
	dAddlNameFaresID	:=	join(	dDeedFipscodeDist,
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
	
	dAddlNamePrep	:=	normalize(dAddlNameFaresID,14,tNormalizeAddlName(left,counter));
	
	// Reformat to bring to base file layouts
	dAddlName			:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'N'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	dAddlNameRepl	:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'Y'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	
	// Normalize addl name file by name
	LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlBuyerSellerTemp	pInput,integer	cnt)	:=
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
	
	dAddlNameNormName	:=	normalize(dAddlNameFaresID,14,tNormalizeAddlNameSearch(left,counter));
	
 	// Normalize addl name search file by address
	LN_PropertyV2.Layout_Prep.Temp.Search	tNormalizeAddlNameAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepSellerMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepSellerMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'O','S','P');
		self									:=	pInput;
	end;
	
	dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),3,tNormalizeAddlNameAddr(left,counter));
	
	dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Normalize the Deed file by name to create an intial Deed search file
	LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tDeedNormName(LN_Propertyv2.Layout_Prep.Temp.Deed	pInput,integer	cnt)	:=
	transform
		string	vDateSeen							:=	if(	length(ut.fnTrim2Upper(pInput.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(pInput.recording_date)),
																					ut.fnTrim2Upper(pInput.recording_date)[1..6],
																					ut.fnTrim2Upper(pInput.contract_date)[1..6]
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
	
	dDeedNormName	:=	normalize(dDeedFipscode,5,tDeedNormName(left,counter));
	
	// Normalize the Deed search file by address
	LN_Propertyv2.Layout_Prep.Temp.Search	tDeedNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepSellerMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepSellerMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'O','S','P');
		self									:=	pInput;
	end;
	
	dDeedNormAddr	:=	normalize(dDeedNormName(nameasis	!=	''),3,tDeedNormAddr(left,counter));
		
	//drop invalid source code 
	dDeedNormAddr0 := dDeedNormAddr(source_code!='OS' and source_code!='SO'); 
	dDeedSearch	:=	dDeedNormAddr0(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Combine all the search files (normalized files from addl names and Deed)
	dSearchCombined	:=	dAddlNameSearch	+	dDeedSearch;
	
	// Clean name and addresses in the search file
	LN_Propertyv2.Layout_Prep.Temp.Search	tSearchPrepAddr(LN_Propertyv2.Layout_Prep.Temp.Search	pInput)	:=
	transform
		self.Append_PrepAddr2	:=	if(	pInput.Append_PrepAddr1	!=	''	and	pInput.Append_PrepAddr2	=	'',
																	'UNKNOWN 12345',
																	pInput.Append_PrepAddr2
																);
		self									:=	pInput;
	end;
	
	dSearchPrepAddr	:=	project(dSearchCombined,tSearchPrepAddr(left));
	
	LN_Propertyv2.Mac_Clean_Name(dSearchPrepAddr,dSearchCleanName);
	
	LN_Propertyv2.Append_AID(dSearchCleanName,dSearchCleanAddr,false);
	
	// Reformat to bring to base file layouts
	dSearch			:=	project(dSearchCleanAddr(Append_ReplRecordInd	=	'N'),LN_Propertyv2.Layout_Deed_Mortgage_Property_Search);
	dSearchRepl	:=	project(dSearchCleanAddr(Append_ReplRecordInd	=	'Y'),LN_Propertyv2.Layout_Deed_Mortgage_Property_Search);
	
	// File prefix
	vFilePrefix	:=	LN_Propertyv2.cluster	+	'in::ln_propertyv2::'	+	pVersionDate;
	
	bldAddlLegal			:=	output(dAddlLegal			,,vFilePrefix	+	'::deed_addl_legal'			,__compressed__);
	bldAddlLegalRepl	:=	output(dAddlLegalRepl	,,vFilePrefix	+	'::deed_repl_addl_legal',__compressed__);
	bldAddlName				:=	output(dAddlName			,,vFilePrefix	+	'::deed_addl_names'			,__compressed__);
	bldAddlNameRepl		:=	output(dAddlNameRepl	,,vFilePrefix	+	'::deed_repl_addl_names',__compressed__);
	bldDeed						:=	output(dDeed					,,vFilePrefix	+	'::deed'								,__compressed__);
	bldDeedRepl				:=	output(dDeedRepl			,,vFilePrefix	+	'::deed_repl'						,__compressed__);
	bldSearch					:=	output(dSearch				,,vFilePrefix	+	'::deed_search'					,__compressed__);
	bldSearchRepl			:=	output(dSearchRepl		,,vFilePrefix	+	'::deed_repl_search'		,__compressed__);
	bldDeedCleanName	:=	output(dSearchCleanName	,,vFilePrefix	+	'::deed_clean_name'		,__compressed__);
	
	bldPrepFiles	:=	parallel(	bldAddlLegal,bldAddlLegalRepl,bldAddlName,bldAddlNameRepl,
															bldDeed,bldDeedRepl,bldSearch,bldSearchRepl
														);
	
	// Add to superfiles
	add2SuperFiles	:=	sequential(	fileservices.startsuperfiletransaction(),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedAddlLegal		,vFilePrefix	+	'::deed_addl_legal'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedReplAddlLegal,vFilePrefix	+	'::deed_repl_addl_legal'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedAddlNames		,vFilePrefix	+	'::deed_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedReplAddlNames,vFilePrefix	+	'::deed_repl_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeed							,vFilePrefix	+	'::deed'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedRepl					,vFilePrefix	+	'::deed_repl'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedSearch				,vFilePrefix	+	'::deed_search'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNDeedReplSearch		,vFilePrefix	+	'::deed_repl_search'),
																	fileservices.finishsuperfiletransaction()
																);
	
	return	sequential(bldPrepFiles ,add2SuperFiles);
	
end;
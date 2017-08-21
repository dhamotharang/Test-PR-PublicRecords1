import	Address,Census_Data,Tools,ut;

export	Prep_OKC_Mortgages(string	pVersionDate)	:=
function
	// Get max value for fares id  //LNDeed  LNDeedRepl

	maxLNMortgageFaresID			:=		max(		ln_propertyv2.Files.Prep.LNDeed(ln_fares_id[1..2]	=	'OM')
																	+	ln_propertyv2.Files.Prep.LNDeedRepl(ln_fares_id[1..2]	=	'OM'),
																	(unsigned)ln_fares_id[3..]
																)	:	global;/*max(		ln_propertyv2.Files.Prep.LNMortgage(ln_fares_id[1..2]	=	'OM')
																			+	ln_propertyv2.Files.Prep.LNMortgageRepl(ln_fares_id[1..2]	=	'OM'),
																			(unsigned)ln_fares_id[3..]
																		)	:	global;*/
	
	// Mortgage vendor files
	dMortgageRaw			:=	ln_propertyv2.Files.In.LNMortgage;
	dMortgageRawRepl	:=	ln_propertyv2.Files.In.LNMortgageRepl;
	
	// Dedup the files so as to remove duplicate records
	dMortgageRawDedup			:=	dedup(dMortgageRaw,record,all);
	dMortgageRawReplDedup	:=	dedup(dMortgageRawRepl,record,all);
	
	// Add replacement record indicator for Mortgages
	rAppendReplIndicator_Layout	:=
	record
		string1	ReplRecordInd;
		LN_Propertyv2.Layout_Prep.In.MortgagePayload;
	end;
	
	rAppendReplIndicator_Layout	tAppendReplInd(LN_Propertyv2.Layout_Prep.In.MortgagePayload	pInput,boolean	isRepl)	:=
	transform
		self.ReplRecordInd	:=	if(isRepl,'Y','N');
		self.MainRecordCode	:=	ut.fnTrim2Upper(pInput.MainRecordCode);
		self								:=	pInput;
	end;
	
	dMortgageRawAppendReplInd			:=	project(dMortgageRawDedup,tAppendReplInd(left,false));
	dMortgageRawReplAppendReplInd	:=	project(dMortgageRawReplDedup,tAppendReplInd(left,true));
	
	// Combine replacement and non replacement files
	dMortgageRawCombined	:=	dMortgageRawAppendReplInd	+	dMortgageRawReplAppendReplInd;
	
	// Split out the addl buyer, seller and main records from the combined file
	dAddlBorrowerRaw	:=	dMortgageRawCombined(MainRecordCode	=	'B');
	dMortgageMainRaw	:=	dMortgageRawCombined(MainRecordCode	!=	'B');
	
	// Redefine format the layout
	Tools.mac_RedefineFormat(dAddlBorrowerRaw,LN_Propertyv2.Layout_Prep.In.AddlBorrower	,dAddlBorrowerReformat,pShouldExport	:=	false);
	Tools.mac_RedefineFormat(dMortgageMainRaw,LN_Propertyv2.Layout_Prep.In.Mortgage			,dMortgageMainReformat,pShouldExport	:=	false);
	
	// Addl buyer clean
	LN_Propertyv2.Functions.CleanFields(dAddlBorrowerReformat,dAddlBorrowerClean);
	
	// Distribute files
	dAddlBorrowerCleanDist		:=	distribute(	project(	dAddlBorrowerClean,
																												transform(	LN_Propertyv2.Layout_Prep.In.AddlBorrower,
																																		self.recording_date	:=	case(	length(ut.fnTrim2Upper(left.recording_date)),
																																																	8	=>	left.recording_date[5..8]	+	left.recording_date[1..4],
																																																	6	=>	left.recording_date[3..6]	+	left.recording_date[1..2],
																																																	left.recording_date
																																																);
																																		self								:=	left;
																																	)
																											),
																							hash32(record_type,state,county_name,fips_code,apnt_or_pin_number)
																						);
	
	// Remove names with start with SG and map to common layout
	LN_Propertyv2.Layout_Prep.Temp.Deed	tMap2Common(dMortgageMainReformat	pInput,integer	cnt)	:=
	transform
		// Temporary variables
		unsigned	vFaresID													:=	maxLNMortgageFaresID	+	cnt;
		
		string		vBorrower1												:=		pInput.borrower1_last_or_corp_name
																										+	if(pInput.borrower1_last_or_corp_name	!=	''	and	pInput.borrower1_first_middle_name	!=	'',', ','')
																										+	pInput.borrower1_first_middle_name;
		string		vBorrower2												:=		pInput.borrower2_last_or_corp_name
																										+	if(pInput.borrower2_last_or_corp_name	!=	''	and	pInput.borrower2_first_middle_name	!=	'',', ','')
																										+	pInput.borrower2_first_middle_name;
		
		string		vCleanBorrower1										:=	LN_Propertyv2.Functions.fCleanName(vBorrower1);
		string		vCleanBorrower2										:=	LN_Propertyv2.Functions.fCleanName(vBorrower2);
		
		string		vPrepBorrowerMailingUnitNumber		:=	ut.fnTrim2Upper(pInput.borrower_mailing_unit_number);
		string		vPrepPropertyUnitNumber						:=	ut.fnTrim2Upper(pInput.property_address_unit_number);
		
		string		vPrepBorrowerMailingStreetAddr		:=	ut.fnTrim2Upper(pInput.borrower_mailing_full_street_address);
		string		vPrepPropertyStreetAddr						:=	ut.fnTrim2Upper(pInput.property_full_street_address);
		
		// Check if the Borrower mailing address unit number exists in the full street address
		unsigned	vBorrowerMailStreetAddrSpaceCount	:=	StringLib.stringFindCount(vPrepBorrowerMailingStreetAddr,' ');
		unsigned	vBorrowerMailStreetAddrSpaceRIndex:=	StringLib.StringFind(vPrepBorrowerMailingStreetAddr,' ',vBorrowerMailStreetAddrSpaceCount);
		string		vBorrowerMailStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vPrepBorrowerMailingStreetAddr[vBorrowerMailStreetAddrSpaceRIndex+1..vBorrowerMailStreetAddrSpaceRIndex+6],'#');
		
		string		vBorrowerMailingUnitNumber				:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepBorrowerMailingStreetAddr),'#')	=	ut.fnTrim2Upper(vBorrowerMailStreetAddrUnitNumber)	and	vPrepBorrowerMailingUnitNumber	!=	'',
																												'',
																												vPrepBorrowerMailingUnitNumber
																											);
		
		// Check if the property address unit number exists in the full street address
		unsigned	vPropertyStreetAddrSpaceCount			:=	StringLib.stringFindCount(vPrepPropertyStreetAddr,' ');
		unsigned	vPropertyStreetAddrSpaceRIndex		:=	StringLib.StringFind(vPrepPropertyStreetAddr,' ',vPropertyStreetAddrSpaceCount);
		string		vPropertyStreetAddrUnitNumber			:=	StringLib.StringFilterOut(vPrepPropertyStreetAddr[vPropertyStreetAddrSpaceRIndex+1..vPropertyStreetAddrSpaceRIndex+6],'#');
		
		string		vPropertyUnitNumber								:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepPropertyStreetAddr),'#')	=	ut.fnTrim2Upper(vPropertyStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
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
		self.recording_date													:=	case(	length(ut.fnTrim2Upper(pInput.recording_date)),
																													8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																													6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																													pInput.recording_date
																												);
		self.contract_date													:=	case(	length(ut.fnTrim2Upper(pInput.contract_date)),
																													8	=>	pInput.contract_date[5..8]	+	pInput.contract_date[1..4],
																													6	=>	pInput.contract_date[3..6]	+	pInput.contract_date[1..2],
																													pInput.contract_date
																												);
		self.first_td_due_date											:=	case(	length(ut.fnTrim2Upper(pInput.first_td_due_date)),
																													8	=>	pInput.first_td_due_date[5..8]	+	pInput.first_td_due_date[1..4],
																													6	=>	pInput.first_td_due_date[3..6]	+	pInput.first_td_due_date[1..2],
																													pInput.first_td_due_date
																												);
		self.rate_change_frequency									:=	if(	length(ut.fnTrim2Upper(pInput.rate_change_frequency))	>	1,
																												'',
																												ut.fnTrim2Upper(pInput.rate_change_frequency)
																											);
		self.Append_ReplRecordInd										:=	pInput.replacement_record_ind;
		self.Append_PrepMailingAddr1								:=	ut.fnTrim2Upper(vPrepBorrowerMailingStreetAddr	+	' '	+	vBorrowerMailingUnitNumber);
		self.Append_PrepMailingAddr2								:=	regexreplace(	'([0]{5}|[,])$',
																																	ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.mailing_csz)),
																																	''
																																);
		self.Append_PrepPropertyAddr1								:=	ut.fnTrim2Upper(vPrepPropertyStreetAddr	+	' '	+	vPropertyUnitNumber);
		self.Append_PrepPropertyAddr2								:=	regexreplace(	'([0]{5}|[,])$',
																																	ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.property_address_citystatezip)),
																																	''
																																);
		
		self																				:=	pInput;
		self																				:=	[];
	end;
	
	dMortgage2Common	:=	project(dMortgageMainReformat,tMap2Common(left,counter)):independent;
	
	// Populate fipscode
	dMortgageFipscode	:=	join(	dMortgage2Common,
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
	dMortgage			:=	project(dMortgageFipscode(Append_ReplRecordInd	=	'N'),LN_PropertyV2.Layouts.PreProcess_Deed_Layout);
	dMortgageRepl	:=	project(dMortgageFipscode(Append_ReplRecordInd	=	'Y'),LN_PropertyV2.Layouts.PreProcess_Deed_Layout);
	
	// Distribute Mortgage file
	dMortgageFipscodeDist	:=	distribute(dMortgageFipscode,hash32(record_type,state,county_name,fips_code,apnt_or_pin_number));
	
	// Populate fares id for addl borrower records
	LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp	tAddlNameFaresID(LN_Propertyv2.Layout_Prep.Temp.Deed	le,LN_PropertyV2.Layout_Prep.In.AddlBorrower	ri)	:=
	transform
//This assume the date format is in CCYYMMDD; need to add logic to determine format is either CCYYMMDD or MMDDCCYY
// Bug 145096	
		string	vDateSeen						:=	if(	length(ut.fnTrim2Upper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(le.recording_date)),
																				ut.fnTrim2Upper(le.recording_date)[1..6],
																				ut.fnTrim2Upper(le.contract_date)[1..6]
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
		string	vBorrower10					:=		ri.borrower10_last_or_corp_name
																		+	if(ri.borrower10_last_or_corp_name	!=	''	and	ri.borrower10_first_middle_name	!=	'',', ','')
																		+	ri.borrower10_first_middle_name;
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
	
	dAddlNameFaresID	:=	join(	dMortgageFipscodeDist,
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
	transform
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
	
	dAddlNamePrep	:=	normalize(dAddlNameFaresID,13,tNormalizeAddlName(left,counter));
	
	// Reformat to bring to base file layouts
	dAddlName			:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'N'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	dAddlNameRepl	:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'Y'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	
	// Normalize addl name file by name
	LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlBorrowerTemp	pInput,integer	cnt)	:=
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
	
	dAddlNameNormName	:=	normalize(dAddlNameFaresID,13,tNormalizeAddlNameSearch(left,counter));
	
 	// Normalize addl name search file by address
	LN_PropertyV2.Layout_Prep.Temp.Search	tNormalizeAddlNameAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'B','P');
		self									:=	pInput;
	end;
	
	dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),2,tNormalizeAddlNameAddr(left,counter));
	
	dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Normalize the Mortgage file by name to create an intial Mortgage search file
	LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tMortgageNormName(LN_Propertyv2.Layout_Prep.Temp.Deed	pInput,integer	cnt)	:=
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
		self.nameasis									:=	choose(cnt,pInput.name1,pInput.name2);
		self.which_orig								:=	choose(cnt,'1','2');
		self.source_code							:=	'B';
		self													:=	pInput;
		self													:=	[];
	end;
	
	dMortgageNormName	:=	normalize(dMortgageFipscode,2,tMortgageNormName(left,counter));
	
	// Normalize the Mortgage search file by address
	LN_Propertyv2.Layout_Prep.Temp.Search	tMortgageNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'B','P');
		self									:=	pInput;
	end;
	
	dMortgageNormAddr	:=	normalize(dMortgageNormName(nameasis	!=	''),2,tMortgageNormAddr(left,counter));
	
	dMortgageSearch	:=	dMortgageNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Combine all the search files (normalized files from addl names and Mortgage)
	dSearchCombined	:=	dAddlNameSearch	+	dMortgageSearch;
	
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
	vFilePrefix					:=	LN_Propertyv2.cluster	+	'in::ln_propertyv2::'	+	pVersionDate;
	
	// Delete superfile names
	vDeleteFlag					:=	'_delete';
	vAddlNameDelete			:=	LN_Propertyv2.fileNames.Prep.LNMortgageAddlNames			+	vDeleteFlag;
	vAddlNameReplDelete	:=	LN_Propertyv2.fileNames.Prep.LNMortgageReplAddlNames	+	vDeleteFlag;
	vMortgageDelete			:=	LN_Propertyv2.fileNames.Prep.LNMortgage								+	vDeleteFlag;
	vMortgageReplDelete	:=	LN_Propertyv2.fileNames.Prep.LNMortgageRepl						+	vDeleteFlag;
	vSearchDelete				:=	LN_Propertyv2.fileNames.Prep.LNMortgageSearch					+	vDeleteFlag;
	vSearchReplDelete		:=	LN_Propertyv2.fileNames.Prep.LNMortgageReplSearch			+	vDeleteFlag;
	
	// output prepped files
	bldAddlName				:=	output(dAddlName		,,vFilePrefix	+	'::mortgage_addl_names'			,__compressed__);
	bldAddlNameRepl		:=	output(dAddlNameRepl,,vFilePrefix	+	'::mortgage_repl_addl_names',__compressed__);
	bldMortgage				:=	output(dMortgage		,,vFilePrefix	+	'::mortgage'								,__compressed__);
	bldMortgageRepl		:=	output(dMortgageRepl,,vFilePrefix	+	'::mortgage_repl'						,__compressed__);
	bldSearch					:=	output(dSearch			,,vFilePrefix	+	'::mortgage_search'					,__compressed__);
	bldSearchRepl			:=	output(dSearchRepl	,,vFilePrefix	+	'::mortgage_repl_search'		,__compressed__);
	
	bldPrepFiles	:=	parallel(	bldAddlName,bldAddlNameRepl,bldMortgage,
															bldMortgageRepl,bldSearch,bldSearchRepl
														);
	
	// Add to superfiles
	add2SuperFiles	:=	sequential(	fileservices.startsuperfiletransaction(),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgageAddlNames		,vFilePrefix	+	'::mortgage_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgageReplAddlNames,vFilePrefix	+	'::mortgage_repl_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgage							,vFilePrefix	+	'::mortgage'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgageRepl					,vFilePrefix	+	'::mortgage_repl'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgageSearch				,vFilePrefix	+	'::mortgage_search'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNMortgageReplSearch		,vFilePrefix	+	'::mortgage_repl_search'),
																	fileservices.finishsuperfiletransaction()
																);
	
	
	return	sequential(bldPrepFiles,add2SuperFiles);
end;
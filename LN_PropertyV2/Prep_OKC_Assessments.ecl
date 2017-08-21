import	Address,Census_Data,Tools,ut;

export	Prep_OKC_Assessments(string	pVersionDate)	:=
function
	// Get max value for fares id
	maxLNAssesFaresID	:=	max(		ln_propertyv2.Files.Prep.LNAssessment(ln_fares_id[1..2]	=	'OA')
															+	ln_propertyv2.Files.Prep.LNAssessmentRepl(ln_fares_id[1..2]	=	'OA'),
															(unsigned)ln_fares_id[3..]
														)	:	global;
	
	// Assessment vendor files
	dAssessmentRaw			:=	ln_propertyv2.Files.In.LNAssessment;
	dAssessmentRawRepl	:=	ln_propertyv2.Files.In.LNAssessmentRepl;
	
	// Dedup the files so as to remove duplicate records
	dAssessmentRawDedup			:=	dedup(dAssessmentRaw,record,all);
	dAssessmentRawReplDedup	:=	dedup(dAssessmentRawRepl,record,all);
	
	// Add replacement record indicator for assessments
	rAppendReplIndicator_Layout	:=
	record
		string1	ReplRecordInd;
		LN_Propertyv2.Layout_Prep.In.AssessmentPayload;
	end;
	
	rAppendReplIndicator_Layout	tAppendReplInd(LN_Propertyv2.Layout_Prep.In.AssessmentPayload	pInput,boolean	isRepl)	:=
	transform
		self.ReplRecordInd	:=	if(isRepl,'Y','N');
		self.MainRecordCode	:=	ut.fnTrim2Upper(pInput.MainRecordCode);
		self								:=	pInput;
	end;
	
	dAssesRawAppendReplInd			:=	project(dAssessmentRawDedup,tAppendReplInd(left,false));
	dAssesRawReplAppendReplInd	:=	project(dAssessmentRawReplDedup,tAppendReplInd(left,true));
	
	// Combine replacement and non replacement files
	dAssesRawCombined	:=	dAssesRawAppendReplInd	+	dAssesRawReplAppendReplInd;
	
	// Split out the addl name, legal and main records from the combined file
	dAddlLegalRaw	:=	dAssesRawCombined(MainRecordCode	=	'L');
	dAddlNameRaw	:=	dAssesRawCombined(MainRecordCode	=	'O');
	dAssesRaw			:=	dAssesRawCombined(MainRecordCode	not in	['L','O']);
	
	// Redefine format the layout
	Tools.mac_RedefineFormat(dAddlLegalRaw,LN_Propertyv2.Layout_Prep.In.AddlLegal	,dAddlLegalReformat	,pShouldExport	:=	false);
	Tools.mac_RedefineFormat(dAddlNameRaw	,LN_Propertyv2.Layout_Prep.In.AddlName	,dAddlNameReformat	,pShouldExport	:=	false);
	Tools.mac_RedefineFormat(dAssesRaw		,LN_Propertyv2.Layout_Prep.In.Assessment,dAssessmentReformat,pShouldExport	:=	false);
	
	// Addl legal clean
	LN_Propertyv2.Layout_Prep.In.AddlLegal	tCleanAddlLegal(LN_Propertyv2.Layout_Prep.In.AddlLegal	pInput)	:=
	transform
		self.state_code													:=	ut.fnTrim2Upper(pInput.state_code);
		self.county_name												:=	ut.fnTrim2Upper(pInput.county_name);
		self.apna_or_pin_number									:=	ut.fnTrim2Upper(pInput.apna_or_pin_number);
		self.duplicate_apn_multiple_address_id	:=	ut.fnTrim2Upper(pInput.duplicate_apn_multiple_address_id);
		self																		:=	pInput;
	end;
	
	dAddlLegalClean	:=	project(dAddlLegalReformat,tCleanAddlLegal(left));
	
	// Addl name clean
	LN_Propertyv2.Layout_Prep.In.AddlName	tCleanAddlName(LN_Propertyv2.Layout_Prep.In.AddlName	pInput)	:=
	transform
		self.state_code													:=	ut.fnTrim2Upper(pInput.state_code);
		self.county_name												:=	ut.fnTrim2Upper(pInput.county_name);
		self.apna_or_pin_number									:=	ut.fnTrim2Upper(pInput.apna_or_pin_number);
		self.duplicate_apn_multiple_address_id	:=	ut.fnTrim2Upper(pInput.duplicate_apn_multiple_address_id);
		self.addl_owner_name_type_1							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_1);
		self.addl_owner_name_type_2							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_2);
		self.addl_owner_name_type_3							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_3);
		self.addl_owner_name_type_4							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_4);
		self.addl_owner_name_type_5							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_5);
		self.addl_owner_name_type_6							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_6);
		self.addl_owner_name_type_7							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_7);
		self.addl_owner_name_type_8							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_8);
		self.addl_owner_name_type_9							:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_9);
		self.addl_owner_name_type_10						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_10);
		self.addl_owner_name_type_11						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_11);
		self.addl_owner_name_type_12						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_12);
		self.addl_owner_name_type_13						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_13);
		self.addl_owner_name_type_14						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_14);
		self.addl_owner_name_type_15						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_15);
		self.addl_owner_name_type_16						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_16);
		self.addl_owner_name_type_17						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_17);
		self.addl_owner_name_type_18						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_18);
		self.addl_owner_name_type_19						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_19);
		self.addl_owner_name_type_20						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_20);
		self.addl_owner_name_type_21						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_21);
		self.addl_owner_name_type_22						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_22);
		self.addl_owner_name_type_23						:=	LN_Propertyv2.Functions.fCleanName(pInput.addl_owner_name_type_23);
		self																		:=	pInput;
	end;
	
	dAddlNameClean	:=	project(dAddlNameReformat,tCleanAddlName(left));
	
	// Distribute files
	dAddlLegalCleanDist	:=	distribute(dAddlLegalClean,hash32(state_code,county_name,apna_or_pin_number));
	dAddlNameCleanDist	:=	distribute(dAddlNameClean	,hash32(state_code,county_name,apna_or_pin_number));
	
	// Remove names with start with SG
	LN_Propertyv2.Layout_Prep.In.Assessment	tPrepAssesseeName(LN_Propertyv2.Layout_Prep.In.Assessment	pInput)	:=
	transform		
		self.assessee_name				:=	LN_Propertyv2.Functions.fCleanName(pInput.assessee_name);
		self.second_assessee_name	:=	LN_Propertyv2.Functions.fCleanName(pInput.second_assessee_name);
		self.mailing_care_of_name	:=	LN_Propertyv2.Functions.fCleanName(pInput.mailing_care_of_name);
		self											:=	pInput;
	end;
	
	dAssesPrepName	:=	project(dAssessmentReformat,tPrepAssesseeName(left));
	
	// Map to common layout
	LN_Propertyv2.Layout_Prep.Temp.Assessment	tMap2Common(dAssesPrepName	pInput,integer	cnt)	:=
	transform
		// Temporary variables
		unsigned	vFaresID									:=	maxLNAssesFaresID	+	cnt;
		
		string		vMailingStreetAddr				:=	ut.fnTrim2Upper(		pInput.mailing_house_number						+	' '
																															+	pInput.mailing_house_alpha						+	' '
																															+	pInput.mailing_street_direction_left	+	' '
																															+	pInput.mailing_street_name						+	' '
																															+	pInput.mailing_street_suffix					+	' '
																															+	pInput.mailing_street_direction_right
																														);
		
		string		vPrepMailingUnitNumber		:=	ut.fnTrim2Upper(pInput.mailing_unit_number);
		
		unsigned	vMailStreetAddrSpaceCount	:=	StringLib.stringFindCount(vMailingStreetAddr,' ');
		unsigned	vMailStreetAddrSpaceRIndex:=	StringLib.StringFind(vMailingStreetAddr,' ',vMailStreetAddrSpaceCount);
		string		vMailStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vMailingStreetAddr[vMailStreetAddrSpaceRIndex+1..vMailStreetAddrSpaceRIndex+6],'#');
		
		string		vMailingUnitNumber				:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepMailingUnitNumber),'#')	=	ut.fnTrim2Upper(vMailStreetAddrUnitNumber)	and	vPrepMailingUnitNumber	!=	'',
																								'',
																								vPrepMailingUnitNumber
																							);
		
		string		vPropertyStreetAddr				:=	ut.fnTrim2Upper(		pInput.property_house_number					+	' '
																															+	pInput.property_house_alpha						+	' '
																															+	pInput.property_street_direction_left	+	' '
																															+	pInput.property_street_name						+	' '
																															+	pInput.property_street_suffix					+	' '
																															+	pInput.property_street_direction_right
																														);
		
		string		vPrepPropertyUnitNumber		:=	ut.fnTrim2Upper(pInput.property_unit_number);
		
		unsigned	vPropStreetAddrSpaceCount	:=	StringLib.stringFindCount(vPropertyStreetAddr,' ');
		unsigned	vPropStreetAddrSpaceRIndex:=	StringLib.StringFind(vPropertyStreetAddr,' ',vPropStreetAddrSpaceCount);
		string		vPropStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vPropertyStreetAddr[vPropStreetAddrSpaceRIndex+1..vPropStreetAddrSpaceRIndex+6],'#');
		
		string		vPropertyUnitNumber				:=	if(	StringLib.StringFilterOut(ut.fnTrim2Upper(vPrepPropertyUnitNumber),'#')	=	ut.fnTrim2Upper(vPropStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
																								'',
																								vPrepPropertyUnitNumber
																							);
		
		self.ln_fares_id										:=	'OA'	+	intformat(vFaresID,10,1);
		self.process_date										:=	pVersionDate;
		self.vendor_source_flag							:=	'O';
		self.state_code											:=	ut.fnTrim2Upper(pInput.state_code);
		self.county_name										:=	ut.fnTrim2Upper(pInput.county_name);
		self.apna_or_pin_number							:=	ut.fnTrim2Upper(pInput.apna_or_pin_number);
		self.duplicate_apn_multiple_address_id	:=	ut.fnTrim2Upper(pInput.duplicate_apn_multiple_address_id);
		self.assessee_ownership_rights_code	:=	if(	ut.fnTrim2Upper(pInput.assessee_vesting_id_code)	in	LN_Propertyv2.Constants.Lookups.Rights,
																								ut.fnTrim2Upper(pInput.assessee_vesting_id_code),
																								''
																							);
		self.assessee_relationship_code			:=	if(	ut.fnTrim2Upper(pInput.assessee_vesting_id_code)	in	LN_Propertyv2.Constants.Lookups.Relationships,
																								ut.fnTrim2Upper(pInput.assessee_vesting_id_code),
																								''
																							);
		self.assessee_name_type_code				:=	pInput.assessee_name_type;
		self.second_assessee_name_type_code	:=	pInput.second_assessee_name_type;
		self.mail_care_of_name_type_code		:=	pInput.mail_care_of_name_type;
		self.mailing_full_street_address		:=	if(	pInput.mailing_full_street_address	!=	'',
																								pInput.mailing_full_street_address,
																								ut.fnTrim2Upper(vMailingStreetAddr	+	' '	+	vMailingUnitNumber)
																							);
		self.mailing_city_state_zip					:=	if(	pInput.mailing_city_state_zip	!=	'',
																								pInput.mailing_city_state_zip,
																								Address.Addr2FromComponentsWithZip4(	pInput.mailing_city_name,
																																											pInput.mailing_state,
																																											pInput.mailing_zip_code,
																																											pInput.mailing_zip_4
																																										)
																							);
		self.property_full_street_address		:=	if(	pInput.property_full_street_address	!=	'',
																								pInput.property_full_street_address,
																								ut.fnTrim2Upper(vPropertyStreetAddr	+	' '	+	vPropertyUnitNumber)
																							);
		self.property_city_state_zip				:=	Address.Addr2FromComponentsWithZip4(	pInput.property_city_name,
																																									pInput.property_state,
																																									pInput.property_zip_code,
																																									pInput.property_zip_4
																																								);
		self.property_address_code					:=	pInput.property_address_source_flag;
		self.record_type_code								:=	pInput.record_type;
		self.new_record_type_code						:=	pInput.new_record_type;
		self.recording_date									:=	case(	length(ut.fnTrim2Upper(pInput.recording_date)),
																									8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																									6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																									pInput.recording_date
																								);
		self.prior_recording_date						:=	case(	length(ut.fnTrim2Upper(pInput.prior_recording_date)),
																									8	=>	pInput.prior_recording_date[5..8]	+	pInput.prior_recording_date[1..4],
																									6	=>	pInput.prior_recording_date[3..6]	+	pInput.prior_recording_date[1..2],
																									pInput.prior_recording_date
																								);
		self.prior_sales_price_code					:=	pInput.prior_sales_code;
		self.assessed_total_value						:=	pInput.total_assessed_value;
		self.assessed_value_year						:=	pInput.assessment_year;
		self.homestead_homeowner_exemption	:=	pInput.california_homeowner_exemption;
		self.land_acres											:=	if(	stringlib.stringfind(ut.fnTrim2Upper(pInput.lot_size_or_area),'AC',1)	!=	0,
																								pInput.lot_size_or_area,
																								''
																							);
		self.land_square_footage						:=	if(	stringlib.stringfind(ut.fnTrim2Upper(pInput.lot_size_or_area),'SF',1)	!=	0,
																								pInput.lot_size_or_area,
																								''
																							);
		self.land_dimensions								:=	if(	stringlib.stringfind(ut.fnTrim2Upper(pInput.lot_size_or_area),'AC',1)	!=	0	and	stringlib.stringfind(ut.fnTrim2Upper(pInput.lot_size_or_area),'SF',1)	!=	0,
																								pInput.lot_size_or_area,
																								''
																							);
		self.garage_type_code								:=	pInput.garage_type;
		self.pool_code											:=	pInput.pool;
		self.style_code											:=	pInput.style;
		self.type_construction_code					:=	pInput.type_construction;
		self.exterior_walls_code						:=	pInput.exterior_walls;
		self.foundation_code								:=	pInput.foundation;
		self.roof_cover_code								:=	pInput.roof_cover;
		self.roof_type_code									:=	pInput.roof_type;
		self.heating_code										:=	pInput.heating;
		self.heating_fuel_type_code					:=	pInput.heating_fuel_type;
		self.air_conditioning_code					:=	pInput.air_conditioning;
		self.air_conditioning_type_code			:=	pInput.air_conditioning_type;
		self.fireplace_indicator						:=	if(	ut.fnTrim2Upper(pInput.fireplace)	=	'Y'	or	regexfind('^[0-9]+$',ut.fnTrim2Upper(pInput.fireplace)),
																								'Y',
																								''
																							);
		self.fireplace_number								:=	if(	ut.fnTrim2Upper(pInput.fireplace)	=	'Y'	or	pInput.fireplace	=	'',
																								'',
																								pInput.fireplace
																							);
		self.basement_code									:=	pInput.basement;
		self.building_class_code						:=	pInput.building_class;
		self.site_influence1_code						:=	pInput.site_influence1;
		self.site_influence2_code						:=	pInput.site_influence2;
		self.tape_cut_date									:=	if(	length(ut.fnTrim2Upper(pInput.tape_cut_date))	=	6,
																								pInput.tape_cut_date[3..6]	+	pInput.tape_cut_date[1..2],
																								pInput.tape_cut_date
																							);
		self.certification_date							:=	case(	length(ut.fnTrim2Upper(pInput.certification_date)),
																									8	=>	pInput.certification_date[5..8]	+	pInput.certification_date[1..4],
																									6	=>	pInput.certification_date[3..6]	+	pInput.certification_date[1..2],
																									pInput.certification_date
																								);
		self.lot_size_frontage_feet					:=	pInput.lot_size_frontage;
		self.lot_size_depth_feet						:=	pInput.lot_size_depth;
		self.building_quality_code					:=	pInput.building_quality;
		self.building_condition_code				:=	pInput.building_condition;
		self.interior_walls_code						:=	pInput.interior_walls;
		self.floor_cover_code								:=	pInput.floor_cover;
		self.water_code											:=	pInput.water;
		self.sewer_code											:=	pInput.sewer;
		self.topograpy_code									:=	pInput.topography;
		self.other_rooms_indicator					:=	pInput.other_rooms;
		self.Append_ReplRecordInd						:=	pInput.replacement_record_ind;
		self.Append_PrepMailingAddr1				:=	ut.fnTrim2Upper(self.mailing_full_street_address);
		self.Append_PrepMailingAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																													ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.mailing_city_state_zip)),
																													''
																												);
		self.Append_PrepPropertyAddr1				:=	ut.fnTrim2Upper(self.property_full_street_address);
		self.Append_PrepPropertyAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																													ut.fnTrim2Upper(LN_Propertyv2.Functions.fDropZip4(self.property_city_state_zip)),
																													''
																												);
		
		self																:=	pInput;
		self																:=	[];
	end;
	
	dAsses2Common	:=	project(dAssesPrepName,tMap2Common(left,counter)):independent;
	
	// Populate fipscode
	dAssesFipscode	:=	join(	dAsses2Common,
														Census_Data.File_Fips2County,
														ut.fnTrim2Upper(left.state_code)	=	ut.fnTrim2Upper(right.state_code)	and
														ut.fnTrim2Upper(left.county_name)	=	ut.fnTrim2Upper(right.county_name),
														transform(	LN_Propertyv2.Layout_Prep.Temp.Assessment,
																				self.fips_code	:=	right.state_fips	+	right.county_fips;
																				self						:=	left;
																			),
														left outer,
														lookup
													);
	
	// Reformat to bring to base file layouts
	dAssessment			:=	project(dAssesFipscode(Append_ReplRecordInd	=	'N'),LN_PropertyV2.Layouts.PreProcess_Assessor_Layout);
	dAssessmentRepl	:=	project(dAssesFipscode(Append_ReplRecordInd	=	'Y'),LN_PropertyV2.Layouts.PreProcess_Assessor_Layout);
	
	// Distribute assessment file
	dAssesFipscodeDist	:=	distribute(dAssesFipscode,hash32(state_code,county_name,apna_or_pin_number));
	
	// Populate fares id for addl legal records
	LN_PropertyV2.Layout_Prep.Temp.AddlLegal	tAddlLegalFaresID(LN_Propertyv2.Layout_Prep.Temp.Assessment	le,LN_PropertyV2.Layout_Prep.In.AddlLegal	ri)	:=
	transform
		self.addl_legal	:=	ri.legal_description;
		self						:=	le;
	end;
	
	dAddlLegalPrep	:=	join(	dAssesFipscodeDist,
														dAddlLegalCleanDist,
														left.Append_ReplRecordInd								=	right.replacement_record_ind	and
														left.state_code													=	right.state_code							and
														left.county_name												=	right.county_name							and
														left.apna_or_pin_number									=	right.apna_or_pin_number			and
														left.duplicate_apn_multiple_address_id	=	right.duplicate_apn_multiple_address_id,
														tAddlLegalFaresID(left,right),
														local
													);
	
	// Reformat to bring to base file layouts
	dAddlLegal			:=	project(dAddlLegalPrep(Append_ReplRecordInd	=	'N'),LN_Propertyv2.Layout_Addl_Legal);
	dAddlLegalRepl	:=	project(dAddlLegalPrep(Append_ReplRecordInd	=	'Y'),LN_Propertyv2.Layout_Addl_Legal);
	
	// Populate fares id for addl name records
	LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	tAddlNameFaresID(LN_Propertyv2.Layout_Prep.Temp.Assessment	le,LN_PropertyV2.Layout_Prep.In.AddlName	ri)	:=
	transform
		string	vDateSeen			:=	map(	length(ut.fnTrim2Upper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(le.recording_date)) and le.recording_date[1..2] in ['17','18','19','20']	=>	ut.fnTrim2Upper(le.recording_date)[1..6],
																		length(ut.fnTrim2Upper(le.recording_date))	in	[6,8]	and le.recording_date[1..2] not in ['17','18','19','20']
																					and le.recording_date[1..2] in ['01','02','03','04','05','06','07','08','09','10','11','12'] =>	le.recording_date[5..8] + le.recording_date[1..2],
																		length(ut.fnTrim2Upper(le.recording_date))	in	[6,8]	and	 regexfind('^[00]+$',ut.fnTrim2Upper(le.recording_date))	=> le.recording_date[5..8] + '00',	
																		length(ut.fnTrim2Upper(le.sale_date))				in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(le.sale_date))and le.sale_date[1..2] in ['17','18','19','20']			=>	ut.fnTrim2Upper(le.sale_date)[1..6],
																		regexreplace('^[0]*$',StringLib.StringFindReplace(StringLib.StringRepad(ut.fnTrim2Upper(le.tax_year),6),' ','0'),'')
																	);
		
		self.ln_fares_id			:=	le.ln_fares_id;
		self.dt_first_seen		:=	vDateSeen;
		self.dt_last_seen			:=	vDateSeen;
		self									:=	le;
		self									:=	ri;
	end;
	
	dAddlNameFaresID	:=	join(	dAssesFipscodeDist,
															dAddlNameCleanDist,
															left.Append_ReplRecordInd								=	right.replacement_record_ind	and
															left.state_code													=	right.state_code							and
															left.county_name												=	right.county_name							and
															left.apna_or_pin_number									=	right.apna_or_pin_number			and
															left.duplicate_apn_multiple_address_id	=	right.duplicate_apn_multiple_address_id,
															tAddlNameFaresID(left,right),
															local
														);
	
	// Normalize addl name file to create base file
	LN_PropertyV2.Layout_Prep.Temp.AddlName	tNormalizeAddlName(LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	pInput,integer	cnt)	:=
	transform
		self.apnt_or_pin_number		:=	pInput.apna_or_pin_number;
		self.buyer_or_seller			:=	'O';
		self.name_seq							:=	(string)cnt;
		self.name									:=	choose(	cnt,
																					pInput.addl_owner_name_1,
																					pInput.addl_owner_name_2,
																					pInput.addl_owner_name_3,
																					pInput.addl_owner_name_4,
																					pInput.addl_owner_name_5,
																					pInput.addl_owner_name_6,
																					pInput.addl_owner_name_7,
																					pInput.addl_owner_name_8,
																					pInput.addl_owner_name_9,
																					pInput.addl_owner_name_10,
																					pInput.addl_owner_name_11,
																					pInput.addl_owner_name_12,
																					pInput.addl_owner_name_13,
																					pInput.addl_owner_name_14,
																					pInput.addl_owner_name_15,
																					pInput.addl_owner_name_16,
																					pInput.addl_owner_name_17,
																					pInput.addl_owner_name_18,
																					pInput.addl_owner_name_19,
																					pInput.addl_owner_name_20,
																					pInput.addl_owner_name_21,
																					pInput.addl_owner_name_22,
																					pInput.addl_owner_name_23
																				);
		self.id_code							:=	choose(	cnt,
																					pInput.LA_addl_owner_name_ind_1		+	pInput.addl_owner_name_type_1,
																					pInput.LA_addl_owner_name_ind_2		+	pInput.addl_owner_name_type_2,
																					pInput.LA_addl_owner_name_ind_3		+	pInput.addl_owner_name_type_3,
																					pInput.LA_addl_owner_name_ind_4		+	pInput.addl_owner_name_type_4,
																					pInput.LA_addl_owner_name_ind_5		+	pInput.addl_owner_name_type_5,
																					pInput.LA_addl_owner_name_ind_6		+	pInput.addl_owner_name_type_6,
																					pInput.LA_addl_owner_name_ind_7		+	pInput.addl_owner_name_type_7,
																					pInput.LA_addl_owner_name_ind_8		+	pInput.addl_owner_name_type_8,
																					pInput.LA_addl_owner_name_ind_9		+	pInput.addl_owner_name_type_9,
																					pInput.LA_addl_owner_name_ind_10	+	pInput.addl_owner_name_type_10,
																					pInput.LA_addl_owner_name_ind_11	+	pInput.addl_owner_name_type_11,
																					pInput.LA_addl_owner_name_ind_12	+	pInput.addl_owner_name_type_12,
																					pInput.LA_addl_owner_name_ind_13	+	pInput.addl_owner_name_type_13,
																					pInput.LA_addl_owner_name_ind_14	+	pInput.addl_owner_name_type_14,
																					pInput.LA_addl_owner_name_ind_15	+	pInput.addl_owner_name_type_15,
																					pInput.LA_addl_owner_name_ind_16	+	pInput.addl_owner_name_type_16,
																					pInput.LA_addl_owner_name_ind_17	+	pInput.addl_owner_name_type_17,
																					pInput.LA_addl_owner_name_ind_18	+	pInput.addl_owner_name_type_18,
																					pInput.LA_addl_owner_name_ind_19	+	pInput.addl_owner_name_type_19,
																					pInput.LA_addl_owner_name_ind_20	+	pInput.addl_owner_name_type_20,
																					pInput.LA_addl_owner_name_ind_21	+	pInput.addl_owner_name_type_21,
																					pInput.LA_addl_owner_name_ind_22	+	pInput.addl_owner_name_type_22,
																					pInput.LA_addl_owner_name_ind_23	+	pInput.addl_owner_name_type_23
																				);
		self.Append_ReplRecordInd	:=	pInput.replacement_record_ind;
		self											:=	pInput;
	end;
	
	dAddlNamePrep	:=	normalize(dAddlNameFaresID,23,tNormalizeAddlName(left,counter));
	
	// Reformat to bring to base file layouts
	dAddlName			:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'N'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	dAddlNameRepl	:=	project(dAddlNamePrep(Append_ReplRecordInd	=	'Y'	and	name	!=	''),LN_Propertyv2.Layout_Addl_Names);
	
	// Normalize addl name file by name
	LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	pInput,integer	cnt)	:=
	transform
		self.Append_ReplRecordInd			:=	pInput.replacement_record_ind;
		self.dt_vendor_first_reported	:=	(unsigned3)pVersionDate[1..6];
		self.dt_vendor_last_reported	:=	(unsigned3)pVersionDate[1..6];
		self.dt_first_seen						:=	(unsigned3)pInput.dt_first_seen;
		self.dt_last_seen							:=	(unsigned3)pInput.dt_last_seen;
		self.vendor_source_flag				:=	'O';
		self.process_date							:=	pVersionDate;
		self.source_code							:=	'O';
		self.which_orig								:=	(string)(2	+	cnt);
		self.nameasis									:=	choose(	cnt,
																							pInput.addl_owner_name_1,
																							pInput.addl_owner_name_2,
																							pInput.addl_owner_name_3,
																							pInput.addl_owner_name_4,
																							pInput.addl_owner_name_5,
																							pInput.addl_owner_name_6,
																							pInput.addl_owner_name_7,
																							pInput.addl_owner_name_8,
																							pInput.addl_owner_name_9,
																							pInput.addl_owner_name_10,
																							pInput.addl_owner_name_11,
																							pInput.addl_owner_name_12,
																							pInput.addl_owner_name_13,
																							pInput.addl_owner_name_14,
																							pInput.addl_owner_name_15,
																							pInput.addl_owner_name_16,
																							pInput.addl_owner_name_17,
																							pInput.addl_owner_name_18,
																							pInput.addl_owner_name_19,
																							pInput.addl_owner_name_20,
																							pInput.addl_owner_name_21,
																							pInput.addl_owner_name_22,
																							pInput.addl_owner_name_23
																						);
		
		self													:=	pInput;
		self													:=	[];
	end;
	
	dAddlNameNormName	:=	normalize(dAddlNameFaresID,23,tNormalizeAddlNameSearch(left,counter));
	
 	// Normalize addl name search file by address
	LN_PropertyV2.Layout_Prep.Temp.Search	tNormalizeAddlNameAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'O','P');
		self									:=	pInput;
	end;
	
	dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),2,tNormalizeAddlNameAddr(left,counter));
	
	dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Normalize the assessment file by name to create an intial assessment search file
	LN_Propertyv2.Layout_Prep.Temp.SearchTemp	tAssesNormName(LN_Propertyv2.Layout_Prep.Temp.Assessment	pInput,integer	cnt)	:=
	transform
		string	vDateSeen							:=	map(	length(ut.fnTrim2Upper(pInput.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(pInput.recording_date))	=>	ut.fnTrim2Upper(pInput.recording_date)[1..6],
																						length(ut.fnTrim2Upper(pInput.recording_date))	in	[6,8]	and pInput.recording_date[1..2] not in ['17','18','19','20']
																									and pInput.recording_date[1..2] in ['01','02','03','04','05','06','07','08','09','10','11','12'] =>	pInput.recording_date[5..8] + pInput.recording_date[1..2],
																						length(ut.fnTrim2Upper(pInput.recording_date))	in	[6,8]	and	 regexfind('^[0]+$',ut.fnTrim2Upper(pInput.recording_date))	=> pInput.recording_date[5..8] + '00',	
																						length(ut.fnTrim2Upper(pInput.sale_date))				in	[6,8]	and	~regexfind('^[0]+$',ut.fnTrim2Upper(pInput.sale_date))and pInput.sale_date[1..2] in ['17','18','19','20']			=>	ut.fnTrim2Upper(pInput.sale_date)[1..6],
																						regexreplace('^[0]*$',StringLib.StringFindReplace(StringLib.StringRepad(ut.fnTrim2Upper(pInput.tax_year),6),' ','0'),'')
																					);
		
		self.dt_first_seen						:=	(unsigned3)vDateSeen;
		self.dt_last_seen							:=	(unsigned3)vDateSeen;
		self.dt_vendor_first_reported	:=	(unsigned3)pVersionDate[1..6];
		self.dt_vendor_last_reported	:=	(unsigned3)pVersionDate[1..6];
		self.process_date							:=	pVersionDate;
		self.nameasis									:=	choose(cnt,pInput.assessee_name,pInput.second_assessee_name,pInput.mailing_care_of_name);
		self.which_orig								:=	choose(cnt,'1','2','1');
		self.source_code							:=	choose(cnt,'O','O','C');
		self													:=	pInput;
		self													:=	[];
	end;
	
	dAssesNormName	:=	normalize(dAssesFipscode,3,tAssesNormName(left,counter));
	
	// Normalize the assessment search file by address
	LN_Propertyv2.Layout_Prep.Temp.Search	tAssesNormAddr(LN_Propertyv2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
	transform
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
		self.source_code			:=	ut.fnTrim2Upper(pInput.source_code)	+	choose(cnt,'O','P');
		self									:=	pInput;
	end;
	
	dAssesNormAddr	:=	normalize(dAssesNormName(nameasis	!=	''),2,tAssesNormAddr(left,counter));
	
	dAssesSearch	:=	dAssesNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
	
	// Combine all the search files (normalized files from addl names and assessment)
	dSearchCombined	:=	dAddlNameSearch	+	dAssesSearch;
	
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
	
	LN_Propertyv2.Mac_Clean_Name(dSearchPrepAddr,dSearchCleanName,dAssessment);
	LN_Propertyv2.Append_AID(dSearchCleanName,dSearchCleanAddr,false);
	
	// Reformat to bring to base file layouts
	dSearch			:=	project(dSearchCleanAddr(Append_ReplRecordInd	=	'N'),LN_Propertyv2.Layout_Deed_Mortgage_Property_Search);
	dSearchRepl	:=	project(dSearchCleanAddr(Append_ReplRecordInd	=	'Y'),LN_Propertyv2.Layout_Deed_Mortgage_Property_Search);
	
	// File prefix
	vFilePrefix	:=	LN_Propertyv2.cluster	+	'in::ln_propertyv2::'	+	pVersionDate;
	
	bldAddlLegal			:=	output(dAddlLegal			,,vFilePrefix	+	'::assessor_addl_legal'			,__compressed__);
	bldAddlLegalRepl	:=	output(dAddlLegalRepl	,,vFilePrefix	+	'::assessor_repl_addl_legal',__compressed__);
	bldAddlName				:=	output(dAddlName			,,vFilePrefix	+	'::assessor_addl_names'			,__compressed__);
	bldAddlNameRepl		:=	output(dAddlNameRepl	,,vFilePrefix	+	'::assessor_repl_addl_names',__compressed__);
	bldAssessment			:=	output(dAssessment		,,vFilePrefix	+	'::assessor'								,__compressed__);
	bldAssessmentRepl	:=	output(dAssessmentRepl,,vFilePrefix	+	'::assessor_repl'						,__compressed__);
	bldSearch					:=	output(dSearch				,,vFilePrefix	+	'::assessor_search'					,__compressed__);
	bldSearchRepl			:=	output(dSearchRepl		,,vFilePrefix	+	'::assessor_repl_search'		,__compressed__);
	
	bldPrepFiles	:=	parallel(	bldAddlLegal,bldAddlLegalRepl,bldAddlName,bldAddlNameRepl,
															bldAssessment,bldAssessmentRepl,bldSearch,bldSearchRepl
														);
	
	// Add to superfiles
	add2SuperFiles	:=	sequential(	fileservices.startsuperfiletransaction(),																	
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentAddlLegal		,vFilePrefix	+	'::assessor_addl_legal'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentReplAddlLegal,vFilePrefix	+	'::assessor_repl_addl_legal'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentAddlNames		,vFilePrefix	+	'::assessor_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentReplAddlNames,vFilePrefix	+	'::assessor_repl_addl_names'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessment							,vFilePrefix	+	'::assessor'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentRepl					,vFilePrefix	+	'::assessor_repl'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentSearch				,vFilePrefix	+	'::assessor_search'),
																	fileservices.addsuperfile(LN_Propertyv2.fileNames.Prep.LNAssessmentReplSearch		,vFilePrefix	+	'::assessor_repl_search'),
/*  // Add to combined search, addl legal and addl names superfiles 																	
																	ln_propertyV2.Files.Prep.LNAddlNames  ,ln_propertyV2.filenames.Prep.LNAddlNames
																	ln_propertyV2.Files.Prep.LNAddlNamesRepl,ln_propertyV2.filenames.Prep.LNAddlNamesRepl
																	ln_propertyV2.Files.Prep.LNAddlLegalRepl,ln_propertyV2.filenames.Prep.LNAddllegalRepl
																	ln_propertyV2.Files.Prep.LNAddlLegal,ln_propertyV2.filenames.Prep.LNAddllegal
																	ln_propertyV2.Files.Prep.LNSearchRepl,ln_propertyV2.filenames.Prep.LNSearch	
																	ln_propertyV2.Files.Prep.LNSearch,ln_propertyV2.filenames.Prep.LNSearchRepl,*/
																	fileservices.finishsuperfiletransaction()
																);
	
	return	sequential(bldPrepFiles,add2SuperFiles);
end;
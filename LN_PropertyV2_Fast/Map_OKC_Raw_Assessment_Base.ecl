/*2014-08-27T05:15:11Z (Gabriel Marcan_prod)
fast property build 0.7 - see bugzilla https://bugzilla.seisint.com/show_bug.cgi?id=163383
*/
IMPORT aid,ln_propertyv2,Tools,ut,Address,Census_Data,nid;

EXPORT Map_OKC_Raw_Assessment_Base(string	pVersionDate,
																	 dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment)) iRokAn,
																	 dataset(recordof(LN_PropertyV2_Fast.Files.raw.bk_assessment)) iRokAr
																	 ) := MODULE
  SHARED common := MODULE
			EXPORT layout_pre_temp_assessment := RECORD
									LN_Propertyv2.Layout_Prep.Temp.Assessment;
									/*AID.Common.xAID	Append_RawAID;
									string10	prim_range;
									string2		predir;
									string28	prim_name;
									string4		suffix;
									string2		postdir;
									string10	unit_desig;
									string8		sec_range;
									string25	p_city_name;
									string25	v_city_name;
									string2		st;
									string5		zip;
									string4		zip4;
									string4		cart;
									string1		cr_sort_sz;
									string4		lot;
									string1		lot_order;
									string2		dbpc;
									string1		chk_digit;
									string2		rec_type;
									string5		county;
									string10	geo_lat;
									string11	geo_long;
									string4		msa;
									string7		geo_blk;
									string1		geo_match;
									string4		err_stat;*/
									string100 raw_file_name;
					END;
	END;
	SHARED PrepDataSet := MODULE
		
		// Adjust layout for replacement records
		iRokA_L		:=	{string1	ReplInd, recordof(iRokAn)};
		iRokA_L tRepl(iRokAn L, string1 isRepl) := TRANSFORM
			SELF.ReplInd := isRepl;
			SELF:=L;
		END;
		dAssesRawCombined :=	PROJECT(iRokAn, tRepl(LEFT,'N')) + PROJECT(iRokAr, tRepl(LEFT,'Y'));		
														
		// Split out datasets
		// Split out the addl name, legal and main records from the combined file
		dAssesRaw			:=	dAssesRawCombined(new_Record_Type_Legal_Description[1]	not in	['L','O']);
		dAddlLegalRaw	:=	dAssesRawCombined(new_Record_Type_Legal_Description[1]	=	'L');
		dAddlNameRaw	:=	dAssesRawCombined(new_Record_Type_Legal_Description[1]	=	'O');
		// Redefine format the layout
		Tools.mac_RedefineFormat(dAssesRaw		,LN_Propertyv2_Fast.Layout_Prep_In_Assessment,dAssessmentReformat,pShouldExport	:=	false);
		Tools.mac_RedefineFormat(dAddlLegalRaw,LN_Propertyv2.Layout_Prep.In.AddlLegal	,dAddlLegalReformat	,pShouldExport	:=	false);
		Tools.mac_RedefineFormat(dAddlNameRaw	,LN_Propertyv2.Layout_Prep.In.AddlName	,dAddlNameReformat	,pShouldExport	:=	false);
		
		EXPORT reformatted := MODULE
			EXPORT dAssessmentRef := dAssessmentReformat;
			EXPORT dAddlLegalRef := dAddlLegalReformat;
			EXPORT dAddlNameRef := dAddlNameReformat;
		END;
		
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Assessment
	// ---------------------------------------------------------------------------------------------------------
	EXPORT assessment := MODULE
		// Get max value for fares id
		maxLNAssesFaresID	:= max(
															max(	ln_propertyv2.Files.Prep.LNAssessment(ln_fares_id[1..2]	=	'OA')
																+	ln_propertyv2.Files.Prep.LNAssessmentRepl(ln_fares_id[1..2]	=	'OA'),
																(unsigned)ln_fares_id[3..]
															),
															max(  LN_PropertyV2_Fast.Files.prep.assessment (ln_fares_id[1..2]='OA'),
																(unsigned)ln_fares_id[3..]
																	)
															) :	global;
																									
		// Remove names with start with SG
		LN_Propertyv2_Fast.Layout_Prep_In_Assessment	tPrepAssesseeName(LN_Propertyv2_Fast.Layout_Prep_In_Assessment	pInput)	:= TRANSFORM	
		
			//Fix Truncated Names
			trNameA1           := LN_PropertyV2_Fast.Functions_Truncated_Names(pInput.assessee_name);
			trNameA2           := LN_PropertyV2_Fast.Functions_Truncated_Names(pInput.second_assessee_name);
			trNameM            := LN_PropertyV2_Fast.Functions_Truncated_Names(pInput.mailing_care_of_name);	
		
			self.assessee_name				:=	LN_Propertyv2.Functions.fCleanName(trNameA1);
			self.second_assessee_name	:=	LN_Propertyv2.Functions.fCleanName(trNameA2);
			self.mailing_care_of_name	:=	LN_Propertyv2.Functions.fCleanName(trNameM);
			self											:=	pInput;
		END;
		dAssesPrepName	:=	project(PrepDataSet.reformatted.dAssessmentRef,tPrepAssesseeName(left));
		// Map to common layout
		common.layout_pre_temp_assessment	tMap2Common(dAssesPrepName	pInput,integer	cnt)	:= TRANSFORM
			// Temporary variables
			unsigned	vFaresID									:=	maxLNAssesFaresID	+	cnt;
			
			string		vMailingStreetAddr				:=	ut.CleanSpacesAndUpper(		pInput.mailing_house_number						+	' '
																																+	pInput.mailing_house_alpha						+	' '
																																+	pInput.mailing_street_direction_left	+	' '
																																+	pInput.mailing_street_name						+	' '
																																+	pInput.mailing_street_suffix					+	' '
																																+	pInput.mailing_street_direction_right
																															);
			
			string		vPrepMailingUnitNumber		:=	if(trim(pInput.mailing_address_unit_number_LA_only)<>''
																									,ut.CleanSpacesAndUpper(pInput.mailing_address_unit_number_LA_only)
																									,ut.CleanSpacesAndUpper(pInput.mailing_unit_number));
			
			unsigned	vMailStreetAddrSpaceCount	:=	StringLib.stringFindCount(vMailingStreetAddr,' ');
			unsigned	vMailStreetAddrSpaceRIndex:=	StringLib.StringFind(vMailingStreetAddr,' ',vMailStreetAddrSpaceCount);
			string		vMailStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vMailingStreetAddr[vMailStreetAddrSpaceRIndex+1..vMailStreetAddrSpaceRIndex+6],'#');
			
			string		vMailingUnitNumber				:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepMailingUnitNumber),'#')	=	ut.CleanSpacesAndUpper(vMailStreetAddrUnitNumber)	and	vPrepMailingUnitNumber	!=	'',
																									'',
																									vPrepMailingUnitNumber
																								);
			
			string		vPropertyStreetAddr				:=	ut.CleanSpacesAndUpper(		pInput.property_house_number					+	' '
																																+	pInput.property_house_alpha						+	' '
																																+	pInput.property_street_direction_left	+	' '
																																+	pInput.property_street_name						+	' '
																																+	pInput.property_street_suffix					+	' '
																																+	pInput.property_street_direction_right
																															);

			string		vPrepPropertyUnitNumber		:=	if(trim(pInput.property_address_unit_number_LA_only)<>''
																									,ut.CleanSpacesAndUpper(pInput.property_address_unit_number_LA_only)
																									,ut.CleanSpacesAndUpper(pInput.property_unit_number));
			
			unsigned	vPropStreetAddrSpaceCount	:=	StringLib.stringFindCount(vPropertyStreetAddr,' ');
			unsigned	vPropStreetAddrSpaceRIndex:=	StringLib.StringFind(vPropertyStreetAddr,' ',vPropStreetAddrSpaceCount);
			string		vPropStreetAddrUnitNumber	:=	StringLib.StringFilterOut(vPropertyStreetAddr[vPropStreetAddrSpaceRIndex+1..vPropStreetAddrSpaceRIndex+6],'#');
			
			string		vPropertyUnitNumber				:=	if(	StringLib.StringFilterOut(ut.CleanSpacesAndUpper(vPrepPropertyUnitNumber),'#')	=	ut.CleanSpacesAndUpper(vPropStreetAddrUnitNumber)	and	vPrepPropertyUnitNumber	!=	'',
																									'',
																									vPrepPropertyUnitNumber
																								);
			
			self.ln_fares_id										:=	'OA'	+	intformat(vFaresID,10,1);
			self.process_date										:=	pVersionDate;
			self.vendor_source_flag							:=	'O';
			self.state_code											:=	ut.CleanSpacesAndUpper(pInput.state_code);
			self.county_name										:=	ut.CleanSpacesAndUpper(pInput.county_name);
			self.apna_or_pin_number							:=	ut.CleanSpacesAndUpper(pInput.apna_or_pin_number);
			self.duplicate_apn_multiple_address_id	:=	ut.CleanSpacesAndUpper(pInput.duplicate_apn_multiple_address_id);
			self.assessee_ownership_rights_code	:=	if(	ut.CleanSpacesAndUpper(pInput.assessee_vesting_id_code)	in	LN_Propertyv2.Constants.Lookups.Rights,
																									ut.CleanSpacesAndUpper(pInput.assessee_vesting_id_code),
																									''
																								);
			self.assessee_relationship_code			:=	if(	ut.CleanSpacesAndUpper(pInput.assessee_vesting_id_code)	in	LN_Propertyv2.Constants.Lookups.Relationships,
																									ut.CleanSpacesAndUpper(pInput.assessee_vesting_id_code),
																									''
																								);
			self.assessee_name_type_code				:=	pInput.assessee_name_type;
			self.second_assessee_name_type_code	:=	pInput.second_assessee_name_type;
			self.mail_care_of_name_type_code		:=	pInput.mail_care_of_name_type;
			self.mailing_full_street_address		:=	if(	pInput.mailing_full_street_address	!=	'',
																									ln_propertyv2_fast.fn_clean_address(pInput.mailing_full_street_address),
																									ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(vMailingStreetAddr	+	' '	+	vMailingUnitNumber))
																								);
			self.mailing_city_state_zip					:=	if(	pInput.mailing_city_state_zip	!=	'',
																									ln_propertyv2_fast.fn_clean_address(pInput.mailing_city_state_zip),
																									ln_propertyv2_fast.fn_clean_address(Address.Addr2FromComponentsWithZip4(
																																												pInput.mailing_city_name,
																																												pInput.mailing_state,
																																												pInput.mailing_zip_code,
																																												pInput.mailing_zip_4
																																											))
																								);
			self.property_full_street_address		:=	if(	pInput.property_full_street_address	!=	'',
																									ln_propertyv2_fast.fn_clean_address(pInput.property_full_street_address),
																									ln_propertyv2_fast.fn_clean_address(ut.CleanSpacesAndUpper(vPropertyStreetAddr	+	' '	+	vPropertyUnitNumber))
																								);
			self.property_city_state_zip				:=	ln_propertyv2_fast.fn_clean_address(Address.Addr2FromComponentsWithZip4(	
																																										pInput.property_city_name,
																																										pInput.property_state,
																																										pInput.property_zip_code,
																																										pInput.property_zip_4
																																									));
			self.property_address_code					:=	pInput.property_address_source_flag;
			self.record_type_code								:=	pInput.record_type;
			self.new_record_type_code						:=	pInput.new_record_type;
			self.recording_date									:=	case(	length(ut.CleanSpacesAndUpper(pInput.recording_date)),
																										8	=>	pInput.recording_date[5..8]	+	pInput.recording_date[1..4],
																										6	=>	pInput.recording_date[3..6]	+	pInput.recording_date[1..2],
																										pInput.recording_date
																									);
			self.prior_recording_date						:=	case(	length(ut.CleanSpacesAndUpper(pInput.prior_recording_date)),
																										8	=>	pInput.prior_recording_date[5..8]	+	pInput.prior_recording_date[1..4],
																										6	=>	pInput.prior_recording_date[3..6]	+	pInput.prior_recording_date[1..2],
																										pInput.prior_recording_date
																									);
			self.prior_sales_price_code					:=	pInput.prior_sales_code;
			self.assessed_total_value						:=	pInput.total_assessed_value;
			self.assessed_value_year						:=	pInput.assessment_year;
			self.homestead_homeowner_exemption	:=	pInput.california_homeowner_exemption;
			self.land_acres											:=	if(	stringlib.stringfind(ut.CleanSpacesAndUpper(pInput.lot_size_or_area),'AC',1)	!=	0,
																									pInput.lot_size_or_area,
																									''
																								);
			self.land_square_footage						:=	if(	stringlib.stringfind(ut.CleanSpacesAndUpper(pInput.lot_size_or_area),'SF',1)	!=	0,
																									pInput.lot_size_or_area,
																									''
																								);
			self.land_dimensions								:=	if(	stringlib.stringfind(ut.CleanSpacesAndUpper(pInput.lot_size_or_area),'AC',1)	!=	0	and	stringlib.stringfind(ut.CleanSpacesAndUpper(pInput.lot_size_or_area),'SF',1)	!=	0,
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
			self.fireplace_indicator						:=	if(	ut.CleanSpacesAndUpper(pInput.fireplace)	=	'Y'	or	regexfind('^[0-9]+$',ut.CleanSpacesAndUpper(pInput.fireplace)),
																									'Y',
																									''
																								);
			self.fireplace_number								:=	if(	ut.CleanSpacesAndUpper(pInput.fireplace)	=	'Y'	or	pInput.fireplace	=	'',
																									'',
																									pInput.fireplace
																								);
			self.basement_code									:=	pInput.basement;
			self.building_class_code						:=	pInput.building_class;
			self.site_influence1_code						:=	pInput.site_influence1;
			self.site_influence2_code						:=	pInput.site_influence2;
			self.tape_cut_date									:=	if(	length(ut.CleanSpacesAndUpper(pInput.tape_cut_date))	=	6,
																									pInput.tape_cut_date[3..6]	+	pInput.tape_cut_date[1..2],
																									pInput.tape_cut_date
																								);
			self.certification_date							:=	case(	length(ut.CleanSpacesAndUpper(pInput.certification_date)),
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
			self.Append_PrepMailingAddr1				:=	ut.CleanSpacesAndUpper(self.mailing_full_street_address);
			self.Append_PrepMailingAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																														ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.mailing_city_state_zip)),
																														''
																													);
			self.Append_PrepPropertyAddr1				:=	ut.CleanSpacesAndUpper(self.property_full_street_address);
			self.Append_PrepPropertyAddr2				:=	regexreplace(	'([0]{5}|[,])$',
																														ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(self.property_city_state_zip)),
																														''
																													);
			
			self																:=	pInput;
			self																:=	[];
		end;
	
		dAsses2Common	:=	project(dAssesPrepName,tMap2Common(left,counter)) : independent;
		
		// Populate fipscode
		common.layout_pre_temp_assessment tJoinFips(common.layout_pre_temp_assessment L,
																												recordof(Census_Data.File_Fips2County) R)  := TRANSFORM
			self.fips_code			:=	IF(trim(L.fips_code, left, right) = '', R.state_fips	+	R.county_fips, L.fips_code); //DF-22234 only replace fips_code by census data value if it's not provided by the vendor
			self								:=	L;
		END;
		
		dFipsCode	:= join(dAsses2Common, Census_Data.File_Fips2County,
															ut.CleanSpacesAndUpper(left.state_code)	=	ut.CleanSpacesAndUpper(right.state_code)	and
															ut.CleanSpacesAndUpper(left.county_name)	=	ut.CleanSpacesAndUpper(right.county_name),
															tJoinFips(left,right), left outer, lookup);
		
		// Add Country Code & Clean Addresses	
		LN_PropertyV2_Fast.MAC_CtryCodeOwnAssess(dFipsCode, dAssessCommon);
		
		EXPORT dAssesFipscode	:= dAssessCommon : independent;
		
		EXPORT dAssesFipscodeDist	:=	distribute(dAssesFipscode,hash32(state_code,county_name,apna_or_pin_number));
		
		// Reformat to bring to base file layouts
		LN_PropertyV2_Fast.Layout_prep_assessment tReformatToCommon(dAssesFipscode L)  := TRANSFORM
				SELF.update_type	:= '';
				SELF							:= L;
		END;
		
		EXPORT dNew			:=	project(dAssesFipscode,tReformatToCommon(LEFT));
		
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Additional Names
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlNames 	:= MODULE
		// Addl name clean
		LN_Propertyv2.Layout_Prep.In.AddlName	tCleanAddlName(LN_Propertyv2.Layout_Prep.In.AddlName	pInput)	:= TRANSFORM
			self.state_code													:=	ut.CleanSpacesAndUpper(pInput.state_code);
			self.county_name												:=	ut.CleanSpacesAndUpper(pInput.county_name);
			self.apna_or_pin_number									:=	ut.CleanSpacesAndUpper(pInput.apna_or_pin_number);
			self.duplicate_apn_multiple_address_id	:=	ut.CleanSpacesAndUpper(pInput.duplicate_apn_multiple_address_id);
			// below 2 lines to address Jira DF-14876
			self.addl_owner_name_8									:=	regexreplace('0',pInput.addl_owner_name_8,' ');
			self.addl_owner_name_17									:=	pInput.addl_owner_name_17[1..14];
			// ** end DF-14876 **
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
		dAddlNameClean	:=	project(PrepDataSet.reformatted.dAddlNameRef,tCleanAddlName(left));
		dAddlNameCleanDist	:=	distribute(dAddlNameClean	,hash32(state_code,county_name,apna_or_pin_number));
		// Populate fares id for addl name records
		LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	tAddlNameFaresID(common.layout_pre_temp_assessment	le,LN_PropertyV2.Layout_Prep.In.AddlName	ri)	:=
		TRANSFORM

			string	vDateSeen			:=	map(	length(ut.CleanSpacesAndUpper(le.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(le.recording_date)) and le.recording_date[1..2] in ['17','18','19','20']	=>	ut.CleanSpacesAndUpper(le.recording_date)[1..6],

																			length(ut.CleanSpacesAndUpper(le.recording_date))	in	[6,8]	and le.recording_date[1..2] not in ['17','18','19','20']
																						and le.recording_date[1..2] in ['01','02','03','04','05','06','07','08','09','10','11','12'] =>	le.recording_date[5..8] + le.recording_date[1..2],
																			length(ut.CleanSpacesAndUpper(le.recording_date))	in	[6,8]	and	 regexfind('^[00]+$',ut.CleanSpacesAndUpper(le.recording_date))	=> le.recording_date[5..8] + '00',	
																			length(ut.CleanSpacesAndUpper(le.sale_date))				in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(le.sale_date))and le.sale_date[1..2] in ['17','18','19','20']			=>	ut.CleanSpacesAndUpper(le.sale_date)[1..6],
																			regexreplace('^[0]*$',StringLib.StringFindReplace(StringLib.StringRepad(ut.CleanSpacesAndUpper(le.tax_year),6),' ','0'),'')
																		);

			self.ln_fares_id			:=	le.ln_fares_id;
			self.dt_first_seen		:=	vDateSeen;
			self.dt_last_seen			:=	vDateSeen;
			self									:=	le;
			self									:=	ri;
		end;
	
		EXPORT dAddlNameFaresID	:=	join(	assessment.dAssesFipscodeDist,
																dAddlNameCleanDist,
																left.Append_ReplRecordInd								=	right.replacement_record_ind	and
																left.state_code													=	right.state_code							and
																left.county_name												=	right.county_name							and
																left.apna_or_pin_number									=	right.apna_or_pin_number			and
																left.duplicate_apn_multiple_address_id	=	right.duplicate_apn_multiple_address_id,
																tAddlNameFaresID(left,right),
																local
															);
		// Normalize names in addl name file to create base file
		LN_PropertyV2.Layout_Prep.Temp.AddlName	tNormalizeAddlName(LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	pInput,integer	cnt)	:=
		TRANSFORM
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
		
		SHARED dAddlNamePrep	:=	normalize(dAddlNameFaresID,23,tNormalizeAddlName(left,counter));
		// Reformat to bring to base file layouts
		
		EXPORT dNew			:=	project(dAddlNamePrep(name	!=	''),LN_PropertyV2_Fast.Layout_prep_addl_names);
		
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Additional Legal
	// ---------------------------------------------------------------------------------------------------------
	EXPORT addlLegal 	:= MODULE
		// Addl legal clean
		LN_Propertyv2.Layout_Prep.In.AddlLegal	tCleanAddlLegal(LN_Propertyv2.Layout_Prep.In.AddlLegal	pInput)	:=
		transform
			self.state_code													:=	ut.CleanSpacesAndUpper(pInput.state_code);
			self.county_name												:=	ut.CleanSpacesAndUpper(pInput.county_name);
			self.apna_or_pin_number									:=	ut.CleanSpacesAndUpper(pInput.apna_or_pin_number);
			self.duplicate_apn_multiple_address_id	:=	ut.CleanSpacesAndUpper(pInput.duplicate_apn_multiple_address_id);
			self																		:=	pInput;
		end;
		dAddlLegalClean	:=	project(PrepDataSet.reformatted.dAddlLegalRef,tCleanAddlLegal(left));
		dAddlLegalCleanDist	:=	distribute(dAddlLegalClean,hash32(state_code,county_name,apna_or_pin_number));
		// Populate fares id for addl legal records
		LN_PropertyV2.Layout_Prep.Temp.AddlLegal	tAddlLegalFaresID(common.layout_pre_temp_assessment	le,LN_PropertyV2.Layout_Prep.In.AddlLegal	ri)	:=
		transform
			self.addl_legal	:=	ri.legal_description;
			self						:=	le;
		end;
	
		SHARED dAddlLegalPrep	:=	join(	assessment.dAssesFipscodeDist,
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
		EXPORT dNew			:=	project(dAddlLegalPrep,LN_PropertyV2_Fast.Layout_prep_addl_legal);
		
	END;
	// ---------------------------------------------------------------------------------------------------------
	// Search
	// ---------------------------------------------------------------------------------------------------------
	EXPORT search 		:= MODULE	
		// --------- BUILD SEARCH FROM ASSESSMENT
		// Normalize the assessment file by name to create an intial assessment search file
		LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tAssesNormName(common.layout_pre_temp_assessment	pInput,integer	cnt)	:=
		TRANSFORM
			string	vDateSeen										:=	map(length(ut.CleanSpacesAndUpper(pInput.recording_date))	in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(pInput.recording_date))	=>	ut.CleanSpacesAndUpper(pInput.recording_date)[1..6],
																									length(ut.CleanSpacesAndUpper(pInput.recording_date))	in	[6,8]	and pInput.recording_date[1..2] not in ['17','18','19','20']
																												and pInput.recording_date[1..2] in ['01','02','03','04','05','06','07','08','09','10','11','12'] =>	pInput.recording_date[5..8] + pInput.recording_date[1..2],
																									length(ut.CleanSpacesAndUpper(pInput.recording_date))	in	[6,8]	and	 regexfind('^[0]+$',ut.CleanSpacesAndUpper(pInput.recording_date))	=> pInput.recording_date[5..8] + '00',	
																									length(ut.CleanSpacesAndUpper(pInput.sale_date))				in	[6,8]	and	~regexfind('^[0]+$',ut.CleanSpacesAndUpper(pInput.sale_date))and pInput.sale_date[1..2] in ['17','18','19','20']			=>	ut.CleanSpacesAndUpper(pInput.sale_date)[1..6],
																									regexreplace('^[0]*$',StringLib.StringFindReplace(StringLib.StringRepad(ut.CleanSpacesAndUpper(pInput.tax_year),6),' ','0'),'')
																									);
				
			self.dt_first_seen									:=	(unsigned3)vDateSeen;
			self.dt_last_seen										:=	(unsigned3)vDateSeen;
			self.dt_vendor_first_reported				:=	(unsigned3)pVersionDate[1..6];
			self.dt_vendor_last_reported				:=	(unsigned3)pVersionDate[1..6];
			self.process_date										:=	pVersionDate;
			self.nameasis												:=	choose(cnt,pInput.assessee_name,pInput.second_assessee_name,pInput.mailing_care_of_name);
			self.which_orig											:=	choose(cnt,'1','2','1');
			self.source_code										:=	choose(cnt,'O','O','C');
			self.ln_buyer_mailing_country_code	:=  pInput.ln_mailing_country_code;
			self																:=	pInput;
			self																:=	[];
		end;
		
		dAssesNormName	:=	normalize(assessment.dAssesFipscode,3,tAssesNormName(left,counter));
		
		// Normalize the assessment search file by address
		LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tAssesNormAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp	pInput,integer	cnt)	:=
		TRANSFORM
			self.Append_PrepAddr1								:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2								:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 	:=  choose(cnt, pInput.ln_buyer_mailing_country_code, '');
			self.source_code										:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'O','P');
			self																:=	pInput;
		end;
	
		dAssesNormAddr	:=	normalize(dAssesNormName(nameasis	!=	''),2,tAssesNormAddr(left,counter));
		dAssesSearch	:=	dAssesNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		// --------- BUILD SEARCH FROM ASSESSMENT ADDL NAMES SPLIT
		// Normalize addl name file by name
		LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameSearch(LN_PropertyV2.Layout_Prep.Temp.AddlNameTemp	pInput,integer	cnt)	:=
		TRANSFORM
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
		dAddlNameNormName	:=	normalize(addlNames.dAddlNameFaresID,23,tNormalizeAddlNameSearch(left,counter));
	 	// Normalize addl name search file by address
		LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tNormalizeAddlNameAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp pInput,integer	cnt)	:=
		TRANSFORM
			self.Append_PrepAddr1								:=	choose(cnt,pInput.Append_PrepMailingAddr1,pInput.Append_PrepPropertyAddr1);
			self.Append_PrepAddr2								:=	choose(cnt,pInput.Append_PrepMailingAddr2,pInput.Append_PrepPropertyAddr2);
			self.ln_buyer_mailing_country_code 	:=  choose(cnt, pInput.ln_buyer_mailing_country_code, '');
			self.source_code										:=	ut.CleanSpacesAndUpper(pInput.source_code)	+	choose(cnt,'O','P');
			self																:=	pInput;
		end;
		dAddlNameNormAddr	:=	normalize(dAddlNameNormName(nameasis	!=	''),2,tNormalizeAddlNameAddr(left,counter));
		dAddlNameSearch	:=	dAddlNameNormAddr(Append_PrepAddr1	!=	''	or	Append_PrepAddr2	!=	'');
		
		// --------- COMBINE ASSESSMENT AND ADDL NAME SEARCHES
		// Combine all the search files (normalized files from addl names and assessment)
		dSearchCombined	:=	dAddlNameSearch	+	dAssesSearch;
		// Clean name and addresses in the search file
		LN_PropertyV2.Layout_Prep.Temp.SearchTemp	tSearchPrepAddr(LN_PropertyV2.Layout_Prep.Temp.SearchTemp	pInput)	:=
		TRANSFORM
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
		
		dom_buyer 						:= not_prop_addr(ln_buyer_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);
		domestic_buyer_filter := prop_addr + dom_buyer;		
		
	//clean and normalize cleaned names
		nid.mac_cleanfullnames(domestic_buyer_filter, dSearchCleanName, nameasis, nid, ln_entity_type, title, fname, mname, lname, name_suffix,,,,,,,,,,true, c_name, true);
		
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
		
		dNormSearchName := dedup(sort(normalize(dSearchCleanName,2,tNormSearchCleanNames(LEFT,counter)),
																	record,local),record, EXCEPT conjunctive_name_seq,local);
/*	
	//Prep Files for Name Cleaner////////////////////////////////////////////////////////////////
		tempLayout := record
			dSearchPrepAddr;
			string1 nt;
			string180 c_name;
		end;
	
		tempLayout addCN(dSearchPrepAddr l):= transform
			self.nt 		:= '';
			self.c_name := '';	
			self 				:= l;
		end;

		fixTrunc := project(dSearchPrepAddr, addCN(left));
		
		////////////////////////////////////////////////////////////////////////////////////////////
		//Re-Clean Names Using NID Cleaner
		////////////////////////////////////////////////////////////////////////////////////////////
		nid.mac_cleanfullnames(fixTrunc, dSearchCleanName, nameasis, nid, nt, title, fname, mname, lname, name_suffix, , , , , , , , , , true, c_name);
		sort_nid := dSearchCleanName;//sort(dSearchCleanName, record, local);
	
		LN_PropertyV2.Layout_Did_Out tNormSearchCleanNames(sort_nid L, integer C) := TRANSFORM
			SELF.title 					:= choose(c, if(L.nt not in ['B','T'], L.title, ''), 
																					if(L.nt not in ['B','T'] and L.cln_title2<>'', L.cln_title2, 
																					if(L.nt not in ['B','T'] and L.cln_title2='', L.title, '')));
			SELF.fname 					:= choose(c, if(L.nt not in ['B','T'], L.fname, ''), 
																					if(L.nt not in ['B','T'] and L.cln_fname2<>'', L.cln_fname2, 
																					if(L.nt not in ['B','T'] and L.cln_fname2='', L.fname, '')));
			SELF.mname 					:= choose(c, if(L.nt not in ['B','T'], L.mname, ''), 
																					if(L.nt not in ['B','T'] and (L.cln_mname2<>'' or L.cln_lname2<>''), L.cln_mname2, 
																					if(L.nt not in ['B','T'] and L.cln_mname2='' and L.cln_lname2='', L.mname, '')));
			SELF.lname 					:= choose(c, if(L.nt not in ['B','T'], L.lname, ''), 
																					if(L.nt not in ['B','T'] and L.cln_lname2<>'', L.cln_lname2, 
																					if(L.nt not in ['B','T'] and L.cln_lname2='', L.lname, '')));
			SELF.name_suffix  	:= choose(c, if(L.nt not in ['B','T'], L.name_suffix, ''), 
																					if(L.nt not in ['B','T'] and (L.cln_suffix2<>'' or L.cln_lname2<>''), L.cln_suffix2, 
																					if(L.nt not in ['B','T'] and L.cln_suffix2='' and L.cln_lname2='', L.name_suffix, '')));
			
			vStandardizeName  				:= LN_PropertyV2.Prep_Name.fnStandardizeName(L.nameasis);	
			SELF.cname 								:= if(L.nt in ['B','T'] and l.c_name<>'', l.c_name, 
																			if(L.nt in ['B','T'] and l.c_name='', LN_PropertyV2.Prep_Name.fnClean2Upper(vStandardizeName), 
																			''));
			SELF.ln_entity_type 			:= l.nt;	
			SELF.conjunctive_name_seq := (string)c; // dedup will throw out duplicates for no second names
			SELF	   := L;
			self 	   := [];
		END;
		
		dAssessNormSearchName := dedup(sort(normalize(sort_nid,2,tNormSearchCleanNames(LEFT,counter)),
															record,local),record, EXCEPT conjunctive_name_seq,local);*/
		
		LN_Propertyv2.Append_AID(dNormSearchName,dSearchCleanAddr,false);
		dSearchAID	:=	dSearchCleanAddr; 

		EXPORT dNew	:=	project(dSearchAID, LN_PropertyV2_Fast.Layout_prep_search_prp);
		
	END;
END;
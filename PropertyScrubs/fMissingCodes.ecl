import LN_PropertyV2,codes;
EXPORT fMissingCodes (dataset(recordof(ln_propertyV2.layouts.layout_property_common_model_base_scrubs )) AssessorLatestRaw) := function

export prep  := record

			ln_propertyV2.layouts.layout_property_common_model_base_scrubs;
			string200 field_name; 
			string source_code;
			string raw_code; 
end; 

prep tNormalizeCodes(AssessorLatestRaw	pInput,integer	cnt)	:=
	transform
		self.field_name		:=	choose(	cnt,
		                              'LAND_USE',
																	'OWNER_OWNERSHIP_RIGHTS_CODE',
																	'OWNER_RELATIONSHIP_CODE',
																	'ASSESSEE_NAME_TYPE_CODE',
																	'SECOND_ASSESSEE_NAME_TYPE_CODE',
																	'MAIL_CARE_OF_NAME_TYPE_CODE',
																	'RECORD_TYPE_CODE',
																	'LEGAL_LOT_CODE',
																	'OWNERSHIP_TYPE_CODE',
																	'NEW_RECORD_TYPE_CODE',
																	'SALE_CODE',
																	'PRIOR_SALES_PRICE_CODE',
																	'MORTGAGE_LOAN_TYPE_CODE',
																	'MORTGAGE_LENDER_TYPE_CODE',
																	'TAX_EXEMPTION1_CODE',
																	'TAX_EXEMPTION2_CODE',
																	'TAX_EXEMPTION3_CODE',
																	'TAX_EXEMPTION4_CODE',
																	'STORIES_CODE',
																	'GARAGE',
																	'POOL_CODE',
																	'EXTERIOR_WALLS',
																	'ROOF_TYPE',
																	'HEATING',
																	'FUEL',
																	'AIR_CONDITIONING_TYPE_CODE',
																	'BUILDING_CLASS_CODE',
																	'LOCATION_INFLUENCE',
																	'AMENITIES1_CODE',
																	'AMENITIES2_CODE',
																	'AMENITIES3_CODE',
																	'AMENITIES4_CODE',
																	'BLDG_IMPV_CODE',
																	'FIREPLACE_INDICATOR',
																	'PROPERTY_ADDRESS_CODE',
																	'FLOOR_COVER',
																	'QUALITY'

																	);
		tvendor_source	:=	if(pInput.vendor_source_flag	in	['F','S'],'FARES','OKCTY');
		self.source_code	:=	if(tvendor_source	=	'FARES','FAR_F',tvendor_source);
		self.raw_code			:=	choose(	cnt,
		                              pInput.standardized_land_use_code,
																	pInput.assessee_ownership_rights_code,
																	pInput.assessee_relationship_code,
																	pInput.assessee_name_type_code,
																	pInput.second_assessee_name_type_code,
																	pInput.mail_care_of_name_type_code,
																	pInput.record_type_code,
																	pInput.legal_lot_code,
																	pInput.ownership_type_code,
																	pInput.new_record_type_code,
																	pInput.sales_price_code,
																	pInput.prior_sales_price_code,
																	pInput.mortgage_loan_type_code,
																	pInput.mortgage_lender_type_code,
																	pInput.tax_exemption1_code,
																	pInput.tax_exemption2_code,
																	pInput.tax_exemption3_code,
																	pInput.tax_exemption4_code,
																	pInput.no_of_stories,
																	pInput.garage_type_code,
																	pInput.pool_code,
																	pInput.exterior_walls_code,
																	pInput.roof_type_code,
																	pInput.heating_code,
																	pInput.heating_fuel_type_code,
																	pInput.air_conditioning_type_code,
																	pInput.building_class_code,
																	pInput.site_influence1_code,
																	pInput.amenities1_code,
																	pInput.amenities2_code,
																	pInput.amenities3_code,
																	pInput.amenities4_code,
																	pInput.other_buildings1_code,
																	pInput.fireplace_indicator,
																	pInput.property_address_code,
																	pInput.floor_cover_code,
																	pInput.building_quality_code
																	
																);
		self							:=	[];
	end;

	dPropertyRawCodes	:=	normalize(	AssessorLatestRaw,
																		37,
																		tNormalizeCodes(left,counter)
																	);

	prep	tGetCommonCode(dPropertyRawCodes	le,codes.File_Codes_V3_In	ri)	:=
	transform
		self	:=	le;
	end;

	// Do a left only join to get the list of codes which don't have a common code
	dPropNoCommonCode	:=	join(	dPropertyRawCodes(raw_code<>''),
															Codes.File_Codes_V3_In(file_name	in	['FARES_2580','FARES_1080']),
															stringlib.stringcleanspaces(left.field_name)	=	stringlib.stringcleanspaces(right.field_name)		and
															stringlib.stringcleanspaces(left.source_code)	=	stringlib.stringcleanspaces(right.field_name2)	and
															stringlib.stringcleanspaces(left.raw_code)		=	stringlib.stringcleanspaces(right.code),
															tGetCommonCode(left,right),
															left only,
															lookup
														);

  rMissingCodesCounts := record
   dPropNoCommonCode.field_name;
	 dPropNoCommonCode.source_code;
	 dPropNoCommonCode.raw_code;
	 count_ := count(group);
	end;
	
	tMissingCodes := sort(table(dPropNoCommonCode,rMissingCodesCounts,field_name,source_code,raw_code,few),field_name,-count_) ;//:persist('tax_missing_codes');

Return 	tMissingCodes;
 
end ; 

import	codes;

export	Missing_Common_Codes(string	pVersion)	:=
function
	// Normalize the file to contain only the raw vendor codes
	PropertyCharacteristics.Layout_Codes.LNPropertyMissingCodes	tNormalizeCodes(PropertyCharacteristics.Layouts.Common	pInput,integer	cnt)	:=
	transform
		self.field_name		:=	choose(	cnt,
																	'AIR_CONDITIONING',
																	'BASEMENT_FINISH',
																	'CONSTRUCTION_TYPE',
																	'EXTERIOR_WALLS',
																	'FIREPLACE_TYPE',
																	'FLOOR_COVER',
																	'FOUNDATION',
																	'FUEL',
																	'GARAGE',
																	'HEATING',
																	'PARKING_TYPE',
																	'POOL_CODE',
																	'ROOF_COVER',
																	'SEWER',
																	'STYLE',
																	'WATER',
																	'STORIES_CODE',
																	'FRAME',
																	'STANDARDIZED_LAND_USE_CODE',
																	'LOCATION_INFLUENCE',
																	'PROPERTY_IND',
																	'QUALITY',
																	'TYPE_FINANCING',
																	'MORTGAGE_LOAN_TYPE_CODE',
																	'TRANSACTION_TYPE',//IMO it's a bug that this lookup was re-named to SALE_TRANS_CODE in the Prop Char lookup
																	                  //Giving it this name here creates a match with the Property lookup file (...it's also the field name in the data)
																	'ROOF_TYPE'
																	);
		self.source_code	:=	if(pInput.vendor_source	=	'FARES','FAR_F',pInput.vendor_source);
		self.raw_code			:=	choose(	cnt,
																	pInput.air_conditioning_type,
																	pInput.basement_finish,
																	pInput.construction_type,
																	pInput.exterior_wall,
																	pInput.fireplace_type,
																	pInput.floor_type,
																	pInput.foundation,
																	pInput.fuel_type,
																	pInput.garage,
																	pInput.heating,
																	pInput.parking_type,
																	pInput.pool_type,
																	pInput.roof_cover,
																	pInput.sewer,
																	pInput.style_type,
																	pInput.water,
																	pInput.stories_type,
																	pInput.frame_type,
																	pInput.land_use_code,
																	pInput.location_influence_code,
																	pInput.property_type_code,
																	pInput.structure_quality,
																	pInput.interest_rate_type_code,
																	pInput.loan_type_code,
																	pInput.sale_type_code,
																	pInput.roof_type
																);
		self							:=	[];
	end;

	dPropertyRawCodes	:=	normalize(	PropertyCharacteristics.Map_LNProperty_Common,
																		25,
																		tNormalizeCodes(left,counter)
																	);

	PropertyCharacteristics.Layout_Codes.LNPropertyMissingCodes	tGetCommonCode(dPropertyRawCodes	le,codes.File_Codes_V3_In	ri)	:=
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
	 dPropNoCommonCode.common_code;
	 count_ := count(group);
	end;
	
	tMissingCodesCounts := sort(table(dPropNoCommonCode,rMissingCodesCounts,field_name,source_code,raw_code,common_code,few),-count_);

	outPropNoCommonCode	:=	if(	exists(tMissingCodesCounts),
															sequential(	output(choosen(tMissingCodesCounts(count_>50),500),named('LNProperty_Missing_Common_Codes')),
																					fileservices.sendemail('terri.hardy-george@lexisnexis.com','LN Property Missing Codes','Build '	+	pVersion	+	' has missing Fares or Fidelity codes. They are located in workunit '	+	thorlib.wuid())
																				),
															output('No new common codes needs to be added')
														);

	return	outPropNoCommonCode;
end;
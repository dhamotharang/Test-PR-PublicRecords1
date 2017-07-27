import	codes;

export Files	:=
module
	
	// dataset definition for the data codes
	export	Codes	:=
	module
		
		export	Raw2Standardized					:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'in::propertyinfo::standardized_codes',
																										PropertyCharacteristics.Layout_Codes.Raw2Standardized,
																										thor
																									);

		export	DataFeatureCodes					:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'in::propertyinfo::feature_codes',
																										PropertyCharacteristics.layout_Codes.DataFeatureCodes,
																										csv(heading(1),terminator('\t'),separator(','),maxlength(4096),quote('"'))
																									);

		export	DataFeatureValues					:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'in::propertyinfo::feature_code_values',
																										PropertyCharacteristics.layout_Codes.DataFeatureValues,
																										csv(heading(1),terminator('\t'),separator(','),maxlength(4096),quote('"'))
																									);

		export	VisientDataFeatureCodes		:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'in::propertyinfo::visient_feature_codes',
																										PropertyCharacteristics.layout_Codes.DataFeatureCodes,
																										csv(heading(1),terminator('\t'),separator(','),maxlength(4096),quote('"'))
																									);

		export	VisientDataFeatureValues	:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'in::propertyinfo::visient_feature_code_values',
																										PropertyCharacteristics.layout_Codes.DataFeatureValues,
																										csv(heading(1),terminator('\t'),separator(','),maxlength(4096),quote('"'))
																									);

		export	MLS2IBCodeLookup					:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'lookup::propertyinfo::mls2ib',
																										PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup,
																										thor
																									);

		export	MLS2CommonCodeLookup			:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'lookup::propertyinfo::mls2common',
																										PropertyCharacteristics.Layout_Codes.MLS2Common,
																										csv(heading(1),separator('\t'),terminator('\r\n'))
																									);

		
		export	CensusDefaultDataLookup		:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'lookup::propertyinfo::census_default',
																										PropertyCharacteristics.Layout_Codes.CensusDefault2Common,
																										thor
																									);

		export	ZipCodeDefaultDataLookup	:=	dataset(	PropertyCharacteristics.Constants.cluster	+	'lookup::propertyinfo::zip_default',
																										PropertyCharacteristics.Layout_Codes.ZipDefault2Common,
																										thor
																									);
		
		export	CodesV3										:=	Codes.File_Codes_V3_In(file_name	=	'PROPERTYINFO')	:	global;
	end;
	
	// dataset definition for property information base file
	export	Base	:=
	module
	export	Property	:=	dataset('~thor_data400::base::propertyinfo',PropertyCharacteristics.Layouts.Base,thor);
	
	end;

end;
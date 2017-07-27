import	codes,ut;

export	Proc_Build_Lookups	:=
module

	shared	dCodes	:=	PropertyCharacteristics.Files.Codes.CodesV3;
	
	// Combine the visient and mls feature codes and create a lookup table containing the IB codes
	// Restrict codes to only MLS
	dDataFeatureCodes		:=	PropertyCharacteristics.Files.Codes.DataFeatureCodes(data_source_id	in	['2','4']	and	trade_id	!=	'');
	dDataFeatureValues	:=	PropertyCharacteristics.Files.Codes.DataFeatureValues;

	// Build a common lookup for the insurbase codes
	PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup	tIBCodes(	PropertyCharacteristics.Layout_Codes.DataFeatureCodes	le,
																														PropertyCharacteristics.Layout_Codes.DataFeatureValues	ri
																													)	:=
	transform
		self.data_source_id	:=	(integer)le.data_source_id;
		self.trade_id				:=	(integer)le.trade_id;
		self.material_code	:=	ri.material_code;
		self.value					:=	ri.value;
		self.dynamic_value	:=	ri.dynamic_value;
		self								:=	le;
		self								:=	[];
	end;

	dCodeLookup	:=	join(	dDataFeatureCodes,
												dDataFeatureValues,
												left.feature_id	=	right.feature_id,
												tIBCodes(left,right),
												many lookup
											);

	dVisientDataFeatureCodes	:=	PropertyCharacteristics.Files.Codes.VisientDataFeatureCodes(data_source_id	=	'9'	and	trade_id	!=	'');
	dVisientDataFeatureValues	:=	PropertyCharacteristics.Files.Codes.VisientDataFeatureValues;

	dVisientCodeLookup	:=	join(	dVisientDataFeatureCodes,
																dVisientDataFeatureValues,
																left.feature_id	=	right.feature_id,
																tIBCodes(left,right),
																many lookup
															);

	dMLS2IBCodeLookup	:=	dCodeLookup	+	dVisientCodeLookup;

	// Populate insurbase category code
	PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup	tCategoryCodes(dMLS2IBCodeLookup	le,dCodes	ri)	:=
	transform
		self.category_code	:=	ri.long_desc;
		self								:=	le;
	end;

	dCategoryCodeLookup	:=	join(	dCodeLookup,
																dCodes,
																right.field_name2	=	'PINFO'							and
																right.field_name	=	'TRADE2CATEGORY'		and
																left.trade_id			=	(integer)right.code,
																tCategoryCodes(left,right),
																left outer,
																lookup
															);

	// Performance improvement
	// Create a lookup file so that each code/description would exist on every node so as to do a local denormalize (mimic a lookup)
	PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup	tNormalize(dCategoryCodeLookup	pInput,integer	cnt)	:=
	transform
		self.which_node	:=	cnt	-	1;
		self						:=	pInput;
	end;
	
	dNormalize	:=	normalize(	dCategoryCodeLookup,
															400,
															tNormalize(left,counter)
														);
	
	ut.MAC_SF_BuildProcess(dNormalize,'~thor_data400::lookup::propertyinfo::mls2ib',bldIBLookup,2,,true);

	export	MLS2IB_Lookup	:=	bldIBLookup;
	
	// Join to codesV3 file to create the common codes for the IB codes in the default data
	// PropertyCharacteristics.Layout_Codes.CensusDefault2Common	tCensusDefault2Common(PropertyCharacteristics.Files.Raw.CensusDefaults	le,dCodes	ri)	:=
	// transform
		// self.common_code	:=	ri.long_desc;
		// self.trade_id			:=	(integer)le.trade_id;
		// self							:=	le;
	// end;
	
	// dCensusDefault	:=	join(	PropertyCharacteristics.Files.Raw.CensusDefaults,
														// dCodes,
														// right.field_name2				=	'PINFO'						and
														// left.xmlxref						=	right.code[1..3]	and
														// (integer)left.trade_id	=	(integer)right.code[5..],
														// tCensusDefault2Common(left,right),
														// lookup
													// );
	
	// ut.MAC_SF_BuildProcess(dCensusDefault,'~thor_data400::lookup::propertyinfo::census_default',bldCensusLookup,2,,true);
	
	// PropertyCharacteristics.Layout_Codes.ZipDefault2Common	tZipCodeDefault2Common(PropertyCharacteristics.Files.Raw.ZipCodeDefaults	le,dCodes	ri)	:=
	// transform
		// self.common_code	:=	ri.long_desc;
		// self.trade_id			:=	(integer)le.trade_id;
		// self							:=	le;
	// end;
	
	// dZipCodeDefault	:=	join(	PropertyCharacteristics.Files.Raw.ZipCodeDefaults,
														// dCodes,
														// right.field_name2				=	'PINFO'						and
														// left.xmlxref						=	right.code[1..3]	and
														// (integer)left.trade_id	=	(integer)right.code[5..],
														// tZipCodeDefault2Common(left,right),
														// lookup
													// );
	
	// ut.MAC_SF_BuildProcess(dZipCodeDefault,'~thor_data400::lookup::propertyinfo::zip_default',bldZipCodeLookup,2,,true);
	
	// export	DefaultData	:=	parallel(bldCensusLookup,bldZipCodeLookup);

end;
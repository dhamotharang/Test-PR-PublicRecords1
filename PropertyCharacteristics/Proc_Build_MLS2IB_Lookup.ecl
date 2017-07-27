import	codes,ut;

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
// PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup	tCategoryCodes(dMLS2IBCodeLookup	le,Codes.File_Codes_V3_In	ri)	:=
PropertyCharacteristics.Layout_Codes.MLS2IBCodeLookup	tCategoryCodes(dMLS2IBCodeLookup	le,Codes.File_Codes_V3_In	ri)	:=
transform
	self.category_code	:=	ri.long_desc;
	self								:=	le;
end;

dCategoryCodeLookup	:=	join(	dCodeLookup,
															Codes.File_Codes_V3_In,
															right.file_name		=	'PROPERTYINFO'	and
															right.field_name2	=	'PINFO'							and
															right.field_name	=	'TRADE2CATEGORY'		and
															left.trade_id			=	(integer)right.code,
															tCategoryCodes(left,right),
															left outer,
															lookup
														);

ut.MAC_SF_BuildProcess(dCodeLookup,'~thor_data400::lookup::propertyinfo::mls2ib',bldIBLookup,2,,true);

export	Proc_Build_MLS2IB_Lookup	:=	bldIBLookup;
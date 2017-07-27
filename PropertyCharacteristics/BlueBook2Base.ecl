import	AID,Codes,ut;

dBBCombined	:=		PropertyCharacteristics.Map_BlueBook_Common.MLS1_Map2Common
								+	PropertyCharacteristics.Map_BlueBook_Common.MLS2_Map2Common
								+	PropertyCharacteristics.Map_BlueBook_Common.MLS3_Map2Common
								+	PropertyCharacteristics.Map_BlueBook_Common.MLS4_Map2Common
								+	PropertyCharacteristics.Map_BlueBook_Common.Ins1_Map2Common
								+	PropertyCharacteristics.Map_BlueBook_Common.Appr_Map2Common
								;

dBBAddrPopulated	:=	dBBCombined(property_street_address	!=	''	and	property_city_state_zip	!=	'');

// Reformat to temp base file layout
PropertyCharacteristics.Layouts.TempBase	tTempBase(dBBAddrPopulated	pInput)	:=
transform
	self.dt_vendor_first_reported	:=	(unsigned)pInput.process_date;
	self.dt_vendor_last_reported	:=	(unsigned)pInput.process_date;
	self.vendor										:=	pInput.vendor_source;
	self.vendor_source						:=	'A';
	self.data_source							:=	case(	pInput.vendor_source,
																					'MLS1'	=>	2,
																					'MLS2'	=>	4,
																					'MLS3'	=>	9,
																					0
																				);
	self.stories_type_desc				:=	pInput.stories_type;
	self													:=	pInput;
	self													:=	[];
end;

dBBPopulateSource	:=	project(dBBAddrPopulated,tTempBase(left));

// Append sequence number
ut.MAC_Sequence_Records(dBBPopulateSource,property_rid,dBBAppendSeqNum);

dBBAppendSeqNumDist	:=	distribute(dBBAppendSeqNum,property_rid);

// Split the dataset according to sources to populate insurbase codes
dBB		:=	dBBAppendSeqNumDist(vendor[1..3]	!=	'MLS');
dMLS	:=	dBBAppendSeqNumDist(vendor[1..3]	=	'MLS');

// Slim down the layout to keep only fields which have codes
rSlim2CodeFields_layout	:=
record
	dBBAppendSeqNum.property_rid;
	dBBAppendSeqNum.data_source;
	dBBAppendSeqNum.air_conditioning_type;
	dBBAppendSeqNum.air_conditioning_type_desc;
	dBBAppendSeqNum.heating;
	dBBAppendSeqNum.heating_desc;
	dBBAppendSeqNum.fuel_type;
	dBBAppendSeqNum.fuel_type_desc;
	dBBAppendSeqNum.exterior_wall;
	dBBAppendSeqNum.exterior_wall_desc;
	dBBAppendSeqNum.construction_type;
	dBBAppendSeqNum.construction_type_desc;
	dBBAppendSeqNum.floor_type;
	dBBAppendSeqNum.floor_type_desc;
	dBBAppendSeqNum.roof_cover;
	dBBAppendSeqNum.roof_cover_desc;
	dBBAppendSeqNum.foundation;
	dBBAppendSeqNum.foundation_desc;
	dBBAppendSeqNum.fireplace_type;
	dBBAppendSeqNum.fireplace_type_desc;
	dBBAppendSeqNum.parking_type;
	dBBAppendSeqNum.parking_type_desc;
	dBBAppendSeqNum.garage;
	dBBAppendSeqNum.garage_desc;
	dBBAppendSeqNum.basement_finish;
	dBBAppendSeqNum.basement_finish_desc;
	dBBAppendSeqNum.sewer;
	dBBAppendSeqNum.sewer_desc;
	dBBAppendSeqNum.water;
	dBBAppendSeqNum.water_desc;
	dBBAppendSeqNum.land_use_code;
	dBBAppendSeqNum.property_type_code;
	dBBAppendSeqNum.property_type_desc;
	dBBAppendSeqNum.pool_type;
	dBBAppendSeqNum.pool_type_desc;
	dBBAppendSeqNum.stories_type;
	dBBAppendSeqNum.stories_type_desc;
	dBBAppendSeqNum.style_type;
	dBBAppendSeqNum.style_type_desc;
	dBBAppendSeqNum.location_influence_code;
	dBBAppendSeqNum.location_influence_desc;
	dBBAppendSeqNum.living_area_square_footage;
	dBBAppendSeqNum.no_of_stories;
	dBBAppendSeqNum.basement_square_footage;
	dBBAppendSeqNum.no_of_baths;
	dBBAppendSeqNum.no_of_fireplaces;
	dataset(PropertyCharacteristics.Layout_Codes.TradeMaterials)	insurbase_codes;
end;

dBBSlim2CodeFields	:=	project(dBB,rSlim2CodeFields_layout);
dMLSSlim2CodeFields	:=	project(dMLS,rSlim2CodeFields_layout);

// No need to remap insurbase codes for Insurance and appraisal files as they are pulled straight from the vendor files
dBBInsurbaseCode	:=	dBBSlim2CodeFields;

// Populate insurbase codes for MLS data
PropertyCharacteristics.Get_IB_Common_Codes.Mac_Get_IBCode(dMLSSlim2CodeFields,'MLS',dMLSInsurbaseCode);

// Lookup table for IB codes - MLS data
dMLS2IBCodeLookup	:=	sort(	distribute(PropertyCharacteristics.Files.Codes.MLS2IBCodeLookup,which_node),
														PropertyCharacteristics.Functions.clean2Upper(feature_description)[1..100],trade_id,-value,material_code,
														local
													);

// Get IB code for basement, special case since the basement feature description is truncated to 100 bytes
string	vTradeID	:=	PropertyCharacteristics.Files.Codes.CodesV3(	field_name2	=	'BLUBK'	and
																																		field_name	=	'TRADE'	and
																																		long_desc		=	'BASEMENT_FINISH_DESC'
																																	)[1].code;

rSlim2CodeFields_layout	tIBMaterialCode(rSlim2CodeFields_layout	le,dMLS2IBCodeLookup	ri)	:=
transform
	string	vMaterialValue	:=	if(	ri.value	!=	'',
																	ri.value,
																	map(	ri.dynamic_value	=	'Y'	and	ri.trade_id	=	20	and	le.basement_square_footage	!=	''	=>	le.basement_square_footage,
																				ri.dynamic_value	=	'F'	and	ri.trade_id	=	20	and	le.basement_square_footage	!=	''	=>	le.basement_square_footage,
																				ri.dynamic_value	=	'P'	and	ri.trade_id	=	20	and	le.basement_square_footage	!=	''	=>	(string)round((0.5*(integer)le.basement_square_footage)),
																				ri.dynamic_value	=	'Q'	and	ri.trade_id	=	20	and	le.basement_square_footage	!=	''	=>	(string)round((0.25*(integer)le.basement_square_footage)),
																				ri.value
																			)
																);
	
	self.basement_finish	:=	if(le.basement_finish	!=	'',le.basement_finish,ri.material_code);
	self.insurbase_codes	:=	if(	le.basement_finish	!=	'',
																le.insurbase_codes,
																if(	ri.material_code	!=	''	and	vMaterialValue	!=	'',
																		le.insurbase_codes	+	row({ri.category_code,ri.material_code,vMaterialValue,'','',''},PropertyCharacteristics.Layout_Codes.TradeMaterials),
																		le.insurbase_codes
																	)
															);
	self									:=	le;
end;

dMLSBasementIBCode	:=	denormalize(	dMLSInsurbaseCode(basement_finish_desc	!=	''	and	data_source	=	9),
																			dMLS2IBCodeLookup,
																			right.trade_id																																		=	(unsigned)vTradeID		and
																			PropertyCharacteristics.Functions.clean2Upper(left.basement_finish_desc)[1..100]	=	PropertyCharacteristics.Functions.clean2Upper(right.feature_description)[1..100],
																			tIBMaterialCode(left,right),
																			local
																		);

// Combine the two datasets
dBBIBCodeCombined	:=	dBBInsurbaseCode	+	dMLSBasementIBCode	+	dMLSInsurbaseCode(~(basement_finish_desc	!=	''	and	data_source	=	9));

// Get common codes for all the code fields that exist in the property data report
PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_Common_Code(dBBIBCodeCombined,dBBStandardizedCodes);

// Bring back to the original base layout
PropertyCharacteristics.Layouts.TempBase	tReformat2Base(dBBAppendSeqNum	le,dBBStandardizedCodes	ri)	:=
transform
	self.property_rid	:=	le.property_rid;
	self							:=	ri;
	self							:=	le;
end;

dBBReformat2Base	:=	join(	dBBAppendSeqNumDist,
														distribute(dBBStandardizedCodes,property_rid),
														left.property_rid	=	right.property_rid,
														tReformat2Base(left,right),
														local
													);

unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
															AID.Common.eReturnValues.ACECacheRecords;
		
AID.MacAppendFromRaw_2Line(	dBBReformat2Base,
														property_street_address,
														property_city_state_zip,
														property_raw_aid,
														dBlueBookAppendAceAddr,
														lAIDAppendFlags
													);

// Parse the cleaned address and map to base layout
PropertyCharacteristics.Layouts.TempBase	tParseCleanAddr(dBlueBookAppendAceAddr	pInput)	:=
transform
	self.property_raw_aid					:=	pInput.AIDWork_RawAID;
	self.property_ace_aid					:=	pInput.AIDWork_AceCache.AID;
	self.prim_range								:=	pInput.AIDWork_AceCache.prim_range;
	self.predir										:=	pInput.AIDWork_AceCache.predir;
	self.prim_name								:=	pInput.AIDWork_AceCache.prim_name;
	self.addr_suffix							:=	pInput.AIDWork_AceCache.addr_suffix;
	self.postdir									:=	pInput.AIDWork_AceCache.postdir;
	self.unit_desig								:=	pInput.AIDWork_AceCache.unit_desig;
	self.sec_range								:=	pInput.AIDWork_AceCache.sec_range;
	self.p_city_name							:=	pInput.AIDWork_AceCache.p_city_name;
	self.v_city_name							:=	pInput.AIDWork_AceCache.v_city_name;
	self.st												:=	pInput.AIDWork_AceCache.st;
	self.zip											:=	pInput.AIDWork_AceCache.zip5;
	self.zip4											:=	pInput.AIDWork_AceCache.zip4;
	self.cart											:=	pInput.AIDWork_AceCache.cart;
	self.cr_sort_sz								:=	pInput.AIDWork_AceCache.cr_sort_sz;
	self.lot											:=	pInput.AIDWork_AceCache.lot;
	self.lot_order								:=	pInput.AIDWork_AceCache.lot_order;
	self.dbpc											:=	pInput.AIDWork_AceCache.dbpc;
	self.chk_digit								:=	pInput.AIDWork_AceCache.chk_digit;
	self.rec_type									:=	pInput.AIDWork_AceCache.rec_type;
	self.county										:=	pInput.AIDWork_AceCache.county;
	self.geo_lat									:=	pInput.AIDWork_AceCache.geo_lat;
	self.geo_long									:=	pInput.AIDWork_AceCache.geo_long;
	self.msa											:=	pInput.AIDWork_AceCache.msa;
	self.geo_blk									:=	pInput.AIDWork_AceCache.geo_blk;
	self.geo_match								:=	pInput.AIDWork_AceCache.geo_match;
	self.err_stat									:=	pInput.AIDWork_AceCache.err_stat;
	self.latitude									:=	if(pInput.latitude	!=	'',pInput.latitude,pInput.AIDWork_AceCache.geo_lat);
	self.longitude								:=	if(pInput.longitude	!=	'',pInput.longitude,pInput.AIDWork_AceCache.geo_long);
	self 													:=	pInput;
	self													:=	[];
end;

dBBCleanAddr	:=	project(dBlueBookAppendAceAddr,tParseCleanAddr(left));

// Rollup records by property address
PropertyCharacteristics.Mac_Property_Rollup(dBBCleanAddr,dBBRollup,true);

export	BlueBook2Base	:=	dBBRollup	:	persist('~thor_data400::persist::propertybluebook::bluebook2base');
// export	BlueBook2Base	:=	dataset('~thor_data400::persist::propertybluebook::bluebook2base',PropertyCharacteristics.Layouts.TempBase,thor);
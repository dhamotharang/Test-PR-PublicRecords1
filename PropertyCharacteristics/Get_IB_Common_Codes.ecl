import	Codes;

export	Get_IB_Common_Codes	:=
module	
	// Performance improvement
	// Normalize the lookup table 400 times so as to create 400 copies of each record on every node
	rNormalize_layout	:=
	record
		unsigned2	which_node;
		PropertyCharacteristics.Files.Codes.CodesV3;
	end;
	
	rNormalize_layout	tNormalize(PropertyCharacteristics.Files.Codes.CodesV3	pInput,integer	cnt)	:=
	transform
		self.which_node	:=	cnt	-	1;
		self						:=	pInput;
	end;
	
	dCodesV3Normalize	:=	normalize(PropertyCharacteristics.Files.Codes.CodesV3(field_name2	=	'CMNIB'),400,tNormalize(left,counter));
	
	// Distribute on which_node
	export	dCodesV3NormalizedDist	:=	distribute(dCodesV3Normalize,which_node)	:	independent;
	
	// Macro to get the insurbase material codes and values for MLS data
	export	Mac_MLS_IBCode(pInDataset,pField,pFieldDesc,pCodesV3FieldName,pOutDataset)	:=
	macro
		// Get trade id from the field name
		#uniquename(vTradeID)
		%vTradeID%	:=	PropertyCharacteristics.Files.Codes.CodesV3(	field_name2	=	'PINFO'	and
																																	field_name	=	'TRADE'	and
																																	long_desc		=	pCodesV3FieldName
																																)[1].code;
		
		#uniquename(dInFilter)
		%dInFilter%	:=	pInDataset(pFieldDesc	!=	'');
		
		// Sort MLS2IBCodeLookup dataset by value so that the material code with the highest value is used
		#uniquename(dMLS2IBCodeLookup)
		%dMLS2IBCodeLookup%	:=	sort(	distribute(PropertyCharacteristics.Files.Codes.MLS2IBCodeLookup,which_node),
																	feature_description,trade_id,-value,material_code,
																	local
																);

		// Function to get insurbase material code and value
		#uniquename(tIBMaterialCode)
		recordof(pInDataset)	%tIBMaterialCode%(%dInFilter%	le,%dMLS2IBCodeLookup%	ri)	:=
		transform
			real	vMaterialValue		:=	if(	ri.value	!=	'',
																			(real)ri.value,
																			map(	ri.dynamic_value	=	'Y'	and	ri.trade_id	=	17	and	ri.material_code	in	['PAU','PAS','PEU','PES']	and	le.living_area_square_footage	!=	''	=>	map(	(integer)le.living_area_square_footage	<=	1200								=>	200,
																																																																																																	(integer)le.living_area_square_footage	between 1201	and	2400	=>	400,
																																																																																																	(integer)le.living_area_square_footage	>	2400									=>	600,
																																																																																																	(integer)ri.value
																																																																																																),
																						ri.dynamic_value	=	'Y'	and	ri.trade_id	=	20	and	le.basement_square_footage		!=	''																=>	(integer)le.basement_square_footage,
																						ri.dynamic_value	=	'Y'	and	ri.trade_id	=	20	and	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	''	=>	round((integer)le.living_area_square_footage/(real)le.no_of_stories),
																						ri.dynamic_value	=	'F'	and	ri.trade_id	=	20	and	le.basement_square_footage		!=	''																=>	(integer)le.basement_square_footage,
																						ri.dynamic_value	=	'F'	and	ri.trade_id	=	20	and	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	''	=>	round((integer)le.living_area_square_footage/(real)le.no_of_stories),
																						ri.dynamic_value	=	'P'	and	ri.trade_id	=	20	and	le.basement_square_footage		!=	''																=>	round(0.5*(integer)le.basement_square_footage),
																						ri.dynamic_value	=	'P'	and	ri.trade_id	=	20	and	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	''	=>	round(0.5*((integer)le.living_area_square_footage/(real)le.no_of_stories)),
																						ri.dynamic_value	=	'Q'	and	ri.trade_id	=	20	and	le.basement_square_footage		!=	''																=>	round(0.25*(integer)le.basement_square_footage),
																						ri.dynamic_value	=	'Q'	and	ri.trade_id	=	20	and	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	''	=>	round(0.25*((integer)le.living_area_square_footage/(real)le.no_of_stories)),
																						(real)ri.value
																					)
																		);

			self.pField							:=	if(le.pField	!=	'',le.pField,ri.material_code);
			self.insurbase_codes		:=	if(	ri.material_code	!=	''	and	vMaterialValue	!=	0,
																			le.insurbase_codes	+	row({ri.category_code,ri.material_code,vMaterialValue,'','',''},PropertyCharacteristics.Layout_Codes.TradeMaterials),
																			le.insurbase_codes
																		);
			self										:=	le;
		end;
		
		#uniquename(dMLSIBCode)
		%dMLSIBCode%	:=	denormalize(	%dInFilter%,
																		%dMLS2IBCodeLookup%,
																		right.trade_id																									=	(unsigned)%vTradeID%	and
																		PropertyCharacteristics.Functions.clean2Upper(left.pFieldDesc)	=	PropertyCharacteristics.Functions.clean2Upper(right.feature_description),
																		%tIBMaterialCode%(left,right),
																		local
																	);
		
		pOutDataset	:=	%dMLSIBCode%	+	pInDataset(pFieldDesc	=	'');
	endmacro;
	
	// Macro to get the insurbase material codes and values for MLS data
	export	Mac_MLS_Const_Heat_IBCode(pInDataset,pField,pFieldDesc,pCodesV3FieldName,pOutDataset)	:=
	macro
		// Get trade id from the field name
		#uniquename(vTradeID)
		%vTradeID%	:=	PropertyCharacteristics.Files.Codes.CodesV3(	field_name2	=	'PINFO'	and
																																	field_name	=	'TRADE'	and
																																	long_desc		=	pCodesV3FieldName
																																)[1].code;
		
		#uniquename(dInFilter)
		%dInFilter%	:=	pInDataset(pFieldDesc	!=	'');
		
		// Sort MLS2IBCodeLookup dataset by value so that the material code with the highest value is used
		#uniquename(dMLS2IBCodeLookup)
		%dMLS2IBCodeLookup%	:=	dedup(	sort(	distribute(PropertyCharacteristics.Files.Codes.MLS2IBCodeLookup,which_node),
																					feature_description,trade_id,-value,material_code,
																					local
																				),
																		feature_description,trade_id,
																		local
																	);

		// Function to get insurbase material code and value
		#uniquename(tIBMaterialCode)
		recordof(pInDataset)	%tIBMaterialCode%(%dInFilter%	le,%dMLS2IBCodeLookup%	ri)	:=
		transform
			self.pField							:=	if(le.pField	!=	'',le.pField,ri.material_code);
			self										:=	le;
		end;
		
		#uniquename(dMLSIBCode)
		%dMLSIBCode%	:=	denormalize(	%dInFilter%,
																		%dMLS2IBCodeLookup%,
																		right.trade_id																									=	(unsigned)%vTradeID%	and
																		PropertyCharacteristics.Functions.clean2Upper(left.pFieldDesc)	=	PropertyCharacteristics.Functions.clean2Upper(right.feature_description),
																		%tIBMaterialCode%(left,right),
																		local
																	);
		
		pOutDataset	:=	%dMLSIBCode%	+	pInDataset(pFieldDesc	=	'');
	endmacro;
	
	// Macro to get the insurbase material codes and values for public records data
	export	Mac_LN_IBCode(pInDataset,pField,pCodesV3Field,pOutDataset)	:=
	macro		
		#uniquename(dInFilter)
		%dInFilter%	:=	pInDataset(pField	!=	'');
		
		// Function to get insurbase material code and value
		#uniquename(tIBMaterialCode)
		recordof(pInDataset)	%tIBMaterialCode%(%dInFilter%	le,PropertyCharacteristics.Get_IB_Common_Codes.dCodesV3NormalizedDist	ri)	:=
		transform
			string3		vCategoryCode		:=	ut.Word(stringlib.stringcleanspaces(ri.long_desc),1,'|');
			string2		vTradeID				:=	ut.Word(stringlib.stringcleanspaces(ri.long_desc),2,'|');
			string30	vMaterialCode		:=	ut.Word(stringlib.stringcleanspaces(ri.long_desc),3,'|');
			string35	vTmpValue				:=	ut.Word(stringlib.stringcleanspaces(ri.long_desc),4,'|');
			/*
			real	vMaterialValue			:=	if(	vTmpValue	=	'BASEMENT_SQFT/LIVING_SQFT/STORIES',
																				if(	le.basement_square_footage	!=	'',
																						(integer)le.basement_square_footage,
																						if(	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	'',
																								round((integer)le.living_area_square_footage/(real)le.no_of_stories),
																								0
																							)
																					),
																				(real)vTmpValue
																			);
			*/
			real	vMaterialValue			:=	map(	vTmpValue	=	'BASEMENT_SQFT/LIVING_SQFT/STORIES'	and	le.basement_square_footage		!=	''																												=>	(integer)le.basement_square_footage,
																					vTmpValue	=	'BASEMENT_SQFT/LIVING_SQFT/STORIES'	and	le.living_area_square_footage	!=	''	and	le.no_of_stories	!=	''													=>	round((integer)le.living_area_square_footage/(real)le.no_of_stories),
																					vTmpValue	=	'GARAGE_SQFT/LIVING_SQFT'						and	le.garage_square_footage			!=	''																												=>	(integer)le.garage_square_footage,
																					vTmpValue	=	'GARAGE_SQFT/LIVING_SQFT'						and	le.living_area_square_footage	!=	''	and	(integer)le.living_area_square_footage	<=	1200	=>	200,
																					vTmpValue	=	'GARAGE_SQFT/LIVING_SQFT'						and	(integer)le.living_area_square_footage	between 1201	and	2400															=>	400,
																					vTmpValue	=	'GARAGE_SQFT/LIVING_SQFT'						and	(integer)le.living_area_square_footage	>	2400																							=>	600,
																					(real)vTmpValue
																				);
			
			self.insurbase_codes			:=	if(	vMaterialCode	!=	''	and	vMaterialValue	!=	0,
																				le.insurbase_codes	+	row({vCategoryCode,vMaterialCode,vMaterialValue,'','',''},PropertyCharacteristics.Layout_Codes.TradeMaterials),
																				le.insurbase_codes
																			);
			self											:=	le;
		end;

		#uniquename(dLNIBCode)
		%dLNIBCode%	:=	denormalize(	%dInFilter%,
																	PropertyCharacteristics.Get_IB_Common_Codes.dCodesV3NormalizedDist,
																	right.field_name																						=	pCodesV3Field	and
																	PropertyCharacteristics.Functions.clean2Upper(left.pField)	=	PropertyCharacteristics.Functions.clean2Upper(right.code),
																	%tIBMaterialCode%(left,right),
																	local
																);

		pOutDataset	:=	%dLNIBCode%	+	pInDataset(pField	=	'');
	endmacro;
	
	// Wrapper macro for getting the insurbase codes for MLS data
	export	Mac_Get_IBCode(pInDataset,pSource,pOutDataset)	:=
	macro
		// Distribute the dataset to reduce the skew
		#uniquename(dInDist)
		%dInDist%	:=	distribute(pInDataset,random());
		
		// Insurbase code for AC Type
		#uniquename(dIBCode_AC)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dInDist%,AIR_CONDITIONING_TYPE,AIR_CONDITIONING_TYPE_DESC,'AIR_CONDITIONING_TYPE_DESC',%dIBCode_AC%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dInDist%,AIR_CONDITIONING_TYPE,'AIR_CONDITIONING_TYPE',%dIBCode_AC%);
		#end
		
		// Insurbase code for Heating
		#uniquename(dIBCode_Heating)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_AC%,HEATING,HEATING_DESC,'HEATING_DESC',%dIBCode_Heating%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_AC%,HEATING,'HEATING_TYPE',%dIBCode_Heating%);
		#end
		
		// Insurbase code for Fuel Type
		// Bug# 80231 - Only get the IB code for fuel type if heating is not populated
		#uniquename(dIBCode_HeatNotPopulated)
		#uniquename(dIBCode_HeatPopulated)
		#uniquename(dIBCode_Fuel)
		#uniquename(dIBCode_FuelNoHeat)
		#uniquename(dIBCode_FuelHeat)
		
		#if(pSource	=	'MLS')
			%dIBCode_HeatNotPopulated%	:=	%dIBCode_Heating%(HEATING_DESC	=	'');
			%dIBCode_HeatPopulated%			:=	%dIBCode_Heating%(HEATING_DESC	!=	'');
			
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_HeatNotPopulated%,FUEL_TYPE,FUEL_TYPE_DESC,'FUEL_TYPE_DESC',%dIBCode_FuelNoHeat%);
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_Const_Heat_IBCode(%dIBCode_HeatPopulated%,FUEL_TYPE,FUEL_TYPE_DESC,'FUEL_TYPE_DESC',%dIBCode_FuelHeat%);
			%dIBCode_Fuel%	:=	%dIBCode_FuelHeat%	+	%dIBCode_FuelNoHeat%;
		#elseif(pSource	=	'LN')
			%dIBCode_HeatNotPopulated%	:=	%dIBCode_Heating%(HEATING	=	'');
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_HeatNotPopulated%,FUEL_TYPE,'FUEL_TYPE',%dIBCode_FuelNoHeat%);
			%dIBCode_Fuel%	:=	%dIBCode_Heating%(HEATING	!=	'')	+	%dIBCode_FuelNoHeat%;
		#end
		
		// Insurbase code for Floor Type
		#uniquename(dIBCode_Floor)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_Fuel%,FLOOR_TYPE,FLOOR_TYPE_DESC,'FLOOR_TYPE_DESC',%dIBCode_Floor%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Fuel%,FLOOR_TYPE,'FLOOR_COVER',%dIBCode_Floor%);
		#end
		
		// Insurbase code for Construction Type
		#uniquename(dIBCode_ConstType)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_Const_Heat_IBCode(%dIBCode_Floor%,CONSTRUCTION_TYPE,CONSTRUCTION_TYPE_DESC,'CONSTRUCTION_TYPE_DESC',%dIBCode_ConstType%);
		#elseif(pSource	=	'LN')
			// PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Floor%,CONSTRUCTION_TYPE,'CONSTRUCTION_TYPE',%dIBCode_ConstType%);
			// No need to send the contruction type to the ERC calculator per business
			%dIBCode_ConstType%	:=	%dIBCode_Floor%;
		#end
		
		// Insurbase code for Exterior Wall
		#uniquename(dIBCode_ExtWall)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_ConstType%,EXTERIOR_WALL,EXTERIOR_WALL_DESC,'EXTERIOR_WALL_DESC',%dIBCode_ExtWall%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_ConstType%,EXTERIOR_WALL,'EXTERIOR_WALL',%dIBCode_ExtWall%);
		#end
		
		// Insurbase code for Roof Cover
		#uniquename(dIBCode_RoofCover)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_ExtWall%,ROOF_COVER,ROOF_COVER_DESC,'ROOF_COVER_DESC',%dIBCode_RoofCover%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_ExtWall%,ROOF_COVER,'ROOF_COVER_TYPE',%dIBCode_RoofCover%);
		#end
		
		// Insurbase code for Foundation
		#uniquename(dIBCode_Foundation)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_RoofCover%,FOUNDATION,FOUNDATION_DESC,'FOUNDATION_DESC',%dIBCode_Foundation%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_RoofCover%,FOUNDATION,'FOUNDATION_TYPE',%dIBCode_Foundation%);
		#end
		
		// Insurbase code for Fireplace Type
		#uniquename(dIBCode_Fireplace)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_Foundation%,FIREPLACE_TYPE,FIREPLACE_TYPE_DESC,'FIREPLACE_TYPE_DESC',%dIBCode_Fireplace%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Foundation%,FIREPLACE_TYPE,'FIREPLACE_TYPE',%dIBCode_Fireplace%);
		#end
		
		// Insurbase code for Parking Type
		#uniquename(dIBCode_Parking)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_Fireplace%,PARKING_TYPE,PARKING_TYPE_DESC,'PARKING_TYPE_DESC',%dIBCode_Parking%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Fireplace%,PARKING_TYPE,'PARKING_TYPE',%dIBCode_Parking%);
		#end
		
		// Insurbase code for Garage Type
		#uniquename(dIBCode_Garage)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_Parking%,GARAGE,GARAGE_DESC,'GARAGE_DESC',%dIBCode_Garage%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Parking%,GARAGE,'GARAGE_TYPE',%dIBCode_Garage%);
		#end
		
		// Insurbase code for Basement Finish
		#uniquename(dIBCode_Basement)
		#if(pSource	=	'MLS')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_MLS_IBCode(%dIBCode_Garage%,BASEMENT_FINISH,BASEMENT_FINISH_DESC,'BASEMENT',%dIBCode_Basement%);
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Garage%,BASEMENT_FINISH,'BASEMENT_FINISH',%dIBCode_Basement%);
		#end
		
		// Insurbase code for Stories Type
		#uniquename(dIBCode_Stories)
		#if(pSource	=	'MLS')
			%dIBCode_Stories%	:=	%dIBCode_Basement%;
		#elseif(pSource	=	'LN')
			PropertyCharacteristics.Get_IB_Common_Codes.Mac_LN_IBCode(%dIBCode_Basement%,STORIES_TYPE,'STORIES_TYPE',%dIBCode_Stories%);
		#end
		
		pOutDataset	:=	%dIBCode_Stories%;
	endmacro;
	
end;
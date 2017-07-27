import	codes;

export	Get_BB_Common_Codes	:=
module

	export	Mac_IB_2_Common(pInDataset,pField,pCodesV3FieldName,pOutDataset)	:=
	macro		
		#uniquename(tCommonCode)
		recordof(pInDataset)	%tCommonCode%(pInDataset	le,PropertyCharacteristics.Files.Codes.CodesV3	ri)	:=
		transform
			self.pField	:=	ri.long_desc[1..3];
			self				:=	le;
		end;
		
		#uniquename(dCommonCode)
		%dCommonCode%	:=	join(	pInDataset,
														PropertyCharacteristics.Files.Codes.CodesV3,
														right.field_name2																						=	'PINFO'						and
														right.field_name																						=	pCodesV3FieldName	and
														PropertyCharacteristics.Functions.clean2Upper(left.pField)	=	PropertyCharacteristics.Functions.clean2Upper(right.code),
														%tCommonCode%(left,right),
														left outer,
														lookup
													);
		
		pOutDataset	:=	%dCommonCode%;
	endmacro;
	
	
	// Convert the other descriptions which don't have insurbase codes mappings to common codes
	export	Mac_BB_2_Common(pInDataset,pField,pFieldDesc,pCodeFieldName,pOutDataset)	:=
	macro
		#uniquename(dMLS2CommonCode)
		%dMLS2CommonCode%	:=	PropertyCharacteristics.Files.Codes.MLS2CommonCodeLookup(	file_name		=	'PROPERTYINFO'	and
																																										source_code	=	'PINFO'
																																									);
		
		#uniquename(tCommonCode)
		recordof(pInDataset)	%tCommonCode%(pInDataset	le,%dMLS2CommonCode%	ri)	:=
		transform
			self.pField	:=	ri.common_code;
			self				:=	le;
		end;

		#uniquename(dBBCommonCode)
		%dBBCommonCode%	:=	join(	pInDataset,
															%dMLS2CommonCode%,
															right.field_name																								=	pCodeFieldName	and
															PropertyCharacteristics.Functions.clean2Upper(left.pFieldDesc)	=	PropertyCharacteristics.Functions.clean2Upper(right.raw_desc),
															%tCommonCode%(left,right),
															left outer,
															lookup
														);

		pOutDataset	:=	%dBBCommonCode%;
	endmacro;

	export	Mac_BB_Common_Code(pInDataset,pOutDataset)	:=
	macro
		// To reduce the skew, distribute the dataset
		#uniquename(dInDist)
		%dInDist%	:=	distribute(pInDataset,random());
		
		#uniquename(dCmnCode_AC)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dInDist%,AIR_CONDITIONING_TYPE,'CLIMATE_CONTROL',%dCmnCode_AC%);
		
		// Insurbase code for Heating
		#uniquename(dCmnCode_Heating)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_AC%,HEATING,'CLIMATE_CONTROL',%dCmnCode_Heating%);
		
		// Insurbase code for Fuel Type
		#uniquename(dCmnCode_Fuel)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Heating%,FUEL_TYPE,'CLIMATE_CONTROL',%dCmnCode_Fuel%);
		
		// Insurbase code for Floor Type
		#uniquename(dCmnCode_Floor)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Fuel%,FLOOR_TYPE,'FLOORING',%dCmnCode_Floor%);
		
		// Insurbase code for Construction Type
		#uniquename(dCmnCode_ConstType)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Floor%,CONSTRUCTION_TYPE,'EXTERIOR_FINISH',%dCmnCode_ConstType%);
		
		// Insurbase code for Exterior Wall
		#uniquename(dCmnCode_ExtWall)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_ConstType%,EXTERIOR_WALL,'EXTERIOR_FINISH',%dCmnCode_ExtWall%);
		
		// Insurbase code for Roof Cover
		#uniquename(dCmnCode_RoofCover)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_ExtWall%,ROOF_COVER,'ROOFING',%dCmnCode_RoofCover%);
		
		// Insurbase code for Foundation
		#uniquename(dCmnCode_Foundation)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_RoofCover%,FOUNDATION,'FOUNDATION',%dCmnCode_Foundation%);
		
		// Insurbase code for Fireplace Type
		#uniquename(dCmnCode_Fireplace)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Foundation%,FIREPLACE_TYPE,'FIREPLACE',%dCmnCode_Fireplace%);
		
		// Insurbase code for Parking Type
		#uniquename(dCmnCode_Parking)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Fireplace%,PARKING_TYPE,'PARKING',%dCmnCode_Parking%);
		
		// Insurbase code for Garage Type
		#uniquename(dCmnCode_Garage)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Parking%,GARAGE,'PARKING',%dCmnCode_Garage%);
		
		// Insurbase code for Basement Finish
		#uniquename(dCmnCode_Basement)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_IB_2_Common(%dCmnCode_Garage%,BASEMENT_FINISH,'BASEMENT',%dCmnCode_Basement%);
		
		#uniquename(dCmnCode_Sewer)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_Basement%,SEWER,SEWER_DESC,'SEWER',%dCmnCode_Sewer%);
		
		#uniquename(dCmnCode_Water)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_Sewer%,WATER,WATER_DESC,'WATER',%dCmnCode_Water%);
		
		#uniquename(dCmnCode_PropType)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_Water%,PROPERTY_TYPE_CODE,PROPERTY_TYPE_DESC,'PROPERTY_IND',%dCmnCode_PropType%);
		
		#uniquename(dCmnCode_LandUse)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_PropType%,LAND_USE_CODE,LAND_USE_CODE,'LAND_USE_CODE',%dCmnCode_LandUse%);
		
		#uniquename(dCmnCode_Pool)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_LandUse%,POOL_TYPE,POOL_TYPE_DESC,'POOL_TYPE',%dCmnCode_Pool%);
		
		#uniquename(dCmnCode_Style)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_Pool%,STYLE_TYPE,STYLE_TYPE_DESC,'STYLE_TYPE',%dCmnCode_Style%);
		
		#uniquename(dCmnCode_LocInf)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_Style%,LOCATION_INFLUENCE_CODE,LOCATION_INFLUENCE_DESC,'LOCATION_INFLUENCE',%dCmnCode_LocInf%);
		
		#uniquename(dCmnCode_Stories)
		PropertyCharacteristics.Get_BB_Common_Codes.Mac_BB_2_Common(%dCmnCode_LocInf%,STORIES_TYPE,STORIES_TYPE_DESC,'STORIES_TYPE',%dCmnCode_Stories%);
		
		pOutDataset	:=	%dCmnCode_Stories%;
	endmacro;
	
end;
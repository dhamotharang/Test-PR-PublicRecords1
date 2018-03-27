/* **************************************************************************************************************
*************** All of the "Fix-Code" logic is made obsolete because we went to the more advanced method
*************** of doing full refreshes from production - see "V_Refresh_*" attributes
************************************************************************************************************** */

IMPORT Codes, PRTE2_LNProperty;

// much of this from:  PropertyScrubs.fValidateAssesment

Codes_All  := Codes.File_Codes_V3_In;
filterBy := 'FARES_2580';
file_codes_in := Codes_All(file_name=filterBy);
TrimLR(STRING S1) := trim(S1,left,right);

findCodesV3Desc(string FieldName,string description, string vendor) := FUNCTION 
		file_desc := file_codes_in(field_name = FieldName ,long_desc = description, field_name2[1]=vendor); 
		return  TrimLR(file_desc[1].code);
END ;
Batch_Layout := PRTE2_LNProperty.z_Layout_Batch_in;

EXPORT Batch_Layout 	U_Fix_Alpha_Codes_1(Batch_Layout L) := TRANSFORM

			STRING TMP_SRC := L.LN_Fares_ID[1];
			STRING lvendor_source_flag := IF(TMP_SRC='R','F',TMP_SRC);
			debugString := '['+L.assess_garage_type_desc+' | GARAGE | '+lvendor_source_flag+']';
			LookupCode(STRING val, STRING FieldName) := IF( TrimLR(val)='', '', findCodesV3Desc(FieldName, TrimLR(val), lvendor_source_flag) );
			// SELF.assess_pool_code := debugString;
			SELF.vendor_source_flag := lvendor_source_flag;		
			SELF.assess_pool_code     							:= LookupCode(L.assess_pool_desc, 'POOL_CODE');  
			SELF.assess_garage_type_code     				:= LookupCode(L.assess_garage_type_desc, 'GARAGE');  
			SELF.assess_exterior_walls_code     		:= LookupCode(L.assess_exterior_walls_desc, 'EXTERIOR_WALLS');  
			SELF.assess_roof_type_code     					:= LookupCode(L.assess_roof_type_desc, 'ROOF_TYPE');  
			SELF.assess_heating_code     						:= LookupCode(L.assess_heating_desc, 'HEATING');  
			SELF.assess_heating_fuel_type_code     	:= LookupCode(L.assess_heating_fuel_type_desc, 'FUEL');  
			SELF.assess_air_conditioning_type_code 	:= LookupCode(L.assess_air_conditioning_type_desc, 'AIR_CONDITIONING_TYPE_CODE');  
			SELF.assess_building_class_code     		:= LookupCode(L.assess_building_class_desc, 'BUILDING_CLASS_CODE');  
			SELF.assess_site_influence1_code     		:= LookupCode(L.assess_site_influence1_desc, 'LOCATION_INFLUENCE');  
			SELF.assess_amenities1_code     				:= LookupCode(L.assess_amenities1_desc, 'AMENITIES1_CODE');  
			SELF.assess_amenities2_code     				:= LookupCode(L.assess_amenities2_desc, 'AMENITIES2_CODE');  
			SELF.assess_amenities3_code     				:= LookupCode(L.assess_amenities3_desc, 'AMENITIES3_CODE');  
			SELF.assess_amenities4_code     				:= LookupCode(L.assess_amenities4_desc, 'AMENITIES4_CODE');  
			SELF.assess_other_buildings1_code     	:= LookupCode(L.assess_other_buildings1_desc, 'BLDG_IMPV_CODE');  
			SELF.assess_fireplace_indicator     		:= LookupCode(L.assess_fireplace_indicator_desc, 'FIREPLACE_INDICATOR');  
			SELF := L;
			SELF := [];
			
END;

/*
The following are done in the Transform_data feeding the final expanded layout - so we need to add these codes to the spreadsheet to remove the descriptions
					SELF.exterior_walls_code   := MAP(L.assess_exterior_walls_desc = 'SIDING (ALUM/VINYL)' => 'SID',
					SELF.type_construction_code := MAP(L.assess_type_construction_desc = 'FRAME'    => 'FRM',
					SELF.foundation_code        := MAP(L.assess_foundation_desc = 'SLAB'    => 'SLB',
					self.heating_code    := MAP(L.assess_heating_desc = 'FORCED AIR'       => 'FA0',
					SELF.heating_fuel_type_code  := MAP(L.assess_heating_fuel_type_desc = 'COAL'    => 'FCO',
					SELF.roof_type_code   := MAP(L.assess_roof_type_desc = 'GABLE'    => 'G00',

// we can fix these later ...
			// SELF.assess_standardized_land_use_code	:= LookupCode(L.assess_standardized_land_use_desc, 'LAND_USE');
			// SELF.assess_assessee_ownership_rights_code	:= LookupCode(L.assess_assessee_ownership_rights_desc, 'OWNER_OWNERSHIP_RIGHTS_CODE');  
			// SELF.assess_assessee_relationship_code	:= LookupCode(L.assess_assessee_relationship_desc, 'OWNER_RELATIONSHIP_CODE');  
			// SELF.assess_assessee_name_type_code  	:= LookupCode(L.assess_assessee_name_type_desc, 'ASSESSEE_NAME_TYPE_CODE');  
			// SELF.assess_second_assessee_name_type_code := LookupCode(L.assess_second_assessee_name_type_desc, 'SECOND_ASSESSEE_NAME_TYPE_CODE');  
			// SELF.assess_mail_care_of_name_type_code    := LookupCode(L.assess_mail_care_of_name_type_desc, 'MAIL_CARE_OF_NAME_TYPE_CODE');  
			// SELF.record_type_code     							:= LookupCode(L.record_type_desc, 'RECORD_TYPE_CODE');  
			// SELF.legal_lot_code     								:= LookupCode(L.assess_legal_lot_desc, 'LEGAL_LOT_CODE');  
			// SELF.ownership_type_code     					:= LookupCode(L.assess_ownership_type_desc, 'OWNERSHIP_TYPE_CODE');  
			// SELF.new_record_type_code     					:= LookupCode(L.assess_new_record_type_desc, 'NEW_RECORD_TYPE_CODE');  
			// SELF.sales_price_code     							:= LookupCode(L.assess_sales_price_desc, 'SALE_CODE');  
			// SELF.prior_sales_price_code	 					:= LookupCode(L.assess_prior_sales_price_desc, 'PRIOR_SALES_PRICE_CODE');  
			// SELF.mortgage_loan_type_code   				:= LookupCode(L.assess_mortgage_loan_type_desc, 'MORTGAGE_LOAN_TYPE_CODE');  
			// SELF.mortgage_lender_type_code					:= LookupCode(L.assess_mortgage_lender_type_desc, 'MORTGAGE_LENDER_TYPE_CODE');  
			// SELF.assess_tax_exemption1_code     		:= LookupCode(L.assess_tax_exemption1_desc, 'TAX_EXEMPTION1_CODE');  
			// SELF.assess_tax_exemption2_code     		:= LookupCode(L.assess_tax_exemption2_desc, 'TAX_EXEMPTION2_CODE');  
			// SELF.assess_tax_exemption3_code     		:= LookupCode(L.assess_tax_exemption3_desc, 'TAX_EXEMPTION3_CODE');  
			// SELF.assess_tax_exemption4_code     		:= LookupCode(L.assess_tax_exemption4_desc, 'TAX_EXEMPTION4_CODE');  
			// SELF.assess_no_of_stories     					:= LookupCode(L.assess_no_of_stories, 'STORIES_CODE');  
			// SELF.assess_property_address_code     	:= LookupCode(L.assess_property_address_desc, 'PROPERTY_ADDRESS_CODE');  
			// SELF.assess_floor_cover_code     			:= LookupCode(L.assess_floor_cover_desc, 'FLOOR_COVER');  
			// SELF.assess_building_quality_code     	:= LookupCode(L.assess_building_quality_desc, 'QUALITY');  
*/
import Codes, LN_PropertyV2;

k_codes			:= keys.codes;

l_raw				:= layouts.assess.raw_source;
l_fid				:= layouts.fid;
l_tmp				:= layouts.assess.result.tmp;
l_rolled		:= layouts.assess.result.rolled_tmp;

max_assess	:= consts.max_assess;
code_file		:= consts.assess_codefile;


// Abstract Codes.KeyCodes calls to simplify somewhat...
varstring GetCode(
	string field_name_value, 
	string field_name2_value = '',
	string code_value
) := function
	return Codes.KeyCodes(code_file, field_name_value, field_name2_value, code_value, true);
end;

// returns building area by code
string GetLivingByCode (l_raw L, string1 ind) := 
  map (L.building_area_indicator = ind => L.building_area,
       L.building_area1_indicator = ind => L.building_area1,
       L.building_area2_indicator = ind => L.building_area2,
       L.building_area3_indicator = ind => L.building_area3,
       L.building_area4_indicator = ind => L.building_area4,
       L.building_area5_indicator = ind => L.building_area5,
       L.building_area6_indicator = ind => L.building_area6,
       L.building_area7_indicator = ind => L.building_area7,
       '');


export dataset(l_rolled) fn_get_assessments(
  dataset(l_raw) ds_raw
) := function
	
	// add computed fields
	l_tmp addValue(ds_raw L) := transform
	
		// Sorting Date -----------------------------------
		self.sortby_date := Raw.assess_recency(L);
		
		// Penalty ----------------------------------------
		self.penalt := 0;
		self.cPenalt := 0;
		// We only need a placeholder since searchable data is all in the parties section
		
		// Type ----------------------------------------
		ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		self.fid_type				:= ft;
		self.fid_type_desc	:= fn_fid_type_desc(ft);
		
		// Vendor --------------------------------------
		vsource := fn_vendor_source(L.vendor_source_flag);
		self.vendor_source_desc := vsource;
		obs_source := fn_vendor_source_obscure(L.vendor_source_flag);
		self.vendor_source_flag := obs_source;
		
  	// Lookup Codes -----------------------------------
		
		// Owner Info
		self.assessee_ownership_rights_desc := GetCode(
			'OWNER_OWNERSHIP_RIGHTS_CODE', vsource, L.assessee_ownership_rights_code);
		self.assessee_relationship_desc := GetCode(
			'OWNER_RELATIONSHIP_CODE', vsource, L.assessee_relationship_code);
		self.assessee_name_type_desc := GetCode(
			'ASSESSEE_NAME_TYPE_CODE', vsource, L.assessee_name_type_code);
		self.second_assessee_name_type_desc := GetCode(
			'SECOND_ASSESSEE_NAME_TYPE_CODE ', vsource, L.second_assessee_name_type_code);
		
		// Address Info
		self.mail_care_of_name_type_desc := GetCode(
			'MAIL_CARE_OF_NAME_TYPE_CODE', vsource, L.mail_care_of_name_type_code);
		
		// Legal Info
		self.record_type_desc := GetCode(
			'RECORD_TYPE_CODE', vsource, L.record_type_code);
		self.standardized_land_use_desc := GetCode(
			'LAND_USE', vsource, L.standardized_land_use_code); // STANDARDIZED_LAND_USE_CODE deprecated
		// self.fares_land_use_desc := GetCode(
			// 'LAND_USE', vsource, L.fares_land_use);
		self.legal_lot_desc := GetCode(
			'LEGAL_LOT_CODE', vsource, L.legal_lot_code);
		self.ownership_type_desc := GetCode(
			'OWNERSHIP_TYPE_CODE', vsource, L.ownership_type_code);
		self.new_record_type_desc := GetCode(
			'NEW_RECORD_TYPE_CODE', vsource, L.new_record_type_code);
		self.document_type_desc := GetCode(
			'DOCUMENT_TYPE_CODE', vsource, L.document_type);
		
		// Sales Info
		self.sales_price_desc := GetCode(
			'SALE_CODE', vsource, L.sales_price_code); // SALES_PRICE_CODE deprecated
		self.prior_sales_price_desc := GetCode(
			'PRIOR_SALES_PRICE_CODE', vsource, L.prior_sales_price_code);

		// Mortgage Info
		self.mortgage_loan_type_desc := GetCode(
			'MORTGAGE_LOAN_TYPE_CODE', vsource, L.mortgage_loan_type_code);
		
		// Lender Info
		self.mortgage_lender_type_desc := GetCode(
			'MORTGAGE_LENDER_TYPE_CODE', vsource, L.mortgage_lender_type_code);
		
		// Tax Info
		self.tax_exemption1_desc := GetCode(
			'TAX_EXEMPTION1_CODE', vsource, L.tax_exemption1_code);
		self.tax_exemption2_desc := GetCode(
			'TAX_EXEMPTION2_CODE', vsource, L.tax_exemption2_code);
		self.tax_exemption3_desc := GetCode(
			'TAX_EXEMPTION3_CODE', vsource, L.tax_exemption3_code);
		self.tax_exemption4_desc := GetCode(
			'TAX_EXEMPTION4_CODE', vsource, L.tax_exemption4_code);
		
		// Property Info
		self.no_of_stories_desc := GetCode(
			'STORIES_CODE', vsource, L.no_of_stories);
		self.garage_type_desc := GetCode(
			'GARAGE', vsource, L.garage_type_code); // GARAGE_TYPE_CODE deprecated
		self.pool_desc := GetCode(
			'POOL_CODE', vsource, L.pool_code);
		self.exterior_walls_desc := GetCode(
			'EXTERIOR_WALLS', vsource, L.exterior_walls_code); // EXTERIOR_WALLS_CODE deprecated
		self.roof_type_desc := GetCode(
			'ROOF_TYPE', vsource, L.roof_type_code); // ROOF_TYPE_CODE deprecated
		self.heating_desc := GetCode(
			'HEATING', vsource, L.heating_code); // HEATING_CODE deprecated
		self.heating_fuel_type_desc := GetCode(
			'FUEL', vsource, L.heating_fuel_type_code); // HEATING_FUEL_TYPE_CODE deprecated
		self.air_conditioning_desc := GetCode(
			'AIR_CONDITIONING', vsource, L.air_conditioning_code); // AIR_CONDITIONING_CODE deprecated
		self.air_conditioning_type_desc := GetCode(
			'AIR_CONDITIONING_TYPE_CODE', vsource, L.air_conditioning_type_code);
		self.style_desc := GetCode(
			'STYLE', vsource, L.style_code); // STYLE_CODE deprecated
		self.type_construction_desc := GetCode(
			'CONSTRUCTION_TYPE', vsource, L.type_construction_code); // TYPE_CONSTRUCTION_CODE deprecated
		self.foundation_desc := GetCode(
			'FOUNDATION', vsource, L.foundation_code); // FOUNDATION_CODE deprecated
		self.roof_cover_desc := GetCode(
			'ROOF_COVER', vsource, L.roof_cover_code); // ROOF_COVER_CODE deprecated
		self.basement_desc := GetCode(
			'BASEMENT_FINISH', vsource, L.basement_code); // BASEMENT_CODE deprecated
		self.building_class_desc := GetCode(
			'BUILDING_CLASS_CODE', vsource, L.building_class_code);
		self.site_influence1_desc := GetCode(
			'LOCATION_INFLUENCE', vsource, L.site_influence1_code);
		self.site_influence2_desc := GetCode(
			'LOCATION_INFLUENCE', vsource, L.site_influence2_code);
		self.site_influence3_desc := GetCode(
			'LOCATION_INFLUENCE', vsource, L.site_influence3_code);
		self.site_influence4_desc := GetCode(
			'LOCATION_INFLUENCE', vsource, L.site_influence4_code);
		self.site_influence5_desc := GetCode(
			'LOCATION_INFLUENCE', vsource, L.site_influence5_code);
		
		// NOTE: keys need to go back to original fieldnames in 1/09
		self.amenities1_desc := GetCode(
			// 'AMENITIES1_CODE', vsource, L.amenities1_code1);
			'AMENITIES1_CODE', vsource, L.amenities1_code);
		self.amenities2_desc := GetCode(
			// 'AMENITIES2_CODE', vsource, L.amenities1_code2);
			'AMENITIES2_CODE', vsource, L.amenities2_code);
		self.amenities3_desc := GetCode(
			// 'AMENITIES3_CODE', vsource, L.amenities1_code3);
			'AMENITIES3_CODE', vsource, L.amenities3_code);
		self.amenities4_desc := GetCode(
			// 'AMENITIES4_CODE', vsource, L.amenities1_code4);
			'AMENITIES4_CODE', vsource, L.amenities4_code);
		self.amenities5_desc := GetCode(
			// 'AMENITIES5_CODE', vsource, L.amenities1_code5);
			'AMENITIES5_CODE', vsource, L.amenities5_code);
		// self.amenities1_code := L.amenities1_code1;
		// self.amenities2_code := L.amenities1_code2;
		// self.amenities3_code := L.amenities1_code3;
		// self.amenities4_code := L.amenities1_code4;
		// self.amenities5_code := L.amenities1_code5;
		
		self.other_buildings1_desc := GetCode(
			'BLDG_IMPV_CODE', vsource, L.other_buildings1_code);
		self.other_buildings2_desc := GetCode(
			'BLDG_IMPV_CODE', vsource, L.other_buildings2_code);
		self.other_buildings3_desc := GetCode(
			'BLDG_IMPV_CODE', vsource, L.other_buildings3_code);
		self.other_buildings4_desc := GetCode(
			'BLDG_IMPV_CODE', vsource, L.other_buildings4_code);
		self.other_buildings5_desc := GetCode(
			'BLDG_IMPV_CODE', vsource, L.other_buildings5_code);
		
		self.fireplace_indicator_desc := GetCode(
			'FIREPLACE_INDICATOR', vsource, L.fireplace_indicator);
		self.fares_fire_place_type_desc := GetCode(
			'FIREPLACE_TYPE', vsource, L.fares_fire_place_type);
		self.fares_frame_desc := GetCode(
			'FRAME', vsource, L.fares_frame);
		self.fares_electric_energy_desc := GetCode(
			'ELECTRIC_ENERGY', vsource, L.fares_electric_energy);
			
		self.fares_sewer_desc := GetCode(
			'SEWER', vsource, L.fares_sewer);
		self.fares_water_desc := GetCode(
			'WATER', vsource, L.fares_water);
		self.fares_condition_desc := GetCode(
			'CONDITION', vsource, L.fares_condition);
		self.fares_sewer := L.sewer_code;
		self.fares_water := L.water_code;
		self.fares_condition := L.building_condition_code;
		self.condo_project_name := L.condo_project_or_building_name;
		self.building_name := L.condo_project_or_building_name;
			
		self.property_address_desc := GetCode(
			'PROPERTY_ADDRESS_CODE', vsource, L.property_address_code);
		
		self.building_area_desc := GetCode(
			'BUILDING_AREA_INDICATOR', vsource, L.building_area_indicator);
		self.building_area1_desc := GetCode(
			'BUILDING_AREA1_INDICATOR', vsource, L.building_area1_indicator);
		self.building_area2_desc := GetCode(
			'BUILDING_AREA2_INDICATOR', vsource, L.building_area2_indicator);
		self.building_area3_desc := GetCode(
			'BUILDING_AREA3_INDICATOR', vsource, L.building_area3_indicator);
		self.building_area4_desc := GetCode(
			'BUILDING_AREA4_INDICATOR', vsource, L.building_area4_indicator);
		self.building_area5_desc := GetCode(
			'BUILDING_AREA5_INDICATOR', vsource, L.building_area5_indicator);
		self.building_area6_desc := GetCode(
			'BUILDING_AREA6_INDICATOR', vsource, L.building_area6_indicator);
		self.building_area7_desc := GetCode(
			'BUILDING_AREA7_INDICATOR', vsource, L.building_area7_indicator);
		
		self.floor_cover_desc := GetCode(
			'FLOOR_COVER', vsource, L.floor_cover_code);
		self.building_quality_desc := GetCode(
			'QUALITY', vsource, L.building_quality_code);
		
		self.fares_parking_type_desc := GetCode(
			'PARKING_TYPE', vsource, L.fares_parking_type);
		self.fares_property_indicator_desc := GetCode(
			'PROPERTY_IND', vsource, L.fares_property_indicator);
		self.fares_stories_desc := GetCode(
			'STORIES_CODE', vsource, L.fares_stories_code);
		
		udecimal5_2 pct(string n, string d) := (real)n / (real)d * 100.0;
		self.percent_improved := pct(L.assessed_improvement_value, L.assessed_total_value);

    // Calculate living area. Generally, it corresponds to "L" building area code, but in absense of it, "J" can be used.
    sq_feet_L := GetLivingByCode (L, 'L');
    sq_feet := if (sq_feet_L = '', GetLivingByCode (L, 'J'), sq_feet_L);
		self.fares_living_square_feet := if (L.fares_living_square_feet = '' and obs_source = 'B', sq_feet, L.fares_living_square_feet);
		self := L;
		
	end;
	ds_value := project(ds_raw, addValue(left));
	
	// sort & dedup
	ds_sort := dedup(
		sort(ds_value, ln_fares_id, search_did, record ),
		record
	);
	
	// rollup
	l_rolled xf_roll_assess(l_tmp L, dataset(l_tmp) R) := transform
		self.assessments	:= choosen(R,max_assess);
		self							:= L;
	end;
	ds_rolled := rollup(
		group( ds_sort, ln_fares_id, search_did ),
		group,
		xf_roll_assess(left,rows(left))
	);
	
	// DEBUG
	// output(ds_raw1,		named('ds_raw1'));
	// output(ds_raw2,		named('ds_raw2'));
	// output(ds_raw3,		named('ds_raw3'));
	// output(ds_value,		named('ds_value'));
	// output(ds_sort,		named('ds_sort'));
	// output(ds_rolled,	named('ds_rolled'));
	
	return ds_rolled;
	
end;
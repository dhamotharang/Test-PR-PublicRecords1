import LN_PropertyV2_Services, LN_PropertyV2, _Control;

k_codes			:= LN_PropertyV2_Services.keys_2.codes;

l_raw				:= LN_PropertyV2_Services.layouts.assess.raw_source;
l_fid				:= LN_PropertyV2_Services.layouts.fid;
l_tmp				:= LN_PropertyV2_Services.layouts.assess.result.tmp;
l_rolled		:= LN_PropertyV2_Services.layouts.assess.result.rolled_tmp;

max_assess	:= LN_PropertyV2_Services.consts.max_assess;
code_file		:= LN_PropertyV2_Services.consts.assess_codefile;

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


export dataset(l_rolled) fn_get_assessments_2(
  dataset(l_raw) ds_raw,
	LN_PropertyV2_Services.interfaces.Iinput_report in_mod
) := function
	
	// For Boca Shell Property Common, we don't need the code descriptions.
	l_tmp addOnlyALittleValue(ds_raw L) := transform
	
		// Sorting Date -----------------------------------
		self.sortby_date := LN_PropertyV2_Services.Raw_2(in_mod.lookupVal, in_mod.partyType, in_mod.faresID).assess_recency_raw(L);
		
		// Penalty ----------------------------------------
		self.penalt := 0;
		self.cPenalt := 0;
		// We only need a placeholder since searchable data is all in the parties section
		
		// Type ----------------------------------------
		ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		self.fid_type				:= ft;
		self.fid_type_desc	:= fn_fid_type_desc(ft);
		
		// Vendor --------------------------------------
		obs_source := fn_vendor_source_obscure(L.vendor_source_flag);
		self.vendor_source_desc := fn_vendor_source(L.vendor_source_flag);
		self.vendor_source_flag := obs_source;
		
		self.fares_sewer := L.sewer_code;
		self.fares_water := L.water_code;
		self.fares_condition := L.building_condition_code;
		self.condo_project_name := L.condo_project_or_building_name;
		self.building_name := L.condo_project_or_building_name;
			
		udecimal5_2 pct(string n, string d) := (real)n / (real)d * 100.0;
		self.percent_improved := pct(L.assessed_improvement_value, L.assessed_total_value);

    // Calculate living area. Generally, it corresponds to "L" building area code, but in absense of it, "J" can be used.
    sq_feet_L := GetLivingByCode(L, 'L');
    sq_feet := if (sq_feet_L = '', GetLivingByCode(L, 'J'), sq_feet_L);
		self.fares_living_square_feet := if (L.fares_living_square_feet = '' and obs_source = 'B', sq_feet, L.fares_living_square_feet);
		self := L;
		self := [];
	end;

	ds_value := project(ds_raw, addOnlyALittleValue(left));
	
#IF(_Control.Environment.OnThor)  
	ds_value_distributed := distribute(ds_value, hash64(ln_fares_id));
	// sort & dedup
	ds_sort := 
		DEDUP(
			SORT(
				ds_value_distributed, 
				ln_fares_id, search_did, -sortby_date, fid_type, vendor_source_flag, -assessed_total_value, local
			),
			ln_fares_id, search_did, sortby_date, fid_type, vendor_source_flag, assessed_total_value, local
		);
#ELSE	
	// sort & dedup
	ds_sort := 
		DEDUP(
			SORT(
				ds_value, 
				ln_fares_id, search_did, -sortby_date, fid_type, vendor_source_flag, -assessed_total_value
			),
			ln_fares_id, search_did, sortby_date, fid_type, vendor_source_flag, assessed_total_value
		);
#END
	
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
	
	return ds_rolled;
	
end;
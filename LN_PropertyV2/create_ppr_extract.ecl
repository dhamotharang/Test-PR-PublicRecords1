import LN_PropertyV2_Services, Codes;

// search file has cleaned addresses, filtered for assessments and property addresses only
props_addr := ln_propertyv2.file_search_did(ln_fares_id[2] = 'A', source_code[2] = 'P');
props_ddp := dedup(sort(props_addr, ln_fares_id), ln_fares_id);

// base file has property details, can be joined by ln_fares_id
base_assess := LN_PropertyV2.file_assessment_building(trim(ln_fares_id) != '');

layout_combined := RECORD
	props_ddp.ln_fares_id;
	string sortby_date;
	props_ddp.prim_range;
	props_ddp.predir;	
	props_ddp.prim_name;
	props_ddp.suffix;
	props_ddp.unit_desig;
	props_ddp.sec_range;
	props_ddp.postdir;
	props_ddp.v_city_name;
	props_ddp.st;
	props_ddp.zip;
	base_assess.vendor_source_flag;
	base_assess.apna_or_pin_number;
	base_assess.duplicate_apn_multiple_address_id;
	base_assess.year_built;
	base_assess.standardized_land_use_code;
	STRING standardized_land_use_desc := '';
END;

layout_combined xform(base_assess le, props_ddp ri) := TRANSFORM
	// using the same code as the Property service uses to pick the 'most recent' record
	SELF.sortby_date := LN_PropertyV2_Services.Raw.assess_recency(le);
	SELF := le;
	SELF := ri;
END;


combined := join(base_assess, props_ddp,left.ln_fares_id = right.ln_fares_id, xform(LEFT,RIGHT), HASH);

combined_dist := DISTRIBUTE(combined, HASH32(prim_name, v_city_name, prim_range, zip, suffix, sec_range, predir, postdir, st));
current := dedup(sort(combined_dist, prim_name, v_city_name, prim_range, zip, suffix, sec_range, predir, postdir, st, -sortby_date, local),
								      prim_name, v_city_name, prim_range, zip, suffix, sec_range, predir, postdir, st, local);

assess_codes := Codes.File_Codes_V3_In(file_name ='FARES_2580', field_name='LAND_USE');

// need to translate land use code to its description
with_desc := join(current, assess_codes, right.field_name2 = LN_PropertyV2_Services.fn_vendor_source(left.vendor_source_flag) and
																				 right.code = left.standardized_land_use_code, 
																				 transform(layout_combined, 
																						self.standardized_land_use_desc := right.long_desc;
																						self := left;), left outer, lookup);


export create_ppr_extract :=with_desc;
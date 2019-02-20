import fcra, ut, AVM_V2, data_services;

Layout_Override_AVM1 := RECORD
	string28 prim_name;
	string2  st;
	
	string5  zip;
	string10 prim_range;
	string8  sec_range;
	

	string12 ln_fares_id_ta;
	string12 ln_fares_id_pi;
	string45 unformatted_apn;
	string2  predir;
	
	
	
	string4  suffix;
	string2  postdir;
	string10 unit_desig;
	
	string25 p_city_name;
	string4  zip4;


	string10 lat;
	string11 long;
	string7  geo_blk;
	string5  fips_code;
	string1  land_use;
	string8  recording_date;
	string4  assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer  tax_assessment_valuation;
	integer  price_index_valuation;
	integer  automated_valuation;
	integer  confidence_score;
	integer  hedonic_valuation;
	string12 comp1;
	string12 comp2;
	string12 comp3;
	string12 comp4;
	string12 comp5;
	string12 nearby1;
	string12 nearby2;
	string12 nearby3;
	string12 nearby4;
	string12 nearby5;
	integer  no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
	integer  comp_radius;  // number of miles needed to meet 20 comp minimum
	real     sum_hedonic_distance; // sum of the comps' hedonic distance
	real     sum_physical_distance; // sum of the comps' physical distance to the subject property
	string1  combo_flag;
	integer  median_fips_valuation;  // median valuation of the property's county
	integer  median_tract_valuation;  // median valuation of the property's tract (tract=geo_blk[1..6]
	integer  median_block_valuation;  // median valuation of the property's block group (blkgrp=geo_blk[7])
	string20 flag_file_id;
end;
ds := dedup(sort(dataset('~thor_data400::base::override::fcra::qa::avm',layout_override_avm1,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),-flag_file_id),except flag_file_id,keep(1));

FCRA.Layout_Override_AVM proj_recs(ds l) := transform
	self := l;
end;

kf := project(ds,proj_recs(left));//dedup(sort(dataset(ut.foreign_prod+'thor_data400::base::override::fcra::qa::avm',fcra.layout_override_avm,flat),-flag_file_id),except flag_file_id,keep(1));

//DF-22458 blank out specifed fields in thor_data400::key::avm_v2::fcra::qa::address
ut.MAC_CLEAR_FIELDS(kf, kf_cleared, AVM_V2.Constants.fields_to_clear);

export Key_Override_AVM_FFID := index(kf_cleared,{flag_file_id}, {kf_cleared},
  '~thor_data400::key::override::fcra::avm::qa::ffid');
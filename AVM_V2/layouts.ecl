export layouts := module


export layout_clean_assessment := record
	string12 ln_fares_id;
	string45 unformatted_apn;
	
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  zip;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string7  geo_blk := '';

	string5 fips_code;
	string4 land_use_code;
	string11 sales_price;
	string1 sales_price_code;
	string8 recording_date;
	string4 assessed_value_year;
	string11 assessed_total_value;
	string11 market_total_value;

	// hedonic charactericts
	string30 lot_size;
	string9 building_area;
	string4	year_built;
	string5	no_of_stories;
	string5	no_of_rooms;
	string5	no_of_bedrooms;
	string7	no_of_baths;	
end;

export layout_hedonic_base := record
	unsigned seq;
	layout_clean_assessment;
end;


export Layout_Automated_Valuations := record
	string8 history_date;
	string12 ln_fares_id_ta;
	string12 ln_fares_id_pi;
	string45 unformatted_apn;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string10 lat;
	string11 long;
	string7 geo_blk;
	string5 fips_code;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer tax_assessment_valuation;
	integer price_index_valuation;
	integer hedonic_valuation;
	integer automated_valuation;
	integer confidence_score;
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
end;

export layout_history_slim := record
	string8 history_date;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer tax_assessment_valuation;
	integer price_index_valuation;
	integer hedonic_valuation;
	integer automated_valuation;
	integer confidence_score;
end;

export max_history := 100;
export layout_base_with_history := record
	Layout_Automated_Valuations;
	dataset(layout_history_slim) history { maxcount(max_history) };
end;

export layout_median_valuations := record
	string8 history_date;
	string12 fips_geo_12;	
	integer8 median_valuation;
end;

export layout_median_history_slim := record
	string8 history_date;
	integer8 median_valuation;
end;

export layout_medians_with_history := record
	layout_median_valuations;
	dataset(layout_median_history_slim) history { maxcount(max_history) };
end;

// keep this in here for any products still outputting this layout
export Layout_AVM_Base_original := record
	string12 ln_fares_id_ta;
	string12 ln_fares_id_pi;
	string45 unformatted_apn;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string10 lat;
	string11 long;
	string7 geo_blk;
	string5 fips_code;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer tax_assessment_valuation;
	integer price_index_valuation;
	integer automated_valuation;
	integer confidence_score;
	integer hedonic_valuation;
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
	integer no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
	integer comp_radius;  // number of miles needed to meet 20 comp minimum
	real sum_hedonic_distance; // sum of the comps' hedonic distance
	real sum_physical_distance; // sum of the comps' physical distance to the subject property
	string1 combo_flag;
	integer median_fips_valuation;  // median valuation of the property's county
	integer median_tract_valuation;  // median valuation of the property's tract (tract=geo_blk[1..6]
	integer median_block_valuation;  // median valuation of the property's block group (blkgrp=geo_blk[7])
end;

export layout_property_hedonic := record
	string12 ln_fares_id;  // for internal testing
	string64 address;
	string30 city;
	string2 st;
	string5 zip;
	STRING10 lat;  // for internal testing of distance
	STRING11 long;  // for internal testing of distance
	real distance;
	string1 land_use_code;
	string25 land_use_description;
	string11 sales_price;
	string8 recording_date;
	string4 assessed_value_year;
	string11 assessed_total_value;
	string11 market_total_value;
	string4	year_built;
	string30 lot_size;
	string9	building_area;
	string5	no_of_rooms;
	string5	no_of_bedrooms;
	string7	no_of_baths;
	string5	no_of_stories;
end;


export max_comparable	:= 5;
export max_nearby			:= 5;

export layout_value_fields := record
  string1 land_use_code;
  string25 land_use_description;
  string8 recording_date;
  string4 assessed_value_year;
  string11 sales_price;  
  string11 assessed_total_value;
  string11 market_total_value;
  integer tax_assessment_valuation;
  integer price_index_valuation;
  integer hedonic_valuation;
  integer automated_valuation;
  integer confidence_score;
  dataset(layout_property_hedonic) comparable	{ maxcount(max_comparable) };
  dataset(layout_property_hedonic) nearby			{ maxcount(max_nearby) };
	dataset(layout_history_slim) history { maxcount(max_history) };
end;

export layout_medians := record
	string12 fips_geo_12;	
	integer8 median_valuation;
end;

export layout_AVM_batchin := record
	UNSIGNED4 seq;
	string30 acctno := '';
	string65 street_addr := ''; 
	STRING10 prim_range := '';
	STRING2  predir := '';
	STRING28 prim_name := '';
	STRING4  suffix := '';
	STRING2  postdir := '';
	STRING10 unit_desig := '';
	STRING8  sec_range := '';
	STRING25 p_city_name := '';
	STRING2  st := '';
	STRING5  z5 := '';
	STRING4  zip4 := '';
	STRING10 lat := '';
	STRING11 long := '';
	string3 county := '';
	string7 geo_blk := '';
	STRING1  addr_type := '';
	STRING4  addr_status := '';
end;

export layout_AVM_batchout := record
	unsigned seq;
	string30 acctno;
	string45 unformatted_apn;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
	string2 st;
	string5 zip;
	string4 zip4;
	string5 fips_code;
	string1 land_use;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer price_index_valuation;
	integer tax_assessment_valuation;
	integer hedonic_valuation;
	integer automated_valuation;
	integer confidence_score;
end;

EXPORT Layout_Override_AVM_Medians := record
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  suffix;
	string2  postdir;
	string10 unit_desig;
	string8  sec_range;
	string25 city_name;
	string2  st;
	string5  zip;
	string12 geolink;
	unsigned median_county_value;
	unsigned median_tract_value;
	unsigned median_block_value;
	STRING20 flag_file_id;
end;

EXPORT Layout_Override_AVM_Address := record
  unsigned6 did;  
  string10 prim_range;
  string2  predir;
  string28 prim_name;
  string4  suffix;
  string2  postdir;
  string10 unit_desig;
  string8  sec_range;
  string25 city_name;
  string2  st;
  string5  zip;
  string4  zip4;
  integer avm_1_yr;
  integer avm_5_yrs;
  integer current_adls_per_address;
  integer current_ssns_per_address;
  integer current_phones_per_address;
	STRING20 flag_file_id;
end;

end;
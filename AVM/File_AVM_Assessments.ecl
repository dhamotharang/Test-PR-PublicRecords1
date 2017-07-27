import ln_property;


search_file := LN_Property.File_Search(ln_fares_id[1]!='R'  and ln_fares_id[2] = 'A' and source_code[2] = 'P' and (integer)zip <> 0);  // search file, assessment records

sfa := distribute(search_file, hash(ln_fares_id));

layout_clean_assessment := record
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

ta_file := ln_property.File_Assessment(ln_fares_id[1]!='R' and state_code in avm.filters.valid_states and avm.filters.valid_date(recording_date)
										and recording_date <= avm.filters.history_date and prior_recording_date <= avm.filters.history_date 
										);
										
ta_base := distribute(ta_file, hash(ln_fares_id));
 
layout_clean_assessment clean_assessment(ta_base le, sfa rt) := transform
	self.ln_fares_id := le.ln_fares_id;
	self.unformatted_apn := avm.filters.stripformat(le.apna_or_pin_number);
	self.fips_code := le.fips_code;
	self.land_use_code := le.standardized_land_use_code;
	
	// impute the sales price from the prior sales if sales price or recording date are missing
	useprior := ((integer)le.sales_price < avm.filters.minimum_sale_price or le.recording_date='') and avm.filters.valid_date(le.prior_recording_date);
	
	self.sales_price := if(useprior, le.prior_sales_price, le.sales_price);
	self.sales_price_code := if(useprior, le.prior_sales_price_code, le.sales_price_code);
	self.recording_date := if(useprior, le.prior_recording_date, le.recording_date);
  
	self.assessed_value_year := le.assessed_value_year;
	self.assessed_total_value := le.assessed_total_value;
	self.market_total_value := le.market_total_value;
	
	self.prim_range := rt.prim_range;
	self.predir := rt.predir;
	self.prim_name := rt.prim_name;
	self.suffix := rt.suffix;
	self.postdir := rt.postdir;
	self.unit_desig := rt.unit_desig;
	self.sec_range := rt.sec_range;
	self.p_city_name := rt.p_city_name;
	self.st := rt.st;
	self.zip := rt.zip;
	self.zip4 := rt.zip4;
	self.lat := rt.geo_lat;
	self.long := rt.geo_long;
	self.geo_blk := rt.geo_blk;
	
	self.lot_size := map(le.land_acres != '' => le.land_acres,
						 le.land_square_footage != '' => le.land_square_footage,
						 le.land_dimensions != '' => le.land_dimensions,
						 '');
	self := le;
end;


// append the clean address and clean the apn to use for linking to assessment records
assessment_slim := join(ta_base, sfa, left.ln_fares_id=right.ln_fares_id, clean_assessment(left,right), left outer, keep(1), local) : persist('temp::avm::assessments');


export File_AVM_Assessments := assessment_slim;
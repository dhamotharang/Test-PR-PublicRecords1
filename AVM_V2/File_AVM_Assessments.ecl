import ln_propertyv2;

export File_AVM_Assessments(string8 history_date) := function

search_file := LN_PropertyV2.File_Search_DID(ln_fares_id[1]!='R'  and ln_fares_id[2] = 'A' and source_code[2] = 'P' and (integer)zip <> 0 
										and trim(county)<>'');  // search file, assessment records

sfa := distribute(search_file, hash(ln_fares_id));

ta_file := LN_PropertyV2.File_Assessment(ln_fares_id[1]!='R' and state_code in avm_v2.filters(history_date).valid_states 
										and avm_v2.filters(history_date).valid_date(recording_date)
										and recording_date <= history_date and prior_recording_date <= history_date);
										
ta_base := distribute(ta_file, hash(ln_fares_id));
 
avm_v2.layouts.layout_clean_assessment clean_assessment(ta_base le, sfa rt) := transform
	self.ln_fares_id := le.ln_fares_id;
	self.unformatted_apn := avm_v2.filters(history_date).stripformat(le.apna_or_pin_number);
	self.fips_code := rt.county;
	self.land_use_code := le.standardized_land_use_code;
	
	// impute the sales price from the prior sales if sales price or recording date are missing
	useprior := ((integer)le.sales_price < avm_v2.filters(history_date).minimum_sale_price or le.recording_date='') 
								and avm_v2.filters(history_date).valid_date(le.prior_recording_date);
	
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
assessment_slim := join(ta_base, sfa, left.ln_fares_id=right.ln_fares_id, clean_assessment(left,right), keep(1), local); 

// if a property doesn't have an apn to search by, or a valid address, remove it
good_assessments := assessment_slim(trim(unformatted_apn)<>'' or 
																		(trim(prim_range)<>'' and trim(prim_name)<>'' and trim(zip) <> '')) : persist('temp::avm_v2::assessments');

return good_assessments;

end;



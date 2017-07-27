import ut;

export File_AVM_PI_Records(string8 history_date) := function

deeds := avm_v2.file_avm_deeds(history_date)(land_use_code in avm_v2.filters(history_date).land_use_codes and recording_date[1..4] > '1995');

assessments := avm_v2.File_AVM_Assessments(history_date)(land_use_code in avm_v2.filters(history_date).land_use_codes
										and sales_price_code not in avm_v2.filters(history_date).bad_sales_price_codes
										and (integer)sales_price>avm_v2.filters(history_date).minimum_sale_price
										and recording_date[1..4] > '1995') ;

// output(count(deeds), named('deed_count'));
// output(count(assessments), named('assessment_count'));

layout_pi_record := record
	unsigned seq;
	string12 ln_fares_id;
	string45  unformatted_apn;
	string60  property_full_street_address;
	string51  property_city_state_zip;
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
	string3  county := '';
	string7  geo_blk := '';
	string5 fips_code;
	string1 land_use;
	string11 sales_price;
	string8 recording_date;	
	string6 quarter;
	integer Price_Index_Valuation;
end;


pi_composite1 := project(deeds,transform(layout_pi_record, 
										self.land_use := if(trim(left.land_use_code) in ['','1000','1001'],'1','2'),
										self.quarter := avm_v2.filters(history_date).quarter_map(left.recording_date);
										self := left, self := []))
										
			  + project(assessments, transform(layout_pi_record, 
										self.land_use := if(trim(left.land_use_code) in ['','1000','1001'],'1','2'),
										self.quarter := avm_v2.filters(history_date).quarter_map(left.recording_date);
										self := left, self := []));
										

pi_composite := distribute(pi_composite1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));

// put the deed and assessment records together and dedup by apn and address
// to make dedup more deterministic, sort by most recent recording date, then by -ln_fares_id[2] to put Deed records ahead of assessments, 
// and then finally by most expensive so each build uses the same sales price if there are 2 deed records on the same day with different sale prices.
// in some very odd cases, the exact same property is coded with different land use codes on different records, add land use code to the sort as well so it always
// picks the same one on each build
pi_sorted := sort(pi_composite, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range,
								-(unsigned)recording_date, -ln_fares_id[2], -(integer)sales_price, -land_use, ln_fares_id, local); 
pi_deduped := dedup(pi_sorted, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range, local);

layout_pi_record add_seq(layout_pi_record le, integer c) := transform
	self.seq := c;
	self := le;
end;
w_seq := project(pi_deduped, add_seq(left, counter));

return w_seq;

end;


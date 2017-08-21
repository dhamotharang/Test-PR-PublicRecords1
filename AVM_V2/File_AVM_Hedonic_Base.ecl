import ut;

export File_AVM_Hedonic_Base(string8 history_date) := function

// hedonic base records must have a tax value to use, valid land use, and lat/long to calculate distance to a comp record
f := avm_v2.File_AVM_Assessments(history_date)(land_use_code in avm_v2.filters(history_date).land_use_codes
										and ( (integer)assessed_total_value > avm_v2.filters(history_date).minimum_sale_price or
										      (integer)market_total_value > avm_v2.filters(history_date).minimum_sale_price)
											and assessed_value_year <= history_date[1..4]		
									    and lat != '' and long !='' );
											  
mapped1 := project(f, transform(recordof(f), 
								self.land_use_code := if(trim(left.land_use_code) in ['1000','1001', ''],'1','2'), // convert the 4 byte land use down to a 1 byte code
								self := left));  


mapped := distribute(mapped1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));


deed_recs := avm_v2.file_avm_deeds(history_date)(land_use_code in avm_v2.filters(history_date).land_use_codes and recording_date != ''
							and recording_date > avm_v2.filters(history_date).recent_sale_for_hedonic_model );  							
										

deed_distr := distribute(deed_recs, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
deed_distr_sorted := sort(deed_distr, unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range,
														-(unsigned)recording_date, -(integer)sales_price, -land_use_code, ln_fares_id, local);
deeds := dedup(deed_distr_sorted, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range, local); 

with_sales_data := join(mapped, deeds, 
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						transform(recordof(f), 
							use_deed := ( (integer)left.sales_price < avm_v2.filters(history_date).minimum_sale_price and (integer)right.sales_price >= avm_v2.filters(history_date).minimum_sale_price ) or
													( (integer)right.sales_price >= avm_v2.filters(history_date).minimum_sale_price  and (unsigned)right.recording_date > (unsigned)left.recording_date );
							self.sales_price := if(use_deed, right.sales_price, left.sales_price), 
							self.recording_date := if(use_deed, right.recording_date, left.recording_date),
							self := left),
						left outer, 
						atmost(left.zip=right.zip and
									left.prim_range=right.prim_range and
									left.predir=right.predir and
									left.prim_name=right.prim_name and
									left.suffix=right.suffix and
									left.postdir=right.postdir and
									left.sec_range=right.sec_range and 
									left.unformatted_apn=right.unformatted_apn,500), 
							keep(1), local); 
						
sales_data_distr := distribute(with_sales_data, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));

// keep only 1 record per property, sort by assessed_year desc to hold onto the most recent assessed record for that property
sorted_recs := sort(sales_data_distr, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range,
												-(unsigned)assessed_value_year, -land_use_code, ln_fares_id, local); 
unique_recs := dedup(sorted_recs, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range, local); 


AVM_V2.layouts.layout_hedonic_base add_seq(f le, integer c) := transform
	self.seq := c;
	self := le;
end;

w_seq := project(unique_recs, add_seq(left, counter)) : persist('temp::avm_v2::hedonic::base');

return w_seq;

end;

import ut;

export File_TA_Ratios(string8 history_date) := function
					
ta_base := distribute(avm_v2.file_TA_BaseTable(history_date), hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));						

// join to deeds to impute the sales price if sales price or recording date are missing
	
	valid_deeds := avm_v2.file_avm_deeds(history_date)(recording_date > avm_v2.filters(history_date).recent_sale_for_TA_ratio);
	
	deeds1 := distribute(valid_deeds, 
							hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
	
	sorted_recs := sort(deeds1, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range,-recording_date, -(integer)sales_price, ln_fares_id, local); 
	deduped_deeds := dedup(sorted_recs, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, sec_range, local); 

	l := record
		ta_base;
	end;

	l tf1(ta_base le, deduped_deeds rt) := transform
		usedeed := ( (integer)le.sales_price < avm_v2.filters(history_date).minimum_sale_price and (integer)rt.sales_price >= avm_v2.filters(history_date).minimum_sale_price ) or
													( (integer)rt.sales_price >= avm_v2.filters(history_date).minimum_sale_price  and (unsigned)rt.recording_date > (unsigned)le.recording_date );						
		self.sales_price := if(usedeed, rt.sales_price, le.sales_price);
		self.recording_date := if(usedeed, rt.recording_date, le.recording_date);
		self := le;
	end;


	w_imputed_sales := join(ta_base, deduped_deeds,
							left.zip=right.zip and
							left.prim_range=right.prim_range and
							left.predir=right.predir and
							left.prim_name=right.prim_name and
							left.suffix=right.suffix and
							left.postdir=right.postdir and
							left.sec_range=right.sec_range and 
							left.unformatted_apn=right.unformatted_apn,
							tf1(left,right),
							left outer, 
							
							atmost(left.zip=right.zip and
									left.prim_range=right.prim_range and
									left.predir=right.predir and
									left.prim_name=right.prim_name and
									left.suffix=right.suffix and
									left.postdir=right.postdir and
									left.sec_range=right.sec_range and 
									left.unformatted_apn=right.unformatted_apn,1000), 
							keep(1), local);  

		
filtered_recs := w_imputed_sales(sales_price_code not in avm_v2.filters(history_date).bad_sales_price_codes
										and recording_date > avm_v2.filters(history_date).recent_sale_for_TA_ratio 
										and (integer)sales_price>avm_v2.filters(history_date).minimum_sale_price);	

									
return filtered_recs;

end;

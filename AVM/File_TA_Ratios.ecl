import ut;
					
ta_base := distribute(avm.file_TA_BaseTable, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));						

// join to deeds to impute the sales price if sales price or recording date are missing
	
	deeds1 := distribute(avm.file_avm_deeds(recording_date > avm.filters.recent_sale_for_TA_ratio), 
							hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));
	
	sorted_recs := sort(deeds1, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range,-recording_date, local); 
	deeds := dedup(sorted_recs, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, local); 

	l := record
		ta_base;
	end;

	l tf1(ta_base le, avm.file_avm_deeds rt) := transform
		usedeed := ((integer)le.sales_price < avm.filters.minimum_sale_price or le.recording_date='') and 
				   ((integer)rt.sales_price > avm.filters.minimum_sale_price and rt.recording_date!='');
		self.sales_price := if(usedeed, rt.sales_price, le.sales_price);
		self.recording_date := if(usedeed, rt.recording_date, le.recording_date);
		self := le;

	end;


	w_imputed_sales := join(ta_base, deeds,
							left.zip=right.zip and
							left.prim_range=right.prim_range and
							left.predir=right.predir and
							left.prim_name=right.prim_name and
							left.suffix=right.suffix and
							left.postdir=right.postdir and
							ut.nneq(left.unit_desig,right.unit_desig) and
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
									left.unformatted_apn=right.unformatted_apn,500), 
							keep(1), local);  

		
filtered_recs := w_imputed_sales(sales_price_code not in avm.filters.bad_sales_price_codes
										and recording_date > avm.filters.recent_sale_for_TA_ratio 
										and (integer)sales_price>avm.filters.minimum_sale_price);	

									
export File_TA_Ratios := filtered_recs;
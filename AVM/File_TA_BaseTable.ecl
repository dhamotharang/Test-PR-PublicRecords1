
f := avm.File_AVM_Assessments(land_use_code in avm.filters.land_use_codes
										and assessed_value_year > '2002' and assessed_value_year <= avm.filters.history_date[1..4]
										
										and ( (integer)assessed_total_value > avm.filters.minimum_sale_price or
										      (integer)market_total_value > avm.filters.minimum_sale_price) );
											  
mapped1 := project(f, transform(recordof(f), 
								self.land_use_code := if(trim(left.land_use_code) in ['','1000','1001'],'1','2'), // convert the 4 byte land use down to a 1 byte code
								self := left));  

mapped := distribute(mapped1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));


sorted_recs := sort(mapped, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range,-assessed_value_year, local); 
unique_recs := dedup(sorted_recs, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, assessed_value_year, local); 


export File_TA_BaseTable := unique_recs;
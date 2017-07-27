import ut;

// hedonic base records must have a tax value to use, valid land use, and lat/long to calculate distance to a comp record
f := avm.File_AVM_Assessments(land_use_code in avm.filters.land_use_codes
										and ( (integer)assessed_total_value > avm.filters.minimum_sale_price or
										      (integer)market_total_value > avm.filters.minimum_sale_price)
									    and lat != '' and long !='' );
											  
mapped1 := project(f, transform(recordof(f), 
								self.land_use_code := if(trim(left.land_use_code) in ['1000','1001', ''],'1','2'), // convert the 4 byte land use down to a 1 byte code
								self := left));  

mapped := distribute(mapped1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));


deed_recs := avm.file_avm_deeds(land_use_code in avm.filters.land_use_codes and recording_date != ''
							and recording_date > avm.filters.recent_sale_for_hedonic_model );  							
										

deed_distr := distribute(deed_recs, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));
deed_distr_sorted := sort(deed_distr, unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range,-recording_date, local);
deeds := dedup(deed_distr_sorted, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, local); 

with_sales_data := join(mapped, deeds, 
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						ut.nneq(left.unit_desig,right.unit_desig) and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						transform(recordof(f), self.sales_price := if((integer)left.sales_price=0, right.sales_price, left.sales_price), 
											   self.recording_date := if(trim(left.recording_date)='', right.recording_date, left.recording_date),
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
						
        


sales_data_distr := distribute(with_sales_data, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));

// keep only 1 record per property, sort by assessed_year desc to hold onto the most recent assessed record for that property
sorted_recs := sort(sales_data_distr, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range,-assessed_value_year, local); 
unique_recs := dedup(sorted_recs, unformatted_apn, zip, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, local); 


layout_ta_hedonic := record
	unsigned seq;
	avm.File_AVM_Assessments;
end;

layout_ta_hedonic add_seq(f le, integer c) := transform
	self.seq := c;
	self := le;
end;

w_seq := project(unique_recs, add_seq(left, counter)) : persist('temp::avm_hedonic::base');

export File_AVM_Hedonic_Base := w_seq;
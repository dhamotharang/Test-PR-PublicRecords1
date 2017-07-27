export File_AVM_Medians(dataset(AVM_V2.layouts.Layout_Automated_Valuations) valuations_base, string8 history_date) := function

/* *************************************************************

Append the geographic medians to each record where available
Modelers will use these geographic medians to compare to property valuation
   
***************************************************************/								
avm_medians := record
	string5 fips_code;
	unsigned fips_code_seq;
	
	string12 fips_geo_12;
	unsigned fips_geo_12_seq;

	string11 fips_geo_11;
	unsigned fips_geo_11_seq;
	
	string1 land_use;
	integer8 automated_valuation;
end;

avm_medians add_geo(valuations_base le) := transform	
	self.fips_geo_12 := le.fips_code + le.geo_blk; 
	self.fips_geo_11 := le.fips_code + le.geo_blk[1..6];
	self := le;
	self := [];
end;

// initial medians code to use the removed_outliers dataset and only records which have geo_blk and fips populated.
// they may want to change to use 'blended' dataset, before outliers and low confidence score records were removed.
a := project(valuations_base(automated_valuation!=0 and fips_code<> '' and geo_blk<>''), add_geo(left));  																	
	
fips1 := distribute(a, hash(fips_code,land_use));
fips2 := group(sort(fips1, fips_code, land_use, automated_valuation, local), fips_code, land_use, local);
fips3 := table(fips2, {fips_code,land_use, total := count(group)});

avm_medians tf_fips(avm_medians le, avm_medians rt, integer C) := transform
	self.fips_code_seq := c;
	self := rt;
end;
fips4 := iterate(fips2,tf_fips(left,right,counter));

layout_fips := record
	string5 fips_code;
	string1 land_use;
	unsigned fips_code_count;	
	integer8 median_valuation;
end;
fips5 := join(fips4, fips3, left.fips_code=right.fips_code and left.land_use=right.land_use and left.fips_code_seq=round(right.total*0.50),     
						transform(layout_fips, self.fips_code_count := right.total, 
																self.median_valuation := left.automated_valuation,
																self := left, self := []), lookup);

fips := fips5(fips_code_count > avm_v2.filters(history_date).minimum_median_count);							
// output(fips,,'~thor_data400::avm_v2::avm_fipscode_medians', __compressed__, overwrite);
  
 
fipsgeo11_1 := distribute(a(fips_geo_11!=''), hash(fips_geo_11,land_use));
fipsgeo11_2 := group(sort(fipsgeo11_1, fips_geo_11, land_use, automated_valuation, local), fips_geo_11, land_use, local);
fipsgeo11_3 := table(fipsgeo11_2, {fips_geo_11,land_use, total := count(group)});

avm_medians tf_fipsgeo11(avm_medians le, avm_medians rt, integer C) := transform
	self.fips_geo_11_seq := c;
	self := rt;
end;
fipsgeo11_4 := iterate(fipsgeo11_2,tf_fipsgeo11(left,right,counter));

layout_fipsgeo11 := record
	string11 fips_geo_11;
	string1 land_use;
	unsigned fips_geo_11_count;	
	integer8 median_valuation;
end;
fipsgeo11_5 := join(fipsgeo11_4, fipsgeo11_3, left.fips_geo_11=right.fips_geo_11 and left.land_use=right.land_use and left.fips_geo_11_seq=round(right.total*0.50),     
						transform(layout_fipsgeo11, self.fips_geo_11_count := right.total, 
																self.median_valuation := left.automated_valuation,
																self := left, self := []), lookup);
fipsgeo11 := fipsgeo11_5(fips_geo_11_count > avm_v2.filters(history_date).minimum_median_count);								
// output(fipsgeo11,,'~thor_data400::avm_v2::avm_fips_geo11_medians', __compressed__, overwrite);

  
fipsgeo12_1 := distribute(a(fips_geo_12!=''), hash(fips_geo_12,land_use));
fipsgeo12_2 := group(sort(fipsgeo12_1, fips_geo_12, land_use, automated_valuation, local), fips_geo_12, land_use, local);
fipsgeo12_3 := table(fipsgeo12_2, {fips_geo_12,land_use, total := count(group)});

avm_medians tf_fipsgeo12(avm_medians le, avm_medians rt, integer C) := transform
	self.fips_geo_12_seq := c;
	self := rt;
end;
fipsgeo12_4 := iterate(fipsgeo12_2,tf_fipsgeo12(left,right,counter));

layout_fipsgeo12 := record
	string12 fips_geo_12;
	string1 land_use;
	unsigned fips_geo_12_count;	
	integer8 median_valuation;
end;
fipsgeo12_5 := join(fipsgeo12_4, fipsgeo12_3, left.fips_geo_12=right.fips_geo_12 and left.land_use=right.land_use and left.fips_geo_12_seq=round(right.total*0.50),     
						transform(layout_fipsgeo12, self.fips_geo_12_count := right.total, 
																self.median_valuation := left.automated_valuation,
																self := left, self := []), lookup);
fipsgeo12 := fipsgeo12_5(fips_geo_12_count > avm_v2.filters(history_date).minimum_median_count);												
// output(fipsgeo12,,'~thor_data400::avm_v2::avm_fips_geo12_medians', __compressed__, overwrite);


	// integer median_fips_valuation;  // median valuation of the property's county
	// integer median_tract_valuation;  // median valuation of the property's tract (tract=geo_blk[1..6]
	// integer median_block_valuation;  // median valuation of the property's block group (blkgrp=geo_blk[7])
	

// combine all medians into 1 table, and search them by the geography you're looking for
// ie:  you want median for fipscode = '27145', pad the last 7 with spaces.  
// There is only 1 record per geography, going on the requirement from modelers to use land_use = 1 
// this will give you the single family dwelling median they're looking for

mcounty := project(fips(land_use='1'), transform(avm_v2.layouts.layout_median_valuations, self.fips_geo_12 := left.fips_code,
								self.median_valuation := left.median_valuation, self.history_date := history_date) );
m11 := project(fipsgeo11(land_use='1'), transform(avm_v2.layouts.layout_median_valuations, self.fips_geo_12 := left.fips_geo_11,
								self.median_valuation := left.median_valuation, self.history_date := history_date) );
m12 := project(fipsgeo12(land_use='1'), transform(avm_v2.layouts.layout_median_valuations, self.fips_geo_12 := left.fips_geo_12,
								self.median_valuation := left.median_valuation, self.history_date := history_date) );
mcombined := mcounty + m11 + m12;

return mcombined;

end;
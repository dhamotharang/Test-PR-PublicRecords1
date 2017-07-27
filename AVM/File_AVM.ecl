import avm, ut;

pi := avm.File_PI_Valuations;
ta := avm.File_TA_Valuations;
hedonic := avm.File_Hedonic_Valuations;

// filter out useless records from ta and pi before the distributions
valuated_ta1 := ta(tax_assessment_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));
valuated_pi1 := pi(price_index_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));
valuated_hedonic1 := hedonic(hedonic_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));

valuated_ta := distribute(valuated_ta1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));
valuated_pi := distribute(valuated_pi1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));
valuated_hedonic := distribute(valuated_hedonic1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));

merged_rec := record
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
  real sum_physical_distance; // sum of the comps' physical distance to the subject propertyend;
  string1 combo_flag;
end;

merged_rec merge_files(valuated_ta le, valuated_pi rt) := transform
	//assume we're using the assessment record unless it's not present
	use_pi := le.fips_code='';
	self.ln_fares_id_ta := le.ln_fares_id;
	self.ln_fares_id_pi := rt.ln_fares_id;
	self.unformatted_apn := if(use_pi, rt.unformatted_apn , le.unformatted_apn );
	self.prim_range := if(use_pi, rt.prim_range , le.prim_range );
	self.predir := if(use_pi, rt.predir , le.predir );
	self.prim_name := if(use_pi, rt.prim_name , le.prim_name );
	self.suffix := if(use_pi, rt.suffix , le.suffix );
	self.postdir := if(use_pi, rt.postdir , le.postdir );
	self.unit_desig := if(use_pi, rt.unit_desig , le.unit_desig );
	self.sec_range := if(use_pi, rt.sec_range , le.sec_range );
	self.p_city_name := if(use_pi, rt.p_city_name , le.p_city_name );
	self.st := if(use_pi, rt.st , le.st );
	self.zip := if(use_pi, rt.zip , le.zip );
	self.zip4 := if(use_pi, rt.zip4 , le.zip4 );
	self.lat := if(use_pi, rt.lat , le.lat );
	self.long := if(use_pi, rt.long , le.long );
	self.geo_blk := if(use_pi, rt.geo_blk , le.geo_blk );
	self.fips_code := if(use_pi, rt.fips_code , le.fips_code );
	self.land_use := if(use_pi, rt.land_use , le.land_use );
	
	// only care about recording date and sales price that come from PI model calculation
	self.recording_date := rt.recording_date;
	self.sales_price :=  rt.sales_price;  
	self.price_index_valuation := rt.price_index_valuation;
	
	self.tax_assessment_valuation := le.tax_assessment_valuation;
	self.assessed_value_year := le.assessed_value_year;
	self.assessed_total_value := le.assessed_total_value;
	self.market_total_value := le.market_total_value;
	
	self := [];
end;  

merged1 := join(valuated_ta, valuated_pi,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.unit_desig=right.unit_desig and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						merge_files(left,right),
						full outer, 
						limit(50), local);
									
	
merged_distr :=  distribute(merged1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));	

merged_rec add_hedonic(merged_rec le, valuated_hedonic rt) := transform	
	self.hedonic_valuation := rt.hedonic_valuation;
	self.comp1 := rt.comp1;
	self.comp2 := rt.comp2;
	self.comp3 := rt.comp3;
	self.comp4 := rt.comp4;
	self.comp5 := rt.comp5;
	self.nearby1 := rt.nearby1;
	self.nearby2 := rt.nearby2;
	self.nearby3 := rt.nearby3;
	self.nearby4 := rt.nearby4;
	self.nearby5 := rt.nearby5;
	self.no_of_comps := rt.no_of_comps; 
	self.comp_radius := rt.comp_radius;
	self.sum_hedonic_distance := rt.sum_hedonic_distance; 
	self.sum_physical_distance := rt.sum_physical_distance; 
	
	use_hedonic := le.fips_code='';
	self.ln_fares_id_ta := if(use_hedonic, rt.ln_fares_id, le.ln_fares_id_ta);
	self.unformatted_apn := if(use_hedonic, rt.unformatted_apn , le.unformatted_apn );
	self.prim_range := if(use_hedonic, rt.prim_range , le.prim_range );
	self.predir := if(use_hedonic, rt.predir , le.predir );
	self.prim_name := if(use_hedonic, rt.prim_name , le.prim_name );
	self.suffix := if(use_hedonic, rt.suffix , le.suffix );
	self.postdir := if(use_hedonic, rt.postdir , le.postdir );
	self.unit_desig := if(use_hedonic, rt.unit_desig , le.unit_desig );
	self.sec_range := if(use_hedonic, rt.sec_range , le.sec_range );
	self.p_city_name := if(use_hedonic, rt.p_city_name , le.p_city_name );
	self.st := if(use_hedonic, rt.st , le.st );
	self.zip := if(use_hedonic, rt.zip , le.zip );
	self.zip4 := if(use_hedonic, rt.zip4 , le.zip4 );
	self.lat := if(use_hedonic, rt.lat , le.lat );
	self.long := if(use_hedonic, rt.long , le.long );
	self.geo_blk := if(use_hedonic, rt.geo_blk , le.geo_blk );
	
	self.fips_code := if(use_hedonic, rt.fips_code , le.fips_code );
	self.land_use := if(use_hedonic, rt.land_use_code , le.land_use );
	
	self.recording_date := if(trim(le.recording_date)='', rt.recording_date , le.recording_date );
	self.sales_price := if((integer)le.sales_price=0, rt.sales_price , le.sales_price );  
	self.assessed_value_year := if(trim(le.assessed_value_year)='', rt.assessed_value_year, le.assessed_value_year);
	self.assessed_total_value := if((integer)le.assessed_total_value=0, rt.assessed_total_value, le.assessed_total_value);
	self.market_total_value := if((integer)le.market_total_value=0, rt.market_total_value, le.market_total_value);
	
	self := le;
	
end; 

merged := join(merged_distr, valuated_hedonic,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.unit_desig=right.unit_desig and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						add_hedonic(left,right),
						full outer, 
						limit(50), local); 	
						

merged_rec add_blending(merged le, avm.File_Model_Accuracy_Table rt) := transform
	pi_pop := le.price_index_valuation<>0;
	ta_pop := le.tax_assessment_valuation<>0;
	hedonic_pop := le.hedonic_valuation<>0;
	
	pi_confidence := if(pi_pop, rt.pi_accuracy, 0);
	ta_confidence := if(ta_pop, rt.ta_accuracy, 0);
	hedonic_confidence := if(hedonic_pop, rt.hedonic_accuracy, 0);
		
	combo_rule := map(pi_confidence<>0 or ta_confidence<>0 or hedonic_confidence<>0 => '1',
						hedonic_pop => '2',
						ta_pop => '3',
						pi_pop => '4',
						'0');
					  
	self.combo_flag := combo_rule; 
	
	model_selected := map(	(combo_rule='1' and hedonic_confidence >= ta_confidence and hedonic_confidence >= pi_confidence)
								 or combo_rule='2' => 'H',
						    (combo_rule='1' and ta_confidence >= hedonic_confidence and ta_confidence >= pi_confidence)
							     or combo_rule='3' => 'T',
							(combo_rule='1' and pi_confidence >= hedonic_confidence and pi_confidence >= ta_confidence)
								 or combo_rule='4' => 'P',
							'');

	self.automated_valuation := map(model_selected='H' => le.hedonic_valuation,
									model_selected='T' => le.tax_assessment_valuation,
									model_selected='P' => le.price_index_valuation,
									0);
									
	cs := map(model_selected='H' and combo_rule='1' => round(hedonic_confidence*100),
			  model_selected='H' and combo_rule='2' => 26,
			  model_selected='T' and combo_rule='1' => round(ta_confidence*100),
			  model_selected='T' and combo_rule='3' => 24,
			  model_selected='P' and combo_rule='1' => round(pi_confidence*100),
			  model_selected='P' and combo_rule='4' => 22,
				0);	
	// cap the confidence score at 99, don't want to say we're 100% confident about any AVM			
	self.confidence_score := if(cs > 99, 99, cs);
	
	self := le;
end;		
					
blended := join(merged, avm.File_Model_Accuracy_Table, 
				left.fips_code=right.fips_code and
				left.land_use=right.land_use,
				add_blending(left,right), left outer, lookup);
				
output(blended,,'~thor_data400::avm::avm_base_full', __compressed__, overwrite);	

// filter out any records that don't have a confidence score of at least 30
cutoff := blended(confidence_score >= 25);

r := record
  string5 fips_code;
  integer8 sales_price;
  integer8 assessed_total_value;
  integer8 market_total_value;
end;

samp := project(cutoff, transform(r, self.sales_price := (integer)left.sales_price,
						self.assessed_total_value := (integer)left.assessed_total_value,
						self.market_total_value := (integer)left.market_total_value,
						self := left));

// filter out any records that have sales or assessment data more than 2 times the standard deviation for that county
stat_layout := record
	fips_code := samp.fips_code;
	record_count     := COUNT(GROUP);
	 
	sales_mean := ave(group, samp.sales_price);
	sales_std_dev := sqrt(variance(group, samp.sales_price));
	
	assessed_value_mean := ave(group, samp.assessed_total_value);
	assessed_value_std_dev := sqrt(variance(group, samp.assessed_total_value));
	
	market_value_mean := ave(group, samp.market_total_value);
	market_value_std_dev := sqrt(variance(group, samp.market_total_value));
end;

deviation_stats := TABLE(samp, stat_layout, fips_code, few); 
// output(stats, all, named('standard_deviation_stats'));

merged_rec skip_outliers(cutoff le, deviation_stats rt) := transform
	a_val := (integer)le.assessed_total_value;
	m_val := (integer)le.market_total_value;
	s_val := (integer)le.sales_price;
	
	a_val_outlier := ( a_val>0 and rt.assessed_value_mean>0 ) and abs(a_val - rt.assessed_value_mean) > (2 * rt.assessed_value_std_dev);
	m_val_outlier := ( m_val>0 and rt.market_value_mean>0 ) and abs(m_val - rt.market_value_mean) > (2 * rt.market_value_std_dev);
	s_val_outlier := ( s_val>0 and rt.sales_mean>0 ) and abs(s_val - rt.sales_mean) > (2 * rt.sales_std_dev);

	outlier_2std := a_val_outlier or m_val_outlier or s_val_outlier;
	
	self.automated_valuation := if(outlier_2std, skip, le.automated_valuation);
	self := le;
end;

removed_outliers := join(cutoff, deviation_stats, left.fips_code=right.fips_code,
						 skip_outliers(left,right),
						 left outer, lookup);



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

avm_medians add_geo(removed_outliers le) := transform	
	self.fips_geo_12 := le.fips_code + le.geo_blk; 
	self.fips_geo_11 := le.fips_code + le.geo_blk[1..6];
	self := le;
	self := [];
end;

// initial medians code to use the removed_outliers dataset and only records which have geo_blk and fips populated.
// they may want to change to use 'blended' dataset, before outliers and low confidence score records were removed.
a := project(removed_outliers(automated_valuation!=0 and fips_code<> '' and geo_blk<>''), add_geo(left));  																	
	
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

fips := fips5(fips_code_count > filters.minimum_median_count);							
output(fips,,'~thor_data400::avm::avm_fipscode_medians', __compressed__, overwrite);
  
 
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
fipsgeo11 := fipsgeo11_5(fips_geo_11_count > filters.minimum_median_count);								
output(fipsgeo11,,'~thor_data400::avm::avm_fips_geo11_medians', __compressed__, overwrite);

  
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
fipsgeo12 := fipsgeo12_5(fips_geo_12_count > filters.minimum_median_count);												
output(fipsgeo12,,'~thor_data400::avm::avm_fips_geo12_medians', __compressed__, overwrite);


// now append the calculated median values by geography

	// integer median_fips_valuation;  // median valuation of the property's county
	// integer median_tract_valuation;  // median valuation of the property's tract (tract=geo_blk[1..6]
	// integer median_block_valuation;  // median valuation of the property's block group (blkgrp=geo_blk[7])
	
avm.Layout_AVM_Base append_median_fips(removed_outliers le, fips rt) := transform
	self.median_fips_valuation := rt.median_valuation;
	self := le;
	self := [];
end;

w_median_fips := join(removed_outliers, fips, 
						left.fips_code=right.fips_code and left.land_use=right.land_use,
						append_median_fips(left,right), left outer, lookup);


avm.Layout_AVM_Base append_median_tracts(w_median_fips le, fipsgeo11 rt) := transform
	self.median_tract_valuation := rt.median_valuation;
	self := le;
	self := [];
end;

w_median_tracts := join(w_median_fips, fipsgeo11, 
						left.land_use=right.land_use and
						(left.fips_code + left.geo_blk[1..6]) = right.fips_geo_11,
						append_median_tracts(left,right), left outer, lookup);
						

avm.Layout_AVM_Base append_median_blocks(w_median_tracts le, fipsgeo12 rt) := transform
	self.median_block_valuation := rt.median_valuation;
	self := le;
	self := [];
end;

w_median_blocks := join(w_median_tracts, fipsgeo12, 
						left.land_use=right.land_use and
						(left.fips_code + left.geo_blk) = right.fips_geo_12,
						append_median_blocks(left,right), left outer, lookup);


// output(removed_outliers,,'~thor_data400::avm::avm_base_removed_outliers', __compressed__);
// export File_AVM := removed_outliers;
						
ut.mac_sf_buildprocess(w_median_blocks, '~thor_data400::base::avm', build_avm_base, 2,, true);

export File_AVM := build_avm_base;
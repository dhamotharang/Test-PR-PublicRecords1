import ut;

export File_AVM(string8 history_date) := function

pi := avm_v2.File_PI_Valuations(history_date);
ta := avm_v2.File_TA_Valuations(history_date);
hedonic := avm_v2.File_Hedonic_Valuations(history_date);

// filter out useless records from ta and pi before the distributions
valuated_ta1 := ta(tax_assessment_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));
valuated_pi1 := pi(price_index_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));
valuated_hedonic1 := hedonic(hedonic_valuation!=0 and (prim_range<>'' or prim_name<>'' or sec_range<>'' or zip<>'' or unformatted_apn<>''));

valuated_ta := distribute(valuated_ta1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
valuated_pi := distribute(valuated_pi1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));
valuated_hedonic := distribute(valuated_hedonic1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));

merged_rec := record
	AVM_V2.layouts.Layout_Automated_Valuations;
	
	// these fields used for the blending logic
  integer no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
  integer comp_radius;  // number of miles needed to meet 20 comp minimum
  real sum_hedonic_distance; // sum of the comps' hedonic distance
  real sum_physical_distance; // sum of the comps' physical distance to the subject propertyend;
  string1 combo_flag;
	integer Market_Value_Valuation;
	integer Assessed_Value_Valuation;
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
	
	// new fields for testing new accuracy table structure
	self.Market_Value_Valuation := le.Market_Value_Valuation;
	self.Assessed_Value_Valuation := le.Assessed_Value_Valuation;
	self := [];
end;  

merged1 := join(valuated_ta, valuated_pi,
						left.zip=right.zip and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						merge_files(left,right),
						full outer, 
						limit(50), local);
									
	
merged_distr :=  distribute(merged1, hash(unformatted_apn,zip,prim_range,prim_name,predir,suffix,postdir,sec_range));	

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
						left.sec_range=right.sec_range and 
						left.unformatted_apn=right.unformatted_apn,
						add_hedonic(left,right),
						full outer, 
						limit(50), local); 	
						

merged_rec add_blending(merged le, avm_v2.File_Model_Accuracy_Table rt) := transform
	pi_pop := le.price_index_valuation<>0;
	ta_pop := le.tax_assessment_valuation<>0;
	hedonic_pop := le.hedonic_valuation<>0;
		
	months_since_sale := ut.DaysApart(history_date,le.recording_date)/avm_v2.filters(history_date).days_in_a_month;

	pi_accuracy := if(rt.pi_bin1_cap in [0, avm_v2.filters(history_date).default_max_bin],  // if the cap isn't populated, use the overall accuracy
										rt.overall_pi_accuracy, 
										map(months_since_sale <= rt.pi_bin1_cap => rt.pi_bin1_accuracy,
												months_since_sale <= rt.pi_bin2_cap => rt.pi_bin2_accuracy,
												months_since_sale <= rt.pi_bin3_cap => rt.pi_bin3_accuracy,
												rt.pi_bin4_accuracy) );							 
	pi_confidence := if(pi_pop, pi_accuracy, 0);
	
	
	//ta_accuracy := higher of assessed_value confidence or market_value confidence
	// whichever is selected, populate the tax_assessment_valuation with the higher confidence
	assessed_value := (integer)le.assessed_total_value;
	assessed_accuracy := map(assessed_value=0 => 0,  // if we don't have assessed value on this record, set the accuracy to 0
													rt.assessed_bin1_cap in [0, avm_v2.filters(history_date).default_max_bin] => rt.overall_assessed_accuracy, // if the cap isn't populated, use the overall accuracy
													assessed_value <= rt.assessed_bin1_cap => rt.assessed_bin1_accuracy,
													assessed_value <= rt.assessed_bin2_cap => rt.assessed_bin2_accuracy,
													assessed_value <= rt.assessed_bin3_cap => rt.assessed_bin3_accuracy,
													rt.assessed_bin4_accuracy);
													
	market_value := (integer)le.market_total_value;
	market_accuracy := map(market_value=0 => 0,  // if we don't have market value on this record, set the accuracy to 0
													rt.market_bin1_cap in [0, avm_v2.filters(history_date).default_max_bin] => rt.overall_market_accuracy, // if the cap isn't populated, use the overall accuracy
													market_value <= rt.market_bin1_cap => rt.market_bin1_accuracy,
													market_value <= rt.market_bin2_cap => rt.market_bin2_accuracy,
													market_value <= rt.market_bin3_cap => rt.market_bin3_accuracy,
													rt.market_bin4_accuracy);
	
	best_ta_valuation := if(market_accuracy >= assessed_accuracy, le.market_value_valuation, le.assessed_value_valuation);
	ta_accuracy := max(market_accuracy, assessed_accuracy);
	self.tax_assessment_valuation := best_ta_valuation;
	
	ta_confidence := if(ta_pop, ta_accuracy, 0);
	
	hedonic_accuracy := if(rt.hedonic_bin1_cap in [0, avm_v2.filters(history_date).default_max_bin],  // if the cap isn't populated, use the overall accuracy
										rt.overall_hedonic_accuracy, 
										map(le.sum_physical_distance <= rt.hedonic_bin1_cap => rt.hedonic_bin1_accuracy,
												le.sum_physical_distance <= rt.hedonic_bin2_cap => rt.hedonic_bin2_accuracy,
												le.sum_physical_distance <= rt.hedonic_bin3_cap => rt.hedonic_bin3_accuracy,
												rt.hedonic_bin4_accuracy) );	
	
	hedonic_confidence := if(hedonic_pop, hedonic_accuracy, 0);
		
	combo_rule := map(
						months_since_sale < 6 and pi_pop => '5',
						pi_confidence<>0 or ta_confidence<>0 or hedonic_confidence<>0 => '1',
						hedonic_pop => '2',
						ta_pop => '3',
						pi_pop => '4',
						'0');
					  
	self.combo_flag := combo_rule; 
		
	model_selected := map(	
								combo_rule='5' => 'P',  // PI override for recent sale
								(combo_rule='1' and hedonic_confidence >= ta_confidence and hedonic_confidence >= pi_confidence)
								 or combo_rule='2' => 'H',
						    (combo_rule='1' and ta_confidence >= hedonic_confidence and ta_confidence >= pi_confidence)
							     or combo_rule='3' => 'T',
							(combo_rule='1' and pi_confidence >= hedonic_confidence and pi_confidence >= ta_confidence)
								 or combo_rule='4' => 'P',
							'');
	
	self.automated_valuation := map(model_selected='H' => le.hedonic_valuation,
									model_selected='T' => best_ta_valuation,
									model_selected='P' => le.price_index_valuation,
									0);
									
	cs := map(
				model_selected='P' and combo_rule='5' => 85,
				model_selected='H' and combo_rule='1' => round(hedonic_confidence*100),
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
					
blended := join(merged, avm_v2.File_Model_Accuracy_Table, 
				left.fips_code=right.fips_code and
				left.land_use=right.land_use,
				add_blending(left,right), left outer, lookup);
				
// output(blended,,'~thor_data400::avm_v2::avm_base_full_' + history_date, __compressed__, overwrite);	

// filter out any records that don't have a confidence score of at least 25 and anything over 20 Million bucks
cutoff := blended(confidence_score >= 25 and automated_valuation < 20000000);

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

AVM_V2.layouts.Layout_Automated_Valuations skip_outliers(cutoff le, deviation_stats rt) := transform
	self.history_date := history_date;
	a_val := (integer)le.assessed_total_value;
	m_val := (integer)le.market_total_value;
	s_val := (integer)le.sales_price;
	
	a_val_outlier := ( a_val>0 and rt.assessed_value_mean>0 ) and abs(a_val - rt.assessed_value_mean) > (2 * rt.assessed_value_std_dev);
	m_val_outlier := ( m_val>0 and rt.market_value_mean>0 ) and abs(m_val - rt.market_value_mean) > (2 * rt.market_value_std_dev);
	s_val_outlier := ( s_val>0 and rt.sales_mean>0 ) and abs(s_val - rt.sales_mean) > (2 * rt.sales_std_dev);

	outlier_2std := a_val_outlier or m_val_outlier or s_val_outlier;
	
	self.automated_valuation := if(outlier_2std, skip, le.automated_valuation);
	
	// sale within the last 12 months, add 20 pts
	// sale within the last 13-24 months, add 10 pts
	// sale within the last 25-36 months, add 5 pts
	cs := le.confidence_score;
	adjusted_from_recent_sale := map(
										cs >= 70 => cs,
										le.recording_date > avm_v2.filters(history_date).days_ago_365 => cs + 20,
									  le.recording_date > avm_v2.filters(history_date).days_ago_731 => cs + 10,
									  le.recording_date > avm_v2.filters(history_date).days_ago_1095 => cs + 5,
									  cs);
	
	valuation_count := if(le.price_index_valuation<>0, 1, 0) +
					   if(le.tax_assessment_valuation<>0, 1, 0)  + 
					   if(le.hedonic_valuation<>0, 1, 0);
	
	valuation_adjustment := valuation_count * 5;
	
	// if confidence score is still less than 50, add 5 points per valuation calcuated
	tweaked_score := if(adjusted_from_recent_sale < 50, adjusted_from_recent_sale + valuation_adjustment, adjusted_from_recent_sale);
	
	self.confidence_score := if(cs >= 70, cs, tweaked_score);
	
	self := le;
end;

removed_outliers := join(cutoff, deviation_stats, left.fips_code=right.fips_code,
						 skip_outliers(left,right),
						 left outer, lookup);

output(removed_outliers,,'~thor_data400::avm_v2::file_avm', __compressed__, overwrite);
return removed_outliers;

end;
ox := record
	unsigned seq;
	string5 fips_code;
	string1 land_use;
	string4 land_use_raw;
	string8 recent_sale_date;
	integer recent_sale_price;
	
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
	string3 county;
	string7 geo_blk;
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	integer tax_assessment_valuation;
	integer price_index_valuation;
	integer automated_valuation;
	integer confidence_score;
	integer8 hedonic_valuation;

	integer no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
	integer comp_radius;  // number of miles needed to meet 20 comp minimum
	real sum_hedonic_distance; // sum of the comps' hedonic distance
	real sum_physical_distance; // sum of the comps' physical distance to the subject property
	string1 combo_flag;

	integer8 market_value_valuation;
  integer8 assessed_value_valuation;
end;

d := dataset('~dvstemp::out::sept2006_avm_validation_results_20090317_against_base_full', ox, CSV(QUOTE('"'), heading(single)) );	
// output(d(market_value_valuation<>0) );
base_file := d;

// hennepin := d(fips_code='27053');
// output(hennepin(market_value_valuation<>0) );
// output(count(hennepin));
// output(hennepin);
// output(hennepin,,'~dvstemp::out::hennepin_sept2006_validation_base_20090317', csv(quote('"'), heading(single)) , overwrite);
// j_f1 := dataset('~dvstemp::out::hennepin_sept2006_validation_base_20090317', ox, CSV(QUOTE('"'), heading(single)) );	
// base_file := j_f1(land_use='1' and recent_sale_date[1..6]='200610');
// base_file := j_f1;
// output(count(j_f));

eyeball := 10;

atr := record
	unsigned seq;
	string5 fips_code;
	string1 land_use;
	string8 recent_sale_date;
	integer recent_sale_price;
	
	string8 recording_date;
	string4 assessed_value_year;
	string11 sales_price;  
	string11 assessed_total_value;
	string11 market_total_value;
	
	integer no_of_comps;  // overall number of hedonic comp_candidates at 1 mile
	integer comp_radius;  // number of miles needed to meet 20 comp minimum
	real sum_hedonic_distance; // sum of the comps' hedonic distance
	real sum_physical_distance; // sum of the comps' physical distance to the subject property
	string1 combo_flag;
	real months_since_sale;
	
	// fields for accuracy table calculations	
	integer price_index_valuation;
	integer diff_pi;
	real percent_diff_pi;
	
	integer tax_assessment_valuation;
	integer diff_ta;
	real percent_diff_ta;
	
	integer hedonic_valuation;
	integer diff_hedonic;
	real percent_diff_hedonic;
	
	integer market_value_valuation;
	integer diff_mv;
	real percent_diff_mv;
	
	integer assessed_value_valuation;
	integer diff_av;
	real percent_diff_av;
	
	// assessed value binning
	unsigned assessed_seq;
	unsigned assessed_valuations_total;
	string1 assessed_valuation_bin;
	integer assessed_bin1_cap;
	integer assessed_bin2_cap;
	integer assessed_bin3_cap;

	
	// market value binning
	unsigned market_seq;
	unsigned market_valuations_total;
	string1 market_valuation_bin;
	integer market_bin1_cap;
	integer market_bin2_cap;
	integer market_bin3_cap;
		
	// PI binning
	unsigned PI_seq;
	unsigned PI_valuations_total;
	string1 PI_valuation_bin;
	real PI_bin1_cap;
	real PI_bin2_cap;
	real PI_bin3_cap;

	// hedonic binning
	unsigned hedonic_seq;
	unsigned hedonic_valuations_total;
	string1 hedonic_valuation_bin;
	real hedonic_bin1_cap;
	real hedonic_bin2_cap;
	real hedonic_bin3_cap;

end;

valuation_counts := table(base_file, {fips_code,land_use, 
																pi_valuations_ct := count(group,price_index_valuation<>0),
																ta_valuations_ct := count(group,tax_assessment_valuation<>0),
																market_valuations_ct := count(group,market_value_valuation<>0),
																assessed_valuations_ct := count(group,assessed_value_valuation<>0),
																hedonic_valuations_ct := count(group,hedonic_valuation<>0)},
													fips_code, land_use, few);
// output(valuation_counts, named('valuation_counts'));


base_with_totals_and_diffs := join(base_file, valuation_counts, 
															left.fips_code=right.fips_code and left.land_use=right.land_use,
															transform(atr, self.pi_valuations_total := right.pi_valuations_ct;
																						 self.hedonic_valuations_total := right.hedonic_valuations_ct;
																						 self.market_valuations_total := right.market_valuations_ct;
																						 self.assessed_valuations_total := right.assessed_valuations_ct;
																						 
																						self.months_since_sale := ut.DaysApart(left.recent_sale_date,left.recording_date)/avm_v2.filters.days_in_a_month;
																						 
																						diff_pi := left.price_index_valuation-left.recent_sale_price;
																						self.diff_pi := if(left.price_index_valuation=0, 0, diff_pi );
																						diff_ratio_pi := if(left.price_index_valuation=0, 0, abs(diff_pi/left.recent_sale_price));
																						self.percent_diff_pi := diff_ratio_pi*100;

																						diff_hedonic := left.hedonic_valuation-left.recent_sale_price;
																						self.diff_hedonic := if(left.hedonic_valuation=0, 0, diff_hedonic );
																						diff_ratio_hedonic := if(left.hedonic_valuation=0, 0, abs(diff_hedonic/left.recent_sale_price));
																						self.percent_diff_hedonic := diff_ratio_hedonic*100;

																						diff_ta := left.tax_assessment_valuation-left.recent_sale_price;
																						self.diff_ta := if(left.tax_assessment_valuation=0, 0, diff_ta );
																						diff_ratio_ta := if(left.tax_assessment_valuation=0, 0, abs(diff_ta/left.recent_sale_price));
																						self.percent_diff_ta := diff_ratio_ta*100;

																						diff_mv := left.market_value_valuation-left.recent_sale_price;
																						self.diff_mv := if(left.market_value_valuation=0, 0, diff_mv );
																						diff_ratio_mv := if(left.market_value_valuation=0, 0, abs(diff_mv/left.recent_sale_price));
																						self.percent_diff_mv := diff_ratio_mv*100;

																						diff_av := left.assessed_value_valuation-left.recent_sale_price;
																						self.diff_av := if(left.assessed_value_valuation=0, 0, diff_av );
																						diff_ratio_av := if(left.assessed_value_valuation=0, 0, abs(diff_av/left.recent_sale_price));
																						self.percent_diff_av := diff_ratio_av*100;
																													 
																						 self := left, self := []));
// output(choosen(base_with_totals_and_diffs, eyeball), named('base_with_totals_and_diffs'));

overall_model_accuracy_stats := table(base_with_totals_and_diffs, 
	{fips_code,
	land_use,
	assessed_value_valuation_accuracy := (count(group, percent_diff_av <= 20 and assessed_value_valuation<>0)) / (count(group,assessed_value_valuation<>0)),
	market_value_valuation_accuracy := (count(group, percent_diff_mv <= 20 and market_value_valuation<>0)) / (count(group,market_value_valuation<>0)),
	tax_assessment_valuation_accuracy := (count(group, percent_diff_ta <= 20 and tax_assessment_valuation<>0)) / (count(group,tax_assessment_valuation<>0)),
	hedonic_valuation_accuracy := (count(group, percent_diff_hedonic <= 20 and hedonic_valuation<>0)) / (count(group,hedonic_valuation<>0)),
	price_index_valuation_accuracy := (count(group, percent_diff_pi <= 20 and price_index_valuation<>0)) / (count(group,price_index_valuation<>0)),	
	},
	fips_code, land_use, few);
// output(overall_model_accuracy_stats, named('overall_model_accuracy_stats'));

min_valuations_to_use_bins := avm_v2.filters.min_valuations_to_use_bins;
default_max := avm_v2.filters.default_max_bin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    ASSESSED VALUE VALUATION BIN LOGIC 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
// grouped_assessed_valuations := group(sort(j_f(assessed_value_valuation<>0),fips_code,land_use,(integer)assessed_value_valuation), fips_code, land_use);
grouped_assessed_valuations := group(sort(base_with_totals_and_diffs(assessed_value_valuation<>0),fips_code,land_use,(integer)assessed_total_value), fips_code, land_use);

atr add_assessed_seq(atr le, atr rt, integer C) := transform
	self.assessed_seq := c;
	bin := map(rt.assessed_valuations_total < min_valuations_to_use_bins => '1',
							c <= rt.assessed_valuations_total * 0.25 => '1',
							c <= rt.assessed_valuations_total * 0.50 => '2',
							c <= rt.assessed_valuations_total * 0.75 => '3',
							'4');

	self.assessed_valuation_bin := bin;
	self := rt;
end;

assessed_with_seq := iterate(grouped_assessed_valuations,add_assessed_seq(left,right,counter));
// output(assessed_with_seq, all, named('assessed_with_seq'));



atr roll_assessed_bins(atr le, atr rt) := transform
	self.assessed_bin1_cap := if(le.assessed_valuations_total < min_valuations_to_use_bins, default_max, 
																if(le.assessed_valuation_bin='1' and rt.assessed_valuation_bin='2', (integer)le.assessed_total_value, le.assessed_bin1_cap) );  
	self.assessed_bin2_cap := if(le.assessed_valuation_bin='2' and rt.assessed_valuation_bin='3', (integer)le.assessed_total_value, le.assessed_bin2_cap);
	self.assessed_bin3_cap := if(le.assessed_valuation_bin='3' and rt.assessed_valuation_bin='4', (integer)le.assessed_total_value, le.assessed_bin3_cap);
	self := rt;
end;

rolled_assessed_bins := rollup(assessed_with_seq, true, roll_assessed_bins(left,right));


with_assessed_bin_caps := join(assessed_with_seq, rolled_assessed_bins, 
						left.fips_code=right.fips_code and 
						left.land_use=right.land_use,
						transform(atr, 
									self.assessed_bin1_cap := right.assessed_bin1_cap, 
									self.assessed_bin2_cap := right.assessed_bin2_cap,
									self.assessed_bin3_cap := right.assessed_bin3_cap,
									self := left), lookup);
// assessed_caps := dedup(sort(with_assessed_bin_caps, fips_code, land_use, assessed_seq), fips_code, land_use);
// output(assessed_caps, named('assessed_caps'));


assessed_value_valuation_bin_stats := table(with_assessed_bin_caps, 
	{fips_code,
	land_use,	
	assessed_valuations_count := count(group),
	bin1_accuracy := (count(group, assessed_valuation_bin='1' and percent_diff_av <= 20 and assessed_value_valuation<>0)) / (count(group, assessed_valuation_bin='1' and assessed_value_valuation<>0)),
	bin2_accuracy := (count(group, assessed_valuation_bin='2' and percent_diff_av <= 20 and assessed_value_valuation<>0)) / (count(group, assessed_valuation_bin='2' and assessed_value_valuation<>0)),
	bin3_accuracy := (count(group, assessed_valuation_bin='3' and percent_diff_av <= 20 and assessed_value_valuation<>0)) / (count(group, assessed_valuation_bin='3' and assessed_value_valuation<>0)),
	bin4_accuracy := (count(group, assessed_valuation_bin='4' and percent_diff_av <= 20 and assessed_value_valuation<>0)) / (count(group, assessed_valuation_bin='4' and assessed_value_valuation<>0)),
	},
	fips_code, land_use, few);
// output(assessed_value_valuation_bin_stats, named('assessed_value_valuation_bin_stats'));





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    MARKET VALUE VALUATION BIN LOGIC 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
// grouped_market_valuations := group(sort(j_f(market_value_valuation<>0),fips_code,land_use,(integer)market_value_valuation), fips_code, land_use);
grouped_market_valuations := group(sort(base_with_totals_and_diffs(market_value_valuation<>0),fips_code,land_use,(integer)market_total_value), fips_code, land_use);

atr add_market_seq(atr le, atr rt, integer C) := transform
	self.market_seq := c;
	bin := map(rt.market_valuations_total < min_valuations_to_use_bins => '1',
							c <= rt.market_valuations_total * 0.25 => '1',
							c <= rt.market_valuations_total * 0.50 => '2',
							c <= rt.market_valuations_total * 0.75 => '3',
							'4');

	self.market_valuation_bin := bin;
	self := rt;
end;

market_with_seq := iterate(grouped_market_valuations,add_market_seq(left,right,counter));

atr roll_market_bins(atr le, atr rt) := transform
	self.market_bin1_cap := if(le.market_valuations_total < min_valuations_to_use_bins, default_max, 
																if(le.market_valuation_bin='1' and rt.market_valuation_bin='2', (integer)le.market_total_value, le.market_bin1_cap) );  
	self.market_bin2_cap := if(le.market_valuation_bin='2' and rt.market_valuation_bin='3', (integer)le.market_total_value, le.market_bin2_cap);
	self.market_bin3_cap := if(le.market_valuation_bin='3' and rt.market_valuation_bin='4', (integer)le.market_total_value, le.market_bin3_cap);
	self := rt;
end;

rolled_market_bins := rollup(market_with_seq, true, roll_market_bins(left,right));


with_market_bin_caps := join(market_with_seq, rolled_market_bins, 
						left.fips_code=right.fips_code and 
						left.land_use=right.land_use,
						transform(atr, 
									self.market_bin1_cap := right.market_bin1_cap, 
									self.market_bin2_cap := right.market_bin2_cap,
									self.market_bin3_cap := right.market_bin3_cap,
									self := left), lookup);
// market_caps := dedup(sort(with_market_bin_caps, fips_code, land_use, market_seq), fips_code, land_use);
// output(market_caps, named('market_caps'));

market_value_valuation_bin_stats := table(with_market_bin_caps, 
	{fips_code,
	land_use,
	market_valuations_count := count(group),
	bin1_accuracy := (count(group, market_valuation_bin='1' and percent_diff_mv <= 20 and market_value_valuation<>0)) / (count(group, market_valuation_bin='1' and market_value_valuation<>0)),
	bin2_accuracy := (count(group, market_valuation_bin='2' and percent_diff_mv <= 20 and market_value_valuation<>0)) / (count(group, market_valuation_bin='2' and market_value_valuation<>0)),
	bin3_accuracy := (count(group, market_valuation_bin='3' and percent_diff_mv <= 20 and market_value_valuation<>0)) / (count(group, market_valuation_bin='3' and market_value_valuation<>0)),
	bin4_accuracy := (count(group, market_valuation_bin='4' and percent_diff_mv <= 20 and market_value_valuation<>0)) / (count(group, market_valuation_bin='4' and market_value_valuation<>0)),
	},
	fips_code, land_use, few);
// output(market_value_valuation_bin_stats, named('market_value_valuation_bin_stats'));








////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    HEDONIC VALUATION BIN LOGIC 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
grouped_hedonic_valuations := group(sort(base_with_totals_and_diffs(hedonic_valuation<>0),fips_code,land_use,sum_physical_distance), fips_code, land_use);

// output(choosen(grouped_hedonic_valuations, eyeball), named('sorted_hedonic_by_physical_distance'));

atr add_hedonic_seq(atr le, atr rt, integer C) := transform
	self.hedonic_seq := c;
	bin := map(rt.hedonic_valuations_total < min_valuations_to_use_bins => '1',
							c <= rt.hedonic_valuations_total * 0.25 => '1',
							c <= rt.hedonic_valuations_total * 0.50 => '2',
							c <= rt.hedonic_valuations_total * 0.75 => '3',
							'4');

	self.hedonic_valuation_bin := bin;
	self := rt;
end;

hedonic_with_seq := iterate(grouped_hedonic_valuations,add_hedonic_seq(left,right,counter));

atr roll_hedonic_bins(atr le, atr rt) := transform
	self.hedonic_bin1_cap := if(le.hedonic_valuations_total < min_valuations_to_use_bins, default_max, 
																if(le.hedonic_valuation_bin='1' and rt.hedonic_valuation_bin='2', le.sum_physical_distance, le.hedonic_bin1_cap) );  
	self.hedonic_bin2_cap := if(le.hedonic_valuation_bin='2' and rt.hedonic_valuation_bin='3', le.sum_physical_distance, le.hedonic_bin2_cap);
	self.hedonic_bin3_cap := if(le.hedonic_valuation_bin='3' and rt.hedonic_valuation_bin='4', le.sum_physical_distance, le.hedonic_bin3_cap);
	self := rt;
end;

rolled_hedonic_bins := rollup(hedonic_with_seq, true, roll_hedonic_bins(left,right));


with_hedonic_bin_caps := join(hedonic_with_seq, rolled_hedonic_bins, 
						left.fips_code=right.fips_code and 
						left.land_use=right.land_use,
						transform(atr, 
									self.hedonic_bin1_cap := right.hedonic_bin1_cap, 
									self.hedonic_bin2_cap := right.hedonic_bin2_cap,
									self.hedonic_bin3_cap := right.hedonic_bin3_cap,
									self := left), lookup);
// hedonic_caps := dedup(sort(with_hedonic_bin_caps, fips_code, land_use, hedonic_seq), fips_code, land_use);
// output(hedonic_caps, named('hedonic_caps'));

hedonic_valuation_bin_stats := table(with_hedonic_bin_caps, 
	{fips_code,
	land_use,
	hedonic_valuations_count := count(group),
	bin1_accuracy := (count(group, hedonic_valuation_bin='1' and percent_diff_hedonic <= 20 and hedonic_valuation<>0)) / (count(group, hedonic_valuation_bin='1' and hedonic_valuation<>0)),
	bin2_accuracy := (count(group, hedonic_valuation_bin='2' and percent_diff_hedonic <= 20 and hedonic_valuation<>0)) / (count(group, hedonic_valuation_bin='2' and hedonic_valuation<>0)),
	bin3_accuracy := (count(group, hedonic_valuation_bin='3' and percent_diff_hedonic <= 20 and hedonic_valuation<>0)) / (count(group, hedonic_valuation_bin='3' and hedonic_valuation<>0)),
	bin4_accuracy := (count(group, hedonic_valuation_bin='4' and percent_diff_hedonic <= 20 and hedonic_valuation<>0)) / (count(group, hedonic_valuation_bin='4' and hedonic_valuation<>0)),
	},
	fips_code, land_use, few);
// output(hedonic_valuation_bin_stats, named('hedonic_valuation_bin_stats'));





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                    PI VALUATION BIN LOGIC 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
grouped_pi_valuations := group(sort(base_with_totals_and_diffs(price_index_valuation<>0),fips_code,land_use,months_since_sale), fips_code, land_use);

// output(choosen(grouped_pi_valuations, eyeball), named('sorted_pi_by_physical_distance'));

atr add_pi_seq(atr le, atr rt, integer C) := transform
	self.pi_seq := c;
	bin := map(rt.pi_valuations_total < min_valuations_to_use_bins => '1',
							c <= rt.pi_valuations_total * 0.25 => '1',
							c <= rt.pi_valuations_total * 0.50 => '2',
							c <= rt.pi_valuations_total * 0.75 => '3',
							'4');

	self.pi_valuation_bin := bin;
	self := rt;
end;

pi_with_seq := iterate(grouped_pi_valuations,add_pi_seq(left,right,counter));

atr roll_pi_bins(atr le, atr rt) := transform
	self.pi_bin1_cap := if(le.pi_valuations_total < min_valuations_to_use_bins, default_max, 
																if(le.pi_valuation_bin='1' and rt.pi_valuation_bin='2', le.months_since_sale, le.pi_bin1_cap) );  
	self.pi_bin2_cap := if(le.pi_valuation_bin='2' and rt.pi_valuation_bin='3', le.months_since_sale, le.pi_bin2_cap);
	self.pi_bin3_cap := if(le.pi_valuation_bin='3' and rt.pi_valuation_bin='4', le.months_since_sale, le.pi_bin3_cap);
	self := rt;
end;

rolled_pi_bins := rollup(pi_with_seq, true, roll_pi_bins(left,right));


with_pi_bin_caps := join(pi_with_seq, rolled_pi_bins, 
						left.fips_code=right.fips_code and 
						left.land_use=right.land_use,
						transform(atr, 
									self.pi_bin1_cap := right.pi_bin1_cap, 
									self.pi_bin2_cap := right.pi_bin2_cap,
									self.pi_bin3_cap := right.pi_bin3_cap,
									self := left), lookup);
// pi_caps := dedup(sort(with_pi_bin_caps, fips_code, land_use, pi_seq), fips_code, land_use);
// output(pi_caps, named('pi_caps'));

pi_valuation_bin_stats := table(with_pi_bin_caps, 
	{fips_code,
	land_use,
	pi_valuations_count := count(group),
	bin1_accuracy := (count(group, pi_valuation_bin='1' and percent_diff_pi <= 20 and price_index_valuation<>0)) / (count(group, pi_valuation_bin='1' and price_index_valuation<>0)),
	bin2_accuracy := (count(group, pi_valuation_bin='2' and percent_diff_pi <= 20 and price_index_valuation<>0)) / (count(group, pi_valuation_bin='2' and price_index_valuation<>0)),
	bin3_accuracy := (count(group, pi_valuation_bin='3' and percent_diff_pi <= 20 and price_index_valuation<>0)) / (count(group, pi_valuation_bin='3' and price_index_valuation<>0)),
	bin4_accuracy := (count(group, pi_valuation_bin='4' and percent_diff_pi <= 20 and price_index_valuation<>0)) / (count(group, pi_valuation_bin='4' and price_index_valuation<>0)),
	},
	fips_code, land_use, few);
// output(pi_valuation_bin_stats, named('pi_valuation_bin_stats'));



final_accuracy_layout := record
	string5 fips_code;
	string1 land_use;	
	
	unsigned assessed_valuations_count;
	real overall_assessed_accuracy;
	integer assessed_bin1_cap;
	integer assessed_bin2_cap;
	integer assessed_bin3_cap;
	real assessed_bin1_accuracy;
	real assessed_bin2_accuracy;
	real assessed_bin3_accuracy;
	real assessed_bin4_accuracy;
	
	unsigned market_valuations_count;
	real overall_market_accuracy;
	real market_bin1_accuracy;
	real market_bin2_accuracy;
	real market_bin3_accuracy;
	real market_bin4_accuracy;
	integer market_bin1_cap;
	integer market_bin2_cap;
	integer market_bin3_cap;
	
	unsigned PI_valuations_count;
	real overall_PI_accuracy;
	real PI_bin1_accuracy;
	real PI_bin2_accuracy;
	real PI_bin3_accuracy;
	real PI_bin4_accuracy;
	real PI_bin1_cap;
	real PI_bin2_cap;
	real PI_bin3_cap;
	
	unsigned hedonic_valuations_count;
	real overall_hedonic_accuracy;
	real hedonic_bin1_accuracy;
	real hedonic_bin2_accuracy;
	real hedonic_bin3_accuracy;
	real hedonic_bin4_accuracy;
	real hedonic_bin1_cap;
	real hedonic_bin2_cap;
	real hedonic_bin3_cap;
	
end;

j1 := join(overall_model_accuracy_stats, assessed_value_valuation_bin_stats,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
										self.fips_code := left.fips_code;
										self.land_use := left.land_use;
										self.overall_assessed_accuracy := left.assessed_value_valuation_accuracy;
										self.overall_market_accuracy := left.market_value_valuation_accuracy;
										self.overall_hedonic_accuracy := left.hedonic_valuation_accuracy;
										self.overall_pi_accuracy := left.price_index_valuation_accuracy;
										self.assessed_valuations_count := right.assessed_valuations_count;
										self.assessed_bin1_accuracy := right.bin1_accuracy;
										self.assessed_bin2_accuracy := right.bin2_accuracy;
										self.assessed_bin3_accuracy := right.bin3_accuracy;
										self.assessed_bin4_accuracy := right.bin4_accuracy;
										self := [];), 
								left outer);
// output(j1, named('with_assessed_bin_accuracy'));


j2 := join(j1, market_value_valuation_bin_stats,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
										self.market_valuations_count := right.market_valuations_count;
										self.market_bin1_accuracy := right.bin1_accuracy;
										self.market_bin2_accuracy := right.bin2_accuracy;
										self.market_bin3_accuracy := right.bin3_accuracy;
										self.market_bin4_accuracy := right.bin4_accuracy;
										self := left;), 
								left outer);
// output(j2, named('with_market_bin_accuracy'));

j3 := join(j2, pi_valuation_bin_stats,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
										self.pi_valuations_count := right.pi_valuations_count;
										self.pi_bin1_accuracy := right.bin1_accuracy;
										self.pi_bin2_accuracy := right.bin2_accuracy;
										self.pi_bin3_accuracy := right.bin3_accuracy;
										self.pi_bin4_accuracy := right.bin4_accuracy;
									self := left;), 
							left outer);
// output(j3, named('with_pi_bin_accuracy'));


j4 := join(j3, hedonic_valuation_bin_stats,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
										self.hedonic_valuations_count := right.hedonic_valuations_count;
										self.hedonic_bin1_accuracy := right.bin1_accuracy;
										self.hedonic_bin2_accuracy := right.bin2_accuracy;
										self.hedonic_bin3_accuracy := right.bin3_accuracy;
										self.hedonic_bin4_accuracy := right.bin4_accuracy;
									self := left;), 
							left outer);
// output(j4, named('with_hedonic_bin_accuracy'));
 


j5 := join(j4, rolled_assessed_bins,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
											self.assessed_bin1_cap := right.assessed_bin1_cap, 
											self.assessed_bin2_cap := right.assessed_bin2_cap,
											self.assessed_bin3_cap := right.assessed_bin3_cap,
									self := left;), 
							left outer);
// output(j5, named('with_assessed_bins'));


j6 := join(j5, rolled_market_bins,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
											self.market_bin1_cap := right.market_bin1_cap, 
											self.market_bin2_cap := right.market_bin2_cap,
											self.market_bin3_cap := right.market_bin3_cap,
									self := left;), 
							left outer);
// output(j6, named('with_market_bins'));

j7 := join(j6, rolled_pi_bins,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
											self.pi_bin1_cap := right.pi_bin1_cap, 
											self.pi_bin2_cap := right.pi_bin2_cap,
											self.pi_bin3_cap := right.pi_bin3_cap,
									self := left;), 
							left outer);
// output(j7, named('with_pi_bins'));

j8 := join(j7, rolled_hedonic_bins,
						left.fips_code=right.fips_code and left.land_use=right.land_use,
					transform(final_accuracy_layout,
											self.hedonic_bin1_cap := right.hedonic_bin1_cap, 
											self.hedonic_bin2_cap := right.hedonic_bin2_cap,
											self.hedonic_bin3_cap := right.hedonic_bin3_cap,
									self := left;), 
							left outer);
output(j8(fips_code='27053'), named('full_accuracy_picture'));

tday := ut.GetDate;
output(j8,,'~thor_data400::in::avm_model_accuracy_table_' + tday, csv(heading(single), quote('"')), overwrite );


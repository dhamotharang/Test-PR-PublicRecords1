
export File_TA_UpdateTable(string8 history_date) := function

d := avm_v2.file_ta_ratios(history_date);

month_stat_layout := record
	fips_code := d.fips_code;
	land_use_code := d.land_use_code;
	assessed_value_year := d.assessed_value_year;

	month6_ct := count(group,d.recording_date >= avm_v2.filters(history_date).days_ago_183);
	month12_ct := count(group,d.recording_date >= avm_v2.filters(history_date).days_ago_365);
	month18_ct := count(group,d.recording_date >=  avm_v2.filters(history_date).days_ago_548);
end;

// gather some stats about the # of sales for 3 time frames (6, 12 and 18 months)
stats := table(d, month_stat_layout, fips_code, land_use_code, assessed_value_year, few);

layout_ta_calcs := record
	string12 ln_fares_id;
	string5 fips_code;
	string1 land_use_code;
	string4 assessed_value_year;
	
	string8 recording_date;
	string11 sales_price;
	string11 assessed_total_value;
	string11 market_total_value;

	integer assess_recs_total_count;
	string1 assess_bin;	
	string11 assess_bin1_cap;
	string11 assess_bin2_cap;
	string11 assess_bin3_cap;
	real assessed_value_to_saleprice_ratio1;
	real assessed_value_to_saleprice_ratio2;
	real assessed_value_to_saleprice_ratio3;
	real assessed_value_to_saleprice_ratio4;
	
	integer market_recs_total_count;
	string1 market_bin;
	string11 market_bin1_cap;
	string11 market_bin2_cap;
	string11 market_bin3_cap;
	real market_value_to_saleprice_ratio1;
	real market_value_to_saleprice_ratio2;
	real market_value_to_saleprice_ratio3;
	real market_value_to_saleprice_ratio4;
	integer county_seq;
	string2 sales_months_filter;
end;


//layout_ta_calcs append_calcs(layout_temp le) := transform 
layout_ta_calcs append_calcs(d le, stats rt) := transform
	smf := map(rt.month6_ct > 200 => '6',
			   rt.month12_ct > 200 => '12',
			   '18');
			   
	
	rdf := map(smf='6' => avm_v2.filters(history_date).days_ago_183,
			   smf='12' => avm_v2.filters(history_date).days_ago_365,
			   avm_v2.filters(history_date).days_ago_548);
	// we have over 200 records at rdf for this fips, skip any record that comes prior to rdf	   
	self.sales_months_filter := if(le.recording_date > rdf, smf, skip); 
	self.assessed_value_to_saleprice_ratio1 := (integer)le.sales_price/(integer)le.assessed_total_value;
	self.market_value_to_saleprice_ratio1  := (integer)le.sales_price/(integer)le.market_total_value;
	
	self := le;
	self := [];
end; 

f1 := join(d, stats, 
			left.fips_code=right.fips_code and
			left.land_use_code=right.land_use_code and
			left.assessed_value_year=right.assessed_value_year,
			append_calcs(left,right), left outer, lookup);
							

f := distribute(f1, hash(assessed_value_year,fips_code,land_use_code));

// create median assessed to sales ratio per year, fips, land use and bin

	// group all the properties by tax year, fips, land use and put that grouped result into layout_ta_calcs to iterate through
	assessed_props := group(sort(f(assessed_value_to_saleprice_ratio1<>0), assessed_value_year,fips_code,land_use_code,(integer)assessed_total_value, local), assessed_value_year, fips_code, land_use_code, local);
	assessed_totals := table(assessed_props, {assessed_value_year,fips_code,land_use_code, total := count(group)});

	// break assessments out into quartiles
	w_assess_totals1 := join(assessed_props,assessed_totals, 
									left.assessed_value_year=right.assessed_value_year and 
									left.fips_code=right.fips_code and 
									left.land_use_code=right.land_use_code,
									transform(layout_ta_calcs, self.assess_recs_total_count := right.total, self := left), local);
	w_assess_totals := distribute(w_assess_totals1, hash(assessed_value_year,fips_code,land_use_code));
	grouped_assess_with_total := group(sort(w_assess_totals(assess_recs_total_count > 50), assessed_value_year,fips_code,land_use_code,(integer)assessed_total_value, local), assessed_value_year, fips_code, land_use_code, local);


	layout_ta_calcs add_seq(layout_ta_calcs le, layout_ta_calcs rt, integer C) := transform
		self.county_seq := c;
		bin := map(rt.assess_recs_total_count < 200 => '1',
					c <= rt.assess_recs_total_count * 0.25 => '1',
					c <= rt.assess_recs_total_count * 0.50 => '2',
					c <= rt.assess_recs_total_count * 0.75 => '3',
					'4');

		self.assess_bin := bin;
		self.assess_bin1_cap := if(rt.assess_recs_total_count < 200, '99999999999', '');  // we only have 1 bin to work with
		self := rt;
	end;

	assessed_with_seq := iterate(grouped_assess_with_total,add_seq(left,right,counter));


	layout_ta_calcs roll_bins(layout_ta_calcs le, layout_ta_calcs rt) := transform
		self.assess_bin1_cap := if(le.assess_bin1_cap='99999999999', '99999999999', if(le.assess_bin='1' and rt.assess_bin='2', le.assessed_total_value, le.assess_bin1_cap));  
		self.assess_bin2_cap := if(le.assess_bin='2' and rt.assess_bin='3', le.assessed_total_value, le.assess_bin2_cap);
		self.assess_bin3_cap := if(le.assess_bin='3' and rt.assess_bin='4', le.assessed_total_value, le.assess_bin3_cap);
		self := rt;
	end;

	rolled_assess_bins := rollup(assessed_with_seq, true, roll_bins(left,right));


	with_assess_bin_caps1 := join(assessed_with_seq, rolled_assess_bins, 
							left.assessed_value_year=right.assessed_value_year and 
							left.fips_code=right.fips_code and 
							left.land_use_code=right.land_use_code,
							transform(layout_ta_calcs, 
										self.assess_bin1_cap := right.assess_bin1_cap, 
										self.assess_bin2_cap := right.assess_bin2_cap,
										self.assess_bin3_cap := right.assess_bin3_cap,
										self := left), lookup);

	with_assess_bin_caps := distribute(with_assess_bin_caps1, hash(assessed_value_year,fips_code,land_use_code));

	grouped_assess_bins := group(sort(with_assess_bin_caps, assessed_value_year,fips_code,land_use_code,assess_bin,assessed_value_to_saleprice_ratio1, local), fips_code,land_use_code,assessed_value_year,assess_bin, local);


	assess_bin_totals1 := table(grouped_assess_bins, {fips_code,land_use_code, assessed_value_year, assess_bin, total := count(group)});

	layout_ta_calcs add_seq_per_bin(layout_ta_calcs le, layout_ta_calcs rt, integer C) := transform
		self.county_seq := c;
		self := rt;
	end;

	assessed_bins_with_seq1 := iterate(grouped_assess_bins,add_seq_per_bin(left,right,counter));
	
	
	assess_bin_totals := distribute(assess_bin_totals1, hash(assessed_value_year,fips_code,land_use_code));
	assessed_bins_with_seq := distribute(assessed_bins_with_seq1, hash(assessed_value_year,fips_code,land_use_code));


	// instead of taking the middle record as the median, Global Analytics suggested using the 49th percentile record in each quartile
	assess_with_ratios1 := join(assess_bin_totals,assessed_bins_with_seq, 
									left.assessed_value_year=right.assessed_value_year and 
									left.fips_code=right.fips_code and 
									left.land_use_code=right.land_use_code and
									left.assess_bin=right.assess_bin and
									right.county_seq=round(left.total*0.49),     
									transform(layout_ta_calcs, 
											self.assessed_value_to_saleprice_ratio1:=if(right.assess_bin='1', right.assessed_value_to_saleprice_ratio1,0),
											self.assessed_value_to_saleprice_ratio2:=if(right.assess_bin='2', right.assessed_value_to_saleprice_ratio1,0),
											self.assessed_value_to_saleprice_ratio3:=if(right.assess_bin='3', right.assessed_value_to_saleprice_ratio1,0),
											self.assessed_value_to_saleprice_ratio4:=if(right.assess_bin='4', right.assessed_value_to_saleprice_ratio1,0),
											self.county_seq := right.county_seq,
											self := left,
											self := right), local
									);


	assess_with_ratios := distribute(assess_with_ratios1, hash(assessed_value_year,fips_code,land_use_code));
	grouped_assess_with_ratios := group(sort(assess_with_ratios, fips_code,land_use_code,assessed_value_year,assess_bin, local), fips_code,land_use_code,assessed_value_year, local);
	

	layout_ta_calcs roll_assess_ratios(layout_ta_calcs le, layout_ta_calcs rt) := transform
		self.assessed_value_to_saleprice_ratio1 := le.assessed_value_to_saleprice_ratio1;
		self.assessed_value_to_saleprice_ratio2 := if(rt.assess_bin='2',rt.assessed_value_to_saleprice_ratio2, le.assessed_value_to_saleprice_ratio2);
		self.assessed_value_to_saleprice_ratio3 := if(rt.assess_bin='3',rt.assessed_value_to_saleprice_ratio3, le.assessed_value_to_saleprice_ratio3);
		self.assessed_value_to_saleprice_ratio4 := if(rt.assess_bin='4',rt.assessed_value_to_saleprice_ratio4, le.assessed_value_to_saleprice_ratio4);
		self := rt;
	end;

	Median_Assessed_Ratios1 := rollup(grouped_assess_with_ratios, true, roll_assess_ratios(left,right));
// end of median Assessed


// create median assessed to sales ratio per year, fips, land use and bin

	// group all the properties by tax year, fips, land use and put that grouped result into layout_ta_calcs to iterate through
	market_props := group(sort(f(market_value_to_saleprice_ratio1<>0), assessed_value_year,fips_code,land_use_code,(integer)market_total_value, local), assessed_value_year, fips_code, land_use_code, local);
	market_totals := table(market_props, {assessed_value_year,fips_code,land_use_code, total := count(group)});
	
	// break assessments out into quartiles
	w_market_totals1 := join(market_props,market_totals, 
									left.assessed_value_year=right.assessed_value_year and 
									left.fips_code=right.fips_code and 
									left.land_use_code=right.land_use_code,
									transform(layout_ta_calcs, self.market_recs_total_count := right.total, self := left), local);
	
	w_market_totals := distribute(w_market_totals1, hash(assessed_value_year,fips_code,land_use_code));
	grouped_market_with_total := group(sort(w_market_totals(market_recs_total_count > 50), assessed_value_year,fips_code,land_use_code,(integer)market_total_value, local), assessed_value_year, fips_code, land_use_code, local);


	layout_ta_calcs add_seq2(layout_ta_calcs le, layout_ta_calcs rt, integer C) := transform
		self.county_seq := c;
		bin := map(rt.market_recs_total_count < 200 => '1',
					c <= rt.market_recs_total_count * 0.25 => '1',
					c <= rt.market_recs_total_count * 0.50 => '2',
					c <= rt.market_recs_total_count * 0.75 => '3',
					'4');

		self.market_bin := bin;
		self.market_bin1_cap := if(rt.market_recs_total_count < 200, '99999999999', '');  // we only have 1 bin to work with
		self := rt;
	end;

	market_with_seq1 := iterate(grouped_market_with_total,add_seq2(left,right,counter));


	layout_ta_calcs roll_bins2(layout_ta_calcs le, layout_ta_calcs rt) := transform
		self.market_bin1_cap := if(le.market_bin1_cap='99999999999', '99999999999', if(le.market_bin='1' and rt.market_bin='2', le.market_total_value, le.market_bin1_cap));  
		self.market_bin2_cap := if(le.market_bin='2' and rt.market_bin='3', le.market_total_value, le.market_bin2_cap);
		self.market_bin3_cap := if(le.market_bin='3' and rt.market_bin='4', le.market_total_value, le.market_bin3_cap);
		self := rt;
	end;

	rolled_market_bins1 := rollup(market_with_seq1, true, roll_bins2(left,right));


	market_with_seq := distribute(market_with_seq1, hash(assessed_value_year,fips_code,land_use_code));
	rolled_market_bins := distribute(rolled_market_bins1, hash(assessed_value_year,fips_code,land_use_code));


	with_market_bin_caps1 := join(market_with_seq, rolled_market_bins, 
							left.assessed_value_year=right.assessed_value_year and 
							left.fips_code=right.fips_code and 
							left.land_use_code=right.land_use_code,
							transform(layout_ta_calcs, 
										self.market_bin1_cap := right.market_bin1_cap, 
										self.market_bin2_cap := right.market_bin2_cap,
										self.market_bin3_cap := right.market_bin3_cap,
										self := left), local);


	with_market_bin_caps := distribute(with_market_bin_caps1, hash(assessed_value_year,fips_code,land_use_code));
	grouped_market_bins := group(sort(with_market_bin_caps, fips_code,land_use_code,assessed_value_year,market_bin,market_value_to_saleprice_ratio1, local), fips_code,land_use_code,assessed_value_year,market_bin, local);

	market_bin_totals1 := table(grouped_market_bins, {fips_code,land_use_code, assessed_value_year, market_bin, total := count(group)});

	layout_ta_calcs add_seq_per_bin2(layout_ta_calcs le, layout_ta_calcs rt, integer C) := transform
		self.county_seq := c;
		self := rt;
	end;

	market_bins_with_seq1 := iterate(grouped_market_bins,add_seq_per_bin2(left,right,counter));


	market_bin_totals := distribute(market_bin_totals1, hash(assessed_value_year,fips_code,land_use_code));
	market_bins_with_seq := distribute(market_bins_with_seq1, hash(assessed_value_year,fips_code,land_use_code));


	// instead of taking the middle record as the median, Global Analytics suggested using the 49th percentile record in each quartile
	market_with_ratios1 := join(market_bin_totals,market_bins_with_seq, 
									left.assessed_value_year=right.assessed_value_year and 
									left.fips_code=right.fips_code and 
									left.land_use_code=right.land_use_code and
									left.market_bin=right.market_bin and
									right.county_seq=round(left.total*0.49),     
									transform(layout_ta_calcs, 
											self.market_value_to_saleprice_ratio1:=if(right.market_bin='1', right.market_value_to_saleprice_ratio1,0),
											self.market_value_to_saleprice_ratio2:=if(right.market_bin='2', right.market_value_to_saleprice_ratio1,0),
											self.market_value_to_saleprice_ratio3:=if(right.market_bin='3', right.market_value_to_saleprice_ratio1,0),
											self.market_value_to_saleprice_ratio4:=if(right.market_bin='4', right.market_value_to_saleprice_ratio1,0),
											self.county_seq := right.county_seq,
											self := left,
											self := right), local
									);

	market_with_ratios := distribute(market_with_ratios1, hash(assessed_value_year,fips_code,land_use_code));
	grouped_market_with_ratios := group(sort(market_with_ratios, fips_code,land_use_code,assessed_value_year,market_bin, local), fips_code,land_use_code,assessed_value_year, local);

	layout_ta_calcs roll_market_ratios(layout_ta_calcs le, layout_ta_calcs rt) := transform
		self.market_value_to_saleprice_ratio1 := le.market_value_to_saleprice_ratio1;
		self.market_value_to_saleprice_ratio2 := if(rt.market_bin='2',rt.market_value_to_saleprice_ratio2, le.market_value_to_saleprice_ratio2);
		self.market_value_to_saleprice_ratio3 := if(rt.market_bin='3',rt.market_value_to_saleprice_ratio3, le.market_value_to_saleprice_ratio3);
		self.market_value_to_saleprice_ratio4 := if(rt.market_bin='4',rt.market_value_to_saleprice_ratio4, le.market_value_to_saleprice_ratio4);
		self := rt;
	end;

	Median_market_Ratios1 := rollup(grouped_market_with_ratios, true, roll_market_ratios(left,right));
	
// end of median market


layout_ta_calcs merge_ratios(layout_ta_calcs le, layout_ta_calcs rt) := transform
	self.assessed_value_to_saleprice_ratio1 := le.assessed_value_to_saleprice_ratio1;
	self.assessed_value_to_saleprice_ratio2 := le.assessed_value_to_saleprice_ratio2; 
	self.assessed_value_to_saleprice_ratio3 := le.assessed_value_to_saleprice_ratio3; 
	self.assessed_value_to_saleprice_ratio4 := le.assessed_value_to_saleprice_ratio4; 
	self.assess_recs_total_count := le.assess_recs_total_count;
	self.assess_bin := le.assess_bin;	
	self.assess_bin1_cap := le.assess_bin1_cap;
	self.assess_bin2_cap := le.assess_bin2_cap;
	self.assess_bin3_cap := le.assess_bin3_cap;
	
	self.market_value_to_saleprice_ratio1 := rt.market_value_to_saleprice_ratio1;
	self.market_value_to_saleprice_ratio2 := rt.market_value_to_saleprice_ratio2;
	self.market_value_to_saleprice_ratio3 := rt.market_value_to_saleprice_ratio3;
	self.market_value_to_saleprice_ratio4 := rt.market_value_to_saleprice_ratio4;	
	self.market_recs_total_count := rt.market_recs_total_count;
	self.market_bin := rt.market_bin;
	self.market_bin1_cap := rt.market_bin1_cap;
	self.market_bin2_cap := rt.market_bin2_cap;
	self.market_bin3_cap := rt.market_bin3_cap;
		
	// for the rest of the fields, use assessed data unless it's not present
	useMarket := le.fips_code='';
	self := if(useMarket, rt, le);
end;


Median_Assessed_Ratios := distribute(Median_Assessed_Ratios1, hash(assessed_value_year,fips_code,land_use_code));
Median_Market_Ratios := distribute(Median_Market_Ratios1, hash(assessed_value_year,fips_code,land_use_code));

w_both_ratios := join(Median_Assessed_Ratios, Median_Market_Ratios,
					  left.assessed_value_year=right.assessed_value_year and 
					  left.fips_code=right.fips_code and 
					  left.land_use_code=right.land_use_code,
					  merge_ratios(left,right), full outer, local);
// output(count(w_both_ratios), named('both_ratios_counts'));			  


output(w_both_ratios,,'~thor_data400::avm_v2::ta_update_table', __compressed__, overwrite);

return w_both_ratios;

end;

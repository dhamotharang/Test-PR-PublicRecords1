import ut;

pi_deduped := avm.File_AVM_PI_Records;

pi_calculation_layout := record
	pi_deduped;
	string6 base_quarter;
	
	boolean zip_level_multiplier;
	real saleqtr_to_Q3_2005_multiplier;
	integer Q3_2005_valuation;
	boolean basetable_missing_county;
	real basetable_to_current_ofheo_ratio;
	real saleqtr_to_current_ofheo_ratio;
	real ofheo_coef1;
	real msp_coef1;
	integer saleqtr_median_sales_price;
	integer q3_2005_base_msp;
	integer most_recent_quarter_msp;
	string6 most_recent_quarter;
	real8 q3_2005_to_most_recent_quarter_ratio;
	real8 sale_quarter_to_most_recent_ratio;
end;


pi_calculation_layout get_ofheo_ratios(pi_deduped le, avm.File_OFHEO rt) := transform
	q := avm.filters.quarter_map(le.recording_date);
	self.quarter := q;
	self.basetable_to_current_ofheo_ratio := rt.base_to_current_Ratio;
	self.saleqtr_to_current_ofheo_ratio := rt.current_ratio;
	
	// inserted to test ofheo only
	self.Price_Index_Valuation := (integer)((integer)le.sales_price * rt.current_ratio);
	self := le;
	self := [];
end;

wOfheo := join(pi_deduped, avm.File_OFHEO, 
					left.fips_code[1..2]=right.state_fips 
					and avm.filters.quarter_map(left.recording_date)=right.quarter,
					get_ofheo_ratios(left,right), left outer, lookup);

/*
pi_calculation_layout add_base(pi_calculation_layout le, avm.File_PI_BaseTable rt) := transform
	self.zip_level_multiplier := rt.zipcode!='';
	self.base_quarter := if(le.quarter<'2005Q4','2005Q3',le.quarter);
	q := le.quarter;
	multiplier := map(q='1996Q1' => rt.Q1_1996,
						q='1996Q2' => rt.Q2_1996,
						q='1996Q3' => rt.Q3_1996,
						q='1996Q4' => rt.Q4_1996,
						
						q='1997Q1' => rt.Q1_1997,
						q='1997Q2' => rt.Q2_1997,
						q='1997Q3' => rt.Q3_1997,
						q='1997Q4' => rt.Q4_1997,
						
						q='1998Q1' => rt.Q1_1998,
						q='1998Q2' => rt.Q2_1998,
						q='1998Q3' => rt.Q3_1998,
						q='1998Q4' => rt.Q4_1998,
						
						q='1999Q1' => rt.Q1_1999,
						q='1999Q2' => rt.Q2_1999,
						q='1999Q3' => rt.Q3_1999,
						q='1999Q4' => rt.Q4_1999,
						
						q='2000Q1' => rt.Q1_2000,
						q='2000Q2' => rt.Q2_2000,
						q='2000Q3' => rt.Q3_2000,
						q='2000Q4' => rt.Q4_2000,
						
						q='2001Q1' => rt.Q1_2001,
						q='2001Q2' => rt.Q2_2001,
						q='2001Q3' => rt.Q3_2001,
						q='2001Q4' => rt.Q4_2001,
						
						q='2002Q1' => rt.Q1_2002,
						q='2002Q2' => rt.Q2_2002,
						q='2002Q3' => rt.Q3_2002,
						q='2002Q4' => rt.Q4_2002,
						
						q='2003Q1' => rt.Q1_2003,
						q='2003Q2' => rt.Q2_2003,
						q='2003Q3' => rt.Q3_2003,
						q='2003Q4' => rt.Q4_2003,
						
						q='2004Q1' => rt.Q1_2004,
						q='2004Q2' => rt.Q2_2004,
						q='2004Q3' => rt.Q3_2004,
						q='2004Q4' => rt.Q4_2004,
						
						q='2005Q1' => rt.Q1_2005,
						q='2005Q2' => rt.Q2_2005,
					
						rt.Q3_2005);
						
	
	self.saleqtr_to_Q3_2005_multiplier := if(le.recording_date[1..6] between '199601' and '200509',multiplier,0);
	self.Q3_2005_valuation := if(le.recording_date[1..6] between '199601' and '200509', (integer)( (integer)le.sales_price * multiplier), -1);  // only do base table calculation for sales within that range
	self.Price_Index_Valuation := if(self.Q3_2005_valuation=0, (integer)((integer)le.sales_price * le.saleqtr_to_current_ofheo_ratio), 0);
	self.basetable_missing_county := self.Q3_2005_valuation=0;
	self := le;
end;

base_table1 := join(wOfheo, avm.File_PI_BaseTable,
						left.fips_code=right.fips_code and 
						left.land_use=right.land_use and
						ut.NNEQ(left.zip, right.zipcode),
						add_base(left,right), left outer, many lookup, keep(100));

base_table := distribute(base_table1, hash(seq));						
// output(with_base_table, named('with_base_table'));

// choose the calculation from each record, picking the one with a zip_level_multiplier as highest priority
sorted_base_table := sort(base_table, seq, -zip_level_multiplier, local);
with_base_table := dedup(sorted_base_table, seq, local);


pi_calculation_layout add_coefficients(pi_calculation_layout le, avm.File_PI_Coefficients rt) := transform
	self.ofheo_coef1 := if(rt.fips_code='', 9999, rt.coef1_ofheo);
	self.msp_coef1 := if(rt.fips_code='', 9999,rt.coef2_msp);
	self := le;
end;

w_coeff := join(with_base_table, avm.File_PI_Coefficients, left.fips_code=right.fips_code and left.land_use=right.land_use,
				add_coefficients(left,right), left outer, lookup);
//output(w_coeff);
*/


msp := avm.File_PI_Median_Sales;

pi_calculation_layout perform_valuation(pi_calculation_layout le, msp rt) := transform
	self.saleqtr_median_sales_price := (integer)rt.sales_price;
	self.q3_2005_base_msp := rt.q3_2005_base_msp;
	self.most_recent_quarter_msp := rt.most_recent_quarter_msp;
	self.most_recent_quarter := rt.most_recent_quarter;
	self.q3_2005_to_most_recent_quarter_ratio := rt.q3_2005_to_most_recent_quarter_ratio;
	self.sale_quarter_to_most_recent_ratio := rt.sale_quarter_to_most_recent_ratio;
	
	self.Price_Index_Valuation := map(rt.sale_quarter_to_most_recent_ratio <> 0 =>
									  (integer)le.sales_price * rt.sale_quarter_to_most_recent_ratio,
									  (integer)le.sales_price * le.saleqtr_to_current_ofheo_ratio);
									  
		
	// base := le.recording_date[1..6] between '199601' and '200509';
	// self.Price_Index_Valuation := map(// recording date isn't during the basetable timeframe, do the update table logic only
											  // ~base and le.ofheo_coef1=0 and rt.sale_quarter_to_most_recent_ratio <> 0 =>
													// (integer)le.sales_price * rt.sale_quarter_to_most_recent_ratio * le.msp_coef1,
											  // ~base and le.ofheo_coef1=0 and rt.sale_quarter_to_most_recent_ratio = 0 =>
													// (integer)le.sales_price * le.saleqtr_to_current_ofheo_ratio,
											  // ~base and le.ofheo_coef1<>0 and le.ofheo_coef1<>9999 =>
													// (integer)le.sales_price * le.saleqtr_to_current_ofheo_ratio * le.ofheo_coef1,
												// ~base and le.ofheo_coef1<>0 and le.ofheo_coef1=9999 =>
													// (integer)le.sales_price * le.saleqtr_to_current_ofheo_ratio,
											  
											  // // recording date is during the basetable timefram, use the base table logic combined with the update table logic
											  // base and le.ofheo_coef1=0 and rt.q3_2005_to_most_recent_quarter_ratio <>0 =>
													// (integer)le.Q3_2005_valuation * rt.q3_2005_to_most_recent_quarter_ratio * le.msp_coef1,
											  // base and le.ofheo_coef1=0 and rt.q3_2005_to_most_recent_quarter_ratio = 0 =>
													// (integer)le.Q3_2005_valuation * le.basetable_to_current_ofheo_ratio,
											  // base and le.ofheo_coef1<>0 and le.ofheo_coef1<>9999 =>
													// (integer)le.Q3_2005_valuation * le.basetable_to_current_ofheo_ratio * le.ofheo_coef1,
											
											  // le.Price_Index_Valuation = -1 => 0,	// set the final valuation to 0 if there was no sale from 1996-2005q3
													
											  // (integer)le.Price_Index_Valuation);
	
	self := le;
end;


PI_Valuation := join(wOfheo, msp, left.fips_code=right.fips_code and left.land_use=right.land_use and left.quarter=right.quarter,
				perform_valuation(left,right), left outer, lookup);			


output(PI_Valuation,,'~thor_data400::avm::pi_valuations', __compressed__, overwrite);

export File_PI_Valuations := PI_Valuation;
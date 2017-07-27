import ut;

export File_PI_Valuations(string8 history_date) := function

pi_deduped := avm_v2.File_AVM_PI_Records(history_date);

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


ofheo_file := avm_v2.File_OFHEO(history_date);

pi_calculation_layout get_ofheo_ratios(pi_deduped le, ofheo_file rt) := transform
	q := avm_v2.filters(history_date).quarter_map(le.recording_date);
	self.quarter := q;
	self.basetable_to_current_ofheo_ratio := rt.base_to_current_Ratio;
	self.saleqtr_to_current_ofheo_ratio := rt.current_ratio;
	
	// inserted to test ofheo only
	self.Price_Index_Valuation := (integer)((integer)le.sales_price * rt.current_ratio);
	self := le;
	self := [];
end;

wOfheo := join(pi_deduped, ofheo_file, 
					left.fips_code[1..2]=right.state_fips 
					and avm_v2.filters(history_date).quarter_map(left.recording_date)=right.quarter,
					get_ofheo_ratios(left,right), left outer, lookup);

msp := avm_v2.File_PI_Median_Sales(history_date);

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
									  
	self := le;
end;


PI_Valuation := join(wOfheo, msp, left.fips_code=right.fips_code and left.land_use=right.land_use and left.quarter=right.quarter,
				perform_valuation(left,right), left outer, lookup);	
				
output(PI_Valuation,,'~thor_data400::avm_v2::pi_valuations', __compressed__, overwrite);	
			
return pi_valuation;

end;

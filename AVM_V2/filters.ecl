import ut, LN_PropertyV2;

export filters(string8 history_date) := MODULE
	
	export valid_states := ['AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
							'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
							'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
							'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
							'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
							'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
							'WY'];

	export land_use_codes := ['','1000','1001','1002','1004','1010','1114'];  // codes blank, '1000' and '1001' are converted to land_use='1'(single family dwelling), all others are '2'(condo, multi unit dwelling)
	
	export bad_sales_price_codes := ['E','I','N','S','X','P','V','W','B']; 
	
	export bad_loan_type_codes := ['2','B','Q','E','R','X'];
		
	export quarter_map(string8 saledate) := map( saledate[5..6] between '01' and '03' => saledate[1..4] + 'Q1',
												 saledate[5..6] between '04' and '06' => saledate[1..4] + 'Q2',
												 saledate[5..6] between '07' and '09' => saledate[1..4] + 'Q3',
												 saledate[5..6] between '10' and '12' => saledate[1..4] + 'Q4',
												 '' );
	
	//Function for unformatted apns
	export stripFormat(string apn) := LN_PropertyV2.fn_strip_pnum(apn);
	
	export valid_date(string saledate) := ut.isNumeric(saledate) or trim(saledate)='' ;
	
	export minimum_sale_price := 5000;

	shared today1900 := ut.DaysSince1900(history_date[1..4], history_date[5..6], history_date[7..8]);
	
	export recent_sale_for_TA_ratio := ut.DateFrom_DaysSince1900(today1900-548);  // change to 548 to return a date from a year and a half ago
																				  // originally it was set at 365, but may not have enough sales
																				  // reported to do a ratio then.
																				  

	export days_ago_1095 := ut.DateFrom_DaysSince1900(today1900-1095); // within the past 3 years		
	export days_ago_731 := ut.DateFrom_DaysSince1900(today1900-731);  // within the past 2 years												
	export days_ago_548 := ut.DateFrom_DaysSince1900(today1900-548); 
	export days_ago_365 := ut.DateFrom_DaysSince1900(today1900-365);
	export days_ago_183 := ut.DateFrom_DaysSince1900(today1900-183);
																				  
	export recent_sale_for_Hedonic_model := ut.DateFrom_DaysSince1900(today1900-365);  

	export minimum_median_count := 10;
	
	export days_in_a_month := 30.5;
	export default_max_bin := 99999999999;
	export min_valuations_to_use_bins := 100;
	export earliest_history_build := '20040930';
		
end;

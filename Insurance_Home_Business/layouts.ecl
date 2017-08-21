import address;

export layout_foreclosure_monitoring := module

// Monitoring raw vendor layout
	export l_foreclosure_monitoring_IN := record
		string14	experian_bus_id;
		string36	business_name;
		string30	address_street;
		string13	city;
		string2		state;
		string5		zip;
		string4		zip4;
		string4		carrier_route;
		string3		fips_county_code;
		string30	county_name;
		string10	bus_phone_number;
		string4		msa_code;
		string50	msa_description;
		string16	geographic_code;
		string1		recent_update_code;
		string1		years_in_business_code;
		string4		business_started_year;
		string1		hotline_type;
		string6		hotline_date;
		string1		business_type_code;
		string1		address_type_code;
		string1		oxford_life_cycle_predictor;
		string7		est_no_of_employees;
		string1		emp_size_code;
		string7		est_annual_sales_amt;
		string1		annual_sales_size_code;
		string8		ownership_change_date;
		string1		ownership_code;
		string1		location_code;
		string1		primary_sic_code_industry_classification;
		string8		primary_sic_code;
		string8		second_sic_code;
		string8		third_sic_code;
		string8		fourth_sic_code;
		string3		filler;
		string6		primary_saics_code;
		string6		second_addl_saics_code;
		string6		third_addl_saics_code;
		string6		fouth_addl_saics_code;
		string140	primary_yellow_page_heading;
		string140	second_yellow_page_heading;
		string140	third_yellow_page_heading;
		string140	fourth_yellow_page_heading;
		string3		executive_count;
		string3		executive_honorific;
		string20	executive_last_name;
		string10	executive_first_name;
		string1		filler1;
		string10	executive_title;
		string9		tax_id;
		string50	url;
		string1		derogatory_legal_ind;
		string8		derogatory_legal_file_date;
		string19	legal_liability_amt;
		string1		ucc_data_ind;
		string3		ucc_count;
		string8		last_experian_inquiry_date;
		string9		recent_high_credit;
		string9		median_credit_amt;
		string3		total_combined_trade_lines;
		string3		dbt_combined_trade_totals;
		string9		combined_trade_balance;
		string3		aged_trade_lines_count;
		string3		percentage_trade_current;
		string3		percentage_trade_31_60_days_beyond;
		string3		percentage_trade_60_days_beyond;
		string1		experian_credit_rating;
		string9		bcs_file_number;
		string7		commercial_intelliscore;
		string3		intelliscore_percentile;
		string5		intelliscore_probability;
		string7		market_intelliscore;
		string3		quarter1_abg_dbt;
		string3		quarter2_abg_dbt;
		string3		quarter3_abg_dbt;
		string3		quarter4_abg_dbt;
		string3		quarter5_abg_dbt;
		string1		trailing_x;
		string2		lf;
	end;

// Monitoring temp layout
	export l_foreclosure_monitoring_temp := record
		unsigned6		bdid := 0;
		unsigned2		bdid_score := 0;
		string14		experian_bus_id;
		string36		business_name;
		qstring120	company_name;
		string1			business_type_code;
		string1			bus_flag := '';
		string1			res_flag := '';
		string1			home_bus_flag := '';
		string30		address_street;
		string13		city;
		string2			state;
		string5			zip;
		string4			zip4;
		string10		bus_phone_number;
		// Address.Layout_Clean182_fips clean_addr;
		string10        prim_range		; // [1..10]
		string2         predir				;	// [11..12]
		string28        prim_name			;	// [13..40]
		string4         addr_suffix		; // [41..44]
		string2         postdir				;	// [45..46]
		string10        unit_desig		;	// [47..56]
		string8         sec_range			;	// [57..64]
		string25        p_city_name		;	// [65..89]
		string25        v_city_name		; // [90..114]
		string2         st						;	// [115..116]
		string5         c_zip5					;	// [117..121]
		string4         c_zip4					;	// [122..125]
		string4         cart					;	// [126..129]
		string1         cr_sort_sz		;	// [130]
		string4         lot						;	// [131..134]
		string1         lot_order			;	// [135]
		string2         dbpc					;	// [136..137]
		string1         chk_digit			;	// [138]
		string2         rec_type			;	// [139..140]
		string2         fips_state		;	// [141..142]
		string3         fips_county		;	// [143..145]
		string10        geo_lat				;	// [146..155]
		string11        geo_long			;	// [156..166]
		string4         msa						;	// [167..170]
		string7         geo_blk				;	// [171..177]
		string1         geo_match			;	// [178]
		string4         err_stat			;	// [179..182]
	end;
	
// Monitoring Output Layout
	export l_foreclosure_monitoring_out := record
		string1		bus_flag := '';
		string1		res_flag := '';
		string1		home_bus_flag := '';
		l_foreclosure_monitoring_IN;
	end;
end;
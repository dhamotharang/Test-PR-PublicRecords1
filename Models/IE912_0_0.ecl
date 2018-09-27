import risk_indicators, ut, easi, std, riskview;

export IE912_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION
	IE_DEBUG := false;

	#IF(IE_DEBUG)
	Layout_debug := record
		risk_indicators.Layout_Boca_Shell clam;
		String adl_category;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_phonevalflag;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		Integer rc_disthphoneaddr;
		Boolean rc_fnamessnmatch;
		Integer combo_addrcount;
		Boolean lname_eda_sourced;
		Integer age;
		Integer add1_unit_count;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_automated_valuation_2;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Integer add1_naprop;
		String add1_mortgage_type;
		Integer property_sold_assessed_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Integer addrs_10yr;
		Integer gong_did_phone_ct;
		Integer addrs_per_adl;
		Integer attr_num_watercraft60;
		Integer attr_total_number_derogs;
		Integer attr_num_nonderogs90;
		Boolean Bankrupt;
		Integer date_last_seen;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_unrel_cj_last_seen;
		Integer liens_unrel_ot_total_amount;
		String ams_college_code;
		String ams_income_level_code;
		String prof_license_category;
		String wealth_index;
		Integer archive_date;
		Integer pk_wealth_index;
		Real pk_wealth_index_m;
		Integer wealth_index_cm;
		Boolean source_tot_DA;
		Boolean source_tot_CG;
		Boolean source_tot_P;
		Boolean source_tot_BA;
		Boolean source_tot_AM;
		Boolean source_tot_W;
		Boolean add_apt;
		Boolean bk_flag;
		Integer pk_bk_level;
		Integer add1_avm_med;
		Integer rc_valid_bus_phone;
		Integer rc_valid_res_phone;
		Integer age_rcd;
		Integer add1_mortgage_type_ord;
		Real prof_license_category_ord;
		Integer pk_attr_total_number_derogs;
		Integer pk_attr_total_number_derogs_2;
		Integer pk_attr_num_nonderogs90;
		Integer pk_attr_num_nonderogs90_2;
		Integer pk_derog_total;
		Integer pk_derog_total_m;
		Integer add1_avm_automated_valuation_rcd;
		Integer add1_avm_automated_val_2_rcd;
		Integer pk_liens_unrel_ot_total_amount;
		Integer attr_num_watercraft60_cap;
		Integer combo_addrcount_cap;
		Integer gong_did_phone_ct_cap;
		Integer ams_college_code_mis;
		Integer ams_college_code_cm;
		Integer ams_income_level_code_cm;
		Integer unit5;
		Integer pk_dist_a1toa2;
		Integer pk_dist_a1toa3;
		Integer pk_dist_a2toa3;
		Integer pk_rc_disthphoneaddr;
		Real pk_dist_a1toa2_m;
		Real pk_dist_a1toa3_m;
		Real pk_dist_a2toa3_m;
		Real pk_rc_disthphoneaddr_m;
		Real Dist_mod;
		Integer sysdate;
		Integer date_last_seen2;
		Integer liens_unrel_cj_last_seen2;
		Real years_date_last_seen;
		Real years_liens_unrel_cj_last_seen;
		Integer pk_yr_date_last_seen;
		Integer pk_bk_yr_date_last_seen;
		Real pk_bk_yr_date_last_seen_m1;
		Integer adl_category_ord;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk2_yr_liens_unrel_cj_last_seen;
		Real predicted_inc_high;
		Real predicted_inc_low;
		// Real pred_inc;
		Integer estimated_income;
		Integer estinc_bounded;
		Integer estimated_income_2;
	end;

	Layout_debug doModel( clam le ) := TRANSFORM
	#ELSE
	Risk_Indicators.Layout_Boca_Shell doModel( clam le ) := TRANSFORM
	#END
	
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_addrcount                  := le.iid.combo_addrcount;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		age                              := le.name_verification.age;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_avm_automated_valuation     := le.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;

		// because sysdate (line 337) checks for 999999, don't update to use ut.getdate here. archive_date isn't otherwise used, and this logic validated on 2010-03-12 w/Matt Waite.
		archive_date                     := le.historydate;


		NULL := -999999999;

		pk_wealth_index :=  map((integer)wealth_index <= 2 => 0,
								(integer)wealth_index <= 3 => 1,
								(integer)wealth_index <= 4 => 2,
								(integer)wealth_index <= 5 => 3,
															  4);

		pk_wealth_index_m :=  map(pk_wealth_index = 0 => 39116.676936,
								  pk_wealth_index = 1 => 43449.700792,
								  pk_wealth_index = 2 => 57061.910522,
								  pk_wealth_index = 3 => 82122.972447,
														 134020.49977);

		wealth_index_cm :=  map((integer)wealth_index = 0 => 35766,
								(integer)wealth_index = 1 => 32220,
								(integer)wealth_index = 2 => 35991,
								(integer)wealth_index = 3 => 39789,
								(integer)wealth_index = 4 => 46630,
								(integer)wealth_index = 5 => 52993,
								(integer)wealth_index = 6 => 55911,
															 43256);
		boolean findw( string sources, string src, string x, string y ) := Common.contains( ','+trim(sources,all), ','+src+',' );

		source_tot_DA := ((integer)findw(rc_sources, 'DA', ' ,', 'I') > 0);
		source_tot_CG := ((integer)findw(rc_sources, 'CG', ' ,', 'I') > 0);
		source_tot_P  := ((integer)findw(rc_sources, 'P',  ' ,', 'I') > 0);
		source_tot_BA := ((integer)findw(rc_sources, 'BA', ' ,', 'I') > 0);
		source_tot_AM := ((integer)findw(rc_sources, 'AM', ' ,', 'I') > 0);
		source_tot_W  := ((integer)findw(rc_sources, 'W',  ' ,', 'I') > 0);

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

		rc_valid_bus_phone :=  if((integer)rc_phonevalflag = 1, 1, 0);

		rc_valid_res_phone :=  if((integer)rc_phonevalflag = 2, 1, 0);

		age_rcd :=  map(age < 18 => 35,
						age > 60 => 35,
									age);

		add1_mortgage_type_ord :=  map(add1_mortgage_type in ['FHA']              => 1,
									   add1_mortgage_type in ['', ' ']            => 2,
									   add1_mortgage_type in ['2', 'E', 'N', 'U'] => 4,
																					 3);

		// generated code:
			// prof_license_category_ord :=  map((string)prof_license_category = '0' => 1,
											// prof_license_category in ['', ' ']  => 1.5,
											// prof_license_category);
		// rewritten code:
		prof_license_category_ord :=  map(
			prof_license_category = '0' => 1,
			prof_license_category in ['', ' ']  => 1.5,
			(integer1)prof_license_category
		);

		pk_attr_total_number_derogs := attr_total_number_derogs;

		pk_attr_total_number_derogs_2 :=  if((integer)pk_attr_total_number_derogs > 3, 3, pk_attr_total_number_derogs);

		pk_attr_num_nonderogs90 := attr_num_nonderogs90;

		pk_attr_num_nonderogs90_2 :=  if((integer)pk_attr_num_nonderogs90 > 4, 4, pk_attr_num_nonderogs90);

		pk_derog_total :=  if(pk_attr_total_number_derogs_2 > 0, pk_attr_total_number_derogs_2, (-1 * pk_attr_num_nonderogs90_2));

		pk_derog_total_m :=  map(pk_derog_total <= -4 => 51961,
								 pk_derog_total <= -3 => 49033,
								 pk_derog_total <= -2 => 45551,
								 pk_derog_total <= -1 => 40287,
								 pk_derog_total <= 0  => 42406,
								 pk_derog_total <= 1  => 40550,
								 pk_derog_total <= 2  => 38539,
								 pk_derog_total <= 3  => 37345,
														 43256);

		add1_avm_automated_valuation_rcd :=  if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);

		add1_avm_automated_val_2_rcd :=  if((integer)add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2);

		pk_liens_unrel_ot_total_amount :=  map((integer)liens_unrel_ot_total_amount <= 0     => -1,
											   (integer)liens_unrel_ot_total_amount <= 10000 => 0,
																								1);

		attr_num_watercraft60_cap :=  if((integer)attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

		combo_addrcount_cap :=  if(combo_addrcount > 6, 6, combo_addrcount);

		gong_did_phone_ct_cap :=  if((integer)gong_did_phone_ct > 5, 5, gong_did_phone_ct);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		ams_college_code_mis := if(trim(ams_college_code)='',1,0);

		ams_college_code_cm :=  map((integer)ams_college_code = 2 => 38463,
									(integer)ams_college_code = 4 => 49756,
																	 43256);

		ams_income_level_code_cm :=  map(ams_income_level_code in ['A', 'B', 'C'] => 38285,
										 ams_income_level_code = 'D'              => 39525,
										 ams_income_level_code = 'E'              => 42426,
										 ams_income_level_code = 'F'              => 44337,
										 ams_income_level_code = 'G'              => 46648,
										 ams_income_level_code = 'H'              => 48231,
										 ams_income_level_code = 'I'              => 49622,
										 ams_income_level_code = 'J'              => 52149,
										 ams_income_level_code = 'K'              => 53457,
																					 43095);

		unit5 :=  if((integer)add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));

		pk_dist_a1toa2 :=  map(dist_a1toa2 = 9999 => -1,
							   dist_a1toa2 <= 0   => 0,
							   dist_a1toa2 <= 9   => 1,
													 2);

		pk_dist_a1toa3 :=  map(dist_a1toa3 = 9999 => -1,
							   dist_a1toa3 <= 0   => 0,
							   dist_a1toa3 <= 30  => 1,
													 2);

		pk_dist_a2toa3 :=  map(dist_a2toa3 = 9999 => -1,
							   dist_a2toa3 <= 0   => 0,
							   dist_a2toa3 <= 9   => 1,
							   dist_a2toa3 <= 35  => 2,
													 3);

		pk_rc_disthphoneaddr :=  map(rc_disthphoneaddr = 9999 => 0,
									 rc_disthphoneaddr <= 3   => 0,
									 rc_disthphoneaddr <= 6   => 1,
									 rc_disthphoneaddr <= 12  => 2,
																 3);

		pk_dist_a1toa2_m :=  map(pk_dist_a1toa2 = -1 => 47044.838402,
								 pk_dist_a1toa2 = 0  => 56779.152604,
								 pk_dist_a1toa2 = 1  => 64372.446403,
														67159.04343);

		pk_dist_a1toa3_m :=  map(pk_dist_a1toa3 = -1 => 45641.502319,
								 pk_dist_a1toa3 = 0  => 57276.981937,
								 pk_dist_a1toa3 = 1  => 64982.162906,
														68001.554009);

		pk_dist_a2toa3_m :=  map(pk_dist_a2toa3 = -1 => 46484.736644,
								 pk_dist_a2toa3 = 0  => 56957.192413,
								 pk_dist_a2toa3 = 1  => 62973.959269,
								 pk_dist_a2toa3 = 2  => 65191.442627,
														70153.886806);

		pk_rc_disthphoneaddr_m :=  map(pk_rc_disthphoneaddr = 0 => 62474.417978,
									   pk_rc_disthphoneaddr = 1 => 63733.738308,
									   pk_rc_disthphoneaddr = 2 => 68541.171909,
																   83512.402545);

		Dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

		sysdate :=  map(archive_date = 999999  => Common.sas_date( (STRING)Std.Date.Today() ),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], '1') - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);

		date_last_seen2 :=  map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer1)(trim((string)date_last_seen, LEFT))[5..6]))), '1') - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))) - 1)),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) =>  (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer1)(trim((string)date_last_seen, LEFT))[5..6]))), '1') - ut.DaysSince1900('1960', '1', '1')),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) =>  (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], '1', '1') - ut.DaysSince1900('1960', '1', '1')),
																																									NULL);

		liens_unrel_cj_last_seen2 :=  map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), '1') - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))) - 1)),
								(length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4],  (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), '1') - ut.DaysSince1900('1960', '1', '1')),
								(length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], '1', '1') - ut.DaysSince1900('1960', '1', '1')),
																																									NULL);

		years_date_last_seen :=  if((sysdate != NULL) and (date_last_seen2 != NULL), ((sysdate - date_last_seen2) / 365.25), NULL);

		years_liens_unrel_cj_last_seen :=  if((sysdate != NULL) and (liens_unrel_cj_last_seen2 != NULL), ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL);

		pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

		pk_bk_yr_date_last_seen :=  map((real)pk_yr_date_last_seen = NULL => -1,
										(real)pk_yr_date_last_seen >= 9                        => 9,
																			 pk_yr_date_last_seen);

		pk_bk_yr_date_last_seen_m1 :=  map(pk_bk_yr_date_last_seen = -1 => 65447.971203,
										   pk_bk_yr_date_last_seen = 1  => 37195.924959,
										   pk_bk_yr_date_last_seen = 2  => 40666.992447,
										   pk_bk_yr_date_last_seen = 3  => 42965.336207,
										   pk_bk_yr_date_last_seen = 4  => 44669.167255,
										   pk_bk_yr_date_last_seen = 5  => 47563.390744,
										   pk_bk_yr_date_last_seen = 6  => 47917.954038,
										   pk_bk_yr_date_last_seen = 7  => 49396.154083,
										   pk_bk_yr_date_last_seen = 8  => 50099.973169,
										   pk_bk_yr_date_last_seen = 9  => 52557.404007,
																		   65447.971203);

		adl_category_ord := (integer)((string)adl_category = '1 DEAD');

		pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));

		pk2_yr_liens_unrel_cj_last_seen :=  map((real)pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
												pk_yr_liens_unrel_cj_last_seen <= 3          => 2,
												pk_yr_liens_unrel_cj_last_seen <= 5          => 1,
																								0);

		predicted_inc_high := -28552 +
			(pk_wealth_index_m * 0.51667) +
			((integer)source_tot_DA * 88499) +
			(add1_avm_med * 0.05448) +
			(prof_license_category_ord * 8167.93208) +
			(addrs_per_adl * 855.48025) +
			(pk_derog_total_m * 0.27963) +
			(add1_avm_automated_valuation_rcd * 0.01557) +
			(property_sold_assessed_total * 0.02413) +
			(attr_num_watercraft60_cap * 10490) +
			(age_rcd * 324.98302) +
			(combo_addrcount_cap * -2218.70449) +
			((integer)add_apt * -6810.8463) +
			((integer)source_tot_CG * 28047) +
			((integer)source_tot_W * 6718.13655) +
			(gong_did_phone_ct * 1414.7842) +
			(add1_mortgage_type_ord * 1825.91813) +
			((integer)source_tot_AM * 17169) +
			(rc_valid_bus_phone * 11042) +
			(pk_liens_unrel_ot_total_amount * 7931.02954) +
			(add1_avm_automated_val_2_rcd * 0.00826) +
			(ams_college_code_mis * -5323.07783) +
			(pk_bk_level * -1970.64639);

		predicted_inc_low := -45923 +
			(unit5 * -832.87755) +
			(wealth_index_cm * 0.58264) +
			(pk_derog_total_m * 0.09997) +
			(add1_avm_automated_valuation_rcd * 0.045) +
			(addrs_per_adl * 545.9244) +
			((integer)source_tot_W * 5334.71282) +
			(prof_license_category_ord * 5952.85069) +
			((integer)source_tot_P * 2443.25461) +
			(Dist_mod * 0.14399) +
			(pk_bk_yr_date_last_seen_m1 * 0.09757) +
			(adl_category_ord * -6304.92099) +
			((integer)rc_fnamessnmatch * 1785.49733) +
			(add1_mortgage_type_ord * 859.15454) +
			(pk2_yr_liens_unrel_cj_last_seen * -803.19148) +
			(ams_college_code_cm * 0.23431) +
			(attr_num_watercraft60_cap * 6294.24356) +
			(rc_valid_res_phone * -2008.73124) +
			(ams_income_level_code_cm * 0.08691) +
			(addrs_10yr * -375.39614) +
			(gong_did_phone_ct_cap * 630.52863) +
			((integer)source_tot_AM * 12757) +
			((integer)lname_eda_sourced * 1462.6333);

		pred_inc :=  if((integer)predicted_inc_high < 60000, (predicted_inc_low - 2000), (predicted_inc_high - 2000));


		estimated_income := (unsigned)common.round(pred_inc, 1000); 
		
		/* changes to min/max overrides and 222 being changed to 0 are per 2010-03-09 email from Mike Woodberry:
			0 = Unable to calculate predicted annual income
			19,999 = Predicted annual income less than $20,000 annually
			20,000 - 250,000 = Predicted annual income amount
			250,999 = Predicted annual income greater than $250,000 annually
		*/
		estinc_bounded := map(
			estimated_income < 20000  => 19999,
			estimated_income > 250000 => 250999,
			estimated_income
		);
  

		estimated_income_2 :=  if(riskview.Constants.noscore(nas_summary, nap_summary, add1_naprop, le.truedid), 0, estinc_bounded);


		#if(IE_DEBUG)
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_addrcount := combo_addrcount;
			self.lname_eda_sourced := lname_eda_sourced;
			self.age := age;
			self.add1_unit_count := add1_unit_count;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.addrs_10yr := addrs_10yr;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.addrs_per_adl := addrs_per_adl;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.archive_date := archive_date;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_P := source_tot_P;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_W := source_tot_W;
			self.add_apt := add_apt;
			self.bk_flag := bk_flag;
			self.pk_bk_level := pk_bk_level;
			self.add1_avm_med := add1_avm_med;
			self.rc_valid_bus_phone := rc_valid_bus_phone;
			self.rc_valid_res_phone := rc_valid_res_phone;
			self.age_rcd := age_rcd;
			self.add1_mortgage_type_ord := add1_mortgage_type_ord;
			self.prof_license_category_ord := prof_license_category_ord;
			self.pk_attr_total_number_derogs := pk_attr_total_number_derogs;
			self.pk_attr_total_number_derogs_2 := pk_attr_total_number_derogs_2;
			self.pk_attr_num_nonderogs90 := pk_attr_num_nonderogs90;
			self.pk_attr_num_nonderogs90_2 := pk_attr_num_nonderogs90_2;
			self.pk_derog_total := pk_derog_total;
			self.pk_derog_total_m := pk_derog_total_m;
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
			self.add1_avm_automated_val_2_rcd := add1_avm_automated_val_2_rcd;
			self.pk_liens_unrel_ot_total_amount := pk_liens_unrel_ot_total_amount;
			self.attr_num_watercraft60_cap := attr_num_watercraft60_cap;
			self.combo_addrcount_cap := combo_addrcount_cap;
			self.gong_did_phone_ct_cap := gong_did_phone_ct_cap;
			self.ams_college_code_mis := ams_college_code_mis;
			self.ams_college_code_cm := ams_college_code_cm;
			self.ams_income_level_code_cm := ams_income_level_code_cm;
			self.unit5 := unit5;
			self.pk_dist_a1toa2 := pk_dist_a1toa2;
			self.pk_dist_a1toa3 := pk_dist_a1toa3;
			self.pk_dist_a2toa3 := pk_dist_a2toa3;
			self.pk_rc_disthphoneaddr := pk_rc_disthphoneaddr;
			self.pk_dist_a1toa2_m := pk_dist_a1toa2_m;
			self.pk_dist_a1toa3_m := pk_dist_a1toa3_m;
			self.pk_dist_a2toa3_m := pk_dist_a2toa3_m;
			self.pk_rc_disthphoneaddr_m := pk_rc_disthphoneaddr_m;
			self.Dist_mod := Dist_mod;
			self.sysdate := sysdate;
			self.date_last_seen2 := date_last_seen2;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.adl_category_ord := adl_category_ord;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.estimated_income := estimated_income;
			self.estinc_bounded := estinc_bounded;
			self.estimated_income_2 := estimated_income_2;
			self.clam := le;
		#else
			self.estimated_income := estimated_income_2;
			self := le;
		#end

	END;
	
	results := project(clam, doModel(left));

	return results;
END;
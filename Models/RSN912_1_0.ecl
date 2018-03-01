import ut, Risk_Indicators, RiskWise, easi, std;

export RSN912_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

	RSN_DEBUG := false;

	temp := record
		Risk_Indicators.Layout_Boca_Shell;
		string15 cus_chargeoff_amt := '';
	end;

	temp add_rs(clam le, recoverscore_batchin rt) := TRANSFORM 
		self.cus_chargeoff_amt := rt.debt_amount;
		self := le;
	end;

	with_rs_batchin := join(clam, recoverscore_batchin, left.seq=right.seq, add_rs(left,right));


	sysyear := (integer)(ut.GetDate[1..4]);

	#if(RSN_DEBUG)
	Layout_DEBUG := record
		with_rs_batchin;
		String in_dob;
		Integer NAP_Summary;
		String nap_type;
		String nap_status;
		Boolean add1_isbestmatch;
		Integer add1_naprop;
		Integer add1_date_first_seen;
		Integer property_owned_total;
		Integer dist_a1toa2;
		Integer add2_date_first_seen;
		Integer add3_date_first_seen;
		Integer ssns_per_adl;
		Integer ssns_per_adl_c6;
		Integer date_last_seen;
		String disposition;
		Integer filing_count;
		Integer bk_disposed_historical_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_recent_released_count;
		Integer liens_historical_released_count;
		Integer criminal_count;
		Integer felony_count;
		Integer rel_count;
		Integer rel_prop_owned_count;
		Integer rel_within25miles_count;
		Integer rel_within100miles_count;
		Integer rel_within500miles_count;
		Integer current_count;
		Integer historical_count;
		Integer inferred_dob;
		String archive_date;
		String C_BORN_USA;
		String C_SPAN_LANG;
		String Curr_Debt_Amt;
		Integer adl_hphn;
		Real Curr_Debt_Amt_lg;
		String sys_norm;
		Integer sysdate;
		String bk_norm;
		Integer bk_last_seen;
		Integer yrs_since_bk;
		Integer bk_lvl;
		Real bk_lvl_m;
		Integer lien_unr_lvl;
		Boolean rel_lien_flag;
		Integer combo_lien_lvl_b1;
		Integer combo_lien_lvl_b2;
		Integer combo_lien_lvl;
		Real combo_lien_lvl_m;
		Integer criminal_lvl;
		Real criminal_lvl_m;
		Integer rel_25MilesLess_count;
		Integer rel_100MilesLess_count;
		Integer rel_500MilesLess_count;
		Integer rel_500milesless_pct;
		Integer rel_500milesless_pct_a;
		Real rel_500milesless_pct_a_m;
		Integer rel_prop_own_pct;
		Integer rel_prop_own_pct_a;
		Real rel_prop_own_pct_a_m;
		Integer add1_naprop_lvl_b1;
		Integer add1_naprop_lvl_b2;
		Integer add1_naprop_lvl;
		Real add1_naprop_lvl_m;
		Integer add1_first_seen;
		Integer add2_first_seen;
		Integer add3_first_seen;
		Integer yrs_since_add1_first_seen;
		Integer yrs_since_add2_first_seen;
		Integer yrs_since_add3_first_seen;
		Integer addrs_seen_within_15;
		Integer addrs_seen_within_10;
		Integer addrs_seen_within_5;
		Integer addr_history_lvl;
		Real addr_history_lvl_m;
		Integer ssns_per_adl_lvl;
		Real ssns_per_adl_lvl_m;
		Integer car_count_lvl;
		Real car_count_lvl_m;
		Integer infer_date;
		Integer dob;
		Integer combo_age;
		Integer age_group;
		Real age_group_m;
		Integer c_born_usa_lvl;
		Real c_born_usa_lvl_m;
		Integer c_span_lang_lvl;
		Real c_span_lang_lvl_m;
		Boolean contrary_phn;
		Boolean verfst_p;
		Boolean verlst_p;
		Boolean veradd_p;
		Boolean verphn_p;
		Integer nap_ver1;
		Integer nap_ver2;
		Integer nap_ver3;
		Real nap_ver3_m;
		Integer adl_phn_lvl;
		Real adl_phn_lvl_m;
		Integer base;
		Integer point;
		Real odds;
		Real CUS_log;
		Real phat;
		Integer RSN912_1_0;
		Integer RSN912_1_0_2;
	END;
	
	Layout_DEBUG doModel(with_rs_batchin le, easi.Key_Easi_Census ri) := TRANSFORM
	#else
	Layout_RecoverScore doModel(with_rs_batchin le, easi.Key_Easi_Census ri) := TRANSFORM
	#end

		in_dob                           := le.shell_input.dob;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		nap_status                       := le.iid.nap_status;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		date_last_seen                   := le.bjl.date_last_seen;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		rel_count                        := le.relatives.relative_count;
		rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
		rel_within25miles_count          := le.relatives.relative_within25miles_count;
		rel_within100miles_count         := le.relatives.relative_within100miles_count;
		rel_within500miles_count         := le.relatives.relative_within500miles_count;
		current_count                    := le.vehicles.current_count;
		historical_count                 := le.vehicles.historical_count;
		inferred_dob                     := le.reported_dob;
		archive_date                     := if( le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.historydate );
		C_BORN_USA                       := ri.born_usa;
		C_SPAN_LANG                      := ri.span_lang;
		Curr_Debt_Amt                    := le.cus_chargeoff_amt;
		adl_hphn                         := le.ADL_Shell_Flags.adl_hphn; //  results of ADL search on hphone


		string normalize_date( string indate ) := if( length(trim(indate)) not in [6,8], '',
		// string normalize_date( string indate ) := if( length(trim(indate)) not in [6,8] or indate[1..2] not in ['19','20'], '',
			indate[1..4] // year
			+ intformat( min(12,max(1,(integer1)indate[5..6])), 2, 1 ) // month from 01-12
			+ if( length(indate)=6, '01', // default to a day of 01 when not present
				intformat(max(1,min( (integer1)indate[7..8],
					/* NUMBER OF DAYS IN THE MONTH */
					map(
						(integer1)indate[5..6] = 2             => 28,
						min(12,max(1,(integer1)indate[5..6])) in [1,3,5,7,8,10,12] => 31,
						30
					) /* END DAYS IN MONTH */
				)), 2, 1 )
			)
		);
		integer4 sas_date( string indate ) := /* indate assumed to be valid - possibly output from normalized_date */
			if( indate = '', -999999999,
			ut.DaysSince1900( indate[1..4], indate[5..6], indate[7..8] )
			- ut.DaysSince1900( '1960', '01', '01')
		);
		


		NULL := -999999999;


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		Curr_Debt_Amt_lg := if( (real)curr_debt_amt <= 0, ln(7200), ln(max((real)curr_debt_amt, 1)) );

		sys_norm := normalize_date( (string)archive_date );
		sysdate  := sas_date( sys_norm );

		bk_norm := normalize_date( (string)date_last_seen );
		bk_last_seen := sas_date( bk_norm );

		yrs_since_bk := truncate(((sysdate - bk_last_seen) / 365.25));

		bk_lvl :=  map(
					   bk_last_seen = NULL                                                              => -1,
					   ((integer)contains_i(disposition, 'Discharge') > 0) and (yrs_since_bk > 0)       => 2,
					   (integer)contains_i(disposition, 'Dismissed') > 0                                => 1,
					   (filing_count > 0) or ((yrs_since_bk > 0) or (bk_disposed_historical_count > 0)) => 0,
																										   -1);

		bk_lvl_m :=  map(bk_lvl = -1 => 0.0658282044,
						 bk_lvl = 0  => 0.0242424242,
						 bk_lvl = 1  => 0.0554493308,
										0.0758440323);

		lien_unr_lvl :=  map((liens_historical_unreleased_ct in [2, 3]) and (liens_recent_released_count = 0) => 2,
							 (liens_historical_unreleased_ct = 2) and (liens_recent_released_count = 1)       => 2,
							 liens_recent_unreleased_count = 0                                                => 1,
																												 0);

		rel_lien_flag := ((boolean)liens_recent_released_count or (boolean)liens_historical_released_count);

		combo_lien_lvl_b1 := map(lien_unr_lvl = 2 => 4,
								 lien_unr_lvl = 1 => 3,
													 1);

		combo_lien_lvl_b2 := map(lien_unr_lvl = 2 => 1,
								 lien_unr_lvl = 1 => 2,
													 0);

		combo_lien_lvl := if(rel_lien_flag, combo_lien_lvl_b1, combo_lien_lvl_b2);

		combo_lien_lvl_m :=  map(combo_lien_lvl = 0 => 0.0471811275,
								 combo_lien_lvl = 1 => 0.062266965,
								 combo_lien_lvl = 2 => 0.0677407543,
								 combo_lien_lvl = 3 => 0.0706300813,
													   0.0839622642);

		criminal_lvl :=  map(felony_count > 0   => 4,
							 criminal_count > 4 => 3,
							 criminal_count > 1 => 2,
							 criminal_count > 0 => 1,
												   0);

		criminal_lvl_m :=  map(criminal_lvl = 0 => 0.0715822619,
							   criminal_lvl = 1 => 0.0512382579,
							   criminal_lvl = 2 => 0.0471923536,
							   criminal_lvl = 3 => 0.0436507937,
												   0.0350649351);

		rel_25MilesLess_count := rel_within25miles_count;

		rel_100MilesLess_count := if(max(rel_25MilesLess_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_25MilesLess_count = NULL, 0, rel_25MilesLess_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count)));

		rel_500MilesLess_count := if(max(rel_100MilesLess_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_100MilesLess_count = NULL, 0, rel_100MilesLess_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count)));


		// if rel_count > 0 then rel_500MilesLess_pct = int( rel_500MilesLess_count / rel_count * 100 );
     
		rel_500milesless_pct :=  if(rel_count > 0, truncate((100*rel_500MilesLess_count/rel_count)), NULL);

		rel_500milesless_pct_a :=  map(rel_count = 0              => 3,
									   rel_500milesless_pct < 10  => 0,
									   rel_500milesless_pct < 60  => 1,
									   rel_500milesless_pct < 100 => 2,
																	 3);

		rel_500milesless_pct_a_m :=  map(rel_500milesless_pct_a = 0 => 0.0362694301,
										 rel_500milesless_pct_a = 1 => 0.0563658838,
										 rel_500milesless_pct_a = 2 => 0.0668047644,
																	   0.0718905099);

		rel_prop_own_pct :=  if(rel_count > 0, truncate((100*rel_prop_owned_count /rel_count)), NULL);

		rel_prop_own_pct_a :=  map(rel_count = 0           => 4,
								   rel_prop_own_pct >= 100 => 4,
								   rel_prop_own_pct >= 20  => 3,
								   rel_prop_own_pct >= 10  => 2,
								   rel_prop_own_pct > 0    => 1,
															  0);

		rel_prop_own_pct_a_m :=  map(rel_prop_own_pct_a = 0 => 0.0558759913,
									 rel_prop_own_pct_a = 1 => 0.0582474227,
									 rel_prop_own_pct_a = 2 => 0.0643289606,
									 rel_prop_own_pct_a = 3 => 0.0738413197,
															   0.0904109589);

		add1_naprop_lvl_b1 := map((property_owned_total > 0) and (add1_naprop in [3, 4]) => 4,
								  (property_owned_total = 0) and (add1_naprop in [3, 4]) => 3,
								  add1_naprop in [1, 2]                                  => 1,
																							2);

		add1_naprop_lvl_b2 := map(dist_a1toa2 = 9999                                                                                                           => 4,
								  ((100 < dist_a1toa2) AND (dist_a1toa2 < 9999)) or (((0 < dist_a1toa2) AND (dist_a1toa2 <= 100)) and (add1_naprop in [1, 2])) => 0,
								  ((0 < dist_a1toa2) AND (dist_a1toa2 <= 100)) and (add1_naprop in [3, 4])                                                     => 3,
								  (dist_a1toa2 = 0) and (add1_naprop in [2, 3, 4])                                                                             => 1,
																																								  2);

		add1_naprop_lvl := if(add1_isbestmatch, add1_naprop_lvl_b1, add1_naprop_lvl_b2);

		add1_naprop_lvl_m :=  map(add1_naprop_lvl = 0 => 0.0269230769,
								  add1_naprop_lvl = 1 => 0.0508447813,
								  add1_naprop_lvl = 2 => 0.0607259825,
								  add1_naprop_lvl = 3 => 0.0752791069,
														 0.0832303255);

		add1_first_seen := sas_date(normalize_date( (string)add1_date_first_seen ));
		add2_first_seen := sas_date(normalize_date( (string)add2_date_first_seen ));
		add3_first_seen := sas_date(normalize_date( (string)add3_date_first_seen ));

		yrs_since_add1_first_seen := truncate(((sysdate - add1_first_seen) / 365.25));
		yrs_since_add2_first_seen := truncate(((sysdate - add2_first_seen) / 365.25));
		yrs_since_add3_first_seen := truncate(((sysdate - add3_first_seen) / 365.25));

		addrs_seen_within_15 :=  if(add1_isbestmatch, if(max((integer)(yrs_since_add1_first_seen <= 15), (integer)(yrs_since_add2_first_seen <= 15), (integer)(yrs_since_add3_first_seen <= 15)) = NULL, NULL, sum((integer)(yrs_since_add1_first_seen <= 15), (integer)(yrs_since_add2_first_seen <= 15), (integer)(yrs_since_add3_first_seen <= 15))), (if(max((integer)(yrs_since_add2_first_seen <= 15), (integer)(yrs_since_add3_first_seen <= 15)) = NULL, NULL, sum((integer)(yrs_since_add2_first_seen <= 15), (integer)(yrs_since_add3_first_seen <= 15))) + 1));
		addrs_seen_within_10 :=  if(add1_isbestmatch, if(max((integer)(yrs_since_add1_first_seen <= 10), (integer)(yrs_since_add2_first_seen <= 10), (integer)(yrs_since_add3_first_seen <= 10)) = NULL, NULL, sum((integer)(yrs_since_add1_first_seen <= 10), (integer)(yrs_since_add2_first_seen <= 10), (integer)(yrs_since_add3_first_seen <= 10))), (if(max((integer)(yrs_since_add2_first_seen <= 10), (integer)(yrs_since_add3_first_seen <= 10)) = NULL, NULL, sum((integer)(yrs_since_add2_first_seen <= 10), (integer)(yrs_since_add3_first_seen <= 10))) + 1));
		addrs_seen_within_5 :=  if(add1_isbestmatch, if(max((integer)(yrs_since_add1_first_seen <= 5), (integer)(yrs_since_add2_first_seen <= 5), (integer)(yrs_since_add3_first_seen <= 5)) = NULL, NULL, sum((integer)(yrs_since_add1_first_seen <= 5), (integer)(yrs_since_add2_first_seen <= 5), (integer)(yrs_since_add3_first_seen <= 5))), (if(max((integer)(yrs_since_add2_first_seen <= 5), (integer)(yrs_since_add3_first_seen <= 5)) = NULL, NULL, sum((integer)(yrs_since_add2_first_seen <= 5), (integer)(yrs_since_add3_first_seen <= 5))) + 1));

		addr_history_lvl :=  map(((addrs_seen_within_15 = 0) and (property_owned_total > 0)) or ((addrs_seen_within_10 = 0) and (property_owned_total > 0))     => 7,
								 ((addrs_seen_within_15 = 1) and (property_owned_total > 0)) or ((addrs_seen_within_10 = 1) and (property_owned_total > 0))     => 6,
								 (addrs_seen_within_15 in [0, 1]) or ((addrs_seen_within_10 = 0) or ((addrs_seen_within_5 = 0) and (property_owned_total = 0))) => 5,
								 (addrs_seen_within_15 = 2) or ((addrs_seen_within_10 = 1) or (addrs_seen_within_5 = 0))                                        => 4,
								 ((addrs_seen_within_10 = 2) and (property_owned_total > 0)) or ((addrs_seen_within_5 = 1) and (property_owned_total > 0))      => 3,
								 (addrs_seen_within_10 = 2) or (addrs_seen_within_5 = 1)                                                                        => 2,
								 addrs_seen_within_5 = 2                                                                                                        => 1,
																																								   0);

		addr_history_lvl_m :=  map(addr_history_lvl = 0 => 0.0438763831,
								   addr_history_lvl = 1 => 0.0496735075,
								   addr_history_lvl = 2 => 0.054192229,
								   addr_history_lvl = 3 => 0.0654490107,
								   addr_history_lvl = 4 => 0.0748113998,
								   addr_history_lvl = 5 => 0.0955380577,
								   addr_history_lvl = 6 => 0.1027364378,
														   0.1288590604);

		ssns_per_adl_lvl :=  map((ssns_per_adl in [1, 2]) and (ssns_per_adl_c6 = 0) => 3,
								 (ssns_per_adl > 2) and (ssns_per_adl_c6 = 0)       => 2,
								 (ssns_per_adl = 2) and (ssns_per_adl_c6 = 1)       => 0,
																					   1);

		ssns_per_adl_lvl_m :=  map(ssns_per_adl_lvl = 0 => 0.0439519159,
								   ssns_per_adl_lvl = 1 => 0.0531821046,
								   ssns_per_adl_lvl = 2 => 0.0702875399,
														   0.0781299027);

		car_count_lvl :=  map((current_count > 4) and (historical_count < 8) => 6,
							  (current_count = 4) and (historical_count < 7) => 6,
							  (current_count = 3) and (historical_count < 6) => 5,
							  (current_count = 2) and (historical_count < 3) => 4,
							  historical_count < 2                           => 4,
							  (current_count = 2) and (historical_count < 4) => 3,
							  historical_count < 3                           => 3,
							  current_count > 4                              => 2,
							  (current_count > 2) and (historical_count < 8) => 2,
							  (current_count > 1) and (historical_count < 7) => 2,
							  historical_count < 4                           => 2,
							  (current_count = 2) and (historical_count > 9) => 0,
							  (current_count = 1) and (historical_count > 8) => 0,
							  (current_count = 0) and (historical_count > 7) => 0,
																				1);

		car_count_lvl_m :=  map(car_count_lvl = 0 => 0.0368188513,
								car_count_lvl = 1 => 0.0483383686,
								car_count_lvl = 2 => 0.0600663524,
								car_count_lvl = 3 => 0.0658449562,
								car_count_lvl = 4 => 0.0740317605,
								car_count_lvl = 5 => 0.0803418803,
													 0.0964550701);

		infer_date := sas_date( normalize_date( (string)inferred_dob ));
		dob        := sas_date( normalize_date( (string)in_dob ));
		
		combo_age := map(
			NULL not in [sysdate,dob]        => min(max( (integer)(( sysdate - dob        ) / 365.25 ),0),100),
			NULL not in [sysdate,infer_date] => min(max( (integer)(( sysdate - infer_date ) / 365.25 ),0),100),
			-1
		);
		
		age_group :=  map(combo_age > 60 => 60,
						  combo_age > 50 => 50,
						  combo_age > 40 => 40,
						  combo_age > 30 => 30,
						  combo_age > 18 => 18,
											60);

		age_group_m :=  map(age_group = 18 => 0.0440647482,
							age_group = 30 => 0.0525996665,
							age_group = 40 => 0.0664855362,
							age_group = 50 => 0.0838958534,
											  0.1004130918);

		c_born_usa_lvl :=  map(
								'' = trim(c_born_usa) => 2, // for when c_born_usa is missing
							    (0 <= (integer)c_born_usa) AND ((integer)c_born_usa < 10)   => 0,
							   (10 <= (integer)c_born_usa) AND ((integer)c_born_usa < 40)  => 1,
							   (40 <= (integer)c_born_usa) AND ((integer)c_born_usa < 110) => 2,
							   110 <= (integer)c_born_usa                                  => 3,
																							  2);

		c_born_usa_lvl_m :=  map(c_born_usa_lvl = 0 => 0.0377358491,
								 c_born_usa_lvl = 1 => 0.049726776,
								 c_born_usa_lvl = 2 => 0.0623757195,
													   0.0779887619);

		c_span_lang_lvl :=  map(
								''=trim(c_span_lang) => 1, // for when c_span_lang is missing
								(0 <= (integer)c_span_lang) AND ((integer)c_span_lang < 60)    => 5,
								(60 <= (integer)c_span_lang) AND ((integer)c_span_lang < 100)  => 4,
								(100 <= (integer)c_span_lang) AND ((integer)c_span_lang < 130) => 3,
								(130 <= (integer)c_span_lang) AND ((integer)c_span_lang < 160) => 2,
								(160 <= (integer)c_span_lang) AND ((integer)c_span_lang < 180) => 1,
								180 <= (integer)c_span_lang                                    => 0,
																								  1);

		c_span_lang_lvl_m :=  map(c_span_lang_lvl = 0 => 0.0412436548,
								  c_span_lang_lvl = 1 => 0.0532544379,
								  c_span_lang_lvl = 2 => 0.056408965,
								  c_span_lang_lvl = 3 => 0.0682281059,
								  c_span_lang_lvl = 4 => 0.0731960907,
														 0.086500181);

		contrary_phn := (nap_summary in [1]);

		verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);
		verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
		veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
		verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		nap_ver1 :=  map(contrary_phn                              => 0,
						 veradd_p and verphn_p                     => 2,
						 veradd_p and (verlst_p and not(verfst_p)) => 2,
																	  1);

		nap_ver2 :=  map((nap_ver1 = 2) and (nap_type in ['A', 'P']) => 4,
						 (nap_ver1 = 1) and (nap_type = 'A')         => 3,
						 (nap_ver1 = 1) and (nap_type = 'U')         => 1,
						 nap_ver1 = 0                                => 0,
																		2);

		nap_ver3 :=  if(nap_status = 'D', 0, nap_ver2);

		nap_ver3_m :=  map(nap_ver3 = 0 => 0.045392022,
						   nap_ver3 = 1 => 0.0493909192,
						   nap_ver3 = 2 => 0.0658643037,
						   nap_ver3 = 3 => 0.0725294651,
										   0.0884353741);

		adl_phn_lvl :=  map(adl_hphn = 2 => 2,
							adl_hphn = 1 => 0,
										    1);

		adl_phn_lvl_m :=  map(adl_phn_lvl = 0 => 0.035158212,
							  adl_phn_lvl = 1 => 0.0631132461,
												 0.1046741277);

		base := 700;
		point := 50;
		odds  := .06598/(1-.06598);

		CUS_log := -6.302765209 +
			(bk_lvl_m * 21.258859964) +
			(combo_lien_lvl_m * 13.323276016) +
			(criminal_lvl_m * 6.8436564069) +
			(rel_500milesless_pct_a_m * 12.47372758) +
			(rel_prop_own_pct_a_m * 6.3978227543) +
			(add1_naprop_lvl_m * 5.5040443746) +
			(addr_history_lvl_m * 3.4623109744) +
			(ssns_per_adl_lvl_m * 5.3669067689) +
			(car_count_lvl_m * 12.406080142) +
			(age_group_m * 7.8639877919) +
			(c_born_usa_lvl_m * 7.0451982981) +
			(c_span_lang_lvl_m * 7.0502912222) +
			(nap_ver3_m * 6.0850744315) +
			(adl_phn_lvl_m * 8.6395976166) +
			(Curr_Debt_Amt_lg * -0.562484384);

		phat := (exp(CUS_log) / (1 + exp(CUS_log)));
		RSN912_1_0 := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));
		RSN912_1_0_2 := max(300, min(999, if(RSN912_1_0 = NULL, -NULL, RSN912_1_0)));

		#if(RSN_DEBUG)
			self := le;
			self.in_dob := in_dob;
			self.nap_summary := nap_summary;
			self.nap_type := nap_type;
			self.nap_status := nap_status;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_naprop := add1_naprop;
			self.add1_date_first_seen := add1_date_first_seen;
			self.property_owned_total := property_owned_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.add2_date_first_seen := add2_date_first_seen;
			self.add3_date_first_seen := add3_date_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.date_last_seen := date_last_seen;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_recent_released_count := liens_recent_released_count;
			self.liens_historical_released_count := liens_historical_released_count;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.rel_count := rel_count;
			self.rel_prop_owned_count := rel_prop_owned_count;
			self.rel_within25miles_count := rel_within25miles_count;
			self.rel_within100miles_count := rel_within100miles_count;
			self.rel_within500miles_count := rel_within500miles_count;
			self.current_count := current_count;
			self.historical_count := historical_count;
			self.inferred_dob := inferred_dob;
			self.archive_date := archive_date;
			self.C_BORN_USA := C_BORN_USA;
			self.C_SPAN_LANG := C_SPAN_LANG;
			self.Curr_Debt_Amt := Curr_Debt_Amt;
			self.adl_hphn := adl_hphn;
			self.Curr_Debt_Amt_lg := Curr_Debt_Amt_lg;
			self.sys_norm := sys_norm;
			self.sysdate := sysdate;
			self.bk_norm := bk_norm;
			self.bk_last_seen := bk_last_seen;
			self.yrs_since_bk := yrs_since_bk;
			self.bk_lvl := bk_lvl;
			self.bk_lvl_m := bk_lvl_m;
			self.lien_unr_lvl := lien_unr_lvl;
			self.rel_lien_flag := rel_lien_flag;
			self.combo_lien_lvl_b1 := combo_lien_lvl_b1;
			self.combo_lien_lvl_b2 := combo_lien_lvl_b2;
			self.combo_lien_lvl := combo_lien_lvl;
			self.combo_lien_lvl_m := combo_lien_lvl_m;
			self.criminal_lvl := criminal_lvl;
			self.criminal_lvl_m := criminal_lvl_m;
			self.rel_25MilesLess_count := rel_25MilesLess_count;
			self.rel_100MilesLess_count := rel_100MilesLess_count;
			self.rel_500MilesLess_count := rel_500MilesLess_count;
			self.rel_500milesless_pct := rel_500milesless_pct;
			self.rel_500milesless_pct_a := rel_500milesless_pct_a;
			self.rel_500milesless_pct_a_m := rel_500milesless_pct_a_m;
			self.rel_prop_own_pct := rel_prop_own_pct;
			self.rel_prop_own_pct_a := rel_prop_own_pct_a;
			self.rel_prop_own_pct_a_m := rel_prop_own_pct_a_m;
			self.add1_naprop_lvl_b1 := add1_naprop_lvl_b1;
			self.add1_naprop_lvl_b2 := add1_naprop_lvl_b2;
			self.add1_naprop_lvl := add1_naprop_lvl;
			self.add1_naprop_lvl_m := add1_naprop_lvl_m;
			self.add1_first_seen := add1_first_seen;
			self.add2_first_seen := add2_first_seen;
			self.add3_first_seen := add3_first_seen;
			self.yrs_since_add1_first_seen := yrs_since_add1_first_seen;
			self.yrs_since_add2_first_seen := yrs_since_add2_first_seen;
			self.yrs_since_add3_first_seen := yrs_since_add3_first_seen;
			self.addrs_seen_within_15 := addrs_seen_within_15;
			self.addrs_seen_within_10 := addrs_seen_within_10;
			self.addrs_seen_within_5 := addrs_seen_within_5;
			self.addr_history_lvl := addr_history_lvl;
			self.addr_history_lvl_m := addr_history_lvl_m;
			self.ssns_per_adl_lvl := ssns_per_adl_lvl;
			self.ssns_per_adl_lvl_m := ssns_per_adl_lvl_m;
			self.car_count_lvl := car_count_lvl;
			self.car_count_lvl_m := car_count_lvl_m;
			self.infer_date := infer_date;
			self.dob := dob;
			self.combo_age := combo_age;
			self.age_group := age_group;
			self.age_group_m := age_group_m;
			self.c_born_usa_lvl := c_born_usa_lvl;
			self.c_born_usa_lvl_m := c_born_usa_lvl_m;
			self.c_span_lang_lvl := c_span_lang_lvl;
			self.c_span_lang_lvl_m := c_span_lang_lvl_m;
			self.contrary_phn := contrary_phn;
			self.verfst_p := verfst_p;
			self.verlst_p := verlst_p;
			self.veradd_p := veradd_p;
			self.verphn_p := verphn_p;
			self.nap_ver1 := nap_ver1;
			self.nap_ver2 := nap_ver2;
			self.nap_ver3 := nap_ver3;
			self.nap_ver3_m := nap_ver3_m;
			self.adl_phn_lvl := adl_phn_lvl;
			self.adl_phn_lvl_m := adl_phn_lvl_m;
			self.base := base;
			self.point := point;
			self.odds := odds;
			self.CUS_log := CUS_log;
			self.phat := phat;
			self.RSN912_1_0 := RSN912_1_0;
			self.RSN912_1_0_2 := RSN912_1_0_2;
		#else
		self.seq           := (string)le.seq;
		self.recover_score := (string)RSN912_1_0_2;
		#end
	end;




	scores := join(with_rs_batchin, easi.key_easi_census, 
					keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
					doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

	return scores;
	
	/* NO INDICES TO BE USED FOR THIS MODEL -- https://bugzilla.seisint.com/show_bug.cgi?id=48249#c0 */
	// indices := RecoverScore_Collection_Indices( clam, recoverscore_batchin );

	// layout_recoverscore doIndices( layout_recoverscore le, indices ri ) := TRANSFORM
		// SELF.address_index          := ri.address_index;
		// SELF.telephone_index        := ri.telephone_index;
		// SELF.contactability_score   := ri.contactability_score;
		// SELF.asset_index            := ri.asset_index;
		// SELF.lifecycle_stress_index := ri.lifecycle_stress_index;
		// SELF.liquidity_score        := ri.liquidity_score;
		// self := le;
	// END;

	// withIndices := join( scores, indices, left.seq=right.seq, doIndices(left,right));    
	// RETURN withIndices;

END;

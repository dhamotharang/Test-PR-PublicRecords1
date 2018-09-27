import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVG812_0_0(dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	
	Layout_ModelOut doModel( clam le ) := TRANSFORM
		truedid                         :=  le.truedid;
		out_addr_status                 :=  le.address_validation.error_codes;
		in_dob                          :=  le.shell_input.dob;
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_hphonetypeflag               :=  le.iid.hphonetypeflag;
		rc_hphonevalflag                :=  le.iid.hphonevalflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_hriskaddrflag                :=  (INTEGER)le.iid.hriskaddrflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_ssnhighissue                 :=  le.iid.soclhighissue;
		rc_addrvalflag                  :=  le.iid.addrvalflag;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		rc_sources                      :=  le.iid.sources;
		rc_addrcount                    :=  le.iid.addrcount;
		rc_ssncount                     :=  le.iid.socscount;
		rc_numelever                    :=  le.iid.numelever;
		rc_addrcommflag                 :=  le.iid.addrcommflag;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_hrisksicphone                :=  le.iid.hrisksicphone;
		rc_disthphoneaddr               :=  le.iid.disthphoneaddr;
		combo_fnamescore                :=  le.iid.combo_firstscore;
		combo_hphonescore               :=  le.iid.combo_hphonescore;
		combo_dobscore                  :=  le.iid.combo_dobscore;
		combo_hphonecount               :=  le.iid.combo_hphonecount;
		combo_dobcount                  :=  le.iid.combo_dobcount;
		EQ_count                        :=  le.source_verification.eq_count;
		PR_count                        :=  le.source_verification.pr_count;
		adl_V_last_seen                 :=  le.source_verification.adl_V_last_seen;
		adl_W_last_seen                 :=  le.source_verification.adl_W_last_seen;
		addrpop                         :=  le.input_validation.Address;
		ssnlength                       :=  le.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.input_validation.dateofbirth;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		adl_score                       :=  le.name_verification.adl_score;
		age                             :=  le.Name_Verification.age;
		add1_address_score              :=  le.address_verification.input_address_information.address_score;
		add1_isbestmatch                :=  le.address_verification.input_address_information.isbestmatch;
		Add1_lres                       :=  le.lres;
		add1_avm_land_use               :=  le.AVM.Input_Address_Information.avm_land_use_code;
		add1_avm_assessed_value_year    :=  le.AVM.Input_Address_Information.avm_assessed_value_year;
		add1_avm_automated_valuation    :=  le.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_med_fips               :=  le.AVM.Input_Address_Information.avm_median_fips_level;
		add1_avm_med_geo11              :=  le.AVM.Input_Address_Information.avm_median_geo11_level;
		add1_avm_med_geo12              :=  le.AVM.Input_Address_Information.avm_median_geo12_level;
		add1_source_count               :=  le.address_verification.input_address_information.source_count;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		property_owned_total            :=  le.address_verification.owned.property_total;
		property_owned_purchase_count   :=  le.address_verification.owned.property_owned_purchase_count;
		property_owned_assessed_count   :=  le.address_verification.owned.property_owned_assessed_count;
		property_sold_total             :=  le.address_verification.sold.property_total;
		dist_a1toa2                     :=  le.address_verification.distance_in_2_h1;
		dist_a1toa3                     :=  le.address_verification.distance_in_2_h2;
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add2_pop                        :=  le.addrPop2;
		Add3_lres                       :=  le.lres3;
		add3_naprop                     :=  le.address_verification.address_history_2.naprop;
		add3_pop                        :=  le.addrPop3;
		addrs_10yr                      :=  le.other_address_info.addrs_last_10years;
		recent_disconnects              :=  le.phone_verification.recent_disconnects;
		header_last_seen                :=  le.ssn_verification.header_last_seen;
		ssns_per_adl                    :=  le.velocity_counters.ssns_per_adl;
		addrs_per_adl                   :=  le.velocity_counters.addrs_per_adl;
		adlperssn_count                 :=  le.SSN_Verification.adlPerSSN_count;
		adls_per_addr                   :=  le.velocity_counters.adls_per_addr;
		ssns_per_adl_c6                 :=  le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                :=  le.velocity_counters.addrs_per_adl_created_6months;
		ssns_per_addr_c6                :=  le.velocity_counters.ssns_per_addr_created_6months;
		adls_per_phone_c6               :=  le.velocity_counters.adls_per_phone_created_6months;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		criminal_last_date              :=  le.bjl.last_criminal_date;
		felony_count                    :=  le.bjl.felony_count;
		prof_license_flag               :=  (INTEGER)le.professional_license.professional_license_flag;
		addr_stability                  :=  le.mobility_indicator;
		archive_date                    :=  if(999999=le.historydate, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);
		
		
		rc_lnamessnmatch2               :=  le.iid.lastssnmatch2;



		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		sysyear := ((STRING)archive_date)[1..4];

		usps_deliverable :=  if(rc_addrvalflag = 'V', 1, 0);

		hr_address :=  if(rc_hriskaddrflag = 4, 1, 0);

		phone_zip_mismatch :=  if(rc_phonezipflag = '1', 1, 0);

		distance := rc_disthphoneaddr;

		disconnected :=  if(rc_hriskphoneflag = '5', 1, 0);
		hr_phone :=  if(rc_hriskphoneflag = '6', 1, 0);

		phn_corrections :=  if(rc_hrisksicphone = '2225', 1, 0);

		deceased :=  if(rc_decsflag, 1, 0);

		ssnhighissue_yr :=  map(
			trim(rc_ssnhighissue) = '' => -9999,
			(real)rc_ssnhighissue = 0  => -9999,
			(real)(trim(rc_ssnhighissue)[1..4])
		);

		dob_yr :=  map(
			trim(in_dob) = '' => -9999,
			(real)in_dob = 0  => -9999,
			(real)((string)trim(in_dob))[1..4]);

		dob_mismatch :=  map(
			(ssnhighissue_yr = -9999) or (dob_yr = -9999) => 0,
			(dob_yr > ssnhighissue_yr) and dobpop = 1     => (dob_yr - ssnhighissue_yr),
			0
		);

		cell_mobile_pager :=  if(rc_hriskphoneflag in ['1', '2', '3'], 1, 0);

		pnotpot :=  if(trim(rc_hphonetypeflag) in ['0', 'Z'], 0, 1);

		busphone_flag :=  if(rc_hphonevalflag = '1', 1, 0);
		hr_phone_flag :=  if(rc_hphonevalflag = '3', 1, 0);
		non_land_phone_flag :=  if(rc_hphonevalflag = '4', 1, 0);

		addinval :=  if(rc_addrvalflag = 'N', 1, 0);
		aptflag :=  if(rc_dwelltype = 'A', 1, 0);

		hirisk_commercial_flag :=  if(rc_addrcommflag in ['1', '2'], 1, 0);

		source_DA_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'DA,') > 0);
		source_DS_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'DS,') > 0);
		source_EQ_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'EQ,') > 0);
		source_FF_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'FF,') > 0);
		source_FR_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'FR,') > 0);
		source_L2_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'L2,') > 0);
		source_LI_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'LI,') > 0);
		source_P_tot  := (contains_i(StringLib.StringToUpperCase(rc_sources), 'P ,') > 0);
		source_PL_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'PL,') > 0);
		source_V_tot  := (contains_i(StringLib.StringToUpperCase(rc_sources), 'V ,') > 0);
		source_VO_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'VO,') > 0);
		source_W_tot  := (contains_i(StringLib.StringToUpperCase(rc_sources), 'W ,') > 0);
		source_WP_tot := (contains_i(StringLib.StringToUpperCase(rc_sources), 'WP,') > 0);
		
		prof_license_flag2 := if((prof_license_flag > 0) or source_pl_tot, 1, 0);
		property_sourced   := if(source_p_tot or (add1_naprop >= 3), 1, 0);
		deceased2          := if(source_ds_tot or (deceased > 0), 1, 0);

		source_v_flag := max(source_v_tot, source_vo_tot);


		// verfst_p := (nap_summary in [2,3,4,8,9,10,12]);
		verlst_p := (nap_summary in [2,5,7,8,9,11,12]);
		veradd_p := (nap_summary in [3,5,6,8,10,11,12]);
		verphn_p := (nap_summary in [4,6,7,9,10,11,12]);
		contrary_phone := (nap_summary=1);


		nap_tree := if( add1_isbestmatch,
			map(
				contrary_phone => 1,
				hphnpop = 1 and ~verphn_p and ~verlst_p => 3,
				hphnpop = 1 and ~verphn_p and  verlst_p => 4,
				hphnpop = 1 and  verphn_p and ~verlst_p => 1,
				hphnpop = 1 and  verphn_p and  verlst_p => 5,
				hphnpop = 0 and                verlst_p and veradd_p => 2,
				0
			),
			map(
				contrary_phone => 11,
				hphnpop = 1 and ~verphn_p and ~verlst_p => 13,
				hphnpop = 1 and ~verphn_p and  verlst_p => 14,
				hphnpop = 1 and  verphn_p and ~verlst_p => 12,
				hphnpop = 1 and  verphn_p and  verlst_p => 15,
				10
			)
		  );
   

		rc_addrcount_c1 := min(rc_addrcount, 6);
		rc_ssncount_c1 := min(rc_ssncount, 6);
		rc_numelever_c :=  map(rc_numelever <= 2 => 0,
							   rc_numelever <= 3 => 1,
							   rc_numelever <= 4 => 2,
							   rc_numelever <= 5 => 3,
													4);

		combo_hphonecount_c1 := combo_hphonecount;
		combo_dobcount_c1 := min(combo_dobcount, 4);
		eq_count_c :=  map(eq_count <= 0  => 0,
						   eq_count <= 1  => 1,
						   eq_count <= 2  => 2,
						   eq_count <= 3  => 3,
						   eq_count <= 5  => 4,
						   eq_count <= 6  => 5,
						   eq_count <= 9  => 6,
						   eq_count <= 17 => 7,
											 8);

		pr_count_c :=  map(pr_count <= 0 => 0,
						   pr_count <= 2 => 1,
						   pr_count <= 4 => 2,
											3);

		rc_lnamessnmatch2_c := (real)rc_lnamessnmatch2;

		combo_fnamescore_100 :=  map(combo_fnamescore = 100 => 1,
									 combo_fnamescore = 255 => -1,
															   0);

		combo_hphonescore_90 :=  map(
			combo_hphonescore between 90 and 100 => 1,
			combo_hphonescore = 255             => -1,
			0);

		combo_dobscore_100 :=  map(combo_dobscore = 100 => 1,
								   combo_dobscore = 255 => -1,
														   0);

		adl_score_100 :=  if(adl_score = 100, 1, 0);

		add1_address_score_100 :=  map(add1_address_score = 100 => 1,
									   add1_address_score = 255 => -1,
																   0);

		add1_source_count_c :=  map(add1_source_count <= 2 => 0,
									add1_source_count <= 3 => 1,
									add1_source_count <= 6 => 2,
															  3);


		rc_addrcount_c      := if( ~add1_isbestmatch, 10 + rc_addrcount_c1, rc_addrcount_c1); 
		rc_ssncount_c       := if( ~add1_isbestmatch, 10 + rc_ssncount_c1, rc_ssncount_c1); 
		combo_hphonecount_c := if( ~add1_isbestmatch, 10 + combo_hphonecount_c1, combo_hphonecount_c1); 
		combo_dobcount_c    := if( ~add1_isbestmatch, 10 + combo_dobcount_c1, combo_dobcount_c1);

		eq_count_c_m :=  case(eq_count_c,
			0  => 0.2903225806,
			1  => 0.2785388128,
			2  => 0.2654545455,
			3  => 0.2545454545,
			4  => 0.2218309859,
			5  => 0.2262382865,
			6  => 0.2023084995,
			7  => 0.1845905048,
			8  => 0.1790331647,
			10 => 0.4612612613,
			11 => 0.3910034602,
			12 => 0.3834422658,
			13 => 0.3610315186,
			14 => 0.3662349263,
			15 => 0.3414096916,
			16 => 0.3209513629,
			17 => 0.2925743361,
			0.2816843827
		);

		pr_count_c_m :=  map(pr_count_c = 0  => 0.2257924916,
							 pr_count_c = 1  => 0.1381567614,
							 pr_count_c = 2  => 0.123252859,
							 pr_count_c = 3  => 0.0979166667,
							 pr_count_c = 10 => 0.3399031812,
							 pr_count_c = 11 => 0.2234805587,
							 pr_count_c = 12 => 0.1958333333,
												0.174904943);

		nap_tree_m :=  map(nap_tree = 0  => 0.2627395979,
						   nap_tree = 1  => 0.2342778162,
						   nap_tree = 2  => 0.2200956938,
						   nap_tree = 3  => 0.2010056901,
						   nap_tree = 4  => 0.1931718062,
						   nap_tree = 5  => 0.1639241301,
						   nap_tree = 10 => 0.3665234002,
						   nap_tree = 11 => 0.3486547085,
						   nap_tree = 12 => 0.3217784476,
						   nap_tree = 13 => 0.3087184374,
						   nap_tree = 14 => 0.2962522308,
											0.2779933481);

		add1_source_count_c_m :=  map(add1_source_count_c = 0  => 0.2354743407,
									  add1_source_count_c = 1  => 0.1965294592,
									  add1_source_count_c = 2  => 0.1676619201,
									  add1_source_count_c = 3  => 0.1353383459,
									  add1_source_count_c = 10 => 0.331738437,
									  add1_source_count_c = 11 => 0.2653301887,
									  add1_source_count_c = 12 => 0.2313895782,
																  0.25);

		rc_addrcount_c_m :=  case(rc_addrcount_c,
			0  => 0.2217898833,
			1  => 0.2213162982,
			2  => 0.1870007262,
			3  => 0.1659011078,
			4  => 0.1557911909,
			5  => 0.1405835544,
			6  => 0.0900900901,
			10 => 0.3490292976,
			11 => 0.2678903346,
			12 => 0.2415599534,
			13 => 0.2291666667,
			14 => 0.1257861635,
			15 => 0.2045454545,
			0.2222222222);

		rc_ssncount_c_m :=  case(rc_ssncount_c,
			0  => 0.2657342657,
			1  => 0.2111868609,
			2  => 0.1851951548,
			3  => 0.1873189572,
			4  => 0.1795221843,
			5  => 0.1684210526,
			6  => 0.1694214876,
			10 => 0.4775280899,
			11 => 0.3400017026,
			12 => 0.2762675921,
			13 => 0.2631851086,
			14 => 0.2533692722,
			15 => 0.2753164557,
			0.244047619);

		rc_numelever_c_m :=  case(rc_numelever_c,
			0  => 0.380952381,
			1  => 0.2862453532,
			2  => 0.2316046701,
			3  => 0.2010403487,
			4  => 0.1741959244,
			10 => 0.4693877551,
			11 => 0.3993850359,
			12 => 0.3226666667,
			13 => 0.2835674616,
			0.2692928641);

		combo_hphonecount_c_m :=  case(combo_hphonecount_c,
			0  => 0.2104088771,
			1  => 0.1769947762,
			10 => 0.3269362577,
			0.2897669706);

		combo_dobcount_c_m :=  case(combo_dobcount_c,
			0  => 0.227072487,
			1  => 0.2090986154,
			2  => 0.1987019471,
			3  => 0.1842046719,
			4  => 0.1846203415,
			10 => 0.3762612365,
			11 => 0.3484384568,
			12 => 0.3142281106,
			13 => 0.2847200253,
			0.2657082002);

		ver_source_mod_best_b1 := -1.172313736 +
			(property_sourced * -0.481434847) +
			(prof_license_flag2 * -0.271081036) +
			((real)source_w_tot * -0.488581797) +
			((real)source_wp_tot * -0.098215222);

		ver_source_mod_b1 := (100 * (exp(ver_source_mod_best_b1) / (1 + exp(ver_source_mod_best_b1))));

		ver_score_mod_best_b1 := -0.731193632 +
			(combo_hphonescore_90 * -0.064981863) +
			(combo_dobscore_100 * -0.11636904) +
			(add1_address_score_100 * -0.207731917) +
			(combo_fnamescore_100 * -0.431296268);

		ver_score_mod_b1 := (100 * (exp(ver_score_mod_best_b1) / (1 + exp(ver_score_mod_best_b1))));

		ver_counter_mod_best_b1 := -3.916322374 +
			(add1_source_count_c_m * 5.3850179442) +
			(rc_ssncount_c_m * 2.2527772603) +
			(rc_numelever_c_m * 2.2958551296) +
			(combo_hphonecount_c_m * 2.7092828253);

		ver_counter_mod_b1 := (100 * (exp(ver_counter_mod_best_b1) / (1 + exp(ver_counter_mod_best_b1))));

		ver_source_mod_notbest_b2 := -0.064013619 +
			((real)source_eq_tot * -0.507896184) +
			(property_sourced * -0.473715919) +
			(prof_license_flag2 * -0.303507086) +
			((real)source_v_flag * -0.164515257) +
			((real)source_wp_tot * -0.125766278);

		ver_source_mod_b2 := (100 * (exp(ver_source_mod_notbest_b2) / (1 + exp(ver_source_mod_notbest_b2))));

		ver_score_mod_notbest_b2 := -0.274495765 +
			(combo_hphonescore_90 * -0.033496988) +
			(combo_dobscore_100 * -0.150781265) +
			(adl_score_100 * -0.3803891) +
			(add1_address_score_100 * -0.364196421);

		ver_score_mod_b2 := (100 * (exp(ver_score_mod_notbest_b2) / (1 + exp(ver_score_mod_notbest_b2))));

		ver_counter_mod_notbest_b2 := -4.494979525 +
			(rc_addrcount_c_m * 3.7750057376) +
			(rc_ssncount_c_m * 2.8859937287) +
			(combo_hphonecount_c_m * 2.5370241446) +
			(combo_dobcount_c_m * 2.4787135883);

		ver_counter_mod_b2      := (100 * (exp(ver_counter_mod_notbest_b2) / (1 + exp(ver_counter_mod_notbest_b2))));
		ver_score_mod_best      := if(add1_isbestmatch, ver_score_mod_best_b1, -9999);
		ver_source_mod_notbest  := if(add1_isbestmatch, -9999, ver_source_mod_notbest_b2);
		ver_counter_mod         := if(add1_isbestmatch, ver_counter_mod_b1, ver_counter_mod_b2);
		ver_score_mod_notbest   := if(add1_isbestmatch, -9999, ver_score_mod_notbest_b2);
		ver_source_mod          := if(add1_isbestmatch, ver_source_mod_b1, ver_source_mod_b2);
		ver_score_mod           := if(add1_isbestmatch, ver_score_mod_b1, ver_score_mod_b2);
		ver_counter_mod_best    := if(add1_isbestmatch, ver_counter_mod_best_b1, -9999);
		ver_counter_mod_notbest := if(add1_isbestmatch, -9999, ver_counter_mod_notbest_b2);
		ver_source_mod_best     := if(add1_isbestmatch, ver_source_mod_best_b1, -9999);

		ver_mod_best_b_b1 := -4.557555927 +
			(ver_source_mod * 0.0157829449) +
			(ver_counter_mod * 0.0189642768) +
			(eq_count_c_m * 3.3288015371) +
			(pr_count_c_m * 4.610730102) +
			(nap_tree_m * 4.3473102597);

		ver_mod_b_b1 := (100 * (exp(ver_mod_best_b_b1) / (1 + exp(ver_mod_best_b_b1))));

		ver_mod_notbest_b_b2 := -3.99087993 +
			(ver_score_mod * 0.0156836696) +
			(ver_counter_mod * 0.026335566) +
			(pr_count_c_m * 4.7914461296) +
			(nap_tree_m * 2.7126594638);

		ver_mod_b_b2 := (100 * (exp(ver_mod_notbest_b_b2) / (1 + exp(ver_mod_notbest_b_b2))));

		ver_mod_b := if(add1_isbestmatch, ver_mod_b_b1, ver_mod_b_b2);

		ver_mod_notbest_b := if(add1_isbestmatch, -9999, ver_mod_notbest_b_b2);

		ver_mod_best_b := if(add1_isbestmatch, ver_mod_best_b_b1, -9999);

		liens_hist_unrel_c :=  map(liens_historical_unreleased_ct <= 0 => 0,
								   liens_historical_unreleased_ct <= 1 => 1,
								   liens_historical_unreleased_ct <= 3 => 2,
																		  3);

		liens_rec_unrel_c :=  map(liens_recent_unreleased_count <= 0 => 0,
								  liens_recent_unreleased_count <= 1 => 1,
								  liens_recent_unreleased_count <= 2 => 2,
								  liens_recent_unreleased_count <= 4 => 3,
																		4);

		source_lien_flag := max(source_l2_tot, source_li_tot);

		lien_unrel_flag :=  map((liens_rec_unrel_c <= 0) and (liens_hist_unrel_c <= 1) => 0,
								(liens_rec_unrel_c <= 0) and (liens_hist_unrel_c <= 2) => 2,
								liens_rec_unrel_c <= 0                                 => 3,
								(liens_rec_unrel_c <= 1) and (liens_hist_unrel_c <= 1) => 1,
								liens_rec_unrel_c <= 2                                 => 4,
								(liens_rec_unrel_c <= 3) and (liens_hist_unrel_c <= 2) => 4,
																						  5);

		neg_sources_minor := max(source_da_tot, deceased2, source_ff_tot, source_fr_tot, source_lien_flag);

		felony_flag :=  if(felony_count > 0, 1, 0);

		mth_since_crim := ut.DaysApart( (string8)criminal_last_date, ((STRING8)archive_date)[1..6]+'01' ) * (12 / 365.25);

		yr_since_crim :=  if(criminal_last_date = 0, -9, truncate((mth_since_crim / 12)));

		yr_since_crim_2 :=  if(yr_since_crim = 0, 1, yr_since_crim);

		lien_unrel_flag_m :=  case(lien_unrel_flag,
			0 => 0.2410180823,
			1 => 0.2580521472,
			2 => 0.2745180218,
			3 => 0.2920747996,
			4 => 0.3206659428,
				 0.4276315789);

		yr_since_crim_m :=  case(yr_since_crim_2,
			-9 => 0.2438601175,
			1  => 0.4278481013,
			2  => 0.426183844,
			3  => 0.4109195402,
			4  => 0.3766233766,
			5  => 0.3344370861,
			0.3);

		property_owned_total_x := if(property_owned_total > 0, 1, 0);
		property_sold_total_x  := if(property_sold_total > 0, 1, 0);

		property_total_x :=  map(property_owned_total_x=1 and property_sold_total_x=1 => 3,
								 property_owned_total_x=1                           => 2,
								 property_sold_total_x=1                            => 1,
																					 0);

		property_owned_purchase_count_x :=  if(property_owned_purchase_count > 0, 1, 0);
		property_owned_assessed_count_x :=  if(property_owned_assessed_count > 0, 1, 0);

		property_owned_flag :=  map(property_owned_purchase_count_x=1 and property_owned_assessed_count_x=1 => 3,
									property_owned_purchase_count_x=1                                       => 2,
									property_owned_assessed_count_x=1                                       => 1,
									0);

		property_ownership_level :=  map((property_total_x <= 0) and (property_owned_flag <= 0) => 0,
										 property_owned_flag <= 0                               => 1,
										 property_owned_flag <= 1                               => 2,
										 (property_total_x <= 2) and (property_owned_flag <= 2) => 3,
										 property_owned_flag <= 2                               => 5,
										 (property_total_x <= 2) and (property_owned_flag <= 3) => 4,
																								   5);

		add1_naprop_level :=  map(add1_naprop in [4]    => 2,
								  add1_naprop in [3]    => 1,
								  add1_naprop in [1, 2] => -1,
														   0);

		naprop_level :=  map((add1_naprop = 4) and (add2_naprop = 4) => 4,
							 add1_naprop = 4                         => 3,
							 (add2_naprop = 4) or (add3_naprop = 4)  => 2,
							 add1_naprop = 3                         => 1,
							 add1_naprop in [1, 2]                   => -1,
																		0);

		property_ownership_level_m :=  case(property_ownership_level,
			0 => 0.2762810776,
			1 => 0.1888745149,
			2 => 0.1702877275,
			3 => 0.1429906542,
			4 => 0.1313195548,
			0.1085858586);

		add1_naprop_level_m :=  map(add1_naprop_level = -1 => 0.2873333809,
									add1_naprop_level = 0  => 0.2629651211,
									add1_naprop_level = 1  => 0.2449541284,
															  0.1239173884);

		naprop_level_m :=  case(naprop_level,
			-1 => 0.2961642099,
			0  => 0.2674460271,
			1  => 0.249835418,
			2  => 0.2043075082,
			3  => 0.1282485876,
			0.090778098);

		dist_a1toa2_code :=  map(dist_a1toa2 = 9999 => 9,
								 dist_a1toa2 = 0    => 0,
								 dist_a1toa2 <= 100 => 1,
													   2);

		dist_a1toa3_code :=  map(dist_a1toa3 = 9999 => 9,
								 dist_a1toa3 = 0    => 0,
								 dist_a1toa3 <= 100 => 1,
													   2);

		dist_code :=  map((dist_a1toa2_code <= 0) and (dist_a1toa3_code <= 0) => 0,
						  (dist_a1toa2_code <= 0) and (dist_a1toa3_code <= 2) => 1,
						  dist_a1toa2_code <= 0                               => 2,
						  (dist_a1toa2_code <= 1) and (dist_a1toa3_code <= 0) => 1,
						  (dist_a1toa2_code <= 1) and (dist_a1toa3_code <= 2) => 2,
						  dist_a1toa2_code <= 1                               => 3,
						  dist_a1toa3_code <= 0                               => 1,
						  dist_a1toa3_code <= 1                               => 2,
						  dist_a1toa3_code <= 2                               => 3,
																				 4);

		dist_code_m :=  case(dist_code,
			0 => 0.2070053121,
			1 => 0.2262985834,
			2 => 0.2579870729,
			3 => 0.2835345406,
				 0.3282128138);

		add1_lres_level :=  map(add1_lres <= 0  => 0,
								add1_lres <= 11 => 1,
								add1_lres <= 22 => 2,
								add1_lres <= 43 => 3,
												   4);

		add3_lres_level :=  map(~add3_pop       => -1,
								add3_lres <= 70 => 0,
												   1);

		add1_lres_level_m :=  case(add1_lres_level,
			0 => 0.3117092248,
			1 => 0.2469659595,
			2 => 0.2210545066,
			3 => 0.1966066119,
				 0.1894985251);

		add3_lres_level_m :=  map(add3_lres_level = -1 => 0.2926331416,
								  add3_lres_level = 0  => 0.2536016331,
														  0.2118954248);

		addrs_10yr_code :=  map(~add2_pop and ~add3_pop => -2,
								~add3_pop               => -1,
								addrs_10yr <= 0         => 0,
								addrs_10yr <= 1         => 1,
								addrs_10yr <= 4         => 2,
								addrs_10yr <= 8         => 3,
								4);

		addrs_10yr_code_m :=  case(addrs_10yr_code,
			-2 => 0.3081002893,
			-1 => 0.2829562594,
			0  => 0.1219330855,
			1  => 0.1924019608,
			2  => 0.2438051553,
			3  => 0.2606834558,
				  0.3011974209);

		addr_stability_code :=  map((integer)addr_stability <= 1 => 0,
									(integer)addr_stability <= 2 => 1,
									(integer)addr_stability <= 3 => 2,
									(integer)addr_stability <= 4 => 3,
									(integer)addr_stability <= 5 => 4,
														   5);

		addr_stability_code_m :=  case(addr_stability_code,
			0 => 0.3042278726,
			1 => 0.2638901118,
			2 => 0.2461767205,
			3 => 0.2224215247,
			4 => 0.210792048,
				 0.1579514825);

		prop_mod2 := -6.418325989 +
			(property_ownership_level_m * 3.0281088673) +
			(naprop_level_m * 2.8333891527) +
			(dist_code_m * 3.7857538573) +
			(add1_lres_level_m * 4.3554180618) +
			(add3_lres_level_m * 2.2309158723) +
			(addrs_10yr_code_m * 2.0301498007) +
			(addr_stability_code_m * 2.7051418361);

		prop_mod2_2 := (100 * (exp(prop_mod2) / (1 + exp(prop_mod2))));

		ssn_age := ((integer)sysyear - ssnhighissue_yr);

		age2 := age;

		age2_2 :=  if(age2 = 0, ssn_age, age2);

		age2_code :=  map(
						age2 = 0 and ssnhighissue_yr = -9999 => 0,
						age2_2 <= 25 => 0,
						age2_2 <= 32 => 1,
						age2_2 <= 34 => 2,
						age2_2 <= 37 => 3,
						age2_2 <= 40 => 4,
						age2_2 <= 43 => 5,
						age2_2 <= 52 => 6,
						age2_2 <= 56 => 7,
										8);

		age2_code_m :=  case(age2_code,
			0 => 0.3255733148,
			1 => 0.3052283985,
			2 => 0.2918752407,
			3 => 0.2680861981,
			4 => 0.240564757,
			5 => 0.233241506,
			6 => 0.1998832458,
			7 => 0.1772339637,
				 0.1364470732);

		ssns_per_adl_c :=  map(~truedid          => -1,
							   ssns_per_adl <= 2 => 0,
							   ssns_per_adl <= 3 => 1,
													2);

		addrs_per_adl_c :=  map(~truedid           => -1,
								addrs_per_adl <= 2 => 3,
								addrs_per_adl <= 3 => 2,
								addrs_per_adl <= 5 => 1,
													  0);

		adls_per_addr_c :=  map(~addrpop                       => -2,
								aptflag = 1                    => -1,
								adls_per_addr = 0              => 6,
								adls_per_addr = 1              => 4,
								adls_per_addr = 2              => 0,
								adls_per_addr in [3, 4]        => 1,
								adls_per_addr in [5, 6]        => 2,
								adls_per_addr in [7, 8, 9, 10] => 3,
								adls_per_addr <= 16            => 4,
								adls_per_addr <= 21            => 5,
																  6);

		adlperssn_count_c :=  if(adlperssn_count = 1, 0, 1);

		ssns_per_adl_c_m :=  case(ssns_per_adl_c,
			-1 => 0.468401487,
			0  => 0.243596433,
			1  => 0.2715664902,
					0.3524011299);

		addrs_per_adl_c_m :=  case(addrs_per_adl_c,
			-1 => 0.468401487,
			0  => 0.2326190388,
			1  => 0.2457534843,
			2  => 0.2782549729,
				  0.3042833608);

		adls_per_addr_c_m :=  case(adls_per_addr_c,
			-2 => 0.4676056338,
			-1 => 0.2830533843,
			0  => 0.1741988496,
			1  => 0.1860946746,
			2  => 0.2024420024,
			3  => 0.2207461084,
			4  => 0.2371109806,
			5  => 0.2763192787,
				  0.2988646824);

		ssns_per_adl_c6_c :=  map(~truedid             => -1,
								  ssns_per_adl_c6 <= 0 => 0,
								  ssns_per_adl_c6 <= 1 => 1,
														  2);

		addrs_per_adl_c6_c :=  map(~truedid              => -1,
								   addrs_per_adl_c6 <= 0 => 0,
								   addrs_per_adl_c6 <= 1 => 1,
								   addrs_per_adl_c6 <= 2 => 2,
															3);

		ssns_per_addr_c6_c :=  map(~addrpop              => -2,
								   aptflag = 1           => -1,
								   ssns_per_addr_c6 <= 0 => 0,
								   ssns_per_addr_c6 <= 1 => 1,
								   ssns_per_addr_c6 <= 2 => 2,
								   ssns_per_addr_c6 <= 3 => 3,
								   ssns_per_addr_c6 <= 4 => 4,
															5);

		adls_per_phone_c6_c :=  map(hphnpop = 0            => -1,
									adls_per_phone_c6 >= 1 => 1,
															  0);

		per_adl_c6_c :=  map(ssns_per_adl_c6_c = -1                                => -1,
							 ssns_per_adl_c6_c = 0                                 => 0,
							 (ssns_per_adl_c6_c = 1) and (addrs_per_adl_c6_c <= 0) => 0,
							 (ssns_per_adl_c6_c = 1) and (addrs_per_adl_c6_c <= 1) => 1,
							 ssns_per_adl_c6_c = 1                                 => 2,
							 (ssns_per_adl_c6_c = 2) and (addrs_per_adl_c6_c <= 0) => 2,
																					  3);

		ssns_per_addr_c6_c_m :=  case(ssns_per_addr_c6_c,
			-2 => 0.4676056338,
			-1 => 0.2830533843,
			0  => 0.2127088608,
			1  => 0.2534183082,
			2  => 0.2760467381,
			3  => 0.2997382199,
			4  => 0.3417721519,
			0.4089709763);

		adls_per_phone_c6_c_m :=  map(adls_per_phone_c6_c = -1 => 0.3130193906,
									  adls_per_phone_c6_c = 0  => 0.2353928711,
																  0.2611484901);

		per_adl_c6_c_m :=  case(per_adl_c6_c,
			-1 => 0.468401487,
			0  => 0.237250492,
			1  => 0.2757541899,
			2  => 0.2998805257,
			0.3902847571);

		velo_mod3 := -5.302246522 +
			(ssns_per_adl_c_m * 1.3049711309) +
			(addrs_per_adl_c_m * 3.1224442697) +
			(adls_per_addr_c_m * 3.4830049916) +
			(adlperssn_count_c * 0.1259278414) +
			(ssns_per_addr_c6_c_m * 2.6936929055) +
			(adls_per_phone_c6_c_m * 4.3789256812) +
			(per_adl_c6_c_m * 1.4627883689);

		velo_mod3_2 := (100 * (exp(velo_mod3) / (1 + exp(velo_mod3))));

		cellphone :=  if(cell_mobile_pager=1 or non_land_phone_flag=1, 1, 0);

		pnotpot2 :=  map((pnotpot = 1) and (cellphone = 0) => 2,
						 (pnotpot = 1) or (cellphone = 1)  => 1,
															  0);

		recent_disconnect_flag :=  if(recent_disconnects > 0, 1, 0);

		risky_phone :=  if(hr_phone_flag=1 or hr_phone=1 or phn_corrections=1, 1, 0);

		not_connected_level :=  map((hphnpop = 0) and (trim(nap_status) = 'C')      => -1,
									hphnpop = 0                                                              => -2,
									(trim(nap_status) = 'C') and (disconnected = 0) => 0,
																												1);

		phnprob :=  map((not_connected_level = 1) and (pnotpot2 = 2)      => 3,
						(not_connected_level = 1) and (pnotpot2 = 1)      => 2,
						busphone_flag = 1                                 => 2,
						(risky_phone = 1) or (recent_disconnect_flag = 1) => 1,
																			 not_connected_level);

		error_codes := out_addr_status;
		ec1 := trim(error_codes)[1];
		ec3 := trim(error_codes)[3];
		ec4 := trim(error_codes)[4];
		

		addr_changed :=  if((ec1 = 'S') and (ec3 != '0'), 1, 0);
		unit_changed :=  if((ec1 = 'S') and (ec4 != '0'), 1, 0);

		e412 :=  if(trim(error_codes) = 'E412', 1, 0);

		address_standardization_level :=  map(~addrpop                                                    => -1,
											  (ec1 = 'S') and ((addr_changed = 1) and (unit_changed = 1)) => 3,
											  (ec1 = 'S') and (unit_changed = 1)                          => 2,
											  (ec1 = 'S') and (addr_changed = 1)                          => 1,
											  ec1 = 'S'                                                   => 0,
											  e412 = 1                                                    => 1,
																											 4);

		usps_not_deliverable := 1-usps_deliverable;

		addprob :=  map(~addrpop                                               => -1,
						(address_standardization_level = 4) and (addinval = 1) => 4,
						hr_address = 1                                         => 4,
						hirisk_commercial_flag = 1                             => 4,
						aptflag = 1                                            => 3,
						address_standardization_level = 4                      => 2,
						(usps_not_deliverable = 1) or (addinval = 1)           => 2,
						address_standardization_level > 0                      => 1,
																				  0);

		distflag :=  map(~addrpop        => -2,
						 hphnpop = 0     => -1,
						 distance = 9999 => 2,
						 distance <= 0   => 0,
						 distance <= 1   => 1,
						 distance <= 2   => 2,
						 distance <= 3   => 3,
											4);

		dob_mismatch_flag :=  if(dob_mismatch > 0, 1, 0);

		addprob_m :=  map(addprob = -1 => 0.4676056338,
						  addprob = 0  => 0.2304013664,
						  addprob = 1  => 0.2462289745,
						  addprob = 2  => 0.2528641571,
						  addprob = 3  => 0.2827159461,
										  0.3221070812);

		phnprob_m :=  map(phnprob = -2 => 0.3259777539,
						  phnprob = -1 => 0.2770303936,
						  phnprob = 0  => 0.2212195371,
						  phnprob = 1  => 0.2440607397,
						  phnprob = 2  => 0.2646883261,
										  0.3526970954);

		distflag_m :=  map(distflag = -2 => 0.4676056338,
						   distflag = -1 => 0.3084677419,
						   distflag = 0  => 0.218032112,
						   distflag = 1  => 0.2355512385,
						   distflag = 2  => 0.2446979148,
						   distflag = 3  => 0.2533136966,
											0.2881739918);

		fp_mod := -3.322149662 +
			(phnprob_m * 4.0246019692) +
			(addprob_m * 3.7200432518) +
			(distflag_m * 1.0221095944) +
			(dob_mismatch_flag * 0.6351084012) +
			(phone_zip_mismatch * 0.3319704455);

		fp_mod_2 := (100 * (exp(fp_mod) / (1 + exp(fp_mod))));

		derog_mod2 := -4.38064999 +
			(lien_unrel_flag_m * 4.7393818895) +
			(yr_since_crim_m * 3.3918106056) +
			(felony_flag * 0.4658609878) +
			(fp_mod_2 * 0.0484211081);

		derog_mod2_2 := (100 * (exp(derog_mod2) / (1 + exp(derog_mod2))));

		avm_hit :=  if((integer)add1_avm_land_use > 0, 1, 0);

		since_add1_avm_assessed_value := ((integer)sysyear - (integer)add1_avm_assessed_value_year);

		since_add1_avm_assessed_val_code :=  map(avm_hit = 0                        => -1,
												 // since_add1_avm_assessed_value = .  => 0,
												 trim(sysyear)='' or trim(add1_avm_assessed_value_year)='' => 0,
												 since_add1_avm_assessed_value <= 0 => 0,
												 since_add1_avm_assessed_value <= 1 => 1,
												 since_add1_avm_assessed_value <= 2 => 2,
																					   3);

		add1_avm_automated_valuation_c := (20000 * if ((add1_avm_automated_valuation / 20000) >= 0,
				roundup((add1_avm_automated_valuation / 20000)),
				truncate((add1_avm_automated_valuation / 20000)))
		);
		add1_avm_automated_valuation_c_2 :=  if(add1_avm_automated_valuation_c > 700000, 700000, add1_avm_automated_valuation_c);

		add1_avm_auto_valuation_code :=  map(avm_hit = 0                                => -1,
											 add1_avm_automated_valuation_c_2 <= 20000  => 0,
											 add1_avm_automated_valuation_c_2 <= 40000  => 1,
											 add1_avm_automated_valuation_c_2 <= 60000  => 2,
											 add1_avm_automated_valuation_c_2 <= 80000  => 3,
											 add1_avm_automated_valuation_c_2 <= 120000 => 4,
											 add1_avm_automated_valuation_c_2 <= 160000 => 5,
											 add1_avm_automated_valuation_c_2 <= 380000 => 6,
																						   7);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);


		add1_avm_med_code := if( avm_hit=0,
			map(
				add1_avm_med  =      0 => 13,
				add1_avm_med <=  60000 => 10,
				add1_avm_med <= 100000 => 11,
				add1_avm_med <= 340000 => 12,
				13
			),
			map(
				add1_avm_med <=  40000 => 0,
				add1_avm_med <= 260000 => 1,
				2
			)
		);
	

		since_add1_avm_assessed_code_m :=  map(since_add1_avm_assessed_val_code = -1 => 0.2584964906,
											   since_add1_avm_assessed_val_code = 0  => 0.2272075567,
											   since_add1_avm_assessed_val_code = 1  => 0.2399598394,
											   since_add1_avm_assessed_val_code = 2  => 0.2598187311,
																						0.2877784467);

		add1_avm_auto_valuation_code_m :=  map(add1_avm_auto_valuation_code = -1 => 0.2584964906,
											   add1_avm_auto_valuation_code = 0  => 0.3155737705,
											   add1_avm_auto_valuation_code = 1  => 0.2859362859,
											   add1_avm_auto_valuation_code = 2  => 0.2696969697,
											   add1_avm_auto_valuation_code = 3  => 0.2537037037,
											   add1_avm_auto_valuation_code = 4  => 0.2338251986,
											   add1_avm_auto_valuation_code = 5  => 0.2213114754,
											   add1_avm_auto_valuation_code = 6  => 0.2119429993,
																					0.1955645161);

		add1_avm_med_code_m :=  map(add1_avm_med_code = 0  => 0.3048166786,
									add1_avm_med_code = 1  => 0.2337256344,
									add1_avm_med_code = 2  => 0.205973623,
									add1_avm_med_code = 10 => 0.3366233766,
									add1_avm_med_code = 11 => 0.2978535725,
									add1_avm_med_code = 12 => 0.2696053306,
															  0.2359363328);

		avm_mod := -3.150913807 +
			(since_add1_avm_assessed_code_m * 2.1335512935) +
			(add1_avm_auto_valuation_code_m * 1.6561078482) +
			(add1_avm_med_code_m * 4.3791229134);

		avm_mod_2 := (100 * (exp(avm_mod) / (1 + exp(avm_mod))));
		since_adl_V_last_seen    := ((integer)sysyear - (real)((string)adl_v_last_seen)[1..4]);
		since_adl_W_last_seen    := ((integer)sysyear - (real)((string)adl_w_last_seen)[1..4]);
		since_header_last_seen   := ((integer)sysyear - (real)((string)header_last_seen)[1..4]);
		since_adl_v_last_seen_2  :=  if(since_adl_v_last_seen > 2000, -9999, since_adl_v_last_seen);
		since_adl_w_last_seen_2  :=  if(since_adl_w_last_seen > 2000, -9999, since_adl_w_last_seen);
		since_header_last_seen_2 :=  if(since_header_last_seen > 2000, -9999, since_header_last_seen);

		since_adl_v_last_seen_code :=  map(since_adl_v_last_seen_2 = -9999  => -1,
										   since_adl_v_last_seen_2 <= 0 => 0,
										   since_adl_v_last_seen_2 <= 3 => 1,
																		   2);

		since_adl_w_last_seen_code :=  map(since_adl_w_last_seen_2 = -9999  => -1,
										   since_adl_w_last_seen_2 <= 2 => 0,
																		   1);

		since_header_last_seen_code :=  map(since_header_last_seen_2 = -9999  => -1,
											since_header_last_seen_2 <= 0 => 0,
																			 1);

		since_adl_v_last_seen_code_m :=  map(since_adl_v_last_seen_code = -1 => 0.2605787739,
											 since_adl_v_last_seen_code = 0  => 0.21102801,
											 since_adl_v_last_seen_code = 1  => 0.2463467955,
																				0.2799657534);

		since_adl_w_last_seen_code_m :=  map(since_adl_w_last_seen_code = -1 => 0.2526774408,
											 since_adl_w_last_seen_code = 0  => 0.140776699,
																				0.1944444444);

		since_header_last_seen_code_m :=  map(since_header_last_seen_code = -1 => 0.3242491657,
											  since_header_last_seen_code = 0  => 0.2197853875,
																				  0.2567567568);

		base := 703;

		odds := (1 / 21);

		point := -40;

		logit := -6.988244863 +
			(ver_mod_b * 0.0223208312) +
			(derog_mod2_2 * 0.019027502) +
			(lien_unrel_flag_m * 3.0517194547) +
			(neg_sources_minor * 0.1736797792) +
			(prop_mod2_2 * 0.0233189401) +
			(age2_code_m * 3.2742291194) +
			(velo_mod3_2 * 0.0088933747) +
			(avm_mod_2 * 0.0374552394) +
			(since_adl_v_last_seen_code_m * 2.1998645695) +
			(since_adl_w_last_seen_code_m * 2.4475592803) +
			(since_header_last_seen_code_m * 0.7868390306);

		phat := (exp(logit) / (1 + exp(logit)));
		
		mod7_RV := truncate(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));
		ov_ssndead := (((integer)ssnlength > 0) and rc_decsflag);
		ov_ssnprior := ((rc_ssndobflag = 1) or (rc_pwssndobflag = '1'));
		ov_criminal_flag := (criminal_count > 0);
		ov_corrections := (rc_hrisksic = 2225);
		mod7_RV_cap := min(900, max(501, mod7_rv));
		mod7_rv_cap_2 :=  if((mod7_rv_cap > 610) and (ov_ssndead or (ov_ssnprior or (ov_criminal_flag or ov_corrections))), 610, mod7_rv_cap);
		mod7_rv_cap_3 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, mod7_rv_cap_2);
		RVG812 := mod7_rv_cap_3;


		self.seq := le.seq;


		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;		
		
		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RVG812 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),		
			RiskWise.rvReasonCodes(le, 4, inCalif, true)
		);
		
		
		//self.score := intformat( rvg812, 3, 1 );
		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			intformat( rvg812, 3, 1 )
		);		

	end;
	
	model := project( clam, doModel(left) );
	return model;
end;
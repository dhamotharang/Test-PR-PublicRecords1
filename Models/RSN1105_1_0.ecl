import ut, easi, risk_indicators, riskwise;

RSN_DEBUG := FALSE;

export RSN1105_1_0(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	#if(RSN_DEBUG)
		layout_debug := record
			Risk_Indicators.Layout_Boca_Shell clam;
			
			Integer adl_addr;
			Integer adl_hphn;
			Integer adl_ssn;
			Integer adl_dob;
			String c_span_lang;
			String c_unemp;
			Integer NAS_Summary;
			Integer NAP_Summary;
			qstring100 ver_sources;
			Boolean add1_isbestmatch;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_automated_valuation_6;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Integer add1_source_count;
			Boolean add1_eda_sourced;
			Boolean add1_applicant_owned;
			Boolean add1_family_owned;
			Integer add1_naprop;
			Integer add1_mortgage_amount;
			Integer property_owned_total;
			Integer addrs_10yr;
			Integer addrs_15yr;
			Integer namePerSSN_count;
			Integer ssns_per_adl;
			Integer addrs_per_adl;
			Integer phones_per_adl;
			Integer impulse_count;
			Integer attr_num_aircraft;
			Integer attr_eviction_count;
			String disposition;
			Integer filing_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer criminal_count;
			Integer felony_count;
			Integer rel_count;
			Integer rel_criminal_count;
			Integer crim_rel_within25miles;
			Integer crim_rel_within100miles;
			Integer crim_rel_within500miles;
			Integer rel_prop_owned_count;
			Integer rel_prop_sold_count;
			Integer rel_prop_sold_purchase_count;
			Integer rel_incomeunder100_count;
			Integer rel_incomeover100_count;
			Integer rel_homeunder150_count;
			Integer rel_homeunder200_count;
			Integer rel_homeunder300_count;
			Integer rel_homeunder500_count;
			Integer rel_homeover500_count;
			Integer watercraft_count;
			String ams_income_level_code;
			String wealth_index;
			Integer estimated_income;
			Integer add1_naprop_lvl;
			Integer match_lvl;
			Integer missing_lvl;
			Integer mismatch_lvl;
			Integer adl_match_lvl;
			Integer add1_fam_app_owned;
			Integer adl_addr_phn_mtch_lvl;
			Integer addrs_yr_lvl;
			Integer criminal_lvl;
			Boolean source_tot_ak;
			Boolean source_tot_am;
			Boolean source_tot_ar;
			Boolean source_tot_ba;
			Boolean source_tot_cg;
			Boolean source_tot_co;
			Boolean source_tot_cy;
			Boolean source_tot_da;
			Boolean source_tot_d;
			Boolean source_tot_dl;
			Boolean source_tot_ds;
			Boolean source_tot_eb;
			Boolean source_tot_em;
			Boolean source_tot_vo;
			Boolean source_tot_eq;
			Boolean source_tot_ff;
			Boolean source_tot_fr;
			Boolean source_tot_l2;
			Boolean source_tot_li;
			Boolean source_tot_mw;
			Boolean source_tot_nt;
			Boolean source_tot_p;
			Boolean source_tot_pl;
			Boolean source_tot_sl;
			Boolean source_tot_tu;
			Boolean source_tot_v;
			Boolean source_tot_w;
			Boolean source_tot_wp;
			Integer source_tot_count_pos;
			Integer source_tot_count_neg;
			Integer source_tot_lvl;
			Integer rel_home500plus_count;
			Integer rel_home300plus_count;
			Integer rel_home200plus_count;
			Integer rel_home150plus_count;
			Integer rel_home100plus_count;
			Integer rel_home150plus_pct;
			Integer rel_home100plus_pct;
			Integer rel_home200plus_pct;
			Integer rel_nicehome;
			Integer liens_unreleased_lvl;
			String _disposition;
			Integer bk_level;
			Integer ssns_per_adl_lvl;
			Integer add1_source_lvl;
			Integer estimated_income_lvl;
			Integer ao_ams_income_level_code;
			Boolean alt_nameperssn_count;
			Integer add1_avm_med_geo_lvl;
			Integer rel_prop_own_pct;
			Integer rel_prop_sold_pct;
			Integer rel_prop_sold_purch_pct;
			Integer rel_prop_sold_purch_pct_a;
			Integer add1_avm_automated_lvl;
			Integer rel_prop_own_pct_a;
			Integer impulse_count_2;
			Integer c_span_lang_lvl;
			Integer rel_prop_sold_pct_a;
			Boolean verlst_p;
			Boolean veradd_p;
			Boolean verphn_p;
			Integer ver_nap;
			Boolean contrary_ssn;
			Boolean verfst_s;
			Boolean verlst_s;
			Boolean veradd_s;
			Boolean verssn_s;
			Integer ver_nas;
			Integer wealth_index_lvl;
			Integer add1_avm_home_upgrade;
			Boolean ssns_per_adl_4p;
			Boolean addrs_per_adl_25p;
			Boolean phones_per_adl_2p;
			Boolean velocity_problem;
			Boolean zero_unemp;
			Integer add1_avm_good_home_equity;
			Boolean eviction_flag;
			Integer rel_income75plus_count;
			Integer rel_income75plus_pct;
			Integer rel_income75plus_high_pct;
			Integer crim_rel_25milesless_count_c31_b2;
			Integer crim_rel_100milesless_count_c31_b2;
			Integer crim_rel_500milesless_count;
			Integer crim_rel_lvl;
			Integer fips_ratio_c33_b1_1;
			Integer fips_ratio_c34;
			Integer fips_ratio;
			Integer fips_level;
			Integer property_owner_lvl;
			Real subscore0;
			Real subscore1;
			Real subscore2;
			Real subscore3;
			Real subscore4;
			Real subscore5;
			Real subscore6;
			Real subscore7;
			Real subscore8;
			Real subscore9;
			Real subscore10;
			Real subscore11;
			Real subscore12;
			Real subscore13;
			Real subscore14;
			Real subscore15;
			Real subscore16;
			Real subscore17;
			Real subscore18;
			Real subscore19;
			Real subscore20;
			Real subscore21;
			Real subscore22;
			Real subscore23;
			Real subscore24;
			Real subscore25;
			Real subscore26;
			Real subscore27;
			Real subscore28;
			Real subscore29;
			Real subscore30;
			Real subscore31;
			Real subscore32;
			Real subscore33;
			Real subscore_total;
			Integer RSN1105_1_0;
		end;
		layout_debug doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM
	#else
		Models.Layout_RecoverScore doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM
	#end






		adl_addr                         := le.adl_shell_flags.adl_addr;
		adl_hphn                         := le.adl_shell_flags.adl_hphn;
		adl_ssn                          := le.adl_shell_flags.adl_ssn;
		adl_dob                          := le.adl_shell_flags.adl_dob;
		c_span_lang                      := trim(ri.SPAN_LANG);
		c_unemp                          := trim(ri.unemp);
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		ver_sources                      := le.header_summary.ver_sources;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_6   := le.avm.input_address_information.avm_automated_valuation6;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		property_owned_total             := le.address_verification.owned.property_total;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		impulse_count                    := le.impulse.count;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_eviction_count              := le.bjl.eviction_count;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		rel_count                        := le.relatives.relative_count;
		rel_criminal_count               := le.relatives.relative_criminal_count;
		crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
		crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
		crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
		rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
		rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
		rel_prop_sold_purchase_count     := le.relatives.sold.relatives_property_owned_purchase_count;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
		rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
		rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
		rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
		rel_homeover500_count            := le.relatives.relative_homeover500_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_income_level_code            := le.student.income_level_code;
		wealth_index                     := le.wealth_indicator;
		estimated_income                 := le.estimated_income;



		NULL := -999999999;

		add1_naprop_lvl := map(
				(add1_naprop in [3, 4]) and add1_eda_sourced => 3,
				(add1_naprop in [3, 4])                      => 2,
				not(add1_isbestmatch)                        => 0,
																												1);

		// match_lvl := if(max((integer)adl_addr = (string)2, (integer)adl_hphn = 2, (integer)adl_ssn = (string)2, (integer)adl_dob = (string)2) = NULL, NULL, sum((integer)adl_addr = (string)2, (integer)adl_hphn = 2, (integer)adl_ssn = (string)2, (integer)adl_dob = (string)2));
		match_lvl    := (integer1)(adl_addr=2) + (integer1)(adl_hphn=2) + (integer1)(adl_ssn=2) + (integer1)(adl_dob=2);
		missing_lvl  := (integer1)(adl_addr=0) + (integer1)(adl_hphn=0) + (integer1)(adl_ssn=0) + (integer1)(adl_dob=0);
		mismatch_lvl := (integer1)(adl_addr=3) + (integer1)(adl_hphn=3) + (integer1)(adl_ssn=3) + (integer1)(adl_dob=3);
		// mismatch_lvl := if(max((integer)adl_addr = (string)3, (integer)adl_hphn = 3, (integer)adl_ssn = (string)3, (integer)adl_dob = (string)3) = NULL, NULL, sum((integer)adl_addr = (string)3, (integer)adl_hphn = 3, (integer)adl_ssn = (string)3, (integer)adl_dob = (string)3));

		adl_match_lvl := map(
				match_lvl = 4 and missing_lvl = 0 => 4,
				match_lvl = 3 and missing_lvl = 1 => 3,
				match_lvl = 3 and missing_lvl = 0 => 2,
				match_lvl = 2 and missing_lvl < 2 => 1,
				match_lvl = 0 and missing_lvl = 4 => -1,
																						 0);

		add1_fam_app_owned := if(add1_family_owned or add1_applicant_owned, 1, 0);

		adl_addr_phn_mtch_lvl := map(
				adl_addr = 2 and adl_hphn = 2        => 3,
				adl_addr = 2                         => 2,
				adl_addr = 3 or adl_addr = 1 => 1,
																												0);

		addrs_yr_lvl := map(
				addrs_10yr <= 0                     => 5,
				addrs_10yr <= 1                     => 0,
				addrs_10yr <= 3                     => 1,
				addrs_10yr <= 7 and addrs_15yr <= 4 => 1,
				addrs_10yr <= 7                     => 2,
				addrs_10yr <= 10                    => 3,
																							 4);

		criminal_lvl := map(
				criminal_count > 5 and felony_count > 0 => 3,
				criminal_count > 5                      => 2,
				criminal_count > 0 and felony_count > 0 => 2,
				criminal_count > 0                      => 1,
																									 0);

		source_tot_ak := Models.Common.findw_cpp(ver_sources, 'AK' , ' ,', 'I') > 0;
		source_tot_am := Models.Common.findw_cpp(ver_sources, 'AM' , ' ,', 'I') > 0;
		source_tot_ar := Models.Common.findw_cpp(ver_sources, 'AR' , ' ,', 'I') > 0;
		source_tot_ba := Models.Common.findw_cpp(ver_sources, 'BA' , ' ,', 'I') > 0;
		source_tot_cg := Models.Common.findw_cpp(ver_sources, 'CG' , ' ,', 'I') > 0;
		source_tot_co := Models.Common.findw_cpp(ver_sources, 'CO' , ' ,', 'I') > 0;
		source_tot_cy := Models.Common.findw_cpp(ver_sources, 'CY' , ' ,', 'I') > 0;
		source_tot_da := Models.Common.findw_cpp(ver_sources, 'DA' , ' ,', 'I') > 0;
		source_tot_d  := Models.Common.findw_cpp(ver_sources, 'D' , ' ,', 'I') > 0;
		source_tot_dl := Models.Common.findw_cpp(ver_sources, 'DL' , ' ,', 'I') > 0;
		source_tot_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ' ,', 'I') > 0;
		source_tot_eb := Models.Common.findw_cpp(ver_sources, 'EB' , ' ,', 'I') > 0;
		source_tot_em := Models.Common.findw_cpp(ver_sources, 'EM' , ' ,', 'I') > 0;
		source_tot_vo := Models.Common.findw_cpp(ver_sources, 'VO' , ' ,', 'I') > 0;
		source_tot_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ' ,', 'I') > 0;
		source_tot_ff := Models.Common.findw_cpp(ver_sources, 'FF' , ' ,', 'I') > 0;
		source_tot_fr := Models.Common.findw_cpp(ver_sources, 'FR' , ' ,', 'I') > 0;
		source_tot_l2 := Models.Common.findw_cpp(ver_sources, 'L2' , ' ,', 'I') > 0;
		source_tot_li := Models.Common.findw_cpp(ver_sources, 'LI' , ' ,', 'I') > 0;
		source_tot_mw := Models.Common.findw_cpp(ver_sources, 'MW' , ' ,', 'I') > 0;
		source_tot_nt := Models.Common.findw_cpp(ver_sources, 'NT' , ' ,', 'I') > 0;
		source_tot_p  := Models.Common.findw_cpp(ver_sources, 'P' , ' ,', 'I') > 0;
		source_tot_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ' ,', 'I') > 0;
		source_tot_sl := Models.Common.findw_cpp(ver_sources, 'SL' , ' ,', 'I') > 0;
		source_tot_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ' ,', 'I') > 0;
		source_tot_v  := Models.Common.findw_cpp(ver_sources, 'V' , ' ,', 'I') > 0;
		source_tot_w  := Models.Common.findw_cpp(ver_sources, 'W' , ' ,', 'I') > 0;
		source_tot_wp := Models.Common.findw_cpp(ver_sources, 'WP' , ' ,', 'I') > 0;

		source_tot_count_pos := if(max((integer)source_tot_am, (integer)source_tot_ar, (integer)source_tot_cy, (integer)source_tot_d, (integer)source_tot_dl, (integer)source_tot_eb, (integer)source_tot_em, (integer)source_tot_vo, (integer)source_tot_eq, (integer)source_tot_mw, (integer)source_tot_p, (integer)source_tot_pl, (integer)source_tot_sl, (integer)source_tot_tu, (integer)source_tot_v, (integer)source_tot_w, (integer)source_tot_wp) = NULL, NULL, sum((integer)source_tot_am, (integer)source_tot_ar, (integer)source_tot_cy, (integer)source_tot_d, (integer)source_tot_dl, (integer)source_tot_eb, (integer)source_tot_em, (integer)source_tot_vo, (integer)source_tot_eq, (integer)source_tot_mw, (integer)source_tot_p, (integer)source_tot_pl, (integer)source_tot_sl, (integer)source_tot_tu, (integer)source_tot_v, (integer)source_tot_w, (integer)source_tot_wp));

		source_tot_count_neg := if(max((integer)source_tot_ak, (integer)source_tot_ba, (integer)source_tot_cg, (integer)source_tot_co, (integer)source_tot_da, (integer)source_tot_ds, (integer)source_tot_ff, (integer)source_tot_fr, (integer)source_tot_l2, (integer)source_tot_li, (integer)source_tot_nt) = NULL, NULL, sum((integer)source_tot_ak, (integer)source_tot_ba, (integer)source_tot_cg, (integer)source_tot_co, (integer)source_tot_da, (integer)source_tot_ds, (integer)source_tot_ff, (integer)source_tot_fr, (integer)source_tot_l2, (integer)source_tot_li, (integer)source_tot_nt));

		source_tot_lvl := map(
				source_tot_count_pos > 0 and source_tot_count_neg = 0 => 2,
				source_tot_count_pos > 0                              => 1,
																																 0);

		rel_home500plus_count := rel_homeover500_count;

		rel_home300plus_count := if(max(rel_home500plus_count, rel_homeunder500_count) = NULL, NULL, sum(if(rel_home500plus_count = NULL, 0, rel_home500plus_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count)));

		rel_home200plus_count := if(max(rel_home300plus_count, rel_homeunder300_count) = NULL, NULL, sum(if(rel_home300plus_count = NULL, 0, rel_home300plus_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count)));

		rel_home150plus_count := if(max(rel_home200plus_count, rel_homeunder200_count) = NULL, NULL, sum(if(rel_home200plus_count = NULL, 0, rel_home200plus_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count)));

		rel_home100plus_count := if(max(rel_home150plus_count, rel_homeunder150_count) = NULL, NULL, sum(if(rel_home150plus_count = NULL, 0, rel_home150plus_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count)));

		rel_home150plus_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_home150plus_count * 100 / rel_count));

		rel_home100plus_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_home100plus_count * 100 / rel_count));

		rel_home200plus_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_home200plus_count * 100 / rel_count));

		rel_nicehome := if(rel_home200plus_pct >= 60 or rel_home150plus_pct >= 70 or rel_home100plus_pct >= 100, 1, 0);

		liens_unreleased_lvl := map(
				liens_historical_unreleased_ct > 0 and liens_recent_unreleased_count > 2   => 3,
				liens_historical_unreleased_ct > 3                                         => 2,
				0 < liens_historical_unreleased_ct AND liens_historical_unreleased_ct <= 3 => 1,
				liens_historical_unreleased_ct = 0 and liens_recent_unreleased_count > 0   => 1,
																																											0);

		_disposition := map(
				StringLib.StringToUpperCase(disposition) = 'DISMISSED' => 'DISMISSED',
				disposition = ' '                                      => 'NONE',
																																	'DISCHARGE');

		bk_level := map(
				_disposition = 'DISMISSED'                      => 2,
				_disposition = 'DISCHARGE' and filing_count < 2 => 0,
																													 1);

		ssns_per_adl_lvl := map(
				ssns_per_adl = 1                       => 0,
				1 < ssns_per_adl AND ssns_per_adl <= 3 => 1,
				ssns_per_adl = 0                       => 2,
																									3);

		add1_source_lvl := map(
				add1_source_count > 8 => 3,
				add1_source_count > 4 => 2,
				add1_source_count > 0 => 1,
																 0);

		estimated_income_lvl := map(
				estimated_income <= 28000 => 0,
				estimated_income <= 34000 => 1,
				estimated_income <= 40000 => 2,
																		 3);

		ao_ams_income_level_code := map(
				(ams_income_level_code in ['I', 'J', 'K'])      => 3,
				(ams_income_level_code in ['E', 'F', 'G', 'H']) => 2,
				(ams_income_level_code in ['A', 'B', 'C', 'D']) => 0,
																													 1);

		alt_nameperssn_count := nameperssn_count > 0;

		add1_avm_med_geo_lvl := map(
				0 < add1_avm_med_geo12 AND add1_avm_med_geo12 <= 50000       => 0,
				50000 < add1_avm_med_geo12 AND add1_avm_med_geo12 <= 125000  => 1,
				125000 < add1_avm_med_geo12 AND add1_avm_med_geo12 <= 150000 => 2,
				add1_avm_med_geo12 > 150000 and add1_avm_med_geo11 > 225000  => 4,
				add1_avm_med_geo12 > 150000                                  => 3,
																																				2);

		rel_prop_own_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_prop_owned_count * 100 / rel_count));

		rel_prop_sold_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_prop_sold_count * 100 / rel_count));

		rel_prop_sold_purch_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_prop_sold_purchase_count * 100 / rel_count));

		rel_prop_sold_purch_pct_a := map(
				rel_count = 0                 => 0,
				rel_prop_sold_purch_pct >= 50 => 3,
				rel_prop_sold_purch_pct >= 20 => 2,
				rel_prop_sold_purch_pct >= 10 => 1,
																				 0);

		add1_avm_automated_lvl := map(
				add1_avm_automated_valuation = 0                                                 => 1,
				0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 100000      => 0,
				100000 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 200000 => 2,
																																														3);

		rel_prop_own_pct_a := map(
				rel_count = 0          => 0,
				rel_prop_own_pct >= 40 => 3,
				rel_prop_own_pct >= 20 => 2,
				rel_prop_own_pct >= 10 => 1,
																	0);

		impulse_count_2 := min(if(impulse_count = NULL, -NULL, impulse_count), 2);

		c_span_lang_lvl := map(
				TRIM(C_SPAN_LANG) = ''																								 => 0,
				0 <= (INTEGER)TRIM(C_SPAN_LANG) AND (INTEGER)TRIM(C_SPAN_LANG) < 70    => 3,
				70 <= (INTEGER)TRIM(C_SPAN_LANG) AND (INTEGER)TRIM(C_SPAN_LANG) < 110  => 2,
				110 <= (INTEGER)TRIM(C_SPAN_LANG) AND (INTEGER)TRIM(C_SPAN_LANG) < 140 => 1,
																																									0);

		rel_prop_sold_pct_a := map(
				rel_count = 0           => 0,
				rel_prop_sold_pct >= 40 => 3,
				rel_prop_sold_pct >= 20 => 2,
				rel_prop_sold_pct >= 10 => 1,
																	 0);

		verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

		veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

		verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		ver_nap := map(
				veradd_p and verphn_p and verlst_p => 3,
				veradd_p                           => 2,
				verphn_p or verlst_p               => 1,
																							0);

		contrary_ssn := (nas_summary in [1]);

		verfst_s := (nas_summary in [2, 3, 4, 8, 9, 10, 12]);

		verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);

		veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

		verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);

		ver_nas := map(
				verfst_s and verlst_s and verssn_s => 3,
				verlst_s and verfst_s              => 2,
				not(contrary_ssn)                  => 1,
																							0);

		wealth_index_lvl := map(
				(wealth_index in ['5', '6']) => 3,
				(wealth_index in ['3', '4']) => 2,
				wealth_index = (string)2     => 1,
																				0);

		add1_avm_home_upgrade := if(add1_avm_automated_valuation_6 - add1_avm_automated_valuation < -200000, 1, 0);

		ssns_per_adl_4p := ssns_per_adl >= 4;

		addrs_per_adl_25p := addrs_per_adl >= 25;

		phones_per_adl_2p := phones_per_adl >= 2;

		velocity_problem := ssns_per_adl_4p or addrs_per_adl_25p or phones_per_adl_2p;

		zero_unemp := C_UNEMP = (string)0;

		add1_avm_good_home_equity := if(add1_mortgage_amount - add1_avm_automated_valuation < - 100000, 1, 0);

		eviction_flag := attr_eviction_count > 0;

		rel_income75plus_count := if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)));

		rel_income75plus_pct := map(
				rel_count = 0 => -1,
												 truncate(rel_income75plus_count * 100 / rel_count));

		rel_income75plus_high_pct := if(rel_income75plus_pct >= 40, 1, 0);

		crim_rel_25milesless_count_c31_b2 := IF(rel_count > 0, crim_rel_within25miles, -1);
		
		crim_rel_100milesless_count_c31_b2 := IF(rel_count > 0, SUM(crim_rel_25milesless_count_c31_b2, crim_rel_within100miles), -1);
		
		crim_rel_500milesless_count := IF(rel_count > 0, SUM(crim_rel_100milesless_count_c31_b2, crim_rel_within500miles), -1);

		// crim_rel_100milesless_count_c31_b2 := if(max(crim_rel_25milesless_count_c31_b2, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_25milesless_count_c31_b2 = NULL, 0, crim_rel_25milesless_count_c31_b2), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles)));

		// crim_rel_500milesless_count := map(
				// rel_count = 0 => -1,
												 // if(max(crim_rel_100milesless_count_c31_b2, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_100milesless_count_c31_b2 = NULL, 0, crim_rel_100milesless_count_c31_b2), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));

		crim_rel_lvl := map(
				rel_count = 0                    => -1,
				crim_rel_500milesless_count >= 5 => 3,
				crim_rel_500milesless_count >= 2 => 2,
				crim_rel_500milesless_count >= 1 => 1,
				rel_criminal_count > 2           => 1,
																						0);

		fips_ratio_c33_b1_1 := (INTEGER)truncate((INTEGER)add1_avm_automated_valuation * 100 / add1_avm_med_fips);

		fips_ratio_c34 := if(add1_avm_automated_valuation <= 0, -1, (INTEGER)fips_ratio_c33_b1_1);

		fips_ratio := if(add1_avm_med_fips > 0, fips_ratio_c34, -2);

		fips_level := map(
				fips_ratio > 120                      => 3,
				50 < fips_ratio AND fips_ratio <= 120 => 2,
				0 < fips_ratio AND fips_ratio <= 50   => 0,
																								 1);

		property_owner_lvl := map(
				property_owned_total = 0                      => 0,
				watercraft_count > 0 or attr_num_aircraft > 0 => 2,
				property_owned_total = 1                      => 1,
																												 2);

		subscore0 := map(
				(add1_naprop_lvl in [0]) => 13.522180,
				(add1_naprop_lvl in [1]) => 10.163617,
				(add1_naprop_lvl in [2]) => 49.901496,
				(add1_naprop_lvl in [3]) => 55.773219,
																		20.599976);

		subscore1 := map(
				(adl_match_lvl in [-1]) => 84.063001,
				(adl_match_lvl in [0])  => 12.941446,
				(adl_match_lvl in [1])  => 17.207672,
				(adl_match_lvl in [2])  => 18.865055,
				(adl_match_lvl in [3])  => 22.161303,
				(adl_match_lvl in [4])  => 25.690596,
																	 20.599976);

		subscore2 := map(
				(add1_fam_app_owned in [0]) => 28.411577,
				(add1_fam_app_owned in [1]) => -5.303469,
																			 20.599976);

		subscore3 := map(
				(adl_addr_phn_mtch_lvl in [0]) => -15.674334,
				(adl_addr_phn_mtch_lvl in [1]) => 18.903969,
				(adl_addr_phn_mtch_lvl in [2]) => 22.124738,
				(adl_addr_phn_mtch_lvl in [3]) => 65.374198,
																					20.599976);

		subscore4 := map(
				(addrs_yr_lvl in [0]) => 40.393445,
				(addrs_yr_lvl in [1]) => 25.408543,
				(addrs_yr_lvl in [2]) => 15.668945,
				(addrs_yr_lvl in [3]) => 16.993901,
				(addrs_yr_lvl in [4]) => 16.505358,
				(addrs_yr_lvl in [5]) => 7.362659,
																 20.599976);

		subscore5 := map(
				(criminal_lvl in [0]) => 24.222418,
				(criminal_lvl in [1]) => 11.606103,
				(criminal_lvl in [2]) => 3.346057,
				(criminal_lvl in [3]) => -5.738069,
																 20.599976);

		subscore6 := map(
				(source_tot_lvl in [0]) => -2.088959,
				(source_tot_lvl in [1]) => 20.027249,
				(source_tot_lvl in [2]) => 24.589302,
																	 20.599976);

		subscore7 := map(
				(rel_nicehome in [0]) => 17.413831,
				(rel_nicehome in [1]) => 33.226486,
																 20.599976);

		subscore8 := map(
				(liens_unreleased_lvl in [0]) => 22.841856,
				(liens_unreleased_lvl in [1]) => 17.520338,
				(liens_unreleased_lvl in [2]) => 11.211090,
				(liens_unreleased_lvl in [3]) => 5.162264,
																				 20.599976);

		subscore9 := map(
				(bk_level in [0]) => 33.456631,
				(bk_level in [1]) => 20.055593,
				(bk_level in [2]) => 0.650750,
														 20.599976);

		subscore10 := map(
				(ssns_per_adl_lvl in [0]) => 23.047763,
				(ssns_per_adl_lvl in [1]) => 19.926739,
				(ssns_per_adl_lvl in [2]) => 4.274050,
				(ssns_per_adl_lvl in [3]) => 21.256870,
																		 20.599976);

		subscore11 := map(
				(add1_source_lvl in [0]) => 35.750928,
				(add1_source_lvl in [1]) => 18.165802,
				(add1_source_lvl in [2]) => 22.017267,
				(add1_source_lvl in [3]) => 32.964066,
																		20.599976);

		subscore12 := map(
				(estimated_income_lvl in [0]) => 13.834638,
				(estimated_income_lvl in [1]) => 23.324066,
				(estimated_income_lvl in [2]) => 24.456771,
				(estimated_income_lvl in [3]) => 19.245927,
																				 20.599976);

		subscore13 := map(
				(ao_ams_income_level_code in [0]) => 17.204979,
				(ao_ams_income_level_code in [1]) => 18.884334,
				(ao_ams_income_level_code in [2]) => 32.339594,
				(ao_ams_income_level_code in [3]) => 41.704858,
																						 20.599976);

		subscore14 := map(
				(alt_nameperssn_count in [0]) => 22.051365,
				(alt_nameperssn_count in [1]) => 12.736717,
																				 20.599976);

		subscore15 := map(
				(add1_avm_med_geo_lvl in [0]) => 9.797681,
				(add1_avm_med_geo_lvl in [1]) => 20.088529,
				(add1_avm_med_geo_lvl in [2]) => 21.476254,
				(add1_avm_med_geo_lvl in [3]) => 22.274794,
				(add1_avm_med_geo_lvl in [4]) => 21.568588,
																				 20.599976);

		subscore16 := map(
				(rel_prop_sold_purch_pct_a in [0]) => 20.916684,
				(rel_prop_sold_purch_pct_a in [1]) => 19.295551,
				(rel_prop_sold_purch_pct_a in [2]) => 11.053548,
				(rel_prop_sold_purch_pct_a in [3]) => 34.620956,
																							20.599976);

		subscore17 := map(
				(add1_avm_automated_lvl in [0]) => 14.241527,
				(add1_avm_automated_lvl in [1]) => 21.720044,
				(add1_avm_automated_lvl in [2]) => 20.958511,
				(add1_avm_automated_lvl in [3]) => 21.691148,
																					 20.599976);

		subscore18 := map(
				(rel_prop_own_pct_a in [0]) => 18.637959,
				(rel_prop_own_pct_a in [1]) => 18.410951,
				(rel_prop_own_pct_a in [2]) => 27.214367,
				(rel_prop_own_pct_a in [3]) => 28.525974,
																			 20.599976);

		subscore19 := map(
				(impulse_count_2 in [0]) => 21.092757,
				(impulse_count_2 in [1]) => 15.122676,
				(impulse_count_2 in [2]) => 17.195965,
																		20.599976);

		subscore20 := map(
				(c_span_lang_lvl in [0]) => 18.199393,
				(c_span_lang_lvl in [1]) => 18.088641,
				(c_span_lang_lvl in [2]) => 23.288826,
				(c_span_lang_lvl in [3]) => 27.190430,
																		20.599976);

		subscore21 := map(
				(rel_prop_sold_pct_a in [0]) => 18.812648,
				(rel_prop_sold_pct_a in [1]) => 24.383703,
				(rel_prop_sold_pct_a in [2]) => 28.453142,
				(rel_prop_sold_pct_a in [3]) => 22.253246,
																				20.599976);

		subscore22 := map(
				(ver_nap in [0]) => 19.150827,
				(ver_nap in [1]) => 21.593125,
				(ver_nap in [2]) => 22.670828,
				(ver_nap in [3]) => 17.195656,
														20.599976);

		subscore23 := map(
				(ver_nas in [0]) => 13.318040,
				(ver_nas in [1]) => 12.661847,
				(ver_nas in [2]) => 18.860065,
				(ver_nas in [3]) => 21.468319,
														20.599976);

		subscore24 := map(
				(wealth_index_lvl in [0]) => 18.908593,
				(wealth_index_lvl in [1]) => 22.369208,
				(wealth_index_lvl in [2]) => 20.407144,
				(wealth_index_lvl in [3]) => 17.740033,
																		 20.599976);

		subscore25 := map(
				(add1_avm_home_upgrade in [0]) => 19.948531,
				(add1_avm_home_upgrade in [1]) => 36.676076,
																					20.599976);

		subscore26 := map(
				(velocity_problem in [0]) => 20.946286,
				(velocity_problem in [1]) => 16.359197,
																		 20.599976);

		subscore27 := map(
				(zero_unemp in [0]) => 20.445025,
				(zero_unemp in [1]) => 24.828387,
															 20.599976);

		subscore28 := map(
				(add1_avm_good_home_equity in [0]) => 19.828154,
				(add1_avm_good_home_equity in [1]) => 23.938477,
																							20.599976);

		subscore29 := map(
				(eviction_flag in [0]) => 20.747043,
				(eviction_flag in [1]) => 19.762875,
																	20.599976);

		subscore30 := map(
				(rel_income75plus_high_pct in [0]) => 20.238531,
				(rel_income75plus_high_pct in [1]) => 27.488448,
																							20.599976);

		subscore31 := map(
				(crim_rel_lvl in [-1]) => 21.847951,
				(crim_rel_lvl in [0])  => 19.565518,
				(crim_rel_lvl in [1])  => 22.479268,
				(crim_rel_lvl in [2])  => 18.146869,
				(crim_rel_lvl in [3])  => 24.427210,
																	20.599976);

		subscore32 := map(
				(fips_level in [0]) => 22.696913,
				(fips_level in [1]) => 20.197863,
				(fips_level in [2]) => 19.744320,
				(fips_level in [3]) => 23.183703,
															 20.599976);

		subscore33 := map(
				(property_owner_lvl in [0]) => 20.232717,
				(property_owner_lvl in [1]) => 21.131989,
				(property_owner_lvl in [2]) => 24.381415,
																			 20.599976);

		subscore_total := subscore0 +
				subscore1 +
				subscore2 +
				subscore3 +
				subscore4 +
				subscore5 +
				subscore6 +
				subscore7 +
				subscore8 +
				subscore9 +
				subscore10 +
				subscore11 +
				subscore12 +
				subscore13 +
				subscore14 +
				subscore15 +
				subscore16 +
				subscore17 +
				subscore18 +
				subscore19 +
				subscore20 +
				subscore21 +
				subscore22 +
				subscore23 +
				subscore24 +
				subscore25 +
				subscore26 +
				subscore27 +
				subscore28 +
				subscore29 +
				subscore30 +
				subscore31 +
				subscore32 +
				subscore33;

		rsn1105_1_0 := round(min(if(max(subscore_total, (real)301) = NULL, -NULL, max(subscore_total, (real)301)), 999));












		#if(RSN_DEBUG)
			self.clam := le;
			self.adl_addr                           := adl_addr;
			self.adl_hphn                           := adl_hphn;
			self.adl_ssn                            := adl_ssn;
			self.adl_dob                            := adl_dob;
			self.c_span_lang                        := c_span_lang;
			self.c_unemp                            := c_unemp;
			self.nas_summary                        := nas_summary;
			self.nap_summary                        := nap_summary;
			self.ver_sources                        := ver_sources;
			self.add1_isbestmatch                   := add1_isbestmatch;
			self.add1_avm_automated_valuation       := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_6     := add1_avm_automated_valuation_6;
			self.add1_avm_med_fips                  := add1_avm_med_fips;
			self.add1_avm_med_geo11                 := add1_avm_med_geo11;
			self.add1_avm_med_geo12                 := add1_avm_med_geo12;
			self.add1_source_count                  := add1_source_count;
			self.add1_eda_sourced                   := add1_eda_sourced;
			self.add1_applicant_owned               := add1_applicant_owned;
			self.add1_family_owned                  := add1_family_owned;
			self.add1_naprop                        := add1_naprop;
			self.add1_mortgage_amount               := add1_mortgage_amount;
			self.property_owned_total               := property_owned_total;
			self.addrs_10yr                         := addrs_10yr;
			self.addrs_15yr                         := addrs_15yr;
			self.nameperssn_count                   := nameperssn_count;
			self.ssns_per_adl                       := ssns_per_adl;
			self.addrs_per_adl                      := addrs_per_adl;
			self.phones_per_adl                     := phones_per_adl;
			self.impulse_count                      := impulse_count;
			self.attr_num_aircraft                  := attr_num_aircraft;
			self.attr_eviction_count                := attr_eviction_count;
			self.disposition                        := disposition;
			self.filing_count                       := filing_count;
			self.liens_recent_unreleased_count      := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct     := liens_historical_unreleased_ct;
			self.criminal_count                     := criminal_count;
			self.felony_count                       := felony_count;
			self.rel_count                          := rel_count;
			self.rel_criminal_count                 := rel_criminal_count;
			self.crim_rel_within25miles             := crim_rel_within25miles;
			self.crim_rel_within100miles            := crim_rel_within100miles;
			self.crim_rel_within500miles            := crim_rel_within500miles;
			self.rel_prop_owned_count               := rel_prop_owned_count;
			self.rel_prop_sold_count                := rel_prop_sold_count;
			self.rel_prop_sold_purchase_count       := rel_prop_sold_purchase_count;
			self.rel_incomeunder100_count           := rel_incomeunder100_count;
			self.rel_incomeover100_count            := rel_incomeover100_count;
			self.rel_homeunder150_count             := rel_homeunder150_count;
			self.rel_homeunder200_count             := rel_homeunder200_count;
			self.rel_homeunder300_count             := rel_homeunder300_count;
			self.rel_homeunder500_count             := rel_homeunder500_count;
			self.rel_homeover500_count              := rel_homeover500_count;
			self.watercraft_count                   := watercraft_count;
			self.ams_income_level_code              := ams_income_level_code;
			self.wealth_index                       := wealth_index;
			self.estimated_income                   := estimated_income;
			self.add1_naprop_lvl                    := add1_naprop_lvl;
			self.match_lvl                          := match_lvl;
			self.missing_lvl                        := missing_lvl;
			self.mismatch_lvl                       := mismatch_lvl;
			self.adl_match_lvl                      := adl_match_lvl;
			self.add1_fam_app_owned                 := add1_fam_app_owned;
			self.adl_addr_phn_mtch_lvl              := adl_addr_phn_mtch_lvl;
			self.addrs_yr_lvl                       := addrs_yr_lvl;
			self.criminal_lvl                       := criminal_lvl;
			self.source_tot_ak                      := source_tot_ak;
			self.source_tot_am                      := source_tot_am;
			self.source_tot_ar                      := source_tot_ar;
			self.source_tot_ba                      := source_tot_ba;
			self.source_tot_cg                      := source_tot_cg;
			self.source_tot_co                      := source_tot_co;
			self.source_tot_cy                      := source_tot_cy;
			self.source_tot_da                      := source_tot_da;
			self.source_tot_d                       := source_tot_d;
			self.source_tot_dl                      := source_tot_dl;
			self.source_tot_ds                      := source_tot_ds;
			self.source_tot_eb                      := source_tot_eb;
			self.source_tot_em                      := source_tot_em;
			self.source_tot_vo                      := source_tot_vo;
			self.source_tot_eq                      := source_tot_eq;
			self.source_tot_ff                      := source_tot_ff;
			self.source_tot_fr                      := source_tot_fr;
			self.source_tot_l2                      := source_tot_l2;
			self.source_tot_li                      := source_tot_li;
			self.source_tot_mw                      := source_tot_mw;
			self.source_tot_nt                      := source_tot_nt;
			self.source_tot_p                       := source_tot_p;
			self.source_tot_pl                      := source_tot_pl;
			self.source_tot_sl                      := source_tot_sl;
			self.source_tot_tu                      := source_tot_tu;
			self.source_tot_v                       := source_tot_v;
			self.source_tot_w                       := source_tot_w;
			self.source_tot_wp                      := source_tot_wp;
			self.source_tot_count_pos               := source_tot_count_pos;
			self.source_tot_count_neg               := source_tot_count_neg;
			self.source_tot_lvl                     := source_tot_lvl;
			self.rel_home500plus_count              := rel_home500plus_count;
			self.rel_home300plus_count              := rel_home300plus_count;
			self.rel_home200plus_count              := rel_home200plus_count;
			self.rel_home150plus_count              := rel_home150plus_count;
			self.rel_home100plus_count              := rel_home100plus_count;
			self.rel_home150plus_pct                := rel_home150plus_pct;
			self.rel_home100plus_pct                := rel_home100plus_pct;
			self.rel_home200plus_pct                := rel_home200plus_pct;
			self.rel_nicehome                       := rel_nicehome;
			self.liens_unreleased_lvl               := liens_unreleased_lvl;
			self._disposition                       := _disposition;
			self.bk_level                           := bk_level;
			self.ssns_per_adl_lvl                   := ssns_per_adl_lvl;
			self.add1_source_lvl                    := add1_source_lvl;
			self.estimated_income_lvl               := estimated_income_lvl;
			self.ao_ams_income_level_code           := ao_ams_income_level_code;
			self.alt_nameperssn_count               := alt_nameperssn_count;
			self.add1_avm_med_geo_lvl               := add1_avm_med_geo_lvl;
			self.rel_prop_own_pct                   := rel_prop_own_pct;
			self.rel_prop_sold_pct                  := rel_prop_sold_pct;
			self.rel_prop_sold_purch_pct            := rel_prop_sold_purch_pct;
			self.rel_prop_sold_purch_pct_a          := rel_prop_sold_purch_pct_a;
			self.add1_avm_automated_lvl             := add1_avm_automated_lvl;
			self.rel_prop_own_pct_a                 := rel_prop_own_pct_a;
			self.impulse_count_2                    := impulse_count_2;
			self.c_span_lang_lvl                    := c_span_lang_lvl;
			self.rel_prop_sold_pct_a                := rel_prop_sold_pct_a;
			self.verlst_p                           := verlst_p;
			self.veradd_p                           := veradd_p;
			self.verphn_p                           := verphn_p;
			self.ver_nap                            := ver_nap;
			self.contrary_ssn                       := contrary_ssn;
			self.verfst_s                           := verfst_s;
			self.verlst_s                           := verlst_s;
			self.veradd_s                           := veradd_s;
			self.verssn_s                           := verssn_s;
			self.ver_nas                            := ver_nas;
			self.wealth_index_lvl                   := wealth_index_lvl;
			self.add1_avm_home_upgrade              := add1_avm_home_upgrade;
			self.ssns_per_adl_4p                    := ssns_per_adl_4p;
			self.addrs_per_adl_25p                  := addrs_per_adl_25p;
			self.phones_per_adl_2p                  := phones_per_adl_2p;
			self.velocity_problem                   := velocity_problem;
			self.zero_unemp                         := zero_unemp;
			self.add1_avm_good_home_equity          := add1_avm_good_home_equity;
			self.eviction_flag                      := eviction_flag;
			self.rel_income75plus_count             := rel_income75plus_count;
			self.rel_income75plus_pct               := rel_income75plus_pct;
			self.rel_income75plus_high_pct          := rel_income75plus_high_pct;
			self.crim_rel_25milesless_count_c31_b2  := crim_rel_25milesless_count_c31_b2;
			self.crim_rel_100milesless_count_c31_b2 := crim_rel_100milesless_count_c31_b2;
			self.crim_rel_500milesless_count        := crim_rel_500milesless_count;
			self.crim_rel_lvl                       := crim_rel_lvl;
			self.fips_ratio_c33_b1_1                := fips_ratio_c33_b1_1;
			self.fips_ratio_c34                     := fips_ratio_c34;
			self.fips_ratio                         := fips_ratio;
			self.fips_level                         := fips_level;
			self.property_owner_lvl                 := property_owner_lvl;
			self.subscore0                          := subscore0;
			self.subscore1                          := subscore1;
			self.subscore2                          := subscore2;
			self.subscore3                          := subscore3;
			self.subscore4                          := subscore4;
			self.subscore5                          := subscore5;
			self.subscore6                          := subscore6;
			self.subscore7                          := subscore7;
			self.subscore8                          := subscore8;
			self.subscore9                          := subscore9;
			self.subscore10                         := subscore10;
			self.subscore11                         := subscore11;
			self.subscore12                         := subscore12;
			self.subscore13                         := subscore13;
			self.subscore14                         := subscore14;
			self.subscore15                         := subscore15;
			self.subscore16                         := subscore16;
			self.subscore17                         := subscore17;
			self.subscore18                         := subscore18;
			self.subscore19                         := subscore19;
			self.subscore20                         := subscore20;
			self.subscore21                         := subscore21;
			self.subscore22                         := subscore22;
			self.subscore23                         := subscore23;
			self.subscore24                         := subscore24;
			self.subscore25                         := subscore25;
			self.subscore26                         := subscore26;
			self.subscore27                         := subscore27;
			self.subscore28                         := subscore28;
			self.subscore29                         := subscore29;
			self.subscore30                         := subscore30;
			self.subscore31                         := subscore31;
			self.subscore32                         := subscore32;
			self.subscore33                         := subscore33;
			self.subscore_total                     := subscore_total;
			self.rsn1105_1_0                        := rsn1105_1_0;
		#else

		self.seq := (string)le.seq;
		self.recover_score := (string)rsn1105_1_0;
		#end
	end;

	scores := join(clam, easi.key_easi_census, 
					keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
					doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));
	return scores;


end;
import ut, riskwise, risk_indicators, riskwisefcra, std, riskview;

export RVG1201_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean PreScreenOptOut ) := FUNCTION

	money4 := Models.RVG1106_1_0( clam, isCalifornia, PreScreenOptOut );

	RVG_DEBUG := false;
	#if(RVG_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String in_dob;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_decsflag;
			Integer rc_ssnlowissue;
			String rc_bansflag;
			Integer combo_dobscore;
			qstring100 ver_sources;
			Boolean addrPop;
			String ssnlength;
			Boolean dobpop;
			Boolean hphnpop;
			Integer Age;
			Integer add1_avm_automated_valuation;
			Integer add1_naprop;
			Integer add1_date_first_seen;
			Integer property_owned_total;
			Integer property_sold_total;
			String add2_building_area;
			Integer add2_date_first_seen;
			Integer add3_date_first_seen;
			Integer addrs_10yr;
			Integer gong_did_phone_ct;
			Integer ssns_per_adl;
			Integer adls_per_addr;
			Integer phones_per_adl_c6;
			Integer inq_count12;
			Integer paw_active_phone_count;
			Integer infutor_first_seen;
			Integer impulse_count;
			qstring50 email_source_list;
			Integer attr_eviction_count;
			Boolean Bankrupt;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_sc_ct;
			Integer criminal_count;
			Integer watercraft_count;
			String ams_income_level_code;
			String ams_college_tier;
			Boolean prof_license_flag;
			String input_dob_match_level;
			Integer reported_dob;
			Integer estimated_income;
			Integer sysdate;
			Integer ver_src_ba_pos;
			Boolean ver_src_ba;
			Integer ver_src_ds_pos;
			Boolean ver_src_ds;
			Integer ver_src_l2_pos;
			Boolean ver_src_l2;
			Integer ver_src_li_pos;
			Boolean ver_src_li;
			Boolean bk_discharge_2;
			Boolean crime_flag_2;
			Integer in_dob2;
			Real yr_in_dob;
			Integer rc_ssnlowissue2;
			Real ssn_lowissue_age_2;
			Integer add1_date_first_seen2;
			Real mth_add1_date_first_seen;
			Integer add2_date_first_seen2;
			Real mth_add2_date_first_seen;
			Integer add3_date_first_seen2;
			Real mth_add3_date_first_seen;
			Real add_lres_mth_avg_2;
			Boolean watercraft_flag_2;
			Integer email_src_im_pos;
			Boolean email_src_im_2;
			Integer reported_dob2;
			Real yr_reported_dob;
			Integer combined_age_2;
			Integer infutor_first_seen2;
			Real mth_infutor_first_seen_2;
			String _ams_college_tier_2;
			String _ams_income_level_code_2;
			Integer attr_eviction_count_2;
			Integer liens_unrel_sc_ct_2;
			Integer inq_count12_2;
			Integer impulse_count_2;
			String add2_building_area_2;
			Integer addrs_10yr_2;
			Integer ssns_per_adl_2;
			Integer phones_per_adl_c6_2;
			String _ams_college_tier_1;
			Integer gong_did_phone_ct_2;
			Integer paw_active_phone_count_2;
			Boolean prof_license_flag_2;
			String _ams_income_level_code_1;
			Integer estimated_income_2;
			Integer bk_discharge_1;
			Integer crime_flag_1;
			Real add_lres_mth_avg_1;
			Integer watercraft_flag_1;
			Integer email_src_im_1;
			Real ssn_lowissue_age_1;
			Integer nas_summary_2;
			Integer add1_avm_automated_valuation_2;
			Integer adls_per_addr_2;
			Real mth_infutor_first_seen_1;
			Integer combined_age_1;
			Integer crime_flag;
			Integer liens_unrel_sc_ct_1;
			Integer impulse_count_1;
			String _ams_income_level_code;
			Integer watercraft_flag;
			Integer addrs_10yr_1;
			Integer gong_did_phone_ct_1;
			Real add_lres_mth_avg;
			Integer inq_count12_1;
			String _ams_college_tier;
			Integer add2_building_area_1;
			Integer phones_per_adl_c6_1;
			Integer email_src_im;
			Integer prof_license_flag_1;
			Integer bk_discharge;
			Integer paw_active_phone_count_1;
			Integer estimated_income_1;
			Integer ssns_per_adl_1;
			Integer attr_eviction_count_1;
			Integer ssn_lowissue_age;
			Integer nas_summary_1;
			Integer add1_avm_automated_valuation_1;
			Integer adls_per_addr_1;
			Real mth_infutor_first_seen;
			Integer combined_age;
			Real v4_subscore0;
			Real v4_subscore1;
			Real v4_subscore2;
			Real v4_subscore3;
			Real v4_subscore4;
			Real v4_subscore5;
			Real v4_subscore6;
			Real v4_subscore7;
			Real v4_subscore8;
			Real v4_subscore9;
			Real v4_subscore10;
			Real v4_subscore11;
			Real v4_subscore12;
			Real v4_subscore13;
			Real v4_subscore14;
			Real v4_subscore15;
			Real v4_subscore16;
			Real v4_subscore17;
			Real v4_subscore18;
			Real v4_subscore19;
			Real v4_subscore20;
			Real v4_subscore21;
			Real v4_subscore22;
			Real v4_subscore23;
			Real v4_subscore24;
			Real v4_rawscore;
			Real v4_lnoddsscore;
			Real v4_probscore;
			Boolean bk_flag;
			Boolean lien_rec_unrel_flag;
			Boolean lien_hist_unrel_flag;
			Boolean lien_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Integer Base;
			Integer point;
			Real odds;
			Integer v4_custom_score;
			Integer RVG1201_1_0;
			Models.Layout_ModelOut;
		end;
		layout_debug doModel( clam le, money4 ri ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le, money4 ri ) := TRANSFORM
	#end
		
		truedid                          := le.truedid;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		age                              := le.name_verification.age;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_building_area               := (string)le.address_verification.address_history_1.building_area;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		inq_count12                      := le.acc_logs.inquiries.count12;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		impulse_count                    := le.impulse.count;
		email_source_list                := le.email_summary.email_source_list;
		attr_eviction_count              := le.bjl.eviction_count;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		input_dob_match_level            := le.dobmatchlevel;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;








		NULL := -999999999;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		sysdate := models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

		ver_src_ba_pos := Models.common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := Models.common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_l2_pos := Models.common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_li_pos := Models.common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		bk_discharge_2 := contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARGE') > 0;

		crime_flag_2 := criminal_count > 0;

		in_dob2 := models.common.sas_date((string)(in_dob));

		yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, roundup((sysdate - in_dob2) / 365.25));

		rc_ssnlowissue2 := models.common.sas_date((string)(rc_ssnlowissue));

		ssn_lowissue_age_2 := if(in_dob2 != NULL and rc_ssnlowissue2 != NULL, (rc_ssnlowissue2 - in_dob2) / 365.2, NULL);

		add1_date_first_seen2 := models.common.sas_date((string)(add1_date_first_seen));

		mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, roundup((sysdate - add1_date_first_seen2) / 30.5));

		add2_date_first_seen2 := models.common.sas_date((string)(add2_date_first_seen));

		mth_add2_date_first_seen := if(min(sysdate, add2_date_first_seen2) = NULL, NULL, roundup((sysdate - add2_date_first_seen2) / 30.5));

		add3_date_first_seen2 := models.common.sas_date((string)(add3_date_first_seen));

		mth_add3_date_first_seen := if(min(sysdate, add3_date_first_seen2) = NULL, NULL, roundup((sysdate - add3_date_first_seen2) / 30.5));

		add_lres_mth_avg_2 := if(max(mth_add1_date_first_seen, mth_add2_date_first_seen, mth_add3_date_first_seen) = NULL, NULL, (if(max(mth_add1_date_first_seen, mth_add2_date_first_seen, mth_add3_date_first_seen) = NULL, NULL, SUM(if(mth_add1_date_first_seen = NULL, 0, mth_add1_date_first_seen), if(mth_add2_date_first_seen = NULL, 0, mth_add2_date_first_seen), if(mth_add3_date_first_seen = NULL, 0, mth_add3_date_first_seen)))/sum(if(mth_add1_date_first_seen = NULL, 0, 1), if(mth_add2_date_first_seen = NULL, 0, 1), if(mth_add3_date_first_seen = NULL, 0, 1))));

		watercraft_flag_2 := watercraft_count > 0;

		email_src_im_pos := Models.common.findw_cpp(email_source_list, 'IM' , '  ,', 'ie');

		email_src_im_2 := email_src_im_pos > 0;

		reported_dob2 := models.common.sas_date((string)(reported_dob));

		yr_reported_dob := if(min(sysdate, reported_dob2) = NULL, NULL, roundup((sysdate - reported_dob2) / 365.25));

		combined_age_2 := map(
				yr_in_dob != NULL       => round(yr_in_dob),
				yr_reported_dob != NULL => round(yr_reported_dob),
																	 round(age));

		infutor_first_seen2 := models.common.sas_date((string)(infutor_first_seen));

		mth_infutor_first_seen_2 := if(min(sysdate, infutor_first_seen2) = NULL, NULL, roundup((sysdate - infutor_first_seen2) / 30.5));

		_ams_college_tier_2 := ams_college_tier;

		_ams_income_level_code_2 := ams_income_level_code;

		attr_eviction_count_2 := if(attr_eviction_count = NULL, -999, attr_eviction_count);

		liens_unrel_sc_ct_2 := if(liens_unrel_sc_ct = NULL, -999, liens_unrel_sc_ct);

		inq_count12_2 := if(inq_count12 = NULL, -999, inq_count12);

		impulse_count_2 := if(impulse_count = NULL, -999, impulse_count);

		add2_building_area_2 := if(trim(add2_building_area) = '', '-999', add2_building_area);

		addrs_10yr_2 := if(addrs_10yr = NULL, -999, addrs_10yr);

		ssns_per_adl_2 := if(ssns_per_adl = NULL, -999, ssns_per_adl);

		phones_per_adl_c6_2 := if(phones_per_adl_c6 = NULL, -999, phones_per_adl_c6);

		_ams_college_tier_1 := if(trim(_ams_college_tier_2) = '', '-999', _ams_college_tier_2);

		gong_did_phone_ct_2 := if(gong_did_phone_ct = NULL, -999, gong_did_phone_ct);

		paw_active_phone_count_2 := if(paw_active_phone_count = NULL, -999, paw_active_phone_count);

		prof_license_flag_2 := prof_license_flag;

		_ams_income_level_code_1 := if(trim(_ams_income_level_code_2) = '', '-999', _ams_income_level_code_2);

		estimated_income_2 := if(estimated_income = NULL, -999, estimated_income);

		bk_discharge_1 := (integer)bk_discharge_2;

		crime_flag_1 := (integer)crime_flag_2;

		add_lres_mth_avg_1 := if(add_lres_mth_avg_2 = NULL, -999, add_lres_mth_avg_2);

		watercraft_flag_1 := (integer)watercraft_flag_2;

		email_src_im_1 := (integer)email_src_im_2;

		ssn_lowissue_age_1 := if(ssn_lowissue_age_2 = NULL, -999, ssn_lowissue_age_2);

		nas_summary_2 := if(nas_summary = NULL, -999, nas_summary);

		add1_avm_automated_valuation_2 := if(add1_avm_automated_valuation = NULL, -999, add1_avm_automated_valuation);

		adls_per_addr_2 := if(adls_per_addr = NULL, -999, adls_per_addr);

		mth_infutor_first_seen_1 := if(mth_infutor_first_seen_2 = NULL, -999, mth_infutor_first_seen_2);

		combined_age_1 := if(combined_age_2 = NULL, -999, combined_age_2);

		crime_flag := if(not(truedid), NULL, crime_flag_1);

		liens_unrel_sc_ct_1 := if(not(truedid), NULL, liens_unrel_sc_ct_2);

		impulse_count_1 := if(not(truedid), NULL, impulse_count_2);

		_ams_income_level_code := if(not(truedid), '', _ams_income_level_code_1);

		watercraft_flag := if(not(truedid), NULL, watercraft_flag_1);

		addrs_10yr_1 := if(not(truedid), NULL, addrs_10yr_2);

		gong_did_phone_ct_1 := if(not(truedid), NULL, gong_did_phone_ct_2);

		add_lres_mth_avg := if(not(truedid), NULL, add_lres_mth_avg_1);

		inq_count12_1 := if(not(truedid), NULL, inq_count12_2);

		_ams_college_tier := if(not(truedid), '', trim(_ams_college_tier_1));

		add2_building_area_1 := if(not(truedid), NULL, (integer)add2_building_area_2);

		phones_per_adl_c6_1 := if(not(truedid), NULL, (integer)phones_per_adl_c6_2);

		email_src_im := if(not(truedid), NULL, (integer)email_src_im_1);

		prof_license_flag_1 := if(not(truedid), NULL, (integer)prof_license_flag_2);

		bk_discharge := if(not(truedid), NULL, (integer)bk_discharge_1);

		paw_active_phone_count_1 := if(not(truedid), NULL, paw_active_phone_count_2);

		estimated_income_1 := if(not(truedid), NULL, estimated_income_2);

		ssns_per_adl_1 := if(not(truedid), NULL, ssns_per_adl_2);

		attr_eviction_count_1 := if(not(truedid), NULL, attr_eviction_count_2);

		ssn_lowissue_age := if(not(ssnlength = '9' and dobpop), NULL, ssn_lowissue_age_1);

		nas_summary_1 := if(not(truedid or ssnlength = '9'), NULL, (integer)nas_summary_2);

		add1_avm_automated_valuation_1 := if(not(addrpop), NULL, add1_avm_automated_valuation_2);

		adls_per_addr_1 := if(not(addrpop), NULL, adls_per_addr_2);

		mth_infutor_first_seen := if(not(hphnpop), NULL, mth_infutor_first_seen_1);

		combined_age := if(not(truedid and dobpop), NULL, combined_age_1);

		v4_subscore0 := map(
				NULL < attr_eviction_count_1 AND attr_eviction_count_1 < 1 => 0.061079,
				1 <= attr_eviction_count_1 AND attr_eviction_count_1 < 2   => -0.374077,
				2 <= attr_eviction_count_1                                 => -0.500537,
																																			0.000000);

		v4_subscore1 := map(
				NULL < liens_unrel_sc_ct_1 AND liens_unrel_sc_ct_1 < 1 => 0.021643,
				1 <= liens_unrel_sc_ct_1 AND liens_unrel_sc_ct_1 < 2   => -0.015554,
				2 <= liens_unrel_sc_ct_1                               => -0.234567,
																																	0.000000);

		v4_subscore2 := map(
				NULL < inq_count12_1 AND inq_count12_1 < 1 => 0.093560,
				1 <= inq_count12_1 AND inq_count12_1 < 2   => -0.024779,
				2 <= inq_count12_1 AND inq_count12_1 < 3   => -0.088879,
				3 <= inq_count12_1                         => -0.163152,
																											0.000000);

		v4_subscore3 := map(
				NULL < impulse_count_1 AND impulse_count_1 < 1 => 0.035224,
				1 <= impulse_count_1 AND impulse_count_1 < 2   => 0.009570,
				2 <= impulse_count_1 AND impulse_count_1 < 3   => -0.112555,
				3 <= impulse_count_1 AND impulse_count_1 < 4   => -0.443202,
				4 <= impulse_count_1                           => -0.529233,
																													0.000000);

		v4_subscore4 := map(
				NULL < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 <= 0       => 0.000000,
				0 < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 98075       => -0.119784,
				98075 <= add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 116328 => 0.015739,
				116328 <= add1_avm_automated_valuation_1                                            => 0.133130,
																																															 0.000000);

		v4_subscore5 := map(
				NULL < add2_building_area_1 AND add2_building_area_1 < 1     => 0.000000,
				1 <= add2_building_area_1 AND add2_building_area_1 < 1149    => -0.137655,
				1149 <= add2_building_area_1 AND add2_building_area_1 < 2636 => 0.045887,
				2636 <= add2_building_area_1                                 => 0.120052,
																																				0.000000);

		v4_subscore6 := map(
				NULL < addrs_10yr_1 AND addrs_10yr_1 < 3 => 0.143899,
				3 <= addrs_10yr_1 AND addrs_10yr_1 < 4   => 0.044754,
				4 <= addrs_10yr_1 AND addrs_10yr_1 < 6   => -0.042744,
				6 <= addrs_10yr_1 AND addrs_10yr_1 < 9   => -0.051483,
				9 <= addrs_10yr_1                        => -0.085629,
																										0.000000);

		v4_subscore7 := map(
				NULL < ssns_per_adl_1 AND ssns_per_adl_1 < 2 => 0.076205,
				2 <= ssns_per_adl_1 AND ssns_per_adl_1 < 3   => -0.075163,
				3 <= ssns_per_adl_1 AND ssns_per_adl_1 < 4   => -0.216067,
				4 <= ssns_per_adl_1 AND ssns_per_adl_1 < 5   => -0.225621,
				5 <= ssns_per_adl_1                          => -0.447399,
																												0.000000);

		v4_subscore8 := map(
				NULL < adls_per_addr_1 AND adls_per_addr_1 < 7 => 0.162339,
				7 <= adls_per_addr_1 AND adls_per_addr_1 < 13  => -0.001107,
				13 <= adls_per_addr_1 AND adls_per_addr_1 < 16 => -0.090604,
				16 <= adls_per_addr_1                          => -0.169698,
																													0.000000);

		v4_subscore9 := map(
				NULL < phones_per_adl_c6_1 AND phones_per_adl_c6_1 < 1 => 0.013628,
				1 <= phones_per_adl_c6_1                               => -0.176807,
																																	-0.000000);

		v4_subscore10 := map(
				(_ams_college_tier in [''])                => 0.000000,
				(_ams_college_tier in ['-999'])             => -0.005847,
				(_ams_college_tier in ['0', '1', '2', '3']) => 0.306730,
				(_ams_college_tier in ['4'])                => 0.086704,
				(_ams_college_tier in ['5', '6'])           => -0.096042,
																											 0.000000);

		v4_subscore11 := map(
				(nas_summary_1 in [0, 1, 2, 3, 5, 6, 8, 10, 11, 12]) => 0.044474,
				(nas_summary_1 in [4, 7, 9])                         => -0.343963,
																																0.000000);

		v4_subscore12 := map(
				NULL < gong_did_phone_ct_1 AND gong_did_phone_ct_1 < 3 => 0.020050,
				3 <= gong_did_phone_ct_1 AND gong_did_phone_ct_1 < 4   => -0.115681,
				4 <= gong_did_phone_ct_1                               => -0.191420,
																																	-0.000000);

		v4_subscore13 := map(
				NULL < paw_active_phone_count_1 AND paw_active_phone_count_1 < 1 => -0.009199,
				1 <= paw_active_phone_count_1                                    => 0.293216,
																																						-0.000000);

		v4_subscore14 := map(
				(prof_license_flag_1 in [0]) => -0.022292,
				(prof_license_flag_1 in [1]) => 0.255059,
																				0.000000);

		v4_subscore15 := map(
				(_ams_income_level_code in ['Other'])       => 0.000000,
				(_ams_income_level_code in ['-999'])        => 0.000000,
				(_ams_income_level_code in ['A', 'B', 'C']) => -0.206261,
				(_ams_income_level_code in ['D', 'E'])      => 0.035868,
				(_ams_income_level_code in ['F', 'G', 'H']) => 0.082840,
				(_ams_income_level_code in ['I', 'J', 'K']) => 0.097910,
																											 0.000000);

		v4_subscore16 := map(
				NULL < estimated_income_1 AND estimated_income_1 < 19999   => 0.000000,
				19999 <= estimated_income_1 AND estimated_income_1 < 21000 => -0.395497,
				21000 <= estimated_income_1 AND estimated_income_1 < 28000 => -0.108182,
				28000 <= estimated_income_1 AND estimated_income_1 < 32000 => -0.003383,
				32000 <= estimated_income_1 AND estimated_income_1 < 35000 => 0.059785,
				35000 <= estimated_income_1 AND estimated_income_1 < 40000 => 0.116456,
				40000 <= estimated_income_1                                => 0.253034,
																																			0.000000);

		v4_subscore17 := map(
				(bk_discharge in [0]) => -0.041110,
				(bk_discharge in [1]) => 0.170644,
																 0.000000);

		v4_subscore18 := map(
				(crime_flag in [0]) => 0.024547,
				(crime_flag in [1]) => -0.406355,
															 0.000000);

		v4_subscore19 := map(
				NULL < ssn_lowissue_age AND ssn_lowissue_age < -0.01  => -0.323813,
				-0.01 <= ssn_lowissue_age AND ssn_lowissue_age < 1.23 => -0.157589,
				1.23 <= ssn_lowissue_age AND ssn_lowissue_age < 14.09 => 0.046415,
				14.09 <= ssn_lowissue_age                             => 0.085997,
																																 0.000000);

		v4_subscore20 := map(
				NULL < add_lres_mth_avg AND add_lres_mth_avg < 21.66   => -0.168008,
				21.66 <= add_lres_mth_avg AND add_lres_mth_avg < 31.66 => -0.088334,
				31.66 <= add_lres_mth_avg AND add_lres_mth_avg < 45    => -0.061982,
				45 <= add_lres_mth_avg AND add_lres_mth_avg < 89.66    => 0.009061,
				89.66 <= add_lres_mth_avg AND add_lres_mth_avg < 143   => 0.023054,
				143 <= add_lres_mth_avg AND add_lres_mth_avg < 198.5   => 0.105158,
				198.5 <= add_lres_mth_avg                              => 0.143557,
																																	0.000000);

		v4_subscore21 := map(
				(watercraft_flag in [0]) => -0.000247,
				(watercraft_flag in [1]) => 0.015051,
																		0.000000);

		v4_subscore22 := map(
				(email_src_im in [0]) => 0.148253,
				(email_src_im in [1]) => -0.270135,
																 0.000000);

		v4_subscore23 := map(
				NULL < mth_infutor_first_seen AND mth_infutor_first_seen < 1 => -0.034567,
				1 <= mth_infutor_first_seen AND mth_infutor_first_seen < 17  => -0.347101,
				17 <= mth_infutor_first_seen                                 => 0.073975,
																																				-0.000000);

		v4_subscore24 := map(
				NULL < combined_age AND combined_age < 33 => -0.080120,
				33 <= combined_age AND combined_age < 36  => -0.078158,
				36 <= combined_age AND combined_age < 38  => -0.038140,
				38 <= combined_age AND combined_age < 43  => -0.026134,
				43 <= combined_age AND combined_age < 50  => 0.049814,
				50 <= combined_age                        => 0.107121,
																										 -0.000000);

		v4_rawscore := v4_subscore0 +
				v4_subscore1 +
				v4_subscore2 +
				v4_subscore3 +
				v4_subscore4 +
				v4_subscore5 +
				v4_subscore6 +
				v4_subscore7 +
				v4_subscore8 +
				v4_subscore9 +
				v4_subscore10 +
				v4_subscore11 +
				v4_subscore12 +
				v4_subscore13 +
				v4_subscore14 +
				v4_subscore15 +
				v4_subscore16 +
				v4_subscore17 +
				v4_subscore18 +
				v4_subscore19 +
				v4_subscore20 +
				v4_subscore21 +
				v4_subscore22 +
				v4_subscore23 +
				v4_subscore24;

		v4_lnoddsscore := v4_rawscore + -0.554838;

		v4_probscore := exp(v4_lnoddsscore) / (1 + exp(v4_lnoddsscore));

		bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		lien_flag := ver_src_l2 or ver_src_li or lien_rec_unrel_flag or lien_hist_unrel_flag;

		ssn_deceased := rc_decsflag = '1' or ver_src_ds;

		scored_222s := ( property_owned_total > 0 or property_sold_total > 0 ) or 90 <= combo_dobscore AND combo_dobscore <= 100 or (integer1)input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid;

		base := 700;
		point := 40;
		odds := 0.580030;

		v4_custom_score := map(
				ssn_deceased                                                                      => 200,
				riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																																														 round(point * (ln(v4_probscore / (1 - v4_probscore)) - ln(odds)) / ln(2) + base));

		rvg1201_1_0 := if(v4_custom_score > 222, max(501, min(900, if(v4_custom_score = NULL, -NULL, v4_custom_score))), v4_custom_score);


		#if(RVG_DEBUG)
			self.clam := le;
			self.truedid                         := truedid;
			self.in_dob                          := in_dob;
			self.nas_summary                     := nas_summary;
			self.nap_summary                     := nap_summary;
			self.rc_decsflag                     := rc_decsflag;
			self.rc_ssnlowissue                  := rc_ssnlowissue;
			self.rc_bansflag                     := rc_bansflag;
			self.combo_dobscore                  := combo_dobscore;
			self.ver_sources                     := ver_sources;
			self.addrpop                         := addrpop;
			self.ssnlength                       := ssnlength;
			self.dobpop                          := dobpop;
			self.hphnpop                         := hphnpop;
			self.age                             := age;
			self.add1_avm_automated_valuation    := add1_avm_automated_valuation;
			self.add1_naprop                     := add1_naprop;
			self.add1_date_first_seen            := add1_date_first_seen;
			self.property_owned_total            := property_owned_total;
			self.property_sold_total             := property_sold_total;
			self.add2_building_area              := add2_building_area;
			self.add2_date_first_seen            := add2_date_first_seen;
			self.add3_date_first_seen            := add3_date_first_seen;
			self.addrs_10yr                      := addrs_10yr;
			self.gong_did_phone_ct               := gong_did_phone_ct;
			self.ssns_per_adl                    := ssns_per_adl;
			self.adls_per_addr                   := adls_per_addr;
			self.phones_per_adl_c6               := phones_per_adl_c6;
			self.inq_count12                     := inq_count12;
			self.paw_active_phone_count          := paw_active_phone_count;
			self.infutor_first_seen              := infutor_first_seen;
			self.impulse_count                   := impulse_count;
			self.email_source_list               := email_source_list;
			self.attr_eviction_count             := attr_eviction_count;
			self.bankrupt                        := bankrupt;
			self.disposition                     := disposition;
			self.filing_count                    := filing_count;
			self.bk_recent_count                 := bk_recent_count;
			self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
			self.liens_unrel_sc_ct               := liens_unrel_sc_ct;
			self.criminal_count                  := criminal_count;
			self.watercraft_count                := watercraft_count;
			self.ams_income_level_code           := ams_income_level_code;
			self.ams_college_tier                := ams_college_tier;
			self.prof_license_flag               := prof_license_flag;
			self.input_dob_match_level           := input_dob_match_level;
			self.reported_dob                    := reported_dob;
			self.estimated_income                := estimated_income;
			self.sysdate                         := sysdate;
			self.ver_src_ba_pos                  := ver_src_ba_pos;
			self.ver_src_ba                      := ver_src_ba;
			self.ver_src_ds_pos                  := ver_src_ds_pos;
			self.ver_src_ds                      := ver_src_ds;
			self.ver_src_l2_pos                  := ver_src_l2_pos;
			self.ver_src_l2                      := ver_src_l2;
			self.ver_src_li_pos                  := ver_src_li_pos;
			self.ver_src_li                      := ver_src_li;
			self.bk_discharge_2                  := bk_discharge_2;
			self.crime_flag_2                    := crime_flag_2;
			self.in_dob2                         := in_dob2;
			self.yr_in_dob                       := yr_in_dob;
			self.rc_ssnlowissue2                 := rc_ssnlowissue2;
			self.ssn_lowissue_age_2              := ssn_lowissue_age_2;
			self.add1_date_first_seen2           := add1_date_first_seen2;
			self.mth_add1_date_first_seen        := mth_add1_date_first_seen;
			self.add2_date_first_seen2           := add2_date_first_seen2;
			self.mth_add2_date_first_seen        := mth_add2_date_first_seen;
			self.add3_date_first_seen2           := add3_date_first_seen2;
			self.mth_add3_date_first_seen        := mth_add3_date_first_seen;
			self.add_lres_mth_avg_2              := add_lres_mth_avg_2;
			self.watercraft_flag_2               := watercraft_flag_2;
			self.email_src_im_pos                := email_src_im_pos;
			self.email_src_im_2                  := email_src_im_2;
			self.reported_dob2                   := reported_dob2;
			self.yr_reported_dob                 := yr_reported_dob;
			self.combined_age_2                  := combined_age_2;
			self.infutor_first_seen2             := infutor_first_seen2;
			self.mth_infutor_first_seen_2        := mth_infutor_first_seen_2;
			self._ams_college_tier_2             := _ams_college_tier_2;
			self._ams_income_level_code_2        := _ams_income_level_code_2;
			self.attr_eviction_count_2           := attr_eviction_count_2;
			self.liens_unrel_sc_ct_2             := liens_unrel_sc_ct_2;
			self.inq_count12_2                   := inq_count12_2;
			self.impulse_count_2                 := impulse_count_2;
			self.add2_building_area_2            := add2_building_area_2;
			self.addrs_10yr_2                    := addrs_10yr_2;
			self.ssns_per_adl_2                  := ssns_per_adl_2;
			self.phones_per_adl_c6_2             := phones_per_adl_c6_2;
			self._ams_college_tier_1             := _ams_college_tier_1;
			self.gong_did_phone_ct_2             := gong_did_phone_ct_2;
			self.paw_active_phone_count_2        := paw_active_phone_count_2;
			self.prof_license_flag_2             := prof_license_flag_2;
			self._ams_income_level_code_1        := _ams_income_level_code_1;
			self.estimated_income_2              := estimated_income_2;
			self.bk_discharge_1                  := bk_discharge_1;
			self.crime_flag_1                    := crime_flag_1;
			self.add_lres_mth_avg_1              := add_lres_mth_avg_1;
			self.watercraft_flag_1               := watercraft_flag_1;
			self.email_src_im_1                  := email_src_im_1;
			self.ssn_lowissue_age_1              := ssn_lowissue_age_1;
			self.nas_summary_2                   := nas_summary_2;
			self.add1_avm_automated_valuation_2  := add1_avm_automated_valuation_2;
			self.adls_per_addr_2                 := adls_per_addr_2;
			self.mth_infutor_first_seen_1        := mth_infutor_first_seen_1;
			self.combined_age_1                  := combined_age_1;
			self.crime_flag                      := crime_flag;
			self.liens_unrel_sc_ct_1             := liens_unrel_sc_ct_1;
			self.impulse_count_1                 := impulse_count_1;
			self._ams_income_level_code          := _ams_income_level_code;
			self.watercraft_flag                 := watercraft_flag;
			self.addrs_10yr_1                    := addrs_10yr_1;
			self.gong_did_phone_ct_1             := gong_did_phone_ct_1;
			self.add_lres_mth_avg                := add_lres_mth_avg;
			self.inq_count12_1                   := inq_count12_1;
			self._ams_college_tier               := _ams_college_tier;
			self.add2_building_area_1            := add2_building_area_1;
			self.phones_per_adl_c6_1             := phones_per_adl_c6_1;
			self.email_src_im                    := email_src_im;
			self.prof_license_flag_1             := prof_license_flag_1;
			self.bk_discharge                    := bk_discharge;
			self.paw_active_phone_count_1        := paw_active_phone_count_1;
			self.estimated_income_1              := estimated_income_1;
			self.ssns_per_adl_1                  := ssns_per_adl_1;
			self.attr_eviction_count_1           := attr_eviction_count_1;
			self.ssn_lowissue_age                := ssn_lowissue_age;
			self.nas_summary_1                   := nas_summary_1;
			self.add1_avm_automated_valuation_1  := add1_avm_automated_valuation_1;
			self.adls_per_addr_1                 := adls_per_addr_1;
			self.mth_infutor_first_seen          := mth_infutor_first_seen;
			self.combined_age                    := combined_age;
			self.v4_subscore0                    := v4_subscore0;
			self.v4_subscore1                    := v4_subscore1;
			self.v4_subscore2                    := v4_subscore2;
			self.v4_subscore3                    := v4_subscore3;
			self.v4_subscore4                    := v4_subscore4;
			self.v4_subscore5                    := v4_subscore5;
			self.v4_subscore6                    := v4_subscore6;
			self.v4_subscore7                    := v4_subscore7;
			self.v4_subscore8                    := v4_subscore8;
			self.v4_subscore9                    := v4_subscore9;
			self.v4_subscore10                   := v4_subscore10;
			self.v4_subscore11                   := v4_subscore11;
			self.v4_subscore12                   := v4_subscore12;
			self.v4_subscore13                   := v4_subscore13;
			self.v4_subscore14                   := v4_subscore14;
			self.v4_subscore15                   := v4_subscore15;
			self.v4_subscore16                   := v4_subscore16;
			self.v4_subscore17                   := v4_subscore17;
			self.v4_subscore18                   := v4_subscore18;
			self.v4_subscore19                   := v4_subscore19;
			self.v4_subscore20                   := v4_subscore20;
			self.v4_subscore21                   := v4_subscore21;
			self.v4_subscore22                   := v4_subscore22;
			self.v4_subscore23                   := v4_subscore23;
			self.v4_subscore24                   := v4_subscore24;
			self.v4_rawscore                     := v4_rawscore;
			self.v4_lnoddsscore                  := v4_lnoddsscore;
			self.v4_probscore                    := v4_probscore;
			self.bk_flag                         := bk_flag;
			self.lien_rec_unrel_flag             := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag            := lien_hist_unrel_flag;
			self.lien_flag                       := lien_flag;
			self.ssn_deceased                    := ssn_deceased;
			self.scored_222s                     := scored_222s;
			self.base                            := base;
			self.point                           := point;
			self.odds                            := odds;
			self.v4_custom_score                 := v4_custom_score;
			self.rvg1201_1_0                     := rvg1201_1_0;
		#end
		
		self.seq := le.seq;
		self.score := if( ri.score in ['101','102','103','104' /*fcra*/, '200' /*deceased*/, '222' /*prescreen*/, '100' /*incalif*/ ], ri.score, (string3)rvg1201_1_0 );
		self.ri := ri.ri;

	END;
	
	model := join( clam, money4, left.seq=right.seq, doModel(left,right), keep(1) );
	return model;
END;
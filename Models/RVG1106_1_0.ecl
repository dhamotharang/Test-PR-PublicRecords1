import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVG1106_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean PreScreenOptOut ) := FUNCTION

	RVG_DEBUG := false;

	#if(RVG_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String out_unit_desig;
			String out_sec_range;
			String out_addr_type;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_decsflag;
			String rc_dwelltype;
			String rc_bansflag;
			Integer combo_dobscore;
			qstring100 ver_sources;
			Boolean dobpop;
			String add1_avm_sales_price;
			String add1_avm_assessed_total_value;
			String add1_avm_market_total_value;
			Integer add1_avm_tax_assessed_valuation;
			Integer add1_avm_price_index_valuation;
			Integer add1_avm_hedonic_valuation;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Boolean add1_applicant_owned;
			Boolean add1_occupant_owned;
			Boolean add1_family_owned;
			Integer add1_naprop;
			Integer add1_date_last_seen;
			Integer property_owned_total;
			Integer property_sold_total;
			String add2_addr_type;
			String add2_avm_assessed_total_value;
			Integer add2_avm_automated_valuation;
			Integer add2_avm_med_fips;
			Integer add2_avm_med_geo11;
			Integer add2_avm_med_geo12;
			Boolean add2_applicant_owned;
			Boolean add2_occupant_owned;
			Boolean add2_family_owned;
			Integer addrs_5yr;
			Integer addrs_10yr;
			Integer addrs_15yr;
			Integer addr_lres_2mo_count;
			Integer addr_lres_6mo_count;
			String gong_did_last_seen;
			Integer gong_did_first_ct;
			Integer gong_did_last_ct;
			Integer header_first_seen;
			Integer ssns_per_adl;
			Integer phones_per_adl;
			Integer adlPerSSN_count;
			Integer adls_per_addr;
			Integer ssns_per_addr;
			Integer ssns_per_adl_c6;
			Integer phones_per_adl_c6;
			Integer adls_per_addr_c6;
			Integer ssns_per_addr_c6;
			Integer inq_collection_count12;
			Integer inq_auto_count12;
			Integer inq_banking_count12;
			Integer inq_highriskcredit_count12;
			Integer inq_communications_count12;
			Integer impulse_count;
			Integer email_count;
			Integer email_domain_free_count;
			qstring50 email_source_list;
			qstring50 email_source_count;
			qstring100 email_source_first_seen;
			Integer attr_addrs_last12;
			Integer attr_addrs_last24;
			Integer attr_addrs_last36;
			Integer attr_num_aircraft;
			Integer attr_total_number_derogs;
			Integer attr_num_nonderogs;
			Integer attr_num_nonderogs30;
			Integer attr_num_nonderogs90;
			Boolean Bankrupt;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_sc_ct;
			Integer liens_unrel_sc_last_seen;
			Integer liens_rel_sc_last_seen;
			Integer criminal_count;
			Integer watercraft_count;
			String ams_age;
			String ams_college_tier;
			Boolean prof_license_flag;
			String prof_license_type;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			Integer reported_dob;
			String archive_date;




			Integer sysdate;
			Boolean Impulse_Email;
			Boolean impulse_seg;
			Integer total_recs;
			Integer derog_ratio;
			Integer i1_derog_ratio_lvl;
			Real i1_derog_ratio_lvl_m1;
			Integer imp_pos;
			Real impulse_source_count;
			String impulse_source_fst_seen;
			Integer _impulse_source_fst_seen;
			Integer mos_impulse_source_fst_seen;
			Integer i1_impulse_lvl;
			Real i1_impulse_lvl_m1;
			Integer i1_phones_per_adl_lvl;
			Real i1_phones_per_adl_lvl_m1;
			Boolean acquire_web;
			Boolean outward_media;
			Integer pct_free_accounts;
			Integer ln_free_email_accts_lvl;
			Real ln_free_email_accts_lvl_m1;
			Boolean nas_479;
			Boolean dob_verd;
			Integer ln_nas_ver_lvl;
			Real ln_nas_ver_lvl_m1;
			Boolean inq_coll;
			Boolean inq_auto;
			Boolean inq_banking;
			Boolean inq_highrisk;
			Boolean inq_comm;
			Integer inquiry_sum;
			Integer ln_inquiry_lvl;
			Real ln_inquiry_lvl_m1;
			Integer ln_ssns_per_adl_lvl;
			Real ln_ssns_per_adl_lvl_m1;
			Boolean add_apt;
			Integer ids_per_addr_max;
			Integer ln_ids_per_addr_lvl;
			Real ln_ids_per_addr_lvl_m1;
			Boolean pl_nurse;
			Integer ln_pl_lvl;
			Real ln_pl_lvl_m1;
			Integer ln_college_lvl;
			Real ln_college_lvl_m1;
			Integer addrs_15;
			Integer addrs_10;
			Integer addrs_5;
			Integer addrs_3;
			Integer addrs_2;
			Integer vel4;
			Integer vel3;
			Integer vel2;
			Integer vel1;
			Integer vel0;
			Real addr_vel_rate;
			Integer ln_addr_vel_rate_lvl;
			Integer _reported_dob;
			Integer reported_age;
			Integer applicant_age;
			Integer ln_age_x_addr_vel_combo_lvl;
			Real ln_age_x_addr_vel_combo_lvl_m1;
			Boolean aptflag1;
			Boolean aptflag2;
			String econcode1;
			Integer econval2;
			String econcode2;
			Integer i1_poor_eco_traj_f;
			Boolean i1_brief_residency_f;
			Integer _header_first_seen;
			Integer mos_header_first_seen;
			Integer ln_mos_header_first_seen_c;
			Real ln_mos_header_first_seen_sq;
			Integer age_header_first_seen;
			Integer ln_age_header_first_seen_c;
			Real ln_age_header_first_seen_lg;
			Boolean ln_criminal_f;
			Integer i0_email_sum_lvl;
			Real i0_email_sum_lvl_m0;
			Integer max_avm;
			Integer ln_avm_value_lvl;
			Real ln_avm_value_lvl_m0;
			Integer ln_econ_trajectory_lvl;
			Real ln_econ_trajectory_lvl_m0;
			Integer _add1_date_last_seen;
			Integer mos_add1_date_last_seen;
			Boolean seen_recently;
			Boolean property_owner;
			Integer ln_naprop_lvl;
			Real ln_naprop_lvl_m0;
			Integer ln_derog_ratio_lvl;
			Real ln_derog_ratio_lvl_m0;
			Integer _liens_unrel_sc_last_seen;
			Integer _liens_rel_sc_last_seen;
			Integer mos_sc_unrel_last_seen;
			Integer mos_sc_rel_last_seen;
			Integer ln_sc_liens_lvl;
			Real ln_sc_liens_lvl_m0;
			Integer ln_file_integrity_lvl;
			Real ln_file_integrity_lvl_m0;
			Integer max_ids_per_addr_c6;
			Integer ln_ids_per_addr_c6_2;
			Real ln_ids_per_addr_c6_2_m0;
			Real ln_pl_lvl_m0;
			Integer _gong_did_last_seen;
			Integer mos_since_gong_last_seen;
			Boolean phn_last_seen_rec;
			Boolean phn_bad_counts;
			Integer ln_phn_prob_lvl;
			Real ln_phn_prob_lvl_m0;
			String curr_addr_lvl;
			String prev_addr_lvl;
			Integer ln_curr_prev_addr_lvl;
			Real ln_curr_prev_addr_lvl_m0;
			Boolean ln_num_nonderogs_90_30_f;
			Real imp1_log;
			Real imp0_log;
			Real phat;
			Integer base;
			Integer point;
			Real odds;
			Integer c40_mod;
			Integer custom_40_compucredit_score;
			Boolean source_tot_DS;
			Boolean source_tot_BA;
			Boolean bk_flag;
			Boolean lien_rec_unrel_flag;
			Boolean lien_hist_unrel_flag;
			Boolean source_tot_L2;
			Boolean source_tot_LI;
			Boolean lien_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Integer _222;
			Integer RVG1106_1_0;

			// reasons:
			Boolean rc_non_us_ssn;
			Integer inq_count12;
			Integer recent_disconnects;
			Boolean _phn_recent_disconnect;
			String rc_ssndobflag;
			String rc_pwssndobflag;
			String rc_addrcommflag;
			String add1_advo_res_or_business;
			Boolean _add_highriskcom;
			Boolean add1_eda_sourced;
			String rc_ssnvalflag;
			String rc_pwssnvalflag;
			String nap_status;
			String rc_hriskphoneflag;
			String rc_hphonetypeflag;
			String rc_hphonevalflag;
			String rc_phonezipflag;
			String telcordia_type;
			Boolean _phn_notpots;
			Boolean addrs_prison_history;
			String rc_addrvalflag;
			Boolean _add_invalid;
			String rc_cityzipflag;
			Boolean _add_zipcitymismatch;
			String add1_advo_address_vacancy;
			Boolean _add_advo_vacant;
			String add1_advo_throw_back;
			Boolean _add_advo_throwback;
			Boolean glrc9v;
			Boolean glrc9w;
			Boolean glrc9q;
			Boolean glrc9t;
			Boolean glrc9u;
			Boolean glrc9o;
			String rc1;
			String rc2;
			String rc3;
			String rc4;
			String rc5;


			Models.Layout_ModelOut;
		end;
		layout_debug doModel(clam le) := TRANSFORM
	#else
		models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end




		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_decsflag                      := le.iid.decsflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		dobpop                           := le.input_validation.dateofbirth;
		add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
		add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
		add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_addr_type                   := le.address_verification.addr_type2;
		add2_avm_assessed_total_value    := le.avm.address_history_1.avm_assessed_total_value;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		addr_lres_2mo_count              := le.address_history_summary.lres_2mo_count;
		addr_lres_6mo_count              := le.address_history_summary.lres_6mo_count;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		inq_collection_count12           := le.acc_logs.collection.count12;
		inq_auto_count12                 := le.acc_logs.auto.count12;
		inq_banking_count12              := le.acc_logs.banking.count12;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_communications_count12       := le.acc_logs.communications.count12;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		email_source_count               := le.email_summary.email_source_ct;
		email_source_first_seen          := le.email_summary.email_source_first_seen;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs30             := le.source_verification.num_nonderogs30;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
		liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
		criminal_count                   := le.bjl.criminal_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_type                := le.professional_license.license_type;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		archive_date                     := if( le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate + '01');






		NULL := -999999999;


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

		sysdate := models.common.sas_date((string)(archive_date));

		impulse_email := (integer)contains_i(email_source_list, 'IM') > 0;

		impulse_seg := impulse_email or impulse_count > 0;

		total_recs := if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs)));

		derog_ratio_c2 := if(attr_total_number_derogs = 0, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10) * 10 + 100, if (attr_total_number_derogs * 100 / total_recs / 10 >= 0, roundup(attr_total_number_derogs * 100 / total_recs / 10), truncate(attr_total_number_derogs * 100 / total_recs / 10)) * 10);

		derog_ratio := if(total_recs > 0, derog_ratio_c2, 100);

		i1_derog_ratio_lvl := map(
				derog_ratio >= 160 => 3,
				derog_ratio >= 140 => 2,
				derog_ratio <= 20  => 2,
				derog_ratio >= 100 => 1,
				derog_ratio <= 60  => 1,
															0);

		i1_derog_ratio_lvl_m1 := map(
				i1_derog_ratio_lvl = 0 => 0.7552083333,
				i1_derog_ratio_lvl = 1 => 0.6457317073,
				i1_derog_ratio_lvl = 2 => 0.582,
																	0.3125);

		imp_pos := Models.Common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		impulse_source_count := if(imp_pos > 0, (real)Models.Common.getw(email_source_count, imp_pos), NULL);

		impulse_source_fst_seen := if(imp_pos > 0, Models.Common.getw(email_source_first_seen, imp_pos), (string)NULL);

		_impulse_source_fst_seen := models.common.sas_date((string)(impulse_source_fst_seen));

		mos_impulse_source_fst_seen := if( _impulse_source_fst_seen=NULL, NULL, truncate((sysdate - _impulse_source_fst_seen) / (365.25 / 12)));

		i1_impulse_lvl := map(
				impulse_source_count > 5 or impulse_count > 4                                    => 4,
				impulse_source_count > 3 or impulse_count > 2                                    => 3,
				impulse_source_count > 2 or impulse_count > 1 or mos_impulse_source_fst_seen = 0 => 2,
				impulse_count > 0                                                                => 1,
																																														0);

		i1_impulse_lvl_m1 := map(
				i1_impulse_lvl = 0 => 0.595862069,
				i1_impulse_lvl = 1 => 0.6137607506,
				i1_impulse_lvl = 2 => 0.6289808917,
				i1_impulse_lvl = 3 => 0.672,
															0.7826086957);

		i1_phones_per_adl_lvl := map(
				phones_per_adl = 1 and phones_per_adl_c6 = 0 => 2,
				phones_per_adl_c6 > 0                        => 0,
																												1);

		i1_phones_per_adl_lvl_m1 := map(
				i1_phones_per_adl_lvl = 0 => 0.6870967742,
				i1_phones_per_adl_lvl = 1 => 0.6319161328,
																		 0.5749167592);

		acquire_web := (integer)contains_i(email_source_list, 'AW') > 0;

		outward_media := (integer)contains_i(email_source_list, 'OM') > 0;

		pct_free_accounts := if(email_count > 0, 
					if (	email_domain_free_count * 100 / email_count / 10 >= 0, 
						roundup(email_domain_free_count * 100 / email_count / 10), 
						truncate(email_domain_free_count * 100 / email_count / 10)) * 10, 
					NULL);


		ln_free_email_accts_lvl := map(
				0 <= pct_free_accounts AND pct_free_accounts <= 30 => 2,
				pct_free_accounts = NULL                           => 1,
																															0);

		ln_free_email_accts_lvl_m1 := map(
				ln_free_email_accts_lvl = 0 => 0.6486486486,
				ln_free_email_accts_lvl = 1 => 0.6486486486,
																			 0.5657370518);

		nas_479 := (nas_summary in [4, 7, 9]);

		dob_verd := dobpop and input_dob_match_level = (string)8 and combo_dobscore = 100;

		ln_nas_ver_lvl := map(
				nas_479 and not(dob_verd) => 0,
				not(dob_verd)             => 1,
				nas_479                   => 2,
																		 3);

		ln_nas_ver_lvl_m1 := map(
				ln_nas_ver_lvl = 0 => 0.8888888889,
				ln_nas_ver_lvl = 1 => 0.7064220183,
				ln_nas_ver_lvl = 2 => 0.6923076923,
															0.6072412436);

		inq_coll := inq_collection_count12 > 0;

		inq_auto := inq_auto_count12 > 0;

		inq_banking := inq_banking_count12 > 0;

		inq_highrisk := inq_highriskcredit_count12 > 0;

		inq_comm := inq_communications_count12 > 0;

		inquiry_sum := if(max((integer)inq_coll, (integer)inq_auto, (integer)inq_banking, (integer)inq_highrisk, (integer)inq_comm) = NULL, NULL, sum((integer)inq_coll, (integer)inq_auto, (integer)inq_banking, (integer)inq_highrisk, (integer)inq_comm));

		ln_inquiry_lvl := map(
				inq_coll and inquiry_sum = 1 => 2,
				inquiry_sum > 0              => 1,
																				0);

		ln_inquiry_lvl_m1 := map(
				ln_inquiry_lvl = 0 => 0.61953125,
				ln_inquiry_lvl = 1 => 0.5714285714,
															0.6655092593);

		ln_ssns_per_adl_lvl := map(
				ssns_per_adl > 4 or ssns_per_adl = 0 or ssns_per_adl_c6 > 1  => 4,
				ssns_per_adl > 3 or ssns_per_adl > 1 and ssns_per_adl_c6 > 0 => 3,
				ssns_per_adl_c6 > 0                                          => 2,
				ssns_per_adl > 1                                             => 1,
																																				0);

		ln_ssns_per_adl_lvl_m1 := map(
				ln_ssns_per_adl_lvl = 0 => 0.5869356388,
				ln_ssns_per_adl_lvl = 1 => 0.5786290323,
				ln_ssns_per_adl_lvl = 2 => 0.6351875809,
				ln_ssns_per_adl_lvl = 3 => 0.6853932584,
																	 0.7261904762);

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		ids_per_addr_max := max(adls_per_addr, ssns_per_addr);

		ln_ids_per_addr_lvl := map(
				ids_per_addr_max > 2 and add_apt             => 3,
				ids_per_addr_max > 10                        => 2,
				ids_per_addr_max > 6 or ids_per_addr_max < 2 => 1,
																												0);

		ln_ids_per_addr_lvl_m1 := map(
				ln_ids_per_addr_lvl = 0 => 0.5653594771,
				ln_ids_per_addr_lvl = 1 => 0.5951859956,
				ln_ids_per_addr_lvl = 2 => 0.6500815661,
																	 0.7329545455);

		pl_nurse := (integer)contains_i(StringLib.StringToUpperCase(prof_license_type), 'NURSE') > 0;

		ln_pl_lvl := map(
				pl_nurse          => 2,
				prof_license_flag => 1,
														 0);

		ln_pl_lvl_m1 := map(
				ln_pl_lvl = 0 => 0.6254681648,
				ln_pl_lvl = 1 => 0.6374269006,
												 0.4252873563);

		ln_college_lvl := map(
				(ams_college_tier in ['1', '2', '3']) => 2,
				(ams_college_tier in ['4'])           => 1,
																								 0);

		ln_college_lvl_m1 := map(
				ln_college_lvl = 0 => 0.6243194192,
				ln_college_lvl = 1 => 0.5363636364,
															0.5873015873);

		addrs_15 := addrs_15yr - addrs_10yr;
		addrs_10 := addrs_10yr - addrs_5yr;
		addrs_5 := addrs_5yr - attr_addrs_last36;
		addrs_3 := attr_addrs_last36 - attr_addrs_last24;
		addrs_2 := attr_addrs_last24 - attr_addrs_last12;
		vel4 := addrs_10 - addrs_15;
		vel3 := addrs_5 - addrs_10;
		vel2 := addrs_3 - addrs_5;
		vel1 := addrs_2 - addrs_3;
		vel0 := attr_addrs_last12 - addrs_2;

		addr_vel_rate := round((vel4 * 5 +
				vel3 * 5 +
				vel2 * 2 +
				vel1 +
				vel0) / sum(5, 5, 2, 1, 1)/.25)*.25;

		ln_addr_vel_rate_lvl := map(
				addr_vel_rate = 0                              => 0,
				addr_vel_rate < -.75                           => 1,
				-.75 <= addr_vel_rate AND addr_vel_rate <= .50 => 2,
																													3);

		_reported_dob := models.common.sas_date((string)(reported_dob));

		reported_age := if( _reported_dob=NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

		applicant_age := map(
				(integer)input_dob_age > 0 => (integer)input_dob_age,
				(integer)inferred_age  > 0 => (integer)inferred_age,
				(integer)reported_age  > 0 => (integer)reported_age,
				(integer)ams_age > 0       => (integer)ams_age,
																		 -1);

		ln_age_x_addr_vel_combo_lvl := map(
				applicant_age <= 25                              => 4,
				applicant_age <= 35 and ln_addr_vel_rate_lvl = 3 => 4,
				ln_addr_vel_rate_lvl = 3                         => 3,
				applicant_age <= 35 and ln_addr_vel_rate_lvl > 0 => 3,
				applicant_age <= 45 and ln_addr_vel_rate_lvl = 0 => 2,
				applicant_age <= 45 and ln_addr_vel_rate_lvl = 2 => 2,
				applicant_age <= 55                              => 1,
				applicant_age <= 65 and ln_addr_vel_rate_lvl = 2 => 1,
																														0);

		ln_age_x_addr_vel_combo_lvl_m1 := map(
				ln_age_x_addr_vel_combo_lvl = 0 => 0.4676258993,
				ln_age_x_addr_vel_combo_lvl = 1 => 0.5571557156,
				ln_age_x_addr_vel_combo_lvl = 2 => 0.6474543708,
				ln_age_x_addr_vel_combo_lvl = 3 => 0.7041198502,
																					 0.7961165049);

		aptflag1 := (rc_dwelltype in ['A', 'H']);

		aptflag2 := (add2_addr_type in ['A', 'H']);

		econval1_c30 := map(
				add1_avm_automated_valuation > 0          => add1_avm_automated_valuation,
				add1_avm_assessed_total_value > (string)0 => (integer)add1_avm_assessed_total_value,
				add1_avm_med_geo12 > 0                    => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0                    => add1_avm_med_geo11,
				add1_avm_med_fips > 0                     => add1_avm_med_fips,
																										 -1);

		econval1_c31 := map(
				add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
				add1_avm_med_fips > 0  => add1_avm_med_fips,
																	-1);

		econval1_1 := if(not(aptflag1), econval1_c30, econval1_c31);

		econcode1_c33 := map(
				econval1_1 > 650000 => 'A',
				econval1_1 > 450000 => 'B',
				econval1_1 > 250000 => 'C',
				econval1_1 > 125000 => 'D',
				econval1_1 > 75000  => 'E',
				econval1_1 > 0      => 'F',
															 'U');

		econcode1_c34 := map(
				econval1_1 > 1000000 => 'C',
				econval1_1 > 500000  => 'D',
				econval1_1 > 175000  => 'E',
				econval1_1 > 0       => 'F',
																'U');

		econcode1 := if(not(aptflag1), econcode1_c33, econcode1_c34);

		econval2_c36 := map(
				add2_avm_automated_valuation > 0          => add2_avm_automated_valuation,
				add2_avm_assessed_total_value > (string)0 => NULL,
				add2_avm_med_geo12 > 0                    => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0                    => add2_avm_med_geo11,
				add2_avm_med_fips > 0                     => add2_avm_med_fips,
																										 -1);

		econval2_c37 := map(
				add2_avm_med_geo12 > 0 => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0 => add2_avm_med_geo11,
				add2_avm_med_fips > 0  => add2_avm_med_fips,
																	-1);

		econval2 := if(not(aptflag2), econval2_c36, econval2_c37);

		econcode2_c39 := map(
				econval2 > 650000 => 'A',
				econval2 > 450000 => 'B',
				econval2 > 250000 => 'C',
				econval2 > 125000 => 'D',
				econval2 > 75000  => 'E',
				econval2 > 0      => 'F',
														 'U');

		econcode2_c40 := map(
				econval2 > 1000000 => 'C',
				econval2 > 500000  => 'D',
				econval2 > 175000  => 'E',
				econval2 > 0       => 'F',
															'U');

		econcode2 := if(not(aptflag2), econcode2_c39, econcode2_c40);

		i1_poor_eco_traj_f := map(
				(econcode1 in ['E', 'F', 'U']) and (string)econcode2 = 'F' => 1,
				(string)econcode1 = 'F' and (string)econcode2 = 'U'        => 1,
																																			0);

		i1_brief_residency_f := addr_lres_2mo_count > 2 or addr_lres_6mo_count > 4;

		_header_first_seen := models.common.sas_date((string)(header_first_seen));

		mos_header_first_seen := if( _header_first_seen=NULL, NULL, truncate((sysdate - _header_first_seen) / (365.25 / 12)));


		ln_mos_header_first_seen_c := if(mos_header_first_seen = NULL, 120, min(if(max(mos_header_first_seen, 0) = NULL, -NULL, max(mos_header_first_seen, 0)), 500));

		ln_mos_header_first_seen_sq := power( ln_mos_header_first_seen_c, 2 );

		age_header_first_seen := if( mos_header_first_seen=NULL, NULL, truncate(applicant_age - mos_header_first_seen / 12));

		// ln_age_header_first_seen_c := if(age_header_first_seen < 0, 15, min(if(max(age_header_first_seen, 0) = NULL, -NULL, max(age_header_first_seen, 0)), 50));
		LN_age_header_first_seen_c := if( age_header_first_seen < 0, 15, min(max(age_header_first_seen,0),50) );

		ln_age_header_first_seen_lg := ln(ln_age_header_first_seen_c + 1);

		ln_criminal_f := criminal_count > 0;

		i0_email_sum_lvl := map(
				not(acquire_web)   => 0,
				not(outward_media) => 1,
															2);

		i0_email_sum_lvl_m0 := map(
				i0_email_sum_lvl = 0 => 0.511095204,
				i0_email_sum_lvl = 1 => 0.4656577416,
																0.4028436019);

		max_avm := max((integer)add1_avm_sales_price, (integer)add1_avm_assessed_total_value, (integer)add1_avm_market_total_value, add1_avm_tax_assessed_valuation, add1_avm_price_index_valuation, add1_avm_hedonic_valuation, add1_avm_automated_valuation);

		ln_avm_value_lvl := map(
				max_avm > 200000 => 5,
				max_avm > 100000 => 4,
				max_avm = 0      => 3,
				max_avm > 75000  => 2,
				max_avm > 50000  => 1,
														0);

		ln_avm_value_lvl_m0 := map(
				ln_avm_value_lvl = 0 => 0.6756756757,
				ln_avm_value_lvl = 1 => 0.5833333333,
				ln_avm_value_lvl = 2 => 0.5548780488,
				ln_avm_value_lvl = 3 => 0.4719000892,
				ln_avm_value_lvl = 4 => 0.4466019417,
																0.4673366834);

		ln_econ_trajectory_lvl := map(
				(string)econcode1 = 'F' and (string)econcode2 = 'F'   => 0,
				(string)econcode1 = 'F' and (string)econcode2 = 'U'   => 1,
				(string)econcode1 = 'U' and (string)econcode2 = 'F'   => 1,
				(string)econcode1 = 'U' and (string)econcode2 = 'U'   => 2,
				(string)econcode1 != 'U' and (string)econcode2 != 'U' => 2,
																																 3);

		ln_econ_trajectory_lvl_m0 := map(
				ln_econ_trajectory_lvl = 0 => 0.5856079404,
				ln_econ_trajectory_lvl = 1 => 0.485915493,
				ln_econ_trajectory_lvl = 2 => 0.4689129563,
																			0.4340277778);

		_add1_date_last_seen := models.common.sas_date((string)(add1_date_last_seen));

		mos_add1_date_last_seen := if( _add1_date_last_seen=NULL, NULL, truncate((sysdate - _add1_date_last_seen) / (365.25 / 12)));

		seen_recently := mos_add1_date_last_seen = 0;

		property_owner := property_owned_total > 0 or watercraft_count > 0 or attr_num_aircraft > 0;

		ln_naprop_lvl := map(
				not(seen_recently) and not(property_owner) and add1_naprop = 1 => 0,
				not(seen_recently) and not(property_owner)                     => 1,
				not(property_owner)                                            => 2,
				add1_naprop = 4                                                => 4,
																																					3);

		ln_naprop_lvl_m0 := map(
				ln_naprop_lvl = 0 => 0.7272727273,
				ln_naprop_lvl = 1 => 0.5699300699,
				ln_naprop_lvl = 2 => 0.48852657,
				ln_naprop_lvl = 3 => 0.4446952596,
														 0.429073857);

		ln_derog_ratio_lvl := map(
				derog_ratio >= 160 => 0,
				derog_ratio >= 150 => 1,
				derog_ratio >= 140 => 2,
				derog_ratio >= 130 => 3,
				derog_ratio >= 120 => 4,
				derog_ratio >= 110 => 5,
				derog_ratio <= 20  => 3,
				derog_ratio <= 40  => 4,
				derog_ratio <= 60  => 5,
				derog_ratio <= 70  => 6,
															7);

		ln_derog_ratio_lvl_m0 := map(
				ln_derog_ratio_lvl = 0 => 0.3241758242,
				ln_derog_ratio_lvl = 1 => 0.39453125,
				ln_derog_ratio_lvl = 2 => 0.3856382979,
				ln_derog_ratio_lvl = 3 => 0.4476744186,
				ln_derog_ratio_lvl = 4 => 0.5180467091,
				ln_derog_ratio_lvl = 5 => 0.5601436266,
				ln_derog_ratio_lvl = 6 => 0.6931818182,
																	0.7384615385);

		_liens_unrel_sc_last_seen := models.common.sas_date((string)(liens_unrel_SC_last_seen));

		_liens_rel_sc_last_seen := models.common.sas_date((string)(liens_rel_SC_last_seen));

		mos_sc_unrel_last_seen := if( _liens_unrel_sc_last_seen=NULL, NULL, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)));

		mos_sc_rel_last_seen := if( _liens_rel_sc_last_seen=NULL, NULL, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)));

		ln_sc_liens_lvl := map(
				0 <= mos_sc_unrel_last_seen AND mos_sc_unrel_last_seen <= 12 or 0 <= mos_sc_rel_last_seen AND mos_sc_rel_last_seen <= 6 => 3,
				liens_unrel_SC_ct > 1                                                                                                   => 2,
				liens_unrel_SC_ct > 0                                                                                                   => 1,
																																																																	 0);

		ln_sc_liens_lvl_m0 := map(
				ln_sc_liens_lvl = 0 => 0.4604835799,
				ln_sc_liens_lvl = 1 => 0.5709219858,
				ln_sc_liens_lvl = 2 => 0.5766871166,
															 0.6181818182);

		ln_file_integrity_lvl := map(
				adlperssn_count = 1 and ssns_per_adl = 1 => 3,
				adlperssn_count = 2 and ssns_per_adl = 1 => 2,
				adlperssn_count = 1 and ssns_per_adl = 2 => 2,
				adlperssn_count = 0 or ssns_per_adl = 0  => 0,
				adlperssn_count > 4 or ssns_per_adl > 4  => 0,
				adlperssn_count > 2 and ssns_per_adl > 1 => 0,
				adlperssn_count > 1 and ssns_per_adl > 2 => 0,
																										1);

		ln_file_integrity_lvl_m0 := map(
				ln_file_integrity_lvl = 0 => 0.6209150327,
				ln_file_integrity_lvl = 1 => 0.5436893204,
				ln_file_integrity_lvl = 2 => 0.4823529412,
																		 0.4163454125);

		max_ids_per_addr_c6 := max(adls_per_addr_c6, ssns_per_addr_c6);

		ln_ids_per_addr_c6_2 := min(if(max_ids_per_addr_c6 = NULL, -NULL, max_ids_per_addr_c6), 2);

		ln_ids_per_addr_c6_2_m0 := map(
				ln_ids_per_addr_c6_2 = 0 => 0.4551827742,
				ln_ids_per_addr_c6_2 = 1 => 0.5215252153,
																		0.515503876);

		ln_pl_lvl_m0 := map(
				ln_pl_lvl = 0 => 0.4891558225,
				ln_pl_lvl = 1 => 0.4761904762,
												 0.3071428571);

		_gong_did_last_seen := models.common.sas_date((string)(gong_did_last_seen));

		mos_since_gong_last_seen := if( _gong_did_last_seen=NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));

		phn_last_seen_rec := mos_since_gong_last_seen = 0;

		phn_bad_counts := gong_did_first_ct > 2 or gong_did_last_ct > 2;

		ln_phn_prob_lvl := map(
				phn_bad_counts and not(phn_last_seen_rec) => 3,
				phn_bad_counts and phn_last_seen_rec      => 2,
				not(phn_last_seen_rec)                    => 1,
																										 0);

		ln_phn_prob_lvl_m0 := map(
				ln_phn_prob_lvl = 0 => 0.4575107296,
				ln_phn_prob_lvl = 1 => 0.4911392405,
				ln_phn_prob_lvl = 2 => 0.4368932039,
															 0.6144578313);

		curr_addr_lvl := map(
				add1_applicant_owned => 'APP',
				add1_family_owned    => 'FAM',
				add1_occupant_owned  => 'OCC',
																'OTH');

		prev_addr_lvl := map(
				add2_applicant_owned => 'APP',
				add2_family_owned    => 'FAM',
				add2_occupant_owned  => 'OCC',
																'OTH');

		ln_curr_prev_addr_lvl := map(
				curr_addr_lvl = 'APP'                                       => 4,
				curr_addr_lvl = 'OTH' and prev_addr_lvl != 'APP'            => 2,
				curr_addr_lvl = 'FAM' and prev_addr_lvl = 'OTH'             => 1,
				(curr_addr_lvl in ['FAM', 'OCC']) and prev_addr_lvl = 'FAM' => 0,
																																			 3);

		ln_curr_prev_addr_lvl_m0 := map(
				ln_curr_prev_addr_lvl = 0 => 0.6603773585,
				ln_curr_prev_addr_lvl = 1 => 0.4676258993,
				ln_curr_prev_addr_lvl = 2 => 0.5158371041,
				ln_curr_prev_addr_lvl = 3 => 0.4525222552,
																		 0.4337349398);

		ln_num_nonderogs_90_30_f := attr_num_nonderogs90 - attr_num_nonderogs30 > 0;

		imp1_log := -18.86703771 +
				i1_derog_ratio_lvl_m1 * 4.1212910706 +
				i1_impulse_lvl_m1 * 3.0406542743 +
				i1_phones_per_adl_lvl_m1 * 2.5311661944 +
				ln_free_email_accts_lvl_m1 * 2.5224867221 +
				ln_nas_ver_lvl_m1 * 3.3927862761 +
				ln_inquiry_lvl_m1 * 3.9146407957 +
				ln_ssns_per_adl_lvl_m1 * 3.8275620108 +
				ln_ids_per_addr_lvl_m1 * 2.9896001136 +
				ln_pl_lvl_m1 * 3.1638450644 +
				ln_college_lvl_m1 * 4.5849485849 +
				ln_age_x_addr_vel_combo_lvl_m1 * 0.7280195001 +
				i1_poor_eco_traj_f * 0.2951353094 +
				(integer)i1_brief_residency_f * 0.4545347575 +
				ln_mos_header_first_seen_sq * -7.923451E-6 +
				ln_age_header_first_seen_lg * -0.572488205 +
				(integer)ln_criminal_f * 0.5398153879;

		imp0_log := -14.94317702 +
				i0_email_sum_lvl_m0 * 4.3352608958 +
				ln_avm_value_lvl_m0 * 3.1460966899 +
				ln_econ_trajectory_lvl_m0 * 2.1549774148 +
				ln_naprop_lvl_m0 * 2.1943872701 +
				ln_derog_ratio_lvl_m0 * 3.1220932913 +
				ln_sc_liens_lvl_m0 * 1.7837839122 +
				ln_file_integrity_lvl_m0 * 4.2658521432 +
				ln_ids_per_addr_c6_2_m0 * 2.6554583549 +
				ln_pl_lvl_m0 * 3.8588273489 +
				ln_phn_prob_lvl_m0 * 2.6737522813 +
				ln_curr_prev_addr_lvl_m0 * 2.3440856502 +
				ln_mos_header_first_seen_c * -0.003465335 +
				(integer)ln_criminal_f * 0.5984093008 +
				(integer)ln_num_nonderogs_90_30_f * 0.3991049092;

		phat := if(impulse_seg, exp(imp1_log) / (1 + exp(imp1_log)), exp(imp0_log) / (1 + exp(imp0_log)));

		base := 580;

		point := -20;

		odds := .6108 / (1 - .6108);

		c40_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		custom_40_compucredit_score := max(501, min(900, if(c40_mod = NULL, -NULL, c40_mod)));

		source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'DS', ',') > 0;

		source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'BA', ',') > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'L2', ',') > 0;

		source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'LI', ',') > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;

		_222 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 1, 0);

		rvg1106_1_0 := if(_222=1, 222, custom_40_compucredit_score);



		// REASON CODES
		rc_non_us_ssn                    := le.iid.non_us_ssn;
		inq_count12                      := le.acc_logs.inquiries.count12;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		_phn_recent_disconnect := recent_disconnects > 0;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
		_add_highriskcom := (integer)rc_addrcommflag > 0 or StringLib.StringToUpperCase(add1_advo_res_or_business) = 'B';
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		nap_status                       := le.iid.nap_status;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		telcordia_type                   := le.phone_verification.telcordia_type;
		_phn_notpots := ((rc_hriskphoneflag in ['1', '2', '3', '4']) or (StringLib.StringToUpperCase(rc_hphonetypeflag) in ['1', '2', '3', '6', '7', '9', 'A', 'U'])) and telcordia_type != '00';
		addrs_prison_history             := le.other_address_info.isprison;
		rc_addrvalflag                   := le.iid.addrvalflag;
		_add_invalid := StringLib.StringToUpperCase(rc_addrvalflag) != 'V';
		rc_cityzipflag                   := le.iid.cityzipflag;
		_add_zipcitymismatch := (integer)rc_cityzipflag > 0;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		_add_advo_vacant := StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y';
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		_add_advo_throwback := StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';


		glrc9v := (integer)rc_non_us_ssn = 1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 or rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3', '4']);
		glrc9w := (integer)bankrupt > 0;
		glrc9q := Inq_count12 > 0;
		glrc9t := (integer)_phn_recent_disconnect = 1 or StringLib.StringToUpperCase(nap_status) = 'D' or (rc_hriskphoneflag in ['5', '6']) or (rc_hphonetypeflag in ['5', 'A']) or rc_hphonevalflag = (string)3 or rc_phonezipflag = (string)1 or (boolean)(integer)_phn_notpots;
		glrc9u := (boolean)(integer)_add_highriskcom or addrs_prison_history or (boolean)(integer)_add_invalid or (boolean)(integer)_add_zipcitymismatch or (boolean)(integer)_add_advo_vacant or (boolean)(integer)_add_advo_throwback;
		glrc9o := (integer)add1_eda_sourced = 0;



		riTemp := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		rc := riskwise.Reasons(le, PreScreenOptOut, isCalifornia);
		rcs_final :=
			if( rc.rc02, rc.makeRC('02') ) &
			if( glrc9V, rc.makeRC('9V') ) &
			if( rc.rc97, rc.makeRC('97') ) &
			if( rc.rc25, rc.makeRC('25') ) &
			if( rc.rcEV, rc.makeRC('EV') ) &
			if( glrc9W, rc.makeRC('9W') ) &
			if( rc.rc98, rc.makeRC('98') ) &
			if( rc.rc9H, rc.makeRC('9H') ) &
			if( glrc9Q, rc.makeRC('9Q') ) &
			if( rc.rcMS, rc.makeRC('MS') ) &
			if( rc.rc9D, rc.makeRC('9D') ) &
			if( rc.rcPV, rc.makeRC('PV') ) &
			if( glrc9U, rc.makeRC('9U') ) &
			if( rc.rc9E, rc.makeRC('9E') ) &
			if( glrc9T, rc.makeRC('9T') ) &
			if( glrc9O, rc.makeRC('9O') ) &
			if( rc.rcMI, rc.makeRC('MI') ) &
			if( rc.rc9G, rc.makeRC('9G') ) &
			if( rc.rc28, rc.makeRC('28') ) &
			if( rc.rc20, rc.makeRC('20') ) &
			if( rc.rc99, rc.makeRC('99') ) &
			if( rc.rc9A, rc.makeRC('9A') ) &
			if( rc.rc9I, rc.makeRC('9I') ) &
			if( rc.rc07, rc.makeRC('07') ) &
			if( rc.rc9J, rc.makeRC('9J') )
		;

		ri := map(
			riTemp[1].hri <> '00' => riTemp,
			rc.rc95 => rc.makeRC('95'),
			rc.rc35 => rc.makeRC('35'),
			rvg1106_1_0 = 222 => rc.makeRC('9X'),
			rcs_final
		) & dataset( [ {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc);
		self.ri := choosen( ri, 4 );


		self.score := map(
			riTemp[1].hri in ['91','92','93','94'] => (string3)((integer)riTemp[1].hri + 10),
			rc.rc95 => '222',
			rc.rc35 => '100',
			(string3)rvg1106_1_0
		);
		
		self.seq := le.seq;






		#if(RVG_DEBUG)
			self.clam := le;
			
			self.truedid := truedid;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_decsflag := rc_decsflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.combo_dobscore := combo_dobscore;
			self.ver_sources := ver_sources;
			self.dobpop := dobpop;
			self.add1_avm_sales_price := add1_avm_sales_price;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_tax_assessed_valuation := add1_avm_tax_assessed_valuation;
			self.add1_avm_price_index_valuation := add1_avm_price_index_valuation;
			self.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_date_last_seen := add1_date_last_seen;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.add2_addr_type := add2_addr_type;
			self.add2_avm_assessed_total_value := add2_avm_assessed_total_value;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_med_fips := add2_avm_med_fips;
			self.add2_avm_med_geo11 := add2_avm_med_geo11;
			self.add2_avm_med_geo12 := add2_avm_med_geo12;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add2_occupant_owned := add2_occupant_owned;
			self.add2_family_owned := add2_family_owned;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.addr_lres_2mo_count := addr_lres_2mo_count;
			self.addr_lres_6mo_count := addr_lres_6mo_count;
			self.gong_did_last_seen := gong_did_last_seen;
			self.gong_did_first_ct := gong_did_first_ct;
			self.gong_did_last_ct := gong_did_last_ct;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.phones_per_adl_c6 := phones_per_adl_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.inq_collection_count12 := inq_collection_count12;
			self.inq_auto_count12 := inq_auto_count12;
			self.inq_banking_count12 := inq_banking_count12;
			self.inq_highriskcredit_count12 := inq_highriskcredit_count12;
			self.inq_communications_count12 := inq_communications_count12;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_source_list := email_source_list;
			self.email_source_count := email_source_count;
			self.email_source_first_seen := email_source_first_seen;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_num_aircraft := attr_num_aircraft;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs30 := attr_num_nonderogs30;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.liens_unrel_sc_last_seen := liens_unrel_sc_last_seen;
			self.liens_rel_sc_last_seen := liens_rel_sc_last_seen;
			self.criminal_count := criminal_count;
			self.watercraft_count := watercraft_count;
			self.ams_age := ams_age;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_flag := prof_license_flag;
			self.prof_license_type := prof_license_type;
			self.input_dob_age := input_dob_age;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.reported_dob := reported_dob;
			self.archive_date := archive_date;
		
		
			self.sysdate                          := sysdate;
			self.impulse_email                    := impulse_email;
			self.impulse_seg                      := impulse_seg;
			self.total_recs                       := total_recs;
			self.derog_ratio                      := derog_ratio;
			self.i1_derog_ratio_lvl               := i1_derog_ratio_lvl;
			self.i1_derog_ratio_lvl_m1            := i1_derog_ratio_lvl_m1;
			self.imp_pos                          := imp_pos;
			self.impulse_source_count             := impulse_source_count;
			self.impulse_source_fst_seen          := impulse_source_fst_seen;
			self._impulse_source_fst_seen         := _impulse_source_fst_seen;
			self.mos_impulse_source_fst_seen      := mos_impulse_source_fst_seen;
			self.i1_impulse_lvl                   := i1_impulse_lvl;
			self.i1_impulse_lvl_m1                := i1_impulse_lvl_m1;
			self.i1_phones_per_adl_lvl            := i1_phones_per_adl_lvl;
			self.i1_phones_per_adl_lvl_m1         := i1_phones_per_adl_lvl_m1;
			self.acquire_web                      := acquire_web;
			self.outward_media                    := outward_media;
			self.pct_free_accounts                := pct_free_accounts;
			self.ln_free_email_accts_lvl          := ln_free_email_accts_lvl;
			self.ln_free_email_accts_lvl_m1       := ln_free_email_accts_lvl_m1;
			self.nas_479                          := nas_479;
			self.dob_verd                         := dob_verd;
			self.ln_nas_ver_lvl                   := ln_nas_ver_lvl;
			self.ln_nas_ver_lvl_m1                := ln_nas_ver_lvl_m1;
			self.inq_coll                         := inq_coll;
			self.inq_auto                         := inq_auto;
			self.inq_banking                      := inq_banking;
			self.inq_highrisk                     := inq_highrisk;
			self.inq_comm                         := inq_comm;
			self.inquiry_sum                      := inquiry_sum;
			self.ln_inquiry_lvl                   := ln_inquiry_lvl;
			self.ln_inquiry_lvl_m1                := ln_inquiry_lvl_m1;
			self.ln_ssns_per_adl_lvl              := ln_ssns_per_adl_lvl;
			self.ln_ssns_per_adl_lvl_m1           := ln_ssns_per_adl_lvl_m1;
			self.add_apt                          := add_apt;
			self.ids_per_addr_max                 := ids_per_addr_max;
			self.ln_ids_per_addr_lvl              := ln_ids_per_addr_lvl;
			self.ln_ids_per_addr_lvl_m1           := ln_ids_per_addr_lvl_m1;
			self.pl_nurse                         := pl_nurse;
			self.ln_pl_lvl                        := ln_pl_lvl;
			self.ln_pl_lvl_m1                     := ln_pl_lvl_m1;
			self.ln_college_lvl                   := ln_college_lvl;
			self.ln_college_lvl_m1                := ln_college_lvl_m1;
			self.addrs_15                         := addrs_15;
			self.addrs_10                         := addrs_10;
			self.addrs_5                          := addrs_5;
			self.addrs_3                          := addrs_3;
			self.addrs_2                          := addrs_2;
			self.vel4                             := vel4;
			self.vel3                             := vel3;
			self.vel2                             := vel2;
			self.vel1                             := vel1;
			self.vel0                             := vel0;
			self.addr_vel_rate                    := addr_vel_rate;
			self.ln_addr_vel_rate_lvl             := ln_addr_vel_rate_lvl;
			self._reported_dob                    := _reported_dob;
			self.reported_age                     := reported_age;
			self.applicant_age                    := applicant_age;
			self.ln_age_x_addr_vel_combo_lvl      := ln_age_x_addr_vel_combo_lvl;
			self.ln_age_x_addr_vel_combo_lvl_m1   := ln_age_x_addr_vel_combo_lvl_m1;
			self.aptflag1                         := aptflag1;
			self.aptflag2                         := aptflag2;
			self.econcode1                        := econcode1;
			self.econval2                         := econval2;
			self.econcode2                        := econcode2;
			self.i1_poor_eco_traj_f               := i1_poor_eco_traj_f;
			self.i1_brief_residency_f             := i1_brief_residency_f;
			self._header_first_seen               := _header_first_seen;
			self.mos_header_first_seen            := mos_header_first_seen;
			self.ln_mos_header_first_seen_c       := ln_mos_header_first_seen_c;
			self.ln_mos_header_first_seen_sq      := ln_mos_header_first_seen_sq;
			self.age_header_first_seen            := age_header_first_seen;
			self.ln_age_header_first_seen_c       := ln_age_header_first_seen_c;
			self.ln_age_header_first_seen_lg      := ln_age_header_first_seen_lg;
			self.ln_criminal_f                    := ln_criminal_f;
			self.i0_email_sum_lvl                 := i0_email_sum_lvl;
			self.i0_email_sum_lvl_m0              := i0_email_sum_lvl_m0;
			self.max_avm                          := max_avm;
			self.ln_avm_value_lvl                 := ln_avm_value_lvl;
			self.ln_avm_value_lvl_m0              := ln_avm_value_lvl_m0;
			self.ln_econ_trajectory_lvl           := ln_econ_trajectory_lvl;
			self.ln_econ_trajectory_lvl_m0        := ln_econ_trajectory_lvl_m0;
			self._add1_date_last_seen             := _add1_date_last_seen;
			self.mos_add1_date_last_seen          := mos_add1_date_last_seen;
			self.seen_recently                    := seen_recently;
			self.property_owner                   := property_owner;
			self.ln_naprop_lvl                    := ln_naprop_lvl;
			self.ln_naprop_lvl_m0                 := ln_naprop_lvl_m0;
			self.ln_derog_ratio_lvl               := ln_derog_ratio_lvl;
			self.ln_derog_ratio_lvl_m0            := ln_derog_ratio_lvl_m0;
			self._liens_unrel_sc_last_seen        := _liens_unrel_sc_last_seen;
			self._liens_rel_sc_last_seen          := _liens_rel_sc_last_seen;
			self.mos_sc_unrel_last_seen           := mos_sc_unrel_last_seen;
			self.mos_sc_rel_last_seen             := mos_sc_rel_last_seen;
			self.ln_sc_liens_lvl                  := ln_sc_liens_lvl;
			self.ln_sc_liens_lvl_m0               := ln_sc_liens_lvl_m0;
			self.ln_file_integrity_lvl            := ln_file_integrity_lvl;
			self.ln_file_integrity_lvl_m0         := ln_file_integrity_lvl_m0;
			self.max_ids_per_addr_c6              := max_ids_per_addr_c6;
			self.ln_ids_per_addr_c6_2             := ln_ids_per_addr_c6_2;
			self.ln_ids_per_addr_c6_2_m0          := ln_ids_per_addr_c6_2_m0;
			self.ln_pl_lvl_m0                     := ln_pl_lvl_m0;
			self._gong_did_last_seen              := _gong_did_last_seen;
			self.mos_since_gong_last_seen         := mos_since_gong_last_seen;
			self.phn_last_seen_rec                := phn_last_seen_rec;
			self.phn_bad_counts                   := phn_bad_counts;
			self.ln_phn_prob_lvl                  := ln_phn_prob_lvl;
			self.ln_phn_prob_lvl_m0               := ln_phn_prob_lvl_m0;
			self.curr_addr_lvl                    := curr_addr_lvl;
			self.prev_addr_lvl                    := prev_addr_lvl;
			self.ln_curr_prev_addr_lvl            := ln_curr_prev_addr_lvl;
			self.ln_curr_prev_addr_lvl_m0         := ln_curr_prev_addr_lvl_m0;
			self.ln_num_nonderogs_90_30_f         := ln_num_nonderogs_90_30_f;
			self.imp1_log                         := imp1_log;
			self.imp0_log                         := imp0_log;
			self.phat                             := phat;
			self.base                             := base;
			self.point                            := point;
			self.odds                             := odds;
			self.c40_mod                          := c40_mod;
			self.custom_40_compucredit_score      := custom_40_compucredit_score;
			self.source_tot_ds                    := source_tot_ds;
			self.source_tot_ba                    := source_tot_ba;
			self.bk_flag                          := bk_flag;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.source_tot_l2                    := source_tot_l2;
			self.source_tot_li                    := source_tot_li;
			self.lien_flag                        := lien_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.scored_222s                      := scored_222s;
			self._222                             := _222;
			self.rvg1106_1_0                      := rvg1106_1_0;

			self.rc_non_us_ssn                    := rc_non_us_ssn;
			self.inq_count12                      := inq_count12;
			self.recent_disconnects               := recent_disconnects;
			self._phn_recent_disconnect           := _phn_recent_disconnect;
			self.rc_ssndobflag                    := rc_ssndobflag;
			self.rc_pwssndobflag                  := rc_pwssndobflag;
			self.rc_addrcommflag                  := rc_addrcommflag;
			self.add1_advo_res_or_business        := add1_advo_res_or_business;
			self._add_highriskcom                 := _add_highriskcom;
			self.add1_eda_sourced                 := add1_eda_sourced;
			self.rc_ssnvalflag                    := rc_ssnvalflag;
			self.rc_pwssnvalflag                  := rc_pwssnvalflag;
			self.nap_status                       := nap_status;
			self.rc_hriskphoneflag                := rc_hriskphoneflag;
			self.rc_hphonetypeflag                := rc_hphonetypeflag;
			self.rc_hphonevalflag                 := rc_hphonevalflag;
			self.rc_phonezipflag                  := rc_phonezipflag;
			self.telcordia_type                   := telcordia_type;
			self._phn_notpots                     := _phn_notpots;
			self.addrs_prison_history             := addrs_prison_history;
			self.rc_addrvalflag                   := rc_addrvalflag;
			self._add_invalid                     := _add_invalid;
			self.rc_cityzipflag                   := rc_cityzipflag;
			self._add_zipcitymismatch             := _add_zipcitymismatch;
			self.add1_advo_address_vacancy        := add1_advo_address_vacancy;
			self._add_advo_vacant                 := _add_advo_vacant;
			self.add1_advo_throw_back             := add1_advo_throw_back;
			self._add_advo_throwback              := _add_advo_throwback;
			self.glrc9v                           := glrc9v;
			self.glrc9w                           := glrc9w;
			self.glrc9q                           := glrc9q;
			self.glrc9t                           := glrc9t;
			self.glrc9u                           := glrc9u;
			self.glrc9o                           := glrc9o;
			self.rc1                              := rcs_final[1].hri;
			self.rc2                              := rcs_final[2].hri;
			self.rc3                              := rcs_final[3].hri;
			self.rc4                              := rcs_final[4].hri;
			self.rc5                              := rcs_final[5].hri;
		#end
		
	END;
	
	model := project( clam, doModel(left) );
	return model;
END;


import risk_indicators, ut, easi, riskwise;

MSN_DEBUG := false;

export MSN1106_0_0( grouped dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	#if(MSN_DEBUG)
		layout_debug := record
			String c_fammar_p;
			String C_HH2_P;
			String C_HIGH_ED;
			String C_LOWINC;
			String C_MED_AGE;
			String C_OWNOCC_P;
			String C_ROBBERY;
			Boolean trueDID;
			String adl_category;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String nap_type;
			String rc_decsflag;
			String rc_bansflag;
			Integer combo_lnamescore;
			Integer combo_addrscore;
			Integer combo_dobscore;
			qstring100 ver_sources;
			qstring200 ver_sources_first_seen;
			qstring100 ver_sources_count;
			qstring100 ver_ssn_sources;
			Integer bus_addr_match_count;
			String ssnlength;
			qstring50 util_adl_type_list;
			Boolean add1_isbestmatch;
			String add1_advo_address_vacancy;
			Integer ADD1_NAPROP;
			Integer PROPERTY_OWNED_TOTAL;
			Integer PROPERTY_SOLD_TOTAL;
			Boolean add2_isbestmatch;
			String add2_advo_address_vacancy;
			Integer addrs_5yr;
			Integer addrs_10yr;
			Integer addrs_15yr;
			Integer unique_addr_count;
			String gong_did_first_seen;
			Integer gong_did_phone_ct;
			Integer addrs_per_adl_c6;
			Integer inq_count;
			Integer inq_count01;
			Integer inq_count03;
			Integer inq_count06;
			Integer inq_count12;
			Integer inq_count24;
			Integer inq_collection_count;
			Integer inq_collection_count01;
			Integer inq_collection_count03;
			Integer inq_collection_count06;
			Integer inq_collection_count12;
			Integer inq_collection_count24;
			Integer inq_mortgage_count06;
			Integer inq_mortgage_count12;
			Integer inq_highriskcredit_count;
			Integer inq_retail_count06;
			Integer impulse_count;
			Integer email_count;
			Integer email_domain_free_count;
			Integer email_domain_isp_count;
			Integer email_domain_edu_count;
			Integer email_domain_corp_count;
			qstring50 email_source_list;
			qstring50 email_source_count;
			Integer attr_addrs_last90;
			Integer attr_addrs_last12;
			Integer attr_addrs_last24;
			Integer attr_addrs_last36;
			Integer attr_eviction_count;
			Integer attr_date_last_eviction;
			Boolean Bankrupt;
			Integer date_last_seen;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			String liens_last_unrel_date;
			Integer liens_unrel_cj_ct;
			Integer liens_rel_cj_ct;
			Integer liens_unrel_ft_ct;
			Integer liens_unrel_fc_ct;
			Integer liens_rel_fc_ct;
			Integer liens_unrel_ot_ct;
			Integer liens_rel_ot_ct;
			Integer liens_unrel_sc_ct;
			Integer criminal_count;
			Integer criminal_last_date;
			Integer felony_count;
			Integer rel_count;
			Integer rel_bankrupt_count;
			Integer rel_criminal_count;
			Integer rel_felony_total;
			Integer rel_incomeunder25_count;
			Integer rel_incomeunder50_count;
			Integer rel_incomeunder75_count;
			Integer rel_incomeunder100_count;
			Integer rel_incomeover100_count;
			Integer acc_count;
			String ams_college_code;
			String ams_income_level_code;
			String ams_college_tier;
			String prof_license_category;
			String wealth_index;
			String input_dob_match_level;
			Integer inferred_age;
			String addr_stability_v2;
			Integer archive_date;
			String sysdate;
			Integer today;
			Integer tot_fr_pos;
			Real tot_cnt_fr;
			Integer tot_nt_pos;
			Real tot_cnt_nt;
			Integer tot_p_pos;
			String tot_fdate_p;
			Integer tot_fdate_p2;
			Integer tot_mosince_fdate_p;
			Real tot_cnt_p;
			Integer ssn_source_ct;
			Boolean verfst_p;
			Real nap_type_m;
			Real combo_addrscore_summary_m;
			Real combo_lnamescore_summary_m;
			Boolean ssn_length_ind;
			Real ver_mod;
			Integer inferred_age_18_75;
			Boolean fr_ind;
			Boolean nt_ind;
			Real tot_cnt_p_12;
			Integer ssn_source_ct_4;
			Real tot_mosince_fdate_p_480;
			Integer date_last_seen2;
			Integer mosince_date_ls;
			Integer criminal_last_date2;
			Integer mosince_criminal_ls;
			Integer liens_last_unrel_date2;
			Integer mosince_liens_unrel_ls;
			Integer attr_date_last_eviction2;
			Integer mosince_eviction_ls;
			Real mosince_criminal_ls_300;
			Real mosince_liens_unrel_ls_240;
			Real mosince_date_ls_binned_m;
			Real mosince_eviction_ls_180;
			Integer criminal_count_15;
			Integer felony_ind;
			Boolean impulse_ind;
			Integer liens_recent_unreleased_count_3;
			Integer liens_unrel_cj_ct_3;
			Integer liens_rel_cj_ct_3;
			Integer liens_unrel_ft_ind;
			Boolean liens_fc_ind;
			Integer liens_unrel_ot_ct_3;
			Integer liens_rel_ot_ind;
			Integer liens_unrel_sc_ct_2;
			Real liens_mod;
			Integer attr_eviction_count_3;
			Real derog_prop_mod;
			Integer inq_count_25;
			Integer inq_mortgage_count06_ind;
			Integer inq_mortgage_count12_ind;
			Integer inq_highriskcredit_count_5;
			Integer inq_retail_count06_ind;
			Integer inq_non_collection_count;
			Integer inq_non_collection_count01;
			Integer inq_non_collection_count03;
			Integer inq_non_collection_count06;
			Integer inq_non_collection_count12;
			Integer inq_non_collection_count24;
			Real inq_collection_summary_m;
			Real inq_non_collection_summary_m;
			Real inquiry_mod;
			Integer unique_addr_count_25;
			Boolean add1_vacant_address;
			Boolean add2_vacant_address;
			Integer best_addr_vacant;
			Boolean property_owned_ind;
			Boolean property_sold_ind;
			Real prop_ownership_exp_m;
			Real isbestmatch_m;
			String address_recency;
			Real address_recency_m;
			Real add1_naprop_summary_m;
			Integer gong_did_first_seen2;
			Integer mosince_gong_fs;
			Real mosince_gong_fs_120;
			Real gong_did_phone_ct_6;
			// Boolean util_long_dist;
			// Boolean util_electric;
			// Boolean util_local_phone;
			// Boolean util_cell;
			// Boolean util_telco;
			// Boolean util_cable;
			// Boolean util_other;
			// Boolean util_longdist_local;
			
			boolean util_Infrastructure;
			boolean util_other;
			Real util_mod;
			Integer email_im_pos;
			Real email_cnt_im;
			Integer email_count_15;
			Integer max_email;
			Boolean hi_email_ct;
			Integer email_domain_edu_ind;
			Integer email_domain_corp_ind;
			Real email_cnt_im_ind;
			String email_summary;
			Real email_summary_m;
			Integer ams_college_code_summary;
			Integer ams_income_summary;
			Real ams_college_tier_summary_m;
			Integer ams_college_income_summary;
			Real ams_college_income_summary_m;
			Integer rel_count_25;
			Integer rel_criminal_count_15;
			Integer rel_felony_total_5;
			Integer rel_bankrupt_count_10;
			Integer rel_income;
			Real rel_income_m;
			Real rel_mod;
			Real c_med_age2;
			String c_fammar_p2;
			Real c_hh2_p_70;
			Real c_ownocc_p2;
			Real c_lowinc2;
			Real c_high_ed_60;
			Real c_robbery2;
			Real census_mod;
			Integer bus_addr_match_count_100;
			Integer acc_count_2;
			Real prof_license_category_m;
			Real wealth_index_m;
			Real addr_stability_v2_m;
			Real outest;
			Real phat;
			Integer score_msn;
			Boolean lien_rec_unrel_flag;
			Boolean lien_hist_unrel_flag;
			Boolean source_tot_L2;
			Boolean source_tot_LI;
			Boolean lien_flag;
			Boolean source_tot_DS;
			Boolean source_tot_BA;
			Boolean ssn_deceased;
			Boolean bk_flag;
			Boolean scored_222s;
			Integer MSN1106_0_0_2;
			Integer MSN1106_0_0_1;
			Integer MSN1106_0_0;
			risk_indicators.layout_boca_shell clam;
			models.layout_modelout;
		end;
		layout_debug doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#end
		C_FAMMAR_P                       := ri.fammar_p;
		C_HH2_P                          := ri.hh2_p;
		C_HIGH_ED                        := ri.high_ed;
		C_LOWINC                         := ri.lowinc;
		C_MED_AGE                        := ri.med_age;
		C_OWNOCC_P                       := ri.ownocp;
		C_ROBBERY                        := ri.robbery;
		truedid                          := le.truedid;
		adl_category                     := le.adlcategory;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		rc_decsflag                      := le.iid.decsflag;
		rc_bansflag                      := le.iid.bansflag;
		combo_lnamescore                 := le.iid.combo_lastscore;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
		bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
		ssnlength                        := le.input_validation.ssn_length;
		util_adl_type_list               := le.utility.utili_adl_type;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
		add2_advo_address_vacancy        := le.advo_addr_hist1.address_vacancy_indicator;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		inq_count                        := le.acc_logs.inquiries.counttotal;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_count24                      := le.acc_logs.inquiries.count24;
		inq_collection_count             := le.acc_logs.collection.counttotal;
		inq_collection_count01           := le.acc_logs.collection.count01;
		inq_collection_count03           := le.acc_logs.collection.count03;
		inq_collection_count06           := le.acc_logs.collection.count06;
		inq_collection_count12           := le.acc_logs.collection.count12;
		inq_collection_count24           := le.acc_logs.collection.count24;
		inq_mortgage_count06             := le.acc_logs.mortgage.count06;
		inq_mortgage_count12             := le.acc_logs.mortgage.count12;
		inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
		inq_retail_count06               := le.acc_logs.retail.count06;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
		email_domain_edu_count           := le.email_summary.email_domain_edu_ct;
		email_domain_corp_count          := le.email_summary.email_domain_corp_ct;
		email_source_list                := le.email_summary.email_source_list;
		email_source_count               := le.email_summary.email_source_ct;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_last_unrel_date            := le.bjl.last_liens_unreleased_date;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
		liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
		liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		rel_count                        := le.relatives.relative_count;
		rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
		rel_criminal_count               := le.relatives.relative_criminal_count;
		rel_felony_total                 := le.relatives.relative_felony_total;
		rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
		rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
		rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		acc_count                        := le.accident_data.acc.num_accidents;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		addr_stability_v2                := le.addr_stability;
		archive_date                     := le.historydate;







		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


		NULL := -999999999;

		sysdate := if( archive_date=999999, ut.GetDate[1..6], (string6)archive_date );
		today := (ut.DaysSince1900(((string)sysdate)[1..4], ((string)sysdate)[5..6], (string)01) - ut.DaysSince1900('1960', '1', '1'));

		tot_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , ' ,', 'ie');

		tot_cnt_fr := if(tot_fr_pos > 0, (real)Models.Common.getw(ver_sources_count, tot_fr_pos), 0);

		tot_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , ' ,', 'ie');

		tot_cnt_nt := if(tot_nt_pos > 0, (real)Models.Common.getw(ver_sources_count, tot_nt_pos), 0);

		tot_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		tot_fdate_p := if(tot_p_pos > 0, Models.Common.getw(ver_sources_first_seen, tot_p_pos), '0');

		tot_fdate_p2 := models.common.sas_date((string)(tot_fdate_p));

		tot_mosince_fdate_p := if(min(today, tot_fdate_p2) = NULL, NULL, (integer)((today - tot_fdate_p2) / 30.5));

		tot_cnt_p := if(tot_p_pos > 0, (real)Models.Common.getw(ver_sources_count, tot_p_pos), 0);

		ssn_source_ct := Models.Common.countw((string)(ver_ssn_sources), ' !$%&()*+,-./;<^|');

		nas_12 := (nas_summary = 12);
		verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

		nap_type_m := map(
			trim(nap_type) = ''            => 26.33,
			(nap_type in ['A', 'P']) => 45.90,
										32.95);

		combo_addrscore_summary_m := map(
			(combo_addrscore in [80, 90]) => 27.53,
			combo_addrscore = 100         => 40.33,
											 10.77);

		combo_lnamescore_summary_m := map(
			combo_lnamescore = 100 => 38.06,
			combo_lnamescore = 255 => 3.23,
									  21.84);

		ssn_length_ind := ssnlength = (string)9;

		ver_mod := -4.641610158 +
			(integer)nas_12 * 0.9603054431 +
			(integer)verfst_p * 0.0427762694 +
			nap_type_m * 0.0305712546 +
			combo_addrscore_summary_m * 0.0062681556 +
			combo_lnamescore_summary_m * 0.0177284218 +
			(integer)add1_isbestmatch * 0.1607088249 +
			(integer)ssn_length_ind * 1.057720972;

		inferred_age_18_75 := if(inferred_age != 0, max(min(if(inferred_age = NULL, -NULL, inferred_age), 75), 18), 0);

		fr_ind := tot_cnt_fr > 0;

		nt_ind := tot_cnt_nt > 0;

		tot_cnt_p_12 := min(if(tot_cnt_p = NULL, -NULL, tot_cnt_p), 12);

		ssn_source_ct_4 := min(if(ssn_source_ct = NULL, -NULL, ssn_source_ct), 4);

		tot_mosince_fdate_p_480 := if(tot_mosince_fdate_p = NULL, -100, min(tot_mosince_fdate_p, 480));

		date_last_seen2 := models.common.sas_date((string)(date_last_seen));

		mosince_date_ls := if(min(today, date_last_seen2) = NULL, NULL, (integer)((today - date_last_seen2) / 30.5));

		criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

		mosince_criminal_ls := if(min(today, criminal_last_date2) = NULL, NULL, (integer)((today - criminal_last_date2) / 30.5));

		liens_last_unrel_date2 := models.common.sas_date((string)(liens_last_unrel_date));

		mosince_liens_unrel_ls := if(min(today, liens_last_unrel_date2) = NULL, NULL, (integer)((today - liens_last_unrel_date2) / 30.5));

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		mosince_eviction_ls := if(min(today, attr_date_last_eviction2) = NULL, NULL, (integer)((today - attr_date_last_eviction2) / 30.5));

		mosince_criminal_ls_300 := if(mosince_criminal_ls != NULL, min(mosince_criminal_ls, 300), 300);

		mosince_liens_unrel_ls_240 := if(mosince_liens_unrel_ls != NULL, min(mosince_liens_unrel_ls, 240), 240);

		mosince_date_ls_binned_m := map(
			mosince_date_ls = NULL => 41.20,
			mosince_date_ls < 120  => 3.85,
									  30.41);

		mosince_eviction_ls_180 := if(mosince_eviction_ls != NULL, min(if(mosince_eviction_ls = NULL, -NULL, mosince_eviction_ls), 180), 200);

		criminal_count_15 := min(if(criminal_count = NULL, -NULL, criminal_count), 15);

		felony_ind := min(if(felony_count = NULL, -NULL, felony_count), 1);

		impulse_ind := impulse_count > 0;

		liens_recent_unreleased_count_3 := min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 3);

		liens_unrel_cj_ct_3 := min(if(liens_unrel_cj_ct = NULL, -NULL, liens_unrel_cj_ct), 3);

		liens_rel_cj_ct_3 := min(if(liens_rel_cj_ct = NULL, -NULL, liens_rel_cj_ct), 3);

		liens_unrel_ft_ind := min(if(liens_unrel_ft_ct = NULL, -NULL, liens_unrel_ft_ct), 1);

		liens_fc_ind := liens_unrel_fc_ct > 0 or liens_rel_fc_ct > 0;

		liens_unrel_ot_ct_3 := min(if(liens_unrel_ot_ct = NULL, -NULL, liens_unrel_ot_ct), 3);

		liens_rel_ot_ind := min(if(liens_rel_ot_ct = NULL, -NULL, liens_rel_ot_ct), 1);

		liens_unrel_sc_ct_2 := min(if(liens_unrel_sc_ct = NULL, -NULL, liens_unrel_sc_ct), 2);

		liens_mod := -0.34734271 +
			liens_recent_unreleased_count_3 * -0.957640431 +
			liens_unrel_cj_ct_3 * -0.666967488 +
			liens_rel_cj_ct_3 * -0.320059184 +
			liens_unrel_ft_ind * -0.346335325 +
			liens_unrel_ot_ct_3 * -0.200775627 +
			liens_rel_ot_ind * -0.219495459 +
			liens_unrel_sc_ct_2 * -0.946324739;

		attr_eviction_count_3 := min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 3);

		derog_prop_mod := -2.362095058 +
			mosince_eviction_ls_180 * 0.0095848043 +
			attr_eviction_count_3 * -0.450242261 +
			(integer)fr_ind * -0.613654903 +
			(integer)nt_ind * -2.138021032 +
			(integer)liens_fc_ind * -1.377582042;

		inq_count_25 := min(if(Inq_count = NULL, -NULL, Inq_count), 25);

		inq_mortgage_count06_ind := min(if(inq_mortgage_count06 = NULL, -NULL, inq_mortgage_count06), 1);

		inq_mortgage_count12_ind := min(if(inq_mortgage_count12 = NULL, -NULL, inq_mortgage_count12), 1);

		inq_highriskcredit_count_5 := min(if(Inq_HighRiskCredit_count = NULL, -NULL, Inq_HighRiskCredit_count), 5);

		inq_retail_count06_ind := min(if(Inq_Retail_count06 = NULL, -NULL, Inq_Retail_count06), 1);

		inq_non_collection_count := Inq_Count - Inq_Collection_count;

		inq_non_collection_count01 := Inq_count01 - Inq_Collection_count01;

		inq_non_collection_count03 := Inq_count03 - Inq_Collection_count03;

		inq_non_collection_count06 := Inq_count06 - Inq_Collection_count06;

		inq_non_collection_count12 := Inq_count12 - Inq_Collection_count12;

		inq_non_collection_count24 := Inq_count24 - Inq_Collection_count24;

		inq_collection_summary_m := map(
			inq_collection_count01 > 0 => 14.05,
			inq_collection_count03 > 0 => 16.93,
			inq_collection_count06 > 0 => 18.19,
			inq_collection_count12 > 0 => 23.80,
			inq_collection_count24 > 0 => 26.92,
			inq_collection_count > 0   => 31.19,
										  44.72);

		inq_non_collection_summary_m := map(
			inq_non_collection_count01 > 0 => 24.63,
			inq_non_collection_count03 > 0 => 31.31,
			inq_non_collection_count06 > 0 => 32.07,
			inq_non_collection_count12 > 0 => 38.88,
			inq_non_collection_count24 > 0 => 40.59,
			inq_non_collection_count > 0   => 41.57,
											  39.34);

		inquiry_mod := -3.288894167 +
			inq_count_25 * -0.047023303 +
			inq_collection_summary_m * 0.0328367018 +
			inq_non_collection_summary_m * 0.0439926671 +
			inq_retail_count06_ind * 0.7273335727 +
			inq_highriskcredit_count_5 * -1.515121722 +
			inq_mortgage_count06_ind * 0.3101880726 +
			inq_mortgage_count12_ind * 0.392831375;

		unique_addr_count_25 := min(if(unique_addr_count = NULL, -NULL, unique_addr_count), 25);

		add1_vacant_address := (string)add1_advo_address_vacancy = 'Y';

		add2_vacant_address := (string)add2_advo_address_vacancy = 'Y';

		best_addr_vacant := map(
			add1_isbestmatch => add1_vacant_address,
			add2_isbestmatch => add2_vacant_address,
								0);

		property_owned_ind := property_owned_total > 0;

		property_sold_ind := property_sold_total > 0;

		prop_ownership_exp_m := map(
			not(property_owned_ind or property_sold_ind)  => 26.47,
			not(property_owned_ind) and property_sold_ind => 38.14,
			property_owned_ind and not(property_sold_ind) => 49.46,
															 52.43);

		isbestmatch_m := map(
			add1_isbestmatch => 24.09,
			add2_isbestmatch => 41.46,
								30.61);

		address_recency := map(
			attr_addrs_last90 > 0 => 'd90',
			addrs_per_adl_c6 > 0  => 'm06',
			attr_addrs_last12 > 0 => 'm12',
			attr_addrs_last24 > 0 => 'm24',
			attr_addrs_last36 > 0 => 'm36',
			addrs_5yr > 0         => 'y05',
			addrs_10yr > 0        => 'y10',
			addrs_15yr > 0        => 'y15',
			'');

		address_recency_m := map(
			address_recency = ''                       => 5.29,
			(address_recency in ['d90', 'm06'])        => 32.25,
			(address_recency in ['m12', 'm24', 'm36']) => 42.12,
														  43.10);

		add1_naprop_summary_m := map(
			add1_naprop = 0         => 26.90,
			add1_naprop = 1         => 25.95,
			(add1_naprop in [2, 3]) => 33.99,
									   54.27);

		gong_did_first_seen2 := models.common.sas_date((string)(gong_did_first_seen));

		mosince_gong_fs := if(min(today, gong_did_first_seen2) = NULL, NULL, (integer)((today - gong_did_first_seen2) / 30.5));

		mosince_gong_fs_120 := if(mosince_gong_fs = NULL, 48, min(if(mosince_gong_fs = NULL, -NULL, mosince_gong_fs), 120));

		gong_did_phone_ct_6_1 := min(if(gong_did_phone_ct = NULL, -NULL, gong_did_phone_ct), 6);

		gong_did_phone_ct_6 := if(gong_did_phone_ct = 0, 3.5, gong_did_phone_ct_6_1);

		/* finding which number word 1, 2 or Z occur in */
		util_Infrastructure_w      := Models.Common.findw_cpp(util_adl_type_list,'1',' ,','I E');
		util_Other_w              := Models.Common.findw_cpp(util_adl_type_list,'Z',' ,','I E');

		util_Infrastructure := util_infrastructure_w > 0;
		util_other                      := util_other_w > 0;

		util_mod := -0.041510334
								+ (integer)util_Infrastructure  * -0.382617319
								+ (integer)util_other  * -0.280630249;
		 
		email_im_pos := Models.Common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		email_cnt_im := if(email_im_pos > 0, (real)Models.Common.getw(email_source_count, email_im_pos), 0);

		email_count_15 := min(if(email_count = NULL, -NULL, email_count), 15);

		max_email := max(email_domain_free_count, email_domain_isp_count, email_domain_edu_count, email_domain_corp_count);

		hi_email_ct := email_count >= 7;

		email_domain_edu_ind := min(if(email_domain_edu_count = NULL, -NULL, email_domain_edu_count), 1);

		email_domain_corp_ind := min(if(email_domain_corp_count = NULL, -NULL, email_domain_corp_count), 1);

		email_cnt_im_ind := min(if(email_cnt_im = NULL, -NULL, email_cnt_im), 1);

		email_summary := map(
			(boolean)email_cnt_im_ind or max_email = email_domain_free_count and hi_email_ct => '1 IM/HI',
			email_domain_edu_ind > 0                                                         => '2 EDU',
			email_domain_corp_ind > 0                                                        => '3 CORP',
			email_count != 0 and max_email = email_domain_free_count                         => '4 FREE',
			email_count != 0 and max_email = email_domain_isp_count                          => '5 ISP',
			email_count > 0                                                                  => '6 ERROR',
																								'7 NONE');

		email_summary_m := map(
			Models.Common.getw(trim(email_summary, LEFT), 1) = '1' => 12.68,
			Models.Common.getw(trim(email_summary, LEFT), 1) = '2' => 45.87,
			Models.Common.getw(trim(email_summary, LEFT), 1) = '3' => 37.73,
			Models.Common.getw(trim(email_summary, LEFT), 1) = '4' => 35.54,
			Models.Common.getw(trim(email_summary, LEFT), 1) = '5' => 38.15,
																	  41.19);

		ams_college_code_summary := map(
			ams_college_code = (string)1    => 4,
			trim(ams_college_code) = '' => 0,
											   (integer1)ams_college_code);

		ams_income_summary := map(
			trim(ams_income_level_code) = ''         => 0,
			ams_income_level_code in ['A', 'B', 'C'] => 1,
			ams_income_level_code = 'D'              => 2,
			ams_income_level_code = 'E'              => 3,
			ams_income_level_code in ['F', 'G']      => 4,
			ams_income_level_code in ['H', 'I']      => 5,
			                                            6);

		ams_college_tier_summary_m := map(
			trim(ams_college_tier) = ''                => 37.06,
			ams_college_tier in ['0', '1', '2', '3']   => 47.68,
			ams_college_tier = (string)4               => 40.91,
			ams_college_tier = (string)5               => 33.33,
			                                              26.83);

		ams_college_income_summary := map(
			ams_college_code_summary = 0 and ams_income_summary = 0                                                              => 0,
			ams_college_code_summary = 0 and ams_income_summary <= 3 or ams_college_code_summary = 2 and ams_income_summary <= 1 => 1,
			ams_college_code_summary = 0 and ams_income_summary = 4 or ams_college_code_summary = 2 and ams_income_summary <= 3  => 2,
			ams_college_code_summary = 0 and ams_income_summary = 5 or ams_college_code_summary = 2 and ams_income_summary <= 5  => 3,
			ams_college_code_summary <= 2 or ams_college_code_summary = 4 and ams_income_summary <= 3                            => 4,
			ams_college_code_summary = 4 and ams_income_summary = 4                                                              => 5,
			ams_college_code_summary = 4 and ams_income_summary = 5                                                              => 6,
																																	7);

		ams_college_income_summary_m := map(
			ams_college_income_summary = 0 => 38.24,
			ams_college_income_summary = 1 => 21.13,
			ams_college_income_summary = 2 => 28.67,
			ams_college_income_summary = 3 => 32.46,
			ams_college_income_summary = 4 => 38.92,
			ams_college_income_summary = 5 => 44.52,
			ams_college_income_summary = 6 => 47.43,
											  50.28);

		rel_count_25_1 := min(if(rel_count = NULL, -NULL, rel_count), 25);

		rel_count_25 := if(rel_count = 0, 26, rel_count_25_1);

		rel_criminal_count_15 := min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 15);

		rel_felony_total_5 := min(if(rel_felony_total = NULL, -NULL, rel_felony_total), 5);

		rel_bankrupt_count_10 := min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 10);

		rel_income := map(
			rel_incomeover100_count > 0  => 101,
			rel_incomeunder100_count > 0 => 100,
			rel_incomeunder75_count > 0  => 75,
			rel_incomeunder50_count > 0  => 50,
			rel_incomeunder25_count > 0  => 25,
											0);

		rel_income_m := map(
			rel_income = 0   => 18.77,
			rel_income = 25  => 26.14,
			rel_income = 50  => 32.34,
			rel_income = 75  => 37.12,
			rel_income = 100 => 42.17,
								47.46);

		rel_mod := -2.062493544 +
			rel_count_25 * -0.022654928 +
			rel_criminal_count_15 * -0.047189594 +
			rel_felony_total_5 * -0.167816303 +
			rel_bankrupt_count_10 * -0.211538596 +
			rel_income_m * 0.0534136052;

		c_med_age2  := if(trim(C_MED_AGE) = '', 0, (real)c_med_age);
		c_fammar_p2 := if(trim(C_FAMMAR_P) = '', 55, (real)c_fammar_p);
		c_hh2_p_70  := if(trim(C_HH2_P) != '', min((real)C_HH2_P, 70), 10 );
		c_ownocc_p2 := if(trim(C_OWNOCC_P) = '', 5, (real)c_ownocc_p);
		c_lowinc2   := if(trim(C_LOWINC) = '', 60, (real)C_LOWINC);

		c_high_ed_60 := if(trim(C_HIGH_ED) != '', min((real)C_HIGH_ED, 60), 5);
		c_robbery2 := if(trim(C_ROBBERY) = '', 199, (real)C_ROBBERY);

		census_mod := -1.757523681 +
			c_med_age2 * 0.0022112392 +
			c_fammar_p2 * 0.0091163307 +
			c_hh2_p_70 * 0.0023367248 +
			c_ownocc_p2 * 0.0033727916 +
			c_lowinc2 * -0.003617957 +
			c_high_ed_60 * 0.0121167559 +
			c_robbery2 * -0.001878085;

		bus_addr_match_count_100 := min(if(bus_addr_match_count = NULL, -NULL, bus_addr_match_count), 100);

		acc_count_2 := min(if(acc_count = NULL, -NULL, acc_count), 2);

		prof_license_category_m := map(
			trim(prof_license_category) = '' => 36.59,
			prof_license_category = (string)0    => 41.95,
			prof_license_category = (string)1    => 32.51,
			prof_license_category = (string)2    => 35.60,
			prof_license_category = (string)3    => 48.13,
			prof_license_category = (string)4    => 49.61,
													61.19);

		wealth_index_m := map(
			wealth_index = (string)1 => 19.22,
			wealth_index = (string)2 => 27.83,
			wealth_index = (string)3 => 33.22,
			wealth_index = (string)4 => 43.73,
			wealth_index = (string)5 => 53.72,
										55.28);

		addr_stability_v2_m := map(
			addr_stability_v2 = '0' => 10.48,
			addr_stability_v2 = '1' => 21.07,
			addr_stability_v2 = '2' => 25.13,
			addr_stability_v2 = '3' => 27.13,
			addr_stability_v2 = '4' => 30.64,
			addr_stability_v2 = '5' => 37.81,
									 48.53);

		outest := -7.121824799 +
			inferred_age_18_75 * 0.0107881315 +
			ver_mod * 0.4821304173 +
			tot_cnt_p_12 * 0.0185722598 +
			tot_mosince_fdate_p_480 * 0.0005914305 +
			ssn_source_ct_4 * 0.2107348076 +
			criminal_count_15 * -0.041100587 +
			felony_ind * -0.252863507 +
			(integer)impulse_ind * -1.50006465 +
			mosince_liens_unrel_ls_240 * 0.0041542086 +
			mosince_criminal_ls_300 * 0.0002838206 +
			liens_mod * 0.2458745251 +
			mosince_date_ls_binned_m * 0.0693051539 +
			derog_prop_mod * 0.2680849854 +
			inquiry_mod * 0.7392448059 +
			add1_naprop_summary_m * 0.0036593403 +
			isbestmatch_m * -0.003875905 +
			address_recency_m * 0.012493827 +
			prop_ownership_exp_m * 0.0026699695 +
			unique_addr_count_25 * -0.005023787 +
			best_addr_vacant * -0.338466343 +
			mosince_gong_fs_120 * 0.0025273269 +
			gong_did_phone_ct_6 * -0.030914384 +
			rel_mod * 0.3056993181 +
			census_mod * 0.3328490095 +
			ams_college_income_summary_m * 0.0065306314 +
			ams_college_tier_summary_m * 0.0340241622 +
			bus_addr_match_count_100 * -0.002465206 +
			acc_count_2 * -0.154734739 +
			email_summary_m * 0.0066593133 +
			email_count_15 * -0.043079997 +
			util_mod * 0.3559530842 +
			prof_license_category_m * 0.0110147968 +
			wealth_index_m * 0.0042652391 +
			addr_stability_v2_m * 0.0040006534;

		phat := exp(outest) / (1 + exp(outest));

		score := round(50 * (ln(phat / (1 - phat)) - ln(1 / 20)) / ln(2) + 600);

		msn1106_0_0_2 := min(999, if(max(300, score) = NULL, -NULL, max(300, score)));

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'L2', ',') > 0;

		source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'LI', ',') > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'DS', ',') > 0;

		source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'BA', ',') > 0;

		ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		// msn1106_0_0_1 := if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 and not(scored_222s), 222, msn1106_0_0_2);
		msn1106_0_0_1 := msn1106_0_0_2;

		msn1106_0_0 := if(trim(adl_category, LEFT, RIGHT) = '1 DEAD' or rc_decsflag = (string)1 or source_tot_ds, 200, msn1106_0_0_1);


		#if(MSN_DEBUG)
			self.clam := le;
			self.C_FAMMAR_P := C_FAMMAR_P;
			self.C_HH2_P := C_HH2_P;
			self.C_HIGH_ED := C_HIGH_ED;
			self.C_LOWINC := C_LOWINC;
			self.C_MED_AGE := C_MED_AGE;
			self.C_OWNOCC_P := C_OWNOCC_P;
			self.C_ROBBERY := C_ROBBERY;
			self.truedid := truedid;
			self.adl_category := adl_category;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_type := nap_type;
			self.rc_decsflag := rc_decsflag;
			self.rc_bansflag := rc_bansflag;
			self.combo_lnamescore := combo_lnamescore;
			self.combo_addrscore := combo_addrscore;
			self.combo_dobscore := combo_dobscore;
			self.ver_sources := ver_sources;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_sources_count := ver_sources_count;
			self.ver_ssn_sources := ver_ssn_sources;
			self.bus_addr_match_count := bus_addr_match_count;
			self.ssnlength := ssnlength;
			self.util_adl_type_list := util_adl_type_list;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_naprop := add1_naprop;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.add2_isbestmatch := add2_isbestmatch;
			self.add2_advo_address_vacancy := add2_advo_address_vacancy;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.unique_addr_count := unique_addr_count;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.inq_count := inq_count;
			self.inq_count01 := inq_count01;
			self.inq_count03 := inq_count03;
			self.inq_count06 := inq_count06;
			self.inq_count12 := inq_count12;
			self.inq_count24 := inq_count24;
			self.inq_collection_count := inq_collection_count;
			self.inq_collection_count01 := inq_collection_count01;
			self.inq_collection_count03 := inq_collection_count03;
			self.inq_collection_count06 := inq_collection_count06;
			self.inq_collection_count12 := inq_collection_count12;
			self.inq_collection_count24 := inq_collection_count24;
			self.inq_mortgage_count06 := inq_mortgage_count06;
			self.inq_mortgage_count12 := inq_mortgage_count12;
			self.inq_highriskcredit_count := inq_highriskcredit_count;
			self.inq_retail_count06 := inq_retail_count06;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_domain_isp_count := email_domain_isp_count;
			self.email_domain_edu_count := email_domain_edu_count;
			self.email_domain_corp_count := email_domain_corp_count;
			self.email_source_list := email_source_list;
			self.email_source_count := email_source_count;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_last_unrel_date := liens_last_unrel_date;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_rel_cj_ct := liens_rel_cj_ct;
			self.liens_unrel_ft_ct := liens_unrel_ft_ct;
			self.liens_unrel_fc_ct := liens_unrel_fc_ct;
			self.liens_rel_fc_ct := liens_rel_fc_ct;
			self.liens_unrel_ot_ct := liens_unrel_ot_ct;
			self.liens_rel_ot_ct := liens_rel_ot_ct;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_count := felony_count;
			self.rel_count := rel_count;
			self.rel_bankrupt_count := rel_bankrupt_count;
			self.rel_criminal_count := rel_criminal_count;
			self.rel_felony_total := rel_felony_total;
			self.rel_incomeunder25_count := rel_incomeunder25_count;
			self.rel_incomeunder50_count := rel_incomeunder50_count;
			self.rel_incomeunder75_count := rel_incomeunder75_count;
			self.rel_incomeunder100_count := rel_incomeunder100_count;
			self.rel_incomeover100_count := rel_incomeover100_count;
			self.acc_count := acc_count;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.addr_stability_v2 := addr_stability_v2;
			self.archive_date := archive_date;
			self.sysdate := sysdate;
			self.today                            := today;
			self.tot_fr_pos                       := tot_fr_pos;
			self.tot_cnt_fr                       := tot_cnt_fr;
			self.tot_nt_pos                       := tot_nt_pos;
			self.tot_cnt_nt                       := tot_cnt_nt;
			self.tot_p_pos                        := tot_p_pos;
			self.tot_fdate_p                      := tot_fdate_p;
			self.tot_fdate_p2                     := tot_fdate_p2;
			self.tot_mosince_fdate_p              := tot_mosince_fdate_p;
			self.tot_cnt_p                        := tot_cnt_p;
			self.ssn_source_ct                    := ssn_source_ct;
			self.verfst_p                         := verfst_p;
			self.nap_type_m                       := nap_type_m;
			self.combo_addrscore_summary_m        := combo_addrscore_summary_m;
			self.combo_lnamescore_summary_m       := combo_lnamescore_summary_m;
			self.ssn_length_ind                   := ssn_length_ind;
			self.ver_mod                          := ver_mod;
			self.inferred_age_18_75               := inferred_age_18_75;
			self.fr_ind                           := fr_ind;
			self.nt_ind                           := nt_ind;
			self.tot_cnt_p_12                     := tot_cnt_p_12;
			self.ssn_source_ct_4                  := ssn_source_ct_4;
			self.tot_mosince_fdate_p_480          := tot_mosince_fdate_p_480;
			self.date_last_seen2                  := date_last_seen2;
			self.mosince_date_ls                  := mosince_date_ls;
			self.criminal_last_date2              := criminal_last_date2;
			self.mosince_criminal_ls              := mosince_criminal_ls;
			self.liens_last_unrel_date2           := liens_last_unrel_date2;
			self.mosince_liens_unrel_ls           := mosince_liens_unrel_ls;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mosince_eviction_ls              := mosince_eviction_ls;
			self.mosince_criminal_ls_300          := mosince_criminal_ls_300;
			self.mosince_liens_unrel_ls_240       := mosince_liens_unrel_ls_240;
			self.mosince_date_ls_binned_m         := mosince_date_ls_binned_m;
			self.mosince_eviction_ls_180          := mosince_eviction_ls_180;
			self.criminal_count_15                := criminal_count_15;
			self.felony_ind                       := felony_ind;
			self.impulse_ind                      := impulse_ind;
			self.liens_recent_unreleased_count_3  := liens_recent_unreleased_count_3;
			self.liens_unrel_cj_ct_3              := liens_unrel_cj_ct_3;
			self.liens_rel_cj_ct_3                := liens_rel_cj_ct_3;
			self.liens_unrel_ft_ind               := liens_unrel_ft_ind;
			self.liens_fc_ind                     := liens_fc_ind;
			self.liens_unrel_ot_ct_3              := liens_unrel_ot_ct_3;
			self.liens_rel_ot_ind                 := liens_rel_ot_ind;
			self.liens_unrel_sc_ct_2              := liens_unrel_sc_ct_2;
			self.liens_mod                        := liens_mod;
			self.attr_eviction_count_3            := attr_eviction_count_3;
			self.derog_prop_mod                   := derog_prop_mod;
			self.inq_count_25                     := inq_count_25;
			self.inq_mortgage_count06_ind         := inq_mortgage_count06_ind;
			self.inq_mortgage_count12_ind         := inq_mortgage_count12_ind;
			self.inq_highriskcredit_count_5       := inq_highriskcredit_count_5;
			self.inq_retail_count06_ind           := inq_retail_count06_ind;
			self.inq_non_collection_count         := inq_non_collection_count;
			self.inq_non_collection_count01       := inq_non_collection_count01;
			self.inq_non_collection_count03       := inq_non_collection_count03;
			self.inq_non_collection_count06       := inq_non_collection_count06;
			self.inq_non_collection_count12       := inq_non_collection_count12;
			self.inq_non_collection_count24       := inq_non_collection_count24;
			self.inq_collection_summary_m         := inq_collection_summary_m;
			self.inq_non_collection_summary_m     := inq_non_collection_summary_m;
			self.inquiry_mod                      := inquiry_mod;
			self.unique_addr_count_25             := unique_addr_count_25;
			self.add1_vacant_address              := add1_vacant_address;
			self.add2_vacant_address              := add2_vacant_address;
			self.best_addr_vacant                 := best_addr_vacant;
			self.property_owned_ind               := property_owned_ind;
			self.property_sold_ind                := property_sold_ind;
			self.prop_ownership_exp_m             := prop_ownership_exp_m;
			self.isbestmatch_m                    := isbestmatch_m;
			self.address_recency                  := address_recency;
			self.address_recency_m                := address_recency_m;
			self.add1_naprop_summary_m            := add1_naprop_summary_m;
			self.gong_did_first_seen2             := gong_did_first_seen2;
			self.mosince_gong_fs                  := mosince_gong_fs;
			self.mosince_gong_fs_120              := mosince_gong_fs_120;
			self.gong_did_phone_ct_6              := gong_did_phone_ct_6;
			// self.util_long_dist                   := util_long_dist;
			// self.util_electric                    := util_electric;
			// self.util_local_phone                 := util_local_phone;
			// self.util_cell                        := util_cell;
			// self.util_telco                       := util_telco;
			// self.util_cable                       := util_cable;
			// self.util_other                       := util_other;
			// self.util_longdist_local              := util_longdist_local;
			
			self.util_Infrastructure := util_Infrastructure;
			self.util_other := util_other;
			self.util_mod                         := util_mod;
			self.email_im_pos                     := email_im_pos;
			self.email_cnt_im                     := email_cnt_im;
			self.email_count_15                   := email_count_15;
			self.max_email                        := max_email;
			self.hi_email_ct                      := hi_email_ct;
			self.email_domain_edu_ind             := email_domain_edu_ind;
			self.email_domain_corp_ind            := email_domain_corp_ind;
			self.email_cnt_im_ind                 := email_cnt_im_ind;
			self.email_summary                    := email_summary;
			self.email_summary_m                  := email_summary_m;
			self.ams_college_code_summary         := ams_college_code_summary;
			self.ams_income_summary               := ams_income_summary;
			self.ams_college_tier_summary_m       := ams_college_tier_summary_m;
			self.ams_college_income_summary       := ams_college_income_summary;
			self.ams_college_income_summary_m     := ams_college_income_summary_m;
			self.rel_count_25                     := rel_count_25;
			self.rel_criminal_count_15            := rel_criminal_count_15;
			self.rel_felony_total_5               := rel_felony_total_5;
			self.rel_bankrupt_count_10            := rel_bankrupt_count_10;
			self.rel_income                       := rel_income;
			self.rel_income_m                     := rel_income_m;
			self.rel_mod                          := rel_mod;
			self.c_med_age2                        := c_med_age2;
			self.c_fammar_p2                       := c_fammar_p;
			self.c_hh2_p_70                       := c_hh2_p_70;
			self.c_ownocc_p2                       := c_ownocc_p2;
			self.c_lowinc2                         := c_lowinc2;
			self.c_high_ed_60                     := c_high_ed_60;
			self.c_robbery2                        := c_robbery2;
			self.census_mod                       := census_mod;
			self.bus_addr_match_count_100         := bus_addr_match_count_100;
			self.acc_count_2                      := acc_count_2;
			self.prof_license_category_m          := prof_license_category_m;
			self.wealth_index_m                   := wealth_index_m;
			self.addr_stability_v2_m              := addr_stability_v2_m;
			self.outest                           := outest;
			self.phat                             := phat;
			self.score_msn                            := score;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.source_tot_l2                    := source_tot_l2;
			self.source_tot_li                    := source_tot_li;
			self.lien_flag                        := lien_flag;
			self.source_tot_ds                    := source_tot_ds;
			self.source_tot_ba                    := source_tot_ba;
			self.ssn_deceased                     := ssn_deceased;
			self.bk_flag                          := bk_flag;
			self.scored_222s                      := scored_222s;
			self.msn1106_0_0_2                    := msn1106_0_0_2;
			self.msn1106_0_0_1                    := msn1106_0_0_1;
			self.msn1106_0_0                      := msn1106_0_0;
		#END
		
		self.seq := le.seq;
		self.score := (string3)msn1106_0_0;
		
		rc := riskwise.Reasons( le );
		reasons := 
			  if( rc.rc77, rc.makeRC('77') )
			& if( rc.rc78, rc.makeRC('78') )
			& if( rc.rc02, rc.makeRC('02') )
			& if( rc.rc50, rc.makeRC('50') )
			& if( rc.rc97, rc.makeRC('97') )
			& if( rc.rc9N, rc.makeRC('9N') )
			& if( rc.rc98, rc.makeRC('98') )
			& if( rc.rcEV, rc.makeRC('EV') )
			& if( rc.rc9W, rc.makeRC('9W') )
			& if( rc.rc9H, rc.makeRC('9H') )
			& if( rc.rc22, rc.makeRC('22') )
			& if( rc.rc23, rc.makeRC('23') )
			& if( rc.rc24, rc.makeRC('24') )
			& if( rc.rc25, rc.makeRC('25') )
			& if( rc.rc26, rc.makeRC('26') )
			& if( rc.rc37, rc.makeRC('37') )
			& if( rc.rc48, rc.makeRC('48') )
			& if( rc.rc9E, rc.makeRC('9E') )
			& if( rc.rcFQ, rc.makeRC('FQ') )
			& if( rc.rcFR, rc.makeRC('FR') )
			& if( rc.rc99, rc.makeRC('99') )
			// & if( rc.rc9K, rc.makeRC('9K') )
			& if( le.shell_input.addr_type = 'H', rc.makeRC('9K') )
			& if( rc.rc9F, rc.makeRC('9F') )
			& if( rc.rc9A, rc.makeRC('9A') )
			& if( rc.rc9B, rc.makeRC('9B') )
			& if( rc.rc06, rc.makeRC('06') )
			& if( rc.rc51, rc.makeRC('51') )
			& if( rc.rc71, rc.makeRC('71') )
			& if( rc.rc72, rc.makeRC('72') )
			& if( rc.rc39, rc.makeRC('39') )
			& if( rc.rcMI, rc.makeRC('MI') )
			& if( rc.rc38, rc.makeRC('38') )
			& if( rc.rcMS, rc.makeRC('MS') )
			& if( rc.rc89, rc.makeRC('89') )
			& if( rc.rcMN, rc.makeRC('MN') )
			& if( rc.rc52, rc.makeRC('52') )
			& if( rc.rc14, rc.makeRC('14') )
			& if( rc.rc11, rc.makeRC('11') )
			& if( rc.rc12, rc.makeRC('12') )
			& if( rc.rc40, rc.makeRC('40') )
			& if( rc.rc13, rc.makeRC('13') )
			& if( rc.rc85, rc.makeRC('85') )
			& if( rc.rc90, rc.makeRC('90') )
			& if( rc.rc9G, rc.makeRC('9G') )
			& if( rc.rc9D, rc.makeRC('9D') )
			& if( rc.rc9J, rc.makeRC('9J') )
			& if( rc.rc9C, rc.makeRC('9C') )
			& if( rc.rcFB, rc.makeRC('FB') )
			// & if( rc.rc9O, rc.makeRC('9O') )
			& if( le.velocity_counters.phones_per_addr = 0, rc.makeRC('9O') )
			// & if( rc.rc9M, rc.makeRC('9M') )
			& if( (integer1)le.wealth_indicator <= 2, rc.makeRC('9M') )
			& if( rc.rc9I, rc.makeRC('9I') )
			& if( rc.rcPV, rc.makeRC('PV') )
			& if( rc.rc29, rc.makeRC('29') )
			& if( rc.rc30, rc.makeRC('30') )
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
			& rc.makeRC('00')
		;

		self.ri := choosen( reasons, 4 );
	END;

	model := JOIN(clam, EASI.Key_Easi_Census, 
			KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
			doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1));

	return model;
	
END;


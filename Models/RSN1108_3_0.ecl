import risk_indicators, ut, riskwise, easi, std;

export RSN1108_3_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION
	RSN_DEBUG := false;

	#if(RSN_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String adl_category;
			String in_state;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_decsflag;
			String rc_pwssnvalflag;
			String rc_ssnstate;
			String rc_bansflag;
			Integer rc_addrcount;
			Integer combo_dobscore;
			qstring100 ver_sources;
			qstring200 ver_sources_first_seen;
			qstring200 ver_sources_last_seen;
			qstring100 bus_addr_sources;
			qstring100 bus_addr_sources_count;
			Integer source_count;
			Integer age;
			Integer util_adl_count;
			Integer add1_avm_automated_valuation;
			Integer add1_naprop;
			Integer ADD1_PURCHASE_AMOUNT;
			Integer add1_nhood_avg_purchase_amount;
			Integer add1_nhood_avg_assessed_amount;
			Integer property_owned_total;
			Integer property_sold_total;
			Boolean addrs_prison_history;
			Integer hist_addr_match;
			String gong_did_last_seen;
			Integer ssns_per_adl;
			Integer ssns_per_adl_c6;
			Integer invalid_ssns_per_adl;
			Integer inq_count03;
			Integer inq_count06;
			Integer inq_count24;
			Integer inq_collection_count12;
			Integer inq_highriskcredit_count;
			Integer inq_ssnsperadl;
			Integer inq_addrsperadl;
			Integer inq_lnamesperadl;
			Integer inq_fnamesperadl;
			Integer inq_phonesperadl;
			Integer inq_dobsperadl;
			Integer inq_adlsperssn;
			Integer inq_lnamesperssn;
			Integer inq_addrsperssn;
			Integer inq_dobsperssn;
			Integer paw_business_count;
			Integer impulse_count;
			qstring50 email_source_list;
			Integer attr_addrs_last36;
			Integer attr_eviction_count12;
			Boolean Bankrupt;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_cj_last_seen;
			Integer liens_rel_cj_ct;
			Integer criminal_count;
			Integer felony_count;
			Boolean foreclosure_flag;
			Integer rel_criminal_count;
			Integer current_count;
			Integer historical_count;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			Integer archive_date;
			String c_blue_empl;
			String c_span_lang;
			Integer sysdate;
			Integer ver_src_ds_pos;
			Boolean ver_src_ds_1;
			Integer ver_src_de_pos;
			Boolean ver_src_de_1;
			Integer ver_src_p_pos;
			String ver_src_fdate_p;
			Integer ver_src_fdate_p2;
			Real mth_ver_src_fdate_p;
			Integer ver_src_v_pos;
			Boolean ver_src_v;
			String ver_src_ldate_v;
			Integer ver_src_ldate_v2;
			Real mth_ver_src_ldate_v;
			Integer ver_src_wp_pos;
			String ver_src_ldate_wp;
			Integer ver_src_ldate_wp2;
			Real mth_ver_src_ldate_wp;
			Integer bus_addr_src_br_pos;
			Real bus_addr_src_cnt_br;
			Integer j_c_spanish;
			Real j_c_spanish_m;
			Real j_c_span_lang_c;
			Integer j_addrs_last36m_9;
			Real j_addrs_last36m_9_m;
			Integer liens_unrel_cj_last_seen2;
			Real mth_liens_unrel_cj_last_seen;
			Integer j_cj_lien_lvl_c156;
			Integer j_cj_lien_lvl_c157;
			Integer j_cj_lien_lvl;
			Real j_cj_lien_lvl_m;
			Integer j_historic_addr_match;
			Real j_historic_addr_match_m;
			Boolean ssn_issued18;
			Boolean ssn_statediff;
			Boolean ssn_adl_prob;
			Integer j_ssn_probs_v2;
			Real j_ssn_probs_v2_m;
			Integer j_input_nhood_growth;
			Integer j_input_home_growth;
			Integer j_input_area_growth;
			Real j_input_area_growth_m;
			Integer j_rc_addrcount_6;
			Real j_rc_addrcount_6_m;
			Integer j_prop_1st_seen;
			Real j_prop_1st_seen_m;
			Integer inq_max_peradl;
			Integer inq_max_perssn;
			Boolean j_inqelement_bad;
			Integer j_inq_lvl;
			Real j_inq_lvl_m;
			Integer j_util_adl_count;
			Real j_util_adl_count_m;
			Integer j_recent_vehicle_hit;
			Real j_recent_vehicle_hit_m;
			Boolean Impulse_Email;
			Boolean ver_src_fr;
			Integer j_derog_severity_v2;
			Real j_derog_severity_v2_m;
			Integer j_paw_bus_ct_3;
			Real j_paw_bus_ct_3_m;
			Integer gong_did_last_seen2;
			Real mth_gong_did_last_seen;
			Integer j_recent_phn_hit;
			Real j_recent_phn_hit_m;
			Boolean j_dead;
			Boolean j_c_blue_empl_lt40pct;
			Integer j_src_confirm_name;
			Real j_src_confirm_name_m;
			Integer j_criminal_relative_4;
			Real j_criminal_relative_4_m;
			Real j_busreg_ct_2;
			Real j_busreg_ct_2_m;
			Integer j_prop_ct_lvl;
			Real j_prop_ct_lvl_m;
			Integer j_inq_coll_ct12_4;
			Real j_inq_coll_ct12_4_m;
			Real lb_age;
			Integer j_age_lvl;
			Real j_age_lvl_m;
			Real b_job;
			Integer Base;
			Real odds;
			Integer point;
			Real phat;
			Integer custom40_mod;
			Integer rsn1108_3_1;
			Boolean ver_src_l2;
			Boolean ver_src_li;
			Boolean ver_src_ba;
			Boolean ver_src_ds;
			Boolean ver_src_de;
			Boolean lien_flag;
			Boolean bk_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Integer rsn1108_3;
			Models.Layout_RecoverScore;
		end;
		layout_debug doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#else
		Models.Layout_RecoverScore doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#end
	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	in_state                         := le.shell_input.in_state;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnstate                      := le.iid.soclstate;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	bus_addr_sources                 := le.business_header_address_summary.bus_sources;
	bus_addr_sources_count           := le.business_header_address_summary.bus_sources_record_cnt;
	source_count                     := le.name_verification.source_count;
	age                              := le.name_verification.age;
	util_adl_count                   := le.utility.utili_adl_count;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_nhood_avg_purchase_amount   := le.addr_risk_summary.n_ave_purchase_amount;
	add1_nhood_avg_assessed_amount   := le.addr_risk_summary.n_ave_assessed_amount;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_prison_history             := le.other_address_info.isprison;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	inq_adlsperssn                   := le.acc_logs.inquiryadlsperssn;
	inq_lnamesperssn                 := le.acc_logs.inquirylnamesperssn;
	inq_addrsperssn                  := le.acc_logs.inquiryaddrsperssn;
	inq_dobsperssn                   := le.acc_logs.inquirydobsperssn;
	paw_business_count               := le.employment.business_ct;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_eviction_count12            := le.bjl.eviction_count12;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	foreclosure_flag                 := le.bjl.foreclosure_flag;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	archive_date                     := le.historydate;
	C_BLUE_EMPL                      := trim(ri.blue_empl);
	C_SPAN_LANG                      := trim(ri.span_lang);


NULL := -999999999;

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));


sysdate := map(
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);

ver_src_ds_pos := models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

ver_src_ds_1 := ver_src_ds_pos > 0;

ver_src_de_pos := models.common.findw_cpp(ver_sources, 'DE' , ' ,', 'ie');

ver_src_de_1 := ver_src_de_pos > 0;

ver_src_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

ver_src_fdate_p := if(ver_src_p_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p2 := models.common.sas_date((string)(ver_src_fdate_p));

mth_ver_src_fdate_p := if(min(sysdate, ver_src_fdate_p2) = NULL, NULL, (sysdate - ver_src_fdate_p2) / 30.5);

ver_src_v_pos := models.common.findw_cpp(ver_sources, 'V' , ' ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

ver_src_ldate_v := if(ver_src_v_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_v_pos), '0');

ver_src_ldate_v2 := models.common.sas_date((string)(ver_src_ldate_v));

mth_ver_src_ldate_v := if(min(sysdate, ver_src_ldate_v2) = NULL, NULL, (sysdate - ver_src_ldate_v2) / 30.5);

ver_src_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

ver_src_ldate_wp := if(ver_src_wp_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

ver_src_ldate_wp2 := models.common.sas_date((string)(ver_src_ldate_wp));

mth_ver_src_ldate_wp := if(min(sysdate, ver_src_ldate_wp2) = NULL, NULL, (sysdate - ver_src_ldate_wp2) / 30.5);

bus_addr_src_br_pos := models.common.findw_cpp(bus_addr_sources, 'BR' , ' ,', 'ie');

bus_addr_src_cnt_br := if(bus_addr_src_br_pos > 0, (real)models.common.getw(bus_addr_sources_count, bus_addr_src_br_pos), 0);

j_c_spanish := map(
    C_SPAN_LANG = ''        => 140,
    (real)C_SPAN_LANG < 80  => 80,
    (real)C_SPAN_LANG < 100 => 100,
    (real)C_SPAN_LANG < 120 => 120,
    (real)C_SPAN_LANG < 130 => 130,
    (real)C_SPAN_LANG < 140 => 140,
    (real)C_SPAN_LANG < 160 => 160,
    (real)C_SPAN_LANG < 190 => 190,
                               191);

j_c_spanish_m := map(
    j_c_spanish = 80  => 0.5221505376,
    j_c_spanish = 100 => 0.4823773324,
    j_c_spanish = 120 => 0.4542102028,
    j_c_spanish = 130 => 0.4477434679,
    j_c_spanish = 140 => 0.4386951631,
    j_c_spanish = 160 => 0.4154370034,
    j_c_spanish = 190 => 0.3803139307,
    j_c_spanish = 191 => 0.3653846154,
                         0.4509957558);

j_c_span_lang_c := if(C_SPAN_LANG = '', 100, max(min((real)C_SPAN_LANG, 200), 25));

j_addrs_last36m_9 := max(min(if(attr_addrs_last36 = NULL, -NULL, attr_addrs_last36), 9), 1);

j_addrs_last36m_9_m := map(
    j_addrs_last36m_9 = 1 => 0.4998527246,
    j_addrs_last36m_9 = 2 => 0.4756176853,
    j_addrs_last36m_9 = 3 => 0.4559494559,
    j_addrs_last36m_9 = 4 => 0.4294727355,
    j_addrs_last36m_9 = 5 => 0.41692988,
    j_addrs_last36m_9 = 6 => 0.4100502513,
    j_addrs_last36m_9 = 7 => 0.3993288591,
    j_addrs_last36m_9 = 8 => 0.3220858896,
    j_addrs_last36m_9 = 9 => 0.3043478261,
                             0.4509957558);

liens_unrel_cj_last_seen2 := models.common.sas_date((string)(liens_unrel_cj_last_seen));

mth_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

j_cj_lien_lvl_c156 := if(mth_liens_unrel_cj_last_seen > 6, 0, 1);

j_cj_lien_lvl_c157 := map(
    mth_liens_unrel_cj_last_seen = NULL => 2,
    mth_liens_unrel_cj_last_seen <= 3   => 5,
    mth_liens_unrel_cj_last_seen <= 6   => 4,
    mth_liens_unrel_cj_last_seen <= 12  => 3,
                                           2);

j_cj_lien_lvl := if(liens_rel_cj_ct > 0, j_cj_lien_lvl_c156, j_cj_lien_lvl_c157);

j_cj_lien_lvl_m := map(
    j_cj_lien_lvl = 0 => 0.5471698113,
    j_cj_lien_lvl = 1 => 0.50243309,
    j_cj_lien_lvl = 2 => 0.4522238409,
    j_cj_lien_lvl = 3 => 0.3954545455,
    j_cj_lien_lvl = 4 => 0.3574380165,
    j_cj_lien_lvl = 5 => 0.3447251114,
                         0.4509957558);

j_historic_addr_match := if(hist_addr_match < 0, 3, min(if(hist_addr_match = NULL, -NULL, hist_addr_match), 3));

j_historic_addr_match_m := map(
    j_historic_addr_match = 0 => 0.3736702128,
    j_historic_addr_match = 1 => 0.5058665128,
    j_historic_addr_match = 2 => 0.4519061584,
    j_historic_addr_match = 3 => 0.4123278468,
                                 0.4509957558);

ssn_issued18 := (real)rc_pwssnvalflag = 5;

ssn_statediff := StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT));

ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2 or invalid_ssns_per_adl > 0;

j_ssn_probs_v2 := map(
    ssn_issued18 AND ssn_adl_prob AND ssn_statediff       => 4,
    (ssn_issued18 OR ssn_adl_prob) AND NOT(ssn_statediff) => 3,
    ssn_issued18 OR ssn_adl_prob                          => 2,
    ssn_statediff                                         => 1,
                                                           0);

j_ssn_probs_v2_m := map(
    j_ssn_probs_v2 = 0 => 0.4805998572,
    j_ssn_probs_v2 = 1 => 0.4549356223,
    j_ssn_probs_v2 = 2 => 0.3992740472,
    j_ssn_probs_v2 = 3 => 0.3770152956,
    j_ssn_probs_v2 = 4 => 0.2538461538,
                          0.4509957558);

j_input_nhood_growth := map(
    add1_Nhood_avg_assessed_amount <= 0 OR add1_Nhood_avg_purchase_amount <= 0 => -1,
    add1_Nhood_avg_assessed_amount >= add1_Nhood_avg_purchase_amount           => 1,
                                                                                  0);

j_input_home_growth := map(
    add1_avm_automated_valuation <= 0 OR add1_purchase_amount <= 0 => -1,
    add1_avm_automated_valuation >= add1_purchase_amount           => 1,
                                                                      0);

j_input_area_growth := map(
    j_input_nhood_growth = -1                             => -1,
    j_input_nhood_growth = 1 AND j_input_home_growth = 1  => 4,
    j_input_home_growth = 1                               => 3,
    j_input_nhood_growth = 1 AND j_input_home_growth = -1 => 2,
    j_input_home_growth = -1                              => 1,
                                                             0);

j_input_area_growth_m := map(
    j_input_area_growth = -1 => 0.3853929745,
    j_input_area_growth = 0  => 0.4547738693,
    j_input_area_growth = 1  => 0.4608104829,
    j_input_area_growth = 2  => 0.4771208226,
    j_input_area_growth = 3  => 0.4886363636,
    j_input_area_growth = 4  => 0.5306748466,
                                0.4509957558);

j_rc_addrcount_6 := min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 6);

j_rc_addrcount_6_m := map(
    j_rc_addrcount_6 = 0 => 0.3636363636,
    j_rc_addrcount_6 = 1 => 0.381294964,
    j_rc_addrcount_6 = 2 => 0.4068965517,
    j_rc_addrcount_6 = 3 => 0.4488821904,
    j_rc_addrcount_6 = 4 => 0.4792312461,
    j_rc_addrcount_6 = 5 => 0.484073107,
    j_rc_addrcount_6 = 6 => 0.5340829234,
                            0.4509957558);

j_prop_1st_seen := map(
    mth_ver_src_fdate_p = NULL => -1,
    mth_ver_src_fdate_p <= 24  => 0,
    mth_ver_src_fdate_p <= 48  => 1,
    mth_ver_src_fdate_p <= 120 => 2,
                                  3);

j_prop_1st_seen_m := map(
    j_prop_1st_seen = -1 => 0.4585507742,
    j_prop_1st_seen = 0  => 0.6102941176,
    j_prop_1st_seen = 1  => 0.4845679012,
    j_prop_1st_seen = 2  => 0.4220125786,
    j_prop_1st_seen = 3  => 0.3840277778,
                            0.4509957558);

inq_max_peradl := max(Inq_SSNsPerADL, Inq_AddrsPerADL, Inq_LnamesPerADL, Inq_FnamesPerADL, Inq_PhonesPerADL, Inq_DOBsPerADL);

inq_max_perssn := max(Inq_ADLsPerSSN, Inq_AddrsPerSSN, Inq_LnamesPerSSN, Inq_DOBsPerSSN);

j_inqelement_bad := inq_max_peradl = 0 AND inq_max_perssn > 0 OR inq_max_peradl > 0 AND inq_max_perssn = 0 OR inq_max_peradl > 2 OR inq_max_perssn > 2;

j_inq_lvl := map(
    j_INQelement_bad => 4,
    Inq_count03 > 0  => 3,
    Inq_count06 > 0  => 2,
    Inq_count24 > 0  => 1,
                        0);

j_inq_lvl_m := map(
    j_inq_lvl = 0 => 0.5009304057,
    j_inq_lvl = 1 => 0.4692280946,
    j_inq_lvl = 2 => 0.43,
    j_inq_lvl = 3 => 0.419158361,
    j_inq_lvl = 4 => 0.372406639,
                     0.4509957558);

j_util_adl_count := map(
    util_adl_count > 7 => 8,
    util_adl_count > 4 => 5,
    util_adl_count > 2 => 3,
                          util_adl_count);

j_util_adl_count_m := map(
    j_util_adl_count = 0 => 0.4951379763,
    j_util_adl_count = 1 => 0.4825106244,
    j_util_adl_count = 2 => 0.4441295547,
    j_util_adl_count = 3 => 0.4299191375,
    j_util_adl_count = 5 => 0.4061998931,
    j_util_adl_count = 8 => 0.3625218914,
                            0.4509957558);

j_recent_vehicle_hit := map(
    mth_ver_src_ldate_v = 0                   => 3,
    (integer)ver_src_v = 1                    => 2,
    current_count > 0 OR historical_count > 0 => 1,
                                                 0);

j_recent_vehicle_hit_m := map(
    j_recent_vehicle_hit = 0 => 0.4124004551,
    j_recent_vehicle_hit = 1 => 0.4485234511,
    j_recent_vehicle_hit = 2 => 0.4748753356,
    j_recent_vehicle_hit = 3 => 0.6211849192,
                                0.4509957558);

impulse_email := (integer)indexw(StringLib.StringToUpperCase(trim(email_source_list, ALL)), 'IM', ',') > 0;

ver_src_fr := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'FR', ',') > 0;

j_derog_severity_v2 := map(
    (integer)ver_src_fr > 0 or (integer)foreclosure_flag > 0                                   => 0,
    felony_count > 0                                                                           => 1,
    attr_eviction_count12 > 1 OR (integer)addrs_prison_history > 0                             => 2,
    criminal_count > 0 OR impulse_email OR Inq_HighRiskCredit_count > 1                        => 3,
    attr_eviction_count12 > 0 OR Inq_HighRiskCredit_count > 0 OR impulse_count > 0 OR bankrupt => 4,
                                                                                                  5);

j_derog_severity_v2_m := map(
    j_derog_severity_v2 = 0 => 0.3176895307,
    j_derog_severity_v2 = 1 => 0.3529411765,
    j_derog_severity_v2 = 2 => 0.3831168831,
    j_derog_severity_v2 = 3 => 0.4237623762,
    j_derog_severity_v2 = 4 => 0.4388327722,
    j_derog_severity_v2 = 5 => 0.4645500758,
                               0.4509957558);

j_paw_bus_ct_3 := min(if(PAW_Business_count = NULL, -NULL, PAW_Business_count), 3);

j_paw_bus_ct_3_m := map(
    j_paw_bus_ct_3 = 0 => 0.4615246152,
    j_paw_bus_ct_3 = 1 => 0.4518760196,
    j_paw_bus_ct_3 = 2 => 0.3674588665,
    j_paw_bus_ct_3 = 3 => 0.3260135135,
                          0.4509957558);

gong_did_last_seen2 := models.common.sas_date((string)(gong_did_last_seen));

mth_gong_did_last_seen := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, (sysdate - gong_did_last_seen2) / 30.5);

j_recent_phn_hit := map(
    mth_ver_src_ldate_wp = 0 AND mth_gong_did_last_seen = 0 => 2,
    mth_ver_src_ldate_wp = 0 OR mth_gong_did_last_seen = 0  => 1,
                                                               0);

j_recent_phn_hit_m := map(
    j_recent_phn_hit = 0 => 0.4393335106,
    j_recent_phn_hit = 1 => 0.4720633524,
    j_recent_phn_hit = 2 => 0.4985787379,
                            0.4509957558);

j_dead := (integer)ver_src_ds_1 > 0 OR (integer)ver_src_de_1 > 0 OR adl_category = '1 DEAD' OR (real)rc_decsflag = 1;

j_c_blue_empl_lt40pct := C_BLUE_EMPL != '' AND (real)C_BLUE_EMPL <= 40;

j_src_confirm_name := map(
    source_count <= 2 => 0,
    source_count <= 3 => 1,
    source_count <= 5 => 2,
    source_count <= 7 => 3,
                         4);

j_src_confirm_name_m := map(
    j_src_confirm_name = 0 => 0.3347826087,
    j_src_confirm_name = 1 => 0.3760869565,
    j_src_confirm_name = 2 => 0.4252177206,
    j_src_confirm_name = 3 => 0.44453328,
    j_src_confirm_name = 4 => 0.4741441054,
                              0.4509957558);

j_criminal_relative_4 := min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 4);

j_criminal_relative_4_m := map(
    j_criminal_relative_4 = 0 => 0.4657553957,
    j_criminal_relative_4 = 1 => 0.46069869,
    j_criminal_relative_4 = 2 => 0.4462193823,
    j_criminal_relative_4 = 3 => 0.4394661582,
    j_criminal_relative_4 = 4 => 0.385005637,
                                 0.4509957558);

j_busreg_ct_2 := min(if(bus_addr_src_cnt_br = NULL, -NULL, bus_addr_src_cnt_br), 2);

j_busreg_ct_2_m := map(
    j_busreg_ct_2 = 0 => 0.4577375053,
    j_busreg_ct_2 = 1 => 0.3949044586,
    j_busreg_ct_2 = 2 => 0.3242574257,
                         0.4509957558);

j_prop_ct_lvl := map(
    property_owned_total = 1 AND property_sold_total = 0 => 0,
    property_owned_total = 0 AND property_sold_total = 0 => 1,
    property_owned_total = 0 AND property_sold_total = 1 => 2,
                                                            3);

j_prop_ct_lvl_m := map(
    j_prop_ct_lvl = 0 => 0.4762931034,
    j_prop_ct_lvl = 1 => 0.4655843058,
    j_prop_ct_lvl = 2 => 0.3946459413,
    j_prop_ct_lvl = 3 => 0.3578047042,
                         0.4509957558);

j_inq_coll_ct12_4 := min(if(Inq_Collection_count12 = NULL, -NULL, Inq_Collection_count12), 4);

j_inq_coll_ct12_4_m := map(
    j_inq_coll_ct12_4 = 0 => 0.4718979093,
    j_inq_coll_ct12_4 = 1 => 0.4626448262,
    j_inq_coll_ct12_4 = 2 => 0.4490291262,
    j_inq_coll_ct12_4 = 3 => 0.4187956204,
    j_inq_coll_ct12_4 = 4 => 0.3974833457,
                             0.4509957558);

lb_age := map(
    age > 0                 => age,
    (real)input_dob_age > 0 => (real)input_dob_age,
    inferred_age > 0        => inferred_age,
                               -1);

j_age_lvl := map(
    lb_age <= 58 => 0,
    lb_age <= 63 => 1,
                    2);

j_age_lvl_m := map(
    j_age_lvl = 0 => 0.4555516637,
    j_age_lvl = 1 => 0.4047244094,
    j_age_lvl = 2 => 0.362962963,
                     0.4509957558);

b_job := -21.83827784 +
    j_c_spanish_m * 1.4892887712 +
    j_c_span_lang_c * -0.001038143 +
    j_cj_lien_lvl_m * 4.217981403 +
    j_age_lvl_m * 2.6365221207 +
    j_rc_addrcount_6_m * 1.5040668743 +
    j_src_confirm_name_m * 2.9637958551 +
    (integer)j_c_blue_empl_lt40pct * -0.171367393 +
    j_recent_phn_hit_m * 3.3544766571 +
    j_ssn_probs_v2_m * 2.5058772315 +
    j_historic_addr_match_m * 3.1333266992 +
    j_inq_coll_ct12_4_m * 1.9184354451 +
    j_inq_lvl_m * 1.8226993648 +
    j_paw_bus_ct_3_m * 2.2675659424 +
    j_util_adl_count_m * 2.3617861645 +
    j_busreg_ct_2_m * 2.3416891971 +
    j_prop_ct_lvl_m * 1.7429412216 +
    j_addrs_last36m_9_m * 1.9599015939 +
    j_derog_severity_v2_m * 2.4627121769 +
    j_input_area_growth_m * 3.0549935686 +
    (integer)j_dead * -0.529816898 +
    j_prop_1st_seen_m * 1.9794006002 +
    j_recent_vehicle_hit_m * 2.080967276 +
    j_criminal_relative_4_m * 2.4965639692;

base := 700;

odds := 0.4268 / (1 - 0.4268);

point := 40;

phat := exp(b_job) / (1 + exp(b_job));

custom40_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

rsn1108_3_1 := round(min(if(max(custom40_mod, 501) = NULL, -NULL, max(custom40_mod, 501)), 900));

ver_src_l2 := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0;

ver_src_li := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0;

ver_src_ba := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0;

ver_src_ds := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

ver_src_de := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

ssn_deceased := (integer)ver_src_ds > 0 OR (integer)ver_src_de > 0 OR adl_category = '1 DEAD' OR (real)rc_decsflag = 1;

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (real)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

rsn1108_3 := if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 AND not(scored_222s), 222, rsn1108_3_1);



		#if(RSN_DEBUG)
			self.clam                            := le;
			self.truedid                         := truedid;
			self.adl_category                    := adl_category;
			self.in_state                        := in_state;
			self.nas_summary                     := nas_summary;
			self.nap_summary                     := nap_summary;
			self.rc_decsflag                     := rc_decsflag;
			self.rc_pwssnvalflag                 := rc_pwssnvalflag;
			self.rc_ssnstate                     := rc_ssnstate;
			self.rc_bansflag                     := rc_bansflag;
			self.rc_addrcount                    := rc_addrcount;
			self.combo_dobscore                  := combo_dobscore;
			self.ver_sources                     := ver_sources;
			self.ver_sources_first_seen          := ver_sources_first_seen;
			self.ver_sources_last_seen           := ver_sources_last_seen;
			self.bus_addr_sources                := bus_addr_sources;
			self.bus_addr_sources_count          := bus_addr_sources_count;
			self.source_count                    := source_count;
			self.age                             := age;
			self.util_adl_count                  := util_adl_count;
			self.add1_avm_automated_valuation    := add1_avm_automated_valuation;
			self.add1_naprop                     := add1_naprop;
			self.add1_purchase_amount            := add1_purchase_amount;
			self.add1_nhood_avg_purchase_amount  := add1_nhood_avg_purchase_amount;
			self.add1_nhood_avg_assessed_amount  := add1_nhood_avg_assessed_amount;
			self.property_owned_total            := property_owned_total;
			self.property_sold_total             := property_sold_total;
			self.addrs_prison_history            := addrs_prison_history;
			self.hist_addr_match                 := hist_addr_match;
			self.gong_did_last_seen              := gong_did_last_seen;
			self.ssns_per_adl                    := ssns_per_adl;
			self.ssns_per_adl_c6                 := ssns_per_adl_c6;
			self.invalid_ssns_per_adl            := invalid_ssns_per_adl;
			self.inq_count03                     := inq_count03;
			self.inq_count06                     := inq_count06;
			self.inq_count24                     := inq_count24;
			self.inq_collection_count12          := inq_collection_count12;
			self.inq_highriskcredit_count        := inq_highriskcredit_count;
			self.inq_ssnsperadl                  := inq_ssnsperadl;
			self.inq_addrsperadl                 := inq_addrsperadl;
			self.inq_lnamesperadl                := inq_lnamesperadl;
			self.inq_fnamesperadl                := inq_fnamesperadl;
			self.inq_phonesperadl                := inq_phonesperadl;
			self.inq_dobsperadl                  := inq_dobsperadl;
			self.inq_adlsperssn                  := inq_adlsperssn;
			self.inq_lnamesperssn                := inq_lnamesperssn;
			self.inq_addrsperssn                 := inq_addrsperssn;
			self.inq_dobsperssn                  := inq_dobsperssn;
			self.paw_business_count              := paw_business_count;
			self.impulse_count                   := impulse_count;
			self.email_source_list               := email_source_list;
			self.attr_addrs_last36               := attr_addrs_last36;
			self.attr_eviction_count12           := attr_eviction_count12;
			self.bankrupt                        := bankrupt;
			self.filing_count                    := filing_count;
			self.bk_recent_count                 := bk_recent_count;
			self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
			self.liens_unrel_cj_last_seen        := liens_unrel_cj_last_seen;
			self.liens_rel_cj_ct                 := liens_rel_cj_ct;
			self.criminal_count                  := criminal_count;
			self.felony_count                    := felony_count;
			self.foreclosure_flag                := foreclosure_flag;
			self.rel_criminal_count              := rel_criminal_count;
			self.current_count                   := current_count;
			self.historical_count                := historical_count;
			self.input_dob_age                   := input_dob_age;
			self.input_dob_match_level           := input_dob_match_level;
			self.inferred_age                    := inferred_age;
			self.archive_date                    := archive_date;
			self.C_BLUE_EMPL                     := C_BLUE_EMPL;
			self.C_SPAN_LANG                     := C_SPAN_LANG;
			self.sysdate                         := sysdate;
			self.ver_src_ds_pos                  := ver_src_ds_pos;
			self.ver_src_ds_1                    := ver_src_ds_1;
			self.ver_src_de_pos                  := ver_src_de_pos;
			self.ver_src_de_1                    := ver_src_de_1;
			self.ver_src_p_pos                   := ver_src_p_pos;
			self.ver_src_fdate_p                 := ver_src_fdate_p;
			self.ver_src_fdate_p2                := ver_src_fdate_p2;
			self.mth_ver_src_fdate_p             := mth_ver_src_fdate_p;
			self.ver_src_v_pos                   := ver_src_v_pos;
			self.ver_src_v                       := ver_src_v;
			self.ver_src_ldate_v                 := ver_src_ldate_v;
			self.ver_src_ldate_v2                := ver_src_ldate_v2;
			self.mth_ver_src_ldate_v             := mth_ver_src_ldate_v;
			self.ver_src_wp_pos                  := ver_src_wp_pos;
			self.ver_src_ldate_wp                := ver_src_ldate_wp;
			self.ver_src_ldate_wp2               := ver_src_ldate_wp2;
			self.mth_ver_src_ldate_wp            := mth_ver_src_ldate_wp;
			self.bus_addr_src_br_pos             := bus_addr_src_br_pos;
			self.bus_addr_src_cnt_br             := bus_addr_src_cnt_br;
			self.j_c_spanish                     := j_c_spanish;
			self.j_c_spanish_m                   := j_c_spanish_m;
			self.j_c_span_lang_c                 := j_c_span_lang_c;
			self.j_addrs_last36m_9               := j_addrs_last36m_9;
			self.j_addrs_last36m_9_m             := j_addrs_last36m_9_m;
			self.liens_unrel_cj_last_seen2       := liens_unrel_cj_last_seen2;
			self.mth_liens_unrel_cj_last_seen    := mth_liens_unrel_cj_last_seen;
			self.j_cj_lien_lvl_c156              := j_cj_lien_lvl_c156;
			self.j_cj_lien_lvl_c157              := j_cj_lien_lvl_c157;
			self.j_cj_lien_lvl                   := j_cj_lien_lvl;
			self.j_cj_lien_lvl_m                 := j_cj_lien_lvl_m;
			self.j_historic_addr_match           := j_historic_addr_match;
			self.j_historic_addr_match_m         := j_historic_addr_match_m;
			self.ssn_issued18                    := ssn_issued18;
			self.ssn_statediff                   := ssn_statediff;
			self.ssn_adl_prob                    := ssn_adl_prob;
			self.j_ssn_probs_v2                  := j_ssn_probs_v2;
			self.j_ssn_probs_v2_m                := j_ssn_probs_v2_m;
			self.j_input_nhood_growth            := j_input_nhood_growth;
			self.j_input_home_growth             := j_input_home_growth;
			self.j_input_area_growth             := j_input_area_growth;
			self.j_input_area_growth_m           := j_input_area_growth_m;
			self.j_rc_addrcount_6                := j_rc_addrcount_6;
			self.j_rc_addrcount_6_m              := j_rc_addrcount_6_m;
			self.j_prop_1st_seen                 := j_prop_1st_seen;
			self.j_prop_1st_seen_m               := j_prop_1st_seen_m;
			self.inq_max_peradl                  := inq_max_peradl;
			self.inq_max_perssn                  := inq_max_perssn;
			self.j_inqelement_bad                := j_inqelement_bad;
			self.j_inq_lvl                       := j_inq_lvl;
			self.j_inq_lvl_m                     := j_inq_lvl_m;
			self.j_util_adl_count                := j_util_adl_count;
			self.j_util_adl_count_m              := j_util_adl_count_m;
			self.j_recent_vehicle_hit            := j_recent_vehicle_hit;
			self.j_recent_vehicle_hit_m          := j_recent_vehicle_hit_m;
			self.impulse_email                   := impulse_email;
			self.ver_src_fr                      := ver_src_fr;
			self.j_derog_severity_v2             := j_derog_severity_v2;
			self.j_derog_severity_v2_m           := j_derog_severity_v2_m;
			self.j_paw_bus_ct_3                  := j_paw_bus_ct_3;
			self.j_paw_bus_ct_3_m                := j_paw_bus_ct_3_m;
			self.gong_did_last_seen2             := gong_did_last_seen2;
			self.mth_gong_did_last_seen          := mth_gong_did_last_seen;
			self.j_recent_phn_hit                := j_recent_phn_hit;
			self.j_recent_phn_hit_m              := j_recent_phn_hit_m;
			self.j_dead                          := j_dead;
			self.j_c_blue_empl_lt40pct           := j_c_blue_empl_lt40pct;
			self.j_src_confirm_name              := j_src_confirm_name;
			self.j_src_confirm_name_m            := j_src_confirm_name_m;
			self.j_criminal_relative_4           := j_criminal_relative_4;
			self.j_criminal_relative_4_m         := j_criminal_relative_4_m;
			self.j_busreg_ct_2                   := j_busreg_ct_2;
			self.j_busreg_ct_2_m                 := j_busreg_ct_2_m;
			self.j_prop_ct_lvl                   := j_prop_ct_lvl;
			self.j_prop_ct_lvl_m                 := j_prop_ct_lvl_m;
			self.j_inq_coll_ct12_4               := j_inq_coll_ct12_4;
			self.j_inq_coll_ct12_4_m             := j_inq_coll_ct12_4_m;
			self.lb_age                          := lb_age;
			self.j_age_lvl                       := j_age_lvl;
			self.j_age_lvl_m                     := j_age_lvl_m;
			self.b_job                           := b_job;
			self.base                            := base;
			self.odds                            := odds;
			self.point                           := point;
			self.phat                            := phat;
			self.custom40_mod                    := custom40_mod;
			self.rsn1108_3_1                     := rsn1108_3_1;
			self.ver_src_l2                      := ver_src_l2;
			self.ver_src_li                      := ver_src_li;
			self.ver_src_ba                      := ver_src_ba;
			self.ver_src_ds                      := ver_src_ds;
			self.ver_src_de                      := ver_src_de;
			self.lien_flag                       := lien_flag;
			self.bk_flag                         := bk_flag;
			self.ssn_deceased                    := ssn_deceased;
			self.scored_222s                     := scored_222s;
			self.rsn1108_3                       := rsn1108_3;
		#end

		self.seq := (string)le.seq;
		self.recover_score := (string)rsn1108_3;
	end;


	model := JOIN(clam, EASI.Key_Easi_Census, 
							KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
							doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.Max_Atmost), KEEP(1));

	RETURN(model);
END;

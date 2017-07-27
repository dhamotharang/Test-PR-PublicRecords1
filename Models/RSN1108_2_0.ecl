import risk_indicators, ut, riskwise, easi;

export RSN1108_2_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION
	RSN_DEBUG := false;

	#if(RSN_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String adl_category;
			Integer NAS_Summary;
			Integer NAP_Summary;
			Boolean rc_input_addr_not_most_recent;
			String rc_decsflag;
			String rc_pwssnvalflag;
			String rc_bansflag;
			Integer rc_lnamecount;
			Integer rc_addrcount;
			Integer rc_ssncount;
			Integer combo_dobscore;
			Integer combo_ssncount;
			qstring100 ver_sources;
			qstring200 ver_sources_first_seen;
			qstring200 ver_sources_last_seen;
			Integer bus_addr_match_count;
			qstring100 bus_addr_sources;
			Integer age;
			Boolean add1_house_number_match;
			Boolean add1_isbestmatch;
			String add1_advo_address_vacancy;
			String add1_advo_drop;
			String add1_advo_res_or_business;
			Integer add1_avm_automated_valuation;
			Integer add1_naprop;
			Integer add1_nhood_business_count;
			Integer add1_nhood_sfd_count;
			Integer add1_nhood_mfd_count;
			Integer add1_nhood_avg_purchase_amount;
			Integer add1_nhood_avg_assessed_amount;
			Integer property_owned_total;
			Integer property_sold_total;
			Boolean addrs_prison_history;
			String gong_did_last_seen;
			Integer ssns_per_adl;
			Integer addrs_per_ssn;
			Integer ssns_per_adl_c6;
			Integer inq_ssn_ver_count;
			Integer inq_count;
			Integer inq_count24;
			Integer inq_collection_count01;
			Integer inq_collection_count03;
			Integer inq_collection_count06;
			Integer inq_collection_count12;
			Integer inq_highriskcredit_count;
			Integer impulse_count;
			Integer email_count;
			qstring50 email_source_list;
			Integer attr_addrs_last36;
			Integer attr_felonies36;
			Integer attr_eviction_count;
			Integer attr_eviction_count36;
			Boolean Bankrupt;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_cj_ct;
			Integer liens_unrel_cj_last_seen;
			Integer liens_unrel_cj_total_amount;
			Integer liens_rel_cj_ct;
			Integer liens_rel_cj_last_seen;
			Integer liens_unrel_sc_ct;
			Integer liens_rel_sc_ct;
			Integer criminal_count;
			Integer criminal_last_date;
			Integer felony_count;
			Boolean foreclosure_flag;
			Integer rel_felony_count;
			Integer rel_incomeunder25_count;
			Integer current_count;
			Integer historical_count;
			String ams_class;
			String ams_college_code;
			String ams_college_type;
			String ams_income_level_code;
			String ams_file_type;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			Integer archive_date;
			String c_easiqlife;
			String c_robbery;
			String c_span_lang;
			Integer sysdate;
			Integer ver_src_en_pos;
			String ver_src_fdate_en;
			Integer ver_src_eq_pos;
			String ver_src_fdate_eq;
			Integer ver_src_p_pos;
			String ver_src_ldate_p;
			Integer ver_src_ldate_p2;
			Real mth_ver_src_ldate_p;
			Integer ver_src_v_pos;
			Boolean ver_src_v;
			Integer ver_src_wp_pos;
			String ver_src_ldate_wp;
			Integer ver_src_ldate_wp2;
			Real mth_ver_src_ldate_wp;
			Integer s0_c_spanish;
			Real s0_c_spanish_m;
			Real s0_c_span_lang_c;
			Integer s0_cj_lien_amt;
			Real s0_cj_lien_amt_m;
			Integer liens_unrel_cj_last_seen2;
			Real mth_liens_unrel_cj_last_seen;
			Integer s0_cj_lien_lvl_c116;
			Integer s0_cj_lien_lvl_c117;
			Integer s0_cj_lien_lvl;
			Real s0_cj_lien_lvl_m;
			Integer s0_src_confirm_addr;
			Real s0_src_confirm_addr_m;
			Integer s0_combo_src_confirm_ssn;
			Real s0_combo_src_confirm_ssn_m;
			Integer s0_input_probs;
			Real s0_input_probs_m;
			Integer s0_coll_recency;
			Real s0_coll_recency_m;
			Integer s0_inq_ssn_verx_v2;
			Real s0_inq_ssn_verx_v2_m;
			Boolean s0_c_gt_median_robbery;
			Boolean business_bk;
			Boolean business_lien;
			Integer s0_business_hdr_lvl;
			Real s0_business_hdr_lvl_m;
			Integer s0_recent_prop_hit;
			Real s0_recent_prop_hit_m;
			Integer ver_src_fdate_eq2;
			Real mth_ver_src_fdate_eq;
			Integer ver_src_fdate_en2;
			Real mth_ver_src_fdate_en;
			Real lb_mons_on_cb;
			Real lb_age_1;
			Real _age_fseen_cb;
			Integer s0_age_fstsn_on_cb;
			Real s0_age_fstsn_on_cb_m;
			Integer s0_vehicle_hit;
			Real s0_vehicle_hit_m;
			Integer criminal_last_date2_1;
			Real mth_criminal_last_date_1;
			Integer s0_criminal_history;
			Real s0_criminal_history_m;
			Boolean s0_nhood_growth;
			Integer lb_total_properties;
			Integer s0_nhood_num_properties;
			Real s0_nhood_num_properties_m;
			Integer s0_ssns_per_adl_lvl;
			Real s0_ssns_per_adl_lvl_m;
			Integer s0_rel_felony_count_2;
			Real s0_rel_felony_count_2_m;
			Integer s0_avm_lvl;
			Real s0_avm_lvl_m;
			Boolean Impulse_Email;
			Integer s0_derog_severity;
			Real s0_derog_severity_m;
			Integer s1_c_spanish;
			Real s1_c_spanish_m;
			Integer s1_c_span_lang_c;
			Real lb_age;
			Integer s1_age_lvl_v2;
			Real s1_age_lvl_v2_m;
			Integer criminal_last_date2;
			Real mth_criminal_last_date;
			Integer s1_criminal_felony_lvl;
			Real s1_criminal_felony_lvl_m;
			Integer s1_unrel_cj_lien_amt;
			Real s1_unrel_cj_lien_amt_m;
			Integer liens_rel_cj_last_seen2;
			Real mth_liens_rel_cj_last_seen;
			Integer s1_cj_lien_lvl;
			Real s1_cj_lien_lvl_m;
			Integer s1_sc_lien_lvl;
			Real s1_sc_lien_lvl_m;
			Boolean s1_inq_count24_7p;
			Integer s1_inq_ssn_verx_v2;
			Real s1_inq_ssn_verx_v2_m;
			Boolean s1_email_f;
			Boolean ams_flag;
			Integer s1_ams_lvl;
			Real s1_ams_lvl_m;
			Boolean s1_c_gt_median_robbery;
			Integer s1_c_qual_of_life;
			Real s1_c_qual_of_life_m;
			Boolean ssn_issued18;
			Integer s1_addrs_per_ssn;
			Real s1_addrs_per_ssn_m;
			Boolean s1_4p_rel_incomeunder25;
			Boolean s1_good_src_count;
			Boolean s1_4p_addrs_3yr;
			Boolean s1_recent_prop_hit;
			Boolean adl_dead;
			Integer gong_did_last_seen2;
			Real mth_gong_did_last_seen;
			Integer s1_recent_phone_hit;
			Real s1_recent_phone_hit_m;
			Integer s1_input_avm_lvl;
			Real s1_input_avm_lvl_m;
			Real s0_addr_match;
			Real s1_no_addr_match;
			Integer Base;
			Real odds;
			Integer point;
			Boolean addr_match;
			Boolean no_addr_match;
			Real custom40;
			Real phat;
			Integer custom40_mod;
			Integer rsn1108_2_1;
			Boolean ver_src_l2;
			Boolean ver_src_li;
			Boolean ver_src_ba;
			Boolean ver_src_ds;
			Boolean ver_src_de;
			Boolean lien_flag;
			Boolean bk_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Integer rsn1108_2;
			Models.Layout_RecoverScore;
		end;
		layout_debug doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#else
		Models.Layout_RecoverScore doModel( clam le, EASI.Key_Easi_Census ri ) := TRANSFORM
	#end

	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_lnamecount                    := le.iid.lastcount;
	rc_addrcount                     := le.iid.addrcount;
	rc_ssncount                      := le.iid.socscount;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_ssncount                   := le.iid.combo_ssncount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_addr_sources                 := le.business_header_address_summary.bus_sources;
	age                              := le.name_verification.age;
	add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_drop                   := le.advo_input_addr.drop_indicator;
	add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_nhood_business_count        := le.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.addr_risk_summary.n_mfd_count;
	add1_nhood_avg_purchase_amount   := le.addr_risk_summary.n_ave_purchase_amount;
	add1_nhood_avg_assessed_amount   := le.addr_risk_summary.n_ave_assessed_amount;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_prison_history             := le.other_address_info.isprison;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	impulse_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_felonies36                  := le.bjl.criminal_count36;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count36            := le.bjl.eviction_count36;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	foreclosure_flag                 := le.bjl.foreclosure_flag;
	rel_felony_count                 := le.relatives.relative_felony_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	archive_date                     := le.historydate;
	C_EASIQLIFE                      := trim(ri.easiqlife);
	C_ROBBERY                        := trim(ri.robbery);
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
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);

ver_src_en_pos := models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

ver_src_fdate_en := if(ver_src_en_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_eq_pos := models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

ver_src_fdate_eq := if(ver_src_eq_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

ver_src_ldate_p := if(ver_src_p_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_p_pos), '0');

ver_src_ldate_p2 := models.common.sas_date((string)(ver_src_ldate_p));

mth_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, (sysdate - ver_src_ldate_p2) / 30.5);

ver_src_v_pos := models.common.findw_cpp(ver_sources, 'V' , ' ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

ver_src_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

ver_src_ldate_wp := if(ver_src_wp_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

ver_src_ldate_wp2 := models.common.sas_date((string)(ver_src_ldate_wp));

mth_ver_src_ldate_wp := if(min(sysdate, ver_src_ldate_wp2) = NULL, NULL, (sysdate - ver_src_ldate_wp2) / 30.5);

s0_c_spanish := map(
    (real)C_SPAN_LANG <= 60  => 60,
    (real)C_SPAN_LANG <= 110 => 110,
    (real)C_SPAN_LANG <= 130 => 130,
    (real)C_SPAN_LANG <= 150 => 150,
    (real)C_SPAN_LANG <= 170 => 170,
                                171);

s0_c_spanish_m := map(
    s0_c_spanish = 60  => 0.4113338936,
    s0_c_spanish = 110 => 0.383070923,
    s0_c_spanish = 130 => 0.3442760943,
    s0_c_spanish = 150 => 0.3110140708,
    s0_c_spanish = 170 => 0.2893289329,
    s0_c_spanish = 171 => 0.2671825216,
                          0.3649173135);

s0_c_span_lang_c := if(C_SPAN_LANG = '', 100, max(min((real)C_SPAN_LANG, 200), 25));

s0_cj_lien_amt := map(
    liens_unrel_cj_total_amount > 20000 => 4,
    liens_unrel_cj_total_amount > 9000  => 3,
    liens_unrel_cj_total_amount > 8000  => 2,
    liens_unrel_cj_total_amount > 2000  => 1,
                                           0);

s0_cj_lien_amt_m := map(
    s0_cj_lien_amt = 0 => 0.389011683,
    s0_cj_lien_amt = 1 => 0.3579513299,
    s0_cj_lien_amt = 2 => 0.3316455696,
    s0_cj_lien_amt = 3 => 0.2891869237,
    s0_cj_lien_amt = 4 => 0.25997426,
                          0.3649173135);

liens_unrel_cj_last_seen2 := models.common.sas_date((string)(liens_unrel_cj_last_seen));

mth_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

s0_cj_lien_lvl_c116 := map(
    mth_liens_unrel_cj_last_seen = NULL => 3,
    mth_liens_unrel_cj_last_seen < 12   => 6,
    mth_liens_unrel_cj_last_seen < 25   => 5,
                                           4);

s0_cj_lien_lvl_c117 := map(
    mth_liens_unrel_cj_last_seen = NULL => 2,
    mth_liens_unrel_cj_last_seen < 25   => 0,
                                           1);

s0_cj_lien_lvl := if(liens_rel_cj_ct = 0, s0_cj_lien_lvl_c116, s0_cj_lien_lvl_c117);

s0_cj_lien_lvl_m := map(
    s0_cj_lien_lvl = 0 => 0.4611590629,
    s0_cj_lien_lvl = 1 => 0.435828877,
    s0_cj_lien_lvl = 2 => 0.4272,
    s0_cj_lien_lvl = 3 => 0.3868270959,
    s0_cj_lien_lvl = 4 => 0.3596102746,
    s0_cj_lien_lvl = 5 => 0.2979744136,
    s0_cj_lien_lvl = 6 => 0.2613877119,
                          0.3649173135);

s0_src_confirm_addr := map(
    rc_addrcount <= 2 => 0,
    rc_addrcount = 3  => 1,
    rc_addrcount = 4  => 2,
    rc_addrcount <= 7 => 3,
    rc_addrcount = 8  => 4,
    rc_addrcount = 9  => 5,
                         6);

s0_src_confirm_addr_m := map(
    s0_src_confirm_addr = 0 => 0.2857142857,
    s0_src_confirm_addr = 1 => 0.3290170689,
    s0_src_confirm_addr = 2 => 0.3534751773,
    s0_src_confirm_addr = 3 => 0.3693035553,
    s0_src_confirm_addr = 4 => 0.3990526939,
    s0_src_confirm_addr = 5 => 0.4227748691,
    s0_src_confirm_addr = 6 => 0.4454976303,
                               0.3649173135);

s0_combo_src_confirm_ssn := min(if(combo_ssncount = NULL, -NULL, combo_ssncount), 3);

s0_combo_src_confirm_ssn_m := map(
    s0_combo_src_confirm_ssn = 0 => 0.2571428571,
    s0_combo_src_confirm_ssn = 1 => 0.2606232295,
    s0_combo_src_confirm_ssn = 2 => 0.321799308,
    s0_combo_src_confirm_ssn = 3 => 0.3687385495,
                                    0.3649173135);

s0_input_probs := map(
    add1_advo_address_vacancy = 'Y' OR NOT(add1_house_number_match)                                       => 2,
    add1_advo_drop = 'Y' OR add1_advo_res_or_business = 'B' OR (integer)rc_input_addr_not_most_recent > 0 => 1,
                                                                                                             0);

s0_input_probs_m := map(
    s0_input_probs = 0 => 0.3696599413,
    s0_input_probs = 1 => 0.3395092639,
    s0_input_probs = 2 => 0.281618887,
                          0.3649173135);

s0_coll_recency := map(
    Inq_Collection_count01 > 0 => 4,
    Inq_Collection_count03 > 0 => 3,
    Inq_Collection_count06 > 0 => 2,
    Inq_Collection_count12 > 0 => 1,
                                  0);

s0_coll_recency_m := map(
    s0_coll_recency = 0 => 0.397255545,
    s0_coll_recency = 1 => 0.3535414166,
    s0_coll_recency = 2 => 0.3367174281,
    s0_coll_recency = 3 => 0.3198071515,
    s0_coll_recency = 4 => 0.2919402985,
                           0.3649173135);

s0_inq_ssn_verx_v2 := map(
    Inq_count = 0                 => -1,
    Inq_ssn_ver_count = 255       => 0,
    (Inq_ssn_ver_count in [1, 2]) => 0,
    Inq_ssn_ver_count < 7         => 1,
    Inq_ssn_ver_count < 11        => 2,
    Inq_ssn_ver_count < 16        => 3,
    Inq_ssn_ver_count < 21        => 4,
                                     5);

s0_inq_ssn_verx_v2_m := map(
    s0_inq_ssn_verx_v2 = -1 => 0.4232622161,
    s0_inq_ssn_verx_v2 = 0  => 0.4053346628,
    s0_inq_ssn_verx_v2 = 1  => 0.3573654391,
    s0_inq_ssn_verx_v2 = 2  => 0.3110445775,
    s0_inq_ssn_verx_v2 = 3  => 0.2780517879,
    s0_inq_ssn_verx_v2 = 4  => 0.2669902913,
    s0_inq_ssn_verx_v2 = 5  => 0.2004264392,
                               0.3649173135);

s0_c_gt_median_robbery := (real)C_ROBBERY > 100;

business_bk := (integer)indexw(StringLib.StringToUpperCase(trim(bus_addr_sources, ALL)), 'BK', ',') > 0;

business_lien := (integer)indexw(StringLib.StringToUpperCase(trim(bus_addr_sources, ALL)), 'L2', ',') > 0;

s0_business_hdr_lvl := map(
    business_bk or business_lien => 0,
    bus_addr_match_count != 0    => 1,
                                    2);

s0_business_hdr_lvl_m := map(
    s0_business_hdr_lvl = 0 => 0.3139013453,
    s0_business_hdr_lvl = 1 => 0.3547601656,
    s0_business_hdr_lvl = 2 => 0.3776448271,
                               0.3649173135);

s0_recent_prop_hit := map(
    mth_ver_src_ldate_p = NULL => 0,
    mth_ver_src_ldate_p = 0    => 2,
    mth_ver_src_ldate_p <= 12  => 1,
                                  0);

s0_recent_prop_hit_m := map(
    s0_recent_prop_hit = 0 => 0.3334886973,
    s0_recent_prop_hit = 1 => 0.3527865405,
    s0_recent_prop_hit = 2 => 0.3739363828,
                              0.3649173135);

ver_src_fdate_eq2 := models.common.sas_date((string)(ver_src_fdate_eq));

mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

ver_src_fdate_en2 := models.common.sas_date((string)(ver_src_fdate_en));

mth_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 30.5);

lb_mons_on_cb := if(mth_ver_src_fdate_eq != NULL OR mth_ver_src_fdate_en != NULL, max(mth_ver_src_fdate_eq, mth_ver_src_fdate_en), NULL);

lb_age_1 := map(
    age > 0                 => age,
    (real)input_dob_age > 0 => (real)input_dob_age,
    inferred_age > 0        => inferred_age,
                               -1);

_age_fseen_cb := if(lb_age_1 > 0 AND lb_mons_on_cb > 0, lb_age_1 - round(lb_mons_on_cb / 12), NULL);

s0_age_fstsn_on_cb := map(
    _age_fseen_cb > 50 => 50,
    _age_fseen_cb > 39 => 39,
    _age_fseen_cb > 29 => 29,
                          0);

s0_age_fstsn_on_cb_m := map(
    s0_age_fstsn_on_cb = 0  => 0.38727093,
    s0_age_fstsn_on_cb = 29 => 0.3646103896,
    s0_age_fstsn_on_cb = 39 => 0.3245436105,
    s0_age_fstsn_on_cb = 50 => 0.2445993031,
                               0.3649173135);

s0_vehicle_hit := map(
    (integer)ver_src_v > 0                    => 2,
    current_count > 0 OR historical_count > 0 => 1,
                                                 0);

s0_vehicle_hit_m := map(
    s0_vehicle_hit = 0 => 0.3260670032,
    s0_vehicle_hit = 1 => 0.3645386692,
    s0_vehicle_hit = 2 => 0.3906990521,
                          0.3649173135);

criminal_last_date2_1 := models.common.sas_date((string)(criminal_last_date));

mth_criminal_last_date_1 := if(min(sysdate, criminal_last_date2_1) = NULL, NULL, (sysdate - criminal_last_date2_1) / 30.5);

s0_criminal_history := map(
    attr_felonies36 > 0 OR felony_count > 1 OR (felony_count > 0 AND (addrs_prison_history OR (mth_criminal_last_date_1 != NULL and mth_criminal_last_date_1 <= 12))) => 3,
    addrs_prison_history                                                                                                                                        => 2,
    mth_criminal_last_date_1 = NULL and criminal_count = 0                                                                                                      => 0,
    mth_criminal_last_date_1 > 12                                                                                                                               => 1,
                                                                                                                                                                   2);

s0_criminal_history_m := map(
    s0_criminal_history = 0 => 0.3702418665,
    s0_criminal_history = 1 => 0.3500161447,
    s0_criminal_history = 2 => 0.3047445255,
    s0_criminal_history = 3 => 0.2093023256,
                               0.3649173135);

s0_nhood_growth := add1_Nhood_avg_assessed_amount > 0 AND add1_Nhood_avg_purchase_amount > 0 AND add1_Nhood_avg_assessed_amount >= add1_Nhood_avg_purchase_amount;

lb_total_properties := if(max(add1_Nhood_SFD_count, add1_Nhood_MFD_count, add1_Nhood_Business_Count) = NULL, NULL, sum(if(add1_Nhood_SFD_count = NULL, 0, add1_Nhood_SFD_count), if(add1_Nhood_MFD_count = NULL, 0, add1_Nhood_MFD_count), if(add1_Nhood_Business_Count = NULL, 0, add1_Nhood_Business_Count)));

s0_nhood_num_properties := map(
    lb_total_properties = 0     => 2501,
    lb_total_properties <= 1500 => 1500,
    lb_total_properties <= 2500 => 2500,
                                   2501);

s0_nhood_num_properties_m := map(
    s0_nhood_num_properties = 1500 => 0.3718355953,
    s0_nhood_num_properties = 2500 => 0.3344729345,
    s0_nhood_num_properties = 2501 => 0.2877882152,
                                      0.3649173135);

s0_ssns_per_adl_lvl := map(
    ssns_per_adl = 1 and ssns_per_adl_c6 = 0                                             => 0,
    ssns_per_adl = 2 and ssns_per_adl_c6 = 0                                             => 1,
    ssns_per_adl = 1 and ssns_per_adl_c6 = 1 OR ssns_per_adl = 0                         => 2,
    ssns_per_adl = 2 and ssns_per_adl_c6 = 1 OR ssns_per_adl = 3 and ssns_per_adl_c6 < 2 => 3,
                                                                                            4);

s0_ssns_per_adl_lvl_m := map(
    s0_ssns_per_adl_lvl = 0 => 0.3872070804,
    s0_ssns_per_adl_lvl = 1 => 0.3791821561,
    s0_ssns_per_adl_lvl = 2 => 0.3508856683,
    s0_ssns_per_adl_lvl = 3 => 0.3262295082,
    s0_ssns_per_adl_lvl = 4 => 0.3061840121,
                               0.3649173135);

s0_rel_felony_count_2 := min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 2);

s0_rel_felony_count_2_m := map(
    s0_rel_felony_count_2 = 0 => 0.3701873585,
    s0_rel_felony_count_2 = 1 => 0.349537037,
    s0_rel_felony_count_2 = 2 => 0.3202875399,
                                 0.3649173135);

s0_avm_lvl := map(
    add1_avm_automated_valuation = 0       => 5,
    add1_avm_automated_valuation <= 30000  => 0,
    add1_avm_automated_valuation <= 75000  => 1,
    add1_avm_automated_valuation <= 150000 => 2,
    add1_avm_automated_valuation <= 175000 => 3,
    add1_avm_automated_valuation <= 225000 => 4,
    add1_avm_automated_valuation <= 250000 => 5,
    add1_avm_automated_valuation <= 500000 => 6,
                                              7);

s0_avm_lvl_m := map(
    s0_avm_lvl = 0 => 0.3180076628,
    s0_avm_lvl = 1 => 0.3303130148,
    s0_avm_lvl = 2 => 0.3642201835,
    s0_avm_lvl = 3 => 0.3775130305,
    s0_avm_lvl = 4 => 0.4024717894,
    s0_avm_lvl = 5 => 0.3804757292,
    s0_avm_lvl = 6 => 0.334376397,
    s0_avm_lvl = 7 => 0.2762237762,
                      0.3649173135);

impulse_email := (integer)indexw(StringLib.StringToUpperCase(trim(email_source_list, ALL)), 'IM', ',') > 0;

s0_derog_severity := map(
    foreclosure_flag                                                                                => 5,
    attr_eviction_count36 > 0                                                                       => 4,
    (StringLib.StringToUpperCase(disposition))[1..8] = 'DISCHARG' AND attr_eviction_count = 0       => 0,
    impulse_count > 0 OR (impulse_email or Inq_HighRiskCredit_count > 0) OR attr_eviction_count > 0 => 3,
    disposition = ' ' and NOT(bankrupt)                                                             => 1,
                                                                                                       3);

s0_derog_severity_m := map(
    s0_derog_severity = 0 => 0.4116972477,
    s0_derog_severity = 1 => 0.3668539326,
    s0_derog_severity = 2 => 0.3438485804,
    s0_derog_severity = 3 => 0.3267716535,
    s0_derog_severity = 4 => 0.26,
    s0_derog_severity = 5 => 0.2237762238,
                             0.3649173135);

s1_c_spanish := map(
    (real)C_SPAN_LANG <= 110 => 110,
    (real)C_SPAN_LANG <= 150 => 150,
    (real)C_SPAN_LANG <= 180 => 180,
                                181);

s1_c_spanish_m := map(
    s1_c_spanish = 110 => 0.3442178475,
    s1_c_spanish = 150 => 0.2816229117,
    s1_c_spanish = 180 => 0.2299651568,
    s1_c_spanish = 181 => 0.2061068702,
                          0.3089615723);

s1_c_span_lang_c := if(C_SPAN_LANG = '', 100, min(if(max((integer)C_SPAN_LANG, 25) = NULL, -NULL, max((integer)C_SPAN_LANG, 25)), 200));

lb_age := map(
    age > 0                 => age,
    (real)input_dob_age > 0 => (real)input_dob_age,
    inferred_age > 0        => inferred_age,
                               -1);

s1_age_lvl_v2 := map(
    lb_age = -1  => 2,
    lb_age <= 34 => 1,
    lb_age <= 62 => 2,
    lb_age <= 70 => 3,
                    4);

s1_age_lvl_v2_m := map(
    s1_age_lvl_v2 = 1 => 0.3437152392,
    s1_age_lvl_v2 = 2 => 0.3095716871,
    s1_age_lvl_v2 = 3 => 0.2821497121,
    s1_age_lvl_v2 = 4 => 0.2611764706,
                         0.3089615723);

criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

mth_criminal_last_date := if(min(sysdate, criminal_last_date2) = NULL, NULL, (sysdate - criminal_last_date2) / 30.5);

s1_criminal_felony_lvl := map(
    felony_count > 0                                     => 3,
    mth_criminal_last_date = NULL and criminal_count = 0 => 0,
    mth_criminal_last_date > 6                           => 1,
                                                            2);

s1_criminal_felony_lvl_m := map(
    s1_criminal_felony_lvl = 0 => 0.3171485725,
    s1_criminal_felony_lvl = 1 => 0.2936088419,
    s1_criminal_felony_lvl = 2 => 0.2233502538,
    s1_criminal_felony_lvl = 3 => 0.1944444444,
                                  0.3089615723);

s1_unrel_cj_lien_amt := map(
    liens_unrel_cj_total_amount > 20000 => 3,
    liens_unrel_cj_total_amount > 7000  => 2,
    liens_unrel_cj_total_amount > 1000  => 1,
                                           0);

s1_unrel_cj_lien_amt_m := map(
    s1_unrel_cj_lien_amt = 0 => 0.3273829572,
    s1_unrel_cj_lien_amt = 1 => 0.3011389522,
    s1_unrel_cj_lien_amt = 2 => 0.2760072159,
    s1_unrel_cj_lien_amt = 3 => 0.2032146958,
                                0.3089615723);

liens_rel_cj_last_seen2 := models.common.sas_date((string)(liens_rel_cj_last_seen));

mth_liens_rel_cj_last_seen := if(min(sysdate, liens_rel_cj_last_seen2) = NULL, NULL, (sysdate - liens_rel_cj_last_seen2) / 30.5);

s1_cj_lien_lvl := if(mth_liens_rel_cj_last_seen > 48 OR mth_liens_rel_cj_last_seen = NULL, min(if(liens_unrel_cj_ct = NULL, -NULL, liens_unrel_cj_ct), 3) + 1, 0);

s1_cj_lien_lvl_m := map(
    s1_cj_lien_lvl = 0 => 0.3862068966,
    s1_cj_lien_lvl = 1 => 0.3250674547,
    s1_cj_lien_lvl = 2 => 0.2903225806,
    s1_cj_lien_lvl = 3 => 0.2418069088,
    s1_cj_lien_lvl = 4 => 0.2285471538,
                          0.3089615723);

s1_sc_lien_lvl := map(
    liens_rel_sc_ct > 0 AND liens_unrel_sc_ct > 1 => 1,
    liens_rel_sc_ct > 0                           => 0,
                                                     min(if(liens_unrel_sc_ct = NULL, -NULL, liens_unrel_sc_ct), 3) + 2);

s1_sc_lien_lvl_m := map(
    s1_sc_lien_lvl = 0 => 0.4463519313,
    s1_sc_lien_lvl = 1 => 0.3625,
    s1_sc_lien_lvl = 2 => 0.3099949264,
    s1_sc_lien_lvl = 3 => 0.2745098039,
    s1_sc_lien_lvl = 4 => 0.2699619772,
    s1_sc_lien_lvl = 5 => 0.2537313433,
                          0.3089615723);

s1_inq_count24_7p := Inq_count24 >= 7;

s1_inq_ssn_verx_v2 := map(
    Inq_ssn_ver_count = 255 => 1,
    Inq_ssn_ver_count = 0   => 5,
                               min(if(Inq_ssn_ver_count = NULL, -NULL, Inq_ssn_ver_count), 5));

s1_inq_ssn_verx_v2_m := map(
    s1_inq_ssn_verx_v2 = 1 => 0.3487112844,
    s1_inq_ssn_verx_v2 = 2 => 0.3251106894,
    s1_inq_ssn_verx_v2 = 3 => 0.3104,
    s1_inq_ssn_verx_v2 = 4 => 0.3024154589,
    s1_inq_ssn_verx_v2 = 5 => 0.2693576557,
                              0.3089615723);

s1_email_f := email_count > 0;

ams_flag := ams_class != ' ' or ams_college_code != ' ' or ams_college_type != ' ' or ams_income_level_code != ' ' or ams_file_type != ' ';

s1_ams_lvl := map(
    (real)ams_college_code = 4 => 2,
    ams_flag                   => 1,
                                  0);

s1_ams_lvl_m := map(
    s1_ams_lvl = 0 => 0.3042071197,
    s1_ams_lvl = 1 => 0.3243546577,
    s1_ams_lvl = 2 => 0.425974026,
                      0.3089615723);

s1_c_gt_median_robbery := (real)C_ROBBERY > 100;

s1_c_qual_of_life := map(
    (real)C_EASIQLIFE < 110 => 110,
    (real)C_EASIQLIFE < 140 => 140,
    (real)C_EASIQLIFE < 150 => 150,
                               151);

s1_c_qual_of_life_m := map(
    s1_c_qual_of_life = 110 => 0.3317919075,
    s1_c_qual_of_life = 140 => 0.2681992337,
    s1_c_qual_of_life = 150 => 0.2346153846,
    s1_c_qual_of_life = 151 => 0.2004264392,
                               0.3089615723);

ssn_issued18 := (real)rc_pwssnvalflag = 5;

s1_addrs_per_ssn := map(
    addrs_per_ssn = 0  => 2,
    addrs_per_ssn < 7  => 0,
    addrs_per_ssn < 15 => 1,
                          2);

s1_addrs_per_ssn_m := map(
    s1_addrs_per_ssn = 0 => 0.3464681845,
    s1_addrs_per_ssn = 1 => 0.3039252808,
    s1_addrs_per_ssn = 2 => 0.2702229996,
                            0.3089615723);

s1_4p_rel_incomeunder25 := rel_incomeunder25_count > 3;

s1_good_src_count := rc_lnamecount > 4 AND rc_addrcount > 2 AND rc_ssncount > 2;

s1_4p_addrs_3yr := attr_addrs_last36 >= 4;

s1_recent_prop_hit := mth_ver_src_ldate_p != NULL and mth_ver_src_ldate_p <= 12;

adl_dead := adl_category = '1 DEAD';

gong_did_last_seen2 := models.common.sas_date((string)(gong_did_last_seen));

mth_gong_did_last_seen := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, (sysdate - gong_did_last_seen2) / 30.5);

s1_recent_phone_hit := map(
    mth_gong_did_last_seen = 0 AND mth_ver_src_ldate_wp = 0 => 3,
    mth_gong_did_last_seen = 0                              => 2,
    mth_ver_src_ldate_wp = 0                                => 1,
                                                               0);

s1_recent_phone_hit_m := map(
    s1_recent_phone_hit = 0 => 0.2837598176,
    s1_recent_phone_hit = 1 => 0.3039049236,
    s1_recent_phone_hit = 2 => 0.3250104037,
    s1_recent_phone_hit = 3 => 0.3683636364,
                               0.3089615723);

s1_input_avm_lvl := map(
    add1_avm_automated_valuation = 0       => 1,
    add1_avm_automated_valuation <= 75000  => 0,
    add1_avm_automated_valuation <= 250000 => 1,
    add1_avm_automated_valuation <= 500000 => 2,
                                              3);

s1_input_avm_lvl_m := map(
    s1_input_avm_lvl = 0 => 0.2720870679,
    s1_input_avm_lvl = 1 => 0.3238379367,
    s1_input_avm_lvl = 2 => 0.2585034014,
    s1_input_avm_lvl = 3 => 0.225,
                            0.3089615723);

s0_addr_match := -20.66354442 +
    s0_c_spanish_m * 3.2163107667 +
    s0_c_span_lang_c * 0.0002681276 +
    s0_cj_lien_amt_m * 2.4602938169 +
    s0_cj_lien_lvl_m * 3.5199898917 +
    s0_src_confirm_addr_m * 3.8167318252 +
    s0_combo_src_confirm_ssn_m * 2.3654565355 +
    (integer)ssn_issued18 * -0.138448341 +
    s0_input_probs_m * 2.7263502051 +
    s0_coll_recency_m * 1.9959963714 +
    s0_inq_ssn_verx_v2_m * 3.2147793829 +
    (integer)s0_c_gt_median_robbery * -0.224192264 +
    s0_business_hdr_lvl_m * 3.2350664018 +
    (integer)adl_dead * -0.463488811 +
    s0_recent_prop_hit_m * 3.4772917836 +
    s0_age_fstsn_on_cb_m * 3.6207899979 +
    s0_vehicle_hit_m * 2.339828191 +
    s0_criminal_history_m * 4.5173092698 +
    (integer)s0_nhood_growth * 0.0840091597 +
    s0_nhood_num_properties_m * 3.5100108285 +
    s0_ssns_per_adl_lvl_m * 2.5091460425 +
    s0_rel_felony_count_2_m * 3.4165353877 +
    s0_avm_lvl_m * 2.7932511773 +
    s0_derog_severity_m * 2.4419383959;

s1_no_addr_match := -13.1982412 +
    s1_c_spanish_m * 2.9009187471 +
    s1_c_span_lang_c * -0.000034539 +
    s1_age_lvl_v2_m * 3.3687318994 +
    s1_criminal_felony_lvl_m * 4.3820188395 +
    s1_unrel_cj_lien_amt_m * 3.1540695031 +
    s1_cj_lien_lvl_m * 3.8505689961 +
    s1_sc_lien_lvl_m * 4.2344207337 +
    (integer)s1_inq_count24_7p * -0.18192409 +
    s1_inq_ssn_verx_v2_m * 2.8953167419 +
    (integer)s1_email_f * 0.1277199738 +
    s1_ams_lvl_m * 3.3485625788 +
    (integer)s1_c_gt_median_robbery * -0.272985891 +
    s1_c_qual_of_life_m * 3.0795948144 +
    (integer)ssn_issued18 * -0.139426971 +
    s1_addrs_per_ssn_m * 2.3110634013 +
    (integer)s1_4p_rel_incomeunder25 * -0.115579047 +
    (integer)s1_good_src_count * 0.2104797938 +
    (integer)s1_4p_addrs_3yr * -0.137212188 +
    (integer)s1_recent_prop_hit * 0.239598967 +
    (integer)adl_dead * -0.430714724 +
    s1_recent_phone_hit_m * 3.7552838864 +
    s1_input_avm_lvl_m * 2.4851284755;

base := 700;

odds := 0.3248 / (1 - 0.3248);

point := 40;

addr_match := (integer)add1_isbestmatch = 1;

no_addr_match := (integer)add1_isbestmatch = 0;

custom40 := (integer)addr_match * s0_addr_match + (integer)no_addr_match * s1_no_addr_match;

phat := exp(custom40) / (1 + exp(custom40));

custom40_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

rsn1108_2_1 := round(min(if(max(custom40_mod, 501) = NULL, -NULL, max(custom40_mod, 501)), 900));

ver_src_l2 := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0;

ver_src_li := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0;

ver_src_ba := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0;

ver_src_ds := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

ver_src_de := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

ssn_deceased := (integer)ver_src_ds > 0 OR (integer)ver_src_de > 0 OR adl_category = '1 DEAD' OR (real)rc_decsflag = 1;

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (real)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

rsn1108_2 := if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 AND not(scored_222s), 222, rsn1108_2_1);



		#if(RSN_DEBUG)
			self.clam                            := le;
			self.truedid                         := truedid;
			self.adl_category                    := adl_category;
			self.nas_summary                     := nas_summary;
			self.nap_summary                     := nap_summary;
			self.rc_input_addr_not_most_recent   := rc_input_addr_not_most_recent;
			self.rc_decsflag                     := rc_decsflag;
			self.rc_pwssnvalflag                 := rc_pwssnvalflag;
			self.rc_bansflag                     := rc_bansflag;
			self.rc_lnamecount                   := rc_lnamecount;
			self.rc_addrcount                    := rc_addrcount;
			self.rc_ssncount                     := rc_ssncount;
			self.combo_dobscore                  := combo_dobscore;
			self.combo_ssncount                  := combo_ssncount;
			self.ver_sources                     := ver_sources;
			self.ver_sources_first_seen          := ver_sources_first_seen;
			self.ver_sources_last_seen           := ver_sources_last_seen;
			self.bus_addr_match_count            := bus_addr_match_count;
			self.bus_addr_sources                := bus_addr_sources;
			self.age                             := age;
			self.add1_house_number_match         := add1_house_number_match;
			self.add1_isbestmatch                := add1_isbestmatch;
			self.add1_advo_address_vacancy       := add1_advo_address_vacancy;
			self.add1_advo_drop                  := add1_advo_drop;
			self.add1_advo_res_or_business       := add1_advo_res_or_business;
			self.add1_avm_automated_valuation    := add1_avm_automated_valuation;
			self.add1_naprop                     := add1_naprop;
			self.add1_nhood_business_count       := add1_nhood_business_count;
			self.add1_nhood_sfd_count            := add1_nhood_sfd_count;
			self.add1_nhood_mfd_count            := add1_nhood_mfd_count;
			self.add1_nhood_avg_purchase_amount  := add1_nhood_avg_purchase_amount;
			self.add1_nhood_avg_assessed_amount  := add1_nhood_avg_assessed_amount;
			self.property_owned_total            := property_owned_total;
			self.property_sold_total             := property_sold_total;
			self.addrs_prison_history            := addrs_prison_history;
			self.gong_did_last_seen              := gong_did_last_seen;
			self.ssns_per_adl                    := ssns_per_adl;
			self.addrs_per_ssn                   := addrs_per_ssn;
			self.ssns_per_adl_c6                 := ssns_per_adl_c6;
			self.inq_ssn_ver_count               := inq_ssn_ver_count;
			self.inq_count                       := inq_count;
			self.inq_count24                     := inq_count24;
			self.inq_collection_count01          := inq_collection_count01;
			self.inq_collection_count03          := inq_collection_count03;
			self.inq_collection_count06          := inq_collection_count06;
			self.inq_collection_count12          := inq_collection_count12;
			self.inq_highriskcredit_count        := inq_highriskcredit_count;
			self.impulse_count                   := impulse_count;
			self.email_count                     := email_count;
			self.email_source_list               := email_source_list;
			self.attr_addrs_last36               := attr_addrs_last36;
			self.attr_felonies36                 := attr_felonies36;
			self.attr_eviction_count             := attr_eviction_count;
			self.attr_eviction_count36           := attr_eviction_count36;
			self.bankrupt                        := bankrupt;
			self.disposition                     := disposition;
			self.filing_count                    := filing_count;
			self.bk_recent_count                 := bk_recent_count;
			self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct               := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen        := liens_unrel_cj_last_seen;
			self.liens_unrel_cj_total_amount     := liens_unrel_cj_total_amount;
			self.liens_rel_cj_ct                 := liens_rel_cj_ct;
			self.liens_rel_cj_last_seen          := liens_rel_cj_last_seen;
			self.liens_unrel_sc_ct               := liens_unrel_sc_ct;
			self.liens_rel_sc_ct                 := liens_rel_sc_ct;
			self.criminal_count                  := criminal_count;
			self.criminal_last_date              := criminal_last_date;
			self.felony_count                    := felony_count;
			self.foreclosure_flag                := foreclosure_flag;
			self.rel_felony_count                := rel_felony_count;
			self.rel_incomeunder25_count         := rel_incomeunder25_count;
			self.current_count                   := current_count;
			self.historical_count                := historical_count;
			self.ams_class                       := ams_class;
			self.ams_college_code                := ams_college_code;
			self.ams_college_type                := ams_college_type;
			self.ams_income_level_code           := ams_income_level_code;
			self.ams_file_type                   := ams_file_type;
			self.input_dob_age                   := input_dob_age;
			self.input_dob_match_level           := input_dob_match_level;
			self.inferred_age                    := inferred_age;
			self.archive_date                    := archive_date;
			self.C_EASIQLIFE                     := C_EASIQLIFE;
			self.C_ROBBERY                       := C_ROBBERY;
			self.C_SPAN_LANG                     := C_SPAN_LANG;
			self.sysdate                         := sysdate;
			self.ver_src_en_pos                  := ver_src_en_pos;
			self.ver_src_fdate_en                := ver_src_fdate_en;
			self.ver_src_eq_pos                  := ver_src_eq_pos;
			self.ver_src_fdate_eq                := ver_src_fdate_eq;
			self.ver_src_p_pos                   := ver_src_p_pos;
			self.ver_src_ldate_p                 := ver_src_ldate_p;
			self.ver_src_ldate_p2                := ver_src_ldate_p2;
			self.mth_ver_src_ldate_p             := mth_ver_src_ldate_p;
			self.ver_src_v_pos                   := ver_src_v_pos;
			self.ver_src_v                       := ver_src_v;
			self.ver_src_wp_pos                  := ver_src_wp_pos;
			self.ver_src_ldate_wp                := ver_src_ldate_wp;
			self.ver_src_ldate_wp2               := ver_src_ldate_wp2;
			self.mth_ver_src_ldate_wp            := mth_ver_src_ldate_wp;
			self.s0_c_spanish                    := s0_c_spanish;
			self.s0_c_spanish_m                  := s0_c_spanish_m;
			self.s0_c_span_lang_c                := s0_c_span_lang_c;
			self.s0_cj_lien_amt                  := s0_cj_lien_amt;
			self.s0_cj_lien_amt_m                := s0_cj_lien_amt_m;
			self.liens_unrel_cj_last_seen2       := liens_unrel_cj_last_seen2;
			self.mth_liens_unrel_cj_last_seen    := mth_liens_unrel_cj_last_seen;
			self.s0_cj_lien_lvl_c116             := s0_cj_lien_lvl_c116;
			self.s0_cj_lien_lvl_c117             := s0_cj_lien_lvl_c117;
			self.s0_cj_lien_lvl                  := s0_cj_lien_lvl;
			self.s0_cj_lien_lvl_m                := s0_cj_lien_lvl_m;
			self.s0_src_confirm_addr             := s0_src_confirm_addr;
			self.s0_src_confirm_addr_m           := s0_src_confirm_addr_m;
			self.s0_combo_src_confirm_ssn        := s0_combo_src_confirm_ssn;
			self.s0_combo_src_confirm_ssn_m      := s0_combo_src_confirm_ssn_m;
			self.s0_input_probs                  := s0_input_probs;
			self.s0_input_probs_m                := s0_input_probs_m;
			self.s0_coll_recency                 := s0_coll_recency;
			self.s0_coll_recency_m               := s0_coll_recency_m;
			self.s0_inq_ssn_verx_v2              := s0_inq_ssn_verx_v2;
			self.s0_inq_ssn_verx_v2_m            := s0_inq_ssn_verx_v2_m;
			self.s0_c_gt_median_robbery          := s0_c_gt_median_robbery;
			self.business_bk                     := business_bk;
			self.business_lien                   := business_lien;
			self.s0_business_hdr_lvl             := s0_business_hdr_lvl;
			self.s0_business_hdr_lvl_m           := s0_business_hdr_lvl_m;
			self.s0_recent_prop_hit              := s0_recent_prop_hit;
			self.s0_recent_prop_hit_m            := s0_recent_prop_hit_m;
			self.ver_src_fdate_eq2               := ver_src_fdate_eq2;
			self.mth_ver_src_fdate_eq            := mth_ver_src_fdate_eq;
			self.ver_src_fdate_en2               := ver_src_fdate_en2;
			self.mth_ver_src_fdate_en            := mth_ver_src_fdate_en;
			self.lb_mons_on_cb                   := lb_mons_on_cb;
			self.lb_age_1                        := lb_age_1;
			self._age_fseen_cb                   := _age_fseen_cb;
			self.s0_age_fstsn_on_cb              := s0_age_fstsn_on_cb;
			self.s0_age_fstsn_on_cb_m            := s0_age_fstsn_on_cb_m;
			self.s0_vehicle_hit                  := s0_vehicle_hit;
			self.s0_vehicle_hit_m                := s0_vehicle_hit_m;
			self.criminal_last_date2_1           := criminal_last_date2_1;
			self.mth_criminal_last_date_1        := mth_criminal_last_date_1;
			self.s0_criminal_history             := s0_criminal_history;
			self.s0_criminal_history_m           := s0_criminal_history_m;
			self.s0_nhood_growth                 := s0_nhood_growth;
			self.lb_total_properties             := lb_total_properties;
			self.s0_nhood_num_properties         := s0_nhood_num_properties;
			self.s0_nhood_num_properties_m       := s0_nhood_num_properties_m;
			self.s0_ssns_per_adl_lvl             := s0_ssns_per_adl_lvl;
			self.s0_ssns_per_adl_lvl_m           := s0_ssns_per_adl_lvl_m;
			self.s0_rel_felony_count_2           := s0_rel_felony_count_2;
			self.s0_rel_felony_count_2_m         := s0_rel_felony_count_2_m;
			self.s0_avm_lvl                      := s0_avm_lvl;
			self.s0_avm_lvl_m                    := s0_avm_lvl_m;
			self.impulse_email                   := impulse_email;
			self.s0_derog_severity               := s0_derog_severity;
			self.s0_derog_severity_m             := s0_derog_severity_m;
			self.s1_c_spanish                    := s1_c_spanish;
			self.s1_c_spanish_m                  := s1_c_spanish_m;
			self.s1_c_span_lang_c                := s1_c_span_lang_c;
			self.lb_age                          := lb_age;
			self.s1_age_lvl_v2                   := s1_age_lvl_v2;
			self.s1_age_lvl_v2_m                 := s1_age_lvl_v2_m;
			self.criminal_last_date2             := criminal_last_date2;
			self.mth_criminal_last_date          := mth_criminal_last_date;
			self.s1_criminal_felony_lvl          := s1_criminal_felony_lvl;
			self.s1_criminal_felony_lvl_m        := s1_criminal_felony_lvl_m;
			self.s1_unrel_cj_lien_amt            := s1_unrel_cj_lien_amt;
			self.s1_unrel_cj_lien_amt_m          := s1_unrel_cj_lien_amt_m;
			self.liens_rel_cj_last_seen2         := liens_rel_cj_last_seen2;
			self.mth_liens_rel_cj_last_seen      := mth_liens_rel_cj_last_seen;
			self.s1_cj_lien_lvl                  := s1_cj_lien_lvl;
			self.s1_cj_lien_lvl_m                := s1_cj_lien_lvl_m;
			self.s1_sc_lien_lvl                  := s1_sc_lien_lvl;
			self.s1_sc_lien_lvl_m                := s1_sc_lien_lvl_m;
			self.s1_inq_count24_7p               := s1_inq_count24_7p;
			self.s1_inq_ssn_verx_v2              := s1_inq_ssn_verx_v2;
			self.s1_inq_ssn_verx_v2_m            := s1_inq_ssn_verx_v2_m;
			self.s1_email_f                      := s1_email_f;
			self.ams_flag                        := ams_flag;
			self.s1_ams_lvl                      := s1_ams_lvl;
			self.s1_ams_lvl_m                    := s1_ams_lvl_m;
			self.s1_c_gt_median_robbery          := s1_c_gt_median_robbery;
			self.s1_c_qual_of_life               := s1_c_qual_of_life;
			self.s1_c_qual_of_life_m             := s1_c_qual_of_life_m;
			self.ssn_issued18                    := ssn_issued18;
			self.s1_addrs_per_ssn                := s1_addrs_per_ssn;
			self.s1_addrs_per_ssn_m              := s1_addrs_per_ssn_m;
			self.s1_4p_rel_incomeunder25         := s1_4p_rel_incomeunder25;
			self.s1_good_src_count               := s1_good_src_count;
			self.s1_4p_addrs_3yr                 := s1_4p_addrs_3yr;
			self.s1_recent_prop_hit              := s1_recent_prop_hit;
			self.adl_dead                        := adl_dead;
			self.gong_did_last_seen2             := gong_did_last_seen2;
			self.mth_gong_did_last_seen          := mth_gong_did_last_seen;
			self.s1_recent_phone_hit             := s1_recent_phone_hit;
			self.s1_recent_phone_hit_m           := s1_recent_phone_hit_m;
			self.s1_input_avm_lvl                := s1_input_avm_lvl;
			self.s1_input_avm_lvl_m              := s1_input_avm_lvl_m;
			self.s0_addr_match                   := s0_addr_match;
			self.s1_no_addr_match                := s1_no_addr_match;
			self.base                            := base;
			self.odds                            := odds;
			self.point                           := point;
			self.addr_match                      := addr_match;
			self.no_addr_match                   := no_addr_match;
			self.custom40                        := custom40;
			self.phat                            := phat;
			self.custom40_mod                    := custom40_mod;
			self.rsn1108_2_1                     := rsn1108_2_1;
			self.ver_src_l2                      := ver_src_l2;
			self.ver_src_li                      := ver_src_li;
			self.ver_src_ba                      := ver_src_ba;
			self.ver_src_ds                      := ver_src_ds;
			self.ver_src_de                      := ver_src_de;
			self.lien_flag                       := lien_flag;
			self.bk_flag                         := bk_flag;
			self.ssn_deceased                    := ssn_deceased;
			self.scored_222s                     := scored_222s;
			self.rsn1108_2                       := rsn1108_2;

		#end

		self.seq := (string)le.seq;
		self.recover_score := (string)rsn1108_2;
	end;


	model := JOIN(clam, EASI.Key_Easi_Census, 
							KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
							doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.Max_Atmost), KEEP(1));

	RETURN(model);
END;

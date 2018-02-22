import risk_indicators, ut, riskwise, easi, std;

export RSN1108_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION
	RSN_DEBUG := false;

	#if(RSN_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String adl_category;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_decsflag;
			String rc_bansflag;
			Integer rc_addrcount;
			Integer combo_dobscore;
			qstring100 ver_sources;
			qstring100 bus_addr_sources;
			String fname_eda_sourced_type;
			String lname_eda_sourced_type;
			Integer age;
			Integer util_adl_count;
			Integer add1_avm_automated_valuation;
			Integer add1_naprop;
			Integer ADD1_PURCHASE_AMOUNT;
			String add1_building_area;
			Integer add1_nhood_avg_purchase_amount;
			Integer add1_nhood_avg_assessed_amount;
			Integer add1_nhood_avg_price_per_sf;
			Integer property_owned_total;
			Integer property_sold_total;
			Integer inq_count;
			Integer inq_count03;
			Integer inq_count06;
			Integer inq_count12;
			Integer inq_count24;
			Integer inq_collection_count03;
			Integer inq_highriskcredit_count;
			Integer paw_business_count;
			Integer paw_dead_business_count;
			Integer impulse_count;
			qstring50 email_source_list;
			Integer attr_addrs_last36;
			Integer attr_date_last_derog;
			Integer attr_num_rel_liens12;
			Integer attr_num_rel_liens36;
			Integer attr_num_rel_liens60;
			Integer attr_eviction_count24;
			Boolean Bankrupt;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_recent_released_count;
			Integer liens_historical_released_count;
			Integer liens_unrel_cj_first_seen;
			Integer liens_unrel_cj_last_seen;
			Integer liens_rel_cj_ct;
			Integer criminal_count;
			Integer felony_count;
			Boolean foreclosure_flag;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			String addr_stability_v2;
			Integer estimated_income;
			Integer archive_date;
			String c_blue_empl;
			String c_easiqlife;
			String c_span_lang;
			Integer sysdate;
			Integer b_qlife_income_lvl;
			Real b_qlife_income_lvl_m;
			Real b_c_easiqlife_c;
			Real b_c_span_lang_c;
			Real b_c_span_lang_srt;
			Integer attr_date_last_derog2;
			Real mth_attr_date_last_derog;
			Boolean b_derog_last2yrs;
			Boolean ver_src_fr;
			Boolean b_foreclosure_history;
			Boolean Impulse_Email;
			Boolean payday_loan_flag;
			Integer b_derog_severity_v2;
			Real b_derog_severity_v2_m;
			Integer b_rel_recency;
			Real b_rel_recency_m;
			Integer liens_unrel_cj_first_seen2;
			Real mth_liens_unrel_cj_first_seen;
			Integer liens_unrel_cj_last_seen2;
			Real mth_liens_unrel_cj_last_seen;
			Integer b_cj_lien_lvl_c11;
			Integer b_cj_lien_lvl_c12;
			Integer b_cj_lien_lvl;
			Real b_cj_lien_lvl_m;
			Integer b_inq_lvl_v2;
			Real b_inq_lvl_v2_m;
			Integer b_c_blue_collar;
			Real b_c_blue_collar_m;
			Real lb_age;
			Integer b_age_lvl;
			Real b_age_lvl_m;
			Integer b_verx_lvl_v2;
			Real b_verx_lvl_v2_m;
			Integer b_paw_lvl;
			Real b_paw_lvl_m;
			Integer b_stability_lvl;
			Real b_stability_lvl_m;
			Boolean business_bk;
			Boolean business_lien;
			Boolean b_derog_busihdr_hit;
			Integer nhood_growth;
			Integer home_growth;
			Integer b_input_avm_growth;
			Real b_input_avm_growth_m;
			Integer b_util_adl_count;
			Real b_util_adl_count_m;
			Integer lb_price_per_sft;
			Integer rel_price_per_sft;
			Boolean b_input_rel_ppsft_gtmed;
			String source1;
			String source2;
			String positive_source2;
			String positive_source1;
			Integer b_source_seq;
			Real b_source_seq_m;
			Real b_both;
			Integer Base;
			Real odds;
			Integer point;
			Real phat;
			Integer custom40_mod;
			Integer rsn1108_1_1;
			Boolean ver_src_l2;
			Boolean ver_src_li;
			Boolean ver_src_ba;
			Boolean ver_src_ds;
			Boolean ver_src_de;
			Boolean lien_flag;
			Boolean bk_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Integer rsn1108_1;
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
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	bus_addr_sources                 := le.business_header_address_summary.bus_sources;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	age                              := le.name_verification.age;
	util_adl_count                   := le.utility.utili_adl_count;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_building_area               := (string)le.address_verification.input_address_information.building_area;
	add1_nhood_avg_purchase_amount   := le.addr_risk_summary.n_ave_purchase_amount;
	add1_nhood_avg_assessed_amount   := le.addr_risk_summary.n_ave_assessed_amount;
	add1_nhood_avg_price_per_sf      := le.addr_risk_summary.n_ave_price_per_sf;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	paw_business_count               := le.employment.business_ct;
	paw_dead_business_count          := le.employment.dead_business_ct;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_date_last_derog             := le.date_last_derog;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_eviction_count24            := le.bjl.eviction_count24;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	foreclosure_flag                 := le.bjl.foreclosure_flag;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;
	archive_date                     := le.historydate;
	C_BLUE_EMPL                      := trim(ri.blue_empl);
	C_EASIQLIFE                      := trim(ri.easiqlife);
	C_SPAN_LANG                      := trim(ri.span_lang);











NULL := -999999999;

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);



sysdate := map(
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL);

b_qlife_income_lvl := map(
    C_EASIQLIFE != '' AND (real)C_EASIQLIFE < 100 AND 35000 < estimated_income AND estimated_income <= 60000                                                         => 7,
    C_EASIQLIFE != '' AND (real)C_EASIQLIFE < 100 AND estimated_income <= 35000 OR 100 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 110 AND estimated_income > 35000 => 6,
    C_EASIQLIFE != '' AND (real)C_EASIQLIFE < 100                                                                                                                    => 5,
    100 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 110 OR 110 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 130 AND estimated_income <= 60000                        => 4,
    110 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 130                                                                                                              => 3,
    130 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 140 AND estimated_income <= 60000                                                                                => 2,
    130 <= (real)C_EASIQLIFE AND (real)C_EASIQLIFE < 150                                                                                                              => 1,
                                                                                                                                                                         0);

b_qlife_income_lvl_m := map(
    b_qlife_income_lvl = 0 => 0.3148148148,
    b_qlife_income_lvl = 1 => 0.3339920949,
    b_qlife_income_lvl = 2 => 0.3783783784,
    b_qlife_income_lvl = 3 => 0.3915343915,
    b_qlife_income_lvl = 4 => 0.4336598397,
    b_qlife_income_lvl = 5 => 0.4825493171,
    b_qlife_income_lvl = 6 => 0.5179282869,
    b_qlife_income_lvl = 7 => 0.5719506624,
                              0.4811656006);

b_c_easiqlife_c := if(C_EASIQLIFE = '', 100, max(min((real)C_EASIQLIFE, 170), 30));

b_c_span_lang_c := if(C_SPAN_LANG = '', 100, max(min((real)C_SPAN_LANG, 200), 25));

b_c_span_lang_srt := sqrt(b_c_span_lang_c);

attr_date_last_derog2 := models.common.sas_date((string)(attr_date_last_derog));

mth_attr_date_last_derog := if(min(sysdate, attr_date_last_derog2) = NULL, NULL, (sysdate - attr_date_last_derog2) / 30.5);

b_derog_last2yrs := mth_attr_date_last_derog != NULL AND mth_attr_date_last_derog <= 24;

ver_src_fr := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'FR', ',') > 0;

b_foreclosure_history := (integer)ver_src_fr > 0 or (integer)foreclosure_flag > 0;

impulse_email := (integer)indexw(StringLib.StringToUpperCase(trim(email_source_list, ALL)), 'IM', ',') > 0;

payday_loan_flag := impulse_count > 0 OR (impulse_email or Inq_HighRiskCredit_count > 0);

b_derog_severity_v2 := map(
    attr_eviction_count24 > 0                                 => 6,
    payday_loan_flag AND b_derog_last2yrs OR felony_count > 0 => 5,
    b_foreclosure_history                                     => 4,
    payday_loan_flag OR b_derog_last2yrs AND NOT(bankrupt)    => 3,
    b_derog_last2yrs OR NOT(bankrupt)                         => 2,
                                                                 1);

b_derog_severity_v2_m := map(
    b_derog_severity_v2 = 1 => 0.567251462,
    b_derog_severity_v2 = 2 => 0.51231011,
    b_derog_severity_v2 = 3 => 0.4515151515,
    b_derog_severity_v2 = 4 => 0.4250681199,
    b_derog_severity_v2 = 5 => 0.371040724,
    b_derog_severity_v2 = 6 => 0.3445945946,
                               0.4811656006);

b_rel_recency := map(
    attr_num_rel_liens12 > 0                                               => 4,
    attr_num_rel_liens36 > 0                                               => 3,
    attr_num_rel_liens60 > 0                                               => 2,
    liens_recent_released_count > 0 or liens_historical_released_count > 0 => 1,
                                                                              0);

b_rel_recency_m := map(
    b_rel_recency = 0 => 0.4641638225,
    b_rel_recency = 1 => 0.5124153499,
    b_rel_recency = 2 => 0.525862069,
    b_rel_recency = 3 => 0.5314814815,
    b_rel_recency = 4 => 0.5512820513,
                         0.4811656006);

liens_unrel_cj_first_seen2 := models.common.sas_date((string)(liens_unrel_cj_first_seen));

mth_liens_unrel_cj_first_seen := if(min(sysdate, liens_unrel_cj_first_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_first_seen2) / 30.5);

liens_unrel_cj_last_seen2 := models.common.sas_date((string)(liens_unrel_cj_last_seen));

mth_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

b_cj_lien_lvl_c11 := map(
    mth_liens_unrel_cj_last_seen = NULL AND mth_liens_unrel_cj_first_seen = NULL => 2,
    mth_liens_unrel_cj_last_seen <= 24 AND mth_liens_unrel_cj_first_seen <= 48   => 3,
                                                                                    4);

b_cj_lien_lvl_c12 := map(
    mth_liens_unrel_cj_last_seen = NULL AND mth_liens_unrel_cj_first_seen = NULL => 1,
    mth_liens_unrel_cj_last_seen <= 24 AND mth_liens_unrel_cj_first_seen <= 48   => 0,
                                                                                    2);

b_cj_lien_lvl := if(liens_rel_cj_ct > 0, b_cj_lien_lvl_c11, b_cj_lien_lvl_c12);

b_cj_lien_lvl_m := map(
    b_cj_lien_lvl = 0 => 0.391776571,
    b_cj_lien_lvl = 1 => 0.4878232488,
    b_cj_lien_lvl = 2 => 0.5027262814,
    b_cj_lien_lvl = 3 => 0.5494736842,
    b_cj_lien_lvl = 4 => 0.5795148248,
                         0.4811656006);

b_inq_lvl_v2 := map(
    Inq_Collection_count03 > 2                      => 7,
    Inq_count03 > 2 OR Inq_HighRiskCredit_count > 0 => 6,
    Inq_count03 > 1                                 => 5,
    Inq_count06 > 0                                 => 4,
    Inq_count12 > 0                                 => 3,
    Inq_count24 > 0                                 => 2,
    Inq_count > 0                                   => 1,
                                                       0);

b_inq_lvl_v2_m := map(
    b_inq_lvl_v2 = 0 => 0.5424657534,
    b_inq_lvl_v2 = 1 => 0.5116883117,
    b_inq_lvl_v2 = 2 => 0.5042935207,
    b_inq_lvl_v2 = 3 => 0.4929101958,
    b_inq_lvl_v2 = 4 => 0.4641670622,
    b_inq_lvl_v2 = 5 => 0.456097561,
    b_inq_lvl_v2 = 6 => 0.4208955224,
    b_inq_lvl_v2 = 7 => 0.3594771242,
                        0.4811656006);

b_c_blue_collar := map(
    (real)C_BLUE_EMPL < 30  => 30,
    (real)C_BLUE_EMPL < 70  => 70,
    (real)C_BLUE_EMPL < 120 => 120,
    (real)C_BLUE_EMPL < 160 => 160,
                               161);

b_c_blue_collar_m := map(
    b_c_blue_collar = 30  => 0.3940972222,
    b_c_blue_collar = 70  => 0.4420344054,
    b_c_blue_collar = 120 => 0.4727090636,
    b_c_blue_collar = 160 => 0.4923273657,
    b_c_blue_collar = 161 => 0.5464445868,
                             0.4811656006);

lb_age := map(
    age > 0                 => age,
    (real)input_dob_age > 0 => (real)input_dob_age,
    inferred_age > 0        => inferred_age,
                               -1);

b_age_lvl := map(
    lb_age <= 25 => 1,
    lb_age <= 35 => 2,
    lb_age <= 55 => 3,
    lb_age <= 60 => 4,
    lb_age <= 65 => 5,
                    6);

b_age_lvl_m := map(
    b_age_lvl = 1 => 0.4212454212,
    b_age_lvl = 2 => 0.4836653386,
    b_age_lvl = 3 => 0.4989532449,
    b_age_lvl = 4 => 0.4774774775,
    b_age_lvl = 5 => 0.3885542169,
    b_age_lvl = 6 => 0.3380952381,
                     0.4811656006);

b_verx_lvl_v2 := map(
    rc_addrcount > 8                                                                                          => 5,
    rc_addrcount > 5 AND fname_eda_sourced_type != ' ' AND lname_eda_sourced_type != ' ' AND nas_summary = 12 => 4,
    rc_addrcount > 3                                                                                          => 3,
    fname_eda_sourced_type != ' ' AND lname_eda_sourced_type != ' ' AND nas_summary = 12                      => 2,
    nas_summary = 12                                                                                          => 1,
                                                                                                                 0);

b_verx_lvl_v2_m := map(
    b_verx_lvl_v2 = 0 => 0.3867924528,
    b_verx_lvl_v2 = 1 => 0.3960176991,
    b_verx_lvl_v2 = 2 => 0.436746988,
    b_verx_lvl_v2 = 3 => 0.4973125884,
    b_verx_lvl_v2 = 4 => 0.528363047,
    b_verx_lvl_v2 = 5 => 0.6538461538,
                         0.4811656006);

b_paw_lvl := map(
    PAW_Dead_business_count > 1 => 4,
    PAW_Dead_business_count > 0 => 3,
                                   min(if(PAW_Business_count = NULL, -NULL, PAW_Business_count), 2));

b_paw_lvl_m := map(
    b_paw_lvl = 0 => 0.504502312,
    b_paw_lvl = 1 => 0.4973089343,
    b_paw_lvl = 2 => 0.3743315508,
    b_paw_lvl = 3 => 0.3646723647,
    b_paw_lvl = 4 => 0.3205128205,
                     0.4811656006);

b_stability_lvl := map(
    (real)addr_stability_v2 = 6 AND (attr_addrs_last36 in [0, 1])                                        => 4,
    (attr_addrs_last36 in [0, 1]) OR (attr_addrs_last36 in [2, 3]) AND (addr_stability_v2 in ['5', '6']) => 3,
    (attr_addrs_last36 in [2, 3])                                                                        => 2,
    attr_addrs_last36 = 4 OR attr_addrs_last36 > 4 AND (real)addr_stability_v2 = 6                       => 1,
                                                                                                            0);

b_stability_lvl_m := map(
    b_stability_lvl = 0 => 0.3563336766,
    b_stability_lvl = 1 => 0.4281481481,
    b_stability_lvl = 2 => 0.4693446089,
    b_stability_lvl = 3 => 0.5028694405,
    b_stability_lvl = 4 => 0.5760495526,
                           0.4811656006);

business_bk := (integer)indexw(StringLib.StringToUpperCase(trim(bus_addr_sources, ALL)), 'BK', ',') > 0;

business_lien := (integer)indexw(StringLib.StringToUpperCase(trim(bus_addr_sources, ALL)), 'L2', ',') > 0;

b_derog_busihdr_hit := business_bk OR business_lien;

nhood_growth := map(
    add1_Nhood_avg_assessed_amount <= 0 OR add1_Nhood_avg_purchase_amount <= 0 => -1,
    add1_Nhood_avg_assessed_amount >= add1_Nhood_avg_purchase_amount           => 2,
    add1_Nhood_avg_assessed_amount < add1_Nhood_avg_purchase_amount            => 1,
                                                                                  -1);

home_growth := map(
    add1_avm_automated_valuation <= 0 OR add1_purchase_amount <= 0 => -1,
    add1_avm_automated_valuation >= add1_purchase_amount           => 2,
    add1_avm_automated_valuation < add1_purchase_amount            => 1,
                                                                      -1);

b_input_avm_growth := if(nhood_growth = 2 AND home_growth = 2, 3, nhood_growth);

b_input_avm_growth_m := map(
    b_input_avm_growth = -1 => 0.4029163469,
    b_input_avm_growth = 1  => 0.4529512404,
    b_input_avm_growth = 2  => 0.5229090909,
    b_input_avm_growth = 3  => 0.5636645963,
                               0.4811656006);

b_util_adl_count := map(
    util_adl_count > 8 => 9,
    util_adl_count > 4 => 5,
    util_adl_count > 2 => 3,
                          util_adl_count);

b_util_adl_count_m := map(
    b_util_adl_count = 0 => 0.5401322002,
    b_util_adl_count = 1 => 0.4950773558,
    b_util_adl_count = 2 => 0.4839622642,
    b_util_adl_count = 3 => 0.4471947195,
    b_util_adl_count = 5 => 0.4046783626,
    b_util_adl_count = 9 => 0.3695652174,
                            0.4811656006);

lb_price_per_sft := if(add1_purchase_amount <= 0 or (real)add1_building_area <= 0, -1, round(add1_purchase_amount / (real)add1_building_area));

rel_price_per_sft := if(lb_price_per_sft <= 0 or add1_Nhood_avg_price_per_sf <= 0, -1, truncate(lb_price_per_sft / add1_Nhood_avg_price_per_sf * 100));

b_input_rel_ppsft_gtmed := rel_price_per_sft >= 100;

source1 := models.common.getw(ver_sources, 1, ',');

source2 := models.common.getw(ver_sources, 2, ',');

positive_source2 := map(
    source2 = ' '                                                                                                    => 'Missing',
    (source2 in ['AM', 'AR', 'EB', 'EM', 'VO', 'MW', 'P', 'PL', 'SL', 'WP', 'E1', 'E2', 'E3', 'E4', 'W', 'V', 'CY']) => 'Positive',
    (source2 in ['EQ', 'EN', 'TU', 'TN', 'TS'])                                                                      => 'Credit Bureau',
    (source2 in ['AK', 'BA', 'CG', 'CO', 'DA', 'DS', 'DE', 'FF', 'L2', 'LI', 'D', 'NT', 'FR'])                       => 'Negative',
                                                                                                                        'Unknown');

positive_source1 := map(
    source1 = ' '                                                                                                    => 'Missing',
    (source1 in ['AM', 'AR', 'EB', 'EM', 'VO', 'MW', 'P', 'PL', 'SL', 'WP', 'E1', 'E2', 'E3', 'E4', 'W', 'V', 'CY']) => 'Positive',
    (source1 in ['EQ', 'EN', 'TU', 'TN', 'TS'])                                                                      => 'Credit Bureau',
    (source1 in ['AK', 'BA', 'CG', 'CO', 'DA', 'DS', 'DE', 'FF', 'L2', 'LI', 'D', 'NT', 'FR'])                       => 'Negative',
                                                                                                                        'Unknown');

b_source_seq := map(
    positive_source1 = 'Credit Bureau' AND positive_source2 = 'Credit Bureau' => 2,
    positive_source1 = 'Credit Bureau' AND positive_source2 = 'Positive'      => 1,
                                                                                 0);

b_source_seq_m := map(
    b_source_seq = 0 => 0.4184168013,
    b_source_seq = 1 => 0.4569732938,
    b_source_seq = 2 => 0.4888962,
                        0.4811656006);

b_both := -17.462529 +
    b_qlife_income_lvl_m * 2.6228184278 +
    b_c_easiqlife_c * 0.0005398683 +
    b_c_span_lang_c * -0.01535036 +
    b_c_span_lang_srt * 0.2383425239 +
    b_derog_severity_v2_m * 3.3456090374 +
    b_rel_recency_m * 2.7328042914 +
    b_cj_lien_lvl_m * 2.6565385213 +
    b_inq_lvl_v2_m * 2.5798633139 +
    b_c_blue_collar_m * 1.8469423466 +
    b_age_lvl_m * 3.7296041105 +
    b_verx_lvl_v2_m * 2.2384640203 +
    b_paw_lvl_m * 2.7809948049 +
    b_stability_lvl_m * 2.3532281201 +
    (integer)b_derog_busihdr_hit * -0.331395715 +
    b_input_avm_growth_m * 2.1140652447 +
    b_util_adl_count_m * 1.9799940459 +
    (integer)b_input_rel_ppsft_gtmed * 0.2642690162 +
    b_source_seq_m * 3.4510504729;

base := 700;

odds := 0.4514 / (1 - 0.4514);

point := 40;

phat := exp(b_both) / (1 + exp(b_both));

custom40_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

rsn1108_1_1 := round(min(if(max(custom40_mod, 501) = NULL, -NULL, max(custom40_mod, 501)), 900));

ver_src_l2 := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0;

ver_src_li := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0;

ver_src_ba := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0;

ver_src_ds := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

ver_src_de := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

ssn_deceased := (integer)ver_src_ds > 0 OR (integer)ver_src_de > 0 OR adl_category = '1 DEAD' OR (real)rc_decsflag = 1;

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (real)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

rsn1108_1 := if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 AND not(scored_222s), 222, rsn1108_1_1);


		#if(RSN_DEBUG)
			self.clam                             := le;
			self.truedid                          := truedid;
			self.adl_category                     := adl_category;
			self.nas_summary                      := nas_summary;
			self.nap_summary                      := nap_summary;
			self.rc_decsflag                      := rc_decsflag;
			self.rc_bansflag                      := rc_bansflag;
			self.rc_addrcount                     := rc_addrcount;
			self.combo_dobscore                   := combo_dobscore;
			self.ver_sources                      := ver_sources;
			self.bus_addr_sources                 := bus_addr_sources;
			self.fname_eda_sourced_type           := fname_eda_sourced_type;
			self.lname_eda_sourced_type           := lname_eda_sourced_type;
			self.age                              := age;
			self.util_adl_count                   := util_adl_count;
			self.add1_avm_automated_valuation     := add1_avm_automated_valuation;
			self.add1_naprop                      := add1_naprop;
			self.add1_purchase_amount             := add1_purchase_amount;
			self.add1_building_area               := add1_building_area;
			self.add1_nhood_avg_purchase_amount   := add1_nhood_avg_purchase_amount;
			self.add1_nhood_avg_assessed_amount   := add1_nhood_avg_assessed_amount;
			self.add1_nhood_avg_price_per_sf      := add1_nhood_avg_price_per_sf;
			self.property_owned_total             := property_owned_total;
			self.property_sold_total              := property_sold_total;
			self.inq_count                        := inq_count;
			self.inq_count03                      := inq_count03;
			self.inq_count06                      := inq_count06;
			self.inq_count12                      := inq_count12;
			self.inq_count24                      := inq_count24;
			self.inq_collection_count03           := inq_collection_count03;
			self.inq_highriskcredit_count         := inq_highriskcredit_count;
			self.paw_business_count               := paw_business_count;
			self.paw_dead_business_count          := paw_dead_business_count;
			self.impulse_count                    := impulse_count;
			self.email_source_list                := email_source_list;
			self.attr_addrs_last36                := attr_addrs_last36;
			self.attr_date_last_derog             := attr_date_last_derog;
			self.attr_num_rel_liens12             := attr_num_rel_liens12;
			self.attr_num_rel_liens36             := attr_num_rel_liens36;
			self.attr_num_rel_liens60             := attr_num_rel_liens60;
			self.attr_eviction_count24            := attr_eviction_count24;
			self.bankrupt                         := bankrupt;
			self.filing_count                     := filing_count;
			self.bk_recent_count                  := bk_recent_count;
			self.liens_recent_unreleased_count    := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct   := liens_historical_unreleased_ct;
			self.liens_recent_released_count      := liens_recent_released_count;
			self.liens_historical_released_count  := liens_historical_released_count;
			self.liens_unrel_cj_first_seen        := liens_unrel_cj_first_seen;
			self.liens_unrel_cj_last_seen         := liens_unrel_cj_last_seen;
			self.liens_rel_cj_ct                  := liens_rel_cj_ct;
			self.criminal_count                   := criminal_count;
			self.felony_count                     := felony_count;
			self.foreclosure_flag                 := foreclosure_flag;
			self.input_dob_age                    := input_dob_age;
			self.input_dob_match_level            := input_dob_match_level;
			self.inferred_age                     := inferred_age;
			self.addr_stability_v2                := addr_stability_v2;
			self.estimated_income                 := estimated_income;
			self.archive_date                     := archive_date;
			self.C_BLUE_EMPL                      := C_BLUE_EMPL;
			self.C_EASIQLIFE                      := C_EASIQLIFE;
			self.C_SPAN_LANG                      := C_SPAN_LANG;
			self.sysdate                          := sysdate;
			self.b_qlife_income_lvl               := b_qlife_income_lvl;
			self.b_qlife_income_lvl_m             := b_qlife_income_lvl_m;
			self.b_c_easiqlife_c                  := b_c_easiqlife_c;
			self.b_c_span_lang_c                  := b_c_span_lang_c;
			self.b_c_span_lang_srt                := b_c_span_lang_srt;
			self.attr_date_last_derog2            := attr_date_last_derog2;
			self.mth_attr_date_last_derog         := mth_attr_date_last_derog;
			self.b_derog_last2yrs                 := b_derog_last2yrs;
			self.ver_src_fr                       := ver_src_fr;
			self.b_foreclosure_history            := b_foreclosure_history;
			self.impulse_email                    := impulse_email;
			self.payday_loan_flag                 := payday_loan_flag;
			self.b_derog_severity_v2              := b_derog_severity_v2;
			self.b_derog_severity_v2_m            := b_derog_severity_v2_m;
			self.b_rel_recency                    := b_rel_recency;
			self.b_rel_recency_m                  := b_rel_recency_m;
			self.liens_unrel_cj_first_seen2       := liens_unrel_cj_first_seen2;
			self.mth_liens_unrel_cj_first_seen    := mth_liens_unrel_cj_first_seen;
			self.liens_unrel_cj_last_seen2        := liens_unrel_cj_last_seen2;
			self.mth_liens_unrel_cj_last_seen     := mth_liens_unrel_cj_last_seen;
			self.b_cj_lien_lvl_c11                := b_cj_lien_lvl_c11;
			self.b_cj_lien_lvl_c12                := b_cj_lien_lvl_c12;
			self.b_cj_lien_lvl                    := b_cj_lien_lvl;
			self.b_cj_lien_lvl_m                  := b_cj_lien_lvl_m;
			self.b_inq_lvl_v2                     := b_inq_lvl_v2;
			self.b_inq_lvl_v2_m                   := b_inq_lvl_v2_m;
			self.b_c_blue_collar                  := b_c_blue_collar;
			self.b_c_blue_collar_m                := b_c_blue_collar_m;
			self.lb_age                           := lb_age;
			self.b_age_lvl                        := b_age_lvl;
			self.b_age_lvl_m                      := b_age_lvl_m;
			self.b_verx_lvl_v2                    := b_verx_lvl_v2;
			self.b_verx_lvl_v2_m                  := b_verx_lvl_v2_m;
			self.b_paw_lvl                        := b_paw_lvl;
			self.b_paw_lvl_m                      := b_paw_lvl_m;
			self.b_stability_lvl                  := b_stability_lvl;
			self.b_stability_lvl_m                := b_stability_lvl_m;
			self.business_bk                      := business_bk;
			self.business_lien                    := business_lien;
			self.b_derog_busihdr_hit              := b_derog_busihdr_hit;
			self.nhood_growth                     := nhood_growth;
			self.home_growth                      := home_growth;
			self.b_input_avm_growth               := b_input_avm_growth;
			self.b_input_avm_growth_m             := b_input_avm_growth_m;
			self.b_util_adl_count                 := b_util_adl_count;
			self.b_util_adl_count_m               := b_util_adl_count_m;
			self.lb_price_per_sft                 := lb_price_per_sft;
			self.rel_price_per_sft                := rel_price_per_sft;
			self.b_input_rel_ppsft_gtmed          := b_input_rel_ppsft_gtmed;
			self.source1                          := source1;
			self.source2                          := source2;
			self.positive_source2                 := positive_source2;
			self.positive_source1                 := positive_source1;
			self.b_source_seq                     := b_source_seq;
			self.b_source_seq_m                   := b_source_seq_m;
			self.b_both                           := b_both;
			self.base                             := base;
			self.odds                             := odds;
			self.point                            := point;
			self.phat                             := phat;
			self.custom40_mod                     := custom40_mod;
			self.rsn1108_1_1                      := rsn1108_1_1;
			self.ver_src_l2                       := ver_src_l2;
			self.ver_src_li                       := ver_src_li;
			self.ver_src_ba                       := ver_src_ba;
			self.ver_src_ds                       := ver_src_ds;
			self.ver_src_de                       := ver_src_de;
			self.lien_flag                        := lien_flag;
			self.bk_flag                          := bk_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.scored_222s                      := scored_222s;
			self.rsn1108_1                        := rsn1108_1;

		#end

		self.seq := (string)le.seq;
		self.recover_score := (string)rsn1108_1;
	end;


	model := JOIN(clam, EASI.Key_Easi_Census, 
							KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
							doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.Max_Atmost), KEEP(1));

	RETURN(model);
END;

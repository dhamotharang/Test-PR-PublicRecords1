IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, EASI, std;

EXPORT rsn1103_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;
			Models.Layout_RecoverScore;

			/* Model Input Variables */
			INTEGER adl_dob;
			INTEGER adl_ssn;
			INTEGER in_ssnpop;
			INTEGER adl_addr;
			INTEGER in_addrpop_found;
			STRING c_civ_emp;
			STRING c_hhsize;
			STRING c_easiqlife;
			STRING c_asian_lang;
			BOOLEAN truedid;
			STRING adl_category;
			STRING in_state;
			INTEGER did_count;
			STRING rc_hphonevalflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_pwssnvalflag;
			STRING rc_ssnstate;
			INTEGER rc_numelever;
			INTEGER combo_dobscore;
			INTEGER util_adl_count;
			BOOLEAN add1_house_number_match;
			INTEGER add1_avm_automated_valuation;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			INTEGER add1_assessed_amount;
			INTEGER property_owned_total;
			INTEGER prop1_sale_price;
			INTEGER prop2_sale_price;
			STRING gong_did_last_seen;
			INTEGER gong_did_first_ct;
			INTEGER gong_did_last_ct;
			INTEGER ssns_per_adl;
			INTEGER ssns_per_adl_c6;
			INTEGER dl_addrs_per_adl;
			INTEGER vo_addrs_per_adl;
			INTEGER pl_addrs_per_adl;
			INTEGER attr_num_purchase60;
			INTEGER attr_num_sold60;
			INTEGER attr_total_number_derogs;
			INTEGER attr_arrests;
			INTEGER attr_num_nonderogs;
			INTEGER date_last_seen;
			STRING disposition;
			INTEGER liens_unrel_cj_ct;
			INTEGER liens_unrel_cj_total_amount;
			INTEGER liens_rel_cj_ct;
			INTEGER liens_rel_cj_first_seen;
			INTEGER liens_rel_cj_total_amount;
			INTEGER liens_unrel_ft_ct;
			INTEGER liens_unrel_ft_first_seen;
			INTEGER liens_rel_ft_ct;
			INTEGER liens_unrel_ot_ct;
			INTEGER liens_unrel_ot_total_amount;
			INTEGER liens_rel_ot_ct;
			INTEGER liens_rel_ot_first_seen;
			INTEGER liens_rel_ot_last_seen;
			INTEGER liens_unrel_sc_ct;
			INTEGER liens_unrel_sc_total_amount;
			INTEGER liens_rel_sc_ct;
			INTEGER liens_rel_sc_first_seen;
			INTEGER liens_rel_sc_last_seen;
			INTEGER liens_rel_sc_total_amount;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER rel_count;
			INTEGER rel_incomeunder25_count;
			INTEGER ams_age;
			STRING ams_college_code;
			BOOLEAN prof_license_flag;
			INTEGER input_dob_age;
			INTEGER inferred_age;
			INTEGER reported_dob;

			/* Model Intermediate Variables */
			INTEGER archive_date;
			INTEGER sysdate;
			BOOLEAN core_adl;
			BOOLEAN single_did;
			INTEGER did_ver_lvl;
			REAL did_ver_lvl_m;
			INTEGER prop_sale_history;
			REAL prop_sale_history_m;
			INTEGER adl_match_lvl;
			REAL adl_match_lvl_m;
			INTEGER criminal_level;
			REAL criminal_level_m;
			INTEGER discharged_bk_f;
			INTEGER _date_last_seen;
			INTEGER yrs_bk_last_seen;
			INTEGER bk_lvl;
			REAL bk_lvl_m;
			INTEGER total_recs;
			INTEGER derog_ratio_c12;
			INTEGER derog_ratio;
			INTEGER derog_ratio2;
			REAL derog_ratio2_m;
			INTEGER _reported_dob;
			INTEGER reported_age;
			INTEGER applicant_age;
			INTEGER applicant_age_lvl;
			REAL applicant_age_lvl_m;
			INTEGER _liens_rel_cj_first_seen;
			INTEGER mos_cj_rel_first_seen;
			INTEGER liens_cj_lvl;
			REAL liens_cj_lvl_m;
			INTEGER _liens_unrel_ft_first_seen;
			INTEGER mos_ft_unrel_last_seen;
			INTEGER liens_ft_lvl;
			REAL liens_ft_lvl_m;
			INTEGER _liens_rel_ot_first_seen;
			INTEGER mos_ot_rel_first_seen;
			INTEGER _liens_rel_ot_last_seen;
			INTEGER mos_ot_rel_last_seen;
			INTEGER liens_ot_lvl;
			REAL liens_ot_lvl_m;
			INTEGER _liens_rel_sc_first_seen;
			INTEGER mos_sc_rel_first_seen;
			INTEGER _liens_rel_sc_last_seen;
			INTEGER mos_sc_rel_last_seen;
			INTEGER liens_sc_lvl;
			REAL liens_sc_lvl_m;
			INTEGER education_lvl;
			REAL education_lvl_m;
			INTEGER dl_addrs_per_adl_lvl;
			INTEGER vo_addrs_per_adl_lvl;
			INTEGER addr_immobility_lvl;
			REAL addr_immobility_lvl_m;
			INTEGER c_civ_emp_lvl;
			REAL c_civ_emp_lvl_m;
			INTEGER sold_purch_lvl;
			REAL sold_purch_lvl_m;
			INTEGER rel_count_lvl;
			REAL rel_count_lvl_m;
			INTEGER util_adl_count_c;
			BOOLEAN family_owned;
			BOOLEAN app_owned;
			BOOLEAN stolen_addr;
			BOOLEAN nothing_found;
			BOOLEAN property_owner;
			REAL addrmod_log;
			REAL addrmod;
			BOOLEAN ssn_priordob;
			BOOLEAN ssn_inval;
			BOOLEAN ssn_issued18;
			BOOLEAN ssn_statediff;
			BOOLEAN ssn_deceased;
			BOOLEAN ssn_adl_prob;
			REAL ssnprob_log;
			REAL ssnprobmod;
			REAL _c_hhsize;
			REAL _c_easiqlife;
			INTEGER _c_asian_lang;
			INTEGER _gong_did_last_seen;
			INTEGER mos_since_gong_last_seen;
			BOOLEAN phn_last_seen_rec;
			BOOLEAN phn_residential;
			BOOLEAN phn_good_counts;
			REAL phoneproblog;
			REAL phoneprobmod;
			INTEGER rel_incomeunder25_count_c;
			REAL rel_incomeunder25_count_lg;
			INTEGER add1_value;
			INTEGER add1_valuation_c;
			REAL add1_valuation_lg;
			REAL asst_log;
			REAL phat;
			INTEGER base;
			INTEGER point;
			REAL odds;
			INTEGER asst_mod;
			INTEGER rsn1103_1_0;
		END;
		Layout_Debug doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM
	#else
		Layout_RecoverScore doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_dob                          := le.ADL_Shell_Flags.adl_dob; // Results of ADL search on DOB
	adl_ssn                          := le.ADL_Shell_Flags.adl_ssn; // Results of ADL search on SSN
	in_ssnpop                        := le.ADL_Shell_Flags.in_ssnpop; // Was ssn populated on input from consumer
	adl_addr                         := le.ADL_Shell_Flags.adl_addr; // Results of ADL search on address
	in_addrpop_found                 := le.ADL_Shell_Flags.in_addrpop_found; // Did input address match database address
	c_civ_emp                        := ri.civ_emp;
	c_hhsize                         := ri.hhsize;
	c_easiqlife                      := ri.easiqlife;
	c_asian_lang                     := ri.asian_lang;
	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	in_state                         := le.shell_input.in_state;
	did_count                        := le.iid.didcount;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnstate                      := le.iid.soclstate;
	rc_numelever                     := le.iid.numelever;
	combo_dobscore                   := le.iid.combo_dobscore;
	util_adl_count                   := le.utility.utili_adl_count;
	add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
	property_owned_total             := le.address_verification.owned.property_total;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
	gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_sold60                  := le.other_address_info.num_sold60;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	date_last_seen                   := le.bjl.date_last_seen;
	disposition                      := le.bjl.disposition;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_unrel_ft_first_seen        := le.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_rel_sc_first_seen          := le.liens.liens_released_small_claims.earliest_filing_date;
	liens_rel_sc_last_seen           := le.liens.liens_released_small_claims.most_recent_filing_date;
	liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	rel_count                        := le.relatives.relative_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	ams_age                          := (INTEGER)le.student.age;
	ams_college_code                 := le.student.college_code;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_age                    := (INTEGER)le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER contains_i(string haystack, string needle) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		
	sysdate := Common.SAS_Date((STRING)archive_date);
	
	core_adl := adl_category[1] = '8';
	
	single_did := did_count = 1;
	
	did_ver_lvl := map(
	    not(core_adl)                                                             => 3,
	    adl_dob = 0                                                      				 	=> 2,
	    core_adl and not(single_did and rc_numelever > 3) or combo_dobscore = 255 => 0,
	    combo_dobscore < 100                                                      => 1,
	                                                                                 0);
	
	did_ver_lvl_m := map(
	    did_ver_lvl = 0 => 0.2954275574,
	    did_ver_lvl = 1 => 0.2562559392,
	    did_ver_lvl = 2 => 0.18798151,
	                       0.118226601);
	
	prop_sale_history := map(
	    prop2_sale_price > 0 => 2,
	    prop1_sale_price > 0 => 1,
	                            0);
	
	prop_sale_history_m := map(
	    prop_sale_history = 0 => 0.2873782351,
	    prop_sale_history = 1 => 0.257196389,
	                             0.218648473);
	
	adl_match_lvl := map(
	    adl_ssn != 2 and (boolean)(integer)in_ssnpop        => 0,
	    adl_addr = 2                                        => 3,
	    adl_addr = 3 and (boolean)(integer)in_addrpop_found => 2,
	    adl_addr != 0                                       => 1,
	                                                           0);
	
	adl_match_lvl_m := map(
	    adl_match_lvl = 0 => 0.1017612524,
	    adl_match_lvl = 1 => 0.2479368822,
	    adl_match_lvl = 2 => 0.2543001549,
	                         0.3109606293);
	
	criminal_level := map(
	    attr_arrests > 0   => 4,
	    felony_count > 0   => 3,
	    criminal_count > 3 => 2,
	    criminal_count > 0 => 1,
	                          0);
	
	criminal_level_m := map(
	    criminal_level = 0 => 0.2860363924,
	    criminal_level = 1 => 0.2774876921,
	    criminal_level = 2 => 0.2669456067,
	    criminal_level = 3 => 0.186013986,
	                          0.1460055096);
	
	discharged_bk_f := contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARGE');
	
	_date_last_seen := Common.SAS_Date((STRING)date_last_seen);
	
	yrs_bk_last_seen := IF(MIN(sysdate, _date_last_seen) = NULL, NULL, truncate((sysdate - _date_last_seen) / 365.25));
	
	bk_lvl := map(
	    0 <= yrs_bk_last_seen AND yrs_bk_last_seen < 7 and discharged_bk_f = 1 => 2,
	    Discharged_BK_f = 1                                                		 => 1,
																																								0);
	
	bk_lvl_m := map(
	    bk_lvl = 0 => 0.2793394192,
	    bk_lvl = 1 => 0.289569378,
	                  0.3651626443);
	
	total_recs := if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs)));
	
	derog_ratio_c12 := if(attr_total_number_derogs = 0, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10) * 10 + 100, if (attr_total_number_derogs * 100 / total_recs / 10 >= 0, roundup(attr_total_number_derogs * 100 / total_recs / 10), truncate(attr_total_number_derogs * 100 / total_recs / 10)) * 10);
	
	derog_ratio := if(total_recs > 0, derog_ratio_c12, 100);
	
	derog_ratio2 := map(
	    derog_ratio >= 180                 => 9,
	    (derog_ratio in [10, 170])         => 8,
	    derog_ratio = 160                  => 7,
	    (derog_ratio in [20, 150])         => 6,
	    (derog_ratio in [30, 140])         => 5,
	    (derog_ratio in [40, 130, 120])    => 4,
	    derog_ratio = 50                   => 3,
	    derog_ratio = 60                   => 2,
	    (derog_ratio in [70, 80, 90, 110]) => 1,
	                                          0);
	
	derog_ratio2_m := map(
	    derog_ratio2 = 0 => 0.0642201835,
	    derog_ratio2 = 1 => 0.1988663203,
	    derog_ratio2 = 2 => 0.2348790323,
	    derog_ratio2 = 3 => 0.243145943,
	    derog_ratio2 = 4 => 0.2537263774,
	    derog_ratio2 = 5 => 0.2728651792,
	    derog_ratio2 = 6 => 0.2965233383,
	    derog_ratio2 = 7 => 0.3241601144,
	    derog_ratio2 = 8 => 0.3534671841,
	                        0.3832335329);
	
	_reported_dob := Common.SAS_Date((STRING)reported_dob);
	
	reported_age := IF(MIN(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
	
	applicant_age := map(
	    input_dob_age > 0 => input_dob_age,
	    inferred_age > 0  => inferred_age,
	    reported_age > 0  => reported_age,
	    ams_age > 0       => ams_age,
	                        -1);
	
	applicant_age_lvl := map(
	    applicant_age <= 25 => 65,
	    applicant_age <= 35 => 35,
	    applicant_age <= 55 => 55,
	    applicant_age <= 65 => 60,
	    applicant_age <= 75 => 75,
	                           80);
	
	applicant_age_lvl_m := map(
	    applicant_age_lvl = 35 => 0.3147835269,
	    applicant_age_lvl = 55 => 0.2875414935,
	    applicant_age_lvl = 60 => 0.266199138,
	    applicant_age_lvl = 65 => 0.2329164401,
	    applicant_age_lvl = 75 => 0.2180387749,
	                              0.1834002677);
	
	_liens_rel_cj_first_seen := Common.SAS_Date((STRING)liens_rel_CJ_first_seen);
	
	mos_cj_rel_first_seen := IF(MIN(sysdate, _liens_rel_cj_first_seen) = NULL, NULL, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)));
	
	liens_cj_lvl := map(
	    0 <= mos_cj_rel_first_seen AND mos_cj_rel_first_seen <= 12           => 9,
	    1 <= liens_rel_CJ_total_amount AND liens_rel_CJ_total_amount <= 4000 => 8,
	    liens_unrel_CJ_ct != 0 and liens_rel_CJ_ct > 0                       => 7,
	    liens_unrel_CJ_total_amount = 0                                      => 7,
	    liens_unrel_CJ_total_amount <= 1000                                  => 6,
	    liens_unrel_CJ_total_amount <= 2000                                  => 5,
	    liens_unrel_CJ_total_amount <= 7000                                  => 4,
	    liens_unrel_CJ_total_amount <= 15000                                 => 3,
	    liens_unrel_CJ_total_amount <= 25000                                 => 2,
	                                                                            1);
	
	liens_cj_lvl_m := map(
	    liens_cj_lvl = 1 => 0.139321075,
	    liens_cj_lvl = 2 => 0.1544804838,
	    liens_cj_lvl = 3 => 0.2049512987,
	    liens_cj_lvl = 4 => 0.2452453628,
	    liens_cj_lvl = 5 => 0.2657383232,
	    liens_cj_lvl = 6 => 0.2720403023,
	    liens_cj_lvl = 7 => 0.2948398062,
	    liens_cj_lvl = 8 => 0.3496397421,
	                        0.3869863014);
	
	_liens_unrel_ft_first_seen := Common.SAS_Date((STRING)liens_unrel_FT_first_seen);
	
	mos_ft_unrel_last_seen := IF(MIN(sysdate, _liens_unrel_ft_first_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)));
	
	liens_ft_lvl := map(
	    0 <= mos_ft_unrel_last_seen AND mos_ft_unrel_last_seen <= 24 => 3,
	    liens_unrel_FT_ct > 1                                        => 2,
	    liens_unrel_FT_ct > 0 or liens_rel_FT_ct > 0                 => 1,
	                                                                    0);
	
	liens_ft_lvl_m := map(
	    liens_ft_lvl = 0 => 0.2851534099,
	    liens_ft_lvl = 1 => 0.2409867173,
	    liens_ft_lvl = 2 => 0.2033898305,
	                        0.1879021879);
	
	_liens_rel_ot_first_seen := Common.SAS_Date((STRING)liens_rel_OT_first_seen);
	
	mos_ot_rel_first_seen := IF(MIN(sysdate, _liens_rel_ot_first_seen) = NULL, NULL, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)));
	
	_liens_rel_ot_last_seen := Common.SAS_Date((STRING)liens_rel_OT_last_seen);
	
	mos_ot_rel_last_seen := IF(MIN(sysdate, _liens_rel_ot_last_seen) = NULL, NULL, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)));
	
	liens_ot_lvl := map(
	    0 <= mos_ot_rel_first_seen AND mos_ot_rel_first_seen <= 24 => 4,
	    0 <= mos_ot_rel_last_seen AND mos_ot_rel_last_seen <= 24   => 4,
	    liens_unrel_OT_ct = 0                                      => 3,
	    liens_rel_OT_ct > 0                                        => 2,
	    liens_unrel_OT_total_amount < 4000                         => 1,
	                                                                  0);
	
	liens_ot_lvl_m := map(
	    liens_ot_lvl = 0 => 0.1841059603,
	    liens_ot_lvl = 1 => 0.2236053481,
	    liens_ot_lvl = 2 => 0.2655670103,
	    liens_ot_lvl = 3 => 0.2851567466,
	                        0.3236842105);
	
	_liens_rel_sc_first_seen := Common.SAS_Date((STRING)liens_rel_SC_first_seen);
	
	mos_sc_rel_first_seen := IF(MIN(sysdate, _liens_rel_sc_first_seen) = NULL, NULL, truncate((sysdate - _liens_rel_sc_first_seen) / (365.25 / 12)));
	
	_liens_rel_sc_last_seen := Common.SAS_Date((STRING)liens_rel_SC_last_seen);
	
	mos_sc_rel_last_seen := IF(MIN(sysdate, _liens_rel_sc_last_seen) = NULL, NULL, truncate((sysdate - _liens_rel_sc_last_seen) / (365.25 / 12)));
	
	liens_sc_lvl := map(
	    liens_rel_SC_total_amount >= 2000                                                                                      => 6,
	    0 <= mos_sc_rel_first_seen AND mos_sc_rel_first_seen <= 12 or 0 <= mos_sc_rel_last_seen AND mos_sc_rel_last_seen <= 12 => 6,
	    liens_rel_SC_ct > 0                                                                                                    => 5,
	    liens_unrel_SC_ct = 0                                                                                                  => 4,
	    liens_unrel_SC_total_amount <= 1000                                                                                    => 3,
	    liens_unrel_SC_total_amount <= 4000                                                                                    => 2,
	    liens_unrel_SC_total_amount <= 7000                                                                                    => 1,
	                                                                                                                              0);
	
	liens_sc_lvl_m := map(
	    liens_sc_lvl = 0 => 0.1583629893,
	    liens_sc_lvl = 1 => 0.203444564,
	    liens_sc_lvl = 2 => 0.2430923807,
	    liens_sc_lvl = 3 => 0.2626421011,
	    liens_sc_lvl = 4 => 0.2842408092,
	    liens_sc_lvl = 5 => 0.3339646465,
	                        0.451287794);
	
	education_lvl := map(
	    ams_college_code > (string)0 and prof_license_flag      => 3,
	    ams_college_code > (string)0 and not(prof_license_flag) => 2,
	    prof_license_flag                                       => 1,
	                                                               0);
	
	education_lvl_m := map(
	    education_lvl = 0 => 0.2753677907,
	    education_lvl = 1 => 0.3218894009,
	    education_lvl = 2 => 0.3708791209,
	                         0.4190981432);
	
	dl_addrs_per_adl_lvl := map(
	    dl_addrs_per_adl > 7 => 4,
	    dl_addrs_per_adl > 3 => 3,
	    dl_addrs_per_adl > 1 => 2,
	    dl_addrs_per_adl > 0 => 1,
	                            0);
	
	vo_addrs_per_adl_lvl := map(
	    vo_addrs_per_adl > 4 => 3,
	    vo_addrs_per_adl > 1 => 2,
	    vo_addrs_per_adl > 0 => 1,
	                            0);
	
	addr_immobility_lvl := map(
	    pl_addrs_per_adl > 0 and (dl_addrs_per_adl_lvl > 0 or vo_addrs_per_adl_lvl > 0) => 3,
	    dl_addrs_per_adl_lvl = 4 or vo_addrs_per_adl_lvl = 3                            => 4,
	    dl_addrs_per_adl_lvl > 1 and vo_addrs_per_adl_lvl = 2                           => 4,
	    dl_addrs_per_adl_lvl > 0 and vo_addrs_per_adl_lvl > 0                           => 3,
	    vo_addrs_per_adl_lvl > 0 or pl_addrs_per_adl > 0                                => 2,
	    dl_addrs_per_adl_lvl > 0                                                        => 1,
	                                                                                       0);
	
	addr_immobility_lvl_m := map(
	    addr_immobility_lvl = 0 => 0.2443610003,
	    addr_immobility_lvl = 1 => 0.2756289308,
	    addr_immobility_lvl = 2 => 0.2929129425,
	    addr_immobility_lvl = 3 => 0.3451015004,
	                               0.3695358269);
	
	c_civ_emp_lvl := map(
	    (INTEGER)C_CIV_EMP >= 70 => 3,
	    (INTEGER)C_CIV_EMP >= 60 => 2,
	    (INTEGER)C_CIV_EMP >= 50 => 1,
	                               0);
	
	c_civ_emp_lvl_m := map(
	    c_civ_emp_lvl = 0 => 0.2513731826,
	    c_civ_emp_lvl = 1 => 0.2723485654,
	    c_civ_emp_lvl = 2 => 0.2960905789,
	                         0.3127035831);
	
	sold_purch_lvl := map(
	    (attr_num_purchase60 in [1, 2]) and attr_num_sold60 = 0 => 3,
	    attr_num_purchase60 = 0 and attr_num_sold60 = 0         => 2,
	    attr_num_purchase60 > 2 and attr_num_sold60 = 0         => 1,
	    attr_num_purchase60 < 3 and attr_num_sold60 = 1         => 1,
	                                                               0);
	
	sold_purch_lvl_m := map(
	    sold_purch_lvl = 0 => 0.1936549901,
	    sold_purch_lvl = 1 => 0.2464285714,
	    sold_purch_lvl = 2 => 0.2816305407,
	                          0.3242360007);
	
	rel_count_lvl := map(
	    not(truedid) and rel_count = 0   => 0,
	    not(truedid) or rel_count = 0    => 1,
	    rel_count = 1 or rel_count >= 25 => 2,
	    rel_count > 20                   => 3,
	    rel_count = 2                    => 4,
	    rel_count = 3 or rel_count > 7   => 5,
	                                        6);
	
	rel_count_lvl_m := map(
	    rel_count_lvl = 0 => 0.047146402,
	    rel_count_lvl = 1 => 0.2007490637,
	    rel_count_lvl = 2 => 0.230359103,
	    rel_count_lvl = 3 => 0.2411160059,
	    rel_count_lvl = 4 => 0.2766447368,
	    rel_count_lvl = 5 => 0.2829663864,
	                         0.3114632335);
	
	util_adl_count_c := min(if(max(util_adl_count, 0) = NULL, -NULL, max(util_adl_count, 0)), 25);
	
	family_owned := add1_naprop = 3 or add1_family_owned;
	
	app_owned := add1_naprop = 4 and add1_applicant_owned and property_owned_total > 0;
	
	stolen_addr := (add1_naprop in [1, 2]);
	
	nothing_found := add1_naprop = 0;
	
	property_owner := property_owned_total > 0;
	
	addrmod_log := -1.7286 +
	    (integer)family_owned * 0.0790 +
	    (integer)app_owned * 0.2489 +
	    (integer)add1_house_number_match * 0.7310;
	
	addrmod := round(100 * exp(addrmod_log) / (1 + exp(addrmod_log))/.1)*.1;
	
	ssn_priordob := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;
	
	ssn_inval := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3']);
	
	ssn_issued18 := rc_pwssnvalflag = (string)5;
	
	ssn_statediff := StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT));
	
	ssn_deceased := rc_decsflag = (string)1;
	
	ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;
	
	ssnprob_log := -0.8188 +
	    (integer)ssn_priordob * -0.7124 +
	    (integer)ssn_inval * -1.2997 +
	    (integer)ssn_issued18 * -0.2534 +
	    (integer)ssn_statediff * -0.0874 +
	    (integer)ssn_deceased * -1.5032 +
	    (integer)ssn_adl_prob * -0.3331;
	
	ssnprobmod := round(100 * exp(ssnprob_log) / (1 + exp(ssnprob_log))/.1)*.1;
	
	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	_c_hhsize := if(TRIM(C_HHSIZE) = '', 2.81384315034427, max(min(if((REAL)C_HHSIZE = (REAL)NULL, (REAL)-NULL, (REAL)C_HHSIZE), 4.19), (real)0));
	
	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	_c_easiqlife := if(TRIM(C_EASIQLIFE) = '', 94.4781220970127, max(min(if((INTEGER)C_EASIQLIFE = NULL, -NULL, (INTEGER)C_EASIQLIFE), 167), 0));
	
	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	_c_asian_lang := map(
	    TRIM(C_ASIAN_LANG)=''     	=> 125,
	    (INTEGER)C_ASIAN_LANG < 60 	=> 125,
	                                 max(min(if((INTEGER)C_ASIAN_LANG = NULL, -NULL, (INTEGER)C_ASIAN_LANG), 198), 0));
	
	_gong_did_last_seen := Common.SAS_Date((STRING)gong_did_last_seen);
	
	mos_since_gong_last_seen := IF(MIN(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));
	
	phn_last_seen_rec := mos_since_gong_last_seen = 0;
	
	phn_residential := rc_hphonevalflag = (string)2;
	
	phn_good_counts := (gong_did_first_ct in [1, 2]) and gong_did_last_ct = 1;
	
	phoneproblog := -1.0168 +
	    (integer)phn_last_seen_rec * 0.2460 +
	    (integer)phn_residential * 0.1543 +
	    (integer)phn_last_seen_rec * (integer)phn_residential * -0.1546 +
	    (integer)phn_good_counts * -0.0757;
	
	phoneprobmod := round(100 * exp(phoneproblog) / (1 + exp(phoneproblog))/.1)*.1;
	
	rel_incomeunder25_count_c := min(if(rel_incomeunder25_count = NULL, -NULL, rel_incomeunder25_count), 50);
	
	rel_incomeunder25_count_lg := ln(rel_incomeunder25_count_c + 1);
	
	add1_value := if(add1_assessed_amount = 0, add1_avm_automated_valuation, add1_assessed_amount);
	
	add1_valuation_c := map(
	    add1_value > 500000 => 25000,
	    add1_value > 250000 => 50000,
	    add1_value > 150000 => 75000,
	    add1_value = 0      => 50000,
	                           max(min(if(add1_value = NULL, -NULL, add1_value), 150000), 1));
	
	add1_valuation_lg := ln(add1_valuation_c);
	
	asst_log := -18.73340688 +
	    did_ver_lvl_m * 3.1132128963 +
	    prop_sale_history_m * 3.8174598062 +
	    adl_match_lvl_m * 3.8101470297 +
	    criminal_level_m * 5.0587250199 +
	    bk_lvl_m * 4.3720723677 +
	    derog_ratio2_m * 0.8651110702 +
	    applicant_age_lvl_m * 2.5576804073 +
	    liens_cj_lvl_m * 5.3039431374 +
	    liens_ft_lvl_m * 3.9130455616 +
	    liens_ot_lvl_m * 4.0482700726 +
	    liens_sc_lvl_m * 4.4102880696 +
	    education_lvl_m * 2.2196347293 +
	    addr_immobility_lvl_m * 3.9790126834 +
	    c_civ_emp_lvl_m * 3.5057300609 +
	    sold_purch_lvl_m * 2.3197667784 +
	    rel_count_lvl_m * 2.1245833397 +
	    util_adl_count_c * -0.026645752 +
	    addrmod * 0.0162146904 +
	    ssnprobmod * 0.0218802189 +
	    _c_hhsize * -0.063614202 +
	    _c_easiqlife * -0.002941309 +
	    _c_asian_lang * -0.001253175 +
	    phoneprobmod * 0.0323727277 +
	    rel_incomeunder25_count_lg * -0.087770071 +
	    add1_valuation_lg * 0.0773644892;
	
	phat := exp(asst_log) / (1 + exp(asst_log));
	
	base := 700;
	
	point := 40;
	
	odds := .2828 / (1 - .2828);
	
	asst_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);
	
	rsn1103_1_0 := max(501, min(900, if(asst_mod = NULL, -NULL, asst_mod)));
	
	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.adl_dob := adl_dob;
		SELF.adl_ssn := adl_ssn;
		SELF.in_ssnpop := in_ssnpop;
		SELF.adl_addr := adl_addr;
		SELF.in_addrpop_found := in_addrpop_found;
		SELF.c_civ_emp := c_civ_emp;
		SELF.c_hhsize := c_hhsize;
		SELF.c_easiqlife := c_easiqlife;
		SELF.c_asian_lang := c_asian_lang;
		SELF.truedid := truedid;
		SELF.adl_category := adl_category;
		SELF.in_state := in_state;
		SELF.did_count := did_count;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_ssnvalflag := rc_ssnvalflag;
		SELF.rc_pwssnvalflag := rc_pwssnvalflag;
		SELF.rc_ssnstate := rc_ssnstate;
		SELF.rc_numelever := rc_numelever;
		SELF.combo_dobscore := combo_dobscore;
		SELF.util_adl_count := util_adl_count;
		SELF.add1_house_number_match := add1_house_number_match;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_assessed_amount := add1_assessed_amount;
		SELF.property_owned_total := property_owned_total;
		SELF.prop1_sale_price := prop1_sale_price;
		SELF.prop2_sale_price := prop2_sale_price;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.gong_did_first_ct := gong_did_first_ct;
		SELF.gong_did_last_ct := gong_did_last_ct;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.dl_addrs_per_adl := dl_addrs_per_adl;
		SELF.vo_addrs_per_adl := vo_addrs_per_adl;
		SELF.pl_addrs_per_adl := pl_addrs_per_adl;
		SELF.attr_num_purchase60 := attr_num_purchase60;
		SELF.attr_num_sold60 := attr_num_sold60;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_arrests := attr_arrests;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.date_last_seen := date_last_seen;
		SELF.disposition := disposition;
		SELF.liens_unrel_cj_ct := liens_unrel_cj_ct;
		SELF.liens_unrel_cj_total_amount := liens_unrel_cj_total_amount;
		SELF.liens_rel_cj_ct := liens_rel_cj_ct;
		SELF.liens_rel_cj_first_seen := liens_rel_cj_first_seen;
		SELF.liens_rel_cj_total_amount := liens_rel_cj_total_amount;
		SELF.liens_unrel_ft_ct := liens_unrel_ft_ct;
		SELF.liens_unrel_ft_first_seen := liens_unrel_ft_first_seen;
		SELF.liens_rel_ft_ct := liens_rel_ft_ct;
		SELF.liens_unrel_ot_ct := liens_unrel_ot_ct;
		SELF.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
		SELF.liens_rel_ot_ct := liens_rel_ot_ct;
		SELF.liens_rel_ot_first_seen := liens_rel_ot_first_seen;
		SELF.liens_rel_ot_last_seen := liens_rel_ot_last_seen;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
		SELF.liens_rel_sc_ct := liens_rel_sc_ct;
		SELF.liens_rel_sc_first_seen := liens_rel_sc_first_seen;
		SELF.liens_rel_sc_last_seen := liens_rel_sc_last_seen;
		SELF.liens_rel_sc_total_amount := liens_rel_sc_total_amount;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.rel_count := rel_count;
		SELF.rel_incomeunder25_count := rel_incomeunder25_count;
		SELF.ams_age := ams_age;
		SELF.ams_college_code := ams_college_code;
		SELF.prof_license_flag := prof_license_flag;
		SELF.input_dob_age := input_dob_age;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;

		/* Model Intermediate Variables */
		SELF.archive_date := archive_date;
		SELF.sysdate := sysdate;
		SELF.core_adl := core_adl;
		SELF.single_did := single_did;
		SELF.did_ver_lvl := did_ver_lvl;
		SELF.did_ver_lvl_m := did_ver_lvl_m;
		SELF.prop_sale_history := prop_sale_history;
		SELF.prop_sale_history_m := prop_sale_history_m;
		SELF.adl_match_lvl := adl_match_lvl;
		SELF.adl_match_lvl_m := adl_match_lvl_m;
		SELF.criminal_level := criminal_level;
		SELF.criminal_level_m := criminal_level_m;
		SELF.discharged_bk_f := discharged_bk_f;
		SELF._date_last_seen := _date_last_seen;
		SELF.yrs_bk_last_seen := yrs_bk_last_seen;
		SELF.bk_lvl := bk_lvl;
		SELF.bk_lvl_m := bk_lvl_m;
		SELF.total_recs := total_recs;
		SELF.derog_ratio_c12 := derog_ratio_c12;
		SELF.derog_ratio := derog_ratio;
		SELF.derog_ratio2 := derog_ratio2;
		SELF.derog_ratio2_m := derog_ratio2_m;
		SELF._reported_dob := _reported_dob;
		SELF.reported_age := reported_age;
		SELF.applicant_age := applicant_age;
		SELF.applicant_age_lvl := applicant_age_lvl;
		SELF.applicant_age_lvl_m := applicant_age_lvl_m;
		SELF._liens_rel_cj_first_seen := _liens_rel_cj_first_seen;
		SELF.mos_cj_rel_first_seen := mos_cj_rel_first_seen;
		SELF.liens_cj_lvl := liens_cj_lvl;
		SELF.liens_cj_lvl_m := liens_cj_lvl_m;
		SELF._liens_unrel_ft_first_seen := _liens_unrel_ft_first_seen;
		SELF.mos_ft_unrel_last_seen := mos_ft_unrel_last_seen;
		SELF.liens_ft_lvl := liens_ft_lvl;
		SELF.liens_ft_lvl_m := liens_ft_lvl_m;
		SELF._liens_rel_ot_first_seen := _liens_rel_ot_first_seen;
		SELF.mos_ot_rel_first_seen := mos_ot_rel_first_seen;
		SELF._liens_rel_ot_last_seen := _liens_rel_ot_last_seen;
		SELF.mos_ot_rel_last_seen := mos_ot_rel_last_seen;
		SELF.liens_ot_lvl := liens_ot_lvl;
		SELF.liens_ot_lvl_m := liens_ot_lvl_m;
		SELF._liens_rel_sc_first_seen := _liens_rel_sc_first_seen;
		SELF.mos_sc_rel_first_seen := mos_sc_rel_first_seen;
		SELF._liens_rel_sc_last_seen := _liens_rel_sc_last_seen;
		SELF.mos_sc_rel_last_seen := mos_sc_rel_last_seen;
		SELF.liens_sc_lvl := liens_sc_lvl;
		SELF.liens_sc_lvl_m := liens_sc_lvl_m;
		SELF.education_lvl := education_lvl;
		SELF.education_lvl_m := education_lvl_m;
		SELF.dl_addrs_per_adl_lvl := dl_addrs_per_adl_lvl;
		SELF.vo_addrs_per_adl_lvl := vo_addrs_per_adl_lvl;
		SELF.addr_immobility_lvl := addr_immobility_lvl;
		SELF.addr_immobility_lvl_m := addr_immobility_lvl_m;
		SELF.c_civ_emp_lvl := c_civ_emp_lvl;
		SELF.c_civ_emp_lvl_m := c_civ_emp_lvl_m;
		SELF.sold_purch_lvl := sold_purch_lvl;
		SELF.sold_purch_lvl_m := sold_purch_lvl_m;
		SELF.rel_count_lvl := rel_count_lvl;
		SELF.rel_count_lvl_m := rel_count_lvl_m;
		SELF.util_adl_count_c := util_adl_count_c;
		SELF.family_owned := family_owned;
		SELF.app_owned := app_owned;
		SELF.stolen_addr := stolen_addr;
		SELF.nothing_found := nothing_found;
		SELF.property_owner := property_owner;
		SELF.addrmod_log := addrmod_log;
		SELF.addrmod := addrmod;
		SELF.ssn_priordob := ssn_priordob;
		SELF.ssn_inval := ssn_inval;
		SELF.ssn_issued18 := ssn_issued18;
		SELF.ssn_statediff := ssn_statediff;
		SELF.ssn_deceased := ssn_deceased;
		SELF.ssn_adl_prob := ssn_adl_prob;
		SELF.ssnprob_log := ssnprob_log;
		SELF.ssnprobmod := ssnprobmod;
		SELF._c_hhsize := _c_hhsize;
		SELF._c_easiqlife := _c_easiqlife;
		SELF._c_asian_lang := _c_asian_lang;
		SELF._gong_did_last_seen := _gong_did_last_seen;
		SELF.mos_since_gong_last_seen := mos_since_gong_last_seen;
		SELF.phn_last_seen_rec := phn_last_seen_rec;
		SELF.phn_residential := phn_residential;
		SELF.phn_good_counts := phn_good_counts;
		SELF.phoneproblog := phoneproblog;
		SELF.phoneprobmod := phoneprobmod;
		SELF.rel_incomeunder25_count_c := rel_incomeunder25_count_c;
		SELF.rel_incomeunder25_count_lg := rel_incomeunder25_count_lg;
		SELF.add1_value := add1_value;
		SELF.add1_valuation_c := add1_valuation_c;
		SELF.add1_valuation_lg := add1_valuation_lg;
		SELF.asst_log := asst_log;
		SELF.phat := phat;
		SELF.base := base;
		SELF.point := point;
		SELF.odds := odds;
		SELF.asst_mod := asst_mod;
		SELF.rsn1103_1_0 := rsn1103_1_0;
		
		SELF.seq := (STRING)le.seq;

		SELF.clam := le;
	#else
		SELF.recover_score := INTFORMAT(rsn1103_1_0, 3, 1);
		SELF.seq := (STRING)le.seq;
	#end
	END;

	model := JOIN(clam, EASI.Key_Easi_Census, 
					KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
					doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1));
  
	RETURN(UNGROUP(model));
END;

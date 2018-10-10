import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVA1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean PreScreenOptOut=false ) := FUNCTION

	RVA_DEBUG := false;
	
	#if(RVA_DEBUG)
	Layout_Debug := record
		unsigned seq;
		typeof(clam.truedid) truedid;
		typeof(clam.adlcategory) adl_category;
		typeof(clam.shell_input.unit_desig) out_unit_desig;
		typeof(clam.shell_input.sec_range) out_sec_range;
		typeof(clam.shell_input.addr_type) out_addr_type;
		typeof(clam.shell_input.dob) in_dob;
		typeof(clam.iid.nas_summary) nas_summary;
		typeof(clam.iid.nap_summary) nap_summary;
		typeof(clam.iid.nap_status) nap_status;
		typeof(clam.iid.didcount) did_count;
		typeof(clam.iid.dirsaddr_lastscore) rc_dirsaddr_lastscore;
		typeof(clam.iid.name_addr_phone) rc_name_addr_phone;
		typeof(clam.iid.inputaddrnotmostrecent) rc_input_addr_not_most_recent;
		typeof(clam.iid.hriskphoneflag) rc_hriskphoneflag;
		typeof(clam.iid.phonevalflag) rc_phonevalflag;
		typeof(clam.iid.phonezipflag) rc_phonezipflag;
		typeof(clam.iid.decsflag) rc_decsflag;
		typeof(clam.iid.socsdobflag) rc_ssndobflag;
		typeof(clam.iid.pwsocsdobflag) rc_pwssndobflag;
		typeof(clam.iid.socsvalflag) rc_ssnvalflag;
		unsigned rc_ssnlowissue;
		typeof(clam.iid.dwelltype) rc_dwelltype;
		typeof(clam.iid.bansflag) rc_bansflag;
		typeof(clam.iid.sources) rc_sources;
		typeof(clam.iid.numelever) rc_numelever;
		typeof(clam.iid.addrmiskeyflag) rc_addrmiskeyflag;
		typeof(clam.iid.hrisksic) rc_hrisksic;
		typeof(clam.iid.disthphoneaddr) rc_disthphoneaddr;
		typeof(clam.iid.statezipflag) rc_statezipflag;
		typeof(clam.iid.cityzipflag) rc_cityzipflag;
		typeof(clam.iid.firstssnmatch) rc_fnamessnmatch;
		typeof(clam.iid.combo_addrscore) combo_addrscore;
		typeof(clam.iid.combo_hphonescore) combo_hphonescore;
		typeof(clam.iid.combo_ssnscore) combo_ssnscore;
		typeof(clam.iid.combo_dobscore) combo_dobscore;
		typeof(clam.iid.combo_firstcount) combo_fnamecount;
		typeof(clam.iid.combo_lastcount) combo_lnamecount;
		typeof(clam.iid.combo_addrcount) combo_addrcount;
		typeof(clam.iid.combo_ssncount) combo_ssncount;
		typeof(clam.iid.combo_dobcount) combo_dobcount;
		typeof(clam.source_verification.eq_count) eq_count;
		typeof(clam.source_verification.pr_count) pr_count;
		typeof(clam.source_verification.adl_eqfs_first_seen) adl_eq_first_seen;
		typeof(clam.source_verification.adl_eqfs_last_seen) adl_eq_last_seen;
		typeof(clam.input_validation.ssn_length) ssnlength;
		typeof(clam.input_validation.dateofbirth) dobpop;
		typeof(clam.name_verification.lname_eda_sourced) lname_eda_sourced;
		typeof(clam.name_verification.age) age;
		typeof(clam.address_verification.input_address_information.address_score) add1_address_score;
		typeof(clam.address_verification.input_address_information.isbestmatch) add1_isbestmatch;
		typeof(clam.address_verification.input_address_information.unit_count) add1_unit_count;
		typeof(clam.avm.input_address_information.avm_automated_valuation) add1_avm_automated_valuation;
		typeof(clam.avm.input_address_information.avm_automated_valuation2) add1_avm_automated_valuation_2;
		typeof(clam.avm.input_address_information.avm_automated_valuation3) add1_avm_automated_valuation_3;
		typeof(clam.avm.input_address_information.avm_automated_valuation4) add1_avm_automated_valuation_4;
		typeof(clam.avm.input_address_information.avm_median_fips_level) add1_avm_med_fips;
		typeof(clam.avm.input_address_information.avm_median_geo11_level) add1_avm_med_geo11;
		typeof(clam.avm.input_address_information.avm_median_geo12_level) add1_avm_med_geo12;
		typeof(clam.address_verification.input_address_information.source_count) add1_source_count;
		typeof(clam.address_verification.input_address_information.applicant_owned) add1_applicant_owned;
		typeof(clam.address_verification.input_address_information.occupant_owned) add1_occupant_owned;
		typeof(clam.address_verification.input_address_information.family_owned) add1_family_owned;
		typeof(clam.address_verification.input_address_information.naprop) add1_naprop;
		typeof(clam.address_verification.input_address_information.mortgage_type) add1_mortgage_type;
		typeof(clam.address_verification.input_address_information.type_financing) add1_financing_type;
		typeof(clam.address_verification.input_address_information.standardized_land_use_code) add1_land_use_code;
		typeof(clam.address_verification.owned.property_total) property_owned_total;
		typeof(clam.address_verification.sold.property_total) property_sold_total;
		typeof(clam.address_verification.sold.property_owned_assessed_total) property_sold_assessed_total;
		typeof(clam.address_verification.recent_property_sales.sale_price1) prop1_sale_price;
		typeof(clam.address_verification.recent_property_sales.prev_purch_price1) prop1_prev_purchase_price;
		typeof(clam.address_verification.distance_in_2_h1) dist_a1toa2;
		typeof(clam.address_verification.distance_in_2_h2) dist_a1toa3;
		typeof(clam.address_verification.distance_h1_2_h2) dist_a2toa3;
		typeof(clam.other_address_info.avg_lres) avg_lres;
		typeof(clam.other_address_info.addrs_last_5years) addrs_5yr;
		typeof(clam.other_address_info.addrs_last_10years) addrs_10yr;
		typeof(clam.other_address_info.addrs_last_15years) addrs_15yr;
		typeof(clam.other_address_info.isprison) addrs_prison_history;
		typeof(clam.phone_verification.recent_disconnects) recent_disconnects;
		typeof(clam.phone_verification.gong_did.gong_adl_dt_first_seen_full) gong_did_first_seen;
		typeof(clam.phone_verification.gong_did.gong_adl_dt_last_seen_full) gong_did_last_seen;
		typeof(clam.phone_verification.gong_did.gong_did_phone_ct) gong_did_phone_ct;
		typeof(clam.phone_verification.gong_did.gong_did_addr_ct) gong_did_addr_ct;
		typeof(clam.phone_verification.gong_did.gong_did_first_ct) gong_did_first_ct;
		typeof(clam.ssn_verification.credit_first_seen) credit_first_seen;
		typeof(clam.ssn_verification.header_first_seen) header_first_seen;
		typeof(clam.ssn_verification.validation.inputsocscharflag) inputssncharflag;
		typeof(clam.velocity_counters.ssns_per_adl) ssns_per_adl;
		typeof(clam.velocity_counters.addrs_per_adl) addrs_per_adl;
		typeof(clam.ssn_verification.adlperssn_count) adlperssn_count;
		typeof(clam.velocity_counters.ssns_per_adl_created_6months) ssns_per_adl_c6;
		typeof(clam.velocity_counters.addrs_per_adl_created_6months) addrs_per_adl_c6;
		typeof(clam.velocity_counters.vo_addrs_per_adl) vo_addrs_per_adl;
		typeof(clam.velocity_counters.pl_addrs_per_adl) pl_addrs_per_adl;
		typeof(clam.velocity_counters.invalid_ssns_per_adl) invalid_ssns_per_adl;
		typeof(clam.velocity_counters.invalid_addrs_per_adl_created_6months) invalid_addrs_per_adl_c6;
		typeof(clam.infutor_phone.infutor_nap) infutor_nap;
		typeof(clam.impulse.count) impulse_count;
		typeof(clam.other_address_info.addrs_last30) attr_addrs_last30;
		typeof(clam.other_address_info.addrs_last90) attr_addrs_last90;
		typeof(clam.other_address_info.addrs_last12) attr_addrs_last12;
		typeof(clam.other_address_info.addrs_last24) attr_addrs_last24;
		typeof(clam.other_address_info.addrs_last36) attr_addrs_last36;
		typeof(clam.other_address_info.date_first_purchase) attr_date_first_purchase;
		typeof(clam.other_address_info.num_purchase30) attr_num_purchase30;
		typeof(clam.other_address_info.num_purchase90) attr_num_purchase90;
		typeof(clam.other_address_info.num_purchase180) attr_num_purchase180;
		typeof(clam.other_address_info.num_purchase12) attr_num_purchase12;
		typeof(clam.other_address_info.num_purchase24) attr_num_purchase24;
		typeof(clam.other_address_info.num_purchase36) attr_num_purchase36;
		typeof(clam.other_address_info.num_purchase60) attr_num_purchase60;
		typeof(clam.watercraft.watercraft_count60) attr_num_watercraft60;
		typeof(clam.aircraft.aircraft_count) attr_num_aircraft;
		typeof(clam.total_number_derogs) attr_total_number_derogs;
		typeof(clam.bjl.eviction_count) attr_eviction_count;
		typeof(clam.source_verification.num_nonderogs90) attr_num_nonderogs90;
		typeof(clam.bjl.bankrupt) bankrupt;
		typeof(clam.bjl.date_last_seen) date_last_seen;
		typeof(clam.bjl.disposition) disposition;
		typeof(clam.bjl.filing_count) filing_count;
		typeof(clam.bjl.bk_recent_count) bk_recent_count;
		typeof(clam.bjl.bk_disposed_recent_count) bk_disposed_recent_count;
		typeof(clam.bjl.bk_disposed_historical_count) bk_disposed_historical_count;
		typeof(clam.bjl.liens_recent_unreleased_count) liens_recent_unreleased_count;
		typeof(clam.bjl.liens_historical_unreleased_count) liens_historical_unreleased_ct;
		typeof(clam.bjl.liens_recent_released_count) liens_recent_released_count;
		typeof(clam.bjl.liens_historical_released_count) liens_historical_released_count;
		typeof(clam.liens.liens_unreleased_civil_judgment.count) liens_unrel_cj_ct;
		typeof(clam.liens.liens_unreleased_civil_judgment.most_recent_filing_date) liens_unrel_cj_last_seen;
		typeof(clam.liens.liens_released_civil_judgment.count) liens_rel_cj_ct;
		typeof(clam.liens.liens_unreleased_foreclosure.count) liens_unrel_fc_ct;
		typeof(clam.liens.liens_released_foreclosure.count) liens_rel_fc_ct;
		typeof(clam.liens.liens_unreleased_landlord_tenant.count) liens_unrel_lt_ct;
		typeof(clam.liens.liens_released_landlord_tenant.count) liens_rel_lt_ct;
		typeof(clam.liens.liens_unreleased_other_tax.total_amount) liens_unrel_ot_total_amount;
		typeof(clam.liens.liens_unreleased_small_claims.count) liens_unrel_sc_ct;
		typeof(clam.liens.liens_released_small_claims.count) liens_rel_sc_ct;
		typeof(clam.bjl.criminal_count) criminal_count;
		typeof(clam.bjl.last_criminal_date) criminal_last_date;
		typeof(clam.bjl.felony_count) felony_count;
		typeof(clam.student.college_code) ams_college_code;
		typeof(clam.student.income_level_code) ams_income_level_code;
		typeof(clam.student.college_tier) ams_college_tier;
		typeof(clam.professional_license.plcategory) prof_license_category;
		typeof(clam.wealth_indicator) wealth_index;
		typeof(clam.dobmatchlevel) input_dob_match_level;
		typeof(clam.mobility_indicator) addr_stability;
		Integer archive_date;
		Integer pk_wealth_index;
		Real pk_wealth_index_m;
		Integer wealth_index_cm;
		Boolean source_tot_DA;
		Boolean source_tot_CG;
		Boolean source_tot_P;
		Boolean source_tot_BA;
		Boolean source_tot_AM;
		Boolean source_tot_W;
		Boolean add_apt;
		Boolean bk_flag;
		Integer pk_bk_level;
		Integer add1_avm_med;
		Integer rc_valid_bus_phone;
		Integer rc_valid_res_phone;
		Integer age_rcd;
		Integer add1_mortgage_type_ord;
		Real prof_license_category_ord;
		Integer pk_attr_total_number_derogs;
		Integer pk_attr_total_number_derogs_2;
		Integer pk_attr_num_nonderogs90;
		Integer pk_attr_num_nonderogs90_2;
		Integer pk_derog_total;
		Integer pk_derog_total_m;
		Integer add1_avm_automated_valuation_rcd;
		Integer add1_avm_automated_val_2_rcd;
		Integer pk_liens_unrel_ot_total_amount;
		Integer attr_num_watercraft60_cap;
		Integer combo_addrcount_cap;
		Integer gong_did_phone_ct_cap;
		Integer ams_college_code_mis;
		Integer ams_college_code_cm;
		Integer ams_income_level_code_cm;
		Integer unit5;
		Integer pk_dist_a1toa2;
		Integer pk_dist_a1toa3;
		Integer pk_dist_a2toa3;
		Integer pk_rc_disthphoneaddr;
		Real pk_dist_a1toa2_m;
		Real pk_dist_a1toa3_m;
		Real pk_dist_a2toa3_m;
		Real pk_rc_disthphoneaddr_m;
		Real Dist_mod;
		Integer sysdate;
		Integer date_last_seen2;
		Integer liens_unrel_cj_last_seen2;
		Real years_date_last_seen;
		Real years_liens_unrel_cj_last_seen;
		Integer pk_yr_date_last_seen;
		Integer pk_bk_yr_date_last_seen;
		Real pk_bk_yr_date_last_seen_m1;
		Integer adl_category_ord;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk2_yr_liens_unrel_cj_last_seen;
		Real predicted_inc_high;
		Real predicted_inc_low;
		Real pred_inc;
		Integer today;
		String add1_land_use_code_2byte;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean lien_flag;
		Boolean source_tot_DS;
		Boolean source_tot_BA_2;
		Boolean bk_flag_2;
		Boolean ssn_deceased;
		Integer pk_impulse_count;
		Integer pk_impulse_count_2;
		Integer pk_adl_cat_deceased;
		String bs_own_rent;
		Integer bs_attr_derog_flag;
		Integer bs_attr_eviction_flag;
		Integer bs_attr_derog_flag2;
		String hm_segment;
		String hm_segment_2;
		Real did_ver_m_b1;
		Real did_ver_nodob_m_b1;
		Real verx_m_b1;
		Real mod_ver_b1;
		Real gong_hist_summary_m_b1;
		Real time_on_gong_b1;
		Real time_on_gong_b1_2;
		Integer in_dob2_b1;
		Integer ssns_per_adl_summary_b1;
		Integer ssns_per_adl_summary_b1_2;
		Real ssns_per_adl_summary_m_b1;
		Real mod_prob_b1;
		Integer prop1_sale_index_b1;
		Real prop1_sale_index2_b1;
		Real address_recency_m_b1;
		String out_addr_type_summary_b1;
		String add1_land_use_code_summary_b1;
		String addr_type_summary_b1;
		Real addr_type_summary_m_b1;
		Real add1_financing_type_m_b1;
		Real add1_naprop_summary_m_b1;
		Real mosince_criminal_last_date_84_b1;
		Integer impulse_count_2_b1;
		Real ams_college_tier_summary_b1;
		Real ams_college_tier_summary_m_b1;
		Real prof_license_category2_b1;
		Real addr_stability2_b1;
		Integer in_dob2_b1_2;
		Real time_on_eq_b1;
		Real time_on_eq_b1_2;
		Real outest_b1;
		Real did_ver_b2;
		Real did_ver_nodob_m_b2;
		Real verx_m_b2;
		Real mod_ver_b2;
		Real gong_hist_summary_m_b2;
		Integer gong_did_first_seen2_b2;
		Real time_on_gong_b2;
		Real time_on_gong_b2_2;
		Real mosince_gong_did_first_seen_b2;
		Real mosince_gong_did_first_seen_b2_2;
		Integer ssns_per_adl_summary_b2;
		Integer ssns_per_adl_summary_b2_2;
		Real ssns_per_adl_summary_m_b2;
		Integer prop1_sale_index_b2;
		Real prop1_sale_index2_b2;
		String out_addr_type_summary_b2;
		String add1_land_use_code_summary_b2;
		String addr_type_summary_b2;
		Real addr_type_summary_m_b2;
		Real add1_avm_change1_b2;
		Real add1_avm_change2_b2;
		Real add1_avm_change3_b2;
		Real add1_avm_change1_nomiss_b2;
		Real add1_avm_change2_nomiss_b2;
		Real add1_avm_change3_nomiss_b2;
		Real add1_avm_index_b2;
		Real add1_avm_index_b2_2;
		Real add1_avm_index_summary_m_b2;
		Real add1_financing_type_m_b2;
		Real add1_ownership_m_b2;
		Real add1_naprop_summary_m_b2;
		Real ams_college_tier_summary_b2;
		Real ams_college_tier_summary_m_b2;
		Real prof_license_category2_b2;
		Real addr_stability2_b2;
		Real addr_stability2_m_b2;
		String most_recent_purchase_b2;
		Real most_recent_purchase_m_b2;
		Real time_on_eq_b2;
		Real time_on_eq_b2_2;
		Real did_ver_m_b3;
		Real did_ver_nodob_m_b3;
		Real verx_m_b3;
		Real mod_ver_b3;
		Integer gong_did_first_seen2_b3;
		Real time_on_gong_b3;
		Real time_on_gong_b3_2;
		Real mosince_gong_did_first_seen_b3;
		Real mosince_gong_did_first_seen_b3_2;
		Integer ssns_per_adl_summary_b3;
		Integer ssns_per_adl_summary_b3_2;
		Real ssns_per_adl_summary_m_b3;
		String address_recency_b3;
		String address_recency2_b3;
		Real address_recency2_m_b3;
		Real add1_financing_type_m_b3;
		Real ams_college_tier_summary_b3;
		Real ams_college_tier_summary_m_b3;
		Real addr_stability2_b3;
		Real addr_stability2_m_b3;
		Real outest_b3;
		Real mod_ver_b4;
		Real combo_hphnscore_summary_m_b4;
		Integer gong_did_first_seen2_b4;
		Real time_on_gong_b4;
		Real time_on_gong_b4_2;
		Real mosince_gong_did_first_seen_b4;
		Real mosince_gong_did_first_seen_b4_2;
		Integer ssns_per_adl_summary_b4;
		Integer ssns_per_adl_summary_b4_2;
		Real ssns_per_adl_summary_m_b4;
		Real adlperssn_count_summary_b4;
		Real adlperssn_count_summary_m_b4;
		String address_recency_b4;
		String address_recency2_b4;
		Real address_recency2_m_b4;
		Real prof_license_category_m_b4;
		Real addr_stability2_b4;
		Real addr_stability2_m_b4;
		Integer ams_income_level_summary_b4;
		Integer ams_college_code_summary_b4;
		Real ams_college_income_summary_m_b4;
		Integer combo_dobcount_5;
		Boolean cell_pager_pcs;
		Integer contrary_ssn;
		Integer residential_phone;
		Real ams_college_tier_summary;
		Integer attr_addrs_last12_4;
		Integer criminal_count_7;
		Integer ssns_per_adl_summary;
		Integer hi_pred_income;
		Real addr_stability2;
		Integer rc_ssnlowissue2;
		Integer verlst_p;
		Real add1_avm_index;
		Real outest;
		Integer hi_combo_ssncount;
		Real add1_avm_change1_2;
		Real did_ver_m;
		Integer add1_avm_automated_val2_300k;
		Real mod_derog;
		Integer add1_unit_count_5;
		Real ams_college_tier_summary_m;
		Real add1_avm_change1_nomiss;
		Integer liens_recent_released_ind;
		Integer ams_college_code_summary;
		Real adlperssn_count_summary;
		Real log10_pred_inc;
		Real mod_ver;
		Integer bad_bk;
		Real addr_stability2_m;
		Integer hi_addrs_per_adl;
		Integer liens_released_ind;
		Integer invalid_addrs_per_adl_c6_ind;
		Boolean yrsince_rc_ssnlowissue_le10;
		Real address_recency_m;
		Integer addrs_10yr_15;
		Integer hi_gong_did_addr_ct;
		Integer liens_recent_unreleased_count_6;
		Real add1_avm_change2_nomiss;
		Boolean zip_mismatch;
		Boolean hi_yrs_when_ln_first_seen;
		Integer addrs_15yr_20;
		Real did_ver_nodob_m;
		Real most_recent_purchase_m;
		Real yrs_at_lowissue;
		Integer hi_gong_did_phone_ct;
		Integer add1_avm_automated_val3_300k;
		Real yrs_when_credit_first_seen;
		Real mod_prop;
		Boolean no_vo_addrs_per_adl;
		Boolean liens_historical_released_ind;
		Integer ams_income_level_summary;
		Boolean hi_lo_eq_count;
		Real add1_ownership_m;
		Boolean no_ssn_sources;
		Real combo_hphnscore_summary_m;
		String most_recent_purchase;
		Integer felony_count_2;
		Real ams_college_income_summary_m;
		Boolean yrs_at_lowissue_ge30;
		Boolean lo_addrs_per_adl;
		Real add1_avm_change2_2;
		Real address_recency2_m;
		Integer gong_did_first_seen2;
		Integer header_first_seen2;
		Real time_on_gong;
		Integer ssnprior;
		Real addr_type_summary_m;
		Real add1_financing_type_m;
		Real adlperssn_count_summary_m;
		Integer prop1_sale_index;
		Boolean impulse_ind;
		Boolean lo_combo_ssnscore;
		Real mod_phnprob;
		Boolean hi_gong_did_first_ct;
		Integer adl_eq_last_seen2;
		Boolean ssndead;
		Integer adlperssn_count_5;
		Boolean liens_fc_ind;
		Real add1_avm_change2;
		Boolean dismissed_bk;
		String address_recency2;
		Boolean hm_aptflag;
		Integer eq_count_50;
		Integer attr_addrs_last30_2;
		Integer attr_addrs_last36_7;
		Boolean veradd_p;
		Integer attr_addrs_last24_6;
		Boolean hi_addrs_per_adl_c6;
		Real mod_addrprob;
		Integer slim_addr_info;
		Integer ssninvalid;
		Integer rc_numelever_gt4;
		Real add1_avm_change3;
		Real verx_m;
		Real yrs_when_header_first_seen;
		Integer add1_avm_automated_val4_300k;
		Boolean verphn_p;
		Integer pr_count_12;
		Integer combo_fnamecount_6;
		Real add1_avm_change1;
		Integer lo_combo_addrscore;
		Integer single_did;
		Integer infutor_nap_ver;
		Boolean phn_disconnected;
		Integer nas12;
		Integer impulse_count_2;
		Integer lres0;
		Integer adl_eq_first_seen2;
		Integer no_addrs_per_adl;
		Integer gong_did_last_seen2;
		Integer liens_lt_ind;
		Real mosince_criminal_last_date_84;
		Integer phone_zip_mismatch;
		Integer prop1_distressed_sale;
		Real add1_naprop_summary_m;
		Boolean yrsince_rc_ssnlowissue_le15;
		Integer criminal_last_date2;
		Real time_on_eq;
		Real did_ver;
		Integer watercraft_aircraft_ind;
		Integer attr_addrs_last90_2;
		Real yrsince_rc_ssnlowissue;
		Integer ssnprob_hm;
		Integer credit_first_seen2;
		Real mod_ssnprob;
		String out_addr_type_summary;
		Real add1_avm_change3_2;
		Real prof_license_category_m;
		Boolean liens_sc_ind;
		Boolean miss_rc_name_addr_phone;
		Real add1_avm_index_summary_m;
		Real ssns_per_adl_summary_m;
		Integer ver_phncount;
		Boolean ver_nas479;
		Boolean no_addr_sources;
		Boolean liens_cj_ind;
		Integer combo_lnamecount_6;
		Boolean lo_combo_hphonescore;
		Integer addrs_5yr_10;
		Boolean add1_hr_mortgage_type;
		String address_recency;
		Integer combo_addrcount_5;
		Boolean lo_rc_dirsaddr_lastscore;
		Real mosince_gong_did_first_seen;
		Boolean lo_add1_address_score;
		Integer add1_avm_automated_val_300k;
		Integer pred_inc_8_200k;
		Real mosince_criminal_last_date;
		Real prop1_sale_index2;
		Boolean verfst_p;
		Real mod_prob;
		Real prof_license_category2;
		Integer in_dob2;
		Real add1_avm_change3_nomiss;
		Real gong_hist_summary_m;
		Boolean hi_ssns_per_adl_c6;
		Boolean no_pl_addrs_per_adl;
		Boolean no_add1_sources;
		Boolean core_adl;
		String addr_type_summary;
		Boolean invalid_ssns_per_adl_ind;
		Real yrs_when_ln_first_seen;
		String add1_land_use_code_summary;
		Real phat;
		Integer score;
		Integer RVA1003_0_0;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Integer rva1003_0_0_2;
		Boolean scored_222s;
		Integer rva1003_0_0_3;
	end;
	Layout_Debug doModel(clam le) := TRANSFORM
	#else
	Layout_ModelOut doModel(clam le) := TRANSFORM
	#end



		truedid                          := le.truedid;
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		did_count                        := le.iid.didcount;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_name_addr_phone               := le.iid.name_addr_phone;
		rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_numelever                     := le.iid.numelever;
		rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_statezipflag                  := le.iid.statezipflag;
		rc_cityzipflag                   := le.iid.cityzipflag;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_hphonescore                := le.iid.combo_hphonescore;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_ssncount                   := le.iid.combo_ssncount;
		combo_dobcount                   := le.iid.combo_dobcount;
		eq_count                         := le.source_verification.eq_count;
		pr_count                         := le.source_verification.pr_count;
		adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
		adl_eq_last_seen                 := le.source_verification.adl_eqfs_last_seen;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		age                              := le.name_verification.age;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
		add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
		prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		avg_lres                         := le.other_address_info.avg_lres;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		addrs_prison_history             := le.other_address_info.isprison;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		credit_first_seen                := le.ssn_verification.credit_first_seen;
		header_first_seen                := le.ssn_verification.header_first_seen;
		inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
		invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
		invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_addrs_last30                := le.other_address_info.addrs_last30;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_date_first_purchase         := le.other_address_info.date_first_purchase;
		attr_num_purchase30              := le.other_address_info.num_purchase30;
		attr_num_purchase90              := le.other_address_info.num_purchase90;
		attr_num_purchase180             := le.other_address_info.num_purchase180;
		attr_num_purchase12              := le.other_address_info.num_purchase12;
		attr_num_purchase24              := le.other_address_info.num_purchase24;
		attr_num_purchase36              := le.other_address_info.num_purchase36;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
		liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		addr_stability                   := le.mobility_indicator;
		archive_date                     := le.historydate;

		NULL := -999999999;


		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

		transdate_sas(indate,outdate) := MACRO
			outdate := map(
				length(indate)=8 and (integer4)indate[1..4] >= 1800 => common.sas_date(
					indate[1..4]
					+ intformat(min(12,max(1, (integer2)indate[5..6])), 2, 1 )
					+ '01'
				) + min(31,max(1, (integer2)indate[7..8])) - 1,
				length(indate)=6 and (integer4)indate[1..4] >= 1800 => common.sas_date(
					indate[1..4]
					+ intformat(min(12,max(1,(integer2)indate[5..6])), 2, 1 )
					+ '01'
				),
				NULL
			);
		ENDMACRO;

		integer transDate_yr(string indate, integer today) := function
			indate2 := map(
				length(trim((string)indate))=8 and (integer)indate[1..4] >= 1800 =>
					models.common.sas_date( indate[1..4]
						+ intformat(min(12,max(1,(integer)indate[5..6] )),2,1)
						+ '01'
					) + min(31,max(1,(integer)indate[7..8])) - 1,
				length(trim((string)indate))=6 and (integer)indate[1..4] >= 1800 =>
					models.common.sas_date( indate[1..4]
						+ intformat(min(12,max(1,(integer)indate[5..6])),2,1)
						+ '01'
					),
				models.common.null
			);
			outvar := if( ''=indate or models.common.null in [indate2, today], models.common.null, (integer)((today-indate2)/365.25) );
			return outvar;
		END;
		
		transDate_mo(indate,today,outvar) := MACRO;
			#uniquename(indate2)
			%indate2% := map(
				length(trim((string)indate))=8 and (integer)((STRING)indate)[1..4] >= 1800 =>
					models.common.sas_date( ((STRING)indate)[1..4]
						+ intformat(min(12,max(1,(integer)((STRING)indate)[5..6] )),2,1)
						+ '01'
					) + min(31,max(1,(integer)((STRING)indate)[7..8])) - 1,
				length(trim((string)indate))=6 and (integer)((STRING)indate)[1..4] >= 1800 =>
					models.common.sas_date( ((STRING)indate)[1..4]
						+ intformat(min(12,max(1,(integer)((STRING)indate)[5..6])),2,1)
						+ '01'
					),
				models.common.null
			);
			outvar := if( 0 = (integer)indate or models.common.null in[%indate2%, today], models.common.null, (today-%indate2%)/30.5 );
		ENDMACRO;





		pk_wealth_index :=  map((integer)wealth_index <= 2 => 0,
								(integer)wealth_index <= 3 => 1,
								(integer)wealth_index <= 4 => 2,
								(integer)wealth_index <= 5 => 3,
															  4);

		pk_wealth_index_m :=  map(pk_wealth_index = 0 => 39116.676936,
								  pk_wealth_index = 1 => 43449.700792,
								  pk_wealth_index = 2 => 57061.910522,
								  pk_wealth_index = 3 => 82122.972447,
														 134020.49977);

		wealth_index_cm :=  map((integer)wealth_index = 0 => 35766,
								(integer)wealth_index = 1 => 32220,
								(integer)wealth_index = 2 => 35991,
								(integer)wealth_index = 3 => 39789,
								(integer)wealth_index = 4 => 46630,
								(integer)wealth_index = 5 => 52993,
								(integer)wealth_index = 6 => 55911,
															 43256);

		Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool');
		Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool');
		Common.findw(rc_sources, 'P',  ' ,', 'I', source_tot_P,  'bool');
		Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool');
		Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool');
		Common.findw(rc_sources, 'W',  ' ,', 'I', source_tot_W,  'bool');

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

		rc_valid_bus_phone :=  if((integer)rc_phonevalflag = 1, 1, 0);

		rc_valid_res_phone :=  if((integer)rc_phonevalflag = 2, 1, 0);

		age_rcd :=  map(age < 18 => 35,
						age > 60 => 35,
									age);

		add1_mortgage_type_ord :=  map(add1_mortgage_type in ['FHA']              => 1,
									   add1_mortgage_type in ['', ' ']            => 2,
									   add1_mortgage_type in ['2', 'E', 'N', 'U'] => 4,
																					 3);

		prof_license_category_ord :=  map(prof_license_category = '0'        => 1,
										  prof_license_category in ['', ' '] => 1.5,
																				(real)prof_license_category);

		pk_attr_total_number_derogs := attr_total_number_derogs;

		pk_attr_total_number_derogs_2 :=  if(pk_attr_total_number_derogs > 3, 3, pk_attr_total_number_derogs);

		pk_attr_num_nonderogs90 := attr_num_nonderogs90;

		pk_attr_num_nonderogs90_2 :=  if(pk_attr_num_nonderogs90 > 4, 4, pk_attr_num_nonderogs90);

		pk_derog_total :=  if(pk_attr_total_number_derogs_2 > 0, pk_attr_total_number_derogs_2, (-1 * pk_attr_num_nonderogs90_2));

		pk_derog_total_m :=  map(pk_derog_total <= -4 => 51961,
								 pk_derog_total <= -3 => 49033,
								 pk_derog_total <= -2 => 45551,
								 pk_derog_total <= -1 => 40287,
								 pk_derog_total <= 0  => 42406,
								 pk_derog_total <= 1  => 40550,
								 pk_derog_total <= 2  => 38539,
								 pk_derog_total <= 3  => 37345,
														 43256);

		add1_avm_automated_valuation_rcd :=  if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);

		add1_avm_automated_val_2_rcd :=  if(add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2);

		pk_liens_unrel_ot_total_amount :=  map(liens_unrel_ot_total_amount <= 0     => -1,
											   liens_unrel_ot_total_amount <= 10000 => 0,
																					   1);

		attr_num_watercraft60_cap :=  if(attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

		combo_addrcount_cap :=  if(combo_addrcount > 6, 6, combo_addrcount);

		gong_did_phone_ct_cap :=  if(gong_did_phone_ct > 5, 5, gong_did_phone_ct);

		ams_college_code_mis := (integer)(trim(ams_college_code)='');

		ams_college_code_cm :=  map((integer)ams_college_code = 2 => 38463,
									(integer)ams_college_code = 4 => 49756,
																	 43256);

		ams_income_level_code_cm :=  map(ams_income_level_code in ['A', 'B', 'C'] => 38285,
										 ams_income_level_code = 'D'              => 39525,
										 ams_income_level_code = 'E'              => 42426,
										 ams_income_level_code = 'F'              => 44337,
										 ams_income_level_code = 'G'              => 46648,
										 ams_income_level_code = 'H'              => 48231,
										 ams_income_level_code = 'I'              => 49622,
										 ams_income_level_code = 'J'              => 52149,
										 ams_income_level_code = 'K'              => 53457,
																					 43095);

		unit5 :=  if(add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));

		pk_dist_a1toa2 :=  map(dist_a1toa2 = 9999 => -1,
							   dist_a1toa2 <= 0   => 0,
							   dist_a1toa2 <= 9   => 1,
													 2);

		pk_dist_a1toa3 :=  map(dist_a1toa3 = 9999 => -1,
							   dist_a1toa3 <= 0   => 0,
							   dist_a1toa3 <= 30  => 1,
													 2);

		pk_dist_a2toa3 :=  map(dist_a2toa3 = 9999 => -1,
							   dist_a2toa3 <= 0   => 0,
							   dist_a2toa3 <= 9   => 1,
							   dist_a2toa3 <= 35  => 2,
													 3);

		pk_rc_disthphoneaddr :=  map(rc_disthphoneaddr = 9999 => 0,
									 rc_disthphoneaddr <= 3   => 0,
									 rc_disthphoneaddr <= 6   => 1,
									 rc_disthphoneaddr <= 12  => 2,
																 3);

		pk_dist_a1toa2_m :=  map(pk_dist_a1toa2 = -1 => 47044.838402,
								 pk_dist_a1toa2 = 0  => 56779.152604,
								 pk_dist_a1toa2 = 1  => 64372.446403,
														67159.04343);

		pk_dist_a1toa3_m :=  map(pk_dist_a1toa3 = -1 => 45641.502319,
								 pk_dist_a1toa3 = 0  => 57276.981937,
								 pk_dist_a1toa3 = 1  => 64982.162906,
														68001.554009);

		pk_dist_a2toa3_m :=  map(pk_dist_a2toa3 = -1 => 46484.736644,
								 pk_dist_a2toa3 = 0  => 56957.192413,
								 pk_dist_a2toa3 = 1  => 62973.959269,
								 pk_dist_a2toa3 = 2  => 65191.442627,
														70153.886806);

		pk_rc_disthphoneaddr_m :=  map(pk_rc_disthphoneaddr = 0 => 62474.417978,
									   pk_rc_disthphoneaddr = 1 => 63733.738308,
									   pk_rc_disthphoneaddr = 2 => 68541.171909,
																   83512.402545);

		Dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

		sysdate :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date((string)if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);

		date_last_seen2 :=  map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))) - 1)),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																							NULL);

		liens_unrel_cj_last_seen2 :=  map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))) - 1)),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																														  NULL);

		years_date_last_seen :=  if((sysdate != NULL) and (date_last_seen2 != NULL), ((sysdate - date_last_seen2) / 365.25), NULL);

		years_liens_unrel_cj_last_seen :=  if((sysdate != NULL) and (liens_unrel_cj_last_seen2 != NULL), ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL);

		pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

		pk_bk_yr_date_last_seen :=  map((real)pk_yr_date_last_seen = NULL => -1,
										pk_yr_date_last_seen >= 9         => 9,
																			 pk_yr_date_last_seen);

		pk_bk_yr_date_last_seen_m1 :=  map(pk_bk_yr_date_last_seen = -1 => 65447.971203,
										   pk_bk_yr_date_last_seen = 1  => 37195.924959,
										   pk_bk_yr_date_last_seen = 2  => 40666.992447,
										   pk_bk_yr_date_last_seen = 3  => 42965.336207,
										   pk_bk_yr_date_last_seen = 4  => 44669.167255,
										   pk_bk_yr_date_last_seen = 5  => 47563.390744,
										   pk_bk_yr_date_last_seen = 6  => 47917.954038,
										   pk_bk_yr_date_last_seen = 7  => 49396.154083,
										   pk_bk_yr_date_last_seen = 8  => 50099.973169,
										   pk_bk_yr_date_last_seen = 9  => 52557.404007,
																		   65447.971203);

		adl_category_ord := (integer)(adl_category = '1 DEAD');

		pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));

		pk2_yr_liens_unrel_cj_last_seen :=  map((real)pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
												pk_yr_liens_unrel_cj_last_seen <= 3          => 2,
												pk_yr_liens_unrel_cj_last_seen <= 5          => 1,
																								0);

		predicted_inc_high := -28552 +
			(pk_wealth_index_m * 0.51667) +
			((integer)source_tot_DA * 88499) +
			(add1_avm_med * 0.05448) +
			(prof_license_category_ord * 8167.93208) +
			(addrs_per_adl * 855.48025) +
			(pk_derog_total_m * 0.27963) +
			(add1_avm_automated_valuation_rcd * 0.01557) +
			(property_sold_assessed_total * 0.02413) +
			(attr_num_watercraft60_cap * 10490) +
			(age_rcd * 324.98302) +
			(combo_addrcount_cap * -2218.70449) +
			((integer)add_apt * -6810.8463) +
			((integer)source_tot_CG * 28047) +
			((integer)source_tot_W * 6718.13655) +
			(gong_did_phone_ct * 1414.7842) +
			(add1_mortgage_type_ord * 1825.91813) +
			((integer)source_tot_AM * 17169) +
			(rc_valid_bus_phone * 11042) +
			(pk_liens_unrel_ot_total_amount * 7931.02954) +
			(add1_avm_automated_val_2_rcd * 0.00826) +
			(ams_college_code_mis * -5323.07783) +
			(pk_bk_level * -1970.64639);

		predicted_inc_low := -45923 +
			(unit5 * -832.87755) +
			(wealth_index_cm * 0.58264) +
			(pk_derog_total_m * 0.09997) +
			(add1_avm_automated_valuation_rcd * 0.045) +
			(addrs_per_adl * 545.9244) +
			((integer)source_tot_W * 5334.71282) +
			(prof_license_category_ord * 5952.85069) +
			((integer)source_tot_P * 2443.25461) +
			(Dist_mod * 0.14399) +
			(pk_bk_yr_date_last_seen_m1 * 0.09757) +
			(adl_category_ord * -6304.92099) +
			((integer)rc_fnamessnmatch * 1785.49733) +
			(add1_mortgage_type_ord * 859.15454) +
			(pk2_yr_liens_unrel_cj_last_seen * -803.19148) +
			(ams_college_code_cm * 0.23431) +
			(attr_num_watercraft60_cap * 6294.24356) +
			(rc_valid_res_phone * -2008.73124) +
			(ams_income_level_code_cm * 0.08691) +
			(addrs_10yr * -375.39614) +
			(gong_did_phone_ct_cap * 630.52863) +
			((integer)source_tot_AM * 12757) +
			((integer)lname_eda_sourced * 1462.6333);

		pred_inc :=  if((integer)predicted_inc_high < 60000, (predicted_inc_low - 2000), (predicted_inc_high - 2000));

		archive_date_fixed := if(archive_date=999999, ((STRING)Std.Date.Today())[1..6], (string6)archive_date);
		today := (ut.DaysSince1900(((string)archive_date_fixed)[1..4], ((string)archive_date_fixed)[5..6], (string)01) - ut.DaysSince1900('1960', '1', '1'));

		add1_land_use_code_2byte := (add1_land_use_code)[1..2];

		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

		source_tot_L2 := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ',') > 0);

		source_tot_LI := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ',') > 0);

		lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

		source_tot_DS := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ',') > 0);

		source_tot_BA_2 := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ',') > 0);

		bk_flag_2 := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA_2 = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

		pk_impulse_count := impulse_count;

		pk_impulse_count_2 :=  if(pk_impulse_count > 2, 2, pk_impulse_count);

		pk_adl_cat_deceased :=  if(trim(trim(adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0);

		bs_own_rent :=  map((add1_naprop = 4) or (property_owned_total > 0)                                                      => '1 Owner',
							(trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H') or ((add1_naprop = 1) or (add1_unit_count > 3)) => '2 Renter',
																																	'3 Other');

		bs_attr_derog_flag :=  if(attr_total_number_derogs > 0, 1, 0);

		bs_attr_eviction_flag :=  if(attr_eviction_count > 0, 1, 0);

		bs_attr_derog_flag2 :=  if((bs_attr_derog_flag > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag > 0) or ((pk_impulse_count_2 > 0) or (((integer)bk_flag_2 > 0) or ((pk_adl_cat_deceased > 0) or ((integer)ssn_deceased > 0)))))), 1, 0);

		hm_segment := '        ';

		hm_segment_2 :=  if(bs_attr_derog_flag2 = 1, '0 Derog', bs_own_rent);

		did_ver_m_b1 := map(not(((adl_category)[1..1] = '8'))                                                                          => 27.35,
							(((adl_category)[1..1] = '8') and not(((did_count = 1) and (rc_numelever > 3)))) or (combo_dobscore = 255) => 16.41,
							combo_dobscore < 100                                                                                       => 10.91,
																																		  9.62);

		did_ver_nodob_m_b1 := map(not(((adl_category)[1..1] = '8'))                                              => 27.35,
								  ((adl_category)[1..1] = '8') and not(((did_count = 1) and (rc_numelever > 3))) => 15.34,
																													9.76);

		verx_m_b1 := map(not((nas_summary = 12)) and not((nap_summary in [2, 5, 7, 8, 9, 11, 12]))                                                                                                                                           => 14.69,
						 not((nas_summary = 12))                                                                                                                                                                                             => 11.36,
						 (nas_summary = 12) and not(((nap_summary in [2, 5, 7, 8, 9, 11, 12]) or (nap_summary in [2, 3, 4, 8, 9, 10, 12])))                                                                                                  => 11.00,
						 (nas_summary = 12) and ((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and not(((nap_summary in [2, 3, 4, 8, 9, 10, 12]) and ((nap_summary in [3, 5, 6, 8, 10, 11, 12]) and (nap_summary in [4, 6, 7, 9, 10, 11, 12]))))) => 09.44,
																																																												07.50);

		mod_ver_b1 := if(dobpop, -2.852447267 +
			(did_ver_m_b1 * 0.0696027609) +
			(verx_m_b1 * 0.0396792894) +
			(min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6) * -0.048848033) +
			(min(if(combo_addrcount = NULL, -NULL, combo_addrcount), 5) * -0.030034585) +
			((integer)(combo_ssncount > 2) * 0.2114511904) +
			(min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5) * -0.024379566) +
			((integer)add1_isbestmatch * -0.142056448) +
			(if(max((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12])) = NULL, NULL, sum((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]))) * -0.032923906), -2.822146754 +
			(did_ver_nodob_m_b1 * 0.0699210044) +
			(verx_m_b1 * 0.037631352) +
			(min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6) * -0.071853632) +
			(min(if(combo_addrcount = NULL, -NULL, combo_addrcount), 5) * -0.032761954) +
			((integer)(combo_ssncount > 2) * 0.2084239663) +
			((integer)add1_isbestmatch * -0.144893221) +
			(if(max((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12])) = NULL, NULL, sum((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]))) * -0.029646534));

		gong_hist_summary_m_b1 := map(not((gong_did_phone_ct >= 6)) and (not((gong_did_addr_ct >= 5)) and not((gong_did_first_ct >= 3))) => 10.31,
									  (not((gong_did_phone_ct >= 6)) and (if(max((integer)(gong_did_addr_ct >= 5), (integer)(gong_did_first_ct >= 3)) = NULL, NULL, sum((integer)(gong_did_addr_ct >= 5), (integer)(gong_did_first_ct >= 3))) = 1)) => 12.46,
																																			14.86);

		time_on_gong_b1 := if('' in [gong_did_last_seen,gong_did_first_seen], NULL, (common.sas_date((string)gong_did_last_seen) - common.sas_date((string)gong_did_first_seen)) / 30.5);

		time_on_gong_b1_2 := if(time_on_gong_b1 = NULL, 30, time_on_gong_b1);

		in_dob2_b1 := common.sas_date((string)in_dob);

		ssns_per_adl_summary_b1 := min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 5);

		ssns_per_adl_summary_b1_2 := if(ssns_per_adl = 0, 5, ssns_per_adl_summary_b1);

		ssns_per_adl_summary_m_b1 := map(ssns_per_adl_summary_b1_2 = 1 => 9.87,
										 ssns_per_adl_summary_b1_2 = 2 => 10.93,
										 ssns_per_adl_summary_b1_2 = 3 => 11.76,
										 ssns_per_adl_summary_b1_2 = 4 => 12.82,
																		  17.24);

		yrsince_rc_ssnlowissue := transDate_yr((string)rc_ssnlowissue,today);

		rc_ssnlowissue2 := common.sas_date((string)rc_ssnlowissue);
		
		yrs_at_lowissue:= transDate_yr(in_dob,rc_ssnlowissue2);
		yrsince_rc_ssnlowissue_le10 := (yrsince_rc_ssnlowissue <=10);

		mod_prob_b1 := if(dobpop, 2.8649560095 +
			(-3.71236198 +
			(time_on_gong_b1_2 * -0.004732271) +
			(gong_hist_summary_m_b1 * 0.1448250515) +
			((integer)((rc_dirsaddr_lastscore <= 50) or (rc_dirsaddr_lastscore = 255)) * 0.1833351329) +
			((integer)((integer)rc_hriskphoneflag = 5) * 0.3661704109) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.3272194896) +
			((integer)((integer)rc_phonezipflag = 1) * 0.1263058705) * 0.8663826233) +
			((integer)(in_dob2_b1 != NULL and rc_ssnlowissue!=0 and ((common.sas_date((string)rc_ssnlowissue) - in_dob2_b1) / 365.25) >= 30) * 0.3587640927) +
			((integer)(yrsince_rc_ssnlowissue_le10) * 0.2998333678) +
			(-2.77543471 +
			(ssns_per_adl_summary_m_b1 * 0.0828306608) +
			((integer)(ssns_per_adl_c6 >= 2) * 0.3956289204) +
			((integer)((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))) * -0.267185838) * 0.8397712986) +
			(-2.257914758 +
			((integer)((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))) * 0.2258154025) +
			((integer)rc_input_addr_not_most_recent * 0.0890973446) +
			((integer)addrs_prison_history * 0.8172329282) +
			((integer)(addrs_per_adl >= 30) * 0.3249713512) +
			((integer)(addrs_per_adl_c6 >= 2) * 0.3715956156) +
			(invalid_addrs_per_adl_c6 * 0.5477899285) +
			((integer)rc_addrmiskeyflag * 0.2712321378) +
			((integer)((combo_addrscore <= 50) or (combo_addrscore = 255)) * 0.193118463) * 0.6274237104), 2.9142428069 +
			(-3.71236198 +
			(time_on_gong_b1_2 * -0.004732271) +
			(gong_hist_summary_m_b1 * 0.1448250515) +
			((integer)((rc_dirsaddr_lastscore <= 50) or (rc_dirsaddr_lastscore = 255)) * 0.1833351329) +
			((integer)((integer)rc_hriskphoneflag = 5) * 0.3661704109) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.3272194896) +
			((integer)((integer)rc_phonezipflag = 1) * 0.1263058705) * 0.8664422082) +
			((integer)(rc_ssnlowissue != 0 and (integer)((today - common.sas_date((string)rc_ssnlowissue)) / 365.25) <= 10) * 0.2676771407) +
			(-2.77543471 +
			(ssns_per_adl_summary_m_b1 * 0.0828306608) +
			((integer)(ssns_per_adl_c6 >= 2) * 0.3956289204) +
			((integer)((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))) * -0.267185838) * 0.8574425429) +
			(-2.257914758 +
			((integer)((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))) * 0.2258154025) +
			((integer)rc_input_addr_not_most_recent * 0.0890973446) +
			((integer)addrs_prison_history * 0.8172329282) +
			((integer)(addrs_per_adl >= 30) * 0.3249713512) +
			((integer)(addrs_per_adl_c6 >= 2) * 0.3715956156) +
			(invalid_addrs_per_adl_c6 * 0.5477899285) +
			((integer)rc_addrmiskeyflag * 0.2712321378) +
			((integer)((combo_addrscore <= 50) or (combo_addrscore = 255)) * 0.193118463) * 0.6294883247));

		prop1_sale_index_b1 := if(prop1_prev_purchase_price != 0, (prop1_sale_price - prop1_prev_purchase_price), NULL);

		prop1_sale_index2_b1 := if((real)prop1_sale_index_b1 != NULL, max(min(if((prop1_sale_index_b1 / 1000) = NULL, -NULL, (prop1_sale_index_b1 / 1000)), 300), -300), NULL);

		address_recency_m_b1 := map(attr_addrs_last30 > 0 => 12.97,
									attr_addrs_last90 > 0 => 13.35,
									attr_addrs_last12 > 0 => 11.03,
									attr_addrs_last24 > 0 => 10.68,
									attr_addrs_last36 > 0 => 10.82,
									addrs_5yr > 0         => 9.54,
									addrs_10yr > 0        => 8.14,
									addrs_15yr > 0        => 7.78,
															 7.86);

		out_addr_type_summary_b1 := map(out_addr_type = 'H' => 'H',
										out_addr_type = 'P' => 'P',
										out_addr_type = 'R' => 'R',
															   'Other');

		add1_land_use_code_summary_b1 := map(add1_land_use_code_2byte = ''            => '',
											 add1_land_use_code_2byte in ['10', '70'] => 'SingleFam',
											 add1_land_use_code_2byte in ['11', '19'] => 'MultiFam',
																						 'NonRes');

		addr_type_summary_b1 := map((out_addr_type_summary_b1 = 'H') or ((add1_land_use_code_summary_b1 = 'MultiFam') or (add1_unit_count >= 5)) => 'Apt',
									add1_land_use_code_summary_b1 = 'SingleFam'                                                                  => 'SingleFam',
									(add1_land_use_code_summary_b1 = 'NonRes') or (out_addr_type_summary_b1 in ['P', 'R'])                       => 'HiRisk',
																																					'Other');

		addr_type_summary_m_b1 := map(addr_type_summary_b1 = 'Apt'    => 11.59,
									  addr_type_summary_b1 = 'HiRisk' => 12.53,
									  addr_type_summary_b1 = 'Other'  => 10.86,
																		 9.44);

		add1_financing_type_m_b1 := map((add1_financing_type = '') and not((add1_mortgage_type in ['C', 'CNS', 'H']))    => 10.31,
										(add1_financing_type = 'ADJ') and not((add1_mortgage_type in ['C', 'CNS', 'H'])) => 10.97,
										(add1_financing_type = 'CNV') and not((add1_mortgage_type in ['C', 'CNS', 'H'])) => 9.97,
																															13.47);

		add1_naprop_summary_m_b1 := map((add1_naprop <= 1) and (property_owned_total = 0) => 11.40,
										add1_naprop <= 3                                  => 10.52,
																							 8.31);

		// mosince_criminal_last_date_84_b1 := if(((today - common.sas_date((string)criminal_last_date)) / 30.5) = NULL, 90, min(if(((today - common.sas_date((string)criminal_last_date)) / 30.5) = NULL, -NULL, ((today - common.sas_date((string)criminal_last_date)) / 30.5)), 84));
		transDate_mo(criminal_last_date, today,	mosince_criminal_last_date);
		mosince_criminal_last_date_84 := if(mosince_criminal_last_date = NULL, 90, min(mosince_criminal_last_date,84));
		mosince_criminal_last_date_84_b1 := mosince_criminal_last_date_84;


		impulse_count_2_b1 := if((real)impulse_count = NULL, 0, min(if(impulse_count = NULL, -NULL, impulse_count), 2));

		ams_college_tier_summary_b1 := if((3 <= (integer)ams_college_tier) AND ((integer)ams_college_tier <= 4), 3.5, (real)ams_college_tier);

		ams_college_tier_summary_m_b1 := map((integer)ams_college_tier_summary_b1 = 1 => 3.33,
											 (integer)ams_college_tier_summary_b1 = 2 => 5.15,
											 ams_college_tier_summary_b1 = 3.5        => 6.21,
											 (integer)ams_college_tier_summary_b1 = 5 => 7.43,
											 (integer)ams_college_tier_summary_b1 = 6 => 10.40,
																						 10.50);

		prof_license_category2_b1 := map(prof_license_category = ''          => 10.46,
										 (integer)prof_license_category = 0  => 12.32,
										 (integer)prof_license_category <= 3 => 9.75,
										 (integer)prof_license_category = 4  => 7.39,
																				5.94);

		addr_stability2_b1 := map((integer)addr_stability <= 2 => 12.79,
								  (integer)addr_stability = 3  => 10.61,
								  (integer)addr_stability <= 5 => 8.86,
																  5.86);

		in_dob2_b1_2 := common.sas_date((string)in_dob);

		time_on_eq_b1 := ((common.sas_date((string)adl_eq_last_seen) - common.sas_date((string)adl_eq_first_seen)) / 365.25);

		time_on_eq_b1_2 := if(0 in [adl_eq_last_seen,adl_eq_first_seen], 4, min(time_on_eq_b1,40));
		
		credit_first_seen_str := (string)credit_first_seen;
		header_first_seen_str := (string)header_first_seen;
		transdate_sas(credit_first_seen_str,credit_first_seen2);
		transdate_sas(header_first_seen_str,header_first_seen2);

		yrs_when_credit_first_seen := transdate_yr(in_dob,credit_first_seen2);
		yrs_when_header_first_seen := transdate_yr(in_dob,header_first_seen2);
		yrs_when_ln_first_seen := min(
			if(yrs_when_credit_first_seen=NULL, -NULL, yrs_when_credit_first_seen),
			if(yrs_when_header_first_seen=NULL, -NULL, yrs_when_header_first_seen)
		);

		hi_yrs_when_ln_first_seen := yrs_when_ln_first_seen != -NULL and yrs_when_ln_first_seen > 60;
		
		outest_b1 := if(dobpop, -1.171285635 +
			(mod_ver_b1 * 0.7887739116) +
			(mod_prob_b1 * 0.3128235718) +
			(address_recency_m_b1 * 0.027555765) +
			(min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 15) * 0.0277139855) +
			(-1.848570583 +
			(min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 6) * 0.0944606712) +
			((integer)((liens_recent_released_count > 0) or (liens_historical_released_count > 0)) * -0.147981962) +
			((integer)((boolean)liens_unrel_cj_ct or (boolean)liens_rel_cj_ct) * 0.0488865291) +
			((integer)((boolean)liens_unrel_fc_ct or (boolean)liens_rel_fc_ct) * -0.286334781) +
			((integer)((boolean)liens_unrel_lt_ct or (boolean)liens_rel_lt_ct) * 0.2896559953) +
			((integer)((boolean)liens_unrel_sc_ct or (boolean)liens_rel_sc_ct) * 0.1919585357) +
			((integer)((StringLib.StringToUpperCase(disposition) = 'DISMISSED') or ((filing_count >= 4) or ((bk_recent_count > 1) or ((bk_disposed_recent_count >= 4) or (bk_disposed_historical_count >= 3))))) * 0.121612293) +
			(min(if(criminal_count = NULL, -NULL, criminal_count), 7) * 0.0987422014) +
			(min(if(felony_count = NULL, -NULL, felony_count), 2) * 0.188452812) +
			(mosince_criminal_last_date_84_b1 * -0.004768451) +
			(impulse_count_2_b1 * 0.4440847706) * 0.7993689191) +
			(prof_license_category2_b1 * 0.0799482219) +
			(addr_stability2_b1 * 0.0550552232) +
			(ams_college_tier_summary_m_b1 * 0.1225338833) +
			((integer)hi_yrs_when_ln_first_seen * 0.5446069497) +
			((integer)((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)) * 0.1624979237), -1.119976911 +
			(mod_ver_b1 * 0.8067921714) +
			(mod_prob_b1 * 0.2932740076) +
			((integer)((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)) * 0.1686488265) +
			(address_recency_m_b1 * 0.0266107871) +
			(min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 15) * 0.0270078765) +
			(-1.848570583 +
			(min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 6) * 0.0944606712) +
			((integer)((liens_recent_released_count > 0) or (liens_historical_released_count > 0)) * -0.147981962) +
			((integer)((boolean)liens_unrel_cj_ct or (boolean)liens_rel_cj_ct) * 0.0488865291) +
			((integer)((boolean)liens_unrel_fc_ct or (boolean)liens_rel_fc_ct) * -0.286334781) +
			((integer)((boolean)liens_unrel_lt_ct or (boolean)liens_rel_lt_ct) * 0.2896559953) +
			((integer)((boolean)liens_unrel_sc_ct or (boolean)liens_rel_sc_ct) * 0.1919585357) +
			((integer)((StringLib.StringToUpperCase(disposition) = 'DISMISSED') or ((filing_count >= 4) or ((bk_recent_count > 1) or ((bk_disposed_recent_count >= 4) or (bk_disposed_historical_count >= 3))))) * 0.121612293) +
			(min(if(criminal_count = NULL, -NULL, criminal_count), 7) * 0.0987422014) +
			(min(if(felony_count = NULL, -NULL, felony_count), 2) * 0.188452812) +
			(mosince_criminal_last_date_84_b1 * -0.004768451) +
			(impulse_count_2_b1 * 0.4440847706) * 0.7825824233) +
			(prof_license_category2_b1 * 0.0771696395) +
			(addr_stability2_b1 * 0.0544587166) +
			(ams_college_tier_summary_m_b1 * 0.1257359617) +
			(time_on_eq_b1_2 * -0.004211154));

		did_ver_b2 := map((did_count = 1) and (combo_dobscore = 255) => 14.25,
						  (did_count = 1) and (rc_numelever <= 4)    => 10.94,
						  not((did_count = 1))                       => 8.62,
																		5.29);

		did_ver_nodob_m_b2 := if((did_count = 1) and (rc_numelever > 4), 5.36, 11.43);

		verx_m_b2 := map(not(add1_isbestmatch) and not((nap_summary in [2, 5, 7, 8, 9, 11, 12]))                                                                                                                                                                                                                         => 10.91,
						 (not(add1_isbestmatch) and ((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and not((nap_summary in [4, 6, 7, 9, 10, 11, 12])))) or (add1_isbestmatch and not(((nap_summary in [2, 5, 7, 8, 9, 11, 12]) or ((nap_summary in [4, 6, 7, 9, 10, 11, 12]) or (nap_summary in [3, 5, 6, 8, 10, 11, 12]))))) => 7.91,
						 add1_isbestmatch and not((nap_summary in [2, 5, 7, 8, 9, 11, 12]))                                                                                                                                                                                                                              => 6.69,
						 add1_isbestmatch and ((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and not((nap_summary in [4, 6, 7, 9, 10, 11, 12])))                                                                                                                                                                              => 6.15,
						 not(add1_isbestmatch) and (nap_summary in [2, 5, 7, 8, 9, 11, 12])                                                                                                                                                                                                                              => 5.09,
						 add1_isbestmatch and ((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and ((nap_summary in [4, 6, 7, 9, 10, 11, 12]) and not((nap_summary in [3, 5, 6, 8, 10, 11, 12]))))                                                                                                                              => 4.23,
																																																																															3.89);

		mod_ver_b2 := if(dobpop, -3.480026412 +
			(verx_m_b2 * 0.1395067004) +
			(did_ver_b2 * 0.0414399515) +
			(min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5) * -0.152962495) +
			((integer)(infutor_nap >= 11) * 0.2485588758), -3.315333648 +
			(verx_m_b2 * 0.1129324036) +
			(did_ver_nodob_m_b2 * 0.0555305156) +
			(min(if(combo_lnamecount = NULL, -NULL, combo_lnamecount), 6) * -0.138732566) +
			((integer)(infutor_nap >= 11) * 0.256578356));

		gong_hist_summary_m_b2 := map(not((gong_did_phone_ct >= 4)) and not((gong_did_addr_ct >= 5))                          => 5.80,
									  (gong_did_phone_ct >= 4) and not(((gong_did_addr_ct >= 5) or (gong_did_first_ct >= 3))) => 6.88,
																																 8.89);

		gong_did_first_seen2_b2 := common.sas_date((string)gong_did_first_seen);

		time_on_gong_b2 := if('' in [gong_did_last_seen,gong_did_first_seen], NULL, (common.sas_date((string)gong_did_last_seen) - common.sas_date((string)gong_did_first_seen)) / 30.5);
		
		time_on_gong_b2_2 := if(time_on_gong_b2 = NULL, 30, time_on_gong_b2);

		transDate_mo(gong_did_first_seen,today,mosince_gong_did_first_seen_b2);
		mosince_gong_did_first_seen := if(mosince_gong_did_first_seen_b2=NULL, 30, mosince_gong_did_first_seen_b2);

		ssns_per_adl_summary_b2 := min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 5);

		ssns_per_adl_summary_b2_2 := if(ssns_per_adl = 0, 5, ssns_per_adl_summary_b2);

		ssns_per_adl_summary_m_b2 := map(ssns_per_adl_summary_b2_2 = 1 => 9.87,
										 ssns_per_adl_summary_b2_2 = 2 => 10.93,
										 ssns_per_adl_summary_b2_2 = 3 => 11.76,
										 ssns_per_adl_summary_b2_2 = 4 => 12.82,
																		  17.24);

		prop1_sale_index_b2 := if(prop1_prev_purchase_price != 0, (prop1_sale_price - prop1_prev_purchase_price), NULL);

		prop1_sale_index2_b2 := if((real)prop1_sale_index_b2 != NULL, max(min(if((prop1_sale_index_b2 / 1000) = NULL, -NULL, (prop1_sale_index_b2 / 1000)), 300), -300), NULL);

		out_addr_type_summary_b2 := map(out_addr_type = 'H' => 'H',
										out_addr_type = 'P' => 'P',
										out_addr_type = 'R' => 'R',
															   'Other');

		add1_land_use_code_summary_b2 := map(add1_land_use_code_2byte = ''            => '',
											 add1_land_use_code_2byte in ['10', '19'] => 'SingleFam',
											 add1_land_use_code_2byte = '11'          => 'MultiFam',
											 add1_land_use_code_2byte = '70'          => 'Rural',
																						 'NonRes');

		addr_type_summary_b2 := map((out_addr_type_summary_b2 = 'H') or (add1_unit_count >= 5)                                                   => 'Apt',
									(add1_land_use_code_summary_b2 in ['SingleFam', 'MultiFam', 'Rural']) or (out_addr_type_summary_b2 in ['R']) => 'SingleMultiFamRural',
									(add1_land_use_code_summary_b2 = 'NonRes') or (out_addr_type_summary_b2 in ['P'])                            => 'HiRisk',
																																					'Other');

		addr_type_summary_m_b2 := map(addr_type_summary_b2 = 'Apt'    => 9.32,
									  addr_type_summary_b2 = 'HiRisk' => 6.89,
									  addr_type_summary_b2 = 'Other'  => 6.28,
																		 5.49);

		add1_avm_change1_b2 := if(round(min(if((add1_avm_automated_valuation_2 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_2 / 1000)), 300)) > 0, (round(min(if((add1_avm_automated_valuation / 1000) = NULL, -NULL, (add1_avm_automated_valuation / 1000)), 300)) / round(min(if((add1_avm_automated_valuation_2 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_2 / 1000)), 300))), NULL);

		add1_avm_change2_b2 := if(round(min(if((add1_avm_automated_valuation_3 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_3 / 1000)), 300)) > 0, (round(min(if((add1_avm_automated_valuation_2 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_2 / 1000)), 300)) / round(min(if((add1_avm_automated_valuation_3 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_3 / 1000)), 300))), NULL);

		add1_avm_change3_b2 := if(round(min(if((add1_avm_automated_valuation_4 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_4 / 1000)), 300)) > 0, (round(min(if((add1_avm_automated_valuation_3 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_3 / 1000)), 300)) / round(min(if((add1_avm_automated_valuation_4 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_4 / 1000)), 300))), NULL);

		add1_avm_change1_nomiss_b2 := if(add1_avm_change1_b2 = NULL, 1, add1_avm_change1_b2);

		add1_avm_change2_nomiss_b2 := if(add1_avm_change2_b2 = NULL, 1, add1_avm_change2_b2);

		add1_avm_change3_nomiss_b2 := if(add1_avm_change3_b2 = NULL, 1, add1_avm_change3_b2);

		add1_avm_index_b2 := (add1_avm_change1_nomiss_b2 * (add1_avm_change2_nomiss_b2 * add1_avm_change3_nomiss_b2));

		add1_avm_index_b2_2 := if((integer)NULL = 0, NULL, max((real)min(if(add1_avm_index_b2 = NULL, -NULL, add1_avm_index_b2), 2), 0.5));

		add1_avm_index_summary_m_b2 := map(add1_avm_index_b2_2 <= 0.7 => 7.91,
										   add1_avm_index_b2_2 <= 1.6 => 5.76,
																		 8.20);

		add1_financing_type_m_b2 := map((add1_financing_type = '') and not((add1_mortgage_type in ['2', 'G', 'H', 'R']))              => 5.29,
										(add1_financing_type in ['ADJ', 'OTH']) and not((add1_mortgage_type in ['2', 'G', 'H', 'R'])) => 7.43,
										add1_financing_type = 'CNV'                                                                   => 5.84,
																																		 9.58);

		add1_ownership_m_b2 := map(not(add1_applicant_owned) and add1_occupant_owned                                   => 8.65,
								   not(add1_applicant_owned) and (not(add1_family_owned) and not(add1_occupant_owned)) => 7.54,
								   add1_applicant_owned and add1_family_owned                                          => 4.35,
																														  6.93);

		add1_naprop_summary_m_b2 := map((add1_naprop <= 1) and (property_owned_total = 0) => 8.96,
										add1_naprop <= 3                                  => 7.76,
																							 5.28);

		ams_college_tier_summary_b2 := map((1 <= (integer)ams_college_tier) AND ((integer)ams_college_tier <= 3) => 2,
										   (4 <= (integer)ams_college_tier) AND ((integer)ams_college_tier <= 5) => 4.5,
																													6);

		ams_college_tier_summary_m_b2 := map((integer)ams_college_tier_summary_b2 = 2 => 3.36,
											 ams_college_tier_summary_b2 = 4.5        => 4.05,
																						 5.95);

		prof_license_category2_b2 := map(prof_license_category = ''          => 5.94,
										 (integer)prof_license_category <= 3 => 6.69,
										 (integer)prof_license_category = 4  => 4.24,
																				1.68);

		addr_stability2_b2 := if((2 <= (integer)addr_stability) AND ((integer)addr_stability <= 3), 2.5, (real)addr_stability);

		addr_stability2_m_b2 := map(addr_stability2_b2 = 0 => 7.30,
									addr_stability2_b2 = 1 => 12.61,
									addr_stability2_b2 = 2.5        => 7.13,
									addr_stability2_b2 = 4 => 5.75,
									addr_stability2_b2 = 5 => 4.43,
																	   3.17);

		most_recent_purchase_b2 := map(attr_num_purchase30 > 0  => 'd30',
									   attr_num_purchase90 > 0  => 'd90',
									   attr_num_purchase180 > 0 => 'd180',
									   attr_num_purchase12 > 0  => 'm12',
									   attr_num_purchase24 > 0  => 'm24',
									   attr_num_purchase36 > 0  => 'm36',
									   attr_num_purchase60 > 0  => 'm60',
																   'm60+');

		most_recent_purchase_m_b2 := map(most_recent_purchase_b2 in ['d30', 'd90', 'd180'] => 8.66,
										 most_recent_purchase_b2 = 'm12'                   => 8.19,
										 most_recent_purchase_b2 = 'm24'                   => 7.77,
										 most_recent_purchase_b2 = 'm36'                   => 5.54,
										 most_recent_purchase_b2 = 'm60'                   => 4.90,
										 attr_date_first_purchase > 0                      => 4.61,
																							  4.59);

		time_on_eq_b2 := ((common.sas_date((string)adl_eq_last_seen) - common.sas_date((string)adl_eq_first_seen)) / 365.25);

		time_on_eq_b2_2 := if(0 in [adl_eq_last_seen,adl_eq_first_seen], 4, min(time_on_eq_b2,40));

		did_ver_m_b3 := map(not((did_count = 1)) or ((did_count = 1) and (not((rc_numelever > 4)) and (combo_dobscore = 255))) => 15.84,
							(did_count = 1) and (not((rc_numelever > 4)) or (combo_dobscore != 100))                           => 12.38,
																																  8.20);

		did_ver_nodob_m_b3 := if((did_count = 1) and (rc_numelever > 4), 8.64, 13.98);

		verx_m_b3 := map(not((nas_summary = 12)) and not(((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and (nap_summary in [4, 6, 7, 9, 10, 11, 12]))) => 13.62,
						 ((not((nas_summary = 12)) and ((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and (nap_summary in [4, 6, 7, 9, 10, 11, 12]))) or ((nas_summary = 12) and (if(max((integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12])) = NULL, NULL, sum((integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]))) <= 1))) => 10.04,
						 (nas_summary = 12) and not(((nap_summary in [2, 5, 7, 8, 9, 11, 12]) and (nap_summary in [4, 6, 7, 9, 10, 11, 12])))      => 9.63,
																																					  7.18);

		mod_ver_b3 := if(dobpop, -2.556583244 +
			(verx_m_b3 * 0.05143678) +
			(did_ver_m_b3 * 0.0261014742) +
			(min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5) * -0.190332206) +
			((integer)add1_isbestmatch * -0.143575058) +
			((integer)(nas_summary in [1]) * -0.680190186) +
			((integer)(infutor_nap >= 7) * -0.115956686), -2.243453807 +
			(did_ver_nodob_m_b3 * 0.0476363701) +
			(min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6) * -0.171337723) +
			((integer)add1_isbestmatch * -0.111991796) +
			((integer)(nas_summary in [1]) * -0.674610375) +
			((integer)(nas_summary in [4, 7, 9]) * 0.148073691) +
			((integer)(infutor_nap >= 7) * -0.112390766));

		gong_did_first_seen2_b3 := common.sas_date((string)gong_did_first_seen);

		time_on_gong_b3 := if('' in [gong_did_last_seen,gong_did_first_seen], NULL, (common.sas_date((string)gong_did_last_seen) - common.sas_date((string)gong_did_first_seen)) / 30.5);
		time_on_gong_b3_2 := if(time_on_gong_b3 = NULL, 30, time_on_gong_b3);

		transDate_mo(gong_did_first_seen,today,mosince_gong_did_first_seen_b3);
		mosince_gong_did_first_seen_b3_2 := if(mosince_gong_did_first_seen_b3=NULL, 30, mosince_gong_did_first_seen_b3);

		ssns_per_adl_summary_b3 := max(min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 4), 2);

		ssns_per_adl_summary_b3_2 := if(ssns_per_adl = 0, 4, ssns_per_adl_summary_b3);

		ssns_per_adl_summary_m_b3 := map(ssns_per_adl_summary_b3_2 = 2 => 10.04,
										 ssns_per_adl_summary_b3_2 = 3 => 11.62,
																		  14.08);

		address_recency_b3 := map(attr_addrs_last30 > 0 => 'd30',
								  attr_addrs_last90 > 0 => 'd90',
								  attr_addrs_last12 > 0 => 'm12',
								  attr_addrs_last24 > 0 => 'm24',
								  attr_addrs_last36 > 0 => 'm36',
								  addrs_5yr > 0         => 'y05',
								  addrs_10yr > 0        => 'y10',
								  addrs_15yr > 0        => 'y15',
															'bogus');

		address_recency2_b3 := if(address_recency_b3 in ['m24', 'm36', 'y05'], 'y05', address_recency_b3);

		address_recency2_m_b3 := map(//address_recency2_b3 = ''    => 10.86,
									 address_recency2_b3 = 'd30' => 14.05,
									 address_recency2_b3 = 'd90' => 13.68,
									 address_recency2_b3 = 'm12' => 10.88,
									 address_recency2_b3 = 'y05' => 9.17,
									 address_recency2_b3 = 'y10' => 8.31,
									 address_recency2_b3 = 'y15' => 6.78,
																	10.86);

		add1_financing_type_m_b3 := map((add1_financing_type = 'CNV') and not((add1_mortgage_type in ['2', 'G', 'H', 'R'])) => 7.90,
										(add1_financing_type = '') and not((add1_mortgage_type in ['2', 'G', 'H', 'R']))    => 10.09,
										(add1_financing_type = 'ADJ') and not((add1_mortgage_type in ['2', 'G', 'H', 'R'])) => 11.13,
																															   12.50);

		ams_college_tier_summary_b3 := map((1 <= (integer)ams_college_tier) AND ((integer)ams_college_tier <= 3) => 2,
										   (4 <= (integer)ams_college_tier) AND ((integer)ams_college_tier <= 5) => 4.5,
										   (integer)ams_college_tier = 6                                         => 6,
																													7);

		ams_college_tier_summary_m_b3 := map((integer)ams_college_tier_summary_b3 = 2 => 4.79,
											 ams_college_tier_summary_b3 = 4.5        => 7.43,
											 (integer)ams_college_tier_summary_b3 = 6 => 8.39,
																						 10.45);

		addr_stability2_b3 := map((1 <= (integer)addr_stability) AND ((integer)addr_stability <= 2) => 1.5,
								  (4 <= (integer)addr_stability) AND ((integer)addr_stability <= 5) => 4.5,
																									   (real)addr_stability);

		addr_stability2_m_b3 := map((integer)addr_stability2_b3 = 0 => 13.57,
									addr_stability2_b3 = 1.5        => 11.57,
									(integer)addr_stability2_b3 = 3 => 10.39,
									addr_stability2_b3 = 4.5        => 8.56,
																	   6.17);

		outest_b3 := if(dobpop, -2.480680083 +
			(mod_ver_b3 * 0.5808355572) +
			(-1.969465254 +
			(time_on_gong_b3_2 * -0.00278098) +
			(mosince_gong_did_first_seen_b3_2 * -0.00749891) +
			((integer)((nap_status = 'D') or (recent_disconnects > 0)) * 0.2377783803) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.205573326) +
			((integer)((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)) * 0.0996425283) * 0.3961257181) +
			(-2.951893872 +
			((integer)(addrs_per_adl <= 2) * 0.2441075121) +
			((integer)(addrs_per_adl_c6 > 0) * 0.3832428107) +
			((integer)(vo_addrs_per_adl = 0) * 0.439177912) +
			((integer)(pl_addrs_per_adl = 0) * 0.1915981038) +
			((integer)((add1_address_score < 70) or (add1_address_score = 255)) * 0.4276960437) * 0.4722410927) +
			((integer)((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))) * -0.116115154) +
			(ssns_per_adl_summary_m_b3 * 0.0923210686) +
			(address_recency2_m_b3 * 0.0366761278) +
			(add1_financing_type_m_b3 * 0.0711144784) +
			((integer)(impulse_count > 0) * 0.7769659368) +
			(ams_college_tier_summary_m_b3 * 0.0941149478) +
			(addr_stability2_m_b3 * 0.0443309899) +
			((integer)((eq_count >= 40) or (eq_count = 0)) * -0.617273793) +
			((integer)((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)) * -0.558524162), -1.90311519 +
			(mod_ver_b3 * 0.5292095853) +
			(-1.969465254 +
			(time_on_gong_b3_2 * -0.00278098) +
			(mosince_gong_did_first_seen_b3_2 * -0.00749891) +
			((integer)((nap_status = 'D') or (recent_disconnects > 0)) * 0.2377783803) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.205573326) +
			((integer)((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)) * 0.0996425283) * 0.4057068039) +
			(-2.951893872 +
			((integer)(addrs_per_adl <= 2) * 0.2441075121) +
			((integer)(addrs_per_adl_c6 > 0) * 0.3832428107) +
			((integer)(vo_addrs_per_adl = 0) * 0.439177912) +
			((integer)(pl_addrs_per_adl = 0) * 0.1915981038) +
			((integer)((add1_address_score < 70) or (add1_address_score = 255)) * 0.4276960437) * 0.4016965136) +
			(address_recency2_m_b3 * 0.0452416165) +
			(add1_financing_type_m_b3 * 0.0745278958) +
			((integer)(impulse_count > 0) * 0.7857661528) +
			(ams_college_tier_summary_m_b3 * 0.0981154504) +
			((integer)(max(min(if(round((pred_inc / 1000)) = NULL, -NULL, round((pred_inc / 1000))), 200), 8) > 85) * -0.350953903) +
			(addr_stability2_m_b3 * 0.0363304947) +
			((integer)((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)) * -0.568396766));

		input_dob_match_level_8 := (integer)((integer)input_dob_match_level=8);
		mod_ver_b4 := if(dobpop, -1.665226077 +
			((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]) * -0.151248012) +
			((integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]) * -0.318246264) +
			(input_dob_match_level_8 * -0.124341313) +
			(min(if(combo_lnamecount = NULL, -NULL, combo_lnamecount), 6) * -0.067725936) +
			(min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5) * -0.09143648) +
			((integer)add1_isbestmatch * -0.169879293) +
			((integer)(nas_summary in [4, 7, 9]) * 0.202099101), -1.687947161 +
			((integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]) * -0.331076546) +
			(min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6) * -0.105167384) +
			(min(if(combo_lnamecount = NULL, -NULL, combo_lnamecount), 6) * -0.078766534) +
			((integer)add1_isbestmatch * -0.172029191) +
			((integer)(nas_summary in [4, 7, 9]) * 0.2001921197));

		combo_hphnscore_summary_m_b4 := map(combo_hphonescore <= 70  => 11.50,
											combo_hphonescore != 255 => 9.09,
																		10.84);

		gong_did_first_seen2_b4 := common.sas_date((string)gong_did_first_seen);

		time_on_gong_b4 := if('' in [gong_did_last_seen,gong_did_first_seen], NULL, (common.sas_date((string)gong_did_last_seen) - common.sas_date((string)gong_did_first_seen)) / 30.5);
		time_on_gong_b4_2 := if(time_on_gong_b4 = NULL, 30, time_on_gong_b4);

		transDate_mo(gong_did_first_seen,today,mosince_gong_did_first_seen_b4);
		mosince_gong_did_first_seen_b4_2 := if(mosince_gong_did_first_seen_b4=NULL, 30, mosince_gong_did_first_seen_b4);

		ssns_per_adl_summary_b4 := min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 4);

		ssns_per_adl_summary_b4_2 := if(ssns_per_adl = 0, 2, ssns_per_adl_summary_b4);

		ssns_per_adl_summary_m_b4 := map(ssns_per_adl_summary_b4_2 = 1 => 8.56,
										 ssns_per_adl_summary_b4_2 = 2 => 9.51,
										 ssns_per_adl_summary_b4_2 = 3 => 11.52,
																		  13.84);

		adlperssn_count_summary_b4 := map(adlperssn_count <= 1 => 0.5,
										  adlperssn_count <= 3 => 2.5,
																  min(if(adlperssn_count = NULL, -NULL, adlperssn_count), 5));

		adlperssn_count_summary_m_b4 := map(adlperssn_count_summary_b4 = 0.5        => 8.53,
											adlperssn_count_summary_b4 = 2.5        => 9.41,
											(integer)adlperssn_count_summary_b4 = 4 => 10.35,
																					   14.81);

		address_recency_b4 := map(attr_addrs_last30 > 0 => 'd30',
								  attr_addrs_last90 > 0 => 'd90',
								  attr_addrs_last12 > 0 => 'm12',
								  attr_addrs_last24 > 0 => 'm24',
								  attr_addrs_last36 > 0 => 'm36',
								  addrs_5yr > 0         => 'y05',
								  addrs_10yr > 0        => 'y10',
								  addrs_15yr > 0        => 'y15',
														   'bogus');

		address_recency2_b4 := map(address_recency_b4 in ['d30', 'd90'] => 'd90',
								   address_recency_b4 in ['m36', 'y05'] => 'y05',
																		   address_recency_b4);

		address_recency2_m_b4 := map(//address_recency2_b4 = ''    => 6.11,
									 address_recency2_b4 = 'd90' => 12.47,
									 address_recency2_b4 = 'm12' => 10.57,
									 address_recency2_b4 = 'm24' => 9.33,
									 address_recency2_b4 = 'y05' => 8.53,
									 address_recency2_b4 = 'y10' => 7.05,
									 address_recency2_b4 = 'y15' => 5.12,
																	6.11);

		prof_license_category_m_b4 := map(trim(prof_license_category) = '' => 8.99,
										  ((integer)(real)prof_license_category = 0) => 12.04,
										  ((integer)(real)prof_license_category = 1) => 8.20,
										  ((integer)(real)prof_license_category = 2) => 6.16,
										  ((integer)(real)prof_license_category = 3) => 4.41,
										  ((integer)(real)prof_license_category = 4) => 3.91,
																				1.82);

		addr_stability2_b4 := if((2 <= (integer)addr_stability) AND ((integer)addr_stability <= 3), 2.5, (real)addr_stability);

		addr_stability2_m_b4 := map(addr_stability2_b4 = 0 => 10.53,
									addr_stability2_b4 = 1 => 12.75,
									addr_stability2_b4 = 2.5        => 10.04,
									addr_stability2_b4 = 4 => 8.21,
									addr_stability2_b4 = 5 => 6.92,
																	   4.97);

		ams_income_level_summary_b4 := map(ams_income_level_code = ''                                   => 0,
										   ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'G'] => 1,
																										   2);

		ams_college_code_summary_b4 := map(ams_college_code in ['1', '4'] => 4,
										   (integer)ams_college_code = 2  => 2,
																			 0);

		ams_college_income_summary_m_b4 := map((ams_college_code_summary_b4 = 0) and (ams_income_level_summary_b4 = 0) => 9.15,
											   (ams_college_code_summary_b4 = 0) and (ams_income_level_summary_b4 = 1) => 10.09,
											   (ams_college_code_summary_b4 = 0) and (ams_income_level_summary_b4 = 2) => 7.82,
																														  4.35);

		combo_dobcount_5 := map(hm_segment_2 = '0 Derog'  => min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5),
								hm_segment_2 = '1 Owner'  => min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5),
								hm_segment_2 = '2 Renter' => min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5),
															 min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 5));

		cell_pager_pcs := map(hm_segment_2 = '0 Derog'  => (rc_hriskphoneflag in ['1', '2', '3']),
							  hm_segment_2 = '1 Owner'  => (rc_hriskphoneflag in ['1', '2', '3']),
							  hm_segment_2 = '2 Renter' => (rc_hriskphoneflag in ['1', '2', '3']),
														   (rc_hriskphoneflag in ['1', '2', '3']));

		contrary_ssn := map(hm_segment_2 = '0 Derog'  => NULL,
							hm_segment_2 = '1 Owner'  => NULL,
							hm_segment_2 = '2 Renter' => (nas_summary in [1]),
														 NULL);

		residential_phone := map(hm_segment_2 = '0 Derog'  => NULL,
								 hm_segment_2 = '1 Owner'  => ((integer)rc_phonevalflag = 2),
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		ams_college_tier_summary := map(hm_segment_2 = '0 Derog'  => ams_college_tier_summary_b1,
										hm_segment_2 = '1 Owner'  => ams_college_tier_summary_b2,
										hm_segment_2 = '2 Renter' => ams_college_tier_summary_b3,
																	 NULL);

		attr_addrs_last12_4 := map(hm_segment_2 = '0 Derog'  => NULL,
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																min(if(attr_addrs_last12 = NULL, -NULL, attr_addrs_last12), 4));

		criminal_count_7 := map(hm_segment_2 = '0 Derog'  => min(if(criminal_count = NULL, -NULL, criminal_count), 7),
								hm_segment_2 = '1 Owner'  => NULL,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		ssns_per_adl_summary := map(hm_segment_2 = '0 Derog'  => ssns_per_adl_summary_b1_2,
									hm_segment_2 = '1 Owner'  => ssns_per_adl_summary_b2_2,
									hm_segment_2 = '2 Renter' => ssns_per_adl_summary_b3_2,
																 ssns_per_adl_summary_b4_2);

		hi_pred_income := map(hm_segment_2 = '0 Derog'  => NULL,
							  hm_segment_2 = '1 Owner'  => NULL,
							  hm_segment_2 = '2 Renter' => (max(min(if(round((pred_inc / 1000)) = NULL, -NULL, round((pred_inc / 1000))), 200), 8) > 85),
														   NULL);

		addr_stability2 := map(hm_segment_2 = '0 Derog'  => addr_stability2_b1,
							   hm_segment_2 = '1 Owner'  => addr_stability2_b2,
							   hm_segment_2 = '2 Renter' => addr_stability2_b3,
															addr_stability2_b4);

		verlst_p := map(hm_segment_2 = '0 Derog'  => (nap_summary in [2, 5, 7, 8, 9, 11, 12]),
						hm_segment_2 = '1 Owner'  => (nap_summary in [2, 5, 7, 8, 9, 11, 12]),
						hm_segment_2 = '2 Renter' => (nap_summary in [2, 5, 7, 8, 9, 11, 12]),
													 NULL);

		add1_avm_index := map(hm_segment_2 = '0 Derog'  => NULL,
							  hm_segment_2 = '1 Owner'  => add1_avm_index_b2_2,
							  hm_segment_2 = '2 Renter' => NULL,
														   NULL);
		inputssncharflag_val := (integer)(inputssncharflag = '0');
		

		hi_combo_ssncount := map(hm_segment_2 = '0 Derog'  => (combo_ssncount > 2),
								 hm_segment_2 = '1 Owner'  => NULL,
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		add1_avm_change1_2 := map(hm_segment_2 = '0 Derog'  => NULL,
								  hm_segment_2 = '1 Owner'  => min(if(add1_avm_change1_b2 = NULL, -NULL, add1_avm_change1_b2), 2),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		did_ver_m := map(hm_segment_2 = '0 Derog'  => did_ver_m_b1,
						 hm_segment_2 = '1 Owner'  => NULL,
						 hm_segment_2 = '2 Renter' => did_ver_m_b3,
													  NULL);

		add1_avm_automated_val2_300k := map(hm_segment_2 = '0 Derog'  => NULL,
											hm_segment_2 = '1 Owner'  => round(min(if((add1_avm_automated_valuation_2 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_2 / 1000)), 300)),
											hm_segment_2 = '2 Renter' => NULL,
																		 NULL);

		mod_derog := map(hm_segment_2 = '0 Derog'  => -1.848570583 +
			(min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 6) * 0.0944606712) +
			((integer)((liens_recent_released_count > 0) or (liens_historical_released_count > 0)) * -0.147981962) +
			((integer)((boolean)liens_unrel_cj_ct or (boolean)liens_rel_cj_ct) * 0.0488865291) +
			((integer)((boolean)liens_unrel_fc_ct or (boolean)liens_rel_fc_ct) * -0.286334781) +
			((integer)((boolean)liens_unrel_lt_ct or (boolean)liens_rel_lt_ct) * 0.2896559953) +
			((integer)((boolean)liens_unrel_sc_ct or (boolean)liens_rel_sc_ct) * 0.1919585357) +
			((integer)((StringLib.StringToUpperCase(disposition) = 'DISMISSED') or ((filing_count >= 4) or ((bk_recent_count > 1) or ((bk_disposed_recent_count >= 4) or (bk_disposed_historical_count >= 3))))) * 0.121612293) +
			(min(if(criminal_count = NULL, -NULL, criminal_count), 7) * 0.0987422014) +
			(min(if(felony_count = NULL, -NULL, felony_count), 2) * 0.188452812) +
			(mosince_criminal_last_date_84_b1 * -0.004768451) +
			(impulse_count_2_b1 * 0.4440847706),
						 hm_segment_2 = '1 Owner'  => NULL,
						 hm_segment_2 = '2 Renter' => NULL,
													  NULL);

		add1_unit_count_5 := map(hm_segment_2 = '0 Derog'  => min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5),
								 hm_segment_2 = '1 Owner'  => min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5),
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		ams_college_tier_summary_m := map(hm_segment_2 = '0 Derog'  => ams_college_tier_summary_m_b1,
										  hm_segment_2 = '1 Owner'  => ams_college_tier_summary_m_b2,
										  hm_segment_2 = '2 Renter' => ams_college_tier_summary_m_b3,
																	   NULL);

		add1_avm_change1_nomiss := map(hm_segment_2 = '0 Derog'  => NULL,
									   hm_segment_2 = '1 Owner'  => add1_avm_change1_nomiss_b2,
									   hm_segment_2 = '2 Renter' => NULL,
																	NULL);

		liens_recent_released_ind := map(hm_segment_2 = '0 Derog'  => (liens_recent_released_count > 0),
										 hm_segment_2 = '1 Owner'  => NULL,
										 hm_segment_2 = '2 Renter' => NULL,
																	  NULL);

		ams_college_code_summary := map(hm_segment_2 = '0 Derog'  => NULL,
										hm_segment_2 = '1 Owner'  => NULL,
										hm_segment_2 = '2 Renter' => NULL,
																	 ams_college_code_summary_b4);

		adlperssn_count_summary := map(hm_segment_2 = '0 Derog'  => NULL,
									   hm_segment_2 = '1 Owner'  => NULL,
									   hm_segment_2 = '2 Renter' => NULL,
																	adlperssn_count_summary_b4);

		log10_pred_inc := map(hm_segment_2 = '0 Derog'  => log(pred_inc),
							  hm_segment_2 = '1 Owner'  => log(pred_inc),
							  hm_segment_2 = '2 Renter' => NULL,
														   NULL);

		mod_ver := map(hm_segment_2 = '0 Derog'  => mod_ver_b1,
					   hm_segment_2 = '1 Owner'  => mod_ver_b2,
					   hm_segment_2 = '2 Renter' => mod_ver_b3,
													mod_ver_b4);

		bad_bk := map(hm_segment_2 = '0 Derog'  => ((StringLib.StringToUpperCase(disposition) = 'DISMISSED') or ((filing_count >= 4) or ((bk_recent_count > 1) or ((bk_disposed_recent_count >= 4) or (bk_disposed_historical_count >= 3))))),
					  hm_segment_2 = '1 Owner'  => NULL,
					  hm_segment_2 = '2 Renter' => NULL,
												   NULL);

		addr_stability2_m := map(hm_segment_2 = '0 Derog'  => NULL,
								 hm_segment_2 = '1 Owner'  => addr_stability2_m_b2,
								 hm_segment_2 = '2 Renter' => addr_stability2_m_b3,
															  addr_stability2_m_b4);

		hi_addrs_per_adl := map(hm_segment_2 = '0 Derog'  => (addrs_per_adl >= 30),
								hm_segment_2 = '1 Owner'  => (addrs_per_adl >= 30),
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		liens_released_ind := map(hm_segment_2 = '0 Derog'  => ((liens_recent_released_count > 0) or (liens_historical_released_count > 0)),
								  hm_segment_2 = '1 Owner'  => NULL,
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		invalid_addrs_per_adl_c6_ind := map(hm_segment_2 = '0 Derog'  => (invalid_addrs_per_adl_c6 > 0),
											hm_segment_2 = '1 Owner'  => NULL,
											hm_segment_2 = '2 Renter' => NULL,
																		 NULL);

		address_recency_m := map(hm_segment_2 = '0 Derog'  => address_recency_m_b1,
								 hm_segment_2 = '1 Owner'  => NULL,
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		addrs_10yr_15 := map(hm_segment_2 = '0 Derog'  => min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 15),
							 hm_segment_2 = '1 Owner'  => NULL,
							 hm_segment_2 = '2 Renter' => NULL,
														  min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 15));

		hi_gong_did_addr_ct := map(hm_segment_2 = '0 Derog'  => (gong_did_addr_ct >= 5),
								   hm_segment_2 = '1 Owner'  => (gong_did_addr_ct >= 5),
								   hm_segment_2 = '2 Renter' => NULL,
																NULL);

		liens_recent_unreleased_count_6 := map(hm_segment_2 = '0 Derog'  => min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 6),
											   hm_segment_2 = '1 Owner'  => NULL,
											   hm_segment_2 = '2 Renter' => NULL,
																			NULL);

		add1_avm_change2_nomiss := map(hm_segment_2 = '0 Derog'  => NULL,
									   hm_segment_2 = '1 Owner'  => add1_avm_change2_nomiss_b2,
									   hm_segment_2 = '2 Renter' => NULL,
																	NULL);

		zip_mismatch := map(hm_segment_2 = '0 Derog'  => false,
							hm_segment_2 = '1 Owner'  => false,
							hm_segment_2 = '2 Renter' => false,
														 ((boolean)(integer)rc_statezipflag or (boolean)(integer)rc_cityzipflag));

		// hi_yrs_when_ln_first_seen := map(hm_segment_2 = '0 Derog'  => ((integer)if(max(((common.sas_date((string)credit_first_seen) - in_dob2_b1_2) / 365.25), ((common.sas_date((string)header_first_seen) - common.sas_date((string)in_dob)) / 365.25)) = NULL, NULL, min(if(((common.sas_date((string)credit_first_seen) - in_dob2_b1_2) / 365.25) = NULL, -NULL, ((common.sas_date((string)credit_first_seen) - in_dob2_b1_2) / 365.25)), if(((common.sas_date((string)header_first_seen) - common.sas_date((string)in_dob)) / 365.25) = NULL, -NULL, ((common.sas_date((string)header_first_seen) - common.sas_date((string)in_dob)) / 365.25)))) > 60),
										 // hm_segment_2 = '1 Owner'  => NULL,
										 // hm_segment_2 = '2 Renter' => NULL,
																	  // NULL);

		addrs_15yr_20 := map(hm_segment_2 = '0 Derog'  => NULL,
							 hm_segment_2 = '1 Owner'  => NULL,
							 hm_segment_2 = '2 Renter' => NULL,
														  min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 20));

		did_ver_nodob_m := map(hm_segment_2 = '0 Derog'  => did_ver_nodob_m_b1,
							   hm_segment_2 = '1 Owner'  => did_ver_nodob_m_b2,
							   hm_segment_2 = '2 Renter' => did_ver_nodob_m_b3,
															NULL);

		most_recent_purchase_m := map(hm_segment_2 = '0 Derog'  => NULL,
									  hm_segment_2 = '1 Owner'  => most_recent_purchase_m_b2,
									  hm_segment_2 = '2 Renter' => NULL,
																   NULL);

		hi_gong_did_phone_ct := map(hm_segment_2 = '0 Derog'  => (gong_did_phone_ct >= 6),
									hm_segment_2 = '1 Owner'  => (gong_did_phone_ct >= 4),
									hm_segment_2 = '2 Renter' => NULL,
																 NULL);

		add1_avm_automated_val3_300k := map(hm_segment_2 = '0 Derog'  => NULL,
											hm_segment_2 = '1 Owner'  => round(min(if((add1_avm_automated_valuation_3 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_3 / 1000)), 300)),
											hm_segment_2 = '2 Renter' => NULL,
																		 NULL);


		mod_prop := map(hm_segment_2 = '0 Derog'  => -5.335237533 +
			(addr_type_summary_m_b1 * 0.048240784) +
			(add1_naprop_summary_m_b1 * 0.1028961798) +
			(add1_financing_type_m_b1 * 0.1538363662) +
			((integer)((NULL < (real)prop1_sale_index2_b1) AND (prop1_sale_index2_b1 < -50)) * 0.3182550927),
						hm_segment_2 = '1 Owner'  => -6.413517145 +
			(add1_ownership_m_b2 * 0.1498454379) +
			(add1_naprop_summary_m_b2 * 0.0517586554) +
			((integer)((NULL < (real)prop1_sale_index2_b2) AND (prop1_sale_index2_b2 < -50)) * 0.3030610822) +
			(add1_avm_index_summary_m_b2 * 0.1550154917) +
			(addr_type_summary_m_b2 * 0.0830205644) +
			(add1_financing_type_m_b2 * 0.1699277097),
						hm_segment_2 = '2 Renter' => NULL,
													 NULL);

		no_vo_addrs_per_adl := map(hm_segment_2 = '0 Derog'  => false,
								   hm_segment_2 = '1 Owner'  => false,
								   hm_segment_2 = '2 Renter' => (vo_addrs_per_adl = 0),
																(vo_addrs_per_adl = 0));

		liens_historical_released_ind := map(hm_segment_2 = '0 Derog'  => (liens_historical_released_count > 0),
											 hm_segment_2 = '1 Owner'  => false,
											 hm_segment_2 = '2 Renter' => false,
																		  false);

		ams_income_level_summary := map(hm_segment_2 = '0 Derog'  => NULL,
										hm_segment_2 = '1 Owner'  => NULL,
										hm_segment_2 = '2 Renter' => NULL,
																	 ams_income_level_summary_b4);

		hi_lo_eq_count := map(hm_segment_2 = '0 Derog'  => false,
							  hm_segment_2 = '1 Owner'  => false,
							  hm_segment_2 = '2 Renter' => ((eq_count >= 40) or (eq_count = 0)),
														   false);

		add1_ownership_m := map(hm_segment_2 = '0 Derog'  => NULL,
								hm_segment_2 = '1 Owner'  => add1_ownership_m_b2,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		no_ssn_sources := map(hm_segment_2 = '0 Derog'  => (combo_ssncount = 0),
							  hm_segment_2 = '1 Owner'  => (combo_ssncount = 0),
							  hm_segment_2 = '2 Renter' => false,
														   false);

		combo_hphnscore_summary_m := map(hm_segment_2 = '0 Derog'  => NULL,
										 hm_segment_2 = '1 Owner'  => NULL,
										 hm_segment_2 = '2 Renter' => NULL,
																	  combo_hphnscore_summary_m_b4);

		most_recent_purchase := map(hm_segment_2 = '0 Derog'  => '',
									hm_segment_2 = '1 Owner'  => most_recent_purchase_b2,
									hm_segment_2 = '2 Renter' => '',
																 '');

		felony_count_2 := map(hm_segment_2 = '0 Derog'  => min(if(felony_count = NULL, -NULL, felony_count), 2),
							  hm_segment_2 = '1 Owner'  => NULL,
							  hm_segment_2 = '2 Renter' => NULL,
														   NULL);

		ams_college_income_summary_m := map(hm_segment_2 = '0 Derog'  => NULL,
											hm_segment_2 = '1 Owner'  => NULL,
											hm_segment_2 = '2 Renter' => NULL,
																		 ams_college_income_summary_m_b4);

		yrs_at_lowissue_ge30 := yrs_at_lowissue >= 30;

		lo_addrs_per_adl := map(hm_segment_2 = '0 Derog'  => false,
								hm_segment_2 = '1 Owner'  => false,
								hm_segment_2 = '2 Renter' => (addrs_per_adl <= 2),
															 false);

		add1_avm_change2_2 := map(hm_segment_2 = '0 Derog'  => NULL,
								  hm_segment_2 = '1 Owner'  => min(if(add1_avm_change2_b2 = NULL, -NULL, add1_avm_change2_b2), 2),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		address_recency2_m := map(hm_segment_2 = '0 Derog'  => NULL,
								  hm_segment_2 = '1 Owner'  => NULL,
								  hm_segment_2 = '2 Renter' => address_recency2_m_b3,
															   address_recency2_m_b4);

		gong_did_first_seen2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)gong_did_first_seen),
									hm_segment_2 = '1 Owner'  => common.sas_date((string)gong_did_first_seen),
									hm_segment_2 = '2 Renter' => common.sas_date((string)gong_did_first_seen),
																 common.sas_date((string)gong_did_first_seen));

		time_on_gong := map(hm_segment_2 = '0 Derog'  => time_on_gong_b1_2,
							hm_segment_2 = '1 Owner'  => time_on_gong_b2_2,
							hm_segment_2 = '2 Renter' => time_on_gong_b3_2,
														 time_on_gong_b4_2);

		ssnprior := map(hm_segment_2 = '0 Derog'  => ((integer)rc_ssndobflag = 1),
						hm_segment_2 = '1 Owner'  => ((integer)rc_ssndobflag = 1),
						hm_segment_2 = '2 Renter' => NULL,
													 NULL);

		addr_type_summary_m := map(hm_segment_2 = '0 Derog'  => addr_type_summary_m_b1,
								   hm_segment_2 = '1 Owner'  => addr_type_summary_m_b2,
								   hm_segment_2 = '2 Renter' => NULL,
																NULL);

		add1_financing_type_m := map(hm_segment_2 = '0 Derog'  => add1_financing_type_m_b1,
									 hm_segment_2 = '1 Owner'  => add1_financing_type_m_b2,
									 hm_segment_2 = '2 Renter' => add1_financing_type_m_b3,
																  NULL);

		adlperssn_count_summary_m := map(hm_segment_2 = '0 Derog'  => NULL,
										 hm_segment_2 = '1 Owner'  => NULL,
										 hm_segment_2 = '2 Renter' => NULL,
																	  adlperssn_count_summary_m_b4);

		prop1_sale_index := map(hm_segment_2 = '0 Derog'  => prop1_sale_index_b1,
								hm_segment_2 = '1 Owner'  => prop1_sale_index_b2,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		impulse_ind := map(hm_segment_2 = '0 Derog'  => false,
						   hm_segment_2 = '1 Owner'  => (impulse_count > 0),
						   hm_segment_2 = '2 Renter' => (impulse_count > 0),
														(impulse_count > 0));

		lo_combo_ssnscore := map(hm_segment_2 = '0 Derog'  => ((combo_ssnscore < 80) or (combo_ssnscore = 255)),
								 hm_segment_2 = '1 Owner'  => ((combo_ssnscore < 80) or (combo_ssnscore = 255)),
								 hm_segment_2 = '2 Renter' => false,
															  false);

		mod_phnprob := map(hm_segment_2 = '0 Derog'  => -3.71236198 +
			(time_on_gong_b1_2 * -0.004732271) +
			(gong_hist_summary_m_b1 * 0.1448250515) +
			((integer)((rc_dirsaddr_lastscore <= 50) or (rc_dirsaddr_lastscore = 255)) * 0.1833351329) +
			((integer)((integer)rc_hriskphoneflag = 5) * 0.3661704109) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.3272194896) +
			((integer)((integer)rc_phonezipflag = 1) * 0.1263058705),
						   hm_segment_2 = '1 Owner'  => -4.263521317 +
			(time_on_gong_b2_2 * -0.008185605) +
			(mosince_gong_did_first_seen * -0.002376652) +
			(gong_hist_summary_m_b2 * 0.2850619793) +
			((integer)((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)) * 0.2207252414) +
			((integer)((integer)rc_hriskphoneflag = 5) * 0.3879572713) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.6129493395) +
			((integer)((integer)rc_phonevalflag = 2) * -0.096727907) +
			((integer)((integer)rc_phonezipflag = 1) * 0.4944742328) +
			((integer)(infutor_nap >= 11) * 0.305853332),
						   hm_segment_2 = '2 Renter' => -1.969465254 +
			(time_on_gong_b3_2 * -0.00278098) +
			(mosince_gong_did_first_seen_b3_2 * -0.00749891) +
			((integer)((nap_status = 'D') or (recent_disconnects > 0)) * 0.2377783803) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.205573326) +
			((integer)((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)) * 0.0996425283),
														-3.532319608 +
			(time_on_gong_b4_2 * -0.005828681) +
			((integer)(trim(rc_name_addr_phone, ALL) = '') * -0.146151221) +
			(combo_hphnscore_summary_m_b4 * 0.1308651573) +
			(mosince_gong_did_first_seen_b4_2 * -0.002872043) +
			((integer)((nap_status = 'D') or ((recent_disconnects > 0) or ((integer)(real)rc_hriskphoneflag = 5))) * 0.3648766181) +
			((integer)(rc_hriskphoneflag in ['1', '2', '3']) * 0.2172242148) +
			((integer)((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)) * 0.3263902193));

		hi_gong_did_first_ct := map(hm_segment_2 = '0 Derog'  => (gong_did_first_ct >= 3),
									hm_segment_2 = '1 Owner'  => (gong_did_first_ct >= 3),
									hm_segment_2 = '2 Renter' => false,
																 false);

		adl_eq_last_seen2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)adl_eq_last_seen),
								 hm_segment_2 = '1 Owner'  => common.sas_date((string)adl_eq_last_seen),
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		ssndead := map(hm_segment_2 = '0 Derog'  => ((integer)rc_decsflag = 1),
					   hm_segment_2 = '1 Owner'  => ((integer)rc_decsflag = 1),
					   hm_segment_2 = '2 Renter' => false,
													false);

		adlperssn_count_5 := map(hm_segment_2 = '0 Derog'  => min(if(adlperssn_count = NULL, -NULL, adlperssn_count), 5),
								 hm_segment_2 = '1 Owner'  => NULL,
								 hm_segment_2 = '2 Renter' => NULL,
															  min(if(adlperssn_count = NULL, -NULL, adlperssn_count), 5));

		liens_fc_ind := map(hm_segment_2 = '0 Derog'  => ((boolean)liens_unrel_fc_ct or (boolean)liens_rel_fc_ct),
							hm_segment_2 = '1 Owner'  => false,
							hm_segment_2 = '2 Renter' => false,
														 false);

		add1_avm_change2 := map(hm_segment_2 = '0 Derog'  => NULL,
								hm_segment_2 = '1 Owner'  => add1_avm_change2_b2,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		dismissed_bk := map(hm_segment_2 = '0 Derog'  => (StringLib.StringToUpperCase(disposition) = 'DISMISSED'),
							hm_segment_2 = '1 Owner'  => false,
							hm_segment_2 = '2 Renter' => false,
														 false);

		address_recency2 := map(hm_segment_2 = '0 Derog'  => '',
								hm_segment_2 = '1 Owner'  => '',
								hm_segment_2 = '2 Renter' => address_recency2_b3,
															 address_recency2_b4);

		hm_aptflag := map(hm_segment_2 = '0 Derog'  => ((out_addr_type_summary_b1 = 'H') or ((add1_land_use_code_summary_b1 = 'MultiFam') or (add1_unit_count >= 5))),
						  hm_segment_2 = '1 Owner'  => ((out_addr_type_summary_b2 = 'H') or (add1_unit_count >= 5)),
						  hm_segment_2 = '2 Renter' => false,
													   false);

		eq_count_50 := map(hm_segment_2 = '0 Derog'  => NULL,
						   hm_segment_2 = '1 Owner'  => min(if(eq_count = NULL, -NULL, eq_count), 50),
						   hm_segment_2 = '2 Renter' => NULL,
														NULL);

		attr_addrs_last30_2 := map(hm_segment_2 = '0 Derog'  => NULL,
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																min(if(attr_addrs_last30 = NULL, -NULL, attr_addrs_last30), 2));

		attr_addrs_last36_7 := map(hm_segment_2 = '0 Derog'  => NULL,
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																min(if(attr_addrs_last36 = NULL, -NULL, attr_addrs_last36), 7));

		veradd_p := map(hm_segment_2 = '0 Derog'  => (nap_summary in [3, 5, 6, 8, 10, 11, 12]),
						hm_segment_2 = '1 Owner'  => (nap_summary in [3, 5, 6, 8, 10, 11, 12]),
						hm_segment_2 = '2 Renter' => (nap_summary in [3, 5, 6, 8, 10, 11, 12]),
													 false);

		attr_addrs_last24_6 := map(hm_segment_2 = '0 Derog'  => NULL,
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																min(if(attr_addrs_last24 = NULL, -NULL, attr_addrs_last24), 6));

		hi_addrs_per_adl_c6 := map(hm_segment_2 = '0 Derog'  => (addrs_per_adl_c6 >= 2),
								   hm_segment_2 = '1 Owner'  => (addrs_per_adl_c6 >= 2),
								   hm_segment_2 = '2 Renter' => (addrs_per_adl_c6 > 0),
																(addrs_per_adl_c6 > 0));

		mod_addrprob := map(hm_segment_2 = '0 Derog'  => -2.257914758 +
			((integer)((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))) * 0.2258154025) +
			((integer)rc_input_addr_not_most_recent * 0.0890973446) +
			((integer)addrs_prison_history * 0.8172329282) +
			((integer)(addrs_per_adl >= 30) * 0.3249713512) +
			((integer)(addrs_per_adl_c6 >= 2) * 0.3715956156) +
			(invalid_addrs_per_adl_c6 * 0.5477899285) +
			((integer)rc_addrmiskeyflag * 0.2712321378) +
			((integer)((combo_addrscore <= 50) or (combo_addrscore = 255)) * 0.193118463),
							hm_segment_2 = '1 Owner'  => NULL,
							hm_segment_2 = '2 Renter' => -2.951893872 +
			((integer)(addrs_per_adl <= 2) * 0.2441075121) +
			((integer)(addrs_per_adl_c6 > 0) * 0.3832428107) +
			((integer)(vo_addrs_per_adl = 0) * 0.439177912) +
			((integer)(pl_addrs_per_adl = 0) * 0.1915981038) +
			((integer)((add1_address_score < 70) or (add1_address_score = 255)) * 0.4276960437),
														 -3.071747837 +
			((integer)(add1_source_count = 0) * 0.3760676046) +
			((integer)(addrs_per_adl_c6 > 0) * 0.3598927442) +
			((integer)(vo_addrs_per_adl = 0) * 0.3184968373) +
			((integer)(pl_addrs_per_adl = 0) * 0.3215316808) +
			((integer)((add1_address_score < 70) or (add1_address_score = 255)) * 0.1297993076) +
			((integer)((boolean)(integer)rc_statezipflag or (boolean)(integer)rc_cityzipflag) * 0.3076319559));

		slim_addr_info := map(hm_segment_2 = '0 Derog'  => ((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))),
							  hm_segment_2 = '1 Owner'  => NULL,
							  hm_segment_2 = '2 Renter' => ((combo_addrcount = 0) or ((avg_lres = 0) or (addrs_per_adl = 0))),
														   NULL);

		ssninvalid := map(hm_segment_2 = '0 Derog'  => ((integer)rc_ssnvalflag = 1),
						  hm_segment_2 = '1 Owner'  => ((integer)rc_ssnvalflag = 1),
						  hm_segment_2 = '2 Renter' => NULL,
													   NULL);

		rc_numelever_gt4 := map(hm_segment_2 = '0 Derog'  => NULL,
								hm_segment_2 = '1 Owner'  => NULL,
								hm_segment_2 = '2 Renter' => (rc_numelever > 4),
															 NULL);

		add1_avm_change3 := map(hm_segment_2 = '0 Derog'  => NULL,
								hm_segment_2 = '1 Owner'  => add1_avm_change3_b2,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		verx_m := map(hm_segment_2 = '0 Derog'  => verx_m_b1,
					  hm_segment_2 = '1 Owner'  => verx_m_b2,
					  hm_segment_2 = '2 Renter' => verx_m_b3,
												   NULL);


		add1_avm_automated_val4_300k := map(hm_segment_2 = '0 Derog'  => NULL,
											hm_segment_2 = '1 Owner'  => round(min(if((add1_avm_automated_valuation_4 / 1000) = NULL, -NULL, (add1_avm_automated_valuation_4 / 1000)), 300)),
											hm_segment_2 = '2 Renter' => NULL,
																		 NULL);

		verphn_p := map(hm_segment_2 = '0 Derog'  => (nap_summary in [4, 6, 7, 9, 10, 11, 12]),
						hm_segment_2 = '1 Owner'  => (nap_summary in [4, 6, 7, 9, 10, 11, 12]),
						hm_segment_2 = '2 Renter' => (nap_summary in [4, 6, 7, 9, 10, 11, 12]),
													 (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

		pr_count_12 := map(hm_segment_2 = '0 Derog'  => NULL,
						   hm_segment_2 = '1 Owner'  => min(if(pr_count = NULL, -NULL, pr_count), 12),
						   hm_segment_2 = '2 Renter' => NULL,
														NULL);

		combo_fnamecount_6 := map(hm_segment_2 = '0 Derog'  => min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6),
								  hm_segment_2 = '1 Owner'  => NULL,
								  hm_segment_2 = '2 Renter' => min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6),
															   min(if(combo_fnamecount = NULL, -NULL, combo_fnamecount), 6));

		add1_avm_change1 := map(hm_segment_2 = '0 Derog'  => NULL,
								hm_segment_2 = '1 Owner'  => add1_avm_change1_b2,
								hm_segment_2 = '2 Renter' => NULL,
															 NULL);

		lo_combo_addrscore := map(hm_segment_2 = '0 Derog'  => ((combo_addrscore <= 50) or (combo_addrscore = 255)),
								  hm_segment_2 = '1 Owner'  => ((combo_addrscore <= 90) or (combo_addrscore = 255)),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		single_did := map(hm_segment_2 = '0 Derog'  => (did_count = 1),
						  hm_segment_2 = '1 Owner'  => (did_count = 1),
						  hm_segment_2 = '2 Renter' => (did_count = 1),
													   NULL);

		infutor_nap_ver := map(hm_segment_2 = '0 Derog'  => NULL,
							   hm_segment_2 = '1 Owner'  => (infutor_nap >= 11),
							   hm_segment_2 = '2 Renter' => (infutor_nap >= 7),
															NULL);

		phn_disconnected := map(hm_segment_2 = '0 Derog'  => ((integer)rc_hriskphoneflag = 5),
								hm_segment_2 = '1 Owner'  => ((integer)rc_hriskphoneflag = 5),
								hm_segment_2 = '2 Renter' => ((nap_status = 'D') or (recent_disconnects > 0)),
															 ((nap_status = 'D') or ((recent_disconnects > 0) or ((integer)(real)rc_hriskphoneflag = 5))));

		nas12 := map(hm_segment_2 = '0 Derog'  => (nas_summary = 12),
					 hm_segment_2 = '1 Owner'  => NULL,
					 hm_segment_2 = '2 Renter' => (nas_summary = 12),
												  NULL);

		impulse_count_2 := map(hm_segment_2 = '0 Derog'  => impulse_count_2_b1,
							   hm_segment_2 = '1 Owner'  => NULL,
							   hm_segment_2 = '2 Renter' => NULL,
															NULL);

		lres0 := map(hm_segment_2 = '0 Derog'  => (avg_lres = 0),
					 hm_segment_2 = '1 Owner'  => NULL,
					 hm_segment_2 = '2 Renter' => (avg_lres = 0),
												  NULL);

		adl_eq_first_seen2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)adl_eq_first_seen),
								  hm_segment_2 = '1 Owner'  => common.sas_date((string)adl_eq_first_seen),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		no_addrs_per_adl := map(hm_segment_2 = '0 Derog'  => (addrs_per_adl = 0),
								hm_segment_2 = '1 Owner'  => NULL,
								hm_segment_2 = '2 Renter' => (addrs_per_adl = 0),
															 NULL);

		gong_did_last_seen2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)gong_did_last_seen),
								   hm_segment_2 = '1 Owner'  => common.sas_date((string)gong_did_last_seen),
								   hm_segment_2 = '2 Renter' => common.sas_date((string)gong_did_last_seen),
																common.sas_date((string)gong_did_last_seen));

		liens_lt_ind := map(hm_segment_2 = '0 Derog'  => ((boolean)liens_unrel_lt_ct or (boolean)liens_rel_lt_ct),
							hm_segment_2 = '1 Owner'  => NULL,
							hm_segment_2 = '2 Renter' => NULL,
														 NULL);



		phone_zip_mismatch := map(hm_segment_2 = '0 Derog'  => ((integer)rc_phonezipflag = 1),
								  hm_segment_2 = '1 Owner'  => ((integer)rc_phonezipflag = 1),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		prop1_distressed_sale := map(hm_segment_2 = '0 Derog'  => ((NULL < (real)prop1_sale_index2_b1) AND (prop1_sale_index2_b1 < -50)),
									 hm_segment_2 = '1 Owner'  => ((NULL < (real)prop1_sale_index2_b2) AND (prop1_sale_index2_b2 < -50)),
									 hm_segment_2 = '2 Renter' => NULL,
																  NULL);

		add1_naprop_summary_m := map(hm_segment_2 = '0 Derog'  => add1_naprop_summary_m_b1,
									 hm_segment_2 = '1 Owner'  => add1_naprop_summary_m_b2,
									 hm_segment_2 = '2 Renter' => NULL,
																  NULL);

		yrsince_rc_ssnlowissue_le15 := (yrsince_rc_ssnlowissue <=15);

		criminal_last_date2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)criminal_last_date),
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																NULL);

		time_on_eq := map(hm_segment_2 = '0 Derog'  => time_on_eq_b1_2,
						  hm_segment_2 = '1 Owner'  => time_on_eq_b2_2,
						  hm_segment_2 = '2 Renter' => NULL,
													   NULL);

		did_ver := map(hm_segment_2 = '0 Derog'  => NULL,
					   hm_segment_2 = '1 Owner'  => did_ver_b2,
					   hm_segment_2 = '2 Renter' => NULL,
													NULL);

		watercraft_aircraft_ind := map(hm_segment_2 = '0 Derog'  => ((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)),
									   hm_segment_2 = '1 Owner'  => NULL,
									   hm_segment_2 = '2 Renter' => ((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0)),
																	NULL);

		attr_addrs_last90_2 := map(hm_segment_2 = '0 Derog'  => NULL,
								   hm_segment_2 = '1 Owner'  => NULL,
								   hm_segment_2 = '2 Renter' => NULL,
																min(if(attr_addrs_last90 = NULL, -NULL, attr_addrs_last90), 2));


		ssnprob_hm := map(hm_segment_2 = '0 Derog'  => ((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))),
						  hm_segment_2 = '1 Owner'  => ((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))),
						  hm_segment_2 = '2 Renter' => NULL,
													   NULL);


		mod_ssnprob := map(hm_segment_2 = '0 Derog'  => -2.77543471 +
			(ssns_per_adl_summary_m_b1 * 0.0828306608) +
			((integer)(ssns_per_adl_c6 >= 2) * 0.3956289204) +
			((integer)((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))) * -0.267185838),
						   hm_segment_2 = '1 Owner'  => -2.824191238 +
			(ssns_per_adl_summary_m_b2 * 0.0699661692) +
			((integer)(ssns_per_adl_c6 >= 2) * 0.3814382102) +
			((integer)((combo_ssncount = 0) or (((integer)rc_decsflag = 1) or (((integer)rc_ssndobflag = 1) or (((integer)rc_ssnvalflag = 1) or (((combo_ssnscore < 80) or (combo_ssnscore = 255)) or ((integer)inputssncharflag = 0)))))) * -0.777577261) +
			((integer)(invalid_ssns_per_adl > 0) * 0.3177013544),
						   hm_segment_2 = '2 Renter' => NULL,
														-3.906329158 +
			(ssns_per_adl_summary_m_b4 * 0.091856886) +
			(adlperssn_count_summary_m_b4 * 0.0992898188) +
			(inputssncharflag_val * -0.20740256) +
			((integer)(ssns_per_adl_c6 >= 1) * 0.2423230646));

		out_addr_type_summary := map(hm_segment_2 = '0 Derog'  => out_addr_type_summary_b1,
									 hm_segment_2 = '1 Owner'  => out_addr_type_summary_b2,
									 hm_segment_2 = '2 Renter' => '',
																  '');

		add1_avm_change3_2 := map(hm_segment_2 = '0 Derog'  => NULL,
								  hm_segment_2 = '1 Owner'  => min(if(add1_avm_change3_b2 = NULL, -NULL, add1_avm_change3_b2), 2),
								  hm_segment_2 = '2 Renter' => NULL,
															   NULL);

		prof_license_category_m := map(hm_segment_2 = '0 Derog'  => NULL,
									   hm_segment_2 = '1 Owner'  => NULL,
									   hm_segment_2 = '2 Renter' => NULL,
																	prof_license_category_m_b4);

		liens_sc_ind := map(hm_segment_2 = '0 Derog'  => ((boolean)liens_unrel_sc_ct or (boolean)liens_rel_sc_ct),
							hm_segment_2 = '1 Owner'  => false,
							hm_segment_2 = '2 Renter' => false,
														 false);

		miss_rc_name_addr_phone := map(hm_segment_2 = '0 Derog'  => false,
									   hm_segment_2 = '1 Owner'  => false,
									   hm_segment_2 = '2 Renter' => false,
																	(trim(rc_name_addr_phone, ALL) = ''));

		add1_avm_index_summary_m := map(hm_segment_2 = '0 Derog'  => NULL,
										hm_segment_2 = '1 Owner'  => add1_avm_index_summary_m_b2,
										hm_segment_2 = '2 Renter' => NULL,
																	 NULL);

		ssns_per_adl_summary_m := map(hm_segment_2 = '0 Derog'  => ssns_per_adl_summary_m_b1,
									  hm_segment_2 = '1 Owner'  => ssns_per_adl_summary_m_b2,
									  hm_segment_2 = '2 Renter' => ssns_per_adl_summary_m_b3,
																   ssns_per_adl_summary_m_b4);

		ver_phncount := map(hm_segment_2 = '0 Derog'  => if(max((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12])) = NULL, NULL, sum((integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]), (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]), (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]), (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]))),
							hm_segment_2 = '1 Owner'  => NULL,
							hm_segment_2 = '2 Renter' => NULL,
														 NULL);

		ver_nas479 := map(hm_segment_2 = '0 Derog'  => false,
						  hm_segment_2 = '1 Owner'  => false,
						  hm_segment_2 = '2 Renter' => (nas_summary in [4, 7, 9]),
													   (nas_summary in [4, 7, 9]));

		no_addr_sources := map(hm_segment_2 = '0 Derog'  => (combo_addrcount = 0),
							   hm_segment_2 = '1 Owner'  => false,
							   hm_segment_2 = '2 Renter' => (combo_addrcount = 0),
															false);

		liens_cj_ind := map(hm_segment_2 = '0 Derog'  => ((boolean)liens_unrel_cj_ct or (boolean)liens_rel_cj_ct),
							hm_segment_2 = '1 Owner'  => false,
							hm_segment_2 = '2 Renter' => false,
														 false);

		combo_lnamecount_6 := map(hm_segment_2 = '0 Derog'  => NULL,
								  hm_segment_2 = '1 Owner'  => min(if(combo_lnamecount = NULL, -NULL, combo_lnamecount), 6),
								  hm_segment_2 = '2 Renter' => NULL,
															   min(if(combo_lnamecount = NULL, -NULL, combo_lnamecount), 6));

		lo_combo_hphonescore := map(hm_segment_2 = '0 Derog'  => ((combo_hphonescore <= 80) or (combo_hphonescore = 255)),
									hm_segment_2 = '1 Owner'  => false,
									hm_segment_2 = '2 Renter' => false,
																 false);

		addrs_5yr_10 := map(hm_segment_2 = '0 Derog'  => NULL,
							hm_segment_2 = '1 Owner'  => NULL,
							hm_segment_2 = '2 Renter' => NULL,
														 min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 10));

		add1_hr_mortgage_type := map(hm_segment_2 = '0 Derog'  => (add1_mortgage_type in ['C', 'CNS', 'H']),
									 hm_segment_2 = '1 Owner'  => (add1_mortgage_type in ['2', 'G', 'H', 'R']),
									 hm_segment_2 = '2 Renter' => (add1_mortgage_type in ['2', 'G', 'H', 'R']),
																  (add1_mortgage_type in ['2', 'G', 'H']));

		address_recency := map(hm_segment_2 = '0 Derog'  => '',
							   hm_segment_2 = '1 Owner'  => '',
							   hm_segment_2 = '2 Renter' => address_recency_b3,
															address_recency_b4);

		combo_addrcount_5 := map(hm_segment_2 = '0 Derog'  => min(if(combo_addrcount = NULL, -NULL, combo_addrcount), 5),
								 hm_segment_2 = '1 Owner'  => NULL,
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		lo_rc_dirsaddr_lastscore := map(hm_segment_2 = '0 Derog'  => ((rc_dirsaddr_lastscore <= 50) or (rc_dirsaddr_lastscore = 255)),
										hm_segment_2 = '1 Owner'  => ((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)),
										hm_segment_2 = '2 Renter' => ((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)),
																	 ((rc_dirsaddr_lastscore <= 60) or (rc_dirsaddr_lastscore = 255)));


		lo_add1_address_score := map(hm_segment_2 = '0 Derog'  => false,
									 hm_segment_2 = '1 Owner'  => false,
									 hm_segment_2 = '2 Renter' => ((add1_address_score < 70) or (add1_address_score = 255)),
																  ((add1_address_score < 70) or (add1_address_score = 255)));

		add1_avm_automated_val_300k := map(hm_segment_2 = '0 Derog'  => NULL,
										   hm_segment_2 = '1 Owner'  => round(min(if((add1_avm_automated_valuation / 1000) = NULL, -NULL, (add1_avm_automated_valuation / 1000)), 300)),
										   hm_segment_2 = '2 Renter' => NULL,
																		NULL);

		pred_inc_8_200k := map(hm_segment_2 = '0 Derog'  => NULL,
							   hm_segment_2 = '1 Owner'  => NULL,
							   hm_segment_2 = '2 Renter' => max(min(if(round((pred_inc / 1000)) = NULL, -NULL, round((pred_inc / 1000))), 200), 8),
															NULL);

		prop1_sale_index2 := map(hm_segment_2 = '0 Derog'  => prop1_sale_index2_b1,
								 hm_segment_2 = '1 Owner'  => prop1_sale_index2_b2,
								 hm_segment_2 = '2 Renter' => NULL,
															  NULL);

		verfst_p := map(hm_segment_2 = '0 Derog'  => (nap_summary in [2, 3, 4, 8, 9, 10, 12]),
						hm_segment_2 = '1 Owner'  => false,
						hm_segment_2 = '2 Renter' => false,
													 (nap_summary in [2, 3, 4, 8, 9, 10, 12]));


		mod_prob := map(
			hm_segment_2 = '0 Derog' and dobpop => 2.8649560095
			                  + mod_phnprob  * 0.8663826233
			                  + (integer)yrs_at_lowissue_ge30  * 0.3587640927
			                  + (integer)yrsince_rc_ssnlowissue_le10  * 0.2998333678
			                  + mod_ssnprob  * 0.8397712986
			                  + mod_addrprob  * 0.6274237104,
			hm_segment_2 = '0 Derog' => 2.9142428069
			                  + mod_phnprob  * 0.8664422082
			                  + (integer)yrsince_rc_ssnlowissue_le10  * 0.2676771407
			                  + mod_ssnprob  * 0.8574425429
			                  + mod_addrprob  * 0.6294883247,
			hm_segment_2 = '1 Owner' => 1.2156885702
		                  + mod_phnprob  * 0.8880563687
		                  + (integer)yrsince_rc_ssnlowissue_le15  * 0.5689066393
		                  + mod_ssnprob  * 0.5941446359
		                  + (integer)rc_input_addr_not_most_recent  * 0.2440238766
		                  + (integer)hi_addrs_per_adl_c6  * 0.4091220732
		                  + lo_combo_addrscore  * 0.2914577025,
			NULL
		);


		prof_license_category2 := map(hm_segment_2 = '0 Derog'  => prof_license_category2_b1,
									  hm_segment_2 = '1 Owner'  => prof_license_category2_b2,
									  hm_segment_2 = '2 Renter' => NULL,
																   NULL);

		in_dob2 := map(hm_segment_2 = '0 Derog'  => common.sas_date((string)in_dob),
					   hm_segment_2 = '1 Owner'  => NULL,
					   hm_segment_2 = '2 Renter' => NULL,
													NULL);

		add1_avm_change3_nomiss := map(hm_segment_2 = '0 Derog'  => NULL,
									   hm_segment_2 = '1 Owner'  => add1_avm_change3_nomiss_b2,
									   hm_segment_2 = '2 Renter' => NULL,
																	NULL);

		gong_hist_summary_m := map(hm_segment_2 = '0 Derog'  => gong_hist_summary_m_b1,
								   hm_segment_2 = '1 Owner'  => gong_hist_summary_m_b2,
								   hm_segment_2 = '2 Renter' => NULL,
																NULL);

		hi_ssns_per_adl_c6 := map(hm_segment_2 = '0 Derog'  => (ssns_per_adl_c6 >= 2),
								  hm_segment_2 = '1 Owner'  => (ssns_per_adl_c6 >= 2),
								  hm_segment_2 = '2 Renter' => false,
															   (ssns_per_adl_c6 >= 1));

		no_pl_addrs_per_adl := map(hm_segment_2 = '0 Derog'  => false,
								   hm_segment_2 = '1 Owner'  => false,
								   hm_segment_2 = '2 Renter' => (pl_addrs_per_adl = 0),
																(pl_addrs_per_adl = 0));

		no_add1_sources := map(hm_segment_2 = '0 Derog'  => false,
							   hm_segment_2 = '1 Owner'  => false,
							   hm_segment_2 = '2 Renter' => false,
															(add1_source_count = 0));

		core_adl := map(hm_segment_2 = '0 Derog'  => ((adl_category)[1..1] = '8'),
						hm_segment_2 = '1 Owner'  => false,
						hm_segment_2 = '2 Renter' => false,
													 false);

		addr_type_summary := map(hm_segment_2 = '0 Derog'  => addr_type_summary_b1,
								 hm_segment_2 = '1 Owner'  => addr_type_summary_b2,
								 hm_segment_2 = '2 Renter' => '',
															  '');

		invalid_ssns_per_adl_ind := map(hm_segment_2 = '0 Derog'  => (invalid_ssns_per_adl > 0),
										hm_segment_2 = '1 Owner'  => (invalid_ssns_per_adl > 0),
										hm_segment_2 = '2 Renter' => false,
																	 false);


		add1_land_use_code_summary := map(hm_segment_2 = '0 Derog'  => add1_land_use_code_summary_b1,
										  hm_segment_2 = '1 Owner'  => add1_land_use_code_summary_b2,
										  hm_segment_2 = '2 Renter' => '',
																	   '');


		outest := case( hm_segment_2,
			'0 Derog' => if(dobpop,
				-1.171285635
					+ mod_ver  * 0.7887739116
					+ mod_prob  * 0.3128235718
					+ address_recency_m  * 0.027555765
					+ addrs_10yr_15  * 0.0277139855
					+ mod_derog  * 0.7993689191
					+ prof_license_category2  * 0.0799482219
					+ addr_stability2  * 0.0550552232
					+ ams_college_tier_summary_m  * 0.1225338833
					+ (integer)hi_yrs_when_ln_first_seen  * 0.5446069497
					+ watercraft_aircraft_ind  * 0.1624979237,
				-1.119976911
					+ mod_ver  * 0.8067921714
					+ mod_prob  * 0.2932740076
					+ watercraft_aircraft_ind  * 0.1686488265
					+ address_recency_m  * 0.0266107871
					+ addrs_10yr_15  * 0.0270078765
					+ mod_derog  * 0.7825824233
					+ prof_license_category2  * 0.0771696395
					+ addr_stability2  * 0.0544587166
					+ ams_college_tier_summary_m  * 0.1257359617
					+ time_on_eq  * -0.004211154
			 ),
			 '1 Owner' =>
				-0.278572513
					+ mod_ver  * 0.2684046906
					+ mod_prob  * 0.5203028179
					+ mod_prop  * 0.4563001671
					+ (integer)impulse_ind  * 1.0025774003
					+ ams_college_tier_summary_m  * 0.2723901925
					+ log10_pred_inc  * -0.504486403
					+ addr_stability2_m  * 0.0758118361
					+ prof_license_category2  * 0.1636901491
					+ most_recent_purchase_m  * 0.0775048358
					+ time_on_eq  * -0.023365141
					+ EQ_count_50  * 0.0061470762
					+ PR_count_12  * 0.0314835727,
			'2 Renter' => if( dobpop,
				-2.480680083
					+ mod_ver  * 0.5808355572
					+ mod_phnprob  * 0.3961257181
					+ mod_addrprob  * 0.4722410927
					+ slim_addr_info  * -0.116115154
					+ ssns_per_adl_summary_m  * 0.0923210686
					+ address_recency2_m  * 0.0366761278
					+ add1_financing_type_m  * 0.0711144784
					+ (integer)impulse_ind  * 0.7769659368
					+ ams_college_tier_summary_m  * 0.0941149478
					+ addr_stability2_m  * 0.0443309899
					+ (integer)hi_lo_eq_count  * -0.617273793
					+ watercraft_aircraft_ind  * -0.558524162,
				-1.90311519
					+ mod_ver  * 0.5292095853
					+ mod_phnprob  * 0.4057068039
					+ mod_addrprob  * 0.4016965136
					+ address_recency2_m  * 0.0452416165
					+ add1_financing_type_m  * 0.0745278958
					+ (integer)impulse_ind  * 0.7857661528
					+ ams_college_tier_summary_m  * 0.0981154504
					+ hi_pred_income  * -0.350953903
					+ addr_stability2_m  * 0.0363304947
					+ watercraft_aircraft_ind  * -0.568396766
			),
			-1.869701404
				+ mod_ver  * 0.5173471132
				+ mod_addrprob  * 0.2149182351
				+ mod_phnprob  * 0.397242091
				+ mod_ssnprob  * 0.4494459568
				+ (integer)add1_hr_mortgage_type  * 0.3410934197
				+ address_recency2_m  * 0.03679263
				+ (integer)impulse_ind  * 0.7712064998
				+ prof_license_category_m  * 0.1139458987
				+ addr_stability2_m  * 0.0557261166
				+ ams_college_income_summary_m  * 0.1473949557
		);


		phat := (exp(outest) / (1 + exp(outest)));

		score := round(((-40 * ((ln((phat / (1 - phat))) - ln((1 / 20))) / ln(2))) + 700));

		rva1003_0_0 := min(900, if(max(501, score) = NULL, -NULL, max(501, score)));

		ov_ssndead := (((integer)ssnlength > 0) and ((integer)rc_decsflag = 1));

		ov_ssnprior := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

		ov_criminal_flag := (criminal_count > 0);

		ov_corrections := ((integer)rc_hrisksic = 2225);

		ov_impulse := (impulse_count > 0);

		rva1003_0_0_2 :=  if((rva1003_0_0 > 680) and (ov_ssndead or (ov_ssnprior or (ov_criminal_flag or (ov_corrections or ov_impulse)))), 680, rva1003_0_0);

		scored_222s := ( sum(property_owned_total,property_sold_total)>0 OR
									 combo_dobscore between 90 and 100 or
									 (integer)input_dob_match_level >= 7 or
									 lien_flag or
									 criminal_count > 0 or
									 bk_flag or
									 ssn_deceased or
									 truedid
									 );

		rva1003_0_0_3 := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, rva1003_0_0_2 );


		#if(RVA_DEBUG)
			self.truedid := truedid;
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
			self.rc_name_addr_phone := rc_name_addr_phone;
			self.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_numelever := rc_numelever;
			self.rc_addrmiskeyflag := rc_addrmiskeyflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_statezipflag := rc_statezipflag;
			self.rc_cityzipflag := rc_cityzipflag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_addrscore := combo_addrscore;
			self.combo_hphonescore := combo_hphonescore;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_lnamecount := combo_lnamecount;
			self.combo_addrcount := combo_addrcount;
			self.combo_ssncount := combo_ssncount;
			self.combo_dobcount := combo_dobcount;
			self.eq_count := eq_count;
			self.pr_count := pr_count;
			self.adl_eq_first_seen := adl_eq_first_seen;
			self.adl_eq_last_seen := adl_eq_last_seen;
			self.ssnlength := ssnlength;
			self.dobpop := dobpop;
			self.lname_eda_sourced := lname_eda_sourced;
			self.age := age;
			self.add1_address_score := add1_address_score;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_unit_count := add1_unit_count;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_automated_valuation_3 := add1_avm_automated_valuation_3;
			self.add1_avm_automated_valuation_4 := add1_avm_automated_valuation_4;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_source_count := add1_source_count;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_land_use_code := add1_land_use_code;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.prop1_sale_price := prop1_sale_price;
			self.prop1_prev_purchase_price := prop1_prev_purchase_price;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.avg_lres := avg_lres;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.addrs_prison_history := addrs_prison_history;
			self.recent_disconnects := recent_disconnects;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_last_seen := gong_did_last_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_addr_ct := gong_did_addr_ct;
			self.gong_did_first_ct := gong_did_first_ct;
			self.credit_first_seen := credit_first_seen;
			self.header_first_seen := header_first_seen;
			self.inputssncharflag := inputssncharflag;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.pl_addrs_per_adl := pl_addrs_per_adl;
			self.invalid_ssns_per_adl := invalid_ssns_per_adl;
			self.invalid_addrs_per_adl_c6 := invalid_addrs_per_adl_c6;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_addrs_last30 := attr_addrs_last30;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_date_first_purchase := attr_date_first_purchase;
			self.attr_num_purchase30 := attr_num_purchase30;
			self.attr_num_purchase90 := attr_num_purchase90;
			self.attr_num_purchase180 := attr_num_purchase180;
			self.attr_num_purchase12 := attr_num_purchase12;
			self.attr_num_purchase24 := attr_num_purchase24;
			self.attr_num_purchase36 := attr_num_purchase36;
			self.attr_num_purchase60 := attr_num_purchase60;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.attr_num_aircraft := attr_num_aircraft;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_recent_count := bk_disposed_recent_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_recent_released_count := liens_recent_released_count;
			self.liens_historical_released_count := liens_historical_released_count;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_rel_cj_ct := liens_rel_cj_ct;
			self.liens_unrel_fc_ct := liens_unrel_fc_ct;
			self.liens_rel_fc_ct := liens_rel_fc_ct;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_rel_lt_ct := liens_rel_lt_ct;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.liens_rel_sc_ct := liens_rel_sc_ct;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_count := felony_count;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.addr_stability := addr_stability;
			self.archive_date := archive_date;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_P := source_tot_P;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_W := source_tot_W;
			self.add_apt := add_apt;
			self.bk_flag := bk_flag;
			self.pk_bk_level := pk_bk_level;
			self.add1_avm_med := add1_avm_med;
			self.rc_valid_bus_phone := rc_valid_bus_phone;
			self.rc_valid_res_phone := rc_valid_res_phone;
			self.age_rcd := age_rcd;
			self.add1_mortgage_type_ord := add1_mortgage_type_ord;
			self.prof_license_category_ord := prof_license_category_ord;
			self.pk_attr_total_number_derogs := pk_attr_total_number_derogs;
			self.pk_attr_total_number_derogs_2 := pk_attr_total_number_derogs_2;
			self.pk_attr_num_nonderogs90 := pk_attr_num_nonderogs90;
			self.pk_attr_num_nonderogs90_2 := pk_attr_num_nonderogs90_2;
			self.pk_derog_total := pk_derog_total;
			self.pk_derog_total_m := pk_derog_total_m;
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
			self.add1_avm_automated_val_2_rcd := add1_avm_automated_val_2_rcd;
			self.pk_liens_unrel_ot_total_amount := pk_liens_unrel_ot_total_amount;
			self.attr_num_watercraft60_cap := attr_num_watercraft60_cap;
			self.combo_addrcount_cap := combo_addrcount_cap;
			self.gong_did_phone_ct_cap := gong_did_phone_ct_cap;
			self.ams_college_code_mis := ams_college_code_mis;
			self.ams_college_code_cm := ams_college_code_cm;
			self.ams_income_level_code_cm := ams_income_level_code_cm;
			self.unit5 := unit5;
			self.pk_dist_a1toa2 := pk_dist_a1toa2;
			self.pk_dist_a1toa3 := pk_dist_a1toa3;
			self.pk_dist_a2toa3 := pk_dist_a2toa3;
			self.pk_rc_disthphoneaddr := pk_rc_disthphoneaddr;
			self.pk_dist_a1toa2_m := pk_dist_a1toa2_m;
			self.pk_dist_a1toa3_m := pk_dist_a1toa3_m;
			self.pk_dist_a2toa3_m := pk_dist_a2toa3_m;
			self.pk_rc_disthphoneaddr_m := pk_rc_disthphoneaddr_m;
			self.Dist_mod := Dist_mod;
			self.sysdate := sysdate;
			self.date_last_seen2 := date_last_seen2;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.adl_category_ord := adl_category_ord;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.pred_inc := pred_inc;
			self.today := today;
			self.add1_land_use_code_2byte := add1_land_use_code_2byte;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.lien_flag := lien_flag;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_BA_2 := source_tot_BA_2;
			self.bk_flag_2 := bk_flag_2;
			self.ssn_deceased := ssn_deceased;
			self.pk_impulse_count := pk_impulse_count;
			self.pk_impulse_count_2 := pk_impulse_count_2;
			self.pk_adl_cat_deceased := pk_adl_cat_deceased;
			self.bs_own_rent := bs_own_rent;
			self.bs_attr_derog_flag := bs_attr_derog_flag;
			self.bs_attr_eviction_flag := bs_attr_eviction_flag;
			self.bs_attr_derog_flag2 := bs_attr_derog_flag2;
			self.hm_segment := hm_segment;
			self.hm_segment_2 := hm_segment_2;
			self.did_ver_m_b1 := did_ver_m_b1;
			self.did_ver_nodob_m_b1 := did_ver_nodob_m_b1;
			self.verx_m_b1 := verx_m_b1;
			self.mod_ver_b1 := mod_ver_b1;
			self.gong_hist_summary_m_b1 := gong_hist_summary_m_b1;
			self.time_on_gong_b1 := time_on_gong_b1;
			self.time_on_gong_b1_2 := time_on_gong_b1_2;
			self.in_dob2_b1 := in_dob2_b1;
			self.ssns_per_adl_summary_b1 := ssns_per_adl_summary_b1;
			self.ssns_per_adl_summary_b1_2 := ssns_per_adl_summary_b1_2;
			self.ssns_per_adl_summary_m_b1 := ssns_per_adl_summary_m_b1;
			self.mod_prob_b1 := mod_prob_b1;
			self.prop1_sale_index_b1 := prop1_sale_index_b1;
			self.prop1_sale_index2_b1 := prop1_sale_index2_b1;
			self.address_recency_m_b1 := address_recency_m_b1;
			self.out_addr_type_summary_b1 := out_addr_type_summary_b1;
			self.add1_land_use_code_summary_b1 := add1_land_use_code_summary_b1;
			self.addr_type_summary_b1 := addr_type_summary_b1;
			self.addr_type_summary_m_b1 := addr_type_summary_m_b1;
			self.add1_financing_type_m_b1 := add1_financing_type_m_b1;
			self.add1_naprop_summary_m_b1 := add1_naprop_summary_m_b1;
			self.mosince_criminal_last_date_84_b1 := mosince_criminal_last_date_84_b1;
			self.impulse_count_2_b1 := impulse_count_2_b1;
			self.ams_college_tier_summary_b1 := ams_college_tier_summary_b1;
			self.ams_college_tier_summary_m_b1 := ams_college_tier_summary_m_b1;
			self.prof_license_category2_b1 := prof_license_category2_b1;
			self.addr_stability2_b1 := addr_stability2_b1;
			self.in_dob2_b1_2 := in_dob2_b1_2;
			self.time_on_eq_b1 := time_on_eq_b1;
			self.time_on_eq_b1_2 := time_on_eq_b1_2;
			self.outest_b1 := outest_b1;
			self.did_ver_b2 := did_ver_b2;
			self.did_ver_nodob_m_b2 := did_ver_nodob_m_b2;
			self.verx_m_b2 := verx_m_b2;
			self.mod_ver_b2 := mod_ver_b2;
			self.gong_hist_summary_m_b2 := gong_hist_summary_m_b2;
			self.gong_did_first_seen2_b2 := gong_did_first_seen2_b2;
			self.time_on_gong_b2 := time_on_gong_b2;
			self.time_on_gong_b2_2 := time_on_gong_b2_2;
			self.mosince_gong_did_first_seen_b2 := mosince_gong_did_first_seen_b2;
			self.mosince_gong_did_first_seen_b2_2 := -987654321;
			self.ssns_per_adl_summary_b2 := ssns_per_adl_summary_b2;
			self.ssns_per_adl_summary_b2_2 := ssns_per_adl_summary_b2_2;
			self.ssns_per_adl_summary_m_b2 := ssns_per_adl_summary_m_b2;
			self.prop1_sale_index_b2 := prop1_sale_index_b2;
			self.prop1_sale_index2_b2 := prop1_sale_index2_b2;
			self.out_addr_type_summary_b2 := out_addr_type_summary_b2;
			self.add1_land_use_code_summary_b2 := add1_land_use_code_summary_b2;
			self.addr_type_summary_b2 := addr_type_summary_b2;
			self.addr_type_summary_m_b2 := addr_type_summary_m_b2;
			self.add1_avm_change1_b2 := add1_avm_change1_b2;
			self.add1_avm_change2_b2 := add1_avm_change2_b2;
			self.add1_avm_change3_b2 := add1_avm_change3_b2;
			self.add1_avm_change1_nomiss_b2 := add1_avm_change1_nomiss_b2;
			self.add1_avm_change2_nomiss_b2 := add1_avm_change2_nomiss_b2;
			self.add1_avm_change3_nomiss_b2 := add1_avm_change3_nomiss_b2;
			self.add1_avm_index_b2 := add1_avm_index_b2;
			self.add1_avm_index_b2_2 := add1_avm_index_b2_2;
			self.add1_avm_index_summary_m_b2 := add1_avm_index_summary_m_b2;
			self.add1_financing_type_m_b2 := add1_financing_type_m_b2;
			self.add1_ownership_m_b2 := add1_ownership_m_b2;
			self.add1_naprop_summary_m_b2 := add1_naprop_summary_m_b2;
			self.ams_college_tier_summary_b2 := ams_college_tier_summary_b2;
			self.ams_college_tier_summary_m_b2 := ams_college_tier_summary_m_b2;
			self.prof_license_category2_b2 := prof_license_category2_b2;
			self.addr_stability2_b2 := addr_stability2_b2;
			self.addr_stability2_m_b2 := addr_stability2_m_b2;
			self.most_recent_purchase_b2 := most_recent_purchase_b2;
			self.most_recent_purchase_m_b2 := most_recent_purchase_m_b2;
			self.time_on_eq_b2 := time_on_eq_b2;
			self.time_on_eq_b2_2 := time_on_eq_b2_2;
			self.did_ver_m_b3 := did_ver_m_b3;
			self.did_ver_nodob_m_b3 := did_ver_nodob_m_b3;
			self.verx_m_b3 := verx_m_b3;
			self.mod_ver_b3 := mod_ver_b3;
			self.gong_did_first_seen2_b3 := gong_did_first_seen2_b3;
			self.time_on_gong_b3 := time_on_gong_b3;
			self.time_on_gong_b3_2 := time_on_gong_b3_2;
			self.mosince_gong_did_first_seen_b3 := mosince_gong_did_first_seen_b3;
			self.mosince_gong_did_first_seen_b3_2 := mosince_gong_did_first_seen_b3_2;
			self.ssns_per_adl_summary_b3 := ssns_per_adl_summary_b3;
			self.ssns_per_adl_summary_b3_2 := ssns_per_adl_summary_b3_2;
			self.ssns_per_adl_summary_m_b3 := ssns_per_adl_summary_m_b3;
			self.address_recency_b3 := address_recency_b3;
			self.address_recency2_b3 := address_recency2_b3;
			self.address_recency2_m_b3 := address_recency2_m_b3;
			self.add1_financing_type_m_b3 := add1_financing_type_m_b3;
			self.ams_college_tier_summary_b3 := ams_college_tier_summary_b3;
			self.ams_college_tier_summary_m_b3 := ams_college_tier_summary_m_b3;
			self.addr_stability2_b3 := addr_stability2_b3;
			self.addr_stability2_m_b3 := addr_stability2_m_b3;
			self.outest_b3 := outest_b3;
			self.mod_ver_b4 := mod_ver_b4;
			self.combo_hphnscore_summary_m_b4 := combo_hphnscore_summary_m_b4;
			self.gong_did_first_seen2_b4 := gong_did_first_seen2_b4;
			self.time_on_gong_b4 := time_on_gong_b4;
			self.time_on_gong_b4_2 := time_on_gong_b4_2;
			self.mosince_gong_did_first_seen_b4 := mosince_gong_did_first_seen_b4;
			self.mosince_gong_did_first_seen_b4_2 := mosince_gong_did_first_seen_b4_2;
			self.ssns_per_adl_summary_b4 := ssns_per_adl_summary_b4;
			self.ssns_per_adl_summary_b4_2 := ssns_per_adl_summary_b4_2;
			self.ssns_per_adl_summary_m_b4 := ssns_per_adl_summary_m_b4;
			self.adlperssn_count_summary_b4 := adlperssn_count_summary_b4;
			self.adlperssn_count_summary_m_b4 := adlperssn_count_summary_m_b4;
			self.address_recency_b4 := address_recency_b4;
			self.address_recency2_b4 := address_recency2_b4;
			self.address_recency2_m_b4 := address_recency2_m_b4;
			self.prof_license_category_m_b4 := prof_license_category_m_b4;
			self.addr_stability2_b4 := addr_stability2_b4;
			self.addr_stability2_m_b4 := addr_stability2_m_b4;
			self.ams_income_level_summary_b4 := ams_income_level_summary_b4;
			self.ams_college_code_summary_b4 := ams_college_code_summary_b4;
			self.ams_college_income_summary_m_b4 := ams_college_income_summary_m_b4;
			self.combo_dobcount_5 := combo_dobcount_5;
			self.cell_pager_pcs := cell_pager_pcs;
			self.contrary_ssn := contrary_ssn;
			self.residential_phone := residential_phone;
			self.ams_college_tier_summary := ams_college_tier_summary;
			self.attr_addrs_last12_4 := attr_addrs_last12_4;
			self.criminal_count_7 := criminal_count_7;
			self.ssns_per_adl_summary := ssns_per_adl_summary;
			self.hi_pred_income := hi_pred_income;
			self.addr_stability2 := addr_stability2;
			self.rc_ssnlowissue2 := rc_ssnlowissue2;
			self.verlst_p := verlst_p;
			self.add1_avm_index := add1_avm_index;
			self.outest := outest;
			self.hi_combo_ssncount := hi_combo_ssncount;
			self.add1_avm_change1_2 := add1_avm_change1_2;
			self.did_ver_m := did_ver_m;
			self.add1_avm_automated_val2_300k := add1_avm_automated_val2_300k;
			self.mod_derog := mod_derog;
			self.add1_unit_count_5 := add1_unit_count_5;
			self.ams_college_tier_summary_m := ams_college_tier_summary_m;
			self.add1_avm_change1_nomiss := add1_avm_change1_nomiss;
			self.liens_recent_released_ind := liens_recent_released_ind;
			self.ams_college_code_summary := ams_college_code_summary;
			self.adlperssn_count_summary := adlperssn_count_summary;
			self.log10_pred_inc := log10_pred_inc;
			self.mod_ver := mod_ver;
			self.bad_bk := bad_bk;
			self.addr_stability2_m := addr_stability2_m;
			self.hi_addrs_per_adl := hi_addrs_per_adl;
			self.liens_released_ind := liens_released_ind;
			self.invalid_addrs_per_adl_c6_ind := invalid_addrs_per_adl_c6_ind;
			self.yrsince_rc_ssnlowissue_le10 := yrsince_rc_ssnlowissue_le10;
			self.address_recency_m := address_recency_m;
			self.addrs_10yr_15 := addrs_10yr_15;
			self.hi_gong_did_addr_ct := hi_gong_did_addr_ct;
			self.liens_recent_unreleased_count_6 := liens_recent_unreleased_count_6;
			self.add1_avm_change2_nomiss := add1_avm_change2_nomiss;
			self.zip_mismatch := zip_mismatch;
			self.hi_yrs_when_ln_first_seen := hi_yrs_when_ln_first_seen;
			self.addrs_15yr_20 := addrs_15yr_20;
			self.did_ver_nodob_m := did_ver_nodob_m;
			self.most_recent_purchase_m := most_recent_purchase_m;
			self.yrs_at_lowissue := yrs_at_lowissue;
			self.hi_gong_did_phone_ct := hi_gong_did_phone_ct;
			self.add1_avm_automated_val3_300k := add1_avm_automated_val3_300k;
			self.yrs_when_credit_first_seen := yrs_when_credit_first_seen;
			self.mod_prop := mod_prop;
			self.no_vo_addrs_per_adl := no_vo_addrs_per_adl;
			self.liens_historical_released_ind := liens_historical_released_ind;
			self.ams_income_level_summary := ams_income_level_summary;
			self.hi_lo_eq_count := hi_lo_eq_count;
			self.add1_ownership_m := add1_ownership_m;
			self.no_ssn_sources := no_ssn_sources;
			self.combo_hphnscore_summary_m := combo_hphnscore_summary_m;
			self.most_recent_purchase := most_recent_purchase;
			self.felony_count_2 := felony_count_2;
			self.ams_college_income_summary_m := ams_college_income_summary_m;
			self.yrs_at_lowissue_ge30 := yrs_at_lowissue_ge30;
			self.lo_addrs_per_adl := lo_addrs_per_adl;
			self.add1_avm_change2_2 := add1_avm_change2_2;
			self.address_recency2_m := address_recency2_m;
			self.gong_did_first_seen2 := gong_did_first_seen2;
			self.header_first_seen2 := header_first_seen2;
			self.time_on_gong := time_on_gong;
			self.ssnprior := ssnprior;
			self.addr_type_summary_m := addr_type_summary_m;
			self.add1_financing_type_m := add1_financing_type_m;
			self.adlperssn_count_summary_m := adlperssn_count_summary_m;
			self.prop1_sale_index := prop1_sale_index;
			self.impulse_ind := impulse_ind;
			self.lo_combo_ssnscore := lo_combo_ssnscore;
			self.mod_phnprob := mod_phnprob;
			self.hi_gong_did_first_ct := hi_gong_did_first_ct;
			self.adl_eq_last_seen2 := adl_eq_last_seen2;
			self.ssndead := ssndead;
			self.adlperssn_count_5 := adlperssn_count_5;
			self.liens_fc_ind := liens_fc_ind;
			self.add1_avm_change2 := add1_avm_change2;
			self.dismissed_bk := dismissed_bk;
			self.address_recency2 := address_recency2;
			self.hm_aptflag := hm_aptflag;
			self.eq_count_50 := eq_count_50;
			self.attr_addrs_last30_2 := attr_addrs_last30_2;
			self.attr_addrs_last36_7 := attr_addrs_last36_7;
			self.veradd_p := veradd_p;
			self.attr_addrs_last24_6 := attr_addrs_last24_6;
			self.hi_addrs_per_adl_c6 := hi_addrs_per_adl_c6;
			self.mod_addrprob := mod_addrprob;
			self.slim_addr_info := slim_addr_info;
			self.ssninvalid := ssninvalid;
			self.rc_numelever_gt4 := rc_numelever_gt4;
			self.add1_avm_change3 := add1_avm_change3;
			self.verx_m := verx_m;
			self.yrs_when_header_first_seen := yrs_when_header_first_seen;
			self.add1_avm_automated_val4_300k := add1_avm_automated_val4_300k;
			self.verphn_p := verphn_p;
			self.pr_count_12 := pr_count_12;
			self.combo_fnamecount_6 := combo_fnamecount_6;
			self.add1_avm_change1 := add1_avm_change1;
			self.lo_combo_addrscore := lo_combo_addrscore;
			self.single_did := single_did;
			self.infutor_nap_ver := infutor_nap_ver;
			self.phn_disconnected := phn_disconnected;
			self.nas12 := nas12;
			self.impulse_count_2 := impulse_count_2;
			self.lres0 := lres0;
			self.adl_eq_first_seen2 := adl_eq_first_seen2;
			self.no_addrs_per_adl := no_addrs_per_adl;
			self.gong_did_last_seen2 := gong_did_last_seen2;
			self.liens_lt_ind := liens_lt_ind;
			self.mosince_criminal_last_date_84 := mosince_criminal_last_date_84;
			self.phone_zip_mismatch := phone_zip_mismatch;
			self.prop1_distressed_sale := prop1_distressed_sale;
			self.add1_naprop_summary_m := add1_naprop_summary_m;
			self.yrsince_rc_ssnlowissue_le15 := yrsince_rc_ssnlowissue_le15;
			self.criminal_last_date2 := criminal_last_date2;
			self.time_on_eq := time_on_eq;
			self.did_ver := did_ver;
			self.watercraft_aircraft_ind := watercraft_aircraft_ind;
			self.attr_addrs_last90_2 := attr_addrs_last90_2;
			self.yrsince_rc_ssnlowissue := yrsince_rc_ssnlowissue;
			self.ssnprob_hm := ssnprob_hm;
			self.credit_first_seen2 := credit_first_seen2;
			self.mod_ssnprob := mod_ssnprob;
			self.out_addr_type_summary := out_addr_type_summary;
			self.add1_avm_change3_2 := add1_avm_change3_2;
			self.prof_license_category_m := prof_license_category_m;
			self.liens_sc_ind := liens_sc_ind;
			self.miss_rc_name_addr_phone := miss_rc_name_addr_phone;
			self.add1_avm_index_summary_m := add1_avm_index_summary_m;
			self.ssns_per_adl_summary_m := ssns_per_adl_summary_m;
			self.ver_phncount := ver_phncount;
			self.ver_nas479 := ver_nas479;
			self.no_addr_sources := no_addr_sources;
			self.liens_cj_ind := liens_cj_ind;
			self.combo_lnamecount_6 := combo_lnamecount_6;
			self.lo_combo_hphonescore := lo_combo_hphonescore;
			self.addrs_5yr_10 := addrs_5yr_10;
			self.add1_hr_mortgage_type := add1_hr_mortgage_type;
			self.address_recency := address_recency;
			self.combo_addrcount_5 := combo_addrcount_5;
			self.lo_rc_dirsaddr_lastscore := lo_rc_dirsaddr_lastscore;
			self.mosince_gong_did_first_seen := mosince_gong_did_first_seen;
			self.lo_add1_address_score := lo_add1_address_score;
			self.add1_avm_automated_val_300k := add1_avm_automated_val_300k;
			self.pred_inc_8_200k := pred_inc_8_200k;
			self.mosince_criminal_last_date := mosince_criminal_last_date;
			self.prop1_sale_index2 := prop1_sale_index2;
			self.verfst_p := verfst_p;
			self.mod_prob := mod_prob;
			self.prof_license_category2 := prof_license_category2;
			self.in_dob2 := in_dob2;
			self.add1_avm_change3_nomiss := add1_avm_change3_nomiss;
			self.gong_hist_summary_m := gong_hist_summary_m;
			self.hi_ssns_per_adl_c6 := hi_ssns_per_adl_c6;
			self.no_pl_addrs_per_adl := no_pl_addrs_per_adl;
			self.no_add1_sources := no_add1_sources;
			self.core_adl := core_adl;
			self.addr_type_summary := addr_type_summary;
			self.invalid_ssns_per_adl_ind := invalid_ssns_per_adl_ind;
			self.yrs_when_ln_first_seen := yrs_when_ln_first_seen;
			self.add1_land_use_code_summary := add1_land_use_code_summary;
			self.phat := phat;
			self.score := score;
			self.rva1003_0_0 := rva1003_0_0;
			self.ov_ssndead := ov_ssndead;
			self.ov_ssnprior := ov_ssnprior;
			self.ov_criminal_flag := ov_criminal_flag;
			self.ov_corrections := ov_corrections;
			self.ov_impulse := ov_impulse;
			self.rva1003_0_0_2 := rva1003_0_0_2;
			self.scored_222s := scored_222s;
			self.rva1003_0_0_3 := rva1003_0_0_3;
		#else

			inCalif := isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

			self.ri := riskwise.rv3autoReasonCodes( le, 4, inCalif, PreScreenOptOut );

			self.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				intformat(rva1003_0_0_3,3,1)
			);
		#end;
		self.seq := le.seq;

	end;

	model := project( clam, doModel(left) );
	return model;

end;
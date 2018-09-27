import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVT1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia=false, boolean PreScreenOptOut=false ) := FUNCTION

	RVT_DEBUG := false;
	
	#if(RVT_DEBUG)
	Layout_Debug := record
		unsigned seq;
		typeof(clam.did) did;
		typeof(clam.truedid) truedid;
		typeof(clam.adlcategory) adl_category;
		typeof(clam.shell_input.unit_desig) out_unit_desig;
		typeof(clam.shell_input.sec_range) out_sec_range;
		typeof(clam.shell_input.st) out_st;
		typeof(clam.shell_input.addr_type) out_addr_type;
		typeof(clam.iid.nas_summary) nas_summary;
		typeof(clam.iid.nap_summary) nap_summary;
		typeof(clam.iid.nap_status) nap_status;
		typeof(clam.iid.didcount) did_count;
		typeof(clam.iid.dirsaddr_lastscore) rc_dirsaddr_lastscore;
		typeof(clam.iid.hriskphoneflag) rc_hriskphoneflag;
		typeof(clam.iid.hphonetypeflag) rc_hphonetypeflag;
		typeof(clam.iid.phonevalflag) rc_phonevalflag;
		typeof(clam.iid.hphonevalflag) rc_hphonevalflag;
		typeof(clam.iid.phonezipflag) rc_phonezipflag;
		typeof(clam.iid.pwphonezipflag) rc_pwphonezipflag;
		typeof(clam.iid.decsflag) rc_decsflag;
		typeof(clam.iid.socsdobflag) rc_ssndobflag;
		typeof(clam.iid.pwsocsdobflag) rc_pwssndobflag;
		unsigned rc_ssnhighissue;
		typeof(clam.iid.areacodesplitflag) rc_areacodesplitflag;
		typeof(clam.iid.addrvalflag) rc_addrvalflag;
		typeof(clam.iid.dwelltype) rc_dwelltype;
		typeof(clam.iid.bansflag) rc_bansflag;
		typeof(clam.iid.sources) rc_sources;
		typeof(clam.iid.hrisksic) rc_hrisksic;
		typeof(clam.iid.disthphoneaddr) rc_disthphoneaddr;
		typeof(clam.iid.phonetype) rc_phonetype;
		typeof(clam.iid.statezipflag) rc_statezipflag;
		typeof(clam.iid.firstssnmatch) rc_fnamessnmatch;
		typeof(clam.iid.combo_addrscore) combo_addrscore;
		typeof(clam.iid.combo_hphonescore) combo_hphonescore;
		typeof(clam.iid.combo_ssnscore) combo_ssnscore;
		typeof(clam.iid.combo_dobscore) combo_dobscore;
		typeof(clam.iid.combo_addrcount) combo_addrcount;
		typeof(clam.source_verification.eq_count) eq_count;
		typeof(clam.source_verification.pr_count) pr_count;
		typeof(clam.source_verification.adl_eqfs_first_seen) adl_eq_first_seen;
		typeof(clam.source_verification.adl_en_first_seen) adl_en_first_seen;
		typeof(clam.source_verification.adl_pr_first_seen) adl_pr_first_seen;
		typeof(clam.source_verification.adl_em_first_seen) adl_em_first_seen;
		typeof(clam.source_verification.adl_vo_first_seen) adl_vo_first_seen;
		typeof(clam.source_verification.adl_em_only_first_seen) adl_em_only_first_seen;
		typeof(clam.source_verification.adl_w_first_seen) adl_w_first_seen;
		typeof(clam.source_verification.adl_w_last_seen) adl_w_last_seen;
		typeof(clam.source_verification.addrsources) addr_sources;
		typeof(clam.source_verification.em_only_sources) em_only_sources;
		typeof(clam.available_sources.voter) voter_avail;
		typeof(clam.input_validation.ssn_length) ssnlength;
		typeof(clam.name_verification.adl_score) adl_score;
		typeof(clam.name_verification.lname_score) lname_score;
		typeof(clam.name_verification.lname_change_date) lname_change_date;
		typeof(clam.name_verification.fname_eda_sourced_type) fname_eda_sourced_type;
		typeof(clam.name_verification.lname_eda_sourced) lname_eda_sourced;
		typeof(clam.name_verification.lname_eda_sourced_type) lname_eda_sourced_type;
		typeof(clam.name_verification.age) age;
		typeof(clam.address_verification.input_address_information.address_score) add1_address_score;
		typeof(clam.address_verification.input_address_information.isbestmatch) add1_isbestmatch;
		typeof(clam.address_verification.input_address_information.unit_count) add1_unit_count;
		typeof(clam.lres) add1_lres;
		typeof(clam.avm.input_address_information.avm_land_use_code) add1_avm_land_use;
		typeof(clam.avm.input_address_information.avm_recording_date) add1_avm_recording_date;
		typeof(clam.avm.input_address_information.avm_assessed_value_year) add1_avm_assessed_value_year;
		typeof(clam.avm.input_address_information.avm_assessed_total_value) add1_avm_assessed_total_value;
		typeof(clam.avm.input_address_information.avm_market_total_value) add1_avm_market_total_value;
		typeof(clam.avm.input_address_information.avm_hedonic_valuation) add1_avm_hedonic_valuation;
		typeof(clam.avm.input_address_information.avm_automated_valuation) add1_avm_automated_valuation;
		typeof(clam.avm.input_address_information.avm_automated_valuation2) add1_avm_automated_valuation_2;
		typeof(clam.avm.input_address_information.avm_automated_valuation3) add1_avm_automated_valuation_3;
		typeof(clam.avm.input_address_information.avm_automated_valuation4) add1_avm_automated_valuation_4;
		typeof(clam.avm.input_address_information.avm_median_fips_level) add1_avm_med_fips;
		typeof(clam.avm.input_address_information.avm_median_geo11_level) add1_avm_med_geo11;
		typeof(clam.avm.input_address_information.avm_median_geo12_level) add1_avm_med_geo12;
		typeof(clam.address_verification.input_address_information.applicant_owned) add1_applicant_owned;
		typeof(clam.address_verification.input_address_information.occupant_owned) add1_occupant_owned;
		typeof(clam.address_verification.input_address_information.family_owned) add1_family_owned;
		typeof(clam.address_verification.input_address_information.naprop) add1_naprop;
		typeof(clam.address_verification.input_address_information.built_date) add1_built_date;
		typeof(clam.address_verification.input_address_information.purchase_amount) add1_purchase_amount;
		typeof(clam.address_verification.input_address_information.mortgage_date) add1_mortgage_date;
		typeof(clam.address_verification.input_address_information.mortgage_type) add1_mortgage_type;
		typeof(clam.address_verification.input_address_information.type_financing) add1_financing_type;
		typeof(clam.address_verification.input_address_information.first_td_due_date) add1_mortgage_due_date;
		typeof(clam.address_verification.input_address_information.assessed_amount) add1_assessed_amount;
		typeof(clam.address_verification.input_address_information.date_first_seen) add1_date_first_seen;
		typeof(clam.address_verification.input_address_information.standardized_land_use_code) add1_land_use_code;
		string add1_building_area;
		string add1_no_of_partial_baths;
		typeof(clam.addrpop) add1_pop;
		typeof(clam.address_verification.owned.property_total) property_owned_total;
		typeof(clam.address_verification.owned.property_owned_assessed_total) property_owned_assessed_total;
		typeof(clam.address_verification.sold.property_total) property_sold_total;
		typeof(clam.address_verification.sold.property_owned_assessed_total) property_sold_assessed_total;
		typeof(clam.address_verification.recent_property_sales.sale_price1) prop1_sale_price;
		typeof(clam.address_verification.recent_property_sales.sale_date2) prop2_sale_date;
		typeof(clam.address_verification.distance_in_2_h1) dist_a1toa2;
		typeof(clam.address_verification.distance_in_2_h2) dist_a1toa3;
		typeof(clam.address_verification.distance_h1_2_h2) dist_a2toa3;
		typeof(clam.address_verification.address_history_1.address_score) add2_address_score;
		typeof(clam.lres2) add2_lres;
		typeof(clam.avm.address_history_1.avm_land_use_code) add2_avm_land_use;
		typeof(clam.avm.address_history_1.avm_sales_price) add2_avm_sales_price;
		typeof(clam.avm.address_history_1.avm_market_total_value) add2_avm_market_total_value;
		typeof(clam.avm.address_history_1.avm_hedonic_valuation) add2_avm_hedonic_valuation;
		typeof(clam.avm.address_history_1.avm_automated_valuation) add2_avm_automated_valuation;
		typeof(clam.avm.address_history_1.avm_automated_valuation3) add2_avm_automated_valuation_3;
		typeof(clam.avm.address_history_1.avm_automated_valuation4) add2_avm_automated_valuation_4;
		typeof(clam.address_verification.address_history_1.sources) add2_sources;
		typeof(clam.address_verification.address_history_1.applicant_owned) add2_applicant_owned;
		typeof(clam.address_verification.address_history_1.family_owned) add2_family_owned;
		typeof(clam.address_verification.address_history_1.naprop) add2_naprop;
		string add2_no_of_buildings;
		string add2_parking_no_of_cars;
		typeof(clam.address_verification.address_history_1.assessed_value_year) add2_assessed_value_year;
		typeof(clam.address_verification.address_history_1.mortgage_type) add2_mortgage_type;
		typeof(clam.address_verification.address_history_1.assessed_amount) add2_assessed_amount;
		typeof(clam.address_verification.address_history_1.date_first_seen) add2_date_first_seen;
		typeof(clam.address_verification.address_history_1.date_last_seen) add2_date_last_seen;
		typeof(clam.addrpop2) add2_pop;
		typeof(clam.lres3) add3_lres;
		typeof(clam.address_verification.address_history_2.sources) add3_sources;
		typeof(clam.address_verification.address_history_2.applicant_owned) add3_applicant_owned;
		typeof(clam.address_verification.address_history_2.family_owned) add3_family_owned;
		typeof(clam.address_verification.address_history_2.naprop) add3_naprop;
		typeof(clam.address_verification.address_history_2.mortgage_type) add3_mortgage_type;
		typeof(clam.address_verification.address_history_2.assessed_amount) add3_assessed_amount;
		typeof(clam.address_verification.address_history_2.date_first_seen) add3_date_first_seen;
		typeof(clam.addrpop3) add3_pop;
		typeof(clam.other_address_info.addrs_last_5years) addrs_5yr;
		typeof(clam.other_address_info.addrs_last_10years) addrs_10yr;
		typeof(clam.other_address_info.addrs_last_15years) addrs_15yr;
		typeof(clam.other_address_info.isprison) addrs_prison_history;
		typeof(clam.phone_verification.gong_did.gong_adl_dt_first_seen_full) gong_did_first_seen;
		typeof(clam.phone_verification.gong_did.gong_did_phone_ct) gong_did_phone_ct;
		typeof(clam.ssn_verification.nameperssn_count) nameperssn_count;
		typeof(clam.ssn_verification.credit_first_seen) credit_first_seen;
		typeof(clam.ssn_verification.header_first_seen) header_first_seen;
		typeof(clam.ssn_verification.validation.inputsocscharflag) inputssncharflag;
		typeof(clam.velocity_counters.ssns_per_adl) ssns_per_adl;
		typeof(clam.velocity_counters.addrs_per_adl) addrs_per_adl;
		typeof(clam.velocity_counters.phones_per_adl) phones_per_adl;
		typeof(clam.ssn_verification.adlperssn_count) adlperssn_count;
		typeof(clam.velocity_counters.addrs_per_ssn) addrs_per_ssn;
		typeof(clam.velocity_counters.adls_per_addr) adls_per_addr;
		typeof(clam.velocity_counters.ssns_per_addr) ssns_per_addr;
		typeof(clam.velocity_counters.phones_per_addr) phones_per_addr;
		typeof(clam.velocity_counters.adls_per_phone) adls_per_phone;
		typeof(clam.velocity_counters.ssns_per_adl_created_6months) ssns_per_adl_c6;
		typeof(clam.velocity_counters.addrs_per_adl_created_6months) addrs_per_adl_c6;
		typeof(clam.velocity_counters.phones_per_adl_created_6months) phones_per_adl_c6;
		typeof(clam.velocity_counters.ssns_per_addr_created_6months) ssns_per_addr_c6;
		typeof(clam.velocity_counters.phones_per_addr_created_6months) phones_per_addr_c6;
		typeof(clam.velocity_counters.adls_per_phone_created_6months) adls_per_phone_c6;
		typeof(clam.velocity_counters.vo_addrs_per_adl) vo_addrs_per_adl;
		typeof(clam.velocity_counters.invalid_ssns_per_adl_created_6months) invalid_ssns_per_adl_c6;
		typeof(clam.infutor_phone.infutor_date_first_seen) infutor_first_seen;
		typeof(clam.infutor_phone.infutor_nap) infutor_nap;
		typeof(clam.impulse.count) impulse_count;
		typeof(clam.other_address_info.addrs_last24) attr_addrs_last24;
		typeof(clam.other_address_info.addrs_last36) attr_addrs_last36;
		typeof(clam.watercraft.watercraft_count60) attr_num_watercraft60;
		typeof(clam.total_number_derogs) attr_total_number_derogs;
		typeof(clam.bjl.eviction_count) attr_eviction_count;
		typeof(clam.bjl.eviction_count30) attr_eviction_count30;
		typeof(clam.bjl.eviction_count90) attr_eviction_count90;
		typeof(clam.bjl.eviction_count180) attr_eviction_count180;
		typeof(clam.bjl.eviction_count12) attr_eviction_count12;
		typeof(clam.bjl.eviction_count24) attr_eviction_count24;
		typeof(clam.bjl.eviction_count36) attr_eviction_count36;
		typeof(clam.bjl.eviction_count60) attr_eviction_count60;
		typeof(clam.source_verification.num_nonderogs90) attr_num_nonderogs90;
		typeof(clam.professional_license.proflic_count90) attr_num_proflic90;
		typeof(clam.professional_license.expire_count90) attr_num_proflic_exp90;
		typeof(clam.professional_license.expire_count12) attr_num_proflic_exp12;
		typeof(clam.bjl.bankrupt) bankrupt;
		typeof(clam.bjl.date_last_seen) date_last_seen;
		typeof(clam.bjl.filing_type) filing_type;
		typeof(clam.bjl.disposition) disposition;
		typeof(clam.bjl.filing_count) filing_count;
		typeof(clam.bjl.bk_recent_count) bk_recent_count;
		typeof(clam.bjl.bk_disposed_historical_count) bk_disposed_historical_count;
		typeof(clam.bjl.liens_recent_unreleased_count) liens_recent_unreleased_count;
		typeof(clam.bjl.liens_historical_unreleased_count) liens_historical_unreleased_ct;
		typeof(clam.bjl.last_liens_unreleased_date) liens_last_unrel_date;
		typeof(clam.liens.liens_unreleased_civil_judgment.count) liens_unrel_cj_ct;
		typeof(clam.liens.liens_unreleased_civil_judgment.most_recent_filing_date) liens_unrel_cj_last_seen;
		typeof(clam.liens.liens_unreleased_federal_tax.count) liens_unrel_ft_ct;
		typeof(clam.liens.liens_unreleased_landlord_tenant.count) liens_unrel_lt_ct;
		typeof(clam.liens.liens_unreleased_landlord_tenant.earliest_filing_date) liens_unrel_lt_first_seen;
		typeof(clam.liens.liens_unreleased_other_lj.count) liens_unrel_o_ct;
		typeof(clam.liens.liens_unreleased_other_tax.count) liens_unrel_ot_ct;
		typeof(clam.liens.liens_unreleased_other_tax.earliest_filing_date) liens_unrel_ot_first_seen;
		typeof(clam.liens.liens_unreleased_other_tax.total_amount) liens_unrel_ot_total_amount;
		typeof(clam.liens.liens_unreleased_small_claims.count) liens_unrel_sc_ct;
		typeof(clam.bjl.criminal_count) criminal_count;
		typeof(clam.bjl.felony_count) felony_count;
		typeof(clam.watercraft.watercraft_count) watercraft_count;
		typeof(clam.student.age) ams_age;
		typeof(clam.student.class) ams_class;
		typeof(clam.student.college_code) ams_college_code;
		typeof(clam.student.income_level_code) ams_income_level_code;
		typeof(clam.student.college_tier) ams_college_tier;
		typeof(clam.professional_license.plcategory) prof_license_category;
		typeof(clam.wealth_indicator) wealth_index;
		typeof(clam.dobmatchlevel) input_dob_match_level;
		typeof(clam.inferred_age) inferred_age;
		typeof(clam.reported_dob) reported_dob;
		typeof(clam.historydate) archive_date;

		Integer sysdate;
		Real sysyear;
		Integer rc_ssnhighissue2;
		Real years_rc_ssnhighissue;
		Real months_rc_ssnhighissue;
		Integer adl_eq_first_seen2;
		Real years_adl_eq_first_seen;
		Real months_adl_eq_first_seen;
		Integer adl_en_first_seen2;
		Real years_adl_en_first_seen;
		Real months_adl_en_first_seen;
		Integer adl_pr_first_seen2;
		Real years_adl_pr_first_seen;
		Real months_adl_pr_first_seen;
		Integer adl_em_first_seen2;
		Real years_adl_em_first_seen;
		Real months_adl_em_first_seen;
		Integer adl_vo_first_seen2;
		Real years_adl_vo_first_seen;
		Real months_adl_vo_first_seen;
		Integer adl_em_only_first_seen2;
		Real years_adl_em_only_first_seen;
		Real months_adl_em_only_first_seen;
		Integer adl_w_first_seen2;
		Real years_adl_w_first_seen;
		Real months_adl_w_first_seen;
		Integer adl_w_last_seen2;
		Real years_adl_w_last_seen;
		Real months_adl_w_last_seen;
		Integer lname_change_date2;
		Real years_lname_change_date;
		Real months_lname_change_date;
		Integer add1_avm_recording_date2;
		Real years_add1_avm_recording_date;
		Real months_add1_avm_recording_date;
		Integer add1_built_date2;
		Real years_add1_built_date;
		Real months_add1_built_date;
		Integer add1_mortgage_date2;
		Real years_add1_mortgage_date;
		Real months_add1_mortgage_date;
		Integer add1_mortgage_due_date2;
		Real years_add1_mortgage_due_date;
		Real months_add1_mortgage_due_date;
		Integer add1_date_first_seen2;
		Real years_add1_date_first_seen;
		Real months_add1_date_first_seen;
		Integer prop2_sale_date2;
		Real years_prop2_sale_date;
		Real months_prop2_sale_date;
		Integer add2_assessed_value_year2;
		Real years_add2_assessed_value_year;
		Real months_add2_assessed_value_year;
		Integer add2_date_first_seen2;
		Real years_add2_date_first_seen;
		Real months_add2_date_first_seen;
		Integer add2_date_last_seen2;
		Real years_add2_date_last_seen;
		Real months_add2_date_last_seen;
		Integer add3_date_first_seen2;
		Real years_add3_date_first_seen;
		Real months_add3_date_first_seen;
		Integer gong_did_first_seen2;
		Real years_gong_did_first_seen;
		Real months_gong_did_first_seen;
		Integer credit_first_seen2;
		Real years_credit_first_seen;
		Real months_credit_first_seen;
		Integer header_first_seen2;
		Real years_header_first_seen;
		Real months_header_first_seen;
		Integer infutor_first_seen2;
		Real years_infutor_first_seen;
		Real months_infutor_first_seen;
		Integer date_last_seen2;
		Real years_date_last_seen;
		Real months_date_last_seen;
		Integer liens_last_unrel_date2;
		Real years_liens_last_unrel_date;
		Real months_liens_last_unrel_date;
		Integer liens_unrel_cj_last_seen2;
		Real years_liens_unrel_cj_last_seen;
		Real months_liens_unrel_cj_last_seen;
		Integer liens_unrel_lt_first_seen2;
		Real years_liens_unrel_lt_first_seen;
		Real months_liens_unrel_lt_first_seen;
		Integer liens_unrel_ot_first_seen2;
		Real years_liens_unrel_ot_first_seen;
		Real months_liens_unrel_ot_first_seen;
		Integer reported_dob2;
		Real years_reported_dob;
		Real months_reported_dob;
		Integer add1_avm_assessed_value_year2;
		Real years_add1_avm_assess_year;
		Real months_add1_avm_assess_year;
		Boolean source_tot_AK;
		Boolean source_tot_AM;
		Boolean source_tot_AR;
		Boolean source_tot_BA;
		Boolean source_tot_CG;
		Boolean source_tot_DA;
		Boolean source_tot_DS;
		Boolean source_tot_EB;
		Boolean source_tot_EM;
		Boolean source_tot_VO;
		Boolean source_tot_FF;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean source_tot_P;
		Boolean source_tot_W;
		Boolean source_tot_voter;
		Boolean source_add_P;
		Boolean source_add2_AK;
		Boolean source_add2_AM;
		Boolean source_add2_AR;
		Boolean source_add2_CG;
		Boolean source_add2_EB;
		Boolean source_add2_EM;
		Boolean source_add2_VO;
		Boolean source_add2_EQ;
		Boolean source_add2_P;
		Boolean source_add2_WP;
		Boolean source_add2_voter;
		Boolean source_add3_P;
		Boolean em_only_source_EM;
		Boolean em_only_source_E1;
		Boolean em_only_source_E2;
		Boolean em_only_source_E3;
		Boolean em_only_source_E4;
		Real years_adl_first_seen_max_fcra;
		Real months_adl_first_seen_max_fcra;
		Boolean add_apt;
		Boolean phn_disconnected;
		Boolean phn_inval;
		Boolean phn_cellpager;
		Boolean phn_zipmismatch;
		Boolean ssn_deceased;
		Boolean ssn_adl_prob;
		Boolean bk_flag;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean lien_flag;
		Boolean crime_flag;
		Boolean crime_felony_flag;
		Boolean crime_drug_flag;
		Boolean add1_AVM_hit;
		Integer add1_avm_med;
		Real add1_avm_to_med_ratio;
		Real add_lres_month_avg;
		Integer pk_wealth_index;
		Real pk_wealth_index_m;
		Integer wealth_index_cm;
		Integer pk_bk_level;
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
		Real Dist_mod;
		Integer pk_yr_date_last_seen;
		Integer pk_bk_yr_date_last_seen;
		Real pk_bk_yr_date_last_seen_m1;
		Integer adl_category_ord;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk2_yr_liens_unrel_cj_last_seen;
		Real predicted_inc_high;
		Real predicted_inc_low;
		Real pred_inc;
		Real estimated_income;
		Real estimated_income_2;
		Integer pk_ssnchar_invalid_or_recent;
		Integer pk_did0;
		Integer pk_yr_adl_vo_first_seen;
		Integer pk_yr_adl_em_only_first_seen;
		Integer pk_yr_adl_first_seen_max_fcra;
		Integer pk_mo_adl_first_seen_max_fcra;
		Integer pk_yr_lname_change_date;
		Integer pk_yr_gong_did_first_seen;
		Integer pk_yr_credit_first_seen;
		Integer pk_yr_header_first_seen;
		Integer pk_yr_infutor_first_seen;
		Integer pk_multi_did;
		Integer pk_nas_summary;
		Integer pk_nap_summary;
		Integer pk_rc_dirsaddr_lastscore;
		Integer pk_adl_score;
		Integer pk_lname_score;
		Integer pk_combo_addrscore;
		Integer pk_combo_hphonescore;
		Integer pk_combo_ssnscore;
		Integer pk_eq_count;
		Integer pk_pos_secondary_sources;
		Integer pk_voter_flag;
		Integer pk_fname_eda_sourced_type_lvl;
		Integer pk_lname_eda_sourced_type_lvl;
		Integer pk_add1_address_score;
		Integer pk_add1_unit_count2;
		Integer pk_add2_address_score;
		Integer pk_add2_pos_sources;
		Integer pk_add2_pos_secondary_sources;
		Boolean add2_source_EM;
		Boolean add2_source_E1;
		Boolean add2_source_E2;
		Boolean add2_source_E3;
		Boolean add2_source_E4;
		Boolean add3_source_EM;
		Boolean add3_source_E1;
		Boolean add3_source_E2;
		Boolean add3_source_E3;
		Boolean add3_source_E4;
		Integer pk_em_only_ver_lvl;
		Integer pk_add2_em_ver_lvl;
		Integer pk_ssnchar_invalid_or_recent_2;
		Integer pk_infutor_risk_lvl;
		Integer pk_infutor_risk_lvl_nb;
		Integer pk_yr_adl_vo_first_seen2;
		Integer pk_yr_adl_em_only_first_seen2;
		Integer pk_yrmo_adl_first_seen_max_fcra2;
		Integer pk_yrmo_adl_f_sn_mx_fcra2_nb;
		Integer pk_yr_lname_change_date2;
		Integer pk_yr_gong_did_first_seen2;
		Integer pk_yr_credit_first_seen2;
		Integer pk_yr_header_first_seen2;
		Integer pk_yr_infutor_first_seen2;
		Integer pk_estimated_income;
		Integer pk_yr_adl_w_last_seen;
		Integer pk_yr_add1_built_date;
		Integer pk_yr_add1_mortgage_date;
		Integer pk_yr_add1_mortgage_due_date;
		Integer pk_yr_add1_date_first_seen;
		Integer pk_yr_prop2_sale_date;
		Integer pk_yr_add2_assessed_value_year;
		Integer pk_yr_add2_date_first_seen;
		Integer pk_yr_add2_date_last_seen;
		Integer pk_yr_add3_date_first_seen;
		Integer pk_property_owned_assessed_total;
		Integer pk_prop1_sale_price;
		Integer pk_add1_purchase_amount;
		Integer pk_add1_assessed_amount;
		Integer pk_add2_assessed_amount;
		Integer pk_add3_assessed_amount;
		Integer pk_property_owned_assessed_total_2;
		Integer pk_prop1_sale_price_2;
		Integer pk_add1_purchase_amount_2;
		Integer pk_add1_assessed_amount_2;
		Integer pk_add2_assessed_amount_2;
		Integer pk_add3_assessed_amount_2;
		Integer pk_add1_building_area;
		Integer pk_yr_adl_w_last_seen2;
		Integer pk_pr_count;
		Integer pk_addrs_sourced_lvl;
		Integer pk_add1_own_level;
		Integer pk_naprop_level;
		Integer pk_naprop_level2_b1;
		Integer pk_naprop_level2;
		Integer pk_add2_own_level;
		Integer pk_add3_own_level;
		Integer pk_yr_add1_built_date2;
		Integer pk_add1_purchase_amount2;
		Integer pk_yr_add1_mortgage_date2;
		Integer pk_add1_mortgage_risk;
		Integer pk_add1_adjustable_financing;
		Integer pk_add1_assessed_amount2;
		Integer pk_yr_add1_mortgage_due_date2;
		Integer pk_yr_add1_date_first_seen2;
		String pk_add1_land_use_cat;
		Integer pk_add1_land_use_risk_level;
		Integer pk_add1_building_area2;
		Integer pk_add1_no_of_partial_baths;
		Integer pk_property_owned_total;
		Integer pk_prop_own_assess_tot2;
		Integer pk_prop1_sale_price2;
		Integer pk_yr_prop2_sale_date2;
		Integer pk_add2_no_of_buildings;
		Integer pk_add2_parking_no_of_cars;
		Integer pk_yr_add2_assessed_value_year2;
		Integer pk_add2_mortgage_risk;
		Integer pk_add2_assessed_amount2;
		Integer pk_yr_add2_date_first_seen2;
		Integer pk_yr_add2_date_last_seen2;
		Integer pk_add3_mortgage_risk;
		Integer pk_add3_assessed_amount2;
		Integer pk_yr_add3_date_first_seen2;
		Integer pk_watercraft_count;
		Integer pk_attr_num_watercraft60;
		Integer pk_yr_liens_last_unrel_date;
		Integer pk_yr_liens_unrel_lt_first_seen;
		Integer pk_yr_liens_unrel_ot_first_seen;
		Integer pk_bk_level_2;
		Integer pk_liens_unrel_cj_ct;
		Integer pk_liens_unrel_ft_ct;
		Integer pk_liens_unrel_lt_ct;
		Integer pk_liens_unrel_o_ct;
		Integer pk_liens_unrel_ot_ct;
		Integer pk_liens_unrel_sc_ct;
		Integer pk_liens_unrel_count;
		Integer pk_lien_type_level;
		Integer pk_yr_liens_last_unrel_date2;
		Integer pk_yr_liens_last_unrel_date3;
		Real pk_yr_liens_last_unrel_date3_2;
		Integer pk_yr_liens_unrel_lt_first_sn2;
		Integer pk_yr_liens_unrel_ot_first_sn2;
		Integer pk_attr_eviction_count;
		Integer pk_eviction_level;
		Integer pk_crime_level;
		Integer pk_attr_total_number_derogs_3;
		Integer pk_yr_rc_ssnhighissue;
		Integer pk_addr_not_valid;
		Integer pk_area_code_split;
		Integer pk_disconnected;
		Integer pk_phn_cell_pager_inval;
		Integer pk_yr_rc_ssnhighissue2;
		Integer pk_prof_lic_cat;
		Integer pk_attr_num_proflic90;
		Integer pk_attr_num_proflic_exp90;
		Integer pk_attr_num_proflic_exp12;
		Integer pk_add_lres_month_avg;
		Integer pk_add1_lres;
		Integer pk_add2_lres;
		Integer pk_add3_lres;
		Integer pk_addrs_5yr;
		Integer pk_addrs_15yr;
		Integer pk_add_lres_month_avg2;
		Integer pk_nameperssn_count;
		Integer pk_ssns_per_adl;
		Integer pk_addrs_per_adl;
		Integer pk_phones_per_adl;
		Integer pk_adlperssn_count;
		Integer pk_addrs_per_ssn;
		Integer pk_adls_per_addr_b1;
		Integer pk_ssns_per_addr2_b1;
		Integer pk_phones_per_addr_b1;
		Integer pk_adls_per_addr_b2;
		Integer pk_ssns_per_addr2_b2;
		Integer pk_phones_per_addr_b2;
		Integer pk_phones_per_addr;
		Integer pk_adls_per_addr;
		Integer pk_ssns_per_addr2;
		Integer pk_adls_per_phone;
		Integer pk_ssns_per_adl_c6;
		Integer pk_addrs_per_adl_c6;
		Integer pk_phones_per_adl_c6;
		Integer pk_ssns_per_addr_c6_b1;
		Integer pk_phones_per_addr_c6_b1;
		Integer pk_ssns_per_addr_c6_b2;
		Integer pk_phones_per_addr_c6_b2;
		Integer pk_ssns_per_addr_c6;
		Integer pk_phones_per_addr_c6;
		Integer pk_adls_per_phone_c6;
		Integer pk_vo_addrs_per_adl;
		Integer pk_attr_addrs_last24;
		Integer pk_attr_addrs_last36;
		Integer pk_college_tier;
		Real ams_class_n_b8;
		Real ams_class_n_b8_2;
		Integer pk_ams_class_level_b8;
		Real pk_since_ams_class_year;
		Real ams_class_n;
		Integer pk_ams_class_level;
		Integer pk_ams_income_level_code;
		Integer pk_yr_reported_dob;
		Integer pk_ams_age;
		Integer pk_inferred_age;
		Integer pk_yr_reported_dob2;
		Integer pk_yr_add1_avm_recording_date;
		Integer pk_yr_add1_avm_assess_year;
		Integer pk_add1_avm_as;
		Integer pk_add1_avm_mkt;
		Integer pk_add1_avm_hed;
		Integer pk_add1_avm_auto;
		Integer pk_add1_avm_auto2;
		Integer pk_add1_avm_auto3;
		Integer pk_add1_avm_auto4;
		Integer pk_add1_avm_med;
		Integer pk_add2_avm_sp;
		Integer pk_add2_avm_mkt;
		Integer pk_add2_avm_hed;
		Integer pk_add2_avm_auto;
		Integer pk_add2_avm_auto3;
		Integer pk_add2_avm_auto4;
		Integer pk_add1_avm_as_2;
		Integer pk_add1_avm_mkt_2;
		Integer pk_add1_avm_hed_2;
		Integer pk_add1_avm_auto_2;
		Integer pk_add1_avm_auto2_2;
		Integer pk_add1_avm_auto3_2;
		Integer pk_add1_avm_auto4_2;
		Integer pk_add1_avm_med_2;
		Integer pk_add2_avm_sp_2;
		Integer pk_add2_avm_mkt_2;
		Integer pk_add2_avm_hed_2;
		Integer pk_add2_avm_auto_2;
		Integer pk_add2_avm_auto3_2;
		Integer pk_add2_avm_auto4_2;
		Real pk_add1_avm_to_med_ratio;
		Real pk_add1_avm_to_med_ratio_2;
		Integer pk2_add1_avm_as;
		Integer pk2_add1_avm_mkt;
		Integer pk2_add1_avm_hed;
		Integer pk2_add1_avm_auto;
		Integer pk2_add1_avm_auto2;
		Integer pk2_add1_avm_auto3;
		Integer pk2_add1_avm_auto4;
		Integer pk_avm_auto_diff4;
		Integer pk_avm_auto_diff4_lvl;
		Integer pk2_add1_avm_med;
		Integer pk2_add1_avm_to_med_ratio;
		Integer pk_add2_avm_hit;
		Integer pk_avm_hit_level;
		Integer pk2_add2_avm_sp;
		Integer pk2_add2_avm_mkt;
		Integer pk2_add2_avm_hed;
		Integer pk2_add2_avm_auto;
		Integer pk2_add2_avm_auto3;
		Integer pk2_add2_avm_auto4;
		Integer pk_add2_avm_auto_diff3;
		Integer pk_add2_avm_auto_diff3_lvl;
		Integer pk2_yr_add1_avm_recording_date;
		Integer pk2_yr_add1_avm_assess_year;
		Integer pk_dist_a1toa2_2;
		Integer pk_dist_a1toa3_2;
		Integer pk_rc_disthphoneaddr_2;
		Integer pk_out_st_division_lvl;
		Integer pk_wealth_index_2;
		Integer pk_impulse_count;
		Integer pk_impulse_count_2;
		Integer pk_attr_total_number_derogs_4;
		Integer pk_attr_total_number_derogs_5;
		Integer pk_attr_num_nonderogs90_3;
		Integer pk_attr_num_nonderogs90_4;
		Integer pk_derog_total_2;
		Integer pk_attr_num_nonderogs90_b;
		Integer pk_adl_cat_deceased;
		String bs_own_rent;
		Integer bs_attr_derog_flag;
		Integer bs_attr_eviction_flag;
		Integer bs_attr_derog_flag2;
		String pk_Segment;
		String pk_segment_2;
		Real pk_nas_summary_mm_b1_c2_b1;
		Real pk_nap_summary_mm_b1_c2_b1;
		Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
		Real pk_adl_score_mm_b1_c2_b1;
		Real pk_lname_score_mm_b1_c2_b1;
		Real pk_combo_addrscore_mm_b1_c2_b1;
		Real pk_combo_hphonescore_mm_b1_c2_b1;
		Real pk_combo_ssnscore_mm_b1_c2_b1;
		Real pk_eq_count_mm_b1_c2_b1;
		Real pk_pos_secondary_sources_mm_b1_c2_b1;
		Real pk_voter_flag_mm_b1_c2_b1;
		Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1;
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
		Real pk_add1_address_score_mm_b1_c2_b1;
		Real pk_add2_address_score_mm_b1_c2_b1;
		Real pk_add2_pos_sources_mm_b1_c2_b1;
		Real pk_add2_pos_secondary_sources_mm_b1_c2_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
		Real pk_infutor_risk_lvl_mm_b1_c2_b1;
		Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
		Real pk_yr_lname_change_date2_mm_b1_c2_b1;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
		Real pk_yr_credit_first_seen2_mm_b1_c2_b1;
		Real pk_yr_header_first_seen2_mm_b1_c2_b1;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b1;
		Real pk_em_only_ver_lvl_mm_b1_c2_b1;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
		Real pk_nas_summary_mm_b1_c2_b2;
		Real pk_nap_summary_mm_b1_c2_b2;
		Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
		Real pk_adl_score_mm_b1_c2_b2;
		Real pk_lname_score_mm_b1_c2_b2;
		Real pk_combo_addrscore_mm_b1_c2_b2;
		Real pk_combo_hphonescore_mm_b1_c2_b2;
		Real pk_combo_ssnscore_mm_b1_c2_b2;
		Real pk_eq_count_mm_b1_c2_b2;
		Real pk_pos_secondary_sources_mm_b1_c2_b2;
		Real pk_voter_flag_mm_b1_c2_b2;
		Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2;
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
		Real pk_add1_address_score_mm_b1_c2_b2;
		Real pk_add2_address_score_mm_b1_c2_b2;
		Real pk_add2_pos_sources_mm_b1_c2_b2;
		Real pk_add2_pos_secondary_sources_mm_b1_c2_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
		Real pk_infutor_risk_lvl_mm_b1_c2_b2;
		Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
		Real pk_yr_lname_change_date2_mm_b1_c2_b2;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
		Real pk_yr_credit_first_seen2_mm_b1_c2_b2;
		Real pk_yr_header_first_seen2_mm_b1_c2_b2;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b2;
		Real pk_em_only_ver_lvl_mm_b1_c2_b2;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
		Real pk_nas_summary_mm_b1_c2_b3;
		Real pk_nap_summary_mm_b1_c2_b3;
		Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
		Real pk_adl_score_mm_b1_c2_b3;
		Real pk_lname_score_mm_b1_c2_b3;
		Real pk_combo_addrscore_mm_b1_c2_b3;
		Real pk_combo_hphonescore_mm_b1_c2_b3;
		Real pk_combo_ssnscore_mm_b1_c2_b3;
		Real pk_eq_count_mm_b1_c2_b3;
		Real pk_pos_secondary_sources_mm_b1_c2_b3;
		Real pk_voter_flag_mm_b1_c2_b3;
		Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3;
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
		Real pk_add1_address_score_mm_b1_c2_b3;
		Real pk_add2_address_score_mm_b1_c2_b3;
		Real pk_add2_pos_sources_mm_b1_c2_b3;
		Real pk_add2_pos_secondary_sources_mm_b1_c2_b3;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
		Real pk_infutor_risk_lvl_mm_b1_c2_b3;
		Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b3;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
		Real pk_yr_lname_change_date2_mm_b1_c2_b3;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
		Real pk_yr_credit_first_seen2_mm_b1_c2_b3;
		Real pk_yr_header_first_seen2_mm_b1_c2_b3;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b3;
		Real pk_em_only_ver_lvl_mm_b1_c2_b3;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b3;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
		Real pk_nas_summary_mm_b1_c2_b4;
		Real pk_nap_summary_mm_b1_c2_b4;
		Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b4;
		Real pk_adl_score_mm_b1_c2_b4;
		Real pk_lname_score_mm_b1_c2_b4;
		Real pk_combo_addrscore_mm_b1_c2_b4;
		Real pk_combo_hphonescore_mm_b1_c2_b4;
		Real pk_combo_ssnscore_mm_b1_c2_b4;
		Real pk_eq_count_mm_b1_c2_b4;
		Real pk_pos_secondary_sources_mm_b1_c2_b4;
		Real pk_voter_flag_mm_b1_c2_b4;
		Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b4;
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4;
		Real pk_add1_address_score_mm_b1_c2_b4;
		Real pk_add2_address_score_mm_b1_c2_b4;
		Real pk_add2_pos_sources_mm_b1_c2_b4;
		Real pk_add2_pos_secondary_sources_mm_b1_c2_b4;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b4;
		Real pk_infutor_risk_lvl_mm_b1_c2_b4;
		Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b4;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4;
		Real pk_yr_lname_change_date2_mm_b1_c2_b4;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b4;
		Real pk_yr_credit_first_seen2_mm_b1_c2_b4;
		Real pk_yr_header_first_seen2_mm_b1_c2_b4;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b4;
		Real pk_em_only_ver_lvl_mm_b1_c2_b4;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b4;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
		Real pk_nap_summary_mm_b1;
		Real pk_yr_gong_did_first_seen2_mm_b1;
		Real pk_add2_pos_secondary_sources_mm_b1;
		Real pk_nas_summary_mm_b1;
		Real pk_yr_infutor_first_seen2_mm_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b1;
		Real pk_combo_hphonescore_mm_b1;
		Real pk_lname_score_mm_b1;
		Real pk_yr_lname_change_date2_mm_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b1;
		Real pk_add2_em_ver_lvl_mm_b1;
		Real pk_yr_credit_first_seen2_mm_b1;
		Real pk_adl_score_mm_b1;
		Real pk_yr_header_first_seen2_mm_b1;
		Real pk_eq_count_mm_b1;
		Real pk_em_only_ver_lvl_mm_b1;
		Real pk_rc_dirsaddr_lastscore_mm_b1;
		Real pk_add1_address_score_mm_b1;
		Real pk_yr_adl_vo_first_seen2_mm_b1;
		Real pk_pos_secondary_sources_mm_b1;
		Real pk_combo_addrscore_mm_b1;
		Real pk_voter_flag_mm_b1;
		Real pk_combo_ssnscore_mm_b1;
		Real pk_add2_address_score_mm_b1;
		Real pk_add2_pos_sources_mm_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
		Real pk_fname_eda_sourced_type_lvl_mm_b1;
		Real pk_infutor_risk_lvl_mm_b1;
		Real pk_lname_eda_sourced_type_lvl_mm_b1;
		Real pk_nas_summary_mm_b2_c2_b1;
		Real pk_nap_summary_mm_b2_c2_b1;
		Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
		Real pk_adl_score_mm_b2_c2_b1;
		Real pk_lname_score_mm_b2_c2_b1;
		Real pk_combo_addrscore_mm_b2_c2_b1;
		Real pk_combo_hphonescore_mm_b2_c2_b1;
		Real pk_combo_ssnscore_mm_b2_c2_b1;
		Real pk_eq_count_mm_b2_c2_b1;
		Real pk_pos_secondary_sources_mm_b2_c2_b1;
		Real pk_voter_flag_mm_b2_c2_b1;
		Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
		Real pk_add1_address_score_mm_b2_c2_b1;
		Real pk_add2_address_score_mm_b2_c2_b1;
		Real pk_add2_pos_sources_mm_b2_c2_b1;
		Real pk_add2_pos_secondary_sources_mm_b2_c2_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
		Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
		Real pk_yr_lname_change_date2_mm_b2_c2_b1;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
		Real pk_yr_credit_first_seen2_mm_b2_c2_b1;
		Real pk_yr_header_first_seen2_mm_b2_c2_b1;

		Real pk_yr_infutor_first_seen2_mm_b2_c2_b1;
		Real pk_em_only_ver_lvl_mm_b2_c2_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
		Real pk_nas_summary_mm_b2_c2_b2;
		Real pk_nap_summary_mm_b2_c2_b2;
		Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
		Real pk_adl_score_mm_b2_c2_b2;
		Real pk_lname_score_mm_b2_c2_b2;
		Real pk_combo_addrscore_mm_b2_c2_b2;
		Real pk_combo_hphonescore_mm_b2_c2_b2;
		Real pk_combo_ssnscore_mm_b2_c2_b2;
		Real pk_eq_count_mm_b2_c2_b2;
		Real pk_pos_secondary_sources_mm_b2_c2_b2;
		Real pk_voter_flag_mm_b2_c2_b2;
		Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
		Real pk_add1_address_score_mm_b2_c2_b2;
		Real pk_add2_address_score_mm_b2_c2_b2;
		Real pk_add2_pos_sources_mm_b2_c2_b2;
		Real pk_add2_pos_secondary_sources_mm_b2_c2_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
		Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
		Real pk_yr_lname_change_date2_mm_b2_c2_b2;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
		Real pk_yr_credit_first_seen2_mm_b2_c2_b2;
		Real pk_yr_header_first_seen2_mm_b2_c2_b2;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b2;
		Real pk_em_only_ver_lvl_mm_b2_c2_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
		Real pk_nas_summary_mm_b2_c2_b3;
		Real pk_nap_summary_mm_b2_c2_b3;
		Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
		Real pk_adl_score_mm_b2_c2_b3;
		Real pk_lname_score_mm_b2_c2_b3;
		Real pk_combo_addrscore_mm_b2_c2_b3;
		Real pk_combo_hphonescore_mm_b2_c2_b3;
		Real pk_combo_ssnscore_mm_b2_c2_b3;
		Real pk_eq_count_mm_b2_c2_b3;
		Real pk_pos_secondary_sources_mm_b2_c2_b3;
		Real pk_voter_flag_mm_b2_c2_b3;
		Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
		Real pk_add1_address_score_mm_b2_c2_b3;
		Real pk_add2_address_score_mm_b2_c2_b3;
		Real pk_add2_pos_sources_mm_b2_c2_b3;
		Real pk_add2_pos_secondary_sources_mm_b2_c2_b3;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
		Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b3;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
		Real pk_yr_lname_change_date2_mm_b2_c2_b3;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
		Real pk_yr_credit_first_seen2_mm_b2_c2_b3;
		Real pk_yr_header_first_seen2_mm_b2_c2_b3;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b3;
		Real pk_em_only_ver_lvl_mm_b2_c2_b3;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
		Real pk_nas_summary_mm_b2_c2_b4;
		Real pk_nap_summary_mm_b2_c2_b4;
		Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b4;
		Real pk_adl_score_mm_b2_c2_b4;
		Real pk_lname_score_mm_b2_c2_b4;
		Real pk_combo_addrscore_mm_b2_c2_b4;
		Real pk_combo_hphonescore_mm_b2_c2_b4;
		Real pk_combo_ssnscore_mm_b2_c2_b4;
		Real pk_eq_count_mm_b2_c2_b4;
		Real pk_pos_secondary_sources_mm_b2_c2_b4;
		Real pk_voter_flag_mm_b2_c2_b4;
		Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b4;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4;
		Real pk_add1_address_score_mm_b2_c2_b4;
		Real pk_add2_address_score_mm_b2_c2_b4;
		Real pk_add2_pos_sources_mm_b2_c2_b4;
		Real pk_add2_pos_secondary_sources_mm_b2_c2_b4;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b4;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b4;
		Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b4;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4;
		Real pk_yr_lname_change_date2_mm_b2_c2_b4;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b4;
		Real pk_yr_credit_first_seen2_mm_b2_c2_b4;
		Real pk_yr_header_first_seen2_mm_b2_c2_b4;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b4;
		Real pk_em_only_ver_lvl_mm_b2_c2_b4;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
		Real pk_nap_summary_mm_b2;
		Real pk_yr_gong_did_first_seen2_mm_b2;
		Real pk_add2_pos_secondary_sources_mm_b2;
		Real pk_nas_summary_mm_b2;
		Real pk_yr_infutor_first_seen2_mm_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b2;
		Real pk_combo_hphonescore_mm_b2;
		Real pk_lname_score_mm_b2;
		Real pk_yr_lname_change_date2_mm_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b2;
		Real pk_infutor_risk_lvl_nb_mm_b2;
		Real pk_yr_credit_first_seen2_mm_b2;
		Real pk_adl_score_mm_b2;
		Real pk_yr_header_first_seen2_mm_b2;
		Real pk_eq_count_mm_b2;
		Real pk_em_only_ver_lvl_mm_b2;
		Real pk_rc_dirsaddr_lastscore_mm_b2;
		Real pk_add1_address_score_mm_b2;
		Real pk_yr_adl_vo_first_seen2_mm_b2;
		Real pk_pos_secondary_sources_mm_b2;
		Real pk_combo_addrscore_mm_b2;
		Real pk_voter_flag_mm_b2;
		Real pk_combo_ssnscore_mm_b2;
		Real pk_add2_address_score_mm_b2;
		Real pk_add2_pos_sources_mm_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
		Real pk_fname_eda_sourced_type_lvl_mm_b2;
		Real pk_lname_eda_sourced_type_lvl_mm_b2;
		Real pk_nap_summary_mm;
		Real pk_yr_gong_did_first_seen2_mm;
		Real pk_add2_pos_secondary_sources_mm;
		Real pk_nas_summary_mm;
		Real pk_yr_infutor_first_seen2_mm;
		Real pk_yr_adl_em_only_first_seen2_mm;
		Real pk_combo_hphonescore_mm;
		Real pk_lname_score_mm;
		Real pk_yr_lname_change_date2_mm;
		Real pk_ssnchar_invalid_or_recent_mm;
		Real pk_infutor_risk_lvl_nb_mm;
		Real pk_add2_em_ver_lvl_mm;
		Real pk_yr_credit_first_seen2_mm;
		Real pk_adl_score_mm;
		Real pk_yr_header_first_seen2_mm;
		Real pk_eq_count_mm;
		Real pk_em_only_ver_lvl_mm;
		Real pk_rc_dirsaddr_lastscore_mm;
		Real pk_add1_address_score_mm;
		Real pk_yr_adl_vo_first_seen2_mm;
		Real pk_pos_secondary_sources_mm;
		Real pk_combo_addrscore_mm;
		Real pk_voter_flag_mm;
		Real pk_combo_ssnscore_mm;
		Real pk_add2_address_score_mm;
		Real pk_add2_pos_sources_mm;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm;
		Real pk_fname_eda_sourced_type_lvl_mm;
		Real pk_infutor_risk_lvl_mm;
		Real pk_lname_eda_sourced_type_lvl_mm;
		Real pk_estimated_income_mm_b1;
		Real pk_yr_adl_w_last_seen2_mm_b1;
		Real pk_pr_count_mm_b1;
		Real pk_addrs_sourced_lvl_mm_b1;
		Real pk_add1_own_level_mm_b1;
		Real pk_add2_own_level_mm_b1;
		Real pk_add3_own_level_mm_b1;
		Real pk_naprop_level2_mm_b1;
		Real pk_yr_add1_built_date2_mm_b1;
		Real pk_add1_purchase_amount2_mm_b1;
		Real pk_yr_add1_mortgage_date2_mm_b1;
		Real pk_add1_mortgage_risk_mm_b1;
		Real pk_add1_assessed_amount2_mm_b1;
		Real pk_yr_add1_mortgage_due_date2_mm_b1;
		Real pk_yr_add1_date_first_seen2_mm_b1;
		Real pk_add1_land_use_risk_level_mm_b1;
		Real pk_add1_building_area2_mm_b1;
		Real pk_property_owned_total_mm_b1;
		Real pk_prop_own_assess_tot2_mm_b1;
		Real pk_prop1_sale_price2_mm_b1;
		Real pk_yr_prop2_sale_date2_mm_b1;
		Real pk_add2_no_of_buildings_mm_b1;
		Real pk_add2_parking_no_of_cars_mm_b1;
		Real pk_add2_mortgage_risk_mm_b1;
		Real pk_add2_assessed_amount2_mm_b1;
		Real pk_yr_add2_date_first_seen2_mm_b1;
		Real pk_yr_add2_date_last_seen2_mm_b1;
		Real pk_add3_mortgage_risk_mm_b1;
		Real pk_add3_assessed_amount2_mm_b1;
		Real pk_yr_add3_date_first_seen2_mm_b1;
		Real pk_watercraft_count_mm_b1;
		Real pk_bk_level_mm_b1;
		Real pk_eviction_level_mm_b1;
		Real pk_lien_type_level_mm_b1;
		Real pk_yr_liens_last_unrel_date3_mm_b1;
		Real pk_yr_ln_unrel_lt_f_sn2_mm_b1;
		Real pk_yr_ln_unrel_ot_f_sn2_mm_b1;
		Real pk_crime_level_mm_b1;
		Real pk_attr_total_number_derogs_mm_b1;
		Real pk_yr_rc_ssnhighissue2_mm_b1;
		Real pk_prof_lic_cat_mm_b1;
		Real pk_add1_lres_mm_b1;
		Real pk_add2_lres_mm_b1;
		Real pk_add3_lres_mm_b1;
		Real pk_addrs_5yr_mm_b1;
		Real pk_addrs_15yr_mm_b1;
		Real pk_add_lres_month_avg2_mm_b1;
		Real pk_nameperssn_count_mm_b1;
		Real pk_ssns_per_adl_mm_b1;
		Real pk_addrs_per_adl_mm_b1;
		Real pk_phones_per_adl_mm_b1;
		Real pk_adlperssn_count_mm_b1;
		Real pk_addrs_per_ssn_mm_b1;
		Real pk_adls_per_addr_mm_b1;
		Real pk_phones_per_addr_mm_b1;
		Real pk_adls_per_phone_mm_b1;
		Real pk_ssns_per_adl_c6_mm_b1;
		Real pk_addrs_per_adl_c6_mm_b1;
		Real pk_phones_per_adl_c6_mm_b1;
		Real pk_ssns_per_addr_c6_mm_b1;
		Real pk_phones_per_addr_c6_mm_b1;
		Real pk_adls_per_phone_c6_mm_b1;
		Real pk_attr_addrs_last24_mm_b1;
		Real pk_attr_addrs_last36_mm_b1;
		Real pk_ams_class_level_mm_b1;
		Real pk_ams_income_level_code_mm_b1;
		Real pk_college_tier_mm_b1;
		Real pk_ams_age_mm_b1;
		Real pk_inferred_age_mm_b1;
		Real pk_yr_reported_dob2_mm_b1;
		Real pk_avm_hit_level_mm_b1;
		Real pk_avm_auto_diff4_lvl_mm_b1;
		Real pk_add2_avm_auto_diff3_lvl_mm_b1;
		Real pk2_add1_avm_as_mm_b1;
		Real pk2_add1_avm_mkt_mm_b1;
		Real pk2_add1_avm_hed_mm_b1;
		Real pk2_add1_avm_auto_mm_b1;
		Real pk2_add1_avm_auto2_mm_b1;
		Real pk2_add1_avm_auto3_mm_b1;
		Real pk2_add1_avm_auto4_mm_b1;
		Real pk2_add1_avm_med_mm_b1;
		Real pk2_add1_avm_to_med_ratio_mm_b1;
		Real pk2_add2_avm_sp_mm_b1;
		Real pk2_add2_avm_mkt_mm_b1;
		Real pk2_add2_avm_hed_mm_b1;
		Real pk2_add2_avm_auto_mm_b1;
		Real pk2_add2_avm_auto3_mm_b1;
		Real pk2_add2_avm_auto4_mm_b1;
		Real pk2_yr_add1_avm_rec_dt_mm_b1;
		Real pk2_yr_add1_avm_assess_year_mm_b1;
		Real pk_dist_a1toa2_mm_b1;
		Real pk_dist_a1toa3_mm_b1;
		Real pk_rc_disthphoneaddr_mm_b1;
		Real pk_out_st_division_lvl_mm_b1;
		Real pk_wealth_index_mm_b1;
		Real pk_impulse_count_mm_b1;
		Real pk_attr_num_nonderogs90_b_mm_b1;
		Real pk_ssns_per_addr2_mm_b1;
		Real pk_yr_add2_assess_val_yr2_mm_b1;
		Real pk_estimated_income_mm_b2;
		Real pk_yr_adl_w_last_seen2_mm_b2;
		Real pk_pr_count_mm_b2;
		Real pk_addrs_sourced_lvl_mm_b2;
		Real pk_add1_own_level_mm_b2;
		Real pk_add2_own_level_mm_b2;
		Real pk_add3_own_level_mm_b2;
		Real pk_naprop_level2_mm_b2;
		Real pk_yr_add1_built_date2_mm_b2;
		Real pk_add1_purchase_amount2_mm_b2;
		Real pk_yr_add1_mortgage_date2_mm_b2;
		Real pk_add1_mortgage_risk_mm_b2;
		Real pk_add1_assessed_amount2_mm_b2;
		Real pk_yr_add1_mortgage_due_date2_mm_b2;
		Real pk_yr_add1_date_first_seen2_mm_b2;
		Real pk_add1_land_use_risk_level_mm_b2;
		Real pk_add1_building_area2_mm_b2;
		Real pk_property_owned_total_mm_b2;
		Real pk_prop_own_assess_tot2_mm_b2;
		Real pk_prop1_sale_price2_mm_b2;
		Real pk_yr_prop2_sale_date2_mm_b2;
		Real pk_add2_no_of_buildings_mm_b2;
		Real pk_add2_parking_no_of_cars_mm_b2;
		Real pk_add2_mortgage_risk_mm_b2;
		Real pk_add2_assessed_amount2_mm_b2;
		Real pk_yr_add2_date_first_seen2_mm_b2;
		Real pk_yr_add2_date_last_seen2_mm_b2;
		Real pk_add3_mortgage_risk_mm_b2;
		Real pk_add3_assessed_amount2_mm_b2;
		Real pk_yr_add3_date_first_seen2_mm_b2;
		Real pk_watercraft_count_mm_b2;
		Real pk_bk_level_mm_b2;
		Real pk_eviction_level_mm_b2;
		Real pk_lien_type_level_mm_b2;
		Real pk_yr_liens_last_unrel_date3_mm_b2;
		Real pk_yr_ln_unrel_lt_f_sn2_mm_b2;
		Real pk_yr_ln_unrel_ot_f_sn2_mm_b2;
		Real pk_crime_level_mm_b2;
		Real pk_attr_total_number_derogs_mm_b2;
		Real pk_yr_rc_ssnhighissue2_mm_b2;
		Real pk_prof_lic_cat_mm_b2;
		Real pk_add1_lres_mm_b2;
		Real pk_add2_lres_mm_b2;
		Real pk_add3_lres_mm_b2;
		Real pk_addrs_5yr_mm_b2;
		Real pk_addrs_15yr_mm_b2;
		Real pk_add_lres_month_avg2_mm_b2;
		Real pk_nameperssn_count_mm_b2;
		Real pk_ssns_per_adl_mm_b2;
		Real pk_addrs_per_adl_mm_b2;
		Real pk_phones_per_adl_mm_b2;
		Real pk_adlperssn_count_mm_b2;
		Real pk_addrs_per_ssn_mm_b2;
		Real pk_adls_per_addr_mm_b2;
		Real pk_phones_per_addr_mm_b2;
		Real pk_adls_per_phone_mm_b2;
		Real pk_ssns_per_adl_c6_mm_b2;
		Real pk_addrs_per_adl_c6_mm_b2;
		Real pk_phones_per_adl_c6_mm_b2;
		Real pk_ssns_per_addr_c6_mm_b2;
		Real pk_phones_per_addr_c6_mm_b2;
		Real pk_adls_per_phone_c6_mm_b2;
		Real pk_attr_addrs_last24_mm_b2;
		Real pk_attr_addrs_last36_mm_b2;
		Real pk_ams_class_level_mm_b2;
		Real pk_ams_income_level_code_mm_b2;
		Real pk_college_tier_mm_b2;
		Real pk_ams_age_mm_b2;
		Real pk_inferred_age_mm_b2;
		Real pk_yr_reported_dob2_mm_b2;
		Real pk_avm_hit_level_mm_b2;
		Real pk_avm_auto_diff4_lvl_mm_b2;
		Real pk_add2_avm_auto_diff3_lvl_mm_b2;
		Real pk2_add1_avm_as_mm_b2;
		Real pk2_add1_avm_mkt_mm_b2;
		Real pk2_add1_avm_hed_mm_b2;
		Real pk2_add1_avm_auto_mm_b2;
		Real pk2_add1_avm_auto2_mm_b2;
		Real pk2_add1_avm_auto3_mm_b2;
		Real pk2_add1_avm_auto4_mm_b2;
		Real pk2_add1_avm_med_mm_b2;
		Real pk2_add1_avm_to_med_ratio_mm_b2;
		Real pk2_add2_avm_sp_mm_b2;
		Real pk2_add2_avm_mkt_mm_b2;
		Real pk2_add2_avm_hed_mm_b2;
		Real pk2_add2_avm_auto_mm_b2;
		Real pk2_add2_avm_auto3_mm_b2;
		Real pk2_add2_avm_auto4_mm_b2;
		Real pk2_yr_add1_avm_rec_dt_mm_b2;
		Real pk2_yr_add1_avm_assess_year_mm_b2;
		Real pk_dist_a1toa2_mm_b2;
		Real pk_dist_a1toa3_mm_b2;
		Real pk_rc_disthphoneaddr_mm_b2;
		Real pk_out_st_division_lvl_mm_b2;
		Real pk_wealth_index_mm_b2;
		Real pk_impulse_count_mm_b2;
		Real pk_attr_num_nonderogs90_b_mm_b2;
		Real pk_ssns_per_addr2_mm_b2;
		Real pk_yr_add2_assess_val_yr2_mm_b2;
		Real pk_estimated_income_mm_b3;
		Real pk_yr_adl_w_last_seen2_mm_b3;
		Real pk_pr_count_mm_b3;
		Real pk_addrs_sourced_lvl_mm_b3;
		Real pk_add1_own_level_mm_b3;
		Real pk_add2_own_level_mm_b3;
		Real pk_add3_own_level_mm_b3;
		Real pk_naprop_level2_mm_b3;
		Real pk_yr_add1_built_date2_mm_b3;
		Real pk_add1_purchase_amount2_mm_b3;
		Real pk_yr_add1_mortgage_date2_mm_b3;
		Real pk_add1_mortgage_risk_mm_b3;
		Real pk_add1_assessed_amount2_mm_b3;
		Real pk_yr_add1_mortgage_due_date2_mm_b3;
		Real pk_yr_add1_date_first_seen2_mm_b3;
		Real pk_add1_land_use_risk_level_mm_b3;
		Real pk_add1_building_area2_mm_b3;
		Real pk_property_owned_total_mm_b3;
		Real pk_prop_own_assess_tot2_mm_b3;
		Real pk_prop1_sale_price2_mm_b3;
		Real pk_yr_prop2_sale_date2_mm_b3;
		Real pk_add2_no_of_buildings_mm_b3;
		Real pk_add2_parking_no_of_cars_mm_b3;
		Real pk_add2_mortgage_risk_mm_b3;
		Real pk_add2_assessed_amount2_mm_b3;
		Real pk_yr_add2_date_first_seen2_mm_b3;
		Real pk_yr_add2_date_last_seen2_mm_b3;
		Real pk_add3_mortgage_risk_mm_b3;
		Real pk_add3_assessed_amount2_mm_b3;
		Real pk_yr_add3_date_first_seen2_mm_b3;
		Real pk_watercraft_count_mm_b3;
		Real pk_bk_level_mm_b3;
		Real pk_eviction_level_mm_b3;
		Real pk_lien_type_level_mm_b3;
		Real pk_yr_liens_last_unrel_date3_mm_b3;
		Real pk_yr_ln_unrel_lt_f_sn2_mm_b3;
		Real pk_yr_ln_unrel_ot_f_sn2_mm_b3;
		Real pk_crime_level_mm_b3;
		Real pk_attr_total_number_derogs_mm_b3;
		Real pk_yr_rc_ssnhighissue2_mm_b3;
		Real pk_prof_lic_cat_mm_b3;
		Real pk_add1_lres_mm_b3;
		Real pk_add2_lres_mm_b3;
		Real pk_add3_lres_mm_b3;
		Real pk_addrs_5yr_mm_b3;
		Real pk_addrs_15yr_mm_b3;
		Real pk_add_lres_month_avg2_mm_b3;
		Real pk_nameperssn_count_mm_b3;
		Real pk_ssns_per_adl_mm_b3;
		Real pk_addrs_per_adl_mm_b3;
		Real pk_phones_per_adl_mm_b3;
		Real pk_adlperssn_count_mm_b3;
		Real pk_addrs_per_ssn_mm_b3;
		Real pk_adls_per_addr_mm_b3;
		Real pk_phones_per_addr_mm_b3;
		Real pk_adls_per_phone_mm_b3;
		Real pk_ssns_per_adl_c6_mm_b3;
		Real pk_addrs_per_adl_c6_mm_b3;
		Real pk_phones_per_adl_c6_mm_b3;
		Real pk_ssns_per_addr_c6_mm_b3;
		Real pk_phones_per_addr_c6_mm_b3;
		Real pk_adls_per_phone_c6_mm_b3;
		Real pk_attr_addrs_last24_mm_b3;
		Real pk_attr_addrs_last36_mm_b3;
		Real pk_ams_class_level_mm_b3;
		Real pk_ams_income_level_code_mm_b3;
		Real pk_college_tier_mm_b3;
		Real pk_ams_age_mm_b3;
		Real pk_inferred_age_mm_b3;
		Real pk_yr_reported_dob2_mm_b3;
		Real pk_avm_hit_level_mm_b3;
		Real pk_avm_auto_diff4_lvl_mm_b3;
		Real pk_add2_avm_auto_diff3_lvl_mm_b3;
		Real pk2_add1_avm_as_mm_b3;
		Real pk2_add1_avm_mkt_mm_b3;
		Real pk2_add1_avm_hed_mm_b3;
		Real pk2_add1_avm_auto_mm_b3;
		Real pk2_add1_avm_auto2_mm_b3;
		Real pk2_add1_avm_auto3_mm_b3;
		Real pk2_add1_avm_auto4_mm_b3;
		Real pk2_add1_avm_med_mm_b3;
		Real pk2_add1_avm_to_med_ratio_mm_b3;
		Real pk2_add2_avm_sp_mm_b3;
		Real pk2_add2_avm_mkt_mm_b3;
		Real pk2_add2_avm_hed_mm_b3;
		Real pk2_add2_avm_auto_mm_b3;
		Real pk2_add2_avm_auto3_mm_b3;
		Real pk2_add2_avm_auto4_mm_b3;
		Real pk2_yr_add1_avm_rec_dt_mm_b3;
		Real pk2_yr_add1_avm_assess_year_mm_b3;
		Real pk_dist_a1toa2_mm_b3;
		Real pk_dist_a1toa3_mm_b3;
		Real pk_rc_disthphoneaddr_mm_b3;
		Real pk_out_st_division_lvl_mm_b3;
		Real pk_wealth_index_mm_b3;
		Real pk_impulse_count_mm_b3;
		Real pk_attr_num_nonderogs90_b_mm_b3;
		Real pk_ssns_per_addr2_mm_b3;
		Real pk_yr_add2_assess_val_yr2_mm_b3;
		Real pk_estimated_income_mm_b4;
		Real pk_yr_adl_w_last_seen2_mm_b4;
		Real pk_pr_count_mm_b4;
		Real pk_addrs_sourced_lvl_mm_b4;
		Real pk_add1_own_level_mm_b4;
		Real pk_add2_own_level_mm_b4;
		Real pk_add3_own_level_mm_b4;
		Real pk_naprop_level2_mm_b4;
		Real pk_yr_add1_built_date2_mm_b4;
		Real pk_add1_purchase_amount2_mm_b4;
		Real pk_yr_add1_mortgage_date2_mm_b4;
		Real pk_add1_mortgage_risk_mm_b4;
		Real pk_add1_assessed_amount2_mm_b4;
		Real pk_yr_add1_mortgage_due_date2_mm_b4;
		Real pk_yr_add1_date_first_seen2_mm_b4;
		Real pk_add1_land_use_risk_level_mm_b4;
		Real pk_add1_building_area2_mm_b4;
		Real pk_property_owned_total_mm_b4;
		Real pk_prop_own_assess_tot2_mm_b4;
		Real pk_prop1_sale_price2_mm_b4;
		Real pk_yr_prop2_sale_date2_mm_b4;
		Real pk_add2_no_of_buildings_mm_b4;
		Real pk_add2_parking_no_of_cars_mm_b4;
		Real pk_add2_mortgage_risk_mm_b4;
		Real pk_add2_assessed_amount2_mm_b4;
		Real pk_yr_add2_date_first_seen2_mm_b4;
		Real pk_yr_add2_date_last_seen2_mm_b4;
		Real pk_add3_mortgage_risk_mm_b4;
		Real pk_add3_assessed_amount2_mm_b4;
		Real pk_yr_add3_date_first_seen2_mm_b4;
		Real pk_watercraft_count_mm_b4;
		Real pk_bk_level_mm_b4;
		Real pk_eviction_level_mm_b4;
		Real pk_lien_type_level_mm_b4;
		Real pk_yr_liens_last_unrel_date3_mm_b4;
		Real pk_yr_ln_unrel_lt_f_sn2_mm_b4;
		Real pk_yr_ln_unrel_ot_f_sn2_mm_b4;
		Real pk_crime_level_mm_b4;
		Real pk_attr_total_number_derogs_mm_b4;
		Real pk_yr_rc_ssnhighissue2_mm_b4;
		Real pk_prof_lic_cat_mm_b4;
		Real pk_add1_lres_mm_b4;
		Real pk_add2_lres_mm_b4;
		Real pk_add3_lres_mm_b4;
		Real pk_addrs_5yr_mm_b4;
		Real pk_addrs_15yr_mm_b4;
		Real pk_add_lres_month_avg2_mm_b4;
		Real pk_nameperssn_count_mm_b4;
		Real pk_ssns_per_adl_mm_b4;
		Real pk_addrs_per_adl_mm_b4;
		Real pk_phones_per_adl_mm_b4;
		Real pk_adlperssn_count_mm_b4;
		Real pk_addrs_per_ssn_mm_b4;
		Real pk_adls_per_addr_mm_b4;
		Real pk_phones_per_addr_mm_b4;
		Real pk_adls_per_phone_mm_b4;
		Real pk_ssns_per_adl_c6_mm_b4;
		Real pk_addrs_per_adl_c6_mm_b4;
		Real pk_phones_per_adl_c6_mm_b4;
		Real pk_ssns_per_addr_c6_mm_b4;
		Real pk_phones_per_addr_c6_mm_b4;
		Real pk_adls_per_phone_c6_mm_b4;
		Real pk_attr_addrs_last24_mm_b4;
		Real pk_attr_addrs_last36_mm_b4;
		Real pk_ams_class_level_mm_b4;
		Real pk_ams_income_level_code_mm_b4;
		Real pk_college_tier_mm_b4;
		Real pk_ams_age_mm_b4;
		Real pk_inferred_age_mm_b4;
		Real pk_yr_reported_dob2_mm_b4;
		Real pk_avm_hit_level_mm_b4;
		Real pk_avm_auto_diff4_lvl_mm_b4;
		Real pk_add2_avm_auto_diff3_lvl_mm_b4;
		Real pk2_add1_avm_as_mm_b4;
		Real pk2_add1_avm_mkt_mm_b4;
		Real pk2_add1_avm_hed_mm_b4;
		Real pk2_add1_avm_auto_mm_b4;
		Real pk2_add1_avm_auto2_mm_b4;
		Real pk2_add1_avm_auto3_mm_b4;
		Real pk2_add1_avm_auto4_mm_b4;
		Real pk2_add1_avm_med_mm_b4;
		Real pk2_add1_avm_to_med_ratio_mm_b4;
		Real pk2_add2_avm_sp_mm_b4;
		Real pk2_add2_avm_mkt_mm_b4;
		Real pk2_add2_avm_hed_mm_b4;
		Real pk2_add2_avm_auto_mm_b4;
		Real pk2_add2_avm_auto3_mm_b4;
		Real pk2_add2_avm_auto4_mm_b4;
		Real pk2_yr_add1_avm_rec_dt_mm_b4;
		Real pk2_yr_add1_avm_assess_year_mm_b4;
		Real pk_dist_a1toa2_mm_b4;
		Real pk_dist_a1toa3_mm_b4;
		Real pk_rc_disthphoneaddr_mm_b4;
		Real pk_out_st_division_lvl_mm_b4;
		Real pk_wealth_index_mm_b4;
		Real pk_impulse_count_mm_b4;
		Real pk_attr_num_nonderogs90_b_mm_b4;
		Real pk_ssns_per_addr2_mm_b4;
		Real pk_yr_add2_assess_val_yr2_mm_b4;
		Real pk_prop_own_assess_tot2_mm;
		Real pk_yr_add1_date_first_seen2_mm;
		Real pk_attr_addrs_last36_mm;
		Real pk2_add2_avm_mkt_mm;
		Real pk_nameperssn_count_mm;
		Real pk_add1_purchase_amount2_mm;
		Real pk_adls_per_phone_mm;
		Real pk_ssns_per_addr2_mm;
		Real pk_property_owned_total_mm;
		Real pk_ams_class_level_mm;
		Real pk_adls_per_phone_c6_mm;
		Real pk_yr_add2_date_first_seen2_mm;
		Real pk_adlperssn_count_mm;
		Real pk2_add2_avm_auto_mm;
		Real pk2_add2_avm_hed_mm;
		Real pk_avm_auto_diff4_lvl_mm;
		Real pk_yr_add3_date_first_seen2_mm;
		Real pk_add1_land_use_risk_level_mm;
		Real pk_add2_avm_auto_diff3_lvl_mm;
		Real pk_add2_own_level_mm;
		Real pk_addrs_per_ssn_mm;
		Real pk_add2_lres_mm;
		Real pk_addrs_sourced_lvl_mm;
		Real pk_add_lres_month_avg2_mm;
		Real pk_rc_disthphoneaddr_mm;
		Real pk_add1_lres_mm;
		Real pk_attr_total_number_derogs_mm;
		Real pk_addrs_per_adl_c6_mm;
		Real pk2_add2_avm_sp_mm;
		Real pk_addrs_per_adl_mm;
		Real pk_naprop_level2_mm;
		Real pk2_add1_avm_auto3_mm;
		Real pk2_add1_avm_mkt_mm;
		Real pk_yr_reported_dob2_mm;
		Real pk_prop1_sale_price2_mm;
		Real pk2_add1_avm_auto4_mm;
		Real pk_college_tier_mm;
		Real pk_ssns_per_adl_mm;
		Real pk_yr_adl_w_last_seen2_mm;
		Real pk_ams_income_level_code_mm;
		Real pk_yr_ln_unrel_ot_f_sn2_mm;
		Real pk_add1_building_area2_mm;
		Real pk_pr_count_mm;
		Real pk2_add1_avm_as_mm;
		Real pk_inferred_age_mm;
		Real pk2_yr_add1_avm_assess_year_mm;
		Real pk_out_st_division_lvl_mm;
		Real pk_yr_rc_ssnhighissue2_mm;
		Real pk_watercraft_count_mm;
		Real pk_phones_per_adl_mm;
		Real pk2_add1_avm_auto2_mm;
		Real pk_ssns_per_addr_c6_mm;
		Real pk_yr_ln_unrel_lt_f_sn2_mm;
		Real pk2_add1_avm_hed_mm;
		Real pk2_yr_add1_avm_rec_dt_mm;
		Real pk_add1_mortgage_risk_mm;
		Real pk_yr_add2_assess_val_yr2_mm;
		Real pk_add2_assessed_amount2_mm;
		Real pk_prof_lic_cat_mm;
		Real pk_dist_a1toa3_mm;
		Real pk_eviction_level_mm;
		Real pk_attr_num_nonderogs90_b_mm;
		Real pk_add3_own_level_mm;
		Real pk_adls_per_addr_mm;
		Real pk_ssns_per_adl_c6_mm;
		Real pk_attr_addrs_last24_mm;
		Real pk_yr_add2_date_last_seen2_mm;
		Real pk_add3_mortgage_risk_mm;
		Real pk_add2_parking_no_of_cars_mm;
		Real pk2_add1_avm_med_mm;
		Real pk_impulse_count_mm;
		Real pk_add2_no_of_buildings_mm;
		Real pk_yr_add1_mortgage_date2_mm;
		Real pk_crime_level_mm;
		Real pk_addrs_15yr_mm;
		Real pk_avm_hit_level_mm;
		Real pk_bk_level_mm;
		Real pk_wealth_index_mm;
		Real pk2_add1_avm_to_med_ratio_mm;
		Real pk2_add1_avm_auto_mm;
		Real pk_add1_assessed_amount2_mm;
		Real pk_add3_lres_mm;
		Real pk_ams_age_mm;
		Real pk_yr_prop2_sale_date2_mm;
		Real pk_estimated_income_mm;
		Real pk_yr_add1_mortgage_due_date2_mm;
		Real pk_add2_mortgage_risk_mm;
		Real pk_dist_a1toa2_mm;
		Real pk_add1_own_level_mm;
		Real pk2_add2_avm_auto4_mm;
		Real pk_add3_assessed_amount2_mm;
		Real pk_yr_add1_built_date2_mm;
		Real pk_addrs_5yr_mm;
		Real pk_phones_per_addr_mm;
		Real pk_lien_type_level_mm;
		Real pk2_add2_avm_auto3_mm;
		Real pk_phones_per_adl_c6_mm;
		Real pk_phones_per_addr_c6_mm;
		Real pk_yr_liens_last_unrel_date3_mm;
		Real segment_mean;
		Real pk_add_lres_month_avg2_mm_2;
		Real pk_add1_address_score_mm_2;
		Real pk_add1_assessed_amount2_mm_2;
		Real pk_add1_building_area2_mm_2;
		Real pk_add1_land_use_risk_level_mm_2;
		Real pk_add1_lres_mm_2;
		Real pk_add1_mortgage_risk_mm_2;
		Real pk_add1_own_level_mm_2;
		Real pk_add1_purchase_amount2_mm_2;
		Real pk_add2_address_score_mm_2;
		Real pk_add2_assessed_amount2_mm_2;
		Real pk_add2_avm_auto_diff3_lvl_mm_2;
		Real pk_add2_em_ver_lvl_mm_2;
		Real pk_add2_lres_mm_2;
		Real pk_add2_mortgage_risk_mm_2;
		Real pk_add2_no_of_buildings_mm_2;
		Real pk_add2_own_level_mm_2;
		Real pk_add2_parking_no_of_cars_mm_2;
		Real pk_add2_pos_secondary_sources_mm_2;
		Real pk_add2_pos_sources_mm_2;
		Real pk_add3_assessed_amount2_mm_2;
		Real pk_add3_lres_mm_2;
		Real pk_add3_mortgage_risk_mm_2;
		Real pk_add3_own_level_mm_2;
		Real pk_addrs_15yr_mm_2;
		Real pk_addrs_5yr_mm_2;
		Real pk_addrs_per_adl_c6_mm_2;
		Real pk_addrs_per_adl_mm_2;
		Real pk_addrs_per_ssn_mm_2;
		Real pk_addrs_sourced_lvl_mm_2;
		Real pk_adl_score_mm_2;
		Real pk_adlperssn_count_mm_2;
		Real pk_adls_per_addr_mm_2;
		Real pk_adls_per_phone_c6_mm_2;
		Real pk_adls_per_phone_mm_2;
		Real pk_ams_age_mm_2;
		Real pk_ams_class_level_mm_2;
		Real pk_ams_income_level_code_mm_2;
		Real pk_attr_addrs_last24_mm_2;
		Real pk_attr_addrs_last36_mm_2;
		Real pk_attr_num_nonderogs90_b_mm_2;
		Real pk_attr_total_number_derogs_mm_2;
		Real pk_avm_auto_diff4_lvl_mm_2;
		Real pk_avm_hit_level_mm_2;
		Real pk_bk_level_mm_2;
		Real pk_college_tier_mm_2;
		Real pk_combo_addrscore_mm_2;
		Real pk_combo_hphonescore_mm_2;
		Real pk_combo_ssnscore_mm_2;
		Real pk_crime_level_mm_2;
		Real pk_dist_a1toa2_mm_2;
		Real pk_dist_a1toa3_mm_2;
		Real pk_em_only_ver_lvl_mm_2;
		Real pk_eq_count_mm_2;
		Real pk_estimated_income_mm_2;
		Real pk_eviction_level_mm_2;
		Real pk_fname_eda_sourced_type_lvl_mm_2;
		Real pk_impulse_count_mm_2;
		Real pk_inferred_age_mm_2;
		Real pk_infutor_risk_lvl_mm_2;
		Real pk_infutor_risk_lvl_nb_mm_2;
		Real pk_lien_type_level_mm_2;
		Real pk_lname_eda_sourced_type_lvl_mm_2;
		Real pk_lname_score_mm_2;
		Real pk_nameperssn_count_mm_2;
		Real pk_nap_summary_mm_2;
		Real pk_naprop_level2_mm_2;
		Real pk_nas_summary_mm_2;
		Real pk_out_st_division_lvl_mm_2;
		Real pk_phones_per_addr_c6_mm_2;
		Real pk_phones_per_addr_mm_2;
		Real pk_phones_per_adl_c6_mm_2;
		Real pk_phones_per_adl_mm_2;
		Real pk_pos_secondary_sources_mm_2;
		Real pk_pr_count_mm_2;
		Real pk_prof_lic_cat_mm_2;
		Real pk_prop_own_assess_tot2_mm_2;
		Real pk_prop1_sale_price2_mm_2;
		Real pk_property_owned_total_mm_2;
		Real pk_rc_dirsaddr_lastscore_mm_2;
		Real pk_rc_disthphoneaddr_mm_2;
		Real pk_ssnchar_invalid_or_recent_mm_2;
		Real pk_ssns_per_addr_c6_mm_2;
		Real pk_ssns_per_addr2_mm_2;
		Real pk_ssns_per_adl_c6_mm_2;
		Real pk_ssns_per_adl_mm_2;
		Real pk_voter_flag_mm_2;
		Real pk_watercraft_count_mm_2;
		Real pk_wealth_index_mm_2;
		Real pk_yr_add1_built_date2_mm_2;
		Real pk_yr_add1_date_first_seen2_mm_2;
		Real pk_yr_add1_mortgage_date2_mm_2;
		Real pk_yr_add1_mortgage_due_date2_mm_2;
		Real pk_yr_add2_assess_val_yr2_mm_2;
		Real pk_yr_add2_date_first_seen2_mm_2;
		Real pk_yr_add2_date_last_seen2_mm_2;
		Real pk_yr_add3_date_first_seen2_mm_2;
		Real pk_yr_adl_em_only_first_seen2_mm_2;
		Real pk_yr_adl_vo_first_seen2_mm_2;
		Real pk_yr_adl_w_last_seen2_mm_2;
		Real pk_yr_credit_first_seen2_mm_2;
		Real pk_yr_gong_did_first_seen2_mm_2;
		Real pk_yr_header_first_seen2_mm_2;
		Real pk_yr_infutor_first_seen2_mm_2;
		Real pk_yr_liens_last_unrel_date3_mm_2;
		Real pk_yr_ln_unrel_lt_f_sn2_mm_2;
		Real pk_yr_ln_unrel_ot_f_sn2_mm_2;
		Real pk_yr_lname_change_date2_mm_2;
		Real pk_yr_prop2_sale_date2_mm_2;
		Real pk_yr_rc_ssnhighissue2_mm_2;
		Real pk_yr_reported_dob2_mm_2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
		Real pk2_add1_avm_as_mm_2;
		Real pk2_add1_avm_auto_mm_2;
		Real pk2_add1_avm_auto2_mm_2;
		Real pk2_add1_avm_auto3_mm_2;
		Real pk2_add1_avm_auto4_mm_2;
		Real pk2_add1_avm_hed_mm_2;
		Real pk2_add1_avm_med_mm_2;
		Real pk2_add1_avm_mkt_mm_2;
		Real pk2_add1_avm_to_med_ratio_mm_2;
		Real pk2_add2_avm_auto_mm_2;
		Real pk2_add2_avm_auto3_mm_2;
		Real pk2_add2_avm_auto4_mm_2;
		Real pk2_add2_avm_hed_mm_2;
		Real pk2_add2_avm_mkt_mm_2;
		Real pk2_add2_avm_sp_mm_2;
		Real pk2_yr_add1_avm_assess_year_mm_2;
		Real pk2_yr_add1_avm_rec_dt_mm_2;
		Real addprob3_mod_dm_b1;
		Real phnprob_mod_dm_b1;
		Real ssnprob2_mod_dm_nodob_b1;
		Real fp_mod5_dm_nodob_b1;
		Real age_mod3_nodob_dm_b1;
		Real amstudent_mod_dm_b1;
		Real avm_mod_dm_b1;
		Real derog_mod3_dm_b1;
		Real distance_mod2_dm_b1;
		Real lien_mod_dm_b1;
		Real lres_mod_dm_b1;
		Real proflic_mod_dm_b1;
		Real property_mod_dm_b1;
		Real velocity2_mod_dm_b1;
		Real ver_best_src_cnt_mod_dm_b1;
		Real ver_notbest_src_cnt_mod_dm_b1;
		Real ver_src_cnt_mod_dm_b1;
		Real mod14_dm_nodob_b1;
		Real amstudent_mod_om_b2;
		Real avm_mod_om_b2;
		Real lres_mod_om_b2;
		Real proflic_mod_om_b2;
		Real property_mod_om_b2;
		Real velocity2_mod_om_b2;
		Real ver_best_src_cnt_mod_om_b2;
		Real ver_best_src_time_mod_om_b2;
		Real ver_notbest_src_cnt_mod_om_b2;
		Real ver_notbest_src_time_mod_om_b2;
		Real ver_src_time_mod_om_b2;
		Real ver_src_cnt_mod_om_b2;
		Real mod14_om_nodob_b2;
		Real age_mod3_nodob_rm_b3;
		Real amstudent_mod_rm_b3;
		Real avm_mod_rm_b3;
		Real distance_mod2_rm_b3;
		Real lres_mod_rm_b3;
		Real proflic_mod_rm_b3;
		Real property_mod_rm_b3;
		Real velocity2_mod_rm_b3;
		Real ver_best_score_mod_rm_nodob_b3;
		Real ver_best_src_cnt_mod_rm_b3;
		Real ver_best_src_time_mod_rm_b3;
		Real ver_notbest_score_mod_rm_nodob_b3;
		Real ver_notbest_src_cnt_mod_rm_b3;
		Real ver_notbest_src_time_mod_rm_b3;
		Real ver_src_time_mod_rm_b3;
		Real ver_score_mod_rm_nodob_b3;
		Real ver_src_cnt_mod_rm_b3;
		Real mod14_rm_nodob_b3;
		Real age_mod3_nodob_xm_b4;
		Real amstudent_mod_xm_b4;
		Real avm_mod_xm_b4;
		Real distance_mod2_xm_b4;
		Real lres_mod_xm_b4;
		Real property_mod_xm_b4;
		Real velocity2_mod_xm_b4;
		Real ver_best_src_cnt_mod_xm_b4;
		Real ver_best_src_time_mod_xm_b4;
		Real ver_notbest_src_cnt_mod_xm_b4;
		Real ver_notbest_src_time_mod_xm_b4;
		Real ver_src_time_mod_xm_b4;
		Real ver_src_cnt_mod_xm_b4;
		Real mod14_xm_nodob_b4;
		Real velocity2_mod_rm;
		Real mod14_om_nodob;
		Real mod14_dm_nodob;
		Real proflic_mod_rm;
		Real lien_mod_dm;
		Real phat;
		Real addprob3_mod_dm;
		Real proflic_mod_om;
		Real age_mod3_nodob_xm;
		Real avm_mod_om;
		Real property_mod_xm;
		Real velocity2_mod_dm;
		Real ver_notbest_score_mod_rm_nodob;
		Real property_mod_rm;
		Real velocity2_mod_om;
		Real ver_src_time_mod_rm;
		Real property_mod_dm;
		Real ver_notbest_src_cnt_mod_xm;
		Real ver_best_src_time_mod_om;
		Real ver_best_src_cnt_mod_xm;
		Real avm_mod_rm;
		Real amstudent_mod_rm;
		Real velocity2_mod_xm;
		Real avm_mod_dm;
		Real lres_mod_om;
		Real ver_best_src_cnt_mod_rm;
		Real lres_mod_rm;
		Real distance_mod2_rm;
		Real ver_score_mod_rm_nodob;
		Real proflic_mod_dm;
		Real ver_notbest_src_time_mod_rm;
		Real ver_best_src_cnt_mod_om;
		Real age_mod3_nodob_rm;
		Real ver_src_cnt_mod_dm;
		Real derog_mod3_dm;
		Real ssnprob2_mod_dm_nodob;
		Real amstudent_mod_om;
		Real ver_src_time_mod_om;
		Real ver_notbest_src_cnt_mod_om;
		Real ver_notbest_src_cnt_mod_rm;
		Real distance_mod2_dm;
		Real ver_best_src_cnt_mod_dm;
		Real age_mod3_nodob_dm;
		Real ver_src_cnt_mod_xm;
		Real ver_notbest_src_time_mod_xm;
		Real amstudent_mod_dm;
		Real ver_notbest_src_time_mod_om;
		Real ver_best_score_mod_rm_nodob;
		Real mod14_xm_nodob;
		Real ver_src_cnt_mod_om;
		Real ver_best_src_time_mod_xm;
		Real amstudent_mod_xm;
		Real avm_mod_xm;
		Real distance_mod2_xm;
		Real phnprob_mod_dm;
		Real ver_src_cnt_mod_rm;
		Integer mod14_scr;
		Real lres_mod_dm;
		Real ver_best_src_time_mod_rm;
		Real ver_notbest_src_cnt_mod_dm;
		Real mod14_rm_nodob;
		Real property_mod_om;
		Real fp_mod5_dm_nodob;
		Real ver_src_time_mod_xm;
		Real lres_mod_xm;
		Integer RVT1003;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Integer rvt1003_2;
		Boolean scored_222s;
		Integer rvt1003_3;

	end;
	Layout_Debug doModel(clam le) := TRANSFORM
	#else
	Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

		
		did                              := le.did;
		truedid                          := le.truedid;
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_st                           := le.shell_input.st;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		did_count                        := le.iid.didcount;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
		rc_areacodesplitflag             := le.iid.areacodesplitflag;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_statezipflag                  := le.iid.statezipflag;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_hphonescore                := le.iid.combo_hphonescore;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_addrcount                  := le.iid.combo_addrcount;
		eq_count                         := le.source_verification.eq_count;
		pr_count                         := le.source_verification.pr_count;
		adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
		adl_en_first_seen                := le.source_verification.adl_en_first_seen;
		adl_pr_first_seen                := le.source_verification.adl_pr_first_seen;
		adl_em_first_seen                := le.source_verification.adl_em_first_seen;
		adl_vo_first_seen                := le.source_verification.adl_vo_first_seen;
		adl_em_only_first_seen           := le.source_verification.adl_em_only_first_seen;
		adl_w_first_seen                 := le.source_verification.adl_w_first_seen;
		adl_w_last_seen                  := le.source_verification.adl_w_last_seen;
		addr_sources                     := le.source_verification.addrsources;
		em_only_sources                  := le.source_verification.em_only_sources;
		voter_avail                      := le.available_sources.voter;
		ssnlength                        := le.input_validation.ssn_length;
		adl_score                        := le.name_verification.adl_score;
		lname_score                      := le.name_verification.lname_score;
		lname_change_date                := le.name_verification.lname_change_date;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		age                              := le.name_verification.age;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_lres                        := le.lres;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
		add1_avm_assessed_value_year     := le.avm.input_address_information.avm_assessed_value_year;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
		add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_built_date                  := le.address_verification.input_address_information.built_date;
		add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
		add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		add1_no_of_partial_baths         := (string)le.address_verification.input_address_information.no_of_partial_baths;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
		prop2_sale_date                  := le.address_verification.recent_property_sales.sale_date2;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_address_score               := le.address_verification.address_history_1.address_score;
		add2_lres                        := le.lres2;
		add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
		add2_avm_sales_price             := le.avm.address_history_1.avm_sales_price;
		add2_avm_market_total_value      := le.avm.address_history_1.avm_market_total_value;
		add2_avm_hedonic_valuation       := le.avm.address_history_1.avm_hedonic_valuation;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
		add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
		add2_sources                     := le.address_verification.address_history_1.sources;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add2_no_of_buildings             := (string)le.address_verification.address_history_1.no_of_buildings;
		add2_parking_no_of_cars          := (string)le.address_verification.address_history_1.parking_no_of_cars;
		add2_assessed_value_year         := le.address_verification.address_history_1.assessed_value_year;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
		add2_pop                         := le.addrpop2;
		add3_lres                        := le.lres3;
		add3_sources                     := le.address_verification.address_history_2.sources;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
		add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		add3_pop                         := le.addrpop3;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		addrs_prison_history             := le.other_address_info.isprison;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		credit_first_seen                := le.ssn_verification.credit_first_seen;
		header_first_seen                := le.ssn_verification.header_first_seen;
		inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count30            := le.bjl.eviction_count30;
		attr_eviction_count90            := le.bjl.eviction_count90;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		attr_num_proflic90               := le.professional_license.proflic_count90;
		attr_num_proflic_exp90           := le.professional_license.expire_count90;
		attr_num_proflic_exp12           := le.professional_license.expire_count12;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_type                      := le.bjl.filing_type;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_last_unrel_date            := le.bjl.last_liens_unreleased_date;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_lt_first_seen        := le.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
		liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_class                        := le.student.class;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		archive_date                     := le.historydate;





		NULL := -999999999;


		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);

		sysyear :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => year(common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'))),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (real)(trim((string)archive_date, LEFT))[1..4],
																			   NULL);

		rc_ssnhighissue2 := common.sas_date((string)rc_ssnhighissue);

		years_rc_ssnhighissue := if( NULL in [sysdate, rc_ssnhighissue2], NULL, ((sysdate - rc_ssnhighissue2) / 365.25));

		months_rc_ssnhighissue := if( NULL in [sysdate, rc_ssnhighissue2], NULL, ((sysdate - rc_ssnhighissue2) / 30.5));

		adl_eq_first_seen2 := common.sas_date((string)adl_eq_first_seen);

		years_adl_eq_first_seen := if( NULL in [sysdate, adl_eq_first_seen2], NULL, ((sysdate - adl_eq_first_seen2) / 365.25));

		months_adl_eq_first_seen := if( NULL in [sysdate, adl_eq_first_seen2], NULL, ((sysdate - adl_eq_first_seen2) / 30.5));

		adl_en_first_seen2 := common.sas_date((string)adl_en_first_seen);

		years_adl_en_first_seen := if( NULL in [sysdate, adl_en_first_seen2], NULL, ((sysdate - adl_en_first_seen2) / 365.25));

		months_adl_en_first_seen := if( NULL in [sysdate, adl_en_first_seen2], NULL, ((sysdate - adl_en_first_seen2) / 30.5));

		adl_pr_first_seen2 := common.sas_date((string)adl_pr_first_seen);

		years_adl_pr_first_seen := if( NULL in [sysdate, adl_pr_first_seen2], NULL, ((sysdate - adl_pr_first_seen2) / 365.25));

		months_adl_pr_first_seen := if( NULL in [sysdate, adl_pr_first_seen2], NULL, ((sysdate - adl_pr_first_seen2) / 30.5));

		adl_em_first_seen2 := common.sas_date((string)adl_em_first_seen);

		years_adl_em_first_seen := if( NULL in [sysdate, adl_em_first_seen2], NULL, ((sysdate - adl_em_first_seen2) / 365.25));

		months_adl_em_first_seen := if( NULL in [sysdate, adl_em_first_seen2], NULL, ((sysdate - adl_em_first_seen2) / 30.5));

		adl_vo_first_seen2 := common.sas_date((string)adl_vo_first_seen);

		years_adl_vo_first_seen := if( NULL in [sysdate, adl_vo_first_seen2], NULL, ((sysdate - adl_vo_first_seen2) / 365.25));

		months_adl_vo_first_seen := if( NULL in [sysdate, adl_vo_first_seen2], NULL, ((sysdate - adl_vo_first_seen2) / 30.5));

		adl_em_only_first_seen2 := common.sas_date((string)adl_em_only_first_seen);

		years_adl_em_only_first_seen := if( NULL in [sysdate, adl_em_only_first_seen2], NULL, ((sysdate - adl_em_only_first_seen2) / 365.25));

		months_adl_em_only_first_seen := if( NULL in [sysdate, adl_em_only_first_seen2], NULL, ((sysdate - adl_em_only_first_seen2) / 30.5));

		adl_w_first_seen2 := common.sas_date((string)adl_w_first_seen);

		years_adl_w_first_seen := if( NULL in [sysdate, adl_w_first_seen2], NULL, ((sysdate - adl_w_first_seen2) / 365.25));

		months_adl_w_first_seen := if( NULL in [sysdate, adl_w_first_seen2], NULL, ((sysdate - adl_w_first_seen2) / 30.5));

		adl_w_last_seen2 := common.sas_date((string)adl_w_last_seen);

		years_adl_w_last_seen := if( NULL in [sysdate, adl_w_last_seen2], NULL, ((sysdate - adl_w_last_seen2) / 365.25));

		months_adl_w_last_seen := if( NULL in [sysdate, adl_w_last_seen2], NULL, ((sysdate - adl_w_last_seen2) / 30.5));

		lname_change_date2 := common.sas_date((string)lname_change_date);

		years_lname_change_date := if( NULL in [sysdate, lname_change_date2], NULL, ((sysdate - lname_change_date2) / 365.25));

		months_lname_change_date := if( NULL in [sysdate, lname_change_date2], NULL, ((sysdate - lname_change_date2) / 30.5));

		add1_avm_recording_date2 := common.sas_date((string)add1_avm_recording_date);

		years_add1_avm_recording_date := if( NULL in [sysdate, add1_avm_recording_date2], NULL, ((sysdate - add1_avm_recording_date2) / 365.25));

		months_add1_avm_recording_date := if( NULL in [sysdate, add1_avm_recording_date2], NULL, ((sysdate - add1_avm_recording_date2) / 30.5));

		add1_built_date2 := common.sas_date((string)add1_built_date);

		years_add1_built_date := if( NULL in [sysdate, add1_built_date2], NULL, ((sysdate - add1_built_date2) / 365.25));

		months_add1_built_date := if( NULL in [sysdate, add1_built_date2], NULL, ((sysdate - add1_built_date2) / 30.5));

		add1_mortgage_date2 := common.sas_date((string)add1_mortgage_date);

		years_add1_mortgage_date := if( NULL in [sysdate, add1_mortgage_date2], NULL, ((sysdate - add1_mortgage_date2) / 365.25));

		months_add1_mortgage_date := if( NULL in [sysdate, add1_mortgage_date2], NULL, ((sysdate - add1_mortgage_date2) / 30.5));

		add1_mortgage_due_date2 := common.sas_date((string)add1_mortgage_due_date);

		years_add1_mortgage_due_date := if( NULL in [sysdate, add1_mortgage_due_date2], NULL, ((sysdate - add1_mortgage_due_date2) / 365.25));

		months_add1_mortgage_due_date := if( NULL in [sysdate, add1_mortgage_due_date2], NULL, ((sysdate - add1_mortgage_due_date2) / 30.5));

		add1_date_first_seen2 := common.sas_date((string)add1_date_first_seen);

		years_add1_date_first_seen := if( NULL in [sysdate, add1_date_first_seen2], NULL, ((sysdate - add1_date_first_seen2) / 365.25));

		months_add1_date_first_seen := if( NULL in [sysdate, add1_date_first_seen2], NULL, ((sysdate - add1_date_first_seen2) / 30.5));

		prop2_sale_date2 := common.sas_date((string)prop2_sale_date);

		years_prop2_sale_date := if( NULL in [sysdate, prop2_sale_date2], NULL, ((sysdate - prop2_sale_date2) / 365.25));

		months_prop2_sale_date := if( NULL in [sysdate, prop2_sale_date2], NULL, ((sysdate - prop2_sale_date2) / 30.5));

		add2_assessed_value_year2 := common.sas_date((string)add2_assessed_value_year);

		years_add2_assessed_value_year := if( NULL in [sysdate, add2_assessed_value_year2], NULL, ((sysdate - add2_assessed_value_year2) / 365.25));

		months_add2_assessed_value_year := if( NULL in [sysdate, add2_assessed_value_year2], NULL, ((sysdate - add2_assessed_value_year2) / 30.5));

		add2_date_first_seen2 := common.sas_date((string)add2_date_first_seen);

		years_add2_date_first_seen := if( NULL in [sysdate, add2_date_first_seen2], NULL, ((sysdate - add2_date_first_seen2) / 365.25));

		months_add2_date_first_seen := if( NULL in [sysdate, add2_date_first_seen2], NULL, ((sysdate - add2_date_first_seen2) / 30.5));

		add2_date_last_seen2 := common.sas_date((string)add2_date_last_seen);

		years_add2_date_last_seen := if( NULL in [sysdate, add2_date_last_seen2], NULL, ((sysdate - add2_date_last_seen2) / 365.25));

		months_add2_date_last_seen := if( NULL in [sysdate, add2_date_last_seen2], NULL, ((sysdate - add2_date_last_seen2) / 30.5));

		add3_date_first_seen2 := common.sas_date((string)add3_date_first_seen);

		years_add3_date_first_seen := if( NULL in [sysdate, add3_date_first_seen2], NULL, ((sysdate - add3_date_first_seen2) / 365.25));

		months_add3_date_first_seen := if( NULL in [sysdate, add3_date_first_seen2], NULL, ((sysdate - add3_date_first_seen2) / 30.5));

		gong_did_first_seen2 := common.sas_date((string)gong_did_first_seen);

		years_gong_did_first_seen := if( NULL in [sysdate, gong_did_first_seen2], NULL, ((sysdate - gong_did_first_seen2) / 365.25));

		months_gong_did_first_seen := if( NULL in [sysdate, gong_did_first_seen2], NULL, ((sysdate - gong_did_first_seen2) / 30.5));

		credit_first_seen2 := common.sas_date((string)credit_first_seen);

		years_credit_first_seen := if( NULL in [sysdate, credit_first_seen2], NULL, ((sysdate - credit_first_seen2) / 365.25));

		months_credit_first_seen := if( NULL in [sysdate, credit_first_seen2], NULL, ((sysdate - credit_first_seen2) / 30.5));

		header_first_seen2 := common.sas_date((string)header_first_seen);

		years_header_first_seen := if( NULL in [sysdate, header_first_seen2], NULL, ((sysdate - header_first_seen2) / 365.25));

		months_header_first_seen := if( NULL in [sysdate, header_first_seen2], NULL, ((sysdate - header_first_seen2) / 30.5));

		infutor_first_seen2 := common.sas_date((string)infutor_first_seen);

		years_infutor_first_seen := if( NULL in [sysdate, infutor_first_seen2], NULL, ((sysdate - infutor_first_seen2) / 365.25));

		months_infutor_first_seen := if( NULL in [sysdate, infutor_first_seen2], NULL, ((sysdate - infutor_first_seen2) / 30.5));

		date_last_seen2 := common.sas_date((string)date_last_seen);

		years_date_last_seen := if( NULL in [sysdate, date_last_seen2], NULL, ((sysdate - date_last_seen2) / 365.25));

		months_date_last_seen := if( NULL in [sysdate, date_last_seen2], NULL, ((sysdate - date_last_seen2) / 30.5));

		liens_last_unrel_date2 := common.sas_date((string)liens_last_unrel_date);

		years_liens_last_unrel_date := if( NULL in [sysdate, liens_last_unrel_date2], NULL, ((sysdate - liens_last_unrel_date2) / 365.25));

		months_liens_last_unrel_date := if( NULL in [sysdate, liens_last_unrel_date2], NULL, ((sysdate - liens_last_unrel_date2) / 30.5));

		liens_unrel_cj_last_seen2 := common.sas_date((string)liens_unrel_cj_last_seen);

		years_liens_unrel_cj_last_seen := if( NULL in [sysdate, liens_unrel_cj_last_seen2], NULL, ((sysdate - liens_unrel_cj_last_seen2) / 365.25));

		months_liens_unrel_cj_last_seen := if( NULL in [sysdate, liens_unrel_cj_last_seen2], NULL, ((sysdate - liens_unrel_cj_last_seen2) / 30.5));

		liens_unrel_lt_first_seen2 := common.sas_date((string)liens_unrel_lt_first_seen);

		years_liens_unrel_lt_first_seen := if( NULL in [sysdate, liens_unrel_lt_first_seen2], NULL, ((sysdate - liens_unrel_lt_first_seen2) / 365.25));

		months_liens_unrel_lt_first_seen := if( NULL in [sysdate, liens_unrel_lt_first_seen2], NULL, ((sysdate - liens_unrel_lt_first_seen2) / 30.5));

		liens_unrel_ot_first_seen2 := common.sas_date((string)liens_unrel_ot_first_seen);

		years_liens_unrel_ot_first_seen := if( NULL in [sysdate, liens_unrel_ot_first_seen2], NULL, ((sysdate - liens_unrel_ot_first_seen2) / 365.25));

		months_liens_unrel_ot_first_seen := if( NULL in [sysdate, liens_unrel_ot_first_seen2], NULL, ((sysdate - liens_unrel_ot_first_seen2) / 30.5));

		reported_dob2 := common.sas_date((string)reported_dob);

		years_reported_dob := if( NULL in [sysdate, reported_dob2], NULL, ((sysdate - reported_dob2) / 365.25));

		months_reported_dob := if( NULL in [sysdate, reported_dob2], NULL, ((sysdate - reported_dob2) / 30.5));

		add1_avm_assessed_value_year2 := common.sas_date((string)add1_avm_assessed_value_year);

		years_add1_avm_assess_year := if( NULL in [sysdate, add1_avm_assessed_value_year2], NULL, ((sysdate - add1_avm_assessed_value_year2) / 365.25));

		months_add1_avm_assess_year := if( NULL in [sysdate, add1_avm_assessed_value_year2], NULL, ((sysdate - add1_avm_assessed_value_year2) / 30.5));

		Common.findw(rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool'); // source_tot_AK := 
		Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool'); // source_tot_AM := 
		Common.findw(rc_sources, 'AR', ' ,', 'I', source_tot_AR, 'bool'); // source_tot_AR := 
		Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool'); // source_tot_BA := 
		Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool'); // source_tot_CG := 
		Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool'); // source_tot_DA := 
		Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool'); // source_tot_DS := 
		Common.findw(rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool'); // source_tot_EB := 
		Common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool'); // source_tot_EM := 
		Common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool'); // source_tot_VO := 
		Common.findw(rc_sources, 'FF', ' ,', 'I', source_tot_FF, 'bool'); // source_tot_FF := 
		Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool'); // source_tot_L2 := 
		Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool'); // source_tot_LI := 
		Common.findw(rc_sources, 'P', ' ,', 'I', source_tot_P, 'bool'); // source_tot_P := 
		Common.findw(rc_sources, 'W', ' ,', 'I', source_tot_W, 'bool'); // source_tot_W := 
		source_tot_voter := (source_tot_EM or source_tot_VO);
		Common.findw(addr_sources, 'P', ' ,', 'I', source_add_P, 'bool'); // source_add_P := 
		Common.findw(add2_sources, 'AK', ' ,', 'I', source_add2_AK, 'bool'); // source_add2_AK := 
		Common.findw(add2_sources, 'AM', ' ,', 'I', source_add2_AM, 'bool'); // source_add2_AM := 
		Common.findw(add2_sources, 'AR', ' ,', 'I', source_add2_AR, 'bool'); // source_add2_AR := 
		Common.findw(add2_sources, 'CG', ' ,', 'I', source_add2_CG, 'bool'); // source_add2_CG := 
		Common.findw(add2_sources, 'EB', ' ,', 'I', source_add2_EB, 'bool'); // source_add2_EB := 
		Common.findw(add2_sources, 'EM', ' ,', 'I', source_add2_EM, 'bool'); // source_add2_EM := 
		Common.findw(add2_sources, 'VO', ' ,', 'I', source_add2_VO, 'bool'); // source_add2_VO := 
		Common.findw(add2_sources, 'EQ', ' ,', 'I', source_add2_EQ, 'bool'); // source_add2_EQ := 
		Common.findw(add2_sources, 'P', ' ,', 'I', source_add2_P, 'bool'); // source_add2_P := 
		Common.findw(add2_sources, 'WP', ' ,', 'I', source_add2_WP, 'bool'); // source_add2_WP := 
		source_add2_voter := (source_add2_EM or source_add2_VO);
		Common.findw(add3_sources, 'P', ' ,', 'I', source_add3_P, 'bool'); // source_add3_P := 
		Common.findw(em_only_sources, 'EM', ' ,', 'I', em_only_source_EM, 'bool'); // em_only_source_EM := 
		Common.findw(em_only_sources, 'E1', ' ,', 'I', em_only_source_E1, 'bool'); // em_only_source_E1 := 
		Common.findw(em_only_sources, 'E2', ' ,', 'I', em_only_source_E2, 'bool'); // em_only_source_E2 := 
		Common.findw(em_only_sources, 'E3', ' ,', 'I', em_only_source_E3, 'bool'); // em_only_source_E3 := 
		Common.findw(em_only_sources, 'E4', ' ,', 'I', em_only_source_E4, 'bool'); // em_only_source_E4 := 



		years_adl_first_seen_max_fcra := max(years_adl_eq_first_seen, years_adl_en_first_seen, years_adl_pr_first_seen, years_adl_em_first_seen, years_adl_vo_first_seen, years_adl_em_only_first_seen, years_adl_w_first_seen);

		months_adl_first_seen_max_fcra := max(months_adl_eq_first_seen, months_adl_en_first_seen, months_adl_pr_first_seen, months_adl_em_first_seen, months_adl_vo_first_seen, months_adl_em_only_first_seen, months_adl_w_first_seen);

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		phn_disconnected := ((integer)rc_hriskphoneflag = 5);

		phn_inval := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

		phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

		phn_zipmismatch := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));

		ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

		ssn_adl_prob := ((ssns_per_adl = 0) or ((ssns_per_adl >= 3) or (ssns_per_adl_c6 >= 2)));

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

		lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

		crime_flag := (criminal_count > 0);

		crime_felony_flag := (felony_count > 0);

		crime_drug_flag := (((integer)crime_flag = 1) or ((integer)source_tot_DA = 1));

		add1_AVM_hit := ((integer)add1_avm_land_use > 0);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

		add1_avm_to_med_ratio :=  if(not((add1_avm_automated_valuation in [NULL, 0])) and not((add1_avm_med in [NULL, 0])), (add1_avm_automated_valuation / add1_avm_med), NULL);

		add_lres_month_avg := if(max(months_add1_date_first_seen, months_add2_date_first_seen, months_add3_date_first_seen) = NULL, NULL, (if(max(months_add1_date_first_seen, months_add2_date_first_seen, months_add3_date_first_seen) = NULL, NULL, SUM(if(months_add1_date_first_seen = NULL, 0, months_add1_date_first_seen), if(months_add2_date_first_seen = NULL, 0, months_add2_date_first_seen), if(months_add3_date_first_seen = NULL, 0, months_add3_date_first_seen)))/sum(if(months_add1_date_first_seen = NULL, 0, 1), if(months_add2_date_first_seen = NULL, 0, 1), if(months_add3_date_first_seen = NULL, 0, 1))));

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

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

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

		Dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

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

		estimated_income := max((real)0, round(pred_inc/1000)*1000);

		estimated_income_2 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, estimated_income);

		pk_ssnchar_invalid_or_recent :=  if(inputssncharflag in ['1', '2', '3', '4'], 1, 0);

		pk_did0 :=  if(did = 0, 1, 0);

		pk_yr_adl_vo_first_seen := if (years_adl_vo_first_seen >= 0, roundup(years_adl_vo_first_seen), truncate(years_adl_vo_first_seen));

		pk_yr_adl_em_only_first_seen := if (years_adl_em_only_first_seen >= 0, roundup(years_adl_em_only_first_seen), truncate(years_adl_em_only_first_seen));

		pk_yr_adl_first_seen_max_fcra := if (years_adl_first_seen_max_fcra >= 0, roundup(years_adl_first_seen_max_fcra), truncate(years_adl_first_seen_max_fcra));

		pk_mo_adl_first_seen_max_fcra := if (months_adl_first_seen_max_fcra >= 0, roundup(months_adl_first_seen_max_fcra), truncate(months_adl_first_seen_max_fcra));

		pk_yr_lname_change_date := if (years_lname_change_date >= 0, roundup(years_lname_change_date), truncate(years_lname_change_date));

		pk_yr_gong_did_first_seen := if (years_gong_did_first_seen >= 0, roundup(years_gong_did_first_seen), truncate(years_gong_did_first_seen));

		pk_yr_credit_first_seen := if (years_credit_first_seen >= 0, roundup(years_credit_first_seen), truncate(years_credit_first_seen));

		pk_yr_header_first_seen := if (years_header_first_seen >= 0, roundup(years_header_first_seen), truncate(years_header_first_seen));

		pk_yr_infutor_first_seen := if (years_infutor_first_seen >= 0, roundup(years_infutor_first_seen), truncate(years_infutor_first_seen));

		pk_multi_did :=  if(did_count >= 2, 1, 0);

		pk_nas_summary :=  map(nas_summary >= 12 => 2,
							   nas_summary >= 9  => 1,
													0);

		pk_nap_summary :=  map(nap_summary >= 12 => 2,
							   nap_summary >= 9  => 1,
							   nap_summary = 1   => -1,
													0);

		pk_rc_dirsaddr_lastscore :=  map(rc_dirsaddr_lastscore = 255 => -1,
										 rc_dirsaddr_lastscore >= 90 => 2,
										 rc_dirsaddr_lastscore >= 80 => 1,
																		0);

		pk_adl_score :=  if(adl_score = 100, 1, 0);

		pk_lname_score :=  map(lname_score = 255 => 0,
							   lname_score = 100 => 1,
													0);

		pk_combo_addrscore :=  if(combo_addrscore = 100, 1, 0);

		pk_combo_hphonescore :=  map(combo_hphonescore = 255 => 0,
									 combo_hphonescore = 100 => 2,
									 combo_hphonescore >= 90 => 1,
																0);

		pk_combo_ssnscore :=  map(combo_ssnscore = 100 => 1,
								  combo_ssnscore = 255 => -1,
														  0);

		pk_eq_count :=  map(eq_count <= 1  => 0,
							eq_count <= 3  => 1,
							eq_count <= 5  => 2,
							eq_count <= 6  => 3,
							eq_count <= 7  => 4,
							eq_count <= 17 => 5,
											  6);

		pk_pos_secondary_sources :=  map(source_tot_EB                                                                                                                                                                                                                 => 2,
										 if(max((integer)source_tot_AK, (integer)source_tot_AM, (integer)source_tot_AR, (integer)source_tot_CG) = NULL, NULL, sum((integer)source_tot_AK, (integer)source_tot_AM, (integer)source_tot_AR, (integer)source_tot_CG)) > 0 => 1,
																																																																		  0);

		pk_voter_flag :=  map(source_tot_voter => 1,
							  voter_avail      => -1,
												  0);

		pk_fname_eda_sourced_type_lvl :=  map(trim(trim(fname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP' => 3,
											  trim(trim(fname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'  => 2,
											  trim(trim(fname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A'  => 1,
																											  0);

		pk_lname_eda_sourced_type_lvl :=  map(trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP' => 3,
											  trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'  => 2,
											  trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A'  => 1,
																											  0);

		pk_add1_address_score :=  if(add1_address_score = 100, 1, 0);

		pk_add1_unit_count2 :=  map(add1_unit_count <= 2 => 0,
									add1_unit_count <= 3 => 1,
									add1_unit_count <= 4 => 2,
															3);

		pk_add2_address_score :=  map(add2_address_score >= 90 => 3,
									  add2_address_score >= 60 => 2,
									  add2_address_score >= 10 => 1,
																  0);

		pk_add2_pos_sources :=  map(source_add2_EQ and (source_add2_WP and source_add2_voter) => 4,
									source_add2_EQ and source_add2_WP                         => 3,
									source_add2_voter                                         => 2,
									source_add2_EQ                                            => 1,
																								 0);

		pk_add2_pos_secondary_sources :=  map(source_add2_EB                                                                                                                                                                                                                        => 2,
											  if(max((integer)source_add2_AK, (integer)source_add2_AM, (integer)source_add2_AR, (integer)source_add2_CG) = NULL, NULL, sum((integer)source_add2_AK, (integer)source_add2_AM, (integer)source_add2_AR, (integer)source_add2_CG)) > 0 => 1,
																																																																					   0);

		Common.findw(add2_sources, 'EM', ' ,', 'I', add2_source_EM, 'bool'); // add2_source_EM := 
		Common.findw(add2_sources, 'E1', ' ,', 'I', add2_source_E1, 'bool'); // add2_source_E1 := 
		Common.findw(add2_sources, 'E2', ' ,', 'I', add2_source_E2, 'bool'); // add2_source_E2 := 
		Common.findw(add2_sources, 'E3', ' ,', 'I', add2_source_E3, 'bool'); // add2_source_E3 := 
		Common.findw(add2_sources, 'E4', ' ,', 'I', add2_source_E4, 'bool'); // add2_source_E4 := 
		Common.findw(add3_sources, 'EM', ' ,', 'I', add3_source_EM, 'bool'); // add3_source_EM := 
		Common.findw(add3_sources, 'E1', ' ,', 'I', add3_source_E1, 'bool'); // add3_source_E1 := 
		Common.findw(add3_sources, 'E2', ' ,', 'I', add3_source_E2, 'bool'); // add3_source_E2 := 
		Common.findw(add3_sources, 'E3', ' ,', 'I', add3_source_E3, 'bool'); // add3_source_E3 := 
		Common.findw(add3_sources, 'E4', ' ,', 'I', add3_source_E4, 'bool'); // add3_source_E4 := 



		pk_em_only_ver_lvl :=  map(em_only_source_EM and em_only_source_E1 => 3,
								   em_only_source_E1                       => 2,
								   em_only_source_E4                       => -1,
								   em_only_source_EM                       => 1,
																			  0);

		pk_add2_em_ver_lvl :=  map(add2_source_E1 => 2,
								   add2_source_E4 => -1,
								   add2_source_EM => 1,
													 0);

		pk_ssnchar_invalid_or_recent_2 :=  if(inputssncharflag in ['1', '2', '3', '4'], 1, 0);

		pk_infutor_risk_lvl :=  map(infutor_nap in [1, 6] => 2,
									infutor_nap in [0]    => 0,
															 1);

		pk_infutor_risk_lvl_nb :=  map(infutor_nap in [1, 6] => 3,
									   infutor_nap in [12]   => 0,
									   infutor_nap in [0]    => 1,
																2);

		pk_yr_adl_vo_first_seen2 :=  map((real)pk_yr_adl_vo_first_seen <= NULL => -1,
										 pk_yr_adl_vo_first_seen <= 1          => 0,
										 pk_yr_adl_vo_first_seen <= 3          => 1,
										 pk_yr_adl_vo_first_seen <= 4          => 2,
																				  3);

		pk_yr_adl_em_only_first_seen2 :=  map((real)pk_yr_adl_em_only_first_seen <= NULL => -1,
											  pk_yr_adl_em_only_first_seen <= 1          => 0,
											  pk_yr_adl_em_only_first_seen <= 2          => 1,
											  pk_yr_adl_em_only_first_seen <= 3          => 2,
											  pk_yr_adl_em_only_first_seen <= 19         => 3,
																							4);

		pk_yrmo_adl_first_seen_max_fcra2 :=  map((real)pk_mo_adl_first_seen_max_fcra <= NULL => -1,
												 pk_mo_adl_first_seen_max_fcra <= 3          => 0,
												 pk_mo_adl_first_seen_max_fcra <= 13         => 1,
												 pk_mo_adl_first_seen_max_fcra <= 19         => 2,
												 pk_mo_adl_first_seen_max_fcra <= 25         => 3,
												 pk_mo_adl_first_seen_max_fcra <= 36         => 4,
												 pk_mo_adl_first_seen_max_fcra <= 41         => 5,
												 pk_mo_adl_first_seen_max_fcra <= 54         => 6,
												 pk_mo_adl_first_seen_max_fcra <= 60         => 7,
												 pk_yr_adl_first_seen_max_fcra <= 6          => 8,
												 pk_yr_adl_first_seen_max_fcra <= 8          => 9,
												 pk_yr_adl_first_seen_max_fcra <= 12         => 10,
												 pk_yr_adl_first_seen_max_fcra <= 15         => 11,
												 pk_yr_adl_first_seen_max_fcra <= 17         => 12,
												 pk_yr_adl_first_seen_max_fcra <= 19         => 13,
												 pk_yr_adl_first_seen_max_fcra <= 21         => 14,
												 pk_yr_adl_first_seen_max_fcra <= 26         => 15,
																								16);

		pk_yrmo_adl_f_sn_mx_fcra2_nb :=  map((real)pk_mo_adl_first_seen_max_fcra <= NULL => -1,
											 pk_mo_adl_first_seen_max_fcra <= 3          => 0,
											 pk_mo_adl_first_seen_max_fcra <= 13         => 1,
											 pk_mo_adl_first_seen_max_fcra <= 25         => 2,
											 pk_mo_adl_first_seen_max_fcra <= 41         => 3,
											 pk_mo_adl_first_seen_max_fcra <= 54         => 4,
											 pk_mo_adl_first_seen_max_fcra <= 60         => 5,
											 pk_yr_adl_first_seen_max_fcra <= 8          => 6,
											 pk_yr_adl_first_seen_max_fcra <= 12         => 7,
											 pk_yr_adl_first_seen_max_fcra <= 15         => 8,
											 pk_yr_adl_first_seen_max_fcra <= 17         => 9,
											 pk_yr_adl_first_seen_max_fcra <= 19         => 10,
											 pk_yr_adl_first_seen_max_fcra <= 21         => 11,
											 pk_yr_adl_first_seen_max_fcra <= 26         => 12,
																							13);

		pk_yr_lname_change_date2 :=  map((real)pk_yr_lname_change_date <= NULL => -1,
										 pk_yr_lname_change_date <= 2          => 0,
										 pk_yr_lname_change_date <= 8          => 1,
																				  2);

		pk_yr_gong_did_first_seen2 :=  map((real)pk_yr_gong_did_first_seen <= NULL => -1,
										   pk_yr_gong_did_first_seen <= 1          => 0,
										   pk_yr_gong_did_first_seen <= 2          => 1,
										   pk_yr_gong_did_first_seen <= 3          => 2,
										   pk_yr_gong_did_first_seen <= 4          => 3,
																					  4);

		pk_yr_credit_first_seen2 :=  map((real)pk_yr_credit_first_seen <= NULL => -1,
										 pk_yr_credit_first_seen <= 1          => 0,
										 pk_yr_credit_first_seen <= 2          => 1,
										 pk_yr_credit_first_seen <= 3          => 2,
										 pk_yr_credit_first_seen <= 5          => 3,
										 pk_yr_credit_first_seen <= 6          => 4,
										 pk_yr_credit_first_seen <= 8          => 5,
										 pk_yr_credit_first_seen <= 10         => 6,
										 pk_yr_credit_first_seen <= 15         => 7,
										 pk_yr_credit_first_seen <= 19         => 8,
										 pk_yr_credit_first_seen <= 21         => 9,
										 pk_yr_credit_first_seen <= 28         => 10,
																				  11);

		pk_yr_header_first_seen2 :=  map((real)pk_yr_header_first_seen <= NULL => -1,
										 pk_yr_header_first_seen <= 1          => 0,
										 pk_yr_header_first_seen <= 2          => 1,
										 pk_yr_header_first_seen <= 4          => 2,
										 pk_yr_header_first_seen <= 5          => 3,
										 pk_yr_header_first_seen <= 16         => 4,
										 pk_yr_header_first_seen <= 19         => 5,
										 pk_yr_header_first_seen <= 24         => 6,
																				  7);

		pk_yr_infutor_first_seen2 :=  map((real)pk_yr_infutor_first_seen <= NULL => -1,
										  pk_yr_infutor_first_seen <= 1          => 0,
										  pk_yr_infutor_first_seen <= 2          => 1,
										  pk_yr_infutor_first_seen <= 3          => 2,
										  pk_yr_infutor_first_seen <= 4          => 3,
																					4);

		pk_estimated_income :=  map((integer)estimated_income_2 <= 222    => -1,
									(integer)estimated_income_2 <= 15000  => 0,
									(integer)estimated_income_2 <= 19000  => 1,
									(integer)estimated_income_2 <= 20000  => 2,
									(integer)estimated_income_2 <= 21000  => 3,
									(integer)estimated_income_2 <= 22000  => 4,
									(integer)estimated_income_2 <= 23000  => 5,
									(integer)estimated_income_2 <= 24000  => 6,
									(integer)estimated_income_2 <= 25000  => 7,
									(integer)estimated_income_2 <= 26000  => 8,
									(integer)estimated_income_2 <= 27000  => 9,
									(integer)estimated_income_2 <= 28000  => 10,
									(integer)estimated_income_2 <= 29000  => 11,
									(integer)estimated_income_2 <= 31000  => 12,
									(integer)estimated_income_2 <= 32000  => 13,
									(integer)estimated_income_2 <= 33000  => 14,
									(integer)estimated_income_2 <= 34000  => 15,
									(integer)estimated_income_2 <= 35000  => 16,
									(integer)estimated_income_2 <= 36000  => 17,
									(integer)estimated_income_2 <= 37000  => 18,
									(integer)estimated_income_2 <= 39000  => 19,
									(integer)estimated_income_2 <= 108000 => 20,
									(integer)estimated_income_2 <= 150000 => 21,
																			 22);

		pk_yr_adl_w_last_seen := if (years_adl_w_last_seen >= 0, roundup(years_adl_w_last_seen), truncate(years_adl_w_last_seen));

		pk_yr_add1_built_date := if (years_add1_built_date >= 0, roundup(years_add1_built_date), truncate(years_add1_built_date));

		pk_yr_add1_mortgage_date := if (years_add1_mortgage_date >= 0, roundup(years_add1_mortgage_date), truncate(years_add1_mortgage_date));

		pk_yr_add1_mortgage_due_date := if (years_add1_mortgage_due_date >= 0, roundup(years_add1_mortgage_due_date), truncate(years_add1_mortgage_due_date));

		pk_yr_add1_date_first_seen := if (years_add1_date_first_seen >= 0, roundup(years_add1_date_first_seen), truncate(years_add1_date_first_seen));

		pk_yr_prop2_sale_date := if (years_prop2_sale_date >= 0, roundup(years_prop2_sale_date), truncate(years_prop2_sale_date));

		pk_yr_add2_assessed_value_year := if (years_add2_assessed_value_year >= 0, roundup(years_add2_assessed_value_year), truncate(years_add2_assessed_value_year));

		pk_yr_add2_date_first_seen := if (years_add2_date_first_seen >= 0, roundup(years_add2_date_first_seen), truncate(years_add2_date_first_seen));

		pk_yr_add2_date_last_seen := if (years_add2_date_last_seen >= 0, roundup(years_add2_date_last_seen), truncate(years_add2_date_last_seen));

		pk_yr_add3_date_first_seen := if (years_add3_date_first_seen >= 0, roundup(years_add3_date_first_seen), truncate(years_add3_date_first_seen));

		pk_property_owned_assessed_total := (20000 * if ((property_owned_assessed_total / 20000) >= 0, roundup((property_owned_assessed_total / 20000)), truncate((property_owned_assessed_total / 20000))));

		pk_prop1_sale_price := (20000 * if ((prop1_sale_price / 20000) >= 0, roundup((prop1_sale_price / 20000)), truncate((prop1_sale_price / 20000))));

		pk_add1_purchase_amount := (20000 * if ((add1_purchase_amount / 20000) >= 0, roundup((add1_purchase_amount / 20000)), truncate((add1_purchase_amount / 20000))));

		pk_add1_assessed_amount := (20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000))));

		pk_add2_assessed_amount := (20000 * if ((add2_assessed_amount / 20000) >= 0, roundup((add2_assessed_amount / 20000)), truncate((add2_assessed_amount / 20000))));

		pk_add3_assessed_amount := (20000 * if ((add3_assessed_amount / 20000) >= 0, roundup((add3_assessed_amount / 20000)), truncate((add3_assessed_amount / 20000))));

		pk_property_owned_assessed_total_2 :=  if(pk_property_owned_assessed_total > 1000000, 1000000, pk_property_owned_assessed_total);

		pk_prop1_sale_price_2 :=  if(pk_prop1_sale_price > 1000000, 1000000, pk_prop1_sale_price);

		pk_add1_purchase_amount_2 :=  if(pk_add1_purchase_amount > 1000000, 1000000, pk_add1_purchase_amount);

		pk_add1_assessed_amount_2 :=  if(pk_add1_assessed_amount > 1000000, 1000000, pk_add1_assessed_amount);

		pk_add2_assessed_amount_2 :=  if(pk_add2_assessed_amount > 1000000, 1000000, pk_add2_assessed_amount);

		pk_add3_assessed_amount_2 :=  if(pk_add3_assessed_amount > 1000000, 1000000, pk_add3_assessed_amount);

		pk_add1_building_area :=  map((integer)add1_building_area <= 1000   => (100 * if (((real)add1_building_area / 100) >= 0, roundup(((real)add1_building_area / 100)), truncate(((real)add1_building_area / 100)))),
									  (integer)add1_building_area <= 10000  => (1000 * if (((real)add1_building_area / 1000) >= 0, roundup(((real)add1_building_area / 1000)), truncate(((real)add1_building_area / 1000)))),
									  (integer)add1_building_area <= 100000 => (10000 * if (((real)add1_building_area / 10000) >= 0, roundup(((real)add1_building_area / 10000)), truncate(((real)add1_building_area / 10000)))),
																			   100001);

		pk_yr_adl_w_last_seen2 :=  map((real)pk_yr_adl_w_last_seen <= NULL => -1,
									   pk_yr_adl_w_last_seen <= 0          => 0,
									   pk_yr_adl_w_last_seen <= 1          => 1,
																			  2);

		pk_pr_count :=  map(pr_count <= 0 => -1,
							pr_count <= 1 => 0,
							pr_count <= 9 => 1,
											 2);

		pk_addrs_sourced_lvl :=  map(source_add_P and (source_add2_P or source_add3_P) => 3,
									 source_add_P                                      => 2,
									 source_add2_P or source_add3_P                    => 1,
																						  0);

		pk_add1_own_level :=  map(add1_applicant_owned and add1_family_owned => 3,
								  add1_applicant_owned                       => 2,
								  add1_family_owned                          => 1,
								  add1_occupant_owned                        => -1,
																				0);

		pk_naprop_level :=  map((add1_naprop = 4) and (add2_naprop = 4)  => 7,
								add1_naprop = 4                          => 6,
								(add1_naprop = 3) and (add2_naprop = 4)  => 5,
								(add1_naprop = 3) and (add2_naprop = 3)  => 4,
								(add1_naprop = 3) and (add2_naprop != 1) => 3,
								add1_naprop = 3                          => 2,
								add1_naprop = 2                          => 3,
								(add1_naprop = 1) and (add2_naprop = 4)  => 4,
								(add1_naprop = 1) and (add2_naprop = 3)  => 1,
								(add1_naprop = 1) and (add2_naprop != 1) => 0,
								add1_naprop = 1                          => -1,
								(add1_naprop = 0) and (add2_naprop = 4)  => 5,
								(add1_naprop = 0) and (add2_naprop != 1) => 2,
																			0);

		pk_naprop_level2_b1 := map(pk_naprop_level = 6  => 7,
								   pk_naprop_level >= 2 => 5,
														   4);

		pk_naprop_level2 := map(add3_naprop = 4                              => pk_naprop_level2_b1,
								(add3_naprop = 0) and (pk_naprop_level = -1) => -2,
								(add3_naprop = 0) and (pk_naprop_level = 0)  => -1,
																				pk_naprop_level);

		pk_add2_own_level :=  map(add2_applicant_owned and add2_family_owned => 3,
								  add2_applicant_owned                       => 2,
								  add2_family_owned                          => 1,
																				0);

		pk_add3_own_level :=  map(add3_applicant_owned and add3_family_owned => 3,
								  add3_applicant_owned                       => 2,
								  add3_family_owned                          => 1,
																				0);

		pk_yr_add1_built_date2 :=  map((real)pk_yr_add1_built_date <= NULL => -4,
									   pk_yr_add1_built_date <= 1          => -3,
									   pk_yr_add1_built_date <= 4          => -2,
									   pk_yr_add1_built_date <= 7          => -1,
									   pk_yr_add1_built_date <= 25         => 0,
									   pk_yr_add1_built_date <= 35         => 1,
									   pk_yr_add1_built_date <= 50         => 2,
																			  3);

		pk_add1_purchase_amount2 :=  map(pk_add1_purchase_amount_2 <= 0      => -1,
										 pk_add1_purchase_amount_2 <= 120000 => 0,
																				1);

		pk_yr_add1_mortgage_date2 :=  map((real)pk_yr_add1_mortgage_date <= NULL => -1,
										  pk_yr_add1_mortgage_date <= 2          => 0,
										  pk_yr_add1_mortgage_date <= 3          => 1,
																					2);

		pk_add1_mortgage_risk :=  map(trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 3,
									  trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 3,
									  trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 2,
									  trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 1,
									  trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 0,
									  trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																												-1);

		pk_add1_adjustable_financing :=  if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

		pk_add1_assessed_amount2 :=  map(pk_add1_assessed_amount_2 <= 0      => -1,
										 pk_add1_assessed_amount_2 <= 40000  => 0,
										 pk_add1_assessed_amount_2 <= 60000  => 1,
										 pk_add1_assessed_amount_2 <= 80000  => 2,
										 pk_add1_assessed_amount_2 <= 100000 => 3,
										 pk_add1_assessed_amount_2 <= 140000 => 4,
										 pk_add1_assessed_amount_2 <= 160000 => 5,
																				6);

		pk_yr_add1_mortgage_due_date2 :=  map((real)pk_yr_add1_mortgage_due_date <= NULL => -1,
											  pk_yr_add1_mortgage_due_date <= -27        => 2,
											  pk_yr_add1_mortgage_due_date <= -12        => 1,
																							0);

		pk_yr_add1_date_first_seen2 :=  map((real)pk_yr_add1_date_first_seen <= NULL => -1,
											pk_yr_add1_date_first_seen <= 1          => 0,
											pk_yr_add1_date_first_seen <= 2          => 1,
											pk_yr_add1_date_first_seen <= 3          => 2,
											pk_yr_add1_date_first_seen <= 4          => 3,
											pk_yr_add1_date_first_seen <= 5          => 4,
											pk_yr_add1_date_first_seen <= 8          => 5,
											pk_yr_add1_date_first_seen <= 10         => 6,
											pk_yr_add1_date_first_seen <= 14         => 7,
											pk_yr_add1_date_first_seen <= 19         => 8,
											pk_yr_add1_date_first_seen <= 26         => 9,
																						10);

		pk_add1_land_use_cat := (trim(add1_land_use_code, LEFT))[1..2];

		pk_add1_land_use_risk_level :=  map(trim(trim(pk_add1_land_use_cat, LEFT), LEFT, RIGHT) in ['11', '92', '91']             => 4,
											trim(trim(pk_add1_land_use_cat, LEFT), LEFT, RIGHT) in ['', '20']                     => 3,
											trim(trim(pk_add1_land_use_cat, LEFT), LEFT, RIGHT) in ['30', '05', '10', '80', '00'] => 2,
											trim(trim(pk_add1_land_use_cat, LEFT), LEFT, RIGHT) in ['19']                         => 2,
											trim(trim(pk_add1_land_use_cat, LEFT), LEFT, RIGHT) in ['70']                         => 0,
																																	 3);

		pk_add1_building_area2 :=  map(pk_add1_building_area <= 0     => -99,
									   pk_add1_building_area <= 900   => -4,
									   pk_add1_building_area <= 1000  => -3,
									   pk_add1_building_area <= 2000  => -2,
									   pk_add1_building_area <= 3000  => -1,
									   pk_add1_building_area <= 5000  => 0,
									   pk_add1_building_area <= 7000  => 1,
									   pk_add1_building_area <= 10000 => 2,
									   pk_add1_building_area <= 30000 => 3,
																		 4);

		pk_add1_no_of_partial_baths :=  if((integer)add1_no_of_partial_baths <= 0, 0, 1);

		pk_property_owned_total :=  map(property_owned_total <= 0 => -1,
										property_owned_total <= 1 => 0,
										property_owned_total <= 4 => 1,
										property_owned_total <= 6 => 2,
																	 3);

		pk_prop_own_assess_tot2 :=  map(pk_property_owned_assessed_total_2 <= 0      => 0,
										pk_property_owned_assessed_total_2 <= 80000  => 1,
										pk_property_owned_assessed_total_2 <= 140000 => 2,
										pk_property_owned_assessed_total_2 <= 260000 => 3,
										pk_property_owned_assessed_total_2 <= 260000 => 4,
																						5);

		pk_prop1_sale_price2 :=  map(pk_prop1_sale_price_2 <= 0     => 0,
									 pk_prop1_sale_price_2 <= 40000 => 1,
																	   2);

		pk_yr_prop2_sale_date2 :=  map(pk_yr_prop2_sale_date <= 1 => 0,
									   pk_yr_prop2_sale_date <= 4 => 1,
									   pk_yr_prop2_sale_date <= 9 => 2,
																	 3);

		pk_add2_no_of_buildings :=  map((integer)add2_no_of_buildings <= 0 => -1,
										(integer)add2_no_of_buildings <= 1 => 0,
										(integer)add2_no_of_buildings <= 5 => 1,
																			  2);

		pk_add2_parking_no_of_cars :=  map((integer)add2_parking_no_of_cars <= 0 => 0,
										   (integer)add2_parking_no_of_cars <= 1 => 1,
										   (integer)add2_parking_no_of_cars <= 2 => 2,
																					3);

		pk_yr_add2_assessed_value_year2 :=  map((real)pk_yr_add2_assessed_value_year <= NULL => -1,
												pk_yr_add2_assessed_value_year <= 0          => 0,
												pk_yr_add2_assessed_value_year <= 1          => 1,
																								2);

		pk_add2_mortgage_risk :=  map(trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 3,
									  trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 3,
									  trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 2,
									  trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 1,
									  trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 0,
									  trim(trim(add2_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																												-1);

		pk_add2_assessed_amount2 :=  map(pk_add2_assessed_amount_2 <= 0      => -1,
										 pk_add2_assessed_amount_2 <= 60000  => 0,
										 pk_add2_assessed_amount_2 <= 100000 => 1,
										 pk_add2_assessed_amount_2 <= 120000 => 2,
										 pk_add2_assessed_amount_2 <= 260000 => 3,
																				4);

		pk_yr_add2_date_first_seen2 :=  map((real)pk_yr_add2_date_first_seen <= NULL => -1,
											pk_yr_add2_date_first_seen <= 1          => 0,
											pk_yr_add2_date_first_seen <= 2          => 1,
											pk_yr_add2_date_first_seen <= 3          => 2,
											pk_yr_add2_date_first_seen <= 4          => 3,
											pk_yr_add2_date_first_seen <= 6          => 4,
											pk_yr_add2_date_first_seen <= 7          => 5,
											pk_yr_add2_date_first_seen <= 8          => 6,
											pk_yr_add2_date_first_seen <= 9          => 7,
											pk_yr_add2_date_first_seen <= 13         => 8,
											pk_yr_add2_date_first_seen <= 17         => 9,
											pk_yr_add2_date_first_seen <= 21         => 10,
																						11);

		pk_yr_add2_date_last_seen2 :=  map((real)pk_yr_add2_date_last_seen <= NULL => -1,
										   pk_yr_add2_date_last_seen <= 1          => 0,
										   pk_yr_add2_date_last_seen <= 2          => 1,
										   pk_yr_add2_date_last_seen <= 3          => 2,
										   pk_yr_add2_date_last_seen <= 5          => 3,
										   pk_yr_add2_date_last_seen <= 6          => 4,
										   pk_yr_add2_date_last_seen <= 10         => 5,
																					  6);

		pk_add3_mortgage_risk :=  map(trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 5,
									  trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 4,
									  trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 3,
									  trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 2,
									  trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 1,
									  trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																												-1);

		pk_add3_assessed_amount2 :=  map(pk_add3_assessed_amount_2 <= 0      => -1,
										 pk_add3_assessed_amount_2 <= 60000  => 0,
										 pk_add3_assessed_amount_2 <= 80000  => 1,
										 pk_add3_assessed_amount_2 <= 140000 => 2,
																				3);

		pk_yr_add3_date_first_seen2 :=  map((real)pk_yr_add3_date_first_seen <= NULL => -1,
											pk_yr_add3_date_first_seen <= 1          => 0,
											pk_yr_add3_date_first_seen <= 2          => 1,
											pk_yr_add3_date_first_seen <= 3          => 2,
											pk_yr_add3_date_first_seen <= 4          => 3,
											pk_yr_add3_date_first_seen <= 5          => 4,
											pk_yr_add3_date_first_seen <= 8          => 5,
											pk_yr_add3_date_first_seen <= 11         => 6,
											pk_yr_add3_date_first_seen <= 14         => 7,
											pk_yr_add3_date_first_seen <= 18         => 8,
																						9);

		pk_watercraft_count :=  map(watercraft_count <= 0 => 0,
									watercraft_count <= 1 => 1,
															 2);

		pk_attr_num_watercraft60 :=  if(attr_num_watercraft60 <= 0, 0, 1);

		pk_yr_liens_last_unrel_date := if (years_liens_last_unrel_date >= 0, roundup(years_liens_last_unrel_date), truncate(years_liens_last_unrel_date));

		pk_yr_liens_unrel_lt_first_seen := if (years_liens_unrel_lt_first_seen >= 0, roundup(years_liens_unrel_lt_first_seen), truncate(years_liens_unrel_lt_first_seen));

		pk_yr_liens_unrel_ot_first_seen := if (years_liens_unrel_ot_first_seen >= 0, roundup(years_liens_unrel_ot_first_seen), truncate(years_liens_unrel_ot_first_seen));

		pk_bk_level_2 :=  map((filing_count >= 2) or (((trim(trim(filing_type, LEFT), LEFT, RIGHT) = '') and (filing_count >= 1)) or ((StringLib.StringToUpperCase(trim(trim(disposition, LEFT), LEFT, RIGHT)) = 'DISMISSED') or (bk_disposed_historical_count >= 2))) => 2,
							  (integer)bk_flag > 0                                                                                                                                                                                                                     => 1,
																																																																		  0);

		pk_liens_unrel_cj_ct :=  map(liens_unrel_cj_ct <= 0 => 0,
									 liens_unrel_cj_ct <= 1 => 1,
									 liens_unrel_cj_ct <= 2 => 2,
									 liens_unrel_cj_ct <= 3 => 3,
															   4);

		pk_liens_unrel_ft_ct :=  if(liens_unrel_ft_ct <= 0, 0, 1);

		pk_liens_unrel_lt_ct :=  if(liens_unrel_lt_ct <= 0, 0, 1);

		pk_liens_unrel_o_ct :=  if(liens_unrel_o_ct <= 0, 0, 1);

		pk_liens_unrel_ot_ct :=  if(liens_unrel_ot_ct <= 0, 0, 1);

		pk_liens_unrel_sc_ct :=  map(liens_unrel_sc_ct <= 0 => 0,
									 liens_unrel_sc_ct <= 1 => 1,
															   2);

		pk_liens_unrel_count := (liens_recent_unreleased_count + liens_historical_unreleased_ct);

		pk_lien_type_level :=  map((pk_liens_unrel_cj_ct >= 4) or ((pk_liens_unrel_lt_ct >= 1) or (pk_liens_unrel_sc_ct >= 2)) => 5,
								   (pk_liens_unrel_cj_ct >= 2) or (pk_liens_unrel_sc_ct >= 1)                                  => 4,
								   pk_liens_unrel_cj_ct >= 1                                                                   => 3,
								   (pk_liens_unrel_ft_ct >= 1) or (pk_liens_unrel_ot_ct >= 1)                                  => 2,
								   (pk_liens_unrel_o_ct >= 1) or (pk_liens_unrel_count >= 1)                                   => 1,
																																  0);

		pk_yr_liens_last_unrel_date2 :=  map((real)pk_yr_liens_last_unrel_date <= NULL => -1,
											 pk_yr_liens_last_unrel_date <= 1          => 0,
											 pk_yr_liens_last_unrel_date <= 2          => 1,
											 pk_yr_liens_last_unrel_date <= 3          => 2,
											 pk_yr_liens_last_unrel_date <= 5          => 3,
																						  4);

		pk_yr_liens_last_unrel_date3 := pk_yr_liens_last_unrel_date2;

		pk_yr_liens_last_unrel_date3_2 :=  if((pk_yr_liens_last_unrel_date3 = -1) and lien_flag, -0.5, pk_yr_liens_last_unrel_date3);

		pk_yr_liens_unrel_lt_first_sn2 :=  map((real)pk_yr_liens_unrel_lt_first_seen <= NULL => -1,
											   pk_yr_liens_unrel_lt_first_seen <= 2          => 0,
																								1);

		pk_yr_liens_unrel_ot_first_sn2 :=  map((real)pk_yr_liens_unrel_ot_first_seen <= NULL => -1,
											   pk_yr_liens_unrel_ot_first_seen <= 3          => 0,
											   pk_yr_liens_unrel_ot_first_seen <= 5          => 1,
																								2);

		pk_attr_eviction_count :=  map(attr_eviction_count <= 0 => 0,
									   attr_eviction_count <= 1 => 1,
									   attr_eviction_count <= 2 => 2,
																   3);

		pk_eviction_level :=  map(attr_eviction_count30 > 0   => 7,
								  attr_eviction_count90 > 0   => 6,
								  attr_eviction_count180 > 0  => 5,
								  attr_eviction_count12 > 0   => 4,
								  attr_eviction_count24 > 0   => 3,
								  attr_eviction_count36 > 0   => 2,
								  pk_attr_eviction_count >= 3 => 2,
								  attr_eviction_count60 > 0   => 1,
								  pk_attr_eviction_count >= 1 => 1,
																 0);

		pk_crime_level :=  map(crime_felony_flag                => 2,
							   crime_drug_flag or source_tot_FF => 1,
																   0);

		pk_attr_total_number_derogs_3 :=  map(attr_total_number_derogs <= 0 => 0,
											  attr_total_number_derogs <= 1 => 1,
											  attr_total_number_derogs <= 2 => 2,
											  attr_total_number_derogs <= 3 => 3,
																			   4);

		pk_yr_rc_ssnhighissue := if (years_rc_ssnhighissue >= 0, roundup(years_rc_ssnhighissue), truncate(years_rc_ssnhighissue));

		pk_addr_not_valid :=  if(trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N', 1, 0);

		pk_area_code_split :=  if(trim(trim(rc_areacodesplitflag, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

		pk_disconnected :=  map(trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'C' => -1,
								phn_disconnected                                => 1,
																				   0);

		pk_phn_cell_pager_inval :=  if(phn_cellpager or phn_inval, 1, 0);

		pk_yr_rc_ssnhighissue2 :=  map((real)pk_yr_rc_ssnhighissue = NULL => -1,
									   pk_yr_rc_ssnhighissue <= 0         => 0,
									   pk_yr_rc_ssnhighissue <= 3         => 1,
									   pk_yr_rc_ssnhighissue <= 10        => 2,
									   pk_yr_rc_ssnhighissue <= 12        => 3,
									   pk_yr_rc_ssnhighissue <= 18        => 4,
									   pk_yr_rc_ssnhighissue <= 21        => 5,
									   pk_yr_rc_ssnhighissue <= 24        => 6,
									   pk_yr_rc_ssnhighissue <= 26        => 7,
									   pk_yr_rc_ssnhighissue <= 28        => 8,
									   pk_yr_rc_ssnhighissue <= 31        => 9,
									   pk_yr_rc_ssnhighissue <= 34        => 10,
									   pk_yr_rc_ssnhighissue <= 39        => 11,
									   pk_yr_rc_ssnhighissue <= 41        => 12,
									   pk_yr_rc_ssnhighissue <= 45        => 13,
																			 14);

		pk_prof_lic_cat :=  map(trim(prof_license_category)='' => -1,
								((integer)prof_license_category <= 1) => 0,
								((integer)prof_license_category <= 3) => 1,
								((integer)prof_license_category <= 4) => 2,
																	   3);

		pk_attr_num_proflic90 :=  if(attr_num_proflic90 > 0, 1, 0);

		pk_attr_num_proflic_exp90 :=  if(attr_num_proflic_exp90 > 0, 1, 0);

		pk_attr_num_proflic_exp12 :=  if(attr_num_proflic_exp12 > 0, 1, 0);

		pk_add_lres_month_avg := if (add_lres_month_avg >= 0, roundup( add_lres_month_avg ), truncate(add_lres_month_avg));

		pk_add1_lres :=  map((integer)add1_pop = 0 => -2,
							 add1_lres <= 0        => -1,
							 add1_lres <= 1        => 0,
							 add1_lres <= 2        => 1,
							 add1_lres <= 3        => 2,
							 add1_lres <= 4        => 3,
							 add1_lres <= 12       => 4,
							 add1_lres <= 15       => 5,
							 add1_lres <= 27       => 6,
							 add1_lres <= 61       => 7,
							 add1_lres <= 102      => 8,
							 add1_lres <= 123      => 9,
							 add1_lres <= 234      => 10,
													  11);

		pk_add2_lres :=  map((integer)add2_pop = 0 => -2,
							 add2_lres <= 0        => -1,
							 add2_lres <= 2        => 0,
							 add2_lres <= 9        => 1,
							 add2_lres <= 21       => 2,
							 add2_lres <= 25       => 3,
							 add2_lres <= 33       => 4,
							 add2_lres <= 50       => 5,
							 add2_lres <= 87       => 6,
							 add2_lres <= 120      => 7,
							 add2_lres <= 168      => 8,
							 add2_lres <= 240      => 9,
													  10);

		pk_add3_lres :=  map((integer)add3_pop = 0 => -2,
							 add3_lres <= 0        => -1,
							 add3_lres <= 35       => 0,
							 add3_lres <= 59       => 1,
							 add3_lres <= 94       => 2,
							 add3_lres <= 119      => 3,
							 add3_lres <= 142      => 4,
							 add3_lres <= 197      => 5,
													  6);

		pk_addrs_5yr :=  map(addrs_5yr <= 0 => 0,
							 addrs_5yr <= 2 => 1,
							 addrs_5yr <= 4 => 2,
							 addrs_5yr <= 6 => 3,
											   4);

		pk_addrs_15yr :=  map(addrs_15yr <= 0  => 0,
							  addrs_15yr <= 9  => 1,
							  addrs_15yr <= 15 => 2,
												  3);

		pk_add_lres_month_avg2 :=  map((real)pk_add_lres_month_avg <= NULL => -1,
									   pk_add_lres_month_avg <= 3          => 0,
									   pk_add_lres_month_avg <= 11         => 1,
									   pk_add_lres_month_avg <= 14         => 2,
									   pk_add_lres_month_avg <= 24         => 3,
									   pk_add_lres_month_avg <= 26         => 4,
									   pk_add_lres_month_avg <= 32         => 5,
									   pk_add_lres_month_avg <= 34         => 6,
									   pk_add_lres_month_avg <= 43         => 7,
									   pk_add_lres_month_avg <= 53         => 8,
									   pk_add_lres_month_avg <= 72         => 9,
									   pk_add_lres_month_avg <= 83         => 10,
									   pk_add_lres_month_avg <= 97         => 11,
									   pk_add_lres_month_avg <= 114        => 12,
									   pk_add_lres_month_avg <= 159        => 13,
									   pk_add_lres_month_avg <= 159        => 14,
									   pk_add_lres_month_avg <= 197        => 15,
									   pk_add_lres_month_avg <= 159        => 16,
																			  17);

		pk_nameperssn_count :=  map(nameperssn_count <= 0 => 0,
									nameperssn_count <= 1 => 1,
															 2);

		pk_ssns_per_adl :=  map(ssns_per_adl <= 0 => -1,
								ssns_per_adl <= 1 => 0,
								ssns_per_adl <= 2 => 1,
								ssns_per_adl <= 3 => 2,
								ssns_per_adl <= 4 => 3,
													 4);

		pk_addrs_per_adl :=  map(addrs_per_adl <= 0  => -6,
								 addrs_per_adl <= 1  => -5,
								 addrs_per_adl <= 2  => -4,
								 addrs_per_adl <= 3  => -3,
								 addrs_per_adl <= 4  => -2,
								 addrs_per_adl <= 5  => -1,
								 addrs_per_adl <= 10 => 0,
								 addrs_per_adl <= 12 => 1,
								 addrs_per_adl <= 18 => 2,
														3);

		pk_phones_per_adl :=  map(phones_per_adl <= 0 => -1,
								  phones_per_adl <= 1 => 0,
								  phones_per_adl <= 2 => 1,
														 2);

		pk_adlperssn_count :=  map(adlperssn_count <= 0 => -1,
								   adlperssn_count <= 1 => 0,
								   adlperssn_count <= 2 => 1,
														   2);

		pk_addrs_per_ssn :=  map(addrs_per_ssn <= 0  => -4,
								 addrs_per_ssn <= 4  => -3,
								 addrs_per_ssn <= 6  => -2,
								 addrs_per_ssn <= 7  => -1,
								 addrs_per_ssn <= 8  => 0,
								 addrs_per_ssn <= 11 => 1,
								 addrs_per_ssn <= 18 => 2,
														3);

		pk_adls_per_addr_b1 := map(adls_per_addr <= 0  => -2,
								   adls_per_addr <= 1  => -1,
								   adls_per_addr <= 2  => 0,
								   adls_per_addr <= 3  => 1,
								   adls_per_addr <= 4  => 2,
								   adls_per_addr <= 5  => 3,
								   adls_per_addr <= 6  => 4,
								   adls_per_addr <= 7  => 5,
								   adls_per_addr <= 8  => 6,
								   adls_per_addr <= 9  => 7,
								   adls_per_addr <= 10 => 8,
								   adls_per_addr <= 11 => 9,
								   adls_per_addr <= 13 => 10,
								   adls_per_addr <= 16 => 11,
								   adls_per_addr <= 21 => 12,
														  13);

		pk_ssns_per_addr2_b1 := map((ssns_per_addr <= 0) and (pk_add1_unit_count2 = 3)       => 10,
									ssns_per_addr <= 0                                       => -2,
									(ssns_per_addr <= 1) and (pk_add1_unit_count2 = 3)       => -2,
									ssns_per_addr <= 1                                       => -1,
									(ssns_per_addr <= 2) and (pk_add1_unit_count2 in [2, 3]) => 6,
									ssns_per_addr <= 2                                       => 0,
									(ssns_per_addr <= 3) and (pk_add1_unit_count2 in [2, 3]) => 10,
									ssns_per_addr <= 3                                       => 1,
									(ssns_per_addr <= 4) and (pk_add1_unit_count2 in [2, 3]) => 10,
									ssns_per_addr <= 4                                       => 2,
									(ssns_per_addr <= 5) and (pk_add1_unit_count2 = 3)       => 10,
									ssns_per_addr <= 5                                       => 3,
									(ssns_per_addr <= 6) and (pk_add1_unit_count2 = 3)       => 11,
									ssns_per_addr <= 6                                       => 4,
									(ssns_per_addr <= 7) and (pk_add1_unit_count2 = 3)       => 11,
									ssns_per_addr <= 7                                       => 5,
									(ssns_per_addr <= 8) and (pk_add1_unit_count2 = 3)       => 12,
									ssns_per_addr <= 8                                       => 6,
									(ssns_per_addr <= 9) and (pk_add1_unit_count2 = 3)       => 12,
									ssns_per_addr <= 9                                       => 7,
									(ssns_per_addr <= 11) and (pk_add1_unit_count2 = 3)      => 12,
									ssns_per_addr <= 11                                      => 8,
									(ssns_per_addr <= 13) and (pk_add1_unit_count2 = 3)      => 12,
									ssns_per_addr <= 13                                      => 9,
									(ssns_per_addr <= 16) and (pk_add1_unit_count2 = 3)      => 12,
									ssns_per_addr <= 16                                      => 10,
									ssns_per_addr <= 24                                      => 11,
																								12);

		pk_phones_per_addr_b1 := map(phones_per_addr <= 0 => -1,
									 phones_per_addr <= 1 => 0,
									 phones_per_addr <= 2 => 1,
									 phones_per_addr <= 3 => 2,
															 3);

		pk_adls_per_addr_b2 := map(adls_per_addr <= 0 => -102,
								   adls_per_addr <= 1 => -101,
								   adls_per_addr <= 2 => 100,
								   adls_per_addr <= 3 => 101,
														 102);

		pk_ssns_per_addr2_b2 := map(ssns_per_addr <= 1  => -101,
									ssns_per_addr <= 2  => 100,
									ssns_per_addr <= 3  => 101,
									ssns_per_addr <= 13 => 102,
														   103);

		pk_phones_per_addr_b2 := map(phones_per_addr <= 0 => 100,
									 phones_per_addr <= 1 => 101,
									 phones_per_addr <= 2 => 102,
															 103);

		pk_phones_per_addr := if((integer)add_apt = 0, pk_phones_per_addr_b1, pk_phones_per_addr_b2);

		pk_adls_per_addr := if((integer)add_apt = 0, pk_adls_per_addr_b1, pk_adls_per_addr_b2);

		pk_ssns_per_addr2 := if((integer)add_apt = 0, pk_ssns_per_addr2_b1, pk_ssns_per_addr2_b2);

		pk_adls_per_phone :=  map(adls_per_phone <= 0 => -2,
								  adls_per_phone <= 1 => -1,
								  adls_per_phone <= 2 => 0,
														 1);

		pk_ssns_per_adl_c6 :=  map(ssns_per_adl_c6 <= 0 => 0,
								   ssns_per_adl_c6 <= 1 => 1,
														   2);

		pk_addrs_per_adl_c6 :=  map(addrs_per_adl_c6 <= 0 => 0,
									addrs_per_adl_c6 <= 1 => 1,
									addrs_per_adl_c6 <= 2 => 2,
															 3);

		pk_phones_per_adl_c6 :=  map(phones_per_adl_c6 <= 0 => -2,
									 phones_per_adl_c6 <= 1 => -1,
									 phones_per_adl_c6 <= 2 => 0,
															   1);

		pk_ssns_per_addr_c6_b1 := map(ssns_per_addr_c6 <= 0 => 0,
									  ssns_per_addr_c6 <= 1 => 1,
									  ssns_per_addr_c6 <= 2 => 2,
									  ssns_per_addr_c6 <= 3 => 3,
									  ssns_per_addr_c6 <= 4 => 4,
									  ssns_per_addr_c6 <= 5 => 5,
															   6);

		pk_phones_per_addr_c6_b1 := map(phones_per_addr_c6 <= 0 => -1,
										phones_per_addr_c6 <= 1 => 0,
										phones_per_addr_c6 <= 2 => 1,
																   2);

		pk_ssns_per_addr_c6_b2 := map(ssns_per_addr_c6 <= 0 => 100,
									  ssns_per_addr_c6 <= 1 => 101,
									  ssns_per_addr_c6 <= 2 => 102,
									  ssns_per_addr_c6 <= 3 => 103,
															   104);

		pk_phones_per_addr_c6_b2 := map(phones_per_addr_c6 <= 0 => 100,
										phones_per_addr_c6 <= 2 => 101,
																   102);

		pk_ssns_per_addr_c6 := if((integer)add_apt = 0, pk_ssns_per_addr_c6_b1, pk_ssns_per_addr_c6_b2);

		pk_phones_per_addr_c6 := if((integer)add_apt = 0, pk_phones_per_addr_c6_b1, pk_phones_per_addr_c6_b2);

		pk_adls_per_phone_c6 :=  map(adls_per_phone_c6 <= 0 => 0,
									 adls_per_phone_c6 <= 1 => 1,
															   2);

		pk_vo_addrs_per_adl :=  if(vo_addrs_per_adl <= 0, 0, 1);

		pk_attr_addrs_last24 :=  map(attr_addrs_last24 <= 0 => 0,
									 attr_addrs_last24 <= 1 => 1,
									 attr_addrs_last24 <= 2 => 2,
									 attr_addrs_last24 <= 3 => 3,
									 attr_addrs_last24 <= 5 => 4,
															   5);

		pk_attr_addrs_last36 :=  map(attr_addrs_last36 <= 0 => 0,
									 attr_addrs_last36 <= 1 => 1,
									 attr_addrs_last36 <= 2 => 2,
									 attr_addrs_last36 <= 3 => 3,
									 attr_addrs_last36 <= 4 => 4,
									 attr_addrs_last36 <= 5 => 5,
															   6);

		pk_college_tier :=  if(trim(ams_college_tier) in ['', '0'], -1, (integer)ams_college_tier);

		ams_class_n_b8 := (real)ams_class;

		ams_class_n_b8_2 := if(((integer)ams_class_n_b8 >= 60), (ams_class_n_b8 + 1900), (ams_class_n_b8 + 2000));

		pk_since_ams_class_year := map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => NULL,
									   trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => NULL,
																						  (integer)(sysyear - ams_class_n_b8_2));
																							
		pk_ams_class_level_b8 := map(pk_since_ams_class_year <= 1 => 0,
									 pk_since_ams_class_year <= 2 => 1,
									 pk_since_ams_class_year <= 3 => 2,
									 pk_since_ams_class_year <= 4 => 3,
									 pk_since_ams_class_year <= 5 => 4,
									 pk_since_ams_class_year <= 10 => 5,
									 pk_since_ams_class_year <= 13 => 6,
									 pk_since_ams_class_year <= 17 => 7,
										  8);

		ams_class_n := map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => NULL,
																			  ams_class_n_b8_2);

		pk_ams_class_level := map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => 1000005,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => 1000004,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => 1000003,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => 1000001,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => 1000000,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => 1000002,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => -1000001,
																					 pk_ams_class_level_b8);

		pk_ams_income_level_code :=  map(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['A', 'B'] => 0,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['C']      => 1,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['D', 'E'] => 2,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['F']      => 3,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['G', 'H'] => 4,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['I', 'J'] => 5,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['K']      => 6,
																											   -1);

		pk_yr_reported_dob := if (years_reported_dob >= 0, roundup(years_reported_dob), truncate(years_reported_dob));

		pk_ams_age :=  map(trim(ams_age)=''   => -1,
						   (integer)ams_age <= 21 => 21,
						   (integer)ams_age <= 22 => 22,
						   (integer)ams_age <= 23 => 23,
						   (integer)ams_age <= 24 => 24,
						   (integer)ams_age <= 25 => 25,
						   (integer)ams_age <= 29 => 29,
													 99);

		pk_inferred_age :=  map(inferred_age <= 0  => -1,
								inferred_age <= 18 => 18,
								inferred_age <= 19 => 19,
								inferred_age <= 20 => 20,
								inferred_age <= 21 => 21,
								inferred_age <= 22 => 22,
								inferred_age <= 24 => 24,
								inferred_age <= 34 => 34,
								inferred_age <= 37 => 37,
								inferred_age <= 41 => 41,
								inferred_age <= 42 => 42,
								inferred_age <= 43 => 43,
								inferred_age <= 44 => 44,
								inferred_age <= 46 => 46,
								inferred_age <= 48 => 48,
								inferred_age <= 52 => 52,
								inferred_age <= 56 => 56,
								inferred_age <= 61 => 61,
													  99);

		pk_yr_reported_dob2 :=  map((real)pk_yr_reported_dob <= NULL => -1,
									pk_yr_reported_dob <= 19         => 19,
									pk_yr_reported_dob <= 21         => 21,
									pk_yr_reported_dob <= 22         => 22,
									pk_yr_reported_dob <= 23         => 23,
									pk_yr_reported_dob <= 32         => 32,
									pk_yr_reported_dob <= 35         => 35,
									pk_yr_reported_dob <= 39         => 39,
									pk_yr_reported_dob <= 42         => 42,
									pk_yr_reported_dob <= 43         => 43,
									pk_yr_reported_dob <= 44         => 44,
									pk_yr_reported_dob <= 45         => 45,
									pk_yr_reported_dob <= 46         => 46,
									pk_yr_reported_dob <= 49         => 49,
									pk_yr_reported_dob <= 57         => 57,
									pk_yr_reported_dob <= 61         => 61,
																		99);

		pk_yr_add1_avm_recording_date := if (years_add1_avm_recording_date >= 0, roundup(years_add1_avm_recording_date), truncate(years_add1_avm_recording_date));

		pk_yr_add1_avm_assess_year := if (years_add1_avm_assess_year >= 0, roundup(years_add1_avm_assess_year), truncate(years_add1_avm_assess_year));

		pk_add1_avm_as := if(trim(add1_avm_assessed_total_value)='', NULL, (20000 * if (((real)add1_avm_assessed_total_value / 20000) >= 0, roundup(((real)add1_avm_assessed_total_value / 20000)), truncate(((real)add1_avm_assessed_total_value / 20000)))));

		pk_add1_avm_mkt := if(trim(add1_avm_market_total_value)='', NULL, (20000 * if (((real)add1_avm_market_total_value / 20000) >= 0, roundup(((real)add1_avm_market_total_value / 20000)), truncate(((real)add1_avm_market_total_value / 20000)))));

		pk_add1_avm_hed := (20000 * if ((add1_avm_hedonic_valuation / 20000) >= 0, roundup((add1_avm_hedonic_valuation / 20000)), truncate((add1_avm_hedonic_valuation / 20000))));

		pk_add1_avm_auto := (20000 * if ((add1_avm_automated_valuation / 20000) >= 0, roundup((add1_avm_automated_valuation / 20000)), truncate((add1_avm_automated_valuation / 20000))));

		pk_add1_avm_auto2 := (20000 * if ((add1_avm_automated_valuation_2 / 20000) >= 0, roundup((add1_avm_automated_valuation_2 / 20000)), truncate((add1_avm_automated_valuation_2 / 20000))));

		pk_add1_avm_auto3 := (20000 * if ((add1_avm_automated_valuation_3 / 20000) >= 0, roundup((add1_avm_automated_valuation_3 / 20000)), truncate((add1_avm_automated_valuation_3 / 20000))));

		pk_add1_avm_auto4 := (20000 * if ((add1_avm_automated_valuation_4 / 20000) >= 0, roundup((add1_avm_automated_valuation_4 / 20000)), truncate((add1_avm_automated_valuation_4 / 20000))));

		pk_add1_avm_med := (20000 * if ((add1_avm_med / 20000) >= 0, roundup((add1_avm_med / 20000)), truncate((add1_avm_med / 20000))));

		pk_add2_avm_sp := if(trim(add2_avm_sales_price)='', NULL, (20000 * if (((real)add2_avm_sales_price / 20000) >= 0, roundup(((real)add2_avm_sales_price / 20000)), truncate(((real)add2_avm_sales_price / 20000)))));

		pk_add2_avm_mkt := if(trim(add2_avm_market_total_value)='', NULL, (20000 * if (((real)add2_avm_market_total_value / 20000) >= 0, roundup(((real)add2_avm_market_total_value / 20000)), truncate(((real)add2_avm_market_total_value / 20000)))));

		pk_add2_avm_hed := (20000 * if ((add2_avm_hedonic_valuation / 20000) >= 0, roundup((add2_avm_hedonic_valuation / 20000)), truncate((add2_avm_hedonic_valuation / 20000))));

		pk_add2_avm_auto := (20000 * if ((add2_avm_automated_valuation / 20000) >= 0, roundup((add2_avm_automated_valuation / 20000)), truncate((add2_avm_automated_valuation / 20000))));

		pk_add2_avm_auto3 := (20000 * if ((add2_avm_automated_valuation_3 / 20000) >= 0, roundup((add2_avm_automated_valuation_3 / 20000)), truncate((add2_avm_automated_valuation_3 / 20000))));

		pk_add2_avm_auto4 := (20000 * if ((add2_avm_automated_valuation_4 / 20000) >= 0, roundup((add2_avm_automated_valuation_4 / 20000)), truncate((add2_avm_automated_valuation_4 / 20000))));

		pk_add1_avm_as_2 :=  if(pk_add1_avm_as > 1000000, 1000000, pk_add1_avm_as);

		pk_add1_avm_mkt_2 :=  if(pk_add1_avm_mkt > 1000000, 1000000, pk_add1_avm_mkt);

		pk_add1_avm_hed_2 :=  if(pk_add1_avm_hed > 1000000, 1000000, pk_add1_avm_hed);

		pk_add1_avm_auto_2 :=  if(pk_add1_avm_auto > 1000000, 1000000, pk_add1_avm_auto);

		pk_add1_avm_auto2_2 :=  if(pk_add1_avm_auto2 > 1000000, 1000000, pk_add1_avm_auto2);

		pk_add1_avm_auto3_2 :=  if(pk_add1_avm_auto3 > 1000000, 1000000, pk_add1_avm_auto3);

		pk_add1_avm_auto4_2 :=  if(pk_add1_avm_auto4 > 1000000, 1000000, pk_add1_avm_auto4);

		pk_add1_avm_med_2 :=  if(pk_add1_avm_med > 1000000, 1000000, pk_add1_avm_med);

		pk_add2_avm_sp_2 :=  if(pk_add2_avm_sp > 1000000, 1000000, pk_add2_avm_sp);

		pk_add2_avm_mkt_2 :=  if(pk_add2_avm_mkt > 1000000, 1000000, pk_add2_avm_mkt);

		pk_add2_avm_hed_2 :=  if(pk_add2_avm_hed > 1000000, 1000000, pk_add2_avm_hed);

		pk_add2_avm_auto_2 :=  if(pk_add2_avm_auto > 1000000, 1000000, pk_add2_avm_auto);

		pk_add2_avm_auto3_2 :=  if(pk_add2_avm_auto3 > 1000000, 1000000, pk_add2_avm_auto3);

		pk_add2_avm_auto4_2 :=  if(pk_add2_avm_auto4 > 1000000, 1000000, pk_add2_avm_auto4);

		pk_add1_avm_to_med_ratio := round(add1_avm_to_med_ratio*10)/10;

		pk_add1_avm_to_med_ratio_2 :=  if((integer)pk_add1_avm_to_med_ratio > 10, 10, pk_add1_avm_to_med_ratio);  

		pk2_add1_avm_as :=  map(pk_add1_avm_as_2 <= 20000  => 0,
								pk_add1_avm_as_2 <= 100000 => 1,
								pk_add1_avm_as_2 <= 500000 => 2,
															  3);

		pk2_add1_avm_mkt :=  map(pk_add1_avm_mkt_2 <= NULL => 1,
								 pk_add1_avm_mkt_2 <= 60000      => 0,
								 pk_add1_avm_mkt_2 <= 80000      => 1,
								 pk_add1_avm_mkt_2 <= 120000     => 2,
								 pk_add1_avm_mkt_2 <= 480000     => 3,
																	4);

		pk2_add1_avm_hed :=  map(pk_add1_avm_hed_2 <= 0      => 3,
								 pk_add1_avm_hed_2 <= 40000  => 0,
								 pk_add1_avm_hed_2 <= 60000  => 1,
								 pk_add1_avm_hed_2 <= 80000  => 2,
								 pk_add1_avm_hed_2 <= 100000 => 3,
								 pk_add1_avm_hed_2 <= 120000 => 4,
								 pk_add1_avm_hed_2 <= 640000 => 5,
																6);

		pk2_add1_avm_auto :=  map(pk_add1_avm_auto_2 <= 0      => 4,
								  pk_add1_avm_auto_2 <= 20000  => 0,
								  pk_add1_avm_auto_2 <= 40000  => 1,
								  pk_add1_avm_auto_2 <= 60000  => 2,
								  pk_add1_avm_auto_2 <= 80000  => 3,
								  pk_add1_avm_auto_2 <= 120000 => 4,
								  pk_add1_avm_auto_2 <= 640000 => 5,
																  6);

		pk2_add1_avm_auto2 :=  map(pk_add1_avm_auto2_2 <= 0      => 4,
								   pk_add1_avm_auto2_2 <= 20000  => 0,
								   pk_add1_avm_auto2_2 <= 40000  => 1,
								   pk_add1_avm_auto2_2 <= 60000  => 2,
								   pk_add1_avm_auto2_2 <= 80000  => 3,
								   pk_add1_avm_auto2_2 <= 120000 => 5,
								   pk_add1_avm_auto2_2 <= 640000 => 6,
																	7);

		pk2_add1_avm_auto3 :=  map(pk_add1_avm_auto3_2 <= 0      => 3,
								   pk_add1_avm_auto3_2 <= 20000  => 0,
								   pk_add1_avm_auto3_2 <= 60000  => 1,
								   pk_add1_avm_auto3_2 <= 80000  => 2,
								   pk_add1_avm_auto3_2 <= 100000 => 3,
								   pk_add1_avm_auto3_2 <= 120000 => 4,
								   pk_add1_avm_auto3_2 <= 140000 => 5,
								   pk_add1_avm_auto3_2 <= 600000 => 6,
																	7);

		pk2_add1_avm_auto4 :=  map(pk_add1_avm_auto4_2 <= 0      => 3,
								   pk_add1_avm_auto4_2 <= 40000  => 0,
								   pk_add1_avm_auto4_2 <= 60000  => 1,
								   pk_add1_avm_auto4_2 <= 80000  => 2,
								   pk_add1_avm_auto4_2 <= 120000 => 3,
								   pk_add1_avm_auto4_2 <= 240000 => 4,
								   pk_add1_avm_auto4_2 <= 560000 => 5,
																	6);

		pk_avm_auto_diff4 :=  if((pk_add1_avm_auto_2 = 0) or (pk_add1_avm_auto4_2 = 0), -999999, (pk_add1_avm_auto_2 - pk_add1_avm_auto4_2));

		pk_avm_auto_diff4_lvl :=  map(pk_avm_auto_diff4 = -999999 => -1,
									  pk_avm_auto_diff4 <= 80000  => 0,
																	 1);

		pk2_add1_avm_med :=  map(pk_add1_avm_med_2 <= 0      => 7,
								 pk_add1_avm_med_2 <= 20000  => 0,
								 pk_add1_avm_med_2 <= 40000  => 1,
								 pk_add1_avm_med_2 <= 60000  => 2,
								 pk_add1_avm_med_2 <= 80000  => 3,
								 pk_add1_avm_med_2 <= 120000 => 4,
								 pk_add1_avm_med_2 <= 620000 => 5,
								 pk_add1_avm_med_2 <= 720000 => 6,
																7);

		// pk2_add1_avm_to_med_ratio :=  map(pk_add1_avm_to_med_ratio_2 <= NULL => 0,
										  // pk_add1_avm_to_med_ratio_2 <= 0.7  => 0,
										  // pk_add1_avm_to_med_ratio_2 <= 1.0  => 1,
										  // pk_add1_avm_to_med_ratio_2 <= 1.1  => 2,
										  // pk_add1_avm_to_med_ratio_2 <= 1.4  => 3,
										  // pk_add1_avm_to_med_ratio_2 <= 1.7  => 4,
																				// 5);
		// to work around the floating point comparison issue, increase the value of the point by 1 and do a less than comparison here
		pk2_add1_avm_to_med_ratio :=  map(pk_add1_avm_to_med_ratio_2 <= NULL => 0,
										  pk_add1_avm_to_med_ratio_2 < 0.8  => 0,
										  pk_add1_avm_to_med_ratio_2 < 1.1  => 1,
										  pk_add1_avm_to_med_ratio_2 < 1.2  => 2,
										  pk_add1_avm_to_med_ratio_2 < 1.5  => 3,
										  pk_add1_avm_to_med_ratio_2 < 1.8  => 4,
																				5);

		pk_add2_avm_hit :=  if(add2_avm_land_use in ['1', '2'], 1, 0);

		pk_avm_hit_level :=  map(((integer)add1_AVM_hit > 0) and (pk_add2_avm_hit > 0) => 2,
								 (integer)add1_AVM_hit > 0                             => 1,
								 pk_add2_avm_hit > 0                                   => -1,
																						  0);

		pk2_add2_avm_sp :=  map((real)pk_add2_avm_sp_2 <= NULL => 3,
								pk_add2_avm_sp_2 <= 20000      => 0,
								pk_add2_avm_sp_2 <= 40000      => 1,
								pk_add2_avm_sp_2 <= 60000      => 2,
								pk_add2_avm_sp_2 <= 80000      => 3,
								pk_add2_avm_sp_2 <= 140000     => 4,
																  5);

		pk2_add2_avm_mkt :=  map((real)pk_add2_avm_mkt_2 <= NULL => 2,
								 pk_add2_avm_mkt_2 <= 40000      => 0,
								 pk_add2_avm_mkt_2 <= 60000      => 1,
								 pk_add2_avm_mkt_2 <= 100000     => 2,
								 pk_add2_avm_mkt_2 <= 460000     => 3,
																	4);

		pk2_add2_avm_hed :=  map(pk_add2_avm_hed_2 <= 0      => 3,
								 pk_add2_avm_hed_2 <= 20000  => 0,
								 pk_add2_avm_hed_2 <= 60000  => 1,
								 pk_add2_avm_hed_2 <= 80000  => 2,
								 pk_add2_avm_hed_2 <= 120000 => 4,
								 pk_add2_avm_hed_2 <= 620000 => 5,
																6);

		pk2_add2_avm_auto :=  map(pk_add2_avm_auto_2 <= 0      => 1,
								  pk_add2_avm_auto_2 <= 60000  => 0,
								  pk_add2_avm_auto_2 <= 80000  => 1,
								  pk_add2_avm_auto_2 <= 520000 => 2,
																  3);

		pk2_add2_avm_auto3 :=  map(pk_add2_avm_auto3_2 <= 0      => 2,
								   pk_add2_avm_auto3_2 <= 40000  => 0,
								   pk_add2_avm_auto3_2 <= 60000  => 1,
								   pk_add2_avm_auto3_2 <= 100000 => 2,
								   pk_add2_avm_auto3_2 <= 680000 => 3,
																	4);

		pk2_add2_avm_auto4 :=  map(pk_add2_avm_auto4_2 <= 0      => 3,
								   pk_add2_avm_auto4_2 <= 40000  => 0,
								   pk_add2_avm_auto4_2 <= 60000  => 1,
								   pk_add2_avm_auto4_2 <= 80000  => 2,
								   pk_add2_avm_auto4_2 <= 100000 => 3,
								   pk_add2_avm_auto4_2 <= 480000 => 4,
																	5);

		pk_add2_avm_auto_diff3 :=  if((pk_add2_avm_auto_2 = 0) or (pk_add2_avm_auto3_2 = 0), -999999, (pk_add2_avm_auto_2 - pk_add2_avm_auto3_2));

		pk_add2_avm_auto_diff3_lvl :=  map(pk_add2_avm_auto_diff3 = -999999 => -2,
										   pk_add2_avm_auto_diff3 < -20000  => -1,
																			   0);

		pk2_yr_add1_avm_recording_date :=  map((real)pk_yr_add1_avm_recording_date <= NULL => 2,
											   pk_yr_add1_avm_recording_date <= 2          => 0,
											   pk_yr_add1_avm_recording_date <= 3          => 1,
											   pk_yr_add1_avm_recording_date <= 5          => 2,
											   pk_yr_add1_avm_recording_date <= 13         => 3,
																							  4);

		pk2_yr_add1_avm_assess_year :=  map((real)pk_yr_add1_avm_assess_year <= NULL => 0,
											pk_yr_add1_avm_assess_year <= 1          => 1,
																						2);

		pk_dist_a1toa2_2 :=  map(dist_a1toa2 = 0    => 0,
								 dist_a1toa2 = 9999 => 4,
								 dist_a1toa2 <= 2   => 3,
								 dist_a1toa2 <= 8   => 2,
													   1);

		pk_dist_a1toa3_2 :=  map(dist_a1toa3 = 0    => 0,
								 dist_a1toa3 = 9999 => 6,
								 dist_a1toa3 <= 1   => 5,
								 dist_a1toa3 <= 2   => 4,
								 dist_a1toa3 <= 4   => 3,
								 dist_a1toa3 <= 40  => 2,
													   1);

		pk_rc_disthphoneaddr_2 :=  map(rc_disthphoneaddr <= 0   => 0,
									   rc_disthphoneaddr = 9999 => 4,
									   rc_disthphoneaddr <= 6   => 1,
									   rc_disthphoneaddr <= 11  => 2,
																   3);

		pk_out_st_division_lvl :=  map(trim(trim(out_st, LEFT), LEFT, RIGHT) in ['IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']             => 0,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['IL', 'IN', 'MI', 'OH', 'WI']                         => 1,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY']       => 2,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AL', 'KY', 'MS', 'TN']                               => 3,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV'] => 4,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['NJ', 'NY', 'PA']                                     => 5,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AK', 'CA', 'HI', 'OR', 'WA']                         => 6,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AR', 'LA', 'OK', 'TX']                               => 7,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'] => 8,
																																		  -1);

		pk_wealth_index_2 :=  map((integer)wealth_index <= 1 => 0,
								  (integer)wealth_index <= 2 => 1,
								  (integer)wealth_index <= 3 => 2,
								  (integer)wealth_index <= 4 => 3,
																4);

		pk_impulse_count := impulse_count;

		pk_impulse_count_2 :=  if(pk_impulse_count > 2, 2, pk_impulse_count);

		pk_attr_total_number_derogs_4 := attr_total_number_derogs;

		pk_attr_total_number_derogs_5 :=  if(pk_attr_total_number_derogs_4 > 3, 3, pk_attr_total_number_derogs_4);

		pk_attr_num_nonderogs90_3 := attr_num_nonderogs90;

		pk_attr_num_nonderogs90_4 :=  if(pk_attr_num_nonderogs90_3 > 4, 4, pk_attr_num_nonderogs90_3);

		pk_derog_total_2 :=  if(pk_attr_total_number_derogs_5 > 0, pk_attr_total_number_derogs_5, (-1 * pk_attr_num_nonderogs90_4));

		pk_attr_num_nonderogs90_b := ((10 * (integer)add1_isbestmatch) + pk_attr_num_nonderogs90_4);

		pk_adl_cat_deceased :=  if(trim(trim(adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0);

		bs_own_rent :=  map((add1_naprop = 4) or (property_owned_total > 0)                                                      => '1 Owner ',
							(trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H') or ((add1_naprop = 1) or (add1_unit_count > 3)) => '2 Renter',
																																	'3 Other ');

		bs_attr_derog_flag :=  if(attr_total_number_derogs > 0, 1, 0);

		bs_attr_eviction_flag :=  if(attr_eviction_count > 0, 1, 0);

		bs_attr_derog_flag2 :=  if((bs_attr_derog_flag > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag > 0) or ((pk_impulse_count_2 > 0) or (((integer)bk_flag > 0) or ((pk_adl_cat_deceased > 0) or ((integer)ssn_deceased > 0)))))), 1, 0);

		pk_Segment := '        ';

		pk_segment_2 :=  if(bs_attr_derog_flag2 = 1, '0 Derog ', bs_own_rent);

		pk_nas_summary_mm_b1_c2_b1 := map(pk_nas_summary = 0 => 0.3327305606,
										  pk_nas_summary = 1 => 0.3308270677,
																0.2488979592);

		pk_nap_summary_mm_b1_c2_b1 := map(pk_nap_summary = -1 => 0.3483870968,
										  pk_nap_summary = 0  => 0.2839238133,
										  pk_nap_summary = 1  => 0.2171684817,
																 0.1945803538);

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2809269162,
													pk_rc_dirsaddr_lastscore = 0  => 0.3106936416,
													pk_rc_dirsaddr_lastscore = 1  => 0.2454308094,
																					 0.234202454);

		pk_adl_score_mm_b1_c2_b1 := map(pk_adl_score = 0 => 0.2727272727,
															0.265189226);

		pk_lname_score_mm_b1_c2_b1 := map(pk_lname_score = 0 => 0.2933507171,
																0.2640209453);

		pk_combo_addrscore_mm_b1_c2_b1 := map(pk_combo_addrscore = 0 => 0.3179190751,
																		0.2609808102);

		pk_combo_hphonescore_mm_b1_c2_b1 := map(pk_combo_hphonescore = 0 => 0.2823032103,
												pk_combo_hphonescore = 1 => 0.2846153846,
																			0.2421069084);

		pk_combo_ssnscore_mm_b1_c2_b1 := map(pk_combo_ssnscore = -1 => 0.3310891089,
											 pk_combo_ssnscore = 0  => 0.3658008658,
																	   0.2482511794);

		pk_eq_count_mm_b1_c2_b1 := map(pk_eq_count = 0 => 0.4375,
									   pk_eq_count = 1 => 0.3982430454,
									   pk_eq_count = 2 => 0.3275529865,
									   pk_eq_count = 3 => 0.2994579946,
									   pk_eq_count = 4 => 0.2592105263,
									   pk_eq_count = 5 => 0.2507090187,
														  0.2457870941);

		pk_pos_secondary_sources_mm_b1_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.2673715008,
													pk_pos_secondary_sources = 1 => 0.1559633028,
																					0.1428571429);

		pk_voter_flag_mm_b1_c2_b1 := map(pk_voter_flag = -1 => 0.2953225313,
										 pk_voter_flag = 0  => 0.2768644747,
															   0.2435203646);

		pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.2896208825,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.2625766871,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.2073954984,
																							  0.19140625);

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2988021587,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.269902338,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.2125480154,
																							  0.2011918275);

		pk_add1_address_score_mm_b1_c2_b1 := map(pk_add1_address_score = 0 => 0.3083076923,
																			  0.2603983597);

		pk_add2_address_score_mm_b1_c2_b1 := map(pk_add2_address_score = 0 => 0.3692077728,
												 pk_add2_address_score = 1 => 0.2620524703,
												 pk_add2_address_score = 2 => 0.2616099071,
																			  0.2299829642);

		pk_add2_pos_sources_mm_b1_c2_b1 := map(pk_add2_pos_sources = 0 => 0.2777044855,
											   pk_add2_pos_sources = 1 => 0.2689043937,
											   pk_add2_pos_sources = 2 => 0.261707989,
											   pk_add2_pos_sources = 3 => 0.2440944882,
																		  0.1859756098);

		pk_add2_pos_secondary_sources_mm_b1_c2_b1 := map(pk_add2_pos_secondary_sources = 0 => 0.2661141805,
														 pk_add2_pos_secondary_sources = 1 => 0.1463414634,
																							  0.1388888889);

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2650162607,
																							  0.2990654206);

		pk_infutor_risk_lvl_mm_b1_c2_b1 := map(pk_infutor_risk_lvl = 0 => 0.2561966257,
											   pk_infutor_risk_lvl = 1 => 0.2345964709,
																		  0.3537353735);

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.2799528049,
													pk_yr_adl_vo_first_seen2 = 0  => 0.2566666667,
													pk_yr_adl_vo_first_seen2 = 1  => 0.2389006342,
													pk_yr_adl_vo_first_seen2 = 2  => 0.2823984526,
																					 0.2350565428);

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.2725767734,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.2142857143,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.2547770701,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.248447205,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.2374798061,
																							   0.2165898618);

		pk_yr_lname_change_date2_mm_b1_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.2611206159,
													pk_yr_lname_change_date2 = 0  => 0.3050397878,
													pk_yr_lname_change_date2 = 1  => 0.3033333333,
																					 0.3514492754);

		pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.2785554879,
													  pk_yr_gong_did_first_seen2 = 0  => 0.3766025641,
													  pk_yr_gong_did_first_seen2 = 1  => 0.3010130246,
													  pk_yr_gong_did_first_seen2 = 2  => 0.2836398838,
													  pk_yr_gong_did_first_seen2 = 3  => 0.2634508349,
																						 0.2402541149);

		pk_yr_credit_first_seen2_mm_b1_c2_b1 := map(pk_yr_credit_first_seen2 = -1 => 0.5333333333,
													pk_yr_credit_first_seen2 = 0  => 0.6640625,
													pk_yr_credit_first_seen2 = 1  => 0.504587156,
													pk_yr_credit_first_seen2 = 2  => 0.4573170732,
													pk_yr_credit_first_seen2 = 3  => 0.3926701571,
													pk_yr_credit_first_seen2 = 4  => 0.3802816901,
													pk_yr_credit_first_seen2 = 5  => 0.3518930958,
													pk_yr_credit_first_seen2 = 6  => 0.3249452954,
													pk_yr_credit_first_seen2 = 7  => 0.276128037,
													pk_yr_credit_first_seen2 = 8  => 0.2813230872,
													pk_yr_credit_first_seen2 = 9  => 0.2276887872,
													pk_yr_credit_first_seen2 = 10 => 0.1952614379,
																					 0.2755905512);

		pk_yr_header_first_seen2_mm_b1_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.4544159544,
													pk_yr_header_first_seen2 = 0  => 0.4593023256,
													pk_yr_header_first_seen2 = 1  => 0.4044117647,
													pk_yr_header_first_seen2 = 2  => 0.3183701657,
													pk_yr_header_first_seen2 = 3  => 0.2961630695,
													pk_yr_header_first_seen2 = 4  => 0.2405310828,
													pk_yr_header_first_seen2 = 5  => 0.1903553299,
													pk_yr_header_first_seen2 = 6  => 0.1719745223,
																					 0.1935483871);

		pk_yr_infutor_first_seen2_mm_b1_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.256274081,
													 pk_yr_infutor_first_seen2 = 0  => 0.2787663108,
													 pk_yr_infutor_first_seen2 = 1  => 0.3097222222,
													 pk_yr_infutor_first_seen2 = 2  => 0.25,
													 pk_yr_infutor_first_seen2 = 3  => 0.2926829268,
																					   0.2352941176);

		pk_em_only_ver_lvl_mm_b1_c2_b1 := map(pk_em_only_ver_lvl = -1 => 0.2090909091,
											  pk_em_only_ver_lvl = 0  => 0.2720606616,
											  pk_em_only_ver_lvl = 1  => 0.2481238274,
											  pk_em_only_ver_lvl = 2  => 0.2107279693,
																		 0.2519379845);

		pk_add2_em_ver_lvl_mm_b1_c2_b1 := map(pk_add2_em_ver_lvl = -1 => 0.3571428571,
											  pk_add2_em_ver_lvl = 0  => 0.2655783258,
											  pk_add2_em_ver_lvl = 1  => 0.2792321117,
																		 0.2245614035);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.5675675676,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.6111111111,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.6391752577,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.5740740741,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.4905660377,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.5,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.3968253968,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.4072164948,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.4485981308,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.36996337,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.3606557377,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2974276527,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2790262172,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2972085386,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2714854866,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.2274035694,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1994167788,
																							  0.1907983762);

		pk_nas_summary_mm_b1_c2_b2 := map(pk_nas_summary = 0 => 0.0958026274,
										  pk_nas_summary = 1 => 0.0542635659,
																0.0557626361);

		pk_nap_summary_mm_b1_c2_b2 := map(pk_nap_summary = -1 => 0.0701468189,
										  pk_nap_summary = 0  => 0.0793148593,
										  pk_nap_summary = 1  => 0.0394133822,
																 0.0421007867);

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := map(pk_rc_dirsaddr_lastscore = -1 => 0.0670529801,
													pk_rc_dirsaddr_lastscore = 0  => 0.0870599429,
													pk_rc_dirsaddr_lastscore = 1  => 0.0817204301,
																					 0.0549379385);

		pk_adl_score_mm_b1_c2_b2 := map(pk_adl_score = 0 => 0.1120448179,
															0.0610658307);

		pk_lname_score_mm_b1_c2_b2 := map(pk_lname_score = 0 => 0.1060606061,
																0.0614846288);

		pk_combo_addrscore_mm_b1_c2_b2 := map(pk_combo_addrscore = 0 => 0.0759493671,
																		0.0628142263);

		pk_combo_hphonescore_mm_b1_c2_b2 := map(pk_combo_hphonescore = 0 => 0.0824576585,
												pk_combo_hphonescore = 1 => 0.0777777778,
																			0.0444312091);

		pk_combo_ssnscore_mm_b1_c2_b2 := map(pk_combo_ssnscore = -1 => 0.0957555178,
											 pk_combo_ssnscore = 0  => 0.1073619632,
																	   0.0550287464);

		pk_eq_count_mm_b1_c2_b2 := map(pk_eq_count = 0 => 0.0921501706,
									   pk_eq_count = 1 => 0.0915841584,
									   pk_eq_count = 2 => 0.0662251656,
									   pk_eq_count = 3 => 0.0598455598,
									   pk_eq_count = 4 => 0.0619088564,
									   pk_eq_count = 5 => 0.0580323786,
														  0.0661610879);

		pk_pos_secondary_sources_mm_b1_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.0643469677,
													pk_pos_secondary_sources = 1 => 0.0357142857,
																					0.012987013);

		pk_voter_flag_mm_b1_c2_b2 := map(pk_voter_flag = -1 => 0.0933254578,
										 pk_voter_flag = 0  => 0.0468052049,
															   0.0611391315);

		pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.072041581,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.0795568983,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.0354191263,
																							  0.0418400876);

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0795454545,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.0803331542,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0366088632,
																							  0.0412782956);

		pk_add1_address_score_mm_b1_c2_b2 := map(pk_add1_address_score = 0 => 0.0802469136,
																			  0.0623817333);

		pk_add2_address_score_mm_b1_c2_b2 := map(pk_add2_address_score = 0 => 0.0877777778,
												 pk_add2_address_score = 1 => 0.0616539244,
												 pk_add2_address_score = 2 => 0.0642076503,
																			  0.0632258065);

		pk_add2_pos_sources_mm_b1_c2_b2 := map(pk_add2_pos_sources = 0 => 0.0616869492,
											   pk_add2_pos_sources = 1 => 0.0634059665,
											   pk_add2_pos_sources = 2 => 0.0704,
											   pk_add2_pos_sources = 3 => 0.0526762957,
																		  0.0652985075);

		pk_add2_pos_secondary_sources_mm_b1_c2_b2 := map(pk_add2_pos_secondary_sources = 0 => 0.0636468237,
														 pk_add2_pos_secondary_sources = 1 => 0.0337078652,
																							  0);

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.0624079529,
																							  0.1005434783);

		pk_infutor_risk_lvl_mm_b1_c2_b2 := map(pk_infutor_risk_lvl = 0 => 0.0520277481,
											   pk_infutor_risk_lvl = 1 => 0.0710250202,
																		  0.1203758074);

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.0653240113,
													pk_yr_adl_vo_first_seen2 = 0  => 0.046997389,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0641267446,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0560420315,
																					 0.0614290333);

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0612043435,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.053030303,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0507462687,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0699588477,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0773722628,
																							   0.0676056338);

		pk_yr_lname_change_date2_mm_b1_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.0619246862,
													pk_yr_lname_change_date2 = 0  => 0.0811808118,
													pk_yr_lname_change_date2 = 1  => 0.0855018587,
																					 0.075);

		pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0722233067,
													  pk_yr_gong_did_first_seen2 = 0  => 0.0894117647,
													  pk_yr_gong_did_first_seen2 = 1  => 0.0909090909,
													  pk_yr_gong_did_first_seen2 = 2  => 0.068762279,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0417801998,
																						 0.057001531);

		pk_yr_credit_first_seen2_mm_b1_c2_b2 := map(pk_yr_credit_first_seen2 = -1 => 0.0704225352,
													pk_yr_credit_first_seen2 = 0  => 0.1855670103,
													pk_yr_credit_first_seen2 = 1  => 0.1052631579,
													pk_yr_credit_first_seen2 = 2  => 0.1148325359,
													pk_yr_credit_first_seen2 = 3  => 0.1168831169,
													pk_yr_credit_first_seen2 = 4  => 0.108490566,
													pk_yr_credit_first_seen2 = 5  => 0.0852428964,
													pk_yr_credit_first_seen2 = 6  => 0.0834123223,
													pk_yr_credit_first_seen2 = 7  => 0.0745293892,
													pk_yr_credit_first_seen2 = 8  => 0.0576496674,
													pk_yr_credit_first_seen2 = 9  => 0.0516853933,
													pk_yr_credit_first_seen2 = 10 => 0.0442493415,
																					 0.028708134);

		pk_yr_header_first_seen2_mm_b1_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.1528239203,
													pk_yr_header_first_seen2 = 0  => 0.0871143376,
													pk_yr_header_first_seen2 = 1  => 0.0708534622,
													pk_yr_header_first_seen2 = 2  => 0.068,
													pk_yr_header_first_seen2 = 3  => 0.0609348915,
													pk_yr_header_first_seen2 = 4  => 0.0580075662,
													pk_yr_header_first_seen2 = 5  => 0.0579710145,
													pk_yr_header_first_seen2 = 6  => 0.0575620767,
																					 0.0373931624);

		pk_yr_infutor_first_seen2_mm_b1_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.0520277481,
													 pk_yr_infutor_first_seen2 = 0  => 0.0720798958,
													 pk_yr_infutor_first_seen2 = 1  => 0.1057452123,
													 pk_yr_infutor_first_seen2 = 2  => 0.0932017544,
													 pk_yr_infutor_first_seen2 = 3  => 0.0882352941,
																					   0.0931174089);

		pk_em_only_ver_lvl_mm_b1_c2_b2 := map(pk_em_only_ver_lvl = -1 => 0.0580645161,
											  pk_em_only_ver_lvl = 0  => 0.0611276872,
											  pk_em_only_ver_lvl = 1  => 0.079303675,
											  pk_em_only_ver_lvl = 2  => 0.0443349754,
																		 0.0722733246);

		pk_add2_em_ver_lvl_mm_b1_c2_b2 := map(pk_add2_em_ver_lvl = -1 => 0.0454545455,
											  pk_add2_em_ver_lvl = 0  => 0.0617417954,
											  pk_add2_em_ver_lvl = 1  => 0.1019736842,
																		 0.0657142857);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1428571429,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1882352941,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.137254902,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1034482759,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.1428571429,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1386138614,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1082089552,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.106870229,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.109375,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0859073359,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.084592145,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0697954272,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0678899083,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0523961661,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0511788384,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0444177671,
																							  0.0441518203);

		pk_nas_summary_mm_b1_c2_b3 := map(pk_nas_summary = 0 => 0.2631218622,
										  pk_nas_summary = 1 => 0.2296511628,
																0.2053486151);

		pk_nap_summary_mm_b1_c2_b3 := map(pk_nap_summary = -1 => 0.3167082294,
										  pk_nap_summary = 0  => 0.2372865365,
										  pk_nap_summary = 1  => 0.1542912247,
																 0.1390999416);

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2188449848,
													pk_rc_dirsaddr_lastscore = 0  => 0.2637258013,
													pk_rc_dirsaddr_lastscore = 1  => 0.2156862745,
																					 0.1980906921);

		pk_adl_score_mm_b1_c2_b3 := map(pk_adl_score = 0 => 0.2192429022,
															0.2240473548);

		pk_lname_score_mm_b1_c2_b3 := map(pk_lname_score = 0 => 0.230015083,
																0.2231927006);

		pk_combo_addrscore_mm_b1_c2_b3 := map(pk_combo_addrscore = 0 => 0.2690972222,
																		0.2150274377);

		pk_combo_hphonescore_mm_b1_c2_b3 := map(pk_combo_hphonescore = 0 => 0.2391555145,
												pk_combo_hphonescore = 1 => 0.2427184466,
																			0.198772778);

		pk_combo_ssnscore_mm_b1_c2_b3 := map(pk_combo_ssnscore = -1 => 0.2660954712,
											 pk_combo_ssnscore = 0  => 0.2532299742,
																	   0.204815542);

		pk_eq_count_mm_b1_c2_b3 := map(pk_eq_count = 0 => 0.3053278689,
									   pk_eq_count = 1 => 0.2719680465,
									   pk_eq_count = 2 => 0.2513489209,
									   pk_eq_count = 3 => 0.194980695,
									   pk_eq_count = 4 => 0.1849710983,
									   pk_eq_count = 5 => 0.1827610048,
														  0.1751874574);

		pk_pos_secondary_sources_mm_b1_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.2247119078,
													pk_pos_secondary_sources = 1 => 0.1147540984,
																					0.0333333333);

		pk_voter_flag_mm_b1_c2_b3 := map(pk_voter_flag = -1 => 0.2387144715,
										 pk_voter_flag = 0  => 0.2281696054,
															   0.1986506747);

		pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.2374517375,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.256768559,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.1294452347,
																							  0.139845397);

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2395659432,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.2534974818,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.147826087,
																							  0.1515458692);

		pk_add1_address_score_mm_b1_c2_b3 := map(pk_add1_address_score = 0 => 0.2602409639,
																			  0.2144254714);

		pk_add2_address_score_mm_b1_c2_b3 := map(pk_add2_address_score = 0 => 0.2772797527,
												 pk_add2_address_score = 1 => 0.2081669329,
												 pk_add2_address_score = 2 => 0.2263242376,
																			  0.16);

		pk_add2_pos_sources_mm_b1_c2_b3 := map(pk_add2_pos_sources = 0 => 0.2726510067,
											   pk_add2_pos_sources = 1 => 0.2113763211,
											   pk_add2_pos_sources = 2 => 0.2267689685,
											   pk_add2_pos_sources = 3 => 0.1512820513,
																		  0.1407035176);

		pk_add2_pos_secondary_sources_mm_b1_c2_b3 := map(pk_add2_pos_secondary_sources = 0 => 0.2241354875,
														 pk_add2_pos_secondary_sources = 1 => 0.0967741935,
																							  0.1666666667);

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.228078112,
																							  0.1602708804);

		pk_infutor_risk_lvl_mm_b1_c2_b3 := map(pk_infutor_risk_lvl = 0 => 0.2167459778,
											   pk_infutor_risk_lvl = 1 => 0.1765154403,
																		  0.292962963);

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.2313822479,
													pk_yr_adl_vo_first_seen2 = 0  => 0.2242562929,
													pk_yr_adl_vo_first_seen2 = 1  => 0.1935483871,
													pk_yr_adl_vo_first_seen2 = 2  => 0.2296072508,
																					 0.1847922193);

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.2283720175,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.1939393939,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.1706349206,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.152,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.2186192469,
																							   0.1518987342);

		pk_yr_lname_change_date2_mm_b1_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.2219644238,
													pk_yr_lname_change_date2 = 0  => 0.2330827068,
													pk_yr_lname_change_date2 = 1  => 0.2660194175,
																					 0.2093023256);

		pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.2385612272,
													  pk_yr_gong_did_first_seen2 = 0  => 0.3240611961,
													  pk_yr_gong_did_first_seen2 = 1  => 0.2581120944,
													  pk_yr_gong_did_first_seen2 = 2  => 0.217552534,
													  pk_yr_gong_did_first_seen2 = 3  => 0.1799746515,
																						 0.1773385301);

		pk_yr_credit_first_seen2_mm_b1_c2_b3 := map(pk_yr_credit_first_seen2 = -1 => 0.3439153439,
													pk_yr_credit_first_seen2 = 0  => 0.3086109365,
													pk_yr_credit_first_seen2 = 1  => 0.2832422587,
													pk_yr_credit_first_seen2 = 2  => 0.2640562249,
													pk_yr_credit_first_seen2 = 3  => 0.2215435869,
													pk_yr_credit_first_seen2 = 4  => 0.2227122381,
													pk_yr_credit_first_seen2 = 5  => 0.1893382353,
													pk_yr_credit_first_seen2 = 6  => 0.1994301994,
													pk_yr_credit_first_seen2 = 7  => 0.2080856124,
													pk_yr_credit_first_seen2 = 8  => 0.2071494042,
													pk_yr_credit_first_seen2 = 9  => 0.1765834933,
													pk_yr_credit_first_seen2 = 10 => 0.1327498177,
																					 0.0714285714);

		pk_yr_header_first_seen2_mm_b1_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.2519284172,
													pk_yr_header_first_seen2 = 0  => 0.2565564424,
													pk_yr_header_first_seen2 = 1  => 0.2721474132,
													pk_yr_header_first_seen2 = 2  => 0.1760104302,
													pk_yr_header_first_seen2 = 3  => 0.1580381471,
													pk_yr_header_first_seen2 = 4  => 0.176728335,
													pk_yr_header_first_seen2 = 5  => 0.1616161616,
													pk_yr_header_first_seen2 = 6  => 0.0909090909,
																					 0.1578947368);

		pk_yr_infutor_first_seen2_mm_b1_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.2167459778,
													 pk_yr_infutor_first_seen2 = 0  => 0.2354878551,
													 pk_yr_infutor_first_seen2 = 1  => 0.2503703704,
													 pk_yr_infutor_first_seen2 = 2  => 0.2263033175,
													 pk_yr_infutor_first_seen2 = 3  => 0.2463054187,
																					   0.1802721088);

		pk_em_only_ver_lvl_mm_b1_c2_b3 := map(pk_em_only_ver_lvl = -1 => 0.2058823529,
											  pk_em_only_ver_lvl = 0  => 0.2282218597,
											  pk_em_only_ver_lvl = 1  => 0.1948051948,
											  pk_em_only_ver_lvl = 2  => 0.1581027668,
																		 0.2276119403);

		pk_add2_em_ver_lvl_mm_b1_c2_b3 := map(pk_add2_em_ver_lvl = -1 => 0.2,
											  pk_add2_em_ver_lvl = 0  => 0.2252836305,
											  pk_add2_em_ver_lvl = 1  => 0.1963824289,
																		 0.1678321678);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3649851632,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3465703971,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.2920747996,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.2775800712,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.2871287129,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2635574837,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.220657277,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.2256355932,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.2040358744,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.2275312856,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1879235983,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2129173508,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1916488223,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2186878728,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1963087248,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1734104046,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1281840592,
																							  0.1551724138);

		pk_nas_summary_mm_b1_c2_b4 := map(pk_nas_summary = 0 => 0.2306501548,
										  pk_nas_summary = 1 => 0.2126865672,
																0.1780382084);

		pk_nap_summary_mm_b1_c2_b4 := map(pk_nap_summary = -1 => 0.2559808612,
										  pk_nap_summary = 0  => 0.2145028224,
										  pk_nap_summary = 1  => 0.1275766017,
																 0.1443298969);

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b4 := map(pk_rc_dirsaddr_lastscore = -1 => 0.1864168618,
													pk_rc_dirsaddr_lastscore = 0  => 0.2543859649,
													pk_rc_dirsaddr_lastscore = 1  => 0.1574074074,
																					 0.1655712841);

		pk_adl_score_mm_b1_c2_b4 := map(pk_adl_score = 0 => 0.2234042553,
															0.1866258159);

		pk_lname_score_mm_b1_c2_b4 := map(pk_lname_score = 0 => 0.1808118081,
																0.1884917897);

		pk_combo_addrscore_mm_b1_c2_b4 := map(pk_combo_addrscore = 0 => 0.253164557,
																		0.1852000535);

		pk_combo_hphonescore_mm_b1_c2_b4 := map(pk_combo_hphonescore = 0 => 0.2159599684,
												pk_combo_hphonescore = 1 => 0.2068965517,
																			0.1603072983);

		pk_combo_ssnscore_mm_b1_c2_b4 := map(pk_combo_ssnscore = -1 => 0.2286432161,
											 pk_combo_ssnscore = 0  => 0.3039215686,
																	   0.1766546706);

		pk_eq_count_mm_b1_c2_b4 := map(pk_eq_count = 0 => 0.2453102453,
									   pk_eq_count = 1 => 0.2186070158,
									   pk_eq_count = 2 => 0.1953255426,
									   pk_eq_count = 3 => 0.2016806723,
									   pk_eq_count = 4 => 0.1625344353,
									   pk_eq_count = 5 => 0.1665141812,
														  0.1225165563);

		pk_pos_secondary_sources_mm_b1_c2_b4 := map(pk_pos_secondary_sources = 0 => 0.1894983104,
													pk_pos_secondary_sources = 1 => 0.0652173913,
																					0.0612244898);

		pk_voter_flag_mm_b1_c2_b4 := map(pk_voter_flag = -1 => 0.2382925818,
										 pk_voter_flag = 0  => 0.1668512366,
															   0.1638545182);

		pk_fname_eda_sourced_type_lvl_mm_b1_c2_b4 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.1939176491,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.2195467422,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.1548672566,
																							  0.1384462151);

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2240729101,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.2090261283,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.1425287356,
																							  0.1354501608);

		pk_add1_address_score_mm_b1_c2_b4 := map(pk_add1_address_score = 0 => 0.2277039848,
																			  0.1850729826);

		pk_add2_address_score_mm_b1_c2_b4 := map(pk_add2_address_score = 0 => 0.2157824342,
												 pk_add2_address_score = 1 => 0.177399757,
												 pk_add2_address_score = 2 => 0.1758957655,
																			  0.1661129568);

		pk_add2_pos_sources_mm_b1_c2_b4 := map(pk_add2_pos_sources = 0 => 0.2101305896,
											   pk_add2_pos_sources = 1 => 0.1813667534,
											   pk_add2_pos_sources = 2 => 0.1676646707,
											   pk_add2_pos_sources = 3 => 0.1349480969,
																		  0.1973684211);

		pk_add2_pos_secondary_sources_mm_b1_c2_b4 := map(pk_add2_pos_secondary_sources = 0 => 0.1884992264,
														 pk_add2_pos_secondary_sources = 1 => 0.1052631579,
																							  0);

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b4 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.1890851149,
																							  0.1550387597);

		pk_infutor_risk_lvl_mm_b1_c2_b4 := map(pk_infutor_risk_lvl = 0 => 0.1714446318,
											   pk_infutor_risk_lvl = 1 => 0.1707317073,
																		  0.3101604278);

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b4 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.1974309344,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1825396825,
													pk_yr_adl_vo_first_seen2 = 1  => 0.1751824818,
													pk_yr_adl_vo_first_seen2 = 2  => 0.1382488479,
																					 0.1496932515);

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1917787743,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.2170542636,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.2173913043,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.1179245283,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.1625441696,
																							   0.1111111111);

		pk_yr_lname_change_date2_mm_b1_c2_b4 := map(pk_yr_lname_change_date2 = -1 => 0.1855597696,
													pk_yr_lname_change_date2 = 0  => 0.2238095238,
													pk_yr_lname_change_date2 = 1  => 0.2239747634,
																					 0.1748251748);

		pk_yr_gong_did_first_seen2_mm_b1_c2_b4 := map(pk_yr_gong_did_first_seen2 = -1 => 0.1897369556,
													  pk_yr_gong_did_first_seen2 = 0  => 0.2925925926,
													  pk_yr_gong_did_first_seen2 = 1  => 0.2343096234,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1676300578,
													  pk_yr_gong_did_first_seen2 = 3  => 0.1865889213,
																						 0.1674347158);

		pk_yr_credit_first_seen2_mm_b1_c2_b4 := map(pk_yr_credit_first_seen2 = -1 => 0.2944162437,
													pk_yr_credit_first_seen2 = 0  => 0.2895442359,
													pk_yr_credit_first_seen2 = 1  => 0.2361359571,
													pk_yr_credit_first_seen2 = 2  => 0.2415841584,
													pk_yr_credit_first_seen2 = 3  => 0.1614583333,
													pk_yr_credit_first_seen2 = 4  => 0.1784037559,
													pk_yr_credit_first_seen2 = 5  => 0.1780104712,
													pk_yr_credit_first_seen2 = 6  => 0.1737451737,
													pk_yr_credit_first_seen2 = 7  => 0.2018244014,
													pk_yr_credit_first_seen2 = 8  => 0.1778711485,
													pk_yr_credit_first_seen2 = 9  => 0.1183574879,
													pk_yr_credit_first_seen2 = 10 => 0.1135734072,
																					 0.1153846154);

		pk_yr_header_first_seen2_mm_b1_c2_b4 := map(pk_yr_header_first_seen2 = -1 => 0.2123123123,
													pk_yr_header_first_seen2 = 0  => 0.245,
													pk_yr_header_first_seen2 = 1  => 0.2595870206,
													pk_yr_header_first_seen2 = 2  => 0.1504286828,
													pk_yr_header_first_seen2 = 3  => 0.119804401,
													pk_yr_header_first_seen2 = 4  => 0.1448371448,
													pk_yr_header_first_seen2 = 5  => 0.115942029,
													pk_yr_header_first_seen2 = 6  => 0.2073170732,
																					 0.0736842105);

		pk_yr_infutor_first_seen2_mm_b1_c2_b4 := map(pk_yr_infutor_first_seen2 = -1 => 0.1714446318,
													 pk_yr_infutor_first_seen2 = 0  => 0.2138728324,
													 pk_yr_infutor_first_seen2 = 1  => 0.2551210428,
													 pk_yr_infutor_first_seen2 = 2  => 0.2282958199,
													 pk_yr_infutor_first_seen2 = 3  => 0.1991150442,
																					   0.2215568862);

		pk_em_only_ver_lvl_mm_b1_c2_b4 := map(pk_em_only_ver_lvl = -1 => 0.0555555556,
											  pk_em_only_ver_lvl = 0  => 0.1918385785,
											  pk_em_only_ver_lvl = 1  => 0.1873065015,
											  pk_em_only_ver_lvl = 2  => 0.1488549618,
																		 0.1451612903);

		pk_add2_em_ver_lvl_mm_b1_c2_b4 := map(pk_add2_em_ver_lvl = -1 => 0,
											  pk_add2_em_ver_lvl = 0  => 0.1880923775,
											  pk_add2_em_ver_lvl = 1  => 0.2328042328,
																		 0.1157894737);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3163841808,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3083700441,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.2867647059,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.2258064516,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.2566037736,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2282157676,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1929824561,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1467505241,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.1733870968,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1746411483,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1735099338,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.1942286349,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1895551257,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1826625387,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1761658031,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1189320388,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1138211382,
																							  0.1144578313);

		pk_nap_summary_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_nap_summary_mm_b1_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nap_summary_mm_b1_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nap_summary_mm_b1_c2_b3,
																 pk_nap_summary_mm_b1_c2_b4);

		pk_yr_gong_did_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b2,
												pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b1_c2_b3,
																			 pk_yr_gong_did_first_seen2_mm_b1_c2_b4);

		pk_add2_pos_secondary_sources_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_secondary_sources_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_add2_pos_secondary_sources_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_add2_pos_secondary_sources_mm_b1_c2_b3,
																				pk_add2_pos_secondary_sources_mm_b1_c2_b4);

		pk_nas_summary_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_nas_summary_mm_b1_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nas_summary_mm_b1_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nas_summary_mm_b1_c2_b3,
																 pk_nas_summary_mm_b1_c2_b4);

		pk_yr_infutor_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_infutor_first_seen2_mm_b1_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_infutor_first_seen2_mm_b1_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_infutor_first_seen2_mm_b1_c2_b3,
																			pk_yr_infutor_first_seen2_mm_b1_c2_b4);

		pk_yr_adl_em_only_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3,
																				pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4);

		pk_combo_hphonescore_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_hphonescore_mm_b1_c2_b1,
										  pk_segment_2 = '1 Owner ' => pk_combo_hphonescore_mm_b1_c2_b2,
										  pk_segment_2 = '2 Renter' => pk_combo_hphonescore_mm_b1_c2_b3,
																	   pk_combo_hphonescore_mm_b1_c2_b4);

		pk_lname_score_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_lname_score_mm_b1_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_lname_score_mm_b1_c2_b2,
									pk_segment_2 = '2 Renter' => pk_lname_score_mm_b1_c2_b3,
																 pk_lname_score_mm_b1_c2_b4);

		pk_yr_lname_change_date2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_lname_change_date2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_lname_change_date2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_lname_change_date2_mm_b1_c2_b3,
																		   pk_yr_lname_change_date2_mm_b1_c2_b4);

		pk_ssnchar_invalid_or_recent_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b1,
												  pk_segment_2 = '1 Owner ' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b2,
												  pk_segment_2 = '2 Renter' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b3,
																			   pk_ssnchar_invalid_or_recent_mm_b1_c2_b4);

		pk_add2_em_ver_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add2_em_ver_lvl_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_add2_em_ver_lvl_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_add2_em_ver_lvl_mm_b1_c2_b3,
																	 pk_add2_em_ver_lvl_mm_b1_c2_b4);

		pk_yr_credit_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_credit_first_seen2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_credit_first_seen2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_credit_first_seen2_mm_b1_c2_b3,
																		   pk_yr_credit_first_seen2_mm_b1_c2_b4);

		pk_adl_score_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_adl_score_mm_b1_c2_b1,
								  pk_segment_2 = '1 Owner ' => pk_adl_score_mm_b1_c2_b2,
								  pk_segment_2 = '2 Renter' => pk_adl_score_mm_b1_c2_b3,
															   pk_adl_score_mm_b1_c2_b4);

		pk_yr_header_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_header_first_seen2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_header_first_seen2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_header_first_seen2_mm_b1_c2_b3,
																		   pk_yr_header_first_seen2_mm_b1_c2_b4);

		pk_eq_count_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_eq_count_mm_b1_c2_b1,
								 pk_segment_2 = '1 Owner ' => pk_eq_count_mm_b1_c2_b2,
								 pk_segment_2 = '2 Renter' => pk_eq_count_mm_b1_c2_b3,
															  pk_eq_count_mm_b1_c2_b4);

		pk_em_only_ver_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_em_only_ver_lvl_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_em_only_ver_lvl_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_em_only_ver_lvl_mm_b1_c2_b3,
																	 pk_em_only_ver_lvl_mm_b1_c2_b4);

		pk_rc_dirsaddr_lastscore_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b3,
																		   pk_rc_dirsaddr_lastscore_mm_b1_c2_b4);

		pk_add1_address_score_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add1_address_score_mm_b1_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_address_score_mm_b1_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_address_score_mm_b1_c2_b3,
																		pk_add1_address_score_mm_b1_c2_b4);

		pk_yr_adl_vo_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b3,
																		   pk_yr_adl_vo_first_seen2_mm_b1_c2_b4);

		pk_pos_secondary_sources_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b1_c2_b3,
																		   pk_pos_secondary_sources_mm_b1_c2_b4);

		pk_combo_addrscore_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_addrscore_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_combo_addrscore_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_combo_addrscore_mm_b1_c2_b3,
																	 pk_combo_addrscore_mm_b1_c2_b4);

		pk_voter_flag_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b1_c2_b1,
								   pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b1_c2_b2,
								   pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b1_c2_b3,
																pk_voter_flag_mm_b1_c2_b4);

		pk_combo_ssnscore_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_ssnscore_mm_b1_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssnscore_mm_b1_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssnscore_mm_b1_c2_b3,
																	pk_combo_ssnscore_mm_b1_c2_b4);

		pk_add2_address_score_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add2_address_score_mm_b1_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_address_score_mm_b1_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_address_score_mm_b1_c2_b3,
																		pk_add2_address_score_mm_b1_c2_b4);

		pk_add2_pos_sources_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b1_c2_b3,
																	  pk_add2_pos_sources_mm_b1_c2_b4);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3,
																			pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4);

		pk_fname_eda_sourced_type_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3,
																				pk_fname_eda_sourced_type_lvl_mm_b1_c2_b4);

		pk_infutor_risk_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_infutor_risk_lvl_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_infutor_risk_lvl_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_infutor_risk_lvl_mm_b1_c2_b3,
																	  pk_infutor_risk_lvl_mm_b1_c2_b4);

		pk_lname_eda_sourced_type_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3,
																				pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4);

		pk_nas_summary_mm_b2_c2_b1 := map(pk_nas_summary = 0 => 0.4031753969,
										  pk_nas_summary = 1 => 0.3506547209,
																0.3075042777);

		pk_nap_summary_mm_b2_c2_b1 := map(pk_nap_summary = -1 => 0.3643865364,
										  pk_nap_summary = 0  => 0.3669935949,
										  pk_nap_summary = 1  => 0.2805071315,
																 0.2736982644);

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := map(pk_rc_dirsaddr_lastscore = -1 => 0.3484066768,
													pk_rc_dirsaddr_lastscore = 0  => 0.3880576337,
													pk_rc_dirsaddr_lastscore = 1  => 0.3904109589,
																					 0.3502868069);

		pk_adl_score_mm_b2_c2_b1 := map(pk_adl_score = 0 => 0.3584828711,
															0.3599469935);

		pk_lname_score_mm_b2_c2_b1 := map(pk_lname_score = 0 => 0.4082568807,
																0.3564129385);

		pk_combo_addrscore_mm_b2_c2_b1 := map(pk_combo_addrscore = 0 => 0.3630597368,
																		0.3472780417);

		pk_combo_hphonescore_mm_b2_c2_b1 := map(pk_combo_hphonescore = 0 => 0.3657918969,
												pk_combo_hphonescore = 1 => 0.3695652174,
																			0.3483355234);

		pk_combo_ssnscore_mm_b2_c2_b1 := map(pk_combo_ssnscore = -1 => 0.4021149297,
											 pk_combo_ssnscore = 0  => 0.4221938776,
																	   0.3408663911);

		pk_eq_count_mm_b2_c2_b1 := map(pk_eq_count = 0 => 0.4717348928,
									   pk_eq_count = 1 => 0.4803675856,
									   pk_eq_count = 2 => 0.4367631297,
									   pk_eq_count = 3 => 0.4347133758,
									   pk_eq_count = 4 => 0.3893740902,
									   pk_eq_count = 5 => 0.3527365295,
														  0.3137414334);

		pk_pos_secondary_sources_mm_b2_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.3622380825,
													pk_pos_secondary_sources = 1 => 0.2028985507,
																					0.1979166667);

		pk_voter_flag_mm_b2_c2_b1 := map(pk_voter_flag = -1 => 0.3969933185,
										 pk_voter_flag = 0  => 0.3779853235,
															   0.3259793641);

		pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.3685884026,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.3246878002,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.2365063788,
																							  0.2852664577);

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.3668847061,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.3706371191,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.2426229508,
																							  0.3275862069);

		pk_add1_address_score_mm_b2_c2_b1 := map(pk_add1_address_score = 0 => 0.3678140835,
																			  0.3104099245);

		pk_add2_address_score_mm_b2_c2_b1 := map(pk_add2_address_score = 0 => 0.3177339901,
												 pk_add2_address_score = 1 => 0.363424411,
												 pk_add2_address_score = 2 => 0.292760541,
																			  0.3865030675);

		pk_add2_pos_sources_mm_b2_c2_b1 := map(pk_add2_pos_sources = 0 => 0.3705416116,
											   pk_add2_pos_sources = 1 => 0.3868440758,
											   pk_add2_pos_sources = 2 => 0.3425468904,
											   pk_add2_pos_sources = 3 => 0.2833428735,
																		  0.2206375839);

		pk_add2_pos_secondary_sources_mm_b2_c2_b1 := map(pk_add2_pos_secondary_sources = 0 => 0.3606136175,
														 pk_add2_pos_secondary_sources = 1 => 0.1728395062,
																							  0.2452830189);

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.359854434,
																							  0.3575757576);

		pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := map(pk_infutor_risk_lvl_nb = 0 => 0.290881688,
												  pk_infutor_risk_lvl_nb = 1 => 0.3548481823,
												  pk_infutor_risk_lvl_nb = 2 => 0.2644602536,
																				0.4564133254);

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.3838452506,
													pk_yr_adl_vo_first_seen2 = 0  => 0.3505603985,
													pk_yr_adl_vo_first_seen2 = 1  => 0.3157894737,
													pk_yr_adl_vo_first_seen2 = 2  => 0.3253424658,
																					 0.3171762366);

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.3691842615,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.273556231,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.3610547667,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.3576642336,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.3161131611,
																							   0.2586872587);

		pk_yr_lname_change_date2_mm_b2_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.3553307774,
													pk_yr_lname_change_date2 = 0  => 0.3967684022,
													pk_yr_lname_change_date2 = 1  => 0.4280476627,
																					 0.3940092166);

		pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.3808960997,
													  pk_yr_gong_did_first_seen2 = 0  => 0.4377729258,
													  pk_yr_gong_did_first_seen2 = 1  => 0.3868725869,
													  pk_yr_gong_did_first_seen2 = 2  => 0.3998845932,
													  pk_yr_gong_did_first_seen2 = 3  => 0.3816878103,
																						 0.3241158114);

		pk_yr_credit_first_seen2_mm_b2_c2_b1 := map(pk_yr_credit_first_seen2 = -1 => 0.4585798817,
													pk_yr_credit_first_seen2 = 0  => 0.6213017751,
													pk_yr_credit_first_seen2 = 1  => 0.5299539171,
													pk_yr_credit_first_seen2 = 2  => 0.6070381232,
													pk_yr_credit_first_seen2 = 3  => 0.4978213508,
													pk_yr_credit_first_seen2 = 4  => 0.4634525661,
													pk_yr_credit_first_seen2 = 5  => 0.4616182573,
													pk_yr_credit_first_seen2 = 6  => 0.4458464774,
													pk_yr_credit_first_seen2 = 7  => 0.4035728786,
													pk_yr_credit_first_seen2 = 8  => 0.3629719854,
													pk_yr_credit_first_seen2 = 9  => 0.3087431694,
													pk_yr_credit_first_seen2 = 10 => 0.2499670054,
																					 0.2287581699);

		pk_yr_header_first_seen2_mm_b2_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.5054787994,
													pk_yr_header_first_seen2 = 0  => 0.45875,
													pk_yr_header_first_seen2 = 1  => 0.5074626866,
													pk_yr_header_first_seen2 = 2  => 0.4211805556,
													pk_yr_header_first_seen2 = 3  => 0.3939016801,
													pk_yr_header_first_seen2 = 4  => 0.3293303992,
													pk_yr_header_first_seen2 = 5  => 0.25,
													pk_yr_header_first_seen2 = 6  => 0.2195892575,
																					 0.2357274401);

		pk_yr_infutor_first_seen2_mm_b2_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.3548481823,
													 pk_yr_infutor_first_seen2 = 0  => 0.3834224599,
													 pk_yr_infutor_first_seen2 = 1  => 0.3692093347,
													 pk_yr_infutor_first_seen2 = 2  => 0.340367597,
													 pk_yr_infutor_first_seen2 = 3  => 0.3855555556,
																					   0.3170320405);

		pk_em_only_ver_lvl_mm_b2_c2_b1 := map(pk_em_only_ver_lvl = -1 => 0.3986928105,
											  pk_em_only_ver_lvl = 0  => 0.3684788316,
											  pk_em_only_ver_lvl = 1  => 0.3399503722,
											  pk_em_only_ver_lvl = 2  => 0.3049065421,
																		 0.292201382);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.48828125,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.64,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.6148648649,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4845360825,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.5483870968,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.6109422492,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.464516129,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.5125523013,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.5,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.4642289348,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.463991204,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.4330527927,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.3938053097,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.3806818182,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.3550232392,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.3094398747,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.2537724898,
																							  0.2272291467);

		pk_nas_summary_mm_b2_c2_b2 := map(pk_nas_summary = 0 => 0.1424802111,
										  pk_nas_summary = 1 => 0.0933181596,
																0.0634104542);

		pk_nap_summary_mm_b2_c2_b2 := map(pk_nap_summary = -1 => 0.0702754036,
										  pk_nap_summary = 0  => 0.1143881208,
										  pk_nap_summary = 1  => 0.066539924,
																 0.061247216);

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := map(pk_rc_dirsaddr_lastscore = -1 => 0.0978027227,
													pk_rc_dirsaddr_lastscore = 0  => 0.1152487961,
													pk_rc_dirsaddr_lastscore = 1  => 0.1402714932,
																					 0.0857413548);

		pk_adl_score_mm_b2_c2_b2 := map(pk_adl_score = 0 => 0.1914091937,
															0.0909236433);

		pk_lname_score_mm_b2_c2_b2 := map(pk_lname_score = 0 => 0.1553509781,
																0.0968962322);

		pk_combo_addrscore_mm_b2_c2_b2 := map(pk_combo_addrscore = 0 => 0.1071965628,
																		0.0868986921);

		pk_combo_hphonescore_mm_b2_c2_b2 := map(pk_combo_hphonescore = 0 => 0.1172919872,
												pk_combo_hphonescore = 1 => 0.1224489796,
																			0.0738305467);

		pk_combo_ssnscore_mm_b2_c2_b2 := map(pk_combo_ssnscore = -1 => 0.1384810127,
											 pk_combo_ssnscore = 0  => 0.1882716049,
																	   0.0819105478);

		pk_eq_count_mm_b2_c2_b2 := map(pk_eq_count = 0 => 0.1656441718,
									   pk_eq_count = 1 => 0.0959860384,
									   pk_eq_count = 2 => 0.1100090171,
									   pk_eq_count = 3 => 0.0944444444,
									   pk_eq_count = 4 => 0.11352657,
									   pk_eq_count = 5 => 0.0923694779,
														  0.1025358324);

		pk_pos_secondary_sources_mm_b2_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.1023503792,
													pk_pos_secondary_sources = 1 => 0.0561797753,
																					0.0506329114);

		pk_voter_flag_mm_b2_c2_b2 := map(pk_voter_flag = -1 => 0.142071494,
										 pk_voter_flag = 0  => 0.0952948183,
															   0.0841446453);

		pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.106749978,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.0875462392,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.0607142857,
																							  0.0681536555);

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.1062260536,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.1130284728,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0657769304,
																							  0.0690537084);

		pk_add1_address_score_mm_b2_c2_b2 := map(pk_add1_address_score = 0 => 0.1101577909,
																			  0.0741646292);

		pk_add2_address_score_mm_b2_c2_b2 := map(pk_add2_address_score = 0 => 0.0975609756,
												 pk_add2_address_score = 1 => 0.101326217,
												 pk_add2_address_score = 2 => 0.0708860759,
																			  0.129740519);

		pk_add2_pos_sources_mm_b2_c2_b2 := map(pk_add2_pos_sources = 0 => 0.095371669,
											   pk_add2_pos_sources = 1 => 0.1174698795,
											   pk_add2_pos_sources = 2 => 0.0950337216,
											   pk_add2_pos_sources = 3 => 0.0837676843,
																		  0.0653685675);

		pk_add2_pos_secondary_sources_mm_b2_c2_b2 := map(pk_add2_pos_secondary_sources = 0 => 0.1015056923,
														 pk_add2_pos_secondary_sources = 1 => 0.0510948905,
																							  0.0144927536);

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.0982002838,
																							  0.1744186047);

		pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := map(pk_infutor_risk_lvl_nb = 0 => 0.0733944954,
												  pk_infutor_risk_lvl_nb = 1 => 0.0908022647,
												  pk_infutor_risk_lvl_nb = 2 => 0.0931422723,
																				0.1673866091);

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.1159361472,
													pk_yr_adl_vo_first_seen2 = 0  => 0.0749765698,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0859766277,
													pk_yr_adl_vo_first_seen2 = 2  => 0.1068548387,
																					 0.0785425101);

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1021490371,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.0972762646,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0842105263,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0738522954,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.1016666667,
																							   0.1004366812);

		pk_yr_lname_change_date2_mm_b2_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.0988154375,
													pk_yr_lname_change_date2 = 0  => 0.1302083333,
													pk_yr_lname_change_date2 = 1  => 0.160326087,
																					 0.0738636364);

		pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.1227904784,
													  pk_yr_gong_did_first_seen2 = 0  => 0.1366666667,
													  pk_yr_gong_did_first_seen2 = 1  => 0.1234309623,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1325301205,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0904584882,
																						 0.0823902843);

		pk_yr_credit_first_seen2_mm_b2_c2_b2 := map(pk_yr_credit_first_seen2 = -1 => 0.1735751295,
													pk_yr_credit_first_seen2 = 0  => 0.2407407407,
													pk_yr_credit_first_seen2 = 1  => 0.131147541,
													pk_yr_credit_first_seen2 = 2  => 0.2105263158,
													pk_yr_credit_first_seen2 = 3  => 0.1409090909,
													pk_yr_credit_first_seen2 = 4  => 0.1448763251,
													pk_yr_credit_first_seen2 = 5  => 0.144,
													pk_yr_credit_first_seen2 = 6  => 0.133105802,
													pk_yr_credit_first_seen2 = 7  => 0.1219626168,
													pk_yr_credit_first_seen2 = 8  => 0.0966069746,
													pk_yr_credit_first_seen2 = 9  => 0.0946153846,
													pk_yr_credit_first_seen2 = 10 => 0.0662517567,
																					 0.0538922156);

		pk_yr_header_first_seen2_mm_b2_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.1950920245,
													pk_yr_header_first_seen2 = 0  => 0.1346704871,
													pk_yr_header_first_seen2 = 1  => 0.1431767338,
													pk_yr_header_first_seen2 = 2  => 0.1169521559,
													pk_yr_header_first_seen2 = 3  => 0.1036717063,
													pk_yr_header_first_seen2 = 4  => 0.0883025979,
													pk_yr_header_first_seen2 = 5  => 0.0779036827,
													pk_yr_header_first_seen2 = 6  => 0.0794326241,
																					 0.0785619174);

		pk_yr_infutor_first_seen2_mm_b2_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.0908022647,
													 pk_yr_infutor_first_seen2 = 0  => 0.1194968553,
													 pk_yr_infutor_first_seen2 = 1  => 0.1235679214,
													 pk_yr_infutor_first_seen2 = 2  => 0.1325581395,
													 pk_yr_infutor_first_seen2 = 3  => 0.1208530806,
																					   0.0928961749);

		pk_em_only_ver_lvl_mm_b2_c2_b2 := map(pk_em_only_ver_lvl = -1 => 0.1095890411,
											  pk_em_only_ver_lvl = 0  => 0.1023836336,
											  pk_em_only_ver_lvl = 1  => 0.0965227818,
											  pk_em_only_ver_lvl = 2  => 0.0734767025,
																		 0.1021437579);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1915584416,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.2941176471,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1555555556,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.1111111111,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.2162162162,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2295081967,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1323529412,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1650943396,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.115942029,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1439393939,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1437578815,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.1336487286,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1179645335,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1186252772,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0816852966,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0969743988,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0634523539,
																							  0.0789724072);

		pk_nas_summary_mm_b2_c2_b3 := map(pk_nas_summary = 0 => 0.3134003805,
										  pk_nas_summary = 1 => 0.2778903022,
																0.2657679345);

		pk_nap_summary_mm_b2_c2_b3 := map(pk_nap_summary = -1 => 0.3396849593,
										  pk_nap_summary = 0  => 0.2977995535,
										  pk_nap_summary = 1  => 0.25,
																 0.2645985401);

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2856829883,
													pk_rc_dirsaddr_lastscore = 0  => 0.3283611973,
													pk_rc_dirsaddr_lastscore = 1  => 0.2798833819,
																					 0.3585978209);

		pk_adl_score_mm_b2_c2_b3 := map(pk_adl_score = 0 => 0.2429171039,
															0.3177887283);

		pk_lname_score_mm_b2_c2_b3 := map(pk_lname_score = 0 => 0.3471059767,
																0.2656095144);

		pk_combo_addrscore_mm_b2_c2_b3 := map(pk_combo_addrscore = 0 => 0.2954800359,
																		0.3359946773);

		pk_combo_hphonescore_mm_b2_c2_b3 := map(pk_combo_hphonescore = 0 => 0.2937601163,
												pk_combo_hphonescore = 1 => 0.3521126761,
																			0.318712851);

		pk_combo_ssnscore_mm_b2_c2_b3 := map(pk_combo_ssnscore = -1 => 0.311891307,
											 pk_combo_ssnscore = 0  => 0.4020797227,
																	   0.2757937863);

		pk_eq_count_mm_b2_c2_b3 := map(pk_eq_count = 0 => 0.3453407346,
									   pk_eq_count = 1 => 0.3118772419,
									   pk_eq_count = 2 => 0.2799070848,
									   pk_eq_count = 3 => 0.2665969681,
									   pk_eq_count = 4 => 0.2675606641,
									   pk_eq_count = 5 => 0.2425036009,
														  0.2335714286);

		pk_pos_secondary_sources_mm_b2_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.3012096471,
													pk_pos_secondary_sources = 1 => 0.1242937853,
																					0.0597014925);

		pk_voter_flag_mm_b2_c2_b3 := map(pk_voter_flag = -1 => 0.3446493285,
										 pk_voter_flag = 0  => 0.2845605701,
															   0.2269051145);

		pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.3007528693,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.3441802253,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.245972073,
																							  0.2725274725);

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2994036773,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.3744125326,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.2244367418,
																							  0.2630385488);

		pk_add1_address_score_mm_b2_c2_b3 := map(pk_add1_address_score = 0 => 0.3016313598,
																			  0.2691532258);

		pk_add2_address_score_mm_b2_c2_b3 := map(pk_add2_address_score = 0 => 0.3567874911,
												 pk_add2_address_score = 1 => 0.2703868051,
												 pk_add2_address_score = 2 => 0.2454780362,
																			  0.3475609756);

		pk_add2_pos_sources_mm_b2_c2_b3 := map(pk_add2_pos_sources = 0 => 0.3478342631,
											   pk_add2_pos_sources = 1 => 0.2842145344,
											   pk_add2_pos_sources = 2 => 0.2398613518,
											   pk_add2_pos_sources = 3 => 0.2126833477,
																		  0.1484992101);

		pk_add2_pos_secondary_sources_mm_b2_c2_b3 := map(pk_add2_pos_secondary_sources = 0 => 0.3005889987,
														 pk_add2_pos_secondary_sources = 1 => 0.0864197531,
																							  0.0833333333);

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2994087722,
																							  0.3059348739);

		pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := map(pk_infutor_risk_lvl_nb = 0 => 0.261008807,
												  pk_infutor_risk_lvl_nb = 1 => 0.2983054836,
												  pk_infutor_risk_lvl_nb = 2 => 0.2035639413,
																				0.3638568129);

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.3169158241,
													pk_yr_adl_vo_first_seen2 = 0  => 0.2433596554,
													pk_yr_adl_vo_first_seen2 = 1  => 0.2239927841,
													pk_yr_adl_vo_first_seen2 = 2  => 0.2405063291,
																					 0.2316267547);

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.3075204765,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.2388888889,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.2393162393,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.2272727273,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.2257462687,
																							   0.2702702703);

		pk_yr_lname_change_date2_mm_b2_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.2948293093,
													pk_yr_lname_change_date2 = 0  => 0.3770949721,
													pk_yr_lname_change_date2 = 1  => 0.376635514,
																					 0.4657534247);

		pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.3111901391,
													  pk_yr_gong_did_first_seen2 = 0  => 0.3870967742,
													  pk_yr_gong_did_first_seen2 = 1  => 0.3055009823,
													  pk_yr_gong_did_first_seen2 = 2  => 0.2851824274,
													  pk_yr_gong_did_first_seen2 = 3  => 0.304868316,
																						 0.2371371525);

		pk_yr_credit_first_seen2_mm_b2_c2_b3 := map(pk_yr_credit_first_seen2 = -1 => 0.3494234903,
													pk_yr_credit_first_seen2 = 0  => 0.3555018138,
													pk_yr_credit_first_seen2 = 1  => 0.3200702165,
													pk_yr_credit_first_seen2 = 2  => 0.3017847485,
													pk_yr_credit_first_seen2 = 3  => 0.2716621253,
													pk_yr_credit_first_seen2 = 4  => 0.2721555174,
													pk_yr_credit_first_seen2 = 5  => 0.2491103203,
													pk_yr_credit_first_seen2 = 6  => 0.2617041199,
													pk_yr_credit_first_seen2 = 7  => 0.2692069393,
													pk_yr_credit_first_seen2 = 8  => 0.2813411079,
													pk_yr_credit_first_seen2 = 9  => 0.2291196388,
													pk_yr_credit_first_seen2 = 10 => 0.1888933928,
																					 0.1590909091);

		pk_yr_header_first_seen2_mm_b2_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.3333959288,
													pk_yr_header_first_seen2 = 0  => 0.2800963082,
													pk_yr_header_first_seen2 = 1  => 0.3100817439,
													pk_yr_header_first_seen2 = 2  => 0.2363013699,
													pk_yr_header_first_seen2 = 3  => 0.2019099591,
													pk_yr_header_first_seen2 = 4  => 0.2068807339,
													pk_yr_header_first_seen2 = 5  => 0.164893617,
													pk_yr_header_first_seen2 = 6  => 0.1656804734,
																					 0.1794871795);

		pk_yr_infutor_first_seen2_mm_b2_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.2983054836,
													 pk_yr_infutor_first_seen2 = 0  => 0.3205664628,
													 pk_yr_infutor_first_seen2 = 1  => 0.3020118343,
													 pk_yr_infutor_first_seen2 = 2  => 0.2796365138,
													 pk_yr_infutor_first_seen2 = 3  => 0.2936660269,
																					   0.2535392535);

		pk_em_only_ver_lvl_mm_b2_c2_b3 := map(pk_em_only_ver_lvl = -1 => 0.1780104712,
											  pk_em_only_ver_lvl = 0  => 0.3077029648,
											  pk_em_only_ver_lvl = 1  => 0.2526104418,
											  pk_em_only_ver_lvl = 2  => 0.1915584416,
																		 0.2124681934);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3496470588,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3426183844,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.3524982888,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.3369829684,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.3107526882,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2969359331,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.3005988024,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.2656095144,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.2713963964,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.2765833818,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2476789458,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2635740643,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2802041974,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2819512195,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2786259542,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.2336343115,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1852017937,
																							  0.2317708333);

		pk_nas_summary_mm_b2_c2_b4 := map(pk_nas_summary = 0 => 0.3442350333,
										  pk_nas_summary = 1 => 0.2654905963,
																0.2338797814);

		pk_nap_summary_mm_b2_c2_b4 := map(pk_nap_summary = -1 => 0.2984469953,
										  pk_nap_summary = 0  => 0.3082257086,
										  pk_nap_summary = 1  => 0.2089552239,
																 0.2065868263);

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b4 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2931686915,
													pk_rc_dirsaddr_lastscore = 0  => 0.3121129552,
													pk_rc_dirsaddr_lastscore = 1  => 0.2944162437,
																					 0.2891344383);

		pk_adl_score_mm_b2_c2_b4 := map(pk_adl_score = 0 => 0.2590431739,
															0.3050097495);

		pk_lname_score_mm_b2_c2_b4 := map(pk_lname_score = 0 => 0.3603356739,
																0.2611762368);

		pk_combo_addrscore_mm_b2_c2_b4 := map(pk_combo_addrscore = 0 => 0.3010625738,
																		0.28375);

		pk_combo_hphonescore_mm_b2_c2_b4 := map(pk_combo_hphonescore = 0 => 0.3066209334,
												pk_combo_hphonescore = 1 => 0.1888888889,
																			0.2851146271);

		pk_combo_ssnscore_mm_b2_c2_b4 := map(pk_combo_ssnscore = -1 => 0.3463580065,
											 pk_combo_ssnscore = 0  => 0.3386075949,
																	   0.2585443397);

		pk_eq_count_mm_b2_c2_b4 := map(pk_eq_count = 0 => 0.3643521832,
									   pk_eq_count = 1 => 0.346896192,
									   pk_eq_count = 2 => 0.2898630137,
									   pk_eq_count = 3 => 0.2449238579,
									   pk_eq_count = 4 => 0.2605304212,
									   pk_eq_count = 5 => 0.2325901459,
														  0.1969596827);

		pk_pos_secondary_sources_mm_b2_c2_b4 := map(pk_pos_secondary_sources = 0 => 0.2993529561,
													pk_pos_secondary_sources = 1 => 0.109375,
																					0.0909090909);

		pk_voter_flag_mm_b2_c2_b4 := map(pk_voter_flag = -1 => 0.3481152993,
										 pk_voter_flag = 0  => 0.2899042298,
															   0.2240794574);

		pk_fname_eda_sourced_type_lvl_mm_b2_c2_b4 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.3026162989,
														 pk_fname_eda_sourced_type_lvl = 1 => 0.2928039702,
														 pk_fname_eda_sourced_type_lvl = 2 => 0.212173913,
																							  0.21875);

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.3042326039,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.3400605449,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.2133027523,
																							  0.2299401198);

		pk_add1_address_score_mm_b2_c2_b4 := map(pk_add1_address_score = 0 => 0.302910876,
																			  0.2441054092);

		pk_add2_address_score_mm_b2_c2_b4 := map(pk_add2_address_score = 0 => 0.3080895009,
												 pk_add2_address_score = 1 => 0.2715217849,
												 pk_add2_address_score = 2 => 0.241219963,
																			  0.3613924051);

		pk_add2_pos_sources_mm_b2_c2_b4 := map(pk_add2_pos_sources = 0 => 0.3623161071,
											   pk_add2_pos_sources = 1 => 0.2875432083,
											   pk_add2_pos_sources = 2 => 0.2233883058,
											   pk_add2_pos_sources = 3 => 0.190269331,
																		  0.1596091205);

		pk_add2_pos_secondary_sources_mm_b2_c2_b4 := map(pk_add2_pos_secondary_sources = 0 => 0.2984349363,
														 pk_add2_pos_secondary_sources = 1 => 0.0857142857,
																							  0.0416666667);

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b4 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2986022872,
																							  0.281512605);

		pk_infutor_risk_lvl_nb_mm_b2_c2_b4 := map(pk_infutor_risk_lvl_nb = 0 => 0.2132196162,
												  pk_infutor_risk_lvl_nb = 1 => 0.2829506418,
												  pk_infutor_risk_lvl_nb = 2 => 0.2331141662,
																				0.4120696039);

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b4 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.3178775905,
													pk_yr_adl_vo_first_seen2 = 0  => 0.2475106686,
													pk_yr_adl_vo_first_seen2 = 1  => 0.2168968318,
													pk_yr_adl_vo_first_seen2 = 2  => 0.2417218543,
																					 0.2184542587);

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.3061152351,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.2916666667,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.2367346939,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.2311212815,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.2148394241,
																							   0.2580645161);

		pk_yr_lname_change_date2_mm_b2_c2_b4 := map(pk_yr_lname_change_date2 = -1 => 0.2914359921,
													pk_yr_lname_change_date2 = 0  => 0.3775,
													pk_yr_lname_change_date2 = 1  => 0.370015949,
																					 0.3481781377);

		pk_yr_gong_did_first_seen2_mm_b2_c2_b4 := map(pk_yr_gong_did_first_seen2 = -1 => 0.3188580993,
													  pk_yr_gong_did_first_seen2 = 0  => 0.4028776978,
													  pk_yr_gong_did_first_seen2 = 1  => 0.3353535354,
													  pk_yr_gong_did_first_seen2 = 2  => 0.2701863354,
													  pk_yr_gong_did_first_seen2 = 3  => 0.2848,
																						 0.2080808081);

		pk_yr_credit_first_seen2_mm_b2_c2_b4 := map(pk_yr_credit_first_seen2 = -1 => 0.3680130559,
													pk_yr_credit_first_seen2 = 0  => 0.3879056047,
													pk_yr_credit_first_seen2 = 1  => 0.3533123028,
													pk_yr_credit_first_seen2 = 2  => 0.3142857143,
													pk_yr_credit_first_seen2 = 3  => 0.2892040977,
													pk_yr_credit_first_seen2 = 4  => 0.2706552707,
													pk_yr_credit_first_seen2 = 5  => 0.2707390649,
													pk_yr_credit_first_seen2 = 6  => 0.2737361282,
													pk_yr_credit_first_seen2 = 7  => 0.2828863346,
													pk_yr_credit_first_seen2 = 8  => 0.2480553155,
													pk_yr_credit_first_seen2 = 9  => 0.1972076789,
													pk_yr_credit_first_seen2 = 10 => 0.1604708798,
																					 0.0930232558);

		pk_yr_header_first_seen2_mm_b2_c2_b4 := map(pk_yr_header_first_seen2 = -1 => 0.3485959765,
													pk_yr_header_first_seen2 = 0  => 0.3175182482,
													pk_yr_header_first_seen2 = 1  => 0.3258426966,
													pk_yr_header_first_seen2 = 2  => 0.2122340426,
													pk_yr_header_first_seen2 = 3  => 0.1730449251,
													pk_yr_header_first_seen2 = 4  => 0.191923775,
													pk_yr_header_first_seen2 = 5  => 0.1584158416,
													pk_yr_header_first_seen2 = 6  => 0.0756302521,
																					 0.1869158879);

		pk_yr_infutor_first_seen2_mm_b2_c2_b4 := map(pk_yr_infutor_first_seen2 = -1 => 0.2829506418,
													 pk_yr_infutor_first_seen2 = 0  => 0.3384050367,
													 pk_yr_infutor_first_seen2 = 1  => 0.2950699043,
													 pk_yr_infutor_first_seen2 = 2  => 0.3603473227,
													 pk_yr_infutor_first_seen2 = 3  => 0.349328215,
																					   0.3442622951);

		pk_em_only_ver_lvl_mm_b2_c2_b4 := map(pk_em_only_ver_lvl = -1 => 0.16,
											  pk_em_only_ver_lvl = 0  => 0.3070231729,
											  pk_em_only_ver_lvl = 1  => 0.2502242152,
											  pk_em_only_ver_lvl = 2  => 0.186440678,
																		 0.2049861496);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3686762226,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3945945946,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.3810408922,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.3582554517,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.3609467456,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.3079470199,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.3225806452,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.2829341317,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.2873900293,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.2865412446,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2679245283,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2826362484,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2744405183,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2823741007,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2186440678,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1975524476,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.161311054,
																							  0.1411764706);

		pk_nap_summary_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_nap_summary_mm_b2_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nap_summary_mm_b2_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nap_summary_mm_b2_c2_b3,
																 pk_nap_summary_mm_b2_c2_b4);

		pk_yr_gong_did_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b2,
												pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b2_c2_b3,
																			 pk_yr_gong_did_first_seen2_mm_b2_c2_b4);

		pk_add2_pos_secondary_sources_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_secondary_sources_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_add2_pos_secondary_sources_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_add2_pos_secondary_sources_mm_b2_c2_b3,
																				pk_add2_pos_secondary_sources_mm_b2_c2_b4);

		pk_nas_summary_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_nas_summary_mm_b2_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nas_summary_mm_b2_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nas_summary_mm_b2_c2_b3,
																 pk_nas_summary_mm_b2_c2_b4);

		pk_yr_infutor_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_infutor_first_seen2_mm_b2_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_infutor_first_seen2_mm_b2_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_infutor_first_seen2_mm_b2_c2_b3,
																			pk_yr_infutor_first_seen2_mm_b2_c2_b4);

		pk_yr_adl_em_only_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3,
																				pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4);

		pk_combo_hphonescore_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_hphonescore_mm_b2_c2_b1,
										  pk_segment_2 = '1 Owner ' => pk_combo_hphonescore_mm_b2_c2_b2,
										  pk_segment_2 = '2 Renter' => pk_combo_hphonescore_mm_b2_c2_b3,
																	   pk_combo_hphonescore_mm_b2_c2_b4);

		pk_lname_score_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_lname_score_mm_b2_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_lname_score_mm_b2_c2_b2,
									pk_segment_2 = '2 Renter' => pk_lname_score_mm_b2_c2_b3,
																 pk_lname_score_mm_b2_c2_b4);

		pk_yr_lname_change_date2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_lname_change_date2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_lname_change_date2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_lname_change_date2_mm_b2_c2_b3,
																		   pk_yr_lname_change_date2_mm_b2_c2_b4);

		pk_ssnchar_invalid_or_recent_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b1,
												  pk_segment_2 = '1 Owner ' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b2,
												  pk_segment_2 = '2 Renter' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b3,
																			   pk_ssnchar_invalid_or_recent_mm_b2_c2_b4);

		pk_infutor_risk_lvl_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_infutor_risk_lvl_nb_mm_b2_c2_b1,
											pk_segment_2 = '1 Owner ' => pk_infutor_risk_lvl_nb_mm_b2_c2_b2,
											pk_segment_2 = '2 Renter' => pk_infutor_risk_lvl_nb_mm_b2_c2_b3,
																		 pk_infutor_risk_lvl_nb_mm_b2_c2_b4);

		pk_yr_credit_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_credit_first_seen2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_credit_first_seen2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_credit_first_seen2_mm_b2_c2_b3,
																		   pk_yr_credit_first_seen2_mm_b2_c2_b4);

		pk_adl_score_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_adl_score_mm_b2_c2_b1,
								  pk_segment_2 = '1 Owner ' => pk_adl_score_mm_b2_c2_b2,
								  pk_segment_2 = '2 Renter' => pk_adl_score_mm_b2_c2_b3,
															   pk_adl_score_mm_b2_c2_b4);

		pk_yr_header_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_header_first_seen2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_header_first_seen2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_header_first_seen2_mm_b2_c2_b3,
																		   pk_yr_header_first_seen2_mm_b2_c2_b4);

		pk_eq_count_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_eq_count_mm_b2_c2_b1,
								 pk_segment_2 = '1 Owner ' => pk_eq_count_mm_b2_c2_b2,
								 pk_segment_2 = '2 Renter' => pk_eq_count_mm_b2_c2_b3,
															  pk_eq_count_mm_b2_c2_b4);

		pk_em_only_ver_lvl_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_em_only_ver_lvl_mm_b2_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_em_only_ver_lvl_mm_b2_c2_b2,
										pk_segment_2 = '2 Renter' => pk_em_only_ver_lvl_mm_b2_c2_b3,
																	 pk_em_only_ver_lvl_mm_b2_c2_b4);

		pk_rc_dirsaddr_lastscore_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b3,
																		   pk_rc_dirsaddr_lastscore_mm_b2_c2_b4);

		pk_add1_address_score_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_add1_address_score_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_address_score_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_address_score_mm_b2_c2_b3,
																		pk_add1_address_score_mm_b2_c2_b4);

		pk_yr_adl_vo_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b3,
																		   pk_yr_adl_vo_first_seen2_mm_b2_c2_b4);

		pk_pos_secondary_sources_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b2_c2_b3,
																		   pk_pos_secondary_sources_mm_b2_c2_b4);

		pk_combo_addrscore_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_addrscore_mm_b2_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_combo_addrscore_mm_b2_c2_b2,
										pk_segment_2 = '2 Renter' => pk_combo_addrscore_mm_b2_c2_b3,
																	 pk_combo_addrscore_mm_b2_c2_b4);

		pk_voter_flag_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b2_c2_b1,
								   pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b2_c2_b2,
								   pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b2_c2_b3,
																pk_voter_flag_mm_b2_c2_b4);

		pk_combo_ssnscore_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_ssnscore_mm_b2_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssnscore_mm_b2_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssnscore_mm_b2_c2_b3,
																	pk_combo_ssnscore_mm_b2_c2_b4);

		pk_add2_address_score_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_add2_address_score_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_address_score_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_address_score_mm_b2_c2_b3,
																		pk_add2_address_score_mm_b2_c2_b4);

		pk_add2_pos_sources_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b2_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b2_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b2_c2_b3,
																	  pk_add2_pos_sources_mm_b2_c2_b4);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3,
																			pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4);

		pk_fname_eda_sourced_type_lvl_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3,
																				pk_fname_eda_sourced_type_lvl_mm_b2_c2_b4);

		pk_lname_eda_sourced_type_lvl_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3,
																				pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4);

		pk_nap_summary_mm := if((integer)add1_isbestmatch = 1, pk_nap_summary_mm_b1, pk_nap_summary_mm_b2);

		pk_yr_gong_did_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_gong_did_first_seen2_mm_b1, pk_yr_gong_did_first_seen2_mm_b2);

		pk_add2_pos_secondary_sources_mm := if((integer)add1_isbestmatch = 1, pk_add2_pos_secondary_sources_mm_b1, pk_add2_pos_secondary_sources_mm_b2);

		pk_nas_summary_mm := if((integer)add1_isbestmatch = 1, pk_nas_summary_mm_b1, pk_nas_summary_mm_b2);

		pk_yr_infutor_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_infutor_first_seen2_mm_b1, pk_yr_infutor_first_seen2_mm_b2);

		pk_yr_adl_em_only_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_em_only_first_seen2_mm_b1, pk_yr_adl_em_only_first_seen2_mm_b2);

		pk_combo_hphonescore_mm := if((integer)add1_isbestmatch = 1, pk_combo_hphonescore_mm_b1, pk_combo_hphonescore_mm_b2);

		pk_lname_score_mm := if((integer)add1_isbestmatch = 1, pk_lname_score_mm_b1, pk_lname_score_mm_b2);

		pk_yr_lname_change_date2_mm := if((integer)add1_isbestmatch = 1, pk_yr_lname_change_date2_mm_b1, pk_yr_lname_change_date2_mm_b2);

		pk_ssnchar_invalid_or_recent_mm := if((integer)add1_isbestmatch = 1, pk_ssnchar_invalid_or_recent_mm_b1, pk_ssnchar_invalid_or_recent_mm_b2);

		pk_infutor_risk_lvl_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_infutor_risk_lvl_nb_mm_b2);

		pk_add2_em_ver_lvl_mm := if((integer)add1_isbestmatch = 1, pk_add2_em_ver_lvl_mm_b1, NULL);

		pk_yr_credit_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_credit_first_seen2_mm_b1, pk_yr_credit_first_seen2_mm_b2);

		pk_adl_score_mm := if((integer)add1_isbestmatch = 1, pk_adl_score_mm_b1, pk_adl_score_mm_b2);

		pk_yr_header_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_header_first_seen2_mm_b1, pk_yr_header_first_seen2_mm_b2);

		pk_eq_count_mm := if((integer)add1_isbestmatch = 1, pk_eq_count_mm_b1, pk_eq_count_mm_b2);

		pk_em_only_ver_lvl_mm := if((integer)add1_isbestmatch = 1, pk_em_only_ver_lvl_mm_b1, pk_em_only_ver_lvl_mm_b2);

		pk_rc_dirsaddr_lastscore_mm := if((integer)add1_isbestmatch = 1, pk_rc_dirsaddr_lastscore_mm_b1, pk_rc_dirsaddr_lastscore_mm_b2);

		pk_add1_address_score_mm := if((integer)add1_isbestmatch = 1, pk_add1_address_score_mm_b1, pk_add1_address_score_mm_b2);

		pk_yr_adl_vo_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_vo_first_seen2_mm_b1, pk_yr_adl_vo_first_seen2_mm_b2);

		pk_pos_secondary_sources_mm := if((integer)add1_isbestmatch = 1, pk_pos_secondary_sources_mm_b1, pk_pos_secondary_sources_mm_b2);

		pk_combo_addrscore_mm := if((integer)add1_isbestmatch = 1, pk_combo_addrscore_mm_b1, pk_combo_addrscore_mm_b2);

		pk_voter_flag_mm := if((integer)add1_isbestmatch = 1, pk_voter_flag_mm_b1, pk_voter_flag_mm_b2);

		pk_combo_ssnscore_mm := if((integer)add1_isbestmatch = 1, pk_combo_ssnscore_mm_b1, pk_combo_ssnscore_mm_b2);

		pk_add2_address_score_mm := if((integer)add1_isbestmatch = 1, pk_add2_address_score_mm_b1, pk_add2_address_score_mm_b2);

		pk_add2_pos_sources_mm := if((integer)add1_isbestmatch = 1, pk_add2_pos_sources_mm_b1, pk_add2_pos_sources_mm_b2);

		pk_yrmo_adl_f_sn_mx_fcra2_mm := if((integer)add1_isbestmatch = 1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b2);

		pk_fname_eda_sourced_type_lvl_mm := if((integer)add1_isbestmatch = 1, pk_fname_eda_sourced_type_lvl_mm_b1, pk_fname_eda_sourced_type_lvl_mm_b2);

		pk_infutor_risk_lvl_mm := if((integer)add1_isbestmatch = 1, pk_infutor_risk_lvl_mm_b1, NULL);

		pk_lname_eda_sourced_type_lvl_mm := if((integer)add1_isbestmatch = 1, pk_lname_eda_sourced_type_lvl_mm_b1, pk_lname_eda_sourced_type_lvl_mm_b2);

		pk_estimated_income_mm_b1 := map(pk_estimated_income = -1 => 0.4107676969,
										 pk_estimated_income = 0  => 0.490797546,
										 pk_estimated_income = 1  => 0.4484228474,
										 pk_estimated_income = 2  => 0.4474393531,
										 pk_estimated_income = 3  => 0.4013096352,
										 pk_estimated_income = 4  => 0.4174477289,
										 pk_estimated_income = 5  => 0.4232868405,
										 pk_estimated_income = 6  => 0.4055075594,
										 pk_estimated_income = 7  => 0.3692826192,
										 pk_estimated_income = 8  => 0.384423365,
										 pk_estimated_income = 9  => 0.3555917481,
										 pk_estimated_income = 10 => 0.3407572383,
										 pk_estimated_income = 11 => 0.3078281342,
										 pk_estimated_income = 12 => 0.3216833096,
										 pk_estimated_income = 13 => 0.2786745964,
										 pk_estimated_income = 14 => 0.2780441035,
										 pk_estimated_income = 15 => 0.2747933884,
										 pk_estimated_income = 16 => 0.2655502392,
										 pk_estimated_income = 17 => 0.2822902796,
										 pk_estimated_income = 18 => 0.2752721617,
										 pk_estimated_income = 19 => 0.2317636196,
										 pk_estimated_income = 20 => 0.2018514066,
										 pk_estimated_income = 21 => 0.144278607,
																	 0.1081081081);

		pk_yr_adl_w_last_seen2_mm_b1 := map(pk_yr_adl_w_last_seen2 = -1 => 0.3310629412,
											pk_yr_adl_w_last_seen2 = 0  => 0.1280653951,
											pk_yr_adl_w_last_seen2 = 1  => 0.1944444444,
																		   0.2069632495);

		pk_pr_count_mm_b1 := map(pk_pr_count = -1 => 0.39912708,
								 pk_pr_count = 0  => 0.2427227944,
								 pk_pr_count = 1  => 0.1992853953,
													 0.1270125224);

		pk_addrs_sourced_lvl_mm_b1 := map(pk_addrs_sourced_lvl = 0 => 0.3727775969,
										  pk_addrs_sourced_lvl = 1 => 0.2191947946,
										  pk_addrs_sourced_lvl = 2 => 0.1810211449,
																	  0.1142857143);

		pk_add1_own_level_mm_b1 := map(pk_add1_own_level = -1 => 0.3521624007,
									   pk_add1_own_level = 0  => 0.3593840678,
									   pk_add1_own_level = 1  => 0.2903837044,
									   pk_add1_own_level = 2  => 0.1599705123,
																 0.1521805428);

		pk_add2_own_level_mm_b1 := map(pk_add2_own_level = 0 => 0.3444598578,
									   pk_add2_own_level = 1 => 0.3072897196,
									   pk_add2_own_level = 2 => 0.2108218479,
																0.1792060491);

		pk_add3_own_level_mm_b1 := map(pk_add3_own_level = 0 => 0.3374680376,
									   pk_add3_own_level = 1 => 0.2959576516,
									   pk_add3_own_level = 2 => 0.1976994968,
																0.2012121212);

		pk_naprop_level2_mm_b1 := map(pk_naprop_level2 = -2 => 0.3975845411,
									  pk_naprop_level2 = -1 => 0.4011939571,
									  pk_naprop_level2 = 0  => 0.3811455847,
									  pk_naprop_level2 = 1  => 0.3447820343,
									  pk_naprop_level2 = 2  => 0.3732697631,
									  pk_naprop_level2 = 3  => 0.3125389894,
									  pk_naprop_level2 = 4  => 0.2428177883,
									  pk_naprop_level2 = 5  => 0.2060555088,
									  pk_naprop_level2 = 6  => 0.1698630137,
															   0.130044843);

		pk_yr_add1_built_date2_mm_b1 := map(pk_yr_add1_built_date2 = -4 => 0.3433398058,
											pk_yr_add1_built_date2 = -3 => 0.1666666667,
											pk_yr_add1_built_date2 = -2 => 0.2908891328,
											pk_yr_add1_built_date2 = -1 => 0.2496984318,
											pk_yr_add1_built_date2 = 0  => 0.2521717548,
											pk_yr_add1_built_date2 = 1  => 0.2905837239,
											pk_yr_add1_built_date2 = 2  => 0.311251981,
																		   0.3376865672);

		pk_add1_purchase_amount2_mm_b1 := map(pk_add1_purchase_amount2 = -1 => 0.3458571323,
											  pk_add1_purchase_amount2 = 0  => 0.3196144431,
																			   0.2641059287);

		pk_yr_add1_mortgage_date2_mm_b1 := map(pk_yr_add1_mortgage_date2 = -1 => 0.3391496981,
											   pk_yr_add1_mortgage_date2 = 0  => 0.2686697148,
											   pk_yr_add1_mortgage_date2 = 1  => 0.2858858859,
																				 0.2779026217);

		pk_add1_mortgage_risk_mm_b1 := map(pk_add1_mortgage_risk = -1 => 0.2631578947,
										   pk_add1_mortgage_risk = 0  => 0.2414518674,
										   pk_add1_mortgage_risk = 1  => 0.3341637414,
										   pk_add1_mortgage_risk = 2  => 0.2943129929,
																		 0.2924400181);

		pk_add1_assessed_amount2_mm_b1 := map(pk_add1_assessed_amount2 = -1 => 0.3402967662,
											  pk_add1_assessed_amount2 = 0  => 0.4003164557,
											  pk_add1_assessed_amount2 = 1  => 0.4012158055,
											  pk_add1_assessed_amount2 = 2  => 0.3631937683,
											  pk_add1_assessed_amount2 = 3  => 0.3314606742,
											  pk_add1_assessed_amount2 = 4  => 0.2785749629,
											  pk_add1_assessed_amount2 = 5  => 0.2562761506,
																			   0.2604853416);

		pk_yr_add1_mortgage_due_date2_mm_b1 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.336581207,
												   pk_yr_add1_mortgage_due_date2 = 0  => 0.3024494143,
												   pk_yr_add1_mortgage_due_date2 = 1  => 0.2839976553,
																						 0.2817832765);

		pk_yr_add1_date_first_seen2_mm_b1 := map(pk_yr_add1_date_first_seen2 = -1 => 0.3678403972,
												 pk_yr_add1_date_first_seen2 = 0  => 0.3316648531,
												 pk_yr_add1_date_first_seen2 = 1  => 0.3485617597,
												 pk_yr_add1_date_first_seen2 = 2  => 0.276177412,
												 pk_yr_add1_date_first_seen2 = 3  => 0.2735988201,
												 pk_yr_add1_date_first_seen2 = 4  => 0.2434701493,
												 pk_yr_add1_date_first_seen2 = 5  => 0.2520435967,
												 pk_yr_add1_date_first_seen2 = 6  => 0.2415949961,
												 pk_yr_add1_date_first_seen2 = 7  => 0.2205188679,
												 pk_yr_add1_date_first_seen2 = 8  => 0.1987237922,
												 pk_yr_add1_date_first_seen2 = 9  => 0.2109038737,
																					 0.186770428);

		pk_add1_land_use_risk_level_mm_b1 := map(pk_add1_land_use_risk_level = 0 => 0.3205128205,
												 pk_add1_land_use_risk_level = 2 => 0.2806303425,
												 pk_add1_land_use_risk_level = 3 => 0.3535296173,
																					0.3990665111);

		pk_add1_building_area2_mm_b1 := map(pk_add1_building_area2 = -99 => 0.3432971014,
											pk_add1_building_area2 = -4  => 0.3514817367,
											pk_add1_building_area2 = -3  => 0.3566058002,
											pk_add1_building_area2 = -2  => 0.2942600625,
											pk_add1_building_area2 = -1  => 0.2476547842,
											pk_add1_building_area2 = 0   => 0.2555555556,
											pk_add1_building_area2 = 1   => 0.3017241379,
											pk_add1_building_area2 = 2   => 0.425,
											pk_add1_building_area2 = 3   => 0.3936170213,
																			0.423880597);

		pk_property_owned_total_mm_b1 := map(pk_property_owned_total = -1 => 0.3794968258,
											 pk_property_owned_total = 0  => 0.2074325114,
											 pk_property_owned_total = 1  => 0.1579919926,
											 pk_property_owned_total = 2  => 0.1570680628,
																			 0.1043478261);

		pk_prop_own_assess_tot2_mm_b1 := map(pk_prop_own_assess_tot2 = 0 => 0.3585344057,
											 pk_prop_own_assess_tot2 = 1 => 0.2703990471,
											 pk_prop_own_assess_tot2 = 2 => 0.2051422319,
											 pk_prop_own_assess_tot2 = 3 => 0.1758241758,
																			0.1423297785);

		pk_prop1_sale_price2_mm_b1 := map(pk_prop1_sale_price2 = 0 => 0.3357497237,
										  pk_prop1_sale_price2 = 1 => 0.2551020408,
																	  0.185704023);

		pk_yr_prop2_sale_date2_mm_b1 := map(pk_yr_prop2_sale_date2 = 0 => 0.3306174536,
											pk_yr_prop2_sale_date2 = 1 => 0.1540469974,
											pk_yr_prop2_sale_date2 = 2 => 0.1460446247,
																		  0.0972762646);

		pk_add2_no_of_buildings_mm_b1 := map(pk_add2_no_of_buildings = -1 => 0.328998159,
											 pk_add2_no_of_buildings = 0  => 0.3067021128,
											 pk_add2_no_of_buildings = 1  => 0.3357664234,
																			 0.3505154639);

		pk_add2_parking_no_of_cars_mm_b1 := map(pk_add2_parking_no_of_cars = 0 => 0.3320180706,
												pk_add2_parking_no_of_cars = 1 => 0.3337590464,
												pk_add2_parking_no_of_cars = 2 => 0.276734481,
																				  0.2361878453);

		pk_add2_mortgage_risk_mm_b1 := map(pk_add2_mortgage_risk = -1 => 0.4418604651,
										   pk_add2_mortgage_risk = 0  => 0.2674483529,
										   pk_add2_mortgage_risk = 1  => 0.3312315271,
										   pk_add2_mortgage_risk = 2  => 0.3038626609,
																		 0.2988138686);

		pk_add2_assessed_amount2_mm_b1 := map(pk_add2_assessed_amount2 = -1 => 0.3316321217,
											  pk_add2_assessed_amount2 = 0  => 0.4135188867,
											  pk_add2_assessed_amount2 = 1  => 0.3334960938,
											  pk_add2_assessed_amount2 = 2  => 0.3108974359,
											  pk_add2_assessed_amount2 = 3  => 0.3015776699,
																			   0.2482472913);

		pk_yr_add2_date_first_seen2_mm_b1 := map(pk_yr_add2_date_first_seen2 = -1 => 0.4207240949,
												 pk_yr_add2_date_first_seen2 = 0  => 0.3604322099,
												 pk_yr_add2_date_first_seen2 = 1  => 0.3501369863,
												 pk_yr_add2_date_first_seen2 = 2  => 0.3315419595,
												 pk_yr_add2_date_first_seen2 = 3  => 0.3148976982,
												 pk_yr_add2_date_first_seen2 = 4  => 0.3392519834,
												 pk_yr_add2_date_first_seen2 = 5  => 0.3211488251,
												 pk_yr_add2_date_first_seen2 = 6  => 0.332488596,
												 pk_yr_add2_date_first_seen2 = 7  => 0.3081607795,
												 pk_yr_add2_date_first_seen2 = 8  => 0.2886207712,
												 pk_yr_add2_date_first_seen2 = 9  => 0.2376033058,
												 pk_yr_add2_date_first_seen2 = 10 => 0.2357019064,
																					 0.2212943633);

		pk_yr_add2_date_last_seen2_mm_b1 := map(pk_yr_add2_date_last_seen2 = -1 => 0.4207240949,
												pk_yr_add2_date_last_seen2 = 0  => 0.340860491,
												pk_yr_add2_date_last_seen2 = 1  => 0.2675886951,
												pk_yr_add2_date_last_seen2 = 2  => 0.2232346241,
												pk_yr_add2_date_last_seen2 = 3  => 0.216796875,
												pk_yr_add2_date_last_seen2 = 4  => 0.2154255319,
												pk_yr_add2_date_last_seen2 = 5  => 0.1788990826,
																				   0.182781457);

		pk_add3_mortgage_risk_mm_b1 := map(pk_add3_mortgage_risk = -1 => 0.347826087,
										   pk_add3_mortgage_risk = 0  => 0.2517985612,
										   pk_add3_mortgage_risk = 1  => 0.1707317073,
										   pk_add3_mortgage_risk = 2  => 0.3298946384,
										   pk_add3_mortgage_risk = 3  => 0.3264781491,
										   pk_add3_mortgage_risk = 4  => 0.2964480874,
																		 0.3427895981);

		pk_add3_assessed_amount2_mm_b1 := map(pk_add3_assessed_amount2 = -1 => 0.3323002642,
											  pk_add3_assessed_amount2 = 0  => 0.396012931,
											  pk_add3_assessed_amount2 = 1  => 0.3310185185,
											  pk_add3_assessed_amount2 = 2  => 0.3153477218,
																			   0.2717282717);

		pk_yr_add3_date_first_seen2_mm_b1 := map(pk_yr_add3_date_first_seen2 = -1 => 0.4103918978,
												 pk_yr_add3_date_first_seen2 = 0  => 0.3928379106,
												 pk_yr_add3_date_first_seen2 = 1  => 0.3771889401,
												 pk_yr_add3_date_first_seen2 = 2  => 0.3572512465,
												 pk_yr_add3_date_first_seen2 = 3  => 0.3207078547,
												 pk_yr_add3_date_first_seen2 = 4  => 0.3316925407,
												 pk_yr_add3_date_first_seen2 = 5  => 0.3284336783,
												 pk_yr_add3_date_first_seen2 = 6  => 0.2879529873,
												 pk_yr_add3_date_first_seen2 = 7  => 0.2544455221,
												 pk_yr_add3_date_first_seen2 = 8  => 0.2363481229,
																					 0.2157248157);

		pk_watercraft_count_mm_b1 := map(pk_watercraft_count = 0 => 0.327955683,
										 pk_watercraft_count = 1 => 0.171539961,
																	0.2);

		pk_bk_level_mm_b1 := map(pk_bk_level_2 = 0 => 0.3736797031,
								 pk_bk_level_2 = 1 => 0.2058033781,
													  0.3373702422);

		pk_eviction_level_mm_b1 := map(pk_eviction_level = 0 => 0.2926481708,
									   pk_eviction_level = 1 => 0.4279235504,
									   pk_eviction_level = 2 => 0.4790794979,
									   pk_eviction_level = 3 => 0.5020120724,
									   pk_eviction_level = 4 => 0.50330033,
									   pk_eviction_level = 5 => 0.5753846154,
									   pk_eviction_level = 6 => 0.5679442509,
																0.6126760563);

		pk_lien_type_level_mm_b1 := map(pk_lien_type_level = 0 => 0.2775907063,
										pk_lien_type_level = 1 => 0.306122449,
										pk_lien_type_level = 2 => 0.2558365759,
										pk_lien_type_level = 3 => 0.3642735367,
										pk_lien_type_level = 4 => 0.3877402974,
																  0.4730923695);

		pk_yr_liens_last_unrel_date3_mm_b1 := map((integer)pk_yr_liens_last_unrel_date3_2 = -1 => 0.2846845508,
												  pk_yr_liens_last_unrel_date3_2 = -0.5        => 0.2683234637,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 0  => 0.4445879062,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 1  => 0.4092651757,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 2  => 0.3673469388,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 3  => 0.3576069908,
																								  0.3453815261);

		pk_yr_ln_unrel_lt_f_sn2_mm_b1 := map(pk_yr_liens_unrel_lt_first_sn2 = -1 => 0.3109926509,
											 pk_yr_liens_unrel_lt_first_sn2 = 0  => 0.5335073977,
																					0.4774904215);

		pk_yr_ln_unrel_ot_f_sn2_mm_b1 := map(pk_yr_liens_unrel_ot_first_sn2 = -1 => 0.3276588232,
											 pk_yr_liens_unrel_ot_first_sn2 = 0  => 0.2993197279,
											 pk_yr_liens_unrel_ot_first_sn2 = 1  => 0.2690437601,
																					0.2773972603);

		pk_crime_level_mm_b1 := map(pk_crime_level = 0 => 0.3084327323,
									pk_crime_level = 1 => 0.3921809688,
														  0.5181405896);

		pk_attr_total_number_derogs_mm_b1 := map(pk_attr_total_number_derogs_5 = 0 => 0.2827829433,
												 pk_attr_total_number_derogs_5 = 1 => 0.2972329119,
												 pk_attr_total_number_derogs_5 = 2 => 0.3714746172,
																					  0.4289061356);

		pk_yr_rc_ssnhighissue2_mm_b1 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.3791032826,
											pk_yr_rc_ssnhighissue2 = 0  => 0.2222222222,
											pk_yr_rc_ssnhighissue2 = 1  => 0.3106796117,
											pk_yr_rc_ssnhighissue2 = 2  => 0.3416536661,
											pk_yr_rc_ssnhighissue2 = 3  => 0.3382899628,
											pk_yr_rc_ssnhighissue2 = 4  => 0.3821102909,
											pk_yr_rc_ssnhighissue2 = 5  => 0.3437895269,
											pk_yr_rc_ssnhighissue2 = 6  => 0.3622002821,
											pk_yr_rc_ssnhighissue2 = 7  => 0.3554633472,
											pk_yr_rc_ssnhighissue2 = 8  => 0.3459899264,
											pk_yr_rc_ssnhighissue2 = 9  => 0.3397355949,
											pk_yr_rc_ssnhighissue2 = 10 => 0.2988647581,
											pk_yr_rc_ssnhighissue2 = 11 => 0.2327771798,
											pk_yr_rc_ssnhighissue2 = 12 => 0.2079002079,
											pk_yr_rc_ssnhighissue2 = 13 => 0.1578298397,
																		   0.2121837894);

		pk_prof_lic_cat_mm_b1 := map(pk_prof_lic_cat = -1 => 0.3316562484,
									 pk_prof_lic_cat = 0  => 0.2797513321,
									 pk_prof_lic_cat = 1  => 0.2036516854,
									 pk_prof_lic_cat = 2  => 0.1859205776,
															 0.0962962963);

		pk_add1_lres_mm_b1 := map(pk_add1_lres = -2 => 0.2926829268,
								  pk_add1_lres = -1 => 0.3680825405,
								  pk_add1_lres = 0  => 0.3118556701,
								  pk_add1_lres = 1  => 0.3680851064,
								  pk_add1_lres = 2  => 0.3182897862,
								  pk_add1_lres = 3  => 0.3483709273,
								  pk_add1_lres = 4  => 0.3225671141,
								  pk_add1_lres = 5  => 0.3101604278,
								  pk_add1_lres = 6  => 0.3350327749,
								  pk_add1_lres = 7  => 0.2587088916,
								  pk_add1_lres = 8  => 0.2472985489,
								  pk_add1_lres = 9  => 0.2459485224,
								  pk_add1_lres = 10 => 0.2078593588,
													   0.1971830986);

		pk_add2_lres_mm_b1 := map(pk_add2_lres = -2 => 0.4199475066,
								  pk_add2_lres = -1 => 0.2297226583,
								  pk_add2_lres = 0  => 0.3520192887,
								  pk_add2_lres = 1  => 0.3568037975,
								  pk_add2_lres = 2  => 0.3381306342,
								  pk_add2_lres = 3  => 0.3122197309,
								  pk_add2_lres = 4  => 0.339198436,
								  pk_add2_lres = 5  => 0.3174187922,
								  pk_add2_lres = 6  => 0.3370214931,
								  pk_add2_lres = 7  => 0.3274657002,
								  pk_add2_lres = 8  => 0.2916107383,
								  pk_add2_lres = 9  => 0.2544378698,
													   0.1939393939);

		pk_add3_lres_mm_b1 := map(pk_add3_lres = -2 => 0.4083333333,
								  pk_add3_lres = -1 => 0.3128816083,
								  pk_add3_lres = 0  => 0.3377567587,
								  pk_add3_lres = 1  => 0.318273276,
								  pk_add3_lres = 2  => 0.3357967667,
								  pk_add3_lres = 3  => 0.2991769547,
								  pk_add3_lres = 4  => 0.2835150738,
								  pk_add3_lres = 5  => 0.2647058824,
													   0.2705263158);

		pk_addrs_5yr_mm_b1 := map(pk_addrs_5yr = 0 => 0.2700831025,
								  pk_addrs_5yr = 1 => 0.3205326232,
								  pk_addrs_5yr = 2 => 0.3522367031,
								  pk_addrs_5yr = 3 => 0.345619793,
													  0.3764523625);

		pk_addrs_15yr_mm_b1 := map(pk_addrs_15yr = 0 => 0.3086574655,
								   pk_addrs_15yr = 1 => 0.3229374758,
								   pk_addrs_15yr = 2 => 0.3322703113,
														0.378125);

		pk_add_lres_month_avg2_mm_b1 := map(pk_add_lres_month_avg2 = -1 => 0.4612903226,
											pk_add_lres_month_avg2 = 0  => 0.4150943396,
											pk_add_lres_month_avg2 = 1  => 0.4028436019,
											pk_add_lres_month_avg2 = 2  => 0.4044350581,
											pk_add_lres_month_avg2 = 3  => 0.3870718517,
											pk_add_lres_month_avg2 = 4  => 0.3785900783,
											pk_add_lres_month_avg2 = 5  => 0.3589639822,
											pk_add_lres_month_avg2 = 6  => 0.3589435774,
											pk_add_lres_month_avg2 = 7  => 0.3725337487,
											pk_add_lres_month_avg2 = 8  => 0.3392386881,
											pk_add_lres_month_avg2 = 9  => 0.3397911306,
											pk_add_lres_month_avg2 = 10 => 0.3045822102,
											pk_add_lres_month_avg2 = 11 => 0.2955371901,
											pk_add_lres_month_avg2 = 12 => 0.2762752482,
											pk_add_lres_month_avg2 = 13 => 0.2383667883,
											pk_add_lres_month_avg2 = 15 => 0.2358783364,
																		   0.1859706362);

		pk_nameperssn_count_mm_b1 := map(pk_nameperssn_count = 0 => 0.3210449852,
										 pk_nameperssn_count = 1 => 0.3763803681,
																	0.3466666667);

		pk_ssns_per_adl_mm_b1 := map(pk_ssns_per_adl = -1 => 0.527027027,
									 pk_ssns_per_adl = 0  => 0.3088738499,
									 pk_ssns_per_adl = 1  => 0.3283382648,
									 pk_ssns_per_adl = 2  => 0.3745839637,
									 pk_ssns_per_adl = 3  => 0.4068322981,
															 0.5188834154);

		pk_addrs_per_adl_mm_b1 := map(pk_addrs_per_adl = -6 => 0.54375,
									  pk_addrs_per_adl = -5 => 0.4323529412,
									  pk_addrs_per_adl = -4 => 0.4051054384,
									  pk_addrs_per_adl = -3 => 0.3912698413,
									  pk_addrs_per_adl = -2 => 0.3527578685,
									  pk_addrs_per_adl = -1 => 0.3318129989,
									  pk_addrs_per_adl = 0  => 0.3182211242,
									  pk_addrs_per_adl = 1  => 0.2935528121,
									  pk_addrs_per_adl = 2  => 0.2944748027,
															   0.2836653386);

		pk_phones_per_adl_mm_b1 := map(pk_phones_per_adl = -1 => 0.3465784446,
									   pk_phones_per_adl = 0  => 0.2745832219,
									   pk_phones_per_adl = 1  => 0.3137254902,
																 0.3123486683);

		pk_adlperssn_count_mm_b1 := map(pk_adlperssn_count = -1 => 0.379810095,
										pk_adlperssn_count = 0  => 0.298110604,
										pk_adlperssn_count = 1  => 0.3141339001,
																   0.3463024283);

		pk_addrs_per_ssn_mm_b1 := map(pk_addrs_per_ssn = -4 => 0.3802078179,
									  pk_addrs_per_ssn = -3 => 0.3606785669,
									  pk_addrs_per_ssn = -2 => 0.3109034268,
									  pk_addrs_per_ssn = -1 => 0.2913571911,
									  pk_addrs_per_ssn = 0  => 0.3105360444,
									  pk_addrs_per_ssn = 1  => 0.2805767319,
									  pk_addrs_per_ssn = 2  => 0.2723196086,
															   0.2458823529);

		pk_adls_per_addr_mm_b1 := map(pk_adls_per_addr = -102 => 0.3519293352,
									  pk_adls_per_addr = -101 => 0.3255813953,
									  pk_adls_per_addr = -2   => 0.3069828722,
									  pk_adls_per_addr = -1   => 0.2388419783,
									  pk_adls_per_addr = 0    => 0.2089182494,
									  pk_adls_per_addr = 1    => 0.2345588235,
									  pk_adls_per_addr = 2    => 0.2406962785,
									  pk_adls_per_addr = 3    => 0.2540272615,
									  pk_adls_per_addr = 4    => 0.2908163265,
									  pk_adls_per_addr = 5    => 0.2633269107,
									  pk_adls_per_addr = 6    => 0.2926192031,
									  pk_adls_per_addr = 7    => 0.2886884108,
									  pk_adls_per_addr = 8    => 0.3173352436,
									  pk_adls_per_addr = 9    => 0.3280127694,
									  pk_adls_per_addr = 10   => 0.341567696,
									  pk_adls_per_addr = 11   => 0.3498349835,
									  pk_adls_per_addr = 12   => 0.3772241993,
									  pk_adls_per_addr = 13   => 0.3858636855,
									  pk_adls_per_addr = 100  => 0.2862453532,
									  pk_adls_per_addr = 101  => 0.357615894,
																 0.4006062137);

		pk_phones_per_addr_mm_b1 := map(pk_phones_per_addr = -1  => 0.2939514281,
										pk_phones_per_addr = 0   => 0.2970564407,
										pk_phones_per_addr = 1   => 0.3579433092,
										pk_phones_per_addr = 2   => 0.4031830239,
										pk_phones_per_addr = 3   => 0.4136546185,
										pk_phones_per_addr = 100 => 0.3741058655,
										pk_phones_per_addr = 101 => 0.3850630456,
										pk_phones_per_addr = 102 => 0.3686098655,
																	0.3606823721);

		pk_adls_per_phone_mm_b1 := map(pk_adls_per_phone = -2 => 0.3357007066,
									   pk_adls_per_phone = -1 => 0.3020514666,
									   pk_adls_per_phone = 0  => 0.3086714399,
																 0.3636363636);

		pk_ssns_per_adl_c6_mm_b1 := map(pk_ssns_per_adl_c6 = 0 => 0.3087971989,
										pk_ssns_per_adl_c6 = 1 => 0.345503507,
																  0.4487179487);

		pk_addrs_per_adl_c6_mm_b1 := map(pk_addrs_per_adl_c6 = 0 => 0.3121647573,
										 pk_addrs_per_adl_c6 = 1 => 0.356727073,
										 pk_addrs_per_adl_c6 = 2 => 0.3566009105,
																	0.4137353434);

		pk_phones_per_adl_c6_mm_b1 := map(pk_phones_per_adl_c6 = -2 => 0.3243846093,
										  pk_phones_per_adl_c6 = -1 => 0.330033863,
										  pk_phones_per_adl_c6 = 0  => 0.3682634731,
																	   0.4489795918);

		pk_ssns_per_addr_c6_mm_b1 := map(pk_ssns_per_addr_c6 = 0   => 0.2909250439,
										 pk_ssns_per_addr_c6 = 1   => 0.3393186004,
										 pk_ssns_per_addr_c6 = 2   => 0.2990728477,
										 pk_ssns_per_addr_c6 = 3   => 0.3240740741,
										 pk_ssns_per_addr_c6 = 4   => 0.326,
										 pk_ssns_per_addr_c6 = 5   => 0.4347826087,
										 pk_ssns_per_addr_c6 = 6   => 0.4220779221,
										 pk_ssns_per_addr_c6 = 100 => 0.3571868132,
										 pk_ssns_per_addr_c6 = 101 => 0.4111282844,
										 pk_ssns_per_addr_c6 = 102 => 0.402,
										 pk_ssns_per_addr_c6 = 103 => 0.3443708609,
																	  0.4861111111);

		pk_phones_per_addr_c6_mm_b1 := map(pk_phones_per_addr_c6 = -1  => 0.2934050064,
										   pk_phones_per_addr_c6 = 0   => 0.39545309,
										   pk_phones_per_addr_c6 = 1   => 0.4537313433,
										   pk_phones_per_addr_c6 = 2   => 0.427184466,
										   pk_phones_per_addr_c6 = 100 => 0.3605862617,
										   pk_phones_per_addr_c6 = 101 => 0.3595233662,
																		  0.3859202714);

		pk_adls_per_phone_c6_mm_b1 := map(pk_adls_per_phone_c6 = 0 => 0.3240043901,
										  pk_adls_per_phone_c6 = 1 => 0.3475552787,
																	  0.2810945274);

		pk_attr_addrs_last24_mm_b1 := map(pk_attr_addrs_last24 = 0 => 0.2888450022,
										  pk_attr_addrs_last24 = 1 => 0.3262668796,
										  pk_attr_addrs_last24 = 2 => 0.3589949211,
										  pk_attr_addrs_last24 = 3 => 0.3863564917,
										  pk_attr_addrs_last24 = 4 => 0.3889242521,
																	  0.4204545455);

		pk_attr_addrs_last36_mm_b1 := map(pk_attr_addrs_last36 = 0 => 0.2779680365,
										  pk_attr_addrs_last36 = 1 => 0.3125202462,
										  pk_attr_addrs_last36 = 2 => 0.3451375352,
										  pk_attr_addrs_last36 = 3 => 0.3682708769,
										  pk_attr_addrs_last36 = 4 => 0.38420653,
										  pk_attr_addrs_last36 = 5 => 0.3662477558,
																	  0.3887468031);

		pk_ams_class_level_mm_b1 := map(pk_ams_class_level = -1000001 => 0.3201004618,
										pk_ams_class_level = 0        => 0.6402877698,
										pk_ams_class_level = 1        => 0.5490196078,
										pk_ams_class_level = 2        => 0.5508474576,
										pk_ams_class_level = 3        => 0.5851851852,
										pk_ams_class_level = 4        => 0.449704142,
										pk_ams_class_level = 5        => 0.4247038917,
										pk_ams_class_level = 6        => 0.3399715505,
										pk_ams_class_level = 7        => 0.3534090909,
										pk_ams_class_level = 8        => 0.297029703,
										pk_ams_class_level = 1000000  => 0.2815533981,
										pk_ams_class_level = 1000001  => 0.2692307692,
										pk_ams_class_level = 1000002  => 0.1994459834,
										pk_ams_class_level = 1000003  => 0.186440678,
										pk_ams_class_level = 1000004  => 0.1777777778,
																		 0.1153846154);

		pk_ams_income_level_code_mm_b1 := map(pk_ams_income_level_code = -1 => 0.3201004618,
											  pk_ams_income_level_code = 0  => 0.4830188679,
											  pk_ams_income_level_code = 1  => 0.4651162791,
											  pk_ams_income_level_code = 2  => 0.3957126304,
											  pk_ams_income_level_code = 3  => 0.3092948718,
											  pk_ams_income_level_code = 4  => 0.3118686869,
											  pk_ams_income_level_code = 5  => 0.285,
																			   0.2229299363);

		pk_college_tier_mm_b1 := map((integer)pk_college_tier = -1 => 0.3278849217,
									 (integer)pk_college_tier = 1  => 0.1538461538,
									 (integer)pk_college_tier = 2  => 0.2037037037,
									 (integer)pk_college_tier = 3  => 0.1898148148,
									 (integer)pk_college_tier = 4  => 0.1763085399,
									 (integer)pk_college_tier = 5  => 0.3232323232,
																	  0.2595419847);

		pk_ams_age_mm_b1 := map(pk_ams_age = -1 => 0.3179409739,
								pk_ams_age = 21 => 0.5846153846,
								pk_ams_age = 22 => 0.5431034483,
								pk_ams_age = 23 => 0.5,
								pk_ams_age = 24 => 0.5568862275,
								pk_ams_age = 25 => 0.4021164021,
								pk_ams_age = 29 => 0.4484978541,
												   0.3302598491);

		pk_inferred_age_mm_b1 := map(pk_inferred_age = -1 => 0.6,
									 pk_inferred_age = 18 => 0.6103286385,
									 pk_inferred_age = 19 => 0.6113074205,
									 pk_inferred_age = 20 => 0.5756756757,
									 pk_inferred_age = 21 => 0.5304740406,
									 pk_inferred_age = 22 => 0.4892205638,
									 pk_inferred_age = 24 => 0.4766686356,
									 pk_inferred_age = 34 => 0.3982024945,
									 pk_inferred_age = 37 => 0.3441263045,
									 pk_inferred_age = 41 => 0.3271960958,
									 pk_inferred_age = 42 => 0.2925482981,
									 pk_inferred_age = 43 => 0.2868705036,
									 pk_inferred_age = 44 => 0.2805628848,
									 pk_inferred_age = 46 => 0.2821330902,
									 pk_inferred_age = 48 => 0.2685656155,
									 pk_inferred_age = 52 => 0.2564789991,
									 pk_inferred_age = 56 => 0.227610481,
									 pk_inferred_age = 61 => 0.19,
															 0.19);

		pk_yr_reported_dob2_mm_b1 := map(pk_yr_reported_dob2 = -1 => 0.467389273,
										 pk_yr_reported_dob2 = 19 => 0.6071428571,
										 pk_yr_reported_dob2 = 21 => 0.6341463415,
										 pk_yr_reported_dob2 = 22 => 0.5384615385,
										 pk_yr_reported_dob2 = 23 => 0.472,
										 pk_yr_reported_dob2 = 32 => 0.4151539069,
										 pk_yr_reported_dob2 = 35 => 0.3581145207,
										 pk_yr_reported_dob2 = 39 => 0.3351131995,
										 pk_yr_reported_dob2 = 42 => 0.3273641219,
										 pk_yr_reported_dob2 = 43 => 0.2920187793,
										 pk_yr_reported_dob2 = 44 => 0.2909423605,
										 pk_yr_reported_dob2 = 45 => 0.2787769784,
										 pk_yr_reported_dob2 = 46 => 0.3085501859,
										 pk_yr_reported_dob2 = 49 => 0.264957265,
										 pk_yr_reported_dob2 = 57 => 0.2440782698,
										 pk_yr_reported_dob2 = 61 => 0.19,
																	 0.19);

		pk_avm_hit_level_mm_b1 := map(pk_avm_hit_level = -1 => 0.3232410969,
									  pk_avm_hit_level = 0  => 0.360957441,
									  pk_avm_hit_level = 1  => 0.2979815657,
															   0.2686588504);

		pk_avm_auto_diff4_lvl_mm_b1 := map(pk_avm_auto_diff4_lvl = -1 => 0.3296461323,
										   pk_avm_auto_diff4_lvl = 0  => 0.2780645161,
																		 0.2290502793);

		pk_add2_avm_auto_diff3_lvl_mm_b1 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.3369425199,
												pk_add2_avm_auto_diff3_lvl = -1 => 0.3012457531,
																				   0.2999333904);

		pk2_add1_avm_as_mm_b1 := map(pk2_add1_avm_as = 0 => 0.3429678372,
									 pk2_add1_avm_as = 1 => 0.2966684294,
									 pk2_add1_avm_as = 2 => 0.2472713587,
															0.144486692);

		pk2_add1_avm_mkt_mm_b1 := map(pk2_add1_avm_mkt = 0 => 0.431092437,
									  pk2_add1_avm_mkt = 1 => 0.3365608056,
									  pk2_add1_avm_mkt = 2 => 0.3003554502,
									  pk2_add1_avm_mkt = 3 => 0.2440191388,
															  0.1698113208);

		pk2_add1_avm_hed_mm_b1 := map(pk2_add1_avm_hed = 0 => 0.4394904459,
									  pk2_add1_avm_hed = 1 => 0.4199134199,
									  pk2_add1_avm_hed = 2 => 0.399103139,
									  pk2_add1_avm_hed = 3 => 0.3413324709,
									  pk2_add1_avm_hed = 4 => 0.2959048877,
									  pk2_add1_avm_hed = 5 => 0.2617689016,
															  0.1412103746);

		pk2_add1_avm_auto_mm_b1 := map(pk2_add1_avm_auto = 0 => 0.4347826087,
									   pk2_add1_avm_auto = 1 => 0.3721461187,
									   pk2_add1_avm_auto = 2 => 0.4545454545,
									   pk2_add1_avm_auto = 3 => 0.3907203907,
									   pk2_add1_avm_auto = 4 => 0.3476087496,
									   pk2_add1_avm_auto = 5 => 0.2611361587,
																0.1648148148);

		pk2_add1_avm_auto2_mm_b1 := map(pk2_add1_avm_auto2 = 0 => 0.4620689655,
										pk2_add1_avm_auto2 = 1 => 0.401826484,
										pk2_add1_avm_auto2 = 2 => 0.4363354037,
										pk2_add1_avm_auto2 = 3 => 0.3820512821,
										pk2_add1_avm_auto2 = 4 => 0.3465028014,
										pk2_add1_avm_auto2 = 5 => 0.3172531215,
										pk2_add1_avm_auto2 = 6 => 0.2586414791,
																  0.1757575758);

		pk2_add1_avm_auto3_mm_b1 := map(pk2_add1_avm_auto3 = 0 => 0.4718309859,
										pk2_add1_avm_auto3 = 1 => 0.4332998997,
										pk2_add1_avm_auto3 = 2 => 0.3932448733,
										pk2_add1_avm_auto3 = 3 => 0.3431787153,
										pk2_add1_avm_auto3 = 4 => 0.2958515284,
										pk2_add1_avm_auto3 = 5 => 0.2738719832,
										pk2_add1_avm_auto3 = 6 => 0.2489822718,
																  0.1733668342);

		pk2_add1_avm_auto4_mm_b1 := map(pk2_add1_avm_auto4 = 0 => 0.3898305085,
										pk2_add1_avm_auto4 = 1 => 0.40625,
										pk2_add1_avm_auto4 = 2 => 0.3804347826,
										pk2_add1_avm_auto4 = 3 => 0.3298049996,
										pk2_add1_avm_auto4 = 4 => 0.2925851703,
										pk2_add1_avm_auto4 = 5 => 0.2237076649,
																  0.1451612903);

		pk2_add1_avm_med_mm_b1 := map(pk2_add1_avm_med = 0 => 0.5287356322,
									  pk2_add1_avm_med = 1 => 0.4724689165,
									  pk2_add1_avm_med = 2 => 0.4667258208,
									  pk2_add1_avm_med = 3 => 0.4168865435,
									  pk2_add1_avm_med = 4 => 0.3679577465,
									  pk2_add1_avm_med = 5 => 0.304886492,
									  pk2_add1_avm_med = 6 => 0.1934673367,
															  0.323489011);

		pk2_add1_avm_to_med_ratio_mm_b1 := map(pk2_add1_avm_to_med_ratio = 0 => 0.3447505585,
											   pk2_add1_avm_to_med_ratio = 1 => 0.2822569096,
											   pk2_add1_avm_to_med_ratio = 2 => 0.2872867364,
											   pk2_add1_avm_to_med_ratio = 3 => 0.272567151,
											   pk2_add1_avm_to_med_ratio = 4 => 0.2605965463,
																				0.2615629984);

		pk2_add2_avm_sp_mm_b1 := map(pk2_add2_avm_sp = 0 => 0.3949903661,
									 pk2_add2_avm_sp = 1 => 0.3420724095,
									 pk2_add2_avm_sp = 2 => 0.3631633715,
									 pk2_add2_avm_sp = 3 => 0.3380210152,
									 pk2_add2_avm_sp = 4 => 0.287099903,
															0.2524970036);

		pk2_add2_avm_mkt_mm_b1 := map(pk2_add2_avm_mkt = 0 => 0.4614035088,
									  pk2_add2_avm_mkt = 1 => 0.3545310016,
									  pk2_add2_avm_mkt = 2 => 0.3304094387,
									  pk2_add2_avm_mkt = 3 => 0.2745427791,
															  0.1900826446);

		pk2_add2_avm_hed_mm_b1 := map(pk2_add2_avm_hed = 0 => 0.5897435897,
									  pk2_add2_avm_hed = 1 => 0.4514767932,
									  pk2_add2_avm_hed = 2 => 0.3444283647,
									  pk2_add2_avm_hed = 3 => 0.3329922947,
									  pk2_add2_avm_hed = 4 => 0.3169864961,
									  pk2_add2_avm_hed = 5 => 0.2854792267,
															  0.1886792453);

		pk2_add2_avm_auto_mm_b1 := map(pk2_add2_avm_auto = 0 => 0.4363636364,
									   pk2_add2_avm_auto = 1 => 0.3414175733,
									   pk2_add2_avm_auto = 2 => 0.2873446614,
																0.20625);

		pk2_add2_avm_auto3_mm_b1 := map(pk2_add2_avm_auto3 = 0 => 0.442155309,
										pk2_add2_avm_auto3 = 1 => 0.3947368421,
										pk2_add2_avm_auto3 = 2 => 0.3377379473,
										pk2_add2_avm_auto3 = 3 => 0.2788885471,
																  0.2);

		pk2_add2_avm_auto4_mm_b1 := map(pk2_add2_avm_auto4 = 0 => 0.5294117647,
										pk2_add2_avm_auto4 = 1 => 0.4086021505,
										pk2_add2_avm_auto4 = 2 => 0.3984962406,
										pk2_add2_avm_auto4 = 3 => 0.3273867303,
										pk2_add2_avm_auto4 = 4 => 0.3024206224,
																  0.2076124567);

		pk2_yr_add1_avm_rec_dt_mm_b1 := map(pk2_yr_add1_avm_recording_date = 0 => 0.2971606379,
											pk2_yr_add1_avm_recording_date = 1 => 0.3032185206,
											pk2_yr_add1_avm_recording_date = 2 => 0.3400222258,
											pk2_yr_add1_avm_recording_date = 3 => 0.2698008337,
																				  0.2624565469);

		pk2_yr_add1_avm_assess_year_mm_b1 := map(pk2_yr_add1_avm_assess_year = 0 => 0.3443110701,
												 pk2_yr_add1_avm_assess_year = 1 => 0.3005415162,
																					0.2798300382);

		pk_dist_a1toa2_mm_b1 := map(pk_dist_a1toa2_2 = 0 => 0.3219652036,
									pk_dist_a1toa2_2 = 1 => 0.317498309,
									pk_dist_a1toa2_2 = 2 => 0.3344103393,
									pk_dist_a1toa2_2 = 3 => 0.3412151067,
															0.3976047904);

		pk_dist_a1toa3_mm_b1 := map(pk_dist_a1toa3_2 = 0 => 0.3249613601,
									pk_dist_a1toa3_2 = 1 => 0.3086959919,
									pk_dist_a1toa3_2 = 2 => 0.3230853477,
									pk_dist_a1toa3_2 = 3 => 0.3346357801,
									pk_dist_a1toa3_2 = 4 => 0.3435582822,
									pk_dist_a1toa3_2 = 5 => 0.349537037,
															0.3952069717);

		pk_rc_disthphoneaddr_mm_b1 := map(pk_rc_disthphoneaddr_2 = 0 => 0.2772209254,
										  pk_rc_disthphoneaddr_2 = 1 => 0.3322300372,
										  pk_rc_disthphoneaddr_2 = 2 => 0.3284615385,
										  pk_rc_disthphoneaddr_2 = 3 => 0.3261851016,
																		0.337188506);

		pk_out_st_division_lvl_mm_b1 := map(pk_out_st_division_lvl = -1 => 0.4920634921,
											pk_out_st_division_lvl = 0  => 0.3229214515,
											pk_out_st_division_lvl = 1  => 0.3041793523,
											pk_out_st_division_lvl = 2  => 0.3606589917,
											pk_out_st_division_lvl = 3  => 0.4277511962,
											pk_out_st_division_lvl = 4  => 0.3155126606,
											pk_out_st_division_lvl = 5  => 0.2871683024,
											pk_out_st_division_lvl = 6  => 0.2946012606,
											pk_out_st_division_lvl = 7  => 0.3686782311,
																		   0.3245243129);

		pk_wealth_index_mm_b1 := map(pk_wealth_index_2 = 0 => 0.3848669541,
									 pk_wealth_index_2 = 1 => 0.3623924941,
									 pk_wealth_index_2 = 2 => 0.3131948508,
									 pk_wealth_index_2 = 3 => 0.2744803063,
															  0.1573888666);

		pk_impulse_count_mm_b1 := map(pk_impulse_count_2 = 0 => 0.3062688429,
									  pk_impulse_count_2 = 1 => 0.5356290488,
																0.5783898305);

		pk_attr_num_nonderogs90_b_mm_b1 := map(pk_attr_num_nonderogs90_b = 0  => 0.4438596491,
											   pk_attr_num_nonderogs90_b = 1  => 0.3998861984,
											   pk_attr_num_nonderogs90_b = 2  => 0.3144813594,
											   pk_attr_num_nonderogs90_b = 3  => 0.2356262834,
											   pk_attr_num_nonderogs90_b = 4  => 0.1424802111,
											   pk_attr_num_nonderogs90_b = 10 => 0.4246575342,
											   pk_attr_num_nonderogs90_b = 11 => 0.3088546815,
											   pk_attr_num_nonderogs90_b = 12 => 0.2486394558,
											   pk_attr_num_nonderogs90_b = 13 => 0.1746630728,
																				 0.1352040816);

		pk_ssns_per_addr2_mm_b1 := map(pk_ssns_per_addr2 = -101 => 0.3503333333,
									   pk_ssns_per_addr2 = -2   => 0.2888471178,
									   pk_ssns_per_addr2 = -1   => 0.2741477273,
									   pk_ssns_per_addr2 = 0    => 0.2060344828,
									   pk_ssns_per_addr2 = 1    => 0.2315705128,
									   pk_ssns_per_addr2 = 2    => 0.2197278912,
									   pk_ssns_per_addr2 = 3    => 0.2568196939,
									   pk_ssns_per_addr2 = 4    => 0.2640243902,
									   pk_ssns_per_addr2 = 5    => 0.2805369128,
									   pk_ssns_per_addr2 = 6    => 0.2826086957,
									   pk_ssns_per_addr2 = 7    => 0.2926300578,
									   pk_ssns_per_addr2 = 8    => 0.312786339,
									   pk_ssns_per_addr2 = 9    => 0.3368211261,
									   pk_ssns_per_addr2 = 10   => 0.3465598835,
									   pk_ssns_per_addr2 = 11   => 0.3781372002,
									   pk_ssns_per_addr2 = 12   => 0.3967806841,
									   pk_ssns_per_addr2 = 100  => 0.3285714286,
									   pk_ssns_per_addr2 = 101  => 0.3626760563,
									   pk_ssns_per_addr2 = 102  => 0.381398984,
																   0.4405043341);

		pk_yr_add2_assess_val_yr2_mm_b1 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.3409332596,
											   pk_yr_add2_assessed_value_year2 = 0  => 0.3170731707,
											   pk_yr_add2_assessed_value_year2 = 1  => 0.3029664207,
																					   0.312141018);

		pk_estimated_income_mm_b2 := map(pk_estimated_income = -1 => 0.1582799634,
										 pk_estimated_income = 1  => 0.2456140351,
										 pk_estimated_income = 2  => 0.1395348837,
										 pk_estimated_income = 3  => 0.1666666667,
										 pk_estimated_income = 4  => 0.213592233,
										 pk_estimated_income = 5  => 0.2105263158,
										 pk_estimated_income = 6  => 0.118226601,
										 pk_estimated_income = 7  => 0.1393442623,
										 pk_estimated_income = 8  => 0.1264705882,
										 pk_estimated_income = 9  => 0.1076604555,
										 pk_estimated_income = 10 => 0.1274131274,
										 pk_estimated_income = 11 => 0.13136289,
										 pk_estimated_income = 12 => 0.1018711019,
										 pk_estimated_income = 13 => 0.1048292108,
										 pk_estimated_income = 14 => 0.0788235294,
										 pk_estimated_income = 15 => 0.0943181818,
										 pk_estimated_income = 16 => 0.0871003308,
										 pk_estimated_income = 17 => 0.0974244121,
										 pk_estimated_income = 18 => 0.0766002099,
										 pk_estimated_income = 19 => 0.0715962441,
										 pk_estimated_income = 20 => 0.0591881215,
										 pk_estimated_income = 21 => 0.0425179459,
																	 0.0412573674);

		pk_yr_adl_w_last_seen2_mm_b2 := map(pk_yr_adl_w_last_seen2 = -1 => 0.0818279186,
											pk_yr_adl_w_last_seen2 = 0  => 0.0435835351,
											pk_yr_adl_w_last_seen2 = 1  => 0.0725995316,
																		   0.0695581015);

		pk_pr_count_mm_b2 := map(pk_pr_count = -1 => 0.1466716811,
								 pk_pr_count = 0  => 0.081705151,
								 pk_pr_count = 1  => 0.0720853081,
													 0.0666058394);

		pk_addrs_sourced_lvl_mm_b2 := map(pk_addrs_sourced_lvl = 0 => 0.1120057685,
										  pk_addrs_sourced_lvl = 1 => 0.0887357848,
										  pk_addrs_sourced_lvl = 2 => 0.0523134639,
																	  0.0360970107);

		pk_add1_own_level_mm_b2 := map(pk_add1_own_level = -1 => 0.1054637865,
									   pk_add1_own_level = 0  => 0.1043205731,
									   pk_add1_own_level = 1  => 0.0717391304,
									   pk_add1_own_level = 2  => 0.076550518,
																 0.0542288557);

		pk_add2_own_level_mm_b2 := map(pk_add2_own_level = 0 => 0.0813266697,
									   pk_add2_own_level = 1 => 0.0715372907,
									   pk_add2_own_level = 2 => 0.0965869515,
																0.0689498409);

		pk_add3_own_level_mm_b2 := map(pk_add3_own_level = 0 => 0.0824272502,
									   pk_add3_own_level = 1 => 0.0708705357,
									   pk_add3_own_level = 2 => 0.0940649496,
																0.0618342427);

		pk_naprop_level2_mm_b2 := map(pk_naprop_level2 = -2 => 0.1034482759,
									  pk_naprop_level2 = -1 => 0.1283354511,
									  pk_naprop_level2 = 0  => 0.1233595801,
									  pk_naprop_level2 = 1  => 0.1546391753,
									  pk_naprop_level2 = 2  => 0.0960548885,
									  pk_naprop_level2 = 3  => 0.1341463415,
									  pk_naprop_level2 = 4  => 0.1083554768,
									  pk_naprop_level2 = 5  => 0.0862729013,
									  pk_naprop_level2 = 6  => 0.0738882748,
															   0.0485305491);

		pk_yr_add1_built_date2_mm_b2 := map(pk_yr_add1_built_date2 = -4 => 0.0871138996,
											pk_yr_add1_built_date2 = -3 => 0,
											pk_yr_add1_built_date2 = -2 => 0.0520748576,
											pk_yr_add1_built_date2 = -1 => 0.0607594937,
											pk_yr_add1_built_date2 = 0  => 0.0586972083,
											pk_yr_add1_built_date2 = 1  => 0.0707029663,
											pk_yr_add1_built_date2 = 2  => 0.0855663825,
																		   0.1040734636);

		pk_add1_purchase_amount2_mm_b2 := map(pk_add1_purchase_amount2 = -1 => 0.0869768166,
											  pk_add1_purchase_amount2 = 0  => 0.0882943144,
																			   0.0684919749);

		pk_yr_add1_mortgage_date2_mm_b2 := map(pk_yr_add1_mortgage_date2 = -1 => 0.0792924037,
											   pk_yr_add1_mortgage_date2 = 0  => 0.0802681334,
											   pk_yr_add1_mortgage_date2 = 1  => 0.0919117647,
																				 0.078464578);

		pk_add1_mortgage_risk_mm_b2 := map(pk_add1_mortgage_risk = -1 => 0.0731707317,
										   pk_add1_mortgage_risk = 0  => 0.0596491228,
										   pk_add1_mortgage_risk = 1  => 0.0784707352,
										   pk_add1_mortgage_risk = 2  => 0.087268606,
																		 0.1175422974);

		pk_add1_assessed_amount2_mm_b2 := map(pk_add1_assessed_amount2 = -1 => 0.0799066383,
											  pk_add1_assessed_amount2 = 0  => 0.1460992908,
											  pk_add1_assessed_amount2 = 1  => 0.1419249592,
											  pk_add1_assessed_amount2 = 2  => 0.1222222222,
											  pk_add1_assessed_amount2 = 3  => 0.0962343096,
											  pk_add1_assessed_amount2 = 4  => 0.0814006367,
											  pk_add1_assessed_amount2 = 5  => 0.0738137083,
																			   0.0669685164);

		pk_yr_add1_mortgage_due_date2_mm_b2 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.079453626,
												   pk_yr_add1_mortgage_due_date2 = 0  => 0.054676259,
												   pk_yr_add1_mortgage_due_date2 = 1  => 0.0719800182,
																						 0.0956442831);

		pk_yr_add1_date_first_seen2_mm_b2 := map(pk_yr_add1_date_first_seen2 = -1 => 0.111762199,
												 pk_yr_add1_date_first_seen2 = 0  => 0.0679136691,
												 pk_yr_add1_date_first_seen2 = 1  => 0.0688800793,
												 pk_yr_add1_date_first_seen2 = 2  => 0.087398374,
												 pk_yr_add1_date_first_seen2 = 3  => 0.0846594526,
												 pk_yr_add1_date_first_seen2 = 4  => 0.0727141829,
												 pk_yr_add1_date_first_seen2 = 5  => 0.0718043949,
												 pk_yr_add1_date_first_seen2 = 6  => 0.0538057743,
												 pk_yr_add1_date_first_seen2 = 7  => 0.0511210762,
												 pk_yr_add1_date_first_seen2 = 8  => 0.0551684088,
												 pk_yr_add1_date_first_seen2 = 9  => 0.05118411,
																					 0.0362537764);

		pk_add1_land_use_risk_level_mm_b2 := map(pk_add1_land_use_risk_level = 0 => 0.0153846154,
												 pk_add1_land_use_risk_level = 2 => 0.0714148497,
												 pk_add1_land_use_risk_level = 3 => 0.0976510067,
																					0.1382799325);

		pk_add1_building_area2_mm_b2 := map(pk_add1_building_area2 = -99 => 0.0854051375,
											pk_add1_building_area2 = -4  => 0.108751062,
											pk_add1_building_area2 = -3  => 0.1090425532,
											pk_add1_building_area2 = -2  => 0.0834582241,
											pk_add1_building_area2 = -1  => 0.050617284,
											pk_add1_building_area2 = 0   => 0.0518248175,
											pk_add1_building_area2 = 1   => 0.0634920635,
											pk_add1_building_area2 = 2   => 0.04,
											pk_add1_building_area2 = 3   => 0.1358024691,
																			0.125);

		pk_property_owned_total_mm_b2 := map(pk_property_owned_total = -1 => 0.0947075209,
											 pk_property_owned_total = 0  => 0.0871308231,
											 pk_property_owned_total = 1  => 0.0650623886,
											 pk_property_owned_total = 2  => 0.0607966457,
																			 0.0481927711);

		pk_prop_own_assess_tot2_mm_b2 := map(pk_prop_own_assess_tot2 = 0 => 0.0725848564,
											 pk_prop_own_assess_tot2 = 1 => 0.1562871876,
											 pk_prop_own_assess_tot2 = 2 => 0.0903727541,
											 pk_prop_own_assess_tot2 = 3 => 0.0793261868,
																			0.061500615);

		pk_prop1_sale_price2_mm_b2 := map(pk_prop1_sale_price2 = 0 => 0.0864314468,
										  pk_prop1_sale_price2 = 1 => 0.1470588235,
																	  0.0460116536);

		pk_yr_prop2_sale_date2_mm_b2 := map(pk_yr_prop2_sale_date2 = 0 => 0.0825019458,
											pk_yr_prop2_sale_date2 = 1 => 0.0711409396,
											pk_yr_prop2_sale_date2 = 2 => 0.0497925311,
																		  0.0215686275);

		pk_add2_no_of_buildings_mm_b2 := map(pk_add2_no_of_buildings = -1 => 0.0740559751,
											 pk_add2_no_of_buildings = 0  => 0.0965614035,
											 pk_add2_no_of_buildings = 1  => 0.104859335,
																			 0.1029411765);

		pk_add2_parking_no_of_cars_mm_b2 := map(pk_add2_parking_no_of_cars = 0 => 0.0824261952,
												pk_add2_parking_no_of_cars = 1 => 0.0981262327,
												pk_add2_parking_no_of_cars = 2 => 0.068889864,
																				  0.0407288317);

		pk_add2_mortgage_risk_mm_b2 := map(pk_add2_mortgage_risk = -1 => 0.0689655172,
										   pk_add2_mortgage_risk = 0  => 0.0654690619,
										   pk_add2_mortgage_risk = 1  => 0.0782467397,
										   pk_add2_mortgage_risk = 2  => 0.0911722142,
																		 0.1124134257);

		pk_add2_assessed_amount2_mm_b2 := map(pk_add2_assessed_amount2 = -1 => 0.0759070295,
											  pk_add2_assessed_amount2 = 0  => 0.1316270567,
											  pk_add2_assessed_amount2 = 1  => 0.1101449275,
											  pk_add2_assessed_amount2 = 2  => 0.0772014475,
											  pk_add2_assessed_amount2 = 3  => 0.082010582,
																			   0.0731764706);

		pk_yr_add2_date_first_seen2_mm_b2 := map(pk_yr_add2_date_first_seen2 = -1 => 0.1217312894,
												 pk_yr_add2_date_first_seen2 = 0  => 0.1019011407,
												 pk_yr_add2_date_first_seen2 = 1  => 0.0892034233,
												 pk_yr_add2_date_first_seen2 = 2  => 0.0852503383,
												 pk_yr_add2_date_first_seen2 = 3  => 0.082937365,
												 pk_yr_add2_date_first_seen2 = 4  => 0.0751316884,
												 pk_yr_add2_date_first_seen2 = 5  => 0.09044658,
												 pk_yr_add2_date_first_seen2 = 6  => 0.085978836,
												 pk_yr_add2_date_first_seen2 = 7  => 0.0652699436,
												 pk_yr_add2_date_first_seen2 = 8  => 0.072619384,
												 pk_yr_add2_date_first_seen2 = 9  => 0.0513047324,
												 pk_yr_add2_date_first_seen2 = 10 => 0.048427673,
																					 0.0623830318);

		pk_yr_add2_date_last_seen2_mm_b2 := map(pk_yr_add2_date_last_seen2 = -1 => 0.1217312894,
												pk_yr_add2_date_last_seen2 = 0  => 0.0871743004,
												pk_yr_add2_date_last_seen2 = 1  => 0.0813600486,
												pk_yr_add2_date_last_seen2 = 2  => 0.0584231424,
												pk_yr_add2_date_last_seen2 = 3  => 0.0625402966,
												pk_yr_add2_date_last_seen2 = 4  => 0.0517799353,
												pk_yr_add2_date_last_seen2 = 5  => 0.0481667865,
																				   0.04017042);

		pk_add3_mortgage_risk_mm_b2 := map(pk_add3_mortgage_risk = -1 => 0.1612903226,
										   pk_add3_mortgage_risk = 0  => 0.0748373102,
										   pk_add3_mortgage_risk = 1  => 0.0333333333,
										   pk_add3_mortgage_risk = 2  => 0.0784508836,
										   pk_add3_mortgage_risk = 3  => 0.087075575,
										   pk_add3_mortgage_risk = 4  => 0.1024193548,
																		 0.1333333333);

		pk_add3_assessed_amount2_mm_b2 := map(pk_add3_assessed_amount2 = -1 => 0.0795729748,
											  pk_add3_assessed_amount2 = 0  => 0.1398963731,
											  pk_add3_assessed_amount2 = 1  => 0.118705036,
											  pk_add3_assessed_amount2 = 2  => 0.0820219361,
																			   0.0694905035);

		pk_yr_add3_date_first_seen2_mm_b2 := map(pk_yr_add3_date_first_seen2 = -1 => 0.0963419051,
												 pk_yr_add3_date_first_seen2 = 0  => 0.1023869347,
												 pk_yr_add3_date_first_seen2 = 1  => 0.1002994012,
												 pk_yr_add3_date_first_seen2 = 2  => 0.0926847951,
												 pk_yr_add3_date_first_seen2 = 3  => 0.0894922071,
												 pk_yr_add3_date_first_seen2 = 4  => 0.0820770519,
												 pk_yr_add3_date_first_seen2 = 5  => 0.0854700855,
												 pk_yr_add3_date_first_seen2 = 6  => 0.0763319672,
												 pk_yr_add3_date_first_seen2 = 7  => 0.0645526614,
												 pk_yr_add3_date_first_seen2 = 8  => 0.0565749235,
																					 0.0508130081);

		pk_watercraft_count_mm_b2 := map(pk_watercraft_count = 0 => 0.081862395,
										 pk_watercraft_count = 1 => 0.0403337969,
																	0.0220385675);

		pk_bk_level_mm_b2 := if(pk_bk_level_2 = 0, 0.0801705757, NULL);

		pk_eviction_level_mm_b2 := if(pk_eviction_level = 0, 0.0801705757, NULL);

		pk_lien_type_level_mm_b2 := if(pk_lien_type_level = 0, 0.0801705757, NULL);

		pk_yr_liens_last_unrel_date3_mm_b2 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0801705757, NULL);

		pk_yr_ln_unrel_lt_f_sn2_mm_b2 := if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.0801705757, NULL);

		pk_yr_ln_unrel_ot_f_sn2_mm_b2 := if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.0801705757, NULL);

		pk_crime_level_mm_b2 := map(pk_crime_level = 0 => 0.0805726377,
														  0.0292887029);

		pk_attr_total_number_derogs_mm_b2 := if(pk_attr_total_number_derogs_5 = 0, 0.0801705757, NULL);

		pk_yr_rc_ssnhighissue2_mm_b2 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.1209918769,
											pk_yr_rc_ssnhighissue2 = 0  => 0,
											pk_yr_rc_ssnhighissue2 = 1  => 0.1129943503,
											pk_yr_rc_ssnhighissue2 = 2  => 0.0957542909,
											pk_yr_rc_ssnhighissue2 = 3  => 0.1052631579,
											pk_yr_rc_ssnhighissue2 = 4  => 0.1154639175,
											pk_yr_rc_ssnhighissue2 = 5  => 0.0866838805,
											pk_yr_rc_ssnhighissue2 = 6  => 0.0838641189,
											pk_yr_rc_ssnhighissue2 = 7  => 0.0723514212,
											pk_yr_rc_ssnhighissue2 = 8  => 0.0639147803,
											pk_yr_rc_ssnhighissue2 = 9  => 0.0664540138,
											pk_yr_rc_ssnhighissue2 = 10 => 0.0587748344,
											pk_yr_rc_ssnhighissue2 = 11 => 0.050194415,
											pk_yr_rc_ssnhighissue2 = 12 => 0.0605726872,
											pk_yr_rc_ssnhighissue2 = 13 => 0.0338894682,
																		   0.0405505952);

		pk_prof_lic_cat_mm_b2 := map(pk_prof_lic_cat = -1 => 0.0821602252,
									 pk_prof_lic_cat = 0  => 0.0931122449,
									 pk_prof_lic_cat = 1  => 0.064293915,
									 pk_prof_lic_cat = 2  => 0.0547520661,
															 0.0292397661);

		pk_add1_lres_mm_b2 := map(pk_add1_lres = -2 => 0.0526315789,
								  pk_add1_lres = -1 => 0.1081054783,
								  pk_add1_lres = 0  => 0.044058745,
								  pk_add1_lres = 1  => 0.0653594771,
								  pk_add1_lres = 2  => 0.0738255034,
								  pk_add1_lres = 3  => 0.0694444444,
								  pk_add1_lres = 4  => 0.0833851898,
								  pk_add1_lres = 5  => 0.079002079,
								  pk_add1_lres = 6  => 0.0699432892,
								  pk_add1_lres = 7  => 0.0784020508,
								  pk_add1_lres = 8  => 0.0673463912,
								  pk_add1_lres = 9  => 0.0560957367,
								  pk_add1_lres = 10 => 0.0506419401,
													   0.0344086022);

		pk_add2_lres_mm_b2 := map(pk_add2_lres = -2 => 0.1162361624,
								  pk_add2_lres = -1 => 0.0562364816,
								  pk_add2_lres = 0  => 0.0976076555,
								  pk_add2_lres = 1  => 0.0914166085,
								  pk_add2_lres = 2  => 0.0904255319,
								  pk_add2_lres = 3  => 0.0881094953,
								  pk_add2_lres = 4  => 0.0912799592,
								  pk_add2_lres = 5  => 0.0796407186,
								  pk_add2_lres = 6  => 0.0761431412,
								  pk_add2_lres = 7  => 0.0802760625,
								  pk_add2_lres = 8  => 0.067223382,
								  pk_add2_lres = 9  => 0.0583596215,
													   0.0779816514);

		pk_add3_lres_mm_b2 := map(pk_add3_lres = -2 => 0.0968218773,
								  pk_add3_lres = -1 => 0.0674174879,
								  pk_add3_lres = 0  => 0.0854215391,
								  pk_add3_lres = 1  => 0.0835401158,
								  pk_add3_lres = 2  => 0.0859395532,
								  pk_add3_lres = 3  => 0.0715990453,
								  pk_add3_lres = 4  => 0.0818268316,
								  pk_add3_lres = 5  => 0.0621118012,
													   0.0725907384);

		pk_addrs_5yr_mm_b2 := map(pk_addrs_5yr = 0 => 0.0671604318,
								  pk_addrs_5yr = 1 => 0.080481757,
								  pk_addrs_5yr = 2 => 0.0834293237,
								  pk_addrs_5yr = 3 => 0.1124429224,
													  0.12);

		pk_addrs_15yr_mm_b2 := map(pk_addrs_15yr = 0 => 0.0811287478,
								   pk_addrs_15yr = 1 => 0.0782131481,
								   pk_addrs_15yr = 2 => 0.0927628948,
														0.1592920354);

		pk_add_lres_month_avg2_mm_b2 := map(pk_add_lres_month_avg2 = -1 => 0.1876923077,
											pk_add_lres_month_avg2 = 0  => 0.1692307692,
											pk_add_lres_month_avg2 = 1  => 0.1111111111,
											pk_add_lres_month_avg2 = 2  => 0.1087470449,
											pk_add_lres_month_avg2 = 3  => 0.1134636265,
											pk_add_lres_month_avg2 = 4  => 0.1283950617,
											pk_add_lres_month_avg2 = 5  => 0.0885022693,
											pk_add_lres_month_avg2 = 6  => 0.0927152318,
											pk_add_lres_month_avg2 = 7  => 0.0879523591,
											pk_add_lres_month_avg2 = 8  => 0.0911016949,
											pk_add_lres_month_avg2 = 9  => 0.0905418251,
											pk_add_lres_month_avg2 = 10 => 0.0772594752,
											pk_add_lres_month_avg2 = 11 => 0.0797196671,
											pk_add_lres_month_avg2 = 12 => 0.0685500623,
											pk_add_lres_month_avg2 = 13 => 0.0597374179,
											pk_add_lres_month_avg2 = 15 => 0.0558199913,
																		   0.0498830865);

		pk_nameperssn_count_mm_b2 := map(pk_nameperssn_count = 0 => 0.0787910552,
										 pk_nameperssn_count = 1 => 0.1004390779,
																	0.1395348837);

		pk_ssns_per_adl_mm_b2 := map(pk_ssns_per_adl = -1 => 0.1419878296,
									 pk_ssns_per_adl = 0  => 0.0720647427,
									 pk_ssns_per_adl = 1  => 0.1004829123,
									 pk_ssns_per_adl = 2  => 0.1033099298,
									 pk_ssns_per_adl = 3  => 0.1641025641,
															 0.2419354839);

		pk_addrs_per_adl_mm_b2 := map(pk_addrs_per_adl = -6 => 0.1792114695,
									  pk_addrs_per_adl = -5 => 0.1117266851,
									  pk_addrs_per_adl = -4 => 0.0836980306,
									  pk_addrs_per_adl = -3 => 0.0867966164,
									  pk_addrs_per_adl = -2 => 0.0803341902,
									  pk_addrs_per_adl = -1 => 0.085106383,
									  pk_addrs_per_adl = 0  => 0.0740364252,
									  pk_addrs_per_adl = 1  => 0.0684986061,
									  pk_addrs_per_adl = 2  => 0.079461711,
															   0.0818291215);

		pk_phones_per_adl_mm_b2 := map(pk_phones_per_adl = -1 => 0.0950876541,
									   pk_phones_per_adl = 0  => 0.0621459513,
									   pk_phones_per_adl = 1  => 0.0665312341,
																 0.0867208672);

		pk_adlperssn_count_mm_b2 := map(pk_adlperssn_count = -1 => 0.120987302,
										pk_adlperssn_count = 0  => 0.0636228991,
										pk_adlperssn_count = 1  => 0.0708154506,
																   0.0947591318);

		pk_addrs_per_ssn_mm_b2 := map(pk_addrs_per_ssn = -4 => 0.1208885092,
									  pk_addrs_per_ssn = -3 => 0.0726923077,
									  pk_addrs_per_ssn = -2 => 0.0628177197,
									  pk_addrs_per_ssn = -1 => 0.0683760684,
									  pk_addrs_per_ssn = 0  => 0.0644814616,
									  pk_addrs_per_ssn = 1  => 0.0690423163,
									  pk_addrs_per_ssn = 2  => 0.065631929,
															   0.0627802691);

		pk_adls_per_addr_mm_b2 := map(pk_adls_per_addr = -102 => 0.1199021207,
									  pk_adls_per_addr = -101 => 0.0981595092,
									  pk_adls_per_addr = -2   => 0.0552575107,
									  pk_adls_per_addr = -1   => 0.0459770115,
									  pk_adls_per_addr = 0    => 0.018018018,
									  pk_adls_per_addr = 1    => 0.0372040586,
									  pk_adls_per_addr = 2    => 0.0433553252,
									  pk_adls_per_addr = 3    => 0.0547112462,
									  pk_adls_per_addr = 4    => 0.0530054645,
									  pk_adls_per_addr = 5    => 0.0580985915,
									  pk_adls_per_addr = 6    => 0.0619834711,
									  pk_adls_per_addr = 7    => 0.0761828388,
									  pk_adls_per_addr = 8    => 0.0972338642,
									  pk_adls_per_addr = 9    => 0.0942578548,
									  pk_adls_per_addr = 10   => 0.0959894806,
									  pk_adls_per_addr = 11   => 0.1161745828,
									  pk_adls_per_addr = 12   => 0.1332445037,
									  pk_adls_per_addr = 13   => 0.1614409606,
									  pk_adls_per_addr = 100  => 0.12,
									  pk_adls_per_addr = 101  => 0.1007194245,
																 0.1276771005);

		pk_phones_per_addr_mm_b2 := map(pk_phones_per_addr = -1  => 0.0693512304,
										pk_phones_per_addr = 0   => 0.0665746809,
										pk_phones_per_addr = 1   => 0.0918227501,
										pk_phones_per_addr = 2   => 0.144963145,
										pk_phones_per_addr = 3   => 0.1085972851,
										pk_phones_per_addr = 100 => 0.150862069,
										pk_phones_per_addr = 101 => 0.139941691,
										pk_phones_per_addr = 102 => 0.1510574018,
																	0.1131716595);

		pk_adls_per_phone_mm_b2 := map(pk_adls_per_phone = -2 => 0.0971208999,
									   pk_adls_per_phone = -1 => 0.0579193811,
									   pk_adls_per_phone = 0  => 0.0449392713,
																 0.0854700855);

		pk_ssns_per_adl_c6_mm_b2 := map(pk_ssns_per_adl_c6 = 0 => 0.0796309439,
										pk_ssns_per_adl_c6 = 1 => 0.0801618548,
																  0.1359223301);

		pk_addrs_per_adl_c6_mm_b2 := map(pk_addrs_per_adl_c6 = 0 => 0.0794680637,
										 pk_addrs_per_adl_c6 = 1 => 0.081168134,
										 pk_addrs_per_adl_c6 = 2 => 0.0935334873,
																	0.0884353741);

		pk_phones_per_adl_c6_mm_b2 := map(pk_phones_per_adl_c6 = -2 => 0.0818834317,
										  pk_phones_per_adl_c6 = -1 => 0.068700114,
										  pk_phones_per_adl_c6 = 0  => 0.0652173913,
																	   0.0681818182);

		pk_ssns_per_addr_c6_mm_b2 := map(pk_ssns_per_addr_c6 = 0   => 0.0646292585,
										 pk_ssns_per_addr_c6 = 1   => 0.0936651584,
										 pk_ssns_per_addr_c6 = 2   => 0.0649542368,
										 pk_ssns_per_addr_c6 = 3   => 0.0974576271,
										 pk_ssns_per_addr_c6 = 4   => 0.0892857143,
										 pk_ssns_per_addr_c6 = 5   => 0.0617283951,
										 pk_ssns_per_addr_c6 = 6   => 0.1967213115,
										 pk_ssns_per_addr_c6 = 100 => 0.1214852973,
										 pk_ssns_per_addr_c6 = 101 => 0.1216545012,
										 pk_ssns_per_addr_c6 = 102 => 0.1204188482,
										 pk_ssns_per_addr_c6 = 103 => 0.0677966102,
																	  0.0416666667);

		pk_phones_per_addr_c6_mm_b2 := map(pk_phones_per_addr_c6 = -1  => 0.0678798509,
										   pk_phones_per_addr_c6 = 0   => 0.1057062675,
										   pk_phones_per_addr_c6 = 1   => 0.1165644172,
										   pk_phones_per_addr_c6 = 2   => 0.2,
										   pk_phones_per_addr_c6 = 100 => 0.1194997684,
										   pk_phones_per_addr_c6 = 101 => 0.1179749187,
																		  0.1279069767);

		pk_adls_per_phone_c6_mm_b2 := map(pk_adls_per_phone_c6 = 0 => 0.0816942374,
										  pk_adls_per_phone_c6 = 1 => 0.0760504202,
																	  0.0266666667);

		pk_attr_addrs_last24_mm_b2 := map(pk_attr_addrs_last24 = 0 => 0.0746098211,
										  pk_attr_addrs_last24 = 1 => 0.0829230081,
										  pk_attr_addrs_last24 = 2 => 0.0875873186,
										  pk_attr_addrs_last24 = 3 => 0.0915542938,
										  pk_attr_addrs_last24 = 4 => 0.1107266436,
																	  0.1025641026);

		pk_attr_addrs_last36_mm_b2 := map(pk_attr_addrs_last36 = 0 => 0.0700296736,
										  pk_attr_addrs_last36 = 1 => 0.0813607839,
										  pk_attr_addrs_last36 = 2 => 0.0877899176,
										  pk_attr_addrs_last36 = 3 => 0.0833985904,
										  pk_attr_addrs_last36 = 4 => 0.1102150538,
										  pk_attr_addrs_last36 = 5 => 0.105,
																	  0.134375);

		pk_ams_class_level_mm_b2 := map(pk_ams_class_level = -1000001 => 0.0786772665,
										pk_ams_class_level = 0        => 0.3695652174,
										pk_ams_class_level = 1        => 0.1818181818,
										pk_ams_class_level = 2        => 0.1403508772,
										pk_ams_class_level = 3        => 0.1818181818,
										pk_ams_class_level = 4        => 0.1538461538,
										pk_ams_class_level = 5        => 0.103626943,
										pk_ams_class_level = 6        => 0.1056751468,
										pk_ams_class_level = 7        => 0.0891089109,
										pk_ams_class_level = 8        => 0.0817391304,
										pk_ams_class_level = 1000000  => 0.1525423729,
										pk_ams_class_level = 1000001  => 0.0444444444,
										pk_ams_class_level = 1000002  => 0.0449172577,
										pk_ams_class_level = 1000003  => 0.0188679245,
										pk_ams_class_level = 1000004  => 0.0206896552,
																		 0.0381679389);

		pk_ams_income_level_code_mm_b2 := map(pk_ams_income_level_code = -1 => 0.0786772665,
											  pk_ams_income_level_code = 0  => 0.203125,
											  pk_ams_income_level_code = 1  => 0.1679389313,
											  pk_ams_income_level_code = 2  => 0.1125498008,
											  pk_ams_income_level_code = 3  => 0.0784313725,
											  pk_ams_income_level_code = 4  => 0.0764163373,
											  pk_ams_income_level_code = 5  => 0.0616016427,
																			   0.0627062706);

		pk_college_tier_mm_b2 := map((integer)pk_college_tier = -1 => 0.0817984646,
									 (integer)pk_college_tier = 1  => 0.02,
									 (integer)pk_college_tier = 2  => 0.0130718954,
									 (integer)pk_college_tier = 3  => 0.0292134831,
									 (integer)pk_college_tier = 4  => 0.0643153527,
									 (integer)pk_college_tier = 5  => 0.0531914894,
																	  0.0916666667);

		pk_ams_age_mm_b2 := map(pk_ams_age = -1 => 0.0776519946,
								pk_ams_age = 21 => 0.2794117647,
								pk_ams_age = 22 => 0.15,
								pk_ams_age = 23 => 0.152,
								pk_ams_age = 24 => 0.1538461538,
								pk_ams_age = 25 => 0.1717171717,
								pk_ams_age = 29 => 0.1105610561,
												   0.090813094);

		pk_inferred_age_mm_b2 := map(pk_inferred_age = -1 => 0.185520362,
									 pk_inferred_age = 18 => 0.1701030928,
									 pk_inferred_age = 19 => 0.1610738255,
									 pk_inferred_age = 20 => 0.1968911917,
									 pk_inferred_age = 21 => 0.1418918919,
									 pk_inferred_age = 22 => 0.15625,
									 pk_inferred_age = 24 => 0.1331592689,
									 pk_inferred_age = 34 => 0.1004130918,
									 pk_inferred_age = 37 => 0.079435128,
									 pk_inferred_age = 41 => 0.0750514051,
									 pk_inferred_age = 42 => 0.0753701211,
									 pk_inferred_age = 43 => 0.0584415584,
									 pk_inferred_age = 44 => 0.0691994573,
									 pk_inferred_age = 46 => 0.0784177654,
									 pk_inferred_age = 48 => 0.0781021898,
									 pk_inferred_age = 52 => 0.0657998424,
									 pk_inferred_age = 56 => 0.0604997808,
									 pk_inferred_age = 61 => 0.0602036299,
															 0.048);

		pk_yr_reported_dob2_mm_b2 := map(pk_yr_reported_dob2 = -1 => 0.1293449988,
										 pk_yr_reported_dob2 = 19 => 0.4375,
										 pk_yr_reported_dob2 = 21 => 0.1730769231,
										 pk_yr_reported_dob2 = 22 => 0.12,
										 pk_yr_reported_dob2 = 23 => 0.12,
										 pk_yr_reported_dob2 = 32 => 0.0964809384,
										 pk_yr_reported_dob2 = 35 => 0.0896589659,
										 pk_yr_reported_dob2 = 39 => 0.0779406507,
										 pk_yr_reported_dob2 = 42 => 0.0765503876,
										 pk_yr_reported_dob2 = 43 => 0.0782122905,
										 pk_yr_reported_dob2 = 44 => 0.0605652759,
										 pk_yr_reported_dob2 = 45 => 0.0678925035,
										 pk_yr_reported_dob2 = 46 => 0.0821325648,
										 pk_yr_reported_dob2 = 49 => 0.0776746458,
										 pk_yr_reported_dob2 = 57 => 0.0628385699,
										 pk_yr_reported_dob2 = 61 => 0.0627705628,
																	 0.0484993475);

		pk_avm_hit_level_mm_b2 := map(pk_avm_hit_level = -1 => 0.0971792226,
									  pk_avm_hit_level = 0  => 0.0833474504,
									  pk_avm_hit_level = 1  => 0.077262931,
															   0.0706155143);

		pk_avm_auto_diff4_lvl_mm_b2 := map(pk_avm_auto_diff4_lvl = -1 => 0.0759863429,
										   pk_avm_auto_diff4_lvl = 0  => 0.108219531,
																		 0.0860655738);

		pk_add2_avm_auto_diff3_lvl_mm_b2 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.0790795468,
												pk_add2_avm_auto_diff3_lvl = -1 => 0.1185814555,
																				   0.0721659159);

		pk2_add1_avm_as_mm_b2 := map(pk2_add1_avm_as = 0 => 0.0886652955,
									 pk2_add1_avm_as = 1 => 0.0784951231,
									 pk2_add1_avm_as = 2 => 0.063487882,
															0.0484949833);

		pk2_add1_avm_mkt_mm_b2 := map(pk2_add1_avm_mkt = 0 => 0.1587301587,
									  pk2_add1_avm_mkt = 1 => 0.0811119952,
									  pk2_add1_avm_mkt = 2 => 0.0942501482,
									  pk2_add1_avm_mkt = 3 => 0.0699149683,
															  0.0442176871);

		pk2_add1_avm_hed_mm_b2 := map(pk2_add1_avm_hed = 0 => 0.2119205298,
									  pk2_add1_avm_hed = 1 => 0.1849529781,
									  pk2_add1_avm_hed = 2 => 0.1275415896,
									  pk2_add1_avm_hed = 3 => 0.0864294331,
									  pk2_add1_avm_hed = 4 => 0.0863402062,
									  pk2_add1_avm_hed = 5 => 0.0665417893,
															  0.0418963616);

		pk2_add1_avm_auto_mm_b2 := map(pk2_add1_avm_auto = 0 => 0.175,
									   pk2_add1_avm_auto = 1 => 0.1408450704,
									   pk2_add1_avm_auto = 2 => 0.1587677725,
									   pk2_add1_avm_auto = 3 => 0.1171171171,
									   pk2_add1_avm_auto = 4 => 0.0915173593,
									   pk2_add1_avm_auto = 5 => 0.0678176796,
																0.042834891);

		pk2_add1_avm_auto2_mm_b2 := map(pk2_add1_avm_auto2 = 0 => 0.1807228916,
										pk2_add1_avm_auto2 = 1 => 0.1924528302,
										pk2_add1_avm_auto2 = 2 => 0.1498559078,
										pk2_add1_avm_auto2 = 3 => 0.1139896373,
										pk2_add1_avm_auto2 = 4 => 0.0879469222,
										pk2_add1_avm_auto2 = 5 => 0.08811749,
										pk2_add1_avm_auto2 = 6 => 0.0678579681,
																  0.0463519313);

		pk2_add1_avm_auto3_mm_b2 := map(pk2_add1_avm_auto3 = 0 => 0.1481481481,
										pk2_add1_avm_auto3 = 1 => 0.1731843575,
										pk2_add1_avm_auto3 = 2 => 0.109375,
										pk2_add1_avm_auto3 = 3 => 0.0867659947,
										pk2_add1_avm_auto3 = 4 => 0.0760499432,
										pk2_add1_avm_auto3 = 5 => 0.0707364341,
										pk2_add1_avm_auto3 = 6 => 0.0676217765,
																  0.0449678801);

		pk2_add1_avm_auto4_mm_b2 := map(pk2_add1_avm_auto4 = 0 => 0.0909090909,
										pk2_add1_avm_auto4 = 1 => 0.1162790698,
										pk2_add1_avm_auto4 = 2 => 0.1351351351,
										pk2_add1_avm_auto4 = 3 => 0.0769115217,
										pk2_add1_avm_auto4 = 4 => 0.1200241255,
										pk2_add1_avm_auto4 = 5 => 0.0944606414,
																  0.0508982036);

		pk2_add1_avm_med_mm_b2 := map(pk2_add1_avm_med = 0 => 0.2653061224,
									  pk2_add1_avm_med = 1 => 0.2237442922,
									  pk2_add1_avm_med = 2 => 0.1666666667,
									  pk2_add1_avm_med = 3 => 0.1258823529,
									  pk2_add1_avm_med = 4 => 0.1043298969,
									  pk2_add1_avm_med = 5 => 0.07654011,
									  pk2_add1_avm_med = 6 => 0.0363951473,
															  0.0565770863);

		pk2_add1_avm_to_med_ratio_mm_b2 := map(pk2_add1_avm_to_med_ratio = 0 => 0.0884955752,
											   pk2_add1_avm_to_med_ratio = 1 => 0.0771921361,
											   pk2_add1_avm_to_med_ratio = 2 => 0.0713980333,
											   pk2_add1_avm_to_med_ratio = 3 => 0.0671423938,
											   pk2_add1_avm_to_med_ratio = 4 => 0.0611835507,
																				0.0606995885);

		pk2_add2_avm_sp_mm_b2 := map(pk2_add2_avm_sp = 0 => 0.1153846154,
									 pk2_add2_avm_sp = 1 => 0.1063829787,
									 pk2_add2_avm_sp = 2 => 0.0886262925,
									 pk2_add2_avm_sp = 3 => 0.0797407141,
									 pk2_add2_avm_sp = 4 => 0.0863213811,
															0.0741418764);

		pk2_add2_avm_mkt_mm_b2 := map(pk2_add2_avm_mkt = 0 => 0.1525974026,
									  pk2_add2_avm_mkt = 1 => 0.1455108359,
									  pk2_add2_avm_mkt = 2 => 0.0789949158,
									  pk2_add2_avm_mkt = 3 => 0.0785650224,
															  0.0666666667);

		pk2_add2_avm_hed_mm_b2 := map(pk2_add2_avm_hed = 0 => 0.25,
									  pk2_add2_avm_hed = 1 => 0.168,
									  pk2_add2_avm_hed = 2 => 0.1154734411,
									  pk2_add2_avm_hed = 3 => 0.0795425667,
									  pk2_add2_avm_hed = 4 => 0.1041292639,
									  pk2_add2_avm_hed = 5 => 0.074477298,
															  0.0557667934);

		pk2_add2_avm_auto_mm_b2 := map(pk2_add2_avm_auto = 0 => 0.1494252874,
									   pk2_add2_avm_auto = 1 => 0.0806914588,
									   pk2_add2_avm_auto = 2 => 0.0784729586,
																0.0649484536);

		pk2_add2_avm_auto3_mm_b2 := map(pk2_add2_avm_auto3 = 0 => 0.1609589041,
										pk2_add2_avm_auto3 = 1 => 0.1201298701,
										pk2_add2_avm_auto3 = 2 => 0.0809895691,
										pk2_add2_avm_auto3 = 3 => 0.0755369494,
																  0.0802047782);

		pk2_add2_avm_auto4_mm_b2 := map(pk2_add2_avm_auto4 = 0 => 0.1428571429,
										pk2_add2_avm_auto4 = 1 => 0.0303030303,
										pk2_add2_avm_auto4 = 2 => 0.2361111111,
										pk2_add2_avm_auto4 = 3 => 0.0748898678,
										pk2_add2_avm_auto4 = 4 => 0.1190397895,
																  0.1017612524);

		pk2_yr_add1_avm_rec_dt_mm_b2 := map(pk2_yr_add1_avm_recording_date = 0 => 0.0788518641,
											pk2_yr_add1_avm_recording_date = 1 => 0.091,
											pk2_yr_add1_avm_recording_date = 2 => 0.0845109758,
											pk2_yr_add1_avm_recording_date = 3 => 0.0678783383,
																				  0.0666975452);

		pk2_yr_add1_avm_assess_year_mm_b2 := map(pk2_yr_add1_avm_assess_year = 0 => 0.0888367415,
												 pk2_yr_add1_avm_assess_year = 1 => 0.0872180451,
																					0.0704353933);

		pk_dist_a1toa2_mm_b2 := map(pk_dist_a1toa2_2 = 0 => 0.0770978276,
									pk_dist_a1toa2_2 = 1 => 0.0720726922,
									pk_dist_a1toa2_2 = 2 => 0.093919837,
									pk_dist_a1toa2_2 = 3 => 0.0939706681,
															0.107925801);

		pk_dist_a1toa3_mm_b2 := map(pk_dist_a1toa3_2 = 0 => 0.0830923463,
									pk_dist_a1toa3_2 = 1 => 0.0652889163,
									pk_dist_a1toa3_2 = 2 => 0.0800408719,
									pk_dist_a1toa3_2 = 3 => 0.1100671141,
									pk_dist_a1toa3_2 = 4 => 0.1049773756,
									pk_dist_a1toa3_2 = 5 => 0.0899795501,
															0.0909710392);

		pk_rc_disthphoneaddr_mm_b2 := map(pk_rc_disthphoneaddr_2 = 0 => 0.0520759193,
										  pk_rc_disthphoneaddr_2 = 1 => 0.0656554713,
										  pk_rc_disthphoneaddr_2 = 2 => 0.058974359,
										  pk_rc_disthphoneaddr_2 = 3 => 0.0778625954,
																		0.1002811621);

		pk_out_st_division_lvl_mm_b2 := map(pk_out_st_division_lvl = -1 => 0.12,
											pk_out_st_division_lvl = 0  => 0.0366101695,
											pk_out_st_division_lvl = 1  => 0.03826617,
											pk_out_st_division_lvl = 2  => 0.0966167859,
											pk_out_st_division_lvl = 3  => 0.064516129,
											pk_out_st_division_lvl = 4  => 0.0906094345,
											pk_out_st_division_lvl = 5  => 0.0604501608,
											pk_out_st_division_lvl = 6  => 0.0668123634,
											pk_out_st_division_lvl = 7  => 0.1079564213,
																		   0.0718002081);

		pk_wealth_index_mm_b2 := map(pk_wealth_index_2 = 0 => 0.0660960533,
									 pk_wealth_index_2 = 1 => 0.1538908246,
									 pk_wealth_index_2 = 2 => 0.1066605631,
									 pk_wealth_index_2 = 3 => 0.0788879648,
															  0.0655903128);

		pk_impulse_count_mm_b2 := if(pk_impulse_count_2 = 0, 0.0801705757, NULL);

		pk_attr_num_nonderogs90_b_mm_b2 := map(pk_attr_num_nonderogs90_b = 0  => 0.1740139211,
											   pk_attr_num_nonderogs90_b = 1  => 0.1399856425,
											   pk_attr_num_nonderogs90_b = 2  => 0.0979646186,
											   pk_attr_num_nonderogs90_b = 3  => 0.0543016029,
											   pk_attr_num_nonderogs90_b = 4  => 0.0546265329,
											   pk_attr_num_nonderogs90_b = 10 => 0.0917431193,
											   pk_attr_num_nonderogs90_b = 11 => 0.1003285871,
											   pk_attr_num_nonderogs90_b = 12 => 0.0601727311,
											   pk_attr_num_nonderogs90_b = 13 => 0.0354309889,
																				 0.023580786);

		pk_ssns_per_addr2_mm_b2 := map(pk_ssns_per_addr2 = -101 => 0.1184008201,
									   pk_ssns_per_addr2 = -2   => 0.0521348315,
									   pk_ssns_per_addr2 = -1   => 0.0379562044,
									   pk_ssns_per_addr2 = 0    => 0.0194269063,
									   pk_ssns_per_addr2 = 1    => 0.048082427,
									   pk_ssns_per_addr2 = 2    => 0.0394265233,
									   pk_ssns_per_addr2 = 3    => 0.0568647541,
									   pk_ssns_per_addr2 = 4    => 0.0449704142,
									   pk_ssns_per_addr2 = 5    => 0.0486284289,
									   pk_ssns_per_addr2 = 6    => 0.0616531165,
									   pk_ssns_per_addr2 = 7    => 0.0724637681,
									   pk_ssns_per_addr2 = 8    => 0.0936733693,
									   pk_ssns_per_addr2 = 9    => 0.0929292929,
									   pk_ssns_per_addr2 = 10   => 0.1171497585,
									   pk_ssns_per_addr2 = 11   => 0.1395683453,
									   pk_ssns_per_addr2 = 12   => 0.1584875302,
									   pk_ssns_per_addr2 = 100  => 0.1458333333,
									   pk_ssns_per_addr2 = 101  => 0.1016949153,
									   pk_ssns_per_addr2 = 102  => 0.1313131313,
																   0.1107266436);

		pk_yr_add2_assess_val_yr2_mm_b2 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.0823854404,
											   pk_yr_add2_assessed_value_year2 = 0  => 0.1282051282,
											   pk_yr_add2_assessed_value_year2 = 1  => 0.0720747442,
																					   0.0971168437);

		pk_estimated_income_mm_b3 := map(pk_estimated_income = -1 => 0.3087649402,
										 pk_estimated_income = 0  => 0.5,
										 pk_estimated_income = 1  => 0.3146562905,
										 pk_estimated_income = 2  => 0.3285175879,
										 pk_estimated_income = 3  => 0.2953667954,
										 pk_estimated_income = 4  => 0.2872531418,
										 pk_estimated_income = 5  => 0.2718214428,
										 pk_estimated_income = 6  => 0.2822986577,
										 pk_estimated_income = 7  => 0.2808933002,
										 pk_estimated_income = 8  => 0.2775881684,
										 pk_estimated_income = 9  => 0.2667112299,
										 pk_estimated_income = 10 => 0.2419984387,
										 pk_estimated_income = 11 => 0.2390542907,
										 pk_estimated_income = 12 => 0.2396825397,
										 pk_estimated_income = 13 => 0.2573426573,
										 pk_estimated_income = 14 => 0.2225859247,
										 pk_estimated_income = 15 => 0.225,
										 pk_estimated_income = 16 => 0.2399150743,
										 pk_estimated_income = 17 => 0.2270742358,
										 pk_estimated_income = 18 => 0.20861678,
										 pk_estimated_income = 19 => 0.1896551724,
										 pk_estimated_income = 20 => 0.1674629718,
										 pk_estimated_income = 21 => 0.1751824818,
																	 0.2150537634);

		pk_yr_adl_w_last_seen2_mm_b3 := map(pk_yr_adl_w_last_seen2 = -1 => 0.281685684,
											pk_yr_adl_w_last_seen2 = 0  => 0.1048387097,
											pk_yr_adl_w_last_seen2 = 1  => 0.1481481481,
																		   0.1588235294);

		pk_pr_count_mm_b3 := map(pk_pr_count = -1 => 0.2917858278,
								 pk_pr_count = 0  => 0.1310160428,
								 pk_pr_count = 1  => 0.1345603272,
													 0.1034482759);

		pk_addrs_sourced_lvl_mm_b3 := map(pk_addrs_sourced_lvl = 0 => 0.2876531975,
										  pk_addrs_sourced_lvl = 1 => 0.1443123939,
										  pk_addrs_sourced_lvl = 2 => 0.0677966102,
																	  0.0785714286);

		pk_add1_own_level_mm_b3 := map(pk_add1_own_level = -1 => 0.2953644106,
									   pk_add1_own_level = 0  => 0.2755298151,
										 pk_add1_own_level = 1  => 0.1556064073,
										 (15220 / 54322));  // changed to segment mean in the else case

		pk_add2_own_level_mm_b3 := map(pk_add2_own_level = 0 => 0.2888848315,
									   pk_add2_own_level = 1 => 0.1987659762,
									   pk_add2_own_level = 2 => 0.1421319797,
																0.1700680272);

		pk_add3_own_level_mm_b3 := map(pk_add3_own_level = 0 => 0.2867545144,
									   pk_add3_own_level = 1 => 0.1829738059,
									   pk_add3_own_level = 2 => 0.1546391753,
																0.0846905537);

		pk_naprop_level2_mm_b3 := map(pk_naprop_level2 = -2 => 0.2731973571,
									  pk_naprop_level2 = -1 => 0.3096675971,
									  pk_naprop_level2 = 0  => 0.2540983607,
									  pk_naprop_level2 = 1  => 0.1992011982,
									  pk_naprop_level2 = 2  => 0.2777102741,
									  pk_naprop_level2 = 3  => 0.2444771723,
									  pk_naprop_level2 = 4  => 0.1171366594,
															   0.192575406);

		pk_yr_add1_built_date2_mm_b3 := map(pk_yr_add1_built_date2 = -4 => 0.2718596569,
											pk_yr_add1_built_date2 = -3 => 0.0740740741,
											pk_yr_add1_built_date2 = -2 => 0.2477432297,
											pk_yr_add1_built_date2 = -1 => 0.2298546896,
											pk_yr_add1_built_date2 = 0  => 0.2574964303,
											pk_yr_add1_built_date2 = 1  => 0.2838445808,
											pk_yr_add1_built_date2 = 2  => 0.3173050801,
																		   0.3363115307);

		pk_add1_purchase_amount2_mm_b3 := map(pk_add1_purchase_amount2 = -1 => 0.2752753844,
											  pk_add1_purchase_amount2 = 0  => 0.3272890754,
																			   0.2679303746);

		pk_yr_add1_mortgage_date2_mm_b3 := map(pk_yr_add1_mortgage_date2 = -1 => 0.2757120522,
											   pk_yr_add1_mortgage_date2 = 0  => 0.3230966091,
											   pk_yr_add1_mortgage_date2 = 1  => 0.2694770544,
																				 0.2846111418);

		pk_add1_mortgage_risk_mm_b3 := map(pk_add1_mortgage_risk = -1 => 0.3333333333,
										   pk_add1_mortgage_risk = 0  => 0.2615526802,
										   pk_add1_mortgage_risk = 1  => 0.2779273504,
										   pk_add1_mortgage_risk = 2  => 0.2873603352,
																		 0.3303278689);

		pk_add1_assessed_amount2_mm_b3 := map(pk_add1_assessed_amount2 = -1 => 0.2732629704,
											  pk_add1_assessed_amount2 = 0  => 0.3941747573,
											  pk_add1_assessed_amount2 = 1  => 0.3752380952,
											  pk_add1_assessed_amount2 = 2  => 0.3291139241,
											  pk_add1_assessed_amount2 = 3  => 0.3167825223,
											  pk_add1_assessed_amount2 = 4  => 0.2942898975,
											  pk_add1_assessed_amount2 = 5  => 0.3128772636,
																			   0.2606103958);

		pk_yr_add1_mortgage_due_date2_mm_b3 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.2756724961,
												   pk_yr_add1_mortgage_due_date2 = 0  => 0.287275566,
												   pk_yr_add1_mortgage_due_date2 = 1  => 0.2902986917,
																						 0.311338484);

		pk_yr_add1_date_first_seen2_mm_b3 := map(pk_yr_add1_date_first_seen2 = -1 => 0.3006509684,
												 pk_yr_add1_date_first_seen2 = 0  => 0.2569486405,
												 pk_yr_add1_date_first_seen2 = 1  => 0.2631736527,
												 pk_yr_add1_date_first_seen2 = 2  => 0.2123850992,
												 pk_yr_add1_date_first_seen2 = 3  => 0.2288288288,
												 pk_yr_add1_date_first_seen2 = 4  => 0.1804812834,
												 pk_yr_add1_date_first_seen2 = 5  => 0.2090680101,
												 pk_yr_add1_date_first_seen2 = 6  => 0.1890243902,
												 pk_yr_add1_date_first_seen2 = 7  => 0.1718146718,
												 pk_yr_add1_date_first_seen2 = 8  => 0.1493506494,
												 pk_yr_add1_date_first_seen2 = 9  => 0.1272727273,
																					 0.2162162162);

		pk_add1_land_use_risk_level_mm_b3 := map(pk_add1_land_use_risk_level = 0 => 0.1818181818,
												 pk_add1_land_use_risk_level = 2 => 0.2794254701,
												 pk_add1_land_use_risk_level = 3 => 0.2739099751,
																					0.3457943925);

		pk_add1_building_area2_mm_b3 := map(pk_add1_building_area2 = -99 => 0.271446216,
											pk_add1_building_area2 = -4  => 0.3049680275,
											pk_add1_building_area2 = -3  => 0.3034367142,
											pk_add1_building_area2 = -2  => 0.2989214176,
											pk_add1_building_area2 = -1  => 0.2408899118,
											pk_add1_building_area2 = 0   => 0.2843040474,
											pk_add1_building_area2 = 1   => 0.3495575221,
											pk_add1_building_area2 = 2   => 0.3825503356,
											pk_add1_building_area2 = 3   => 0.4028571429,
																			0.3647375505);

		pk_property_owned_total_mm_b3 := if(pk_property_owned_total = -1, 0.2801811421, NULL);

		pk_prop_own_assess_tot2_mm_b3 := if(pk_prop_own_assess_tot2 = 0, 0.2801811421, NULL);

		pk_prop1_sale_price2_mm_b3 := map(pk_prop1_sale_price2 = 0 => 0.2830439338,
										  pk_prop1_sale_price2 = 1 => 0.1842105263,
																	  0.1023809524);

		pk_yr_prop2_sale_date2_mm_b3 := map(pk_yr_prop2_sale_date2 = 0 => 0.2810551825,
											pk_yr_prop2_sale_date2 = 1 => 0.1358024691,
											pk_yr_prop2_sale_date2 = 2 => 0.0873015873,
																		  0.0862068966);

		pk_add2_no_of_buildings_mm_b3 := map(pk_add2_no_of_buildings = -1 => 0.2849050101,
											 pk_add2_no_of_buildings = 0  => 0.2488010464,
											 pk_add2_no_of_buildings = 1  => 0.271714922,
																			 0.3162393162);

		pk_add2_parking_no_of_cars_mm_b3 := map(pk_add2_parking_no_of_cars = 0 => 0.2860122674,
												pk_add2_parking_no_of_cars = 1 => 0.2729744426,
												pk_add2_parking_no_of_cars = 2 => 0.2182562902,
																				  0.1909937888);

		pk_add2_mortgage_risk_mm_b3 := map(pk_add2_mortgage_risk = -1 => 0.2682926829,
										   pk_add2_mortgage_risk = 0  => 0.1995852773,
										   pk_add2_mortgage_risk = 1  => 0.2848477346,
										   pk_add2_mortgage_risk = 2  => 0.2472019465,
																		 0.2788408967);

		pk_add2_assessed_amount2_mm_b3 := map(pk_add2_assessed_amount2 = -1 => 0.2868842923,
											  pk_add2_assessed_amount2 = 0  => 0.3785357737,
											  pk_add2_assessed_amount2 = 1  => 0.3142857143,
											  pk_add2_assessed_amount2 = 2  => 0.2684931507,
											  pk_add2_assessed_amount2 = 3  => 0.2450403314,
																			   0.1983232148);

		pk_yr_add2_date_first_seen2_mm_b3 := map(pk_yr_add2_date_first_seen2 = -1 => 0.3383044254,
												 pk_yr_add2_date_first_seen2 = 0  => 0.2580008768,
												 pk_yr_add2_date_first_seen2 = 1  => 0.2642045455,
												 pk_yr_add2_date_first_seen2 = 2  => 0.2498500899,
												 pk_yr_add2_date_first_seen2 = 3  => 0.2496199453,
												 pk_yr_add2_date_first_seen2 = 4  => 0.2404856409,
												 pk_yr_add2_date_first_seen2 = 5  => 0.2538915727,
												 pk_yr_add2_date_first_seen2 = 6  => 0.2564885496,
												 pk_yr_add2_date_first_seen2 = 7  => 0.2502685285,
												 pk_yr_add2_date_first_seen2 = 8  => 0.2317198764,
												 pk_yr_add2_date_first_seen2 = 9  => 0.2114485981,
												 pk_yr_add2_date_first_seen2 = 10 => 0.1798715203,
																					 0.1776155718);

		pk_yr_add2_date_last_seen2_mm_b3 := map(pk_yr_add2_date_last_seen2 = -1 => 0.3383044254,
												pk_yr_add2_date_last_seen2 = 0  => 0.2572186023,
												pk_yr_add2_date_last_seen2 = 1  => 0.2107652399,
												pk_yr_add2_date_last_seen2 = 2  => 0.1789577188,
												pk_yr_add2_date_last_seen2 = 3  => 0.2219354839,
												pk_yr_add2_date_last_seen2 = 4  => 0.2060085837,
												pk_yr_add2_date_last_seen2 = 5  => 0.2075471698,
																				   0.1727861771);

		pk_add3_mortgage_risk_mm_b3 := map(pk_add3_mortgage_risk = -1 => 0.2093023256,
										   pk_add3_mortgage_risk = 0  => 0.1958456973,
										   pk_add3_mortgage_risk = 1  => 0.1666666667,
										   pk_add3_mortgage_risk = 2  => 0.2840979634,
										   pk_add3_mortgage_risk = 3  => 0.251651255,
										   pk_add3_mortgage_risk = 4  => 0.2625698324,
																		 0.2577639752);

		pk_add3_assessed_amount2_mm_b3 := map(pk_add3_assessed_amount2 = -1 => 0.2882310564,
											  pk_add3_assessed_amount2 = 0  => 0.3560371517,
											  pk_add3_assessed_amount2 = 1  => 0.3375,
											  pk_add3_assessed_amount2 = 2  => 0.2543962485,
																			   0.2007462687);

		pk_yr_add3_date_first_seen2_mm_b3 := map(pk_yr_add3_date_first_seen2 = -1 => 0.3240234452,
												 pk_yr_add3_date_first_seen2 = 0  => 0.3062719812,
												 pk_yr_add3_date_first_seen2 = 1  => 0.2632062471,
												 pk_yr_add3_date_first_seen2 = 2  => 0.2444987775,
												 pk_yr_add3_date_first_seen2 = 3  => 0.2263610315,
												 pk_yr_add3_date_first_seen2 = 4  => 0.2225650066,
												 pk_yr_add3_date_first_seen2 = 5  => 0.2371449119,
												 pk_yr_add3_date_first_seen2 = 6  => 0.2236408567,
												 pk_yr_add3_date_first_seen2 = 7  => 0.2025506377,
												 pk_yr_add3_date_first_seen2 = 8  => 0.2077067669,
																					 0.1466030989);

		pk_watercraft_count_mm_b3 := map(pk_watercraft_count = 0 => 0.2809859285,
										 pk_watercraft_count = 1 => 0.0984455959,
																	0.1041666667);

		pk_bk_level_mm_b3 := if(pk_bk_level_2 = 0, 0.2801811421, NULL);

		pk_eviction_level_mm_b3 := if(pk_eviction_level = 0, 0.2801811421, NULL);

		pk_lien_type_level_mm_b3 := if(pk_lien_type_level = 0, 0.2801811421, NULL);

		pk_yr_liens_last_unrel_date3_mm_b3 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.2801811421, NULL);

		pk_yr_ln_unrel_lt_f_sn2_mm_b3 := if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.2801811421, NULL);

		pk_yr_ln_unrel_ot_f_sn2_mm_b3 := if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.2801811421, NULL);

		pk_crime_level_mm_b3 := map(pk_crime_level = 0 => 0.2804282529,
														  0.0363636364);

		pk_attr_total_number_derogs_mm_b3 := if(pk_attr_total_number_derogs_5 = 0, 0.2801811421, NULL);

		pk_yr_rc_ssnhighissue2_mm_b3 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.293976167,
											pk_yr_rc_ssnhighissue2 = 0  => 0.112195122,
											pk_yr_rc_ssnhighissue2 = 1  => 0.1789554531,
											pk_yr_rc_ssnhighissue2 = 2  => 0.2039420756,
											pk_yr_rc_ssnhighissue2 = 3  => 0.2732793522,
											pk_yr_rc_ssnhighissue2 = 4  => 0.3109462711,
											pk_yr_rc_ssnhighissue2 = 5  => 0.288104431,
											pk_yr_rc_ssnhighissue2 = 6  => 0.2896505376,
											pk_yr_rc_ssnhighissue2 = 7  => 0.2937728938,
											pk_yr_rc_ssnhighissue2 = 8  => 0.2870292887,
											pk_yr_rc_ssnhighissue2 = 9  => 0.2996655518,
											pk_yr_rc_ssnhighissue2 = 10 => 0.3046820405,
											pk_yr_rc_ssnhighissue2 = 11 => 0.2316034082,
											pk_yr_rc_ssnhighissue2 = 12 => 0.1935483871,
											pk_yr_rc_ssnhighissue2 = 13 => 0.1578947368,
																		   0.1525753158);

		pk_prof_lic_cat_mm_b3 := map(pk_prof_lic_cat = -1 => 0.2840508917,
									 pk_prof_lic_cat = 0  => 0.2032400589,
									 pk_prof_lic_cat = 1  => 0.132183908,
									 pk_prof_lic_cat = 2  => 0.0712166172,
															 0.0642857143);

		pk_add1_lres_mm_b3 := map(pk_add1_lres = -1 => 0.3015290358,
								  pk_add1_lres = 0  => 0.2468531469,
								  pk_add1_lres = 1  => 0.2560113154,
								  pk_add1_lres = 2  => 0.2517006803,
								  pk_add1_lres = 3  => 0.2728813559,
								  pk_add1_lres = 4  => 0.2499260574,
								  pk_add1_lres = 5  => 0.223880597,
								  pk_add1_lres = 6  => 0.2631949331,
								  pk_add1_lres = 7  => 0.2003762935,
								  pk_add1_lres = 8  => 0.1979356406,
								  pk_add1_lres = 9  => 0.1903485255,
								  pk_add1_lres = 10 => 0.1637279597,
													   0.1162790698);

		pk_add2_lres_mm_b3 := map(pk_add2_lres = -2 => 0.3383133585,
								  pk_add2_lres = -1 => 0.2317505315,
								  pk_add2_lres = 0  => 0.248279513,
								  pk_add2_lres = 1  => 0.2660404394,
								  pk_add2_lres = 2  => 0.2479892761,
								  pk_add2_lres = 3  => 0.2446280992,
								  pk_add2_lres = 4  => 0.2563094068,
								  pk_add2_lres = 5  => 0.2468513854,
								  pk_add2_lres = 6  => 0.2528776978,
								  pk_add2_lres = 7  => 0.2622263624,
								  pk_add2_lres = 8  => 0.2285287528,
								  pk_add2_lres = 9  => 0.203898051,
													   0.0967741935);

		pk_add3_lres_mm_b3 := map(pk_add3_lres = -2 => 0.3245800425,
								  pk_add3_lres = -1 => 0.2793339863,
								  pk_add3_lres = 0  => 0.2388920535,
								  pk_add3_lres = 1  => 0.2218292067,
								  pk_add3_lres = 2  => 0.2563589597,
								  pk_add3_lres = 3  => 0.2156682028,
								  pk_add3_lres = 4  => 0.218373494,
								  pk_add3_lres = 5  => 0.2036775106,
													   0.141955836);

		pk_addrs_5yr_mm_b3 := map(pk_addrs_5yr = 0 => 0.3149678604,
								  pk_addrs_5yr = 1 => 0.2709620884,
								  pk_addrs_5yr = 2 => 0.2448018027,
								  pk_addrs_5yr = 3 => 0.2365067466,
													  0.2471169687);

		pk_addrs_15yr_mm_b3 := map(pk_addrs_15yr = 0 => 0.3364323068,
								   pk_addrs_15yr = 1 => 0.2593367763,
								   pk_addrs_15yr = 2 => 0.2252396166,
														0.2727272727);

		pk_add_lres_month_avg2_mm_b3 := map(pk_add_lres_month_avg2 = -1 => 0.3499378963,
											pk_add_lres_month_avg2 = 0  => 0.323943662,
											pk_add_lres_month_avg2 = 1  => 0.2896242846,
											pk_add_lres_month_avg2 = 2  => 0.2893617021,
											pk_add_lres_month_avg2 = 3  => 0.272883206,
											pk_add_lres_month_avg2 = 4  => 0.2554076539,
											pk_add_lres_month_avg2 = 5  => 0.2455919395,
											pk_add_lres_month_avg2 = 6  => 0.2400756144,
											pk_add_lres_month_avg2 = 7  => 0.2502429543,
											pk_add_lres_month_avg2 = 8  => 0.2371077763,
											pk_add_lres_month_avg2 = 9  => 0.2427015251,
											pk_add_lres_month_avg2 = 10 => 0.2365189536,
											pk_add_lres_month_avg2 = 11 => 0.2569269521,
											pk_add_lres_month_avg2 = 12 => 0.2237762238,
											pk_add_lres_month_avg2 = 13 => 0.1885245902,
											pk_add_lres_month_avg2 = 15 => 0.1865357644,
																		   0.1690909091);

		pk_nameperssn_count_mm_b3 := map(pk_nameperssn_count = 0 => 0.2763385147,
										 pk_nameperssn_count = 1 => 0.3375038145,
																	0.3655913978);

		pk_ssns_per_adl_mm_b3 := map(pk_ssns_per_adl = -1 => 0.3433110148,
									 pk_ssns_per_adl = 0  => 0.2447008654,
									 pk_ssns_per_adl = 1  => 0.2870612886,
									 pk_ssns_per_adl = 2  => 0.3489813995,
									 pk_ssns_per_adl = 3  => 0.4262295082,
															 0.4583333333);

		pk_addrs_per_adl_mm_b3 := map(pk_addrs_per_adl = -6 => 0.3490762706,
									  pk_addrs_per_adl = -5 => 0.2971646674,
									  pk_addrs_per_adl = -4 => 0.2859851477,
									  pk_addrs_per_adl = -3 => 0.2631676558,
									  pk_addrs_per_adl = -2 => 0.2577816747,
									  pk_addrs_per_adl = -1 => 0.2439156301,
									  pk_addrs_per_adl = 0  => 0.2228637413,
									  pk_addrs_per_adl = 1  => 0.2026009582,
									  pk_addrs_per_adl = 2  => 0.210619469,
															   0.2451456311);

		pk_phones_per_adl_mm_b3 := map(pk_phones_per_adl = -1 => 0.2918064846,
									   pk_phones_per_adl = 0  => 0.217960005,
									   pk_phones_per_adl = 1  => 0.2524834437,
																 0.3109756098);

		pk_adlperssn_count_mm_b3 := map(pk_adlperssn_count = -1 => 0.2975695849,
										pk_adlperssn_count = 0  => 0.2435224753,
										pk_adlperssn_count = 1  => 0.2939900867,
																   0.3331805683);

		pk_addrs_per_ssn_mm_b3 := map(pk_addrs_per_ssn = -4 => 0.2976687926,
									  pk_addrs_per_ssn = -3 => 0.2925470333,
									  pk_addrs_per_ssn = -2 => 0.2375430332,
									  pk_addrs_per_ssn = -1 => 0.2346938776,
									  pk_addrs_per_ssn = 0  => 0.2337139019,
									  pk_addrs_per_ssn = 1  => 0.2281904762,
									  pk_addrs_per_ssn = 2  => 0.2128240109,
															   0.1614906832);

		pk_adls_per_addr_mm_b3 := map(pk_adls_per_addr = -102 => 0.2614618092,
									  pk_adls_per_addr = -101 => 0.2582582583,
									  pk_adls_per_addr = -2   => 0.3482587065,
									  pk_adls_per_addr = -1   => 0.1916859122,
									  pk_adls_per_addr = 0    => 0.1365795724,
									  pk_adls_per_addr = 1    => 0.1894736842,
									  pk_adls_per_addr = 2    => 0.2066601371,
									  pk_adls_per_addr = 3    => 0.2294455067,
									  pk_adls_per_addr = 4    => 0.2581244197,
									  pk_adls_per_addr = 5    => 0.2681858019,
									  pk_adls_per_addr = 6    => 0.2776785714,
									  pk_adls_per_addr = 7    => 0.2847926267,
									  pk_adls_per_addr = 8    => 0.2843951985,
									  pk_adls_per_addr = 9    => 0.2996941896,
									  pk_adls_per_addr = 10   => 0.3210958904,
									  pk_adls_per_addr = 11   => 0.3168056165,
									  pk_adls_per_addr = 12   => 0.3318934485,
									  pk_adls_per_addr = 13   => 0.3406561219,
									  pk_adls_per_addr = 100  => 0.2570977918,
									  pk_adls_per_addr = 101  => 0.2424242424,
																 0.3128667681);

		pk_phones_per_addr_mm_b3 := map(pk_phones_per_addr = -1  => 0.2575595873,
										pk_phones_per_addr = 0   => 0.2913283916,
										pk_phones_per_addr = 1   => 0.3189344852,
										pk_phones_per_addr = 2   => 0.3568945539,
										pk_phones_per_addr = 3   => 0.3807169345,
										pk_phones_per_addr = 100 => 0.2934749621,
										pk_phones_per_addr = 101 => 0.2937634409,
										pk_phones_per_addr = 102 => 0.289493865,
																	0.2697070249);

		pk_adls_per_phone_mm_b3 := map(pk_adls_per_phone = -2 => 0.2798084559,
									   pk_adls_per_phone = -1 => 0.2783009802,
									   pk_adls_per_phone = 0  => 0.2923299566,
																 0.3146853147);

		pk_ssns_per_adl_c6_mm_b3 := map(pk_ssns_per_adl_c6 = 0 => 0.2843729872,
										pk_ssns_per_adl_c6 = 1 => 0.264227343,
																  0.4075067024);

		pk_addrs_per_adl_c6_mm_b3 := map(pk_addrs_per_adl_c6 = 0 => 0.2819762755,
										 pk_addrs_per_adl_c6 = 1 => 0.269441167,
										 pk_addrs_per_adl_c6 = 2 => 0.290459364,
																	0.325443787);

		pk_phones_per_adl_c6_mm_b3 := map(pk_phones_per_adl_c6 = -2 => 0.2804990125,
										  pk_phones_per_adl_c6 = -1 => 0.272819131,
										  pk_phones_per_adl_c6 = 0  => 0.2964824121,
																	   0.4615384615);

		pk_ssns_per_addr_c6_mm_b3 := map(pk_ssns_per_addr_c6 = 0   => 0.2930370696,
										 pk_ssns_per_addr_c6 = 1   => 0.3089502374,
										 pk_ssns_per_addr_c6 = 2   => 0.2341279799,
										 pk_ssns_per_addr_c6 = 3   => 0.2747540984,
										 pk_ssns_per_addr_c6 = 4   => 0.3113207547,
										 pk_ssns_per_addr_c6 = 5   => 0.3386454183,
										 pk_ssns_per_addr_c6 = 6   => 0.4541062802,
										 pk_ssns_per_addr_c6 = 100 => 0.272972302,
										 pk_ssns_per_addr_c6 = 101 => 0.298440208,
										 pk_ssns_per_addr_c6 = 102 => 0.2590460526,
										 pk_ssns_per_addr_c6 = 103 => 0.2982885086,
																	  0.321888412);

		pk_phones_per_addr_c6_mm_b3 := map(pk_phones_per_addr_c6 = -1  => 0.2715151515,
										   pk_phones_per_addr_c6 = 0   => 0.3638724036,
										   pk_phones_per_addr_c6 = 1   => 0.448019802,
										   pk_phones_per_addr_c6 = 2   => 0.4545454545,
										   pk_phones_per_addr_c6 = 100 => 0.2642186043,
										   pk_phones_per_addr_c6 = 101 => 0.2758114374,
																		  0.2999834902);

		pk_adls_per_phone_c6_mm_b3 := map(pk_adls_per_phone_c6 = 0 => 0.2768121083,
										  pk_adls_per_phone_c6 = 1 => 0.3332318929,
																	  0.268707483);

		pk_attr_addrs_last24_mm_b3 := map(pk_attr_addrs_last24 = 0 => 0.2914578186,
										  pk_attr_addrs_last24 = 1 => 0.2678135917,
										  pk_attr_addrs_last24 = 2 => 0.2660242983,
										  pk_attr_addrs_last24 = 3 => 0.2586858006,
										  pk_attr_addrs_last24 = 4 => 0.3044397463,
																	  0.3333333333);

		pk_attr_addrs_last36_mm_b3 := map(pk_attr_addrs_last36 = 0 => 0.302888102,
										  pk_attr_addrs_last36 = 1 => 0.2672779051,
										  pk_attr_addrs_last36 = 2 => 0.2674094708,
										  pk_attr_addrs_last36 = 3 => 0.2407407407,
										  pk_attr_addrs_last36 = 4 => 0.2581466395,
										  pk_attr_addrs_last36 = 5 => 0.2548746518,
																	  0.2985507246);

		pk_ams_class_level_mm_b3 := map(pk_ams_class_level = -1000001 => 0.2890332198,
										pk_ams_class_level = 0        => 0.3747841105,
										pk_ams_class_level = 1        => 0.3579175705,
										pk_ams_class_level = 2        => 0.3278688525,
										pk_ams_class_level = 3        => 0.272,
										pk_ams_class_level = 4        => 0.2332089552,
										pk_ams_class_level = 5        => 0.2018572825,
										pk_ams_class_level = 6        => 0.1956521739,
										pk_ams_class_level = 7        => 0.2031558185,
										pk_ams_class_level = 8        => 0.1875,
										pk_ams_class_level = 1000000  => 0.1609756098,
										pk_ams_class_level = 1000001  => 0.1463414634,
										pk_ams_class_level = 1000002  => 0.1057692308,
										pk_ams_class_level = 1000003  => 0.0707070707,
										pk_ams_class_level = 1000004  => 0.0497737557,
																		 0.0714285714);

		pk_ams_income_level_code_mm_b3 := map(pk_ams_income_level_code = -1 => 0.2890147563,
											  pk_ams_income_level_code = 0  => 0.4232081911,
											  pk_ams_income_level_code = 1  => 0.3289786223,
											  pk_ams_income_level_code = 2  => 0.2607020548,
											  pk_ams_income_level_code = 3  => 0.1921024546,
											  pk_ams_income_level_code = 4  => 0.1873571973,
											  pk_ams_income_level_code = 5  => 0.1516709512,
																			   0.1081395349);

		pk_college_tier_mm_b3 := map((integer)pk_college_tier = -1 => 0.2876938431,
									 (integer)pk_college_tier = 1  => 0,
									 (integer)pk_college_tier = 2  => 0.0769230769,
									 (integer)pk_college_tier = 3  => 0.0596330275,
									 (integer)pk_college_tier = 4  => 0.1178082192,
									 (integer)pk_college_tier = 5  => 0.1412103746,
																	  0.1959798995);

		pk_ams_age_mm_b3 := map(pk_ams_age = -1 => 0.2841620703,
								pk_ams_age = 21 => 0.3555811277,
								pk_ams_age = 22 => 0.3490759754,
								pk_ams_age = 23 => 0.2972508591,
								pk_ams_age = 24 => 0.250965251,
								pk_ams_age = 25 => 0.2222222222,
								pk_ams_age = 29 => 0.2097470697,
												   0.1859229748);

		pk_inferred_age_mm_b3 := map(pk_inferred_age = -1 => 0.3261623165,
									 pk_inferred_age = 18 => 0.3905498282,
									 pk_inferred_age = 19 => 0.3135994587,
									 pk_inferred_age = 20 => 0.3014575187,
									 pk_inferred_age = 21 => 0.2803837953,
									 pk_inferred_age = 22 => 0.2683461117,
									 pk_inferred_age = 24 => 0.2482704092,
									 pk_inferred_age = 34 => 0.2502791217,
									 pk_inferred_age = 37 => 0.2752344181,
									 pk_inferred_age = 41 => 0.2382956339,
									 pk_inferred_age = 42 => 0.2364066194,
									 pk_inferred_age = 43 => 0.2216981132,
									 pk_inferred_age = 44 => 0.2364864865,
									 pk_inferred_age = 46 => 0.2324246772,
									 pk_inferred_age = 48 => 0.234859675,
									 pk_inferred_age = 52 => 0.2187761945,
									 pk_inferred_age = 56 => 0.1980582524,
									 pk_inferred_age = 61 => 0.1797631862,
															 0.1470009833);

		pk_yr_reported_dob2_mm_b3 := map(pk_yr_reported_dob2 = -1 => 0.316284841,
										 pk_yr_reported_dob2 = 19 => 0.4022988506,
										 pk_yr_reported_dob2 = 21 => 0.3038585209,
										 pk_yr_reported_dob2 = 22 => 0.2556237219,
										 pk_yr_reported_dob2 = 23 => 0.2568306011,
										 pk_yr_reported_dob2 = 32 => 0.2253521127,
										 pk_yr_reported_dob2 = 35 => 0.2454545455,
										 pk_yr_reported_dob2 = 39 => 0.2488932612,
										 pk_yr_reported_dob2 = 42 => 0.2313982011,
										 pk_yr_reported_dob2 = 43 => 0.2288557214,
										 pk_yr_reported_dob2 = 44 => 0.2191435768,
										 pk_yr_reported_dob2 = 45 => 0.2452830189,
										 pk_yr_reported_dob2 = 46 => 0.2444444444,
										 pk_yr_reported_dob2 = 49 => 0.2268656716,
										 pk_yr_reported_dob2 = 57 => 0.207639569,
										 pk_yr_reported_dob2 = 61 => 0.1766200762,
																	 0.1446540881);

		pk_avm_hit_level_mm_b3 := map(pk_avm_hit_level = -1 => 0.2436368086,
									  pk_avm_hit_level = 0  => 0.289562174,
									  pk_avm_hit_level = 1  => 0.2996982903,
															   0.2392589673);

		pk_avm_auto_diff4_lvl_mm_b3 := map(pk_avm_auto_diff4_lvl = -1 => 0.2809062649,
										   pk_avm_auto_diff4_lvl = 0  => 0.2698127725,
																		 0.2970711297);

		pk_add2_avm_auto_diff3_lvl_mm_b3 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.2905862126,
												pk_add2_avm_auto_diff3_lvl = -1 => 0.2352224254,
																				   0.2458920872);

		pk2_add1_avm_as_mm_b3 := map(pk2_add1_avm_as = 0 => 0.2829446916,
									 pk2_add1_avm_as = 1 => 0.3173161442,
									 pk2_add1_avm_as = 2 => 0.2455327598,
															0.1652421652);

		pk2_add1_avm_mkt_mm_b3 := map(pk2_add1_avm_mkt = 0 => 0.4143646409,
									  pk2_add1_avm_mkt = 1 => 0.2794098503,
									  pk2_add1_avm_mkt = 2 => 0.3118971061,
									  pk2_add1_avm_mkt = 3 => 0.2520813166,
															  0.1224489796);

		pk2_add1_avm_hed_mm_b3 := map(pk2_add1_avm_hed = 0 => 0.5242424242,
									  pk2_add1_avm_hed = 1 => 0.4151376147,
									  pk2_add1_avm_hed = 2 => 0.3731117825,
									  pk2_add1_avm_hed = 3 => 0.279642999,
									  pk2_add1_avm_hed = 4 => 0.2952243126,
									  pk2_add1_avm_hed = 5 => 0.2675977654,
															  0.1128318584);

		pk2_add1_avm_auto_mm_b3 := map(pk2_add1_avm_auto = 0 => 0.4620253165,
									   pk2_add1_avm_auto = 1 => 0.4705882353,
									   pk2_add1_avm_auto = 2 => 0.4027777778,
									   pk2_add1_avm_auto = 3 => 0.3823178017,
									   pk2_add1_avm_auto = 4 => 0.2812180143,
									   pk2_add1_avm_auto = 5 => 0.2613507836,
																0.1707317073);

		pk2_add1_avm_auto2_mm_b3 := map(pk2_add1_avm_auto2 = 0 => 0.5235294118,
										pk2_add1_avm_auto2 = 1 => 0.4601769912,
										pk2_add1_avm_auto2 = 2 => 0.3863636364,
										pk2_add1_avm_auto2 = 3 => 0.4013157895,
										pk2_add1_avm_auto2 = 4 => 0.2791164142,
										pk2_add1_avm_auto2 = 5 => 0.3313212609,
										pk2_add1_avm_auto2 = 6 => 0.2592295345,
																  0.1707650273);

		pk2_add1_avm_auto3_mm_b3 := map(pk2_add1_avm_auto3 = 0 => 0.4900662252,
										pk2_add1_avm_auto3 = 1 => 0.4546341463,
										pk2_add1_avm_auto3 = 2 => 0.3465608466,
										pk2_add1_avm_auto3 = 3 => 0.2802452085,
										pk2_add1_avm_auto3 = 4 => 0.3213429257,
										pk2_add1_avm_auto3 = 5 => 0.2993421053,
										pk2_add1_avm_auto3 = 6 => 0.2513599275,
																  0.1693989071);

		pk2_add1_avm_auto4_mm_b3 := map(pk2_add1_avm_auto4 = 0 => 0.5301204819,
										pk2_add1_avm_auto4 = 1 => 0.3653846154,
										pk2_add1_avm_auto4 = 2 => 0.2890625,
										pk2_add1_avm_auto4 = 3 => 0.281431564,
										pk2_add1_avm_auto4 = 4 => 0.290842872,
										pk2_add1_avm_auto4 = 5 => 0.2128982129,
																  0.137755102);

		pk2_add1_avm_med_mm_b3 := map(pk2_add1_avm_med = 0 => 0.5714285714,
									  pk2_add1_avm_med = 1 => 0.4714003945,
									  pk2_add1_avm_med = 2 => 0.4330244313,
									  pk2_add1_avm_med = 3 => 0.3871851041,
									  pk2_add1_avm_med = 4 => 0.3349596945,
									  pk2_add1_avm_med = 5 => 0.2666503906,
									  pk2_add1_avm_med = 6 => 0.1808035714,
															  0.2528929605);

		pk2_add1_avm_to_med_ratio_mm_b3 := map(pk2_add1_avm_to_med_ratio = 0 => 0.2790393647,
											   pk2_add1_avm_to_med_ratio = 1 => 0.2866250498,
											   pk2_add1_avm_to_med_ratio = 2 => 0.2697576396,
											   pk2_add1_avm_to_med_ratio = 3 => 0.2892112421,
											   pk2_add1_avm_to_med_ratio = 4 => 0.2488755622,
																				0.3072625698);

		pk2_add2_avm_sp_mm_b3 := map(pk2_add2_avm_sp = 0 => 0.3381088825,
									 pk2_add2_avm_sp = 1 => 0.315,
									 pk2_add2_avm_sp = 2 => 0.2758169935,
									 pk2_add2_avm_sp = 3 => 0.2892834101,
									 pk2_add2_avm_sp = 4 => 0.2423119674,
															0.2106854839);

		pk2_add2_avm_mkt_mm_b3 := map(pk2_add2_avm_mkt = 0 => 0.3994708995,
									  pk2_add2_avm_mkt = 1 => 0.3306451613,
									  pk2_add2_avm_mkt = 2 => 0.2855433123,
									  pk2_add2_avm_mkt = 3 => 0.2222683839,
															  0.1283783784);

		pk2_add2_avm_hed_mm_b3 := map(pk2_add2_avm_hed = 0 => 0.5833333333,
									  pk2_add2_avm_hed = 1 => 0.3928571429,
									  pk2_add2_avm_hed = 2 => 0.3319838057,
									  pk2_add2_avm_hed = 3 => 0.2881405042,
									  pk2_add2_avm_hed = 4 => 0.2902921772,
									  pk2_add2_avm_hed = 5 => 0.2254140407,
															  0.1342512909);

		pk2_add2_avm_auto_mm_b3 := map(pk2_add2_avm_auto = 0 => 0.4212765957,
									   pk2_add2_avm_auto = 1 => 0.2931382442,
									   pk2_add2_avm_auto = 2 => 0.2363191109,
																0.1545718433);

		pk2_add2_avm_auto3_mm_b3 := map(pk2_add2_avm_auto3 = 0 => 0.4075144509,
										pk2_add2_avm_auto3 = 1 => 0.380952381,
										pk2_add2_avm_auto3 = 2 => 0.2915528207,
										pk2_add2_avm_auto3 = 3 => 0.2265722616,
																  0.1383219955);

		pk2_add2_avm_auto4_mm_b3 := map(pk2_add2_avm_auto4 = 0 => 0.3846153846,
										pk2_add2_avm_auto4 = 1 => 0.3684210526,
										pk2_add2_avm_auto4 = 2 => 0.3238095238,
										pk2_add2_avm_auto4 = 3 => 0.2836534598,
										pk2_add2_avm_auto4 = 4 => 0.2400506971,
																  0.1894150418);

		pk2_yr_add1_avm_rec_dt_mm_b3 := map(pk2_yr_add1_avm_recording_date = 0 => 0.3073473612,
											pk2_yr_add1_avm_recording_date = 1 => 0.2880288029,
											pk2_yr_add1_avm_recording_date = 2 => 0.2790924502,
											pk2_yr_add1_avm_recording_date = 3 => 0.2679436372,
																				  0.2841051314);

		pk2_yr_add1_avm_assess_year_mm_b3 := map(pk2_yr_add1_avm_assess_year = 0 => 0.2795724984,
												 pk2_yr_add1_avm_assess_year = 1 => 0.2754172989,
																					0.2828549527);

		pk_dist_a1toa2_mm_b3 := map(pk_dist_a1toa2_2 = 0 => 0.2575887919,
									pk_dist_a1toa2_2 = 1 => 0.2314803625,
									pk_dist_a1toa2_2 = 2 => 0.2756677285,
									pk_dist_a1toa2_2 = 3 => 0.2689655172,
															0.3382924028);

		pk_dist_a1toa3_mm_b3 := map(pk_dist_a1toa3_2 = 0 => 0.2712851406,
									pk_dist_a1toa3_2 = 1 => 0.2073802127,
									pk_dist_a1toa3_2 = 2 => 0.2533009034,
									pk_dist_a1toa3_2 = 3 => 0.2769563649,
									pk_dist_a1toa3_2 = 4 => 0.2783632982,
									pk_dist_a1toa3_2 = 5 => 0.2245467225,
															0.3242734769);

		pk_rc_disthphoneaddr_mm_b3 := map(pk_rc_disthphoneaddr_2 = 0 => 0.2526274304,
										  pk_rc_disthphoneaddr_2 = 1 => 0.3089706109,
										  pk_rc_disthphoneaddr_2 = 2 => 0.308056872,
										  pk_rc_disthphoneaddr_2 = 3 => 0.2911534155,
																		0.2797480595);

		pk_out_st_division_lvl_mm_b3 := map(pk_out_st_division_lvl = -1 => 0.4842105263,
											pk_out_st_division_lvl = 0  => 0.2312186978,
											pk_out_st_division_lvl = 1  => 0.2735339506,
											pk_out_st_division_lvl = 2  => 0.2937778945,
											pk_out_st_division_lvl = 3  => 0.4403341289,
											pk_out_st_division_lvl = 4  => 0.2737444818,
											pk_out_st_division_lvl = 5  => 0.2896752046,
											pk_out_st_division_lvl = 6  => 0.2531530163,
											pk_out_st_division_lvl = 7  => 0.311544544,
																		   0.2737127371);

		pk_wealth_index_mm_b3 := map(pk_wealth_index_2 = 0 => 0.2839752427,
									 pk_wealth_index_2 = 1 => 0.3201834862,
									 pk_wealth_index_2 = 2 => 0.2860235747,
									 pk_wealth_index_2 = 3 => 0.2626543553,
															  0.1363636364);

		pk_impulse_count_mm_b3 := if(pk_impulse_count_2 = 0, 0.2801811421, NULL);

		pk_attr_num_nonderogs90_b_mm_b3 := map(pk_attr_num_nonderogs90_b = 0  => 0.3497271149,
											   pk_attr_num_nonderogs90_b = 1  => 0.2839735996,
											   pk_attr_num_nonderogs90_b = 2  => 0.2314370151,
											   pk_attr_num_nonderogs90_b = 3  => 0.1483790524,
											   pk_attr_num_nonderogs90_b = 4  => 0.0754716981,
											   pk_attr_num_nonderogs90_b = 10 => 0.2738693467,
											   pk_attr_num_nonderogs90_b = 11 => 0.2415277031,
											   pk_attr_num_nonderogs90_b = 12 => 0.1920083031,
											   pk_attr_num_nonderogs90_b = 13 => 0.1305147059,
																				 0.0344827586);

		pk_ssns_per_addr2_mm_b3 := map(pk_ssns_per_addr2 = -101 => 0.2620098789,
									   pk_ssns_per_addr2 = -2   => 0.2727272727,
									   pk_ssns_per_addr2 = -1   => 0.1701492537,
									   pk_ssns_per_addr2 = 0    => 0.1169811321,
									   pk_ssns_per_addr2 = 1    => 0.1541450777,
									   pk_ssns_per_addr2 = 2    => 0.2103407756,
									   pk_ssns_per_addr2 = 3    => 0.212458287,
									   pk_ssns_per_addr2 = 4    => 0.235908142,
									   pk_ssns_per_addr2 = 5    => 0.2900688299,
									   pk_ssns_per_addr2 = 6    => 0.2760267431,
									   pk_ssns_per_addr2 = 7    => 0.2696517413,
									   pk_ssns_per_addr2 = 8    => 0.2793263647,
									   pk_ssns_per_addr2 = 9    => 0.3027232426,
									   pk_ssns_per_addr2 = 10   => 0.3294117647,
									   pk_ssns_per_addr2 = 11   => 0.332919871,
									   pk_ssns_per_addr2 = 12   => 0.3435762365,
									   pk_ssns_per_addr2 = 100  => 0.2398589065,
									   pk_ssns_per_addr2 = 101  => 0.2448275862,
									   pk_ssns_per_addr2 = 102  => 0.3042215006,
																   0.332137031);

		pk_yr_add2_assess_val_yr2_mm_b3 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.2942077922,
											   pk_yr_add2_assessed_value_year2 = 0  => 0.04,
											   pk_yr_add2_assessed_value_year2 = 1  => 0.2466782736,
																					   0.2457002457);

		pk_estimated_income_mm_b4 := map(pk_estimated_income = -1 => 0.3556573173,
										 pk_estimated_income = 0  => 0.3818181818,
										 pk_estimated_income = 1  => 0.3333333333,
										 pk_estimated_income = 2  => 0.2231884058,
										 pk_estimated_income = 3  => 0.3303269448,
										 pk_estimated_income = 4  => 0.3042168675,
										 pk_estimated_income = 5  => 0.3338884263,
										 pk_estimated_income = 6  => 0.2912761355,
										 pk_estimated_income = 7  => 0.2863013699,
										 pk_estimated_income = 8  => 0.283197832,
										 pk_estimated_income = 9  => 0.2523297491,
										 pk_estimated_income = 10 => 0.2274959083,
										 pk_estimated_income = 11 => 0.2076923077,
										 pk_estimated_income = 12 => 0.2021709634,
										 pk_estimated_income = 13 => 0.1787610619,
										 pk_estimated_income = 14 => 0.157079646,
										 pk_estimated_income = 15 => 0.1813031161,
										 pk_estimated_income = 16 => 0.1282894737,
										 pk_estimated_income = 17 => 0.1467181467,
										 pk_estimated_income = 18 => 0.1782945736,
										 pk_estimated_income = 19 => 0.1230366492,
										 pk_estimated_income = 20 => 0.1116928447,
										 pk_estimated_income = 21 => 0.1176470588,
																	 0);

		pk_yr_adl_w_last_seen2_mm_b4 := map(pk_yr_adl_w_last_seen2 = -1 => 0.2655150076,
											pk_yr_adl_w_last_seen2 = 0  => 0.0839694656,
											pk_yr_adl_w_last_seen2 = 1  => 0.1066666667,
																		   0.0900900901);

		pk_pr_count_mm_b4 := map(pk_pr_count = -1 => 0.2831498325,
								 pk_pr_count = 0  => 0.1187384045,
								 pk_pr_count = 1  => 0.0905861456,
													 0.027027027);

		pk_addrs_sourced_lvl_mm_b4 := map(pk_addrs_sourced_lvl = 0 => 0.2769918437,
										  pk_addrs_sourced_lvl = 1 => 0.1049761418,
										  pk_addrs_sourced_lvl = 2 => 0.0565371025,
																	  0.0658436214);

		pk_add1_own_level_mm_b4 := map(pk_add1_own_level = -1 => 0.206865402,
									   pk_add1_own_level = 0  => 0.2899367052,
											pk_add1_own_level = 1  =>	0.18169959,
										(6197 / 23694));  // made the segment_mean be the else case

		pk_add2_own_level_mm_b4 := map(pk_add2_own_level = 0 => 0.2721585944,
									   pk_add2_own_level = 1 => 0.1534482759,
									   pk_add2_own_level = 2 => 0.1095890411,
																0.0357142857);

		pk_add3_own_level_mm_b4 := map(pk_add3_own_level = 0 => 0.2673465752,
									   pk_add3_own_level = 1 => 0.1707556428,
									   pk_add3_own_level = 2 => 0.1285714286,
																0.0728476821);

		pk_naprop_level2_mm_b4 := map(pk_naprop_level2 = -1 => 0.3024971623,
									  pk_naprop_level2 = 0  => 0.2599206349,
									  pk_naprop_level2 = 2  => 0.2912778905,
									  pk_naprop_level2 = 3  => 0.1948338006,
									  pk_naprop_level2 = 4  => 0.1216216216,
															   0.0894160584);

		pk_yr_add1_built_date2_mm_b4 := map(pk_yr_add1_built_date2 = -4 => 0.281260292,
											pk_yr_add1_built_date2 = -3 => 0,
											pk_yr_add1_built_date2 = -2 => 0.1458333333,
											pk_yr_add1_built_date2 = -1 => 0.1680327869,
											pk_yr_add1_built_date2 = 0  => 0.1641566265,
											pk_yr_add1_built_date2 = 1  => 0.1650879567,
											pk_yr_add1_built_date2 = 2  => 0.1798753339,
																		   0.2502708559);

		pk_add1_purchase_amount2_mm_b4 := map(pk_add1_purchase_amount2 = -1 => 0.2781857002,
											  pk_add1_purchase_amount2 = 0  => 0.2118301314,
																			   0.1734978114);

		pk_yr_add1_mortgage_date2_mm_b4 := map(pk_yr_add1_mortgage_date2 = -1 => 0.2712468684,
											   pk_yr_add1_mortgage_date2 = 0  => 0.2104557641,
											   pk_yr_add1_mortgage_date2 = 1  => 0.1623931624,
																				 0.1809815951);

		pk_add1_mortgage_risk_mm_b4 := map(pk_add1_mortgage_risk = -1 => 0.2,
										   pk_add1_mortgage_risk = 0  => 0.119379845,
										   pk_add1_mortgage_risk = 1  => 0.2679569495,
										   pk_add1_mortgage_risk = 2  => 0.2363112392,
																		 0.2199710564);

		pk_add1_assessed_amount2_mm_b4 := map(pk_add1_assessed_amount2 = -1 => 0.2762782987,
											  pk_add1_assessed_amount2 = 0  => 0.3763837638,
											  pk_add1_assessed_amount2 = 1  => 0.2926829268,
											  pk_add1_assessed_amount2 = 2  => 0.2352941176,
											  pk_add1_assessed_amount2 = 3  => 0.223880597,
											  pk_add1_assessed_amount2 = 4  => 0.186440678,
											  pk_add1_assessed_amount2 = 5  => 0.2265372168,
																			   0.151556157);

		pk_yr_add1_mortgage_due_date2_mm_b4 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.269915112,
												   pk_yr_add1_mortgage_due_date2 = 0  => 0.1432291667,
												   pk_yr_add1_mortgage_due_date2 = 1  => 0.1844155844,
																						 0.2308282209);

		pk_yr_add1_date_first_seen2_mm_b4 := map(pk_yr_add1_date_first_seen2 = -1 => 0.3032326072,
												 pk_yr_add1_date_first_seen2 = 0  => 0.2493573265,
												 pk_yr_add1_date_first_seen2 = 1  => 0.2557510149,
												 pk_yr_add1_date_first_seen2 = 2  => 0.2025316456,
												 pk_yr_add1_date_first_seen2 = 3  => 0.1713917526,
												 pk_yr_add1_date_first_seen2 = 4  => 0.1624365482,
												 pk_yr_add1_date_first_seen2 = 5  => 0.157654227,
												 pk_yr_add1_date_first_seen2 = 6  => 0.1692015209,
												 pk_yr_add1_date_first_seen2 = 7  => 0.150779896,
												 pk_yr_add1_date_first_seen2 = 8  => 0.1281407035,
												 pk_yr_add1_date_first_seen2 = 9  => 0.1070234114,
																					 0.0454545455);

		pk_add1_land_use_risk_level_mm_b4 := map(pk_add1_land_use_risk_level = 0 => 0.2093023256,
												 pk_add1_land_use_risk_level = 2 => 0.1853887183,
												 pk_add1_land_use_risk_level = 3 => 0.2887080014,
																					0.2816901408);

		pk_add1_building_area2_mm_b4 := map(pk_add1_building_area2 = -99 => 0.2810299296,
											pk_add1_building_area2 = -4  => 0.2942857143,
											pk_add1_building_area2 = -3  => 0.2384937238,
											pk_add1_building_area2 = -2  => 0.2068584071,
											pk_add1_building_area2 = -1  => 0.1332007952,
											pk_add1_building_area2 = 0   => 0.1365461847,
											pk_add1_building_area2 = 1   => 0.1785714286,
											pk_add1_building_area2 = 2   => 0.25,
											pk_add1_building_area2 = 3   => 0.2142857143,
																			0.375);

		pk_property_owned_total_mm_b4 := if(pk_property_owned_total = -1, 0.2615430067, NULL);

		pk_prop_own_assess_tot2_mm_b4 := if(pk_prop_own_assess_tot2 = 0, 0.2615430067, NULL);

		pk_prop1_sale_price2_mm_b4 := map(pk_prop1_sale_price2 = 0 => 0.264233389,
										  pk_prop1_sale_price2 = 1 => 0.1764705882,
																	  0.0778443114);

		pk_yr_prop2_sale_date2_mm_b4 := map(pk_yr_prop2_sale_date2 = 0 => 0.2625641461,
											pk_yr_prop2_sale_date2 = 1 => 0.0606060606,
											pk_yr_prop2_sale_date2 = 2 => 0.0566037736,
																		  0.0344827586);

		pk_add2_no_of_buildings_mm_b4 := map(pk_add2_no_of_buildings = -1 => 0.2642293704,
											 pk_add2_no_of_buildings = 0  => 0.2378957169,
											 pk_add2_no_of_buildings = 1  => 0.2382352941,
																			 0.3142857143);

		pk_add2_parking_no_of_cars_mm_b4 := map(pk_add2_parking_no_of_cars = 0 => 0.2669309852,
												pk_add2_parking_no_of_cars = 1 => 0.269170579,
												pk_add2_parking_no_of_cars = 2 => 0.1754068716,
																				  0.1589147287);

		pk_add2_mortgage_risk_mm_b4 := map(pk_add2_mortgage_risk = -1 => 0.4545454545,
										   pk_add2_mortgage_risk = 0  => 0.1555944056,
										   pk_add2_mortgage_risk = 1  => 0.2665055626,
										   pk_add2_mortgage_risk = 2  => 0.2067226891,
																		 0.2311643836);

		pk_add2_assessed_amount2_mm_b4 := map(pk_add2_assessed_amount2 = -1 => 0.2682914394,
											  pk_add2_assessed_amount2 = 0  => 0.3524355301,
											  pk_add2_assessed_amount2 = 1  => 0.3004484305,
											  pk_add2_assessed_amount2 = 2  => 0.1791530945,
											  pk_add2_assessed_amount2 = 3  => 0.1965006729,
																			   0.1530944625);

		pk_yr_add2_date_first_seen2_mm_b4 := map(pk_yr_add2_date_first_seen2 = -1 => 0.3183536329,
												 pk_yr_add2_date_first_seen2 = 0  => 0.2749221184,
												 pk_yr_add2_date_first_seen2 = 1  => 0.2665413534,
												 pk_yr_add2_date_first_seen2 = 2  => 0.2451644101,
												 pk_yr_add2_date_first_seen2 = 3  => 0.2156862745,
												 pk_yr_add2_date_first_seen2 = 4  => 0.2272496187,
												 pk_yr_add2_date_first_seen2 = 5  => 0.2104722793,
												 pk_yr_add2_date_first_seen2 = 6  => 0.2448330684,
												 pk_yr_add2_date_first_seen2 = 7  => 0.1962809917,
												 pk_yr_add2_date_first_seen2 = 8  => 0.2138728324,
												 pk_yr_add2_date_first_seen2 = 9  => 0.1613445378,
												 pk_yr_add2_date_first_seen2 = 10 => 0.155216285,
																					 0.0997067449);

		pk_yr_add2_date_last_seen2_mm_b4 := map(pk_yr_add2_date_last_seen2 = -1 => 0.3183536329,
												pk_yr_add2_date_last_seen2 = 0  => 0.250842244,
												pk_yr_add2_date_last_seen2 = 1  => 0.212987013,
												pk_yr_add2_date_last_seen2 = 2  => 0.1712121212,
												pk_yr_add2_date_last_seen2 = 3  => 0.1395348837,
												pk_yr_add2_date_last_seen2 = 4  => 0.1798941799,
												pk_yr_add2_date_last_seen2 = 5  => 0.1623036649,
																				   0.1394799054);

		pk_add3_mortgage_risk_mm_b4 := map(pk_add3_mortgage_risk = -1 => 0.3333333333,
										   pk_add3_mortgage_risk = 0  => 0.1513002364,
										   pk_add3_mortgage_risk = 1  => 0.1515151515,
										   pk_add3_mortgage_risk = 2  => 0.2661236181,
										   pk_add3_mortgage_risk = 3  => 0.1977777778,
										   pk_add3_mortgage_risk = 4  => 0.1935483871,
																		 0.2551020408);

		pk_add3_assessed_amount2_mm_b4 := map(pk_add3_assessed_amount2 = -1 => 0.2692065339,
											  pk_add3_assessed_amount2 = 0  => 0.3345656192,
											  pk_add3_assessed_amount2 = 1  => 0.2155172414,
											  pk_add3_assessed_amount2 = 2  => 0.1949778434,
																			   0.1735895846);

		pk_yr_add3_date_first_seen2_mm_b4 := map(pk_yr_add3_date_first_seen2 = -1 => 0.3044411908,
												 pk_yr_add3_date_first_seen2 = 0  => 0.2831149927,
												 pk_yr_add3_date_first_seen2 = 1  => 0.286407767,
												 pk_yr_add3_date_first_seen2 = 2  => 0.239683437,
												 pk_yr_add3_date_first_seen2 = 3  => 0.2179591837,
												 pk_yr_add3_date_first_seen2 = 4  => 0.2264150943,
												 pk_yr_add3_date_first_seen2 = 5  => 0.2330097087,
												 pk_yr_add3_date_first_seen2 = 6  => 0.2178017532,
												 pk_yr_add3_date_first_seen2 = 7  => 0.1719512195,
												 pk_yr_add3_date_first_seen2 = 8  => 0.1470198675,
																					 0.1428571429);

		pk_watercraft_count_mm_b4 := map(pk_watercraft_count = 0 => 0.2639309962,
										 pk_watercraft_count = 1 => 0.0643564356,
																	0.0410958904);

		pk_bk_level_mm_b4 := if(pk_bk_level_2 = 0, 0.2615430067, NULL);

		pk_eviction_level_mm_b4 := if(pk_eviction_level = 0, 0.2615430067, NULL);

		pk_lien_type_level_mm_b4 := if(pk_lien_type_level = 0, 0.2615430067, NULL);

		pk_yr_liens_last_unrel_date3_mm_b4 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.2615430067, NULL);

		pk_yr_ln_unrel_lt_f_sn2_mm_b4 := if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.2615430067, NULL);

		pk_yr_ln_unrel_ot_f_sn2_mm_b4 := if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.2615430067, NULL);

		pk_crime_level_mm_b4 := map(pk_crime_level = 0 => 0.2617347585,
														  0.08);

		pk_attr_total_number_derogs_mm_b4 := if(pk_attr_total_number_derogs_5 = 0, 0.2615430067, NULL);

		pk_yr_rc_ssnhighissue2_mm_b4 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.3122102009,
											pk_yr_rc_ssnhighissue2 = 0  => 0.202020202,
											pk_yr_rc_ssnhighissue2 = 1  => 0.2165242165,
											pk_yr_rc_ssnhighissue2 = 2  => 0.2561576355,
											pk_yr_rc_ssnhighissue2 = 3  => 0.2925764192,
											pk_yr_rc_ssnhighissue2 = 4  => 0.2763119745,
											pk_yr_rc_ssnhighissue2 = 5  => 0.2501380453,
											pk_yr_rc_ssnhighissue2 = 6  => 0.2662473795,
											pk_yr_rc_ssnhighissue2 = 7  => 0.2915214866,
											pk_yr_rc_ssnhighissue2 = 8  => 0.2311435523,
											pk_yr_rc_ssnhighissue2 = 9  => 0.2930568079,
											pk_yr_rc_ssnhighissue2 = 10 => 0.221719457,
											pk_yr_rc_ssnhighissue2 = 11 => 0.1850431448,
											pk_yr_rc_ssnhighissue2 = 12 => 0.1298701299,
											pk_yr_rc_ssnhighissue2 = 13 => 0.1241830065,
																		   0.1331096197);

		pk_prof_lic_cat_mm_b4 := map(pk_prof_lic_cat = -1 => 0.2654494991,
									 pk_prof_lic_cat = 0  => 0.1872791519,
									 pk_prof_lic_cat = 1  => 0.0909090909,
									 pk_prof_lic_cat = 2  => 0.0569620253,
															 0.0322580645);

		pk_add1_lres_mm_b4 := map(pk_add1_lres = -2 => 0.2588235294,
								  pk_add1_lres = -1 => 0.3034645888,
								  pk_add1_lres = 0  => 0.2188235294,
								  pk_add1_lres = 1  => 0.2477477477,
								  pk_add1_lres = 2  => 0.2453703704,
								  pk_add1_lres = 3  => 0.2159624413,
								  pk_add1_lres = 4  => 0.2537202381,
								  pk_add1_lres = 5  => 0.2627118644,
								  pk_add1_lres = 6  => 0.2339181287,
								  pk_add1_lres = 7  => 0.1737749546,
								  pk_add1_lres = 8  => 0.1570422535,
								  pk_add1_lres = 9  => 0.1691542289,
								  pk_add1_lres = 10 => 0.1345381526,
													   0.0563380282);

		pk_add2_lres_mm_b4 := map(pk_add2_lres = -2 => 0.3225620312,
								  pk_add2_lres = -1 => 0.1736842105,
								  pk_add2_lres = 0  => 0.2764317181,
								  pk_add2_lres = 1  => 0.2782199711,
								  pk_add2_lres = 2  => 0.2497522299,
								  pk_add2_lres = 3  => 0.2255434783,
								  pk_add2_lres = 4  => 0.2398373984,
								  pk_add2_lres = 5  => 0.2232905983,
								  pk_add2_lres = 6  => 0.2276176024,
								  pk_add2_lres = 7  => 0.228959276,
								  pk_add2_lres = 8  => 0.1994949495,
								  pk_add2_lres = 9  => 0.1703406814,
													   0.2264150943);

		pk_add3_lres_mm_b4 := map(pk_add3_lres = -2 => 0.3058257295,
								  pk_add3_lres = -1 => 0.2225017973,
								  pk_add3_lres = 0  => 0.2417253521,
								  pk_add3_lres = 1  => 0.2230098146,
								  pk_add3_lres = 2  => 0.2352285396,
								  pk_add3_lres = 3  => 0.2323717949,
								  pk_add3_lres = 4  => 0.2413793103,
								  pk_add3_lres = 5  => 0.1435079727,
													   0.156626506);

		pk_addrs_5yr_mm_b4 := map(pk_addrs_5yr = 0 => 0.2847869704,
								  pk_addrs_5yr = 1 => 0.2531876138,
								  pk_addrs_5yr = 2 => 0.2400321113,
								  pk_addrs_5yr = 3 => 0.2278037383,
													  0.2588832487);

		pk_addrs_15yr_mm_b4 := map(pk_addrs_15yr = 0 => 0.3285917496,
								   pk_addrs_15yr = 1 => 0.2416080051,
								   pk_addrs_15yr = 2 => 0.2215496368,
														0.2363636364);

		pk_add_lres_month_avg2_mm_b4 := map(pk_add_lres_month_avg2 = -1 => 0.3664761127,
											pk_add_lres_month_avg2 = 0  => 0.3305613306,
											pk_add_lres_month_avg2 = 1  => 0.3166144201,
											pk_add_lres_month_avg2 = 2  => 0.3063063063,
											pk_add_lres_month_avg2 = 3  => 0.2595296026,
											pk_add_lres_month_avg2 = 4  => 0.2552301255,
											pk_add_lres_month_avg2 = 5  => 0.2627906977,
											pk_add_lres_month_avg2 = 6  => 0.2173913043,
											pk_add_lres_month_avg2 = 7  => 0.2221600448,
											pk_add_lres_month_avg2 = 8  => 0.2400221729,
											pk_add_lres_month_avg2 = 9  => 0.2166311301,
											pk_add_lres_month_avg2 = 10 => 0.2173038229,
											pk_add_lres_month_avg2 = 11 => 0.2139917695,
											pk_add_lres_month_avg2 = 12 => 0.2255466053,
											pk_add_lres_month_avg2 = 13 => 0.171468728,
											pk_add_lres_month_avg2 = 15 => 0.1399317406,
																		   0.0895522388);

		pk_nameperssn_count_mm_b4 := map(pk_nameperssn_count = 0 => 0.2567816092,
										 pk_nameperssn_count = 1 => 0.3152345809,
																	0.2978723404);

		pk_ssns_per_adl_mm_b4 := map(pk_ssns_per_adl = -1 => 0.3671858775,
									 pk_ssns_per_adl = 0  => 0.2231303107,
									 pk_ssns_per_adl = 1  => 0.273381295,
									 pk_ssns_per_adl = 2  => 0.3287937743,
									 pk_ssns_per_adl = 3  => 0.3388429752,
															 0.4042553191);

		pk_addrs_per_adl_mm_b4 := map(pk_addrs_per_adl = -6 => 0.3718558804,
									  pk_addrs_per_adl = -5 => 0.2686487921,
									  pk_addrs_per_adl = -4 => 0.2565677243,
									  pk_addrs_per_adl = -3 => 0.2567404427,
									  pk_addrs_per_adl = -2 => 0.2413620431,
									  pk_addrs_per_adl = -1 => 0.2303571429,
									  pk_addrs_per_adl = 0  => 0.2021810251,
									  pk_addrs_per_adl = 1  => 0.2079343365,
									  pk_addrs_per_adl = 2  => 0.1897891232,
															   0.1715686275);

		pk_phones_per_adl_mm_b4 := map(pk_phones_per_adl = -1 => 0.277774854,
									   pk_phones_per_adl = 0  => 0.1899509804,
									   pk_phones_per_adl = 1  => 0.2257462687,
																 0.2987012987);

		pk_adlperssn_count_mm_b4 := map(pk_adlperssn_count = -1 => 0.3186129684,
										pk_adlperssn_count = 0  => 0.2225699878,
										pk_adlperssn_count = 1  => 0.266359447,
																   0.3040112597);

		pk_addrs_per_ssn_mm_b4 := map(pk_addrs_per_ssn = -4 => 0.3196884069,
									  pk_addrs_per_ssn = -3 => 0.2642577723,
									  pk_addrs_per_ssn = -2 => 0.2218440594,
									  pk_addrs_per_ssn = -1 => 0.1849710983,
									  pk_addrs_per_ssn = 0  => 0.2027027027,
									  pk_addrs_per_ssn = 1  => 0.1994516792,
									  pk_addrs_per_ssn = 2  => 0.19625,
															   0.1666666667);

		pk_adls_per_addr_mm_b4 := map(pk_adls_per_addr = -102 => 0.2911963883,
									  pk_adls_per_addr = -101 => 0.4298245614,
									  pk_adls_per_addr = -2   => 0.2825366777,
									  pk_adls_per_addr = -1   => 0.3179396092,
									  pk_adls_per_addr = 0    => 0.1771944217,
									  pk_adls_per_addr = 1    => 0.1902268761,
									  pk_adls_per_addr = 2    => 0.2124105012,
									  pk_adls_per_addr = 3    => 0.2077104642,
									  pk_adls_per_addr = 4    => 0.1980033278,
									  pk_adls_per_addr = 5    => 0.2340241796,
									  pk_adls_per_addr = 6    => 0.2425149701,
									  pk_adls_per_addr = 7    => 0.2679814385,
									  pk_adls_per_addr = 8    => 0.238372093,
									  pk_adls_per_addr = 9    => 0.2991803279,
									  pk_adls_per_addr = 10   => 0.2974238876,
									  pk_adls_per_addr = 11   => 0.3075370121,
									  pk_adls_per_addr = 12   => 0.3001269036,
									  pk_adls_per_addr = 13   => 0.2765531062,
									  pk_adls_per_addr = 100  => 0.1956521739,
									  pk_adls_per_addr = 101  => 0.4444444444,
																 0.3679245283);

		pk_phones_per_addr_mm_b4 := map(pk_phones_per_addr = -1  => 0.2651239669,
										pk_phones_per_addr = 0   => 0.2289832887,
										pk_phones_per_addr = 1   => 0.314270724,
										pk_phones_per_addr = 2   => 0.3431635389,
										pk_phones_per_addr = 3   => 0.3131868132,
										pk_phones_per_addr = 100 => 0.3215796897,
										pk_phones_per_addr = 101 => 0.3286219081,
										pk_phones_per_addr = 102 => 0.3706293706,
																	0.2264150943);

		pk_adls_per_phone_mm_b4 := map(pk_adls_per_phone = -2 => 0.2763434302,
									   pk_adls_per_phone = -1 => 0.2399218859,
									   pk_adls_per_phone = 0  => 0.2087628866,
																 0.3472222222);

		pk_ssns_per_adl_c6_mm_b4 := map(pk_ssns_per_adl_c6 = 0 => 0.2593787133,
										pk_ssns_per_adl_c6 = 1 => 0.264715948,
																  0.3728813559);

		pk_addrs_per_adl_c6_mm_b4 := map(pk_addrs_per_adl_c6 = 0 => 0.2571635836,
										 pk_addrs_per_adl_c6 = 1 => 0.2798418972,
										 pk_addrs_per_adl_c6 = 2 => 0.276867031,
																	0.3921568627);

		pk_phones_per_adl_c6_mm_b4 := map(pk_phones_per_adl_c6 = -2 => 0.2613849033,
										  pk_phones_per_adl_c6 = -1 => 0.2625745951,
										  pk_phones_per_adl_c6 = 0  => 0.2894736842,
																	   0.3333333333);

		pk_ssns_per_addr_c6_mm_b4 := map(pk_ssns_per_addr_c6 = 0   => 0.2532386126,
										 pk_ssns_per_addr_c6 = 1   => 0.2769613385,
										 pk_ssns_per_addr_c6 = 2   => 0.2330543933,
										 pk_ssns_per_addr_c6 = 3   => 0.2688311688,
										 pk_ssns_per_addr_c6 = 4   => 0.3111888112,
										 pk_ssns_per_addr_c6 = 5   => 0.3727272727,
										 pk_ssns_per_addr_c6 = 6   => 0.5079365079,
										 pk_ssns_per_addr_c6 = 100 => 0.3090753425,
										 pk_ssns_per_addr_c6 = 101 => 0.3837209302,
										 pk_ssns_per_addr_c6 = 102 => 0.3548387097,
										 pk_ssns_per_addr_c6 = 103 => 0.5,
																	  1);

		pk_phones_per_addr_c6_mm_b4 := map(pk_phones_per_addr_c6 = -1  => 0.2487725844,
										   pk_phones_per_addr_c6 = 0   => 0.3489896232,
										   pk_phones_per_addr_c6 = 1   => 0.4037267081,
										   pk_phones_per_addr_c6 = 2   => 0.4,
										   pk_phones_per_addr_c6 = 100 => 0.3280669145,
										   pk_phones_per_addr_c6 = 101 => 0.3005780347,
																		  0.1111111111);

		pk_adls_per_phone_c6_mm_b4 := map(pk_adls_per_phone_c6 = 0 => 0.259317127,
										  pk_adls_per_phone_c6 = 1 => 0.3081081081,
																	  0.1529850746);

		pk_attr_addrs_last24_mm_b4 := map(pk_attr_addrs_last24 = 0 => 0.2588089522,
										  pk_attr_addrs_last24 = 1 => 0.2585669782,
										  pk_attr_addrs_last24 = 2 => 0.2665010646,
										  pk_attr_addrs_last24 = 3 => 0.295404814,
										  pk_attr_addrs_last24 = 4 => 0.2910958904,
																	  0.375);

		pk_attr_addrs_last36_mm_b4 := map(pk_attr_addrs_last36 = 0 => 0.2689307458,
										  pk_attr_addrs_last36 = 1 => 0.2469985359,
										  pk_attr_addrs_last36 = 2 => 0.2770455794,
										  pk_attr_addrs_last36 = 3 => 0.2555746141,
										  pk_attr_addrs_last36 = 4 => 0.2418831169,
										  pk_attr_addrs_last36 = 5 => 0.2074688797,
																	  0.2692307692);

		pk_ams_class_level_mm_b4 := map(pk_ams_class_level = -1000001 => 0.2717396746,
										pk_ams_class_level = 0        => 0.365497076,
										pk_ams_class_level = 1        => 0.3373493976,
										pk_ams_class_level = 2        => 0.2134387352,
										pk_ams_class_level = 3        => 0.2368421053,
										pk_ams_class_level = 4        => 0.2202643172,
										pk_ams_class_level = 5        => 0.1761658031,
										pk_ams_class_level = 6        => 0.1865889213,
										pk_ams_class_level = 7        => 0.2346938776,
										pk_ams_class_level = 8        => 0.1904761905,
										pk_ams_class_level = 1000000  => 0.1512605042,
										pk_ams_class_level = 1000001  => 0.1470588235,
										pk_ams_class_level = 1000002  => 0.1065292096,
										pk_ams_class_level = 1000003  => 0.0588235294,
										pk_ams_class_level = 1000004  => 0.0388349515,
																		 0.0571428571);

		pk_ams_income_level_code_mm_b4 := map(pk_ams_income_level_code = -1 => 0.2717761314,
											  pk_ams_income_level_code = 0  => 0.4568965517,
											  pk_ams_income_level_code = 1  => 0.3229398664,
											  pk_ams_income_level_code = 2  => 0.2285287528,
											  pk_ams_income_level_code = 3  => 0.1988416988,
											  pk_ams_income_level_code = 4  => 0.1464174455,
											  pk_ams_income_level_code = 5  => 0.1206896552,
																			   0.0816993464);

		pk_college_tier_mm_b4 := map((integer)pk_college_tier = -1 => 0.2694233923,
									 (integer)pk_college_tier = 1  => 0.0476190476,
									 (integer)pk_college_tier = 2  => 0.0612244898,
									 (integer)pk_college_tier = 3  => 0.0319148936,
									 (integer)pk_college_tier = 4  => 0.0890804598,
									 (integer)pk_college_tier = 5  => 0.18,
																	  0.196969697);

		pk_ams_age_mm_b4 := map(pk_ams_age = -1 => 0.2664242424,
								pk_ams_age = 21 => 0.3535791757,
								pk_ams_age = 22 => 0.2723004695,
								pk_ams_age = 23 => 0.2711864407,
								pk_ams_age = 24 => 0.2259414226,
								pk_ams_age = 25 => 0.1981981982,
								pk_ams_age = 29 => 0.187,
												   0.187);

		pk_inferred_age_mm_b4 := map(pk_inferred_age = -1 => 0.3479020979,
									 pk_inferred_age = 18 => 0.3892190153,
									 pk_inferred_age = 19 => 0.3107996702,
									 pk_inferred_age = 20 => 0.2935779817,
									 pk_inferred_age = 21 => 0.2726449275,
									 pk_inferred_age = 22 => 0.252276867,
									 pk_inferred_age = 24 => 0.2306273063,
									 pk_inferred_age = 34 => 0.246930972,
									 pk_inferred_age = 37 => 0.2505399568,
									 pk_inferred_age = 41 => 0.2138836773,
									 pk_inferred_age = 42 => 0.2235294118,
									 pk_inferred_age = 43 => 0.2033195021,
									 pk_inferred_age = 44 => 0.212244898,
									 pk_inferred_age = 46 => 0.1751152074,
									 pk_inferred_age = 48 => 0.176056338,
									 pk_inferred_age = 52 => 0.1855807744,
									 pk_inferred_age = 56 => 0.1820895522,
									 pk_inferred_age = 61 => 0.1384083045,
															 0.1240105541);

		pk_yr_reported_dob2_mm_b4 := map(pk_yr_reported_dob2 = -1 => 0.3187049764,
										 pk_yr_reported_dob2 = 19 => 0.3739837398,
										 pk_yr_reported_dob2 = 21 => 0.2594458438,
										 pk_yr_reported_dob2 = 22 => 0.2244094488,
										 pk_yr_reported_dob2 = 23 => 0.224137931,
										 pk_yr_reported_dob2 = 32 => 0.2204794318,
										 pk_yr_reported_dob2 = 35 => 0.226927253,
										 pk_yr_reported_dob2 = 39 => 0.2211350294,
										 pk_yr_reported_dob2 = 42 => 0.2132963989,
										 pk_yr_reported_dob2 = 43 => 0.2204081633,
										 pk_yr_reported_dob2 = 44 => 0.2018779343,
										 pk_yr_reported_dob2 = 45 => 0.2262443439,
										 pk_yr_reported_dob2 = 46 => 0.1952380952,
										 pk_yr_reported_dob2 = 49 => 0.1647819063,
										 pk_yr_reported_dob2 = 57 => 0.1780821918,
										 pk_yr_reported_dob2 = 61 => 0.1350762527,
																	 0.1278501629);

		pk_avm_hit_level_mm_b4 := map(pk_avm_hit_level = -1 => 0.2311335649,
									  pk_avm_hit_level = 0  => 0.295948484,
									  pk_avm_hit_level = 1  => 0.1929614556,
															   0.1712898752);

		pk_avm_auto_diff4_lvl_mm_b4 := map(pk_avm_auto_diff4_lvl = -1 => 0.2635655522,
										   pk_avm_auto_diff4_lvl = 0  => 0.20625,
																		 0.2142857143);

		pk_add2_avm_auto_diff3_lvl_mm_b4 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.2709019926,
												pk_add2_avm_auto_diff3_lvl = -1 => 0.2196339434,
																				   0.2142433234);

		pk2_add1_avm_as_mm_b4 := map(pk2_add1_avm_as = 0 => 0.2781376518,
									 pk2_add1_avm_as = 1 => 0.1984179301,
									 pk2_add1_avm_as = 2 => 0.1673202614,
															0.131147541);

		pk2_add1_avm_mkt_mm_b4 := map(pk2_add1_avm_mkt = 0 => 0.3253731343,
									  pk2_add1_avm_mkt = 1 => 0.2709459459,
									  pk2_add1_avm_mkt = 2 => 0.2293423272,
									  pk2_add1_avm_mkt = 3 => 0.1675204918,
															  0.1170212766);

		pk2_add1_avm_hed_mm_b4 := map(pk2_add1_avm_hed = 0 => 0.358490566,
									  pk2_add1_avm_hed = 1 => 0.3505747126,
									  pk2_add1_avm_hed = 2 => 0.2605363985,
									  pk2_add1_avm_hed = 3 => 0.2791592966,
									  pk2_add1_avm_hed = 4 => 0.1949458484,
									  pk2_add1_avm_hed = 5 => 0.170937682,
															  0.1045454545);

		pk2_add1_avm_auto_mm_b4 := map(pk2_add1_avm_auto = 0 => 0.4,
									   pk2_add1_avm_auto = 1 => 0.3913043478,
									   pk2_add1_avm_auto = 2 => 0.3248730964,
									   pk2_add1_avm_auto = 3 => 0.2310756972,
									   pk2_add1_avm_auto = 4 => 0.2819675641,
									   pk2_add1_avm_auto = 5 => 0.1727140784,
																0.1218637993);

		pk2_add1_avm_auto2_mm_b4 := map(pk2_add1_avm_auto2 = 0 => 0.48,
										pk2_add1_avm_auto2 = 1 => 0.3305785124,
										pk2_add1_avm_auto2 = 2 => 0.2415730337,
										pk2_add1_avm_auto2 = 3 => 0.2558139535,
										pk2_add1_avm_auto2 = 4 => 0.2831181512,
										pk2_add1_avm_auto2 = 5 => 0.1876106195,
										pk2_add1_avm_auto2 = 6 => 0.1756791721,
																  0.0896860987);

		pk2_add1_avm_auto3_mm_b4 := map(pk2_add1_avm_auto3 = 0 => 0.380952381,
										pk2_add1_avm_auto3 = 1 => 0.2807017544,
										pk2_add1_avm_auto3 = 2 => 0.2680851064,
										pk2_add1_avm_auto3 = 3 => 0.2800940439,
										pk2_add1_avm_auto3 = 4 => 0.179331307,
										pk2_add1_avm_auto3 = 5 => 0.2079510703,
										pk2_add1_avm_auto3 = 6 => 0.1699905033,
																  0.0734463277);

		pk2_add1_avm_auto4_mm_b4 := map(pk2_add1_avm_auto4 = 0 => 0.3333333333,
										pk2_add1_avm_auto4 = 1 => 0.3636363636,
										pk2_add1_avm_auto4 = 2 => 0.1111111111,
										pk2_add1_avm_auto4 = 3 => 0.2639343547,
										pk2_add1_avm_auto4 = 4 => 0.2166666667,
										pk2_add1_avm_auto4 = 5 => 0.1783625731,
																  0.0576923077);

		pk2_add1_avm_med_mm_b4 := map(pk2_add1_avm_med = 0 => 0.4583333333,
									  pk2_add1_avm_med = 1 => 0.4717607973,
									  pk2_add1_avm_med = 2 => 0.3969754253,
									  pk2_add1_avm_med = 3 => 0.32,
									  pk2_add1_avm_med = 4 => 0.2827614717,
									  pk2_add1_avm_med = 5 => 0.2403688364,
									  pk2_add1_avm_med = 6 => 0.1694915254,
															  0.2678972713);

		pk2_add1_avm_to_med_ratio_mm_b4 := map(pk2_add1_avm_to_med_ratio = 0 => 0.2820758228,
											   pk2_add1_avm_to_med_ratio = 1 => 0.1852810651,
											   pk2_add1_avm_to_med_ratio = 2 => 0.1896774194,
											   pk2_add1_avm_to_med_ratio = 3 => 0.1808396125,
											   pk2_add1_avm_to_med_ratio = 4 => 0.157480315,
																				0.16);

		pk2_add2_avm_sp_mm_b4 := map(pk2_add2_avm_sp = 0 => 0.358490566,
									 pk2_add2_avm_sp = 1 => 0.3427419355,
									 pk2_add2_avm_sp = 2 => 0.32,
									 pk2_add2_avm_sp = 3 => 0.2686430022,
									 pk2_add2_avm_sp = 4 => 0.1986607143,
															0.1627260083);

		pk2_add2_avm_mkt_mm_b4 := map(pk2_add2_avm_mkt = 0 => 0.4022346369,
									  pk2_add2_avm_mkt = 1 => 0.3514851485,
									  pk2_add2_avm_mkt = 2 => 0.2660997472,
									  pk2_add2_avm_mkt = 3 => 0.1754266212,
															  0.0860215054);

		pk2_add2_avm_hed_mm_b4 := map(pk2_add2_avm_hed = 0 => 0.4230769231,
									  pk2_add2_avm_hed = 1 => 0.3469387755,
									  pk2_add2_avm_hed = 2 => 0.337962963,
									  pk2_add2_avm_hed = 3 => 0.2698350353,
									  pk2_add2_avm_hed = 4 => 0.2457264957,
									  pk2_add2_avm_hed = 5 => 0.1846929423,
															  0.0740740741);

		pk2_add2_avm_auto_mm_b4 := map(pk2_add2_avm_auto = 0 => 0.3790523691,
									   pk2_add2_avm_auto = 1 => 0.2737560068,
									   pk2_add2_avm_auto = 2 => 0.1972071815,
																0.1276102088);

		pk2_add2_avm_auto3_mm_b4 := map(pk2_add2_avm_auto3 = 0 => 0.3854166667,
										pk2_add2_avm_auto3 = 1 => 0.3793103448,
										pk2_add2_avm_auto3 = 2 => 0.2712098765,
										pk2_add2_avm_auto3 = 3 => 0.1829100892,
																  0.0943396226);

		pk2_add2_avm_auto4_mm_b4 := map(pk2_add2_avm_auto4 = 0 => 0.4705882353,
										pk2_add2_avm_auto4 = 1 => 0.2,
										pk2_add2_avm_auto4 = 2 => 0.3333333333,
										pk2_add2_avm_auto4 = 3 => 0.2624379193,
										pk2_add2_avm_auto4 = 4 => 0.2439418417,
																  0.0975609756);

		pk2_yr_add1_avm_rec_dt_mm_b4 := map(pk2_yr_add1_avm_recording_date = 0 => 0.2230971129,
											pk2_yr_add1_avm_recording_date = 1 => 0.188372093,
											pk2_yr_add1_avm_recording_date = 2 => 0.2741383585,
											pk2_yr_add1_avm_recording_date = 3 => 0.1886287625,
																				  0.16152019);

		pk2_yr_add1_avm_assess_year_mm_b4 := map(pk2_yr_add1_avm_assess_year = 0 => 0.2816245719,
												 pk2_yr_add1_avm_assess_year = 1 => 0.2681818182,
																					0.182824906);

		pk_dist_a1toa2_mm_b4 := map(pk_dist_a1toa2_2 = 0 => 0.2479944193,
									pk_dist_a1toa2_2 = 1 => 0.2181472426,
									pk_dist_a1toa2_2 = 2 => 0.2520568437,
									pk_dist_a1toa2_2 = 3 => 0.2681081081,
															0.3210458637);

		pk_dist_a1toa3_mm_b4 := map(pk_dist_a1toa3_2 = 0 => 0.2550852117,
									pk_dist_a1toa3_2 = 1 => 0.1904231626,
									pk_dist_a1toa3_2 = 2 => 0.2328042328,
									pk_dist_a1toa3_2 = 3 => 0.2719200888,
									pk_dist_a1toa3_2 = 4 => 0.2742316785,
									pk_dist_a1toa3_2 = 5 => 0.2913043478,
															0.3048889774);

		pk_rc_disthphoneaddr_mm_b4 := map(pk_rc_disthphoneaddr_2 = 0 => 0.20124523,
										  pk_rc_disthphoneaddr_2 = 1 => 0.2816677997,
										  pk_rc_disthphoneaddr_2 = 2 => 0.2399512789,
										  pk_rc_disthphoneaddr_2 = 3 => 0.2834951456,
																		0.2783433596);

		pk_out_st_division_lvl_mm_b4 := map(pk_out_st_division_lvl = -1 => 0.4003241491,
											pk_out_st_division_lvl = 0  => 0.198757764,
											pk_out_st_division_lvl = 1  => 0.2026315789,
											pk_out_st_division_lvl = 2  => 0.2493670886,
											pk_out_st_division_lvl = 3  => 0.3450549451,
											pk_out_st_division_lvl = 4  => 0.2625244316,
											pk_out_st_division_lvl = 5  => 0.2433898305,
											pk_out_st_division_lvl = 6  => 0.2309269893,
											pk_out_st_division_lvl = 7  => 0.3044737689,
																		   0.2750759878);

		pk_wealth_index_mm_b4 := map(pk_wealth_index_2 = 0 => 0.2918069585,
									 pk_wealth_index_2 = 1 => 0.2446043165,
									 pk_wealth_index_2 = 2 => 0.1812227074,
									 pk_wealth_index_2 = 3 => 0.1451073986,
															  0.0744047619);

		pk_impulse_count_mm_b4 := if(pk_impulse_count_2 = 0, 0.2615430067, NULL);

		pk_attr_num_nonderogs90_b_mm_b4 := map(pk_attr_num_nonderogs90_b = 0  => 0.3698735148,
											   pk_attr_num_nonderogs90_b = 1  => 0.2910134378,
											   pk_attr_num_nonderogs90_b = 2  => 0.2161512027,
											   pk_attr_num_nonderogs90_b = 3  => 0.1454219031,
											   pk_attr_num_nonderogs90_b = 4  => 0.1842105263,
											   pk_attr_num_nonderogs90_b = 10 => 0.2209944751,
											   pk_attr_num_nonderogs90_b = 11 => 0.2061919505,
											   pk_attr_num_nonderogs90_b = 12 => 0.1656777727,
											   pk_attr_num_nonderogs90_b = 13 => 0.1177644711,
																				 0.0422535211);

		pk_ssns_per_addr2_mm_b4 := map(pk_ssns_per_addr2 = -101 => 0.3071638862,
									   pk_ssns_per_addr2 = -2   => 0.2916403453,
									   pk_ssns_per_addr2 = -1   => 0.2739726027,
									   pk_ssns_per_addr2 = 0    => 0.1728070175,
									   pk_ssns_per_addr2 = 1    => 0.1958762887,
									   pk_ssns_per_addr2 = 2    => 0.2152209493,
									   pk_ssns_per_addr2 = 3    => 0.1967213115,
									   pk_ssns_per_addr2 = 4    => 0.1968085106,
									   pk_ssns_per_addr2 = 5    => 0.2309090909,
									   pk_ssns_per_addr2 = 6    => 0.237037037,
									   pk_ssns_per_addr2 = 7    => 0.2399103139,
									   pk_ssns_per_addr2 = 8    => 0.26910516,
									   pk_ssns_per_addr2 = 9    => 0.2965250965,
									   pk_ssns_per_addr2 = 10   => 0.3062330623,
									   pk_ssns_per_addr2 = 11   => 0.3009795191,
									   pk_ssns_per_addr2 = 12   => 0.2743055556,
									   pk_ssns_per_addr2 = 100  => 0.2093023256,
									   pk_ssns_per_addr2 = 101  => 0.5,
									   pk_ssns_per_addr2 = 102  => 0.3506493506,
																   0.380952381);

		pk_yr_add2_assess_val_yr2_mm_b4 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.2761391089,
											   pk_yr_add2_assessed_value_year2 = 0  => 1,
											   pk_yr_add2_assessed_value_year2 = 1  => 0.2130348038,
																					   0.2313810557);

		pk_prop_own_assess_tot2_mm := map(pk_segment_2 = '0 Derog ' => pk_prop_own_assess_tot2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_prop_own_assess_tot2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_prop_own_assess_tot2_mm_b3,
																	   pk_prop_own_assess_tot2_mm_b4);

		pk_yr_add1_date_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add1_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add1_date_first_seen2_mm_b3,
																		   pk_yr_add1_date_first_seen2_mm_b4);

		pk_attr_addrs_last36_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last36_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_attr_addrs_last36_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_attr_addrs_last36_mm_b3,
																	pk_attr_addrs_last36_mm_b4);

		pk2_add2_avm_mkt_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_mkt_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add2_avm_mkt_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add2_avm_mkt_mm_b3,
																pk2_add2_avm_mkt_mm_b4);

		pk_nameperssn_count_mm := map(pk_segment_2 = '0 Derog ' => pk_nameperssn_count_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_nameperssn_count_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_nameperssn_count_mm_b3,
																   pk_nameperssn_count_mm_b4);

		pk_add1_purchase_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_purchase_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_purchase_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_purchase_amount2_mm_b3,
																		pk_add1_purchase_amount2_mm_b4);

		pk_adls_per_phone_mm := map(pk_segment_2 = '0 Derog ' => pk_adls_per_phone_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_adls_per_phone_mm_b2,
									pk_segment_2 = '2 Renter' => pk_adls_per_phone_mm_b3,
																 pk_adls_per_phone_mm_b4);

		pk_ssns_per_addr2_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_addr2_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_ssns_per_addr2_mm_b2,
									pk_segment_2 = '2 Renter' => pk_ssns_per_addr2_mm_b3,
																 pk_ssns_per_addr2_mm_b4);

		pk_property_owned_total_mm := map(pk_segment_2 = '0 Derog ' => pk_property_owned_total_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_property_owned_total_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_property_owned_total_mm_b3,
																	   pk_property_owned_total_mm_b4);

		pk_ams_class_level_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_class_level_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_ams_class_level_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_ams_class_level_mm_b3,
																  pk_ams_class_level_mm_b4);

		pk_adls_per_phone_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_adls_per_phone_c6_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_adls_per_phone_c6_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_adls_per_phone_c6_mm_b3,
																	pk_adls_per_phone_c6_mm_b4);

		pk_yr_add2_date_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add2_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add2_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add2_date_first_seen2_mm_b3,
																		   pk_yr_add2_date_first_seen2_mm_b4);

		pk_adlperssn_count_mm := map(pk_segment_2 = '0 Derog ' => pk_adlperssn_count_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_adlperssn_count_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_adlperssn_count_mm_b3,
																  pk_adlperssn_count_mm_b4);

		pk2_add2_avm_auto_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_auto_mm_b1,
									pk_segment_2 = '1 Owner ' => pk2_add2_avm_auto_mm_b2,
									pk_segment_2 = '2 Renter' => pk2_add2_avm_auto_mm_b3,
																 pk2_add2_avm_auto_mm_b4);

		pk2_add2_avm_hed_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_hed_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add2_avm_hed_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add2_avm_hed_mm_b3,
																pk2_add2_avm_hed_mm_b4);

		pk_avm_auto_diff4_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_avm_auto_diff4_lvl_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_avm_auto_diff4_lvl_mm_b2,
										pk_segment_2 = '2 Renter' => pk_avm_auto_diff4_lvl_mm_b3,
																	 pk_avm_auto_diff4_lvl_mm_b4);

		pk_yr_add3_date_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add3_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add3_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add3_date_first_seen2_mm_b3,
																		   pk_yr_add3_date_first_seen2_mm_b4);

		pk_add1_land_use_risk_level_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_land_use_risk_level_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_add1_land_use_risk_level_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_add1_land_use_risk_level_mm_b3,
																		   pk_add1_land_use_risk_level_mm_b4);

		pk_add2_avm_auto_diff3_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_avm_auto_diff3_lvl_mm_b1,
											 pk_segment_2 = '1 Owner ' => pk_add2_avm_auto_diff3_lvl_mm_b2,
											 pk_segment_2 = '2 Renter' => pk_add2_avm_auto_diff3_lvl_mm_b3,
																		  pk_add2_avm_auto_diff3_lvl_mm_b4);

		pk_add2_own_level_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_own_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_add2_own_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_add2_own_level_mm_b3,
																 pk_add2_own_level_mm_b4);

		pk_addrs_per_ssn_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_per_ssn_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_addrs_per_ssn_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_addrs_per_ssn_mm_b3,
																pk_addrs_per_ssn_mm_b4);

		pk_add2_lres_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add2_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add2_lres_mm_b3,
															pk_add2_lres_mm_b4);

		pk_addrs_sourced_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_sourced_lvl_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_addrs_sourced_lvl_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_addrs_sourced_lvl_mm_b3,
																	pk_addrs_sourced_lvl_mm_b4);

		pk_add_lres_month_avg2_mm := map(pk_segment_2 = '0 Derog ' => pk_add_lres_month_avg2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_add_lres_month_avg2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_add_lres_month_avg2_mm_b3,
																	  pk_add_lres_month_avg2_mm_b4);

		pk_rc_disthphoneaddr_mm := map(pk_segment_2 = '0 Derog ' => pk_rc_disthphoneaddr_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_rc_disthphoneaddr_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_rc_disthphoneaddr_mm_b3,
																	pk_rc_disthphoneaddr_mm_b4);

		pk_add1_lres_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add1_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add1_lres_mm_b3,
															pk_add1_lres_mm_b4);

		pk_attr_total_number_derogs_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_total_number_derogs_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_attr_total_number_derogs_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_attr_total_number_derogs_mm_b3,
																		   pk_attr_total_number_derogs_mm_b4);

		pk_addrs_per_adl_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_per_adl_c6_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_addrs_per_adl_c6_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_addrs_per_adl_c6_mm_b3,
																   pk_addrs_per_adl_c6_mm_b4);

		pk2_add2_avm_sp_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_sp_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk2_add2_avm_sp_mm_b2,
								  pk_segment_2 = '2 Renter' => pk2_add2_avm_sp_mm_b3,
															   pk2_add2_avm_sp_mm_b4);

		pk_addrs_per_adl_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_per_adl_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_addrs_per_adl_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_addrs_per_adl_mm_b3,
																pk_addrs_per_adl_mm_b4);

		pk_naprop_level2_mm := map(pk_segment_2 = '0 Derog ' => pk_naprop_level2_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_naprop_level2_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_naprop_level2_mm_b3,
																pk_naprop_level2_mm_b4);

		pk2_add1_avm_auto3_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto3_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto3_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add1_avm_auto3_mm_b3,
																  pk2_add1_avm_auto3_mm_b4);

		pk2_add1_avm_mkt_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_mkt_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_mkt_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_mkt_mm_b3,
																pk2_add1_avm_mkt_mm_b4);

		pk_yr_reported_dob2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_reported_dob2_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_yr_reported_dob2_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_yr_reported_dob2_mm_b3,
																   pk_yr_reported_dob2_mm_b4);

		pk_prop1_sale_price2_mm := map(pk_segment_2 = '0 Derog ' => pk_prop1_sale_price2_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_prop1_sale_price2_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_prop1_sale_price2_mm_b3,
																	pk_prop1_sale_price2_mm_b4);

		pk2_add1_avm_auto4_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto4_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto4_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add1_avm_auto4_mm_b3,
																  pk2_add1_avm_auto4_mm_b4);

		pk_college_tier_mm := map(pk_segment_2 = '0 Derog ' => pk_college_tier_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_college_tier_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_college_tier_mm_b3,
															   pk_college_tier_mm_b4);

		pk_ssns_per_adl_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_ssns_per_adl_mm_b3,
															   pk_ssns_per_adl_mm_b4);

		pk_yr_adl_w_last_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_w_last_seen2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_adl_w_last_seen2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_adl_w_last_seen2_mm_b3,
																	  pk_yr_adl_w_last_seen2_mm_b4);

		pk_ams_income_level_code_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_income_level_code_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_ams_income_level_code_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_ams_income_level_code_mm_b3,
																		pk_ams_income_level_code_mm_b4);

		pk_yr_ln_unrel_ot_f_sn2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_ln_unrel_ot_f_sn2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_ln_unrel_ot_f_sn2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_ln_unrel_ot_f_sn2_mm_b3,
																	   pk_yr_ln_unrel_ot_f_sn2_mm_b4);

		pk_add1_building_area2_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_building_area2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_add1_building_area2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_add1_building_area2_mm_b3,
																	  pk_add1_building_area2_mm_b4);

		pk_pr_count_mm := map(pk_segment_2 = '0 Derog ' => pk_pr_count_mm_b1,
							  pk_segment_2 = '1 Owner ' => pk_pr_count_mm_b2,
							  pk_segment_2 = '2 Renter' => pk_pr_count_mm_b3,
														   pk_pr_count_mm_b4);

		pk2_add1_avm_as_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_as_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk2_add1_avm_as_mm_b2,
								  pk_segment_2 = '2 Renter' => pk2_add1_avm_as_mm_b3,
															   pk2_add1_avm_as_mm_b4);

		pk_inferred_age_mm := map(pk_segment_2 = '0 Derog ' => pk_inferred_age_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_inferred_age_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_inferred_age_mm_b3,
															   pk_inferred_age_mm_b4);

		pk2_yr_add1_avm_assess_year_mm := map(pk_segment_2 = '0 Derog ' => pk2_yr_add1_avm_assess_year_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk2_yr_add1_avm_assess_year_mm_b2,
											  pk_segment_2 = '2 Renter' => pk2_yr_add1_avm_assess_year_mm_b3,
																		   pk2_yr_add1_avm_assess_year_mm_b4);

		pk_out_st_division_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_out_st_division_lvl_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_out_st_division_lvl_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_out_st_division_lvl_mm_b3,
																	  pk_out_st_division_lvl_mm_b4);

		pk_yr_rc_ssnhighissue2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_rc_ssnhighissue2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_rc_ssnhighissue2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_rc_ssnhighissue2_mm_b3,
																	  pk_yr_rc_ssnhighissue2_mm_b4);

		pk_watercraft_count_mm := map(pk_segment_2 = '0 Derog ' => pk_watercraft_count_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_watercraft_count_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_watercraft_count_mm_b3,
																   pk_watercraft_count_mm_b4);

		pk_phones_per_adl_mm := map(pk_segment_2 = '0 Derog ' => pk_phones_per_adl_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_phones_per_adl_mm_b2,
									pk_segment_2 = '2 Renter' => pk_phones_per_adl_mm_b3,
																 pk_phones_per_adl_mm_b4);

		pk2_add1_avm_auto2_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto2_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto2_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add1_avm_auto2_mm_b3,
																  pk2_add1_avm_auto2_mm_b4);

		pk_ssns_per_addr_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_addr_c6_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_ssns_per_addr_c6_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_ssns_per_addr_c6_mm_b3,
																   pk_ssns_per_addr_c6_mm_b4);

		pk_yr_ln_unrel_lt_f_sn2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_ln_unrel_lt_f_sn2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_ln_unrel_lt_f_sn2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_ln_unrel_lt_f_sn2_mm_b3,
																	   pk_yr_ln_unrel_lt_f_sn2_mm_b4);

		pk2_add1_avm_hed_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_hed_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_hed_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_hed_mm_b3,
																pk2_add1_avm_hed_mm_b4);

		pk2_yr_add1_avm_rec_dt_mm := map(pk_segment_2 = '0 Derog ' => pk2_yr_add1_avm_rec_dt_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk2_yr_add1_avm_rec_dt_mm_b2,
										 pk_segment_2 = '2 Renter' => pk2_yr_add1_avm_rec_dt_mm_b3,
																	  pk2_yr_add1_avm_rec_dt_mm_b4);

		pk_add1_mortgage_risk_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add1_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add1_mortgage_risk_mm_b3,
																	 pk_add1_mortgage_risk_mm_b4);

		pk_yr_add2_assess_val_yr2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add2_assess_val_yr2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_add2_assess_val_yr2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_add2_assess_val_yr2_mm_b3,
																		 pk_yr_add2_assess_val_yr2_mm_b4);

		pk_add2_assessed_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_assessed_amount2_mm_b3,
																		pk_add2_assessed_amount2_mm_b4);

		pk_prof_lic_cat_mm := map(pk_segment_2 = '0 Derog ' => pk_prof_lic_cat_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_prof_lic_cat_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_prof_lic_cat_mm_b3,
															   pk_prof_lic_cat_mm_b4);

		pk_dist_a1toa3_mm := map(pk_segment_2 = '0 Derog ' => pk_dist_a1toa3_mm_b1,
								 pk_segment_2 = '1 Owner ' => pk_dist_a1toa3_mm_b2,
								 pk_segment_2 = '2 Renter' => pk_dist_a1toa3_mm_b3,
															  pk_dist_a1toa3_mm_b4);

		pk_eviction_level_mm := map(pk_segment_2 = '0 Derog ' => pk_eviction_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_eviction_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_eviction_level_mm_b3,
																 pk_eviction_level_mm_b4);

		pk_attr_num_nonderogs90_b_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_num_nonderogs90_b_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_attr_num_nonderogs90_b_mm_b2,
											pk_segment_2 = '2 Renter' => pk_attr_num_nonderogs90_b_mm_b3,
																		 pk_attr_num_nonderogs90_b_mm_b4);

		pk_add3_own_level_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_own_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_add3_own_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_add3_own_level_mm_b3,
																 pk_add3_own_level_mm_b4);

		pk_adls_per_addr_mm := map(pk_segment_2 = '0 Derog ' => pk_adls_per_addr_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_adls_per_addr_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_adls_per_addr_mm_b3,
																pk_adls_per_addr_mm_b4);

		pk_ssns_per_adl_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_c6_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_c6_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_ssns_per_adl_c6_mm_b3,
																  pk_ssns_per_adl_c6_mm_b4);

		pk_attr_addrs_last24_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last24_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_attr_addrs_last24_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_attr_addrs_last24_mm_b3,
																	pk_attr_addrs_last24_mm_b4);

		pk_yr_add2_date_last_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add2_date_last_seen2_mm_b1,
											 pk_segment_2 = '1 Owner ' => pk_yr_add2_date_last_seen2_mm_b2,
											 pk_segment_2 = '2 Renter' => pk_yr_add2_date_last_seen2_mm_b3,
																		  pk_yr_add2_date_last_seen2_mm_b4);

		pk_add3_mortgage_risk_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add3_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add3_mortgage_risk_mm_b3,
																	 pk_add3_mortgage_risk_mm_b4);

		pk_add2_parking_no_of_cars_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_parking_no_of_cars_mm_b1,
											 pk_segment_2 = '1 Owner ' => pk_add2_parking_no_of_cars_mm_b2,
											 pk_segment_2 = '2 Renter' => pk_add2_parking_no_of_cars_mm_b3,
																		  pk_add2_parking_no_of_cars_mm_b4);

		pk2_add1_avm_med_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_med_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_med_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_med_mm_b3,
																pk2_add1_avm_med_mm_b4);

		pk_impulse_count_mm := map(pk_segment_2 = '0 Derog ' => pk_impulse_count_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_impulse_count_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_impulse_count_mm_b3,
																pk_impulse_count_mm_b4);

		pk_add2_no_of_buildings_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_no_of_buildings_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_add2_no_of_buildings_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_add2_no_of_buildings_mm_b3,
																	   pk_add2_no_of_buildings_mm_b4);

		pk_yr_add1_mortgage_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_mortgage_date2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_add1_mortgage_date2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_add1_mortgage_date2_mm_b3,
																		 pk_yr_add1_mortgage_date2_mm_b4);

		pk_crime_level_mm := map(pk_segment_2 = '0 Derog ' => pk_crime_level_mm_b1,
								 pk_segment_2 = '1 Owner ' => pk_crime_level_mm_b2,
								 pk_segment_2 = '2 Renter' => pk_crime_level_mm_b3,
															  pk_crime_level_mm_b4);

		pk_addrs_15yr_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_15yr_mm_b1,
								pk_segment_2 = '1 Owner ' => pk_addrs_15yr_mm_b2,
								pk_segment_2 = '2 Renter' => pk_addrs_15yr_mm_b3,
															 pk_addrs_15yr_mm_b4);

		pk_avm_hit_level_mm := map(pk_segment_2 = '0 Derog ' => pk_avm_hit_level_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_avm_hit_level_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_avm_hit_level_mm_b3,
																pk_avm_hit_level_mm_b4);

		pk_bk_level_mm := map(pk_segment_2 = '0 Derog ' => pk_bk_level_mm_b1,
							  pk_segment_2 = '1 Owner ' => pk_bk_level_mm_b2,
							  pk_segment_2 = '2 Renter' => pk_bk_level_mm_b3,
														   pk_bk_level_mm_b4);

		pk_wealth_index_mm := map(pk_segment_2 = '0 Derog ' => pk_wealth_index_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_wealth_index_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_wealth_index_mm_b3,
															   pk_wealth_index_mm_b4);

		pk2_add1_avm_to_med_ratio_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_to_med_ratio_mm_b1,
											pk_segment_2 = '1 Owner ' => pk2_add1_avm_to_med_ratio_mm_b2,
											pk_segment_2 = '2 Renter' => pk2_add1_avm_to_med_ratio_mm_b3,
																		 pk2_add1_avm_to_med_ratio_mm_b4);

		pk2_add1_avm_auto_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto_mm_b1,
									pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto_mm_b2,
									pk_segment_2 = '2 Renter' => pk2_add1_avm_auto_mm_b3,
																 pk2_add1_avm_auto_mm_b4);

		pk_add1_assessed_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_assessed_amount2_mm_b3,
																		pk_add1_assessed_amount2_mm_b4);

		pk_add3_lres_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add3_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add3_lres_mm_b3,
															pk_add3_lres_mm_b4);

		pk_ams_age_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_age_mm_b1,
							 pk_segment_2 = '1 Owner ' => pk_ams_age_mm_b2,
							 pk_segment_2 = '2 Renter' => pk_ams_age_mm_b3,
														  pk_ams_age_mm_b4);

		pk_yr_prop2_sale_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_prop2_sale_date2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_prop2_sale_date2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_prop2_sale_date2_mm_b3,
																	  pk_yr_prop2_sale_date2_mm_b4);

		pk_estimated_income_mm := map(pk_segment_2 = '0 Derog ' => pk_estimated_income_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_estimated_income_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_estimated_income_mm_b3,
																   pk_estimated_income_mm_b4);

		pk_yr_add1_mortgage_due_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_mortgage_due_date2_mm_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_add1_mortgage_due_date2_mm_b2,
												pk_segment_2 = '2 Renter' => pk_yr_add1_mortgage_due_date2_mm_b3,
																			 pk_yr_add1_mortgage_due_date2_mm_b4);

		pk_add2_mortgage_risk_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add2_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add2_mortgage_risk_mm_b3,
																	 pk_add2_mortgage_risk_mm_b4);

		pk_dist_a1toa2_mm := map(pk_segment_2 = '0 Derog ' => pk_dist_a1toa2_mm_b1,
								 pk_segment_2 = '1 Owner ' => pk_dist_a1toa2_mm_b2,
								 pk_segment_2 = '2 Renter' => pk_dist_a1toa2_mm_b3,
															  pk_dist_a1toa2_mm_b4);

		pk_add1_own_level_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_own_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_add1_own_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_add1_own_level_mm_b3,
																 pk_add1_own_level_mm_b4);

		pk2_add2_avm_auto4_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_auto4_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add2_avm_auto4_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add2_avm_auto4_mm_b3,
																  pk2_add2_avm_auto4_mm_b4);

		pk_add3_assessed_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add3_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add3_assessed_amount2_mm_b3,
																		pk_add3_assessed_amount2_mm_b4);

		pk_yr_add1_built_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_built_date2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_add1_built_date2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_add1_built_date2_mm_b3,
																	  pk_yr_add1_built_date2_mm_b4);

		pk_addrs_5yr_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_5yr_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_addrs_5yr_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_addrs_5yr_mm_b3,
															pk_addrs_5yr_mm_b4);

		pk_phones_per_addr_mm := map(pk_segment_2 = '0 Derog ' => pk_phones_per_addr_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_phones_per_addr_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_phones_per_addr_mm_b3,
																  pk_phones_per_addr_mm_b4);

		pk_lien_type_level_mm := map(pk_segment_2 = '0 Derog ' => pk_lien_type_level_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_lien_type_level_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_lien_type_level_mm_b3,
																  pk_lien_type_level_mm_b4);

		pk2_add2_avm_auto3_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_auto3_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add2_avm_auto3_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add2_avm_auto3_mm_b3,
																  pk2_add2_avm_auto3_mm_b4);

		pk_phones_per_adl_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_phones_per_adl_c6_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_phones_per_adl_c6_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_phones_per_adl_c6_mm_b3,
																	pk_phones_per_adl_c6_mm_b4);

		pk_phones_per_addr_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_phones_per_addr_c6_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_phones_per_addr_c6_mm_b2,
										pk_segment_2 = '2 Renter' => pk_phones_per_addr_c6_mm_b3,
																	 pk_phones_per_addr_c6_mm_b4);

		pk_yr_liens_last_unrel_date3_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_liens_last_unrel_date3_mm_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_liens_last_unrel_date3_mm_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_liens_last_unrel_date3_mm_b3,
																			pk_yr_liens_last_unrel_date3_mm_b4);

		segment_mean :=  map(pk_segment_2 = '0 Derog ' => (13628 / 41881),
							 pk_segment_2 = '1 Owner ' => (2444 / 30485),
							 pk_segment_2 = '2 Renter' => (15220 / 54322),
														  (6197 / 23694));

		pk_add_lres_month_avg2_mm_2 :=  if(pk_add_lres_month_avg2_mm = NULL, segment_mean, pk_add_lres_month_avg2_mm);

		pk_add1_address_score_mm_2 :=  if(pk_add1_address_score_mm = NULL, segment_mean, pk_add1_address_score_mm);

		pk_add1_assessed_amount2_mm_2 :=  if(pk_add1_assessed_amount2_mm = NULL, segment_mean, pk_add1_assessed_amount2_mm);

		pk_add1_building_area2_mm_2 :=  if(pk_add1_building_area2_mm = NULL, segment_mean, pk_add1_building_area2_mm);

		pk_add1_land_use_risk_level_mm_2 :=  if(pk_add1_land_use_risk_level_mm = NULL, segment_mean, pk_add1_land_use_risk_level_mm);

		pk_add1_lres_mm_2 :=  if(pk_add1_lres_mm = NULL, segment_mean, pk_add1_lres_mm);

		pk_add1_mortgage_risk_mm_2 :=  if(pk_add1_mortgage_risk_mm = NULL, segment_mean, pk_add1_mortgage_risk_mm);

		pk_add1_own_level_mm_2 :=  if(pk_add1_own_level_mm = NULL, segment_mean, pk_add1_own_level_mm);

		pk_add1_purchase_amount2_mm_2 :=  if(pk_add1_purchase_amount2_mm = NULL, segment_mean, pk_add1_purchase_amount2_mm);

		pk_add2_address_score_mm_2 :=  if(pk_add2_address_score_mm = NULL, segment_mean, pk_add2_address_score_mm);

		pk_add2_assessed_amount2_mm_2 :=  if(pk_add2_assessed_amount2_mm = NULL, segment_mean, pk_add2_assessed_amount2_mm);

		pk_add2_avm_auto_diff3_lvl_mm_2 :=  if(pk_add2_avm_auto_diff3_lvl_mm = NULL, segment_mean, pk_add2_avm_auto_diff3_lvl_mm);

		pk_add2_em_ver_lvl_mm_2 :=  if(pk_add2_em_ver_lvl_mm = NULL, segment_mean, pk_add2_em_ver_lvl_mm);

		pk_add2_lres_mm_2 :=  if(pk_add2_lres_mm = NULL, segment_mean, pk_add2_lres_mm);

		pk_add2_mortgage_risk_mm_2 :=  if(pk_add2_mortgage_risk_mm = NULL, segment_mean, pk_add2_mortgage_risk_mm);

		pk_add2_no_of_buildings_mm_2 :=  if(pk_add2_no_of_buildings_mm = NULL, segment_mean, pk_add2_no_of_buildings_mm);

		pk_add2_own_level_mm_2 :=  if(pk_add2_own_level_mm = NULL, segment_mean, pk_add2_own_level_mm);

		pk_add2_parking_no_of_cars_mm_2 :=  if(pk_add2_parking_no_of_cars_mm = NULL, segment_mean, pk_add2_parking_no_of_cars_mm);

		pk_add2_pos_secondary_sources_mm_2 :=  if(pk_add2_pos_secondary_sources_mm = NULL, segment_mean, pk_add2_pos_secondary_sources_mm);

		pk_add2_pos_sources_mm_2 :=  if(pk_add2_pos_sources_mm = NULL, segment_mean, pk_add2_pos_sources_mm);

		pk_add3_assessed_amount2_mm_2 :=  if(pk_add3_assessed_amount2_mm = NULL, segment_mean, pk_add3_assessed_amount2_mm);

		pk_add3_lres_mm_2 :=  if(pk_add3_lres_mm = NULL, segment_mean, pk_add3_lres_mm);

		pk_add3_mortgage_risk_mm_2 :=  if(pk_add3_mortgage_risk_mm = NULL, segment_mean, pk_add3_mortgage_risk_mm);

		pk_add3_own_level_mm_2 :=  if(pk_add3_own_level_mm = NULL, segment_mean, pk_add3_own_level_mm);

		pk_addrs_15yr_mm_2 :=  if(pk_addrs_15yr_mm = NULL, segment_mean, pk_addrs_15yr_mm);

		pk_addrs_5yr_mm_2 :=  if(pk_addrs_5yr_mm = NULL, segment_mean, pk_addrs_5yr_mm);

		pk_addrs_per_adl_c6_mm_2 :=  if(pk_addrs_per_adl_c6_mm = NULL, segment_mean, pk_addrs_per_adl_c6_mm);

		pk_addrs_per_adl_mm_2 :=  if(pk_addrs_per_adl_mm = NULL, segment_mean, pk_addrs_per_adl_mm);

		pk_addrs_per_ssn_mm_2 :=  if(pk_addrs_per_ssn_mm = NULL, segment_mean, pk_addrs_per_ssn_mm);

		pk_addrs_sourced_lvl_mm_2 :=  if(pk_addrs_sourced_lvl_mm = NULL, segment_mean, pk_addrs_sourced_lvl_mm);

		pk_adl_score_mm_2 :=  if(pk_adl_score_mm = NULL, segment_mean, pk_adl_score_mm);

		pk_adlperssn_count_mm_2 :=  if(pk_adlperssn_count_mm = NULL, segment_mean, pk_adlperssn_count_mm);

		pk_adls_per_addr_mm_2 :=  if(pk_adls_per_addr_mm = NULL, segment_mean, pk_adls_per_addr_mm);

		pk_adls_per_phone_c6_mm_2 :=  if(pk_adls_per_phone_c6_mm = NULL, segment_mean, pk_adls_per_phone_c6_mm);

		pk_adls_per_phone_mm_2 :=  if(pk_adls_per_phone_mm = NULL, segment_mean, pk_adls_per_phone_mm);

		pk_ams_age_mm_2 :=  if(pk_ams_age_mm = NULL, segment_mean, pk_ams_age_mm);

		pk_ams_class_level_mm_2 :=  if(pk_ams_class_level_mm = NULL, segment_mean, pk_ams_class_level_mm);

		pk_ams_income_level_code_mm_2 :=  if(pk_ams_income_level_code_mm = NULL, segment_mean, pk_ams_income_level_code_mm);

		pk_attr_addrs_last24_mm_2 :=  if(pk_attr_addrs_last24_mm = NULL, segment_mean, pk_attr_addrs_last24_mm);

		pk_attr_addrs_last36_mm_2 :=  if(pk_attr_addrs_last36_mm = NULL, segment_mean, pk_attr_addrs_last36_mm);

		pk_attr_num_nonderogs90_b_mm_2 :=  if(pk_attr_num_nonderogs90_b_mm = NULL, segment_mean, pk_attr_num_nonderogs90_b_mm);

		pk_attr_total_number_derogs_mm_2 :=  if(pk_attr_total_number_derogs_mm = NULL, segment_mean, pk_attr_total_number_derogs_mm);

		pk_avm_auto_diff4_lvl_mm_2 :=  if(pk_avm_auto_diff4_lvl_mm = NULL, segment_mean, pk_avm_auto_diff4_lvl_mm);

		pk_avm_hit_level_mm_2 :=  if(pk_avm_hit_level_mm = NULL, segment_mean, pk_avm_hit_level_mm);

		pk_bk_level_mm_2 :=  if(pk_bk_level_mm = NULL, segment_mean, pk_bk_level_mm);

		pk_college_tier_mm_2 :=  if(pk_college_tier_mm = NULL, segment_mean, pk_college_tier_mm);

		pk_combo_addrscore_mm_2 :=  if(pk_combo_addrscore_mm = NULL, segment_mean, pk_combo_addrscore_mm);

		pk_combo_hphonescore_mm_2 :=  if(pk_combo_hphonescore_mm = NULL, segment_mean, pk_combo_hphonescore_mm);

		pk_combo_ssnscore_mm_2 :=  if(pk_combo_ssnscore_mm = NULL, segment_mean, pk_combo_ssnscore_mm);

		pk_crime_level_mm_2 :=  if(pk_crime_level_mm = NULL, segment_mean, pk_crime_level_mm);

		pk_dist_a1toa2_mm_2 :=  if(pk_dist_a1toa2_mm = NULL, segment_mean, pk_dist_a1toa2_mm);

		pk_dist_a1toa3_mm_2 :=  if(pk_dist_a1toa3_mm = NULL, segment_mean, pk_dist_a1toa3_mm);

		pk_em_only_ver_lvl_mm_2 :=  if(pk_em_only_ver_lvl_mm = NULL, segment_mean, pk_em_only_ver_lvl_mm);

		pk_eq_count_mm_2 :=  if(pk_eq_count_mm = NULL, segment_mean, pk_eq_count_mm);

		pk_estimated_income_mm_2 :=  if(pk_estimated_income_mm = NULL, segment_mean, pk_estimated_income_mm);

		pk_eviction_level_mm_2 :=  if(pk_eviction_level_mm = NULL, segment_mean, pk_eviction_level_mm);

		pk_fname_eda_sourced_type_lvl_mm_2 :=  if(pk_fname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_fname_eda_sourced_type_lvl_mm);

		pk_impulse_count_mm_2 :=  if(pk_impulse_count_mm = NULL, segment_mean, pk_impulse_count_mm);

		pk_inferred_age_mm_2 :=  if(pk_inferred_age_mm = NULL, segment_mean, pk_inferred_age_mm);

		pk_infutor_risk_lvl_mm_2 :=  if(pk_infutor_risk_lvl_mm = NULL, segment_mean, pk_infutor_risk_lvl_mm);

		pk_infutor_risk_lvl_nb_mm_2 :=  if(pk_infutor_risk_lvl_nb_mm = NULL, segment_mean, pk_infutor_risk_lvl_nb_mm);

		pk_lien_type_level_mm_2 :=  if(pk_lien_type_level_mm = NULL, segment_mean, pk_lien_type_level_mm);

		pk_lname_eda_sourced_type_lvl_mm_2 :=  if(pk_lname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_lname_eda_sourced_type_lvl_mm);

		pk_lname_score_mm_2 :=  if(pk_lname_score_mm = NULL, segment_mean, pk_lname_score_mm);

		pk_nameperssn_count_mm_2 :=  if(pk_nameperssn_count_mm = NULL, segment_mean, pk_nameperssn_count_mm);

		pk_nap_summary_mm_2 :=  if(pk_nap_summary_mm = NULL, segment_mean, pk_nap_summary_mm);

		pk_naprop_level2_mm_2 :=  if(pk_naprop_level2_mm = NULL, segment_mean, pk_naprop_level2_mm);

		pk_nas_summary_mm_2 :=  if(pk_nas_summary_mm = NULL, segment_mean, pk_nas_summary_mm);

		pk_out_st_division_lvl_mm_2 :=  if(pk_out_st_division_lvl_mm = NULL, segment_mean, pk_out_st_division_lvl_mm);

		pk_phones_per_addr_c6_mm_2 :=  if(pk_phones_per_addr_c6_mm = NULL, segment_mean, pk_phones_per_addr_c6_mm);

		pk_phones_per_addr_mm_2 :=  if(pk_phones_per_addr_mm = NULL, segment_mean, pk_phones_per_addr_mm);

		pk_phones_per_adl_c6_mm_2 :=  if(pk_phones_per_adl_c6_mm = NULL, segment_mean, pk_phones_per_adl_c6_mm);

		pk_phones_per_adl_mm_2 :=  if(pk_phones_per_adl_mm = NULL, segment_mean, pk_phones_per_adl_mm);

		pk_pos_secondary_sources_mm_2 :=  if(pk_pos_secondary_sources_mm = NULL, segment_mean, pk_pos_secondary_sources_mm);

		pk_pr_count_mm_2 :=  if(pk_pr_count_mm = NULL, segment_mean, pk_pr_count_mm);

		pk_prof_lic_cat_mm_2 :=  if(pk_prof_lic_cat_mm = NULL, segment_mean, pk_prof_lic_cat_mm);

		pk_prop_own_assess_tot2_mm_2 :=  if(pk_prop_own_assess_tot2_mm = NULL, segment_mean, pk_prop_own_assess_tot2_mm);

		pk_prop1_sale_price2_mm_2 :=  if(pk_prop1_sale_price2_mm = NULL, segment_mean, pk_prop1_sale_price2_mm);

		pk_property_owned_total_mm_2 :=  if(pk_property_owned_total_mm = NULL, segment_mean, pk_property_owned_total_mm);

		pk_rc_dirsaddr_lastscore_mm_2 :=  if(pk_rc_dirsaddr_lastscore_mm = NULL, segment_mean, pk_rc_dirsaddr_lastscore_mm);

		pk_rc_disthphoneaddr_mm_2 :=  if(pk_rc_disthphoneaddr_mm = NULL, segment_mean, pk_rc_disthphoneaddr_mm);

		pk_ssnchar_invalid_or_recent_mm_2 :=  if(pk_ssnchar_invalid_or_recent_mm = NULL, segment_mean, pk_ssnchar_invalid_or_recent_mm);

		pk_ssns_per_addr_c6_mm_2 :=  if(pk_ssns_per_addr_c6_mm = NULL, segment_mean, pk_ssns_per_addr_c6_mm);

		pk_ssns_per_addr2_mm_2 :=  if(pk_ssns_per_addr2_mm = NULL, segment_mean, pk_ssns_per_addr2_mm);

		pk_ssns_per_adl_c6_mm_2 :=  if(pk_ssns_per_adl_c6_mm = NULL, segment_mean, pk_ssns_per_adl_c6_mm);

		pk_ssns_per_adl_mm_2 :=  if(pk_ssns_per_adl_mm = NULL, segment_mean, pk_ssns_per_adl_mm);

		pk_voter_flag_mm_2 :=  if(pk_voter_flag_mm = NULL, segment_mean, pk_voter_flag_mm);

		pk_watercraft_count_mm_2 :=  if(pk_watercraft_count_mm = NULL, segment_mean, pk_watercraft_count_mm);

		pk_wealth_index_mm_2 :=  if(pk_wealth_index_mm = NULL, segment_mean, pk_wealth_index_mm);

		pk_yr_add1_built_date2_mm_2 :=  if(pk_yr_add1_built_date2_mm = NULL, segment_mean, pk_yr_add1_built_date2_mm);

		pk_yr_add1_date_first_seen2_mm_2 :=  if(pk_yr_add1_date_first_seen2_mm = NULL, segment_mean, pk_yr_add1_date_first_seen2_mm);

		pk_yr_add1_mortgage_date2_mm_2 :=  if(pk_yr_add1_mortgage_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_date2_mm);

		pk_yr_add1_mortgage_due_date2_mm_2 :=  if(pk_yr_add1_mortgage_due_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_due_date2_mm);

		pk_yr_add2_assess_val_yr2_mm_2 :=  if(pk_yr_add2_assess_val_yr2_mm = NULL, segment_mean, pk_yr_add2_assess_val_yr2_mm);

		pk_yr_add2_date_first_seen2_mm_2 :=  if(pk_yr_add2_date_first_seen2_mm = NULL, segment_mean, pk_yr_add2_date_first_seen2_mm);

		pk_yr_add2_date_last_seen2_mm_2 :=  if(pk_yr_add2_date_last_seen2_mm = NULL, segment_mean, pk_yr_add2_date_last_seen2_mm);

		pk_yr_add3_date_first_seen2_mm_2 :=  if(pk_yr_add3_date_first_seen2_mm = NULL, segment_mean, pk_yr_add3_date_first_seen2_mm);

		pk_yr_adl_em_only_first_seen2_mm_2 :=  if(pk_yr_adl_em_only_first_seen2_mm = NULL, segment_mean, pk_yr_adl_em_only_first_seen2_mm);

		pk_yr_adl_vo_first_seen2_mm_2 :=  if(pk_yr_adl_vo_first_seen2_mm = NULL, segment_mean, pk_yr_adl_vo_first_seen2_mm);

		pk_yr_adl_w_last_seen2_mm_2 :=  if(pk_yr_adl_w_last_seen2_mm = NULL, segment_mean, pk_yr_adl_w_last_seen2_mm);

		pk_yr_credit_first_seen2_mm_2 :=  if(pk_yr_credit_first_seen2_mm = NULL, segment_mean, pk_yr_credit_first_seen2_mm);

		pk_yr_gong_did_first_seen2_mm_2 :=  if(pk_yr_gong_did_first_seen2_mm = NULL, segment_mean, pk_yr_gong_did_first_seen2_mm);

		pk_yr_header_first_seen2_mm_2 :=  if(pk_yr_header_first_seen2_mm = NULL, segment_mean, pk_yr_header_first_seen2_mm);

		pk_yr_infutor_first_seen2_mm_2 :=  if(pk_yr_infutor_first_seen2_mm = NULL, segment_mean, pk_yr_infutor_first_seen2_mm);

		pk_yr_liens_last_unrel_date3_mm_2 :=  if(pk_yr_liens_last_unrel_date3_mm = NULL, segment_mean, pk_yr_liens_last_unrel_date3_mm);

		pk_yr_ln_unrel_lt_f_sn2_mm_2 :=  if(pk_yr_ln_unrel_lt_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_lt_f_sn2_mm);

		pk_yr_ln_unrel_ot_f_sn2_mm_2 :=  if(pk_yr_ln_unrel_ot_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_ot_f_sn2_mm);

		pk_yr_lname_change_date2_mm_2 :=  if(pk_yr_lname_change_date2_mm = NULL, segment_mean, pk_yr_lname_change_date2_mm);

		pk_yr_prop2_sale_date2_mm_2 :=  if(pk_yr_prop2_sale_date2_mm = NULL, segment_mean, pk_yr_prop2_sale_date2_mm);

		pk_yr_rc_ssnhighissue2_mm_2 :=  if(pk_yr_rc_ssnhighissue2_mm = NULL, segment_mean, pk_yr_rc_ssnhighissue2_mm);

		pk_yr_reported_dob2_mm_2 :=  if(pk_yr_reported_dob2_mm = NULL, segment_mean, pk_yr_reported_dob2_mm);

		pk_yrmo_adl_f_sn_mx_fcra2_mm_2 :=  if(pk_yrmo_adl_f_sn_mx_fcra2_mm = NULL, segment_mean, pk_yrmo_adl_f_sn_mx_fcra2_mm);

		pk2_add1_avm_as_mm_2 :=  if(pk2_add1_avm_as_mm = NULL, segment_mean, pk2_add1_avm_as_mm);

		pk2_add1_avm_auto_mm_2 :=  if(pk2_add1_avm_auto_mm = NULL, segment_mean, pk2_add1_avm_auto_mm);

		pk2_add1_avm_auto2_mm_2 :=  if(pk2_add1_avm_auto2_mm = NULL, segment_mean, pk2_add1_avm_auto2_mm);

		pk2_add1_avm_auto3_mm_2 :=  if(pk2_add1_avm_auto3_mm = NULL, segment_mean, pk2_add1_avm_auto3_mm);

		pk2_add1_avm_auto4_mm_2 :=  if(pk2_add1_avm_auto4_mm = NULL, segment_mean, pk2_add1_avm_auto4_mm);

		pk2_add1_avm_hed_mm_2 :=  if(pk2_add1_avm_hed_mm = NULL, segment_mean, pk2_add1_avm_hed_mm);

		pk2_add1_avm_med_mm_2 :=  if(pk2_add1_avm_med_mm = NULL, segment_mean, pk2_add1_avm_med_mm);

		pk2_add1_avm_mkt_mm_2 :=  if(pk2_add1_avm_mkt_mm = NULL, segment_mean, pk2_add1_avm_mkt_mm);

		pk2_add1_avm_to_med_ratio_mm_2 :=  if(pk2_add1_avm_to_med_ratio_mm = NULL, segment_mean, pk2_add1_avm_to_med_ratio_mm);

		pk2_add2_avm_auto_mm_2 :=  if(pk2_add2_avm_auto_mm = NULL, segment_mean, pk2_add2_avm_auto_mm);

		pk2_add2_avm_auto3_mm_2 :=  if(pk2_add2_avm_auto3_mm = NULL, segment_mean, pk2_add2_avm_auto3_mm);

		pk2_add2_avm_auto4_mm_2 :=  if(pk2_add2_avm_auto4_mm = NULL, segment_mean, pk2_add2_avm_auto4_mm);

		pk2_add2_avm_hed_mm_2 :=  if(pk2_add2_avm_hed_mm = NULL, segment_mean, pk2_add2_avm_hed_mm);

		pk2_add2_avm_mkt_mm_2 :=  if(pk2_add2_avm_mkt_mm = NULL, segment_mean, pk2_add2_avm_mkt_mm);

		pk2_add2_avm_sp_mm_2 :=  if(pk2_add2_avm_sp_mm = NULL, segment_mean, pk2_add2_avm_sp_mm);

		pk2_yr_add1_avm_assess_year_mm_2 :=  if(pk2_yr_add1_avm_assess_year_mm = NULL, segment_mean, pk2_yr_add1_avm_assess_year_mm);

		pk2_yr_add1_avm_rec_dt_mm_2 :=  if(pk2_yr_add1_avm_rec_dt_mm = NULL, segment_mean, pk2_yr_add1_avm_rec_dt_mm);

		addprob3_mod_dm_b1 := -0.685182232 +
			((integer)addrs_prison_history * 0.8042078464) +
			((real)rc_statezipflag * -0.180884266) +
			(pk_addr_not_valid * -0.170434402);

		phnprob_mod_dm_b1 := -0.736050541 +
			(pk_phn_cell_pager_inval * 0.0864079002) +
			((integer)phn_zipmismatch * 0.1153773959) +
			(pk_disconnected * 0.1727165694) +
			(pk_area_code_split * 0.3150228648);

		ssnprob2_mod_dm_nodob_b1 := -2.275728633 +
			((integer)ssn_adl_prob * 0.3696179697) +
			(invalid_ssns_per_adl_c6 * 0.5653144127) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 4.5640149273) +
			((integer)ssn_deceased * 0.3810468307);

		fp_mod5_dm_nodob_b1 := -5.777105257 +
			((100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))) * 0.0679516027) +
			((100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))) * 0.0248678183) +
			((100 * (exp(ssnprob2_mod_dm_nodob_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1)))) * 0.0439889446) +
			(pk_rc_disthphoneaddr_mm_2 * 1.7888979077);

		age_mod3_nodob_dm_b1 := -3.006121488 +
			(pk_ams_age_mm_2 * 0.993281268) +
			(pk_inferred_age_mm_2 * 3.7892397227) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 2.1202990347);

		amstudent_mod_dm_b1 := -4.509346629 +
			(pk_ams_class_level_mm_2 * 3.3885300665) +
			(pk_ams_income_level_code_mm_2 * 3.4919924279) +
			(pk_college_tier_mm_2 * 4.7174776794);

		avm_mod_dm_b1 := -4.964412622 +
			(pk2_add1_avm_as_mm_2 * 1.1507425916) +
			(pk2_add1_avm_auto_mm_2 * 1.1860084539) +
			(pk2_add1_avm_auto3_mm_2 * 1.5471989377) +
			(pk2_add1_avm_med_mm_2 * 2.7203155312) +
			(pk2_add2_avm_sp_mm_2 * 1.643724612) +
			(pk2_add2_avm_mkt_mm_2 * 1.3967653716) +
			(pk2_add2_avm_auto_mm_2 * 1.8252477009) +
			(pk2_yr_add1_avm_assess_year_mm_2 * 1.4990188477);

		derog_mod3_dm_b1 := -4.82179048 +
			(pk_bk_level_mm_2 * 4.0909885727) +
			(pk_crime_level_mm_2 * 3.1160972556) +
			(pk_attr_total_number_derogs_mm_2 * 2.0273753588) +
			(pk_eviction_level_mm_2 * 3.2207429164);

		distance_mod2_dm_b1 := (-2.167999136 + (pk_dist_a1toa3_mm_2 * 4.4182726876));

		lien_mod_dm_b1 := -5.263863123 +
			(pk_lien_type_level_mm_2 * 2.094520063) +
			(pk_yr_liens_last_unrel_date3_mm_2 * 2.5581537143) +
			(pk_yr_ln_unrel_lt_f_sn2_mm_2 * 1.4188154101) +
			(pk_yr_ln_unrel_ot_f_sn2_mm_2 * 7.8152511888);

		lres_mod_dm_b1 := -4.083384956 +
			(pk_add1_lres_mm_2 * 3.7361238938) +
			(pk_add2_lres_mm_2 * 0.9594859029) +
			(pk_add3_lres_mm_2 * 2.8843356597) +
			(pk_add_lres_month_avg2_mm_2 * 2.6644457047);

		proflic_mod_dm_b1 := -2.289151149 +
			(pk_attr_num_proflic_exp12 * -0.230311691) +
			(pk_prof_lic_cat_mm_2 * 4.7933933446);

		property_mod_dm_b1 := -8.077695291 +
			(pk_yr_adl_w_last_seen2_mm_2 * 2.9377684756) +
			(pk_pr_count_mm_2 * 2.4235624196) +
			(pk_naprop_level2_mm_2 * 1.2333391358) +
			(pk_add1_assessed_amount2_mm_2 * 1.8850735989) +
			(pk_yr_add1_date_first_seen2_mm_2 * 1.8677699696) +
			(pk_property_owned_total_mm_2 * 1.2303389216) +
			(pk_yr_prop2_sale_date2_mm_2 * 2.1032801225) +
			(pk_add2_assessed_amount2_mm_2 * 2.5680261751) +
			(pk_yr_add2_date_last_seen2_mm_2 * 1.6148004603) +
			(pk_add3_assessed_amount2_mm_2 * 1.9079909944) +
			(pk_yr_add3_date_first_seen2_mm_2 * 2.607289328);

		velocity2_mod_dm_b1 := -13.51139008 +
			(pk_vo_addrs_per_adl * -0.150789653) +
			(pk_nameperssn_count_mm_2 * 5.1991975524) +
			(pk_ssns_per_adl_mm_2 * 3.6905063789) +
			(pk_addrs_per_adl_mm_2 * 4.9158522016) +
			(pk_phones_per_adl_mm_2 * 3.9633364874) +
			(pk_adlperssn_count_mm_2 * 1.5473784632) +
			(pk_addrs_per_ssn_mm_2 * 2.3184922545) +
			(pk_ssns_per_adl_c6_mm_2 * 2.0642604904) +
			(pk_phones_per_adl_c6_mm_2 * 4.6085161635) +
			(pk_phones_per_addr_c6_mm_2 * 2.1018409867) +
			(pk_attr_addrs_last36_mm_2 * 5.6453741368) +
			(pk_ssns_per_addr2_mm_2 * 3.3015352781);

		ver_best_src_cnt_mod_dm_b1 := -7.895488657 +
			(pk_eq_count_mm_2 * 3.7615340762) +
			(pk_pos_secondary_sources_mm_2 * 4.2448491693) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 3.1810891321) +
			(pk_em_only_ver_lvl_mm_2 * 3.2896839286) +
			(pk_infutor_risk_lvl_mm_2 * 3.6980492431) +
			(pk_nas_summary_mm_2 * 3.9438162325) +
			(pk_attr_num_nonderogs90_b_mm_2 * 3.6486354376);

		ver_notbest_src_cnt_mod_dm_b1 := -8.747714164 +
			(pk_eq_count_mm_2 * 3.0913102452) +
			(pk_pos_secondary_sources_mm_2 * 3.5154757073) +
			(pk_voter_flag_mm_2 * 1.2592451611) +
			(pk_fname_eda_sourced_type_lvl_mm_2 * 1.3510027227) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 1.4158861796) +
			(pk_infutor_risk_lvl_nb_mm_2 * 3.9482089364) +
			(pk_nas_summary_mm_2 * 3.1237805474) +
			(pk_add2_pos_sources_mm_2 * 2.5128831218) +
			(pk_attr_num_nonderogs90_b_mm_2 * 2.4176846113);

		ver_src_cnt_mod_dm_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))), (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1)))));

		mod14_dm_nodob_b1 := -7.30511376 +
			(pk_impulse_count_mm_2 * 3.073081436) +
			(pk_out_st_division_lvl_mm_2 * 3.9171645368) +
			(pk_multi_did * 0.1559449118) +
			((100 * (exp(fp_mod5_dm_nodob_b1) / (1 + exp(fp_mod5_dm_nodob_b1)))) * 0.0109074417) +
			((100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))) * 0.0160998863) +
			((100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))) * 0.0233900034) +
			((100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))) * 0.0233313671) +
			((100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))) * -0.021840183) +
			((100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))) * 0.0199169913) +
			((100 * (exp(amstudent_mod_dm_b1) / (1 + exp(amstudent_mod_dm_b1)))) * 0.0142612298) +
			((100 * (exp(proflic_mod_dm_b1) / (1 + exp(proflic_mod_dm_b1)))) * 0.0135119795) +
			((100 * (exp(distance_mod2_dm_b1) / (1 + exp(distance_mod2_dm_b1)))) * -0.021469975) +
			((100 * (exp(velocity2_mod_dm_b1) / (1 + exp(velocity2_mod_dm_b1)))) * 0.0201497388) +
			((100 * (exp(age_mod3_nodob_dm_b1) / (1 + exp(age_mod3_nodob_dm_b1)))) * 0.0113781326) +
			(ver_src_cnt_mod_dm_b1 * 0.0191490348);

		amstudent_mod_om_b2 := -5.462231441 +
			(pk_ams_class_level_mm_2 * 6.8433968524) +
			(pk_ams_income_level_code_mm_2 * 9.1027746164) +
			(pk_college_tier_mm_2 * 21.430754128);

		avm_mod_om_b2 := -9.354663128 +
			(pk_avm_hit_level_mm_2 * 12.118534885) +
			(pk_avm_auto_diff4_lvl_mm_2 * 17.661242678) +
			(pk_add2_avm_auto_diff3_lvl_mm_2 * 6.3437682721) +
			(pk2_add1_avm_as_mm_2 * 6.8546602529) +
			(pk2_add1_avm_mkt_mm_2 * 4.5960969777) +
			(pk2_add1_avm_auto3_mm_2 * 5.3604781295) +
			(pk2_add1_avm_med_mm_2 * 7.0336254307) +
			(pk2_add2_avm_hed_mm_2 * 3.902667981) +
			(pk2_add2_avm_auto3_mm_2 * 4.7887353254) +
			(pk2_add2_avm_auto4_mm_2 * 6.3101767445) +
			(pk2_yr_add1_avm_rec_dt_mm_2 * 10.334676654);

		lres_mod_om_b2 := -4.883925452 +
			(pk_add1_lres_mm_2 * 10.913617404) +
			(pk_add3_lres_mm_2 * 5.368018692) +
			(pk_addrs_15yr_mm_2 * 5.816373559) +
			(pk_add_lres_month_avg2_mm_2 * 7.6717146149);

		proflic_mod_om_b2 := -3.75134809 +
			(pk_attr_num_proflic_exp90 * -0.630417373) +
			(pk_prof_lic_cat_mm_2 * 16.305255408);

		property_mod_om_b2 := -16.4577251 +
			(pk_add1_adjustable_financing * 0.4639715174) +
			(pk_add1_no_of_partial_baths * -0.498300764) +
			(pk_addrs_sourced_lvl_mm_2 * 11.748032076) +
			(pk_yr_add1_built_date2_mm_2 * 9.9578349478) +
			(pk_add1_mortgage_risk_mm_2 * 12.632426601) +
			(pk_yr_add1_mortgage_due_date2_mm_2 * 13.406779602) +
			(pk_yr_add1_date_first_seen2_mm_2 * 9.1188751115) +
			(pk_prop_own_assess_tot2_mm_2 * 8.1184510498) +
			(pk_prop1_sale_price2_mm_2 * 12.388701463) +
			(pk_add2_no_of_buildings_mm_2 * 13.732506715) +
			(pk_add2_parking_no_of_cars_mm_2 * 10.494494646) +
			(pk_yr_add2_assess_val_yr2_mm_2 * 10.142905668) +
			(pk_add2_mortgage_risk_mm_2 * 9.914435809) +
			(pk_yr_add2_date_first_seen2_mm_2 * 7.8964807741) +
			(pk_add3_mortgage_risk_mm_2 * 12.139309631) +
			(pk_add3_assessed_amount2_mm_2 * 7.2608049971) +
			(pk_yr_add3_date_first_seen2_mm_2 * 6.8496436525) +
			(pk_watercraft_count_mm_2 * 15.902136381);

		velocity2_mod_om_b2 := -8.047639904 +
			(pk_vo_addrs_per_adl * -0.136422136) +
			(pk_nameperssn_count_mm_2 * 11.9723053) +
			(pk_ssns_per_adl_mm_2 * 6.8751756504) +
			(pk_addrs_per_adl_mm_2 * 5.4227052488) +
			(pk_phones_per_adl_mm_2 * 7.8437958134) +
			(pk_adlperssn_count_mm_2 * 7.7102704701) +
			(pk_adls_per_phone_mm_2 * 7.8170912188) +
			(pk_attr_addrs_last36_mm_2 * 9.250185781) +
			(pk_ssns_per_addr2_mm_2 * 11.520783035);

		ver_best_src_cnt_mod_om_b2 := -9.237689458 +
			(pk_eq_count_mm_2 * 7.4457512764) +
			(pk_pos_secondary_sources_mm_2 * 18.436380613) +
			(pk_voter_flag_mm_2 * 11.878852479) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 10.980239213) +
			(pk_em_only_ver_lvl_mm_2 * 9.786968228) +
			(pk_add2_em_ver_lvl_mm_2 * 10.46496007) +
			(pk_infutor_risk_lvl_mm_2 * 8.699870995) +
			(pk_nas_summary_mm_2 * 10.420501753) +
			(pk_attr_num_nonderogs90_b_mm_2 * 12.513815166);

		ver_best_src_time_mod_om_b2 := -7.072524616 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 10.365016035) +
			(pk_yr_adl_em_only_first_seen2_mm_2 * 24.602808141) +
			(pk_yr_gong_did_first_seen2_mm_2 * 9.8585246928) +
			(pk_yr_header_first_seen2_mm_2 * 8.1446134433) +
			(pk_yr_infutor_first_seen2_mm_2 * 14.57420792);

		ver_notbest_src_cnt_mod_om_b2 := -7.8224325 +
			(pk_voter_flag_mm_2 * 7.2957684538) +
			(pk_infutor_risk_lvl_nb_mm_2 * 7.6934750192) +
			(pk_nas_summary_mm_2 * 8.5851245904) +
			(pk_nap_summary_mm_2 * 7.7701646459) +
			(pk_add2_pos_sources_mm_2 * 4.2984300095) +
			(pk_add2_pos_secondary_sources_mm_2 * 12.230318936) +
			(pk_attr_num_nonderogs90_b_mm_2 * 6.7475602607);

		ver_notbest_src_time_mod_om_b2 := -5.990361879 +
			(pk_yr_adl_vo_first_seen2_mm_2 * 6.3578008202) +
			(pk_yr_gong_did_first_seen2_mm_2 * 6.3404728441) +
			(pk_yr_infutor_first_seen2_mm_2 * 9.2575793819) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 7.9015673764) +
			(pk_yr_lname_change_date2_mm_2 * 7.1745709041);

		ver_src_time_mod_om_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_om_b2) / (1 + exp(ver_best_src_time_mod_om_b2)))), (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2)))));

		ver_src_cnt_mod_om_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))), (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2)))));

		mod14_om_nodob_b2 := -6.395336206 +
			(pk_out_st_division_lvl_mm_2 * 8.8509871433) +
			(pk_wealth_index_mm_2 * 4.5628487278) +
			(pk_multi_did * 0.3858109959) +
			((100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))) * 0.055133426) +
			((100 * (exp(lres_mod_om_b2) / (1 + exp(lres_mod_om_b2)))) * -0.041535027) +
			((100 * (exp(avm_mod_om_b2) / (1 + exp(avm_mod_om_b2)))) * 0.0455769221) +
			((100 * (exp(amstudent_mod_om_b2) / (1 + exp(amstudent_mod_om_b2)))) * 0.0496609635) +
			((100 * (exp(proflic_mod_om_b2) / (1 + exp(proflic_mod_om_b2)))) * 0.0870171637) +
			((100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))) * 0.0566768494) +
			(ver_src_cnt_mod_om_b2 * 0.0306490174) +
			(ver_src_time_mod_om_b2 * 0.0364856947);

		age_mod3_nodob_rm_b3 := -4.710400478 +
			(pk_ams_age_mm_2 * 3.5779453742) +
			(pk_inferred_age_mm_2 * 3.2009119556) +
			(pk_yr_reported_dob2_mm_2 * 1.9566855765) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 4.6022319661);

		amstudent_mod_rm_b3 := -3.872540661 +
			(pk_ams_class_level_mm_2 * 2.9703454982) +
			(pk_ams_income_level_code_mm_2 * 3.3604515652) +
			(pk_college_tier_mm_2 * 4.0429966406);

		avm_mod_rm_b3 := -8.923775865 +
			(pk_avm_hit_level_mm_2 * 1.2774498697) +
			(pk2_add1_avm_as_mm_2 * 1.9785300748) +
			(pk2_add1_avm_hed_mm_2 * 1.0514172773) +
			(pk2_add1_avm_auto3_mm_2 * 1.6034910329) +
			(pk2_add1_avm_auto4_mm_2 * 2.8060201687) +
			(pk2_add1_avm_med_mm_2 * 3.3588476515) +
			(pk2_add1_avm_to_med_ratio_mm_2 * 5.3083241617) +
			(pk2_add2_avm_mkt_mm_2 * 1.2401228727) +
			(pk2_add2_avm_hed_mm_2 * 1.0818127073) +
			(pk2_add2_avm_auto_mm_2 * 2.6639642335) +
			(pk2_yr_add1_avm_rec_dt_mm_2 * 6.0557178831);

		distance_mod2_rm_b3 := -2.598387298 +
			(pk_dist_a1toa2_mm_2 * 2.4939656332) +
			(pk_dist_a1toa3_mm_2 * 3.3656515969);

		lres_mod_rm_b3 := -3.103828149 +
			(pk_add1_lres_mm_2 * 2.9886929697) +
			(pk_addrs_5yr_mm_2 * 0.7817547549) +
			(pk_add_lres_month_avg2_mm_2 * 3.8827347514);

		proflic_mod_rm_b3 := -2.53818558 +
			(pk_attr_num_proflic90 * -0.812136354) +
			(pk_attr_num_proflic_exp12 * -0.376407671) +
			(pk_prof_lic_cat_mm_2 * 5.6846967795);

		property_mod_rm_b3 := -12.42141193 +
			(pk_add1_no_of_partial_baths * -0.285716532) +
			(pk_attr_num_watercraft60 * -1.061940951) +
			(pk_pr_count_mm_2 * 4.2758149055) +
			(pk_add1_own_level_mm_2 * 3.1252187144) +
			(pk_add2_own_level_mm_2 * 2.9316893904) +
			(pk_add3_own_level_mm_2 * 3.2372818012) +
			(pk_yr_add1_built_date2_mm_2 * 2.087853129) +
			(pk_add1_purchase_amount2_mm_2 * 2.2106163528) +
			(pk_yr_add1_mortgage_date2_mm_2 * 3.0815383383) +
			(pk_add1_assessed_amount2_mm_2 * 3.2846620522) +
			(pk_yr_add1_date_first_seen2_mm_2 * 4.7264668771) +
			(pk_add1_land_use_risk_level_mm_2 * 2.5423305567) +
			(pk_add1_building_area2_mm_2 * 2.0460904991) +
			(pk_add2_assessed_amount2_mm_2 * 2.7041831726) +
			(pk_yr_add2_date_first_seen2_mm_2 * 2.0386114361) +
			(pk_add3_assessed_amount2_mm_2 * 2.5652443849);

		velocity2_mod_rm_b3 := -10.444171 +
			(pk_vo_addrs_per_adl * -0.142336745) +
			(pk_nameperssn_count_mm_2 * 6.4685349102) +
			(pk_ssns_per_adl_mm_2 * 2.5799007362) +
			(pk_addrs_per_adl_mm_2 * 1.3884266552) +
			(pk_phones_per_adl_mm_2 * 3.2882609443) +
			(pk_adlperssn_count_mm_2 * 2.6025518967) +
			(pk_addrs_per_ssn_mm_2 * 2.4462034538) +
			(pk_ssns_per_addr_c6_mm_2 * 2.711819456) +
			(pk_phones_per_addr_c6_mm_2 * 3.2825103649) +
			(pk_adls_per_phone_c6_mm_2 * 4.5553190123) +
			(pk_ssns_per_addr2_mm_2 * 4.5701283072);

		ver_best_score_mod_rm_nodob_b3 := -6.779512161 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 5.6398942247) +
			(pk_combo_hphonescore_mm_2 * 5.4650307923) +
			(pk_combo_ssnscore_mm_2 * 4.379600808) +
			(pk_add1_address_score_mm_2 * 4.8167098916) +
			(pk_add2_address_score_mm_2 * 4.3354837687);

		ver_best_src_cnt_mod_rm_b3 := -7.048454197 +
			(pk_eq_count_mm_2 * 4.5170480539) +
			(pk_pos_secondary_sources_mm_2 * 6.8805855469) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 4.8039361253) +
			(pk_infutor_risk_lvl_mm_2 * 4.039478244) +
			(pk_nas_summary_mm_2 * 3.1268657473) +
			(pk_attr_num_nonderogs90_b_mm_2 * 2.3678357729);

		ver_best_src_time_mod_rm_b3 := -6.133940459 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.1951251421) +
			(pk_yr_gong_did_first_seen2_mm_2 * 2.5144152498) +
			(pk_yr_header_first_seen2_mm_2 * 2.8948488483) +
			(pk_yr_infutor_first_seen2_mm_2 * 5.4107002632) +
			(pk_yr_lname_change_date2_mm_2 * 6.6746985376);

		ver_notbest_score_mod_rm_nodob_b3 := -11.15269517 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 3.3949735362) +
			(pk_adl_score_mm_2 * 8.1170750905) +
			(pk_lname_score_mm_2 * 6.1668630066) +
			(pk_combo_addrscore_mm_2 * 4.8767736275) +
			(pk_combo_ssnscore_mm_2 * 3.3191747715) +
			(pk_add1_address_score_mm_2 * 8.4050323973);

		ver_notbest_src_cnt_mod_rm_b3 := -7.609020654 +
			(pk_eq_count_mm_2 * 1.034615945) +
			(pk_pos_secondary_sources_mm_2 * 4.9751349437) +
			(pk_voter_flag_mm_2 * 3.0312975503) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 3.1837590467) +
			(pk_infutor_risk_lvl_nb_mm_2 * 4.1684862824) +
			(pk_nap_summary_mm_2 * 3.3216517104) +
			(pk_add2_pos_sources_mm_2 * 1.0161187759) +
			(pk_attr_num_nonderogs90_b_mm_2 * 1.7137454821);

		ver_notbest_src_time_mod_rm_b3 := -5.819035396 +
			(pk_yr_gong_did_first_seen2_mm_2 * 1.0399317862) +
			(pk_yr_credit_first_seen2_mm_2 * 2.8722135813) +
			(pk_yr_header_first_seen2_mm_2 * 3.3037070301) +
			(pk_yr_infutor_first_seen2_mm_2 * 4.02798862) +
			(pk_yr_lname_change_date2_mm_2 * 5.2586325292);

		ver_src_time_mod_rm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_rm_b3) / (1 + exp(ver_best_src_time_mod_rm_b3)))), (100 * (exp(ver_notbest_src_time_mod_rm_b3) / (1 + exp(ver_notbest_src_time_mod_rm_b3)))));

		ver_score_mod_rm_nodob_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_rm_nodob_b3) / (1 + exp(ver_best_score_mod_rm_nodob_b3)))), (100 * (exp(ver_notbest_score_mod_rm_nodob_b3) / (1 + exp(ver_notbest_score_mod_rm_nodob_b3)))));

		ver_src_cnt_mod_rm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))), (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3)))));

		mod14_rm_nodob_b3 := -6.738227742 +
			(pk_did0 * -0.653063266) +
			(pk_out_st_division_lvl_mm_2 * 3.528202433) +
			(pk_estimated_income_mm_2 * 0.6667849146) +
			(pk_multi_did * 0.4352935304) +
			((100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))) * 0.0239482799) +
			((100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))) * -0.034367076) +
			((100 * (exp(avm_mod_rm_b3) / (1 + exp(avm_mod_rm_b3)))) * 0.0263855702) +
			((100 * (exp(amstudent_mod_rm_b3) / (1 + exp(amstudent_mod_rm_b3)))) * 0.0411497652) +
			((100 * (exp(proflic_mod_rm_b3) / (1 + exp(proflic_mod_rm_b3)))) * 0.0295052338) +
			((100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))) * -0.026122586) +
			((100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))) * 0.0249994025) +
			((100 * (exp(age_mod3_nodob_rm_b3) / (1 + exp(age_mod3_nodob_rm_b3)))) * 0.0226857976) +
			(ver_src_cnt_mod_rm_b3 * 0.0344991259) +
			(ver_src_time_mod_rm_b3 * 0.0106101097) +
			(ver_score_mod_rm_nodob_b3 * 0.0105092665);

		age_mod3_nodob_xm_b4 := -4.041773894 +
			(pk_ams_age_mm_2 * 3.5651393574) +
			(pk_inferred_age_mm_2 * 2.8588132342) +
			(pk_yr_reported_dob2_mm_2 * 2.0749991507) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 2.8234791995);

		amstudent_mod_xm_b4 := -4.076152289 +
			(pk_ams_class_level_mm_2 * 2.9565629045) +
			(pk_ams_income_level_code_mm_2 * 4.0035017759) +
			(pk_college_tier_mm_2 * 4.5421861597);

		avm_mod_xm_b4 := -5.314298248 +
			(pk_avm_hit_level_mm_2 * 1.5250141739) +
			(pk2_add1_avm_auto2_mm_2 * 2.5015384804) +
			(pk2_add1_avm_med_mm_2 * 3.4174872905) +
			(pk2_add2_avm_sp_mm_2 * 2.768048504) +
			(pk2_add2_avm_mkt_mm_2 * 2.4783069487) +
			(pk2_add2_avm_hed_mm_2 * 1.9263425821) +
			(pk2_yr_add1_avm_assess_year_mm_2 * 1.6136419531);

		distance_mod2_xm_b4 := -2.666383282 +
			(pk_dist_a1toa2_mm_2 * 2.441281012) +
			(pk_dist_a1toa3_mm_2 * 3.7314687198);

		lres_mod_xm_b4 := -3.326039985 +
			(pk_add1_lres_mm_2 * 3.847641266) +
			(pk_add3_lres_mm_2 * 1.3100174619) +
			(pk_add_lres_month_avg2_mm_2 * 3.430112705);

		property_mod_xm_b4 := -9.818451041 +
			(pk_pr_count_mm_2 * 4.6092647915) +
			(pk_add1_own_level_mm_2 * 2.381224257) +
			(pk_add2_own_level_mm_2 * 4.3425454311) +
			(pk_add1_assessed_amount2_mm_2 * 2.7537014524) +
			(pk_yr_add1_date_first_seen2_mm_2 * 3.7025246749) +
			(pk_add2_assessed_amount2_mm_2 * 3.1369845827) +
			(pk_add3_assessed_amount2_mm_2 * 2.5277365089) +
			(pk_yr_add3_date_first_seen2_mm_2 * 3.1930465493) +
			(pk_watercraft_count_mm_2 * 6.5462577172);

		velocity2_mod_xm_b4 := -14.68115712 +
			(pk_vo_addrs_per_adl * -0.185368531) +
			(pk_nameperssn_count_mm_2 * 6.825754387) +
			(pk_addrs_per_adl_mm_2 * 3.4566600058) +
			(pk_phones_per_adl_mm_2 * 3.2680587611) +
			(pk_adlperssn_count_mm_2 * 1.5534356562) +
			(pk_addrs_per_ssn_mm_2 * 1.2164594009) +
			(pk_adls_per_addr_mm_2 * 3.9780264699) +
			(pk_phones_per_addr_mm_2 * 1.2483315431) +
			(pk_adls_per_phone_mm_2 * 2.9124604306) +
			(pk_ssns_per_adl_c6_mm_2 * 5.6136685706) +
			(pk_addrs_per_adl_c6_mm_2 * 6.5771655518) +
			(pk_phones_per_addr_c6_mm_2 * 2.7279036392) +
			(pk_adls_per_phone_c6_mm_2 * 5.2561182111) +
			(pk_attr_addrs_last24_mm_2 * 7.5013862091);

		ver_best_src_cnt_mod_xm_b4 := -9.035956034 +
			(pk_eq_count_mm_2 * 5.8138986969) +
			(pk_pos_secondary_sources_mm_2 * 7.7169677992) +
			(pk_voter_flag_mm_2 * 4.2341939699) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 5.3866013992) +
			(pk_add2_em_ver_lvl_mm_2 * 9.4389152073) +
			(pk_infutor_risk_lvl_mm_2 * 4.4115707022) +
			(pk_nas_summary_mm_2 * 2.9228141752);

		ver_best_src_time_mod_xm_b4 := -5.983231094 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.8937238163) +
			(pk_yr_gong_did_first_seen2_mm_2 * 2.6969717235) +
			(pk_yr_header_first_seen2_mm_2 * 4.2671658095) +
			(pk_yr_infutor_first_seen2_mm_2 * 6.2473562113) +
			(pk_yr_lname_change_date2_mm_2 * 5.6322281145);

		ver_notbest_src_cnt_mod_xm_b4 := -6.392287067 +
			(pk_eq_count_mm_2 * 2.625291548) +
			(pk_pos_secondary_sources_mm_2 * 4.7677533487) +
			(pk_voter_flag_mm_2 * 2.1650186576) +
			(pk_infutor_risk_lvl_nb_mm_2 * 3.9380343392) +
			(pk_nap_summary_mm_2 * 3.2943359747) +
			(pk_attr_num_nonderogs90_b_mm_2 * 1.6764166269);

		ver_notbest_src_time_mod_xm_b4 := -6.015632852 +
			(pk_yr_gong_did_first_seen2_mm_2 * 1.3124490737) +
			(pk_yr_header_first_seen2_mm_2 * 3.3631646513) +
			(pk_yr_infutor_first_seen2_mm_2 * 4.5782890617) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 2.8577770489) +
			(pk_yr_lname_change_date2_mm_2 * 5.0751638413);

		ver_src_time_mod_xm_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4)))), (100 * (exp(ver_notbest_src_time_mod_xm_b4) / (1 + exp(ver_notbest_src_time_mod_xm_b4)))));

		ver_src_cnt_mod_xm_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_xm_b4) / (1 + exp(ver_best_src_cnt_mod_xm_b4)))), (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4)))));

		mod14_xm_nodob_b4 := -6.713964934 +
			(pk_did0 * -1.020334165) +
			(pk_out_st_division_lvl_mm_2 * 3.6748223998) +
			(pk_multi_did * 0.5041995845) +
			(pk_prof_lic_cat_mm_2 * 3.5568659598) +
			((100 * (exp(property_mod_xm_b4) / (1 + exp(property_mod_xm_b4)))) * 0.0336115238) +
			((100 * (exp(lres_mod_xm_b4) / (1 + exp(lres_mod_xm_b4)))) * -0.032794059) +
			((100 * (exp(avm_mod_xm_b4) / (1 + exp(avm_mod_xm_b4)))) * 0.0266111316) +
			((100 * (exp(amstudent_mod_xm_b4) / (1 + exp(amstudent_mod_xm_b4)))) * 0.0410295459) +
			((100 * (exp(distance_mod2_xm_b4) / (1 + exp(distance_mod2_xm_b4)))) * -0.013831809) +
			((100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4)))) * 0.0271649292) +
			((100 * (exp(age_mod3_nodob_xm_b4) / (1 + exp(age_mod3_nodob_xm_b4)))) * 0.0190805037) +
			(ver_src_cnt_mod_xm_b4 * 0.0278229471) +
			(ver_src_time_mod_xm_b4 * 0.012472493);

		velocity2_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))),
															 NULL);

		mod14_om_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b2) / (1 + exp(mod14_om_nodob_b2))),
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL);

		mod14_dm_nodob := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1) / (1 + exp(mod14_dm_nodob_b1))),
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL);

		proflic_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => (100 * (exp(proflic_mod_rm_b3) / (1 + exp(proflic_mod_rm_b3)))),
														   NULL);

		lien_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))),
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														NULL);

		phat := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1) / (1 + exp(mod14_dm_nodob_b1))),
					pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b2) / (1 + exp(mod14_om_nodob_b2))),
					pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b3) / (1 + exp(mod14_rm_nodob_b3))),
												 (exp(mod14_xm_nodob_b4) / (1 + exp(mod14_xm_nodob_b4))));

		addprob3_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))),
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															NULL);

		proflic_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => (100 * (exp(proflic_mod_om_b2) / (1 + exp(proflic_mod_om_b2)))),
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL);

		age_mod3_nodob_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  (100 * (exp(age_mod3_nodob_xm_b4) / (1 + exp(age_mod3_nodob_xm_b4)))));

		avm_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => (100 * (exp(avm_mod_om_b2) / (1 + exp(avm_mod_om_b2)))),
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL);

		property_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															(100 * (exp(property_mod_xm_b4) / (1 + exp(property_mod_xm_b4)))));

		velocity2_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(velocity2_mod_dm_b1) / (1 + exp(velocity2_mod_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_notbest_score_mod_rm_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_score_mod_rm_nodob_b3) / (1 + exp(ver_notbest_score_mod_rm_nodob_b3)))),
																		   NULL);

		property_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => (100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))),
															NULL);

		velocity2_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => (100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))),
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_src_time_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => ver_src_time_mod_rm_b3,
																NULL);

		property_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))),
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															NULL);

		ver_notbest_src_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => NULL,
																	   (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4)))));

		ver_best_src_time_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_src_time_mod_om_b2) / (1 + exp(ver_best_src_time_mod_om_b2)))),
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL);

		ver_best_src_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => NULL,
																	(100 * (exp(ver_best_src_cnt_mod_xm_b4) / (1 + exp(ver_best_src_cnt_mod_xm_b4)))));

		avm_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => (100 * (exp(avm_mod_rm_b3) / (1 + exp(avm_mod_rm_b3)))),
													   NULL);

		amstudent_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(amstudent_mod_rm_b3) / (1 + exp(amstudent_mod_rm_b3)))),
															 NULL);

		velocity2_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4)))));

		avm_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))),
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL);

		lres_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => (100 * (exp(lres_mod_om_b2) / (1 + exp(lres_mod_om_b2)))),
						   pk_segment_2 = '2 Renter' => NULL,
														NULL);

		ver_best_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))),
																	NULL);

		lres_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => (100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))),
														NULL);

		distance_mod2_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))),
															 NULL);

		ver_score_mod_rm_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
									  pk_segment_2 = '1 Owner ' => NULL,
									  pk_segment_2 = '2 Renter' => ver_score_mod_rm_nodob_b3,
																   NULL);

		proflic_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(proflic_mod_dm_b1) / (1 + exp(proflic_mod_dm_b1)))),
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL);

		ver_notbest_src_time_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_src_time_mod_rm_b3) / (1 + exp(ver_notbest_src_time_mod_rm_b3)))),
																		NULL);

		ver_best_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))),
									   pk_segment_2 = '2 Renter' => NULL,
																	NULL);

		age_mod3_nodob_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => (100 * (exp(age_mod3_nodob_rm_b3) / (1 + exp(age_mod3_nodob_rm_b3)))),
															  NULL);

		ver_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => ver_src_cnt_mod_dm_b1,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => NULL,
															   NULL);

		derog_mod3_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))),
							 pk_segment_2 = '1 Owner ' => NULL,
							 pk_segment_2 = '2 Renter' => NULL,
														  NULL);

		ssnprob2_mod_dm_nodob := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ssnprob2_mod_dm_nodob_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1)))),
									 pk_segment_2 = '1 Owner ' => NULL,
									 pk_segment_2 = '2 Renter' => NULL,
																  NULL);

		amstudent_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => (100 * (exp(amstudent_mod_om_b2) / (1 + exp(amstudent_mod_om_b2)))),
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_src_time_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => ver_src_time_mod_om_b2,
								   pk_segment_2 = '2 Renter' => NULL,
																NULL);

		ver_notbest_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2)))),
										  pk_segment_2 = '2 Renter' => NULL,
																	   NULL);

		ver_notbest_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3)))),
																	   NULL);

		distance_mod2_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(distance_mod2_dm_b1) / (1 + exp(distance_mod2_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_best_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))),
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => NULL,
																	NULL);

		age_mod3_nodob_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(age_mod3_nodob_dm_b1) / (1 + exp(age_mod3_nodob_dm_b1)))),
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  NULL);

		ver_src_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => NULL,
															   ver_src_cnt_mod_xm_b4);

		ver_notbest_src_time_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => NULL,
																		(100 * (exp(ver_notbest_src_time_mod_xm_b4) / (1 + exp(ver_notbest_src_time_mod_xm_b4)))));

		amstudent_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(amstudent_mod_dm_b1) / (1 + exp(amstudent_mod_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_notbest_src_time_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2)))),
										   pk_segment_2 = '2 Renter' => NULL,
																		NULL);

		ver_best_score_mod_rm_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_score_mod_rm_nodob_b3) / (1 + exp(ver_best_score_mod_rm_nodob_b3)))),
																		NULL);

		mod14_xm_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   (exp(mod14_xm_nodob_b4) / (1 + exp(mod14_xm_nodob_b4))));

		ver_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => ver_src_cnt_mod_om_b2,
								  pk_segment_2 = '2 Renter' => NULL,
															   NULL);

		ver_best_src_time_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4)))));

		amstudent_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(amstudent_mod_xm_b4) / (1 + exp(amstudent_mod_xm_b4)))));

		avm_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   (100 * (exp(avm_mod_xm_b4) / (1 + exp(avm_mod_xm_b4)))));

		distance_mod2_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(distance_mod2_xm_b4) / (1 + exp(distance_mod2_xm_b4)))));

		phnprob_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))),
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL);

		ver_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => ver_src_cnt_mod_rm_b3,
															   NULL);

		mod14_scr := map(pk_segment_2 = '0 Derog ' => round(((-40 * ((ln(((exp(mod14_dm_nodob_b1) / (1 + exp(mod14_dm_nodob_b1))) / (1 - (exp(mod14_dm_nodob_b1) / (1 + exp(mod14_dm_nodob_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
						 pk_segment_2 = '1 Owner ' => round(((-40 * ((ln(((exp(mod14_om_nodob_b2) / (1 + exp(mod14_om_nodob_b2))) / (1 - (exp(mod14_om_nodob_b2) / (1 + exp(mod14_om_nodob_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
						 pk_segment_2 = '2 Renter' => round(((-40 * ((ln(((exp(mod14_rm_nodob_b3) / (1 + exp(mod14_rm_nodob_b3))) / (1 - (exp(mod14_rm_nodob_b3) / (1 + exp(mod14_rm_nodob_b3)))))) - ln((1 / 20))) / ln(2))) + 700)),
													  round(((-40 * ((ln(((exp(mod14_xm_nodob_b4) / (1 + exp(mod14_xm_nodob_b4))) / (1 - (exp(mod14_xm_nodob_b4) / (1 + exp(mod14_xm_nodob_b4)))))) - ln((1 / 20))) / ln(2))) + 700)));

		lres_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))),
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														NULL);

		ver_best_src_time_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_src_time_mod_rm_b3) / (1 + exp(ver_best_src_time_mod_rm_b3)))),
																	 NULL);

		ver_notbest_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1)))),
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => NULL,
																	   NULL);

		mod14_rm_nodob := map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b3) / (1 + exp(mod14_rm_nodob_b3))),
														   NULL);

		property_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => (100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))),
							   pk_segment_2 = '2 Renter' => NULL,
															NULL);

		fp_mod5_dm_nodob := map(pk_segment_2 = '0 Derog ' => (100 * (exp(fp_mod5_dm_nodob_b1) / (1 + exp(fp_mod5_dm_nodob_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL);

		ver_src_time_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => NULL,
																ver_src_time_mod_xm_b4);

		lres_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '	' => NULL,
														(100 * (exp(lres_mod_xm_b4) / (1 + exp(lres_mod_xm_b4)))));

		RVT1003 := min(900, if(max(501, mod14_scr) = NULL, -NULL, max(501, mod14_scr)));

		ov_ssndead := (((integer)ssnlength > 0) and ((integer)rc_decsflag = 1));

		ov_ssnprior := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

		ov_criminal_flag := (criminal_count > 0);

		ov_corrections := ((integer)rc_hrisksic = 2225);

		ov_impulse := (impulse_count > 0);

		rvt1003_2 :=  if((RVT1003 > 680) and (ov_ssndead or (ov_ssnprior or (ov_criminal_flag or (ov_corrections or ov_impulse)))), 680, RVT1003);

		scored_222s := ((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) OR (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag > 0) or (ssn_deceased or truedid)))))));

		rvt1003_3 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvt1003_2);

		#if(RVT_DEBUG)
			self.seq := le.seq;
			self.did := did;
			self.truedid := truedid;
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_st := out_st;
			self.out_addr_type := out_addr_type;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnhighissue := rc_ssnhighissue;
			self.rc_areacodesplitflag := rc_areacodesplitflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_statezipflag := rc_statezipflag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_addrscore := combo_addrscore;
			self.combo_hphonescore := combo_hphonescore;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_addrcount := combo_addrcount;
			self.eq_count := eq_count;
			self.pr_count := pr_count;
			self.adl_eq_first_seen := adl_eq_first_seen;
			self.adl_en_first_seen := adl_en_first_seen;
			self.adl_pr_first_seen := adl_pr_first_seen;
			self.adl_em_first_seen := adl_em_first_seen;
			self.adl_vo_first_seen := adl_vo_first_seen;
			self.adl_em_only_first_seen := adl_em_only_first_seen;
			self.adl_w_first_seen := adl_w_first_seen;
			self.adl_w_last_seen := adl_w_last_seen;
			self.addr_sources := addr_sources;
			self.em_only_sources := em_only_sources;
			self.voter_avail := voter_avail;
			self.ssnlength := ssnlength;
			self.adl_score := adl_score;
			self.lname_score := lname_score;
			self.lname_change_date := lname_change_date;
			self.fname_eda_sourced_type := fname_eda_sourced_type;
			self.lname_eda_sourced := lname_eda_sourced;
			self.lname_eda_sourced_type := lname_eda_sourced_type;
			self.age := age;
			self.add1_address_score := add1_address_score;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_unit_count := add1_unit_count;
			self.add1_lres := add1_lres;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_recording_date := add1_avm_recording_date;
			self.add1_avm_assessed_value_year := add1_avm_assessed_value_year;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_automated_valuation_3 := add1_avm_automated_valuation_3;
			self.add1_avm_automated_valuation_4 := add1_avm_automated_valuation_4;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_built_date := add1_built_date;
			self.add1_purchase_amount := add1_purchase_amount;
			self.add1_mortgage_date := add1_mortgage_date;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_mortgage_due_date := add1_mortgage_due_date;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_land_use_code := add1_land_use_code;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_partial_baths := add1_no_of_partial_baths;
			self.add1_pop := add1_pop;
			self.property_owned_total := property_owned_total;
			self.property_owned_assessed_total := property_owned_assessed_total;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.prop1_sale_price := prop1_sale_price;
			self.prop2_sale_date := prop2_sale_date;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add2_address_score := add2_address_score;
			self.add2_lres := add2_lres;
			self.add2_avm_land_use := add2_avm_land_use;
			self.add2_avm_sales_price := add2_avm_sales_price;
			self.add2_avm_market_total_value := add2_avm_market_total_value;
			self.add2_avm_hedonic_valuation := add2_avm_hedonic_valuation;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_automated_valuation_3 := add2_avm_automated_valuation_3;
			self.add2_avm_automated_valuation_4 := add2_avm_automated_valuation_4;
			self.add2_sources := add2_sources;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add2_family_owned := add2_family_owned;
			self.add2_naprop := add2_naprop;
			self.add2_no_of_buildings := add2_no_of_buildings;
			self.add2_parking_no_of_cars := add2_parking_no_of_cars;
			self.add2_assessed_value_year := add2_assessed_value_year;
			self.add2_mortgage_type := add2_mortgage_type;
			self.add2_assessed_amount := add2_assessed_amount;
			self.add2_date_first_seen := add2_date_first_seen;
			self.add2_date_last_seen := add2_date_last_seen;
			self.add2_pop := add2_pop;
			self.add3_lres := add3_lres;
			self.add3_sources := add3_sources;
			self.add3_applicant_owned := add3_applicant_owned;
			self.add3_family_owned := add3_family_owned;
			self.add3_naprop := add3_naprop;
			self.add3_mortgage_type := add3_mortgage_type;
			self.add3_assessed_amount := add3_assessed_amount;
			self.add3_date_first_seen := add3_date_first_seen;
			self.add3_pop := add3_pop;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.addrs_prison_history := addrs_prison_history;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.nameperssn_count := nameperssn_count;
			self.credit_first_seen := credit_first_seen;
			self.header_first_seen := header_first_seen;
			self.inputssncharflag := inputssncharflag;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.phones_per_adl_c6 := phones_per_adl_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.invalid_ssns_per_adl_c6 := invalid_ssns_per_adl_c6;
			self.infutor_first_seen := infutor_first_seen;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_eviction_count30 := attr_eviction_count30;
			self.attr_eviction_count90 := attr_eviction_count90;
			self.attr_eviction_count180 := attr_eviction_count180;
			self.attr_eviction_count12 := attr_eviction_count12;
			self.attr_eviction_count24 := attr_eviction_count24;
			self.attr_eviction_count36 := attr_eviction_count36;
			self.attr_eviction_count60 := attr_eviction_count60;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.attr_num_proflic90 := attr_num_proflic90;
			self.attr_num_proflic_exp90 := attr_num_proflic_exp90;
			self.attr_num_proflic_exp12 := attr_num_proflic_exp12;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_type := filing_type;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_last_unrel_date := liens_last_unrel_date;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_unrel_ft_ct := liens_unrel_ft_ct;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_lt_first_seen := liens_unrel_lt_first_seen;
			self.liens_unrel_o_ct := liens_unrel_o_ct;
			self.liens_unrel_ot_ct := liens_unrel_ot_ct;
			self.liens_unrel_ot_first_seen := liens_unrel_ot_first_seen;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.watercraft_count := watercraft_count;
			self.ams_age := ams_age;
			self.ams_class := ams_class;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.reported_dob := reported_dob;
			self.archive_date := archive_date;
			self.sysdate := sysdate;
			self.sysyear := sysyear;
			self.rc_ssnhighissue2 := rc_ssnhighissue2;
			self.years_rc_ssnhighissue := years_rc_ssnhighissue;
			self.months_rc_ssnhighissue := months_rc_ssnhighissue;
			self.adl_eq_first_seen2 := adl_eq_first_seen2;
			self.years_adl_eq_first_seen := years_adl_eq_first_seen;
			self.months_adl_eq_first_seen := months_adl_eq_first_seen;
			self.adl_en_first_seen2 := adl_en_first_seen2;
			self.years_adl_en_first_seen := years_adl_en_first_seen;
			self.months_adl_en_first_seen := months_adl_en_first_seen;
			self.adl_pr_first_seen2 := adl_pr_first_seen2;
			self.years_adl_pr_first_seen := years_adl_pr_first_seen;
			self.months_adl_pr_first_seen := months_adl_pr_first_seen;
			self.adl_em_first_seen2 := adl_em_first_seen2;
			self.years_adl_em_first_seen := years_adl_em_first_seen;
			self.months_adl_em_first_seen := months_adl_em_first_seen;
			self.adl_vo_first_seen2 := adl_vo_first_seen2;
			self.years_adl_vo_first_seen := years_adl_vo_first_seen;
			self.months_adl_vo_first_seen := months_adl_vo_first_seen;
			self.adl_em_only_first_seen2 := adl_em_only_first_seen2;
			self.years_adl_em_only_first_seen := years_adl_em_only_first_seen;
			self.months_adl_em_only_first_seen := months_adl_em_only_first_seen;
			self.adl_w_first_seen2 := adl_w_first_seen2;
			self.years_adl_w_first_seen := years_adl_w_first_seen;
			self.months_adl_w_first_seen := months_adl_w_first_seen;
			self.adl_w_last_seen2 := adl_w_last_seen2;
			self.years_adl_w_last_seen := years_adl_w_last_seen;
			self.months_adl_w_last_seen := months_adl_w_last_seen;
			self.lname_change_date2 := lname_change_date2;
			self.years_lname_change_date := years_lname_change_date;
			self.months_lname_change_date := months_lname_change_date;
			self.add1_avm_recording_date2 := add1_avm_recording_date2;
			self.years_add1_avm_recording_date := years_add1_avm_recording_date;
			self.months_add1_avm_recording_date := months_add1_avm_recording_date;
			self.add1_built_date2 := add1_built_date2;
			self.years_add1_built_date := years_add1_built_date;
			self.months_add1_built_date := months_add1_built_date;
			self.add1_mortgage_date2 := add1_mortgage_date2;
			self.years_add1_mortgage_date := years_add1_mortgage_date;
			self.months_add1_mortgage_date := months_add1_mortgage_date;
			self.add1_mortgage_due_date2 := add1_mortgage_due_date2;
			self.years_add1_mortgage_due_date := years_add1_mortgage_due_date;
			self.months_add1_mortgage_due_date := months_add1_mortgage_due_date;
			self.add1_date_first_seen2 := add1_date_first_seen2;
			self.years_add1_date_first_seen := years_add1_date_first_seen;
			self.months_add1_date_first_seen := months_add1_date_first_seen;
			self.prop2_sale_date2 := prop2_sale_date2;
			self.years_prop2_sale_date := years_prop2_sale_date;
			self.months_prop2_sale_date := months_prop2_sale_date;
			self.add2_assessed_value_year2 := add2_assessed_value_year2;
			self.years_add2_assessed_value_year := years_add2_assessed_value_year;
			self.months_add2_assessed_value_year := months_add2_assessed_value_year;
			self.add2_date_first_seen2 := add2_date_first_seen2;
			self.years_add2_date_first_seen := years_add2_date_first_seen;
			self.months_add2_date_first_seen := months_add2_date_first_seen;
			self.add2_date_last_seen2 := add2_date_last_seen2;
			self.years_add2_date_last_seen := years_add2_date_last_seen;
			self.months_add2_date_last_seen := months_add2_date_last_seen;
			self.add3_date_first_seen2 := add3_date_first_seen2;
			self.years_add3_date_first_seen := years_add3_date_first_seen;
			self.months_add3_date_first_seen := months_add3_date_first_seen;
			self.gong_did_first_seen2 := gong_did_first_seen2;
			self.years_gong_did_first_seen := years_gong_did_first_seen;
			self.months_gong_did_first_seen := months_gong_did_first_seen;
			self.credit_first_seen2 := credit_first_seen2;
			self.years_credit_first_seen := years_credit_first_seen;
			self.months_credit_first_seen := months_credit_first_seen;
			self.header_first_seen2 := header_first_seen2;
			self.years_header_first_seen := years_header_first_seen;
			self.months_header_first_seen := months_header_first_seen;
			self.infutor_first_seen2 := infutor_first_seen2;
			self.years_infutor_first_seen := years_infutor_first_seen;
			self.months_infutor_first_seen := months_infutor_first_seen;
			self.date_last_seen2 := date_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.months_date_last_seen := months_date_last_seen;
			self.liens_last_unrel_date2 := liens_last_unrel_date2;
			self.years_liens_last_unrel_date := years_liens_last_unrel_date;
			self.months_liens_last_unrel_date := months_liens_last_unrel_date;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.months_liens_unrel_cj_last_seen := months_liens_unrel_cj_last_seen;
			self.liens_unrel_lt_first_seen2 := liens_unrel_lt_first_seen2;
			self.years_liens_unrel_lt_first_seen := years_liens_unrel_lt_first_seen;
			self.months_liens_unrel_lt_first_seen := months_liens_unrel_lt_first_seen;
			self.liens_unrel_ot_first_seen2 := liens_unrel_ot_first_seen2;
			self.years_liens_unrel_ot_first_seen := years_liens_unrel_ot_first_seen;
			self.months_liens_unrel_ot_first_seen := months_liens_unrel_ot_first_seen;
			self.reported_dob2 := reported_dob2;
			self.years_reported_dob := years_reported_dob;
			self.months_reported_dob := months_reported_dob;
			self.add1_avm_assessed_value_year2 := add1_avm_assessed_value_year2;
			self.years_add1_avm_assess_year := years_add1_avm_assess_year;
			self.months_add1_avm_assess_year := months_add1_avm_assess_year;
			self.source_tot_AK := source_tot_AK;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_AR := source_tot_AR;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_EB := source_tot_EB;
			self.source_tot_EM := source_tot_EM;
			self.source_tot_VO := source_tot_VO;
			self.source_tot_FF := source_tot_FF;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.source_tot_P := source_tot_P;
			self.source_tot_W := source_tot_W;
			self.source_tot_voter := source_tot_voter;
			self.source_add_P := source_add_P;
			self.source_add2_AK := source_add2_AK;
			self.source_add2_AM := source_add2_AM;
			self.source_add2_AR := source_add2_AR;
			self.source_add2_CG := source_add2_CG;
			self.source_add2_EB := source_add2_EB;
			self.source_add2_EM := source_add2_EM;
			self.source_add2_VO := source_add2_VO;
			self.source_add2_EQ := source_add2_EQ;
			self.source_add2_P := source_add2_P;
			self.source_add2_WP := source_add2_WP;
			self.source_add2_voter := source_add2_voter;
			self.source_add3_P := source_add3_P;
			self.em_only_source_EM := em_only_source_EM;
			self.em_only_source_E1 := em_only_source_E1;
			self.em_only_source_E2 := em_only_source_E2;
			self.em_only_source_E3 := em_only_source_E3;
			self.em_only_source_E4 := em_only_source_E4;
			self.years_adl_first_seen_max_fcra := years_adl_first_seen_max_fcra;
			self.months_adl_first_seen_max_fcra := months_adl_first_seen_max_fcra;
			self.add_apt := add_apt;
			self.phn_disconnected := phn_disconnected;
			self.phn_inval := phn_inval;
			self.phn_cellpager := phn_cellpager;
			self.phn_zipmismatch := phn_zipmismatch;
			self.ssn_deceased := ssn_deceased;
			self.ssn_adl_prob := ssn_adl_prob;
			self.bk_flag := bk_flag;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.lien_flag := lien_flag;
			self.crime_flag := crime_flag;
			self.crime_felony_flag := crime_felony_flag;
			self.crime_drug_flag := crime_drug_flag;
			self.add1_AVM_hit := add1_AVM_hit;
			self.add1_avm_med := add1_avm_med;
			self.add1_avm_to_med_ratio := add1_avm_to_med_ratio;
			self.add_lres_month_avg := add_lres_month_avg;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.pk_bk_level := pk_bk_level;
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
			self.Dist_mod := Dist_mod;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.adl_category_ord := adl_category_ord;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.pred_inc := pred_inc;
			self.estimated_income := estimated_income;
			self.estimated_income_2 := estimated_income_2;
			self.pk_ssnchar_invalid_or_recent := pk_ssnchar_invalid_or_recent;
			self.pk_did0 := pk_did0;
			self.pk_yr_adl_vo_first_seen := pk_yr_adl_vo_first_seen;
			self.pk_yr_adl_em_only_first_seen := pk_yr_adl_em_only_first_seen;
			self.pk_yr_adl_first_seen_max_fcra := pk_yr_adl_first_seen_max_fcra;
			self.pk_mo_adl_first_seen_max_fcra := pk_mo_adl_first_seen_max_fcra;
			self.pk_yr_lname_change_date := pk_yr_lname_change_date;
			self.pk_yr_gong_did_first_seen := pk_yr_gong_did_first_seen;
			self.pk_yr_credit_first_seen := pk_yr_credit_first_seen;
			self.pk_yr_header_first_seen := pk_yr_header_first_seen;
			self.pk_yr_infutor_first_seen := pk_yr_infutor_first_seen;
			self.pk_multi_did := pk_multi_did;
			self.pk_nas_summary := pk_nas_summary;
			self.pk_nap_summary := pk_nap_summary;
			self.pk_rc_dirsaddr_lastscore := pk_rc_dirsaddr_lastscore;
			self.pk_adl_score := pk_adl_score;
			self.pk_lname_score := pk_lname_score;
			self.pk_combo_addrscore := pk_combo_addrscore;
			self.pk_combo_hphonescore := pk_combo_hphonescore;
			self.pk_combo_ssnscore := pk_combo_ssnscore;
			self.pk_eq_count := pk_eq_count;
			self.pk_pos_secondary_sources := pk_pos_secondary_sources;
			self.pk_voter_flag := pk_voter_flag;
			self.pk_fname_eda_sourced_type_lvl := pk_fname_eda_sourced_type_lvl;
			self.pk_lname_eda_sourced_type_lvl := pk_lname_eda_sourced_type_lvl;
			self.pk_add1_address_score := pk_add1_address_score;
			self.pk_add1_unit_count2 := pk_add1_unit_count2;
			self.pk_add2_address_score := pk_add2_address_score;
			self.pk_add2_pos_sources := pk_add2_pos_sources;
			self.pk_add2_pos_secondary_sources := pk_add2_pos_secondary_sources;
			self.add2_source_EM := add2_source_EM;
			self.add2_source_E1 := add2_source_E1;
			self.add2_source_E2 := add2_source_E2;
			self.add2_source_E3 := add2_source_E3;
			self.add2_source_E4 := add2_source_E4;
			self.add3_source_EM := add3_source_EM;
			self.add3_source_E1 := add3_source_E1;
			self.add3_source_E2 := add3_source_E2;
			self.add3_source_E3 := add3_source_E3;
			self.add3_source_E4 := add3_source_E4;
			self.pk_em_only_ver_lvl := pk_em_only_ver_lvl;
			self.pk_add2_em_ver_lvl := pk_add2_em_ver_lvl;
			self.pk_ssnchar_invalid_or_recent_2 := pk_ssnchar_invalid_or_recent_2;
			self.pk_infutor_risk_lvl := pk_infutor_risk_lvl;
			self.pk_infutor_risk_lvl_nb := pk_infutor_risk_lvl_nb;
			self.pk_yr_adl_vo_first_seen2 := pk_yr_adl_vo_first_seen2;
			self.pk_yr_adl_em_only_first_seen2 := pk_yr_adl_em_only_first_seen2;
			self.pk_yrmo_adl_first_seen_max_fcra2 := pk_yrmo_adl_first_seen_max_fcra2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_nb := pk_yrmo_adl_f_sn_mx_fcra2_nb;
			self.pk_yr_lname_change_date2 := pk_yr_lname_change_date2;
			self.pk_yr_gong_did_first_seen2 := pk_yr_gong_did_first_seen2;
			self.pk_yr_credit_first_seen2 := pk_yr_credit_first_seen2;
			self.pk_yr_header_first_seen2 := pk_yr_header_first_seen2;
			self.pk_yr_infutor_first_seen2 := pk_yr_infutor_first_seen2;
			self.pk_estimated_income := pk_estimated_income;
			self.pk_yr_adl_w_last_seen := pk_yr_adl_w_last_seen;
			self.pk_yr_add1_built_date := pk_yr_add1_built_date;
			self.pk_yr_add1_mortgage_date := pk_yr_add1_mortgage_date;
			self.pk_yr_add1_mortgage_due_date := pk_yr_add1_mortgage_due_date;
			self.pk_yr_add1_date_first_seen := pk_yr_add1_date_first_seen;
			self.pk_yr_prop2_sale_date := pk_yr_prop2_sale_date;
			self.pk_yr_add2_assessed_value_year := pk_yr_add2_assessed_value_year;
			self.pk_yr_add2_date_first_seen := pk_yr_add2_date_first_seen;
			self.pk_yr_add2_date_last_seen := pk_yr_add2_date_last_seen;
			self.pk_yr_add3_date_first_seen := pk_yr_add3_date_first_seen;
			self.pk_property_owned_assessed_total := pk_property_owned_assessed_total;
			self.pk_prop1_sale_price := pk_prop1_sale_price;
			self.pk_add1_purchase_amount := pk_add1_purchase_amount;
			self.pk_add1_assessed_amount := pk_add1_assessed_amount;
			self.pk_add2_assessed_amount := pk_add2_assessed_amount;
			self.pk_add3_assessed_amount := pk_add3_assessed_amount;
			self.pk_property_owned_assessed_total_2 := pk_property_owned_assessed_total_2;
			self.pk_prop1_sale_price_2 := pk_prop1_sale_price_2;
			self.pk_add1_purchase_amount_2 := pk_add1_purchase_amount_2;
			self.pk_add1_assessed_amount_2 := pk_add1_assessed_amount_2;
			self.pk_add2_assessed_amount_2 := pk_add2_assessed_amount_2;
			self.pk_add3_assessed_amount_2 := pk_add3_assessed_amount_2;
			self.pk_add1_building_area := pk_add1_building_area;
			self.pk_yr_adl_w_last_seen2 := pk_yr_adl_w_last_seen2;
			self.pk_pr_count := pk_pr_count;
			self.pk_addrs_sourced_lvl := pk_addrs_sourced_lvl;
			self.pk_add1_own_level := pk_add1_own_level;
			self.pk_naprop_level := pk_naprop_level;
			self.pk_naprop_level2_b1 := pk_naprop_level2_b1;
			self.pk_naprop_level2 := pk_naprop_level2;
			self.pk_add2_own_level := pk_add2_own_level;
			self.pk_add3_own_level := pk_add3_own_level;
			self.pk_yr_add1_built_date2 := pk_yr_add1_built_date2;
			self.pk_add1_purchase_amount2 := pk_add1_purchase_amount2;
			self.pk_yr_add1_mortgage_date2 := pk_yr_add1_mortgage_date2;
			self.pk_add1_mortgage_risk := pk_add1_mortgage_risk;
			self.pk_add1_adjustable_financing := pk_add1_adjustable_financing;
			self.pk_add1_assessed_amount2 := pk_add1_assessed_amount2;
			self.pk_yr_add1_mortgage_due_date2 := pk_yr_add1_mortgage_due_date2;
			self.pk_yr_add1_date_first_seen2 := pk_yr_add1_date_first_seen2;
			self.pk_add1_land_use_cat := pk_add1_land_use_cat;
			self.pk_add1_land_use_risk_level := pk_add1_land_use_risk_level;
			self.pk_add1_building_area2 := pk_add1_building_area2;
			self.pk_add1_no_of_partial_baths := pk_add1_no_of_partial_baths;
			self.pk_property_owned_total := pk_property_owned_total;
			self.pk_prop_own_assess_tot2 := pk_prop_own_assess_tot2;
			self.pk_prop1_sale_price2 := pk_prop1_sale_price2;
			self.pk_yr_prop2_sale_date2 := pk_yr_prop2_sale_date2;
			self.pk_add2_no_of_buildings := pk_add2_no_of_buildings;
			self.pk_add2_parking_no_of_cars := pk_add2_parking_no_of_cars;
			self.pk_yr_add2_assessed_value_year2 := pk_yr_add2_assessed_value_year2;
			self.pk_add2_mortgage_risk := pk_add2_mortgage_risk;
			self.pk_add2_assessed_amount2 := pk_add2_assessed_amount2;
			self.pk_yr_add2_date_first_seen2 := pk_yr_add2_date_first_seen2;
			self.pk_yr_add2_date_last_seen2 := pk_yr_add2_date_last_seen2;
			self.pk_add3_mortgage_risk := pk_add3_mortgage_risk;
			self.pk_add3_assessed_amount2 := pk_add3_assessed_amount2;
			self.pk_yr_add3_date_first_seen2 := pk_yr_add3_date_first_seen2;
			self.pk_watercraft_count := pk_watercraft_count;
			self.pk_attr_num_watercraft60 := pk_attr_num_watercraft60;
			self.pk_yr_liens_last_unrel_date := pk_yr_liens_last_unrel_date;
			self.pk_yr_liens_unrel_lt_first_seen := pk_yr_liens_unrel_lt_first_seen;
			self.pk_yr_liens_unrel_ot_first_seen := pk_yr_liens_unrel_ot_first_seen;
			self.pk_bk_level_2 := pk_bk_level_2;
			self.pk_liens_unrel_cj_ct := pk_liens_unrel_cj_ct;
			self.pk_liens_unrel_ft_ct := pk_liens_unrel_ft_ct;
			self.pk_liens_unrel_lt_ct := pk_liens_unrel_lt_ct;
			self.pk_liens_unrel_o_ct := pk_liens_unrel_o_ct;
			self.pk_liens_unrel_ot_ct := pk_liens_unrel_ot_ct;
			self.pk_liens_unrel_sc_ct := pk_liens_unrel_sc_ct;
			self.pk_liens_unrel_count := pk_liens_unrel_count;
			self.pk_lien_type_level := pk_lien_type_level;
			self.pk_yr_liens_last_unrel_date2 := pk_yr_liens_last_unrel_date2;
			self.pk_yr_liens_last_unrel_date3 := pk_yr_liens_last_unrel_date3;
			self.pk_yr_liens_last_unrel_date3_2 := pk_yr_liens_last_unrel_date3_2;
			self.pk_yr_liens_unrel_lt_first_sn2 := pk_yr_liens_unrel_lt_first_sn2;
			self.pk_yr_liens_unrel_ot_first_sn2 := pk_yr_liens_unrel_ot_first_sn2;
			self.pk_attr_eviction_count := pk_attr_eviction_count;
			self.pk_eviction_level := pk_eviction_level;
			self.pk_crime_level := pk_crime_level;
			self.pk_attr_total_number_derogs_3 := pk_attr_total_number_derogs_3;
			self.pk_yr_rc_ssnhighissue := pk_yr_rc_ssnhighissue;
			self.pk_addr_not_valid := pk_addr_not_valid;
			self.pk_area_code_split := pk_area_code_split;
			self.pk_disconnected := pk_disconnected;
			self.pk_phn_cell_pager_inval := pk_phn_cell_pager_inval;
			self.pk_yr_rc_ssnhighissue2 := pk_yr_rc_ssnhighissue2;
			self.pk_prof_lic_cat := pk_prof_lic_cat;
			self.pk_attr_num_proflic90 := pk_attr_num_proflic90;
			self.pk_attr_num_proflic_exp90 := pk_attr_num_proflic_exp90;
			self.pk_attr_num_proflic_exp12 := pk_attr_num_proflic_exp12;
			self.pk_add_lres_month_avg := pk_add_lres_month_avg;
			self.pk_add1_lres := pk_add1_lres;
			self.pk_add2_lres := pk_add2_lres;
			self.pk_add3_lres := pk_add3_lres;
			self.pk_addrs_5yr := pk_addrs_5yr;
			self.pk_addrs_15yr := pk_addrs_15yr;
			self.pk_add_lres_month_avg2 := pk_add_lres_month_avg2;
			self.pk_nameperssn_count := pk_nameperssn_count;
			self.pk_ssns_per_adl := pk_ssns_per_adl;
			self.pk_addrs_per_adl := pk_addrs_per_adl;
			self.pk_phones_per_adl := pk_phones_per_adl;
			self.pk_adlperssn_count := pk_adlperssn_count;
			self.pk_addrs_per_ssn := pk_addrs_per_ssn;
			self.pk_adls_per_addr_b1 := pk_adls_per_addr_b1;
			self.pk_ssns_per_addr2_b1 := pk_ssns_per_addr2_b1;
			self.pk_phones_per_addr_b1 := pk_phones_per_addr_b1;
			self.pk_adls_per_addr_b2 := pk_adls_per_addr_b2;
			self.pk_ssns_per_addr2_b2 := pk_ssns_per_addr2_b2;
			self.pk_phones_per_addr_b2 := pk_phones_per_addr_b2;
			self.pk_phones_per_addr := pk_phones_per_addr;
			self.pk_adls_per_addr := pk_adls_per_addr;
			self.pk_ssns_per_addr2 := pk_ssns_per_addr2;
			self.pk_adls_per_phone := pk_adls_per_phone;
			self.pk_ssns_per_adl_c6 := pk_ssns_per_adl_c6;
			self.pk_addrs_per_adl_c6 := pk_addrs_per_adl_c6;
			self.pk_phones_per_adl_c6 := pk_phones_per_adl_c6;
			self.pk_ssns_per_addr_c6_b1 := pk_ssns_per_addr_c6_b1;
			self.pk_phones_per_addr_c6_b1 := pk_phones_per_addr_c6_b1;
			self.pk_ssns_per_addr_c6_b2 := pk_ssns_per_addr_c6_b2;
			self.pk_phones_per_addr_c6_b2 := pk_phones_per_addr_c6_b2;
			self.pk_ssns_per_addr_c6 := pk_ssns_per_addr_c6;
			self.pk_phones_per_addr_c6 := pk_phones_per_addr_c6;
			self.pk_adls_per_phone_c6 := pk_adls_per_phone_c6;
			self.pk_vo_addrs_per_adl := pk_vo_addrs_per_adl;
			self.pk_attr_addrs_last24 := pk_attr_addrs_last24;
			self.pk_attr_addrs_last36 := pk_attr_addrs_last36;
			self.pk_college_tier := pk_college_tier;
			self.ams_class_n_b8 := ams_class_n_b8;
			self.ams_class_n_b8_2 := ams_class_n_b8_2;
			self.pk_ams_class_level_b8 := pk_ams_class_level_b8;
			self.pk_since_ams_class_year := pk_since_ams_class_year;
			self.ams_class_n := ams_class_n;
			self.pk_ams_class_level := pk_ams_class_level;
			self.pk_ams_income_level_code := pk_ams_income_level_code;
			self.pk_yr_reported_dob := pk_yr_reported_dob;
			self.pk_ams_age := pk_ams_age;
			self.pk_inferred_age := pk_inferred_age;
			self.pk_yr_reported_dob2 := pk_yr_reported_dob2;
			self.pk_yr_add1_avm_recording_date := pk_yr_add1_avm_recording_date;
			self.pk_yr_add1_avm_assess_year := pk_yr_add1_avm_assess_year;
			self.pk_add1_avm_as := pk_add1_avm_as;
			self.pk_add1_avm_mkt := pk_add1_avm_mkt;
			self.pk_add1_avm_hed := pk_add1_avm_hed;
			self.pk_add1_avm_auto := pk_add1_avm_auto;
			self.pk_add1_avm_auto2 := pk_add1_avm_auto2;
			self.pk_add1_avm_auto3 := pk_add1_avm_auto3;
			self.pk_add1_avm_auto4 := pk_add1_avm_auto4;
			self.pk_add1_avm_med := pk_add1_avm_med;
			self.pk_add2_avm_sp := pk_add2_avm_sp;
			self.pk_add2_avm_mkt := pk_add2_avm_mkt;
			self.pk_add2_avm_hed := pk_add2_avm_hed;
			self.pk_add2_avm_auto := pk_add2_avm_auto;
			self.pk_add2_avm_auto3 := pk_add2_avm_auto3;
			self.pk_add2_avm_auto4 := pk_add2_avm_auto4;
			self.pk_add1_avm_as_2 := pk_add1_avm_as_2;
			self.pk_add1_avm_mkt_2 := pk_add1_avm_mkt_2;
			self.pk_add1_avm_hed_2 := pk_add1_avm_hed_2;
			self.pk_add1_avm_auto_2 := pk_add1_avm_auto_2;
			self.pk_add1_avm_auto2_2 := pk_add1_avm_auto2_2;
			self.pk_add1_avm_auto3_2 := pk_add1_avm_auto3_2;
			self.pk_add1_avm_auto4_2 := pk_add1_avm_auto4_2;
			self.pk_add1_avm_med_2 := pk_add1_avm_med_2;
			self.pk_add2_avm_sp_2 := pk_add2_avm_sp_2;
			self.pk_add2_avm_mkt_2 := pk_add2_avm_mkt_2;
			self.pk_add2_avm_hed_2 := pk_add2_avm_hed_2;
			self.pk_add2_avm_auto_2 := pk_add2_avm_auto_2;
			self.pk_add2_avm_auto3_2 := pk_add2_avm_auto3_2;
			self.pk_add2_avm_auto4_2 := pk_add2_avm_auto4_2;
			self.pk_add1_avm_to_med_ratio := pk_add1_avm_to_med_ratio;
			self.pk_add1_avm_to_med_ratio_2 := pk_add1_avm_to_med_ratio_2;
			self.pk2_add1_avm_as := pk2_add1_avm_as;
			self.pk2_add1_avm_mkt := pk2_add1_avm_mkt;
			self.pk2_add1_avm_hed := pk2_add1_avm_hed;
			self.pk2_add1_avm_auto := pk2_add1_avm_auto;
			self.pk2_add1_avm_auto2 := pk2_add1_avm_auto2;
			self.pk2_add1_avm_auto3 := pk2_add1_avm_auto3;
			self.pk2_add1_avm_auto4 := pk2_add1_avm_auto4;
			self.pk_avm_auto_diff4 := pk_avm_auto_diff4;
			self.pk_avm_auto_diff4_lvl := pk_avm_auto_diff4_lvl;
			self.pk2_add1_avm_med := pk2_add1_avm_med;
			self.pk2_add1_avm_to_med_ratio := pk2_add1_avm_to_med_ratio;
			self.pk_add2_avm_hit := pk_add2_avm_hit;
			self.pk_avm_hit_level := pk_avm_hit_level;
			self.pk2_add2_avm_sp := pk2_add2_avm_sp;
			self.pk2_add2_avm_mkt := pk2_add2_avm_mkt;
			self.pk2_add2_avm_hed := pk2_add2_avm_hed;
			self.pk2_add2_avm_auto := pk2_add2_avm_auto;
			self.pk2_add2_avm_auto3 := pk2_add2_avm_auto3;
			self.pk2_add2_avm_auto4 := pk2_add2_avm_auto4;
			self.pk_add2_avm_auto_diff3 := pk_add2_avm_auto_diff3;
			self.pk_add2_avm_auto_diff3_lvl := pk_add2_avm_auto_diff3_lvl;
			self.pk2_yr_add1_avm_recording_date := pk2_yr_add1_avm_recording_date;
			self.pk2_yr_add1_avm_assess_year := pk2_yr_add1_avm_assess_year;
			self.pk_dist_a1toa2_2 := pk_dist_a1toa2_2;
			self.pk_dist_a1toa3_2 := pk_dist_a1toa3_2;
			self.pk_rc_disthphoneaddr_2 := pk_rc_disthphoneaddr_2;
			self.pk_out_st_division_lvl := pk_out_st_division_lvl;
			self.pk_wealth_index_2 := pk_wealth_index_2;
			self.pk_impulse_count := pk_impulse_count;
			self.pk_impulse_count_2 := pk_impulse_count_2;
			self.pk_attr_total_number_derogs_4 := pk_attr_total_number_derogs_4;
			self.pk_attr_total_number_derogs_5 := pk_attr_total_number_derogs_5;
			self.pk_attr_num_nonderogs90_3 := pk_attr_num_nonderogs90_3;
			self.pk_attr_num_nonderogs90_4 := pk_attr_num_nonderogs90_4;
			self.pk_derog_total_2 := pk_derog_total_2;
			self.pk_attr_num_nonderogs90_b := pk_attr_num_nonderogs90_b;
			self.pk_adl_cat_deceased := pk_adl_cat_deceased;
			self.bs_own_rent := bs_own_rent;
			self.bs_attr_derog_flag := bs_attr_derog_flag;
			self.bs_attr_eviction_flag := bs_attr_eviction_flag;
			self.bs_attr_derog_flag2 := bs_attr_derog_flag2;
			self.pk_Segment := pk_Segment;
			self.pk_segment_2 := pk_segment_2;
			self.pk_nas_summary_mm_b1_c2_b1 := pk_nas_summary_mm_b1_c2_b1;
			self.pk_nap_summary_mm_b1_c2_b1 := pk_nap_summary_mm_b1_c2_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
			self.pk_adl_score_mm_b1_c2_b1 := pk_adl_score_mm_b1_c2_b1;
			self.pk_lname_score_mm_b1_c2_b1 := pk_lname_score_mm_b1_c2_b1;
			self.pk_combo_addrscore_mm_b1_c2_b1 := pk_combo_addrscore_mm_b1_c2_b1;
			self.pk_combo_hphonescore_mm_b1_c2_b1 := pk_combo_hphonescore_mm_b1_c2_b1;
			self.pk_combo_ssnscore_mm_b1_c2_b1 := pk_combo_ssnscore_mm_b1_c2_b1;
			self.pk_eq_count_mm_b1_c2_b1 := pk_eq_count_mm_b1_c2_b1;
			self.pk_pos_secondary_sources_mm_b1_c2_b1 := pk_pos_secondary_sources_mm_b1_c2_b1;
			self.pk_voter_flag_mm_b1_c2_b1 := pk_voter_flag_mm_b1_c2_b1;
			self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
			self.pk_add1_address_score_mm_b1_c2_b1 := pk_add1_address_score_mm_b1_c2_b1;
			self.pk_add2_address_score_mm_b1_c2_b1 := pk_add2_address_score_mm_b1_c2_b1;
			self.pk_add2_pos_sources_mm_b1_c2_b1 := pk_add2_pos_sources_mm_b1_c2_b1;
			self.pk_add2_pos_secondary_sources_mm_b1_c2_b1 := pk_add2_pos_secondary_sources_mm_b1_c2_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
			self.pk_infutor_risk_lvl_mm_b1_c2_b1 := pk_infutor_risk_lvl_mm_b1_c2_b1;
			self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b1 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
			self.pk_yr_lname_change_date2_mm_b1_c2_b1 := pk_yr_lname_change_date2_mm_b1_c2_b1;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
			self.pk_yr_credit_first_seen2_mm_b1_c2_b1 := pk_yr_credit_first_seen2_mm_b1_c2_b1;
			self.pk_yr_header_first_seen2_mm_b1_c2_b1 := pk_yr_header_first_seen2_mm_b1_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b1 := pk_yr_infutor_first_seen2_mm_b1_c2_b1;
			self.pk_em_only_ver_lvl_mm_b1_c2_b1 := pk_em_only_ver_lvl_mm_b1_c2_b1;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b1 := pk_add2_em_ver_lvl_mm_b1_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
			self.pk_nas_summary_mm_b1_c2_b2 := pk_nas_summary_mm_b1_c2_b2;
			self.pk_nap_summary_mm_b1_c2_b2 := pk_nap_summary_mm_b1_c2_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
			self.pk_adl_score_mm_b1_c2_b2 := pk_adl_score_mm_b1_c2_b2;
			self.pk_lname_score_mm_b1_c2_b2 := pk_lname_score_mm_b1_c2_b2;
			self.pk_combo_addrscore_mm_b1_c2_b2 := pk_combo_addrscore_mm_b1_c2_b2;
			self.pk_combo_hphonescore_mm_b1_c2_b2 := pk_combo_hphonescore_mm_b1_c2_b2;
			self.pk_combo_ssnscore_mm_b1_c2_b2 := pk_combo_ssnscore_mm_b1_c2_b2;
			self.pk_eq_count_mm_b1_c2_b2 := pk_eq_count_mm_b1_c2_b2;
			self.pk_pos_secondary_sources_mm_b1_c2_b2 := pk_pos_secondary_sources_mm_b1_c2_b2;
			self.pk_voter_flag_mm_b1_c2_b2 := pk_voter_flag_mm_b1_c2_b2;
			self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
			self.pk_add1_address_score_mm_b1_c2_b2 := pk_add1_address_score_mm_b1_c2_b2;
			self.pk_add2_address_score_mm_b1_c2_b2 := pk_add2_address_score_mm_b1_c2_b2;
			self.pk_add2_pos_sources_mm_b1_c2_b2 := pk_add2_pos_sources_mm_b1_c2_b2;
			self.pk_add2_pos_secondary_sources_mm_b1_c2_b2 := pk_add2_pos_secondary_sources_mm_b1_c2_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
			self.pk_infutor_risk_lvl_mm_b1_c2_b2 := pk_infutor_risk_lvl_mm_b1_c2_b2;
			self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b2 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
			self.pk_yr_lname_change_date2_mm_b1_c2_b2 := pk_yr_lname_change_date2_mm_b1_c2_b2;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
			self.pk_yr_credit_first_seen2_mm_b1_c2_b2 := pk_yr_credit_first_seen2_mm_b1_c2_b2;
			self.pk_yr_header_first_seen2_mm_b1_c2_b2 := pk_yr_header_first_seen2_mm_b1_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b2 := pk_yr_infutor_first_seen2_mm_b1_c2_b2;
			self.pk_em_only_ver_lvl_mm_b1_c2_b2 := pk_em_only_ver_lvl_mm_b1_c2_b2;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b2 := pk_add2_em_ver_lvl_mm_b1_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
			self.pk_nas_summary_mm_b1_c2_b3 := pk_nas_summary_mm_b1_c2_b3;
			self.pk_nap_summary_mm_b1_c2_b3 := pk_nap_summary_mm_b1_c2_b3;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
			self.pk_adl_score_mm_b1_c2_b3 := pk_adl_score_mm_b1_c2_b3;
			self.pk_lname_score_mm_b1_c2_b3 := pk_lname_score_mm_b1_c2_b3;
			self.pk_combo_addrscore_mm_b1_c2_b3 := pk_combo_addrscore_mm_b1_c2_b3;
			self.pk_combo_hphonescore_mm_b1_c2_b3 := pk_combo_hphonescore_mm_b1_c2_b3;
			self.pk_combo_ssnscore_mm_b1_c2_b3 := pk_combo_ssnscore_mm_b1_c2_b3;
			self.pk_eq_count_mm_b1_c2_b3 := pk_eq_count_mm_b1_c2_b3;
			self.pk_pos_secondary_sources_mm_b1_c2_b3 := pk_pos_secondary_sources_mm_b1_c2_b3;
			self.pk_voter_flag_mm_b1_c2_b3 := pk_voter_flag_mm_b1_c2_b3;
			self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3;
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
			self.pk_add1_address_score_mm_b1_c2_b3 := pk_add1_address_score_mm_b1_c2_b3;
			self.pk_add2_address_score_mm_b1_c2_b3 := pk_add2_address_score_mm_b1_c2_b3;
			self.pk_add2_pos_sources_mm_b1_c2_b3 := pk_add2_pos_sources_mm_b1_c2_b3;
			self.pk_add2_pos_secondary_sources_mm_b1_c2_b3 := pk_add2_pos_secondary_sources_mm_b1_c2_b3;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
			self.pk_infutor_risk_lvl_mm_b1_c2_b3 := pk_infutor_risk_lvl_mm_b1_c2_b3;
			self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b3 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b3;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
			self.pk_yr_lname_change_date2_mm_b1_c2_b3 := pk_yr_lname_change_date2_mm_b1_c2_b3;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
			self.pk_yr_credit_first_seen2_mm_b1_c2_b3 := pk_yr_credit_first_seen2_mm_b1_c2_b3;
			self.pk_yr_header_first_seen2_mm_b1_c2_b3 := pk_yr_header_first_seen2_mm_b1_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b3 := pk_yr_infutor_first_seen2_mm_b1_c2_b3;
			self.pk_em_only_ver_lvl_mm_b1_c2_b3 := pk_em_only_ver_lvl_mm_b1_c2_b3;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b3 := pk_add2_em_ver_lvl_mm_b1_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
			self.pk_nas_summary_mm_b1_c2_b4 := pk_nas_summary_mm_b1_c2_b4;
			self.pk_nap_summary_mm_b1_c2_b4 := pk_nap_summary_mm_b1_c2_b4;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b4 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b4;
			self.pk_adl_score_mm_b1_c2_b4 := pk_adl_score_mm_b1_c2_b4;
			self.pk_lname_score_mm_b1_c2_b4 := pk_lname_score_mm_b1_c2_b4;
			self.pk_combo_addrscore_mm_b1_c2_b4 := pk_combo_addrscore_mm_b1_c2_b4;
			self.pk_combo_hphonescore_mm_b1_c2_b4 := pk_combo_hphonescore_mm_b1_c2_b4;
			self.pk_combo_ssnscore_mm_b1_c2_b4 := pk_combo_ssnscore_mm_b1_c2_b4;
			self.pk_eq_count_mm_b1_c2_b4 := pk_eq_count_mm_b1_c2_b4;
			self.pk_pos_secondary_sources_mm_b1_c2_b4 := pk_pos_secondary_sources_mm_b1_c2_b4;
			self.pk_voter_flag_mm_b1_c2_b4 := pk_voter_flag_mm_b1_c2_b4;
			self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b4 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b4;
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4;
			self.pk_add1_address_score_mm_b1_c2_b4 := pk_add1_address_score_mm_b1_c2_b4;
			self.pk_add2_address_score_mm_b1_c2_b4 := pk_add2_address_score_mm_b1_c2_b4;
			self.pk_add2_pos_sources_mm_b1_c2_b4 := pk_add2_pos_sources_mm_b1_c2_b4;
			self.pk_add2_pos_secondary_sources_mm_b1_c2_b4 := pk_add2_pos_secondary_sources_mm_b1_c2_b4;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b4 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b4;
			self.pk_infutor_risk_lvl_mm_b1_c2_b4 := pk_infutor_risk_lvl_mm_b1_c2_b4;
			self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b4 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b4;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4;
			self.pk_yr_lname_change_date2_mm_b1_c2_b4 := pk_yr_lname_change_date2_mm_b1_c2_b4;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b4 := pk_yr_gong_did_first_seen2_mm_b1_c2_b4;
			self.pk_yr_credit_first_seen2_mm_b1_c2_b4 := pk_yr_credit_first_seen2_mm_b1_c2_b4;
			self.pk_yr_header_first_seen2_mm_b1_c2_b4 := pk_yr_header_first_seen2_mm_b1_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b4 := pk_yr_infutor_first_seen2_mm_b1_c2_b4;
			self.pk_em_only_ver_lvl_mm_b1_c2_b4 := pk_em_only_ver_lvl_mm_b1_c2_b4;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b4 := pk_add2_em_ver_lvl_mm_b1_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
			self.pk_nap_summary_mm_b1 := pk_nap_summary_mm_b1;
			self.pk_yr_gong_did_first_seen2_mm_b1 := pk_yr_gong_did_first_seen2_mm_b1;
			self.pk_add2_pos_secondary_sources_mm_b1 := pk_add2_pos_secondary_sources_mm_b1;
			self.pk_nas_summary_mm_b1 := pk_nas_summary_mm_b1;
			self.pk_yr_infutor_first_seen2_mm_b1 := pk_yr_infutor_first_seen2_mm_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b1 := pk_yr_adl_em_only_first_seen2_mm_b1;
			self.pk_combo_hphonescore_mm_b1 := pk_combo_hphonescore_mm_b1;
			self.pk_lname_score_mm_b1 := pk_lname_score_mm_b1;
			self.pk_yr_lname_change_date2_mm_b1 := pk_yr_lname_change_date2_mm_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b1 := pk_ssnchar_invalid_or_recent_mm_b1;
			self.pk_add2_em_ver_lvl_mm_b1 := pk_add2_em_ver_lvl_mm_b1;
			self.pk_yr_credit_first_seen2_mm_b1 := pk_yr_credit_first_seen2_mm_b1;
			self.pk_adl_score_mm_b1 := pk_adl_score_mm_b1;
			self.pk_yr_header_first_seen2_mm_b1 := pk_yr_header_first_seen2_mm_b1;
			self.pk_eq_count_mm_b1 := pk_eq_count_mm_b1;
			self.pk_em_only_ver_lvl_mm_b1 := pk_em_only_ver_lvl_mm_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b1 := pk_rc_dirsaddr_lastscore_mm_b1;
			self.pk_add1_address_score_mm_b1 := pk_add1_address_score_mm_b1;
			self.pk_yr_adl_vo_first_seen2_mm_b1 := pk_yr_adl_vo_first_seen2_mm_b1;
			self.pk_pos_secondary_sources_mm_b1 := pk_pos_secondary_sources_mm_b1;
			self.pk_combo_addrscore_mm_b1 := pk_combo_addrscore_mm_b1;
			self.pk_voter_flag_mm_b1 := pk_voter_flag_mm_b1;
			self.pk_combo_ssnscore_mm_b1 := pk_combo_ssnscore_mm_b1;
			self.pk_add2_address_score_mm_b1 := pk_add2_address_score_mm_b1;
			self.pk_add2_pos_sources_mm_b1 := pk_add2_pos_sources_mm_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
			self.pk_fname_eda_sourced_type_lvl_mm_b1 := pk_fname_eda_sourced_type_lvl_mm_b1;
			self.pk_infutor_risk_lvl_mm_b1 := pk_infutor_risk_lvl_mm_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b1 := pk_lname_eda_sourced_type_lvl_mm_b1;
			self.pk_nas_summary_mm_b2_c2_b1 := pk_nas_summary_mm_b2_c2_b1;
			self.pk_nap_summary_mm_b2_c2_b1 := pk_nap_summary_mm_b2_c2_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
			self.pk_adl_score_mm_b2_c2_b1 := pk_adl_score_mm_b2_c2_b1;
			self.pk_lname_score_mm_b2_c2_b1 := pk_lname_score_mm_b2_c2_b1;
			self.pk_combo_addrscore_mm_b2_c2_b1 := pk_combo_addrscore_mm_b2_c2_b1;
			self.pk_combo_hphonescore_mm_b2_c2_b1 := pk_combo_hphonescore_mm_b2_c2_b1;
			self.pk_combo_ssnscore_mm_b2_c2_b1 := pk_combo_ssnscore_mm_b2_c2_b1;
			self.pk_eq_count_mm_b2_c2_b1 := pk_eq_count_mm_b2_c2_b1;
			self.pk_pos_secondary_sources_mm_b2_c2_b1 := pk_pos_secondary_sources_mm_b2_c2_b1;
			self.pk_voter_flag_mm_b2_c2_b1 := pk_voter_flag_mm_b2_c2_b1;
			self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
			self.pk_add1_address_score_mm_b2_c2_b1 := pk_add1_address_score_mm_b2_c2_b1;
			self.pk_add2_address_score_mm_b2_c2_b1 := pk_add2_address_score_mm_b2_c2_b1;
			self.pk_add2_pos_sources_mm_b2_c2_b1 := pk_add2_pos_sources_mm_b2_c2_b1;
			self.pk_add2_pos_secondary_sources_mm_b2_c2_b1 := pk_add2_pos_secondary_sources_mm_b2_c2_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
			self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b1 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
			self.pk_yr_lname_change_date2_mm_b2_c2_b1 := pk_yr_lname_change_date2_mm_b2_c2_b1;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
			self.pk_yr_credit_first_seen2_mm_b2_c2_b1 := pk_yr_credit_first_seen2_mm_b2_c2_b1;
			self.pk_yr_header_first_seen2_mm_b2_c2_b1 := pk_yr_header_first_seen2_mm_b2_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b1 := pk_yr_infutor_first_seen2_mm_b2_c2_b1;
			self.pk_em_only_ver_lvl_mm_b2_c2_b1 := pk_em_only_ver_lvl_mm_b2_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
			self.pk_nas_summary_mm_b2_c2_b2 := pk_nas_summary_mm_b2_c2_b2;
			self.pk_nap_summary_mm_b2_c2_b2 := pk_nap_summary_mm_b2_c2_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
			self.pk_adl_score_mm_b2_c2_b2 := pk_adl_score_mm_b2_c2_b2;
			self.pk_lname_score_mm_b2_c2_b2 := pk_lname_score_mm_b2_c2_b2;
			self.pk_combo_addrscore_mm_b2_c2_b2 := pk_combo_addrscore_mm_b2_c2_b2;
			self.pk_combo_hphonescore_mm_b2_c2_b2 := pk_combo_hphonescore_mm_b2_c2_b2;
			self.pk_combo_ssnscore_mm_b2_c2_b2 := pk_combo_ssnscore_mm_b2_c2_b2;
			self.pk_eq_count_mm_b2_c2_b2 := pk_eq_count_mm_b2_c2_b2;
			self.pk_pos_secondary_sources_mm_b2_c2_b2 := pk_pos_secondary_sources_mm_b2_c2_b2;
			self.pk_voter_flag_mm_b2_c2_b2 := pk_voter_flag_mm_b2_c2_b2;
			self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
			self.pk_add1_address_score_mm_b2_c2_b2 := pk_add1_address_score_mm_b2_c2_b2;
			self.pk_add2_address_score_mm_b2_c2_b2 := pk_add2_address_score_mm_b2_c2_b2;
			self.pk_add2_pos_sources_mm_b2_c2_b2 := pk_add2_pos_sources_mm_b2_c2_b2;
			self.pk_add2_pos_secondary_sources_mm_b2_c2_b2 := pk_add2_pos_secondary_sources_mm_b2_c2_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
			self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b2 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
			self.pk_yr_lname_change_date2_mm_b2_c2_b2 := pk_yr_lname_change_date2_mm_b2_c2_b2;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
			self.pk_yr_credit_first_seen2_mm_b2_c2_b2 := pk_yr_credit_first_seen2_mm_b2_c2_b2;
			self.pk_yr_header_first_seen2_mm_b2_c2_b2 := pk_yr_header_first_seen2_mm_b2_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b2 := pk_yr_infutor_first_seen2_mm_b2_c2_b2;
			self.pk_em_only_ver_lvl_mm_b2_c2_b2 := pk_em_only_ver_lvl_mm_b2_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
			self.pk_nas_summary_mm_b2_c2_b3 := pk_nas_summary_mm_b2_c2_b3;
			self.pk_nap_summary_mm_b2_c2_b3 := pk_nap_summary_mm_b2_c2_b3;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
			self.pk_adl_score_mm_b2_c2_b3 := pk_adl_score_mm_b2_c2_b3;
			self.pk_lname_score_mm_b2_c2_b3 := pk_lname_score_mm_b2_c2_b3;
			self.pk_combo_addrscore_mm_b2_c2_b3 := pk_combo_addrscore_mm_b2_c2_b3;
			self.pk_combo_hphonescore_mm_b2_c2_b3 := pk_combo_hphonescore_mm_b2_c2_b3;
			self.pk_combo_ssnscore_mm_b2_c2_b3 := pk_combo_ssnscore_mm_b2_c2_b3;
			self.pk_eq_count_mm_b2_c2_b3 := pk_eq_count_mm_b2_c2_b3;
			self.pk_pos_secondary_sources_mm_b2_c2_b3 := pk_pos_secondary_sources_mm_b2_c2_b3;
			self.pk_voter_flag_mm_b2_c2_b3 := pk_voter_flag_mm_b2_c2_b3;
			self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
			self.pk_add1_address_score_mm_b2_c2_b3 := pk_add1_address_score_mm_b2_c2_b3;
			self.pk_add2_address_score_mm_b2_c2_b3 := pk_add2_address_score_mm_b2_c2_b3;
			self.pk_add2_pos_sources_mm_b2_c2_b3 := pk_add2_pos_sources_mm_b2_c2_b3;
			self.pk_add2_pos_secondary_sources_mm_b2_c2_b3 := pk_add2_pos_secondary_sources_mm_b2_c2_b3;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
			self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b3 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b3;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
			self.pk_yr_lname_change_date2_mm_b2_c2_b3 := pk_yr_lname_change_date2_mm_b2_c2_b3;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
			self.pk_yr_credit_first_seen2_mm_b2_c2_b3 := pk_yr_credit_first_seen2_mm_b2_c2_b3;
			self.pk_yr_header_first_seen2_mm_b2_c2_b3 := pk_yr_header_first_seen2_mm_b2_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b3 := pk_yr_infutor_first_seen2_mm_b2_c2_b3;
			self.pk_em_only_ver_lvl_mm_b2_c2_b3 := pk_em_only_ver_lvl_mm_b2_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
			self.pk_nas_summary_mm_b2_c2_b4 := pk_nas_summary_mm_b2_c2_b4;
			self.pk_nap_summary_mm_b2_c2_b4 := pk_nap_summary_mm_b2_c2_b4;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b4 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b4;
			self.pk_adl_score_mm_b2_c2_b4 := pk_adl_score_mm_b2_c2_b4;
			self.pk_lname_score_mm_b2_c2_b4 := pk_lname_score_mm_b2_c2_b4;
			self.pk_combo_addrscore_mm_b2_c2_b4 := pk_combo_addrscore_mm_b2_c2_b4;
			self.pk_combo_hphonescore_mm_b2_c2_b4 := pk_combo_hphonescore_mm_b2_c2_b4;
			self.pk_combo_ssnscore_mm_b2_c2_b4 := pk_combo_ssnscore_mm_b2_c2_b4;
			self.pk_eq_count_mm_b2_c2_b4 := pk_eq_count_mm_b2_c2_b4;
			self.pk_pos_secondary_sources_mm_b2_c2_b4 := pk_pos_secondary_sources_mm_b2_c2_b4;
			self.pk_voter_flag_mm_b2_c2_b4 := pk_voter_flag_mm_b2_c2_b4;
			self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b4 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b4;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4;
			self.pk_add1_address_score_mm_b2_c2_b4 := pk_add1_address_score_mm_b2_c2_b4;
			self.pk_add2_address_score_mm_b2_c2_b4 := pk_add2_address_score_mm_b2_c2_b4;
			self.pk_add2_pos_sources_mm_b2_c2_b4 := pk_add2_pos_sources_mm_b2_c2_b4;
			self.pk_add2_pos_secondary_sources_mm_b2_c2_b4 := pk_add2_pos_secondary_sources_mm_b2_c2_b4;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b4 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b4;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b4 := pk_infutor_risk_lvl_nb_mm_b2_c2_b4;
			self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b4 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b4;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4;
			self.pk_yr_lname_change_date2_mm_b2_c2_b4 := pk_yr_lname_change_date2_mm_b2_c2_b4;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b4 := pk_yr_gong_did_first_seen2_mm_b2_c2_b4;
			self.pk_yr_credit_first_seen2_mm_b2_c2_b4 := pk_yr_credit_first_seen2_mm_b2_c2_b4;
			self.pk_yr_header_first_seen2_mm_b2_c2_b4 := pk_yr_header_first_seen2_mm_b2_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b4 := pk_yr_infutor_first_seen2_mm_b2_c2_b4;
			self.pk_em_only_ver_lvl_mm_b2_c2_b4 := pk_em_only_ver_lvl_mm_b2_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
			self.pk_nap_summary_mm_b2 := pk_nap_summary_mm_b2;
			self.pk_yr_gong_did_first_seen2_mm_b2 := pk_yr_gong_did_first_seen2_mm_b2;
			self.pk_add2_pos_secondary_sources_mm_b2 := pk_add2_pos_secondary_sources_mm_b2;
			self.pk_nas_summary_mm_b2 := pk_nas_summary_mm_b2;
			self.pk_yr_infutor_first_seen2_mm_b2 := pk_yr_infutor_first_seen2_mm_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b2 := pk_yr_adl_em_only_first_seen2_mm_b2;
			self.pk_combo_hphonescore_mm_b2 := pk_combo_hphonescore_mm_b2;
			self.pk_lname_score_mm_b2 := pk_lname_score_mm_b2;
			self.pk_yr_lname_change_date2_mm_b2 := pk_yr_lname_change_date2_mm_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b2 := pk_ssnchar_invalid_or_recent_mm_b2;
			self.pk_infutor_risk_lvl_nb_mm_b2 := pk_infutor_risk_lvl_nb_mm_b2;
			self.pk_yr_credit_first_seen2_mm_b2 := pk_yr_credit_first_seen2_mm_b2;
			self.pk_adl_score_mm_b2 := pk_adl_score_mm_b2;
			self.pk_yr_header_first_seen2_mm_b2 := pk_yr_header_first_seen2_mm_b2;
			self.pk_eq_count_mm_b2 := pk_eq_count_mm_b2;
			self.pk_em_only_ver_lvl_mm_b2 := pk_em_only_ver_lvl_mm_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b2 := pk_rc_dirsaddr_lastscore_mm_b2;
			self.pk_add1_address_score_mm_b2 := pk_add1_address_score_mm_b2;
			self.pk_yr_adl_vo_first_seen2_mm_b2 := pk_yr_adl_vo_first_seen2_mm_b2;
			self.pk_pos_secondary_sources_mm_b2 := pk_pos_secondary_sources_mm_b2;
			self.pk_combo_addrscore_mm_b2 := pk_combo_addrscore_mm_b2;
			self.pk_voter_flag_mm_b2 := pk_voter_flag_mm_b2;
			self.pk_combo_ssnscore_mm_b2 := pk_combo_ssnscore_mm_b2;
			self.pk_add2_address_score_mm_b2 := pk_add2_address_score_mm_b2;
			self.pk_add2_pos_sources_mm_b2 := pk_add2_pos_sources_mm_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
			self.pk_fname_eda_sourced_type_lvl_mm_b2 := pk_fname_eda_sourced_type_lvl_mm_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b2 := pk_lname_eda_sourced_type_lvl_mm_b2;
			self.pk_nap_summary_mm := pk_nap_summary_mm;
			self.pk_yr_gong_did_first_seen2_mm := pk_yr_gong_did_first_seen2_mm;
			self.pk_add2_pos_secondary_sources_mm := pk_add2_pos_secondary_sources_mm;
			self.pk_nas_summary_mm := pk_nas_summary_mm;
			self.pk_yr_infutor_first_seen2_mm := pk_yr_infutor_first_seen2_mm;
			self.pk_yr_adl_em_only_first_seen2_mm := pk_yr_adl_em_only_first_seen2_mm;
			self.pk_combo_hphonescore_mm := pk_combo_hphonescore_mm;
			self.pk_lname_score_mm := pk_lname_score_mm;
			self.pk_yr_lname_change_date2_mm := pk_yr_lname_change_date2_mm;
			self.pk_ssnchar_invalid_or_recent_mm := pk_ssnchar_invalid_or_recent_mm;
			self.pk_infutor_risk_lvl_nb_mm := pk_infutor_risk_lvl_nb_mm;
			self.pk_add2_em_ver_lvl_mm := pk_add2_em_ver_lvl_mm;
			self.pk_yr_credit_first_seen2_mm := pk_yr_credit_first_seen2_mm;
			self.pk_adl_score_mm := pk_adl_score_mm;
			self.pk_yr_header_first_seen2_mm := pk_yr_header_first_seen2_mm;
			self.pk_eq_count_mm := pk_eq_count_mm;
			self.pk_em_only_ver_lvl_mm := pk_em_only_ver_lvl_mm;
			self.pk_rc_dirsaddr_lastscore_mm := pk_rc_dirsaddr_lastscore_mm;
			self.pk_add1_address_score_mm := pk_add1_address_score_mm;
			self.pk_yr_adl_vo_first_seen2_mm := pk_yr_adl_vo_first_seen2_mm;
			self.pk_pos_secondary_sources_mm := pk_pos_secondary_sources_mm;
			self.pk_combo_addrscore_mm := pk_combo_addrscore_mm;
			self.pk_voter_flag_mm := pk_voter_flag_mm;
			self.pk_combo_ssnscore_mm := pk_combo_ssnscore_mm;
			self.pk_add2_address_score_mm := pk_add2_address_score_mm;
			self.pk_add2_pos_sources_mm := pk_add2_pos_sources_mm;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm := pk_yrmo_adl_f_sn_mx_fcra2_mm;
			self.pk_fname_eda_sourced_type_lvl_mm := pk_fname_eda_sourced_type_lvl_mm;
			self.pk_infutor_risk_lvl_mm := pk_infutor_risk_lvl_mm;
			self.pk_lname_eda_sourced_type_lvl_mm := pk_lname_eda_sourced_type_lvl_mm;
			self.pk_estimated_income_mm_b1 := pk_estimated_income_mm_b1;
			self.pk_yr_adl_w_last_seen2_mm_b1 := pk_yr_adl_w_last_seen2_mm_b1;
			self.pk_pr_count_mm_b1 := pk_pr_count_mm_b1;
			self.pk_addrs_sourced_lvl_mm_b1 := pk_addrs_sourced_lvl_mm_b1;
			self.pk_add1_own_level_mm_b1 := pk_add1_own_level_mm_b1;
			self.pk_add2_own_level_mm_b1 := pk_add2_own_level_mm_b1;
			self.pk_add3_own_level_mm_b1 := pk_add3_own_level_mm_b1;
			self.pk_naprop_level2_mm_b1 := pk_naprop_level2_mm_b1;
			self.pk_yr_add1_built_date2_mm_b1 := pk_yr_add1_built_date2_mm_b1;
			self.pk_add1_purchase_amount2_mm_b1 := pk_add1_purchase_amount2_mm_b1;
			self.pk_yr_add1_mortgage_date2_mm_b1 := pk_yr_add1_mortgage_date2_mm_b1;
			self.pk_add1_mortgage_risk_mm_b1 := pk_add1_mortgage_risk_mm_b1;
			self.pk_add1_assessed_amount2_mm_b1 := pk_add1_assessed_amount2_mm_b1;
			self.pk_yr_add1_mortgage_due_date2_mm_b1 := pk_yr_add1_mortgage_due_date2_mm_b1;
			self.pk_yr_add1_date_first_seen2_mm_b1 := pk_yr_add1_date_first_seen2_mm_b1;
			self.pk_add1_land_use_risk_level_mm_b1 := pk_add1_land_use_risk_level_mm_b1;
			self.pk_add1_building_area2_mm_b1 := pk_add1_building_area2_mm_b1;
			self.pk_property_owned_total_mm_b1 := pk_property_owned_total_mm_b1;
			self.pk_prop_own_assess_tot2_mm_b1 := pk_prop_own_assess_tot2_mm_b1;
			self.pk_prop1_sale_price2_mm_b1 := pk_prop1_sale_price2_mm_b1;
			self.pk_yr_prop2_sale_date2_mm_b1 := pk_yr_prop2_sale_date2_mm_b1;
			self.pk_add2_no_of_buildings_mm_b1 := pk_add2_no_of_buildings_mm_b1;
			self.pk_add2_parking_no_of_cars_mm_b1 := pk_add2_parking_no_of_cars_mm_b1;
			self.pk_add2_mortgage_risk_mm_b1 := pk_add2_mortgage_risk_mm_b1;
			self.pk_add2_assessed_amount2_mm_b1 := pk_add2_assessed_amount2_mm_b1;
			self.pk_yr_add2_date_first_seen2_mm_b1 := pk_yr_add2_date_first_seen2_mm_b1;
			self.pk_yr_add2_date_last_seen2_mm_b1 := pk_yr_add2_date_last_seen2_mm_b1;
			self.pk_add3_mortgage_risk_mm_b1 := pk_add3_mortgage_risk_mm_b1;
			self.pk_add3_assessed_amount2_mm_b1 := pk_add3_assessed_amount2_mm_b1;
			self.pk_yr_add3_date_first_seen2_mm_b1 := pk_yr_add3_date_first_seen2_mm_b1;
			self.pk_watercraft_count_mm_b1 := pk_watercraft_count_mm_b1;
			self.pk_bk_level_mm_b1 := pk_bk_level_mm_b1;
			self.pk_eviction_level_mm_b1 := pk_eviction_level_mm_b1;
			self.pk_lien_type_level_mm_b1 := pk_lien_type_level_mm_b1;
			self.pk_yr_liens_last_unrel_date3_mm_b1 := pk_yr_liens_last_unrel_date3_mm_b1;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b1 := pk_yr_ln_unrel_lt_f_sn2_mm_b1;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b1 := pk_yr_ln_unrel_ot_f_sn2_mm_b1;
			self.pk_crime_level_mm_b1 := pk_crime_level_mm_b1;
			self.pk_attr_total_number_derogs_mm_b1 := pk_attr_total_number_derogs_mm_b1;
			self.pk_yr_rc_ssnhighissue2_mm_b1 := pk_yr_rc_ssnhighissue2_mm_b1;
			self.pk_prof_lic_cat_mm_b1 := pk_prof_lic_cat_mm_b1;
			self.pk_add1_lres_mm_b1 := pk_add1_lres_mm_b1;
			self.pk_add2_lres_mm_b1 := pk_add2_lres_mm_b1;
			self.pk_add3_lres_mm_b1 := pk_add3_lres_mm_b1;
			self.pk_addrs_5yr_mm_b1 := pk_addrs_5yr_mm_b1;
			self.pk_addrs_15yr_mm_b1 := pk_addrs_15yr_mm_b1;
			self.pk_add_lres_month_avg2_mm_b1 := pk_add_lres_month_avg2_mm_b1;
			self.pk_nameperssn_count_mm_b1 := pk_nameperssn_count_mm_b1;
			self.pk_ssns_per_adl_mm_b1 := pk_ssns_per_adl_mm_b1;
			self.pk_addrs_per_adl_mm_b1 := pk_addrs_per_adl_mm_b1;
			self.pk_phones_per_adl_mm_b1 := pk_phones_per_adl_mm_b1;
			self.pk_adlperssn_count_mm_b1 := pk_adlperssn_count_mm_b1;
			self.pk_addrs_per_ssn_mm_b1 := pk_addrs_per_ssn_mm_b1;
			self.pk_adls_per_addr_mm_b1 := pk_adls_per_addr_mm_b1;
			self.pk_phones_per_addr_mm_b1 := pk_phones_per_addr_mm_b1;
			self.pk_adls_per_phone_mm_b1 := pk_adls_per_phone_mm_b1;
			self.pk_ssns_per_adl_c6_mm_b1 := pk_ssns_per_adl_c6_mm_b1;
			self.pk_addrs_per_adl_c6_mm_b1 := pk_addrs_per_adl_c6_mm_b1;
			self.pk_phones_per_adl_c6_mm_b1 := pk_phones_per_adl_c6_mm_b1;
			self.pk_ssns_per_addr_c6_mm_b1 := pk_ssns_per_addr_c6_mm_b1;
			self.pk_phones_per_addr_c6_mm_b1 := pk_phones_per_addr_c6_mm_b1;
			self.pk_adls_per_phone_c6_mm_b1 := pk_adls_per_phone_c6_mm_b1;
			self.pk_attr_addrs_last24_mm_b1 := pk_attr_addrs_last24_mm_b1;
			self.pk_attr_addrs_last36_mm_b1 := pk_attr_addrs_last36_mm_b1;
			self.pk_ams_class_level_mm_b1 := pk_ams_class_level_mm_b1;
			self.pk_ams_income_level_code_mm_b1 := pk_ams_income_level_code_mm_b1;
			self.pk_college_tier_mm_b1 := pk_college_tier_mm_b1;
			self.pk_ams_age_mm_b1 := pk_ams_age_mm_b1;
			self.pk_inferred_age_mm_b1 := pk_inferred_age_mm_b1;
			self.pk_yr_reported_dob2_mm_b1 := pk_yr_reported_dob2_mm_b1;
			self.pk_avm_hit_level_mm_b1 := pk_avm_hit_level_mm_b1;
			self.pk_avm_auto_diff4_lvl_mm_b1 := pk_avm_auto_diff4_lvl_mm_b1;
			self.pk_add2_avm_auto_diff3_lvl_mm_b1 := pk_add2_avm_auto_diff3_lvl_mm_b1;
			self.pk2_add1_avm_as_mm_b1 := pk2_add1_avm_as_mm_b1;
			self.pk2_add1_avm_mkt_mm_b1 := pk2_add1_avm_mkt_mm_b1;
			self.pk2_add1_avm_hed_mm_b1 := pk2_add1_avm_hed_mm_b1;
			self.pk2_add1_avm_auto_mm_b1 := pk2_add1_avm_auto_mm_b1;
			self.pk2_add1_avm_auto2_mm_b1 := pk2_add1_avm_auto2_mm_b1;
			self.pk2_add1_avm_auto3_mm_b1 := pk2_add1_avm_auto3_mm_b1;
			self.pk2_add1_avm_auto4_mm_b1 := pk2_add1_avm_auto4_mm_b1;
			self.pk2_add1_avm_med_mm_b1 := pk2_add1_avm_med_mm_b1;
			self.pk2_add1_avm_to_med_ratio_mm_b1 := pk2_add1_avm_to_med_ratio_mm_b1;
			self.pk2_add2_avm_sp_mm_b1 := pk2_add2_avm_sp_mm_b1;
			self.pk2_add2_avm_mkt_mm_b1 := pk2_add2_avm_mkt_mm_b1;
			self.pk2_add2_avm_hed_mm_b1 := pk2_add2_avm_hed_mm_b1;
			self.pk2_add2_avm_auto_mm_b1 := pk2_add2_avm_auto_mm_b1;
			self.pk2_add2_avm_auto3_mm_b1 := pk2_add2_avm_auto3_mm_b1;
			self.pk2_add2_avm_auto4_mm_b1 := pk2_add2_avm_auto4_mm_b1;
			self.pk2_yr_add1_avm_rec_dt_mm_b1 := pk2_yr_add1_avm_rec_dt_mm_b1;
			self.pk2_yr_add1_avm_assess_year_mm_b1 := pk2_yr_add1_avm_assess_year_mm_b1;
			self.pk_dist_a1toa2_mm_b1 := pk_dist_a1toa2_mm_b1;
			self.pk_dist_a1toa3_mm_b1 := pk_dist_a1toa3_mm_b1;
			self.pk_rc_disthphoneaddr_mm_b1 := pk_rc_disthphoneaddr_mm_b1;
			self.pk_out_st_division_lvl_mm_b1 := pk_out_st_division_lvl_mm_b1;
			self.pk_wealth_index_mm_b1 := pk_wealth_index_mm_b1;
			self.pk_impulse_count_mm_b1 := pk_impulse_count_mm_b1;
			self.pk_attr_num_nonderogs90_b_mm_b1 := pk_attr_num_nonderogs90_b_mm_b1;
			self.pk_ssns_per_addr2_mm_b1 := pk_ssns_per_addr2_mm_b1;
			self.pk_yr_add2_assess_val_yr2_mm_b1 := pk_yr_add2_assess_val_yr2_mm_b1;
			self.pk_estimated_income_mm_b2 := pk_estimated_income_mm_b2;
			self.pk_yr_adl_w_last_seen2_mm_b2 := pk_yr_adl_w_last_seen2_mm_b2;
			self.pk_pr_count_mm_b2 := pk_pr_count_mm_b2;
			self.pk_addrs_sourced_lvl_mm_b2 := pk_addrs_sourced_lvl_mm_b2;
			self.pk_add1_own_level_mm_b2 := pk_add1_own_level_mm_b2;
			self.pk_add2_own_level_mm_b2 := pk_add2_own_level_mm_b2;
			self.pk_add3_own_level_mm_b2 := pk_add3_own_level_mm_b2;
			self.pk_naprop_level2_mm_b2 := pk_naprop_level2_mm_b2;
			self.pk_yr_add1_built_date2_mm_b2 := pk_yr_add1_built_date2_mm_b2;
			self.pk_add1_purchase_amount2_mm_b2 := pk_add1_purchase_amount2_mm_b2;
			self.pk_yr_add1_mortgage_date2_mm_b2 := pk_yr_add1_mortgage_date2_mm_b2;
			self.pk_add1_mortgage_risk_mm_b2 := pk_add1_mortgage_risk_mm_b2;
			self.pk_add1_assessed_amount2_mm_b2 := pk_add1_assessed_amount2_mm_b2;
			self.pk_yr_add1_mortgage_due_date2_mm_b2 := pk_yr_add1_mortgage_due_date2_mm_b2;
			self.pk_yr_add1_date_first_seen2_mm_b2 := pk_yr_add1_date_first_seen2_mm_b2;
			self.pk_add1_land_use_risk_level_mm_b2 := pk_add1_land_use_risk_level_mm_b2;
			self.pk_add1_building_area2_mm_b2 := pk_add1_building_area2_mm_b2;
			self.pk_property_owned_total_mm_b2 := pk_property_owned_total_mm_b2;
			self.pk_prop_own_assess_tot2_mm_b2 := pk_prop_own_assess_tot2_mm_b2;
			self.pk_prop1_sale_price2_mm_b2 := pk_prop1_sale_price2_mm_b2;
			self.pk_yr_prop2_sale_date2_mm_b2 := pk_yr_prop2_sale_date2_mm_b2;
			self.pk_add2_no_of_buildings_mm_b2 := pk_add2_no_of_buildings_mm_b2;
			self.pk_add2_parking_no_of_cars_mm_b2 := pk_add2_parking_no_of_cars_mm_b2;
			self.pk_add2_mortgage_risk_mm_b2 := pk_add2_mortgage_risk_mm_b2;
			self.pk_add2_assessed_amount2_mm_b2 := pk_add2_assessed_amount2_mm_b2;
			self.pk_yr_add2_date_first_seen2_mm_b2 := pk_yr_add2_date_first_seen2_mm_b2;
			self.pk_yr_add2_date_last_seen2_mm_b2 := pk_yr_add2_date_last_seen2_mm_b2;
			self.pk_add3_mortgage_risk_mm_b2 := pk_add3_mortgage_risk_mm_b2;
			self.pk_add3_assessed_amount2_mm_b2 := pk_add3_assessed_amount2_mm_b2;
			self.pk_yr_add3_date_first_seen2_mm_b2 := pk_yr_add3_date_first_seen2_mm_b2;
			self.pk_watercraft_count_mm_b2 := pk_watercraft_count_mm_b2;
			self.pk_bk_level_mm_b2 := pk_bk_level_mm_b2;
			self.pk_eviction_level_mm_b2 := pk_eviction_level_mm_b2;
			self.pk_lien_type_level_mm_b2 := pk_lien_type_level_mm_b2;
			self.pk_yr_liens_last_unrel_date3_mm_b2 := pk_yr_liens_last_unrel_date3_mm_b2;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b2 := pk_yr_ln_unrel_lt_f_sn2_mm_b2;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b2 := pk_yr_ln_unrel_ot_f_sn2_mm_b2;
			self.pk_crime_level_mm_b2 := pk_crime_level_mm_b2;
			self.pk_attr_total_number_derogs_mm_b2 := pk_attr_total_number_derogs_mm_b2;
			self.pk_yr_rc_ssnhighissue2_mm_b2 := pk_yr_rc_ssnhighissue2_mm_b2;
			self.pk_prof_lic_cat_mm_b2 := pk_prof_lic_cat_mm_b2;
			self.pk_add1_lres_mm_b2 := pk_add1_lres_mm_b2;
			self.pk_add2_lres_mm_b2 := pk_add2_lres_mm_b2;
			self.pk_add3_lres_mm_b2 := pk_add3_lres_mm_b2;
			self.pk_addrs_5yr_mm_b2 := pk_addrs_5yr_mm_b2;
			self.pk_addrs_15yr_mm_b2 := pk_addrs_15yr_mm_b2;
			self.pk_add_lres_month_avg2_mm_b2 := pk_add_lres_month_avg2_mm_b2;
			self.pk_nameperssn_count_mm_b2 := pk_nameperssn_count_mm_b2;
			self.pk_ssns_per_adl_mm_b2 := pk_ssns_per_adl_mm_b2;
			self.pk_addrs_per_adl_mm_b2 := pk_addrs_per_adl_mm_b2;
			self.pk_phones_per_adl_mm_b2 := pk_phones_per_adl_mm_b2;
			self.pk_adlperssn_count_mm_b2 := pk_adlperssn_count_mm_b2;
			self.pk_addrs_per_ssn_mm_b2 := pk_addrs_per_ssn_mm_b2;
			self.pk_adls_per_addr_mm_b2 := pk_adls_per_addr_mm_b2;
			self.pk_phones_per_addr_mm_b2 := pk_phones_per_addr_mm_b2;
			self.pk_adls_per_phone_mm_b2 := pk_adls_per_phone_mm_b2;
			self.pk_ssns_per_adl_c6_mm_b2 := pk_ssns_per_adl_c6_mm_b2;
			self.pk_addrs_per_adl_c6_mm_b2 := pk_addrs_per_adl_c6_mm_b2;
			self.pk_phones_per_adl_c6_mm_b2 := pk_phones_per_adl_c6_mm_b2;
			self.pk_ssns_per_addr_c6_mm_b2 := pk_ssns_per_addr_c6_mm_b2;
			self.pk_phones_per_addr_c6_mm_b2 := pk_phones_per_addr_c6_mm_b2;
			self.pk_adls_per_phone_c6_mm_b2 := pk_adls_per_phone_c6_mm_b2;
			self.pk_attr_addrs_last24_mm_b2 := pk_attr_addrs_last24_mm_b2;
			self.pk_attr_addrs_last36_mm_b2 := pk_attr_addrs_last36_mm_b2;
			self.pk_ams_class_level_mm_b2 := pk_ams_class_level_mm_b2;
			self.pk_ams_income_level_code_mm_b2 := pk_ams_income_level_code_mm_b2;
			self.pk_college_tier_mm_b2 := pk_college_tier_mm_b2;
			self.pk_ams_age_mm_b2 := pk_ams_age_mm_b2;
			self.pk_inferred_age_mm_b2 := pk_inferred_age_mm_b2;
			self.pk_yr_reported_dob2_mm_b2 := pk_yr_reported_dob2_mm_b2;
			self.pk_avm_hit_level_mm_b2 := pk_avm_hit_level_mm_b2;
			self.pk_avm_auto_diff4_lvl_mm_b2 := pk_avm_auto_diff4_lvl_mm_b2;
			self.pk_add2_avm_auto_diff3_lvl_mm_b2 := pk_add2_avm_auto_diff3_lvl_mm_b2;
			self.pk2_add1_avm_as_mm_b2 := pk2_add1_avm_as_mm_b2;
			self.pk2_add1_avm_mkt_mm_b2 := pk2_add1_avm_mkt_mm_b2;
			self.pk2_add1_avm_hed_mm_b2 := pk2_add1_avm_hed_mm_b2;
			self.pk2_add1_avm_auto_mm_b2 := pk2_add1_avm_auto_mm_b2;
			self.pk2_add1_avm_auto2_mm_b2 := pk2_add1_avm_auto2_mm_b2;
			self.pk2_add1_avm_auto3_mm_b2 := pk2_add1_avm_auto3_mm_b2;
			self.pk2_add1_avm_auto4_mm_b2 := pk2_add1_avm_auto4_mm_b2;
			self.pk2_add1_avm_med_mm_b2 := pk2_add1_avm_med_mm_b2;
			self.pk2_add1_avm_to_med_ratio_mm_b2 := pk2_add1_avm_to_med_ratio_mm_b2;
			self.pk2_add2_avm_sp_mm_b2 := pk2_add2_avm_sp_mm_b2;
			self.pk2_add2_avm_mkt_mm_b2 := pk2_add2_avm_mkt_mm_b2;
			self.pk2_add2_avm_hed_mm_b2 := pk2_add2_avm_hed_mm_b2;
			self.pk2_add2_avm_auto_mm_b2 := pk2_add2_avm_auto_mm_b2;
			self.pk2_add2_avm_auto3_mm_b2 := pk2_add2_avm_auto3_mm_b2;
			self.pk2_add2_avm_auto4_mm_b2 := pk2_add2_avm_auto4_mm_b2;
			self.pk2_yr_add1_avm_rec_dt_mm_b2 := pk2_yr_add1_avm_rec_dt_mm_b2;
			self.pk2_yr_add1_avm_assess_year_mm_b2 := pk2_yr_add1_avm_assess_year_mm_b2;
			self.pk_dist_a1toa2_mm_b2 := pk_dist_a1toa2_mm_b2;
			self.pk_dist_a1toa3_mm_b2 := pk_dist_a1toa3_mm_b2;
			self.pk_rc_disthphoneaddr_mm_b2 := pk_rc_disthphoneaddr_mm_b2;
			self.pk_out_st_division_lvl_mm_b2 := pk_out_st_division_lvl_mm_b2;
			self.pk_wealth_index_mm_b2 := pk_wealth_index_mm_b2;
			self.pk_impulse_count_mm_b2 := pk_impulse_count_mm_b2;
			self.pk_attr_num_nonderogs90_b_mm_b2 := pk_attr_num_nonderogs90_b_mm_b2;
			self.pk_ssns_per_addr2_mm_b2 := pk_ssns_per_addr2_mm_b2;
			self.pk_yr_add2_assess_val_yr2_mm_b2 := pk_yr_add2_assess_val_yr2_mm_b2;
			self.pk_estimated_income_mm_b3 := pk_estimated_income_mm_b3;
			self.pk_yr_adl_w_last_seen2_mm_b3 := pk_yr_adl_w_last_seen2_mm_b3;
			self.pk_pr_count_mm_b3 := pk_pr_count_mm_b3;
			self.pk_addrs_sourced_lvl_mm_b3 := pk_addrs_sourced_lvl_mm_b3;
			self.pk_add1_own_level_mm_b3 := pk_add1_own_level_mm_b3;
			self.pk_add2_own_level_mm_b3 := pk_add2_own_level_mm_b3;
			self.pk_add3_own_level_mm_b3 := pk_add3_own_level_mm_b3;
			self.pk_naprop_level2_mm_b3 := pk_naprop_level2_mm_b3;
			self.pk_yr_add1_built_date2_mm_b3 := pk_yr_add1_built_date2_mm_b3;
			self.pk_add1_purchase_amount2_mm_b3 := pk_add1_purchase_amount2_mm_b3;
			self.pk_yr_add1_mortgage_date2_mm_b3 := pk_yr_add1_mortgage_date2_mm_b3;
			self.pk_add1_mortgage_risk_mm_b3 := pk_add1_mortgage_risk_mm_b3;
			self.pk_add1_assessed_amount2_mm_b3 := pk_add1_assessed_amount2_mm_b3;
			self.pk_yr_add1_mortgage_due_date2_mm_b3 := pk_yr_add1_mortgage_due_date2_mm_b3;
			self.pk_yr_add1_date_first_seen2_mm_b3 := pk_yr_add1_date_first_seen2_mm_b3;
			self.pk_add1_land_use_risk_level_mm_b3 := pk_add1_land_use_risk_level_mm_b3;
			self.pk_add1_building_area2_mm_b3 := pk_add1_building_area2_mm_b3;
			self.pk_property_owned_total_mm_b3 := pk_property_owned_total_mm_b3;
			self.pk_prop_own_assess_tot2_mm_b3 := pk_prop_own_assess_tot2_mm_b3;
			self.pk_prop1_sale_price2_mm_b3 := pk_prop1_sale_price2_mm_b3;
			self.pk_yr_prop2_sale_date2_mm_b3 := pk_yr_prop2_sale_date2_mm_b3;
			self.pk_add2_no_of_buildings_mm_b3 := pk_add2_no_of_buildings_mm_b3;
			self.pk_add2_parking_no_of_cars_mm_b3 := pk_add2_parking_no_of_cars_mm_b3;
			self.pk_add2_mortgage_risk_mm_b3 := pk_add2_mortgage_risk_mm_b3;
			self.pk_add2_assessed_amount2_mm_b3 := pk_add2_assessed_amount2_mm_b3;
			self.pk_yr_add2_date_first_seen2_mm_b3 := pk_yr_add2_date_first_seen2_mm_b3;
			self.pk_yr_add2_date_last_seen2_mm_b3 := pk_yr_add2_date_last_seen2_mm_b3;
			self.pk_add3_mortgage_risk_mm_b3 := pk_add3_mortgage_risk_mm_b3;
			self.pk_add3_assessed_amount2_mm_b3 := pk_add3_assessed_amount2_mm_b3;
			self.pk_yr_add3_date_first_seen2_mm_b3 := pk_yr_add3_date_first_seen2_mm_b3;
			self.pk_watercraft_count_mm_b3 := pk_watercraft_count_mm_b3;
			self.pk_bk_level_mm_b3 := pk_bk_level_mm_b3;
			self.pk_eviction_level_mm_b3 := pk_eviction_level_mm_b3;
			self.pk_lien_type_level_mm_b3 := pk_lien_type_level_mm_b3;
			self.pk_yr_liens_last_unrel_date3_mm_b3 := pk_yr_liens_last_unrel_date3_mm_b3;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b3 := pk_yr_ln_unrel_lt_f_sn2_mm_b3;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b3 := pk_yr_ln_unrel_ot_f_sn2_mm_b3;
			self.pk_crime_level_mm_b3 := pk_crime_level_mm_b3;
			self.pk_attr_total_number_derogs_mm_b3 := pk_attr_total_number_derogs_mm_b3;
			self.pk_yr_rc_ssnhighissue2_mm_b3 := pk_yr_rc_ssnhighissue2_mm_b3;
			self.pk_prof_lic_cat_mm_b3 := pk_prof_lic_cat_mm_b3;
			self.pk_add1_lres_mm_b3 := pk_add1_lres_mm_b3;
			self.pk_add2_lres_mm_b3 := pk_add2_lres_mm_b3;
			self.pk_add3_lres_mm_b3 := pk_add3_lres_mm_b3;
			self.pk_addrs_5yr_mm_b3 := pk_addrs_5yr_mm_b3;
			self.pk_addrs_15yr_mm_b3 := pk_addrs_15yr_mm_b3;
			self.pk_add_lres_month_avg2_mm_b3 := pk_add_lres_month_avg2_mm_b3;
			self.pk_nameperssn_count_mm_b3 := pk_nameperssn_count_mm_b3;
			self.pk_ssns_per_adl_mm_b3 := pk_ssns_per_adl_mm_b3;
			self.pk_addrs_per_adl_mm_b3 := pk_addrs_per_adl_mm_b3;
			self.pk_phones_per_adl_mm_b3 := pk_phones_per_adl_mm_b3;
			self.pk_adlperssn_count_mm_b3 := pk_adlperssn_count_mm_b3;
			self.pk_addrs_per_ssn_mm_b3 := pk_addrs_per_ssn_mm_b3;
			self.pk_adls_per_addr_mm_b3 := pk_adls_per_addr_mm_b3;
			self.pk_phones_per_addr_mm_b3 := pk_phones_per_addr_mm_b3;
			self.pk_adls_per_phone_mm_b3 := pk_adls_per_phone_mm_b3;
			self.pk_ssns_per_adl_c6_mm_b3 := pk_ssns_per_adl_c6_mm_b3;
			self.pk_addrs_per_adl_c6_mm_b3 := pk_addrs_per_adl_c6_mm_b3;
			self.pk_phones_per_adl_c6_mm_b3 := pk_phones_per_adl_c6_mm_b3;
			self.pk_ssns_per_addr_c6_mm_b3 := pk_ssns_per_addr_c6_mm_b3;
			self.pk_phones_per_addr_c6_mm_b3 := pk_phones_per_addr_c6_mm_b3;
			self.pk_adls_per_phone_c6_mm_b3 := pk_adls_per_phone_c6_mm_b3;
			self.pk_attr_addrs_last24_mm_b3 := pk_attr_addrs_last24_mm_b3;
			self.pk_attr_addrs_last36_mm_b3 := pk_attr_addrs_last36_mm_b3;
			self.pk_ams_class_level_mm_b3 := pk_ams_class_level_mm_b3;
			self.pk_ams_income_level_code_mm_b3 := pk_ams_income_level_code_mm_b3;
			self.pk_college_tier_mm_b3 := pk_college_tier_mm_b3;
			self.pk_ams_age_mm_b3 := pk_ams_age_mm_b3;
			self.pk_inferred_age_mm_b3 := pk_inferred_age_mm_b3;
			self.pk_yr_reported_dob2_mm_b3 := pk_yr_reported_dob2_mm_b3;
			self.pk_avm_hit_level_mm_b3 := pk_avm_hit_level_mm_b3;
			self.pk_avm_auto_diff4_lvl_mm_b3 := pk_avm_auto_diff4_lvl_mm_b3;
			self.pk_add2_avm_auto_diff3_lvl_mm_b3 := pk_add2_avm_auto_diff3_lvl_mm_b3;
			self.pk2_add1_avm_as_mm_b3 := pk2_add1_avm_as_mm_b3;
			self.pk2_add1_avm_mkt_mm_b3 := pk2_add1_avm_mkt_mm_b3;
			self.pk2_add1_avm_hed_mm_b3 := pk2_add1_avm_hed_mm_b3;
			self.pk2_add1_avm_auto_mm_b3 := pk2_add1_avm_auto_mm_b3;
			self.pk2_add1_avm_auto2_mm_b3 := pk2_add1_avm_auto2_mm_b3;
			self.pk2_add1_avm_auto3_mm_b3 := pk2_add1_avm_auto3_mm_b3;
			self.pk2_add1_avm_auto4_mm_b3 := pk2_add1_avm_auto4_mm_b3;
			self.pk2_add1_avm_med_mm_b3 := pk2_add1_avm_med_mm_b3;
			self.pk2_add1_avm_to_med_ratio_mm_b3 := pk2_add1_avm_to_med_ratio_mm_b3;
			self.pk2_add2_avm_sp_mm_b3 := pk2_add2_avm_sp_mm_b3;
			self.pk2_add2_avm_mkt_mm_b3 := pk2_add2_avm_mkt_mm_b3;
			self.pk2_add2_avm_hed_mm_b3 := pk2_add2_avm_hed_mm_b3;
			self.pk2_add2_avm_auto_mm_b3 := pk2_add2_avm_auto_mm_b3;
			self.pk2_add2_avm_auto3_mm_b3 := pk2_add2_avm_auto3_mm_b3;
			self.pk2_add2_avm_auto4_mm_b3 := pk2_add2_avm_auto4_mm_b3;
			self.pk2_yr_add1_avm_rec_dt_mm_b3 := pk2_yr_add1_avm_rec_dt_mm_b3;
			self.pk2_yr_add1_avm_assess_year_mm_b3 := pk2_yr_add1_avm_assess_year_mm_b3;
			self.pk_dist_a1toa2_mm_b3 := pk_dist_a1toa2_mm_b3;
			self.pk_dist_a1toa3_mm_b3 := pk_dist_a1toa3_mm_b3;
			self.pk_rc_disthphoneaddr_mm_b3 := pk_rc_disthphoneaddr_mm_b3;
			self.pk_out_st_division_lvl_mm_b3 := pk_out_st_division_lvl_mm_b3;
			self.pk_wealth_index_mm_b3 := pk_wealth_index_mm_b3;
			self.pk_impulse_count_mm_b3 := pk_impulse_count_mm_b3;
			self.pk_attr_num_nonderogs90_b_mm_b3 := pk_attr_num_nonderogs90_b_mm_b3;
			self.pk_ssns_per_addr2_mm_b3 := pk_ssns_per_addr2_mm_b3;
			self.pk_yr_add2_assess_val_yr2_mm_b3 := pk_yr_add2_assess_val_yr2_mm_b3;
			self.pk_estimated_income_mm_b4 := pk_estimated_income_mm_b4;
			self.pk_yr_adl_w_last_seen2_mm_b4 := pk_yr_adl_w_last_seen2_mm_b4;
			self.pk_pr_count_mm_b4 := pk_pr_count_mm_b4;
			self.pk_addrs_sourced_lvl_mm_b4 := pk_addrs_sourced_lvl_mm_b4;
			self.pk_add1_own_level_mm_b4 := pk_add1_own_level_mm_b4;
			self.pk_add2_own_level_mm_b4 := pk_add2_own_level_mm_b4;
			self.pk_add3_own_level_mm_b4 := pk_add3_own_level_mm_b4;
			self.pk_naprop_level2_mm_b4 := pk_naprop_level2_mm_b4;
			self.pk_yr_add1_built_date2_mm_b4 := pk_yr_add1_built_date2_mm_b4;
			self.pk_add1_purchase_amount2_mm_b4 := pk_add1_purchase_amount2_mm_b4;
			self.pk_yr_add1_mortgage_date2_mm_b4 := pk_yr_add1_mortgage_date2_mm_b4;
			self.pk_add1_mortgage_risk_mm_b4 := pk_add1_mortgage_risk_mm_b4;
			self.pk_add1_assessed_amount2_mm_b4 := pk_add1_assessed_amount2_mm_b4;
			self.pk_yr_add1_mortgage_due_date2_mm_b4 := pk_yr_add1_mortgage_due_date2_mm_b4;
			self.pk_yr_add1_date_first_seen2_mm_b4 := pk_yr_add1_date_first_seen2_mm_b4;
			self.pk_add1_land_use_risk_level_mm_b4 := pk_add1_land_use_risk_level_mm_b4;
			self.pk_add1_building_area2_mm_b4 := pk_add1_building_area2_mm_b4;
			self.pk_property_owned_total_mm_b4 := pk_property_owned_total_mm_b4;
			self.pk_prop_own_assess_tot2_mm_b4 := pk_prop_own_assess_tot2_mm_b4;
			self.pk_prop1_sale_price2_mm_b4 := pk_prop1_sale_price2_mm_b4;
			self.pk_yr_prop2_sale_date2_mm_b4 := pk_yr_prop2_sale_date2_mm_b4;
			self.pk_add2_no_of_buildings_mm_b4 := pk_add2_no_of_buildings_mm_b4;
			self.pk_add2_parking_no_of_cars_mm_b4 := pk_add2_parking_no_of_cars_mm_b4;
			self.pk_add2_mortgage_risk_mm_b4 := pk_add2_mortgage_risk_mm_b4;
			self.pk_add2_assessed_amount2_mm_b4 := pk_add2_assessed_amount2_mm_b4;
			self.pk_yr_add2_date_first_seen2_mm_b4 := pk_yr_add2_date_first_seen2_mm_b4;
			self.pk_yr_add2_date_last_seen2_mm_b4 := pk_yr_add2_date_last_seen2_mm_b4;
			self.pk_add3_mortgage_risk_mm_b4 := pk_add3_mortgage_risk_mm_b4;
			self.pk_add3_assessed_amount2_mm_b4 := pk_add3_assessed_amount2_mm_b4;
			self.pk_yr_add3_date_first_seen2_mm_b4 := pk_yr_add3_date_first_seen2_mm_b4;
			self.pk_watercraft_count_mm_b4 := pk_watercraft_count_mm_b4;
			self.pk_bk_level_mm_b4 := pk_bk_level_mm_b4;
			self.pk_eviction_level_mm_b4 := pk_eviction_level_mm_b4;
			self.pk_lien_type_level_mm_b4 := pk_lien_type_level_mm_b4;
			self.pk_yr_liens_last_unrel_date3_mm_b4 := pk_yr_liens_last_unrel_date3_mm_b4;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b4 := pk_yr_ln_unrel_lt_f_sn2_mm_b4;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b4 := pk_yr_ln_unrel_ot_f_sn2_mm_b4;
			self.pk_crime_level_mm_b4 := pk_crime_level_mm_b4;
			self.pk_attr_total_number_derogs_mm_b4 := pk_attr_total_number_derogs_mm_b4;
			self.pk_yr_rc_ssnhighissue2_mm_b4 := pk_yr_rc_ssnhighissue2_mm_b4;
			self.pk_prof_lic_cat_mm_b4 := pk_prof_lic_cat_mm_b4;
			self.pk_add1_lres_mm_b4 := pk_add1_lres_mm_b4;
			self.pk_add2_lres_mm_b4 := pk_add2_lres_mm_b4;
			self.pk_add3_lres_mm_b4 := pk_add3_lres_mm_b4;
			self.pk_addrs_5yr_mm_b4 := pk_addrs_5yr_mm_b4;
			self.pk_addrs_15yr_mm_b4 := pk_addrs_15yr_mm_b4;
			self.pk_add_lres_month_avg2_mm_b4 := pk_add_lres_month_avg2_mm_b4;
			self.pk_nameperssn_count_mm_b4 := pk_nameperssn_count_mm_b4;
			self.pk_ssns_per_adl_mm_b4 := pk_ssns_per_adl_mm_b4;
			self.pk_addrs_per_adl_mm_b4 := pk_addrs_per_adl_mm_b4;
			self.pk_phones_per_adl_mm_b4 := pk_phones_per_adl_mm_b4;
			self.pk_adlperssn_count_mm_b4 := pk_adlperssn_count_mm_b4;
			self.pk_addrs_per_ssn_mm_b4 := pk_addrs_per_ssn_mm_b4;
			self.pk_adls_per_addr_mm_b4 := pk_adls_per_addr_mm_b4;
			self.pk_phones_per_addr_mm_b4 := pk_phones_per_addr_mm_b4;
			self.pk_adls_per_phone_mm_b4 := pk_adls_per_phone_mm_b4;
			self.pk_ssns_per_adl_c6_mm_b4 := pk_ssns_per_adl_c6_mm_b4;
			self.pk_addrs_per_adl_c6_mm_b4 := pk_addrs_per_adl_c6_mm_b4;
			self.pk_phones_per_adl_c6_mm_b4 := pk_phones_per_adl_c6_mm_b4;
			self.pk_ssns_per_addr_c6_mm_b4 := pk_ssns_per_addr_c6_mm_b4;
			self.pk_phones_per_addr_c6_mm_b4 := pk_phones_per_addr_c6_mm_b4;
			self.pk_adls_per_phone_c6_mm_b4 := pk_adls_per_phone_c6_mm_b4;
			self.pk_attr_addrs_last24_mm_b4 := pk_attr_addrs_last24_mm_b4;
			self.pk_attr_addrs_last36_mm_b4 := pk_attr_addrs_last36_mm_b4;
			self.pk_ams_class_level_mm_b4 := pk_ams_class_level_mm_b4;
			self.pk_ams_income_level_code_mm_b4 := pk_ams_income_level_code_mm_b4;
			self.pk_college_tier_mm_b4 := pk_college_tier_mm_b4;
			self.pk_ams_age_mm_b4 := pk_ams_age_mm_b4;
			self.pk_inferred_age_mm_b4 := pk_inferred_age_mm_b4;
			self.pk_yr_reported_dob2_mm_b4 := pk_yr_reported_dob2_mm_b4;
			self.pk_avm_hit_level_mm_b4 := pk_avm_hit_level_mm_b4;
			self.pk_avm_auto_diff4_lvl_mm_b4 := pk_avm_auto_diff4_lvl_mm_b4;
			self.pk_add2_avm_auto_diff3_lvl_mm_b4 := pk_add2_avm_auto_diff3_lvl_mm_b4;
			self.pk2_add1_avm_as_mm_b4 := pk2_add1_avm_as_mm_b4;
			self.pk2_add1_avm_mkt_mm_b4 := pk2_add1_avm_mkt_mm_b4;
			self.pk2_add1_avm_hed_mm_b4 := pk2_add1_avm_hed_mm_b4;
			self.pk2_add1_avm_auto_mm_b4 := pk2_add1_avm_auto_mm_b4;
			self.pk2_add1_avm_auto2_mm_b4 := pk2_add1_avm_auto2_mm_b4;
			self.pk2_add1_avm_auto3_mm_b4 := pk2_add1_avm_auto3_mm_b4;
			self.pk2_add1_avm_auto4_mm_b4 := pk2_add1_avm_auto4_mm_b4;
			self.pk2_add1_avm_med_mm_b4 := pk2_add1_avm_med_mm_b4;
			self.pk2_add1_avm_to_med_ratio_mm_b4 := pk2_add1_avm_to_med_ratio_mm_b4;
			self.pk2_add2_avm_sp_mm_b4 := pk2_add2_avm_sp_mm_b4;
			self.pk2_add2_avm_mkt_mm_b4 := pk2_add2_avm_mkt_mm_b4;
			self.pk2_add2_avm_hed_mm_b4 := pk2_add2_avm_hed_mm_b4;
			self.pk2_add2_avm_auto_mm_b4 := pk2_add2_avm_auto_mm_b4;
			self.pk2_add2_avm_auto3_mm_b4 := pk2_add2_avm_auto3_mm_b4;
			self.pk2_add2_avm_auto4_mm_b4 := pk2_add2_avm_auto4_mm_b4;
			self.pk2_yr_add1_avm_rec_dt_mm_b4 := pk2_yr_add1_avm_rec_dt_mm_b4;
			self.pk2_yr_add1_avm_assess_year_mm_b4 := pk2_yr_add1_avm_assess_year_mm_b4;
			self.pk_dist_a1toa2_mm_b4 := pk_dist_a1toa2_mm_b4;
			self.pk_dist_a1toa3_mm_b4 := pk_dist_a1toa3_mm_b4;
			self.pk_rc_disthphoneaddr_mm_b4 := pk_rc_disthphoneaddr_mm_b4;
			self.pk_out_st_division_lvl_mm_b4 := pk_out_st_division_lvl_mm_b4;
			self.pk_wealth_index_mm_b4 := pk_wealth_index_mm_b4;
			self.pk_impulse_count_mm_b4 := pk_impulse_count_mm_b4;
			self.pk_attr_num_nonderogs90_b_mm_b4 := pk_attr_num_nonderogs90_b_mm_b4;
			self.pk_ssns_per_addr2_mm_b4 := pk_ssns_per_addr2_mm_b4;
			self.pk_yr_add2_assess_val_yr2_mm_b4 := pk_yr_add2_assess_val_yr2_mm_b4;
			self.pk_prop_own_assess_tot2_mm := pk_prop_own_assess_tot2_mm;
			self.pk_yr_add1_date_first_seen2_mm := pk_yr_add1_date_first_seen2_mm;
			self.pk_attr_addrs_last36_mm := pk_attr_addrs_last36_mm;
			self.pk2_add2_avm_mkt_mm := pk2_add2_avm_mkt_mm;
			self.pk_nameperssn_count_mm := pk_nameperssn_count_mm;
			self.pk_add1_purchase_amount2_mm := pk_add1_purchase_amount2_mm;
			self.pk_adls_per_phone_mm := pk_adls_per_phone_mm;
			self.pk_ssns_per_addr2_mm := pk_ssns_per_addr2_mm;
			self.pk_property_owned_total_mm := pk_property_owned_total_mm;
			self.pk_ams_class_level_mm := pk_ams_class_level_mm;
			self.pk_adls_per_phone_c6_mm := pk_adls_per_phone_c6_mm;
			self.pk_yr_add2_date_first_seen2_mm := pk_yr_add2_date_first_seen2_mm;
			self.pk_adlperssn_count_mm := pk_adlperssn_count_mm;
			self.pk2_add2_avm_auto_mm := pk2_add2_avm_auto_mm;
			self.pk2_add2_avm_hed_mm := pk2_add2_avm_hed_mm;
			self.pk_avm_auto_diff4_lvl_mm := pk_avm_auto_diff4_lvl_mm;
			self.pk_yr_add3_date_first_seen2_mm := pk_yr_add3_date_first_seen2_mm;
			self.pk_add1_land_use_risk_level_mm := pk_add1_land_use_risk_level_mm;
			self.pk_add2_avm_auto_diff3_lvl_mm := pk_add2_avm_auto_diff3_lvl_mm;
			self.pk_add2_own_level_mm := pk_add2_own_level_mm;
			self.pk_addrs_per_ssn_mm := pk_addrs_per_ssn_mm;
			self.pk_add2_lres_mm := pk_add2_lres_mm;
			self.pk_addrs_sourced_lvl_mm := pk_addrs_sourced_lvl_mm;
			self.pk_add_lres_month_avg2_mm := pk_add_lres_month_avg2_mm;
			self.pk_rc_disthphoneaddr_mm := pk_rc_disthphoneaddr_mm;
			self.pk_add1_lres_mm := pk_add1_lres_mm;
			self.pk_attr_total_number_derogs_mm := pk_attr_total_number_derogs_mm;
			self.pk_addrs_per_adl_c6_mm := pk_addrs_per_adl_c6_mm;
			self.pk2_add2_avm_sp_mm := pk2_add2_avm_sp_mm;
			self.pk_addrs_per_adl_mm := pk_addrs_per_adl_mm;
			self.pk_naprop_level2_mm := pk_naprop_level2_mm;
			self.pk2_add1_avm_auto3_mm := pk2_add1_avm_auto3_mm;
			self.pk2_add1_avm_mkt_mm := pk2_add1_avm_mkt_mm;
			self.pk_yr_reported_dob2_mm := pk_yr_reported_dob2_mm;
			self.pk_prop1_sale_price2_mm := pk_prop1_sale_price2_mm;
			self.pk2_add1_avm_auto4_mm := pk2_add1_avm_auto4_mm;
			self.pk_college_tier_mm := pk_college_tier_mm;
			self.pk_ssns_per_adl_mm := pk_ssns_per_adl_mm;
			self.pk_yr_adl_w_last_seen2_mm := pk_yr_adl_w_last_seen2_mm;
			self.pk_ams_income_level_code_mm := pk_ams_income_level_code_mm;
			self.pk_yr_ln_unrel_ot_f_sn2_mm := pk_yr_ln_unrel_ot_f_sn2_mm;
			self.pk_add1_building_area2_mm := pk_add1_building_area2_mm;
			self.pk_pr_count_mm := pk_pr_count_mm;
			self.pk2_add1_avm_as_mm := pk2_add1_avm_as_mm;
			self.pk_inferred_age_mm := pk_inferred_age_mm;
			self.pk2_yr_add1_avm_assess_year_mm := pk2_yr_add1_avm_assess_year_mm;
			self.pk_out_st_division_lvl_mm := pk_out_st_division_lvl_mm;
			self.pk_yr_rc_ssnhighissue2_mm := pk_yr_rc_ssnhighissue2_mm;
			self.pk_watercraft_count_mm := pk_watercraft_count_mm;
			self.pk_phones_per_adl_mm := pk_phones_per_adl_mm;
			self.pk2_add1_avm_auto2_mm := pk2_add1_avm_auto2_mm;
			self.pk_ssns_per_addr_c6_mm := pk_ssns_per_addr_c6_mm;
			self.pk_yr_ln_unrel_lt_f_sn2_mm := pk_yr_ln_unrel_lt_f_sn2_mm;
			self.pk2_add1_avm_hed_mm := pk2_add1_avm_hed_mm;
			self.pk2_yr_add1_avm_rec_dt_mm := pk2_yr_add1_avm_rec_dt_mm;
			self.pk_add1_mortgage_risk_mm := pk_add1_mortgage_risk_mm;
			self.pk_yr_add2_assess_val_yr2_mm := pk_yr_add2_assess_val_yr2_mm;
			self.pk_add2_assessed_amount2_mm := pk_add2_assessed_amount2_mm;
			self.pk_prof_lic_cat_mm := pk_prof_lic_cat_mm;
			self.pk_dist_a1toa3_mm := pk_dist_a1toa3_mm;
			self.pk_eviction_level_mm := pk_eviction_level_mm;
			self.pk_attr_num_nonderogs90_b_mm := pk_attr_num_nonderogs90_b_mm;
			self.pk_add3_own_level_mm := pk_add3_own_level_mm;
			self.pk_adls_per_addr_mm := pk_adls_per_addr_mm;
			self.pk_ssns_per_adl_c6_mm := pk_ssns_per_adl_c6_mm;
			self.pk_attr_addrs_last24_mm := pk_attr_addrs_last24_mm;
			self.pk_yr_add2_date_last_seen2_mm := pk_yr_add2_date_last_seen2_mm;
			self.pk_add3_mortgage_risk_mm := pk_add3_mortgage_risk_mm;
			self.pk_add2_parking_no_of_cars_mm := pk_add2_parking_no_of_cars_mm;
			self.pk2_add1_avm_med_mm := pk2_add1_avm_med_mm;
			self.pk_impulse_count_mm := pk_impulse_count_mm;
			self.pk_add2_no_of_buildings_mm := pk_add2_no_of_buildings_mm;
			self.pk_yr_add1_mortgage_date2_mm := pk_yr_add1_mortgage_date2_mm;
			self.pk_crime_level_mm := pk_crime_level_mm;
			self.pk_addrs_15yr_mm := pk_addrs_15yr_mm;
			self.pk_avm_hit_level_mm := pk_avm_hit_level_mm;
			self.pk_bk_level_mm := pk_bk_level_mm;
			self.pk_wealth_index_mm := pk_wealth_index_mm;
			self.pk2_add1_avm_to_med_ratio_mm := pk2_add1_avm_to_med_ratio_mm;
			self.pk2_add1_avm_auto_mm := pk2_add1_avm_auto_mm;
			self.pk_add1_assessed_amount2_mm := pk_add1_assessed_amount2_mm;
			self.pk_add3_lres_mm := pk_add3_lres_mm;
			self.pk_ams_age_mm := pk_ams_age_mm;
			self.pk_yr_prop2_sale_date2_mm := pk_yr_prop2_sale_date2_mm;
			self.pk_estimated_income_mm := pk_estimated_income_mm;
			self.pk_yr_add1_mortgage_due_date2_mm := pk_yr_add1_mortgage_due_date2_mm;
			self.pk_add2_mortgage_risk_mm := pk_add2_mortgage_risk_mm;
			self.pk_dist_a1toa2_mm := pk_dist_a1toa2_mm;
			self.pk_add1_own_level_mm := pk_add1_own_level_mm;
			self.pk2_add2_avm_auto4_mm := pk2_add2_avm_auto4_mm;
			self.pk_add3_assessed_amount2_mm := pk_add3_assessed_amount2_mm;
			self.pk_yr_add1_built_date2_mm := pk_yr_add1_built_date2_mm;
			self.pk_addrs_5yr_mm := pk_addrs_5yr_mm;
			self.pk_phones_per_addr_mm := pk_phones_per_addr_mm;
			self.pk_lien_type_level_mm := pk_lien_type_level_mm;
			self.pk2_add2_avm_auto3_mm := pk2_add2_avm_auto3_mm;
			self.pk_phones_per_adl_c6_mm := pk_phones_per_adl_c6_mm;
			self.pk_phones_per_addr_c6_mm := pk_phones_per_addr_c6_mm;
			self.pk_yr_liens_last_unrel_date3_mm := pk_yr_liens_last_unrel_date3_mm;
			self.segment_mean := segment_mean;
			self.pk_add_lres_month_avg2_mm_2 := pk_add_lres_month_avg2_mm_2;
			self.pk_add1_address_score_mm_2 := pk_add1_address_score_mm_2;
			self.pk_add1_assessed_amount2_mm_2 := pk_add1_assessed_amount2_mm_2;
			self.pk_add1_building_area2_mm_2 := pk_add1_building_area2_mm_2;
			self.pk_add1_land_use_risk_level_mm_2 := pk_add1_land_use_risk_level_mm_2;
			self.pk_add1_lres_mm_2 := pk_add1_lres_mm_2;
			self.pk_add1_mortgage_risk_mm_2 := pk_add1_mortgage_risk_mm_2;
			self.pk_add1_own_level_mm_2 := pk_add1_own_level_mm_2;
			self.pk_add1_purchase_amount2_mm_2 := pk_add1_purchase_amount2_mm_2;
			self.pk_add2_address_score_mm_2 := pk_add2_address_score_mm_2;
			self.pk_add2_assessed_amount2_mm_2 := pk_add2_assessed_amount2_mm_2;
			self.pk_add2_avm_auto_diff3_lvl_mm_2 := pk_add2_avm_auto_diff3_lvl_mm_2;
			self.pk_add2_em_ver_lvl_mm_2 := pk_add2_em_ver_lvl_mm_2;
			self.pk_add2_lres_mm_2 := pk_add2_lres_mm_2;
			self.pk_add2_mortgage_risk_mm_2 := pk_add2_mortgage_risk_mm_2;
			self.pk_add2_no_of_buildings_mm_2 := pk_add2_no_of_buildings_mm_2;
			self.pk_add2_own_level_mm_2 := pk_add2_own_level_mm_2;
			self.pk_add2_parking_no_of_cars_mm_2 := pk_add2_parking_no_of_cars_mm_2;
			self.pk_add2_pos_secondary_sources_mm_2 := pk_add2_pos_secondary_sources_mm_2;
			self.pk_add2_pos_sources_mm_2 := pk_add2_pos_sources_mm_2;
			self.pk_add3_assessed_amount2_mm_2 := pk_add3_assessed_amount2_mm_2;
			self.pk_add3_lres_mm_2 := pk_add3_lres_mm_2;
			self.pk_add3_mortgage_risk_mm_2 := pk_add3_mortgage_risk_mm_2;
			self.pk_add3_own_level_mm_2 := pk_add3_own_level_mm_2;
			self.pk_addrs_15yr_mm_2 := pk_addrs_15yr_mm_2;
			self.pk_addrs_5yr_mm_2 := pk_addrs_5yr_mm_2;
			self.pk_addrs_per_adl_c6_mm_2 := pk_addrs_per_adl_c6_mm_2;
			self.pk_addrs_per_adl_mm_2 := pk_addrs_per_adl_mm_2;
			self.pk_addrs_per_ssn_mm_2 := pk_addrs_per_ssn_mm_2;
			self.pk_addrs_sourced_lvl_mm_2 := pk_addrs_sourced_lvl_mm_2;
			self.pk_adl_score_mm_2 := pk_adl_score_mm_2;
			self.pk_adlperssn_count_mm_2 := pk_adlperssn_count_mm_2;
			self.pk_adls_per_addr_mm_2 := pk_adls_per_addr_mm_2;
			self.pk_adls_per_phone_c6_mm_2 := pk_adls_per_phone_c6_mm_2;
			self.pk_adls_per_phone_mm_2 := pk_adls_per_phone_mm_2;
			self.pk_ams_age_mm_2 := pk_ams_age_mm_2;
			self.pk_ams_class_level_mm_2 := pk_ams_class_level_mm_2;
			self.pk_ams_income_level_code_mm_2 := pk_ams_income_level_code_mm_2;
			self.pk_attr_addrs_last24_mm_2 := pk_attr_addrs_last24_mm_2;
			self.pk_attr_addrs_last36_mm_2 := pk_attr_addrs_last36_mm_2;
			self.pk_attr_num_nonderogs90_b_mm_2 := pk_attr_num_nonderogs90_b_mm_2;
			self.pk_attr_total_number_derogs_mm_2 := pk_attr_total_number_derogs_mm_2;
			self.pk_avm_auto_diff4_lvl_mm_2 := pk_avm_auto_diff4_lvl_mm_2;
			self.pk_avm_hit_level_mm_2 := pk_avm_hit_level_mm_2;
			self.pk_bk_level_mm_2 := pk_bk_level_mm_2;
			self.pk_college_tier_mm_2 := pk_college_tier_mm_2;
			self.pk_combo_addrscore_mm_2 := pk_combo_addrscore_mm_2;
			self.pk_combo_hphonescore_mm_2 := pk_combo_hphonescore_mm_2;
			self.pk_combo_ssnscore_mm_2 := pk_combo_ssnscore_mm_2;
			self.pk_crime_level_mm_2 := pk_crime_level_mm_2;
			self.pk_dist_a1toa2_mm_2 := pk_dist_a1toa2_mm_2;
			self.pk_dist_a1toa3_mm_2 := pk_dist_a1toa3_mm_2;
			self.pk_em_only_ver_lvl_mm_2 := pk_em_only_ver_lvl_mm_2;
			self.pk_eq_count_mm_2 := pk_eq_count_mm_2;
			self.pk_estimated_income_mm_2 := pk_estimated_income_mm_2;
			self.pk_eviction_level_mm_2 := pk_eviction_level_mm_2;
			self.pk_fname_eda_sourced_type_lvl_mm_2 := pk_fname_eda_sourced_type_lvl_mm_2;
			self.pk_impulse_count_mm_2 := pk_impulse_count_mm_2;
			self.pk_inferred_age_mm_2 := pk_inferred_age_mm_2;
			self.pk_infutor_risk_lvl_mm_2 := pk_infutor_risk_lvl_mm_2;
			self.pk_infutor_risk_lvl_nb_mm_2 := pk_infutor_risk_lvl_nb_mm_2;
			self.pk_lien_type_level_mm_2 := pk_lien_type_level_mm_2;
			self.pk_lname_eda_sourced_type_lvl_mm_2 := pk_lname_eda_sourced_type_lvl_mm_2;
			self.pk_lname_score_mm_2 := pk_lname_score_mm_2;
			self.pk_nameperssn_count_mm_2 := pk_nameperssn_count_mm_2;
			self.pk_nap_summary_mm_2 := pk_nap_summary_mm_2;
			self.pk_naprop_level2_mm_2 := pk_naprop_level2_mm_2;
			self.pk_nas_summary_mm_2 := pk_nas_summary_mm_2;
			self.pk_out_st_division_lvl_mm_2 := pk_out_st_division_lvl_mm_2;
			self.pk_phones_per_addr_c6_mm_2 := pk_phones_per_addr_c6_mm_2;
			self.pk_phones_per_addr_mm_2 := pk_phones_per_addr_mm_2;
			self.pk_phones_per_adl_c6_mm_2 := pk_phones_per_adl_c6_mm_2;
			self.pk_phones_per_adl_mm_2 := pk_phones_per_adl_mm_2;
			self.pk_pos_secondary_sources_mm_2 := pk_pos_secondary_sources_mm_2;
			self.pk_pr_count_mm_2 := pk_pr_count_mm_2;
			self.pk_prof_lic_cat_mm_2 := pk_prof_lic_cat_mm_2;
			self.pk_prop_own_assess_tot2_mm_2 := pk_prop_own_assess_tot2_mm_2;
			self.pk_prop1_sale_price2_mm_2 := pk_prop1_sale_price2_mm_2;
			self.pk_property_owned_total_mm_2 := pk_property_owned_total_mm_2;
			self.pk_rc_dirsaddr_lastscore_mm_2 := pk_rc_dirsaddr_lastscore_mm_2;
			self.pk_rc_disthphoneaddr_mm_2 := pk_rc_disthphoneaddr_mm_2;
			self.pk_ssnchar_invalid_or_recent_mm_2 := pk_ssnchar_invalid_or_recent_mm_2;
			self.pk_ssns_per_addr_c6_mm_2 := pk_ssns_per_addr_c6_mm_2;
			self.pk_ssns_per_addr2_mm_2 := pk_ssns_per_addr2_mm_2;
			self.pk_ssns_per_adl_c6_mm_2 := pk_ssns_per_adl_c6_mm_2;
			self.pk_ssns_per_adl_mm_2 := pk_ssns_per_adl_mm_2;
			self.pk_voter_flag_mm_2 := pk_voter_flag_mm_2;
			self.pk_watercraft_count_mm_2 := pk_watercraft_count_mm_2;
			self.pk_wealth_index_mm_2 := pk_wealth_index_mm_2;
			self.pk_yr_add1_built_date2_mm_2 := pk_yr_add1_built_date2_mm_2;
			self.pk_yr_add1_date_first_seen2_mm_2 := pk_yr_add1_date_first_seen2_mm_2;
			self.pk_yr_add1_mortgage_date2_mm_2 := pk_yr_add1_mortgage_date2_mm_2;
			self.pk_yr_add1_mortgage_due_date2_mm_2 := pk_yr_add1_mortgage_due_date2_mm_2;
			self.pk_yr_add2_assess_val_yr2_mm_2 := pk_yr_add2_assess_val_yr2_mm_2;
			self.pk_yr_add2_date_first_seen2_mm_2 := pk_yr_add2_date_first_seen2_mm_2;
			self.pk_yr_add2_date_last_seen2_mm_2 := pk_yr_add2_date_last_seen2_mm_2;
			self.pk_yr_add3_date_first_seen2_mm_2 := pk_yr_add3_date_first_seen2_mm_2;
			self.pk_yr_adl_em_only_first_seen2_mm_2 := pk_yr_adl_em_only_first_seen2_mm_2;
			self.pk_yr_adl_vo_first_seen2_mm_2 := pk_yr_adl_vo_first_seen2_mm_2;
			self.pk_yr_adl_w_last_seen2_mm_2 := pk_yr_adl_w_last_seen2_mm_2;
			self.pk_yr_credit_first_seen2_mm_2 := pk_yr_credit_first_seen2_mm_2;
			self.pk_yr_gong_did_first_seen2_mm_2 := pk_yr_gong_did_first_seen2_mm_2;
			self.pk_yr_header_first_seen2_mm_2 := pk_yr_header_first_seen2_mm_2;
			self.pk_yr_infutor_first_seen2_mm_2 := pk_yr_infutor_first_seen2_mm_2;
			self.pk_yr_liens_last_unrel_date3_mm_2 := pk_yr_liens_last_unrel_date3_mm_2;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_2 := pk_yr_ln_unrel_lt_f_sn2_mm_2;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_2 := pk_yr_ln_unrel_ot_f_sn2_mm_2;
			self.pk_yr_lname_change_date2_mm_2 := pk_yr_lname_change_date2_mm_2;
			self.pk_yr_prop2_sale_date2_mm_2 := pk_yr_prop2_sale_date2_mm_2;
			self.pk_yr_rc_ssnhighissue2_mm_2 := pk_yr_rc_ssnhighissue2_mm_2;
			self.pk_yr_reported_dob2_mm_2 := pk_yr_reported_dob2_mm_2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
			self.pk2_add1_avm_as_mm_2 := pk2_add1_avm_as_mm_2;
			self.pk2_add1_avm_auto_mm_2 := pk2_add1_avm_auto_mm_2;
			self.pk2_add1_avm_auto2_mm_2 := pk2_add1_avm_auto2_mm_2;
			self.pk2_add1_avm_auto3_mm_2 := pk2_add1_avm_auto3_mm_2;
			self.pk2_add1_avm_auto4_mm_2 := pk2_add1_avm_auto4_mm_2;
			self.pk2_add1_avm_hed_mm_2 := pk2_add1_avm_hed_mm_2;
			self.pk2_add1_avm_med_mm_2 := pk2_add1_avm_med_mm_2;
			self.pk2_add1_avm_mkt_mm_2 := pk2_add1_avm_mkt_mm_2;
			self.pk2_add1_avm_to_med_ratio_mm_2 := pk2_add1_avm_to_med_ratio_mm_2;
			self.pk2_add2_avm_auto_mm_2 := pk2_add2_avm_auto_mm_2;
			self.pk2_add2_avm_auto3_mm_2 := pk2_add2_avm_auto3_mm_2;
			self.pk2_add2_avm_auto4_mm_2 := pk2_add2_avm_auto4_mm_2;
			self.pk2_add2_avm_hed_mm_2 := pk2_add2_avm_hed_mm_2;
			self.pk2_add2_avm_mkt_mm_2 := pk2_add2_avm_mkt_mm_2;
			self.pk2_add2_avm_sp_mm_2 := pk2_add2_avm_sp_mm_2;
			self.pk2_yr_add1_avm_assess_year_mm_2 := pk2_yr_add1_avm_assess_year_mm_2;
			self.pk2_yr_add1_avm_rec_dt_mm_2 := pk2_yr_add1_avm_rec_dt_mm_2;
			self.addprob3_mod_dm_b1 := addprob3_mod_dm_b1;
			self.phnprob_mod_dm_b1 := phnprob_mod_dm_b1;
			self.ssnprob2_mod_dm_nodob_b1 := ssnprob2_mod_dm_nodob_b1;
			self.fp_mod5_dm_nodob_b1 := fp_mod5_dm_nodob_b1;
			self.age_mod3_nodob_dm_b1 := age_mod3_nodob_dm_b1;
			self.amstudent_mod_dm_b1 := amstudent_mod_dm_b1;
			self.avm_mod_dm_b1 := avm_mod_dm_b1;
			self.derog_mod3_dm_b1 := derog_mod3_dm_b1;
			self.distance_mod2_dm_b1 := distance_mod2_dm_b1;
			self.lien_mod_dm_b1 := lien_mod_dm_b1;
			self.lres_mod_dm_b1 := lres_mod_dm_b1;
			self.proflic_mod_dm_b1 := proflic_mod_dm_b1;
			self.property_mod_dm_b1 := property_mod_dm_b1;
			self.velocity2_mod_dm_b1 := velocity2_mod_dm_b1;
			self.ver_best_src_cnt_mod_dm_b1 := ver_best_src_cnt_mod_dm_b1;
			self.ver_notbest_src_cnt_mod_dm_b1 := ver_notbest_src_cnt_mod_dm_b1;
			self.ver_src_cnt_mod_dm_b1 := ver_src_cnt_mod_dm_b1;
			self.mod14_dm_nodob_b1 := mod14_dm_nodob_b1;
			self.amstudent_mod_om_b2 := amstudent_mod_om_b2;
			self.avm_mod_om_b2 := avm_mod_om_b2;
			self.lres_mod_om_b2 := lres_mod_om_b2;
			self.proflic_mod_om_b2 := proflic_mod_om_b2;
			self.property_mod_om_b2 := property_mod_om_b2;
			self.velocity2_mod_om_b2 := velocity2_mod_om_b2;
			self.ver_best_src_cnt_mod_om_b2 := ver_best_src_cnt_mod_om_b2;
			self.ver_best_src_time_mod_om_b2 := ver_best_src_time_mod_om_b2;
			self.ver_notbest_src_cnt_mod_om_b2 := ver_notbest_src_cnt_mod_om_b2;
			self.ver_notbest_src_time_mod_om_b2 := ver_notbest_src_time_mod_om_b2;
			self.ver_src_time_mod_om_b2 := ver_src_time_mod_om_b2;
			self.ver_src_cnt_mod_om_b2 := ver_src_cnt_mod_om_b2;
			self.mod14_om_nodob_b2 := mod14_om_nodob_b2;
			self.age_mod3_nodob_rm_b3 := age_mod3_nodob_rm_b3;
			self.amstudent_mod_rm_b3 := amstudent_mod_rm_b3;
			self.avm_mod_rm_b3 := avm_mod_rm_b3;
			self.distance_mod2_rm_b3 := distance_mod2_rm_b3;
			self.lres_mod_rm_b3 := lres_mod_rm_b3;
			self.proflic_mod_rm_b3 := proflic_mod_rm_b3;
			self.property_mod_rm_b3 := property_mod_rm_b3;
			self.velocity2_mod_rm_b3 := velocity2_mod_rm_b3;
			self.ver_best_score_mod_rm_nodob_b3 := ver_best_score_mod_rm_nodob_b3;
			self.ver_best_src_cnt_mod_rm_b3 := ver_best_src_cnt_mod_rm_b3;
			self.ver_best_src_time_mod_rm_b3 := ver_best_src_time_mod_rm_b3;
			self.ver_notbest_score_mod_rm_nodob_b3 := ver_notbest_score_mod_rm_nodob_b3;
			self.ver_notbest_src_cnt_mod_rm_b3 := ver_notbest_src_cnt_mod_rm_b3;
			self.ver_notbest_src_time_mod_rm_b3 := ver_notbest_src_time_mod_rm_b3;
			self.ver_src_time_mod_rm_b3 := ver_src_time_mod_rm_b3;
			self.ver_score_mod_rm_nodob_b3 := ver_score_mod_rm_nodob_b3;
			self.ver_src_cnt_mod_rm_b3 := ver_src_cnt_mod_rm_b3;
			self.mod14_rm_nodob_b3 := mod14_rm_nodob_b3;
			self.age_mod3_nodob_xm_b4 := age_mod3_nodob_xm_b4;
			self.amstudent_mod_xm_b4 := amstudent_mod_xm_b4;
			self.avm_mod_xm_b4 := avm_mod_xm_b4;
			self.distance_mod2_xm_b4 := distance_mod2_xm_b4;
			self.lres_mod_xm_b4 := lres_mod_xm_b4;
			self.property_mod_xm_b4 := property_mod_xm_b4;
			self.velocity2_mod_xm_b4 := velocity2_mod_xm_b4;
			self.ver_best_src_cnt_mod_xm_b4 := ver_best_src_cnt_mod_xm_b4;
			self.ver_best_src_time_mod_xm_b4 := ver_best_src_time_mod_xm_b4;
			self.ver_notbest_src_cnt_mod_xm_b4 := ver_notbest_src_cnt_mod_xm_b4;
			self.ver_notbest_src_time_mod_xm_b4 := ver_notbest_src_time_mod_xm_b4;
			self.ver_src_time_mod_xm_b4 := ver_src_time_mod_xm_b4;
			self.ver_src_cnt_mod_xm_b4 := ver_src_cnt_mod_xm_b4;
			self.mod14_xm_nodob_b4 := mod14_xm_nodob_b4;
			self.velocity2_mod_rm := velocity2_mod_rm;
			self.mod14_om_nodob := mod14_om_nodob;
			self.mod14_dm_nodob := mod14_dm_nodob;
			self.proflic_mod_rm := proflic_mod_rm;
			self.lien_mod_dm := lien_mod_dm;
			self.phat := phat;
			self.addprob3_mod_dm := addprob3_mod_dm;
			self.proflic_mod_om := proflic_mod_om;
			self.age_mod3_nodob_xm := age_mod3_nodob_xm;
			self.avm_mod_om := avm_mod_om;
			self.property_mod_xm := property_mod_xm;
			self.velocity2_mod_dm := velocity2_mod_dm;
			self.ver_notbest_score_mod_rm_nodob := ver_notbest_score_mod_rm_nodob;
			self.property_mod_rm := property_mod_rm;
			self.velocity2_mod_om := velocity2_mod_om;
			self.ver_src_time_mod_rm := ver_src_time_mod_rm;
			self.property_mod_dm := property_mod_dm;
			self.ver_notbest_src_cnt_mod_xm := ver_notbest_src_cnt_mod_xm;
			self.ver_best_src_time_mod_om := ver_best_src_time_mod_om;
			self.ver_best_src_cnt_mod_xm := ver_best_src_cnt_mod_xm;
			self.avm_mod_rm := avm_mod_rm;
			self.amstudent_mod_rm := amstudent_mod_rm;
			self.velocity2_mod_xm := velocity2_mod_xm;
			self.avm_mod_dm := avm_mod_dm;
			self.lres_mod_om := lres_mod_om;
			self.ver_best_src_cnt_mod_rm := ver_best_src_cnt_mod_rm;
			self.lres_mod_rm := lres_mod_rm;
			self.distance_mod2_rm := distance_mod2_rm;
			self.ver_score_mod_rm_nodob := ver_score_mod_rm_nodob;
			self.proflic_mod_dm := proflic_mod_dm;
			self.ver_notbest_src_time_mod_rm := ver_notbest_src_time_mod_rm;
			self.ver_best_src_cnt_mod_om := ver_best_src_cnt_mod_om;
			self.age_mod3_nodob_rm := age_mod3_nodob_rm;
			self.ver_src_cnt_mod_dm := ver_src_cnt_mod_dm;
			self.derog_mod3_dm := derog_mod3_dm;
			self.ssnprob2_mod_dm_nodob := ssnprob2_mod_dm_nodob;
			self.amstudent_mod_om := amstudent_mod_om;
			self.ver_src_time_mod_om := ver_src_time_mod_om;
			self.ver_notbest_src_cnt_mod_om := ver_notbest_src_cnt_mod_om;
			self.ver_notbest_src_cnt_mod_rm := ver_notbest_src_cnt_mod_rm;
			self.distance_mod2_dm := distance_mod2_dm;
			self.ver_best_src_cnt_mod_dm := ver_best_src_cnt_mod_dm;
			self.age_mod3_nodob_dm := age_mod3_nodob_dm;
			self.ver_src_cnt_mod_xm := ver_src_cnt_mod_xm;
			self.ver_notbest_src_time_mod_xm := ver_notbest_src_time_mod_xm;
			self.amstudent_mod_dm := amstudent_mod_dm;
			self.ver_notbest_src_time_mod_om := ver_notbest_src_time_mod_om;
			self.ver_best_score_mod_rm_nodob := ver_best_score_mod_rm_nodob;
			self.mod14_xm_nodob := mod14_xm_nodob;
			self.ver_src_cnt_mod_om := ver_src_cnt_mod_om;
			self.ver_best_src_time_mod_xm := ver_best_src_time_mod_xm;
			self.amstudent_mod_xm := amstudent_mod_xm;
			self.avm_mod_xm := avm_mod_xm;
			self.distance_mod2_xm := distance_mod2_xm;
			self.phnprob_mod_dm := phnprob_mod_dm;
			self.ver_src_cnt_mod_rm := ver_src_cnt_mod_rm;
			self.mod14_scr := mod14_scr;
			self.lres_mod_dm := lres_mod_dm;
			self.ver_best_src_time_mod_rm := ver_best_src_time_mod_rm;
			self.ver_notbest_src_cnt_mod_dm := ver_notbest_src_cnt_mod_dm;
			self.mod14_rm_nodob := mod14_rm_nodob;
			self.property_mod_om := property_mod_om;
			self.fp_mod5_dm_nodob := fp_mod5_dm_nodob;
			self.ver_src_time_mod_xm := ver_src_time_mod_xm;
			self.lres_mod_xm := lres_mod_xm;
			self.RVT1003 := RVT1003;
			self.ov_ssndead := ov_ssndead;
			self.ov_ssnprior := ov_ssnprior;
			self.ov_criminal_flag := ov_criminal_flag;
			self.ov_corrections := ov_corrections;
			self.ov_impulse := ov_impulse;
			self.rvt1003_2 := rvt1003_2;
			self.scored_222s := scored_222s;
			self.rvt1003_3 := rvt1003_3;
		#else
			self.seq := le.seq;
			inCalif := isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
			self.ri := riskwise.rv3telecomReasonCodes( le, 4, inCalif, PreScreenOptOut );
			self.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				intformat(rvt1003_3,3,1)
			);
		#end
		self := [];
	end;

	model := project( clam, doModel(left) );
	return model;

end;


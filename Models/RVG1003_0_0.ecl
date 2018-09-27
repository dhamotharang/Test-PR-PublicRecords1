	import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

	export RVG1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia=false, boolean PreScreenOptOut=false ) := FUNCTION

		RVG_DEBUG := false;
		
		#if(RVG_DEBUG)
		Layout_Debug := record
			unsigned seq;
			typeof(clam.truedid) truedid;
			typeof(clam.adlcategory) adl_category;
			typeof(clam.shell_input.unit_desig) out_unit_desig;
			typeof(clam.shell_input.sec_range) out_sec_range;
			typeof(clam.shell_input.st) out_st;
			typeof(clam.shell_input.addr_type) out_addr_type;
			typeof(clam.shell_input.addr_status) out_addr_status;
			typeof(clam.shell_input.dob) in_dob;
			typeof(clam.iid.nas_summary) nas_summary;
			typeof(clam.iid.nap_summary) nap_summary;
			typeof(clam.iid.didcount) did_count;
			typeof(clam.iid.dirsaddr_lastscore) rc_dirsaddr_lastscore;
			typeof(clam.iid.hriskphoneflag) rc_hriskphoneflag;
			typeof(clam.iid.phonevalflag) rc_phonevalflag;
			typeof(clam.iid.phonezipflag) rc_phonezipflag;
			typeof(clam.iid.pwphonezipflag) rc_pwphonezipflag;
			typeof(clam.iid.decsflag) rc_decsflag;
			typeof(clam.iid.socsdobflag) rc_ssndobflag;
			typeof(clam.iid.pwsocsdobflag) rc_pwssndobflag;
			typeof(clam.iid.pwsocsvalflag) rc_pwssnvalflag;
			unsigned rc_ssnhighissue;
			typeof(clam.iid.areacodesplitflag) rc_areacodesplitflag;
			typeof(clam.iid.addrvalflag) rc_addrvalflag;
			typeof(clam.iid.dwelltype) rc_dwelltype;
			typeof(clam.iid.bansflag) rc_bansflag;
			typeof(clam.iid.sources) rc_sources;
			typeof(clam.iid.addrcount) rc_addrcount;
			typeof(clam.iid.phonelastcount) rc_phonelnamecount;
			typeof(clam.iid.phonephonecount) rc_phonephonecount;
			typeof(clam.iid.hrisksic) rc_hrisksic;
			typeof(clam.iid.disthphoneaddr) rc_disthphoneaddr;
			typeof(clam.iid.firstssnmatch) rc_fnamessnmatch;
			typeof(clam.iid.combo_hphonescore) combo_hphonescore;
			typeof(clam.iid.combo_ssnscore) combo_ssnscore;
			typeof(clam.iid.combo_dobscore) combo_dobscore;
			typeof(clam.iid.combo_firstcount) combo_fnamecount;
			typeof(clam.iid.combo_addrcount) combo_addrcount;
			typeof(clam.iid.combo_ssncount) combo_ssncount;
			typeof(clam.iid.combo_dobcount) combo_dobcount;
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
			typeof(clam.source_verification.firstnamesources) fname_sources;
			typeof(clam.source_verification.lastnamesources) lname_sources;
			typeof(clam.source_verification.addrsources) addr_sources;
			typeof(clam.source_verification.em_only_sources) em_only_sources;
			typeof(clam.available_sources.voter) voter_avail;
			typeof(clam.input_validation.ssn_length) ssnlength;
			typeof(clam.input_validation.dateofbirth) dobpop;
			typeof(clam.name_verification.adl_score) adl_score;
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
			typeof(clam.avm.input_address_information.avm_sales_price) add1_avm_sales_price;
			typeof(clam.avm.input_address_information.avm_assessed_total_value) add1_avm_assessed_total_value;
			typeof(clam.avm.input_address_information.avm_automated_valuation) add1_avm_automated_valuation;
			typeof(clam.avm.input_address_information.avm_automated_valuation2) add1_avm_automated_valuation_2;
			typeof(clam.avm.input_address_information.avm_automated_valuation3) add1_avm_automated_valuation_3;
			typeof(clam.avm.input_address_information.avm_median_fips_level) add1_avm_med_fips;
			typeof(clam.avm.input_address_information.avm_median_geo11_level) add1_avm_med_geo11;
			typeof(clam.avm.input_address_information.avm_median_geo12_level) add1_avm_med_geo12;
			typeof(clam.address_verification.input_address_information.applicant_owned) add1_applicant_owned;
			typeof(clam.address_verification.input_address_information.occupant_owned) add1_occupant_owned;
			typeof(clam.address_verification.input_address_information.family_owned) add1_family_owned;
			typeof(clam.address_verification.input_address_information.naprop) add1_naprop;
			typeof(clam.address_verification.input_address_information.built_date) add1_built_date;
			typeof(clam.address_verification.input_address_information.purchase_amount) add1_purchase_amount;
			typeof(clam.address_verification.input_address_information.mortgage_amount) add1_mortgage_amount;
			typeof(clam.address_verification.input_address_information.mortgage_date) add1_mortgage_date;
			typeof(clam.address_verification.input_address_information.mortgage_type) add1_mortgage_type;
			typeof(clam.address_verification.input_address_information.type_financing) add1_financing_type;
			typeof(clam.address_verification.input_address_information.assessed_amount) add1_assessed_amount;
			typeof(clam.address_verification.input_address_information.date_first_seen) add1_date_first_seen;
			string add1_building_area;
			string add1_no_of_rooms;
			typeof(clam.address_verification.input_address_information.garage_type_code) add1_garage_type_code;
			typeof(clam.address_verification.input_address_information.style_code) add1_style_code;
			typeof(clam.addrpop) add1_pop;
			typeof(clam.address_verification.owned.property_total) property_owned_total;
			typeof(clam.address_verification.sold.property_total) property_sold_total;
			typeof(clam.address_verification.sold.property_owned_assessed_total) property_sold_assessed_total;
			typeof(clam.address_verification.recent_property_sales.prev_purch_price1) prop1_prev_purchase_price;
			typeof(clam.address_verification.distance_in_2_h1) dist_a1toa2;
			typeof(clam.address_verification.distance_in_2_h2) dist_a1toa3;
			typeof(clam.address_verification.distance_h1_2_h2) dist_a2toa3;
			typeof(clam.address_verification.address_history_1.address_score) add2_address_score;
			typeof(clam.avm.address_history_1.avm_land_use_code) add2_avm_land_use;
			typeof(clam.avm.address_history_1.avm_hedonic_valuation) add2_avm_hedonic_valuation;
			typeof(clam.avm.address_history_1.avm_automated_valuation) add2_avm_automated_valuation;
			typeof(clam.avm.address_history_1.avm_automated_valuation3) add2_avm_automated_valuation_3;
			typeof(clam.address_verification.address_history_1.sources) add2_sources;
			typeof(clam.address_verification.address_history_1.naprop) add2_naprop;
			string add2_building_area;
			string add2_no_of_buildings;
			string add2_no_of_rooms;
			typeof(clam.address_verification.address_history_1.style_code) add2_style_code;
			typeof(clam.address_verification.address_history_1.assessed_value_year) add2_assessed_value_year;
			typeof(clam.address_verification.address_history_1.purchase_amount) add2_purchase_amount;
			typeof(clam.address_verification.address_history_1.mortgage_type) add2_mortgage_type;
			typeof(clam.address_verification.address_history_1.assessed_amount) add2_assessed_amount;
			typeof(clam.address_verification.address_history_1.date_first_seen) add2_date_first_seen;
			typeof(clam.address_verification.address_history_1.date_last_seen) add2_date_last_seen;
			typeof(clam.lres3) add3_lres;
			typeof(clam.address_verification.address_history_2.sources) add3_sources;
			typeof(clam.address_verification.address_history_2.naprop) add3_naprop;
			typeof(clam.address_verification.address_history_2.purchase_amount) add3_purchase_amount;
			typeof(clam.address_verification.address_history_2.mortgage_type) add3_mortgage_type;
			typeof(clam.address_verification.address_history_2.assessed_amount) add3_assessed_amount;
			typeof(clam.address_verification.address_history_2.date_first_seen) add3_date_first_seen;
			typeof(clam.address_verification.address_history_2.date_last_seen) add3_date_last_seen;
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
			typeof(clam.velocity_counters.adls_per_addr) adls_per_addr;
			typeof(clam.velocity_counters.ssns_per_addr) ssns_per_addr;
			typeof(clam.velocity_counters.phones_per_addr) phones_per_addr;
			typeof(clam.velocity_counters.adls_per_phone) adls_per_phone;
			typeof(clam.velocity_counters.ssns_per_adl_created_6months) ssns_per_adl_c6;
			typeof(clam.velocity_counters.ssns_per_addr_created_6months) ssns_per_addr_c6;
			typeof(clam.velocity_counters.adls_per_phone_created_6months) adls_per_phone_c6;
			typeof(clam.velocity_counters.vo_addrs_per_adl) vo_addrs_per_adl;
			typeof(clam.velocity_counters.invalid_addrs_per_adl_created_6months) invalid_addrs_per_adl_c6;
			typeof(clam.infutor_phone.infutor_date_first_seen) infutor_first_seen;
			typeof(clam.infutor_phone.infutor_nap) infutor_nap;
			typeof(clam.impulse.count) impulse_count;
			typeof(clam.other_address_info.addrs_last24) attr_addrs_last24;
			typeof(clam.other_address_info.num_sold180) attr_num_sold180;
			typeof(clam.watercraft.watercraft_count180) attr_num_watercraft180;
			typeof(clam.watercraft.watercraft_count60) attr_num_watercraft60;
			typeof(clam.total_number_derogs) attr_total_number_derogs;
			typeof(clam.bjl.eviction_count) attr_eviction_count;
			typeof(clam.bjl.last_eviction_date) attr_date_last_eviction;
			typeof(clam.bjl.eviction_count30) attr_eviction_count30;
			typeof(clam.bjl.eviction_count90) attr_eviction_count90;
			typeof(clam.bjl.eviction_count180) attr_eviction_count180;
			typeof(clam.bjl.eviction_count12) attr_eviction_count12;
			typeof(clam.bjl.eviction_count24) attr_eviction_count24;
			typeof(clam.bjl.eviction_count36) attr_eviction_count36;
			typeof(clam.bjl.eviction_count60) attr_eviction_count60;
			typeof(clam.source_verification.num_nonderogs90) attr_num_nonderogs90;
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
			typeof(clam.student.age) ams_age;
			typeof(clam.student.class) ams_class;
			typeof(clam.student.college_tier) college_tier;
			typeof(clam.student.college_code) ams_college_code;
			typeof(clam.student.income_level_code) ams_income_level_code;
			typeof(clam.professional_license.professional_license_flag) prof_license_flag;
			typeof(clam.professional_license.plcategory) prof_license_category;
			typeof(clam.wealth_indicator) wealth_index;
			typeof(clam.dobmatchlevel) input_dob_match_level;
			typeof(clam.inferred_age) inferred_age;
			typeof(clam.reported_dob) reported_dob;
			String archive_date;
			Integer sysdate;
			Integer sysyear;
			Integer in_dob2;
			Real years_in_dob;
			Real months_in_dob;
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
			Integer add1_built_date2;
			Real years_add1_built_date;
			Real months_add1_built_date;
			Integer add1_mortgage_date2;
			Real years_add1_mortgage_date;
			Real months_add1_mortgage_date;
			Integer add1_date_first_seen2;
			Real years_add1_date_first_seen;
			Real months_add1_date_first_seen;
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
			Integer add3_date_last_seen2;
			Real years_add3_date_last_seen;
			Real months_add3_date_last_seen;
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
			Integer attr_date_last_eviction2;
			Real years_attr_date_last_eviction;
			Real months_attr_date_last_eviction;
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
			Boolean source_fst_PL;
			Boolean source_lst_PL;
			Boolean source_add_P;
			Boolean source_add_PL;
			Boolean source_add2_EM;
			Boolean source_add2_VO;
			Boolean source_add2_EQ;
			Boolean source_add2_P;
			Boolean source_add2_WP;
			Boolean source_add2_voter;
			Boolean source_add3_P;
			Boolean source_add3_W;
			Boolean em_only_source_EM;
			Boolean em_only_source_E1;
			Boolean em_only_source_E2;
			Boolean em_only_source_E3;
			Boolean em_only_source_E4;
			Boolean verfst_p;
			Boolean verlst_p;
			Boolean veradd_p;
			Boolean verphn_p;
			Integer ver_phncount;
			Real years_adl_first_seen_max_fcra;
			Real months_adl_first_seen_max_fcra;
			String add_ec1;
			String add_ec3;
			String add_ec4;
			Boolean add_apt;
			Boolean phn_highrisk2;
			Boolean phn_zipmismatch;
			Boolean ssn_issued18;
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
			Boolean add_apt_2;
			Integer pk_bk_level;
			Integer add1_avm_med_2;
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
			Integer pk_yr_adl_em_first_seen;
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
			Integer pk_combo_hphonescore;
			Integer pk_combo_ssnscore;
			Integer pk_combo_dobscore;
			Integer pk_combo_fnamecount;
			Integer pk_combo_fnamecount_nb;
			Integer pk_rc_phonelnamecount;
			Integer pk_combo_addrcount_nb;
			Integer pk_rc_addrcount;
			Integer pk_rc_addrcount_nb;
			Integer pk_rc_phonephonecount;
			Integer pk_ver_phncount;
			Integer pk_gong_did_phone_ct;
			Integer pk_gong_did_phone_ct_nb;
			Integer pk_combo_ssncount;
			Integer pk_combo_dobcount;
			Integer pk_combo_dobcount_nb;
			Integer pk_eq_count;
			Integer pk_pos_secondary_sources;
			Integer pk_voter_flag;
			Integer pk_fname_eda_sourced_type_lvl;
			Integer pk_lname_eda_sourced_type_lvl;
			Integer pk_add1_address_score;
			Integer pk_add1_unit_count2;
			Integer pk_add2_address_score;
			Integer pk_add2_pos_sources;
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
			Integer pk_add2_em_ver_lvl;
			Integer pk_ssnchar_invalid_or_recent_2;
			Integer pk_infutor_risk_lvl;
			Integer pk_infutor_risk_lvl_nb;
			Integer pk_yr_adl_em_first_seen2;
			Integer pk_yr_adl_vo_first_seen2;
			Integer pk_yr_adl_em_only_first_seen2;
			Integer pk_yrmo_adl_first_seen_max_fcra2;
			Integer pk_yr_lname_change_date2;
			Integer pk_yr_gong_did_first_seen2;
			Integer pk_yr_credit_first_seen2;
			Integer pk_yr_header_first_seen2;
			Integer pk_yr_infutor_first_seen2;
			Integer pk_estimated_income;
			Integer pk_yr_adl_pr_first_seen;
			Integer pk_yr_adl_w_first_seen;
			Integer pk_yr_adl_w_last_seen;
			Integer pk_yr_add1_built_date;
			Integer pk_yr_add1_mortgage_date;
			Integer pk_yr_add1_date_first_seen;
			Integer pk_yr_add2_assessed_value_year;
			Integer pk_yr_add2_date_first_seen;
			Integer pk_yr_add2_date_last_seen;
			Integer pk_yr_add3_date_first_seen;
			Integer pk_yr_add3_date_last_seen;
			Integer pk_prop1_prev_purchase_price;
			Integer pk_add1_purchase_amount;
			Integer pk_add1_mortgage_amount;
			Integer pk_add1_assessed_amount;
			Integer pk_add2_purchase_amount;
			Integer pk_add2_assessed_amount;
			Integer pk_add3_purchase_amount;
			Integer pk_add3_assessed_amount;
			Integer pk_prop1_prev_purchase_price_2;
			Integer pk_add1_purchase_amount_2;
			Integer pk_add1_mortgage_amount_2;
			Integer pk_add1_assessed_amount_2;
			Integer pk_add2_purchase_amount_2;
			Integer pk_add2_assessed_amount_2;
			Integer pk_add3_purchase_amount_2;
			Integer pk_add3_assessed_amount_2;
			Integer pk_add1_building_area;
			Integer pk_add2_building_area;
			Integer pk_yr_adl_pr_first_seen2;
			Integer pk_yr_adl_w_first_seen2;
			Integer pk_yr_adl_w_last_seen2;
			Integer pk_pr_count;
			Integer pk_addrs_sourced_lvl;
			Integer pk_add1_own_level;
			Integer pk_naprop_level;
			Integer pk_naprop_level2_b1;
			Integer pk_naprop_level2;
			Integer pk_yr_add1_built_date2;
			Integer pk_add1_purchase_amount2;
			Integer pk_add1_mortgage_amount2;
			Integer pk_yr_add1_mortgage_date2;
			Integer pk_add1_adjustable_financing;
			Integer pk_add1_assessed_amount2;
			Integer pk_yr_add1_date_first_seen2;
			Integer pk_add1_building_area2;
			Integer pk_add1_no_of_rooms;
			Integer pk_add1_garage_type_risk_level;
			Integer pk_add1_style_code_level;
			Integer pk_property_owned_total;
			Integer pk_prop1_prev_purchase_price2;
			Integer pk_add2_building_area2;
			Integer pk_add2_no_of_buildings;
			Integer pk_add2_no_of_rooms;
			Integer pk_add2_style_code_level;
			Integer pk_yr_add2_assessed_value_year2;
			Integer pk_add2_purchase_amount2;
			Integer pk_add2_mortgage_risk;
			Integer pk_add2_assessed_amount2;
			Integer pk_yr_add2_date_first_seen2;
			Integer pk_yr_add2_date_last_seen2;
			Integer pk_add3_purchase_amount2;
			Integer pk_add3_mortgage_risk;
			Integer pk_add3_assessed_amount2;
			Integer pk_yr_add3_date_first_seen2;
			Integer pk_yr_add3_date_last_seen2;
			Integer pk_attr_num_sold180;
			Integer pk_attr_num_watercraft180;
			Integer pk_yr_liens_last_unrel_date;
			Integer pk_yr_liens_unrel_lt_first_seen;
			Integer pk_yr_liens_unrel_ot_first_seen;
			Integer pk_yr_attr_date_last_eviction;
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
			Integer pk_yr_attr_date_last_eviction2;
			Integer pk_eviction_level;
			Integer pk_crime_level;
			Integer pk_attr_total_number_derogs_3;
			Integer pk_yr_rc_ssnhighissue;
			Integer pk_add_standarization_error;
			Integer pk_addr_changed;
			Integer pk_unit_changed;
			Integer pk_add_standarization_flag;
			Integer pk_addr_not_valid;
			Integer pk_area_code_split;
			Integer pk_yr_rc_ssnhighissue2;
			Integer pk_pl_sourced_level;
			Integer pk_prof_lic_cat;
			Integer pk_add_lres_month_avg;
			Integer pk_add1_lres;
			Integer pk_add3_lres;
			Integer pk_addrs_5yr;
			Integer pk_addrs_10yr;
			Integer pk_addrs_15yr;
			Integer pk_add_lres_month_avg2;
			Integer pk_nameperssn_count;
			Integer pk_ssns_per_adl;
			Integer pk_addrs_per_adl;
			Integer pk_phones_per_adl;
			Integer pk_adlperssn_count;
			Integer pk_adls_per_addr_b1;
			Integer pk_ssns_per_addr2_b1;
			Integer pk_adls_per_addr_b2;
			Integer pk_ssns_per_addr2_b2;
			Integer pk_phones_per_addr_b2;
			Integer pk_phones_per_addr;
			Integer pk_adls_per_addr;
			Integer pk_ssns_per_addr2;
			Integer pk_adls_per_phone;
			Integer pk_ssns_per_adl_c6;
			Integer pk_ssns_per_addr_c6_b1;
			Integer pk_ssns_per_addr_c6_b2;
			Integer pk_ssns_per_addr_c6;
			Integer pk_adls_per_phone_c6;
			Integer pk_vo_addrs_per_adl;
			Integer pk_attr_addrs_last24;
			Integer pk_college_tier;
			Real ams_class_n_b8;
			Real ams_class_n_b8_2;
			Integer pk_ams_class_level_b8;
			Real pk_since_ams_class_year;
			Real ams_class_n;
			Integer pk_ams_class_level;
			Integer pk_ams_income_level_code;
			Integer pk_yr_in_dob;
			Integer pk_yr_reported_dob;
			Integer pk_yr_in_dob2;
			Integer pk_ams_age;
			Integer pk_inferred_age;
			Integer pk_yr_reported_dob2;
			Integer pk_add1_avm_sp;
			Integer pk_add1_avm_as;
			Integer pk_add1_avm_auto2;
			Integer pk_add1_avm_auto3;
			Integer pk_add1_avm_med;
			Integer pk_add2_avm_hed;
			Integer pk_add2_avm_auto;
			Integer pk_add2_avm_auto3;
			Integer pk_add1_avm_sp_2;
			Integer pk_add1_avm_as_2;
			Integer pk_add1_avm_auto2_2;
			Integer pk_add1_avm_auto3_2;
			Integer pk_add1_avm_med_2;
			Integer pk_add2_avm_hed_2;
			Integer pk_add2_avm_auto_2;
			Integer pk_add2_avm_auto3_2;
			Real pk_add1_avm_to_med_ratio;
			Real pk_add1_avm_to_med_ratio_2;
			Integer pk2_add1_avm_sp;
			Integer pk2_add1_avm_as;
			Integer pk2_add1_avm_auto2;
			Integer pk2_add1_avm_auto3;
			Integer pk2_add1_avm_med;
			Integer pk2_add1_avm_to_med_ratio;
			Integer pk_add2_avm_hit;
			Integer pk_avm_hit_level;
			Integer pk2_add2_avm_hed;
			Integer pk2_add2_avm_auto3;
			Integer pk_add2_avm_auto_diff3;
			Integer pk_add2_avm_auto_diff3_lvl;
			Integer pk_dist_a1toa2_2;
			Integer pk_dist_a1toa3_2;
			Integer pk_out_st_division_lvl;
			Integer pk_impulse_count;
			Integer pk_impulse_count_2;
			Integer pk_attr_total_number_derogs_4;
			Integer pk_attr_total_number_derogs_5;
			Integer pk_attr_num_nonderogs90_3;
			Integer pk_attr_num_nonderogs90_4;
			Integer pk_attr_num_nonderogs90_b;
			Integer pk_adl_cat_deceased;
			Integer bs_attr_derog_flag;
			Integer bs_attr_eviction_flag;
			Integer bs_attr_derog_flag2;
			Integer pk_own_flag;
			String pk_Segment3;
			String pk_segment3_2;
			Real pk_nas_summary_mm_b1_c2_b1;
			Real pk_nap_summary_mm_b1_c2_b1;
			Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
			Real pk_adl_score_mm_b1_c2_b1;
			Real pk_combo_hphonescore_mm_b1_c2_b1;
			Real pk_combo_ssnscore_mm_b1_c2_b1;
			Real pk_combo_dobscore_mm_b1_c2_b1;
			Real pk_combo_fnamecount_mm_b1_c2_b1;
			Real pk_rc_phonelnamecount_mm_b1_c2_b1;
			Real pk_rc_addrcount_mm_b1_c2_b1;
			Real pk_rc_phonephonecount_mm_b1_c2_b1;
			Real pk_ver_phncount_mm_b1_c2_b1;
			Real pk_gong_did_phone_ct_mm_b1_c2_b1;
			Real pk_combo_ssncount_mm_b1_c2_b1;
			Real pk_combo_dobcount_mm_b1_c2_b1;
			Real pk_eq_count_mm_b1_c2_b1;
			Real pk_pos_secondary_sources_mm_b1_c2_b1;
			Real pk_voter_flag_mm_b1_c2_b1;
			Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1;
			Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
			Real pk_add1_address_score_mm_b1_c2_b1;
			Real pk_add2_address_score_mm_b1_c2_b1;
			Real pk_add2_pos_sources_mm_b1_c2_b1;
			Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
			Real pk_infutor_risk_lvl_mm_b1_c2_b1;
			Real pk_yr_adl_em_first_seen2_mm_b1_c2_b1;
			Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b1;
			Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
			Real pk_yr_lname_change_date2_mm_b1_c2_b1;
			Real pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
			Real pk_yr_credit_first_seen2_mm_b1_c2_b1;
			Real pk_yr_header_first_seen2_mm_b1_c2_b1;
			Real pk_yr_infutor_first_seen2_mm_b1_c2_b1;
			Real pk_add2_em_ver_lvl_mm_b1_c2_b1;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
			Real pk_nas_summary_mm_b1_c2_b2;
			Real pk_nap_summary_mm_b1_c2_b2;
			Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
			Real pk_adl_score_mm_b1_c2_b2;
			Real pk_combo_hphonescore_mm_b1_c2_b2;
			Real pk_combo_ssnscore_mm_b1_c2_b2;
			Real pk_combo_dobscore_mm_b1_c2_b2;
			Real pk_combo_fnamecount_mm_b1_c2_b2;
			Real pk_rc_phonelnamecount_mm_b1_c2_b2;
			Real pk_rc_addrcount_mm_b1_c2_b2;
			Real pk_rc_phonephonecount_mm_b1_c2_b2;
			Real pk_ver_phncount_mm_b1_c2_b2;
			Real pk_gong_did_phone_ct_mm_b1_c2_b2;
			Real pk_combo_ssncount_mm_b1_c2_b2;
			Real pk_combo_dobcount_mm_b1_c2_b2;
			Real pk_eq_count_mm_b1_c2_b2;
			Real pk_pos_secondary_sources_mm_b1_c2_b2;
			Real pk_voter_flag_mm_b1_c2_b2;
			Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2;
			Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
			Real pk_add1_address_score_mm_b1_c2_b2;
			Real pk_add2_address_score_mm_b1_c2_b2;
			Real pk_add2_pos_sources_mm_b1_c2_b2;
			Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
			Real pk_infutor_risk_lvl_mm_b1_c2_b2;
			Real pk_yr_adl_em_first_seen2_mm_b1_c2_b2;
			Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b2;
			Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
			Real pk_yr_lname_change_date2_mm_b1_c2_b2;
			Real pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
			Real pk_yr_credit_first_seen2_mm_b1_c2_b2;
			Real pk_yr_header_first_seen2_mm_b1_c2_b2;
			Real pk_yr_infutor_first_seen2_mm_b1_c2_b2;
			Real pk_add2_em_ver_lvl_mm_b1_c2_b2;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
			Real pk_nas_summary_mm_b1_c2_b3;
			Real pk_nap_summary_mm_b1_c2_b3;
			Real pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
			Real pk_adl_score_mm_b1_c2_b3;
			Real pk_combo_hphonescore_mm_b1_c2_b3;
			Real pk_combo_ssnscore_mm_b1_c2_b3;
			Real pk_combo_dobscore_mm_b1_c2_b3;
			Real pk_combo_fnamecount_mm_b1_c2_b3;
			Real pk_rc_phonelnamecount_mm_b1_c2_b3;
			Real pk_rc_addrcount_mm_b1_c2_b3;
			Real pk_rc_phonephonecount_mm_b1_c2_b3;
			Real pk_ver_phncount_mm_b1_c2_b3;
			Real pk_gong_did_phone_ct_mm_b1_c2_b3;
			Real pk_combo_ssncount_mm_b1_c2_b3;
			Real pk_combo_dobcount_mm_b1_c2_b3;
			Real pk_eq_count_mm_b1_c2_b3;
			Real pk_pos_secondary_sources_mm_b1_c2_b3;
			Real pk_voter_flag_mm_b1_c2_b3;
			Real pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3;
			Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
			Real pk_add1_address_score_mm_b1_c2_b3;
			Real pk_add2_address_score_mm_b1_c2_b3;
			Real pk_add2_pos_sources_mm_b1_c2_b3;
			Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
			Real pk_infutor_risk_lvl_mm_b1_c2_b3;
			Real pk_yr_adl_em_first_seen2_mm_b1_c2_b3;
			Real pk_yr_adl_vo_first_seen2_mm_b1_c2_b3;
			Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
			Real pk_yr_lname_change_date2_mm_b1_c2_b3;
			Real pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
			Real pk_yr_credit_first_seen2_mm_b1_c2_b3;
			Real pk_yr_header_first_seen2_mm_b1_c2_b3;
			Real pk_yr_infutor_first_seen2_mm_b1_c2_b3;
			Real pk_add2_em_ver_lvl_mm_b1_c2_b3;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
			Real pk_nap_summary_mm_b1;
			Real pk_yr_infutor_first_seen2_mm_b1;
			Real pk_yr_lname_change_date2_mm_b1;
			Real pk_ssnchar_invalid_or_recent_mm_b1;
			Real pk_yr_adl_em_first_seen2_mm_b1;
			Real pk_adl_score_mm_b1;
			Real pk_rc_phonelnamecount_mm_b1;
			Real pk_rc_dirsaddr_lastscore_mm_b1;
			Real pk_combo_ssncount_mm_b1;
			Real pk_yr_adl_vo_first_seen2_mm_b1;
			Real pk_pos_secondary_sources_mm_b1;
			Real pk_voter_flag_mm_b1;
			Real pk_add2_address_score_mm_b1;
			Real pk_combo_ssnscore_mm_b1;
			Real pk_lname_eda_sourced_type_lvl_mm_b1;
			Real pk_combo_dobscore_mm_b1;
			Real pk_ver_phncount_mm_b1;
			Real pk_combo_dobcount_mm_b1;
			Real pk_nas_summary_mm_b1;
			Real pk_rc_addrcount_mm_b1;
			Real pk_gong_did_phone_ct_mm_b1;
			Real pk_yr_gong_did_first_seen2_mm_b1;
			Real pk_combo_hphonescore_mm_b1;
			Real pk_yr_adl_em_only_first_seen2_mm_b1;
			Real pk_add2_em_ver_lvl_mm_b1;
			Real pk_yr_credit_first_seen2_mm_b1;
			Real pk_eq_count_mm_b1;
			Real pk_yr_header_first_seen2_mm_b1;
			Real pk_add1_address_score_mm_b1;
			Real pk_combo_fnamecount_mm_b1;
			Real pk_rc_phonephonecount_mm_b1;
			Real pk_add2_pos_sources_mm_b1;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
			Real pk_fname_eda_sourced_type_lvl_mm_b1;
			Real pk_infutor_risk_lvl_mm_b1;
			Real pk_nas_summary_mm_b2_c2_b1;
			Real pk_nap_summary_mm_b2_c2_b1;
			Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
			Real pk_adl_score_mm_b2_c2_b1;
			Real pk_combo_hphonescore_mm_b2_c2_b1;
			Real pk_combo_ssnscore_mm_b2_c2_b1;
			Real pk_combo_dobscore_mm_b2_c2_b1;
			Real pk_combo_fnamecount_nb_mm_b2_c2_b1;
			Real pk_rc_phonelnamecount_mm_b2_c2_b1;
			Real pk_combo_addrcount_nb_mm_b2_c2_b1;
			Real pk_rc_addrcount_nb_mm_b2_c2_b1;
			Real pk_rc_phonephonecount_mm_b2_c2_b1;
			Real pk_ver_phncount_mm_b2_c2_b1;
			Real pk_gong_did_phone_ct_nb_mm_b2_c2_b1;
			Real pk_combo_ssncount_mm_b2_c2_b1;
			Real pk_combo_dobcount_nb_mm_b2_c2_b1;
			Real pk_eq_count_mm_b2_c2_b1;
			Real pk_pos_secondary_sources_mm_b2_c2_b1;
			Real pk_voter_flag_mm_b2_c2_b1;
			Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1;
			Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
			Real pk_add1_address_score_mm_b2_c2_b1;
			Real pk_add2_address_score_mm_b2_c2_b1;
			Real pk_add2_pos_sources_mm_b2_c2_b1;
			Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
			Real pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
			Real pk_yr_adl_em_first_seen2_mm_b2_c2_b1;
			Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b1;
			Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
			Real pk_yr_lname_change_date2_mm_b2_c2_b1;
			Real pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
			Real pk_yr_credit_first_seen2_mm_b2_c2_b1;
			Real pk_yr_header_first_seen2_mm_b2_c2_b1;
			Real pk_yr_infutor_first_seen2_mm_b2_c2_b1;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
			Real pk_nas_summary_mm_b2_c2_b2;
			Real pk_nap_summary_mm_b2_c2_b2;
			Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
			Real pk_adl_score_mm_b2_c2_b2;
			Real pk_combo_hphonescore_mm_b2_c2_b2;
			Real pk_combo_ssnscore_mm_b2_c2_b2;
			Real pk_combo_dobscore_mm_b2_c2_b2;
			Real pk_combo_fnamecount_nb_mm_b2_c2_b2;
			Real pk_rc_phonelnamecount_mm_b2_c2_b2;
			Real pk_combo_addrcount_nb_mm_b2_c2_b2;
			Real pk_rc_addrcount_nb_mm_b2_c2_b2;
			Real pk_rc_phonephonecount_mm_b2_c2_b2;
			Real pk_ver_phncount_mm_b2_c2_b2;
			Real pk_gong_did_phone_ct_nb_mm_b2_c2_b2;
			Real pk_combo_ssncount_mm_b2_c2_b2;
			Real pk_combo_dobcount_nb_mm_b2_c2_b2;
			Real pk_eq_count_mm_b2_c2_b2;
			Real pk_pos_secondary_sources_mm_b2_c2_b2;
			Real pk_voter_flag_mm_b2_c2_b2;
			Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2;
			Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
			Real pk_add1_address_score_mm_b2_c2_b2;
			Real pk_add2_address_score_mm_b2_c2_b2;
			Real pk_add2_pos_sources_mm_b2_c2_b2;
			Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
			Real pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
			Real pk_yr_adl_em_first_seen2_mm_b2_c2_b2;
			Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b2;
			Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
			Real pk_yr_lname_change_date2_mm_b2_c2_b2;
			Real pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
			Real pk_yr_credit_first_seen2_mm_b2_c2_b2;
			Real pk_yr_header_first_seen2_mm_b2_c2_b2;
			Real pk_yr_infutor_first_seen2_mm_b2_c2_b2;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
			Real pk_nas_summary_mm_b2_c2_b3;
			Real pk_nap_summary_mm_b2_c2_b3;
			Real pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
			Real pk_adl_score_mm_b2_c2_b3;
			Real pk_combo_hphonescore_mm_b2_c2_b3;
			Real pk_combo_ssnscore_mm_b2_c2_b3;
			Real pk_combo_dobscore_mm_b2_c2_b3;
			Real pk_combo_fnamecount_nb_mm_b2_c2_b3;
			Real pk_rc_phonelnamecount_mm_b2_c2_b3;
			Real pk_combo_addrcount_nb_mm_b2_c2_b3;
			Real pk_rc_addrcount_nb_mm_b2_c2_b3;
			Real pk_rc_phonephonecount_mm_b2_c2_b3;
			Real pk_ver_phncount_mm_b2_c2_b3;
			Real pk_gong_did_phone_ct_nb_mm_b2_c2_b3;
			Real pk_combo_ssncount_mm_b2_c2_b3;
			Real pk_combo_dobcount_nb_mm_b2_c2_b3;
			Real pk_eq_count_mm_b2_c2_b3;
			Real pk_pos_secondary_sources_mm_b2_c2_b3;
			Real pk_voter_flag_mm_b2_c2_b3;
			Real pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3;
			Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
			Real pk_add1_address_score_mm_b2_c2_b3;
			Real pk_add2_address_score_mm_b2_c2_b3;
			Real pk_add2_pos_sources_mm_b2_c2_b3;
			Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
			Real pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
			Real pk_yr_adl_em_first_seen2_mm_b2_c2_b3;
			Real pk_yr_adl_vo_first_seen2_mm_b2_c2_b3;
			Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
			Real pk_yr_lname_change_date2_mm_b2_c2_b3;
			Real pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
			Real pk_yr_credit_first_seen2_mm_b2_c2_b3;
			Real pk_yr_header_first_seen2_mm_b2_c2_b3;
			Real pk_yr_infutor_first_seen2_mm_b2_c2_b3;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
			Real pk_nap_summary_mm_b2;
			Real pk_yr_infutor_first_seen2_mm_b2;
			Real pk_yr_lname_change_date2_mm_b2;
			Real pk_ssnchar_invalid_or_recent_mm_b2;
			Real pk_gong_did_phone_ct_nb_mm_b2;
			Real pk_yr_adl_em_first_seen2_mm_b2;
			Real pk_adl_score_mm_b2;
			Real pk_combo_dobcount_nb_mm_b2;
			Real pk_rc_phonelnamecount_mm_b2;
			Real pk_combo_fnamecount_nb_mm_b2;
			Real pk_rc_dirsaddr_lastscore_mm_b2;
			Real pk_combo_ssncount_mm_b2;
			Real pk_yr_adl_vo_first_seen2_mm_b2;
			Real pk_pos_secondary_sources_mm_b2;
			Real pk_voter_flag_mm_b2;
			Real pk_add2_address_score_mm_b2;
			Real pk_combo_ssnscore_mm_b2;
			Real pk_lname_eda_sourced_type_lvl_mm_b2;
			Real pk_combo_dobscore_mm_b2;
			Real pk_ver_phncount_mm_b2;
			Real pk_nas_summary_mm_b2;
			Real pk_yr_gong_did_first_seen2_mm_b2;
			Real pk_combo_hphonescore_mm_b2;
			Real pk_yr_adl_em_only_first_seen2_mm_b2;
			Real pk_infutor_risk_lvl_nb_mm_b2;
			Real pk_yr_credit_first_seen2_mm_b2;
			Real pk_combo_addrcount_nb_mm_b2;
			Real pk_yr_header_first_seen2_mm_b2;
			Real pk_eq_count_mm_b2;
			Real pk_add1_address_score_mm_b2;
			Real pk_rc_phonephonecount_mm_b2;
			Real pk_rc_addrcount_nb_mm_b2;
			Real pk_add2_pos_sources_mm_b2;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
			Real pk_fname_eda_sourced_type_lvl_mm_b2;
			Real pk_nap_summary_mm;
			Real pk_yr_infutor_first_seen2_mm;
			Real pk_yr_lname_change_date2_mm;
			Real pk_ssnchar_invalid_or_recent_mm;
			Real pk_gong_did_phone_ct_nb_mm;
			Real pk_yr_adl_em_first_seen2_mm;
			Real pk_adl_score_mm;
			Real pk_combo_dobcount_nb_mm;
			Real pk_rc_phonelnamecount_mm;
			Real pk_combo_fnamecount_nb_mm;
			Real pk_rc_dirsaddr_lastscore_mm;
			Real pk_combo_ssncount_mm;
			Real pk_yr_adl_vo_first_seen2_mm;
			Real pk_pos_secondary_sources_mm;
			Real pk_voter_flag_mm;
			Real pk_add2_address_score_mm;
			Real pk_combo_ssnscore_mm;
			Real pk_lname_eda_sourced_type_lvl_mm;
			Real pk_combo_dobscore_mm;
			Real pk_ver_phncount_mm;
			Real pk_combo_dobcount_mm;
			Real pk_nas_summary_mm;
			Real pk_rc_addrcount_mm;
			Real pk_gong_did_phone_ct_mm;
			Real pk_yr_gong_did_first_seen2_mm;
			Real pk_combo_hphonescore_mm;
			Real pk_yr_adl_em_only_first_seen2_mm;
			Real pk_infutor_risk_lvl_nb_mm;
			Real pk_add2_em_ver_lvl_mm;
			Real pk_yr_credit_first_seen2_mm;
			Real pk_combo_addrcount_nb_mm;
			Real pk_eq_count_mm;
			Real pk_yr_header_first_seen2_mm;
			Real pk_add1_address_score_mm;
			Real pk_combo_fnamecount_mm;
			Real pk_rc_phonephonecount_mm;
			Real pk_rc_addrcount_nb_mm;
			Real pk_add2_pos_sources_mm;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm;
			Real pk_fname_eda_sourced_type_lvl_mm;
			Real pk_infutor_risk_lvl_mm;
			Real pk_estimated_income_mm_b1;
			Real pk_yr_adl_pr_first_seen2_mm_b1;
			Real pk_yr_adl_w_first_seen2_mm_b1;
			Real pk_yr_adl_w_last_seen2_mm_b1;
			Real pk_pr_count_mm_b1;
			Real pk_addrs_sourced_lvl_mm_b1;
			Real pk_add1_own_level_mm_b1;
			Real pk_naprop_level2_mm_b1;
			Real pk_yr_add1_built_date2_mm_b1;
			Real pk_add1_purchase_amount2_mm_b1;
			Real pk_add1_mortgage_amount2_mm_b1;
			Real pk_yr_add1_mortgage_date2_mm_b1;
			Real pk_add1_assessed_amount2_mm_b1;
			Real pk_yr_add1_date_first_seen2_mm_b1;
			Real pk_add1_building_area2_mm_b1;
			Real pk_add1_no_of_rooms_mm_b1;
			Real pk_add1_garage_type_risk_lvl_mm_b1;
			Real pk_add1_style_code_level_mm_b1;
			Real pk_property_owned_total_mm_b1;
			Real pk_prop1_prev_purchase_price2_mm_b1;
			Real pk_add2_building_area2_mm_b1;
			Real pk_add2_no_of_buildings_mm_b1;
			Real pk_add2_no_of_rooms_mm_b1;
			Real pk_add2_style_code_level_mm_b1;
			Real pk_add2_purchase_amount2_mm_b1;
			Real pk_add2_mortgage_risk_mm_b1;
			Real pk_add2_assessed_amount2_mm_b1;
			Real pk_yr_add2_date_first_seen2_mm_b1;
			Real pk_yr_add2_date_last_seen2_mm_b1;
			Real pk_add3_purchase_amount2_mm_b1;
			Real pk_add3_mortgage_risk_mm_b1;
			Real pk_add3_assessed_amount2_mm_b1;
			Real pk_yr_add3_date_first_seen2_mm_b1;
			Real pk_yr_add3_date_last_seen2_mm_b1;
			Real pk_bk_level_mm_b1;
			Real pk_eviction_level_mm_b1;
			Real pk_lien_type_level_mm_b1;
			Real pk_yr_liens_last_unrel_date3_mm_b1;
			Real pk_yr_ln_unrel_lt_f_sn2_mm_b1;
			Real pk_yr_ln_unrel_ot_f_sn2_mm_b1;
			Real pk_yr_attr_dt_l_eviction2_mm_b1;
			Real pk_crime_level_mm_b1;
			Real pk_attr_total_number_derogs_mm_b1;
			Real pk_yr_rc_ssnhighissue2_mm_b1;
			Real pk_pl_sourced_level_mm_b1;
			Real pk_prof_lic_cat_mm_b1;
			Real pk_add1_lres_mm_b1;
			Real pk_add3_lres_mm_b1;
			Real pk_addrs_5yr_mm_b1;
			Real pk_addrs_10yr_mm_b1;
			Real pk_addrs_15yr_mm_b1;
			Real pk_add_lres_month_avg2_mm_b1;
			Real pk_nameperssn_count_mm_b1;
			Real pk_ssns_per_adl_mm_b1;
			Real pk_addrs_per_adl_mm_b1;
			Real pk_phones_per_adl_mm_b1;
			Real pk_adlperssn_count_mm_b1;
			Real pk_adls_per_addr_mm_b1;
			Real pk_adls_per_phone_mm_b1;
			Real pk_ssns_per_adl_c6_mm_b1;
			Real pk_ssns_per_addr_c6_mm_b1;
			Real pk_adls_per_phone_c6_mm_b1;
			Real pk_attr_addrs_last24_mm_b1;
			Real pk_ams_class_level_mm_b1;
			Real pk_ams_income_level_code_mm_b1;
			Real pk_college_tier_mm_b1;
			Real pk_yr_in_dob2_mm_b1;
			Real pk_ams_age_mm_b1;
			Real pk_inferred_age_mm_b1;
			Real pk_yr_reported_dob2_mm_b1;
			Real pk_avm_hit_level_mm_b1;
			Real pk_add2_avm_auto_diff3_lvl_mm_b1;
			Real pk2_add1_avm_sp_mm_b1;
			Real pk2_add1_avm_as_mm_b1;
			Real pk2_add1_avm_auto2_mm_b1;
			Real pk2_add1_avm_auto3_mm_b1;
			Real pk2_add1_avm_med_mm_b1;
			Real pk2_add1_avm_to_med_ratio_mm_b1;
			Real pk2_add2_avm_hed_mm_b1;
			Real pk2_add2_avm_auto3_mm_b1;
			Real pk_dist_a1toa2_mm_b1;
			Real pk_dist_a1toa3_mm_b1;
			Real pk_out_st_division_lvl_mm_b1;
			Real pk_impulse_count_mm_b1;
			Real pk_attr_num_nonderogs90_b_mm_b1;
			Real pk_ssns_per_addr2_mm_b1;
			Real pk_yr_add2_assess_val_yr2_mm_b1;
			Real pk_estimated_income_mm_b2;
			Real pk_yr_adl_pr_first_seen2_mm_b2;
			Real pk_yr_adl_w_first_seen2_mm_b2;
			Real pk_yr_adl_w_last_seen2_mm_b2;
			Real pk_pr_count_mm_b2;
			Real pk_addrs_sourced_lvl_mm_b2;
			Real pk_add1_own_level_mm_b2;
			Real pk_naprop_level2_mm_b2;
			Real pk_yr_add1_built_date2_mm_b2;
			Real pk_add1_purchase_amount2_mm_b2;
			Real pk_add1_mortgage_amount2_mm_b2;
			Real pk_yr_add1_mortgage_date2_mm_b2;
			Real pk_add1_assessed_amount2_mm_b2;
			Real pk_yr_add1_date_first_seen2_mm_b2;
			Real pk_add1_building_area2_mm_b2;
			Real pk_add1_no_of_rooms_mm_b2;
			Real pk_add1_garage_type_risk_lvl_mm_b2;
			Real pk_add1_style_code_level_mm_b2;
			Real pk_property_owned_total_mm_b2;
			Real pk_prop1_prev_purchase_price2_mm_b2;
			Real pk_add2_building_area2_mm_b2;
			Real pk_add2_no_of_buildings_mm_b2;
			Real pk_add2_no_of_rooms_mm_b2;
			Real pk_add2_style_code_level_mm_b2;
			Real pk_add2_purchase_amount2_mm_b2;
			Real pk_add2_mortgage_risk_mm_b2;
			Real pk_add2_assessed_amount2_mm_b2;
			Real pk_yr_add2_date_first_seen2_mm_b2;
			Real pk_yr_add2_date_last_seen2_mm_b2;
			Real pk_add3_purchase_amount2_mm_b2;
			Real pk_add3_mortgage_risk_mm_b2;
			Real pk_add3_assessed_amount2_mm_b2;
			Real pk_yr_add3_date_first_seen2_mm_b2;
			Real pk_yr_add3_date_last_seen2_mm_b2;
			Real pk_bk_level_mm_b2;
			Real pk_eviction_level_mm_b2;
			Real pk_lien_type_level_mm_b2;
			Real pk_yr_liens_last_unrel_date3_mm_b2;
			Real pk_yr_ln_unrel_lt_f_sn2_mm_b2;
			Real pk_yr_ln_unrel_ot_f_sn2_mm_b2;
			Real pk_yr_attr_dt_l_eviction2_mm_b2;
			Real pk_crime_level_mm_b2;
			Real pk_attr_total_number_derogs_mm_b2;
			Real pk_yr_rc_ssnhighissue2_mm_b2;
			Real pk_pl_sourced_level_mm_b2;
			Real pk_prof_lic_cat_mm_b2;
			Real pk_add1_lres_mm_b2;
			Real pk_add3_lres_mm_b2;
			Real pk_addrs_5yr_mm_b2;
			Real pk_addrs_10yr_mm_b2;
			Real pk_addrs_15yr_mm_b2;
			Real pk_add_lres_month_avg2_mm_b2;
			Real pk_nameperssn_count_mm_b2;
			Real pk_ssns_per_adl_mm_b2;
			Real pk_addrs_per_adl_mm_b2;
			Real pk_phones_per_adl_mm_b2;
			Real pk_adlperssn_count_mm_b2;
			Real pk_adls_per_addr_mm_b2;
			Real pk_adls_per_phone_mm_b2;
			Real pk_ssns_per_adl_c6_mm_b2;
			Real pk_ssns_per_addr_c6_mm_b2;
			Real pk_adls_per_phone_c6_mm_b2;
			Real pk_attr_addrs_last24_mm_b2;
			Real pk_ams_class_level_mm_b2;
			Real pk_ams_income_level_code_mm_b2;
			Real pk_college_tier_mm_b2;
			Real pk_yr_in_dob2_mm_b2;
			Real pk_ams_age_mm_b2;
			Real pk_inferred_age_mm_b2;
			Real pk_yr_reported_dob2_mm_b2;
			Real pk_avm_hit_level_mm_b2;
			Real pk_add2_avm_auto_diff3_lvl_mm_b2;
			Real pk2_add1_avm_sp_mm_b2;
			Real pk2_add1_avm_as_mm_b2;
			Real pk2_add1_avm_auto2_mm_b2;
			Real pk2_add1_avm_auto3_mm_b2;
			Real pk2_add1_avm_med_mm_b2;
			Real pk2_add1_avm_to_med_ratio_mm_b2;
			Real pk2_add2_avm_hed_mm_b2;
			Real pk2_add2_avm_auto3_mm_b2;
			Real pk_dist_a1toa2_mm_b2;
			Real pk_dist_a1toa3_mm_b2;
			Real pk_out_st_division_lvl_mm_b2;
			Real pk_impulse_count_mm_b2;
			Real pk_attr_num_nonderogs90_b_mm_b2;
			Real pk_ssns_per_addr2_mm_b2;
			Real pk_yr_add2_assess_val_yr2_mm_b2;
			Real pk_estimated_income_mm_b3;
			Real pk_yr_adl_pr_first_seen2_mm_b3;
			Real pk_yr_adl_w_first_seen2_mm_b3;
			Real pk_yr_adl_w_last_seen2_mm_b3;
			Real pk_pr_count_mm_b3;
			Real pk_addrs_sourced_lvl_mm_b3;
			Real pk_add1_own_level_mm_b3;
			Real pk_naprop_level2_mm_b3;
			Real pk_yr_add1_built_date2_mm_b3;
			Real pk_add1_purchase_amount2_mm_b3;
			Real pk_add1_mortgage_amount2_mm_b3;
			Real pk_yr_add1_mortgage_date2_mm_b3;
			Real pk_add1_assessed_amount2_mm_b3;
			Real pk_yr_add1_date_first_seen2_mm_b3;
			Real pk_add1_building_area2_mm_b3;
			Real pk_add1_no_of_rooms_mm_b3;
			Real pk_add1_garage_type_risk_lvl_mm_b3;
			Real pk_add1_style_code_level_mm_b3;
			Real pk_property_owned_total_mm_b3;
			Real pk_prop1_prev_purchase_price2_mm_b3;
			Real pk_add2_building_area2_mm_b3;
			Real pk_add2_no_of_buildings_mm_b3;
			Real pk_add2_no_of_rooms_mm_b3;
			Real pk_add2_style_code_level_mm_b3;
			Real pk_add2_purchase_amount2_mm_b3;
			Real pk_add2_mortgage_risk_mm_b3;
			Real pk_add2_assessed_amount2_mm_b3;
			Real pk_yr_add2_date_first_seen2_mm_b3;
			Real pk_yr_add2_date_last_seen2_mm_b3;
			Real pk_add3_purchase_amount2_mm_b3;
			Real pk_add3_mortgage_risk_mm_b3;
			Real pk_add3_assessed_amount2_mm_b3;
			Real pk_yr_add3_date_first_seen2_mm_b3;
			Real pk_yr_add3_date_last_seen2_mm_b3;
			Real pk_bk_level_mm_b3;
			Real pk_eviction_level_mm_b3;
			Real pk_lien_type_level_mm_b3;
			Real pk_yr_liens_last_unrel_date3_mm_b3;
			Real pk_yr_ln_unrel_lt_f_sn2_mm_b3;
			Real pk_yr_ln_unrel_ot_f_sn2_mm_b3;
			Real pk_yr_attr_dt_l_eviction2_mm_b3;
			Real pk_crime_level_mm_b3;
			Real pk_attr_total_number_derogs_mm_b3;
			Real pk_yr_rc_ssnhighissue2_mm_b3;
			Real pk_pl_sourced_level_mm_b3;
			Real pk_prof_lic_cat_mm_b3;
			Real pk_add1_lres_mm_b3;
			Real pk_add3_lres_mm_b3;
			Real pk_addrs_5yr_mm_b3;
			Real pk_addrs_10yr_mm_b3;
			Real pk_addrs_15yr_mm_b3;
			Real pk_add_lres_month_avg2_mm_b3;
			Real pk_nameperssn_count_mm_b3;
			Real pk_ssns_per_adl_mm_b3;
			Real pk_addrs_per_adl_mm_b3;
			Real pk_phones_per_adl_mm_b3;
			Real pk_adlperssn_count_mm_b3;
			Real pk_adls_per_addr_mm_b3;
			Real pk_adls_per_phone_mm_b3;
			Real pk_ssns_per_adl_c6_mm_b3;
			Real pk_ssns_per_addr_c6_mm_b3;
			Real pk_adls_per_phone_c6_mm_b3;
			Real pk_attr_addrs_last24_mm_b3;
			Real pk_ams_class_level_mm_b3;
			Real pk_ams_income_level_code_mm_b3;
			Real pk_college_tier_mm_b3;
			Real pk_yr_in_dob2_mm_b3;
			Real pk_ams_age_mm_b3;
			Real pk_inferred_age_mm_b3;
			Real pk_yr_reported_dob2_mm_b3;
			Real pk_avm_hit_level_mm_b3;
			Real pk_add2_avm_auto_diff3_lvl_mm_b3;
			Real pk2_add1_avm_sp_mm_b3;
			Real pk2_add1_avm_as_mm_b3;
			Real pk2_add1_avm_auto2_mm_b3;
			Real pk2_add1_avm_auto3_mm_b3;
			Real pk2_add1_avm_med_mm_b3;
			Real pk2_add1_avm_to_med_ratio_mm_b3;
			Real pk2_add2_avm_hed_mm_b3;
			Real pk2_add2_avm_auto3_mm_b3;
			Real pk_dist_a1toa2_mm_b3;
			Real pk_dist_a1toa3_mm_b3;
			Real pk_out_st_division_lvl_mm_b3;
			Real pk_impulse_count_mm_b3;
			Real pk_attr_num_nonderogs90_b_mm_b3;
			Real pk_ssns_per_addr2_mm_b3;
			Real pk_yr_add2_assess_val_yr2_mm_b3;
			Real pk_yr_add1_date_first_seen2_mm;
			Real pk_add2_style_code_level_mm;
			Real pk_add1_mortgage_amount2_mm;
			Real pk_nameperssn_count_mm;
			Real pk_add1_purchase_amount2_mm;
			Real pk_adls_per_phone_mm;
			Real pk_ssns_per_addr2_mm;
			Real pk_property_owned_total_mm;
			Real pk_ams_class_level_mm;
			Real pk_adls_per_phone_c6_mm;
			Real pk_yr_attr_dt_l_eviction2_mm;
			Real pk_yr_add2_date_first_seen2_mm;
			Real pk_adlperssn_count_mm;
			Real pk2_add2_avm_hed_mm;
			Real pk_yr_add3_date_first_seen2_mm;
			Real pk_add2_avm_auto_diff3_lvl_mm;
			Real pk_addrs_sourced_lvl_mm;
			Real pk_add_lres_month_avg2_mm;
			Real pk_add1_lres_mm;
			Real pk_attr_total_number_derogs_mm;
			Real pk_addrs_per_adl_mm;
			Real pk_naprop_level2_mm;
			Real pk2_add1_avm_auto3_mm;
			Real pk_yr_reported_dob2_mm;
			Real pk_college_tier_mm;
			Real pk_ssns_per_adl_mm;
			Real pk_yr_adl_w_last_seen2_mm;
			Real pk_ams_income_level_code_mm;
			Real pk_yr_ln_unrel_ot_f_sn2_mm;
			Real pk_add1_building_area2_mm;
			Real pk_yr_add3_date_last_seen2_mm;
			Real pk_pr_count_mm;
			Real pk2_add1_avm_as_mm;
			Real pk_inferred_age_mm;
			Real pk_out_st_division_lvl_mm;
			Real pk_yr_rc_ssnhighissue2_mm;
			Real pk_prop1_prev_purchase_price2_mm;
			Real pk_add2_purchase_amount2_mm;
			Real pk_add2_building_area2_mm;
			Real pk_phones_per_adl_mm;
			Real pk_add1_no_of_rooms_mm;
			Real pk2_add1_avm_auto2_mm;
			Real pk_addrs_10yr_mm;
			Real pk_ssns_per_addr_c6_mm;
			Real pk_add3_purchase_amount2_mm;
			Real pk_yr_ln_unrel_lt_f_sn2_mm;
			Real pk_yr_add2_assess_val_yr2_mm;
			Real pk_pl_sourced_level_mm;
			Real pk_add2_assessed_amount2_mm;
			Real pk_prof_lic_cat_mm;
			Real pk_dist_a1toa3_mm;
			Real pk_eviction_level_mm;
			Real pk_attr_num_nonderogs90_b_mm;
			Real pk_adls_per_addr_mm;
			Real pk_ssns_per_adl_c6_mm;
			Real pk_attr_addrs_last24_mm;
			Real pk_yr_add2_date_last_seen2_mm;
			Real pk_add3_mortgage_risk_mm;
			Real pk2_add1_avm_sp_mm;
			Real pk2_add1_avm_med_mm;
			Real pk_add2_no_of_rooms_mm;
			Real pk_impulse_count_mm;
			Real pk_add2_no_of_buildings_mm;
			Real pk_yr_add1_mortgage_date2_mm;
			Real pk_crime_level_mm;
			Real pk_yr_in_dob2_mm;
			Real pk_addrs_15yr_mm;
			Real pk_add1_garage_type_risk_lvl_mm;
			Real pk_avm_hit_level_mm;
			Real pk_bk_level_mm;
			Real pk2_add1_avm_to_med_ratio_mm;
			Real pk_yr_adl_pr_first_seen2_mm;
			Real pk_add1_assessed_amount2_mm;
			Real pk_add1_style_code_level_mm;
			Real pk_add3_lres_mm;
			Real pk_ams_age_mm;
			Real pk_estimated_income_mm;
			Real pk_yr_adl_w_first_seen2_mm;
			Real pk_add2_mortgage_risk_mm;
			Real pk_dist_a1toa2_mm;
			Real pk_add1_own_level_mm;
			Real pk_add3_assessed_amount2_mm;
			Real pk_yr_add1_built_date2_mm;
			Real pk_addrs_5yr_mm;
			Real pk_lien_type_level_mm;
			Real pk2_add2_avm_auto3_mm;
			Real pk_yr_liens_last_unrel_date3_mm;
			Real segment_mean;
			Real pk_add_lres_month_avg2_mm_2;
			Real pk_add1_address_score_mm_2;
			Real pk_add1_assessed_amount2_mm_2;
			Real pk_add1_building_area2_mm_2;
			Real pk_add1_garage_type_risk_lvl_mm_2;
			Real pk_add1_lres_mm_2;
			Real pk_add1_mortgage_amount2_mm_2;
			Real pk_add1_no_of_rooms_mm_2;
			Real pk_add1_own_level_mm_2;
			Real pk_add1_purchase_amount2_mm_2;
			Real pk_add1_style_code_level_mm_2;
			Real pk_add2_address_score_mm_2;
			Real pk_add2_assessed_amount2_mm_2;
			Real pk_add2_avm_auto_diff3_lvl_mm_2;
			Real pk_add2_building_area2_mm_2;
			Real pk_add2_em_ver_lvl_mm_2;
			Real pk_add2_mortgage_risk_mm_2;
			Real pk_add2_no_of_buildings_mm_2;
			Real pk_add2_no_of_rooms_mm_2;
			Real pk_add2_pos_sources_mm_2;
			Real pk_add2_purchase_amount2_mm_2;
			Real pk_add2_style_code_level_mm_2;
			Real pk_add3_assessed_amount2_mm_2;
			Real pk_add3_lres_mm_2;
			Real pk_add3_mortgage_risk_mm_2;
			Real pk_add3_purchase_amount2_mm_2;
			Real pk_addrs_10yr_mm_2;
			Real pk_addrs_15yr_mm_2;
			Real pk_addrs_5yr_mm_2;
			Real pk_addrs_per_adl_mm_2;
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
			Real pk_attr_num_nonderogs90_b_mm_2;
			Real pk_attr_total_number_derogs_mm_2;
			Real pk_avm_hit_level_mm_2;
			Real pk_bk_level_mm_2;
			Real pk_college_tier_mm_2;
			Real pk_combo_addrcount_nb_mm_2;
			Real pk_combo_dobcount_mm_2;
			Real pk_combo_dobcount_nb_mm_2;
			Real pk_combo_dobscore_mm_2;
			Real pk_combo_fnamecount_mm_2;
			Real pk_combo_fnamecount_nb_mm_2;
			Real pk_combo_hphonescore_mm_2;
			Real pk_combo_ssncount_mm_2;
			Real pk_combo_ssnscore_mm_2;
			Real pk_crime_level_mm_2;
			Real pk_dist_a1toa2_mm_2;
			Real pk_dist_a1toa3_mm_2;
			Real pk_eq_count_mm_2;
			Real pk_estimated_income_mm_2;
			Real pk_eviction_level_mm_2;
			Real pk_fname_eda_sourced_type_lvl_mm_2;
			Real pk_gong_did_phone_ct_mm_2;
			Real pk_gong_did_phone_ct_nb_mm_2;
			Real pk_impulse_count_mm_2;
			Real pk_inferred_age_mm_2;
			Real pk_infutor_risk_lvl_mm_2;
			Real pk_infutor_risk_lvl_nb_mm_2;
			Real pk_lien_type_level_mm_2;
			Real pk_lname_eda_sourced_type_lvl_mm_2;
			Real pk_nameperssn_count_mm_2;
			Real pk_nap_summary_mm_2;
			Real pk_naprop_level2_mm_2;
			Real pk_nas_summary_mm_2;
			Real pk_out_st_division_lvl_mm_2;
			Real pk_phones_per_adl_mm_2;
			Real pk_pl_sourced_level_mm_2;
			Real pk_pos_secondary_sources_mm_2;
			Real pk_pr_count_mm_2;
			Real pk_prof_lic_cat_mm_2;
			Real pk_prop1_prev_purchase_price2_mm_2;
			Real pk_property_owned_total_mm_2;
			Real pk_rc_addrcount_mm_2;
			Real pk_rc_addrcount_nb_mm_2;
			Real pk_rc_dirsaddr_lastscore_mm_2;
			Real pk_rc_phonelnamecount_mm_2;
			Real pk_rc_phonephonecount_mm_2;
			Real pk_ssnchar_invalid_or_recent_mm_2;
			Real pk_ssns_per_addr_c6_mm_2;
			Real pk_ssns_per_addr2_mm_2;
			Real pk_ssns_per_adl_c6_mm_2;
			Real pk_ssns_per_adl_mm_2;
			Real pk_ver_phncount_mm_2;
			Real pk_voter_flag_mm_2;
			Real pk_yr_add1_built_date2_mm_2;
			Real pk_yr_add1_date_first_seen2_mm_2;
			Real pk_yr_add1_mortgage_date2_mm_2;
			Real pk_yr_add2_assess_val_yr2_mm_2;
			Real pk_yr_add2_date_first_seen2_mm_2;
			Real pk_yr_add2_date_last_seen2_mm_2;
			Real pk_yr_add3_date_first_seen2_mm_2;
			Real pk_yr_add3_date_last_seen2_mm_2;
			Real pk_yr_adl_em_first_seen2_mm_2;
			Real pk_yr_adl_em_only_first_seen2_mm_2;
			Real pk_yr_adl_pr_first_seen2_mm_2;
			Real pk_yr_adl_vo_first_seen2_mm_2;
			Real pk_yr_adl_w_first_seen2_mm_2;
			Real pk_yr_adl_w_last_seen2_mm_2;
			Real pk_yr_attr_dt_l_eviction2_mm_2;
			Real pk_yr_credit_first_seen2_mm_2;
			Real pk_yr_gong_did_first_seen2_mm_2;
			Real pk_yr_header_first_seen2_mm_2;
			Real pk_yr_in_dob2_mm_2;
			Real pk_yr_infutor_first_seen2_mm_2;
			Real pk_yr_liens_last_unrel_date3_mm_2;
			Real pk_yr_ln_unrel_lt_f_sn2_mm_2;
			Real pk_yr_ln_unrel_ot_f_sn2_mm_2;
			Real pk_yr_lname_change_date2_mm_2;
			Real pk_yr_rc_ssnhighissue2_mm_2;
			Real pk_yr_reported_dob2_mm_2;
			Real pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
			Real pk2_add1_avm_as_mm_2;
			Real pk2_add1_avm_auto2_mm_2;
			Real pk2_add1_avm_auto3_mm_2;
			Real pk2_add1_avm_med_mm_2;
			Real pk2_add1_avm_sp_mm_2;
			Real pk2_add1_avm_to_med_ratio_mm_2;
			Real pk2_add2_avm_auto3_mm_2;
			Real pk2_add2_avm_hed_mm_2;
			Real amstudent_mod_om_b1;
			Real avm_mod_om_b1;
			Real derog_mod3_om_b1;
			Real lien_mod_om_b1;
			Real property_mod_om_b1;
			Real velocity2_mod_om_b1;
			Real ver_best_element_cnt_mod_om_b1;
			Real ver_best_src_cnt_mod_om_b1;
			Real ver_best_src_time_mod_om_b1;
			Real ver_notbest_element_cnt_mod_om_b1;
			Real ver_notbest_src_cnt_mod_om_b1;
			Real ver_notbest_src_time_mod_om_b1;
			Real ver_src_time_mod_om_b1;
			Real ver_element_cnt_mod_om_b1;
			Real ver_src_cnt_mod_om_b1;
			Real mod14_om_b1;
			Real addprob3_mod_xm_b2;
			Real phnprob_mod_xm_b2;
			Real ssnprob2_mod_xm_b2;
			Real fp_mod5_xm_b2;
			Real age_mod3_nodob_xm_b2;
			Real age_mod3_xm_b2;
			Real amstudent_mod_xm_b2;
			Real avm_mod_xm_b2;
			Real derog_mod3_xm_b2;
			Real lien_mod_xm_b2;
			Real lres_mod_xm_b2;
			Real property_mod_xm_b2;
			Real velocity2_mod_xm_b2;
			Real ver_best_element_cnt_mod_xm_b2;
			Real ver_best_src_cnt_mod_xm_b2;
			Real ver_best_src_time_mod_xm_b2;
			Real ver_notbest_element_cnt_mod_xm_b2;
			Real ver_notbest_src_cnt_mod_xm_b2;
			Real ver_notbest_src_time_mod_xm_b2;
			Real ver_element_cnt_mod_xm_b2;
			Real ver_src_time_mod_xm_b2;
			Real ver_src_cnt_mod_xm_b2;
			Real mod14_xm_b2;
			Real age_mod3_nm_b3;
			Real amstudent_mod_nm_b3;
			Real avm_mod_nm_b3;
			Real distance_mod2_nm_b3;
			Real lres_mod_nm_b3;
			Real proflic_mod_nm_b3;
			Real property_mod_nm_b3;
			Real velocity2_mod_nm_b3;
			Real ver_best_score_mod_nm_b3;
			Real ver_best_src_cnt_mod_nm_b3;
			Real ver_best_src_time_mod_nm_b3;
			Real ver_notbest_score_mod_nm_b3;
			Real ver_notbest_src_cnt_mod_nm_b3;
			Real ver_notbest_src_time_mod_nm_b3;
			Real ver_src_cnt_mod_nm_b3;
			Real ver_score_mod_nm_b3;
			Real ver_src_time_mod_nm_b3;
			Real mod14_nm_b3;
			Real ver_best_element_cnt_mod_om;
			Real ver_src_cnt_mod_nm;
			Real amstudent_mod_om;
			Real ver_notbest_score_mod_nm;
			Real ver_src_time_mod_nm;
			Real phat;
			Real age_mod3_nodob_xm;
			Real ver_src_time_mod_om;
			Real avm_mod_om;
			Real ver_notbest_src_cnt_mod_nm;
			Real property_mod_xm;
			Real mod14_om;
			Real mod14_xm;
			Real ver_notbest_src_cnt_mod_om;
			Real velocity2_mod_nm;
			Real distance_mod2_nm;
			Real lien_mod_om;
			Real ver_src_cnt_mod_xm;
			Real mod14_nm;
			Real ver_notbest_src_time_mod_xm;
			Real velocity2_mod_om;
			Real property_mod_nm;
			Real ver_notbest_element_cnt_mod_xm;
			Real ver_notbest_src_cnt_mod_xm;
			Real ver_notbest_src_time_mod_om;
			Real avm_mod_nm;
			Real ver_best_src_time_mod_om;
			Real ver_best_src_time_mod_xm;
			Real ver_src_cnt_mod_om;
			Real ver_best_src_cnt_mod_xm;
			Real amstudent_mod_xm;
			Real age_mod3_xm;
			Real avm_mod_xm;
			Real ver_best_src_cnt_mod_nm;
			Real velocity2_mod_xm;
			Real ver_notbest_element_cnt_mod_om;
			Real lres_mod_nm;
			Real ver_notbest_src_time_mod_nm;
			Real fp_mod5_xm;
			Real phnprob_mod_xm;
			Real ver_element_cnt_mod_xm;
			Real derog_mod3_om;
			Integer mod14_scr;
			Real ssnprob2_mod_xm;
			Real age_mod3_nm;
			Real ver_best_src_cnt_mod_om;
			Real ver_best_src_time_mod_nm;
			Real addprob3_mod_xm;
			Real derog_mod3_xm;
			Real ver_element_cnt_mod_om;
			Real ver_best_score_mod_nm;
			Real lien_mod_xm;
			Real amstudent_mod_nm;
			Real ver_score_mod_nm;
			Real proflic_mod_nm;
			Real ver_src_time_mod_xm;
			Real property_mod_om;
			Real lres_mod_xm;
			Real ver_best_element_cnt_mod_xm;
			Real mod14_om_nodob_b1_c2_b1;
			Real ver_best_e_cnt_mod_xm_nodob_b1_c2_b2;
			Real ver_best_score_mod_xm_nodob_b1_c2_b2;
			Real ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2;
			Real ver_notbest_score_mod_xm_nodob_b1_c2_b2;
			Real ver_element_cnt_mod_xm_nodob_b1_c2_b2;
			Real ver_score_mod_xm_nodob_b1_c2_b2;
			Real mod14_xm_nodob_b1_c2_b2;
			Real mod14_nm_nodob_b1_c2_b3;
			Real mod14_om_nodob_b1;
			Integer mod14_scr_b1;
			Real mod14_xm_nodob_b1;
			Real ver_best_score_mod_xm_nodob_b1;
			Real mod14_nm_nodob_b1;
			Real phat_b1;
			Real ver_score_mod_xm_nodob_b1;
			Real ver_best_e_cnt_mod_xm_nodob_b1;
			Real ver_notbest_score_mod_xm_nodob_b1;
			Real ver_element_cnt_mod_xm_nodob_b1;
			Real ver_notbest_e_cnt_mod_xm_nodob_b1;
			Real mod14_om_nodob;
			Integer mod14_scr_2;
			Real mod14_xm_nodob;
			Real ver_best_score_mod_xm_nodob;
			Real mod14_nm_nodob;
			Real phat_2;
			Real ver_score_mod_xm_nodob;
			Real ver_best_e_cnt_mod_xm_nodob;
			Real ver_notbest_score_mod_xm_nodob;
			Real ver_element_cnt_mod_xm_nodob;
			Real ver_notbest_e_cnt_mod_xm_nodob;
			Integer RVG1003;
			Boolean ov_ssndead;
			Boolean ov_ssnprior;
			Boolean ov_criminal_flag;
			Boolean ov_corrections;
			Boolean ov_impulse;
			Integer rvg1003_2;
			Boolean scored_222s;
			Integer rvg1003_3;

		end;
		layout_debug doModel(clam le) := TRANSFORM
		#else
		layout_modelout doModel(clam le) := TRANSFORM
		#end
				
				
			truedid                          := le.truedid;
			adl_category                     := le.adlcategory;
			out_unit_desig                   := le.shell_input.unit_desig;
			out_sec_range                    := le.shell_input.sec_range;
			out_st                           := le.shell_input.st;
			out_addr_type                    := le.shell_input.addr_type;
			out_addr_status                  := le.shell_input.addr_status;
			in_dob                           := le.shell_input.dob;
			nas_summary                      := le.iid.nas_summary;
			nap_summary                      := le.iid.nap_summary;
			did_count                        := le.iid.didcount;
			rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
			rc_hriskphoneflag                := le.iid.hriskphoneflag;
			rc_phonevalflag                  := le.iid.phonevalflag;
			rc_phonezipflag                  := le.iid.phonezipflag;
			rc_pwphonezipflag                := le.iid.pwphonezipflag;
			rc_decsflag                      := le.iid.decsflag;
			rc_ssndobflag                    := le.iid.socsdobflag;
			rc_pwssndobflag                  := le.iid.pwsocsdobflag;
			rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
			rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
			rc_areacodesplitflag             := le.iid.areacodesplitflag;
			rc_addrvalflag                   := le.iid.addrvalflag;
			rc_dwelltype                     := le.iid.dwelltype;
			rc_bansflag                      := le.iid.bansflag;
			rc_sources                       := le.iid.sources;
			rc_addrcount                     := le.iid.addrcount;
			rc_phonelnamecount               := le.iid.phonelastcount;
			rc_phonephonecount               := le.iid.phonephonecount;
			rc_hrisksic                      := le.iid.hrisksic;
			rc_disthphoneaddr                := le.iid.disthphoneaddr;
			rc_fnamessnmatch                 := le.iid.firstssnmatch;
			combo_hphonescore                := le.iid.combo_hphonescore;
			combo_ssnscore                   := le.iid.combo_ssnscore;
			combo_dobscore                   := le.iid.combo_dobscore;
			combo_fnamecount                 := le.iid.combo_firstcount;
			combo_addrcount                  := le.iid.combo_addrcount;
			combo_ssncount                   := le.iid.combo_ssncount;
			combo_dobcount                   := le.iid.combo_dobcount;
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
			fname_sources                    := le.source_verification.firstnamesources;
			lname_sources                    := le.source_verification.lastnamesources;
			addr_sources                     := le.source_verification.addrsources;
			em_only_sources                  := le.source_verification.em_only_sources;
			voter_avail                      := le.available_sources.voter;
			ssnlength                        := le.input_validation.ssn_length;
			dobpop                           := le.input_validation.dateofbirth;
			adl_score                        := le.name_verification.adl_score;
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
			add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
			add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
			add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
			add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
			add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
			add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
			add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
			add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
			add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
			add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
			add1_family_owned                := le.address_verification.input_address_information.family_owned;
			add1_naprop                      := le.address_verification.input_address_information.naprop;
			add1_built_date                  := le.address_verification.input_address_information.built_date;
			add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
			add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
			add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
			add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
			add1_financing_type              := le.address_verification.input_address_information.type_financing;
			add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
			add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
			add1_building_area               := (string)le.address_verification.input_address_information.building_area;
			add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
			add1_garage_type_code            := le.address_verification.input_address_information.garage_type_code;
			add1_style_code                  := le.address_verification.input_address_information.style_code;
			add1_pop                         := le.addrpop;
			property_owned_total             := le.address_verification.owned.property_total;
			property_sold_total              := le.address_verification.sold.property_total;
			property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
			prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
			dist_a1toa2                      := le.address_verification.distance_in_2_h1;
			dist_a1toa3                      := le.address_verification.distance_in_2_h2;
			dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
			add2_address_score               := le.address_verification.address_history_1.address_score;
			add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
			add2_avm_hedonic_valuation       := le.avm.address_history_1.avm_hedonic_valuation;
			add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
			add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
			add2_sources                     := le.address_verification.address_history_1.sources;
			add2_naprop                      := le.address_verification.address_history_1.naprop;
			add2_building_area               := (string)le.address_verification.address_history_1.building_area;
			add2_no_of_buildings             := (string)le.address_verification.address_history_1.no_of_buildings;
			add2_no_of_rooms                 := (string)le.address_verification.address_history_1.no_of_rooms;
			add2_style_code                  := le.address_verification.address_history_1.style_code;
			add2_assessed_value_year         := le.address_verification.address_history_1.assessed_value_year;
			add2_purchase_amount             := le.address_verification.address_history_1.purchase_amount;
			add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
			add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
			add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
			add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
			add3_lres                        := le.lres3;
			add3_sources                     := le.address_verification.address_history_2.sources;
			add3_naprop                      := le.address_verification.address_history_2.naprop;
			add3_purchase_amount             := le.address_verification.address_history_2.purchase_amount;
			add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
			add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
			add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
			add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
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
			adls_per_addr                    := le.velocity_counters.adls_per_addr;
			ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
			phones_per_addr                  := le.velocity_counters.phones_per_addr;
			adls_per_phone                   := le.velocity_counters.adls_per_phone;
			ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
			ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
			adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
			vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
			invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
			infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
			infutor_nap                      := le.infutor_phone.infutor_nap;
			impulse_count                    := le.impulse.count;
			attr_addrs_last24                := le.other_address_info.addrs_last24;
			attr_num_sold180                 := le.other_address_info.num_sold180;
			attr_num_watercraft180           := le.watercraft.watercraft_count180;
			attr_num_watercraft60            := le.watercraft.watercraft_count60;
			attr_total_number_derogs         := le.total_number_derogs;
			attr_eviction_count              := le.bjl.eviction_count;
			attr_date_last_eviction          := le.bjl.last_eviction_date;
			attr_eviction_count30            := le.bjl.eviction_count30;
			attr_eviction_count90            := le.bjl.eviction_count90;
			attr_eviction_count180           := le.bjl.eviction_count180;
			attr_eviction_count12            := le.bjl.eviction_count12;
			attr_eviction_count24            := le.bjl.eviction_count24;
			attr_eviction_count36            := le.bjl.eviction_count36;
			attr_eviction_count60            := le.bjl.eviction_count60;
			attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
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
			ams_age                          := le.student.age;
			ams_class                        := le.student.class;
			college_tier                     := le.student.college_tier;
			ams_college_code                 := le.student.college_code;
			ams_income_level_code            := le.student.income_level_code;
			prof_license_flag                := le.professional_license.professional_license_flag;
			prof_license_category            := le.professional_license.plcategory;
			wealth_index                     := le.wealth_indicator;
			input_dob_match_level            := le.dobmatchlevel;
			inferred_age                     := le.inferred_age;
			reported_dob                     := le.reported_dob;
			archive_date                     := if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate + '01');



			sysdate                          := models.common.sas_date(models.common.readDate((string)archive_date));
			NULL := -999999999;
			INTEGER year(integer sas_date) :=
				if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
			sysyear := year(sysdate);



	in_dob2 := models.common.sas_date(models.common.readDate((string)in_dob));

	years_in_dob := if(in_dob2=NULL, NULL, (sysdate - in_dob2) / 365.25);

	months_in_dob := if(in_dob2=NULL, NULL, (sysdate - in_dob2) / 30.5);

	rc_ssnhighissue2 := models.common.sas_date(models.common.readDate((string)rc_ssnhighissue));

	years_rc_ssnhighissue := if(rc_ssnhighissue2=NULL, NULL, (sysdate - rc_ssnhighissue2) / 365.25);

	months_rc_ssnhighissue := if(rc_ssnhighissue2=NULL, NULL, (sysdate - rc_ssnhighissue2) / 30.5);

	adl_eq_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_eq_first_seen));

	years_adl_eq_first_seen := if(adl_eq_first_seen2=NULL, NULL, (sysdate - adl_eq_first_seen2) / 365.25);

	months_adl_eq_first_seen := if(adl_eq_first_seen2=NULL, NULL, (sysdate - adl_eq_first_seen2) / 30.5);

	adl_en_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_en_first_seen));

	years_adl_en_first_seen := if(adl_en_first_seen2=NULL, NULL, (sysdate - adl_en_first_seen2) / 365.25);

	months_adl_en_first_seen := if(adl_en_first_seen2=NULL, NULL, (sysdate - adl_en_first_seen2) / 30.5);

	adl_pr_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_pr_first_seen));

	years_adl_pr_first_seen := if(adl_pr_first_seen2=NULL, NULL, (sysdate - adl_pr_first_seen2) / 365.25);

	months_adl_pr_first_seen := if(adl_pr_first_seen2=NULL, NULL, (sysdate - adl_pr_first_seen2) / 30.5);

	adl_em_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_em_first_seen));

	years_adl_em_first_seen := if(adl_em_first_seen2=NULL, NULL, (sysdate - adl_em_first_seen2) / 365.25);

	months_adl_em_first_seen := if(adl_em_first_seen2=NULL, NULL, (sysdate - adl_em_first_seen2) / 30.5);

	adl_vo_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_vo_first_seen));

	years_adl_vo_first_seen := if(adl_vo_first_seen2=NULL, NULL, (sysdate - adl_vo_first_seen2) / 365.25);

	months_adl_vo_first_seen := if(adl_vo_first_seen2=NULL, NULL, (sysdate - adl_vo_first_seen2) / 30.5);

	adl_em_only_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_em_only_first_seen));

	years_adl_em_only_first_seen := if(adl_em_only_first_seen2=NULL, NULL, (sysdate - adl_em_only_first_seen2) / 365.25);

	months_adl_em_only_first_seen := if(adl_em_only_first_seen2=NULL, NULL, (sysdate - adl_em_only_first_seen2) / 30.5);

	adl_w_first_seen2 := models.common.sas_date(models.common.readDate((string)adl_w_first_seen));

	years_adl_w_first_seen := if(adl_w_first_seen2=NULL, NULL, (sysdate - adl_w_first_seen2) / 365.25);

	months_adl_w_first_seen := if(adl_w_first_seen2=NULL, NULL, (sysdate - adl_w_first_seen2) / 30.5);

	adl_w_last_seen2 := models.common.sas_date(models.common.readDate((string)adl_w_last_seen));

	years_adl_w_last_seen := if(adl_w_last_seen2=NULL, NULL, (sysdate - adl_w_last_seen2) / 365.25);

	months_adl_w_last_seen := if(adl_w_last_seen2=NULL, NULL, (sysdate - adl_w_last_seen2) / 30.5);

	lname_change_date2 := models.common.sas_date(models.common.readDate((string)lname_change_date));

	years_lname_change_date := if(lname_change_date2=NULL, NULL, (sysdate - lname_change_date2) / 365.25);

	months_lname_change_date := if(lname_change_date2=NULL, NULL, (sysdate - lname_change_date2) / 30.5);

	add1_built_date2 := models.common.sas_date(models.common.readDate((string)add1_built_date));

	years_add1_built_date := if(add1_built_date2=NULL, NULL, (sysdate - add1_built_date2) / 365.25);

	months_add1_built_date := if(add1_built_date2=NULL, NULL, (sysdate - add1_built_date2) / 30.5);

	add1_mortgage_date2 := models.common.sas_date(models.common.readDate((string)add1_mortgage_date));

	years_add1_mortgage_date := if(add1_mortgage_date2=NULL, NULL, (sysdate - add1_mortgage_date2) / 365.25);

	months_add1_mortgage_date := if(add1_mortgage_date2=NULL, NULL, (sysdate - add1_mortgage_date2) / 30.5);

	add1_date_first_seen2 := models.common.sas_date(models.common.readDate((string)add1_date_first_seen));

	years_add1_date_first_seen := if(add1_date_first_seen2=NULL, NULL, (sysdate - add1_date_first_seen2) / 365.25);

	months_add1_date_first_seen := if(add1_date_first_seen2=NULL, NULL, (sysdate - add1_date_first_seen2) / 30.5);

	add2_assessed_value_year2 := models.common.sas_date(models.common.readDate((string)add2_assessed_value_year));

	years_add2_assessed_value_year := if(add2_assessed_value_year2=NULL, NULL, (sysdate - add2_assessed_value_year2) / 365.25);

	months_add2_assessed_value_year := if(add2_assessed_value_year2=NULL, NULL, (sysdate - add2_assessed_value_year2) / 30.5);

	add2_date_first_seen2 := models.common.sas_date(models.common.readDate((string)add2_date_first_seen));

	years_add2_date_first_seen := if(add2_date_first_seen2=NULL, NULL, (sysdate - add2_date_first_seen2) / 365.25);

	months_add2_date_first_seen := if(add2_date_first_seen2=NULL, NULL, (sysdate - add2_date_first_seen2) / 30.5);

	add2_date_last_seen2 := models.common.sas_date(models.common.readDate((string)add2_date_last_seen));

	years_add2_date_last_seen := if(add2_date_last_seen2=NULL, NULL, (sysdate - add2_date_last_seen2) / 365.25);

	months_add2_date_last_seen := if(add2_date_last_seen2=NULL, NULL, (sysdate - add2_date_last_seen2) / 30.5);

	add3_date_first_seen2 := models.common.sas_date(models.common.readDate((string)add3_date_first_seen));

	years_add3_date_first_seen := if(add3_date_first_seen2=NULL, NULL, (sysdate - add3_date_first_seen2) / 365.25);

	months_add3_date_first_seen := if(add3_date_first_seen2=NULL, NULL, (sysdate - add3_date_first_seen2) / 30.5);

	add3_date_last_seen2 := models.common.sas_date(models.common.readDate((string)add3_date_last_seen));

	years_add3_date_last_seen := if(add3_date_last_seen2=NULL, NULL, (sysdate - add3_date_last_seen2) / 365.25);

	months_add3_date_last_seen := if(add3_date_last_seen2=NULL, NULL, (sysdate - add3_date_last_seen2) / 30.5);

	gong_did_first_seen2 := models.common.sas_date(models.common.readDate((string)gong_did_first_seen));

	years_gong_did_first_seen := if(gong_did_first_seen2=NULL, NULL, (sysdate - gong_did_first_seen2) / 365.25);

	months_gong_did_first_seen := if(gong_did_first_seen2=NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

	credit_first_seen2 := models.common.sas_date(models.common.readDate((string)credit_first_seen));

	years_credit_first_seen := if(credit_first_seen2=NULL, NULL, (sysdate - credit_first_seen2) / 365.25);

	months_credit_first_seen := if(credit_first_seen2=NULL, NULL, (sysdate - credit_first_seen2) / 30.5);

	header_first_seen2 := models.common.sas_date(models.common.readDate((string)header_first_seen));

	years_header_first_seen := if(header_first_seen2=NULL, NULL, (sysdate - header_first_seen2) / 365.25);

	months_header_first_seen := if(header_first_seen2=NULL, NULL, (sysdate - header_first_seen2) / 30.5);

	infutor_first_seen2 := models.common.sas_date(models.common.readDate((string)infutor_first_seen));

	years_infutor_first_seen := if(infutor_first_seen2=NULL, NULL, (sysdate - infutor_first_seen2) / 365.25);

	months_infutor_first_seen := if(infutor_first_seen2=NULL, NULL, (sysdate - infutor_first_seen2) / 30.5);

	attr_date_last_eviction2 := models.common.sas_date(models.common.readDate((string)attr_date_last_eviction));

	years_attr_date_last_eviction := if(attr_date_last_eviction2=NULL, NULL, (sysdate - attr_date_last_eviction2) / 365.25);

	months_attr_date_last_eviction := if(attr_date_last_eviction2=NULL, NULL, (sysdate - attr_date_last_eviction2) / 30.5);

	date_last_seen2 := models.common.sas_date(models.common.readDate((string)date_last_seen));

	years_date_last_seen := if(date_last_seen2=NULL, NULL, (sysdate - date_last_seen2) / 365.25);

	months_date_last_seen := if(date_last_seen2=NULL, NULL, (sysdate - date_last_seen2) / 30.5);

	liens_last_unrel_date2 := models.common.sas_date(models.common.readDate((string)liens_last_unrel_date));

	years_liens_last_unrel_date := if(liens_last_unrel_date2=NULL, NULL, (sysdate - liens_last_unrel_date2) / 365.25);

	months_liens_last_unrel_date := if(liens_last_unrel_date2=NULL, NULL, (sysdate - liens_last_unrel_date2) / 30.5);

	liens_unrel_cj_last_seen2 := models.common.sas_date(models.common.readDate((string)liens_unrel_cj_last_seen));

	years_liens_unrel_cj_last_seen := if(liens_unrel_cj_last_seen2=NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 365.25);

	months_liens_unrel_cj_last_seen := if(liens_unrel_cj_last_seen2=NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

	liens_unrel_lt_first_seen2 := models.common.sas_date(models.common.readDate((string)liens_unrel_lt_first_seen));

	years_liens_unrel_lt_first_seen := if(liens_unrel_lt_first_seen2=NULL, NULL, (sysdate - liens_unrel_lt_first_seen2) / 365.25);

	months_liens_unrel_lt_first_seen := if(liens_unrel_lt_first_seen2=NULL, NULL, (sysdate - liens_unrel_lt_first_seen2) / 30.5);

	liens_unrel_ot_first_seen2 := models.common.sas_date(models.common.readDate((string)liens_unrel_ot_first_seen));

	years_liens_unrel_ot_first_seen := if(liens_unrel_ot_first_seen2=NULL, NULL, (sysdate - liens_unrel_ot_first_seen2) / 365.25);

	months_liens_unrel_ot_first_seen := if(liens_unrel_ot_first_seen2=NULL, NULL, (sysdate - liens_unrel_ot_first_seen2) / 30.5);

	reported_dob2 := models.common.sas_date(models.common.readDate((string)reported_dob));

	years_reported_dob := if(reported_dob2=NULL, NULL, (sysdate - reported_dob2) / 365.25);

	months_reported_dob := if(reported_dob2=NULL, NULL, (sysdate - reported_dob2) / 30.5);

	models.common.findw(rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool'); // source_tot_AK := 
	models.common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool'); // source_tot_AM := 
	models.common.findw(rc_sources, 'AR', ' ,', 'I', source_tot_AR, 'bool'); // source_tot_AR := 
	models.common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool'); // source_tot_BA := 
	models.common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool'); // source_tot_CG := 
	models.common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool'); // source_tot_DA := 
	models.common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool'); // source_tot_DS := 
	models.common.findw(rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool'); // source_tot_EB := 
	models.common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool'); // source_tot_EM := 
	models.common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool'); // source_tot_VO := 
	models.common.findw(rc_sources, 'FF', ' ,', 'I', source_tot_FF, 'bool'); // source_tot_FF := 
	models.common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool'); // source_tot_L2 := 
	models.common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool'); // source_tot_LI := 
	models.common.findw(rc_sources, 'P', ' ,', 'I', source_tot_P, 'bool'); // source_tot_P := 
	models.common.findw(rc_sources, 'W', ' ,', 'I', source_tot_W, 'bool'); // source_tot_W := 
	source_tot_voter := (source_tot_EM or source_tot_VO);
	models.common.findw(fname_sources, 'PL', ' ,', 'I', source_fst_PL, 'bool'); // source_fst_PL := 
	models.common.findw(lname_sources, 'PL', ' ,', 'I', source_lst_PL, 'bool'); // source_lst_PL := 
	models.common.findw(addr_sources, 'P', ' ,', 'I', source_add_P, 'bool'); // source_add_P := 
	models.common.findw(addr_sources, 'PL', ' ,', 'I', source_add_PL, 'bool'); // source_add_PL := 
	models.common.findw(add2_sources, 'EM', ' ,', 'I', source_add2_EM, 'bool'); // source_add2_EM := 
	models.common.findw(add2_sources, 'VO', ' ,', 'I', source_add2_VO, 'bool'); // source_add2_VO := 
	models.common.findw(add2_sources, 'EQ', ' ,', 'I', source_add2_EQ, 'bool'); // source_add2_EQ := 
	models.common.findw(add2_sources, 'P', ' ,', 'I', source_add2_P, 'bool'); // source_add2_P := 
	models.common.findw(add2_sources, 'WP', ' ,', 'I', source_add2_WP, 'bool'); // source_add2_WP := 
	source_add2_voter := (source_add2_EM or source_add2_VO);
	models.common.findw(add3_sources, 'P', ' ,', 'I', source_add3_P, 'bool'); // source_add3_P := 
	models.common.findw(add3_sources, 'W', ' ,', 'I', source_add3_W, 'bool'); // source_add3_W := 
	models.common.findw(em_only_sources, 'EM', ' ,', 'I', em_only_source_EM, 'bool'); // em_only_source_EM := 
	models.common.findw(em_only_sources, 'E1', ' ,', 'I', em_only_source_E1, 'bool'); // em_only_source_E1 := 
	models.common.findw(em_only_sources, 'E2', ' ,', 'I', em_only_source_E2, 'bool'); // em_only_source_E2 := 
	models.common.findw(em_only_sources, 'E3', ' ,', 'I', em_only_source_E3, 'bool'); // em_only_source_E3 := 
	models.common.findw(em_only_sources, 'E4', ' ,', 'I', em_only_source_E4, 'bool'); // em_only_source_E4 := 

	verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

	verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

	veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

	verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

	ver_phncount := if(max((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p) = NULL, NULL, sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p));

	years_adl_first_seen_max_fcra := max(years_adl_eq_first_seen, years_adl_en_first_seen, years_adl_pr_first_seen, years_adl_em_first_seen, years_adl_vo_first_seen, years_adl_em_only_first_seen, years_adl_w_first_seen);

	months_adl_first_seen_max_fcra := max(months_adl_eq_first_seen, months_adl_en_first_seen, months_adl_pr_first_seen, months_adl_em_first_seen, months_adl_vo_first_seen, months_adl_em_only_first_seen, months_adl_w_first_seen);

	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

	add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

	add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

	add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

	phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

	phn_zipmismatch := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));

	ssn_issued18 := ((integer)rc_pwssnvalflag = 5);

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

	add_apt_2 := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

	pk_bk_level :=  map(bankrupt             => 2,
						(integer)bk_flag = 1 => 1,
												0);

	add1_avm_med_2 :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
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

	Dist_mod := 53000 +
		(pk_dist_a1toa2 * 2742.75338) +
		(pk_dist_a1toa3 * 2773.73056) +
		(pk_dist_a2toa3 * 2915.40756) +
		(pk_rc_disthphoneaddr * 4620.15356);

	pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

	pk_bk_yr_date_last_seen :=  map(pk_yr_date_last_seen=0     => -1,
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
		(add1_avm_med_2 * 0.05448) +
		(prof_license_category_ord * 8167.93208) +
		(addrs_per_adl * 855.48025) +
		(pk_derog_total_m * 0.27963) +
		(add1_avm_automated_valuation_rcd * 0.01557) +
		(property_sold_assessed_total * 0.02413) +
		(attr_num_watercraft60_cap * 10490) +
		(age_rcd * 324.98302) +
		(combo_addrcount_cap * -2218.70449) +
		((integer)add_apt_2 * -6810.8463) +
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

	pk_yr_adl_em_first_seen := if (years_adl_em_first_seen >= 0, roundup(years_adl_em_first_seen), truncate(years_adl_em_first_seen));

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

	pk_combo_hphonescore :=  map(combo_hphonescore = 255 => 0,
								 combo_hphonescore = 100 => 2,
								 combo_hphonescore >= 90 => 1,
															0);

	pk_combo_ssnscore :=  map(combo_ssnscore = 100 => 1,
							  combo_ssnscore = 255 => -1,
													  0);

	pk_combo_dobscore :=  map(combo_dobscore = 255 => -1,
							  combo_dobscore >= 95 => 2,
							  combo_dobscore >= 90 => 1,
													  0);

	pk_combo_fnamecount :=  map(combo_fnamecount <= 1 => 0,
								combo_fnamecount <= 2 => 1,
								combo_fnamecount <= 3 => 2,
								combo_fnamecount <= 4 => 3,
														 4);

	pk_combo_fnamecount_nb :=  map(combo_fnamecount <= 1 => 0,
								   combo_fnamecount <= 2 => 1,
								   combo_fnamecount <= 3 => 2,
								   combo_fnamecount <= 4 => 3,
								   combo_fnamecount <= 5 => 4,
								   combo_fnamecount <= 6 => 5,
															6);

	pk_rc_phonelnamecount :=  if(rc_phonelnamecount <= 0, 0, 1);

	pk_combo_addrcount_nb :=  map(combo_addrcount <= 0 => 0,
								  combo_addrcount <= 1 => 1,
								  combo_addrcount <= 2 => 2,
								  combo_addrcount <= 3 => 3,
								  combo_addrcount <= 4 => 4,
														  5);

	pk_rc_addrcount :=  map(rc_addrcount <= 1 => 0,
							rc_addrcount <= 2 => 1,
							rc_addrcount <= 3 => 2,
												 3);

	pk_rc_addrcount_nb :=  map(rc_addrcount <= 0 => 0,
							   rc_addrcount <= 1 => 1,
							   rc_addrcount <= 2 => 1,
							   rc_addrcount <= 3 => 1,
													3);

	pk_rc_phonephonecount :=  if(rc_phonephonecount <= 0, 0, 1);

	pk_ver_phncount :=  map(ver_phncount <= 0 => 0,
							ver_phncount <= 2 => 1,
							ver_phncount <= 3 => 2,
												 3);

	pk_gong_did_phone_ct :=  map(gong_did_phone_ct <= 0 => -1,
								 gong_did_phone_ct <= 1 => 0,
								 gong_did_phone_ct <= 2 => 1,
								 gong_did_phone_ct <= 4 => 2,
														   3);

	pk_gong_did_phone_ct_nb :=  map(gong_did_phone_ct <= 0 => -2,
									gong_did_phone_ct <= 1 => -1,
									gong_did_phone_ct <= 2 => 0,
									gong_did_phone_ct <= 3 => 1,
															  2);

	pk_combo_ssncount :=  map(combo_ssncount <= 0 => -1,
							  combo_ssncount <= 1 => 0,
													 1);

	pk_combo_dobcount :=  map(combo_dobcount <= 0 => 0,
							  combo_dobcount <= 1 => 1,
							  combo_dobcount <= 2 => 2,
							  combo_dobcount <= 3 => 3,
													 4);

	pk_combo_dobcount_nb :=  map(combo_dobcount <= 0 => 0,
								 combo_dobcount <= 1 => 1,
								 combo_dobcount <= 2 => 2,
								 combo_dobcount <= 3 => 3,
								 combo_dobcount <= 4 => 4,
								 combo_dobcount <= 5 => 5,
								 combo_dobcount <= 6 => 6,
														7);

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

	pk_fname_eda_sourced_type_lvl :=  map(trim(fname_eda_sourced_type) = 'AP' => 3,
										  trim(fname_eda_sourced_type) = 'P'  => 2,
										  trim(fname_eda_sourced_type) = 'A'  => 1,
																										  0);

	pk_lname_eda_sourced_type_lvl :=  map(trim(lname_eda_sourced_type) = 'AP' => 3,
										  trim(lname_eda_sourced_type) = 'P'  => 2,
										  trim(lname_eda_sourced_type) = 'A'  => 1,
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

	models.common.findw(add2_sources, 'EM', ' ,', 'I', add2_source_EM, 'bool'); // add2_source_EM := 
	models.common.findw(add2_sources, 'E1', ' ,', 'I', add2_source_E1, 'bool'); // add2_source_E1 := 
	models.common.findw(add2_sources, 'E2', ' ,', 'I', add2_source_E2, 'bool'); // add2_source_E2 := 
	models.common.findw(add2_sources, 'E3', ' ,', 'I', add2_source_E3, 'bool'); // add2_source_E3 := 
	models.common.findw(add2_sources, 'E4', ' ,', 'I', add2_source_E4, 'bool'); // add2_source_E4 := 
	models.common.findw(add3_sources, 'EM', ' ,', 'I', add3_source_EM, 'bool'); // add3_source_EM := 
	models.common.findw(add3_sources, 'E1', ' ,', 'I', add3_source_E1, 'bool'); // add3_source_E1 := 
	models.common.findw(add3_sources, 'E2', ' ,', 'I', add3_source_E2, 'bool'); // add3_source_E2 := 
	models.common.findw(add3_sources, 'E3', ' ,', 'I', add3_source_E3, 'bool'); // add3_source_E3 := 
	models.common.findw(add3_sources, 'E4', ' ,', 'I', add3_source_E4, 'bool'); // add3_source_E4 := 

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

	pk_yr_adl_em_first_seen2 :=  map((real)pk_yr_adl_em_first_seen <= NULL => -1,
									 pk_yr_adl_em_first_seen <= 1          => 0,
									 pk_yr_adl_em_first_seen <= 3          => 1,
									 pk_yr_adl_em_first_seen <= 4          => 2,
									 pk_yr_adl_em_first_seen <= 18         => 3,
																			  4);

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

	pk_yr_adl_pr_first_seen := if (years_adl_pr_first_seen >= 0, roundup(years_adl_pr_first_seen), truncate(years_adl_pr_first_seen));

	pk_yr_adl_w_first_seen := if (years_adl_w_first_seen >= 0, roundup(years_adl_w_first_seen), truncate(years_adl_w_first_seen));

	pk_yr_adl_w_last_seen := if (years_adl_w_last_seen >= 0, roundup(years_adl_w_last_seen), truncate(years_adl_w_last_seen));

	pk_yr_add1_built_date := if (years_add1_built_date >= 0, roundup(years_add1_built_date), truncate(years_add1_built_date));

	pk_yr_add1_mortgage_date := if (years_add1_mortgage_date >= 0, roundup(years_add1_mortgage_date), truncate(years_add1_mortgage_date));

	pk_yr_add1_date_first_seen := if (years_add1_date_first_seen >= 0, roundup(years_add1_date_first_seen), truncate(years_add1_date_first_seen));

	pk_yr_add2_assessed_value_year := if (years_add2_assessed_value_year >= 0, roundup(years_add2_assessed_value_year), truncate(years_add2_assessed_value_year));

	pk_yr_add2_date_first_seen := if (years_add2_date_first_seen >= 0, roundup(years_add2_date_first_seen), truncate(years_add2_date_first_seen));

	pk_yr_add2_date_last_seen := if (years_add2_date_last_seen >= 0, roundup(years_add2_date_last_seen), truncate(years_add2_date_last_seen));

	pk_yr_add3_date_first_seen := if (years_add3_date_first_seen >= 0, roundup(years_add3_date_first_seen), truncate(years_add3_date_first_seen));

	pk_yr_add3_date_last_seen := if (years_add3_date_last_seen >= 0, roundup(years_add3_date_last_seen), truncate(years_add3_date_last_seen));

	pk_prop1_prev_purchase_price := (20000 * if ((prop1_prev_purchase_price / 20000) >= 0, roundup((prop1_prev_purchase_price / 20000)), truncate((prop1_prev_purchase_price / 20000))));

	pk_add1_purchase_amount := (20000 * if ((add1_purchase_amount / 20000) >= 0, roundup((add1_purchase_amount / 20000)), truncate((add1_purchase_amount / 20000))));

	pk_add1_mortgage_amount := (20000 * if ((add1_mortgage_amount / 20000) >= 0, roundup((add1_mortgage_amount / 20000)), truncate((add1_mortgage_amount / 20000))));

	pk_add1_assessed_amount := (20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000))));

	pk_add2_purchase_amount := (20000 * if ((add2_purchase_amount / 20000) >= 0, roundup((add2_purchase_amount / 20000)), truncate((add2_purchase_amount / 20000))));

	pk_add2_assessed_amount := (20000 * if ((add2_assessed_amount / 20000) >= 0, roundup((add2_assessed_amount / 20000)), truncate((add2_assessed_amount / 20000))));

	pk_add3_purchase_amount := (20000 * if ((add3_purchase_amount / 20000) >= 0, roundup((add3_purchase_amount / 20000)), truncate((add3_purchase_amount / 20000))));

	pk_add3_assessed_amount := (20000 * if ((add3_assessed_amount / 20000) >= 0, roundup((add3_assessed_amount / 20000)), truncate((add3_assessed_amount / 20000))));

	pk_prop1_prev_purchase_price_2 :=  if(pk_prop1_prev_purchase_price > 1000000, 1000000, pk_prop1_prev_purchase_price);

	pk_add1_purchase_amount_2 :=  if(pk_add1_purchase_amount > 1000000, 1000000, pk_add1_purchase_amount);

	pk_add1_mortgage_amount_2 :=  if(pk_add1_mortgage_amount > 1000000, 1000000, pk_add1_mortgage_amount);

	pk_add1_assessed_amount_2 :=  if(pk_add1_assessed_amount > 1000000, 1000000, pk_add1_assessed_amount);

	pk_add2_purchase_amount_2 :=  if(pk_add2_purchase_amount > 1000000, 1000000, pk_add2_purchase_amount);

	pk_add2_assessed_amount_2 :=  if(pk_add2_assessed_amount > 1000000, 1000000, pk_add2_assessed_amount);

	pk_add3_purchase_amount_2 :=  if(pk_add3_purchase_amount > 1000000, 1000000, pk_add3_purchase_amount);

	pk_add3_assessed_amount_2 :=  if(pk_add3_assessed_amount > 1000000, 1000000, pk_add3_assessed_amount);

	pk_add1_building_area :=  map((integer)add1_building_area <= 1000   => (100 * if (((real)add1_building_area / 100) >= 0, roundup(((real)add1_building_area / 100)), truncate(((real)add1_building_area / 100)))),
								  (integer)add1_building_area <= 10000  => (1000 * if (((real)add1_building_area / 1000) >= 0, roundup(((real)add1_building_area / 1000)), truncate(((real)add1_building_area / 1000)))),
								  (integer)add1_building_area <= 100000 => (10000 * if (((real)add1_building_area / 10000) >= 0, roundup(((real)add1_building_area / 10000)), truncate(((real)add1_building_area / 10000)))),
																		   100001);

	pk_add2_building_area :=  map((integer)add2_building_area <= 1000   => (100 * if (((real)add2_building_area / 100) >= 0, roundup(((real)add2_building_area / 100)), truncate(((real)add2_building_area / 100)))),
								  (integer)add2_building_area <= 10000  => (1000 * if (((real)add2_building_area / 1000) >= 0, roundup(((real)add2_building_area / 1000)), truncate(((real)add2_building_area / 1000)))),
								  (integer)add2_building_area <= 100000 => (10000 * if (((real)add2_building_area / 10000) >= 0, roundup(((real)add2_building_area / 10000)), truncate(((real)add2_building_area / 10000)))),
																		   100001);

	pk_yr_adl_pr_first_seen2 :=  map((real)pk_yr_adl_pr_first_seen <= NULL => -1,
									 pk_yr_adl_pr_first_seen <= 1          => 0,
									 pk_yr_adl_pr_first_seen <= 5          => 1,
									 pk_yr_adl_pr_first_seen <= 8          => 2,
									 pk_yr_adl_pr_first_seen <= 12         => 3,
									 pk_yr_adl_pr_first_seen <= 14         => 4,
									 pk_yr_adl_pr_first_seen <= 24         => 5,
									 pk_yr_adl_pr_first_seen <= 37         => 6,
																			  7);

	pk_yr_adl_w_first_seen2 :=  map((real)pk_yr_adl_w_first_seen <= NULL => -1,
									pk_yr_adl_w_first_seen <= 3          => 0,
									pk_yr_adl_w_first_seen <= 12         => 1,
																			2);

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

	pk_add1_mortgage_amount2 :=  map(pk_add1_mortgage_amount_2 <= 0      => -1,
									 pk_add1_mortgage_amount_2 <= 80000  => 0,
									 pk_add1_mortgage_amount_2 <= 120000 => 1,
																			2);

	pk_yr_add1_mortgage_date2 :=  map((real)pk_yr_add1_mortgage_date <= NULL => -1,
									  pk_yr_add1_mortgage_date <= 2          => 0,
									  pk_yr_add1_mortgage_date <= 3          => 1,
																				2);

	pk_add1_adjustable_financing :=  if(trim(add1_financing_type) = 'ADJ', 1, 0);

	pk_add1_assessed_amount2 :=  map(pk_add1_assessed_amount_2 <= 0      => -1,
									 pk_add1_assessed_amount_2 <= 40000  => 0,
									 pk_add1_assessed_amount_2 <= 60000  => 1,
									 pk_add1_assessed_amount_2 <= 80000  => 2,
									 pk_add1_assessed_amount_2 <= 100000 => 3,
									 pk_add1_assessed_amount_2 <= 140000 => 4,
									 pk_add1_assessed_amount_2 <= 160000 => 5,
																			6);

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

	pk_add1_no_of_rooms :=  map((integer)add1_no_of_rooms <= 0 => -1,
								(integer)add1_no_of_rooms <= 4 => 0,
								(integer)add1_no_of_rooms <= 5 => 1,
								(integer)add1_no_of_rooms <= 6 => 2,
								(integer)add1_no_of_rooms <= 7 => 3,
																  4);

	pk_add1_garage_type_risk_level :=  map(trim(add1_garage_type_code) in ['M', 'A', 'U'] => 0,
										   trim(add1_garage_type_code) in ['G', 'B', 'Y'] => 1,
										   trim(add1_garage_type_code) in ['C', 'N', 'D'] => 2,
																													  3);

	pk_add1_style_code_level :=  map(trim(add1_style_code) in ['J'] => 4,
									 trim(add1_style_code) in ['D'] => 3,
									 trim(add1_style_code) in ['N'] => 2,
									 trim(add1_style_code) in ['R'] => 1,
									 trim(add1_style_code) in ['C'] => 1,
																								0);

	pk_property_owned_total :=  map(property_owned_total <= 0 => -1,
									property_owned_total <= 1 => 0,
									property_owned_total <= 4 => 1,
									property_owned_total <= 6 => 2,
																 3);

	pk_prop1_prev_purchase_price2 :=  map(pk_prop1_prev_purchase_price_2 <= 0     => 0,
										  pk_prop1_prev_purchase_price_2 <= 80000 => 1,
																					 2);

	pk_add2_building_area2 :=  map(pk_add2_building_area <= 0    => -4,
								   pk_add2_building_area <= 900  => -3,
								   pk_add2_building_area <= 1000 => -2,
								   pk_add2_building_area <= 2000 => -1,
								   pk_add2_building_area <= 5000 => 0,
								   pk_add2_building_area <= 7000 => 1,
																	2);

	pk_add2_no_of_buildings :=  map((integer)add2_no_of_buildings <= 0 => -1,
									(integer)add2_no_of_buildings <= 1 => 0,
									(integer)add2_no_of_buildings <= 5 => 1,
																		  2);

	pk_add2_no_of_rooms :=  map((integer)add2_no_of_rooms <= 0 => -1,
								(integer)add2_no_of_rooms <= 3 => 0,
								(integer)add2_no_of_rooms <= 8 => 1,
																  2);

	pk_add2_style_code_level :=  map(trim(add2_style_code) in ['J'] => 4,
									 trim(add2_style_code) in ['D'] => 3,
									 trim(add2_style_code) in ['N'] => 2,
									 trim(add2_style_code) in ['R'] => 1,
									 trim(add2_style_code) in ['C'] => 1,
																								0);

	pk_yr_add2_assessed_value_year2 :=  map((real)pk_yr_add2_assessed_value_year <= NULL => -1,
											pk_yr_add2_assessed_value_year <= 0          => 0,
											pk_yr_add2_assessed_value_year <= 1          => 1,
																							2);

	pk_add2_purchase_amount2 :=  map(pk_add2_purchase_amount_2 <= 0     => -1,
									 pk_add2_purchase_amount_2 <= 80000 => 0,
																		   1);

	pk_add2_mortgage_risk :=  map(trim(add2_mortgage_type) in ['S', '1', 'H']   => 3,
								  trim(add2_mortgage_type) in ['FHA', '2']      => 3,
								  trim(add2_mortgage_type) in ['N', 'R', 'G']   => 2,
								  trim(add2_mortgage_type) in ['U', '', 'P']    => 1,
								  trim(add2_mortgage_type) in ['VA']            => 0,
								  trim(add2_mortgage_type) in ['CNS', 'E', 'C'] => 0,
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

	pk_add3_purchase_amount2 :=  map(pk_add3_purchase_amount_2 <= 0      => -1,
									 pk_add3_purchase_amount_2 <= 20000  => 0,
									 pk_add3_purchase_amount_2 <= 60000  => 1,
									 pk_add3_purchase_amount_2 <= 80000  => 2,
									 pk_add3_purchase_amount_2 <= 260000 => 3,
																			4);

	pk_add3_mortgage_risk :=  map(trim(add3_mortgage_type) in ['S', '1', 'H']   => 5,
								  trim(add3_mortgage_type) in ['FHA', '2']      => 4,
								  trim(add3_mortgage_type) in ['N', 'R', 'G']   => 3,
								  trim(add3_mortgage_type) in ['U', '', 'P']    => 2,
								  trim(add3_mortgage_type) in ['VA']            => 1,
								  trim(add3_mortgage_type) in ['CNS', 'E', 'C'] => 0,
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

	pk_yr_add3_date_last_seen2 :=  map((real)pk_yr_add3_date_last_seen <= NULL => -1,
									   pk_yr_add3_date_last_seen <= 1          => 0,
									   pk_yr_add3_date_last_seen <= 2          => 1,
									   pk_yr_add3_date_last_seen <= 3          => 2,
									   pk_yr_add3_date_last_seen <= 4          => 3,
									   pk_yr_add3_date_last_seen <= 7          => 4,
									   pk_yr_add3_date_last_seen <= 9          => 5,
									   pk_yr_add3_date_last_seen <= 12         => 6,
									   pk_yr_add3_date_last_seen <= 14         => 7,
																				  8);

	pk_attr_num_sold180 :=  if(attr_num_sold180 <= 0, 0, 1);

	pk_attr_num_watercraft180 :=  if(attr_num_watercraft180 <= 0, 0, 1);

	pk_yr_liens_last_unrel_date := if (years_liens_last_unrel_date >= 0, roundup(years_liens_last_unrel_date), truncate(years_liens_last_unrel_date));

	pk_yr_liens_unrel_lt_first_seen := if (years_liens_unrel_lt_first_seen >= 0, roundup(years_liens_unrel_lt_first_seen), truncate(years_liens_unrel_lt_first_seen));

	pk_yr_liens_unrel_ot_first_seen := if (years_liens_unrel_ot_first_seen >= 0, roundup(years_liens_unrel_ot_first_seen), truncate(years_liens_unrel_ot_first_seen));

	pk_yr_attr_date_last_eviction := if (years_attr_date_last_eviction >= 0, roundup(years_attr_date_last_eviction), truncate(years_attr_date_last_eviction));

	pk_bk_level_2 :=  map((filing_count >= 2) or (((trim(filing_type) = '') and (filing_count >= 1)) or ((StringLib.StringToUpperCase(trim(disposition)) = 'DISMISSED') or (bk_disposed_historical_count >= 2))) => 2,
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

	pk_yr_attr_date_last_eviction2 :=  map((real)pk_yr_attr_date_last_eviction <= NULL => -1,
										   pk_yr_attr_date_last_eviction <= 1          => 0,
										   pk_yr_attr_date_last_eviction <= 2          => 1,
										   pk_yr_attr_date_last_eviction <= 3          => 2,
										   pk_yr_attr_date_last_eviction <= 4          => 3,
										   pk_yr_attr_date_last_eviction <= 5          => 4,
																						  5);

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

	pk_add_standarization_error :=  if(trim(add_ec1) = 'E', 1, 0);

	pk_addr_changed :=  if((add_ec1 = 'S') and (add_ec3 != '0'), 1, 0);

	pk_unit_changed :=  if((add_ec1 = 'S') and (add_ec4 != '0'), 1, 0);

	pk_add_standarization_flag :=  if((boolean)pk_add_standarization_error or ((boolean)pk_addr_changed or (boolean)pk_unit_changed), 1, 0);

	pk_addr_not_valid :=  if(trim(rc_addrvalflag) = 'N', 1, 0);

	pk_area_code_split :=  if(trim(rc_areacodesplitflag) = 'Y', 1, 0);

	pk_yr_rc_ssnhighissue2 :=  map(pk_yr_rc_ssnhighissue = 0   => -1,
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

	pk_pl_sourced_level :=  map(((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and (((integer)source_fst_PL = 1) and ((integer)prof_license_flag = 1))) => 3,
								((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and ((integer)source_fst_PL = 1))                                        => 2,
								(integer)prof_license_flag = 1                                                                                                          => 2,
								((integer)source_add_PL = 0) and (((integer)source_lst_PL = 0) and ((integer)source_fst_PL = 0))                                        => 0,
																																										   1);

	pk_prof_lic_cat :=  map(trim(prof_license_category)='' => -1,
							((integer)prof_license_category <= 1) => 0,
							((integer)prof_license_category <= 3) => 1,
							((integer)prof_license_category <= 4) => 2,
																   3);

	pk_add_lres_month_avg := if (add_lres_month_avg >= 0, roundup(add_lres_month_avg), truncate(add_lres_month_avg));

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

	pk_addrs_10yr :=  map(addrs_10yr <= 0 => 0,
						  addrs_10yr <= 1 => 1,
						  addrs_10yr <= 6 => 2,
						  addrs_10yr <= 8 => 3,
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

	pk_phones_per_addr := if((integer)add_apt_2 = 0, NULL, pk_phones_per_addr_b2);

	pk_adls_per_addr := if((integer)add_apt_2 = 0, pk_adls_per_addr_b1, pk_adls_per_addr_b2);

	pk_ssns_per_addr2 := if((integer)add_apt_2 = 0, pk_ssns_per_addr2_b1, pk_ssns_per_addr2_b2);

	pk_adls_per_phone :=  map(adls_per_phone <= 0 => -2,
							  adls_per_phone <= 1 => -1,
							  adls_per_phone <= 2 => 0,
													 1);

	pk_ssns_per_adl_c6 :=  map(ssns_per_adl_c6 <= 0 => 0,
							   ssns_per_adl_c6 <= 1 => 1,
													   2);

	pk_ssns_per_addr_c6_b1 := map(ssns_per_addr_c6 <= 0 => 0,
								  ssns_per_addr_c6 <= 1 => 1,
								  ssns_per_addr_c6 <= 2 => 2,
								  ssns_per_addr_c6 <= 3 => 3,
								  ssns_per_addr_c6 <= 4 => 4,
								  ssns_per_addr_c6 <= 5 => 5,
														   6);

	pk_ssns_per_addr_c6_b2 := map(ssns_per_addr_c6 <= 0 => 100,
								  ssns_per_addr_c6 <= 1 => 101,
								  ssns_per_addr_c6 <= 2 => 102,
								  ssns_per_addr_c6 <= 3 => 103,
														   104);

	pk_ssns_per_addr_c6 := if((integer)add_apt_2 = 0, pk_ssns_per_addr_c6_b1, pk_ssns_per_addr_c6_b2);

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

	pk_college_tier :=  if(trim(college_tier) in ['', '0'], -1, (integer)college_tier);

	ams_class_n_b8 := (real)ams_class;

	ams_class_n_b8_2 := if(((integer)ams_class_n_b8 >= 60), (ams_class_n_b8 + 1900), (ams_class_n_b8 + 2000));

	pk_ams_class_level_b8 := map(((integer)(sysyear - ams_class_n_b8_2) <= 1) => 0,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 2) => 1,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 3) => 2,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 4) => 3,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 5) => 4,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 10) => 5,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 13) => 6,
								 ((integer)(sysyear - ams_class_n_b8_2) <= 17) => 7,
									  8);


	pk_since_ams_class_year := map(trim(ams_class) = 'GR' => NULL,
								   trim(ams_class) = 'SR' => NULL,
								   trim(ams_class) = 'JR' => NULL,
								   trim(ams_class) = 'SO' => NULL,
								   trim(ams_class) = 'FR' => NULL,
								   trim(ams_class) = 'UN' => NULL,
								   trim(ams_class) = ''   => NULL,
																					  (sysyear - ams_class_n_b8_2));


	ams_class_n := map(trim(ams_class) = 'GR' => NULL,
					   trim(ams_class) = 'SR' => NULL,
					   trim(ams_class) = 'JR' => NULL,
					   trim(ams_class) = 'SO' => NULL,
					   trim(ams_class) = 'FR' => NULL,
					   trim(ams_class) = 'UN' => NULL,
					   trim(ams_class) = ''   => NULL,
																		  ams_class_n_b8_2);

	pk_ams_class_level := map(trim(ams_class) = 'GR' => 1000005,
							  trim(ams_class) = 'SR' => 1000004,
							  trim(ams_class) = 'JR' => 1000003,
							  trim(ams_class) = 'SO' => 1000001,
							  trim(ams_class) = 'FR' => 1000000,
							  trim(ams_class) = 'UN' => 1000002,
							  trim(ams_class) = ''   => -1000001,
																				 pk_ams_class_level_b8);

	pk_ams_income_level_code :=  map(trim(ams_income_level_code) in ['A', 'B'] => 0,
									 trim(ams_income_level_code) in ['C']      => 1,
									 trim(ams_income_level_code) in ['D', 'E'] => 2,
									 trim(ams_income_level_code) in ['F']      => 3,
									 trim(ams_income_level_code) in ['G', 'H'] => 4,
									 trim(ams_income_level_code) in ['I', 'J'] => 5,
									 trim(ams_income_level_code) in ['K']      => 6,
																										   -1);

	pk_yr_in_dob := if (years_in_dob >= 0, roundup(years_in_dob), truncate(years_in_dob));

	pk_yr_reported_dob := if (years_reported_dob >= 0, roundup(years_reported_dob), truncate(years_reported_dob));

	pk_yr_in_dob2 :=  map(pk_yr_in_dob <= 19 => 19,
						  pk_yr_in_dob <= 20 => 20,
						  pk_yr_in_dob <= 21 => 21,
						  pk_yr_in_dob <= 22 => 22,
						  pk_yr_in_dob <= 23 => 23,
						  pk_yr_in_dob <= 25 => 25,
						  pk_yr_in_dob <= 29 => 29,
						  pk_yr_in_dob <= 35 => 35,
						  pk_yr_in_dob <= 38 => 38,
						  pk_yr_in_dob <= 41 => 41,
						  pk_yr_in_dob <= 42 => 42,
						  pk_yr_in_dob <= 43 => 43,
						  pk_yr_in_dob <= 44 => 44,
						  pk_yr_in_dob <= 45 => 45,
						  pk_yr_in_dob <= 47 => 47,
						  pk_yr_in_dob <= 49 => 49,
						  pk_yr_in_dob <= 57 => 57,
						  pk_yr_in_dob <= 61 => 61,
												99);

	pk_ams_age :=  map(trim(ams_age)=''       => -1,
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

	pk_add1_avm_sp := (20000 * if (((real)add1_avm_sales_price / 20000) >= 0, roundup(((real)add1_avm_sales_price / 20000)), truncate(((real)add1_avm_sales_price / 20000))));

	pk_add1_avm_as := (20000 * if (((real)add1_avm_assessed_total_value / 20000) >= 0, roundup(((real)add1_avm_assessed_total_value / 20000)), truncate(((real)add1_avm_assessed_total_value / 20000))));

	pk_add1_avm_auto2 := (20000 * if ((add1_avm_automated_valuation_2 / 20000) >= 0, roundup((add1_avm_automated_valuation_2 / 20000)), truncate((add1_avm_automated_valuation_2 / 20000))));

	pk_add1_avm_auto3 := (20000 * if ((add1_avm_automated_valuation_3 / 20000) >= 0, roundup((add1_avm_automated_valuation_3 / 20000)), truncate((add1_avm_automated_valuation_3 / 20000))));

	pk_add1_avm_med := (20000 * if ((add1_avm_med_2 / 20000) >= 0, roundup((add1_avm_med_2 / 20000)), truncate((add1_avm_med_2 / 20000))));

	pk_add2_avm_hed := (20000 * if ((add2_avm_hedonic_valuation / 20000) >= 0, roundup((add2_avm_hedonic_valuation / 20000)), truncate((add2_avm_hedonic_valuation / 20000))));

	pk_add2_avm_auto := (20000 * if ((add2_avm_automated_valuation / 20000) >= 0, roundup((add2_avm_automated_valuation / 20000)), truncate((add2_avm_automated_valuation / 20000))));

	pk_add2_avm_auto3 := (20000 * if ((add2_avm_automated_valuation_3 / 20000) >= 0, roundup((add2_avm_automated_valuation_3 / 20000)), truncate((add2_avm_automated_valuation_3 / 20000))));

	pk_add1_avm_sp_2 :=  if(pk_add1_avm_sp > 1000000, 1000000, pk_add1_avm_sp);

	pk_add1_avm_as_2 :=  if(pk_add1_avm_as > 1000000, 1000000, pk_add1_avm_as);

	pk_add1_avm_auto2_2 :=  if(pk_add1_avm_auto2 > 1000000, 1000000, pk_add1_avm_auto2);

	pk_add1_avm_auto3_2 :=  if(pk_add1_avm_auto3 > 1000000, 1000000, pk_add1_avm_auto3);

	pk_add1_avm_med_2 :=  if(pk_add1_avm_med > 1000000, 1000000, pk_add1_avm_med);

	pk_add2_avm_hed_2 :=  if(pk_add2_avm_hed > 1000000, 1000000, pk_add2_avm_hed);

	pk_add2_avm_auto_2 :=  if(pk_add2_avm_auto > 1000000, 1000000, pk_add2_avm_auto);

	pk_add2_avm_auto3_2 :=  if(pk_add2_avm_auto3 > 1000000, 1000000, pk_add2_avm_auto3);

	pk_add1_avm_to_med_ratio := round(add1_avm_to_med_ratio*10)/10;

	pk_add1_avm_to_med_ratio_2 :=  if((integer)pk_add1_avm_to_med_ratio > 10, 10, pk_add1_avm_to_med_ratio);

	pk2_add1_avm_sp :=  map(pk_add1_avm_sp_2 <= 80000  => 0,
							pk_add1_avm_sp_2 <= 120000 => 1,
							pk_add1_avm_sp_2 <= 180000 => 2,
														  3);

	pk2_add1_avm_as :=  map(pk_add1_avm_as_2 <= 20000  => 0,
							pk_add1_avm_as_2 <= 100000 => 1,
							pk_add1_avm_as_2 <= 500000 => 2,
														  3);

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

	pk2_add1_avm_med :=  map(pk_add1_avm_med_2 <= 0      => 7,
							 pk_add1_avm_med_2 <= 20000  => 0,
							 pk_add1_avm_med_2 <= 40000  => 1,
							 pk_add1_avm_med_2 <= 60000  => 2,
							 pk_add1_avm_med_2 <= 80000  => 3,
							 pk_add1_avm_med_2 <= 120000 => 4,
							 pk_add1_avm_med_2 <= 620000 => 5,
							 pk_add1_avm_med_2 <= 720000 => 6,
															7);

	pk2_add1_avm_to_med_ratio :=  map(pk_add1_avm_to_med_ratio_2 <= NULL => 0,
									  pk_add1_avm_to_med_ratio_2 <= 0.7  => 0,
									  pk_add1_avm_to_med_ratio_2 <= 1.0  => 1,
									  pk_add1_avm_to_med_ratio_2 <= 1.1  => 2,
									  pk_add1_avm_to_med_ratio_2 <= 1.4  => 3,
									  pk_add1_avm_to_med_ratio_2 <= 1.7  => 4,
																			5);

	pk_add2_avm_hit :=  if(add2_avm_land_use in ['1', '2'], 1, 0);

	pk_avm_hit_level :=  map(((integer)add1_AVM_hit > 0) and (pk_add2_avm_hit > 0) => 2,
							 (integer)add1_AVM_hit > 0                             => 1,
							 pk_add2_avm_hit > 0                                   => -1,
																					  0);

	pk2_add2_avm_hed :=  map(pk_add2_avm_hed_2 <= 0      => 3,
							 pk_add2_avm_hed_2 <= 20000  => 0,
							 pk_add2_avm_hed_2 <= 60000  => 1,
							 pk_add2_avm_hed_2 <= 80000  => 2,
							 pk_add2_avm_hed_2 <= 120000 => 4,
							 pk_add2_avm_hed_2 <= 620000 => 5,
															6);

	pk2_add2_avm_auto3 :=  map(pk_add2_avm_auto3_2 <= 0      => 2,
							   pk_add2_avm_auto3_2 <= 40000  => 0,
							   pk_add2_avm_auto3_2 <= 60000  => 1,
							   pk_add2_avm_auto3_2 <= 100000 => 2,
							   pk_add2_avm_auto3_2 <= 680000 => 3,
																4);

	pk_add2_avm_auto_diff3 :=  if((pk_add2_avm_auto_2 = 0) or (pk_add2_avm_auto3_2 = 0), -999999, (pk_add2_avm_auto_2 - pk_add2_avm_auto3_2));

	pk_add2_avm_auto_diff3_lvl :=  map(pk_add2_avm_auto_diff3 = -999999 => -2,
									   pk_add2_avm_auto_diff3 < -20000  => -1,
																		   0);

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

	pk_out_st_division_lvl :=  map(trim(out_st) in ['IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']             => 0,
								   trim(out_st) in ['IL', 'IN', 'MI', 'OH', 'WI']                         => 1,
								   trim(out_st) in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY']       => 2,
								   trim(out_st) in ['AL', 'KY', 'MS', 'TN']                               => 3,
								   trim(out_st) in ['DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV'] => 4,
								   trim(out_st) in ['NJ', 'NY', 'PA']                                     => 5,
								   trim(out_st) in ['AK', 'CA', 'HI', 'OR', 'WA']                         => 6,
								   trim(out_st) in ['AR', 'LA', 'OK', 'TX']                               => 7,
								   trim(out_st) in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'] => 8,
																																	  -1);

	pk_impulse_count := min(2,impulse_count);

	pk_impulse_count_2 :=  pk_impulse_count;

	pk_attr_total_number_derogs_4 := attr_total_number_derogs;

	pk_attr_total_number_derogs_5 :=  if(pk_attr_total_number_derogs_4 > 3, 3, pk_attr_total_number_derogs_4);

	pk_attr_num_nonderogs90_3 := attr_num_nonderogs90;

	pk_attr_num_nonderogs90_4 :=  if(pk_attr_num_nonderogs90_3 > 4, 4, pk_attr_num_nonderogs90_3);

	pk_attr_num_nonderogs90_b := ((10 * (integer)add1_isbestmatch) + pk_attr_num_nonderogs90_4);

	pk_adl_cat_deceased :=  if(trim(adl_category) = '1 DEAD', 1, 0);

	bs_attr_derog_flag :=  if(attr_total_number_derogs > 0, 1, 0);

	bs_attr_eviction_flag :=  if(attr_eviction_count > 0, 1, 0);

	bs_attr_derog_flag2 :=  if((bs_attr_derog_flag > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag > 0) or ((pk_impulse_count_2 > 0) or (((integer)bk_flag > 0) or ((pk_adl_cat_deceased > 0) or ((integer)ssn_deceased > 0)))))), 1, 0);

	pk_own_flag :=  if((add1_naprop in [3, 4]) or (property_owned_total > 0), 1, 0);

	pk_Segment3 := '             ';

	pk_segment3_2 :=  map((bs_attr_derog_flag2 = 1) and (pk_own_flag = 1) => '0 Derog-Owner',
						  bs_attr_derog_flag2 = 1                         => '1 Derog-Other',
																			 '2 Non-Derog  ');

	pk_nas_summary_mm_b1_c2_b1 := map(pk_nas_summary = 0 => 0.3859649123,
									  pk_nas_summary = 1 => 0.1831395349,
															0.1865801551);

	pk_nap_summary_mm_b1_c2_b1 := map(pk_nap_summary = -1 => 0.2596153846,
									  pk_nap_summary = 0  => 0.1964772816,
									  pk_nap_summary = 1  => 0.1926311574,
															 0.1480900052);

	pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := map(pk_rc_dirsaddr_lastscore = -1 => 0.1811292156,
												pk_rc_dirsaddr_lastscore = 0  => 0.2200275609,
												pk_rc_dirsaddr_lastscore = 1  => 0.1822660099,
																				 0.1837870749);

	pk_adl_score_mm_b1_c2_b1 := map(pk_adl_score = 0 => 0.2727272727,
														0.1866167914);

	pk_combo_hphonescore_mm_b1_c2_b1 := map(pk_combo_hphonescore = 0 => 0.196317471,
											pk_combo_hphonescore = 1 => 0.1358024691,
																		0.1732402082);

	pk_combo_ssnscore_mm_b1_c2_b1 := map(pk_combo_ssnscore = -1 => 0,
										 pk_combo_ssnscore = 0  => 0.3167701863,
																   0.1860962009);

	pk_combo_dobscore_mm_b1_c2_b1 := map(pk_combo_dobscore = -1 => 0.284457478,
										 pk_combo_dobscore = 0  => 0.2444444444,
										 pk_combo_dobscore = 1  => 0.2200598802,
																   0.1831959732);

	pk_combo_fnamecount_mm_b1_c2_b1 := map(pk_combo_fnamecount = 0 => 0.2753623188,
										   pk_combo_fnamecount = 1 => 0.2433823529,
										   pk_combo_fnamecount = 2 => 0.2064846416,
										   pk_combo_fnamecount = 3 => 0.1876594758,
																	  0.1704534468);

	pk_rc_phonelnamecount_mm_b1_c2_b1 := map(pk_rc_phonelnamecount = 0 => 0.1966077958,
																		  0.1683320523);

	pk_rc_addrcount_mm_b1_c2_b1 := map(pk_rc_addrcount = 0 => 0.2140273831,
									   pk_rc_addrcount = 1 => 0.1694290976,
									   pk_rc_addrcount = 2 => 0.1685960226,
															  0.1691919192);

	pk_rc_phonephonecount_mm_b1_c2_b1 := map(pk_rc_phonephonecount = 0 => 0.1936406169,
																		  0.1774564995);

	pk_ver_phncount_mm_b1_c2_b1 := map(pk_ver_phncount = 0 => 0.1929854577,
									   pk_ver_phncount = 1 => 0.2100958827,
									   pk_ver_phncount = 2 => 0.1925142392,
															  0.1480900052);

	pk_gong_did_phone_ct_mm_b1_c2_b1 := map(pk_gong_did_phone_ct = -1 => 0.1938845468,
											pk_gong_did_phone_ct = 0  => 0.1659423789,
											pk_gong_did_phone_ct = 1  => 0.1857506361,
											pk_gong_did_phone_ct = 2  => 0.2025373811,
																		 0.2914171657);

	pk_combo_ssncount_mm_b1_c2_b1 := map(pk_combo_ssncount = -1 => 0.4,
										 pk_combo_ssncount = 0  => 0.2047729022,
																   0.1651890921);

	pk_combo_dobcount_mm_b1_c2_b1 := map(pk_combo_dobcount = 0 => 0.2667757774,
										 pk_combo_dobcount = 1 => 0.2185850053,
										 pk_combo_dobcount = 2 => 0.2324561404,
										 pk_combo_dobcount = 3 => 0.1938948559,
																  0.1722141823);

	pk_eq_count_mm_b1_c2_b1 := map(pk_eq_count = 0 => 0.1935483871,
								   pk_eq_count = 1 => 0.2741935484,
								   pk_eq_count = 2 => 0.2118171683,
								   pk_eq_count = 3 => 0.1813953488,
								   pk_eq_count = 4 => 0.194011976,
								   pk_eq_count = 5 => 0.1793773869,
													  0.1862985421);

	pk_pos_secondary_sources_mm_b1_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.1871546241,
												pk_pos_secondary_sources = 1 => 0.2115384615,
																				0.1388888889);

	pk_voter_flag_mm_b1_c2_b1 := map(pk_voter_flag = -1 => 0.2269736842,
									 pk_voter_flag = 0  => 0.1778991401,
														   0.1864564007);

	pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.1981373265,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.1904276986,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.16,
																						  0.1567183802);

	pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.1947440377,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.1985645933,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.1754587156,
																						  0.1672288301);

	pk_add1_address_score_mm_b1_c2_b1 := map(pk_add1_address_score = 0 => 0.1890660592,
																		  0.1869630287);

	pk_add2_address_score_mm_b1_c2_b1 := map(pk_add2_address_score = 0 => 0.2283356259,
											 pk_add2_address_score = 1 => 0.1856458771,
											 pk_add2_address_score = 2 => 0.1872278665,
																		  0.1809290954);

	pk_add2_pos_sources_mm_b1_c2_b1 := map(pk_add2_pos_sources = 0 => 0.1994134897,
										   pk_add2_pos_sources = 1 => 0.1846406448,
										   pk_add2_pos_sources = 2 => 0.1876155268,
										   pk_add2_pos_sources = 3 => 0.1897086175,
																	  0.2012578616);

	pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.1869796784,
																						  0.3157894737);

	pk_infutor_risk_lvl_mm_b1_c2_b1 := map(pk_infutor_risk_lvl = 0 => 0.1805672269,
										   pk_infutor_risk_lvl = 1 => 0.1879978028,
																	  0.2089201878);

	pk_yr_adl_em_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_em_first_seen2 = -1 => 0.1877091856,
												pk_yr_adl_em_first_seen2 = 0  => 0.214953271,
												pk_yr_adl_em_first_seen2 = 1  => 0.1705006766,
												pk_yr_adl_em_first_seen2 = 2  => 0.1715374841,
												pk_yr_adl_em_first_seen2 = 3  => 0.1868043233,
																				 0.2081447964);

	pk_yr_adl_vo_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.187374487,
												pk_yr_adl_vo_first_seen2 = 0  => 0.2025782689,
												pk_yr_adl_vo_first_seen2 = 1  => 0.1820712695,
												pk_yr_adl_vo_first_seen2 = 2  => 0.1798179059,
																				 0.1887947269);

	pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1879476706,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.1887755102,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.1438356164,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.1642335766,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.1838111298,
																						   0.2428571429);

	pk_yr_lname_change_date2_mm_b1_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.18488455,
												pk_yr_lname_change_date2 = 0  => 0.2225609756,
												pk_yr_lname_change_date2 = 1  => 0.2252427184,
																				 0.219858156);

	pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.2010989011,
												  pk_yr_gong_did_first_seen2 = 0  => 0.2153110048,
												  pk_yr_gong_did_first_seen2 = 1  => 0.2053072626,
												  pk_yr_gong_did_first_seen2 = 2  => 0.2016048144,
												  pk_yr_gong_did_first_seen2 = 3  => 0.1749598716,
																					 0.1767843289);

	pk_yr_credit_first_seen2_mm_b1_c2_b1 := map(pk_yr_credit_first_seen2 = -1 => 0,
												pk_yr_credit_first_seen2 = 0  => 0.2142857143,
												pk_yr_credit_first_seen2 = 1  => 0.4545454545,
												pk_yr_credit_first_seen2 = 2  => 0.3428571429,
												pk_yr_credit_first_seen2 = 3  => 0.2765957447,
												pk_yr_credit_first_seen2 = 4  => 0.3211678832,
												pk_yr_credit_first_seen2 = 5  => 0.237704918,
												pk_yr_credit_first_seen2 = 6  => 0.2427745665,
												pk_yr_credit_first_seen2 = 7  => 0.2088181261,
												pk_yr_credit_first_seen2 = 8  => 0.1918044927,
												pk_yr_credit_first_seen2 = 9  => 0.1809595769,
												pk_yr_credit_first_seen2 = 10 => 0.1590594744,
																				 0.1263736264);

	pk_yr_header_first_seen2_mm_b1_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.3074380165,
												pk_yr_header_first_seen2 = 0  => 0.2847222222,
												pk_yr_header_first_seen2 = 1  => 0.2090032154,
												pk_yr_header_first_seen2 = 2  => 0.2152542373,
												pk_yr_header_first_seen2 = 3  => 0.2103321033,
												pk_yr_header_first_seen2 = 4  => 0.1794642857,
												pk_yr_header_first_seen2 = 5  => 0.1771390374,
												pk_yr_header_first_seen2 = 6  => 0.1689272503,
																				 0.1630824373);

	pk_yr_infutor_first_seen2_mm_b1_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.1805672269,
												 pk_yr_infutor_first_seen2 = 0  => 0.2146487294,
												 pk_yr_infutor_first_seen2 = 1  => 0.1871120307,
												 pk_yr_infutor_first_seen2 = 2  => 0.1714471969,
												 pk_yr_infutor_first_seen2 = 3  => 0.1749226006,
																				   0.1892473118);

	pk_add2_em_ver_lvl_mm_b1_c2_b1 := map(pk_add2_em_ver_lvl = -1 => 0.15,
										  pk_add2_em_ver_lvl = 0  => 0.1871188617,
										  pk_add2_em_ver_lvl = 1  => 0.1909307876,
																	 0.1822222222);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1666666667,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.5185185185,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.3623188406,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.2352941176,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.3153153153,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.2307692308,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.3089430894,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2438162544,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2308091286,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2042287362,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1993442623,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1869918699,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.179946626,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1597051597,
																						  0.1615776081);

	pk_nas_summary_mm_b1_c2_b2 := map(pk_nas_summary = 0 => 0.323943662,
									  pk_nas_summary = 1 => 0.2611311673,
															0.2563508886);

	pk_nap_summary_mm_b1_c2_b2 := map(pk_nap_summary = -1 => 0.3308605341,
									  pk_nap_summary = 0  => 0.264260918,
									  pk_nap_summary = 1  => 0.2334931759,
															 0.2239837398);

	pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2463316354,
												pk_rc_dirsaddr_lastscore = 0  => 0.2805111821,
												pk_rc_dirsaddr_lastscore = 1  => 0.2716981132,
																				 0.2551517743);

	pk_adl_score_mm_b1_c2_b2 := map(pk_adl_score = 0 => 0.3578947368,
														0.2561689138);

	pk_combo_hphonescore_mm_b1_c2_b2 := map(pk_combo_hphonescore = 0 => 0.2617507546,
											pk_combo_hphonescore = 1 => 0.3333333333,
																		0.2456289576);

	pk_combo_ssnscore_mm_b1_c2_b2 := map(pk_combo_ssnscore = -1 => 0.35,
										 pk_combo_ssnscore = 0  => 0.3224043716,
																   0.2559516191);

	pk_combo_dobscore_mm_b1_c2_b2 := map(pk_combo_dobscore = -1 => 0.3656550703,
										 pk_combo_dobscore = 0  => 0.2923351159,
										 pk_combo_dobscore = 1  => 0.2719522592,
																   0.2503064477);

	pk_combo_fnamecount_mm_b1_c2_b2 := map(pk_combo_fnamecount = 0 => 0.3367088608,
										   pk_combo_fnamecount = 1 => 0.2726571539,
										   pk_combo_fnamecount = 2 => 0.2662827895,
										   pk_combo_fnamecount = 3 => 0.2484173208,
																	  0.2331040507);

	pk_rc_phonelnamecount_mm_b1_c2_b2 := map(pk_rc_phonelnamecount = 0 => 0.2655059848,
																		  0.2298553719);

	pk_rc_addrcount_mm_b1_c2_b2 := map(pk_rc_addrcount = 0 => 0.2692845616,
									   pk_rc_addrcount = 1 => 0.2424487322,
									   pk_rc_addrcount = 2 => 0.2335711603,
															  0.1975308642);

	pk_rc_phonephonecount_mm_b1_c2_b2 := map(pk_rc_phonephonecount = 0 => 0.2601318119,
																		  0.2507518132);

	pk_ver_phncount_mm_b1_c2_b2 := map(pk_ver_phncount = 0 => 0.257196945,
									   pk_ver_phncount = 1 => 0.2838407494,
									   pk_ver_phncount = 2 => 0.2623088792,
															  0.2239837398);

	pk_gong_did_phone_ct_mm_b1_c2_b2 := map(pk_gong_did_phone_ct = -1 => 0.2443405737,
											pk_gong_did_phone_ct = 0  => 0.2442731975,
											pk_gong_did_phone_ct = 1  => 0.2563151387,
											pk_gong_did_phone_ct = 2  => 0.2824020403,
																		 0.37109375);

	pk_combo_ssncount_mm_b1_c2_b2 := map(pk_combo_ssncount = -1 => 0.3577981651,
										 pk_combo_ssncount = 0  => 0.2780124723,
																   0.2195792185);

	pk_combo_dobcount_mm_b1_c2_b2 := map(pk_combo_dobcount = 0 => 0.3441422594,
										 pk_combo_dobcount = 1 => 0.2811080836,
										 pk_combo_dobcount = 2 => 0.2657128258,
										 pk_combo_dobcount = 3 => 0.2563164894,
																  0.2354897458);

	pk_eq_count_mm_b1_c2_b2 := map(pk_eq_count = 0 => 0.3181818182,
								   pk_eq_count = 1 => 0.3572542902,
								   pk_eq_count = 2 => 0.3128415301,
								   pk_eq_count = 3 => 0.2970890411,
								   pk_eq_count = 4 => 0.275862069,
								   pk_eq_count = 5 => 0.2537462537,
													  0.2415663672);

	pk_pos_secondary_sources_mm_b1_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.2569638769,
												pk_pos_secondary_sources = 1 => 0.2642857143,
																				0.12);

	pk_voter_flag_mm_b1_c2_b2 := map(pk_voter_flag = -1 => 0.3048936715,
									 pk_voter_flag = 0  => 0.2471589021,
														   0.253389029);

	pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.2616531099,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.2828365879,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.2134337728,
																						  0.2228436223);

	pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2604190389,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.2796208531,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.2282314765,
																						  0.2303647159);

	pk_add1_address_score_mm_b1_c2_b2 := map(pk_add1_address_score = 0 => 0.2651452963,
																		  0.2547852977);

	pk_add2_address_score_mm_b1_c2_b2 := map(pk_add2_address_score = 0 => 0.2954796031,
											 pk_add2_address_score = 1 => 0.2553324533,
											 pk_add2_address_score = 2 => 0.2480686695,
																		  0.2782051282);

	pk_add2_pos_sources_mm_b1_c2_b2 := map(pk_add2_pos_sources = 0 => 0.2673926195,
										   pk_add2_pos_sources = 1 => 0.2590044516,
										   pk_add2_pos_sources = 2 => 0.2423764458,
										   pk_add2_pos_sources = 3 => 0.2588719899,
																	  0.2328244275);

	pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2568119244,
																						  0.2307692308);

	pk_infutor_risk_lvl_mm_b1_c2_b2 := map(pk_infutor_risk_lvl = 0 => 0.260338716,
										   pk_infutor_risk_lvl = 1 => 0.2399307454,
																	  0.2808471455);

	pk_yr_adl_em_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_em_first_seen2 = -1 => 0.2592085877,
												pk_yr_adl_em_first_seen2 = 0  => 0.2591743119,
												pk_yr_adl_em_first_seen2 = 1  => 0.2590315142,
												pk_yr_adl_em_first_seen2 = 2  => 0.2552727273,
												pk_yr_adl_em_first_seen2 = 3  => 0.254205191,
																				 0.2110091743);

	pk_yr_adl_vo_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.259580091,
												pk_yr_adl_vo_first_seen2 = 0  => 0.2619834711,
												pk_yr_adl_vo_first_seen2 = 1  => 0.2444766389,
												pk_yr_adl_vo_first_seen2 = 2  => 0.2471855115,
																				 0.254864188);

	pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.2580870717,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.2443729904,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.2609970674,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.2352941176,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.25088,
																						   0.2368421053);

	pk_yr_lname_change_date2_mm_b1_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.2557576996,
												pk_yr_lname_change_date2 = 0  => 0.292004635,
												pk_yr_lname_change_date2 = 1  => 0.2629558541,
																				 0.2388451444);

	pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.2498181818,
												  pk_yr_gong_did_first_seen2 = 0  => 0.3048327138,
												  pk_yr_gong_did_first_seen2 = 1  => 0.2753721245,
												  pk_yr_gong_did_first_seen2 = 2  => 0.2612374405,
												  pk_yr_gong_did_first_seen2 = 3  => 0.2562292359,
																					 0.2542112382);

	pk_yr_credit_first_seen2_mm_b1_c2_b2 := map(pk_yr_credit_first_seen2 = -1 => 0.3571428571,
												pk_yr_credit_first_seen2 = 0  => 0.4393939394,
												pk_yr_credit_first_seen2 = 1  => 0.4039735099,
												pk_yr_credit_first_seen2 = 2  => 0.4110169492,
												pk_yr_credit_first_seen2 = 3  => 0.4057771664,
												pk_yr_credit_first_seen2 = 4  => 0.3462414579,
												pk_yr_credit_first_seen2 = 5  => 0.3094170404,
												pk_yr_credit_first_seen2 = 6  => 0.3043305522,
												pk_yr_credit_first_seen2 = 7  => 0.2761475886,
												pk_yr_credit_first_seen2 = 8  => 0.2569772762,
												pk_yr_credit_first_seen2 = 9  => 0.2384401114,
												pk_yr_credit_first_seen2 = 10 => 0.1968893176,
																				 0.1474358974);

	pk_yr_header_first_seen2_mm_b1_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.3431058177,
												pk_yr_header_first_seen2 = 0  => 0.3178294574,
												pk_yr_header_first_seen2 = 1  => 0.3167128347,
												pk_yr_header_first_seen2 = 2  => 0.2625311548,
												pk_yr_header_first_seen2 = 3  => 0.2603892688,
												pk_yr_header_first_seen2 = 4  => 0.2453490698,
												pk_yr_header_first_seen2 = 5  => 0.2157394844,
												pk_yr_header_first_seen2 = 6  => 0.2074688797,
																				 0.2281368821);

	pk_yr_infutor_first_seen2_mm_b1_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.260338716,
												 pk_yr_infutor_first_seen2 = 0  => 0.2761544285,
												 pk_yr_infutor_first_seen2 = 1  => 0.2282628933,
												 pk_yr_infutor_first_seen2 = 2  => 0.240116521,
												 pk_yr_infutor_first_seen2 = 3  => 0.2633879781,
																				   0.2612612613);

	pk_add2_em_ver_lvl_mm_b1_c2_b2 := map(pk_add2_em_ver_lvl = -1 => 0.1525423729,
										  pk_add2_em_ver_lvl = 0  => 0.2576798573,
										  pk_add2_em_ver_lvl = 1  => 0.238453276,
																	 0.2459893048);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.4285714286,
												 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.8,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.4133333333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.3913043478,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.4141414141,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.4139534884,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.3818181818,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.4192708333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.4035087719,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.351010101,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.3043251694,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2955036324,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2744501638,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2609665428,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2538202538,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.238108484,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.197389683,
																						  0.1867364747);

	pk_nas_summary_mm_b1_c2_b3 := map(pk_nas_summary = 0 => 0.2857142857,
									  pk_nas_summary = 1 => 0.2056603774,
															0.183828651);

	pk_nap_summary_mm_b1_c2_b3 := map(pk_nap_summary = -1 => 0.262987013,
									  pk_nap_summary = 0  => 0.1947336653,
									  pk_nap_summary = 1  => 0.1641531323,
															 0.1428027418);

	pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := map(pk_rc_dirsaddr_lastscore = -1 => 0.1803187803,
												pk_rc_dirsaddr_lastscore = 0  => 0.2254316069,
												pk_rc_dirsaddr_lastscore = 1  => 0.1710144928,
																				 0.1745231608);

	pk_adl_score_mm_b1_c2_b3 := map(pk_adl_score = 0 => 0.225433526,
														0.1849596933);

	pk_combo_hphonescore_mm_b1_c2_b3 := map(pk_combo_hphonescore = 0 => 0.1902898068,
											pk_combo_hphonescore = 1 => 0.2,
																		0.1747925311);

	pk_combo_ssnscore_mm_b1_c2_b3 := map(pk_combo_ssnscore = -1 => 0.3333333333,
										 pk_combo_ssnscore = 0  => 0.2361111111,
																   0.1842000794);

	pk_combo_dobscore_mm_b1_c2_b3 := map(pk_combo_dobscore = -1 => 0.2681451613,
										 pk_combo_dobscore = 0  => 0.2215053763,
										 pk_combo_dobscore = 1  => 0.2049586777,
																   0.1690572344);

	pk_combo_fnamecount_mm_b1_c2_b3 := map(pk_combo_fnamecount = 0 => 0.2384161752,
										   pk_combo_fnamecount = 1 => 0.1948981875,
										   pk_combo_fnamecount = 2 => 0.1816509542,
										   pk_combo_fnamecount = 3 => 0.1542708672,
																	  0.1365118174);

	pk_rc_phonelnamecount_mm_b1_c2_b3 := map(pk_rc_phonelnamecount = 0 => 0.19610032,
																		  0.1530726257);

	pk_rc_addrcount_mm_b1_c2_b3 := map(pk_rc_addrcount = 0 => 0.2035238505,
									   pk_rc_addrcount = 1 => 0.1571168253,
									   pk_rc_addrcount = 2 => 0.1317626527,
															  0.1302083333);

	pk_rc_phonephonecount_mm_b1_c2_b3 := map(pk_rc_phonephonecount = 0 => 0.1894119646,
																		  0.1775716146);

	pk_ver_phncount_mm_b1_c2_b3 := map(pk_ver_phncount = 0 => 0.1923309544,
									   pk_ver_phncount = 1 => 0.2175989086,
									   pk_ver_phncount = 2 => 0.1754343039,
															  0.1428027418);

	pk_gong_did_phone_ct_mm_b1_c2_b3 := map(pk_gong_did_phone_ct = -1 => 0.1915870455,
											pk_gong_did_phone_ct = 0  => 0.1757402101,
											pk_gong_did_phone_ct = 1  => 0.1762645914,
											pk_gong_did_phone_ct = 2  => 0.1957317073,
																		 0.2009803922);

	pk_combo_ssncount_mm_b1_c2_b3 := map(pk_combo_ssncount = -1 => 0.2857142857,
										 pk_combo_ssncount = 0  => 0.1848175512,
																   0.1041666667);

	pk_combo_dobcount_mm_b1_c2_b3 := map(pk_combo_dobcount = 0 => 0.2607809847,
										 pk_combo_dobcount = 1 => 0.1986126323,
										 pk_combo_dobcount = 2 => 0.1768085106,
										 pk_combo_dobcount = 3 => 0.1708444877,
																  0.1389295116);

	pk_eq_count_mm_b1_c2_b3 := map(pk_eq_count = 0 => 0.2797927461,
								   pk_eq_count = 1 => 0.2597231378,
								   pk_eq_count = 2 => 0.2226782966,
								   pk_eq_count = 3 => 0.1916961131,
								   pk_eq_count = 4 => 0.1902552204,
								   pk_eq_count = 5 => 0.1753645434,
													  0.1506234414);

	pk_pos_secondary_sources_mm_b1_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.1854974705,
												pk_pos_secondary_sources = 1 => 0.1785714286,
																				0.1315789474);

	pk_voter_flag_mm_b1_c2_b3 := map(pk_voter_flag = -1 => 0.2257298031,
									 pk_voter_flag = 0  => 0.1843349088,
														   0.1706123529);

	pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.1961726452,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.1840891622,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.1633466135,
																						  0.1407884151);

	pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.19639214,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.1954413191,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.1652078775,
																						  0.149957877);

	pk_add1_address_score_mm_b1_c2_b3 := map(pk_add1_address_score = 0 => 0.1992801047,
																		  0.1824851912);

	pk_add2_address_score_mm_b1_c2_b3 := map(pk_add2_address_score = 0 => 0.2559440559,
											 pk_add2_address_score = 1 => 0.1801448992,
											 pk_add2_address_score = 2 => 0.1865203762,
																		  0.1434034417);

	pk_add2_pos_sources_mm_b1_c2_b3 := map(pk_add2_pos_sources = 0 => 0.2494407159,
										   pk_add2_pos_sources = 1 => 0.1829328102,
										   pk_add2_pos_sources = 2 => 0.1593357271,
										   pk_add2_pos_sources = 3 => 0.1689088191,
																	  0.1697530864);

	pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.1851831112,
																						  0.2407407407);

	pk_infutor_risk_lvl_mm_b1_c2_b3 := map(pk_infutor_risk_lvl = 0 => 0.1896162528,
										   pk_infutor_risk_lvl = 1 => 0.1631749276,
																	  0.2143979881);

	pk_yr_adl_em_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_em_first_seen2 = -1 => 0.1960916442,
												pk_yr_adl_em_first_seen2 = 0  => 0.2173913043,
												pk_yr_adl_em_first_seen2 = 1  => 0.1976744186,
												pk_yr_adl_em_first_seen2 = 2  => 0.1627296588,
												pk_yr_adl_em_first_seen2 = 3  => 0.1668556311,
																				 0.1534988713);

	pk_yr_adl_vo_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.1952501813,
												pk_yr_adl_vo_first_seen2 = 0  => 0.1766561514,
												pk_yr_adl_vo_first_seen2 = 1  => 0.182,
												pk_yr_adl_vo_first_seen2 = 2  => 0.1644204852,
																				 0.1646022571);

	pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1866581551,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.1779141104,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.219858156,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.1781376518,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.1705237515,
																						   0.2222222222);

	pk_yr_lname_change_date2_mm_b1_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.1846107604,
												pk_yr_lname_change_date2 = 0  => 0.2047244094,
												pk_yr_lname_change_date2 = 1  => 0.1893687708,
																				 0.1856287425);

	pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.1981580083,
												  pk_yr_gong_did_first_seen2 = 0  => 0.2192448234,
												  pk_yr_gong_did_first_seen2 = 1  => 0.22899729,
												  pk_yr_gong_did_first_seen2 = 2  => 0.2043010753,
												  pk_yr_gong_did_first_seen2 = 3  => 0.1765217391,
																					 0.1639814309);

	pk_yr_credit_first_seen2_mm_b1_c2_b3 := map(pk_yr_credit_first_seen2 = -1 => 0.3461538462,
												pk_yr_credit_first_seen2 = 0  => 0.3411764706,
												pk_yr_credit_first_seen2 = 1  => 0.3131067961,
												pk_yr_credit_first_seen2 = 2  => 0.2610364683,
												pk_yr_credit_first_seen2 = 3  => 0.2441243366,
												pk_yr_credit_first_seen2 = 4  => 0.2160583942,
												pk_yr_credit_first_seen2 = 5  => 0.2073891626,
												pk_yr_credit_first_seen2 = 6  => 0.17503884,
												pk_yr_credit_first_seen2 = 7  => 0.1842105263,
												pk_yr_credit_first_seen2 = 8  => 0.1645904115,
												pk_yr_credit_first_seen2 = 9  => 0.1562009419,
												pk_yr_credit_first_seen2 = 10 => 0.128975265,
																				 0.0897435897);

	pk_yr_header_first_seen2_mm_b1_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.2325312801,
												pk_yr_header_first_seen2 = 0  => 0.1935483871,
												pk_yr_header_first_seen2 = 1  => 0.2196601942,
												pk_yr_header_first_seen2 = 2  => 0.1767676768,
												pk_yr_header_first_seen2 = 3  => 0.1786971831,
												pk_yr_header_first_seen2 = 4  => 0.1516917598,
												pk_yr_header_first_seen2 = 5  => 0.1428571429,
												pk_yr_header_first_seen2 = 6  => 0.1661721068,
																				 0.1169354839);

	pk_yr_infutor_first_seen2_mm_b1_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.1896162528,
												 pk_yr_infutor_first_seen2 = 0  => 0.1971481711,
												 pk_yr_infutor_first_seen2 = 1  => 0.1735587081,
												 pk_yr_infutor_first_seen2 = 2  => 0.1651376147,
												 pk_yr_infutor_first_seen2 = 3  => 0.1666666667,
																				   0.1852986217);

	pk_add2_em_ver_lvl_mm_b1_c2_b3 := map(pk_add2_em_ver_lvl = -1 => 0.037037037,
										  pk_add2_em_ver_lvl = 0  => 0.186298984,
										  pk_add2_em_ver_lvl = 1  => 0.1800847458,
																	 0.1329787234);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.5384615385,
												 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3857142857,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.3063829787,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.2985781991,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.3053097345,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2702702703,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.2327586207,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.274566474,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.1808219178,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.2185534591,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2120592744,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.1879139073,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1705175601,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1583113456,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1711229947,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1567567568,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1313204802,
																						  0.0981012658);

	pk_nap_summary_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_nap_summary_mm_b1_c2_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_nap_summary_mm_b1_c2_b2,
																   pk_nap_summary_mm_b1_c2_b3);

	pk_yr_infutor_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_infutor_first_seen2_mm_b1_c2_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_yr_infutor_first_seen2_mm_b1_c2_b2,
																			  pk_yr_infutor_first_seen2_mm_b1_c2_b3);

	pk_yr_lname_change_date2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_lname_change_date2_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_lname_change_date2_mm_b1_c2_b2,
																			 pk_yr_lname_change_date2_mm_b1_c2_b3);

	pk_ssnchar_invalid_or_recent_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b1,
											  pk_segment3_2 = '1 Derog-Other' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b2,
																				 pk_ssnchar_invalid_or_recent_mm_b1_c2_b3);

	pk_yr_adl_em_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_em_first_seen2_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_em_first_seen2_mm_b1_c2_b2,
																			 pk_yr_adl_em_first_seen2_mm_b1_c2_b3);

	pk_adl_score_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_adl_score_mm_b1_c2_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_adl_score_mm_b1_c2_b2,
																 pk_adl_score_mm_b1_c2_b3);

	pk_rc_phonelnamecount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_phonelnamecount_mm_b1_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_rc_phonelnamecount_mm_b1_c2_b2,
																		  pk_rc_phonelnamecount_mm_b1_c2_b3);

	pk_rc_dirsaddr_lastscore_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b2,
																			 pk_rc_dirsaddr_lastscore_mm_b1_c2_b3);

	pk_combo_ssncount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_ssncount_mm_b1_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_ssncount_mm_b1_c2_b2,
																	  pk_combo_ssncount_mm_b1_c2_b3);

	pk_yr_adl_vo_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b2,
																			 pk_yr_adl_vo_first_seen2_mm_b1_c2_b3);

	pk_pos_secondary_sources_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_pos_secondary_sources_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_pos_secondary_sources_mm_b1_c2_b2,
																			 pk_pos_secondary_sources_mm_b1_c2_b3);

	pk_voter_flag_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_voter_flag_mm_b1_c2_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_voter_flag_mm_b1_c2_b2,
																  pk_voter_flag_mm_b1_c2_b3);

	pk_add2_address_score_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_address_score_mm_b1_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add2_address_score_mm_b1_c2_b2,
																		  pk_add2_address_score_mm_b1_c2_b3);

	pk_combo_ssnscore_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_ssnscore_mm_b1_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_ssnscore_mm_b1_c2_b2,
																	  pk_combo_ssnscore_mm_b1_c2_b3);

	pk_lname_eda_sourced_type_lvl_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2,
																				  pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3);

	pk_combo_dobscore_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_dobscore_mm_b1_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_dobscore_mm_b1_c2_b2,
																	  pk_combo_dobscore_mm_b1_c2_b3);

	pk_ver_phncount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_ver_phncount_mm_b1_c2_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_ver_phncount_mm_b1_c2_b2,
																	pk_ver_phncount_mm_b1_c2_b3);

	pk_combo_dobcount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_dobcount_mm_b1_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_dobcount_mm_b1_c2_b2,
																	  pk_combo_dobcount_mm_b1_c2_b3);

	pk_nas_summary_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_nas_summary_mm_b1_c2_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_nas_summary_mm_b1_c2_b2,
																   pk_nas_summary_mm_b1_c2_b3);

	pk_rc_addrcount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_addrcount_mm_b1_c2_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_rc_addrcount_mm_b1_c2_b2,
																	pk_rc_addrcount_mm_b1_c2_b3);

	pk_gong_did_phone_ct_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_gong_did_phone_ct_mm_b1_c2_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_gong_did_phone_ct_mm_b1_c2_b2,
																		 pk_gong_did_phone_ct_mm_b1_c2_b3);

	pk_yr_gong_did_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_gong_did_first_seen2_mm_b1_c2_b1,
											pk_segment3_2 = '1 Derog-Other' => pk_yr_gong_did_first_seen2_mm_b1_c2_b2,
																			   pk_yr_gong_did_first_seen2_mm_b1_c2_b3);

	pk_combo_hphonescore_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_hphonescore_mm_b1_c2_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_combo_hphonescore_mm_b1_c2_b2,
																		 pk_combo_hphonescore_mm_b1_c2_b3);

	pk_yr_adl_em_only_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2,
																				  pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3);

	pk_add2_em_ver_lvl_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_em_ver_lvl_mm_b1_c2_b1,
									pk_segment3_2 = '1 Derog-Other' => pk_add2_em_ver_lvl_mm_b1_c2_b2,
																	   pk_add2_em_ver_lvl_mm_b1_c2_b3);

	pk_yr_credit_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_credit_first_seen2_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_credit_first_seen2_mm_b1_c2_b2,
																			 pk_yr_credit_first_seen2_mm_b1_c2_b3);

	pk_eq_count_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_eq_count_mm_b1_c2_b1,
							 pk_segment3_2 = '1 Derog-Other' => pk_eq_count_mm_b1_c2_b2,
																pk_eq_count_mm_b1_c2_b3);

	pk_yr_header_first_seen2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_header_first_seen2_mm_b1_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_header_first_seen2_mm_b1_c2_b2,
																			 pk_yr_header_first_seen2_mm_b1_c2_b3);

	pk_add1_address_score_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_address_score_mm_b1_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_address_score_mm_b1_c2_b2,
																		  pk_add1_address_score_mm_b1_c2_b3);

	pk_combo_fnamecount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_fnamecount_mm_b1_c2_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_combo_fnamecount_mm_b1_c2_b2,
																		pk_combo_fnamecount_mm_b1_c2_b3);

	pk_rc_phonephonecount_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_phonephonecount_mm_b1_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_rc_phonephonecount_mm_b1_c2_b2,
																		  pk_rc_phonephonecount_mm_b1_c2_b3);

	pk_add2_pos_sources_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_pos_sources_mm_b1_c2_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_add2_pos_sources_mm_b1_c2_b2,
																		pk_add2_pos_sources_mm_b1_c2_b3);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2,
																			  pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3);

	pk_fname_eda_sourced_type_lvl_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2,
																				  pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3);

	pk_infutor_risk_lvl_mm_b1 := map(pk_segment3_2 = '0 Derog-Owner' => pk_infutor_risk_lvl_mm_b1_c2_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_infutor_risk_lvl_mm_b1_c2_b2,
																		pk_infutor_risk_lvl_mm_b1_c2_b3);

	pk_nas_summary_mm_b2_c2_b1 := map(pk_nas_summary = 0 => 0.4078947368,
									  pk_nas_summary = 1 => 0.2786231884,
															0.2230102443);

	pk_nap_summary_mm_b2_c2_b1 := map(pk_nap_summary = -1 => 0.3369565217,
									  pk_nap_summary = 0  => 0.2497069168,
									  pk_nap_summary = 1  => 0.2490272374,
															 0.2052631579);

	pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2556100982,
												pk_rc_dirsaddr_lastscore = 0  => 0.2518043304,
												pk_rc_dirsaddr_lastscore = 1  => 0.1747572816,
																				 0.2408848832);

	pk_adl_score_mm_b2_c2_b1 := map(pk_adl_score = 0 => 0.2413793103,
														0.2483221477);

	pk_combo_hphonescore_mm_b2_c2_b1 := map(pk_combo_hphonescore = 0 => 0.2473941715,
											pk_combo_hphonescore = 1 => 0.3333333333,
																		0.2490861619);

	pk_combo_ssnscore_mm_b2_c2_b1 := map(pk_combo_ssnscore = -1 => 0.4814814815,
										 pk_combo_ssnscore = 0  => 0.3522727273,
																   0.2458639706);

	pk_combo_dobscore_mm_b2_c2_b1 := map(pk_combo_dobscore = -1 => 0.3722627737,
										 pk_combo_dobscore = 0  => 0.3246753247,
										 pk_combo_dobscore = 1  => 0.2565217391,
																   0.2432211696);

	pk_combo_fnamecount_nb_mm_b2_c2_b1 := map(pk_combo_fnamecount_nb = 0 => 0.2695035461,
											  pk_combo_fnamecount_nb = 1 => 0.3177387914,
											  pk_combo_fnamecount_nb = 2 => 0.2602262837,
											  pk_combo_fnamecount_nb = 3 => 0.2575851393,
											  pk_combo_fnamecount_nb = 4 => 0.23046875,
											  pk_combo_fnamecount_nb = 5 => 0.2306967985,
																			0.2137161085);

	pk_rc_phonelnamecount_mm_b2_c2_b1 := map(pk_rc_phonelnamecount = 0 => 0.2536273941,
																		  0.2293080054);

	pk_combo_addrcount_nb_mm_b2_c2_b1 := map(pk_combo_addrcount_nb = 0 => 0.2791586998,
											 pk_combo_addrcount_nb = 1 => 0.2583148559,
											 pk_combo_addrcount_nb = 2 => 0.2565186751,
											 pk_combo_addrcount_nb = 3 => 0.181598063,
											 pk_combo_addrcount_nb = 4 => 0.172972973,
																		  0.1590909091);

	pk_rc_addrcount_nb_mm_b2_c2_b1 := map(pk_rc_addrcount_nb = 0 => 0.28125,
										  pk_rc_addrcount_nb = 1 => 0.2262653899,
																	0.1744186047);

	pk_rc_phonephonecount_mm_b2_c2_b1 := map(pk_rc_phonephonecount = 0 => 0.2464742894,
																		  0.2522123894);

	pk_ver_phncount_mm_b2_c2_b1 := map(pk_ver_phncount = 0 => 0.2594241615,
									   pk_ver_phncount = 1 => 0.2575516693,
									   pk_ver_phncount = 2 => 0.2309820194,
															  0.2052631579);

	pk_gong_did_phone_ct_nb_mm_b2_c2_b1 := map(pk_gong_did_phone_ct_nb = -2 => 0.2410071942,
											   pk_gong_did_phone_ct_nb = -1 => 0.2459178624,
											   pk_gong_did_phone_ct_nb = 0  => 0.240167364,
											   pk_gong_did_phone_ct_nb = 1  => 0.2411003236,
																			   0.3076923077);

	pk_combo_ssncount_mm_b2_c2_b1 := map(pk_combo_ssncount = -1 => 0.4428571429,
										 pk_combo_ssncount = 0  => 0.2617786451,
																   0.2273945077);

	pk_combo_dobcount_nb_mm_b2_c2_b1 := map(pk_combo_dobcount_nb = 0 => 0.3470790378,
											pk_combo_dobcount_nb = 1 => 0.2603550296,
											pk_combo_dobcount_nb = 2 => 0.2743221691,
											pk_combo_dobcount_nb = 3 => 0.2406671962,
											pk_combo_dobcount_nb = 4 => 0.25030012,
											pk_combo_dobcount_nb = 5 => 0.2265625,
											pk_combo_dobcount_nb = 6 => 0.2322834646,
																		0.2465753425);

	pk_eq_count_mm_b2_c2_b1 := map(pk_eq_count = 0 => 0.5,
								   pk_eq_count = 1 => 0.3333333333,
								   pk_eq_count = 2 => 0.3130081301,
								   pk_eq_count = 3 => 0.2876106195,
								   pk_eq_count = 4 => 0.2642857143,
								   pk_eq_count = 5 => 0.2560766861,
													  0.2239069111);

	pk_pos_secondary_sources_mm_b2_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.2468383361,
												pk_pos_secondary_sources = 1 => 0.4186046512,
																				0.2972972973);

	pk_voter_flag_mm_b2_c2_b1 := map(pk_voter_flag = -1 => 0.276119403,
									 pk_voter_flag = 0  => 0.2446016381,
														   0.2442118617);

	pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.2620911098,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.2096774194,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.1879895561,
																						  0.2157598499);

	pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.2591463415,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.2408712364,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.2199592668,
																						  0.2339776195);

	pk_add1_address_score_mm_b2_c2_b1 := map(pk_add1_address_score = 0 => 0.2745752427,
																		  0.2222886167);

	pk_add2_address_score_mm_b2_c2_b1 := map(pk_add2_address_score = 0 => 0.2649006623,
											 pk_add2_address_score = 1 => 0.2487878281,
											 pk_add2_address_score = 2 => 0.233463035,
																		  0.2401574803);

	pk_add2_pos_sources_mm_b2_c2_b1 := map(pk_add2_pos_sources = 0 => 0.235426009,
										   pk_add2_pos_sources = 1 => 0.2545670225,
										   pk_add2_pos_sources = 2 => 0.240188383,
										   pk_add2_pos_sources = 3 => 0.2350187266,
																	  0.2418772563);

	pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2481927711,
																						  0.3333333333);

	pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := map(pk_infutor_risk_lvl_nb = 0 => 0.1991001125,
											  pk_infutor_risk_lvl_nb = 1 => 0.2620607504,
											  pk_infutor_risk_lvl_nb = 2 => 0.2129032258,
																			0.2837370242);

	pk_yr_adl_em_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_em_first_seen2 = -1 => 0.2522805017,
												pk_yr_adl_em_first_seen2 = 0  => 0.2254901961,
												pk_yr_adl_em_first_seen2 = 1  => 0.183908046,
												pk_yr_adl_em_first_seen2 = 2  => 0.213559322,
												pk_yr_adl_em_first_seen2 = 3  => 0.2503317116,
																				 0.2962962963);

	pk_yr_adl_vo_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.2502637131,
												pk_yr_adl_vo_first_seen2 = 0  => 0.2345276873,
												pk_yr_adl_vo_first_seen2 = 1  => 0.1892285298,
												pk_yr_adl_vo_first_seen2 = 2  => 0.2421524664,
																				 0.2763997165);

	pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.2496413199,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.1891891892,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.2151898734,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.2016806723,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.2585301837,
																						   0.1515151515);

	pk_yr_lname_change_date2_mm_b2_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.2472491909,
												pk_yr_lname_change_date2 = 0  => 0.2727272727,
												pk_yr_lname_change_date2 = 1  => 0.2661290323,
																				 0.2340425532);

	pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.2474837182,
												  pk_yr_gong_did_first_seen2 = 0  => 0.2828685259,
												  pk_yr_gong_did_first_seen2 = 1  => 0.2921348315,
												  pk_yr_gong_did_first_seen2 = 2  => 0.2617647059,
												  pk_yr_gong_did_first_seen2 = 3  => 0.2540983607,
																					 0.2408536585);

	pk_yr_credit_first_seen2_mm_b2_c2_b1 := map(pk_yr_credit_first_seen2 = -1 => 0.52,
												pk_yr_credit_first_seen2 = 0  => 0.25,
												pk_yr_credit_first_seen2 = 1  => 0.4285714286,
												pk_yr_credit_first_seen2 = 2  => 0.35,
												pk_yr_credit_first_seen2 = 3  => 0.4302325581,
												pk_yr_credit_first_seen2 = 4  => 0.4428571429,
												pk_yr_credit_first_seen2 = 5  => 0.2926829268,
												pk_yr_credit_first_seen2 = 6  => 0.2770083102,
												pk_yr_credit_first_seen2 = 7  => 0.285012285,
												pk_yr_credit_first_seen2 = 8  => 0.2367688022,
												pk_yr_credit_first_seen2 = 9  => 0.2341696535,
												pk_yr_credit_first_seen2 = 10 => 0.2146619842,
																				 0.2307692308);

	pk_yr_header_first_seen2_mm_b2_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.3020833333,
												pk_yr_header_first_seen2 = 0  => 0.34375,
												pk_yr_header_first_seen2 = 1  => 0.2777777778,
												pk_yr_header_first_seen2 = 2  => 0.313225058,
												pk_yr_header_first_seen2 = 3  => 0.233974359,
												pk_yr_header_first_seen2 = 4  => 0.240348964,
												pk_yr_header_first_seen2 = 5  => 0.2200772201,
												pk_yr_header_first_seen2 = 6  => 0.2298850575,
																				 0.3197674419);

	pk_yr_infutor_first_seen2_mm_b2_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.2620607504,
												 pk_yr_infutor_first_seen2 = 0  => 0.253125,
												 pk_yr_infutor_first_seen2 = 1  => 0.2133815552,
												 pk_yr_infutor_first_seen2 = 2  => 0.1920529801,
												 pk_yr_infutor_first_seen2 = 3  => 0.2663316583,
																				   0.2793522267);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.4444444444,
												 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 1,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.25,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.3333333333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.2857142857,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.3333333333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.4117647059,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.3953488372,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.4074074074,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.4833333333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2913043478,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2889447236,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.2782258065,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2670349908,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2198177677,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.2274881517,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.2169117647,
																						  0.2573839662);

	pk_nas_summary_mm_b2_c2_b2 := map(pk_nas_summary = 0 => 0.4043209877,
									  pk_nas_summary = 1 => 0.3542675545,
															0.3003892132);

	pk_nap_summary_mm_b2_c2_b2 := map(pk_nap_summary = -1 => 0.4090441932,
									  pk_nap_summary = 0  => 0.3376340285,
									  pk_nap_summary = 1  => 0.3010139417,
															 0.306038048);

	pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := map(pk_rc_dirsaddr_lastscore = -1 => 0.32833764,
												pk_rc_dirsaddr_lastscore = 0  => 0.3553734062,
												pk_rc_dirsaddr_lastscore = 1  => 0.3493449782,
																				 0.3321585903);

	pk_adl_score_mm_b2_c2_b2 := map(pk_adl_score = 0 => 0.3779904306,
														0.3359317905);

	pk_combo_hphonescore_mm_b2_c2_b2 := map(pk_combo_hphonescore = 0 => 0.3337762424,
											pk_combo_hphonescore = 1 => 0.4534883721,
																		0.3414939242);

	pk_combo_ssnscore_mm_b2_c2_b2 := map(pk_combo_ssnscore = -1 => 0.3981481481,
										 pk_combo_ssnscore = 0  => 0.4436619718,
																   0.3345295448);

	pk_combo_dobscore_mm_b2_c2_b2 := map(pk_combo_dobscore = -1 => 0.4494382022,
										 pk_combo_dobscore = 0  => 0.4103585657,
										 pk_combo_dobscore = 1  => 0.3602409639,
																   0.324846405);

	pk_combo_fnamecount_nb_mm_b2_c2_b2 := map(pk_combo_fnamecount_nb = 0 => 0.4138428262,
											  pk_combo_fnamecount_nb = 1 => 0.3581004317,
											  pk_combo_fnamecount_nb = 2 => 0.346147064,
											  pk_combo_fnamecount_nb = 3 => 0.3226732267,
											  pk_combo_fnamecount_nb = 4 => 0.29664903,
											  pk_combo_fnamecount_nb = 5 => 0.2812219227,
																			0.2962138085);

	pk_rc_phonelnamecount_mm_b2_c2_b2 := map(pk_rc_phonelnamecount = 0 => 0.3414012017,
																		  0.3075679172);

	pk_combo_addrcount_nb_mm_b2_c2_b2 := map(pk_combo_addrcount_nb = 0 => 0.350886918,
											 pk_combo_addrcount_nb = 1 => 0.3354146654,
											 pk_combo_addrcount_nb = 2 => 0.3082987552,
											 pk_combo_addrcount_nb = 3 => 0.2727272727,
											 pk_combo_addrcount_nb = 4 => 0.265560166,
																		  0.2222222222);

	pk_rc_addrcount_nb_mm_b2_c2_b2 := map(pk_rc_addrcount_nb = 0 => 0.3556000891,
										  pk_rc_addrcount_nb = 1 => 0.30125,
																	0.2295081967);

	pk_rc_phonephonecount_mm_b2_c2_b2 := map(pk_rc_phonephonecount = 0 => 0.3338953332,
																		  0.3425330173);

	pk_ver_phncount_mm_b2_c2_b2 := map(pk_ver_phncount = 0 => 0.3383649573,
									   pk_ver_phncount = 1 => 0.3543033578,
									   pk_ver_phncount = 2 => 0.3224519405,
															  0.306038048);

	pk_gong_did_phone_ct_nb_mm_b2_c2_b2 := map(pk_gong_did_phone_ct_nb = -2 => 0.3187550309,
											   pk_gong_did_phone_ct_nb = -1 => 0.3289541034,
											   pk_gong_did_phone_ct_nb = 0  => 0.3361678005,
											   pk_gong_did_phone_ct_nb = 1  => 0.3611111111,
																			   0.4009077156);

	pk_combo_ssncount_mm_b2_c2_b2 := map(pk_combo_ssncount = -1 => 0.4406779661,
										 pk_combo_ssncount = 0  => 0.3627917185,
																   0.281213705);

	pk_combo_dobcount_nb_mm_b2_c2_b2 := map(pk_combo_dobcount_nb = 0 => 0.4387588459,
											pk_combo_dobcount_nb = 1 => 0.3555555556,
											pk_combo_dobcount_nb = 2 => 0.3437207123,
											pk_combo_dobcount_nb = 3 => 0.337861995,
											pk_combo_dobcount_nb = 4 => 0.3108796296,
											pk_combo_dobcount_nb = 5 => 0.2879141391,
											pk_combo_dobcount_nb = 6 => 0.2761087268,
																		0.3173076923);

	pk_eq_count_mm_b2_c2_b2 := map(pk_eq_count = 0 => 0.4129032258,
								   pk_eq_count = 1 => 0.4681583477,
								   pk_eq_count = 2 => 0.3837298542,
								   pk_eq_count = 3 => 0.3928194298,
								   pk_eq_count = 4 => 0.3437213566,
								   pk_eq_count = 5 => 0.3274373552,
													  0.318619919);

	pk_pos_secondary_sources_mm_b2_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.3367337025,
												pk_pos_secondary_sources = 1 => 0.3333333333,
																				0.2);

	pk_voter_flag_mm_b2_c2_b2 := map(pk_voter_flag = -1 => 0.3684540608,
									 pk_voter_flag = 0  => 0.3330428151,
														   0.3277551996);

	pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.3409541584,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.347605225,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.2805816938,
																						  0.3083573487);

	pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.3400333933,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.3516908213,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.3062827225,
																						  0.3088235294);

	pk_add1_address_score_mm_b2_c2_b2 := map(pk_add1_address_score = 0 => 0.351251936,
																		  0.2922871325);

	pk_add2_address_score_mm_b2_c2_b2 := map(pk_add2_address_score = 0 => 0.2824427481,
											 pk_add2_address_score = 1 => 0.3400961025,
											 pk_add2_address_score = 2 => 0.3197424893,
																		  0.2871870398);

	pk_add2_pos_sources_mm_b2_c2_b2 := map(pk_add2_pos_sources = 0 => 0.3275510204,
										   pk_add2_pos_sources = 1 => 0.3446540881,
										   pk_add2_pos_sources = 2 => 0.3225352113,
										   pk_add2_pos_sources = 3 => 0.3213762811,
																	  0.2680412371);

	pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.3363109609,
																						  0.375);

	pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := map(pk_infutor_risk_lvl_nb = 0 => 0.3155494756,
											  pk_infutor_risk_lvl_nb = 1 => 0.341502256,
											  pk_infutor_risk_lvl_nb = 2 => 0.276337381,
																			0.3769983298);

	pk_yr_adl_em_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_em_first_seen2 = -1 => 0.3421985816,
												pk_yr_adl_em_first_seen2 = 0  => 0.3333333333,
												pk_yr_adl_em_first_seen2 = 1  => 0.3564356436,
												pk_yr_adl_em_first_seen2 = 2  => 0.3348729792,
												pk_yr_adl_em_first_seen2 = 3  => 0.3223350254,
																				 0.3188854489);

	pk_yr_adl_vo_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.341119403,
												pk_yr_adl_vo_first_seen2 = 0  => 0.3463463463,
												pk_yr_adl_vo_first_seen2 = 1  => 0.3143794423,
												pk_yr_adl_vo_first_seen2 = 2  => 0.3288702929,
																				 0.3289036545);

	pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.3397252433,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.3052208835,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.2342007435,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.3318777293,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.328705777,
																						   0.2545454545);

	pk_yr_lname_change_date2_mm_b2_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.3335782513,
												pk_yr_lname_change_date2 = 0  => 0.3618538324,
												pk_yr_lname_change_date2 = 1  => 0.371498173,
																				 0.3691275168);

	pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.3213736545,
												  pk_yr_gong_did_first_seen2 = 0  => 0.3953229399,
												  pk_yr_gong_did_first_seen2 = 1  => 0.3866133866,
												  pk_yr_gong_did_first_seen2 = 2  => 0.3684210526,
												  pk_yr_gong_did_first_seen2 = 3  => 0.3406326034,
																					 0.329909245);

	pk_yr_credit_first_seen2_mm_b2_c2_b2 := map(pk_yr_credit_first_seen2 = -1 => 0.4111111111,
												pk_yr_credit_first_seen2 = 0  => 0.6458333333,
												pk_yr_credit_first_seen2 = 1  => 0.4651162791,
												pk_yr_credit_first_seen2 = 2  => 0.4857142857,
												pk_yr_credit_first_seen2 = 3  => 0.4427374302,
												pk_yr_credit_first_seen2 = 4  => 0.4510739857,
												pk_yr_credit_first_seen2 = 5  => 0.4058500914,
												pk_yr_credit_first_seen2 = 6  => 0.3532206969,
												pk_yr_credit_first_seen2 = 7  => 0.3566624632,
												pk_yr_credit_first_seen2 = 8  => 0.336196319,
												pk_yr_credit_first_seen2 = 9  => 0.2983213429,
												pk_yr_credit_first_seen2 = 10 => 0.2585258526,
																				 0.2471910112);

	pk_yr_header_first_seen2_mm_b2_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.4152880776,
												pk_yr_header_first_seen2 = 0  => 0.4122287968,
												pk_yr_header_first_seen2 = 1  => 0.3850931677,
												pk_yr_header_first_seen2 = 2  => 0.3666534966,
												pk_yr_header_first_seen2 = 3  => 0.3681818182,
												pk_yr_header_first_seen2 = 4  => 0.3138145315,
												pk_yr_header_first_seen2 = 5  => 0.2879708384,
												pk_yr_header_first_seen2 = 6  => 0.2554744526,
																				 0.3964497041);

	pk_yr_infutor_first_seen2_mm_b2_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.341502256,
												 pk_yr_infutor_first_seen2 = 0  => 0.3447600392,
												 pk_yr_infutor_first_seen2 = 1  => 0.3123966942,
												 pk_yr_infutor_first_seen2 = 2  => 0.3302752294,
												 pk_yr_infutor_first_seen2 = 3  => 0.3513513514,
																				   0.3024793388);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3924050633,
												 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.75,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.5535714286,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4918032787,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.4606741573,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.5022624434,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.479338843,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.4441558442,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.4093023256,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.4623376623,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.4102564103,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.359375,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.3490599503,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.350973236,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.3233851186,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.2993295019,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.259986459,
																						  0.2862068966);

	pk_nas_summary_mm_b2_c2_b3 := map(pk_nas_summary = 0 => 0.3381389253,
									  pk_nas_summary = 1 => 0.3185173551,
															0.234065636);

	pk_nap_summary_mm_b2_c2_b3 := map(pk_nap_summary = -1 => 0.39503386,
									  pk_nap_summary = 0  => 0.2936658132,
									  pk_nap_summary = 1  => 0.2463942308,
															 0.2343470483);

	pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := map(pk_rc_dirsaddr_lastscore = -1 => 0.2921257291,
												pk_rc_dirsaddr_lastscore = 0  => 0.3179723502,
												pk_rc_dirsaddr_lastscore = 1  => 0.2746478873,
																				 0.258979206);

	pk_adl_score_mm_b2_c2_b3 := map(pk_adl_score = 0 => 0.3913043478,
														0.2887163953);

	pk_combo_hphonescore_mm_b2_c2_b3 := map(pk_combo_hphonescore = 0 => 0.287279064,
											pk_combo_hphonescore = 1 => 0.32,
																		0.3018660812);

	pk_combo_ssnscore_mm_b2_c2_b3 := map(pk_combo_ssnscore = -1 => 0.3194221509,
										 pk_combo_ssnscore = 0  => 0.4120603015,
																   0.2869434717);

	pk_combo_dobscore_mm_b2_c2_b3 := map(pk_combo_dobscore = -1 => 0.3650725875,
										 pk_combo_dobscore = 0  => 0.4004975124,
										 pk_combo_dobscore = 1  => 0.3103448276,
																   0.2621359223);

	pk_combo_fnamecount_nb_mm_b2_c2_b3 := map(pk_combo_fnamecount_nb = 0 => 0.3318264014,
											  pk_combo_fnamecount_nb = 1 => 0.2988022014,
											  pk_combo_fnamecount_nb = 2 => 0.272970562,
											  pk_combo_fnamecount_nb = 3 => 0.2494481236,
											  pk_combo_fnamecount_nb = 4 => 0.2122241087,
											  pk_combo_fnamecount_nb = 5 => 0.2333333333,
																			0.175);

	pk_rc_phonelnamecount_mm_b2_c2_b3 := map(pk_rc_phonelnamecount = 0 => 0.297505423,
																		  0.254226675);

	pk_combo_addrcount_nb_mm_b2_c2_b3 := map(pk_combo_addrcount_nb = 0 => 0.3160585228,
											 pk_combo_addrcount_nb = 1 => 0.2869326835,
											 pk_combo_addrcount_nb = 2 => 0.224456959,
											 pk_combo_addrcount_nb = 3 => 0.2357723577,
											 pk_combo_addrcount_nb = 4 => 0.1559633028,
																		  0.1176470588);

	pk_rc_addrcount_nb_mm_b2_c2_b3 := map(pk_rc_addrcount_nb = 0 => 0.3204279882,
										  pk_rc_addrcount_nb = 1 => 0.2357877639,
																	0.1);

	pk_rc_phonephonecount_mm_b2_c2_b3 := map(pk_rc_phonephonecount = 0 => 0.2861114622,
																		  0.3047520661);

	pk_ver_phncount_mm_b2_c2_b3 := map(pk_ver_phncount = 0 => 0.2995856354,
									   pk_ver_phncount = 1 => 0.3070229956,
									   pk_ver_phncount = 2 => 0.2519517388,
															  0.2343470483);

	pk_gong_did_phone_ct_nb_mm_b2_c2_b3 := map(pk_gong_did_phone_ct_nb = -2 => 0.2944600939,
											   pk_gong_did_phone_ct_nb = -1 => 0.2875638842,
											   pk_gong_did_phone_ct_nb = 0  => 0.2741456166,
											   pk_gong_did_phone_ct_nb = 1  => 0.2682926829,
																			   0.3459459459);

	pk_combo_ssncount_mm_b2_c2_b3 := map(pk_combo_ssncount = -1 => 0.3323863636,
										 pk_combo_ssncount = 0  => 0.2884348344,
																   0.2258064516);

	pk_combo_dobcount_nb_mm_b2_c2_b3 := map(pk_combo_dobcount_nb = 0 => 0.3702623907,
											pk_combo_dobcount_nb = 1 => 0.2767489712,
											pk_combo_dobcount_nb = 2 => 0.2689813048,
											pk_combo_dobcount_nb = 3 => 0.2705823293,
											pk_combo_dobcount_nb = 4 => 0.2313432836,
											pk_combo_dobcount_nb = 5 => 0.2231404959,
											pk_combo_dobcount_nb = 6 => 0.25,
																		0.6);

	pk_eq_count_mm_b2_c2_b3 := map(pk_eq_count = 0 => 0.3350318471,
								   pk_eq_count = 1 => 0.365470852,
								   pk_eq_count = 2 => 0.3491253644,
								   pk_eq_count = 3 => 0.3321167883,
								   pk_eq_count = 4 => 0.2792207792,
								   pk_eq_count = 5 => 0.2683615819,
													  0.2349585062);

	pk_pos_secondary_sources_mm_b2_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.2906803355,
												pk_pos_secondary_sources = 1 => 0.375,
																				0.2608695652);

	pk_voter_flag_mm_b2_c2_b3 := map(pk_voter_flag = -1 => 0.3498424133,
									 pk_voter_flag = 0  => 0.2844884488,
														   0.2663539867);

	pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3 := map(pk_fname_eda_sourced_type_lvl = 0 => 0.3004710264,
													 pk_fname_eda_sourced_type_lvl = 1 => 0.2677514793,
													 pk_fname_eda_sourced_type_lvl = 2 => 0.2256214149,
																						  0.2188139059);

	pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.3039215686,
													 pk_lname_eda_sourced_type_lvl = 1 => 0.2606149341,
													 pk_lname_eda_sourced_type_lvl = 2 => 0.2482269504,
																						  0.2589686099);

	pk_add1_address_score_mm_b2_c2_b3 := map(pk_add1_address_score = 0 => 0.3124140518,
																		  0.2306600426);

	pk_add2_address_score_mm_b2_c2_b3 := map(pk_add2_address_score = 0 => 0.285106383,
											 pk_add2_address_score = 1 => 0.2935819136,
											 pk_add2_address_score = 2 => 0.257918552,
																		  0.282527881);

	pk_add2_pos_sources_mm_b2_c2_b3 := map(pk_add2_pos_sources = 0 => 0.3115299335,
										   pk_add2_pos_sources = 1 => 0.2955275844,
										   pk_add2_pos_sources = 2 => 0.2564102564,
										   pk_add2_pos_sources = 3 => 0.291218638,
																	  0.2343096234);

	pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2908669448,
																						  0.375);

	pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := map(pk_infutor_risk_lvl_nb = 0 => 0.2395005675,
											  pk_infutor_risk_lvl_nb = 1 => 0.3036197564,
											  pk_infutor_risk_lvl_nb = 2 => 0.2203777905,
																			0.332894159);

	pk_yr_adl_em_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_em_first_seen2 = -1 => 0.3062877338,
												pk_yr_adl_em_first_seen2 = 0  => 0.296875,
												pk_yr_adl_em_first_seen2 = 1  => 0.2751540041,
												pk_yr_adl_em_first_seen2 = 2  => 0.2566371681,
												pk_yr_adl_em_first_seen2 = 3  => 0.2649199418,
																				 0.231292517);

	pk_yr_adl_vo_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_vo_first_seen2 = -1 => 0.3035343035,
												pk_yr_adl_vo_first_seen2 = 0  => 0.2828507795,
												pk_yr_adl_vo_first_seen2 = 1  => 0.2434367542,
												pk_yr_adl_vo_first_seen2 = 2  => 0.2448598131,
																				 0.2792134831);

	pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.295642933,
													 pk_yr_adl_em_only_first_seen2 = 0  => 0.2258064516,
													 pk_yr_adl_em_only_first_seen2 = 1  => 0.2522522523,
													 pk_yr_adl_em_only_first_seen2 = 2  => 0.2786069652,
													 pk_yr_adl_em_only_first_seen2 = 3  => 0.2612244898,
																						   0.2727272727);

	pk_yr_lname_change_date2_mm_b2_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.2881905727,
												pk_yr_lname_change_date2 = 0  => 0.3549382716,
												pk_yr_lname_change_date2 = 1  => 0.2985074627,
																				 0.320754717);

	pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.3020987916,
												  pk_yr_gong_did_first_seen2 = 0  => 0.3346007605,
												  pk_yr_gong_did_first_seen2 = 1  => 0.3351449275,
												  pk_yr_gong_did_first_seen2 = 2  => 0.3054003724,
												  pk_yr_gong_did_first_seen2 = 3  => 0.2813370474,
																					 0.2646668436);

	pk_yr_credit_first_seen2_mm_b2_c2_b3 := map(pk_yr_credit_first_seen2 = -1 => 0.3206896552,
												pk_yr_credit_first_seen2 = 0  => 0.4678362573,
												pk_yr_credit_first_seen2 = 1  => 0.3880126183,
												pk_yr_credit_first_seen2 = 2  => 0.3701923077,
												pk_yr_credit_first_seen2 = 3  => 0.3651626443,
												pk_yr_credit_first_seen2 = 4  => 0.3251028807,
												pk_yr_credit_first_seen2 = 5  => 0.284203103,
												pk_yr_credit_first_seen2 = 6  => 0.2953586498,
												pk_yr_credit_first_seen2 = 7  => 0.2651006711,
												pk_yr_credit_first_seen2 = 8  => 0.2558970693,
												pk_yr_credit_first_seen2 = 9  => 0.2568027211,
												pk_yr_credit_first_seen2 = 10 => 0.2361809045,
																				 0.125);

	pk_yr_header_first_seen2_mm_b2_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.3288246269,
												pk_yr_header_first_seen2 = 0  => 0.3257575758,
												pk_yr_header_first_seen2 = 1  => 0.2996254682,
												pk_yr_header_first_seen2 = 2  => 0.2798329356,
												pk_yr_header_first_seen2 = 3  => 0.2540716612,
												pk_yr_header_first_seen2 = 4  => 0.2517694641,
												pk_yr_header_first_seen2 = 5  => 0.2214765101,
												pk_yr_header_first_seen2 = 6  => 0.2201834862,
																				 0.25);

	pk_yr_infutor_first_seen2_mm_b2_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.3036197564,
												 pk_yr_infutor_first_seen2 = 0  => 0.3100573215,
												 pk_yr_infutor_first_seen2 = 1  => 0.2543962485,
												 pk_yr_infutor_first_seen2 = 2  => 0.261299435,
												 pk_yr_infutor_first_seen2 = 3  => 0.2359550562,
																				   0.2524590164);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.3258426966,
												 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.5714285714,
												 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.4012738854,
												 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4134078212,
												 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.3939393939,
												 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.3608247423,
												 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.4171428571,
												 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.3387387387,
												 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.3794466403,
												 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.3211845103,
												 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2870708546,
												 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2823145124,
												 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.265746333,
												 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2601626016,
												 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.2531806616,
												 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.2585034014,
												 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.233877902,
																						  0.2280701754);

	pk_nap_summary_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_nap_summary_mm_b2_c2_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_nap_summary_mm_b2_c2_b2,
																   pk_nap_summary_mm_b2_c2_b3);

	pk_yr_infutor_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_infutor_first_seen2_mm_b2_c2_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_yr_infutor_first_seen2_mm_b2_c2_b2,
																			  pk_yr_infutor_first_seen2_mm_b2_c2_b3);

	pk_yr_lname_change_date2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_lname_change_date2_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_lname_change_date2_mm_b2_c2_b2,
																			 pk_yr_lname_change_date2_mm_b2_c2_b3);

	pk_ssnchar_invalid_or_recent_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b1,
											  pk_segment3_2 = '1 Derog-Other' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b2,
																				 pk_ssnchar_invalid_or_recent_mm_b2_c2_b3);

	pk_gong_did_phone_ct_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_gong_did_phone_ct_nb_mm_b2_c2_b1,
										 pk_segment3_2 = '1 Derog-Other' => pk_gong_did_phone_ct_nb_mm_b2_c2_b2,
																			pk_gong_did_phone_ct_nb_mm_b2_c2_b3);

	pk_yr_adl_em_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_em_first_seen2_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_em_first_seen2_mm_b2_c2_b2,
																			 pk_yr_adl_em_first_seen2_mm_b2_c2_b3);

	pk_adl_score_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_adl_score_mm_b2_c2_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_adl_score_mm_b2_c2_b2,
																 pk_adl_score_mm_b2_c2_b3);

	pk_combo_dobcount_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_dobcount_nb_mm_b2_c2_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_combo_dobcount_nb_mm_b2_c2_b2,
																		 pk_combo_dobcount_nb_mm_b2_c2_b3);

	pk_rc_phonelnamecount_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_phonelnamecount_mm_b2_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_rc_phonelnamecount_mm_b2_c2_b2,
																		  pk_rc_phonelnamecount_mm_b2_c2_b3);

	pk_combo_fnamecount_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_fnamecount_nb_mm_b2_c2_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_combo_fnamecount_nb_mm_b2_c2_b2,
																		   pk_combo_fnamecount_nb_mm_b2_c2_b3);

	pk_rc_dirsaddr_lastscore_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b2,
																			 pk_rc_dirsaddr_lastscore_mm_b2_c2_b3);

	pk_combo_ssncount_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_ssncount_mm_b2_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_ssncount_mm_b2_c2_b2,
																	  pk_combo_ssncount_mm_b2_c2_b3);

	pk_yr_adl_vo_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b2,
																			 pk_yr_adl_vo_first_seen2_mm_b2_c2_b3);

	pk_pos_secondary_sources_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_pos_secondary_sources_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_pos_secondary_sources_mm_b2_c2_b2,
																			 pk_pos_secondary_sources_mm_b2_c2_b3);

	pk_voter_flag_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_voter_flag_mm_b2_c2_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_voter_flag_mm_b2_c2_b2,
																  pk_voter_flag_mm_b2_c2_b3);

	pk_add2_address_score_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_address_score_mm_b2_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add2_address_score_mm_b2_c2_b2,
																		  pk_add2_address_score_mm_b2_c2_b3);

	pk_combo_ssnscore_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_ssnscore_mm_b2_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_ssnscore_mm_b2_c2_b2,
																	  pk_combo_ssnscore_mm_b2_c2_b3);

	pk_lname_eda_sourced_type_lvl_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2,
																				  pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3);

	pk_combo_dobscore_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_dobscore_mm_b2_c2_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_combo_dobscore_mm_b2_c2_b2,
																	  pk_combo_dobscore_mm_b2_c2_b3);

	pk_ver_phncount_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_ver_phncount_mm_b2_c2_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_ver_phncount_mm_b2_c2_b2,
																	pk_ver_phncount_mm_b2_c2_b3);

	pk_nas_summary_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_nas_summary_mm_b2_c2_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_nas_summary_mm_b2_c2_b2,
																   pk_nas_summary_mm_b2_c2_b3);

	pk_yr_gong_did_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_gong_did_first_seen2_mm_b2_c2_b1,
											pk_segment3_2 = '1 Derog-Other' => pk_yr_gong_did_first_seen2_mm_b2_c2_b2,
																			   pk_yr_gong_did_first_seen2_mm_b2_c2_b3);

	pk_combo_hphonescore_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_hphonescore_mm_b2_c2_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_combo_hphonescore_mm_b2_c2_b2,
																		 pk_combo_hphonescore_mm_b2_c2_b3);

	pk_yr_adl_em_only_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2,
																				  pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3);

	pk_infutor_risk_lvl_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_infutor_risk_lvl_nb_mm_b2_c2_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_infutor_risk_lvl_nb_mm_b2_c2_b2,
																		   pk_infutor_risk_lvl_nb_mm_b2_c2_b3);

	pk_yr_credit_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_credit_first_seen2_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_credit_first_seen2_mm_b2_c2_b2,
																			 pk_yr_credit_first_seen2_mm_b2_c2_b3);

	pk_combo_addrcount_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_combo_addrcount_nb_mm_b2_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_combo_addrcount_nb_mm_b2_c2_b2,
																		  pk_combo_addrcount_nb_mm_b2_c2_b3);

	pk_yr_header_first_seen2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_header_first_seen2_mm_b2_c2_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_header_first_seen2_mm_b2_c2_b2,
																			 pk_yr_header_first_seen2_mm_b2_c2_b3);

	pk_eq_count_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_eq_count_mm_b2_c2_b1,
							 pk_segment3_2 = '1 Derog-Other' => pk_eq_count_mm_b2_c2_b2,
																pk_eq_count_mm_b2_c2_b3);

	pk_add1_address_score_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_address_score_mm_b2_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_address_score_mm_b2_c2_b2,
																		  pk_add1_address_score_mm_b2_c2_b3);

	pk_rc_phonephonecount_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_phonephonecount_mm_b2_c2_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_rc_phonephonecount_mm_b2_c2_b2,
																		  pk_rc_phonephonecount_mm_b2_c2_b3);

	pk_rc_addrcount_nb_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_rc_addrcount_nb_mm_b2_c2_b1,
									pk_segment3_2 = '1 Derog-Other' => pk_rc_addrcount_nb_mm_b2_c2_b2,
																	   pk_rc_addrcount_nb_mm_b2_c2_b3);

	pk_add2_pos_sources_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_pos_sources_mm_b2_c2_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_add2_pos_sources_mm_b2_c2_b2,
																		pk_add2_pos_sources_mm_b2_c2_b3);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2,
																			  pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3);

	pk_fname_eda_sourced_type_lvl_mm_b2 := map(pk_segment3_2 = '0 Derog-Owner' => pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1,
											   pk_segment3_2 = '1 Derog-Other' => pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2,
																				  pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3);

	pk_nap_summary_mm := if((integer)add1_isbestmatch = 1, pk_nap_summary_mm_b1, pk_nap_summary_mm_b2);

	pk_yr_infutor_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_infutor_first_seen2_mm_b1, pk_yr_infutor_first_seen2_mm_b2);

	pk_yr_lname_change_date2_mm := if((integer)add1_isbestmatch = 1, pk_yr_lname_change_date2_mm_b1, pk_yr_lname_change_date2_mm_b2);

	pk_ssnchar_invalid_or_recent_mm := if((integer)add1_isbestmatch = 1, pk_ssnchar_invalid_or_recent_mm_b1, pk_ssnchar_invalid_or_recent_mm_b2);

	pk_gong_did_phone_ct_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_gong_did_phone_ct_nb_mm_b2);

	pk_yr_adl_em_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_em_first_seen2_mm_b1, pk_yr_adl_em_first_seen2_mm_b2);

	pk_adl_score_mm := if((integer)add1_isbestmatch = 1, pk_adl_score_mm_b1, pk_adl_score_mm_b2);

	pk_combo_dobcount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_combo_dobcount_nb_mm_b2);

	pk_rc_phonelnamecount_mm := if((integer)add1_isbestmatch = 1, pk_rc_phonelnamecount_mm_b1, pk_rc_phonelnamecount_mm_b2);

	pk_combo_fnamecount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_combo_fnamecount_nb_mm_b2);

	pk_rc_dirsaddr_lastscore_mm := if((integer)add1_isbestmatch = 1, pk_rc_dirsaddr_lastscore_mm_b1, pk_rc_dirsaddr_lastscore_mm_b2);

	pk_combo_ssncount_mm := if((integer)add1_isbestmatch = 1, pk_combo_ssncount_mm_b1, pk_combo_ssncount_mm_b2);

	pk_yr_adl_vo_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_vo_first_seen2_mm_b1, pk_yr_adl_vo_first_seen2_mm_b2);

	pk_pos_secondary_sources_mm := if((integer)add1_isbestmatch = 1, pk_pos_secondary_sources_mm_b1, pk_pos_secondary_sources_mm_b2);

	pk_voter_flag_mm := if((integer)add1_isbestmatch = 1, pk_voter_flag_mm_b1, pk_voter_flag_mm_b2);

	pk_add2_address_score_mm := if((integer)add1_isbestmatch = 1, pk_add2_address_score_mm_b1, pk_add2_address_score_mm_b2);

	pk_combo_ssnscore_mm := if((integer)add1_isbestmatch = 1, pk_combo_ssnscore_mm_b1, pk_combo_ssnscore_mm_b2);

	pk_lname_eda_sourced_type_lvl_mm := if((integer)add1_isbestmatch = 1, pk_lname_eda_sourced_type_lvl_mm_b1, pk_lname_eda_sourced_type_lvl_mm_b2);

	pk_combo_dobscore_mm := if((integer)add1_isbestmatch = 1, pk_combo_dobscore_mm_b1, pk_combo_dobscore_mm_b2);

	pk_ver_phncount_mm := if((integer)add1_isbestmatch = 1, pk_ver_phncount_mm_b1, pk_ver_phncount_mm_b2);

	pk_combo_dobcount_mm := if((integer)add1_isbestmatch = 1, pk_combo_dobcount_mm_b1, NULL);

	pk_nas_summary_mm := if((integer)add1_isbestmatch = 1, pk_nas_summary_mm_b1, pk_nas_summary_mm_b2);

	pk_rc_addrcount_mm := if((integer)add1_isbestmatch = 1, pk_rc_addrcount_mm_b1, NULL);

	pk_gong_did_phone_ct_mm := if((integer)add1_isbestmatch = 1, pk_gong_did_phone_ct_mm_b1, NULL);

	pk_yr_gong_did_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_gong_did_first_seen2_mm_b1, pk_yr_gong_did_first_seen2_mm_b2);

	pk_combo_hphonescore_mm := if((integer)add1_isbestmatch = 1, pk_combo_hphonescore_mm_b1, pk_combo_hphonescore_mm_b2);

	pk_yr_adl_em_only_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_em_only_first_seen2_mm_b1, pk_yr_adl_em_only_first_seen2_mm_b2);

	pk_infutor_risk_lvl_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_infutor_risk_lvl_nb_mm_b2);

	pk_add2_em_ver_lvl_mm := if((integer)add1_isbestmatch = 1, pk_add2_em_ver_lvl_mm_b1, NULL);

	pk_yr_credit_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_credit_first_seen2_mm_b1, pk_yr_credit_first_seen2_mm_b2);

	pk_combo_addrcount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_combo_addrcount_nb_mm_b2);

	pk_eq_count_mm := if((integer)add1_isbestmatch = 1, pk_eq_count_mm_b1, pk_eq_count_mm_b2);

	pk_yr_header_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_header_first_seen2_mm_b1, pk_yr_header_first_seen2_mm_b2);

	pk_add1_address_score_mm := if((integer)add1_isbestmatch = 1, pk_add1_address_score_mm_b1, pk_add1_address_score_mm_b2);

	pk_combo_fnamecount_mm := if((integer)add1_isbestmatch = 1, pk_combo_fnamecount_mm_b1, NULL);

	pk_rc_phonephonecount_mm := if((integer)add1_isbestmatch = 1, pk_rc_phonephonecount_mm_b1, pk_rc_phonephonecount_mm_b2);

	pk_rc_addrcount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_rc_addrcount_nb_mm_b2);

	pk_add2_pos_sources_mm := if((integer)add1_isbestmatch = 1, pk_add2_pos_sources_mm_b1, pk_add2_pos_sources_mm_b2);

	pk_yrmo_adl_f_sn_mx_fcra2_mm := if((integer)add1_isbestmatch = 1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b2);

	pk_fname_eda_sourced_type_lvl_mm := if((integer)add1_isbestmatch = 1, pk_fname_eda_sourced_type_lvl_mm_b1, pk_fname_eda_sourced_type_lvl_mm_b2);

	pk_infutor_risk_lvl_mm := if((integer)add1_isbestmatch = 1, pk_infutor_risk_lvl_mm_b1, NULL);

	pk_estimated_income_mm_b1 := map(pk_estimated_income = -1 => 0.3846153846,
									 pk_estimated_income = 0  => 0.2682926829,
									 pk_estimated_income = 1  => 0.2737642586,
									 pk_estimated_income = 2  => 0.2590361446,
									 pk_estimated_income = 3  => 0.2845188285,
									 pk_estimated_income = 4  => 0.2719298246,
									 pk_estimated_income = 5  => 0.2765486726,
									 pk_estimated_income = 6  => 0.2752136752,
									 pk_estimated_income = 7  => 0.2417266187,
									 pk_estimated_income = 8  => 0.2526690391,
									 pk_estimated_income = 9  => 0.2220039293,
									 pk_estimated_income = 10 => 0.2055369128,
									 pk_estimated_income = 11 => 0.2238095238,
									 pk_estimated_income = 12 => 0.21875,
									 pk_estimated_income = 13 => 0.2225832656,
									 pk_estimated_income = 14 => 0.2089795918,
									 pk_estimated_income = 15 => 0.2036713287,
									 pk_estimated_income = 16 => 0.2134615385,
									 pk_estimated_income = 17 => 0.1970649895,
									 pk_estimated_income = 18 => 0.2073684211,
									 pk_estimated_income = 19 => 0.1708229426,
									 pk_estimated_income = 20 => 0.1649575896,
									 pk_estimated_income = 21 => 0.1888888889,
																 0.170212766);

	pk_yr_adl_pr_first_seen2_mm_b1 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.2582203522,
										  pk_yr_adl_pr_first_seen2 = 0  => 0.1977329975,
										  pk_yr_adl_pr_first_seen2 = 1  => 0.1994750656,
										  pk_yr_adl_pr_first_seen2 = 2  => 0.1840909091,
										  pk_yr_adl_pr_first_seen2 = 3  => 0.1752055661,
										  pk_yr_adl_pr_first_seen2 = 4  => 0.1807147674,
										  pk_yr_adl_pr_first_seen2 = 5  => 0.1642691415,
										  pk_yr_adl_pr_first_seen2 = 6  => 0.1580645161,
																		   0.2325581395);

	pk_yr_adl_w_first_seen2_mm_b1 := map(pk_yr_adl_w_first_seen2 = -1 => 0.2030164245,
										 pk_yr_adl_w_first_seen2 = 0  => 0.1881188119,
										 pk_yr_adl_w_first_seen2 = 1  => 0.1973434535,
																		 0.1333333333);

	pk_yr_adl_w_last_seen2_mm_b1 := map(pk_yr_adl_w_last_seen2 = -1 => 0.2030164245,
										pk_yr_adl_w_last_seen2 = 0  => 0.2,
										pk_yr_adl_w_last_seen2 = 1  => 0.1764705882,
																	   0.1929133858);

	pk_pr_count_mm_b1 := map(pk_pr_count = -1 => 0.2617471873,
							 pk_pr_count = 0  => 0.1966044143,
							 pk_pr_count = 1  => 0.179798706,
												 0.1910828025);

	pk_addrs_sourced_lvl_mm_b1 := map(pk_addrs_sourced_lvl = 0 => 0.2185192852,
									  pk_addrs_sourced_lvl = 1 => 0.1939142462,
									  pk_addrs_sourced_lvl = 2 => 0.1728222997,
																  0.1463068182);

	pk_add1_own_level_mm_b1 := map(pk_add1_own_level = -1 => 0.2259161315,
								   pk_add1_own_level = 0  => 0.2284293094,
								   pk_add1_own_level = 1  => 0.2492723849,
								   pk_add1_own_level = 2  => 0.175817757,
															 0.1566433566);

	pk_naprop_level2_mm_b1 := map(pk_naprop_level2 = -2 => 0.247311828,
								  pk_naprop_level2 = -1 => 0.2467532468,
								  pk_naprop_level2 = 0  => 0.2429501085,
								  pk_naprop_level2 = 1  => 0.2083333333,
								  pk_naprop_level2 = 2  => 0.2364204767,
								  pk_naprop_level2 = 3  => 0.2638587798,
								  pk_naprop_level2 = 4  => 0.2230088496,
								  pk_naprop_level2 = 5  => 0.2205632847,
								  pk_naprop_level2 = 6  => 0.1716205983,
														   0.1387202242);

	pk_yr_add1_built_date2_mm_b1 := map(pk_yr_add1_built_date2 = -4 => 0.2060295374,
										pk_yr_add1_built_date2 = -3 => 0.1904761905,
										pk_yr_add1_built_date2 = -2 => 0.1792014856,
										pk_yr_add1_built_date2 = -1 => 0.2047244094,
										pk_yr_add1_built_date2 = 0  => 0.1892380737,
										pk_yr_add1_built_date2 = 1  => 0.1908127208,
										pk_yr_add1_built_date2 = 2  => 0.2253652471,
																	   0.2044905009);

	pk_add1_purchase_amount2_mm_b1 := map(pk_add1_purchase_amount2 = -1 => 0.2209921758,
										  pk_add1_purchase_amount2 = 0  => 0.2019086571,
																		   0.1706253758);

	pk_add1_mortgage_amount2_mm_b1 := map(pk_add1_mortgage_amount2 = -1 => 0.2121593952,
										  pk_add1_mortgage_amount2 = 0  => 0.2095858734,
										  pk_add1_mortgage_amount2 = 1  => 0.2150848069,
																		   0.1703896104);

	pk_yr_add1_mortgage_date2_mm_b1 := map(pk_yr_add1_mortgage_date2 = -1 => 0.2094276939,
										   pk_yr_add1_mortgage_date2 = 0  => 0.1880743749,
										   pk_yr_add1_mortgage_date2 = 1  => 0.2040623524,
																			 0.1900369004);

	pk_add1_assessed_amount2_mm_b1 := map(pk_add1_assessed_amount2 = -1 => 0.2022481626,
										  pk_add1_assessed_amount2 = 0  => 0.2229679344,
										  pk_add1_assessed_amount2 = 1  => 0.2396946565,
										  pk_add1_assessed_amount2 = 2  => 0.2388852024,
										  pk_add1_assessed_amount2 = 3  => 0.2116697703,
										  pk_add1_assessed_amount2 = 4  => 0.1991744066,
										  pk_add1_assessed_amount2 = 5  => 0.1915085818,
																		   0.1777347948);

	pk_yr_add1_date_first_seen2_mm_b1 := map(pk_yr_add1_date_first_seen2 = -1 => 0.281615704,
											 pk_yr_add1_date_first_seen2 = 0  => 0.2125786164,
											 pk_yr_add1_date_first_seen2 = 1  => 0.1996830428,
											 pk_yr_add1_date_first_seen2 = 2  => 0.1979949875,
											 pk_yr_add1_date_first_seen2 = 3  => 0.2064428312,
											 pk_yr_add1_date_first_seen2 = 4  => 0.1884164223,
											 pk_yr_add1_date_first_seen2 = 5  => 0.194467965,
											 pk_yr_add1_date_first_seen2 = 6  => 0.1960285132,
											 pk_yr_add1_date_first_seen2 = 7  => 0.1826241135,
											 pk_yr_add1_date_first_seen2 = 8  => 0.1594048884,
											 pk_yr_add1_date_first_seen2 = 9  => 0.1855241265,
																				 0.1709090909);

	pk_add1_building_area2_mm_b1 := map(pk_add1_building_area2 = -99 => 0.2053978713,
										pk_add1_building_area2 = -4  => 0.2274472169,
										pk_add1_building_area2 = -3  => 0.2366412214,
										pk_add1_building_area2 = -2  => 0.1975057266,
										pk_add1_building_area2 = -1  => 0.1901522514,
										pk_add1_building_area2 = 0   => 0.1861471861,
										pk_add1_building_area2 = 1   => 0.1746031746,
										pk_add1_building_area2 = 2   => 0.2307692308,
										pk_add1_building_area2 = 3   => 0.277173913,
																		0.3012048193);

	pk_add1_no_of_rooms_mm_b1 := map(pk_add1_no_of_rooms = -1 => 0.2078125,
									 pk_add1_no_of_rooms = 0  => 0.2235609103,
									 pk_add1_no_of_rooms = 1  => 0.2028141679,
									 pk_add1_no_of_rooms = 2  => 0.1833333333,
									 pk_add1_no_of_rooms = 3  => 0.186746988,
																 0.1866216976);

	pk_add1_garage_type_risk_lvl_mm_b1 := map(pk_add1_garage_type_risk_level = 0 => 0.1850551655,
											  pk_add1_garage_type_risk_level = 1 => 0.2013406157,
											  pk_add1_garage_type_risk_level = 2 => 0.2066985646,
																					0.207003367);

	pk_add1_style_code_level_mm_b1 := map(pk_add1_style_code_level = 0 => 0.2062253436,
										  pk_add1_style_code_level = 1 => 0.1553133515,
										  pk_add1_style_code_level = 2 => 0.1748704663,
										  pk_add1_style_code_level = 3 => 0.1712473573,
																		  0.1822995461);

	pk_property_owned_total_mm_b1 := map(pk_property_owned_total = -1 => 0.2451968504,
										 pk_property_owned_total = 0  => 0.1915957053,
										 pk_property_owned_total = 1  => 0.1766973021,
										 pk_property_owned_total = 2  => 0.1818181818,
																		 0.1785714286);

	pk_prop1_prev_purchase_price2_mm_b1 := map(pk_prop1_prev_purchase_price2 = 0 => 0.2053669001,
											   pk_prop1_prev_purchase_price2 = 1 => 0.1420911528,
																					0.1563517915);

	pk_add2_building_area2_mm_b1 := map(pk_add2_building_area2 = -4 => 0.2050703478,
										pk_add2_building_area2 = -3 => 0.1964483907,
										pk_add2_building_area2 = -2 => 0.1832167832,
										pk_add2_building_area2 = -1 => 0.2019906323,
										pk_add2_building_area2 = 0  => 0.1933364618,
										pk_add2_building_area2 = 1  => 0.2857142857,
																	   0.2225705329);

	pk_add2_no_of_buildings_mm_b1 := map(pk_add2_no_of_buildings = -1 => 0.2007925408,
										 pk_add2_no_of_buildings = 0  => 0.2093933464,
										 pk_add2_no_of_buildings = 1  => 0.2216624685,
																		 0.303030303);

	pk_add2_no_of_rooms_mm_b1 := map(pk_add2_no_of_rooms = -1 => 0.2053592829,
									 pk_add2_no_of_rooms = 0  => 0.2068965517,
									 pk_add2_no_of_rooms = 1  => 0.1921193232,
																 0.1868787276);

	pk_add2_style_code_level_mm_b1 := map(pk_add2_style_code_level = 0 => 0.2049651211,
										  pk_add2_style_code_level = 1 => 0.1238095238,
										  pk_add2_style_code_level = 2 => 0.1533018868,
										  pk_add2_style_code_level = 3 => 0.2168674699,
																		  0.1751336898);

	pk_add2_purchase_amount2_mm_b1 := map(pk_add2_purchase_amount2 = -1 => 0.2083692591,
										  pk_add2_purchase_amount2 = 0  => 0.2015810277,
																		   0.1863940904);

	pk_add2_mortgage_risk_mm_b1 := map(pk_add2_mortgage_risk = -1 => 0.2068965517,
									   pk_add2_mortgage_risk = 0  => 0.179331307,
									   pk_add2_mortgage_risk = 1  => 0.2037354507,
									   pk_add2_mortgage_risk = 2  => 0.2051709758,
																	 0.2012345679);

	pk_add2_assessed_amount2_mm_b1 := map(pk_add2_assessed_amount2 = -1 => 0.2026030868,
										  pk_add2_assessed_amount2 = 0  => 0.2094668118,
										  pk_add2_assessed_amount2 = 1  => 0.2040490144,
										  pk_add2_assessed_amount2 = 2  => 0.2128418549,
										  pk_add2_assessed_amount2 = 3  => 0.1918882072,
																		   0.2118570183);

	pk_yr_add2_date_first_seen2_mm_b1 := map(pk_yr_add2_date_first_seen2 = -1 => 0.252016129,
											 pk_yr_add2_date_first_seen2 = 0  => 0.2250639386,
											 pk_yr_add2_date_first_seen2 = 1  => 0.2319004525,
											 pk_yr_add2_date_first_seen2 = 2  => 0.230459307,
											 pk_yr_add2_date_first_seen2 = 3  => 0.2190237797,
											 pk_yr_add2_date_first_seen2 = 4  => 0.1978253244,
											 pk_yr_add2_date_first_seen2 = 5  => 0.1926121372,
											 pk_yr_add2_date_first_seen2 = 6  => 0.2,
											 pk_yr_add2_date_first_seen2 = 7  => 0.1932287366,
											 pk_yr_add2_date_first_seen2 = 8  => 0.18412527,
											 pk_yr_add2_date_first_seen2 = 9  => 0.1707085117,
											 pk_yr_add2_date_first_seen2 = 10 => 0.1681000782,
																				 0.1538461538);

	pk_yr_add2_date_last_seen2_mm_b1 := map(pk_yr_add2_date_last_seen2 = -1 => 0.252016129,
											pk_yr_add2_date_last_seen2 = 0  => 0.2239495252,
											pk_yr_add2_date_last_seen2 = 1  => 0.1877317155,
											pk_yr_add2_date_last_seen2 = 2  => 0.177173913,
											pk_yr_add2_date_last_seen2 = 3  => 0.1710526316,
											pk_yr_add2_date_last_seen2 = 4  => 0.172489083,
											pk_yr_add2_date_last_seen2 = 5  => 0.138671875,
																			   0.1341030195);

	pk_add3_purchase_amount2_mm_b1 := map(pk_add3_purchase_amount2 = -1 => 0.2067792951,
										  pk_add3_purchase_amount2 = 0  => 0.2004219409,
										  pk_add3_purchase_amount2 = 1  => 0.2061258278,
										  pk_add3_purchase_amount2 = 2  => 0.2024390244,
										  pk_add3_purchase_amount2 = 3  => 0.1893651655,
																		   0.1804043546);

	pk_add3_mortgage_risk_mm_b1 := map(pk_add3_mortgage_risk = -1 => 0.1794871795,
									   pk_add3_mortgage_risk = 0  => 0.1863699583,
									   pk_add3_mortgage_risk = 1  => 0.2470588235,
									   pk_add3_mortgage_risk = 2  => 0.2027449083,
									   pk_add3_mortgage_risk = 3  => 0.213961922,
									   pk_add3_mortgage_risk = 4  => 0.2032755299,
																	 0.1866197183);

	pk_add3_assessed_amount2_mm_b1 := map(pk_add3_assessed_amount2 = -1 => 0.2004871448,
										  pk_add3_assessed_amount2 = 0  => 0.2279635258,
										  pk_add3_assessed_amount2 = 1  => 0.2389580974,
										  pk_add3_assessed_amount2 = 2  => 0.2169990503,
																		   0.1811894882);

	pk_yr_add3_date_first_seen2_mm_b1 := map(pk_yr_add3_date_first_seen2 = -1 => 0.2479882955,
											 pk_yr_add3_date_first_seen2 = 0  => 0.2558340536,
											 pk_yr_add3_date_first_seen2 = 1  => 0.2431972789,
											 pk_yr_add3_date_first_seen2 = 2  => 0.2291242363,
											 pk_yr_add3_date_first_seen2 = 3  => 0.2164759725,
											 pk_yr_add3_date_first_seen2 = 4  => 0.2092222987,
											 pk_yr_add3_date_first_seen2 = 5  => 0.1894390795,
											 pk_yr_add3_date_first_seen2 = 6  => 0.2010269576,
											 pk_yr_add3_date_first_seen2 = 7  => 0.1837443557,
											 pk_yr_add3_date_first_seen2 = 8  => 0.1769675411,
																				 0.1566861774);

	pk_yr_add3_date_last_seen2_mm_b1 := map(pk_yr_add3_date_last_seen2 = -1 => 0.2479882955,
											pk_yr_add3_date_last_seen2 = 0  => 0.2364212848,
											pk_yr_add3_date_last_seen2 = 1  => 0.2185154295,
											pk_yr_add3_date_last_seen2 = 2  => 0.2184517497,
											pk_yr_add3_date_last_seen2 = 3  => 0.2,
											pk_yr_add3_date_last_seen2 = 4  => 0.1688435808,
											pk_yr_add3_date_last_seen2 = 5  => 0.1657859974,
											pk_yr_add3_date_last_seen2 = 6  => 0.1488162345,
											pk_yr_add3_date_last_seen2 = 7  => 0.1294642857,
																			   0.1385665529);

	pk_bk_level_mm_b1 := map(pk_bk_level_2 = 0 => 0.2255667892,
							 pk_bk_level_2 = 1 => 0.1618618304,
												  0.2295948326);

	pk_eviction_level_mm_b1 := map(pk_eviction_level = 0 => 0.1910750683,
								   pk_eviction_level = 1 => 0.2833827893,
								   pk_eviction_level = 2 => 0.3237221494,
								   pk_eviction_level = 3 => 0.2724550898,
								   pk_eviction_level = 4 => 0.2513089005,
								   pk_eviction_level = 5 => 0.298245614,
								   pk_eviction_level = 6 => 0.3253012048,
															0.3302752294);

	pk_lien_type_level_mm_b1 := map(pk_lien_type_level = 0 => 0.1862215229,
									pk_lien_type_level = 1 => 0.1841004184,
									pk_lien_type_level = 2 => 0.1678714859,
									pk_lien_type_level = 3 => 0.2062245492,
									pk_lien_type_level = 4 => 0.2135443695,
															  0.2929447853);

	pk_yr_liens_last_unrel_date3_mm_b1 := map((integer)pk_yr_liens_last_unrel_date3_2 = -1 => 0.1910719966,
											  pk_yr_liens_last_unrel_date3_2 = -0.5        => 0.1774006942,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 0  => 0.2483241926,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 1  => 0.2450744834,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 2  => 0.2144166158,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 3  => 0.2002314815,
																							  0.1975446429);

	pk_yr_ln_unrel_lt_f_sn2_mm_b1 := map(pk_yr_liens_unrel_lt_first_sn2 = -1 => 0.1979296232,
										 pk_yr_liens_unrel_lt_first_sn2 = 0  => 0.3102564103,
																				0.3154069767);

	pk_yr_ln_unrel_ot_f_sn2_mm_b1 := map(pk_yr_liens_unrel_ot_first_sn2 = -1 => 0.2037128713,
										 pk_yr_liens_unrel_ot_first_sn2 = 0  => 0.1897810219,
										 pk_yr_liens_unrel_ot_first_sn2 = 1  => 0.187007874,
																				0.1902552204);

	pk_yr_attr_dt_l_eviction2_mm_b1 := map(pk_yr_attr_date_last_eviction2 = -1 => 0.1910049009,
										   pk_yr_attr_date_last_eviction2 = 0  => 0.2995529061,
										   pk_yr_attr_date_last_eviction2 = 1  => 0.2997858672,
										   pk_yr_attr_date_last_eviction2 = 2  => 0.3227272727,
										   pk_yr_attr_date_last_eviction2 = 3  => 0.3076923077,
										   pk_yr_attr_date_last_eviction2 = 4  => 0.2493074792,
																				  0.2848575712);

	pk_crime_level_mm_b1 := map(pk_crime_level = 0 => 0.196996073,
								pk_crime_level = 1 => 0.2794279428,
													  0.3861892583);

	pk_attr_total_number_derogs_mm_b1 := map(pk_attr_total_number_derogs_5 = 0 => 0.1986371818,
											 pk_attr_total_number_derogs_5 = 1 => 0.1757679181,
											 pk_attr_total_number_derogs_5 = 2 => 0.2006794467,
																				  0.2548945783);

	pk_yr_rc_ssnhighissue2_mm_b1 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.3888888889,
										pk_yr_rc_ssnhighissue2 = 0  => 0.3333333333,
										pk_yr_rc_ssnhighissue2 = 1  => 0.45,
										pk_yr_rc_ssnhighissue2 = 2  => 0.1984732824,
										pk_yr_rc_ssnhighissue2 = 3  => 0.2083333333,
										pk_yr_rc_ssnhighissue2 = 4  => 0.259569378,
										pk_yr_rc_ssnhighissue2 = 5  => 0.2314397355,
										pk_yr_rc_ssnhighissue2 = 6  => 0.2211388456,
										pk_yr_rc_ssnhighissue2 = 7  => 0.2360622803,
										pk_yr_rc_ssnhighissue2 = 8  => 0.2085752568,
										pk_yr_rc_ssnhighissue2 = 9  => 0.2014602488,
										pk_yr_rc_ssnhighissue2 = 10 => 0.2023552031,
										pk_yr_rc_ssnhighissue2 = 11 => 0.1705252676,
										pk_yr_rc_ssnhighissue2 = 12 => 0.1597139452,
										pk_yr_rc_ssnhighissue2 = 13 => 0.1496960486,
																	   0.1547464239);

	pk_pl_sourced_level_mm_b1 := map(pk_pl_sourced_level = 0 => 0.2041921907,
									 pk_pl_sourced_level = 1 => 0.2407407407,
									 pk_pl_sourced_level = 2 => 0.1917922948,
																0.1515151515);

	pk_prof_lic_cat_mm_b1 := map(pk_prof_lic_cat = -1 => 0.2041269319,
								 pk_prof_lic_cat = 0  => 0.2073813708,
								 pk_prof_lic_cat = 1  => 0.1805555556,
								 pk_prof_lic_cat = 2  => 0.1595744681,
														 0.1379310345);

	pk_add1_lres_mm_b1 := map(pk_add1_lres = -2 => 0.15,
							  pk_add1_lres = -1 => 0.2885126162,
							  pk_add1_lres = 0  => 0.2363636364,
							  pk_add1_lres = 1  => 0.2264808362,
							  pk_add1_lres = 2  => 0.1911262799,
							  pk_add1_lres = 3  => 0.2729970326,
							  pk_add1_lres = 4  => 0.1865042174,
							  pk_add1_lres = 5  => 0.1966292135,
							  pk_add1_lres = 6  => 0.1943811693,
							  pk_add1_lres = 7  => 0.1991223258,
							  pk_add1_lres = 8  => 0.1905959266,
							  pk_add1_lres = 9  => 0.1956145413,
							  pk_add1_lres = 10 => 0.1751809281,
												   0.1475);

	pk_add3_lres_mm_b1 := map(pk_add3_lres = -2 => 0.2415856395,
							  pk_add3_lres = -1 => 0.1836115326,
							  pk_add3_lres = 0  => 0.2023956532,
							  pk_add3_lres = 1  => 0.2123266564,
							  pk_add3_lres = 2  => 0.2080114449,
							  pk_add3_lres = 3  => 0.2017426273,
							  pk_add3_lres = 4  => 0.2022022022,
							  pk_add3_lres = 5  => 0.2100719424,
												   0.1931649331);

	pk_addrs_5yr_mm_b1 := map(pk_addrs_5yr = 0 => 0.1768303337,
							  pk_addrs_5yr = 1 => 0.1991334914,
							  pk_addrs_5yr = 2 => 0.216443529,
							  pk_addrs_5yr = 3 => 0.2441860465,
												  0.2845691383);

	pk_addrs_10yr_mm_b1 := map(pk_addrs_10yr = 0 => 0.1661375661,
							   pk_addrs_10yr = 1 => 0.1816905364,
							   pk_addrs_10yr = 2 => 0.2009061569,
							   pk_addrs_10yr = 3 => 0.2325760493,
													0.2547528517);

	pk_addrs_15yr_mm_b1 := map(pk_addrs_15yr = 0 => 0.1595273264,
							   pk_addrs_15yr = 1 => 0.1981855593,
							   pk_addrs_15yr = 2 => 0.2275686386,
													0.2972972973);

	pk_add_lres_month_avg2_mm_b1 := map(pk_add_lres_month_avg2 = -1 => 0.3529411765,
										pk_add_lres_month_avg2 = 0  => 0.2666666667,
										pk_add_lres_month_avg2 = 1  => 0.2425249169,
										pk_add_lres_month_avg2 = 2  => 0.2433460076,
										pk_add_lres_month_avg2 = 3  => 0.2423510467,
										pk_add_lres_month_avg2 = 4  => 0.2683823529,
										pk_add_lres_month_avg2 = 5  => 0.25249501,
										pk_add_lres_month_avg2 = 6  => 0.2520325203,
										pk_add_lres_month_avg2 = 7  => 0.2195540309,
										pk_add_lres_month_avg2 = 8  => 0.2181558935,
										pk_add_lres_month_avg2 = 9  => 0.2138487888,
										pk_add_lres_month_avg2 = 10 => 0.1941699605,
										pk_add_lres_month_avg2 = 11 => 0.204199259,
										pk_add_lres_month_avg2 = 12 => 0.1962050868,
										pk_add_lres_month_avg2 = 13 => 0.1813747228,
										pk_add_lres_month_avg2 = 15 => 0.1577495863,
																	   0.1567445365);

	pk_nameperssn_count_mm_b1 := map(pk_nameperssn_count = 0 => 0.2006717732,
									 pk_nameperssn_count = 1 => 0.2311168496,
																0.358974359);

	pk_ssns_per_adl_mm_b1 := map(pk_ssns_per_adl = -1 => 0.4285714286,
								 pk_ssns_per_adl = 0  => 0.1926105391,
								 pk_ssns_per_adl = 1  => 0.2048431313,
								 pk_ssns_per_adl = 2  => 0.2384576357,
								 pk_ssns_per_adl = 3  => 0.2679738562,
														 0.3208722741);

	pk_addrs_per_adl_mm_b1 := map(pk_addrs_per_adl = -6 => 0.4,
								  pk_addrs_per_adl = -5 => 0.2594059406,
								  pk_addrs_per_adl = -4 => 0.2360655738,
								  pk_addrs_per_adl = -3 => 0.2141823444,
								  pk_addrs_per_adl = -2 => 0.204620462,
								  pk_addrs_per_adl = -1 => 0.1999052582,
								  pk_addrs_per_adl = 0  => 0.1954816145,
								  pk_addrs_per_adl = 1  => 0.1920165175,
								  pk_addrs_per_adl = 2  => 0.2049353702,
														   0.2178217822);

	pk_phones_per_adl_mm_b1 := map(pk_phones_per_adl = -1 => 0.2115931282,
								   pk_phones_per_adl = 0  => 0.184574013,
								   pk_phones_per_adl = 1  => 0.2023038157,
															 0.2248995984);

	pk_adlperssn_count_mm_b1 := map(pk_adlperssn_count = -1 => 0.3902439024,
									pk_adlperssn_count = 0  => 0.1955679028,
									pk_adlperssn_count = 1  => 0.2062292909,
															   0.228804903);

	pk_adls_per_addr_mm_b1 := map(pk_adls_per_addr = -102 => 0.218579235,
								  pk_adls_per_addr = -101 => 0.2093023256,
								  pk_adls_per_addr = -2   => 0.2791127542,
								  pk_adls_per_addr = -1   => 0.2121212121,
								  pk_adls_per_addr = 0    => 0.1462765957,
								  pk_adls_per_addr = 1    => 0.1821480406,
								  pk_adls_per_addr = 2    => 0.1935483871,
								  pk_adls_per_addr = 3    => 0.1803367735,
								  pk_adls_per_addr = 4    => 0.1905002527,
								  pk_adls_per_addr = 5    => 0.1881390593,
								  pk_adls_per_addr = 6    => 0.1821933962,
								  pk_adls_per_addr = 7    => 0.2104259377,
								  pk_adls_per_addr = 8    => 0.1973954764,
								  pk_adls_per_addr = 9    => 0.2163501239,
								  pk_adls_per_addr = 10   => 0.2081877184,
								  pk_adls_per_addr = 11   => 0.2246851385,
								  pk_adls_per_addr = 12   => 0.2403965304,
								  pk_adls_per_addr = 13   => 0.2155870445,
								  pk_adls_per_addr = 100  => 0.1836734694,
								  pk_adls_per_addr = 101  => 0.1698113208,
															 0.2275600506);

	pk_adls_per_phone_mm_b1 := map(pk_adls_per_phone = -2 => 0.2097821048,
								   pk_adls_per_phone = -1 => 0.1882086168,
								   pk_adls_per_phone = 0  => 0.1871049305,
															 0.2523364486);

	pk_ssns_per_adl_c6_mm_b1 := map(pk_ssns_per_adl_c6 = 0 => 0.1934218636,
									pk_ssns_per_adl_c6 = 1 => 0.2221242283,
															  0.2580645161);

	pk_ssns_per_addr_c6_mm_b1 := map(pk_ssns_per_addr_c6 = 0   => 0.1889375,
									 pk_ssns_per_addr_c6 = 1   => 0.2229392173,
									 pk_ssns_per_addr_c6 = 2   => 0.2239404353,
									 pk_ssns_per_addr_c6 = 3   => 0.2266009852,
									 pk_ssns_per_addr_c6 = 4   => 0.2905027933,
									 pk_ssns_per_addr_c6 = 5   => 0.4285714286,
									 pk_ssns_per_addr_c6 = 6   => 0.2580645161,
									 pk_ssns_per_addr_c6 = 100 => 0.2128603104,
									 pk_ssns_per_addr_c6 = 101 => 0.269058296,
									 pk_ssns_per_addr_c6 = 102 => 0.2151898734,
									 pk_ssns_per_addr_c6 = 103 => 0.3157894737,
																  0.5714285714);

	pk_adls_per_phone_c6_mm_b1 := map(pk_adls_per_phone_c6 = 0 => 0.206976393,
									  pk_adls_per_phone_c6 = 1 => 0.1934468715,
																  0.1557377049);

	pk_attr_addrs_last24_mm_b1 := map(pk_attr_addrs_last24 = 0 => 0.1882109617,
									  pk_attr_addrs_last24 = 1 => 0.2125288762,
									  pk_attr_addrs_last24 = 2 => 0.2235857528,
									  pk_attr_addrs_last24 = 3 => 0.2300664452,
									  pk_attr_addrs_last24 = 4 => 0.244,
																  0.2203389831);

	pk_ams_class_level_mm_b1 := map(pk_ams_class_level = -1000001 => 0.1971412397,
									pk_ams_class_level = 0        => 0.306122449,
									pk_ams_class_level = 1        => 0.3928571429,
									pk_ams_class_level = 2        => 0.4047619048,
									pk_ams_class_level = 3        => 0.3555555556,
									pk_ams_class_level = 4        => 0.3,
									pk_ams_class_level = 5        => 0.3130434783,
									pk_ams_class_level = 6        => 0.2353982301,
									pk_ams_class_level = 7        => 0.2084309133,
									pk_ams_class_level = 8        => 0.2226379794,
									pk_ams_class_level = 1000000  => 0.2598870056,
									pk_ams_class_level = 1000001  => 0.176,
									pk_ams_class_level = 1000002  => 0.1875,
									pk_ams_class_level = 1000003  => 0.1720430108,
									pk_ams_class_level = 1000004  => 0.1560693642,
																	 0.1428571429);

	pk_ams_income_level_code_mm_b1 := map(pk_ams_income_level_code = -1 => 0.1971319402,
										  pk_ams_income_level_code = 0  => 0.2283105023,
										  pk_ams_income_level_code = 1  => 0.2479108635,
										  pk_ams_income_level_code = 2  => 0.244825547,
										  pk_ams_income_level_code = 3  => 0.2187958884,
										  pk_ams_income_level_code = 4  => 0.1894329897,
										  pk_ams_income_level_code = 5  => 0.2164009112,
																		   0.2122302158);

	pk_college_tier_mm_b1 := map((integer)pk_college_tier = -1 => 0.203415891,
								 (integer)pk_college_tier = 1  => 0,
								 (integer)pk_college_tier = 2  => 0.1176470588,
								 (integer)pk_college_tier = 3  => 0.182278481,
								 (integer)pk_college_tier = 4  => 0.1764705882,
								 (integer)pk_college_tier = 5  => 0.2296450939,
																  0.2158469945);

	pk_yr_in_dob2_mm_b1 := map(pk_yr_in_dob2 = 19 => 0.2666666667,
							   pk_yr_in_dob2 = 20 => 0.3157894737,
							   pk_yr_in_dob2 = 21 => 0.4666666667,
							   pk_yr_in_dob2 = 22 => 0.3518518519,
							   pk_yr_in_dob2 = 23 => 0.3289473684,
							   pk_yr_in_dob2 = 25 => 0.2956298201,
							   pk_yr_in_dob2 = 29 => 0.2821901324,
							   pk_yr_in_dob2 = 35 => 0.2222471406,
							   pk_yr_in_dob2 = 38 => 0.2108350587,
							   pk_yr_in_dob2 = 41 => 0.2071656616,
							   pk_yr_in_dob2 = 42 => 0.2055084746,
							   pk_yr_in_dob2 = 43 => 0.2023681378,
							   pk_yr_in_dob2 = 44 => 0.1870350691,
							   pk_yr_in_dob2 = 45 => 0.1870669746,
							   pk_yr_in_dob2 = 47 => 0.1773341163,
							   pk_yr_in_dob2 = 49 => 0.1875,
							   pk_yr_in_dob2 = 57 => 0.1667062455,
							   pk_yr_in_dob2 = 61 => 0.1612903226,
													 0.1458699473);

	pk_ams_age_mm_b1 := map(pk_ams_age = -1 => 0.1964836521,
							pk_ams_age = 21 => 0.3300970874,
							pk_ams_age = 22 => 0.3863636364,
							pk_ams_age = 23 => 0.3541666667,
							pk_ams_age = 24 => 0.3194444444,
							pk_ams_age = 25 => 0.2957746479,
							pk_ams_age = 29 => 0.2816901408,
											   0.2265372168);

	pk_inferred_age_mm_b1 := map(pk_inferred_age = -1 => 0.3076923077,
								 pk_inferred_age = 18 => 0.3333333333,
								 pk_inferred_age = 19 => 0.4054054054,
								 pk_inferred_age = 20 => 0.296875,
								 pk_inferred_age = 21 => 0.3301886792,
								 pk_inferred_age = 22 => 0.3741007194,
								 pk_inferred_age = 24 => 0.3163265306,
								 pk_inferred_age = 34 => 0.2380569406,
								 pk_inferred_age = 37 => 0.2127806563,
								 pk_inferred_age = 41 => 0.2055084746,
								 pk_inferred_age = 42 => 0.2019543974,
								 pk_inferred_age = 43 => 0.1873638344,
								 pk_inferred_age = 44 => 0.1845102506,
								 pk_inferred_age = 46 => 0.1804733728,
								 pk_inferred_age = 48 => 0.1886287625,
								 pk_inferred_age = 52 => 0.1639935846,
								 pk_inferred_age = 56 => 0.1675579323,
								 pk_inferred_age = 61 => 0.1570680628,
														 0.1489361702);

	pk_yr_reported_dob2_mm_b1 := map(pk_yr_reported_dob2 = -1 => 0.2759776536,
									 pk_yr_reported_dob2 = 19 => 0.5,
									 pk_yr_reported_dob2 = 21 => 0.5,
									 pk_yr_reported_dob2 = 22 => 0.30,
									 pk_yr_reported_dob2 = 23 => 0.30,
									 pk_yr_reported_dob2 = 32 => 0.2510433387,
									 pk_yr_reported_dob2 = 35 => 0.2150862069,
									 pk_yr_reported_dob2 = 39 => 0.2093147752,
									 pk_yr_reported_dob2 = 42 => 0.2047706422,
									 pk_yr_reported_dob2 = 43 => 0.2041942605,
									 pk_yr_reported_dob2 = 44 => 0.1900108578,
									 pk_yr_reported_dob2 = 45 => 0.1829988194,
									 pk_yr_reported_dob2 = 46 => 0.1932084309,
									 pk_yr_reported_dob2 = 49 => 0.1818969251,
									 pk_yr_reported_dob2 = 57 => 0.1653031761,
									 pk_yr_reported_dob2 = 61 => 0.1583184258,
																 0.1489547038);

	pk_avm_hit_level_mm_b1 := map(pk_avm_hit_level = -1 => 0.2336448598,
								  pk_avm_hit_level = 0  => 0.211774744,
								  pk_avm_hit_level = 1  => 0.2017028178,
														   0.1848090983);

	pk_add2_avm_auto_diff3_lvl_mm_b1 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.2047795879,
											pk_add2_avm_auto_diff3_lvl = -1 => 0.1994342291,
																			   0.1989608415);

	pk2_add1_avm_sp_mm_b1 := map(pk2_add1_avm_sp = 0 => 0.2162940379,
								 pk2_add1_avm_sp = 1 => 0.1870867367,
								 pk2_add1_avm_sp = 2 => 0.1798846431,
														0.15625);

	pk2_add1_avm_as_mm_b1 := map(pk2_add1_avm_as = 0 => 0.2127244603,
								 pk2_add1_avm_as = 1 => 0.197824116,
								 pk2_add1_avm_as = 2 => 0.1826745475,
														0.1379310345);

	pk2_add1_avm_auto2_mm_b1 := map(pk2_add1_avm_auto2 = 0 => 0.227027027,
									pk2_add1_avm_auto2 = 1 => 0.2049910873,
									pk2_add1_avm_auto2 = 2 => 0.24291939,
									pk2_add1_avm_auto2 = 3 => 0.2407002188,
									pk2_add1_avm_auto2 = 4 => 0.2151480755,
									pk2_add1_avm_auto2 = 5 => 0.2100733185,
									pk2_add1_avm_auto2 = 6 => 0.1785859407,
															  0.2006802721);

	pk2_add1_avm_auto3_mm_b1 := map(pk2_add1_avm_auto3 = 0 => 0.2268041237,
									pk2_add1_avm_auto3 = 1 => 0.2396640827,
									pk2_add1_avm_auto3 = 2 => 0.2348993289,
									pk2_add1_avm_auto3 = 3 => 0.2154412942,
									pk2_add1_avm_auto3 = 4 => 0.19054242,
									pk2_add1_avm_auto3 = 5 => 0.1697312588,
									pk2_add1_avm_auto3 = 6 => 0.1749106897,
															  0.2119205298);

	pk2_add1_avm_med_mm_b1 := map(pk2_add1_avm_med = 0 => 0.2405063291,
								  pk2_add1_avm_med = 1 => 0.2535575679,
								  pk2_add1_avm_med = 2 => 0.242740134,
								  pk2_add1_avm_med = 3 => 0.2470355731,
								  pk2_add1_avm_med = 4 => 0.2113946326,
								  pk2_add1_avm_med = 5 => 0.1853661848,
								  pk2_add1_avm_med = 6 => 0.1894736842,
														  0.2162041182);

	pk2_add1_avm_to_med_ratio_mm_b1 := map(pk2_add1_avm_to_med_ratio = 0 => 0.2137110878,
										   pk2_add1_avm_to_med_ratio = 1 => 0.1916808562,
										   pk2_add1_avm_to_med_ratio = 2 => 0.1990719258,
										   pk2_add1_avm_to_med_ratio = 3 => 0.1947063089,
										   pk2_add1_avm_to_med_ratio = 4 => 0.1940298507,
																			0.2060702875);

	pk2_add2_avm_hed_mm_b1 := map(pk2_add2_avm_hed = 0 => 0.304,
								  pk2_add2_avm_hed = 1 => 0.2450199203,
								  pk2_add2_avm_hed = 2 => 0.1913043478,
								  pk2_add2_avm_hed = 3 => 0.2026050003,
								  pk2_add2_avm_hed = 4 => 0.2094594595,
								  pk2_add2_avm_hed = 5 => 0.1896045198,
														  0.2215189873);

	pk2_add2_avm_auto3_mm_b1 := map(pk2_add2_avm_auto3 = 0 => 0.2524590164,
									pk2_add2_avm_auto3 = 1 => 0.2378716745,
									pk2_add2_avm_auto3 = 2 => 0.2051462622,
									pk2_add2_avm_auto3 = 3 => 0.1868489583,
															  0.2027027027);

	pk_dist_a1toa2_mm_b1 := map(pk_dist_a1toa2_2 = 0 => 0.2021493674,
								pk_dist_a1toa2_2 = 1 => 0.1997969543,
								pk_dist_a1toa2_2 = 2 => 0.2047619048,
								pk_dist_a1toa2_2 = 3 => 0.2031975245,
														0.2370766488);

	pk_dist_a1toa3_mm_b1 := map(pk_dist_a1toa3_2 = 0 => 0.2058873287,
								pk_dist_a1toa3_2 = 1 => 0.1881498921,
								pk_dist_a1toa3_2 = 2 => 0.2043279687,
								pk_dist_a1toa3_2 = 3 => 0.2015717092,
								pk_dist_a1toa3_2 = 4 => 0.2050861362,
								pk_dist_a1toa3_2 = 5 => 0.1890034364,
														0.2363886975);

	pk_out_st_division_lvl_mm_b1 := map(pk_out_st_division_lvl = -1 => 0.1111111111,
										pk_out_st_division_lvl = 0  => 0.18935236,
										pk_out_st_division_lvl = 1  => 0.1859923826,
										pk_out_st_division_lvl = 2  => 0.1980255517,
										pk_out_st_division_lvl = 3  => 0.2507305669,
										pk_out_st_division_lvl = 4  => 0.2068234796,
										pk_out_st_division_lvl = 5  => 0.174094261,
										pk_out_st_division_lvl = 6  => 0.1746784022,
										pk_out_st_division_lvl = 7  => 0.2484848485,
																	   0.1573426573);

	pk_impulse_count_mm_b1 := map(pk_impulse_count_2 = 0 => 0.1738873184,
								  pk_impulse_count_2 = 1 => 0.2358784798,
															0.2737927801);

	pk_attr_num_nonderogs90_b_mm_b1 := map(pk_attr_num_nonderogs90_b = 0  => 0.3773584906,
										   pk_attr_num_nonderogs90_b = 1  => 0.2718301435,
										   pk_attr_num_nonderogs90_b = 2  => 0.2321501428,
										   pk_attr_num_nonderogs90_b = 3  => 0.2,
										   pk_attr_num_nonderogs90_b = 4  => 0.1157894737,
										   pk_attr_num_nonderogs90_b = 10 => 0.2631578947,
										   pk_attr_num_nonderogs90_b = 11 => 0.2074848065,
										   pk_attr_num_nonderogs90_b = 12 => 0.1727721486,
										   pk_attr_num_nonderogs90_b = 13 => 0.1501740428,
																			 0.1553784861);

	pk_ssns_per_addr2_mm_b1 := map(pk_ssns_per_addr2 = -101 => 0.2185314685,
								   pk_ssns_per_addr2 = -2   => 0.2605042017,
								   pk_ssns_per_addr2 = -1   => 0.2130177515,
								   pk_ssns_per_addr2 = 0    => 0.1365853659,
								   pk_ssns_per_addr2 = 1    => 0.1927525058,
								   pk_ssns_per_addr2 = 2    => 0.1769276748,
								   pk_ssns_per_addr2 = 3    => 0.1858049625,
								   pk_ssns_per_addr2 = 4    => 0.206185567,
								   pk_ssns_per_addr2 = 5    => 0.1745513866,
								   pk_ssns_per_addr2 = 6    => 0.1910430839,
								   pk_ssns_per_addr2 = 7    => 0.2013422819,
								   pk_ssns_per_addr2 = 8    => 0.1978319783,
								   pk_ssns_per_addr2 = 9    => 0.2120592744,
								   pk_ssns_per_addr2 = 10   => 0.2271234162,
								   pk_ssns_per_addr2 = 11   => 0.2352941176,
								   pk_ssns_per_addr2 = 12   => 0.2112171838,
								   pk_ssns_per_addr2 = 100  => 0.152173913,
								   pk_ssns_per_addr2 = 101  => 0.2456140351,
								   pk_ssns_per_addr2 = 102  => 0.2342519685,
															   0.203125);

	pk_yr_add2_assess_val_yr2_mm_b1 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.206343082,
										   pk_yr_add2_assessed_value_year2 = 0  => 0.1184573003,
										   pk_yr_add2_assessed_value_year2 = 1  => 0.2029327317,
																				   0.1964468739);

	pk_estimated_income_mm_b2 := map(pk_estimated_income = -1 => 0.3846153846,
									 pk_estimated_income = 0  => 0.3977900552,
									 pk_estimated_income = 1  => 0.344895288,
									 pk_estimated_income = 2  => 0.3203568532,
									 pk_estimated_income = 3  => 0.3169934641,
									 pk_estimated_income = 4  => 0.3189282627,
									 pk_estimated_income = 5  => 0.30656,
									 pk_estimated_income = 6  => 0.3107614498,
									 pk_estimated_income = 7  => 0.3035435122,
									 pk_estimated_income = 8  => 0.3083311705,
									 pk_estimated_income = 9  => 0.2898842476,
									 pk_estimated_income = 10 => 0.3033162578,
									 pk_estimated_income = 11 => 0.295281583,
									 pk_estimated_income = 12 => 0.2795552087,
									 pk_estimated_income = 13 => 0.2902719665,
									 pk_estimated_income = 14 => 0.2591605596,
									 pk_estimated_income = 15 => 0.2494117647,
									 pk_estimated_income = 16 => 0.2597938144,
									 pk_estimated_income = 17 => 0.251541307,
									 pk_estimated_income = 18 => 0.2473763118,
									 pk_estimated_income = 19 => 0.2414860681,
									 pk_estimated_income = 20 => 0.2291831879,
									 pk_estimated_income = 21 => 0.2380952381,
																 0.2777777778);

	pk_yr_adl_pr_first_seen2_mm_b2 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.2994600551,
										  pk_yr_adl_pr_first_seen2 = 0  => 0.2842105263,
										  pk_yr_adl_pr_first_seen2 = 1  => 0.2350617284,
										  pk_yr_adl_pr_first_seen2 = 2  => 0.2142857143,
										  pk_yr_adl_pr_first_seen2 = 3  => 0.2008639309,
										  pk_yr_adl_pr_first_seen2 = 4  => 0.201986755,
										  pk_yr_adl_pr_first_seen2 = 5  => 0.1854103343,
										  pk_yr_adl_pr_first_seen2 = 6  => 0.3,
																		   0.3333333333);

	pk_yr_adl_w_first_seen2_mm_b2 := map(pk_yr_adl_w_first_seen2 = -1 => 0.2890995261,
										 pk_yr_adl_w_first_seen2 = 0  => 0.2132352941,
										 pk_yr_adl_w_first_seen2 = 1  => 0.2192622951,
																		 0.320754717);

	pk_yr_adl_w_last_seen2_mm_b2 := map(pk_yr_adl_w_last_seen2 = -1 => 0.2890995261,
										pk_yr_adl_w_last_seen2 = 0  => 0.2153846154,
										pk_yr_adl_w_last_seen2 = 1  => 0.1764705882,
																	   0.2352941176);

	pk_pr_count_mm_b2 := map(pk_pr_count = -1 => 0.2995504971,
							 pk_pr_count = 0  => 0.2318229715,
							 pk_pr_count = 1  => 0.2088694853,
												 0.0833333333);

	pk_addrs_sourced_lvl_mm_b2 := map(pk_addrs_sourced_lvl = 0 => 0.294752289,
									  pk_addrs_sourced_lvl = 1 => 0.2099069513,
									  pk_addrs_sourced_lvl = 2 => 0.2083333333,
																  0.2100840336);

	pk_add1_own_level_mm_b2 := map(pk_add1_own_level = -1 => 0.2881687104,
															 0.2883293365);

	pk_naprop_level2_mm_b2 := map(pk_naprop_level2 = -2 => 0.3140142518,
								  pk_naprop_level2 = -1 => 0.2975480021,
								  pk_naprop_level2 = 0  => 0.2950175439,
								  pk_naprop_level2 = 1  => 0.2866161616,
								  pk_naprop_level2 = 2  => 0.2850177953,
								  pk_naprop_level2 = 3  => 0.2464454976,
								  pk_naprop_level2 = 4  => 0.2284196547,
														   0.1896373057);

	pk_yr_add1_built_date2_mm_b2 := map(pk_yr_add1_built_date2 = -4 => 0.2842614302,
										pk_yr_add1_built_date2 = -3 => 0.2222222222,
										pk_yr_add1_built_date2 = -2 => 0.2691823899,
										pk_yr_add1_built_date2 = -1 => 0.3068720379,
										pk_yr_add1_built_date2 = 0  => 0.2857878476,
										pk_yr_add1_built_date2 = 1  => 0.2979338843,
										pk_yr_add1_built_date2 = 2  => 0.300029129,
																	   0.3005249344);

	pk_add1_purchase_amount2_mm_b2 := map(pk_add1_purchase_amount2 = -1 => 0.2879408924,
										  pk_add1_purchase_amount2 = 0  => 0.3046319152,
																		   0.2744360902);

	pk_add1_mortgage_amount2_mm_b2 := map(pk_add1_mortgage_amount2 = -1 => 0.2858768241,
										  pk_add1_mortgage_amount2 = 0  => 0.3194057567,
										  pk_add1_mortgage_amount2 = 1  => 0.2944273804,
																		   0.2788048553);

	pk_yr_add1_mortgage_date2_mm_b2 := map(pk_yr_add1_mortgage_date2 = -1 => 0.2872352604,
										   pk_yr_add1_mortgage_date2 = 0  => 0.3096754625,
										   pk_yr_add1_mortgage_date2 = 1  => 0.3000560852,
																			 0.2756427979);

	pk_add1_assessed_amount2_mm_b2 := map(pk_add1_assessed_amount2 = -1 => 0.2834672459,
										  pk_add1_assessed_amount2 = 0  => 0.3372228705,
										  pk_add1_assessed_amount2 = 1  => 0.3311546841,
										  pk_add1_assessed_amount2 = 2  => 0.3092926491,
										  pk_add1_assessed_amount2 = 3  => 0.2950466619,
										  pk_add1_assessed_amount2 = 4  => 0.2931453573,
										  pk_add1_assessed_amount2 = 5  => 0.2992518703,
																		   0.2850502045);

	pk_yr_add1_date_first_seen2_mm_b2 := map(pk_yr_add1_date_first_seen2 = -1 => 0.3559409977,
											 pk_yr_add1_date_first_seen2 = 0  => 0.2959387483,
											 pk_yr_add1_date_first_seen2 = 1  => 0.2691858769,
											 pk_yr_add1_date_first_seen2 = 2  => 0.2605252188,
											 pk_yr_add1_date_first_seen2 = 3  => 0.2493261456,
											 pk_yr_add1_date_first_seen2 = 4  => 0.2324742268,
											 pk_yr_add1_date_first_seen2 = 5  => 0.2525075226,
											 pk_yr_add1_date_first_seen2 = 6  => 0.2397067118,
											 pk_yr_add1_date_first_seen2 = 7  => 0.2256977863,
											 pk_yr_add1_date_first_seen2 = 8  => 0.2171113155,
											 pk_yr_add1_date_first_seen2 = 9  => 0.2122807018,
																				 0.1641791045);

	pk_add1_building_area2_mm_b2 := map(pk_add1_building_area2 = -99 => 0.2841262783,
										pk_add1_building_area2 = -4  => 0.3281143635,
										pk_add1_building_area2 = -3  => 0.3234732824,
										pk_add1_building_area2 = -2  => 0.2898893408,
										pk_add1_building_area2 = -1  => 0.2813971743,
										pk_add1_building_area2 = 0   => 0.3065049614,
										pk_add1_building_area2 = 1   => 0.3076923077,
										pk_add1_building_area2 = 2   => 0.3053892216,
										pk_add1_building_area2 = 3   => 0.3016393443,
																		0.3008130081);

	pk_add1_no_of_rooms_mm_b2 := map(pk_add1_no_of_rooms = -1 => 0.2886832901,
									 pk_add1_no_of_rooms = 0  => 0.3139534884,
									 pk_add1_no_of_rooms = 1  => 0.2760041195,
									 pk_add1_no_of_rooms = 2  => 0.2903811252,
									 pk_add1_no_of_rooms = 3  => 0.301805675,
																 0.2669256382);

	pk_add1_garage_type_risk_lvl_mm_b2 := map(pk_add1_garage_type_risk_level = 0 => 0.2773845635,
											  pk_add1_garage_type_risk_level = 1 => 0.266869469,
											  pk_add1_garage_type_risk_level = 2 => 0.3072963972,
																					0.2893894459);

	pk_add1_style_code_level_mm_b2 := map(pk_add1_style_code_level = 0 => 0.2883362229,
										  pk_add1_style_code_level = 1 => 0.2882882883,
										  pk_add1_style_code_level = 2 => 0.2662440571,
										  pk_add1_style_code_level = 3 => 0.2878787879,
																		  0.2996031746);

	pk_property_owned_total_mm_b2 := if(pk_property_owned_total = -1, 0.2882838158, NULL);

	pk_prop1_prev_purchase_price2_mm_b2 := map(pk_prop1_prev_purchase_price2 = 0 => 0.2900422734,
											   pk_prop1_prev_purchase_price2 = 1 => 0.2633053221,
																					0.2002176279);

	pk_add2_building_area2_mm_b2 := map(pk_add2_building_area2 = -4 => 0.2876433901,
										pk_add2_building_area2 = -3 => 0.3155373032,
										pk_add2_building_area2 = -2 => 0.2941757157,
										pk_add2_building_area2 = -1 => 0.2849129594,
										pk_add2_building_area2 = 0  => 0.282601626,
										pk_add2_building_area2 = 1  => 0.3108108108,
																	   0.3448275862);

	pk_add2_no_of_buildings_mm_b2 := map(pk_add2_no_of_buildings = -1 => 0.2879668781,
										 pk_add2_no_of_buildings = 0  => 0.2844660194,
										 pk_add2_no_of_buildings = 1  => 0.303514377,
																		 0.4683544304);

	pk_add2_no_of_rooms_mm_b2 := map(pk_add2_no_of_rooms = -1 => 0.2893163446,
									 pk_add2_no_of_rooms = 0  => 0.3643724696,
									 pk_add2_no_of_rooms = 1  => 0.2804383726,
																 0.2726146221);

	pk_add2_style_code_level_mm_b2 := map(pk_add2_style_code_level = 0 => 0.2890990523,
										  pk_add2_style_code_level = 1 => 0.2327272727,
										  pk_add2_style_code_level = 2 => 0.2968515742,
										  pk_add2_style_code_level = 3 => 0.2299465241,
																		  0.2792706334);

	pk_add2_purchase_amount2_mm_b2 := map(pk_add2_purchase_amount2 = -1 => 0.2921588052,
										  pk_add2_purchase_amount2 = 0  => 0.3020695729,
																		   0.2628530907);

	pk_add2_mortgage_risk_mm_b2 := map(pk_add2_mortgage_risk = -1 => 0.3417721519,
									   pk_add2_mortgage_risk = 0  => 0.2621564482,
									   pk_add2_mortgage_risk = 1  => 0.2892784607,
									   pk_add2_mortgage_risk = 2  => 0.2790339157,
																	 0.290292615);

	pk_add2_assessed_amount2_mm_b2 := map(pk_add2_assessed_amount2 = -1 => 0.2862191698,
										  pk_add2_assessed_amount2 = 0  => 0.3286666667,
										  pk_add2_assessed_amount2 = 1  => 0.2841698842,
										  pk_add2_assessed_amount2 = 2  => 0.2886029412,
										  pk_add2_assessed_amount2 = 3  => 0.2837493632,
																		   0.2825854701);

	pk_yr_add2_date_first_seen2_mm_b2 := map(pk_yr_add2_date_first_seen2 = -1 => 0.348,
											 pk_yr_add2_date_first_seen2 = 0  => 0.3328686925,
											 pk_yr_add2_date_first_seen2 = 1  => 0.306245614,
											 pk_yr_add2_date_first_seen2 = 2  => 0.3057783598,
											 pk_yr_add2_date_first_seen2 = 3  => 0.2973111834,
											 pk_yr_add2_date_first_seen2 = 4  => 0.2877866168,
											 pk_yr_add2_date_first_seen2 = 5  => 0.2696594427,
											 pk_yr_add2_date_first_seen2 = 6  => 0.2794583693,
											 pk_yr_add2_date_first_seen2 = 7  => 0.2522875817,
											 pk_yr_add2_date_first_seen2 = 8  => 0.258116304,
											 pk_yr_add2_date_first_seen2 = 9  => 0.2325678497,
											 pk_yr_add2_date_first_seen2 = 10 => 0.2181688126,
																				 0.2148962149);

	pk_yr_add2_date_last_seen2_mm_b2 := map(pk_yr_add2_date_last_seen2 = -1 => 0.348,
											pk_yr_add2_date_last_seen2 = 0  => 0.3061059343,
											pk_yr_add2_date_last_seen2 = 1  => 0.2343143965,
											pk_yr_add2_date_last_seen2 = 2  => 0.2351409978,
											pk_yr_add2_date_last_seen2 = 3  => 0.2073563218,
											pk_yr_add2_date_last_seen2 = 4  => 0.174386921,
											pk_yr_add2_date_last_seen2 = 5  => 0.1961115807,
																			   0.1840942563);

	pk_add3_purchase_amount2_mm_b2 := map(pk_add3_purchase_amount2 = -1 => 0.292047871,
										  pk_add3_purchase_amount2 = 0  => 0.3042424242,
										  pk_add3_purchase_amount2 = 1  => 0.3089233754,
										  pk_add3_purchase_amount2 = 2  => 0.3108003108,
										  pk_add3_purchase_amount2 = 3  => 0.2629947109,
																		   0.2450505939);

	pk_add3_mortgage_risk_mm_b2 := map(pk_add3_mortgage_risk = -1 => 0.4255319149,
									   pk_add3_mortgage_risk = 0  => 0.2618657938,
									   pk_add3_mortgage_risk = 1  => 0.2323943662,
									   pk_add3_mortgage_risk = 2  => 0.2888090458,
									   pk_add3_mortgage_risk = 3  => 0.2737160121,
									   pk_add3_mortgage_risk = 4  => 0.3029715762,
																	 0.3115124153);

	pk_add3_assessed_amount2_mm_b2 := map(pk_add3_assessed_amount2 = -1 => 0.2882955377,
										  pk_add3_assessed_amount2 = 0  => 0.3154314357,
										  pk_add3_assessed_amount2 = 1  => 0.3225296443,
										  pk_add3_assessed_amount2 = 2  => 0.289193825,
																		   0.2604237867);

	pk_yr_add3_date_first_seen2_mm_b2 := map(pk_yr_add3_date_first_seen2 = -1 => 0.3563218391,
											 pk_yr_add3_date_first_seen2 = 0  => 0.3535031847,
											 pk_yr_add3_date_first_seen2 = 1  => 0.3275922671,
											 pk_yr_add3_date_first_seen2 = 2  => 0.3106657122,
											 pk_yr_add3_date_first_seen2 = 3  => 0.3018706024,
											 pk_yr_add3_date_first_seen2 = 4  => 0.2950819672,
											 pk_yr_add3_date_first_seen2 = 5  => 0.2761292761,
											 pk_yr_add3_date_first_seen2 = 6  => 0.2622282609,
											 pk_yr_add3_date_first_seen2 = 7  => 0.2373210386,
											 pk_yr_add3_date_first_seen2 = 8  => 0.223487824,
																				 0.2139376218);

	pk_yr_add3_date_last_seen2_mm_b2 := map(pk_yr_add3_date_last_seen2 = -1 => 0.3563218391,
											pk_yr_add3_date_last_seen2 = 0  => 0.3283340817,
											pk_yr_add3_date_last_seen2 = 1  => 0.2786762343,
											pk_yr_add3_date_last_seen2 = 2  => 0.2658385093,
											pk_yr_add3_date_last_seen2 = 3  => 0.2475106686,
											pk_yr_add3_date_last_seen2 = 4  => 0.2439571393,
											pk_yr_add3_date_last_seen2 = 5  => 0.2081128748,
											pk_yr_add3_date_last_seen2 = 6  => 0.1948130277,
											pk_yr_add3_date_last_seen2 = 7  => 0.2088495575,
																			   0.1753063148);

	pk_bk_level_mm_b2 := map(pk_bk_level_2 = 0 => 0.3197493981,
							 pk_bk_level_2 = 1 => 0.2129935391,
												  0.2791929382);

	pk_eviction_level_mm_b2 := map(pk_eviction_level = 0 => 0.2660060787,
								   pk_eviction_level = 1 => 0.3439476554,
								   pk_eviction_level = 2 => 0.3592177164,
								   pk_eviction_level = 3 => 0.3763089005,
								   pk_eviction_level = 4 => 0.4059293044,
								   pk_eviction_level = 5 => 0.3893280632,
								   pk_eviction_level = 6 => 0.3769751693,
															0.4353182752);

	pk_lien_type_level_mm_b2 := map(pk_lien_type_level = 0 => 0.2684991927,
									pk_lien_type_level = 1 => 0.2362637363,
									pk_lien_type_level = 2 => 0.2087042532,
									pk_lien_type_level = 3 => 0.2684629345,
									pk_lien_type_level = 4 => 0.3087211831,
															  0.3627614068);

	pk_yr_liens_last_unrel_date3_mm_b2 := map((integer)pk_yr_liens_last_unrel_date3_2 = -1 => 0.2822590546,
											  pk_yr_liens_last_unrel_date3_2 = -0.5        => 0.2438756454,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 0  => 0.3311932162,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 1  => 0.3160561185,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 2  => 0.3042569862,
											  (integer)pk_yr_liens_last_unrel_date3_2 = 3  => 0.2889823381,
																							  0.2726558408);

	pk_yr_ln_unrel_lt_f_sn2_mm_b2 := map(pk_yr_liens_unrel_lt_first_sn2 = -1 => 0.279364291,
										 pk_yr_liens_unrel_lt_first_sn2 = 0  => 0.4268719384,
																				0.3772432226);

	pk_yr_ln_unrel_ot_f_sn2_mm_b2 := map(pk_yr_liens_unrel_ot_first_sn2 = -1 => 0.2912435254,
										 pk_yr_liens_unrel_ot_first_sn2 = 0  => 0.2565349544,
										 pk_yr_liens_unrel_ot_first_sn2 = 1  => 0.2405345212,
																				0.2250316056);

	pk_yr_attr_dt_l_eviction2_mm_b2 := map(pk_yr_attr_date_last_eviction2 = -1 => 0.2659648082,
										   pk_yr_attr_date_last_eviction2 = 0  => 0.3952076677,
										   pk_yr_attr_date_last_eviction2 = 1  => 0.3855992421,
										   pk_yr_attr_date_last_eviction2 = 2  => 0.3462800875,
										   pk_yr_attr_date_last_eviction2 = 3  => 0.3850129199,
										   pk_yr_attr_date_last_eviction2 = 4  => 0.3188291139,
																				  0.322150962);

	pk_crime_level_mm_b2 := map(pk_crime_level = 0 => 0.278818712,
								pk_crime_level = 1 => 0.3540186916,
													  0.4981384959);

	pk_attr_total_number_derogs_mm_b2 := map(pk_attr_total_number_derogs_5 = 0 => 0.2851508702,
											 pk_attr_total_number_derogs_5 = 1 => 0.258767167,
											 pk_attr_total_number_derogs_5 = 2 => 0.2840590316,
																				  0.3318718112);

	pk_yr_rc_ssnhighissue2_mm_b2 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.2765957447,
										pk_yr_rc_ssnhighissue2 = 0  => 0.3333333333,
										pk_yr_rc_ssnhighissue2 = 1  => 0.2747252747,
										pk_yr_rc_ssnhighissue2 = 2  => 0.2959830867,
										pk_yr_rc_ssnhighissue2 = 3  => 0.35625,
										pk_yr_rc_ssnhighissue2 = 4  => 0.3292841649,
										pk_yr_rc_ssnhighissue2 = 5  => 0.3092648408,
										pk_yr_rc_ssnhighissue2 = 6  => 0.317531862,
										pk_yr_rc_ssnhighissue2 = 7  => 0.3282595634,
										pk_yr_rc_ssnhighissue2 = 8  => 0.3087967644,
										pk_yr_rc_ssnhighissue2 = 9  => 0.2972623967,
										pk_yr_rc_ssnhighissue2 = 10 => 0.2688921015,
										pk_yr_rc_ssnhighissue2 = 11 => 0.2367320682,
										pk_yr_rc_ssnhighissue2 = 12 => 0.216168717,
										pk_yr_rc_ssnhighissue2 = 13 => 0.1784596118,
																	   0.1827622015);

	pk_pl_sourced_level_mm_b2 := map(pk_pl_sourced_level = 0 => 0.2903638431,
									 pk_pl_sourced_level = 1 => 0.3,
									 pk_pl_sourced_level = 2 => 0.256281407,
																0.22);

	pk_prof_lic_cat_mm_b2 := map(pk_prof_lic_cat = -1 => 0.2902552995,
								 pk_prof_lic_cat = 0  => 0.2922077922,
								 pk_prof_lic_cat = 1  => 0.2202643172,
								 pk_prof_lic_cat = 2  => 0.1887477314,
														 0.2444444444);

	pk_add1_lres_mm_b2 := map(pk_add1_lres = -2 => 0.2,
							  pk_add1_lres = -1 => 0.356108079,
							  pk_add1_lres = 0  => 0.3133179369,
							  pk_add1_lres = 1  => 0.3318700615,
							  pk_add1_lres = 2  => 0.2810858144,
							  pk_add1_lres = 3  => 0.2905759162,
							  pk_add1_lres = 4  => 0.2801230081,
							  pk_add1_lres = 5  => 0.2721649485,
							  pk_add1_lres = 6  => 0.2609227543,
							  pk_add1_lres = 7  => 0.246228876,
							  pk_add1_lres = 8  => 0.2502327747,
							  pk_add1_lres = 9  => 0.2466124661,
							  pk_add1_lres = 10 => 0.216840052,
												   0.2371134021);

	pk_add3_lres_mm_b2 := map(pk_add3_lres = -2 => 0.3512778684,
							  pk_add3_lres = -1 => 0.2773007619,
							  pk_add3_lres = 0  => 0.2967949733,
							  pk_add3_lres = 1  => 0.2927816212,
							  pk_add3_lres = 2  => 0.280668439,
							  pk_add3_lres = 3  => 0.2788141239,
							  pk_add3_lres = 4  => 0.2688652879,
							  pk_add3_lres = 5  => 0.2544578313,
												   0.2580645161);

	pk_addrs_5yr_mm_b2 := map(pk_addrs_5yr = 0 => 0.2408404237,
							  pk_addrs_5yr = 1 => 0.2692032229,
							  pk_addrs_5yr = 2 => 0.3065317499,
							  pk_addrs_5yr = 3 => 0.3304985826,
												  0.3702031603);

	pk_addrs_10yr_mm_b2 := map(pk_addrs_10yr = 0 => 0.2419239052,
							   pk_addrs_10yr = 1 => 0.255,
							   pk_addrs_10yr = 2 => 0.2779071156,
							   pk_addrs_10yr = 3 => 0.3138053999,
													0.3463850249);

	pk_addrs_15yr_mm_b2 := map(pk_addrs_15yr = 0 => 0.3197556008,
							   pk_addrs_15yr = 1 => 0.2809257781,
							   pk_addrs_15yr = 2 => 0.3062446536,
													0.3906779661);

	pk_add_lres_month_avg2_mm_b2 := map(pk_add_lres_month_avg2 = -1 => 0.3793103448,
										pk_add_lres_month_avg2 = 0  => 0.4342105263,
										pk_add_lres_month_avg2 = 1  => 0.3608183509,
										pk_add_lres_month_avg2 = 2  => 0.3384879725,
										pk_add_lres_month_avg2 = 3  => 0.3301354402,
										pk_add_lres_month_avg2 = 4  => 0.3246205734,
										pk_add_lres_month_avg2 = 5  => 0.3175977654,
										pk_add_lres_month_avg2 = 6  => 0.3240589198,
										pk_add_lres_month_avg2 = 7  => 0.3137362637,
										pk_add_lres_month_avg2 = 8  => 0.3014681348,
										pk_add_lres_month_avg2 = 9  => 0.293477053,
										pk_add_lres_month_avg2 = 10 => 0.2678251981,
										pk_add_lres_month_avg2 = 11 => 0.2460502461,
										pk_add_lres_month_avg2 = 12 => 0.2313231323,
										pk_add_lres_month_avg2 = 13 => 0.2278873864,
										pk_add_lres_month_avg2 = 15 => 0.2228571429,
																	   0.1807580175);

	pk_nameperssn_count_mm_b2 := map(pk_nameperssn_count = 0 => 0.2863901169,
									 pk_nameperssn_count = 1 => 0.3116447199,
																0.3010752688);

	pk_ssns_per_adl_mm_b2 := map(pk_ssns_per_adl = -1 => 0.45,
								 pk_ssns_per_adl = 0  => 0.2758496565,
								 pk_ssns_per_adl = 1  => 0.2954970396,
								 pk_ssns_per_adl = 2  => 0.3121518987,
								 pk_ssns_per_adl = 3  => 0.3471208435,
														 0.4401709402);

	pk_addrs_per_adl_mm_b2 := map(pk_addrs_per_adl = -6 => 0.3265306122,
								  pk_addrs_per_adl = -5 => 0.3822284908,
								  pk_addrs_per_adl = -4 => 0.35375,
								  pk_addrs_per_adl = -3 => 0.3306540007,
								  pk_addrs_per_adl = -2 => 0.292437432,
								  pk_addrs_per_adl = -1 => 0.2931544235,
								  pk_addrs_per_adl = 0  => 0.2809291288,
								  pk_addrs_per_adl = 1  => 0.2775856105,
								  pk_addrs_per_adl = 2  => 0.2762609903,
														   0.2886561955);

	pk_phones_per_adl_mm_b2 := map(pk_phones_per_adl = -1 => 0.288756511,
								   pk_phones_per_adl = 0  => 0.2821266177,
								   pk_phones_per_adl = 1  => 0.2983524355,
															 0.3694029851);

	pk_adlperssn_count_mm_b2 := map(pk_adlperssn_count = -1 => 0.3055555556,
									pk_adlperssn_count = 0  => 0.2815991342,
									pk_adlperssn_count = 1  => 0.2941833717,
															   0.3093039773);

	pk_adls_per_addr_mm_b2 := map(pk_adls_per_addr = -102 => 0.2858334879,
								  pk_adls_per_addr = -101 => 0.2683823529,
								  pk_adls_per_addr = -2   => 0.3291323316,
								  pk_adls_per_addr = -1   => 0.2771929825,
								  pk_adls_per_addr = 0    => 0.2609819121,
								  pk_adls_per_addr = 1    => 0.2429042904,
								  pk_adls_per_addr = 2    => 0.2602956705,
								  pk_adls_per_addr = 3    => 0.2668004012,
								  pk_adls_per_addr = 4    => 0.2697247706,
								  pk_adls_per_addr = 5    => 0.2704199354,
								  pk_adls_per_addr = 6    => 0.2681091251,
								  pk_adls_per_addr = 7    => 0.2795061728,
								  pk_adls_per_addr = 8    => 0.3052122515,
								  pk_adls_per_addr = 9    => 0.3013777268,
								  pk_adls_per_addr = 10   => 0.3017322835,
								  pk_adls_per_addr = 11   => 0.2918418839,
								  pk_adls_per_addr = 12   => 0.3127860027,
								  pk_adls_per_addr = 13   => 0.3137920395,
								  pk_adls_per_addr = 100  => 0.2601351351,
								  pk_adls_per_addr = 101  => 0.2643678161,
															 0.2923863236);

	pk_adls_per_phone_mm_b2 := map(pk_adls_per_phone = -2 => 0.2896743638,
								   pk_adls_per_phone = -1 => 0.2799035102,
								   pk_adls_per_phone = 0  => 0.3032477341,
															 0.3161094225);

	pk_ssns_per_adl_c6_mm_b2 := map(pk_ssns_per_adl_c6 = 0 => 0.2742067232,
									pk_ssns_per_adl_c6 = 1 => 0.3073246806,
															  0.3930722892);

	pk_ssns_per_addr_c6_mm_b2 := map(pk_ssns_per_addr_c6 = 0   => 0.2679525223,
									 pk_ssns_per_addr_c6 = 1   => 0.3093295495,
									 pk_ssns_per_addr_c6 = 2   => 0.3189848221,
									 pk_ssns_per_addr_c6 = 3   => 0.3433133733,
									 pk_ssns_per_addr_c6 = 4   => 0.3173996176,
									 pk_ssns_per_addr_c6 = 5   => 0.4085365854,
									 pk_ssns_per_addr_c6 = 6   => 0.4454545455,
									 pk_ssns_per_addr_c6 = 100 => 0.2811473762,
									 pk_ssns_per_addr_c6 = 101 => 0.3077851539,
									 pk_ssns_per_addr_c6 = 102 => 0.3373287671,
									 pk_ssns_per_addr_c6 = 103 => 0.3881578947,
																  0.3709677419);

	pk_adls_per_phone_c6_mm_b2 := map(pk_adls_per_phone_c6 = 0 => 0.2897122302,
									  pk_adls_per_phone_c6 = 1 => 0.2863571282,
																  0.2427293065);

	pk_attr_addrs_last24_mm_b2 := map(pk_attr_addrs_last24 = 0 => 0.2518097485,
									  pk_attr_addrs_last24 = 1 => 0.2935306263,
									  pk_attr_addrs_last24 = 2 => 0.3102237383,
									  pk_attr_addrs_last24 = 3 => 0.3375616631,
									  pk_attr_addrs_last24 = 4 => 0.3634385201,
																  0.3866666667);

	pk_ams_class_level_mm_b2 := map(pk_ams_class_level = -1000001 => 0.2822280664,
									pk_ams_class_level = 0        => 0.4356435644,
									pk_ams_class_level = 1        => 0.496124031,
									pk_ams_class_level = 2        => 0.4277456647,
									pk_ams_class_level = 3        => 0.4558139535,
									pk_ams_class_level = 4        => 0.4214559387,
									pk_ams_class_level = 5        => 0.3471241171,
									pk_ams_class_level = 6        => 0.3236607143,
									pk_ams_class_level = 7        => 0.2990110529,
									pk_ams_class_level = 8        => 0.3063949403,
									pk_ams_class_level = 1000000  => 0.3280943026,
									pk_ams_class_level = 1000001  => 0.2896825397,
									pk_ams_class_level = 1000002  => 0.2434254889,
									pk_ams_class_level = 1000003  => 0.2088607595,
									pk_ams_class_level = 1000004  => 0.2218430034,
																	 0.1951219512);

	pk_ams_income_level_code_mm_b2 := map(pk_ams_income_level_code = -1 => 0.2822316986,
										  pk_ams_income_level_code = 0  => 0.3751617076,
										  pk_ams_income_level_code = 1  => 0.3440443213,
										  pk_ams_income_level_code = 2  => 0.3093894305,
										  pk_ams_income_level_code = 3  => 0.2988782051,
										  pk_ams_income_level_code = 4  => 0.2939914163,
										  pk_ams_income_level_code = 5  => 0.2640625,
																		   0.2875);

	pk_college_tier_mm_b2 := map((integer)pk_college_tier = -1 => 0.2904763854,
								 (integer)pk_college_tier = 1  => 0.2352941176,
								 (integer)pk_college_tier = 2  => 0.1565217391,
								 (integer)pk_college_tier = 3  => 0.2233009709,
								 (integer)pk_college_tier = 4  => 0.2479185939,
								 (integer)pk_college_tier = 5  => 0.2796116505,
																  0.2908242613);

	pk_yr_in_dob2_mm_b2 := map(pk_yr_in_dob2 = 19 => 0.487804878,
							   pk_yr_in_dob2 = 20 => 0.5222222222,
							   pk_yr_in_dob2 = 21 => 0.484029484,
							   pk_yr_in_dob2 = 22 => 0.4345549738,
							   pk_yr_in_dob2 = 23 => 0.4749642346,
							   pk_yr_in_dob2 = 25 => 0.3945945946,
							   pk_yr_in_dob2 = 29 => 0.3475554206,
							   pk_yr_in_dob2 = 35 => 0.3057731608,
							   pk_yr_in_dob2 = 38 => 0.2937062937,
							   pk_yr_in_dob2 = 41 => 0.2667065629,
							   pk_yr_in_dob2 = 42 => 0.2523809524,
							   pk_yr_in_dob2 = 43 => 0.2549965541,
							   pk_yr_in_dob2 = 44 => 0.2548746518,
							   pk_yr_in_dob2 = 45 => 0.2706389088,
							   pk_yr_in_dob2 = 47 => 0.2572347267,
							   pk_yr_in_dob2 = 49 => 0.2357798165,
							   pk_yr_in_dob2 = 57 => 0.2168392917,
							   pk_yr_in_dob2 = 61 => 0.1928281461,
													 0.1681350954);

	pk_ams_age_mm_b2 := map(pk_ams_age = -1 => 0.2806218767,
							pk_ams_age = 21 => 0.4493670886,
							pk_ams_age = 22 => 0.4124293785,
							pk_ams_age = 23 => 0.4285714286,
							pk_ams_age = 24 => 0.4111498258,
							pk_ams_age = 25 => 0.3475177305,
							pk_ams_age = 29 => 0.358778626,
											   0.3056359991);

	pk_inferred_age_mm_b2 := map(pk_inferred_age = -1 => 0.3863636364,
								 pk_inferred_age = 18 => 0.4772727273,
								 pk_inferred_age = 19 => 0.4918918919,
								 pk_inferred_age = 20 => 0.431547619,
								 pk_inferred_age = 21 => 0.4369114878,
								 pk_inferred_age = 22 => 0.4548148148,
								 pk_inferred_age = 24 => 0.4048008729,
								 pk_inferred_age = 34 => 0.3232140962,
								 pk_inferred_age = 37 => 0.2963473467,
								 pk_inferred_age = 41 => 0.2625542467,
								 pk_inferred_age = 42 => 0.2557651992,
								 pk_inferred_age = 43 => 0.2622253721,
								 pk_inferred_age = 44 => 0.2708333333,
								 pk_inferred_age = 46 => 0.2558139535,
								 pk_inferred_age = 48 => 0.2327425373,
								 pk_inferred_age = 52 => 0.2211784799,
								 pk_inferred_age = 56 => 0.203562341,
								 pk_inferred_age = 61 => 0.1900826446,
														 0.1793831169);

	pk_yr_reported_dob2_mm_b2 := map(pk_yr_reported_dob2 = -1 => 0.3899231678,
									 pk_yr_reported_dob2 = 19 => 0.5555555556,
									 pk_yr_reported_dob2 = 21 => 0.4683544304,
									 pk_yr_reported_dob2 = 22 => 0.4225352113,
									 pk_yr_reported_dob2 = 23 => 0.4672131148,
									 pk_yr_reported_dob2 = 32 => 0.3223690557,
									 pk_yr_reported_dob2 = 35 => 0.3044254104,
									 pk_yr_reported_dob2 = 39 => 0.2844686649,
									 pk_yr_reported_dob2 = 42 => 0.2636363636,
									 pk_yr_reported_dob2 = 43 => 0.2558970693,
									 pk_yr_reported_dob2 = 44 => 0.2621564482,
									 pk_yr_reported_dob2 = 45 => 0.2715231788,
									 pk_yr_reported_dob2 = 46 => 0.2694805195,
									 pk_yr_reported_dob2 = 49 => 0.2354529094,
									 pk_yr_reported_dob2 = 57 => 0.2140782505,
									 pk_yr_reported_dob2 = 61 => 0.1922811854,
																 0.1766323024);

	pk_avm_hit_level_mm_b2 := map(pk_avm_hit_level = -1 => 0.285165347,
								  pk_avm_hit_level = 0  => 0.2888410351,
								  pk_avm_hit_level = 1  => 0.2923719499,
														   0.2841641768);

	pk_add2_avm_auto_diff3_lvl_mm_b2 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.2899466261,
											pk_add2_avm_auto_diff3_lvl = -1 => 0.2458049887,
																			   0.2908468025);

	pk2_add1_avm_sp_mm_b2 := map(pk2_add1_avm_sp = 0 => 0.2914353427,
								 pk2_add1_avm_sp = 1 => 0.2801075269,
								 pk2_add1_avm_sp = 2 => 0.2698031685,
														0.2568229531);

	pk2_add1_avm_as_mm_b2 := map(pk2_add1_avm_as = 0 => 0.2909137481,
								 pk2_add1_avm_as = 1 => 0.2890574215,
								 pk2_add1_avm_as = 2 => 0.2638556835,
														0.2688679245);

	pk2_add1_avm_auto2_mm_b2 := map(pk2_add1_avm_auto2 = 0 => 0.356,
									pk2_add1_avm_auto2 = 1 => 0.3700680272,
									pk2_add1_avm_auto2 = 2 => 0.3680623174,
									pk2_add1_avm_auto2 = 3 => 0.299512987,
									pk2_add1_avm_auto2 = 4 => 0.2882267249,
									pk2_add1_avm_auto2 = 5 => 0.299031477,
									pk2_add1_avm_auto2 = 6 => 0.2709219858,
															  0.1724137931);

	pk2_add1_avm_auto3_mm_b2 := map(pk2_add1_avm_auto3 = 0 => 0.3319672131,
									pk2_add1_avm_auto3 = 1 => 0.3698630137,
									pk2_add1_avm_auto3 = 2 => 0.3129829985,
									pk2_add1_avm_auto3 = 3 => 0.2889515586,
									pk2_add1_avm_auto3 = 4 => 0.2871287129,
									pk2_add1_avm_auto3 = 5 => 0.2705078125,
									pk2_add1_avm_auto3 = 6 => 0.2643001085,
															  0.1990632319);

	pk2_add1_avm_med_mm_b2 := map(pk2_add1_avm_med = 0 => 0.3531914894,
								  pk2_add1_avm_med = 1 => 0.3657219973,
								  pk2_add1_avm_med = 2 => 0.348098434,
								  pk2_add1_avm_med = 3 => 0.3460490463,
								  pk2_add1_avm_med = 4 => 0.32761047,
								  pk2_add1_avm_med = 5 => 0.2687883576,
								  pk2_add1_avm_med = 6 => 0.16827853,
														  0.274530779);

	pk2_add1_avm_to_med_ratio_mm_b2 := map(pk2_add1_avm_to_med_ratio = 0 => 0.2877911326,
										   pk2_add1_avm_to_med_ratio = 1 => 0.2850865147,
										   pk2_add1_avm_to_med_ratio = 2 => 0.3107409535,
										   pk2_add1_avm_to_med_ratio = 3 => 0.2774765895,
										   pk2_add1_avm_to_med_ratio = 4 => 0.3172043011,
																			0.303030303);

	pk2_add2_avm_hed_mm_b2 := map(pk2_add2_avm_hed = 0 => 0.3708333333,
								  pk2_add2_avm_hed = 1 => 0.3390614673,
								  pk2_add2_avm_hed = 2 => 0.3105110897,
								  pk2_add2_avm_hed = 3 => 0.2884296311,
								  pk2_add2_avm_hed = 4 => 0.3037634409,
								  pk2_add2_avm_hed = 5 => 0.269105565,
														  0.181184669);

	pk2_add2_avm_auto3_mm_b2 := map(pk2_add2_avm_auto3 = 0 => 0.3653465347,
									pk2_add2_avm_auto3 = 1 => 0.3396039604,
									pk2_add2_avm_auto3 = 2 => 0.289995155,
									pk2_add2_avm_auto3 = 3 => 0.2687818697,
															  0.1740890688);

	pk_dist_a1toa2_mm_b2 := map(pk_dist_a1toa2_2 = 0 => 0.2857235142,
								pk_dist_a1toa2_2 = 1 => 0.2842292089,
								pk_dist_a1toa2_2 = 2 => 0.296722397,
								pk_dist_a1toa2_2 = 3 => 0.2903153657,
														0.3021001616);

	pk_dist_a1toa3_mm_b2 := map(pk_dist_a1toa3_2 = 0 => 0.2849143877,
								pk_dist_a1toa3_2 = 1 => 0.2732659463,
								pk_dist_a1toa3_2 = 2 => 0.2893292507,
								pk_dist_a1toa3_2 = 3 => 0.2996863975,
								pk_dist_a1toa3_2 = 4 => 0.3092324805,
								pk_dist_a1toa3_2 = 5 => 0.2760736196,
														0.3378378378);

	pk_out_st_division_lvl_mm_b2 := map(pk_out_st_division_lvl = -1 => 0.1984126984,
										pk_out_st_division_lvl = 0  => 0.2978365385,
										pk_out_st_division_lvl = 1  => 0.2791089705,
										pk_out_st_division_lvl = 2  => 0.2659994733,
										pk_out_st_division_lvl = 3  => 0.3218934911,
										pk_out_st_division_lvl = 4  => 0.3072367004,
										pk_out_st_division_lvl = 5  => 0.2415897098,
										pk_out_st_division_lvl = 6  => 0.2455049344,
										pk_out_st_division_lvl = 7  => 0.3464060374,
																	   0.2282023681);

	pk_impulse_count_mm_b2 := map(pk_impulse_count_2 = 0 => 0.2558808245,
								  pk_impulse_count_2 = 1 => 0.3196349469,
															0.3612159329);

	pk_attr_num_nonderogs90_b_mm_b2 := map(pk_attr_num_nonderogs90_b = 0  => 0.4110169492,
										   pk_attr_num_nonderogs90_b = 1  => 0.3482200647,
										   pk_attr_num_nonderogs90_b = 2  => 0.3142057383,
										   pk_attr_num_nonderogs90_b = 3  => 0.2720763723,
										   pk_attr_num_nonderogs90_b = 4  => 0.2820512821,
										   pk_attr_num_nonderogs90_b = 10 => 0.2777777778,
										   pk_attr_num_nonderogs90_b = 11 => 0.2694960212,
										   pk_attr_num_nonderogs90_b = 12 => 0.2430555556,
										   pk_attr_num_nonderogs90_b = 13 => 0.2096680256,
																			 0.1232876712);

	pk_ssns_per_addr2_mm_b2 := map(pk_ssns_per_addr2 = -101 => 0.2851901566,
								   pk_ssns_per_addr2 = -2   => 0.3273631841,
								   pk_ssns_per_addr2 = -1   => 0.285229202,
								   pk_ssns_per_addr2 = 0    => 0.2440585009,
								   pk_ssns_per_addr2 = 1    => 0.2571628232,
								   pk_ssns_per_addr2 = 2    => 0.2579693034,
								   pk_ssns_per_addr2 = 3    => 0.2589138782,
								   pk_ssns_per_addr2 = 4    => 0.2729912875,
								   pk_ssns_per_addr2 = 5    => 0.2738791423,
								   pk_ssns_per_addr2 = 6    => 0.2663645519,
								   pk_ssns_per_addr2 = 7    => 0.2785560345,
								   pk_ssns_per_addr2 = 8    => 0.2952959029,
								   pk_ssns_per_addr2 = 9    => 0.2968148407,
								   pk_ssns_per_addr2 = 10   => 0.2938950555,
								   pk_ssns_per_addr2 = 11   => 0.3098538067,
								   pk_ssns_per_addr2 = 12   => 0.3167330677,
								   pk_ssns_per_addr2 = 100  => 0.275862069,
								   pk_ssns_per_addr2 = 101  => 0.2627118644,
								   pk_ssns_per_addr2 = 102  => 0.2831360947,
															   0.3067970205);

	pk_yr_add2_assess_val_yr2_mm_b2 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.2885277888,
										   pk_yr_add2_assessed_value_year2 = 0  => 0.2048192771,
										   pk_yr_add2_assessed_value_year2 = 1  => 0.2861927546,
																				   0.3027233851);

	pk_estimated_income_mm_b3 := map(pk_estimated_income = -1 => 0.3359375,
									 pk_estimated_income = 0  => 0.3617021277,
									 pk_estimated_income = 1  => 0.3160714286,
									 pk_estimated_income = 2  => 0.2617586912,
									 pk_estimated_income = 3  => 0.3027656477,
									 pk_estimated_income = 4  => 0.2853159851,
									 pk_estimated_income = 5  => 0.2778143515,
									 pk_estimated_income = 6  => 0.2552255226,
									 pk_estimated_income = 7  => 0.2729257642,
									 pk_estimated_income = 8  => 0.2553533191,
									 pk_estimated_income = 9  => 0.2530186608,
									 pk_estimated_income = 10 => 0.2344747533,
									 pk_estimated_income = 11 => 0.2357414449,
									 pk_estimated_income = 12 => 0.201622248,
									 pk_estimated_income = 13 => 0.1978866475,
									 pk_estimated_income = 14 => 0.1798642534,
									 pk_estimated_income = 15 => 0.1974683544,
									 pk_estimated_income = 16 => 0.1910994764,
									 pk_estimated_income = 17 => 0.1685950413,
									 pk_estimated_income = 18 => 0.2102473498,
									 pk_estimated_income = 19 => 0.14958159,
									 pk_estimated_income = 20 => 0.1674669868,
									 pk_estimated_income = 21 => 0.0934579439,
																 0.1153846154);

	pk_yr_adl_pr_first_seen2_mm_b3 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.2496391825,
										  pk_yr_adl_pr_first_seen2 = 0  => 0.1650943396,
										  pk_yr_adl_pr_first_seen2 = 1  => 0.1638929088,
										  pk_yr_adl_pr_first_seen2 = 2  => 0.1593333333,
										  pk_yr_adl_pr_first_seen2 = 3  => 0.1334776335,
										  pk_yr_adl_pr_first_seen2 = 4  => 0.1179361179,
										  pk_yr_adl_pr_first_seen2 = 5  => 0.1448170732,
										  pk_yr_adl_pr_first_seen2 = 6  => 0.16,
																		   0.0769230769);

	pk_yr_adl_w_first_seen2_mm_b3 := map(pk_yr_adl_w_first_seen2 = -1 => 0.2261038502,
										 pk_yr_adl_w_first_seen2 = 0  => 0.1616161616,
										 pk_yr_adl_w_first_seen2 = 1  => 0.1548821549,
																		 0.2608695652);

	pk_yr_adl_w_last_seen2_mm_b3 := map(pk_yr_adl_w_last_seen2 = -1 => 0.2261038502,
										pk_yr_adl_w_last_seen2 = 0  => 0.1830985915,
										pk_yr_adl_w_last_seen2 = 1  => 0.1666666667,
																	   0.1557971014);

	pk_pr_count_mm_b3 := map(pk_pr_count = -1 => 0.2503990985,
							 pk_pr_count = 0  => 0.1597760551,
							 pk_pr_count = 1  => 0.148944565,
												 0.25);

	pk_addrs_sourced_lvl_mm_b3 := map(pk_addrs_sourced_lvl = 0 => 0.235945835,
									  pk_addrs_sourced_lvl = 1 => 0.1784054344,
									  pk_addrs_sourced_lvl = 2 => 0.134088763,
																  0.1550695825);

	pk_add1_own_level_mm_b3 := map(pk_add1_own_level = -1 => 0.2496651038,
								   pk_add1_own_level = 0  => 0.2428635576,
								   pk_add1_own_level = 1  => 0.2200357782,
								   pk_add1_own_level = 2  => 0.1369318182,
															 0.1285878301);

	pk_naprop_level2_mm_b3 := map(pk_naprop_level2 = -2 => 0.2587878788,
								  pk_naprop_level2 = -1 => 0.2497517378,
								  pk_naprop_level2 = 0  => 0.2485089463,
								  pk_naprop_level2 = 1  => 0.237695078,
								  pk_naprop_level2 = 2  => 0.2450788535,
								  pk_naprop_level2 = 3  => 0.2230281052,
								  pk_naprop_level2 = 4  => 0.230565371,
								  pk_naprop_level2 = 5  => 0.2041522491,
								  pk_naprop_level2 = 6  => 0.1355165069,
														   0.1103723404);

	pk_yr_add1_built_date2_mm_b3 := map(pk_yr_add1_built_date2 = -4 => 0.2378511646,
										pk_yr_add1_built_date2 = -3 => 0.2142857143,
										pk_yr_add1_built_date2 = -2 => 0.1834002677,
										pk_yr_add1_built_date2 = -1 => 0.1597402597,
										pk_yr_add1_built_date2 = 0  => 0.1987218503,
										pk_yr_add1_built_date2 = 1  => 0.2246648794,
										pk_yr_add1_built_date2 = 2  => 0.2203879488,
																	   0.2218000475);

	pk_add1_purchase_amount2_mm_b3 := map(pk_add1_purchase_amount2 = -1 => 0.2382590566,
										  pk_add1_purchase_amount2 = 0  => 0.207947618,
																		   0.1910068426);

	pk_add1_mortgage_amount2_mm_b3 := map(pk_add1_mortgage_amount2 = -1 => 0.2350929907,
										  pk_add1_mortgage_amount2 = 0  => 0.2248590923,
										  pk_add1_mortgage_amount2 = 1  => 0.1930917327,
																		   0.1939846118);

	pk_yr_add1_mortgage_date2_mm_b3 := map(pk_yr_add1_mortgage_date2 = -1 => 0.2314380027,
										   pk_yr_add1_mortgage_date2 = 0  => 0.2141712087,
										   pk_yr_add1_mortgage_date2 = 1  => 0.2034438776,
																			 0.1989735492);

	pk_add1_assessed_amount2_mm_b3 := map(pk_add1_assessed_amount2 = -1 => 0.2330070691,
										  pk_add1_assessed_amount2 = 0  => 0.2516248839,
										  pk_add1_assessed_amount2 = 1  => 0.230125523,
										  pk_add1_assessed_amount2 = 2  => 0.2530232558,
										  pk_add1_assessed_amount2 = 3  => 0.2150537634,
										  pk_add1_assessed_amount2 = 4  => 0.1899622234,
										  pk_add1_assessed_amount2 = 5  => 0.2077562327,
																		   0.1924029727);

	pk_yr_add1_date_first_seen2_mm_b3 := map(pk_yr_add1_date_first_seen2 = -1 => 0.3189778926,
											 pk_yr_add1_date_first_seen2 = 0  => 0.2216931217,
											 pk_yr_add1_date_first_seen2 = 1  => 0.2076813656,
											 pk_yr_add1_date_first_seen2 = 2  => 0.1992854307,
											 pk_yr_add1_date_first_seen2 = 3  => 0.1943771207,
											 pk_yr_add1_date_first_seen2 = 4  => 0.1818923328,
											 pk_yr_add1_date_first_seen2 = 5  => 0.1788055353,
											 pk_yr_add1_date_first_seen2 = 6  => 0.1668099742,
											 pk_yr_add1_date_first_seen2 = 7  => 0.1591549296,
											 pk_yr_add1_date_first_seen2 = 8  => 0.1505791506,
											 pk_yr_add1_date_first_seen2 = 9  => 0.1736745887,
																				 0.094017094);

	pk_add1_building_area2_mm_b3 := map(pk_add1_building_area2 = -99 => 0.2380604935,
										pk_add1_building_area2 = -4  => 0.2596685083,
										pk_add1_building_area2 = -3  => 0.2168330956,
										pk_add1_building_area2 = -2  => 0.2040386521,
										pk_add1_building_area2 = -1  => 0.2049632353,
										pk_add1_building_area2 = 0   => 0.1944894652,
										pk_add1_building_area2 = 1   => 0.2575757576,
										pk_add1_building_area2 = 2   => 0.2920353982,
										pk_add1_building_area2 = 3   => 0.1993127148,
																		0.2399380805);

	pk_add1_no_of_rooms_mm_b3 := map(pk_add1_no_of_rooms = -1 => 0.229119931,
									 pk_add1_no_of_rooms = 0  => 0.2246998285,
									 pk_add1_no_of_rooms = 1  => 0.2214611872,
									 pk_add1_no_of_rooms = 2  => 0.1978891821,
									 pk_add1_no_of_rooms = 3  => 0.1926091825,
																 0.2123893805);

	pk_add1_garage_type_risk_lvl_mm_b3 := map(pk_add1_garage_type_risk_level = 0 => 0.2033271719,
											  pk_add1_garage_type_risk_level = 1 => 0.202057067,
											  pk_add1_garage_type_risk_level = 2 => 0.2134724858,
																					0.2325136351);

	pk_add1_style_code_level_mm_b3 := map(pk_add1_style_code_level = 0 => 0.2279190794,
										  pk_add1_style_code_level = 1 => 0.1901840491,
										  pk_add1_style_code_level = 2 => 0.1495901639,
										  pk_add1_style_code_level = 3 => 0.1902439024,
																		  0.1822827939);

	pk_property_owned_total_mm_b3 := map(pk_property_owned_total = -1 => 0.2443025627,
										 pk_property_owned_total = 0  => 0.1544558283,
										 pk_property_owned_total = 1  => 0.1545547595,
										 pk_property_owned_total = 2  => 0.4615384615,
																		 0.25);

	pk_prop1_prev_purchase_price2_mm_b3 := map(pk_prop1_prev_purchase_price2 = 0 => 0.2262335818,
											   pk_prop1_prev_purchase_price2 = 1 => 0.1678832117,
																					0.172985782);

	pk_add2_building_area2_mm_b3 := map(pk_add2_building_area2 = -4 => 0.2237038617,
										pk_add2_building_area2 = -3 => 0.2335766423,
										pk_add2_building_area2 = -2 => 0.2311396469,
										pk_add2_building_area2 = -1 => 0.2292651132,
										pk_add2_building_area2 = 0  => 0.2166910688,
										pk_add2_building_area2 = 1  => 0.3846153846,
																	   0.2347266881);

	pk_add2_no_of_buildings_mm_b3 := map(pk_add2_no_of_buildings = -1 => 0.2232197762,
										 pk_add2_no_of_buildings = 0  => 0.2347181794,
										 pk_add2_no_of_buildings = 1  => 0.2352941176,
																		 0.2959183673);

	pk_add2_no_of_rooms_mm_b3 := map(pk_add2_no_of_rooms = -1 => 0.2259421059,
									 pk_add2_no_of_rooms = 0  => 0.2205882353,
									 pk_add2_no_of_rooms = 1  => 0.2253366309,
																 0.1843817787);

	pk_add2_style_code_level_mm_b3 := map(pk_add2_style_code_level = 0 => 0.2259128984,
										  pk_add2_style_code_level = 1 => 0.1639344262,
										  pk_add2_style_code_level = 2 => 0.2222222222,
										  pk_add2_style_code_level = 3 => 0.2146892655,
																		  0.2042105263);

	pk_add2_purchase_amount2_mm_b3 := map(pk_add2_purchase_amount2 = -1 => 0.2274048443,
										  pk_add2_purchase_amount2 = 0  => 0.2423411065,
																		   0.2075200329);

	pk_add2_mortgage_risk_mm_b3 := map(pk_add2_mortgage_risk = -1 => 0.1904761905,
									   pk_add2_mortgage_risk = 0  => 0.1996161228,
									   pk_add2_mortgage_risk = 1  => 0.2257040857,
									   pk_add2_mortgage_risk = 2  => 0.213130352,
																	 0.2449421965);

	pk_add2_assessed_amount2_mm_b3 := map(pk_add2_assessed_amount2 = -1 => 0.2229571254,
										  pk_add2_assessed_amount2 = 0  => 0.2604735883,
										  pk_add2_assessed_amount2 = 1  => 0.2411575563,
										  pk_add2_assessed_amount2 = 2  => 0.2353760446,
										  pk_add2_assessed_amount2 = 3  => 0.2094284522,
																		   0.2202925046);

	pk_yr_add2_date_first_seen2_mm_b3 := map(pk_yr_add2_date_first_seen2 = -1 => 0.2837541164,
											 pk_yr_add2_date_first_seen2 = 0  => 0.2601987448,
											 pk_yr_add2_date_first_seen2 = 1  => 0.2441642071,
											 pk_yr_add2_date_first_seen2 = 2  => 0.2455054524,
											 pk_yr_add2_date_first_seen2 = 3  => 0.2283891547,
											 pk_yr_add2_date_first_seen2 = 4  => 0.2084574151,
											 pk_yr_add2_date_first_seen2 = 5  => 0.2047761194,
											 pk_yr_add2_date_first_seen2 = 6  => 0.2080924855,
											 pk_yr_add2_date_first_seen2 = 7  => 0.2190745987,
											 pk_yr_add2_date_first_seen2 = 8  => 0.1789077213,
											 pk_yr_add2_date_first_seen2 = 9  => 0.1690496215,
											 pk_yr_add2_date_first_seen2 = 10 => 0.1652661064,
																				 0.1540178571);

	pk_yr_add2_date_last_seen2_mm_b3 := map(pk_yr_add2_date_last_seen2 = -1 => 0.2837541164,
											pk_yr_add2_date_last_seen2 = 0  => 0.2451254926,
											pk_yr_add2_date_last_seen2 = 1  => 0.1750205423,
											pk_yr_add2_date_last_seen2 = 2  => 0.1709570957,
											pk_yr_add2_date_last_seen2 = 3  => 0.165787932,
											pk_yr_add2_date_last_seen2 = 4  => 0.1101190476,
											pk_yr_add2_date_last_seen2 = 5  => 0.1325796506,
																			   0.1382978723);

	pk_add3_purchase_amount2_mm_b3 := map(pk_add3_purchase_amount2 = -1 => 0.2294084162,
										  pk_add3_purchase_amount2 = 0  => 0.233933162,
										  pk_add3_purchase_amount2 = 1  => 0.2200220022,
										  pk_add3_purchase_amount2 = 2  => 0.2079722704,
										  pk_add3_purchase_amount2 = 3  => 0.2057628371,
																		   0.2);

	pk_add3_mortgage_risk_mm_b3 := map(pk_add3_mortgage_risk = -1 => 0.2592592593,
									   pk_add3_mortgage_risk = 0  => 0.2016689847,
									   pk_add3_mortgage_risk = 1  => 0.2023809524,
									   pk_add3_mortgage_risk = 2  => 0.2273060453,
									   pk_add3_mortgage_risk = 3  => 0.2009400705,
									   pk_add3_mortgage_risk = 4  => 0.1947115385,
																	 0.2542372881);

	pk_add3_assessed_amount2_mm_b3 := map(pk_add3_assessed_amount2 = -1 => 0.2242434999,
										  pk_add3_assessed_amount2 = 0  => 0.260026738,
										  pk_add3_assessed_amount2 = 1  => 0.2388489209,
										  pk_add3_assessed_amount2 = 2  => 0.2306755934,
																		   0.2040729741);

	pk_yr_add3_date_first_seen2_mm_b3 := map(pk_yr_add3_date_first_seen2 = -1 => 0.2726852921,
											 pk_yr_add3_date_first_seen2 = 0  => 0.2776219854,
											 pk_yr_add3_date_first_seen2 = 1  => 0.2572886297,
											 pk_yr_add3_date_first_seen2 = 2  => 0.2400702988,
											 pk_yr_add3_date_first_seen2 = 3  => 0.2341059603,
											 pk_yr_add3_date_first_seen2 = 4  => 0.2127542606,
											 pk_yr_add3_date_first_seen2 = 5  => 0.2154621197,
											 pk_yr_add3_date_first_seen2 = 6  => 0.1839543471,
											 pk_yr_add3_date_first_seen2 = 7  => 0.1682665161,
											 pk_yr_add3_date_first_seen2 = 8  => 0.1575954509,
																				 0.1511961722);

	pk_yr_add3_date_last_seen2_mm_b3 := map(pk_yr_add3_date_last_seen2 = -1 => 0.2726852921,
											pk_yr_add3_date_last_seen2 = 0  => 0.2572169599,
											pk_yr_add3_date_last_seen2 = 1  => 0.2229923518,
											pk_yr_add3_date_last_seen2 = 2  => 0.2112769486,
											pk_yr_add3_date_last_seen2 = 3  => 0.2049248748,
											pk_yr_add3_date_last_seen2 = 4  => 0.1818897638,
											pk_yr_add3_date_last_seen2 = 5  => 0.152764761,
											pk_yr_add3_date_last_seen2 = 6  => 0.1322849214,
											pk_yr_add3_date_last_seen2 = 7  => 0.1577608142,
																			   0.1358313817);

	pk_bk_level_mm_b3 := if(pk_bk_level_2 = 0, 0.22517317, NULL);

	pk_eviction_level_mm_b3 := if(pk_eviction_level = 0, 0.22517317, NULL);

	pk_lien_type_level_mm_b3 := if(pk_lien_type_level = 0, 0.22517317, NULL);

	pk_yr_liens_last_unrel_date3_mm_b3 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.22517317, NULL);

	pk_yr_ln_unrel_lt_f_sn2_mm_b3 := if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.22517317, NULL);

	pk_yr_ln_unrel_ot_f_sn2_mm_b3 := if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.22517317, NULL);

	pk_yr_attr_dt_l_eviction2_mm_b3 := if(pk_yr_attr_date_last_eviction2 = -1, 0.22517317, NULL);

	pk_crime_level_mm_b3 := map(pk_crime_level = 0 => 0.2251270626,
													  0.6666666667);

	pk_attr_total_number_derogs_mm_b3 := if(pk_attr_total_number_derogs_5 = 0, 0.22517317, NULL);

	pk_yr_rc_ssnhighissue2_mm_b3 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.2096774194,
										pk_yr_rc_ssnhighissue2 = 0  => 0.21875,
										pk_yr_rc_ssnhighissue2 = 1  => 0.2094240838,
										pk_yr_rc_ssnhighissue2 = 2  => 0.2100591716,
										pk_yr_rc_ssnhighissue2 = 3  => 0.25,
										pk_yr_rc_ssnhighissue2 = 4  => 0.2934967654,
										pk_yr_rc_ssnhighissue2 = 5  => 0.24,
										pk_yr_rc_ssnhighissue2 = 6  => 0.2306597057,
										pk_yr_rc_ssnhighissue2 = 7  => 0.2187375943,
										pk_yr_rc_ssnhighissue2 = 8  => 0.2246039143,
										pk_yr_rc_ssnhighissue2 = 9  => 0.2087712939,
										pk_yr_rc_ssnhighissue2 = 10 => 0.2032332564,
										pk_yr_rc_ssnhighissue2 = 11 => 0.184470377,
										pk_yr_rc_ssnhighissue2 = 12 => 0.170212766,
										pk_yr_rc_ssnhighissue2 = 13 => 0.1524590164,
																	   0.157480315);

	pk_pl_sourced_level_mm_b3 := map(pk_pl_sourced_level = 0 => 0.2287249706,
									 pk_pl_sourced_level = 1 => 0.1642512077,
									 pk_pl_sourced_level = 2 => 0.1693711968,
																0.1467391304);

	pk_prof_lic_cat_mm_b3 := map(pk_prof_lic_cat = -1 => 0.2279898219,
								 pk_prof_lic_cat = 0  => 0.195035461,
								 pk_prof_lic_cat = 1  => 0.1414473684,
								 pk_prof_lic_cat = 2  => 0.1241830065,
														 0.1333333333);

	pk_add1_lres_mm_b3 := map(pk_add1_lres = -2 => 0.2315789474,
							  pk_add1_lres = -1 => 0.315926893,
							  pk_add1_lres = 0  => 0.2082616179,
							  pk_add1_lres = 1  => 0.25,
							  pk_add1_lres = 2  => 0.2034782609,
							  pk_add1_lres = 3  => 0.2253032929,
							  pk_add1_lres = 4  => 0.2104018913,
							  pk_add1_lres = 5  => 0.2065439673,
							  pk_add1_lres = 6  => 0.2003294893,
							  pk_add1_lres = 7  => 0.191332135,
							  pk_add1_lres = 8  => 0.1752093802,
							  pk_add1_lres = 9  => 0.1611876988,
							  pk_add1_lres = 10 => 0.1527390901,
												   0.1780104712);

	pk_add3_lres_mm_b3 := map(pk_add3_lres = -2 => 0.2729012198,
							  pk_add3_lres = -1 => 0.2053657595,
							  pk_add3_lres = 0  => 0.2265936255,
							  pk_add3_lres = 1  => 0.2203872437,
							  pk_add3_lres = 2  => 0.222257755,
							  pk_add3_lres = 3  => 0.197039778,
							  pk_add3_lres = 4  => 0.1799687011,
							  pk_add3_lres = 5  => 0.1997105644,
												   0.1949458484);

	pk_addrs_5yr_mm_b3 := map(pk_addrs_5yr = 0 => 0.2017133956,
							  pk_addrs_5yr = 1 => 0.2273867493,
							  pk_addrs_5yr = 2 => 0.2343792264,
							  pk_addrs_5yr = 3 => 0.2349425287,
												  0.2276595745);

	pk_addrs_10yr_mm_b3 := map(pk_addrs_10yr = 0 => 0.2214076246,
							   pk_addrs_10yr = 1 => 0.2357050453,
							   pk_addrs_10yr = 2 => 0.2254372019,
							   pk_addrs_10yr = 3 => 0.2131474104,
													0.2197496523);

	pk_addrs_15yr_mm_b3 := map(pk_addrs_15yr = 0 => 0.2685758514,
							   pk_addrs_15yr = 1 => 0.2244425831,
							   pk_addrs_15yr = 2 => 0.2102143183,
													0.1965317919);

	pk_add_lres_month_avg2_mm_b3 := map(pk_add_lres_month_avg2 = -1 => 0.3296296296,
										pk_add_lres_month_avg2 = 0  => 0.4322580645,
										pk_add_lres_month_avg2 = 1  => 0.2793851718,
										pk_add_lres_month_avg2 = 2  => 0.2605820106,
										pk_add_lres_month_avg2 = 3  => 0.2675453048,
										pk_add_lres_month_avg2 = 4  => 0.2362318841,
										pk_add_lres_month_avg2 = 5  => 0.2529832936,
										pk_add_lres_month_avg2 = 6  => 0.240797546,
										pk_add_lres_month_avg2 = 7  => 0.2462006079,
										pk_add_lres_month_avg2 = 8  => 0.2331809275,
										pk_add_lres_month_avg2 = 9  => 0.2106470858,
										pk_add_lres_month_avg2 = 10 => 0.2009249743,
										pk_add_lres_month_avg2 = 11 => 0.204496788,
										pk_add_lres_month_avg2 = 12 => 0.1900674433,
										pk_add_lres_month_avg2 = 13 => 0.1629726206,
										pk_add_lres_month_avg2 = 15 => 0.1445086705,
																	   0.1581920904);

	pk_nameperssn_count_mm_b3 := map(pk_nameperssn_count = 0 => 0.2231698113,
									 pk_nameperssn_count = 1 => 0.2513863216,
																0.1692307692);

	pk_ssns_per_adl_mm_b3 := map(pk_ssns_per_adl = -1 => 0.3207207207,
								 pk_ssns_per_adl = 0  => 0.2167337311,
								 pk_ssns_per_adl = 1  => 0.2336521569,
								 pk_ssns_per_adl = 2  => 0.2720450281,
								 pk_ssns_per_adl = 3  => 0.3089430894,
														 0.3559322034);

	pk_addrs_per_adl_mm_b3 := map(pk_addrs_per_adl = -6 => 0.3197424893,
								  pk_addrs_per_adl = -5 => 0.2970895113,
								  pk_addrs_per_adl = -4 => 0.2789011828,
								  pk_addrs_per_adl = -3 => 0.2574552684,
								  pk_addrs_per_adl = -2 => 0.2419606619,
								  pk_addrs_per_adl = -1 => 0.2188736682,
								  pk_addrs_per_adl = 0  => 0.1972962382,
								  pk_addrs_per_adl = 1  => 0.2021764032,
								  pk_addrs_per_adl = 2  => 0.1702574882,
														   0.1877729258);

	pk_phones_per_adl_mm_b3 := map(pk_phones_per_adl = -1 => 0.2328733487,
								   pk_phones_per_adl = 0  => 0.1994350282,
								   pk_phones_per_adl = 1  => 0.2442273535,
															 0.25);

	pk_adlperssn_count_mm_b3 := map(pk_adlperssn_count = -1 => 0.3388429752,
									pk_adlperssn_count = 0  => 0.2233078992,
									pk_adlperssn_count = 1  => 0.2240841777,
															   0.2357965095);

	pk_adls_per_addr_mm_b3 := map(pk_adls_per_addr = -102 => 0.2298978644,
								  pk_adls_per_addr = -101 => 0.2605042017,
								  pk_adls_per_addr = -2   => 0.3158844765,
								  pk_adls_per_addr = -1   => 0.2294117647,
								  pk_adls_per_addr = 0    => 0.1510067114,
								  pk_adls_per_addr = 1    => 0.2016057092,
								  pk_adls_per_addr = 2    => 0.1703645008,
								  pk_adls_per_addr = 3    => 0.1975724882,
								  pk_adls_per_addr = 4    => 0.1895244659,
								  pk_adls_per_addr = 5    => 0.2217422606,
								  pk_adls_per_addr = 6    => 0.2257551669,
								  pk_adls_per_addr = 7    => 0.2118780096,
								  pk_adls_per_addr = 8    => 0.2250686185,
								  pk_adls_per_addr = 9    => 0.2401157184,
								  pk_adls_per_addr = 10   => 0.2418338109,
								  pk_adls_per_addr = 11   => 0.2206287921,
								  pk_adls_per_addr = 12   => 0.237012987,
								  pk_adls_per_addr = 13   => 0.2436482085,
								  pk_adls_per_addr = 100  => 0.2272727273,
								  pk_adls_per_addr = 101  => 0.25,
															 0.2478849408);

	pk_adls_per_phone_mm_b3 := map(pk_adls_per_phone = -2 => 0.2280019212,
								   pk_adls_per_phone = -1 => 0.2174790438,
								   pk_adls_per_phone = 0  => 0.2130044843,
															 0.2790697674);

	pk_ssns_per_adl_c6_mm_b3 := map(pk_ssns_per_adl_c6 = 0 => 0.2191836735,
									pk_ssns_per_adl_c6 = 1 => 0.2354127002,
															  0.355);

	pk_ssns_per_addr_c6_mm_b3 := map(pk_ssns_per_addr_c6 = 0   => 0.2076386784,
									 pk_ssns_per_addr_c6 = 1   => 0.2381374723,
									 pk_ssns_per_addr_c6 = 2   => 0.231884058,
									 pk_ssns_per_addr_c6 = 3   => 0.282245827,
									 pk_ssns_per_addr_c6 = 4   => 0.3300492611,
									 pk_ssns_per_addr_c6 = 5   => 0.34375,
									 pk_ssns_per_addr_c6 = 6   => 0.3389830508,
									 pk_ssns_per_addr_c6 = 100 => 0.2320746712,
									 pk_ssns_per_addr_c6 = 101 => 0.2741702742,
									 pk_ssns_per_addr_c6 = 102 => 0.2258064516,
									 pk_ssns_per_addr_c6 = 103 => 0.25,
																  0.3181818182);

	pk_adls_per_phone_c6_mm_b3 := map(pk_adls_per_phone_c6 = 0 => 0.2266562337,
									  pk_adls_per_phone_c6 = 1 => 0.2246432703,
																  0.1669758813);

	pk_attr_addrs_last24_mm_b3 := map(pk_attr_addrs_last24 = 0 => 0.2058184639,
									  pk_attr_addrs_last24 = 1 => 0.2357804233,
									  pk_attr_addrs_last24 = 2 => 0.2494534324,
									  pk_attr_addrs_last24 = 3 => 0.23815621,
									  pk_attr_addrs_last24 = 4 => 0.2581196581,
																  0.2826086957);

	pk_ams_class_level_mm_b3 := map(pk_ams_class_level = -1000001 => 0.2276917229,
									pk_ams_class_level = 0        => 0.3697916667,
									pk_ams_class_level = 1        => 0.328042328,
									pk_ams_class_level = 2        => 0.3088803089,
									pk_ams_class_level = 3        => 0.3483870968,
									pk_ams_class_level = 4        => 0.2620689655,
									pk_ams_class_level = 5        => 0.221180364,
									pk_ams_class_level = 6        => 0.229390681,
									pk_ams_class_level = 7        => 0.1918412348,
									pk_ams_class_level = 8        => 0.2118100128,
									pk_ams_class_level = 1000000  => 0.2673031026,
									pk_ams_class_level = 1000001  => 0.1862745098,
									pk_ams_class_level = 1000002  => 0.1456410256,
									pk_ams_class_level = 1000003  => 0.1369863014,
									pk_ams_class_level = 1000004  => 0.0846774194,
																	 0.1304347826);

	pk_ams_income_level_code_mm_b3 := map(pk_ams_income_level_code = -1 => 0.2277542876,
										  pk_ams_income_level_code = 0  => 0.2604422604,
										  pk_ams_income_level_code = 1  => 0.2352941176,
										  pk_ams_income_level_code = 2  => 0.230628655,
										  pk_ams_income_level_code = 3  => 0.197327852,
										  pk_ams_income_level_code = 4  => 0.2022932023,
										  pk_ams_income_level_code = 5  => 0.1796116505,
																		   0.1983471074);

	pk_college_tier_mm_b3 := map((integer)pk_college_tier = -1 => 0.2312185687,
								 (integer)pk_college_tier = 1  => 0.0588235294,
								 (integer)pk_college_tier = 2  => 0.1,
								 (integer)pk_college_tier = 3  => 0.1342412451,
								 (integer)pk_college_tier = 4  => 0.1425260718,
								 (integer)pk_college_tier = 5  => 0.1855388813,
																  0.2434640523);

	pk_yr_in_dob2_mm_b3 := map(pk_yr_in_dob2 = 19 => 0.4120879121,
							   pk_yr_in_dob2 = 20 => 0.3767660911,
							   pk_yr_in_dob2 = 21 => 0.3357058126,
							   pk_yr_in_dob2 = 22 => 0.3291404612,
							   pk_yr_in_dob2 = 23 => 0.296398892,
							   pk_yr_in_dob2 = 25 => 0.2662144977,
							   pk_yr_in_dob2 = 29 => 0.2301937464,
							   pk_yr_in_dob2 = 35 => 0.2107898562,
							   pk_yr_in_dob2 = 38 => 0.1916299559,
							   pk_yr_in_dob2 = 41 => 0.18,
							   pk_yr_in_dob2 = 42 => 0.2331288344,
							   pk_yr_in_dob2 = 43 => 0.2089552239,
							   pk_yr_in_dob2 = 44 => 0.1833976834,
							   pk_yr_in_dob2 = 45 => 0.1782608696,
							   pk_yr_in_dob2 = 47 => 0.1900921659,
							   pk_yr_in_dob2 = 49 => 0.1671087533,
							   pk_yr_in_dob2 = 57 => 0.1798966651,
							   pk_yr_in_dob2 = 61 => 0.1620209059,
													 0.1477272727);

	pk_ams_age_mm_b3 := map(pk_ams_age = -1 => 0.2220014685,
							pk_ams_age = 21 => 0.3146551724,
							pk_ams_age = 22 => 0.3027888446,
							pk_ams_age = 23 => 0.3056478405,
							pk_ams_age = 24 => 0.286163522,
							pk_ams_age = 25 => 0.2959501558,
							pk_ams_age = 29 => 0.2153146323,
											   0.2094542659);

	pk_inferred_age_mm_b3 := map(pk_inferred_age = -1 => 0.318501171,
								 pk_inferred_age = 18 => 0.4187725632,
								 pk_inferred_age = 19 => 0.339731286,
								 pk_inferred_age = 20 => 0.3423913043,
								 pk_inferred_age = 21 => 0.2997118156,
								 pk_inferred_age = 22 => 0.3099361896,
								 pk_inferred_age = 24 => 0.2685453792,
								 pk_inferred_age = 34 => 0.2211042312,
								 pk_inferred_age = 37 => 0.1941704036,
								 pk_inferred_age = 41 => 0.1865168539,
								 pk_inferred_age = 42 => 0.2123287671,
								 pk_inferred_age = 43 => 0.1774891775,
								 pk_inferred_age = 44 => 0.1698924731,
								 pk_inferred_age = 46 => 0.1809045226,
								 pk_inferred_age = 48 => 0.1695156695,
								 pk_inferred_age = 52 => 0.1759729272,
								 pk_inferred_age = 56 => 0.1831683168,
								 pk_inferred_age = 61 => 0.1583710407,
														 0.1472491909);

	pk_yr_reported_dob2_mm_b3 := map(pk_yr_reported_dob2 = -1 => 0.2907145246,
									 pk_yr_reported_dob2 = 19 => 0.4482758621,
									 pk_yr_reported_dob2 = 21 => 0.3018867925,
									 pk_yr_reported_dob2 = 22 => 0.2205882353,
									 pk_yr_reported_dob2 = 23 => 0.2413793103,
									 pk_yr_reported_dob2 = 32 => 0.2180835086,
									 pk_yr_reported_dob2 = 35 => 0.1923076923,
									 pk_yr_reported_dob2 = 39 => 0.1874521806,
									 pk_yr_reported_dob2 = 42 => 0.1802096986,
									 pk_yr_reported_dob2 = 43 => 0.2112676056,
									 pk_yr_reported_dob2 = 44 => 0.1771058315,
									 pk_yr_reported_dob2 = 45 => 0.1736111111,
									 pk_yr_reported_dob2 = 46 => 0.1584415584,
									 pk_yr_reported_dob2 = 49 => 0.1770642202,
									 pk_yr_reported_dob2 = 57 => 0.1780821918,
									 pk_yr_reported_dob2 = 61 => 0.1563636364,
																 0.1469329529);

	pk_avm_hit_level_mm_b3 := map(pk_avm_hit_level = -1 => 0.2396768402,
								  pk_avm_hit_level = 0  => 0.2373875321,
								  pk_avm_hit_level = 1  => 0.2081077329,
														   0.2048896582);

	pk_add2_avm_auto_diff3_lvl_mm_b3 := map(pk_add2_avm_auto_diff3_lvl = -2 => 0.2263773769,
											pk_add2_avm_auto_diff3_lvl = -1 => 0.193817878,
																			   0.2270008545);

	pk2_add1_avm_sp_mm_b3 := map(pk2_add1_avm_sp = 0 => 0.2345119501,
								 pk2_add1_avm_sp = 1 => 0.1829608939,
								 pk2_add1_avm_sp = 2 => 0.1907855877,
														0.1801354402);

	pk2_add1_avm_as_mm_b3 := map(pk2_add1_avm_as = 0 => 0.2356156502,
								 pk2_add1_avm_as = 1 => 0.2158273381,
								 pk2_add1_avm_as = 2 => 0.1793733037,
														0.2330097087);

	pk2_add1_avm_auto2_mm_b3 := map(pk2_add1_avm_auto2 = 0 => 0.2466666667,
									pk2_add1_avm_auto2 = 1 => 0.2863849765,
									pk2_add1_avm_auto2 = 2 => 0.2549295775,
									pk2_add1_avm_auto2 = 3 => 0.2241014799,
									pk2_add1_avm_auto2 = 4 => 0.2363429869,
									pk2_add1_avm_auto2 = 5 => 0.2061310782,
									pk2_add1_avm_auto2 = 6 => 0.1950413223,
															  0.1970588235);

	pk2_add1_avm_auto3_mm_b3 := map(pk2_add1_avm_auto3 = 0 => 0.325,
									pk2_add1_avm_auto3 = 1 => 0.2582557155,
									pk2_add1_avm_auto3 = 2 => 0.244111349,
									pk2_add1_avm_auto3 = 3 => 0.2329381443,
									pk2_add1_avm_auto3 = 4 => 0.1966224367,
									pk2_add1_avm_auto3 = 5 => 0.2021563342,
									pk2_add1_avm_auto3 = 6 => 0.1912823507,
															  0.2005813953);

	pk2_add1_avm_med_mm_b3 := map(pk2_add1_avm_med = 0 => 0.2611940299,
								  pk2_add1_avm_med = 1 => 0.300295858,
								  pk2_add1_avm_med = 2 => 0.2893175074,
								  pk2_add1_avm_med = 3 => 0.247734139,
								  pk2_add1_avm_med = 4 => 0.2457746479,
								  pk2_add1_avm_med = 5 => 0.2108468865,
								  pk2_add1_avm_med = 6 => 0.1482479784,
														  0.2196416722);

	pk2_add1_avm_to_med_ratio_mm_b3 := map(pk2_add1_avm_to_med_ratio = 0 => 0.2334741288,
										   pk2_add1_avm_to_med_ratio = 1 => 0.2106819763,
										   pk2_add1_avm_to_med_ratio = 2 => 0.1968557758,
										   pk2_add1_avm_to_med_ratio = 3 => 0.2140709561,
										   pk2_add1_avm_to_med_ratio = 4 => 0.1765957447,
																			0.2449438202);

	pk2_add2_avm_hed_mm_b3 := map(pk2_add2_avm_hed = 0 => 0.2844827586,
								  pk2_add2_avm_hed = 1 => 0.278313253,
								  pk2_add2_avm_hed = 2 => 0.2380216383,
								  pk2_add2_avm_hed = 3 => 0.2258965999,
								  pk2_add2_avm_hed = 4 => 0.2218700475,
								  pk2_add2_avm_hed = 5 => 0.2094027345,
														  0.2042553191);

	pk2_add2_avm_auto3_mm_b3 := map(pk2_add2_avm_auto3 = 0 => 0.2798507463,
									pk2_add2_avm_auto3 = 1 => 0.2959558824,
									pk2_add2_avm_auto3 = 2 => 0.2274853536,
									pk2_add2_avm_auto3 = 3 => 0.2050009193,
															  0.1780104712);

	pk_dist_a1toa2_mm_b3 := map(pk_dist_a1toa2_2 = 0 => 0.2144060111,
								pk_dist_a1toa2_2 = 1 => 0.2257472951,
								pk_dist_a1toa2_2 = 2 => 0.2196957566,
								pk_dist_a1toa2_2 = 3 => 0.2321340562,
														0.2781420765);

	pk_dist_a1toa3_mm_b3 := map(pk_dist_a1toa3_2 = 0 => 0.2193832599,
								pk_dist_a1toa3_2 = 1 => 0.2128801431,
								pk_dist_a1toa3_2 = 2 => 0.2198356808,
								pk_dist_a1toa3_2 = 3 => 0.2192257503,
								pk_dist_a1toa3_2 = 4 => 0.216765453,
								pk_dist_a1toa3_2 = 5 => 0.1986644407,
														0.270088249);

	pk_out_st_division_lvl_mm_b3 := map(pk_out_st_division_lvl = -1 => 0.2631578947,
										pk_out_st_division_lvl = 0  => 0.205952381,
										pk_out_st_division_lvl = 1  => 0.2121451104,
										pk_out_st_division_lvl = 2  => 0.2348008386,
										pk_out_st_division_lvl = 3  => 0.2574605032,
										pk_out_st_division_lvl = 4  => 0.2175925926,
										pk_out_st_division_lvl = 5  => 0.1880668258,
										pk_out_st_division_lvl = 6  => 0.2164987645,
										pk_out_st_division_lvl = 7  => 0.2519582245,
																	   0.186440678);

	pk_impulse_count_mm_b3 := if(pk_impulse_count_2 = 0, 0.22517317, NULL);

	pk_attr_num_nonderogs90_b_mm_b3 := map(pk_attr_num_nonderogs90_b = 0  => 0.3316831683,
										   pk_attr_num_nonderogs90_b = 1  => 0.3030044141,
										   pk_attr_num_nonderogs90_b = 2  => 0.2595573441,
										   pk_attr_num_nonderogs90_b = 3  => 0.204845815,
										   pk_attr_num_nonderogs90_b = 4  => 0.3191489362,
										   pk_attr_num_nonderogs90_b = 10 => 0.313253012,
										   pk_attr_num_nonderogs90_b = 11 => 0.2030953027,
										   pk_attr_num_nonderogs90_b = 12 => 0.1591880342,
										   pk_attr_num_nonderogs90_b = 13 => 0.1370892019,
																			 0.101010101);

	pk_ssns_per_addr2_mm_b3 := map(pk_ssns_per_addr2 = -101 => 0.2306861156,
								   pk_ssns_per_addr2 = -2   => 0.3192272309,
								   pk_ssns_per_addr2 = -1   => 0.1983240223,
								   pk_ssns_per_addr2 = 0    => 0.169212691,
								   pk_ssns_per_addr2 = 1    => 0.1819038643,
								   pk_ssns_per_addr2 = 2    => 0.1781512605,
								   pk_ssns_per_addr2 = 3    => 0.2047654505,
								   pk_ssns_per_addr2 = 4    => 0.1972642189,
								   pk_ssns_per_addr2 = 5    => 0.2161144578,
								   pk_ssns_per_addr2 = 6    => 0.2139423077,
								   pk_ssns_per_addr2 = 7    => 0.2038590604,
								   pk_ssns_per_addr2 = 8    => 0.2192540323,
								   pk_ssns_per_addr2 = 9    => 0.2309509746,
								   pk_ssns_per_addr2 = 10   => 0.2318251144,
								   pk_ssns_per_addr2 = 11   => 0.2326129666,
								   pk_ssns_per_addr2 = 12   => 0.2667627974,
								   pk_ssns_per_addr2 = 100  => 0.2313432836,
								   pk_ssns_per_addr2 = 101  => 0.2213114754,
								   pk_ssns_per_addr2 = 102  => 0.2385524372,
															   0.2651113468);

	pk_yr_add2_assess_val_yr2_mm_b3 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.2250338375,
										   pk_yr_add2_assessed_value_year2 = 0  => 0.1389830508,
										   pk_yr_add2_assessed_value_year2 = 1  => 0.2300184362,
																				   0.2175675676);

	pk_yr_add1_date_first_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add1_date_first_seen2_mm_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_add1_date_first_seen2_mm_b2,
																			 pk_yr_add1_date_first_seen2_mm_b3);

	pk_add2_style_code_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_style_code_level_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add2_style_code_level_mm_b2,
																		  pk_add2_style_code_level_mm_b3);

	pk_add1_mortgage_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_mortgage_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_mortgage_amount2_mm_b2,
																		  pk_add1_mortgage_amount2_mm_b3);

	pk_nameperssn_count_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_nameperssn_count_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_nameperssn_count_mm_b2,
																	 pk_nameperssn_count_mm_b3);

	pk_add1_purchase_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_purchase_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_purchase_amount2_mm_b2,
																		  pk_add1_purchase_amount2_mm_b3);

	pk_adls_per_phone_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_adls_per_phone_mm_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_adls_per_phone_mm_b2,
																   pk_adls_per_phone_mm_b3);

	pk_ssns_per_addr2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssns_per_addr2_mm_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_ssns_per_addr2_mm_b2,
																   pk_ssns_per_addr2_mm_b3);

	pk_property_owned_total_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_property_owned_total_mm_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_property_owned_total_mm_b2,
																		 pk_property_owned_total_mm_b3);

	pk_ams_class_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ams_class_level_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_ams_class_level_mm_b2,
																	pk_ams_class_level_mm_b3);

	pk_adls_per_phone_c6_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_adls_per_phone_c6_mm_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_adls_per_phone_c6_mm_b2,
																	  pk_adls_per_phone_c6_mm_b3);

	pk_yr_attr_dt_l_eviction2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_attr_dt_l_eviction2_mm_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_yr_attr_dt_l_eviction2_mm_b2,
																		   pk_yr_attr_dt_l_eviction2_mm_b3);

	pk_yr_add2_date_first_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add2_date_first_seen2_mm_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_add2_date_first_seen2_mm_b2,
																			 pk_yr_add2_date_first_seen2_mm_b3);

	pk_adlperssn_count_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_adlperssn_count_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_adlperssn_count_mm_b2,
																	pk_adlperssn_count_mm_b3);

	pk2_add2_avm_hed_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add2_avm_hed_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk2_add2_avm_hed_mm_b2,
																  pk2_add2_avm_hed_mm_b3);

	pk_yr_add3_date_first_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add3_date_first_seen2_mm_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_yr_add3_date_first_seen2_mm_b2,
																			 pk_yr_add3_date_first_seen2_mm_b3);

	pk_add2_avm_auto_diff3_lvl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_avm_auto_diff3_lvl_mm_b1,
										 pk_segment3_2 = '1 Derog-Other' => pk_add2_avm_auto_diff3_lvl_mm_b2,
																			pk_add2_avm_auto_diff3_lvl_mm_b3);

	pk_addrs_sourced_lvl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_addrs_sourced_lvl_mm_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_addrs_sourced_lvl_mm_b2,
																	  pk_addrs_sourced_lvl_mm_b3);

	pk_add_lres_month_avg2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add_lres_month_avg2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_add_lres_month_avg2_mm_b2,
																		pk_add_lres_month_avg2_mm_b3);

	pk_add1_lres_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_lres_mm_b1,
						   pk_segment3_2 = '1 Derog-Other' => pk_add1_lres_mm_b2,
															  pk_add1_lres_mm_b3);

	pk_attr_total_number_derogs_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_attr_total_number_derogs_mm_b1,
										  pk_segment3_2 = '1 Derog-Other' => pk_attr_total_number_derogs_mm_b2,
																			 pk_attr_total_number_derogs_mm_b3);

	pk_addrs_per_adl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_addrs_per_adl_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_addrs_per_adl_mm_b2,
																  pk_addrs_per_adl_mm_b3);

	pk_naprop_level2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_naprop_level2_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_naprop_level2_mm_b2,
																  pk_naprop_level2_mm_b3);

	pk2_add1_avm_auto3_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_auto3_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_auto3_mm_b2,
																	pk2_add1_avm_auto3_mm_b3);

	pk_yr_reported_dob2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_reported_dob2_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_yr_reported_dob2_mm_b2,
																	 pk_yr_reported_dob2_mm_b3);

	pk_college_tier_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_college_tier_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_college_tier_mm_b2,
																 pk_college_tier_mm_b3);

	pk_ssns_per_adl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssns_per_adl_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_ssns_per_adl_mm_b2,
																 pk_ssns_per_adl_mm_b3);

	pk_yr_adl_w_last_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_w_last_seen2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_w_last_seen2_mm_b2,
																		pk_yr_adl_w_last_seen2_mm_b3);

	pk_ams_income_level_code_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ams_income_level_code_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_ams_income_level_code_mm_b2,
																		  pk_ams_income_level_code_mm_b3);

	pk_yr_ln_unrel_ot_f_sn2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_ln_unrel_ot_f_sn2_mm_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_yr_ln_unrel_ot_f_sn2_mm_b2,
																		 pk_yr_ln_unrel_ot_f_sn2_mm_b3);

	pk_add1_building_area2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_building_area2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_add1_building_area2_mm_b2,
																		pk_add1_building_area2_mm_b3);

	pk_yr_add3_date_last_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add3_date_last_seen2_mm_b1,
										 pk_segment3_2 = '1 Derog-Other' => pk_yr_add3_date_last_seen2_mm_b2,
																			pk_yr_add3_date_last_seen2_mm_b3);

	pk_pr_count_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_pr_count_mm_b1,
						  pk_segment3_2 = '1 Derog-Other' => pk_pr_count_mm_b2,
															 pk_pr_count_mm_b3);

	pk2_add1_avm_as_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_as_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_as_mm_b2,
																 pk2_add1_avm_as_mm_b3);

	pk_inferred_age_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_inferred_age_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_inferred_age_mm_b2,
																 pk_inferred_age_mm_b3);

	pk_out_st_division_lvl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_out_st_division_lvl_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_out_st_division_lvl_mm_b2,
																		pk_out_st_division_lvl_mm_b3);

	pk_yr_rc_ssnhighissue2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_rc_ssnhighissue2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_yr_rc_ssnhighissue2_mm_b2,
																		pk_yr_rc_ssnhighissue2_mm_b3);

	pk_prop1_prev_purchase_price2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_prop1_prev_purchase_price2_mm_b1,
											pk_segment3_2 = '1 Derog-Other' => pk_prop1_prev_purchase_price2_mm_b2,
																			   pk_prop1_prev_purchase_price2_mm_b3);

	pk_add2_purchase_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_purchase_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add2_purchase_amount2_mm_b2,
																		  pk_add2_purchase_amount2_mm_b3);

	pk_add2_building_area2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_building_area2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_add2_building_area2_mm_b2,
																		pk_add2_building_area2_mm_b3);

	pk_phones_per_adl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_phones_per_adl_mm_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_phones_per_adl_mm_b2,
																   pk_phones_per_adl_mm_b3);

	pk_add1_no_of_rooms_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_no_of_rooms_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_add1_no_of_rooms_mm_b2,
																	 pk_add1_no_of_rooms_mm_b3);

	pk2_add1_avm_auto2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_auto2_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_auto2_mm_b2,
																	pk2_add1_avm_auto2_mm_b3);

	pk_addrs_10yr_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_addrs_10yr_mm_b1,
							pk_segment3_2 = '1 Derog-Other' => pk_addrs_10yr_mm_b2,
															   pk_addrs_10yr_mm_b3);

	pk_ssns_per_addr_c6_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssns_per_addr_c6_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_ssns_per_addr_c6_mm_b2,
																	 pk_ssns_per_addr_c6_mm_b3);

	pk_add3_purchase_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add3_purchase_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add3_purchase_amount2_mm_b2,
																		  pk_add3_purchase_amount2_mm_b3);

	pk_yr_ln_unrel_lt_f_sn2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_ln_unrel_lt_f_sn2_mm_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_yr_ln_unrel_lt_f_sn2_mm_b2,
																		 pk_yr_ln_unrel_lt_f_sn2_mm_b3);

	pk_yr_add2_assess_val_yr2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add2_assess_val_yr2_mm_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_yr_add2_assess_val_yr2_mm_b2,
																		   pk_yr_add2_assess_val_yr2_mm_b3);

	pk_pl_sourced_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_pl_sourced_level_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_pl_sourced_level_mm_b2,
																	 pk_pl_sourced_level_mm_b3);

	pk_add2_assessed_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_assessed_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add2_assessed_amount2_mm_b2,
																		  pk_add2_assessed_amount2_mm_b3);

	pk_prof_lic_cat_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_prof_lic_cat_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk_prof_lic_cat_mm_b2,
																 pk_prof_lic_cat_mm_b3);

	pk_dist_a1toa3_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_dist_a1toa3_mm_b1,
							 pk_segment3_2 = '1 Derog-Other' => pk_dist_a1toa3_mm_b2,
																pk_dist_a1toa3_mm_b3);

	pk_eviction_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_eviction_level_mm_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_eviction_level_mm_b2,
																   pk_eviction_level_mm_b3);

	pk_attr_num_nonderogs90_b_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_attr_num_nonderogs90_b_mm_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_attr_num_nonderogs90_b_mm_b2,
																		   pk_attr_num_nonderogs90_b_mm_b3);

	pk_adls_per_addr_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_adls_per_addr_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_adls_per_addr_mm_b2,
																  pk_adls_per_addr_mm_b3);

	pk_ssns_per_adl_c6_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ssns_per_adl_c6_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_ssns_per_adl_c6_mm_b2,
																	pk_ssns_per_adl_c6_mm_b3);

	pk_attr_addrs_last24_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_attr_addrs_last24_mm_b1,
								   pk_segment3_2 = '1 Derog-Other' => pk_attr_addrs_last24_mm_b2,
																	  pk_attr_addrs_last24_mm_b3);

	pk_yr_add2_date_last_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add2_date_last_seen2_mm_b1,
										 pk_segment3_2 = '1 Derog-Other' => pk_yr_add2_date_last_seen2_mm_b2,
																			pk_yr_add2_date_last_seen2_mm_b3);

	pk_add3_mortgage_risk_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add3_mortgage_risk_mm_b1,
									pk_segment3_2 = '1 Derog-Other' => pk_add3_mortgage_risk_mm_b2,
																	   pk_add3_mortgage_risk_mm_b3);

	pk2_add1_avm_sp_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_sp_mm_b1,
							  pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_sp_mm_b2,
																 pk2_add1_avm_sp_mm_b3);

	pk2_add1_avm_med_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_med_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_med_mm_b2,
																  pk2_add1_avm_med_mm_b3);

	pk_add2_no_of_rooms_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_no_of_rooms_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_add2_no_of_rooms_mm_b2,
																	 pk_add2_no_of_rooms_mm_b3);

	pk_impulse_count_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_impulse_count_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_impulse_count_mm_b2,
																  pk_impulse_count_mm_b3);

	pk_add2_no_of_buildings_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_no_of_buildings_mm_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_add2_no_of_buildings_mm_b2,
																		 pk_add2_no_of_buildings_mm_b3);

	pk_yr_add1_mortgage_date2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add1_mortgage_date2_mm_b1,
										pk_segment3_2 = '1 Derog-Other' => pk_yr_add1_mortgage_date2_mm_b2,
																		   pk_yr_add1_mortgage_date2_mm_b3);

	pk_crime_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_crime_level_mm_b1,
							 pk_segment3_2 = '1 Derog-Other' => pk_crime_level_mm_b2,
																pk_crime_level_mm_b3);

	pk_yr_in_dob2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_in_dob2_mm_b1,
							pk_segment3_2 = '1 Derog-Other' => pk_yr_in_dob2_mm_b2,
															   pk_yr_in_dob2_mm_b3);

	pk_addrs_15yr_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_addrs_15yr_mm_b1,
							pk_segment3_2 = '1 Derog-Other' => pk_addrs_15yr_mm_b2,
															   pk_addrs_15yr_mm_b3);

	pk_add1_garage_type_risk_lvl_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_garage_type_risk_lvl_mm_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_add1_garage_type_risk_lvl_mm_b2,
																			  pk_add1_garage_type_risk_lvl_mm_b3);

	pk_avm_hit_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_avm_hit_level_mm_b1,
							   pk_segment3_2 = '1 Derog-Other' => pk_avm_hit_level_mm_b2,
																  pk_avm_hit_level_mm_b3);

	pk_bk_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_bk_level_mm_b1,
						  pk_segment3_2 = '1 Derog-Other' => pk_bk_level_mm_b2,
															 pk_bk_level_mm_b3);

	pk2_add1_avm_to_med_ratio_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add1_avm_to_med_ratio_mm_b1,
										pk_segment3_2 = '1 Derog-Other' => pk2_add1_avm_to_med_ratio_mm_b2,
																		   pk2_add1_avm_to_med_ratio_mm_b3);

	pk_yr_adl_pr_first_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_pr_first_seen2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_pr_first_seen2_mm_b2,
																		  pk_yr_adl_pr_first_seen2_mm_b3);

	pk_add1_assessed_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_assessed_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_assessed_amount2_mm_b2,
																		  pk_add1_assessed_amount2_mm_b3);

	pk_add1_style_code_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_style_code_level_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add1_style_code_level_mm_b2,
																		  pk_add1_style_code_level_mm_b3);

	pk_add3_lres_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add3_lres_mm_b1,
						   pk_segment3_2 = '1 Derog-Other' => pk_add3_lres_mm_b2,
															  pk_add3_lres_mm_b3);

	pk_ams_age_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_ams_age_mm_b1,
						 pk_segment3_2 = '1 Derog-Other' => pk_ams_age_mm_b2,
															pk_ams_age_mm_b3);

	pk_estimated_income_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_estimated_income_mm_b1,
								  pk_segment3_2 = '1 Derog-Other' => pk_estimated_income_mm_b2,
																	 pk_estimated_income_mm_b3);

	pk_yr_adl_w_first_seen2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_adl_w_first_seen2_mm_b1,
									  pk_segment3_2 = '1 Derog-Other' => pk_yr_adl_w_first_seen2_mm_b2,
																		 pk_yr_adl_w_first_seen2_mm_b3);

	pk_add2_mortgage_risk_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add2_mortgage_risk_mm_b1,
									pk_segment3_2 = '1 Derog-Other' => pk_add2_mortgage_risk_mm_b2,
																	   pk_add2_mortgage_risk_mm_b3);

	pk_dist_a1toa2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_dist_a1toa2_mm_b1,
							 pk_segment3_2 = '1 Derog-Other' => pk_dist_a1toa2_mm_b2,
																pk_dist_a1toa2_mm_b3);

	pk_add1_own_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add1_own_level_mm_b1,
								pk_segment3_2 = '1 Derog-Other' => pk_add1_own_level_mm_b2,
																   pk_add1_own_level_mm_b3);

	pk_add3_assessed_amount2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_add3_assessed_amount2_mm_b1,
									   pk_segment3_2 = '1 Derog-Other' => pk_add3_assessed_amount2_mm_b2,
																		  pk_add3_assessed_amount2_mm_b3);

	pk_yr_add1_built_date2_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_add1_built_date2_mm_b1,
									 pk_segment3_2 = '1 Derog-Other' => pk_yr_add1_built_date2_mm_b2,
																		pk_yr_add1_built_date2_mm_b3);

	pk_addrs_5yr_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_addrs_5yr_mm_b1,
						   pk_segment3_2 = '1 Derog-Other' => pk_addrs_5yr_mm_b2,
															  pk_addrs_5yr_mm_b3);

	pk_lien_type_level_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_lien_type_level_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk_lien_type_level_mm_b2,
																	pk_lien_type_level_mm_b3);

	pk2_add2_avm_auto3_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk2_add2_avm_auto3_mm_b1,
								 pk_segment3_2 = '1 Derog-Other' => pk2_add2_avm_auto3_mm_b2,
																	pk2_add2_avm_auto3_mm_b3);

	pk_yr_liens_last_unrel_date3_mm := map(pk_segment3_2 = '0 Derog-Owner' => pk_yr_liens_last_unrel_date3_mm_b1,
										   pk_segment3_2 = '1 Derog-Other' => pk_yr_liens_last_unrel_date3_mm_b2,
																			  pk_yr_liens_last_unrel_date3_mm_b3);

	segment_mean :=  map(pk_segment3_2 = '0 Derog-Owner' => (5271 / 26001),
						 pk_segment3_2 = '1 Derog-Other' => (15098 / 52372),
															(6469 / 28729));

	pk_add_lres_month_avg2_mm_2 :=  if(pk_add_lres_month_avg2_mm = NULL, segment_mean, pk_add_lres_month_avg2_mm);

	pk_add1_address_score_mm_2 :=  if(pk_add1_address_score_mm = NULL, segment_mean, pk_add1_address_score_mm);

	pk_add1_assessed_amount2_mm_2 :=  if(pk_add1_assessed_amount2_mm = NULL, segment_mean, pk_add1_assessed_amount2_mm);

	pk_add1_building_area2_mm_2 :=  if(pk_add1_building_area2_mm = NULL, segment_mean, pk_add1_building_area2_mm);

	pk_add1_garage_type_risk_lvl_mm_2 :=  if(pk_add1_garage_type_risk_lvl_mm = NULL, segment_mean, pk_add1_garage_type_risk_lvl_mm);

	pk_add1_lres_mm_2 :=  if(pk_add1_lres_mm = NULL, segment_mean, pk_add1_lres_mm);

	pk_add1_mortgage_amount2_mm_2 :=  if(pk_add1_mortgage_amount2_mm = NULL, segment_mean, pk_add1_mortgage_amount2_mm);

	pk_add1_no_of_rooms_mm_2 :=  if(pk_add1_no_of_rooms_mm = NULL, segment_mean, pk_add1_no_of_rooms_mm);

	pk_add1_own_level_mm_2 :=  if(pk_add1_own_level_mm = NULL, segment_mean, pk_add1_own_level_mm);

	pk_add1_purchase_amount2_mm_2 :=  if(pk_add1_purchase_amount2_mm = NULL, segment_mean, pk_add1_purchase_amount2_mm);

	pk_add1_style_code_level_mm_2 :=  if(pk_add1_style_code_level_mm = NULL, segment_mean, pk_add1_style_code_level_mm);

	pk_add2_address_score_mm_2 :=  if(pk_add2_address_score_mm = NULL, segment_mean, pk_add2_address_score_mm);

	pk_add2_assessed_amount2_mm_2 :=  if(pk_add2_assessed_amount2_mm = NULL, segment_mean, pk_add2_assessed_amount2_mm);

	pk_add2_avm_auto_diff3_lvl_mm_2 :=  if(pk_add2_avm_auto_diff3_lvl_mm = NULL, segment_mean, pk_add2_avm_auto_diff3_lvl_mm);

	pk_add2_building_area2_mm_2 :=  if(pk_add2_building_area2_mm = NULL, segment_mean, pk_add2_building_area2_mm);

	pk_add2_em_ver_lvl_mm_2 :=  if(pk_add2_em_ver_lvl_mm = NULL, segment_mean, pk_add2_em_ver_lvl_mm);

	pk_add2_mortgage_risk_mm_2 :=  if(pk_add2_mortgage_risk_mm = NULL, segment_mean, pk_add2_mortgage_risk_mm);

	pk_add2_no_of_buildings_mm_2 :=  if(pk_add2_no_of_buildings_mm = NULL, segment_mean, pk_add2_no_of_buildings_mm);

	pk_add2_no_of_rooms_mm_2 :=  if(pk_add2_no_of_rooms_mm = NULL, segment_mean, pk_add2_no_of_rooms_mm);

	pk_add2_pos_sources_mm_2 :=  if(pk_add2_pos_sources_mm = NULL, segment_mean, pk_add2_pos_sources_mm);

	pk_add2_purchase_amount2_mm_2 :=  if(pk_add2_purchase_amount2_mm = NULL, segment_mean, pk_add2_purchase_amount2_mm);

	pk_add2_style_code_level_mm_2 :=  if(pk_add2_style_code_level_mm = NULL, segment_mean, pk_add2_style_code_level_mm);

	pk_add3_assessed_amount2_mm_2 :=  if(pk_add3_assessed_amount2_mm = NULL, segment_mean, pk_add3_assessed_amount2_mm);

	pk_add3_lres_mm_2 :=  if(pk_add3_lres_mm = NULL, segment_mean, pk_add3_lres_mm);

	pk_add3_mortgage_risk_mm_2 :=  if(pk_add3_mortgage_risk_mm = NULL, segment_mean, pk_add3_mortgage_risk_mm);

	pk_add3_purchase_amount2_mm_2 :=  if(pk_add3_purchase_amount2_mm = NULL, segment_mean, pk_add3_purchase_amount2_mm);

	pk_addrs_10yr_mm_2 :=  if(pk_addrs_10yr_mm = NULL, segment_mean, pk_addrs_10yr_mm);

	pk_addrs_15yr_mm_2 :=  if(pk_addrs_15yr_mm = NULL, segment_mean, pk_addrs_15yr_mm);

	pk_addrs_5yr_mm_2 :=  if(pk_addrs_5yr_mm = NULL, segment_mean, pk_addrs_5yr_mm);

	pk_addrs_per_adl_mm_2 :=  if(pk_addrs_per_adl_mm = NULL, segment_mean, pk_addrs_per_adl_mm);

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

	pk_attr_num_nonderogs90_b_mm_2 :=  if(pk_attr_num_nonderogs90_b_mm = NULL, segment_mean, pk_attr_num_nonderogs90_b_mm);

	pk_attr_total_number_derogs_mm_2 :=  if(pk_attr_total_number_derogs_mm = NULL, segment_mean, pk_attr_total_number_derogs_mm);

	pk_avm_hit_level_mm_2 :=  if(pk_avm_hit_level_mm = NULL, segment_mean, pk_avm_hit_level_mm);

	pk_bk_level_mm_2 :=  if(pk_bk_level_mm = NULL, segment_mean, pk_bk_level_mm);

	pk_college_tier_mm_2 :=  if(pk_college_tier_mm = NULL, segment_mean, pk_college_tier_mm);

	pk_combo_addrcount_nb_mm_2 :=  if(pk_combo_addrcount_nb_mm = NULL, segment_mean, pk_combo_addrcount_nb_mm);

	pk_combo_dobcount_mm_2 :=  if(pk_combo_dobcount_mm = NULL, segment_mean, pk_combo_dobcount_mm);

	pk_combo_dobcount_nb_mm_2 :=  if(pk_combo_dobcount_nb_mm = NULL, segment_mean, pk_combo_dobcount_nb_mm);

	pk_combo_dobscore_mm_2 :=  if(pk_combo_dobscore_mm = NULL, segment_mean, pk_combo_dobscore_mm);

	pk_combo_fnamecount_mm_2 :=  if(pk_combo_fnamecount_mm = NULL, segment_mean, pk_combo_fnamecount_mm);

	pk_combo_fnamecount_nb_mm_2 :=  if(pk_combo_fnamecount_nb_mm = NULL, segment_mean, pk_combo_fnamecount_nb_mm);

	pk_combo_hphonescore_mm_2 :=  if(pk_combo_hphonescore_mm = NULL, segment_mean, pk_combo_hphonescore_mm);

	pk_combo_ssncount_mm_2 :=  if(pk_combo_ssncount_mm = NULL, segment_mean, pk_combo_ssncount_mm);

	pk_combo_ssnscore_mm_2 :=  if(pk_combo_ssnscore_mm = NULL, segment_mean, pk_combo_ssnscore_mm);

	pk_crime_level_mm_2 :=  if(pk_crime_level_mm = NULL, segment_mean, pk_crime_level_mm);

	pk_dist_a1toa2_mm_2 :=  if(pk_dist_a1toa2_mm = NULL, segment_mean, pk_dist_a1toa2_mm);

	pk_dist_a1toa3_mm_2 :=  if(pk_dist_a1toa3_mm = NULL, segment_mean, pk_dist_a1toa3_mm);

	pk_eq_count_mm_2 :=  if(pk_eq_count_mm = NULL, segment_mean, pk_eq_count_mm);

	pk_estimated_income_mm_2 :=  if(pk_estimated_income_mm = NULL, segment_mean, pk_estimated_income_mm);

	pk_eviction_level_mm_2 :=  if(pk_eviction_level_mm = NULL, segment_mean, pk_eviction_level_mm);

	pk_fname_eda_sourced_type_lvl_mm_2 :=  if(pk_fname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_fname_eda_sourced_type_lvl_mm);

	pk_gong_did_phone_ct_mm_2 :=  if(pk_gong_did_phone_ct_mm = NULL, segment_mean, pk_gong_did_phone_ct_mm);

	pk_gong_did_phone_ct_nb_mm_2 :=  if(pk_gong_did_phone_ct_nb_mm = NULL, segment_mean, pk_gong_did_phone_ct_nb_mm);

	pk_impulse_count_mm_2 :=  if(pk_impulse_count_mm = NULL, segment_mean, pk_impulse_count_mm);

	pk_inferred_age_mm_2 :=  if(pk_inferred_age_mm = NULL, segment_mean, pk_inferred_age_mm);

	pk_infutor_risk_lvl_mm_2 :=  if(pk_infutor_risk_lvl_mm = NULL, segment_mean, pk_infutor_risk_lvl_mm);

	pk_infutor_risk_lvl_nb_mm_2 :=  if(pk_infutor_risk_lvl_nb_mm = NULL, segment_mean, pk_infutor_risk_lvl_nb_mm);

	pk_lien_type_level_mm_2 :=  if(pk_lien_type_level_mm = NULL, segment_mean, pk_lien_type_level_mm);

	pk_lname_eda_sourced_type_lvl_mm_2 :=  if(pk_lname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_lname_eda_sourced_type_lvl_mm);

	pk_nameperssn_count_mm_2 :=  if(pk_nameperssn_count_mm = NULL, segment_mean, pk_nameperssn_count_mm);

	pk_nap_summary_mm_2 :=  if(pk_nap_summary_mm = NULL, segment_mean, pk_nap_summary_mm);

	pk_naprop_level2_mm_2 :=  if(pk_naprop_level2_mm = NULL, segment_mean, pk_naprop_level2_mm);

	pk_nas_summary_mm_2 :=  if(pk_nas_summary_mm = NULL, segment_mean, pk_nas_summary_mm);

	pk_out_st_division_lvl_mm_2 :=  if(pk_out_st_division_lvl_mm = NULL, segment_mean, pk_out_st_division_lvl_mm);

	pk_phones_per_adl_mm_2 :=  if(pk_phones_per_adl_mm = NULL, segment_mean, pk_phones_per_adl_mm);

	pk_pl_sourced_level_mm_2 :=  if(pk_pl_sourced_level_mm = NULL, segment_mean, pk_pl_sourced_level_mm);

	pk_pos_secondary_sources_mm_2 :=  if(pk_pos_secondary_sources_mm = NULL, segment_mean, pk_pos_secondary_sources_mm);

	pk_pr_count_mm_2 :=  if(pk_pr_count_mm = NULL, segment_mean, pk_pr_count_mm);

	pk_prof_lic_cat_mm_2 :=  if(pk_prof_lic_cat_mm = NULL, segment_mean, pk_prof_lic_cat_mm);

	pk_prop1_prev_purchase_price2_mm_2 :=  if(pk_prop1_prev_purchase_price2_mm = NULL, segment_mean, pk_prop1_prev_purchase_price2_mm);

	pk_property_owned_total_mm_2 :=  if(pk_property_owned_total_mm = NULL, segment_mean, pk_property_owned_total_mm);

	pk_rc_addrcount_mm_2 :=  if(pk_rc_addrcount_mm = NULL, segment_mean, pk_rc_addrcount_mm);

	pk_rc_addrcount_nb_mm_2 :=  if(pk_rc_addrcount_nb_mm = NULL, segment_mean, pk_rc_addrcount_nb_mm);

	pk_rc_dirsaddr_lastscore_mm_2 :=  if(pk_rc_dirsaddr_lastscore_mm = NULL, segment_mean, pk_rc_dirsaddr_lastscore_mm);

	pk_rc_phonelnamecount_mm_2 :=  if(pk_rc_phonelnamecount_mm = NULL, segment_mean, pk_rc_phonelnamecount_mm);

	pk_rc_phonephonecount_mm_2 :=  if(pk_rc_phonephonecount_mm = NULL, segment_mean, pk_rc_phonephonecount_mm);

	pk_ssnchar_invalid_or_recent_mm_2 :=  if(pk_ssnchar_invalid_or_recent_mm = NULL, segment_mean, pk_ssnchar_invalid_or_recent_mm);

	pk_ssns_per_addr_c6_mm_2 :=  if(pk_ssns_per_addr_c6_mm = NULL, segment_mean, pk_ssns_per_addr_c6_mm);

	pk_ssns_per_addr2_mm_2 :=  if(pk_ssns_per_addr2_mm = NULL, segment_mean, pk_ssns_per_addr2_mm);

	pk_ssns_per_adl_c6_mm_2 :=  if(pk_ssns_per_adl_c6_mm = NULL, segment_mean, pk_ssns_per_adl_c6_mm);

	pk_ssns_per_adl_mm_2 :=  if(pk_ssns_per_adl_mm = NULL, segment_mean, pk_ssns_per_adl_mm);

	pk_ver_phncount_mm_2 :=  if(pk_ver_phncount_mm = NULL, segment_mean, pk_ver_phncount_mm);

	pk_voter_flag_mm_2 :=  if(pk_voter_flag_mm = NULL, segment_mean, pk_voter_flag_mm);

	pk_yr_add1_built_date2_mm_2 :=  if(pk_yr_add1_built_date2_mm = NULL, segment_mean, pk_yr_add1_built_date2_mm);

	pk_yr_add1_date_first_seen2_mm_2 :=  if(pk_yr_add1_date_first_seen2_mm = NULL, segment_mean, pk_yr_add1_date_first_seen2_mm);

	pk_yr_add1_mortgage_date2_mm_2 :=  if(pk_yr_add1_mortgage_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_date2_mm);

	pk_yr_add2_assess_val_yr2_mm_2 :=  if(pk_yr_add2_assess_val_yr2_mm = NULL, segment_mean, pk_yr_add2_assess_val_yr2_mm);

	pk_yr_add2_date_first_seen2_mm_2 :=  if(pk_yr_add2_date_first_seen2_mm = NULL, segment_mean, pk_yr_add2_date_first_seen2_mm);

	pk_yr_add2_date_last_seen2_mm_2 :=  if(pk_yr_add2_date_last_seen2_mm = NULL, segment_mean, pk_yr_add2_date_last_seen2_mm);

	pk_yr_add3_date_first_seen2_mm_2 :=  if(pk_yr_add3_date_first_seen2_mm = NULL, segment_mean, pk_yr_add3_date_first_seen2_mm);

	pk_yr_add3_date_last_seen2_mm_2 :=  if(pk_yr_add3_date_last_seen2_mm = NULL, segment_mean, pk_yr_add3_date_last_seen2_mm);

	pk_yr_adl_em_first_seen2_mm_2 :=  if(pk_yr_adl_em_first_seen2_mm = NULL, segment_mean, pk_yr_adl_em_first_seen2_mm);

	pk_yr_adl_em_only_first_seen2_mm_2 :=  if(pk_yr_adl_em_only_first_seen2_mm = NULL, segment_mean, pk_yr_adl_em_only_first_seen2_mm);

	pk_yr_adl_pr_first_seen2_mm_2 :=  if(pk_yr_adl_pr_first_seen2_mm = NULL, segment_mean, pk_yr_adl_pr_first_seen2_mm);

	pk_yr_adl_vo_first_seen2_mm_2 :=  if(pk_yr_adl_vo_first_seen2_mm = NULL, segment_mean, pk_yr_adl_vo_first_seen2_mm);

	pk_yr_adl_w_first_seen2_mm_2 :=  if(pk_yr_adl_w_first_seen2_mm = NULL, segment_mean, pk_yr_adl_w_first_seen2_mm);

	pk_yr_adl_w_last_seen2_mm_2 :=  if(pk_yr_adl_w_last_seen2_mm = NULL, segment_mean, pk_yr_adl_w_last_seen2_mm);

	pk_yr_attr_dt_l_eviction2_mm_2 :=  if(pk_yr_attr_dt_l_eviction2_mm = NULL, segment_mean, pk_yr_attr_dt_l_eviction2_mm);

	pk_yr_credit_first_seen2_mm_2 :=  if(pk_yr_credit_first_seen2_mm = NULL, segment_mean, pk_yr_credit_first_seen2_mm);

	pk_yr_gong_did_first_seen2_mm_2 :=  if(pk_yr_gong_did_first_seen2_mm = NULL, segment_mean, pk_yr_gong_did_first_seen2_mm);

	pk_yr_header_first_seen2_mm_2 :=  if(pk_yr_header_first_seen2_mm = NULL, segment_mean, pk_yr_header_first_seen2_mm);

	pk_yr_in_dob2_mm_2 :=  if(pk_yr_in_dob2_mm = NULL, segment_mean, pk_yr_in_dob2_mm);

	pk_yr_infutor_first_seen2_mm_2 :=  if(pk_yr_infutor_first_seen2_mm = NULL, segment_mean, pk_yr_infutor_first_seen2_mm);

	pk_yr_liens_last_unrel_date3_mm_2 :=  if(pk_yr_liens_last_unrel_date3_mm = NULL, segment_mean, pk_yr_liens_last_unrel_date3_mm);

	pk_yr_ln_unrel_lt_f_sn2_mm_2 :=  if(pk_yr_ln_unrel_lt_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_lt_f_sn2_mm);

	pk_yr_ln_unrel_ot_f_sn2_mm_2 :=  if(pk_yr_ln_unrel_ot_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_ot_f_sn2_mm);

	pk_yr_lname_change_date2_mm_2 :=  if(pk_yr_lname_change_date2_mm = NULL, segment_mean, pk_yr_lname_change_date2_mm);

	pk_yr_rc_ssnhighissue2_mm_2 :=  if(pk_yr_rc_ssnhighissue2_mm = NULL, segment_mean, pk_yr_rc_ssnhighissue2_mm);

	pk_yr_reported_dob2_mm_2 :=  if(pk_yr_reported_dob2_mm = NULL, segment_mean, pk_yr_reported_dob2_mm);

	pk_yrmo_adl_f_sn_mx_fcra2_mm_2 :=  if(pk_yrmo_adl_f_sn_mx_fcra2_mm = NULL, segment_mean, pk_yrmo_adl_f_sn_mx_fcra2_mm);

	pk2_add1_avm_as_mm_2 :=  if(pk2_add1_avm_as_mm = NULL, segment_mean, pk2_add1_avm_as_mm);

	pk2_add1_avm_auto2_mm_2 :=  if(pk2_add1_avm_auto2_mm = NULL, segment_mean, pk2_add1_avm_auto2_mm);

	pk2_add1_avm_auto3_mm_2 :=  if(pk2_add1_avm_auto3_mm = NULL, segment_mean, pk2_add1_avm_auto3_mm);

	pk2_add1_avm_med_mm_2 :=  if(pk2_add1_avm_med_mm = NULL, segment_mean, pk2_add1_avm_med_mm);

	pk2_add1_avm_sp_mm_2 :=  if(pk2_add1_avm_sp_mm = NULL, segment_mean, pk2_add1_avm_sp_mm);

	pk2_add1_avm_to_med_ratio_mm_2 :=  if(pk2_add1_avm_to_med_ratio_mm = NULL, segment_mean, pk2_add1_avm_to_med_ratio_mm);

	pk2_add2_avm_auto3_mm_2 :=  if(pk2_add2_avm_auto3_mm = NULL, segment_mean, pk2_add2_avm_auto3_mm);

	pk2_add2_avm_hed_mm_2 :=  if(pk2_add2_avm_hed_mm = NULL, segment_mean, pk2_add2_avm_hed_mm);

	amstudent_mod_om_b1 := -4.29824439 +
		(pk_ams_class_level_mm_2 * 4.5917890773) +
		(pk_ams_income_level_code_mm_2 * 2.8363040749) +
		(pk_college_tier_mm_2 * 6.9872860663);

	avm_mod_om_b1 := -4.47640326 +
		(pk_avm_hit_level_mm_2 * 3.5929763258) +
		(pk2_add1_avm_sp_mm_2 * 2.8146911945) +
		(pk2_add1_avm_auto3_mm_2 * 1.9109418343) +
		(pk2_add1_avm_med_mm_2 * 3.6207308062) +
		(pk2_add2_avm_hed_mm_2 * 3.3382218844);

	derog_mod3_om_b1 := -4.819094713 +
		(pk_bk_level_mm_2 * 5.407017651) +
		(pk_crime_level_mm_2 * 4.2449837013) +
		(pk_attr_total_number_derogs_mm_2 * 3.1498523001) +
		(pk_eviction_level_mm_2 * 4.0858798247);

	lien_mod_om_b1 := -5.779408567 +
		(pk_lien_type_level_mm_2 * 3.5253586518) +
		(pk_yr_liens_last_unrel_date3_mm_2 * 3.5622604241) +
		(pk_yr_ln_unrel_lt_f_sn2_mm_2 * 1.7308895078) +
		(pk_yr_ln_unrel_ot_f_sn2_mm_2 * 12.878491866);

	property_mod_om_b1 := -19.73664629 +
		((integer)source_add3_W * 0.7874029056) +
		(pk_add1_adjustable_financing * 0.240467173) +
		(pk_attr_num_sold180 * 0.279905591) +
		(pk_attr_num_watercraft180 * 1.4449903047) +
		(pk_yr_adl_pr_first_seen2_mm_2 * 2.8445980892) +
		(pk_yr_adl_w_last_seen2_mm_2 * 26.894265247) +
		(pk_addrs_sourced_lvl_mm_2 * 2.3111847274) +
		(pk_naprop_level2_mm_2 * 1.2317431465) +
		(pk_add1_purchase_amount2_mm_2 * 2.7868448188) +
		(pk_add1_mortgage_amount2_mm_2 * 3.3745151629) +
		(pk_add1_assessed_amount2_mm_2 * 3.3805679577) +
		(pk_yr_add1_date_first_seen2_mm_2 * 3.6626658901) +
		(pk_add1_building_area2_mm_2 * 3.5394881131) +
		(pk_add1_no_of_rooms_mm_2 * 3.3203482033) +
		(pk_property_owned_total_mm_2 * 2.8891716072) +
		(pk_prop1_prev_purchase_price2_mm_2 * 4.7513361127) +
		(pk_add2_no_of_buildings_mm_2 * 6.7768286565) +
		(pk_add2_style_code_level_mm_2 * 5.6343819425) +
		(pk_yr_add2_assess_val_yr2_mm_2 * 5.9835106619) +
		(pk_yr_add2_date_last_seen2_mm_2 * 2.2444467868) +
		(pk_add3_assessed_amount2_mm_2 * 4.8873557721) +
		(pk_yr_add3_date_last_seen2_mm_2 * 3.6447156134);

	velocity2_mod_om_b1 := -9.694478524 +
		(pk_nameperssn_count_mm_2 * 4.1884849096) +
		(pk_ssns_per_adl_mm_2 * 4.0599379305) +
		(pk_addrs_per_adl_mm_2 * 5.199522681) +
		(pk_phones_per_adl_mm_2 * 4.8822018433) +
		(pk_adlperssn_count_mm_2 * 4.299425004) +
		(pk_adls_per_phone_mm_2 * 3.6560209226) +
		(pk_ssns_per_adl_c6_mm_2 * 2.4321663934) +
		(pk_ssns_per_addr_c6_mm_2 * 3.8211563199) +
		(pk_attr_addrs_last24_mm_2 * 3.1787691251) +
		(pk_ssns_per_addr2_mm_2 * 5.2528668995);

	ver_best_element_cnt_mod_om_b1 := -5.758015601 +
		(pk_combo_fnamecount_mm_2 * 0.1515466062) +
		(pk_rc_addrcount_mm_2 * 3.6616285674) +
		(pk_ver_phncount_mm_2 * 4.6336659526) +
		(pk_gong_did_phone_ct_mm_2 * 5.8074880452) +
		(pk_combo_ssncount_mm_2 * 4.8579493984) +
		(pk_combo_dobcount_mm_2 * 3.6919351419);

	ver_best_src_cnt_mod_om_b1 := -6.994646368 +
		(pk_eq_count_mm_2 * 5.1311784965) +
		(pk_voter_flag_mm_2 * 5.7834745444) +
		(pk_lname_eda_sourced_type_lvl_mm_2 * 4.3413098228) +
		(pk_infutor_risk_lvl_mm_2 * 4.2128934364) +
		(pk_nas_summary_mm_2 * 4.5387972366) +
		(pk_attr_num_nonderogs90_b_mm_2 * 5.4548041485);

	ver_best_src_time_mod_om_b1 := -7.478948095 +
		(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.5922319474) +
		(pk_yr_adl_em_first_seen2_mm_2 * 9.0061449347) +
		(pk_yr_gong_did_first_seen2_mm_2 * 3.81781703) +
		(pk_yr_header_first_seen2_mm_2 * 2.6433067865) +
		(pk_yr_infutor_first_seen2_mm_2 * 5.9140215224) +
		(pk_yr_lname_change_date2_mm_2 * 6.0564892732);

	ver_notbest_element_cnt_mod_om_b1 := -5.682667455 +
		(pk_combo_addrcount_nb_mm_2 * 5.4630961767) +
		(pk_gong_did_phone_ct_nb_mm_2 * 5.7754206095) +
		(pk_combo_ssncount_mm_2 * 3.548864238) +
		(pk_combo_dobcount_nb_mm_2 * 3.564790718);

	ver_notbest_src_cnt_mod_om_b1 := -6.665131853 +
		((integer)add3_source_E1 * 0.6927240921) +
		(pk_eq_count_mm_2 * 3.371457195) +
		(pk_pos_secondary_sources_mm_2 * 4.5493780157) +
		(pk_fname_eda_sourced_type_lvl_mm_2 * 3.568340164) +
		(pk_infutor_risk_lvl_nb_mm_2 * 4.6086751676) +
		(pk_nas_summary_mm_2 * 2.6658672424) +
		(pk_attr_num_nonderogs90_b_mm_2 * 3.50703206);

	ver_notbest_src_time_mod_om_b1 := -7.696962003 +
		(pk_yr_adl_em_first_seen2_mm_2 * 4.0899387041) +
		(pk_yr_adl_vo_first_seen2_mm_2 * 4.5454534203) +
		(pk_yr_adl_em_only_first_seen2_mm_2 * 5.1700171316) +
		(pk_yr_credit_first_seen2_mm_2 * 4.402232842) +
		(pk_yr_header_first_seen2_mm_2 * 2.7654796803) +
		(pk_yr_infutor_first_seen2_mm_2 * 5.4777040868);

	ver_src_time_mod_om_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_om_b1) / (1 + exp(ver_best_src_time_mod_om_b1)))), (100 * (exp(ver_notbest_src_time_mod_om_b1) / (1 + exp(ver_notbest_src_time_mod_om_b1)))));

	ver_element_cnt_mod_om_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_om_b1) / (1 + exp(ver_best_element_cnt_mod_om_b1)))), (100 * (exp(ver_notbest_element_cnt_mod_om_b1) / (1 + exp(ver_notbest_element_cnt_mod_om_b1)))));

	ver_src_cnt_mod_om_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_om_b1) / (1 + exp(ver_best_src_cnt_mod_om_b1)))), (100 * (exp(ver_notbest_src_cnt_mod_om_b1) / (1 + exp(ver_notbest_src_cnt_mod_om_b1)))));

	mod14_om_b1 := -7.303813325 +
		(pk_impulse_count_mm_2 * 5.142854832) +
		(pk_out_st_division_lvl_mm_2 * 4.1389830214) +
		((100 * (exp(avm_mod_om_b1) / (1 + exp(avm_mod_om_b1)))) * 0.0144806099) +
		((100 * (exp(amstudent_mod_om_b1) / (1 + exp(amstudent_mod_om_b1)))) * 0.016590975) +
		((100 * (exp(velocity2_mod_om_b1) / (1 + exp(velocity2_mod_om_b1)))) * 0.0288967469) +
		((100 * (exp(derog_mod3_om_b1) / (1 + exp(derog_mod3_om_b1)))) * 0.0295582209) +
		((100 * (exp(lien_mod_om_b1) / (1 + exp(lien_mod_om_b1)))) * 0.0269761302) +
		((100 * (exp(property_mod_om_b1) / (1 + exp(property_mod_om_b1)))) * 0.0264943682) +
		(pk_estimated_income_mm_2 * 1.7045557714) +
		(ver_src_cnt_mod_om_b1 * 0.0090095346) +
		(ver_element_cnt_mod_om_b1 * 0.0092465604) +
		(ver_src_time_mod_om_b1 * 0.0171110584) +
		(pk_multi_did * 0.4794617198);

	addprob3_mod_xm_b2 := -0.939011036 +
		((integer)addrs_prison_history * 0.6510039411) +
		(invalid_addrs_per_adl_c6 * 0.5649516534) +
		(pk_addr_not_valid * 0.1473901303) +
		(pk_add_standarization_flag * 0.076418485);

	phnprob_mod_xm_b2 := -0.981624558 +
		((integer)phn_highrisk2 * 0.1228376043) +
		((integer)phn_zipmismatch * 0.1613083911) +
		(pk_area_code_split * 0.0952043985);

	ssnprob2_mod_xm_b2 := -2.271584743 +
		((integer)ssn_issued18 * -0.348295867) +
		((integer)ssn_adl_prob * 0.2684702622) +
		(pk_ssnchar_invalid_or_recent_mm_2 * 4.6912478452);

	fp_mod5_xm_b2 := -3.994322222 +
		((100 * (exp(addprob3_mod_xm_b2) / (1 + exp(addprob3_mod_xm_b2)))) * 0.0254715032) +
		((100 * (exp(phnprob_mod_xm_b2) / (1 + exp(phnprob_mod_xm_b2)))) * 0.0350068328) +
		((100 * (exp(ssnprob2_mod_xm_b2) / (1 + exp(ssnprob2_mod_xm_b2)))) * 0.0463352297);

	age_mod3_nodob_xm_b2 := -2.709048604 +
		(pk_ams_age_mm_2 * 1.1294189604) +
		(pk_inferred_age_mm_2 * 4.383158808) +
		(pk_yr_rc_ssnhighissue2_mm_2 * 0.6939368252);

	age_mod3_xm_b2 := (-2.288335004 + (pk_yr_in_dob2_mm_2 * 4.745147613));

	amstudent_mod_xm_b2 := -4.527250827 +
		(pk_ams_class_level_mm_2 * 3.6208846874) +
		(pk_ams_income_level_code_mm_2 * 3.3759218184) +
		(pk_college_tier_mm_2 * 5.5582084377);

	avm_mod_xm_b2 := -5.3438135 +
		(pk_add2_avm_auto_diff3_lvl_mm_2 * 2.9944409948) +
		(pk2_add1_avm_auto2_mm_2 * 1.8272678696) +
		(pk2_add1_avm_med_mm_2 * 4.0603952842) +
		(pk2_add1_avm_to_med_ratio_mm_2 * 4.3035166471) +
		(pk2_add2_avm_auto3_mm_2 * 2.1943000192);

	derog_mod3_xm_b2 := -5.016328065 +
		(pk_bk_level_mm_2 * 4.5215681149) +
		(pk_yr_attr_dt_l_eviction2_mm_2 * 3.7477436243) +
		(pk_crime_level_mm_2 * 3.7891445165) +
		(pk_attr_total_number_derogs_mm_2 * 2.1269688411);

	lien_mod_xm_b2 := -4.726627723 +
		(pk_lien_type_level_mm_2 * 2.6736757158) +
		(pk_yr_liens_last_unrel_date3_mm_2 * 2.9442878167) +
		(pk_yr_ln_unrel_lt_f_sn2_mm_2 * 2.0802049945) +
		(pk_yr_ln_unrel_ot_f_sn2_mm_2 * 5.5331084393);

	lres_mod_xm_b2 := -4.776910485 +
		(pk_add1_lres_mm_2 * 4.0460815191) +
		(pk_add3_lres_mm_2 * 3.7625285576) +
		(pk_addrs_5yr_mm_2 * 1.6334500318) +
		(pk_addrs_15yr_mm_2 * 1.8484645255) +
		(pk_add_lres_month_avg2_mm_2 * 2.0889244017);

	property_mod_xm_b2 := -21.62914771 +
		(pk_yr_adl_pr_first_seen2_mm_2 * 4.6905470535) +
		(pk_yr_adl_w_first_seen2_mm_2 * 4.6125860071) +
		(pk_yr_add1_built_date2_mm_2 * 3.0231960122) +
		(pk_add1_mortgage_amount2_mm_2 * 2.9403962151) +
		(pk_yr_add1_mortgage_date2_mm_2 * 3.9218017026) +
		(pk_add1_assessed_amount2_mm_2 * 2.1189736713) +
		(pk_yr_add1_date_first_seen2_mm_2 * 3.1273433158) +
		(pk_add1_building_area2_mm_2 * 2.3351487535) +
		(pk_add1_no_of_rooms_mm_2 * 3.9050028453) +
		(pk_add1_garage_type_risk_lvl_mm_2 * 3.7004239407) +
		(pk_add2_no_of_buildings_mm_2 * 3.8884271344) +
		(pk_add2_no_of_rooms_mm_2 * 3.6097439032) +
		(pk_add2_style_code_level_mm_2 * 3.8710537552) +
		(pk_yr_add2_assess_val_yr2_mm_2 * 4.9333911416) +
		(pk_add2_purchase_amount2_mm_2 * 2.4370157628) +
		(pk_add2_assessed_amount2_mm_2 * 3.1227707774) +
		(pk_yr_add2_date_first_seen2_mm_2 * 1.3787213018) +
		(pk_yr_add2_date_last_seen2_mm_2 * 1.2441162668) +
		(pk_add3_purchase_amount2_mm_2 * 2.6468300544) +
		(pk_add3_mortgage_risk_mm_2 * 3.6777437588) +
		(pk_add3_assessed_amount2_mm_2 * 2.5283401342) +
		(pk_yr_add3_date_first_seen2_mm_2 * 2.168599381) +
		(pk_yr_add3_date_last_seen2_mm_2 * 1.9152441834);

	velocity2_mod_xm_b2 := -13.3372789 +
		(pk_vo_addrs_per_adl * -0.041713487) +
		(pk_nameperssn_count_mm_2 * 2.8492077669) +
		(pk_ssns_per_adl_mm_2 * 4.1582595685) +
		(pk_addrs_per_adl_mm_2 * 7.052373057) +
		(pk_phones_per_adl_mm_2 * 2.9214011325) +
		(pk_adlperssn_count_mm_2 * 3.8218122037) +
		(pk_adls_per_addr_mm_2 * 3.9155283276) +
		(pk_adls_per_phone_mm_2 * 4.9087469609) +
		(pk_ssns_per_addr_c6_mm_2 * 3.2634938346) +
		(pk_adls_per_phone_c6_mm_2 * 5.4876443803) +
		(pk_attr_addrs_last24_mm_2 * 4.7530403793);

	ver_best_element_cnt_mod_xm_b2 := -7.217363605 +
		(pk_combo_fnamecount_mm_2 * 1.7604187356) +
		(pk_rc_phonelnamecount_mm_2 * 2.2616881906) +
		(pk_rc_addrcount_mm_2 * 2.4086931118) +
		(pk_ver_phncount_mm_2 * 3.8477288169) +
		(pk_gong_did_phone_ct_mm_2 * 6.1883427437) +
		(pk_combo_ssncount_mm_2 * 4.0296037161) +
		(pk_combo_dobcount_mm_2 * 3.4092099562);

	ver_best_src_cnt_mod_xm_b2 := -8.135886674 +
		(pk_eq_count_mm_2 * 4.4569084722) +
		(pk_pos_secondary_sources_mm_2 * 6.6011775834) +
		(pk_voter_flag_mm_2 * 4.4289507968) +
		(pk_lname_eda_sourced_type_lvl_mm_2 * 4.1796117982) +
		(pk_infutor_risk_lvl_mm_2 * 3.7246951741) +
		(pk_attr_num_nonderogs90_b_mm_2 * 4.1187801453);

	ver_best_src_time_mod_xm_b2 := -4.97902464 +
		(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.5614684575) +
		(pk_yr_gong_did_first_seen2_mm_2 * 4.027834961) +
		(pk_yr_header_first_seen2_mm_2 * 1.5743795624) +
		(pk_yr_infutor_first_seen2_mm_2 * 5.0222523934);

	ver_notbest_element_cnt_mod_xm_b2 := -17.00710167 +
		(pk_combo_fnamecount_nb_mm_2 * 1.3884074773) +
		(pk_rc_phonelnamecount_mm_2 * 8.6940526703) +
		(pk_rc_addrcount_nb_mm_2 * 3.7713853036) +
		(pk_rc_phonephonecount_mm_2 * 21.908343882) +
		(pk_gong_did_phone_ct_nb_mm_2 * 6.1949584875) +
		(pk_combo_ssncount_mm_2 * 3.3912992233) +
		(pk_combo_dobcount_nb_mm_2 * 3.1530839966);

	ver_notbest_src_cnt_mod_xm_b2 := -8.29507403 +
		(pk_eq_count_mm_2 * 3.5013653011) +
		(pk_pos_secondary_sources_mm_2 * 4.845409385) +
		(pk_infutor_risk_lvl_nb_mm_2 * 3.933432994) +
		(pk_nas_summary_mm_2 * 3.1645549936) +
		(pk_nap_summary_mm_2 * 2.6280596658) +
		(pk_add2_pos_sources_mm_2 * 2.9073267531) +
		(pk_attr_num_nonderogs90_b_mm_2 * 1.6355560104);

	ver_notbest_src_time_mod_xm_b2 := -8.229888513 +
		(pk_yr_adl_em_only_first_seen2_mm_2 * 4.2371205084) +
		(pk_yr_gong_did_first_seen2_mm_2 * 3.9124570337) +
		(pk_yr_credit_first_seen2_mm_2 * 3.8850588536) +
		(pk_yr_header_first_seen2_mm_2 * 1.7423940619) +
		(pk_yr_infutor_first_seen2_mm_2 * 4.1648271369) +
		(pk_yr_lname_change_date2_mm_2 * 4.4680054803);

	ver_element_cnt_mod_xm_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_xm_b2) / (1 + exp(ver_best_element_cnt_mod_xm_b2)))), (100 * (exp(ver_notbest_element_cnt_mod_xm_b2) / (1 + exp(ver_notbest_element_cnt_mod_xm_b2)))));

	ver_src_time_mod_xm_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_xm_b2) / (1 + exp(ver_best_src_time_mod_xm_b2)))), (100 * (exp(ver_notbest_src_time_mod_xm_b2) / (1 + exp(ver_notbest_src_time_mod_xm_b2)))));

	ver_src_cnt_mod_xm_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_xm_b2) / (1 + exp(ver_best_src_cnt_mod_xm_b2)))), (100 * (exp(ver_notbest_src_cnt_mod_xm_b2) / (1 + exp(ver_notbest_src_cnt_mod_xm_b2)))));

	mod14_xm_b2 := -8.61546262 +
		(pk_impulse_count_mm_2 * 4.0942627513) +
		(pk_out_st_division_lvl_mm_2 * 2.9164515598) +
		((100 * (exp(avm_mod_xm_b2) / (1 + exp(avm_mod_xm_b2)))) * 0.0247066249) +
		((100 * (exp(age_mod3_xm_b2) / (1 + exp(age_mod3_xm_b2)))) * 0.012017114) +
		((100 * (exp(amstudent_mod_xm_b2) / (1 + exp(amstudent_mod_xm_b2)))) * 0.0132412703) +
		((100 * (exp(velocity2_mod_xm_b2) / (1 + exp(velocity2_mod_xm_b2)))) * 0.0237601171) +
		((100 * (exp(lres_mod_xm_b2) / (1 + exp(lres_mod_xm_b2)))) * -0.008850545) +
		(pk_prof_lic_cat_mm_2 * 3.1405417188) +
		((100 * (exp(fp_mod5_xm_b2) / (1 + exp(fp_mod5_xm_b2)))) * 0.0077074713) +
		((100 * (exp(derog_mod3_xm_b2) / (1 + exp(derog_mod3_xm_b2)))) * 0.0261362891) +
		((100 * (exp(lien_mod_xm_b2) / (1 + exp(lien_mod_xm_b2)))) * 0.0210586575) +
		((100 * (exp(property_mod_xm_b2) / (1 + exp(property_mod_xm_b2)))) * 0.0160954568) +
		(ver_src_cnt_mod_xm_b2 * 0.0104220512) +
		(ver_element_cnt_mod_xm_b2 * 0.0100493471) +
		(ver_src_time_mod_xm_b2 * 0.0075413035);

	age_mod3_nm_b3 := -2.719808323 +
		(pk_yr_in_dob2_mm_2 * 3.5372237763) +
		(pk_yr_reported_dob2_mm_2 * 2.9424244425);

	amstudent_mod_nm_b3 := -4.066288029 +
		(pk_ams_class_level_mm_2 * 4.9897040279) +
		(pk_ams_income_level_code_mm_2 * 3.5992648567) +
		(pk_college_tier_mm_2 * 3.923419383);

	avm_mod_nm_b3 := -4.497096168 +
		(pk2_add1_avm_sp_mm_2 * 2.8292591818) +
		(pk2_add1_avm_as_mm_2 * 4.1398881869) +
		(pk2_add1_avm_med_mm_2 * 4.2922186592) +
		(pk2_add2_avm_auto3_mm_2 * 3.1790735154);

	distance_mod2_nm_b3 := -2.74653625 +
		(pk_dist_a1toa2_mm_2 * 2.156927476) +
		(pk_dist_a1toa3_mm_2 * 4.5383866525);

	lres_mod_nm_b3 := -6.365606593 +
		(pk_add1_lres_mm_2 * 4.8470759191) +
		(pk_add3_lres_mm_2 * 3.1661232496) +
		(pk_addrs_10yr_mm_2 * 11.73445566) +
		(pk_add_lres_month_avg2_mm_2 * 2.8817468877);

	proflic_mod_nm_b3 := -2.903913415 +
		(pk_pl_sourced_level_mm_2 * 3.3924067709) +
		(pk_prof_lic_cat_mm_2 * 4.0026106055);

	property_mod_nm_b3 := -15.68614558 +
		(pk_pr_count_mm_2 * 3.3500052753) +
		(pk_add1_own_level_mm_2 * 1.2948391874) +
		(pk_add1_purchase_amount2_mm_2 * 1.5503104683) +
		(pk_add1_assessed_amount2_mm_2 * 1.741243602) +
		(pk_yr_add1_date_first_seen2_mm_2 * 3.6895609326) +
		(pk_add1_style_code_level_mm_2 * 3.1712689983) +
		(pk_add2_building_area2_mm_2 * 3.8985399708) +
		(pk_add2_no_of_buildings_mm_2 * 7.3359622051) +
		(pk_add2_no_of_rooms_mm_2 * 5.9959050771) +
		(pk_yr_add2_assess_val_yr2_mm_2 * 6.50307558) +
		(pk_add2_mortgage_risk_mm_2 * 6.1274413983) +
		(pk_add2_assessed_amount2_mm_2 * 4.9915414623) +
		(pk_yr_add2_date_first_seen2_mm_2 * 1.2918465092) +
		(pk_yr_add2_date_last_seen2_mm_2 * 1.6978444755) +
		(pk_add3_mortgage_risk_mm_2 * 3.8817539933) +
		(pk_add3_assessed_amount2_mm_2 * 4.6604338011) +
		(pk_yr_add3_date_first_seen2_mm_2 * 2.0920866057) +
		(pk_yr_add3_date_last_seen2_mm_2 * 0.6572362275);

	velocity2_mod_nm_b3 := -9.51633128 +
		(pk_nameperssn_count_mm_2 * 4.7411635652) +
		(pk_ssns_per_adl_mm_2 * 4.5083296262) +
		(pk_addrs_per_adl_mm_2 * 6.0873291027) +
		(pk_phones_per_adl_mm_2 * 3.1895345527) +
		(pk_adls_per_addr_mm_2 * 4.7264728463) +
		(pk_ssns_per_adl_c6_mm_2 * 2.7180809336) +
		(pk_ssns_per_addr_c6_mm_2 * 3.4830901132) +
		(pk_attr_addrs_last24_mm_2 * 7.1829081933);

	ver_best_score_mod_nm_b3 := -4.746905481 +
		(pk_rc_dirsaddr_lastscore_mm_2 * 5.5800141155) +
		(pk_combo_ssnscore_mm_2 * 3.287603464) +
		(pk_combo_dobscore_mm_2 * 5.1770769912) +
		(pk_add2_address_score_mm_2 * 3.4755270764);

	ver_best_src_cnt_mod_nm_b3 := -6.732895269 +
		(pk_eq_count_mm_2 * 4.9934882236) +
		(pk_voter_flag_mm_2 * 3.661331229) +
		(pk_lname_eda_sourced_type_lvl_mm_2 * 4.3703679338) +
		(pk_add2_em_ver_lvl_mm_2 * 6.5785594446) +
		(pk_infutor_risk_lvl_mm_2 * 4.8857604063) +
		(pk_attr_num_nonderogs90_b_mm_2 * 3.7108767518);

	ver_best_src_time_mod_nm_b3 := -4.214094016 +
		(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.8907040244) +
		(pk_yr_header_first_seen2_mm_2 * 3.4594636768) +
		(pk_yr_infutor_first_seen2_mm_2 * 6.2351385329);

	ver_notbest_score_mod_nm_b3 := -10.26137088 +
		(pk_rc_dirsaddr_lastscore_mm_2 * 3.6830510857) +
		(pk_combo_hphonescore_mm_2 * 8.0282665614) +
		(pk_combo_ssnscore_mm_2 * 2.2817817147) +
		(pk_combo_dobscore_mm_2 * 4.2385063389) +
		(pk_add1_address_score_mm_2 * 4.1802021975) +
		(pk_add2_address_score_mm_2 * 9.7187682276);

	ver_notbest_src_cnt_mod_nm_b3 := -7.885463027 +
		(pk_eq_count_mm_2 * 3.4304251222) +
		(pk_pos_secondary_sources_mm_2 * 6.5269453665) +
		(pk_voter_flag_mm_2 * 3.2669077149) +
		(pk_infutor_risk_lvl_nb_mm_2 * 4.2043346377) +
		(pk_nas_summary_mm_2 * 3.3300472814) +
		(pk_nap_summary_mm_2 * 3.1853521369);

	ver_notbest_src_time_mod_nm_b3 := -5.271884668 +
		(pk_yr_header_first_seen2_mm_2 * 2.5527711622) +
		(pk_yr_infutor_first_seen2_mm_2 * 4.8350637344) +
		(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 3.7973054965) +
		(pk_yr_lname_change_date2_mm_2 * 3.8174594596);

	ver_src_cnt_mod_nm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_nm_b3) / (1 + exp(ver_best_src_cnt_mod_nm_b3)))), (100 * (exp(ver_notbest_src_cnt_mod_nm_b3) / (1 + exp(ver_notbest_src_cnt_mod_nm_b3)))));

	ver_score_mod_nm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_nm_b3) / (1 + exp(ver_best_score_mod_nm_b3)))), (100 * (exp(ver_notbest_score_mod_nm_b3) / (1 + exp(ver_notbest_score_mod_nm_b3)))));

	ver_src_time_mod_nm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_nm_b3) / (1 + exp(ver_best_src_time_mod_nm_b3)))), (100 * (exp(ver_notbest_src_time_mod_nm_b3) / (1 + exp(ver_notbest_src_time_mod_nm_b3)))));

	mod14_nm_b3 := -5.622411401 +
		(pk_out_st_division_lvl_mm_2 * 5.0862847929) +
		((100 * (exp(distance_mod2_nm_b3) / (1 + exp(distance_mod2_nm_b3)))) * -0.047334615) +
		((100 * (exp(avm_mod_nm_b3) / (1 + exp(avm_mod_nm_b3)))) * 0.036420728) +
		((100 * (exp(age_mod3_nm_b3) / (1 + exp(age_mod3_nm_b3)))) * 0.0132467303) +
		((100 * (exp(amstudent_mod_nm_b3) / (1 + exp(amstudent_mod_nm_b3)))) * 0.0353190681) +
		((100 * (exp(velocity2_mod_nm_b3) / (1 + exp(velocity2_mod_nm_b3)))) * 0.0240840132) +
		((100 * (exp(lres_mod_nm_b3) / (1 + exp(lres_mod_nm_b3)))) * -0.021456794) +
		((100 * (exp(proflic_mod_nm_b3) / (1 + exp(proflic_mod_nm_b3)))) * 0.0290587025) +
		((100 * (exp(property_mod_nm_b3) / (1 + exp(property_mod_nm_b3)))) * 0.0233139469) +
		(ver_src_cnt_mod_nm_b3 * 0.0220053102) +
		(ver_src_time_mod_nm_b3 * 0.0091256222) +
		(ver_score_mod_nm_b3 * 0.0166098849) +
		(pk_multi_did * 0.2507566599);

	ver_best_element_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_best_element_cnt_mod_om_b1) / (1 + exp(ver_best_element_cnt_mod_om_b1)))),
									   pk_segment3_2 = '1 Derog-Other' => NULL,
																		  NULL);

	ver_src_cnt_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							  pk_segment3_2 = '1 Derog-Other' => NULL,
																 ver_src_cnt_mod_nm_b3);

	amstudent_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(amstudent_mod_om_b1) / (1 + exp(amstudent_mod_om_b1)))),
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   NULL);

	ver_notbest_score_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									pk_segment3_2 = '1 Derog-Other' => NULL,
																	   (100 * (exp(ver_notbest_score_mod_nm_b3) / (1 + exp(ver_notbest_score_mod_nm_b3)))));

	ver_src_time_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							   pk_segment3_2 = '1 Derog-Other' => NULL,
																  ver_src_time_mod_nm_b3);

	phat := map(pk_segment3_2 = '0 Derog-Owner' => (exp(mod14_om_b1) / (1 + exp(mod14_om_b1))),
				pk_segment3_2 = '1 Derog-Other' => (exp(mod14_xm_b2) / (1 + exp(mod14_xm_b2))),
												   (exp(mod14_nm_b3) / (1 + exp(mod14_nm_b3))));

	age_mod3_nodob_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							 pk_segment3_2 = '1 Derog-Other' => (100 * (exp(age_mod3_nodob_xm_b2) / (1 + exp(age_mod3_nodob_xm_b2)))),
																NULL);

	ver_src_time_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => ver_src_time_mod_om_b1,
							   pk_segment3_2 = '1 Derog-Other' => NULL,
																  NULL);

	avm_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(avm_mod_om_b1) / (1 + exp(avm_mod_om_b1)))),
					  pk_segment3_2 = '1 Derog-Other' => NULL,
														 NULL);

	ver_notbest_src_cnt_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									  pk_segment3_2 = '1 Derog-Other' => NULL,
																		 (100 * (exp(ver_notbest_src_cnt_mod_nm_b3) / (1 + exp(ver_notbest_src_cnt_mod_nm_b3)))));

	property_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(property_mod_xm_b2) / (1 + exp(property_mod_xm_b2)))),
															  NULL);

	mod14_om := map(pk_segment3_2 = '0 Derog-Owner' => (exp(mod14_om_b1) / (1 + exp(mod14_om_b1))),
					pk_segment3_2 = '1 Derog-Other' => NULL,
													   NULL);

	mod14_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					pk_segment3_2 = '1 Derog-Other' => (exp(mod14_xm_b2) / (1 + exp(mod14_xm_b2))),
													   NULL);

	ver_notbest_src_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_notbest_src_cnt_mod_om_b1) / (1 + exp(ver_notbest_src_cnt_mod_om_b1)))),
									  pk_segment3_2 = '1 Derog-Other' => NULL,
																		 NULL);

	velocity2_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   (100 * (exp(velocity2_mod_nm_b3) / (1 + exp(velocity2_mod_nm_b3)))));

	distance_mod2_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   (100 * (exp(distance_mod2_nm_b3) / (1 + exp(distance_mod2_nm_b3)))));

	lien_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(lien_mod_om_b1) / (1 + exp(lien_mod_om_b1)))),
					   pk_segment3_2 = '1 Derog-Other' => NULL,
														  NULL);

	ver_src_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							  pk_segment3_2 = '1 Derog-Other' => ver_src_cnt_mod_xm_b2,
																 NULL);

	mod14_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					pk_segment3_2 = '1 Derog-Other' => NULL,
													   (exp(mod14_nm_b3) / (1 + exp(mod14_nm_b3))));

	ver_notbest_src_time_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_notbest_src_time_mod_xm_b2) / (1 + exp(ver_notbest_src_time_mod_xm_b2)))),
																		  NULL);

	velocity2_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(velocity2_mod_om_b1) / (1 + exp(velocity2_mod_om_b1)))),
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   NULL);

	property_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						   pk_segment3_2 = '1 Derog-Other' => NULL,
															  (100 * (exp(property_mod_nm_b3) / (1 + exp(property_mod_nm_b3)))));

	ver_notbest_element_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
										  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_notbest_element_cnt_mod_xm_b2) / (1 + exp(ver_notbest_element_cnt_mod_xm_b2)))),
																			 NULL);

	ver_notbest_src_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_notbest_src_cnt_mod_xm_b2) / (1 + exp(ver_notbest_src_cnt_mod_xm_b2)))),
																		 NULL);

	ver_notbest_src_time_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_notbest_src_time_mod_om_b1) / (1 + exp(ver_notbest_src_time_mod_om_b1)))),
									   pk_segment3_2 = '1 Derog-Other' => NULL,
																		  NULL);

	avm_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					  pk_segment3_2 = '1 Derog-Other' => NULL,
														 (100 * (exp(avm_mod_nm_b3) / (1 + exp(avm_mod_nm_b3)))));

	ver_best_src_time_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_best_src_time_mod_om_b1) / (1 + exp(ver_best_src_time_mod_om_b1)))),
									pk_segment3_2 = '1 Derog-Other' => NULL,
																	   NULL);

	ver_best_src_time_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_best_src_time_mod_xm_b2) / (1 + exp(ver_best_src_time_mod_xm_b2)))),
																	   NULL);

	ver_src_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => ver_src_cnt_mod_om_b1,
							  pk_segment3_2 = '1 Derog-Other' => NULL,
																 NULL);

	ver_best_src_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
								   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_best_src_cnt_mod_xm_b2) / (1 + exp(ver_best_src_cnt_mod_xm_b2)))),
																	  NULL);

	amstudent_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => (100 * (exp(amstudent_mod_xm_b2) / (1 + exp(amstudent_mod_xm_b2)))),
															   NULL);

	age_mod3_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(age_mod3_xm_b2) / (1 + exp(age_mod3_xm_b2)))),
														  NULL);

	avm_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(avm_mod_xm_b2) / (1 + exp(avm_mod_xm_b2)))),
														 NULL);

	ver_best_src_cnt_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
								   pk_segment3_2 = '1 Derog-Other' => NULL,
																	  (100 * (exp(ver_best_src_cnt_mod_nm_b3) / (1 + exp(ver_best_src_cnt_mod_nm_b3)))));

	velocity2_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => (100 * (exp(velocity2_mod_xm_b2) / (1 + exp(velocity2_mod_xm_b2)))),
															   NULL);

	ver_notbest_element_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_notbest_element_cnt_mod_om_b1) / (1 + exp(ver_notbest_element_cnt_mod_om_b1)))),
										  pk_segment3_2 = '1 Derog-Other' => NULL,
																			 NULL);

	lres_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					   pk_segment3_2 = '1 Derog-Other' => NULL,
														  (100 * (exp(lres_mod_nm_b3) / (1 + exp(lres_mod_nm_b3)))));

	ver_notbest_src_time_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									   pk_segment3_2 = '1 Derog-Other' => NULL,
																		  (100 * (exp(ver_notbest_src_time_mod_nm_b3) / (1 + exp(ver_notbest_src_time_mod_nm_b3)))));

	fp_mod5_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(fp_mod5_xm_b2) / (1 + exp(fp_mod5_xm_b2)))),
														 NULL);

	phnprob_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(phnprob_mod_xm_b2) / (1 + exp(phnprob_mod_xm_b2)))),
															 NULL);

	ver_element_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
								  pk_segment3_2 = '1 Derog-Other' => ver_element_cnt_mod_xm_b2,
																	 NULL);

	derog_mod3_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(derog_mod3_om_b1) / (1 + exp(derog_mod3_om_b1)))),
						 pk_segment3_2 = '1 Derog-Other' => NULL,
															NULL);

	mod14_scr := map(pk_segment3_2 = '0 Derog-Owner' => round(((-40 * ((ln(((exp(mod14_om_b1) / (1 + exp(mod14_om_b1))) / (1 - (exp(mod14_om_b1) / (1 + exp(mod14_om_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
					 pk_segment3_2 = '1 Derog-Other' => round(((-40 * ((ln(((exp(mod14_xm_b2) / (1 + exp(mod14_xm_b2))) / (1 - (exp(mod14_xm_b2) / (1 + exp(mod14_xm_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
														round(((-40 * ((ln(((exp(mod14_nm_b3) / (1 + exp(mod14_nm_b3))) / (1 - (exp(mod14_nm_b3) / (1 + exp(mod14_nm_b3)))))) - ln((1 / 20))) / ln(2))) + 700)));

	ssnprob2_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ssnprob2_mod_xm_b2) / (1 + exp(ssnprob2_mod_xm_b2)))),
															  NULL);

	age_mod3_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					   pk_segment3_2 = '1 Derog-Other' => NULL,
														  (100 * (exp(age_mod3_nm_b3) / (1 + exp(age_mod3_nm_b3)))));

	ver_best_src_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(ver_best_src_cnt_mod_om_b1) / (1 + exp(ver_best_src_cnt_mod_om_b1)))),
								   pk_segment3_2 = '1 Derog-Other' => NULL,
																	  NULL);

	ver_best_src_time_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									pk_segment3_2 = '1 Derog-Other' => NULL,
																	   (100 * (exp(ver_best_src_time_mod_nm_b3) / (1 + exp(ver_best_src_time_mod_nm_b3)))));

	addprob3_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(addprob3_mod_xm_b2) / (1 + exp(addprob3_mod_xm_b2)))),
															  NULL);

	derog_mod3_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						 pk_segment3_2 = '1 Derog-Other' => (100 * (exp(derog_mod3_xm_b2) / (1 + exp(derog_mod3_xm_b2)))),
															NULL);

	ver_element_cnt_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => ver_element_cnt_mod_om_b1,
								  pk_segment3_2 = '1 Derog-Other' => NULL,
																	 NULL);

	ver_best_score_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
								 pk_segment3_2 = '1 Derog-Other' => NULL,
																	(100 * (exp(ver_best_score_mod_nm_b3) / (1 + exp(ver_best_score_mod_nm_b3)))));

	lien_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(lien_mod_xm_b2) / (1 + exp(lien_mod_xm_b2)))),
														  NULL);

	amstudent_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   (100 * (exp(amstudent_mod_nm_b3) / (1 + exp(amstudent_mod_nm_b3)))));

	ver_score_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							pk_segment3_2 = '1 Derog-Other' => NULL,
															   ver_score_mod_nm_b3);

	proflic_mod_nm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
						  pk_segment3_2 = '1 Derog-Other' => NULL,
															 (100 * (exp(proflic_mod_nm_b3) / (1 + exp(proflic_mod_nm_b3)))));

	ver_src_time_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							   pk_segment3_2 = '1 Derog-Other' => ver_src_time_mod_xm_b2,
																  NULL);

	property_mod_om := map(pk_segment3_2 = '0 Derog-Owner' => (100 * (exp(property_mod_om_b1) / (1 + exp(property_mod_om_b1)))),
						   pk_segment3_2 = '1 Derog-Other' => NULL,
															  NULL);

	lres_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
					   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(lres_mod_xm_b2) / (1 + exp(lres_mod_xm_b2)))),
														  NULL);

	ver_best_element_cnt_mod_xm := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									   pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_best_element_cnt_mod_xm_b2) / (1 + exp(ver_best_element_cnt_mod_xm_b2)))),
																		  NULL);

	mod14_om_nodob_b1_c2_b1 := -7.269791585 +
		(pk_impulse_count_mm_2 * 5.202460862) +
		(pk_out_st_division_lvl_mm_2 * 4.150142349) +
		(avm_mod_om * 0.0145848189) +
		(amstudent_mod_om * 0.0160410157) +
		(velocity2_mod_om * 0.0296970217) +
		(derog_mod3_om * 0.0302163976) +
		(lien_mod_om * 0.0265606527) +
		(property_mod_om * 0.0278238124) +
		(pk_estimated_income_mm_2 * 1.6125404243) +
		(ver_src_cnt_mod_om * 0.0131826671) +
		(ver_src_time_mod_om * 0.0188074934) +
		(pk_multi_did * 0.5131464419);

	ver_best_e_cnt_mod_xm_nodob_b1_c2_b2 := -6.661901665 +
		(pk_combo_fnamecount_mm_2 * 4.0553880882) +
		(pk_rc_addrcount_mm_2 * 2.5742386175) +
		(pk_ver_phncount_mm_2 * 4.6861575743) +
		(pk_gong_did_phone_ct_mm_2 * 6.0816052649) +
		(pk_combo_ssncount_mm_2 * 4.3504687787);

	ver_best_score_mod_xm_nodob_b1_c2_b2 := -9.101908523 +
		(pk_rc_dirsaddr_lastscore_mm_2 * 5.4776192985) +
		(pk_adl_score_mm_2 * 4.0943535429) +
		(pk_combo_hphonescore_mm_2 * 5.1419605105) +
		(pk_combo_ssnscore_mm_2 * 4.1002761292) +
		(pk_add1_address_score_mm_2 * 7.6754364771) +
		(pk_add2_address_score_mm_2 * 4.8074235026);

	ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2 := -16.71055692 +
		(pk_combo_fnamecount_nb_mm_2 * 3.8335848797) +
		(pk_rc_phonelnamecount_mm_2 * 7.9979592083) +
		(pk_rc_addrcount_nb_mm_2 * 3.7855887969) +
		(pk_rc_phonephonecount_mm_2 * 22.184017622) +
		(pk_gong_did_phone_ct_nb_mm_2 * 6.1739054419) +
		(pk_combo_ssncount_mm_2 * 3.6482892347);

	ver_notbest_score_mod_xm_nodob_b1_c2_b2 := -8.159841399 +
		(pk_rc_dirsaddr_lastscore_mm_2 * 4.2547722115) +
		(pk_combo_hphonescore_mm_2 * 4.2430234707) +
		(pk_combo_ssnscore_mm_2 * 4.2105021258) +
		(pk_add1_address_score_mm_2 * 4.7092760488) +
		(pk_add2_address_score_mm_2 * 4.8095261759);

	ver_element_cnt_mod_xm_nodob_b1_c2_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b2)))), (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2)))));

	ver_score_mod_xm_nodob_b1_c2_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_best_score_mod_xm_nodob_b1_c2_b2)))), (100 * (exp(ver_notbest_score_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_notbest_score_mod_xm_nodob_b1_c2_b2)))));

	mod14_xm_nodob_b1_c2_b2 := -8.637216875 +
		(pk_impulse_count_mm_2 * 4.1296787855) +
		(pk_out_st_division_lvl_mm_2 * 2.9892778908) +
		(avm_mod_xm * 0.0245330447) +
		(age_mod3_nodob_xm * 0.0087010814) +
		(amstudent_mod_xm * 0.0133253992) +
		(velocity2_mod_xm * 0.0257064883) +
		(lres_mod_xm * -0.00953088) +
		(pk_prof_lic_cat_mm_2 * 3.1641725732) +
		(derog_mod3_xm * 0.0262895232) +
		(lien_mod_xm * 0.0213365923) +
		(property_mod_xm * 0.0159296221) +
		(ver_src_cnt_mod_xm * 0.0094669622) +
		(ver_element_cnt_mod_xm_nodob_b1_c2_b2 * 0.009835493) +
		(ver_src_time_mod_xm * 0.0108337088) +
		(ver_score_mod_xm_nodob_b1_c2_b2 * 0.0069011716);

	mod14_nm_nodob_b1_c2_b3 := -5.562186631 +
		(pk_out_st_division_lvl_mm_2 * 5.0808063035) +
		(distance_mod2_nm * -0.040588888) +
		(avm_mod_nm * 0.0352105714) +
		(amstudent_mod_nm * 0.0358202911) +
		(velocity2_mod_nm * 0.0264775841) +
		(lres_mod_nm * -0.01834689) +
		(proflic_mod_nm * 0.0284284923) +
		(property_mod_nm * 0.0249414551) +
		(ver_src_cnt_mod_nm * 0.026406909) +
		(ver_src_time_mod_nm * 0.0194773912) +
		(pk_multi_did * 0.2725646641);

	mod14_om_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => (exp(mod14_om_nodob_b1_c2_b1) / (1 + exp(mod14_om_nodob_b1_c2_b1))),
							 pk_segment3_2 = '1 Derog-Other' => NULL,
																NULL);

	mod14_scr_b1 := map(pk_segment3_2 = '0 Derog-Owner' => round(((-40 * ((ln(((exp(mod14_om_nodob_b1_c2_b1) / (1 + exp(mod14_om_nodob_b1_c2_b1))) / (1 - (exp(mod14_om_nodob_b1_c2_b1) / (1 + exp(mod14_om_nodob_b1_c2_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
						pk_segment3_2 = '1 Derog-Other' => round(((-40 * ((ln(((exp(mod14_xm_nodob_b1_c2_b2) / (1 + exp(mod14_xm_nodob_b1_c2_b2))) / (1 - (exp(mod14_xm_nodob_b1_c2_b2) / (1 + exp(mod14_xm_nodob_b1_c2_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
														   round(((-40 * ((ln(((exp(mod14_nm_nodob_b1_c2_b3) / (1 + exp(mod14_nm_nodob_b1_c2_b3))) / (1 - (exp(mod14_nm_nodob_b1_c2_b3) / (1 + exp(mod14_nm_nodob_b1_c2_b3)))))) - ln((1 / 20))) / ln(2))) + 700)));

	mod14_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							 pk_segment3_2 = '1 Derog-Other' => (exp(mod14_xm_nodob_b1_c2_b2) / (1 + exp(mod14_xm_nodob_b1_c2_b2))),
																NULL);

	ver_best_score_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
										  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_best_score_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_best_score_mod_xm_nodob_b1_c2_b2)))),
																			 NULL);

	mod14_nm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
							 pk_segment3_2 = '1 Derog-Other' => NULL,
																(exp(mod14_nm_nodob_b1_c2_b3) / (1 + exp(mod14_nm_nodob_b1_c2_b3))));

	phat_b1 := map(pk_segment3_2 = '0 Derog-Owner' => (exp(mod14_om_nodob_b1_c2_b1) / (1 + exp(mod14_om_nodob_b1_c2_b1))),
				   pk_segment3_2 = '1 Derog-Other' => (exp(mod14_xm_nodob_b1_c2_b2) / (1 + exp(mod14_xm_nodob_b1_c2_b2))),
													  (exp(mod14_nm_nodob_b1_c2_b3) / (1 + exp(mod14_nm_nodob_b1_c2_b3))));

	ver_score_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
									 pk_segment3_2 = '1 Derog-Other' => ver_score_mod_xm_nodob_b1_c2_b2,
																		NULL);

	ver_best_e_cnt_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
										  pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b2)))),
																			 NULL);

	ver_notbest_score_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
											 pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_notbest_score_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_notbest_score_mod_xm_nodob_b1_c2_b2)))),
																				NULL);

	ver_element_cnt_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
										   pk_segment3_2 = '1 Derog-Other' => ver_element_cnt_mod_xm_nodob_b1_c2_b2,
																			  NULL);

	ver_notbest_e_cnt_mod_xm_nodob_b1 := map(pk_segment3_2 = '0 Derog-Owner' => NULL,
											 pk_segment3_2 = '1 Derog-Other' => (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2)))),
																				NULL);

	mod14_om_nodob := if((integer)dobpop = 0, mod14_om_nodob_b1, NULL);

	mod14_scr_2 := if((integer)dobpop = 0, mod14_scr_b1, mod14_scr);

	mod14_xm_nodob := if((integer)dobpop = 0, mod14_xm_nodob_b1, NULL);

	ver_best_score_mod_xm_nodob := if((integer)dobpop = 0, ver_best_score_mod_xm_nodob_b1, NULL);

	mod14_nm_nodob := if((integer)dobpop = 0, mod14_nm_nodob_b1, NULL);

	phat_2 := if((integer)dobpop = 0, phat_b1, phat);

	ver_score_mod_xm_nodob := if((integer)dobpop = 0, ver_score_mod_xm_nodob_b1, NULL);

	ver_best_e_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_best_e_cnt_mod_xm_nodob_b1, NULL);

	ver_notbest_score_mod_xm_nodob := if((integer)dobpop = 0, ver_notbest_score_mod_xm_nodob_b1, NULL);

	ver_element_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_element_cnt_mod_xm_nodob_b1, NULL);

	ver_notbest_e_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_notbest_e_cnt_mod_xm_nodob_b1, NULL);

	RVG1003 := min(900, max(501, mod14_scr_2));

	ov_ssndead := (((integer)ssnlength > 0) and ((integer)rc_decsflag = 1));

	ov_ssnprior := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

	ov_criminal_flag := (criminal_count > 0);

	ov_corrections := ((integer)rc_hrisksic = 2225);

	ov_impulse := (impulse_count > 0);

	rvg1003_2 :=  if((RVG1003 > 650) and (ov_ssndead or (ov_ssnprior or (ov_criminal_flag or (ov_corrections or ov_impulse)))), 650, RVG1003);

	// scored_222s := ((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) OR (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag > 0) or (ssn_deceased or truedid)))))));
	scored_222s :=
		property_owned_total>0 or property_sold_total>0
		or combo_dobscore between 90 and 100
		or (integer)input_dob_match_level >= 7
		or lien_flag
		or criminal_count > 0
		or bk_flag
		or ssn_deceased
		or truedid;

	rvg1003_3 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvg1003_2);


			#if(RVG_DEBUG)
				self.seq := le.seq;
				self.truedid := truedid;
				self.adl_category := adl_category;
				self.out_unit_desig := out_unit_desig;
				self.out_sec_range := out_sec_range;
				self.out_st := out_st;
				self.out_addr_type := out_addr_type;
				self.out_addr_status := out_addr_status;
				self.in_dob := in_dob;
				self.nas_summary := nas_summary;
				self.nap_summary := nap_summary;
				self.did_count := did_count;
				self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
				self.rc_hriskphoneflag := rc_hriskphoneflag;
				self.rc_phonevalflag := rc_phonevalflag;
				self.rc_phonezipflag := rc_phonezipflag;
				self.rc_pwphonezipflag := rc_pwphonezipflag;
				self.rc_decsflag := rc_decsflag;
				self.rc_ssndobflag := rc_ssndobflag;
				self.rc_pwssndobflag := rc_pwssndobflag;
				self.rc_pwssnvalflag := rc_pwssnvalflag;
				self.rc_ssnhighissue := rc_ssnhighissue;
				self.rc_areacodesplitflag := rc_areacodesplitflag;
				self.rc_addrvalflag := rc_addrvalflag;
				self.rc_dwelltype := rc_dwelltype;
				self.rc_bansflag := rc_bansflag;
				self.rc_sources := rc_sources;
				self.rc_addrcount := rc_addrcount;
				self.rc_phonelnamecount := rc_phonelnamecount;
				self.rc_phonephonecount := rc_phonephonecount;
				self.rc_hrisksic := rc_hrisksic;
				self.rc_disthphoneaddr := rc_disthphoneaddr;
				self.rc_fnamessnmatch := rc_fnamessnmatch;
				self.combo_hphonescore := combo_hphonescore;
				self.combo_ssnscore := combo_ssnscore;
				self.combo_dobscore := combo_dobscore;
				self.combo_fnamecount := combo_fnamecount;
				self.combo_addrcount := combo_addrcount;
				self.combo_ssncount := combo_ssncount;
				self.combo_dobcount := combo_dobcount;
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
				self.fname_sources := fname_sources;
				self.lname_sources := lname_sources;
				self.addr_sources := addr_sources;
				self.em_only_sources := em_only_sources;
				self.voter_avail := voter_avail;
				self.ssnlength := ssnlength;
				self.dobpop := dobpop;
				self.adl_score := adl_score;
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
				self.add1_avm_sales_price := add1_avm_sales_price;
				self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
				self.add1_avm_automated_valuation := add1_avm_automated_valuation;
				self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
				self.add1_avm_automated_valuation_3 := add1_avm_automated_valuation_3;
				self.add1_avm_med_fips := add1_avm_med_fips;
				self.add1_avm_med_geo11 := add1_avm_med_geo11;
				self.add1_avm_med_geo12 := add1_avm_med_geo12;
				self.add1_applicant_owned := add1_applicant_owned;
				self.add1_occupant_owned := add1_occupant_owned;
				self.add1_family_owned := add1_family_owned;
				self.add1_naprop := add1_naprop;
				self.add1_built_date := add1_built_date;
				self.add1_purchase_amount := add1_purchase_amount;
				self.add1_mortgage_amount := add1_mortgage_amount;
				self.add1_mortgage_date := add1_mortgage_date;
				self.add1_mortgage_type := add1_mortgage_type;
				self.add1_financing_type := add1_financing_type;
				self.add1_assessed_amount := add1_assessed_amount;
				self.add1_date_first_seen := add1_date_first_seen;
				self.add1_building_area := add1_building_area;
				self.add1_no_of_rooms := add1_no_of_rooms;
				self.add1_garage_type_code := add1_garage_type_code;
				self.add1_style_code := add1_style_code;
				self.add1_pop := add1_pop;
				self.property_owned_total := property_owned_total;
				self.property_sold_total := property_sold_total;
				self.property_sold_assessed_total := property_sold_assessed_total;
				self.prop1_prev_purchase_price := prop1_prev_purchase_price;
				self.dist_a1toa2 := dist_a1toa2;
				self.dist_a1toa3 := dist_a1toa3;
				self.dist_a2toa3 := dist_a2toa3;
				self.add2_address_score := add2_address_score;
				self.add2_avm_land_use := add2_avm_land_use;
				self.add2_avm_hedonic_valuation := add2_avm_hedonic_valuation;
				self.add2_avm_automated_valuation := add2_avm_automated_valuation;
				self.add2_avm_automated_valuation_3 := add2_avm_automated_valuation_3;
				self.add2_sources := add2_sources;
				self.add2_naprop := add2_naprop;
				self.add2_building_area := add2_building_area;
				self.add2_no_of_buildings := add2_no_of_buildings;
				self.add2_no_of_rooms := add2_no_of_rooms;
				self.add2_style_code := add2_style_code;
				self.add2_assessed_value_year := add2_assessed_value_year;
				self.add2_purchase_amount := add2_purchase_amount;
				self.add2_mortgage_type := add2_mortgage_type;
				self.add2_assessed_amount := add2_assessed_amount;
				self.add2_date_first_seen := add2_date_first_seen;
				self.add2_date_last_seen := add2_date_last_seen;
				self.add3_lres := add3_lres;
				self.add3_sources := add3_sources;
				self.add3_naprop := add3_naprop;
				self.add3_purchase_amount := add3_purchase_amount;
				self.add3_mortgage_type := add3_mortgage_type;
				self.add3_assessed_amount := add3_assessed_amount;
				self.add3_date_first_seen := add3_date_first_seen;
				self.add3_date_last_seen := add3_date_last_seen;
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
				self.adls_per_addr := adls_per_addr;
				self.ssns_per_addr := ssns_per_addr;
				self.phones_per_addr := phones_per_addr;
				self.adls_per_phone := adls_per_phone;
				self.ssns_per_adl_c6 := ssns_per_adl_c6;
				self.ssns_per_addr_c6 := ssns_per_addr_c6;
				self.adls_per_phone_c6 := adls_per_phone_c6;
				self.vo_addrs_per_adl := vo_addrs_per_adl;
				self.invalid_addrs_per_adl_c6 := invalid_addrs_per_adl_c6;
				self.infutor_first_seen := infutor_first_seen;
				self.infutor_nap := infutor_nap;
				self.impulse_count := impulse_count;
				self.attr_addrs_last24 := attr_addrs_last24;
				self.attr_num_sold180 := attr_num_sold180;
				self.attr_num_watercraft180 := attr_num_watercraft180;
				self.attr_num_watercraft60 := attr_num_watercraft60;
				self.attr_total_number_derogs := attr_total_number_derogs;
				self.attr_eviction_count := attr_eviction_count;
				self.attr_date_last_eviction := attr_date_last_eviction;
				self.attr_eviction_count30 := attr_eviction_count30;
				self.attr_eviction_count90 := attr_eviction_count90;
				self.attr_eviction_count180 := attr_eviction_count180;
				self.attr_eviction_count12 := attr_eviction_count12;
				self.attr_eviction_count24 := attr_eviction_count24;
				self.attr_eviction_count36 := attr_eviction_count36;
				self.attr_eviction_count60 := attr_eviction_count60;
				self.attr_num_nonderogs90 := attr_num_nonderogs90;
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
				self.ams_age := ams_age;
				self.ams_class := ams_class;
				self.college_tier := college_tier;
				self.ams_college_code := ams_college_code;
				self.ams_income_level_code := ams_income_level_code;
				self.prof_license_flag := prof_license_flag;
				self.prof_license_category := prof_license_category;
				self.wealth_index := wealth_index;
				self.input_dob_match_level := input_dob_match_level;
				self.inferred_age := inferred_age;
				self.reported_dob := reported_dob;
				self.archive_date := archive_date;
				self.sysdate := sysdate;
				self.sysyear := sysyear;
				self.in_dob2 := in_dob2;
				self.years_in_dob := years_in_dob;
				self.months_in_dob := months_in_dob;
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
				self.add1_built_date2 := add1_built_date2;
				self.years_add1_built_date := years_add1_built_date;
				self.months_add1_built_date := months_add1_built_date;
				self.add1_mortgage_date2 := add1_mortgage_date2;
				self.years_add1_mortgage_date := years_add1_mortgage_date;
				self.months_add1_mortgage_date := months_add1_mortgage_date;
				self.add1_date_first_seen2 := add1_date_first_seen2;
				self.years_add1_date_first_seen := years_add1_date_first_seen;
				self.months_add1_date_first_seen := months_add1_date_first_seen;
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
				self.add3_date_last_seen2 := add3_date_last_seen2;
				self.years_add3_date_last_seen := years_add3_date_last_seen;
				self.months_add3_date_last_seen := months_add3_date_last_seen;
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
				self.attr_date_last_eviction2 := attr_date_last_eviction2;
				self.years_attr_date_last_eviction := years_attr_date_last_eviction;
				self.months_attr_date_last_eviction := months_attr_date_last_eviction;
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
				self.source_fst_PL := source_fst_PL;
				self.source_lst_PL := source_lst_PL;
				self.source_add_P := source_add_P;
				self.source_add_PL := source_add_PL;
				self.source_add2_EM := source_add2_EM;
				self.source_add2_VO := source_add2_VO;
				self.source_add2_EQ := source_add2_EQ;
				self.source_add2_P := source_add2_P;
				self.source_add2_WP := source_add2_WP;
				self.source_add2_voter := source_add2_voter;
				self.source_add3_P := source_add3_P;
				self.source_add3_W := source_add3_W;
				self.em_only_source_EM := em_only_source_EM;
				self.em_only_source_E1 := em_only_source_E1;
				self.em_only_source_E2 := em_only_source_E2;
				self.em_only_source_E3 := em_only_source_E3;
				self.em_only_source_E4 := em_only_source_E4;
				self.verfst_p := verfst_p;
				self.verlst_p := verlst_p;
				self.veradd_p := veradd_p;
				self.verphn_p := verphn_p;
				self.ver_phncount := ver_phncount;
				self.years_adl_first_seen_max_fcra := years_adl_first_seen_max_fcra;
				self.months_adl_first_seen_max_fcra := months_adl_first_seen_max_fcra;
				self.add_ec1 := add_ec1;
				self.add_ec3 := add_ec3;
				self.add_ec4 := add_ec4;
				self.add_apt := add_apt;
				self.phn_highrisk2 := phn_highrisk2;
				self.phn_zipmismatch := phn_zipmismatch;
				self.ssn_issued18 := ssn_issued18;
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
				self.add_apt_2 := add_apt_2;
				self.pk_bk_level := pk_bk_level;
				self.add1_avm_med_2 := add1_avm_med_2;
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
				self.pk_yr_adl_em_first_seen := pk_yr_adl_em_first_seen;
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
				self.pk_combo_hphonescore := pk_combo_hphonescore;
				self.pk_combo_ssnscore := pk_combo_ssnscore;
				self.pk_combo_dobscore := pk_combo_dobscore;
				self.pk_combo_fnamecount := pk_combo_fnamecount;
				self.pk_combo_fnamecount_nb := pk_combo_fnamecount_nb;
				self.pk_rc_phonelnamecount := pk_rc_phonelnamecount;
				self.pk_combo_addrcount_nb := pk_combo_addrcount_nb;
				self.pk_rc_addrcount := pk_rc_addrcount;
				self.pk_rc_addrcount_nb := pk_rc_addrcount_nb;
				self.pk_rc_phonephonecount := pk_rc_phonephonecount;
				self.pk_ver_phncount := pk_ver_phncount;
				self.pk_gong_did_phone_ct := pk_gong_did_phone_ct;
				self.pk_gong_did_phone_ct_nb := pk_gong_did_phone_ct_nb;
				self.pk_combo_ssncount := pk_combo_ssncount;
				self.pk_combo_dobcount := pk_combo_dobcount;
				self.pk_combo_dobcount_nb := pk_combo_dobcount_nb;
				self.pk_eq_count := pk_eq_count;
				self.pk_pos_secondary_sources := pk_pos_secondary_sources;
				self.pk_voter_flag := pk_voter_flag;
				self.pk_fname_eda_sourced_type_lvl := pk_fname_eda_sourced_type_lvl;
				self.pk_lname_eda_sourced_type_lvl := pk_lname_eda_sourced_type_lvl;
				self.pk_add1_address_score := pk_add1_address_score;
				self.pk_add1_unit_count2 := pk_add1_unit_count2;
				self.pk_add2_address_score := pk_add2_address_score;
				self.pk_add2_pos_sources := pk_add2_pos_sources;
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
				self.pk_add2_em_ver_lvl := pk_add2_em_ver_lvl;
				self.pk_ssnchar_invalid_or_recent_2 := pk_ssnchar_invalid_or_recent_2;
				self.pk_infutor_risk_lvl := pk_infutor_risk_lvl;
				self.pk_infutor_risk_lvl_nb := pk_infutor_risk_lvl_nb;
				self.pk_yr_adl_em_first_seen2 := pk_yr_adl_em_first_seen2;
				self.pk_yr_adl_vo_first_seen2 := pk_yr_adl_vo_first_seen2;
				self.pk_yr_adl_em_only_first_seen2 := pk_yr_adl_em_only_first_seen2;
				self.pk_yrmo_adl_first_seen_max_fcra2 := pk_yrmo_adl_first_seen_max_fcra2;
				self.pk_yr_lname_change_date2 := pk_yr_lname_change_date2;
				self.pk_yr_gong_did_first_seen2 := pk_yr_gong_did_first_seen2;
				self.pk_yr_credit_first_seen2 := pk_yr_credit_first_seen2;
				self.pk_yr_header_first_seen2 := pk_yr_header_first_seen2;
				self.pk_yr_infutor_first_seen2 := pk_yr_infutor_first_seen2;
				self.pk_estimated_income := pk_estimated_income;
				self.pk_yr_adl_pr_first_seen := pk_yr_adl_pr_first_seen;
				self.pk_yr_adl_w_first_seen := pk_yr_adl_w_first_seen;
				self.pk_yr_adl_w_last_seen := pk_yr_adl_w_last_seen;
				self.pk_yr_add1_built_date := pk_yr_add1_built_date;
				self.pk_yr_add1_mortgage_date := pk_yr_add1_mortgage_date;
				self.pk_yr_add1_date_first_seen := pk_yr_add1_date_first_seen;
				self.pk_yr_add2_assessed_value_year := pk_yr_add2_assessed_value_year;
				self.pk_yr_add2_date_first_seen := pk_yr_add2_date_first_seen;
				self.pk_yr_add2_date_last_seen := pk_yr_add2_date_last_seen;
				self.pk_yr_add3_date_first_seen := pk_yr_add3_date_first_seen;
				self.pk_yr_add3_date_last_seen := pk_yr_add3_date_last_seen;
				self.pk_prop1_prev_purchase_price := pk_prop1_prev_purchase_price;
				self.pk_add1_purchase_amount := pk_add1_purchase_amount;
				self.pk_add1_mortgage_amount := pk_add1_mortgage_amount;
				self.pk_add1_assessed_amount := pk_add1_assessed_amount;
				self.pk_add2_purchase_amount := pk_add2_purchase_amount;
				self.pk_add2_assessed_amount := pk_add2_assessed_amount;
				self.pk_add3_purchase_amount := pk_add3_purchase_amount;
				self.pk_add3_assessed_amount := pk_add3_assessed_amount;
				self.pk_prop1_prev_purchase_price_2 := pk_prop1_prev_purchase_price_2;
				self.pk_add1_purchase_amount_2 := pk_add1_purchase_amount_2;
				self.pk_add1_mortgage_amount_2 := pk_add1_mortgage_amount_2;
				self.pk_add1_assessed_amount_2 := pk_add1_assessed_amount_2;
				self.pk_add2_purchase_amount_2 := pk_add2_purchase_amount_2;
				self.pk_add2_assessed_amount_2 := pk_add2_assessed_amount_2;
				self.pk_add3_purchase_amount_2 := pk_add3_purchase_amount_2;
				self.pk_add3_assessed_amount_2 := pk_add3_assessed_amount_2;
				self.pk_add1_building_area := pk_add1_building_area;
				self.pk_add2_building_area := pk_add2_building_area;
				self.pk_yr_adl_pr_first_seen2 := pk_yr_adl_pr_first_seen2;
				self.pk_yr_adl_w_first_seen2 := pk_yr_adl_w_first_seen2;
				self.pk_yr_adl_w_last_seen2 := pk_yr_adl_w_last_seen2;
				self.pk_pr_count := pk_pr_count;
				self.pk_addrs_sourced_lvl := pk_addrs_sourced_lvl;
				self.pk_add1_own_level := pk_add1_own_level;
				self.pk_naprop_level := pk_naprop_level;
				self.pk_naprop_level2_b1 := pk_naprop_level2_b1;
				self.pk_naprop_level2 := pk_naprop_level2;
				self.pk_yr_add1_built_date2 := pk_yr_add1_built_date2;
				self.pk_add1_purchase_amount2 := pk_add1_purchase_amount2;
				self.pk_add1_mortgage_amount2 := pk_add1_mortgage_amount2;
				self.pk_yr_add1_mortgage_date2 := pk_yr_add1_mortgage_date2;
				self.pk_add1_adjustable_financing := pk_add1_adjustable_financing;
				self.pk_add1_assessed_amount2 := pk_add1_assessed_amount2;
				self.pk_yr_add1_date_first_seen2 := pk_yr_add1_date_first_seen2;
				self.pk_add1_building_area2 := pk_add1_building_area2;
				self.pk_add1_no_of_rooms := pk_add1_no_of_rooms;
				self.pk_add1_garage_type_risk_level := pk_add1_garage_type_risk_level;
				self.pk_add1_style_code_level := pk_add1_style_code_level;
				self.pk_property_owned_total := pk_property_owned_total;
				self.pk_prop1_prev_purchase_price2 := pk_prop1_prev_purchase_price2;
				self.pk_add2_building_area2 := pk_add2_building_area2;
				self.pk_add2_no_of_buildings := pk_add2_no_of_buildings;
				self.pk_add2_no_of_rooms := pk_add2_no_of_rooms;
				self.pk_add2_style_code_level := pk_add2_style_code_level;
				self.pk_yr_add2_assessed_value_year2 := pk_yr_add2_assessed_value_year2;
				self.pk_add2_purchase_amount2 := pk_add2_purchase_amount2;
				self.pk_add2_mortgage_risk := pk_add2_mortgage_risk;
				self.pk_add2_assessed_amount2 := pk_add2_assessed_amount2;
				self.pk_yr_add2_date_first_seen2 := pk_yr_add2_date_first_seen2;
				self.pk_yr_add2_date_last_seen2 := pk_yr_add2_date_last_seen2;
				self.pk_add3_purchase_amount2 := pk_add3_purchase_amount2;
				self.pk_add3_mortgage_risk := pk_add3_mortgage_risk;
				self.pk_add3_assessed_amount2 := pk_add3_assessed_amount2;
				self.pk_yr_add3_date_first_seen2 := pk_yr_add3_date_first_seen2;
				self.pk_yr_add3_date_last_seen2 := pk_yr_add3_date_last_seen2;
				self.pk_attr_num_sold180 := pk_attr_num_sold180;
				self.pk_attr_num_watercraft180 := pk_attr_num_watercraft180;
				self.pk_yr_liens_last_unrel_date := pk_yr_liens_last_unrel_date;
				self.pk_yr_liens_unrel_lt_first_seen := pk_yr_liens_unrel_lt_first_seen;
				self.pk_yr_liens_unrel_ot_first_seen := pk_yr_liens_unrel_ot_first_seen;
				self.pk_yr_attr_date_last_eviction := pk_yr_attr_date_last_eviction;
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
				self.pk_yr_attr_date_last_eviction2 := pk_yr_attr_date_last_eviction2;
				self.pk_eviction_level := pk_eviction_level;
				self.pk_crime_level := pk_crime_level;
				self.pk_attr_total_number_derogs_3 := pk_attr_total_number_derogs_3;
				self.pk_yr_rc_ssnhighissue := pk_yr_rc_ssnhighissue;
				self.pk_add_standarization_error := pk_add_standarization_error;
				self.pk_addr_changed := pk_addr_changed;
				self.pk_unit_changed := pk_unit_changed;
				self.pk_add_standarization_flag := pk_add_standarization_flag;
				self.pk_addr_not_valid := pk_addr_not_valid;
				self.pk_area_code_split := pk_area_code_split;
				self.pk_yr_rc_ssnhighissue2 := pk_yr_rc_ssnhighissue2;
				self.pk_pl_sourced_level := pk_pl_sourced_level;
				self.pk_prof_lic_cat := pk_prof_lic_cat;
				self.pk_add_lres_month_avg := pk_add_lres_month_avg;
				self.pk_add1_lres := pk_add1_lres;
				self.pk_add3_lres := pk_add3_lres;
				self.pk_addrs_5yr := pk_addrs_5yr;
				self.pk_addrs_10yr := pk_addrs_10yr;
				self.pk_addrs_15yr := pk_addrs_15yr;
				self.pk_add_lres_month_avg2 := pk_add_lres_month_avg2;
				self.pk_nameperssn_count := pk_nameperssn_count;
				self.pk_ssns_per_adl := pk_ssns_per_adl;
				self.pk_addrs_per_adl := pk_addrs_per_adl;
				self.pk_phones_per_adl := pk_phones_per_adl;
				self.pk_adlperssn_count := pk_adlperssn_count;
				self.pk_adls_per_addr_b1 := pk_adls_per_addr_b1;
				self.pk_ssns_per_addr2_b1 := pk_ssns_per_addr2_b1;
				self.pk_adls_per_addr_b2 := pk_adls_per_addr_b2;
				self.pk_ssns_per_addr2_b2 := pk_ssns_per_addr2_b2;
				self.pk_phones_per_addr_b2 := pk_phones_per_addr_b2;
				self.pk_phones_per_addr := pk_phones_per_addr;
				self.pk_adls_per_addr := pk_adls_per_addr;
				self.pk_ssns_per_addr2 := pk_ssns_per_addr2;
				self.pk_adls_per_phone := pk_adls_per_phone;
				self.pk_ssns_per_adl_c6 := pk_ssns_per_adl_c6;
				self.pk_ssns_per_addr_c6_b1 := pk_ssns_per_addr_c6_b1;
				self.pk_ssns_per_addr_c6_b2 := pk_ssns_per_addr_c6_b2;
				self.pk_ssns_per_addr_c6 := pk_ssns_per_addr_c6;
				self.pk_adls_per_phone_c6 := pk_adls_per_phone_c6;
				self.pk_vo_addrs_per_adl := pk_vo_addrs_per_adl;
				self.pk_attr_addrs_last24 := pk_attr_addrs_last24;
				self.pk_college_tier := pk_college_tier;
				self.ams_class_n_b8 := ams_class_n_b8;
				self.ams_class_n_b8_2 := ams_class_n_b8_2;
				self.pk_ams_class_level_b8 := pk_ams_class_level_b8;
				self.pk_since_ams_class_year := pk_since_ams_class_year;
				self.ams_class_n := ams_class_n;
				self.pk_ams_class_level := pk_ams_class_level;
				self.pk_ams_income_level_code := pk_ams_income_level_code;
				self.pk_yr_in_dob := pk_yr_in_dob;
				self.pk_yr_reported_dob := pk_yr_reported_dob;
				self.pk_yr_in_dob2 := pk_yr_in_dob2;
				self.pk_ams_age := pk_ams_age;
				self.pk_inferred_age := pk_inferred_age;
				self.pk_yr_reported_dob2 := pk_yr_reported_dob2;
				self.pk_add1_avm_sp := pk_add1_avm_sp;
				self.pk_add1_avm_as := pk_add1_avm_as;
				self.pk_add1_avm_auto2 := pk_add1_avm_auto2;
				self.pk_add1_avm_auto3 := pk_add1_avm_auto3;
				self.pk_add1_avm_med := pk_add1_avm_med;
				self.pk_add2_avm_hed := pk_add2_avm_hed;
				self.pk_add2_avm_auto := pk_add2_avm_auto;
				self.pk_add2_avm_auto3 := pk_add2_avm_auto3;
				self.pk_add1_avm_sp_2 := pk_add1_avm_sp_2;
				self.pk_add1_avm_as_2 := pk_add1_avm_as_2;
				self.pk_add1_avm_auto2_2 := pk_add1_avm_auto2_2;
				self.pk_add1_avm_auto3_2 := pk_add1_avm_auto3_2;
				self.pk_add1_avm_med_2 := pk_add1_avm_med_2;
				self.pk_add2_avm_hed_2 := pk_add2_avm_hed_2;
				self.pk_add2_avm_auto_2 := pk_add2_avm_auto_2;
				self.pk_add2_avm_auto3_2 := pk_add2_avm_auto3_2;
				self.pk_add1_avm_to_med_ratio := pk_add1_avm_to_med_ratio;
				self.pk_add1_avm_to_med_ratio_2 := pk_add1_avm_to_med_ratio_2;
				self.pk2_add1_avm_sp := pk2_add1_avm_sp;
				self.pk2_add1_avm_as := pk2_add1_avm_as;
				self.pk2_add1_avm_auto2 := pk2_add1_avm_auto2;
				self.pk2_add1_avm_auto3 := pk2_add1_avm_auto3;
				self.pk2_add1_avm_med := pk2_add1_avm_med;
				self.pk2_add1_avm_to_med_ratio := pk2_add1_avm_to_med_ratio;
				self.pk_add2_avm_hit := pk_add2_avm_hit;
				self.pk_avm_hit_level := pk_avm_hit_level;
				self.pk2_add2_avm_hed := pk2_add2_avm_hed;
				self.pk2_add2_avm_auto3 := pk2_add2_avm_auto3;
				self.pk_add2_avm_auto_diff3 := pk_add2_avm_auto_diff3;
				self.pk_add2_avm_auto_diff3_lvl := pk_add2_avm_auto_diff3_lvl;
				self.pk_dist_a1toa2_2 := pk_dist_a1toa2_2;
				self.pk_dist_a1toa3_2 := pk_dist_a1toa3_2;
				self.pk_out_st_division_lvl := pk_out_st_division_lvl;
				self.pk_impulse_count := pk_impulse_count;
				self.pk_impulse_count_2 := pk_impulse_count_2;
				self.pk_attr_total_number_derogs_4 := pk_attr_total_number_derogs_4;
				self.pk_attr_total_number_derogs_5 := pk_attr_total_number_derogs_5;
				self.pk_attr_num_nonderogs90_3 := pk_attr_num_nonderogs90_3;
				self.pk_attr_num_nonderogs90_4 := pk_attr_num_nonderogs90_4;
				self.pk_attr_num_nonderogs90_b := pk_attr_num_nonderogs90_b;
				self.pk_adl_cat_deceased := pk_adl_cat_deceased;
				self.bs_attr_derog_flag := bs_attr_derog_flag;
				self.bs_attr_eviction_flag := bs_attr_eviction_flag;
				self.bs_attr_derog_flag2 := bs_attr_derog_flag2;
				self.pk_own_flag := pk_own_flag;
				self.pk_Segment3 := pk_Segment3;
				self.pk_segment3_2 := pk_segment3_2;
				self.pk_nas_summary_mm_b1_c2_b1 := pk_nas_summary_mm_b1_c2_b1;
				self.pk_nap_summary_mm_b1_c2_b1 := pk_nap_summary_mm_b1_c2_b1;
				self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
				self.pk_adl_score_mm_b1_c2_b1 := pk_adl_score_mm_b1_c2_b1;
				self.pk_combo_hphonescore_mm_b1_c2_b1 := pk_combo_hphonescore_mm_b1_c2_b1;
				self.pk_combo_ssnscore_mm_b1_c2_b1 := pk_combo_ssnscore_mm_b1_c2_b1;
				self.pk_combo_dobscore_mm_b1_c2_b1 := pk_combo_dobscore_mm_b1_c2_b1;
				self.pk_combo_fnamecount_mm_b1_c2_b1 := pk_combo_fnamecount_mm_b1_c2_b1;
				self.pk_rc_phonelnamecount_mm_b1_c2_b1 := pk_rc_phonelnamecount_mm_b1_c2_b1;
				self.pk_rc_addrcount_mm_b1_c2_b1 := pk_rc_addrcount_mm_b1_c2_b1;
				self.pk_rc_phonephonecount_mm_b1_c2_b1 := pk_rc_phonephonecount_mm_b1_c2_b1;
				self.pk_ver_phncount_mm_b1_c2_b1 := pk_ver_phncount_mm_b1_c2_b1;
				self.pk_gong_did_phone_ct_mm_b1_c2_b1 := pk_gong_did_phone_ct_mm_b1_c2_b1;
				self.pk_combo_ssncount_mm_b1_c2_b1 := pk_combo_ssncount_mm_b1_c2_b1;
				self.pk_combo_dobcount_mm_b1_c2_b1 := pk_combo_dobcount_mm_b1_c2_b1;
				self.pk_eq_count_mm_b1_c2_b1 := pk_eq_count_mm_b1_c2_b1;
				self.pk_pos_secondary_sources_mm_b1_c2_b1 := pk_pos_secondary_sources_mm_b1_c2_b1;
				self.pk_voter_flag_mm_b1_c2_b1 := pk_voter_flag_mm_b1_c2_b1;
				self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b1;
				self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
				self.pk_add1_address_score_mm_b1_c2_b1 := pk_add1_address_score_mm_b1_c2_b1;
				self.pk_add2_address_score_mm_b1_c2_b1 := pk_add2_address_score_mm_b1_c2_b1;
				self.pk_add2_pos_sources_mm_b1_c2_b1 := pk_add2_pos_sources_mm_b1_c2_b1;
				self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
				self.pk_infutor_risk_lvl_mm_b1_c2_b1 := pk_infutor_risk_lvl_mm_b1_c2_b1;
				self.pk_yr_adl_em_first_seen2_mm_b1_c2_b1 := pk_yr_adl_em_first_seen2_mm_b1_c2_b1;
				self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b1 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b1;
				self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
				self.pk_yr_lname_change_date2_mm_b1_c2_b1 := pk_yr_lname_change_date2_mm_b1_c2_b1;
				self.pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
				self.pk_yr_credit_first_seen2_mm_b1_c2_b1 := pk_yr_credit_first_seen2_mm_b1_c2_b1;
				self.pk_yr_header_first_seen2_mm_b1_c2_b1 := pk_yr_header_first_seen2_mm_b1_c2_b1;
				self.pk_yr_infutor_first_seen2_mm_b1_c2_b1 := pk_yr_infutor_first_seen2_mm_b1_c2_b1;
				self.pk_add2_em_ver_lvl_mm_b1_c2_b1 := pk_add2_em_ver_lvl_mm_b1_c2_b1;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
				self.pk_nas_summary_mm_b1_c2_b2 := pk_nas_summary_mm_b1_c2_b2;
				self.pk_nap_summary_mm_b1_c2_b2 := pk_nap_summary_mm_b1_c2_b2;
				self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
				self.pk_adl_score_mm_b1_c2_b2 := pk_adl_score_mm_b1_c2_b2;
				self.pk_combo_hphonescore_mm_b1_c2_b2 := pk_combo_hphonescore_mm_b1_c2_b2;
				self.pk_combo_ssnscore_mm_b1_c2_b2 := pk_combo_ssnscore_mm_b1_c2_b2;
				self.pk_combo_dobscore_mm_b1_c2_b2 := pk_combo_dobscore_mm_b1_c2_b2;
				self.pk_combo_fnamecount_mm_b1_c2_b2 := pk_combo_fnamecount_mm_b1_c2_b2;
				self.pk_rc_phonelnamecount_mm_b1_c2_b2 := pk_rc_phonelnamecount_mm_b1_c2_b2;
				self.pk_rc_addrcount_mm_b1_c2_b2 := pk_rc_addrcount_mm_b1_c2_b2;
				self.pk_rc_phonephonecount_mm_b1_c2_b2 := pk_rc_phonephonecount_mm_b1_c2_b2;
				self.pk_ver_phncount_mm_b1_c2_b2 := pk_ver_phncount_mm_b1_c2_b2;
				self.pk_gong_did_phone_ct_mm_b1_c2_b2 := pk_gong_did_phone_ct_mm_b1_c2_b2;
				self.pk_combo_ssncount_mm_b1_c2_b2 := pk_combo_ssncount_mm_b1_c2_b2;
				self.pk_combo_dobcount_mm_b1_c2_b2 := pk_combo_dobcount_mm_b1_c2_b2;
				self.pk_eq_count_mm_b1_c2_b2 := pk_eq_count_mm_b1_c2_b2;
				self.pk_pos_secondary_sources_mm_b1_c2_b2 := pk_pos_secondary_sources_mm_b1_c2_b2;
				self.pk_voter_flag_mm_b1_c2_b2 := pk_voter_flag_mm_b1_c2_b2;
				self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b2;
				self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
				self.pk_add1_address_score_mm_b1_c2_b2 := pk_add1_address_score_mm_b1_c2_b2;
				self.pk_add2_address_score_mm_b1_c2_b2 := pk_add2_address_score_mm_b1_c2_b2;
				self.pk_add2_pos_sources_mm_b1_c2_b2 := pk_add2_pos_sources_mm_b1_c2_b2;
				self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
				self.pk_infutor_risk_lvl_mm_b1_c2_b2 := pk_infutor_risk_lvl_mm_b1_c2_b2;
				self.pk_yr_adl_em_first_seen2_mm_b1_c2_b2 := pk_yr_adl_em_first_seen2_mm_b1_c2_b2;
				self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b2 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b2;
				self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
				self.pk_yr_lname_change_date2_mm_b1_c2_b2 := pk_yr_lname_change_date2_mm_b1_c2_b2;
				self.pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
				self.pk_yr_credit_first_seen2_mm_b1_c2_b2 := pk_yr_credit_first_seen2_mm_b1_c2_b2;
				self.pk_yr_header_first_seen2_mm_b1_c2_b2 := pk_yr_header_first_seen2_mm_b1_c2_b2;
				self.pk_yr_infutor_first_seen2_mm_b1_c2_b2 := pk_yr_infutor_first_seen2_mm_b1_c2_b2;
				self.pk_add2_em_ver_lvl_mm_b1_c2_b2 := pk_add2_em_ver_lvl_mm_b1_c2_b2;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
				self.pk_nas_summary_mm_b1_c2_b3 := pk_nas_summary_mm_b1_c2_b3;
				self.pk_nap_summary_mm_b1_c2_b3 := pk_nap_summary_mm_b1_c2_b3;
				self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
				self.pk_adl_score_mm_b1_c2_b3 := pk_adl_score_mm_b1_c2_b3;
				self.pk_combo_hphonescore_mm_b1_c2_b3 := pk_combo_hphonescore_mm_b1_c2_b3;
				self.pk_combo_ssnscore_mm_b1_c2_b3 := pk_combo_ssnscore_mm_b1_c2_b3;
				self.pk_combo_dobscore_mm_b1_c2_b3 := pk_combo_dobscore_mm_b1_c2_b3;
				self.pk_combo_fnamecount_mm_b1_c2_b3 := pk_combo_fnamecount_mm_b1_c2_b3;
				self.pk_rc_phonelnamecount_mm_b1_c2_b3 := pk_rc_phonelnamecount_mm_b1_c2_b3;
				self.pk_rc_addrcount_mm_b1_c2_b3 := pk_rc_addrcount_mm_b1_c2_b3;
				self.pk_rc_phonephonecount_mm_b1_c2_b3 := pk_rc_phonephonecount_mm_b1_c2_b3;
				self.pk_ver_phncount_mm_b1_c2_b3 := pk_ver_phncount_mm_b1_c2_b3;
				self.pk_gong_did_phone_ct_mm_b1_c2_b3 := pk_gong_did_phone_ct_mm_b1_c2_b3;
				self.pk_combo_ssncount_mm_b1_c2_b3 := pk_combo_ssncount_mm_b1_c2_b3;
				self.pk_combo_dobcount_mm_b1_c2_b3 := pk_combo_dobcount_mm_b1_c2_b3;
				self.pk_eq_count_mm_b1_c2_b3 := pk_eq_count_mm_b1_c2_b3;
				self.pk_pos_secondary_sources_mm_b1_c2_b3 := pk_pos_secondary_sources_mm_b1_c2_b3;
				self.pk_voter_flag_mm_b1_c2_b3 := pk_voter_flag_mm_b1_c2_b3;
				self.pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3 := pk_fname_eda_sourced_type_lvl_mm_b1_c2_b3;
				self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
				self.pk_add1_address_score_mm_b1_c2_b3 := pk_add1_address_score_mm_b1_c2_b3;
				self.pk_add2_address_score_mm_b1_c2_b3 := pk_add2_address_score_mm_b1_c2_b3;
				self.pk_add2_pos_sources_mm_b1_c2_b3 := pk_add2_pos_sources_mm_b1_c2_b3;
				self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
				self.pk_infutor_risk_lvl_mm_b1_c2_b3 := pk_infutor_risk_lvl_mm_b1_c2_b3;
				self.pk_yr_adl_em_first_seen2_mm_b1_c2_b3 := pk_yr_adl_em_first_seen2_mm_b1_c2_b3;
				self.pk_yr_adl_vo_first_seen2_mm_b1_c2_b3 := pk_yr_adl_vo_first_seen2_mm_b1_c2_b3;
				self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
				self.pk_yr_lname_change_date2_mm_b1_c2_b3 := pk_yr_lname_change_date2_mm_b1_c2_b3;
				self.pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
				self.pk_yr_credit_first_seen2_mm_b1_c2_b3 := pk_yr_credit_first_seen2_mm_b1_c2_b3;
				self.pk_yr_header_first_seen2_mm_b1_c2_b3 := pk_yr_header_first_seen2_mm_b1_c2_b3;
				self.pk_yr_infutor_first_seen2_mm_b1_c2_b3 := pk_yr_infutor_first_seen2_mm_b1_c2_b3;
				self.pk_add2_em_ver_lvl_mm_b1_c2_b3 := pk_add2_em_ver_lvl_mm_b1_c2_b3;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
				self.pk_nap_summary_mm_b1 := pk_nap_summary_mm_b1;
				self.pk_yr_infutor_first_seen2_mm_b1 := pk_yr_infutor_first_seen2_mm_b1;
				self.pk_yr_lname_change_date2_mm_b1 := pk_yr_lname_change_date2_mm_b1;
				self.pk_ssnchar_invalid_or_recent_mm_b1 := pk_ssnchar_invalid_or_recent_mm_b1;
				self.pk_yr_adl_em_first_seen2_mm_b1 := pk_yr_adl_em_first_seen2_mm_b1;
				self.pk_adl_score_mm_b1 := pk_adl_score_mm_b1;
				self.pk_rc_phonelnamecount_mm_b1 := pk_rc_phonelnamecount_mm_b1;
				self.pk_rc_dirsaddr_lastscore_mm_b1 := pk_rc_dirsaddr_lastscore_mm_b1;
				self.pk_combo_ssncount_mm_b1 := pk_combo_ssncount_mm_b1;
				self.pk_yr_adl_vo_first_seen2_mm_b1 := pk_yr_adl_vo_first_seen2_mm_b1;
				self.pk_pos_secondary_sources_mm_b1 := pk_pos_secondary_sources_mm_b1;
				self.pk_voter_flag_mm_b1 := pk_voter_flag_mm_b1;
				self.pk_add2_address_score_mm_b1 := pk_add2_address_score_mm_b1;
				self.pk_combo_ssnscore_mm_b1 := pk_combo_ssnscore_mm_b1;
				self.pk_lname_eda_sourced_type_lvl_mm_b1 := pk_lname_eda_sourced_type_lvl_mm_b1;
				self.pk_combo_dobscore_mm_b1 := pk_combo_dobscore_mm_b1;
				self.pk_ver_phncount_mm_b1 := pk_ver_phncount_mm_b1;
				self.pk_combo_dobcount_mm_b1 := pk_combo_dobcount_mm_b1;
				self.pk_nas_summary_mm_b1 := pk_nas_summary_mm_b1;
				self.pk_rc_addrcount_mm_b1 := pk_rc_addrcount_mm_b1;
				self.pk_gong_did_phone_ct_mm_b1 := pk_gong_did_phone_ct_mm_b1;
				self.pk_yr_gong_did_first_seen2_mm_b1 := pk_yr_gong_did_first_seen2_mm_b1;
				self.pk_combo_hphonescore_mm_b1 := pk_combo_hphonescore_mm_b1;
				self.pk_yr_adl_em_only_first_seen2_mm_b1 := pk_yr_adl_em_only_first_seen2_mm_b1;
				self.pk_add2_em_ver_lvl_mm_b1 := pk_add2_em_ver_lvl_mm_b1;
				self.pk_yr_credit_first_seen2_mm_b1 := pk_yr_credit_first_seen2_mm_b1;
				self.pk_eq_count_mm_b1 := pk_eq_count_mm_b1;
				self.pk_yr_header_first_seen2_mm_b1 := pk_yr_header_first_seen2_mm_b1;
				self.pk_add1_address_score_mm_b1 := pk_add1_address_score_mm_b1;
				self.pk_combo_fnamecount_mm_b1 := pk_combo_fnamecount_mm_b1;
				self.pk_rc_phonephonecount_mm_b1 := pk_rc_phonephonecount_mm_b1;
				self.pk_add2_pos_sources_mm_b1 := pk_add2_pos_sources_mm_b1;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
				self.pk_fname_eda_sourced_type_lvl_mm_b1 := pk_fname_eda_sourced_type_lvl_mm_b1;
				self.pk_infutor_risk_lvl_mm_b1 := pk_infutor_risk_lvl_mm_b1;
				self.pk_nas_summary_mm_b2_c2_b1 := pk_nas_summary_mm_b2_c2_b1;
				self.pk_nap_summary_mm_b2_c2_b1 := pk_nap_summary_mm_b2_c2_b1;
				self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
				self.pk_adl_score_mm_b2_c2_b1 := pk_adl_score_mm_b2_c2_b1;
				self.pk_combo_hphonescore_mm_b2_c2_b1 := pk_combo_hphonescore_mm_b2_c2_b1;
				self.pk_combo_ssnscore_mm_b2_c2_b1 := pk_combo_ssnscore_mm_b2_c2_b1;
				self.pk_combo_dobscore_mm_b2_c2_b1 := pk_combo_dobscore_mm_b2_c2_b1;
				self.pk_combo_fnamecount_nb_mm_b2_c2_b1 := pk_combo_fnamecount_nb_mm_b2_c2_b1;
				self.pk_rc_phonelnamecount_mm_b2_c2_b1 := pk_rc_phonelnamecount_mm_b2_c2_b1;
				self.pk_combo_addrcount_nb_mm_b2_c2_b1 := pk_combo_addrcount_nb_mm_b2_c2_b1;
				self.pk_rc_addrcount_nb_mm_b2_c2_b1 := pk_rc_addrcount_nb_mm_b2_c2_b1;
				self.pk_rc_phonephonecount_mm_b2_c2_b1 := pk_rc_phonephonecount_mm_b2_c2_b1;
				self.pk_ver_phncount_mm_b2_c2_b1 := pk_ver_phncount_mm_b2_c2_b1;
				self.pk_gong_did_phone_ct_nb_mm_b2_c2_b1 := pk_gong_did_phone_ct_nb_mm_b2_c2_b1;
				self.pk_combo_ssncount_mm_b2_c2_b1 := pk_combo_ssncount_mm_b2_c2_b1;
				self.pk_combo_dobcount_nb_mm_b2_c2_b1 := pk_combo_dobcount_nb_mm_b2_c2_b1;
				self.pk_eq_count_mm_b2_c2_b1 := pk_eq_count_mm_b2_c2_b1;
				self.pk_pos_secondary_sources_mm_b2_c2_b1 := pk_pos_secondary_sources_mm_b2_c2_b1;
				self.pk_voter_flag_mm_b2_c2_b1 := pk_voter_flag_mm_b2_c2_b1;
				self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b1;
				self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
				self.pk_add1_address_score_mm_b2_c2_b1 := pk_add1_address_score_mm_b2_c2_b1;
				self.pk_add2_address_score_mm_b2_c2_b1 := pk_add2_address_score_mm_b2_c2_b1;
				self.pk_add2_pos_sources_mm_b2_c2_b1 := pk_add2_pos_sources_mm_b2_c2_b1;
				self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
				self.pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
				self.pk_yr_adl_em_first_seen2_mm_b2_c2_b1 := pk_yr_adl_em_first_seen2_mm_b2_c2_b1;
				self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b1 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b1;
				self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
				self.pk_yr_lname_change_date2_mm_b2_c2_b1 := pk_yr_lname_change_date2_mm_b2_c2_b1;
				self.pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
				self.pk_yr_credit_first_seen2_mm_b2_c2_b1 := pk_yr_credit_first_seen2_mm_b2_c2_b1;
				self.pk_yr_header_first_seen2_mm_b2_c2_b1 := pk_yr_header_first_seen2_mm_b2_c2_b1;
				self.pk_yr_infutor_first_seen2_mm_b2_c2_b1 := pk_yr_infutor_first_seen2_mm_b2_c2_b1;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
				self.pk_nas_summary_mm_b2_c2_b2 := pk_nas_summary_mm_b2_c2_b2;
				self.pk_nap_summary_mm_b2_c2_b2 := pk_nap_summary_mm_b2_c2_b2;
				self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
				self.pk_adl_score_mm_b2_c2_b2 := pk_adl_score_mm_b2_c2_b2;
				self.pk_combo_hphonescore_mm_b2_c2_b2 := pk_combo_hphonescore_mm_b2_c2_b2;
				self.pk_combo_ssnscore_mm_b2_c2_b2 := pk_combo_ssnscore_mm_b2_c2_b2;
				self.pk_combo_dobscore_mm_b2_c2_b2 := pk_combo_dobscore_mm_b2_c2_b2;
				self.pk_combo_fnamecount_nb_mm_b2_c2_b2 := pk_combo_fnamecount_nb_mm_b2_c2_b2;
				self.pk_rc_phonelnamecount_mm_b2_c2_b2 := pk_rc_phonelnamecount_mm_b2_c2_b2;
				self.pk_combo_addrcount_nb_mm_b2_c2_b2 := pk_combo_addrcount_nb_mm_b2_c2_b2;
				self.pk_rc_addrcount_nb_mm_b2_c2_b2 := pk_rc_addrcount_nb_mm_b2_c2_b2;
				self.pk_rc_phonephonecount_mm_b2_c2_b2 := pk_rc_phonephonecount_mm_b2_c2_b2;
				self.pk_ver_phncount_mm_b2_c2_b2 := pk_ver_phncount_mm_b2_c2_b2;
				self.pk_gong_did_phone_ct_nb_mm_b2_c2_b2 := pk_gong_did_phone_ct_nb_mm_b2_c2_b2;
				self.pk_combo_ssncount_mm_b2_c2_b2 := pk_combo_ssncount_mm_b2_c2_b2;
				self.pk_combo_dobcount_nb_mm_b2_c2_b2 := pk_combo_dobcount_nb_mm_b2_c2_b2;
				self.pk_eq_count_mm_b2_c2_b2 := pk_eq_count_mm_b2_c2_b2;
				self.pk_pos_secondary_sources_mm_b2_c2_b2 := pk_pos_secondary_sources_mm_b2_c2_b2;
				self.pk_voter_flag_mm_b2_c2_b2 := pk_voter_flag_mm_b2_c2_b2;
				self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b2;
				self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
				self.pk_add1_address_score_mm_b2_c2_b2 := pk_add1_address_score_mm_b2_c2_b2;
				self.pk_add2_address_score_mm_b2_c2_b2 := pk_add2_address_score_mm_b2_c2_b2;
				self.pk_add2_pos_sources_mm_b2_c2_b2 := pk_add2_pos_sources_mm_b2_c2_b2;
				self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
				self.pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
				self.pk_yr_adl_em_first_seen2_mm_b2_c2_b2 := pk_yr_adl_em_first_seen2_mm_b2_c2_b2;
				self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b2 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b2;
				self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
				self.pk_yr_lname_change_date2_mm_b2_c2_b2 := pk_yr_lname_change_date2_mm_b2_c2_b2;
				self.pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
				self.pk_yr_credit_first_seen2_mm_b2_c2_b2 := pk_yr_credit_first_seen2_mm_b2_c2_b2;
				self.pk_yr_header_first_seen2_mm_b2_c2_b2 := pk_yr_header_first_seen2_mm_b2_c2_b2;
				self.pk_yr_infutor_first_seen2_mm_b2_c2_b2 := pk_yr_infutor_first_seen2_mm_b2_c2_b2;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
				self.pk_nas_summary_mm_b2_c2_b3 := pk_nas_summary_mm_b2_c2_b3;
				self.pk_nap_summary_mm_b2_c2_b3 := pk_nap_summary_mm_b2_c2_b3;
				self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
				self.pk_adl_score_mm_b2_c2_b3 := pk_adl_score_mm_b2_c2_b3;
				self.pk_combo_hphonescore_mm_b2_c2_b3 := pk_combo_hphonescore_mm_b2_c2_b3;
				self.pk_combo_ssnscore_mm_b2_c2_b3 := pk_combo_ssnscore_mm_b2_c2_b3;
				self.pk_combo_dobscore_mm_b2_c2_b3 := pk_combo_dobscore_mm_b2_c2_b3;
				self.pk_combo_fnamecount_nb_mm_b2_c2_b3 := pk_combo_fnamecount_nb_mm_b2_c2_b3;
				self.pk_rc_phonelnamecount_mm_b2_c2_b3 := pk_rc_phonelnamecount_mm_b2_c2_b3;
				self.pk_combo_addrcount_nb_mm_b2_c2_b3 := pk_combo_addrcount_nb_mm_b2_c2_b3;
				self.pk_rc_addrcount_nb_mm_b2_c2_b3 := pk_rc_addrcount_nb_mm_b2_c2_b3;
				self.pk_rc_phonephonecount_mm_b2_c2_b3 := pk_rc_phonephonecount_mm_b2_c2_b3;
				self.pk_ver_phncount_mm_b2_c2_b3 := pk_ver_phncount_mm_b2_c2_b3;
				self.pk_gong_did_phone_ct_nb_mm_b2_c2_b3 := pk_gong_did_phone_ct_nb_mm_b2_c2_b3;
				self.pk_combo_ssncount_mm_b2_c2_b3 := pk_combo_ssncount_mm_b2_c2_b3;
				self.pk_combo_dobcount_nb_mm_b2_c2_b3 := pk_combo_dobcount_nb_mm_b2_c2_b3;
				self.pk_eq_count_mm_b2_c2_b3 := pk_eq_count_mm_b2_c2_b3;
				self.pk_pos_secondary_sources_mm_b2_c2_b3 := pk_pos_secondary_sources_mm_b2_c2_b3;
				self.pk_voter_flag_mm_b2_c2_b3 := pk_voter_flag_mm_b2_c2_b3;
				self.pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3 := pk_fname_eda_sourced_type_lvl_mm_b2_c2_b3;
				self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
				self.pk_add1_address_score_mm_b2_c2_b3 := pk_add1_address_score_mm_b2_c2_b3;
				self.pk_add2_address_score_mm_b2_c2_b3 := pk_add2_address_score_mm_b2_c2_b3;
				self.pk_add2_pos_sources_mm_b2_c2_b3 := pk_add2_pos_sources_mm_b2_c2_b3;
				self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
				self.pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
				self.pk_yr_adl_em_first_seen2_mm_b2_c2_b3 := pk_yr_adl_em_first_seen2_mm_b2_c2_b3;
				self.pk_yr_adl_vo_first_seen2_mm_b2_c2_b3 := pk_yr_adl_vo_first_seen2_mm_b2_c2_b3;
				self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
				self.pk_yr_lname_change_date2_mm_b2_c2_b3 := pk_yr_lname_change_date2_mm_b2_c2_b3;
				self.pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
				self.pk_yr_credit_first_seen2_mm_b2_c2_b3 := pk_yr_credit_first_seen2_mm_b2_c2_b3;
				self.pk_yr_header_first_seen2_mm_b2_c2_b3 := pk_yr_header_first_seen2_mm_b2_c2_b3;
				self.pk_yr_infutor_first_seen2_mm_b2_c2_b3 := pk_yr_infutor_first_seen2_mm_b2_c2_b3;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
				self.pk_nap_summary_mm_b2 := pk_nap_summary_mm_b2;
				self.pk_yr_infutor_first_seen2_mm_b2 := pk_yr_infutor_first_seen2_mm_b2;
				self.pk_yr_lname_change_date2_mm_b2 := pk_yr_lname_change_date2_mm_b2;
				self.pk_ssnchar_invalid_or_recent_mm_b2 := pk_ssnchar_invalid_or_recent_mm_b2;
				self.pk_gong_did_phone_ct_nb_mm_b2 := pk_gong_did_phone_ct_nb_mm_b2;
				self.pk_yr_adl_em_first_seen2_mm_b2 := pk_yr_adl_em_first_seen2_mm_b2;
				self.pk_adl_score_mm_b2 := pk_adl_score_mm_b2;
				self.pk_combo_dobcount_nb_mm_b2 := pk_combo_dobcount_nb_mm_b2;
				self.pk_rc_phonelnamecount_mm_b2 := pk_rc_phonelnamecount_mm_b2;
				self.pk_combo_fnamecount_nb_mm_b2 := pk_combo_fnamecount_nb_mm_b2;
				self.pk_rc_dirsaddr_lastscore_mm_b2 := pk_rc_dirsaddr_lastscore_mm_b2;
				self.pk_combo_ssncount_mm_b2 := pk_combo_ssncount_mm_b2;
				self.pk_yr_adl_vo_first_seen2_mm_b2 := pk_yr_adl_vo_first_seen2_mm_b2;
				self.pk_pos_secondary_sources_mm_b2 := pk_pos_secondary_sources_mm_b2;
				self.pk_voter_flag_mm_b2 := pk_voter_flag_mm_b2;
				self.pk_add2_address_score_mm_b2 := pk_add2_address_score_mm_b2;
				self.pk_combo_ssnscore_mm_b2 := pk_combo_ssnscore_mm_b2;
				self.pk_lname_eda_sourced_type_lvl_mm_b2 := pk_lname_eda_sourced_type_lvl_mm_b2;
				self.pk_combo_dobscore_mm_b2 := pk_combo_dobscore_mm_b2;
				self.pk_ver_phncount_mm_b2 := pk_ver_phncount_mm_b2;
				self.pk_nas_summary_mm_b2 := pk_nas_summary_mm_b2;
				self.pk_yr_gong_did_first_seen2_mm_b2 := pk_yr_gong_did_first_seen2_mm_b2;
				self.pk_combo_hphonescore_mm_b2 := pk_combo_hphonescore_mm_b2;
				self.pk_yr_adl_em_only_first_seen2_mm_b2 := pk_yr_adl_em_only_first_seen2_mm_b2;
				self.pk_infutor_risk_lvl_nb_mm_b2 := pk_infutor_risk_lvl_nb_mm_b2;
				self.pk_yr_credit_first_seen2_mm_b2 := pk_yr_credit_first_seen2_mm_b2;
				self.pk_combo_addrcount_nb_mm_b2 := pk_combo_addrcount_nb_mm_b2;
				self.pk_yr_header_first_seen2_mm_b2 := pk_yr_header_first_seen2_mm_b2;
				self.pk_eq_count_mm_b2 := pk_eq_count_mm_b2;
				self.pk_add1_address_score_mm_b2 := pk_add1_address_score_mm_b2;
				self.pk_rc_phonephonecount_mm_b2 := pk_rc_phonephonecount_mm_b2;
				self.pk_rc_addrcount_nb_mm_b2 := pk_rc_addrcount_nb_mm_b2;
				self.pk_add2_pos_sources_mm_b2 := pk_add2_pos_sources_mm_b2;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
				self.pk_fname_eda_sourced_type_lvl_mm_b2 := pk_fname_eda_sourced_type_lvl_mm_b2;
				self.pk_nap_summary_mm := pk_nap_summary_mm;
				self.pk_yr_infutor_first_seen2_mm := pk_yr_infutor_first_seen2_mm;
				self.pk_yr_lname_change_date2_mm := pk_yr_lname_change_date2_mm;
				self.pk_ssnchar_invalid_or_recent_mm := pk_ssnchar_invalid_or_recent_mm;
				self.pk_gong_did_phone_ct_nb_mm := pk_gong_did_phone_ct_nb_mm;
				self.pk_yr_adl_em_first_seen2_mm := pk_yr_adl_em_first_seen2_mm;
				self.pk_adl_score_mm := pk_adl_score_mm;
				self.pk_combo_dobcount_nb_mm := pk_combo_dobcount_nb_mm;
				self.pk_rc_phonelnamecount_mm := pk_rc_phonelnamecount_mm;
				self.pk_combo_fnamecount_nb_mm := pk_combo_fnamecount_nb_mm;
				self.pk_rc_dirsaddr_lastscore_mm := pk_rc_dirsaddr_lastscore_mm;
				self.pk_combo_ssncount_mm := pk_combo_ssncount_mm;
				self.pk_yr_adl_vo_first_seen2_mm := pk_yr_adl_vo_first_seen2_mm;
				self.pk_pos_secondary_sources_mm := pk_pos_secondary_sources_mm;
				self.pk_voter_flag_mm := pk_voter_flag_mm;
				self.pk_add2_address_score_mm := pk_add2_address_score_mm;
				self.pk_combo_ssnscore_mm := pk_combo_ssnscore_mm;
				self.pk_lname_eda_sourced_type_lvl_mm := pk_lname_eda_sourced_type_lvl_mm;
				self.pk_combo_dobscore_mm := pk_combo_dobscore_mm;
				self.pk_ver_phncount_mm := pk_ver_phncount_mm;
				self.pk_combo_dobcount_mm := pk_combo_dobcount_mm;
				self.pk_nas_summary_mm := pk_nas_summary_mm;
				self.pk_rc_addrcount_mm := pk_rc_addrcount_mm;
				self.pk_gong_did_phone_ct_mm := pk_gong_did_phone_ct_mm;
				self.pk_yr_gong_did_first_seen2_mm := pk_yr_gong_did_first_seen2_mm;
				self.pk_combo_hphonescore_mm := pk_combo_hphonescore_mm;
				self.pk_yr_adl_em_only_first_seen2_mm := pk_yr_adl_em_only_first_seen2_mm;
				self.pk_infutor_risk_lvl_nb_mm := pk_infutor_risk_lvl_nb_mm;
				self.pk_add2_em_ver_lvl_mm := pk_add2_em_ver_lvl_mm;
				self.pk_yr_credit_first_seen2_mm := pk_yr_credit_first_seen2_mm;
				self.pk_combo_addrcount_nb_mm := pk_combo_addrcount_nb_mm;
				self.pk_eq_count_mm := pk_eq_count_mm;
				self.pk_yr_header_first_seen2_mm := pk_yr_header_first_seen2_mm;
				self.pk_add1_address_score_mm := pk_add1_address_score_mm;
				self.pk_combo_fnamecount_mm := pk_combo_fnamecount_mm;
				self.pk_rc_phonephonecount_mm := pk_rc_phonephonecount_mm;
				self.pk_rc_addrcount_nb_mm := pk_rc_addrcount_nb_mm;
				self.pk_add2_pos_sources_mm := pk_add2_pos_sources_mm;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm := pk_yrmo_adl_f_sn_mx_fcra2_mm;
				self.pk_fname_eda_sourced_type_lvl_mm := pk_fname_eda_sourced_type_lvl_mm;
				self.pk_infutor_risk_lvl_mm := pk_infutor_risk_lvl_mm;
				self.pk_estimated_income_mm_b1 := pk_estimated_income_mm_b1;
				self.pk_yr_adl_pr_first_seen2_mm_b1 := pk_yr_adl_pr_first_seen2_mm_b1;
				self.pk_yr_adl_w_first_seen2_mm_b1 := pk_yr_adl_w_first_seen2_mm_b1;
				self.pk_yr_adl_w_last_seen2_mm_b1 := pk_yr_adl_w_last_seen2_mm_b1;
				self.pk_pr_count_mm_b1 := pk_pr_count_mm_b1;
				self.pk_addrs_sourced_lvl_mm_b1 := pk_addrs_sourced_lvl_mm_b1;
				self.pk_add1_own_level_mm_b1 := pk_add1_own_level_mm_b1;
				self.pk_naprop_level2_mm_b1 := pk_naprop_level2_mm_b1;
				self.pk_yr_add1_built_date2_mm_b1 := pk_yr_add1_built_date2_mm_b1;
				self.pk_add1_purchase_amount2_mm_b1 := pk_add1_purchase_amount2_mm_b1;
				self.pk_add1_mortgage_amount2_mm_b1 := pk_add1_mortgage_amount2_mm_b1;
				self.pk_yr_add1_mortgage_date2_mm_b1 := pk_yr_add1_mortgage_date2_mm_b1;
				self.pk_add1_assessed_amount2_mm_b1 := pk_add1_assessed_amount2_mm_b1;
				self.pk_yr_add1_date_first_seen2_mm_b1 := pk_yr_add1_date_first_seen2_mm_b1;
				self.pk_add1_building_area2_mm_b1 := pk_add1_building_area2_mm_b1;
				self.pk_add1_no_of_rooms_mm_b1 := pk_add1_no_of_rooms_mm_b1;
				self.pk_add1_garage_type_risk_lvl_mm_b1 := pk_add1_garage_type_risk_lvl_mm_b1;
				self.pk_add1_style_code_level_mm_b1 := pk_add1_style_code_level_mm_b1;
				self.pk_property_owned_total_mm_b1 := pk_property_owned_total_mm_b1;
				self.pk_prop1_prev_purchase_price2_mm_b1 := pk_prop1_prev_purchase_price2_mm_b1;
				self.pk_add2_building_area2_mm_b1 := pk_add2_building_area2_mm_b1;
				self.pk_add2_no_of_buildings_mm_b1 := pk_add2_no_of_buildings_mm_b1;
				self.pk_add2_no_of_rooms_mm_b1 := pk_add2_no_of_rooms_mm_b1;
				self.pk_add2_style_code_level_mm_b1 := pk_add2_style_code_level_mm_b1;
				self.pk_add2_purchase_amount2_mm_b1 := pk_add2_purchase_amount2_mm_b1;
				self.pk_add2_mortgage_risk_mm_b1 := pk_add2_mortgage_risk_mm_b1;
				self.pk_add2_assessed_amount2_mm_b1 := pk_add2_assessed_amount2_mm_b1;
				self.pk_yr_add2_date_first_seen2_mm_b1 := pk_yr_add2_date_first_seen2_mm_b1;
				self.pk_yr_add2_date_last_seen2_mm_b1 := pk_yr_add2_date_last_seen2_mm_b1;
				self.pk_add3_purchase_amount2_mm_b1 := pk_add3_purchase_amount2_mm_b1;
				self.pk_add3_mortgage_risk_mm_b1 := pk_add3_mortgage_risk_mm_b1;
				self.pk_add3_assessed_amount2_mm_b1 := pk_add3_assessed_amount2_mm_b1;
				self.pk_yr_add3_date_first_seen2_mm_b1 := pk_yr_add3_date_first_seen2_mm_b1;
				self.pk_yr_add3_date_last_seen2_mm_b1 := pk_yr_add3_date_last_seen2_mm_b1;
				self.pk_bk_level_mm_b1 := pk_bk_level_mm_b1;
				self.pk_eviction_level_mm_b1 := pk_eviction_level_mm_b1;
				self.pk_lien_type_level_mm_b1 := pk_lien_type_level_mm_b1;
				self.pk_yr_liens_last_unrel_date3_mm_b1 := pk_yr_liens_last_unrel_date3_mm_b1;
				self.pk_yr_ln_unrel_lt_f_sn2_mm_b1 := pk_yr_ln_unrel_lt_f_sn2_mm_b1;
				self.pk_yr_ln_unrel_ot_f_sn2_mm_b1 := pk_yr_ln_unrel_ot_f_sn2_mm_b1;
				self.pk_yr_attr_dt_l_eviction2_mm_b1 := pk_yr_attr_dt_l_eviction2_mm_b1;
				self.pk_crime_level_mm_b1 := pk_crime_level_mm_b1;
				self.pk_attr_total_number_derogs_mm_b1 := pk_attr_total_number_derogs_mm_b1;
				self.pk_yr_rc_ssnhighissue2_mm_b1 := pk_yr_rc_ssnhighissue2_mm_b1;
				self.pk_pl_sourced_level_mm_b1 := pk_pl_sourced_level_mm_b1;
				self.pk_prof_lic_cat_mm_b1 := pk_prof_lic_cat_mm_b1;
				self.pk_add1_lres_mm_b1 := pk_add1_lres_mm_b1;
				self.pk_add3_lres_mm_b1 := pk_add3_lres_mm_b1;
				self.pk_addrs_5yr_mm_b1 := pk_addrs_5yr_mm_b1;
				self.pk_addrs_10yr_mm_b1 := pk_addrs_10yr_mm_b1;
				self.pk_addrs_15yr_mm_b1 := pk_addrs_15yr_mm_b1;
				self.pk_add_lres_month_avg2_mm_b1 := pk_add_lres_month_avg2_mm_b1;
				self.pk_nameperssn_count_mm_b1 := pk_nameperssn_count_mm_b1;
				self.pk_ssns_per_adl_mm_b1 := pk_ssns_per_adl_mm_b1;
				self.pk_addrs_per_adl_mm_b1 := pk_addrs_per_adl_mm_b1;
				self.pk_phones_per_adl_mm_b1 := pk_phones_per_adl_mm_b1;
				self.pk_adlperssn_count_mm_b1 := pk_adlperssn_count_mm_b1;
				self.pk_adls_per_addr_mm_b1 := pk_adls_per_addr_mm_b1;
				self.pk_adls_per_phone_mm_b1 := pk_adls_per_phone_mm_b1;
				self.pk_ssns_per_adl_c6_mm_b1 := pk_ssns_per_adl_c6_mm_b1;
				self.pk_ssns_per_addr_c6_mm_b1 := pk_ssns_per_addr_c6_mm_b1;
				self.pk_adls_per_phone_c6_mm_b1 := pk_adls_per_phone_c6_mm_b1;
				self.pk_attr_addrs_last24_mm_b1 := pk_attr_addrs_last24_mm_b1;
				self.pk_ams_class_level_mm_b1 := pk_ams_class_level_mm_b1;
				self.pk_ams_income_level_code_mm_b1 := pk_ams_income_level_code_mm_b1;
				self.pk_college_tier_mm_b1 := pk_college_tier_mm_b1;
				self.pk_yr_in_dob2_mm_b1 := pk_yr_in_dob2_mm_b1;
				self.pk_ams_age_mm_b1 := pk_ams_age_mm_b1;
				self.pk_inferred_age_mm_b1 := pk_inferred_age_mm_b1;
				self.pk_yr_reported_dob2_mm_b1 := pk_yr_reported_dob2_mm_b1;
				self.pk_avm_hit_level_mm_b1 := pk_avm_hit_level_mm_b1;
				self.pk_add2_avm_auto_diff3_lvl_mm_b1 := pk_add2_avm_auto_diff3_lvl_mm_b1;
				self.pk2_add1_avm_sp_mm_b1 := pk2_add1_avm_sp_mm_b1;
				self.pk2_add1_avm_as_mm_b1 := pk2_add1_avm_as_mm_b1;
				self.pk2_add1_avm_auto2_mm_b1 := pk2_add1_avm_auto2_mm_b1;
				self.pk2_add1_avm_auto3_mm_b1 := pk2_add1_avm_auto3_mm_b1;
				self.pk2_add1_avm_med_mm_b1 := pk2_add1_avm_med_mm_b1;
				self.pk2_add1_avm_to_med_ratio_mm_b1 := pk2_add1_avm_to_med_ratio_mm_b1;
				self.pk2_add2_avm_hed_mm_b1 := pk2_add2_avm_hed_mm_b1;
				self.pk2_add2_avm_auto3_mm_b1 := pk2_add2_avm_auto3_mm_b1;
				self.pk_dist_a1toa2_mm_b1 := pk_dist_a1toa2_mm_b1;
				self.pk_dist_a1toa3_mm_b1 := pk_dist_a1toa3_mm_b1;
				self.pk_out_st_division_lvl_mm_b1 := pk_out_st_division_lvl_mm_b1;
				self.pk_impulse_count_mm_b1 := pk_impulse_count_mm_b1;
				self.pk_attr_num_nonderogs90_b_mm_b1 := pk_attr_num_nonderogs90_b_mm_b1;
				self.pk_ssns_per_addr2_mm_b1 := pk_ssns_per_addr2_mm_b1;
				self.pk_yr_add2_assess_val_yr2_mm_b1 := pk_yr_add2_assess_val_yr2_mm_b1;
				self.pk_estimated_income_mm_b2 := pk_estimated_income_mm_b2;
				self.pk_yr_adl_pr_first_seen2_mm_b2 := pk_yr_adl_pr_first_seen2_mm_b2;
				self.pk_yr_adl_w_first_seen2_mm_b2 := pk_yr_adl_w_first_seen2_mm_b2;
				self.pk_yr_adl_w_last_seen2_mm_b2 := pk_yr_adl_w_last_seen2_mm_b2;
				self.pk_pr_count_mm_b2 := pk_pr_count_mm_b2;
				self.pk_addrs_sourced_lvl_mm_b2 := pk_addrs_sourced_lvl_mm_b2;
				self.pk_add1_own_level_mm_b2 := pk_add1_own_level_mm_b2;
				self.pk_naprop_level2_mm_b2 := pk_naprop_level2_mm_b2;
				self.pk_yr_add1_built_date2_mm_b2 := pk_yr_add1_built_date2_mm_b2;
				self.pk_add1_purchase_amount2_mm_b2 := pk_add1_purchase_amount2_mm_b2;
				self.pk_add1_mortgage_amount2_mm_b2 := pk_add1_mortgage_amount2_mm_b2;
				self.pk_yr_add1_mortgage_date2_mm_b2 := pk_yr_add1_mortgage_date2_mm_b2;
				self.pk_add1_assessed_amount2_mm_b2 := pk_add1_assessed_amount2_mm_b2;
				self.pk_yr_add1_date_first_seen2_mm_b2 := pk_yr_add1_date_first_seen2_mm_b2;
				self.pk_add1_building_area2_mm_b2 := pk_add1_building_area2_mm_b2;
				self.pk_add1_no_of_rooms_mm_b2 := pk_add1_no_of_rooms_mm_b2;
				self.pk_add1_garage_type_risk_lvl_mm_b2 := pk_add1_garage_type_risk_lvl_mm_b2;
				self.pk_add1_style_code_level_mm_b2 := pk_add1_style_code_level_mm_b2;
				self.pk_property_owned_total_mm_b2 := pk_property_owned_total_mm_b2;
				self.pk_prop1_prev_purchase_price2_mm_b2 := pk_prop1_prev_purchase_price2_mm_b2;
				self.pk_add2_building_area2_mm_b2 := pk_add2_building_area2_mm_b2;
				self.pk_add2_no_of_buildings_mm_b2 := pk_add2_no_of_buildings_mm_b2;
				self.pk_add2_no_of_rooms_mm_b2 := pk_add2_no_of_rooms_mm_b2;
				self.pk_add2_style_code_level_mm_b2 := pk_add2_style_code_level_mm_b2;
				self.pk_add2_purchase_amount2_mm_b2 := pk_add2_purchase_amount2_mm_b2;
				self.pk_add2_mortgage_risk_mm_b2 := pk_add2_mortgage_risk_mm_b2;
				self.pk_add2_assessed_amount2_mm_b2 := pk_add2_assessed_amount2_mm_b2;
				self.pk_yr_add2_date_first_seen2_mm_b2 := pk_yr_add2_date_first_seen2_mm_b2;
				self.pk_yr_add2_date_last_seen2_mm_b2 := pk_yr_add2_date_last_seen2_mm_b2;
				self.pk_add3_purchase_amount2_mm_b2 := pk_add3_purchase_amount2_mm_b2;
				self.pk_add3_mortgage_risk_mm_b2 := pk_add3_mortgage_risk_mm_b2;
				self.pk_add3_assessed_amount2_mm_b2 := pk_add3_assessed_amount2_mm_b2;
				self.pk_yr_add3_date_first_seen2_mm_b2 := pk_yr_add3_date_first_seen2_mm_b2;
				self.pk_yr_add3_date_last_seen2_mm_b2 := pk_yr_add3_date_last_seen2_mm_b2;
				self.pk_bk_level_mm_b2 := pk_bk_level_mm_b2;
				self.pk_eviction_level_mm_b2 := pk_eviction_level_mm_b2;
				self.pk_lien_type_level_mm_b2 := pk_lien_type_level_mm_b2;
				self.pk_yr_liens_last_unrel_date3_mm_b2 := pk_yr_liens_last_unrel_date3_mm_b2;
				self.pk_yr_ln_unrel_lt_f_sn2_mm_b2 := pk_yr_ln_unrel_lt_f_sn2_mm_b2;
				self.pk_yr_ln_unrel_ot_f_sn2_mm_b2 := pk_yr_ln_unrel_ot_f_sn2_mm_b2;
				self.pk_yr_attr_dt_l_eviction2_mm_b2 := pk_yr_attr_dt_l_eviction2_mm_b2;
				self.pk_crime_level_mm_b2 := pk_crime_level_mm_b2;
				self.pk_attr_total_number_derogs_mm_b2 := pk_attr_total_number_derogs_mm_b2;
				self.pk_yr_rc_ssnhighissue2_mm_b2 := pk_yr_rc_ssnhighissue2_mm_b2;
				self.pk_pl_sourced_level_mm_b2 := pk_pl_sourced_level_mm_b2;
				self.pk_prof_lic_cat_mm_b2 := pk_prof_lic_cat_mm_b2;
				self.pk_add1_lres_mm_b2 := pk_add1_lres_mm_b2;
				self.pk_add3_lres_mm_b2 := pk_add3_lres_mm_b2;
				self.pk_addrs_5yr_mm_b2 := pk_addrs_5yr_mm_b2;
				self.pk_addrs_10yr_mm_b2 := pk_addrs_10yr_mm_b2;
				self.pk_addrs_15yr_mm_b2 := pk_addrs_15yr_mm_b2;
				self.pk_add_lres_month_avg2_mm_b2 := pk_add_lres_month_avg2_mm_b2;
				self.pk_nameperssn_count_mm_b2 := pk_nameperssn_count_mm_b2;
				self.pk_ssns_per_adl_mm_b2 := pk_ssns_per_adl_mm_b2;
				self.pk_addrs_per_adl_mm_b2 := pk_addrs_per_adl_mm_b2;
				self.pk_phones_per_adl_mm_b2 := pk_phones_per_adl_mm_b2;
				self.pk_adlperssn_count_mm_b2 := pk_adlperssn_count_mm_b2;
				self.pk_adls_per_addr_mm_b2 := pk_adls_per_addr_mm_b2;
				self.pk_adls_per_phone_mm_b2 := pk_adls_per_phone_mm_b2;
				self.pk_ssns_per_adl_c6_mm_b2 := pk_ssns_per_adl_c6_mm_b2;
				self.pk_ssns_per_addr_c6_mm_b2 := pk_ssns_per_addr_c6_mm_b2;
				self.pk_adls_per_phone_c6_mm_b2 := pk_adls_per_phone_c6_mm_b2;
				self.pk_attr_addrs_last24_mm_b2 := pk_attr_addrs_last24_mm_b2;
				self.pk_ams_class_level_mm_b2 := pk_ams_class_level_mm_b2;
				self.pk_ams_income_level_code_mm_b2 := pk_ams_income_level_code_mm_b2;
				self.pk_college_tier_mm_b2 := pk_college_tier_mm_b2;
				self.pk_yr_in_dob2_mm_b2 := pk_yr_in_dob2_mm_b2;
				self.pk_ams_age_mm_b2 := pk_ams_age_mm_b2;
				self.pk_inferred_age_mm_b2 := pk_inferred_age_mm_b2;
				self.pk_yr_reported_dob2_mm_b2 := pk_yr_reported_dob2_mm_b2;
				self.pk_avm_hit_level_mm_b2 := pk_avm_hit_level_mm_b2;
				self.pk_add2_avm_auto_diff3_lvl_mm_b2 := pk_add2_avm_auto_diff3_lvl_mm_b2;
				self.pk2_add1_avm_sp_mm_b2 := pk2_add1_avm_sp_mm_b2;
				self.pk2_add1_avm_as_mm_b2 := pk2_add1_avm_as_mm_b2;
				self.pk2_add1_avm_auto2_mm_b2 := pk2_add1_avm_auto2_mm_b2;
				self.pk2_add1_avm_auto3_mm_b2 := pk2_add1_avm_auto3_mm_b2;
				self.pk2_add1_avm_med_mm_b2 := pk2_add1_avm_med_mm_b2;
				self.pk2_add1_avm_to_med_ratio_mm_b2 := pk2_add1_avm_to_med_ratio_mm_b2;
				self.pk2_add2_avm_hed_mm_b2 := pk2_add2_avm_hed_mm_b2;
				self.pk2_add2_avm_auto3_mm_b2 := pk2_add2_avm_auto3_mm_b2;
				self.pk_dist_a1toa2_mm_b2 := pk_dist_a1toa2_mm_b2;
				self.pk_dist_a1toa3_mm_b2 := pk_dist_a1toa3_mm_b2;
				self.pk_out_st_division_lvl_mm_b2 := pk_out_st_division_lvl_mm_b2;
				self.pk_impulse_count_mm_b2 := pk_impulse_count_mm_b2;
				self.pk_attr_num_nonderogs90_b_mm_b2 := pk_attr_num_nonderogs90_b_mm_b2;
				self.pk_ssns_per_addr2_mm_b2 := pk_ssns_per_addr2_mm_b2;
				self.pk_yr_add2_assess_val_yr2_mm_b2 := pk_yr_add2_assess_val_yr2_mm_b2;
				self.pk_estimated_income_mm_b3 := pk_estimated_income_mm_b3;
				self.pk_yr_adl_pr_first_seen2_mm_b3 := pk_yr_adl_pr_first_seen2_mm_b3;
				self.pk_yr_adl_w_first_seen2_mm_b3 := pk_yr_adl_w_first_seen2_mm_b3;
				self.pk_yr_adl_w_last_seen2_mm_b3 := pk_yr_adl_w_last_seen2_mm_b3;
				self.pk_pr_count_mm_b3 := pk_pr_count_mm_b3;
				self.pk_addrs_sourced_lvl_mm_b3 := pk_addrs_sourced_lvl_mm_b3;
				self.pk_add1_own_level_mm_b3 := pk_add1_own_level_mm_b3;
				self.pk_naprop_level2_mm_b3 := pk_naprop_level2_mm_b3;
				self.pk_yr_add1_built_date2_mm_b3 := pk_yr_add1_built_date2_mm_b3;
				self.pk_add1_purchase_amount2_mm_b3 := pk_add1_purchase_amount2_mm_b3;
				self.pk_add1_mortgage_amount2_mm_b3 := pk_add1_mortgage_amount2_mm_b3;
				self.pk_yr_add1_mortgage_date2_mm_b3 := pk_yr_add1_mortgage_date2_mm_b3;
				self.pk_add1_assessed_amount2_mm_b3 := pk_add1_assessed_amount2_mm_b3;
				self.pk_yr_add1_date_first_seen2_mm_b3 := pk_yr_add1_date_first_seen2_mm_b3;
				self.pk_add1_building_area2_mm_b3 := pk_add1_building_area2_mm_b3;
				self.pk_add1_no_of_rooms_mm_b3 := pk_add1_no_of_rooms_mm_b3;
				self.pk_add1_garage_type_risk_lvl_mm_b3 := pk_add1_garage_type_risk_lvl_mm_b3;
				self.pk_add1_style_code_level_mm_b3 := pk_add1_style_code_level_mm_b3;
				self.pk_property_owned_total_mm_b3 := pk_property_owned_total_mm_b3;
				self.pk_prop1_prev_purchase_price2_mm_b3 := pk_prop1_prev_purchase_price2_mm_b3;
				self.pk_add2_building_area2_mm_b3 := pk_add2_building_area2_mm_b3;
				self.pk_add2_no_of_buildings_mm_b3 := pk_add2_no_of_buildings_mm_b3;
				self.pk_add2_no_of_rooms_mm_b3 := pk_add2_no_of_rooms_mm_b3;
				self.pk_add2_style_code_level_mm_b3 := pk_add2_style_code_level_mm_b3;
				self.pk_add2_purchase_amount2_mm_b3 := pk_add2_purchase_amount2_mm_b3;
				self.pk_add2_mortgage_risk_mm_b3 := pk_add2_mortgage_risk_mm_b3;
				self.pk_add2_assessed_amount2_mm_b3 := pk_add2_assessed_amount2_mm_b3;
				self.pk_yr_add2_date_first_seen2_mm_b3 := pk_yr_add2_date_first_seen2_mm_b3;
				self.pk_yr_add2_date_last_seen2_mm_b3 := pk_yr_add2_date_last_seen2_mm_b3;
				self.pk_add3_purchase_amount2_mm_b3 := pk_add3_purchase_amount2_mm_b3;
				self.pk_add3_mortgage_risk_mm_b3 := pk_add3_mortgage_risk_mm_b3;
				self.pk_add3_assessed_amount2_mm_b3 := pk_add3_assessed_amount2_mm_b3;
				self.pk_yr_add3_date_first_seen2_mm_b3 := pk_yr_add3_date_first_seen2_mm_b3;
				self.pk_yr_add3_date_last_seen2_mm_b3 := pk_yr_add3_date_last_seen2_mm_b3;
				self.pk_bk_level_mm_b3 := pk_bk_level_mm_b3;
				self.pk_eviction_level_mm_b3 := pk_eviction_level_mm_b3;
				self.pk_lien_type_level_mm_b3 := pk_lien_type_level_mm_b3;
				self.pk_yr_liens_last_unrel_date3_mm_b3 := pk_yr_liens_last_unrel_date3_mm_b3;
				self.pk_yr_ln_unrel_lt_f_sn2_mm_b3 := pk_yr_ln_unrel_lt_f_sn2_mm_b3;
				self.pk_yr_ln_unrel_ot_f_sn2_mm_b3 := pk_yr_ln_unrel_ot_f_sn2_mm_b3;
				self.pk_yr_attr_dt_l_eviction2_mm_b3 := pk_yr_attr_dt_l_eviction2_mm_b3;
				self.pk_crime_level_mm_b3 := pk_crime_level_mm_b3;
				self.pk_attr_total_number_derogs_mm_b3 := pk_attr_total_number_derogs_mm_b3;
				self.pk_yr_rc_ssnhighissue2_mm_b3 := pk_yr_rc_ssnhighissue2_mm_b3;
				self.pk_pl_sourced_level_mm_b3 := pk_pl_sourced_level_mm_b3;
				self.pk_prof_lic_cat_mm_b3 := pk_prof_lic_cat_mm_b3;
				self.pk_add1_lres_mm_b3 := pk_add1_lres_mm_b3;
				self.pk_add3_lres_mm_b3 := pk_add3_lres_mm_b3;
				self.pk_addrs_5yr_mm_b3 := pk_addrs_5yr_mm_b3;
				self.pk_addrs_10yr_mm_b3 := pk_addrs_10yr_mm_b3;
				self.pk_addrs_15yr_mm_b3 := pk_addrs_15yr_mm_b3;
				self.pk_add_lres_month_avg2_mm_b3 := pk_add_lres_month_avg2_mm_b3;
				self.pk_nameperssn_count_mm_b3 := pk_nameperssn_count_mm_b3;
				self.pk_ssns_per_adl_mm_b3 := pk_ssns_per_adl_mm_b3;
				self.pk_addrs_per_adl_mm_b3 := pk_addrs_per_adl_mm_b3;
				self.pk_phones_per_adl_mm_b3 := pk_phones_per_adl_mm_b3;
				self.pk_adlperssn_count_mm_b3 := pk_adlperssn_count_mm_b3;
				self.pk_adls_per_addr_mm_b3 := pk_adls_per_addr_mm_b3;
				self.pk_adls_per_phone_mm_b3 := pk_adls_per_phone_mm_b3;
				self.pk_ssns_per_adl_c6_mm_b3 := pk_ssns_per_adl_c6_mm_b3;
				self.pk_ssns_per_addr_c6_mm_b3 := pk_ssns_per_addr_c6_mm_b3;
				self.pk_adls_per_phone_c6_mm_b3 := pk_adls_per_phone_c6_mm_b3;
				self.pk_attr_addrs_last24_mm_b3 := pk_attr_addrs_last24_mm_b3;
				self.pk_ams_class_level_mm_b3 := pk_ams_class_level_mm_b3;
				self.pk_ams_income_level_code_mm_b3 := pk_ams_income_level_code_mm_b3;
				self.pk_college_tier_mm_b3 := pk_college_tier_mm_b3;
				self.pk_yr_in_dob2_mm_b3 := pk_yr_in_dob2_mm_b3;
				self.pk_ams_age_mm_b3 := pk_ams_age_mm_b3;
				self.pk_inferred_age_mm_b3 := pk_inferred_age_mm_b3;
				self.pk_yr_reported_dob2_mm_b3 := pk_yr_reported_dob2_mm_b3;
				self.pk_avm_hit_level_mm_b3 := pk_avm_hit_level_mm_b3;
				self.pk_add2_avm_auto_diff3_lvl_mm_b3 := pk_add2_avm_auto_diff3_lvl_mm_b3;
				self.pk2_add1_avm_sp_mm_b3 := pk2_add1_avm_sp_mm_b3;
				self.pk2_add1_avm_as_mm_b3 := pk2_add1_avm_as_mm_b3;
				self.pk2_add1_avm_auto2_mm_b3 := pk2_add1_avm_auto2_mm_b3;
				self.pk2_add1_avm_auto3_mm_b3 := pk2_add1_avm_auto3_mm_b3;
				self.pk2_add1_avm_med_mm_b3 := pk2_add1_avm_med_mm_b3;
				self.pk2_add1_avm_to_med_ratio_mm_b3 := pk2_add1_avm_to_med_ratio_mm_b3;
				self.pk2_add2_avm_hed_mm_b3 := pk2_add2_avm_hed_mm_b3;
				self.pk2_add2_avm_auto3_mm_b3 := pk2_add2_avm_auto3_mm_b3;
				self.pk_dist_a1toa2_mm_b3 := pk_dist_a1toa2_mm_b3;
				self.pk_dist_a1toa3_mm_b3 := pk_dist_a1toa3_mm_b3;
				self.pk_out_st_division_lvl_mm_b3 := pk_out_st_division_lvl_mm_b3;
				self.pk_impulse_count_mm_b3 := pk_impulse_count_mm_b3;
				self.pk_attr_num_nonderogs90_b_mm_b3 := pk_attr_num_nonderogs90_b_mm_b3;
				self.pk_ssns_per_addr2_mm_b3 := pk_ssns_per_addr2_mm_b3;
				self.pk_yr_add2_assess_val_yr2_mm_b3 := pk_yr_add2_assess_val_yr2_mm_b3;
				self.pk_yr_add1_date_first_seen2_mm := pk_yr_add1_date_first_seen2_mm;
				self.pk_add2_style_code_level_mm := pk_add2_style_code_level_mm;
				self.pk_add1_mortgage_amount2_mm := pk_add1_mortgage_amount2_mm;
				self.pk_nameperssn_count_mm := pk_nameperssn_count_mm;
				self.pk_add1_purchase_amount2_mm := pk_add1_purchase_amount2_mm;
				self.pk_adls_per_phone_mm := pk_adls_per_phone_mm;
				self.pk_ssns_per_addr2_mm := pk_ssns_per_addr2_mm;
				self.pk_property_owned_total_mm := pk_property_owned_total_mm;
				self.pk_ams_class_level_mm := pk_ams_class_level_mm;
				self.pk_adls_per_phone_c6_mm := pk_adls_per_phone_c6_mm;
				self.pk_yr_attr_dt_l_eviction2_mm := pk_yr_attr_dt_l_eviction2_mm;
				self.pk_yr_add2_date_first_seen2_mm := pk_yr_add2_date_first_seen2_mm;
				self.pk_adlperssn_count_mm := pk_adlperssn_count_mm;
				self.pk2_add2_avm_hed_mm := pk2_add2_avm_hed_mm;
				self.pk_yr_add3_date_first_seen2_mm := pk_yr_add3_date_first_seen2_mm;
				self.pk_add2_avm_auto_diff3_lvl_mm := pk_add2_avm_auto_diff3_lvl_mm;
				self.pk_addrs_sourced_lvl_mm := pk_addrs_sourced_lvl_mm;
				self.pk_add_lres_month_avg2_mm := pk_add_lres_month_avg2_mm;
				self.pk_add1_lres_mm := pk_add1_lres_mm;
				self.pk_attr_total_number_derogs_mm := pk_attr_total_number_derogs_mm;
				self.pk_addrs_per_adl_mm := pk_addrs_per_adl_mm;
				self.pk_naprop_level2_mm := pk_naprop_level2_mm;
				self.pk2_add1_avm_auto3_mm := pk2_add1_avm_auto3_mm;
				self.pk_yr_reported_dob2_mm := pk_yr_reported_dob2_mm;
				self.pk_college_tier_mm := pk_college_tier_mm;
				self.pk_ssns_per_adl_mm := pk_ssns_per_adl_mm;
				self.pk_yr_adl_w_last_seen2_mm := pk_yr_adl_w_last_seen2_mm;
				self.pk_ams_income_level_code_mm := pk_ams_income_level_code_mm;
				self.pk_yr_ln_unrel_ot_f_sn2_mm := pk_yr_ln_unrel_ot_f_sn2_mm;
				self.pk_add1_building_area2_mm := pk_add1_building_area2_mm;
				self.pk_yr_add3_date_last_seen2_mm := pk_yr_add3_date_last_seen2_mm;
				self.pk_pr_count_mm := pk_pr_count_mm;
				self.pk2_add1_avm_as_mm := pk2_add1_avm_as_mm;
				self.pk_inferred_age_mm := pk_inferred_age_mm;
				self.pk_out_st_division_lvl_mm := pk_out_st_division_lvl_mm;
				self.pk_yr_rc_ssnhighissue2_mm := pk_yr_rc_ssnhighissue2_mm;
				self.pk_prop1_prev_purchase_price2_mm := pk_prop1_prev_purchase_price2_mm;
				self.pk_add2_purchase_amount2_mm := pk_add2_purchase_amount2_mm;
				self.pk_add2_building_area2_mm := pk_add2_building_area2_mm;
				self.pk_phones_per_adl_mm := pk_phones_per_adl_mm;
				self.pk_add1_no_of_rooms_mm := pk_add1_no_of_rooms_mm;
				self.pk2_add1_avm_auto2_mm := pk2_add1_avm_auto2_mm;
				self.pk_addrs_10yr_mm := pk_addrs_10yr_mm;
				self.pk_ssns_per_addr_c6_mm := pk_ssns_per_addr_c6_mm;
				self.pk_add3_purchase_amount2_mm := pk_add3_purchase_amount2_mm;
				self.pk_yr_ln_unrel_lt_f_sn2_mm := pk_yr_ln_unrel_lt_f_sn2_mm;
				self.pk_yr_add2_assess_val_yr2_mm := pk_yr_add2_assess_val_yr2_mm;
				self.pk_pl_sourced_level_mm := pk_pl_sourced_level_mm;
				self.pk_add2_assessed_amount2_mm := pk_add2_assessed_amount2_mm;
				self.pk_prof_lic_cat_mm := pk_prof_lic_cat_mm;
				self.pk_dist_a1toa3_mm := pk_dist_a1toa3_mm;
				self.pk_eviction_level_mm := pk_eviction_level_mm;
				self.pk_attr_num_nonderogs90_b_mm := pk_attr_num_nonderogs90_b_mm;
				self.pk_adls_per_addr_mm := pk_adls_per_addr_mm;
				self.pk_ssns_per_adl_c6_mm := pk_ssns_per_adl_c6_mm;
				self.pk_attr_addrs_last24_mm := pk_attr_addrs_last24_mm;
				self.pk_yr_add2_date_last_seen2_mm := pk_yr_add2_date_last_seen2_mm;
				self.pk_add3_mortgage_risk_mm := pk_add3_mortgage_risk_mm;
				self.pk2_add1_avm_sp_mm := pk2_add1_avm_sp_mm;
				self.pk2_add1_avm_med_mm := pk2_add1_avm_med_mm;
				self.pk_add2_no_of_rooms_mm := pk_add2_no_of_rooms_mm;
				self.pk_impulse_count_mm := pk_impulse_count_mm;
				self.pk_add2_no_of_buildings_mm := pk_add2_no_of_buildings_mm;
				self.pk_yr_add1_mortgage_date2_mm := pk_yr_add1_mortgage_date2_mm;
				self.pk_crime_level_mm := pk_crime_level_mm;
				self.pk_yr_in_dob2_mm := pk_yr_in_dob2_mm;
				self.pk_addrs_15yr_mm := pk_addrs_15yr_mm;
				self.pk_add1_garage_type_risk_lvl_mm := pk_add1_garage_type_risk_lvl_mm;
				self.pk_avm_hit_level_mm := pk_avm_hit_level_mm;
				self.pk_bk_level_mm := pk_bk_level_mm;
				self.pk2_add1_avm_to_med_ratio_mm := pk2_add1_avm_to_med_ratio_mm;
				self.pk_yr_adl_pr_first_seen2_mm := pk_yr_adl_pr_first_seen2_mm;
				self.pk_add1_assessed_amount2_mm := pk_add1_assessed_amount2_mm;
				self.pk_add1_style_code_level_mm := pk_add1_style_code_level_mm;
				self.pk_add3_lres_mm := pk_add3_lres_mm;
				self.pk_ams_age_mm := pk_ams_age_mm;
				self.pk_estimated_income_mm := pk_estimated_income_mm;
				self.pk_yr_adl_w_first_seen2_mm := pk_yr_adl_w_first_seen2_mm;
				self.pk_add2_mortgage_risk_mm := pk_add2_mortgage_risk_mm;
				self.pk_dist_a1toa2_mm := pk_dist_a1toa2_mm;
				self.pk_add1_own_level_mm := pk_add1_own_level_mm;
				self.pk_add3_assessed_amount2_mm := pk_add3_assessed_amount2_mm;
				self.pk_yr_add1_built_date2_mm := pk_yr_add1_built_date2_mm;
				self.pk_addrs_5yr_mm := pk_addrs_5yr_mm;
				self.pk_lien_type_level_mm := pk_lien_type_level_mm;
				self.pk2_add2_avm_auto3_mm := pk2_add2_avm_auto3_mm;
				self.pk_yr_liens_last_unrel_date3_mm := pk_yr_liens_last_unrel_date3_mm;
				self.segment_mean := segment_mean;
				self.pk_add_lres_month_avg2_mm_2 := pk_add_lres_month_avg2_mm_2;
				self.pk_add1_address_score_mm_2 := pk_add1_address_score_mm_2;
				self.pk_add1_assessed_amount2_mm_2 := pk_add1_assessed_amount2_mm_2;
				self.pk_add1_building_area2_mm_2 := pk_add1_building_area2_mm_2;
				self.pk_add1_garage_type_risk_lvl_mm_2 := pk_add1_garage_type_risk_lvl_mm_2;
				self.pk_add1_lres_mm_2 := pk_add1_lres_mm_2;
				self.pk_add1_mortgage_amount2_mm_2 := pk_add1_mortgage_amount2_mm_2;
				self.pk_add1_no_of_rooms_mm_2 := pk_add1_no_of_rooms_mm_2;
				self.pk_add1_own_level_mm_2 := pk_add1_own_level_mm_2;
				self.pk_add1_purchase_amount2_mm_2 := pk_add1_purchase_amount2_mm_2;
				self.pk_add1_style_code_level_mm_2 := pk_add1_style_code_level_mm_2;
				self.pk_add2_address_score_mm_2 := pk_add2_address_score_mm_2;
				self.pk_add2_assessed_amount2_mm_2 := pk_add2_assessed_amount2_mm_2;
				self.pk_add2_avm_auto_diff3_lvl_mm_2 := pk_add2_avm_auto_diff3_lvl_mm_2;
				self.pk_add2_building_area2_mm_2 := pk_add2_building_area2_mm_2;
				self.pk_add2_em_ver_lvl_mm_2 := pk_add2_em_ver_lvl_mm_2;
				self.pk_add2_mortgage_risk_mm_2 := pk_add2_mortgage_risk_mm_2;
				self.pk_add2_no_of_buildings_mm_2 := pk_add2_no_of_buildings_mm_2;
				self.pk_add2_no_of_rooms_mm_2 := pk_add2_no_of_rooms_mm_2;
				self.pk_add2_pos_sources_mm_2 := pk_add2_pos_sources_mm_2;
				self.pk_add2_purchase_amount2_mm_2 := pk_add2_purchase_amount2_mm_2;
				self.pk_add2_style_code_level_mm_2 := pk_add2_style_code_level_mm_2;
				self.pk_add3_assessed_amount2_mm_2 := pk_add3_assessed_amount2_mm_2;
				self.pk_add3_lres_mm_2 := pk_add3_lres_mm_2;
				self.pk_add3_mortgage_risk_mm_2 := pk_add3_mortgage_risk_mm_2;
				self.pk_add3_purchase_amount2_mm_2 := pk_add3_purchase_amount2_mm_2;
				self.pk_addrs_10yr_mm_2 := pk_addrs_10yr_mm_2;
				self.pk_addrs_15yr_mm_2 := pk_addrs_15yr_mm_2;
				self.pk_addrs_5yr_mm_2 := pk_addrs_5yr_mm_2;
				self.pk_addrs_per_adl_mm_2 := pk_addrs_per_adl_mm_2;
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
				self.pk_attr_num_nonderogs90_b_mm_2 := pk_attr_num_nonderogs90_b_mm_2;
				self.pk_attr_total_number_derogs_mm_2 := pk_attr_total_number_derogs_mm_2;
				self.pk_avm_hit_level_mm_2 := pk_avm_hit_level_mm_2;
				self.pk_bk_level_mm_2 := pk_bk_level_mm_2;
				self.pk_college_tier_mm_2 := pk_college_tier_mm_2;
				self.pk_combo_addrcount_nb_mm_2 := pk_combo_addrcount_nb_mm_2;
				self.pk_combo_dobcount_mm_2 := pk_combo_dobcount_mm_2;
				self.pk_combo_dobcount_nb_mm_2 := pk_combo_dobcount_nb_mm_2;
				self.pk_combo_dobscore_mm_2 := pk_combo_dobscore_mm_2;
				self.pk_combo_fnamecount_mm_2 := pk_combo_fnamecount_mm_2;
				self.pk_combo_fnamecount_nb_mm_2 := pk_combo_fnamecount_nb_mm_2;
				self.pk_combo_hphonescore_mm_2 := pk_combo_hphonescore_mm_2;
				self.pk_combo_ssncount_mm_2 := pk_combo_ssncount_mm_2;
				self.pk_combo_ssnscore_mm_2 := pk_combo_ssnscore_mm_2;
				self.pk_crime_level_mm_2 := pk_crime_level_mm_2;
				self.pk_dist_a1toa2_mm_2 := pk_dist_a1toa2_mm_2;
				self.pk_dist_a1toa3_mm_2 := pk_dist_a1toa3_mm_2;
				self.pk_eq_count_mm_2 := pk_eq_count_mm_2;
				self.pk_estimated_income_mm_2 := pk_estimated_income_mm_2;
				self.pk_eviction_level_mm_2 := pk_eviction_level_mm_2;
				self.pk_fname_eda_sourced_type_lvl_mm_2 := pk_fname_eda_sourced_type_lvl_mm_2;
				self.pk_gong_did_phone_ct_mm_2 := pk_gong_did_phone_ct_mm_2;
				self.pk_gong_did_phone_ct_nb_mm_2 := pk_gong_did_phone_ct_nb_mm_2;
				self.pk_impulse_count_mm_2 := pk_impulse_count_mm_2;
				self.pk_inferred_age_mm_2 := pk_inferred_age_mm_2;
				self.pk_infutor_risk_lvl_mm_2 := pk_infutor_risk_lvl_mm_2;
				self.pk_infutor_risk_lvl_nb_mm_2 := pk_infutor_risk_lvl_nb_mm_2;
				self.pk_lien_type_level_mm_2 := pk_lien_type_level_mm_2;
				self.pk_lname_eda_sourced_type_lvl_mm_2 := pk_lname_eda_sourced_type_lvl_mm_2;
				self.pk_nameperssn_count_mm_2 := pk_nameperssn_count_mm_2;
				self.pk_nap_summary_mm_2 := pk_nap_summary_mm_2;
				self.pk_naprop_level2_mm_2 := pk_naprop_level2_mm_2;
				self.pk_nas_summary_mm_2 := pk_nas_summary_mm_2;
				self.pk_out_st_division_lvl_mm_2 := pk_out_st_division_lvl_mm_2;
				self.pk_phones_per_adl_mm_2 := pk_phones_per_adl_mm_2;
				self.pk_pl_sourced_level_mm_2 := pk_pl_sourced_level_mm_2;
				self.pk_pos_secondary_sources_mm_2 := pk_pos_secondary_sources_mm_2;
				self.pk_pr_count_mm_2 := pk_pr_count_mm_2;
				self.pk_prof_lic_cat_mm_2 := pk_prof_lic_cat_mm_2;
				self.pk_prop1_prev_purchase_price2_mm_2 := pk_prop1_prev_purchase_price2_mm_2;
				self.pk_property_owned_total_mm_2 := pk_property_owned_total_mm_2;
				self.pk_rc_addrcount_mm_2 := pk_rc_addrcount_mm_2;
				self.pk_rc_addrcount_nb_mm_2 := pk_rc_addrcount_nb_mm_2;
				self.pk_rc_dirsaddr_lastscore_mm_2 := pk_rc_dirsaddr_lastscore_mm_2;
				self.pk_rc_phonelnamecount_mm_2 := pk_rc_phonelnamecount_mm_2;
				self.pk_rc_phonephonecount_mm_2 := pk_rc_phonephonecount_mm_2;
				self.pk_ssnchar_invalid_or_recent_mm_2 := pk_ssnchar_invalid_or_recent_mm_2;
				self.pk_ssns_per_addr_c6_mm_2 := pk_ssns_per_addr_c6_mm_2;
				self.pk_ssns_per_addr2_mm_2 := pk_ssns_per_addr2_mm_2;
				self.pk_ssns_per_adl_c6_mm_2 := pk_ssns_per_adl_c6_mm_2;
				self.pk_ssns_per_adl_mm_2 := pk_ssns_per_adl_mm_2;
				self.pk_ver_phncount_mm_2 := pk_ver_phncount_mm_2;
				self.pk_voter_flag_mm_2 := pk_voter_flag_mm_2;
				self.pk_yr_add1_built_date2_mm_2 := pk_yr_add1_built_date2_mm_2;
				self.pk_yr_add1_date_first_seen2_mm_2 := pk_yr_add1_date_first_seen2_mm_2;
				self.pk_yr_add1_mortgage_date2_mm_2 := pk_yr_add1_mortgage_date2_mm_2;
				self.pk_yr_add2_assess_val_yr2_mm_2 := pk_yr_add2_assess_val_yr2_mm_2;
				self.pk_yr_add2_date_first_seen2_mm_2 := pk_yr_add2_date_first_seen2_mm_2;
				self.pk_yr_add2_date_last_seen2_mm_2 := pk_yr_add2_date_last_seen2_mm_2;
				self.pk_yr_add3_date_first_seen2_mm_2 := pk_yr_add3_date_first_seen2_mm_2;
				self.pk_yr_add3_date_last_seen2_mm_2 := pk_yr_add3_date_last_seen2_mm_2;
				self.pk_yr_adl_em_first_seen2_mm_2 := pk_yr_adl_em_first_seen2_mm_2;
				self.pk_yr_adl_em_only_first_seen2_mm_2 := pk_yr_adl_em_only_first_seen2_mm_2;
				self.pk_yr_adl_pr_first_seen2_mm_2 := pk_yr_adl_pr_first_seen2_mm_2;
				self.pk_yr_adl_vo_first_seen2_mm_2 := pk_yr_adl_vo_first_seen2_mm_2;
				self.pk_yr_adl_w_first_seen2_mm_2 := pk_yr_adl_w_first_seen2_mm_2;
				self.pk_yr_adl_w_last_seen2_mm_2 := pk_yr_adl_w_last_seen2_mm_2;
				self.pk_yr_attr_dt_l_eviction2_mm_2 := pk_yr_attr_dt_l_eviction2_mm_2;
				self.pk_yr_credit_first_seen2_mm_2 := pk_yr_credit_first_seen2_mm_2;
				self.pk_yr_gong_did_first_seen2_mm_2 := pk_yr_gong_did_first_seen2_mm_2;
				self.pk_yr_header_first_seen2_mm_2 := pk_yr_header_first_seen2_mm_2;
				self.pk_yr_in_dob2_mm_2 := pk_yr_in_dob2_mm_2;
				self.pk_yr_infutor_first_seen2_mm_2 := pk_yr_infutor_first_seen2_mm_2;
				self.pk_yr_liens_last_unrel_date3_mm_2 := pk_yr_liens_last_unrel_date3_mm_2;
				self.pk_yr_ln_unrel_lt_f_sn2_mm_2 := pk_yr_ln_unrel_lt_f_sn2_mm_2;
				self.pk_yr_ln_unrel_ot_f_sn2_mm_2 := pk_yr_ln_unrel_ot_f_sn2_mm_2;
				self.pk_yr_lname_change_date2_mm_2 := pk_yr_lname_change_date2_mm_2;
				self.pk_yr_rc_ssnhighissue2_mm_2 := pk_yr_rc_ssnhighissue2_mm_2;
				self.pk_yr_reported_dob2_mm_2 := pk_yr_reported_dob2_mm_2;
				self.pk_yrmo_adl_f_sn_mx_fcra2_mm_2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
				self.pk2_add1_avm_as_mm_2 := pk2_add1_avm_as_mm_2;
				self.pk2_add1_avm_auto2_mm_2 := pk2_add1_avm_auto2_mm_2;
				self.pk2_add1_avm_auto3_mm_2 := pk2_add1_avm_auto3_mm_2;
				self.pk2_add1_avm_med_mm_2 := pk2_add1_avm_med_mm_2;
				self.pk2_add1_avm_sp_mm_2 := pk2_add1_avm_sp_mm_2;
				self.pk2_add1_avm_to_med_ratio_mm_2 := pk2_add1_avm_to_med_ratio_mm_2;
				self.pk2_add2_avm_auto3_mm_2 := pk2_add2_avm_auto3_mm_2;
				self.pk2_add2_avm_hed_mm_2 := pk2_add2_avm_hed_mm_2;
				self.amstudent_mod_om_b1 := amstudent_mod_om_b1;
				self.avm_mod_om_b1 := avm_mod_om_b1;
				self.derog_mod3_om_b1 := derog_mod3_om_b1;
				self.lien_mod_om_b1 := lien_mod_om_b1;
				self.property_mod_om_b1 := property_mod_om_b1;
				self.velocity2_mod_om_b1 := velocity2_mod_om_b1;
				self.ver_best_element_cnt_mod_om_b1 := ver_best_element_cnt_mod_om_b1;
				self.ver_best_src_cnt_mod_om_b1 := ver_best_src_cnt_mod_om_b1;
				self.ver_best_src_time_mod_om_b1 := ver_best_src_time_mod_om_b1;
				self.ver_notbest_element_cnt_mod_om_b1 := ver_notbest_element_cnt_mod_om_b1;
				self.ver_notbest_src_cnt_mod_om_b1 := ver_notbest_src_cnt_mod_om_b1;
				self.ver_notbest_src_time_mod_om_b1 := ver_notbest_src_time_mod_om_b1;
				self.ver_src_time_mod_om_b1 := ver_src_time_mod_om_b1;
				self.ver_element_cnt_mod_om_b1 := ver_element_cnt_mod_om_b1;
				self.ver_src_cnt_mod_om_b1 := ver_src_cnt_mod_om_b1;
				self.mod14_om_b1 := mod14_om_b1;
				self.addprob3_mod_xm_b2 := addprob3_mod_xm_b2;
				self.phnprob_mod_xm_b2 := phnprob_mod_xm_b2;
				self.ssnprob2_mod_xm_b2 := ssnprob2_mod_xm_b2;
				self.fp_mod5_xm_b2 := fp_mod5_xm_b2;
				self.age_mod3_nodob_xm_b2 := age_mod3_nodob_xm_b2;
				self.age_mod3_xm_b2 := age_mod3_xm_b2;
				self.amstudent_mod_xm_b2 := amstudent_mod_xm_b2;
				self.avm_mod_xm_b2 := avm_mod_xm_b2;
				self.derog_mod3_xm_b2 := derog_mod3_xm_b2;
				self.lien_mod_xm_b2 := lien_mod_xm_b2;
				self.lres_mod_xm_b2 := lres_mod_xm_b2;
				self.property_mod_xm_b2 := property_mod_xm_b2;
				self.velocity2_mod_xm_b2 := velocity2_mod_xm_b2;
				self.ver_best_element_cnt_mod_xm_b2 := ver_best_element_cnt_mod_xm_b2;
				self.ver_best_src_cnt_mod_xm_b2 := ver_best_src_cnt_mod_xm_b2;
				self.ver_best_src_time_mod_xm_b2 := ver_best_src_time_mod_xm_b2;
				self.ver_notbest_element_cnt_mod_xm_b2 := ver_notbest_element_cnt_mod_xm_b2;
				self.ver_notbest_src_cnt_mod_xm_b2 := ver_notbest_src_cnt_mod_xm_b2;
				self.ver_notbest_src_time_mod_xm_b2 := ver_notbest_src_time_mod_xm_b2;
				self.ver_element_cnt_mod_xm_b2 := ver_element_cnt_mod_xm_b2;
				self.ver_src_time_mod_xm_b2 := ver_src_time_mod_xm_b2;
				self.ver_src_cnt_mod_xm_b2 := ver_src_cnt_mod_xm_b2;
				self.mod14_xm_b2 := mod14_xm_b2;
				self.age_mod3_nm_b3 := age_mod3_nm_b3;
				self.amstudent_mod_nm_b3 := amstudent_mod_nm_b3;
				self.avm_mod_nm_b3 := avm_mod_nm_b3;
				self.distance_mod2_nm_b3 := distance_mod2_nm_b3;
				self.lres_mod_nm_b3 := lres_mod_nm_b3;
				self.proflic_mod_nm_b3 := proflic_mod_nm_b3;
				self.property_mod_nm_b3 := property_mod_nm_b3;
				self.velocity2_mod_nm_b3 := velocity2_mod_nm_b3;
				self.ver_best_score_mod_nm_b3 := ver_best_score_mod_nm_b3;
				self.ver_best_src_cnt_mod_nm_b3 := ver_best_src_cnt_mod_nm_b3;
				self.ver_best_src_time_mod_nm_b3 := ver_best_src_time_mod_nm_b3;
				self.ver_notbest_score_mod_nm_b3 := ver_notbest_score_mod_nm_b3;
				self.ver_notbest_src_cnt_mod_nm_b3 := ver_notbest_src_cnt_mod_nm_b3;
				self.ver_notbest_src_time_mod_nm_b3 := ver_notbest_src_time_mod_nm_b3;
				self.ver_src_cnt_mod_nm_b3 := ver_src_cnt_mod_nm_b3;
				self.ver_score_mod_nm_b3 := ver_score_mod_nm_b3;
				self.ver_src_time_mod_nm_b3 := ver_src_time_mod_nm_b3;
				self.mod14_nm_b3 := mod14_nm_b3;
				self.ver_best_element_cnt_mod_om := ver_best_element_cnt_mod_om;
				self.ver_src_cnt_mod_nm := ver_src_cnt_mod_nm;
				self.amstudent_mod_om := amstudent_mod_om;
				self.ver_notbest_score_mod_nm := ver_notbest_score_mod_nm;
				self.ver_src_time_mod_nm := ver_src_time_mod_nm;
				self.phat := phat;
				self.age_mod3_nodob_xm := age_mod3_nodob_xm;
				self.ver_src_time_mod_om := ver_src_time_mod_om;
				self.avm_mod_om := avm_mod_om;
				self.ver_notbest_src_cnt_mod_nm := ver_notbest_src_cnt_mod_nm;
				self.property_mod_xm := property_mod_xm;
				self.mod14_om := mod14_om;
				self.mod14_xm := mod14_xm;
				self.ver_notbest_src_cnt_mod_om := ver_notbest_src_cnt_mod_om;
				self.velocity2_mod_nm := velocity2_mod_nm;
				self.distance_mod2_nm := distance_mod2_nm;
				self.lien_mod_om := lien_mod_om;
				self.ver_src_cnt_mod_xm := ver_src_cnt_mod_xm;
				self.mod14_nm := mod14_nm;
				self.ver_notbest_src_time_mod_xm := ver_notbest_src_time_mod_xm;
				self.velocity2_mod_om := velocity2_mod_om;
				self.property_mod_nm := property_mod_nm;
				self.ver_notbest_element_cnt_mod_xm := ver_notbest_element_cnt_mod_xm;
				self.ver_notbest_src_cnt_mod_xm := ver_notbest_src_cnt_mod_xm;
				self.ver_notbest_src_time_mod_om := ver_notbest_src_time_mod_om;
				self.avm_mod_nm := avm_mod_nm;
				self.ver_best_src_time_mod_om := ver_best_src_time_mod_om;
				self.ver_best_src_time_mod_xm := ver_best_src_time_mod_xm;
				self.ver_src_cnt_mod_om := ver_src_cnt_mod_om;
				self.ver_best_src_cnt_mod_xm := ver_best_src_cnt_mod_xm;
				self.amstudent_mod_xm := amstudent_mod_xm;
				self.age_mod3_xm := age_mod3_xm;
				self.avm_mod_xm := avm_mod_xm;
				self.ver_best_src_cnt_mod_nm := ver_best_src_cnt_mod_nm;
				self.velocity2_mod_xm := velocity2_mod_xm;
				self.ver_notbest_element_cnt_mod_om := ver_notbest_element_cnt_mod_om;
				self.lres_mod_nm := lres_mod_nm;
				self.ver_notbest_src_time_mod_nm := ver_notbest_src_time_mod_nm;
				self.fp_mod5_xm := fp_mod5_xm;
				self.phnprob_mod_xm := phnprob_mod_xm;
				self.ver_element_cnt_mod_xm := ver_element_cnt_mod_xm;
				self.derog_mod3_om := derog_mod3_om;
				self.mod14_scr := mod14_scr;
				self.ssnprob2_mod_xm := ssnprob2_mod_xm;
				self.age_mod3_nm := age_mod3_nm;
				self.ver_best_src_cnt_mod_om := ver_best_src_cnt_mod_om;
				self.ver_best_src_time_mod_nm := ver_best_src_time_mod_nm;
				self.addprob3_mod_xm := addprob3_mod_xm;
				self.derog_mod3_xm := derog_mod3_xm;
				self.ver_element_cnt_mod_om := ver_element_cnt_mod_om;
				self.ver_best_score_mod_nm := ver_best_score_mod_nm;
				self.lien_mod_xm := lien_mod_xm;
				self.amstudent_mod_nm := amstudent_mod_nm;
				self.ver_score_mod_nm := ver_score_mod_nm;
				self.proflic_mod_nm := proflic_mod_nm;
				self.ver_src_time_mod_xm := ver_src_time_mod_xm;
				self.property_mod_om := property_mod_om;
				self.lres_mod_xm := lres_mod_xm;
				self.ver_best_element_cnt_mod_xm := ver_best_element_cnt_mod_xm;
				self.mod14_om_nodob_b1_c2_b1 := mod14_om_nodob_b1_c2_b1;
				self.ver_best_e_cnt_mod_xm_nodob_b1_c2_b2 := ver_best_e_cnt_mod_xm_nodob_b1_c2_b2;
				self.ver_best_score_mod_xm_nodob_b1_c2_b2 := ver_best_score_mod_xm_nodob_b1_c2_b2;
				self.ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2 := ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b2;
				self.ver_notbest_score_mod_xm_nodob_b1_c2_b2 := ver_notbest_score_mod_xm_nodob_b1_c2_b2;
				self.ver_element_cnt_mod_xm_nodob_b1_c2_b2 := ver_element_cnt_mod_xm_nodob_b1_c2_b2;
				self.ver_score_mod_xm_nodob_b1_c2_b2 := ver_score_mod_xm_nodob_b1_c2_b2;
				self.mod14_xm_nodob_b1_c2_b2 := mod14_xm_nodob_b1_c2_b2;
				self.mod14_nm_nodob_b1_c2_b3 := mod14_nm_nodob_b1_c2_b3;
				self.mod14_om_nodob_b1 := mod14_om_nodob_b1;
				self.mod14_scr_b1 := mod14_scr_b1;
				self.mod14_xm_nodob_b1 := mod14_xm_nodob_b1;
				self.ver_best_score_mod_xm_nodob_b1 := ver_best_score_mod_xm_nodob_b1;
				self.mod14_nm_nodob_b1 := mod14_nm_nodob_b1;
				self.phat_b1 := phat_b1;
				self.ver_score_mod_xm_nodob_b1 := ver_score_mod_xm_nodob_b1;
				self.ver_best_e_cnt_mod_xm_nodob_b1 := ver_best_e_cnt_mod_xm_nodob_b1;
				self.ver_notbest_score_mod_xm_nodob_b1 := ver_notbest_score_mod_xm_nodob_b1;
				self.ver_element_cnt_mod_xm_nodob_b1 := ver_element_cnt_mod_xm_nodob_b1;
				self.ver_notbest_e_cnt_mod_xm_nodob_b1 := ver_notbest_e_cnt_mod_xm_nodob_b1;
				self.mod14_om_nodob := mod14_om_nodob;
				self.mod14_scr_2 := mod14_scr_2;
				self.mod14_xm_nodob := mod14_xm_nodob;
				self.ver_best_score_mod_xm_nodob := ver_best_score_mod_xm_nodob;
				self.mod14_nm_nodob := mod14_nm_nodob;
				self.phat_2 := phat_2;
				self.ver_score_mod_xm_nodob := ver_score_mod_xm_nodob;
				self.ver_best_e_cnt_mod_xm_nodob := ver_best_e_cnt_mod_xm_nodob;
				self.ver_notbest_score_mod_xm_nodob := ver_notbest_score_mod_xm_nodob;
				self.ver_element_cnt_mod_xm_nodob := ver_element_cnt_mod_xm_nodob;
				self.ver_notbest_e_cnt_mod_xm_nodob := ver_notbest_e_cnt_mod_xm_nodob;
				self.RVG1003 := RVG1003;
				self.ov_ssndead := ov_ssndead;
				self.ov_ssnprior := ov_ssnprior;
				self.ov_criminal_flag := ov_criminal_flag;
				self.ov_corrections := ov_corrections;
				self.ov_impulse := ov_impulse;
				self.rvg1003_2 := rvg1003_2;
				self.scored_222s := scored_222s;
				self.rvg1003_3 := rvg1003_3;
			#else
				self.seq := le.seq;
				inCalif := isCalifornia and (
					(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
					+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
					+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

				self.ri := riskwise.rv3moneyReasonCodes( le, 4, inCalif, PreScreenOptOut );
				self.score := map(
					self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
					self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
					self.ri[1].hri='35' => '000',
					intformat(rvg1003_3,3,1)
				);
			#end

		END;

		model := project( clam, doModel(LEFT) );
		return model;

	END;


import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVR1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia=false, boolean PreScreenOptOut=false, boolean useRVReasons1=false ) := FUNCTION

	RVR_DEBUG := false;
	
	#if(RVR_DEBUG)
	Layout_Debug := record
		unsigned seq;
		risk_indicators.layout_boca_shell clam;
		Integer4 DID;
		Boolean truedid;
		String adl_category;
		String out_unit_desig;
		String out_sec_range;
		String out_st;
		String out_addr_type;
		String out_addr_status;
		String in_dob;
		Integer4 nas_summary;
		Integer4 nap_summary;
		String nap_status;
		Integer4 did_count;
		Integer4 rc_dirsaddr_lastscore;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_hriskaddrflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_ssnvalflag;
		String rc_pwssnvalflag;
		String rc_ssnhighissue;
		String rc_areacodesplitflag;
		String rc_areacodesplitdate;
		String rc_addrvalflag;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		Integer4 rc_fnamecount;
		Integer4 rc_addrcount;
		Integer4 rc_phonelnamecount;
		Integer4 rc_phoneaddr_phonecount;
		Integer4 rc_disthphoneaddr;
		String rc_phonetype;
		String rc_ziptypeflag;
		String rc_statezipflag;
		String rc_cityzipflag;
		Boolean rc_fnamessnmatch;
		Integer4 combo_fnamescore;
		Integer4 combo_addrscore;
		Integer4 combo_hphonescore;
		Integer4 combo_ssnscore;
		Integer4 combo_dobscore;
		Integer4 combo_fnamecount;
		Integer4 combo_lnamecount;
		Integer4 combo_addrcount;
		Integer4 combo_ssncount;
		Integer4 combo_dobcount;
		Integer4 eq_count;
		Integer4 pr_count;
		Integer4 w_count;
		Integer4 adl_eq_first_seen;
		Integer4 adl_en_first_seen;
		Integer4 adl_pr_first_seen;
		Integer4 adl_em_first_seen;
		Integer4 adl_vo_first_seen;
		Integer4 adl_em_only_first_seen;
		Integer4 adl_w_first_seen;
		Integer4 adl_w_last_seen;
		String fname_sources;
		String lname_sources;
		String addr_sources;
		String em_only_sources;
		Boolean voter_avail;
		Boolean dobpop;
		Integer4 adl_score;
		Integer4 fname_score;
		Integer4 lname_change_date;
		Boolean lname_eda_sourced;
		String lname_eda_sourced_type;
		Integer4 Age;
		Integer4 add1_address_score;
		Boolean add1_isbestmatch;
		Integer4 add1_unit_count;
		Integer4 add1_lres;
		String add1_avm_land_use;
		String add1_avm_recording_date;
		String add1_avm_assessed_value_year;
		String add1_avm_market_total_value;
		Integer4 add1_avm_price_index_valuation;
		Integer4 add1_avm_hedonic_valuation;
		Integer4 add1_avm_automated_valuation;
		Integer4 add1_avm_automated_valuation_2;
		Integer4 add1_avm_automated_valuation_4;
		Integer4 add1_avm_med_fips;
		Integer4 add1_avm_med_geo11;
		Integer4 add1_avm_med_geo12;
		Boolean add1_eda_sourced;
		Integer4 add1_naprop;
		Integer4 add1_purchase_date;
		Integer4 add1_built_date;
		Integer4 add1_mortgage_date;
		String add1_mortgage_type;
		String add1_financing_type;
		Integer4 add1_assessed_amount;
		Integer4 add1_date_first_seen;
		Integer4 add1_building_area;
		Integer4 add1_no_of_baths;
		Integer4 add1_no_of_partial_baths;
		Integer4 add1_pop;
		Integer4 property_owned_total;
		Integer4 property_owned_assessed_total;
		Integer4 property_sold_total;
		Integer4 property_sold_assessed_total;
		Integer4 prop1_sale_price;
		Integer4 prop1_prev_purchase_date;
		Integer4 dist_a1toa2;
		Integer4 dist_a1toa3;
		Integer4 dist_a2toa3;
		Integer4 add2_address_score;
		Integer4 add2_lres;
		String add2_avm_land_use;
		String add2_avm_assessed_value_year;
		String add2_avm_market_total_value;
		Integer4 add2_avm_price_index_valuation;
		Integer4 add2_avm_hedonic_valuation;
		Integer4 add2_avm_automated_valuation;
		Integer4 add2_avm_automated_valuation_2;
		Integer4 add2_avm_automated_valuation_4;
		String add2_sources;
		Boolean add2_applicant_owned;
		Boolean add2_family_owned;
		Integer4 add2_naprop;
		String add2_land_use_code;
		Integer4 add2_building_area;
		Integer4 add2_no_of_baths;
		Integer4 add2_mortgage_date;
		String add2_mortgage_type;
		String add2_mortgage_due_date;
		Integer4 add2_assessed_amount;
		Integer4 add2_date_first_seen;
		Boolean add2_pop;
		Integer4 add3_lres;
		String add3_sources;
		Boolean add3_applicant_owned;
		Boolean add3_family_owned;
		Integer4 add3_naprop;
		String add3_mortgage_type;
		String add3_financing_type;
		Integer4 add3_assessed_amount;
		Integer4 add3_date_first_seen;
		Boolean add3_pop;
		Integer4 addrs_5yr;
		Integer4 addrs_10yr;
		Boolean addrs_prison_history;
		String gong_did_first_seen;
		Integer4 gong_did_phone_ct;
		Integer4 namePerSSN_count;
		Integer4 header_first_seen;
		String inputssncharflag;
		Integer4 ssns_per_adl;
		Integer4 addrs_per_adl;
		Integer4 phones_per_adl;
		Integer4 adlPerSSN_count;
		Integer4 ssns_per_addr;
		Integer4 adls_per_phone;
		Integer4 ssns_per_adl_c6;
		Integer4 ssns_per_addr_c6;
		Integer4 vo_addrs_per_adl;
		Integer4 invalid_addrs_per_adl_c6;
		Integer4 infutor_first_seen;
		Integer4 infutor_nap;
		Integer4 impulse_count;
		Integer4 attr_addrs_last90;
		Integer4 attr_addrs_last12;
		Integer4 attr_addrs_last24;
		Integer4 attr_num_watercraft60;
		Integer4 attr_total_number_derogs;
		Integer4 attr_eviction_count;
		Integer4 attr_eviction_count30;
		Integer4 attr_eviction_count90;
		Integer4 attr_eviction_count180;
		Integer4 attr_eviction_count12;
		Integer4 attr_eviction_count24;
		Integer4 attr_eviction_count36;
		Integer4 attr_eviction_count60;
		Integer4 attr_num_nonderogs90;
		Integer4 attr_num_proflic30;
		Integer4 attr_num_proflic_exp12;
		Boolean Bankrupt;
		Integer4 date_last_seen;
		String filing_type;
		String disposition;
		Integer4 filing_count;
		Integer4 bk_recent_count;
		Integer4 bk_disposed_historical_count;
		Integer4 liens_recent_unreleased_count;
		Integer4 liens_historical_unreleased_ct;
		String liens_last_unrel_date;
		Integer4 liens_unrel_cj_ct;
		Integer4 liens_unrel_cj_first_seen;
		Integer4 liens_unrel_cj_last_seen;
		Integer4 liens_unrel_ft_ct;
		Integer4 liens_unrel_lt_ct;
		Integer4 liens_unrel_lt_first_seen;
		Integer4 liens_unrel_o_ct;
		Integer4 liens_unrel_ot_ct;
		Integer4 liens_unrel_ot_first_seen;
		Integer4 liens_unrel_ot_total_amount;
		Integer4 liens_unrel_sc_ct;
		Integer4 criminal_count;
		Integer4 criminal_last_date;
		Integer4 felony_last_date;
		String ams_age;
		String ams_class;
		String ams_college_code;
		String ams_college_type;
		String ams_income_level_code;
		Boolean prof_license_flag;
		String prof_license_category;
		String wealth_index;
		String input_dob_match_level;
		Integer4 inferred_age;
		Integer4 reported_dob;
		Integer4 archive_date;
		Integer4 today;
		Integer4 sysdate;
		real4 sysyear;
		Integer4 in_dob2;
		real4 years_in_dob;
		Integer4 rc_ssnhighissue2;
		real4 years_rc_ssnhighissue;
		Integer4 rc_areacodesplitdate2;
		real4 years_rc_areacodesplitdate;
		real4 months_rc_areacodesplitdate;
		Integer4 adl_eq_first_seen2;
		real4 years_adl_eq_first_seen;
		real4 months_adl_eq_first_seen;
		Integer4 adl_en_first_seen2;
		real4 years_adl_en_first_seen;
		real4 months_adl_en_first_seen;
		Integer4 adl_pr_first_seen2;
		real4 years_adl_pr_first_seen;
		real4 months_adl_pr_first_seen;
		Integer4 adl_em_first_seen2;
		real4 years_adl_em_first_seen;
		real4 months_adl_em_first_seen;
		Integer4 adl_vo_first_seen2;
		real4 years_adl_vo_first_seen;
		real4 months_adl_vo_first_seen;
		Integer4 adl_em_only_first_seen2;
		real4 years_adl_em_only_first_seen;
		real4 months_adl_em_only_first_seen;
		Integer4 adl_w_first_seen2;
		real4 years_adl_w_first_seen;
		real4 months_adl_w_first_seen;
		Integer4 adl_w_last_seen2;
		real4 years_adl_w_last_seen;
		Integer4 lname_change_date2;
		real4 years_lname_change_date;
		Integer4 add1_avm_recording_date2;
		real4 years_add1_avm_recording_date;
		Integer4 add1_avm_assessed_value_year2;
		real4 years_add1_avm_assess_year;
		Integer4 add1_purchase_date2;
		real4 years_add1_purchase_date;
		Integer4 add1_built_date2;
		real4 years_add1_built_date;
		Integer4 add1_mortgage_date2;
		real4 years_add1_mortgage_date;
		Integer4 add1_date_first_seen2;
		real4 years_add1_date_first_seen;
		real4 months_add1_date_first_seen;
		Integer4 prop1_prev_purchase_date2;
		real4 years_prop1_prev_purchase_date;
		Integer4 add2_avm_assessed_value_year2;
		real4 years_add2_avm_assess_year;
		Integer4 add2_mortgage_date2;
		real4 years_add2_mortgage_date;
		Integer4 add2_mortgage_due_date2;
		real4 years_add2_mortgage_due_date;
		Integer4 add2_date_first_seen2;
		real4 years_add2_date_first_seen;
		real4 months_add2_date_first_seen;
		Integer4 add3_date_first_seen2;
		real4 years_add3_date_first_seen;
		real4 months_add3_date_first_seen;
		Integer4 gong_did_first_seen2;
		real4 years_gong_did_first_seen;
		Integer4 header_first_seen2;
		real4 years_header_first_seen;
		Integer4 infutor_first_seen2;
		real4 years_infutor_first_seen;
		Integer4 liens_last_unrel_date2;
		real4 years_liens_last_unrel_date;
		Integer4 liens_unrel_cj_first_seen2;
		real4 years_liens_unrel_cj_first_seen;
		Integer4 liens_unrel_lt_first_seen2;
		real4 years_liens_unrel_lt_first_seen;
		Integer4 liens_unrel_ot_first_seen2;
		real4 years_liens_unrel_ot_first_seen;
		Integer4 criminal_last_date2;
		real4 years_criminal_last_date;
		Integer4 felony_last_date2;
		real4 years_felony_last_date;
		Integer4 reported_dob2;
		real4 years_reported_dob;
		Boolean source_tot_AK;
		Boolean source_tot_AM;
		Boolean source_tot_AR;
		Boolean source_tot_BA;
		Boolean source_tot_CG;
		Boolean source_tot_DS;
		Boolean source_tot_EB;
		Boolean source_tot_EM;
		Boolean source_tot_VO;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean source_tot_P;
		Boolean source_tot_W;
		Boolean source_tot_voter;
		Boolean source_fst_PL;
		Boolean source_fst_SL;
		Boolean source_lst_PL;
		Boolean source_lst_SL;
		Boolean source_add_P;
		Boolean source_add_PL;
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
		Boolean verfst_p;
		Boolean verlst_p;
		Boolean veradd_p;
		Boolean verphn_p;
		Integer4 ver_phncount;
		real4 years_adl_first_seen_max_fcra;
		real4 months_adl_first_seen_max_fcra;
		String add_ec1;
		String add_ec3;
		String add_ec4;
		Boolean add_apt;
		Boolean phn_disconnected;
		Boolean phn_inval;
		Boolean phn_cellpager;
		Boolean phn_zipmismatch;
		Boolean phn_residential;
		Boolean ssn_priordob;
		Boolean ssn_inval;
		Boolean ssn_issued18;
		Boolean ssn_deceased;
		Boolean ssn_adl_prob;
		Boolean ssn_prob;
		Boolean bk_flag;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean lien_flag;
		Boolean add1_AVM_hit;
		Integer4 add1_avm_med;
		real4 add1_avm_to_med_ratio;
		real4 add_lres_month_avg;
		Integer4 pk_wealth_index;
		real4 pk_wealth_index_m;
		Integer4 wealth_index_cm;
		Boolean source_tot_DA;
		Boolean source_tot_CG_2;
		Boolean source_tot_P_2;
		Boolean source_tot_BA_2;
		Boolean source_tot_AM_2;
		Boolean source_tot_W_2;
		Boolean add_apt_2;
		Integer4 pk_bk_level;
		Integer4 rc_valid_bus_phone;
		Integer4 rc_valid_res_phone;
		Integer4 age_rcd;
		Integer4 add1_mortgage_type_ord;
		real4 prof_license_category_ord;
		Integer4 pk_attr_total_number_derogs;
		Integer4 pk_attr_total_number_derogs_2;
		Integer4 pk_attr_num_nonderogs90;
		Integer4 pk_attr_num_nonderogs90_2;
		Integer4 pk_derog_total;
		Integer4 pk_derog_total_m;
		Integer4 add1_avm_automated_valuation_rcd;
		Integer4 add1_avm_automated_val_2_rcd;
		Integer4 pk_liens_unrel_ot_total_amount;
		Integer4 attr_num_watercraft60_cap;
		Integer4 combo_addrcount_cap;
		Integer4 gong_did_phone_ct_cap;
		Integer4 ams_college_code_mis;
		Integer4 ams_college_code_cm;
		Integer4 ams_income_level_code_cm;
		Integer4 unit5;
		Integer4 pk_dist_a1toa2;
		Integer4 pk_dist_a1toa3;
		Integer4 pk_dist_a2toa3;
		Integer4 pk_rc_disthphoneaddr;
		real4 Dist_mod;
		Integer4 date_last_seen2;
		Integer4 liens_unrel_cj_last_seen2;
		real4 years_date_last_seen;
		real4 years_liens_unrel_cj_last_seen;
		Integer4 pk_yr_date_last_seen;
		Integer4 pk_bk_yr_date_last_seen;
		real4 pk_bk_yr_date_last_seen_m1;
		Integer4 adl_category_ord;
		Integer4 pk_yr_liens_unrel_cj_last_seen;
		Integer4 pk2_yr_liens_unrel_cj_last_seen;
		real4 predicted_inc_high;
		real4 predicted_inc_low;
		real4 pred_inc;
		real4 estimated_income;
		real4 estimated_income_2;
		Integer4 pk_ssnchar_invalid_or_recent;
		Integer4 pk_did0;
		Boolean pk_ssn_prob_nodob;
		Integer4 pk_yr_adl_vo_first_seen;
		Integer4 pk_yr_adl_em_only_first_seen;
		Integer4 pk_yr_adl_first_seen_max_fcra;
		Integer4 pk_mo_adl_first_seen_max_fcra;
		Integer4 pk_yr_lname_change_date;
		Integer4 pk_yr_gong_did_first_seen;
		Integer4 pk_yr_header_first_seen;
		Integer4 pk_yr_infutor_first_seen;
		Integer4 pk_multi_did;
		Integer4 pk_nas_summary;

		Integer4 pk_rc_dirsaddr_lastscore;
		Integer4 pk_adl_score;
		Integer4 pk_combo_fnamescore;
		Integer4 pk_fname_score;
		Integer4 pk_combo_addrscore;
		Integer4 pk_combo_hphonescore;
		Integer4 pk_combo_ssnscore;
		Integer4 pk_combo_dobscore;
		Integer4 pk_combo_fnamecount;
		Integer4 pk_combo_fnamecount_nb;
		Integer4 pk_rc_fnamecount;
		Integer4 pk_rc_fnamecount_nb;
		Integer4 pk_combo_lnamecount;
		Integer4 pk_rc_phonelnamecount;
		Integer4 pk_combo_addrcount_nb;
		Integer4 pk_rc_addrcount;
		Integer4 pk_rc_addrcount_nb;
		Integer4 pk_rc_phoneaddr_phonecount;
		Integer4 pk_ver_phncount;
		Integer4 pk_combo_ssncount;
		Integer4 pk_combo_dobcount;
		Integer4 pk_combo_dobcount_nb;
		Integer4 pk_eq_count;
		Integer4 pk_pos_secondary_sources;
		Integer4 pk_voter_flag;
		Integer4 pk_lname_eda_sourced_type_lvl;
		Integer4 pk_add1_address_score;
		Integer4 pk_add1_unit_count2;
		Integer4 pk_add2_address_score;
		Integer4 pk_add2_pos_sources;
		Integer4 pk_add2_pos_secondary_sources;

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
		Integer4 pk_em_only_ver_lvl;
		Integer4 pk_add2_em_ver_lvl;
		Integer4 pk_ssnchar_invalid_or_recent_2;
		Integer4 pk_infutor_risk_lvl;
		Integer4 pk_infutor_risk_lvl_nb;
		Integer4 pk_yr_adl_vo_first_seen2;
		Integer4 pk_yr_adl_em_only_first_seen2;
		Integer4 pk_yrmo_adl_first_seen_max_fcra2;
		Integer4 pk_yr_lname_change_date2;
		Integer4 pk_yr_gong_did_first_seen2;
		Integer4 pk_yr_header_first_seen2;
		Integer4 pk_yr_infutor_first_seen2;
		Integer4 pk_estimated_income;
		Integer4 pk_yr_adl_w_first_seen;
		Integer4 pk_yr_adl_w_last_seen;
		Integer4 pk_yr_add1_purchase_date;
		Integer4 pk_yr_add1_built_date;
		Integer4 pk_yr_add1_mortgage_date;
		Integer4 pk_yr_add1_date_first_seen;
		Integer4 pk_yr_prop1_prev_purchase_date;
		Integer4 pk_yr_add2_mortgage_date;
		Integer4 pk_yr_add2_mortgage_due_date;
		Integer4 pk_yr_add2_date_first_seen;
		Integer4 pk_yr_add3_date_first_seen;
		Integer4 pk_property_owned_assessed_total;
		Integer4 pk_prop1_sale_price;
		Integer4 pk_add1_assessed_amount;
		Integer4 pk_add2_assessed_amount;
		Integer4 pk_add3_assessed_amount;
		Integer4 pk_property_owned_assessed_total_2;
		Integer4 pk_prop1_sale_price_2;
		Integer4 pk_add1_assessed_amount_2;
		Integer4 pk_add2_assessed_amount_2;
		Integer4 pk_add3_assessed_amount_2;
		Integer4 pk_add1_building_area;
		Integer4 pk_add2_building_area;
		Integer4 pk_yr_adl_w_first_seen2;
		Integer4 pk_yr_adl_w_last_seen2;
		Integer4 pk_pr_count;
		Integer4 pk_addrs_sourced_lvl;
		Integer4 pk_naprop_level;
		Integer4 pk_naprop_level2_b1;
		Integer4 pk_naprop_level2;
		Integer4 pk_add2_own_level;
		Integer4 pk_add3_own_level;
		Integer4 pk_yr_add1_purchase_date2;
		Integer4 pk_yr_add1_built_date2;
		Integer4 pk_yr_add1_mortgage_date2;
		Integer4 pk_add1_mortgage_risk;
		Integer4 pk_add1_adjustable_financing;
		Integer4 pk_add1_assessed_amount2;
		Integer4 pk_yr_add1_date_first_seen2;
		Integer4 pk_add1_building_area2;
		Integer4 pk_add1_no_of_baths;
		Integer4 pk_add1_no_of_partial_baths;
		Integer4 pk_property_owned_total;
		Integer4 pk_prop_own_assess_tot2;
		Integer4 pk_prop1_sale_price2;
		Integer4 pk_yr_prop1_prev_purchase_date2;
		String pk_add2_land_use_cat;
		Integer4 pk_add2_land_use_risk_level;
		Integer4 pk_add2_building_area2;
		Integer4 pk_add2_no_of_baths;
		Integer4 pk_yr_add2_mortgage_date2;
		Integer4 pk_add2_mortgage_risk;
		Integer4 pk_yr_add2_mortgage_due_date2;
		Integer4 pk_add2_assessed_amount2;
		Integer4 pk_yr_add2_date_first_seen2;
		Integer4 pk_add3_mortgage_risk;
		Integer4 pk_add3_adjustable_financing;
		Integer4 pk_add3_assessed_amount2;
		Integer4 pk_yr_add3_date_first_seen2;
		Integer4 pk_w_count;
		Integer4 pk_yr_liens_last_unrel_date;
		Integer4 pk_yr_liens_unrel_cj_first_seen;
		Integer4 pk_yr_liens_unrel_lt_first_seen;
		Integer4 pk_yr_liens_unrel_ot_first_seen;
		Integer4 pk_yr_criminal_last_date;
		Integer4 pk_yr_felony_last_date;
		Integer4 pk_bk_level_2;
		Integer4 pk_liens_unrel_cj_ct;
		Integer4 pk_liens_unrel_ft_ct;
		Integer4 pk_liens_unrel_lt_ct;
		Integer4 pk_liens_unrel_o_ct;
		Integer4 pk_liens_unrel_ot_ct;
		Integer4 pk_liens_unrel_sc_ct;
		Integer4 pk_liens_unrel_count;
		Integer4 pk_lien_type_level;
		Integer4 pk_yr_liens_last_unrel_date2;
		Integer4 pk_yr_liens_last_unrel_date3;

		real4 pk_yr_liens_last_unrel_date3_2;
		Integer4 pk_yr_liens_unrel_cj_first_sn2;
		Integer4 pk_yr_liens_unrel_lt_first_sn2;
		Integer4 pk_yr_liens_unrel_ot_first_sn2;
		Integer4 pk_attr_eviction_count;
		Integer4 pk_eviction_level;
		Integer4 pk_yr_criminal_last_date2;
		Integer4 pk_yr_felony_last_date2;
		Integer4 pk_attr_total_number_derogs_3;
		Integer4 pk_yr_rc_ssnhighissue;
		Integer4 pk_yr_rc_areacodesplitdate;
		Integer4 pk_add_standarization_error;
		Integer4 pk_addr_changed;
		Integer4 pk_unit_changed;
		Integer4 pk_add_standarization_flag;
		Integer4 pk_addr_not_valid;
		Integer4 pk_corp_mil_zip;
		Integer4 pk_area_code_split;
		Integer4 pk_recent_ac_split;
		Boolean pk_phn_not_residential;
		Integer4 pk_disconnected;
		Integer4 pk_phn_cell_pager_inval;
		Integer4 pk_yr_rc_ssnhighissue2;
		Integer4 pk_pl_sourced_level;
		Integer4 pk_prof_lic_cat;
		Integer4 pk_attr_num_proflic30;
		Integer4 pk_attr_num_proflic_exp12;
		Integer4 pk_add_lres_month_avg;
		Integer4 pk_add1_lres;
		Integer4 pk_add2_lres;
		Integer4 pk_add3_lres;
		Integer4 pk_add1_lres_flag;
		Integer4 pk_add2_lres_flag;
		Integer4 pk_add3_lres_flag;
		Integer4 pk_lres_flag_level;
		Integer4 pk_addrs_5yr;
		Integer4 pk_addrs_10yr;
		Integer4 pk_add_lres_month_avg2;
		Integer4 pk_nameperssn_count;
		Integer4 pk_ssns_per_adl;
		Integer4 pk_addrs_per_adl;
		Integer4 pk_phones_per_adl;
		Integer4 pk_adlperssn_count;
		Integer4 pk_ssns_per_addr2_b1;
		Integer4 pk_ssns_per_addr2_b2;
		Integer4 pk_ssns_per_addr2;
		Integer4 pk_adls_per_phone;
		Integer4 pk_ssns_per_adl_c6;
		Integer4 pk_ssns_per_addr_c6_b1;
		Integer4 pk_ssns_per_addr_c6_b2;
		Integer4 pk_ssns_per_addr_c6;
		Integer4 pk_vo_addrs_per_adl;
		Integer4 pk_attr_addrs_last90;
		Integer4 pk_attr_addrs_last12;
		Integer4 pk_attr_addrs_last24;

		real4 ams_class_n_b8;
		real4 ams_class_n_b8_2;
		Integer4 pk_ams_class_level_b8;
		real4 pk_since_ams_class_year;
		real4 ams_class_n;
		Integer4 pk_ams_class_level;
		Integer4 pk_sl_name_match;
		Integer4 pk_ams_4yr_college;
		Integer4 pk_ams_college_type;
		Integer4 pk_ams_income_level_code;
		Integer4 pk_yr_in_dob;
		Integer4 pk_yr_reported_dob;
		Integer4 pk_yr_in_dob2;
		Integer4 pk_ams_age;
		Integer4 pk_inferred_age;
		Integer4 pk_yr_reported_dob2;
		Integer4 pk_yr_add1_avm_recording_date;
		Integer4 pk_yr_add1_avm_assess_year;
		Integer4 pk_yr_add2_avm_assess_year;
		Integer4 pk_add1_avm_mkt;
		Integer4 pk_add1_avm_pi;
		Integer4 pk_add1_avm_hed;
		Integer4 pk_add1_avm_auto;
		Integer4 pk_add1_avm_auto2;
		Integer4 pk_add1_avm_auto4;
		Integer4 pk_add1_avm_med;
		Integer4 pk_add2_avm_mkt;
		Integer4 pk_add2_avm_pi;
		Integer4 pk_add2_avm_hed;
		Integer4 pk_add2_avm_auto;
		Integer4 pk_add2_avm_auto2;
		Integer4 pk_add2_avm_auto4;
		Integer4 pk_add1_avm_mkt_2;
		Integer4 pk_add1_avm_pi_2;
		Integer4 pk_add1_avm_hed_2;
		Integer4 pk_add1_avm_auto_2;
		Integer4 pk_add1_avm_auto2_2;
		Integer4 pk_add1_avm_auto4_2;
		Integer4 pk_add1_avm_med_2;
		Integer4 pk_add2_avm_mkt_2;
		Integer4 pk_add2_avm_pi_2;
		Integer4 pk_add2_avm_hed_2;
		Integer4 pk_add2_avm_auto_2;
		Integer4 pk_add2_avm_auto2_2;
		Integer4 pk_add2_avm_auto4_2;
		real4 pk_add1_avm_to_med_ratio;
		real4 pk_add1_avm_to_med_ratio_2;
		Integer4 pk2_add1_avm_mkt;
		Integer4 pk2_add1_avm_pi;
		Integer4 pk2_add1_avm_hed;
		Integer4 pk2_add1_avm_auto2;
		Integer4 pk2_add1_avm_auto4;
		Integer4 pk_avm_auto_diff2;
		Integer4 pk_avm_auto_diff4;
		Integer4 pk_avm_auto_diff2_lvl;
		Integer4 pk_avm_auto_diff4_lvl;
		Integer4 pk2_add1_avm_med;
		Integer4 pk2_add1_avm_to_med_ratio;
		Integer4 pk_add2_avm_hit;
		Integer4 pk_avm_hit_level;
		Integer4 pk2_add2_avm_mkt;
		Integer4 pk2_add2_avm_pi;
		Integer4 pk2_add2_avm_hed;
		Integer4 pk2_add2_avm_auto4;
		Integer4 pk_add2_avm_auto_diff2;
		Integer4 pk_add2_avm_auto_diff2_lvl;
		Integer4 pk2_yr_add1_avm_recording_date;
		Integer4 pk2_yr_add1_avm_assess_year;
		Integer4 pk2_yr_add2_avm_assess_year;
		Integer4 pk_dist_a1toa2_2;
		Integer4 pk_dist_a1toa3_2;
		Integer4 pk_rc_disthphoneaddr_2;
		Integer4 pk_out_st_division_lvl;
		Integer4 pk_wealth_index_2;
		Boolean verfst_p_2;
		Boolean verlst_p_2;
		Boolean veradd_p_2;
		Boolean verphn_p_2;
		Integer4 pk_impulse_count;
		Integer4 pk_impulse_count_2;
		Integer4 pk_attr_total_number_derogs_4;
		Integer4 pk_attr_total_number_derogs_5;
		Integer4 pk_attr_num_nonderogs90_3;
		Integer4 pk_attr_num_nonderogs90_4;
		Integer4 pk_attr_num_nonderogs90_b;
		Integer4 pk_adl_cat_deceased;
		String bs_own_rent;
		Integer4 bs_attr_derog_flag;
		Integer4 bs_attr_eviction_flag;
		Integer4 bs_attr_derog_flag2;
		String pk_Segment;
		String pk_segment_2;
		real4 pk_nas_summary_mm_b1_c2_b1;
		real4 pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
		real4 pk_adl_score_mm_b1_c2_b1;
		real4 pk_combo_addrscore_mm_b1_c2_b1;
		real4 pk_combo_hphonescore_mm_b1_c2_b1;
		real4 pk_combo_ssnscore_mm_b1_c2_b1;
		real4 pk_combo_dobscore_mm_b1_c2_b1;
		real4 pk_combo_fnamecount_mm_b1_c2_b1;

		real4 pk_rc_fnamecount_mm_b1_c2_b1;
		real4 pk_combo_lnamecount_mm_b1_c2_b1;
		real4 pk_rc_phonelnamecount_mm_b1_c2_b1;
		real4 pk_rc_addrcount_mm_b1_c2_b1;
		real4 pk_rc_phoneaddr_phonecount_mm_b1_c2_b1;
		real4 pk_ver_phncount_mm_b1_c2_b1;
		real4 pk_combo_ssncount_mm_b1_c2_b1;
		real4 pk_combo_dobcount_mm_b1_c2_b1;
		real4 pk_eq_count_mm_b1_c2_b1;
		real4 pk_pos_secondary_sources_mm_b1_c2_b1;
		real4 pk_voter_flag_mm_b1_c2_b1;
		real4 pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
		real4 pk_add1_address_score_mm_b1_c2_b1;
		real4 pk_add2_address_score_mm_b1_c2_b1;
		real4 pk_add2_pos_sources_mm_b1_c2_b1;
		real4 pk_add2_pos_secondary_sources_mm_b1_c2_b1;
		real4 pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
		real4 pk_infutor_risk_lvl_mm_b1_c2_b1;
		real4 pk_yr_adl_vo_first_seen2_mm_b1_c2_b1;
		real4 pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
		real4 pk_yr_lname_change_date2_mm_b1_c2_b1;
		real4 pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
		real4 pk_yr_header_first_seen2_mm_b1_c2_b1;
		real4 pk_yr_infutor_first_seen2_mm_b1_c2_b1;
		real4 pk_em_only_ver_lvl_mm_b1_c2_b1;
		real4 pk_add2_em_ver_lvl_mm_b1_c2_b1;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
		real4 pk_nas_summary_mm_b1_c2_b2;
		real4 pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
		real4 pk_adl_score_mm_b1_c2_b2;
		real4 pk_combo_addrscore_mm_b1_c2_b2;
		real4 pk_combo_hphonescore_mm_b1_c2_b2;
		real4 pk_combo_ssnscore_mm_b1_c2_b2;
		real4 pk_combo_dobscore_mm_b1_c2_b2;
		real4 pk_combo_fnamecount_mm_b1_c2_b2;
		real4 pk_rc_fnamecount_mm_b1_c2_b2;
		real4 pk_combo_lnamecount_mm_b1_c2_b2;
		real4 pk_rc_phonelnamecount_mm_b1_c2_b2;
		real4 pk_rc_addrcount_mm_b1_c2_b2;
		real4 pk_rc_phoneaddr_phonecount_mm_b1_c2_b2;
		real4 pk_ver_phncount_mm_b1_c2_b2;
		real4 pk_combo_ssncount_mm_b1_c2_b2;
		real4 pk_combo_dobcount_mm_b1_c2_b2;
		real4 pk_eq_count_mm_b1_c2_b2;
		real4 pk_pos_secondary_sources_mm_b1_c2_b2;
		real4 pk_voter_flag_mm_b1_c2_b2;
		real4 pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
		real4 pk_add1_address_score_mm_b1_c2_b2;
		real4 pk_add2_address_score_mm_b1_c2_b2;
		real4 pk_add2_pos_sources_mm_b1_c2_b2;
		real4 pk_add2_pos_secondary_sources_mm_b1_c2_b2;
		real4 pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
		real4 pk_infutor_risk_lvl_mm_b1_c2_b2;
		real4 pk_yr_adl_vo_first_seen2_mm_b1_c2_b2;
		real4 pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
		real4 pk_yr_lname_change_date2_mm_b1_c2_b2;
		real4 pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
		real4 pk_yr_header_first_seen2_mm_b1_c2_b2;
		real4 pk_yr_infutor_first_seen2_mm_b1_c2_b2;
		real4 pk_em_only_ver_lvl_mm_b1_c2_b2;
		real4 pk_add2_em_ver_lvl_mm_b1_c2_b2;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
		real4 pk_nas_summary_mm_b1_c2_b3;
		real4 pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
		real4 pk_adl_score_mm_b1_c2_b3;
		real4 pk_combo_addrscore_mm_b1_c2_b3;
		real4 pk_combo_hphonescore_mm_b1_c2_b3;
		real4 pk_combo_ssnscore_mm_b1_c2_b3;
		real4 pk_combo_dobscore_mm_b1_c2_b3;
		real4 pk_combo_fnamecount_mm_b1_c2_b3;
		real4 pk_rc_fnamecount_mm_b1_c2_b3;
		real4 pk_combo_lnamecount_mm_b1_c2_b3;
		real4 pk_rc_phonelnamecount_mm_b1_c2_b3;
		real4 pk_rc_addrcount_mm_b1_c2_b3;
		real4 pk_rc_phoneaddr_phonecount_mm_b1_c2_b3;
		real4 pk_ver_phncount_mm_b1_c2_b3;
		real4 pk_combo_ssncount_mm_b1_c2_b3;
		real4 pk_combo_dobcount_mm_b1_c2_b3;
		real4 pk_eq_count_mm_b1_c2_b3;
		real4 pk_pos_secondary_sources_mm_b1_c2_b3;
		real4 pk_voter_flag_mm_b1_c2_b3;
		real4 pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
		real4 pk_add1_address_score_mm_b1_c2_b3;
		real4 pk_add2_address_score_mm_b1_c2_b3;
		real4 pk_add2_pos_sources_mm_b1_c2_b3;
		real4 pk_add2_pos_secondary_sources_mm_b1_c2_b3;
		real4 pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
		real4 pk_infutor_risk_lvl_mm_b1_c2_b3;
		real4 pk_yr_adl_vo_first_seen2_mm_b1_c2_b3;
		real4 pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
		real4 pk_yr_lname_change_date2_mm_b1_c2_b3;
		real4 pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
		real4 pk_yr_header_first_seen2_mm_b1_c2_b3;
		real4 pk_yr_infutor_first_seen2_mm_b1_c2_b3;
		real4 pk_em_only_ver_lvl_mm_b1_c2_b3;
		real4 pk_add2_em_ver_lvl_mm_b1_c2_b3;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
		real4 pk_nas_summary_mm_b1_c2_b4;
		real4 pk_rc_dirsaddr_lastscore_mm_b1_c2_b4;
		real4 pk_adl_score_mm_b1_c2_b4;
		real4 pk_combo_addrscore_mm_b1_c2_b4;
		real4 pk_combo_hphonescore_mm_b1_c2_b4;
		real4 pk_combo_ssnscore_mm_b1_c2_b4;
		real4 pk_combo_dobscore_mm_b1_c2_b4;
		real4 pk_combo_fnamecount_mm_b1_c2_b4;
		real4 pk_rc_fnamecount_mm_b1_c2_b4;
		real4 pk_combo_lnamecount_mm_b1_c2_b4;
		real4 pk_rc_phonelnamecount_mm_b1_c2_b4;
		real4 pk_rc_addrcount_mm_b1_c2_b4;
		real4 pk_rc_phoneaddr_phonecount_mm_b1_c2_b4;
		real4 pk_ver_phncount_mm_b1_c2_b4;
		real4 pk_combo_ssncount_mm_b1_c2_b4;
		real4 pk_combo_dobcount_mm_b1_c2_b4;
		real4 pk_eq_count_mm_b1_c2_b4;
		real4 pk_pos_secondary_sources_mm_b1_c2_b4;
		real4 pk_voter_flag_mm_b1_c2_b4;
		real4 pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4;
		real4 pk_add1_address_score_mm_b1_c2_b4;
		real4 pk_add2_address_score_mm_b1_c2_b4;
		real4 pk_add2_pos_sources_mm_b1_c2_b4;
		real4 pk_add2_pos_secondary_sources_mm_b1_c2_b4;
		real4 pk_ssnchar_invalid_or_recent_mm_b1_c2_b4;
		real4 pk_infutor_risk_lvl_mm_b1_c2_b4;
		real4 pk_yr_adl_vo_first_seen2_mm_b1_c2_b4;
		real4 pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4;
		real4 pk_yr_lname_change_date2_mm_b1_c2_b4;
		real4 pk_yr_gong_did_first_seen2_mm_b1_c2_b4;
		real4 pk_yr_header_first_seen2_mm_b1_c2_b4;
		real4 pk_yr_infutor_first_seen2_mm_b1_c2_b4;
		real4 pk_em_only_ver_lvl_mm_b1_c2_b4;
		real4 pk_add2_em_ver_lvl_mm_b1_c2_b4;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
		real4 pk_add2_pos_secondary_sources_mm_b1;
		real4 pk_yr_infutor_first_seen2_mm_b1;
		real4 pk_yr_lname_change_date2_mm_b1;
		real4 pk_ssnchar_invalid_or_recent_mm_b1;
		real4 pk_adl_score_mm_b1;
		real4 pk_rc_phonelnamecount_mm_b1;
		real4 pk_rc_dirsaddr_lastscore_mm_b1;
		real4 pk_combo_ssncount_mm_b1;
		real4 pk_yr_adl_vo_first_seen2_mm_b1;
		real4 pk_pos_secondary_sources_mm_b1;
		real4 pk_combo_addrscore_mm_b1;
		real4 pk_voter_flag_mm_b1;
		real4 pk_add2_address_score_mm_b1;
		real4 pk_rc_fnamecount_mm_b1;
		real4 pk_combo_ssnscore_mm_b1;
		real4 pk_lname_eda_sourced_type_lvl_mm_b1;
		real4 pk_combo_dobscore_mm_b1;
		real4 pk_ver_phncount_mm_b1;
		real4 pk_combo_dobcount_mm_b1;
		real4 pk_rc_phoneaddr_phonecount_mm_b1;
		real4 pk_nas_summary_mm_b1;
		real4 pk_rc_addrcount_mm_b1;
		real4 pk_yr_gong_did_first_seen2_mm_b1;
		real4 pk_combo_hphonescore_mm_b1;
		real4 pk_yr_adl_em_only_first_seen2_mm_b1;
		real4 pk_add2_em_ver_lvl_mm_b1;
		real4 pk_combo_lnamecount_mm_b1;
		real4 pk_eq_count_mm_b1;
		real4 pk_yr_header_first_seen2_mm_b1;
		real4 pk_em_only_ver_lvl_mm_b1;
		real4 pk_add1_address_score_mm_b1;
		real4 pk_combo_fnamecount_mm_b1;
		real4 pk_add2_pos_sources_mm_b1;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
		real4 pk_infutor_risk_lvl_mm_b1;
		real4 pk_nas_summary_mm_b2_c2_b1;
		real4 pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
		real4 pk_adl_score_mm_b2_c2_b1;
		real4 pk_combo_addrscore_mm_b2_c2_b1;
		real4 pk_combo_hphonescore_mm_b2_c2_b1;
		real4 pk_combo_ssnscore_mm_b2_c2_b1;
		real4 pk_combo_dobscore_mm_b2_c2_b1;
		real4 pk_combo_fnamecount_nb_mm_b2_c2_b1;
		real4 pk_rc_fnamecount_nb_mm_b2_c2_b1;
		real4 pk_rc_phonelnamecount_mm_b2_c2_b1;
		real4 pk_combo_addrcount_nb_mm_b2_c2_b1;
		real4 pk_rc_addrcount_nb_mm_b2_c2_b1;
		real4 pk_rc_phoneaddr_phonecount_mm_b2_c2_b1;
		real4 pk_ver_phncount_mm_b2_c2_b1;
		real4 pk_combo_ssncount_mm_b2_c2_b1;
		real4 pk_combo_dobcount_nb_mm_b2_c2_b1;
		real4 pk_eq_count_mm_b2_c2_b1;
		real4 pk_pos_secondary_sources_mm_b2_c2_b1;
		real4 pk_voter_flag_mm_b2_c2_b1;
		real4 pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
		real4 pk_add1_address_score_mm_b2_c2_b1;
		real4 pk_add2_address_score_mm_b2_c2_b1;
		real4 pk_add2_pos_sources_mm_b2_c2_b1;
		real4 pk_add2_pos_secondary_sources_mm_b2_c2_b1;
		real4 pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
		real4 pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
		real4 pk_yr_adl_vo_first_seen2_mm_b2_c2_b1;
		real4 pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
		real4 pk_yr_lname_change_date2_mm_b2_c2_b1;
		real4 pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
		real4 pk_yr_header_first_seen2_mm_b2_c2_b1;
		real4 pk_yr_infutor_first_seen2_mm_b2_c2_b1;
		real4 pk_em_only_ver_lvl_mm_b2_c2_b1;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
		real4 pk_nas_summary_mm_b2_c2_b2;
		real4 pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
		real4 pk_adl_score_mm_b2_c2_b2;
		real4 pk_combo_addrscore_mm_b2_c2_b2;
		real4 pk_combo_hphonescore_mm_b2_c2_b2;
		real4 pk_combo_ssnscore_mm_b2_c2_b2;
		real4 pk_combo_dobscore_mm_b2_c2_b2;
		real4 pk_combo_fnamecount_nb_mm_b2_c2_b2;
		real4 pk_rc_fnamecount_nb_mm_b2_c2_b2;
		real4 pk_rc_phonelnamecount_mm_b2_c2_b2;
		real4 pk_combo_addrcount_nb_mm_b2_c2_b2;
		real4 pk_rc_addrcount_nb_mm_b2_c2_b2;
		real4 pk_rc_phoneaddr_phonecount_mm_b2_c2_b2;
		real4 pk_ver_phncount_mm_b2_c2_b2;
		real4 pk_combo_ssncount_mm_b2_c2_b2;
		real4 pk_combo_dobcount_nb_mm_b2_c2_b2;
		real4 pk_eq_count_mm_b2_c2_b2;
		real4 pk_pos_secondary_sources_mm_b2_c2_b2;
		real4 pk_voter_flag_mm_b2_c2_b2;
		real4 pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
		real4 pk_add1_address_score_mm_b2_c2_b2;
		real4 pk_add2_address_score_mm_b2_c2_b2;
		real4 pk_add2_pos_sources_mm_b2_c2_b2;
		real4 pk_add2_pos_secondary_sources_mm_b2_c2_b2;
		real4 pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
		real4 pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
		real4 pk_yr_adl_vo_first_seen2_mm_b2_c2_b2;
		real4 pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
		real4 pk_yr_lname_change_date2_mm_b2_c2_b2;
		real4 pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
		real4 pk_yr_header_first_seen2_mm_b2_c2_b2;
		real4 pk_yr_infutor_first_seen2_mm_b2_c2_b2;
		real4 pk_em_only_ver_lvl_mm_b2_c2_b2;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
		real4 pk_nas_summary_mm_b2_c2_b3;
		real4 pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
		real4 pk_adl_score_mm_b2_c2_b3;
		real4 pk_combo_addrscore_mm_b2_c2_b3;
		real4 pk_combo_hphonescore_mm_b2_c2_b3;
		real4 pk_combo_ssnscore_mm_b2_c2_b3;
		real4 pk_combo_dobscore_mm_b2_c2_b3;
		real4 pk_combo_fnamecount_nb_mm_b2_c2_b3;
		real4 pk_rc_fnamecount_nb_mm_b2_c2_b3;
		real4 pk_rc_phonelnamecount_mm_b2_c2_b3;
		real4 pk_combo_addrcount_nb_mm_b2_c2_b3;
		real4 pk_rc_addrcount_nb_mm_b2_c2_b3;
		real4 pk_rc_phoneaddr_phonecount_mm_b2_c2_b3;
		real4 pk_ver_phncount_mm_b2_c2_b3;
		real4 pk_combo_ssncount_mm_b2_c2_b3;
		real4 pk_combo_dobcount_nb_mm_b2_c2_b3;
		real4 pk_eq_count_mm_b2_c2_b3;
		real4 pk_pos_secondary_sources_mm_b2_c2_b3;
		real4 pk_voter_flag_mm_b2_c2_b3;
		real4 pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
		real4 pk_add1_address_score_mm_b2_c2_b3;
		real4 pk_add2_address_score_mm_b2_c2_b3;
		real4 pk_add2_pos_sources_mm_b2_c2_b3;
		real4 pk_add2_pos_secondary_sources_mm_b2_c2_b3;
		real4 pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
		real4 pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
		real4 pk_yr_adl_vo_first_seen2_mm_b2_c2_b3;
		real4 pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
		real4 pk_yr_lname_change_date2_mm_b2_c2_b3;
		real4 pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
		real4 pk_yr_header_first_seen2_mm_b2_c2_b3;
		real4 pk_yr_infutor_first_seen2_mm_b2_c2_b3;
		real4 pk_em_only_ver_lvl_mm_b2_c2_b3;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
		real4 pk_nas_summary_mm_b2_c2_b4;
		real4 pk_rc_dirsaddr_lastscore_mm_b2_c2_b4;
		real4 pk_adl_score_mm_b2_c2_b4;
		real4 pk_combo_addrscore_mm_b2_c2_b4;
		real4 pk_combo_hphonescore_mm_b2_c2_b4;
		real4 pk_combo_ssnscore_mm_b2_c2_b4;
		real4 pk_combo_dobscore_mm_b2_c2_b4;
		real4 pk_combo_fnamecount_nb_mm_b2_c2_b4;
		real4 pk_rc_fnamecount_nb_mm_b2_c2_b4;
		real4 pk_rc_phonelnamecount_mm_b2_c2_b4;
		real4 pk_combo_addrcount_nb_mm_b2_c2_b4;
		real4 pk_rc_addrcount_nb_mm_b2_c2_b4;
		real4 pk_rc_phoneaddr_phonecount_mm_b2_c2_b4;
		real4 pk_ver_phncount_mm_b2_c2_b4;
		real4 pk_combo_ssncount_mm_b2_c2_b4;
		real4 pk_combo_dobcount_nb_mm_b2_c2_b4;
		real4 pk_eq_count_mm_b2_c2_b4;
		real4 pk_pos_secondary_sources_mm_b2_c2_b4;
		real4 pk_voter_flag_mm_b2_c2_b4;
		real4 pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4;
		real4 pk_add1_address_score_mm_b2_c2_b4;
		real4 pk_add2_address_score_mm_b2_c2_b4;
		real4 pk_add2_pos_sources_mm_b2_c2_b4;
		real4 pk_add2_pos_secondary_sources_mm_b2_c2_b4;
		real4 pk_ssnchar_invalid_or_recent_mm_b2_c2_b4;
		real4 pk_infutor_risk_lvl_nb_mm_b2_c2_b4;
		real4 pk_yr_adl_vo_first_seen2_mm_b2_c2_b4;
		real4 pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4;
		real4 pk_yr_lname_change_date2_mm_b2_c2_b4;
		real4 pk_yr_gong_did_first_seen2_mm_b2_c2_b4;
		real4 pk_yr_header_first_seen2_mm_b2_c2_b4;
		real4 pk_yr_infutor_first_seen2_mm_b2_c2_b4;
		real4 pk_em_only_ver_lvl_mm_b2_c2_b4;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
		real4 pk_add2_pos_secondary_sources_mm_b2;
		real4 pk_yr_infutor_first_seen2_mm_b2;
		real4 pk_yr_lname_change_date2_mm_b2;
		real4 pk_ssnchar_invalid_or_recent_mm_b2;
		real4 pk_rc_fnamecount_nb_mm_b2;
		real4 pk_adl_score_mm_b2;
		real4 pk_combo_dobcount_nb_mm_b2;
		real4 pk_rc_phonelnamecount_mm_b2;
		real4 pk_combo_fnamecount_nb_mm_b2;
		real4 pk_rc_dirsaddr_lastscore_mm_b2;
		real4 pk_combo_ssncount_mm_b2;
		real4 pk_yr_adl_vo_first_seen2_mm_b2;
		real4 pk_pos_secondary_sources_mm_b2;
		real4 pk_combo_addrscore_mm_b2;
		real4 pk_voter_flag_mm_b2;
		real4 pk_add2_address_score_mm_b2;
		real4 pk_combo_ssnscore_mm_b2;
		real4 pk_lname_eda_sourced_type_lvl_mm_b2;
		real4 pk_combo_dobscore_mm_b2;
		real4 pk_ver_phncount_mm_b2;
		real4 pk_rc_phoneaddr_phonecount_mm_b2;
		real4 pk_nas_summary_mm_b2;
		real4 pk_yr_gong_did_first_seen2_mm_b2;
		real4 pk_combo_hphonescore_mm_b2;
		real4 pk_yr_adl_em_only_first_seen2_mm_b2;
		real4 pk_infutor_risk_lvl_nb_mm_b2;
		real4 pk_combo_addrcount_nb_mm_b2;
		real4 pk_eq_count_mm_b2;
		real4 pk_yr_header_first_seen2_mm_b2;
		real4 pk_em_only_ver_lvl_mm_b2;
		real4 pk_add1_address_score_mm_b2;
		real4 pk_rc_addrcount_nb_mm_b2;
		real4 pk_add2_pos_sources_mm_b2;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
		real4 pk_add2_pos_secondary_sources_mm;
		real4 pk_yr_infutor_first_seen2_mm;
		real4 pk_yr_lname_change_date2_mm;
		real4 pk_ssnchar_invalid_or_recent_mm;
		real4 pk_rc_fnamecount_nb_mm;
		real4 pk_adl_score_mm;
		real4 pk_combo_dobcount_nb_mm;
		real4 pk_rc_phonelnamecount_mm;
		real4 pk_combo_fnamecount_nb_mm;
		real4 pk_rc_dirsaddr_lastscore_mm;
		real4 pk_combo_ssncount_mm;
		real4 pk_yr_adl_vo_first_seen2_mm;
		real4 pk_pos_secondary_sources_mm;
		real4 pk_combo_addrscore_mm;
		real4 pk_voter_flag_mm;
		real4 pk_add2_address_score_mm;
		real4 pk_rc_fnamecount_mm;
		real4 pk_combo_ssnscore_mm;
		real4 pk_lname_eda_sourced_type_lvl_mm;
		real4 pk_combo_dobscore_mm;
		real4 pk_ver_phncount_mm;
		real4 pk_combo_dobcount_mm;
		real4 pk_rc_phoneaddr_phonecount_mm;
		real4 pk_nas_summary_mm;
		real4 pk_rc_addrcount_mm;
		real4 pk_yr_gong_did_first_seen2_mm;
		real4 pk_combo_hphonescore_mm;
		real4 pk_yr_adl_em_only_first_seen2_mm;
		real4 pk_infutor_risk_lvl_nb_mm;
		real4 pk_add2_em_ver_lvl_mm;
		real4 pk_combo_lnamecount_mm;
		real4 pk_combo_addrcount_nb_mm;
		real4 pk_eq_count_mm;
		real4 pk_yr_header_first_seen2_mm;
		real4 pk_em_only_ver_lvl_mm;
		real4 pk_add1_address_score_mm;
		real4 pk_combo_fnamecount_mm;
		real4 pk_rc_addrcount_nb_mm;
		real4 pk_add2_pos_sources_mm;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm;
		real4 pk_infutor_risk_lvl_mm;
		real4 pk_estimated_income_mm_b1;
		real4 pk_yr_adl_w_first_seen2_mm_b1;
		real4 pk_yr_adl_w_last_seen2_mm_b1;
		real4 pk_pr_count_mm_b1;
		real4 pk_addrs_sourced_lvl_mm_b1;
		real4 pk_add2_own_level_mm_b1;
		real4 pk_add3_own_level_mm_b1;
		real4 pk_naprop_level2_mm_b1;
		real4 pk_yr_add1_purchase_date2_mm_b1;
		real4 pk_yr_add1_built_date2_mm_b1;
		real4 pk_yr_add1_mortgage_date2_mm_b1;
		real4 pk_add1_mortgage_risk_mm_b1;
		real4 pk_add1_assessed_amount2_mm_b1;
		real4 pk_yr_add1_date_first_seen2_mm_b1;
		real4 pk_add1_building_area2_mm_b1;
		real4 pk_add1_no_of_baths_mm_b1;
		real4 pk_property_owned_total_mm_b1;
		real4 pk_prop_own_assess_tot2_mm_b1;
		real4 pk_prop1_sale_price2_mm_b1;
		real4 pk_add2_land_use_risk_level_mm_b1;
		real4 pk_add2_building_area2_mm_b1;
		real4 pk_add2_no_of_baths_mm_b1;
		real4 pk_yr_add2_mortgage_date2_mm_b1;
		real4 pk_add2_mortgage_risk_mm_b1;
		real4 pk_yr_add2_mortgage_due_date2_mm_b1;
		real4 pk_add2_assessed_amount2_mm_b1;
		real4 pk_yr_add2_date_first_seen2_mm_b1;
		real4 pk_add3_mortgage_risk_mm_b1;
		real4 pk_add3_assessed_amount2_mm_b1;
		real4 pk_yr_add3_date_first_seen2_mm_b1;
		real4 pk_w_count_mm_b1;
		real4 pk_bk_level_mm_b1;
		real4 pk_eviction_level_mm_b1;
		real4 pk_lien_type_level_mm_b1;
		real4 pk_yr_liens_last_unrel_date3_mm_b1;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm_b1;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm_b1;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm_b1;
		real4 pk_yr_criminal_last_date2_mm_b1;
		real4 pk_yr_felony_last_date2_mm_b1;
		real4 pk_attr_total_number_derogs_mm_b1;
		real4 pk_yr_rc_ssnhighissue2_mm_b1;
		real4 pk_pl_sourced_level_mm_b1;
		real4 pk_prof_lic_cat_mm_b1;
		real4 pk_add1_lres_mm_b1;
		real4 pk_add2_lres_mm_b1;
		real4 pk_add3_lres_mm_b1;
		real4 pk_lres_flag_level_mm_b1;
		real4 pk_addrs_5yr_mm_b1;
		real4 pk_addrs_10yr_mm_b1;
		real4 pk_add_lres_month_avg2_mm_b1;
		real4 pk_nameperssn_count_mm_b1;
		real4 pk_ssns_per_adl_mm_b1;
		real4 pk_addrs_per_adl_mm_b1;
		real4 pk_phones_per_adl_mm_b1;
		real4 pk_adlperssn_count_mm_b1;
		real4 pk_adls_per_phone_mm_b1;
		real4 pk_ssns_per_adl_c6_mm_b1;
		real4 pk_ssns_per_addr_c6_mm_b1;
		real4 pk_attr_addrs_last90_mm_b1;
		real4 pk_attr_addrs_last12_mm_b1;
		real4 pk_attr_addrs_last24_mm_b1;
		real4 pk_ams_class_level_mm_b1;
		real4 pk_ams_4yr_college_mm_b1;
		real4 pk_ams_college_type_mm_b1;
		real4 pk_ams_income_level_code_mm_b1;
		real4 pk_yr_in_dob2_mm_b1;
		real4 pk_ams_age_mm_b1;
		real4 pk_inferred_age_mm_b1;
		real4 pk_yr_reported_dob2_mm_b1;
		real4 pk_avm_hit_level_mm_b1;
		real4 pk_avm_auto_diff2_lvl_mm_b1;
		real4 pk_avm_auto_diff4_lvl_mm_b1;
		real4 pk_add2_avm_auto_diff2_lvl_mm_b1;
		real4 pk2_add1_avm_mkt_mm_b1;
		real4 pk2_add1_avm_pi_mm_b1;
		real4 pk2_add1_avm_hed_mm_b1;
		real4 pk2_add1_avm_auto2_mm_b1;
		real4 pk2_add1_avm_auto4_mm_b1;
		real4 pk2_add1_avm_med_mm_b1;
		real4 pk2_add1_avm_to_med_ratio_mm_b1;
		real4 pk2_add2_avm_mkt_mm_b1;
		real4 pk2_add2_avm_pi_mm_b1;
		real4 pk2_add2_avm_hed_mm_b1;
		real4 pk2_add2_avm_auto4_mm_b1;
		real4 pk2_yr_add1_avm_rec_dt_mm_b1;
		real4 pk2_yr_add1_avm_assess_year_mm_b1;
		real4 pk2_yr_add2_avm_assess_year_mm_b1;
		real4 pk_dist_a1toa2_mm_b1;
		real4 pk_dist_a1toa3_mm_b1;
		real4 pk_rc_disthphoneaddr_mm_b1;
		real4 pk_out_st_division_lvl_mm_b1;
		real4 pk_wealth_index_mm_b1;
		real4 pk_impulse_count_mm_b1;
		real4 pk_attr_num_nonderogs90_b_mm_b1;
		real4 pk_ssns_per_addr2_mm_b1;
		real4 pk_yr_prop1_prev_purch_dt2_mm_b1;
		real4 pk_estimated_income_mm_b2;
		real4 pk_yr_adl_w_first_seen2_mm_b2;
		real4 pk_yr_adl_w_last_seen2_mm_b2;
		real4 pk_pr_count_mm_b2;
		real4 pk_addrs_sourced_lvl_mm_b2;
		real4 pk_add2_own_level_mm_b2;
		real4 pk_add3_own_level_mm_b2;
		real4 pk_naprop_level2_mm_b2;
		real4 pk_yr_add1_purchase_date2_mm_b2;
		real4 pk_yr_add1_built_date2_mm_b2;
		real4 pk_yr_add1_mortgage_date2_mm_b2;
		real4 pk_add1_mortgage_risk_mm_b2;
		real4 pk_add1_assessed_amount2_mm_b2;
		real4 pk_yr_add1_date_first_seen2_mm_b2;
		real4 pk_add1_building_area2_mm_b2;
		real4 pk_add1_no_of_baths_mm_b2;
		real4 pk_property_owned_total_mm_b2;
		real4 pk_prop_own_assess_tot2_mm_b2;
		real4 pk_prop1_sale_price2_mm_b2;
		real4 pk_add2_land_use_risk_level_mm_b2;
		real4 pk_add2_building_area2_mm_b2;
		real4 pk_add2_no_of_baths_mm_b2;
		real4 pk_yr_add2_mortgage_date2_mm_b2;
		real4 pk_add2_mortgage_risk_mm_b2;
		real4 pk_yr_add2_mortgage_due_date2_mm_b2;
		real4 pk_add2_assessed_amount2_mm_b2;
		real4 pk_yr_add2_date_first_seen2_mm_b2;
		real4 pk_add3_mortgage_risk_mm_b2;
		real4 pk_add3_assessed_amount2_mm_b2;
		real4 pk_yr_add3_date_first_seen2_mm_b2;
		real4 pk_w_count_mm_b2;
		real4 pk_bk_level_mm_b2;
		real4 pk_eviction_level_mm_b2;
		real4 pk_lien_type_level_mm_b2;
		real4 pk_yr_liens_last_unrel_date3_mm_b2;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm_b2;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm_b2;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm_b2;
		real4 pk_yr_criminal_last_date2_mm_b2;
		real4 pk_yr_felony_last_date2_mm_b2;
		real4 pk_attr_total_number_derogs_mm_b2;
		real4 pk_yr_rc_ssnhighissue2_mm_b2;
		real4 pk_pl_sourced_level_mm_b2;
		real4 pk_prof_lic_cat_mm_b2;
		real4 pk_add1_lres_mm_b2;
		real4 pk_add2_lres_mm_b2;
		real4 pk_add3_lres_mm_b2;
		real4 pk_lres_flag_level_mm_b2;
		real4 pk_addrs_5yr_mm_b2;
		real4 pk_addrs_10yr_mm_b2;
		real4 pk_add_lres_month_avg2_mm_b2;
		real4 pk_nameperssn_count_mm_b2;
		real4 pk_ssns_per_adl_mm_b2;
		real4 pk_addrs_per_adl_mm_b2;
		real4 pk_phones_per_adl_mm_b2;
		real4 pk_adlperssn_count_mm_b2;
		real4 pk_adls_per_phone_mm_b2;
		real4 pk_ssns_per_adl_c6_mm_b2;
		real4 pk_ssns_per_addr_c6_mm_b2;
		real4 pk_attr_addrs_last90_mm_b2;
		real4 pk_attr_addrs_last12_mm_b2;
		real4 pk_attr_addrs_last24_mm_b2;
		real4 pk_ams_class_level_mm_b2;
		real4 pk_ams_4yr_college_mm_b2;
		real4 pk_ams_college_type_mm_b2;
		real4 pk_ams_income_level_code_mm_b2;
		real4 pk_yr_in_dob2_mm_b2;
		real4 pk_ams_age_mm_b2;
		real4 pk_inferred_age_mm_b2;
		real4 pk_yr_reported_dob2_mm_b2;
		real4 pk_avm_hit_level_mm_b2;
		real4 pk_avm_auto_diff2_lvl_mm_b2;
		real4 pk_avm_auto_diff4_lvl_mm_b2;
		real4 pk_add2_avm_auto_diff2_lvl_mm_b2;
		real4 pk2_add1_avm_mkt_mm_b2;
		real4 pk2_add1_avm_pi_mm_b2;
		real4 pk2_add1_avm_hed_mm_b2;
		real4 pk2_add1_avm_auto2_mm_b2;
		real4 pk2_add1_avm_auto4_mm_b2;
		real4 pk2_add1_avm_med_mm_b2;
		real4 pk2_add1_avm_to_med_ratio_mm_b2;
		real4 pk2_add2_avm_mkt_mm_b2;
		real4 pk2_add2_avm_pi_mm_b2;
		real4 pk2_add2_avm_hed_mm_b2;
		real4 pk2_add2_avm_auto4_mm_b2;
		real4 pk2_yr_add1_avm_rec_dt_mm_b2;
		real4 pk2_yr_add1_avm_assess_year_mm_b2;
		real4 pk2_yr_add2_avm_assess_year_mm_b2;
		real4 pk_dist_a1toa2_mm_b2;
		real4 pk_dist_a1toa3_mm_b2;
		real4 pk_rc_disthphoneaddr_mm_b2;
		real4 pk_out_st_division_lvl_mm_b2;
		real4 pk_wealth_index_mm_b2;
		real4 pk_impulse_count_mm_b2;
		real4 pk_attr_num_nonderogs90_b_mm_b2;
		real4 pk_ssns_per_addr2_mm_b2;
		real4 pk_yr_prop1_prev_purch_dt2_mm_b2;
		real4 pk_estimated_income_mm_b3;
		real4 pk_yr_adl_w_first_seen2_mm_b3;
		real4 pk_yr_adl_w_last_seen2_mm_b3;
		real4 pk_pr_count_mm_b3;
		real4 pk_addrs_sourced_lvl_mm_b3;
		real4 pk_add2_own_level_mm_b3;
		real4 pk_add3_own_level_mm_b3;
		real4 pk_naprop_level2_mm_b3;
		real4 pk_yr_add1_purchase_date2_mm_b3;
		real4 pk_yr_add1_built_date2_mm_b3;
		real4 pk_yr_add1_mortgage_date2_mm_b3;
		real4 pk_add1_mortgage_risk_mm_b3;
		real4 pk_add1_assessed_amount2_mm_b3;
		real4 pk_yr_add1_date_first_seen2_mm_b3;
		real4 pk_add1_building_area2_mm_b3;
		real4 pk_add1_no_of_baths_mm_b3;
		real4 pk_property_owned_total_mm_b3;
		real4 pk_prop_own_assess_tot2_mm_b3;
		real4 pk_prop1_sale_price2_mm_b3;
		real4 pk_add2_land_use_risk_level_mm_b3;
		real4 pk_add2_building_area2_mm_b3;
		real4 pk_add2_no_of_baths_mm_b3;
		real4 pk_yr_add2_mortgage_date2_mm_b3;
		real4 pk_add2_mortgage_risk_mm_b3;
		real4 pk_yr_add2_mortgage_due_date2_mm_b3;
		real4 pk_add2_assessed_amount2_mm_b3;
		real4 pk_yr_add2_date_first_seen2_mm_b3;
		real4 pk_add3_mortgage_risk_mm_b3;
		real4 pk_add3_assessed_amount2_mm_b3;
		real4 pk_yr_add3_date_first_seen2_mm_b3;
		real4 pk_w_count_mm_b3;
		real4 pk_bk_level_mm_b3;
		real4 pk_eviction_level_mm_b3;
		real4 pk_lien_type_level_mm_b3;
		real4 pk_yr_liens_last_unrel_date3_mm_b3;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm_b3;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm_b3;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm_b3;
		real4 pk_yr_criminal_last_date2_mm_b3;
		real4 pk_yr_felony_last_date2_mm_b3;
		real4 pk_attr_total_number_derogs_mm_b3;
		real4 pk_yr_rc_ssnhighissue2_mm_b3;
		real4 pk_pl_sourced_level_mm_b3;
		real4 pk_prof_lic_cat_mm_b3;
		real4 pk_add1_lres_mm_b3;
		real4 pk_add2_lres_mm_b3;
		real4 pk_add3_lres_mm_b3;
		real4 pk_lres_flag_level_mm_b3;
		real4 pk_addrs_5yr_mm_b3;
		real4 pk_addrs_10yr_mm_b3;
		real4 pk_add_lres_month_avg2_mm_b3;
		real4 pk_nameperssn_count_mm_b3;
		real4 pk_ssns_per_adl_mm_b3;
		real4 pk_addrs_per_adl_mm_b3;
		real4 pk_phones_per_adl_mm_b3;
		real4 pk_adlperssn_count_mm_b3;
		real4 pk_adls_per_phone_mm_b3;
		real4 pk_ssns_per_adl_c6_mm_b3;
		real4 pk_ssns_per_addr_c6_mm_b3;
		real4 pk_attr_addrs_last90_mm_b3;
		real4 pk_attr_addrs_last12_mm_b3;
		real4 pk_attr_addrs_last24_mm_b3;
		real4 pk_ams_class_level_mm_b3;
		real4 pk_ams_4yr_college_mm_b3;
		real4 pk_ams_college_type_mm_b3;
		real4 pk_ams_income_level_code_mm_b3;
		real4 pk_yr_in_dob2_mm_b3;
		real4 pk_ams_age_mm_b3;
		real4 pk_inferred_age_mm_b3;
		real4 pk_yr_reported_dob2_mm_b3;
		real4 pk_avm_hit_level_mm_b3;
		real4 pk_avm_auto_diff2_lvl_mm_b3;
		real4 pk_avm_auto_diff4_lvl_mm_b3;
		real4 pk_add2_avm_auto_diff2_lvl_mm_b3;
		real4 pk2_add1_avm_mkt_mm_b3;
		real4 pk2_add1_avm_pi_mm_b3;
		real4 pk2_add1_avm_hed_mm_b3;
		real4 pk2_add1_avm_auto2_mm_b3;
		real4 pk2_add1_avm_auto4_mm_b3;
		real4 pk2_add1_avm_med_mm_b3;
		real4 pk2_add1_avm_to_med_ratio_mm_b3;
		real4 pk2_add2_avm_mkt_mm_b3;
		real4 pk2_add2_avm_pi_mm_b3;
		real4 pk2_add2_avm_hed_mm_b3;
		real4 pk2_add2_avm_auto4_mm_b3;
		real4 pk2_yr_add1_avm_rec_dt_mm_b3;
		real4 pk2_yr_add1_avm_assess_year_mm_b3;
		real4 pk2_yr_add2_avm_assess_year_mm_b3;
		real4 pk_dist_a1toa2_mm_b3;
		real4 pk_dist_a1toa3_mm_b3;
		real4 pk_rc_disthphoneaddr_mm_b3;
		real4 pk_out_st_division_lvl_mm_b3;
		real4 pk_wealth_index_mm_b3;
		real4 pk_impulse_count_mm_b3;
		real4 pk_attr_num_nonderogs90_b_mm_b3;
		real4 pk_ssns_per_addr2_mm_b3;
		real4 pk_yr_prop1_prev_purch_dt2_mm_b3;
		real4 pk_estimated_income_mm_b4;
		real4 pk_yr_adl_w_first_seen2_mm_b4;
		real4 pk_yr_adl_w_last_seen2_mm_b4;
		real4 pk_pr_count_mm_b4;
		real4 pk_addrs_sourced_lvl_mm_b4;
		real4 pk_add2_own_level_mm_b4;
		real4 pk_add3_own_level_mm_b4;
		real4 pk_naprop_level2_mm_b4;
		real4 pk_yr_add1_purchase_date2_mm_b4;
		real4 pk_yr_add1_built_date2_mm_b4;
		real4 pk_yr_add1_mortgage_date2_mm_b4;
		real4 pk_add1_mortgage_risk_mm_b4;
		real4 pk_add1_assessed_amount2_mm_b4;
		real4 pk_yr_add1_date_first_seen2_mm_b4;
		real4 pk_add1_building_area2_mm_b4;
		real4 pk_add1_no_of_baths_mm_b4;
		real4 pk_property_owned_total_mm_b4;
		real4 pk_prop_own_assess_tot2_mm_b4;
		real4 pk_prop1_sale_price2_mm_b4;
		real4 pk_add2_land_use_risk_level_mm_b4;
		real4 pk_add2_building_area2_mm_b4;
		real4 pk_add2_no_of_baths_mm_b4;
		real4 pk_yr_add2_mortgage_date2_mm_b4;
		real4 pk_add2_mortgage_risk_mm_b4;
		real4 pk_yr_add2_mortgage_due_date2_mm_b4;
		real4 pk_add2_assessed_amount2_mm_b4;
		real4 pk_yr_add2_date_first_seen2_mm_b4;
		real4 pk_add3_mortgage_risk_mm_b4;
		real4 pk_add3_assessed_amount2_mm_b4;
		real4 pk_yr_add3_date_first_seen2_mm_b4;
		real4 pk_w_count_mm_b4;
		real4 pk_bk_level_mm_b4;
		real4 pk_eviction_level_mm_b4;
		real4 pk_lien_type_level_mm_b4;
		real4 pk_yr_liens_last_unrel_date3_mm_b4;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm_b4;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm_b4;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm_b4;
		real4 pk_yr_criminal_last_date2_mm_b4;
		real4 pk_yr_felony_last_date2_mm_b4;
		real4 pk_attr_total_number_derogs_mm_b4;
		real4 pk_yr_rc_ssnhighissue2_mm_b4;
		real4 pk_pl_sourced_level_mm_b4;
		real4 pk_prof_lic_cat_mm_b4;
		real4 pk_add1_lres_mm_b4;
		real4 pk_add2_lres_mm_b4;
		real4 pk_add3_lres_mm_b4;
		real4 pk_lres_flag_level_mm_b4;
		real4 pk_addrs_5yr_mm_b4;
		real4 pk_addrs_10yr_mm_b4;
		real4 pk_add_lres_month_avg2_mm_b4;
		real4 pk_nameperssn_count_mm_b4;
		real4 pk_ssns_per_adl_mm_b4;
		real4 pk_addrs_per_adl_mm_b4;
		real4 pk_phones_per_adl_mm_b4;
		real4 pk_adlperssn_count_mm_b4;
		real4 pk_adls_per_phone_mm_b4;
		real4 pk_ssns_per_adl_c6_mm_b4;
		real4 pk_ssns_per_addr_c6_mm_b4;
		real4 pk_attr_addrs_last90_mm_b4;
		real4 pk_attr_addrs_last12_mm_b4;
		real4 pk_attr_addrs_last24_mm_b4;
		real4 pk_ams_class_level_mm_b4;
		real4 pk_ams_4yr_college_mm_b4;
		real4 pk_ams_college_type_mm_b4;
		real4 pk_ams_income_level_code_mm_b4;
		real4 pk_yr_in_dob2_mm_b4;
		real4 pk_ams_age_mm_b4;
		real4 pk_inferred_age_mm_b4;
		real4 pk_yr_reported_dob2_mm_b4;
		real4 pk_avm_hit_level_mm_b4;
		real4 pk_avm_auto_diff2_lvl_mm_b4;
		real4 pk_avm_auto_diff4_lvl_mm_b4;
		real4 pk_add2_avm_auto_diff2_lvl_mm_b4;
		real4 pk2_add1_avm_mkt_mm_b4;
		real4 pk2_add1_avm_pi_mm_b4;
		real4 pk2_add1_avm_hed_mm_b4;
		real4 pk2_add1_avm_auto2_mm_b4;
		real4 pk2_add1_avm_auto4_mm_b4;
		real4 pk2_add1_avm_med_mm_b4;
		real4 pk2_add1_avm_to_med_ratio_mm_b4;
		real4 pk2_add2_avm_mkt_mm_b4;
		real4 pk2_add2_avm_pi_mm_b4;
		real4 pk2_add2_avm_hed_mm_b4;
		real4 pk2_add2_avm_auto4_mm_b4;
		real4 pk2_yr_add1_avm_rec_dt_mm_b4;
		real4 pk2_yr_add1_avm_assess_year_mm_b4;
		real4 pk2_yr_add2_avm_assess_year_mm_b4;
		real4 pk_dist_a1toa2_mm_b4;
		real4 pk_dist_a1toa3_mm_b4;
		real4 pk_rc_disthphoneaddr_mm_b4;
		real4 pk_out_st_division_lvl_mm_b4;
		real4 pk_wealth_index_mm_b4;
		real4 pk_impulse_count_mm_b4;
		real4 pk_attr_num_nonderogs90_b_mm_b4;
		real4 pk_ssns_per_addr2_mm_b4;
		real4 pk_yr_prop1_prev_purch_dt2_mm_b4;
		real4 pk_yr_criminal_last_date2_mm;
		real4 pk_prop_own_assess_tot2_mm;
		real4 pk_yr_add1_date_first_seen2_mm;
		real4 pk2_add2_avm_mkt_mm;
		real4 pk_attr_addrs_last90_mm;
		real4 pk_nameperssn_count_mm;
		real4 pk_yr_add2_mortgage_date2_mm;
		real4 pk_adls_per_phone_mm;
		real4 pk_ssns_per_addr2_mm;
		real4 pk_property_owned_total_mm;
		real4 pk_ams_class_level_mm;
		real4 pk_attr_addrs_last12_mm;
		real4 pk_add2_land_use_risk_level_mm;
		real4 pk_yr_add2_date_first_seen2_mm;
		real4 pk_adlperssn_count_mm;
		real4 pk2_add2_avm_hed_mm;
		real4 pk_avm_auto_diff4_lvl_mm;
		real4 pk_ams_college_type_mm;
		real4 pk_w_count_mm;
		real4 pk_yr_add3_date_first_seen2_mm;
		real4 pk_add2_own_level_mm;
		real4 pk_add2_lres_mm;
		real4 pk_addrs_sourced_lvl_mm;
		real4 pk_add_lres_month_avg2_mm;
		real4 pk_rc_disthphoneaddr_mm;
		real4 pk_add1_lres_mm;
		real4 pk_attr_total_number_derogs_mm;
		real4 pk_addrs_per_adl_mm;
		real4 pk_naprop_level2_mm;
		real4 pk2_add1_avm_mkt_mm;
		real4 pk_yr_reported_dob2_mm;
		real4 pk_prop1_sale_price2_mm;
		real4 pk2_add1_avm_auto4_mm;
		real4 pk_ssns_per_adl_mm;
		real4 pk_yr_adl_w_last_seen2_mm;
		real4 pk_add2_no_of_baths_mm;
		real4 pk_ams_income_level_code_mm;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm;
		real4 pk_add1_building_area2_mm;
		real4 pk_pr_count_mm;
		real4 pk_avm_auto_diff2_lvl_mm;
		real4 pk_inferred_age_mm;
		real4 pk2_yr_add1_avm_assess_year_mm;
		real4 pk_add1_no_of_baths_mm;
		real4 pk_out_st_division_lvl_mm;
		real4 pk_yr_rc_ssnhighissue2_mm;
		real4 pk_add2_building_area2_mm;
		real4 pk_phones_per_adl_mm;
		real4 pk2_add1_avm_auto2_mm;
		real4 pk_addrs_10yr_mm;
		real4 pk_ams_4yr_college_mm;
		real4 pk_ssns_per_addr_c6_mm;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm;
		real4 pk2_add1_avm_hed_mm;
		real4 pk2_yr_add1_avm_rec_dt_mm;
		real4 pk_add1_mortgage_risk_mm;
		real4 pk_pl_sourced_level_mm;
		real4 pk_add2_assessed_amount2_mm;
		real4 pk_prof_lic_cat_mm;
		real4 pk_dist_a1toa3_mm;
		real4 pk_eviction_level_mm;
		real4 pk_attr_num_nonderogs90_b_mm;
		real4 pk_add3_own_level_mm;
		real4 pk_ssns_per_adl_c6_mm;
		real4 pk_attr_addrs_last24_mm;
		real4 pk_add2_avm_auto_diff2_lvl_mm;
		real4 pk_add3_mortgage_risk_mm;
		real4 pk2_add1_avm_med_mm;
		real4 pk_impulse_count_mm;
		real4 pk_yr_add2_mortgage_due_date2_mm;
		real4 pk_yr_add1_mortgage_date2_mm;
		real4 pk_yr_in_dob2_mm;
		real4 pk2_yr_add2_avm_assess_year_mm;
		real4 pk_avm_hit_level_mm;
		real4 pk_bk_level_mm;
		real4 pk_wealth_index_mm;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm;
		real4 pk2_add2_avm_pi_mm;
		real4 pk2_add1_avm_to_med_ratio_mm;
		real4 pk_add1_assessed_amount2_mm;
		real4 pk_add3_lres_mm;
		real4 pk_lres_flag_level_mm;
		real4 pk_ams_age_mm;
		real4 pk_estimated_income_mm;
		real4 pk_yr_adl_w_first_seen2_mm;
		real4 pk_add2_mortgage_risk_mm;
		real4 pk_dist_a1toa2_mm;
		real4 pk2_add2_avm_auto4_mm;
		real4 pk_yr_add1_purchase_date2_mm;
		real4 pk_yr_prop1_prev_purch_dt2_mm;
		real4 pk_add3_assessed_amount2_mm;
		real4 pk_yr_add1_built_date2_mm;
		real4 pk_yr_felony_last_date2_mm;
		real4 pk_addrs_5yr_mm;
		real4 pk_lien_type_level_mm;
		real4 pk2_add1_avm_pi_mm;
		real4 pk_yr_liens_last_unrel_date3_mm;
		real4 segment_mean;
		real4 pk_add_lres_month_avg2_mm_2;
		real4 pk_add1_address_score_mm_2;
		real4 pk_add1_assessed_amount2_mm_2;
		real4 pk_add1_building_area2_mm_2;
		real4 pk_add1_lres_mm_2;
		real4 pk_add1_mortgage_risk_mm_2;
		real4 pk_add1_no_of_baths_mm_2;
		real4 pk_add2_address_score_mm_2;
		real4 pk_add2_assessed_amount2_mm_2;
		real4 pk_add2_avm_auto_diff2_lvl_mm_2;
		real4 pk_add2_building_area2_mm_2;
		real4 pk_add2_em_ver_lvl_mm_2;
		real4 pk_add2_land_use_risk_level_mm_2;
		real4 pk_add2_lres_mm_2;
		real4 pk_add2_mortgage_risk_mm_2;
		real4 pk_add2_no_of_baths_mm_2;
		real4 pk_add2_own_level_mm_2;
		real4 pk_add2_pos_secondary_sources_mm_2;
		real4 pk_add2_pos_sources_mm_2;
		real4 pk_add3_assessed_amount2_mm_2;
		real4 pk_add3_lres_mm_2;
		real4 pk_add3_mortgage_risk_mm_2;
		real4 pk_add3_own_level_mm_2;
		real4 pk_addrs_10yr_mm_2;
		real4 pk_addrs_5yr_mm_2;
		real4 pk_addrs_per_adl_mm_2;
		real4 pk_addrs_sourced_lvl_mm_2;
		real4 pk_adl_score_mm_2;
		real4 pk_adlperssn_count_mm_2;
		real4 pk_adls_per_phone_mm_2;
		real4 pk_ams_4yr_college_mm_2;
		real4 pk_ams_age_mm_2;
		real4 pk_ams_class_level_mm_2;
		real4 pk_ams_college_type_mm_2;
		real4 pk_ams_income_level_code_mm_2;
		real4 pk_attr_addrs_last12_mm_2;
		real4 pk_attr_addrs_last24_mm_2;
		real4 pk_attr_addrs_last90_mm_2;
		real4 pk_attr_num_nonderogs90_b_mm_2;
		real4 pk_attr_total_number_derogs_mm_2;
		real4 pk_avm_auto_diff2_lvl_mm_2;
		real4 pk_avm_auto_diff4_lvl_mm_2;
		real4 pk_avm_hit_level_mm_2;
		real4 pk_bk_level_mm_2;
		real4 pk_combo_addrcount_nb_mm_2;
		real4 pk_combo_addrscore_mm_2;
		real4 pk_combo_dobcount_mm_2;
		real4 pk_combo_dobcount_nb_mm_2;
		real4 pk_combo_dobscore_mm_2;
		real4 pk_combo_fnamecount_nb_mm_2;
		real4 pk_combo_hphonescore_mm_2;
		real4 pk_combo_lnamecount_mm_2;
		real4 pk_combo_ssncount_mm_2;
		real4 pk_combo_ssnscore_mm_2;
		real4 pk_dist_a1toa2_mm_2;
		real4 pk_dist_a1toa3_mm_2;
		real4 pk_em_only_ver_lvl_mm_2;
		real4 pk_eq_count_mm_2;
		real4 pk_estimated_income_mm_2;
		real4 pk_eviction_level_mm_2;
		real4 pk_impulse_count_mm_2;
		real4 pk_inferred_age_mm_2;
		real4 pk_infutor_risk_lvl_mm_2;
		real4 pk_infutor_risk_lvl_nb_mm_2;
		real4 pk_lien_type_level_mm_2;
		real4 pk_lname_eda_sourced_type_lvl_mm_2;
		real4 pk_lres_flag_level_mm_2;
		real4 pk_nameperssn_count_mm_2;
		real4 pk_naprop_level2_mm_2;
		real4 pk_nas_summary_mm_2;
		real4 pk_out_st_division_lvl_mm_2;
		real4 pk_phones_per_adl_mm_2;
		real4 pk_pl_sourced_level_mm_2;
		real4 pk_pos_secondary_sources_mm_2;
		real4 pk_pr_count_mm_2;
		real4 pk_prof_lic_cat_mm_2;
		real4 pk_prop_own_assess_tot2_mm_2;
		real4 pk_prop1_sale_price2_mm_2;
		real4 pk_property_owned_total_mm_2;
		real4 pk_rc_addrcount_mm_2;
		real4 pk_rc_addrcount_nb_mm_2;
		real4 pk_rc_dirsaddr_lastscore_mm_2;
		real4 pk_rc_disthphoneaddr_mm_2;
		real4 pk_rc_fnamecount_mm_2;
		real4 pk_rc_fnamecount_nb_mm_2;
		real4 pk_rc_phoneaddr_phonecount_mm_2;
		real4 pk_rc_phonelnamecount_mm_2;
		real4 pk_ssnchar_invalid_or_recent_mm_2;
		real4 pk_ssns_per_addr_c6_mm_2;
		real4 pk_ssns_per_addr2_mm_2;
		real4 pk_ssns_per_adl_c6_mm_2;
		real4 pk_ssns_per_adl_mm_2;
		real4 pk_ver_phncount_mm_2;
		real4 pk_voter_flag_mm_2;
		real4 pk_w_count_mm_2;
		real4 pk_wealth_index_mm_2;
		real4 pk_yr_add1_built_date2_mm_2;
		real4 pk_yr_add1_date_first_seen2_mm_2;
		real4 pk_yr_add1_mortgage_date2_mm_2;
		real4 pk_yr_add1_purchase_date2_mm_2;
		real4 pk_yr_add2_date_first_seen2_mm_2;
		real4 pk_yr_add2_mortgage_date2_mm_2;
		real4 pk_yr_add2_mortgage_due_date2_mm_2;
		real4 pk_yr_add3_date_first_seen2_mm_2;
		real4 pk_yr_adl_em_only_first_seen2_mm_2;
		real4 pk_yr_adl_vo_first_seen2_mm_2;
		real4 pk_yr_adl_w_first_seen2_mm_2;
		real4 pk_yr_adl_w_last_seen2_mm_2;
		real4 pk_yr_criminal_last_date2_mm_2;
		real4 pk_yr_felony_last_date2_mm_2;
		real4 pk_yr_gong_did_first_seen2_mm_2;
		real4 pk_yr_header_first_seen2_mm_2;
		real4 pk_yr_in_dob2_mm_2;
		real4 pk_yr_infutor_first_seen2_mm_2;
		real4 pk_yr_liens_last_unrel_date3_mm_2;
		real4 pk_yr_ln_unrel_cj_f_sn2_mm_2;
		real4 pk_yr_ln_unrel_lt_f_sn2_mm_2;
		real4 pk_yr_ln_unrel_ot_f_sn2_mm_2;
		real4 pk_yr_lname_change_date2_mm_2;
		real4 pk_yr_prop1_prev_purch_dt2_mm_2;
		real4 pk_yr_rc_ssnhighissue2_mm_2;
		real4 pk_yr_reported_dob2_mm_2;
		real4 pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
		real4 pk2_add1_avm_auto2_mm_2;
		real4 pk2_add1_avm_auto4_mm_2;
		real4 pk2_add1_avm_hed_mm_2;
		real4 pk2_add1_avm_med_mm_2;
		real4 pk2_add1_avm_mkt_mm_2;
		real4 pk2_add1_avm_pi_mm_2;
		real4 pk2_add1_avm_to_med_ratio_mm_2;
		real4 pk2_add2_avm_auto4_mm_2;
		real4 pk2_add2_avm_hed_mm_2;
		real4 pk2_add2_avm_mkt_mm_2;
		real4 pk2_add2_avm_pi_mm_2;
		real4 pk2_yr_add1_avm_assess_year_mm_2;
		real4 pk2_yr_add1_avm_rec_dt_mm_2;
		real4 pk2_yr_add2_avm_assess_year_mm_2;
		real4 addprob3_mod_dm_b1;
		real4 phnprob_mod_dm_b1;
		real4 ssnprob2_mod_dm_b1;
		real4 fp_mod5_dm_b1;
		real4 age_mod3_dm_b1;
		real4 age_mod3_nodob_dm_b1;
		real4 amstudent_mod_dm_b1;
		real4 avm_mod_dm_b1;
		real4 derog_mod3_dm_b1;
		real4 distance_mod2_dm_b1;
		real4 lien_mod_dm_b1;
		real4 lres_mod_dm_b1;
		real4 proflic_mod_dm_b1;
		real4 property_mod_dm_b1;
		real4 velocity2_mod_dm_b1;
		real4 ver_best_score_mod_dm_b1;
		real4 ver_best_element_cnt_mod_dm_b1;
		real4 ver_best_src_cnt_mod_dm_b1;
		real4 ver_best_src_time_mod_dm_b1;
		real4 ver_notbest_element_cnt_mod_dm_b1;
		real4 ver_notbest_score_mod_dm_b1;
		real4 ver_notbest_src_cnt_mod_dm_b1;
		real4 ver_notbest_src_time_mod_dm_b1;
		real4 ver_element_cnt_mod_dm_b1;
		real4 ver_src_cnt_mod_dm_b1;
		real4 ver_score_mod_dm_b1;
		real4 ver_src_time_mod_dm_b1;
		real4 mod14_dm_b1;
		real4 addprob3_mod_om_b2;
		real4 phnprob_mod_om_b2;
		real4 ssnprob2_mod_om_b2;
		real4 fp_mod5_om_b2;
		real4 age_mod3_nodob_om_b2;
		real4 age_mod3_om_b2;
		real4 amstudent_mod_om_b2;
		real4 avm_mod_om_b2;
		real4 distance_mod2_om_b2;
		real4 lien_mod_om_b2;
		real4 lres_mod_om_b2;
		real4 proflic_mod_om_b2;
		real4 property_mod_om_b2;
		real4 velocity2_mod_om_b2;
		real4 ver_best_element_cnt_mod_om_b2;
		real4 ver_best_score_mod_om_b2;
		real4 ver_best_src_cnt_mod_om_b2;
		real4 ver_best_src_time_mod_om_b2;
		real4 ver_notbest_element_cnt_mod_om_b2;
		real4 ver_notbest_score_mod_om_b2;
		real4 ver_notbest_src_cnt_mod_om_b2;
		real4 ver_notbest_src_time_mod_om_b2;
		real4 ver_src_time_mod_om_b2;
		real4 ver_element_cnt_mod_om_b2;
		real4 ver_score_mod_om_b2;
		real4 ver_src_cnt_mod_om_b2;
		real4 mod14_om_b2;
		real4 addprob3_mod_rm_b3;
		real4 phnprob_mod_rm_b3;
		real4 ssnprob2_mod_rm_b3;
		real4 fp_mod5_rm_b3;
		real4 age_mod3_nodob_rm_b3;
		real4 age_mod3_rm_b3;
		real4 amstudent_mod_rm_b3;
		real4 avm_mod_rm_b3;
		real4 distance_mod2_rm_b3;
		real4 lres_mod_rm_b3;
		real4 property_mod_rm_b3;
		real4 velocity2_mod_rm_b3;
		real4 ver_best_element_cnt_mod_rm_b3;
		real4 ver_best_score_mod_rm_b3;
		real4 ver_best_src_cnt_mod_rm_b3;
		real4 ver_best_src_time_mod_rm_b3;
		real4 ver_notbest_element_cnt_mod_rm_b3;
		real4 ver_notbest_score_mod_rm_b3;
		real4 ver_notbest_src_cnt_mod_rm_b3;
		real4 ver_notbest_src_time_mod_rm_b3;
		real4 ver_score_mod_rm_b3;
		real4 ver_element_cnt_mod_rm_b3;
		real4 ver_src_time_mod_rm_b3;
		real4 ver_src_cnt_mod_rm_b3;
		real4 mod14_rm_b3;
		real4 addprob3_mod_xm_b4;
		real4 phnprob_mod_xm_b4;
		real4 ssnprob2_mod_xm_b4;
		real4 fp_mod5_xm_b4;
		real4 age_mod3_nodob_xm_b4;
		real4 age_mod3_xm_b4;
		real4 amstudent_mod_xm_b4;
		real4 avm_mod_xm_b4;
		real4 distance_mod2_xm_b4;
		real4 lres_mod_xm_b4;
		real4 property_mod_xm_b4;
		real4 velocity2_mod_xm_b4;
		real4 ver_best_element_cnt_mod_xm_b4;
		real4 ver_best_score_mod_xm_b4;
		real4 ver_best_src_cnt_mod_xm_b4;
		real4 ver_best_src_time_mod_xm_b4;
		real4 ver_notbest_element_cnt_mod_xm_b4;
		real4 ver_notbest_score_mod_xm_b4;
		real4 ver_notbest_src_cnt_mod_xm_b4;
		real4 ver_notbest_src_time_mod_xm_b4;
		real4 ver_element_cnt_mod_xm_b4;
		real4 ver_score_mod_xm_b4;
		real4 ver_src_time_mod_xm_b4;
		real4 ver_src_cnt_mod_xm_b4;
		real4 mod14_xm_b4;
		real4 ver_best_element_cnt_mod_om;
		real4 distance_mod2_om;
		real4 velocity2_mod_rm;
		real4 lien_mod_dm;
		real4 phat;
		real4 addprob3_mod_dm;
		real4 proflic_mod_om;
		real4 age_mod3_nodob_xm;
		real4 ver_best_score_mod_dm;
		real4 avm_mod_om;
		real4 ver_best_src_time_mod_dm;
		real4 fp_mod5_dm;
		real4 property_mod_xm;
		real4 velocity2_mod_dm;
		real4 age_mod3_dm;
		real4 ver_best_score_mod_xm;
		real4 ver_notbest_element_cnt_mod_rm;
		real4 lien_mod_om;
		real4 age_mod3_rm;
		real4 ver_notbest_src_time_mod_dm;
		real4 property_mod_rm;
		real4 addprob3_mod_rm;
		real4 age_mod3_nodob_om;
		real4 velocity2_mod_om;
		real4 ver_element_cnt_mod_rm;
		real4 ver_src_time_mod_rm;
		real4 property_mod_dm;
		real4 ver_notbest_src_cnt_mod_xm;
		real4 ssnprob2_mod_om;
		real4 ver_best_src_time_mod_om;
		real4 ver_best_src_cnt_mod_xm;
		real4 avm_mod_rm;
		real4 amstudent_mod_rm;
		real4 age_mod3_xm;
		real4 velocity2_mod_xm;
		real4 ssnprob2_mod_rm;
		real4 ver_src_time_mod_dm;
		real4 lres_mod_om;
		real4 avm_mod_dm;
		real4 ver_best_src_cnt_mod_rm;
		real4 ver_element_cnt_mod_xm;
		real4 ssnprob2_mod_xm;
		real4 lres_mod_rm;
		real4 ver_score_mod_xm;
		real4 distance_mod2_rm;
		real4 proflic_mod_dm;
		real4 ver_notbest_src_time_mod_rm;
		real4 ver_best_src_cnt_mod_om;
		real4 addprob3_mod_xm;
		real4 age_mod3_nodob_rm;
		real4 phnprob_mod_rm;
		real4 ver_src_cnt_mod_dm;
		real4 ver_best_element_cnt_mod_rm;
		real4 ssnprob2_mod_dm;
		real4 derog_mod3_dm;
		real4 ver_best_score_mod_rm;
		real4 amstudent_mod_om;
		real4 ver_src_time_mod_om;
		real4 ver_notbest_score_mod_dm;
		real4 mod14_om;
		real4 mod14_xm;
		real4 ver_notbest_src_cnt_mod_rm;
		real4 ver_notbest_src_cnt_mod_om;
		real4 fp_mod5_om;
		real4 distance_mod2_dm;
		real4 ver_notbest_element_cnt_mod_dm;
		real4 ver_best_src_cnt_mod_dm;
		real4 ver_src_cnt_mod_xm;
		real4 age_mod3_nodob_dm;
		real4 ver_notbest_src_time_mod_xm;
		real4 ver_notbest_score_mod_xm;
		real4 addprob3_mod_om;
		real4 fp_mod5_rm;
		real4 ver_notbest_element_cnt_mod_xm;
		real4 ver_score_mod_dm;
		real4 ver_best_score_mod_om;
		real4 amstudent_mod_dm;
		real4 ver_notbest_src_time_mod_om;
		real4 mod14_rm;
		real4 ver_best_src_time_mod_xm;
		real4 ver_src_cnt_mod_om;
		real4 amstudent_mod_xm;
		real4 avm_mod_xm;
		real4 ver_score_mod_rm;
		real4 distance_mod2_xm;
		real4 ver_notbest_element_cnt_mod_om;
		real4 fp_mod5_xm;
		real4 age_mod3_om;
		real4 ver_src_cnt_mod_rm;
		real4 phnprob_mod_dm;
		real4 phnprob_mod_xm;
		real4 ver_notbest_score_mod_rm;
		real mod14_scr;
		real4 ver_notbest_score_mod_om;
		real4 ver_best_element_cnt_mod_dm;
		real4 ver_best_src_time_mod_rm;
		real4 ver_element_cnt_mod_dm;
		real4 lres_mod_dm;
		real4 ver_element_cnt_mod_om;
		real4 mod14_dm;
		real4 phnprob_mod_om;
		real4 ver_notbest_src_cnt_mod_dm;
		real4 ver_score_mod_om;
		real4 ver_src_time_mod_xm;
		real4 property_mod_om;
		real4 ver_best_element_cnt_mod_xm;
		real4 lres_mod_xm;
		real4 ssnprob2_mod_dm_nodob_b1_c2_b1;
		real4 fp_mod5_dm_nodob_b1_c2_b1;
		real4 ver_best_e_cnt_mod_dm_nodob_b1_c2_b1;
		real4 ver_best_score_mod_dm_nodob_b1_c2_b1;
		real4 ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1;
		real4 ver_notbest_score_mod_dm_nodob_b1_c2_b1;
		real4 ver_score_mod_dm_nodob_b1_c2_b1;
		real4 ver_element_cnt_mod_dm_nodob_b1_c2_b1;
		real4 mod14_dm_nodob_b1_c2_b1;
		real4 ssnprob2_mod_om_nodob_b1_c2_b2;
		real4 fp_mod5_om_nodob_b1_c2_b2;
		real4 ver_best_e_cnt_mod_om_nodob_b1_c2_b2;
		real4 ver_best_score_mod_om_nodob_b1_c2_b2;
		real4 ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2;
		real4 ver_notbest_score_mod_om_nodob_b1_c2_b2;
		real4 ver_element_cnt_mod_om_nodob_b1_c2_b2;
		real4 ver_score_mod_om_nodob_b1_c2_b2;
		real4 mod14_om_nodob_b1_c2_b2;
		real4 ssnprob2_mod_rm_nodob_b1_c2_b3;
		real4 fp_mod5_rm_nodob_b1_c2_b3;
		real4 ver_best_e_cnt_mod_rm_nodob_b1_c2_b3;
		real4 ver_best_score_mod_rm_nodob_b1_c2_b3;
		real4 ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3;
		real4 ver_notbest_score_mod_rm_nodob_b1_c2_b3;
		real4 ver_element_cnt_mod_rm_nodob_b1_c2_b3;
		real4 ver_score_mod_rm_nodob_b1_c2_b3;
		real4 mod14_rm_nodob_b1_c2_b3;
		real4 ssnprob2_mod_xm_nodob_b1_c2_b4;
		real4 fp_mod5_xm_nodob_b1_c2_b4;
		real4 ver_best_e_cnt_mod_xm_nodob_b1_c2_b4;
		real4 ver_best_score_mod_xm_nodob_b1_c2_b4;
		real4 ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4;
		real4 ver_notbest_score_mod_xm_nodob_b1_c2_b4;
		real4 ver_element_cnt_mod_xm_nodob_b1_c2_b4;
		real4 ver_score_mod_xm_nodob_b1_c2_b4;
		real4 mod14_xm_nodob_b1_c2_b4;
		real4 fp_mod5_rm_nodob_b1;
		real4 ssnprob2_mod_om_nodob_b1;
		real4 mod14_om_nodob_b1;
		real4 mod14_dm_nodob_b1;
		real4 ssnprob2_mod_dm_nodob_b1;
		real4 ver_notbest_score_mod_om_nodob_b1;
		real4 phat_b1;
		real4 ver_element_cnt_mod_dm_nodob_b1;
		real4 ver_best_e_cnt_mod_om_nodob_b1;
		real4 ver_best_score_mod_dm_nodob_b1;
		real4 ver_notbest_e_cnt_mod_rm_nodob_b1;
		real4 ver_best_e_cnt_mod_rm_nodob_b1;
		real4 ssnprob2_mod_rm_nodob_b1;
		real4 ver_notbest_e_cnt_mod_om_nodob_b1;
		real4 ssnprob2_mod_xm_nodob_b1;
		real4 ver_notbest_score_mod_rm_nodob_b1;
		real4 ver_score_mod_xm_nodob_b1;
		real4 ver_best_e_cnt_mod_xm_nodob_b1;
		real4 ver_best_e_cnt_mod_dm_nodob_b1;
		real4 fp_mod5_om_nodob_b1;
		real4 ver_element_cnt_mod_xm_nodob_b1;
		real4 ver_notbest_e_cnt_mod_xm_nodob_b1;
		real4 ver_best_score_mod_om_nodob_b1;
		real4 ver_best_score_mod_rm_nodob_b1;
		real4 mod14_xm_nodob_b1;
		real4 ver_element_cnt_mod_rm_nodob_b1;
		real4 ver_notbest_score_mod_xm_nodob_b1;
		real4 ver_score_mod_dm_nodob_b1;
		real mod14_scr_b1;
		real4 ver_score_mod_om_nodob_b1;
		real4 ver_notbest_score_mod_dm_nodob_b1;
		real4 ver_score_mod_rm_nodob_b1;
		real4 ver_best_score_mod_xm_nodob_b1;
		real4 fp_mod5_xm_nodob_b1;
		real4 ver_element_cnt_mod_om_nodob_b1;
		real4 mod14_rm_nodob_b1;
		real4 fp_mod5_dm_nodob_b1;
		real4 ver_notbest_e_cnt_mod_dm_nodob_b1;
		real4 fp_mod5_rm_nodob;
		real4 ssnprob2_mod_om_nodob;
		real4 mod14_om_nodob;
		real4 mod14_dm_nodob;
		real4 ssnprob2_mod_dm_nodob;
		real4 ver_notbest_score_mod_om_nodob;
		real4 phat_2;
		real4 ver_element_cnt_mod_dm_nodob;
		real4 ver_best_e_cnt_mod_om_nodob;
		real4 ver_best_score_mod_dm_nodob;
		real4 ver_notbest_e_cnt_mod_rm_nodob;
		real4 ver_best_e_cnt_mod_rm_nodob;
		real4 ssnprob2_mod_rm_nodob;
		real4 ver_notbest_e_cnt_mod_om_nodob;
		real4 ssnprob2_mod_xm_nodob;
		real4 ver_notbest_score_mod_rm_nodob;
		real4 ver_score_mod_xm_nodob;
		real4 ver_best_e_cnt_mod_xm_nodob;
		real4 ver_best_e_cnt_mod_dm_nodob;
		real4 fp_mod5_om_nodob;
		real4 ver_element_cnt_mod_xm_nodob;
		real4 ver_notbest_e_cnt_mod_xm_nodob;
		real4 ver_best_score_mod_om_nodob;
		real4 ver_best_score_mod_rm_nodob;
		real4 mod14_xm_nodob;
		real4 ver_element_cnt_mod_rm_nodob;
		real4 ver_notbest_score_mod_xm_nodob;
		real4 ver_score_mod_dm_nodob;
		Integer4 mod14_scr_2;
		real4 ver_score_mod_om_nodob;
		real4 ver_notbest_score_mod_dm_nodob;
		real4 ver_score_mod_rm_nodob;
		real4 ver_best_score_mod_xm_nodob;
		real4 fp_mod5_xm_nodob;
		real4 ver_element_cnt_mod_om_nodob;
		real4 mod14_rm_nodob;
		real4 fp_mod5_dm_nodob;
		real4 ver_notbest_e_cnt_mod_dm_nodob;
		Integer4 RVR1003;
		Boolean scored_222s;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		
		integer mod14_scr_rounded;
		integer mod14_scr_b1_rounded;

		Integer4 rvr1003_2;
	END;

	Layout_Debug doModel( clam le ) := TRANSFORM
	#else
	Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end
	
		did                              := le.did;
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
		nap_status                       := le.iid.nap_status;
		did_count                        := le.iid.didcount;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnhighissue                  := le.iid.soclhighissue;
		rc_areacodesplitflag             := le.iid.areacodesplitflag;
		rc_areacodesplitdate             := le.iid.areacodesplitdate;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_fnamecount                    := le.iid.firstcount;
		rc_addrcount                     := le.iid.addrcount;
		rc_phonelnamecount               := le.iid.phonelastcount;
		rc_phoneaddr_phonecount          := le.iid.phoneaddr_phonecount;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_ziptypeflag                   := le.iid.ziptypeflag;
		rc_statezipflag                  := le.iid.statezipflag;
		rc_cityzipflag                   := le.iid.cityzipflag;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_fnamescore                 := le.iid.combo_firstscore;
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
		w_count                          := le.source_verification.w_count;
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
		dobpop                           := le.input_validation.dateofbirth;
		adl_score                        := le.name_verification.adl_score;
		fname_score                      := le.name_verification.fname_score;
		lname_change_date                := le.name_verification.lname_change_date;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		age                              := le.name_verification.age;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		// add1_lres                        := le.address_verification.input_address_information.lres;
		add1_lres                        := le.lres;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
		add1_avm_assessed_value_year     := le.avm.input_address_information.avm_assessed_value_year;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
		add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
		add1_avm_automated_valuation     := (integer4)le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := (integer4)le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_automated_valuation_4   := (integer4)le.avm.input_address_information.avm_automated_valuation4;
		add1_avm_med_fips                := (integer4)le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := (integer4)le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := (integer4)le.avm.input_address_information.avm_median_geo12_level;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_purchase_date               := le.address_verification.input_address_information.purchase_date;
		add1_built_date                  := le.address_verification.input_address_information.built_date;
		add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := le.address_verification.input_address_information.building_area;
		add1_no_of_baths                 := le.address_verification.input_address_information.no_of_baths;
		add1_no_of_partial_baths         := le.address_verification.input_address_information.no_of_partial_baths;
		// add1_pop                         := le.address_verification.input_address_information.addrpop;
		add1_pop                         := (integer)le.addrpop; // copied from Models.RSN807_0_0
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
		prop1_prev_purchase_date         := le.address_verification.recent_property_sales.prev_purch_date1;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_address_score               := le.address_verification.address_history_1.address_score;
		add2_lres                        := le.lres2;
		add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
		add2_avm_assessed_value_year     := le.avm.address_history_1.avm_assessed_value_year;
		add2_avm_market_total_value      := le.avm.address_history_1.avm_market_total_value;
		add2_avm_price_index_valuation   := le.avm.address_history_1.avm_price_index_valuation;
		add2_avm_hedonic_valuation       := le.avm.address_history_1.avm_hedonic_valuation;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
		add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
		add2_sources                     := le.address_verification.address_history_1.sources;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add2_land_use_code               := le.address_verification.address_history_1.standardized_land_use_code;
		add2_building_area               := le.address_verification.address_history_1.building_area;
		add2_no_of_baths                 := le.address_verification.address_history_1.no_of_baths;
		add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
		add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		// add2_pop                         := le.address_verification.address_history_1.addrpop;
		add2_pop                         := le.addrpop2;
		add3_lres                        := le.lres3;
		add3_sources                     := le.address_verification.address_history_2.sources;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
		add3_financing_type              := le.address_verification.address_history_2.type_financing;
		add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		add3_pop                         := le.addrpop3;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_prison_history             := le.other_address_info.isprison;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		header_first_seen                := le.ssn_verification.header_first_seen;
		inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		// adlperssn_count                  := le.velocity_counters.adlperssn_count;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		// attr_addrs_last90                := le.attributes.addrs_last90;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
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
		attr_num_proflic30               := le.professional_license.proflic_count30;
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
		liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
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
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_last_date                 := le.bjl.last_felony_date;
		ams_age                          := le.student.age;
		ams_class                        := le.student.class;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		archive_date                     := if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);
		today                            := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

		ssnlength                        := le.input_validation.ssn_length;
		rc_hrisksic                      := le.iid.hrisksic;






		NULL := -999999999;


		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		// # warning:  engineer intervention needed -- function today not implemented
		sysdate :=  __common__(map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => today,
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL));

		// # warning:  engineer intervention needed -- function today not implemented
		sysyear :=  __common__(map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => year(today),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (real)(trim((string)archive_date, LEFT))[1..4],
																			   NULL));

		in_dob2 :=  __common__(map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim(in_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[7..8]))) - 1)),
						(length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
						(length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																															NULL));

		years_in_dob :=  __common__(if((sysdate != NULL) and (in_dob2 != NULL), ((sysdate - in_dob2) / 365.25), NULL));

		rc_ssnhighissue2 :=  __common__(map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)rc_ssnhighissue, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8]))) - 1)),
								 (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_ssnhighissue, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								 (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_ssnhighissue, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																									   NULL));

		years_rc_ssnhighissue :=  __common__(if((sysdate != NULL) and (rc_ssnhighissue2 != NULL), ((sysdate - rc_ssnhighissue2) / 365.25), NULL));

		rc_areacodesplitdate2 :=  __common__(map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8]))) - 1)),
									  (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									  (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																													  NULL));

		years_rc_areacodesplitdate :=  __common__(if((sysdate != NULL) and (rc_areacodesplitdate2 != NULL), ((sysdate - rc_areacodesplitdate2) / 365.25), NULL));

		months_rc_areacodesplitdate :=  __common__(if((sysdate != NULL) and (rc_areacodesplitdate2 != NULL), ((sysdate - rc_areacodesplitdate2) / 30.5), NULL));

		adl_eq_first_seen2 :=  __common__(map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_eq_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_eq_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_eq_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_adl_eq_first_seen :=  __common__(if((sysdate != NULL) and (adl_eq_first_seen2 != NULL), ((sysdate - adl_eq_first_seen2) / 365.25), NULL));

		months_adl_eq_first_seen :=  __common__(if((sysdate != NULL) and (adl_eq_first_seen2 != NULL), ((sysdate - adl_eq_first_seen2) / 30.5), NULL));

		adl_en_first_seen2 :=  __common__(map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_en_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_en_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_en_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_adl_en_first_seen :=  __common__(if((sysdate != NULL) and (adl_en_first_seen2 != NULL), ((sysdate - adl_en_first_seen2) / 365.25), NULL));

		months_adl_en_first_seen :=  __common__(if((sysdate != NULL) and (adl_en_first_seen2 != NULL), ((sysdate - adl_en_first_seen2) / 30.5), NULL));

		adl_pr_first_seen2 :=  __common__(map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_pr_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_pr_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_pr_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_adl_pr_first_seen :=  __common__(if((sysdate != NULL) and (adl_pr_first_seen2 != NULL), ((sysdate - adl_pr_first_seen2) / 365.25), NULL));

		months_adl_pr_first_seen :=  __common__(if((sysdate != NULL) and (adl_pr_first_seen2 != NULL), ((sysdate - adl_pr_first_seen2) / 30.5), NULL));

		adl_em_first_seen2 :=  __common__(map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_em_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_adl_em_first_seen :=  __common__(if((sysdate != NULL) and (adl_em_first_seen2 != NULL), ((sysdate - adl_em_first_seen2) / 365.25), NULL));

		months_adl_em_first_seen :=  __common__(if((sysdate != NULL) and (adl_em_first_seen2 != NULL), ((sysdate - adl_em_first_seen2) / 30.5), NULL));

		adl_vo_first_seen2 :=  __common__(map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_vo_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_vo_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_vo_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_adl_vo_first_seen :=  __common__(if((sysdate != NULL) and (adl_vo_first_seen2 != NULL), ((sysdate - adl_vo_first_seen2) / 365.25), NULL));

		months_adl_vo_first_seen :=  __common__(if((sysdate != NULL) and (adl_vo_first_seen2 != NULL), ((sysdate - adl_vo_first_seen2) / 30.5), NULL));

		adl_em_only_first_seen2 :=  __common__(map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8]))) - 1)),
										(length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										(length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																															NULL));

		years_adl_em_only_first_seen :=  __common__(if((sysdate != NULL) and (adl_em_only_first_seen2 != NULL), ((sysdate - adl_em_only_first_seen2) / 365.25), NULL));

		months_adl_em_only_first_seen :=  __common__(if((sysdate != NULL) and (adl_em_only_first_seen2 != NULL), ((sysdate - adl_em_only_first_seen2) / 30.5), NULL));

		adl_w_first_seen2 :=  __common__(map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_w_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8]))) - 1)),
								  (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								  (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																										  NULL));

		years_adl_w_first_seen :=  __common__(if((sysdate != NULL) and (adl_w_first_seen2 != NULL), ((sysdate - adl_w_first_seen2) / 365.25), NULL));

		months_adl_w_first_seen :=  __common__(if((sysdate != NULL) and (adl_w_first_seen2 != NULL), ((sysdate - adl_w_first_seen2) / 30.5), NULL));

		adl_w_last_seen2 :=  __common__(map((length(trim((string)adl_w_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)adl_w_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[7..8]))) - 1)),
								 (length(trim((string)adl_w_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								 (length(trim((string)adl_w_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																									   NULL));

		years_adl_w_last_seen :=  __common__(if((sysdate != NULL) and (adl_w_last_seen2 != NULL), ((sysdate - adl_w_last_seen2) / 365.25), NULL));

		lname_change_date2 :=  __common__(map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)lname_change_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8]))) - 1)),
								   (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)lname_change_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)lname_change_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_lname_change_date :=  __common__(if((sysdate != NULL) and (lname_change_date2 != NULL), ((sysdate - lname_change_date2) / 365.25), NULL));

		add1_avm_recording_date2 :=  __common__(map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim(add1_avm_recording_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8]))) - 1)),
										 (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_recording_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										 (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_recording_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											   NULL));

		years_add1_avm_recording_date :=  __common__(if((sysdate != NULL) and (add1_avm_recording_date2 != NULL), ((sysdate - add1_avm_recording_date2) / 365.25), NULL));

		add1_avm_assessed_value_year2 :=  __common__(map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8]))) - 1)),
											  (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
											  (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																															  NULL));

		years_add1_avm_assess_year :=  __common__(if((sysdate != NULL) and (add1_avm_assessed_value_year2 != NULL), ((sysdate - add1_avm_assessed_value_year2) / 365.25), NULL));

		add1_purchase_date2 :=  __common__(map((length(trim((string)add1_purchase_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_purchase_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add1_purchase_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_purchase_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_purchase_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add1_purchase_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_purchase_date, LEFT))[7..8]))) - 1)),
									(length(trim((string)add1_purchase_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_purchase_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_purchase_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_purchase_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_purchase_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									(length(trim((string)add1_purchase_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_purchase_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_purchase_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												NULL));

		years_add1_purchase_date :=  __common__(if((sysdate != NULL) and (add1_purchase_date2 != NULL), ((sysdate - add1_purchase_date2) / 365.25), NULL));

		add1_built_date2 :=  __common__(map((length(trim((string)add1_built_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_built_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add1_built_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_built_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_built_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add1_built_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_built_date, LEFT))[7..8]))) - 1)),
								 (length(trim((string)add1_built_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_built_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_built_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_built_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_built_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								 (length(trim((string)add1_built_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_built_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_built_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																									   NULL));

		years_add1_built_date :=  __common__(if((sysdate != NULL) and (add1_built_date2 != NULL), ((sysdate - add1_built_date2) / 365.25), NULL));

		add1_mortgage_date2 :=  __common__(map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add1_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8]))) - 1)),
									(length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									(length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_mortgage_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												NULL));

		years_add1_mortgage_date :=  __common__(if((sysdate != NULL) and (add1_mortgage_date2 != NULL), ((sysdate - add1_mortgage_date2) / 365.25), NULL));

		add1_date_first_seen2 :=  __common__(map((length(trim((string)add1_date_first_seen)) = 8) and (trim((string)add1_date_first_seen)[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add1_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8]))) - 1)),
									  (length(trim((string)add1_date_first_seen)) = 6) and (trim((string)add1_date_first_seen)[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									  (length(trim((string)add1_date_first_seen)) = 4) and (trim((string)add1_date_first_seen)[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																													  NULL));

		years_add1_date_first_seen :=  __common__(if((sysdate != NULL) and (add1_date_first_seen2 != NULL), ((sysdate - add1_date_first_seen2) / 365.25), NULL));

		months_add1_date_first_seen :=  __common__(if((sysdate != NULL) and (add1_date_first_seen2 != NULL), ((sysdate - add1_date_first_seen2) / 30.5), NULL));

		prop1_prev_purchase_date2 :=  __common__(map((length(trim((string)prop1_prev_purchase_date, LEFT, RIGHT)) = 8) and ((trim((string)prop1_prev_purchase_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)prop1_prev_purchase_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[7..8]))) - 1)),
										  (length(trim((string)prop1_prev_purchase_date, LEFT, RIGHT)) = 6) and ((trim((string)prop1_prev_purchase_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)prop1_prev_purchase_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)prop1_prev_purchase_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										  (length(trim((string)prop1_prev_purchase_date, LEFT, RIGHT)) = 4) and ((trim((string)prop1_prev_purchase_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)prop1_prev_purchase_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																  NULL));

		years_prop1_prev_purchase_date :=  __common__(if((sysdate != NULL) and (prop1_prev_purchase_date2 != NULL), ((sysdate - prop1_prev_purchase_date2) / 365.25), NULL));

		add2_avm_assessed_value_year2 :=  __common__(map((length(trim(add2_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim(add2_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[7..8]))) - 1)),
											  (length(trim(add2_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_avm_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
											  (length(trim(add2_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_avm_assessed_value_year, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																															  NULL));

		years_add2_avm_assess_year :=  __common__(if((sysdate != NULL) and (add2_avm_assessed_value_year2 != NULL), ((sysdate - add2_avm_assessed_value_year2) / 365.25), NULL));

		add2_mortgage_date2 :=  __common__(map((length(trim((string)add2_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add2_mortgage_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add2_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[7..8]))) - 1)),
									(length(trim((string)add2_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add2_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									(length(trim((string)add2_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add2_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_mortgage_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												NULL));

		years_add2_mortgage_date :=  __common__(if((sysdate != NULL) and (add2_mortgage_date2 != NULL), ((sysdate - add2_mortgage_date2) / 365.25), NULL));

		add2_mortgage_due_date2 :=  __common__(map((length(trim((string)add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim((string)add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add2_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[7..8]))) - 1)),
										(length(trim((string)add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim((string)add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_mortgage_due_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										(length(trim((string)add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim((string)add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_mortgage_due_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																															NULL));

		years_add2_mortgage_due_date :=  __common__(if((sysdate != NULL) and (add2_mortgage_due_date2 != NULL), ((sysdate - add2_mortgage_due_date2) / 365.25), NULL));

		add2_date_first_seen2 :=  __common__(map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add2_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8]))) - 1)),
									  (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									  (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																													  NULL));

		years_add2_date_first_seen :=  __common__(if((sysdate != NULL) and (add2_date_first_seen2 != NULL), ((sysdate - add2_date_first_seen2) / 365.25), NULL));

		months_add2_date_first_seen :=  __common__(if((sysdate != NULL) and (add2_date_first_seen2 != NULL), ((sysdate - add2_date_first_seen2) / 30.5), NULL));

		add3_date_first_seen2 :=  __common__(map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)add3_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8]))) - 1)),
									  (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add3_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									  (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add3_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																													  NULL));

		years_add3_date_first_seen :=  __common__(if((sysdate != NULL) and (add3_date_first_seen2 != NULL), ((sysdate - add3_date_first_seen2) / 365.25), NULL));

		months_add3_date_first_seen :=  __common__(if((sysdate != NULL) and (add3_date_first_seen2 != NULL), ((sysdate - add3_date_first_seen2) / 30.5), NULL));

		gong_did_first_seen2 :=  __common__(map((length(trim((string)gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)gong_did_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[7..8]))) - 1)),
									 (length(trim((string)gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)gong_did_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)gong_did_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									 (length(trim((string)gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)gong_did_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												   NULL));

		years_gong_did_first_seen :=  __common__(if((sysdate != NULL) and (gong_did_first_seen2 != NULL), ((sysdate - gong_did_first_seen2) / 365.25), NULL));

		header_first_seen2 :=  __common__(map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)header_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8]))) - 1)),
								   (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)header_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								   (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)header_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																											 NULL));

		years_header_first_seen :=  __common__(if((sysdate != NULL) and (header_first_seen2 != NULL), ((sysdate - header_first_seen2) / 365.25), NULL));

		infutor_first_seen2 :=  __common__(map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)infutor_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8]))) - 1)),
									(length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)infutor_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									(length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)infutor_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												NULL));

		years_infutor_first_seen :=  __common__(if((sysdate != NULL) and (infutor_first_seen2 != NULL), ((sysdate - infutor_first_seen2) / 365.25), NULL));

		liens_last_unrel_date2 :=  __common__(map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim(liens_last_unrel_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8]))) - 1)),
									   (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(liens_last_unrel_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									   (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(liens_last_unrel_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																										 NULL));

		years_liens_last_unrel_date :=  __common__(if((sysdate != NULL) and (liens_last_unrel_date2 != NULL), ((sysdate - liens_last_unrel_date2) / 365.25), NULL));

		liens_unrel_cj_first_seen2 :=  __common__(map((length(trim((string)liens_unrel_cj_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_cj_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[7..8]))) - 1)),
										   (length(trim((string)liens_unrel_cj_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										   (length(trim((string)liens_unrel_cj_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																	 NULL));

		years_liens_unrel_cj_first_seen :=  __common__(if((sysdate != NULL) and (liens_unrel_cj_first_seen2 != NULL), ((sysdate - liens_unrel_cj_first_seen2) / 365.25), NULL));

		liens_unrel_lt_first_seen2 :=  __common__(map((length(trim((string)liens_unrel_lt_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_lt_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_lt_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[7..8]))) - 1)),
										   (length(trim((string)liens_unrel_lt_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_lt_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_lt_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_lt_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										   (length(trim((string)liens_unrel_lt_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_lt_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_lt_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																	 NULL));

		years_liens_unrel_lt_first_seen :=  __common__(if((sysdate != NULL) and (liens_unrel_lt_first_seen2 != NULL), ((sysdate - liens_unrel_lt_first_seen2) / 365.25), NULL));

		liens_unrel_ot_first_seen2 :=  __common__(map((length(trim((string)liens_unrel_ot_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_ot_first_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_ot_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[7..8]))) - 1)),
										   (length(trim((string)liens_unrel_ot_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_ot_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_ot_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_ot_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										   (length(trim((string)liens_unrel_ot_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_ot_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_ot_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																	 NULL));

		years_liens_unrel_ot_first_seen :=  __common__(if((sysdate != NULL) and (liens_unrel_ot_first_seen2 != NULL), ((sysdate - liens_unrel_ot_first_seen2) / 365.25), NULL));

		criminal_last_date2 :=  __common__(map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)criminal_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8]))) - 1)),
									(length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)criminal_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
									(length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)criminal_last_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																												NULL));

		years_criminal_last_date :=  __common__(if((sysdate != NULL) and (criminal_last_date2 != NULL), ((sysdate - criminal_last_date2) / 365.25), NULL));

		felony_last_date2 :=  __common__(map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)felony_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8]))) - 1)),
								  (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)felony_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								  (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)felony_last_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																										  NULL));

		years_felony_last_date :=  __common__(if((sysdate != NULL) and (felony_last_date2 != NULL), ((sysdate - felony_last_date2) / 365.25), NULL));

		reported_dob2 :=  __common__(map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)reported_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)reported_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[7..8]))) - 1)),
							  (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)reported_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
							  (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)reported_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																							  NULL));

		years_reported_dob :=  __common__(if((sysdate != NULL) and (reported_dob2 != NULL), ((sysdate - reported_dob2) / 365.25), NULL));

		// # warning:  engineer intervention needed -- function findw not implemented
		Common.findw(  rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool' );
		Common.findw(  rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool' );
		Common.findw(  rc_sources, 'AR', ' ,', 'I', source_tot_AR, 'bool' );
		Common.findw(  rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool' );
		Common.findw(  rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool' );
		Common.findw(  rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool' );
		Common.findw(  rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool' );
		Common.findw(  rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool' );
		Common.findw(  rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool' );
		Common.findw(  rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool' );
		Common.findw(  rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool' );
		Common.findw(  rc_sources, 'P', ' ,', 'I', source_tot_P, 'bool' );
		Common.findw(  rc_sources, 'W', ' ,', 'I', source_tot_W, 'bool' );
		source_tot_voter := __common__((source_tot_EM or source_tot_VO));
		Common.findw(  fname_sources, 'PL', ' ,', 'I', source_fst_PL, 'bool' );
		Common.findw(  fname_sources, 'SL', ' ,', 'I', source_fst_SL, 'bool' );
		Common.findw(  lname_sources, 'PL', ' ,', 'I', source_lst_PL, 'bool' );
		Common.findw(  lname_sources, 'SL', ' ,', 'I', source_lst_SL, 'bool' );
		Common.findw(  addr_sources, 'P', ' ,', 'I', source_add_P, 'bool' );
		Common.findw(  addr_sources, 'PL', ' ,', 'I', source_add_PL, 'bool' );
		Common.findw(  add2_sources, 'AK', ' ,', 'I', source_add2_AK, 'bool' );
		Common.findw(  add2_sources, 'AM', ' ,', 'I', source_add2_AM, 'bool' );
		Common.findw(  add2_sources, 'AR', ' ,', 'I', source_add2_AR, 'bool' );
		Common.findw(  add2_sources, 'CG', ' ,', 'I', source_add2_CG, 'bool' );
		Common.findw(  add2_sources, 'EB', ' ,', 'I', source_add2_EB, 'bool' );
		Common.findw(  add2_sources, 'EM', ' ,', 'I', source_add2_EM, 'bool' );
		Common.findw(  add2_sources, 'VO', ' ,', 'I', source_add2_VO, 'bool' );
		Common.findw(  add2_sources, 'EQ', ' ,', 'I', source_add2_EQ, 'bool' );
		Common.findw(  add2_sources, 'P', ' ,', 'I', source_add2_P, 'bool' );
		Common.findw(  add2_sources, 'WP', ' ,', 'I', source_add2_WP, 'bool' );
		source_add2_voter := __common__((source_add2_EM or source_add2_VO));
		Common.findw(  add3_sources, 'P', ' ,', 'I', source_add3_P, 'bool' );
		Common.findw(  em_only_sources, 'EM', ' ,', 'I', em_only_source_EM, 'bool' );
		Common.findw(  em_only_sources, 'E1', ' ,', 'I', em_only_source_E1, 'bool' );
		Common.findw(  em_only_sources, 'E2', ' ,', 'I', em_only_source_E2, 'bool' );
		Common.findw(  em_only_sources, 'E3', ' ,', 'I', em_only_source_E3, 'bool' );
		Common.findw(  em_only_sources, 'E4', ' ,', 'I', em_only_source_E4, 'bool' );



		verfst_p := __common__((nap_summary in [2, 3, 4, 8, 9, 10, 12]));
		verlst_p := __common__((nap_summary in [2, 5, 7, 8, 9, 11, 12]));
		veradd_p := __common__((nap_summary in [3, 5, 6, 8, 10, 11, 12]));
		verphn_p := __common__((nap_summary in [4, 6, 7, 9, 10, 11, 12]));

		ver_phncount := __common__(if(max((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p) = NULL, NULL, sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p)));

		years_adl_first_seen_max_fcra := __common__(max(years_adl_eq_first_seen, years_adl_en_first_seen, years_adl_pr_first_seen, years_adl_em_first_seen, years_adl_vo_first_seen, years_adl_em_only_first_seen, years_adl_w_first_seen));

		months_adl_first_seen_max_fcra := __common__(max(months_adl_eq_first_seen, months_adl_en_first_seen, months_adl_pr_first_seen, months_adl_em_first_seen, months_adl_vo_first_seen, months_adl_em_only_first_seen, months_adl_w_first_seen));

		add_ec1 := __common__(((string)StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

		add_ec3 := __common__(((string)StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

		add_ec4 := __common__(((string)StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

		add_apt := __common__(((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' ')))));

		phn_disconnected := __common__(((integer)rc_hriskphoneflag = 5));

		phn_inval := __common__((((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5']))));

		phn_cellpager := __common__(((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3'])));

		phn_zipmismatch := __common__((((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1)));

		phn_residential := __common__(((integer)rc_hphonevalflag = 2));

		ssn_priordob := __common__((((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1)));

		ssn_inval := __common__((((integer)rc_ssnvalflag = 1) or (rc_pwssnvalflag in ['1', '2', '3'])));

		ssn_issued18 := __common__(((integer)rc_pwssnvalflag = 5));

		ssn_deceased := __common__((((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1)));

		ssn_adl_prob := __common__(((ssns_per_adl = 0) or ((ssns_per_adl >= 3) or (ssns_per_adl_c6 >= 2))));

		ssn_prob := __common__((ssn_deceased or (ssn_priordob or ssn_inval)));

		bk_flag := __common__(((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0))))));

		lien_rec_unrel_flag := __common__((liens_recent_unreleased_count > 0));

		lien_hist_unrel_flag := __common__((liens_historical_unreleased_ct > 0));

		lien_flag := __common__((((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag))));

		add1_AVM_hit := __common__(((integer)add1_avm_land_use > 0));

add1_avm_med :=  __common__(map(
    add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    add1_avm_med_fips
));

		add1_avm_to_med_ratio :=  __common__(if(not((add1_avm_automated_valuation in [NULL, 0])) and not((add1_avm_med in [NULL, 0])), (add1_avm_automated_valuation / add1_avm_med), NULL));

		add_lres_month_avg := __common__(if(
			max(months_add1_date_first_seen, months_add2_date_first_seen, months_add3_date_first_seen) = NULL, NULL,
			SUM(if(months_add1_date_first_seen = NULL, 0, months_add1_date_first_seen),
			    if(months_add2_date_first_seen = NULL, 0, months_add2_date_first_seen),
			    if(months_add3_date_first_seen = NULL, 0, months_add3_date_first_seen))/sum(if(months_add1_date_first_seen = NULL, 0, 1),
			                                                                                if(months_add2_date_first_seen = NULL, 0, 1),
			                                                                                if(months_add3_date_first_seen = NULL, 0, 1))));

		pk_wealth_index :=  __common__(map((integer)wealth_index <= 2 => 0,
								(integer)wealth_index <= 3 => 1,
								(integer)wealth_index <= 4 => 2,
								(integer)wealth_index <= 5 => 3,
															  4));

		pk_wealth_index_m :=  __common__(map(pk_wealth_index = 0 => 39116.676936,
								  pk_wealth_index = 1 => 43449.700792,
								  pk_wealth_index = 2 => 57061.910522,
								  pk_wealth_index = 3 => 82122.972447,
														 134020.49977));

		wealth_index_cm :=  __common__(map((integer)wealth_index = 0 => 35766,
								(integer)wealth_index = 1 => 32220,
								(integer)wealth_index = 2 => 35991,
								(integer)wealth_index = 3 => 39789,
								(integer)wealth_index = 4 => 46630,
								(integer)wealth_index = 5 => 52993,
								(integer)wealth_index = 6 => 55911,
															 43256));

		Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool' );
		Common.findw( rc_sources, 'CG', ' ,', 'I', source_tot_CG_2, 'bool' );
		Common.findw( rc_sources, 'P', ' ,', 'I', source_tot_P_2, 'bool' );
		Common.findw( rc_sources, 'BA', ' ,', 'I', source_tot_BA_2, 'bool' );
		Common.findw( rc_sources, 'AM', ' ,', 'I', source_tot_AM_2, 'bool' );
		Common.findw( rc_sources, 'W', ' ,', 'I', source_tot_W_2, 'bool' );


		add_apt_2 := __common__(((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' ')))));

		pk_bk_level :=  __common__(map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0));

		rc_valid_bus_phone :=  __common__(if((integer)rc_phonevalflag = 1, 1, 0));

		rc_valid_res_phone :=  __common__(if((integer)rc_phonevalflag = 2, 1, 0));

		age_rcd :=  __common__(map(age < 18 => 35,
						age > 60 => 35,
									age));

		add1_mortgage_type_ord :=  __common__(map(add1_mortgage_type in ['FHA']              => 1,
									   add1_mortgage_type in ['', ' ']            => 2,
									   add1_mortgage_type in ['2', 'E', 'N', 'U'] => 4,
																					 3));

		prof_license_category_ord :=  __common__(map((string)prof_license_category = '0' => 1,
										  prof_license_category in ['', ' ']  => 1.5,
																				 (real)prof_license_category));

		pk_attr_total_number_derogs := __common__(attr_total_number_derogs);

		pk_attr_total_number_derogs_2 :=  __common__(if((integer)pk_attr_total_number_derogs > 3, 3, pk_attr_total_number_derogs));

		pk_attr_num_nonderogs90 := __common__(attr_num_nonderogs90);

		pk_attr_num_nonderogs90_2 :=  __common__(if((integer)pk_attr_num_nonderogs90 > 4, 4, pk_attr_num_nonderogs90));

		pk_derog_total :=  __common__(if(pk_attr_total_number_derogs_2 > 0, pk_attr_total_number_derogs_2, (-1 * pk_attr_num_nonderogs90_2)));

		pk_derog_total_m :=  __common__(map(pk_derog_total <= -4 => 51961,
								 pk_derog_total <= -3 => 49033,
								 pk_derog_total <= -2 => 45551,
								 pk_derog_total <= -1 => 40287,
								 pk_derog_total <= 0  => 42406,
								 pk_derog_total <= 1  => 40550,
								 pk_derog_total <= 2  => 38539,
								 pk_derog_total <= 3  => 37345,
														 43256));

		add1_avm_automated_valuation_rcd :=  __common__(if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation));

		add1_avm_automated_val_2_rcd :=  __common__(if((integer)add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2));

		pk_liens_unrel_ot_total_amount :=  __common__(map((integer)liens_unrel_ot_total_amount <= 0     => -1,
											   (integer)liens_unrel_ot_total_amount <= 10000 => 0,
																								1));

		attr_num_watercraft60_cap :=  __common__(if((integer)attr_num_watercraft60 > 2, 2, attr_num_watercraft60));

		combo_addrcount_cap :=  __common__(if(combo_addrcount > 6, 6, combo_addrcount));

		gong_did_phone_ct_cap :=  __common__(if((integer)gong_did_phone_ct > 5, 5, gong_did_phone_ct));

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		ams_college_code_mis := __common__((integer)(''=trim(ams_college_code)));

		ams_college_code_cm :=  __common__(map((integer)ams_college_code = 2 => 38463,
									(integer)ams_college_code = 4 => 49756,
																	 43256));

		ams_income_level_code_cm :=  __common__(map(ams_income_level_code in ['A', 'B', 'C'] => 38285,
										 ams_income_level_code = 'D'              => 39525,
										 ams_income_level_code = 'E'              => 42426,
										 ams_income_level_code = 'F'              => 44337,
										 ams_income_level_code = 'G'              => 46648,
										 ams_income_level_code = 'H'              => 48231,
										 ams_income_level_code = 'I'              => 49622,
										 ams_income_level_code = 'J'              => 52149,
										 ams_income_level_code = 'K'              => 53457,
																					 43095));

		unit5 :=  __common__(if((integer)add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5)));

		pk_dist_a1toa2 :=  __common__(map(dist_a1toa2 = 9999 => -1,
							   dist_a1toa2 <= 0   => 0,
							   dist_a1toa2 <= 9   => 1,
													 2));

		pk_dist_a1toa3 :=  __common__(map(dist_a1toa3 = 9999 => -1,
							   dist_a1toa3 <= 0   => 0,
							   dist_a1toa3 <= 30  => 1,
													 2));

		pk_dist_a2toa3 :=  __common__(map(dist_a2toa3 = 9999 => -1,
							   dist_a2toa3 <= 0   => 0,
							   dist_a2toa3 <= 9   => 1,
							   dist_a2toa3 <= 35  => 2,
													 3));

		pk_rc_disthphoneaddr :=  __common__(map(rc_disthphoneaddr = 9999 => 0,
									 rc_disthphoneaddr <= 3   => 0,
									 rc_disthphoneaddr <= 6   => 1,
									 rc_disthphoneaddr <= 12  => 2,
																 3));

		Dist_mod := __common__(53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356));

		date_last_seen2 :=  __common__(map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))) - 1)),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																									NULL));

		liens_unrel_cj_last_seen2 :=  __common__(map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))) - 1)),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																  NULL));

		years_date_last_seen :=  __common__(if((sysdate != NULL) and (date_last_seen2 != NULL), ((sysdate - date_last_seen2) / 365.25), NULL));

		years_liens_unrel_cj_last_seen :=  __common__(if((sysdate != NULL) and (liens_unrel_cj_last_seen2 != NULL), ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL));

		pk_yr_date_last_seen := __common__(if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen)));

		pk_bk_yr_date_last_seen :=  __common__(map((real)pk_yr_date_last_seen = NULL => -1,
										(real)pk_yr_date_last_seen >= 9   => 9,
																			 pk_yr_date_last_seen));

		pk_bk_yr_date_last_seen_m1 :=  __common__(map(pk_bk_yr_date_last_seen = -1 => 65447.971203,
										   pk_bk_yr_date_last_seen = 1  => 37195.924959,
										   pk_bk_yr_date_last_seen = 2  => 40666.992447,
										   pk_bk_yr_date_last_seen = 3  => 42965.336207,
										   pk_bk_yr_date_last_seen = 4  => 44669.167255,
										   pk_bk_yr_date_last_seen = 5  => 47563.390744,
										   pk_bk_yr_date_last_seen = 6  => 47917.954038,
										   pk_bk_yr_date_last_seen = 7  => 49396.154083,
										   pk_bk_yr_date_last_seen = 8  => 50099.973169,
										   pk_bk_yr_date_last_seen = 9  => 52557.404007,
																		   65447.971203));

		adl_category_ord := __common__((integer)((string)adl_category = '1 DEAD'));

		pk_yr_liens_unrel_cj_last_seen := __common__(if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen)));

		pk2_yr_liens_unrel_cj_last_seen :=  __common__(map(pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
												pk_yr_liens_unrel_cj_last_seen <= 3          => 2,
												pk_yr_liens_unrel_cj_last_seen <= 5          => 1,
																								0));

		predicted_inc_high := __common__(-28552 +
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
			((integer)add_apt_2 * -6810.8463) +
			((integer)source_tot_CG_2 * 28047) +
			((integer)source_tot_W_2 * 6718.13655) +
			(gong_did_phone_ct * 1414.7842) +
			(add1_mortgage_type_ord * 1825.91813) +
			((integer)source_tot_AM_2 * 17169) +
			(rc_valid_bus_phone * 11042) +
			(pk_liens_unrel_ot_total_amount * 7931.02954) +
			(add1_avm_automated_val_2_rcd * 0.00826) +
			(ams_college_code_mis * -5323.07783) +
			(pk_bk_level * -1970.64639));

		predicted_inc_low := __common__(-45923 +
			(unit5 * -832.87755) +
			(wealth_index_cm * 0.58264) +
			(pk_derog_total_m * 0.09997) +
			(add1_avm_automated_valuation_rcd * 0.045) +
			(addrs_per_adl * 545.9244) +
			((integer)source_tot_W_2 * 5334.71282) +
			(prof_license_category_ord * 5952.85069) +
			((integer)source_tot_P_2 * 2443.25461) +
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
			((integer)source_tot_AM_2 * 12757) +
			((integer)lname_eda_sourced * 1462.6333));

		pred_inc :=  __common__(if((integer)predicted_inc_high < 60000, (predicted_inc_low - 2000), (predicted_inc_high - 2000)));

		estimated_income := __common__(max((real)0, round(pred_inc/1000)*1000));

		estimated_income_2 :=  __common__(if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, estimated_income));

		pk_ssnchar_invalid_or_recent :=  __common__(if(inputssncharflag in ['1', '2', '3', '4'], 1, 0));

		pk_did0 :=  __common__(if((integer)did = 0, 1, 0));

		pk_ssn_prob_nodob := __common__((ssn_deceased or ssn_inval));

		pk_yr_adl_vo_first_seen := __common__(if (years_adl_vo_first_seen >= 0, roundup(years_adl_vo_first_seen), truncate(years_adl_vo_first_seen)));

		pk_yr_adl_em_only_first_seen := __common__(if (years_adl_em_only_first_seen >= 0, roundup(years_adl_em_only_first_seen), truncate(years_adl_em_only_first_seen)));

		pk_yr_adl_first_seen_max_fcra := __common__(if (years_adl_first_seen_max_fcra >= 0, roundup(years_adl_first_seen_max_fcra), truncate(years_adl_first_seen_max_fcra)));

		pk_mo_adl_first_seen_max_fcra := __common__(if (months_adl_first_seen_max_fcra >= 0, roundup(months_adl_first_seen_max_fcra), truncate(months_adl_first_seen_max_fcra)));

		pk_yr_lname_change_date := __common__(if (years_lname_change_date >= 0, roundup(years_lname_change_date), truncate(years_lname_change_date)));

		pk_yr_gong_did_first_seen := __common__(if (years_gong_did_first_seen >= 0, roundup(years_gong_did_first_seen), truncate(years_gong_did_first_seen)));

		pk_yr_header_first_seen := __common__(if (years_header_first_seen >= 0, roundup(years_header_first_seen), truncate(years_header_first_seen)));

		pk_yr_infutor_first_seen := __common__(if (years_infutor_first_seen >= 0, roundup(years_infutor_first_seen), truncate(years_infutor_first_seen)));

		pk_multi_did :=  __common__(if((integer)did_count >= 2, 1, 0));

		pk_nas_summary :=  __common__(map(nas_summary >= 12 => 2,
							   nas_summary >= 9  => 1,
													0));

		pk_rc_dirsaddr_lastscore :=  __common__(map((integer)rc_dirsaddr_lastscore = 255 => -1,
										 (integer)rc_dirsaddr_lastscore >= 90 => 2,
										 (integer)rc_dirsaddr_lastscore >= 80 => 1,
																				 0));

		pk_adl_score :=  __common__(if(adl_score = 100, 1, 0));

		pk_combo_fnamescore :=  __common__(map(combo_fnamescore = 255 => 0,
									combo_fnamescore >= 90 => 1,
															  0));

		pk_fname_score :=  __common__(map(fname_score = 255 => 0,
							   fname_score >= 90 => 1,
													0));

		pk_combo_addrscore :=  __common__(if(combo_addrscore = 100, 1, 0));

		pk_combo_hphonescore :=  __common__(map(combo_hphonescore = 255 => 0,
									 combo_hphonescore = 100 => 2,
									 combo_hphonescore >= 90 => 1,
																0));

		pk_combo_ssnscore :=  __common__(map(combo_ssnscore = 100 => 1,
								  combo_ssnscore = 255 => -1,
														  0));

		pk_combo_dobscore :=  __common__(map(combo_dobscore = 255 => -1,
								  combo_dobscore >= 95 => 2,
								  combo_dobscore >= 90 => 1,
														  0));

		pk_combo_fnamecount :=  __common__(map(combo_fnamecount <= 1 => 0,
									combo_fnamecount <= 2 => 1,
									combo_fnamecount <= 3 => 2,
									combo_fnamecount <= 4 => 3,
															 4));

		pk_combo_fnamecount_nb :=  __common__(map(combo_fnamecount <= 1 => 0,
									   combo_fnamecount <= 2 => 1,
									   combo_fnamecount <= 3 => 2,
									   combo_fnamecount <= 4 => 3,
									   combo_fnamecount <= 5 => 4,
									   combo_fnamecount <= 6 => 5,
																6));

		pk_rc_fnamecount :=  __common__(map(rc_fnamecount <= 1 => 0,
								 rc_fnamecount <= 2 => 1,
								 rc_fnamecount <= 3 => 2,
													   3));

		pk_rc_fnamecount_nb :=  __common__(map(rc_fnamecount <= 1 => 0,
									rc_fnamecount <= 2 => 1,
									rc_fnamecount <= 3 => 2,
									rc_fnamecount <= 4 => 3,
									rc_fnamecount <= 5 => 4,
									rc_fnamecount <= 6 => 5,
														  6));

		pk_combo_lnamecount :=  __common__(map(combo_lnamecount <= 1 => 0,
									combo_lnamecount <= 2 => 1,
									combo_lnamecount <= 3 => 2,
									combo_lnamecount <= 4 => 3,
															 4));

		pk_rc_phonelnamecount :=  __common__(if(rc_phonelnamecount <= 0, 0, 1));

		pk_combo_addrcount_nb :=  __common__(map(combo_addrcount <= 0 => 0,
									  combo_addrcount <= 1 => 1,
									  combo_addrcount <= 2 => 2,
									  combo_addrcount <= 3 => 3,
									  combo_addrcount <= 4 => 4,
															  5));

		pk_rc_addrcount :=  __common__(map(rc_addrcount <= 1 => 0,
								rc_addrcount <= 2 => 1,
								rc_addrcount <= 3 => 2,
													 3));

		pk_rc_addrcount_nb :=  __common__(map(rc_addrcount <= 0 => 0,
								   rc_addrcount <= 1 => 1,
								   rc_addrcount <= 2 => 1,
								   rc_addrcount <= 3 => 1,
														3));

		pk_rc_phoneaddr_phonecount :=  __common__(if(rc_phoneaddr_phonecount <= 0, 0, 1));

		pk_ver_phncount :=  __common__(map(ver_phncount <= 0 => 0,
								ver_phncount <= 2 => 1,
								ver_phncount <= 3 => 2,
													 3));

		pk_combo_ssncount :=  __common__(map(combo_ssncount <= 0 => -1,
								  combo_ssncount <= 1 => 0,
														 1));

		pk_combo_dobcount :=  __common__(map(combo_dobcount <= 0 => 0,
								  combo_dobcount <= 1 => 1,
								  combo_dobcount <= 2 => 2,
								  combo_dobcount <= 3 => 3,
														 4));

		pk_combo_dobcount_nb :=  __common__(map(combo_dobcount <= 0 => 0,
									 combo_dobcount <= 1 => 1,
									 combo_dobcount <= 2 => 2,
									 combo_dobcount <= 3 => 3,
									 combo_dobcount <= 4 => 4,
									 combo_dobcount <= 5 => 5,
									 combo_dobcount <= 6 => 6,
															7));

		pk_eq_count :=  __common__(map(eq_count <= 1  => 0,
							eq_count <= 3  => 1,
							eq_count <= 5  => 2,
							eq_count <= 6  => 3,
							eq_count <= 7  => 4,
							eq_count <= 17 => 5,
											  6));

		pk_pos_secondary_sources :=  __common__(map(source_tot_EB                                                                                                                                                                                                                         => 2,
										 if(max((integer)source_tot_AK, (integer)source_tot_AM_2, (integer)source_tot_AR, (integer)source_tot_CG_2) = NULL, NULL, sum((integer)source_tot_AK, (integer)source_tot_AM_2, (integer)source_tot_AR, (integer)source_tot_CG_2)) > 0 => 1,
																																																																				  0));

		pk_voter_flag :=  __common__(map(source_tot_voter => 1,
							  voter_avail      => -1,
												  0));

		pk_lname_eda_sourced_type_lvl :=  __common__(map(trim(trim((string)lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP' => 3,
											  trim(trim((string)lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'  => 2,
											  trim(trim((string)lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A'  => 1,
																													  0));

		pk_add1_address_score :=  __common__(if(add1_address_score = 100, 1, 0));

		pk_add1_unit_count2 :=  __common__(map((integer)add1_unit_count <= 2 => 0,
									(integer)add1_unit_count <= 3 => 1,
									(integer)add1_unit_count <= 4 => 2,
																	 3));

		pk_add2_address_score :=  __common__(map(add2_address_score >= 90 => 3,
									  add2_address_score >= 60 => 2,
									  add2_address_score >= 10 => 1,
																  0));

		pk_add2_pos_sources :=  __common__(map(source_add2_EQ and (source_add2_WP and source_add2_voter) => 4,
									source_add2_EQ and source_add2_WP                         => 3,
									source_add2_voter                                         => 2,
									source_add2_EQ                                            => 1,
																								 0));

		pk_add2_pos_secondary_sources :=  __common__(map(source_add2_EB                                                                                                                                                                                                                        => 2,
											  if(max((integer)source_add2_AK, (integer)source_add2_AM, (integer)source_add2_AR, (integer)source_add2_CG) = NULL, NULL, sum((integer)source_add2_AK, (integer)source_add2_AM, (integer)source_add2_AR, (integer)source_add2_CG)) > 0 => 1,
																																																																					   0));

		Common.findw(add2_sources, 'EM', ' ,', 'I', add2_source_EM, 'bool');
		Common.findw(add2_sources, 'E1', ' ,', 'I', add2_source_E1, 'bool');
		Common.findw(add2_sources, 'E2', ' ,', 'I', add2_source_E2, 'bool');
		Common.findw(add2_sources, 'E3', ' ,', 'I', add2_source_E3, 'bool');
		Common.findw(add2_sources, 'E4', ' ,', 'I', add2_source_E4, 'bool');
		Common.findw(add3_sources, 'EM', ' ,', 'I', add3_source_EM, 'bool');
		Common.findw(add3_sources, 'E1', ' ,', 'I', add3_source_E1, 'bool');
		Common.findw(add3_sources, 'E2', ' ,', 'I', add3_source_E2, 'bool');
		Common.findw(add3_sources, 'E3', ' ,', 'I', add3_source_E3, 'bool');
		Common.findw(add3_sources, 'E4', ' ,', 'I', add3_source_E4, 'bool');

		pk_em_only_ver_lvl :=  __common__(map(em_only_source_EM and em_only_source_E1 => 3,
								   em_only_source_E1                       => 2,
								   em_only_source_E4                       => -1,
								   em_only_source_EM                       => 1,
																			  0));

		pk_add2_em_ver_lvl :=  __common__(map(add2_source_E1 => 2,
								   add2_source_E4 => -1,
								   add2_source_EM => 1,
													 0));

		pk_ssnchar_invalid_or_recent_2 :=  __common__(if(inputssncharflag in ['1', '2', '3', '4'], 1, 0));

		pk_infutor_risk_lvl :=  __common__(map(infutor_nap in [1, 6] => 2,
									infutor_nap in [0]    => 0,
															 1));

		pk_infutor_risk_lvl_nb :=  __common__(map(infutor_nap in [1, 6] => 3,
									   infutor_nap in [12]   => 0,
									   infutor_nap in [0]    => 1,
																2));

		pk_yr_adl_vo_first_seen2 :=  __common__(map((real)pk_yr_adl_vo_first_seen <= NULL => -1,
										 pk_yr_adl_vo_first_seen <= 1          => 0,
										 pk_yr_adl_vo_first_seen <= 3          => 1,
										 pk_yr_adl_vo_first_seen <= 4          => 2,
																				  3));

		pk_yr_adl_em_only_first_seen2 :=  __common__(map((real)pk_yr_adl_em_only_first_seen <= NULL => -1,
											  pk_yr_adl_em_only_first_seen <= 1          => 0,
											  pk_yr_adl_em_only_first_seen <= 2          => 1,
											  pk_yr_adl_em_only_first_seen <= 3          => 2,
											  pk_yr_adl_em_only_first_seen <= 19         => 3,
																							4));

		pk_yrmo_adl_first_seen_max_fcra2 :=  __common__(map((real)pk_mo_adl_first_seen_max_fcra <= NULL => -1,
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
																								16));

		pk_yr_lname_change_date2 :=  __common__(map((real)pk_yr_lname_change_date <= NULL => -1,
										 pk_yr_lname_change_date <= 2          => 0,
										 pk_yr_lname_change_date <= 8          => 1,
																				  2));

		pk_yr_gong_did_first_seen2 :=  __common__(map((real)pk_yr_gong_did_first_seen <= NULL => -1,
										   pk_yr_gong_did_first_seen <= 1          => 0,
										   pk_yr_gong_did_first_seen <= 2          => 1,
										   pk_yr_gong_did_first_seen <= 3          => 2,
										   pk_yr_gong_did_first_seen <= 4          => 3,
																					  4));

		pk_yr_header_first_seen2 :=  __common__(map((real)pk_yr_header_first_seen <= NULL => -1,
										 pk_yr_header_first_seen <= 1          => 0,
										 pk_yr_header_first_seen <= 2          => 1,
										 pk_yr_header_first_seen <= 4          => 2,
										 pk_yr_header_first_seen <= 5          => 3,
										 pk_yr_header_first_seen <= 16         => 4,
										 pk_yr_header_first_seen <= 19         => 5,
										 pk_yr_header_first_seen <= 24         => 6,
																				  7));

		pk_yr_infutor_first_seen2 :=  __common__(map((real)pk_yr_infutor_first_seen <= NULL => -1,
										  pk_yr_infutor_first_seen <= 1          => 0,
										  pk_yr_infutor_first_seen <= 2          => 1,
										  pk_yr_infutor_first_seen <= 3          => 2,
										  pk_yr_infutor_first_seen <= 4          => 3,
																					4));

		pk_estimated_income :=  __common__(map((integer)estimated_income_2 <= 222    => -1,
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
																			 22));

		pk_yr_adl_w_first_seen := __common__(if (years_adl_w_first_seen >= 0, roundup(years_adl_w_first_seen), truncate(years_adl_w_first_seen)));

		pk_yr_adl_w_last_seen := __common__(if (years_adl_w_last_seen >= 0, roundup(years_adl_w_last_seen), truncate(years_adl_w_last_seen)));

		pk_yr_add1_purchase_date := __common__(if (years_add1_purchase_date >= 0, roundup(years_add1_purchase_date), truncate(years_add1_purchase_date)));

		pk_yr_add1_built_date := __common__(if (years_add1_built_date >= 0, roundup(years_add1_built_date), truncate(years_add1_built_date)));

		pk_yr_add1_mortgage_date := __common__(if (years_add1_mortgage_date >= 0, roundup(years_add1_mortgage_date), truncate(years_add1_mortgage_date)));

		pk_yr_add1_date_first_seen := __common__(if (years_add1_date_first_seen >= 0, roundup(years_add1_date_first_seen), truncate(years_add1_date_first_seen)));

		pk_yr_prop1_prev_purchase_date := __common__(if (years_prop1_prev_purchase_date >= 0, roundup(years_prop1_prev_purchase_date), truncate(years_prop1_prev_purchase_date)));

		pk_yr_add2_mortgage_date := __common__(if (years_add2_mortgage_date >= 0, roundup(years_add2_mortgage_date), truncate(years_add2_mortgage_date)));

		pk_yr_add2_mortgage_due_date := __common__(if (years_add2_mortgage_due_date >= 0, roundup(years_add2_mortgage_due_date), truncate(years_add2_mortgage_due_date)));

		pk_yr_add2_date_first_seen := __common__(if (years_add2_date_first_seen >= 0, roundup(years_add2_date_first_seen), truncate(years_add2_date_first_seen)));

		pk_yr_add3_date_first_seen := __common__(if (years_add3_date_first_seen >= 0, roundup(years_add3_date_first_seen), truncate(years_add3_date_first_seen)));

		pk_property_owned_assessed_total := __common__((20000 * if ((property_owned_assessed_total / 20000) >= 0, roundup((property_owned_assessed_total / 20000)), truncate((property_owned_assessed_total / 20000)))));

		pk_prop1_sale_price := __common__((20000 * if ((prop1_sale_price / 20000) >= 0, roundup((prop1_sale_price / 20000)), truncate((prop1_sale_price / 20000)))));

		pk_add1_assessed_amount := __common__((20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000)))));

		pk_add2_assessed_amount := __common__((20000 * if ((add2_assessed_amount / 20000) >= 0, roundup((add2_assessed_amount / 20000)), truncate((add2_assessed_amount / 20000)))));

		pk_add3_assessed_amount := __common__((20000 * if ((add3_assessed_amount / 20000) >= 0, roundup((add3_assessed_amount / 20000)), truncate((add3_assessed_amount / 20000)))));

		pk_property_owned_assessed_total_2 :=  __common__(if(pk_property_owned_assessed_total > 1000000, 1000000, pk_property_owned_assessed_total));

		pk_prop1_sale_price_2 :=  __common__(if(pk_prop1_sale_price > 1000000, 1000000, pk_prop1_sale_price));

		pk_add1_assessed_amount_2 :=  __common__(if(pk_add1_assessed_amount > 1000000, 1000000, pk_add1_assessed_amount));

		pk_add2_assessed_amount_2 :=  __common__(if(pk_add2_assessed_amount > 1000000, 1000000, pk_add2_assessed_amount));

		pk_add3_assessed_amount_2 :=  __common__(if(pk_add3_assessed_amount > 1000000, 1000000, pk_add3_assessed_amount));

		pk_add1_building_area :=  __common__(map((integer)add1_building_area <= 1000   => (100 * if ((add1_building_area / 100) >= 0, roundup((add1_building_area / 100)), truncate((add1_building_area / 100)))),
									  (integer)add1_building_area <= 10000  => (1000 * if ((add1_building_area / 1000) >= 0, roundup((add1_building_area / 1000)), truncate((add1_building_area / 1000)))),
									  (integer)add1_building_area <= 100000 => (10000 * if ((add1_building_area / 10000) >= 0, roundup((add1_building_area / 10000)), truncate((add1_building_area / 10000)))),
																			   100001));

		pk_add2_building_area :=  __common__(map((integer)add2_building_area <= 1000   => (100 * if ((add2_building_area / 100) >= 0, roundup((add2_building_area / 100)), truncate((add2_building_area / 100)))),
									  (integer)add2_building_area <= 10000  => (1000 * if ((add2_building_area / 1000) >= 0, roundup((add2_building_area / 1000)), truncate((add2_building_area / 1000)))),
									  (integer)add2_building_area <= 100000 => (10000 * if ((add2_building_area / 10000) >= 0, roundup((add2_building_area / 10000)), truncate((add2_building_area / 10000)))),
																			   100001));

		pk_yr_adl_w_first_seen2 :=  __common__(map((real)pk_yr_adl_w_first_seen <= NULL => -1,
										pk_yr_adl_w_first_seen <= 3          => 0,
										pk_yr_adl_w_first_seen <= 12         => 1,
																				2));

		pk_yr_adl_w_last_seen2 :=  __common__(map((real)pk_yr_adl_w_last_seen <= NULL => -1,
									   pk_yr_adl_w_last_seen <= 0          => 0,
									   pk_yr_adl_w_last_seen <= 1          => 1,
																			  2));

		pk_pr_count :=  __common__(map(pr_count <= 0 => -1,
							pr_count <= 1 => 0,
							pr_count <= 9 => 1,
											 2));

		pk_addrs_sourced_lvl :=  __common__(map(source_add_P and (source_add2_P or source_add3_P) => 3,
									 source_add_P                                      => 2,
									 source_add2_P or source_add3_P                    => 1,
																						  0));

		pk_naprop_level :=  __common__(map((add1_naprop = 4) and (add2_naprop = 4)  => 7,
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
																			0));

		pk_naprop_level2_b1 := __common__(map(pk_naprop_level = 6  => 7,
								   pk_naprop_level >= 2 => 5,
														   4));

		pk_naprop_level2 := __common__(map(add3_naprop = 4                              => pk_naprop_level2_b1,
								(add3_naprop = 0) and (pk_naprop_level = -1) => -2,
								(add3_naprop = 0) and (pk_naprop_level = 0)  => -1,
																				pk_naprop_level));

		pk_add2_own_level :=  __common__(map(add2_applicant_owned and add2_family_owned => 3,
								  add2_applicant_owned                       => 2,
								  add2_family_owned                          => 1,
																				0));

		pk_add3_own_level :=  __common__(map(add3_applicant_owned and add3_family_owned => 3,
								  add3_applicant_owned                       => 2,
								  add3_family_owned                          => 1,
																				0));

		pk_yr_add1_purchase_date2 :=  __common__(map((real)pk_yr_add1_purchase_date <= NULL => -1,
										  pk_yr_add1_purchase_date <= 2          => 0,
										  pk_yr_add1_purchase_date <= 3          => 1,
										  pk_yr_add1_purchase_date <= 6          => 2,
										  pk_yr_add1_purchase_date <= 13         => 3,
										  pk_yr_add1_purchase_date <= 22         => 4,
																					5));

		pk_yr_add1_built_date2 :=  __common__(map((real)pk_yr_add1_built_date <= NULL => -4,
									   pk_yr_add1_built_date <= 1          => -3,
									   pk_yr_add1_built_date <= 4          => -2,
									   pk_yr_add1_built_date <= 7          => -1,
									   pk_yr_add1_built_date <= 25         => 0,
									   pk_yr_add1_built_date <= 35         => 1,
									   pk_yr_add1_built_date <= 50         => 2,
																			  3));

		pk_yr_add1_mortgage_date2 :=  __common__(map((real)pk_yr_add1_mortgage_date <= NULL => -1,
										  pk_yr_add1_mortgage_date <= 2          => 0,
										  pk_yr_add1_mortgage_date <= 3          => 1,
																					2));

		pk_add1_mortgage_risk :=  __common__(map(trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 3,
									  trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 3,
									  trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 2,
									  trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 1,
									  trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 0,
									  trim(trim((string)add1_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																														-1));

		pk_add1_adjustable_financing :=  __common__(if(trim(trim((string)add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0));

		pk_add1_assessed_amount2 :=  __common__(map(pk_add1_assessed_amount_2 <= 0      => -1,
										 pk_add1_assessed_amount_2 <= 40000  => 0,
										 pk_add1_assessed_amount_2 <= 60000  => 1,
										 pk_add1_assessed_amount_2 <= 80000  => 2,
										 pk_add1_assessed_amount_2 <= 100000 => 3,
										 pk_add1_assessed_amount_2 <= 140000 => 4,
										 pk_add1_assessed_amount_2 <= 160000 => 5,
																				6));

		pk_yr_add1_date_first_seen2 :=  __common__(map((real)pk_yr_add1_date_first_seen <= NULL => -1,
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
																						10));

		pk_add1_building_area2 :=  __common__(map(pk_add1_building_area <= 0     => -99,
									   pk_add1_building_area <= 900   => -4,
									   pk_add1_building_area <= 1000  => -3,
									   pk_add1_building_area <= 2000  => -2,
									   pk_add1_building_area <= 3000  => -1,
									   pk_add1_building_area <= 5000  => 0,
									   pk_add1_building_area <= 7000  => 1,
									   pk_add1_building_area <= 10000 => 2,
									   pk_add1_building_area <= 30000 => 3,
																		 4));

		pk_add1_no_of_baths :=  __common__(map((integer)add1_no_of_baths <= 0 => -3,
									(integer)add1_no_of_baths <= 1 => -2,
									(integer)add1_no_of_baths <= 2 => -1,
									(integer)add1_no_of_baths <= 3 => 0,
									(integer)add1_no_of_baths <= 5 => 1,
																	  2));

		pk_add1_no_of_partial_baths :=  __common__(if((integer)add1_no_of_partial_baths <= 0, 0, 1));

		pk_property_owned_total :=  __common__(map(property_owned_total <= 0 => -1,
										property_owned_total <= 1 => 0,
										property_owned_total <= 4 => 1,
										property_owned_total <= 6 => 2,
																	 3));

		pk_prop_own_assess_tot2 :=  __common__(map(pk_property_owned_assessed_total_2 <= 0      => 0,
										pk_property_owned_assessed_total_2 <= 80000  => 1,
										pk_property_owned_assessed_total_2 <= 140000 => 2,
										pk_property_owned_assessed_total_2 <= 260000 => 3,
										pk_property_owned_assessed_total_2 <= 260000 => 4,
																						5));

		pk_prop1_sale_price2 :=  __common__(map(pk_prop1_sale_price_2 <= 0     => 0,
									 pk_prop1_sale_price_2 <= 40000 => 1,
																	   2));

		pk_yr_prop1_prev_purchase_date2 :=  __common__(map((real)pk_yr_prop1_prev_purchase_date <= NULL => -1,
												pk_yr_prop1_prev_purchase_date <= 2          => 0,
												pk_yr_prop1_prev_purchase_date <= 3          => 1,
												pk_yr_prop1_prev_purchase_date <= 4          => 2,
												pk_yr_prop1_prev_purchase_date <= 5          => 3,
												pk_yr_prop1_prev_purchase_date <= 7          => 4,
												pk_yr_prop1_prev_purchase_date <= 9          => 5,
												pk_yr_prop1_prev_purchase_date <= 12         => 6,
																								7));

		pk_add2_land_use_cat := __common__((trim((string)add2_land_use_code, LEFT))[1..2]);

		pk_add2_land_use_risk_level :=  __common__(map(trim(trim(pk_add2_land_use_cat, LEFT), LEFT, RIGHT) in ['11', '92', '91']             => 4,
											trim(trim(pk_add2_land_use_cat, LEFT), LEFT, RIGHT) in ['', '20']                     => 3,
											trim(trim(pk_add2_land_use_cat, LEFT), LEFT, RIGHT) in ['30', '05', '10', '80', '00'] => 2,
											trim(trim(pk_add2_land_use_cat, LEFT), LEFT, RIGHT) in ['19']                         => 2,
											trim(trim(pk_add2_land_use_cat, LEFT), LEFT, RIGHT) in ['70']                         => 0,
																																	 3));

		pk_add2_building_area2 :=  __common__(map(pk_add2_building_area <= 0    => -4,
									   pk_add2_building_area <= 900  => -3,
									   pk_add2_building_area <= 1000 => -2,
									   pk_add2_building_area <= 2000 => -1,
									   pk_add2_building_area <= 5000 => 0,
									   pk_add2_building_area <= 7000 => 1,
																		2));

		pk_add2_no_of_baths :=  __common__(map((integer)add2_no_of_baths <= 0 => -3,
									(integer)add2_no_of_baths <= 1 => -2,
									(integer)add2_no_of_baths <= 2 => -1,
									(integer)add2_no_of_baths <= 3 => 0,
									(integer)add2_no_of_baths <= 4 => 1,
																	  2));

		pk_yr_add2_mortgage_date2 :=  __common__(map((real)pk_yr_add2_mortgage_date <= NULL => -1,
										  pk_yr_add2_mortgage_date <= 3          => 0,
																					1));

		pk_add2_mortgage_risk :=  __common__(map(trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 3,
									  trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 3,
									  trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 2,
									  trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 1,
									  trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 0,
									  trim(trim((string)add2_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																														-1));

		pk_yr_add2_mortgage_due_date2 :=  __common__(map((real)pk_yr_add2_mortgage_due_date <= NULL => -1,
											  pk_yr_add2_mortgage_due_date <= -26        => 3,
											  pk_yr_add2_mortgage_due_date <= -23        => 2,
											  pk_yr_add2_mortgage_due_date <= -12        => 1,
																							0));

		pk_add2_assessed_amount2 :=  __common__(map(pk_add2_assessed_amount_2 <= 0      => -1,
										 pk_add2_assessed_amount_2 <= 60000  => 0,
										 pk_add2_assessed_amount_2 <= 100000 => 1,
										 pk_add2_assessed_amount_2 <= 120000 => 2,
										 pk_add2_assessed_amount_2 <= 260000 => 3,
																				4));

		pk_yr_add2_date_first_seen2 :=  __common__(map((real)pk_yr_add2_date_first_seen <= NULL => -1,
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
																						11));

		pk_add3_mortgage_risk :=  __common__(map(trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 5,
									  trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 4,
									  trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 3,
									  trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 2,
									  trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 1,
									  trim(trim((string)add3_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
																														-1));

		pk_add3_adjustable_financing :=  __common__(if(trim(trim((string)add3_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0));

		pk_add3_assessed_amount2 :=  __common__(map(pk_add3_assessed_amount_2 <= 0      => -1,
										 pk_add3_assessed_amount_2 <= 60000  => 0,
										 pk_add3_assessed_amount_2 <= 80000  => 1,
										 pk_add3_assessed_amount_2 <= 140000 => 2,
																				3));

		pk_yr_add3_date_first_seen2 :=  __common__(map((real)pk_yr_add3_date_first_seen <= NULL => -1,
											pk_yr_add3_date_first_seen <= 1          => 0,
											pk_yr_add3_date_first_seen <= 2          => 1,
											pk_yr_add3_date_first_seen <= 3          => 2,
											pk_yr_add3_date_first_seen <= 4          => 3,
											pk_yr_add3_date_first_seen <= 5          => 4,
											pk_yr_add3_date_first_seen <= 8          => 5,
											pk_yr_add3_date_first_seen <= 11         => 6,
											pk_yr_add3_date_first_seen <= 14         => 7,
											pk_yr_add3_date_first_seen <= 18         => 8,
																						9));

		pk_w_count :=  __common__(map(w_count <= 0 => 0,
						   w_count <= 1 => 1,
										   2));

		pk_yr_liens_last_unrel_date := __common__(if (years_liens_last_unrel_date >= 0, roundup(years_liens_last_unrel_date), truncate(years_liens_last_unrel_date)));

		pk_yr_liens_unrel_cj_first_seen := __common__(if (years_liens_unrel_cj_first_seen >= 0, roundup(years_liens_unrel_cj_first_seen), truncate(years_liens_unrel_cj_first_seen)));

		pk_yr_liens_unrel_lt_first_seen := __common__(if (years_liens_unrel_lt_first_seen >= 0, roundup(years_liens_unrel_lt_first_seen), truncate(years_liens_unrel_lt_first_seen)));

		pk_yr_liens_unrel_ot_first_seen := __common__(if (years_liens_unrel_ot_first_seen >= 0, roundup(years_liens_unrel_ot_first_seen), truncate(years_liens_unrel_ot_first_seen)));

		pk_yr_criminal_last_date := __common__(if (years_criminal_last_date >= 0, roundup(years_criminal_last_date), truncate(years_criminal_last_date)));

		pk_yr_felony_last_date := __common__(if (years_felony_last_date >= 0, roundup(years_felony_last_date), truncate(years_felony_last_date)));

		pk_bk_level_2 :=  __common__(map((filing_count >= 2) or (((trim(trim(filing_type, LEFT), LEFT, RIGHT) = '') and (filing_count >= 1)) or ((StringLib.StringToUpperCase(trim(trim(disposition, LEFT), LEFT, RIGHT)) = 'DISMISSED') or (bk_disposed_historical_count >= 2))) => 2,
							  (integer)bk_flag > 0                                                                                                                                                                                                                     => 1,
																																																																		  0));

		pk_liens_unrel_cj_ct :=  __common__(map((integer)liens_unrel_cj_ct <= 0 => 0,
									 (integer)liens_unrel_cj_ct <= 1 => 1,
									 (integer)liens_unrel_cj_ct <= 2 => 2,
									 (integer)liens_unrel_cj_ct <= 3 => 3,
																		4));

		pk_liens_unrel_ft_ct :=  __common__(if((integer)liens_unrel_ft_ct <= 0, 0, 1));

		pk_liens_unrel_lt_ct :=  __common__(if((integer)liens_unrel_lt_ct <= 0, 0, 1));

		pk_liens_unrel_o_ct :=  __common__(if((integer)liens_unrel_o_ct <= 0, 0, 1));

		pk_liens_unrel_ot_ct :=  __common__(if((integer)liens_unrel_ot_ct <= 0, 0, 1));

		pk_liens_unrel_sc_ct :=  __common__(map((integer)liens_unrel_sc_ct <= 0 => 0,
									 (integer)liens_unrel_sc_ct <= 1 => 1,
																		2));

		pk_liens_unrel_count := __common__((liens_recent_unreleased_count + liens_historical_unreleased_ct));

		pk_lien_type_level :=  __common__(map((pk_liens_unrel_cj_ct >= 4) or ((pk_liens_unrel_lt_ct >= 1) or (pk_liens_unrel_sc_ct >= 2)) => 5,
								   (pk_liens_unrel_cj_ct >= 2) or (pk_liens_unrel_sc_ct >= 1)                                  => 4,
								   pk_liens_unrel_cj_ct >= 1                                                                   => 3,
								   (pk_liens_unrel_ft_ct >= 1) or (pk_liens_unrel_ot_ct >= 1)                                  => 2,
								   (pk_liens_unrel_o_ct >= 1) or (pk_liens_unrel_count >= 1)                                   => 1,
																																  0));

		pk_yr_liens_last_unrel_date2 :=  __common__(map((real)pk_yr_liens_last_unrel_date <= NULL => -1,
											 pk_yr_liens_last_unrel_date <= 1          => 0,
											 pk_yr_liens_last_unrel_date <= 2          => 1,
											 pk_yr_liens_last_unrel_date <= 3          => 2,
											 pk_yr_liens_last_unrel_date <= 5          => 3,
																						  4));

		pk_yr_liens_last_unrel_date3 := __common__(pk_yr_liens_last_unrel_date2);

		pk_yr_liens_last_unrel_date3_2 :=  __common__(if((pk_yr_liens_last_unrel_date3 = -1) and lien_flag, -0.5, pk_yr_liens_last_unrel_date3));

		pk_yr_liens_unrel_cj_first_sn2 :=  __common__(map((real)pk_yr_liens_unrel_cj_first_seen <= NULL => -1,
											   pk_yr_liens_unrel_cj_first_seen <= 1          => 0,
											   pk_yr_liens_unrel_cj_first_seen <= 2          => 1,
											   pk_yr_liens_unrel_cj_first_seen <= 4          => 2,
																								3));

		pk_yr_liens_unrel_lt_first_sn2 :=  __common__(map((real)pk_yr_liens_unrel_lt_first_seen <= NULL => -1,
											   pk_yr_liens_unrel_lt_first_seen <= 2          => 0,
																								1));

		pk_yr_liens_unrel_ot_first_sn2 :=  __common__(map((real)pk_yr_liens_unrel_ot_first_seen <= NULL => -1,
											   pk_yr_liens_unrel_ot_first_seen <= 3          => 0,
											   pk_yr_liens_unrel_ot_first_seen <= 5          => 1,
																								2));

		pk_attr_eviction_count :=  __common__(map((integer)attr_eviction_count <= 0 => 0,
									   (integer)attr_eviction_count <= 1 => 1,
									   (integer)attr_eviction_count <= 2 => 2,
																			3));

		pk_eviction_level :=  __common__(map((integer)attr_eviction_count30 > 0  => 7,
								  (integer)attr_eviction_count90 > 0  => 6,
								  (integer)attr_eviction_count180 > 0 => 5,
								  (integer)attr_eviction_count12 > 0  => 4,
								  (integer)attr_eviction_count24 > 0  => 3,
								  (integer)attr_eviction_count36 > 0  => 2,
								  pk_attr_eviction_count >= 3         => 2,
								  (integer)attr_eviction_count60 > 0  => 1,
								  pk_attr_eviction_count >= 1         => 1,
																		 0));

		pk_yr_criminal_last_date2 :=  __common__(map((real)pk_yr_criminal_last_date <= NULL => -1,
										  pk_yr_criminal_last_date <= 1          => 0,
										  pk_yr_criminal_last_date <= 2          => 1,
										  pk_yr_criminal_last_date <= 3          => 2,
										  pk_yr_criminal_last_date <= 5          => 3,
																					4));

		pk_yr_felony_last_date2 :=  __common__(map((real)pk_yr_felony_last_date <= NULL => -1,
										pk_yr_felony_last_date <= 1          => 0,
										pk_yr_felony_last_date <= 2          => 1,
										pk_yr_felony_last_date <= 4          => 2,
																				3));

		pk_attr_total_number_derogs_3 :=  __common__(map((integer)attr_total_number_derogs <= 0 => 0,
											  (integer)attr_total_number_derogs <= 1 => 1,
											  (integer)attr_total_number_derogs <= 2 => 2,
											  (integer)attr_total_number_derogs <= 3 => 3,
																						4));

		pk_yr_rc_ssnhighissue := __common__(if (years_rc_ssnhighissue >= 0, roundup(years_rc_ssnhighissue), truncate(years_rc_ssnhighissue)));

		pk_yr_rc_areacodesplitdate := __common__(if (years_rc_areacodesplitdate >= 0, roundup(years_rc_areacodesplitdate), truncate(years_rc_areacodesplitdate)));

		pk_add_standarization_error :=  __common__(if(trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E', 1, 0));

		pk_addr_changed :=  __common__(if((add_ec1 = 'S') and (add_ec3 != '0'), 1, 0));

		pk_unit_changed :=  __common__(if((add_ec1 = 'S') and (add_ec4 != '0'), 1, 0));

		pk_add_standarization_flag :=  __common__(if((boolean)pk_add_standarization_error or ((boolean)pk_addr_changed or (boolean)pk_unit_changed), 1, 0));

		pk_addr_not_valid :=  __common__(if(trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N', 1, 0));

		pk_corp_mil_zip :=  __common__(if((rc_hriskaddrflag in ['2', '3']) or (rc_ziptypeflag in ['2', '3']), 1, 0));

		pk_area_code_split :=  __common__(if(trim(trim(rc_areacodesplitflag, LEFT), LEFT, RIGHT) = 'Y', 1, 0));

		pk_recent_ac_split :=  __common__(map((pk_yr_rc_areacodesplitdate >= 1) and (pk_yr_rc_areacodesplitdate <= 5) => 1,
								   pk_yr_rc_areacodesplitdate >= 6                                         => -1,
																											  0));

		pk_phn_not_residential := __common__(not(phn_residential));

		pk_disconnected :=  __common__(map(trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'C' => -1,
								phn_disconnected                                => 1,
																				   0));

		pk_phn_cell_pager_inval :=  __common__(if(phn_cellpager or phn_inval, 1, 0));

		pk_yr_rc_ssnhighissue2 :=  __common__(map((real)pk_yr_rc_ssnhighissue = NULL => -1,
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
																			 14));

		pk_pl_sourced_level :=  __common__(map(((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and (((integer)source_fst_PL = 1) and ((integer)prof_license_flag = 1))) => 3,
									((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and ((integer)source_fst_PL = 1))                                        => 2,
									(integer)prof_license_flag = 1                                                                                                          => 2,
									((integer)source_add_PL = 0) and (((integer)source_lst_PL = 0) and ((integer)source_fst_PL = 0))                                        => 0,
																																											   1));

		pk_prof_lic_cat :=  __common__(map(prof_license_category='' => -1,
								(integer)prof_license_category <= 1 => 0,
								(integer)prof_license_category <= 3 => 1,
								(integer)prof_license_category <= 4 => 2,
																	   3));

		pk_attr_num_proflic30 :=  __common__(if((integer)attr_num_proflic30 > 0, 1, 0));

		pk_attr_num_proflic_exp12 :=  __common__(if((integer)attr_num_proflic_exp12 > 0, 1, 0));

		pk_add_lres_month_avg := __common__(if (add_lres_month_avg >= 0, roundup(add_lres_month_avg), truncate(add_lres_month_avg)));

		pk_add1_lres :=  __common__(map((integer)add1_pop = 0 => -2,
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
													  11));

		pk_add2_lres :=  __common__(map((integer)add2_pop = 0 => -2,
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
													  10));

		pk_add3_lres :=  __common__(map((integer)add3_pop = 0 => -2,
							 add3_lres <= 0        => -1,
							 add3_lres <= 35       => 0,
							 add3_lres <= 59       => 1,
							 add3_lres <= 94       => 2,
							 add3_lres <= 119      => 3,
							 add3_lres <= 142      => 4,
							 add3_lres <= 197      => 5,
													  6));

		pk_add1_lres_flag :=  __common__(if(add1_lres > 0, 1, 0));

		pk_add2_lres_flag :=  __common__(if(add2_lres > 0, 1, 0));

		pk_add3_lres_flag :=  __common__(if(add3_lres > 0, 1, 0));

		pk_lres_flag_level :=  __common__(map((boolean)pk_add1_lres_flag and ((boolean)pk_add2_lres_flag or (boolean)pk_add3_lres_flag) => 2,
								   (boolean)pk_add1_lres_flag                                                                => 1,
																																0));

		pk_addrs_5yr :=  __common__(map(addrs_5yr <= 0 => 0,
							 addrs_5yr <= 2 => 1,
							 addrs_5yr <= 4 => 2,
							 addrs_5yr <= 6 => 3,
											   4));

		pk_addrs_10yr :=  __common__(map(addrs_10yr <= 0 => 0,
							  addrs_10yr <= 1 => 1,
							  addrs_10yr <= 6 => 2,
							  addrs_10yr <= 8 => 3,
												 4));

		pk_add_lres_month_avg2 :=  __common__(map((real)pk_add_lres_month_avg <= NULL => -1,
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
																			  17));

		pk_nameperssn_count :=  __common__(map(nameperssn_count <= 0 => 0,
									nameperssn_count <= 1 => 1,
															 2));

		pk_ssns_per_adl :=  __common__(map(ssns_per_adl <= 0 => -1,
								ssns_per_adl <= 1 => 0,
								ssns_per_adl <= 2 => 1,
								ssns_per_adl <= 3 => 2,
								ssns_per_adl <= 4 => 3,
													 4));

		pk_addrs_per_adl :=  __common__(map(addrs_per_adl <= 0  => -6,
								 addrs_per_adl <= 1  => -5,
								 addrs_per_adl <= 2  => -4,
								 addrs_per_adl <= 3  => -3,
								 addrs_per_adl <= 4  => -2,
								 addrs_per_adl <= 5  => -1,
								 addrs_per_adl <= 10 => 0,
								 addrs_per_adl <= 12 => 1,
								 addrs_per_adl <= 18 => 2,
														3));

		pk_phones_per_adl :=  __common__(map(phones_per_adl <= 0 => -1,
								  phones_per_adl <= 1 => 0,
								  phones_per_adl <= 2 => 1,
														 2));

		pk_adlperssn_count :=  __common__(map(adlperssn_count <= 0 => -1,
								   adlperssn_count <= 1 => 0,
								   adlperssn_count <= 2 => 1,
														   2));

		pk_ssns_per_addr2_b1 := __common__(map((ssns_per_addr <= 0) and (pk_add1_unit_count2 = 3)       => 10,
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
																								12));

		pk_ssns_per_addr2_b2 := __common__(map(ssns_per_addr <= 1  => -101,
									ssns_per_addr <= 2  => 100,
									ssns_per_addr <= 3  => 101,
									ssns_per_addr <= 13 => 102,
														   103));

		pk_ssns_per_addr2 := __common__(if((integer)add_apt_2 = 0, pk_ssns_per_addr2_b1, pk_ssns_per_addr2_b2));

		pk_adls_per_phone :=  __common__(map(adls_per_phone <= 0 => -2,
								  adls_per_phone <= 1 => -1,
								  adls_per_phone <= 2 => 0,
														 1));

		pk_ssns_per_adl_c6 :=  __common__(map(ssns_per_adl_c6 <= 0 => 0,
								   ssns_per_adl_c6 <= 1 => 1,
														   2));

		pk_ssns_per_addr_c6_b1 := __common__(map(ssns_per_addr_c6 <= 0 => 0,
									  ssns_per_addr_c6 <= 1 => 1,
									  ssns_per_addr_c6 <= 2 => 2,
									  ssns_per_addr_c6 <= 3 => 3,
									  ssns_per_addr_c6 <= 4 => 4,
									  ssns_per_addr_c6 <= 5 => 5,
															   6));

		pk_ssns_per_addr_c6_b2 := __common__(map(ssns_per_addr_c6 <= 0 => 100,
									  ssns_per_addr_c6 <= 1 => 101,
									  ssns_per_addr_c6 <= 2 => 102,
									  ssns_per_addr_c6 <= 3 => 103,
															   104));

		pk_ssns_per_addr_c6 := __common__(if((integer)add_apt_2 = 0, pk_ssns_per_addr_c6_b1, pk_ssns_per_addr_c6_b2));

		pk_vo_addrs_per_adl :=  __common__(if((integer)vo_addrs_per_adl <= 0, 0, 1));

		pk_attr_addrs_last90 :=  __common__(map((integer)attr_addrs_last90 <= 0 => 0,
									 (integer)attr_addrs_last90 <= 1 => 1,
																		2));

		pk_attr_addrs_last12 :=  __common__(map((integer)attr_addrs_last12 <= 0 => 0,
									 (integer)attr_addrs_last12 <= 1 => 1,
									 (integer)attr_addrs_last12 <= 2 => 2,
									 (integer)attr_addrs_last12 <= 3 => 3,
																		4));

		pk_attr_addrs_last24 :=  __common__(map((integer)attr_addrs_last24 <= 0 => 0,
									 (integer)attr_addrs_last24 <= 1 => 1,
									 (integer)attr_addrs_last24 <= 2 => 2,
									 (integer)attr_addrs_last24 <= 3 => 3,
									 (integer)attr_addrs_last24 <= 5 => 4,
																		5));

		ams_class_n_b8 := __common__((real)ams_class);

		ams_class_n_b8_2 := __common__(if(ams_class_n_b8 >= 60, ams_class_n_b8 + 1900, ams_class_n_b8 + 2000));

		pk_ams_class_level_b8 := __common__(map(((integer)(sysyear - ams_class_n_b8_2) <= 1) => 0,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 2) => 1,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 3) => 2,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 4) => 3,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 5) => 4,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 10) => 5,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 13) => 6,
									 ((integer)(sysyear - ams_class_n_b8_2) <= 17) => 7,
										  8));

		pk_since_ams_class_year := __common__(map(trim(ams_class) = 'GR' => NULL,
									   trim(ams_class) = 'SR' => NULL,
									   trim(ams_class) = 'JR' => NULL,
									   trim(ams_class) = 'SO' => NULL,
									   trim(ams_class) = 'FR' => NULL,
									   trim(ams_class) = 'UN' => NULL,
									   trim(ams_class) = ''   => NULL,
																						  (sysyear - ams_class_n_b8_2)));

		ams_class_n := __common__(map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => NULL,
						   trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => NULL,
																			  ams_class_n_b8_2));

		pk_ams_class_level := __common__(map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => 1000005,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => 1000004,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => 1000003,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => 1000001,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => 1000000,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => 1000002,
								  trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => -1000001,
																					 pk_ams_class_level_b8));

		pk_sl_name_match :=  __common__(if(source_lst_SL and source_fst_SL, 1, 0));

		pk_ams_4yr_college :=  __common__(map((integer)ams_college_code = 4 => 1,
								   (integer)ams_college_code = 2 => -1,
																	0));

		pk_ams_college_type :=  __common__(map(trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'P' => 2,
									trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'S' => 1,
																							 0));

		pk_ams_income_level_code :=  __common__(map(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['A', 'B'] => 0,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['C']      => 1,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['D', 'E'] => 2,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['F']      => 3,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['G', 'H'] => 4,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['I', 'J'] => 5,
										 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['K']      => 6,
																											   -1));

		pk_yr_in_dob := __common__(if (years_in_dob >= 0, roundup(years_in_dob), truncate(years_in_dob)));

		pk_yr_reported_dob := __common__(if (years_reported_dob >= 0, roundup(years_reported_dob), truncate(years_reported_dob)));

		pk_yr_in_dob2 :=  __common__(map(pk_yr_in_dob <= 19 => 19,
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
							  pk_yr_in_dob <= 60 => 60,
							  pk_yr_in_dob <= 63 => 63,
													99));

		pk_ams_age :=  __common__(map(trim(ams_age)='' => -1,
						   (integer)ams_age <= 21 => 21,
						   (integer)ams_age <= 22 => 22,
						   (integer)ams_age <= 23 => 23,
						   (integer)ams_age <= 24 => 24,
						   (integer)ams_age <= 25 => 25,
						   (integer)ams_age <= 29 => 29,
													 99));

		pk_inferred_age :=  __common__(map((integer)inferred_age <= 0  => -1,
								(integer)inferred_age <= 18 => 18,
								(integer)inferred_age <= 19 => 19,
								(integer)inferred_age <= 20 => 20,
								(integer)inferred_age <= 21 => 21,
								(integer)inferred_age <= 22 => 22,
								(integer)inferred_age <= 24 => 24,
								(integer)inferred_age <= 34 => 34,
								(integer)inferred_age <= 37 => 37,
								(integer)inferred_age <= 41 => 41,
								(integer)inferred_age <= 42 => 42,
								(integer)inferred_age <= 43 => 43,
								(integer)inferred_age <= 44 => 44,
								(integer)inferred_age <= 46 => 46,
								(integer)inferred_age <= 48 => 48,
								(integer)inferred_age <= 52 => 52,
								(integer)inferred_age <= 56 => 56,
								(integer)inferred_age <= 59 => 59,
								(integer)inferred_age <= 63 => 63,
															   99));

		pk_yr_reported_dob2 :=  __common__(map((real)pk_yr_reported_dob <= NULL => -1,
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
									pk_yr_reported_dob <= 60         => 60,
									pk_yr_reported_dob <= 63         => 63,
																		99));

		pk_yr_add1_avm_recording_date := __common__(if (years_add1_avm_recording_date >= 0, roundup(years_add1_avm_recording_date), truncate(years_add1_avm_recording_date)));
		pk_yr_add1_avm_assess_year := __common__(if (years_add1_avm_assess_year >= 0, roundup(years_add1_avm_assess_year), truncate(years_add1_avm_assess_year)));
		pk_yr_add2_avm_assess_year := __common__(if (years_add2_avm_assess_year >= 0, roundup(years_add2_avm_assess_year), truncate(years_add2_avm_assess_year)));
		pk_add1_avm_mkt := __common__(if(add1_avm_market_total_value='', NULL, (20000 * if (((real)add1_avm_market_total_value / 20000) >= 0, roundup(((real)add1_avm_market_total_value / 20000)), truncate(((real)add1_avm_market_total_value / 20000))))));
		pk_add1_avm_pi := __common__((20000 * if ((add1_avm_price_index_valuation / 20000) >= 0, roundup((add1_avm_price_index_valuation / 20000)), truncate((add1_avm_price_index_valuation / 20000)))));
		pk_add1_avm_hed := __common__((20000 * if ((add1_avm_hedonic_valuation / 20000) >= 0, roundup((add1_avm_hedonic_valuation / 20000)), truncate((add1_avm_hedonic_valuation / 20000)))));
		pk_add1_avm_auto := __common__((20000 * if ((add1_avm_automated_valuation / 20000) >= 0, roundup((add1_avm_automated_valuation / 20000)), truncate((add1_avm_automated_valuation / 20000)))));
		pk_add1_avm_auto2 := __common__((20000 * if ((add1_avm_automated_valuation_2 / 20000) >= 0, roundup((add1_avm_automated_valuation_2 / 20000)), truncate((add1_avm_automated_valuation_2 / 20000)))));
		pk_add1_avm_auto4 := __common__((20000 * if ((add1_avm_automated_valuation_4 / 20000) >= 0, roundup((add1_avm_automated_valuation_4 / 20000)), truncate((add1_avm_automated_valuation_4 / 20000)))));
		pk_add1_avm_med := __common__((20000 * if ((add1_avm_med / 20000) >= 0, roundup((add1_avm_med / 20000)), truncate((add1_avm_med / 20000)))));
		pk_add2_avm_mkt := __common__(if(add2_avm_market_total_value='', NULL, (20000 * if (((real)add2_avm_market_total_value / 20000) >= 0, roundup(((real)add2_avm_market_total_value / 20000)), truncate(((real)add2_avm_market_total_value / 20000))))));
		pk_add2_avm_pi := __common__((20000 * if ((add2_avm_price_index_valuation / 20000) >= 0, roundup((add2_avm_price_index_valuation / 20000)), truncate((add2_avm_price_index_valuation / 20000)))));
		pk_add2_avm_hed := __common__((20000 * if ((add2_avm_hedonic_valuation / 20000) >= 0, roundup((add2_avm_hedonic_valuation / 20000)), truncate((add2_avm_hedonic_valuation / 20000)))));
		pk_add2_avm_auto := __common__((20000 * if ((add2_avm_automated_valuation / 20000) >= 0, roundup((add2_avm_automated_valuation / 20000)), truncate((add2_avm_automated_valuation / 20000)))));
		pk_add2_avm_auto2 := __common__((20000 * if ((add2_avm_automated_valuation_2 / 20000) >= 0, roundup((add2_avm_automated_valuation_2 / 20000)), truncate((add2_avm_automated_valuation_2 / 20000)))));
		pk_add2_avm_auto4 := __common__((20000 * if ((add2_avm_automated_valuation_4 / 20000) >= 0, roundup((add2_avm_automated_valuation_4 / 20000)), truncate((add2_avm_automated_valuation_4 / 20000)))));
		pk_add1_avm_mkt_2 :=  __common__(if(pk_add1_avm_mkt > 1000000, 1000000, pk_add1_avm_mkt));
		pk_add1_avm_pi_2 :=  __common__(if(pk_add1_avm_pi > 1000000, 1000000, pk_add1_avm_pi));
		pk_add1_avm_hed_2 :=  __common__(if(pk_add1_avm_hed > 1000000, 1000000, pk_add1_avm_hed));
		pk_add1_avm_auto_2 :=  __common__(if(pk_add1_avm_auto > 1000000, 1000000, pk_add1_avm_auto));
		pk_add1_avm_auto2_2 :=  __common__(if(pk_add1_avm_auto2 > 1000000, 1000000, pk_add1_avm_auto2));
		pk_add1_avm_auto4_2 :=  __common__(if(pk_add1_avm_auto4 > 1000000, 1000000, pk_add1_avm_auto4));
		pk_add1_avm_med_2 :=  __common__(if(pk_add1_avm_med > 1000000, 1000000, pk_add1_avm_med));
		pk_add2_avm_mkt_2 :=  __common__(if(pk_add2_avm_mkt > 1000000, 1000000, pk_add2_avm_mkt));
		pk_add2_avm_pi_2 :=  __common__(if(pk_add2_avm_pi > 1000000, 1000000, pk_add2_avm_pi));
		pk_add2_avm_hed_2 :=  __common__(if(pk_add2_avm_hed > 1000000, 1000000, pk_add2_avm_hed));
		pk_add2_avm_auto_2 :=  __common__(if(pk_add2_avm_auto > 1000000, 1000000, pk_add2_avm_auto));
		pk_add2_avm_auto2_2 :=  __common__(if(pk_add2_avm_auto2 > 1000000, 1000000, pk_add2_avm_auto2));
		pk_add2_avm_auto4_2 :=  __common__(if(pk_add2_avm_auto4 > 1000000, 1000000, pk_add2_avm_auto4));
		pk_add1_avm_to_med_ratio := __common__(round(add1_avm_to_med_ratio*10)/10);
		pk_add1_avm_to_med_ratio_2 :=  __common__(if((integer)pk_add1_avm_to_med_ratio > 10, 10, pk_add1_avm_to_med_ratio));

		pk2_add1_avm_mkt :=  __common__(map((real)pk_add1_avm_mkt_2 <= NULL => 1,
								 pk_add1_avm_mkt_2 <= 60000      => 0,
								 pk_add1_avm_mkt_2 <= 80000      => 1,
								 pk_add1_avm_mkt_2 <= 120000     => 2,
								 pk_add1_avm_mkt_2 <= 480000     => 3,
																	4));

		pk2_add1_avm_pi :=  __common__(map(pk_add1_avm_pi_2 <= 0      => 2,
								pk_add1_avm_pi_2 <= 20000  => 0,
								pk_add1_avm_pi_2 <= 120000 => 1,
								pk_add1_avm_pi_2 <= 180000 => 2,
															  3));

		pk2_add1_avm_hed :=  __common__(map(pk_add1_avm_hed_2 <= 0      => 3,
								 pk_add1_avm_hed_2 <= 40000  => 0,
								 pk_add1_avm_hed_2 <= 60000  => 1,
								 pk_add1_avm_hed_2 <= 80000  => 2,
								 pk_add1_avm_hed_2 <= 100000 => 3,
								 pk_add1_avm_hed_2 <= 120000 => 4,
								 pk_add1_avm_hed_2 <= 640000 => 5,
																6));

		pk2_add1_avm_auto2 :=  __common__(map(pk_add1_avm_auto2_2 <= 0      => 4,
								   pk_add1_avm_auto2_2 <= 20000  => 0,
								   pk_add1_avm_auto2_2 <= 40000  => 1,
								   pk_add1_avm_auto2_2 <= 60000  => 2,
								   pk_add1_avm_auto2_2 <= 80000  => 3,
								   pk_add1_avm_auto2_2 <= 120000 => 5,
								   pk_add1_avm_auto2_2 <= 640000 => 6,
																	7));

		pk2_add1_avm_auto4 :=  __common__(map(pk_add1_avm_auto4_2 <= 0      => 3,
								   pk_add1_avm_auto4_2 <= 40000  => 0,
								   pk_add1_avm_auto4_2 <= 60000  => 1,
								   pk_add1_avm_auto4_2 <= 80000  => 2,
								   pk_add1_avm_auto4_2 <= 120000 => 3,
								   pk_add1_avm_auto4_2 <= 240000 => 4,
								   pk_add1_avm_auto4_2 <= 560000 => 5,
																	6));

		pk_avm_auto_diff2 :=  __common__(if((pk_add1_avm_auto_2 = 0) or (pk_add1_avm_auto2_2 = 0), -999999, (pk_add1_avm_auto_2 - pk_add1_avm_auto2_2)));

		pk_avm_auto_diff4 :=  __common__(if((pk_add1_avm_auto_2 = 0) or (pk_add1_avm_auto4_2 = 0), -999999, (pk_add1_avm_auto_2 - pk_add1_avm_auto4_2)));

		pk_avm_auto_diff2_lvl :=  __common__(map(pk_avm_auto_diff2 = -999999 => -2,
									  pk_avm_auto_diff2 < 0       => -1,
									  pk_avm_auto_diff2 = 0       => 0,
									  pk_avm_auto_diff2 <= 40000  => 1,
																	 2));

		pk_avm_auto_diff4_lvl :=  __common__(map(pk_avm_auto_diff4 = -999999 => -1,
									  pk_avm_auto_diff4 <= 80000  => 0,
																	 1));

		pk2_add1_avm_med :=  __common__(map(pk_add1_avm_med_2 <= 0      => 7,
								 pk_add1_avm_med_2 <= 20000  => 0,
								 pk_add1_avm_med_2 <= 40000  => 1,
								 pk_add1_avm_med_2 <= 60000  => 2,
								 pk_add1_avm_med_2 <= 80000  => 3,
								 pk_add1_avm_med_2 <= 120000 => 4,
								 pk_add1_avm_med_2 <= 620000 => 5,
								 pk_add1_avm_med_2 <= 720000 => 6,
																7));

pk2_add1_avm_to_med_ratio :=  __common__(map(pk_add1_avm_to_med_ratio_2 <= NULL => 0,
	(real4)pk_add1_avm_to_med_ratio_2 <= (real4)0.7  => 0,
	(real4)pk_add1_avm_to_med_ratio_2 <= (real4)1.0  => 1,
	(real4)pk_add1_avm_to_med_ratio_2 <= (real4)1.1  => 2,
	(real4)pk_add1_avm_to_med_ratio_2 <= (real4)1.4  => 3,
	(real4)pk_add1_avm_to_med_ratio_2 <= (real4)1.7  => 4,
5));

		pk_add2_avm_hit :=  __common__(if(add2_avm_land_use in ['1', '2'], 1, 0));

		pk_avm_hit_level :=  __common__(map(((integer)add1_AVM_hit > 0) and (pk_add2_avm_hit > 0) => 2,
								 (integer)add1_AVM_hit > 0                             => 1,
								 pk_add2_avm_hit > 0                                   => -1,
																						  0));

		pk2_add2_avm_mkt :=  __common__(map((real)pk_add2_avm_mkt_2 <= NULL => 2,
								 pk_add2_avm_mkt_2 <= 40000      => 0,
								 pk_add2_avm_mkt_2 <= 60000      => 1,
								 pk_add2_avm_mkt_2 <= 100000     => 2,
								 pk_add2_avm_mkt_2 <= 460000     => 3,
																	4));

		pk2_add2_avm_pi :=  __common__(map(pk_add2_avm_pi_2 <= 0      => 2,
								pk_add2_avm_pi_2 <= 40000  => 0,
								pk_add2_avm_pi_2 <= 80000  => 1,
								pk_add2_avm_pi_2 <= 520000 => 3,
															  4));

		pk2_add2_avm_hed :=  __common__(map(pk_add2_avm_hed_2 <= 0      => 3,
								 pk_add2_avm_hed_2 <= 20000  => 0,
								 pk_add2_avm_hed_2 <= 60000  => 1,
								 pk_add2_avm_hed_2 <= 80000  => 2,
								 pk_add2_avm_hed_2 <= 120000 => 4,
								 pk_add2_avm_hed_2 <= 620000 => 5,
																6));

		pk2_add2_avm_auto4 :=  __common__(map(pk_add2_avm_auto4_2 <= 0      => 3,
								   pk_add2_avm_auto4_2 <= 40000  => 0,
								   pk_add2_avm_auto4_2 <= 60000  => 1,
								   pk_add2_avm_auto4_2 <= 80000  => 2,
								   pk_add2_avm_auto4_2 <= 100000 => 3,
								   pk_add2_avm_auto4_2 <= 480000 => 4,
																	5));

		pk_add2_avm_auto_diff2 :=  __common__(if((pk_add2_avm_auto_2 = 0) or (pk_add2_avm_auto2_2 = 0), -999999, (pk_add2_avm_auto_2 - pk_add2_avm_auto2_2)));

		pk_add2_avm_auto_diff2_lvl :=  __common__(map(pk_add2_avm_auto_diff2 = -999999 => -3,
										   pk_add2_avm_auto_diff2 < -40000  => -2,
										   pk_add2_avm_auto_diff2 < -20000  => -1,
										   pk_add2_avm_auto_diff2 = 0       => 0,
																			   1));

		pk2_yr_add1_avm_recording_date :=  __common__(map((real)pk_yr_add1_avm_recording_date <= NULL => 2,
											   pk_yr_add1_avm_recording_date <= 2          => 0,
											   pk_yr_add1_avm_recording_date <= 3          => 1,
											   pk_yr_add1_avm_recording_date <= 5          => 2,
											   pk_yr_add1_avm_recording_date <= 13         => 3,
																							  4));

		pk2_yr_add1_avm_assess_year :=  __common__(map((real)pk_yr_add1_avm_assess_year <= NULL => 0,
											pk_yr_add1_avm_assess_year <= 1          => 1,
																						2));

		pk2_yr_add2_avm_assess_year :=  __common__(map((real)pk_yr_add2_avm_assess_year <= NULL => 0,
											pk_yr_add2_avm_assess_year <= 1          => 1,
																						2));

		pk_dist_a1toa2_2 :=  __common__(map(dist_a1toa2 = 0    => 0,
								 dist_a1toa2 = 9999 => 4,
								 dist_a1toa2 <= 2   => 3,
								 dist_a1toa2 <= 8   => 2,
													   1));

		pk_dist_a1toa3_2 :=  __common__(map(dist_a1toa3 = 0    => 0,
								 dist_a1toa3 = 9999 => 6,
								 dist_a1toa3 <= 1   => 5,
								 dist_a1toa3 <= 2   => 4,
								 dist_a1toa3 <= 4   => 3,
								 dist_a1toa3 <= 40  => 2,
													   1));

		pk_rc_disthphoneaddr_2 :=  __common__(map(rc_disthphoneaddr <= 0   => 0,
									   rc_disthphoneaddr = 9999 => 4,
									   rc_disthphoneaddr <= 6   => 1,
									   rc_disthphoneaddr <= 11  => 2,
																   3));

		pk_out_st_division_lvl :=  __common__(map(trim(trim(out_st, LEFT), LEFT, RIGHT) in ['IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']             => 0,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['IL', 'IN', 'MI', 'OH', 'WI']                         => 1,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY']       => 2,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AL', 'KY', 'MS', 'TN']                               => 3,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV'] => 4,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['NJ', 'NY', 'PA']                                     => 5,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AK', 'CA', 'HI', 'OR', 'WA']                         => 6,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['AR', 'LA', 'OK', 'TX']                               => 7,
									   trim(trim(out_st, LEFT), LEFT, RIGHT) in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'] => 8,
																																		  -1));

		pk_wealth_index_2 :=  __common__(map((integer)wealth_index <= 1 => 0,
								  (integer)wealth_index <= 2 => 1,
								  (integer)wealth_index <= 3 => 2,
								  (integer)wealth_index <= 4 => 3,
																4));

		verfst_p_2 := __common__((nap_summary in [2, 3, 4, 8, 9, 10, 12]));

		verlst_p_2 := __common__((nap_summary in [2, 5, 7, 8, 9, 11, 12]));

		veradd_p_2 := __common__((nap_summary in [3, 5, 6, 8, 10, 11, 12]));

		verphn_p_2 := __common__((nap_summary in [4, 6, 7, 9, 10, 11, 12]));

		pk_impulse_count := __common__(impulse_count);

		pk_impulse_count_2 :=  __common__(if((integer)pk_impulse_count > 2, 2, pk_impulse_count));

		pk_attr_total_number_derogs_4 := __common__(attr_total_number_derogs);

		pk_attr_total_number_derogs_5 :=  __common__(if((integer)pk_attr_total_number_derogs_4 > 3, 3, pk_attr_total_number_derogs_4));

		pk_attr_num_nonderogs90_3 := __common__(attr_num_nonderogs90);

		pk_attr_num_nonderogs90_4 :=  __common__(if((integer)pk_attr_num_nonderogs90_3 > 4, 4, pk_attr_num_nonderogs90_3));

		pk_attr_num_nonderogs90_b := __common__(((10 * (integer)add1_isbestmatch) + pk_attr_num_nonderogs90_4));

		pk_adl_cat_deceased :=  __common__(if(trim(trim((string)adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0));

		bs_own_rent :=  __common__(map((add1_naprop = 4) or (property_owned_total > 0)                                                               => '1 Owner ',
							(trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H') or ((add1_naprop = 1) or ((integer)add1_unit_count > 3)) => '2 Renter',
																																			 '3 Other '));

		bs_attr_derog_flag :=  __common__(if((integer)attr_total_number_derogs > 0, 1, 0));

		bs_attr_eviction_flag :=  __common__(if((integer)attr_eviction_count > 0, 1, 0));

		bs_attr_derog_flag2 :=  __common__(if((bs_attr_derog_flag > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag > 0) or ((pk_impulse_count_2 > 0) or (((integer)bk_flag > 0) or ((pk_adl_cat_deceased > 0) or ((integer)ssn_deceased > 0)))))), 1, 0));

		pk_Segment := __common__('        ');

		pk_segment_2 :=  __common__(if(bs_attr_derog_flag2 = 1, '0 Derog ', bs_own_rent));

		pk_nas_summary_mm_b1_c2_b1 := __common__(map(pk_nas_summary = 0 => 0.1428571429,
										  pk_nas_summary = 1 => 0.1630434783,
																0.1325036344));

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.1491509867,
													pk_rc_dirsaddr_lastscore = 0  => 0.1735886595,
													pk_rc_dirsaddr_lastscore = 1  => 0.1657559199,
																					 0.1116485815));

		pk_adl_score_mm_b1_c2_b1 := __common__(map(pk_adl_score = 0 => 0.1674876847,
															0.1325887037));

		pk_combo_addrscore_mm_b1_c2_b1 := __common__(map(pk_combo_addrscore = 0 => 0.1591804571,
																		0.131612667));

		pk_combo_hphonescore_mm_b1_c2_b1 := __common__(map(pk_combo_hphonescore = 0 => 0.1619295111,
												pk_combo_hphonescore = 1 => 0.1105398458,
																			0.1108242554));

		pk_combo_ssnscore_mm_b1_c2_b1 := __common__(map(pk_combo_ssnscore = -1 => 0.1,
											 pk_combo_ssnscore = 0  => 0.15,
																	   0.1326891768));

		pk_combo_dobscore_mm_b1_c2_b1 := __common__(map(pk_combo_dobscore = -1 => 0.3395904437,
											 pk_combo_dobscore = 0  => 0.1973466003,
											 pk_combo_dobscore = 1  => 0.1222104145,
																	   0.1223519406));

		pk_combo_fnamecount_mm_b1_c2_b1 := __common__(map(pk_combo_fnamecount = 0 => 0.272659176,
											   pk_combo_fnamecount = 1 => 0.1939845475,
											   pk_combo_fnamecount = 2 => 0.1497542135,
											   pk_combo_fnamecount = 3 => 0.1211707613,
																		  0.0951036612));

		pk_rc_fnamecount_mm_b1_c2_b1 := __common__(map(pk_rc_fnamecount = 0 => 0.2603359173,
											pk_rc_fnamecount = 1 => 0.1839601269,
											pk_rc_fnamecount = 2 => 0.1444119989,
																	0.099019088));

		pk_combo_lnamecount_mm_b1_c2_b1 := __common__(map(pk_combo_lnamecount = 0 => 0.2481572482,
											   pk_combo_lnamecount = 1 => 0.2,
											   pk_combo_lnamecount = 2 => 0.1565390894,
											   pk_combo_lnamecount = 3 => 0.1240444252,
																		  0.0947295303));

		pk_rc_phonelnamecount_mm_b1_c2_b1 := __common__(map(pk_rc_phonelnamecount = 0 => 0.160704716,
																			  0.1023725835));

		pk_rc_addrcount_mm_b1_c2_b1 := __common__(map(pk_rc_addrcount = 0 => 0.1681042228,
										   pk_rc_addrcount = 1 => 0.1196006911,
										   pk_rc_addrcount = 2 => 0.0970671712,
																  0.095374072));

		pk_rc_phoneaddr_phonecount_mm_b1_c2_b1 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.1566363351,
																						0.1028539806));

		pk_ver_phncount_mm_b1_c2_b1 := __common__(map(pk_ver_phncount = 0 => 0.1698463826,
										   pk_ver_phncount = 1 => 0.1617546265,
										   pk_ver_phncount = 2 => 0.1199561136,
																  0.0925365608));

		pk_combo_ssncount_mm_b1_c2_b1 := __common__(map(pk_combo_ssncount = -1 => 0.1518987342,
											 pk_combo_ssncount = 0  => 0.1511698388,
																	   0.107520613));

		pk_combo_dobcount_mm_b1_c2_b1 := __common__(map(pk_combo_dobcount = 0 => 0.2912676056,
											 pk_combo_dobcount = 1 => 0.1786649215,
											 pk_combo_dobcount = 2 => 0.1626892481,
											 pk_combo_dobcount = 3 => 0.1390587232,
																	  0.0972057696));

		pk_eq_count_mm_b1_c2_b1 := __common__(map(pk_eq_count = 0 => 0.2345679012,
									   pk_eq_count = 1 => 0.2587991718,
									   pk_eq_count = 2 => 0.2015466409,
									   pk_eq_count = 3 => 0.155,
									   pk_eq_count = 4 => 0.1373074347,
									   pk_eq_count = 5 => 0.1210530379,
														  0.1078604548));

		pk_pos_secondary_sources_mm_b1_c2_b1 := __common__(map(pk_pos_secondary_sources = 0 => 0.1340582302,
													pk_pos_secondary_sources = 1 => 0.099378882,
																					0.0709677419));

		pk_voter_flag_mm_b1_c2_b1 := __common__(map(pk_voter_flag = -1 => 0.1771209866,
										 pk_voter_flag = 0  => 0.1278229449,
															   0.1194677739));

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.1663242344,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.1485022307,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.1184419714,
																							  0.0987432675));

		pk_add1_address_score_mm_b1_c2_b1 := __common__(map(pk_add1_address_score = 0 => 0.1498501499,
																			  0.1315551877));

		pk_add2_address_score_mm_b1_c2_b1 := __common__(map(pk_add2_address_score = 0 => 0.1975460123,
												 pk_add2_address_score = 1 => 0.1308549574,
												 pk_add2_address_score = 2 => 0.1153225806,
																			  0.107372942));

		pk_add2_pos_sources_mm_b1_c2_b1 := __common__(map(pk_add2_pos_sources = 0 => 0.1586345382,
											   pk_add2_pos_sources = 1 => 0.1300102524,
											   pk_add2_pos_sources = 2 => 0.1297006907,
											   pk_add2_pos_sources = 3 => 0.1204968944,
																		  0.1228070175));

		pk_add2_pos_secondary_sources_mm_b1_c2_b1 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.1332558795,
														 pk_add2_pos_secondary_sources = 1 => 0.0545454545,
																							  0.072));

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.132658423,
																							  0.2702702703));

		pk_infutor_risk_lvl_mm_b1_c2_b1 := __common__(map(pk_infutor_risk_lvl = 0 => 0.1186277653,
											   pk_infutor_risk_lvl = 1 => 0.146172976,
																		  0.1971884498));

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b1 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.1387886081,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1712062257,
													pk_yr_adl_vo_first_seen2 = 1  => 0.1191195511,
													pk_yr_adl_vo_first_seen2 = 2  => 0.1312741313,
																					 0.1043021511));

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1343797385,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.140625,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.1203703704,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.1347342398,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.1189575452,
																							   0.0985915493));

		pk_yr_lname_change_date2_mm_b1_c2_b1 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.1328242552,
													pk_yr_lname_change_date2 = 0  => 0.1719242902,
													pk_yr_lname_change_date2 = 1  => 0.1224696356,
																					 0.0952380952));

		pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.1546118115,
													  pk_yr_gong_did_first_seen2 = 0  => 0.1953757225,
													  pk_yr_gong_did_first_seen2 = 1  => 0.1683673469,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1220216606,
													  pk_yr_gong_did_first_seen2 = 3  => 0.1251819505,
																						 0.1102479598));

		pk_yr_header_first_seen2_mm_b1_c2_b1 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.2929171669,
													pk_yr_header_first_seen2 = 0  => 0.2649434572,
													pk_yr_header_first_seen2 = 1  => 0.1988555079,
													pk_yr_header_first_seen2 = 2  => 0.1652673442,
													pk_yr_header_first_seen2 = 3  => 0.1495176849,
													pk_yr_header_first_seen2 = 4  => 0.1153245354,
													pk_yr_header_first_seen2 = 5  => 0.0946643718,
													pk_yr_header_first_seen2 = 6  => 0.0769230769,
																					 0.0803571429));

		pk_yr_infutor_first_seen2_mm_b1_c2_b1 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.1186277653,
													 pk_yr_infutor_first_seen2 = 0  => 0.1563021703,
													 pk_yr_infutor_first_seen2 = 1  => 0.1699716714,
													 pk_yr_infutor_first_seen2 = 2  => 0.1517241379,
													 pk_yr_infutor_first_seen2 = 3  => 0.1617977528,
																					   0.1566951567));

		pk_em_only_ver_lvl_mm_b1_c2_b1 := __common__(map(pk_em_only_ver_lvl = -1 => 0.1820728291,
											  pk_em_only_ver_lvl = 0  => 0.1344603488,
											  pk_em_only_ver_lvl = 1  => 0.1304757419,
											  pk_em_only_ver_lvl = 2  => 0.0997123682,
																		 0.1094793057));

		pk_add2_em_ver_lvl_mm_b1_c2_b1 := __common__(map(pk_add2_em_ver_lvl = -1 => 0.1931818182,
											  pk_add2_em_ver_lvl = 0  => 0.1333309027,
											  pk_add2_em_ver_lvl = 1  => 0.1246200608,
																		 0.1));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1111111111,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.5660377358,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.4096385542,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4171779141,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.3677419355,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.3344947735,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.2738095238,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.2887139108,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.2568306011,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.2295081967,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1977252843,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.1534133533,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1363821968,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1287078934,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1253148615,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1165129925,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0971783835,
																							  0.0814956855));

		pk_nas_summary_mm_b1_c2_b2 := __common__(map(pk_nas_summary = 0 => 0.0842911877,
										  pk_nas_summary = 1 => 0.0493358634,
																0.0359693054));

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.0453263118,
													pk_rc_dirsaddr_lastscore = 0  => 0.059059633,
													pk_rc_dirsaddr_lastscore = 1  => 0.0459440057,
																					 0.0306293565));

		pk_adl_score_mm_b1_c2_b2 := __common__(map(pk_adl_score = 0 => 0.0519125683,
															0.0361620529));

		pk_combo_addrscore_mm_b1_c2_b2 := __common__(map(pk_combo_addrscore = 0 => 0.0592592593,
																		0.0358026612));

		pk_combo_hphonescore_mm_b1_c2_b2 := __common__(map(pk_combo_hphonescore = 0 => 0.0577983778,
												pk_combo_hphonescore = 1 => 0.0313216196,
																			0.0269176815));

		pk_combo_ssnscore_mm_b1_c2_b2 := __common__(map(pk_combo_ssnscore = -1 => 0.1145038168,
											 pk_combo_ssnscore = 0  => 0.0391908976,
																	   0.036065159));

		pk_combo_dobscore_mm_b1_c2_b2 := __common__(map(pk_combo_dobscore = -1 => 0.1026304442,
											 pk_combo_dobscore = 0  => 0.0453153705,
											 pk_combo_dobscore = 1  => 0.0421792619,
																	   0.0334735659));

		pk_combo_fnamecount_mm_b1_c2_b2 := __common__(map(pk_combo_fnamecount = 0 => 0.0807354117,
											   pk_combo_fnamecount = 1 => 0.0436438419,
											   pk_combo_fnamecount = 2 => 0.0380611989,
											   pk_combo_fnamecount = 3 => 0.0355675832,
																		  0.0282660333));

		pk_rc_fnamecount_mm_b1_c2_b2 := __common__(map(pk_rc_fnamecount = 0 => 0.0770282589,
											pk_rc_fnamecount = 1 => 0.0408590572,
											pk_rc_fnamecount = 2 => 0.0358932525,
																	0.0304909184));

		pk_combo_lnamecount_mm_b1_c2_b2 := __common__(map(pk_combo_lnamecount = 0 => 0.1275510204,
											   pk_combo_lnamecount = 1 => 0.0671744097,
											   pk_combo_lnamecount = 2 => 0.0365874705,
											   pk_combo_lnamecount = 3 => 0.0341061265,
																		  0.0272854182));

		pk_rc_phonelnamecount_mm_b1_c2_b2 := __common__(map(pk_rc_phonelnamecount = 0 => 0.0563279289,
																			  0.025506728));

		pk_rc_addrcount_mm_b1_c2_b2 := __common__(map(pk_rc_addrcount = 0 => 0.0462952708,
										   pk_rc_addrcount = 1 => 0.0366470384,
										   pk_rc_addrcount = 2 => 0.0304826418,
																  0.0227309108));

		pk_rc_phoneaddr_phonecount_mm_b1_c2_b2 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.0511740331,
																						0.0262114078));

		pk_ver_phncount_mm_b1_c2_b2 := __common__(map(pk_ver_phncount = 0 => 0.0578532346,
										   pk_ver_phncount = 1 => 0.0463541667,
										   pk_ver_phncount = 2 => 0.0326749573,
																  0.0267938736));

		pk_combo_ssncount_mm_b1_c2_b2 := __common__(map(pk_combo_ssncount = -1 => 0.0849420849,
											 pk_combo_ssncount = 0  => 0.0361506699,
																	   0.0262295082));

		pk_combo_dobcount_mm_b1_c2_b2 := __common__(map(pk_combo_dobcount = 0 => 0.0789473684,
											 pk_combo_dobcount = 1 => 0.0511889036,
											 pk_combo_dobcount = 2 => 0.0380295567,
											 pk_combo_dobcount = 3 => 0.0339622642,
																	  0.0289570745));

		pk_eq_count_mm_b1_c2_b2 := __common__(map(pk_eq_count = 0 => 0.0850515464,
									   pk_eq_count = 1 => 0.0405669599,
									   pk_eq_count = 2 => 0.0349677928,
									   pk_eq_count = 3 => 0.0314531348,
									   pk_eq_count = 4 => 0.0332720963,
									   pk_eq_count = 5 => 0.0359488727,
														  0.0374742705));

		pk_pos_secondary_sources_mm_b1_c2_b2 := __common__(map(pk_pos_secondary_sources = 0 => 0.0368006169,
													pk_pos_secondary_sources = 1 => 0.0178571429,
																					0.0168350168));

		pk_voter_flag_mm_b1_c2_b2 := __common__(map(pk_voter_flag = -1 => 0.057073274,
										 pk_voter_flag = 0  => 0.0339889851,
															   0.0321859199));

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.0567613786,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.0556621881,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0282655963,
																							  0.0251042963));

		pk_add1_address_score_mm_b1_c2_b2 := __common__(map(pk_add1_address_score = 0 => 0.0535011802,
																			  0.03561104));

		pk_add2_address_score_mm_b1_c2_b2 := __common__(map(pk_add2_address_score = 0 => 0.0413971539,
												 pk_add2_address_score = 1 => 0.0363401803,
												 pk_add2_address_score = 2 => 0.0318988865,
																			  0.0327757685));

		pk_add2_pos_sources_mm_b1_c2_b2 := __common__(map(pk_add2_pos_sources = 0 => 0.0320947473,
											   pk_add2_pos_sources = 1 => 0.0361618115,
											   pk_add2_pos_sources = 2 => 0.037443609,
											   pk_add2_pos_sources = 3 => 0.0446754706,
																		  0.0464316423));

		pk_add2_pos_secondary_sources_mm_b1_c2_b2 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.0363908345,
														 pk_add2_pos_secondary_sources = 1 => 0.0196078431,
																							  0.0147928994));

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.0362098421,
																							  0.0675675676));

		pk_infutor_risk_lvl_mm_b1_c2_b2 := __common__(map(pk_infutor_risk_lvl = 0 => 0.028227317,
											   pk_infutor_risk_lvl = 1 => 0.0569511945,
																		  0.0670103093));

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b2 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.0385993272,
													pk_yr_adl_vo_first_seen2 = 0  => 0.0445151033,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0399363564,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0367213115,
																					 0.0252473055));

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0366305703,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.0370751802,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0266781411,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0422794118,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0334889712,
																							   0.0158227848));

		pk_yr_lname_change_date2_mm_b1_c2_b2 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.0363580274,
													pk_yr_lname_change_date2 = 0  => 0.0506550218,
													pk_yr_lname_change_date2 = 1  => 0.0338791643,
																					 0.0175600739));

		pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.0388763959,
													  pk_yr_gong_did_first_seen2 = 0  => 0.0514138817,
													  pk_yr_gong_did_first_seen2 = 1  => 0.0577523413,
													  pk_yr_gong_did_first_seen2 = 2  => 0.0458945859,
													  pk_yr_gong_did_first_seen2 = 3  => 0.043638034,
																						 0.0307556868));

		pk_yr_header_first_seen2_mm_b1_c2_b2 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.0714552937,
													pk_yr_header_first_seen2 = 0  => 0.0775034294,
													pk_yr_header_first_seen2 = 1  => 0.0679862306,
													pk_yr_header_first_seen2 = 2  => 0.051032674,
													pk_yr_header_first_seen2 = 3  => 0.0463000404,
													pk_yr_header_first_seen2 = 4  => 0.031819594,
													pk_yr_header_first_seen2 = 5  => 0.0201156651,
													pk_yr_header_first_seen2 = 6  => 0.0193886861,
																					 0.013233348));

		pk_yr_infutor_first_seen2_mm_b1_c2_b2 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.028227317,
													 pk_yr_infutor_first_seen2 = 0  => 0.0582354411,
													 pk_yr_infutor_first_seen2 = 1  => 0.0656378199,
													 pk_yr_infutor_first_seen2 = 2  => 0.0580503834,
													 pk_yr_infutor_first_seen2 = 3  => 0.0520534862,
																					   0.053593179));

		pk_em_only_ver_lvl_mm_b1_c2_b2 := __common__(map(pk_em_only_ver_lvl = -1 => 0.0489583333,
											  pk_em_only_ver_lvl = 0  => 0.0367182924,
											  pk_em_only_ver_lvl = 1  => 0.040614961,
											  pk_em_only_ver_lvl = 2  => 0.0255449591,
																		 0.0238399319));

		pk_add2_em_ver_lvl_mm_b1_c2_b2 := __common__(map(pk_add2_em_ver_lvl = -1 => 0.037037037,
											  pk_add2_em_ver_lvl = 0  => 0.0362919473,
											  pk_add2_em_ver_lvl = 1  => 0.0455616654,
																		 0.0220183486));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.2105263158,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1923076923,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.125,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.0760869565,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1785714286,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.1046277666,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0930232558,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.078125,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.088,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0720906282,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0723167539,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0624898026,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.050184789,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0418934911,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.038467273,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0293317564,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0219363295,
																							  0.014364249));

		pk_nas_summary_mm_b1_c2_b3 := __common__(map(pk_nas_summary = 0 => 0.171539961,
										  pk_nas_summary = 1 => 0.1225382932,
																0.1208879975));

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.1167993492,
													pk_rc_dirsaddr_lastscore = 0  => 0.1479106551,
													pk_rc_dirsaddr_lastscore = 1  => 0.1559055118,
																					 0.1024819028));

		pk_adl_score_mm_b1_c2_b3 := __common__(map(pk_adl_score = 0 => 0.1464646465,
															0.1214790173));

		pk_combo_addrscore_mm_b1_c2_b3 := __common__(map(pk_combo_addrscore = 0 => 0.1184834123,
																		0.1221851543));

		pk_combo_hphonescore_mm_b1_c2_b3 := __common__(map(pk_combo_hphonescore = 0 => 0.1387195122,
												pk_combo_hphonescore = 1 => 0.1,
																			0.0972156678));

		pk_combo_ssnscore_mm_b1_c2_b3 := __common__(map(pk_combo_ssnscore = -1 => 0.1926605505,
											 pk_combo_ssnscore = 0  => 0.1753794266,
																	   0.120080109));

		pk_combo_dobscore_mm_b1_c2_b3 := __common__(map(pk_combo_dobscore = -1 => 0.1680216802,
											 pk_combo_dobscore = 0  => 0.1529888551,
											 pk_combo_dobscore = 1  => 0.1200850159,
																	   0.0966500973));

		pk_combo_fnamecount_mm_b1_c2_b3 := __common__(map(pk_combo_fnamecount = 0 => 0.1497730711,
											   pk_combo_fnamecount = 1 => 0.126506605,
											   pk_combo_fnamecount = 2 => 0.1054397986,
											   pk_combo_fnamecount = 3 => 0.0684816166,
																		  0.0498687664));

		pk_rc_fnamecount_mm_b1_c2_b3 := __common__(map(pk_rc_fnamecount = 0 => 0.1486656513,
											pk_rc_fnamecount = 1 => 0.1216437459,
											pk_rc_fnamecount = 2 => 0.0884658455,
																	0.0605510142));

		pk_combo_lnamecount_mm_b1_c2_b3 := __common__(map(pk_combo_lnamecount = 0 => 0.1534503121,
											   pk_combo_lnamecount = 1 => 0.1300666547,
											   pk_combo_lnamecount = 2 => 0.1050440744,
											   pk_combo_lnamecount = 3 => 0.0707202505,
																		  0.0480417755));

		pk_rc_phonelnamecount_mm_b1_c2_b3 := __common__(map(pk_rc_phonelnamecount = 0 => 0.1381103408,
																			  0.0757560226));

		pk_rc_addrcount_mm_b1_c2_b3 := __common__(map(pk_rc_addrcount = 0 => 0.135322539,
										   pk_rc_addrcount = 1 => 0.0928328505,
										   pk_rc_addrcount = 2 => 0.0456852792,
																  0.024691358));

		pk_rc_phoneaddr_phonecount_mm_b1_c2_b3 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.1319016125,
																						0.0938033544));

		pk_ver_phncount_mm_b1_c2_b3 := __common__(map(pk_ver_phncount = 0 => 0.1353143931,
										   pk_ver_phncount = 1 => 0.1378858474,
										   pk_ver_phncount = 2 => 0.0998151571,
																  0.0717781403));

		pk_combo_ssncount_mm_b1_c2_b3 := __common__(map(pk_combo_ssncount = -1 => 0.191588785,
											 pk_combo_ssncount = 0  => 0.1208540573,
																	   0.0769230769));

		pk_combo_dobcount_mm_b1_c2_b3 := __common__(map(pk_combo_dobcount = 0 => 0.1668620555,
											 pk_combo_dobcount = 1 => 0.1088322858,
											 pk_combo_dobcount = 2 => 0.1131241238,
											 pk_combo_dobcount = 3 => 0.0818806128,
																	  0.0575048733));

		pk_eq_count_mm_b1_c2_b3 := __common__(map(pk_eq_count = 0 => 0.1896705254,
									   pk_eq_count = 1 => 0.180399805,
									   pk_eq_count = 2 => 0.1374677704,
									   pk_eq_count = 3 => 0.1082089552,
									   pk_eq_count = 4 => 0.099009901,
									   pk_eq_count = 5 => 0.0849245793,
														  0.0749434389));

		pk_pos_secondary_sources_mm_b1_c2_b3 := __common__(map(pk_pos_secondary_sources = 0 => 0.1222456409,
													pk_pos_secondary_sources = 1 => 0.0683229814,
																					0.0395480226));

		pk_voter_flag_mm_b1_c2_b3 := __common__(map(pk_voter_flag = -1 => 0.1579953708,
										 pk_voter_flag = 0  => 0.1136721713,
															   0.0986016127));

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.135047006,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.1587664192,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0694444444,
																							  0.0784947817));

		pk_add1_address_score_mm_b1_c2_b3 := __common__(map(pk_add1_address_score = 0 => 0.1162049522,
																			  0.1231497928));

		pk_add2_address_score_mm_b1_c2_b3 := __common__(map(pk_add2_address_score = 0 => 0.1698187549,
												 pk_add2_address_score = 1 => 0.1095926119,
												 pk_add2_address_score = 2 => 0.1117845118,
																			  0.0893246187));

		pk_add2_pos_sources_mm_b1_c2_b3 := __common__(map(pk_add2_pos_sources = 0 => 0.16643026,
											   pk_add2_pos_sources = 1 => 0.1115839243,
											   pk_add2_pos_sources = 2 => 0.0970309152,
											   pk_add2_pos_sources = 3 => 0.0906210393,
																		  0.0664451827));

		pk_add2_pos_secondary_sources_mm_b1_c2_b3 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.1219047619,
														 pk_add2_pos_secondary_sources = 1 => 0.027027027,
																							  0.0425531915));

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.1212570331,
																							  0.1513761468));

		pk_infutor_risk_lvl_mm_b1_c2_b3 := __common__(map(pk_infutor_risk_lvl = 0 => 0.1155495182,
											   pk_infutor_risk_lvl = 1 => 0.115404837,
																		  0.1549246407));

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b3 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.1285909713,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1478658537,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0931818182,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0936227951,
																					 0.0706994329));

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1243869544,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.1270417423,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.1300578035,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0915576694,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0883874001,
																							   0.0277777778));

		pk_yr_lname_change_date2_mm_b1_c2_b3 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.1211426188,
													pk_yr_lname_change_date2 = 0  => 0.1363095238,
													pk_yr_lname_change_date2 = 1  => 0.119379845,
																					 0.103343465));

		pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.1358402691,
													  pk_yr_gong_did_first_seen2 = 0  => 0.1883948757,
													  pk_yr_gong_did_first_seen2 = 1  => 0.1217838765,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1075347476,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0895869692,
																						 0.0791065038));

		pk_yr_header_first_seen2_mm_b1_c2_b3 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.1475031473,
													pk_yr_header_first_seen2 = 0  => 0.1632345555,
													pk_yr_header_first_seen2 = 1  => 0.1079215116,
													pk_yr_header_first_seen2 = 2  => 0.0960842382,
													pk_yr_header_first_seen2 = 3  => 0.0838287753,
													pk_yr_header_first_seen2 = 4  => 0.0635801152,
													pk_yr_header_first_seen2 = 5  => 0.0653266332,
													pk_yr_header_first_seen2 = 6  => 0.0343137255,
																					 0.0327102804));

		pk_yr_infutor_first_seen2_mm_b1_c2_b3 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.1155495182,
													 pk_yr_infutor_first_seen2 = 0  => 0.1388158912,
													 pk_yr_infutor_first_seen2 = 1  => 0.1246799795,
													 pk_yr_infutor_first_seen2 = 2  => 0.1372397841,
													 pk_yr_infutor_first_seen2 = 3  => 0.131372549,
																					   0.1045016077));

		pk_em_only_ver_lvl_mm_b1_c2_b3 := __common__(map(pk_em_only_ver_lvl = -1 => 0.1266891892,
											  pk_em_only_ver_lvl = 0  => 0.1245192456,
											  pk_em_only_ver_lvl = 1  => 0.1087848933,
											  pk_em_only_ver_lvl = 2  => 0.0831202046,
																		 0.0571428571));

		pk_add2_em_ver_lvl_mm_b1_c2_b3 := __common__(map(pk_add2_em_ver_lvl = -1 => 0.1435185185,
											  pk_add2_em_ver_lvl = 0  => 0.1228601341,
											  pk_add2_em_ver_lvl = 1  => 0.0991471215,
																		 0.0478723404));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1851851852,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.2650273224,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.2094964029,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.1993687533,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1561579258,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.1649085795,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1468164794,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1371929825,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.1112195122,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1079393399,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0949321913,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0942835932,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1090342679,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0879025239,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0751173709,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0674682699,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0419721871,
																							  0.0294906166));

		pk_nas_summary_mm_b1_c2_b4 := __common__(map(pk_nas_summary = 0 => 0.0843537415,
										  pk_nas_summary = 1 => 0.0764790765,
																0.0754130378));

		pk_rc_dirsaddr_lastscore_mm_b1_c2_b4 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.0816835542,
													pk_rc_dirsaddr_lastscore = 0  => 0.1166982922,
													pk_rc_dirsaddr_lastscore = 1  => 0.095014111,
																					 0.0658097528));

		pk_adl_score_mm_b1_c2_b4 := __common__(map(pk_adl_score = 0 => 0.1010452962,
															0.0754121361));

		pk_combo_addrscore_mm_b1_c2_b4 := __common__(map(pk_combo_addrscore = 0 => 0.1054461182,
																		0.0750463127));

		pk_combo_hphonescore_mm_b1_c2_b4 := __common__(map(pk_combo_hphonescore = 0 => 0.1083255194,
												pk_combo_hphonescore = 1 => 0.0799059929,
																			0.0536551769));

		pk_combo_ssnscore_mm_b1_c2_b4 := __common__(map(pk_combo_ssnscore = -1 => 0.0874125874,
											 pk_combo_ssnscore = 0  => 0.0849056604,
																	   0.0752615323));

		pk_combo_dobscore_mm_b1_c2_b4 := __common__(map(pk_combo_dobscore = -1 => 0.1218739851,
											 pk_combo_dobscore = 0  => 0.0997101449,
											 pk_combo_dobscore = 1  => 0.0770186335,
																	   0.0584635924));

		pk_combo_fnamecount_mm_b1_c2_b4 := __common__(map(pk_combo_fnamecount = 0 => 0.1012378162,
											   pk_combo_fnamecount = 1 => 0.0810210172,
											   pk_combo_fnamecount = 2 => 0.0549102429,
											   pk_combo_fnamecount = 3 => 0.0476453274,
																		  0.0301829268));

		pk_rc_fnamecount_mm_b1_c2_b4 := __common__(map(pk_rc_fnamecount = 0 => 0.0998735082,
											pk_rc_fnamecount = 1 => 0.0732591114,
											pk_rc_fnamecount = 2 => 0.0530213588,
																	0.0383172032));

		pk_combo_lnamecount_mm_b1_c2_b4 := __common__(map(pk_combo_lnamecount = 0 => 0.1246209824,
											   pk_combo_lnamecount = 1 => 0.0889896219,
											   pk_combo_lnamecount = 2 => 0.0644829879,
											   pk_combo_lnamecount = 3 => 0.0498909837,
																		  0.0330854065));

		pk_rc_phonelnamecount_mm_b1_c2_b4 := __common__(map(pk_rc_phonelnamecount = 0 => 0.1059452182,
																			  0.0496084489));

		pk_rc_addrcount_mm_b1_c2_b4 := __common__(map(pk_rc_addrcount = 0 => 0.0915828802,
										   pk_rc_addrcount = 1 => 0.0513214935,
										   pk_rc_addrcount = 2 => 0.0369371798,
																  0.0193164933));

		pk_rc_phoneaddr_phonecount_mm_b1_c2_b4 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.0963703193,
																						0.0542237219));

		pk_ver_phncount_mm_b1_c2_b4 := __common__(map(pk_ver_phncount = 0 => 0.1121214962,
										   pk_ver_phncount = 1 => 0.0934103006,
										   pk_ver_phncount = 2 => 0.0598205904,
																  0.0367952522));

		pk_combo_ssncount_mm_b1_c2_b4 := __common__(map(pk_combo_ssncount = -1 => 0.0820143885,
											 pk_combo_ssncount = 0  => 0.0755040164,
																	   0.0593220339));

		pk_combo_dobcount_mm_b1_c2_b4 := __common__(map(pk_combo_dobcount = 0 => 0.1191510576,
											 pk_combo_dobcount = 1 => 0.0710085934,
											 pk_combo_dobcount = 2 => 0.0650514437,
											 pk_combo_dobcount = 3 => 0.0502068015,
																	  0.0365582711));

		pk_eq_count_mm_b1_c2_b4 := __common__(map(pk_eq_count = 0 => 0.0986666667,
									   pk_eq_count = 1 => 0.1021775544,
									   pk_eq_count = 2 => 0.0922394147,
									   pk_eq_count = 3 => 0.0654664484,
									   pk_eq_count = 4 => 0.0607573866,
									   pk_eq_count = 5 => 0.0507904714,
														  0.0439016339));

		pk_pos_secondary_sources_mm_b1_c2_b4 := __common__(map(pk_pos_secondary_sources = 0 => 0.0762585114,
													pk_pos_secondary_sources = 1 => 0.0567010309,
																					0.0217755444));

		pk_voter_flag_mm_b1_c2_b4 := __common__(map(pk_voter_flag = -1 => 0.1092957262,
										 pk_voter_flag = 0  => 0.0695428458,
															   0.0592073958));

		pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.1076057172,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.1037607171,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0456819665,
																							  0.0503850953));

		pk_add1_address_score_mm_b1_c2_b4 := __common__(map(pk_add1_address_score = 0 => 0.0864135864,
																			  0.0751164244));

		pk_add2_address_score_mm_b1_c2_b4 := __common__(map(pk_add2_address_score = 0 => 0.0955414013,
												 pk_add2_address_score = 1 => 0.0678817932,
												 pk_add2_address_score = 2 => 0.0542914172,
																			  0.0537678208));

		pk_add2_pos_sources_mm_b1_c2_b4 := __common__(map(pk_add2_pos_sources = 0 => 0.0941151133,
											   pk_add2_pos_sources = 1 => 0.0664886991,
											   pk_add2_pos_sources = 2 => 0.0611848495,
											   pk_add2_pos_sources = 3 => 0.0528691167,
																		  0.0404040404));

		pk_add2_pos_secondary_sources_mm_b1_c2_b4 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.0756927148,
														 pk_add2_pos_secondary_sources = 1 => 0.0701754386,
																							  0.0320512821));

		pk_ssnchar_invalid_or_recent_mm_b1_c2_b4 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.0754268803,
																							  0.1024590164));

		pk_infutor_risk_lvl_mm_b1_c2_b4 := __common__(map(pk_infutor_risk_lvl = 0 => 0.0643946526,
											   pk_infutor_risk_lvl = 1 => 0.0963289562,
																		  0.1251564456));

		pk_yr_adl_vo_first_seen2_mm_b1_c2_b4 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.0796805854,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1084420041,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0670138889,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0574324324,
																					 0.042462368));

		pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0783990505,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.0626992561,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0647482014,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0564440263,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0487646294,
																							   0));

		pk_yr_lname_change_date2_mm_b1_c2_b4 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.0756262243,
													pk_yr_lname_change_date2 = 0  => 0.0877313228,
													pk_yr_lname_change_date2 = 1  => 0.0739299611,
																					 0.0453074434));

		pk_yr_gong_did_first_seen2_mm_b1_c2_b4 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.0852615914,
													  pk_yr_gong_did_first_seen2 = 0  => 0.1245791246,
													  pk_yr_gong_did_first_seen2 = 1  => 0.0967741935,
													  pk_yr_gong_did_first_seen2 = 2  => 0.0799640611,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0555555556,
																						 0.0462590507));

		pk_yr_header_first_seen2_mm_b1_c2_b4 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.1002305545,
													pk_yr_header_first_seen2 = 0  => 0.1064883606,
													pk_yr_header_first_seen2 = 1  => 0.0703125,
													pk_yr_header_first_seen2 = 2  => 0.0512960735,
													pk_yr_header_first_seen2 = 3  => 0.0483693661,
													pk_yr_header_first_seen2 = 4  => 0.0416513085,
													pk_yr_header_first_seen2 = 5  => 0.0262096774,
													pk_yr_header_first_seen2 = 6  => 0.0255319149,
																					 0.0125448029));

		pk_yr_infutor_first_seen2_mm_b1_c2_b4 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.0643946526,
													 pk_yr_infutor_first_seen2 = 0  => 0.1153846154,
													 pk_yr_infutor_first_seen2 = 1  => 0.0987893462,
													 pk_yr_infutor_first_seen2 = 2  => 0.0909712722,
													 pk_yr_infutor_first_seen2 = 3  => 0.0857908847,
																					   0.1053097345));

		pk_em_only_ver_lvl_mm_b1_c2_b4 := __common__(map(pk_em_only_ver_lvl = -1 => 0.1016260163,
											  pk_em_only_ver_lvl = 0  => 0.0785509167,
											  pk_em_only_ver_lvl = 1  => 0.0615436926,
											  pk_em_only_ver_lvl = 2  => 0.0403321471,
																		 0.0361842105));

		pk_add2_em_ver_lvl_mm_b1_c2_b4 := __common__(map(pk_add2_em_ver_lvl = -1 => 0.1428571429,
											  pk_add2_em_ver_lvl = 0  => 0.0762544212,
											  pk_add2_em_ver_lvl = 1  => 0.0530973451,
																		 0.0400696864));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.097799511,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1586592179,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1413589688,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.116903028,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1296558227,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.1100055279,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0846681922,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0886803874,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0836267606,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0811791383,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0849182963,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0722021661,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.069286872,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0605555556,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0430705106,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0334740651,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0256101235,
																							  0.0105042017));

		pk_add2_pos_secondary_sources_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_pos_secondary_sources_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_add2_pos_secondary_sources_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_add2_pos_secondary_sources_mm_b1_c2_b3,
																				pk_add2_pos_secondary_sources_mm_b1_c2_b4));

		pk_yr_infutor_first_seen2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_infutor_first_seen2_mm_b1_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_infutor_first_seen2_mm_b1_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_infutor_first_seen2_mm_b1_c2_b3,
																			pk_yr_infutor_first_seen2_mm_b1_c2_b4));

		pk_yr_lname_change_date2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_lname_change_date2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_lname_change_date2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_lname_change_date2_mm_b1_c2_b3,
																		   pk_yr_lname_change_date2_mm_b1_c2_b4));

		pk_ssnchar_invalid_or_recent_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b1,
												  pk_segment_2 = '1 Owner ' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b2,
												  pk_segment_2 = '2 Renter' => pk_ssnchar_invalid_or_recent_mm_b1_c2_b3,
																			   pk_ssnchar_invalid_or_recent_mm_b1_c2_b4));

		pk_adl_score_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_adl_score_mm_b1_c2_b1,
								  pk_segment_2 = '1 Owner ' => pk_adl_score_mm_b1_c2_b2,
								  pk_segment_2 = '2 Renter' => pk_adl_score_mm_b1_c2_b3,
															   pk_adl_score_mm_b1_c2_b4));

		pk_rc_phonelnamecount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_phonelnamecount_mm_b1_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_rc_phonelnamecount_mm_b1_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_rc_phonelnamecount_mm_b1_c2_b3,
																		pk_rc_phonelnamecount_mm_b1_c2_b4));

		pk_rc_dirsaddr_lastscore_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_rc_dirsaddr_lastscore_mm_b1_c2_b3,
																		   pk_rc_dirsaddr_lastscore_mm_b1_c2_b4));

		pk_combo_ssncount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_ssncount_mm_b1_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssncount_mm_b1_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssncount_mm_b1_c2_b3,
																	pk_combo_ssncount_mm_b1_c2_b4));

		pk_yr_adl_vo_first_seen2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_adl_vo_first_seen2_mm_b1_c2_b3,
																		   pk_yr_adl_vo_first_seen2_mm_b1_c2_b4));

		pk_pos_secondary_sources_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b1_c2_b3,
																		   pk_pos_secondary_sources_mm_b1_c2_b4));

		pk_combo_addrscore_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_addrscore_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_combo_addrscore_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_combo_addrscore_mm_b1_c2_b3,
																	 pk_combo_addrscore_mm_b1_c2_b4));

		pk_voter_flag_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b1_c2_b1,
								   pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b1_c2_b2,
								   pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b1_c2_b3,
																pk_voter_flag_mm_b1_c2_b4));

		pk_add2_address_score_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_address_score_mm_b1_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_address_score_mm_b1_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_address_score_mm_b1_c2_b3,
																		pk_add2_address_score_mm_b1_c2_b4));

		pk_rc_fnamecount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_fnamecount_mm_b1_c2_b1,
									  pk_segment_2 = '1 Owner ' => pk_rc_fnamecount_mm_b1_c2_b2,
									  pk_segment_2 = '2 Renter' => pk_rc_fnamecount_mm_b1_c2_b3,
																   pk_rc_fnamecount_mm_b1_c2_b4));

		pk_combo_ssnscore_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_ssnscore_mm_b1_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssnscore_mm_b1_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssnscore_mm_b1_c2_b3,
																	pk_combo_ssnscore_mm_b1_c2_b4));

		pk_lname_eda_sourced_type_lvl_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3,
																				pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4));

		pk_combo_dobscore_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_dobscore_mm_b1_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_dobscore_mm_b1_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_dobscore_mm_b1_c2_b3,
																	pk_combo_dobscore_mm_b1_c2_b4));

		pk_ver_phncount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_ver_phncount_mm_b1_c2_b1,
									 pk_segment_2 = '1 Owner ' => pk_ver_phncount_mm_b1_c2_b2,
									 pk_segment_2 = '2 Renter' => pk_ver_phncount_mm_b1_c2_b3,
																  pk_ver_phncount_mm_b1_c2_b4));

		pk_combo_dobcount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_dobcount_mm_b1_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_dobcount_mm_b1_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_dobcount_mm_b1_c2_b3,
																	pk_combo_dobcount_mm_b1_c2_b4));

		pk_rc_phoneaddr_phonecount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_phoneaddr_phonecount_mm_b1_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_rc_phoneaddr_phonecount_mm_b1_c2_b2,
												pk_segment_2 = '2 Renter' => pk_rc_phoneaddr_phonecount_mm_b1_c2_b3,
																			 pk_rc_phoneaddr_phonecount_mm_b1_c2_b4));

		pk_nas_summary_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_nas_summary_mm_b1_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nas_summary_mm_b1_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nas_summary_mm_b1_c2_b3,
																 pk_nas_summary_mm_b1_c2_b4));

		pk_rc_addrcount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_addrcount_mm_b1_c2_b1,
									 pk_segment_2 = '1 Owner ' => pk_rc_addrcount_mm_b1_c2_b2,
									 pk_segment_2 = '2 Renter' => pk_rc_addrcount_mm_b1_c2_b3,
																  pk_rc_addrcount_mm_b1_c2_b4));

		pk_yr_gong_did_first_seen2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b2,
												pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b1_c2_b3,
																			 pk_yr_gong_did_first_seen2_mm_b1_c2_b4));

		pk_combo_hphonescore_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_hphonescore_mm_b1_c2_b1,
										  pk_segment_2 = '1 Owner ' => pk_combo_hphonescore_mm_b1_c2_b2,
										  pk_segment_2 = '2 Renter' => pk_combo_hphonescore_mm_b1_c2_b3,
																	   pk_combo_hphonescore_mm_b1_c2_b4));

		pk_yr_adl_em_only_first_seen2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3,
																				pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4));

		pk_add2_em_ver_lvl_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_em_ver_lvl_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_add2_em_ver_lvl_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_add2_em_ver_lvl_mm_b1_c2_b3,
																	 pk_add2_em_ver_lvl_mm_b1_c2_b4));

		pk_combo_lnamecount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_lnamecount_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_combo_lnamecount_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_combo_lnamecount_mm_b1_c2_b3,
																	  pk_combo_lnamecount_mm_b1_c2_b4));

		pk_eq_count_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_eq_count_mm_b1_c2_b1,
								 pk_segment_2 = '1 Owner ' => pk_eq_count_mm_b1_c2_b2,
								 pk_segment_2 = '2 Renter' => pk_eq_count_mm_b1_c2_b3,
															  pk_eq_count_mm_b1_c2_b4));

		pk_yr_header_first_seen2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_header_first_seen2_mm_b1_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_header_first_seen2_mm_b1_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_header_first_seen2_mm_b1_c2_b3,
																		   pk_yr_header_first_seen2_mm_b1_c2_b4));

		pk_em_only_ver_lvl_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_em_only_ver_lvl_mm_b1_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_em_only_ver_lvl_mm_b1_c2_b2,
										pk_segment_2 = '2 Renter' => pk_em_only_ver_lvl_mm_b1_c2_b3,
																	 pk_em_only_ver_lvl_mm_b1_c2_b4));

		pk_add1_address_score_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_address_score_mm_b1_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_address_score_mm_b1_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_address_score_mm_b1_c2_b3,
																		pk_add1_address_score_mm_b1_c2_b4));

		pk_combo_fnamecount_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_fnamecount_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_combo_fnamecount_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_combo_fnamecount_mm_b1_c2_b3,
																	  pk_combo_fnamecount_mm_b1_c2_b4));

		pk_add2_pos_sources_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b1_c2_b3,
																	  pk_add2_pos_sources_mm_b1_c2_b4));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3,
																			pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4));

		pk_infutor_risk_lvl_mm_b1 := __common__(map(pk_segment_2 = '0 Derog ' => pk_infutor_risk_lvl_mm_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_infutor_risk_lvl_mm_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_infutor_risk_lvl_mm_b1_c2_b3,
																	  pk_infutor_risk_lvl_mm_b1_c2_b4));

		pk_nas_summary_mm_b2_c2_b1 := __common__(map(pk_nas_summary = 0 => 0.2290502793,
										  pk_nas_summary = 1 => 0.2768256334,
																0.1623376623));

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.2030642023,
													pk_rc_dirsaddr_lastscore = 0  => 0.2658146965,
													pk_rc_dirsaddr_lastscore = 1  => 0.2384615385,
																					 0.1594098597));

		pk_adl_score_mm_b2_c2_b1 := __common__(map(pk_adl_score = 0 => 0.140625,
															0.2027611044));

		pk_combo_addrscore_mm_b2_c2_b1 := __common__(map(pk_combo_addrscore = 0 => 0.2515337423,
																		0.1723446894));

		pk_combo_hphonescore_mm_b2_c2_b1 := __common__(map(pk_combo_hphonescore = 0 => 0.2433419244,
												pk_combo_hphonescore = 1 => 0.1617647059,
																			0.1504401864));

		pk_combo_ssnscore_mm_b2_c2_b1 := __common__(map(pk_combo_ssnscore = -1 => 0.2378378378,
											 pk_combo_ssnscore = 0  => 0.256097561,
																	   0.198405886));

		pk_combo_dobscore_mm_b2_c2_b1 := __common__(map(pk_combo_dobscore = -1 => 0.4156378601,
											 pk_combo_dobscore = 0  => 0.2231884058,
											 pk_combo_dobscore = 1  => 0.18,
																	   0.1790072102));

		pk_combo_fnamecount_nb_mm_b2_c2_b1 := __common__(map(pk_combo_fnamecount_nb = 0 => 0.3577863578,
												  pk_combo_fnamecount_nb = 1 => 0.2917293233,
												  pk_combo_fnamecount_nb = 2 => 0.214050494,
												  pk_combo_fnamecount_nb = 3 => 0.1717990276,
												  pk_combo_fnamecount_nb = 4 => 0.1415220294,
												  pk_combo_fnamecount_nb = 5 => 0.1232349166,
																				0.0812854442));

		pk_rc_fnamecount_nb_mm_b2_c2_b1 := __common__(map(pk_rc_fnamecount_nb = 0 => 0.348977136,
											   pk_rc_fnamecount_nb = 1 => 0.2851458886,
											   pk_rc_fnamecount_nb = 2 => 0.1976689977,
											   pk_rc_fnamecount_nb = 3 => 0.1579696395,
											   pk_rc_fnamecount_nb = 4 => 0.1338842975,
											   pk_rc_fnamecount_nb = 5 => 0.1167608286,
																		  0.0948616601));

		pk_rc_phonelnamecount_mm_b2_c2_b1 := __common__(map(pk_rc_phonelnamecount = 0 => 0.2412006432,
																			  0.1254600201));

		pk_combo_addrcount_nb_mm_b2_c2_b1 := __common__(map(pk_combo_addrcount_nb = 0 => 0.2664670659,
												 pk_combo_addrcount_nb = 1 => 0.2327738516,
												 pk_combo_addrcount_nb = 2 => 0.1735751295,
												 pk_combo_addrcount_nb = 3 => 0.1286735504,
												 pk_combo_addrcount_nb = 4 => 0.1052631579,
																			  0.08));

		pk_rc_addrcount_nb_mm_b2_c2_b1 := __common__(map(pk_rc_addrcount_nb = 0 => 0.2722129784,
											  pk_rc_addrcount_nb = 1 => 0.1662274096,
																		0.0892193309));

		pk_rc_phoneaddr_phonecount_mm_b2_c2_b1 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.2180603046,
																						0.1496282528));

		pk_ver_phncount_mm_b2_c2_b1 := __common__(map(pk_ver_phncount = 0 => 0.2527386541,
										   pk_ver_phncount = 1 => 0.2194955692,
										   pk_ver_phncount = 2 => 0.1368171021,
																  0.1237288136));

		pk_combo_ssncount_mm_b2_c2_b1 := __common__(map(pk_combo_ssncount = -1 => 0.2215384615,
											 pk_combo_ssncount = 0  => 0.233942362,
																	   0.1392276423));

		pk_combo_dobcount_nb_mm_b2_c2_b1 := __common__(map(pk_combo_dobcount_nb = 0 => 0.3538175047,
												pk_combo_dobcount_nb = 1 => 0.2379471229,
												pk_combo_dobcount_nb = 2 => 0.2598870056,
												pk_combo_dobcount_nb = 3 => 0.188738269,
												pk_combo_dobcount_nb = 4 => 0.1546875,
												pk_combo_dobcount_nb = 5 => 0.1275831087,
												pk_combo_dobcount_nb = 6 => 0.1046770601,
																			0.0956521739));

		pk_eq_count_mm_b2_c2_b1 := __common__(map(pk_eq_count = 0 => 0.2746478873,
									   pk_eq_count = 1 => 0.3723849372,
									   pk_eq_count = 2 => 0.3497884344,
									   pk_eq_count = 3 => 0.2115869018,
									   pk_eq_count = 4 => 0.2245430809,
									   pk_eq_count = 5 => 0.1832520792,
														  0.1446629213));

		pk_pos_secondary_sources_mm_b2_c2_b1 := __common__(map(pk_pos_secondary_sources = 0 => 0.2032123736,
													pk_pos_secondary_sources = 1 => 0.0882352941,
																					0.0973451327));

		pk_voter_flag_mm_b2_c2_b1 := __common__(map(pk_voter_flag = -1 => 0.2642857143,
										 pk_voter_flag = 0  => 0.1881238802,
															   0.1857279388));

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.248266607,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.2131438721,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.1169154229,
																							  0.131239484));

		pk_add1_address_score_mm_b2_c2_b1 := __common__(map(pk_add1_address_score = 0 => 0.2553699284,
																			  0.1582554517));

		pk_add2_address_score_mm_b2_c2_b1 := __common__(map(pk_add2_address_score = 0 => 0.1211072664,
												 pk_add2_address_score = 1 => 0.2096994536,
												 pk_add2_address_score = 2 => 0.1570438799,
																			  0.1599264706));

		pk_add2_pos_sources_mm_b2_c2_b1 := __common__(map(pk_add2_pos_sources = 0 => 0.1628392484,
											   pk_add2_pos_sources = 1 => 0.222262641,
											   pk_add2_pos_sources = 2 => 0.2147058824,
											   pk_add2_pos_sources = 3 => 0.1422558923,
																		  0.1221374046));

		pk_add2_pos_secondary_sources_mm_b2_c2_b1 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.2018982892,
														 pk_add2_pos_secondary_sources = 1 => 0.0416666667,
																							  0.0357142857));

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.2010780408,
																							  0.1730769231));

		pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := __common__(map(pk_infutor_risk_lvl_nb = 0 => 0.1631477927,
												  pk_infutor_risk_lvl_nb = 1 => 0.1957202505,
												  pk_infutor_risk_lvl_nb = 2 => 0.1850789096,
																				0.27843987));

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b1 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.2075595727,
													pk_yr_adl_vo_first_seen2 = 0  => 0.2702702703,
													pk_yr_adl_vo_first_seen2 = 1  => 0.1737931034,
													pk_yr_adl_vo_first_seen2 = 2  => 0.1770114943,
																					 0.1676587302));

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.2043959121,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.2167832168,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.2097560976,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.1633333333,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.1737451737,
																							   0.3888888889));

		pk_yr_lname_change_date2_mm_b2_c2_b1 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.1969121741,
													pk_yr_lname_change_date2 = 0  => 0.2916666667,
													pk_yr_lname_change_date2 = 1  => 0.237388724,
																					 0.2129032258));

		pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.232730507,
													  pk_yr_gong_did_first_seen2 = 0  => 0.2953020134,
													  pk_yr_gong_did_first_seen2 = 1  => 0.2483221477,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1856823266,
													  pk_yr_gong_did_first_seen2 = 3  => 0.1937406855,
																						 0.1614747071));

		pk_yr_header_first_seen2_mm_b2_c2_b1 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.3693693694,
													pk_yr_header_first_seen2 = 0  => 0.3919413919,
													pk_yr_header_first_seen2 = 1  => 0.328358209,
													pk_yr_header_first_seen2 = 2  => 0.2813211845,
													pk_yr_header_first_seen2 = 3  => 0.2098092643,
													pk_yr_header_first_seen2 = 4  => 0.1524230847,
													pk_yr_header_first_seen2 = 5  => 0.1160092807,
													pk_yr_header_first_seen2 = 6  => 0.1141732283,
																					 0.1016042781));

		pk_yr_infutor_first_seen2_mm_b2_c2_b1 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.1957202505,
													 pk_yr_infutor_first_seen2 = 0  => 0.2250847458,
													 pk_yr_infutor_first_seen2 = 1  => 0.2172011662,
													 pk_yr_infutor_first_seen2 = 2  => 0.202166065,
													 pk_yr_infutor_first_seen2 = 3  => 0.1898734177,
																					   0.1104294479));

		pk_em_only_ver_lvl_mm_b2_c2_b1 := __common__(map(pk_em_only_ver_lvl = -1 => 0.2647058824,
											  pk_em_only_ver_lvl = 0  => 0.20416784,
											  pk_em_only_ver_lvl = 1  => 0.183625731,
											  pk_em_only_ver_lvl = 2  => 0.1930501931,
																		 0.1529850746));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.2337662338,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3636363636,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.488372093,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.4567901235,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.6081081081,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.4470588235,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.4554455446,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.4042553191,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.3406593407,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.3316062176,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.2967625899,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.2584514722,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1981845688,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.2086956522,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1397228637,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.1512791991,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.1171407186,
																							  0.0843881857));

		pk_nas_summary_mm_b2_c2_b2 := __common__(map(pk_nas_summary = 0 => 0.0924214418,
										  pk_nas_summary = 1 => 0.0759141494,
																0.0519305019));

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.0579060595,
													pk_rc_dirsaddr_lastscore = 0  => 0.1084425036,
													pk_rc_dirsaddr_lastscore = 1  => 0.087962963,
																					 0.046087374));

		pk_adl_score_mm_b2_c2_b2 := __common__(map(pk_adl_score = 0 => 0.0640394089,
															0.0579688209));

		pk_combo_addrscore_mm_b2_c2_b2 := __common__(map(pk_combo_addrscore = 0 => 0.0729001585,
																		0.0534983434));

		pk_combo_hphonescore_mm_b2_c2_b2 := __common__(map(pk_combo_hphonescore = 0 => 0.0864896525,
												pk_combo_hphonescore = 1 => 0.04,
																			0.0405156538));

		pk_combo_ssnscore_mm_b2_c2_b2 := __common__(map(pk_combo_ssnscore = -1 => 0.0947136564,
											 pk_combo_ssnscore = 0  => 0.0432692308,
																	   0.056997256));

		pk_combo_dobscore_mm_b2_c2_b2 := __common__(map(pk_combo_dobscore = -1 => 0.1135857461,
											 pk_combo_dobscore = 0  => 0.0934343434,
											 pk_combo_dobscore = 1  => 0.0599078341,
																	   0.0525280178));

		pk_combo_fnamecount_nb_mm_b2_c2_b2 := __common__(map(pk_combo_fnamecount_nb = 0 => 0.0969101124,
												  pk_combo_fnamecount_nb = 1 => 0.0660660661,
												  pk_combo_fnamecount_nb = 2 => 0.0638935108,
												  pk_combo_fnamecount_nb = 3 => 0.0558166863,
												  pk_combo_fnamecount_nb = 4 => 0.0479820628,
												  pk_combo_fnamecount_nb = 5 => 0.0451448041,
																				0.0249554367));

		pk_rc_fnamecount_nb_mm_b2_c2_b2 := __common__(map(pk_rc_fnamecount_nb = 0 => 0.100792752,
											   pk_rc_fnamecount_nb = 1 => 0.0573975045,
											   pk_rc_fnamecount_nb = 2 => 0.058360352,
											   pk_rc_fnamecount_nb = 3 => 0.0561612157,
											   pk_rc_fnamecount_nb = 4 => 0.0512658228,
											   pk_rc_fnamecount_nb = 5 => 0.0361247947,
																		  0.0205128205));

		pk_rc_phonelnamecount_mm_b2_c2_b2 := __common__(map(pk_rc_phonelnamecount = 0 => 0.0839567747,
																			  0.0370170224));

		pk_combo_addrcount_nb_mm_b2_c2_b2 := __common__(map(pk_combo_addrcount_nb = 0 => 0.0799265044,
												 pk_combo_addrcount_nb = 1 => 0.0726216412,
												 pk_combo_addrcount_nb = 2 => 0.0601127113,
												 pk_combo_addrcount_nb = 3 => 0.0421377184,
												 pk_combo_addrcount_nb = 4 => 0.0425280567,
																			  0.0264705882));

		pk_rc_addrcount_nb_mm_b2_c2_b2 := __common__(map(pk_rc_addrcount_nb = 0 => 0.0791652865,
											  pk_rc_addrcount_nb = 1 => 0.0536494074,
																		0.0307692308));

		pk_rc_phoneaddr_phonecount_mm_b2_c2_b2 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.0691868759,
																						0.0393606394));

		pk_ver_phncount_mm_b2_c2_b2 := __common__(map(pk_ver_phncount = 0 => 0.0902173913,
										   pk_ver_phncount = 1 => 0.0598503741,
										   pk_ver_phncount = 2 => 0.0469064105,
																  0.0359447005));

		pk_combo_ssncount_mm_b2_c2_b2 := __common__(map(pk_combo_ssncount = -1 => 0.0943396226,
											 pk_combo_ssncount = 0  => 0.0565224208,
																	   0.0610687023));

		pk_combo_dobcount_nb_mm_b2_c2_b2 := __common__(map(pk_combo_dobcount_nb = 0 => 0.1074188563,
												pk_combo_dobcount_nb = 1 => 0.0745156483,
												pk_combo_dobcount_nb = 2 => 0.0550161812,
												pk_combo_dobcount_nb = 3 => 0.0531412963,
												pk_combo_dobcount_nb = 4 => 0.0533049041,
												pk_combo_dobcount_nb = 5 => 0.0484550562,
												pk_combo_dobcount_nb = 6 => 0.0331491713,
																			0.0174418605));

		pk_eq_count_mm_b2_c2_b2 := __common__(map(pk_eq_count = 0 => 0.091588785,
									   pk_eq_count = 1 => 0.0936902486,
									   pk_eq_count = 2 => 0.0683520599,
									   pk_eq_count = 3 => 0.0415472779,
									   pk_eq_count = 4 => 0.0498132005,
									   pk_eq_count = 5 => 0.0540321272,
														  0.0567962503));

		pk_pos_secondary_sources_mm_b2_c2_b2 := __common__(map(pk_pos_secondary_sources = 0 => 0.0588462728,
													pk_pos_secondary_sources = 1 => 0.0253164557,
																					0.0428134557));

		pk_voter_flag_mm_b2_c2_b2 := __common__(map(pk_voter_flag = -1 => 0.0805369128,
										 pk_voter_flag = 0  => 0.0536541889,
															   0.0548551959));

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.0870178739,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.0765740216,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.0377777778,
																							  0.0365801786));

		pk_add1_address_score_mm_b2_c2_b2 := __common__(map(pk_add1_address_score = 0 => 0.0726702076,
																			  0.0515363881));

		pk_add2_address_score_mm_b2_c2_b2 := __common__(map(pk_add2_address_score = 0 => 0.037037037,
												 pk_add2_address_score = 1 => 0.059822077,
												 pk_add2_address_score = 2 => 0.0441919192,
																			  0.0576766856));

		pk_add2_pos_sources_mm_b2_c2_b2 := __common__(map(pk_add2_pos_sources = 0 => 0.049074819,
											   pk_add2_pos_sources = 1 => 0.0629106669,
											   pk_add2_pos_sources = 2 => 0.0571142285,
											   pk_add2_pos_sources = 3 => 0.0525345622,
																		  0.0590163934));

		pk_add2_pos_secondary_sources_mm_b2_c2_b2 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.0584342333,
														 pk_add2_pos_secondary_sources = 1 => 0.0172413793,
																							  0.0161290323));

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.0580067189,
																							  0.0909090909));

		pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := __common__(map(pk_infutor_risk_lvl_nb = 0 => 0.0586932447,
												  pk_infutor_risk_lvl_nb = 1 => 0.0505188135,
												  pk_infutor_risk_lvl_nb = 2 => 0.0749874182,
																				0.0963488844));

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b2 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.0604580863,
													pk_yr_adl_vo_first_seen2 = 0  => 0.0704845815,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0452801228,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0724815725,
																					 0.0485523385));

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0596443228,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.0622406639,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0471698113,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0545905707,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0497896213,
																							   0.03125));

		pk_yr_lname_change_date2_mm_b2_c2_b2 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.0576953558,
													pk_yr_lname_change_date2 = 0  => 0.0881057269,
													pk_yr_lname_change_date2 = 1  => 0.059125964,
																					 0.043715847));

		pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.0644634843,
													  pk_yr_gong_did_first_seen2 = 0  => 0.0791788856,
													  pk_yr_gong_did_first_seen2 = 1  => 0.0877659574,
													  pk_yr_gong_did_first_seen2 = 2  => 0.0551330798,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0709759189,
																						 0.0490513651));

		pk_yr_header_first_seen2_mm_b2_c2_b2 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.1034482759,
													pk_yr_header_first_seen2 = 0  => 0.1204481793,
													pk_yr_header_first_seen2 = 1  => 0.0688259109,
													pk_yr_header_first_seen2 = 2  => 0.0756207675,
													pk_yr_header_first_seen2 = 3  => 0.0538011696,
													pk_yr_header_first_seen2 = 4  => 0.0510650715,
													pk_yr_header_first_seen2 = 5  => 0.0327169275,
													pk_yr_header_first_seen2 = 6  => 0.0375,
																					 0.0326241135));

		pk_yr_infutor_first_seen2_mm_b2_c2_b2 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.0505188135,
													 pk_yr_infutor_first_seen2 = 0  => 0.0804321729,
													 pk_yr_infutor_first_seen2 = 1  => 0.0839160839,
													 pk_yr_infutor_first_seen2 = 2  => 0.0520833333,
													 pk_yr_infutor_first_seen2 = 3  => 0.0751295337,
																					   0.0608108108));

		pk_em_only_ver_lvl_mm_b2_c2_b2 := __common__(map(pk_em_only_ver_lvl = -1 => 0.0792682927,
											  pk_em_only_ver_lvl = 0  => 0.0594812574,
											  pk_em_only_ver_lvl = 1  => 0.0486055777,
											  pk_em_only_ver_lvl = 2  => 0.0400763359,
																		 0.0621669627));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.2037037037,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.0833333333,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1206896552,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0984848485,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1641791045,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.141509434,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0537634409,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0905349794,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1081081081,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0789692436,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.072555205,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0717761557,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0554216867,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0423671822,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0374374374,
																							  0.0317258883));

		pk_nas_summary_mm_b2_c2_b3 := __common__(map(pk_nas_summary = 0 => 0.2387339056,
										  pk_nas_summary = 1 => 0.2015124555,
																0.1391926824));

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.1718440185,
													pk_rc_dirsaddr_lastscore = 0  => 0.2096415328,
													pk_rc_dirsaddr_lastscore = 1  => 0.2256097561,
																					 0.1712292002));

		pk_adl_score_mm_b2_c2_b3 := __common__(map(pk_adl_score = 0 => 0.1751412429,
															0.1837295691));

		pk_combo_addrscore_mm_b2_c2_b3 := __common__(map(pk_combo_addrscore = 0 => 0.1992197025,
																		0.1600735971));

		pk_combo_hphonescore_mm_b2_c2_b3 := __common__(map(pk_combo_hphonescore = 0 => 0.191036301,
												pk_combo_hphonescore = 1 => 0.1954022989,
																			0.1635032538));

		pk_combo_ssnscore_mm_b2_c2_b3 := __common__(map(pk_combo_ssnscore = -1 => 0.2432590856,
											 pk_combo_ssnscore = 0  => 0.28,
																	   0.1728447907));

		pk_combo_dobscore_mm_b2_c2_b3 := __common__(map(pk_combo_dobscore = -1 => 0.2345741113,
											 pk_combo_dobscore = 0  => 0.2093541203,
											 pk_combo_dobscore = 1  => 0.1916932907,
																	   0.1376067139));

		pk_combo_fnamecount_nb_mm_b2_c2_b3 := __common__(map(pk_combo_fnamecount_nb = 0 => 0.2268788404,
												  pk_combo_fnamecount_nb = 1 => 0.1661129568,
												  pk_combo_fnamecount_nb = 2 => 0.1386896222,
												  pk_combo_fnamecount_nb = 3 => 0.1104783599,
												  pk_combo_fnamecount_nb = 4 => 0.0646258503,
												  pk_combo_fnamecount_nb = 5 => 0.0777777778,
																				0.0416666667));

		pk_rc_fnamecount_nb_mm_b2_c2_b3 := __common__(map(pk_rc_fnamecount_nb = 0 => 0.2267730763,
											   pk_rc_fnamecount_nb = 1 => 0.1601068999,
											   pk_rc_fnamecount_nb = 2 => 0.1335051546,
											   pk_rc_fnamecount_nb = 3 => 0.0946327684,
											   pk_rc_fnamecount_nb = 4 => 0.0531914894,
											   pk_rc_fnamecount_nb = 5 => 0.0882352941,
																		  0));

		pk_rc_phonelnamecount_mm_b2_c2_b3 := __common__(map(pk_rc_phonelnamecount = 0 => 0.1945471747,
																			  0.12039801));

		pk_combo_addrcount_nb_mm_b2_c2_b3 := __common__(map(pk_combo_addrcount_nb = 0 => 0.2052562032,
												 pk_combo_addrcount_nb = 1 => 0.180619644,
												 pk_combo_addrcount_nb = 2 => 0.1310956301,
												 pk_combo_addrcount_nb = 3 => 0.1176470588,
												 pk_combo_addrcount_nb = 4 => 0.0901639344,
																			  0));

		pk_rc_addrcount_nb_mm_b2_c2_b3 := __common__(map(pk_rc_addrcount_nb = 0 => 0.2105016409,
											  pk_rc_addrcount_nb = 1 => 0.1392330383,
																		0));

		pk_rc_phoneaddr_phonecount_mm_b2_c2_b3 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.1863290273,
																						0.1673511294));

		pk_ver_phncount_mm_b2_c2_b3 := __common__(map(pk_ver_phncount = 0 => 0.1903743316,
										   pk_ver_phncount = 1 => 0.1946250542,
										   pk_ver_phncount = 2 => 0.1504491018,
																  0.1149068323));

		pk_combo_ssncount_mm_b2_c2_b3 := __common__(map(pk_combo_ssncount = -1 => 0.2416713721,
											 pk_combo_ssncount = 0  => 0.1751455328,
																	   0));

		pk_combo_dobcount_nb_mm_b2_c2_b3 := __common__(map(pk_combo_dobcount_nb = 0 => 0.232808358,
												pk_combo_dobcount_nb = 1 => 0.1761111111,
												pk_combo_dobcount_nb = 2 => 0.1440677966,
												pk_combo_dobcount_nb = 3 => 0.1283547258,
												pk_combo_dobcount_nb = 4 => 0.0843558282,
												pk_combo_dobcount_nb = 5 => 0.0489130435,
												pk_combo_dobcount_nb = 6 => 0.0625,
																			0));

		pk_eq_count_mm_b2_c2_b3 := __common__(map(pk_eq_count = 0 => 0.2403258656,
									   pk_eq_count = 1 => 0.2098613251,
									   pk_eq_count = 2 => 0.1967340591,
									   pk_eq_count = 3 => 0.1753986333,
									   pk_eq_count = 4 => 0.14910859,
									   pk_eq_count = 5 => 0.1308793456,
														  0.1036324786));

		pk_pos_secondary_sources_mm_b2_c2_b3 := __common__(map(pk_pos_secondary_sources = 0 => 0.1848267711,
													pk_pos_secondary_sources = 1 => 0.0163934426,
																					0.0256410256));

		pk_voter_flag_mm_b2_c2_b3 := __common__(map(pk_voter_flag = -1 => 0.2328253224,
										 pk_voter_flag = 0  => 0.1737594347,
															   0.1364069952));

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.1925349339,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.2168049793,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.1003167899,
																							  0.1382878645));

		pk_add1_address_score_mm_b2_c2_b3 := __common__(map(pk_add1_address_score = 0 => 0.2015511787,
																			  0.1378322043));

		pk_add2_address_score_mm_b2_c2_b3 := __common__(map(pk_add2_address_score = 0 => 0.1406844106,
												 pk_add2_address_score = 1 => 0.1773494828,
												 pk_add2_address_score = 2 => 0.1536585366,
																			  0.2407743497));

		pk_add2_pos_sources_mm_b2_c2_b3 := __common__(map(pk_add2_pos_sources = 0 => 0.2106003752,
											   pk_add2_pos_sources = 1 => 0.1859835468,
											   pk_add2_pos_sources = 2 => 0.153638814,
											   pk_add2_pos_sources = 3 => 0.1196454948,
																		  0.1517857143));

		pk_add2_pos_secondary_sources_mm_b2_c2_b3 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.1841118058,
														 pk_add2_pos_secondary_sources = 1 => 0.0333333333,
																							  0));

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.1829594414,
																							  0.2342857143));

		pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := __common__(map(pk_infutor_risk_lvl_nb = 0 => 0.1545454545,
												  pk_infutor_risk_lvl_nb = 1 => 0.1813681368,
												  pk_infutor_risk_lvl_nb = 2 => 0.159364468,
																				0.2177625961));

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b3 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.1939119631,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1882352941,
													pk_yr_adl_vo_first_seen2 = 1  => 0.131147541,
													pk_yr_adl_vo_first_seen2 = 2  => 0.13225058,
																					 0.0922619048));

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.1906682028,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.1260869565,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.152892562,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.1568047337,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0992481203,
																							   0.2));

		pk_yr_lname_change_date2_mm_b2_c2_b3 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.1798950215,
													pk_yr_lname_change_date2 = 0  => 0.2572614108,
													pk_yr_lname_change_date2 = 1  => 0.1958333333,
																					 0.2376237624));

		pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.1940643863,
													  pk_yr_gong_did_first_seen2 = 0  => 0.2640776699,
													  pk_yr_gong_did_first_seen2 = 1  => 0.1830985915,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1641414141,
													  pk_yr_gong_did_first_seen2 = 3  => 0.1466083151,
																						 0.1225937183));

		pk_yr_header_first_seen2_mm_b2_c2_b3 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.2112074083,
													pk_yr_header_first_seen2 = 0  => 0.2185514612,
													pk_yr_header_first_seen2 = 1  => 0.1700507614,
													pk_yr_header_first_seen2 = 2  => 0.1338709677,
													pk_yr_header_first_seen2 = 3  => 0.1187904968,
													pk_yr_header_first_seen2 = 4  => 0.0926243568,
													pk_yr_header_first_seen2 = 5  => 0.0344827586,
													pk_yr_header_first_seen2 = 6  => 0.0638297872,
																					 0.0444444444));

		pk_yr_infutor_first_seen2_mm_b2_c2_b3 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.1814602317,
													 pk_yr_infutor_first_seen2 = 0  => 0.190749079,
													 pk_yr_infutor_first_seen2 = 1  => 0.1850152905,
													 pk_yr_infutor_first_seen2 = 2  => 0.2093023256,
													 pk_yr_infutor_first_seen2 = 3  => 0.1265432099,
																					   0.2165605096));

		pk_em_only_ver_lvl_mm_b2_c2_b3 := __common__(map(pk_em_only_ver_lvl = -1 => 0.1377245509,
											  pk_em_only_ver_lvl = 0  => 0.190767198,
											  pk_em_only_ver_lvl = 1  => 0.1388888889,
											  pk_em_only_ver_lvl = 2  => 0.1153846154,
																		 0.0732984293));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.2495238095,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.3461538462,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.2648607976,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.2129186603,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.2463343109,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.187211094,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1850649351,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1601694915,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.1505882353,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1348314607,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1449067432,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.160412758,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1545988258,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.1580756014,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.1353846154,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0912408759,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0666666667,
																							  0.0819672131));

		pk_nas_summary_mm_b2_c2_b4 := __common__(map(pk_nas_summary = 0 => 0.1435275714,
										  pk_nas_summary = 1 => 0.1347971499,
																0.0967297331));

		pk_rc_dirsaddr_lastscore_mm_b2_c2_b4 := __common__(map(pk_rc_dirsaddr_lastscore = -1 => 0.1180338134,
													pk_rc_dirsaddr_lastscore = 0  => 0.1930521092,
													pk_rc_dirsaddr_lastscore = 1  => 0.1435185185,
																					 0.0919314531));

		pk_adl_score_mm_b2_c2_b4 := __common__(map(pk_adl_score = 0 => 0.051175657,
															0.121555236));

		pk_combo_addrscore_mm_b2_c2_b4 := __common__(map(pk_combo_addrscore = 0 => 0.1387464031,
																		0.1015707918));

		pk_combo_hphonescore_mm_b2_c2_b4 := __common__(map(pk_combo_hphonescore = 0 => 0.1486325803,
												pk_combo_hphonescore = 1 => 0.1382113821,
																			0.0838204203));

		pk_combo_ssnscore_mm_b2_c2_b4 := __common__(map(pk_combo_ssnscore = -1 => 0.1438941076,
											 pk_combo_ssnscore = 0  => 0.1680911681,
																	   0.1134356745));

		pk_combo_dobscore_mm_b2_c2_b4 := __common__(map(pk_combo_dobscore = -1 => 0.1722550953,
											 pk_combo_dobscore = 0  => 0.1304347826,
											 pk_combo_dobscore = 1  => 0.1067761807,
																	   0.0867659947));

		pk_combo_fnamecount_nb_mm_b2_c2_b4 := __common__(map(pk_combo_fnamecount_nb = 0 => 0.1536612949,
												  pk_combo_fnamecount_nb = 1 => 0.1174331551,
												  pk_combo_fnamecount_nb = 2 => 0.0932340563,
												  pk_combo_fnamecount_nb = 3 => 0.0635430039,
												  pk_combo_fnamecount_nb = 4 => 0.0505617978,
												  pk_combo_fnamecount_nb = 5 => 0.0304347826,
																				0));

		pk_rc_fnamecount_nb_mm_b2_c2_b4 := __common__(map(pk_rc_fnamecount_nb = 0 => 0.1521855725,
											   pk_rc_fnamecount_nb = 1 => 0.1115961283,
											   pk_rc_fnamecount_nb = 2 => 0.0835892187,
											   pk_rc_fnamecount_nb = 3 => 0.0632,
											   pk_rc_fnamecount_nb = 4 => 0.044386423,
											   pk_rc_fnamecount_nb = 5 => 0.021978022,
																		  0));

		pk_rc_phonelnamecount_mm_b2_c2_b4 := __common__(map(pk_rc_phonelnamecount = 0 => 0.1502141926,
																			  0.0678448405));

		pk_combo_addrcount_nb_mm_b2_c2_b4 := __common__(map(pk_combo_addrcount_nb = 0 => 0.1417334745,
												 pk_combo_addrcount_nb = 1 => 0.1274286715,
												 pk_combo_addrcount_nb = 2 => 0.0860499266,
												 pk_combo_addrcount_nb = 3 => 0.0736842105,
												 pk_combo_addrcount_nb = 4 => 0.0350877193,
																			  0));

		pk_rc_addrcount_nb_mm_b2_c2_b4 := __common__(map(pk_rc_addrcount_nb = 0 => 0.1381931064,
											  pk_rc_addrcount_nb = 1 => 0.0970326781,
																		0));

		pk_rc_phoneaddr_phonecount_mm_b2_c2_b4 := __common__(map(pk_rc_phoneaddr_phonecount = 0 => 0.1287889881,
																						0.0817141336));

		pk_ver_phncount_mm_b2_c2_b4 := __common__(map(pk_ver_phncount = 0 => 0.1588873813,
										   pk_ver_phncount = 1 => 0.1093888397,
										   pk_ver_phncount = 2 => 0.0765582656,
																  0.0563124432));

		pk_combo_ssncount_mm_b2_c2_b4 := __common__(map(pk_combo_ssncount = -1 => 0.1446464646,
											 pk_combo_ssncount = 0  => 0.114584731,
																	   0));

		pk_combo_dobcount_nb_mm_b2_c2_b4 := __common__(map(pk_combo_dobcount_nb = 0 => 0.1686439405,
												pk_combo_dobcount_nb = 1 => 0.1063743402,
												pk_combo_dobcount_nb = 2 => 0.0983688833,
												pk_combo_dobcount_nb = 3 => 0.0756715853,
												pk_combo_dobcount_nb = 4 => 0.0618556701,
												pk_combo_dobcount_nb = 5 => 0.04,
												pk_combo_dobcount_nb = 6 => 0.0217391304,
																			0));

		pk_eq_count_mm_b2_c2_b4 := __common__(map(pk_eq_count = 0 => 0.1510470306,
									   pk_eq_count = 1 => 0.1541438246,
									   pk_eq_count = 2 => 0.1360612109,
									   pk_eq_count = 3 => 0.1266846361,
									   pk_eq_count = 4 => 0.1162255466,
									   pk_eq_count = 5 => 0.0845410628,
														  0.0602474449));

		pk_pos_secondary_sources_mm_b2_c2_b4 := __common__(map(pk_pos_secondary_sources = 0 => 0.1197482664,
													pk_pos_secondary_sources = 1 => 0.0465116279,
																					0.0416666667));

		pk_voter_flag_mm_b2_c2_b4 := __common__(map(pk_voter_flag = -1 => 0.1704732753,
										 pk_voter_flag = 0  => 0.1084505405,
															   0.0895947426));

		pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4 := __common__(map(pk_lname_eda_sourced_type_lvl = 0 => 0.1584891912,
														 pk_lname_eda_sourced_type_lvl = 1 => 0.1230031949,
														 pk_lname_eda_sourced_type_lvl = 2 => 0.063931014,
																							  0.0718165359));

		pk_add1_address_score_mm_b2_c2_b4 := __common__(map(pk_add1_address_score = 0 => 0.1354868914,
																			  0.0919079436));

		pk_add2_address_score_mm_b2_c2_b4 := __common__(map(pk_add2_address_score = 0 => 0.0777957861,
												 pk_add2_address_score = 1 => 0.1184543746,
												 pk_add2_address_score = 2 => 0.1050929669,
																			  0.1442841287));

		pk_add2_pos_sources_mm_b2_c2_b4 := __common__(map(pk_add2_pos_sources = 0 => 0.1206045651,
											   pk_add2_pos_sources = 1 => 0.1287219423,
											   pk_add2_pos_sources = 2 => 0.0908450704,
											   pk_add2_pos_sources = 3 => 0.0825998646,
																		  0.0526315789));

		pk_add2_pos_secondary_sources_mm_b2_c2_b4 := __common__(map(pk_add2_pos_secondary_sources = 0 => 0.118969393,
														 pk_add2_pos_secondary_sources = 1 => 0,
																							  0.0425531915));

		pk_ssnchar_invalid_or_recent_mm_b2_c2_b4 := __common__(map(pk_ssnchar_invalid_or_recent_2 = 0 => 0.119495749,
																							  0.0777777778));

		pk_infutor_risk_lvl_nb_mm_b2_c2_b4 := __common__(map(pk_infutor_risk_lvl_nb = 0 => 0.1135135135,
												  pk_infutor_risk_lvl_nb = 1 => 0.1082188479,
												  pk_infutor_risk_lvl_nb = 2 => 0.1232925953,
																				0.1839207048));

		pk_yr_adl_vo_first_seen2_mm_b2_c2_b4 := __common__(map(pk_yr_adl_vo_first_seen2 = -1 => 0.1260180026,
													pk_yr_adl_vo_first_seen2 = 0  => 0.1476274165,
													pk_yr_adl_vo_first_seen2 = 1  => 0.0767613039,
													pk_yr_adl_vo_first_seen2 = 2  => 0.0896358543,
																					 0.0684699915));

		pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4 := __common__(map(pk_yr_adl_em_only_first_seen2 = -1 => 0.123661213,
														 pk_yr_adl_em_only_first_seen2 = 0  => 0.0990990991,
														 pk_yr_adl_em_only_first_seen2 = 1  => 0.0784313725,
														 pk_yr_adl_em_only_first_seen2 = 2  => 0.0798969072,
														 pk_yr_adl_em_only_first_seen2 = 3  => 0.0837124659,
																							   0));

		pk_yr_lname_change_date2_mm_b2_c2_b4 := __common__(map(pk_yr_lname_change_date2 = -1 => 0.1162834175,
													pk_yr_lname_change_date2 = 0  => 0.1816326531,
													pk_yr_lname_change_date2 = 1  => 0.1329113924,
																					 0.1097560976));

		pk_yr_gong_did_first_seen2_mm_b2_c2_b4 := __common__(map(pk_yr_gong_did_first_seen2 = -1 => 0.1285099924,
													  pk_yr_gong_did_first_seen2 = 0  => 0.202173913,
													  pk_yr_gong_did_first_seen2 = 1  => 0.1525423729,
													  pk_yr_gong_did_first_seen2 = 2  => 0.1061571125,
													  pk_yr_gong_did_first_seen2 = 3  => 0.0834553441,
																						 0.0790592236));

		pk_yr_header_first_seen2_mm_b2_c2_b4 := __common__(map(pk_yr_header_first_seen2 = -1 => 0.1492169062,
													pk_yr_header_first_seen2 = 0  => 0.1544502618,
													pk_yr_header_first_seen2 = 1  => 0.1071779744,
													pk_yr_header_first_seen2 = 2  => 0.08733791,
													pk_yr_header_first_seen2 = 3  => 0.0839328537,
													pk_yr_header_first_seen2 = 4  => 0.0566666667,
													pk_yr_header_first_seen2 = 5  => 0.0538461538,
													pk_yr_header_first_seen2 = 6  => 0.0171428571,
																					 0.0198675497));

		pk_yr_infutor_first_seen2_mm_b2_c2_b4 := __common__(map(pk_yr_infutor_first_seen2 = -1 => 0.1082188479,
													 pk_yr_infutor_first_seen2 = 0  => 0.1550687285,
													 pk_yr_infutor_first_seen2 = 1  => 0.1414285714,
													 pk_yr_infutor_first_seen2 = 2  => 0.1344383057,
													 pk_yr_infutor_first_seen2 = 3  => 0.1291139241,
																					   0.119205298));

		pk_em_only_ver_lvl_mm_b2_c2_b4 := __common__(map(pk_em_only_ver_lvl = -1 => 0.1727272727,
											  pk_em_only_ver_lvl = 0  => 0.123943476,
											  pk_em_only_ver_lvl = 1  => 0.0758293839,
											  pk_em_only_ver_lvl = 2  => 0.0958230958,
																		 0.0717213115));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := __common__(map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1496099128,
													 pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.217877095,
													 pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1923076923,
													 pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.1881578947,
													 pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1936507937,
													 pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.1506072874,
													 pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1681109185,
													 pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1403940887,
													 pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.118226601,
													 pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1082802548,
													 pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1206529454,
													 pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.1078806427,
													 pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.1242857143,
													 pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0715705765,
													 pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0616966581,
													 pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0460829493,
													 pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0397168698,
																							  0.0309278351));

		pk_add2_pos_secondary_sources_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_pos_secondary_sources_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_add2_pos_secondary_sources_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_add2_pos_secondary_sources_mm_b2_c2_b3,
																				pk_add2_pos_secondary_sources_mm_b2_c2_b4));

		pk_yr_infutor_first_seen2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_infutor_first_seen2_mm_b2_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_infutor_first_seen2_mm_b2_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_infutor_first_seen2_mm_b2_c2_b3,
																			pk_yr_infutor_first_seen2_mm_b2_c2_b4));

		pk_yr_lname_change_date2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_lname_change_date2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_lname_change_date2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_lname_change_date2_mm_b2_c2_b3,
																		   pk_yr_lname_change_date2_mm_b2_c2_b4));

		pk_ssnchar_invalid_or_recent_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b1,
												  pk_segment_2 = '1 Owner ' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b2,
												  pk_segment_2 = '2 Renter' => pk_ssnchar_invalid_or_recent_mm_b2_c2_b3,
																			   pk_ssnchar_invalid_or_recent_mm_b2_c2_b4));

		pk_rc_fnamecount_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_fnamecount_nb_mm_b2_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_rc_fnamecount_nb_mm_b2_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_rc_fnamecount_nb_mm_b2_c2_b3,
																	  pk_rc_fnamecount_nb_mm_b2_c2_b4));

		pk_adl_score_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_adl_score_mm_b2_c2_b1,
								  pk_segment_2 = '1 Owner ' => pk_adl_score_mm_b2_c2_b2,
								  pk_segment_2 = '2 Renter' => pk_adl_score_mm_b2_c2_b3,
															   pk_adl_score_mm_b2_c2_b4));

		pk_combo_dobcount_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_dobcount_nb_mm_b2_c2_b1,
										  pk_segment_2 = '1 Owner ' => pk_combo_dobcount_nb_mm_b2_c2_b2,
										  pk_segment_2 = '2 Renter' => pk_combo_dobcount_nb_mm_b2_c2_b3,
																	   pk_combo_dobcount_nb_mm_b2_c2_b4));

		pk_rc_phonelnamecount_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_phonelnamecount_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_rc_phonelnamecount_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_rc_phonelnamecount_mm_b2_c2_b3,
																		pk_rc_phonelnamecount_mm_b2_c2_b4));

		pk_combo_fnamecount_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_fnamecount_nb_mm_b2_c2_b1,
											pk_segment_2 = '1 Owner ' => pk_combo_fnamecount_nb_mm_b2_c2_b2,
											pk_segment_2 = '2 Renter' => pk_combo_fnamecount_nb_mm_b2_c2_b3,
																		 pk_combo_fnamecount_nb_mm_b2_c2_b4));

		pk_rc_dirsaddr_lastscore_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_rc_dirsaddr_lastscore_mm_b2_c2_b3,
																		   pk_rc_dirsaddr_lastscore_mm_b2_c2_b4));

		pk_combo_ssncount_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_ssncount_mm_b2_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssncount_mm_b2_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssncount_mm_b2_c2_b3,
																	pk_combo_ssncount_mm_b2_c2_b4));

		pk_yr_adl_vo_first_seen2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_adl_vo_first_seen2_mm_b2_c2_b3,
																		   pk_yr_adl_vo_first_seen2_mm_b2_c2_b4));

		pk_pos_secondary_sources_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b2_c2_b3,
																		   pk_pos_secondary_sources_mm_b2_c2_b4));

		pk_combo_addrscore_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_addrscore_mm_b2_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_combo_addrscore_mm_b2_c2_b2,
										pk_segment_2 = '2 Renter' => pk_combo_addrscore_mm_b2_c2_b3,
																	 pk_combo_addrscore_mm_b2_c2_b4));

		pk_voter_flag_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b2_c2_b1,
								   pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b2_c2_b2,
								   pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b2_c2_b3,
																pk_voter_flag_mm_b2_c2_b4));

		pk_add2_address_score_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_address_score_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_address_score_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_address_score_mm_b2_c2_b3,
																		pk_add2_address_score_mm_b2_c2_b4));

		pk_combo_ssnscore_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_ssnscore_mm_b2_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_ssnscore_mm_b2_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_ssnscore_mm_b2_c2_b3,
																	pk_combo_ssnscore_mm_b2_c2_b4));

		pk_lname_eda_sourced_type_lvl_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3,
																				pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4));

		pk_combo_dobscore_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_dobscore_mm_b2_c2_b1,
									   pk_segment_2 = '1 Owner ' => pk_combo_dobscore_mm_b2_c2_b2,
									   pk_segment_2 = '2 Renter' => pk_combo_dobscore_mm_b2_c2_b3,
																	pk_combo_dobscore_mm_b2_c2_b4));

		pk_ver_phncount_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_ver_phncount_mm_b2_c2_b1,
									 pk_segment_2 = '1 Owner ' => pk_ver_phncount_mm_b2_c2_b2,
									 pk_segment_2 = '2 Renter' => pk_ver_phncount_mm_b2_c2_b3,
																  pk_ver_phncount_mm_b2_c2_b4));

		pk_rc_phoneaddr_phonecount_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_phoneaddr_phonecount_mm_b2_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_rc_phoneaddr_phonecount_mm_b2_c2_b2,
												pk_segment_2 = '2 Renter' => pk_rc_phoneaddr_phonecount_mm_b2_c2_b3,
																			 pk_rc_phoneaddr_phonecount_mm_b2_c2_b4));

		pk_nas_summary_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_nas_summary_mm_b2_c2_b1,
									pk_segment_2 = '1 Owner ' => pk_nas_summary_mm_b2_c2_b2,
									pk_segment_2 = '2 Renter' => pk_nas_summary_mm_b2_c2_b3,
																 pk_nas_summary_mm_b2_c2_b4));

		pk_yr_gong_did_first_seen2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b2,
												pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b2_c2_b3,
																			 pk_yr_gong_did_first_seen2_mm_b2_c2_b4));

		pk_combo_hphonescore_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_hphonescore_mm_b2_c2_b1,
										  pk_segment_2 = '1 Owner ' => pk_combo_hphonescore_mm_b2_c2_b2,
										  pk_segment_2 = '2 Renter' => pk_combo_hphonescore_mm_b2_c2_b3,
																	   pk_combo_hphonescore_mm_b2_c2_b4));

		pk_yr_adl_em_only_first_seen2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1,
												   pk_segment_2 = '1 Owner ' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2,
												   pk_segment_2 = '2 Renter' => pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3,
																				pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4));

		pk_infutor_risk_lvl_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_infutor_risk_lvl_nb_mm_b2_c2_b1,
											pk_segment_2 = '1 Owner ' => pk_infutor_risk_lvl_nb_mm_b2_c2_b2,
											pk_segment_2 = '2 Renter' => pk_infutor_risk_lvl_nb_mm_b2_c2_b3,
																		 pk_infutor_risk_lvl_nb_mm_b2_c2_b4));

		pk_combo_addrcount_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_combo_addrcount_nb_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_combo_addrcount_nb_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_combo_addrcount_nb_mm_b2_c2_b3,
																		pk_combo_addrcount_nb_mm_b2_c2_b4));

		pk_eq_count_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_eq_count_mm_b2_c2_b1,
								 pk_segment_2 = '1 Owner ' => pk_eq_count_mm_b2_c2_b2,
								 pk_segment_2 = '2 Renter' => pk_eq_count_mm_b2_c2_b3,
															  pk_eq_count_mm_b2_c2_b4));

		pk_yr_header_first_seen2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_header_first_seen2_mm_b2_c2_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_header_first_seen2_mm_b2_c2_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_header_first_seen2_mm_b2_c2_b3,
																		   pk_yr_header_first_seen2_mm_b2_c2_b4));

		pk_em_only_ver_lvl_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_em_only_ver_lvl_mm_b2_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_em_only_ver_lvl_mm_b2_c2_b2,
										pk_segment_2 = '2 Renter' => pk_em_only_ver_lvl_mm_b2_c2_b3,
																	 pk_em_only_ver_lvl_mm_b2_c2_b4));

		pk_add1_address_score_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_address_score_mm_b2_c2_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_address_score_mm_b2_c2_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_address_score_mm_b2_c2_b3,
																		pk_add1_address_score_mm_b2_c2_b4));

		pk_rc_addrcount_nb_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_addrcount_nb_mm_b2_c2_b1,
										pk_segment_2 = '1 Owner ' => pk_rc_addrcount_nb_mm_b2_c2_b2,
										pk_segment_2 = '2 Renter' => pk_rc_addrcount_nb_mm_b2_c2_b3,
																	 pk_rc_addrcount_nb_mm_b2_c2_b4));

		pk_add2_pos_sources_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b2_c2_b1,
										 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b2_c2_b2,
										 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b2_c2_b3,
																	  pk_add2_pos_sources_mm_b2_c2_b4));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := __common__(map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1,
											   pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2,
											   pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3,
																			pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4));

		pk_add2_pos_secondary_sources_mm := __common__(if((integer)add1_isbestmatch = 1, pk_add2_pos_secondary_sources_mm_b1, pk_add2_pos_secondary_sources_mm_b2));

		pk_yr_infutor_first_seen2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_infutor_first_seen2_mm_b1, pk_yr_infutor_first_seen2_mm_b2));

		pk_yr_lname_change_date2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_lname_change_date2_mm_b1, pk_yr_lname_change_date2_mm_b2));

		pk_ssnchar_invalid_or_recent_mm := __common__(if((integer)add1_isbestmatch = 1, pk_ssnchar_invalid_or_recent_mm_b1, pk_ssnchar_invalid_or_recent_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_rc_fnamecount_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_rc_fnamecount_nb_mm_b2));

		pk_adl_score_mm := __common__(if((integer)add1_isbestmatch = 1, pk_adl_score_mm_b1, pk_adl_score_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_dobcount_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_combo_dobcount_nb_mm_b2));

		pk_rc_phonelnamecount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_rc_phonelnamecount_mm_b1, pk_rc_phonelnamecount_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_fnamecount_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_combo_fnamecount_nb_mm_b2));

		pk_rc_dirsaddr_lastscore_mm := __common__(if((integer)add1_isbestmatch = 1, pk_rc_dirsaddr_lastscore_mm_b1, pk_rc_dirsaddr_lastscore_mm_b2));

		pk_combo_ssncount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_ssncount_mm_b1, pk_combo_ssncount_mm_b2));

		pk_yr_adl_vo_first_seen2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_adl_vo_first_seen2_mm_b1, pk_yr_adl_vo_first_seen2_mm_b2));

		pk_pos_secondary_sources_mm := __common__(if((integer)add1_isbestmatch = 1, pk_pos_secondary_sources_mm_b1, pk_pos_secondary_sources_mm_b2));

		pk_combo_addrscore_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_addrscore_mm_b1, pk_combo_addrscore_mm_b2));

		pk_voter_flag_mm := __common__(if((integer)add1_isbestmatch = 1, pk_voter_flag_mm_b1, pk_voter_flag_mm_b2));

		pk_add2_address_score_mm := __common__(if((integer)add1_isbestmatch = 1, pk_add2_address_score_mm_b1, pk_add2_address_score_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_rc_fnamecount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_rc_fnamecount_mm_b1, NULL));

		pk_combo_ssnscore_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_ssnscore_mm_b1, pk_combo_ssnscore_mm_b2));

		pk_lname_eda_sourced_type_lvl_mm := __common__(if((integer)add1_isbestmatch = 1, pk_lname_eda_sourced_type_lvl_mm_b1, pk_lname_eda_sourced_type_lvl_mm_b2));

		pk_combo_dobscore_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_dobscore_mm_b1, pk_combo_dobscore_mm_b2));

		pk_ver_phncount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_ver_phncount_mm_b1, pk_ver_phncount_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_dobcount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_dobcount_mm_b1, NULL));

		pk_rc_phoneaddr_phonecount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_rc_phoneaddr_phonecount_mm_b1, pk_rc_phoneaddr_phonecount_mm_b2));

		pk_nas_summary_mm := __common__(if((integer)add1_isbestmatch = 1, pk_nas_summary_mm_b1, pk_nas_summary_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_rc_addrcount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_rc_addrcount_mm_b1, NULL));

		pk_yr_gong_did_first_seen2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_gong_did_first_seen2_mm_b1, pk_yr_gong_did_first_seen2_mm_b2));

		pk_combo_hphonescore_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_hphonescore_mm_b1, pk_combo_hphonescore_mm_b2));

		pk_yr_adl_em_only_first_seen2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_adl_em_only_first_seen2_mm_b1, pk_yr_adl_em_only_first_seen2_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_infutor_risk_lvl_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_infutor_risk_lvl_nb_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_add2_em_ver_lvl_mm := __common__(if((integer)add1_isbestmatch = 1, pk_add2_em_ver_lvl_mm_b1, NULL));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_lnamecount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_lnamecount_mm_b1, NULL));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_addrcount_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_combo_addrcount_nb_mm_b2));

		pk_eq_count_mm := __common__(if((integer)add1_isbestmatch = 1, pk_eq_count_mm_b1, pk_eq_count_mm_b2));

		pk_yr_header_first_seen2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yr_header_first_seen2_mm_b1, pk_yr_header_first_seen2_mm_b2));

		pk_em_only_ver_lvl_mm := __common__(if((integer)add1_isbestmatch = 1, pk_em_only_ver_lvl_mm_b1, pk_em_only_ver_lvl_mm_b2));

		pk_add1_address_score_mm := __common__(if((integer)add1_isbestmatch = 1, pk_add1_address_score_mm_b1, pk_add1_address_score_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_combo_fnamecount_mm := __common__(if((integer)add1_isbestmatch = 1, pk_combo_fnamecount_mm_b1, NULL));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_rc_addrcount_nb_mm := __common__(if((integer)add1_isbestmatch = 1, NULL, pk_rc_addrcount_nb_mm_b2));

		pk_add2_pos_sources_mm := __common__(if((integer)add1_isbestmatch = 1, pk_add2_pos_sources_mm_b1, pk_add2_pos_sources_mm_b2));

		pk_yrmo_adl_f_sn_mx_fcra2_mm := __common__(if((integer)add1_isbestmatch = 1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b2));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_infutor_risk_lvl_mm := __common__(if((integer)add1_isbestmatch = 1, pk_infutor_risk_lvl_mm_b1, NULL));

		pk_estimated_income_mm_b1 := __common__(map(pk_estimated_income = -1 => 0.2455357143,
										 pk_estimated_income = 0  => 0.2480620155,
										 pk_estimated_income = 1  => 0.2728146013,
										 pk_estimated_income = 2  => 0.2548701299,
										 pk_estimated_income = 3  => 0.2820512821,
										 pk_estimated_income = 4  => 0.2465346535,
										 pk_estimated_income = 5  => 0.2316570486,
										 pk_estimated_income = 6  => 0.2174871418,
										 pk_estimated_income = 7  => 0.1859872611,
										 pk_estimated_income = 8  => 0.194828623,
										 pk_estimated_income = 9  => 0.1662721893,
										 pk_estimated_income = 10 => 0.1438398999,
										 pk_estimated_income = 11 => 0.1313559322,
										 pk_estimated_income = 12 => 0.1224421335,
										 pk_estimated_income = 13 => 0.1412958626,
										 pk_estimated_income = 14 => 0.1291632819,
										 pk_estimated_income = 15 => 0.1179723502,
										 pk_estimated_income = 16 => 0.115694165,
										 pk_estimated_income = 17 => 0.1097424412,
										 pk_estimated_income = 18 => 0.1395348837,
										 pk_estimated_income = 19 => 0.105964467,
										 pk_estimated_income = 20 => 0.1072185858,
										 pk_estimated_income = 21 => 0.1161764706,
																	 0.0817610063));

		pk_yr_adl_w_first_seen2_mm_b1 := __common__(map(pk_yr_adl_w_first_seen2 = -1 => 0.1525385119,
											 pk_yr_adl_w_first_seen2 = 0  => 0.0661764706,
											 pk_yr_adl_w_first_seen2 = 1  => 0.0831683168,
																			 0.09375));

		pk_yr_adl_w_last_seen2_mm_b1 := __common__(map(pk_yr_adl_w_last_seen2 = -1 => 0.1525385119,
											pk_yr_adl_w_last_seen2 = 0  => 0.0687830688,
											pk_yr_adl_w_last_seen2 = 1  => 0.0801186944,
																		   0.0863121186));

		pk_pr_count_mm_b1 := __common__(map(pk_pr_count = -1 => 0.2064160342,
								 pk_pr_count = 0  => 0.0970435945,
								 pk_pr_count = 1  => 0.1015389041,
													 0.1162227603));

		pk_addrs_sourced_lvl_mm_b1 := __common__(map(pk_addrs_sourced_lvl = 0 => 0.1783417041,
										  pk_addrs_sourced_lvl = 1 => 0.105506156,
										  pk_addrs_sourced_lvl = 2 => 0.0989539749,
																	  0.0998959417));

		pk_add2_own_level_mm_b1 := __common__(map(pk_add2_own_level = 0 => 0.154525169,
									   pk_add2_own_level = 1 => 0.1457725948,
									   pk_add2_own_level = 2 => 0.1114386792,
																0.1054251635));

		pk_add3_own_level_mm_b1 := __common__(map(pk_add3_own_level = 0 => 0.1517660044,
									   pk_add3_own_level = 1 => 0.1569634703,
									   pk_add3_own_level = 2 => 0.109058927,
																0.1039039039));

		pk_naprop_level2_mm_b1 := __common__(map(pk_naprop_level2 = -2 => 0.2383268482,
									  pk_naprop_level2 = -1 => 0.206927779,
									  pk_naprop_level2 = 0  => 0.20640956,
									  pk_naprop_level2 = 1  => 0.1601731602,
									  pk_naprop_level2 = 2  => 0.1794595758,
									  pk_naprop_level2 = 3  => 0.1838931955,
									  pk_naprop_level2 = 4  => 0.1414835165,
									  pk_naprop_level2 = 5  => 0.1113214691,
									  pk_naprop_level2 = 6  => 0.0968844614,
															   0.0929496403));

		pk_yr_add1_purchase_date2_mm_b1 := __common__(map(pk_yr_add1_purchase_date2 = -1 => 0.1670592729,
											   pk_yr_add1_purchase_date2 = 0  => 0.1412282682,
											   pk_yr_add1_purchase_date2 = 1  => 0.147696477,
											   pk_yr_add1_purchase_date2 = 2  => 0.1322485207,
											   pk_yr_add1_purchase_date2 = 3  => 0.1317630597,
											   pk_yr_add1_purchase_date2 = 4  => 0.1136853448,
																				 0.1118800461));

		pk_yr_add1_built_date2_mm_b1 := __common__(map(pk_yr_add1_built_date2 = -4 => 0.1611489776,
											pk_yr_add1_built_date2 = -3 => 0.1346153846,
											pk_yr_add1_built_date2 = -2 => 0.1417624521,
											pk_yr_add1_built_date2 = -1 => 0.1315261044,
											pk_yr_add1_built_date2 = 0  => 0.1237444757,
											pk_yr_add1_built_date2 = 1  => 0.123987034,
											pk_yr_add1_built_date2 = 2  => 0.1306279621,
																		   0.1549393414));

		pk_yr_add1_mortgage_date2_mm_b1 := __common__(map(pk_yr_add1_mortgage_date2 = -1 => 0.1511701691,
											   pk_yr_add1_mortgage_date2 = 0  => 0.1494530245,
											   pk_yr_add1_mortgage_date2 = 1  => 0.1289120715,
																				 0.1311591634));

		pk_add1_mortgage_risk_mm_b1 := __common__(map(pk_add1_mortgage_risk = -1 => 0.1333333333,
										   pk_add1_mortgage_risk = 0  => 0.1154674709,
										   pk_add1_mortgage_risk = 1  => 0.1516615914,
										   pk_add1_mortgage_risk = 2  => 0.130250118,
																		 0.1575562701));

		pk_add1_assessed_amount2_mm_b1 := __common__(map(pk_add1_assessed_amount2 = -1 => 0.1580389903,
											  pk_add1_assessed_amount2 = 0  => 0.1968503937,
											  pk_add1_assessed_amount2 = 1  => 0.161352657,
											  pk_add1_assessed_amount2 = 2  => 0.1440422323,
											  pk_add1_assessed_amount2 = 3  => 0.1233671988,
											  pk_add1_assessed_amount2 = 4  => 0.1377061757,
											  pk_add1_assessed_amount2 = 5  => 0.1265597148,
																			   0.1199935401));

		pk_yr_add1_date_first_seen2_mm_b1 := __common__(map(pk_yr_add1_date_first_seen2 = -1 => 0.2721437741,
												 pk_yr_add1_date_first_seen2 = 0  => 0.2149165849,
												 pk_yr_add1_date_first_seen2 = 1  => 0.1622818442,
												 pk_yr_add1_date_first_seen2 = 2  => 0.1573204001,
												 pk_yr_add1_date_first_seen2 = 3  => 0.1520825373,
												 pk_yr_add1_date_first_seen2 = 4  => 0.1352583587,
												 pk_yr_add1_date_first_seen2 = 5  => 0.1139510117,
												 pk_yr_add1_date_first_seen2 = 6  => 0.1131936788,
												 pk_yr_add1_date_first_seen2 = 7  => 0.1051121544,
												 pk_yr_add1_date_first_seen2 = 8  => 0.0928143713,
												 pk_yr_add1_date_first_seen2 = 9  => 0.0734737979,
																					 0.0675675676));

		pk_add1_building_area2_mm_b1 := __common__(map(pk_add1_building_area2 = -99 => 0.1605307521,
											pk_add1_building_area2 = -4  => 0.1764080765,
											pk_add1_building_area2 = -3  => 0.1444308446,
											pk_add1_building_area2 = -2  => 0.1404251566,
											pk_add1_building_area2 = -1  => 0.1199089299,
											pk_add1_building_area2 = 0   => 0.1184433164,
											pk_add1_building_area2 = 1   => 0.0909090909,
											pk_add1_building_area2 = 2   => 0.1142857143,
											pk_add1_building_area2 = 3   => 0.1325966851,
																			0.2067039106));

		pk_add1_no_of_baths_mm_b1 := __common__(map(pk_add1_no_of_baths = -3 => 0.1582765124,
										 pk_add1_no_of_baths = -2 => 0.1472312704,
										 pk_add1_no_of_baths = -1 => 0.1298463789,
										 pk_add1_no_of_baths = 0  => 0.1340713407,
										 pk_add1_no_of_baths = 1  => 0.12,
																	 0.1148648649));

		pk_property_owned_total_mm_b1 := __common__(map(pk_property_owned_total = -1 => 0.1902499381,
											 pk_property_owned_total = 0  => 0.100432831,
											 pk_property_owned_total = 1  => 0.0953955136,
											 pk_property_owned_total = 2  => 0.0884353741,
																			 0.0747663551));

		pk_prop_own_assess_tot2_mm_b1 := __common__(map(pk_prop_own_assess_tot2 = 0 => 0.1693603202,
											 pk_prop_own_assess_tot2 = 1 => 0.1072072072,
											 pk_prop_own_assess_tot2 = 2 => 0.1056910569,
											 pk_prop_own_assess_tot2 = 3 => 0.0868897759,
																			0.0918163673));

		pk_prop1_sale_price2_mm_b1 := __common__(map(pk_prop1_sale_price2 = 0 => 0.1523801185,
										  pk_prop1_sale_price2 = 1 => 0.1047120419,
																	  0.103460972));

		pk_add2_land_use_risk_level_mm_b1 := __common__(map(pk_add2_land_use_risk_level = 0 => 0.0982142857,
												 pk_add2_land_use_risk_level = 2 => 0.1365584368,
												 pk_add2_land_use_risk_level = 3 => 0.1557034306,
																					0.16));

		pk_add2_building_area2_mm_b1 := __common__(map(pk_add2_building_area2 = -4 => 0.1524070639,
											pk_add2_building_area2 = -3 => 0.1714285714,
											pk_add2_building_area2 = -2 => 0.1430615165,
											pk_add2_building_area2 = -1 => 0.1368139224,
											pk_add2_building_area2 = 0  => 0.1385435169,
											pk_add2_building_area2 = 1  => 0.1376146789,
																		   0.1616438356));

		pk_add2_no_of_baths_mm_b1 := __common__(map(pk_add2_no_of_baths = -3 => 0.1522624434,
										 pk_add2_no_of_baths = -2 => 0.1471594798,
										 pk_add2_no_of_baths = -1 => 0.1315052042,
										 pk_add2_no_of_baths = 0  => 0.1382636656,
										 pk_add2_no_of_baths = 1  => 0.1519607843,
																	 0.1641791045));

		pk_yr_add2_mortgage_date2_mm_b1 := __common__(map(pk_yr_add2_mortgage_date2 = -1 => 0.1495577243,
											   pk_yr_add2_mortgage_date2 = 0  => 0.1453050034,
																				 0.1410018553));

		pk_add2_mortgage_risk_mm_b1 := __common__(map(pk_add2_mortgage_risk = -1 => 0.1428571429,
										   pk_add2_mortgage_risk = 0  => 0.1312649165,
										   pk_add2_mortgage_risk = 1  => 0.148915487,
										   pk_add2_mortgage_risk = 2  => 0.1478439425,
																		 0.1560424967));

		pk_yr_add2_mortgage_due_date2_mm_b1 := __common__(map(pk_yr_add2_mortgage_due_date2 = -1 => 0.1493785311,
												   pk_yr_add2_mortgage_due_date2 = 0  => 0.1414982164,
												   pk_yr_add2_mortgage_due_date2 = 1  => 0.1565934066,
												   pk_yr_add2_mortgage_due_date2 = 2  => 0.1410788382,
																						 0.1404724409));

		pk_add2_assessed_amount2_mm_b1 := __common__(map(pk_add2_assessed_amount2 = -1 => 0.1515380193,
											  pk_add2_assessed_amount2 = 0  => 0.1654366544,
											  pk_add2_assessed_amount2 = 1  => 0.1485809683,
											  pk_add2_assessed_amount2 = 2  => 0.1651954603,
											  pk_add2_assessed_amount2 = 3  => 0.1166464156,
																			   0.1384950927));

		pk_yr_add2_date_first_seen2_mm_b1 := __common__(map(pk_yr_add2_date_first_seen2 = -1 => 0.2379583034,
												 pk_yr_add2_date_first_seen2 = 0  => 0.2222480801,
												 pk_yr_add2_date_first_seen2 = 1  => 0.1782706345,
												 pk_yr_add2_date_first_seen2 = 2  => 0.1634901727,
												 pk_yr_add2_date_first_seen2 = 3  => 0.1662541254,
												 pk_yr_add2_date_first_seen2 = 4  => 0.1454907823,
												 pk_yr_add2_date_first_seen2 = 5  => 0.1433476395,
												 pk_yr_add2_date_first_seen2 = 6  => 0.1272554606,
												 pk_yr_add2_date_first_seen2 = 7  => 0.1196228639,
												 pk_yr_add2_date_first_seen2 = 8  => 0.1143904321,
												 pk_yr_add2_date_first_seen2 = 9  => 0.0994055482,
												 pk_yr_add2_date_first_seen2 = 10 => 0.1013953488,
																					 0.0908532842));

		pk_add3_mortgage_risk_mm_b1 := __common__(map(pk_add3_mortgage_risk = -1 => 0.0869565217,
										   pk_add3_mortgage_risk = 0  => 0.1353104727,
										   pk_add3_mortgage_risk = 1  => 0.1058823529,
										   pk_add3_mortgage_risk = 2  => 0.1498579758,
										   pk_add3_mortgage_risk = 3  => 0.129703763,
										   pk_add3_mortgage_risk = 4  => 0.1445086705,
																		 0.1633466135));

		pk_add3_assessed_amount2_mm_b1 := __common__(map(pk_add3_assessed_amount2 = -1 => 0.1501420309,
											  pk_add3_assessed_amount2 = 0  => 0.1633522727,
											  pk_add3_assessed_amount2 = 1  => 0.157223796,
											  pk_add3_assessed_amount2 = 2  => 0.1424514908,
																			   0.1323845328));

		pk_yr_add3_date_first_seen2_mm_b1 := __common__(map(pk_yr_add3_date_first_seen2 = -1 => 0.2262367982,
												 pk_yr_add3_date_first_seen2 = 0  => 0.2368421053,
												 pk_yr_add3_date_first_seen2 = 1  => 0.1963979417,
												 pk_yr_add3_date_first_seen2 = 2  => 0.1720542231,
												 pk_yr_add3_date_first_seen2 = 3  => 0.1734213007,
												 pk_yr_add3_date_first_seen2 = 4  => 0.1436588103,
												 pk_yr_add3_date_first_seen2 = 5  => 0.1373561523,
												 pk_yr_add3_date_first_seen2 = 6  => 0.1277006173,
												 pk_yr_add3_date_first_seen2 = 7  => 0.1152882206,
												 pk_yr_add3_date_first_seen2 = 8  => 0.1056476538,
																					 0.0966587112));

		pk_w_count_mm_b1 := __common__(map(pk_w_count = 0 => 0.1526708854,
								pk_w_count = 1 => 0.0770218228,
												  0.0867924528));

		pk_bk_level_mm_b1 := __common__(map(pk_bk_level_2 = 0 => 0.1704606486,
								 pk_bk_level_2 = 1 => 0.0998821945,
													  0.1933395005));

		pk_eviction_level_mm_b1 := __common__(map(pk_eviction_level = 0 => 0.1422761947,
									   pk_eviction_level = 1 => 0.2066115702,
									   pk_eviction_level = 2 => 0.2589928058,
									   pk_eviction_level = 3 => 0.3343465046,
									   pk_eviction_level = 4 => 0.3444444444,
									   pk_eviction_level = 5 => 0.4175824176,
									   pk_eviction_level = 6 => 0.4303797468,
																0.4520547945));

		pk_lien_type_level_mm_b1 := __common__(map(pk_lien_type_level = 0 => 0.1379635213,
										pk_lien_type_level = 1 => 0.1095238095,
										pk_lien_type_level = 2 => 0.114507772,
										pk_lien_type_level = 3 => 0.1675297773,
										pk_lien_type_level = 4 => 0.1796516957,
																  0.2810890361));

		pk_yr_liens_last_unrel_date3_mm_b1 := __common__(map((integer)pk_yr_liens_last_unrel_date3_2 = -1 => 0.1553144465,
												  pk_yr_liens_last_unrel_date3_2 = -0.5        => 0.1158474576,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 0  => 0.2462082912,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 1  => 0.1992433796,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 2  => 0.1662286465,
												  (integer)pk_yr_liens_last_unrel_date3_2 = 3  => 0.1542995839,
																								  0.1356824625));

		pk_yr_ln_unrel_cj_f_sn2_mm_b1 := __common__(map(pk_yr_liens_unrel_cj_first_sn2 = -1 => 0.14,
											 pk_yr_liens_unrel_cj_first_sn2 = 0  => 0.2616926503,
											 pk_yr_liens_unrel_cj_first_sn2 = 1  => 0.2244897959,
											 pk_yr_liens_unrel_cj_first_sn2 = 2  => 0.1725293132,
																					0.1663385827));

		pk_yr_ln_unrel_lt_f_sn2_mm_b1 := __common__(map(pk_yr_liens_unrel_lt_first_sn2 = -1 => 0.1458441808,
											 pk_yr_liens_unrel_lt_first_sn2 = 0  => 0.4017857143,
																					0.2417582418));

		pk_yr_ln_unrel_ot_f_sn2_mm_b1 := __common__(map(pk_yr_liens_unrel_ot_first_sn2 = -1 => 0.1496503894,
											 pk_yr_liens_unrel_ot_first_sn2 = 0  => 0.1627620222,
											 pk_yr_liens_unrel_ot_first_sn2 = 1  => 0.1319796954,
																					0.0802047782));

		pk_yr_criminal_last_date2_mm_b1 := __common__(map(pk_yr_criminal_last_date2 = -1 => 0.1430736317,
											   pk_yr_criminal_last_date2 = 0  => 0.2778603269,
											   pk_yr_criminal_last_date2 = 1  => 0.2404006678,
											   pk_yr_criminal_last_date2 = 2  => 0.206122449,
											   pk_yr_criminal_last_date2 = 3  => 0.1762749446,
																				 0.1361502347));

		pk_yr_felony_last_date2_mm_b1 := __common__(map(pk_yr_felony_last_date2 = -1 => 0.1447014228,
											 pk_yr_felony_last_date2 = 0  => 0.4427480916,
											 pk_yr_felony_last_date2 = 1  => 0.3828125,
											 pk_yr_felony_last_date2 = 2  => 0.313304721,
																			 0.2720588235));

		pk_attr_total_number_derogs_mm_b1 := __common__(map(pk_attr_total_number_derogs_5 = 0 => 0.142542564,
												 pk_attr_total_number_derogs_5 = 1 => 0.1387722772,
												 pk_attr_total_number_derogs_5 = 2 => 0.1717844728,
																					  0.2113985449));

		pk_yr_rc_ssnhighissue2_mm_b1 := __common__(map(pk_yr_rc_ssnhighissue2 = -1 => 0.1875,
											pk_yr_rc_ssnhighissue2 = 0  => 0.2068965517,
											pk_yr_rc_ssnhighissue2 = 1  => 0.2755102041,
											pk_yr_rc_ssnhighissue2 = 2  => 0.2523900574,
											pk_yr_rc_ssnhighissue2 = 3  => 0.2056074766,
											pk_yr_rc_ssnhighissue2 = 4  => 0.2659808964,
											pk_yr_rc_ssnhighissue2 = 5  => 0.2257558791,
											pk_yr_rc_ssnhighissue2 = 6  => 0.1859594384,
											pk_yr_rc_ssnhighissue2 = 7  => 0.1554307116,
											pk_yr_rc_ssnhighissue2 = 8  => 0.1441331709,
											pk_yr_rc_ssnhighissue2 = 9  => 0.1357933579,
											pk_yr_rc_ssnhighissue2 = 10 => 0.1185057965,
											pk_yr_rc_ssnhighissue2 = 11 => 0.1051881994,
											pk_yr_rc_ssnhighissue2 = 12 => 0.0942857143,
											pk_yr_rc_ssnhighissue2 = 13 => 0.0852974186,
																		   0.0861581921));

		pk_pl_sourced_level_mm_b1 := __common__(map(pk_pl_sourced_level = 0 => 0.1519981386,
										 pk_pl_sourced_level = 1 => 0.1504424779,
										 pk_pl_sourced_level = 2 => 0.1093333333,
																	0.0922787194));

		pk_prof_lic_cat_mm_b1 := __common__(map(pk_prof_lic_cat = -1 => 0.1517538815,
									 pk_prof_lic_cat = 0  => 0.1182795699,
									 pk_prof_lic_cat = 1  => 0.0982839314,
									 pk_prof_lic_cat = 2  => 0.0964673913,
															 0.0625));

		pk_add1_lres_mm_b1 := __common__(map(pk_add1_lres = -2 => 0.0588235294,
								  pk_add1_lres = -1 => 0.2782742681,
								  pk_add1_lres = 0  => 0.2759381898,
								  pk_add1_lres = 1  => 0.2388392857,
								  pk_add1_lres = 2  => 0.2046783626,
								  pk_add1_lres = 3  => 0.1702970297,
								  pk_add1_lres = 4  => 0.1945244957,
								  pk_add1_lres = 5  => 0.1576994434,
								  pk_add1_lres = 6  => 0.1572438163,
								  pk_add1_lres = 7  => 0.1424898512,
								  pk_add1_lres = 8  => 0.1123154257,
								  pk_add1_lres = 9  => 0.1109215017,
								  pk_add1_lres = 10 => 0.0990842216,
													   0.0534223706));

		pk_add2_lres_mm_b1 := __common__(map(pk_add2_lres = -2 => 0.2339137017,
								  pk_add2_lres = -1 => 0.1196060038,
								  pk_add2_lres = 0  => 0.1987381703,
								  pk_add2_lres = 1  => 0.1886082751,
								  pk_add2_lres = 2  => 0.1743803466,
								  pk_add2_lres = 3  => 0.1539033457,
								  pk_add2_lres = 4  => 0.1655691439,
								  pk_add2_lres = 5  => 0.1491775383,
								  pk_add2_lres = 6  => 0.1419104574,
								  pk_add2_lres = 7  => 0.1258121677,
								  pk_add2_lres = 8  => 0.1097019658,
								  pk_add2_lres = 9  => 0.1053962901,
													   0.1245136187));

		pk_add3_lres_mm_b1 := __common__(map(pk_add3_lres = -2 => 0.2209912536,
								  pk_add3_lres = -1 => 0.1207826414,
								  pk_add3_lres = 0  => 0.1621334278,
								  pk_add3_lres = 1  => 0.1459767387,
								  pk_add3_lres = 2  => 0.1448547083,
								  pk_add3_lres = 3  => 0.1289104639,
								  pk_add3_lres = 4  => 0.12403698,
								  pk_add3_lres = 5  => 0.1191740413,
													   0.1079478055));

		pk_lres_flag_level_mm_b1 := __common__(map(pk_lres_flag_level = 0 => 0.2695266272,
										pk_lres_flag_level = 1 => 0.1616766467,
																  0.1338472091));

		pk_addrs_5yr_mm_b1 := __common__(map(pk_addrs_5yr = 0 => 0.1084621993,
								  pk_addrs_5yr = 1 => 0.1509279028,
								  pk_addrs_5yr = 2 => 0.177700831,
								  pk_addrs_5yr = 3 => 0.1944592435,
													  0.2165991903));

		pk_addrs_10yr_mm_b1 := __common__(map(pk_addrs_10yr = 0 => 0.1065668203,
								   pk_addrs_10yr = 1 => 0.1401214386,
								   pk_addrs_10yr = 2 => 0.1543307087,
								   pk_addrs_10yr = 3 => 0.1579885877,
														0.1744258225));

		pk_add_lres_month_avg2_mm_b1 := __common__(map(pk_add_lres_month_avg2 = -1 => 0.2236842105,
											pk_add_lres_month_avg2 = 0  => 0.4862385321,
											pk_add_lres_month_avg2 = 1  => 0.34738041,
											pk_add_lres_month_avg2 = 2  => 0.3135245902,
											pk_add_lres_month_avg2 = 3  => 0.2637681159,
											pk_add_lres_month_avg2 = 4  => 0.2204081633,
											pk_add_lres_month_avg2 = 5  => 0.2055749129,
											pk_add_lres_month_avg2 = 6  => 0.201183432,
											pk_add_lres_month_avg2 = 7  => 0.1791859001,
											pk_add_lres_month_avg2 = 8  => 0.1693667158,
											pk_add_lres_month_avg2 = 9  => 0.1552214547,
											pk_add_lres_month_avg2 = 10 => 0.1326606876,
											pk_add_lres_month_avg2 = 11 => 0.1262658228,
											pk_add_lres_month_avg2 = 12 => 0.1172746458,
											pk_add_lres_month_avg2 = 13 => 0.1047202251,
											pk_add_lres_month_avg2 = 15 => 0.0921096071,
																		   0.075));

		pk_nameperssn_count_mm_b1 := __common__(map(pk_nameperssn_count = 0 => 0.1475091341,
										 pk_nameperssn_count = 1 => 0.1593323217,
																	0.3125));

		pk_ssns_per_adl_mm_b1 := __common__(map(pk_ssns_per_adl = -1 => 0.2517985612,
									 pk_ssns_per_adl = 0  => 0.147121698,
									 pk_ssns_per_adl = 1  => 0.1436661332,
									 pk_ssns_per_adl = 2  => 0.1623115578,
									 pk_ssns_per_adl = 3  => 0.168,
															 0.2657657658));

		pk_addrs_per_adl_mm_b1 := __common__(map(pk_addrs_per_adl = -6 => 0.2586206897,
									  pk_addrs_per_adl = -5 => 0.2531120332,
									  pk_addrs_per_adl = -4 => 0.214253291,
									  pk_addrs_per_adl = -3 => 0.1827597728,
									  pk_addrs_per_adl = -2 => 0.1634415004,
									  pk_addrs_per_adl = -1 => 0.1434940095,
									  pk_addrs_per_adl = 0  => 0.1305995865,
									  pk_addrs_per_adl = 1  => 0.1310096154,
									  pk_addrs_per_adl = 2  => 0.1231818182,
															   0.1386623165));

		pk_phones_per_adl_mm_b1 := __common__(map(pk_phones_per_adl = -1 => 0.1686661335,
									   pk_phones_per_adl = 0  => 0.1168595952,
									   pk_phones_per_adl = 1  => 0.1218214075,
																 0.1313868613));

		pk_adlperssn_count_mm_b1 := __common__(map(pk_adlperssn_count = -1 => 0.2314814815,
										pk_adlperssn_count = 0  => 0.1456142574,
										pk_adlperssn_count = 1  => 0.1537928988,
																   0.1509779951));

		pk_adls_per_phone_mm_b1 := __common__(map(pk_adls_per_phone = -2 => 0.1771655629,
									   pk_adls_per_phone = -1 => 0.1226629872,
									   pk_adls_per_phone = 0  => 0.1042535446,
																 0.1231527094));

		pk_ssns_per_adl_c6_mm_b1 := __common__(map(pk_ssns_per_adl_c6 = 0 => 0.1332000592,
										pk_ssns_per_adl_c6 = 1 => 0.186344239,
																  0.2848101266));

		pk_ssns_per_addr_c6_mm_b1 := __common__(map(pk_ssns_per_addr_c6 = 0   => 0.1180482446,
										 pk_ssns_per_addr_c6 = 1   => 0.1659079413,
										 pk_ssns_per_addr_c6 = 2   => 0.1889400922,
										 pk_ssns_per_addr_c6 = 3   => 0.2483221477,
										 pk_ssns_per_addr_c6 = 4   => 0.2408163265,
										 pk_ssns_per_addr_c6 = 5   => 0.25,
										 pk_ssns_per_addr_c6 = 6   => 0.4090909091,
										 pk_ssns_per_addr_c6 = 100 => 0.1987243373,
										 pk_ssns_per_addr_c6 = 101 => 0.2564102564,
										 pk_ssns_per_addr_c6 = 102 => 0.2904761905,
										 pk_ssns_per_addr_c6 = 103 => 0.202247191,
																	  0.3333333333));

		pk_attr_addrs_last90_mm_b1 := __common__(map(pk_attr_addrs_last90 = 0 => 0.1418458466,
										  pk_attr_addrs_last90 = 1 => 0.2166193182,
																	  0.2677419355));

		pk_attr_addrs_last12_mm_b1 := __common__(map(pk_attr_addrs_last12 = 0 => 0.1309481358,
										  pk_attr_addrs_last12 = 1 => 0.171641791,
										  pk_attr_addrs_last12 = 2 => 0.2212160414,
										  pk_attr_addrs_last12 = 3 => 0.2504854369,
																	  0.2857142857));

		pk_attr_addrs_last24_mm_b1 := __common__(map(pk_attr_addrs_last24 = 0 => 0.1226103044,
										  pk_attr_addrs_last24 = 1 => 0.1560566246,
										  pk_attr_addrs_last24 = 2 => 0.1872100061,
										  pk_attr_addrs_last24 = 3 => 0.2194570136,
										  pk_attr_addrs_last24 = 4 => 0.2099447514,
																	  0.2988505747));

		pk_ams_class_level_mm_b1 := __common__(map(pk_ams_class_level = -1000001 => 0.144480126,
										pk_ams_class_level = 0        => 0.4962962963,
										pk_ams_class_level = 1        => 0.3942307692,
										pk_ams_class_level = 2        => 0.3333333333,
										pk_ams_class_level = 3        => 0.2857142857,
										pk_ams_class_level = 4        => 0.2288135593,
										pk_ams_class_level = 5        => 0.2270029674,
										pk_ams_class_level = 6        => 0.1748768473,
										pk_ams_class_level = 7        => 0.1237288136,
										pk_ams_class_level = 8        => 0.1137184116,
										pk_ams_class_level = 1000000  => 0.2408376963,
										pk_ams_class_level = 1000001  => 0.2358490566,
										pk_ams_class_level = 1000002  => 0.1151271754,
										pk_ams_class_level = 1000003  => 0.1486486486,
										pk_ams_class_level = 1000004  => 0.1082802548,
																		 0.09));

		pk_ams_4yr_college_mm_b1 := __common__(map(pk_ams_4yr_college = -1 => 0.1523809524,
										pk_ams_4yr_college = 0  => 0.1487766935,
																   0.1410852713));

		pk_ams_college_type_mm_b1 := __common__(map(pk_ams_college_type = 0 => 0.1488026238,
										 pk_ams_college_type = 1 => 0.1513279802,
																	0.0769230769));

		pk_ams_income_level_code_mm_b1 := __common__(map(pk_ams_income_level_code = -1 => 0.144480126,
											  pk_ams_income_level_code = 0  => 0.255033557,
											  pk_ams_income_level_code = 1  => 0.2150943396,
											  pk_ams_income_level_code = 2  => 0.1970209885,
											  pk_ams_income_level_code = 3  => 0.1719532554,
											  pk_ams_income_level_code = 4  => 0.1452513966,
											  pk_ams_income_level_code = 5  => 0.131147541,
																			   0.1692307692));

		pk_yr_in_dob2_mm_b1 := __common__(map(pk_yr_in_dob2 = 19 => 0.5058548009,
								   pk_yr_in_dob2 = 20 => 0.4474226804,
								   pk_yr_in_dob2 = 21 => 0.4173728814,
								   pk_yr_in_dob2 = 22 => 0.3674242424,
								   pk_yr_in_dob2 = 23 => 0.2916666667,
								   pk_yr_in_dob2 = 25 => 0.2748375116,
								   pk_yr_in_dob2 = 29 => 0.2191283293,
								   pk_yr_in_dob2 = 35 => 0.1654152446,
								   pk_yr_in_dob2 = 38 => 0.1508161817,
								   pk_yr_in_dob2 = 41 => 0.1442646024,
								   pk_yr_in_dob2 = 42 => 0.1371055495,
								   pk_yr_in_dob2 = 43 => 0.1318051576,
								   pk_yr_in_dob2 = 44 => 0.1173020528,
								   pk_yr_in_dob2 = 45 => 0.1154545455,
								   pk_yr_in_dob2 = 47 => 0.095952024,
								   pk_yr_in_dob2 = 49 => 0.1048144433,
								   pk_yr_in_dob2 = 57 => 0.1035039561,
								   pk_yr_in_dob2 = 60 => 0.0924574209,
								   pk_yr_in_dob2 = 63 => 0.0833922261,
														 0.0858718487));

		pk_ams_age_mm_b1 := __common__(map(pk_ams_age = -1 => 0.1443445889,
								pk_ams_age = 21 => 0.5214285714,
								pk_ams_age = 22 => 0.36,
								pk_ams_age = 23 => 0.3465346535,
								pk_ams_age = 24 => 0.3055555556,
								pk_ams_age = 25 => 0.212962963,
								pk_ams_age = 29 => 0.2386363636,
												   0.1368977673));

		pk_inferred_age_mm_b1 := __common__(map(pk_inferred_age = -1 => 0.1764705882,
									 pk_inferred_age = 18 => 0.4617834395,
									 pk_inferred_age = 19 => 0.4142538976,
									 pk_inferred_age = 20 => 0.4206008584,
									 pk_inferred_age = 21 => 0.3752310536,
									 pk_inferred_age = 22 => 0.3333333333,
									 pk_inferred_age = 24 => 0.264604811,
									 pk_inferred_age = 34 => 0.1854077253,
									 pk_inferred_age = 37 => 0.1558441558,
									 pk_inferred_age = 41 => 0.1412012645,
									 pk_inferred_age = 42 => 0.1271676301,
									 pk_inferred_age = 43 => 0.1217137293,
									 pk_inferred_age = 44 => 0.1126885537,
									 pk_inferred_age = 46 => 0.1021233569,
									 pk_inferred_age = 48 => 0.1078234704,
									 pk_inferred_age = 52 => 0.100260794,
									 pk_inferred_age = 56 => 0.1035372144,
									 pk_inferred_age = 59 => 0.096453018,
									 pk_inferred_age = 63 => 0.0882352941,
															 0.087831923));

		pk_yr_reported_dob2_mm_b1 := __common__(map(pk_yr_reported_dob2 = -1 => 0.295154185,
										 pk_yr_reported_dob2 = 19 => 0.5609756098,
										 pk_yr_reported_dob2 = 21 => 0.4117647059,
										 pk_yr_reported_dob2 = 22 => 0.4077669903,
										 pk_yr_reported_dob2 = 23 => 0.3790322581,
										 pk_yr_reported_dob2 = 32 => 0.1926298157,
										 pk_yr_reported_dob2 = 35 => 0.1517564403,
										 pk_yr_reported_dob2 = 39 => 0.147942158,
										 pk_yr_reported_dob2 = 42 => 0.1449908925,
										 pk_yr_reported_dob2 = 43 => 0.1301775148,
										 pk_yr_reported_dob2 = 44 => 0.121031746,
										 pk_yr_reported_dob2 = 45 => 0.114075437,
										 pk_yr_reported_dob2 = 46 => 0.1024590164,
										 pk_yr_reported_dob2 = 49 => 0.1057985758,
										 pk_yr_reported_dob2 = 57 => 0.1026490066,
										 pk_yr_reported_dob2 = 60 => 0.0970752956,
										 pk_yr_reported_dob2 = 63 => 0.0865384615,
																	 0.0885805763));

		pk_avm_hit_level_mm_b1 := __common__(map(pk_avm_hit_level = -1 => 0.1630123928,
									  pk_avm_hit_level = 0  => 0.1648720938,
									  pk_avm_hit_level = 1  => 0.1384919143,
															   0.1238881011));

		pk_avm_auto_diff2_lvl_mm_b1 := __common__(map(pk_avm_auto_diff2_lvl = -2 => 0.1632108707,
										   pk_avm_auto_diff2_lvl = -1 => 0.14188367,
										   pk_avm_auto_diff2_lvl = 0  => 0.1340315726,
										   pk_avm_auto_diff2_lvl = 1  => 0.125146886,
																		 0.1162324649));

		pk_avm_auto_diff4_lvl_mm_b1 := __common__(map(pk_avm_auto_diff4_lvl = -1 => 0.1478389482,
										   pk_avm_auto_diff4_lvl = 0  => 0.1504871887,
																		 0.1579384871));

		pk_add2_avm_auto_diff2_lvl_mm_b1 := __common__(map(pk_add2_avm_auto_diff2_lvl = -3 => 0.1537387527,
												pk_add2_avm_auto_diff2_lvl = -2 => 0.1599264706,
												pk_add2_avm_auto_diff2_lvl = -1 => 0.139874739,
												pk_add2_avm_auto_diff2_lvl = 0  => 0.1373710775,
																				   0.1339993111));

		pk2_add1_avm_mkt_mm_b1 := __common__(map(pk2_add1_avm_mkt = 0 => 0.1813084112,
									  pk2_add1_avm_mkt = 1 => 0.1543979927,
									  pk2_add1_avm_mkt = 2 => 0.1307829181,
									  pk2_add1_avm_mkt = 3 => 0.1210358416,
															  0.0884955752));

		pk2_add1_avm_pi_mm_b1 := __common__(map(pk2_add1_avm_pi = 0 => 0.203125,
									 pk2_add1_avm_pi = 1 => 0.1447039199,
									 pk2_add1_avm_pi = 2 => 0.1515900187,
															0.1353192838));

		pk2_add1_avm_hed_mm_b1 := __common__(map(pk2_add1_avm_hed = 0 => 0.2387096774,
									  pk2_add1_avm_hed = 1 => 0.1788461538,
									  pk2_add1_avm_hed = 2 => 0.1567080045,
									  pk2_add1_avm_hed = 3 => 0.1579740081,
									  pk2_add1_avm_hed = 4 => 0.1402251791,
									  pk2_add1_avm_hed = 5 => 0.1265290877,
															  0.1001890359));

		pk2_add1_avm_auto2_mm_b1 := __common__(map(pk2_add1_avm_auto2 = 0 => 0.2051282051,
										pk2_add1_avm_auto2 = 1 => 0.1955922865,
										pk2_add1_avm_auto2 = 2 => 0.1897058824,
										pk2_add1_avm_auto2 = 3 => 0.1503984064,
										pk2_add1_avm_auto2 = 4 => 0.1632108707,
										pk2_add1_avm_auto2 = 5 => 0.1410095953,
										pk2_add1_avm_auto2 = 6 => 0.1242241165,
																  0.0990853659));

		pk2_add1_avm_auto4_mm_b1 := __common__(map(pk2_add1_avm_auto4 = 0 => 0.2237442922,
										pk2_add1_avm_auto4 = 1 => 0.1814516129,
										pk2_add1_avm_auto4 = 2 => 0.2018779343,
										pk2_add1_avm_auto4 = 3 => 0.148552686,
										pk2_add1_avm_auto4 = 4 => 0.1428571429,
										pk2_add1_avm_auto4 = 5 => 0.1375061607,
																  0.1123188406));

		pk2_add1_avm_med_mm_b1 := __common__(map(pk2_add1_avm_med = 0 => 0.2820512821,
									  pk2_add1_avm_med = 1 => 0.233256351,
									  pk2_add1_avm_med = 2 => 0.1797101449,
									  pk2_add1_avm_med = 3 => 0.1794724771,
									  pk2_add1_avm_med = 4 => 0.1608801956,
									  pk2_add1_avm_med = 5 => 0.1466846838,
									  pk2_add1_avm_med = 6 => 0.1085714286,
															  0.1328805741));

		pk2_add1_avm_to_med_ratio_mm_b1 := __common__(map(pk2_add1_avm_to_med_ratio = 0 => 0.1622576596,
											   pk2_add1_avm_to_med_ratio = 1 => 0.1277402536,
											   pk2_add1_avm_to_med_ratio = 2 => 0.1318591319,
											   pk2_add1_avm_to_med_ratio = 3 => 0.1383360522,
											   pk2_add1_avm_to_med_ratio = 4 => 0.1279569892,
																				0.1133757962));

		pk2_add2_avm_mkt_mm_b1 := __common__(map(pk2_add2_avm_mkt = 0 => 0.1952506596,
									  pk2_add2_avm_mkt = 1 => 0.1790123457,
									  pk2_add2_avm_mkt = 2 => 0.1508286959,
									  pk2_add2_avm_mkt = 3 => 0.1170997754,
															  0.0725806452));

		pk2_add2_avm_pi_mm_b1 := __common__(map(pk2_add2_avm_pi = 0 => 0.1944444444,
									 pk2_add2_avm_pi = 1 => 0.1600587372,
									 pk2_add2_avm_pi = 2 => 0.1514713301,
									 pk2_add2_avm_pi = 3 => 0.1348684211,
															0.1024464832));

		pk2_add2_avm_hed_mm_b1 := __common__(map(pk2_add2_avm_hed = 0 => 0.265625,
									  pk2_add2_avm_hed = 1 => 0.2138263666,
									  pk2_add2_avm_hed = 2 => 0.1544401544,
									  pk2_add2_avm_hed = 3 => 0.1519921299,
									  pk2_add2_avm_hed = 4 => 0.1456538763,
									  pk2_add2_avm_hed = 5 => 0.1257861635,
															  0.1162790698));

		pk2_add2_avm_auto4_mm_b1 := __common__(map(pk2_add2_avm_auto4 = 0 => 0.2717948718,
										pk2_add2_avm_auto4 = 1 => 0.2164502165,
										pk2_add2_avm_auto4 = 2 => 0.1900311526,
										pk2_add2_avm_auto4 = 3 => 0.1476777829,
										pk2_add2_avm_auto4 = 4 => 0.1438501058,
																  0.1182795699));

		pk2_yr_add1_avm_rec_dt_mm_b1 := __common__(map(pk2_yr_add1_avm_recording_date = 0 => 0.1537881643,
											pk2_yr_add1_avm_recording_date = 1 => 0.1473183978,
											pk2_yr_add1_avm_recording_date = 2 => 0.1545326994,
											pk2_yr_add1_avm_recording_date = 3 => 0.1260952381,
																				  0.1264044944));

		pk2_yr_add1_avm_assess_year_mm_b1 := __common__(map(pk2_yr_add1_avm_assess_year = 0 => 0.1618631594,
												 pk2_yr_add1_avm_assess_year = 1 => 0.1438498958,
																					0.124118613));

		pk2_yr_add2_avm_assess_year_mm_b1 := __common__(map(pk2_yr_add2_avm_assess_year = 0 => 0.1527727829,
												 pk2_yr_add2_avm_assess_year = 1 => 0.1546541108,
																					0.1282750265));

		pk_dist_a1toa2_mm_b1 := __common__(map(pk_dist_a1toa2_2 = 0 => 0.1361712721,
									pk_dist_a1toa2_2 = 1 => 0.1423196585,
									pk_dist_a1toa2_2 = 2 => 0.1584211949,
									pk_dist_a1toa2_2 = 3 => 0.1749258789,
															0.2137751787));

		pk_dist_a1toa3_mm_b1 := __common__(map(pk_dist_a1toa3_2 = 0 => 0.1373958333,
									pk_dist_a1toa3_2 = 1 => 0.1292563334,
									pk_dist_a1toa3_2 = 2 => 0.144724314,
									pk_dist_a1toa3_2 = 3 => 0.1570773032,
									pk_dist_a1toa3_2 = 4 => 0.1639941691,
									pk_dist_a1toa3_2 = 5 => 0.1668806162,
															0.2118667028));

		pk_rc_disthphoneaddr_mm_b1 := __common__(map(pk_rc_disthphoneaddr_2 = 0 => 0.1141722194,
										  pk_rc_disthphoneaddr_2 = 1 => 0.1402293359,
										  pk_rc_disthphoneaddr_2 = 2 => 0.1542288557,
										  pk_rc_disthphoneaddr_2 = 3 => 0.1643835616,
																		0.1824121808));

		pk_out_st_division_lvl_mm_b1 := __common__(map(pk_out_st_division_lvl = -1 => 0.0710059172,
											pk_out_st_division_lvl = 0  => 0.1295387635,
											pk_out_st_division_lvl = 1  => 0.1419770774,
											pk_out_st_division_lvl = 2  => 0.1341513292,
											pk_out_st_division_lvl = 3  => 0.1593838416,
											pk_out_st_division_lvl = 4  => 0.1496485166,
											pk_out_st_division_lvl = 5  => 0.1481936163,
											pk_out_st_division_lvl = 6  => 0.1387596899,
											pk_out_st_division_lvl = 7  => 0.1645710059,
																		   0.1996445498));

		pk_wealth_index_mm_b1 := __common__(map(pk_wealth_index_2 = 0 => 0.1800802776,
									 pk_wealth_index_2 = 1 => 0.1514459665,
									 pk_wealth_index_2 = 2 => 0.1461293128,
									 pk_wealth_index_2 = 3 => 0.1243213898,
															  0.099157253));

		pk_impulse_count_mm_b1 := __common__(map(pk_impulse_count_2 = 0 => 0.1309189036,
									  pk_impulse_count_2 = 1 => 0.4511149228,
																0.5740740741));

		pk_attr_num_nonderogs90_b_mm_b1 := __common__(map(pk_attr_num_nonderogs90_b = 0  => 0.2469635628,
											   pk_attr_num_nonderogs90_b = 1  => 0.2639553429,
											   pk_attr_num_nonderogs90_b = 2  => 0.1641742523,
											   pk_attr_num_nonderogs90_b = 3  => 0.115640599,
											   pk_attr_num_nonderogs90_b = 4  => 0.0903010033,
											   pk_attr_num_nonderogs90_b = 10 => 0.1052631579,
											   pk_attr_num_nonderogs90_b = 11 => 0.1698940748,
											   pk_attr_num_nonderogs90_b = 12 => 0.1135498717,
											   pk_attr_num_nonderogs90_b = 13 => 0.0919839205,
																				 0.0728051392));

		pk_ssns_per_addr2_mm_b1 := __common__(map(pk_ssns_per_addr2 = -101 => 0.2109522525,
									   pk_ssns_per_addr2 = -2   => 0.1523378582,
									   pk_ssns_per_addr2 = -1   => 0.1397058824,
									   pk_ssns_per_addr2 = 0    => 0.0894225856,
									   pk_ssns_per_addr2 = 1    => 0.1038511467,
									   pk_ssns_per_addr2 = 2    => 0.1076809996,
									   pk_ssns_per_addr2 = 3    => 0.1242281148,
									   pk_ssns_per_addr2 = 4    => 0.1152815013,
									   pk_ssns_per_addr2 = 5    => 0.1331360947,
									   pk_ssns_per_addr2 = 6    => 0.1354656632,
									   pk_ssns_per_addr2 = 7    => 0.1298129813,
									   pk_ssns_per_addr2 = 8    => 0.153054221,
									   pk_ssns_per_addr2 = 9    => 0.1458531935,
									   pk_ssns_per_addr2 = 10   => 0.1783612494,
									   pk_ssns_per_addr2 = 11   => 0.1746379991,
									   pk_ssns_per_addr2 = 12   => 0.2386980108,
									   pk_ssns_per_addr2 = 100  => 0.1545454545,
									   pk_ssns_per_addr2 = 101  => 0.1812865497,
									   pk_ssns_per_addr2 = 102  => 0.2067307692,
																   0.2222222222));

		pk_yr_prop1_prev_purch_dt2_mm_b1 := __common__(map(pk_yr_prop1_prev_purchase_date2 = -1 => 0.1516472024,
												pk_yr_prop1_prev_purchase_date2 = 0  => 0.1444759207,
												pk_yr_prop1_prev_purchase_date2 = 1  => 0.135371179,
												pk_yr_prop1_prev_purchase_date2 = 2  => 0.125984252,
												pk_yr_prop1_prev_purchase_date2 = 3  => 0.1300813008,
												pk_yr_prop1_prev_purchase_date2 = 4  => 0.0984340045,
												pk_yr_prop1_prev_purchase_date2 = 5  => 0.095505618,
												pk_yr_prop1_prev_purchase_date2 = 6  => 0.0987951807,
																						0.0825892857));

		pk_estimated_income_mm_b2 := __common__(map(pk_estimated_income = -1 => 0.1020408163,
										 pk_estimated_income = 0  => 0,
										 pk_estimated_income = 1  => 0.097826087,
										 pk_estimated_income = 2  => 0.1101694915,
										 pk_estimated_income = 3  => 0.0867768595,
										 pk_estimated_income = 4  => 0.1020408163,
										 pk_estimated_income = 5  => 0.0663983903,
										 pk_estimated_income = 6  => 0.049689441,
										 pk_estimated_income = 7  => 0.0393096836,
										 pk_estimated_income = 8  => 0.0386597938,
										 pk_estimated_income = 9  => 0.051874679,
										 pk_estimated_income = 10 => 0.0462222222,
										 pk_estimated_income = 11 => 0.0488953278,
										 pk_estimated_income = 12 => 0.0459150327,
										 pk_estimated_income = 13 => 0.0438003221,
										 pk_estimated_income = 14 => 0.0433774834,
										 pk_estimated_income = 15 => 0.0415282392,
										 pk_estimated_income = 16 => 0.0422735346,
										 pk_estimated_income = 17 => 0.0451282051,
										 pk_estimated_income = 18 => 0.0398908967,
										 pk_estimated_income = 19 => 0.0386447856,
										 pk_estimated_income = 20 => 0.0349805938,
										 pk_estimated_income = 21 => 0.0357142857,
																	 0.0213836478));

		pk_yr_adl_w_first_seen2_mm_b2 := __common__(map(pk_yr_adl_w_first_seen2 = -1 => 0.0407895751,
											 pk_yr_adl_w_first_seen2 = 0  => 0.0501792115,
											 pk_yr_adl_w_first_seen2 = 1  => 0.0245388669,
																			 0.024691358));

		pk_yr_adl_w_last_seen2_mm_b2 := __common__(map(pk_yr_adl_w_last_seen2 = -1 => 0.0407895751,
											pk_yr_adl_w_last_seen2 = 0  => 0.0214477212,
											pk_yr_adl_w_last_seen2 = 1  => 0.0314136126,
																		   0.0319121777));

		pk_pr_count_mm_b2 := __common__(map(pk_pr_count = -1 => 0.0666764792,
								 pk_pr_count = 0  => 0.0322777632,
								 pk_pr_count = 1  => 0.039214245,
													 0.04744255));

		pk_addrs_sourced_lvl_mm_b2 := __common__(map(pk_addrs_sourced_lvl = 0 => 0.0412749058,
										  pk_addrs_sourced_lvl = 1 => 0.0389666619,
										  pk_addrs_sourced_lvl = 2 => 0.0418479721,
																	  0.0352481203));

		pk_add2_own_level_mm_b2 := __common__(map(pk_add2_own_level = 0 => 0.0387577432,
									   pk_add2_own_level = 1 => 0.0400340716,
									   pk_add2_own_level = 2 => 0.048088411,
																0.0393420255));

		pk_add3_own_level_mm_b2 := __common__(map(pk_add3_own_level = 0 => 0.0391211764,
									   pk_add3_own_level = 1 => 0.0409382607,
									   pk_add3_own_level = 2 => 0.0533333333,
																0.0367058195));

		pk_naprop_level2_mm_b2 := __common__(map(pk_naprop_level2 = -2 => 0.0727272727,
									  pk_naprop_level2 = -1 => 0.0637408568,
									  pk_naprop_level2 = 0  => 0.0506912442,
									  pk_naprop_level2 = 1  => 0.0447761194,
									  pk_naprop_level2 = 2  => 0.0495790458,
									  pk_naprop_level2 = 3  => 0.0373134328,
									  pk_naprop_level2 = 4  => 0.0717557252,
									  pk_naprop_level2 = 5  => 0.0463981632,
									  pk_naprop_level2 = 6  => 0.0383862439,
															   0.0317124736));

		pk_yr_add1_purchase_date2_mm_b2 := __common__(map(pk_yr_add1_purchase_date2 = -1 => 0.0367294105,
											   pk_yr_add1_purchase_date2 = 0  => 0.0590366842,
											   pk_yr_add1_purchase_date2 = 1  => 0.0442764579,
											   pk_yr_add1_purchase_date2 = 2  => 0.0331806711,
											   pk_yr_add1_purchase_date2 = 3  => 0.0265162614,
											   pk_yr_add1_purchase_date2 = 4  => 0.0210497161,
																				 0.0184967704));

		pk_yr_add1_built_date2_mm_b2 := __common__(map(pk_yr_add1_built_date2 = -4 => 0.0424802015,
											pk_yr_add1_built_date2 = -3 => 0.0883977901,
											pk_yr_add1_built_date2 = -2 => 0.0530660377,
											pk_yr_add1_built_date2 = -1 => 0.0421653972,
											pk_yr_add1_built_date2 = 0  => 0.0301528954,
											pk_yr_add1_built_date2 = 1  => 0.0317594493,
											pk_yr_add1_built_date2 = 2  => 0.0381128765,
																		   0.0484956014));

		pk_yr_add1_mortgage_date2_mm_b2 := __common__(map(pk_yr_add1_mortgage_date2 = -1 => 0.0325886298,
											   pk_yr_add1_mortgage_date2 = 0  => 0.0655355008,
											   pk_yr_add1_mortgage_date2 = 1  => 0.0446538304,
																				 0.0293261022));

		pk_add1_mortgage_risk_mm_b2 := __common__(map(pk_add1_mortgage_risk = -1 => 0.0131578947,
										   pk_add1_mortgage_risk = 0  => 0.0374766458,
										   pk_add1_mortgage_risk = 1  => 0.0359038066,
										   pk_add1_mortgage_risk = 2  => 0.055954353,
																		 0.071151814));

		pk_add1_assessed_amount2_mm_b2 := __common__(map(pk_add1_assessed_amount2 = -1 => 0.0458111328,
											  pk_add1_assessed_amount2 = 0  => 0.0536801328,
											  pk_add1_assessed_amount2 = 1  => 0.0542669584,
											  pk_add1_assessed_amount2 = 2  => 0.0461725395,
											  pk_add1_assessed_amount2 = 3  => 0.0387374462,
											  pk_add1_assessed_amount2 = 4  => 0.0377900299,
											  pk_add1_assessed_amount2 = 5  => 0.031992002,
																			   0.0288276209));

		pk_yr_add1_date_first_seen2_mm_b2 := __common__(map(pk_yr_add1_date_first_seen2 = -1 => 0.0757990868,
												 pk_yr_add1_date_first_seen2 = 0  => 0.0726909482,
												 pk_yr_add1_date_first_seen2 = 1  => 0.0611128478,
												 pk_yr_add1_date_first_seen2 = 2  => 0.0582743078,
												 pk_yr_add1_date_first_seen2 = 3  => 0.0474604496,
												 pk_yr_add1_date_first_seen2 = 4  => 0.0461956522,
												 pk_yr_add1_date_first_seen2 = 5  => 0.0383448705,
												 pk_yr_add1_date_first_seen2 = 6  => 0.0315626321,
												 pk_yr_add1_date_first_seen2 = 7  => 0.0247941282,
												 pk_yr_add1_date_first_seen2 = 8  => 0.0220506046,
												 pk_yr_add1_date_first_seen2 = 9  => 0.0191082803,
																					 0.013842913));

		pk_add1_building_area2_mm_b2 := __common__(map(pk_add1_building_area2 = -99 => 0.0426362352,
											pk_add1_building_area2 = -4  => 0.0570599613,
											pk_add1_building_area2 = -3  => 0.0532807104,
											pk_add1_building_area2 = -2  => 0.042873941,
											pk_add1_building_area2 = -1  => 0.026962728,
											pk_add1_building_area2 = 0   => 0.0290979631,
											pk_add1_building_area2 = 1   => 0.0310421286,
											pk_add1_building_area2 = 2   => 0.0545454545,
											pk_add1_building_area2 = 3   => 0.0288184438,
																			0.0620155039));

		pk_add1_no_of_baths_mm_b2 := __common__(map(pk_add1_no_of_baths = -3 => 0.0422922394,
										 pk_add1_no_of_baths = -2 => 0.0441788883,
										 pk_add1_no_of_baths = -1 => 0.0361109068,
										 pk_add1_no_of_baths = 0  => 0.0296840558,
										 pk_add1_no_of_baths = 1  => 0.0394021739,
																	 0.0492753623));

		pk_property_owned_total_mm_b2 := __common__(map(pk_property_owned_total = -1 => 0.0541303836,
											 pk_property_owned_total = 0  => 0.040794554,
											 pk_property_owned_total = 1  => 0.034308827,
											 pk_property_owned_total = 2  => 0.0294117647,
																			 0.0205128205));

		pk_prop_own_assess_tot2_mm_b2 := __common__(map(pk_prop_own_assess_tot2 = 0 => 0.0465051861,
											 pk_prop_own_assess_tot2 = 1 => 0.0523092,
											 pk_prop_own_assess_tot2 = 2 => 0.0389290538,
											 pk_prop_own_assess_tot2 = 3 => 0.031835536,
																			0.0276573381));

		pk_prop1_sale_price2_mm_b2 := __common__(map(pk_prop1_sale_price2 = 0 => 0.0400438466,
										  pk_prop1_sale_price2 = 1 => 0.0631578947,
																	  0.0361543304));

		pk_add2_land_use_risk_level_mm_b2 := __common__(map(pk_add2_land_use_risk_level = 0 => 0.0208816705,
												 pk_add2_land_use_risk_level = 2 => 0.0396825397,
												 pk_add2_land_use_risk_level = 3 => 0.0393095927,
																					0.0506082725));

		pk_add2_building_area2_mm_b2 := __common__(map(pk_add2_building_area2 = -4 => 0.0386843765,
											pk_add2_building_area2 = -3 => 0.0452358037,
											pk_add2_building_area2 = -2 => 0.0449886105,
											pk_add2_building_area2 = -1 => 0.0427628338,
											pk_add2_building_area2 = 0  => 0.0356534696,
											pk_add2_building_area2 = 1  => 0.0588235294,
																		   0.0377562028));

		pk_add2_no_of_baths_mm_b2 := __common__(map(pk_add2_no_of_baths = -3 => 0.0388417951,
										 pk_add2_no_of_baths = -2 => 0.0413540394,
										 pk_add2_no_of_baths = -1 => 0.0411576002,
										 pk_add2_no_of_baths = 0  => 0.0396877033,
										 pk_add2_no_of_baths = 1  => 0.0379310345,
																	 0.0532994924));

		pk_yr_add2_mortgage_date2_mm_b2 := __common__(map(pk_yr_add2_mortgage_date2 = -1 => 0.0368159651,
											   pk_yr_add2_mortgage_date2 = 0  => 0.0548366225,
																				 0.040140172));

		pk_add2_mortgage_risk_mm_b2 := __common__(map(pk_add2_mortgage_risk = -1 => 0.0281690141,
										   pk_add2_mortgage_risk = 0  => 0.0444905486,
										   pk_add2_mortgage_risk = 1  => 0.0381345541,
										   pk_add2_mortgage_risk = 2  => 0.0483329026,
																		 0.055089192));

		pk_yr_add2_mortgage_due_date2_mm_b2 := __common__(map(pk_yr_add2_mortgage_due_date2 = -1 => 0.0374530719,
												   pk_yr_add2_mortgage_due_date2 = 0  => 0.0369989723,
												   pk_yr_add2_mortgage_due_date2 = 1  => 0.044814641,
												   pk_yr_add2_mortgage_due_date2 = 2  => 0.0378967314,
																						 0.0548941799));

		pk_add2_assessed_amount2_mm_b2 := __common__(map(pk_add2_assessed_amount2 = -1 => 0.0405856352,
											  pk_add2_assessed_amount2 = 0  => 0.0428990141,
											  pk_add2_assessed_amount2 = 1  => 0.0408615137,
											  pk_add2_assessed_amount2 = 2  => 0.0345224396,
											  pk_add2_assessed_amount2 = 3  => 0.0358230342,
																			   0.0371721383));

		pk_yr_add2_date_first_seen2_mm_b2 := __common__(map(pk_yr_add2_date_first_seen2 = -1 => 0.0494157741,
												 pk_yr_add2_date_first_seen2 = 0  => 0.0683918669,
												 pk_yr_add2_date_first_seen2 = 1  => 0.0593824228,
												 pk_yr_add2_date_first_seen2 = 2  => 0.0488088321,
												 pk_yr_add2_date_first_seen2 = 3  => 0.0526127416,
												 pk_yr_add2_date_first_seen2 = 4  => 0.0430247718,
												 pk_yr_add2_date_first_seen2 = 5  => 0.0440664071,
												 pk_yr_add2_date_first_seen2 = 6  => 0.0456818182,
												 pk_yr_add2_date_first_seen2 = 7  => 0.034137577,
												 pk_yr_add2_date_first_seen2 = 8  => 0.0320170758,
												 pk_yr_add2_date_first_seen2 = 9  => 0.0267272929,
												 pk_yr_add2_date_first_seen2 = 10 => 0.019907909,
																					 0.0161595574));

		pk_add3_mortgage_risk_mm_b2 := __common__(map(pk_add3_mortgage_risk = -1 => 0.0151515152,
										   pk_add3_mortgage_risk = 0  => 0.0404354588,
										   pk_add3_mortgage_risk = 1  => 0.0349344978,
										   pk_add3_mortgage_risk = 2  => 0.0389889507,
										   pk_add3_mortgage_risk = 3  => 0.0400130124,
										   pk_add3_mortgage_risk = 4  => 0.0581027668,
																		 0.0469924812));

		pk_add3_assessed_amount2_mm_b2 := __common__(map(pk_add3_assessed_amount2 = -1 => 0.0406781266,
											  pk_add3_assessed_amount2 = 0  => 0.0437931034,
											  pk_add3_assessed_amount2 = 1  => 0.0446035242,
											  pk_add3_assessed_amount2 = 2  => 0.0349907919,
																			   0.0346785465));

		pk_yr_add3_date_first_seen2_mm_b2 := __common__(map(pk_yr_add3_date_first_seen2 = -1 => 0.0426034468,
												 pk_yr_add3_date_first_seen2 = 0  => 0.0734351897,
												 pk_yr_add3_date_first_seen2 = 1  => 0.0648899189,
												 pk_yr_add3_date_first_seen2 = 2  => 0.0555793991,
												 pk_yr_add3_date_first_seen2 = 3  => 0.0550122249,
												 pk_yr_add3_date_first_seen2 = 4  => 0.0497319833,
												 pk_yr_add3_date_first_seen2 = 5  => 0.0491642085,
												 pk_yr_add3_date_first_seen2 = 6  => 0.037765612,
												 pk_yr_add3_date_first_seen2 = 7  => 0.0328782086,
												 pk_yr_add3_date_first_seen2 = 8  => 0.0266401214,
																					 0.0188767917));

		pk_w_count_mm_b2 := __common__(map(pk_w_count = 0 => 0.0407947906,
								pk_w_count = 1 => 0.0286152274,
												  0.0277341706));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_bk_level_mm_b2 := __common__(if(pk_bk_level_2 = 0, 0.0396663859, NULL));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_eviction_level_mm_b2 := __common__(if(pk_eviction_level = 0, 0.0396663859, NULL));

		pk_lien_type_level_mm_b2 := __common__(map(pk_lien_type_level = 0 => 0.0396471648,
										pk_lien_type_level = 1 => 0,
										pk_lien_type_level = 3 => 0.4,
																  0));

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		pk_yr_liens_last_unrel_date3_mm_b2 := __common__(if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0396663859, NULL));

		pk_yr_ln_unrel_cj_f_sn2_mm_b2 := __common__(map(pk_yr_liens_unrel_cj_first_sn2 = -1 => 0.0396551522,
																					1));

		pk_yr_ln_unrel_lt_f_sn2_mm_b2 := __common__(if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.0396663859, NULL));
		pk_yr_ln_unrel_ot_f_sn2_mm_b2 := __common__(if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.0396663859, NULL));
		pk_yr_criminal_last_date2_mm_b2 := __common__(if(pk_yr_criminal_last_date2 = -1, 0.0396663859, NULL));
		pk_yr_felony_last_date2_mm_b2 := __common__(if(pk_yr_felony_last_date2 = -1, 0.0396663859, NULL));
		pk_attr_total_number_derogs_mm_b2 := __common__(if(pk_attr_total_number_derogs_5 = 0, 0.0396663859, NULL));

		pk_yr_rc_ssnhighissue2_mm_b2 := __common__(map(pk_yr_rc_ssnhighissue2 = -1 => 0.0865384615,
											pk_yr_rc_ssnhighissue2 = 0  => 0.0392156863,
											pk_yr_rc_ssnhighissue2 = 1  => 0.0645994832,
											pk_yr_rc_ssnhighissue2 = 2  => 0.081702544,
											pk_yr_rc_ssnhighissue2 = 3  => 0.0773026316,
											pk_yr_rc_ssnhighissue2 = 4  => 0.0900131406,
											pk_yr_rc_ssnhighissue2 = 5  => 0.0710894392,
											pk_yr_rc_ssnhighissue2 = 6  => 0.0574733096,
											pk_yr_rc_ssnhighissue2 = 7  => 0.0515893695,
											pk_yr_rc_ssnhighissue2 = 8  => 0.0486322188,
											pk_yr_rc_ssnhighissue2 = 9  => 0.0440178958,
											pk_yr_rc_ssnhighissue2 = 10 => 0.0330755139,
											pk_yr_rc_ssnhighissue2 = 11 => 0.0293838112,
											pk_yr_rc_ssnhighissue2 = 12 => 0.0184376516,
											pk_yr_rc_ssnhighissue2 = 13 => 0.0195205479,
																		   0.0134479718));

		pk_pl_sourced_level_mm_b2 := __common__(map(pk_pl_sourced_level = 0 => 0.0404978347,
										 pk_pl_sourced_level = 1 => 0.0485762144,
										 pk_pl_sourced_level = 2 => 0.032195122,
																	0.0297588507));

		pk_prof_lic_cat_mm_b2 := __common__(map(pk_prof_lic_cat = -1 => 0.0404334445,
									 pk_prof_lic_cat = 0  => 0.0465373961,
									 pk_prof_lic_cat = 1  => 0.0369420215,
									 pk_prof_lic_cat = 2  => 0.0263063063,
															 0.0091930541));

		pk_add1_lres_mm_b2 := __common__(map(pk_add1_lres = -2 => 0.028340081,
								  pk_add1_lres = -1 => 0.0756680731,
								  pk_add1_lres = 0  => 0.0795918367,
								  pk_add1_lres = 1  => 0.0423011844,
								  pk_add1_lres = 2  => 0.048513302,
								  pk_add1_lres = 3  => 0.0716332378,
								  pk_add1_lres = 4  => 0.0621925509,
								  pk_add1_lres = 5  => 0.0532395781,
								  pk_add1_lres = 6  => 0.0545857217,
								  pk_add1_lres = 7  => 0.0462028678,
								  pk_add1_lres = 8  => 0.0359693203,
								  pk_add1_lres = 9  => 0.0293228537,
								  pk_add1_lres = 10 => 0.0232734069,
													   0.0170909091));

		pk_add2_lres_mm_b2 := __common__(map(pk_add2_lres = -2 => 0.0481296758,
								  pk_add2_lres = -1 => 0.0280078619,
								  pk_add2_lres = 0  => 0.0524475524,
								  pk_add2_lres = 1  => 0.0522070015,
								  pk_add2_lres = 2  => 0.0524891138,
								  pk_add2_lres = 3  => 0.0538745387,
								  pk_add2_lres = 4  => 0.0476610768,
								  pk_add2_lres = 5  => 0.0472870183,
								  pk_add2_lres = 6  => 0.0411516315,
								  pk_add2_lres = 7  => 0.0355635154,
								  pk_add2_lres = 8  => 0.0283668783,
								  pk_add2_lres = 9  => 0.0228471002,
													   0.0220858896));

		pk_add3_lres_mm_b2 := __common__(map(pk_add3_lres = -2 => 0.0429425944,
								  pk_add3_lres = -1 => 0.0321613064,
								  pk_add3_lres = 0  => 0.0490050348,
								  pk_add3_lres = 1  => 0.0439900131,
								  pk_add3_lres = 2  => 0.0393983612,
								  pk_add3_lres = 3  => 0.0406525117,
								  pk_add3_lres = 4  => 0.0321223709,
								  pk_add3_lres = 5  => 0.0285087719,
													   0.0252143217));

		pk_lres_flag_level_mm_b2 := __common__(map(pk_lres_flag_level = 0 => 0.0725933719,
										pk_lres_flag_level = 1 => 0.0302349689,
																  0.039438026));

		pk_addrs_5yr_mm_b2 := __common__(map(pk_addrs_5yr = 0 => 0.0262141968,
								  pk_addrs_5yr = 1 => 0.0410699401,
								  pk_addrs_5yr = 2 => 0.0624084919,
								  pk_addrs_5yr = 3 => 0.0806451613,
													  0.1009009009));

		pk_addrs_10yr_mm_b2 := __common__(map(pk_addrs_10yr = 0 => 0.0218149534,
								   pk_addrs_10yr = 1 => 0.0297603644,
								   pk_addrs_10yr = 2 => 0.0466958607,
								   pk_addrs_10yr = 3 => 0.0708173503,
														0.0702426564));

		pk_add_lres_month_avg2_mm_b2 := __common__(map(pk_add_lres_month_avg2 = -1 => 0.1089588378,
											pk_add_lres_month_avg2 = 0  => 0.2195121951,
											pk_add_lres_month_avg2 = 1  => 0.1127717391,
											pk_add_lres_month_avg2 = 2  => 0.1046277666,
											pk_add_lres_month_avg2 = 3  => 0.0940892642,
											pk_add_lres_month_avg2 = 4  => 0.096345515,
											pk_add_lres_month_avg2 = 5  => 0.0751697381,
											pk_add_lres_month_avg2 = 6  => 0.0792838875,
											pk_add_lres_month_avg2 = 7  => 0.0753246753,
											pk_add_lres_month_avg2 = 8  => 0.0602692883,
											pk_add_lres_month_avg2 = 9  => 0.0544683627,
											pk_add_lres_month_avg2 = 10 => 0.0418489633,
											pk_add_lres_month_avg2 = 11 => 0.0362229102,
											pk_add_lres_month_avg2 = 12 => 0.0320021158,
											pk_add_lres_month_avg2 = 13 => 0.028758324,
											pk_add_lres_month_avg2 = 15 => 0.0205323194,
																		   0.0158265827));

		pk_nameperssn_count_mm_b2 := __common__(map(pk_nameperssn_count = 0 => 0.0396946376,
										 pk_nameperssn_count = 1 => 0.0379881154,
																	0.1058823529));

		pk_ssns_per_adl_mm_b2 := __common__(map(pk_ssns_per_adl = -1 => 0.1091314031,
									 pk_ssns_per_adl = 0  => 0.0377462661,
									 pk_ssns_per_adl = 1  => 0.0443199185,
									 pk_ssns_per_adl = 2  => 0.0560263653,
									 pk_ssns_per_adl = 3  => 0.0518518519,
															 0.0263157895));

		pk_addrs_per_adl_mm_b2 := __common__(map(pk_addrs_per_adl = -6 => 0.1016949153,
									  pk_addrs_per_adl = -5 => 0.0458167331,
									  pk_addrs_per_adl = -4 => 0.0383554446,
									  pk_addrs_per_adl = -3 => 0.0340663656,
									  pk_addrs_per_adl = -2 => 0.0363328313,
									  pk_addrs_per_adl = -1 => 0.0386554622,
									  pk_addrs_per_adl = 0  => 0.0399717015,
									  pk_addrs_per_adl = 1  => 0.0426829268,
									  pk_addrs_per_adl = 2  => 0.0451492537,
															   0.0510105871));

		pk_phones_per_adl_mm_b2 := __common__(map(pk_phones_per_adl = -1 => 0.0457027435,
									   pk_phones_per_adl = 0  => 0.0322463566,
									   pk_phones_per_adl = 1  => 0.0376804502,
																 0.0433145009));

		pk_adlperssn_count_mm_b2 := __common__(map(pk_adlperssn_count = -1 => 0.0609137056,
										pk_adlperssn_count = 0  => 0.0386104372,
										pk_adlperssn_count = 1  => 0.0409307541,
																   0.0448873484));

		pk_adls_per_phone_mm_b2 := __common__(map(pk_adls_per_phone = -2 => 0.0598013053,
									   pk_adls_per_phone = -1 => 0.0289270098,
									   pk_adls_per_phone = 0  => 0.0247625233,
																 0.0493273543));

		pk_ssns_per_adl_c6_mm_b2 := __common__(map(pk_ssns_per_adl_c6 = 0 => 0.0353899649,
										pk_ssns_per_adl_c6 = 1 => 0.0582356333,
																  0.0671378092));

		pk_ssns_per_addr_c6_mm_b2 := __common__(map(pk_ssns_per_addr_c6 = 0   => 0.0320408419,
										 pk_ssns_per_addr_c6 = 1   => 0.0547454815,
										 pk_ssns_per_addr_c6 = 2   => 0.0628383149,
										 pk_ssns_per_addr_c6 = 3   => 0.0912621359,
										 pk_ssns_per_addr_c6 = 4   => 0.0960264901,
										 pk_ssns_per_addr_c6 = 5   => 0.1304347826,
										 pk_ssns_per_addr_c6 = 6   => 0.1228070175,
										 pk_ssns_per_addr_c6 = 100 => 0.0656603774,
										 pk_ssns_per_addr_c6 = 101 => 0.0906148867,
										 pk_ssns_per_addr_c6 = 102 => 0.1063829787,
										 pk_ssns_per_addr_c6 = 103 => 0.1818181818,
																	  0.1428571429));

		pk_attr_addrs_last90_mm_b2 := __common__(map(pk_attr_addrs_last90 = 0 => 0.0384765768,
										  pk_attr_addrs_last90 = 1 => 0.0648809524,
																	  0.0839160839));

		pk_attr_addrs_last12_mm_b2 := __common__(map(pk_attr_addrs_last12 = 0 => 0.0348128684,
										  pk_attr_addrs_last12 = 1 => 0.0584660864,
										  pk_attr_addrs_last12 = 2 => 0.0772135963,
										  pk_attr_addrs_last12 = 3 => 0.0798122066,
																	  0.1041666667));

		pk_attr_addrs_last24_mm_b2 := __common__(map(pk_attr_addrs_last24 = 0 => 0.0310280581,
										  pk_attr_addrs_last24 = 1 => 0.0479642548,
										  pk_attr_addrs_last24 = 2 => 0.065937405,
										  pk_attr_addrs_last24 = 3 => 0.0725209669,
										  pk_attr_addrs_last24 = 4 => 0.1007518797,
																	  0.125));

		pk_ams_class_level_mm_b2 := __common__(map(pk_ams_class_level = -1000001 => 0.0390407065,
										pk_ams_class_level = 0        => 0.0813953488,
										pk_ams_class_level = 1        => 0.095890411,
										pk_ams_class_level = 2        => 0.0566037736,
										pk_ams_class_level = 3        => 0.0720720721,
										pk_ams_class_level = 4        => 0.0718562874,
										pk_ams_class_level = 5        => 0.0479452055,
										pk_ams_class_level = 6        => 0.0531697342,
										pk_ams_class_level = 7        => 0.0555978675,
										pk_ams_class_level = 8        => 0.0337150127,
										pk_ams_class_level = 1000000  => 0.050955414,
										pk_ams_class_level = 1000001  => 0.0553191489,
										pk_ams_class_level = 1000002  => 0.0383292383,
										pk_ams_class_level = 1000003  => 0.0394736842,
										pk_ams_class_level = 1000004  => 0.0272873194,
																		 0.0310218978));

		pk_ams_4yr_college_mm_b2 := __common__(map(pk_ams_4yr_college = -1 => 0.0602171767,
										pk_ams_4yr_college = 0  => 0.0399340676,
																   0.0300478033));

		pk_ams_college_type_mm_b2 := __common__(map(pk_ams_college_type = 0 => 0.0399415672,
										 pk_ams_college_type = 1 => 0.0346153846,
																	0.0418994413));

		pk_ams_income_level_code_mm_b2 := __common__(map(pk_ams_income_level_code = -1 => 0.0390401904,
											  pk_ams_income_level_code = 0  => 0.0364963504,
											  pk_ams_income_level_code = 1  => 0.0692520776,
											  pk_ams_income_level_code = 2  => 0.0540994624,
											  pk_ams_income_level_code = 3  => 0.0461538462,
											  pk_ams_income_level_code = 4  => 0.0397228637,
											  pk_ams_income_level_code = 5  => 0.0314830157,
																			   0.0253054101));

		pk_yr_in_dob2_mm_b2 := __common__(map(pk_yr_in_dob2 = 19 => 0.1651090343,
								   pk_yr_in_dob2 = 20 => 0.1565995526,
								   pk_yr_in_dob2 = 21 => 0.1271929825,
								   pk_yr_in_dob2 = 22 => 0.1347248577,
								   pk_yr_in_dob2 = 23 => 0.1082390953,
								   pk_yr_in_dob2 = 25 => 0.0861650485,
								   pk_yr_in_dob2 = 29 => 0.0697417789,
								   pk_yr_in_dob2 = 35 => 0.0707459352,
								   pk_yr_in_dob2 = 38 => 0.0563682465,
								   pk_yr_in_dob2 = 41 => 0.0430439521,
								   pk_yr_in_dob2 = 42 => 0.0514087988,
								   pk_yr_in_dob2 = 43 => 0.0431861804,
								   pk_yr_in_dob2 = 44 => 0.0397702165,
								   pk_yr_in_dob2 = 45 => 0.030527693,
								   pk_yr_in_dob2 = 47 => 0.0348409435,
								   pk_yr_in_dob2 = 49 => 0.0290760284,
								   pk_yr_in_dob2 = 57 => 0.0288030981,
								   pk_yr_in_dob2 = 60 => 0.0191358025,
								   pk_yr_in_dob2 = 63 => 0.020475406,
														 0.0144345339));

		pk_ams_age_mm_b2 := __common__(map(pk_ams_age = -1 => 0.038971641,
								pk_ams_age = 21 => 0.0769230769,
								pk_ams_age = 22 => 0.0933333333,
								pk_ams_age = 23 => 0.0792079208,
								pk_ams_age = 24 => 0.0476190476,
								pk_ams_age = 25 => 0.0935672515,
								pk_ams_age = 29 => 0.0479148181,
												   0.0455195424));

		pk_inferred_age_mm_b2 := __common__(map(pk_inferred_age = -1 => 0.1040268456,
									 pk_inferred_age = 18 => 0.1390532544,
									 pk_inferred_age = 19 => 0.1377777778,
									 pk_inferred_age = 20 => 0.1242937853,
									 pk_inferred_age = 21 => 0.1195499297,
									 pk_inferred_age = 22 => 0.0965692503,
									 pk_inferred_age = 24 => 0.0839799178,
									 pk_inferred_age = 34 => 0.0668534516,
									 pk_inferred_age = 37 => 0.0562170603,
									 pk_inferred_age = 41 => 0.0420699445,
									 pk_inferred_age = 42 => 0.0421401515,
									 pk_inferred_age = 43 => 0.0360801782,
									 pk_inferred_age = 44 => 0.0307497894,
									 pk_inferred_age = 46 => 0.0347674924,
									 pk_inferred_age = 48 => 0.0286023835,
									 pk_inferred_age = 52 => 0.0295055821,
									 pk_inferred_age = 56 => 0.0251344254,
									 pk_inferred_age = 59 => 0.0197889182,
									 pk_inferred_age = 63 => 0.0197458456,
															 0.014989648));

		pk_yr_reported_dob2_mm_b2 := __common__(map(pk_yr_reported_dob2 = -1 => 0.0686008151,
										 pk_yr_reported_dob2 = 19 => 0.1219512195,
										 pk_yr_reported_dob2 = 21 => 0.1279069767,
										 pk_yr_reported_dob2 = 22 => 0.1164383562,
										 pk_yr_reported_dob2 = 23 => 0.0960451977,
										 pk_yr_reported_dob2 = 32 => 0.0662852358,
										 pk_yr_reported_dob2 = 35 => 0.0649280087,
										 pk_yr_reported_dob2 = 39 => 0.0558791122,
										 pk_yr_reported_dob2 = 42 => 0.0412041392,
										 pk_yr_reported_dob2 = 43 => 0.0435227855,
										 pk_yr_reported_dob2 = 44 => 0.0380103238,
										 pk_yr_reported_dob2 = 45 => 0.0311497939,
										 pk_yr_reported_dob2 = 46 => 0.0338164251,
										 pk_yr_reported_dob2 = 49 => 0.0323490132,
										 pk_yr_reported_dob2 = 57 => 0.0286100039,
										 pk_yr_reported_dob2 = 60 => 0.0198262419,
										 pk_yr_reported_dob2 = 63 => 0.0203252033,
																	 0.0152187213));

		pk_avm_hit_level_mm_b2 := __common__(map(pk_avm_hit_level = -1 => 0.047486404,
									  pk_avm_hit_level = 0  => 0.0365900488,
									  pk_avm_hit_level = 1  => 0.0395374277,
															   0.0397114518));

		pk_avm_auto_diff2_lvl_mm_b2 := __common__(map(pk_avm_auto_diff2_lvl = -2 => 0.0404115116,
										   pk_avm_auto_diff2_lvl = -1 => 0.0468838127,
										   pk_avm_auto_diff2_lvl = 0  => 0.0386115969,
										   pk_avm_auto_diff2_lvl = 1  => 0.0348929948,
																		 0.0327402135));

		pk_avm_auto_diff4_lvl_mm_b2 := __common__(map(pk_avm_auto_diff4_lvl = -1 => 0.0389446367,
										   pk_avm_auto_diff4_lvl = 0  => 0.0390198087,
																		 0.0530018762));

		pk_add2_avm_auto_diff2_lvl_mm_b2 := __common__(map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0387908641,
												pk_add2_avm_auto_diff2_lvl = -2 => 0.046875,
												pk_add2_avm_auto_diff2_lvl = -1 => 0.053633218,
												pk_add2_avm_auto_diff2_lvl = 0  => 0.0386136478,
																				   0.0411196433));

		pk2_add1_avm_mkt_mm_b2 := __common__(map(pk2_add1_avm_mkt = 0 => 0.0504340637,
									  pk2_add1_avm_mkt = 1 => 0.0431180188,
									  pk2_add1_avm_mkt = 2 => 0.0398024839,
									  pk2_add1_avm_mkt = 3 => 0.0297547632,
															  0.0322291853));

		pk2_add1_avm_pi_mm_b2 := __common__(map(pk2_add1_avm_pi = 0 => 0.0457746479,
									 pk2_add1_avm_pi = 1 => 0.0542635659,
									 pk2_add1_avm_pi = 2 => 0.0359558684,
															0.0455697413));

		pk2_add1_avm_hed_mm_b2 := __common__(map(pk2_add1_avm_hed = 0 => 0.0722021661,
									  pk2_add1_avm_hed = 1 => 0.0687093779,
									  pk2_add1_avm_hed = 2 => 0.0554250822,
									  pk2_add1_avm_hed = 3 => 0.0398440991,
									  pk2_add1_avm_hed = 4 => 0.0386215092,
									  pk2_add1_avm_hed = 5 => 0.0380986938,
															  0.0261989343));

		pk2_add1_avm_auto2_mm_b2 := __common__(map(pk2_add1_avm_auto2 = 0 => 0.0294117647,
										pk2_add1_avm_auto2 = 1 => 0.0521390374,
										pk2_add1_avm_auto2 = 2 => 0.0588662791,
										pk2_add1_avm_auto2 = 3 => 0.0526104418,
										pk2_add1_avm_auto2 = 4 => 0.0404115116,
										pk2_add1_avm_auto2 = 5 => 0.0435074527,
										pk2_add1_avm_auto2 = 6 => 0.0375779817,
																  0.0276497696));

		pk2_add1_avm_auto4_mm_b2 := __common__(map(pk2_add1_avm_auto4 = 0 => 0.0418943534,
										pk2_add1_avm_auto4 = 1 => 0.0625,
										pk2_add1_avm_auto4 = 2 => 0.0606709493,
										pk2_add1_avm_auto4 = 3 => 0.0391648715,
										pk2_add1_avm_auto4 = 4 => 0.0402338377,
										pk2_add1_avm_auto4 = 5 => 0.0385321101,
																  0.0282258065));

		pk2_add1_avm_med_mm_b2 := __common__(map(pk2_add1_avm_med = 0 => 0.0582524272,
									  pk2_add1_avm_med = 1 => 0.05,
									  pk2_add1_avm_med = 2 => 0.0544973545,
									  pk2_add1_avm_med = 3 => 0.0476454294,
									  pk2_add1_avm_med = 4 => 0.040920251,
									  pk2_add1_avm_med = 5 => 0.0403807326,
									  pk2_add1_avm_med = 6 => 0.0298634812,
															  0.0302846234));

		pk2_add1_avm_to_med_ratio_mm_b2 := __common__(map(pk2_add1_avm_to_med_ratio = 0 => 0.0413343002,
											   pk2_add1_avm_to_med_ratio = 1 => 0.0437304075,
											   pk2_add1_avm_to_med_ratio = 2 => 0.038028169,
											   pk2_add1_avm_to_med_ratio = 3 => 0.0342208721,
											   pk2_add1_avm_to_med_ratio = 4 => 0.0314710905,
																				0.0259878016));

		pk2_add2_avm_mkt_mm_b2 := __common__(map(pk2_add2_avm_mkt = 0 => 0.0528634361,
									  pk2_add2_avm_mkt = 1 => 0.0498687664,
									  pk2_add2_avm_mkt = 2 => 0.0396772491,
									  pk2_add2_avm_mkt = 3 => 0.0376049653,
															  0.0357894737));

		pk2_add2_avm_pi_mm_b2 := __common__(map(pk2_add2_avm_pi = 0 => 0.066759388,
									 pk2_add2_avm_pi = 1 => 0.0472972973,
									 pk2_add2_avm_pi = 2 => 0.0381902714,
									 pk2_add2_avm_pi = 3 => 0.0427867384,
															0.0424597365));

		pk2_add2_avm_hed_mm_b2 := __common__(map(pk2_add2_avm_hed = 0 => 0.0336134454,
									  pk2_add2_avm_hed = 1 => 0.0611782477,
									  pk2_add2_avm_hed = 2 => 0.0450704225,
									  pk2_add2_avm_hed = 3 => 0.0387934632,
									  pk2_add2_avm_hed = 4 => 0.0347330223,
									  pk2_add2_avm_hed = 5 => 0.0414171093,
															  0.0438898451));

		pk2_add2_avm_auto4_mm_b2 := __common__(map(pk2_add2_avm_auto4 = 0 => 0.07421875,
										pk2_add2_avm_auto4 = 1 => 0.0496350365,
										pk2_add2_avm_auto4 = 2 => 0.0463821892,
										pk2_add2_avm_auto4 = 3 => 0.038795348,
										pk2_add2_avm_auto4 = 4 => 0.041952649,
																  0.0385996409));

		pk2_yr_add1_avm_rec_dt_mm_b2 := __common__(map(pk2_yr_add1_avm_recording_date = 0 => 0.0615197404,
											pk2_yr_add1_avm_recording_date = 1 => 0.0559488468,
											pk2_yr_add1_avm_recording_date = 2 => 0.0383559973,
											pk2_yr_add1_avm_recording_date = 3 => 0.0368968211,
																				  0.0241269841));

		pk2_yr_add1_avm_assess_year_mm_b2 := __common__(map(pk2_yr_add1_avm_assess_year = 0 => 0.0421688604,
												 pk2_yr_add1_avm_assess_year = 1 => 0.0385398419,
																					0.0378688217));

		pk2_yr_add2_avm_assess_year_mm_b2 := __common__(map(pk2_yr_add2_avm_assess_year = 0 => 0.0392893154,
												 pk2_yr_add2_avm_assess_year = 1 => 0.0394241417,
																					0.0409273342));

		pk_dist_a1toa2_mm_b2 := __common__(map(pk_dist_a1toa2_2 = 0 => 0.0370777746,
									pk_dist_a1toa2_2 = 1 => 0.0366995859,
									pk_dist_a1toa2_2 = 2 => 0.0465213,
									pk_dist_a1toa2_2 = 3 => 0.0452284034,
															0.0452692555));

		pk_dist_a1toa3_mm_b2 := __common__(map(pk_dist_a1toa3_2 = 0 => 0.0354428061,
									pk_dist_a1toa3_2 = 1 => 0.0343801251,
									pk_dist_a1toa3_2 = 2 => 0.0437472732,
									pk_dist_a1toa3_2 = 3 => 0.0458850425,
									pk_dist_a1toa3_2 = 4 => 0.0421989934,
									pk_dist_a1toa3_2 = 5 => 0.0471293916,
															0.0415702479));

		pk_rc_disthphoneaddr_mm_b2 := __common__(map(pk_rc_disthphoneaddr_2 = 0 => 0.0279480367,
										  pk_rc_disthphoneaddr_2 = 1 => 0.0318584071,
										  pk_rc_disthphoneaddr_2 = 2 => 0.0442890443,
										  pk_rc_disthphoneaddr_2 = 3 => 0.0560747664,
																		0.0630173062));

		pk_out_st_division_lvl_mm_b2 := __common__(map(pk_out_st_division_lvl = -1 => 0.0269230769,
											pk_out_st_division_lvl = 0  => 0.0220713073,
											pk_out_st_division_lvl = 1  => 0.0391095066,
											pk_out_st_division_lvl = 2  => 0.0383860025,
											pk_out_st_division_lvl = 3  => 0.0336344684,
											pk_out_st_division_lvl = 4  => 0.0379949409,
											pk_out_st_division_lvl = 5  => 0.0366592286,
											pk_out_st_division_lvl = 6  => 0.0523754642,
											pk_out_st_division_lvl = 7  => 0.0471414243,
																		   0.0583356373));

		pk_wealth_index_mm_b2 := __common__(map(pk_wealth_index_2 = 0 => 0.0328127905,
									 pk_wealth_index_2 = 1 => 0.0455083742,
									 pk_wealth_index_2 = 2 => 0.0484813459,
									 pk_wealth_index_2 = 3 => 0.038400696,
															  0.0373032904));

		pk_impulse_count_mm_b2 := __common__(if(pk_impulse_count_2 = 0, 0.0396663859, NULL));

		pk_attr_num_nonderogs90_b_mm_b2 := __common__(map(pk_attr_num_nonderogs90_b = 0  => 0.0930232558,
											   pk_attr_num_nonderogs90_b = 1  => 0.0658242727,
											   pk_attr_num_nonderogs90_b = 2  => 0.0594451783,
											   pk_attr_num_nonderogs90_b = 3  => 0.0499507065,
											   pk_attr_num_nonderogs90_b = 4  => 0.0346020761,
											   pk_attr_num_nonderogs90_b = 10 => 0.1044776119,
											   pk_attr_num_nonderogs90_b = 11 => 0.0442766592,
											   pk_attr_num_nonderogs90_b = 12 => 0.036898165,
											   pk_attr_num_nonderogs90_b = 13 => 0.0281299275,
																				 0.0200490087));

		pk_ssns_per_addr2_mm_b2 := __common__(map(pk_ssns_per_addr2 = -101 => 0.0664048554,
									   pk_ssns_per_addr2 = -2   => 0.0364860078,
									   pk_ssns_per_addr2 = -1   => 0.0316132032,
									   pk_ssns_per_addr2 = 0    => 0.0242089855,
									   pk_ssns_per_addr2 = 1    => 0.025107604,
									   pk_ssns_per_addr2 = 2    => 0.0267530567,
									   pk_ssns_per_addr2 = 3    => 0.0323988971,
									   pk_ssns_per_addr2 = 4    => 0.0350504514,
									   pk_ssns_per_addr2 = 5    => 0.037037037,
									   pk_ssns_per_addr2 = 6    => 0.0419447092,
									   pk_ssns_per_addr2 = 7    => 0.0459024273,
									   pk_ssns_per_addr2 = 8    => 0.0475237619,
									   pk_ssns_per_addr2 = 9    => 0.0580186097,
									   pk_ssns_per_addr2 = 10   => 0.0638297872,
									   pk_ssns_per_addr2 = 11   => 0.0738562092,
									   pk_ssns_per_addr2 = 12   => 0.0826939471,
									   pk_ssns_per_addr2 = 100  => 0.0586206897,
									   pk_ssns_per_addr2 = 101  => 0.0975609756,
									   pk_ssns_per_addr2 = 102  => 0.069273743,
																   0.0962732919));

		pk_yr_prop1_prev_purch_dt2_mm_b2 := __common__(map(pk_yr_prop1_prev_purchase_date2 = -1 => 0.0386408796,
												pk_yr_prop1_prev_purchase_date2 = 0  => 0.072265625,
												pk_yr_prop1_prev_purchase_date2 = 1  => 0.0693333333,
												pk_yr_prop1_prev_purchase_date2 = 2  => 0.0604982206,
												pk_yr_prop1_prev_purchase_date2 = 3  => 0.0537757437,
												pk_yr_prop1_prev_purchase_date2 = 4  => 0.0530690537,
												pk_yr_prop1_prev_purchase_date2 = 5  => 0.042366691,
												pk_yr_prop1_prev_purchase_date2 = 6  => 0.030284676,
																						0.0306812272));

		pk_estimated_income_mm_b3 := __common__(map(pk_estimated_income = -1 => 0.2634228188,
										 pk_estimated_income = 0  => 0.3031496063,
										 pk_estimated_income = 1  => 0.2161366313,
										 pk_estimated_income = 2  => 0.1907606531,
										 pk_estimated_income = 3  => 0.1746031746,
										 pk_estimated_income = 4  => 0.164461816,
										 pk_estimated_income = 5  => 0.1456796628,
										 pk_estimated_income = 6  => 0.1255387931,
										 pk_estimated_income = 7  => 0.1181674566,
										 pk_estimated_income = 8  => 0.1153450051,
										 pk_estimated_income = 9  => 0.1266323704,
										 pk_estimated_income = 10 => 0.1136576239,
										 pk_estimated_income = 11 => 0.1143300569,
										 pk_estimated_income = 12 => 0.1154580153,
										 pk_estimated_income = 13 => 0.0904130943,
										 pk_estimated_income = 14 => 0.1002087683,
										 pk_estimated_income = 15 => 0.1035714286,
										 pk_estimated_income = 16 => 0.1103542234,
										 pk_estimated_income = 17 => 0.1030042918,
										 pk_estimated_income = 18 => 0.1231028668,
										 pk_estimated_income = 19 => 0.1307767945,
										 pk_estimated_income = 20 => 0.101628468,
										 pk_estimated_income = 21 => 0.0924369748,
																	 0.1238095238));

		pk_yr_adl_w_first_seen2_mm_b3 := __common__(map(pk_yr_adl_w_first_seen2 = -1 => 0.1402334536,
											 pk_yr_adl_w_first_seen2 = 0  => 0.0344827586,
											 pk_yr_adl_w_first_seen2 = 1  => 0.0367892977,
																			 0.0266666667));

		pk_yr_adl_w_last_seen2_mm_b3 := __common__(map(pk_yr_adl_w_last_seen2 = -1 => 0.1402334536,
											pk_yr_adl_w_last_seen2 = 0  => 0.0214592275,
											pk_yr_adl_w_last_seen2 = 1  => 0.0280898876,
																		   0.044534413));

		pk_pr_count_mm_b3 := __common__(map(pk_pr_count = -1 => 0.1487189707,
								 pk_pr_count = 0  => 0.0432756325,
								 pk_pr_count = 1  => 0.0602409639,
													 0.0952380952));

		pk_addrs_sourced_lvl_mm_b3 := __common__(map(pk_addrs_sourced_lvl = 0 => 0.1449580726,
										  pk_addrs_sourced_lvl = 1 => 0.0615034169,
										  pk_addrs_sourced_lvl = 2 => 0.0216962525,
																	  0.0638977636));

		pk_add2_own_level_mm_b3 := __common__(map(pk_add2_own_level = 0 => 0.1431957518,
									   pk_add2_own_level = 1 => 0.1103267115,
									   pk_add2_own_level = 2 => 0.0456621005,
																0.0716510903));

		pk_add3_own_level_mm_b3 := __common__(map(pk_add3_own_level = 0 => 0.1410733937,
									   pk_add3_own_level = 1 => 0.1043177893,
									   pk_add3_own_level = 2 => 0.0479452055,
																0.0604651163));

		pk_naprop_level2_mm_b3 := __common__(map(pk_naprop_level2 = -2 => 0.147577539,
									  pk_naprop_level2 = -1 => 0.1500397456,
									  pk_naprop_level2 = 0  => 0.1210953347,
									  pk_naprop_level2 = 1  => 0.1184489549,
									  pk_naprop_level2 = 2  => 0.1391749062,
									  pk_naprop_level2 = 3  => 0.1064204046,
									  pk_naprop_level2 = 4  => 0.0577114428,
															   0.0782396088));

		pk_yr_add1_purchase_date2_mm_b3 := __common__(map(pk_yr_add1_purchase_date2 = -1 => 0.1276420943,
											   pk_yr_add1_purchase_date2 = 0  => 0.152173913,
											   pk_yr_add1_purchase_date2 = 1  => 0.1587301587,
											   pk_yr_add1_purchase_date2 = 2  => 0.1541389153,
											   pk_yr_add1_purchase_date2 = 3  => 0.1503616292,
											   pk_yr_add1_purchase_date2 = 4  => 0.1347103727,
																				 0.1329305136));

		pk_yr_add1_built_date2_mm_b3 := __common__(map(pk_yr_add1_built_date2 = -4 => 0.1318662915,
											pk_yr_add1_built_date2 = -3 => 0.1272727273,
											pk_yr_add1_built_date2 = -2 => 0.1169125993,
											pk_yr_add1_built_date2 = -1 => 0.125,
											pk_yr_add1_built_date2 = 0  => 0.1347671665,
											pk_yr_add1_built_date2 = 1  => 0.1323145732,
											pk_yr_add1_built_date2 = 2  => 0.1465050297,
																		   0.1696527012));

		pk_yr_add1_mortgage_date2_mm_b3 := __common__(map(pk_yr_add1_mortgage_date2 = -1 => 0.1337181579,
											   pk_yr_add1_mortgage_date2 = 0  => 0.1517094017,
											   pk_yr_add1_mortgage_date2 = 1  => 0.1645408163,
																				 0.1573346846));

		pk_add1_mortgage_risk_mm_b3 := __common__(map(pk_add1_mortgage_risk = -1 => 0.203125,
										   pk_add1_mortgage_risk = 0  => 0.1385459534,
										   pk_add1_mortgage_risk = 1  => 0.13496068,
										   pk_add1_mortgage_risk = 2  => 0.1548418025,
																		 0.1891394386));

		pk_add1_assessed_amount2_mm_b3 := __common__(map(pk_add1_assessed_amount2 = -1 => 0.1339785315,
											  pk_add1_assessed_amount2 = 0  => 0.211130742,
											  pk_add1_assessed_amount2 = 1  => 0.2096774194,
											  pk_add1_assessed_amount2 = 2  => 0.1916537867,
											  pk_add1_assessed_amount2 = 3  => 0.1655530809,
											  pk_add1_assessed_amount2 = 4  => 0.1284677764,
											  pk_add1_assessed_amount2 = 5  => 0.138700291,
																			   0.1256754884));

		pk_yr_add1_date_first_seen2_mm_b3 := __common__(map(pk_yr_add1_date_first_seen2 = -1 => 0.211677978,
												 pk_yr_add1_date_first_seen2 = 0  => 0.1539743273,
												 pk_yr_add1_date_first_seen2 = 1  => 0.1328899322,
												 pk_yr_add1_date_first_seen2 = 2  => 0.1188374596,
												 pk_yr_add1_date_first_seen2 = 3  => 0.1122382199,
												 pk_yr_add1_date_first_seen2 = 4  => 0.1034275406,
												 pk_yr_add1_date_first_seen2 = 5  => 0.0899893504,
												 pk_yr_add1_date_first_seen2 = 6  => 0.0728744939,
												 pk_yr_add1_date_first_seen2 = 7  => 0.0508373206,
												 pk_yr_add1_date_first_seen2 = 8  => 0.0515097691,
												 pk_yr_add1_date_first_seen2 = 9  => 0.0293398533,
																					 0.025210084));

		pk_add1_building_area2_mm_b3 := __common__(map(pk_add1_building_area2 = -99 => 0.1308077198,
											pk_add1_building_area2 = -4  => 0.1941982272,
											pk_add1_building_area2 = -3  => 0.1698717949,
											pk_add1_building_area2 = -2  => 0.1552327616,
											pk_add1_building_area2 = -1  => 0.1317809621,
											pk_add1_building_area2 = 0   => 0.1132561133,
											pk_add1_building_area2 = 1   => 0.1319648094,
											pk_add1_building_area2 = 2   => 0.1218487395,
											pk_add1_building_area2 = 3   => 0.1611842105,
																			0.1234285714));

		pk_add1_no_of_baths_mm_b3 := __common__(map(pk_add1_no_of_baths = -3 => 0.1327589291,
										 pk_add1_no_of_baths = -2 => 0.1658993752,
										 pk_add1_no_of_baths = -1 => 0.1474422036,
										 pk_add1_no_of_baths = 0  => 0.1127906977,
										 pk_add1_no_of_baths = 1  => 0.1243144424,
																	 0.1340206186));

		pk_property_owned_total_mm_b3 := __common__(if(pk_property_owned_total = -1, 0.1383543201, NULL));
		pk_prop_own_assess_tot2_mm_b3 := __common__(if(pk_prop_own_assess_tot2 = 0, 0.1383543201, NULL));

		pk_prop1_sale_price2_mm_b3 := __common__(map(pk_prop1_sale_price2 = 0 => 0.1397535537,
										  pk_prop1_sale_price2 = 1 => 0.0714285714,
																	  0.055));

		pk_add2_land_use_risk_level_mm_b3 := __common__(map(pk_add2_land_use_risk_level = 0 => 0.0536912752,
												 pk_add2_land_use_risk_level = 2 => 0.129936386,
												 pk_add2_land_use_risk_level = 3 => 0.1417459984,
																					0.1665257819));

		pk_add2_building_area2_mm_b3 := __common__(map(pk_add2_building_area2 = -4 => 0.1379063951,
											pk_add2_building_area2 = -3 => 0.1557478368,
											pk_add2_building_area2 = -2 => 0.149691358,
											pk_add2_building_area2 = -1 => 0.1442002442,
											pk_add2_building_area2 = 0  => 0.1246253746,
											pk_add2_building_area2 = 1  => 0.1532258065,
																		   0.1387283237));

		pk_add2_no_of_baths_mm_b3 := __common__(map(pk_add2_no_of_baths = -3 => 0.1386905229,
										 pk_add2_no_of_baths = -2 => 0.1510476629,
										 pk_add2_no_of_baths = -1 => 0.1325581395,
										 pk_add2_no_of_baths = 0  => 0.1229566453,
										 pk_add2_no_of_baths = 1  => 0.0996884735,
																	 0.1436170213));

		pk_yr_add2_mortgage_date2_mm_b3 := __common__(map(pk_yr_add2_mortgage_date2 = -1 => 0.1378024335,
											   pk_yr_add2_mortgage_date2 = 0  => 0.1415774099,
																				 0.141238365));

		pk_add2_mortgage_risk_mm_b3 := __common__(map(pk_add2_mortgage_risk = -1 => 0.1875,
										   pk_add2_mortgage_risk = 0  => 0.1305334847,
										   pk_add2_mortgage_risk = 1  => 0.137374092,
										   pk_add2_mortgage_risk = 2  => 0.1518087855,
																		 0.1609267376));

		pk_yr_add2_mortgage_due_date2_mm_b3 := __common__(map(pk_yr_add2_mortgage_due_date2 = -1 => 0.137694704,
												   pk_yr_add2_mortgage_due_date2 = 0  => 0.1323106424,
												   pk_yr_add2_mortgage_due_date2 = 1  => 0.1228788765,
												   pk_yr_add2_mortgage_due_date2 = 2  => 0.150310559,
																						 0.1526548673));

		pk_add2_assessed_amount2_mm_b3 := __common__(map(pk_add2_assessed_amount2 = -1 => 0.137755611,
											  pk_add2_assessed_amount2 = 0  => 0.1898638427,
											  pk_add2_assessed_amount2 = 1  => 0.1591981132,
											  pk_add2_assessed_amount2 = 2  => 0.1339712919,
											  pk_add2_assessed_amount2 = 3  => 0.1272239825,
																			   0.1260709914));

		pk_yr_add2_date_first_seen2_mm_b3 := __common__(map(pk_yr_add2_date_first_seen2 = -1 => 0.1857173493,
												 pk_yr_add2_date_first_seen2 = 0  => 0.1887664415,
												 pk_yr_add2_date_first_seen2 = 1  => 0.1441578149,
												 pk_yr_add2_date_first_seen2 = 2  => 0.1340277778,
												 pk_yr_add2_date_first_seen2 = 3  => 0.114973926,
												 pk_yr_add2_date_first_seen2 = 4  => 0.1081805069,
												 pk_yr_add2_date_first_seen2 = 5  => 0.1077065924,
												 pk_yr_add2_date_first_seen2 = 6  => 0.0902011681,
												 pk_yr_add2_date_first_seen2 = 7  => 0.0784688995,
												 pk_yr_add2_date_first_seen2 = 8  => 0.0750902527,
												 pk_yr_add2_date_first_seen2 = 9  => 0.0732026144,
												 pk_yr_add2_date_first_seen2 = 10 => 0.060546875,
																					 0.0291139241));

		pk_add3_mortgage_risk_mm_b3 := __common__(map(pk_add3_mortgage_risk = -1 => 0.1739130435,
										   pk_add3_mortgage_risk = 0  => 0.1138287865,
										   pk_add3_mortgage_risk = 1  => 0.2121212121,
										   pk_add3_mortgage_risk = 2  => 0.1394598016,
										   pk_add3_mortgage_risk = 3  => 0.1228632479,
										   pk_add3_mortgage_risk = 4  => 0.1242460796,
																		 0.1094527363));

		pk_add3_assessed_amount2_mm_b3 := __common__(map(pk_add3_assessed_amount2 = -1 => 0.1400429636,
											  pk_add3_assessed_amount2 = 0  => 0.1695652174,
											  pk_add3_assessed_amount2 = 1  => 0.1467391304,
											  pk_add3_assessed_amount2 = 2  => 0.127143702,
																			   0.1137440758));

		pk_yr_add3_date_first_seen2_mm_b3 := __common__(map(pk_yr_add3_date_first_seen2 = -1 => 0.1755952381,
												 pk_yr_add3_date_first_seen2 = 0  => 0.1937754724,
												 pk_yr_add3_date_first_seen2 = 1  => 0.1504301325,
												 pk_yr_add3_date_first_seen2 = 2  => 0.1193234476,
												 pk_yr_add3_date_first_seen2 = 3  => 0.1191581554,
												 pk_yr_add3_date_first_seen2 = 4  => 0.1140510949,
												 pk_yr_add3_date_first_seen2 = 5  => 0.097941681,
												 pk_yr_add3_date_first_seen2 = 6  => 0.0892725937,
												 pk_yr_add3_date_first_seen2 = 7  => 0.0699724518,
												 pk_yr_add3_date_first_seen2 = 8  => 0.0697258641,
																					 0.0447570332));

		pk_w_count_mm_b3 := __common__(map(pk_w_count = 0 => 0.1402472223,
								pk_w_count = 1 => 0.0345303867,
												  0.0414507772));

		pk_bk_level_mm_b3 := __common__(if(pk_bk_level_2 = 0, 0.1383543201, NULL));
		pk_eviction_level_mm_b3 := __common__(if(pk_eviction_level = 0, 0.1383543201, NULL));

		pk_lien_type_level_mm_b3 := __common__(map(pk_lien_type_level = 0 => 0.1383482169,
										pk_lien_type_level = 1 => 0.3333333333,
																  0));

		pk_yr_liens_last_unrel_date3_mm_b3 := __common__(if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.1383543201, NULL));
		pk_yr_ln_unrel_cj_f_sn2_mm_b3 := __common__(map(pk_yr_liens_unrel_cj_first_sn2 = -1 => 0.1383570594,
																					0));

		pk_yr_ln_unrel_lt_f_sn2_mm_b3 := __common__(if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.1383543201, NULL));
		pk_yr_ln_unrel_ot_f_sn2_mm_b3 := __common__(if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.1383543201, NULL));
		pk_yr_criminal_last_date2_mm_b3 := __common__(if(pk_yr_criminal_last_date2 = -1, 0.1383543201, NULL));
		pk_yr_felony_last_date2_mm_b3 := __common__(if(pk_yr_felony_last_date2 = -1, 0.1383543201, NULL));
		pk_attr_total_number_derogs_mm_b3 := __common__(if(pk_attr_total_number_derogs_5 = 0, 0.1383543201, NULL));

		pk_yr_rc_ssnhighissue2_mm_b3 := __common__(map(pk_yr_rc_ssnhighissue2 = -1 => 0.1860465116,
											pk_yr_rc_ssnhighissue2 = 0  => 0.0704845815,
											pk_yr_rc_ssnhighissue2 = 1  => 0.0969455511,
											pk_yr_rc_ssnhighissue2 = 2  => 0.1188001188,
											pk_yr_rc_ssnhighissue2 = 3  => 0.1516290727,
											pk_yr_rc_ssnhighissue2 = 4  => 0.1944064447,
											pk_yr_rc_ssnhighissue2 = 5  => 0.162699992,
											pk_yr_rc_ssnhighissue2 = 6  => 0.1314026367,
											pk_yr_rc_ssnhighissue2 = 7  => 0.1061073411,
											pk_yr_rc_ssnhighissue2 = 8  => 0.1075902727,
											pk_yr_rc_ssnhighissue2 = 9  => 0.0910662824,
											pk_yr_rc_ssnhighissue2 = 10 => 0.083091226,
											pk_yr_rc_ssnhighissue2 = 11 => 0.065945389,
											pk_yr_rc_ssnhighissue2 = 12 => 0.0582010582,
											pk_yr_rc_ssnhighissue2 = 13 => 0.0506950123,
																		   0.0276422764));

		pk_pl_sourced_level_mm_b3 := __common__(map(pk_pl_sourced_level = 0 => 0.1411061965,
										 pk_pl_sourced_level = 1 => 0.1122112211,
										 pk_pl_sourced_level = 2 => 0.072079536,
																	0.0649350649));

		pk_prof_lic_cat_mm_b3 := __common__(map(pk_prof_lic_cat = -1 => 0.1407799751,
									 pk_prof_lic_cat = 0  => 0.1,
									 pk_prof_lic_cat = 1  => 0.0338461538,
									 pk_prof_lic_cat = 2  => 0.0372093023,
															 0.0106382979));

		pk_add1_lres_mm_b3 := __common__(map(pk_add1_lres = -1 => 0.2063987935,
								  pk_add1_lres = 0  => 0.1997578692,
								  pk_add1_lres = 1  => 0.1701323251,
								  pk_add1_lres = 2  => 0.1513480392,
								  pk_add1_lres = 3  => 0.1539888683,
								  pk_add1_lres = 4  => 0.1417668583,
								  pk_add1_lres = 5  => 0.1405405405,
								  pk_add1_lres = 6  => 0.1268543748,
								  pk_add1_lres = 7  => 0.108812165,
								  pk_add1_lres = 8  => 0.0886266633,
								  pk_add1_lres = 9  => 0.0688995215,
								  pk_add1_lres = 10 => 0.0490819209,
													   0.0251798561));

		pk_add2_lres_mm_b3 := __common__(map(pk_add2_lres = -2 => 0.1853038801,
								  pk_add2_lres = -1 => 0.1125275803,
								  pk_add2_lres = 0  => 0.2120211361,
								  pk_add2_lres = 1  => 0.1679184549,
								  pk_add2_lres = 2  => 0.140108593,
								  pk_add2_lres = 3  => 0.1330989453,
								  pk_add2_lres = 4  => 0.1162862431,
								  pk_add2_lres = 5  => 0.1173436493,
								  pk_add2_lres = 6  => 0.1062641773,
								  pk_add2_lres = 7  => 0.0870599429,
								  pk_add2_lres = 8  => 0.0658350658,
								  pk_add2_lres = 9  => 0.0688956434,
													   0.0693069307));

		pk_add3_lres_mm_b3 := __common__(map(pk_add3_lres = -2 => 0.1768821134,
								  pk_add3_lres = -1 => 0.1091767881,
								  pk_add3_lres = 0  => 0.1276214494,
								  pk_add3_lres = 1  => 0.1030253475,
								  pk_add3_lres = 2  => 0.1003102378,
								  pk_add3_lres = 3  => 0.1075388027,
								  pk_add3_lres = 4  => 0.0919324578,
								  pk_add3_lres = 5  => 0.0604575163,
													   0.0617760618));

		pk_lres_flag_level_mm_b3 := __common__(map(pk_lres_flag_level = 0 => 0.2063987935,
										pk_lres_flag_level = 1 => 0.1568526348,
																  0.1126300431));

		pk_addrs_5yr_mm_b3 := __common__(map(pk_addrs_5yr = 0 => 0.1217812784,
								  pk_addrs_5yr = 1 => 0.1479883468,
								  pk_addrs_5yr = 2 => 0.1365913602,
								  pk_addrs_5yr = 3 => 0.10969286,
													  0.1218905473));

		pk_addrs_10yr_mm_b3 := __common__(map(pk_addrs_10yr = 0 => 0.1460635946,
								   pk_addrs_10yr = 1 => 0.159981086,
								   pk_addrs_10yr = 2 => 0.1312989153,
								   pk_addrs_10yr = 3 => 0.0968399592,
														0.0995260664));

		pk_add_lres_month_avg2_mm_b3 := __common__(map(pk_add_lres_month_avg2 = -1 => 0.2411729503,
											pk_add_lres_month_avg2 = 0  => 0.2845070423,
											pk_add_lres_month_avg2 = 1  => 0.2171008684,
											pk_add_lres_month_avg2 = 2  => 0.1789007746,
											pk_add_lres_month_avg2 = 3  => 0.1526981853,
											pk_add_lres_month_avg2 = 4  => 0.1426583159,
											pk_add_lres_month_avg2 = 5  => 0.1382543881,
											pk_add_lres_month_avg2 = 6  => 0.1239388795,
											pk_add_lres_month_avg2 = 7  => 0.1198137172,
											pk_add_lres_month_avg2 = 8  => 0.1143222506,
											pk_add_lres_month_avg2 = 9  => 0.1067623396,
											pk_add_lres_month_avg2 = 10 => 0.1090326029,
											pk_add_lres_month_avg2 = 11 => 0.1025168815,
											pk_add_lres_month_avg2 = 12 => 0.0887792848,
											pk_add_lres_month_avg2 = 13 => 0.0588446358,
											pk_add_lres_month_avg2 = 15 => 0.0485436893,
																		   0.0291262136));

		pk_nameperssn_count_mm_b3 := __common__(map(pk_nameperssn_count = 0 => 0.1371516491,
										 pk_nameperssn_count = 1 => 0.1505401597,
																	0.1730769231));

		pk_ssns_per_adl_mm_b3 := __common__(map(pk_ssns_per_adl = -1 => 0.2444959444,
									 pk_ssns_per_adl = 0  => 0.1326913164,
									 pk_ssns_per_adl = 1  => 0.1494296578,
									 pk_ssns_per_adl = 2  => 0.13,
									 pk_ssns_per_adl = 3  => 0.1711711712,
															 0.2121212121));

		pk_addrs_per_adl_mm_b3 := __common__(map(pk_addrs_per_adl = -6 => 0.2505307856,
									  pk_addrs_per_adl = -5 => 0.1857556337,
									  pk_addrs_per_adl = -4 => 0.1629751726,
									  pk_addrs_per_adl = -3 => 0.1401059842,
									  pk_addrs_per_adl = -2 => 0.12,
									  pk_addrs_per_adl = -1 => 0.1076855318,
									  pk_addrs_per_adl = 0  => 0.085979269,
									  pk_addrs_per_adl = 1  => 0.0798479087,
									  pk_addrs_per_adl = 2  => 0.0728241563,
															   0.103626943));

		pk_phones_per_adl_mm_b3 := __common__(map(pk_phones_per_adl = -1 => 0.1477185034,
									   pk_phones_per_adl = 0  => 0.0994463142,
									   pk_phones_per_adl = 1  => 0.1225099602,
																 0.1229508197));

		pk_adlperssn_count_mm_b3 := __common__(map(pk_adlperssn_count = -1 => 0.1952662722,
										pk_adlperssn_count = 0  => 0.1316630693,
										pk_adlperssn_count = 1  => 0.1470285447,
																   0.1837937385));

		pk_adls_per_phone_mm_b3 := __common__(map(pk_adls_per_phone = -2 => 0.1521209601,
									   pk_adls_per_phone = -1 => 0.1105396595,
									   pk_adls_per_phone = 0  => 0.1125710227,
																 0.1076233184));

		pk_ssns_per_adl_c6_mm_b3 := __common__(map(pk_ssns_per_adl_c6 = 0 => 0.1282209726,
										pk_ssns_per_adl_c6 = 1 => 0.1544001801,
																  0.2540540541));

		pk_ssns_per_addr_c6_mm_b3 := __common__(map(pk_ssns_per_addr_c6 = 0   => 0.1053523035,
										 pk_ssns_per_addr_c6 = 1   => 0.17498945,
										 pk_ssns_per_addr_c6 = 2   => 0.1665692577,
										 pk_ssns_per_addr_c6 = 3   => 0.190747331,
										 pk_ssns_per_addr_c6 = 4   => 0.1927272727,
										 pk_ssns_per_addr_c6 = 5   => 0.2182539683,
										 pk_ssns_per_addr_c6 = 6   => 0.2604651163,
										 pk_ssns_per_addr_c6 = 100 => 0.1287255635,
										 pk_ssns_per_addr_c6 = 101 => 0.1723556679,
										 pk_ssns_per_addr_c6 = 102 => 0.1710069444,
										 pk_ssns_per_addr_c6 = 103 => 0.1960784314,
																	  0.2513089005));

		pk_attr_addrs_last90_mm_b3 := __common__(map(pk_attr_addrs_last90 = 0 => 0.1310154271,
										  pk_attr_addrs_last90 = 1 => 0.1808429119,
																	  0.2133815552));

		pk_attr_addrs_last12_mm_b3 := __common__(map(pk_attr_addrs_last12 = 0 => 0.1206156172,
										  pk_attr_addrs_last12 = 1 => 0.1574364115,
										  pk_attr_addrs_last12 = 2 => 0.1719588551,
										  pk_attr_addrs_last12 = 3 => 0.1911057692,
																	  0.2706766917));

		pk_attr_addrs_last24_mm_b3 := __common__(map(pk_attr_addrs_last24 = 0 => 0.1149997408,
										  pk_attr_addrs_last24 = 1 => 0.1512004835,
										  pk_attr_addrs_last24 = 2 => 0.1550378831,
										  pk_attr_addrs_last24 = 3 => 0.1531130877,
										  pk_attr_addrs_last24 = 4 => 0.1558704453,
																	  0.2682926829));

		pk_ams_class_level_mm_b3 := __common__(map(pk_ams_class_level = -1000001 => 0.1420052275,
										pk_ams_class_level = 0        => 0.2579582876,
										pk_ams_class_level = 1        => 0.2245179063,
										pk_ams_class_level = 2        => 0.1988636364,
										pk_ams_class_level = 3        => 0.1737012987,
										pk_ams_class_level = 4        => 0.114374034,
										pk_ams_class_level = 5        => 0.0883742911,
										pk_ams_class_level = 6        => 0.0881801126,
										pk_ams_class_level = 7        => 0.0883054893,
										pk_ams_class_level = 8        => 0.085106383,
										pk_ams_class_level = 1000000  => 0.1412268188,
										pk_ams_class_level = 1000001  => 0.1030534351,
										pk_ams_class_level = 1000002  => 0.0922273782,
										pk_ams_class_level = 1000003  => 0.0826210826,
										pk_ams_class_level = 1000004  => 0.0500782473,
																		 0.0240384615));

		pk_ams_4yr_college_mm_b3 := __common__(map(pk_ams_4yr_college = -1 => 0.1472727273,
										pk_ams_4yr_college = 0  => 0.1449113562,
																   0.0726958027));

		pk_ams_college_type_mm_b3 := __common__(map(pk_ams_college_type = 0 => 0.1448942248,
										 pk_ams_college_type = 1 => 0.0857480781,
																	0.0963081862));

		pk_ams_income_level_code_mm_b3 := __common__(map(pk_ams_income_level_code = -1 => 0.1420052275,
											  pk_ams_income_level_code = 0  => 0.2267080745,
											  pk_ams_income_level_code = 1  => 0.1787905346,
											  pk_ams_income_level_code = 2  => 0.1328976035,
											  pk_ams_income_level_code = 3  => 0.1294919455,
											  pk_ams_income_level_code = 4  => 0.0991501416,
											  pk_ams_income_level_code = 5  => 0.0990009083,
																			   0.0873786408));

		pk_yr_in_dob2_mm_b3 := __common__(map(pk_yr_in_dob2 = 19 => 0.2780073462,
								   pk_yr_in_dob2 = 20 => 0.2347118346,
								   pk_yr_in_dob2 = 21 => 0.1997045063,
								   pk_yr_in_dob2 = 22 => 0.1848691695,
								   pk_yr_in_dob2 = 23 => 0.1449825894,
								   pk_yr_in_dob2 = 25 => 0.1140077821,
								   pk_yr_in_dob2 = 29 => 0.0976446035,
								   pk_yr_in_dob2 = 35 => 0.1034551628,
								   pk_yr_in_dob2 = 38 => 0.1017316017,
								   pk_yr_in_dob2 = 41 => 0.1067378252,
								   pk_yr_in_dob2 = 42 => 0.1063348416,
								   pk_yr_in_dob2 = 43 => 0.0825892857,
								   pk_yr_in_dob2 = 44 => 0.0743982495,
								   pk_yr_in_dob2 = 45 => 0.0877944325,
								   pk_yr_in_dob2 = 47 => 0.0771812081,
								   pk_yr_in_dob2 = 49 => 0.083143508,
								   pk_yr_in_dob2 = 57 => 0.0713256484,
								   pk_yr_in_dob2 = 60 => 0.057571965,
								   pk_yr_in_dob2 = 63 => 0.0486787204,
														 0.037302726));

		pk_ams_age_mm_b3 := __common__(map(pk_ams_age = -1 => 0.1371630619,
								pk_ams_age = 21 => 0.249754179,
								pk_ams_age = 22 => 0.2205683356,
								pk_ams_age = 23 => 0.200310559,
								pk_ams_age = 24 => 0.1876046901,
								pk_ams_age = 25 => 0.0967741935,
								pk_ams_age = 29 => 0.0907572383,
												   0.0860927152));

		pk_inferred_age_mm_b3 := __common__(map(pk_inferred_age = -1 => 0.2127659574,
									 pk_inferred_age = 18 => 0.2392478928,
									 pk_inferred_age = 19 => 0.2131116569,
									 pk_inferred_age = 20 => 0.1806679112,
									 pk_inferred_age = 21 => 0.1637973438,
									 pk_inferred_age = 22 => 0.149127907,
									 pk_inferred_age = 24 => 0.1155098543,
									 pk_inferred_age = 34 => 0.1113994809,
									 pk_inferred_age = 37 => 0.1085003455,
									 pk_inferred_age = 41 => 0.1054292929,
									 pk_inferred_age = 42 => 0.0741839763,
									 pk_inferred_age = 43 => 0.0842105263,
									 pk_inferred_age = 44 => 0.0829145729,
									 pk_inferred_age = 46 => 0.0666666667,
									 pk_inferred_age = 48 => 0.0658436214,
									 pk_inferred_age = 52 => 0.0614911606,
									 pk_inferred_age = 56 => 0.0648918469,
									 pk_inferred_age = 59 => 0.0487106017,
									 pk_inferred_age = 63 => 0.0449293967,
															 0.0387309436));

		pk_yr_reported_dob2_mm_b3 := __common__(map(pk_yr_reported_dob2 = -1 => 0.1768392777,
										 pk_yr_reported_dob2 = 19 => 0.2394067797,
										 pk_yr_reported_dob2 = 21 => 0.1905781585,
										 pk_yr_reported_dob2 = 22 => 0.1785268414,
										 pk_yr_reported_dob2 = 23 => 0.1374837873,
										 pk_yr_reported_dob2 = 32 => 0.0931619401,
										 pk_yr_reported_dob2 = 35 => 0.1134601832,
										 pk_yr_reported_dob2 = 39 => 0.1013268999,
										 pk_yr_reported_dob2 = 42 => 0.1031434185,
										 pk_yr_reported_dob2 = 43 => 0.0769230769,
										 pk_yr_reported_dob2 = 44 => 0.0840336134,
										 pk_yr_reported_dob2 = 45 => 0.0814606742,
										 pk_yr_reported_dob2 = 46 => 0.0672782875,
										 pk_yr_reported_dob2 = 49 => 0.0686813187,
										 pk_yr_reported_dob2 = 57 => 0.0627956989,
										 pk_yr_reported_dob2 = 60 => 0.0488505747,
										 pk_yr_reported_dob2 = 63 => 0.0476190476,
																	 0.0365566038));

		pk_avm_hit_level_mm_b3 := __common__(map(pk_avm_hit_level = -1 => 0.1308123998,
									  pk_avm_hit_level = 0  => 0.1302380086,
									  pk_avm_hit_level = 1  => 0.159102001,
															   0.1387263914));

		pk_avm_auto_diff2_lvl_mm_b3 := __common__(map(pk_avm_auto_diff2_lvl = -2 => 0.1300997551,
										   pk_avm_auto_diff2_lvl = -1 => 0.1685153584,
										   pk_avm_auto_diff2_lvl = 0  => 0.1607337168,
										   pk_avm_auto_diff2_lvl = 1  => 0.1379995584,
																		 0.132994186));

		pk_avm_auto_diff4_lvl_mm_b3 := __common__(map(pk_avm_auto_diff4_lvl = -1 => 0.1328149079,
										   pk_avm_auto_diff4_lvl = 0  => 0.1640526976,
																		 0.1740911418));

		pk_add2_avm_auto_diff2_lvl_mm_b3 := __common__(map(pk_add2_avm_auto_diff2_lvl = -3 => 0.139309429,
												pk_add2_avm_auto_diff2_lvl = -2 => 0.1525851198,
												pk_add2_avm_auto_diff2_lvl = -1 => 0.137283237,
												pk_add2_avm_auto_diff2_lvl = 0  => 0.1396838103,
																				   0.1300188206));

		pk2_add1_avm_mkt_mm_b3 := __common__(map(pk2_add1_avm_mkt = 0 => 0.2329495128,
									  pk2_add1_avm_mkt = 1 => 0.1346589714,
									  pk2_add1_avm_mkt = 2 => 0.1647634584,
									  pk2_add1_avm_mkt = 3 => 0.1423789333,
															  0.0801526718));

		pk2_add1_avm_pi_mm_b3 := __common__(map(pk2_add1_avm_pi = 0 => 0.2946428571,
									 pk2_add1_avm_pi = 1 => 0.1982360353,
									 pk2_add1_avm_pi = 2 => 0.1347235694,
															0.1368265683));

		pk2_add1_avm_hed_mm_b3 := __common__(map(pk2_add1_avm_hed = 0 => 0.3148688047,
									  pk2_add1_avm_hed = 1 => 0.2558139535,
									  pk2_add1_avm_hed = 2 => 0.1917293233,
									  pk2_add1_avm_hed = 3 => 0.1322714496,
									  pk2_add1_avm_hed = 4 => 0.1757508343,
									  pk2_add1_avm_hed = 5 => 0.1440771627,
															  0.0962732919));

		pk2_add1_avm_auto2_mm_b3 := __common__(map(pk2_add1_avm_auto2 = 0 => 0.3695652174,
										pk2_add1_avm_auto2 = 1 => 0.2378640777,
										pk2_add1_avm_auto2 = 2 => 0.2141779789,
										pk2_add1_avm_auto2 = 3 => 0.1842385517,
										pk2_add1_avm_auto2 = 4 => 0.1300997551,
										pk2_add1_avm_auto2 = 5 => 0.1873599283,
										pk2_add1_avm_auto2 = 6 => 0.1418451822,
																  0.0950323974));

		pk2_add1_avm_auto4_mm_b3 := __common__(map(pk2_add1_avm_auto4 = 0 => 0.28,
										pk2_add1_avm_auto4 = 1 => 0.237458194,
										pk2_add1_avm_auto4 = 2 => 0.1981981982,
										pk2_add1_avm_auto4 = 3 => 0.1344004065,
										pk2_add1_avm_auto4 = 4 => 0.158489348,
										pk2_add1_avm_auto4 = 5 => 0.1493383743,
																  0.1042128603));

		pk2_add1_avm_med_mm_b3 := __common__(map(pk2_add1_avm_med = 0 => 0.3333333333,
									  pk2_add1_avm_med = 1 => 0.25,
									  pk2_add1_avm_med = 2 => 0.207833733,
									  pk2_add1_avm_med = 3 => 0.1821115722,
									  pk2_add1_avm_med = 4 => 0.1665699362,
									  pk2_add1_avm_med = 5 => 0.1405459409,
									  pk2_add1_avm_med = 6 => 0.1014362657,
															  0.0912767818));

		pk2_add1_avm_to_med_ratio_mm_b3 := __common__(map(pk2_add1_avm_to_med_ratio = 0 => 0.1323321854,
											   pk2_add1_avm_to_med_ratio = 1 => 0.1560494414,
											   pk2_add1_avm_to_med_ratio = 2 => 0.1569950517,
											   pk2_add1_avm_to_med_ratio = 3 => 0.1466026588,
											   pk2_add1_avm_to_med_ratio = 4 => 0.1322620519,
																				0.1443965517));

		pk2_add2_avm_mkt_mm_b3 := __common__(map(pk2_add2_avm_mkt = 0 => 0.2070063694,
									  pk2_add2_avm_mkt = 1 => 0.1985981308,
									  pk2_add2_avm_mkt = 2 => 0.1389334447,
									  pk2_add2_avm_mkt = 3 => 0.1220785679,
															  0.1030042918));

		pk2_add2_avm_pi_mm_b3 := __common__(map(pk2_add2_avm_pi = 0 => 0.2014652015,
									 pk2_add2_avm_pi = 1 => 0.1746031746,
									 pk2_add2_avm_pi = 2 => 0.1386543813,
									 pk2_add2_avm_pi = 3 => 0.1346918489,
															0.1056257176));

		pk2_add2_avm_hed_mm_b3 := __common__(map(pk2_add2_avm_hed = 0 => 0.28,
									  pk2_add2_avm_hed = 1 => 0.219924812,
									  pk2_add2_avm_hed = 2 => 0.1594982079,
									  pk2_add2_avm_hed = 3 => 0.1387468348,
									  pk2_add2_avm_hed = 4 => 0.1502797762,
									  pk2_add2_avm_hed = 5 => 0.1283118324,
															  0.1054313099));

		pk2_add2_avm_auto4_mm_b3 := __common__(map(pk2_add2_avm_auto4 = 0 => 0.2365591398,
										pk2_add2_avm_auto4 = 1 => 0.2294372294,
										pk2_add2_avm_auto4 = 2 => 0.2105263158,
										pk2_add2_avm_auto4 = 3 => 0.1366709955,
										pk2_add2_avm_auto4 = 4 => 0.1469486671,
																  0.0917107584));

		pk2_yr_add1_avm_rec_dt_mm_b3 := __common__(map(pk2_yr_add1_avm_recording_date = 0 => 0.1573362605,
											pk2_yr_add1_avm_recording_date = 1 => 0.1478477854,
											pk2_yr_add1_avm_recording_date = 2 => 0.1334799397,
											pk2_yr_add1_avm_recording_date = 3 => 0.1575568955,
																				  0.1512474012));

		pk2_yr_add1_avm_assess_year_mm_b3 := __common__(map(pk2_yr_add1_avm_assess_year = 0 => 0.131231299,
												 pk2_yr_add1_avm_assess_year = 1 => 0.1688201292,
																					0.1463043478));

		pk2_yr_add2_avm_assess_year_mm_b3 := __common__(map(pk2_yr_add2_avm_assess_year = 0 => 0.1394225908,
												 pk2_yr_add2_avm_assess_year = 1 => 0.1477978925,
																					0.1277065232));

		pk_dist_a1toa2_mm_b3 := __common__(map(pk_dist_a1toa2_2 = 0 => 0.1185979381,
									pk_dist_a1toa2_2 = 1 => 0.1225795682,
									pk_dist_a1toa2_2 = 2 => 0.145403045,
									pk_dist_a1toa2_2 = 3 => 0.1575103207,
															0.1842075321));

		pk_dist_a1toa3_mm_b3 := __common__(map(pk_dist_a1toa3_2 = 0 => 0.108165712,
									pk_dist_a1toa3_2 = 1 => 0.1008358337,
									pk_dist_a1toa3_2 = 2 => 0.1206644379,
									pk_dist_a1toa3_2 = 3 => 0.136900369,
									pk_dist_a1toa3_2 = 4 => 0.1504491018,
									pk_dist_a1toa3_2 = 5 => 0.1408114558,
															0.1764430334));

		pk_rc_disthphoneaddr_mm_b3 := __common__(map(pk_rc_disthphoneaddr_2 = 0 => 0.1087883093,
										  pk_rc_disthphoneaddr_2 = 1 => 0.1204070096,
										  pk_rc_disthphoneaddr_2 = 2 => 0.1355421687,
										  pk_rc_disthphoneaddr_2 = 3 => 0.1369565217,
																		0.1543459566));

		pk_out_st_division_lvl_mm_b3 := __common__(map(pk_out_st_division_lvl = -1 => 0.1111111111,
											pk_out_st_division_lvl = 0  => 0.0882778582,
											pk_out_st_division_lvl = 1  => 0.1301942186,
											pk_out_st_division_lvl = 2  => 0.1242993736,
											pk_out_st_division_lvl = 3  => 0.1520677304,
											pk_out_st_division_lvl = 4  => 0.1480848497,
											pk_out_st_division_lvl = 5  => 0.1422704605,
											pk_out_st_division_lvl = 6  => 0.1372447661,
											pk_out_st_division_lvl = 7  => 0.1619424302,
																		   0.1467336683));

		pk_wealth_index_mm_b3 := __common__(map(pk_wealth_index_2 = 0 => 0.1379262974,
									 pk_wealth_index_2 = 1 => 0.1826420356,
									 pk_wealth_index_2 = 2 => 0.1369733808,
									 pk_wealth_index_2 = 3 => 0.1299347955,
															  0.0825688073));

		pk_impulse_count_mm_b3 := __common__(if(pk_impulse_count_2 = 0, 0.1383543201, NULL));

		pk_attr_num_nonderogs90_b_mm_b3 := __common__(map(pk_attr_num_nonderogs90_b = 0  => 0.2550585729,
											   pk_attr_num_nonderogs90_b = 1  => 0.1905628198,
											   pk_attr_num_nonderogs90_b = 2  => 0.1263366337,
											   pk_attr_num_nonderogs90_b = 3  => 0.0694087404,
											   pk_attr_num_nonderogs90_b = 4  => 0.06,
											   pk_attr_num_nonderogs90_b = 10 => 0.1900452489,
											   pk_attr_num_nonderogs90_b = 11 => 0.1370279434,
											   pk_attr_num_nonderogs90_b = 12 => 0.0929953011,
											   pk_attr_num_nonderogs90_b = 13 => 0.0430042399,
																				 0.0211640212));

		pk_ssns_per_addr2_mm_b3 := __common__(map(pk_ssns_per_addr2 = -101 => 0.1321227301,
									   pk_ssns_per_addr2 = -2   => 0.1072961373,
									   pk_ssns_per_addr2 = -1   => 0.0613718412,
									   pk_ssns_per_addr2 = 0    => 0.0557103064,
									   pk_ssns_per_addr2 = 1    => 0.0593538693,
									   pk_ssns_per_addr2 = 2    => 0.0829045169,
									   pk_ssns_per_addr2 = 3    => 0.0989941768,
									   pk_ssns_per_addr2 = 4    => 0.1134020619,
									   pk_ssns_per_addr2 = 5    => 0.1200434546,
									   pk_ssns_per_addr2 = 6    => 0.1211771495,
									   pk_ssns_per_addr2 = 7    => 0.1484268126,
									   pk_ssns_per_addr2 = 8    => 0.162086818,
									   pk_ssns_per_addr2 = 9    => 0.1802704056,
									   pk_ssns_per_addr2 = 10   => 0.1716923077,
									   pk_ssns_per_addr2 = 11   => 0.1887052342,
									   pk_ssns_per_addr2 = 12   => 0.1640138408,
									   pk_ssns_per_addr2 = 100  => 0.1117764471,
									   pk_ssns_per_addr2 = 101  => 0.1264367816,
									   pk_ssns_per_addr2 = 102  => 0.1478903871,
																   0.1545876473));

		pk_yr_prop1_prev_purch_dt2_mm_b3 := __common__(map(pk_yr_prop1_prev_purchase_date2 = -1 => 0.1394965086,
												pk_yr_prop1_prev_purchase_date2 = 0  => 0.0989010989,
												pk_yr_prop1_prev_purchase_date2 = 1  => 0.0845070423,
												pk_yr_prop1_prev_purchase_date2 = 2  => 0.0571428571,
												pk_yr_prop1_prev_purchase_date2 = 3  => 0.0365853659,
												pk_yr_prop1_prev_purchase_date2 = 4  => 0.0687022901,
												pk_yr_prop1_prev_purchase_date2 = 5  => 0.0900900901,
												pk_yr_prop1_prev_purchase_date2 = 6  => 0.0683760684,
																						0.0492957746));

		pk_estimated_income_mm_b4 := __common__(map(pk_estimated_income = -1 => 0.1543438078,
										 pk_estimated_income = 0  => 0.2051282051,
										 pk_estimated_income = 1  => 0.1556291391,
										 pk_estimated_income = 2  => 0.1621073961,
										 pk_estimated_income = 3  => 0.1423160173,
										 pk_estimated_income = 4  => 0.1375623664,
										 pk_estimated_income = 5  => 0.127304875,
										 pk_estimated_income = 6  => 0.1163273785,
										 pk_estimated_income = 7  => 0.0952469365,
										 pk_estimated_income = 8  => 0.0829196543,
										 pk_estimated_income = 9  => 0.0723466765,
										 pk_estimated_income = 10 => 0.076797051,
										 pk_estimated_income = 11 => 0.0712270804,
										 pk_estimated_income = 12 => 0.065625,
										 pk_estimated_income = 13 => 0.0670540903,
										 pk_estimated_income = 14 => 0.0605078336,
										 pk_estimated_income = 15 => 0.0711325967,
										 pk_estimated_income = 16 => 0.0645669291,
										 pk_estimated_income = 17 => 0.0687342833,
										 pk_estimated_income = 18 => 0.0504959423,
										 pk_estimated_income = 19 => 0.0633552965,
										 pk_estimated_income = 20 => 0.059447983,
										 pk_estimated_income = 21 => 0.0469798658,
																	 0.0163934426));

		pk_yr_adl_w_first_seen2_mm_b4 := __common__(map(pk_yr_adl_w_first_seen2 = -1 => 0.0895158216,
											 pk_yr_adl_w_first_seen2 = 0  => 0.051457976,
											 pk_yr_adl_w_first_seen2 = 1  => 0.0229468599,
																			 0.0211640212));

		pk_yr_adl_w_last_seen2_mm_b4 := __common__(map(pk_yr_adl_w_last_seen2 = -1 => 0.0895158216,
											pk_yr_adl_w_last_seen2 = 0  => 0.0174587779,
											pk_yr_adl_w_last_seen2 = 1  => 0.0268817204,
																		   0.0334051724));

		pk_pr_count_mm_b4 := __common__(map(pk_pr_count = -1 => 0.0941627113,
								 pk_pr_count = 0  => 0.032192706,
								 pk_pr_count = 1  => 0.0371606587,
													 0.0256410256));

		pk_addrs_sourced_lvl_mm_b4 := __common__(map(pk_addrs_sourced_lvl = 0 => 0.0913920346,
										  pk_addrs_sourced_lvl = 1 => 0.0393213035,
										  pk_addrs_sourced_lvl = 2 => 0.0300065232,
																	  0.0299334812));

		pk_add2_own_level_mm_b4 := __common__(map(pk_add2_own_level = 0 => 0.0860998777,
									   pk_add2_own_level = 1 => 0.0942028986,
									   pk_add2_own_level = 2 => 0.0406976744,
																0.0642458101));

		pk_add3_own_level_mm_b4 := __common__(map(pk_add3_own_level = 0 => 0.0863853443,
									   pk_add3_own_level = 1 => 0.0935723655,
									   pk_add3_own_level = 2 => 0.0427350427,
																0.050209205));

		pk_naprop_level2_mm_b4 := __common__(map(pk_naprop_level2 = -1 => 0.1108247423,
									  pk_naprop_level2 = 0  => 0.1256198347,
									  pk_naprop_level2 = 2  => 0.0840613421,
									  pk_naprop_level2 = 3  => 0.0875653083,
									  pk_naprop_level2 = 4  => 0.08043654,
															   0.0502248876));

		pk_yr_add1_purchase_date2_mm_b4 := __common__(map(pk_yr_add1_purchase_date2 = -1 => 0.0829134541,
											   pk_yr_add1_purchase_date2 = 0  => 0.1126183773,
											   pk_yr_add1_purchase_date2 = 1  => 0.0955909596,
											   pk_yr_add1_purchase_date2 = 2  => 0.1006321113,
											   pk_yr_add1_purchase_date2 = 3  => 0.0828989406,
											   pk_yr_add1_purchase_date2 = 4  => 0.0707240799,
																				 0.058525605));

		pk_yr_add1_built_date2_mm_b4 := __common__(map(pk_yr_add1_built_date2 = -4 => 0.0838392343,
											pk_yr_add1_built_date2 = -3 => 0.0952380952,
											pk_yr_add1_built_date2 = -2 => 0.1025331725,
											pk_yr_add1_built_date2 = -1 => 0.1083099907,
											pk_yr_add1_built_date2 = 0  => 0.0761199947,
											pk_yr_add1_built_date2 = 1  => 0.0792939199,
											pk_yr_add1_built_date2 = 2  => 0.0994206257,
																		   0.1059602649));

		pk_yr_add1_mortgage_date2_mm_b4 := __common__(map(pk_yr_add1_mortgage_date2 = -1 => 0.0832169933,
											   pk_yr_add1_mortgage_date2 = 0  => 0.1140278917,
											   pk_yr_add1_mortgage_date2 = 1  => 0.0966280825,
																				 0.0848080901));

		pk_add1_mortgage_risk_mm_b4 := __common__(map(pk_add1_mortgage_risk = -1 => 0.2121212121,
										   pk_add1_mortgage_risk = 0  => 0.0840840841,
										   pk_add1_mortgage_risk = 1  => 0.0841025641,
										   pk_add1_mortgage_risk = 2  => 0.1155163975,
																		 0.1260849703));

		pk_add1_assessed_amount2_mm_b4 := __common__(map(pk_add1_assessed_amount2 = -1 => 0.0850085928,
											  pk_add1_assessed_amount2 = 0  => 0.1362612613,
											  pk_add1_assessed_amount2 = 1  => 0.1276803119,
											  pk_add1_assessed_amount2 = 2  => 0.1172365666,
											  pk_add1_assessed_amount2 = 3  => 0.1014150943,
											  pk_add1_assessed_amount2 = 4  => 0.0936385256,
											  pk_add1_assessed_amount2 = 5  => 0.0840108401,
																			   0.0747663551));

		pk_yr_add1_date_first_seen2_mm_b4 := __common__(map(pk_yr_add1_date_first_seen2 = -1 => 0.1395026256,
												 pk_yr_add1_date_first_seen2 = 0  => 0.1258001422,
												 pk_yr_add1_date_first_seen2 = 1  => 0.105523396,
												 pk_yr_add1_date_first_seen2 = 2  => 0.0858050847,
												 pk_yr_add1_date_first_seen2 = 3  => 0.0740676496,
												 pk_yr_add1_date_first_seen2 = 4  => 0.0728534258,
												 pk_yr_add1_date_first_seen2 = 5  => 0.0615456895,
												 pk_yr_add1_date_first_seen2 = 6  => 0.0491520552,
												 pk_yr_add1_date_first_seen2 = 7  => 0.0338316286,
												 pk_yr_add1_date_first_seen2 = 8  => 0.0277367955,
												 pk_yr_add1_date_first_seen2 = 9  => 0.0203477617,
																					 0.0129533679));

		pk_add1_building_area2_mm_b4 := __common__(map(pk_add1_building_area2 = -99 => 0.0837732487,
											pk_add1_building_area2 = -4  => 0.1323155216,
											pk_add1_building_area2 = -3  => 0.0957055215,
											pk_add1_building_area2 = -2  => 0.1006949472,
											pk_add1_building_area2 = -1  => 0.0764012276,
											pk_add1_building_area2 = 0   => 0.0608294931,
											pk_add1_building_area2 = 1   => 0.0546448087,
											pk_add1_building_area2 = 2   => 0.0943396226,
											pk_add1_building_area2 = 3   => 0.1134020619,
																			0));

		pk_add1_no_of_baths_mm_b4 := __common__(map(pk_add1_no_of_baths = -3 => 0.0842200636,
										 pk_add1_no_of_baths = -2 => 0.1077770131,
										 pk_add1_no_of_baths = -1 => 0.0876379486,
										 pk_add1_no_of_baths = 0  => 0.067473414,
										 pk_add1_no_of_baths = 1  => 0.0651162791,
																	 0.0992907801));

		pk_property_owned_total_mm_b4 := __common__(if(pk_property_owned_total = -1, 0.0864242249, NULL));

		pk_prop_own_assess_tot2_mm_b4 := __common__(if(pk_prop_own_assess_tot2 = 0, 0.0864242249, NULL));

		pk_prop1_sale_price2_mm_b4 := __common__(map(pk_prop1_sale_price2 = 0 => 0.0869029998,
										  pk_prop1_sale_price2 = 1 => 0.05,
																	  0.0444145357));

		pk_add2_land_use_risk_level_mm_b4 := __common__(map(pk_add2_land_use_risk_level = 0 => 0.0942028986,
												 pk_add2_land_use_risk_level = 2 => 0.0951515152,
												 pk_add2_land_use_risk_level = 3 => 0.0837479724,
																					0.1239263804));

		pk_add2_building_area2_mm_b4 := __common__(map(pk_add2_building_area2 = -4 => 0.0834212027,
											pk_add2_building_area2 = -3 => 0.1439749609,
											pk_add2_building_area2 = -2 => 0.1003649635,
											pk_add2_building_area2 = -1 => 0.1058078468,
											pk_add2_building_area2 = 0  => 0.0850515464,
											pk_add2_building_area2 = 1  => 0.0612244898,
																		   0.1209150327));

		pk_add2_no_of_baths_mm_b4 := __common__(map(pk_add2_no_of_baths = -3 => 0.0837688417,
										 pk_add2_no_of_baths = -2 => 0.1203342618,
										 pk_add2_no_of_baths = -1 => 0.0925205361,
										 pk_add2_no_of_baths = 0  => 0.0813835198,
										 pk_add2_no_of_baths = 1  => 0.1297297297,
																	 0.125984252));

		pk_yr_add2_mortgage_date2_mm_b4 := __common__(map(pk_yr_add2_mortgage_date2 = -1 => 0.084760747,
											   pk_yr_add2_mortgage_date2 = 0  => 0.1109346042,
																				 0.0931578947));

		pk_add2_mortgage_risk_mm_b4 := __common__(map(pk_add2_mortgage_risk = -1 => 0.1,
										   pk_add2_mortgage_risk = 0  => 0.0853269537,
										   pk_add2_mortgage_risk = 1  => 0.0853569026,
										   pk_add2_mortgage_risk = 2  => 0.1137152778,
																		 0.1195286195));

		pk_yr_add2_mortgage_due_date2_mm_b4 := __common__(map(pk_yr_add2_mortgage_due_date2 = -1 => 0.084871488,
												   pk_yr_add2_mortgage_due_date2 = 0  => 0.0759075908,
												   pk_yr_add2_mortgage_due_date2 = 1  => 0.1005542359,
												   pk_yr_add2_mortgage_due_date2 = 2  => 0.1125,
																						 0.1135693215));

		pk_add2_assessed_amount2_mm_b4 := __common__(map(pk_add2_assessed_amount2 = -1 => 0.0847338584,
											  pk_add2_assessed_amount2 = 0  => 0.1282965075,
											  pk_add2_assessed_amount2 = 1  => 0.1072274882,
											  pk_add2_assessed_amount2 = 2  => 0.0917431193,
											  pk_add2_assessed_amount2 = 3  => 0.0923728814,
																			   0.075669383));

		pk_yr_add2_date_first_seen2_mm_b4 := __common__(map(pk_yr_add2_date_first_seen2 = -1 => 0.1040346267,
												 pk_yr_add2_date_first_seen2 = 0  => 0.136468868,
												 pk_yr_add2_date_first_seen2 = 1  => 0.1157250925,
												 pk_yr_add2_date_first_seen2 = 2  => 0.097653293,
												 pk_yr_add2_date_first_seen2 = 3  => 0.0895108422,
												 pk_yr_add2_date_first_seen2 = 4  => 0.073817292,
												 pk_yr_add2_date_first_seen2 = 5  => 0.0672052883,
												 pk_yr_add2_date_first_seen2 = 6  => 0.047556719,
												 pk_yr_add2_date_first_seen2 = 7  => 0.0566037736,
												 pk_yr_add2_date_first_seen2 = 8  => 0.0455835067,
												 pk_yr_add2_date_first_seen2 = 9  => 0.0314893617,
												 pk_yr_add2_date_first_seen2 = 10 => 0.0257104195,
																					 0.0211898941));

		pk_add3_mortgage_risk_mm_b4 := __common__(map(pk_add3_mortgage_risk = -1 => 0.25,
										   pk_add3_mortgage_risk = 0  => 0.0789115646,
										   pk_add3_mortgage_risk = 1  => 0.1355932203,
										   pk_add3_mortgage_risk = 2  => 0.0860316604,
										   pk_add3_mortgage_risk = 3  => 0.1079622132,
										   pk_add3_mortgage_risk = 4  => 0.1015625,
																		 0.096));

		pk_add3_assessed_amount2_mm_b4 := __common__(map(pk_add3_assessed_amount2 = -1 => 0.0861795075,
											  pk_add3_assessed_amount2 = 0  => 0.1408016444,
											  pk_add3_assessed_amount2 = 1  => 0.1234347048,
											  pk_add3_assessed_amount2 = 2  => 0.0718424102,
																			   0.0746799431));

		pk_yr_add3_date_first_seen2_mm_b4 := __common__(map(pk_yr_add3_date_first_seen2 = -1 => 0.1055845594,
												 pk_yr_add3_date_first_seen2 = 0  => 0.1582799634,
												 pk_yr_add3_date_first_seen2 = 1  => 0.1231838282,
												 pk_yr_add3_date_first_seen2 = 2  => 0.0920369302,
												 pk_yr_add3_date_first_seen2 = 3  => 0.0841022001,
												 pk_yr_add3_date_first_seen2 = 4  => 0.0813424346,
												 pk_yr_add3_date_first_seen2 = 5  => 0.0705969049,
												 pk_yr_add3_date_first_seen2 = 6  => 0.0558554817,
												 pk_yr_add3_date_first_seen2 = 7  => 0.0506428759,
												 pk_yr_add3_date_first_seen2 = 8  => 0.0314404095,
																					 0.0272969374));

		pk_w_count_mm_b4 := __common__(map(pk_w_count = 0 => 0.0895347063,
								pk_w_count = 1 => 0.0312261995,
												  0.0165876777));

		pk_bk_level_mm_b4 := __common__(if(pk_bk_level_2 = 0, 0.0864242249, NULL));
		pk_eviction_level_mm_b4 := __common__(if(pk_eviction_level = 0, 0.0864242249, NULL));
		pk_lien_type_level_mm_b4 := __common__(map(pk_lien_type_level = 0 => 0.0864279815,
																  0));

		pk_yr_liens_last_unrel_date3_mm_b4 := __common__(if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0864242249, NULL));
		pk_yr_ln_unrel_cj_f_sn2_mm_b4 := __common__(if(pk_yr_liens_unrel_cj_first_sn2 = -1, 0.0864242249, NULL));
		pk_yr_ln_unrel_lt_f_sn2_mm_b4 := __common__(if(pk_yr_liens_unrel_lt_first_sn2 = -1, 0.0864242249, NULL));
		pk_yr_ln_unrel_ot_f_sn2_mm_b4 := __common__(if(pk_yr_liens_unrel_ot_first_sn2 = -1, 0.0864242249, NULL));
		pk_yr_criminal_last_date2_mm_b4 := __common__(if(pk_yr_criminal_last_date2 = -1, 0.0864242249, NULL));
		pk_yr_felony_last_date2_mm_b4 := __common__(if(pk_yr_felony_last_date2 = -1, 0.0864242249, NULL));
		pk_attr_total_number_derogs_mm_b4 := __common__(if(pk_attr_total_number_derogs_5 = 0, 0.0864242249, NULL));

		pk_yr_rc_ssnhighissue2_mm_b4 := __common__(map(pk_yr_rc_ssnhighissue2 = -1 => 0.0842824601,
											pk_yr_rc_ssnhighissue2 = 0  => 0.0760869565,
											pk_yr_rc_ssnhighissue2 = 1  => 0.070323488,
											pk_yr_rc_ssnhighissue2 = 2  => 0.1130638547,
											pk_yr_rc_ssnhighissue2 = 3  => 0.1471631206,
											pk_yr_rc_ssnhighissue2 = 4  => 0.1287915918,
											pk_yr_rc_ssnhighissue2 = 5  => 0.1091837403,
											pk_yr_rc_ssnhighissue2 = 6  => 0.0939490446,
											pk_yr_rc_ssnhighissue2 = 7  => 0.0865561694,
											pk_yr_rc_ssnhighissue2 = 8  => 0.0644836272,
											pk_yr_rc_ssnhighissue2 = 9  => 0.0608907446,
											pk_yr_rc_ssnhighissue2 = 10 => 0.0496232788,
											pk_yr_rc_ssnhighissue2 = 11 => 0.0354388159,
											pk_yr_rc_ssnhighissue2 = 12 => 0.0326958667,
											pk_yr_rc_ssnhighissue2 = 13 => 0.0206455365,
																		   0.0177918191));

		pk_pl_sourced_level_mm_b4 := __common__(map(pk_pl_sourced_level = 0 => 0.0885575028,
										 pk_pl_sourced_level = 1 => 0.0690607735,
										 pk_pl_sourced_level = 2 => 0.0496009122,
																	0.0391752577));

		pk_prof_lic_cat_mm_b4 := __common__(map(pk_prof_lic_cat = -1 => 0.0882637629,
									 pk_prof_lic_cat = 0  => 0.0703363914,
									 pk_prof_lic_cat = 1  => 0.0332850941,
									 pk_prof_lic_cat = 2  => 0.0346487007,
															 0.0052910053));

		pk_add1_lres_mm_b4 := __common__(map(pk_add1_lres = -2 => 0.0517241379,
								  pk_add1_lres = -1 => 0.1428713264,
								  pk_add1_lres = 0  => 0.1408751334,
								  pk_add1_lres = 1  => 0.1467611336,
								  pk_add1_lres = 2  => 0.1372896368,
								  pk_add1_lres = 3  => 0.1063449508,
								  pk_add1_lres = 4  => 0.1141318624,
								  pk_add1_lres = 5  => 0.1119613371,
								  pk_add1_lres = 6  => 0.0930203676,
								  pk_add1_lres = 7  => 0.0741202549,
								  pk_add1_lres = 8  => 0.0607189829,
								  pk_add1_lres = 9  => 0.046402152,
								  pk_add1_lres = 10 => 0.0309895528,
													   0.0193842645));

		pk_add2_lres_mm_b4 := __common__(map(pk_add2_lres = -2 => 0.103908326,
								  pk_add2_lres = -1 => 0.0656455142,
								  pk_add2_lres = 0  => 0.1347644603,
								  pk_add2_lres = 1  => 0.1184631804,
								  pk_add2_lres = 2  => 0.1035932203,
								  pk_add2_lres = 3  => 0.098296837,
								  pk_add2_lres = 4  => 0.0848997494,
								  pk_add2_lres = 5  => 0.0817112733,
								  pk_add2_lres = 6  => 0.062962963,
								  pk_add2_lres = 7  => 0.0446506234,
								  pk_add2_lres = 8  => 0.0439525184,
								  pk_add2_lres = 9  => 0.0306905371,
													   0.0175953079));

		pk_add3_lres_mm_b4 := __common__(map(pk_add3_lres = -2 => 0.1053808709,
								  pk_add3_lres = -1 => 0.0602226721,
								  pk_add3_lres = 0  => 0.0900381762,
								  pk_add3_lres = 1  => 0.0674846626,
								  pk_add3_lres = 2  => 0.0703203203,
								  pk_add3_lres = 3  => 0.0558804418,
								  pk_add3_lres = 4  => 0.0596707819,
								  pk_add3_lres = 5  => 0.0384889522,
													   0.0438957476));

		pk_lres_flag_level_mm_b4 := __common__(map(pk_lres_flag_level = 0 => 0.1369799406,
										pk_lres_flag_level = 1 => 0.0904313243,
																  0.0694837198));

		pk_addrs_5yr_mm_b4 := __common__(map(pk_addrs_5yr = 0 => 0.0643397468,
								  pk_addrs_5yr = 1 => 0.094991121,
								  pk_addrs_5yr = 2 => 0.1075367647,
								  pk_addrs_5yr = 3 => 0.1321299639,
													  0.128440367));

		pk_addrs_10yr_mm_b4 := __common__(map(pk_addrs_10yr = 0 => 0.0709395973,
								   pk_addrs_10yr = 1 => 0.0908261068,
								   pk_addrs_10yr = 2 => 0.0899752271,
								   pk_addrs_10yr = 3 => 0.0982532751,
														0.1051693405));

		pk_add_lres_month_avg2_mm_b4 := __common__(map(pk_add_lres_month_avg2 = -1 => 0.1407093292,
											pk_add_lres_month_avg2 = 0  => 0.1702867072,
											pk_add_lres_month_avg2 = 1  => 0.1557916034,
											pk_add_lres_month_avg2 = 2  => 0.1493965876,
											pk_add_lres_month_avg2 = 3  => 0.1245830126,
											pk_add_lres_month_avg2 = 4  => 0.1205923836,
											pk_add_lres_month_avg2 = 5  => 0.1053639847,
											pk_add_lres_month_avg2 = 6  => 0.0983606557,
											pk_add_lres_month_avg2 = 7  => 0.0926792735,
											pk_add_lres_month_avg2 = 8  => 0.0822716476,
											pk_add_lres_month_avg2 = 9  => 0.069845126,
											pk_add_lres_month_avg2 = 10 => 0.0740268028,
											pk_add_lres_month_avg2 = 11 => 0.0671755725,
											pk_add_lres_month_avg2 = 12 => 0.0486486486,
											pk_add_lres_month_avg2 = 13 => 0.0381753032,
											pk_add_lres_month_avg2 = 15 => 0.0235320996,
																		   0.0202134908));

		pk_nameperssn_count_mm_b4 := __common__(map(pk_nameperssn_count = 0 => 0.0858151266,
										 pk_nameperssn_count = 1 => 0.0930612245,
																	0.1609195402));

		pk_ssns_per_adl_mm_b4 := __common__(map(pk_ssns_per_adl = -1 => 0.1439768977,
									 pk_ssns_per_adl = 0  => 0.0847704598,
									 pk_ssns_per_adl = 1  => 0.0810810811,
									 pk_ssns_per_adl = 2  => 0.0746268657,
									 pk_ssns_per_adl = 3  => 0.1217391304,
															 0.1612903226));

		pk_addrs_per_adl_mm_b4 := __common__(map(pk_addrs_per_adl = -6 => 0.1580052493,
									  pk_addrs_per_adl = -5 => 0.1044867173,
									  pk_addrs_per_adl = -4 => 0.1058823529,
									  pk_addrs_per_adl = -3 => 0.0899410965,
									  pk_addrs_per_adl = -2 => 0.0690567147,
									  pk_addrs_per_adl = -1 => 0.0652741514,
									  pk_addrs_per_adl = 0  => 0.0553745928,
									  pk_addrs_per_adl = 1  => 0.052238806,
									  pk_addrs_per_adl = 2  => 0.0611038108,
															   0.0634920635));

		pk_phones_per_adl_mm_b4 := __common__(map(pk_phones_per_adl = -1 => 0.0962016731,
									   pk_phones_per_adl = 0  => 0.0534246575,
									   pk_phones_per_adl = 1  => 0.056726094,
																 0.0818181818));

		pk_adlperssn_count_mm_b4 := __common__(map(pk_adlperssn_count = -1 => 0.0919377652,
										pk_adlperssn_count = 0  => 0.0838667986,
										pk_adlperssn_count = 1  => 0.0911680912,
																   0.1002431775));

		pk_adls_per_phone_mm_b4 := __common__(map(pk_adls_per_phone = -2 => 0.1147986444,
									   pk_adls_per_phone = -1 => 0.0628266667,
									   pk_adls_per_phone = 0  => 0.0528735632,
																 0.0769230769));

		pk_ssns_per_adl_c6_mm_b4 := __common__(map(pk_ssns_per_adl_c6 = 0 => 0.0764116473,
										pk_ssns_per_adl_c6 = 1 => 0.1195659113,
																  0.1340996169));

		pk_ssns_per_addr_c6_mm_b4 := __common__(map(pk_ssns_per_addr_c6 = 0   => 0.0691607853,
										 pk_ssns_per_addr_c6 = 1   => 0.1186065392,
										 pk_ssns_per_addr_c6 = 2   => 0.1247939722,
										 pk_ssns_per_addr_c6 = 3   => 0.1625816993,
										 pk_ssns_per_addr_c6 = 4   => 0.1966426859,
										 pk_ssns_per_addr_c6 = 5   => 0.1510791367,
										 pk_ssns_per_addr_c6 = 6   => 0.219047619,
										 pk_ssns_per_addr_c6 = 100 => 0.1329225352,
										 pk_ssns_per_addr_c6 = 101 => 0.1846153846,
										 pk_ssns_per_addr_c6 = 102 => 0.1,
										 pk_ssns_per_addr_c6 = 103 => 0.3333333333,
																	  0.25));

		pk_attr_addrs_last90_mm_b4 := __common__(map(pk_attr_addrs_last90 = 0 => 0.0819520602,
										  pk_attr_addrs_last90 = 1 => 0.1348500517,
																	  0.2309859155));

		pk_attr_addrs_last12_mm_b4 := __common__(map(pk_attr_addrs_last12 = 0 => 0.0722277161,
										  pk_attr_addrs_last12 = 1 => 0.122446104,
										  pk_attr_addrs_last12 = 2 => 0.1419797688,
										  pk_attr_addrs_last12 = 3 => 0.2216981132,
																	  0.2459016393));

		pk_attr_addrs_last24_mm_b4 := __common__(map(pk_attr_addrs_last24 = 0 => 0.0665994962,
										  pk_attr_addrs_last24 = 1 => 0.1038124304,
										  pk_attr_addrs_last24 = 2 => 0.1305652037,
										  pk_attr_addrs_last24 = 3 => 0.1412680756,
										  pk_attr_addrs_last24 = 4 => 0.1783681214,
																	  0.1666666667));

		pk_ams_class_level_mm_b4 := __common__(map(pk_ams_class_level = -1000001 => 0.0869408575,
										pk_ams_class_level = 0        => 0.1554993679,
										pk_ams_class_level = 1        => 0.1362179487,
										pk_ams_class_level = 2        => 0.1049210771,
										pk_ams_class_level = 3        => 0.0852713178,
										pk_ams_class_level = 4        => 0.0956937799,
										pk_ams_class_level = 5        => 0.0696123385,
										pk_ams_class_level = 6        => 0.0671031097,
										pk_ams_class_level = 7        => 0.0493197279,
										pk_ams_class_level = 8        => 0.0499040307,
										pk_ams_class_level = 1000000  => 0.1160877514,
										pk_ams_class_level = 1000001  => 0.0668824164,
										pk_ams_class_level = 1000002  => 0.0656398973,
										pk_ams_class_level = 1000003  => 0.0478723404,
										pk_ams_class_level = 1000004  => 0.0290948276,
																		 0.0323741007));

		pk_ams_4yr_college_mm_b4 := __common__(map(pk_ams_4yr_college = -1 => 0.103410341,
										pk_ams_4yr_college = 0  => 0.0901947044,
																   0.0510667584));

		pk_ams_college_type_mm_b4 := __common__(map(pk_ams_college_type = 0 => 0.0902241853,
										 pk_ams_college_type = 1 => 0.0636219319,
																	0.0370813397));

		pk_ams_income_level_code_mm_b4 := __common__(map(pk_ams_income_level_code = -1 => 0.0869392089,
											  pk_ams_income_level_code = 0  => 0.1753246753,
											  pk_ams_income_level_code = 1  => 0.1323425336,
											  pk_ams_income_level_code = 2  => 0.0864220183,
											  pk_ams_income_level_code = 3  => 0.0843023256,
											  pk_ams_income_level_code = 4  => 0.078708059,
											  pk_ams_income_level_code = 5  => 0.070273285,
																			   0.0511330622));

		pk_yr_in_dob2_mm_b4 := __common__(map(pk_yr_in_dob2 = 19 => 0.1667480866,
								   pk_yr_in_dob2 = 20 => 0.1440677966,
								   pk_yr_in_dob2 = 21 => 0.1279887482,
								   pk_yr_in_dob2 = 22 => 0.1150918047,
								   pk_yr_in_dob2 = 23 => 0.1012624228,
								   pk_yr_in_dob2 = 25 => 0.0928683386,
								   pk_yr_in_dob2 = 29 => 0.0914122478,
								   pk_yr_in_dob2 = 35 => 0.0818928263,
								   pk_yr_in_dob2 = 38 => 0.0797602582,
								   pk_yr_in_dob2 = 41 => 0.0714948932,
								   pk_yr_in_dob2 = 42 => 0.0471063257,
								   pk_yr_in_dob2 = 43 => 0.0423497268,
								   pk_yr_in_dob2 = 44 => 0.0585987261,
								   pk_yr_in_dob2 = 45 => 0.0501792115,
								   pk_yr_in_dob2 = 47 => 0.0378279439,
								   pk_yr_in_dob2 = 49 => 0.0313441832,
								   pk_yr_in_dob2 = 57 => 0.034034857,
								   pk_yr_in_dob2 = 60 => 0.0346211741,
								   pk_yr_in_dob2 = 63 => 0.0174788136,
														 0.0181594337));

		pk_ams_age_mm_b4 := __common__(map(pk_ams_age = -1 => 0.0846510843,
								pk_ams_age = 21 => 0.1437291898,
								pk_ams_age = 22 => 0.1345840131,
								pk_ams_age = 23 => 0.131501472,
								pk_ams_age = 24 => 0.0758293839,
								pk_ams_age = 25 => 0.0822454308,
								pk_ams_age = 29 => 0.0697786333,
												   0.0586206897));

		pk_inferred_age_mm_b4 := __common__(map(pk_inferred_age = -1 => 0.1016483516,
									 pk_inferred_age = 18 => 0.15035922,
									 pk_inferred_age = 19 => 0.143454039,
									 pk_inferred_age = 20 => 0.1352615171,
									 pk_inferred_age = 21 => 0.1138228487,
									 pk_inferred_age = 22 => 0.0946480359,
									 pk_inferred_age = 24 => 0.0966719493,
									 pk_inferred_age = 34 => 0.0887048493,
									 pk_inferred_age = 37 => 0.0814634146,
									 pk_inferred_age = 41 => 0.0642907058,
									 pk_inferred_age = 42 => 0.0408450704,
									 pk_inferred_age = 43 => 0.0486842105,
									 pk_inferred_age = 44 => 0.0470588235,
									 pk_inferred_age = 46 => 0.0350318471,
									 pk_inferred_age = 48 => 0.0299065421,
									 pk_inferred_age = 52 => 0.034699273,
									 pk_inferred_age = 56 => 0.0328368314,
									 pk_inferred_age = 59 => 0.033567948,
									 pk_inferred_age = 63 => 0.017124831,
															 0.0188747731));

		pk_yr_reported_dob2_mm_b4 := __common__(map(pk_yr_reported_dob2 = -1 => 0.1268819368,
										 pk_yr_reported_dob2 = 19 => 0.1194581281,
										 pk_yr_reported_dob2 = 21 => 0.10868635,
										 pk_yr_reported_dob2 = 22 => 0.0903716216,
										 pk_yr_reported_dob2 = 23 => 0.0704663212,
										 pk_yr_reported_dob2 = 32 => 0.0814171123,
										 pk_yr_reported_dob2 = 35 => 0.079089275,
										 pk_yr_reported_dob2 = 39 => 0.0776818742,
										 pk_yr_reported_dob2 = 42 => 0.0624365482,
										 pk_yr_reported_dob2 = 43 => 0.042042042,
										 pk_yr_reported_dob2 = 44 => 0.0518207283,
										 pk_yr_reported_dob2 = 45 => 0.0520156047,
										 pk_yr_reported_dob2 = 46 => 0.0444145357,
										 pk_yr_reported_dob2 = 49 => 0.0300653595,
										 pk_yr_reported_dob2 = 57 => 0.0343111111,
										 pk_yr_reported_dob2 = 60 => 0.0339989207,
										 pk_yr_reported_dob2 = 63 => 0.0166858458,
																	 0.0185060565));

		pk_avm_hit_level_mm_b4 := __common__(map(pk_avm_hit_level = -1 => 0.1071228267,
									  pk_avm_hit_level = 0  => 0.0802271554,
									  pk_avm_hit_level = 1  => 0.0916495902,
															   0.0914803179));

		pk_avm_auto_diff2_lvl_mm_b4 := __common__(map(pk_avm_auto_diff2_lvl = -2 => 0.083007941,
										   pk_avm_auto_diff2_lvl = -1 => 0.0944019211,
										   pk_avm_auto_diff2_lvl = 0  => 0.0941660353,
										   pk_avm_auto_diff2_lvl = 1  => 0.0901556157,
																		 0.0919753086));

		pk_avm_auto_diff4_lvl_mm_b4 := __common__(map(pk_avm_auto_diff4_lvl = -1 => 0.0855037912,
										   pk_avm_auto_diff4_lvl = 0  => 0.0873378744,
																		 0.1029411765));

		pk_add2_avm_auto_diff2_lvl_mm_b4 := __common__(map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0841192965,
												pk_add2_avm_auto_diff2_lvl = -2 => 0.131059246,
												pk_add2_avm_auto_diff2_lvl = -1 => 0.1156716418,
												pk_add2_avm_auto_diff2_lvl = 0  => 0.1049868766,
																				   0.0899611531));

		pk2_add1_avm_mkt_mm_b4 := __common__(map(pk2_add1_avm_mkt = 0 => 0.1453224342,
									  pk2_add1_avm_mkt = 1 => 0.0851458886,
									  pk2_add1_avm_mkt = 2 => 0.1067784257,
									  pk2_add1_avm_mkt = 3 => 0.0817230769,
															  0.066));

		pk2_add1_avm_pi_mm_b4 := __common__(map(pk2_add1_avm_pi = 0 => 0.1326530612,
									 pk2_add1_avm_pi = 1 => 0.123923445,
									 pk2_add1_avm_pi = 2 => 0.0839038504,
															0.0954896384));

		pk2_add1_avm_hed_mm_b4 := __common__(map(pk2_add1_avm_hed = 0 => 0.1928104575,
									  pk2_add1_avm_hed = 1 => 0.1680814941,
									  pk2_add1_avm_hed = 2 => 0.1232604374,
									  pk2_add1_avm_hed = 3 => 0.0842421272,
									  pk2_add1_avm_hed = 4 => 0.0961810467,
									  pk2_add1_avm_hed = 5 => 0.086829763,
															  0.0541103018));

		pk2_add1_avm_auto2_mm_b4 := __common__(map(pk2_add1_avm_auto2 = 0 => 0.1648351648,
										pk2_add1_avm_auto2 = 1 => 0.1831395349,
										pk2_add1_avm_auto2 = 2 => 0.1488439306,
										pk2_add1_avm_auto2 = 3 => 0.1286231884,
										pk2_add1_avm_auto2 = 4 => 0.083007941,
										pk2_add1_avm_auto2 = 5 => 0.1021702838,
										pk2_add1_avm_auto2 = 6 => 0.0876327992,
																  0.0503842869));

		pk2_add1_avm_auto4_mm_b4 := __common__(map(pk2_add1_avm_auto4 = 0 => 0.1875,
										pk2_add1_avm_auto4 = 1 => 0.1551724138,
										pk2_add1_avm_auto4 = 2 => 0.1208459215,
										pk2_add1_avm_auto4 = 3 => 0.0860746282,
										pk2_add1_avm_auto4 = 4 => 0.0936831876,
										pk2_add1_avm_auto4 = 5 => 0.0739420935,
																  0.0369230769));

		pk2_add1_avm_med_mm_b4 := __common__(map(pk2_add1_avm_med = 0 => 0.2602739726,
									  pk2_add1_avm_med = 1 => 0.1489361702,
									  pk2_add1_avm_med = 2 => 0.1445945946,
									  pk2_add1_avm_med = 3 => 0.1259500543,
									  pk2_add1_avm_med = 4 => 0.1108537903,
									  pk2_add1_avm_med = 5 => 0.0961485367,
									  pk2_add1_avm_med = 6 => 0.0880989181,
															  0.0620185449));

		pk2_add1_avm_to_med_ratio_mm_b4 := __common__(map(pk2_add1_avm_to_med_ratio = 0 => 0.0844391091,
											   pk2_add1_avm_to_med_ratio = 1 => 0.0990303466,
											   pk2_add1_avm_to_med_ratio = 2 => 0.0908835115,
											   pk2_add1_avm_to_med_ratio = 3 => 0.0783685672,
											   pk2_add1_avm_to_med_ratio = 4 => 0.0880766926,
																				0.0648078372));

		pk2_add2_avm_mkt_mm_b4 := __common__(map(pk2_add2_avm_mkt = 0 => 0.1779935275,
									  pk2_add2_avm_mkt = 1 => 0.1113801453,
									  pk2_add2_avm_mkt = 2 => 0.0853906925,
									  pk2_add2_avm_mkt = 3 => 0.0947556615,
															  0.0895522388));

		pk2_add2_avm_pi_mm_b4 := __common__(map(pk2_add2_avm_pi = 0 => 0.125,
									 pk2_add2_avm_pi = 1 => 0.1397205589,
									 pk2_add2_avm_pi = 2 => 0.0855233782,
									 pk2_add2_avm_pi = 3 => 0.0928529004,
															0.0670289855));

		pk2_add2_avm_hed_mm_b4 := __common__(map(pk2_add2_avm_hed = 0 => 0.2352941176,
									  pk2_add2_avm_hed = 1 => 0.1612244898,
									  pk2_add2_avm_hed = 2 => 0.1322645291,
									  pk2_add2_avm_hed = 3 => 0.0840323743,
									  pk2_add2_avm_hed = 4 => 0.1010260458,
									  pk2_add2_avm_hed = 5 => 0.0989563921,
															  0.0731707317));

		pk2_add2_avm_auto4_mm_b4 := __common__(map(pk2_add2_avm_auto4 = 0 => 0.1941176471,
										pk2_add2_avm_auto4 = 1 => 0.1535087719,
										pk2_add2_avm_auto4 = 2 => 0.1134564644,
										pk2_add2_avm_auto4 = 3 => 0.0850545642,
										pk2_add2_avm_auto4 = 4 => 0.1009292721,
																  0.0474683544));

		pk2_yr_add1_avm_rec_dt_mm_b4 := __common__(map(pk2_yr_add1_avm_recording_date = 0 => 0.1270285395,
											pk2_yr_add1_avm_recording_date = 1 => 0.1106899166,
											pk2_yr_add1_avm_recording_date = 2 => 0.0840538209,
											pk2_yr_add1_avm_recording_date = 3 => 0.0994032892,
																				  0.0722733246));

		pk2_yr_add1_avm_assess_year_mm_b4 := __common__(map(pk2_yr_add1_avm_assess_year = 0 => 0.0841125551,
												 pk2_yr_add1_avm_assess_year = 1 => 0.0928371734,
																					0.0896128724));

		pk2_yr_add2_avm_assess_year_mm_b4 := __common__(map(pk2_yr_add2_avm_assess_year = 0 => 0.0842826112,
												 pk2_yr_add2_avm_assess_year = 1 => 0.1106138107,
																					0.0960057317));

		pk_dist_a1toa2_mm_b4 := __common__(map(pk_dist_a1toa2_2 = 0 => 0.0694578592,
									pk_dist_a1toa2_2 = 1 => 0.0840635423,
									pk_dist_a1toa2_2 = 2 => 0.0977619113,
									pk_dist_a1toa2_2 = 3 => 0.1216063348,
															0.1027237775));

		pk_dist_a1toa3_mm_b4 := __common__(map(pk_dist_a1toa3_2 = 0 => 0.0594090996,
									pk_dist_a1toa3_2 = 1 => 0.0741700024,
									pk_dist_a1toa3_2 = 2 => 0.0792251905,
									pk_dist_a1toa3_2 = 3 => 0.0950179764,
									pk_dist_a1toa3_2 = 4 => 0.0975308642,
									pk_dist_a1toa3_2 = 5 => 0.1227678571,
															0.1047566408));

		pk_rc_disthphoneaddr_mm_b4 := __common__(map(pk_rc_disthphoneaddr_2 = 0 => 0.0599587912,
										  pk_rc_disthphoneaddr_2 = 1 => 0.0637885864,
										  pk_rc_disthphoneaddr_2 = 2 => 0.058076225,
										  pk_rc_disthphoneaddr_2 = 3 => 0.0858806405,
																		0.1205509341));

		pk_out_st_division_lvl_mm_b4 := __common__(map(pk_out_st_division_lvl = -1 => 0.0559910414,
											pk_out_st_division_lvl = 0  => 0.0602739726,
											pk_out_st_division_lvl = 1  => 0.0770268245,
											pk_out_st_division_lvl = 2  => 0.0946873871,
											pk_out_st_division_lvl = 3  => 0.0807040137,
											pk_out_st_division_lvl = 4  => 0.0898765106,
											pk_out_st_division_lvl = 5  => 0.091099751,
											pk_out_st_division_lvl = 6  => 0.1003911343,
											pk_out_st_division_lvl = 7  => 0.1075794621,
																		   0.1031007752));

		pk_wealth_index_mm_b4 := __common__(map(pk_wealth_index_2 = 0 => 0.0868106711,
									 pk_wealth_index_2 = 1 => 0.1016159105,
									 pk_wealth_index_2 = 2 => 0.0908530477,
									 pk_wealth_index_2 = 3 => 0.0737097753,
															  0.0467091295));

		pk_impulse_count_mm_b4 := __common__(if(pk_impulse_count_2 = 0, 0.0864242249, NULL));

		pk_attr_num_nonderogs90_b_mm_b4 := __common__(map(pk_attr_num_nonderogs90_b = 0  => 0.1476115897,
											   pk_attr_num_nonderogs90_b = 1  => 0.1371325862,
											   pk_attr_num_nonderogs90_b = 2  => 0.0825600761,
											   pk_attr_num_nonderogs90_b = 3  => 0.0406342914,
											   pk_attr_num_nonderogs90_b = 4  => 0.0209424084,
											   pk_attr_num_nonderogs90_b = 10 => 0.0852842809,
											   pk_attr_num_nonderogs90_b = 11 => 0.0918125596,
											   pk_attr_num_nonderogs90_b = 12 => 0.0503274733,
											   pk_attr_num_nonderogs90_b = 13 => 0.0359298649,
																				 0.0172413793));

		pk_ssns_per_addr2_mm_b4 := __common__(map(pk_ssns_per_addr2 = -101 => 0.1424116424,
									   pk_ssns_per_addr2 = -2   => 0.0968586387,
									   pk_ssns_per_addr2 = -1   => 0.0856412441,
									   pk_ssns_per_addr2 = 0    => 0.0452992989,
									   pk_ssns_per_addr2 = 1    => 0.0510056315,
									   pk_ssns_per_addr2 = 2    => 0.0551421738,
									   pk_ssns_per_addr2 = 3    => 0.0677075733,
									   pk_ssns_per_addr2 = 4    => 0.0746243458,
									   pk_ssns_per_addr2 = 5    => 0.0775651466,
									   pk_ssns_per_addr2 = 6    => 0.0915245737,
									   pk_ssns_per_addr2 = 7    => 0.0979678496,
									   pk_ssns_per_addr2 = 8    => 0.1131239936,
									   pk_ssns_per_addr2 = 9    => 0.1225,
									   pk_ssns_per_addr2 = 10   => 0.1449814126,
									   pk_ssns_per_addr2 = 11   => 0.1530153015,
									   pk_ssns_per_addr2 = 12   => 0.1661466459,
									   pk_ssns_per_addr2 = 100  => 0.1239669421,
									   pk_ssns_per_addr2 = 101  => 0.1052631579,
									   pk_ssns_per_addr2 = 102  => 0.1466666667,
																   0.0625));

		pk_yr_prop1_prev_purch_dt2_mm_b4 := __common__(map(pk_yr_prop1_prev_purchase_date2 = -1 => 0.0865796436,
												pk_yr_prop1_prev_purchase_date2 = 0  => 0.1333333333,
												pk_yr_prop1_prev_purchase_date2 = 1  => 0.0612244898,
												pk_yr_prop1_prev_purchase_date2 = 2  => 0.0666666667,
												pk_yr_prop1_prev_purchase_date2 = 3  => 0.0517241379,
												pk_yr_prop1_prev_purchase_date2 = 4  => 0.08,
												pk_yr_prop1_prev_purchase_date2 = 5  => 0.0588235294,
												pk_yr_prop1_prev_purchase_date2 = 6  => 0.0795454545,
																						0.0483870968));

		pk_yr_criminal_last_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_criminal_last_date2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_criminal_last_date2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_criminal_last_date2_mm_b3,
																		 pk_yr_criminal_last_date2_mm_b4));

		pk_prop_own_assess_tot2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_prop_own_assess_tot2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_prop_own_assess_tot2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_prop_own_assess_tot2_mm_b3,
																	   pk_prop_own_assess_tot2_mm_b4));

		pk_yr_add1_date_first_seen2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add1_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add1_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add1_date_first_seen2_mm_b3,
																		   pk_yr_add1_date_first_seen2_mm_b4));

		pk2_add2_avm_mkt_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_mkt_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add2_avm_mkt_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add2_avm_mkt_mm_b3,
																pk2_add2_avm_mkt_mm_b4));

		pk_attr_addrs_last90_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last90_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_attr_addrs_last90_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_attr_addrs_last90_mm_b3,
																	pk_attr_addrs_last90_mm_b4));

		pk_nameperssn_count_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_nameperssn_count_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_nameperssn_count_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_nameperssn_count_mm_b3,
																   pk_nameperssn_count_mm_b4));

		pk_yr_add2_mortgage_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add2_mortgage_date2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_add2_mortgage_date2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_add2_mortgage_date2_mm_b3,
																		 pk_yr_add2_mortgage_date2_mm_b4));

		pk_adls_per_phone_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_adls_per_phone_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_adls_per_phone_mm_b2,
									pk_segment_2 = '2 Renter' => pk_adls_per_phone_mm_b3,
																 pk_adls_per_phone_mm_b4));

		pk_ssns_per_addr2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssns_per_addr2_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_ssns_per_addr2_mm_b2,
									pk_segment_2 = '2 Renter' => pk_ssns_per_addr2_mm_b3,
																 pk_ssns_per_addr2_mm_b4));

		pk_property_owned_total_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_property_owned_total_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_property_owned_total_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_property_owned_total_mm_b3,
																	   pk_property_owned_total_mm_b4));

		pk_ams_class_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ams_class_level_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_ams_class_level_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_ams_class_level_mm_b3,
																  pk_ams_class_level_mm_b4));

		pk_attr_addrs_last12_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last12_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_attr_addrs_last12_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_attr_addrs_last12_mm_b3,
																	pk_attr_addrs_last12_mm_b4));

		pk_add2_land_use_risk_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_land_use_risk_level_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_add2_land_use_risk_level_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_add2_land_use_risk_level_mm_b3,
																		   pk_add2_land_use_risk_level_mm_b4));

		pk_yr_add2_date_first_seen2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add2_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add2_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add2_date_first_seen2_mm_b3,
																		   pk_yr_add2_date_first_seen2_mm_b4));

		pk_adlperssn_count_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_adlperssn_count_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_adlperssn_count_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_adlperssn_count_mm_b3,
																  pk_adlperssn_count_mm_b4));

		pk2_add2_avm_hed_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_hed_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add2_avm_hed_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add2_avm_hed_mm_b3,
																pk2_add2_avm_hed_mm_b4));

		pk_avm_auto_diff4_lvl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_avm_auto_diff4_lvl_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_avm_auto_diff4_lvl_mm_b2,
										pk_segment_2 = '2 Renter' => pk_avm_auto_diff4_lvl_mm_b3,
																	 pk_avm_auto_diff4_lvl_mm_b4));

		pk_ams_college_type_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ams_college_type_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_ams_college_type_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_ams_college_type_mm_b3,
																   pk_ams_college_type_mm_b4));

		pk_w_count_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_w_count_mm_b1,
							 pk_segment_2 = '1 Owner ' => pk_w_count_mm_b2,
							 pk_segment_2 = '2 Renter' => pk_w_count_mm_b3,
														  pk_w_count_mm_b4));

		pk_yr_add3_date_first_seen2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add3_date_first_seen2_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_yr_add3_date_first_seen2_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_yr_add3_date_first_seen2_mm_b3,
																		   pk_yr_add3_date_first_seen2_mm_b4));

		pk_add2_own_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_own_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_add2_own_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_add2_own_level_mm_b3,
																 pk_add2_own_level_mm_b4));

		pk_add2_lres_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add2_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add2_lres_mm_b3,
															pk_add2_lres_mm_b4));

		pk_addrs_sourced_lvl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_addrs_sourced_lvl_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_addrs_sourced_lvl_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_addrs_sourced_lvl_mm_b3,
																	pk_addrs_sourced_lvl_mm_b4));

		pk_add_lres_month_avg2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add_lres_month_avg2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_add_lres_month_avg2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_add_lres_month_avg2_mm_b3,
																	  pk_add_lres_month_avg2_mm_b4));

		pk_rc_disthphoneaddr_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_rc_disthphoneaddr_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_rc_disthphoneaddr_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_rc_disthphoneaddr_mm_b3,
																	pk_rc_disthphoneaddr_mm_b4));

		pk_add1_lres_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add1_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add1_lres_mm_b3,
															pk_add1_lres_mm_b4));

		pk_attr_total_number_derogs_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_attr_total_number_derogs_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk_attr_total_number_derogs_mm_b2,
											  pk_segment_2 = '2 Renter' => pk_attr_total_number_derogs_mm_b3,
																		   pk_attr_total_number_derogs_mm_b4));

		pk_addrs_per_adl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_addrs_per_adl_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_addrs_per_adl_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_addrs_per_adl_mm_b3,
																pk_addrs_per_adl_mm_b4));

		pk_naprop_level2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_naprop_level2_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_naprop_level2_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_naprop_level2_mm_b3,
																pk_naprop_level2_mm_b4));

		pk2_add1_avm_mkt_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_mkt_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_mkt_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_mkt_mm_b3,
																pk2_add1_avm_mkt_mm_b4));

		pk_yr_reported_dob2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_reported_dob2_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_yr_reported_dob2_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_yr_reported_dob2_mm_b3,
																   pk_yr_reported_dob2_mm_b4));

		pk_prop1_sale_price2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_prop1_sale_price2_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_prop1_sale_price2_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_prop1_sale_price2_mm_b3,
																	pk_prop1_sale_price2_mm_b4));

		pk2_add1_avm_auto4_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto4_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto4_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add1_avm_auto4_mm_b3,
																  pk2_add1_avm_auto4_mm_b4));

		pk_ssns_per_adl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_ssns_per_adl_mm_b3,
															   pk_ssns_per_adl_mm_b4));

		pk_yr_adl_w_last_seen2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_w_last_seen2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_adl_w_last_seen2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_adl_w_last_seen2_mm_b3,
																	  pk_yr_adl_w_last_seen2_mm_b4));

		pk_add2_no_of_baths_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_no_of_baths_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_add2_no_of_baths_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_add2_no_of_baths_mm_b3,
																   pk_add2_no_of_baths_mm_b4));

		pk_ams_income_level_code_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ams_income_level_code_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_ams_income_level_code_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_ams_income_level_code_mm_b3,
																		pk_ams_income_level_code_mm_b4));

		pk_yr_ln_unrel_ot_f_sn2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_ln_unrel_ot_f_sn2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_ln_unrel_ot_f_sn2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_ln_unrel_ot_f_sn2_mm_b3,
																	   pk_yr_ln_unrel_ot_f_sn2_mm_b4));

		pk_add1_building_area2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_building_area2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_add1_building_area2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_add1_building_area2_mm_b3,
																	  pk_add1_building_area2_mm_b4));

		pk_pr_count_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_pr_count_mm_b1,
							  pk_segment_2 = '1 Owner ' => pk_pr_count_mm_b2,
							  pk_segment_2 = '2 Renter' => pk_pr_count_mm_b3,
														   pk_pr_count_mm_b4));

		pk_avm_auto_diff2_lvl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_avm_auto_diff2_lvl_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_avm_auto_diff2_lvl_mm_b2,
										pk_segment_2 = '2 Renter' => pk_avm_auto_diff2_lvl_mm_b3,
																	 pk_avm_auto_diff2_lvl_mm_b4));

		pk_inferred_age_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_inferred_age_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_inferred_age_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_inferred_age_mm_b3,
															   pk_inferred_age_mm_b4));

		pk2_yr_add1_avm_assess_year_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_yr_add1_avm_assess_year_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk2_yr_add1_avm_assess_year_mm_b2,
											  pk_segment_2 = '2 Renter' => pk2_yr_add1_avm_assess_year_mm_b3,
																		   pk2_yr_add1_avm_assess_year_mm_b4));

		pk_add1_no_of_baths_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_no_of_baths_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_add1_no_of_baths_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_add1_no_of_baths_mm_b3,
																   pk_add1_no_of_baths_mm_b4));

		pk_out_st_division_lvl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_out_st_division_lvl_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_out_st_division_lvl_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_out_st_division_lvl_mm_b3,
																	  pk_out_st_division_lvl_mm_b4));

		pk_yr_rc_ssnhighissue2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_rc_ssnhighissue2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_rc_ssnhighissue2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_rc_ssnhighissue2_mm_b3,
																	  pk_yr_rc_ssnhighissue2_mm_b4));

		pk_add2_building_area2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_building_area2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_add2_building_area2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_add2_building_area2_mm_b3,
																	  pk_add2_building_area2_mm_b4));

		pk_phones_per_adl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_phones_per_adl_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_phones_per_adl_mm_b2,
									pk_segment_2 = '2 Renter' => pk_phones_per_adl_mm_b3,
																 pk_phones_per_adl_mm_b4));

		pk2_add1_avm_auto2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto2_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto2_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add1_avm_auto2_mm_b3,
																  pk2_add1_avm_auto2_mm_b4));

		pk_addrs_10yr_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_addrs_10yr_mm_b1,
								pk_segment_2 = '1 Owner ' => pk_addrs_10yr_mm_b2,
								pk_segment_2 = '2 Renter' => pk_addrs_10yr_mm_b3,
															 pk_addrs_10yr_mm_b4));

		pk_ams_4yr_college_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ams_4yr_college_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_ams_4yr_college_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_ams_4yr_college_mm_b3,
																  pk_ams_4yr_college_mm_b4));

		pk_ssns_per_addr_c6_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssns_per_addr_c6_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_ssns_per_addr_c6_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_ssns_per_addr_c6_mm_b3,
																   pk_ssns_per_addr_c6_mm_b4));

		pk_yr_ln_unrel_lt_f_sn2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_ln_unrel_lt_f_sn2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_ln_unrel_lt_f_sn2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_ln_unrel_lt_f_sn2_mm_b3,
																	   pk_yr_ln_unrel_lt_f_sn2_mm_b4));

		pk2_add1_avm_hed_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_hed_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_hed_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_hed_mm_b3,
																pk2_add1_avm_hed_mm_b4));

		pk2_yr_add1_avm_rec_dt_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_yr_add1_avm_rec_dt_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk2_yr_add1_avm_rec_dt_mm_b2,
										 pk_segment_2 = '2 Renter' => pk2_yr_add1_avm_rec_dt_mm_b3,
																	  pk2_yr_add1_avm_rec_dt_mm_b4));

		pk_add1_mortgage_risk_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add1_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add1_mortgage_risk_mm_b3,
																	 pk_add1_mortgage_risk_mm_b4));

		pk_pl_sourced_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_pl_sourced_level_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_pl_sourced_level_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_pl_sourced_level_mm_b3,
																   pk_pl_sourced_level_mm_b4));

		pk_add2_assessed_amount2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add2_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add2_assessed_amount2_mm_b3,
																		pk_add2_assessed_amount2_mm_b4));

		pk_prof_lic_cat_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_prof_lic_cat_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_prof_lic_cat_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_prof_lic_cat_mm_b3,
															   pk_prof_lic_cat_mm_b4));

		pk_dist_a1toa3_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_dist_a1toa3_mm_b1,
								 pk_segment_2 = '1 Owner ' => pk_dist_a1toa3_mm_b2,
								 pk_segment_2 = '2 Renter' => pk_dist_a1toa3_mm_b3,
															  pk_dist_a1toa3_mm_b4));

		pk_eviction_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_eviction_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_eviction_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_eviction_level_mm_b3,
																 pk_eviction_level_mm_b4));

		pk_attr_num_nonderogs90_b_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_attr_num_nonderogs90_b_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_attr_num_nonderogs90_b_mm_b2,
											pk_segment_2 = '2 Renter' => pk_attr_num_nonderogs90_b_mm_b3,
																		 pk_attr_num_nonderogs90_b_mm_b4));

		pk_add3_own_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add3_own_level_mm_b1,
									pk_segment_2 = '1 Owner ' => pk_add3_own_level_mm_b2,
									pk_segment_2 = '2 Renter' => pk_add3_own_level_mm_b3,
																 pk_add3_own_level_mm_b4));

		pk_ssns_per_adl_c6_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_c6_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_c6_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_ssns_per_adl_c6_mm_b3,
																  pk_ssns_per_adl_c6_mm_b4));

		pk_attr_addrs_last24_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last24_mm_b1,
									   pk_segment_2 = '1 Owner ' => pk_attr_addrs_last24_mm_b2,
									   pk_segment_2 = '2 Renter' => pk_attr_addrs_last24_mm_b3,
																	pk_attr_addrs_last24_mm_b4));

		pk_add2_avm_auto_diff2_lvl_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_avm_auto_diff2_lvl_mm_b1,
											 pk_segment_2 = '1 Owner ' => pk_add2_avm_auto_diff2_lvl_mm_b2,
											 pk_segment_2 = '2 Renter' => pk_add2_avm_auto_diff2_lvl_mm_b3,
																		  pk_add2_avm_auto_diff2_lvl_mm_b4));

		pk_add3_mortgage_risk_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add3_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add3_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add3_mortgage_risk_mm_b3,
																	 pk_add3_mortgage_risk_mm_b4));

		pk2_add1_avm_med_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_med_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk2_add1_avm_med_mm_b2,
								   pk_segment_2 = '2 Renter' => pk2_add1_avm_med_mm_b3,
																pk2_add1_avm_med_mm_b4));

		pk_impulse_count_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_impulse_count_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_impulse_count_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_impulse_count_mm_b3,
																pk_impulse_count_mm_b4));

		pk_yr_add2_mortgage_due_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add2_mortgage_due_date2_mm_b1,
												pk_segment_2 = '1 Owner ' => pk_yr_add2_mortgage_due_date2_mm_b2,
												pk_segment_2 = '2 Renter' => pk_yr_add2_mortgage_due_date2_mm_b3,
																			 pk_yr_add2_mortgage_due_date2_mm_b4));

		pk_yr_add1_mortgage_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add1_mortgage_date2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_add1_mortgage_date2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_add1_mortgage_date2_mm_b3,
																		 pk_yr_add1_mortgage_date2_mm_b4));

		pk_yr_in_dob2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_in_dob2_mm_b1,
								pk_segment_2 = '1 Owner ' => pk_yr_in_dob2_mm_b2,
								pk_segment_2 = '2 Renter' => pk_yr_in_dob2_mm_b3,
															 pk_yr_in_dob2_mm_b4));

		pk2_yr_add2_avm_assess_year_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_yr_add2_avm_assess_year_mm_b1,
											  pk_segment_2 = '1 Owner ' => pk2_yr_add2_avm_assess_year_mm_b2,
											  pk_segment_2 = '2 Renter' => pk2_yr_add2_avm_assess_year_mm_b3,
																		   pk2_yr_add2_avm_assess_year_mm_b4));

		pk_avm_hit_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_avm_hit_level_mm_b1,
								   pk_segment_2 = '1 Owner ' => pk_avm_hit_level_mm_b2,
								   pk_segment_2 = '2 Renter' => pk_avm_hit_level_mm_b3,
																pk_avm_hit_level_mm_b4));

		pk_bk_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_bk_level_mm_b1,
							  pk_segment_2 = '1 Owner ' => pk_bk_level_mm_b2,
							  pk_segment_2 = '2 Renter' => pk_bk_level_mm_b3,
														   pk_bk_level_mm_b4));

		pk_wealth_index_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_wealth_index_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk_wealth_index_mm_b2,
								  pk_segment_2 = '2 Renter' => pk_wealth_index_mm_b3,
															   pk_wealth_index_mm_b4));

		pk_yr_ln_unrel_cj_f_sn2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_ln_unrel_cj_f_sn2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_ln_unrel_cj_f_sn2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_ln_unrel_cj_f_sn2_mm_b3,
																	   pk_yr_ln_unrel_cj_f_sn2_mm_b4));

		pk2_add2_avm_pi_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_pi_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk2_add2_avm_pi_mm_b2,
								  pk_segment_2 = '2 Renter' => pk2_add2_avm_pi_mm_b3,
															   pk2_add2_avm_pi_mm_b4));

		pk2_add1_avm_to_med_ratio_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_to_med_ratio_mm_b1,
											pk_segment_2 = '1 Owner ' => pk2_add1_avm_to_med_ratio_mm_b2,
											pk_segment_2 = '2 Renter' => pk2_add1_avm_to_med_ratio_mm_b3,
																		 pk2_add1_avm_to_med_ratio_mm_b4));

		pk_add1_assessed_amount2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add1_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add1_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add1_assessed_amount2_mm_b3,
																		pk_add1_assessed_amount2_mm_b4));

		pk_add3_lres_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add3_lres_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_add3_lres_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_add3_lres_mm_b3,
															pk_add3_lres_mm_b4));

		pk_lres_flag_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_lres_flag_level_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_lres_flag_level_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_lres_flag_level_mm_b3,
																  pk_lres_flag_level_mm_b4));

		pk_ams_age_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_ams_age_mm_b1,
							 pk_segment_2 = '1 Owner ' => pk_ams_age_mm_b2,
							 pk_segment_2 = '2 Renter' => pk_ams_age_mm_b3,
														  pk_ams_age_mm_b4));

		pk_estimated_income_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_estimated_income_mm_b1,
									  pk_segment_2 = '1 Owner ' => pk_estimated_income_mm_b2,
									  pk_segment_2 = '2 Renter' => pk_estimated_income_mm_b3,
																   pk_estimated_income_mm_b4));

		pk_yr_adl_w_first_seen2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_adl_w_first_seen2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_adl_w_first_seen2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_adl_w_first_seen2_mm_b3,
																	   pk_yr_adl_w_first_seen2_mm_b4));

		pk_add2_mortgage_risk_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add2_mortgage_risk_mm_b1,
										pk_segment_2 = '1 Owner ' => pk_add2_mortgage_risk_mm_b2,
										pk_segment_2 = '2 Renter' => pk_add2_mortgage_risk_mm_b3,
																	 pk_add2_mortgage_risk_mm_b4));

		pk_dist_a1toa2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_dist_a1toa2_mm_b1,
								 pk_segment_2 = '1 Owner ' => pk_dist_a1toa2_mm_b2,
								 pk_segment_2 = '2 Renter' => pk_dist_a1toa2_mm_b3,
															  pk_dist_a1toa2_mm_b4));

		pk2_add2_avm_auto4_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_auto4_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk2_add2_avm_auto4_mm_b2,
									 pk_segment_2 = '2 Renter' => pk2_add2_avm_auto4_mm_b3,
																  pk2_add2_avm_auto4_mm_b4));

		pk_yr_add1_purchase_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add1_purchase_date2_mm_b1,
											pk_segment_2 = '1 Owner ' => pk_yr_add1_purchase_date2_mm_b2,
											pk_segment_2 = '2 Renter' => pk_yr_add1_purchase_date2_mm_b3,
																		 pk_yr_add1_purchase_date2_mm_b4));

		pk_yr_prop1_prev_purch_dt2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_prop1_prev_purch_dt2_mm_b1,
											 pk_segment_2 = '1 Owner ' => pk_yr_prop1_prev_purch_dt2_mm_b2,
											 pk_segment_2 = '2 Renter' => pk_yr_prop1_prev_purch_dt2_mm_b3,
																		  pk_yr_prop1_prev_purch_dt2_mm_b4));

		pk_add3_assessed_amount2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_add3_assessed_amount2_mm_b1,
										   pk_segment_2 = '1 Owner ' => pk_add3_assessed_amount2_mm_b2,
										   pk_segment_2 = '2 Renter' => pk_add3_assessed_amount2_mm_b3,
																		pk_add3_assessed_amount2_mm_b4));

		pk_yr_add1_built_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_add1_built_date2_mm_b1,
										 pk_segment_2 = '1 Owner ' => pk_yr_add1_built_date2_mm_b2,
										 pk_segment_2 = '2 Renter' => pk_yr_add1_built_date2_mm_b3,
																	  pk_yr_add1_built_date2_mm_b4));

		pk_yr_felony_last_date2_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_felony_last_date2_mm_b1,
										  pk_segment_2 = '1 Owner ' => pk_yr_felony_last_date2_mm_b2,
										  pk_segment_2 = '2 Renter' => pk_yr_felony_last_date2_mm_b3,
																	   pk_yr_felony_last_date2_mm_b4));

		pk_addrs_5yr_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_addrs_5yr_mm_b1,
							   pk_segment_2 = '1 Owner ' => pk_addrs_5yr_mm_b2,
							   pk_segment_2 = '2 Renter' => pk_addrs_5yr_mm_b3,
															pk_addrs_5yr_mm_b4));

		pk_lien_type_level_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_lien_type_level_mm_b1,
									 pk_segment_2 = '1 Owner ' => pk_lien_type_level_mm_b2,
									 pk_segment_2 = '2 Renter' => pk_lien_type_level_mm_b3,
																  pk_lien_type_level_mm_b4));

		pk2_add1_avm_pi_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_pi_mm_b1,
								  pk_segment_2 = '1 Owner ' => pk2_add1_avm_pi_mm_b2,
								  pk_segment_2 = '2 Renter' => pk2_add1_avm_pi_mm_b3,
															   pk2_add1_avm_pi_mm_b4));

		pk_yr_liens_last_unrel_date3_mm := __common__(map(pk_segment_2 = '0 Derog ' => pk_yr_liens_last_unrel_date3_mm_b1,
											   pk_segment_2 = '1 Owner ' => pk_yr_liens_last_unrel_date3_mm_b2,
											   pk_segment_2 = '2 Renter' => pk_yr_liens_last_unrel_date3_mm_b3,
																			pk_yr_liens_last_unrel_date3_mm_b4));

		segment_mean :=  __common__(map(pk_segment_2 = '0 Derog ' => 0.1486,
							 pk_segment_2 = '1 Owner ' => 0.0397,
							 pk_segment_2 = '2 Renter' => 0.1384,
														  0.0864));

		pk_add_lres_month_avg2_mm_2 :=  __common__(if(pk_add_lres_month_avg2_mm = NULL, segment_mean, pk_add_lres_month_avg2_mm));

		pk_add1_address_score_mm_2 :=  __common__(if(pk_add1_address_score_mm = NULL, segment_mean, pk_add1_address_score_mm));

		pk_add1_assessed_amount2_mm_2 :=  __common__(if(pk_add1_assessed_amount2_mm = NULL, segment_mean, pk_add1_assessed_amount2_mm));

		pk_add1_building_area2_mm_2 :=  __common__(if(pk_add1_building_area2_mm = NULL, segment_mean, pk_add1_building_area2_mm));

		pk_add1_lres_mm_2 :=  __common__(if(pk_add1_lres_mm = NULL, segment_mean, pk_add1_lres_mm));

		pk_add1_mortgage_risk_mm_2 :=  __common__(if(pk_add1_mortgage_risk_mm = NULL, segment_mean, pk_add1_mortgage_risk_mm));

		pk_add1_no_of_baths_mm_2 :=  __common__(if(pk_add1_no_of_baths_mm = NULL, segment_mean, pk_add1_no_of_baths_mm));

		pk_add2_address_score_mm_2 :=  __common__(if(pk_add2_address_score_mm = NULL, segment_mean, pk_add2_address_score_mm));

		pk_add2_assessed_amount2_mm_2 :=  __common__(if(pk_add2_assessed_amount2_mm = NULL, segment_mean, pk_add2_assessed_amount2_mm));

		pk_add2_avm_auto_diff2_lvl_mm_2 :=  __common__(if(pk_add2_avm_auto_diff2_lvl_mm = NULL, segment_mean, pk_add2_avm_auto_diff2_lvl_mm));

		pk_add2_building_area2_mm_2 :=  __common__(if(pk_add2_building_area2_mm = NULL, segment_mean, pk_add2_building_area2_mm));

		pk_add2_em_ver_lvl_mm_2 :=  __common__(if(pk_add2_em_ver_lvl_mm = NULL, segment_mean, pk_add2_em_ver_lvl_mm));

		pk_add2_land_use_risk_level_mm_2 :=  __common__(if(pk_add2_land_use_risk_level_mm = NULL, segment_mean, pk_add2_land_use_risk_level_mm));

		pk_add2_lres_mm_2 :=  __common__(if(pk_add2_lres_mm = NULL, segment_mean, pk_add2_lres_mm));

		pk_add2_mortgage_risk_mm_2 :=  __common__(if(pk_add2_mortgage_risk_mm = NULL, segment_mean, pk_add2_mortgage_risk_mm));

		pk_add2_no_of_baths_mm_2 :=  __common__(if(pk_add2_no_of_baths_mm = NULL, segment_mean, pk_add2_no_of_baths_mm));

		pk_add2_own_level_mm_2 :=  __common__(if(pk_add2_own_level_mm = NULL, segment_mean, pk_add2_own_level_mm));

		pk_add2_pos_secondary_sources_mm_2 :=  __common__(if(pk_add2_pos_secondary_sources_mm = NULL, segment_mean, pk_add2_pos_secondary_sources_mm));

		pk_add2_pos_sources_mm_2 :=  __common__(if(pk_add2_pos_sources_mm = NULL, segment_mean, pk_add2_pos_sources_mm));

		pk_add3_assessed_amount2_mm_2 :=  __common__(if(pk_add3_assessed_amount2_mm = NULL, segment_mean, pk_add3_assessed_amount2_mm));

		pk_add3_lres_mm_2 :=  __common__(if(pk_add3_lres_mm = NULL, segment_mean, pk_add3_lres_mm));

		pk_add3_mortgage_risk_mm_2 :=  __common__(if(pk_add3_mortgage_risk_mm = NULL, segment_mean, pk_add3_mortgage_risk_mm));

		pk_add3_own_level_mm_2 :=  __common__(if(pk_add3_own_level_mm = NULL, segment_mean, pk_add3_own_level_mm));

		pk_addrs_10yr_mm_2 :=  __common__(if(pk_addrs_10yr_mm = NULL, segment_mean, pk_addrs_10yr_mm));

		pk_addrs_5yr_mm_2 :=  __common__(if(pk_addrs_5yr_mm = NULL, segment_mean, pk_addrs_5yr_mm));

		pk_addrs_per_adl_mm_2 :=  __common__(if(pk_addrs_per_adl_mm = NULL, segment_mean, pk_addrs_per_adl_mm));

		pk_addrs_sourced_lvl_mm_2 :=  __common__(if(pk_addrs_sourced_lvl_mm = NULL, segment_mean, pk_addrs_sourced_lvl_mm));

		pk_adl_score_mm_2 :=  __common__(if(pk_adl_score_mm = NULL, segment_mean, pk_adl_score_mm));

		pk_adlperssn_count_mm_2 :=  __common__(if(pk_adlperssn_count_mm = NULL, segment_mean, pk_adlperssn_count_mm));

		pk_adls_per_phone_mm_2 :=  __common__(if(pk_adls_per_phone_mm = NULL, segment_mean, pk_adls_per_phone_mm));

		pk_ams_4yr_college_mm_2 :=  __common__(if(pk_ams_4yr_college_mm = NULL, segment_mean, pk_ams_4yr_college_mm));

		pk_ams_age_mm_2 :=  __common__(if(pk_ams_age_mm = NULL, segment_mean, pk_ams_age_mm));

		pk_ams_class_level_mm_2 :=  __common__(if(pk_ams_class_level_mm = NULL, segment_mean, pk_ams_class_level_mm));

		pk_ams_college_type_mm_2 :=  __common__(if(pk_ams_college_type_mm = NULL, segment_mean, pk_ams_college_type_mm));

		pk_ams_income_level_code_mm_2 :=  __common__(if(pk_ams_income_level_code_mm = NULL, segment_mean, pk_ams_income_level_code_mm));

		pk_attr_addrs_last12_mm_2 :=  __common__(if(pk_attr_addrs_last12_mm = NULL, segment_mean, pk_attr_addrs_last12_mm));

		pk_attr_addrs_last24_mm_2 :=  __common__(if(pk_attr_addrs_last24_mm = NULL, segment_mean, pk_attr_addrs_last24_mm));

		pk_attr_addrs_last90_mm_2 :=  __common__(if(pk_attr_addrs_last90_mm = NULL, segment_mean, pk_attr_addrs_last90_mm));

		pk_attr_num_nonderogs90_b_mm_2 :=  __common__(if(pk_attr_num_nonderogs90_b_mm = NULL, segment_mean, pk_attr_num_nonderogs90_b_mm));

		pk_attr_total_number_derogs_mm_2 :=  __common__(if(pk_attr_total_number_derogs_mm = NULL, segment_mean, pk_attr_total_number_derogs_mm));

		pk_avm_auto_diff2_lvl_mm_2 :=  __common__(if(pk_avm_auto_diff2_lvl_mm = NULL, segment_mean, pk_avm_auto_diff2_lvl_mm));

		pk_avm_auto_diff4_lvl_mm_2 :=  __common__(if(pk_avm_auto_diff4_lvl_mm = NULL, segment_mean, pk_avm_auto_diff4_lvl_mm));

		pk_avm_hit_level_mm_2 :=  __common__(if(pk_avm_hit_level_mm = NULL, segment_mean, pk_avm_hit_level_mm));

		pk_bk_level_mm_2 :=  __common__(if(pk_bk_level_mm = NULL, segment_mean, pk_bk_level_mm));

		pk_combo_addrcount_nb_mm_2 :=  __common__(if(pk_combo_addrcount_nb_mm = NULL, segment_mean, pk_combo_addrcount_nb_mm));

		pk_combo_addrscore_mm_2 :=  __common__(if(pk_combo_addrscore_mm = NULL, segment_mean, pk_combo_addrscore_mm));

		pk_combo_dobcount_mm_2 :=  __common__(if(pk_combo_dobcount_mm = NULL, segment_mean, pk_combo_dobcount_mm));

		pk_combo_dobcount_nb_mm_2 :=  __common__(if(pk_combo_dobcount_nb_mm = NULL, segment_mean, pk_combo_dobcount_nb_mm));

		pk_combo_dobscore_mm_2 :=  __common__(if(pk_combo_dobscore_mm = NULL, segment_mean, pk_combo_dobscore_mm));

		pk_combo_fnamecount_nb_mm_2 :=  __common__(if(pk_combo_fnamecount_nb_mm = NULL, segment_mean, pk_combo_fnamecount_nb_mm));

		pk_combo_hphonescore_mm_2 :=  __common__(if(pk_combo_hphonescore_mm = NULL, segment_mean, pk_combo_hphonescore_mm));

		pk_combo_lnamecount_mm_2 :=  __common__(if(pk_combo_lnamecount_mm = NULL, segment_mean, pk_combo_lnamecount_mm));

		pk_combo_ssncount_mm_2 :=  __common__(if(pk_combo_ssncount_mm = NULL, segment_mean, pk_combo_ssncount_mm));

		pk_combo_ssnscore_mm_2 :=  __common__(if(pk_combo_ssnscore_mm = NULL, segment_mean, pk_combo_ssnscore_mm));

		pk_dist_a1toa2_mm_2 :=  __common__(if(pk_dist_a1toa2_mm = NULL, segment_mean, pk_dist_a1toa2_mm));

		pk_dist_a1toa3_mm_2 :=  __common__(if(pk_dist_a1toa3_mm = NULL, segment_mean, pk_dist_a1toa3_mm));

		pk_em_only_ver_lvl_mm_2 :=  __common__(if(pk_em_only_ver_lvl_mm = NULL, segment_mean, pk_em_only_ver_lvl_mm));

		pk_eq_count_mm_2 :=  __common__(if(pk_eq_count_mm = NULL, segment_mean, pk_eq_count_mm));

		pk_estimated_income_mm_2 :=  __common__(if(pk_estimated_income_mm = NULL, segment_mean, pk_estimated_income_mm));

		pk_eviction_level_mm_2 :=  __common__(if(pk_eviction_level_mm = NULL, segment_mean, pk_eviction_level_mm));

		pk_impulse_count_mm_2 :=  __common__(if(pk_impulse_count_mm = NULL, segment_mean, pk_impulse_count_mm));

		pk_inferred_age_mm_2 :=  __common__(if(pk_inferred_age_mm = NULL, segment_mean, pk_inferred_age_mm));

		pk_infutor_risk_lvl_mm_2 :=  __common__(if(pk_infutor_risk_lvl_mm = NULL, segment_mean, pk_infutor_risk_lvl_mm));

		pk_infutor_risk_lvl_nb_mm_2 :=  __common__(if(pk_infutor_risk_lvl_nb_mm = NULL, segment_mean, pk_infutor_risk_lvl_nb_mm));

		pk_lien_type_level_mm_2 :=  __common__(if(pk_lien_type_level_mm = NULL, segment_mean, pk_lien_type_level_mm));

		pk_lname_eda_sourced_type_lvl_mm_2 :=  __common__(if(pk_lname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_lname_eda_sourced_type_lvl_mm));

		pk_lres_flag_level_mm_2 :=  __common__(if(pk_lres_flag_level_mm = NULL, segment_mean, pk_lres_flag_level_mm));

		pk_nameperssn_count_mm_2 :=  __common__(if(pk_nameperssn_count_mm = NULL, segment_mean, pk_nameperssn_count_mm));

		pk_naprop_level2_mm_2 :=  __common__(if(pk_naprop_level2_mm = NULL, segment_mean, pk_naprop_level2_mm));

		pk_nas_summary_mm_2 :=  __common__(if(pk_nas_summary_mm = NULL, segment_mean, pk_nas_summary_mm));

		pk_out_st_division_lvl_mm_2 :=  __common__(if(pk_out_st_division_lvl_mm = NULL, segment_mean, pk_out_st_division_lvl_mm));

		pk_phones_per_adl_mm_2 :=  __common__(if(pk_phones_per_adl_mm = NULL, segment_mean, pk_phones_per_adl_mm));

		pk_pl_sourced_level_mm_2 :=  __common__(if(pk_pl_sourced_level_mm = NULL, segment_mean, pk_pl_sourced_level_mm));

		pk_pos_secondary_sources_mm_2 :=  __common__(if(pk_pos_secondary_sources_mm = NULL, segment_mean, pk_pos_secondary_sources_mm));

		pk_pr_count_mm_2 :=  __common__(if(pk_pr_count_mm = NULL, segment_mean, pk_pr_count_mm));

		pk_prof_lic_cat_mm_2 :=  __common__(if(pk_prof_lic_cat_mm = NULL, segment_mean, pk_prof_lic_cat_mm));

		pk_prop_own_assess_tot2_mm_2 :=  __common__(if(pk_prop_own_assess_tot2_mm = NULL, segment_mean, pk_prop_own_assess_tot2_mm));

		pk_prop1_sale_price2_mm_2 :=  __common__(if(pk_prop1_sale_price2_mm = NULL, segment_mean, pk_prop1_sale_price2_mm));

		pk_property_owned_total_mm_2 :=  __common__(if(pk_property_owned_total_mm = NULL, segment_mean, pk_property_owned_total_mm));

		pk_rc_addrcount_mm_2 :=  __common__(if(pk_rc_addrcount_mm = NULL, segment_mean, pk_rc_addrcount_mm));

		pk_rc_addrcount_nb_mm_2 :=  __common__(if(pk_rc_addrcount_nb_mm = NULL, segment_mean, pk_rc_addrcount_nb_mm));

		pk_rc_dirsaddr_lastscore_mm_2 :=  __common__(if(pk_rc_dirsaddr_lastscore_mm = NULL, segment_mean, pk_rc_dirsaddr_lastscore_mm));

		pk_rc_disthphoneaddr_mm_2 :=  __common__(if(pk_rc_disthphoneaddr_mm = NULL, segment_mean, pk_rc_disthphoneaddr_mm));

		pk_rc_fnamecount_mm_2 :=  __common__(if(pk_rc_fnamecount_mm = NULL, segment_mean, pk_rc_fnamecount_mm));

		pk_rc_fnamecount_nb_mm_2 :=  __common__(if(pk_rc_fnamecount_nb_mm = NULL, segment_mean, pk_rc_fnamecount_nb_mm));

		pk_rc_phoneaddr_phonecount_mm_2 :=  __common__(if(pk_rc_phoneaddr_phonecount_mm = NULL, segment_mean, pk_rc_phoneaddr_phonecount_mm));

		pk_rc_phonelnamecount_mm_2 :=  __common__(if(pk_rc_phonelnamecount_mm = NULL, segment_mean, pk_rc_phonelnamecount_mm));

		pk_ssnchar_invalid_or_recent_mm_2 :=  __common__(if(pk_ssnchar_invalid_or_recent_mm = NULL, segment_mean, pk_ssnchar_invalid_or_recent_mm));

		pk_ssns_per_addr_c6_mm_2 :=  __common__(if(pk_ssns_per_addr_c6_mm = NULL, segment_mean, pk_ssns_per_addr_c6_mm));

		pk_ssns_per_addr2_mm_2 :=  __common__(if(pk_ssns_per_addr2_mm = NULL, segment_mean, pk_ssns_per_addr2_mm));

		pk_ssns_per_adl_c6_mm_2 :=  __common__(if(pk_ssns_per_adl_c6_mm = NULL, segment_mean, pk_ssns_per_adl_c6_mm));

		pk_ssns_per_adl_mm_2 :=  __common__(if(pk_ssns_per_adl_mm = NULL, segment_mean, pk_ssns_per_adl_mm));

		pk_ver_phncount_mm_2 :=  __common__(if(pk_ver_phncount_mm = NULL, segment_mean, pk_ver_phncount_mm));

		pk_voter_flag_mm_2 :=  __common__(if(pk_voter_flag_mm = NULL, segment_mean, pk_voter_flag_mm));

		pk_w_count_mm_2 :=  __common__(if(pk_w_count_mm = NULL, segment_mean, pk_w_count_mm));

		pk_wealth_index_mm_2 :=  __common__(if(pk_wealth_index_mm = NULL, segment_mean, pk_wealth_index_mm));

		pk_yr_add1_built_date2_mm_2 :=  __common__(if(pk_yr_add1_built_date2_mm = NULL, segment_mean, pk_yr_add1_built_date2_mm));

		pk_yr_add1_date_first_seen2_mm_2 :=  __common__(if(pk_yr_add1_date_first_seen2_mm = NULL, segment_mean, pk_yr_add1_date_first_seen2_mm));

		pk_yr_add1_mortgage_date2_mm_2 :=  __common__(if(pk_yr_add1_mortgage_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_date2_mm));

		pk_yr_add1_purchase_date2_mm_2 :=  __common__(if(pk_yr_add1_purchase_date2_mm = NULL, segment_mean, pk_yr_add1_purchase_date2_mm));

		pk_yr_add2_date_first_seen2_mm_2 :=  __common__(if(pk_yr_add2_date_first_seen2_mm = NULL, segment_mean, pk_yr_add2_date_first_seen2_mm));

		pk_yr_add2_mortgage_date2_mm_2 :=  __common__(if(pk_yr_add2_mortgage_date2_mm = NULL, segment_mean, pk_yr_add2_mortgage_date2_mm));

		pk_yr_add2_mortgage_due_date2_mm_2 :=  __common__(if(pk_yr_add2_mortgage_due_date2_mm = NULL, segment_mean, pk_yr_add2_mortgage_due_date2_mm));

		pk_yr_add3_date_first_seen2_mm_2 :=  __common__(if(pk_yr_add3_date_first_seen2_mm = NULL, segment_mean, pk_yr_add3_date_first_seen2_mm));

		pk_yr_adl_em_only_first_seen2_mm_2 :=  __common__(if(pk_yr_adl_em_only_first_seen2_mm = NULL, segment_mean, pk_yr_adl_em_only_first_seen2_mm));

		pk_yr_adl_vo_first_seen2_mm_2 :=  __common__(if(pk_yr_adl_vo_first_seen2_mm = NULL, segment_mean, pk_yr_adl_vo_first_seen2_mm));

		pk_yr_adl_w_first_seen2_mm_2 :=  __common__(if(pk_yr_adl_w_first_seen2_mm = NULL, segment_mean, pk_yr_adl_w_first_seen2_mm));

		pk_yr_adl_w_last_seen2_mm_2 :=  __common__(if(pk_yr_adl_w_last_seen2_mm = NULL, segment_mean, pk_yr_adl_w_last_seen2_mm));

		pk_yr_criminal_last_date2_mm_2 :=  __common__(if(pk_yr_criminal_last_date2_mm = NULL, segment_mean, pk_yr_criminal_last_date2_mm));

		pk_yr_felony_last_date2_mm_2 :=  __common__(if(pk_yr_felony_last_date2_mm = NULL, segment_mean, pk_yr_felony_last_date2_mm));

		pk_yr_gong_did_first_seen2_mm_2 :=  __common__(if(pk_yr_gong_did_first_seen2_mm = NULL, segment_mean, pk_yr_gong_did_first_seen2_mm));

		pk_yr_header_first_seen2_mm_2 :=  __common__(if(pk_yr_header_first_seen2_mm = NULL, segment_mean, pk_yr_header_first_seen2_mm));

		pk_yr_in_dob2_mm_2 :=  __common__(if(pk_yr_in_dob2_mm = NULL, segment_mean, pk_yr_in_dob2_mm));

		pk_yr_infutor_first_seen2_mm_2 :=  __common__(if(pk_yr_infutor_first_seen2_mm = NULL, segment_mean, pk_yr_infutor_first_seen2_mm));

		pk_yr_liens_last_unrel_date3_mm_2 :=  __common__(if(pk_yr_liens_last_unrel_date3_mm = NULL, segment_mean, pk_yr_liens_last_unrel_date3_mm));

		pk_yr_ln_unrel_cj_f_sn2_mm_2 :=  __common__(if(pk_yr_ln_unrel_cj_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_cj_f_sn2_mm));

		pk_yr_ln_unrel_lt_f_sn2_mm_2 :=  __common__(if(pk_yr_ln_unrel_lt_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_lt_f_sn2_mm));

		pk_yr_ln_unrel_ot_f_sn2_mm_2 :=  __common__(if(pk_yr_ln_unrel_ot_f_sn2_mm = NULL, segment_mean, pk_yr_ln_unrel_ot_f_sn2_mm));

		pk_yr_lname_change_date2_mm_2 :=  __common__(if(pk_yr_lname_change_date2_mm = NULL, segment_mean, pk_yr_lname_change_date2_mm));

		pk_yr_prop1_prev_purch_dt2_mm_2 :=  __common__(if(pk_yr_prop1_prev_purch_dt2_mm = NULL, segment_mean, pk_yr_prop1_prev_purch_dt2_mm));

		pk_yr_rc_ssnhighissue2_mm_2 :=  __common__(if(pk_yr_rc_ssnhighissue2_mm = NULL, segment_mean, pk_yr_rc_ssnhighissue2_mm));

		pk_yr_reported_dob2_mm_2 :=  __common__(if(pk_yr_reported_dob2_mm = NULL, segment_mean, pk_yr_reported_dob2_mm));

		pk_yrmo_adl_f_sn_mx_fcra2_mm_2 :=  __common__(if(pk_yrmo_adl_f_sn_mx_fcra2_mm = NULL, segment_mean, pk_yrmo_adl_f_sn_mx_fcra2_mm));

		pk2_add1_avm_auto2_mm_2 :=  __common__(if(pk2_add1_avm_auto2_mm = NULL, segment_mean, pk2_add1_avm_auto2_mm));

		pk2_add1_avm_auto4_mm_2 :=  __common__(if(pk2_add1_avm_auto4_mm = NULL, segment_mean, pk2_add1_avm_auto4_mm));

		pk2_add1_avm_hed_mm_2 :=  __common__(if(pk2_add1_avm_hed_mm = NULL, segment_mean, pk2_add1_avm_hed_mm));

		pk2_add1_avm_med_mm_2 :=  __common__(if(pk2_add1_avm_med_mm = NULL, segment_mean, pk2_add1_avm_med_mm));

		pk2_add1_avm_mkt_mm_2 :=  __common__(if(pk2_add1_avm_mkt_mm = NULL, segment_mean, pk2_add1_avm_mkt_mm));

		pk2_add1_avm_pi_mm_2 :=  __common__(if(pk2_add1_avm_pi_mm = NULL, segment_mean, pk2_add1_avm_pi_mm));

		pk2_add1_avm_to_med_ratio_mm_2 :=  __common__(if(pk2_add1_avm_to_med_ratio_mm = NULL, segment_mean, pk2_add1_avm_to_med_ratio_mm));

		pk2_add2_avm_auto4_mm_2 :=  __common__(if(pk2_add2_avm_auto4_mm = NULL, segment_mean, pk2_add2_avm_auto4_mm));

		pk2_add2_avm_hed_mm_2 :=  __common__(if(pk2_add2_avm_hed_mm = NULL, segment_mean, pk2_add2_avm_hed_mm));

		pk2_add2_avm_mkt_mm_2 :=  __common__(if(pk2_add2_avm_mkt_mm = NULL, segment_mean, pk2_add2_avm_mkt_mm));

		pk2_add2_avm_pi_mm_2 :=  __common__(if(pk2_add2_avm_pi_mm = NULL, segment_mean, pk2_add2_avm_pi_mm));

		pk2_yr_add1_avm_assess_year_mm_2 :=  __common__(if(pk2_yr_add1_avm_assess_year_mm = NULL, segment_mean, pk2_yr_add1_avm_assess_year_mm));

		pk2_yr_add1_avm_rec_dt_mm_2 :=  __common__(if(pk2_yr_add1_avm_rec_dt_mm = NULL, segment_mean, pk2_yr_add1_avm_rec_dt_mm));

		pk2_yr_add2_avm_assess_year_mm_2 :=  __common__(if(pk2_yr_add2_avm_assess_year_mm = NULL, segment_mean, pk2_yr_add2_avm_assess_year_mm));

		addprob3_mod_dm_b1 := __common__(-1.772033657 +
			((real)addrs_prison_history * 0.899868114) +
			((real)rc_statezipflag * 1.6515825018) +
			(invalid_addrs_per_adl_c6 * 0.7999750196) +
			(pk_add_standarization_flag * 0.1459512115));

		phnprob_mod_dm_b1 := __common__(-1.768935151 +
			(pk_phn_cell_pager_inval * 0.5100218402) +
			((integer)phn_zipmismatch * 0.2056119283) +
			(pk_disconnected * 0.2187907722));

		ssnprob2_mod_dm_b1 := __common__(-2.762476656 +
			((integer)ssn_issued18 * -0.352546587) +
			((integer)ssn_adl_prob * 0.1976582355) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 6.9927111757) +
			(pk_adl_cat_deceased * 0.2232943585));

		fp_mod5_dm_b1 := __common__(-4.31040647 +
			((100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))) * 0.0345708597) +
			((100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))) * 0.0508974939) +
			((100 * (exp(ssnprob2_mod_dm_b1) / (1 + exp(ssnprob2_mod_dm_b1)))) * 0.060251916) +
			(pk_rc_disthphoneaddr_mm_2 * 2.3731468361));

		age_mod3_dm_b1 := __common__(-2.892476343 +
			(pk_yr_in_dob2_mm_2 * 4.4376134407) +
			(pk_yr_reported_dob2_mm_2 * 1.7546034715) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 0.9233922586));

		age_mod3_nodob_dm_b1 := __common__(-3.078380817 +
			(pk_ams_age_mm_2 * 0.8750612984) +
			(pk_inferred_age_mm_2 * 3.5679984907) +
			(pk_yr_reported_dob2_mm_2 * 2.0158276525) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 1.9372139749));

		amstudent_mod_dm_b1 := __common__(-4.627441291 +
			(pk_ams_class_level_mm_2 * 5.1327740545) +
			(pk_ams_college_type_mm_2 * 10.80163108) +
			(pk_ams_income_level_code_mm_2 * 3.3744723206));

		avm_mod_dm_b1 := __common__(-13.76995469 +
			(pk_avm_auto_diff4_lvl_mm_2 * 46.526385403) +
			(pk2_add1_avm_auto2_mm_2 * 3.6034934848) +
			(pk2_add1_avm_med_mm_2 * 7.1930358672) +
			(pk2_add1_avm_to_med_ratio_mm_2 * 5.2402951626) +
			(pk2_add2_avm_mkt_mm_2 * 4.7429625627) +
			(pk2_add2_avm_auto4_mm_2 * 4.4199920184) +
			(pk2_yr_add1_avm_assess_year_mm_2 * 3.9710903712) +
			(pk2_yr_add2_avm_assess_year_mm_2 * 5.0942245238));

		derog_mod3_dm_b1 := __common__(-5.070534015 +
			(pk_bk_level_mm_2 * 7.2759338768) +
			(pk_yr_criminal_last_date2_mm_2 * 2.7309905033) +
			(pk_yr_felony_last_date2_mm_2 * 3.9118502563) +
			(pk_attr_total_number_derogs_mm_2 * 3.2751808332) +
			(pk_eviction_level_mm_2 * 4.8613551216));

		distance_mod2_dm_b1 := __common__(-3.103466991 +
			(pk_dist_a1toa2_mm_2 * 3.1555634217) +
			(pk_dist_a1toa3_mm_2 * 5.9121076857));

		lien_mod_dm_b1 := __common__(-4.482850774 +
			(pk_lien_type_level_mm_2 * 3.9268401769) +
			(pk_yr_liens_last_unrel_date3_mm_2 * 5.3988048104) +
			(pk_yr_ln_unrel_lt_f_sn2_mm_2 * 1.3814311892) +
			(pk_yr_ln_unrel_ot_f_sn2_mm_2 * 7.5452733304));

		lres_mod_dm_b1 := __common__(-3.743685695 +
			(pk_add1_lres_mm_2 * 3.5682601213) +
			(pk_add3_lres_mm_2 * 3.8091299604) +
			(pk_lres_flag_level_mm_2 * 1.2076394508) +
			(pk_add_lres_month_avg2_mm_2 * 4.3420916095));

		proflic_mod_dm_b1 := __common__(-3.250097295 +
			(pk_attr_num_proflic30 * 0.5933274316) +
			(pk_pl_sourced_level_mm_2 * 10.074672209));

		property_mod_dm_b1 := __common__(-6.481013653 +
			(pk_pr_count_mm_2 * 4.372596696) +
			(pk_yr_add1_date_first_seen2_mm_2 * 4.6886115314) +
			(pk_property_owned_total_mm_2 * 2.0949384128) +
			(pk_add2_assessed_amount2_mm_2 * 6.9754101851) +
			(pk_yr_add2_date_first_seen2_mm_2 * 3.1931484188) +
			(pk_yr_add3_date_first_seen2_mm_2 * 3.0660235084) +
			(pk_w_count_mm_2 * 6.6737688583));

		velocity2_mod_dm_b1 := __common__(-8.599130137 +
			(pk_vo_addrs_per_adl * -0.082589213) +
			(pk_nameperssn_count_mm_2 * 5.1635896185) +
			(pk_ssns_per_adl_mm_2 * 2.6070611793) +
			(pk_addrs_per_adl_mm_2 * 7.397314483) +
			(pk_phones_per_adl_mm_2 * 3.6695884203) +
			(pk_adlperssn_count_mm_2 * 7.1530449151) +
			(pk_adls_per_phone_mm_2 * 3.657299719) +
			(pk_ssns_per_adl_c6_mm_2 * 3.5590143324) +
			(pk_ssns_per_addr_c6_mm_2 * 2.9908259798) +
			(pk_attr_addrs_last24_mm_2 * 5.4797383711) +
			(pk_ssns_per_addr2_mm_2 * 4.0295425283));

		ver_best_score_mod_dm_b1 := __common__(-4.624174991 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 5.7588817693) +
			(pk_combo_hphonescore_mm_2 * 6.0074875831) +
			(pk_combo_dobscore_mm_2 * 5.1771176578) +
			(pk_add2_address_score_mm_2 * 3.3776651529));

		ver_best_element_cnt_mod_dm_b1 := __common__(-4.594038142 +
			(pk_rc_fnamecount_mm_2 * 2.7658699579) +
			(pk_rc_phonelnamecount_mm_2 * 3.1605015098) +
			(pk_rc_phoneaddr_phonecount_mm_2 * 3.4066900957) +
			(pk_ver_phncount_mm_2 * 1.8988546559) +
			(pk_combo_ssncount_mm_2 * 4.1214897731) +
			(pk_combo_dobcount_mm_2 * 4.5441682415));

		ver_best_src_cnt_mod_dm_b1 := __common__(-6.94859289 +
			((integer)add1_eda_sourced * -0.100766343) +
			(pk_eq_count_mm_2 * 6.1821447937) +
			(pk_pos_secondary_sources_mm_2 * 6.0654153417) +
			(pk_voter_flag_mm_2 * 5.0487330758) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 4.835272703) +
			(pk_em_only_ver_lvl_mm_2 * 5.5964129798) +
			(pk_infutor_risk_lvl_mm_2 * 5.3961786715) +
			(pk_attr_num_nonderogs90_b_mm_2 * 4.864750439));

		ver_best_src_time_mod_dm_b1 := __common__(-4.939199495 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.4096502524) +
			(pk_yr_adl_vo_first_seen2_mm_2 * 3.5659250961) +
			(pk_yr_gong_did_first_seen2_mm_2 * 3.5442039339) +
			(pk_yr_header_first_seen2_mm_2 * 2.7070247917) +
			(pk_yr_infutor_first_seen2_mm_2 * 8.2741179775));

		ver_notbest_element_cnt_mod_dm_b1 := __common__(-4.675505379 +
			(pk_combo_fnamecount_nb_mm_2 * 2.0183715145) +
			(pk_rc_phonelnamecount_mm_2 * 4.7353271597) +
			(pk_rc_addrcount_nb_mm_2 * 2.7398358354) +
			(pk_combo_ssncount_mm_2 * 3.6081296023) +
			(pk_combo_dobcount_nb_mm_2 * 2.7746030569));

		ver_notbest_score_mod_dm_b1 := __common__(-8.732672714 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 3.1199761225) +
			(pk_adl_score_mm_2 * 10.186204879) +
			(pk_combo_hphonescore_mm_2 * 4.6964902877) +
			(pk_combo_dobscore_mm_2 * 4.4679100613) +
			(pk_add1_address_score_mm_2 * 4.5196268781) +
			(pk_add2_address_score_mm_2 * 9.1892887137));

		ver_notbest_src_cnt_mod_dm_b1 := __common__(-7.258406926 +
			(pk_eq_count_mm_2 * 3.7943251144) +
			(pk_voter_flag_mm_2 * 3.0092751984) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 4.4602188895) +
			(pk_infutor_risk_lvl_nb_mm_2 * 2.1776730748) +
			(pk_nas_summary_mm_2 * 2.3436135908) +
			(pk_add2_pos_secondary_sources_mm_2 * 9.6397664944) +
			(pk_attr_num_nonderogs90_b_mm_2 * 3.3109912588));

		ver_notbest_src_time_mod_dm_b1 := __common__(-5.92829605 +
			(pk_yr_adl_em_only_first_seen2_mm_2 * 4.4434662044) +
			(pk_yr_header_first_seen2_mm_2 * 2.1583063749) +
			(pk_yr_infutor_first_seen2_mm_2 * 6.5447232302) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.2287492526) +
			(pk_yr_lname_change_date2_mm_2 * 4.747325958));

		ver_element_cnt_mod_dm_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_dm_b1) / (1 + exp(ver_best_element_cnt_mod_dm_b1)))), (100 * (exp(ver_notbest_element_cnt_mod_dm_b1) / (1 + exp(ver_notbest_element_cnt_mod_dm_b1))))));

		ver_src_cnt_mod_dm_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))), (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1))))));

		ver_score_mod_dm_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_dm_b1) / (1 + exp(ver_best_score_mod_dm_b1)))), (100 * (exp(ver_notbest_score_mod_dm_b1) / (1 + exp(ver_notbest_score_mod_dm_b1))))));

		ver_src_time_mod_dm_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_dm_b1) / (1 + exp(ver_best_src_time_mod_dm_b1)))), (100 * (exp(ver_notbest_src_time_mod_dm_b1) / (1 + exp(ver_notbest_src_time_mod_dm_b1))))));

		mod14_dm_b1 := __common__(-5.973742986 +
			(pk_impulse_count_mm_2 * 3.5665014601) +
			(pk_out_st_division_lvl_mm_2 * 6.8233149312) +
			((100 * (exp(distance_mod2_dm_b1) / (1 + exp(distance_mod2_dm_b1)))) * -0.041012148) +
			((100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))) * 0.0466558381) +
			((100 * (exp(age_mod3_dm_b1) / (1 + exp(age_mod3_dm_b1)))) * 0.0122073417) +
			((100 * (exp(velocity2_mod_dm_b1) / (1 + exp(velocity2_mod_dm_b1)))) * 0.0173435249) +
			((100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))) * -0.013235734) +
			((100 * (exp(proflic_mod_dm_b1) / (1 + exp(proflic_mod_dm_b1)))) * 0.0344030411) +
			((100 * (exp(fp_mod5_dm_b1) / (1 + exp(fp_mod5_dm_b1)))) * 0.0131428753) +
			((100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))) * 0.026940048) +
			((100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))) * 0.0257657779) +
			((100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))) * 0.027918344) +
			(ver_src_cnt_mod_dm_b1 * 0.0177355844) +
			(ver_src_time_mod_dm_b1 * 0.0015593964));

		addprob3_mod_om_b2 := __common__(-3.194143714 +
			(pk_addr_not_valid * 0.244980869) +
			((real)rc_cityzipflag * 0.7257280816));

		phnprob_mod_om_b2 := __common__(-3.251184735 +
			(pk_phn_cell_pager_inval * 0.6209363097) +
			((integer)phn_zipmismatch * 0.5776756263) +
			(pk_disconnected * 0.1745141584) +
			((integer)pk_phn_not_residential * 0.192887928) +
			(pk_area_code_split * 0.3774275654) +
			(pk_recent_ac_split * 0.2927809899));

		ssnprob2_mod_om_b2 := __common__(-3.975649788 +
			((integer)ssn_issued18 * -0.317013756) +
			((integer)ssn_adl_prob * 0.4008113215) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 21.073586502));

		fp_mod5_om_b2 := __common__(-4.921881399 +
			((100 * (exp(phnprob_mod_om_b2) / (1 + exp(phnprob_mod_om_b2)))) * 0.1152001911) +
			((100 * (exp(ssnprob2_mod_om_b2) / (1 + exp(ssnprob2_mod_om_b2)))) * 0.1690626218) +
			(pk_rc_disthphoneaddr_mm_2 * 12.875168568));

		age_mod3_nodob_om_b2 := __common__(-4.346295212 +
			(pk_inferred_age_mm_2 * 11.16477566) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 14.152934829));

		age_mod3_om_b2 := __common__(-4.313765223 +
			(pk_yr_in_dob2_mm_2 * 11.000738191) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 13.492821218));

		amstudent_mod_om_b2 := __common__(-8.221809637 +
			(pk_sl_name_match * 0.1610943068) +
			(pk_ams_class_level_mm_2 * 12.587777453) +
			(pk_ams_4yr_college_mm_2 * 23.517867106) +
			(pk_ams_college_type_mm_2 * 70.919401476) +
			(pk_ams_income_level_code_mm_2 * 19.18631336));

		avm_mod_om_b2 := __common__(-13.15238855 +
			(pk_avm_hit_level_mm_2 * 12.964745897) +
			(pk_avm_auto_diff2_lvl_mm_2 * 20.93754527) +
			(pk_avm_auto_diff4_lvl_mm_2 * 37.517186494) +
			(pk2_add1_avm_mkt_mm_2 * 20.337104905) +
			(pk2_add1_avm_pi_mm_2 * 10.435791018) +
			(pk2_add1_avm_hed_mm_2 * 9.1666847288) +
			(pk2_add1_avm_auto4_mm_2 * 10.489582962) +
			(pk2_add1_avm_med_mm_2 * 20.845738969) +
			(pk2_add1_avm_to_med_ratio_mm_2 * 30.234337447) +
			(pk2_add2_avm_pi_mm_2 * 10.528471683) +
			(pk2_add2_avm_hed_mm_2 * 10.683644065) +
			(pk2_add2_avm_auto4_mm_2 * 7.9953233352) +
			(pk2_yr_add1_avm_rec_dt_mm_2 * 22.45235703) +
			(pk2_yr_add1_avm_assess_year_mm_2 * 24.984476673));

		distance_mod2_om_b2 := __common__(-4.88043882 +
			(pk_dist_a1toa2_mm_2 * 20.434896021) +
			(pk_dist_a1toa3_mm_2 * 22.025216432));

		lien_mod_om_b2 := __common__(-4.233250111 +
			(pk_lien_type_level_mm_2 * 5.8489830898) +
			(pk_yr_ln_unrel_cj_f_sn2_mm_2 * 20.52772235));

		lres_mod_om_b2 := __common__(-4.734129678 +
			(pk_add1_lres_mm_2 * 8.0412034526) +
			(pk_add2_lres_mm_2 * 5.8251142972) +
			(pk_addrs_10yr_mm_2 * 7.3113388316) +
			(pk_add_lres_month_avg2_mm_2 * 14.552674195));

		proflic_mod_om_b2 := __common__(-4.536520152 +
			(pk_attr_num_proflic_exp12 * -0.275294839) +
			(pk_prof_lic_cat_mm_2 * 33.969756186));

		property_mod_om_b2 := __common__(-13.77850438 +
			(pk_add1_adjustable_financing * 0.2341755008) +
			(pk_pr_count_mm_2 * 12.301518121) +
			(pk_addrs_sourced_lvl_mm_2 * 45.635976549) +
			(pk_naprop_level2_mm_2 * 11.288190125) +
			(pk_yr_add1_built_date2_mm_2 * 9.7028027577) +
			(pk_yr_add1_mortgage_date2_mm_2 * 16.201737258) +
			(pk_add1_mortgage_risk_mm_2 * 10.511522711) +
			(pk_yr_add1_date_first_seen2_mm_2 * 13.965729178) +
			(pk_add1_building_area2_mm_2 * 17.021978754) +
			(pk_prop_own_assess_tot2_mm_2 * 21.129053785) +
			(pk_prop1_sale_price2_mm_2 * 31.978132777) +
			(pk_yr_prop1_prev_purch_dt2_mm_2 * 9.5971874522) +
			(pk_add2_building_area2_mm_2 * 23.720181688) +
			(pk_yr_add2_mortgage_date2_mm_2 * 13.80770968) +
			(pk_yr_add2_date_first_seen2_mm_2 * 14.849917165) +
			(pk_yr_add3_date_first_seen2_mm_2 * 8.85113065));

		velocity2_mod_om_b2 := __common__(-6.786109028 +
			(pk_vo_addrs_per_adl * -0.114347858) +
			(pk_nameperssn_count_mm_2 * 14.901015368) +
			(pk_ssns_per_adl_mm_2 * 15.184623739) +
			(pk_adls_per_phone_mm_2 * 18.406000203) +
			(pk_ssns_per_adl_c6_mm_2 * 7.736772279) +
			(pk_ssns_per_addr_c6_mm_2 * 6.5985761886) +
			(pk_attr_addrs_last24_mm_2 * 11.35163356) +
			(pk_ssns_per_addr2_mm_2 * 14.040923089));

		ver_best_element_cnt_mod_om_b2 := __common__(-4.980015937 +
			(pk_combo_lnamecount_mm_2 * 6.58282346) +
			(pk_rc_phonelnamecount_mm_2 * 22.886750316) +
			(pk_combo_dobcount_mm_2 * 14.661091121));

		ver_best_score_mod_om_b2 := __common__(-5.485146846 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 12.185721571) +
			(pk_combo_hphonescore_mm_2 * 21.592167688) +
			(pk_combo_ssnscore_mm_2 * 10.394514124) +
			(pk_combo_dobscore_mm_2 * 14.144177765));

		ver_best_src_cnt_mod_om_b2 := __common__(-8.409126189 +
			(pk_eq_count_mm_2 * 10.874896171) +
			(pk_pos_secondary_sources_mm_2 * 31.190668256) +
			(pk_voter_flag_mm_2 * 20.255750112) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 19.316586724) +
			(pk_em_only_ver_lvl_mm_2 * 25.890187096) +
			(pk_infutor_risk_lvl_mm_2 * 16.91099081) +
			(pk_attr_num_nonderogs90_b_mm_2 * 13.40617436));

		ver_best_src_time_mod_om_b2 := __common__(-5.97381253 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 13.763999519) +
			(pk_yr_adl_vo_first_seen2_mm_2 * 14.565386277) +
			(pk_yr_gong_did_first_seen2_mm_2 * 10.877146743) +
			(pk_yr_header_first_seen2_mm_2 * 9.3114998135) +
			(pk_yr_infutor_first_seen2_mm_2 * 21.415808556));

		ver_notbest_element_cnt_mod_om_b2 := __common__(-5.026261162 +
			(pk_rc_phonelnamecount_mm_2 * 16.067786907) +
			(pk_combo_addrcount_nb_mm_2 * 9.2836828108) +
			(pk_combo_dobcount_nb_mm_2 * 11.19687264));

		ver_notbest_score_mod_om_b2 := __common__(-6.741423156 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 11.329439877) +
			(pk_combo_hphonescore_mm_2 * 14.712204378) +
			(pk_combo_dobscore_mm_2 * 11.100693866) +
			(pk_add1_address_score_mm_2 * 8.1487656765) +
			(pk_add2_address_score_mm_2 * 20.772441647));

		ver_notbest_src_cnt_mod_om_b2 := __common__(-9.511833208 +
			(pk_eq_count_mm_2 * 10.423354226) +
			(pk_voter_flag_mm_2 * 10.62707455) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 15.50243215) +
			(pk_em_only_ver_lvl_mm_2 * 16.025332493) +
			(pk_infutor_risk_lvl_nb_mm_2 * 7.0460442803) +
			(pk_nas_summary_mm_2 * 8.0738238084) +
			(pk_add2_pos_sources_mm_2 * 14.611639513) +
			(pk_add2_pos_secondary_sources_mm_2 * 31.48586432));

		ver_notbest_src_time_mod_om_b2 := __common__(-4.698106763 +
			(pk_yr_header_first_seen2_mm_2 * 6.152610863) +
			(pk_yr_infutor_first_seen2_mm_2 * 14.343138843) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 10.753096787));

		ver_src_time_mod_om_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_om_b2) / (1 + exp(ver_best_src_time_mod_om_b2)))), (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2))))));

		ver_element_cnt_mod_om_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_om_b2) / (1 + exp(ver_best_element_cnt_mod_om_b2)))), (100 * (exp(ver_notbest_element_cnt_mod_om_b2) / (1 + exp(ver_notbest_element_cnt_mod_om_b2))))));

		ver_score_mod_om_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_om_b2) / (1 + exp(ver_best_score_mod_om_b2)))), (100 * (exp(ver_notbest_score_mod_om_b2) / (1 + exp(ver_notbest_score_mod_om_b2))))));

		ver_src_cnt_mod_om_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))), (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2))))));

		mod14_om_b2 := __common__(-7.792584098 +
			(pk_out_st_division_lvl_mm_2 * 13.045206952) +
			(pk_wealth_index_mm_2 * 19.61189927) +
			((100 * (exp(distance_mod2_om_b2) / (1 + exp(distance_mod2_om_b2)))) * 0.1120316636) +
			((100 * (exp(avm_mod_om_b2) / (1 + exp(avm_mod_om_b2)))) * 0.0841871602) +
			((100 * (exp(age_mod3_om_b2) / (1 + exp(age_mod3_om_b2)))) * 0.0527823876) +
			((100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))) * 0.0515791924) +
			((100 * (exp(proflic_mod_om_b2) / (1 + exp(proflic_mod_om_b2)))) * 0.2375154602) +
			((100 * (exp(lien_mod_om_b2) / (1 + exp(lien_mod_om_b2)))) * 0.0730888975) +
			((100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))) * 0.0779778358) +
			(ver_src_cnt_mod_om_b2 * 0.0747764705) +
			(ver_src_time_mod_om_b2 * 0.0117544488));

		addprob3_mod_rm_b3 := __common__(-1.833360044 +
			((real)rc_statezipflag * 1.8385059882) +
			(invalid_addrs_per_adl_c6 * 0.7732418994));

		phnprob_mod_rm_b3 := __common__(-2.026567978 +
			(pk_phn_cell_pager_inval * 0.1233375269) +
			((integer)phn_zipmismatch * 0.2120641619) +
			((integer)pk_phn_not_residential * 0.204275146) +
			(pk_area_code_split * 0.3397708239) +
			(pk_recent_ac_split * 0.1521203892));

		ssnprob2_mod_rm_b3 := __common__(-2.626425407 +
			((integer)ssn_prob * 0.331695144) +
			((integer)ssn_issued18 * -0.617408502) +
			((integer)ssn_adl_prob * 0.3969047822) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 6.1966648136));

		fp_mod5_rm_b3 := __common__(-4.614377155 +
			((100 * (exp(addprob3_mod_rm_b3) / (1 + exp(addprob3_mod_rm_b3)))) * 0.0512488357) +
			((100 * (exp(phnprob_mod_rm_b3) / (1 + exp(phnprob_mod_rm_b3)))) * 0.0327918958) +
			((100 * (exp(ssnprob2_mod_rm_b3) / (1 + exp(ssnprob2_mod_rm_b3)))) * 0.0740702626) +
			(pk_rc_disthphoneaddr_mm_2 * 3.9933931548));

		age_mod3_nodob_rm_b3 := __common__(-3.983794002 +
			(pk_ams_age_mm_2 * 2.3926442031) +
			(pk_inferred_age_mm_2 * 4.4728081925) +
			(pk_yr_reported_dob2_mm_2 * 2.8695332197) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 4.9988960876));

		age_mod3_rm_b3 := __common__(-3.442648247 +
			(pk_yr_in_dob2_mm_2 * 5.7469274118) +
			(pk_yr_reported_dob2_mm_2 * 2.8472000645) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 2.1953020726));

		amstudent_mod_rm_b3 := __common__(-4.447125236 +
			(pk_ams_class_level_mm_2 * 7.1118621743) +
			(pk_ams_4yr_college_mm_2 * 5.4779213141) +
			(pk_ams_income_level_code_mm_2 * 6.0915944533));

		avm_mod_rm_b3 := __common__(-7.540813087 +
			(pk_avm_auto_diff4_lvl_mm_2 * 5.0601576532) +
			(pk_add2_avm_auto_diff2_lvl_mm_2 * 9.3863711957) +
			(pk2_add1_avm_auto2_mm_2 * 2.8573879424) +
			(pk2_add1_avm_med_mm_2 * 6.6028731682) +
			(pk2_add2_avm_mkt_mm_2 * 3.7717904856) +
			(pk2_add2_avm_auto4_mm_2 * 4.319181618) +
			(pk2_yr_add2_avm_assess_year_mm_2 * 9.0936113341));

		distance_mod2_rm_b3 := __common__(-3.266198579 +
			(pk_dist_a1toa2_mm_2 * 3.110922083) +
			(pk_dist_a1toa3_mm_2 * 7.0823492334));

		lres_mod_rm_b3 := __common__(-5.084018719 +
			(pk_add1_lres_mm_2 * 4.4766696448) +
			(pk_add2_lres_mm_2 * 2.6201074716) +
			(pk_add3_lres_mm_2 * 2.9390121408) +
			(pk_lres_flag_level_mm_2 * 1.2204649294) +
			(pk_addrs_5yr_mm_2 * 7.5462893273) +
			(pk_add_lres_month_avg2_mm_2 * 4.0688416128));

		property_mod_rm_b3 := __common__(-20.5766674 +
			(pk_yr_adl_w_last_seen2_mm_2 * 7.9432077696) +
			(pk_pr_count_mm_2 * 6.5465422386) +
			(pk_add2_own_level_mm_2 * 8.6355057196) +
			(pk_add3_own_level_mm_2 * 6.1185737427) +
			(pk_yr_add1_built_date2_mm_2 * 4.346155903) +
			(pk_add1_mortgage_risk_mm_2 * 4.6149242097) +
			(pk_add1_assessed_amount2_mm_2 * 6.6293811959) +
			(pk_yr_add1_date_first_seen2_mm_2 * 6.3164748459) +
			(pk_add2_land_use_risk_level_mm_2 * 7.8921196414) +
			(pk_yr_add2_mortgage_date2_mm_2 * 42.022935473) +
			(pk_add2_mortgage_risk_mm_2 * 9.2787812533) +
			(pk_yr_add2_mortgage_due_date2_mm_2 * 8.9265117747) +
			(pk_add2_assessed_amount2_mm_2 * 7.3737878632) +
			(pk_yr_add2_date_first_seen2_mm_2 * 3.7450741542) +
			(pk_yr_add3_date_first_seen2_mm_2 * 4.0930256145));

		velocity2_mod_rm_b3 := __common__(-8.074776563 +
			(pk_vo_addrs_per_adl * -0.117563141) +
			(pk_addrs_per_adl_mm_2 * 8.660178225) +
			(pk_adlperssn_count_mm_2 * 7.9569168343) +
			(pk_adls_per_phone_mm_2 * 4.9996041181) +
			(pk_ssns_per_addr_c6_mm_2 * 3.6989926904) +
			(pk_attr_addrs_last90_mm_2 * 2.641448042) +
			(pk_attr_addrs_last12_mm_2 * 4.5420114) +
			(pk_attr_addrs_last24_mm_2 * 5.9809269178) +
			(pk_ssns_per_addr2_mm_2 * 6.077694708));

		ver_best_element_cnt_mod_rm_b3 := __common__(-4.981734379 +
			(pk_rc_phonelnamecount_mm_2 * 7.6373181006) +
			(pk_rc_addrcount_mm_2 * 3.8010490844) +
			(pk_combo_ssncount_mm_2 * 4.9847074818) +
			(pk_combo_dobcount_mm_2 * 7.7031170763));

		ver_best_score_mod_rm_b3 := __common__(-11.74872426 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.1765943661) +
			(pk_combo_addrscore_mm_2 * 47.9483417) +
			(pk_combo_hphonescore_mm_2 * 8.8217497914) +
			(pk_combo_ssnscore_mm_2 * 4.878071975) +
			(pk_combo_dobscore_mm_2 * 6.7844459413) +
			(pk_add2_address_score_mm_2 * 5.2605562614));

		ver_best_src_cnt_mod_rm_b3 := __common__(-7.373515038 +
			(pk_eq_count_mm_2 * 7.263955917) +
			(pk_pos_secondary_sources_mm_2 * 7.4945362925) +
			(pk_voter_flag_mm_2 * 4.3077010339) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 7.5554127338) +
			(pk_add2_em_ver_lvl_mm_2 * 8.6966922269) +
			(pk_infutor_risk_lvl_mm_2 * 3.9408410077) +
			(pk_attr_num_nonderogs90_b_mm_2 * 4.3558792079));

		ver_best_src_time_mod_rm_b3 := __common__(-4.622149964 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 7.5869351454) +
			(pk_yr_gong_did_first_seen2_mm_2 * 2.168997823) +
			(pk_yr_header_first_seen2_mm_2 * 3.2352861305) +
			(pk_yr_infutor_first_seen2_mm_2 * 7.9486565446));

		ver_notbest_element_cnt_mod_rm_b3 := __common__(-4.55882783 +
			(pk_rc_fnamecount_nb_mm_2 * 2.2767942156) +
			(pk_rc_phonelnamecount_mm_2 * 5.2294109663) +
			(pk_rc_addrcount_nb_mm_2 * 4.1128132763) +
			(pk_combo_dobcount_nb_mm_2 * 4.7566654955));

		ver_notbest_score_mod_rm_b3 := __common__(-5.928121961 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.1926447688) +
			(pk_combo_hphonescore_mm_2 * 5.4318719047) +
			(pk_combo_ssnscore_mm_2 * 2.2347411479) +
			(pk_combo_dobscore_mm_2 * 5.6307530619) +
			(pk_add1_address_score_mm_2 * 4.429497901));

		ver_notbest_src_cnt_mod_rm_b3 := __common__(-7.701513671 +
			(pk_eq_count_mm_2 * 4.2302750638) +
			(pk_pos_secondary_sources_mm_2 * 12.098728196) +
			(pk_voter_flag_mm_2 * 4.4304697062) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 5.8091674086) +
			(pk_infutor_risk_lvl_nb_mm_2 * 4.2585527492) +
			(pk_attr_num_nonderogs90_b_mm_2 * 2.6507329127));

		ver_notbest_src_time_mod_rm_b3 := __common__(-6.351541808 +
			(pk_yr_adl_em_only_first_seen2_mm_2 * 2.6938327401) +
			(pk_yr_gong_did_first_seen2_mm_2 * 2.235237984) +
			(pk_yr_header_first_seen2_mm_2 * 3.1411258362) +
			(pk_yr_infutor_first_seen2_mm_2 * 7.3552079292) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 5.1234826257) +
			(pk_yr_lname_change_date2_mm_2 * 5.574468401));

		ver_score_mod_rm_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_rm_b3) / (1 + exp(ver_best_score_mod_rm_b3)))), (100 * (exp(ver_notbest_score_mod_rm_b3) / (1 + exp(ver_notbest_score_mod_rm_b3))))));

		ver_element_cnt_mod_rm_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_rm_b3) / (1 + exp(ver_best_element_cnt_mod_rm_b3)))), (100 * (exp(ver_notbest_element_cnt_mod_rm_b3) / (1 + exp(ver_notbest_element_cnt_mod_rm_b3))))));

		ver_src_time_mod_rm_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_rm_b3) / (1 + exp(ver_best_src_time_mod_rm_b3)))), (100 * (exp(ver_notbest_src_time_mod_rm_b3) / (1 + exp(ver_notbest_src_time_mod_rm_b3))))));

		ver_src_cnt_mod_rm_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))), (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3))))));

		mod14_rm_b3 := __common__(-6.478244493 +
			(pk_out_st_division_lvl_mm_2 * 7.7775157761) +
			((100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))) * -0.026000057) +
			((100 * (exp(avm_mod_rm_b3) / (1 + exp(avm_mod_rm_b3)))) * 0.035824907) +
			((100 * (exp(age_mod3_rm_b3) / (1 + exp(age_mod3_rm_b3)))) * 0.0418488106) +
			((100 * (exp(amstudent_mod_rm_b3) / (1 + exp(amstudent_mod_rm_b3)))) * 0.0413224292) +
			((100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))) * 0.0351859064) +
			((100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))) * -0.03770046) +
			(pk_prof_lic_cat_mm_2 * 6.8725590085) +
			((100 * (exp(fp_mod5_rm_b3) / (1 + exp(fp_mod5_rm_b3)))) * 0.0111342191) +
			((100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))) * 0.0312492795) +
			(pk_estimated_income_mm_2 * 1.1839457165) +
			(ver_element_cnt_mod_rm_b3 * 0.0188247242) +
			(ver_src_time_mod_rm_b3 * 0.013305162) +
			(pk_multi_did * 0.4070716438));

		addprob3_mod_xm_b4 := __common__(-2.400434233 +
			((real)rc_statezipflag * 0.9700574387) +
			(invalid_addrs_per_adl_c6 * 0.4091254606) +
			(pk_addr_not_valid * 0.2442248581) +
			((real)rc_cityzipflag * 0.3792407768) +
			(pk_corp_mil_zip * 0.5992745751) +
			(pk_add_standarization_flag * 0.0824368984));

		phnprob_mod_xm_b4 := __common__(-2.370852669 +
			(pk_phn_cell_pager_inval * 0.4376295341) +
			((integer)phn_zipmismatch * 0.2331176135) +
			(pk_disconnected * 0.315307922) +
			((integer)pk_phn_not_residential * 0.1366825351) +
			(pk_area_code_split * 0.3406217645) +
			(pk_recent_ac_split * 0.1175775156));

		ssnprob2_mod_xm_b4 := __common__(-3.203967217 +
			((integer)ssn_issued18 * -0.931793479) +
			((integer)ssn_adl_prob * 0.239777298) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 10.579959967));

		fp_mod5_xm_b4 := __common__(-4.338819084 +
			((100 * (exp(phnprob_mod_xm_b4) / (1 + exp(phnprob_mod_xm_b4)))) * 0.0554706188) +
			((100 * (exp(ssnprob2_mod_xm_b4) / (1 + exp(ssnprob2_mod_xm_b4)))) * 0.1033474424) +
			(pk_rc_disthphoneaddr_mm_2 * 5.9049131986));

		age_mod3_nodob_xm_b4 := __common__(-4.040493691 +
			(pk_inferred_age_mm_2 * 6.2214520101) +
			(pk_yr_reported_dob2_mm_2 * 5.980024073) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 5.1694464532));

		age_mod3_xm_b4 := __common__(-3.971423225 +
			(pk_yr_in_dob2_mm_2 * 8.1413855066) +
			(pk_yr_reported_dob2_mm_2 * 6.2631194263) +
			(pk_yr_rc_ssnhighissue2_mm_2 * 2.1448775339));

		amstudent_mod_xm_b4 := __common__(-5.70236436 +
			(pk_sl_name_match * 0.2163120776) +
			(pk_ams_class_level_mm_2 * 9.5209345676) +
			(pk_ams_4yr_college_mm_2 * 11.043775886) +
			(pk_ams_college_type_mm_2 * 7.0503600073) +
			(pk_ams_income_level_code_mm_2 * 10.079455151));

		avm_mod_xm_b4 := __common__(-4.987138693 +
			(pk2_add1_avm_auto4_mm_2 * 5.3702965158) +
			(pk2_add1_avm_med_mm_2 * 10.520543981) +
			(pk2_add2_avm_auto4_mm_2 * 6.0105925552) +
			(pk2_yr_add1_avm_rec_dt_mm_2 * 8.1035021919));

		distance_mod2_xm_b4 := __common__(-3.812308206 +
			(pk_dist_a1toa2_mm_2 * 5.6588918946) +
			(pk_dist_a1toa3_mm_2 * 10.854852398));

		lres_mod_xm_b4 := __common__(-5.763613362 +
			(pk_add1_lres_mm_2 * 4.8047919334) +
			(pk_add2_lres_mm_2 * 3.2263730969) +
			(pk_add3_lres_mm_2 * 2.6038395828) +
			(pk_lres_flag_level_mm_2 * 2.9715536302) +
			(pk_addrs_10yr_mm_2 * 15.67250562) +
			(pk_add_lres_month_avg2_mm_2 * 8.3521215616));

		property_mod_xm_b4 := __common__(-12.33820983 +
			(pk_add3_adjustable_financing * 0.3989630573) +
			(pk_add1_no_of_partial_baths * -0.243716756) +
			(pk_yr_adl_w_first_seen2_mm_2 * 11.090004509) +
			(pk_pr_count_mm_2 * 12.183939604) +
			(pk_yr_add1_purchase_date2_mm_2 * 4.6930289928) +
			(pk_add1_mortgage_risk_mm_2 * 4.2466120969) +
			(pk_add1_assessed_amount2_mm_2 * 9.5812066777) +
			(pk_yr_add1_date_first_seen2_mm_2 * 8.9977518606) +
			(pk_add1_building_area2_mm_2 * 4.2554535516) +
			(pk_add1_no_of_baths_mm_2 * 4.599938747) +
			(pk_add2_building_area2_mm_2 * 3.6745108961) +
			(pk_add2_no_of_baths_mm_2 * 5.3720986867) +
			(pk_yr_add2_mortgage_due_date2_mm_2 * 4.7573482531) +
			(pk_add2_assessed_amount2_mm_2 * 6.2218213864) +
			(pk_yr_add2_date_first_seen2_mm_2 * 6.8623690261) +
			(pk_add3_mortgage_risk_mm_2 * 10.663557326) +
			(pk_add3_assessed_amount2_mm_2 * 11.452680357) +
			(pk_yr_add3_date_first_seen2_mm_2 * 4.5408307096));

		velocity2_mod_xm_b4 := __common__(-7.824916051 +
			(pk_vo_addrs_per_adl * -0.125731891) +
			(pk_addrs_per_adl_mm_2 * 11.936397188) +
			(pk_phones_per_adl_mm_2 * 2.5785294172) +
			(pk_adlperssn_count_mm_2 * 17.4815863) +
			(pk_adls_per_phone_mm_2 * 7.2069502147) +
			(pk_ssns_per_addr_c6_mm_2 * 3.7451001654) +
			(pk_attr_addrs_last12_mm_2 * 3.3878881265) +
			(pk_attr_addrs_last24_mm_2 * 7.8464049023) +
			(pk_ssns_per_addr2_mm_2 * 7.4493744962));

		ver_best_element_cnt_mod_xm_b4 := __common__(-4.766307777 +
			(pk_rc_phonelnamecount_mm_2 * 11.887388071) +
			(pk_rc_addrcount_mm_2 * 6.8595507883) +
			(pk_combo_dobcount_mm_2 * 9.5326547203));

		ver_best_score_mod_xm_b4 := __common__(-4.990552616 +
			(pk_combo_fnamescore * -0.284936318) +
			(pk_rc_dirsaddr_lastscore_mm_2 * 8.6625466337) +
			(pk_combo_hphonescore_mm_2 * 11.089861395) +
			(pk_combo_dobscore_mm_2 * 9.4100031385) +
			(pk_add2_address_score_mm_2 * 6.0234492953));

		ver_best_src_cnt_mod_xm_b4 := __common__(-7.258034647 +
			(pk_eq_count_mm_2 * 10.137785932) +
			(pk_pos_secondary_sources_mm_2 * 12.70991574) +
			(pk_voter_flag_mm_2 * 6.8076228676) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 10.772084422) +
			(pk_em_only_ver_lvl_mm_2 * 7.6932362019) +
			(pk_infutor_risk_lvl_mm_2 * 6.5231364699) +
			(pk_attr_num_nonderogs90_b_mm_2 * 6.3274439369));

		ver_best_src_time_mod_xm_b4 := __common__(-4.746907083 +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 12.070255715) +
			(pk_yr_header_first_seen2_mm_2 * 5.3779080946) +
			(pk_yr_infutor_first_seen2_mm_2 * 10.08643065));

		ver_notbest_element_cnt_mod_xm_b4 := __common__(-4.605326678 +
			(pk_rc_phonelnamecount_mm_2 * 8.5975015808) +
			(pk_combo_addrcount_nb_mm_2 * 4.71095369) +
			(pk_combo_dobcount_nb_mm_2 * 7.6008635499));

		ver_notbest_score_mod_xm_b4 := __common__(-8.441404409 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.6435110859) +
			(pk_adl_score_mm_2 * 21.854182336) +
			(pk_combo_hphonescore_mm_2 * 8.2210203279) +
			(pk_combo_ssnscore_mm_2 * 3.9999209371) +
			(pk_combo_dobscore_mm_2 * 7.802153432) +
			(pk_add1_address_score_mm_2 * 4.6915188286));

		ver_notbest_src_cnt_mod_xm_b4 := __common__(-5.431207818 +
			((integer)add1_eda_sourced * -0.161537258) +
			(pk_eq_count_mm_2 * 5.713988338) +
			(pk_voter_flag_mm_2 * 5.9598627163) +
			(pk_lname_eda_sourced_type_lvl_mm_2 * 7.6750694101) +
			(pk_infutor_risk_lvl_nb_mm_2 * 4.4664596216) +
			(pk_attr_num_nonderogs90_b_mm_2 * 4.2773784815));

		ver_notbest_src_time_mod_xm_b4 := __common__(-5.07081603 +
			(pk_yr_header_first_seen2_mm_2 * 4.674472641) +
			(pk_yr_infutor_first_seen2_mm_2 * 6.8892236897) +
			(pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 8.4340871772) +
			(pk_yr_lname_change_date2_mm_2 * 4.7871412946));

		ver_element_cnt_mod_xm_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_xm_b4) / (1 + exp(ver_best_element_cnt_mod_xm_b4)))), (100 * (exp(ver_notbest_element_cnt_mod_xm_b4) / (1 + exp(ver_notbest_element_cnt_mod_xm_b4))))));

		ver_score_mod_xm_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_xm_b4) / (1 + exp(ver_best_score_mod_xm_b4)))), (100 * (exp(ver_notbest_score_mod_xm_b4) / (1 + exp(ver_notbest_score_mod_xm_b4))))));

		ver_src_time_mod_xm_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4)))), (100 * (exp(ver_notbest_src_time_mod_xm_b4) / (1 + exp(ver_notbest_src_time_mod_xm_b4))))));

		ver_src_cnt_mod_xm_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_xm_b4) / (1 + exp(ver_best_src_cnt_mod_xm_b4)))), (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4))))));

		mod14_xm_b4 := __common__(-5.644954367 +
			(pk_did0 * -1.158833602) +
			(pk_out_st_division_lvl_mm_2 * 4.5299169852) +
			((100 * (exp(distance_mod2_xm_b4) / (1 + exp(distance_mod2_xm_b4)))) * -0.048948045) +
			((100 * (exp(avm_mod_xm_b4) / (1 + exp(avm_mod_xm_b4)))) * 0.0392786466) +
			((100 * (exp(age_mod3_xm_b4) / (1 + exp(age_mod3_xm_b4)))) * 0.052184562) +
			((100 * (exp(amstudent_mod_xm_b4) / (1 + exp(amstudent_mod_xm_b4)))) * 0.0539682247) +
			((100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4)))) * 0.0407295304) +
			((100 * (exp(lres_mod_xm_b4) / (1 + exp(lres_mod_xm_b4)))) * -0.022661826) +
			(pk_prof_lic_cat_mm_2 * 5.2831713822) +
			((100 * (exp(fp_mod5_xm_b4) / (1 + exp(fp_mod5_xm_b4)))) * 0.0120756377) +
			((100 * (exp(property_mod_xm_b4) / (1 + exp(property_mod_xm_b4)))) * 0.0380224803) +
			(pk_estimated_income_mm_2 * 4.3243782369) +
			(ver_src_cnt_mod_xm_b4 * 0.0214349092) +
			(ver_element_cnt_mod_xm_b4 * 0.0173305793) +
			(ver_score_mod_xm_b4 * 0.0078432111));

		ver_best_element_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_element_cnt_mod_om_b2) / (1 + exp(ver_best_element_cnt_mod_om_b2)))),
										   pk_segment_2 = '2 Renter' => NULL,
																		NULL));

		distance_mod2_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => (100 * (exp(distance_mod2_om_b2) / (1 + exp(distance_mod2_om_b2)))),
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		velocity2_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))),
															 NULL));

		lien_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))),
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		phat := __common__(map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))),
					pk_segment_2 = '1 Owner ' => (exp(mod14_om_b2) / (1 + exp(mod14_om_b2))),
					pk_segment_2 = '2 Renter' => (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))),
												 (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4)))));

		addprob3_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))),
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		proflic_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => (100 * (exp(proflic_mod_om_b2) / (1 + exp(proflic_mod_om_b2)))),
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL));

		age_mod3_nodob_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  (100 * (exp(age_mod3_nodob_xm_b4) / (1 + exp(age_mod3_nodob_xm_b4))))));

		ver_best_score_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_score_mod_dm_b1) / (1 + exp(ver_best_score_mod_dm_b1)))),
									 pk_segment_2 = '1 Owner ' => NULL,
									 pk_segment_2 = '2 Renter' => NULL,
																  NULL));

		avm_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => (100 * (exp(avm_mod_om_b2) / (1 + exp(avm_mod_om_b2)))),
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL));

		ver_best_src_time_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_src_time_mod_dm_b1) / (1 + exp(ver_best_src_time_mod_dm_b1)))),
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		fp_mod5_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(fp_mod5_dm_b1) / (1 + exp(fp_mod5_dm_b1)))),
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL));

		property_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															(100 * (exp(property_mod_xm_b4) / (1 + exp(property_mod_xm_b4))))));

		velocity2_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(velocity2_mod_dm_b1) / (1 + exp(velocity2_mod_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		age_mod3_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(age_mod3_dm_b1) / (1 + exp(age_mod3_dm_b1)))),
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		ver_best_score_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									 pk_segment_2 = '1 Owner ' => NULL,
									 pk_segment_2 = '2 Renter' => NULL,
																  (100 * (exp(ver_best_score_mod_xm_b4) / (1 + exp(ver_best_score_mod_xm_b4))))));

		ver_notbest_element_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_element_cnt_mod_rm_b3) / (1 + exp(ver_notbest_element_cnt_mod_rm_b3)))),
																		   NULL));

		lien_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => (100 * (exp(lien_mod_om_b2) / (1 + exp(lien_mod_om_b2)))),
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		age_mod3_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => (100 * (exp(age_mod3_rm_b3) / (1 + exp(age_mod3_rm_b3)))),
														NULL));

		ver_notbest_src_time_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_src_time_mod_dm_b1) / (1 + exp(ver_notbest_src_time_mod_dm_b1)))),
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => NULL,
																		NULL));

		property_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => (100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))),
															NULL));

		addprob3_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => (100 * (exp(addprob3_mod_rm_b3) / (1 + exp(addprob3_mod_rm_b3)))),
															NULL));

		age_mod3_nodob_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => (100 * (exp(age_mod3_nodob_om_b2) / (1 + exp(age_mod3_nodob_om_b2)))),
								 pk_segment_2 = '2 Renter' => NULL,
															  NULL));

		velocity2_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => (100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))),
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_element_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									  pk_segment_2 = '1 Owner ' => NULL,
									  pk_segment_2 = '2 Renter' => ver_element_cnt_mod_rm_b3,
																   NULL));

		ver_src_time_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => ver_src_time_mod_rm_b3,
																NULL));

		property_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))),
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		ver_notbest_src_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => NULL,
																	   (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4))))));

		ssnprob2_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => (100 * (exp(ssnprob2_mod_om_b2) / (1 + exp(ssnprob2_mod_om_b2)))),
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		ver_best_src_time_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_src_time_mod_om_b2) / (1 + exp(ver_best_src_time_mod_om_b2)))),
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		ver_best_src_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => NULL,
																	(100 * (exp(ver_best_src_cnt_mod_xm_b4) / (1 + exp(ver_best_src_cnt_mod_xm_b4))))));

		avm_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => (100 * (exp(avm_mod_rm_b3) / (1 + exp(avm_mod_rm_b3)))),
													   NULL));

		amstudent_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(amstudent_mod_rm_b3) / (1 + exp(amstudent_mod_rm_b3)))),
															 NULL));

		age_mod3_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														(100 * (exp(age_mod3_xm_b4) / (1 + exp(age_mod3_xm_b4))))));

		velocity2_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4))))));

		ssnprob2_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => (100 * (exp(ssnprob2_mod_rm_b3) / (1 + exp(ssnprob2_mod_rm_b3)))),
															NULL));

		ver_src_time_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => ver_src_time_mod_dm_b1,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => NULL,
																NULL));

		lres_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => (100 * (exp(lres_mod_om_b2) / (1 + exp(lres_mod_om_b2)))),
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		avm_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))),
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL));

		ver_best_src_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))),
																	NULL));

		ver_element_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									  pk_segment_2 = '1 Owner ' => NULL,
									  pk_segment_2 = '2 Renter' => NULL,
																   ver_element_cnt_mod_xm_b4));

		ssnprob2_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															(100 * (exp(ssnprob2_mod_xm_b4) / (1 + exp(ssnprob2_mod_xm_b4))))));

		lres_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => (100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))),
														NULL));

		ver_score_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 ver_score_mod_xm_b4));

		distance_mod2_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => (100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))),
															 NULL));

		proflic_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(proflic_mod_dm_b1) / (1 + exp(proflic_mod_dm_b1)))),
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL));

		ver_notbest_src_time_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_src_time_mod_rm_b3) / (1 + exp(ver_notbest_src_time_mod_rm_b3)))),
																		NULL));

		ver_best_src_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))),
									   pk_segment_2 = '2 Renter' => NULL,
																	NULL));

		addprob3_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															(100 * (exp(addprob3_mod_xm_b4) / (1 + exp(addprob3_mod_xm_b4))))));

		age_mod3_nodob_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => (100 * (exp(age_mod3_nodob_rm_b3) / (1 + exp(age_mod3_nodob_rm_b3)))),
															  NULL));

		phnprob_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => (100 * (exp(phnprob_mod_rm_b3) / (1 + exp(phnprob_mod_rm_b3)))),
														   NULL));

		ver_src_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => ver_src_cnt_mod_dm_b1,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => NULL,
															   NULL));

		ver_best_element_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_element_cnt_mod_rm_b3) / (1 + exp(ver_best_element_cnt_mod_rm_b3)))),
																		NULL));

		ssnprob2_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ssnprob2_mod_dm_b1) / (1 + exp(ssnprob2_mod_dm_b1)))),
							   pk_segment_2 = '1 Owner ' => NULL,
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		derog_mod3_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))),
							 pk_segment_2 = '1 Owner ' => NULL,
							 pk_segment_2 = '2 Renter' => NULL,
														  NULL));

		ver_best_score_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									 pk_segment_2 = '1 Owner ' => NULL,
									 pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_score_mod_rm_b3) / (1 + exp(ver_best_score_mod_rm_b3)))),
																  NULL));

		amstudent_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => (100 * (exp(amstudent_mod_om_b2) / (1 + exp(amstudent_mod_om_b2)))),
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_src_time_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => ver_src_time_mod_om_b2,
								   pk_segment_2 = '2 Renter' => NULL,
																NULL));

		ver_notbest_score_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_score_mod_dm_b1) / (1 + exp(ver_notbest_score_mod_dm_b1)))),
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		mod14_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						pk_segment_2 = '1 Owner ' => (exp(mod14_om_b2) / (1 + exp(mod14_om_b2))),
						pk_segment_2 = '2 Renter' => NULL,
													 NULL));

		mod14_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						pk_segment_2 = '1 Owner ' => NULL,
						pk_segment_2 = '2 Renter' => NULL,
													 (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4)))));

		ver_notbest_src_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3)))),
																	   NULL));

		ver_notbest_src_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2)))),
										  pk_segment_2 = '2 Renter' => NULL,
																	   NULL));

		fp_mod5_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => (100 * (exp(fp_mod5_om_b2) / (1 + exp(fp_mod5_om_b2)))),
						  pk_segment_2 = '2 Renter' => NULL,
													   NULL));

		distance_mod2_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(distance_mod2_dm_b1) / (1 + exp(distance_mod2_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_notbest_element_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_element_cnt_mod_dm_b1) / (1 + exp(ver_notbest_element_cnt_mod_dm_b1)))),
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		ver_best_src_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))),
									   pk_segment_2 = '1 Owner ' => NULL,
									   pk_segment_2 = '2 Renter' => NULL,
																	NULL));

		ver_src_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => NULL,
															   ver_src_cnt_mod_xm_b4));

		age_mod3_nodob_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(age_mod3_nodob_dm_b1) / (1 + exp(age_mod3_nodob_dm_b1)))),
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  NULL));

		ver_notbest_src_time_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => NULL,
																		(100 * (exp(ver_notbest_src_time_mod_xm_b4) / (1 + exp(ver_notbest_src_time_mod_xm_b4))))));

		ver_notbest_score_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 (100 * (exp(ver_notbest_score_mod_xm_b4) / (1 + exp(ver_notbest_score_mod_xm_b4))))));

		addprob3_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => (100 * (exp(addprob3_mod_om_b2) / (1 + exp(addprob3_mod_om_b2)))),
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		fp_mod5_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => (100 * (exp(fp_mod5_rm_b3) / (1 + exp(fp_mod5_rm_b3)))),
													   NULL));

		ver_notbest_element_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   (100 * (exp(ver_notbest_element_cnt_mod_xm_b4) / (1 + exp(ver_notbest_element_cnt_mod_xm_b4))))));

		ver_score_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => ver_score_mod_dm_b1,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_best_score_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									 pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_score_mod_om_b2) / (1 + exp(ver_best_score_mod_om_b2)))),
									 pk_segment_2 = '2 Renter' => NULL,
																  NULL));

		amstudent_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(amstudent_mod_dm_b1) / (1 + exp(amstudent_mod_dm_b1)))),
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_notbest_src_time_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2)))),
										   pk_segment_2 = '2 Renter' => NULL,
																		NULL));

		mod14_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						pk_segment_2 = '1 Owner ' => NULL,
						pk_segment_2 = '2 Renter' => (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))),
													 NULL));

		ver_best_src_time_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4))))));

		ver_src_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => ver_src_cnt_mod_om_b2,
								  pk_segment_2 = '2 Renter' => NULL,
															   NULL));

		amstudent_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(amstudent_mod_xm_b4) / (1 + exp(amstudent_mod_xm_b4))))));

		avm_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   (100 * (exp(avm_mod_xm_b4) / (1 + exp(avm_mod_xm_b4))))));

		ver_score_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => ver_score_mod_rm_b3,
															 NULL));

		distance_mod2_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => NULL,
								pk_segment_2 = '2 Renter' => NULL,
															 (100 * (exp(distance_mod2_xm_b4) / (1 + exp(distance_mod2_xm_b4))))));

		ver_notbest_element_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_element_cnt_mod_om_b2) / (1 + exp(ver_notbest_element_cnt_mod_om_b2)))),
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		fp_mod5_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						  pk_segment_2 = '1 Owner ' => NULL,
						  pk_segment_2 = '2 Renter' => NULL,
													   (100 * (exp(fp_mod5_xm_b4) / (1 + exp(fp_mod5_xm_b4))))));

		age_mod3_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => (100 * (exp(age_mod3_om_b2) / (1 + exp(age_mod3_om_b2)))),
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		ver_src_cnt_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								  pk_segment_2 = '1 Owner ' => NULL,
								  pk_segment_2 = '2 Renter' => ver_src_cnt_mod_rm_b3,
															   NULL));

		phnprob_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))),
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL));

		phnprob_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => NULL,
							  pk_segment_2 = '2 Renter' => NULL,
														   (100 * (exp(phnprob_mod_xm_b4) / (1 + exp(phnprob_mod_xm_b4))))));

		ver_notbest_score_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_score_mod_rm_b3) / (1 + exp(ver_notbest_score_mod_rm_b3)))),
																	 NULL));

		mod14_scr := __common__(map(pk_segment_2 = '0 Derog ' => (((-40 * ((ln(((exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))) / (1 - (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
						 pk_segment_2 = '1 Owner ' => (((-40 * ((ln(((exp(mod14_om_b2) / (1 + exp(mod14_om_b2))) / (1 - (exp(mod14_om_b2) / (1 + exp(mod14_om_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
						 pk_segment_2 = '2 Renter' => (((-40 * ((ln(((exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))) / (1 - (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3)))))) - ln((1 / 20))) / ln(2))) + 700)),
													  (((-40 * ((ln(((exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4))) / (1 - (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4)))))) - ln((1 / 20))) / ln(2))) + 700))));
		mod14_scr_rounded := __common__(round(mod14_scr));
      /*   mod14_Scr = round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);         Log Adjustment - 04/01/2010 PK   */
           // mod14_Scr = round(-40*(log(phat/(1-phat)) - log(1/20))/log(2) + 700);

		ver_notbest_score_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_score_mod_om_b2) / (1 + exp(ver_notbest_score_mod_om_b2)))),
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		ver_best_element_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_element_cnt_mod_dm_b1) / (1 + exp(ver_best_element_cnt_mod_dm_b1)))),
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => NULL,
																		NULL));

		ver_best_src_time_mod_rm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_src_time_mod_rm_b3) / (1 + exp(ver_best_src_time_mod_rm_b3)))),
																	 NULL));

		ver_element_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => ver_element_cnt_mod_dm_b1,
									  pk_segment_2 = '1 Owner ' => NULL,
									  pk_segment_2 = '2 Renter' => NULL,
																   NULL));

		lres_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))),
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														NULL));

		ver_element_cnt_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
									  pk_segment_2 = '1 Owner ' => ver_element_cnt_mod_om_b2,
									  pk_segment_2 = '2 Renter' => NULL,
																   NULL));

		mod14_dm := __common__(map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))),
						pk_segment_2 = '1 Owner ' => NULL,
						pk_segment_2 = '2 Renter' => NULL,
													 NULL));

		phnprob_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							  pk_segment_2 = '1 Owner ' => (100 * (exp(phnprob_mod_om_b2) / (1 + exp(phnprob_mod_om_b2)))),
							  pk_segment_2 = '2 Renter' => NULL,
														   NULL));

		ver_notbest_src_cnt_mod_dm := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1)))),
										  pk_segment_2 = '1 Owner ' => NULL,
										  pk_segment_2 = '2 Renter' => NULL,
																	   NULL));

		ver_score_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								pk_segment_2 = '1 Owner ' => ver_score_mod_om_b2,
								pk_segment_2 = '2 Renter' => NULL,
															 NULL));

		ver_src_time_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => NULL,
																ver_src_time_mod_xm_b4));

		property_mod_om := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
							   pk_segment_2 = '1 Owner ' => (100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))),
							   pk_segment_2 = '2 Renter' => NULL,
															NULL));

		ver_best_element_cnt_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										   pk_segment_2 = '1 Owner ' => NULL,
										   pk_segment_2 = '2 Renter' => NULL,
																		(100 * (exp(ver_best_element_cnt_mod_xm_b4) / (1 + exp(ver_best_element_cnt_mod_xm_b4))))));

		lres_mod_xm := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
						   pk_segment_2 = '1 Owner ' => NULL,
						   pk_segment_2 = '2 Renter' => NULL,
														(100 * (exp(lres_mod_xm_b4) / (1 + exp(lres_mod_xm_b4))))));


		ssnprob2_mod_dm_nodob_b1_c2_b1 := __common__(-2.842600985 +
			((integer)ssn_adl_prob * 0.1873546716) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 7.1790009888) +
			((integer)pk_ssn_prob_nodob * -0.452191544));

		fp_mod5_dm_nodob_b1_c2_b1 := __common__(-4.338740726 +
			(addprob3_mod_dm * 0.0358226662) +
			(phnprob_mod_dm * 0.0529245176) +
			((100 * (exp(ssnprob2_mod_dm_nodob_b1_c2_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1_c2_b1)))) * 0.0586905893) +
			(pk_rc_disthphoneaddr_mm_2 * 2.4175562576));

		ver_best_e_cnt_mod_dm_nodob_b1_c2_b1 := __common__(-4.509959302 +
			(pk_combo_fnamecount_mm * 4.6719603838) +
			(pk_combo_lnamecount_mm_2 * 2.030032763) +
			(pk_rc_phonelnamecount_mm_2 * 2.8468191439) +
			(pk_rc_phoneaddr_phonecount_mm_2 * 4.5332590189) +
			(pk_combo_ssncount_mm_2 * 5.261862915));

		ver_best_score_mod_dm_nodob_b1_c2_b1 := __common__(-4.714955224 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.7451099256) +
			(pk_combo_hphonescore_mm_2 * 6.8211594303) +
			(pk_add2_address_score_mm_2 * 7.5597897117));

		ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1 := __common__(-4.609136192 +
			(pk_combo_fnamecount_nb_mm_2 * 3.8843807551) +
			(pk_rc_phonelnamecount_mm_2 * 4.6181228426) +
			(pk_rc_addrcount_nb_mm_2 * 2.947670551) +
			(pk_combo_ssncount_mm_2 * 4.1206032876));

		ver_notbest_score_mod_dm_nodob_b1_c2_b1 := __common__(-5.992346035 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 3.5370541899) +
			(pk_combo_hphonescore_mm_2 * 4.9999200267) +
			(pk_add1_address_score_mm_2 * 5.5395500916) +
			(pk_add2_address_score_mm_2 * 8.5714636452));

		ver_score_mod_dm_nodob_b1_c2_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_best_score_mod_dm_nodob_b1_c2_b1)))), (100 * (exp(ver_notbest_score_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_notbest_score_mod_dm_nodob_b1_c2_b1))))));

		ver_element_cnt_mod_dm_nodob_b1_c2_b1 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_best_e_cnt_mod_dm_nodob_b1_c2_b1)))), (100 * (exp(ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1))))));

		mod14_dm_nodob_b1_c2_b1 := __common__(-6.039670217 +
			(pk_impulse_count_mm_2 * 3.7080585665) +
			(pk_out_st_division_lvl_mm_2 * 6.9392049451) +
			(distance_mod2_dm * -0.036558835) +
			(avm_mod_dm * 0.0459695809) +
			(velocity2_mod_dm * 0.0184784166) +
			(lres_mod_dm * -0.011581715) +
			(proflic_mod_dm * 0.0349858649) +
			((100 * (exp(fp_mod5_dm_nodob_b1_c2_b1) / (1 + exp(fp_mod5_dm_nodob_b1_c2_b1)))) * 0.0101386326) +
			(derog_mod3_dm * 0.0279292847) +
			(lien_mod_dm * 0.0261756063) +
			(property_mod_dm * 0.0294115059) +
			(ver_src_cnt_mod_dm * 0.0175450277) +
			(ver_src_time_mod_dm * 0.0088320176));

		ssnprob2_mod_om_nodob_b1_c2_b2 := __common__(-4.071166748 +
			((integer)ssn_adl_prob * 0.3983908386) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 21.443383785));

		fp_mod5_om_nodob_b1_c2_b2 := __common__(-4.939412813 +
			(phnprob_mod_om * 0.1182944061) +
			((100 * (exp(ssnprob2_mod_om_nodob_b1_c2_b2) / (1 + exp(ssnprob2_mod_om_nodob_b1_c2_b2)))) * 0.1693178085) +
			(pk_rc_disthphoneaddr_mm_2 * 13.068203329));

		ver_best_e_cnt_mod_om_nodob_b1_c2_b2 := __common__(-4.600378585 +
			(pk_combo_lnamecount_mm_2 * 11.827299106) +
			(pk_rc_phonelnamecount_mm_2 * 22.198878436));

		ver_best_score_mod_om_nodob_b1_c2_b2 := __common__(-6.366842208 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 13.870097454) +
			(pk_combo_hphonescore_mm_2 * 22.589077518) +
			(pk_combo_ssnscore_mm_2 * 12.030060746) +
			(pk_add1_address_score_mm_2 * 11.735152277) +
			(pk_add2_address_score_mm_2 * 22.846952735));

		ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2 := __common__(-5.06385029 +
			(pk_rc_fnamecount_nb_mm_2 * 10.739812497) +
			(pk_rc_phonelnamecount_mm_2 * 16.489107695) +
			(pk_combo_addrcount_nb_mm_2 * 10.119203697));

		ver_notbest_score_mod_om_nodob_b1_c2_b2 := __common__(-5.869701766 +
			(pk_fname_score * -0.43980397) +
			(pk_rc_dirsaddr_lastscore_mm_2 * 11.410525282) +
			(pk_combo_hphonescore_mm_2 * 15.292389019) +
			(pk_add1_address_score_mm_2 * 10.906266764) +
			(pk_add2_address_score_mm_2 * 20.946905919));

		ver_element_cnt_mod_om_nodob_b1_c2_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_best_e_cnt_mod_om_nodob_b1_c2_b2)))), (100 * (exp(ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2))))));

		ver_score_mod_om_nodob_b1_c2_b2 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_best_score_mod_om_nodob_b1_c2_b2)))), (100 * (exp(ver_notbest_score_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_notbest_score_mod_om_nodob_b1_c2_b2))))));

		mod14_om_nodob_b1_c2_b2 := __common__(-7.970377944 +
			(pk_out_st_division_lvl_mm_2 * 13.336538955) +
			(pk_wealth_index_mm_2 * 18.052629316) +
			(distance_mod2_om * 0.1092564194) +
			(avm_mod_om * 0.080827847) +
			(age_mod3_nodob_om * 0.0465256118) +
			(amstudent_mod_om * 0.0381044419) +
			(velocity2_mod_om * 0.0531005013) +
			(proflic_mod_om * 0.2267831372) +
			(lien_mod_om * 0.0762551155) +
			(property_mod_om * 0.0782441382) +
			(pk_estimated_income_mm_2 * 3.8192215132) +
			(ver_src_cnt_mod_om * 0.0739398977) +
			(ver_src_time_mod_om * 0.0123631145));

		ssnprob2_mod_rm_nodob_b1_c2_b3 := __common__(-2.842981731 +
			((integer)ssn_adl_prob * 0.4003571839) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 7.0173017902));

		fp_mod5_rm_nodob_b1_c2_b3 := __common__(-4.654329737 +
			(addprob3_mod_rm * 0.0507532121) +
			(phnprob_mod_rm * 0.0352220573) +
			((100 * (exp(ssnprob2_mod_rm_nodob_b1_c2_b3) / (1 + exp(ssnprob2_mod_rm_nodob_b1_c2_b3)))) * 0.0681023085) +
			(pk_rc_disthphoneaddr_mm_2 * 4.7946083303));

		ver_best_e_cnt_mod_rm_nodob_b1_c2_b3 := __common__(-4.724693839 +
			(pk_combo_lnamecount_mm_2 * 5.7720062632) +
			(pk_rc_phonelnamecount_mm_2 * 6.2668012547) +
			(pk_rc_addrcount_mm_2 * 4.6486531916) +
			(pk_combo_ssncount_mm_2 * 5.4755163833));

		ver_best_score_mod_rm_nodob_b1_c2_b3 := __common__(-10.23276191 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.8406117462) +
			(pk_combo_addrscore_mm_2 * 37.341722258) +
			(pk_combo_hphonescore_mm_2 * 10.093986961) +
			(pk_combo_ssnscore_mm_2 * 5.2123515529) +
			(pk_add2_address_score_mm_2 * 8.0592845506));

		ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3 := __common__(-4.518842666 +
			(pk_rc_fnamecount_nb_mm_2 * 6.0852026851) +
			(pk_rc_phonelnamecount_mm_2 * 5.5702852198) +
			(pk_rc_addrcount_nb_mm_2 * 4.5496223088));

		ver_notbest_score_mod_rm_nodob_b1_c2_b3 := __common__(-5.822234549 +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.5786375479) +
			(pk_combo_hphonescore_mm_2 * 6.2467460274) +
			(pk_combo_ssnscore_mm_2 * 4.7192039763) +
			(pk_add1_address_score_mm_2 * 5.9083645598));

		ver_element_cnt_mod_rm_nodob_b1_c2_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3)))), (100 * (exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3))))));

		ver_score_mod_rm_nodob_b1_c2_b3 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_score_mod_rm_nodob_b1_c2_b3)))), (100 * (exp(ver_notbest_score_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_score_mod_rm_nodob_b1_c2_b3))))));

		mod14_rm_nodob_b1_c2_b3 := __common__(-6.215177207 +
			(pk_did0 * -0.946397226) +
			(pk_out_st_division_lvl_mm_2 * 6.9881136358) +
			(distance_mod2_rm * -0.032360582) +
			(avm_mod_rm * 0.0362275909) +
			(age_mod3_nodob_rm * 0.0296842572) +
			(amstudent_mod_rm * 0.0382651316) +
			(velocity2_mod_rm * 0.0368890816) +
			(lres_mod_rm * -0.031528923) +
			(pk_prof_lic_cat_mm_2 * 7.1021458841) +
			(property_mod_rm * 0.0337610616) +
			(pk_estimated_income_mm_2 * 1.1899034603) +
			(ver_src_cnt_mod_rm * 0.0172222064) +
			(ver_element_cnt_mod_rm_nodob_b1_c2_b3 * 0.0066460958) +
			(ver_src_time_mod_rm * 0.017457501) +
			(pk_multi_did * 0.4745569551));

		ssnprob2_mod_xm_nodob_b1_c2_b4 := __common__(-3.338787624 +
			((integer)ssn_adl_prob * 0.2471353638) +
			(pk_ssnchar_invalid_or_recent_mm_2 * 10.935979844));

		fp_mod5_xm_nodob_b1_c2_b4 := __common__(-4.265904835 +
			(phnprob_mod_xm * 0.059811812) +
			((100 * (exp(ssnprob2_mod_xm_nodob_b1_c2_b4) / (1 + exp(ssnprob2_mod_xm_nodob_b1_c2_b4)))) * 0.0876436277) +
			(pk_rc_disthphoneaddr_mm_2 * 6.4423660123));

		ver_best_e_cnt_mod_xm_nodob_b1_c2_b4 := __common__(-4.756317234 +
			(pk_combo_fnamecount_mm * 9.1933319685) +
			(pk_rc_phonelnamecount_mm_2 * 12.429904318) +
			(pk_rc_addrcount_mm_2 * 6.6942633479));

		ver_best_score_mod_xm_nodob_b1_c2_b4 := __common__(-4.886970158 +
			(pk_combo_fnamescore * -0.345460013) +
			(pk_rc_dirsaddr_lastscore_mm_2 * 9.9855008396) +
			(pk_combo_hphonescore_mm_2 * 12.278921844) +
			(pk_add2_address_score_mm_2 * 12.657149246));

		ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4 := __common__(-4.734569941 +
			(pk_rc_fnamecount_nb_mm_2 * 7.9001890387) +
			(pk_rc_phonelnamecount_mm_2 * 9.2597351903) +
			(pk_combo_addrcount_nb_mm_2 * 4.9342545135));

		ver_notbest_score_mod_xm_nodob_b1_c2_b4 := __common__(-8.117532477 +
			(pk_fname_score * -0.257520227) +
			(pk_rc_dirsaddr_lastscore_mm_2 * 6.9240750993) +
			(pk_adl_score_mm_2 * 22.211014844) +
			(pk_combo_hphonescore_mm_2 * 9.5516169234) +
			(pk_combo_ssnscore_mm_2 * 7.1980765514) +
			(pk_add1_address_score_mm_2 * 6.7159414778));

		ver_element_cnt_mod_xm_nodob_b1_c2_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4)))), (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4))))));

		ver_score_mod_xm_nodob_b1_c2_b4 := __common__(if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_score_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_score_mod_xm_nodob_b1_c2_b4)))), (100 * (exp(ver_notbest_score_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_score_mod_xm_nodob_b1_c2_b4))))));

		mod14_xm_nodob_b1_c2_b4 := __common__(-5.635378218 +
			(pk_did0 * -1.227690175) +
			(pk_out_st_division_lvl_mm_2 * 4.3376613415) +
			(distance_mod2_xm * -0.04675975) +
			(avm_mod_xm * 0.0393814277) +
			(age_mod3_nodob_xm * 0.0529618933) +
			(amstudent_mod_xm * 0.0532381978) +
			(velocity2_mod_xm * 0.0416862639) +
			(lres_mod_xm * -0.018634794) +
			(pk_prof_lic_cat_mm_2 * 5.0513742613) +
			(property_mod_xm * 0.0387545812) +
			(pk_estimated_income_mm_2 * 4.1740377392) +
			(ver_src_cnt_mod_xm * 0.0222439238) +
			(ver_element_cnt_mod_xm_nodob_b1_c2_b4 * 0.0223563787) +
			(ver_score_mod_xm_nodob_b1_c2_b4 * 0.0108596717));

		fp_mod5_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => (100 * (exp(fp_mod5_rm_nodob_b1_c2_b3) / (1 + exp(fp_mod5_rm_nodob_b1_c2_b3)))),
																NULL));

		ssnprob2_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => (100 * (exp(ssnprob2_mod_om_nodob_b1_c2_b2) / (1 + exp(ssnprob2_mod_om_nodob_b1_c2_b2)))),
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		mod14_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))),
								 pk_segment_2 = '2 Renter' => NULL,
															  NULL));

		mod14_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))),
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  NULL));

		ssnprob2_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ssnprob2_mod_dm_nodob_b1_c2_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1_c2_b1)))),
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 NULL));

		ver_notbest_score_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_score_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_notbest_score_mod_om_nodob_b1_c2_b2)))),
												 pk_segment_2 = '2 Renter' => NULL,
																			  NULL));

		phat_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))),
					   pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))),
					   pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))),
													(exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4)))));

		ver_element_cnt_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => ver_element_cnt_mod_dm_nodob_b1_c2_b1,
											   pk_segment_2 = '1 Owner ' => NULL,
											   pk_segment_2 = '2 Renter' => NULL,
																			NULL));

		ver_best_e_cnt_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_e_cnt_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_best_e_cnt_mod_om_nodob_b1_c2_b2)))),
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		ver_best_score_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_score_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_best_score_mod_dm_nodob_b1_c2_b1)))),
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		ver_notbest_e_cnt_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3)))),
																			  NULL));

		ver_best_e_cnt_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3)))),
																		   NULL));

		ssnprob2_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => (100 * (exp(ssnprob2_mod_rm_nodob_b1_c2_b3) / (1 + exp(ssnprob2_mod_rm_nodob_b1_c2_b3)))),
																	 NULL));

		ver_notbest_e_cnt_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2)))),
												 pk_segment_2 = '2 Renter' => NULL,
																			  NULL));

		ssnprob2_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										pk_segment_2 = '1 Owner ' => NULL,
										pk_segment_2 = '2 Renter' => NULL,
																	 (100 * (exp(ssnprob2_mod_xm_nodob_b1_c2_b4) / (1 + exp(ssnprob2_mod_xm_nodob_b1_c2_b4))))));

		ver_notbest_score_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_score_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_score_mod_rm_nodob_b1_c2_b3)))),
																			  NULL));

		ver_score_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										 pk_segment_2 = '1 Owner ' => NULL,
										 pk_segment_2 = '2 Renter' => NULL,
																	  ver_score_mod_xm_nodob_b1_c2_b4));

		ver_best_e_cnt_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4))))));

		ver_best_e_cnt_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_e_cnt_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_best_e_cnt_mod_dm_nodob_b1_c2_b1)))),
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		fp_mod5_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => (100 * (exp(fp_mod5_om_nodob_b1_c2_b2) / (1 + exp(fp_mod5_om_nodob_b1_c2_b2)))),
								   pk_segment_2 = '2 Renter' => NULL,
																NULL));

		ver_element_cnt_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											   pk_segment_2 = '1 Owner ' => NULL,
											   pk_segment_2 = '2 Renter' => NULL,
																			ver_element_cnt_mod_xm_nodob_b1_c2_b4));

		ver_notbest_e_cnt_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => NULL,
																			  (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4))))));

		ver_best_score_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_score_mod_om_nodob_b1_c2_b2) / (1 + exp(ver_best_score_mod_om_nodob_b1_c2_b2)))),
											  pk_segment_2 = '2 Renter' => NULL,
																		   NULL));

		ver_best_score_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_score_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_score_mod_rm_nodob_b1_c2_b3)))),
																		   NULL));

		mod14_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => NULL,
															  (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4)))));

		ver_element_cnt_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											   pk_segment_2 = '1 Owner ' => NULL,
											   pk_segment_2 = '2 Renter' => ver_element_cnt_mod_rm_nodob_b1_c2_b3,
																			NULL));

		ver_notbest_score_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => NULL,
																			  (100 * (exp(ver_notbest_score_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_score_mod_xm_nodob_b1_c2_b4))))));

		ver_score_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => ver_score_mod_dm_nodob_b1_c2_b1,
										 pk_segment_2 = '1 Owner ' => NULL,
										 pk_segment_2 = '2 Renter' => NULL,
																	  NULL));

/*
		mod14_scr_b1 := __common__(map(pk_segment_2 = '0 Derog ' => round(((-40 * ((ln(((exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))) / (1 - (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1)))))) - ln((1 / 21))) / ln(2))) + 703)),
							pk_segment_2 = '1 Owner ' => round(((-40 * ((ln(((exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))) / (1 - (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2)))))) - ln((1 / 21))) / ln(2))) + 703)),
							pk_segment_2 = '2 Renter' => round(((-40 * ((ln(((exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))) / (1 - (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3)))))) - ln((1 / 21))) / ln(2))) + 703)),
														 round(((-40 * ((ln(((exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4))) / (1 - (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4)))))) - ln((1 / 21))) / ln(2))) + 703))));

                mod14_XM_NoDob = (exp(mod14_XM_NoDob )) / (1+exp(mod14_XM_NoDob ));
                phat = mod14_XM_NoDob;
                mod14_Scr = round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);
*/
		mod14_scr_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (((-40 * ((ln(((exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))) / (1 - (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
							pk_segment_2 = '1 Owner ' => (((-40 * ((ln(((exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))) / (1 - (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
							pk_segment_2 = '2 Renter' => (((-40 * ((ln(((exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))) / (1 - (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3)))))) - ln((1 / 20))) / ln(2))) + 700)),
														 (((-40 * ((ln(((exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4))) / (1 - (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4)))))) - ln((1 / 20))) / ln(2))) + 700))));
		mod14_scr_b1_rounded := __common__(round(mod14_scr_b1));
		ver_score_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										 pk_segment_2 = '1 Owner ' => ver_score_mod_om_nodob_b1_c2_b2,
										 pk_segment_2 = '2 Renter' => NULL,
																	  NULL));

		ver_notbest_score_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_score_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_notbest_score_mod_dm_nodob_b1_c2_b1)))),
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => NULL,
																			  NULL));

		ver_score_mod_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
										 pk_segment_2 = '1 Owner ' => NULL,
										 pk_segment_2 = '2 Renter' => ver_score_mod_rm_nodob_b1_c2_b3,
																	  NULL));

		ver_best_score_mod_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											  pk_segment_2 = '1 Owner ' => NULL,
											  pk_segment_2 = '2 Renter' => NULL,
																		   (100 * (exp(ver_best_score_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_score_mod_xm_nodob_b1_c2_b4))))));

		fp_mod5_xm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => NULL,
																(100 * (exp(fp_mod5_xm_nodob_b1_c2_b4) / (1 + exp(fp_mod5_xm_nodob_b1_c2_b4))))));

		ver_element_cnt_mod_om_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
											   pk_segment_2 = '1 Owner ' => ver_element_cnt_mod_om_nodob_b1_c2_b2,
											   pk_segment_2 = '2 Renter' => NULL,
																			NULL));

		mod14_rm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => NULL,
								 pk_segment_2 = '1 Owner ' => NULL,
								 pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))),
															  NULL));

		fp_mod5_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(fp_mod5_dm_nodob_b1_c2_b1) / (1 + exp(fp_mod5_dm_nodob_b1_c2_b1)))),
								   pk_segment_2 = '1 Owner ' => NULL,
								   pk_segment_2 = '2 Renter' => NULL,
																NULL));

		ver_notbest_e_cnt_mod_dm_nodob_b1 := __common__(map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1) / (1 + exp(ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1)))),
												 pk_segment_2 = '1 Owner ' => NULL,
												 pk_segment_2 = '2 Renter' => NULL,
																			  NULL));


		fp_mod5_rm_nodob := __common__(if((integer)dobpop = 0, fp_mod5_rm_nodob_b1, NULL));
		ssnprob2_mod_om_nodob := __common__(if((integer)dobpop = 0, ssnprob2_mod_om_nodob_b1, NULL));
		mod14_om_nodob := __common__(if((integer)dobpop = 0, mod14_om_nodob_b1, NULL));
		mod14_dm_nodob := __common__(if((integer)dobpop = 0, mod14_dm_nodob_b1, NULL));
		ssnprob2_mod_dm_nodob := __common__(if((integer)dobpop = 0, ssnprob2_mod_dm_nodob_b1, NULL));
		ver_notbest_score_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_notbest_score_mod_om_nodob_b1, NULL));

		phat_2 := __common__(if((integer)dobpop = 0, phat_b1, phat));
		ver_element_cnt_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_element_cnt_mod_dm_nodob_b1, NULL));
		ver_best_e_cnt_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_best_e_cnt_mod_om_nodob_b1, NULL));
		ver_best_score_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_best_score_mod_dm_nodob_b1, NULL));
		ver_notbest_e_cnt_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_e_cnt_mod_rm_nodob_b1, NULL));
		ver_best_e_cnt_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_best_e_cnt_mod_rm_nodob_b1, NULL));
		ssnprob2_mod_rm_nodob := __common__(if((integer)dobpop = 0, ssnprob2_mod_rm_nodob_b1, NULL));
		ver_notbest_e_cnt_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_notbest_e_cnt_mod_om_nodob_b1, NULL));
		ssnprob2_mod_xm_nodob := __common__(if((integer)dobpop = 0, ssnprob2_mod_xm_nodob_b1, NULL));
		ver_notbest_score_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_score_mod_rm_nodob_b1, NULL));
		ver_score_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_score_mod_xm_nodob_b1, NULL));
		ver_best_e_cnt_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_best_e_cnt_mod_xm_nodob_b1, NULL));
		ver_best_e_cnt_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_best_e_cnt_mod_dm_nodob_b1, NULL));
		fp_mod5_om_nodob := __common__(if((integer)dobpop = 0, fp_mod5_om_nodob_b1, NULL));
		ver_element_cnt_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_element_cnt_mod_xm_nodob_b1, NULL));
		ver_notbest_e_cnt_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_e_cnt_mod_xm_nodob_b1, NULL));
		ver_best_score_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_best_score_mod_om_nodob_b1, NULL));
		ver_best_score_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_best_score_mod_rm_nodob_b1, NULL));
		mod14_xm_nodob := __common__(if((integer)dobpop = 0, mod14_xm_nodob_b1, NULL));
		ver_element_cnt_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_element_cnt_mod_rm_nodob_b1, NULL));
		ver_notbest_score_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_score_mod_xm_nodob_b1, NULL));
		ver_score_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_score_mod_dm_nodob_b1, NULL));
		mod14_scr_2 := __common__(if((integer)dobpop = 0, mod14_scr_b1_rounded, mod14_scr_rounded));
		ver_score_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_score_mod_om_nodob_b1, NULL));
		ver_notbest_score_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_score_mod_dm_nodob_b1, NULL));
		ver_score_mod_rm_nodob := __common__(if((integer)dobpop = 0, ver_score_mod_rm_nodob_b1, NULL));
		ver_best_score_mod_xm_nodob := __common__(if((integer)dobpop = 0, ver_best_score_mod_xm_nodob_b1, NULL));
		fp_mod5_xm_nodob := __common__(if((integer)dobpop = 0, fp_mod5_xm_nodob_b1, NULL));
		ver_element_cnt_mod_om_nodob := __common__(if((integer)dobpop = 0, ver_element_cnt_mod_om_nodob_b1, NULL));
		mod14_rm_nodob := __common__(if((integer)dobpop = 0, mod14_rm_nodob_b1, NULL));
		fp_mod5_dm_nodob := __common__(if((integer)dobpop = 0, fp_mod5_dm_nodob_b1, NULL));
		ver_notbest_e_cnt_mod_dm_nodob := __common__(if((integer)dobpop = 0, ver_notbest_e_cnt_mod_dm_nodob_b1, NULL));


		RVR1003 := __common__(min(900, max(501, mod14_scr_2)));

		scored_222s := __common__(((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) OR (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag > 0) or (ssn_deceased or (boolean)(integer)truedid))))))));

		// rvr1003_2 :=  __common__(if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 AND not scored_222s, 222, RVR1003));



		/* Score Cap Begin                                                    Added 04/01/2010 PK */

		ov_ssndead := __common__(((integer1)ssnlength>0 and (integer1)rc_decsflag=1));
		ov_ssnprior := __common__(((integer1)rc_ssndobflag=1 or (integer1)rc_pwssndobflag=1));
		ov_criminal_flag := __common__((criminal_count>0));
		ov_corrections := __common__(((integer2)rc_hrisksic=2225));

		ov_impulse := __common__((( 1 * impulse_count ) > 0 ));

		// if (( RVR1003 > 680 ) and ( ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse )) then RVR1003 = 680;

		RVR1003_2 := __common__(map(
			riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid)                      	=> 222,
			rvr1003 > 680 and ( ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse ) => 680,
			rvr1003 >= 900 => 900,
			rvr1003 <= 501 => 501,
			rvr1003
		));
			

     /* Score Cap End */

		#if(RVR_DEBUG)
			self.clam := le;
			self.seq := le.seq;
			self.did := did;
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
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_ssnhighissue := rc_ssnhighissue;
			self.rc_areacodesplitflag := rc_areacodesplitflag;
			self.rc_areacodesplitdate := rc_areacodesplitdate;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_fnamecount := rc_fnamecount;
			self.rc_addrcount := rc_addrcount;
			self.rc_phonelnamecount := rc_phonelnamecount;
			self.rc_phoneaddr_phonecount := rc_phoneaddr_phonecount;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_ziptypeflag := rc_ziptypeflag;
			self.rc_statezipflag := rc_statezipflag;
			self.rc_cityzipflag := rc_cityzipflag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_fnamescore := combo_fnamescore;
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
			self.w_count := w_count;
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
			self.dobpop := dobpop;
			self.adl_score := adl_score;
			self.fname_score := fname_score;
			self.lname_change_date := lname_change_date;
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
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_price_index_valuation := add1_avm_price_index_valuation;
			self.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_automated_valuation_4 := add1_avm_automated_valuation_4;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_eda_sourced := add1_eda_sourced;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_date := add1_purchase_date;
			self.add1_built_date := add1_built_date;
			self.add1_mortgage_date := add1_mortgage_date;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_baths := add1_no_of_baths;
			self.add1_no_of_partial_baths := add1_no_of_partial_baths;
			self.add1_pop := add1_pop;
			self.property_owned_total := property_owned_total;
			self.property_owned_assessed_total := property_owned_assessed_total;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.prop1_sale_price := prop1_sale_price;
			self.prop1_prev_purchase_date := prop1_prev_purchase_date;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add2_address_score := add2_address_score;
			self.add2_lres := add2_lres;
			self.add2_avm_land_use := add2_avm_land_use;
			self.add2_avm_assessed_value_year := add2_avm_assessed_value_year;
			self.add2_avm_market_total_value := add2_avm_market_total_value;
			self.add2_avm_price_index_valuation := add2_avm_price_index_valuation;
			self.add2_avm_hedonic_valuation := add2_avm_hedonic_valuation;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_automated_valuation_2 := add2_avm_automated_valuation_2;
			self.add2_avm_automated_valuation_4 := add2_avm_automated_valuation_4;
			self.add2_sources := add2_sources;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add2_family_owned := add2_family_owned;
			self.add2_naprop := add2_naprop;
			self.add2_land_use_code := add2_land_use_code;
			self.add2_building_area := add2_building_area;
			self.add2_no_of_baths := add2_no_of_baths;
			self.add2_mortgage_date := add2_mortgage_date;
			self.add2_mortgage_type := add2_mortgage_type;
			self.add2_mortgage_due_date := add2_mortgage_due_date;
			self.add2_assessed_amount := add2_assessed_amount;
			self.add2_date_first_seen := add2_date_first_seen;
			self.add2_pop := add2_pop;
			self.add3_lres := add3_lres;
			self.add3_sources := add3_sources;
			self.add3_applicant_owned := add3_applicant_owned;
			self.add3_family_owned := add3_family_owned;
			self.add3_naprop := add3_naprop;
			self.add3_mortgage_type := add3_mortgage_type;
			self.add3_financing_type := add3_financing_type;
			self.add3_assessed_amount := add3_assessed_amount;
			self.add3_date_first_seen := add3_date_first_seen;
			self.add3_pop := add3_pop;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_prison_history := addrs_prison_history;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.nameperssn_count := nameperssn_count;
			self.header_first_seen := header_first_seen;
			self.inputssncharflag := inputssncharflag;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.ssns_per_addr := ssns_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.invalid_addrs_per_adl_c6 := invalid_addrs_per_adl_c6;
			self.infutor_first_seen := infutor_first_seen;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
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
			self.attr_num_proflic30 := attr_num_proflic30;
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
			self.liens_unrel_cj_first_seen := liens_unrel_cj_first_seen;
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
			self.criminal_last_date := criminal_last_date;
			self.felony_last_date := felony_last_date;
			self.ams_age := ams_age;
			self.ams_class := ams_class;
			self.ams_college_code := ams_college_code;
			self.ams_college_type := ams_college_type;
			self.ams_income_level_code := ams_income_level_code;
			self.prof_license_flag := prof_license_flag;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.reported_dob := reported_dob;
			self.archive_date := archive_date;
			self.today := today;
			self.sysdate := sysdate;
			self.sysyear := sysyear;
			self.in_dob2 := in_dob2;
			self.years_in_dob := years_in_dob;
			self.rc_ssnhighissue2 := rc_ssnhighissue2;
			self.years_rc_ssnhighissue := years_rc_ssnhighissue;
			self.rc_areacodesplitdate2 := rc_areacodesplitdate2;
			self.years_rc_areacodesplitdate := years_rc_areacodesplitdate;
			self.months_rc_areacodesplitdate := months_rc_areacodesplitdate;
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
			self.lname_change_date2 := lname_change_date2;
			self.years_lname_change_date := years_lname_change_date;
			self.add1_avm_recording_date2 := add1_avm_recording_date2;
			self.years_add1_avm_recording_date := years_add1_avm_recording_date;
			self.add1_avm_assessed_value_year2 := add1_avm_assessed_value_year2;
			self.years_add1_avm_assess_year := years_add1_avm_assess_year;
			self.add1_purchase_date2 := add1_purchase_date2;
			self.years_add1_purchase_date := years_add1_purchase_date;
			self.add1_built_date2 := add1_built_date2;
			self.years_add1_built_date := years_add1_built_date;
			self.add1_mortgage_date2 := add1_mortgage_date2;
			self.years_add1_mortgage_date := years_add1_mortgage_date;
			self.add1_date_first_seen2 := add1_date_first_seen2;
			self.years_add1_date_first_seen := years_add1_date_first_seen;
			self.months_add1_date_first_seen := months_add1_date_first_seen;
			self.prop1_prev_purchase_date2 := prop1_prev_purchase_date2;
			self.years_prop1_prev_purchase_date := years_prop1_prev_purchase_date;
			self.add2_avm_assessed_value_year2 := add2_avm_assessed_value_year2;
			self.years_add2_avm_assess_year := years_add2_avm_assess_year;
			self.add2_mortgage_date2 := add2_mortgage_date2;
			self.years_add2_mortgage_date := years_add2_mortgage_date;
			self.add2_mortgage_due_date2 := add2_mortgage_due_date2;
			self.years_add2_mortgage_due_date := years_add2_mortgage_due_date;
			self.add2_date_first_seen2 := add2_date_first_seen2;
			self.years_add2_date_first_seen := years_add2_date_first_seen;
			self.months_add2_date_first_seen := months_add2_date_first_seen;
			self.add3_date_first_seen2 := add3_date_first_seen2;
			self.years_add3_date_first_seen := years_add3_date_first_seen;
			self.months_add3_date_first_seen := months_add3_date_first_seen;
			self.gong_did_first_seen2 := gong_did_first_seen2;
			self.years_gong_did_first_seen := years_gong_did_first_seen;
			self.header_first_seen2 := header_first_seen2;
			self.years_header_first_seen := years_header_first_seen;
			self.infutor_first_seen2 := infutor_first_seen2;
			self.years_infutor_first_seen := years_infutor_first_seen;
			self.liens_last_unrel_date2 := liens_last_unrel_date2;
			self.years_liens_last_unrel_date := years_liens_last_unrel_date;
			self.liens_unrel_cj_first_seen2 := liens_unrel_cj_first_seen2;
			self.years_liens_unrel_cj_first_seen := years_liens_unrel_cj_first_seen;
			self.liens_unrel_lt_first_seen2 := liens_unrel_lt_first_seen2;
			self.years_liens_unrel_lt_first_seen := years_liens_unrel_lt_first_seen;
			self.liens_unrel_ot_first_seen2 := liens_unrel_ot_first_seen2;
			self.years_liens_unrel_ot_first_seen := years_liens_unrel_ot_first_seen;
			self.criminal_last_date2 := criminal_last_date2;
			self.years_criminal_last_date := years_criminal_last_date;
			self.felony_last_date2 := felony_last_date2;
			self.years_felony_last_date := years_felony_last_date;
			self.reported_dob2 := reported_dob2;
			self.years_reported_dob := years_reported_dob;
			self.source_tot_AK := source_tot_AK;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_AR := source_tot_AR;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_EB := source_tot_EB;
			self.source_tot_EM := source_tot_EM;
			self.source_tot_VO := source_tot_VO;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.source_tot_P := source_tot_P;
			self.source_tot_W := source_tot_W;
			self.source_tot_voter := source_tot_voter;
			self.source_fst_PL := source_fst_PL;
			self.source_fst_SL := source_fst_SL;
			self.source_lst_PL := source_lst_PL;
			self.source_lst_SL := source_lst_SL;
			self.source_add_P := source_add_P;
			self.source_add_PL := source_add_PL;
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
			self.phn_disconnected := phn_disconnected;
			self.phn_inval := phn_inval;
			self.phn_cellpager := phn_cellpager;
			self.phn_zipmismatch := phn_zipmismatch;
			self.phn_residential := phn_residential;
			self.ssn_priordob := ssn_priordob;
			self.ssn_inval := ssn_inval;
			self.ssn_issued18 := ssn_issued18;
			self.ssn_deceased := ssn_deceased;
			self.ssn_adl_prob := ssn_adl_prob;
			self.ssn_prob := ssn_prob;
			self.bk_flag := bk_flag;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.lien_flag := lien_flag;
			self.add1_AVM_hit := add1_AVM_hit;
			self.add1_avm_med := add1_avm_med;
			self.add1_avm_to_med_ratio := add1_avm_to_med_ratio;
			self.add_lres_month_avg := add_lres_month_avg;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_CG_2 := source_tot_CG_2;
			self.source_tot_P_2 := source_tot_P_2;
			self.source_tot_BA_2 := source_tot_BA_2;
			self.source_tot_AM_2 := source_tot_AM_2;
			self.source_tot_W_2 := source_tot_W_2;
			self.add_apt_2 := add_apt_2;
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
			self.estimated_income := estimated_income;
			self.estimated_income_2 := estimated_income_2;
			self.pk_ssnchar_invalid_or_recent := pk_ssnchar_invalid_or_recent;
			self.pk_did0 := pk_did0;
			self.pk_ssn_prob_nodob := pk_ssn_prob_nodob;
			self.pk_yr_adl_vo_first_seen := pk_yr_adl_vo_first_seen;
			self.pk_yr_adl_em_only_first_seen := pk_yr_adl_em_only_first_seen;
			self.pk_yr_adl_first_seen_max_fcra := pk_yr_adl_first_seen_max_fcra;
			self.pk_mo_adl_first_seen_max_fcra := pk_mo_adl_first_seen_max_fcra;
			self.pk_yr_lname_change_date := pk_yr_lname_change_date;
			self.pk_yr_gong_did_first_seen := pk_yr_gong_did_first_seen;
			self.pk_yr_header_first_seen := pk_yr_header_first_seen;
			self.pk_yr_infutor_first_seen := pk_yr_infutor_first_seen;
			self.pk_multi_did := pk_multi_did;
			self.pk_nas_summary := pk_nas_summary;
			self.pk_rc_dirsaddr_lastscore := pk_rc_dirsaddr_lastscore;
			self.pk_adl_score := pk_adl_score;
			self.pk_combo_fnamescore := pk_combo_fnamescore;
			self.pk_fname_score := pk_fname_score;
			self.pk_combo_addrscore := pk_combo_addrscore;
			self.pk_combo_hphonescore := pk_combo_hphonescore;
			self.pk_combo_ssnscore := pk_combo_ssnscore;
			self.pk_combo_dobscore := pk_combo_dobscore;
			self.pk_combo_fnamecount := pk_combo_fnamecount;
			self.pk_combo_fnamecount_nb := pk_combo_fnamecount_nb;
			self.pk_rc_fnamecount := pk_rc_fnamecount;
			self.pk_rc_fnamecount_nb := pk_rc_fnamecount_nb;
			self.pk_combo_lnamecount := pk_combo_lnamecount;
			self.pk_rc_phonelnamecount := pk_rc_phonelnamecount;
			self.pk_combo_addrcount_nb := pk_combo_addrcount_nb;
			self.pk_rc_addrcount := pk_rc_addrcount;
			self.pk_rc_addrcount_nb := pk_rc_addrcount_nb;
			self.pk_rc_phoneaddr_phonecount := pk_rc_phoneaddr_phonecount;
			self.pk_ver_phncount := pk_ver_phncount;
			self.pk_combo_ssncount := pk_combo_ssncount;
			self.pk_combo_dobcount := pk_combo_dobcount;
			self.pk_combo_dobcount_nb := pk_combo_dobcount_nb;
			self.pk_eq_count := pk_eq_count;
			self.pk_pos_secondary_sources := pk_pos_secondary_sources;
			self.pk_voter_flag := pk_voter_flag;
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
			self.pk_yr_lname_change_date2 := pk_yr_lname_change_date2;
			self.pk_yr_gong_did_first_seen2 := pk_yr_gong_did_first_seen2;
			self.pk_yr_header_first_seen2 := pk_yr_header_first_seen2;
			self.pk_yr_infutor_first_seen2 := pk_yr_infutor_first_seen2;
			self.pk_estimated_income := pk_estimated_income;
			self.pk_yr_adl_w_first_seen := pk_yr_adl_w_first_seen;
			self.pk_yr_adl_w_last_seen := pk_yr_adl_w_last_seen;
			self.pk_yr_add1_purchase_date := pk_yr_add1_purchase_date;
			self.pk_yr_add1_built_date := pk_yr_add1_built_date;
			self.pk_yr_add1_mortgage_date := pk_yr_add1_mortgage_date;
			self.pk_yr_add1_date_first_seen := pk_yr_add1_date_first_seen;
			self.pk_yr_prop1_prev_purchase_date := pk_yr_prop1_prev_purchase_date;
			self.pk_yr_add2_mortgage_date := pk_yr_add2_mortgage_date;
			self.pk_yr_add2_mortgage_due_date := pk_yr_add2_mortgage_due_date;
			self.pk_yr_add2_date_first_seen := pk_yr_add2_date_first_seen;
			self.pk_yr_add3_date_first_seen := pk_yr_add3_date_first_seen;
			self.pk_property_owned_assessed_total := pk_property_owned_assessed_total;
			self.pk_prop1_sale_price := pk_prop1_sale_price;
			self.pk_add1_assessed_amount := pk_add1_assessed_amount;
			self.pk_add2_assessed_amount := pk_add2_assessed_amount;
			self.pk_add3_assessed_amount := pk_add3_assessed_amount;
			self.pk_property_owned_assessed_total_2 := pk_property_owned_assessed_total_2;
			self.pk_prop1_sale_price_2 := pk_prop1_sale_price_2;
			self.pk_add1_assessed_amount_2 := pk_add1_assessed_amount_2;
			self.pk_add2_assessed_amount_2 := pk_add2_assessed_amount_2;
			self.pk_add3_assessed_amount_2 := pk_add3_assessed_amount_2;
			self.pk_add1_building_area := pk_add1_building_area;
			self.pk_add2_building_area := pk_add2_building_area;
			self.pk_yr_adl_w_first_seen2 := pk_yr_adl_w_first_seen2;
			self.pk_yr_adl_w_last_seen2 := pk_yr_adl_w_last_seen2;
			self.pk_pr_count := pk_pr_count;
			self.pk_addrs_sourced_lvl := pk_addrs_sourced_lvl;
			self.pk_naprop_level := pk_naprop_level;
			self.pk_naprop_level2_b1 := pk_naprop_level2_b1;
			self.pk_naprop_level2 := pk_naprop_level2;
			self.pk_add2_own_level := pk_add2_own_level;
			self.pk_add3_own_level := pk_add3_own_level;
			self.pk_yr_add1_purchase_date2 := pk_yr_add1_purchase_date2;
			self.pk_yr_add1_built_date2 := pk_yr_add1_built_date2;
			self.pk_yr_add1_mortgage_date2 := pk_yr_add1_mortgage_date2;
			self.pk_add1_mortgage_risk := pk_add1_mortgage_risk;
			self.pk_add1_adjustable_financing := pk_add1_adjustable_financing;
			self.pk_add1_assessed_amount2 := pk_add1_assessed_amount2;
			self.pk_yr_add1_date_first_seen2 := pk_yr_add1_date_first_seen2;
			self.pk_add1_building_area2 := pk_add1_building_area2;
			self.pk_add1_no_of_baths := pk_add1_no_of_baths;
			self.pk_add1_no_of_partial_baths := pk_add1_no_of_partial_baths;
			self.pk_property_owned_total := pk_property_owned_total;
			self.pk_prop_own_assess_tot2 := pk_prop_own_assess_tot2;
			self.pk_prop1_sale_price2 := pk_prop1_sale_price2;
			self.pk_yr_prop1_prev_purchase_date2 := pk_yr_prop1_prev_purchase_date2;
			self.pk_add2_land_use_cat := pk_add2_land_use_cat;
			self.pk_add2_land_use_risk_level := pk_add2_land_use_risk_level;
			self.pk_add2_building_area2 := pk_add2_building_area2;
			self.pk_add2_no_of_baths := pk_add2_no_of_baths;
			self.pk_yr_add2_mortgage_date2 := pk_yr_add2_mortgage_date2;
			self.pk_add2_mortgage_risk := pk_add2_mortgage_risk;
			self.pk_yr_add2_mortgage_due_date2 := pk_yr_add2_mortgage_due_date2;
			self.pk_add2_assessed_amount2 := pk_add2_assessed_amount2;
			self.pk_yr_add2_date_first_seen2 := pk_yr_add2_date_first_seen2;
			self.pk_add3_mortgage_risk := pk_add3_mortgage_risk;
			self.pk_add3_adjustable_financing := pk_add3_adjustable_financing;
			self.pk_add3_assessed_amount2 := pk_add3_assessed_amount2;
			self.pk_yr_add3_date_first_seen2 := pk_yr_add3_date_first_seen2;
			self.pk_w_count := pk_w_count;
			self.pk_yr_liens_last_unrel_date := pk_yr_liens_last_unrel_date;
			self.pk_yr_liens_unrel_cj_first_seen := pk_yr_liens_unrel_cj_first_seen;
			self.pk_yr_liens_unrel_lt_first_seen := pk_yr_liens_unrel_lt_first_seen;
			self.pk_yr_liens_unrel_ot_first_seen := pk_yr_liens_unrel_ot_first_seen;
			self.pk_yr_criminal_last_date := pk_yr_criminal_last_date;
			self.pk_yr_felony_last_date := pk_yr_felony_last_date;
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
			self.pk_yr_liens_unrel_cj_first_sn2 := pk_yr_liens_unrel_cj_first_sn2;
			self.pk_yr_liens_unrel_lt_first_sn2 := pk_yr_liens_unrel_lt_first_sn2;
			self.pk_yr_liens_unrel_ot_first_sn2 := pk_yr_liens_unrel_ot_first_sn2;
			self.pk_attr_eviction_count := pk_attr_eviction_count;
			self.pk_eviction_level := pk_eviction_level;
			self.pk_yr_criminal_last_date2 := pk_yr_criminal_last_date2;
			self.pk_yr_felony_last_date2 := pk_yr_felony_last_date2;
			self.pk_attr_total_number_derogs_3 := pk_attr_total_number_derogs_3;
			self.pk_yr_rc_ssnhighissue := pk_yr_rc_ssnhighissue;
			self.pk_yr_rc_areacodesplitdate := pk_yr_rc_areacodesplitdate;
			self.pk_add_standarization_error := pk_add_standarization_error;
			self.pk_addr_changed := pk_addr_changed;
			self.pk_unit_changed := pk_unit_changed;
			self.pk_add_standarization_flag := pk_add_standarization_flag;
			self.pk_addr_not_valid := pk_addr_not_valid;
			self.pk_corp_mil_zip := pk_corp_mil_zip;
			self.pk_area_code_split := pk_area_code_split;
			self.pk_recent_ac_split := pk_recent_ac_split;
			self.pk_phn_not_residential := pk_phn_not_residential;
			self.pk_disconnected := pk_disconnected;
			self.pk_phn_cell_pager_inval := pk_phn_cell_pager_inval;
			self.pk_yr_rc_ssnhighissue2 := pk_yr_rc_ssnhighissue2;
			self.pk_pl_sourced_level := pk_pl_sourced_level;
			self.pk_prof_lic_cat := pk_prof_lic_cat;
			self.pk_attr_num_proflic30 := pk_attr_num_proflic30;
			self.pk_attr_num_proflic_exp12 := pk_attr_num_proflic_exp12;
			self.pk_add_lres_month_avg := pk_add_lres_month_avg;
			self.pk_add1_lres := pk_add1_lres;
			self.pk_add2_lres := pk_add2_lres;
			self.pk_add3_lres := pk_add3_lres;
			self.pk_add1_lres_flag := pk_add1_lres_flag;
			self.pk_add2_lres_flag := pk_add2_lres_flag;
			self.pk_add3_lres_flag := pk_add3_lres_flag;
			self.pk_lres_flag_level := pk_lres_flag_level;
			self.pk_addrs_5yr := pk_addrs_5yr;
			self.pk_addrs_10yr := pk_addrs_10yr;
			self.pk_add_lres_month_avg2 := pk_add_lres_month_avg2;
			self.pk_nameperssn_count := pk_nameperssn_count;
			self.pk_ssns_per_adl := pk_ssns_per_adl;
			self.pk_addrs_per_adl := pk_addrs_per_adl;
			self.pk_phones_per_adl := pk_phones_per_adl;
			self.pk_adlperssn_count := pk_adlperssn_count;
			self.pk_ssns_per_addr2_b1 := pk_ssns_per_addr2_b1;
			self.pk_ssns_per_addr2_b2 := pk_ssns_per_addr2_b2;
			self.pk_ssns_per_addr2 := pk_ssns_per_addr2;
			self.pk_adls_per_phone := pk_adls_per_phone;
			self.pk_ssns_per_adl_c6 := pk_ssns_per_adl_c6;
			self.pk_ssns_per_addr_c6_b1 := pk_ssns_per_addr_c6_b1;
			self.pk_ssns_per_addr_c6_b2 := pk_ssns_per_addr_c6_b2;
			self.pk_ssns_per_addr_c6 := pk_ssns_per_addr_c6;
			self.pk_vo_addrs_per_adl := pk_vo_addrs_per_adl;
			self.pk_attr_addrs_last90 := pk_attr_addrs_last90;
			self.pk_attr_addrs_last12 := pk_attr_addrs_last12;
			self.pk_attr_addrs_last24 := pk_attr_addrs_last24;
			self.ams_class_n_b8 := ams_class_n_b8;
			self.ams_class_n_b8_2 := ams_class_n_b8_2;
			self.pk_ams_class_level_b8 := pk_ams_class_level_b8;
			self.pk_since_ams_class_year := pk_since_ams_class_year;
			self.ams_class_n := ams_class_n;
			self.pk_ams_class_level := pk_ams_class_level;
			self.pk_sl_name_match := pk_sl_name_match;
			self.pk_ams_4yr_college := pk_ams_4yr_college;
			self.pk_ams_college_type := pk_ams_college_type;
			self.pk_ams_income_level_code := pk_ams_income_level_code;
			self.pk_yr_in_dob := pk_yr_in_dob;
			self.pk_yr_reported_dob := pk_yr_reported_dob;
			self.pk_yr_in_dob2 := pk_yr_in_dob2;
			self.pk_ams_age := pk_ams_age;
			self.pk_inferred_age := pk_inferred_age;
			self.pk_yr_reported_dob2 := pk_yr_reported_dob2;
			self.pk_yr_add1_avm_recording_date := pk_yr_add1_avm_recording_date;
			self.pk_yr_add1_avm_assess_year := pk_yr_add1_avm_assess_year;
			self.pk_yr_add2_avm_assess_year := pk_yr_add2_avm_assess_year;
			self.pk_add1_avm_mkt := pk_add1_avm_mkt;
			self.pk_add1_avm_pi := pk_add1_avm_pi;
			self.pk_add1_avm_hed := pk_add1_avm_hed;
			self.pk_add1_avm_auto := pk_add1_avm_auto;
			self.pk_add1_avm_auto2 := pk_add1_avm_auto2;
			self.pk_add1_avm_auto4 := pk_add1_avm_auto4;
			self.pk_add1_avm_med := pk_add1_avm_med;
			self.pk_add2_avm_mkt := pk_add2_avm_mkt;
			self.pk_add2_avm_pi := pk_add2_avm_pi;
			self.pk_add2_avm_hed := pk_add2_avm_hed;
			self.pk_add2_avm_auto := pk_add2_avm_auto;
			self.pk_add2_avm_auto2 := pk_add2_avm_auto2;
			self.pk_add2_avm_auto4 := pk_add2_avm_auto4;
			self.pk_add1_avm_mkt_2 := pk_add1_avm_mkt_2;
			self.pk_add1_avm_pi_2 := pk_add1_avm_pi_2;
			self.pk_add1_avm_hed_2 := pk_add1_avm_hed_2;
			self.pk_add1_avm_auto_2 := pk_add1_avm_auto_2;
			self.pk_add1_avm_auto2_2 := pk_add1_avm_auto2_2;
			self.pk_add1_avm_auto4_2 := pk_add1_avm_auto4_2;
			self.pk_add1_avm_med_2 := pk_add1_avm_med_2;
			self.pk_add2_avm_mkt_2 := pk_add2_avm_mkt_2;
			self.pk_add2_avm_pi_2 := pk_add2_avm_pi_2;
			self.pk_add2_avm_hed_2 := pk_add2_avm_hed_2;
			self.pk_add2_avm_auto_2 := pk_add2_avm_auto_2;
			self.pk_add2_avm_auto2_2 := pk_add2_avm_auto2_2;
			self.pk_add2_avm_auto4_2 := pk_add2_avm_auto4_2;
			self.pk_add1_avm_to_med_ratio := pk_add1_avm_to_med_ratio;
			self.pk_add1_avm_to_med_ratio_2 := pk_add1_avm_to_med_ratio_2;
			self.pk2_add1_avm_mkt := pk2_add1_avm_mkt;
			self.pk2_add1_avm_pi := pk2_add1_avm_pi;
			self.pk2_add1_avm_hed := pk2_add1_avm_hed;
			self.pk2_add1_avm_auto2 := pk2_add1_avm_auto2;
			self.pk2_add1_avm_auto4 := pk2_add1_avm_auto4;
			self.pk_avm_auto_diff2 := pk_avm_auto_diff2;
			self.pk_avm_auto_diff4 := pk_avm_auto_diff4;
			self.pk_avm_auto_diff2_lvl := pk_avm_auto_diff2_lvl;
			self.pk_avm_auto_diff4_lvl := pk_avm_auto_diff4_lvl;
			self.pk2_add1_avm_med := pk2_add1_avm_med;
			self.pk2_add1_avm_to_med_ratio := pk2_add1_avm_to_med_ratio;
			self.pk_add2_avm_hit := pk_add2_avm_hit;
			self.pk_avm_hit_level := pk_avm_hit_level;
			self.pk2_add2_avm_mkt := pk2_add2_avm_mkt;
			self.pk2_add2_avm_pi := pk2_add2_avm_pi;
			self.pk2_add2_avm_hed := pk2_add2_avm_hed;
			self.pk2_add2_avm_auto4 := pk2_add2_avm_auto4;
			self.pk_add2_avm_auto_diff2 := pk_add2_avm_auto_diff2;
			self.pk_add2_avm_auto_diff2_lvl := pk_add2_avm_auto_diff2_lvl;
			self.pk2_yr_add1_avm_recording_date := pk2_yr_add1_avm_recording_date;
			self.pk2_yr_add1_avm_assess_year := pk2_yr_add1_avm_assess_year;
			self.pk2_yr_add2_avm_assess_year := pk2_yr_add2_avm_assess_year;
			self.pk_dist_a1toa2_2 := pk_dist_a1toa2_2;
			self.pk_dist_a1toa3_2 := pk_dist_a1toa3_2;
			self.pk_rc_disthphoneaddr_2 := pk_rc_disthphoneaddr_2;
			self.pk_out_st_division_lvl := pk_out_st_division_lvl;
			self.pk_wealth_index_2 := pk_wealth_index_2;
			self.verfst_p_2 := verfst_p_2;
			self.verlst_p_2 := verlst_p_2;
			self.veradd_p_2 := veradd_p_2;
			self.verphn_p_2 := verphn_p_2;
			self.pk_impulse_count := pk_impulse_count;
			self.pk_impulse_count_2 := pk_impulse_count_2;
			self.pk_attr_total_number_derogs_4 := pk_attr_total_number_derogs_4;
			self.pk_attr_total_number_derogs_5 := pk_attr_total_number_derogs_5;
			self.pk_attr_num_nonderogs90_3 := pk_attr_num_nonderogs90_3;
			self.pk_attr_num_nonderogs90_4 := pk_attr_num_nonderogs90_4;
			self.pk_attr_num_nonderogs90_b := pk_attr_num_nonderogs90_b;
			self.pk_adl_cat_deceased := pk_adl_cat_deceased;
			self.bs_own_rent := bs_own_rent;
			self.bs_attr_derog_flag := bs_attr_derog_flag;
			self.bs_attr_eviction_flag := bs_attr_eviction_flag;
			self.bs_attr_derog_flag2 := bs_attr_derog_flag2;
			self.pk_Segment := pk_Segment;
			self.pk_segment_2 := pk_segment_2;
			self.pk_nas_summary_mm_b1_c2_b1 := pk_nas_summary_mm_b1_c2_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b1;
			self.pk_adl_score_mm_b1_c2_b1 := pk_adl_score_mm_b1_c2_b1;
			self.pk_combo_addrscore_mm_b1_c2_b1 := pk_combo_addrscore_mm_b1_c2_b1;
			self.pk_combo_hphonescore_mm_b1_c2_b1 := pk_combo_hphonescore_mm_b1_c2_b1;
			self.pk_combo_ssnscore_mm_b1_c2_b1 := pk_combo_ssnscore_mm_b1_c2_b1;
			self.pk_combo_dobscore_mm_b1_c2_b1 := pk_combo_dobscore_mm_b1_c2_b1;
			self.pk_combo_fnamecount_mm_b1_c2_b1 := pk_combo_fnamecount_mm_b1_c2_b1;
			self.pk_rc_fnamecount_mm_b1_c2_b1 := pk_rc_fnamecount_mm_b1_c2_b1;
			self.pk_combo_lnamecount_mm_b1_c2_b1 := pk_combo_lnamecount_mm_b1_c2_b1;
			self.pk_rc_phonelnamecount_mm_b1_c2_b1 := pk_rc_phonelnamecount_mm_b1_c2_b1;
			self.pk_rc_addrcount_mm_b1_c2_b1 := pk_rc_addrcount_mm_b1_c2_b1;
			self.pk_rc_phoneaddr_phonecount_mm_b1_c2_b1 := pk_rc_phoneaddr_phonecount_mm_b1_c2_b1;
			self.pk_ver_phncount_mm_b1_c2_b1 := pk_ver_phncount_mm_b1_c2_b1;
			self.pk_combo_ssncount_mm_b1_c2_b1 := pk_combo_ssncount_mm_b1_c2_b1;
			self.pk_combo_dobcount_mm_b1_c2_b1 := pk_combo_dobcount_mm_b1_c2_b1;
			self.pk_eq_count_mm_b1_c2_b1 := pk_eq_count_mm_b1_c2_b1;
			self.pk_pos_secondary_sources_mm_b1_c2_b1 := pk_pos_secondary_sources_mm_b1_c2_b1;
			self.pk_voter_flag_mm_b1_c2_b1 := pk_voter_flag_mm_b1_c2_b1;
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
			self.pk_yr_header_first_seen2_mm_b1_c2_b1 := pk_yr_header_first_seen2_mm_b1_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b1 := pk_yr_infutor_first_seen2_mm_b1_c2_b1;
			self.pk_em_only_ver_lvl_mm_b1_c2_b1 := pk_em_only_ver_lvl_mm_b1_c2_b1;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b1 := pk_add2_em_ver_lvl_mm_b1_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
			self.pk_nas_summary_mm_b1_c2_b2 := pk_nas_summary_mm_b1_c2_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b2;
			self.pk_adl_score_mm_b1_c2_b2 := pk_adl_score_mm_b1_c2_b2;
			self.pk_combo_addrscore_mm_b1_c2_b2 := pk_combo_addrscore_mm_b1_c2_b2;
			self.pk_combo_hphonescore_mm_b1_c2_b2 := pk_combo_hphonescore_mm_b1_c2_b2;
			self.pk_combo_ssnscore_mm_b1_c2_b2 := pk_combo_ssnscore_mm_b1_c2_b2;
			self.pk_combo_dobscore_mm_b1_c2_b2 := pk_combo_dobscore_mm_b1_c2_b2;
			self.pk_combo_fnamecount_mm_b1_c2_b2 := pk_combo_fnamecount_mm_b1_c2_b2;
			self.pk_rc_fnamecount_mm_b1_c2_b2 := pk_rc_fnamecount_mm_b1_c2_b2;
			self.pk_combo_lnamecount_mm_b1_c2_b2 := pk_combo_lnamecount_mm_b1_c2_b2;
			self.pk_rc_phonelnamecount_mm_b1_c2_b2 := pk_rc_phonelnamecount_mm_b1_c2_b2;
			self.pk_rc_addrcount_mm_b1_c2_b2 := pk_rc_addrcount_mm_b1_c2_b2;
			self.pk_rc_phoneaddr_phonecount_mm_b1_c2_b2 := pk_rc_phoneaddr_phonecount_mm_b1_c2_b2;
			self.pk_ver_phncount_mm_b1_c2_b2 := pk_ver_phncount_mm_b1_c2_b2;
			self.pk_combo_ssncount_mm_b1_c2_b2 := pk_combo_ssncount_mm_b1_c2_b2;
			self.pk_combo_dobcount_mm_b1_c2_b2 := pk_combo_dobcount_mm_b1_c2_b2;
			self.pk_eq_count_mm_b1_c2_b2 := pk_eq_count_mm_b1_c2_b2;
			self.pk_pos_secondary_sources_mm_b1_c2_b2 := pk_pos_secondary_sources_mm_b1_c2_b2;
			self.pk_voter_flag_mm_b1_c2_b2 := pk_voter_flag_mm_b1_c2_b2;
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
			self.pk_yr_header_first_seen2_mm_b1_c2_b2 := pk_yr_header_first_seen2_mm_b1_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b2 := pk_yr_infutor_first_seen2_mm_b1_c2_b2;
			self.pk_em_only_ver_lvl_mm_b1_c2_b2 := pk_em_only_ver_lvl_mm_b1_c2_b2;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b2 := pk_add2_em_ver_lvl_mm_b1_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
			self.pk_nas_summary_mm_b1_c2_b3 := pk_nas_summary_mm_b1_c2_b3;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b3;
			self.pk_adl_score_mm_b1_c2_b3 := pk_adl_score_mm_b1_c2_b3;
			self.pk_combo_addrscore_mm_b1_c2_b3 := pk_combo_addrscore_mm_b1_c2_b3;
			self.pk_combo_hphonescore_mm_b1_c2_b3 := pk_combo_hphonescore_mm_b1_c2_b3;
			self.pk_combo_ssnscore_mm_b1_c2_b3 := pk_combo_ssnscore_mm_b1_c2_b3;
			self.pk_combo_dobscore_mm_b1_c2_b3 := pk_combo_dobscore_mm_b1_c2_b3;
			self.pk_combo_fnamecount_mm_b1_c2_b3 := pk_combo_fnamecount_mm_b1_c2_b3;
			self.pk_rc_fnamecount_mm_b1_c2_b3 := pk_rc_fnamecount_mm_b1_c2_b3;
			self.pk_combo_lnamecount_mm_b1_c2_b3 := pk_combo_lnamecount_mm_b1_c2_b3;
			self.pk_rc_phonelnamecount_mm_b1_c2_b3 := pk_rc_phonelnamecount_mm_b1_c2_b3;
			self.pk_rc_addrcount_mm_b1_c2_b3 := pk_rc_addrcount_mm_b1_c2_b3;
			self.pk_rc_phoneaddr_phonecount_mm_b1_c2_b3 := pk_rc_phoneaddr_phonecount_mm_b1_c2_b3;
			self.pk_ver_phncount_mm_b1_c2_b3 := pk_ver_phncount_mm_b1_c2_b3;
			self.pk_combo_ssncount_mm_b1_c2_b3 := pk_combo_ssncount_mm_b1_c2_b3;
			self.pk_combo_dobcount_mm_b1_c2_b3 := pk_combo_dobcount_mm_b1_c2_b3;
			self.pk_eq_count_mm_b1_c2_b3 := pk_eq_count_mm_b1_c2_b3;
			self.pk_pos_secondary_sources_mm_b1_c2_b3 := pk_pos_secondary_sources_mm_b1_c2_b3;
			self.pk_voter_flag_mm_b1_c2_b3 := pk_voter_flag_mm_b1_c2_b3;
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
			self.pk_yr_header_first_seen2_mm_b1_c2_b3 := pk_yr_header_first_seen2_mm_b1_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b3 := pk_yr_infutor_first_seen2_mm_b1_c2_b3;
			self.pk_em_only_ver_lvl_mm_b1_c2_b3 := pk_em_only_ver_lvl_mm_b1_c2_b3;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b3 := pk_add2_em_ver_lvl_mm_b1_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
			self.pk_nas_summary_mm_b1_c2_b4 := pk_nas_summary_mm_b1_c2_b4;
			self.pk_rc_dirsaddr_lastscore_mm_b1_c2_b4 := pk_rc_dirsaddr_lastscore_mm_b1_c2_b4;
			self.pk_adl_score_mm_b1_c2_b4 := pk_adl_score_mm_b1_c2_b4;
			self.pk_combo_addrscore_mm_b1_c2_b4 := pk_combo_addrscore_mm_b1_c2_b4;
			self.pk_combo_hphonescore_mm_b1_c2_b4 := pk_combo_hphonescore_mm_b1_c2_b4;
			self.pk_combo_ssnscore_mm_b1_c2_b4 := pk_combo_ssnscore_mm_b1_c2_b4;
			self.pk_combo_dobscore_mm_b1_c2_b4 := pk_combo_dobscore_mm_b1_c2_b4;
			self.pk_combo_fnamecount_mm_b1_c2_b4 := pk_combo_fnamecount_mm_b1_c2_b4;
			self.pk_rc_fnamecount_mm_b1_c2_b4 := pk_rc_fnamecount_mm_b1_c2_b4;
			self.pk_combo_lnamecount_mm_b1_c2_b4 := pk_combo_lnamecount_mm_b1_c2_b4;
			self.pk_rc_phonelnamecount_mm_b1_c2_b4 := pk_rc_phonelnamecount_mm_b1_c2_b4;
			self.pk_rc_addrcount_mm_b1_c2_b4 := pk_rc_addrcount_mm_b1_c2_b4;
			self.pk_rc_phoneaddr_phonecount_mm_b1_c2_b4 := pk_rc_phoneaddr_phonecount_mm_b1_c2_b4;
			self.pk_ver_phncount_mm_b1_c2_b4 := pk_ver_phncount_mm_b1_c2_b4;
			self.pk_combo_ssncount_mm_b1_c2_b4 := pk_combo_ssncount_mm_b1_c2_b4;
			self.pk_combo_dobcount_mm_b1_c2_b4 := pk_combo_dobcount_mm_b1_c2_b4;
			self.pk_eq_count_mm_b1_c2_b4 := pk_eq_count_mm_b1_c2_b4;
			self.pk_pos_secondary_sources_mm_b1_c2_b4 := pk_pos_secondary_sources_mm_b1_c2_b4;
			self.pk_voter_flag_mm_b1_c2_b4 := pk_voter_flag_mm_b1_c2_b4;
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
			self.pk_yr_header_first_seen2_mm_b1_c2_b4 := pk_yr_header_first_seen2_mm_b1_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b4 := pk_yr_infutor_first_seen2_mm_b1_c2_b4;
			self.pk_em_only_ver_lvl_mm_b1_c2_b4 := pk_em_only_ver_lvl_mm_b1_c2_b4;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b4 := pk_add2_em_ver_lvl_mm_b1_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
			self.pk_add2_pos_secondary_sources_mm_b1 := pk_add2_pos_secondary_sources_mm_b1;
			self.pk_yr_infutor_first_seen2_mm_b1 := pk_yr_infutor_first_seen2_mm_b1;
			self.pk_yr_lname_change_date2_mm_b1 := pk_yr_lname_change_date2_mm_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b1 := pk_ssnchar_invalid_or_recent_mm_b1;
			self.pk_adl_score_mm_b1 := pk_adl_score_mm_b1;
			self.pk_rc_phonelnamecount_mm_b1 := pk_rc_phonelnamecount_mm_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b1 := pk_rc_dirsaddr_lastscore_mm_b1;
			self.pk_combo_ssncount_mm_b1 := pk_combo_ssncount_mm_b1;
			self.pk_yr_adl_vo_first_seen2_mm_b1 := pk_yr_adl_vo_first_seen2_mm_b1;
			self.pk_pos_secondary_sources_mm_b1 := pk_pos_secondary_sources_mm_b1;
			self.pk_combo_addrscore_mm_b1 := pk_combo_addrscore_mm_b1;
			self.pk_voter_flag_mm_b1 := pk_voter_flag_mm_b1;
			self.pk_add2_address_score_mm_b1 := pk_add2_address_score_mm_b1;
			self.pk_rc_fnamecount_mm_b1 := pk_rc_fnamecount_mm_b1;
			self.pk_combo_ssnscore_mm_b1 := pk_combo_ssnscore_mm_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b1 := pk_lname_eda_sourced_type_lvl_mm_b1;
			self.pk_combo_dobscore_mm_b1 := pk_combo_dobscore_mm_b1;
			self.pk_ver_phncount_mm_b1 := pk_ver_phncount_mm_b1;
			self.pk_combo_dobcount_mm_b1 := pk_combo_dobcount_mm_b1;
			self.pk_rc_phoneaddr_phonecount_mm_b1 := pk_rc_phoneaddr_phonecount_mm_b1;
			self.pk_nas_summary_mm_b1 := pk_nas_summary_mm_b1;
			self.pk_rc_addrcount_mm_b1 := pk_rc_addrcount_mm_b1;
			self.pk_yr_gong_did_first_seen2_mm_b1 := pk_yr_gong_did_first_seen2_mm_b1;
			self.pk_combo_hphonescore_mm_b1 := pk_combo_hphonescore_mm_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b1 := pk_yr_adl_em_only_first_seen2_mm_b1;
			self.pk_add2_em_ver_lvl_mm_b1 := pk_add2_em_ver_lvl_mm_b1;
			self.pk_combo_lnamecount_mm_b1 := pk_combo_lnamecount_mm_b1;
			self.pk_eq_count_mm_b1 := pk_eq_count_mm_b1;
			self.pk_yr_header_first_seen2_mm_b1 := pk_yr_header_first_seen2_mm_b1;
			self.pk_em_only_ver_lvl_mm_b1 := pk_em_only_ver_lvl_mm_b1;
			self.pk_add1_address_score_mm_b1 := pk_add1_address_score_mm_b1;
			self.pk_combo_fnamecount_mm_b1 := pk_combo_fnamecount_mm_b1;
			self.pk_add2_pos_sources_mm_b1 := pk_add2_pos_sources_mm_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
			self.pk_infutor_risk_lvl_mm_b1 := pk_infutor_risk_lvl_mm_b1;
			self.pk_nas_summary_mm_b2_c2_b1 := pk_nas_summary_mm_b2_c2_b1;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b1 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b1;
			self.pk_adl_score_mm_b2_c2_b1 := pk_adl_score_mm_b2_c2_b1;
			self.pk_combo_addrscore_mm_b2_c2_b1 := pk_combo_addrscore_mm_b2_c2_b1;
			self.pk_combo_hphonescore_mm_b2_c2_b1 := pk_combo_hphonescore_mm_b2_c2_b1;
			self.pk_combo_ssnscore_mm_b2_c2_b1 := pk_combo_ssnscore_mm_b2_c2_b1;
			self.pk_combo_dobscore_mm_b2_c2_b1 := pk_combo_dobscore_mm_b2_c2_b1;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b1 := pk_combo_fnamecount_nb_mm_b2_c2_b1;
			self.pk_rc_fnamecount_nb_mm_b2_c2_b1 := pk_rc_fnamecount_nb_mm_b2_c2_b1;
			self.pk_rc_phonelnamecount_mm_b2_c2_b1 := pk_rc_phonelnamecount_mm_b2_c2_b1;
			self.pk_combo_addrcount_nb_mm_b2_c2_b1 := pk_combo_addrcount_nb_mm_b2_c2_b1;
			self.pk_rc_addrcount_nb_mm_b2_c2_b1 := pk_rc_addrcount_nb_mm_b2_c2_b1;
			self.pk_rc_phoneaddr_phonecount_mm_b2_c2_b1 := pk_rc_phoneaddr_phonecount_mm_b2_c2_b1;
			self.pk_ver_phncount_mm_b2_c2_b1 := pk_ver_phncount_mm_b2_c2_b1;
			self.pk_combo_ssncount_mm_b2_c2_b1 := pk_combo_ssncount_mm_b2_c2_b1;
			self.pk_combo_dobcount_nb_mm_b2_c2_b1 := pk_combo_dobcount_nb_mm_b2_c2_b1;
			self.pk_eq_count_mm_b2_c2_b1 := pk_eq_count_mm_b2_c2_b1;
			self.pk_pos_secondary_sources_mm_b2_c2_b1 := pk_pos_secondary_sources_mm_b2_c2_b1;
			self.pk_voter_flag_mm_b2_c2_b1 := pk_voter_flag_mm_b2_c2_b1;
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
			self.pk_yr_header_first_seen2_mm_b2_c2_b1 := pk_yr_header_first_seen2_mm_b2_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b1 := pk_yr_infutor_first_seen2_mm_b2_c2_b1;
			self.pk_em_only_ver_lvl_mm_b2_c2_b1 := pk_em_only_ver_lvl_mm_b2_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
			self.pk_nas_summary_mm_b2_c2_b2 := pk_nas_summary_mm_b2_c2_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b2 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b2;
			self.pk_adl_score_mm_b2_c2_b2 := pk_adl_score_mm_b2_c2_b2;
			self.pk_combo_addrscore_mm_b2_c2_b2 := pk_combo_addrscore_mm_b2_c2_b2;
			self.pk_combo_hphonescore_mm_b2_c2_b2 := pk_combo_hphonescore_mm_b2_c2_b2;
			self.pk_combo_ssnscore_mm_b2_c2_b2 := pk_combo_ssnscore_mm_b2_c2_b2;
			self.pk_combo_dobscore_mm_b2_c2_b2 := pk_combo_dobscore_mm_b2_c2_b2;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b2 := pk_combo_fnamecount_nb_mm_b2_c2_b2;
			self.pk_rc_fnamecount_nb_mm_b2_c2_b2 := pk_rc_fnamecount_nb_mm_b2_c2_b2;
			self.pk_rc_phonelnamecount_mm_b2_c2_b2 := pk_rc_phonelnamecount_mm_b2_c2_b2;
			self.pk_combo_addrcount_nb_mm_b2_c2_b2 := pk_combo_addrcount_nb_mm_b2_c2_b2;
			self.pk_rc_addrcount_nb_mm_b2_c2_b2 := pk_rc_addrcount_nb_mm_b2_c2_b2;
			self.pk_rc_phoneaddr_phonecount_mm_b2_c2_b2 := pk_rc_phoneaddr_phonecount_mm_b2_c2_b2;
			self.pk_ver_phncount_mm_b2_c2_b2 := pk_ver_phncount_mm_b2_c2_b2;
			self.pk_combo_ssncount_mm_b2_c2_b2 := pk_combo_ssncount_mm_b2_c2_b2;
			self.pk_combo_dobcount_nb_mm_b2_c2_b2 := pk_combo_dobcount_nb_mm_b2_c2_b2;
			self.pk_eq_count_mm_b2_c2_b2 := pk_eq_count_mm_b2_c2_b2;
			self.pk_pos_secondary_sources_mm_b2_c2_b2 := pk_pos_secondary_sources_mm_b2_c2_b2;
			self.pk_voter_flag_mm_b2_c2_b2 := pk_voter_flag_mm_b2_c2_b2;
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
			self.pk_yr_header_first_seen2_mm_b2_c2_b2 := pk_yr_header_first_seen2_mm_b2_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b2 := pk_yr_infutor_first_seen2_mm_b2_c2_b2;
			self.pk_em_only_ver_lvl_mm_b2_c2_b2 := pk_em_only_ver_lvl_mm_b2_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
			self.pk_nas_summary_mm_b2_c2_b3 := pk_nas_summary_mm_b2_c2_b3;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b3 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b3;
			self.pk_adl_score_mm_b2_c2_b3 := pk_adl_score_mm_b2_c2_b3;
			self.pk_combo_addrscore_mm_b2_c2_b3 := pk_combo_addrscore_mm_b2_c2_b3;
			self.pk_combo_hphonescore_mm_b2_c2_b3 := pk_combo_hphonescore_mm_b2_c2_b3;
			self.pk_combo_ssnscore_mm_b2_c2_b3 := pk_combo_ssnscore_mm_b2_c2_b3;
			self.pk_combo_dobscore_mm_b2_c2_b3 := pk_combo_dobscore_mm_b2_c2_b3;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b3 := pk_combo_fnamecount_nb_mm_b2_c2_b3;
			self.pk_rc_fnamecount_nb_mm_b2_c2_b3 := pk_rc_fnamecount_nb_mm_b2_c2_b3;
			self.pk_rc_phonelnamecount_mm_b2_c2_b3 := pk_rc_phonelnamecount_mm_b2_c2_b3;
			self.pk_combo_addrcount_nb_mm_b2_c2_b3 := pk_combo_addrcount_nb_mm_b2_c2_b3;
			self.pk_rc_addrcount_nb_mm_b2_c2_b3 := pk_rc_addrcount_nb_mm_b2_c2_b3;
			self.pk_rc_phoneaddr_phonecount_mm_b2_c2_b3 := pk_rc_phoneaddr_phonecount_mm_b2_c2_b3;
			self.pk_ver_phncount_mm_b2_c2_b3 := pk_ver_phncount_mm_b2_c2_b3;
			self.pk_combo_ssncount_mm_b2_c2_b3 := pk_combo_ssncount_mm_b2_c2_b3;
			self.pk_combo_dobcount_nb_mm_b2_c2_b3 := pk_combo_dobcount_nb_mm_b2_c2_b3;
			self.pk_eq_count_mm_b2_c2_b3 := pk_eq_count_mm_b2_c2_b3;
			self.pk_pos_secondary_sources_mm_b2_c2_b3 := pk_pos_secondary_sources_mm_b2_c2_b3;
			self.pk_voter_flag_mm_b2_c2_b3 := pk_voter_flag_mm_b2_c2_b3;
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
			self.pk_yr_header_first_seen2_mm_b2_c2_b3 := pk_yr_header_first_seen2_mm_b2_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b3 := pk_yr_infutor_first_seen2_mm_b2_c2_b3;
			self.pk_em_only_ver_lvl_mm_b2_c2_b3 := pk_em_only_ver_lvl_mm_b2_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
			self.pk_nas_summary_mm_b2_c2_b4 := pk_nas_summary_mm_b2_c2_b4;
			self.pk_rc_dirsaddr_lastscore_mm_b2_c2_b4 := pk_rc_dirsaddr_lastscore_mm_b2_c2_b4;
			self.pk_adl_score_mm_b2_c2_b4 := pk_adl_score_mm_b2_c2_b4;
			self.pk_combo_addrscore_mm_b2_c2_b4 := pk_combo_addrscore_mm_b2_c2_b4;
			self.pk_combo_hphonescore_mm_b2_c2_b4 := pk_combo_hphonescore_mm_b2_c2_b4;
			self.pk_combo_ssnscore_mm_b2_c2_b4 := pk_combo_ssnscore_mm_b2_c2_b4;
			self.pk_combo_dobscore_mm_b2_c2_b4 := pk_combo_dobscore_mm_b2_c2_b4;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b4 := pk_combo_fnamecount_nb_mm_b2_c2_b4;
			self.pk_rc_fnamecount_nb_mm_b2_c2_b4 := pk_rc_fnamecount_nb_mm_b2_c2_b4;
			self.pk_rc_phonelnamecount_mm_b2_c2_b4 := pk_rc_phonelnamecount_mm_b2_c2_b4;
			self.pk_combo_addrcount_nb_mm_b2_c2_b4 := pk_combo_addrcount_nb_mm_b2_c2_b4;
			self.pk_rc_addrcount_nb_mm_b2_c2_b4 := pk_rc_addrcount_nb_mm_b2_c2_b4;
			self.pk_rc_phoneaddr_phonecount_mm_b2_c2_b4 := pk_rc_phoneaddr_phonecount_mm_b2_c2_b4;
			self.pk_ver_phncount_mm_b2_c2_b4 := pk_ver_phncount_mm_b2_c2_b4;
			self.pk_combo_ssncount_mm_b2_c2_b4 := pk_combo_ssncount_mm_b2_c2_b4;
			self.pk_combo_dobcount_nb_mm_b2_c2_b4 := pk_combo_dobcount_nb_mm_b2_c2_b4;
			self.pk_eq_count_mm_b2_c2_b4 := pk_eq_count_mm_b2_c2_b4;
			self.pk_pos_secondary_sources_mm_b2_c2_b4 := pk_pos_secondary_sources_mm_b2_c2_b4;
			self.pk_voter_flag_mm_b2_c2_b4 := pk_voter_flag_mm_b2_c2_b4;
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
			self.pk_yr_header_first_seen2_mm_b2_c2_b4 := pk_yr_header_first_seen2_mm_b2_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b4 := pk_yr_infutor_first_seen2_mm_b2_c2_b4;
			self.pk_em_only_ver_lvl_mm_b2_c2_b4 := pk_em_only_ver_lvl_mm_b2_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
			self.pk_add2_pos_secondary_sources_mm_b2 := pk_add2_pos_secondary_sources_mm_b2;
			self.pk_yr_infutor_first_seen2_mm_b2 := pk_yr_infutor_first_seen2_mm_b2;
			self.pk_yr_lname_change_date2_mm_b2 := pk_yr_lname_change_date2_mm_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b2 := pk_ssnchar_invalid_or_recent_mm_b2;
			self.pk_rc_fnamecount_nb_mm_b2 := pk_rc_fnamecount_nb_mm_b2;
			self.pk_adl_score_mm_b2 := pk_adl_score_mm_b2;
			self.pk_combo_dobcount_nb_mm_b2 := pk_combo_dobcount_nb_mm_b2;
			self.pk_rc_phonelnamecount_mm_b2 := pk_rc_phonelnamecount_mm_b2;
			self.pk_combo_fnamecount_nb_mm_b2 := pk_combo_fnamecount_nb_mm_b2;
			self.pk_rc_dirsaddr_lastscore_mm_b2 := pk_rc_dirsaddr_lastscore_mm_b2;
			self.pk_combo_ssncount_mm_b2 := pk_combo_ssncount_mm_b2;
			self.pk_yr_adl_vo_first_seen2_mm_b2 := pk_yr_adl_vo_first_seen2_mm_b2;
			self.pk_pos_secondary_sources_mm_b2 := pk_pos_secondary_sources_mm_b2;
			self.pk_combo_addrscore_mm_b2 := pk_combo_addrscore_mm_b2;
			self.pk_voter_flag_mm_b2 := pk_voter_flag_mm_b2;
			self.pk_add2_address_score_mm_b2 := pk_add2_address_score_mm_b2;
			self.pk_combo_ssnscore_mm_b2 := pk_combo_ssnscore_mm_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b2 := pk_lname_eda_sourced_type_lvl_mm_b2;
			self.pk_combo_dobscore_mm_b2 := pk_combo_dobscore_mm_b2;
			self.pk_ver_phncount_mm_b2 := pk_ver_phncount_mm_b2;
			self.pk_rc_phoneaddr_phonecount_mm_b2 := pk_rc_phoneaddr_phonecount_mm_b2;
			self.pk_nas_summary_mm_b2 := pk_nas_summary_mm_b2;
			self.pk_yr_gong_did_first_seen2_mm_b2 := pk_yr_gong_did_first_seen2_mm_b2;
			self.pk_combo_hphonescore_mm_b2 := pk_combo_hphonescore_mm_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b2 := pk_yr_adl_em_only_first_seen2_mm_b2;
			self.pk_infutor_risk_lvl_nb_mm_b2 := pk_infutor_risk_lvl_nb_mm_b2;
			self.pk_combo_addrcount_nb_mm_b2 := pk_combo_addrcount_nb_mm_b2;
			self.pk_eq_count_mm_b2 := pk_eq_count_mm_b2;
			self.pk_yr_header_first_seen2_mm_b2 := pk_yr_header_first_seen2_mm_b2;
			self.pk_em_only_ver_lvl_mm_b2 := pk_em_only_ver_lvl_mm_b2;
			self.pk_add1_address_score_mm_b2 := pk_add1_address_score_mm_b2;
			self.pk_rc_addrcount_nb_mm_b2 := pk_rc_addrcount_nb_mm_b2;
			self.pk_add2_pos_sources_mm_b2 := pk_add2_pos_sources_mm_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
			self.pk_add2_pos_secondary_sources_mm := pk_add2_pos_secondary_sources_mm;
			self.pk_yr_infutor_first_seen2_mm := pk_yr_infutor_first_seen2_mm;
			self.pk_yr_lname_change_date2_mm := pk_yr_lname_change_date2_mm;
			self.pk_ssnchar_invalid_or_recent_mm := pk_ssnchar_invalid_or_recent_mm;
			self.pk_rc_fnamecount_nb_mm := pk_rc_fnamecount_nb_mm;
			self.pk_adl_score_mm := pk_adl_score_mm;
			self.pk_combo_dobcount_nb_mm := pk_combo_dobcount_nb_mm;
			self.pk_rc_phonelnamecount_mm := pk_rc_phonelnamecount_mm;
			self.pk_combo_fnamecount_nb_mm := pk_combo_fnamecount_nb_mm;
			self.pk_rc_dirsaddr_lastscore_mm := pk_rc_dirsaddr_lastscore_mm;
			self.pk_combo_ssncount_mm := pk_combo_ssncount_mm;
			self.pk_yr_adl_vo_first_seen2_mm := pk_yr_adl_vo_first_seen2_mm;
			self.pk_pos_secondary_sources_mm := pk_pos_secondary_sources_mm;
			self.pk_combo_addrscore_mm := pk_combo_addrscore_mm;
			self.pk_voter_flag_mm := pk_voter_flag_mm;
			self.pk_add2_address_score_mm := pk_add2_address_score_mm;
			self.pk_rc_fnamecount_mm := pk_rc_fnamecount_mm;
			self.pk_combo_ssnscore_mm := pk_combo_ssnscore_mm;
			self.pk_lname_eda_sourced_type_lvl_mm := pk_lname_eda_sourced_type_lvl_mm;
			self.pk_combo_dobscore_mm := pk_combo_dobscore_mm;
			self.pk_ver_phncount_mm := pk_ver_phncount_mm;
			self.pk_combo_dobcount_mm := pk_combo_dobcount_mm;
			self.pk_rc_phoneaddr_phonecount_mm := pk_rc_phoneaddr_phonecount_mm;
			self.pk_nas_summary_mm := pk_nas_summary_mm;
			self.pk_rc_addrcount_mm := pk_rc_addrcount_mm;
			self.pk_yr_gong_did_first_seen2_mm := pk_yr_gong_did_first_seen2_mm;
			self.pk_combo_hphonescore_mm := pk_combo_hphonescore_mm;
			self.pk_yr_adl_em_only_first_seen2_mm := pk_yr_adl_em_only_first_seen2_mm;
			self.pk_infutor_risk_lvl_nb_mm := pk_infutor_risk_lvl_nb_mm;
			self.pk_add2_em_ver_lvl_mm := pk_add2_em_ver_lvl_mm;
			self.pk_combo_lnamecount_mm := pk_combo_lnamecount_mm;
			self.pk_combo_addrcount_nb_mm := pk_combo_addrcount_nb_mm;
			self.pk_eq_count_mm := pk_eq_count_mm;
			self.pk_yr_header_first_seen2_mm := pk_yr_header_first_seen2_mm;
			self.pk_em_only_ver_lvl_mm := pk_em_only_ver_lvl_mm;
			self.pk_add1_address_score_mm := pk_add1_address_score_mm;
			self.pk_combo_fnamecount_mm := pk_combo_fnamecount_mm;
			self.pk_rc_addrcount_nb_mm := pk_rc_addrcount_nb_mm;
			self.pk_add2_pos_sources_mm := pk_add2_pos_sources_mm;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm := pk_yrmo_adl_f_sn_mx_fcra2_mm;
			self.pk_infutor_risk_lvl_mm := pk_infutor_risk_lvl_mm;
			self.pk_estimated_income_mm_b1 := pk_estimated_income_mm_b1;
			self.pk_yr_adl_w_first_seen2_mm_b1 := pk_yr_adl_w_first_seen2_mm_b1;
			self.pk_yr_adl_w_last_seen2_mm_b1 := pk_yr_adl_w_last_seen2_mm_b1;
			self.pk_pr_count_mm_b1 := pk_pr_count_mm_b1;
			self.pk_addrs_sourced_lvl_mm_b1 := pk_addrs_sourced_lvl_mm_b1;
			self.pk_add2_own_level_mm_b1 := pk_add2_own_level_mm_b1;
			self.pk_add3_own_level_mm_b1 := pk_add3_own_level_mm_b1;
			self.pk_naprop_level2_mm_b1 := pk_naprop_level2_mm_b1;
			self.pk_yr_add1_purchase_date2_mm_b1 := pk_yr_add1_purchase_date2_mm_b1;
			self.pk_yr_add1_built_date2_mm_b1 := pk_yr_add1_built_date2_mm_b1;
			self.pk_yr_add1_mortgage_date2_mm_b1 := pk_yr_add1_mortgage_date2_mm_b1;
			self.pk_add1_mortgage_risk_mm_b1 := pk_add1_mortgage_risk_mm_b1;
			self.pk_add1_assessed_amount2_mm_b1 := pk_add1_assessed_amount2_mm_b1;
			self.pk_yr_add1_date_first_seen2_mm_b1 := pk_yr_add1_date_first_seen2_mm_b1;
			self.pk_add1_building_area2_mm_b1 := pk_add1_building_area2_mm_b1;
			self.pk_add1_no_of_baths_mm_b1 := pk_add1_no_of_baths_mm_b1;
			self.pk_property_owned_total_mm_b1 := pk_property_owned_total_mm_b1;
			self.pk_prop_own_assess_tot2_mm_b1 := pk_prop_own_assess_tot2_mm_b1;
			self.pk_prop1_sale_price2_mm_b1 := pk_prop1_sale_price2_mm_b1;
			self.pk_add2_land_use_risk_level_mm_b1 := pk_add2_land_use_risk_level_mm_b1;
			self.pk_add2_building_area2_mm_b1 := pk_add2_building_area2_mm_b1;
			self.pk_add2_no_of_baths_mm_b1 := pk_add2_no_of_baths_mm_b1;
			self.pk_yr_add2_mortgage_date2_mm_b1 := pk_yr_add2_mortgage_date2_mm_b1;
			self.pk_add2_mortgage_risk_mm_b1 := pk_add2_mortgage_risk_mm_b1;
			self.pk_yr_add2_mortgage_due_date2_mm_b1 := pk_yr_add2_mortgage_due_date2_mm_b1;
			self.pk_add2_assessed_amount2_mm_b1 := pk_add2_assessed_amount2_mm_b1;
			self.pk_yr_add2_date_first_seen2_mm_b1 := pk_yr_add2_date_first_seen2_mm_b1;
			self.pk_add3_mortgage_risk_mm_b1 := pk_add3_mortgage_risk_mm_b1;
			self.pk_add3_assessed_amount2_mm_b1 := pk_add3_assessed_amount2_mm_b1;
			self.pk_yr_add3_date_first_seen2_mm_b1 := pk_yr_add3_date_first_seen2_mm_b1;
			self.pk_w_count_mm_b1 := pk_w_count_mm_b1;
			self.pk_bk_level_mm_b1 := pk_bk_level_mm_b1;
			self.pk_eviction_level_mm_b1 := pk_eviction_level_mm_b1;
			self.pk_lien_type_level_mm_b1 := pk_lien_type_level_mm_b1;
			self.pk_yr_liens_last_unrel_date3_mm_b1 := pk_yr_liens_last_unrel_date3_mm_b1;
			self.pk_yr_ln_unrel_cj_f_sn2_mm_b1 := pk_yr_ln_unrel_cj_f_sn2_mm_b1;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b1 := pk_yr_ln_unrel_lt_f_sn2_mm_b1;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b1 := pk_yr_ln_unrel_ot_f_sn2_mm_b1;
			self.pk_yr_criminal_last_date2_mm_b1 := pk_yr_criminal_last_date2_mm_b1;
			self.pk_yr_felony_last_date2_mm_b1 := pk_yr_felony_last_date2_mm_b1;
			self.pk_attr_total_number_derogs_mm_b1 := pk_attr_total_number_derogs_mm_b1;
			self.pk_yr_rc_ssnhighissue2_mm_b1 := pk_yr_rc_ssnhighissue2_mm_b1;
			self.pk_pl_sourced_level_mm_b1 := pk_pl_sourced_level_mm_b1;
			self.pk_prof_lic_cat_mm_b1 := pk_prof_lic_cat_mm_b1;
			self.pk_add1_lres_mm_b1 := pk_add1_lres_mm_b1;
			self.pk_add2_lres_mm_b1 := pk_add2_lres_mm_b1;
			self.pk_add3_lres_mm_b1 := pk_add3_lres_mm_b1;
			self.pk_lres_flag_level_mm_b1 := pk_lres_flag_level_mm_b1;
			self.pk_addrs_5yr_mm_b1 := pk_addrs_5yr_mm_b1;
			self.pk_addrs_10yr_mm_b1 := pk_addrs_10yr_mm_b1;
			self.pk_add_lres_month_avg2_mm_b1 := pk_add_lres_month_avg2_mm_b1;
			self.pk_nameperssn_count_mm_b1 := pk_nameperssn_count_mm_b1;
			self.pk_ssns_per_adl_mm_b1 := pk_ssns_per_adl_mm_b1;
			self.pk_addrs_per_adl_mm_b1 := pk_addrs_per_adl_mm_b1;
			self.pk_phones_per_adl_mm_b1 := pk_phones_per_adl_mm_b1;
			self.pk_adlperssn_count_mm_b1 := pk_adlperssn_count_mm_b1;
			self.pk_adls_per_phone_mm_b1 := pk_adls_per_phone_mm_b1;
			self.pk_ssns_per_adl_c6_mm_b1 := pk_ssns_per_adl_c6_mm_b1;
			self.pk_ssns_per_addr_c6_mm_b1 := pk_ssns_per_addr_c6_mm_b1;
			self.pk_attr_addrs_last90_mm_b1 := pk_attr_addrs_last90_mm_b1;
			self.pk_attr_addrs_last12_mm_b1 := pk_attr_addrs_last12_mm_b1;
			self.pk_attr_addrs_last24_mm_b1 := pk_attr_addrs_last24_mm_b1;
			self.pk_ams_class_level_mm_b1 := pk_ams_class_level_mm_b1;
			self.pk_ams_4yr_college_mm_b1 := pk_ams_4yr_college_mm_b1;
			self.pk_ams_college_type_mm_b1 := pk_ams_college_type_mm_b1;
			self.pk_ams_income_level_code_mm_b1 := pk_ams_income_level_code_mm_b1;
			self.pk_yr_in_dob2_mm_b1 := pk_yr_in_dob2_mm_b1;
			self.pk_ams_age_mm_b1 := pk_ams_age_mm_b1;
			self.pk_inferred_age_mm_b1 := pk_inferred_age_mm_b1;
			self.pk_yr_reported_dob2_mm_b1 := pk_yr_reported_dob2_mm_b1;
			self.pk_avm_hit_level_mm_b1 := pk_avm_hit_level_mm_b1;
			self.pk_avm_auto_diff2_lvl_mm_b1 := pk_avm_auto_diff2_lvl_mm_b1;
			self.pk_avm_auto_diff4_lvl_mm_b1 := pk_avm_auto_diff4_lvl_mm_b1;
			self.pk_add2_avm_auto_diff2_lvl_mm_b1 := pk_add2_avm_auto_diff2_lvl_mm_b1;
			self.pk2_add1_avm_mkt_mm_b1 := pk2_add1_avm_mkt_mm_b1;
			self.pk2_add1_avm_pi_mm_b1 := pk2_add1_avm_pi_mm_b1;
			self.pk2_add1_avm_hed_mm_b1 := pk2_add1_avm_hed_mm_b1;
			self.pk2_add1_avm_auto2_mm_b1 := pk2_add1_avm_auto2_mm_b1;
			self.pk2_add1_avm_auto4_mm_b1 := pk2_add1_avm_auto4_mm_b1;
			self.pk2_add1_avm_med_mm_b1 := pk2_add1_avm_med_mm_b1;
			self.pk2_add1_avm_to_med_ratio_mm_b1 := pk2_add1_avm_to_med_ratio_mm_b1;
			self.pk2_add2_avm_mkt_mm_b1 := pk2_add2_avm_mkt_mm_b1;
			self.pk2_add2_avm_pi_mm_b1 := pk2_add2_avm_pi_mm_b1;
			self.pk2_add2_avm_hed_mm_b1 := pk2_add2_avm_hed_mm_b1;
			self.pk2_add2_avm_auto4_mm_b1 := pk2_add2_avm_auto4_mm_b1;
			self.pk2_yr_add1_avm_rec_dt_mm_b1 := pk2_yr_add1_avm_rec_dt_mm_b1;
			self.pk2_yr_add1_avm_assess_year_mm_b1 := pk2_yr_add1_avm_assess_year_mm_b1;
			self.pk2_yr_add2_avm_assess_year_mm_b1 := pk2_yr_add2_avm_assess_year_mm_b1;
			self.pk_dist_a1toa2_mm_b1 := pk_dist_a1toa2_mm_b1;
			self.pk_dist_a1toa3_mm_b1 := pk_dist_a1toa3_mm_b1;
			self.pk_rc_disthphoneaddr_mm_b1 := pk_rc_disthphoneaddr_mm_b1;
			self.pk_out_st_division_lvl_mm_b1 := pk_out_st_division_lvl_mm_b1;
			self.pk_wealth_index_mm_b1 := pk_wealth_index_mm_b1;
			self.pk_impulse_count_mm_b1 := pk_impulse_count_mm_b1;
			self.pk_attr_num_nonderogs90_b_mm_b1 := pk_attr_num_nonderogs90_b_mm_b1;
			self.pk_ssns_per_addr2_mm_b1 := pk_ssns_per_addr2_mm_b1;
			self.pk_yr_prop1_prev_purch_dt2_mm_b1 := pk_yr_prop1_prev_purch_dt2_mm_b1;
			self.pk_estimated_income_mm_b2 := pk_estimated_income_mm_b2;
			self.pk_yr_adl_w_first_seen2_mm_b2 := pk_yr_adl_w_first_seen2_mm_b2;
			self.pk_yr_adl_w_last_seen2_mm_b2 := pk_yr_adl_w_last_seen2_mm_b2;
			self.pk_pr_count_mm_b2 := pk_pr_count_mm_b2;
			self.pk_addrs_sourced_lvl_mm_b2 := pk_addrs_sourced_lvl_mm_b2;
			self.pk_add2_own_level_mm_b2 := pk_add2_own_level_mm_b2;
			self.pk_add3_own_level_mm_b2 := pk_add3_own_level_mm_b2;
			self.pk_naprop_level2_mm_b2 := pk_naprop_level2_mm_b2;
			self.pk_yr_add1_purchase_date2_mm_b2 := pk_yr_add1_purchase_date2_mm_b2;
			self.pk_yr_add1_built_date2_mm_b2 := pk_yr_add1_built_date2_mm_b2;
			self.pk_yr_add1_mortgage_date2_mm_b2 := pk_yr_add1_mortgage_date2_mm_b2;
			self.pk_add1_mortgage_risk_mm_b2 := pk_add1_mortgage_risk_mm_b2;
			self.pk_add1_assessed_amount2_mm_b2 := pk_add1_assessed_amount2_mm_b2;
			self.pk_yr_add1_date_first_seen2_mm_b2 := pk_yr_add1_date_first_seen2_mm_b2;
			self.pk_add1_building_area2_mm_b2 := pk_add1_building_area2_mm_b2;
			self.pk_add1_no_of_baths_mm_b2 := pk_add1_no_of_baths_mm_b2;
			self.pk_property_owned_total_mm_b2 := pk_property_owned_total_mm_b2;
			self.pk_prop_own_assess_tot2_mm_b2 := pk_prop_own_assess_tot2_mm_b2;
			self.pk_prop1_sale_price2_mm_b2 := pk_prop1_sale_price2_mm_b2;
			self.pk_add2_land_use_risk_level_mm_b2 := pk_add2_land_use_risk_level_mm_b2;
			self.pk_add2_building_area2_mm_b2 := pk_add2_building_area2_mm_b2;
			self.pk_add2_no_of_baths_mm_b2 := pk_add2_no_of_baths_mm_b2;
			self.pk_yr_add2_mortgage_date2_mm_b2 := pk_yr_add2_mortgage_date2_mm_b2;
			self.pk_add2_mortgage_risk_mm_b2 := pk_add2_mortgage_risk_mm_b2;
			self.pk_yr_add2_mortgage_due_date2_mm_b2 := pk_yr_add2_mortgage_due_date2_mm_b2;
			self.pk_add2_assessed_amount2_mm_b2 := pk_add2_assessed_amount2_mm_b2;
			self.pk_yr_add2_date_first_seen2_mm_b2 := pk_yr_add2_date_first_seen2_mm_b2;
			self.pk_add3_mortgage_risk_mm_b2 := pk_add3_mortgage_risk_mm_b2;
			self.pk_add3_assessed_amount2_mm_b2 := pk_add3_assessed_amount2_mm_b2;
			self.pk_yr_add3_date_first_seen2_mm_b2 := pk_yr_add3_date_first_seen2_mm_b2;
			self.pk_w_count_mm_b2 := pk_w_count_mm_b2;
			self.pk_bk_level_mm_b2 := pk_bk_level_mm_b2;
			self.pk_eviction_level_mm_b2 := pk_eviction_level_mm_b2;
			self.pk_lien_type_level_mm_b2 := pk_lien_type_level_mm_b2;
			self.pk_yr_liens_last_unrel_date3_mm_b2 := pk_yr_liens_last_unrel_date3_mm_b2;
			self.pk_yr_ln_unrel_cj_f_sn2_mm_b2 := pk_yr_ln_unrel_cj_f_sn2_mm_b2;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b2 := pk_yr_ln_unrel_lt_f_sn2_mm_b2;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b2 := pk_yr_ln_unrel_ot_f_sn2_mm_b2;
			self.pk_yr_criminal_last_date2_mm_b2 := pk_yr_criminal_last_date2_mm_b2;
			self.pk_yr_felony_last_date2_mm_b2 := pk_yr_felony_last_date2_mm_b2;
			self.pk_attr_total_number_derogs_mm_b2 := pk_attr_total_number_derogs_mm_b2;
			self.pk_yr_rc_ssnhighissue2_mm_b2 := pk_yr_rc_ssnhighissue2_mm_b2;
			self.pk_pl_sourced_level_mm_b2 := pk_pl_sourced_level_mm_b2;
			self.pk_prof_lic_cat_mm_b2 := pk_prof_lic_cat_mm_b2;
			self.pk_add1_lres_mm_b2 := pk_add1_lres_mm_b2;
			self.pk_add2_lres_mm_b2 := pk_add2_lres_mm_b2;
			self.pk_add3_lres_mm_b2 := pk_add3_lres_mm_b2;
			self.pk_lres_flag_level_mm_b2 := pk_lres_flag_level_mm_b2;
			self.pk_addrs_5yr_mm_b2 := pk_addrs_5yr_mm_b2;
			self.pk_addrs_10yr_mm_b2 := pk_addrs_10yr_mm_b2;
			self.pk_add_lres_month_avg2_mm_b2 := pk_add_lres_month_avg2_mm_b2;
			self.pk_nameperssn_count_mm_b2 := pk_nameperssn_count_mm_b2;
			self.pk_ssns_per_adl_mm_b2 := pk_ssns_per_adl_mm_b2;
			self.pk_addrs_per_adl_mm_b2 := pk_addrs_per_adl_mm_b2;
			self.pk_phones_per_adl_mm_b2 := pk_phones_per_adl_mm_b2;
			self.pk_adlperssn_count_mm_b2 := pk_adlperssn_count_mm_b2;
			self.pk_adls_per_phone_mm_b2 := pk_adls_per_phone_mm_b2;
			self.pk_ssns_per_adl_c6_mm_b2 := pk_ssns_per_adl_c6_mm_b2;
			self.pk_ssns_per_addr_c6_mm_b2 := pk_ssns_per_addr_c6_mm_b2;
			self.pk_attr_addrs_last90_mm_b2 := pk_attr_addrs_last90_mm_b2;
			self.pk_attr_addrs_last12_mm_b2 := pk_attr_addrs_last12_mm_b2;
			self.pk_attr_addrs_last24_mm_b2 := pk_attr_addrs_last24_mm_b2;
			self.pk_ams_class_level_mm_b2 := pk_ams_class_level_mm_b2;
			self.pk_ams_4yr_college_mm_b2 := pk_ams_4yr_college_mm_b2;
			self.pk_ams_college_type_mm_b2 := pk_ams_college_type_mm_b2;
			self.pk_ams_income_level_code_mm_b2 := pk_ams_income_level_code_mm_b2;
			self.pk_yr_in_dob2_mm_b2 := pk_yr_in_dob2_mm_b2;
			self.pk_ams_age_mm_b2 := pk_ams_age_mm_b2;
			self.pk_inferred_age_mm_b2 := pk_inferred_age_mm_b2;
			self.pk_yr_reported_dob2_mm_b2 := pk_yr_reported_dob2_mm_b2;
			self.pk_avm_hit_level_mm_b2 := pk_avm_hit_level_mm_b2;
			self.pk_avm_auto_diff2_lvl_mm_b2 := pk_avm_auto_diff2_lvl_mm_b2;
			self.pk_avm_auto_diff4_lvl_mm_b2 := pk_avm_auto_diff4_lvl_mm_b2;
			self.pk_add2_avm_auto_diff2_lvl_mm_b2 := pk_add2_avm_auto_diff2_lvl_mm_b2;
			self.pk2_add1_avm_mkt_mm_b2 := pk2_add1_avm_mkt_mm_b2;
			self.pk2_add1_avm_pi_mm_b2 := pk2_add1_avm_pi_mm_b2;
			self.pk2_add1_avm_hed_mm_b2 := pk2_add1_avm_hed_mm_b2;
			self.pk2_add1_avm_auto2_mm_b2 := pk2_add1_avm_auto2_mm_b2;
			self.pk2_add1_avm_auto4_mm_b2 := pk2_add1_avm_auto4_mm_b2;
			self.pk2_add1_avm_med_mm_b2 := pk2_add1_avm_med_mm_b2;
			self.pk2_add1_avm_to_med_ratio_mm_b2 := pk2_add1_avm_to_med_ratio_mm_b2;
			self.pk2_add2_avm_mkt_mm_b2 := pk2_add2_avm_mkt_mm_b2;
			self.pk2_add2_avm_pi_mm_b2 := pk2_add2_avm_pi_mm_b2;
			self.pk2_add2_avm_hed_mm_b2 := pk2_add2_avm_hed_mm_b2;
			self.pk2_add2_avm_auto4_mm_b2 := pk2_add2_avm_auto4_mm_b2;
			self.pk2_yr_add1_avm_rec_dt_mm_b2 := pk2_yr_add1_avm_rec_dt_mm_b2;
			self.pk2_yr_add1_avm_assess_year_mm_b2 := pk2_yr_add1_avm_assess_year_mm_b2;
			self.pk2_yr_add2_avm_assess_year_mm_b2 := pk2_yr_add2_avm_assess_year_mm_b2;
			self.pk_dist_a1toa2_mm_b2 := pk_dist_a1toa2_mm_b2;
			self.pk_dist_a1toa3_mm_b2 := pk_dist_a1toa3_mm_b2;
			self.pk_rc_disthphoneaddr_mm_b2 := pk_rc_disthphoneaddr_mm_b2;
			self.pk_out_st_division_lvl_mm_b2 := pk_out_st_division_lvl_mm_b2;
			self.pk_wealth_index_mm_b2 := pk_wealth_index_mm_b2;
			self.pk_impulse_count_mm_b2 := pk_impulse_count_mm_b2;
			self.pk_attr_num_nonderogs90_b_mm_b2 := pk_attr_num_nonderogs90_b_mm_b2;
			self.pk_ssns_per_addr2_mm_b2 := pk_ssns_per_addr2_mm_b2;
			self.pk_yr_prop1_prev_purch_dt2_mm_b2 := pk_yr_prop1_prev_purch_dt2_mm_b2;
			self.pk_estimated_income_mm_b3 := pk_estimated_income_mm_b3;
			self.pk_yr_adl_w_first_seen2_mm_b3 := pk_yr_adl_w_first_seen2_mm_b3;
			self.pk_yr_adl_w_last_seen2_mm_b3 := pk_yr_adl_w_last_seen2_mm_b3;
			self.pk_pr_count_mm_b3 := pk_pr_count_mm_b3;
			self.pk_addrs_sourced_lvl_mm_b3 := pk_addrs_sourced_lvl_mm_b3;
			self.pk_add2_own_level_mm_b3 := pk_add2_own_level_mm_b3;
			self.pk_add3_own_level_mm_b3 := pk_add3_own_level_mm_b3;
			self.pk_naprop_level2_mm_b3 := pk_naprop_level2_mm_b3;
			self.pk_yr_add1_purchase_date2_mm_b3 := pk_yr_add1_purchase_date2_mm_b3;
			self.pk_yr_add1_built_date2_mm_b3 := pk_yr_add1_built_date2_mm_b3;
			self.pk_yr_add1_mortgage_date2_mm_b3 := pk_yr_add1_mortgage_date2_mm_b3;
			self.pk_add1_mortgage_risk_mm_b3 := pk_add1_mortgage_risk_mm_b3;
			self.pk_add1_assessed_amount2_mm_b3 := pk_add1_assessed_amount2_mm_b3;
			self.pk_yr_add1_date_first_seen2_mm_b3 := pk_yr_add1_date_first_seen2_mm_b3;
			self.pk_add1_building_area2_mm_b3 := pk_add1_building_area2_mm_b3;
			self.pk_add1_no_of_baths_mm_b3 := pk_add1_no_of_baths_mm_b3;
			self.pk_property_owned_total_mm_b3 := pk_property_owned_total_mm_b3;
			self.pk_prop_own_assess_tot2_mm_b3 := pk_prop_own_assess_tot2_mm_b3;
			self.pk_prop1_sale_price2_mm_b3 := pk_prop1_sale_price2_mm_b3;
			self.pk_add2_land_use_risk_level_mm_b3 := pk_add2_land_use_risk_level_mm_b3;
			self.pk_add2_building_area2_mm_b3 := pk_add2_building_area2_mm_b3;
			self.pk_add2_no_of_baths_mm_b3 := pk_add2_no_of_baths_mm_b3;
			self.pk_yr_add2_mortgage_date2_mm_b3 := pk_yr_add2_mortgage_date2_mm_b3;
			self.pk_add2_mortgage_risk_mm_b3 := pk_add2_mortgage_risk_mm_b3;
			self.pk_yr_add2_mortgage_due_date2_mm_b3 := pk_yr_add2_mortgage_due_date2_mm_b3;
			self.pk_add2_assessed_amount2_mm_b3 := pk_add2_assessed_amount2_mm_b3;
			self.pk_yr_add2_date_first_seen2_mm_b3 := pk_yr_add2_date_first_seen2_mm_b3;
			self.pk_add3_mortgage_risk_mm_b3 := pk_add3_mortgage_risk_mm_b3;
			self.pk_add3_assessed_amount2_mm_b3 := pk_add3_assessed_amount2_mm_b3;
			self.pk_yr_add3_date_first_seen2_mm_b3 := pk_yr_add3_date_first_seen2_mm_b3;
			self.pk_w_count_mm_b3 := pk_w_count_mm_b3;
			self.pk_bk_level_mm_b3 := pk_bk_level_mm_b3;
			self.pk_eviction_level_mm_b3 := pk_eviction_level_mm_b3;
			self.pk_lien_type_level_mm_b3 := pk_lien_type_level_mm_b3;
			self.pk_yr_liens_last_unrel_date3_mm_b3 := pk_yr_liens_last_unrel_date3_mm_b3;
			self.pk_yr_ln_unrel_cj_f_sn2_mm_b3 := pk_yr_ln_unrel_cj_f_sn2_mm_b3;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b3 := pk_yr_ln_unrel_lt_f_sn2_mm_b3;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b3 := pk_yr_ln_unrel_ot_f_sn2_mm_b3;
			self.pk_yr_criminal_last_date2_mm_b3 := pk_yr_criminal_last_date2_mm_b3;
			self.pk_yr_felony_last_date2_mm_b3 := pk_yr_felony_last_date2_mm_b3;
			self.pk_attr_total_number_derogs_mm_b3 := pk_attr_total_number_derogs_mm_b3;
			self.pk_yr_rc_ssnhighissue2_mm_b3 := pk_yr_rc_ssnhighissue2_mm_b3;
			self.pk_pl_sourced_level_mm_b3 := pk_pl_sourced_level_mm_b3;
			self.pk_prof_lic_cat_mm_b3 := pk_prof_lic_cat_mm_b3;
			self.pk_add1_lres_mm_b3 := pk_add1_lres_mm_b3;
			self.pk_add2_lres_mm_b3 := pk_add2_lres_mm_b3;
			self.pk_add3_lres_mm_b3 := pk_add3_lres_mm_b3;
			self.pk_lres_flag_level_mm_b3 := pk_lres_flag_level_mm_b3;
			self.pk_addrs_5yr_mm_b3 := pk_addrs_5yr_mm_b3;
			self.pk_addrs_10yr_mm_b3 := pk_addrs_10yr_mm_b3;
			self.pk_add_lres_month_avg2_mm_b3 := pk_add_lres_month_avg2_mm_b3;
			self.pk_nameperssn_count_mm_b3 := pk_nameperssn_count_mm_b3;
			self.pk_ssns_per_adl_mm_b3 := pk_ssns_per_adl_mm_b3;
			self.pk_addrs_per_adl_mm_b3 := pk_addrs_per_adl_mm_b3;
			self.pk_phones_per_adl_mm_b3 := pk_phones_per_adl_mm_b3;
			self.pk_adlperssn_count_mm_b3 := pk_adlperssn_count_mm_b3;
			self.pk_adls_per_phone_mm_b3 := pk_adls_per_phone_mm_b3;
			self.pk_ssns_per_adl_c6_mm_b3 := pk_ssns_per_adl_c6_mm_b3;
			self.pk_ssns_per_addr_c6_mm_b3 := pk_ssns_per_addr_c6_mm_b3;
			self.pk_attr_addrs_last90_mm_b3 := pk_attr_addrs_last90_mm_b3;
			self.pk_attr_addrs_last12_mm_b3 := pk_attr_addrs_last12_mm_b3;
			self.pk_attr_addrs_last24_mm_b3 := pk_attr_addrs_last24_mm_b3;
			self.pk_ams_class_level_mm_b3 := pk_ams_class_level_mm_b3;
			self.pk_ams_4yr_college_mm_b3 := pk_ams_4yr_college_mm_b3;
			self.pk_ams_college_type_mm_b3 := pk_ams_college_type_mm_b3;
			self.pk_ams_income_level_code_mm_b3 := pk_ams_income_level_code_mm_b3;
			self.pk_yr_in_dob2_mm_b3 := pk_yr_in_dob2_mm_b3;
			self.pk_ams_age_mm_b3 := pk_ams_age_mm_b3;
			self.pk_inferred_age_mm_b3 := pk_inferred_age_mm_b3;
			self.pk_yr_reported_dob2_mm_b3 := pk_yr_reported_dob2_mm_b3;
			self.pk_avm_hit_level_mm_b3 := pk_avm_hit_level_mm_b3;
			self.pk_avm_auto_diff2_lvl_mm_b3 := pk_avm_auto_diff2_lvl_mm_b3;
			self.pk_avm_auto_diff4_lvl_mm_b3 := pk_avm_auto_diff4_lvl_mm_b3;
			self.pk_add2_avm_auto_diff2_lvl_mm_b3 := pk_add2_avm_auto_diff2_lvl_mm_b3;
			self.pk2_add1_avm_mkt_mm_b3 := pk2_add1_avm_mkt_mm_b3;
			self.pk2_add1_avm_pi_mm_b3 := pk2_add1_avm_pi_mm_b3;
			self.pk2_add1_avm_hed_mm_b3 := pk2_add1_avm_hed_mm_b3;
			self.pk2_add1_avm_auto2_mm_b3 := pk2_add1_avm_auto2_mm_b3;
			self.pk2_add1_avm_auto4_mm_b3 := pk2_add1_avm_auto4_mm_b3;
			self.pk2_add1_avm_med_mm_b3 := pk2_add1_avm_med_mm_b3;
			self.pk2_add1_avm_to_med_ratio_mm_b3 := pk2_add1_avm_to_med_ratio_mm_b3;
			self.pk2_add2_avm_mkt_mm_b3 := pk2_add2_avm_mkt_mm_b3;
			self.pk2_add2_avm_pi_mm_b3 := pk2_add2_avm_pi_mm_b3;
			self.pk2_add2_avm_hed_mm_b3 := pk2_add2_avm_hed_mm_b3;
			self.pk2_add2_avm_auto4_mm_b3 := pk2_add2_avm_auto4_mm_b3;
			self.pk2_yr_add1_avm_rec_dt_mm_b3 := pk2_yr_add1_avm_rec_dt_mm_b3;
			self.pk2_yr_add1_avm_assess_year_mm_b3 := pk2_yr_add1_avm_assess_year_mm_b3;
			self.pk2_yr_add2_avm_assess_year_mm_b3 := pk2_yr_add2_avm_assess_year_mm_b3;
			self.pk_dist_a1toa2_mm_b3 := pk_dist_a1toa2_mm_b3;
			self.pk_dist_a1toa3_mm_b3 := pk_dist_a1toa3_mm_b3;
			self.pk_rc_disthphoneaddr_mm_b3 := pk_rc_disthphoneaddr_mm_b3;
			self.pk_out_st_division_lvl_mm_b3 := pk_out_st_division_lvl_mm_b3;
			self.pk_wealth_index_mm_b3 := pk_wealth_index_mm_b3;
			self.pk_impulse_count_mm_b3 := pk_impulse_count_mm_b3;
			self.pk_attr_num_nonderogs90_b_mm_b3 := pk_attr_num_nonderogs90_b_mm_b3;
			self.pk_ssns_per_addr2_mm_b3 := pk_ssns_per_addr2_mm_b3;
			self.pk_yr_prop1_prev_purch_dt2_mm_b3 := pk_yr_prop1_prev_purch_dt2_mm_b3;
			self.pk_estimated_income_mm_b4 := pk_estimated_income_mm_b4;
			self.pk_yr_adl_w_first_seen2_mm_b4 := pk_yr_adl_w_first_seen2_mm_b4;
			self.pk_yr_adl_w_last_seen2_mm_b4 := pk_yr_adl_w_last_seen2_mm_b4;
			self.pk_pr_count_mm_b4 := pk_pr_count_mm_b4;
			self.pk_addrs_sourced_lvl_mm_b4 := pk_addrs_sourced_lvl_mm_b4;
			self.pk_add2_own_level_mm_b4 := pk_add2_own_level_mm_b4;
			self.pk_add3_own_level_mm_b4 := pk_add3_own_level_mm_b4;
			self.pk_naprop_level2_mm_b4 := pk_naprop_level2_mm_b4;
			self.pk_yr_add1_purchase_date2_mm_b4 := pk_yr_add1_purchase_date2_mm_b4;
			self.pk_yr_add1_built_date2_mm_b4 := pk_yr_add1_built_date2_mm_b4;
			self.pk_yr_add1_mortgage_date2_mm_b4 := pk_yr_add1_mortgage_date2_mm_b4;
			self.pk_add1_mortgage_risk_mm_b4 := pk_add1_mortgage_risk_mm_b4;
			self.pk_add1_assessed_amount2_mm_b4 := pk_add1_assessed_amount2_mm_b4;
			self.pk_yr_add1_date_first_seen2_mm_b4 := pk_yr_add1_date_first_seen2_mm_b4;
			self.pk_add1_building_area2_mm_b4 := pk_add1_building_area2_mm_b4;
			self.pk_add1_no_of_baths_mm_b4 := pk_add1_no_of_baths_mm_b4;
			self.pk_property_owned_total_mm_b4 := pk_property_owned_total_mm_b4;
			self.pk_prop_own_assess_tot2_mm_b4 := pk_prop_own_assess_tot2_mm_b4;
			self.pk_prop1_sale_price2_mm_b4 := pk_prop1_sale_price2_mm_b4;
			self.pk_add2_land_use_risk_level_mm_b4 := pk_add2_land_use_risk_level_mm_b4;
			self.pk_add2_building_area2_mm_b4 := pk_add2_building_area2_mm_b4;
			self.pk_add2_no_of_baths_mm_b4 := pk_add2_no_of_baths_mm_b4;
			self.pk_yr_add2_mortgage_date2_mm_b4 := pk_yr_add2_mortgage_date2_mm_b4;
			self.pk_add2_mortgage_risk_mm_b4 := pk_add2_mortgage_risk_mm_b4;
			self.pk_yr_add2_mortgage_due_date2_mm_b4 := pk_yr_add2_mortgage_due_date2_mm_b4;
			self.pk_add2_assessed_amount2_mm_b4 := pk_add2_assessed_amount2_mm_b4;
			self.pk_yr_add2_date_first_seen2_mm_b4 := pk_yr_add2_date_first_seen2_mm_b4;
			self.pk_add3_mortgage_risk_mm_b4 := pk_add3_mortgage_risk_mm_b4;
			self.pk_add3_assessed_amount2_mm_b4 := pk_add3_assessed_amount2_mm_b4;
			self.pk_yr_add3_date_first_seen2_mm_b4 := pk_yr_add3_date_first_seen2_mm_b4;
			self.pk_w_count_mm_b4 := pk_w_count_mm_b4;
			self.pk_bk_level_mm_b4 := pk_bk_level_mm_b4;
			self.pk_eviction_level_mm_b4 := pk_eviction_level_mm_b4;
			self.pk_lien_type_level_mm_b4 := pk_lien_type_level_mm_b4;
			self.pk_yr_liens_last_unrel_date3_mm_b4 := pk_yr_liens_last_unrel_date3_mm_b4;
			self.pk_yr_ln_unrel_cj_f_sn2_mm_b4 := pk_yr_ln_unrel_cj_f_sn2_mm_b4;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_b4 := pk_yr_ln_unrel_lt_f_sn2_mm_b4;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_b4 := pk_yr_ln_unrel_ot_f_sn2_mm_b4;
			self.pk_yr_criminal_last_date2_mm_b4 := pk_yr_criminal_last_date2_mm_b4;
			self.pk_yr_felony_last_date2_mm_b4 := pk_yr_felony_last_date2_mm_b4;
			self.pk_attr_total_number_derogs_mm_b4 := pk_attr_total_number_derogs_mm_b4;
			self.pk_yr_rc_ssnhighissue2_mm_b4 := pk_yr_rc_ssnhighissue2_mm_b4;
			self.pk_pl_sourced_level_mm_b4 := pk_pl_sourced_level_mm_b4;
			self.pk_prof_lic_cat_mm_b4 := pk_prof_lic_cat_mm_b4;
			self.pk_add1_lres_mm_b4 := pk_add1_lres_mm_b4;
			self.pk_add2_lres_mm_b4 := pk_add2_lres_mm_b4;
			self.pk_add3_lres_mm_b4 := pk_add3_lres_mm_b4;
			self.pk_lres_flag_level_mm_b4 := pk_lres_flag_level_mm_b4;
			self.pk_addrs_5yr_mm_b4 := pk_addrs_5yr_mm_b4;
			self.pk_addrs_10yr_mm_b4 := pk_addrs_10yr_mm_b4;
			self.pk_add_lres_month_avg2_mm_b4 := pk_add_lres_month_avg2_mm_b4;
			self.pk_nameperssn_count_mm_b4 := pk_nameperssn_count_mm_b4;
			self.pk_ssns_per_adl_mm_b4 := pk_ssns_per_adl_mm_b4;
			self.pk_addrs_per_adl_mm_b4 := pk_addrs_per_adl_mm_b4;
			self.pk_phones_per_adl_mm_b4 := pk_phones_per_adl_mm_b4;
			self.pk_adlperssn_count_mm_b4 := pk_adlperssn_count_mm_b4;
			self.pk_adls_per_phone_mm_b4 := pk_adls_per_phone_mm_b4;
			self.pk_ssns_per_adl_c6_mm_b4 := pk_ssns_per_adl_c6_mm_b4;
			self.pk_ssns_per_addr_c6_mm_b4 := pk_ssns_per_addr_c6_mm_b4;
			self.pk_attr_addrs_last90_mm_b4 := pk_attr_addrs_last90_mm_b4;
			self.pk_attr_addrs_last12_mm_b4 := pk_attr_addrs_last12_mm_b4;
			self.pk_attr_addrs_last24_mm_b4 := pk_attr_addrs_last24_mm_b4;
			self.pk_ams_class_level_mm_b4 := pk_ams_class_level_mm_b4;
			self.pk_ams_4yr_college_mm_b4 := pk_ams_4yr_college_mm_b4;
			self.pk_ams_college_type_mm_b4 := pk_ams_college_type_mm_b4;
			self.pk_ams_income_level_code_mm_b4 := pk_ams_income_level_code_mm_b4;
			self.pk_yr_in_dob2_mm_b4 := pk_yr_in_dob2_mm_b4;
			self.pk_ams_age_mm_b4 := pk_ams_age_mm_b4;
			self.pk_inferred_age_mm_b4 := pk_inferred_age_mm_b4;
			self.pk_yr_reported_dob2_mm_b4 := pk_yr_reported_dob2_mm_b4;
			self.pk_avm_hit_level_mm_b4 := pk_avm_hit_level_mm_b4;
			self.pk_avm_auto_diff2_lvl_mm_b4 := pk_avm_auto_diff2_lvl_mm_b4;
			self.pk_avm_auto_diff4_lvl_mm_b4 := pk_avm_auto_diff4_lvl_mm_b4;
			self.pk_add2_avm_auto_diff2_lvl_mm_b4 := pk_add2_avm_auto_diff2_lvl_mm_b4;
			self.pk2_add1_avm_mkt_mm_b4 := pk2_add1_avm_mkt_mm_b4;
			self.pk2_add1_avm_pi_mm_b4 := pk2_add1_avm_pi_mm_b4;
			self.pk2_add1_avm_hed_mm_b4 := pk2_add1_avm_hed_mm_b4;
			self.pk2_add1_avm_auto2_mm_b4 := pk2_add1_avm_auto2_mm_b4;
			self.pk2_add1_avm_auto4_mm_b4 := pk2_add1_avm_auto4_mm_b4;
			self.pk2_add1_avm_med_mm_b4 := pk2_add1_avm_med_mm_b4;
			self.pk2_add1_avm_to_med_ratio_mm_b4 := pk2_add1_avm_to_med_ratio_mm_b4;
			self.pk2_add2_avm_mkt_mm_b4 := pk2_add2_avm_mkt_mm_b4;
			self.pk2_add2_avm_pi_mm_b4 := pk2_add2_avm_pi_mm_b4;
			self.pk2_add2_avm_hed_mm_b4 := pk2_add2_avm_hed_mm_b4;
			self.pk2_add2_avm_auto4_mm_b4 := pk2_add2_avm_auto4_mm_b4;
			self.pk2_yr_add1_avm_rec_dt_mm_b4 := pk2_yr_add1_avm_rec_dt_mm_b4;
			self.pk2_yr_add1_avm_assess_year_mm_b4 := pk2_yr_add1_avm_assess_year_mm_b4;
			self.pk2_yr_add2_avm_assess_year_mm_b4 := pk2_yr_add2_avm_assess_year_mm_b4;
			self.pk_dist_a1toa2_mm_b4 := pk_dist_a1toa2_mm_b4;
			self.pk_dist_a1toa3_mm_b4 := pk_dist_a1toa3_mm_b4;
			self.pk_rc_disthphoneaddr_mm_b4 := pk_rc_disthphoneaddr_mm_b4;
			self.pk_out_st_division_lvl_mm_b4 := pk_out_st_division_lvl_mm_b4;
			self.pk_wealth_index_mm_b4 := pk_wealth_index_mm_b4;
			self.pk_impulse_count_mm_b4 := pk_impulse_count_mm_b4;
			self.pk_attr_num_nonderogs90_b_mm_b4 := pk_attr_num_nonderogs90_b_mm_b4;
			self.pk_ssns_per_addr2_mm_b4 := pk_ssns_per_addr2_mm_b4;
			self.pk_yr_prop1_prev_purch_dt2_mm_b4 := pk_yr_prop1_prev_purch_dt2_mm_b4;
			self.pk_yr_criminal_last_date2_mm := pk_yr_criminal_last_date2_mm;
			self.pk_prop_own_assess_tot2_mm := pk_prop_own_assess_tot2_mm;
			self.pk_yr_add1_date_first_seen2_mm := pk_yr_add1_date_first_seen2_mm;
			self.pk2_add2_avm_mkt_mm := pk2_add2_avm_mkt_mm;
			self.pk_attr_addrs_last90_mm := pk_attr_addrs_last90_mm;
			self.pk_nameperssn_count_mm := pk_nameperssn_count_mm;
			self.pk_yr_add2_mortgage_date2_mm := pk_yr_add2_mortgage_date2_mm;
			self.pk_adls_per_phone_mm := pk_adls_per_phone_mm;
			self.pk_ssns_per_addr2_mm := pk_ssns_per_addr2_mm;
			self.pk_property_owned_total_mm := pk_property_owned_total_mm;
			self.pk_ams_class_level_mm := pk_ams_class_level_mm;
			self.pk_attr_addrs_last12_mm := pk_attr_addrs_last12_mm;
			self.pk_add2_land_use_risk_level_mm := pk_add2_land_use_risk_level_mm;
			self.pk_yr_add2_date_first_seen2_mm := pk_yr_add2_date_first_seen2_mm;
			self.pk_adlperssn_count_mm := pk_adlperssn_count_mm;
			self.pk2_add2_avm_hed_mm := pk2_add2_avm_hed_mm;
			self.pk_avm_auto_diff4_lvl_mm := pk_avm_auto_diff4_lvl_mm;
			self.pk_ams_college_type_mm := pk_ams_college_type_mm;
			self.pk_w_count_mm := pk_w_count_mm;
			self.pk_yr_add3_date_first_seen2_mm := pk_yr_add3_date_first_seen2_mm;
			self.pk_add2_own_level_mm := pk_add2_own_level_mm;
			self.pk_add2_lres_mm := pk_add2_lres_mm;
			self.pk_addrs_sourced_lvl_mm := pk_addrs_sourced_lvl_mm;
			self.pk_add_lres_month_avg2_mm := pk_add_lres_month_avg2_mm;
			self.pk_rc_disthphoneaddr_mm := pk_rc_disthphoneaddr_mm;
			self.pk_add1_lres_mm := pk_add1_lres_mm;
			self.pk_attr_total_number_derogs_mm := pk_attr_total_number_derogs_mm;
			self.pk_addrs_per_adl_mm := pk_addrs_per_adl_mm;
			self.pk_naprop_level2_mm := pk_naprop_level2_mm;
			self.pk2_add1_avm_mkt_mm := pk2_add1_avm_mkt_mm;
			self.pk_yr_reported_dob2_mm := pk_yr_reported_dob2_mm;
			self.pk_prop1_sale_price2_mm := pk_prop1_sale_price2_mm;
			self.pk2_add1_avm_auto4_mm := pk2_add1_avm_auto4_mm;
			self.pk_ssns_per_adl_mm := pk_ssns_per_adl_mm;
			self.pk_yr_adl_w_last_seen2_mm := pk_yr_adl_w_last_seen2_mm;
			self.pk_add2_no_of_baths_mm := pk_add2_no_of_baths_mm;
			self.pk_ams_income_level_code_mm := pk_ams_income_level_code_mm;
			self.pk_yr_ln_unrel_ot_f_sn2_mm := pk_yr_ln_unrel_ot_f_sn2_mm;
			self.pk_add1_building_area2_mm := pk_add1_building_area2_mm;
			self.pk_pr_count_mm := pk_pr_count_mm;
			self.pk_avm_auto_diff2_lvl_mm := pk_avm_auto_diff2_lvl_mm;
			self.pk_inferred_age_mm := pk_inferred_age_mm;
			self.pk2_yr_add1_avm_assess_year_mm := pk2_yr_add1_avm_assess_year_mm;
			self.pk_add1_no_of_baths_mm := pk_add1_no_of_baths_mm;
			self.pk_out_st_division_lvl_mm := pk_out_st_division_lvl_mm;
			self.pk_yr_rc_ssnhighissue2_mm := pk_yr_rc_ssnhighissue2_mm;
			self.pk_add2_building_area2_mm := pk_add2_building_area2_mm;
			self.pk_phones_per_adl_mm := pk_phones_per_adl_mm;
			self.pk2_add1_avm_auto2_mm := pk2_add1_avm_auto2_mm;
			self.pk_addrs_10yr_mm := pk_addrs_10yr_mm;
			self.pk_ams_4yr_college_mm := pk_ams_4yr_college_mm;
			self.pk_ssns_per_addr_c6_mm := pk_ssns_per_addr_c6_mm;
			self.pk_yr_ln_unrel_lt_f_sn2_mm := pk_yr_ln_unrel_lt_f_sn2_mm;
			self.pk2_add1_avm_hed_mm := pk2_add1_avm_hed_mm;
			self.pk2_yr_add1_avm_rec_dt_mm := pk2_yr_add1_avm_rec_dt_mm;
			self.pk_add1_mortgage_risk_mm := pk_add1_mortgage_risk_mm;
			self.pk_pl_sourced_level_mm := pk_pl_sourced_level_mm;
			self.pk_add2_assessed_amount2_mm := pk_add2_assessed_amount2_mm;
			self.pk_prof_lic_cat_mm := pk_prof_lic_cat_mm;
			self.pk_dist_a1toa3_mm := pk_dist_a1toa3_mm;
			self.pk_eviction_level_mm := pk_eviction_level_mm;
			self.pk_attr_num_nonderogs90_b_mm := pk_attr_num_nonderogs90_b_mm;
			self.pk_add3_own_level_mm := pk_add3_own_level_mm;
			self.pk_ssns_per_adl_c6_mm := pk_ssns_per_adl_c6_mm;
			self.pk_attr_addrs_last24_mm := pk_attr_addrs_last24_mm;
			self.pk_add2_avm_auto_diff2_lvl_mm := pk_add2_avm_auto_diff2_lvl_mm;
			self.pk_add3_mortgage_risk_mm := pk_add3_mortgage_risk_mm;
			self.pk2_add1_avm_med_mm := pk2_add1_avm_med_mm;
			self.pk_impulse_count_mm := pk_impulse_count_mm;
			self.pk_yr_add2_mortgage_due_date2_mm := pk_yr_add2_mortgage_due_date2_mm;
			self.pk_yr_add1_mortgage_date2_mm := pk_yr_add1_mortgage_date2_mm;
			self.pk_yr_in_dob2_mm := pk_yr_in_dob2_mm;
			self.pk2_yr_add2_avm_assess_year_mm := pk2_yr_add2_avm_assess_year_mm;
			self.pk_avm_hit_level_mm := pk_avm_hit_level_mm;
			self.pk_bk_level_mm := pk_bk_level_mm;
			self.pk_wealth_index_mm := pk_wealth_index_mm;
			self.pk_yr_ln_unrel_cj_f_sn2_mm := pk_yr_ln_unrel_cj_f_sn2_mm;
			self.pk2_add2_avm_pi_mm := pk2_add2_avm_pi_mm;
			self.pk2_add1_avm_to_med_ratio_mm := pk2_add1_avm_to_med_ratio_mm;
			self.pk_add1_assessed_amount2_mm := pk_add1_assessed_amount2_mm;
			self.pk_add3_lres_mm := pk_add3_lres_mm;
			self.pk_lres_flag_level_mm := pk_lres_flag_level_mm;
			self.pk_ams_age_mm := pk_ams_age_mm;
			self.pk_estimated_income_mm := pk_estimated_income_mm;
			self.pk_yr_adl_w_first_seen2_mm := pk_yr_adl_w_first_seen2_mm;
			self.pk_add2_mortgage_risk_mm := pk_add2_mortgage_risk_mm;
			self.pk_dist_a1toa2_mm := pk_dist_a1toa2_mm;
			self.pk2_add2_avm_auto4_mm := pk2_add2_avm_auto4_mm;
			self.pk_yr_add1_purchase_date2_mm := pk_yr_add1_purchase_date2_mm;
			self.pk_yr_prop1_prev_purch_dt2_mm := pk_yr_prop1_prev_purch_dt2_mm;
			self.pk_add3_assessed_amount2_mm := pk_add3_assessed_amount2_mm;
			self.pk_yr_add1_built_date2_mm := pk_yr_add1_built_date2_mm;
			self.pk_yr_felony_last_date2_mm := pk_yr_felony_last_date2_mm;
			self.pk_addrs_5yr_mm := pk_addrs_5yr_mm;
			self.pk_lien_type_level_mm := pk_lien_type_level_mm;
			self.pk2_add1_avm_pi_mm := pk2_add1_avm_pi_mm;
			self.pk_yr_liens_last_unrel_date3_mm := pk_yr_liens_last_unrel_date3_mm;
			self.segment_mean := segment_mean;
			self.pk_add_lres_month_avg2_mm_2 := pk_add_lres_month_avg2_mm_2;
			self.pk_add1_address_score_mm_2 := pk_add1_address_score_mm_2;
			self.pk_add1_assessed_amount2_mm_2 := pk_add1_assessed_amount2_mm_2;
			self.pk_add1_building_area2_mm_2 := pk_add1_building_area2_mm_2;
			self.pk_add1_lres_mm_2 := pk_add1_lres_mm_2;
			self.pk_add1_mortgage_risk_mm_2 := pk_add1_mortgage_risk_mm_2;
			self.pk_add1_no_of_baths_mm_2 := pk_add1_no_of_baths_mm_2;
			self.pk_add2_address_score_mm_2 := pk_add2_address_score_mm_2;
			self.pk_add2_assessed_amount2_mm_2 := pk_add2_assessed_amount2_mm_2;
			self.pk_add2_avm_auto_diff2_lvl_mm_2 := pk_add2_avm_auto_diff2_lvl_mm_2;
			self.pk_add2_building_area2_mm_2 := pk_add2_building_area2_mm_2;
			self.pk_add2_em_ver_lvl_mm_2 := pk_add2_em_ver_lvl_mm_2;
			self.pk_add2_land_use_risk_level_mm_2 := pk_add2_land_use_risk_level_mm_2;
			self.pk_add2_lres_mm_2 := pk_add2_lres_mm_2;
			self.pk_add2_mortgage_risk_mm_2 := pk_add2_mortgage_risk_mm_2;
			self.pk_add2_no_of_baths_mm_2 := pk_add2_no_of_baths_mm_2;
			self.pk_add2_own_level_mm_2 := pk_add2_own_level_mm_2;
			self.pk_add2_pos_secondary_sources_mm_2 := pk_add2_pos_secondary_sources_mm_2;
			self.pk_add2_pos_sources_mm_2 := pk_add2_pos_sources_mm_2;
			self.pk_add3_assessed_amount2_mm_2 := pk_add3_assessed_amount2_mm_2;
			self.pk_add3_lres_mm_2 := pk_add3_lres_mm_2;
			self.pk_add3_mortgage_risk_mm_2 := pk_add3_mortgage_risk_mm_2;
			self.pk_add3_own_level_mm_2 := pk_add3_own_level_mm_2;
			self.pk_addrs_10yr_mm_2 := pk_addrs_10yr_mm_2;
			self.pk_addrs_5yr_mm_2 := pk_addrs_5yr_mm_2;
			self.pk_addrs_per_adl_mm_2 := pk_addrs_per_adl_mm_2;
			self.pk_addrs_sourced_lvl_mm_2 := pk_addrs_sourced_lvl_mm_2;
			self.pk_adl_score_mm_2 := pk_adl_score_mm_2;
			self.pk_adlperssn_count_mm_2 := pk_adlperssn_count_mm_2;
			self.pk_adls_per_phone_mm_2 := pk_adls_per_phone_mm_2;
			self.pk_ams_4yr_college_mm_2 := pk_ams_4yr_college_mm_2;
			self.pk_ams_age_mm_2 := pk_ams_age_mm_2;
			self.pk_ams_class_level_mm_2 := pk_ams_class_level_mm_2;
			self.pk_ams_college_type_mm_2 := pk_ams_college_type_mm_2;
			self.pk_ams_income_level_code_mm_2 := pk_ams_income_level_code_mm_2;
			self.pk_attr_addrs_last12_mm_2 := pk_attr_addrs_last12_mm_2;
			self.pk_attr_addrs_last24_mm_2 := pk_attr_addrs_last24_mm_2;
			self.pk_attr_addrs_last90_mm_2 := pk_attr_addrs_last90_mm_2;
			self.pk_attr_num_nonderogs90_b_mm_2 := pk_attr_num_nonderogs90_b_mm_2;
			self.pk_attr_total_number_derogs_mm_2 := pk_attr_total_number_derogs_mm_2;
			self.pk_avm_auto_diff2_lvl_mm_2 := pk_avm_auto_diff2_lvl_mm_2;
			self.pk_avm_auto_diff4_lvl_mm_2 := pk_avm_auto_diff4_lvl_mm_2;
			self.pk_avm_hit_level_mm_2 := pk_avm_hit_level_mm_2;
			self.pk_bk_level_mm_2 := pk_bk_level_mm_2;
			self.pk_combo_addrcount_nb_mm_2 := pk_combo_addrcount_nb_mm_2;
			self.pk_combo_addrscore_mm_2 := pk_combo_addrscore_mm_2;
			self.pk_combo_dobcount_mm_2 := pk_combo_dobcount_mm_2;
			self.pk_combo_dobcount_nb_mm_2 := pk_combo_dobcount_nb_mm_2;
			self.pk_combo_dobscore_mm_2 := pk_combo_dobscore_mm_2;
			self.pk_combo_fnamecount_nb_mm_2 := pk_combo_fnamecount_nb_mm_2;
			self.pk_combo_hphonescore_mm_2 := pk_combo_hphonescore_mm_2;
			self.pk_combo_lnamecount_mm_2 := pk_combo_lnamecount_mm_2;
			self.pk_combo_ssncount_mm_2 := pk_combo_ssncount_mm_2;
			self.pk_combo_ssnscore_mm_2 := pk_combo_ssnscore_mm_2;
			self.pk_dist_a1toa2_mm_2 := pk_dist_a1toa2_mm_2;
			self.pk_dist_a1toa3_mm_2 := pk_dist_a1toa3_mm_2;
			self.pk_em_only_ver_lvl_mm_2 := pk_em_only_ver_lvl_mm_2;
			self.pk_eq_count_mm_2 := pk_eq_count_mm_2;
			self.pk_estimated_income_mm_2 := pk_estimated_income_mm_2;
			self.pk_eviction_level_mm_2 := pk_eviction_level_mm_2;
			self.pk_impulse_count_mm_2 := pk_impulse_count_mm_2;
			self.pk_inferred_age_mm_2 := pk_inferred_age_mm_2;
			self.pk_infutor_risk_lvl_mm_2 := pk_infutor_risk_lvl_mm_2;
			self.pk_infutor_risk_lvl_nb_mm_2 := pk_infutor_risk_lvl_nb_mm_2;
			self.pk_lien_type_level_mm_2 := pk_lien_type_level_mm_2;
			self.pk_lname_eda_sourced_type_lvl_mm_2 := pk_lname_eda_sourced_type_lvl_mm_2;
			self.pk_lres_flag_level_mm_2 := pk_lres_flag_level_mm_2;
			self.pk_nameperssn_count_mm_2 := pk_nameperssn_count_mm_2;
			self.pk_naprop_level2_mm_2 := pk_naprop_level2_mm_2;
			self.pk_nas_summary_mm_2 := pk_nas_summary_mm_2;
			self.pk_out_st_division_lvl_mm_2 := pk_out_st_division_lvl_mm_2;
			self.pk_phones_per_adl_mm_2 := pk_phones_per_adl_mm_2;
			self.pk_pl_sourced_level_mm_2 := pk_pl_sourced_level_mm_2;
			self.pk_pos_secondary_sources_mm_2 := pk_pos_secondary_sources_mm_2;
			self.pk_pr_count_mm_2 := pk_pr_count_mm_2;
			self.pk_prof_lic_cat_mm_2 := pk_prof_lic_cat_mm_2;
			self.pk_prop_own_assess_tot2_mm_2 := pk_prop_own_assess_tot2_mm_2;
			self.pk_prop1_sale_price2_mm_2 := pk_prop1_sale_price2_mm_2;
			self.pk_property_owned_total_mm_2 := pk_property_owned_total_mm_2;
			self.pk_rc_addrcount_mm_2 := pk_rc_addrcount_mm_2;
			self.pk_rc_addrcount_nb_mm_2 := pk_rc_addrcount_nb_mm_2;
			self.pk_rc_dirsaddr_lastscore_mm_2 := pk_rc_dirsaddr_lastscore_mm_2;
			self.pk_rc_disthphoneaddr_mm_2 := pk_rc_disthphoneaddr_mm_2;
			self.pk_rc_fnamecount_mm_2 := pk_rc_fnamecount_mm_2;
			self.pk_rc_fnamecount_nb_mm_2 := pk_rc_fnamecount_nb_mm_2;
			self.pk_rc_phoneaddr_phonecount_mm_2 := pk_rc_phoneaddr_phonecount_mm_2;
			self.pk_rc_phonelnamecount_mm_2 := pk_rc_phonelnamecount_mm_2;
			self.pk_ssnchar_invalid_or_recent_mm_2 := pk_ssnchar_invalid_or_recent_mm_2;
			self.pk_ssns_per_addr_c6_mm_2 := pk_ssns_per_addr_c6_mm_2;
			self.pk_ssns_per_addr2_mm_2 := pk_ssns_per_addr2_mm_2;
			self.pk_ssns_per_adl_c6_mm_2 := pk_ssns_per_adl_c6_mm_2;
			self.pk_ssns_per_adl_mm_2 := pk_ssns_per_adl_mm_2;
			self.pk_ver_phncount_mm_2 := pk_ver_phncount_mm_2;
			self.pk_voter_flag_mm_2 := pk_voter_flag_mm_2;
			self.pk_w_count_mm_2 := pk_w_count_mm_2;
			self.pk_wealth_index_mm_2 := pk_wealth_index_mm_2;
			self.pk_yr_add1_built_date2_mm_2 := pk_yr_add1_built_date2_mm_2;
			self.pk_yr_add1_date_first_seen2_mm_2 := pk_yr_add1_date_first_seen2_mm_2;
			self.pk_yr_add1_mortgage_date2_mm_2 := pk_yr_add1_mortgage_date2_mm_2;
			self.pk_yr_add1_purchase_date2_mm_2 := pk_yr_add1_purchase_date2_mm_2;
			self.pk_yr_add2_date_first_seen2_mm_2 := pk_yr_add2_date_first_seen2_mm_2;
			self.pk_yr_add2_mortgage_date2_mm_2 := pk_yr_add2_mortgage_date2_mm_2;
			self.pk_yr_add2_mortgage_due_date2_mm_2 := pk_yr_add2_mortgage_due_date2_mm_2;
			self.pk_yr_add3_date_first_seen2_mm_2 := pk_yr_add3_date_first_seen2_mm_2;
			self.pk_yr_adl_em_only_first_seen2_mm_2 := pk_yr_adl_em_only_first_seen2_mm_2;
			self.pk_yr_adl_vo_first_seen2_mm_2 := pk_yr_adl_vo_first_seen2_mm_2;
			self.pk_yr_adl_w_first_seen2_mm_2 := pk_yr_adl_w_first_seen2_mm_2;
			self.pk_yr_adl_w_last_seen2_mm_2 := pk_yr_adl_w_last_seen2_mm_2;
			self.pk_yr_criminal_last_date2_mm_2 := pk_yr_criminal_last_date2_mm_2;
			self.pk_yr_felony_last_date2_mm_2 := pk_yr_felony_last_date2_mm_2;
			self.pk_yr_gong_did_first_seen2_mm_2 := pk_yr_gong_did_first_seen2_mm_2;
			self.pk_yr_header_first_seen2_mm_2 := pk_yr_header_first_seen2_mm_2;
			self.pk_yr_in_dob2_mm_2 := pk_yr_in_dob2_mm_2;
			self.pk_yr_infutor_first_seen2_mm_2 := pk_yr_infutor_first_seen2_mm_2;
			self.pk_yr_liens_last_unrel_date3_mm_2 := pk_yr_liens_last_unrel_date3_mm_2;
			self.pk_yr_ln_unrel_cj_f_sn2_mm_2 := pk_yr_ln_unrel_cj_f_sn2_mm_2;
			self.pk_yr_ln_unrel_lt_f_sn2_mm_2 := pk_yr_ln_unrel_lt_f_sn2_mm_2;
			self.pk_yr_ln_unrel_ot_f_sn2_mm_2 := pk_yr_ln_unrel_ot_f_sn2_mm_2;
			self.pk_yr_lname_change_date2_mm_2 := pk_yr_lname_change_date2_mm_2;
			self.pk_yr_prop1_prev_purch_dt2_mm_2 := pk_yr_prop1_prev_purch_dt2_mm_2;
			self.pk_yr_rc_ssnhighissue2_mm_2 := pk_yr_rc_ssnhighissue2_mm_2;
			self.pk_yr_reported_dob2_mm_2 := pk_yr_reported_dob2_mm_2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
			self.pk2_add1_avm_auto2_mm_2 := pk2_add1_avm_auto2_mm_2;
			self.pk2_add1_avm_auto4_mm_2 := pk2_add1_avm_auto4_mm_2;
			self.pk2_add1_avm_hed_mm_2 := pk2_add1_avm_hed_mm_2;
			self.pk2_add1_avm_med_mm_2 := pk2_add1_avm_med_mm_2;
			self.pk2_add1_avm_mkt_mm_2 := pk2_add1_avm_mkt_mm_2;
			self.pk2_add1_avm_pi_mm_2 := pk2_add1_avm_pi_mm_2;
			self.pk2_add1_avm_to_med_ratio_mm_2 := pk2_add1_avm_to_med_ratio_mm_2;
			self.pk2_add2_avm_auto4_mm_2 := pk2_add2_avm_auto4_mm_2;
			self.pk2_add2_avm_hed_mm_2 := pk2_add2_avm_hed_mm_2;
			self.pk2_add2_avm_mkt_mm_2 := pk2_add2_avm_mkt_mm_2;
			self.pk2_add2_avm_pi_mm_2 := pk2_add2_avm_pi_mm_2;
			self.pk2_yr_add1_avm_assess_year_mm_2 := pk2_yr_add1_avm_assess_year_mm_2;
			self.pk2_yr_add1_avm_rec_dt_mm_2 := pk2_yr_add1_avm_rec_dt_mm_2;
			self.pk2_yr_add2_avm_assess_year_mm_2 := pk2_yr_add2_avm_assess_year_mm_2;
			self.addprob3_mod_dm_b1 := addprob3_mod_dm_b1;
			self.phnprob_mod_dm_b1 := phnprob_mod_dm_b1;
			self.ssnprob2_mod_dm_b1 := ssnprob2_mod_dm_b1;
			self.fp_mod5_dm_b1 := fp_mod5_dm_b1;
			self.age_mod3_dm_b1 := age_mod3_dm_b1;
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
			self.ver_best_score_mod_dm_b1 := ver_best_score_mod_dm_b1;
			self.ver_best_element_cnt_mod_dm_b1 := ver_best_element_cnt_mod_dm_b1;
			self.ver_best_src_cnt_mod_dm_b1 := ver_best_src_cnt_mod_dm_b1;
			self.ver_best_src_time_mod_dm_b1 := ver_best_src_time_mod_dm_b1;
			self.ver_notbest_element_cnt_mod_dm_b1 := ver_notbest_element_cnt_mod_dm_b1;
			self.ver_notbest_score_mod_dm_b1 := ver_notbest_score_mod_dm_b1;
			self.ver_notbest_src_cnt_mod_dm_b1 := ver_notbest_src_cnt_mod_dm_b1;
			self.ver_notbest_src_time_mod_dm_b1 := ver_notbest_src_time_mod_dm_b1;
			self.ver_element_cnt_mod_dm_b1 := ver_element_cnt_mod_dm_b1;
			self.ver_src_cnt_mod_dm_b1 := ver_src_cnt_mod_dm_b1;
			self.ver_score_mod_dm_b1 := ver_score_mod_dm_b1;
			self.ver_src_time_mod_dm_b1 := ver_src_time_mod_dm_b1;
			self.mod14_dm_b1 := mod14_dm_b1;
			self.addprob3_mod_om_b2 := addprob3_mod_om_b2;
			self.phnprob_mod_om_b2 := phnprob_mod_om_b2;
			self.ssnprob2_mod_om_b2 := ssnprob2_mod_om_b2;
			self.fp_mod5_om_b2 := fp_mod5_om_b2;
			self.age_mod3_nodob_om_b2 := age_mod3_nodob_om_b2;
			self.age_mod3_om_b2 := age_mod3_om_b2;
			self.amstudent_mod_om_b2 := amstudent_mod_om_b2;
			self.avm_mod_om_b2 := avm_mod_om_b2;
			self.distance_mod2_om_b2 := distance_mod2_om_b2;
			self.lien_mod_om_b2 := lien_mod_om_b2;
			self.lres_mod_om_b2 := lres_mod_om_b2;
			self.proflic_mod_om_b2 := proflic_mod_om_b2;
			self.property_mod_om_b2 := property_mod_om_b2;
			self.velocity2_mod_om_b2 := velocity2_mod_om_b2;
			self.ver_best_element_cnt_mod_om_b2 := ver_best_element_cnt_mod_om_b2;
			self.ver_best_score_mod_om_b2 := ver_best_score_mod_om_b2;
			self.ver_best_src_cnt_mod_om_b2 := ver_best_src_cnt_mod_om_b2;
			self.ver_best_src_time_mod_om_b2 := ver_best_src_time_mod_om_b2;
			self.ver_notbest_element_cnt_mod_om_b2 := ver_notbest_element_cnt_mod_om_b2;
			self.ver_notbest_score_mod_om_b2 := ver_notbest_score_mod_om_b2;
			self.ver_notbest_src_cnt_mod_om_b2 := ver_notbest_src_cnt_mod_om_b2;
			self.ver_notbest_src_time_mod_om_b2 := ver_notbest_src_time_mod_om_b2;
			self.ver_src_time_mod_om_b2 := ver_src_time_mod_om_b2;
			self.ver_element_cnt_mod_om_b2 := ver_element_cnt_mod_om_b2;
			self.ver_score_mod_om_b2 := ver_score_mod_om_b2;
			self.ver_src_cnt_mod_om_b2 := ver_src_cnt_mod_om_b2;
			self.mod14_om_b2 := mod14_om_b2;
			self.addprob3_mod_rm_b3 := addprob3_mod_rm_b3;
			self.phnprob_mod_rm_b3 := phnprob_mod_rm_b3;
			self.ssnprob2_mod_rm_b3 := ssnprob2_mod_rm_b3;
			self.fp_mod5_rm_b3 := fp_mod5_rm_b3;
			self.age_mod3_nodob_rm_b3 := age_mod3_nodob_rm_b3;
			self.age_mod3_rm_b3 := age_mod3_rm_b3;
			self.amstudent_mod_rm_b3 := amstudent_mod_rm_b3;
			self.avm_mod_rm_b3 := avm_mod_rm_b3;
			self.distance_mod2_rm_b3 := distance_mod2_rm_b3;
			self.lres_mod_rm_b3 := lres_mod_rm_b3;
			self.property_mod_rm_b3 := property_mod_rm_b3;
			self.velocity2_mod_rm_b3 := velocity2_mod_rm_b3;
			self.ver_best_element_cnt_mod_rm_b3 := ver_best_element_cnt_mod_rm_b3;
			self.ver_best_score_mod_rm_b3 := ver_best_score_mod_rm_b3;
			self.ver_best_src_cnt_mod_rm_b3 := ver_best_src_cnt_mod_rm_b3;
			self.ver_best_src_time_mod_rm_b3 := ver_best_src_time_mod_rm_b3;
			self.ver_notbest_element_cnt_mod_rm_b3 := ver_notbest_element_cnt_mod_rm_b3;
			self.ver_notbest_score_mod_rm_b3 := ver_notbest_score_mod_rm_b3;
			self.ver_notbest_src_cnt_mod_rm_b3 := ver_notbest_src_cnt_mod_rm_b3;
			self.ver_notbest_src_time_mod_rm_b3 := ver_notbest_src_time_mod_rm_b3;
			self.ver_score_mod_rm_b3 := ver_score_mod_rm_b3;
			self.ver_element_cnt_mod_rm_b3 := ver_element_cnt_mod_rm_b3;
			self.ver_src_time_mod_rm_b3 := ver_src_time_mod_rm_b3;
			self.ver_src_cnt_mod_rm_b3 := ver_src_cnt_mod_rm_b3;
			self.mod14_rm_b3 := mod14_rm_b3;
			self.addprob3_mod_xm_b4 := addprob3_mod_xm_b4;
			self.phnprob_mod_xm_b4 := phnprob_mod_xm_b4;
			self.ssnprob2_mod_xm_b4 := ssnprob2_mod_xm_b4;
			self.fp_mod5_xm_b4 := fp_mod5_xm_b4;
			self.age_mod3_nodob_xm_b4 := age_mod3_nodob_xm_b4;
			self.age_mod3_xm_b4 := age_mod3_xm_b4;
			self.amstudent_mod_xm_b4 := amstudent_mod_xm_b4;
			self.avm_mod_xm_b4 := avm_mod_xm_b4;
			self.distance_mod2_xm_b4 := distance_mod2_xm_b4;
			self.lres_mod_xm_b4 := lres_mod_xm_b4;
			self.property_mod_xm_b4 := property_mod_xm_b4;
			self.velocity2_mod_xm_b4 := velocity2_mod_xm_b4;
			self.ver_best_element_cnt_mod_xm_b4 := ver_best_element_cnt_mod_xm_b4;
			self.ver_best_score_mod_xm_b4 := ver_best_score_mod_xm_b4;
			self.ver_best_src_cnt_mod_xm_b4 := ver_best_src_cnt_mod_xm_b4;
			self.ver_best_src_time_mod_xm_b4 := ver_best_src_time_mod_xm_b4;
			self.ver_notbest_element_cnt_mod_xm_b4 := ver_notbest_element_cnt_mod_xm_b4;
			self.ver_notbest_score_mod_xm_b4 := ver_notbest_score_mod_xm_b4;
			self.ver_notbest_src_cnt_mod_xm_b4 := ver_notbest_src_cnt_mod_xm_b4;
			self.ver_notbest_src_time_mod_xm_b4 := ver_notbest_src_time_mod_xm_b4;
			self.ver_element_cnt_mod_xm_b4 := ver_element_cnt_mod_xm_b4;
			self.ver_score_mod_xm_b4 := ver_score_mod_xm_b4;
			self.ver_src_time_mod_xm_b4 := ver_src_time_mod_xm_b4;
			self.ver_src_cnt_mod_xm_b4 := ver_src_cnt_mod_xm_b4;
			self.mod14_xm_b4 := mod14_xm_b4;
			self.ver_best_element_cnt_mod_om := ver_best_element_cnt_mod_om;
			self.distance_mod2_om := distance_mod2_om;
			self.velocity2_mod_rm := velocity2_mod_rm;
			self.lien_mod_dm := lien_mod_dm;
			self.phat := phat;
			self.addprob3_mod_dm := addprob3_mod_dm;
			self.proflic_mod_om := proflic_mod_om;
			self.age_mod3_nodob_xm := age_mod3_nodob_xm;
			self.ver_best_score_mod_dm := ver_best_score_mod_dm;
			self.avm_mod_om := avm_mod_om;
			self.ver_best_src_time_mod_dm := ver_best_src_time_mod_dm;
			self.fp_mod5_dm := fp_mod5_dm;
			self.property_mod_xm := property_mod_xm;
			self.velocity2_mod_dm := velocity2_mod_dm;
			self.age_mod3_dm := age_mod3_dm;
			self.ver_best_score_mod_xm := ver_best_score_mod_xm;
			self.ver_notbest_element_cnt_mod_rm := ver_notbest_element_cnt_mod_rm;
			self.lien_mod_om := lien_mod_om;
			self.age_mod3_rm := age_mod3_rm;
			self.ver_notbest_src_time_mod_dm := ver_notbest_src_time_mod_dm;
			self.property_mod_rm := property_mod_rm;
			self.addprob3_mod_rm := addprob3_mod_rm;
			self.age_mod3_nodob_om := age_mod3_nodob_om;
			self.velocity2_mod_om := velocity2_mod_om;
			self.ver_element_cnt_mod_rm := ver_element_cnt_mod_rm;
			self.ver_src_time_mod_rm := ver_src_time_mod_rm;
			self.property_mod_dm := property_mod_dm;
			self.ver_notbest_src_cnt_mod_xm := ver_notbest_src_cnt_mod_xm;
			self.ssnprob2_mod_om := ssnprob2_mod_om;
			self.ver_best_src_time_mod_om := ver_best_src_time_mod_om;
			self.ver_best_src_cnt_mod_xm := ver_best_src_cnt_mod_xm;
			self.avm_mod_rm := avm_mod_rm;
			self.amstudent_mod_rm := amstudent_mod_rm;
			self.age_mod3_xm := age_mod3_xm;
			self.velocity2_mod_xm := velocity2_mod_xm;
			self.ssnprob2_mod_rm := ssnprob2_mod_rm;
			self.ver_src_time_mod_dm := ver_src_time_mod_dm;
			self.lres_mod_om := lres_mod_om;
			self.avm_mod_dm := avm_mod_dm;
			self.ver_best_src_cnt_mod_rm := ver_best_src_cnt_mod_rm;
			self.ver_element_cnt_mod_xm := ver_element_cnt_mod_xm;
			self.ssnprob2_mod_xm := ssnprob2_mod_xm;
			self.lres_mod_rm := lres_mod_rm;
			self.ver_score_mod_xm := ver_score_mod_xm;
			self.distance_mod2_rm := distance_mod2_rm;
			self.proflic_mod_dm := proflic_mod_dm;
			self.ver_notbest_src_time_mod_rm := ver_notbest_src_time_mod_rm;
			self.ver_best_src_cnt_mod_om := ver_best_src_cnt_mod_om;
			self.addprob3_mod_xm := addprob3_mod_xm;
			self.age_mod3_nodob_rm := age_mod3_nodob_rm;
			self.phnprob_mod_rm := phnprob_mod_rm;
			self.ver_src_cnt_mod_dm := ver_src_cnt_mod_dm;
			self.ver_best_element_cnt_mod_rm := ver_best_element_cnt_mod_rm;
			self.ssnprob2_mod_dm := ssnprob2_mod_dm;
			self.derog_mod3_dm := derog_mod3_dm;
			self.ver_best_score_mod_rm := ver_best_score_mod_rm;
			self.amstudent_mod_om := amstudent_mod_om;
			self.ver_src_time_mod_om := ver_src_time_mod_om;
			self.ver_notbest_score_mod_dm := ver_notbest_score_mod_dm;
			self.mod14_om := mod14_om;
			self.mod14_xm := mod14_xm;
			self.ver_notbest_src_cnt_mod_rm := ver_notbest_src_cnt_mod_rm;
			self.ver_notbest_src_cnt_mod_om := ver_notbest_src_cnt_mod_om;
			self.fp_mod5_om := fp_mod5_om;
			self.distance_mod2_dm := distance_mod2_dm;
			self.ver_notbest_element_cnt_mod_dm := ver_notbest_element_cnt_mod_dm;
			self.ver_best_src_cnt_mod_dm := ver_best_src_cnt_mod_dm;
			self.ver_src_cnt_mod_xm := ver_src_cnt_mod_xm;
			self.age_mod3_nodob_dm := age_mod3_nodob_dm;
			self.ver_notbest_src_time_mod_xm := ver_notbest_src_time_mod_xm;
			self.ver_notbest_score_mod_xm := ver_notbest_score_mod_xm;
			self.addprob3_mod_om := addprob3_mod_om;
			self.fp_mod5_rm := fp_mod5_rm;
			self.ver_notbest_element_cnt_mod_xm := ver_notbest_element_cnt_mod_xm;
			self.ver_score_mod_dm := ver_score_mod_dm;
			self.ver_best_score_mod_om := ver_best_score_mod_om;
			self.amstudent_mod_dm := amstudent_mod_dm;
			self.ver_notbest_src_time_mod_om := ver_notbest_src_time_mod_om;
			self.mod14_rm := mod14_rm;
			self.ver_best_src_time_mod_xm := ver_best_src_time_mod_xm;
			self.ver_src_cnt_mod_om := ver_src_cnt_mod_om;
			self.amstudent_mod_xm := amstudent_mod_xm;
			self.avm_mod_xm := avm_mod_xm;
			self.ver_score_mod_rm := ver_score_mod_rm;
			self.distance_mod2_xm := distance_mod2_xm;
			self.ver_notbest_element_cnt_mod_om := ver_notbest_element_cnt_mod_om;
			self.fp_mod5_xm := fp_mod5_xm;
			self.age_mod3_om := age_mod3_om;
			self.ver_src_cnt_mod_rm := ver_src_cnt_mod_rm;
			self.phnprob_mod_dm := phnprob_mod_dm;
			self.phnprob_mod_xm := phnprob_mod_xm;
			self.ver_notbest_score_mod_rm := ver_notbest_score_mod_rm;
			self.mod14_scr := mod14_scr;
			self.ver_notbest_score_mod_om := ver_notbest_score_mod_om;
			self.ver_best_element_cnt_mod_dm := ver_best_element_cnt_mod_dm;
			self.ver_best_src_time_mod_rm := ver_best_src_time_mod_rm;
			self.ver_element_cnt_mod_dm := ver_element_cnt_mod_dm;
			self.lres_mod_dm := lres_mod_dm;
			self.ver_element_cnt_mod_om := ver_element_cnt_mod_om;
			self.mod14_dm := mod14_dm;
			self.phnprob_mod_om := phnprob_mod_om;
			self.ver_notbest_src_cnt_mod_dm := ver_notbest_src_cnt_mod_dm;
			self.ver_score_mod_om := ver_score_mod_om;
			self.ver_src_time_mod_xm := ver_src_time_mod_xm;
			self.property_mod_om := property_mod_om;
			self.ver_best_element_cnt_mod_xm := ver_best_element_cnt_mod_xm;
			self.lres_mod_xm := lres_mod_xm;
			self.ssnprob2_mod_dm_nodob_b1_c2_b1 := ssnprob2_mod_dm_nodob_b1_c2_b1;
			self.fp_mod5_dm_nodob_b1_c2_b1 := fp_mod5_dm_nodob_b1_c2_b1;
			self.ver_best_e_cnt_mod_dm_nodob_b1_c2_b1 := ver_best_e_cnt_mod_dm_nodob_b1_c2_b1;
			self.ver_best_score_mod_dm_nodob_b1_c2_b1 := ver_best_score_mod_dm_nodob_b1_c2_b1;
			self.ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1 := ver_notbest_e_cnt_mod_dm_nodob_b1_c2_b1;
			self.ver_notbest_score_mod_dm_nodob_b1_c2_b1 := ver_notbest_score_mod_dm_nodob_b1_c2_b1;
			self.ver_score_mod_dm_nodob_b1_c2_b1 := ver_score_mod_dm_nodob_b1_c2_b1;
			self.ver_element_cnt_mod_dm_nodob_b1_c2_b1 := ver_element_cnt_mod_dm_nodob_b1_c2_b1;
			self.mod14_dm_nodob_b1_c2_b1 := mod14_dm_nodob_b1_c2_b1;
			self.ssnprob2_mod_om_nodob_b1_c2_b2 := ssnprob2_mod_om_nodob_b1_c2_b2;
			self.fp_mod5_om_nodob_b1_c2_b2 := fp_mod5_om_nodob_b1_c2_b2;
			self.ver_best_e_cnt_mod_om_nodob_b1_c2_b2 := ver_best_e_cnt_mod_om_nodob_b1_c2_b2;
			self.ver_best_score_mod_om_nodob_b1_c2_b2 := ver_best_score_mod_om_nodob_b1_c2_b2;
			self.ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2 := ver_notbest_e_cnt_mod_om_nodob_b1_c2_b2;
			self.ver_notbest_score_mod_om_nodob_b1_c2_b2 := ver_notbest_score_mod_om_nodob_b1_c2_b2;
			self.ver_element_cnt_mod_om_nodob_b1_c2_b2 := ver_element_cnt_mod_om_nodob_b1_c2_b2;
			self.ver_score_mod_om_nodob_b1_c2_b2 := ver_score_mod_om_nodob_b1_c2_b2;
			self.mod14_om_nodob_b1_c2_b2 := mod14_om_nodob_b1_c2_b2;
			self.ssnprob2_mod_rm_nodob_b1_c2_b3 := ssnprob2_mod_rm_nodob_b1_c2_b3;
			self.fp_mod5_rm_nodob_b1_c2_b3 := fp_mod5_rm_nodob_b1_c2_b3;
			self.ver_best_e_cnt_mod_rm_nodob_b1_c2_b3 := ver_best_e_cnt_mod_rm_nodob_b1_c2_b3;
			self.ver_best_score_mod_rm_nodob_b1_c2_b3 := ver_best_score_mod_rm_nodob_b1_c2_b3;
			self.ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3 := ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3;
			self.ver_notbest_score_mod_rm_nodob_b1_c2_b3 := ver_notbest_score_mod_rm_nodob_b1_c2_b3;
			self.ver_element_cnt_mod_rm_nodob_b1_c2_b3 := ver_element_cnt_mod_rm_nodob_b1_c2_b3;
			self.ver_score_mod_rm_nodob_b1_c2_b3 := ver_score_mod_rm_nodob_b1_c2_b3;
			self.mod14_rm_nodob_b1_c2_b3 := mod14_rm_nodob_b1_c2_b3;
			self.ssnprob2_mod_xm_nodob_b1_c2_b4 := ssnprob2_mod_xm_nodob_b1_c2_b4;
			self.fp_mod5_xm_nodob_b1_c2_b4 := fp_mod5_xm_nodob_b1_c2_b4;
			self.ver_best_e_cnt_mod_xm_nodob_b1_c2_b4 := ver_best_e_cnt_mod_xm_nodob_b1_c2_b4;
			self.ver_best_score_mod_xm_nodob_b1_c2_b4 := ver_best_score_mod_xm_nodob_b1_c2_b4;
			self.ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4 := ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4;
			self.ver_notbest_score_mod_xm_nodob_b1_c2_b4 := ver_notbest_score_mod_xm_nodob_b1_c2_b4;
			self.ver_element_cnt_mod_xm_nodob_b1_c2_b4 := ver_element_cnt_mod_xm_nodob_b1_c2_b4;
			self.ver_score_mod_xm_nodob_b1_c2_b4 := ver_score_mod_xm_nodob_b1_c2_b4;
			self.mod14_xm_nodob_b1_c2_b4 := mod14_xm_nodob_b1_c2_b4;
			self.fp_mod5_rm_nodob_b1 := fp_mod5_rm_nodob_b1;
			self.ssnprob2_mod_om_nodob_b1 := ssnprob2_mod_om_nodob_b1;
			self.mod14_om_nodob_b1 := mod14_om_nodob_b1;
			self.mod14_dm_nodob_b1 := mod14_dm_nodob_b1;
			self.ssnprob2_mod_dm_nodob_b1 := ssnprob2_mod_dm_nodob_b1;
			self.ver_notbest_score_mod_om_nodob_b1 := ver_notbest_score_mod_om_nodob_b1;
			self.phat_b1 := phat_b1;
			self.ver_element_cnt_mod_dm_nodob_b1 := ver_element_cnt_mod_dm_nodob_b1;
			self.ver_best_e_cnt_mod_om_nodob_b1 := ver_best_e_cnt_mod_om_nodob_b1;
			self.ver_best_score_mod_dm_nodob_b1 := ver_best_score_mod_dm_nodob_b1;
			self.ver_notbest_e_cnt_mod_rm_nodob_b1 := ver_notbest_e_cnt_mod_rm_nodob_b1;
			self.ver_best_e_cnt_mod_rm_nodob_b1 := ver_best_e_cnt_mod_rm_nodob_b1;
			self.ssnprob2_mod_rm_nodob_b1 := ssnprob2_mod_rm_nodob_b1;
			self.ver_notbest_e_cnt_mod_om_nodob_b1 := ver_notbest_e_cnt_mod_om_nodob_b1;
			self.ssnprob2_mod_xm_nodob_b1 := ssnprob2_mod_xm_nodob_b1;
			self.ver_notbest_score_mod_rm_nodob_b1 := ver_notbest_score_mod_rm_nodob_b1;
			self.ver_score_mod_xm_nodob_b1 := ver_score_mod_xm_nodob_b1;
			self.ver_best_e_cnt_mod_xm_nodob_b1 := ver_best_e_cnt_mod_xm_nodob_b1;
			self.ver_best_e_cnt_mod_dm_nodob_b1 := ver_best_e_cnt_mod_dm_nodob_b1;
			self.fp_mod5_om_nodob_b1 := fp_mod5_om_nodob_b1;
			self.ver_element_cnt_mod_xm_nodob_b1 := ver_element_cnt_mod_xm_nodob_b1;
			self.ver_notbest_e_cnt_mod_xm_nodob_b1 := ver_notbest_e_cnt_mod_xm_nodob_b1;
			self.ver_best_score_mod_om_nodob_b1 := ver_best_score_mod_om_nodob_b1;
			self.ver_best_score_mod_rm_nodob_b1 := ver_best_score_mod_rm_nodob_b1;
			self.mod14_xm_nodob_b1 := mod14_xm_nodob_b1;
			self.ver_element_cnt_mod_rm_nodob_b1 := ver_element_cnt_mod_rm_nodob_b1;
			self.ver_notbest_score_mod_xm_nodob_b1 := ver_notbest_score_mod_xm_nodob_b1;
			self.ver_score_mod_dm_nodob_b1 := ver_score_mod_dm_nodob_b1;
			self.mod14_scr_b1 := mod14_scr_b1;
			self.ver_score_mod_om_nodob_b1 := ver_score_mod_om_nodob_b1;
			self.ver_notbest_score_mod_dm_nodob_b1 := ver_notbest_score_mod_dm_nodob_b1;
			self.ver_score_mod_rm_nodob_b1 := ver_score_mod_rm_nodob_b1;
			self.ver_best_score_mod_xm_nodob_b1 := ver_best_score_mod_xm_nodob_b1;
			self.fp_mod5_xm_nodob_b1 := fp_mod5_xm_nodob_b1;
			self.ver_element_cnt_mod_om_nodob_b1 := ver_element_cnt_mod_om_nodob_b1;
			self.mod14_rm_nodob_b1 := mod14_rm_nodob_b1;
			self.fp_mod5_dm_nodob_b1 := fp_mod5_dm_nodob_b1;
			self.ver_notbest_e_cnt_mod_dm_nodob_b1 := ver_notbest_e_cnt_mod_dm_nodob_b1;
			self.fp_mod5_rm_nodob := fp_mod5_rm_nodob;
			self.ssnprob2_mod_om_nodob := ssnprob2_mod_om_nodob;
			self.mod14_om_nodob := mod14_om_nodob;
			self.mod14_dm_nodob := mod14_dm_nodob;
			self.ssnprob2_mod_dm_nodob := ssnprob2_mod_dm_nodob;
			self.ver_notbest_score_mod_om_nodob := ver_notbest_score_mod_om_nodob;
			self.phat_2 := phat_2;
			self.ver_element_cnt_mod_dm_nodob := ver_element_cnt_mod_dm_nodob;
			self.ver_best_e_cnt_mod_om_nodob := ver_best_e_cnt_mod_om_nodob;
			self.ver_best_score_mod_dm_nodob := ver_best_score_mod_dm_nodob;
			self.ver_notbest_e_cnt_mod_rm_nodob := ver_notbest_e_cnt_mod_rm_nodob;
			self.ver_best_e_cnt_mod_rm_nodob := ver_best_e_cnt_mod_rm_nodob;
			self.ssnprob2_mod_rm_nodob := ssnprob2_mod_rm_nodob;
			self.ver_notbest_e_cnt_mod_om_nodob := ver_notbest_e_cnt_mod_om_nodob;
			self.ssnprob2_mod_xm_nodob := ssnprob2_mod_xm_nodob;
			self.ver_notbest_score_mod_rm_nodob := ver_notbest_score_mod_rm_nodob;
			self.ver_score_mod_xm_nodob := ver_score_mod_xm_nodob;
			self.ver_best_e_cnt_mod_xm_nodob := ver_best_e_cnt_mod_xm_nodob;
			self.ver_best_e_cnt_mod_dm_nodob := ver_best_e_cnt_mod_dm_nodob;
			self.fp_mod5_om_nodob := fp_mod5_om_nodob;
			self.ver_element_cnt_mod_xm_nodob := ver_element_cnt_mod_xm_nodob;
			self.ver_notbest_e_cnt_mod_xm_nodob := ver_notbest_e_cnt_mod_xm_nodob;
			self.ver_best_score_mod_om_nodob := ver_best_score_mod_om_nodob;
			self.ver_best_score_mod_rm_nodob := ver_best_score_mod_rm_nodob;
			self.mod14_xm_nodob := mod14_xm_nodob;
			self.ver_element_cnt_mod_rm_nodob := ver_element_cnt_mod_rm_nodob;
			self.ver_notbest_score_mod_xm_nodob := ver_notbest_score_mod_xm_nodob;
			self.ver_score_mod_dm_nodob := ver_score_mod_dm_nodob;
			self.mod14_scr_2 := mod14_scr_2;
			self.ver_score_mod_om_nodob := ver_score_mod_om_nodob;
			self.ver_notbest_score_mod_dm_nodob := ver_notbest_score_mod_dm_nodob;
			self.ver_score_mod_rm_nodob := ver_score_mod_rm_nodob;
			self.ver_best_score_mod_xm_nodob := ver_best_score_mod_xm_nodob;
			self.fp_mod5_xm_nodob := fp_mod5_xm_nodob;
			self.ver_element_cnt_mod_om_nodob := ver_element_cnt_mod_om_nodob;
			self.mod14_rm_nodob := mod14_rm_nodob;
			self.fp_mod5_dm_nodob := fp_mod5_dm_nodob;
			self.ver_notbest_e_cnt_mod_dm_nodob := ver_notbest_e_cnt_mod_dm_nodob;
			self.RVR1003 := RVR1003;
			self.scored_222s := scored_222s;
			self.rvr1003_2 := rvr1003_2;
			self.ov_ssndead := ov_ssndead;
			self.ov_ssnprior := ov_ssnprior;
			self.ov_criminal_flag := ov_criminal_flag;
			self.ov_corrections := ov_corrections;
			self.ov_impulse := ov_impulse;
			self.mod14_scr_rounded := mod14_scr_rounded;
			self.mod14_scr_b1_rounded := mod14_scr_b1_rounded;
		#else
			self.seq := le.seq;
			
			inCalif := __common__(isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3);



			// SC1O's 2x71 uses this model but rvReasons instead of RV3 Retail reasons
			riTemp := __common__(RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4));
			rc1 := __common__(map(
				riTemp[1].hri <> '00' => riTemp,
				RVR1003_2 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
				RiskWise.rvReasonCodes(le, 4, inCalif)
			));
			rc3 := __common__(riskwise.rv3retailReasonCodes( le, 4, inCalif, PreScreenOptOut ));
			//
			
			self.ri := __common__(if( useRVReasons1, rc1, rc3 ));
			self.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				intformat(RVR1003_2,3,1)
			);
		#end


	END;
	
	scored := project( clam, doModel(left) );
	return scored;
END;



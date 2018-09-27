import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVB1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean PreScreenOptOut=false ) := FUNCTION

	RVB_DEBUG := false;
	
	#if(RVB_DEBUG)
	Layout_Debug := record
		integer seq;
		Integer did;
		Boolean trueDID;
		String adl_category;
		String out_unit_desig;
		String out_sec_range;
		String out_st;
		String out_addr_type;
		String out_addr_status;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String nap_status;
		Integer did_count;
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
		Integer rc_ssnhighissue;
		String rc_areacodesplitflag;
		Integer rc_areacodesplitdate;
		String rc_addrvalflag;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		Integer rc_fnamecount;
		Integer rc_lnamecount;
		Integer rc_addrcount;
		Integer rc_phonelnamecount;
		Integer rc_phonephonecount;
		String rc_hrisksic;
		Integer rc_disthphoneaddr;
		String rc_phonetype;
		String rc_ziptypeflag;
		String rc_cityzipflag;
		Boolean rc_fnamessnmatch;
		Integer combo_dobscore;
		Integer combo_fnamecount;
		Integer combo_addrcount;
		Integer combo_ssncount;
		Integer combo_dobcount;
		Boolean rc_watchlist_flag;
		Integer EQ_count;
		Integer PR_count;
		Integer adl_EQ_first_seen;
		Integer adl_EN_first_seen;
		Integer adl_PR_first_seen;
		Integer adl_EM_first_seen;
		Integer adl_VO_first_seen;
		Integer adl_EM_only_first_seen;
		Integer adl_W_first_seen;
		String fname_sources;
		String lname_sources;
		String addr_sources;
		String ssn_sources;
		String em_only_sources;
		Boolean voter_avail;
		String ssnlength;
		Boolean dobpop;
		Integer lname_change_date;
		Boolean lname_eda_sourced;
		String lname_eda_sourced_type;
		Integer age;
		Boolean add1_isbestmatch;
		Integer add1_unit_count;
		Integer add1_lres;
		String add1_avm_land_use;
		String add1_avm_recording_date;
		String add1_avm_assessed_value_year;
		String add1_avm_market_total_value;
		Integer add1_avm_price_index_valuation;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_automated_valuation_2;
		Integer add1_avm_automated_valuation_3;
		Integer add1_avm_automated_valuation_4;
		Integer add1_avm_confidence_score;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Integer add1_naprop;
		Integer ADD1_PURCHASE_AMOUNT;
		Integer add1_mortgage_date;
		String add1_mortgage_type;
		String add1_financing_type;
		String add1_mortgage_due_date;
		Integer ADD1_ASSESSED_AMOUNT;
		Integer add1_date_first_seen;
		String add1_land_use_code;
		String add1_building_area;
		String add1_no_of_rooms;
		String add1_no_of_baths;
		Boolean add1_pop;
		Integer PROPERTY_OWNED_TOTAL;
		Integer property_owned_assessed_total;
		Integer PROPERTY_SOLD_TOTAL;
		Integer property_sold_assessed_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Integer Add2_lres;
		String add2_avm_land_use;
		String add2_avm_sales_price;
		Integer add2_avm_tax_assessed_valuation;
		Integer add2_avm_price_index_valuation;
		Integer add2_avm_hedonic_valuation;
		Integer add2_avm_automated_valuation;
		Integer add2_avm_automated_valuation_2;
		Integer add2_avm_automated_valuation_3;
		Integer add2_avm_confidence_score;
		String add2_sources;
		Integer ADD2_NAPROP;
		String add2_building_area;
		String add2_no_of_buildings;
		String add2_garage_type_code;
		String add2_parking_no_of_cars;
		String add2_assessed_value_year;
		String add2_mortgage_due_date;
		Integer ADD2_ASSESSED_AMOUNT;
		Integer add2_date_first_seen;
		Boolean add2_pop;
		Integer Add3_lres;
		String add3_sources;
		Integer ADD3_NAPROP;
		String add3_mortgage_type;
		String add3_financing_type;
		Integer ADD3_ASSESSED_AMOUNT;
		Integer add3_date_first_seen;
		Boolean add3_pop;
		Integer addrs_5yr;
		Integer addrs_10yr;
		Integer addrs_15yr;
		Boolean addrs_prison_history;
		String gong_did_first_seen;
		Integer gong_did_phone_ct;
		Integer header_first_seen;
		String inputssncharflag;
		Integer ssns_per_adl;
		Integer addrs_per_adl;
		Integer phones_per_adl;
		Integer adlPerSSN_count;
		Integer adls_per_addr;
		Integer ssns_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer ssns_per_addr_c6;
		Integer adls_per_phone_c6;
		Integer vo_addrs_per_adl;
		Integer invalid_addrs_per_adl_c6;
		Integer infutor_first_seen;
		Integer infutor_nap;
		Integer impulse_count;
		Integer attr_addrs_last90;
		Integer attr_addrs_last12;
		Integer attr_addrs_last24;
		Integer attr_num_sold180;
		Integer attr_num_watercraft60;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Integer attr_eviction_count30;
		Integer attr_eviction_count90;
		Integer attr_eviction_count180;
		Integer attr_eviction_count12;
		Integer attr_eviction_count24;
		Integer attr_eviction_count36;
		Integer attr_eviction_count60;
		Integer attr_num_nonderogs90;
		Boolean Bankrupt;
		Integer date_last_seen;
		String filing_type;
		String disposition;
		Integer filing_count;
		Integer bk_recent_count;
		Integer bk_disposed_historical_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		String liens_last_unrel_date;
		Integer liens_unrel_cj_ct;
		Integer liens_unrel_cj_last_seen;
		Integer liens_unrel_ft_ct;
		Integer liens_unrel_lt_ct;
		Integer liens_unrel_o_ct;
		Integer liens_unrel_ot_ct;
		Integer liens_unrel_ot_total_amount;
		Integer liens_unrel_sc_ct;
		Integer criminal_count;
		Integer criminal_last_date;
		Integer felony_last_date;
		Integer ams_dob;
		String ams_class;
		String ams_college_code;
		String ams_college_type;
		String ams_income_level_code;
		Boolean prof_license_flag;
		String prof_license_category;
		String wealth_index;
		String input_dob_match_level;
		Integer inferred_age;
		Integer reported_dob;
		Integer archive_date;
		Integer sysdate;
		Integer sysyear;
		Integer _daycap_b1;
		Integer in_dob2;
		Integer _y;
		Integer _m;
		Integer _d;
		Integer _daycap;
		Real years_in_dob;
		Integer _daycap_b1_2;
		Integer rc_ssnhighissue2;
		Integer _y_2;
		Integer _m_2;
		Integer _d_2;
		Integer _daycap_2;
		Real years_rc_ssnhighissue;
		Integer _daycap_b1_3;
		Integer _y_3;
		Integer _m_3;
		Integer _d_3;
		Integer _daycap_3;
		Integer rc_areacodesplitdate2;
		Real years_rc_areacodesplitdate;
		Integer _daycap_b1_4;
		Integer adl_eq_first_seen2;
		Integer _y_4;
		Integer _m_4;
		Integer _d_4;
		Integer _daycap_4;
		Real years_adl_eq_first_seen;
		Real months_adl_eq_first_seen;
		Integer _daycap_b1_5;
		Integer _y_5;
		Integer _m_5;
		Integer adl_en_first_seen2;
		Integer _d_5;
		Integer _daycap_5;
		Real years_adl_en_first_seen;
		Real months_adl_en_first_seen;
		Integer _daycap_b1_6;
		Integer _y_6;
		Integer _m_6;
		Integer adl_pr_first_seen2;
		Integer _d_6;
		Integer _daycap_6;
		Real years_adl_pr_first_seen;
		Real months_adl_pr_first_seen;
		Integer _daycap_b1_7;
		Integer adl_em_first_seen2;
		Integer _y_7;
		Integer _m_7;
		Integer _d_7;
		Integer _daycap_7;
		Real years_adl_em_first_seen;
		Real months_adl_em_first_seen;
		Integer _daycap_b1_8;
		Integer adl_vo_first_seen2;
		Integer _y_8;
		Integer _m_8;
		Integer _d_8;
		Integer _daycap_8;
		Real years_adl_vo_first_seen;
		Real months_adl_vo_first_seen;
		Integer _daycap_b1_9;
		Integer _y_9;
		Integer _m_9;
		Integer _d_9;
		Integer _daycap_9;
		Integer adl_em_only_first_seen2;
		Real years_adl_em_only_first_seen;
		Real months_adl_em_only_first_seen;
		Integer _daycap_b1_10;
		Integer adl_w_first_seen2;
		Integer _y_10;
		Integer _m_10;
		Integer _d_10;
		Integer _daycap_10;
		Real years_adl_w_first_seen;
		Real months_adl_w_first_seen;
		Integer _daycap_b1_11;
		Integer _y_11;
		Integer _m_11;
		Integer _d_11;
		Integer lname_change_date2;
		Integer _daycap_11;
		Real years_lname_change_date;
		Integer _daycap_b1_12;
		Integer _y_12;
		Integer add1_avm_recording_date2;
		Integer _m_12;
		Integer _d_12;
		Integer _daycap_12;
		Real years_add1_avm_recording_date;
		Integer _daycap_b1_13;
		Integer _y_13;
		Integer _m_13;
		Integer add1_avm_assessed_value_year2;
		Integer _d_13;
		Integer _daycap_13;
		Real years_add1_avm_assess_year;
		Integer _daycap_b1_14;
		Integer _y_14;
		Integer _m_14;
		Integer _d_14;
		Integer add1_mortgage_date2;
		Integer _daycap_14;
		Real years_add1_mortgage_date;
		Integer _daycap_b1_15;
		Integer _y_15;
		Integer _m_15;
		Integer add1_mortgage_due_date2;
		Integer _d_15;
		Integer _daycap_15;
		Real years_add1_mortgage_due_date;
		Integer _daycap_b1_16;
		Integer add1_date_first_seen2;
		Integer _y_16;
		Integer _m_16;
		Integer _d_16;
		Integer _daycap_16;
		Real years_add1_date_first_seen;
		Real months_add1_date_first_seen;
		Integer _daycap_b1_17;
		Integer _y_17;
		Integer _m_17;
		Integer add2_assessed_value_year2;
		Integer _d_17;
		Integer _daycap_17;
		Real years_add2_assessed_value_year;
		Integer _daycap_b1_18;
		Integer _y_18;
		Integer _m_18;
		Integer add2_mortgage_due_date2;
		Integer _d_18;
		Integer _daycap_18;
		Real years_add2_mortgage_due_date;
		Integer _daycap_b1_19;
		Integer add2_date_first_seen2;
		Integer _y_19;
		Integer _m_19;
		Integer _d_19;
		Integer _daycap_19;
		Real years_add2_date_first_seen;
		Real months_add2_date_first_seen;
		Integer _daycap_b1_20;
		Integer _y_20;
		Integer _m_20;
		Integer add3_date_first_seen2;
		Integer _d_20;
		Integer _daycap_20;
		Real years_add3_date_first_seen;
		Real months_add3_date_first_seen;
		Integer _daycap_b1_21;
		Integer _y_21;
		Integer _m_21;
		Integer _d_21;
		Integer _daycap_21;
		Integer gong_did_first_seen2;
		Real years_gong_did_first_seen;
		Integer _daycap_b1_22;
		Integer header_first_seen2;
		Integer _y_22;
		Integer _m_22;
		Integer _d_22;
		Integer _daycap_22;
		Real years_header_first_seen;
		Integer _daycap_b1_23;
		Integer _y_23;
		Integer _m_23;
		Integer _d_23;
		Integer infutor_first_seen2;
		Integer _daycap_23;
		Real years_infutor_first_seen;
		Integer _daycap_b1_24;
		Integer _y_24;
		Integer _m_24;
		Integer _d_24;
		Integer date_last_seen2;
		Integer _daycap_24;
		Real years_date_last_seen;
		Integer _daycap_b1_25;
		Integer _y_25;
		Integer _m_25;
		Integer _d_25;
		Integer _daycap_25;
		Integer liens_last_unrel_date2;
		Real years_liens_last_unrel_date;
		Integer _daycap_b1_26;
		Integer _y_26;
		Integer _m_26;
		Integer _d_26;
		Integer liens_unrel_cj_last_seen2;
		Integer _daycap_26;
		Real years_liens_unrel_cj_last_seen;
		Integer _daycap_b1_27;
		Integer criminal_last_date2;
		Integer _y_27;
		Integer _m_27;
		Integer _d_27;
		Integer _daycap_27;
		Real years_criminal_last_date;
		Integer _daycap_b1_28;
		Integer _y_28;
		Integer felony_last_date2;
		Integer _m_28;
		Integer _d_28;
		Integer _daycap_28;
		Real years_felony_last_date;
		Integer _daycap_b1_29;
		Integer ams_dob2;
		Integer _y_29;
		Integer _m_29;
		Integer _d_29;
		Integer _daycap_29;
		Real years_ams_dob;
		Integer _daycap_b1_30;
		Integer _y_30;
		Integer _m_30;
		Integer _d_30;
		Integer _daycap_30;
		Integer reported_dob2;
		Real years_reported_dob;
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
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean source_tot_P;
		Boolean source_tot_W;
		Boolean source_tot_voter;
		Boolean source_fst_P;
		Boolean source_fst_PL;
		Boolean source_lst_P;
		Boolean source_lst_PL;
		Boolean source_add_P;
		Boolean source_add_PL;
		Boolean source_ssn_P;
		Boolean source_add2_EM;
		Boolean source_add2_VO;
		Boolean source_add2_EQ;
		Boolean source_add2_P;
		Boolean source_add2_WP;
		Boolean source_add2_voter;
		Boolean source_add3_P;
		Integer nas_summary_p;
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
		Boolean phn_disconnected;
		Boolean phn_inval;
		Boolean phn_highrisk2;
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
		Integer pk_yr_adl_em_only_first_seen;
		Integer pk_yr_adl_first_seen_max_fcra;
		Integer pk_mo_adl_first_seen_max_fcra;
		Integer pk_yr_lname_change_date;
		Integer pk_yr_gong_did_first_seen;
		Integer pk_yr_header_first_seen;
		Integer pk_yr_infutor_first_seen;
		Integer pk_multi_did;
		Integer pk_nas_summary;
		Integer pk_nap_summary;
		Integer pk_combo_fnamecount;
		Integer pk_combo_fnamecount_nb;
		Integer pk_rc_fnamecount;
		Integer pk_rc_lnamecount_nb;
		Integer pk_rc_phonelnamecount;
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
		Integer pk_lname_eda_sourced_type_lvl;
		Integer pk_add1_unit_count2;
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
		Integer pk_em_only_ver_lvl;
		Integer pk_add2_em_ver_lvl;
		Integer pk_infutor_risk_lvl;
		Integer pk_infutor_risk_lvl_nb;
		Integer pk_yr_adl_em_only_first_seen2;
		Integer pk_yrmo_adl_first_seen_max_fcra2;
		Integer pk_yr_lname_change_date2;
		Integer pk_yr_gong_did_first_seen2;
		Integer pk_yr_header_first_seen2;
		Integer pk_yr_infutor_first_seen2;
		Integer pk_estimated_income;
		Integer pk_yr_adl_pr_first_seen;
		Integer pk_yr_adl_w_first_seen;
		Integer pk_yr_add1_mortgage_date;
		Integer pk_yr_add1_mortgage_due_date;
		Integer pk_yr_add1_date_first_seen;
		Integer pk_yr_add2_assessed_value_year;
		Integer pk_yr_add2_mortgage_due_date;
		Integer pk_yr_add2_date_first_seen;
		Integer pk_yr_add3_date_first_seen;
		Integer pk_property_owned_assessed_total;
		Integer pk_add1_purchase_amount;
		Integer pk_add1_assessed_amount;
		Integer pk_add2_assessed_amount;
		Integer pk_add3_assessed_amount;
		Integer pk_property_owned_assessed_total_2;
		Integer pk_add1_purchase_amount_2;
		Integer pk_add1_assessed_amount_2;
		Integer pk_add2_assessed_amount_2;
		Integer pk_add3_assessed_amount_2;
		Integer pk_add1_building_area;
		Integer pk_add2_building_area;
		Integer pk_yr_adl_pr_first_seen2;
		Integer pk_yr_adl_w_first_seen2;
		Integer pk_pr_count;
		Integer pk_nas_summary_p;
		Integer pk_addrs_sourced_lvl;
		Integer pk_naprop_level;
		Integer pk_naprop_level2_b1;
		Integer pk_naprop_level2;
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
		Integer pk_add1_no_of_rooms;
		Integer pk_add1_no_of_baths;
		Integer pk_property_owned_total;
		Integer pk_prop_own_assess_tot2;
		Integer pk_add2_building_area2;
		Integer pk_add2_no_of_buildings;
		Integer pk_add2_garage_type_risk_level;
		Integer pk_add2_parking_no_of_cars;
		Integer pk_yr_add2_assessed_value_year2;
		Integer pk_yr_add2_mortgage_due_date2;
		Integer pk_add2_assessed_amount2;
		Integer pk_yr_add2_date_first_seen2;
		Integer pk_add3_mortgage_risk;
		Integer pk_add3_adjustable_financing;
		Integer pk_add3_assessed_amount2;
		Integer pk_yr_add3_date_first_seen2;
		Integer pk_attr_num_sold180;
		Integer pk_yr_liens_last_unrel_date;
		Integer pk_yr_criminal_last_date;
		Integer pk_yr_felony_last_date;
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
		Integer pk_attr_eviction_count;
		Integer pk_eviction_level;
		Integer pk_yr_criminal_last_date2;
		Integer pk_yr_felony_last_date2;
		Integer pk_yr_rc_ssnhighissue;
		Integer pk_yr_rc_areacodesplitdate;
		Integer pk_add_standarization_error;
		Integer pk_addr_changed;
		Integer pk_unit_changed;
		Integer pk_add_standarization_flag;
		Integer pk_addr_not_valid;
		Integer pk_corp_mil_zip;
		Integer pk_area_code_split;
		Integer pk_recent_ac_split;
		Boolean pk_phn_not_residential;
		Integer pk_disconnected;
		Integer pk_phn_cell_pager_inval;
		Integer pk_yr_rc_ssnhighissue2;
		Integer pk_pl_sourced_level;
		Integer pk_prof_lic_cat;
		Integer pk_add_lres_month_avg;
		Integer pk_add1_lres;
		Integer pk_add2_lres;
		Integer pk_add3_lres;
		Integer pk_add1_lres_flag;
		Integer pk_add2_lres_flag;
		Integer pk_add3_lres_flag;
		Integer pk_lres_flag_level;
		Integer pk_addrs_5yr;
		Integer pk_addrs_15yr;
		Integer pk_add_lres_month_avg2;
		Integer pk_ssns_per_adl;
		Integer pk_addrs_per_adl;
		Integer pk_phones_per_adl;
		Integer pk_adlperssn_count;
		Integer pk_adls_per_addr_b1;
		Integer pk_ssns_per_addr2_b1;
		Integer pk_adls_per_addr_b2;
		Integer pk_ssns_per_addr2_b2;
		Integer pk_adls_per_addr;
		Integer pk_ssns_per_addr2;
		Integer pk_adls_per_phone;
		Integer pk_ssns_per_adl_c6;
		Integer pk_ssns_per_addr_c6_b1;
		Integer pk_ssns_per_addr_c6_b2;
		Integer pk_ssns_per_addr_c6;
		Integer pk_adls_per_phone_c6;
		Integer pk_vo_addrs_per_adl;
		Integer pk_attr_addrs_last90;
		Integer pk_attr_addrs_last12;
		Integer pk_attr_addrs_last24;
		Real ams_class_n_b8;
		Real ams_class_n_b8_2;
		Integer pk_ams_class_level_b8;
		Real pk_since_ams_class_year;
		Real ams_class_n;
		Integer pk_ams_class_level;
		Integer pk_ams_4yr_college;
		Integer pk_ams_college_type;
		Integer pk_ams_income_level_code;
		Integer pk_yr_in_dob;
		Integer pk_yr_ams_dob;
		Integer pk_yr_reported_dob;
		Integer pk_yr_in_dob2;
		Integer pk_yr_ams_dob2;
		Integer pk_inferred_age;
		Integer pk_yr_reported_dob2;
		Integer pk_yr_add1_avm_recording_date;
		Integer pk_yr_add1_avm_assess_year;
		Integer pk_add1_avm_mkt;
		Integer pk_add1_avm_pi;
		Integer pk_add1_avm_auto;
		Integer pk_add1_avm_auto2;
		Integer pk_add1_avm_auto3;
		Integer pk_add1_avm_auto4;
		Integer pk_add1_avm_med;
		Integer pk_add2_avm_sp;
		Integer pk_add2_avm_ta;
		Integer pk_add2_avm_pi;
		Integer pk_add2_avm_hed;
		Integer pk_add2_avm_auto;
		Integer pk_add2_avm_auto2;
		Integer pk_add2_avm_auto3;
		Integer pk_add1_avm_mkt_2;
		Integer pk_add1_avm_pi_2;
		Integer pk_add1_avm_auto_2;
		Integer pk_add1_avm_auto2_2;
		Integer pk_add1_avm_auto3_2;
		Integer pk_add1_avm_auto4_2;
		Integer pk_add1_avm_med_2;
		Integer pk_add2_avm_sp_2;
		Integer pk_add2_avm_ta_2;
		Integer pk_add2_avm_pi_2;
		Integer pk_add2_avm_hed_2;
		Integer pk_add2_avm_auto_2;
		Integer pk_add2_avm_auto2_2;
		Integer pk_add2_avm_auto3_2;
		Real pk_add1_avm_to_med_ratio;
		Real pk_add1_avm_to_med_ratio_2;
		Integer pk_add1_avm_confidence_score;
		Integer pk2_add1_avm_mkt;
		Integer pk2_add1_avm_pi;
		Integer pk2_add1_avm_auto;
		Integer pk2_add1_avm_auto2;
		Integer pk2_add1_avm_auto3;
		Integer pk_avm_auto_diff2;
		Integer pk_avm_auto_diff4;
		Integer pk_avm_auto_diff2_lvl;
		Integer pk_avm_auto_diff4_lvl;
		Integer pk2_add1_avm_med;
		Integer pk2_add1_avm_to_med_ratio;
		Integer pk_add2_avm_hit;
		Integer pk_avm_hit_level;
		Integer pk_add2_avm_confidence_score;
		Integer pk_avm_confidence_level;
		Integer pk2_add2_avm_sp;
		Integer pk2_add2_avm_ta;
		Integer pk2_add2_avm_pi;
		Integer pk2_add2_avm_hed;
		Integer pk2_add2_avm_auto;
		Integer pk2_add2_avm_auto3;
		Integer pk_add2_avm_auto_diff2;
		Integer pk_add2_avm_auto_diff2_lvl;
		Integer pk2_yr_add1_avm_recording_date;
		Integer pk2_yr_add1_avm_assess_year;
		Integer pk_dist_a1toa2_2;
		Integer pk_dist_a1toa3_2;
		Integer pk_rc_disthphoneaddr_2;
		Integer pk_out_st_division_lvl;
		Integer pk_wealth_index_2;
		Integer pk_impulse_count;
		Integer pk_impulse_count_2;
		Integer pk_attr_total_number_derogs_3;
		Integer pk_attr_total_number_derogs_4;
		Integer pk_attr_num_nonderogs90_3;
		Integer pk_attr_num_nonderogs90_4;
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
		Real pk_combo_fnamecount_mm_b1_c2_b1;
		Real pk_rc_fnamecount_mm_b1_c2_b1;
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
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
		Real pk_add2_pos_sources_mm_b1_c2_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
		Real pk_infutor_risk_lvl_mm_b1_c2_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
		Real pk_yr_lname_change_date2_mm_b1_c2_b1;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
		Real pk_yr_header_first_seen2_mm_b1_c2_b1;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b1;
		Real pk_em_only_ver_lvl_mm_b1_c2_b1;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
		Real pk_nas_summary_mm_b1_c2_b2;
		Real pk_nap_summary_mm_b1_c2_b2;
		Real pk_combo_fnamecount_mm_b1_c2_b2;
		Real pk_rc_fnamecount_mm_b1_c2_b2;
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
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
		Real pk_add2_pos_sources_mm_b1_c2_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
		Real pk_infutor_risk_lvl_mm_b1_c2_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
		Real pk_yr_lname_change_date2_mm_b1_c2_b2;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
		Real pk_yr_header_first_seen2_mm_b1_c2_b2;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b2;
		Real pk_em_only_ver_lvl_mm_b1_c2_b2;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
		Real pk_nas_summary_mm_b1_c2_b3;
		Real pk_nap_summary_mm_b1_c2_b3;
		Real pk_combo_fnamecount_mm_b1_c2_b3;
		Real pk_rc_fnamecount_mm_b1_c2_b3;
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
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
		Real pk_add2_pos_sources_mm_b1_c2_b3;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
		Real pk_infutor_risk_lvl_mm_b1_c2_b3;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
		Real pk_yr_lname_change_date2_mm_b1_c2_b3;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
		Real pk_yr_header_first_seen2_mm_b1_c2_b3;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b3;
		Real pk_em_only_ver_lvl_mm_b1_c2_b3;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b3;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
		Real pk_nas_summary_mm_b1_c2_b4;
		Real pk_nap_summary_mm_b1_c2_b4;
		Real pk_combo_fnamecount_mm_b1_c2_b4;
		Real pk_rc_fnamecount_mm_b1_c2_b4;
		Real pk_rc_phonelnamecount_mm_b1_c2_b4;
		Real pk_rc_addrcount_mm_b1_c2_b4;
		Real pk_rc_phonephonecount_mm_b1_c2_b4;
		Real pk_ver_phncount_mm_b1_c2_b4;
		Real pk_gong_did_phone_ct_mm_b1_c2_b4;
		Real pk_combo_ssncount_mm_b1_c2_b4;
		Real pk_combo_dobcount_mm_b1_c2_b4;
		Real pk_eq_count_mm_b1_c2_b4;
		Real pk_pos_secondary_sources_mm_b1_c2_b4;
		Real pk_voter_flag_mm_b1_c2_b4;
		Real pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4;
		Real pk_add2_pos_sources_mm_b1_c2_b4;
		Real pk_ssnchar_invalid_or_recent_mm_b1_c2_b4;
		Real pk_infutor_risk_lvl_mm_b1_c2_b4;
		Real pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4;
		Real pk_yr_lname_change_date2_mm_b1_c2_b4;
		Real pk_yr_gong_did_first_seen2_mm_b1_c2_b4;
		Real pk_yr_header_first_seen2_mm_b1_c2_b4;
		Real pk_yr_infutor_first_seen2_mm_b1_c2_b4;
		Real pk_em_only_ver_lvl_mm_b1_c2_b4;
		Real pk_add2_em_ver_lvl_mm_b1_c2_b4;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
		Real pk_nap_summary_mm_b1;
		Real pk_yr_gong_did_first_seen2_mm_b1;
		Real pk_gong_did_phone_ct_mm_b1;
		Real pk_rc_addrcount_mm_b1;
		Real pk_nas_summary_mm_b1;
		Real pk_yr_infutor_first_seen2_mm_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b1;
		Real pk_yr_lname_change_date2_mm_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b1;
		Real pk_add2_em_ver_lvl_mm_b1;
		Real pk_rc_phonelnamecount_mm_b1;
		Real pk_yr_header_first_seen2_mm_b1;
		Real pk_eq_count_mm_b1;
		Real pk_em_only_ver_lvl_mm_b1;
		Real pk_combo_ssncount_mm_b1;
		Real pk_combo_fnamecount_mm_b1;
		Real pk_pos_secondary_sources_mm_b1;
		Real pk_rc_phonephonecount_mm_b1;
		Real pk_voter_flag_mm_b1;
		Real pk_rc_fnamecount_mm_b1;
		Real pk_add2_pos_sources_mm_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
		Real pk_infutor_risk_lvl_mm_b1;
		Real pk_lname_eda_sourced_type_lvl_mm_b1;
		Real pk_ver_phncount_mm_b1;
		Real pk_combo_dobcount_mm_b1;
		Real pk_nas_summary_mm_b2_c2_b1;
		Real pk_nap_summary_mm_b2_c2_b1;
		Real pk_combo_fnamecount_nb_mm_b2_c2_b1;
		Real pk_rc_lnamecount_nb_mm_b2_c2_b1;
		Real pk_rc_phonelnamecount_mm_b2_c2_b1;
		Real pk_rc_addrcount_nb_mm_b2_c2_b1;
		Real pk_rc_phonephonecount_mm_b2_c2_b1;
		Real pk_ver_phncount_mm_b2_c2_b1;
		Real pk_gong_did_phone_ct_nb_mm_b2_c2_b1;
		Real pk_combo_ssncount_mm_b2_c2_b1;
		Real pk_combo_dobcount_nb_mm_b2_c2_b1;
		Real pk_eq_count_mm_b2_c2_b1;
		Real pk_pos_secondary_sources_mm_b2_c2_b1;
		Real pk_voter_flag_mm_b2_c2_b1;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
		Real pk_add2_pos_sources_mm_b2_c2_b1;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
		Real pk_yr_lname_change_date2_mm_b2_c2_b1;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
		Real pk_yr_header_first_seen2_mm_b2_c2_b1;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b1;
		Real pk_em_only_ver_lvl_mm_b2_c2_b1;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
		Real pk_nas_summary_mm_b2_c2_b2;
		Real pk_nap_summary_mm_b2_c2_b2;
		Real pk_combo_fnamecount_nb_mm_b2_c2_b2;
		Real pk_rc_lnamecount_nb_mm_b2_c2_b2;
		Real pk_rc_phonelnamecount_mm_b2_c2_b2;
		Real pk_rc_addrcount_nb_mm_b2_c2_b2;
		Real pk_rc_phonephonecount_mm_b2_c2_b2;
		Real pk_ver_phncount_mm_b2_c2_b2;
		Real pk_gong_did_phone_ct_nb_mm_b2_c2_b2;
		Real pk_combo_ssncount_mm_b2_c2_b2;
		Real pk_combo_dobcount_nb_mm_b2_c2_b2;
		Real pk_eq_count_mm_b2_c2_b2;
		Real pk_pos_secondary_sources_mm_b2_c2_b2;
		Real pk_voter_flag_mm_b2_c2_b2;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
		Real pk_add2_pos_sources_mm_b2_c2_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
		Real pk_yr_lname_change_date2_mm_b2_c2_b2;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
		Real pk_yr_header_first_seen2_mm_b2_c2_b2;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b2;
		Real pk_em_only_ver_lvl_mm_b2_c2_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
		Real pk_nas_summary_mm_b2_c2_b3;
		Real pk_nap_summary_mm_b2_c2_b3;
		Real pk_combo_fnamecount_nb_mm_b2_c2_b3;
		Real pk_rc_lnamecount_nb_mm_b2_c2_b3;
		Real pk_rc_phonelnamecount_mm_b2_c2_b3;
		Real pk_rc_addrcount_nb_mm_b2_c2_b3;
		Real pk_rc_phonephonecount_mm_b2_c2_b3;
		Real pk_ver_phncount_mm_b2_c2_b3;
		Real pk_gong_did_phone_ct_nb_mm_b2_c2_b3;
		Real pk_combo_ssncount_mm_b2_c2_b3;
		Real pk_combo_dobcount_nb_mm_b2_c2_b3;
		Real pk_eq_count_mm_b2_c2_b3;
		Real pk_pos_secondary_sources_mm_b2_c2_b3;
		Real pk_voter_flag_mm_b2_c2_b3;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
		Real pk_add2_pos_sources_mm_b2_c2_b3;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
		Real pk_yr_lname_change_date2_mm_b2_c2_b3;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
		Real pk_yr_header_first_seen2_mm_b2_c2_b3;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b3;
		Real pk_em_only_ver_lvl_mm_b2_c2_b3;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
		Real pk_nas_summary_mm_b2_c2_b4;
		Real pk_nap_summary_mm_b2_c2_b4;
		Real pk_combo_fnamecount_nb_mm_b2_c2_b4;
		Real pk_rc_lnamecount_nb_mm_b2_c2_b4;
		Real pk_rc_phonelnamecount_mm_b2_c2_b4;
		Real pk_rc_addrcount_nb_mm_b2_c2_b4;
		Real pk_rc_phonephonecount_mm_b2_c2_b4;
		Real pk_ver_phncount_mm_b2_c2_b4;
		Real pk_gong_did_phone_ct_nb_mm_b2_c2_b4;
		Real pk_combo_ssncount_mm_b2_c2_b4;
		Real pk_combo_dobcount_nb_mm_b2_c2_b4;
		Real pk_eq_count_mm_b2_c2_b4;
		Real pk_pos_secondary_sources_mm_b2_c2_b4;
		Real pk_voter_flag_mm_b2_c2_b4;
		Real pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4;
		Real pk_add2_pos_sources_mm_b2_c2_b4;
		Real pk_ssnchar_invalid_or_recent_mm_b2_c2_b4;
		Real pk_infutor_risk_lvl_nb_mm_b2_c2_b4;
		Real pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4;
		Real pk_yr_lname_change_date2_mm_b2_c2_b4;
		Real pk_yr_gong_did_first_seen2_mm_b2_c2_b4;
		Real pk_yr_header_first_seen2_mm_b2_c2_b4;
		Real pk_yr_infutor_first_seen2_mm_b2_c2_b4;
		Real pk_em_only_ver_lvl_mm_b2_c2_b4;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
		Real pk_nap_summary_mm_b2;
		Real pk_yr_gong_did_first_seen2_mm_b2;
		Real pk_nas_summary_mm_b2;
		Real pk_yr_infutor_first_seen2_mm_b2;
		Real pk_yr_adl_em_only_first_seen2_mm_b2;
		Real pk_yr_lname_change_date2_mm_b2;
		Real pk_ssnchar_invalid_or_recent_mm_b2;
		Real pk_infutor_risk_lvl_nb_mm_b2;
		Real pk_gong_did_phone_ct_nb_mm_b2;
		Real pk_combo_dobcount_nb_mm_b2;
		Real pk_rc_phonelnamecount_mm_b2;
		Real pk_yr_header_first_seen2_mm_b2;
		Real pk_eq_count_mm_b2;
		Real pk_combo_fnamecount_nb_mm_b2;
		Real pk_em_only_ver_lvl_mm_b2;
		Real pk_rc_lnamecount_nb_mm_b2;
		Real pk_combo_ssncount_mm_b2;
		Real pk_pos_secondary_sources_mm_b2;
		Real pk_rc_phonephonecount_mm_b2;
		Real pk_voter_flag_mm_b2;
		Real pk_rc_addrcount_nb_mm_b2;
		Real pk_add2_pos_sources_mm_b2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
		Real pk_lname_eda_sourced_type_lvl_mm_b2;
		Real pk_ver_phncount_mm_b2;
		Real pk_nap_summary_mm;
		Real pk_yr_infutor_first_seen2_mm;
		Real pk_yr_lname_change_date2_mm;
		Real pk_ssnchar_invalid_or_recent_mm;
		Real pk_gong_did_phone_ct_nb_mm;
		Real pk_combo_dobcount_nb_mm;
		Real pk_rc_phonelnamecount_mm;
		Real pk_combo_fnamecount_nb_mm;
		Real pk_rc_lnamecount_nb_mm;
		Real pk_combo_ssncount_mm;
		Real pk_pos_secondary_sources_mm;
		Real pk_voter_flag_mm;
		Real pk_rc_fnamecount_mm;
		Real pk_lname_eda_sourced_type_lvl_mm;
		Real pk_ver_phncount_mm;
		Real pk_combo_dobcount_mm;
		Real pk_nas_summary_mm;
		Real pk_rc_addrcount_mm;
		Real pk_gong_did_phone_ct_mm;
		Real pk_yr_gong_did_first_seen2_mm;
		Real pk_yr_adl_em_only_first_seen2_mm;
		Real pk_add2_em_ver_lvl_mm;
		Real pk_infutor_risk_lvl_nb_mm;
		Real pk_eq_count_mm;
		Real pk_yr_header_first_seen2_mm;
		Real pk_em_only_ver_lvl_mm;
		Real pk_combo_fnamecount_mm;
		Real pk_rc_phonephonecount_mm;
		Real pk_add2_pos_sources_mm;
		Real pk_rc_addrcount_nb_mm;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm;
		Real pk_infutor_risk_lvl_mm;
		Real pk_estimated_income_mm_b1;
		Real pk_yr_adl_pr_first_seen2_mm_b1;
		Real pk_yr_adl_w_first_seen2_mm_b1;
		Real pk_pr_count_mm_b1;
		Real pk_addrs_sourced_lvl_mm_b1;
		Real pk_naprop_level2_mm_b1;
		Real pk_add1_purchase_amount2_mm_b1;
		Real pk_yr_add1_mortgage_date2_mm_b1;
		Real pk_add1_mortgage_risk_mm_b1;
		Real pk_add1_assessed_amount2_mm_b1;
		Real pk_yr_add1_mortgage_due_date2_mm_b1;
		Real pk_yr_add1_date_first_seen2_mm_b1;
		Real pk_add1_land_use_risk_level_mm_b1;
		Real pk_add1_building_area2_mm_b1;
		Real pk_add1_no_of_rooms_mm_b1;
		Real pk_add1_no_of_baths_mm_b1;
		Real pk_property_owned_total_mm_b1;
		Real pk_prop_own_assess_tot2_mm_b1;
		Real pk_add2_building_area2_mm_b1;
		Real pk_add2_no_of_buildings_mm_b1;
		Real pk_add2_garage_type_risk_lvl_mm_b1;
		Real pk_add2_parking_no_of_cars_mm_b1;
		Real pk_yr_add2_mortgage_due_date2_mm_b1;
		Real pk_add2_assessed_amount2_mm_b1;
		Real pk_yr_add2_date_first_seen2_mm_b1;
		Real pk_add3_mortgage_risk_mm_b1;
		Real pk_add3_assessed_amount2_mm_b1;
		Real pk_yr_add3_date_first_seen2_mm_b1;
		Real pk_bk_level_mm_b1;
		Real pk_eviction_level_mm_b1;
		Real pk_lien_type_level_mm_b1;
		Real pk_yr_liens_last_unrel_date3_mm_b1;
		Real pk_yr_criminal_last_date2_mm_b1;
		Real pk_yr_felony_last_date2_mm_b1;
		Real pk_attr_total_number_derogs_mm_b1;
		Real pk_yr_rc_ssnhighissue2_mm_b1;
		Real pk_pl_sourced_level_mm_b1;
		Real pk_prof_lic_cat_mm_b1;
		Real pk_add1_lres_mm_b1;
		Real pk_add2_lres_mm_b1;
		Real pk_add3_lres_mm_b1;
		Real pk_lres_flag_level_mm_b1;
		Real pk_addrs_5yr_mm_b1;
		Real pk_addrs_15yr_mm_b1;
		Real pk_add_lres_month_avg2_mm_b1;
		Real pk_ssns_per_adl_mm_b1;
		Real pk_addrs_per_adl_mm_b1;
		Real pk_phones_per_adl_mm_b1;
		Real pk_adlperssn_count_mm_b1;
		Real pk_adls_per_addr_mm_b1;
		Real pk_adls_per_phone_mm_b1;
		Real pk_ssns_per_adl_c6_mm_b1;
		Real pk_ssns_per_addr_c6_mm_b1;
		Real pk_adls_per_phone_c6_mm_b1;
		Real pk_attr_addrs_last90_mm_b1;
		Real pk_attr_addrs_last12_mm_b1;
		Real pk_attr_addrs_last24_mm_b1;
		Real pk_ams_class_level_mm_b1;
		Real pk_ams_4yr_college_mm_b1;
		Real pk_ams_college_type_mm_b1;
		Real pk_ams_income_level_code_mm_b1;
		Real pk_yr_in_dob2_mm_b1;
		Real pk_yr_ams_dob2_mm_b1;
		Real pk_inferred_age_mm_b1;
		Real pk_yr_reported_dob2_mm_b1;
		Real pk_avm_hit_level_mm_b1;
		Real pk_avm_auto_diff2_lvl_mm_b1;
		Real pk_avm_auto_diff4_lvl_mm_b1;
		Real pk_add2_avm_auto_diff2_lvl_mm_b1;
		Real pk_avm_confidence_level_mm_b1;
		Real pk2_add1_avm_mkt_mm_b1;
		Real pk2_add1_avm_pi_mm_b1;
		Real pk2_add1_avm_auto_mm_b1;
		Real pk2_add1_avm_auto2_mm_b1;
		Real pk2_add1_avm_auto3_mm_b1;
		Real pk2_add1_avm_med_mm_b1;
		Real pk2_add1_avm_to_med_ratio_mm_b1;
		Real pk2_add2_avm_sp_mm_b1;
		Real pk2_add2_avm_ta_mm_b1;
		Real pk2_add2_avm_pi_mm_b1;
		Real pk2_add2_avm_hed_mm_b1;
		Real pk2_add2_avm_auto_mm_b1;
		Real pk2_add2_avm_auto3_mm_b1;
		Real pk2_yr_add1_avm_rec_dt_mm_b1;
		Real pk2_yr_add1_avm_assess_year_mm_b1;
		Real pk_dist_a1toa2_mm_b1;
		Real pk_dist_a1toa3_mm_b1;
		Real pk_rc_disthphoneaddr_mm_b1;
		Real pk_out_st_division_lvl_mm_b1;
		Real pk_wealth_index_mm_b1;
		Real pk_attr_num_nonderogs90_b_mm_b1;
		Real pk_ssns_per_addr2_mm_b1;
		Real pk_yr_add2_assess_val_yr2_mm_b1;
		Real pk_estimated_income_mm_b2;
		Real pk_yr_adl_pr_first_seen2_mm_b2;
		Real pk_yr_adl_w_first_seen2_mm_b2;
		Real pk_pr_count_mm_b2;
		Real pk_addrs_sourced_lvl_mm_b2;
		Real pk_naprop_level2_mm_b2;
		Real pk_add1_purchase_amount2_mm_b2;
		Real pk_yr_add1_mortgage_date2_mm_b2;
		Real pk_add1_mortgage_risk_mm_b2;
		Real pk_add1_assessed_amount2_mm_b2;
		Real pk_yr_add1_mortgage_due_date2_mm_b2;
		Real pk_yr_add1_date_first_seen2_mm_b2;
		Real pk_add1_land_use_risk_level_mm_b2;
		Real pk_add1_building_area2_mm_b2;
		Real pk_add1_no_of_rooms_mm_b2;
		Real pk_add1_no_of_baths_mm_b2;
		Real pk_property_owned_total_mm_b2;
		Real pk_prop_own_assess_tot2_mm_b2;
		Real pk_add2_building_area2_mm_b2;
		Real pk_add2_no_of_buildings_mm_b2;
		Real pk_add2_garage_type_risk_lvl_mm_b2;
		Real pk_add2_parking_no_of_cars_mm_b2;
		Real pk_yr_add2_mortgage_due_date2_mm_b2;
		Real pk_add2_assessed_amount2_mm_b2;
		Real pk_yr_add2_date_first_seen2_mm_b2;
		Real pk_add3_mortgage_risk_mm_b2;
		Real pk_add3_assessed_amount2_mm_b2;
		Real pk_yr_add3_date_first_seen2_mm_b2;
		Real pk_bk_level_mm_b2;
		Real pk_eviction_level_mm_b2;
		Real pk_lien_type_level_mm_b2;
		Real pk_yr_liens_last_unrel_date3_mm_b2;
		Real pk_yr_criminal_last_date2_mm_b2;
		Real pk_yr_felony_last_date2_mm_b2;
		Real pk_attr_total_number_derogs_mm_b2;
		Real pk_yr_rc_ssnhighissue2_mm_b2;
		Real pk_pl_sourced_level_mm_b2;
		Real pk_prof_lic_cat_mm_b2;
		Real pk_add1_lres_mm_b2;
		Real pk_add2_lres_mm_b2;
		Real pk_add3_lres_mm_b2;
		Real pk_lres_flag_level_mm_b2;
		Real pk_addrs_5yr_mm_b2;
		Real pk_addrs_15yr_mm_b2;
		Real pk_add_lres_month_avg2_mm_b2;
		Real pk_ssns_per_adl_mm_b2;
		Real pk_addrs_per_adl_mm_b2;
		Real pk_phones_per_adl_mm_b2;
		Real pk_adlperssn_count_mm_b2;
		Real pk_adls_per_addr_mm_b2;
		Real pk_adls_per_phone_mm_b2;
		Real pk_ssns_per_adl_c6_mm_b2;
		Real pk_ssns_per_addr_c6_mm_b2;
		Real pk_adls_per_phone_c6_mm_b2;
		Real pk_attr_addrs_last90_mm_b2;
		Real pk_attr_addrs_last12_mm_b2;
		Real pk_attr_addrs_last24_mm_b2;
		Real pk_ams_class_level_mm_b2;
		Real pk_ams_4yr_college_mm_b2;
		Real pk_ams_college_type_mm_b2;
		Real pk_ams_income_level_code_mm_b2;
		Real pk_yr_in_dob2_mm_b2;
		Real pk_yr_ams_dob2_mm_b2;
		Real pk_inferred_age_mm_b2;
		Real pk_yr_reported_dob2_mm_b2;
		Real pk_avm_hit_level_mm_b2;
		Real pk_avm_auto_diff2_lvl_mm_b2;
		Real pk_avm_auto_diff4_lvl_mm_b2;
		Real pk_add2_avm_auto_diff2_lvl_mm_b2;
		Real pk_avm_confidence_level_mm_b2;
		Real pk2_add1_avm_mkt_mm_b2;
		Real pk2_add1_avm_pi_mm_b2;
		Real pk2_add1_avm_auto_mm_b2;
		Real pk2_add1_avm_auto2_mm_b2;
		Real pk2_add1_avm_auto3_mm_b2;
		Real pk2_add1_avm_med_mm_b2;
		Real pk2_add1_avm_to_med_ratio_mm_b2;
		Real pk2_add2_avm_sp_mm_b2;
		Real pk2_add2_avm_ta_mm_b2;
		Real pk2_add2_avm_pi_mm_b2;
		Real pk2_add2_avm_hed_mm_b2;
		Real pk2_add2_avm_auto_mm_b2;
		Real pk2_add2_avm_auto3_mm_b2;
		Real pk2_yr_add1_avm_rec_dt_mm_b2;
		Real pk2_yr_add1_avm_assess_year_mm_b2;
		Real pk_dist_a1toa2_mm_b2;
		Real pk_dist_a1toa3_mm_b2;
		Real pk_rc_disthphoneaddr_mm_b2;
		Real pk_out_st_division_lvl_mm_b2;
		Real pk_wealth_index_mm_b2;
		Real pk_attr_num_nonderogs90_b_mm_b2;
		Real pk_ssns_per_addr2_mm_b2;
		Real pk_yr_add2_assess_val_yr2_mm_b2;
		Real pk_estimated_income_mm_b3;
		Real pk_yr_adl_pr_first_seen2_mm_b3;
		Real pk_yr_adl_w_first_seen2_mm_b3;
		Real pk_pr_count_mm_b3;
		Real pk_addrs_sourced_lvl_mm_b3;
		Real pk_naprop_level2_mm_b3;
		Real pk_add1_purchase_amount2_mm_b3;
		Real pk_yr_add1_mortgage_date2_mm_b3;
		Real pk_add1_mortgage_risk_mm_b3;
		Real pk_add1_assessed_amount2_mm_b3;
		Real pk_yr_add1_mortgage_due_date2_mm_b3;
		Real pk_yr_add1_date_first_seen2_mm_b3;
		Real pk_add1_land_use_risk_level_mm_b3;
		Real pk_add1_building_area2_mm_b3;
		Real pk_add1_no_of_rooms_mm_b3;
		Real pk_add1_no_of_baths_mm_b3;
		Real pk_property_owned_total_mm_b3;
		Real pk_prop_own_assess_tot2_mm_b3;
		Real pk_add2_building_area2_mm_b3;
		Real pk_add2_no_of_buildings_mm_b3;
		Real pk_add2_garage_type_risk_lvl_mm_b3;
		Real pk_add2_parking_no_of_cars_mm_b3;
		Real pk_yr_add2_mortgage_due_date2_mm_b3;
		Real pk_add2_assessed_amount2_mm_b3;
		Real pk_yr_add2_date_first_seen2_mm_b3;
		Real pk_add3_mortgage_risk_mm_b3;
		Real pk_add3_assessed_amount2_mm_b3;
		Real pk_yr_add3_date_first_seen2_mm_b3;
		Real pk_bk_level_mm_b3;
		Real pk_eviction_level_mm_b3;
		Real pk_lien_type_level_mm_b3;
		Real pk_yr_liens_last_unrel_date3_mm_b3;
		Real pk_yr_criminal_last_date2_mm_b3;
		Real pk_yr_felony_last_date2_mm_b3;
		Real pk_attr_total_number_derogs_mm_b3;
		Real pk_yr_rc_ssnhighissue2_mm_b3;
		Real pk_pl_sourced_level_mm_b3;
		Real pk_prof_lic_cat_mm_b3;
		Real pk_add1_lres_mm_b3;
		Real pk_add2_lres_mm_b3;
		Real pk_add3_lres_mm_b3;
		Real pk_lres_flag_level_mm_b3;
		Real pk_addrs_5yr_mm_b3;
		Real pk_addrs_15yr_mm_b3;
		Real pk_add_lres_month_avg2_mm_b3;
		Real pk_ssns_per_adl_mm_b3;
		Real pk_addrs_per_adl_mm_b3;
		Real pk_phones_per_adl_mm_b3;
		Real pk_adlperssn_count_mm_b3;
		Real pk_adls_per_addr_mm_b3;
		Real pk_adls_per_phone_mm_b3;
		Real pk_ssns_per_adl_c6_mm_b3;
		Real pk_ssns_per_addr_c6_mm_b3;
		Real pk_adls_per_phone_c6_mm_b3;
		Real pk_attr_addrs_last90_mm_b3;
		Real pk_attr_addrs_last12_mm_b3;
		Real pk_attr_addrs_last24_mm_b3;
		Real pk_ams_class_level_mm_b3;
		Real pk_ams_4yr_college_mm_b3;
		Real pk_ams_college_type_mm_b3;
		Real pk_ams_income_level_code_mm_b3;
		Real pk_yr_in_dob2_mm_b3;
		Real pk_yr_ams_dob2_mm_b3;
		Real pk_inferred_age_mm_b3;
		Real pk_yr_reported_dob2_mm_b3;
		Real pk_avm_hit_level_mm_b3;
		Real pk_avm_auto_diff2_lvl_mm_b3;
		Real pk_avm_auto_diff4_lvl_mm_b3;
		Real pk_add2_avm_auto_diff2_lvl_mm_b3;
		Real pk_avm_confidence_level_mm_b3;
		Real pk2_add1_avm_mkt_mm_b3;
		Real pk2_add1_avm_pi_mm_b3;
		Real pk2_add1_avm_auto_mm_b3;
		Real pk2_add1_avm_auto2_mm_b3;
		Real pk2_add1_avm_auto3_mm_b3;
		Real pk2_add1_avm_med_mm_b3;
		Real pk2_add1_avm_to_med_ratio_mm_b3;
		Real pk2_add2_avm_sp_mm_b3;
		Real pk2_add2_avm_ta_mm_b3;
		Real pk2_add2_avm_pi_mm_b3;
		Real pk2_add2_avm_hed_mm_b3;
		Real pk2_add2_avm_auto_mm_b3;
		Real pk2_add2_avm_auto3_mm_b3;
		Real pk2_yr_add1_avm_rec_dt_mm_b3;
		Real pk2_yr_add1_avm_assess_year_mm_b3;
		Real pk_dist_a1toa2_mm_b3;
		Real pk_dist_a1toa3_mm_b3;
		Real pk_rc_disthphoneaddr_mm_b3;
		Real pk_out_st_division_lvl_mm_b3;
		Real pk_wealth_index_mm_b3;
		Real pk_attr_num_nonderogs90_b_mm_b3;
		Real pk_ssns_per_addr2_mm_b3;
		Real pk_yr_add2_assess_val_yr2_mm_b3;
		Real pk_estimated_income_mm_b4;
		Real pk_yr_adl_pr_first_seen2_mm_b4;
		Real pk_yr_adl_w_first_seen2_mm_b4;
		Real pk_pr_count_mm_b4;
		Real pk_addrs_sourced_lvl_mm_b4;
		Real pk_naprop_level2_mm_b4;
		Real pk_add1_purchase_amount2_mm_b4;
		Real pk_yr_add1_mortgage_date2_mm_b4;
		Real pk_add1_mortgage_risk_mm_b4;
		Real pk_add1_assessed_amount2_mm_b4;
		Real pk_yr_add1_mortgage_due_date2_mm_b4;
		Real pk_yr_add1_date_first_seen2_mm_b4;
		Real pk_add1_land_use_risk_level_mm_b4;
		Real pk_add1_building_area2_mm_b4;
		Real pk_add1_no_of_rooms_mm_b4;
		Real pk_add1_no_of_baths_mm_b4;
		Real pk_property_owned_total_mm_b4;
		Real pk_prop_own_assess_tot2_mm_b4;
		Real pk_add2_building_area2_mm_b4;
		Real pk_add2_no_of_buildings_mm_b4;
		Real pk_add2_garage_type_risk_lvl_mm_b4;
		Real pk_add2_parking_no_of_cars_mm_b4;
		Real pk_yr_add2_mortgage_due_date2_mm_b4;
		Real pk_add2_assessed_amount2_mm_b4;
		Real pk_yr_add2_date_first_seen2_mm_b4;
		Real pk_add3_mortgage_risk_mm_b4;
		Real pk_add3_assessed_amount2_mm_b4;
		Real pk_yr_add3_date_first_seen2_mm_b4;
		Real pk_bk_level_mm_b4;
		Real pk_eviction_level_mm_b4;
		Real pk_lien_type_level_mm_b4;
		Real pk_yr_liens_last_unrel_date3_mm_b4;
		Real pk_yr_criminal_last_date2_mm_b4;
		Real pk_yr_felony_last_date2_mm_b4;
		Real pk_attr_total_number_derogs_mm_b4;
		Real pk_yr_rc_ssnhighissue2_mm_b4;
		Real pk_pl_sourced_level_mm_b4;
		Real pk_prof_lic_cat_mm_b4;
		Real pk_add1_lres_mm_b4;
		Real pk_add2_lres_mm_b4;
		Real pk_add3_lres_mm_b4;
		Real pk_lres_flag_level_mm_b4;
		Real pk_addrs_5yr_mm_b4;
		Real pk_addrs_15yr_mm_b4;
		Real pk_add_lres_month_avg2_mm_b4;
		Real pk_ssns_per_adl_mm_b4;
		Real pk_addrs_per_adl_mm_b4;
		Real pk_phones_per_adl_mm_b4;
		Real pk_adlperssn_count_mm_b4;
		Real pk_adls_per_addr_mm_b4;
		Real pk_adls_per_phone_mm_b4;
		Real pk_ssns_per_adl_c6_mm_b4;
		Real pk_ssns_per_addr_c6_mm_b4;
		Real pk_adls_per_phone_c6_mm_b4;
		Real pk_attr_addrs_last90_mm_b4;
		Real pk_attr_addrs_last12_mm_b4;
		Real pk_attr_addrs_last24_mm_b4;
		Real pk_ams_class_level_mm_b4;
		Real pk_ams_4yr_college_mm_b4;
		Real pk_ams_college_type_mm_b4;
		Real pk_ams_income_level_code_mm_b4;
		Real pk_yr_in_dob2_mm_b4;
		Real pk_yr_ams_dob2_mm_b4;
		Real pk_inferred_age_mm_b4;
		Real pk_yr_reported_dob2_mm_b4;
		Real pk_avm_hit_level_mm_b4;
		Real pk_avm_auto_diff2_lvl_mm_b4;
		Real pk_avm_auto_diff4_lvl_mm_b4;
		Real pk_add2_avm_auto_diff2_lvl_mm_b4;
		Real pk_avm_confidence_level_mm_b4;
		Real pk2_add1_avm_mkt_mm_b4;
		Real pk2_add1_avm_pi_mm_b4;
		Real pk2_add1_avm_auto_mm_b4;
		Real pk2_add1_avm_auto2_mm_b4;
		Real pk2_add1_avm_auto3_mm_b4;
		Real pk2_add1_avm_med_mm_b4;
		Real pk2_add1_avm_to_med_ratio_mm_b4;
		Real pk2_add2_avm_sp_mm_b4;
		Real pk2_add2_avm_ta_mm_b4;
		Real pk2_add2_avm_pi_mm_b4;
		Real pk2_add2_avm_hed_mm_b4;
		Real pk2_add2_avm_auto_mm_b4;
		Real pk2_add2_avm_auto3_mm_b4;
		Real pk2_yr_add1_avm_rec_dt_mm_b4;
		Real pk2_yr_add1_avm_assess_year_mm_b4;
		Real pk_dist_a1toa2_mm_b4;
		Real pk_dist_a1toa3_mm_b4;
		Real pk_rc_disthphoneaddr_mm_b4;
		Real pk_out_st_division_lvl_mm_b4;
		Real pk_wealth_index_mm_b4;
		Real pk_attr_num_nonderogs90_b_mm_b4;
		Real pk_ssns_per_addr2_mm_b4;
		Real pk_yr_add2_assess_val_yr2_mm_b4;
		Real pk_yr_criminal_last_date2_mm;
		Real pk_add2_garage_type_risk_lvl_mm;
		Real pk_prop_own_assess_tot2_mm;
		Real pk_yr_add1_date_first_seen2_mm;
		Real pk_attr_addrs_last90_mm;
		Real pk_add1_purchase_amount2_mm;
		Real pk_adls_per_phone_mm;
		Real pk_ssns_per_addr2_mm;
		Real pk_property_owned_total_mm;
		Real pk_ams_class_level_mm;
		Real pk_attr_addrs_last12_mm;
		Real pk_adls_per_phone_c6_mm;
		Real pk_yr_add2_date_first_seen2_mm;
		Real pk_adlperssn_count_mm;
		Real pk2_add2_avm_auto_mm;
		Real pk2_add2_avm_hed_mm;
		Real pk_avm_auto_diff4_lvl_mm;
		Real pk_ams_college_type_mm;
		Real pk_yr_add3_date_first_seen2_mm;
		Real pk_add1_land_use_risk_level_mm;
		Real pk2_add2_avm_ta_mm;
		Real pk_add2_lres_mm;
		Real pk_addrs_sourced_lvl_mm;
		Real pk_add_lres_month_avg2_mm;
		Real pk_rc_disthphoneaddr_mm;
		Real pk_add1_lres_mm;
		Real pk_attr_total_number_derogs_mm;
		Real pk2_add2_avm_sp_mm;
		Real pk_addrs_per_adl_mm;
		Real pk_naprop_level2_mm;
		Real pk2_add1_avm_auto3_mm;
		Real pk2_add1_avm_mkt_mm;
		Real pk_yr_reported_dob2_mm;
		Real pk_ssns_per_adl_mm;
		Real pk_ams_income_level_code_mm;
		Real pk_add1_building_area2_mm;
		Real pk_pr_count_mm;
		Real pk_avm_auto_diff2_lvl_mm;
		Real pk_inferred_age_mm;
		Real pk2_yr_add1_avm_assess_year_mm;
		Real pk_add1_no_of_baths_mm;
		Real pk_out_st_division_lvl_mm;
		Real pk_yr_rc_ssnhighissue2_mm;
		Real pk_add2_building_area2_mm;
		Real pk_phones_per_adl_mm;
		Real pk_add1_no_of_rooms_mm;
		Real pk2_add1_avm_auto2_mm;
		Real pk_ams_4yr_college_mm;
		Real pk_ssns_per_addr_c6_mm;
		Real pk2_yr_add1_avm_rec_dt_mm;
		Real pk_add1_mortgage_risk_mm;
		Real pk_yr_add2_assess_val_yr2_mm;
		Real pk_pl_sourced_level_mm;
		Real pk_add2_assessed_amount2_mm;
		Real pk_prof_lic_cat_mm;
		Real pk_dist_a1toa3_mm;
		Real pk_eviction_level_mm;
		Real pk_attr_num_nonderogs90_b_mm;
		Real pk_adls_per_addr_mm;
		Real pk_yr_ams_dob2_mm;
		Real pk_ssns_per_adl_c6_mm;
		Real pk_attr_addrs_last24_mm;
		Real pk_add2_avm_auto_diff2_lvl_mm;
		Real pk_add3_mortgage_risk_mm;
		Real pk_add2_parking_no_of_cars_mm;
		Real pk2_add1_avm_med_mm;
		Real pk_avm_confidence_level_mm;
		Real pk_add2_no_of_buildings_mm;
		Real pk_yr_add2_mortgage_due_date2_mm;
		Real pk_yr_add1_mortgage_date2_mm;
		Real pk_addrs_15yr_mm;
		Real pk_yr_in_dob2_mm;
		Real pk_avm_hit_level_mm;
		Real pk_bk_level_mm;
		Real pk_wealth_index_mm;
		Real pk2_add2_avm_pi_mm;
		Real pk2_add1_avm_to_med_ratio_mm;
		Real pk2_add1_avm_auto_mm;
		Real pk_yr_adl_pr_first_seen2_mm;
		Real pk_add1_assessed_amount2_mm;
		Real pk_add3_lres_mm;
		Real pk_lres_flag_level_mm;
		Real pk_estimated_income_mm;
		Real pk_yr_adl_w_first_seen2_mm;
		Real pk_yr_add1_mortgage_due_date2_mm;
		Real pk_dist_a1toa2_mm;
		Real pk_add3_assessed_amount2_mm;
		Real pk_yr_felony_last_date2_mm;
		Real pk_addrs_5yr_mm;
		Real pk_lien_type_level_mm;
		Real pk2_add2_avm_auto3_mm;
		Real pk2_add1_avm_pi_mm;
		Real pk_yr_liens_last_unrel_date3_mm;
		Real segment_mean;
		Real pk_add_lres_month_avg2_mm_2;
		Real pk_add1_assessed_amount2_mm_2;
		Real pk_add1_building_area2_mm_2;
		Real pk_add1_land_use_risk_level_mm_2;
		Real pk_add1_lres_mm_2;
		Real pk_add1_mortgage_risk_mm_2;
		Real pk_add1_no_of_baths_mm_2;
		Real pk_add1_no_of_rooms_mm_2;
		Real pk_add1_purchase_amount2_mm_2;
		Real pk_add2_assessed_amount2_mm_2;
		Real pk_add2_avm_auto_diff2_lvl_mm_2;
		Real pk_add2_building_area2_mm_2;
		Real pk_add2_em_ver_lvl_mm_2;
		Real pk_add2_garage_type_risk_lvl_mm_2;
		Real pk_add2_lres_mm_2;
		Real pk_add2_no_of_buildings_mm_2;
		Real pk_add2_parking_no_of_cars_mm_2;
		Real pk_add2_pos_sources_mm_2;
		Real pk_add3_assessed_amount2_mm_2;
		Real pk_add3_lres_mm_2;
		Real pk_add3_mortgage_risk_mm_2;
		Real pk_addrs_15yr_mm_2;
		Real pk_addrs_5yr_mm_2;
		Real pk_addrs_per_adl_mm_2;
		Real pk_addrs_sourced_lvl_mm_2;
		Real pk_adlperssn_count_mm_2;
		Real pk_adls_per_addr_mm_2;
		Real pk_adls_per_phone_c6_mm_2;
		Real pk_adls_per_phone_mm_2;
		Real pk_ams_4yr_college_mm_2;
		Real pk_ams_class_level_mm_2;
		Real pk_ams_college_type_mm_2;
		Real pk_ams_income_level_code_mm_2;
		Real pk_attr_addrs_last12_mm_2;
		Real pk_attr_addrs_last24_mm_2;
		Real pk_attr_addrs_last90_mm_2;
		Real pk_attr_num_nonderogs90_b_mm_2;
		Real pk_attr_total_number_derogs_mm_2;
		Real pk_avm_auto_diff2_lvl_mm_2;
		Real pk_avm_auto_diff4_lvl_mm_2;
		Real pk_avm_confidence_level_mm_2;
		Real pk_avm_hit_level_mm_2;
		Real pk_bk_level_mm_2;
		Real pk_combo_dobcount_mm_2;
		Real pk_combo_dobcount_nb_mm_2;
		Real pk_combo_fnamecount_mm_2;
		Real pk_combo_fnamecount_nb_mm_2;
		Real pk_combo_ssncount_mm_2;
		Real pk_dist_a1toa2_mm_2;
		Real pk_dist_a1toa3_mm_2;
		Real pk_em_only_ver_lvl_mm_2;
		Real pk_eq_count_mm_2;
		Real pk_estimated_income_mm_2;
		Real pk_eviction_level_mm_2;
		Real pk_gong_did_phone_ct_mm_2;
		Real pk_gong_did_phone_ct_nb_mm_2;
		Real pk_inferred_age_mm_2;
		Real pk_infutor_risk_lvl_mm_2;
		Real pk_infutor_risk_lvl_nb_mm_2;
		Real pk_lien_type_level_mm_2;
		Real pk_lname_eda_sourced_type_lvl_mm_2;
		Real pk_lres_flag_level_mm_2;
		Real pk_nap_summary_mm_2;
		Real pk_naprop_level2_mm_2;
		Real pk_nas_summary_mm_2;
		Real pk_out_st_division_lvl_mm_2;
		Real pk_phones_per_adl_mm_2;
		Real pk_pl_sourced_level_mm_2;
		Real pk_pos_secondary_sources_mm_2;
		Real pk_pr_count_mm_2;
		Real pk_prof_lic_cat_mm_2;
		Real pk_prop_own_assess_tot2_mm_2;
		Real pk_property_owned_total_mm_2;
		Real pk_rc_addrcount_mm_2;
		Real pk_rc_addrcount_nb_mm_2;
		Real pk_rc_disthphoneaddr_mm_2;
		Real pk_rc_fnamecount_mm_2;
		Real pk_rc_lnamecount_nb_mm_2;
		Real pk_rc_phonelnamecount_mm_2;
		Real pk_rc_phonephonecount_mm_2;
		Real pk_ssnchar_invalid_or_recent_mm_2;
		Real pk_ssns_per_addr_c6_mm_2;
		Real pk_ssns_per_addr2_mm_2;
		Real pk_ssns_per_adl_c6_mm_2;
		Real pk_ssns_per_adl_mm_2;
		Real pk_ver_phncount_mm_2;
		Real pk_voter_flag_mm_2;
		Real pk_wealth_index_mm_2;
		Real pk_yr_add1_date_first_seen2_mm_2;
		Real pk_yr_add1_mortgage_date2_mm_2;
		Real pk_yr_add1_mortgage_due_date2_mm_2;
		Real pk_yr_add2_assess_val_yr2_mm_2;
		Real pk_yr_add2_date_first_seen2_mm_2;
		Real pk_yr_add2_mortgage_due_date2_mm_2;
		Real pk_yr_add3_date_first_seen2_mm_2;
		Real pk_yr_adl_em_only_first_seen2_mm_2;
		Real pk_yr_adl_pr_first_seen2_mm_2;
		Real pk_yr_adl_w_first_seen2_mm_2;
		Real pk_yr_ams_dob2_mm_2;
		Real pk_yr_criminal_last_date2_mm_2;
		Real pk_yr_felony_last_date2_mm_2;
		Real pk_yr_gong_did_first_seen2_mm_2;
		Real pk_yr_header_first_seen2_mm_2;
		Real pk_yr_in_dob2_mm_2;
		Real pk_yr_infutor_first_seen2_mm_2;
		Real pk_yr_liens_last_unrel_date3_mm_2;
		Real pk_yr_lname_change_date2_mm_2;
		Real pk_yr_rc_ssnhighissue2_mm_2;
		Real pk_yr_reported_dob2_mm_2;
		Real pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
		Real pk2_add1_avm_auto_mm_2;
		Real pk2_add1_avm_auto2_mm_2;
		Real pk2_add1_avm_auto3_mm_2;
		Real pk2_add1_avm_med_mm_2;
		Real pk2_add1_avm_mkt_mm_2;
		Real pk2_add1_avm_pi_mm_2;
		Real pk2_add1_avm_to_med_ratio_mm_2;
		Real pk2_add2_avm_auto_mm_2;
		Real pk2_add2_avm_auto3_mm_2;
		Real pk2_add2_avm_hed_mm_2;
		Real pk2_add2_avm_pi_mm_2;
		Real pk2_add2_avm_sp_mm_2;
		Real pk2_add2_avm_ta_mm_2;
		Real pk2_yr_add1_avm_assess_year_mm_2;
		Real pk2_yr_add1_avm_rec_dt_mm_2;
		Real addprob3_mod_dm_b1;
		Real phnprob_mod_dm_b1;
		Real ssnprob2_mod_dm_b1;
		Real fp_mod5_dm_b1;
		Real age_mod3_dm_b1;
		Real amstudent_mod_dm_b1;
		Real avm_mod_dm_b1;
		Real derog_mod3_dm_b1;
		Real lien_mod_dm_b1;
		Real lres_mod_dm_b1;
		Real property_mod_dm_b1;
		Real velocity2_mod_dm_b1;
		Real ver_best_element_cnt_mod_dm_b1;
		Real ver_best_src_cnt_mod_dm_b1;
		Real ver_best_src_time_mod_dm_b1;
		Real ver_notbest_element_cnt_mod_dm_b1;
		Real ver_notbest_src_cnt_mod_dm_b1;
		Real ver_notbest_src_time_mod_dm_b1;
		Real ver_element_cnt_mod_dm_b1;
		Real ver_src_cnt_mod_dm_b1;
		Real ver_src_time_mod_dm_b1;
		Real mod14_dm_b1;
		Real addprob3_mod_om_b2;
		Real phnprob_mod_om_b2;
		Real ssnprob2_mod_om_b2;
		Real fp_mod5_om_b2;
		Real age_mod3_nodob_om_b2;
		Real age_mod3_om_b2;
		Real avm_mod_om_b2;
		Real property_mod_om_b2;
		Real velocity2_mod_om_b2;
		Real ver_best_src_cnt_mod_om_b2;
		Real ver_best_src_time_mod_om_b2;
		Real ver_notbest_src_cnt_mod_om_b2;
		Real ver_notbest_src_time_mod_om_b2;
		Real ver_src_time_mod_om_b2;
		Real ver_src_cnt_mod_om_b2;
		Real mod14_om_b2;
		Real addprob3_mod_rm_b3;
		Real phnprob_mod_rm_b3;
		Real ssnprob2_mod_rm_b3;
		Real fp_mod5_rm_b3;
		Real age_mod3_nodob_rm_b3;
		Real age_mod3_rm_b3;
		Real amstudent_mod_rm_b3;
		Real avm_mod_rm_b3;
		Real distance_mod2_rm_b3;
		Real lres_mod_rm_b3;
		Real property_mod_rm_b3;
		Real velocity2_mod_rm_b3;
		Real ver_best_element_cnt_mod_rm_b3;
		Real ver_best_src_cnt_mod_rm_b3;
		Real ver_notbest_element_cnt_mod_rm_b3;
		Real ver_notbest_src_cnt_mod_rm_b3;
		Real ver_element_cnt_mod_rm_b3;
		Real ver_src_cnt_mod_rm_b3;
		Real mod14_rm_b3;
		Real addprob3_mod_xm_b4;
		Real phnprob_mod_xm_b4;
		Real ssnprob2_mod_xm_b4;
		Real fp_mod5_xm_b4;
		Real age_mod3_nodob_xm_b4;
		Real age_mod3_xm_b4;
		Real amstudent_mod_xm_b4;
		Real avm_mod_xm_b4;
		Real distance_mod2_xm_b4;
		Real property_mod_xm_b4;
		Real velocity2_mod_xm_b4;
		Real ver_best_element_cnt_mod_xm_b4;
		Real ver_best_src_cnt_mod_xm_b4;
		Real ver_best_src_time_mod_xm_b4;
		Real ver_notbest_element_cnt_mod_xm_b4;
		Real ver_notbest_src_cnt_mod_xm_b4;
		Real ver_notbest_src_time_mod_xm_b4;
		Real ver_element_cnt_mod_xm_b4;
		Real ver_src_time_mod_xm_b4;
		Real ver_src_cnt_mod_xm_b4;
		Real mod14_xm_b4;
		Real velocity2_mod_rm;
		Real lien_mod_dm;
		Real phat;
		Real addprob3_mod_dm;
		Real age_mod3_nodob_xm;
		Real avm_mod_om;
		Real ver_best_src_time_mod_dm;
		Real fp_mod5_dm;
		Real property_mod_xm;
		Real velocity2_mod_dm;
		Real age_mod3_dm;
		Real ver_notbest_element_cnt_mod_rm;
		Real age_mod3_rm;
		Real ver_notbest_src_time_mod_dm;
		Real property_mod_rm;
		Real addprob3_mod_rm;
		Real age_mod3_nodob_om;
		Real velocity2_mod_om;
		Real ver_element_cnt_mod_rm;
		Real property_mod_dm;
		Real ver_notbest_src_cnt_mod_xm;
		Real ssnprob2_mod_om;
		Real ver_best_src_time_mod_om;
		Real ver_best_src_cnt_mod_xm;
		Real avm_mod_rm;
		Real amstudent_mod_rm;
		Real age_mod3_xm;
		Real velocity2_mod_xm;
		Real ssnprob2_mod_rm;
		Real ver_src_time_mod_dm;
		Real avm_mod_dm;
		Real ver_best_src_cnt_mod_rm;
		Real ver_element_cnt_mod_xm;
		Real ssnprob2_mod_xm;
		Real lres_mod_rm;
		Real distance_mod2_rm;
		Real ver_best_src_cnt_mod_om;
		Real addprob3_mod_xm;
		Real age_mod3_nodob_rm;
		Real phnprob_mod_rm;
		Real ver_src_cnt_mod_dm;
		Real ver_best_element_cnt_mod_rm;
		Real ssnprob2_mod_dm;
		Real derog_mod3_dm;
		Real ver_src_time_mod_om;
		Real mod14_om;
		Real mod14_xm;
		Real ver_notbest_src_cnt_mod_om;
		Real ver_notbest_src_cnt_mod_rm;
		Real fp_mod5_om;
		Real ver_notbest_element_cnt_mod_dm;
		Real ver_best_src_cnt_mod_dm;
		Real ver_src_cnt_mod_xm;
		Real ver_notbest_src_time_mod_xm;
		Real addprob3_mod_om;
		Real fp_mod5_rm;
		Real ver_notbest_element_cnt_mod_xm;
		Real amstudent_mod_dm;
		Real ver_notbest_src_time_mod_om;
		Real mod14_rm;
		Real ver_best_src_time_mod_xm;
		Real ver_src_cnt_mod_om;
		Real amstudent_mod_xm;
		Real avm_mod_xm;
		Real distance_mod2_xm;
		Real age_mod3_om;
		Real fp_mod5_xm;
		Real phnprob_mod_dm;
		Real ver_src_cnt_mod_rm;
		Real phnprob_mod_xm;
		Integer mod14_scr;
		Real ver_best_element_cnt_mod_dm;
		Real ver_element_cnt_mod_dm;
		Real lres_mod_dm;
		Real mod14_dm;
		Real phnprob_mod_om;
		Real ver_notbest_src_cnt_mod_dm;
		Real ver_src_time_mod_xm;
		Real property_mod_om;
		Real ver_best_element_cnt_mod_xm;
		Real ssnprob2_mod_dm_nodob_b1_c2_b1;
		Real fp_mod5_dm_nodob_b1_c2_b1;
		Real mod14_dm_nodob_b1_c2_b1;
		Real ssnprob2_mod_om_nodob_b1_c2_b2;
		Real fp_mod5_om_nodob_b1_c2_b2;
		Real mod14_om_nodob_b1_c2_b2;
		Real ver_best_e_cnt_mod_rm_nodob_b1_c2_b3;
		Real ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3;
		Real ver_element_cnt_mod_rm_nodob_b1_c2_b3;
		Real mod14_rm_nodob_b1_c2_b3;
		Real ver_best_e_cnt_mod_xm_nodob_b1_c2_b4;
		Real ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4;
		Real ver_element_cnt_mod_xm_nodob_b1_c2_b4;
		Real mod14_xm_nodob_b1_c2_b4;
		Real ssnprob2_mod_om_nodob_b1;
		Real mod14_om_nodob_b1;
		Real mod14_dm_nodob_b1;
		Real ssnprob2_mod_dm_nodob_b1;
		Integer mod14_scr_b1;
		Real mod14_xm_nodob_b1;
		Real phat_b1;
		Real ver_best_e_cnt_mod_xm_nodob_b1;
		Real ver_element_cnt_mod_rm_nodob_b1;
		Real fp_mod5_om_nodob_b1;
		Real ver_element_cnt_mod_xm_nodob_b1;
		Real ver_notbest_e_cnt_mod_rm_nodob_b1;
		Real ver_notbest_e_cnt_mod_xm_nodob_b1;
		Real mod14_rm_nodob_b1;
		Real fp_mod5_dm_nodob_b1;
		Real ver_best_e_cnt_mod_rm_nodob_b1;
		Real ssnprob2_mod_om_nodob;
		Real mod14_om_nodob;
		Real mod14_dm_nodob;
		Real ssnprob2_mod_dm_nodob;
		Integer mod14_scr_2;
		Real mod14_xm_nodob;
		Real phat_2;
		Real ver_best_e_cnt_mod_xm_nodob;
		Real ver_element_cnt_mod_rm_nodob;
		Real fp_mod5_om_nodob;
		Real ver_element_cnt_mod_xm_nodob;
		Real ver_notbest_e_cnt_mod_rm_nodob;
		Real ver_notbest_e_cnt_mod_xm_nodob;
		Real mod14_rm_nodob;
		Real fp_mod5_dm_nodob;
		Real ver_best_e_cnt_mod_rm_nodob;
		Integer RVB1003;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Integer rvb1003_2;
		Boolean scored_222s;
		Integer rvb1003_3;
	END;
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
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	did_count                        := le.iid.didcount;
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
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_areacodesplitflag             := le.iid.areacodesplitflag;
	rc_areacodesplitdate             := (unsigned)le.iid.areacodesplitdate;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := le.iid.sources;
	rc_fnamecount                    := le.iid.firstcount;
	rc_lnamecount                    := le.iid.lastcount;
	rc_addrcount                     := le.iid.addrcount;
	rc_phonelnamecount               := le.iid.phonelastcount;
	rc_phonephonecount               := le.iid.phonephonecount;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_cityzipflag                   := le.iid.cityzipflag;
	rc_fnamessnmatch                 := le.iid.firstssnmatch;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_fnamecount                 := le.iid.combo_firstcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_ssncount                   := le.iid.combo_ssncount;
	combo_dobcount                   := le.iid.combo_dobcount;
	rc_watchlist_flag                := le.iid.watchlisthit;
	eq_count                         := le.source_verification.eq_count;
	pr_count                         := le.source_verification.pr_count;
	adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
	adl_en_first_seen                := le.source_verification.adl_en_first_seen;
	adl_pr_first_seen                := le.source_verification.adl_pr_first_seen;
	adl_em_first_seen                := le.source_verification.adl_em_first_seen;
	adl_vo_first_seen                := le.source_verification.adl_vo_first_seen;
	adl_em_only_first_seen           := le.source_verification.adl_em_only_first_seen;
	adl_w_first_seen                 := le.source_verification.adl_w_first_seen;
	fname_sources                    := le.source_verification.firstnamesources;
	lname_sources                    := le.source_verification.lastnamesources;
	addr_sources                     := le.source_verification.addrsources;
	ssn_sources                      := le.source_verification.socssources;
	em_only_sources                  := le.source_verification.em_only_sources;
	voter_avail                      := le.available_sources.voter;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	lname_change_date                := le.name_verification.lname_change_date;
	lname_eda_sourced                := le.name_verification.lname_eda_sourced;
	lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_lres                        := le.lres;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
	add1_avm_assessed_value_year     := le.avm.input_address_information.avm_assessed_value_year;
	add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
	add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
	add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
	add1_avm_confidence_score        := le.avm.input_address_information.avm_confidence_score;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
	add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
	add1_building_area               := (string)le.address_verification.input_address_information.building_area;
	add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
	add1_no_of_baths                 := (string)le.address_verification.input_address_information.no_of_baths;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_lres                        := le.lres2;
	add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
	add2_avm_sales_price             := le.avm.address_history_1.avm_sales_price;
	add2_avm_tax_assessed_valuation  := le.avm.address_history_1.avm_tax_assessment_valuation;
	add2_avm_price_index_valuation   := le.avm.address_history_1.avm_price_index_valuation;
	add2_avm_hedonic_valuation       := le.avm.address_history_1.avm_hedonic_valuation;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
	add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
	add2_avm_confidence_score        := le.avm.address_history_1.avm_confidence_score;
	add2_sources                     := le.address_verification.address_history_1.sources;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_building_area               := (string)le.address_verification.address_history_1.building_area;
	add2_no_of_buildings             := (string)le.address_verification.address_history_1.no_of_buildings;
	add2_garage_type_code            := le.address_verification.address_history_1.garage_type_code;
	add2_parking_no_of_cars          := (string)le.address_verification.address_history_1.parking_no_of_cars;
	add2_assessed_value_year         := le.address_verification.address_history_1.assessed_value_year;
	add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
	add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add2_pop                         := le.addrpop2;
	add3_lres                        := le.lres3;
	add3_sources                     := le.address_verification.address_history_2.sources;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
	add3_financing_type              := le.address_verification.address_history_2.type_financing;
	add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	add3_pop                         := le.addrpop3;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	phones_per_adl                   := le.velocity_counters.phones_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	adls_per_phone                   := le.velocity_counters.adls_per_phone;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
	invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_num_sold180                 := le.other_address_info.num_sold180;
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
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_last_date                 := le.bjl.last_felony_date;
	ams_dob                          := (unsigned)le.student.dob_formatted;
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
	archive_date                     := le.historydate;











NULL := -999999999;


INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

sysdate :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
                length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                       NULL);

sysyear :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => year(common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'))),
                length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (integer)(trim((string)archive_date, LEFT))[1..4],
                                                                       NULL);

_daycap_b1 := map((min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                  (min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
(28 + (integer)((((integer)((integer)(trim(in_dob, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(in_dob, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(in_dob, LEFT))[1..4] % 400) = 0))));

in_dob2 := map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(in_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))), (string)if(max(_daycap_b1, max(1, (integer)(trim(in_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1 = NULL, -NULL, _daycap_b1), if(max(1, (integer)(trim(in_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
               (length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
               (length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                           NULL);

_y := map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (integer)(trim(in_dob, LEFT))[1..4],
          (length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
          (length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
                                                                                                      NULL);

_m := map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))),
          (length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
          (length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
                                                                                                      NULL);

_d := map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1, max(1, (integer)(trim(in_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1 = NULL, -NULL, _daycap_b1), if(max(1, (integer)(trim(in_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[7..8])))),
          (length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
          (length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
                                                                                                      NULL);

_daycap := map((length(trim(in_dob, LEFT, RIGHT)) = 8) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => _daycap_b1,
               (length(trim(in_dob, LEFT, RIGHT)) = 6) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
               (length(trim(in_dob, LEFT, RIGHT)) = 4) and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => NULL,
                                                                                                           NULL);

years_in_dob :=  if((sysdate != NULL) and (in_dob2 != NULL), ((sysdate - in_dob2) / 365.25), NULL);

_daycap_b1_2 := map((min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                         (28 + (integer)((((integer)((integer)(trim((string)rc_ssnhighissue, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)rc_ssnhighissue, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)rc_ssnhighissue, LEFT))[1..4] % 400) = 0))));

rc_ssnhighissue2 := map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)rc_ssnhighissue, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))), (string)if(max(_daycap_b1_2, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_2 = NULL, -NULL, _daycap_b1_2), if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                        (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_ssnhighissue, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                        (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_ssnhighissue, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                      NULL);

_y_2 := map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)rc_ssnhighissue, LEFT))[1..4],
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _y,
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _y,
                                                                                                                                          _y);

_m_2 := map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[5..6]))),
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _m,
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _m,
                                                                                                                                          _m);

_d_2 := map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_2, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_2 = NULL, -NULL, _daycap_b1_2), if(max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_ssnhighissue, LEFT))[7..8])))),
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _d,
            (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _d,
                                                                                                                                          _d);

_daycap_2 := map((length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 8) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _daycap_b1_2,
                 (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 6) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _daycap,
                 (length(trim((string)rc_ssnhighissue, LEFT, RIGHT)) = 4) and ((trim((string)rc_ssnhighissue, LEFT))[1..2] in ['19', '20']) => _daycap,
                                                                                                                                               _daycap);

years_rc_ssnhighissue :=  if((sysdate != NULL) and (rc_ssnhighissue2 != NULL), ((sysdate - rc_ssnhighissue2) / 365.25), NULL);

_daycap_b1_3 := map((min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)rc_areacodesplitdate, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)rc_areacodesplitdate, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)rc_areacodesplitdate, LEFT))[1..4] % 400) = 0))),
                         _daycap);

_y_3 := map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)rc_areacodesplitdate, LEFT))[1..4],
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _y_2,
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _y_2,
                                                                                                                                                    _y_2);

_m_3 := map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))),
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _m_2,
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _m_2,
                                                                                                                                                    _m_2);

_d_3 := map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_3, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_3 = NULL, -NULL, _daycap_b1_3), if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8])))),
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _d_2,
            (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _d_2,
                                                                                                                                                    _d_2);

_daycap_3 := map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _daycap_b1_3,
                 (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _daycap_2,
                 (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => _daycap_2,
                                                                                                                                                         _daycap_2);

rc_areacodesplitdate2 := map((length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 8) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))), (string)if(max(_daycap_b1_3, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_3 = NULL, -NULL, _daycap_b1_3), if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 6) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)rc_areacodesplitdate, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)rc_areacodesplitdate, LEFT, RIGHT)) = 4) and ((trim((string)rc_areacodesplitdate, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)rc_areacodesplitdate, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                     NULL);

years_rc_areacodesplitdate :=  if((sysdate != NULL) and (rc_areacodesplitdate2 != NULL), ((sysdate - rc_areacodesplitdate2) / 365.25), NULL);

_daycap_b1_4 := map((min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_eq_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_eq_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_eq_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_2);

adl_eq_first_seen2 := map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_eq_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_4, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_4 = NULL, -NULL, _daycap_b1_4), if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_eq_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_eq_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_y_4 := map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_eq_first_seen, LEFT))[1..4],
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _y_3,
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _y_3,
                                                                                                                                              _y_3);

_m_4 := map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _m_3,
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _m_3,
                                                                                                                                              _m_3);

_d_4 := map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_4, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_4 = NULL, -NULL, _daycap_b1_4), if(max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_eq_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _d_3,
            (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _d_3,
                                                                                                                                              _d_3);

_daycap_4 := map((length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_4,
                 (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_3,
                 (length(trim((string)adl_eq_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_eq_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_3,
                                                                                                                                                   _daycap_3);

years_adl_eq_first_seen :=  if((sysdate != NULL) and (adl_eq_first_seen2 != NULL), ((sysdate - adl_eq_first_seen2) / 365.25), NULL);

months_adl_eq_first_seen :=  if((sysdate != NULL) and (adl_eq_first_seen2 != NULL), ((sysdate - adl_eq_first_seen2) / 30.5), NULL);

_daycap_b1_5 := map((min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_en_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_en_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_en_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_3);

_y_5 := map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_en_first_seen, LEFT))[1..4],
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _y_4,
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _y_4,
                                                                                                                                              _y_4);

_m_5 := map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _m_4,
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _m_4,
                                                                                                                                              _m_4);

adl_en_first_seen2 := map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_en_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_5, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_5 = NULL, -NULL, _daycap_b1_5), if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_en_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_en_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_d_5 := map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_5, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_5 = NULL, -NULL, _daycap_b1_5), if(max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_en_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _d_4,
            (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _d_4,
                                                                                                                                              _d_4);

_daycap_5 := map((length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_5,
                 (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_4,
                 (length(trim((string)adl_en_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_en_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_4,
                                                                                                                                                   _daycap_4);

years_adl_en_first_seen :=  if((sysdate != NULL) and (adl_en_first_seen2 != NULL), ((sysdate - adl_en_first_seen2) / 365.25), NULL);

months_adl_en_first_seen :=  if((sysdate != NULL) and (adl_en_first_seen2 != NULL), ((sysdate - adl_en_first_seen2) / 30.5), NULL);

_daycap_b1_6 := map((min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_pr_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_pr_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_pr_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_4);

_y_6 := map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_pr_first_seen, LEFT))[1..4],
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _y_5,
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _y_5,
                                                                                                                                              _y_5);

_m_6 := map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _m_5,
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _m_5,
                                                                                                                                              _m_5);

adl_pr_first_seen2 := map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_pr_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_6, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_6 = NULL, -NULL, _daycap_b1_6), if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_pr_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_pr_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_d_6 := map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_6, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_6 = NULL, -NULL, _daycap_b1_6), if(max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_pr_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _d_5,
            (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _d_5,
                                                                                                                                              _d_5);

_daycap_6 := map((length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_6,
                 (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_5,
                 (length(trim((string)adl_pr_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_pr_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_5,
                                                                                                                                                   _daycap_5);

years_adl_pr_first_seen :=  if((sysdate != NULL) and (adl_pr_first_seen2 != NULL), ((sysdate - adl_pr_first_seen2) / 365.25), NULL);

months_adl_pr_first_seen :=  if((sysdate != NULL) and (adl_pr_first_seen2 != NULL), ((sysdate - adl_pr_first_seen2) / 30.5), NULL);

_daycap_b1_7 := map((min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_em_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_em_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_em_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_5);

adl_em_first_seen2 := map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_em_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_7, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_7 = NULL, -NULL, _daycap_b1_7), if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_y_7 := map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_em_first_seen, LEFT))[1..4],
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _y_6,
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _y_6,
                                                                                                                                              _y_6);

_m_7 := map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _m_6,
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _m_6,
                                                                                                                                              _m_6);

_d_7 := map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_7, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_7 = NULL, -NULL, _daycap_b1_7), if(max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _d_6,
            (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _d_6,
                                                                                                                                              _d_6);

_daycap_7 := map((length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_7,
                 (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_6,
                 (length(trim((string)adl_em_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_6,
                                                                                                                                                   _daycap_6);

years_adl_em_first_seen :=  if((sysdate != NULL) and (adl_em_first_seen2 != NULL), ((sysdate - adl_em_first_seen2) / 365.25), NULL);

months_adl_em_first_seen :=  if((sysdate != NULL) and (adl_em_first_seen2 != NULL), ((sysdate - adl_em_first_seen2) / 30.5), NULL);

_daycap_b1_8 := map((min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_vo_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_vo_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_vo_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_6);

adl_vo_first_seen2 := map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_vo_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_8, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_8 = NULL, -NULL, _daycap_b1_8), if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_vo_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_vo_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_y_8 := map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_vo_first_seen, LEFT))[1..4],
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _y_7,
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _y_7,
                                                                                                                                              _y_7);

_m_8 := map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _m_7,
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _m_7,
                                                                                                                                              _m_7);

_d_8 := map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_8, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_8 = NULL, -NULL, _daycap_b1_8), if(max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_vo_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _d_7,
            (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _d_7,
                                                                                                                                              _d_7);

_daycap_8 := map((length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_8,
                 (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_7,
                 (length(trim((string)adl_vo_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_vo_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_7,
                                                                                                                                                   _daycap_7);

years_adl_vo_first_seen :=  if((sysdate != NULL) and (adl_vo_first_seen2 != NULL), ((sysdate - adl_vo_first_seen2) / 365.25), NULL);

months_adl_vo_first_seen :=  if((sysdate != NULL) and (adl_vo_first_seen2 != NULL), ((sysdate - adl_vo_first_seen2) / 30.5), NULL);

_daycap_b1_9 := map((min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                    (min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                    (min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_em_only_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_em_only_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_em_only_first_seen, LEFT))[1..4] % 400) = 0))),
                         _daycap_7);

_y_9 := map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_em_only_first_seen, LEFT))[1..4],
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _y_8,
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _y_8,
                                                                                                                                                        _y_8);

_m_9 := map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))),
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _m_8,
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _m_8,
                                                                                                                                                        _m_8);

_d_9 := map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_9, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_9 = NULL, -NULL, _daycap_b1_9), if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8])))),
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _d_8,
            (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _d_8,
                                                                                                                                                        _d_8);

_daycap_9 := map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_9,
                 (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_8,
                 (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_8,
                                                                                                                                                             _daycap_8);

adl_em_only_first_seen2 := map((length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_9, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_9 = NULL, -NULL, _daycap_b1_9), if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_em_only_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim((string)adl_em_only_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_em_only_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_em_only_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                           NULL);

years_adl_em_only_first_seen :=  if((sysdate != NULL) and (adl_em_only_first_seen2 != NULL), ((sysdate - adl_em_only_first_seen2) / 365.25), NULL);

months_adl_em_only_first_seen :=  if((sysdate != NULL) and (adl_em_only_first_seen2 != NULL), ((sysdate - adl_em_only_first_seen2) / 30.5), NULL);

_daycap_b1_10 := map((min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)adl_w_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)adl_w_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)adl_w_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_8);

adl_w_first_seen2 := map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)adl_w_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_10, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_10 = NULL, -NULL, _daycap_b1_10), if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                         (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                         (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)adl_w_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                         NULL);

_y_10 := map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)adl_w_first_seen, LEFT))[1..4],
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _y_9,
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _y_9,
                                                                                                                                             _y_9);

_m_10 := map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[5..6]))),
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _m_9,
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _m_9,
                                                                                                                                             _m_9);

_d_10 := map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_10, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_10 = NULL, -NULL, _daycap_b1_10), if(max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)adl_w_first_seen, LEFT))[7..8])))),
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _d_9,
             (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _d_9,
                                                                                                                                             _d_9);

_daycap_10 := map((length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_10,
                  (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_9,
                  (length(trim((string)adl_w_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)adl_w_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_9,
                                                                                                                                                  _daycap_9);

years_adl_w_first_seen :=  if((sysdate != NULL) and (adl_w_first_seen2 != NULL), ((sysdate - adl_w_first_seen2) / 365.25), NULL);

months_adl_w_first_seen :=  if((sysdate != NULL) and (adl_w_first_seen2 != NULL), ((sysdate - adl_w_first_seen2) / 30.5), NULL);

_daycap_b1_11 := map((min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)lname_change_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)lname_change_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)lname_change_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_9);

_y_11 := map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)lname_change_date, LEFT))[1..4],
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _y_10,
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _y_10,
                                                                                                                                               _y_10);

_m_11 := map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))),
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _m_10,
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _m_10,
                                                                                                                                               _m_10);

_d_11 := map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_11, max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_11 = NULL, -NULL, _daycap_b1_11), if(max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8])))),
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _d_10,
             (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _d_10,
                                                                                                                                               _d_10);

lname_change_date2 := map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)lname_change_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_11, max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_11 = NULL, -NULL, _daycap_b1_11), if(max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)lname_change_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)lname_change_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)lname_change_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_daycap_11 := map((length(trim((string)lname_change_date, LEFT, RIGHT)) = 8) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_11,
                  (length(trim((string)lname_change_date, LEFT, RIGHT)) = 6) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _daycap_10,
                  (length(trim((string)lname_change_date, LEFT, RIGHT)) = 4) and ((trim((string)lname_change_date, LEFT))[1..2] in ['19', '20']) => _daycap_10,
                                                                                                                                                    _daycap_10);

years_lname_change_date :=  if((sysdate != NULL) and (lname_change_date2 != NULL), ((sysdate - lname_change_date2) / 365.25), NULL);

_daycap_b1_12 := map((min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(add1_avm_recording_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(add1_avm_recording_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(add1_avm_recording_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_10);

_y_12 := map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim(add1_avm_recording_date, LEFT))[1..4],
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _y_11,
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _y_11,
                                                                                                                                           _y_11);

add1_avm_recording_date2 := map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(add1_avm_recording_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_12, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_12 = NULL, -NULL, _daycap_b1_12), if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                                (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_recording_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_recording_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                              NULL);

_m_12 := map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[5..6]))),
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _m_11,
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _m_11,
                                                                                                                                           _m_11);

_d_12 := map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_12, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_12 = NULL, -NULL, _daycap_b1_12), if(max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_recording_date, LEFT))[7..8])))),
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _d_11,
             (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _d_11,
                                                                                                                                           _d_11);

_daycap_12 := map((length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 8) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_12,
                  (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 6) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _daycap_11,
                  (length(trim(add1_avm_recording_date, LEFT, RIGHT)) = 4) and ((trim(add1_avm_recording_date, LEFT))[1..2] in ['19', '20']) => _daycap_11,
                                                                                                                                                _daycap_11);

years_add1_avm_recording_date :=  if((sysdate != NULL) and (add1_avm_recording_date2 != NULL), ((sysdate - add1_avm_recording_date2) / 365.25), NULL);

_daycap_b1_13 := map((min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(add1_avm_assessed_value_year, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(add1_avm_assessed_value_year, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(add1_avm_assessed_value_year, LEFT))[1..4] % 400) = 0))),
                          _daycap_11);

_y_13 := map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (integer)(trim(add1_avm_assessed_value_year, LEFT))[1..4],
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _y_12,
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _y_12,
                                                                                                                                                     _y_12);

_m_13 := map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))),
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _m_12,
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _m_12,
                                                                                                                                                     _m_12);

add1_avm_assessed_value_year2 := map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))), (string)if(max(_daycap_b1_13, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_13 = NULL, -NULL, _daycap_b1_13), if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                                     (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                     (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_avm_assessed_value_year, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                             NULL);

_d_13 := map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_13, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_13 = NULL, -NULL, _daycap_b1_13), if(max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_avm_assessed_value_year, LEFT))[7..8])))),
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _d_12,
             (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _d_12,
                                                                                                                                                     _d_12);

_daycap_13 := map((length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_b1_13,
                  (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_12,
                  (length(trim(add1_avm_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add1_avm_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_12,
                                                                                                                                                          _daycap_12);

years_add1_avm_assess_year :=  if((sysdate != NULL) and (add1_avm_assessed_value_year2 != NULL), ((sysdate - add1_avm_assessed_value_year2) / 365.25), NULL);

_daycap_b1_14 := map((min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)add1_mortgage_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)add1_mortgage_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)add1_mortgage_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_12);

_y_14 := map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)add1_mortgage_date, LEFT))[1..4],
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _y_13,
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _y_13,
                                                                                                                                                 _y_13);

_m_14 := map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))),
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _m_13,
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _m_13,
                                                                                                                                                 _m_13);

_d_14 := map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_14, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_14 = NULL, -NULL, _daycap_b1_14), if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8])))),
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _d_13,
             (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _d_13,
                                                                                                                                                 _d_13);

add1_mortgage_date2 := map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)add1_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_14, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_14 = NULL, -NULL, _daycap_b1_14), if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_mortgage_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_mortgage_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_mortgage_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                               NULL);

_daycap_14 := map((length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 8) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_14,
                  (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 6) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _daycap_13,
                  (length(trim((string)add1_mortgage_date, LEFT, RIGHT)) = 4) and ((trim((string)add1_mortgage_date, LEFT))[1..2] in ['19', '20']) => _daycap_13,
                                                                                                                                                      _daycap_13);

years_add1_mortgage_date :=  if((sysdate != NULL) and (add1_mortgage_date2 != NULL), ((sysdate - add1_mortgage_date2) / 365.25), NULL);

_daycap_b1_15 := map((min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(add1_mortgage_due_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(add1_mortgage_due_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(add1_mortgage_due_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_13);

_y_15 := map((length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim(add1_mortgage_due_date, LEFT))[1..4],
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _y_14,
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _y_14,
                                                                                                                                         _y_14);

_m_15 := map((length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))),
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _m_14,
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _m_14,
                                                                                                                                         _m_14);

add1_mortgage_due_date2 := map((length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(add1_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_15, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_15 = NULL, -NULL, _daycap_b1_15), if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add1_mortgage_due_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                           NULL);

_d_15 := map((length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_15, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_15 = NULL, -NULL, _daycap_b1_15), if(max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add1_mortgage_due_date, LEFT))[7..8])))),
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _d_14,
             (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _d_14,
                                                                                                                                         _d_14);

_daycap_15 := map((length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_15,
                  (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_14,
                  (length(trim(add1_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add1_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_14,
                                                                                                                                              _daycap_14);

years_add1_mortgage_due_date :=  if((sysdate != NULL) and (add1_mortgage_due_date2 != NULL), ((sysdate - add1_mortgage_due_date2) / 365.25), NULL);

_daycap_b1_16 := map((min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)add1_date_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)add1_date_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)add1_date_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_14);

add1_date_first_seen2 := map((length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)add1_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_16, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_16 = NULL, -NULL, _daycap_b1_16), if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add1_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                     NULL);

_y_16 := map((length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)add1_date_first_seen, LEFT))[1..4],
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_15,
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_15,
                                                                                                                                                     _y_15);

_m_16 := map((length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[5..6]))),
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_15,
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_15,
                                                                                                                                                     _m_15);

_d_16 := map((length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_16, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_16 = NULL, -NULL, _daycap_b1_16), if(max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add1_date_first_seen, LEFT))[7..8])))),
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_15,
             (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_15,
                                                                                                                                                     _d_15);

_daycap_16 := map((length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_16,
                  (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_15,
                  (length(trim((string)add1_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add1_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_15,
                                                                                                                                                          _daycap_15);

years_add1_date_first_seen :=  if((sysdate != NULL) and (add1_date_first_seen2 != NULL), ((sysdate - add1_date_first_seen2) / 365.25), NULL);

months_add1_date_first_seen :=  if((sysdate != NULL) and (add1_date_first_seen2 != NULL), ((sysdate - add1_date_first_seen2) / 30.5), NULL);

_daycap_b1_17 := map((min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(add2_assessed_value_year, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(add2_assessed_value_year, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(add2_assessed_value_year, LEFT))[1..4] % 400) = 0))),
                          _daycap_15);

_y_17 := map((length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (integer)(trim(add2_assessed_value_year, LEFT))[1..4],
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _y_16,
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _y_16,
                                                                                                                                             _y_16);

_m_17 := map((length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))),
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _m_16,
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _m_16,
                                                                                                                                             _m_16);

add2_assessed_value_year2 := map((length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(add2_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))), (string)if(max(_daycap_b1_17, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_17 = NULL, -NULL, _daycap_b1_17), if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                                 (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_assessed_value_year, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                 (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_assessed_value_year, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                 NULL);

_d_17 := map((length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_17, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_17 = NULL, -NULL, _daycap_b1_17), if(max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add2_assessed_value_year, LEFT))[7..8])))),
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _d_16,
             (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _d_16,
                                                                                                                                             _d_16);

_daycap_17 := map((length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 8) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_b1_17,
                  (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 6) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_16,
                  (length(trim(add2_assessed_value_year, LEFT, RIGHT)) = 4) and ((trim(add2_assessed_value_year, LEFT))[1..2] in ['19', '20']) => _daycap_16,
                                                                                                                                                  _daycap_16);

years_add2_assessed_value_year :=  if((sysdate != NULL) and (add2_assessed_value_year2 != NULL), ((sysdate - add2_assessed_value_year2) / 365.25), NULL);

_daycap_b1_18 := map((min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(add2_mortgage_due_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(add2_mortgage_due_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(add2_mortgage_due_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_16);

_y_18 := map((length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim(add2_mortgage_due_date, LEFT))[1..4],
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _y_17,
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _y_17,
                                                                                                                                         _y_17);

_m_18 := map((length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))),
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _m_17,
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _m_17,
                                                                                                                                         _m_17);

add2_mortgage_due_date2 := map((length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(add2_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_18, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_18 = NULL, -NULL, _daycap_b1_18), if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_mortgage_due_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                               (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(add2_mortgage_due_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                           NULL);

_d_18 := map((length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_18, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_18 = NULL, -NULL, _daycap_b1_18), if(max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(add2_mortgage_due_date, LEFT))[7..8])))),
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _d_17,
             (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _d_17,
                                                                                                                                         _d_17);

_daycap_18 := map((length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 8) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_18,
                  (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 6) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_17,
                  (length(trim(add2_mortgage_due_date, LEFT, RIGHT)) = 4) and ((trim(add2_mortgage_due_date, LEFT))[1..2] in ['19', '20']) => _daycap_17,
                                                                                                                                              _daycap_17);

years_add2_mortgage_due_date :=  if((sysdate != NULL) and (add2_mortgage_due_date2 != NULL), ((sysdate - add2_mortgage_due_date2) / 365.25), NULL);

_daycap_b1_19 := map((min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)add2_date_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)add2_date_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)add2_date_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_17);

add2_date_first_seen2 := map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)add2_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_19, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_19 = NULL, -NULL, _daycap_b1_19), if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add2_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                     NULL);

_y_19 := map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)add2_date_first_seen, LEFT))[1..4],
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_18,
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_18,
                                                                                                                                                     _y_18);

_m_19 := map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[5..6]))),
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_18,
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_18,
                                                                                                                                                     _m_18);

_d_19 := map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_19, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_19 = NULL, -NULL, _daycap_b1_19), if(max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add2_date_first_seen, LEFT))[7..8])))),
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_18,
             (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_18,
                                                                                                                                                     _d_18);

_daycap_19 := map((length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_19,
                  (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_18,
                  (length(trim((string)add2_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add2_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_18,
                                                                                                                                                          _daycap_18);

years_add2_date_first_seen :=  if((sysdate != NULL) and (add2_date_first_seen2 != NULL), ((sysdate - add2_date_first_seen2) / 365.25), NULL);

months_add2_date_first_seen :=  if((sysdate != NULL) and (add2_date_first_seen2 != NULL), ((sysdate - add2_date_first_seen2) / 30.5), NULL);

_daycap_b1_20 := map((min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)add3_date_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)add3_date_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)add3_date_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_18);

_y_20 := map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)add3_date_first_seen, LEFT))[1..4],
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_19,
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _y_19,
                                                                                                                                                     _y_19);

_m_20 := map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))),
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_19,
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _m_19,
                                                                                                                                                     _m_19);

add3_date_first_seen2 := map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)add3_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_20, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_20 = NULL, -NULL, _daycap_b1_20), if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add3_date_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)add3_date_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                     NULL);

_d_20 := map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_20, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_20 = NULL, -NULL, _daycap_b1_20), if(max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)add3_date_first_seen, LEFT))[7..8])))),
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_19,
             (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _d_19,
                                                                                                                                                     _d_19);

_daycap_20 := map((length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_20,
                  (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_19,
                  (length(trim((string)add3_date_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)add3_date_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_19,
                                                                                                                                                          _daycap_19);

years_add3_date_first_seen :=  if((sysdate != NULL) and (add3_date_first_seen2 != NULL), ((sysdate - add3_date_first_seen2) / 365.25), NULL);

months_add3_date_first_seen :=  if((sysdate != NULL) and (add3_date_first_seen2 != NULL), ((sysdate - add3_date_first_seen2) / 30.5), NULL);

_daycap_b1_21 := map((min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(gong_did_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(gong_did_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(gong_did_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_19);

_y_21 := map((length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim(gong_did_first_seen, LEFT))[1..4],
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _y_20,
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _y_20,
                                                                                                                                   _y_20);

_m_21 := map((length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))),
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _m_20,
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _m_20,
                                                                                                                                   _m_20);

_d_21 := map((length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_21, max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_21 = NULL, -NULL, _daycap_b1_21), if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8])))),
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _d_20,
             (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _d_20,
                                                                                                                                   _d_20);

_daycap_21 := map((length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_21,
                  (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_20,
                  (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_20,
                                                                                                                                        _daycap_20);

gong_did_first_seen2 := map((length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(gong_did_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_21, max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_21 = NULL, -NULL, _daycap_b1_21), if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                            (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 6) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(gong_did_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                            (length(trim(gong_did_first_seen, LEFT, RIGHT)) = 4) and ((trim(gong_did_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(gong_did_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                  NULL);

years_gong_did_first_seen :=  if((sysdate != NULL) and (gong_did_first_seen2 != NULL), ((sysdate - gong_did_first_seen2) / 365.25), NULL);

_daycap_b1_22 := map((min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)header_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)header_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)header_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_20);

header_first_seen2 := map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)header_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_22, max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_22 = NULL, -NULL, _daycap_b1_22), if(max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)header_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                          (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)header_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                            NULL);

_y_22 := map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)header_first_seen, LEFT))[1..4],
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _y_21,
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _y_21,
                                                                                                                                               _y_21);

_m_22 := map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[5..6]))),
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _m_21,
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _m_21,
                                                                                                                                               _m_21);

_d_22 := map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_22, max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_22 = NULL, -NULL, _daycap_b1_22), if(max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)header_first_seen, LEFT))[7..8])))),
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _d_21,
             (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _d_21,
                                                                                                                                               _d_21);

_daycap_22 := map((length(trim((string)header_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_22,
                  (length(trim((string)header_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_21,
                  (length(trim((string)header_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)header_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_21,
                                                                                                                                                    _daycap_21);

years_header_first_seen :=  if((sysdate != NULL) and (header_first_seen2 != NULL), ((sysdate - header_first_seen2) / 365.25), NULL);

_daycap_b1_23 := map((min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_21);

_y_23 := map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)infutor_first_seen, LEFT))[1..4],
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _y_22,
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _y_22,
                                                                                                                                                 _y_22);

_m_23 := map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))),
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _m_22,
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _m_22,
                                                                                                                                                 _m_22);

_d_23 := map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_23, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_23 = NULL, -NULL, _daycap_b1_23), if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8])))),
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _d_22,
             (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _d_22,
                                                                                                                                                 _d_22);

infutor_first_seen2 := map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)infutor_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_23, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_23 = NULL, -NULL, _daycap_b1_23), if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)infutor_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)infutor_first_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                               NULL);

_daycap_23 := map((length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 8) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_23,
                  (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 6) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_22,
                  (length(trim((string)infutor_first_seen, LEFT, RIGHT)) = 4) and ((trim((string)infutor_first_seen, LEFT))[1..2] in ['19', '20']) => _daycap_22,
                                                                                                                                                      _daycap_22);

years_infutor_first_seen :=  if((sysdate != NULL) and (infutor_first_seen2 != NULL), ((sysdate - infutor_first_seen2) / 365.25), NULL);

_daycap_b1_24 := map((min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)date_last_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)date_last_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)date_last_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_22);

_y_24 := map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)date_last_seen, LEFT))[1..4],
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _y_23,
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _y_23,
                                                                                                                                         _y_23);

_m_24 := map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))),
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _m_23,
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _m_23,
                                                                                                                                         _m_23);

_d_24 := map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_24, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_24 = NULL, -NULL, _daycap_b1_24), if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])))),
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _d_23,
             (length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _d_23,
                                                                                                                                         _d_23);

date_last_seen2 := map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_24, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_24 = NULL, -NULL, _daycap_b1_24), if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                       (length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                       (length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                   NULL);

_daycap_24 := map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_24,
                  (length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_23,
                  (length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_23,
                                                                                                                                              _daycap_23);

years_date_last_seen :=  if((sysdate != NULL) and (date_last_seen2 != NULL), ((sysdate - date_last_seen2) / 365.25), NULL);

_daycap_b1_25 := map((min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim(liens_last_unrel_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim(liens_last_unrel_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim(liens_last_unrel_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_23);

_y_25 := map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim(liens_last_unrel_date, LEFT))[1..4],
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _y_24,
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _y_24,
                                                                                                                                       _y_24);

_m_25 := map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))),
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _m_24,
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _m_24,
                                                                                                                                       _m_24);

_d_25 := map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_25, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_25 = NULL, -NULL, _daycap_b1_25), if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8])))),
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _d_24,
             (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _d_24,
                                                                                                                                       _d_24);

_daycap_25 := map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_25,
                  (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _daycap_24,
                  (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => _daycap_24,
                                                                                                                                            _daycap_24);

liens_last_unrel_date2 := map((length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 8) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim(liens_last_unrel_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_25, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_25 = NULL, -NULL, _daycap_b1_25), if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                              (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 6) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(liens_last_unrel_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(liens_last_unrel_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                              (length(trim(liens_last_unrel_date, LEFT, RIGHT)) = 4) and ((trim(liens_last_unrel_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(liens_last_unrel_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                        NULL);

years_liens_last_unrel_date :=  if((sysdate != NULL) and (liens_last_unrel_date2 != NULL), ((sysdate - liens_last_unrel_date2) / 365.25), NULL);

_daycap_b1_26 := map((min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4] % 400) = 0))),
                          _daycap_24);

_y_26 := map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4],
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _y_25,
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _y_25,
                                                                                                                                                             _y_25);

_m_26 := map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))),
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _m_25,
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _m_25,
                                                                                                                                                             _m_25);

_d_26 := map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_26, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_26 = NULL, -NULL, _daycap_b1_26), if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8])))),
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _d_25,
             (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _d_25,
                                                                                                                                                             _d_25);

liens_unrel_cj_last_seen2 := map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)if(max(_daycap_b1_26, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_26 = NULL, -NULL, _daycap_b1_26), if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                                 (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                 (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                                                 NULL);

_daycap_26 := map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_b1_26,
                  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_25,
                  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => _daycap_25,
                                                                                                                                                                  _daycap_25);

years_liens_unrel_cj_last_seen :=  if((sysdate != NULL) and (liens_unrel_cj_last_seen2 != NULL), ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL);

_daycap_b1_27 := map((min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)criminal_last_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)criminal_last_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)criminal_last_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_25);

criminal_last_date2 := map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)criminal_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_27, max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_27 = NULL, -NULL, _daycap_b1_27), if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)criminal_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                           (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)criminal_last_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                               NULL);

_y_27 := map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)criminal_last_date, LEFT))[1..4],
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _y_26,
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _y_26,
                                                                                                                                                 _y_26);

_m_27 := map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[5..6]))),
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _m_26,
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _m_26,
                                                                                                                                                 _m_26);

_d_27 := map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_27, max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_27 = NULL, -NULL, _daycap_b1_27), if(max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)criminal_last_date, LEFT))[7..8])))),
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _d_26,
             (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _d_26,
                                                                                                                                                 _d_26);

_daycap_27 := map((length(trim((string)criminal_last_date, LEFT, RIGHT)) = 8) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_27,
                  (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 6) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_26,
                  (length(trim((string)criminal_last_date, LEFT, RIGHT)) = 4) and ((trim((string)criminal_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_26,
                                                                                                                                                      _daycap_26);

years_criminal_last_date :=  if((sysdate != NULL) and (criminal_last_date2 != NULL), ((sysdate - criminal_last_date2) / 365.25), NULL);

_daycap_b1_28 := map((min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)felony_last_date, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)felony_last_date, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)felony_last_date, LEFT))[1..4] % 400) = 0))),
                          _daycap_26);

_y_28 := map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)felony_last_date, LEFT))[1..4],
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _y_27,
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _y_27,
                                                                                                                                             _y_27);

felony_last_date2 := map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)felony_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))), (string)if(max(_daycap_b1_28, max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_28 = NULL, -NULL, _daycap_b1_28), if(max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                         (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)felony_last_date, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                         (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)felony_last_date, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                                         NULL);

_m_28 := map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[5..6]))),
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _m_27,
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _m_27,
                                                                                                                                             _m_27);

_d_28 := map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_28, max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_28 = NULL, -NULL, _daycap_b1_28), if(max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)felony_last_date, LEFT))[7..8])))),
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _d_27,
             (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _d_27,
                                                                                                                                             _d_27);

_daycap_28 := map((length(trim((string)felony_last_date, LEFT, RIGHT)) = 8) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_b1_28,
                  (length(trim((string)felony_last_date, LEFT, RIGHT)) = 6) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_27,
                  (length(trim((string)felony_last_date, LEFT, RIGHT)) = 4) and ((trim((string)felony_last_date, LEFT))[1..2] in ['19', '20']) => _daycap_27,
                                                                                                                                                  _daycap_27);

years_felony_last_date :=  if((sysdate != NULL) and (felony_last_date2 != NULL), ((sysdate - felony_last_date2) / 365.25), NULL);

_daycap_b1_29 := map((min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)ams_dob, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)ams_dob, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)ams_dob, LEFT))[1..4] % 400) = 0))),
                          _daycap_27);

ams_dob2 := map((length(trim((string)ams_dob, LEFT, RIGHT)) = 8) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)ams_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))), (string)if(max(_daycap_b1_29, max(1, (integer)(trim((string)ams_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_29 = NULL, -NULL, _daycap_b1_29), if(max(1, (integer)(trim((string)ams_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                (length(trim((string)ams_dob, LEFT, RIGHT)) = 6) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)ams_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                (length(trim((string)ams_dob, LEFT, RIGHT)) = 4) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)ams_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                              NULL);

_y_29 := map((length(trim((string)ams_dob, LEFT, RIGHT)) = 8) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)ams_dob, LEFT))[1..4],
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 6) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _y_28,
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 4) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _y_28,
                                                                                                                           _y_28);

_m_29 := map((length(trim((string)ams_dob, LEFT, RIGHT)) = 8) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[5..6]))),
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 6) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _m_28,
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 4) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _m_28,
                                                                                                                           _m_28);

_d_29 := map((length(trim((string)ams_dob, LEFT, RIGHT)) = 8) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_29, max(1, (integer)(trim((string)ams_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_29 = NULL, -NULL, _daycap_b1_29), if(max(1, (integer)(trim((string)ams_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)ams_dob, LEFT))[7..8])))),
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 6) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _d_28,
             (length(trim((string)ams_dob, LEFT, RIGHT)) = 4) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _d_28,
                                                                                                                           _d_28);

_daycap_29 := map((length(trim((string)ams_dob, LEFT, RIGHT)) = 8) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _daycap_b1_29,
                  (length(trim((string)ams_dob, LEFT, RIGHT)) = 6) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _daycap_28,
                  (length(trim((string)ams_dob, LEFT, RIGHT)) = 4) and ((trim((string)ams_dob, LEFT))[1..2] in ['19', '20']) => _daycap_28,
                                                                                                                                _daycap_28);

years_ams_dob :=  if((sysdate != NULL) and (ams_dob2 != NULL), ((sysdate - ams_dob2) / 365.25), NULL);

_daycap_b1_30 := map((min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
                     (min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
                     (min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))) in [2]) => (28 + (integer)((((integer)((integer)(trim((string)reported_dob, LEFT))[1..4] % 4) = 0) and ((integer)((integer)(trim((string)reported_dob, LEFT))[1..4] % 100) > 0)) or ((integer)((integer)(trim((string)reported_dob, LEFT))[1..4] % 400) = 0))),
                          _daycap_28);

_y_30 := map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (integer)(trim((string)reported_dob, LEFT))[1..4],
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _y_29,
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _y_29,
                                                                                                                                     _y_29);

_m_30 := map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))),
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _m_29,
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _m_29,
                                                                                                                                     _m_29);

_d_30 := map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => if(max(_daycap_b1_30, max(1, (integer)(trim((string)reported_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_30 = NULL, -NULL, _daycap_b1_30), if(max(1, (integer)(trim((string)reported_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[7..8])))),
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _d_29,
             (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _d_29,
                                                                                                                                     _d_29);

_daycap_30 := map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _daycap_b1_30,
                  (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _daycap_29,
                  (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => _daycap_29,
                                                                                                                                          _daycap_29);

reported_dob2 := map((length(trim((string)reported_dob, LEFT, RIGHT)) = 8) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)(integer)(trim((string)reported_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))), (string)if(max(_daycap_b1_30, max(1, (integer)(trim((string)reported_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_b1_30 = NULL, -NULL, _daycap_b1_30), if(max(1, (integer)(trim((string)reported_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[7..8]))))) - ut.DaysSince1900('1960', '1', '1')),
                     (length(trim((string)reported_dob, LEFT, RIGHT)) = 6) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)reported_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)reported_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
                     (length(trim((string)reported_dob, LEFT, RIGHT)) = 4) and ((trim((string)reported_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)reported_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                                                                                                             NULL);

years_reported_dob :=  if((sysdate != NULL) and (reported_dob2 != NULL), ((sysdate - reported_dob2) / 365.25), NULL);

Common.findw(rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool'); // source_tot_AK  := 
Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool'); // source_tot_AM  := 
Common.findw(rc_sources, 'AR', ' ,', 'I', source_tot_AR, 'bool'); // source_tot_AR  := 
Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool'); // source_tot_BA  := 
Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool'); // source_tot_CG  := 
Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool'); // source_tot_DA  := 
Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool'); // source_tot_DS  := 
Common.findw(rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool'); // source_tot_EB  := 
Common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool'); // source_tot_EM  := 
Common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool'); // source_tot_VO  := 
Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool'); // source_tot_L2  := 
Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool'); // source_tot_LI  := 
Common.findw(rc_sources, 'P',  ' ,', 'I', source_tot_P,  'bool'); // source_tot_P   := 
Common.findw(rc_sources, 'W',  ' ,', 'I', source_tot_W,  'bool'); // source_tot_W   := 
source_tot_voter := (source_tot_EM or source_tot_VO);
Common.findw(fname_sources, 'P',  ' ,', 'I', source_fst_P,   'bool'); // source_fst_P   := 
Common.findw(fname_sources, 'PL', ' ,', 'I', source_fst_PL,  'bool'); // source_fst_PL  := 
Common.findw(lname_sources, 'P',  ' ,', 'I', source_lst_P,   'bool'); // source_lst_P   := 
Common.findw(lname_sources, 'PL', ' ,', 'I', source_lst_PL,  'bool'); // source_lst_PL  := 
Common.findw(addr_sources,  'P',  ' ,', 'I', source_add_P,   'bool'); // source_add_P   := 
Common.findw(addr_sources,  'PL', ' ,', 'I', source_add_PL,  'bool'); // source_add_PL  := 
Common.findw(ssn_sources,   'P',  ' ,', 'I', source_ssn_P,   'bool'); // source_ssn_P   := 
Common.findw(add2_sources,  'EM', ' ,', 'I', source_add2_EM, 'bool'); // source_add2_EM := 
Common.findw(add2_sources,  'VO', ' ,', 'I', source_add2_VO, 'bool'); // source_add2_VO := 
Common.findw(add2_sources,  'EQ', ' ,', 'I', source_add2_EQ, 'bool'); // source_add2_EQ := 
Common.findw(add2_sources,  'P',  ' ,', 'I', source_add2_P,  'bool'); // source_add2_P  := 
Common.findw(add2_sources,  'WP', ' ,', 'I', source_add2_WP, 'bool'); // source_add2_WP := 
source_add2_voter := (source_add2_EM or source_add2_VO);
Common.findw(add3_sources, 'P', ' ,', 'I', source_add3_P, 'bool'); // source_add3_P  := 

nas_summary_p :=  map(source_fst_P and (source_lst_P and (source_add_P and source_ssn_P)) => 12,
                      source_lst_P and (source_add_P and source_ssn_P)                    => 11,
                      source_fst_P and (source_add_P and source_ssn_P)                    => 10,
                      source_fst_P and (source_lst_P and source_ssn_P)                    => 9,
                      source_fst_P and (source_lst_P and source_add_P)                    => 8,
                      source_lst_P and source_ssn_P                                       => 7,
                      source_add_P and source_ssn_P                                       => 6,
                      source_lst_P and source_add_P                                       => 5,
                      source_fst_P and source_ssn_P                                       => 4,
                      source_fst_P and source_add_P                                       => 3,
                      source_fst_P and source_lst_P                                       => 2,
                      source_ssn_P                                                        => 1,
                                                                                             0);

Common.findw(em_only_sources, 'EM', ' ,', 'I', em_only_source_EM, 'bool'); // em_only_source_EM :=
Common.findw(em_only_sources, 'E1', ' ,', 'I', em_only_source_E1, 'bool'); // em_only_source_E1 :=
Common.findw(em_only_sources, 'E2', ' ,', 'I', em_only_source_E2, 'bool'); // em_only_source_E2 :=
Common.findw(em_only_sources, 'E3', ' ,', 'I', em_only_source_E3, 'bool'); // em_only_source_E3 :=
Common.findw(em_only_sources, 'E4', ' ,', 'I', em_only_source_E4, 'bool'); // em_only_source_E4 :=

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

phn_disconnected := ((integer)rc_hriskphoneflag = 5);

phn_inval := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

phn_zipmismatch := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));

phn_residential := ((integer)rc_hphonevalflag = 2);

ssn_priordob := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

ssn_inval := (((integer)rc_ssnvalflag = 1) or (rc_pwssnvalflag in ['1', '2', '3']));

ssn_issued18 := ((integer)rc_pwssnvalflag = 5);

ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

ssn_adl_prob := ((ssns_per_adl = 0) or ((ssns_per_adl >= 3) or (ssns_per_adl_c6 >= 2)));

ssn_prob := (ssn_deceased or (ssn_priordob or ssn_inval));

bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

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

pk_yr_adl_em_only_first_seen := if (years_adl_em_only_first_seen >= 0, roundup(years_adl_em_only_first_seen), truncate(years_adl_em_only_first_seen));

pk_yr_adl_first_seen_max_fcra := if (years_adl_first_seen_max_fcra >= 0, roundup(years_adl_first_seen_max_fcra), truncate(years_adl_first_seen_max_fcra));

pk_mo_adl_first_seen_max_fcra := if (months_adl_first_seen_max_fcra >= 0, roundup(months_adl_first_seen_max_fcra), truncate(months_adl_first_seen_max_fcra));

pk_yr_lname_change_date := if (years_lname_change_date >= 0, roundup(years_lname_change_date), truncate(years_lname_change_date));

pk_yr_gong_did_first_seen := if (years_gong_did_first_seen >= 0, roundup(years_gong_did_first_seen), truncate(years_gong_did_first_seen));

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

pk_rc_fnamecount :=  map(rc_fnamecount <= 1 => 0,
                         rc_fnamecount <= 2 => 1,
                         rc_fnamecount <= 3 => 2,
                                               3);

pk_rc_lnamecount_nb :=  map(rc_lnamecount <= 1 => 0,
                            rc_lnamecount <= 2 => 1,
                            rc_lnamecount <= 3 => 2,
                            rc_lnamecount <= 4 => 3,
                            rc_lnamecount <= 5 => 4,
                            rc_lnamecount <= 6 => 5,
                                                  6);

pk_rc_phonelnamecount :=  if(rc_phonelnamecount <= 0, 0, 1);

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

pk_lname_eda_sourced_type_lvl :=  map(trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP' => 3,
                                      trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'  => 2,
                                      trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A'  => 1,
                                                                                                      0);

pk_add1_unit_count2 :=  map(add1_unit_count <= 2 => 0,
                            add1_unit_count <= 3 => 1,
                            add1_unit_count <= 4 => 2,
                                                    3);

pk_add2_pos_sources :=  map(source_add2_EQ and (source_add2_WP and source_add2_voter) => 4,
                            source_add2_EQ and source_add2_WP                         => 3,
                            source_add2_voter                                         => 2,
                            source_add2_EQ                                            => 1,
                                                                                         0);

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

pk_em_only_ver_lvl :=  map(em_only_source_EM and em_only_source_E1 => 3,
                           em_only_source_E1                       => 2,
                           em_only_source_E4                       => -1,
                           em_only_source_EM                       => 1,
                                                                      0);

pk_add2_em_ver_lvl :=  map(add2_source_E1 => 2,
                           add2_source_E4 => -1,
                           add2_source_EM => 1,
                                             0);

pk_infutor_risk_lvl :=  map(infutor_nap in [1, 6] => 2,
                            infutor_nap in [0]    => 0,
                                                     1);

pk_infutor_risk_lvl_nb :=  map(infutor_nap in [1, 6] => 3,
                               infutor_nap in [12]   => 0,
                               infutor_nap in [0]    => 1,
                                                        2);

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

pk_yr_add1_mortgage_date := if (years_add1_mortgage_date >= 0, roundup(years_add1_mortgage_date), truncate(years_add1_mortgage_date));

pk_yr_add1_mortgage_due_date := if (years_add1_mortgage_due_date >= 0, roundup(years_add1_mortgage_due_date), truncate(years_add1_mortgage_due_date));

pk_yr_add1_date_first_seen := if (years_add1_date_first_seen >= 0, roundup(years_add1_date_first_seen), truncate(years_add1_date_first_seen));

pk_yr_add2_assessed_value_year := if (years_add2_assessed_value_year >= 0, roundup(years_add2_assessed_value_year), truncate(years_add2_assessed_value_year));

pk_yr_add2_mortgage_due_date := if (years_add2_mortgage_due_date >= 0, roundup(years_add2_mortgage_due_date), truncate(years_add2_mortgage_due_date));

pk_yr_add2_date_first_seen := if (years_add2_date_first_seen >= 0, roundup(years_add2_date_first_seen), truncate(years_add2_date_first_seen));

pk_yr_add3_date_first_seen := if (years_add3_date_first_seen >= 0, roundup(years_add3_date_first_seen), truncate(years_add3_date_first_seen));

pk_property_owned_assessed_total := (20000 * if ((property_owned_assessed_total / 20000) >= 0, roundup((property_owned_assessed_total / 20000)), truncate((property_owned_assessed_total / 20000))));

pk_add1_purchase_amount := (20000 * if ((add1_purchase_amount / 20000) >= 0, roundup((add1_purchase_amount / 20000)), truncate((add1_purchase_amount / 20000))));

pk_add1_assessed_amount := (20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000))));

pk_add2_assessed_amount := (20000 * if ((add2_assessed_amount / 20000) >= 0, roundup((add2_assessed_amount / 20000)), truncate((add2_assessed_amount / 20000))));

pk_add3_assessed_amount := (20000 * if ((add3_assessed_amount / 20000) >= 0, roundup((add3_assessed_amount / 20000)), truncate((add3_assessed_amount / 20000))));

pk_property_owned_assessed_total_2 :=  if(pk_property_owned_assessed_total > 1000000, 1000000, pk_property_owned_assessed_total);

pk_add1_purchase_amount_2 :=  if(pk_add1_purchase_amount > 1000000, 1000000, pk_add1_purchase_amount);

pk_add1_assessed_amount_2 :=  if(pk_add1_assessed_amount > 1000000, 1000000, pk_add1_assessed_amount);

pk_add2_assessed_amount_2 :=  if(pk_add2_assessed_amount > 1000000, 1000000, pk_add2_assessed_amount);

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

pk_pr_count :=  map(pr_count <= 0 => -1,
                    pr_count <= 1 => 0,
                    pr_count <= 9 => 1,
                                     2);

pk_nas_summary_p :=  if(nas_summary_p <= 0, 0, 1);

pk_addrs_sourced_lvl :=  map(source_add_P and (source_add2_P or source_add3_P) => 3,
                             source_add_P                                      => 2,
                             source_add2_P or source_add3_P                    => 1,
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

pk_add1_no_of_rooms :=  map((integer)add1_no_of_rooms <= 0 => -1,
                            (integer)add1_no_of_rooms <= 4 => 0,
                            (integer)add1_no_of_rooms <= 5 => 1,
                            (integer)add1_no_of_rooms <= 6 => 2,
                            (integer)add1_no_of_rooms <= 7 => 3,
                                                              4);

pk_add1_no_of_baths :=  map((integer)add1_no_of_baths <= 0 => -3,
                            (integer)add1_no_of_baths <= 1 => -2,
                            (integer)add1_no_of_baths <= 2 => -1,
                            (integer)add1_no_of_baths <= 3 => 0,
                            (integer)add1_no_of_baths <= 5 => 1,
                                                              2);

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

pk_add2_garage_type_risk_level :=  map(trim(trim(add2_garage_type_code, LEFT), LEFT, RIGHT) in ['M', 'A', 'U'] => 0,
                                       trim(trim(add2_garage_type_code, LEFT), LEFT, RIGHT) in ['G', 'B', 'Y'] => 1,
                                       trim(trim(add2_garage_type_code, LEFT), LEFT, RIGHT) in ['C', 'N', 'D'] => 2,
                                                                                                                  3);

pk_add2_parking_no_of_cars :=  map((integer)add2_parking_no_of_cars <= 0 => 0,
                                   (integer)add2_parking_no_of_cars <= 1 => 1,
                                   (integer)add2_parking_no_of_cars <= 2 => 2,
                                                                            3);

pk_yr_add2_assessed_value_year2 :=  map((real)pk_yr_add2_assessed_value_year <= NULL => -1,
                                        pk_yr_add2_assessed_value_year <= 0          => 0,
                                        pk_yr_add2_assessed_value_year <= 1          => 1,
                                                                                        2);

pk_yr_add2_mortgage_due_date2 :=  map((real)pk_yr_add2_mortgage_due_date <= NULL => -1,
                                      pk_yr_add2_mortgage_due_date <= -26        => 3,
                                      pk_yr_add2_mortgage_due_date <= -23        => 2,
                                      pk_yr_add2_mortgage_due_date <= -12        => 1,
                                                                                    0);

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

pk_add3_mortgage_risk :=  map(trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['S', '1', 'H']   => 5,
                              trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['FHA', '2']      => 4,
                              trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['N', 'R', 'G']   => 3,
                              trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['U', '', 'P']    => 2,
                              trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['VA']            => 1,
                              trim(trim(add3_mortgage_type, LEFT), LEFT, RIGHT) in ['CNS', 'E', 'C'] => 0,
                                                                                                        -1);

pk_add3_adjustable_financing :=  if(trim(trim(add3_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

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

pk_attr_num_sold180 :=  if(attr_num_sold180 <= 0, 0, 1);

pk_yr_liens_last_unrel_date := if (years_liens_last_unrel_date >= 0, roundup(years_liens_last_unrel_date), truncate(years_liens_last_unrel_date));

pk_yr_criminal_last_date := if (years_criminal_last_date >= 0, roundup(years_criminal_last_date), truncate(years_criminal_last_date));

pk_yr_felony_last_date := if (years_felony_last_date >= 0, roundup(years_felony_last_date), truncate(years_felony_last_date));

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

pk_yr_criminal_last_date2 :=  map((real)pk_yr_criminal_last_date <= NULL => -1,
                                  pk_yr_criminal_last_date <= 1          => 0,
                                  pk_yr_criminal_last_date <= 2          => 1,
                                  pk_yr_criminal_last_date <= 3          => 2,
                                  pk_yr_criminal_last_date <= 5          => 3,
                                                                            4);

pk_yr_felony_last_date2 :=  map((real)pk_yr_felony_last_date <= NULL => -1,
                                pk_yr_felony_last_date <= 1          => 0,
                                pk_yr_felony_last_date <= 2          => 1,
                                pk_yr_felony_last_date <= 4          => 2,
                                                                        3);

pk_yr_rc_ssnhighissue := if (years_rc_ssnhighissue >= 0, roundup(years_rc_ssnhighissue), truncate(years_rc_ssnhighissue));

pk_yr_rc_areacodesplitdate := if (years_rc_areacodesplitdate >= 0, roundup(years_rc_areacodesplitdate), truncate(years_rc_areacodesplitdate));

pk_add_standarization_error :=  if(trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E', 1, 0);

pk_addr_changed :=  if((add_ec1 = 'S') and (add_ec3 != '0'), 1, 0);

pk_unit_changed :=  if((add_ec1 = 'S') and (add_ec4 != '0'), 1, 0);

pk_add_standarization_flag :=  if((boolean)pk_add_standarization_error or ((boolean)pk_addr_changed or (boolean)pk_unit_changed), 1, 0);

pk_addr_not_valid :=  if(trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N', 1, 0);

pk_corp_mil_zip :=  if((rc_hriskaddrflag in ['2', '3']) or (rc_ziptypeflag in ['2', '3']), 1, 0);

pk_area_code_split :=  if(trim(trim(rc_areacodesplitflag, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

pk_recent_ac_split :=  map((pk_yr_rc_areacodesplitdate >= 1) and (pk_yr_rc_areacodesplitdate <= 5) => 1,
                           pk_yr_rc_areacodesplitdate >= 6                                         => -1,
                                                                                                      0);

pk_phn_not_residential := not(phn_residential);

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

pk_pl_sourced_level :=  map(((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and (((integer)source_fst_PL = 1) and ((integer)prof_license_flag = 1))) => 3,
                            ((integer)source_add_PL = 1) and (((integer)source_lst_PL = 1) and ((integer)source_fst_PL = 1))                                        => 2,
                            (integer)prof_license_flag = 1                                                                                                          => 2,
                            ((integer)source_add_PL = 0) and (((integer)source_lst_PL = 0) and ((integer)source_fst_PL = 0))                                        => 0,
                                                                                                                                                                       1);

pk_prof_lic_cat :=  map(trim(prof_license_category)='' => -1,
                        ((integer)(real)prof_license_category <= 1) => 0,
                        ((integer)(real)prof_license_category <= 3) => 1,
                        ((integer)(real)prof_license_category <= 4) => 2,
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

pk_add1_lres_flag :=  if(add1_lres > 0, 1, 0);

pk_add2_lres_flag :=  if(add2_lres > 0, 1, 0);

pk_add3_lres_flag :=  if(add3_lres > 0, 1, 0);

pk_lres_flag_level :=  map((boolean)pk_add1_lres_flag and ((boolean)pk_add2_lres_flag or (boolean)pk_add3_lres_flag) => 2,
                           pk_add1_lres_flag=1                                                                       => 1,
                                                                                                                        0);

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

pk_adls_per_addr := if((integer)add_apt = 0, pk_adls_per_addr_b1, pk_adls_per_addr_b2);

pk_ssns_per_addr2 := if((integer)add_apt = 0, pk_ssns_per_addr2_b1, pk_ssns_per_addr2_b2);

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

pk_ssns_per_addr_c6 := if((integer)add_apt = 0, pk_ssns_per_addr_c6_b1, pk_ssns_per_addr_c6_b2);

pk_adls_per_phone_c6 :=  map(adls_per_phone_c6 <= 0 => 0,
                             adls_per_phone_c6 <= 1 => 1,
                                                       2);

pk_vo_addrs_per_adl :=  if(vo_addrs_per_adl <= 0, 0, 1);

pk_attr_addrs_last90 :=  map(attr_addrs_last90 <= 0 => 0,
                             attr_addrs_last90 <= 1 => 1,
                                                       2);

pk_attr_addrs_last12 :=  map(attr_addrs_last12 <= 0 => 0,
                             attr_addrs_last12 <= 1 => 1,
                             attr_addrs_last12 <= 2 => 2,
                             attr_addrs_last12 <= 3 => 3,
                                                       4);

pk_attr_addrs_last24 :=  map(attr_addrs_last24 <= 0 => 0,
                             attr_addrs_last24 <= 1 => 1,
                             attr_addrs_last24 <= 2 => 2,
                             attr_addrs_last24 <= 3 => 3,
                             attr_addrs_last24 <= 5 => 4,
                                                       5);

ams_class_n_b8 := (real)ams_class;

ams_class_n_b8_2 := if(((integer)(ams_class_n_b8) >= 60), (ams_class_n_b8 + 1900), (ams_class_n_b8 + 2000));

pk_ams_class_level_b8 := map(((integer)(sysyear - ams_class_n_b8_2) <= 1) => 0,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 2) => 1,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 3) => 2,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 4) => 3,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 5) => 4,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 10) => 5,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 13) => 6,
                             ((integer)(sysyear - ams_class_n_b8_2) <= 17) => 7,
                                  8);

pk_since_ams_class_year := map(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'JR' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SO' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'FR' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'UN' => NULL,
                               trim(trim(ams_class, LEFT), LEFT, RIGHT) = ''   => NULL,
                                                                                  (sysyear - ams_class_n_b8_2));

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

pk_ams_4yr_college :=  map((integer)ams_college_code = 4 => 1,
                           (integer)ams_college_code = 2 => -1,
                                                            0);

pk_ams_college_type :=  map(trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'P' => 2,
                            trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'S' => 1,
                                                                                     0);

pk_ams_income_level_code :=  map(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['A', 'B'] => 0,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['C']      => 1,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['D', 'E'] => 2,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['F']      => 3,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['G', 'H'] => 4,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['I', 'J'] => 5,
                                 trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['K']      => 6,
                                                                                                       -1);

pk_yr_in_dob := if (years_in_dob >= 0, roundup(years_in_dob), truncate(years_in_dob));

pk_yr_ams_dob := if (years_ams_dob >= 0, roundup(years_ams_dob), truncate(years_ams_dob));

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

pk_yr_ams_dob2 :=  map((real)pk_yr_ams_dob <= NULL => -1,
                       pk_yr_ams_dob <= 20         => 20,
                       pk_yr_ams_dob <= 22         => 22,
                       pk_yr_ams_dob <= 23         => 23,
                       pk_yr_ams_dob <= 32         => 32,
                       pk_yr_ams_dob <= 43         => 43,
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

pk_add1_avm_mkt := if(trim(add1_avm_market_total_value)='', NULL, (20000 * if (((real)add1_avm_market_total_value / 20000) >= 0, roundup(((real)add1_avm_market_total_value / 20000)), truncate(((real)add1_avm_market_total_value / 20000)))));

pk_add1_avm_pi := (20000 * if ((add1_avm_price_index_valuation / 20000) >= 0, roundup((add1_avm_price_index_valuation / 20000)), truncate((add1_avm_price_index_valuation / 20000))));

pk_add1_avm_auto := (20000 * if ((add1_avm_automated_valuation / 20000) >= 0, roundup((add1_avm_automated_valuation / 20000)), truncate((add1_avm_automated_valuation / 20000))));

pk_add1_avm_auto2 := (20000 * if ((add1_avm_automated_valuation_2 / 20000) >= 0, roundup((add1_avm_automated_valuation_2 / 20000)), truncate((add1_avm_automated_valuation_2 / 20000))));

pk_add1_avm_auto3 := (20000 * if ((add1_avm_automated_valuation_3 / 20000) >= 0, roundup((add1_avm_automated_valuation_3 / 20000)), truncate((add1_avm_automated_valuation_3 / 20000))));

pk_add1_avm_auto4 := (20000 * if ((add1_avm_automated_valuation_4 / 20000) >= 0, roundup((add1_avm_automated_valuation_4 / 20000)), truncate((add1_avm_automated_valuation_4 / 20000))));

pk_add1_avm_med := (20000 * if ((add1_avm_med / 20000) >= 0, roundup((add1_avm_med / 20000)), truncate((add1_avm_med / 20000))));

pk_add2_avm_sp := if(trim(add2_avm_sales_price)='', NULL, (20000 * if (((real)add2_avm_sales_price / 20000) >= 0, roundup(((real)add2_avm_sales_price / 20000)), truncate(((real)add2_avm_sales_price / 20000)))));

pk_add2_avm_ta := (20000 * if ((add2_avm_tax_assessed_valuation / 20000) >= 0, roundup((add2_avm_tax_assessed_valuation / 20000)), truncate((add2_avm_tax_assessed_valuation / 20000))));

pk_add2_avm_pi := (20000 * if ((add2_avm_price_index_valuation / 20000) >= 0, roundup((add2_avm_price_index_valuation / 20000)), truncate((add2_avm_price_index_valuation / 20000))));

pk_add2_avm_hed := (20000 * if ((add2_avm_hedonic_valuation / 20000) >= 0, roundup((add2_avm_hedonic_valuation / 20000)), truncate((add2_avm_hedonic_valuation / 20000))));

pk_add2_avm_auto := (20000 * if ((add2_avm_automated_valuation / 20000) >= 0, roundup((add2_avm_automated_valuation / 20000)), truncate((add2_avm_automated_valuation / 20000))));

pk_add2_avm_auto2 := (20000 * if ((add2_avm_automated_valuation_2 / 20000) >= 0, roundup((add2_avm_automated_valuation_2 / 20000)), truncate((add2_avm_automated_valuation_2 / 20000))));

pk_add2_avm_auto3 := (20000 * if ((add2_avm_automated_valuation_3 / 20000) >= 0, roundup((add2_avm_automated_valuation_3 / 20000)), truncate((add2_avm_automated_valuation_3 / 20000))));

pk_add1_avm_mkt_2 :=  if(pk_add1_avm_mkt > 1000000, 1000000, pk_add1_avm_mkt);

pk_add1_avm_pi_2 :=  if(pk_add1_avm_pi > 1000000, 1000000, pk_add1_avm_pi);

pk_add1_avm_auto_2 :=  if(pk_add1_avm_auto > 1000000, 1000000, pk_add1_avm_auto);

pk_add1_avm_auto2_2 :=  if(pk_add1_avm_auto2 > 1000000, 1000000, pk_add1_avm_auto2);

pk_add1_avm_auto3_2 :=  if(pk_add1_avm_auto3 > 1000000, 1000000, pk_add1_avm_auto3);

pk_add1_avm_auto4_2 :=  if(pk_add1_avm_auto4 > 1000000, 1000000, pk_add1_avm_auto4);

pk_add1_avm_med_2 :=  if(pk_add1_avm_med > 1000000, 1000000, pk_add1_avm_med);

pk_add2_avm_sp_2 :=  if(pk_add2_avm_sp > 1000000, 1000000, pk_add2_avm_sp);

pk_add2_avm_ta_2 :=  if(pk_add2_avm_ta > 1000000, 1000000, pk_add2_avm_ta);

pk_add2_avm_pi_2 :=  if(pk_add2_avm_pi > 1000000, 1000000, pk_add2_avm_pi);

pk_add2_avm_hed_2 :=  if(pk_add2_avm_hed > 1000000, 1000000, pk_add2_avm_hed);

pk_add2_avm_auto_2 :=  if(pk_add2_avm_auto > 1000000, 1000000, pk_add2_avm_auto);

pk_add2_avm_auto2_2 :=  if(pk_add2_avm_auto2 > 1000000, 1000000, pk_add2_avm_auto2);

pk_add2_avm_auto3_2 :=  if(pk_add2_avm_auto3 > 1000000, 1000000, pk_add2_avm_auto3);

pk_add1_avm_to_med_ratio := round(10*add1_avm_to_med_ratio)/10;

pk_add1_avm_to_med_ratio_2 :=  if(pk_add1_avm_to_med_ratio > 10, 10, pk_add1_avm_to_med_ratio);

pk_add1_avm_confidence_score :=  if(add1_avm_confidence_score >= 80, 1, 0);

pk2_add1_avm_mkt :=  map((real)pk_add1_avm_mkt_2 <= NULL => 1,
                         pk_add1_avm_mkt_2 <= 60000      => 0,
                         pk_add1_avm_mkt_2 <= 80000      => 1,
                         pk_add1_avm_mkt_2 <= 120000     => 2,
                         pk_add1_avm_mkt_2 <= 480000     => 3,
                                                            4);

pk2_add1_avm_pi :=  map(pk_add1_avm_pi_2 <= 0      => 2,
                        pk_add1_avm_pi_2 <= 20000  => 0,
                        pk_add1_avm_pi_2 <= 120000 => 1,
                        pk_add1_avm_pi_2 <= 180000 => 2,
                                                      3);

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

pk_avm_auto_diff2 :=  if((pk_add1_avm_auto_2 = 0) or (pk_add1_avm_auto2_2 = 0), -999999, (pk_add1_avm_auto_2 - pk_add1_avm_auto2_2));

pk_avm_auto_diff4 :=  if((pk_add1_avm_auto_2 = 0) or (pk_add1_avm_auto4_2 = 0), -999999, (pk_add1_avm_auto_2 - pk_add1_avm_auto4_2));

pk_avm_auto_diff2_lvl :=  map(pk_avm_auto_diff2 = -999999 => -2,
                              pk_avm_auto_diff2 < 0       => -1,
                              pk_avm_auto_diff2 = 0       => 0,
                              pk_avm_auto_diff2 <= 40000  => 1,
                                                             2);

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

pk_add2_avm_confidence_score :=  if(add2_avm_confidence_score >= 80, 1, 0);

pk_avm_confidence_level :=  map((boolean)pk_add1_avm_confidence_score and (boolean)pk_add2_avm_confidence_score => 3,
                                (boolean)pk_add1_avm_confidence_score                                           => 2,
                                (boolean)pk_add2_avm_confidence_score                                           => 1,
                                                                                                                   0);

pk2_add2_avm_sp :=  map((real)pk_add2_avm_sp_2 <= NULL => 3,
                        pk_add2_avm_sp_2 <= 20000      => 0,
                        pk_add2_avm_sp_2 <= 40000      => 1,
                        pk_add2_avm_sp_2 <= 60000      => 2,
                        pk_add2_avm_sp_2 <= 80000      => 3,
                        pk_add2_avm_sp_2 <= 140000     => 4,
                                                          5);

pk2_add2_avm_ta :=  map(pk_add2_avm_ta_2 <= 0      => 1,
                        pk_add2_avm_ta_2 <= 60000  => 0,
                        pk_add2_avm_ta_2 <= 100000 => 1,
                                                      2);

pk2_add2_avm_pi :=  map(pk_add2_avm_pi_2 <= 0      => 2,
                        pk_add2_avm_pi_2 <= 40000  => 0,
                        pk_add2_avm_pi_2 <= 80000  => 1,
                        pk_add2_avm_pi_2 <= 520000 => 3,
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

pk_add2_avm_auto_diff2 :=  if((pk_add2_avm_auto_2 = 0) or (pk_add2_avm_auto2_2 = 0), -999999, (pk_add2_avm_auto_2 - pk_add2_avm_auto2_2));

pk_add2_avm_auto_diff2_lvl :=  map(pk_add2_avm_auto_diff2 = -999999 => -3,
                                   pk_add2_avm_auto_diff2 < -40000  => -2,
                                   pk_add2_avm_auto_diff2 < -20000  => -1,
                                   pk_add2_avm_auto_diff2 = 0       => 0,
                                                                       1);

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

pk_attr_total_number_derogs_3 := attr_total_number_derogs;

pk_attr_total_number_derogs_4 :=  if(pk_attr_total_number_derogs_3 > 3, 3, pk_attr_total_number_derogs_3);

pk_attr_num_nonderogs90_3 := attr_num_nonderogs90;

pk_attr_num_nonderogs90_4 :=  if(pk_attr_num_nonderogs90_3 > 4, 4, pk_attr_num_nonderogs90_3);

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

pk_nas_summary_mm_b1_c2_b1 := map(pk_nas_summary = 0 => 0.093220339,
                                  pk_nas_summary = 1 => 0.0611510791,
                                                        0.0459332288);

pk_nap_summary_mm_b1_c2_b1 := map(pk_nap_summary = -1 => 0.0784313725,
                                  pk_nap_summary = 0  => 0.054722041,
                                  pk_nap_summary = 1  => 0.0417142857,
                                                         0.0344785276);

pk_combo_fnamecount_mm_b1_c2_b1 := map(pk_combo_fnamecount = 0 => 0.0968921389,
                                       pk_combo_fnamecount = 1 => 0.0720338983,
                                       pk_combo_fnamecount = 2 => 0.0552122783,
                                       pk_combo_fnamecount = 3 => 0.046167911,
                                                                  0.0364057077);

pk_rc_fnamecount_mm_b1_c2_b1 := map(pk_rc_fnamecount = 0 => 0.0938897168,
                                    pk_rc_fnamecount = 1 => 0.0686997319,
                                    pk_rc_fnamecount = 2 => 0.0499927124,
                                                            0.0392064242);

pk_rc_phonelnamecount_mm_b1_c2_b1 := map(pk_rc_phonelnamecount = 0 => 0.0548762737,
                                                                      0.037995916);

pk_rc_addrcount_mm_b1_c2_b1 := map(pk_rc_addrcount = 0 => 0.0610521511,
                                   pk_rc_addrcount = 1 => 0.0439082278,
                                   pk_rc_addrcount = 2 => 0.0339821315,
                                                          0.0359462971);

pk_rc_phonephonecount_mm_b1_c2_b1 := map(pk_rc_phonephonecount = 0 => 0.0540902995,
                                                                      0.0411876806);

pk_ver_phncount_mm_b1_c2_b1 := map(pk_ver_phncount = 0 => 0.057057465,
                                   pk_ver_phncount = 1 => 0.0583019882,
                                   pk_ver_phncount = 2 => 0.0434359411,
                                                          0.0344785276);

pk_gong_did_phone_ct_mm_b1_c2_b1 := map(pk_gong_did_phone_ct = -1 => 0.0521322889,
                                        pk_gong_did_phone_ct = 0  => 0.0384807596,
                                        pk_gong_did_phone_ct = 1  => 0.0425639726,
                                        pk_gong_did_phone_ct = 2  => 0.0640589569,
                                                                     0.0406504065);

pk_combo_ssncount_mm_b1_c2_b1 := map(pk_combo_ssncount = -1 => 0.0957446809,
                                     pk_combo_ssncount = 0  => 0.0464507488,
                                                               0.0460117087);

pk_combo_dobcount_mm_b1_c2_b1 := map(pk_combo_dobcount = 0 => 0.1117824773,
                                     pk_combo_dobcount = 1 => 0.0642791552,
                                     pk_combo_dobcount = 2 => 0.0612823238,
                                     pk_combo_dobcount = 3 => 0.048601344,
                                                              0.0377755759);

pk_eq_count_mm_b1_c2_b1 := map(pk_eq_count = 0 => 0.1860465116,
                               pk_eq_count = 1 => 0.0742459397,
                               pk_eq_count = 2 => 0.0640138408,
                               pk_eq_count = 3 => 0.0404475043,
                               pk_eq_count = 4 => 0.0556809631,
                               pk_eq_count = 5 => 0.0464989059,
                                                  0.0388062849);

pk_pos_secondary_sources_mm_b1_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.0469315426,
                                            pk_pos_secondary_sources = 1 => 0.0247349823,
                                                                            0.0274725275);

pk_voter_flag_mm_b1_c2_b1 := map(pk_voter_flag = -1 => 0.0575992256,
                                 pk_voter_flag = 0  => 0.0460473064,
                                                       0.0430292599);

pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0572531715,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0502673797,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0440510498,
                                                                                      0.0366923691);

pk_add2_pos_sources_mm_b1_c2_b1 := map(pk_add2_pos_sources = 0 => 0.044113515,
                                       pk_add2_pos_sources = 1 => 0.0462635331,
                                       pk_add2_pos_sources = 2 => 0.0514991182,
                                       pk_add2_pos_sources = 3 => 0.0419235512,
                                                                  0.0558882236);

pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := map(pk_ssnchar_invalid_or_recent = 0 => 0.046420113,
                                                                                    0.1428571429);

pk_infutor_risk_lvl_mm_b1_c2_b1 := map(pk_infutor_risk_lvl = 0 => 0.0410295478,
                                       pk_infutor_risk_lvl = 1 => 0.0549978175,
                                                                  0.0649409628);

pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.046583045,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0472636816,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0479115479,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0462085308,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0451197053,
                                                                                       0.03);

pk_yr_lname_change_date2_mm_b1_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.0460234782,
                                            pk_yr_lname_change_date2 = 0  => 0.0674698795,
                                            pk_yr_lname_change_date2 = 1  => 0.0508083141,
                                                                             0.0426966292);

pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.052851335,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.0742358079,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0659459459,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0607247796,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0472516876,
                                                                                 0.0382585752);

pk_yr_header_first_seen2_mm_b1_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.1135531136,
                                            pk_yr_header_first_seen2 = 0  => 0.0862533693,
                                            pk_yr_header_first_seen2 = 1  => 0.067264574,
                                            pk_yr_header_first_seen2 = 2  => 0.0613535737,
                                            pk_yr_header_first_seen2 = 3  => 0.0667361835,
                                            pk_yr_header_first_seen2 = 4  => 0.0448654038,
                                            pk_yr_header_first_seen2 = 5  => 0.0334261838,
                                            pk_yr_header_first_seen2 = 6  => 0.029717682,
                                                                             0.0231854839);

pk_yr_infutor_first_seen2_mm_b1_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.0410295478,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0555969223,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0608908868,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0492813142,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0666666667,
                                                                               0.0544117647);

pk_em_only_ver_lvl_mm_b1_c2_b1 := map(pk_em_only_ver_lvl = -1 => 0.0365168539,
                                      pk_em_only_ver_lvl = 0  => 0.0463653713,
                                      pk_em_only_ver_lvl = 1  => 0.0476190476,
                                      pk_em_only_ver_lvl = 2  => 0.0476858345,
                                                                 0.0486111111);

pk_add2_em_ver_lvl_mm_b1_c2_b1 := map(pk_add2_em_ver_lvl = -1 => 0.0487804878,
                                      pk_add2_em_ver_lvl = 0  => 0.0461117029,
                                      pk_add2_em_ver_lvl = 1  => 0.052173913,
                                                                 0.0604982206);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.25,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.5,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.3333333333,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.3333333333,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1818181818,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0989010989,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0909090909,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0838709677,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0898876404,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1333333333,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0718085106,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0687936191,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0532629559,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0486891386,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0502721742,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0382882883,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0368259908,
                                                                                      0.0291798107);

pk_nas_summary_mm_b1_c2_b2 := map(pk_nas_summary = 0 => 0.0111607143,
                                  pk_nas_summary = 1 => 0.0303030303,
                                                        0.0132191975);

pk_nap_summary_mm_b1_c2_b2 := map(pk_nap_summary = -1 => 0.0296411856,
                                  pk_nap_summary = 0  => 0.0198109572,
                                  pk_nap_summary = 1  => 0.0092637401,
                                                         0.0098163606);

pk_combo_fnamecount_mm_b1_c2_b2 := map(pk_combo_fnamecount = 0 => 0.0207635633,
                                       pk_combo_fnamecount = 1 => 0.0167554799,
                                       pk_combo_fnamecount = 2 => 0.014216208,
                                       pk_combo_fnamecount = 3 => 0.012751871,
                                                                  0.0118566638);

pk_rc_fnamecount_mm_b1_c2_b2 := map(pk_rc_fnamecount = 0 => 0.0212053571,
                                    pk_rc_fnamecount = 1 => 0.0159437183,
                                    pk_rc_fnamecount = 2 => 0.0127805267,
                                                            0.0125253756);

pk_rc_phonelnamecount_mm_b1_c2_b2 := map(pk_rc_phonelnamecount = 0 => 0.0201688118,
                                                                      0.009732585);

pk_rc_addrcount_mm_b1_c2_b2 := map(pk_rc_addrcount = 0 => 0.0180066521,
                                   pk_rc_addrcount = 1 => 0.0131726942,
                                   pk_rc_addrcount = 2 => 0.0121922137,
                                                          0.0089130778);

pk_rc_phonephonecount_mm_b1_c2_b2 := map(pk_rc_phonephonecount = 0 => 0.0208739372,
                                                                      0.0103713496);

pk_ver_phncount_mm_b1_c2_b2 := map(pk_ver_phncount = 0 => 0.0220908827,
                                   pk_ver_phncount = 1 => 0.0181289681,
                                   pk_ver_phncount = 2 => 0.0117079028,
                                                          0.0098163606);

pk_gong_did_phone_ct_mm_b1_c2_b2 := map(pk_gong_did_phone_ct = -1 => 0.0143074913,
                                        pk_gong_did_phone_ct = 0  => 0.0119390165,
                                        pk_gong_did_phone_ct = 1  => 0.0145703405,
                                        pk_gong_did_phone_ct = 2  => 0.015270326,
                                                                     0.019047619);

pk_combo_ssncount_mm_b1_c2_b2 := map(pk_combo_ssncount = -1 => 0.0090293454,
                                     pk_combo_ssncount = 0  => 0.0134855214,
                                                               0.0186263097);

pk_combo_dobcount_mm_b1_c2_b2 := map(pk_combo_dobcount = 0 => 0.031713763,
                                     pk_combo_dobcount = 1 => 0.0148504497,
                                     pk_combo_dobcount = 2 => 0.0143553273,
                                     pk_combo_dobcount = 3 => 0.0123545432,
                                                              0.012001574);

pk_eq_count_mm_b1_c2_b2 := map(pk_eq_count = 0 => 0.0213675214,
                               pk_eq_count = 1 => 0.0139780884,
                               pk_eq_count = 2 => 0.012987013,
                               pk_eq_count = 3 => 0.0116212339,
                               pk_eq_count = 4 => 0.0121235823,
                               pk_eq_count = 5 => 0.0134435319,
                                                  0.01437412);

pk_pos_secondary_sources_mm_b1_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.0136256744,
                                            pk_pos_secondary_sources = 1 => 0.0104669887,
                                                                            0.0076157001);

pk_voter_flag_mm_b1_c2_b2 := map(pk_voter_flag = -1 => 0.017746339,
                                 pk_voter_flag = 0  => 0.0132851828,
                                                       0.0124808562);

pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0208929481,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0191057145,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0111222445,
                                                                                      0.0095216366);

pk_add2_pos_sources_mm_b1_c2_b2 := map(pk_add2_pos_sources = 0 => 0.0117116088,
                                       pk_add2_pos_sources = 1 => 0.0132341915,
                                       pk_add2_pos_sources = 2 => 0.0161630358,
                                       pk_add2_pos_sources = 3 => 0.0179700499,
                                                                  0.0101232394);

pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0134885487,
                                                                                    0.0441176471);

pk_infutor_risk_lvl_mm_b1_c2_b2 := map(pk_infutor_risk_lvl = 0 => 0.0110085784,
                                       pk_infutor_risk_lvl = 1 => 0.0203114718,
                                                                  0.0239117106);

pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0134019513,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0129427793,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0146015853,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0160558464,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0140504434,
                                                                                       0.008291874);

pk_yr_lname_change_date2_mm_b1_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.0134584122,
                                            pk_yr_lname_change_date2 = 0  => 0.0255288111,
                                            pk_yr_lname_change_date2 = 1  => 0.013552759,
                                                                             0.0063532402);

pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0143452579,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.0213692125,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0229032258,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0185140073,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.014142166,
                                                                                 0.011764134);

pk_yr_header_first_seen2_mm_b1_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.0226229508,
                                            pk_yr_header_first_seen2 = 0  => 0.0354122622,
                                            pk_yr_header_first_seen2 = 1  => 0.0209537572,
                                            pk_yr_header_first_seen2 = 2  => 0.0185541997,
                                            pk_yr_header_first_seen2 = 3  => 0.0140329469,
                                            pk_yr_header_first_seen2 = 4  => 0.0123381546,
                                            pk_yr_header_first_seen2 = 5  => 0.0090225564,
                                            pk_yr_header_first_seen2 = 6  => 0.0089425124,
                                                                             0.0080378251);

pk_yr_infutor_first_seen2_mm_b1_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.0110085784,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0214291342,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0240840379,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0200312989,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0174646191,
                                                                               0.0160590278);

pk_em_only_ver_lvl_mm_b1_c2_b2 := map(pk_em_only_ver_lvl = -1 => 0.010495382,
                                      pk_em_only_ver_lvl = 0  => 0.013378221,
                                      pk_em_only_ver_lvl = 1  => 0.0152849107,
                                      pk_em_only_ver_lvl = 2  => 0.0135220126,
                                                                 0.0156017831);

pk_add2_em_ver_lvl_mm_b1_c2_b2 := map(pk_add2_em_ver_lvl = -1 => 0.0159680639,
                                      pk_add2_em_ver_lvl = 0  => 0.0134120219,
                                      pk_add2_em_ver_lvl = 1  => 0.0170316302,
                                                                 0.0141620771);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.0869565217,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1136363636,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.0632911392,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.0281690141,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.0632911392,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0408997955,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0363636364,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0419091967,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.037037037,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0362318841,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0277712403,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0199251637,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0169798051,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0146636914,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0120433236,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0118221184,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0091160527,
                                                                                      0.0079735034);

pk_nas_summary_mm_b1_c2_b3 := map(pk_nas_summary = 0 => 0.0730088496,
                                  pk_nas_summary = 1 => 0.0531177829,
                                                        0.0453559511);

pk_nap_summary_mm_b1_c2_b3 := map(pk_nap_summary = -1 => 0.0628683694,
                                  pk_nap_summary = 0  => 0.0533628914,
                                  pk_nap_summary = 1  => 0.0325253781,
                                                         0.0258943272);

pk_combo_fnamecount_mm_b1_c2_b3 := map(pk_combo_fnamecount = 0 => 0.0654827969,
                                       pk_combo_fnamecount = 1 => 0.0527563112,
                                       pk_combo_fnamecount = 2 => 0.032499698,
                                       pk_combo_fnamecount = 3 => 0.0213433773,
                                                                  0.0213980029);

pk_rc_fnamecount_mm_b1_c2_b3 := map(pk_rc_fnamecount = 0 => 0.0641153463,
                                    pk_rc_fnamecount = 1 => 0.0470539761,
                                    pk_rc_fnamecount = 2 => 0.0274390244,
                                                            0.0210526316);

pk_rc_phonelnamecount_mm_b1_c2_b3 := map(pk_rc_phonelnamecount = 0 => 0.0536002202,
                                                                      0.0292851717);

pk_rc_addrcount_mm_b1_c2_b3 := map(pk_rc_addrcount = 0 => 0.0545497762,
                                   pk_rc_addrcount = 1 => 0.0313562925,
                                   pk_rc_addrcount = 2 => 0.0147761843,
                                                          0.0122699387);

pk_rc_phonephonecount_mm_b1_c2_b3 := map(pk_rc_phonephonecount = 0 => 0.0525752638,
                                                                      0.0376263684);

pk_ver_phncount_mm_b1_c2_b3 := map(pk_ver_phncount = 0 => 0.0524498886,
                                   pk_ver_phncount = 1 => 0.0588631012,
                                   pk_ver_phncount = 2 => 0.0366163503,
                                                          0.0258943272);

pk_gong_did_phone_ct_mm_b1_c2_b3 := map(pk_gong_did_phone_ct = -1 => 0.0566300911,
                                        pk_gong_did_phone_ct = 0  => 0.0329807692,
                                        pk_gong_did_phone_ct = 1  => 0.028548124,
                                        pk_gong_did_phone_ct = 2  => 0.0237937872,
                                                                     0.0446927374);

pk_combo_ssncount_mm_b1_c2_b3 := map(pk_combo_ssncount = -1 => 0.1073825503,
                                     pk_combo_ssncount = 0  => 0.0454151546,
                                                               0.0185185185);

pk_combo_dobcount_mm_b1_c2_b3 := map(pk_combo_dobcount = 0 => 0.0746808724,
                                     pk_combo_dobcount = 1 => 0.0484024043,
                                     pk_combo_dobcount = 2 => 0.0410647957,
                                     pk_combo_dobcount = 3 => 0.024543379,
                                                              0.0211283956);

pk_eq_count_mm_b1_c2_b3 := map(pk_eq_count = 0 => 0.1177856302,
                               pk_eq_count = 1 => 0.0895097875,
                               pk_eq_count = 2 => 0.0523914412,
                               pk_eq_count = 3 => 0.0451459606,
                               pk_eq_count = 4 => 0.0331790123,
                               pk_eq_count = 5 => 0.0292823657,
                                                  0.0249307479);

pk_pos_secondary_sources_mm_b1_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.0461801596,
                                            pk_pos_secondary_sources = 1 => 0.0275590551,
                                                                            0.0105263158);

pk_voter_flag_mm_b1_c2_b3 := map(pk_voter_flag = -1 => 0.0635747273,
                                 pk_voter_flag = 0  => 0.0467625899,
                                                       0.0298618579);

pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0528011785,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.058283864,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0276343759,
                                                                                      0.0299205236);

pk_add2_pos_sources_mm_b1_c2_b3 := map(pk_add2_pos_sources = 0 => 0.0817657767,
                                       pk_add2_pos_sources = 1 => 0.0401962401,
                                       pk_add2_pos_sources = 2 => 0.0340651022,
                                       pk_add2_pos_sources = 3 => 0.0261044177,
                                                                  0.0189473684);

pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0455910604,
                                                                                    0.078369906);

pk_infutor_risk_lvl_mm_b1_c2_b3 := map(pk_infutor_risk_lvl = 0 => 0.0444172779,
                                       pk_infutor_risk_lvl = 1 => 0.0372199013,
                                                                  0.0673692912);

pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0486814778,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.037993921,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0225330225,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0282714055,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0315789474,
                                                                                       0.0540540541);

pk_yr_lname_change_date2_mm_b1_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.0460306487,
                                            pk_yr_lname_change_date2 = 0  => 0.0542110358,
                                            pk_yr_lname_change_date2 = 1  => 0.038869258,
                                                                             0.0302267003);

pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0579542599,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.0753998477,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0418006431,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0280172414,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0394800193,
                                                                                 0.0250946553);

pk_yr_header_first_seen2_mm_b1_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.0676133819,
                                            pk_yr_header_first_seen2 = 0  => 0.0546241211,
                                            pk_yr_header_first_seen2 = 1  => 0.0377086931,
                                            pk_yr_header_first_seen2 = 2  => 0.031556196,
                                            pk_yr_header_first_seen2 = 3  => 0.0204460967,
                                            pk_yr_header_first_seen2 = 4  => 0.0215544368,
                                            pk_yr_header_first_seen2 = 5  => 0.0199335548,
                                            pk_yr_header_first_seen2 = 6  => 0.0256410256,
                                                                             0.0268199234);

pk_yr_infutor_first_seen2_mm_b1_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.0444172779,
                                             pk_yr_infutor_first_seen2 = 0  => 0.048297315,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0470011534,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0515933232,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0538525269,
                                                                               0.0455259027);

pk_em_only_ver_lvl_mm_b1_c2_b3 := map(pk_em_only_ver_lvl = -1 => 0.0313075506,
                                      pk_em_only_ver_lvl = 0  => 0.0487689244,
                                      pk_em_only_ver_lvl = 1  => 0.0301905469,
                                      pk_em_only_ver_lvl = 2  => 0.0286677909,
                                                                 0.0238095238);

pk_add2_em_ver_lvl_mm_b1_c2_b3 := map(pk_add2_em_ver_lvl = -1 => 0.0050761421,
                                      pk_add2_em_ver_lvl = 0  => 0.0466315404,
                                      pk_add2_em_ver_lvl = 1  => 0.034428795,
                                                                 0.0320512821);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1388888889,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1786885246,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1303060217,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.0854853072,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.0681596884,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0727661851,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0629514964,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.052905464,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0371991247,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0464629552,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0349017009,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0334460729,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0338983051,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0317460317,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0338897319,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0183440754,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0196996294,
                                                                                      0.0153550864);

pk_nas_summary_mm_b1_c2_b4 := map(pk_nas_summary = 0 => 0.0687679083,
                                  pk_nas_summary = 1 => 0.0372807018,
                                                        0.0331848427);

pk_nap_summary_mm_b1_c2_b4 := map(pk_nap_summary = -1 => 0.0909090909,
                                  pk_nap_summary = 0  => 0.046203271,
                                  pk_nap_summary = 1  => 0.0248859394,
                                                         0.0165730722);

pk_combo_fnamecount_mm_b1_c2_b4 := map(pk_combo_fnamecount = 0 => 0.0547380156,
                                       pk_combo_fnamecount = 1 => 0.0376933621,
                                       pk_combo_fnamecount = 2 => 0.0241523456,
                                       pk_combo_fnamecount = 3 => 0.0194610778,
                                                                  0.0130955698);

pk_rc_fnamecount_mm_b1_c2_b4 := map(pk_rc_fnamecount = 0 => 0.0536677993,
                                    pk_rc_fnamecount = 1 => 0.0326969158,
                                    pk_rc_fnamecount = 2 => 0.0229034952,
                                                            0.015361836);

pk_rc_phonelnamecount_mm_b1_c2_b4 := map(pk_rc_phonelnamecount = 0 => 0.0473333333,
                                                                      0.0224430273);

pk_rc_addrcount_mm_b1_c2_b4 := map(pk_rc_addrcount = 0 => 0.0463044976,
                                   pk_rc_addrcount = 1 => 0.0206396588,
                                   pk_rc_addrcount = 2 => 0.0109946305,
                                                          0.0116731518);

pk_rc_phonephonecount_mm_b1_c2_b4 := map(pk_rc_phonephonecount = 0 => 0.0490188819,
                                                                      0.0246727523);

pk_ver_phncount_mm_b1_c2_b4 := map(pk_ver_phncount = 0 => 0.0491450114,
                                   pk_ver_phncount = 1 => 0.0461426668,
                                   pk_ver_phncount = 2 => 0.0267753201,
                                                          0.0165730722);

pk_gong_did_phone_ct_mm_b1_c2_b4 := map(pk_gong_did_phone_ct = -1 => 0.0407693724,
                                        pk_gong_did_phone_ct = 0  => 0.0213461538,
                                        pk_gong_did_phone_ct = 1  => 0.0266136433,
                                        pk_gong_did_phone_ct = 2  => 0.0282157676,
                                                                     0.0487804878);

pk_combo_ssncount_mm_b1_c2_b4 := map(pk_combo_ssncount = -1 => 0.076433121,
                                     pk_combo_ssncount = 0  => 0.0332746188,
                                                               0.024691358);

pk_combo_dobcount_mm_b1_c2_b4 := map(pk_combo_dobcount = 0 => 0.0768235484,
                                     pk_combo_dobcount = 1 => 0.0330912026,
                                     pk_combo_dobcount = 2 => 0.0273383926,
                                     pk_combo_dobcount = 3 => 0.0224593622,
                                                              0.0140056022);

pk_eq_count_mm_b1_c2_b4 := map(pk_eq_count = 0 => 0.0638497653,
                               pk_eq_count = 1 => 0.0651089525,
                               pk_eq_count = 2 => 0.0396475771,
                               pk_eq_count = 3 => 0.0302884615,
                               pk_eq_count = 4 => 0.0283607487,
                               pk_eq_count = 5 => 0.0193263833,
                                                  0.0176584063);

pk_pos_secondary_sources_mm_b1_c2_b4 := map(pk_pos_secondary_sources = 0 => 0.0339489934,
                                            pk_pos_secondary_sources = 1 => 0.0131004367,
                                                                            0.015503876);

pk_voter_flag_mm_b1_c2_b4 := map(pk_voter_flag = -1 => 0.0542280727,
                                 pk_voter_flag = 0  => 0.0324983074,
                                                       0.0243089009);

pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0452759975,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0502490478,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0201986755,
                                                                                      0.0228368877);

pk_add2_pos_sources_mm_b1_c2_b4 := map(pk_add2_pos_sources = 0 => 0.0559085133,
                                       pk_add2_pos_sources = 1 => 0.0262122025,
                                       pk_add2_pos_sources = 2 => 0.0255183413,
                                       pk_add2_pos_sources = 3 => 0.0234042553,
                                                                  0.0208333333);

pk_ssnchar_invalid_or_recent_mm_b1_c2_b4 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0335427479,
                                                                                    0.0588235294);

pk_infutor_risk_lvl_mm_b1_c2_b4 := map(pk_infutor_risk_lvl = 0 => 0.0290387796,
                                       pk_infutor_risk_lvl = 1 => 0.0432432432,
                                                                  0.0565356856);

pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0346962908,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0365659777,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0304506699,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0254545455,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0222321032,
                                                                                       0.0144927536);

pk_yr_lname_change_date2_mm_b1_c2_b4 := map(pk_yr_lname_change_date2 = -1 => 0.0339321357,
                                            pk_yr_lname_change_date2 = 0  => 0.0518987342,
                                            pk_yr_lname_change_date2 = 1  => 0.0226209048,
                                                                             0.0152801358);

pk_yr_gong_did_first_seen2_mm_b1_c2_b4 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0412246282,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.068119891,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0360824742,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0235183443,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0205155181,
                                                                                 0.0208405098);

pk_yr_header_first_seen2_mm_b1_c2_b4 := map(pk_yr_header_first_seen2 = -1 => 0.055499807,
                                            pk_yr_header_first_seen2 = 0  => 0.0571635311,
                                            pk_yr_header_first_seen2 = 1  => 0.0238543628,
                                            pk_yr_header_first_seen2 = 2  => 0.020783848,
                                            pk_yr_header_first_seen2 = 3  => 0.019478133,
                                            pk_yr_header_first_seen2 = 4  => 0.0181388992,
                                            pk_yr_header_first_seen2 = 5  => 0.0134615385,
                                            pk_yr_header_first_seen2 = 6  => 0.0124777184,
                                                                             0.0129240711);

pk_yr_infutor_first_seen2_mm_b1_c2_b4 := map(pk_yr_infutor_first_seen2 = -1 => 0.0290387796,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0503630827,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0413706644,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0462107209,
                                             pk_yr_infutor_first_seen2 = 3  => 0.03974122,
                                                                               0.0544412607);

pk_em_only_ver_lvl_mm_b1_c2_b4 := map(pk_em_only_ver_lvl = -1 => 0.0340314136,
                                      pk_em_only_ver_lvl = 0  => 0.0345723859,
                                      pk_em_only_ver_lvl = 1  => 0.0254205607,
                                      pk_em_only_ver_lvl = 2  => 0.0366699703,
                                                                 0.0178082192);

pk_add2_em_ver_lvl_mm_b1_c2_b4 := map(pk_add2_em_ver_lvl = -1 => 0.0412371134,
                                      pk_add2_em_ver_lvl = 0  => 0.0338839714,
                                      pk_add2_em_ver_lvl = 1  => 0.0309023486,
                                                                 0.0114613181);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.0952380952,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.157323689,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1198060942,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.0828667413,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.058968059,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0620555915,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0458190149,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0507166483,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0463576159,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0447662936,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0295566502,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0314123176,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0213170917,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0210575573,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0206533984,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.017633096,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.009824389,
                                                                                      0.010940919);

pk_nap_summary_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_nap_summary_mm_b1_c2_b1,
                            pk_segment_2 = '1 Owner ' => pk_nap_summary_mm_b1_c2_b2,
                            pk_segment_2 = '2 Renter' => pk_nap_summary_mm_b1_c2_b3,
                                                         pk_nap_summary_mm_b1_c2_b4);

pk_yr_gong_did_first_seen2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b1,
                                        pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b1_c2_b2,
                                        pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b1_c2_b3,
                                                                     pk_yr_gong_did_first_seen2_mm_b1_c2_b4);

pk_gong_did_phone_ct_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_gong_did_phone_ct_mm_b1_c2_b1,
                                  pk_segment_2 = '1 Owner ' => pk_gong_did_phone_ct_mm_b1_c2_b2,
                                  pk_segment_2 = '2 Renter' => pk_gong_did_phone_ct_mm_b1_c2_b3,
                                                               pk_gong_did_phone_ct_mm_b1_c2_b4);

pk_rc_addrcount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_rc_addrcount_mm_b1_c2_b1,
                             pk_segment_2 = '1 Owner ' => pk_rc_addrcount_mm_b1_c2_b2,
                             pk_segment_2 = '2 Renter' => pk_rc_addrcount_mm_b1_c2_b3,
                                                          pk_rc_addrcount_mm_b1_c2_b4);

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

pk_rc_phonelnamecount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_rc_phonelnamecount_mm_b1_c2_b1,
                                   pk_segment_2 = '1 Owner ' => pk_rc_phonelnamecount_mm_b1_c2_b2,
                                   pk_segment_2 = '2 Renter' => pk_rc_phonelnamecount_mm_b1_c2_b3,
                                                                pk_rc_phonelnamecount_mm_b1_c2_b4);

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

pk_combo_ssncount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_ssncount_mm_b1_c2_b1,
                               pk_segment_2 = '1 Owner ' => pk_combo_ssncount_mm_b1_c2_b2,
                               pk_segment_2 = '2 Renter' => pk_combo_ssncount_mm_b1_c2_b3,
                                                            pk_combo_ssncount_mm_b1_c2_b4);

pk_combo_fnamecount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_fnamecount_mm_b1_c2_b1,
                                 pk_segment_2 = '1 Owner ' => pk_combo_fnamecount_mm_b1_c2_b2,
                                 pk_segment_2 = '2 Renter' => pk_combo_fnamecount_mm_b1_c2_b3,
                                                              pk_combo_fnamecount_mm_b1_c2_b4);

pk_pos_secondary_sources_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b1_c2_b1,
                                      pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b1_c2_b2,
                                      pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b1_c2_b3,
                                                                   pk_pos_secondary_sources_mm_b1_c2_b4);

pk_rc_phonephonecount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_rc_phonephonecount_mm_b1_c2_b1,
                                   pk_segment_2 = '1 Owner ' => pk_rc_phonephonecount_mm_b1_c2_b2,
                                   pk_segment_2 = '2 Renter' => pk_rc_phonephonecount_mm_b1_c2_b3,
                                                                pk_rc_phonephonecount_mm_b1_c2_b4);

pk_voter_flag_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b1_c2_b1,
                           pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b1_c2_b2,
                           pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b1_c2_b3,
                                                        pk_voter_flag_mm_b1_c2_b4);

pk_rc_fnamecount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_rc_fnamecount_mm_b1_c2_b1,
                              pk_segment_2 = '1 Owner ' => pk_rc_fnamecount_mm_b1_c2_b2,
                              pk_segment_2 = '2 Renter' => pk_rc_fnamecount_mm_b1_c2_b3,
                                                           pk_rc_fnamecount_mm_b1_c2_b4);

pk_add2_pos_sources_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b1_c2_b1,
                                 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b1_c2_b2,
                                 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b1_c2_b3,
                                                              pk_add2_pos_sources_mm_b1_c2_b4);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1,
                                       pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2,
                                       pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3,
                                                                    pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4);

pk_infutor_risk_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_infutor_risk_lvl_mm_b1_c2_b1,
                                 pk_segment_2 = '1 Owner ' => pk_infutor_risk_lvl_mm_b1_c2_b2,
                                 pk_segment_2 = '2 Renter' => pk_infutor_risk_lvl_mm_b1_c2_b3,
                                                              pk_infutor_risk_lvl_mm_b1_c2_b4);

pk_lname_eda_sourced_type_lvl_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1,
                                           pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2,
                                           pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3,
                                                                        pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4);

pk_ver_phncount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_ver_phncount_mm_b1_c2_b1,
                             pk_segment_2 = '1 Owner ' => pk_ver_phncount_mm_b1_c2_b2,
                             pk_segment_2 = '2 Renter' => pk_ver_phncount_mm_b1_c2_b3,
                                                          pk_ver_phncount_mm_b1_c2_b4);

pk_combo_dobcount_mm_b1 := map(pk_segment_2 = '0 Derog ' => pk_combo_dobcount_mm_b1_c2_b1,
                               pk_segment_2 = '1 Owner ' => pk_combo_dobcount_mm_b1_c2_b2,
                               pk_segment_2 = '2 Renter' => pk_combo_dobcount_mm_b1_c2_b3,
                                                            pk_combo_dobcount_mm_b1_c2_b4);

pk_nas_summary_mm_b2_c2_b1 := map(pk_nas_summary = 0 => 0.1031746032,
                                  pk_nas_summary = 1 => 0.1061263869,
                                                        0.0533614183);

pk_nap_summary_mm_b2_c2_b1 := map(pk_nap_summary = -1 => 0.103626943,
                                  pk_nap_summary = 0  => 0.0826429163,
                                  pk_nap_summary = 1  => 0.0464632455,
                                                         0.035589672);

pk_combo_fnamecount_nb_mm_b2_c2_b1 := map(pk_combo_fnamecount_nb = 0 => 0.1784232365,
                                          pk_combo_fnamecount_nb = 1 => 0.1280101394,
                                          pk_combo_fnamecount_nb = 2 => 0.0765100671,
                                          pk_combo_fnamecount_nb = 3 => 0.0626748741,
                                          pk_combo_fnamecount_nb = 4 => 0.0528683915,
                                          pk_combo_fnamecount_nb = 5 => 0.0405643739,
                                                                        0.0398818316);

pk_rc_lnamecount_nb_mm_b2_c2_b1 := map(pk_rc_lnamecount_nb = 0 => 0.1103896104,
                                       pk_rc_lnamecount_nb = 1 => 0.1080074488,
                                       pk_rc_lnamecount_nb = 2 => 0.0780487805,
                                       pk_rc_lnamecount_nb = 3 => 0.0552380952,
                                       pk_rc_lnamecount_nb = 4 => 0.0461016949,
                                       pk_rc_lnamecount_nb = 5 => 0.047976012,
                                                                  0.0366300366);

pk_rc_phonelnamecount_mm_b2_c2_b1 := map(pk_rc_phonelnamecount = 0 => 0.0830031283,
                                                                      0.0448242502);

pk_rc_addrcount_nb_mm_b2_c2_b1 := map(pk_rc_addrcount_nb = 0 => 0.1069444444,
                                      pk_rc_addrcount_nb = 1 => 0.0551776266,
                                                                0.0315315315);

pk_rc_phonephonecount_mm_b2_c2_b1 := map(pk_rc_phonephonecount = 0 => 0.0825759543,
                                                                      0.0541409147);

pk_ver_phncount_mm_b2_c2_b1 := map(pk_ver_phncount = 0 => 0.0906497623,
                                   pk_ver_phncount = 1 => 0.0701899257,
                                   pk_ver_phncount = 2 => 0.054840248,
                                                          0.035589672);

pk_gong_did_phone_ct_nb_mm_b2_c2_b1 := map(pk_gong_did_phone_ct_nb = -2 => 0.0817307692,
                                           pk_gong_did_phone_ct_nb = -1 => 0.0605943651,
                                           pk_gong_did_phone_ct_nb = 0  => 0.0555978675,
                                           pk_gong_did_phone_ct_nb = 1  => 0.0589285714,
                                                                           0.0608974359);

pk_combo_ssncount_mm_b2_c2_b1 := map(pk_combo_ssncount = -1 => 0.1,
                                     pk_combo_ssncount = 0  => 0.0733101899,
                                                               0.0580955655);

pk_combo_dobcount_nb_mm_b2_c2_b1 := map(pk_combo_dobcount_nb = 0 => 0.146,
                                        pk_combo_dobcount_nb = 1 => 0.0939597315,
                                        pk_combo_dobcount_nb = 2 => 0.0910138249,
                                        pk_combo_dobcount_nb = 3 => 0.0721975934,
                                        pk_combo_dobcount_nb = 4 => 0.0556889102,
                                        pk_combo_dobcount_nb = 5 => 0.0485636115,
                                        pk_combo_dobcount_nb = 6 => 0.0490620491,
                                                                    0.0303030303);

pk_eq_count_mm_b2_c2_b1 := map(pk_eq_count = 0 => 0.2280701754,
                               pk_eq_count = 1 => 0.1758241758,
                               pk_eq_count = 2 => 0.1075514874,
                               pk_eq_count = 3 => 0.0905797101,
                               pk_eq_count = 4 => 0.0794520548,
                               pk_eq_count = 5 => 0.0635971223,
                                                  0.0547680412);

pk_pos_secondary_sources_mm_b2_c2_b1 := map(pk_pos_secondary_sources = 0 => 0.06910516,
                                            pk_pos_secondary_sources = 1 => 0.0744680851,
                                                                            0.0068027211);

pk_voter_flag_mm_b2_c2_b1 := map(pk_voter_flag = -1 => 0.0911877395,
                                 pk_voter_flag = 0  => 0.0703842231,
                                                       0.0578082192);

pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.089446414,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0620567376,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0441537204,
                                                                                      0.0452609159);

pk_add2_pos_sources_mm_b2_c2_b1 := map(pk_add2_pos_sources = 0 => 0.0528414756,
                                       pk_add2_pos_sources = 1 => 0.0783369803,
                                       pk_add2_pos_sources = 2 => 0.0805152979,
                                       pk_add2_pos_sources = 3 => 0.046875,
                                                                  0.0379146919);

pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0678996706,
                                                                                    0.5);

pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := map(pk_infutor_risk_lvl_nb = 0 => 0.0554493308,
                                          pk_infutor_risk_lvl_nb = 1 => 0.0637025967,
                                          pk_infutor_risk_lvl_nb = 2 => 0.0756234916,
                                                                        0.093951094);

pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0706675024,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0733333333,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0703703704,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0445103858,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0536451169,
                                                                                       0.0666666667);

pk_yr_lname_change_date2_mm_b2_c2_b1 := map(pk_yr_lname_change_date2 = -1 => 0.0678218492,
                                            pk_yr_lname_change_date2 = 0  => 0.0666666667,
                                            pk_yr_lname_change_date2 = 1  => 0.084,
                                                                             0.0483870968);

pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0901738779,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.1166666667,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0695970696,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0960451977,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0637583893,
                                                                                 0.0492424242);

pk_yr_header_first_seen2_mm_b2_c2_b1 := map(pk_yr_header_first_seen2 = -1 => 0.192,
                                            pk_yr_header_first_seen2 = 0  => 0.1865671642,
                                            pk_yr_header_first_seen2 = 1  => 0.1095890411,
                                            pk_yr_header_first_seen2 = 2  => 0.0969827586,
                                            pk_yr_header_first_seen2 = 3  => 0.0843373494,
                                            pk_yr_header_first_seen2 = 4  => 0.063293538,
                                            pk_yr_header_first_seen2 = 5  => 0.0338164251,
                                            pk_yr_header_first_seen2 = 6  => 0.0284237726,
                                                                             0.0315789474);

pk_yr_infutor_first_seen2_mm_b2_c2_b1 := map(pk_yr_infutor_first_seen2 = -1 => 0.0636906985,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0810359231,
                                             pk_yr_infutor_first_seen2 = 1  => 0.078101072,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0827338129,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0592592593,
                                                                               0.0625);

pk_em_only_ver_lvl_mm_b2_c2_b1 := map(pk_em_only_ver_lvl = -1 => 0.0909090909,
                                      pk_em_only_ver_lvl = 0  => 0.0703137317,
                                      pk_em_only_ver_lvl = 1  => 0.059602649,
                                      pk_em_only_ver_lvl = 2  => 0.038647343,
                                                                 0.0558659218);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.1904761905,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.6666666667,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.4705882353,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.6428571429,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1818181818,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.2307692308,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.2413793103,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.1428571429,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.1470588235,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.1057692308,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.1165413534,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0916271722,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0864779874,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0665557404,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0728793309,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0603889458,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0471669219,
                                                                                      0.0445682451);

pk_nas_summary_mm_b2_c2_b2 := map(pk_nas_summary = 0 => 0.0344332855,
                                  pk_nas_summary = 1 => 0.0422852002,
                                                        0.0177930221);

pk_nap_summary_mm_b2_c2_b2 := map(pk_nap_summary = -1 => 0.0223463687,
                                  pk_nap_summary = 0  => 0.0299958106,
                                  pk_nap_summary = 1  => 0.0198803659,
                                                         0.0111587983);

pk_combo_fnamecount_nb_mm_b2_c2_b2 := map(pk_combo_fnamecount_nb = 0 => 0.0366972477,
                                          pk_combo_fnamecount_nb = 1 => 0.0326025857,
                                          pk_combo_fnamecount_nb = 2 => 0.0260093168,
                                          pk_combo_fnamecount_nb = 3 => 0.0220622751,
                                          pk_combo_fnamecount_nb = 4 => 0.0176914779,
                                          pk_combo_fnamecount_nb = 5 => 0.0133763838,
                                                                        0.0097465887);

pk_rc_lnamecount_nb_mm_b2_c2_b2 := map(pk_rc_lnamecount_nb = 0 => 0.0334190231,
                                       pk_rc_lnamecount_nb = 1 => 0.0297579392,
                                       pk_rc_lnamecount_nb = 2 => 0.0242686606,
                                       pk_rc_lnamecount_nb = 3 => 0.0190852254,
                                       pk_rc_lnamecount_nb = 4 => 0.0179328334,
                                       pk_rc_lnamecount_nb = 5 => 0.013712047,
                                                                  0.0029154519);

pk_rc_phonelnamecount_mm_b2_c2_b2 := map(pk_rc_phonelnamecount = 0 => 0.0299641828,
                                                                      0.0162687171);

pk_rc_addrcount_nb_mm_b2_c2_b2 := map(pk_rc_addrcount_nb = 0 => 0.0413385827,
                                      pk_rc_addrcount_nb = 1 => 0.0188601403,
                                                                0.007977208);

pk_rc_phonephonecount_mm_b2_c2_b2 := map(pk_rc_phonephonecount = 0 => 0.0311321771,
                                                                      0.0175631931);

pk_ver_phncount_mm_b2_c2_b2 := map(pk_ver_phncount = 0 => 0.0325588067,
                                   pk_ver_phncount = 1 => 0.0281051677,
                                   pk_ver_phncount = 2 => 0.0206600832,
                                                          0.0111587983);

pk_gong_did_phone_ct_nb_mm_b2_c2_b2 := map(pk_gong_did_phone_ct_nb = -2 => 0.0263309187,
                                           pk_gong_did_phone_ct_nb = -1 => 0.0208461823,
                                           pk_gong_did_phone_ct_nb = 0  => 0.0210122006,
                                           pk_gong_did_phone_ct_nb = 1  => 0.0225787285,
                                                                           0.0168728909);

pk_combo_ssncount_mm_b2_c2_b2 := map(pk_combo_ssncount = -1 => 0.0352422907,
                                     pk_combo_ssncount = 0  => 0.0225803634,
                                                               0.0133333333);

pk_combo_dobcount_nb_mm_b2_c2_b2 := map(pk_combo_dobcount_nb = 0 => 0.0439828955,
                                        pk_combo_dobcount_nb = 1 => 0.0305480683,
                                        pk_combo_dobcount_nb = 2 => 0.0245,
                                        pk_combo_dobcount_nb = 3 => 0.0223006351,
                                        pk_combo_dobcount_nb = 4 => 0.0200386711,
                                        pk_combo_dobcount_nb = 5 => 0.0175557056,
                                        pk_combo_dobcount_nb = 6 => 0.0139720559,
                                                                    0.0063694268);

pk_eq_count_mm_b2_c2_b2 := map(pk_eq_count = 0 => 0.0328358209,
                               pk_eq_count = 1 => 0.0336538462,
                               pk_eq_count = 2 => 0.0267624021,
                               pk_eq_count = 3 => 0.0260190807,
                               pk_eq_count = 4 => 0.0175953079,
                               pk_eq_count = 5 => 0.0216092762,
                                                  0.022614841);

pk_pos_secondary_sources_mm_b2_c2_b2 := map(pk_pos_secondary_sources = 0 => 0.0230608877,
                                            pk_pos_secondary_sources = 1 => 0.0201149425,
                                                                            0.0140186916);

pk_voter_flag_mm_b2_c2_b2 := map(pk_voter_flag = -1 => 0.0288377512,
                                 pk_voter_flag = 0  => 0.0237276479,
                                                       0.0204379562);

pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0314341847,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0263396912,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0236040609,
                                                                                      0.0128342246);

pk_add2_pos_sources_mm_b2_c2_b2 := map(pk_add2_pos_sources = 0 => 0.0134414338,
                                       pk_add2_pos_sources = 1 => 0.0264505836,
                                       pk_add2_pos_sources = 2 => 0.0296254891,
                                       pk_add2_pos_sources = 3 => 0.0232673267,
                                                                  0.0137981118);

pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0228725193,
                                                                                    0);

pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := map(pk_infutor_risk_lvl_nb = 0 => 0.017976032,
                                          pk_infutor_risk_lvl_nb = 1 => 0.020739457,
                                          pk_infutor_risk_lvl_nb = 2 => 0.0308219178,
                                                                        0.0331833521);

pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0234096692,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0244498778,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0102941176,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.026993865,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0208728653,
                                                                                       0.0071428571);

pk_yr_lname_change_date2_mm_b2_c2_b2 := map(pk_yr_lname_change_date2 = -1 => 0.0228858374,
                                            pk_yr_lname_change_date2 = 0  => 0.0272108844,
                                            pk_yr_lname_change_date2 = 1  => 0.0257966616,
                                                                             0.0115606936);

pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0269465132,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.0294985251,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.023364486,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0270906949,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.025,
                                                                                 0.019440874);

pk_yr_header_first_seen2_mm_b2_c2_b2 := map(pk_yr_header_first_seen2 = -1 => 0.0367835757,
                                            pk_yr_header_first_seen2 = 0  => 0.0476190476,
                                            pk_yr_header_first_seen2 = 1  => 0.0359281437,
                                            pk_yr_header_first_seen2 = 2  => 0.0292134831,
                                            pk_yr_header_first_seen2 = 3  => 0.0250156348,
                                            pk_yr_header_first_seen2 = 4  => 0.0206216831,
                                            pk_yr_header_first_seen2 = 5  => 0.0133124511,
                                            pk_yr_header_first_seen2 = 6  => 0.014619883,
                                                                             0.0188383046);

pk_yr_infutor_first_seen2_mm_b2_c2_b2 := map(pk_yr_infutor_first_seen2 = -1 => 0.020739457,
                                             pk_yr_infutor_first_seen2 = 0  => 0.026934879,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0364794441,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0253164557,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0201149425,
                                                                               0.0258823529);

pk_em_only_ver_lvl_mm_b2_c2_b2 := map(pk_em_only_ver_lvl = -1 => 0.0292275574,
                                      pk_em_only_ver_lvl = 0  => 0.0233307751,
                                      pk_em_only_ver_lvl = 1  => 0.0227649007,
                                      pk_em_only_ver_lvl = 2  => 0.0204678363,
                                                                 0.0073746313);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.0304878049,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.0909090909,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.1379310345,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.0909090909,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0948275862,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.1,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0338983051,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0380952381,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0451612903,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0436835891,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.033682294,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0302291565,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0225013082,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0235602094,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0183982684,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0152766776,
                                                                                      0.0137614679);

pk_nas_summary_mm_b2_c2_b3 := map(pk_nas_summary = 0 => 0.0921169176,
                                  pk_nas_summary = 1 => 0.091456077,
                                                        0.0497640498);

pk_nap_summary_mm_b2_c2_b3 := map(pk_nap_summary = -1 => 0.1042345277,
                                  pk_nap_summary = 0  => 0.0764236296,
                                  pk_nap_summary = 1  => 0.0686184812,
                                                         0.0528905289);

pk_combo_fnamecount_nb_mm_b2_c2_b3 := map(pk_combo_fnamecount_nb = 0 => 0.0992741747,
                                          pk_combo_fnamecount_nb = 1 => 0.0797034291,
                                          pk_combo_fnamecount_nb = 2 => 0.0532200358,
                                          pk_combo_fnamecount_nb = 3 => 0.0382059801,
                                          pk_combo_fnamecount_nb = 4 => 0.0394190871,
                                          pk_combo_fnamecount_nb = 5 => 0.0144927536,
                                                                        0);

pk_rc_lnamecount_nb_mm_b2_c2_b3 := map(pk_rc_lnamecount_nb = 0 => 0.0972657065,
                                       pk_rc_lnamecount_nb = 1 => 0.0755964358,
                                       pk_rc_lnamecount_nb = 2 => 0.0463892874,
                                       pk_rc_lnamecount_nb = 3 => 0.0368763557,
                                       pk_rc_lnamecount_nb = 4 => 0.032,
                                       pk_rc_lnamecount_nb = 5 => 0,
                                                                  0);

pk_rc_phonelnamecount_mm_b2_c2_b3 := map(pk_rc_phonelnamecount = 0 => 0.0774617997,
                                                                      0.0631868132);

pk_rc_addrcount_nb_mm_b2_c2_b3 := map(pk_rc_addrcount_nb = 0 => 0.0918204271,
                                      pk_rc_addrcount_nb = 1 => 0.0501493811,
                                                                0.0256410256);

pk_rc_phonephonecount_mm_b2_c2_b3 := map(pk_rc_phonephonecount = 0 => 0.0739003676,
                                                                      0.0766335036);

pk_ver_phncount_mm_b2_c2_b3 := map(pk_ver_phncount = 0 => 0.0754390633,
                                   pk_ver_phncount = 1 => 0.0906095552,
                                   pk_ver_phncount = 2 => 0.0637860082,
                                                          0.0528905289);

pk_gong_did_phone_ct_nb_mm_b2_c2_b3 := map(pk_gong_did_phone_ct_nb = -2 => 0.0862792903,
                                           pk_gong_did_phone_ct_nb = -1 => 0.0532879819,
                                           pk_gong_did_phone_ct_nb = 0  => 0.0581395349,
                                           pk_gong_did_phone_ct_nb = 1  => 0.0526315789,
                                                                           0.0585365854);

pk_combo_ssncount_mm_b2_c2_b3 := map(pk_combo_ssncount = -1 => 0.0921919097,
                                     pk_combo_ssncount = 0  => 0.0731521946,
                                                               0);

pk_combo_dobcount_nb_mm_b2_c2_b3 := map(pk_combo_dobcount_nb = 0 => 0.1055687516,
                                        pk_combo_dobcount_nb = 1 => 0.0777967064,
                                        pk_combo_dobcount_nb = 2 => 0.0738738739,
                                        pk_combo_dobcount_nb = 3 => 0.0443890274,
                                        pk_combo_dobcount_nb = 4 => 0.0324324324,
                                        pk_combo_dobcount_nb = 5 => 0.0181818182,
                                        pk_combo_dobcount_nb = 6 => 0.0322580645,
                                                                    0);

pk_eq_count_mm_b2_c2_b3 := map(pk_eq_count = 0 => 0.1061728395,
                               pk_eq_count = 1 => 0.1190354028,
                               pk_eq_count = 2 => 0.0896471949,
                               pk_eq_count = 3 => 0.0626598465,
                               pk_eq_count = 4 => 0.0837438424,
                               pk_eq_count = 5 => 0.0443871707,
                                                  0.0378416258);

pk_pos_secondary_sources_mm_b2_c2_b3 := map(pk_pos_secondary_sources = 0 => 0.0753597907,
                                            pk_pos_secondary_sources = 1 => 0.0392156863,
                                                                            0);

pk_voter_flag_mm_b2_c2_b3 := map(pk_voter_flag = -1 => 0.0966469428,
                                 pk_voter_flag = 0  => 0.0761687571,
                                                       0.0519869352);

pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0786266698,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0662921348,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0550639135,
                                                                                      0.0702656384);

pk_add2_pos_sources_mm_b2_c2_b3 := map(pk_add2_pos_sources = 0 => 0.0772698004,
                                       pk_add2_pos_sources = 1 => 0.0803733472,
                                       pk_add2_pos_sources = 2 => 0.058413252,
                                       pk_add2_pos_sources = 3 => 0.0480167015,
                                                                  0.063559322);

pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0749825419,
                                                                                    0.0592105263);

pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := map(pk_infutor_risk_lvl_nb = 0 => 0.053164557,
                                          pk_infutor_risk_lvl_nb = 1 => 0.0737191772,
                                          pk_infutor_risk_lvl_nb = 2 => 0.0682897862,
                                                                        0.0910693302);

pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0781077001,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0566037736,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.050295858,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0554156171,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0557880056,
                                                                                       0.1111111111);

pk_yr_lname_change_date2_mm_b2_c2_b3 := map(pk_yr_lname_change_date2 = -1 => 0.0747110747,
                                            pk_yr_lname_change_date2 = 0  => 0.1121495327,
                                            pk_yr_lname_change_date2 = 1  => 0.0633333333,
                                                                             0.0380952381);

pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0872627947,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.128440367,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0690690691,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0715990453,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0560420315,
                                                                                 0.0414794331);

pk_yr_header_first_seen2_mm_b2_c2_b3 := map(pk_yr_header_first_seen2 = -1 => 0.1014309002,
                                            pk_yr_header_first_seen2 = 0  => 0.0879120879,
                                            pk_yr_header_first_seen2 = 1  => 0.057050592,
                                            pk_yr_header_first_seen2 = 2  => 0.0554675119,
                                            pk_yr_header_first_seen2 = 3  => 0.0368589744,
                                            pk_yr_header_first_seen2 = 4  => 0.0376952073,
                                            pk_yr_header_first_seen2 = 5  => 0.0526315789,
                                            pk_yr_header_first_seen2 = 6  => 0.0444444444,
                                                                             0.0138888889);

pk_yr_infutor_first_seen2_mm_b2_c2_b3 := map(pk_yr_infutor_first_seen2 = -1 => 0.0737191772,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0863079382,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0710659898,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0837004405,
                                             pk_yr_infutor_first_seen2 = 3  => 0.054313099,
                                                                               0.0263157895);

pk_em_only_ver_lvl_mm_b2_c2_b3 := map(pk_em_only_ver_lvl = -1 => 0.04,
                                      pk_em_only_ver_lvl = 0  => 0.0781755663,
                                      pk_em_only_ver_lvl = 1  => 0.0553691275,
                                      pk_em_only_ver_lvl = 2  => 0.0543478261,
                                                                 0.0710059172);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.0953412784,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.2079207921,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1928783383,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.1355932203,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1522988506,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.11816839,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.089456869,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0651906519,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0820189274,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0470262794,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0552099533,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0517473118,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0744680851,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.0452830189,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0503018109,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.0351648352,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0298146656,
                                                                                      0.0086206897);

pk_nas_summary_mm_b2_c2_b4 := map(pk_nas_summary = 0 => 0.0944206009,
                                  pk_nas_summary = 1 => 0.0749154181,
                                                        0.0331791354);

pk_nap_summary_mm_b2_c2_b4 := map(pk_nap_summary = -1 => 0.0503597122,
                                  pk_nap_summary = 0  => 0.0652423286,
                                  pk_nap_summary = 1  => 0.0355245684,
                                                         0.0279069767);

pk_combo_fnamecount_nb_mm_b2_c2_b4 := map(pk_combo_fnamecount_nb = 0 => 0.0732064422,
                                          pk_combo_fnamecount_nb = 1 => 0.0634809906,
                                          pk_combo_fnamecount_nb = 2 => 0.0352026197,
                                          pk_combo_fnamecount_nb = 3 => 0.0416124837,
                                          pk_combo_fnamecount_nb = 4 => 0.0238429173,
                                          pk_combo_fnamecount_nb = 5 => 0.0183150183,
                                                                        0.0222222222);

pk_rc_lnamecount_nb_mm_b2_c2_b4 := map(pk_rc_lnamecount_nb = 0 => 0.0700795229,
                                       pk_rc_lnamecount_nb = 1 => 0.0512674452,
                                       pk_rc_lnamecount_nb = 2 => 0.0384955752,
                                       pk_rc_lnamecount_nb = 3 => 0.0419384902,
                                       pk_rc_lnamecount_nb = 4 => 0.0280112045,
                                       pk_rc_lnamecount_nb = 5 => 0.024691358,
                                                                  0);

pk_rc_phonelnamecount_mm_b2_c2_b4 := map(pk_rc_phonelnamecount = 0 => 0.0663804998,
                                                                      0.0359219269);

pk_rc_addrcount_nb_mm_b2_c2_b4 := map(pk_rc_addrcount_nb = 0 => 0.0794608731,
                                      pk_rc_addrcount_nb = 1 => 0.0335677749,
                                                                0.0089285714);

pk_rc_phonephonecount_mm_b2_c2_b4 := map(pk_rc_phonephonecount = 0 => 0.0684002261,
                                                                      0.0402851459);

pk_ver_phncount_mm_b2_c2_b4 := map(pk_ver_phncount = 0 => 0.0677885755,
                                   pk_ver_phncount = 1 => 0.0603927381,
                                   pk_ver_phncount = 2 => 0.0379557681,
                                                          0.0279069767);

pk_gong_did_phone_ct_nb_mm_b2_c2_b4 := map(pk_gong_did_phone_ct_nb = -2 => 0.0628797084,
                                           pk_gong_did_phone_ct_nb = -1 => 0.037555697,
                                           pk_gong_did_phone_ct_nb = 0  => 0.0450132392,
                                           pk_gong_did_phone_ct_nb = 1  => 0.0457317073,
                                                                           0.0526315789);

pk_combo_ssncount_mm_b2_c2_b4 := map(pk_combo_ssncount = -1 => 0.095890411,
                                     pk_combo_ssncount = 0  => 0.0500575374,
                                                               0);

pk_combo_dobcount_nb_mm_b2_c2_b4 := map(pk_combo_dobcount_nb = 0 => 0.0971236459,
                                        pk_combo_dobcount_nb = 1 => 0.0510948905,
                                        pk_combo_dobcount_nb = 2 => 0.0423116615,
                                        pk_combo_dobcount_nb = 3 => 0.0336730173,
                                        pk_combo_dobcount_nb = 4 => 0.0364900087,
                                        pk_combo_dobcount_nb = 5 => 0.0281690141,
                                        pk_combo_dobcount_nb = 6 => 0.0192307692,
                                                                    0);

pk_eq_count_mm_b2_c2_b4 := map(pk_eq_count = 0 => 0.1023550725,
                               pk_eq_count = 1 => 0.0973888497,
                               pk_eq_count = 2 => 0.0715206186,
                               pk_eq_count = 3 => 0.0370898716,
                               pk_eq_count = 4 => 0.042662116,
                               pk_eq_count = 5 => 0.0356506239,
                                                  0.02582846);

pk_pos_secondary_sources_mm_b2_c2_b4 := map(pk_pos_secondary_sources = 0 => 0.0536164088,
                                            pk_pos_secondary_sources = 1 => 0.0583333333,
                                                                            0.0291262136);

pk_voter_flag_mm_b2_c2_b4 := map(pk_voter_flag = -1 => 0.0759641605,
                                 pk_voter_flag = 0  => 0.0515274949,
                                                       0.0409114448);

pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4 := map(pk_lname_eda_sourced_type_lvl = 0 => 0.0665577787,
                                                 pk_lname_eda_sourced_type_lvl = 1 => 0.0658461538,
                                                 pk_lname_eda_sourced_type_lvl = 2 => 0.0289541919,
                                                                                      0.0423661071);

pk_add2_pos_sources_mm_b2_c2_b4 := map(pk_add2_pos_sources = 0 => 0.0604460094,
                                       pk_add2_pos_sources = 1 => 0.0573675015,
                                       pk_add2_pos_sources = 2 => 0.0481927711,
                                       pk_add2_pos_sources = 3 => 0.0351008215,
                                                                  0.0286532951);

pk_ssnchar_invalid_or_recent_mm_b2_c2_b4 := map(pk_ssnchar_invalid_or_recent = 0 => 0.0532623169,
                                                                                    0.0810810811);

pk_infutor_risk_lvl_nb_mm_b2_c2_b4 := map(pk_infutor_risk_lvl_nb = 0 => 0.0388349515,
                                          pk_infutor_risk_lvl_nb = 1 => 0.0481589856,
                                          pk_infutor_risk_lvl_nb = 2 => 0.057912844,
                                                                        0.0904059041);

pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4 := map(pk_yr_adl_em_only_first_seen2 = -1 => 0.0553367876,
                                                 pk_yr_adl_em_only_first_seen2 = 0  => 0.0666666667,
                                                 pk_yr_adl_em_only_first_seen2 = 1  => 0.0519877676,
                                                 pk_yr_adl_em_only_first_seen2 = 2  => 0.0436046512,
                                                 pk_yr_adl_em_only_first_seen2 = 3  => 0.0345679012,
                                                                                       0);

pk_yr_lname_change_date2_mm_b2_c2_b4 := map(pk_yr_lname_change_date2 = -1 => 0.0539517274,
                                            pk_yr_lname_change_date2 = 0  => 0.0575221239,
                                            pk_yr_lname_change_date2 = 1  => 0.0409836066,
                                                                             0.043956044);

pk_yr_gong_did_first_seen2_mm_b2_c2_b4 := map(pk_yr_gong_did_first_seen2 = -1 => 0.0646606914,
                                              pk_yr_gong_did_first_seen2 = 0  => 0.0926517572,
                                              pk_yr_gong_did_first_seen2 = 1  => 0.0647482014,
                                              pk_yr_gong_did_first_seen2 = 2  => 0.0427135678,
                                              pk_yr_gong_did_first_seen2 = 3  => 0.0336749634,
                                                                                 0.033635566);

pk_yr_header_first_seen2_mm_b2_c2_b4 := map(pk_yr_header_first_seen2 = -1 => 0.0775862069,
                                            pk_yr_header_first_seen2 = 0  => 0.1014150943,
                                            pk_yr_header_first_seen2 = 1  => 0.0453074434,
                                            pk_yr_header_first_seen2 = 2  => 0.0393818544,
                                            pk_yr_header_first_seen2 = 3  => 0.0288713911,
                                            pk_yr_header_first_seen2 = 4  => 0.0307823856,
                                            pk_yr_header_first_seen2 = 5  => 0.013986014,
                                            pk_yr_header_first_seen2 = 6  => 0.0119047619,
                                                                             0.012345679);

pk_yr_infutor_first_seen2_mm_b2_c2_b4 := map(pk_yr_infutor_first_seen2 = -1 => 0.0481589856,
                                             pk_yr_infutor_first_seen2 = 0  => 0.0768203073,
                                             pk_yr_infutor_first_seen2 = 1  => 0.0641361257,
                                             pk_yr_infutor_first_seen2 = 2  => 0.0714285714,
                                             pk_yr_infutor_first_seen2 = 3  => 0.0415430267,
                                                                               0.0423280423);

pk_em_only_ver_lvl_mm_b2_c2_b4 := map(pk_em_only_ver_lvl = -1 => 0.0820895522,
                                      pk_em_only_ver_lvl = 0  => 0.0557068063,
                                      pk_em_only_ver_lvl = 1  => 0.0352941176,
                                      pk_em_only_ver_lvl = 2  => 0.0450819672,
                                                                 0.0424836601);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := map(pk_yrmo_adl_first_seen_max_fcra2 = -1 => 0.0971128609,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 0  => 0.1428571429,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 1  => 0.1905940594,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 2  => 0.112033195,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 3  => 0.1333333333,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 4  => 0.0725274725,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 5  => 0.0519480519,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 6  => 0.0814393939,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 7  => 0.0628272251,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 8  => 0.0628571429,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 9  => 0.0422680412,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 10 => 0.0444785276,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 11 => 0.0399484536,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 12 => 0.038897893,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 13 => 0.0327868852,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 14 => 0.022249691,
                                             pk_yrmo_adl_first_seen_max_fcra2 = 15 => 0.0224867725,
                                                                                      0.0238095238);

pk_nap_summary_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_nap_summary_mm_b2_c2_b1,
                            pk_segment_2 = '1 Owner ' => pk_nap_summary_mm_b2_c2_b2,
                            pk_segment_2 = '2 Renter' => pk_nap_summary_mm_b2_c2_b3,
                                                         pk_nap_summary_mm_b2_c2_b4);

pk_yr_gong_did_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b1,
                                        pk_segment_2 = '1 Owner ' => pk_yr_gong_did_first_seen2_mm_b2_c2_b2,
                                        pk_segment_2 = '2 Renter' => pk_yr_gong_did_first_seen2_mm_b2_c2_b3,
                                                                     pk_yr_gong_did_first_seen2_mm_b2_c2_b4);

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

pk_gong_did_phone_ct_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_gong_did_phone_ct_nb_mm_b2_c2_b1,
                                     pk_segment_2 = '1 Owner ' => pk_gong_did_phone_ct_nb_mm_b2_c2_b2,
                                     pk_segment_2 = '2 Renter' => pk_gong_did_phone_ct_nb_mm_b2_c2_b3,
                                                                  pk_gong_did_phone_ct_nb_mm_b2_c2_b4);

pk_combo_dobcount_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_dobcount_nb_mm_b2_c2_b1,
                                  pk_segment_2 = '1 Owner ' => pk_combo_dobcount_nb_mm_b2_c2_b2,
                                  pk_segment_2 = '2 Renter' => pk_combo_dobcount_nb_mm_b2_c2_b3,
                                                               pk_combo_dobcount_nb_mm_b2_c2_b4);

pk_rc_phonelnamecount_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_rc_phonelnamecount_mm_b2_c2_b1,
                                   pk_segment_2 = '1 Owner ' => pk_rc_phonelnamecount_mm_b2_c2_b2,
                                   pk_segment_2 = '2 Renter' => pk_rc_phonelnamecount_mm_b2_c2_b3,
                                                                pk_rc_phonelnamecount_mm_b2_c2_b4);

pk_yr_header_first_seen2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yr_header_first_seen2_mm_b2_c2_b1,
                                      pk_segment_2 = '1 Owner ' => pk_yr_header_first_seen2_mm_b2_c2_b2,
                                      pk_segment_2 = '2 Renter' => pk_yr_header_first_seen2_mm_b2_c2_b3,
                                                                   pk_yr_header_first_seen2_mm_b2_c2_b4);

pk_eq_count_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_eq_count_mm_b2_c2_b1,
                         pk_segment_2 = '1 Owner ' => pk_eq_count_mm_b2_c2_b2,
                         pk_segment_2 = '2 Renter' => pk_eq_count_mm_b2_c2_b3,
                                                      pk_eq_count_mm_b2_c2_b4);

pk_combo_fnamecount_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_fnamecount_nb_mm_b2_c2_b1,
                                    pk_segment_2 = '1 Owner ' => pk_combo_fnamecount_nb_mm_b2_c2_b2,
                                    pk_segment_2 = '2 Renter' => pk_combo_fnamecount_nb_mm_b2_c2_b3,
                                                                 pk_combo_fnamecount_nb_mm_b2_c2_b4);

pk_em_only_ver_lvl_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_em_only_ver_lvl_mm_b2_c2_b1,
                                pk_segment_2 = '1 Owner ' => pk_em_only_ver_lvl_mm_b2_c2_b2,
                                pk_segment_2 = '2 Renter' => pk_em_only_ver_lvl_mm_b2_c2_b3,
                                                             pk_em_only_ver_lvl_mm_b2_c2_b4);

pk_rc_lnamecount_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_rc_lnamecount_nb_mm_b2_c2_b1,
                                 pk_segment_2 = '1 Owner ' => pk_rc_lnamecount_nb_mm_b2_c2_b2,
                                 pk_segment_2 = '2 Renter' => pk_rc_lnamecount_nb_mm_b2_c2_b3,
                                                              pk_rc_lnamecount_nb_mm_b2_c2_b4);

pk_combo_ssncount_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_combo_ssncount_mm_b2_c2_b1,
                               pk_segment_2 = '1 Owner ' => pk_combo_ssncount_mm_b2_c2_b2,
                               pk_segment_2 = '2 Renter' => pk_combo_ssncount_mm_b2_c2_b3,
                                                            pk_combo_ssncount_mm_b2_c2_b4);

pk_pos_secondary_sources_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_pos_secondary_sources_mm_b2_c2_b1,
                                      pk_segment_2 = '1 Owner ' => pk_pos_secondary_sources_mm_b2_c2_b2,
                                      pk_segment_2 = '2 Renter' => pk_pos_secondary_sources_mm_b2_c2_b3,
                                                                   pk_pos_secondary_sources_mm_b2_c2_b4);

pk_rc_phonephonecount_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_rc_phonephonecount_mm_b2_c2_b1,
                                   pk_segment_2 = '1 Owner ' => pk_rc_phonephonecount_mm_b2_c2_b2,
                                   pk_segment_2 = '2 Renter' => pk_rc_phonephonecount_mm_b2_c2_b3,
                                                                pk_rc_phonephonecount_mm_b2_c2_b4);

pk_voter_flag_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_voter_flag_mm_b2_c2_b1,
                           pk_segment_2 = '1 Owner ' => pk_voter_flag_mm_b2_c2_b2,
                           pk_segment_2 = '2 Renter' => pk_voter_flag_mm_b2_c2_b3,
                                                        pk_voter_flag_mm_b2_c2_b4);

pk_rc_addrcount_nb_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_rc_addrcount_nb_mm_b2_c2_b1,
                                pk_segment_2 = '1 Owner ' => pk_rc_addrcount_nb_mm_b2_c2_b2,
                                pk_segment_2 = '2 Renter' => pk_rc_addrcount_nb_mm_b2_c2_b3,
                                                             pk_rc_addrcount_nb_mm_b2_c2_b4);

pk_add2_pos_sources_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_add2_pos_sources_mm_b2_c2_b1,
                                 pk_segment_2 = '1 Owner ' => pk_add2_pos_sources_mm_b2_c2_b2,
                                 pk_segment_2 = '2 Renter' => pk_add2_pos_sources_mm_b2_c2_b3,
                                                              pk_add2_pos_sources_mm_b2_c2_b4);

pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1,
                                       pk_segment_2 = '1 Owner ' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2,
                                       pk_segment_2 = '2 Renter' => pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3,
                                                                    pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4);

pk_lname_eda_sourced_type_lvl_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1,
                                           pk_segment_2 = '1 Owner ' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2,
                                           pk_segment_2 = '2 Renter' => pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3,
                                                                        pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4);

pk_ver_phncount_mm_b2 := map(pk_segment_2 = '0 Derog ' => pk_ver_phncount_mm_b2_c2_b1,
                             pk_segment_2 = '1 Owner ' => pk_ver_phncount_mm_b2_c2_b2,
                             pk_segment_2 = '2 Renter' => pk_ver_phncount_mm_b2_c2_b3,
                                                          pk_ver_phncount_mm_b2_c2_b4);

pk_nap_summary_mm := if((integer)add1_isbestmatch = 1, pk_nap_summary_mm_b1, pk_nap_summary_mm_b2);

pk_yr_infutor_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_infutor_first_seen2_mm_b1, pk_yr_infutor_first_seen2_mm_b2);

pk_yr_lname_change_date2_mm := if((integer)add1_isbestmatch = 1, pk_yr_lname_change_date2_mm_b1, pk_yr_lname_change_date2_mm_b2);

pk_ssnchar_invalid_or_recent_mm := if((integer)add1_isbestmatch = 1, pk_ssnchar_invalid_or_recent_mm_b1, pk_ssnchar_invalid_or_recent_mm_b2);

pk_gong_did_phone_ct_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_gong_did_phone_ct_nb_mm_b2);

pk_combo_dobcount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_combo_dobcount_nb_mm_b2);

pk_rc_phonelnamecount_mm := if((integer)add1_isbestmatch = 1, pk_rc_phonelnamecount_mm_b1, pk_rc_phonelnamecount_mm_b2);

pk_combo_fnamecount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_combo_fnamecount_nb_mm_b2);

pk_rc_lnamecount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_rc_lnamecount_nb_mm_b2);

pk_combo_ssncount_mm := if((integer)add1_isbestmatch = 1, pk_combo_ssncount_mm_b1, pk_combo_ssncount_mm_b2);

pk_pos_secondary_sources_mm := if((integer)add1_isbestmatch = 1, pk_pos_secondary_sources_mm_b1, pk_pos_secondary_sources_mm_b2);

pk_voter_flag_mm := if((integer)add1_isbestmatch = 1, pk_voter_flag_mm_b1, pk_voter_flag_mm_b2);

pk_rc_fnamecount_mm := if((integer)add1_isbestmatch = 1, pk_rc_fnamecount_mm_b1, NULL);

pk_lname_eda_sourced_type_lvl_mm := if((integer)add1_isbestmatch = 1, pk_lname_eda_sourced_type_lvl_mm_b1, pk_lname_eda_sourced_type_lvl_mm_b2);

pk_ver_phncount_mm := if((integer)add1_isbestmatch = 1, pk_ver_phncount_mm_b1, pk_ver_phncount_mm_b2);

pk_combo_dobcount_mm := if((integer)add1_isbestmatch = 1, pk_combo_dobcount_mm_b1, NULL);

pk_nas_summary_mm := if((integer)add1_isbestmatch = 1, pk_nas_summary_mm_b1, pk_nas_summary_mm_b2);

pk_rc_addrcount_mm := if((integer)add1_isbestmatch = 1, pk_rc_addrcount_mm_b1, NULL);

pk_gong_did_phone_ct_mm := if((integer)add1_isbestmatch = 1, pk_gong_did_phone_ct_mm_b1, NULL);

pk_yr_gong_did_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_gong_did_first_seen2_mm_b1, pk_yr_gong_did_first_seen2_mm_b2);

pk_yr_adl_em_only_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_adl_em_only_first_seen2_mm_b1, pk_yr_adl_em_only_first_seen2_mm_b2);

pk_add2_em_ver_lvl_mm := if((integer)add1_isbestmatch = 1, pk_add2_em_ver_lvl_mm_b1, NULL);

pk_infutor_risk_lvl_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_infutor_risk_lvl_nb_mm_b2);

pk_eq_count_mm := if((integer)add1_isbestmatch = 1, pk_eq_count_mm_b1, pk_eq_count_mm_b2);

pk_yr_header_first_seen2_mm := if((integer)add1_isbestmatch = 1, pk_yr_header_first_seen2_mm_b1, pk_yr_header_first_seen2_mm_b2);

pk_em_only_ver_lvl_mm := if((integer)add1_isbestmatch = 1, pk_em_only_ver_lvl_mm_b1, pk_em_only_ver_lvl_mm_b2);

pk_combo_fnamecount_mm := if((integer)add1_isbestmatch = 1, pk_combo_fnamecount_mm_b1, NULL);

pk_rc_phonephonecount_mm := if((integer)add1_isbestmatch = 1, pk_rc_phonephonecount_mm_b1, pk_rc_phonephonecount_mm_b2);

pk_add2_pos_sources_mm := if((integer)add1_isbestmatch = 1, pk_add2_pos_sources_mm_b1, pk_add2_pos_sources_mm_b2);

pk_rc_addrcount_nb_mm := if((integer)add1_isbestmatch = 1, NULL, pk_rc_addrcount_nb_mm_b2);

pk_yrmo_adl_f_sn_mx_fcra2_mm := if((integer)add1_isbestmatch = 1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b1, pk_yrmo_adl_f_sn_mx_fcra2_mm_b2);

pk_infutor_risk_lvl_mm := if((integer)add1_isbestmatch = 1, pk_infutor_risk_lvl_mm_b1, NULL);

pk_estimated_income_mm_b1 := map(pk_estimated_income = -1 => 0.1707317073,
                                 pk_estimated_income = 0  => 0.1666666667,
                                 pk_estimated_income = 1  => 0.1143410853,
                                 pk_estimated_income = 2  => 0.1477987421,
                                 pk_estimated_income = 3  => 0.1136363636,
                                 pk_estimated_income = 4  => 0.1050724638,
                                 pk_estimated_income = 5  => 0.0976377953,
                                 pk_estimated_income = 6  => 0.0910307898,
                                 pk_estimated_income = 7  => 0.077294686,
                                 pk_estimated_income = 8  => 0.0709812109,
                                 pk_estimated_income = 9  => 0.0642648491,
                                 pk_estimated_income = 10 => 0.0746812386,
                                 pk_estimated_income = 11 => 0.0685053381,
                                 pk_estimated_income = 12 => 0.0643072939,
                                 pk_estimated_income = 13 => 0.0536044362,
                                 pk_estimated_income = 14 => 0.0418904404,
                                 pk_estimated_income = 15 => 0.0654827969,
                                 pk_estimated_income = 16 => 0.0444697834,
                                 pk_estimated_income = 17 => 0.045949214,
                                 pk_estimated_income = 18 => 0.0542540074,
                                 pk_estimated_income = 19 => 0.0336700337,
                                 pk_estimated_income = 20 => 0.035431538,
                                 pk_estimated_income = 21 => 0.0356731876,
                                                             0.0184331797);

pk_yr_adl_pr_first_seen2_mm_b1 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.0760346487,
                                      pk_yr_adl_pr_first_seen2 = 0  => 0.0554455446,
                                      pk_yr_adl_pr_first_seen2 = 1  => 0.0472466081,
                                      pk_yr_adl_pr_first_seen2 = 2  => 0.0401301518,
                                      pk_yr_adl_pr_first_seen2 = 3  => 0.0357784969,
                                      pk_yr_adl_pr_first_seen2 = 4  => 0.0427078601,
                                      pk_yr_adl_pr_first_seen2 = 5  => 0.0265957447,
                                      pk_yr_adl_pr_first_seen2 = 6  => 0.0242966752,
                                                                       0.0380952381);

pk_yr_adl_w_first_seen2_mm_b1 := map(pk_yr_adl_w_first_seen2 = -1 => 0.0520830222,
                                     pk_yr_adl_w_first_seen2 = 0  => 0.0547945205,
                                     pk_yr_adl_w_first_seen2 = 1  => 0.0312046444,
                                                                     0.0416666667);

pk_pr_count_mm_b1 := map(pk_pr_count = -1 => 0.0776672447,
                         pk_pr_count = 0  => 0.0435421642,
                         pk_pr_count = 1  => 0.038019205,
                                             0.0415057915);

pk_addrs_sourced_lvl_mm_b1 := map(pk_addrs_sourced_lvl = 0 => 0.0648732294,
                                  pk_addrs_sourced_lvl = 1 => 0.0433600458,
                                  pk_addrs_sourced_lvl = 2 => 0.0385311143,
                                                              0.0341625207);

pk_naprop_level2_mm_b1 := map(pk_naprop_level2 = -2 => 0.086659065,
                              pk_naprop_level2 = -1 => 0.0740740741,
                              pk_naprop_level2 = 0  => 0.0847222222,
                              pk_naprop_level2 = 1  => 0.0580808081,
                              pk_naprop_level2 = 2  => 0.0675166098,
                              pk_naprop_level2 = 3  => 0.0564643799,
                              pk_naprop_level2 = 4  => 0.057875895,
                              pk_naprop_level2 = 5  => 0.0414719626,
                              pk_naprop_level2 = 6  => 0.0378991088,
                                                       0.0358237548);

pk_add1_purchase_amount2_mm_b1 := map(pk_add1_purchase_amount2 = -1 => 0.0552625797,
                                      pk_add1_purchase_amount2 = 0  => 0.0576991783,
                                                                       0.0418326693);

pk_yr_add1_mortgage_date2_mm_b1 := map(pk_yr_add1_mortgage_date2 = -1 => 0.0526646331,
                                       pk_yr_add1_mortgage_date2 = 0  => 0.0548796972,
                                       pk_yr_add1_mortgage_date2 = 1  => 0.0498125335,
                                                                         0.0366657874);

pk_add1_mortgage_risk_mm_b1 := map(pk_add1_mortgage_risk = -1 => 0.0588235294,
                                   pk_add1_mortgage_risk = 0  => 0.0382990707,
                                   pk_add1_mortgage_risk = 1  => 0.0515792949,
                                   pk_add1_mortgage_risk = 2  => 0.0497981157,
                                                                 0.0690876882);

pk_add1_assessed_amount2_mm_b1 := map(pk_add1_assessed_amount2 = -1 => 0.0523393755,
                                      pk_add1_assessed_amount2 = 0  => 0.0771604938,
                                      pk_add1_assessed_amount2 = 1  => 0.0546875,
                                      pk_add1_assessed_amount2 = 2  => 0.0817307692,
                                      pk_add1_assessed_amount2 = 3  => 0.0670443815,
                                      pk_add1_assessed_amount2 = 4  => 0.0591743119,
                                      pk_add1_assessed_amount2 = 5  => 0.0388349515,
                                                                       0.0400600901);

pk_yr_add1_mortgage_due_date2_mm_b1 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.0522078249,
                                           pk_yr_add1_mortgage_due_date2 = 0  => 0.0308832613,
                                           pk_yr_add1_mortgage_due_date2 = 1  => 0.0429527304,
                                                                                 0.0605829682);

pk_yr_add1_date_first_seen2_mm_b1 := map(pk_yr_add1_date_first_seen2 = -1 => 0.107678328,
                                         pk_yr_add1_date_first_seen2 = 0  => 0.0851943755,
                                         pk_yr_add1_date_first_seen2 = 1  => 0.0592044403,
                                         pk_yr_add1_date_first_seen2 = 2  => 0.0515873016,
                                         pk_yr_add1_date_first_seen2 = 3  => 0.049833887,
                                         pk_yr_add1_date_first_seen2 = 4  => 0.043043043,
                                         pk_yr_add1_date_first_seen2 = 5  => 0.0405761461,
                                         pk_yr_add1_date_first_seen2 = 6  => 0.0380848749,
                                         pk_yr_add1_date_first_seen2 = 7  => 0.0440464666,
                                         pk_yr_add1_date_first_seen2 = 8  => 0.0335479498,
                                         pk_yr_add1_date_first_seen2 = 9  => 0.0246861925,
                                                                             0.0337078652);

pk_add1_land_use_risk_level_mm_b1 := map(pk_add1_land_use_risk_level = 0 => 0.0597014925,
                                         pk_add1_land_use_risk_level = 2 => 0.0447321699,
                                         pk_add1_land_use_risk_level = 3 => 0.0641296012,
                                                                            0.0603907638);

pk_add1_building_area2_mm_b1 := map(pk_add1_building_area2 = -99 => 0.0546845366,
                                    pk_add1_building_area2 = -4  => 0.0909090909,
                                    pk_add1_building_area2 = -3  => 0.0707395498,
                                    pk_add1_building_area2 = -2  => 0.0506961114,
                                    pk_add1_building_area2 = -1  => 0.0368644926,
                                    pk_add1_building_area2 = 0   => 0.0390946502,
                                    pk_add1_building_area2 = 1   => 0.0532786885,
                                    pk_add1_building_area2 = 2   => 0.0476190476,
                                    pk_add1_building_area2 = 3   => 0.0568720379,
                                                                    0.0634920635);

pk_add1_no_of_rooms_mm_b1 := map(pk_add1_no_of_rooms = -1 => 0.0516094503,
                                 pk_add1_no_of_rooms = 0  => 0.0625,
                                 pk_add1_no_of_rooms = 1  => 0.0719745223,
                                 pk_add1_no_of_rooms = 2  => 0.053196245,
                                 pk_add1_no_of_rooms = 3  => 0.0438448567,
                                                             0.0383091149);

pk_add1_no_of_baths_mm_b1 := map(pk_add1_no_of_baths = -3 => 0.0546804561,
                                 pk_add1_no_of_baths = -2 => 0.0605500821,
                                 pk_add1_no_of_baths = -1 => 0.0435090202,
                                 pk_add1_no_of_baths = 0  => 0.0378240544,
                                 pk_add1_no_of_baths = 1  => 0.0285234899,
                                                             0.057591623);

pk_property_owned_total_mm_b1 := map(pk_property_owned_total = -1 => 0.069489091,
                                     pk_property_owned_total = 0  => 0.0400577409,
                                     pk_property_owned_total = 1  => 0.0348330914,
                                     pk_property_owned_total = 2  => 0.0367647059,
                                                                     0.0380228137);

pk_prop_own_assess_tot2_mm_b1 := map(pk_prop_own_assess_tot2 = 0 => 0.0573041756,
                                     pk_prop_own_assess_tot2 = 1 => 0.0535384615,
                                     pk_prop_own_assess_tot2 = 2 => 0.0500834725,
                                     pk_prop_own_assess_tot2 = 3 => 0.0318181818,
                                                                    0.032603633);

pk_add2_building_area2_mm_b1 := map(pk_add2_building_area2 = -4 => 0.0506042296,
                                    pk_add2_building_area2 = -3 => 0.0615763547,
                                    pk_add2_building_area2 = -2 => 0.0699658703,
                                    pk_add2_building_area2 = -1 => 0.0536260072,
                                    pk_add2_building_area2 = 0  => 0.0477732794,
                                    pk_add2_building_area2 = 1  => 0.0263157895,
                                                                   0.0387596899);

pk_add2_no_of_buildings_mm_b1 := map(pk_add2_no_of_buildings = -1 => 0.0500978342,
                                     pk_add2_no_of_buildings = 0  => 0.0574712644,
                                     pk_add2_no_of_buildings = 1  => 0.0616302187,
                                                                     0.0142857143);

pk_add2_garage_type_risk_lvl_mm_b1 := map(pk_add2_garage_type_risk_level = 0 => 0.0438034188,
                                          pk_add2_garage_type_risk_level = 1 => 0.0495697074,
                                          pk_add2_garage_type_risk_level = 2 => 0.060952381,
                                                                                0.0514617759);

pk_add2_parking_no_of_cars_mm_b1 := map(pk_add2_parking_no_of_cars = 0 => 0.0517634067,
                                        pk_add2_parking_no_of_cars = 1 => 0.0511770727,
                                        pk_add2_parking_no_of_cars = 2 => 0.0502594919,
                                                                          0.0370860927);

pk_yr_add2_mortgage_due_date2_mm_b1 := map(pk_yr_add2_mortgage_due_date2 = -1 => 0.052211696,
                                           pk_yr_add2_mortgage_due_date2 = 0  => 0.038606403,
                                           pk_yr_add2_mortgage_due_date2 = 1  => 0.0356083086,
                                           pk_yr_add2_mortgage_due_date2 = 2  => 0.0615735462,
                                                                                 0.0523861766);

pk_add2_assessed_amount2_mm_b1 := map(pk_add2_assessed_amount2 = -1 => 0.0503641242,
                                      pk_add2_assessed_amount2 = 0  => 0.0775930325,
                                      pk_add2_assessed_amount2 = 1  => 0.0533333333,
                                      pk_add2_assessed_amount2 = 2  => 0.055401662,
                                      pk_add2_assessed_amount2 = 3  => 0.0498108449,
                                                                       0.0470852018);

pk_yr_add2_date_first_seen2_mm_b1 := map(pk_yr_add2_date_first_seen2 = -1 => 0.0831099196,
                                         pk_yr_add2_date_first_seen2 = 0  => 0.0693989071,
                                         pk_yr_add2_date_first_seen2 = 1  => 0.0659229209,
                                         pk_yr_add2_date_first_seen2 = 2  => 0.0520585233,
                                         pk_yr_add2_date_first_seen2 = 3  => 0.0578764143,
                                         pk_yr_add2_date_first_seen2 = 4  => 0.0534079349,
                                         pk_yr_add2_date_first_seen2 = 5  => 0.0611213235,
                                         pk_yr_add2_date_first_seen2 = 6  => 0.0641569459,
                                         pk_yr_add2_date_first_seen2 = 7  => 0.0443230115,
                                         pk_yr_add2_date_first_seen2 = 8  => 0.0374092686,
                                         pk_yr_add2_date_first_seen2 = 9  => 0.0381307339,
                                         pk_yr_add2_date_first_seen2 = 10 => 0.0365120275,
                                                                             0.0307772561);

pk_add3_mortgage_risk_mm_b1 := map(pk_add3_mortgage_risk = -1 => 0,
                                   pk_add3_mortgage_risk = 0  => 0.036338225,
                                   pk_add3_mortgage_risk = 1  => 0.0309278351,
                                   pk_add3_mortgage_risk = 2  => 0.0515473888,
                                   pk_add3_mortgage_risk = 3  => 0.0518134715,
                                   pk_add3_mortgage_risk = 4  => 0.0622261174,
                                                                 0.0607142857);

pk_add3_assessed_amount2_mm_b1 := map(pk_add3_assessed_amount2 = -1 => 0.0513996578,
                                      pk_add3_assessed_amount2 = 0  => 0.0627413127,
                                      pk_add3_assessed_amount2 = 1  => 0.0559322034,
                                      pk_add3_assessed_amount2 = 2  => 0.0605898123,
                                                                       0.0430916553);

pk_yr_add3_date_first_seen2_mm_b1 := map(pk_yr_add3_date_first_seen2 = -1 => 0.078229772,
                                         pk_yr_add3_date_first_seen2 = 0  => 0.0701492537,
                                         pk_yr_add3_date_first_seen2 = 1  => 0.0736896731,
                                         pk_yr_add3_date_first_seen2 = 2  => 0.048441449,
                                         pk_yr_add3_date_first_seen2 = 3  => 0.0477597243,
                                         pk_yr_add3_date_first_seen2 = 4  => 0.0603193377,
                                         pk_yr_add3_date_first_seen2 = 5  => 0.053530578,
                                         pk_yr_add3_date_first_seen2 = 6  => 0.0504578219,
                                         pk_yr_add3_date_first_seen2 = 7  => 0.0433572919,
                                         pk_yr_add3_date_first_seen2 = 8  => 0.0399690562,
                                                                             0.0349107836);

pk_bk_level_mm_b1 := map(pk_bk_level_2 = 0 => 0.0507280598,
                         pk_bk_level_2 = 1 => 0.0485189511,
                                              0.1271676301);

pk_eviction_level_mm_b1 := map(pk_eviction_level = 0 => 0.0482978467,
                               pk_eviction_level = 1 => 0.0872359963,
                               pk_eviction_level = 2 => 0.0809716599,
                               pk_eviction_level = 3 => 0.1086956522,
                               pk_eviction_level = 4 => 0.1397058824,
                               pk_eviction_level = 5 => 0.2096774194,
                               pk_eviction_level = 6 => 0.170212766,
                                                        0.1578947368);

pk_lien_type_level_mm_b1 := map(pk_lien_type_level = 0 => 0.0461295783,
                                pk_lien_type_level = 1 => 0.0714285714,
                                pk_lien_type_level = 2 => 0.0483516484,
                                pk_lien_type_level = 3 => 0.0536387359,
                                pk_lien_type_level = 4 => 0.081265012,
                                                          0.1071428571);

pk_yr_liens_last_unrel_date3_mm_b1 := map((integer)pk_yr_liens_last_unrel_date3_2 = -1 => 0.056676363,
                                          pk_yr_liens_last_unrel_date3_2 = -0.5        => 0.0388001304,
                                          (integer)pk_yr_liens_last_unrel_date3_2 = 0  => 0.0937931034,
                                          (integer)pk_yr_liens_last_unrel_date3_2 = 1  => 0.0627420604,
                                          (integer)pk_yr_liens_last_unrel_date3_2 = 2  => 0.0554339898,
                                          (integer)pk_yr_liens_last_unrel_date3_2 = 3  => 0.070688379,
                                                                                          0.050747443);

pk_yr_criminal_last_date2_mm_b1 := map(pk_yr_criminal_last_date2 = -1 => 0.04923944,
                                       pk_yr_criminal_last_date2 = 0  => 0.145320197,
                                       pk_yr_criminal_last_date2 = 1  => 0.0816901408,
                                       pk_yr_criminal_last_date2 = 2  => 0.092879257,
                                       pk_yr_criminal_last_date2 = 3  => 0.0535714286,
                                                                         0.0557275542);

pk_yr_felony_last_date2_mm_b1 := map(pk_yr_felony_last_date2 = -1 => 0.0501919441,
                                     pk_yr_felony_last_date2 = 0  => 0.1688311688,
                                     pk_yr_felony_last_date2 = 1  => 0.1298701299,
                                     pk_yr_felony_last_date2 = 2  => 0.1333333333,
                                                                     0.1241830065);

pk_attr_total_number_derogs_mm_b1 := map(pk_attr_total_number_derogs_4 = 0 => 0.0419847328,
                                         pk_attr_total_number_derogs_4 = 1 => 0.0574241181,
                                         pk_attr_total_number_derogs_4 = 2 => 0.0730337079,
                                                                              0.0974178404);

pk_yr_rc_ssnhighissue2_mm_b1 := map(pk_yr_rc_ssnhighissue2 = -1 => 0,
                                    pk_yr_rc_ssnhighissue2 = 0  => 0.125,
                                    pk_yr_rc_ssnhighissue2 = 1  => 0.1222222222,
                                    pk_yr_rc_ssnhighissue2 = 2  => 0.0616666667,
                                    pk_yr_rc_ssnhighissue2 = 3  => 0.0835913313,
                                    pk_yr_rc_ssnhighissue2 = 4  => 0.0770887166,
                                    pk_yr_rc_ssnhighissue2 = 5  => 0.0660310734,
                                    pk_yr_rc_ssnhighissue2 = 6  => 0.0618634478,
                                    pk_yr_rc_ssnhighissue2 = 7  => 0.0641368252,
                                    pk_yr_rc_ssnhighissue2 = 8  => 0.064399093,
                                    pk_yr_rc_ssnhighissue2 = 9  => 0.0569105691,
                                    pk_yr_rc_ssnhighissue2 = 10 => 0.0493771234,
                                    pk_yr_rc_ssnhighissue2 = 11 => 0.0351270553,
                                    pk_yr_rc_ssnhighissue2 = 12 => 0.0397196262,
                                    pk_yr_rc_ssnhighissue2 = 13 => 0.0347771103,
                                                                   0.0355701312);

pk_pl_sourced_level_mm_b1 := map(pk_pl_sourced_level = 0 => 0.0529406253,
                                 pk_pl_sourced_level = 1 => 0.024,
                                 pk_pl_sourced_level = 2 => 0.0364725095,
                                                            0.0353697749);

pk_prof_lic_cat_mm_b1 := map(pk_prof_lic_cat = -1 => 0.0525195831,
                             pk_prof_lic_cat = 0  => 0.0431472081,
                             pk_prof_lic_cat = 1  => 0.0481144343,
                             pk_prof_lic_cat = 2  => 0.0357554787,
                                                     0.0140562249);

pk_add1_lres_mm_b1 := map(pk_add1_lres = -2 => 0.0285714286,
                          pk_add1_lres = -1 => 0.1044397463,
                          pk_add1_lres = 0  => 0.1146341463,
                          pk_add1_lres = 1  => 0.0763157895,
                          pk_add1_lres = 2  => 0.0946601942,
                          pk_add1_lres = 3  => 0.08,
                          pk_add1_lres = 4  => 0.0688786224,
                          pk_add1_lres = 5  => 0.0637488107,
                          pk_add1_lres = 6  => 0.0504520268,
                          pk_add1_lres = 7  => 0.0471394037,
                          pk_add1_lres = 8  => 0.0394326683,
                          pk_add1_lres = 9  => 0.0405679513,
                          pk_add1_lres = 10 => 0.0388149774,
                                               0.0269277846);

pk_add2_lres_mm_b1 := map(pk_add2_lres = -2 => 0.0790568655,
                          pk_add2_lres = -1 => 0.0408418943,
                          pk_add2_lres = 0  => 0.077636153,
                          pk_add2_lres = 1  => 0.061901723,
                          pk_add2_lres = 2  => 0.0569085487,
                          pk_add2_lres = 3  => 0.0452640402,
                          pk_add2_lres = 4  => 0.0578592093,
                          pk_add2_lres = 5  => 0.0564784053,
                          pk_add2_lres = 6  => 0.057060126,
                          pk_add2_lres = 7  => 0.0476590973,
                          pk_add2_lres = 8  => 0.0369078756,
                          pk_add2_lres = 9  => 0.035106768,
                                               0.0303797468);

pk_add3_lres_mm_b1 := map(pk_add3_lres = -2 => 0.0788043478,
                          pk_add3_lres = -1 => 0.0383781716,
                          pk_add3_lres = 0  => 0.0561122244,
                          pk_add3_lres = 1  => 0.0534834624,
                          pk_add3_lres = 2  => 0.054577857,
                          pk_add3_lres = 3  => 0.0524213679,
                          pk_add3_lres = 4  => 0.0503401361,
                          pk_add3_lres = 5  => 0.0406746032,
                                               0.0399628253);

pk_lres_flag_level_mm_b1 := map(pk_lres_flag_level = 0 => 0.1033333333,
                                pk_lres_flag_level = 1 => 0.0525483998,
                                                          0.0470460598);

pk_addrs_5yr_mm_b1 := map(pk_addrs_5yr = 0 => 0.0404501894,
                          pk_addrs_5yr = 1 => 0.0528611898,
                          pk_addrs_5yr = 2 => 0.0551724138,
                          pk_addrs_5yr = 3 => 0.0688487585,
                                              0.0734265734);

pk_addrs_15yr_mm_b1 := map(pk_addrs_15yr = 0 => 0.0418888043,
                           pk_addrs_15yr = 1 => 0.0515778091,
                           pk_addrs_15yr = 2 => 0.0493273543,
                                                0.0732323232);

pk_add_lres_month_avg2_mm_b1 := map(pk_add_lres_month_avg2 = -1 => 0.2352941176,
                                    pk_add_lres_month_avg2 = 0  => 0.2142857143,
                                    pk_add_lres_month_avg2 = 1  => 0.163538874,
                                    pk_add_lres_month_avg2 = 2  => 0.1245136187,
                                    pk_add_lres_month_avg2 = 3  => 0.0759599332,
                                    pk_add_lres_month_avg2 = 4  => 0.0791366906,
                                    pk_add_lres_month_avg2 = 5  => 0.0800405268,
                                    pk_add_lres_month_avg2 = 6  => 0.0816326531,
                                    pk_add_lres_month_avg2 = 7  => 0.0721311475,
                                    pk_add_lres_month_avg2 = 8  => 0.0634854772,
                                    pk_add_lres_month_avg2 = 9  => 0.0556255248,
                                    pk_add_lres_month_avg2 = 10 => 0.0565345081,
                                    pk_add_lres_month_avg2 = 11 => 0.0515215426,
                                    pk_add_lres_month_avg2 = 12 => 0.0419111484,
                                    pk_add_lres_month_avg2 = 13 => 0.0377223178,
                                    pk_add_lres_month_avg2 = 15 => 0.0331425128,
                                                                   0.0299896587);

pk_ssns_per_adl_mm_b1 := map(pk_ssns_per_adl = -1 => 0.2631578947,
                             pk_ssns_per_adl = 0  => 0.0490469831,
                             pk_ssns_per_adl = 1  => 0.0541661584,
                             pk_ssns_per_adl = 2  => 0.0590486605,
                             pk_ssns_per_adl = 3  => 0.072234763,
                                                     0.0738255034);

pk_addrs_per_adl_mm_b1 := map(pk_addrs_per_adl = -6 => 0.2307692308,
                              pk_addrs_per_adl = -5 => 0.085995086,
                              pk_addrs_per_adl = -4 => 0.0805658057,
                              pk_addrs_per_adl = -3 => 0.050509165,
                              pk_addrs_per_adl = -2 => 0.0534124629,
                              pk_addrs_per_adl = -1 => 0.0489820006,
                              pk_addrs_per_adl = 0  => 0.0488950276,
                              pk_addrs_per_adl = 1  => 0.0494905386,
                              pk_addrs_per_adl = 2  => 0.045066211,
                                                       0.0471498944);

pk_phones_per_adl_mm_b1 := map(pk_phones_per_adl = -1 => 0.058265651,
                               pk_phones_per_adl = 0  => 0.0434948493,
                               pk_phones_per_adl = 1  => 0.0355577204,
                                                         0.038147139);

pk_adlperssn_count_mm_b1 := map(pk_adlperssn_count = -1 => 0,
                                pk_adlperssn_count = 0  => 0.0503996448,
                                pk_adlperssn_count = 1  => 0.0516216498,
                                                           0.0571069972);

pk_adls_per_addr_mm_b1 := map(pk_adls_per_addr = -102 => 0.0668348045,
                              pk_adls_per_addr = -101 => 0.0504201681,
                              pk_adls_per_addr = -2   => 0.0638930163,
                              pk_adls_per_addr = -1   => 0.0332278481,
                              pk_adls_per_addr = 0    => 0.0328680774,
                              pk_adls_per_addr = 1    => 0.0379207499,
                              pk_adls_per_addr = 2    => 0.0401706363,
                              pk_adls_per_addr = 3    => 0.0489810511,
                              pk_adls_per_addr = 4    => 0.0484048405,
                              pk_adls_per_addr = 5    => 0.044534413,
                              pk_adls_per_addr = 6    => 0.0484018265,
                              pk_adls_per_addr = 7    => 0.048951049,
                              pk_adls_per_addr = 8    => 0.0490909091,
                              pk_adls_per_addr = 9    => 0.0551971326,
                              pk_adls_per_addr = 10   => 0.0534575772,
                              pk_adls_per_addr = 11   => 0.0573726542,
                              pk_adls_per_addr = 12   => 0.0761654629,
                              pk_adls_per_addr = 13   => 0.068762279,
                              pk_adls_per_addr = 100  => 0.0615384615,
                              pk_adls_per_addr = 101  => 0.0714285714,
                                                         0.0644132653);

pk_adls_per_phone_mm_b1 := map(pk_adls_per_phone = -2 => 0.0594854396,
                               pk_adls_per_phone = -1 => 0.0439090455,
                               pk_adls_per_phone = 0  => 0.0392383151,
                                                         0.0476190476);

pk_ssns_per_adl_c6_mm_b1 := map(pk_ssns_per_adl_c6 = 0 => 0.0458082838,
                                pk_ssns_per_adl_c6 = 1 => 0.0667503137,
                                                          0.1433962264);

pk_ssns_per_addr_c6_mm_b1 := map(pk_ssns_per_addr_c6 = 0   => 0.0406296246,
                                 pk_ssns_per_addr_c6 = 1   => 0.0625861051,
                                 pk_ssns_per_addr_c6 = 2   => 0.0793728564,
                                 pk_ssns_per_addr_c6 = 3   => 0.0845323741,
                                 pk_ssns_per_addr_c6 = 4   => 0.1520467836,
                                 pk_ssns_per_addr_c6 = 5   => 0.2653061224,
                                 pk_ssns_per_addr_c6 = 6   => 0.1363636364,
                                 pk_ssns_per_addr_c6 = 100 => 0.0645514223,
                                 pk_ssns_per_addr_c6 = 101 => 0.0767263427,
                                 pk_ssns_per_addr_c6 = 102 => 0.0476190476,
                                 pk_ssns_per_addr_c6 = 103 => 0.125,
                                                              0.2);

pk_adls_per_phone_c6_mm_b1 := map(pk_adls_per_phone_c6 = 0 => 0.0569276247,
                                  pk_adls_per_phone_c6 = 1 => 0.0441877981,
                                                              0.0371134021);

pk_attr_addrs_last90_mm_b1 := map(pk_attr_addrs_last90 = 0 => 0.0486216298,
                                  pk_attr_addrs_last90 = 1 => 0.089629282,
                                                              0.077294686);

pk_attr_addrs_last12_mm_b1 := map(pk_attr_addrs_last12 = 0 => 0.0472945234,
                                  pk_attr_addrs_last12 = 1 => 0.0567096466,
                                  pk_attr_addrs_last12 = 2 => 0.0697329377,
                                  pk_attr_addrs_last12 = 3 => 0.0777777778,
                                                              0.0633802817);

pk_attr_addrs_last24_mm_b1 := map(pk_attr_addrs_last24 = 0 => 0.0447934846,
                                  pk_attr_addrs_last24 = 1 => 0.0521006929,
                                  pk_attr_addrs_last24 = 2 => 0.065433213,
                                  pk_attr_addrs_last24 = 3 => 0.0609836066,
                                  pk_attr_addrs_last24 = 4 => 0.0808823529,
                                                              0.0833333333);

pk_ams_class_level_mm_b1 := map(pk_ams_class_level = -1000001 => 0.0498654376,
                                pk_ams_class_level = 0        => 0.25,
                                pk_ams_class_level = 1        => 0.2432432432,
                                pk_ams_class_level = 2        => 0.1538461538,
                                pk_ams_class_level = 3        => 0.0576923077,
                                pk_ams_class_level = 4        => 0.0967741935,
                                pk_ams_class_level = 5        => 0.1086956522,
                                pk_ams_class_level = 6        => 0.0983606557,
                                pk_ams_class_level = 7        => 0.0440140845,
                                pk_ams_class_level = 8        => 0.0566318927,
                                pk_ams_class_level = 1000000  => 0.0845070423,
                                pk_ams_class_level = 1000001  => 0.0652173913,
                                pk_ams_class_level = 1000002  => 0.0280373832,
                                pk_ams_class_level = 1000003  => 0,
                                pk_ams_class_level = 1000004  => 0.0181818182,
                                                                 0.0108695652);

pk_ams_4yr_college_mm_b1 := map(pk_ams_4yr_college = -1 => 0.0434782609,
                                pk_ams_4yr_college = 0  => 0.0517937613,
                                                           0.0336590662);

pk_ams_college_type_mm_b1 := map(pk_ams_college_type = 0 => 0.0518739577,
                                 pk_ams_college_type = 1 => 0.0361809045,
                                                            0.0172413793);

pk_ams_income_level_code_mm_b1 := map(pk_ams_income_level_code = -1 => 0.0498654376,
                                      pk_ams_income_level_code = 0  => 0.1142857143,
                                      pk_ams_income_level_code = 1  => 0.1021126761,
                                      pk_ams_income_level_code = 2  => 0.0760626398,
                                      pk_ams_income_level_code = 3  => 0.0703517588,
                                      pk_ams_income_level_code = 4  => 0.0454545455,
                                      pk_ams_income_level_code = 5  => 0.0642673522,
                                                                       0.0378378378);

pk_yr_in_dob2_mm_b1 := map(pk_yr_in_dob2 = 19 => 0.25,
                           pk_yr_in_dob2 = 20 => 0.3670886076,
                           pk_yr_in_dob2 = 21 => 0.2380952381,
                           pk_yr_in_dob2 = 22 => 0.1238938053,
                           pk_yr_in_dob2 = 23 => 0.0945945946,
                           pk_yr_in_dob2 = 25 => 0.11,
                           pk_yr_in_dob2 = 29 => 0.0980707395,
                           pk_yr_in_dob2 = 35 => 0.073088685,
                           pk_yr_in_dob2 = 38 => 0.0545943868,
                           pk_yr_in_dob2 = 41 => 0.0554225111,
                           pk_yr_in_dob2 = 42 => 0.047952048,
                           pk_yr_in_dob2 = 43 => 0.041136141,
                           pk_yr_in_dob2 = 44 => 0.0545286506,
                           pk_yr_in_dob2 = 45 => 0.0616302187,
                           pk_yr_in_dob2 = 47 => 0.050614948,
                           pk_yr_in_dob2 = 49 => 0.0471698113,
                           pk_yr_in_dob2 = 57 => 0.0362438221,
                           pk_yr_in_dob2 = 61 => 0.034,
                                                 0.034);

pk_yr_ams_dob2_mm_b1 := map(pk_yr_ams_dob2 = -1 => 0.0494084269,
                            pk_yr_ams_dob2 = 20 => 0.2380952381,
                            pk_yr_ams_dob2 = 22 => 0.2321428571,
                            pk_yr_ams_dob2 = 23 => 0.0555555556,
                            pk_yr_ams_dob2 = 32 => 0.1044417767,
                            pk_yr_ams_dob2 = 43 => 0.0479041916,
                                                   0.0479041916);

pk_inferred_age_mm_b1 := map(pk_inferred_age = -1 => 0,
                             pk_inferred_age = 18 => 0.4634146341,
                             pk_inferred_age = 19 => 0.4307692308,
                             pk_inferred_age = 20 => 0.1935483871,
                             pk_inferred_age = 21 => 0.1355932203,
                             pk_inferred_age = 22 => 0.109947644,
                             pk_inferred_age = 24 => 0.1175337187,
                             pk_inferred_age = 34 => 0.0779303062,
                             pk_inferred_age = 37 => 0.0528900642,
                             pk_inferred_age = 41 => 0.0546407186,
                             pk_inferred_age = 42 => 0.0403940887,
                             pk_inferred_age = 43 => 0.0560661765,
                             pk_inferred_age = 44 => 0.0573372206,
                             pk_inferred_age = 46 => 0.0476190476,
                             pk_inferred_age = 48 => 0.0449976065,
                             pk_inferred_age = 52 => 0.0404699739,
                             pk_inferred_age = 56 => 0.034,
                             pk_inferred_age = 61 => 0.034,
                                                     0.034);

pk_yr_reported_dob2_mm_b1 := map(pk_yr_reported_dob2 = -1 => 0.0963160231,
                                 pk_yr_reported_dob2 = 19 => 0.5714285714,
                                 pk_yr_reported_dob2 = 21 => 0.2413793103,
                                 pk_yr_reported_dob2 = 22 => 0.1818181818,
                                 pk_yr_reported_dob2 = 23 => 0.1224489796,
                                 pk_yr_reported_dob2 = 32 => 0.0957039558,
                                 pk_yr_reported_dob2 = 35 => 0.0544412607,
                                 pk_yr_reported_dob2 = 39 => 0.0552941176,
                                 pk_yr_reported_dob2 = 42 => 0.0534979424,
                                 pk_yr_reported_dob2 = 43 => 0.0394736842,
                                 pk_yr_reported_dob2 = 44 => 0.05651341,
                                 pk_yr_reported_dob2 = 45 => 0.0597165992,
                                 pk_yr_reported_dob2 = 46 => 0.0571705426,
                                 pk_yr_reported_dob2 = 49 => 0.0431818182,
                                 pk_yr_reported_dob2 = 57 => 0.035,
                                 pk_yr_reported_dob2 = 61 => 0.035,
                                                             0.035);

pk_avm_hit_level_mm_b1 := map(pk_avm_hit_level = -1 => 0.0604145602,
                              pk_avm_hit_level = 0  => 0.0607291273,
                              pk_avm_hit_level = 1  => 0.0438130643,
                                                       0.0457605723);

pk_avm_auto_diff2_lvl_mm_b1 := map(pk_avm_auto_diff2_lvl = -2 => 0.0598488161,
                                   pk_avm_auto_diff2_lvl = -1 => 0.0425671251,
                                   pk_avm_auto_diff2_lvl = 0  => 0.0478981985,
                                   pk_avm_auto_diff2_lvl = 1  => 0.0440759328,
                                                                 0.0344202899);

pk_avm_auto_diff4_lvl_mm_b1 := map(pk_avm_auto_diff4_lvl = -1 => 0.0551261796,
                                   pk_avm_auto_diff4_lvl = 0  => 0.0438929229,
                                                                 0.0429311621);

pk_add2_avm_auto_diff2_lvl_mm_b1 := map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0516966422,
                                        pk_add2_avm_auto_diff2_lvl = -2 => 0.0527888446,
                                        pk_add2_avm_auto_diff2_lvl = -1 => 0.0416171225,
                                        pk_add2_avm_auto_diff2_lvl = 0  => 0.0469328942,
                                                                           0.0541920606);

pk_avm_confidence_level_mm_b1 := map(pk_avm_confidence_level = 0 => 0.0534806958,
                                     pk_avm_confidence_level = 1 => 0.0480682839,
                                     pk_avm_confidence_level = 2 => 0.0417979416,
                                                                    0.0457796853);

pk2_add1_avm_mkt_mm_b1 := map(pk2_add1_avm_mkt = 0 => 0.0749235474,
                              pk2_add1_avm_mkt = 1 => 0.0532875109,
                              pk2_add1_avm_mkt = 2 => 0.0612612613,
                              pk2_add1_avm_mkt = 3 => 0.0391794182,
                                                      0.0281923715);

pk2_add1_avm_pi_mm_b1 := map(pk2_add1_avm_pi = 0 => 0.119047619,
                             pk2_add1_avm_pi = 1 => 0.0710128056,
                             pk2_add1_avm_pi = 2 => 0.0544841482,
                                                    0.0384740436);

pk2_add1_avm_auto_mm_b1 := map(pk2_add1_avm_auto = 0 => 0.1358024691,
                               pk2_add1_avm_auto = 1 => 0.1028037383,
                               pk2_add1_avm_auto = 2 => 0.0833333333,
                               pk2_add1_avm_auto = 3 => 0.0730253353,
                               pk2_add1_avm_auto = 4 => 0.060437885,
                               pk2_add1_avm_auto = 5 => 0.0417090539,
                                                        0.0272290443);

pk2_add1_avm_auto2_mm_b1 := map(pk2_add1_avm_auto2 = 0 => 0.1176470588,
                                pk2_add1_avm_auto2 = 1 => 0.09,
                                pk2_add1_avm_auto2 = 2 => 0.0789473684,
                                pk2_add1_avm_auto2 = 3 => 0.0755287009,
                                pk2_add1_avm_auto2 = 4 => 0.0598488161,
                                pk2_add1_avm_auto2 = 5 => 0.0574398249,
                                pk2_add1_avm_auto2 = 6 => 0.0410437431,
                                                          0.0276179517);

pk2_add1_avm_auto3_mm_b1 := map(pk2_add1_avm_auto3 = 0 => 0.0786516854,
                                pk2_add1_avm_auto3 = 1 => 0.0833333333,
                                pk2_add1_avm_auto3 = 2 => 0.0651872399,
                                pk2_add1_avm_auto3 = 3 => 0.0597570318,
                                pk2_add1_avm_auto3 = 4 => 0.0592515593,
                                pk2_add1_avm_auto3 = 5 => 0.0586642599,
                                pk2_add1_avm_auto3 = 6 => 0.0369572423,
                                                          0.0297699594);

pk2_add1_avm_med_mm_b1 := map(pk2_add1_avm_med = 0 => 0.075,
                              pk2_add1_avm_med = 1 => 0.1096345515,
                              pk2_add1_avm_med = 2 => 0.0515097691,
                              pk2_add1_avm_med = 3 => 0.0852059925,
                              pk2_add1_avm_med = 4 => 0.0646714826,
                              pk2_add1_avm_med = 5 => 0.0482894847,
                              pk2_add1_avm_med = 6 => 0.0219378428,
                                                      0.0528579108);

pk2_add1_avm_to_med_ratio_mm_b1 := map(pk2_add1_avm_to_med_ratio = 0 => 0.0596236149,
                                       pk2_add1_avm_to_med_ratio = 1 => 0.0443758646,
                                       pk2_add1_avm_to_med_ratio = 2 => 0.043956044,
                                       pk2_add1_avm_to_med_ratio = 3 => 0.0424161074,
                                       pk2_add1_avm_to_med_ratio = 4 => 0.0392464678,
                                                                        0.04283054);

pk2_add2_avm_sp_mm_b1 := map(pk2_add2_avm_sp = 0 => 0.0710900474,
                             pk2_add2_avm_sp = 1 => 0.0915492958,
                             pk2_add2_avm_sp = 2 => 0.0531309298,
                             pk2_add2_avm_sp = 3 => 0.0516048068,
                             pk2_add2_avm_sp = 4 => 0.0516652434,
                                                    0.0454381536);

pk2_add2_avm_ta_mm_b1 := map(pk2_add2_avm_ta = 0 => 0.100204499,
                             pk2_add2_avm_ta = 1 => 0.0517043136,
                                                    0.0467206888);

pk2_add2_avm_pi_mm_b1 := map(pk2_add2_avm_pi = 0 => 0.0869565217,
                             pk2_add2_avm_pi = 1 => 0.0742857143,
                             pk2_add2_avm_pi = 2 => 0.0518956106,
                             pk2_add2_avm_pi = 3 => 0.0471567268,
                                                    0.0434462445);

pk2_add2_avm_hed_mm_b1 := map(pk2_add2_avm_hed = 0 => 0.0882352941,
                              pk2_add2_avm_hed = 1 => 0.0833333333,
                              pk2_add2_avm_hed = 2 => 0.0697167756,
                              pk2_add2_avm_hed = 3 => 0.0511381353,
                              pk2_add2_avm_hed = 4 => 0.061928934,
                              pk2_add2_avm_hed = 5 => 0.0486478752,
                                                      0.0353089533);

pk2_add2_avm_auto_mm_b1 := map(pk2_add2_avm_auto = 0 => 0.0841654779,
                               pk2_add2_avm_auto = 1 => 0.0524324565,
                               pk2_add2_avm_auto = 2 => 0.0482057299,
                                                        0.0419866871);

pk2_add2_avm_auto3_mm_b1 := map(pk2_add2_avm_auto3 = 0 => 0.0926517572,
                                pk2_add2_avm_auto3 = 1 => 0.0716253444,
                                pk2_add2_avm_auto3 = 2 => 0.0523315007,
                                pk2_add2_avm_auto3 = 3 => 0.0474683544,
                                                          0.0345368917);

pk2_yr_add1_avm_rec_dt_mm_b1 := map(pk2_yr_add1_avm_recording_date = 0 => 0.0561294766,
                                    pk2_yr_add1_avm_recording_date = 1 => 0.0480192077,
                                    pk2_yr_add1_avm_recording_date = 2 => 0.054613267,
                                    pk2_yr_add1_avm_recording_date = 3 => 0.0432872254,
                                                                          0.0345807674);

pk2_yr_add1_avm_assess_year_mm_b1 := map(pk2_yr_add1_avm_assess_year = 0 => 0.0591160845,
                                         pk2_yr_add1_avm_assess_year = 1 => 0.04160184,
                                                                            0.0525949147);

pk_dist_a1toa2_mm_b1 := map(pk_dist_a1toa2_2 = 0 => 0.05115039,
                            pk_dist_a1toa2_2 = 1 => 0.0471866832,
                            pk_dist_a1toa2_2 = 2 => 0.0558447039,
                            pk_dist_a1toa2_2 = 3 => 0.0555762775,
                                                    0.0694288914);

pk_dist_a1toa3_mm_b1 := map(pk_dist_a1toa3_2 = 0 => 0.0514669319,
                            pk_dist_a1toa3_2 = 1 => 0.047064652,
                            pk_dist_a1toa3_2 = 2 => 0.050398808,
                            pk_dist_a1toa3_2 = 3 => 0.0501903773,
                            pk_dist_a1toa3_2 = 4 => 0.048537234,
                            pk_dist_a1toa3_2 = 5 => 0.0440122825,
                                                    0.074255406);

pk_rc_disthphoneaddr_mm_b1 := map(pk_rc_disthphoneaddr_2 = 0 => 0.0418864806,
                                  pk_rc_disthphoneaddr_2 = 1 => 0.0473009086,
                                  pk_rc_disthphoneaddr_2 = 2 => 0.0524861878,
                                  pk_rc_disthphoneaddr_2 = 3 => 0.0787172012,
                                                                0.0613132911);

pk_out_st_division_lvl_mm_b1 := map(pk_out_st_division_lvl = -1 => 0.0769230769,
                                    pk_out_st_division_lvl = 0  => 0.0602782071,
                                    pk_out_st_division_lvl = 1  => 0.0574907,
                                    pk_out_st_division_lvl = 2  => 0.0607870696,
                                    pk_out_st_division_lvl = 3  => 0.0533548909,
                                    pk_out_st_division_lvl = 4  => 0.0595371407,
                                    pk_out_st_division_lvl = 5  => 0.0378413952,
                                    pk_out_st_division_lvl = 6  => 0.0479641867,
                                    pk_out_st_division_lvl = 7  => 0.0569719862,
                                                                   0.0475892298);

pk_wealth_index_mm_b1 := map(pk_wealth_index_2 = 0 => 0.0661707883,
                             pk_wealth_index_2 = 1 => 0.0697940503,
                             pk_wealth_index_2 = 2 => 0.0555555556,
                             pk_wealth_index_2 = 3 => 0.0467002581,
                                                      0.0332605758);

pk_attr_num_nonderogs90_b_mm_b1 := map(pk_attr_num_nonderogs90_b = 0  => 0.1940298507,
                                       pk_attr_num_nonderogs90_b = 1  => 0.096969697,
                                       pk_attr_num_nonderogs90_b = 2  => 0.0585106383,
                                       pk_attr_num_nonderogs90_b = 3  => 0.0485902819,
                                       pk_attr_num_nonderogs90_b = 4  => 0.0214007782,
                                       pk_attr_num_nonderogs90_b = 10 => 0.1153846154,
                                       pk_attr_num_nonderogs90_b = 11 => 0.0607563546,
                                       pk_attr_num_nonderogs90_b = 12 => 0.0419505199,
                                       pk_attr_num_nonderogs90_b = 13 => 0.0335008375,
                                                                         0.0295324036);

pk_ssns_per_addr2_mm_b1 := map(pk_ssns_per_addr2 = -101 => 0.0664869721,
                               pk_ssns_per_addr2 = -2   => 0.0538847118,
                               pk_ssns_per_addr2 = -1   => 0.0442748092,
                               pk_ssns_per_addr2 = 0    => 0.0329925651,
                               pk_ssns_per_addr2 = 1    => 0.0323462415,
                               pk_ssns_per_addr2 = 2    => 0.0419847328,
                               pk_ssns_per_addr2 = 3    => 0.0482017056,
                               pk_ssns_per_addr2 = 4    => 0.0480399693,
                               pk_ssns_per_addr2 = 5    => 0.0464422667,
                               pk_ssns_per_addr2 = 6    => 0.0500231589,
                               pk_ssns_per_addr2 = 7    => 0.048245614,
                               pk_ssns_per_addr2 = 8    => 0.0498463639,
                               pk_ssns_per_addr2 = 9    => 0.0556701031,
                               pk_ssns_per_addr2 = 10   => 0.0524767043,
                               pk_ssns_per_addr2 = 11   => 0.0706976744,
                               pk_ssns_per_addr2 = 12   => 0.0701438849,
                               pk_ssns_per_addr2 = 100  => 0.0620689655,
                               pk_ssns_per_addr2 = 101  => 0.072,
                               pk_ssns_per_addr2 = 102  => 0.0670794634,
                                                           0.058076225);

pk_yr_add2_assess_val_yr2_mm_b1 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.0527511768,
                                       pk_yr_add2_assessed_value_year2 = 0  => 0.102189781,
                                       pk_yr_add2_assessed_value_year2 = 1  => 0.0491077802,
                                                                               0.0496688742);

pk_estimated_income_mm_b2 := map(pk_estimated_income = -1 => 0.0377358491,
                                 pk_estimated_income = 0  => 0,
                                 pk_estimated_income = 1  => 0.0588235294,
                                 pk_estimated_income = 2  => 0.0253164557,
                                 pk_estimated_income = 3  => 0.0502793296,
                                 pk_estimated_income = 4  => 0.0163934426,
                                 pk_estimated_income = 5  => 0.0366598778,
                                 pk_estimated_income = 6  => 0.0271816881,
                                 pk_estimated_income = 7  => 0.0218778487,
                                 pk_estimated_income = 8  => 0.0200647249,
                                 pk_estimated_income = 9  => 0.0168593449,
                                 pk_estimated_income = 10 => 0.0169701987,
                                 pk_estimated_income = 11 => 0.0200271555,
                                 pk_estimated_income = 12 => 0.0207822197,
                                 pk_estimated_income = 13 => 0.0206349206,
                                 pk_estimated_income = 14 => 0.0160901046,
                                 pk_estimated_income = 15 => 0.0176870748,
                                 pk_estimated_income = 16 => 0.0138297872,
                                 pk_estimated_income = 17 => 0.0161374284,
                                 pk_estimated_income = 18 => 0.0134080936,
                                 pk_estimated_income = 19 => 0.0162830558,
                                 pk_estimated_income = 20 => 0.0137871445,
                                 pk_estimated_income = 21 => 0.0125333881,
                                                             0.0083769634);

pk_yr_adl_pr_first_seen2_mm_b2 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.0204796551,
                                      pk_yr_adl_pr_first_seen2 = 0  => 0.0332058764,
                                      pk_yr_adl_pr_first_seen2 = 1  => 0.0187973301,
                                      pk_yr_adl_pr_first_seen2 = 2  => 0.0155883067,
                                      pk_yr_adl_pr_first_seen2 = 3  => 0.0122689242,
                                      pk_yr_adl_pr_first_seen2 = 4  => 0.0099052173,
                                      pk_yr_adl_pr_first_seen2 = 5  => 0.0096822848,
                                      pk_yr_adl_pr_first_seen2 = 6  => 0.0097481722,
                                                                       0.0077021823);

pk_yr_adl_w_first_seen2_mm_b2 := map(pk_yr_adl_w_first_seen2 = -1 => 0.0152350421,
                                     pk_yr_adl_w_first_seen2 = 0  => 0.0179063361,
                                     pk_yr_adl_w_first_seen2 = 1  => 0.011509324,
                                                                     0.0118443316);

pk_pr_count_mm_b2 := map(pk_pr_count = -1 => 0.0239239799,
                         pk_pr_count = 0  => 0.0131429715,
                         pk_pr_count = 1  => 0.0146571489,
                                             0.0205042948);

pk_addrs_sourced_lvl_mm_b2 := map(pk_addrs_sourced_lvl = 0 => 0.0149657543,
                                  pk_addrs_sourced_lvl = 1 => 0.0171501227,
                                  pk_addrs_sourced_lvl = 2 => 0.0155642023,
                                                              0.0127927026);

pk_naprop_level2_mm_b2 := map(pk_naprop_level2 = -2 => 0.0358851675,
                              pk_naprop_level2 = -1 => 0.0223564955,
                              pk_naprop_level2 = 0  => 0.0134952767,
                              pk_naprop_level2 = 1  => 0.0187265918,
                              pk_naprop_level2 = 2  => 0.0143027414,
                              pk_naprop_level2 = 3  => 0.0254706534,
                              pk_naprop_level2 = 4  => 0.0310457516,
                              pk_naprop_level2 = 5  => 0.0182854563,
                              pk_naprop_level2 = 6  => 0.0143104607,
                                                       0.0121581393);

pk_add1_purchase_amount2_mm_b2 := map(pk_add1_purchase_amount2 = -1 => 0.0140074801,
                                      pk_add1_purchase_amount2 = 0  => 0.0176380368,
                                                                       0.0150110737);

pk_yr_add1_mortgage_date2_mm_b2 := map(pk_yr_add1_mortgage_date2 = -1 => 0.0128157319,
                                       pk_yr_add1_mortgage_date2 = 0  => 0.0239171375,
                                       pk_yr_add1_mortgage_date2 = 1  => 0.0153862824,
                                                                         0.010106332);

pk_add1_mortgage_risk_mm_b2 := map(pk_add1_mortgage_risk = -1 => 0.0620155039,
                                   pk_add1_mortgage_risk = 0  => 0.0150961386,
                                   pk_add1_mortgage_risk = 1  => 0.0135517896,
                                   pk_add1_mortgage_risk = 2  => 0.0190292053,
                                                                 0.0280866674);

pk_add1_assessed_amount2_mm_b2 := map(pk_add1_assessed_amount2 = -1 => 0.0150512949,
                                      pk_add1_assessed_amount2 = 0  => 0.0299796748,
                                      pk_add1_assessed_amount2 = 1  => 0.0284249767,
                                      pk_add1_assessed_amount2 = 2  => 0.0275637226,
                                      pk_add1_assessed_amount2 = 3  => 0.0204444444,
                                      pk_add1_assessed_amount2 = 4  => 0.0157386102,
                                      pk_add1_assessed_amount2 = 5  => 0.0171834143,
                                                                       0.0118841687);

pk_yr_add1_mortgage_due_date2_mm_b2 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.0127983961,
                                           pk_yr_add1_mortgage_due_date2 = 0  => 0.0101714618,
                                           pk_yr_add1_mortgage_due_date2 = 1  => 0.0164163752,
                                                                                 0.0247328938);

pk_yr_add1_date_first_seen2_mm_b2 := map(pk_yr_add1_date_first_seen2 = -1 => 0.0379047619,
                                         pk_yr_add1_date_first_seen2 = 0  => 0.0288263555,
                                         pk_yr_add1_date_first_seen2 = 1  => 0.0223468742,
                                         pk_yr_add1_date_first_seen2 = 2  => 0.0209497207,
                                         pk_yr_add1_date_first_seen2 = 3  => 0.0161536991,
                                         pk_yr_add1_date_first_seen2 = 4  => 0.0133964661,
                                         pk_yr_add1_date_first_seen2 = 5  => 0.0131929523,
                                         pk_yr_add1_date_first_seen2 = 6  => 0.0113393591,
                                         pk_yr_add1_date_first_seen2 = 7  => 0.0104218362,
                                         pk_yr_add1_date_first_seen2 = 8  => 0.0078332362,
                                         pk_yr_add1_date_first_seen2 = 9  => 0.008532015,
                                                                             0.0075740699);

pk_add1_land_use_risk_level_mm_b2 := map(pk_add1_land_use_risk_level = 0 => 0.0135869565,
                                         pk_add1_land_use_risk_level = 2 => 0.0142956385,
                                         pk_add1_land_use_risk_level = 3 => 0.0185639603,
                                                                            0.0231481481);

pk_add1_building_area2_mm_b2 := map(pk_add1_building_area2 = -99 => 0.015419511,
                                    pk_add1_building_area2 = -4  => 0.0262951334,
                                    pk_add1_building_area2 = -3  => 0.0203476049,
                                    pk_add1_building_area2 = -2  => 0.0166547168,
                                    pk_add1_building_area2 = -1  => 0.0120073265,
                                    pk_add1_building_area2 = 0   => 0.0104424779,
                                    pk_add1_building_area2 = 1   => 0.0124481328,
                                    pk_add1_building_area2 = 2   => 0.0038910506,
                                    pk_add1_building_area2 = 3   => 0.0195652174,
                                                                    0.0448548813);

pk_add1_no_of_rooms_mm_b2 := map(pk_add1_no_of_rooms = -1 => 0.0157878778,
                                 pk_add1_no_of_rooms = 0  => 0.0152075627,
                                 pk_add1_no_of_rooms = 1  => 0.0208013402,
                                 pk_add1_no_of_rooms = 2  => 0.0153256705,
                                 pk_add1_no_of_rooms = 3  => 0.0109589041,
                                                             0.0107204611);

pk_add1_no_of_baths_mm_b2 := map(pk_add1_no_of_baths = -3 => 0.0155461734,
                                 pk_add1_no_of_baths = -2 => 0.0172501739,
                                 pk_add1_no_of_baths = -1 => 0.0150268491,
                                 pk_add1_no_of_baths = 0  => 0.0107262417,
                                 pk_add1_no_of_baths = 1  => 0.0132352941,
                                                             0.0123119015);

pk_property_owned_total_mm_b2 := map(pk_property_owned_total = -1 => 0.0195793094,
                                     pk_property_owned_total = 0  => 0.0152542916,
                                     pk_property_owned_total = 1  => 0.0135669432,
                                     pk_property_owned_total = 2  => 0.0176506391,
                                                                     0.0177187154);

pk_prop_own_assess_tot2_mm_b2 := map(pk_prop_own_assess_tot2 = 0 => 0.0149866977,
                                     pk_prop_own_assess_tot2 = 1 => 0.0280898876,
                                     pk_prop_own_assess_tot2 = 2 => 0.0162335493,
                                     pk_prop_own_assess_tot2 = 3 => 0.0153180682,
                                                                    0.0110698704);

pk_add2_building_area2_mm_b2 := map(pk_add2_building_area2 = -4 => 0.0149868408,
                                    pk_add2_building_area2 = -3 => 0.0143599145,
                                    pk_add2_building_area2 = -2 => 0.0168693605,
                                    pk_add2_building_area2 = -1 => 0.016661743,
                                    pk_add2_building_area2 = 0  => 0.013095433,
                                    pk_add2_building_area2 = 1  => 0.0126782884,
                                                                   0.0081727963);

pk_add2_no_of_buildings_mm_b2 := map(pk_add2_no_of_buildings = -1 => 0.0152552792,
                                     pk_add2_no_of_buildings = 0  => 0.014732436,
                                     pk_add2_no_of_buildings = 1  => 0.0101950355,
                                                                     0.0068965517);

pk_add2_garage_type_risk_lvl_mm_b2 := map(pk_add2_garage_type_risk_level = 0 => 0.013196094,
                                          pk_add2_garage_type_risk_level = 1 => 0.0157296606,
                                          pk_add2_garage_type_risk_level = 2 => 0.016285956,
                                                                                0.0151460064);

pk_add2_parking_no_of_cars_mm_b2 := map(pk_add2_parking_no_of_cars = 0 => 0.0150738783,
                                        pk_add2_parking_no_of_cars = 1 => 0.0164590239,
                                        pk_add2_parking_no_of_cars = 2 => 0.0142281739,
                                                                          0.0159219312);

pk_yr_add2_mortgage_due_date2_mm_b2 := map(pk_yr_add2_mortgage_due_date2 = -1 => 0.0144909956,
                                           pk_yr_add2_mortgage_due_date2 = 0  => 0.0118025751,
                                           pk_yr_add2_mortgage_due_date2 = 1  => 0.0181294273,
                                           pk_yr_add2_mortgage_due_date2 = 2  => 0.0149014214,
                                                                                 0.018335102);

pk_add2_assessed_amount2_mm_b2 := map(pk_add2_assessed_amount2 = -1 => 0.0147752861,
                                      pk_add2_assessed_amount2 = 0  => 0.0224003773,
                                      pk_add2_assessed_amount2 = 1  => 0.0197103181,
                                      pk_add2_assessed_amount2 = 2  => 0.0165051087,
                                      pk_add2_assessed_amount2 = 3  => 0.0142220216,
                                                                       0.0131661936);

pk_yr_add2_date_first_seen2_mm_b2 := map(pk_yr_add2_date_first_seen2 = -1 => 0.0138943249,
                                         pk_yr_add2_date_first_seen2 = 0  => 0.0274987811,
                                         pk_yr_add2_date_first_seen2 = 1  => 0.0218702866,
                                         pk_yr_add2_date_first_seen2 = 2  => 0.021435059,
                                         pk_yr_add2_date_first_seen2 = 3  => 0.0186681223,
                                         pk_yr_add2_date_first_seen2 = 4  => 0.0161751897,
                                         pk_yr_add2_date_first_seen2 = 5  => 0.01541587,
                                         pk_yr_add2_date_first_seen2 = 6  => 0.0123272826,
                                         pk_yr_add2_date_first_seen2 = 7  => 0.0119570153,
                                         pk_yr_add2_date_first_seen2 = 8  => 0.0116130255,
                                         pk_yr_add2_date_first_seen2 = 9  => 0.0106244297,
                                         pk_yr_add2_date_first_seen2 = 10 => 0.0088211708,
                                                                             0.00864525);

pk_add3_mortgage_risk_mm_b2 := map(pk_add3_mortgage_risk = -1 => 0,
                                   pk_add3_mortgage_risk = 0  => 0.0148224244,
                                   pk_add3_mortgage_risk = 1  => 0.0025188917,
                                   pk_add3_mortgage_risk = 2  => 0.0147557392,
                                   pk_add3_mortgage_risk = 3  => 0.0183130833,
                                   pk_add3_mortgage_risk = 4  => 0.0198690449,
                                                                 0.0215439856);

pk_add3_assessed_amount2_mm_b2 := map(pk_add3_assessed_amount2 = -1 => 0.0148082137,
                                      pk_add3_assessed_amount2 = 0  => 0.0223695112,
                                      pk_add3_assessed_amount2 = 1  => 0.018714402,
                                      pk_add3_assessed_amount2 = 2  => 0.016015021,
                                                                       0.0143119266);

pk_yr_add3_date_first_seen2_mm_b2 := map(pk_yr_add3_date_first_seen2 = -1 => 0.0126624459,
                                         pk_yr_add3_date_first_seen2 = 0  => 0.0310695628,
                                         pk_yr_add3_date_first_seen2 = 1  => 0.0275630252,
                                         pk_yr_add3_date_first_seen2 = 2  => 0.0229482692,
                                         pk_yr_add3_date_first_seen2 = 3  => 0.0193133047,
                                         pk_yr_add3_date_first_seen2 = 4  => 0.0197561352,
                                         pk_yr_add3_date_first_seen2 = 5  => 0.0168483235,
                                         pk_yr_add3_date_first_seen2 = 6  => 0.0136422807,
                                         pk_yr_add3_date_first_seen2 = 7  => 0.0132487059,
                                         pk_yr_add3_date_first_seen2 = 8  => 0.0104112441,
                                                                             0.0089029727);

pk_bk_level_mm_b2 := if(pk_bk_level_2 = 0, 0.0150686374, NULL);

pk_eviction_level_mm_b2 := if(pk_eviction_level = 0, 0.0150686374, NULL);

pk_lien_type_level_mm_b2 := if(pk_lien_type_level = 0, 0.0150686374, NULL);

pk_yr_liens_last_unrel_date3_mm_b2 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0150686374, NULL);

pk_yr_criminal_last_date2_mm_b2 := if(pk_yr_criminal_last_date2 = -1, 0.0150686374, NULL);

pk_yr_felony_last_date2_mm_b2 := if(pk_yr_felony_last_date2 = -1, 0.0150686374, NULL);

pk_attr_total_number_derogs_mm_b2 := if(pk_attr_total_number_derogs_4 = 0, 0.0150686374, NULL);

pk_yr_rc_ssnhighissue2_mm_b2 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.0348837209,
                                    pk_yr_rc_ssnhighissue2 = 0  => 0.0111111111,
                                    pk_yr_rc_ssnhighissue2 = 1  => 0.036834925,
                                    pk_yr_rc_ssnhighissue2 = 2  => 0.0307656177,
                                    pk_yr_rc_ssnhighissue2 = 3  => 0.0222345748,
                                    pk_yr_rc_ssnhighissue2 = 4  => 0.0272300469,
                                    pk_yr_rc_ssnhighissue2 = 5  => 0.0253122398,
                                    pk_yr_rc_ssnhighissue2 = 6  => 0.0192251956,
                                    pk_yr_rc_ssnhighissue2 = 7  => 0.0147538658,
                                    pk_yr_rc_ssnhighissue2 = 8  => 0.017884457,
                                    pk_yr_rc_ssnhighissue2 = 9  => 0.0169715843,
                                    pk_yr_rc_ssnhighissue2 = 10 => 0.0126851256,
                                    pk_yr_rc_ssnhighissue2 = 11 => 0.0104322651,
                                    pk_yr_rc_ssnhighissue2 = 12 => 0.0096065272,
                                    pk_yr_rc_ssnhighissue2 = 13 => 0.0066592675,
                                                                   0.0074724773);

pk_pl_sourced_level_mm_b2 := map(pk_pl_sourced_level = 0 => 0.0155080002,
                                 pk_pl_sourced_level = 1 => 0.0184672207,
                                 pk_pl_sourced_level = 2 => 0.0140438871,
                                                            0.0082188089);

pk_prof_lic_cat_mm_b2 := map(pk_prof_lic_cat = -1 => 0.0155193992,
                             pk_prof_lic_cat = 0  => 0.0160886664,
                             pk_prof_lic_cat = 1  => 0.0133182205,
                             pk_prof_lic_cat = 2  => 0.0094055681,
                                                     0.0068189567);

pk_add1_lres_mm_b2 := map(pk_add1_lres = -2 => 0.0073529412,
                          pk_add1_lres = -1 => 0.0362957938,
                          pk_add1_lres = 0  => 0.0238095238,
                          pk_add1_lres = 1  => 0.031905196,
                          pk_add1_lres = 2  => 0.0200668896,
                          pk_add1_lres = 3  => 0.0263929619,
                          pk_add1_lres = 4  => 0.0246897949,
                          pk_add1_lres = 5  => 0.0219185881,
                          pk_add1_lres = 6  => 0.0197649988,
                          pk_add1_lres = 7  => 0.015606897,
                          pk_add1_lres = 8  => 0.0126638035,
                          pk_add1_lres = 9  => 0.010437466,
                          pk_add1_lres = 10 => 0.0092422487,
                                               0.0086046512);

pk_add2_lres_mm_b2 := map(pk_add2_lres = -2 => 0.0133785942,
                          pk_add2_lres = -1 => 0.010609839,
                          pk_add2_lres = 0  => 0.0251322751,
                          pk_add2_lres = 1  => 0.0199710826,
                          pk_add2_lres = 2  => 0.0197368421,
                          pk_add2_lres = 3  => 0.0192771084,
                          pk_add2_lres = 4  => 0.0195177956,
                          pk_add2_lres = 5  => 0.0180425657,
                          pk_add2_lres = 6  => 0.0140659918,
                          pk_add2_lres = 7  => 0.0113847757,
                          pk_add2_lres = 8  => 0.0123691722,
                          pk_add2_lres = 9  => 0.0122581881,
                                               0.0116533139);

pk_add3_lres_mm_b2 := map(pk_add3_lres = -2 => 0.012306444,
                          pk_add3_lres = -1 => 0.0111382984,
                          pk_add3_lres = 0  => 0.0196813236,
                          pk_add3_lres = 1  => 0.0161226897,
                          pk_add3_lres = 2  => 0.016813654,
                          pk_add3_lres = 3  => 0.0149210488,
                          pk_add3_lres = 4  => 0.0142949968,
                          pk_add3_lres = 5  => 0.0160123172,
                                               0.0101979604);

pk_lres_flag_level_mm_b2 := map(pk_lres_flag_level = 0 => 0.0356432361,
                                pk_lres_flag_level = 1 => 0.0091218682,
                                                          0.014849215);

pk_addrs_5yr_mm_b2 := map(pk_addrs_5yr = 0 => 0.009228548,
                          pk_addrs_5yr = 1 => 0.0157131527,
                          pk_addrs_5yr = 2 => 0.0231515663,
                          pk_addrs_5yr = 3 => 0.0328222329,
                                              0.0391014975);

pk_addrs_15yr_mm_b2 := map(pk_addrs_15yr = 0 => 0.0078210258,
                           pk_addrs_15yr = 1 => 0.0150078417,
                           pk_addrs_15yr = 2 => 0.0267843555,
                                                0.0350877193);

pk_add_lres_month_avg2_mm_b2 := map(pk_add_lres_month_avg2 = -1 => 0.0317460317,
                                    pk_add_lres_month_avg2 = 0  => 0.1264367816,
                                    pk_add_lres_month_avg2 = 1  => 0.0531791908,
                                    pk_add_lres_month_avg2 = 2  => 0.0394321767,
                                    pk_add_lres_month_avg2 = 3  => 0.0394736842,
                                    pk_add_lres_month_avg2 = 4  => 0.0264496439,
                                    pk_add_lres_month_avg2 = 5  => 0.0319273579,
                                    pk_add_lres_month_avg2 = 6  => 0.0366900859,
                                    pk_add_lres_month_avg2 = 7  => 0.0243716679,
                                    pk_add_lres_month_avg2 = 8  => 0.0220361935,
                                    pk_add_lres_month_avg2 = 9  => 0.0188839124,
                                    pk_add_lres_month_avg2 = 10 => 0.0134441708,
                                    pk_add_lres_month_avg2 = 11 => 0.015803997,
                                    pk_add_lres_month_avg2 = 12 => 0.0128024865,
                                    pk_add_lres_month_avg2 = 13 => 0.0103228034,
                                    pk_add_lres_month_avg2 = 15 => 0.0091258405,
                                                                   0.006832037);

pk_ssns_per_adl_mm_b2 := map(pk_ssns_per_adl = -1 => 0.0335820896,
                             pk_ssns_per_adl = 0  => 0.014061925,
                             pk_ssns_per_adl = 1  => 0.018740949,
                             pk_ssns_per_adl = 2  => 0.0175097276,
                             pk_ssns_per_adl = 3  => 0.0307414105,
                                                     0.0267857143);

pk_addrs_per_adl_mm_b2 := map(pk_addrs_per_adl = -6 => 0.0267260579,
                              pk_addrs_per_adl = -5 => 0.0137931034,
                              pk_addrs_per_adl = -4 => 0.0110262114,
                              pk_addrs_per_adl = -3 => 0.0142049191,
                              pk_addrs_per_adl = -2 => 0.01422599,
                              pk_addrs_per_adl = -1 => 0.0149567656,
                              pk_addrs_per_adl = 0  => 0.0150279168,
                              pk_addrs_per_adl = 1  => 0.0175383323,
                              pk_addrs_per_adl = 2  => 0.0198173693,
                                                       0.0162721893);

pk_phones_per_adl_mm_b2 := map(pk_phones_per_adl = -1 => 0.0170953443,
                               pk_phones_per_adl = 0  => 0.0132280742,
                               pk_phones_per_adl = 1  => 0.0123317117,
                                                         0.0104968509);

pk_adlperssn_count_mm_b2 := map(pk_adlperssn_count = -1 => 0.0155279503,
                                pk_adlperssn_count = 0  => 0.0147362125,
                                pk_adlperssn_count = 1  => 0.015618788,
                                                           0.0163520743);

pk_adls_per_addr_mm_b2 := map(pk_adls_per_addr = -102 => 0.0248041775,
                              pk_adls_per_addr = -101 => 0.0206489676,
                              pk_adls_per_addr = -2   => 0.0190073918,
                              pk_adls_per_addr = -1   => 0.0140939597,
                              pk_adls_per_addr = 0    => 0.0079447323,
                              pk_adls_per_addr = 1    => 0.0103723198,
                              pk_adls_per_addr = 2    => 0.0104781863,
                              pk_adls_per_addr = 3    => 0.0119063818,
                              pk_adls_per_addr = 4    => 0.0134690213,
                              pk_adls_per_addr = 5    => 0.0139096751,
                              pk_adls_per_addr = 6    => 0.0172644127,
                              pk_adls_per_addr = 7    => 0.0173856209,
                              pk_adls_per_addr = 8    => 0.0191862388,
                              pk_adls_per_addr = 9    => 0.0187460946,
                              pk_adls_per_addr = 10   => 0.0210290828,
                              pk_adls_per_addr = 11   => 0.0250266241,
                              pk_adls_per_addr = 12   => 0.0227835562,
                              pk_adls_per_addr = 13   => 0.0298146656,
                              pk_adls_per_addr = 100  => 0.0294985251,
                              pk_adls_per_addr = 101  => 0.0106761566,
                                                         0.0222507488);

pk_adls_per_phone_mm_b2 := map(pk_adls_per_phone = -2 => 0.0213850045,
                               pk_adls_per_phone = -1 => 0.0113271039,
                               pk_adls_per_phone = 0  => 0.0107739355,
                                                         0.0158924205);

pk_ssns_per_adl_c6_mm_b2 := map(pk_ssns_per_adl_c6 = 0 => 0.0130425799,
                                pk_ssns_per_adl_c6 = 1 => 0.0237956375,
                                                          0.0353159851);

pk_ssns_per_addr_c6_mm_b2 := map(pk_ssns_per_addr_c6 = 0   => 0.0121551081,
                                 pk_ssns_per_addr_c6 = 1   => 0.0219355572,
                                 pk_ssns_per_addr_c6 = 2   => 0.0245288248,
                                 pk_ssns_per_addr_c6 = 3   => 0.0343422584,
                                 pk_ssns_per_addr_c6 = 4   => 0.0337301587,
                                 pk_ssns_per_addr_c6 = 5   => 0.064,
                                 pk_ssns_per_addr_c6 = 6   => 0.1084337349,
                                 pk_ssns_per_addr_c6 = 100 => 0.0230640201,
                                 pk_ssns_per_addr_c6 = 101 => 0.0305343511,
                                 pk_ssns_per_addr_c6 = 102 => 0.0238095238,
                                 pk_ssns_per_addr_c6 = 103 => 0,
                                                              0.05);

pk_adls_per_phone_c6_mm_b2 := map(pk_adls_per_phone_c6 = 0 => 0.018561033,
                                  pk_adls_per_phone_c6 = 1 => 0.0115737806,
                                                              0.011282854);

pk_attr_addrs_last90_mm_b2 := map(pk_attr_addrs_last90 = 0 => 0.0143867959,
                                  pk_attr_addrs_last90 = 1 => 0.0286581254,
                                                              0.0380952381);

pk_attr_addrs_last12_mm_b2 := map(pk_attr_addrs_last12 = 0 => 0.0129645486,
                                  pk_attr_addrs_last12 = 1 => 0.0218828357,
                                  pk_attr_addrs_last12 = 2 => 0.0316027088,
                                  pk_attr_addrs_last12 = 3 => 0.0421511628,
                                                              0.0659340659);

pk_attr_addrs_last24_mm_b2 := map(pk_attr_addrs_last24 = 0 => 0.0112002751,
                                  pk_attr_addrs_last24 = 1 => 0.0180902161,
                                  pk_attr_addrs_last24 = 2 => 0.0266073527,
                                  pk_attr_addrs_last24 = 3 => 0.0282857143,
                                  pk_attr_addrs_last24 = 4 => 0.0416666667,
                                                              0.0366492147);

pk_ams_class_level_mm_b2 := map(pk_ams_class_level = -1000001 => 0.0145902773,
                                pk_ams_class_level = 0        => 0.0903225806,
                                pk_ams_class_level = 1        => 0.0875,
                                pk_ams_class_level = 2        => 0.0731707317,
                                pk_ams_class_level = 3        => 0.0420168067,
                                pk_ams_class_level = 4        => 0.015625,
                                pk_ams_class_level = 5        => 0.0243778568,
                                pk_ams_class_level = 6        => 0.0237324703,
                                pk_ams_class_level = 7        => 0.0171821306,
                                pk_ams_class_level = 8        => 0.0139491631,
                                pk_ams_class_level = 1000000  => 0.0170940171,
                                pk_ams_class_level = 1000001  => 0.0309278351,
                                pk_ams_class_level = 1000002  => 0.0164458657,
                                pk_ams_class_level = 1000003  => 0.0184331797,
                                pk_ams_class_level = 1000004  => 0.0139082058,
                                                                 0.0038659794);

pk_ams_4yr_college_mm_b2 := map(pk_ams_4yr_college = -1 => 0.0275319567,
                                pk_ams_4yr_college = 0  => 0.0151181684,
                                                           0.0118372791);

pk_ams_college_type_mm_b2 := map(pk_ams_college_type = 0 => 0.0151239901,
                                 pk_ams_college_type = 1 => 0.015229295,
                                                            0.0077787381);

pk_ams_income_level_code_mm_b2 := map(pk_ams_income_level_code = -1 => 0.0145898186,
                                      pk_ams_income_level_code = 0  => 0.0215053763,
                                      pk_ams_income_level_code = 1  => 0.030952381,
                                      pk_ams_income_level_code = 2  => 0.0210727969,
                                      pk_ams_income_level_code = 3  => 0.0202448211,
                                      pk_ams_income_level_code = 4  => 0.0173887415,
                                      pk_ams_income_level_code = 5  => 0.0197728229,
                                                                       0.012932674);

pk_yr_in_dob2_mm_b2 := map(pk_yr_in_dob2 = 19 => 0.0762711864,
                           pk_yr_in_dob2 = 20 => 0.125,
                           pk_yr_in_dob2 = 21 => 0.0927419355,
                           pk_yr_in_dob2 = 22 => 0.0537974684,
                           pk_yr_in_dob2 = 23 => 0.0442260442,
                           pk_yr_in_dob2 = 25 => 0.0412844037,
                           pk_yr_in_dob2 = 29 => 0.0308337895,
                           pk_yr_in_dob2 = 35 => 0.025105144,
                           pk_yr_in_dob2 = 38 => 0.0192291035,
                           pk_yr_in_dob2 = 41 => 0.0175498968,
                           pk_yr_in_dob2 = 42 => 0.0145947355,
                           pk_yr_in_dob2 = 43 => 0.0131678906,
                           pk_yr_in_dob2 = 44 => 0.0134061569,
                           pk_yr_in_dob2 = 45 => 0.013917004,
                           pk_yr_in_dob2 = 47 => 0.0136465031,
                           pk_yr_in_dob2 = 49 => 0.0125374762,
                           pk_yr_in_dob2 = 57 => 0.0109679794,
                           pk_yr_in_dob2 = 61 => 0.0081864506,
                                                 0.0072477963);

pk_yr_ams_dob2_mm_b2 := map(pk_yr_ams_dob2 = -1 => 0.0145809589,
                            pk_yr_ams_dob2 = 20 => 0.0952380952,
                            pk_yr_ams_dob2 = 22 => 0.0804597701,
                            pk_yr_ams_dob2 = 23 => 0.0291262136,
                            pk_yr_ams_dob2 = 32 => 0.023755939,
                            pk_yr_ams_dob2 = 43 => 0.0166852058,
                                                   0.0111336032);

pk_inferred_age_mm_b2 := map(pk_inferred_age = -1 => 0.0332409972,
                             pk_inferred_age = 18 => 0.0608108108,
                             pk_inferred_age = 19 => 0.0625,
                             pk_inferred_age = 20 => 0.0735632184,
                             pk_inferred_age = 21 => 0.062992126,
                             pk_inferred_age = 22 => 0.0344827586,
                             pk_inferred_age = 24 => 0.0404647436,
                             pk_inferred_age = 34 => 0.0248363586,
                             pk_inferred_age = 37 => 0.0186478126,
                             pk_inferred_age = 41 => 0.0161648177,
                             pk_inferred_age = 42 => 0.0107446277,
                             pk_inferred_age = 43 => 0.0141463415,
                             pk_inferred_age = 44 => 0.0125439037,
                             pk_inferred_age = 46 => 0.0131939909,
                             pk_inferred_age = 48 => 0.0116183707,
                             pk_inferred_age = 52 => 0.0106116011,
                             pk_inferred_age = 56 => 0.0103516517,
                             pk_inferred_age = 61 => 0.0083158526,
                                                     0.0079410366);

pk_yr_reported_dob2_mm_b2 := map(pk_yr_reported_dob2 = -1 => 0.0262598664,
                                 pk_yr_reported_dob2 = 19 => 0.1428571429,
                                 pk_yr_reported_dob2 = 21 => 0.0609756098,
                                 pk_yr_reported_dob2 = 22 => 0.0515463918,
                                 pk_yr_reported_dob2 = 23 => 0.018018018,
                                 pk_yr_reported_dob2 = 32 => 0.0267925983,
                                 pk_yr_reported_dob2 = 35 => 0.0228911091,
                                 pk_yr_reported_dob2 = 39 => 0.0190063587,
                                 pk_yr_reported_dob2 = 42 => 0.0153084609,
                                 pk_yr_reported_dob2 = 43 => 0.0106382979,
                                 pk_yr_reported_dob2 = 44 => 0.0144054479,
                                 pk_yr_reported_dob2 = 45 => 0.0131191432,
                                 pk_yr_reported_dob2 = 46 => 0.0119176598,
                                 pk_yr_reported_dob2 = 49 => 0.0131578947,
                                 pk_yr_reported_dob2 = 57 => 0.0109504696,
                                 pk_yr_reported_dob2 = 61 => 0.0088351965,
                                                             0.0077526095);

pk_avm_hit_level_mm_b2 := map(pk_avm_hit_level = -1 => 0.0186838624,
                              pk_avm_hit_level = 0  => 0.0149408217,
                              pk_avm_hit_level = 1  => 0.0150926808,
                                                       0.01427984);

pk_avm_auto_diff2_lvl_mm_b2 := map(pk_avm_auto_diff2_lvl = -2 => 0.0159575722,
                                   pk_avm_auto_diff2_lvl = -1 => 0.0165744036,
                                   pk_avm_auto_diff2_lvl = 0  => 0.0142963187,
                                   pk_avm_auto_diff2_lvl = 1  => 0.0136023855,
                                                                 0.0128584433);

pk_avm_auto_diff4_lvl_mm_b2 := map(pk_avm_auto_diff4_lvl = -1 => 0.0148245214,
                                   pk_avm_auto_diff4_lvl = 0  => 0.0154091392,
                                                                 0.0156566101);

pk_add2_avm_auto_diff2_lvl_mm_b2 := map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0151376778,
                                        pk_add2_avm_auto_diff2_lvl = -2 => 0.0141110066,
                                        pk_add2_avm_auto_diff2_lvl = -1 => 0.0192407696,
                                        pk_add2_avm_auto_diff2_lvl = 0  => 0.0151465531,
                                                                           0.014421151);

pk_avm_confidence_level_mm_b2 := map(pk_avm_confidence_level = 0 => 0.014876737,
                                     pk_avm_confidence_level = 1 => 0.0163109142,
                                     pk_avm_confidence_level = 2 => 0.0155561101,
                                                                    0.0144423643);

pk2_add1_avm_mkt_mm_b2 := map(pk2_add1_avm_mkt = 0 => 0.0293988591,
                              pk2_add1_avm_mkt = 1 => 0.0155169982,
                              pk2_add1_avm_mkt = 2 => 0.0198278111,
                              pk2_add1_avm_mkt = 3 => 0.0125561759,
                                                      0.0100055586);

pk2_add1_avm_pi_mm_b2 := map(pk2_add1_avm_pi = 0 => 0.0066006601,
                             pk2_add1_avm_pi = 1 => 0.0232589771,
                             pk2_add1_avm_pi = 2 => 0.0141016594,
                                                    0.0156509872);

pk2_add1_avm_auto_mm_b2 := map(pk2_add1_avm_auto = 0 => 0.0285714286,
                               pk2_add1_avm_auto = 1 => 0.0325443787,
                               pk2_add1_avm_auto = 2 => 0.0263888889,
                               pk2_add1_avm_auto = 3 => 0.0259691381,
                               pk2_add1_avm_auto = 4 => 0.0172509997,
                               pk2_add1_avm_auto = 5 => 0.0139804488,
                                                        0.0089922784);

pk2_add1_avm_auto2_mm_b2 := map(pk2_add1_avm_auto2 = 0 => 0.0219298246,
                                pk2_add1_avm_auto2 = 1 => 0.0288184438,
                                pk2_add1_avm_auto2 = 2 => 0.0336307481,
                                pk2_add1_avm_auto2 = 3 => 0.0290014684,
                                pk2_add1_avm_auto2 = 4 => 0.0159575722,
                                pk2_add1_avm_auto2 = 5 => 0.0203474536,
                                pk2_add1_avm_auto2 = 6 => 0.0137649196,
                                                          0.0089333192);

pk2_add1_avm_auto3_mm_b2 := map(pk2_add1_avm_auto3 = 0 => 0.0202020202,
                                pk2_add1_avm_auto3 = 1 => 0.0280334728,
                                pk2_add1_avm_auto3 = 2 => 0.0223801066,
                                pk2_add1_avm_auto3 = 3 => 0.0167493337,
                                pk2_add1_avm_auto3 = 4 => 0.0174691095,
                                pk2_add1_avm_auto3 = 5 => 0.0166575142,
                                pk2_add1_avm_auto3 = 6 => 0.0134471287,
                                                          0.00797809);

pk2_add1_avm_med_mm_b2 := map(pk2_add1_avm_med = 0 => 0.0891089109,
                              pk2_add1_avm_med = 1 => 0.0265210608,
                              pk2_add1_avm_med = 2 => 0.0277777778,
                              pk2_add1_avm_med = 3 => 0.0260777009,
                              pk2_add1_avm_med = 4 => 0.0205528559,
                              pk2_add1_avm_med = 5 => 0.0145492336,
                              pk2_add1_avm_med = 6 => 0.0092155009,
                                                      0.0106196982);

pk2_add1_avm_to_med_ratio_mm_b2 := map(pk2_add1_avm_to_med_ratio = 0 => 0.0167125399,
                                       pk2_add1_avm_to_med_ratio = 1 => 0.0155408524,
                                       pk2_add1_avm_to_med_ratio = 2 => 0.0149589621,
                                       pk2_add1_avm_to_med_ratio = 3 => 0.013417594,
                                       pk2_add1_avm_to_med_ratio = 4 => 0.0111817027,
                                                                        0.0109085475);

pk2_add2_avm_sp_mm_b2 := map(pk2_add2_avm_sp = 0 => 0.0234113712,
                             pk2_add2_avm_sp = 1 => 0.0164141414,
                             pk2_add2_avm_sp = 2 => 0.0193955796,
                             pk2_add2_avm_sp = 3 => 0.0150351264,
                             pk2_add2_avm_sp = 4 => 0.0153056934,
                                                    0.014406271);

pk2_add2_avm_ta_mm_b2 := map(pk2_add2_avm_ta = 0 => 0.0210696921,
                             pk2_add2_avm_ta = 1 => 0.0153715449,
                                                    0.0140068128);

pk2_add2_avm_pi_mm_b2 := map(pk2_add2_avm_pi = 0 => 0.0234466589,
                             pk2_add2_avm_pi = 1 => 0.0204275534,
                             pk2_add2_avm_pi = 2 => 0.0149084638,
                             pk2_add2_avm_pi = 3 => 0.0159217457,
                                                    0.0103235747);

pk2_add2_avm_hed_mm_b2 := map(pk2_add2_avm_hed = 0 => 0.0298507463,
                              pk2_add2_avm_hed = 1 => 0.0241486068,
                              pk2_add2_avm_hed = 2 => 0.0202736949,
                              pk2_add2_avm_hed = 3 => 0.0150550087,
                              pk2_add2_avm_hed = 4 => 0.0149253731,
                              pk2_add2_avm_hed = 5 => 0.0151718113,
                                                      0.0072102052);

pk2_add2_avm_auto_mm_b2 := map(pk2_add2_avm_auto = 0 => 0.0224980605,
                               pk2_add2_avm_auto = 1 => 0.0151897139,
                               pk2_add2_avm_auto = 2 => 0.0151829517,
                                                        0.0111906893);

pk2_add2_avm_auto3_mm_b2 := map(pk2_add2_avm_auto3 = 0 => 0.0237258348,
                                pk2_add2_avm_auto3 = 1 => 0.0199288256,
                                pk2_add2_avm_auto3 = 2 => 0.0156600802,
                                pk2_add2_avm_auto3 = 3 => 0.0139781999,
                                                          0.0089224434);

pk2_yr_add1_avm_rec_dt_mm_b2 := map(pk2_yr_add1_avm_recording_date = 0 => 0.0237101933,
                                    pk2_yr_add1_avm_recording_date = 1 => 0.022580236,
                                    pk2_yr_add1_avm_recording_date = 2 => 0.0143771438,
                                    pk2_yr_add1_avm_recording_date = 3 => 0.0132823698,
                                                                          0.0091612699);

pk2_yr_add1_avm_assess_year_mm_b2 := map(pk2_yr_add1_avm_assess_year = 0 => 0.0163185242,
                                         pk2_yr_add1_avm_assess_year = 1 => 0.0139284301,
                                                                            0.016888339);

pk_dist_a1toa2_mm_b2 := map(pk_dist_a1toa2_2 = 0 => 0.0150064098,
                            pk_dist_a1toa2_2 = 1 => 0.0150663637,
                            pk_dist_a1toa2_2 = 2 => 0.0152459683,
                            pk_dist_a1toa2_2 = 3 => 0.0163130276,
                                                    0.0127388535);

pk_dist_a1toa3_mm_b2 := map(pk_dist_a1toa3_2 = 0 => 0.0152471943,
                            pk_dist_a1toa3_2 = 1 => 0.014118172,
                            pk_dist_a1toa3_2 = 2 => 0.0163249142,
                            pk_dist_a1toa3_2 = 3 => 0.0160112607,
                            pk_dist_a1toa3_2 = 4 => 0.0146141855,
                            pk_dist_a1toa3_2 = 5 => 0.0180321443,
                                                    0.0120210368);

pk_rc_disthphoneaddr_mm_b2 := map(pk_rc_disthphoneaddr_2 = 0 => 0.0104933772,
                                  pk_rc_disthphoneaddr_2 = 1 => 0.0140694806,
                                  pk_rc_disthphoneaddr_2 = 2 => 0.0179640719,
                                  pk_rc_disthphoneaddr_2 = 3 => 0.0276461295,
                                                                0.0230095929);

pk_out_st_division_lvl_mm_b2 := map(pk_out_st_division_lvl = -1 => 0.0236220472,
                                    pk_out_st_division_lvl = 0  => 0.0135770235,
                                    pk_out_st_division_lvl = 1  => 0.0133643035,
                                    pk_out_st_division_lvl = 2  => 0.0189337319,
                                    pk_out_st_division_lvl = 3  => 0.0150223305,
                                    pk_out_st_division_lvl = 4  => 0.0181101392,
                                    pk_out_st_division_lvl = 5  => 0.0117469763,
                                    pk_out_st_division_lvl = 6  => 0.0156736199,
                                    pk_out_st_division_lvl = 7  => 0.0185022621,
                                                                   0.0117571612);

pk_wealth_index_mm_b2 := map(pk_wealth_index_2 = 0 => 0.0131856841,
                             pk_wealth_index_2 = 1 => 0.0207236842,
                             pk_wealth_index_2 = 2 => 0.0198967111,
                             pk_wealth_index_2 = 3 => 0.0152343146,
                                                      0.013500576);

pk_attr_num_nonderogs90_b_mm_b2 := map(pk_attr_num_nonderogs90_b = 0  => 0.0304709141,
                                       pk_attr_num_nonderogs90_b = 1  => 0.0302209254,
                                       pk_attr_num_nonderogs90_b = 2  => 0.0261437908,
                                       pk_attr_num_nonderogs90_b = 3  => 0.0148986889,
                                       pk_attr_num_nonderogs90_b = 4  => 0.0161226897,
                                       pk_attr_num_nonderogs90_b = 10 => 0.0127388535,
                                       pk_attr_num_nonderogs90_b = 11 => 0.0163616936,
                                       pk_attr_num_nonderogs90_b = 12 => 0.0131044106,
                                       pk_attr_num_nonderogs90_b = 13 => 0.0125432099,
                                                                         0.0093274988);

pk_ssns_per_addr2_mm_b2 := map(pk_ssns_per_addr2 = -101 => 0.0250839423,
                               pk_ssns_per_addr2 = -2   => 0.0163576881,
                               pk_ssns_per_addr2 = -1   => 0.0110641067,
                               pk_ssns_per_addr2 = 0    => 0.0080085046,
                               pk_ssns_per_addr2 = 1    => 0.0101332482,
                               pk_ssns_per_addr2 = 2    => 0.0100759052,
                               pk_ssns_per_addr2 = 3    => 0.0136232283,
                               pk_ssns_per_addr2 = 4    => 0.0110573601,
                               pk_ssns_per_addr2 = 5    => 0.0148838877,
                               pk_ssns_per_addr2 = 6    => 0.0165576883,
                               pk_ssns_per_addr2 = 7    => 0.0166112957,
                               pk_ssns_per_addr2 = 8    => 0.0197002545,
                               pk_ssns_per_addr2 = 9    => 0.0184771271,
                               pk_ssns_per_addr2 = 10   => 0.0251134154,
                               pk_ssns_per_addr2 = 11   => 0.0255111272,
                               pk_ssns_per_addr2 = 12   => 0.0295930949,
                               pk_ssns_per_addr2 = 100  => 0.0152439024,
                               pk_ssns_per_addr2 = 101  => 0.0185873606,
                               pk_ssns_per_addr2 = 102  => 0.0172299536,
                                                           0.0318118949);

pk_yr_add2_assess_val_yr2_mm_b2 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.0155838867,
                                       pk_yr_add2_assessed_value_year2 = 0  => 0.0294117647,
                                       pk_yr_add2_assessed_value_year2 = 1  => 0.0148013136,
                                                                               0.013034188);

pk_estimated_income_mm_b3 := map(pk_estimated_income = -1 => 0.0928571429,
                                 pk_estimated_income = 0  => 0.1919191919,
                                 pk_estimated_income = 1  => 0.0978135788,
                                 pk_estimated_income = 2  => 0.0790413055,
                                 pk_estimated_income = 3  => 0.0843935539,
                                 pk_estimated_income = 4  => 0.061929337,
                                 pk_estimated_income = 5  => 0.0652248541,
                                 pk_estimated_income = 6  => 0.0570878768,
                                 pk_estimated_income = 7  => 0.056892779,
                                 pk_estimated_income = 8  => 0.0501156515,
                                 pk_estimated_income = 9  => 0.052699784,
                                 pk_estimated_income = 10 => 0.0512315271,
                                 pk_estimated_income = 11 => 0.0572337043,
                                 pk_estimated_income = 12 => 0.0407513531,
                                 pk_estimated_income = 13 => 0.0344827586,
                                 pk_estimated_income = 14 => 0.0482954545,
                                 pk_estimated_income = 15 => 0.042437432,
                                 pk_estimated_income = 16 => 0.0434210526,
                                 pk_estimated_income = 17 => 0.0294985251,
                                 pk_estimated_income = 18 => 0.0441176471,
                                 pk_estimated_income = 19 => 0.0359508042,
                                 pk_estimated_income = 20 => 0.0322519446,
                                 pk_estimated_income = 21 => 0.0199386503,
                                                             0.0218068536);

pk_yr_adl_pr_first_seen2_mm_b3 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.0581015705,
                                      pk_yr_adl_pr_first_seen2 = 0  => 0.013568521,
                                      pk_yr_adl_pr_first_seen2 = 1  => 0.0226487524,
                                      pk_yr_adl_pr_first_seen2 = 2  => 0.0163132137,
                                      pk_yr_adl_pr_first_seen2 = 3  => 0.0194805195,
                                      pk_yr_adl_pr_first_seen2 = 4  => 0.0287474333,
                                      pk_yr_adl_pr_first_seen2 = 5  => 0.0256916996,
                                      pk_yr_adl_pr_first_seen2 = 6  => 0,
                                                                       0);

pk_yr_adl_w_first_seen2_mm_b3 := map(pk_yr_adl_w_first_seen2 = -1 => 0.0532803098,
                                     pk_yr_adl_w_first_seen2 = 0  => 0.0353535354,
                                     pk_yr_adl_w_first_seen2 = 1  => 0.0189003436,
                                                                     0.012987013);

pk_pr_count_mm_b3 := map(pk_pr_count = -1 => 0.0590909091,
                         pk_pr_count = 0  => 0.0223010644,
                         pk_pr_count = 1  => 0.0177944862,
                                             0.0333333333);

pk_addrs_sourced_lvl_mm_b3 := map(pk_addrs_sourced_lvl = 0 => 0.0568916711,
                                  pk_addrs_sourced_lvl = 1 => 0.0214961307,
                                  pk_addrs_sourced_lvl = 2 => 0.0165289256,
                                                              0.0146341463);

pk_naprop_level2_mm_b3 := map(pk_naprop_level2 = -2 => 0.0618578767,
                              pk_naprop_level2 = -1 => 0.0636857872,
                              pk_naprop_level2 = 0  => 0.0445192667,
                              pk_naprop_level2 = 1  => 0.0481434865,
                              pk_naprop_level2 = 2  => 0.0474468393,
                              pk_naprop_level2 = 3  => 0.033045977,
                              pk_naprop_level2 = 4  => 0.0198895028,
                                                       0.0188679245);

pk_add1_purchase_amount2_mm_b3 := map(pk_add1_purchase_amount2 = -1 => 0.0489531025,
                                      pk_add1_purchase_amount2 = 0  => 0.0897713598,
                                                                       0.050383967);

pk_yr_add1_mortgage_date2_mm_b3 := map(pk_yr_add1_mortgage_date2 = -1 => 0.0507089892,
                                       pk_yr_add1_mortgage_date2 = 0  => 0.0716989535,
                                       pk_yr_add1_mortgage_date2 = 1  => 0.055984556,
                                                                         0.049931911);

pk_add1_mortgage_risk_mm_b3 := map(pk_add1_mortgage_risk = -1 => 0.0307692308,
                                   pk_add1_mortgage_risk = 0  => 0.0508009153,
                                   pk_add1_mortgage_risk = 1  => 0.0512589928,
                                   pk_add1_mortgage_risk = 2  => 0.0700676091,
                                                                 0.0780012188);

pk_add1_assessed_amount2_mm_b3 := map(pk_add1_assessed_amount2 = -1 => 0.0493424847,
                                      pk_add1_assessed_amount2 = 0  => 0.1104815864,
                                      pk_add1_assessed_amount2 = 1  => 0.1350931677,
                                      pk_add1_assessed_amount2 = 2  => 0.0977722772,
                                      pk_add1_assessed_amount2 = 3  => 0.0774731824,
                                      pk_add1_assessed_amount2 = 4  => 0.0765931373,
                                      pk_add1_assessed_amount2 = 5  => 0.0639204545,
                                                                       0.0437084601);

pk_yr_add1_mortgage_due_date2_mm_b3 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.0501961174,
                                           pk_yr_add1_mortgage_due_date2 = 0  => 0.0511945392,
                                           pk_yr_add1_mortgage_due_date2 = 1  => 0.0628400435,
                                                                                 0.0741324921);

pk_yr_add1_date_first_seen2_mm_b3 := map(pk_yr_add1_date_first_seen2 = -1 => 0.0929548463,
                                         pk_yr_add1_date_first_seen2 = 0  => 0.070783245,
                                         pk_yr_add1_date_first_seen2 = 1  => 0.0448530436,
                                         pk_yr_add1_date_first_seen2 = 2  => 0.0433673469,
                                         pk_yr_add1_date_first_seen2 = 3  => 0.0361708762,
                                         pk_yr_add1_date_first_seen2 = 4  => 0.0406066536,
                                         pk_yr_add1_date_first_seen2 = 5  => 0.0289315974,
                                         pk_yr_add1_date_first_seen2 = 6  => 0.0257352941,
                                         pk_yr_add1_date_first_seen2 = 7  => 0.0231441048,
                                         pk_yr_add1_date_first_seen2 = 8  => 0.0173633441,
                                         pk_yr_add1_date_first_seen2 = 9  => 0.0088888889,
                                                                             0.0084033613);

pk_add1_land_use_risk_level_mm_b3 := map(pk_add1_land_use_risk_level = 0 => 0.0218978102,
                                         pk_add1_land_use_risk_level = 2 => 0.0594855305,
                                         pk_add1_land_use_risk_level = 3 => 0.0478872064,
                                                                            0.0525378451);

pk_add1_building_area2_mm_b3 := map(pk_add1_building_area2 = -99 => 0.0486328461,
                                    pk_add1_building_area2 = -4  => 0.0749148695,
                                    pk_add1_building_area2 = -3  => 0.0906200318,
                                    pk_add1_building_area2 = -2  => 0.0692805922,
                                    pk_add1_building_area2 = -1  => 0.0478645066,
                                    pk_add1_building_area2 = 0   => 0.044124938,
                                    pk_add1_building_area2 = 1   => 0.0506329114,
                                    pk_add1_building_area2 = 2   => 0.0542168675,
                                    pk_add1_building_area2 = 3   => 0.05,
                                                                    0.0379537954);

pk_add1_no_of_rooms_mm_b3 := map(pk_add1_no_of_rooms = -1 => 0.0513858611,
                                 pk_add1_no_of_rooms = 0  => 0.0698924731,
                                 pk_add1_no_of_rooms = 1  => 0.0684615385,
                                 pk_add1_no_of_rooms = 2  => 0.0711562897,
                                 pk_add1_no_of_rooms = 3  => 0.0652542373,
                                                             0.0458316871);

pk_add1_no_of_baths_mm_b3 := map(pk_add1_no_of_baths = -3 => 0.0483579731,
                                 pk_add1_no_of_baths = -2 => 0.0816728167,
                                 pk_add1_no_of_baths = -1 => 0.063368191,
                                 pk_add1_no_of_baths = 0  => 0.0354963949,
                                 pk_add1_no_of_baths = 1  => 0.0416666667,
                                                             0.0652557319);

pk_property_owned_total_mm_b3 := if(pk_property_owned_total = -1, 0.0527349343, NULL);

pk_prop_own_assess_tot2_mm_b3 := if(pk_prop_own_assess_tot2 = 0, 0.0527349343, NULL);

pk_add2_building_area2_mm_b3 := map(pk_add2_building_area2 = -4 => 0.0521469825,
                                    pk_add2_building_area2 = -3 => 0.0589812332,
                                    pk_add2_building_area2 = -2 => 0.0649606299,
                                    pk_add2_building_area2 = -1 => 0.0577951163,
                                    pk_add2_building_area2 = 0  => 0.0465831166,
                                    pk_add2_building_area2 = 1  => 0.094972067,
                                                                   0.038961039);

pk_add2_no_of_buildings_mm_b3 := map(pk_add2_no_of_buildings = -1 => 0.0524229488,
                                     pk_add2_no_of_buildings = 0  => 0.0537691091,
                                     pk_add2_no_of_buildings = 1  => 0.0617021277,
                                                                     0.0879120879);

pk_add2_garage_type_risk_lvl_mm_b3 := map(pk_add2_garage_type_risk_level = 0 => 0.042115903,
                                          pk_add2_garage_type_risk_level = 1 => 0.0533243334,
                                          pk_add2_garage_type_risk_level = 2 => 0.0630769231,
                                                                                0.0529691501);

pk_add2_parking_no_of_cars_mm_b3 := map(pk_add2_parking_no_of_cars = 0 => 0.0528465782,
                                        pk_add2_parking_no_of_cars = 1 => 0.0500294291,
                                        pk_add2_parking_no_of_cars = 2 => 0.0487098473,
                                                                          0.0717884131);

pk_yr_add2_mortgage_due_date2_mm_b3 := map(pk_yr_add2_mortgage_due_date2 = -1 => 0.0532076908,
                                           pk_yr_add2_mortgage_due_date2 = 0  => 0.0341382182,
                                           pk_yr_add2_mortgage_due_date2 = 1  => 0.0485804416,
                                           pk_yr_add2_mortgage_due_date2 = 2  => 0.0413533835,
                                                                                 0.0582672361);

pk_add2_assessed_amount2_mm_b3 := map(pk_add2_assessed_amount2 = -1 => 0.0515838933,
                                      pk_add2_assessed_amount2 = 0  => 0.0967351874,
                                      pk_add2_assessed_amount2 = 1  => 0.0699755899,
                                      pk_add2_assessed_amount2 = 2  => 0.0686131387,
                                      pk_add2_assessed_amount2 = 3  => 0.0531279472,
                                                                       0.045589106);

pk_yr_add2_date_first_seen2_mm_b3 := map(pk_yr_add2_date_first_seen2 = -1 => 0.0908269318,
                                         pk_yr_add2_date_first_seen2 = 0  => 0.0842201277,
                                         pk_yr_add2_date_first_seen2 = 1  => 0.0561420345,
                                         pk_yr_add2_date_first_seen2 = 2  => 0.0478824876,
                                         pk_yr_add2_date_first_seen2 = 3  => 0.045031816,
                                         pk_yr_add2_date_first_seen2 = 4  => 0.0357622565,
                                         pk_yr_add2_date_first_seen2 = 5  => 0.0367253252,
                                         pk_yr_add2_date_first_seen2 = 6  => 0.0301587302,
                                         pk_yr_add2_date_first_seen2 = 7  => 0.0318379161,
                                         pk_yr_add2_date_first_seen2 = 8  => 0.030149413,
                                         pk_yr_add2_date_first_seen2 = 9  => 0.0304449649,
                                         pk_yr_add2_date_first_seen2 = 10 => 0.0234848485,
                                                                             0.0153256705);

pk_add3_mortgage_risk_mm_b3 := map(pk_add3_mortgage_risk = -1 => 0.1428571429,
                                   pk_add3_mortgage_risk = 0  => 0.0326894502,
                                   pk_add3_mortgage_risk = 1  => 0.0307692308,
                                   pk_add3_mortgage_risk = 2  => 0.0533709102,
                                   pk_add3_mortgage_risk = 3  => 0.0537109375,
                                   pk_add3_mortgage_risk = 4  => 0.05375,
                                                                 0.0365296804);

pk_add3_assessed_amount2_mm_b3 := map(pk_add3_assessed_amount2 = -1 => 0.0538556858,
                                      pk_add3_assessed_amount2 = 0  => 0.0953846154,
                                      pk_add3_assessed_amount2 = 1  => 0.0522565321,
                                      pk_add3_assessed_amount2 = 2  => 0.0473333333,
                                                                       0.0374626523);

pk_yr_add3_date_first_seen2_mm_b3 := map(pk_yr_add3_date_first_seen2 = -1 => 0.0830644608,
                                         pk_yr_add3_date_first_seen2 = 0  => 0.0683760684,
                                         pk_yr_add3_date_first_seen2 = 1  => 0.0520540954,
                                         pk_yr_add3_date_first_seen2 = 2  => 0.0466422466,
                                         pk_yr_add3_date_first_seen2 = 3  => 0.0430839002,
                                         pk_yr_add3_date_first_seen2 = 4  => 0.0377358491,
                                         pk_yr_add3_date_first_seen2 = 5  => 0.0377227171,
                                         pk_yr_add3_date_first_seen2 = 6  => 0.0341679708,
                                         pk_yr_add3_date_first_seen2 = 7  => 0.0273134937,
                                         pk_yr_add3_date_first_seen2 = 8  => 0.0275387263,
                                                                             0.0193281178);

pk_bk_level_mm_b3 := if(pk_bk_level_2 = 0, 0.0527349343, NULL);

pk_eviction_level_mm_b3 := if(pk_eviction_level = 0, 0.0527349343, NULL);

pk_lien_type_level_mm_b3 := if(pk_lien_type_level = 0, 0.0527349343, NULL);

pk_yr_liens_last_unrel_date3_mm_b3 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0527349343, NULL);

pk_yr_criminal_last_date2_mm_b3 := if(pk_yr_criminal_last_date2 = -1, 0.0527349343, NULL);

pk_yr_felony_last_date2_mm_b3 := if(pk_yr_felony_last_date2 = -1, 0.0527349343, NULL);

pk_attr_total_number_derogs_mm_b3 := if(pk_attr_total_number_derogs_4 = 0, 0.0527349343, NULL);

pk_yr_rc_ssnhighissue2_mm_b3 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.0308641975,
                                    pk_yr_rc_ssnhighissue2 = 0  => 0.0358662614,
                                    pk_yr_rc_ssnhighissue2 = 1  => 0.030350438,
                                    pk_yr_rc_ssnhighissue2 = 2  => 0.0425225965,
                                    pk_yr_rc_ssnhighissue2 = 3  => 0.05,
                                    pk_yr_rc_ssnhighissue2 = 4  => 0.1020912743,
                                    pk_yr_rc_ssnhighissue2 = 5  => 0.0628312864,
                                    pk_yr_rc_ssnhighissue2 = 6  => 0.0413743044,
                                    pk_yr_rc_ssnhighissue2 = 7  => 0.0393660532,
                                    pk_yr_rc_ssnhighissue2 = 8  => 0.0442176871,
                                    pk_yr_rc_ssnhighissue2 = 9  => 0.0447324415,
                                    pk_yr_rc_ssnhighissue2 = 10 => 0.0285714286,
                                    pk_yr_rc_ssnhighissue2 = 11 => 0.0264235207,
                                    pk_yr_rc_ssnhighissue2 = 12 => 0.0204962244,
                                    pk_yr_rc_ssnhighissue2 = 13 => 0.0206124853,
                                                                   0.0190930788);

pk_pl_sourced_level_mm_b3 := map(pk_pl_sourced_level = 0 => 0.0545650766,
                                 pk_pl_sourced_level = 1 => 0.0229007634,
                                 pk_pl_sourced_level = 2 => 0.0216362407,
                                                            0.0147239264);

pk_prof_lic_cat_mm_b3 := map(pk_prof_lic_cat = -1 => 0.0542701963,
                             pk_prof_lic_cat = 0  => 0.0258249641,
                             pk_prof_lic_cat = 1  => 0.017167382,
                             pk_prof_lic_cat = 2  => 0.017571885,
                                                     0.0090634441);

pk_add1_lres_mm_b3 := map(pk_add1_lres = -1 => 0.0915181753,
                          pk_add1_lres = 0  => 0.0941609679,
                          pk_add1_lres = 1  => 0.0730619074,
                          pk_add1_lres = 2  => 0.0622059592,
                          pk_add1_lres = 3  => 0.0662460568,
                          pk_add1_lres = 4  => 0.0649451059,
                          pk_add1_lres = 5  => 0.0454705675,
                          pk_add1_lres = 6  => 0.0436017374,
                          pk_add1_lres = 7  => 0.0387524729,
                          pk_add1_lres = 8  => 0.0281936613,
                          pk_add1_lres = 9  => 0.0239605356,
                          pk_add1_lres = 10 => 0.0204398448,
                                               0.0027100271);

pk_add2_lres_mm_b3 := map(pk_add2_lres = -2 => 0.0880542844,
                          pk_add2_lres = -1 => 0.0375757576,
                          pk_add2_lres = 0  => 0.0904449307,
                          pk_add2_lres = 1  => 0.0701024328,
                          pk_add2_lres = 2  => 0.0531156886,
                          pk_add2_lres = 3  => 0.0467422096,
                          pk_add2_lres = 4  => 0.0476036269,
                          pk_add2_lres = 5  => 0.0399395509,
                          pk_add2_lres = 6  => 0.0396430661,
                          pk_add2_lres = 7  => 0.029476787,
                          pk_add2_lres = 8  => 0.0276752768,
                          pk_add2_lres = 9  => 0.0338235294,
                                               0.0294117647);

pk_add3_lres_mm_b3 := map(pk_add3_lres = -2 => 0.0819472326,
                          pk_add3_lres = -1 => 0.0391374797,
                          pk_add3_lres = 0  => 0.0443988195,
                          pk_add3_lres = 1  => 0.041194168,
                          pk_add3_lres = 2  => 0.0407995619,
                          pk_add3_lres = 3  => 0.0260457774,
                          pk_add3_lres = 4  => 0.0360962567,
                          pk_add3_lres = 5  => 0.0364238411,
                                               0.0206896552);

pk_lres_flag_level_mm_b3 := map(pk_lres_flag_level = 0 => 0.0915181753,
                                pk_lres_flag_level = 1 => 0.0724987303,
                                                          0.0401529637);

pk_addrs_5yr_mm_b3 := map(pk_addrs_5yr = 0 => 0.0407881773,
                          pk_addrs_5yr = 1 => 0.0622142715,
                          pk_addrs_5yr = 2 => 0.046750504,
                          pk_addrs_5yr = 3 => 0.0373191165,
                                              0.0260223048);

pk_addrs_15yr_mm_b3 := map(pk_addrs_15yr = 0 => 0.0728185813,
                           pk_addrs_15yr = 1 => 0.0521267628,
                           pk_addrs_15yr = 2 => 0.0319210679,
                                                0.0357142857);

pk_add_lres_month_avg2_mm_b3 := map(pk_add_lres_month_avg2 = -1 => 0.0971370143,
                                    pk_add_lres_month_avg2 = 0  => 0.1726708075,
                                    pk_add_lres_month_avg2 = 1  => 0.1212916776,
                                    pk_add_lres_month_avg2 = 2  => 0.078133783,
                                    pk_add_lres_month_avg2 = 3  => 0.0671342685,
                                    pk_add_lres_month_avg2 = 4  => 0.0552147239,
                                    pk_add_lres_month_avg2 = 5  => 0.0481759955,
                                    pk_add_lres_month_avg2 = 6  => 0.0434404865,
                                    pk_add_lres_month_avg2 = 7  => 0.0461473328,
                                    pk_add_lres_month_avg2 = 8  => 0.0446096654,
                                    pk_add_lres_month_avg2 = 9  => 0.0424231844,
                                    pk_add_lres_month_avg2 = 10 => 0.0355537393,
                                    pk_add_lres_month_avg2 = 11 => 0.0340862423,
                                    pk_add_lres_month_avg2 = 12 => 0.0289855072,
                                    pk_add_lres_month_avg2 = 13 => 0.0257640818,
                                    pk_add_lres_month_avg2 = 15 => 0.0164524422,
                                                                   0.0144425188);

pk_ssns_per_adl_mm_b3 := map(pk_ssns_per_adl = -1 => 0.0870445344,
                             pk_ssns_per_adl = 0  => 0.052637936,
                             pk_ssns_per_adl = 1  => 0.0463292944,
                             pk_ssns_per_adl = 2  => 0.046854083,
                             pk_ssns_per_adl = 3  => 0.0877192982,
                                                     0.275862069);

pk_addrs_per_adl_mm_b3 := map(pk_addrs_per_adl = -6 => 0.0908018868,
                              pk_addrs_per_adl = -5 => 0.0971718637,
                              pk_addrs_per_adl = -4 => 0.0683196335,
                              pk_addrs_per_adl = -3 => 0.0544576197,
                              pk_addrs_per_adl = -2 => 0.0438319774,
                              pk_addrs_per_adl = -1 => 0.0427247078,
                              pk_addrs_per_adl = 0  => 0.0292397661,
                              pk_addrs_per_adl = 1  => 0.0373831776,
                              pk_addrs_per_adl = 2  => 0.0261845387,
                                                       0.035971223);

pk_phones_per_adl_mm_b3 := map(pk_phones_per_adl = -1 => 0.0590928359,
                               pk_phones_per_adl = 0  => 0.0354327371,
                               pk_phones_per_adl = 1  => 0.0394736842,
                                                         0.0489130435);

pk_adlperssn_count_mm_b3 := map(pk_adlperssn_count = -1 => 0.0419161677,
                                pk_adlperssn_count = 0  => 0.0510659395,
                                pk_adlperssn_count = 1  => 0.0568457189,
                                                           0.0627668659);

pk_adls_per_addr_mm_b3 := map(pk_adls_per_addr = -102 => 0.045510695,
                              pk_adls_per_addr = -101 => 0.0176767677,
                              pk_adls_per_addr = -2   => 0.0526315789,
                              pk_adls_per_addr = -1   => 0.0189274448,
                              pk_adls_per_addr = 0    => 0.0168350168,
                              pk_adls_per_addr = 1    => 0.0346045198,
                              pk_adls_per_addr = 2    => 0.0341163311,
                              pk_adls_per_addr = 3    => 0.0451722191,
                              pk_adls_per_addr = 4    => 0.0408614025,
                              pk_adls_per_addr = 5    => 0.0588581519,
                              pk_adls_per_addr = 6    => 0.0550458716,
                              pk_adls_per_addr = 7    => 0.0585831063,
                              pk_adls_per_addr = 8    => 0.0634417129,
                              pk_adls_per_addr = 9    => 0.0769230769,
                              pk_adls_per_addr = 10   => 0.0802192327,
                              pk_adls_per_addr = 11   => 0.0745920746,
                              pk_adls_per_addr = 12   => 0.0840909091,
                              pk_adls_per_addr = 13   => 0.0795892169,
                              pk_adls_per_addr = 100  => 0.037037037,
                              pk_adls_per_addr = 101  => 0.044,
                                                         0.0507430714);

pk_adls_per_phone_mm_b3 := map(pk_adls_per_phone = -2 => 0.0572318161,
                               pk_adls_per_phone = -1 => 0.045155092,
                               pk_adls_per_phone = 0  => 0.0430654459,
                                                         0.0473933649);

pk_ssns_per_adl_c6_mm_b3 := map(pk_ssns_per_adl_c6 = 0 => 0.0441516824,
                                pk_ssns_per_adl_c6 = 1 => 0.07114598,
                                                          0.1070110701);

pk_ssns_per_addr_c6_mm_b3 := map(pk_ssns_per_addr_c6 = 0   => 0.0382062051,
                                 pk_ssns_per_addr_c6 = 1   => 0.0795176182,
                                 pk_ssns_per_addr_c6 = 2   => 0.0914306203,
                                 pk_ssns_per_addr_c6 = 3   => 0.0991735537,
                                 pk_ssns_per_addr_c6 = 4   => 0.1281464531,
                                 pk_ssns_per_addr_c6 = 5   => 0.18125,
                                 pk_ssns_per_addr_c6 = 6   => 0.1386861314,
                                 pk_ssns_per_addr_c6 = 100 => 0.0429864253,
                                 pk_ssns_per_addr_c6 = 101 => 0.0697796432,
                                 pk_ssns_per_addr_c6 = 102 => 0.0771208226,
                                 pk_ssns_per_addr_c6 = 103 => 0.0837209302,
                                                              0.0222222222);

pk_adls_per_phone_c6_mm_b3 := map(pk_adls_per_phone_c6 = 0 => 0.0554771316,
                                  pk_adls_per_phone_c6 = 1 => 0.0488137907,
                                                              0.0234553776);

pk_attr_addrs_last90_mm_b3 := map(pk_attr_addrs_last90 = 0 => 0.0486347514,
                                  pk_attr_addrs_last90 = 1 => 0.07749486,
                                                              0.0809352518);

pk_attr_addrs_last12_mm_b3 := map(pk_attr_addrs_last12 = 0 => 0.0424475051,
                                  pk_attr_addrs_last12 = 1 => 0.0700490055,
                                  pk_attr_addrs_last12 = 2 => 0.0714285714,
                                  pk_attr_addrs_last12 = 3 => 0.0741350906,
                                                              0.09375);

pk_attr_addrs_last24_mm_b3 := map(pk_attr_addrs_last24 = 0 => 0.0409031572,
                                  pk_attr_addrs_last24 = 1 => 0.0642844423,
                                  pk_attr_addrs_last24 = 2 => 0.058016058,
                                  pk_attr_addrs_last24 = 3 => 0.0545868082,
                                  pk_attr_addrs_last24 = 4 => 0.0587618048,
                                                              0.023255814);

pk_ams_class_level_mm_b3 := map(pk_ams_class_level = -1000001 => 0.0504267461,
                                pk_ams_class_level = 0        => 0.2383233533,
                                pk_ams_class_level = 1        => 0.1295843521,
                                pk_ams_class_level = 2        => 0.0859728507,
                                pk_ams_class_level = 3        => 0.0570469799,
                                pk_ams_class_level = 4        => 0.0530679934,
                                pk_ams_class_level = 5        => 0.0308390023,
                                pk_ams_class_level = 6        => 0.0446650124,
                                pk_ams_class_level = 7        => 0.0480109739,
                                pk_ams_class_level = 8        => 0.0439814815,
                                pk_ams_class_level = 1000000  => 0.05,
                                pk_ams_class_level = 1000001  => 0.0459183673,
                                pk_ams_class_level = 1000002  => 0.029787234,
                                pk_ams_class_level = 1000003  => 0.0467836257,
                                pk_ams_class_level = 1000004  => 0.0180995475,
                                                                 0.0084033613);

pk_ams_4yr_college_mm_b3 := map(pk_ams_4yr_college = -1 => 0.060483871,
                                pk_ams_4yr_college = 0  => 0.0548171276,
                                                           0.0253521127);

pk_ams_college_type_mm_b3 := map(pk_ams_college_type = 0 => 0.0548036833,
                                 pk_ams_college_type = 1 => 0.0322778973,
                                                            0.0191815857);

pk_ams_income_level_code_mm_b3 := map(pk_ams_income_level_code = -1 => 0.0504418076,
                                      pk_ams_income_level_code = 0  => 0.1659388646,
                                      pk_ams_income_level_code = 1  => 0.1100917431,
                                      pk_ams_income_level_code = 2  => 0.0648826979,
                                      pk_ams_income_level_code = 3  => 0.0632090762,
                                      pk_ams_income_level_code = 4  => 0.0547080484,
                                      pk_ams_income_level_code = 5  => 0.0470479705,
                                                                       0.0359012715);

pk_yr_in_dob2_mm_b3 := map(pk_yr_in_dob2 = 19 => 0.2657828283,
                           pk_yr_in_dob2 = 20 => 0.1960264901,
                           pk_yr_in_dob2 = 21 => 0.1273192578,
                           pk_yr_in_dob2 = 22 => 0.0904845301,
                           pk_yr_in_dob2 = 23 => 0.0569230769,
                           pk_yr_in_dob2 = 25 => 0.0500488281,
                           pk_yr_in_dob2 = 29 => 0.035126957,
                           pk_yr_in_dob2 = 35 => 0.0373947499,
                           pk_yr_in_dob2 = 38 => 0.036101083,
                           pk_yr_in_dob2 = 41 => 0.0348932677,
                           pk_yr_in_dob2 = 42 => 0.0381991814,
                           pk_yr_in_dob2 = 43 => 0.0324483776,
                           pk_yr_in_dob2 = 44 => 0.0317241379,
                           pk_yr_in_dob2 = 45 => 0.0409026798,
                           pk_yr_in_dob2 = 47 => 0.0296950241,
                           pk_yr_in_dob2 = 49 => 0.0355630821,
                           pk_yr_in_dob2 = 57 => 0.0270018622,
                           pk_yr_in_dob2 = 61 => 0.0226,
                                                 0.0226);

pk_yr_ams_dob2_mm_b3 := map(pk_yr_ams_dob2 = -1 => 0.0493479196,
                            pk_yr_ams_dob2 = 20 => 0.239157373,
                            pk_yr_ams_dob2 = 22 => 0.1142857143,
                            pk_yr_ams_dob2 = 23 => 0.0472027972,
                            pk_yr_ams_dob2 = 32 => 0.038,
                            pk_yr_ams_dob2 = 43 => 0.038,
                                                   0.038);

pk_inferred_age_mm_b3 := map(pk_inferred_age = -1 => 0.0476190476,
                             pk_inferred_age = 18 => 0.1572580645,
                             pk_inferred_age = 19 => 0.1164685908,
                             pk_inferred_age = 20 => 0.0916334661,
                             pk_inferred_age = 21 => 0.0726788432,
                             pk_inferred_age = 22 => 0.0601667271,
                             pk_inferred_age = 24 => 0.049359097,
                             pk_inferred_age = 34 => 0.0399156255,
                             pk_inferred_age = 37 => 0.0374032674,
                             pk_inferred_age = 41 => 0.0316529894,
                             pk_inferred_age = 42 => 0.0336879433,
                             pk_inferred_age = 43 => 0.0318791946,
                             pk_inferred_age = 44 => 0.037366548,
                             pk_inferred_age = 46 => 0.023,
                             pk_inferred_age = 48 => 0.0265306122,
                             pk_inferred_age = 52 => 0.0250652742,
                             pk_inferred_age = 56 => 0.021,
                             pk_inferred_age = 61 => 0.021,
                                                     0.021);

pk_yr_reported_dob2_mm_b3 := map(pk_yr_reported_dob2 = -1 => 0.0793301936,
                                 pk_yr_reported_dob2 = 19 => 0.2396313364,
                                 pk_yr_reported_dob2 = 21 => 0.1510015408,
                                 pk_yr_reported_dob2 = 22 => 0.1038961039,
                                 pk_yr_reported_dob2 = 23 => 0.0589285714,
                                 pk_yr_reported_dob2 = 32 => 0.0354544405,
                                 pk_yr_reported_dob2 = 35 => 0.0352655047,
                                 pk_yr_reported_dob2 = 39 => 0.0306704708,
                                 pk_yr_reported_dob2 = 42 => 0.0325770797,
                                 pk_yr_reported_dob2 = 43 => 0.0320150659,
                                 pk_yr_reported_dob2 = 44 => 0.0335689046,
                                 pk_yr_reported_dob2 = 45 => 0.0394736842,
                                 pk_yr_reported_dob2 = 46 => 0.0167714885,
                                 pk_yr_reported_dob2 = 49 => 0.0268780152,
                                 pk_yr_reported_dob2 = 57 => 0.0235587583,
                                 pk_yr_reported_dob2 = 61 => 0.021,
                                                             0.021);

pk_avm_hit_level_mm_b3 := map(pk_avm_hit_level = -1 => 0.0496644295,
                              pk_avm_hit_level = 0  => 0.0471694448,
                              pk_avm_hit_level = 1  => 0.066772655,
                                                       0.0571428571);

pk_avm_auto_diff2_lvl_mm_b3 := map(pk_avm_auto_diff2_lvl = -2 => 0.0475927594,
                                   pk_avm_auto_diff2_lvl = -1 => 0.066139468,
                                   pk_avm_auto_diff2_lvl = 0  => 0.068059816,
                                   pk_avm_auto_diff2_lvl = 1  => 0.0626196336,
                                                                 0.0562192551);

pk_avm_auto_diff4_lvl_mm_b3 := map(pk_avm_auto_diff4_lvl = -1 => 0.0513511545,
                                   pk_avm_auto_diff4_lvl = 0  => 0.0666782428,
                                                                 0.0407216495);

pk_add2_avm_auto_diff2_lvl_mm_b3 := map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0525997748,
                                        pk_add2_avm_auto_diff2_lvl = -2 => 0.0563991323,
                                        pk_add2_avm_auto_diff2_lvl = -1 => 0.0513833992,
                                        pk_add2_avm_auto_diff2_lvl = 0  => 0.0595211948,
                                                                           0.0481985588);

pk_avm_confidence_level_mm_b3 := map(pk_avm_confidence_level = 0 => 0.053122021,
                                     pk_avm_confidence_level = 1 => 0.0453333333,
                                     pk_avm_confidence_level = 2 => 0.0566666667,
                                                                    0.0370898716);

pk2_add1_avm_mkt_mm_b3 := map(pk2_add1_avm_mkt = 0 => 0.1261538462,
                              pk2_add1_avm_mkt = 1 => 0.0500930665,
                              pk2_add1_avm_mkt = 2 => 0.0932971014,
                              pk2_add1_avm_mkt = 3 => 0.0607123583,
                                                      0.033632287);

pk2_add1_avm_pi_mm_b3 := map(pk2_add1_avm_pi = 0 => 0.1578947368,
                             pk2_add1_avm_pi = 1 => 0.1055389222,
                             pk2_add1_avm_pi = 2 => 0.0513184982,
                                                    0.0499327254);

pk2_add1_avm_auto_mm_b3 := map(pk2_add1_avm_auto = 0 => 0.1807228916,
                               pk2_add1_avm_auto = 1 => 0.130044843,
                               pk2_add1_avm_auto = 2 => 0.1042253521,
                               pk2_add1_avm_auto = 3 => 0.1118530885,
                               pk2_add1_avm_auto = 4 => 0.0496664838,
                               pk2_add1_avm_auto = 5 => 0.0583973849,
                                                        0.0292362768);

pk2_add1_avm_auto2_mm_b3 := map(pk2_add1_avm_auto2 = 0 => 0.1971830986,
                                pk2_add1_avm_auto2 = 1 => 0.119047619,
                                pk2_add1_avm_auto2 = 2 => 0.135501355,
                                pk2_add1_avm_auto2 = 3 => 0.1098265896,
                                pk2_add1_avm_auto2 = 4 => 0.0475927594,
                                pk2_add1_avm_auto2 = 5 => 0.0894774517,
                                pk2_add1_avm_auto2 = 6 => 0.060094077,
                                                          0.0289367429);

pk2_add1_avm_auto3_mm_b3 := map(pk2_add1_avm_auto3 = 0 => 0.12,
                                pk2_add1_avm_auto3 = 1 => 0.1232394366,
                                pk2_add1_avm_auto3 = 2 => 0.1113138686,
                                pk2_add1_avm_auto3 = 3 => 0.0496274504,
                                pk2_add1_avm_auto3 = 4 => 0.0844645551,
                                pk2_add1_avm_auto3 = 5 => 0.0939597315,
                                pk2_add1_avm_auto3 = 6 => 0.0537497098,
                                                          0.0337941628);

pk2_add1_avm_med_mm_b3 := map(pk2_add1_avm_med = 0 => 0.2,
                              pk2_add1_avm_med = 1 => 0.1632047478,
                              pk2_add1_avm_med = 2 => 0.1260273973,
                              pk2_add1_avm_med = 3 => 0.0856291884,
                              pk2_add1_avm_med = 4 => 0.0783561644,
                              pk2_add1_avm_med = 5 => 0.0510474199,
                              pk2_add1_avm_med = 6 => 0.0341997264,
                                                      0.0381993182);

pk2_add1_avm_to_med_ratio_mm_b3 := map(pk2_add1_avm_to_med_ratio = 0 => 0.0491324658,
                                       pk2_add1_avm_to_med_ratio = 1 => 0.0642136667,
                                       pk2_add1_avm_to_med_ratio = 2 => 0.0610079576,
                                       pk2_add1_avm_to_med_ratio = 3 => 0.0622881356,
                                       pk2_add1_avm_to_med_ratio = 4 => 0.0655526992,
                                                                        0.0534883721);

pk2_add2_avm_sp_mm_b3 := map(pk2_add2_avm_sp = 0 => 0.0917874396,
                             pk2_add2_avm_sp = 1 => 0.1094224924,
                             pk2_add2_avm_sp = 2 => 0.0537897311,
                             pk2_add2_avm_sp = 3 => 0.0527054651,
                             pk2_add2_avm_sp = 4 => 0.062254902,
                                                    0.0441676104);

pk2_add2_avm_ta_mm_b3 := map(pk2_add2_avm_ta = 0 => 0.1017964072,
                             pk2_add2_avm_ta = 1 => 0.053402154,
                                                    0.047492125);

pk2_add2_avm_pi_mm_b3 := map(pk2_add2_avm_pi = 0 => 0.1146496815,
                             pk2_add2_avm_pi = 1 => 0.0957746479,
                             pk2_add2_avm_pi = 2 => 0.0522312373,
                             pk2_add2_avm_pi = 3 => 0.0548485392,
                                                    0.0412147505);

pk2_add2_avm_hed_mm_b3 := map(pk2_add2_avm_hed = 0 => 0.1379310345,
                              pk2_add2_avm_hed = 1 => 0.1246105919,
                              pk2_add2_avm_hed = 2 => 0.0539083558,
                              pk2_add2_avm_hed = 3 => 0.0524970608,
                              pk2_add2_avm_hed = 4 => 0.0727091633,
                              pk2_add2_avm_hed = 5 => 0.0508400927,
                                                      0.0318302387);

pk2_add2_avm_auto_mm_b3 := map(pk2_add2_avm_auto = 0 => 0.1211498973,
                               pk2_add2_avm_auto = 1 => 0.0529234845,
                               pk2_add2_avm_auto = 2 => 0.0534343331,
                                                        0.0330682294);

pk2_add2_avm_auto3_mm_b3 := map(pk2_add2_avm_auto3 = 0 => 0.0982142857,
                                pk2_add2_avm_auto3 = 1 => 0.1060606061,
                                pk2_add2_avm_auto3 = 2 => 0.0535798584,
                                pk2_add2_avm_auto3 = 3 => 0.0487315011,
                                                          0.0297029703);

pk2_yr_add1_avm_rec_dt_mm_b3 := map(pk2_yr_add1_avm_recording_date = 0 => 0.0633445946,
                                    pk2_yr_add1_avm_recording_date = 1 => 0.074015748,
                                    pk2_yr_add1_avm_recording_date = 2 => 0.0502227623,
                                    pk2_yr_add1_avm_recording_date = 3 => 0.0589579525,
                                                                          0.067251462);

pk2_yr_add1_avm_assess_year_mm_b3 := map(pk2_yr_add1_avm_assess_year = 0 => 0.0485245363,
                                         pk2_yr_add1_avm_assess_year = 1 => 0.0654587348,
                                                                            0.06406195);

pk_dist_a1toa2_mm_b3 := map(pk_dist_a1toa2_2 = 0 => 0.0463868455,
                            pk_dist_a1toa2_2 = 1 => 0.0444768502,
                            pk_dist_a1toa2_2 = 2 => 0.0545984292,
                            pk_dist_a1toa2_2 = 3 => 0.0516883117,
                                                    0.0873786408);

pk_dist_a1toa3_mm_b3 := map(pk_dist_a1toa3_2 = 0 => 0.0403151674,
                            pk_dist_a1toa3_2 = 1 => 0.0371644873,
                            pk_dist_a1toa3_2 = 2 => 0.0431228285,
                            pk_dist_a1toa3_2 = 3 => 0.0510062457,
                            pk_dist_a1toa3_2 = 4 => 0.0535279805,
                            pk_dist_a1toa3_2 = 5 => 0.0292983809,
                                                    0.0814930902);

pk_rc_disthphoneaddr_mm_b3 := map(pk_rc_disthphoneaddr_2 = 0 => 0.0437919881,
                                  pk_rc_disthphoneaddr_2 = 1 => 0.0463386728,
                                  pk_rc_disthphoneaddr_2 = 2 => 0.0582524272,
                                  pk_rc_disthphoneaddr_2 = 3 => 0.0532687651,
                                                                0.0584778959);

pk_out_st_division_lvl_mm_b3 := map(pk_out_st_division_lvl = -1 => 0.0776255708,
                                    pk_out_st_division_lvl = 0  => 0.040923825,
                                    pk_out_st_division_lvl = 1  => 0.0566936109,
                                    pk_out_st_division_lvl = 2  => 0.0508697079,
                                    pk_out_st_division_lvl = 3  => 0.0767045455,
                                    pk_out_st_division_lvl = 4  => 0.0645101664,
                                    pk_out_st_division_lvl = 5  => 0.0408342656,
                                    pk_out_st_division_lvl = 6  => 0.0509955594,
                                    pk_out_st_division_lvl = 7  => 0.065652522,
                                                                   0.0478210567);

pk_wealth_index_mm_b3 := map(pk_wealth_index_2 = 0 => 0.0523996796,
                             pk_wealth_index_2 = 1 => 0.0948905109,
                             pk_wealth_index_2 = 2 => 0.0632945632,
                             pk_wealth_index_2 = 3 => 0.0434743148,
                                                      0.0186839968);

pk_attr_num_nonderogs90_b_mm_b3 := map(pk_attr_num_nonderogs90_b = 0  => 0.1065292096,
                                       pk_attr_num_nonderogs90_b = 1  => 0.0844470554,
                                       pk_attr_num_nonderogs90_b = 2  => 0.0510132774,
                                       pk_attr_num_nonderogs90_b = 3  => 0.0302114804,
                                       pk_attr_num_nonderogs90_b = 4  => 0.027027027,
                                       pk_attr_num_nonderogs90_b = 10 => 0.1126760563,
                                       pk_attr_num_nonderogs90_b = 11 => 0.0553917439,
                                       pk_attr_num_nonderogs90_b = 12 => 0.0312296075,
                                       pk_attr_num_nonderogs90_b = 13 => 0.0169276344,
                                                                         0.0130718954);

pk_ssns_per_addr2_mm_b3 := map(pk_ssns_per_addr2 = -101 => 0.0447228312,
                               pk_ssns_per_addr2 = -2   => 0.0256410256,
                               pk_ssns_per_addr2 = -1   => 0.0230263158,
                               pk_ssns_per_addr2 = 0    => 0.0124666073,
                               pk_ssns_per_addr2 = 1    => 0.0379537954,
                               pk_ssns_per_addr2 = 2    => 0.0348984772,
                               pk_ssns_per_addr2 = 3    => 0.0431565968,
                               pk_ssns_per_addr2 = 4    => 0.0397268777,
                               pk_ssns_per_addr2 = 5    => 0.0587833219,
                               pk_ssns_per_addr2 = 6    => 0.0496311201,
                               pk_ssns_per_addr2 = 7    => 0.0626545754,
                               pk_ssns_per_addr2 = 8    => 0.0628348758,
                               pk_ssns_per_addr2 = 9    => 0.0884638374,
                               pk_ssns_per_addr2 = 10   => 0.0746777862,
                               pk_ssns_per_addr2 = 11   => 0.0865269461,
                               pk_ssns_per_addr2 = 12   => 0.0613810742,
                               pk_ssns_per_addr2 = 100  => 0.0505836576,
                               pk_ssns_per_addr2 = 101  => 0.0362173038,
                               pk_ssns_per_addr2 = 102  => 0.0485714286,
                                                           0.0538131397);

pk_yr_add2_assess_val_yr2_mm_b3 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.0535803863,
                                       pk_yr_add2_assessed_value_year2 = 0  => 0.04375,
                                       pk_yr_add2_assessed_value_year2 = 1  => 0.0506041222,
                                                                               0.0543478261);

pk_estimated_income_mm_b4 := map(pk_estimated_income = -1 => 0.0671936759,
                                 pk_estimated_income = 0  => 0.1136363636,
                                 pk_estimated_income = 1  => 0.1001964637,
                                 pk_estimated_income = 2  => 0.0906801008,
                                 pk_estimated_income = 3  => 0.1089670829,
                                 pk_estimated_income = 4  => 0.0781499203,
                                 pk_estimated_income = 5  => 0.0738544474,
                                 pk_estimated_income = 6  => 0.0698065601,
                                 pk_estimated_income = 7  => 0.0508108108,
                                 pk_estimated_income = 8  => 0.0447574335,
                                 pk_estimated_income = 9  => 0.0411931818,
                                 pk_estimated_income = 10 => 0.0367534456,
                                 pk_estimated_income = 11 => 0.0296567811,
                                 pk_estimated_income = 12 => 0.0303094085,
                                 pk_estimated_income = 13 => 0.0271769273,
                                 pk_estimated_income = 14 => 0.0240549828,
                                 pk_estimated_income = 15 => 0.0204241948,
                                 pk_estimated_income = 16 => 0.0205992509,
                                 pk_estimated_income = 17 => 0.037037037,
                                 pk_estimated_income = 18 => 0.0189798339,
                                 pk_estimated_income = 19 => 0.0265428003,
                                 pk_estimated_income = 20 => 0.0211764706,
                                 pk_estimated_income = 21 => 0.0164835165,
                                                             0);

pk_yr_adl_pr_first_seen2_mm_b4 := map(pk_yr_adl_pr_first_seen2 = -1 => 0.0447378267,
                                      pk_yr_adl_pr_first_seen2 = 0  => 0.0292397661,
                                      pk_yr_adl_pr_first_seen2 = 1  => 0.0166890983,
                                      pk_yr_adl_pr_first_seen2 = 2  => 0.0144107051,
                                      pk_yr_adl_pr_first_seen2 = 3  => 0.0173139916,
                                      pk_yr_adl_pr_first_seen2 = 4  => 0.010230179,
                                      pk_yr_adl_pr_first_seen2 = 5  => 0.0092748735,
                                      pk_yr_adl_pr_first_seen2 = 6  => 0.0180722892,
                                                                       0);

pk_yr_adl_w_first_seen2_mm_b4 := map(pk_yr_adl_w_first_seen2 = -1 => 0.0393376994,
                                     pk_yr_adl_w_first_seen2 = 0  => 0.0260416667,
                                     pk_yr_adl_w_first_seen2 = 1  => 0.0147058824,
                                                                     0.0044052863);

pk_pr_count_mm_b4 := map(pk_pr_count = -1 => 0.0449878411,
                         pk_pr_count = 0  => 0.0148809524,
                         pk_pr_count = 1  => 0.016897816,
                                             0);

pk_addrs_sourced_lvl_mm_b4 := map(pk_addrs_sourced_lvl = 0 => 0.0426217321,
                                  pk_addrs_sourced_lvl = 1 => 0.0186421174,
                                  pk_addrs_sourced_lvl = 2 => 0.0093873518,
                                                              0.015625);

pk_naprop_level2_mm_b4 := map(pk_naprop_level2 = -1 => 0.0457578646,
                              pk_naprop_level2 = 0  => 0.0483042138,
                              pk_naprop_level2 = 2  => 0.0373181265,
                              pk_naprop_level2 = 3  => 0.0418574615,
                              pk_naprop_level2 = 4  => 0.0277900309,
                                                       0.0173253925);

pk_add1_purchase_amount2_mm_b4 := map(pk_add1_purchase_amount2 = -1 => 0.0377617476,
                                      pk_add1_purchase_amount2 = 0  => 0.0513508335,
                                                                       0.032527881);

pk_yr_add1_mortgage_date2_mm_b4 := map(pk_yr_add1_mortgage_date2 = -1 => 0.0371024735,
                                       pk_yr_add1_mortgage_date2 = 0  => 0.0496802755,
                                       pk_yr_add1_mortgage_date2 = 1  => 0.0569343066,
                                                                         0.0313024036);

pk_add1_mortgage_risk_mm_b4 := map(pk_add1_mortgage_risk = -1 => 0,
                                   pk_add1_mortgage_risk = 0  => 0.0297067901,
                                   pk_add1_mortgage_risk = 1  => 0.0375044061,
                                   pk_add1_mortgage_risk = 2  => 0.0493398193,
                                                                 0.0662116041);

pk_add1_assessed_amount2_mm_b4 := map(pk_add1_assessed_amount2 = -1 => 0.0376724238,
                                      pk_add1_assessed_amount2 = 0  => 0.0710059172,
                                      pk_add1_assessed_amount2 = 1  => 0.0910623946,
                                      pk_add1_assessed_amount2 = 2  => 0.0466970387,
                                      pk_add1_assessed_amount2 = 3  => 0.0580952381,
                                      pk_add1_assessed_amount2 = 4  => 0.0469625162,
                                      pk_add1_assessed_amount2 = 5  => 0.0358208955,
                                                                       0.0283097419);

pk_yr_add1_mortgage_due_date2_mm_b4 := map(pk_yr_add1_mortgage_due_date2 = -1 => 0.0369567956,
                                           pk_yr_add1_mortgage_due_date2 = 0  => 0.0289519398,
                                           pk_yr_add1_mortgage_due_date2 = 1  => 0.0436187399,
                                                                                 0.0552523874);

pk_yr_add1_date_first_seen2_mm_b4 := map(pk_yr_add1_date_first_seen2 = -1 => 0.077467344,
                                         pk_yr_add1_date_first_seen2 = 0  => 0.0785528031,
                                         pk_yr_add1_date_first_seen2 = 1  => 0.0444850701,
                                         pk_yr_add1_date_first_seen2 = 2  => 0.0397504044,
                                         pk_yr_add1_date_first_seen2 = 3  => 0.0338548346,
                                         pk_yr_add1_date_first_seen2 = 4  => 0.0279053338,
                                         pk_yr_add1_date_first_seen2 = 5  => 0.0197459265,
                                         pk_yr_add1_date_first_seen2 = 6  => 0.0200856108,
                                         pk_yr_add1_date_first_seen2 = 7  => 0.0142512077,
                                         pk_yr_add1_date_first_seen2 = 8  => 0.012516469,
                                         pk_yr_add1_date_first_seen2 = 9  => 0.0094228504,
                                                                             0.0114155251);

pk_add1_land_use_risk_level_mm_b4 := map(pk_add1_land_use_risk_level = 0 => 0.0144230769,
                                         pk_add1_land_use_risk_level = 2 => 0.037613147,
                                         pk_add1_land_use_risk_level = 3 => 0.0386567588,
                                                                            0.0631578947);

pk_add1_building_area2_mm_b4 := map(pk_add1_building_area2 = -99 => 0.0377015596,
                                    pk_add1_building_area2 = -4  => 0.0654205607,
                                    pk_add1_building_area2 = -3  => 0.0378787879,
                                    pk_add1_building_area2 = -2  => 0.0445663011,
                                    pk_add1_building_area2 = -1  => 0.0321110421,
                                    pk_add1_building_area2 = 0   => 0.0227408737,
                                    pk_add1_building_area2 = 1   => 0.0212765957,
                                    pk_add1_building_area2 = 2   => 0,
                                    pk_add1_building_area2 = 3   => 0.023255814,
                                                                    0.0769230769);

pk_add1_no_of_rooms_mm_b4 := map(pk_add1_no_of_rooms = -1 => 0.0379126677,
                                 pk_add1_no_of_rooms = 0  => 0.0449438202,
                                 pk_add1_no_of_rooms = 1  => 0.0453869048,
                                 pk_add1_no_of_rooms = 2  => 0.0489755122,
                                 pk_add1_no_of_rooms = 3  => 0.0391095066,
                                                             0.0316913538);

pk_add1_no_of_baths_mm_b4 := map(pk_add1_no_of_baths = -3 => 0.0379903477,
                                 pk_add1_no_of_baths = -2 => 0.0476286579,
                                 pk_add1_no_of_baths = -1 => 0.0376034094,
                                 pk_add1_no_of_baths = 0  => 0.0286738351,
                                 pk_add1_no_of_baths = 1  => 0.0219123506,
                                                             0.025974026);

pk_property_owned_total_mm_b4 := if(pk_property_owned_total = -1, 0.0382999085, NULL);

pk_prop_own_assess_tot2_mm_b4 := if(pk_prop_own_assess_tot2 = 0, 0.0382999085, NULL);

pk_add2_building_area2_mm_b4 := map(pk_add2_building_area2 = -4 => 0.0399885,
                                    pk_add2_building_area2 = -3 => 0.05,
                                    pk_add2_building_area2 = -2 => 0.0441860465,
                                    pk_add2_building_area2 = -1 => 0.0316733797,
                                    pk_add2_building_area2 = 0  => 0.0280121498,
                                    pk_add2_building_area2 = 1  => 0.0353982301,
                                                                   0.0188087774);

pk_add2_no_of_buildings_mm_b4 := map(pk_add2_no_of_buildings = -1 => 0.0386523121,
                                     pk_add2_no_of_buildings = 0  => 0.0341858038,
                                     pk_add2_no_of_buildings = 1  => 0.04,
                                                                     0.0322580645);

pk_add2_garage_type_risk_lvl_mm_b4 := map(pk_add2_garage_type_risk_level = 0 => 0.030923527,
                                          pk_add2_garage_type_risk_level = 1 => 0.0217281455,
                                          pk_add2_garage_type_risk_level = 2 => 0.0384130982,
                                                                                0.0394936829);

pk_add2_parking_no_of_cars_mm_b4 := map(pk_add2_parking_no_of_cars = 0 => 0.03931517,
                                        pk_add2_parking_no_of_cars = 1 => 0.0309667674,
                                        pk_add2_parking_no_of_cars = 2 => 0.0286983259,
                                                                          0.0290964778);

pk_yr_add2_mortgage_due_date2_mm_b4 := map(pk_yr_add2_mortgage_due_date2 = -1 => 0.0393947178,
                                           pk_yr_add2_mortgage_due_date2 = 0  => 0.0380047506,
                                           pk_yr_add2_mortgage_due_date2 = 1  => 0.022913257,
                                           pk_yr_add2_mortgage_due_date2 = 2  => 0.0248062016,
                                                                                 0.0307570978);

pk_add2_assessed_amount2_mm_b4 := map(pk_add2_assessed_amount2 = -1 => 0.0394961518,
                                      pk_add2_assessed_amount2 = 0  => 0.0536912752,
                                      pk_add2_assessed_amount2 = 1  => 0.0403348554,
                                      pk_add2_assessed_amount2 = 2  => 0.0228898426,
                                      pk_add2_assessed_amount2 = 3  => 0.0271234832,
                                                                       0.0266666667);

pk_yr_add2_date_first_seen2_mm_b4 := map(pk_yr_add2_date_first_seen2 = -1 => 0.0649003674,
                                         pk_yr_add2_date_first_seen2 = 0  => 0.0652714463,
                                         pk_yr_add2_date_first_seen2 = 1  => 0.0481955231,
                                         pk_yr_add2_date_first_seen2 = 2  => 0.0390726752,
                                         pk_yr_add2_date_first_seen2 = 3  => 0.0361694798,
                                         pk_yr_add2_date_first_seen2 = 4  => 0.0286989796,
                                         pk_yr_add2_date_first_seen2 = 5  => 0.0232463295,
                                         pk_yr_add2_date_first_seen2 = 6  => 0.025560772,
                                         pk_yr_add2_date_first_seen2 = 7  => 0.0227670753,
                                         pk_yr_add2_date_first_seen2 = 8  => 0.0192848534,
                                         pk_yr_add2_date_first_seen2 = 9  => 0.0149892934,
                                         pk_yr_add2_date_first_seen2 = 10 => 0.0155073106,
                                                                             0.009194159);

pk_add3_mortgage_risk_mm_b4 := map(pk_add3_mortgage_risk = -1 => 0,
                                   pk_add3_mortgage_risk = 0  => 0.0275027503,
                                   pk_add3_mortgage_risk = 1  => 0.037037037,
                                   pk_add3_mortgage_risk = 2  => 0.0385636839,
                                   pk_add3_mortgage_risk = 3  => 0.0350140056,
                                   pk_add3_mortgage_risk = 4  => 0.0425531915,
                                                                 0.0253164557);

pk_add3_assessed_amount2_mm_b4 := map(pk_add3_assessed_amount2 = -1 => 0.0396726183,
                                      pk_add3_assessed_amount2 = 0  => 0.0355555556,
                                      pk_add3_assessed_amount2 = 1  => 0.0343249428,
                                      pk_add3_assessed_amount2 = 2  => 0.023239918,
                                                                       0.0277777778);

pk_yr_add3_date_first_seen2_mm_b4 := map(pk_yr_add3_date_first_seen2 = -1 => 0.0601758794,
                                         pk_yr_add3_date_first_seen2 = 0  => 0.067651633,
                                         pk_yr_add3_date_first_seen2 = 1  => 0.0474100088,
                                         pk_yr_add3_date_first_seen2 = 2  => 0.0352303523,
                                         pk_yr_add3_date_first_seen2 = 3  => 0.0342105263,
                                         pk_yr_add3_date_first_seen2 = 4  => 0.0374796306,
                                         pk_yr_add3_date_first_seen2 = 5  => 0.0293124616,
                                         pk_yr_add3_date_first_seen2 = 6  => 0.022236756,
                                         pk_yr_add3_date_first_seen2 = 7  => 0.0186072738,
                                         pk_yr_add3_date_first_seen2 = 8  => 0.0138121547,
                                                                             0.0113573407);

pk_bk_level_mm_b4 := if(pk_bk_level_2 = 0, 0.0382999085, NULL);

pk_eviction_level_mm_b4 := if(pk_eviction_level = 0, 0.0382999085, NULL);

pk_lien_type_level_mm_b4 := if(pk_lien_type_level = 0, 0.0382999085, NULL);

pk_yr_liens_last_unrel_date3_mm_b4 := if((integer)pk_yr_liens_last_unrel_date3_2 = -1, 0.0382999085, NULL);

pk_yr_criminal_last_date2_mm_b4 := if(pk_yr_criminal_last_date2 = -1, 0.0382999085, NULL);

pk_yr_felony_last_date2_mm_b4 := if(pk_yr_felony_last_date2 = -1, 0.0382999085, NULL);

pk_attr_total_number_derogs_mm_b4 := if(pk_attr_total_number_derogs_4 = 0, 0.0382999085, NULL);

pk_yr_rc_ssnhighissue2_mm_b4 := map(pk_yr_rc_ssnhighissue2 = -1 => 0.0520833333,
                                    pk_yr_rc_ssnhighissue2 = 0  => 0.0276923077,
                                    pk_yr_rc_ssnhighissue2 = 1  => 0.038071066,
                                    pk_yr_rc_ssnhighissue2 = 2  => 0.0438292964,
                                    pk_yr_rc_ssnhighissue2 = 3  => 0.0542264753,
                                    pk_yr_rc_ssnhighissue2 = 4  => 0.0780820523,
                                    pk_yr_rc_ssnhighissue2 = 5  => 0.0459493671,
                                    pk_yr_rc_ssnhighissue2 = 6  => 0.0354501403,
                                    pk_yr_rc_ssnhighissue2 = 7  => 0.0318825911,
                                    pk_yr_rc_ssnhighissue2 = 8  => 0.0295829292,
                                    pk_yr_rc_ssnhighissue2 = 9  => 0.026026026,
                                    pk_yr_rc_ssnhighissue2 = 10 => 0.0204930205,
                                    pk_yr_rc_ssnhighissue2 = 11 => 0.0144495413,
                                    pk_yr_rc_ssnhighissue2 = 12 => 0.0118343195,
                                    pk_yr_rc_ssnhighissue2 = 13 => 0.0098142306,
                                                                   0.0102205487);

pk_pl_sourced_level_mm_b4 := map(pk_pl_sourced_level = 0 => 0.040032295,
                                 pk_pl_sourced_level = 1 => 0.0197368421,
                                 pk_pl_sourced_level = 2 => 0.0179472799,
                                                            0.0129310345);

pk_prof_lic_cat_mm_b4 := map(pk_prof_lic_cat = -1 => 0.0397880924,
                             pk_prof_lic_cat = 0  => 0.0319693095,
                             pk_prof_lic_cat = 1  => 0.0087336245,
                             pk_prof_lic_cat = 2  => 0.0118181818,
                                                     0.0051948052);

pk_add1_lres_mm_b4 := map(pk_add1_lres = -2 => 0.0212765957,
                          pk_add1_lres = -1 => 0.0768417342,
                          pk_add1_lres = 0  => 0.1151776103,
                          pk_add1_lres = 1  => 0.0925666199,
                          pk_add1_lres = 2  => 0.064738292,
                          pk_add1_lres = 3  => 0.0694822888,
                          pk_add1_lres = 4  => 0.0596228508,
                          pk_add1_lres = 5  => 0.0391330524,
                          pk_add1_lres = 6  => 0.0404601349,
                          pk_add1_lres = 7  => 0.0329218107,
                          pk_add1_lres = 8  => 0.0194797034,
                          pk_add1_lres = 9  => 0.0198624905,
                          pk_add1_lres = 10 => 0.0134430727,
                                               0.0085574572);

pk_add2_lres_mm_b4 := map(pk_add2_lres = -2 => 0.0652199833,
                          pk_add2_lres = -1 => 0.02157061,
                          pk_add2_lres = 0  => 0.0546357616,
                          pk_add2_lres = 1  => 0.0575417813,
                          pk_add2_lres = 2  => 0.0453796889,
                          pk_add2_lres = 3  => 0.0420439845,
                          pk_add2_lres = 4  => 0.0334004024,
                          pk_add2_lres = 5  => 0.0283018868,
                          pk_add2_lres = 6  => 0.0256578947,
                          pk_add2_lres = 7  => 0.0230556409,
                          pk_add2_lres = 8  => 0.0210297317,
                          pk_add2_lres = 9  => 0.0148042025,
                                               0.0126984127);

pk_add3_lres_mm_b4 := map(pk_add3_lres = -2 => 0.0596013549,
                          pk_add3_lres = -1 => 0.0224496189,
                          pk_add3_lres = 0  => 0.0352332531,
                          pk_add3_lres = 1  => 0.031025641,
                          pk_add3_lres = 2  => 0.0291632597,
                          pk_add3_lres = 3  => 0.0243902439,
                          pk_add3_lres = 4  => 0.0218978102,
                          pk_add3_lres = 5  => 0.014084507,
                                               0.0203784571);

pk_lres_flag_level_mm_b4 := map(pk_lres_flag_level = 0 => 0.0759361997,
                                pk_lres_flag_level = 1 => 0.0489049169,
                                                          0.0273835311);

pk_addrs_5yr_mm_b4 := map(pk_addrs_5yr = 0 => 0.0275620888,
                          pk_addrs_5yr = 1 => 0.0452717983,
                          pk_addrs_5yr = 2 => 0.0394470668,
                          pk_addrs_5yr = 3 => 0.0391822828,
                                              0.0704225352);

pk_addrs_15yr_mm_b4 := map(pk_addrs_15yr = 0 => 0.0455768584,
                           pk_addrs_15yr = 1 => 0.0375820194,
                           pk_addrs_15yr = 2 => 0.0275526742,
                                                0.0227272727);

pk_add_lres_month_avg2_mm_b4 := map(pk_add_lres_month_avg2 = -1 => 0.0940649496,
                                    pk_add_lres_month_avg2 = 0  => 0.1470160116,
                                    pk_add_lres_month_avg2 = 1  => 0.1269990593,
                                    pk_add_lres_month_avg2 = 2  => 0.0833333333,
                                    pk_add_lres_month_avg2 = 3  => 0.0648406931,
                                    pk_add_lres_month_avg2 = 4  => 0.064171123,
                                    pk_add_lres_month_avg2 = 5  => 0.0561655405,
                                    pk_add_lres_month_avg2 = 6  => 0.0507343124,
                                    pk_add_lres_month_avg2 = 7  => 0.0441136671,
                                    pk_add_lres_month_avg2 = 8  => 0.0358521787,
                                    pk_add_lres_month_avg2 = 9  => 0.0311827957,
                                    pk_add_lres_month_avg2 = 10 => 0.025107604,
                                    pk_add_lres_month_avg2 = 11 => 0.0213366803,
                                    pk_add_lres_month_avg2 = 12 => 0.0189544482,
                                    pk_add_lres_month_avg2 = 13 => 0.0166992628,
                                    pk_add_lres_month_avg2 = 15 => 0.0111715841,
                                                                   0.0101037684);

pk_ssns_per_adl_mm_b4 := map(pk_ssns_per_adl = -1 => 0.0924574209,
                             pk_ssns_per_adl = 0  => 0.0380372953,
                             pk_ssns_per_adl = 1  => 0.0329092451,
                             pk_ssns_per_adl = 2  => 0.0354796321,
                             pk_ssns_per_adl = 3  => 0.0431034483,
                                                     0.025);

pk_addrs_per_adl_mm_b4 := map(pk_addrs_per_adl = -6 => 0.0962343096,
                              pk_addrs_per_adl = -5 => 0.0662119252,
                              pk_addrs_per_adl = -4 => 0.0509159094,
                              pk_addrs_per_adl = -3 => 0.0348933355,
                              pk_addrs_per_adl = -2 => 0.030206379,
                              pk_addrs_per_adl = -1 => 0.0227272727,
                              pk_addrs_per_adl = 0  => 0.0234047795,
                              pk_addrs_per_adl = 1  => 0.0261547023,
                              pk_addrs_per_adl = 2  => 0.0235767683,
                                                       0.0273037543);

pk_phones_per_adl_mm_b4 := map(pk_phones_per_adl = -1 => 0.0448528078,
                               pk_phones_per_adl = 0  => 0.0228245364,
                               pk_phones_per_adl = 1  => 0.0304671632,
                                                         0.0430107527);

pk_adlperssn_count_mm_b4 := map(pk_adlperssn_count = -1 => 0.0352941176,
                                pk_adlperssn_count = 0  => 0.0382323012,
                                pk_adlperssn_count = 1  => 0.0379711494,
                                                           0.0406091371);

pk_adls_per_addr_mm_b4 := map(pk_adls_per_addr = -102 => 0.0454545455,
                              pk_adls_per_addr = -101 => 0.0864197531,
                              pk_adls_per_addr = -2   => 0.0387866733,
                              pk_adls_per_addr = -1   => 0.0375521558,
                              pk_adls_per_addr = 0    => 0.0211640212,
                              pk_adls_per_addr = 1    => 0.0262189512,
                              pk_adls_per_addr = 2    => 0.0286306272,
                              pk_adls_per_addr = 3    => 0.0321118991,
                              pk_adls_per_addr = 4    => 0.0269420745,
                              pk_adls_per_addr = 5    => 0.0369239311,
                              pk_adls_per_addr = 6    => 0.0422812193,
                              pk_adls_per_addr = 7    => 0.0449257922,
                              pk_adls_per_addr = 8    => 0.0520082389,
                              pk_adls_per_addr = 9    => 0.0526315789,
                              pk_adls_per_addr = 10   => 0.05384939,
                              pk_adls_per_addr = 11   => 0.0564814815,
                              pk_adls_per_addr = 12   => 0.07176781,
                              pk_adls_per_addr = 13   => 0.0639419908,
                              pk_adls_per_addr = 100  => 0.0634920635,
                              pk_adls_per_addr = 101  => 0.1363636364,
                                                         0.0340909091);

pk_adls_per_phone_mm_b4 := map(pk_adls_per_phone = -2 => 0.0518559711,
                               pk_adls_per_phone = -1 => 0.0285842116,
                               pk_adls_per_phone = 0  => 0.0224222586,
                                                         0.0380228137);

pk_ssns_per_adl_c6_mm_b4 := map(pk_ssns_per_adl_c6 = 0 => 0.031267899,
                                pk_ssns_per_adl_c6 = 1 => 0.0659201352,
                                                          0.0833333333);

pk_ssns_per_addr_c6_mm_b4 := map(pk_ssns_per_addr_c6 = 0   => 0.0259736541,
                                 pk_ssns_per_addr_c6 = 1   => 0.0646197787,
                                 pk_ssns_per_addr_c6 = 2   => 0.0720568336,
                                 pk_ssns_per_addr_c6 = 3   => 0.110604333,
                                 pk_ssns_per_addr_c6 = 4   => 0.1218637993,
                                 pk_ssns_per_addr_c6 = 5   => 0.1071428571,
                                 pk_ssns_per_addr_c6 = 6   => 0.1237113402,
                                 pk_ssns_per_addr_c6 = 100 => 0.0483870968,
                                 pk_ssns_per_addr_c6 = 101 => 0.0983606557,
                                 pk_ssns_per_addr_c6 = 102 => 0.1176470588,
                                 pk_ssns_per_addr_c6 = 103 => 0,
                                                              0);

pk_adls_per_phone_c6_mm_b4 := map(pk_adls_per_phone_c6 = 0 => 0.046981118,
                                  pk_adls_per_phone_c6 = 1 => 0.0297981608,
                                                              0.0183465959);

pk_attr_addrs_last90_mm_b4 := map(pk_attr_addrs_last90 = 0 => 0.0348034602,
                                  pk_attr_addrs_last90 = 1 => 0.0841063698,
                                                              0.0754716981);

pk_attr_addrs_last12_mm_b4 := map(pk_attr_addrs_last12 = 0 => 0.0308297013,
                                  pk_attr_addrs_last12 = 1 => 0.0620963173,
                                  pk_attr_addrs_last12 = 2 => 0.0742385787,
                                  pk_attr_addrs_last12 = 3 => 0.096069869,
                                                              0.0256410256);

pk_attr_addrs_last24_mm_b4 := map(pk_attr_addrs_last24 = 0 => 0.029066302,
                                  pk_attr_addrs_last24 = 1 => 0.0503649635,
                                  pk_attr_addrs_last24 = 2 => 0.0530391927,
                                  pk_attr_addrs_last24 = 3 => 0.0561519405,
                                  pk_attr_addrs_last24 = 4 => 0.0718232044,
                                                              0.1538461538);

pk_ams_class_level_mm_b4 := map(pk_ams_class_level = -1000001 => 0.0359681698,
                                pk_ams_class_level = 0        => 0.1312607945,
                                pk_ams_class_level = 1        => 0.071547421,
                                pk_ams_class_level = 2        => 0.0514950166,
                                pk_ams_class_level = 3        => 0.0569105691,
                                pk_ams_class_level = 4        => 0.0415162455,
                                pk_ams_class_level = 5        => 0.0388538125,
                                pk_ams_class_level = 6        => 0.028277635,
                                pk_ams_class_level = 7        => 0.0220417633,
                                pk_ams_class_level = 8        => 0.0326797386,
                                pk_ams_class_level = 1000000  => 0.0367647059,
                                pk_ams_class_level = 1000001  => 0.025210084,
                                pk_ams_class_level = 1000002  => 0.0252312868,
                                pk_ams_class_level = 1000003  => 0.0255102041,
                                pk_ams_class_level = 1000004  => 0.0201511335,
                                                                 0.0042553191);

pk_ams_4yr_college_mm_b4 := map(pk_ams_4yr_college = -1 => 0.05,
                                pk_ams_4yr_college = 0  => 0.0397556326,
                                                           0.019597596);

pk_ams_college_type_mm_b4 := map(pk_ams_college_type = 0 => 0.0397346433,
                                 pk_ams_college_type = 1 => 0.0262610504,
                                                            0.0136778116);

pk_ams_income_level_code_mm_b4 := map(pk_ams_income_level_code = -1 => 0.0359634001,
                                      pk_ams_income_level_code = 0  => 0.1328671329,
                                      pk_ams_income_level_code = 1  => 0.0797101449,
                                      pk_ams_income_level_code = 2  => 0.0577594414,
                                      pk_ams_income_level_code = 3  => 0.0484084881,
                                      pk_ams_income_level_code = 4  => 0.0406043437,
                                      pk_ams_income_level_code = 5  => 0.0293209877,
                                                                       0.0219629375);

pk_yr_in_dob2_mm_b4 := map(pk_yr_in_dob2 = 19 => 0.1595845137,
                           pk_yr_in_dob2 = 20 => 0.1086486486,
                           pk_yr_in_dob2 = 21 => 0.0814140332,
                           pk_yr_in_dob2 = 22 => 0.0647840532,
                           pk_yr_in_dob2 = 23 => 0.0537190083,
                           pk_yr_in_dob2 = 25 => 0.0444162437,
                           pk_yr_in_dob2 = 29 => 0.0323755565,
                           pk_yr_in_dob2 = 35 => 0.0311800172,
                           pk_yr_in_dob2 = 38 => 0.0286855483,
                           pk_yr_in_dob2 = 41 => 0.0260238908,
                           pk_yr_in_dob2 = 42 => 0.0238429173,
                           pk_yr_in_dob2 = 43 => 0.0209150327,
                           pk_yr_in_dob2 = 44 => 0.0286783042,
                           pk_yr_in_dob2 = 45 => 0.0185922975,
                           pk_yr_in_dob2 = 47 => 0.0210740993,
                           pk_yr_in_dob2 = 49 => 0.0200133422,
                           pk_yr_in_dob2 = 57 => 0.0155976165,
                           pk_yr_in_dob2 = 61 => 0.0118222585,
                                                 0.0110652663);

pk_yr_ams_dob2_mm_b4 := map(pk_yr_ams_dob2 = -1 => 0.0352310252,
                            pk_yr_ams_dob2 = 20 => 0.1322751323,
                            pk_yr_ams_dob2 = 22 => 0.0585284281,
                            pk_yr_ams_dob2 = 23 => 0.0627062706,
                            pk_yr_ams_dob2 = 32 => 0.0365458296,
                            pk_yr_ams_dob2 = 43 => 0.0278422274,
                                                   0.0236686391);

pk_inferred_age_mm_b4 := map(pk_inferred_age = -1 => 0.0544217687,
                             pk_inferred_age = 18 => 0.1436043747,
                             pk_inferred_age = 19 => 0.1016627078,
                             pk_inferred_age = 20 => 0.0751391466,
                             pk_inferred_age = 21 => 0.0520204366,
                             pk_inferred_age = 22 => 0.0540152964,
                             pk_inferred_age = 24 => 0.0492570171,
                             pk_inferred_age = 34 => 0.0325958119,
                             pk_inferred_age = 37 => 0.031165833,
                             pk_inferred_age = 41 => 0.0235057085,
                             pk_inferred_age = 42 => 0.0259917921,
                             pk_inferred_age = 43 => 0.0183727034,
                             pk_inferred_age = 44 => 0.0163265306,
                             pk_inferred_age = 46 => 0.0190409027,
                             pk_inferred_age = 48 => 0.0190409027,
                             pk_inferred_age = 52 => 0.0144456482,
                             pk_inferred_age = 56 => 0.0145772595,
                             pk_inferred_age = 61 => 0.0105,
                                                     0.0105);

pk_yr_reported_dob2_mm_b4 := map(pk_yr_reported_dob2 = -1 => 0.0716365754,
                                 pk_yr_reported_dob2 = 19 => 0.140625,
                                 pk_yr_reported_dob2 = 21 => 0.0722477064,
                                 pk_yr_reported_dob2 = 22 => 0.045045045,
                                 pk_yr_reported_dob2 = 23 => 0.0378289474,
                                 pk_yr_reported_dob2 = 32 => 0.0322350592,
                                 pk_yr_reported_dob2 = 35 => 0.0310179118,
                                 pk_yr_reported_dob2 = 39 => 0.0270528326,
                                 pk_yr_reported_dob2 = 42 => 0.0270924045,
                                 pk_yr_reported_dob2 = 43 => 0.0257879656,
                                 pk_yr_reported_dob2 = 44 => 0.0192837466,
                                 pk_yr_reported_dob2 = 45 => 0.0157367668,
                                 pk_yr_reported_dob2 = 46 => 0.017699115,
                                 pk_yr_reported_dob2 = 49 => 0.0203784571,
                                 pk_yr_reported_dob2 = 57 => 0.0142857143,
                                 pk_yr_reported_dob2 = 61 => 0.011,
                                                             0.011);

pk_avm_hit_level_mm_b4 := map(pk_avm_hit_level = -1 => 0.0373744452,
                              pk_avm_hit_level = 0  => 0.0401423605,
                              pk_avm_hit_level = 1  => 0.0398394746,
                                                       0.0278810409);

pk_avm_auto_diff2_lvl_mm_b4 := map(pk_avm_auto_diff2_lvl = -2 => 0.0395100884,
                                   pk_avm_auto_diff2_lvl = -1 => 0.035681272,
                                   pk_avm_auto_diff2_lvl = 0  => 0.0401104491,
                                   pk_avm_auto_diff2_lvl = 1  => 0.0340030912,
                                                                 0.0291744258);

pk_avm_auto_diff4_lvl_mm_b4 := map(pk_avm_auto_diff4_lvl = -1 => 0.0386936925,
                                   pk_avm_auto_diff4_lvl = 0  => 0.0388373841,
                                                                 0.0293432697);

pk_add2_avm_auto_diff2_lvl_mm_b4 := map(pk_add2_avm_auto_diff2_lvl = -3 => 0.0399207838,
                                        pk_add2_avm_auto_diff2_lvl = -2 => 0.0326086957,
                                        pk_add2_avm_auto_diff2_lvl = -1 => 0.0368421053,
                                        pk_add2_avm_auto_diff2_lvl = 0  => 0.0335239085,
                                                                           0.0298602287);

pk_avm_confidence_level_mm_b4 := map(pk_avm_confidence_level = 0 => 0.0388762081,
                                     pk_avm_confidence_level = 1 => 0.0312151616,
                                     pk_avm_confidence_level = 2 => 0.0372827081,
                                                                    0.0291666667);

pk2_add1_avm_mkt_mm_b4 := map(pk2_add1_avm_mkt = 0 => 0.0809061489,
                              pk2_add1_avm_mkt = 1 => 0.0381936412,
                              pk2_add1_avm_mkt = 2 => 0.0568638713,
                              pk2_add1_avm_mkt = 3 => 0.0326957659,
                                                      0.0087591241);

pk2_add1_avm_pi_mm_b4 := map(pk2_add1_avm_pi = 0 => 0.0833333333,
                             pk2_add1_avm_pi = 1 => 0.0632228219,
                             pk2_add1_avm_pi = 2 => 0.0381562353,
                                                    0.0338310038);

pk2_add1_avm_auto_mm_b4 := map(pk2_add1_avm_auto = 0 => 0.0909090909,
                               pk2_add1_avm_auto = 1 => 0.0751445087,
                               pk2_add1_avm_auto = 2 => 0.0818414322,
                               pk2_add1_avm_auto = 3 => 0.0677466863,
                               pk2_add1_avm_auto = 4 => 0.0402378137,
                               pk2_add1_avm_auto = 5 => 0.0335841313,
                                                        0.0174723355);

pk2_add1_avm_auto2_mm_b4 := map(pk2_add1_avm_auto2 = 0 => 0.1509433962,
                                pk2_add1_avm_auto2 = 1 => 0.0717948718,
                                pk2_add1_avm_auto2 = 2 => 0.088,
                                pk2_add1_avm_auto2 = 3 => 0.0563165906,
                                pk2_add1_avm_auto2 = 4 => 0.0395100884,
                                pk2_add1_avm_auto2 = 5 => 0.046989721,
                                pk2_add1_avm_auto2 = 6 => 0.0338543596,
                                                          0.0155472637);

pk2_add1_avm_auto3_mm_b4 := map(pk2_add1_avm_auto3 = 0 => 0.0882352941,
                                pk2_add1_avm_auto3 = 1 => 0.077294686,
                                pk2_add1_avm_auto3 = 2 => 0.0486725664,
                                pk2_add1_avm_auto3 = 3 => 0.0397180084,
                                pk2_add1_avm_auto3 = 4 => 0.0497607656,
                                pk2_add1_avm_auto3 = 5 => 0.0509090909,
                                pk2_add1_avm_auto3 = 6 => 0.0318998943,
                                                          0.0153417015);

pk2_add1_avm_med_mm_b4 := map(pk2_add1_avm_med = 0 => 0.0576923077,
                              pk2_add1_avm_med = 1 => 0.1171428571,
                              pk2_add1_avm_med = 2 => 0.0566534914,
                              pk2_add1_avm_med = 3 => 0.0653089888,
                              pk2_add1_avm_med = 4 => 0.055667001,
                              pk2_add1_avm_med = 5 => 0.0364208824,
                              pk2_add1_avm_med = 6 => 0.0278074866,
                                                      0.0326552149);

pk2_add1_avm_to_med_ratio_mm_b4 := map(pk2_add1_avm_to_med_ratio = 0 => 0.0397708458,
                                       pk2_add1_avm_to_med_ratio = 1 => 0.0400435256,
                                       pk2_add1_avm_to_med_ratio = 2 => 0.0378735233,
                                       pk2_add1_avm_to_med_ratio = 3 => 0.0286181521,
                                       pk2_add1_avm_to_med_ratio = 4 => 0.0245971162,
                                                                        0.0303983229);

pk2_add2_avm_sp_mm_b4 := map(pk2_add2_avm_sp = 0 => 0.0731707317,
                             pk2_add2_avm_sp = 1 => 0.0580204778,
                             pk2_add2_avm_sp = 2 => 0.0554216867,
                             pk2_add2_avm_sp = 3 => 0.0393803074,
                             pk2_add2_avm_sp = 4 => 0.0310119695,
                                                    0.0250725785);

pk2_add2_avm_ta_mm_b4 := map(pk2_add2_avm_ta = 0 => 0.0419947507,
                             pk2_add2_avm_ta = 1 => 0.039458823,
                                                    0.0301284162);

pk2_add2_avm_pi_mm_b4 := map(pk2_add2_avm_pi = 0 => 0.0616438356,
                             pk2_add2_avm_pi = 1 => 0.0666666667,
                             pk2_add2_avm_pi = 2 => 0.0393897563,
                             pk2_add2_avm_pi = 3 => 0.0290623674,
                                                    0.0183598531);

pk2_add2_avm_hed_mm_b4 := map(pk2_add2_avm_hed = 0 => 0.0975609756,
                              pk2_add2_avm_hed = 1 => 0.0621301775,
                              pk2_add2_avm_hed = 2 => 0.049132948,
                              pk2_add2_avm_hed = 3 => 0.0391546931,
                              pk2_add2_avm_hed = 4 => 0.0400782014,
                              pk2_add2_avm_hed = 5 => 0.0312977099,
                                                      0.0139372822);

pk2_add2_avm_auto_mm_b4 := map(pk2_add2_avm_auto = 0 => 0.0652591171,
                               pk2_add2_avm_auto = 1 => 0.0401973324,
                               pk2_add2_avm_auto = 2 => 0.0304292929,
                                                        0.0197568389);

pk2_add2_avm_auto3_mm_b4 := map(pk2_add2_avm_auto3 = 0 => 0.0663507109,
                                pk2_add2_avm_auto3 = 1 => 0.0786885246,
                                pk2_add2_avm_auto3 = 2 => 0.0400189972,
                                pk2_add2_avm_auto3 = 3 => 0.0275358247,
                                                          0.0140186916);

pk2_yr_add1_avm_rec_dt_mm_b4 := map(pk2_yr_add1_avm_recording_date = 0 => 0.0369913687,
                                    pk2_yr_add1_avm_recording_date = 1 => 0.0404896422,
                                    pk2_yr_add1_avm_recording_date = 2 => 0.0383323029,
                                    pk2_yr_add1_avm_recording_date = 3 => 0.0405889375,
                                                                          0.0342096927);

pk2_yr_add1_avm_assess_year_mm_b4 := map(pk2_yr_add1_avm_assess_year = 0 => 0.0394676002,
                                         pk2_yr_add1_avm_assess_year = 1 => 0.0368932039,
                                                                            0.0332749562);

pk_dist_a1toa2_mm_b4 := map(pk_dist_a1toa2_2 = 0 => 0.0305367057,
                            pk_dist_a1toa2_2 = 1 => 0.0316903695,
                            pk_dist_a1toa2_2 = 2 => 0.039314845,
                            pk_dist_a1toa2_2 = 3 => 0.0364640884,
                                                    0.0646789529);

pk_dist_a1toa3_mm_b4 := map(pk_dist_a1toa3_2 = 0 => 0.0263370787,
                            pk_dist_a1toa3_2 = 1 => 0.026350304,
                            pk_dist_a1toa3_2 = 2 => 0.0309607077,
                            pk_dist_a1toa3_2 = 3 => 0.0359897172,
                            pk_dist_a1toa3_2 = 4 => 0.0314318976,
                            pk_dist_a1toa3_2 = 5 => 0.0228571429,
                                                    0.0591422122);

pk_rc_disthphoneaddr_mm_b4 := map(pk_rc_disthphoneaddr_2 = 0 => 0.0263370787,
                                  pk_rc_disthphoneaddr_2 = 1 => 0.0319833131,
                                  pk_rc_disthphoneaddr_2 = 2 => 0.0342679128,
                                  pk_rc_disthphoneaddr_2 = 3 => 0.0396475771,
                                                                0.0543518372);

pk_out_st_division_lvl_mm_b4 := map(pk_out_st_division_lvl = -1 => 0.0455445545,
                                    pk_out_st_division_lvl = 0  => 0.0299280576,
                                    pk_out_st_division_lvl = 1  => 0.0368702505,
                                    pk_out_st_division_lvl = 2  => 0.0390570021,
                                    pk_out_st_division_lvl = 3  => 0.0439936776,
                                    pk_out_st_division_lvl = 4  => 0.0422635087,
                                    pk_out_st_division_lvl = 5  => 0.0322128852,
                                    pk_out_st_division_lvl = 6  => 0.034006143,
                                    pk_out_st_division_lvl = 7  => 0.0502803738,
                                                                   0.0343781598);

pk_wealth_index_mm_b4 := map(pk_wealth_index_2 = 0 => 0.0402632324,
                             pk_wealth_index_2 = 1 => 0.0493164063,
                             pk_wealth_index_2 = 2 => 0.0416621926,
                             pk_wealth_index_2 = 3 => 0.0252357551,
                                                      0.0262582057);

pk_attr_num_nonderogs90_b_mm_b4 := map(pk_attr_num_nonderogs90_b = 0  => 0.0949781659,
                                       pk_attr_num_nonderogs90_b = 1  => 0.063525675,
                                       pk_attr_num_nonderogs90_b = 2  => 0.0367158138,
                                       pk_attr_num_nonderogs90_b = 3  => 0.0257633588,
                                       pk_attr_num_nonderogs90_b = 4  => 0.0200803213,
                                       pk_attr_num_nonderogs90_b = 10 => 0.0841121495,
                                       pk_attr_num_nonderogs90_b = 11 => 0.0457700433,
                                       pk_attr_num_nonderogs90_b = 12 => 0.0212042732,
                                       pk_attr_num_nonderogs90_b = 13 => 0.0103598691,
                                                                         0.0114942529);

pk_ssns_per_addr2_mm_b4 := map(pk_ssns_per_addr2 = -101 => 0.0540540541,
                               pk_ssns_per_addr2 = -2   => 0.0368852459,
                               pk_ssns_per_addr2 = -1   => 0.0377984085,
                               pk_ssns_per_addr2 = 0    => 0.0227488152,
                               pk_ssns_per_addr2 = 1    => 0.0229966809,
                               pk_ssns_per_addr2 = 2    => 0.0308880309,
                               pk_ssns_per_addr2 = 3    => 0.0289973453,
                               pk_ssns_per_addr2 = 4    => 0.0293645331,
                               pk_ssns_per_addr2 = 5    => 0.0360335196,
                               pk_ssns_per_addr2 = 6    => 0.0385126162,
                               pk_ssns_per_addr2 = 7    => 0.0428857715,
                               pk_ssns_per_addr2 = 8    => 0.0556497175,
                               pk_ssns_per_addr2 = 9    => 0.0568900126,
                               pk_ssns_per_addr2 = 10   => 0.050802139,
                               pk_ssns_per_addr2 = 11   => 0.0747261346,
                               pk_ssns_per_addr2 = 12   => 0.0563380282,
                               pk_ssns_per_addr2 = 100  => 0.08,
                               pk_ssns_per_addr2 = 101  => 0.15,
                               pk_ssns_per_addr2 = 102  => 0.0375,
                                                           0);

pk_yr_add2_assess_val_yr2_mm_b4 := map(pk_yr_add2_assessed_value_year2 = -1 => 0.0407321475,
                                       pk_yr_add2_assessed_value_year2 = 0  => 0.0192307692,
                                       pk_yr_add2_assessed_value_year2 = 1  => 0.0331299859,
                                                                               0.0266889074);

pk_yr_criminal_last_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_criminal_last_date2_mm_b1,
                                    pk_segment_2 = '1 Owner ' => pk_yr_criminal_last_date2_mm_b2,
                                    pk_segment_2 = '2 Renter' => pk_yr_criminal_last_date2_mm_b3,
                                                                 pk_yr_criminal_last_date2_mm_b4);

pk_add2_garage_type_risk_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_garage_type_risk_lvl_mm_b1,
                                       pk_segment_2 = '1 Owner ' => pk_add2_garage_type_risk_lvl_mm_b2,
                                       pk_segment_2 = '2 Renter' => pk_add2_garage_type_risk_lvl_mm_b3,
                                                                    pk_add2_garage_type_risk_lvl_mm_b4);

pk_prop_own_assess_tot2_mm := map(pk_segment_2 = '0 Derog ' => pk_prop_own_assess_tot2_mm_b1,
                                  pk_segment_2 = '1 Owner ' => pk_prop_own_assess_tot2_mm_b2,
                                  pk_segment_2 = '2 Renter' => pk_prop_own_assess_tot2_mm_b3,
                                                               pk_prop_own_assess_tot2_mm_b4);

pk_yr_add1_date_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_date_first_seen2_mm_b1,
                                      pk_segment_2 = '1 Owner ' => pk_yr_add1_date_first_seen2_mm_b2,
                                      pk_segment_2 = '2 Renter' => pk_yr_add1_date_first_seen2_mm_b3,
                                                                   pk_yr_add1_date_first_seen2_mm_b4);

pk_attr_addrs_last90_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last90_mm_b1,
                               pk_segment_2 = '1 Owner ' => pk_attr_addrs_last90_mm_b2,
                               pk_segment_2 = '2 Renter' => pk_attr_addrs_last90_mm_b3,
                                                            pk_attr_addrs_last90_mm_b4);

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

pk_attr_addrs_last12_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last12_mm_b1,
                               pk_segment_2 = '1 Owner ' => pk_attr_addrs_last12_mm_b2,
                               pk_segment_2 = '2 Renter' => pk_attr_addrs_last12_mm_b3,
                                                            pk_attr_addrs_last12_mm_b4);

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

pk_ams_college_type_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_college_type_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_ams_college_type_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_ams_college_type_mm_b3,
                                                           pk_ams_college_type_mm_b4);

pk_yr_add3_date_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add3_date_first_seen2_mm_b1,
                                      pk_segment_2 = '1 Owner ' => pk_yr_add3_date_first_seen2_mm_b2,
                                      pk_segment_2 = '2 Renter' => pk_yr_add3_date_first_seen2_mm_b3,
                                                                   pk_yr_add3_date_first_seen2_mm_b4);

pk_add1_land_use_risk_level_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_land_use_risk_level_mm_b1,
                                      pk_segment_2 = '1 Owner ' => pk_add1_land_use_risk_level_mm_b2,
                                      pk_segment_2 = '2 Renter' => pk_add1_land_use_risk_level_mm_b3,
                                                                   pk_add1_land_use_risk_level_mm_b4);

pk2_add2_avm_ta_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_ta_mm_b1,
                          pk_segment_2 = '1 Owner ' => pk2_add2_avm_ta_mm_b2,
                          pk_segment_2 = '2 Renter' => pk2_add2_avm_ta_mm_b3,
                                                       pk2_add2_avm_ta_mm_b4);

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

pk_ssns_per_adl_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_mm_b1,
                          pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_mm_b2,
                          pk_segment_2 = '2 Renter' => pk_ssns_per_adl_mm_b3,
                                                       pk_ssns_per_adl_mm_b4);

pk_ams_income_level_code_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_income_level_code_mm_b1,
                                   pk_segment_2 = '1 Owner ' => pk_ams_income_level_code_mm_b2,
                                   pk_segment_2 = '2 Renter' => pk_ams_income_level_code_mm_b3,
                                                                pk_ams_income_level_code_mm_b4);

pk_add1_building_area2_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_building_area2_mm_b1,
                                 pk_segment_2 = '1 Owner ' => pk_add1_building_area2_mm_b2,
                                 pk_segment_2 = '2 Renter' => pk_add1_building_area2_mm_b3,
                                                              pk_add1_building_area2_mm_b4);

pk_pr_count_mm := map(pk_segment_2 = '0 Derog ' => pk_pr_count_mm_b1,
                      pk_segment_2 = '1 Owner ' => pk_pr_count_mm_b2,
                      pk_segment_2 = '2 Renter' => pk_pr_count_mm_b3,
                                                   pk_pr_count_mm_b4);

pk_avm_auto_diff2_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_avm_auto_diff2_lvl_mm_b1,
                                pk_segment_2 = '1 Owner ' => pk_avm_auto_diff2_lvl_mm_b2,
                                pk_segment_2 = '2 Renter' => pk_avm_auto_diff2_lvl_mm_b3,
                                                             pk_avm_auto_diff2_lvl_mm_b4);

pk_inferred_age_mm := map(pk_segment_2 = '0 Derog ' => pk_inferred_age_mm_b1,
                          pk_segment_2 = '1 Owner ' => pk_inferred_age_mm_b2,
                          pk_segment_2 = '2 Renter' => pk_inferred_age_mm_b3,
                                                       pk_inferred_age_mm_b4);

pk2_yr_add1_avm_assess_year_mm := map(pk_segment_2 = '0 Derog ' => pk2_yr_add1_avm_assess_year_mm_b1,
                                      pk_segment_2 = '1 Owner ' => pk2_yr_add1_avm_assess_year_mm_b2,
                                      pk_segment_2 = '2 Renter' => pk2_yr_add1_avm_assess_year_mm_b3,
                                                                   pk2_yr_add1_avm_assess_year_mm_b4);

pk_add1_no_of_baths_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_no_of_baths_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_add1_no_of_baths_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_add1_no_of_baths_mm_b3,
                                                           pk_add1_no_of_baths_mm_b4);

pk_out_st_division_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_out_st_division_lvl_mm_b1,
                                 pk_segment_2 = '1 Owner ' => pk_out_st_division_lvl_mm_b2,
                                 pk_segment_2 = '2 Renter' => pk_out_st_division_lvl_mm_b3,
                                                              pk_out_st_division_lvl_mm_b4);

pk_yr_rc_ssnhighissue2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_rc_ssnhighissue2_mm_b1,
                                 pk_segment_2 = '1 Owner ' => pk_yr_rc_ssnhighissue2_mm_b2,
                                 pk_segment_2 = '2 Renter' => pk_yr_rc_ssnhighissue2_mm_b3,
                                                              pk_yr_rc_ssnhighissue2_mm_b4);

pk_add2_building_area2_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_building_area2_mm_b1,
                                 pk_segment_2 = '1 Owner ' => pk_add2_building_area2_mm_b2,
                                 pk_segment_2 = '2 Renter' => pk_add2_building_area2_mm_b3,
                                                              pk_add2_building_area2_mm_b4);

pk_phones_per_adl_mm := map(pk_segment_2 = '0 Derog ' => pk_phones_per_adl_mm_b1,
                            pk_segment_2 = '1 Owner ' => pk_phones_per_adl_mm_b2,
                            pk_segment_2 = '2 Renter' => pk_phones_per_adl_mm_b3,
                                                         pk_phones_per_adl_mm_b4);

pk_add1_no_of_rooms_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_no_of_rooms_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_add1_no_of_rooms_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_add1_no_of_rooms_mm_b3,
                                                           pk_add1_no_of_rooms_mm_b4);

pk2_add1_avm_auto2_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto2_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto2_mm_b2,
                             pk_segment_2 = '2 Renter' => pk2_add1_avm_auto2_mm_b3,
                                                          pk2_add1_avm_auto2_mm_b4);

pk_ams_4yr_college_mm := map(pk_segment_2 = '0 Derog ' => pk_ams_4yr_college_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk_ams_4yr_college_mm_b2,
                             pk_segment_2 = '2 Renter' => pk_ams_4yr_college_mm_b3,
                                                          pk_ams_4yr_college_mm_b4);

pk_ssns_per_addr_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_addr_c6_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_ssns_per_addr_c6_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_ssns_per_addr_c6_mm_b3,
                                                           pk_ssns_per_addr_c6_mm_b4);

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

pk_pl_sourced_level_mm := map(pk_segment_2 = '0 Derog ' => pk_pl_sourced_level_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_pl_sourced_level_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_pl_sourced_level_mm_b3,
                                                           pk_pl_sourced_level_mm_b4);

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

pk_adls_per_addr_mm := map(pk_segment_2 = '0 Derog ' => pk_adls_per_addr_mm_b1,
                           pk_segment_2 = '1 Owner ' => pk_adls_per_addr_mm_b2,
                           pk_segment_2 = '2 Renter' => pk_adls_per_addr_mm_b3,
                                                        pk_adls_per_addr_mm_b4);

pk_yr_ams_dob2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_ams_dob2_mm_b1,
                         pk_segment_2 = '1 Owner ' => pk_yr_ams_dob2_mm_b2,
                         pk_segment_2 = '2 Renter' => pk_yr_ams_dob2_mm_b3,
                                                      pk_yr_ams_dob2_mm_b4);

pk_ssns_per_adl_c6_mm := map(pk_segment_2 = '0 Derog ' => pk_ssns_per_adl_c6_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk_ssns_per_adl_c6_mm_b2,
                             pk_segment_2 = '2 Renter' => pk_ssns_per_adl_c6_mm_b3,
                                                          pk_ssns_per_adl_c6_mm_b4);

pk_attr_addrs_last24_mm := map(pk_segment_2 = '0 Derog ' => pk_attr_addrs_last24_mm_b1,
                               pk_segment_2 = '1 Owner ' => pk_attr_addrs_last24_mm_b2,
                               pk_segment_2 = '2 Renter' => pk_attr_addrs_last24_mm_b3,
                                                            pk_attr_addrs_last24_mm_b4);

pk_add2_avm_auto_diff2_lvl_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_avm_auto_diff2_lvl_mm_b1,
                                     pk_segment_2 = '1 Owner ' => pk_add2_avm_auto_diff2_lvl_mm_b2,
                                     pk_segment_2 = '2 Renter' => pk_add2_avm_auto_diff2_lvl_mm_b3,
                                                                  pk_add2_avm_auto_diff2_lvl_mm_b4);

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

pk_avm_confidence_level_mm := map(pk_segment_2 = '0 Derog ' => pk_avm_confidence_level_mm_b1,
                                  pk_segment_2 = '1 Owner ' => pk_avm_confidence_level_mm_b2,
                                  pk_segment_2 = '2 Renter' => pk_avm_confidence_level_mm_b3,
                                                               pk_avm_confidence_level_mm_b4);

pk_add2_no_of_buildings_mm := map(pk_segment_2 = '0 Derog ' => pk_add2_no_of_buildings_mm_b1,
                                  pk_segment_2 = '1 Owner ' => pk_add2_no_of_buildings_mm_b2,
                                  pk_segment_2 = '2 Renter' => pk_add2_no_of_buildings_mm_b3,
                                                               pk_add2_no_of_buildings_mm_b4);

pk_yr_add2_mortgage_due_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add2_mortgage_due_date2_mm_b1,
                                        pk_segment_2 = '1 Owner ' => pk_yr_add2_mortgage_due_date2_mm_b2,
                                        pk_segment_2 = '2 Renter' => pk_yr_add2_mortgage_due_date2_mm_b3,
                                                                     pk_yr_add2_mortgage_due_date2_mm_b4);

pk_yr_add1_mortgage_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_mortgage_date2_mm_b1,
                                    pk_segment_2 = '1 Owner ' => pk_yr_add1_mortgage_date2_mm_b2,
                                    pk_segment_2 = '2 Renter' => pk_yr_add1_mortgage_date2_mm_b3,
                                                                 pk_yr_add1_mortgage_date2_mm_b4);

pk_addrs_15yr_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_15yr_mm_b1,
                        pk_segment_2 = '1 Owner ' => pk_addrs_15yr_mm_b2,
                        pk_segment_2 = '2 Renter' => pk_addrs_15yr_mm_b3,
                                                     pk_addrs_15yr_mm_b4);

pk_yr_in_dob2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_in_dob2_mm_b1,
                        pk_segment_2 = '1 Owner ' => pk_yr_in_dob2_mm_b2,
                        pk_segment_2 = '2 Renter' => pk_yr_in_dob2_mm_b3,
                                                     pk_yr_in_dob2_mm_b4);

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

pk2_add2_avm_pi_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_pi_mm_b1,
                          pk_segment_2 = '1 Owner ' => pk2_add2_avm_pi_mm_b2,
                          pk_segment_2 = '2 Renter' => pk2_add2_avm_pi_mm_b3,
                                                       pk2_add2_avm_pi_mm_b4);

pk2_add1_avm_to_med_ratio_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_to_med_ratio_mm_b1,
                                    pk_segment_2 = '1 Owner ' => pk2_add1_avm_to_med_ratio_mm_b2,
                                    pk_segment_2 = '2 Renter' => pk2_add1_avm_to_med_ratio_mm_b3,
                                                                 pk2_add1_avm_to_med_ratio_mm_b4);

pk2_add1_avm_auto_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_auto_mm_b1,
                            pk_segment_2 = '1 Owner ' => pk2_add1_avm_auto_mm_b2,
                            pk_segment_2 = '2 Renter' => pk2_add1_avm_auto_mm_b3,
                                                         pk2_add1_avm_auto_mm_b4);

pk_yr_adl_pr_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_pr_first_seen2_mm_b1,
                                   pk_segment_2 = '1 Owner ' => pk_yr_adl_pr_first_seen2_mm_b2,
                                   pk_segment_2 = '2 Renter' => pk_yr_adl_pr_first_seen2_mm_b3,
                                                                pk_yr_adl_pr_first_seen2_mm_b4);

pk_add1_assessed_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add1_assessed_amount2_mm_b1,
                                   pk_segment_2 = '1 Owner ' => pk_add1_assessed_amount2_mm_b2,
                                   pk_segment_2 = '2 Renter' => pk_add1_assessed_amount2_mm_b3,
                                                                pk_add1_assessed_amount2_mm_b4);

pk_add3_lres_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_lres_mm_b1,
                       pk_segment_2 = '1 Owner ' => pk_add3_lres_mm_b2,
                       pk_segment_2 = '2 Renter' => pk_add3_lres_mm_b3,
                                                    pk_add3_lres_mm_b4);

pk_lres_flag_level_mm := map(pk_segment_2 = '0 Derog ' => pk_lres_flag_level_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk_lres_flag_level_mm_b2,
                             pk_segment_2 = '2 Renter' => pk_lres_flag_level_mm_b3,
                                                          pk_lres_flag_level_mm_b4);

pk_estimated_income_mm := map(pk_segment_2 = '0 Derog ' => pk_estimated_income_mm_b1,
                              pk_segment_2 = '1 Owner ' => pk_estimated_income_mm_b2,
                              pk_segment_2 = '2 Renter' => pk_estimated_income_mm_b3,
                                                           pk_estimated_income_mm_b4);

pk_yr_adl_w_first_seen2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_adl_w_first_seen2_mm_b1,
                                  pk_segment_2 = '1 Owner ' => pk_yr_adl_w_first_seen2_mm_b2,
                                  pk_segment_2 = '2 Renter' => pk_yr_adl_w_first_seen2_mm_b3,
                                                               pk_yr_adl_w_first_seen2_mm_b4);

pk_yr_add1_mortgage_due_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_add1_mortgage_due_date2_mm_b1,
                                        pk_segment_2 = '1 Owner ' => pk_yr_add1_mortgage_due_date2_mm_b2,
                                        pk_segment_2 = '2 Renter' => pk_yr_add1_mortgage_due_date2_mm_b3,
                                                                     pk_yr_add1_mortgage_due_date2_mm_b4);

pk_dist_a1toa2_mm := map(pk_segment_2 = '0 Derog ' => pk_dist_a1toa2_mm_b1,
                         pk_segment_2 = '1 Owner ' => pk_dist_a1toa2_mm_b2,
                         pk_segment_2 = '2 Renter' => pk_dist_a1toa2_mm_b3,
                                                      pk_dist_a1toa2_mm_b4);

pk_add3_assessed_amount2_mm := map(pk_segment_2 = '0 Derog ' => pk_add3_assessed_amount2_mm_b1,
                                   pk_segment_2 = '1 Owner ' => pk_add3_assessed_amount2_mm_b2,
                                   pk_segment_2 = '2 Renter' => pk_add3_assessed_amount2_mm_b3,
                                                                pk_add3_assessed_amount2_mm_b4);

pk_yr_felony_last_date2_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_felony_last_date2_mm_b1,
                                  pk_segment_2 = '1 Owner ' => pk_yr_felony_last_date2_mm_b2,
                                  pk_segment_2 = '2 Renter' => pk_yr_felony_last_date2_mm_b3,
                                                               pk_yr_felony_last_date2_mm_b4);

pk_addrs_5yr_mm := map(pk_segment_2 = '0 Derog ' => pk_addrs_5yr_mm_b1,
                       pk_segment_2 = '1 Owner ' => pk_addrs_5yr_mm_b2,
                       pk_segment_2 = '2 Renter' => pk_addrs_5yr_mm_b3,
                                                    pk_addrs_5yr_mm_b4);

pk_lien_type_level_mm := map(pk_segment_2 = '0 Derog ' => pk_lien_type_level_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk_lien_type_level_mm_b2,
                             pk_segment_2 = '2 Renter' => pk_lien_type_level_mm_b3,
                                                          pk_lien_type_level_mm_b4);

pk2_add2_avm_auto3_mm := map(pk_segment_2 = '0 Derog ' => pk2_add2_avm_auto3_mm_b1,
                             pk_segment_2 = '1 Owner ' => pk2_add2_avm_auto3_mm_b2,
                             pk_segment_2 = '2 Renter' => pk2_add2_avm_auto3_mm_b3,
                                                          pk2_add2_avm_auto3_mm_b4);

pk2_add1_avm_pi_mm := map(pk_segment_2 = '0 Derog ' => pk2_add1_avm_pi_mm_b1,
                          pk_segment_2 = '1 Owner ' => pk2_add1_avm_pi_mm_b2,
                          pk_segment_2 = '2 Renter' => pk2_add1_avm_pi_mm_b3,
                                                       pk2_add1_avm_pi_mm_b4);

pk_yr_liens_last_unrel_date3_mm := map(pk_segment_2 = '0 Derog ' => pk_yr_liens_last_unrel_date3_mm_b1,
                                       pk_segment_2 = '1 Owner ' => pk_yr_liens_last_unrel_date3_mm_b2,
                                       pk_segment_2 = '2 Renter' => pk_yr_liens_last_unrel_date3_mm_b3,
                                                                    pk_yr_liens_last_unrel_date3_mm_b4);

segment_mean :=  map(pk_segment_2 = '0 Derog ' => (1812 / 35348),
                     pk_segment_2 = '1 Owner ' => (2146 / 142415),
                     pk_segment_2 = '2 Renter' => (2578 / 48886),
                                                  (1841 / 48068));

pk_add_lres_month_avg2_mm_2 :=  if(pk_add_lres_month_avg2_mm = NULL, segment_mean, pk_add_lres_month_avg2_mm);

pk_add1_assessed_amount2_mm_2 :=  if(pk_add1_assessed_amount2_mm = NULL, segment_mean, pk_add1_assessed_amount2_mm);

pk_add1_building_area2_mm_2 :=  if(pk_add1_building_area2_mm = NULL, segment_mean, pk_add1_building_area2_mm);

pk_add1_land_use_risk_level_mm_2 :=  if(pk_add1_land_use_risk_level_mm = NULL, segment_mean, pk_add1_land_use_risk_level_mm);

pk_add1_lres_mm_2 :=  if(pk_add1_lres_mm = NULL, segment_mean, pk_add1_lres_mm);

pk_add1_mortgage_risk_mm_2 :=  if(pk_add1_mortgage_risk_mm = NULL, segment_mean, pk_add1_mortgage_risk_mm);

pk_add1_no_of_baths_mm_2 :=  if(pk_add1_no_of_baths_mm = NULL, segment_mean, pk_add1_no_of_baths_mm);

pk_add1_no_of_rooms_mm_2 :=  if(pk_add1_no_of_rooms_mm = NULL, segment_mean, pk_add1_no_of_rooms_mm);

pk_add1_purchase_amount2_mm_2 :=  if(pk_add1_purchase_amount2_mm = NULL, segment_mean, pk_add1_purchase_amount2_mm);

pk_add2_assessed_amount2_mm_2 :=  if(pk_add2_assessed_amount2_mm = NULL, segment_mean, pk_add2_assessed_amount2_mm);

pk_add2_avm_auto_diff2_lvl_mm_2 :=  if(pk_add2_avm_auto_diff2_lvl_mm = NULL, segment_mean, pk_add2_avm_auto_diff2_lvl_mm);

pk_add2_building_area2_mm_2 :=  if(pk_add2_building_area2_mm = NULL, segment_mean, pk_add2_building_area2_mm);

pk_add2_em_ver_lvl_mm_2 :=  if(pk_add2_em_ver_lvl_mm = NULL, segment_mean, pk_add2_em_ver_lvl_mm);

pk_add2_garage_type_risk_lvl_mm_2 :=  if(pk_add2_garage_type_risk_lvl_mm = NULL, segment_mean, pk_add2_garage_type_risk_lvl_mm);

pk_add2_lres_mm_2 :=  if(pk_add2_lres_mm = NULL, segment_mean, pk_add2_lres_mm);

pk_add2_no_of_buildings_mm_2 :=  if(pk_add2_no_of_buildings_mm = NULL, segment_mean, pk_add2_no_of_buildings_mm);

pk_add2_parking_no_of_cars_mm_2 :=  if(pk_add2_parking_no_of_cars_mm = NULL, segment_mean, pk_add2_parking_no_of_cars_mm);

pk_add2_pos_sources_mm_2 :=  if(pk_add2_pos_sources_mm = NULL, segment_mean, pk_add2_pos_sources_mm);

pk_add3_assessed_amount2_mm_2 :=  if(pk_add3_assessed_amount2_mm = NULL, segment_mean, pk_add3_assessed_amount2_mm);

pk_add3_lres_mm_2 :=  if(pk_add3_lres_mm = NULL, segment_mean, pk_add3_lres_mm);

pk_add3_mortgage_risk_mm_2 :=  if(pk_add3_mortgage_risk_mm = NULL, segment_mean, pk_add3_mortgage_risk_mm);

pk_addrs_15yr_mm_2 :=  if(pk_addrs_15yr_mm = NULL, segment_mean, pk_addrs_15yr_mm);

pk_addrs_5yr_mm_2 :=  if(pk_addrs_5yr_mm = NULL, segment_mean, pk_addrs_5yr_mm);

pk_addrs_per_adl_mm_2 :=  if(pk_addrs_per_adl_mm = NULL, segment_mean, pk_addrs_per_adl_mm);

pk_addrs_sourced_lvl_mm_2 :=  if(pk_addrs_sourced_lvl_mm = NULL, segment_mean, pk_addrs_sourced_lvl_mm);

pk_adlperssn_count_mm_2 :=  if(pk_adlperssn_count_mm = NULL, segment_mean, pk_adlperssn_count_mm);

pk_adls_per_addr_mm_2 :=  if(pk_adls_per_addr_mm = NULL, segment_mean, pk_adls_per_addr_mm);

pk_adls_per_phone_c6_mm_2 :=  if(pk_adls_per_phone_c6_mm = NULL, segment_mean, pk_adls_per_phone_c6_mm);

pk_adls_per_phone_mm_2 :=  if(pk_adls_per_phone_mm = NULL, segment_mean, pk_adls_per_phone_mm);

pk_ams_4yr_college_mm_2 :=  if(pk_ams_4yr_college_mm = NULL, segment_mean, pk_ams_4yr_college_mm);

pk_ams_class_level_mm_2 :=  if(pk_ams_class_level_mm = NULL, segment_mean, pk_ams_class_level_mm);

pk_ams_college_type_mm_2 :=  if(pk_ams_college_type_mm = NULL, segment_mean, pk_ams_college_type_mm);

pk_ams_income_level_code_mm_2 :=  if(pk_ams_income_level_code_mm = NULL, segment_mean, pk_ams_income_level_code_mm);

pk_attr_addrs_last12_mm_2 :=  if(pk_attr_addrs_last12_mm = NULL, segment_mean, pk_attr_addrs_last12_mm);

pk_attr_addrs_last24_mm_2 :=  if(pk_attr_addrs_last24_mm = NULL, segment_mean, pk_attr_addrs_last24_mm);

pk_attr_addrs_last90_mm_2 :=  if(pk_attr_addrs_last90_mm = NULL, segment_mean, pk_attr_addrs_last90_mm);

pk_attr_num_nonderogs90_b_mm_2 :=  if(pk_attr_num_nonderogs90_b_mm = NULL, segment_mean, pk_attr_num_nonderogs90_b_mm);

pk_attr_total_number_derogs_mm_2 :=  if(pk_attr_total_number_derogs_mm = NULL, segment_mean, pk_attr_total_number_derogs_mm);

pk_avm_auto_diff2_lvl_mm_2 :=  if(pk_avm_auto_diff2_lvl_mm = NULL, segment_mean, pk_avm_auto_diff2_lvl_mm);

pk_avm_auto_diff4_lvl_mm_2 :=  if(pk_avm_auto_diff4_lvl_mm = NULL, segment_mean, pk_avm_auto_diff4_lvl_mm);

pk_avm_confidence_level_mm_2 :=  if(pk_avm_confidence_level_mm = NULL, segment_mean, pk_avm_confidence_level_mm);

pk_avm_hit_level_mm_2 :=  if(pk_avm_hit_level_mm = NULL, segment_mean, pk_avm_hit_level_mm);

pk_bk_level_mm_2 :=  if(pk_bk_level_mm = NULL, segment_mean, pk_bk_level_mm);

pk_combo_dobcount_mm_2 :=  if(pk_combo_dobcount_mm = NULL, segment_mean, pk_combo_dobcount_mm);

pk_combo_dobcount_nb_mm_2 :=  if(pk_combo_dobcount_nb_mm = NULL, segment_mean, pk_combo_dobcount_nb_mm);

pk_combo_fnamecount_mm_2 :=  if(pk_combo_fnamecount_mm = NULL, segment_mean, pk_combo_fnamecount_mm);

pk_combo_fnamecount_nb_mm_2 :=  if(pk_combo_fnamecount_nb_mm = NULL, segment_mean, pk_combo_fnamecount_nb_mm);

pk_combo_ssncount_mm_2 :=  if(pk_combo_ssncount_mm = NULL, segment_mean, pk_combo_ssncount_mm);

pk_dist_a1toa2_mm_2 :=  if(pk_dist_a1toa2_mm = NULL, segment_mean, pk_dist_a1toa2_mm);

pk_dist_a1toa3_mm_2 :=  if(pk_dist_a1toa3_mm = NULL, segment_mean, pk_dist_a1toa3_mm);

pk_em_only_ver_lvl_mm_2 :=  if(pk_em_only_ver_lvl_mm = NULL, segment_mean, pk_em_only_ver_lvl_mm);

pk_eq_count_mm_2 :=  if(pk_eq_count_mm = NULL, segment_mean, pk_eq_count_mm);

pk_estimated_income_mm_2 :=  if(pk_estimated_income_mm = NULL, segment_mean, pk_estimated_income_mm);

pk_eviction_level_mm_2 :=  if(pk_eviction_level_mm = NULL, segment_mean, pk_eviction_level_mm);

pk_gong_did_phone_ct_mm_2 :=  if(pk_gong_did_phone_ct_mm = NULL, segment_mean, pk_gong_did_phone_ct_mm);

pk_gong_did_phone_ct_nb_mm_2 :=  if(pk_gong_did_phone_ct_nb_mm = NULL, segment_mean, pk_gong_did_phone_ct_nb_mm);

pk_inferred_age_mm_2 :=  if(pk_inferred_age_mm = NULL, segment_mean, pk_inferred_age_mm);

pk_infutor_risk_lvl_mm_2 :=  if(pk_infutor_risk_lvl_mm = NULL, segment_mean, pk_infutor_risk_lvl_mm);

pk_infutor_risk_lvl_nb_mm_2 :=  if(pk_infutor_risk_lvl_nb_mm = NULL, segment_mean, pk_infutor_risk_lvl_nb_mm);

pk_lien_type_level_mm_2 :=  if(pk_lien_type_level_mm = NULL, segment_mean, pk_lien_type_level_mm);

pk_lname_eda_sourced_type_lvl_mm_2 :=  if(pk_lname_eda_sourced_type_lvl_mm = NULL, segment_mean, pk_lname_eda_sourced_type_lvl_mm);

pk_lres_flag_level_mm_2 :=  if(pk_lres_flag_level_mm = NULL, segment_mean, pk_lres_flag_level_mm);

pk_nap_summary_mm_2 :=  if(pk_nap_summary_mm = NULL, segment_mean, pk_nap_summary_mm);

pk_naprop_level2_mm_2 :=  if(pk_naprop_level2_mm = NULL, segment_mean, pk_naprop_level2_mm);

pk_nas_summary_mm_2 :=  if(pk_nas_summary_mm = NULL, segment_mean, pk_nas_summary_mm);

pk_out_st_division_lvl_mm_2 :=  if(pk_out_st_division_lvl_mm = NULL, segment_mean, pk_out_st_division_lvl_mm);

pk_phones_per_adl_mm_2 :=  if(pk_phones_per_adl_mm = NULL, segment_mean, pk_phones_per_adl_mm);

pk_pl_sourced_level_mm_2 :=  if(pk_pl_sourced_level_mm = NULL, segment_mean, pk_pl_sourced_level_mm);

pk_pos_secondary_sources_mm_2 :=  if(pk_pos_secondary_sources_mm = NULL, segment_mean, pk_pos_secondary_sources_mm);

pk_pr_count_mm_2 :=  if(pk_pr_count_mm = NULL, segment_mean, pk_pr_count_mm);

pk_prof_lic_cat_mm_2 :=  if(pk_prof_lic_cat_mm = NULL, segment_mean, pk_prof_lic_cat_mm);

pk_prop_own_assess_tot2_mm_2 :=  if(pk_prop_own_assess_tot2_mm = NULL, segment_mean, pk_prop_own_assess_tot2_mm);

pk_property_owned_total_mm_2 :=  if(pk_property_owned_total_mm = NULL, segment_mean, pk_property_owned_total_mm);

pk_rc_addrcount_mm_2 :=  if(pk_rc_addrcount_mm = NULL, segment_mean, pk_rc_addrcount_mm);

pk_rc_addrcount_nb_mm_2 :=  if(pk_rc_addrcount_nb_mm = NULL, segment_mean, pk_rc_addrcount_nb_mm);

pk_rc_disthphoneaddr_mm_2 :=  if(pk_rc_disthphoneaddr_mm = NULL, segment_mean, pk_rc_disthphoneaddr_mm);

pk_rc_fnamecount_mm_2 :=  if(pk_rc_fnamecount_mm = NULL, segment_mean, pk_rc_fnamecount_mm);

pk_rc_lnamecount_nb_mm_2 :=  if(pk_rc_lnamecount_nb_mm = NULL, segment_mean, pk_rc_lnamecount_nb_mm);

pk_rc_phonelnamecount_mm_2 :=  if(pk_rc_phonelnamecount_mm = NULL, segment_mean, pk_rc_phonelnamecount_mm);

pk_rc_phonephonecount_mm_2 :=  if(pk_rc_phonephonecount_mm = NULL, segment_mean, pk_rc_phonephonecount_mm);

pk_ssnchar_invalid_or_recent_mm_2 :=  if(pk_ssnchar_invalid_or_recent_mm = NULL, segment_mean, pk_ssnchar_invalid_or_recent_mm);

pk_ssns_per_addr_c6_mm_2 :=  if(pk_ssns_per_addr_c6_mm = NULL, segment_mean, pk_ssns_per_addr_c6_mm);

pk_ssns_per_addr2_mm_2 :=  if(pk_ssns_per_addr2_mm = NULL, segment_mean, pk_ssns_per_addr2_mm);

pk_ssns_per_adl_c6_mm_2 :=  if(pk_ssns_per_adl_c6_mm = NULL, segment_mean, pk_ssns_per_adl_c6_mm);

pk_ssns_per_adl_mm_2 :=  if(pk_ssns_per_adl_mm = NULL, segment_mean, pk_ssns_per_adl_mm);

pk_ver_phncount_mm_2 :=  if(pk_ver_phncount_mm = NULL, segment_mean, pk_ver_phncount_mm);

pk_voter_flag_mm_2 :=  if(pk_voter_flag_mm = NULL, segment_mean, pk_voter_flag_mm);

pk_wealth_index_mm_2 :=  if(pk_wealth_index_mm = NULL, segment_mean, pk_wealth_index_mm);

pk_yr_add1_date_first_seen2_mm_2 :=  if(pk_yr_add1_date_first_seen2_mm = NULL, segment_mean, pk_yr_add1_date_first_seen2_mm);

pk_yr_add1_mortgage_date2_mm_2 :=  if(pk_yr_add1_mortgage_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_date2_mm);

pk_yr_add1_mortgage_due_date2_mm_2 :=  if(pk_yr_add1_mortgage_due_date2_mm = NULL, segment_mean, pk_yr_add1_mortgage_due_date2_mm);

pk_yr_add2_assess_val_yr2_mm_2 :=  if(pk_yr_add2_assess_val_yr2_mm = NULL, segment_mean, pk_yr_add2_assess_val_yr2_mm);

pk_yr_add2_date_first_seen2_mm_2 :=  if(pk_yr_add2_date_first_seen2_mm = NULL, segment_mean, pk_yr_add2_date_first_seen2_mm);

pk_yr_add2_mortgage_due_date2_mm_2 :=  if(pk_yr_add2_mortgage_due_date2_mm = NULL, segment_mean, pk_yr_add2_mortgage_due_date2_mm);

pk_yr_add3_date_first_seen2_mm_2 :=  if(pk_yr_add3_date_first_seen2_mm = NULL, segment_mean, pk_yr_add3_date_first_seen2_mm);

pk_yr_adl_em_only_first_seen2_mm_2 :=  if(pk_yr_adl_em_only_first_seen2_mm = NULL, segment_mean, pk_yr_adl_em_only_first_seen2_mm);

pk_yr_adl_pr_first_seen2_mm_2 :=  if(pk_yr_adl_pr_first_seen2_mm = NULL, segment_mean, pk_yr_adl_pr_first_seen2_mm);

pk_yr_adl_w_first_seen2_mm_2 :=  if(pk_yr_adl_w_first_seen2_mm = NULL, segment_mean, pk_yr_adl_w_first_seen2_mm);

pk_yr_ams_dob2_mm_2 :=  if(pk_yr_ams_dob2_mm = NULL, segment_mean, pk_yr_ams_dob2_mm);

pk_yr_criminal_last_date2_mm_2 :=  if(pk_yr_criminal_last_date2_mm = NULL, segment_mean, pk_yr_criminal_last_date2_mm);

pk_yr_felony_last_date2_mm_2 :=  if(pk_yr_felony_last_date2_mm = NULL, segment_mean, pk_yr_felony_last_date2_mm);

pk_yr_gong_did_first_seen2_mm_2 :=  if(pk_yr_gong_did_first_seen2_mm = NULL, segment_mean, pk_yr_gong_did_first_seen2_mm);

pk_yr_header_first_seen2_mm_2 :=  if(pk_yr_header_first_seen2_mm = NULL, segment_mean, pk_yr_header_first_seen2_mm);

pk_yr_in_dob2_mm_2 :=  if(pk_yr_in_dob2_mm = NULL, segment_mean, pk_yr_in_dob2_mm);

pk_yr_infutor_first_seen2_mm_2 :=  if(pk_yr_infutor_first_seen2_mm = NULL, segment_mean, pk_yr_infutor_first_seen2_mm);

pk_yr_liens_last_unrel_date3_mm_2 :=  if(pk_yr_liens_last_unrel_date3_mm = NULL, segment_mean, pk_yr_liens_last_unrel_date3_mm);

pk_yr_lname_change_date2_mm_2 :=  if(pk_yr_lname_change_date2_mm = NULL, segment_mean, pk_yr_lname_change_date2_mm);

pk_yr_rc_ssnhighissue2_mm_2 :=  if(pk_yr_rc_ssnhighissue2_mm = NULL, segment_mean, pk_yr_rc_ssnhighissue2_mm);

pk_yr_reported_dob2_mm_2 :=  if(pk_yr_reported_dob2_mm = NULL, segment_mean, pk_yr_reported_dob2_mm);

pk_yrmo_adl_f_sn_mx_fcra2_mm_2 :=  if(pk_yrmo_adl_f_sn_mx_fcra2_mm = NULL, segment_mean, pk_yrmo_adl_f_sn_mx_fcra2_mm);

pk2_add1_avm_auto_mm_2 :=  if(pk2_add1_avm_auto_mm = NULL, segment_mean, pk2_add1_avm_auto_mm);

pk2_add1_avm_auto2_mm_2 :=  if(pk2_add1_avm_auto2_mm = NULL, segment_mean, pk2_add1_avm_auto2_mm);

pk2_add1_avm_auto3_mm_2 :=  if(pk2_add1_avm_auto3_mm = NULL, segment_mean, pk2_add1_avm_auto3_mm);

pk2_add1_avm_med_mm_2 :=  if(pk2_add1_avm_med_mm = NULL, segment_mean, pk2_add1_avm_med_mm);

pk2_add1_avm_mkt_mm_2 :=  if(pk2_add1_avm_mkt_mm = NULL, segment_mean, pk2_add1_avm_mkt_mm);

pk2_add1_avm_pi_mm_2 :=  if(pk2_add1_avm_pi_mm = NULL, segment_mean, pk2_add1_avm_pi_mm);

pk2_add1_avm_to_med_ratio_mm_2 :=  if(pk2_add1_avm_to_med_ratio_mm = NULL, segment_mean, pk2_add1_avm_to_med_ratio_mm);

pk2_add2_avm_auto_mm_2 :=  if(pk2_add2_avm_auto_mm = NULL, segment_mean, pk2_add2_avm_auto_mm);

pk2_add2_avm_auto3_mm_2 :=  if(pk2_add2_avm_auto3_mm = NULL, segment_mean, pk2_add2_avm_auto3_mm);

pk2_add2_avm_hed_mm_2 :=  if(pk2_add2_avm_hed_mm = NULL, segment_mean, pk2_add2_avm_hed_mm);

pk2_add2_avm_pi_mm_2 :=  if(pk2_add2_avm_pi_mm = NULL, segment_mean, pk2_add2_avm_pi_mm);

pk2_add2_avm_sp_mm_2 :=  if(pk2_add2_avm_sp_mm = NULL, segment_mean, pk2_add2_avm_sp_mm);

pk2_add2_avm_ta_mm_2 :=  if(pk2_add2_avm_ta_mm = NULL, segment_mean, pk2_add2_avm_ta_mm);

pk2_yr_add1_avm_assess_year_mm_2 :=  if(pk2_yr_add1_avm_assess_year_mm = NULL, segment_mean, pk2_yr_add1_avm_assess_year_mm);

pk2_yr_add1_avm_rec_dt_mm_2 :=  if(pk2_yr_add1_avm_rec_dt_mm = NULL, segment_mean, pk2_yr_add1_avm_rec_dt_mm);

addprob3_mod_dm_b1 := -2.98118115 +
    ((integer)addrs_prison_history * 1.3217729609) +
    ((real)rc_cityzipflag * 0.5753437491) +
    (pk_add_standarization_flag * 0.2398834491);

phnprob_mod_dm_b1 := -2.860252827 +
    (pk_phn_cell_pager_inval * 0.3654336853) +
    (pk_disconnected * 0.2286947492);

ssnprob2_mod_dm_b1 := -3.693321989 +
    ((integer)ssn_issued18 * -0.415175794) +
    ((integer)ssn_adl_prob * 0.3017203371) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 15.602378044) +
    (pk_adl_cat_deceased * 0.6491463161);

fp_mod5_dm_b1 := -5.471286756 +
    ((100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))) * 0.1261549046) +
    ((100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))) * 0.126428946) +
    ((100 * (exp(ssnprob2_mod_dm_b1) / (1 + exp(ssnprob2_mod_dm_b1)))) * 0.1470935838) +
    (pk_rc_disthphoneaddr_mm_2 * 8.8284351219);

age_mod3_dm_b1 := -3.926129785 +
    (pk_yr_in_dob2_mm_2 * 5.8732458778) +
    (pk_inferred_age_mm_2 * 2.977585865) +
    (pk_yr_reported_dob2_mm_2 * 3.9219800445) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 5.6155482577);

amstudent_mod_dm_b1 := -6.056815607 +
    (pk_ams_class_level_mm_2 * 9.5290646124) +
    (pk_ams_college_type_mm_2 * 38.45524872) +
    (pk_ams_income_level_code_mm_2 * 12.8143601);

avm_mod_dm_b1 := -7.004873756 +
    (pk_add2_avm_auto_diff2_lvl_mm_2 * 23.928779354) +
    (pk2_add1_avm_auto_mm_2 * 5.223639562) +
    (pk2_add1_avm_auto3_mm_2 * 9.3070394845) +
    (pk2_add1_avm_med_mm_2 * 10.25739943) +
    (pk2_add2_avm_sp_mm_2 * 10.656409759) +
    (pk2_add2_avm_ta_mm_2 * 8.0899207238) +
    (pk2_yr_add1_avm_assess_year_mm_2 * 11.377458485);

derog_mod3_dm_b1 := -5.386097644 +
    ((integer)rc_watchlist_flag * -1.189289094) +
    (pk_bk_level_mm_2 * 11.24915835) +
    (pk_yr_criminal_last_date2_mm_2 * 9.1076829664) +
    (pk_yr_felony_last_date2_mm_2 * 6.8075981644) +
    (pk_attr_total_number_derogs_mm_2 * 9.8176085916) +
    (pk_eviction_level_mm_2 * 10.215822416);

lien_mod_dm_b1 := -4.174640366 +
    (pk_lien_type_level_mm_2 * 10.230859832) +
    (pk_yr_liens_last_unrel_date3_mm_2 * 13.573812066);

lres_mod_dm_b1 := -5.957723144 +
    (pk_add1_lres_mm_2 * 11.908525042) +
    (pk_add2_lres_mm_2 * 8.5157180331) +
    (pk_add3_lres_mm_2 * 15.003261079) +
    (pk_addrs_15yr_mm_2 * 14.971546801) +
    (pk_add_lres_month_avg2_mm_2 * 7.2346809937);

property_mod_dm_b1 := -17.83151196 +
    (pk_add1_adjustable_financing * 0.308228732) +
    (pk_add3_adjustable_financing * 0.2237546663) +
    (pk_attr_num_sold180 * -0.338593967) +
    (pk_yr_adl_pr_first_seen2_mm_2 * 10.579485531) +
    (pk_yr_adl_w_first_seen2_mm_2 * 16.250036488) +
    (pk_add1_mortgage_risk_mm_2 * 21.355363614) +
    (pk_add1_assessed_amount2_mm_2 * 12.679049081) +
    (pk_yr_add1_mortgage_due_date2_mm_2 * 20.377353353) +
    (pk_yr_add1_date_first_seen2_mm_2 * 12.150397769) +
    (pk_add1_building_area2_mm_2 * 7.7170683862) +
    (pk_add1_no_of_rooms_mm_2 * 11.100791686) +
    (pk_property_owned_total_mm_2 * 7.8550698026) +
    (pk_add2_building_area2_mm_2 * 15.671680893) +
    (pk_add2_no_of_buildings_mm_2 * 41.388735347) +
    (pk_yr_add2_assess_val_yr2_mm_2 * 16.494864055) +
    (pk_yr_add2_mortgage_due_date2_mm_2 * 21.007980386) +
    (pk_add2_assessed_amount2_mm_2 * 12.741910067) +
    (pk_yr_add2_date_first_seen2_mm_2 * 12.012393704) +
    (pk_add3_mortgage_risk_mm_2 * 23.684772547) +
    (pk_add3_assessed_amount2_mm_2 * 12.88636966) +
    (pk_yr_add3_date_first_seen2_mm_2 * 10.606204059);

velocity2_mod_dm_b1 := -8.60537603 +
    (pk_vo_addrs_per_adl * -0.153588396) +
    (pk_addrs_per_adl_mm_2 * 16.147179327) +
    (pk_phones_per_adl_mm_2 * 15.328831107) +
    (pk_adlperssn_count_mm_2 * 25.766724158) +
    (pk_adls_per_addr_mm_2 * 12.305477245) +
    (pk_adls_per_phone_mm_2 * 7.7947965641) +
    (pk_ssns_per_adl_c6_mm_2 * 9.1060572014) +
    (pk_ssns_per_addr_c6_mm_2 * 9.0472519076) +
    (pk_attr_addrs_last90_mm_2 * 5.8288341483) +
    (pk_attr_addrs_last24_mm_2 * 9.0603520069);

ver_best_element_cnt_mod_dm_b1 := -5.40911256 +
    (pk_rc_addrcount_mm_2 * 10.484551877) +
    (pk_ver_phncount_mm_2 * 12.137233614) +
    (pk_gong_did_phone_ct_mm_2 * 14.09812665) +
    (pk_combo_dobcount_mm_2 * 13.359880193);

ver_best_src_cnt_mod_dm_b1 := -7.757016104 +
    (pk_eq_count_mm_2 * 12.24139908) +
    (pk_voter_flag_mm_2 * 14.161296228) +
    (pk_lname_eda_sourced_type_lvl_mm_2 * 13.877284072) +
    (pk_add2_em_ver_lvl_mm_2 * 29.343073952) +
    (pk_infutor_risk_lvl_mm_2 * 15.769978388) +
    (pk_attr_num_nonderogs90_b_mm_2 * 15.31136312);

ver_best_src_time_mod_dm_b1 := -5.580616139 +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 7.6536281381) +
    (pk_yr_gong_did_first_seen2_mm_2 * 16.486698325) +
    (pk_yr_header_first_seen2_mm_2 * 8.7265546438) +
    (pk_yr_infutor_first_seen2_mm_2 * 20.757739442);

ver_notbest_element_cnt_mod_dm_b1 := -4.993144259 +
    (pk_combo_fnamecount_nb_mm_2 * 6.4142498064) +
    (pk_rc_phonelnamecount_mm_2 * 11.183180492) +
    (pk_rc_addrcount_nb_mm_2 * 9.2241034242) +
    (pk_combo_dobcount_nb_mm_2 * 6.2220116249);

ver_notbest_src_cnt_mod_dm_b1 := -8.343204714 +
    (pk_eq_count_mm_2 * 6.413898897) +
    (pk_pos_secondary_sources_mm_2 * 33.640447863) +
    (pk_voter_flag_mm_2 * 7.8501781429) +
    (pk_nas_summary_mm_2 * 7.5854993925) +
    (pk_nap_summary_mm_2 * 12.5361742) +
    (pk_add2_pos_sources_mm_2 * 9.8876769511) +
    (pk_attr_num_nonderogs90_b_mm_2 * 4.0299225897);

ver_notbest_src_time_mod_dm_b1 := -5.193763197 +
    (pk_yr_gong_did_first_seen2_mm_2 * 10.058526137) +
    (pk_yr_header_first_seen2_mm_2 * 6.3133993231) +
    (pk_yr_infutor_first_seen2_mm_2 * 15.180925049) +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 4.8060284551);

ver_element_cnt_mod_dm_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_dm_b1) / (1 + exp(ver_best_element_cnt_mod_dm_b1)))), (100 * (exp(ver_notbest_element_cnt_mod_dm_b1) / (1 + exp(ver_notbest_element_cnt_mod_dm_b1)))));

ver_src_cnt_mod_dm_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))), (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1)))));

ver_src_time_mod_dm_b1 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_dm_b1) / (1 + exp(ver_best_src_time_mod_dm_b1)))), (100 * (exp(ver_notbest_src_time_mod_dm_b1) / (1 + exp(ver_notbest_src_time_mod_dm_b1)))));

mod14_dm_b1 := -6.848548184 +
    (pk_out_st_division_lvl_mm_2 * 16.510863319) +
    ((100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))) * 0.0644117153) +
    ((100 * (exp(age_mod3_dm_b1) / (1 + exp(age_mod3_dm_b1)))) * 0.0161378747) +
    ((100 * (exp(amstudent_mod_dm_b1) / (1 + exp(amstudent_mod_dm_b1)))) * 0.0330817661) +
    ((100 * (exp(velocity2_mod_dm_b1) / (1 + exp(velocity2_mod_dm_b1)))) * 0.0473145662) +
    ((100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))) * -0.039008312) +
    (pk_prof_lic_cat_mm_2 * 11.444047148) +
    ((100 * (exp(fp_mod5_dm_b1) / (1 + exp(fp_mod5_dm_b1)))) * 0.0500654249) +
    ((100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))) * 0.0403098001) +
    ((100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))) * 0.068772547) +
    ((100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))) * 0.0850678463) +
    (pk_estimated_income_mm_2 * 4.2747515072) +
    (ver_element_cnt_mod_dm_b1 * 0.0213985437) +
    (ver_src_time_mod_dm_b1 * 0.0168046853);

addprob3_mod_om_b2 := -4.210436249 +
    (pk_addr_not_valid * 0.341073859) +
    ((real)rc_cityzipflag * 1.2867332645) +
    (pk_corp_mil_zip * 0.9899687099);

phnprob_mod_om_b2 := -4.212516495 +
    (pk_phn_cell_pager_inval * 0.8386568664) +
    ((integer)phn_zipmismatch * 0.8780160903) +
    (pk_disconnected * 0.2522001607);

ssnprob2_mod_om_b2 := -4.975326863 +
    ((integer)ssn_issued18 * -0.197250507) +
    ((integer)ssn_adl_prob * 0.3538444012) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 54.186119749);

fp_mod5_om_b2 := -6.086627318 +
    ((100 * (exp(addprob3_mod_om_b2) / (1 + exp(addprob3_mod_om_b2)))) * 0.2401302669) +
    ((100 * (exp(phnprob_mod_om_b2) / (1 + exp(phnprob_mod_om_b2)))) * 0.326644804) +
    ((100 * (exp(ssnprob2_mod_om_b2) / (1 + exp(ssnprob2_mod_om_b2)))) * 0.3421083588) +
    (pk_multi_did * 0.4618392174) +
    (pk_rc_disthphoneaddr_mm_2 * 28.441972917);

age_mod3_nodob_om_b2 := -5.374420853 +
    (pk_yr_ams_dob2_mm_2 * 7.4178575348) +
    (pk_inferred_age_mm_2 * 21.581367961) +
    (pk_yr_reported_dob2_mm_2 * 8.2694848191) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 34.381128935);

age_mod3_om_b2 := -5.262970277 +
    (pk_yr_in_dob2_mm_2 * 16.821129374) +
    (pk_inferred_age_mm_2 * 12.432678956) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 34.594333992);

avm_mod_om_b2 := -18.09819348 +
    (pk_avm_hit_level_mm_2 * 60.630917) +
    (pk_avm_auto_diff2_lvl_mm_2 * 50.604490596) +
    (pk_avm_auto_diff4_lvl_mm_2 * 429.27633482) +
    (pk_add2_avm_auto_diff2_lvl_mm_2 * 54.737319423) +
    (pk2_add1_avm_mkt_mm_2 * 17.084719023) +
    (pk2_add1_avm_auto2_mm_2 * 30.085078389) +
    (pk2_add1_avm_med_mm_2 * 27.509080214) +
    (pk2_add1_avm_to_med_ratio_mm_2 * 62.791063902) +
    (pk2_add2_avm_pi_mm_2 * 38.780531817) +
    (pk2_add2_avm_hed_mm_2 * 25.707565055) +
    (pk2_yr_add1_avm_rec_dt_mm_2 * 71.531279176) +
    (pk2_yr_add1_avm_assess_year_mm_2 * 49.383662915);

property_mod_om_b2 := -13.72196122 +
    (pk_nas_summary_p * -0.459338219) +
    (pk_addrs_sourced_lvl_mm_2 * 73.576333722) +
    (pk_naprop_level2_mm_2 * 24.210734184) +
    (pk_add1_purchase_amount2_mm_2 * 67.582543642) +
    (pk_yr_add1_mortgage_date2_mm_2 * 41.401325795) +
    (pk_add1_mortgage_risk_mm_2 * 27.148155579) +
    (pk_add1_assessed_amount2_mm_2 * 25.571001048) +
    (pk_yr_add1_mortgage_due_date2_mm_2 * 20.325465334) +
    (pk_yr_add1_date_first_seen2_mm_2 * 34.041609774) +
    (pk_add1_building_area2_mm_2 * 25.5006003) +
    (pk_add1_no_of_rooms_mm_2 * 34.705543618) +
    (pk_property_owned_total_mm_2 * 63.784510813) +
    (pk_prop_own_assess_tot2_mm_2 * 25.243170961) +
    (pk_add2_building_area2_mm_2 * 71.828897492) +
    (pk_yr_add2_assess_val_yr2_mm_2 * 49.112328303) +
    (pk_yr_add2_date_first_seen2_mm_2 * 35.958943757) +
    (pk_yr_add3_date_first_seen2_mm_2 * 25.542418052);

velocity2_mod_om_b2 := -7.29128331 +
    (pk_vo_addrs_per_adl * -0.093710582) +
    (pk_ssns_per_adl_mm_2 * 42.041041352) +
    (pk_adls_per_phone_mm_2 * 45.203198358) +
    (pk_ssns_per_adl_c6_mm_2 * 21.238904271) +
    (pk_ssns_per_addr_c6_mm_2 * 17.680716273) +
    (pk_attr_addrs_last24_mm_2 * 31.273462828) +
    (pk_ssns_per_addr2_mm_2 * 42.072351302);

ver_best_src_cnt_mod_om_b2 := -10.5944031 +
    (pk_eq_count_mm_2 * 55.702623441) +
    (pk_pos_secondary_sources_mm_2 * 81.629987119) +
    (pk_voter_flag_mm_2 * 59.601880039) +
    (pk_lname_eda_sourced_type_lvl_mm_2 * 53.331612953) +
    (pk_em_only_ver_lvl_mm_2 * 86.102648876) +
    (pk_infutor_risk_lvl_mm_2 * 41.83097569) +
    (pk_nas_summary_mm_2 * 47.423860427) +
    (pk_attr_num_nonderogs90_b_mm_2 * 33.630673942);

ver_best_src_time_mod_om_b2 := -6.894707566 +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 31.119678078) +
    (pk_yr_gong_did_first_seen2_mm_2 * 36.927190715) +
    (pk_yr_header_first_seen2_mm_2 * 23.171122064) +
    (pk_yr_infutor_first_seen2_mm_2 * 56.869010066) +
    (pk_yr_lname_change_date2_mm_2 * 36.437667818);

ver_notbest_src_cnt_mod_om_b2 := -9.076264433 +
    (pk_eq_count_mm_2 * 26.370872232) +
    (pk_em_only_ver_lvl_mm_2 * 62.487809286) +
    (pk_infutor_risk_lvl_nb_mm_2 * 20.692903786) +
    (pk_nas_summary_mm_2 * 27.153146664) +
    (pk_nap_summary_mm_2 * 32.576685607) +
    (pk_add2_pos_sources_mm_2 * 39.520259684) +
    (pk_attr_num_nonderogs90_b_mm_2 * 16.751097789);

ver_notbest_src_time_mod_om_b2 := -6.659335964 +
    (pk_yr_adl_em_only_first_seen2_mm_2 * 52.479980055) +
    (pk_yr_header_first_seen2_mm_2 * 13.868040695) +
    (pk_yr_infutor_first_seen2_mm_2 * 36.019017641) +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 21.018404752);

ver_src_time_mod_om_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_om_b2) / (1 + exp(ver_best_src_time_mod_om_b2)))), (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2)))));

ver_src_cnt_mod_om_b2 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))), (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2)))));

mod14_om_b2 := -9.325731178 +
    (pk_out_st_division_lvl_mm_2 * 39.27544798) +
    (pk_wealth_index_mm_2 * 21.752563863) +
    (pk_dist_a1toa3_mm_2 * 112.46672224) +
    ((100 * (exp(avm_mod_om_b2) / (1 + exp(avm_mod_om_b2)))) * 0.1588929076) +
    ((100 * (exp(age_mod3_om_b2) / (1 + exp(age_mod3_om_b2)))) * 0.1130882278) +
    ((100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))) * 0.1356124059) +
    (pk_prof_lic_cat_mm_2 * 57.06527204) +
    ((100 * (exp(fp_mod5_om_b2) / (1 + exp(fp_mod5_om_b2)))) * 0.0788956395) +
    ((100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))) * 0.1407568057) +
    (pk_estimated_income_mm_2 * 13.606895489) +
    (ver_src_cnt_mod_om_b2 * 0.1665516443) +
    (ver_src_time_mod_om_b2 * 0.0305458121);

addprob3_mod_rm_b3 := -2.899138881 +
    ((real)rc_cityzipflag * 0.4876658651) +
    (pk_corp_mil_zip * 0.5800854355);

phnprob_mod_rm_b3 := -2.948818804 +
    (pk_disconnected * 0.129849483) +
    ((integer)pk_phn_not_residential * 0.179254911) +
    (pk_area_code_split * 0.2189968871);

ssnprob2_mod_rm_b3 := -3.577274034 +
    ((integer)ssn_prob * -1.138023429) +
    ((integer)ssn_issued18 * -0.702935791) +
    ((integer)ssn_adl_prob * 0.3195398016) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 16.0557885);

fp_mod5_rm_b3 := -4.96533555 +
    ((100 * (exp(addprob3_mod_rm_b3) / (1 + exp(addprob3_mod_rm_b3)))) * 0.0740208569) +
    ((100 * (exp(phnprob_mod_rm_b3) / (1 + exp(phnprob_mod_rm_b3)))) * 0.1297582888) +
    ((100 * (exp(ssnprob2_mod_rm_b3) / (1 + exp(ssnprob2_mod_rm_b3)))) * 0.1770753432);

age_mod3_nodob_rm_b3 := -4.58676018 +
    (pk_yr_ams_dob2_mm_2 * 3.1605373916) +
    (pk_inferred_age_mm_2 * 10.018111351) +
    (pk_yr_reported_dob2_mm_2 * 3.3436235005) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 11.777079606);

age_mod3_rm_b3 := -4.102489235 +
    (pk_yr_in_dob2_mm_2 * 7.7091580922) +
    (pk_inferred_age_mm_2 * 3.4100617994) +
    (pk_yr_reported_dob2_mm_2 * 1.9957871857) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 5.7923307452);

amstudent_mod_rm_b3 := -5.309852364 +
    (pk_ams_class_level_mm_2 * 9.0255992766) +
    (pk_ams_4yr_college_mm_2 * 26.393183949) +
    (pk_ams_income_level_code_mm_2 * 9.2612441586);

avm_mod_rm_b3 := -6.088484399 +
    (pk_avm_confidence_level_mm_2 * 15.946094302) +
    (pk2_add1_avm_auto2_mm_2 * 6.9076058844) +
    (pk2_add1_avm_med_mm_2 * 10.803067726) +
    (pk2_add2_avm_sp_mm_2 * 8.3339968231) +
    (pk2_add2_avm_auto_mm_2 * 5.5827195092) +
    (pk2_yr_add1_avm_rec_dt_mm_2 * 12.216245436);

distance_mod2_rm_b3 := -4.036095334 +
    (pk_dist_a1toa2_mm_2 * 4.2910562992) +
    (pk_dist_a1toa3_mm_2 * 16.392638415);

lres_mod_rm_b3 := -5.715290965 +
    (pk_add1_lres_mm_2 * 11.482977792) +
    (pk_add2_lres_mm_2 * 4.823648317) +
    (pk_add3_lres_mm_2 * 7.1429938724) +
    (pk_lres_flag_level_mm_2 * 3.2252793822) +
    (pk_addrs_5yr_mm_2 * 16.593426233) +
    (pk_add_lres_month_avg2_mm_2 * 7.0758003451);

property_mod_rm_b3 := -13.11332533 +
    (pk_pr_count_mm_2 * 15.362976629) +
    (pk_naprop_level2_mm_2 * 11.250047033) +
    (pk_add1_purchase_amount2_mm_2 * 6.4844913402) +
    (pk_yr_add1_mortgage_date2_mm_2 * 8.6544626373) +
    (pk_add1_assessed_amount2_mm_2 * 9.3517507086) +
    (pk_yr_add1_date_first_seen2_mm_2 * 15.742371209) +
    (pk_add1_no_of_baths_mm_2 * 8.8340820817) +
    (pk_add2_building_area2_mm_2 * 17.362170524) +
    (pk_add2_garage_type_risk_lvl_mm_2 * 17.959041037) +
    (pk_add2_parking_no_of_cars_mm_2 * 19.696626271) +
    (pk_yr_add2_mortgage_due_date2_mm_2 * 20.52596988) +
    (pk_add2_assessed_amount2_mm_2 * 8.5056364587) +
    (pk_yr_add2_date_first_seen2_mm_2 * 9.1334087237) +
    (pk_add3_assessed_amount2_mm_2 * 10.525020121) +
    (pk_yr_add3_date_first_seen2_mm_2 * 9.5029297342);

velocity2_mod_rm_b3 := -9.84788978 +
    (pk_vo_addrs_per_adl * -0.288252744) +
    (pk_ssns_per_adl_mm_2 * 7.7049463685) +
    (pk_addrs_per_adl_mm_2 * 17.157558415) +
    (pk_phones_per_adl_mm_2 * 6.8821748519) +
    (pk_adlperssn_count_mm_2 * 39.272054929) +
    (pk_ssns_per_adl_c6_mm_2 * 9.4553830493) +
    (pk_ssns_per_addr_c6_mm_2 * 8.9058413489) +
    (pk_adls_per_phone_c6_mm_2 * 9.9833514503) +
    (pk_attr_addrs_last12_mm_2 * 9.1766684368) +
    (pk_attr_addrs_last24_mm_2 * 9.0957169961) +
    (pk_ssns_per_addr2_mm_2 * 11.758757313);

ver_best_element_cnt_mod_rm_b3 := -5.868454951 +
    (pk_rc_phonelnamecount_mm_2 * 13.382911274) +
    (pk_rc_addrcount_mm_2 * 9.0236490545) +
    (pk_gong_did_phone_ct_mm_2 * 9.6666138585) +
    (pk_combo_ssncount_mm_2 * 9.9516049995) +
    (pk_combo_dobcount_mm_2 * 17.018646642);

ver_best_src_cnt_mod_rm_b3 := -6.139422803 +
    (pk_eq_count_mm_2 * 15.27051744) +
    (pk_voter_flag_mm_2 * 11.993335326) +
    (pk_lname_eda_sourced_type_lvl_mm_2 * 16.089673535) +
    (pk_infutor_risk_lvl_mm_2 * 12.022197712) +
    (pk_attr_num_nonderogs90_b_mm_2 * 8.8406099883);

ver_notbest_element_cnt_mod_rm_b3 := -11.28415389 +
    (pk_rc_addrcount_nb_mm_2 * 12.057486577) +
    (pk_rc_phonephonecount_mm_2 * 84.778585964) +
    (pk_gong_did_phone_ct_nb_mm_2 * 6.1859504674) +
    (pk_combo_dobcount_nb_mm_2 * 12.887951234);

ver_notbest_src_cnt_mod_rm_b3 := -5.268635324 +
    (pk_eq_count_mm_2 * 11.561140609) +
    (pk_voter_flag_mm_2 * 8.0681013581) +
    (pk_nas_summary_mm_2 * 7.2146829195) +
    (pk_add2_pos_sources_mm_2 * 8.5004128152);

ver_element_cnt_mod_rm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_rm_b3) / (1 + exp(ver_best_element_cnt_mod_rm_b3)))), (100 * (exp(ver_notbest_element_cnt_mod_rm_b3) / (1 + exp(ver_notbest_element_cnt_mod_rm_b3)))));

ver_src_cnt_mod_rm_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))), (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3)))));

mod14_rm_b3 := -6.305889973 +
    (pk_did0 * -1.357364345) +
    (pk_out_st_division_lvl_mm_2 * 10.590524094) +
    (pk_wealth_index_mm_2 * 4.0195772153) +
    ((100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))) * -0.069316392) +
    ((100 * (exp(avm_mod_rm_b3) / (1 + exp(avm_mod_rm_b3)))) * 0.0487828676) +
    ((100 * (exp(age_mod3_rm_b3) / (1 + exp(age_mod3_rm_b3)))) * 0.0508630801) +
    ((100 * (exp(amstudent_mod_rm_b3) / (1 + exp(amstudent_mod_rm_b3)))) * 0.031803173) +
    ((100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))) * 0.0709521149) +
    ((100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))) * -0.019208521) +
    (pk_pl_sourced_level_mm_2 * 16.369052875) +
    ((100 * (exp(fp_mod5_rm_b3) / (1 + exp(fp_mod5_rm_b3)))) * 0.0422529494) +
    ((100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))) * 0.0327390126) +
    (pk_estimated_income_mm_2 * 4.1285289748) +
    (ver_src_cnt_mod_rm_b3 * 0.0172846033) +
    (ver_element_cnt_mod_rm_b3 * 0.0363312687);

addprob3_mod_xm_b4 := -3.23600769 +
    (invalid_addrs_per_adl_c6 * 1.2190123781) +
    ((real)rc_cityzipflag * 0.4755192192) +
    (pk_corp_mil_zip * 0.9710554564);

phnprob_mod_xm_b4 := -3.409041123 +
    ((integer)phn_highrisk2 * 0.5606599437) +
    ((integer)phn_zipmismatch * 0.3551895835) +
    (pk_disconnected * 0.1869820794) +
    ((integer)pk_phn_not_residential * 0.1708359355) +
    (pk_recent_ac_split * -0.136698676);

ssnprob2_mod_xm_b4 := -4.033963338 +
    ((integer)ssn_issued18 * -0.688856123) +
    ((integer)ssn_adl_prob * 0.4289303955) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 23.04132726);

fp_mod5_xm_b4 := -5.434889553 +
    ((100 * (exp(addprob3_mod_xm_b4) / (1 + exp(addprob3_mod_xm_b4)))) * 0.0960227346) +
    ((100 * (exp(phnprob_mod_xm_b4) / (1 + exp(phnprob_mod_xm_b4)))) * 0.1534762895) +
    ((100 * (exp(ssnprob2_mod_xm_b4) / (1 + exp(ssnprob2_mod_xm_b4)))) * 0.1950888748) +
    (pk_rc_disthphoneaddr_mm_2 * 10.523816657);

age_mod3_nodob_xm_b4 := -4.509257866 +
    (pk_inferred_age_mm_2 * 10.965832516) +
    (pk_yr_reported_dob2_mm_2 * 5.7620064068) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 10.711944923);

age_mod3_xm_b4 := -4.397921154 +
    (pk_yr_in_dob2_mm_2 * 9.205425258) +
    (pk_inferred_age_mm_2 * 4.2108267351) +
    (pk_yr_reported_dob2_mm_2 * 4.7046363625) +
    (pk_yr_rc_ssnhighissue2_mm_2 * 6.3745938169);

amstudent_mod_xm_b4 := -6.289855091 +
    (pk_ams_class_level_mm_2 * 13.542336035) +
    (pk_ams_4yr_college_mm_2 * 24.91989082) +
    (pk_ams_college_type_mm_2 * 22.830085738) +
    (pk_ams_income_level_code_mm_2 * 16.999143822);

avm_mod_xm_b4 := -7.445784735 +
    (pk_avm_hit_level_mm_2 * 18.635032348) +
    (pk2_add1_avm_mkt_mm_2 * 11.482614225) +
    (pk2_add1_avm_pi_mm_2 * 10.226829721) +
    (pk2_add1_avm_med_mm_2 * 15.648837638) +
    (pk2_add1_avm_to_med_ratio_mm_2 * 29.56278873) +
    (pk2_add2_avm_sp_mm_2 * 11.360485649) +
    (pk2_add2_avm_auto3_mm_2 * 12.085620318);

distance_mod2_xm_b4 := -4.378826958 +
    (pk_dist_a1toa2_mm_2 * 7.8960760557) +
    (pk_dist_a1toa3_mm_2 * 20.498506223);

property_mod_xm_b4 := -9.715196958 +
    (pk_pr_count_mm_2 * 19.958737512) +
    (pk_add1_mortgage_risk_mm_2 * 14.460881493) +
    (pk_add1_assessed_amount2_mm_2 * 16.79918831) +
    (pk_yr_add1_date_first_seen2_mm_2 * 20.298430472) +
    (pk_add1_land_use_risk_level_mm_2 * 28.652820998) +
    (pk_add1_building_area2_mm_2 * 16.575072428) +
    (pk_add2_assessed_amount2_mm_2 * 20.530651182) +
    (pk_yr_add2_date_first_seen2_mm_2 * 10.633477798) +
    (pk_yr_add3_date_first_seen2_mm_2 * 12.655260736);

velocity2_mod_xm_b4 := -9.757403022 +
    (pk_vo_addrs_per_adl * -0.187048061) +
    (pk_addrs_per_adl_mm_2 * 23.182822062) +
    (pk_adlperssn_count_mm_2 * 76.485267034) +
    (pk_adls_per_phone_mm_2 * 16.10087415) +
    (pk_ssns_per_adl_c6_mm_2 * 7.7029633147) +
    (pk_ssns_per_addr_c6_mm_2 * 10.764576486) +
    (pk_attr_addrs_last12_mm_2 * 6.5326003362) +
    (pk_attr_addrs_last24_mm_2 * 13.413697335) +
    (pk_ssns_per_addr2_mm_2 * 10.937256979);

ver_best_element_cnt_mod_xm_b4 := -6.004504544 +
    (pk_rc_phonelnamecount_mm_2 * 22.099841908) +
    (pk_rc_addrcount_mm_2 * 19.310763585) +
    (pk_combo_ssncount_mm_2 * 13.358777489) +
    (pk_combo_dobcount_mm_2 * 17.701309529);

ver_best_src_cnt_mod_xm_b4 := -6.419469979 +
    (pk_eq_count_mm_2 * 20.801603576) +
    (pk_voter_flag_mm_2 * 12.906609879) +
    (pk_lname_eda_sourced_type_lvl_mm_2 * 20.725667141) +
    (pk_infutor_risk_lvl_mm_2 * 13.984196616) +
    (pk_attr_num_nonderogs90_b_mm_2 * 15.745675221);

ver_best_src_time_mod_xm_b4 := -5.334943181 +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 15.177934324) +
    (pk_yr_header_first_seen2_mm_2 * 14.018299503) +
    (pk_yr_infutor_first_seen2_mm_2 * 22.493580305);

ver_notbest_element_cnt_mod_xm_b4 := -5.368316116 +
    (pk_rc_phonelnamecount_mm_2 * 15.517149562) +
    (pk_rc_addrcount_nb_mm_2 * 15.152227118) +
    (pk_combo_dobcount_nb_mm_2 * 12.758086091);

ver_notbest_src_cnt_mod_xm_b4 := -6.739842604 +
    ((integer)add3_source_E1 * 0.9717277568) +
    (pk_eq_count_mm_2 * 12.733358284) +
    (pk_lname_eda_sourced_type_lvl_mm_2 * 9.0173786904) +
    (pk_em_only_ver_lvl_mm_2 * 17.81342582) +
    (pk_infutor_risk_lvl_nb_mm_2 * 9.6874943353) +
    (pk_nas_summary_mm_2 * 10.397486127) +
    (pk_nap_summary_mm_2 * 8.8551899966);

ver_notbest_src_time_mod_xm_b4 := -4.934309689 +
    (pk_yr_header_first_seen2_mm_2 * 9.3789730356) +
    (pk_yr_infutor_first_seen2_mm_2 * 14.702232316) +
    (pk_yrmo_adl_f_sn_mx_fcra2_mm_2 * 11.03991787);

ver_element_cnt_mod_xm_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_element_cnt_mod_xm_b4) / (1 + exp(ver_best_element_cnt_mod_xm_b4)))), (100 * (exp(ver_notbest_element_cnt_mod_xm_b4) / (1 + exp(ver_notbest_element_cnt_mod_xm_b4)))));

ver_src_time_mod_xm_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4)))), (100 * (exp(ver_notbest_src_time_mod_xm_b4) / (1 + exp(ver_notbest_src_time_mod_xm_b4)))));

ver_src_cnt_mod_xm_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_src_cnt_mod_xm_b4) / (1 + exp(ver_best_src_cnt_mod_xm_b4)))), (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4)))));

mod14_xm_b4 := -7.034206978 +
    (pk_did0 * -1.697811884) +
    (pk_out_st_division_lvl_mm_2 * 21.79664711) +
    (pk_wealth_index_mm_2 * 11.454761445) +
    ((100 * (exp(distance_mod2_xm_b4) / (1 + exp(distance_mod2_xm_b4)))) * -0.094104544) +
    ((100 * (exp(avm_mod_xm_b4) / (1 + exp(avm_mod_xm_b4)))) * 0.0744733035) +
    ((100 * (exp(age_mod3_xm_b4) / (1 + exp(age_mod3_xm_b4)))) * 0.053529519) +
    ((100 * (exp(amstudent_mod_xm_b4) / (1 + exp(amstudent_mod_xm_b4)))) * 0.0573961344) +
    ((100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4)))) * 0.0585468554) +
    (pk_prof_lic_cat_mm_2 * 21.8864837) +
    ((100 * (exp(fp_mod5_xm_b4) / (1 + exp(fp_mod5_xm_b4)))) * 0.0327353382) +
    ((100 * (exp(property_mod_xm_b4) / (1 + exp(property_mod_xm_b4)))) * 0.0345683079) +
    (pk_estimated_income_mm_2 * 5.3611332541) +
    (ver_src_cnt_mod_xm_b4 * 0.0214164199) +
    (ver_element_cnt_mod_xm_b4 * 0.0568829169) +
    (ver_src_time_mod_xm_b4 * 0.0106057129);

velocity2_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                        pk_segment_2 = '1 Owner ' => NULL,
                        pk_segment_2 = '2 Renter' => (100 * (exp(velocity2_mod_rm_b3) / (1 + exp(velocity2_mod_rm_b3)))),
                                                     NULL);

lien_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(lien_mod_dm_b1) / (1 + exp(lien_mod_dm_b1)))),
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => NULL,
                                                NULL);

phat := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))),
            pk_segment_2 = '1 Owner ' => (exp(mod14_om_b2) / (1 + exp(mod14_om_b2))),
            pk_segment_2 = '2 Renter' => (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))),
                                         (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4))));

addprob3_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(addprob3_mod_dm_b1) / (1 + exp(addprob3_mod_dm_b1)))),
                       pk_segment_2 = '1 Owner ' => NULL,
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

ver_best_src_time_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_src_time_mod_dm_b1) / (1 + exp(ver_best_src_time_mod_dm_b1)))),
                                pk_segment_2 = '1 Owner ' => NULL,
                                pk_segment_2 = '2 Renter' => NULL,
                                                             NULL);

fp_mod5_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(fp_mod5_dm_b1) / (1 + exp(fp_mod5_dm_b1)))),
                  pk_segment_2 = '1 Owner ' => NULL,
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

age_mod3_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(age_mod3_dm_b1) / (1 + exp(age_mod3_dm_b1)))),
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => NULL,
                                                NULL);

ver_notbest_element_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                                      pk_segment_2 = '1 Owner ' => NULL,
                                      pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_element_cnt_mod_rm_b3) / (1 + exp(ver_notbest_element_cnt_mod_rm_b3)))),
                                                                   NULL);

age_mod3_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => (100 * (exp(age_mod3_rm_b3) / (1 + exp(age_mod3_rm_b3)))),
                                                NULL);

ver_notbest_src_time_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_src_time_mod_dm_b1) / (1 + exp(ver_notbest_src_time_mod_dm_b1)))),
                                   pk_segment_2 = '1 Owner ' => NULL,
                                   pk_segment_2 = '2 Renter' => NULL,
                                                                NULL);

property_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => (100 * (exp(property_mod_rm_b3) / (1 + exp(property_mod_rm_b3)))),
                                                    NULL);

addprob3_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => (100 * (exp(addprob3_mod_rm_b3) / (1 + exp(addprob3_mod_rm_b3)))),
                                                    NULL);

age_mod3_nodob_om := map(pk_segment_2 = '0 Derog ' => NULL,
                         pk_segment_2 = '1 Owner ' => (100 * (exp(age_mod3_nodob_om_b2) / (1 + exp(age_mod3_nodob_om_b2)))),
                         pk_segment_2 = '2 Renter' => NULL,
                                                      NULL);

velocity2_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                        pk_segment_2 = '1 Owner ' => (100 * (exp(velocity2_mod_om_b2) / (1 + exp(velocity2_mod_om_b2)))),
                        pk_segment_2 = '2 Renter' => NULL,
                                                     NULL);

ver_element_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                              pk_segment_2 = '1 Owner ' => NULL,
                              pk_segment_2 = '2 Renter' => ver_element_cnt_mod_rm_b3,
                                                           NULL);

property_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(property_mod_dm_b1) / (1 + exp(property_mod_dm_b1)))),
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => NULL,
                                                    NULL);

ver_notbest_src_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                                  pk_segment_2 = '1 Owner ' => NULL,
                                  pk_segment_2 = '2 Renter' => NULL,
                                                               (100 * (exp(ver_notbest_src_cnt_mod_xm_b4) / (1 + exp(ver_notbest_src_cnt_mod_xm_b4)))));

ssnprob2_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => (100 * (exp(ssnprob2_mod_om_b2) / (1 + exp(ssnprob2_mod_om_b2)))),
                       pk_segment_2 = '2 Renter' => NULL,
                                                    NULL);

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

age_mod3_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => NULL,
                                                (100 * (exp(age_mod3_xm_b4) / (1 + exp(age_mod3_xm_b4)))));

velocity2_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                        pk_segment_2 = '1 Owner ' => NULL,
                        pk_segment_2 = '2 Renter' => NULL,
                                                     (100 * (exp(velocity2_mod_xm_b4) / (1 + exp(velocity2_mod_xm_b4)))));

ssnprob2_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => (100 * (exp(ssnprob2_mod_rm_b3) / (1 + exp(ssnprob2_mod_rm_b3)))),
                                                    NULL);

ver_src_time_mod_dm := map(pk_segment_2 = '0 Derog ' => ver_src_time_mod_dm_b1,
                           pk_segment_2 = '1 Owner ' => NULL,
                           pk_segment_2 = '2 Renter' => NULL,
                                                        NULL);

avm_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(avm_mod_dm_b1) / (1 + exp(avm_mod_dm_b1)))),
                  pk_segment_2 = '1 Owner ' => NULL,
                  pk_segment_2 = '2 Renter' => NULL,
                                               NULL);

ver_best_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                               pk_segment_2 = '1 Owner ' => NULL,
                               pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_src_cnt_mod_rm_b3) / (1 + exp(ver_best_src_cnt_mod_rm_b3)))),
                                                            NULL);

ver_element_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                              pk_segment_2 = '1 Owner ' => NULL,
                              pk_segment_2 = '2 Renter' => NULL,
                                                           ver_element_cnt_mod_xm_b4);

ssnprob2_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => NULL,
                                                    (100 * (exp(ssnprob2_mod_xm_b4) / (1 + exp(ssnprob2_mod_xm_b4)))));

lres_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => (100 * (exp(lres_mod_rm_b3) / (1 + exp(lres_mod_rm_b3)))),
                                                NULL);

distance_mod2_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                        pk_segment_2 = '1 Owner ' => NULL,
                        pk_segment_2 = '2 Renter' => (100 * (exp(distance_mod2_rm_b3) / (1 + exp(distance_mod2_rm_b3)))),
                                                     NULL);

ver_best_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                               pk_segment_2 = '1 Owner ' => (100 * (exp(ver_best_src_cnt_mod_om_b2) / (1 + exp(ver_best_src_cnt_mod_om_b2)))),
                               pk_segment_2 = '2 Renter' => NULL,
                                                            NULL);

addprob3_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => NULL,
                                                    (100 * (exp(addprob3_mod_xm_b4) / (1 + exp(addprob3_mod_xm_b4)))));

age_mod3_nodob_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                         pk_segment_2 = '1 Owner ' => NULL,
                         pk_segment_2 = '2 Renter' => (100 * (exp(age_mod3_nodob_rm_b3) / (1 + exp(age_mod3_nodob_rm_b3)))),
                                                      NULL);

phnprob_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                      pk_segment_2 = '1 Owner ' => NULL,
                      pk_segment_2 = '2 Renter' => (100 * (exp(phnprob_mod_rm_b3) / (1 + exp(phnprob_mod_rm_b3)))),
                                                   NULL);

ver_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => ver_src_cnt_mod_dm_b1,
                          pk_segment_2 = '1 Owner ' => NULL,
                          pk_segment_2 = '2 Renter' => NULL,
                                                       NULL);

ver_best_element_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                                   pk_segment_2 = '1 Owner ' => NULL,
                                   pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_element_cnt_mod_rm_b3) / (1 + exp(ver_best_element_cnt_mod_rm_b3)))),
                                                                NULL);

ssnprob2_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ssnprob2_mod_dm_b1) / (1 + exp(ssnprob2_mod_dm_b1)))),
                       pk_segment_2 = '1 Owner ' => NULL,
                       pk_segment_2 = '2 Renter' => NULL,
                                                    NULL);

derog_mod3_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(derog_mod3_dm_b1) / (1 + exp(derog_mod3_dm_b1)))),
                     pk_segment_2 = '1 Owner ' => NULL,
                     pk_segment_2 = '2 Renter' => NULL,
                                                  NULL);

ver_src_time_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                           pk_segment_2 = '1 Owner ' => ver_src_time_mod_om_b2,
                           pk_segment_2 = '2 Renter' => NULL,
                                                        NULL);

mod14_om := map(pk_segment_2 = '0 Derog ' => NULL,
                pk_segment_2 = '1 Owner ' => (exp(mod14_om_b2) / (1 + exp(mod14_om_b2))),
                pk_segment_2 = '2 Renter' => NULL,
                                             NULL);

mod14_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                pk_segment_2 = '1 Owner ' => NULL,
                pk_segment_2 = '2 Renter' => NULL,
                                             (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4))));

ver_notbest_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                                  pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_cnt_mod_om_b2) / (1 + exp(ver_notbest_src_cnt_mod_om_b2)))),
                                  pk_segment_2 = '2 Renter' => NULL,
                                                               NULL);

ver_notbest_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                                  pk_segment_2 = '1 Owner ' => NULL,
                                  pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_src_cnt_mod_rm_b3) / (1 + exp(ver_notbest_src_cnt_mod_rm_b3)))),
                                                               NULL);

fp_mod5_om := map(pk_segment_2 = '0 Derog ' => NULL,
                  pk_segment_2 = '1 Owner ' => (100 * (exp(fp_mod5_om_b2) / (1 + exp(fp_mod5_om_b2)))),
                  pk_segment_2 = '2 Renter' => NULL,
                                               NULL);

ver_notbest_element_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_element_cnt_mod_dm_b1) / (1 + exp(ver_notbest_element_cnt_mod_dm_b1)))),
                                      pk_segment_2 = '1 Owner ' => NULL,
                                      pk_segment_2 = '2 Renter' => NULL,
                                                                   NULL);

ver_best_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_src_cnt_mod_dm_b1) / (1 + exp(ver_best_src_cnt_mod_dm_b1)))),
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

addprob3_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => (100 * (exp(addprob3_mod_om_b2) / (1 + exp(addprob3_mod_om_b2)))),
                       pk_segment_2 = '2 Renter' => NULL,
                                                    NULL);

fp_mod5_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                  pk_segment_2 = '1 Owner ' => NULL,
                  pk_segment_2 = '2 Renter' => (100 * (exp(fp_mod5_rm_b3) / (1 + exp(fp_mod5_rm_b3)))),
                                               NULL);

ver_notbest_element_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                                      pk_segment_2 = '1 Owner ' => NULL,
                                      pk_segment_2 = '2 Renter' => NULL,
                                                                   (100 * (exp(ver_notbest_element_cnt_mod_xm_b4) / (1 + exp(ver_notbest_element_cnt_mod_xm_b4)))));

amstudent_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(amstudent_mod_dm_b1) / (1 + exp(amstudent_mod_dm_b1)))),
                        pk_segment_2 = '1 Owner ' => NULL,
                        pk_segment_2 = '2 Renter' => NULL,
                                                     NULL);

ver_notbest_src_time_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                                   pk_segment_2 = '1 Owner ' => (100 * (exp(ver_notbest_src_time_mod_om_b2) / (1 + exp(ver_notbest_src_time_mod_om_b2)))),
                                   pk_segment_2 = '2 Renter' => NULL,
                                                                NULL);

mod14_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                pk_segment_2 = '1 Owner ' => NULL,
                pk_segment_2 = '2 Renter' => (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))),
                                             NULL);

ver_best_src_time_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                                pk_segment_2 = '1 Owner ' => NULL,
                                pk_segment_2 = '2 Renter' => NULL,
                                                             (100 * (exp(ver_best_src_time_mod_xm_b4) / (1 + exp(ver_best_src_time_mod_xm_b4)))));

ver_src_cnt_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                          pk_segment_2 = '1 Owner ' => ver_src_cnt_mod_om_b2,
                          pk_segment_2 = '2 Renter' => NULL,
                                                       NULL);

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

age_mod3_om := map(pk_segment_2 = '0 Derog ' => NULL,
                   pk_segment_2 = '1 Owner ' => (100 * (exp(age_mod3_om_b2) / (1 + exp(age_mod3_om_b2)))),
                   pk_segment_2 = '2 Renter' => NULL,
                                                NULL);

fp_mod5_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                  pk_segment_2 = '1 Owner ' => NULL,
                  pk_segment_2 = '2 Renter' => NULL,
                                               (100 * (exp(fp_mod5_xm_b4) / (1 + exp(fp_mod5_xm_b4)))));

phnprob_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(phnprob_mod_dm_b1) / (1 + exp(phnprob_mod_dm_b1)))),
                      pk_segment_2 = '1 Owner ' => NULL,
                      pk_segment_2 = '2 Renter' => NULL,
                                                   NULL);

ver_src_cnt_mod_rm := map(pk_segment_2 = '0 Derog ' => NULL,
                          pk_segment_2 = '1 Owner ' => NULL,
                          pk_segment_2 = '2 Renter' => ver_src_cnt_mod_rm_b3,
                                                       NULL);

phnprob_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                      pk_segment_2 = '1 Owner ' => NULL,
                      pk_segment_2 = '2 Renter' => NULL,
                                                   (100 * (exp(phnprob_mod_xm_b4) / (1 + exp(phnprob_mod_xm_b4)))));

mod14_scr := map(pk_segment_2 = '0 Derog ' => round(((-40 * ((ln(((exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))) / (1 - (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
                 pk_segment_2 = '1 Owner ' => round(((-40 * ((ln(((exp(mod14_om_b2) / (1 + exp(mod14_om_b2))) / (1 - (exp(mod14_om_b2) / (1 + exp(mod14_om_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
                 pk_segment_2 = '2 Renter' => round(((-40 * ((ln(((exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3))) / (1 - (exp(mod14_rm_b3) / (1 + exp(mod14_rm_b3)))))) - ln((1 / 20))) / ln(2))) + 700)),
                                              round(((-40 * ((ln(((exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4))) / (1 - (exp(mod14_xm_b4) / (1 + exp(mod14_xm_b4)))))) - ln((1 / 20))) / ln(2))) + 700)));

ver_best_element_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_best_element_cnt_mod_dm_b1) / (1 + exp(ver_best_element_cnt_mod_dm_b1)))),
                                   pk_segment_2 = '1 Owner ' => NULL,
                                   pk_segment_2 = '2 Renter' => NULL,
                                                                NULL);

ver_element_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => ver_element_cnt_mod_dm_b1,
                              pk_segment_2 = '1 Owner ' => NULL,
                              pk_segment_2 = '2 Renter' => NULL,
                                                           NULL);

lres_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(lres_mod_dm_b1) / (1 + exp(lres_mod_dm_b1)))),
                   pk_segment_2 = '1 Owner ' => NULL,
                   pk_segment_2 = '2 Renter' => NULL,
                                                NULL);

mod14_dm := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_b1) / (1 + exp(mod14_dm_b1))),
                pk_segment_2 = '1 Owner ' => NULL,
                pk_segment_2 = '2 Renter' => NULL,
                                             NULL);

phnprob_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                      pk_segment_2 = '1 Owner ' => (100 * (exp(phnprob_mod_om_b2) / (1 + exp(phnprob_mod_om_b2)))),
                      pk_segment_2 = '2 Renter' => NULL,
                                                   NULL);

ver_notbest_src_cnt_mod_dm := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ver_notbest_src_cnt_mod_dm_b1) / (1 + exp(ver_notbest_src_cnt_mod_dm_b1)))),
                                  pk_segment_2 = '1 Owner ' => NULL,
                                  pk_segment_2 = '2 Renter' => NULL,
                                                               NULL);

ver_src_time_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                           pk_segment_2 = '1 Owner ' => NULL,
                           pk_segment_2 = '2 Renter' => NULL,
                                                        ver_src_time_mod_xm_b4);

property_mod_om := map(pk_segment_2 = '0 Derog ' => NULL,
                       pk_segment_2 = '1 Owner ' => (100 * (exp(property_mod_om_b2) / (1 + exp(property_mod_om_b2)))),
                       pk_segment_2 = '2 Renter' => NULL,
                                                    NULL);

ver_best_element_cnt_mod_xm := map(pk_segment_2 = '0 Derog ' => NULL,
                                   pk_segment_2 = '1 Owner ' => NULL,
                                   pk_segment_2 = '2 Renter' => NULL,
                                                                (100 * (exp(ver_best_element_cnt_mod_xm_b4) / (1 + exp(ver_best_element_cnt_mod_xm_b4)))));

ssnprob2_mod_dm_nodob_b1_c2_b1 := -3.78390629 +
    ((integer)ssn_adl_prob * 0.2897471328) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 15.474107663) +
    (pk_adl_cat_deceased * 0.5241908095);

fp_mod5_dm_nodob_b1_c2_b1 := -5.476442991 +
    (addprob3_mod_dm * 0.1256878122) +
    (phnprob_mod_dm * 0.1330387228) +
    ((100 * (exp(ssnprob2_mod_dm_nodob_b1_c2_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1_c2_b1)))) * 0.1422799648) +
    (pk_rc_disthphoneaddr_mm_2 * 8.9638680348);

mod14_dm_nodob_b1_c2_b1 := -6.299063623 +
    (pk_out_st_division_lvl_mm_2 * 17.540926315) +
    (avm_mod_dm * 0.0633143413) +
    (amstudent_mod_dm * 0.0377058865) +
    (velocity2_mod_dm * 0.0475208588) +
    (lres_mod_dm * -0.036778249) +
    ((100 * (exp(fp_mod5_dm_nodob_b1_c2_b1) / (1 + exp(fp_mod5_dm_nodob_b1_c2_b1)))) * 0.0440798274) +
    (derog_mod3_dm * 0.0419247401) +
    (lien_mod_dm * 0.0681044709) +
    (property_mod_dm * 0.087573575) +
    (pk_estimated_income_mm_2 * 4.5587414718) +
    (ver_src_cnt_mod_dm * 0.0187664158) +
    (ver_src_time_mod_dm * 0.0269186956);

ssnprob2_mod_om_nodob_b1_c2_b2 := -5.032062094 +
    ((integer)ssn_adl_prob * 0.3406444394) +
    (pk_ssnchar_invalid_or_recent_mm_2 * 54.144607259);

fp_mod5_om_nodob_b1_c2_b2 := -6.097560639 +
    (addprob3_mod_om * 0.2390208266) +
    (phnprob_mod_om * 0.3294112065) +
    ((100 * (exp(ssnprob2_mod_om_nodob_b1_c2_b2) / (1 + exp(ssnprob2_mod_om_nodob_b1_c2_b2)))) * 0.3465548128) +
    (pk_multi_did * 0.4604065846) +
    (pk_rc_disthphoneaddr_mm_2 * 28.617442255);

mod14_om_nodob_b1_c2_b2 := -9.31769003 +
    (pk_out_st_division_lvl_mm_2 * 39.760527404) +
    (pk_wealth_index_mm_2 * 22.066429852) +
    (pk_dist_a1toa3_mm_2 * 108.04204147) +
    (avm_mod_om * 0.1551824124) +
    (age_mod3_nodob_om * 0.1333958406) +
    (velocity2_mod_om * 0.1325191453) +
    (pk_prof_lic_cat_mm_2 * 56.225143102) +
    ((100 * (exp(fp_mod5_om_nodob_b1_c2_b2) / (1 + exp(fp_mod5_om_nodob_b1_c2_b2)))) * 0.0840018065) +
    (property_mod_om * 0.1392580498) +
    (pk_estimated_income_mm_2 * 15.683408906) +
    (ver_src_cnt_mod_om * 0.1691508236) +
    (ver_src_time_mod_om * 0.0285564032);

ver_best_e_cnt_mod_rm_nodob_b1_c2_b3 := -5.707992592 +
    (pk_combo_fnamecount_mm_2 * 15.259368631) +
    (pk_rc_phonelnamecount_mm_2 * 11.745705241) +
    (pk_rc_addrcount_mm_2 * 8.9335105778) +
    (pk_gong_did_phone_ct_mm_2 * 8.5906192646) +
    (pk_combo_ssncount_mm_2 * 11.520381528);

ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3 := -11.0844948 +
    (pk_rc_lnamecount_nb_mm_2 * 12.822151602) +
    (pk_rc_addrcount_nb_mm_2 * 12.943448369) +
    (pk_rc_phonephonecount_mm_2 * 80.889794545) +
    (pk_gong_did_phone_ct_nb_mm_2 * 6.7162757428);

ver_element_cnt_mod_rm_nodob_b1_c2_b3 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3)))), (100 * (exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3)))));

mod14_rm_nodob_b1_c2_b3 := -6.211240474 +
    (pk_did0 * -1.405842962) +
    (pk_out_st_division_lvl_mm_2 * 12.125309019) +
    (pk_wealth_index_mm_2 * 4.4654751598) +
    (distance_mod2_rm * -0.079559178) +
    (avm_mod_rm * 0.0473192285) +
    (age_mod3_nodob_rm * 0.0436034732) +
    (amstudent_mod_rm * 0.0292413667) +
    (velocity2_mod_rm * 0.0702403477) +
    (pk_pl_sourced_level_mm_2 * 16.358266706) +
    (property_mod_rm * 0.0395885465) +
    (pk_estimated_income_mm_2 * 3.9918469556) +
    (ver_src_cnt_mod_rm * 0.0289721336) +
    (ver_element_cnt_mod_rm_nodob_b1_c2_b3 * 0.0302274224);

ver_best_e_cnt_mod_xm_nodob_b1_c2_b4 := -6.109832116 +
    (pk_rc_fnamecount_mm_2 * 16.511115253) +
    (pk_rc_phonelnamecount_mm_2 * 25.232875047) +
    (pk_rc_addrcount_mm_2 * 21.721048839) +
    (pk_combo_ssncount_mm_2 * 13.227299161);

ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4 := -5.439911936 +
    (pk_combo_fnamecount_nb_mm_2 * 13.404630398) +
    (pk_rc_phonelnamecount_mm_2 * 15.158171822) +
    (pk_rc_addrcount_nb_mm_2 * 16.602203827);

ver_element_cnt_mod_xm_nodob_b1_c2_b4 := if((integer)add1_isbestmatch = 1, (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4)))), (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4)))));

mod14_xm_nodob_b1_c2_b4 := -7.063116987 +
    (pk_did0 * -1.702877811) +
    (pk_out_st_division_lvl_mm_2 * 22.968931906) +
    (pk_wealth_index_mm_2 * 12.017764672) +
    (distance_mod2_xm * -0.081778649) +
    (avm_mod_xm * 0.0737646044) +
    (age_mod3_nodob_xm * 0.0416965037) +
    (amstudent_mod_xm * 0.058831493) +
    (velocity2_mod_xm * 0.0631893361) +
    (pk_prof_lic_cat_mm_2 * 21.231975868) +
    (property_mod_xm * 0.0414250481) +
    (pk_estimated_income_mm_2 * 4.600033771) +
    (ver_src_cnt_mod_xm * 0.0283333311) +
    (ver_element_cnt_mod_xm_nodob_b1_c2_b4 * 0.0696763678) +
    (ver_src_time_mod_xm * 0.0173854282);

ssnprob2_mod_om_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                pk_segment_2 = '1 Owner ' => (100 * (exp(ssnprob2_mod_om_nodob_b1_c2_b2) / (1 + exp(ssnprob2_mod_om_nodob_b1_c2_b2)))),
                                pk_segment_2 = '2 Renter' => NULL,
                                                             NULL);

mod14_om_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                         pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))),
                         pk_segment_2 = '2 Renter' => NULL,
                                                      NULL);

mod14_dm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))),
                         pk_segment_2 = '1 Owner ' => NULL,
                         pk_segment_2 = '2 Renter' => NULL,
                                                      NULL);

ssnprob2_mod_dm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => (100 * (exp(ssnprob2_mod_dm_nodob_b1_c2_b1) / (1 + exp(ssnprob2_mod_dm_nodob_b1_c2_b1)))),
                                pk_segment_2 = '1 Owner ' => NULL,
                                pk_segment_2 = '2 Renter' => NULL,
                                                             NULL);

mod14_scr_b1 := map(pk_segment_2 = '0 Derog ' => round(((-40 * ((ln(((exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))) / (1 - (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1)))))) - ln((1 / 20))) / ln(2))) + 700)),
                    pk_segment_2 = '1 Owner ' => round(((-40 * ((ln(((exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))) / (1 - (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2)))))) - ln((1 / 20))) / ln(2))) + 700)),
                    pk_segment_2 = '2 Renter' => round(((-40 * ((ln(((exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))) / (1 - (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3)))))) - ln((1 / 20))) / ln(2))) + 700)),
                                                 round(((-40 * ((ln(((exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4))) / (1 - (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4)))))) - ln((1 / 20))) / ln(2))) + 700)));

mod14_xm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                         pk_segment_2 = '1 Owner ' => NULL,
                         pk_segment_2 = '2 Renter' => NULL,
                                                      (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4))));

phat_b1 := map(pk_segment_2 = '0 Derog ' => (exp(mod14_dm_nodob_b1_c2_b1) / (1 + exp(mod14_dm_nodob_b1_c2_b1))),
               pk_segment_2 = '1 Owner ' => (exp(mod14_om_nodob_b1_c2_b2) / (1 + exp(mod14_om_nodob_b1_c2_b2))),
               pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))),
                                            (exp(mod14_xm_nodob_b1_c2_b4) / (1 + exp(mod14_xm_nodob_b1_c2_b4))));

ver_best_e_cnt_mod_xm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                      pk_segment_2 = '1 Owner ' => NULL,
                                      pk_segment_2 = '2 Renter' => NULL,
                                                                   (100 * (exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_best_e_cnt_mod_xm_nodob_b1_c2_b4)))));

ver_element_cnt_mod_rm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                       pk_segment_2 = '1 Owner ' => NULL,
                                       pk_segment_2 = '2 Renter' => ver_element_cnt_mod_rm_nodob_b1_c2_b3,
                                                                    NULL);

fp_mod5_om_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                           pk_segment_2 = '1 Owner ' => (100 * (exp(fp_mod5_om_nodob_b1_c2_b2) / (1 + exp(fp_mod5_om_nodob_b1_c2_b2)))),
                           pk_segment_2 = '2 Renter' => NULL,
                                                        NULL);

ver_element_cnt_mod_xm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                       pk_segment_2 = '1 Owner ' => NULL,
                                       pk_segment_2 = '2 Renter' => NULL,
                                                                    ver_element_cnt_mod_xm_nodob_b1_c2_b4);

ver_notbest_e_cnt_mod_rm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                         pk_segment_2 = '1 Owner ' => NULL,
                                         pk_segment_2 = '2 Renter' => (100 * (exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3)))),
                                                                      NULL);

ver_notbest_e_cnt_mod_xm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                         pk_segment_2 = '1 Owner ' => NULL,
                                         pk_segment_2 = '2 Renter' => NULL,
                                                                      (100 * (exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4) / (1 + exp(ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4)))));

mod14_rm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                         pk_segment_2 = '1 Owner ' => NULL,
                         pk_segment_2 = '2 Renter' => (exp(mod14_rm_nodob_b1_c2_b3) / (1 + exp(mod14_rm_nodob_b1_c2_b3))),
                                                      NULL);

fp_mod5_dm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => (100 * (exp(fp_mod5_dm_nodob_b1_c2_b1) / (1 + exp(fp_mod5_dm_nodob_b1_c2_b1)))),
                           pk_segment_2 = '1 Owner ' => NULL,
                           pk_segment_2 = '2 Renter' => NULL,
                                                        NULL);

ver_best_e_cnt_mod_rm_nodob_b1 := map(pk_segment_2 = '0 Derog ' => NULL,
                                      pk_segment_2 = '1 Owner ' => NULL,
                                      pk_segment_2 = '2 Renter' => (100 * (exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3) / (1 + exp(ver_best_e_cnt_mod_rm_nodob_b1_c2_b3)))),
                                                                   NULL);

ssnprob2_mod_om_nodob := if((integer)dobpop = 0, ssnprob2_mod_om_nodob_b1, NULL);

mod14_om_nodob := if((integer)dobpop = 0, mod14_om_nodob_b1, NULL);

mod14_dm_nodob := if((integer)dobpop = 0, mod14_dm_nodob_b1, NULL);

ssnprob2_mod_dm_nodob := if((integer)dobpop = 0, ssnprob2_mod_dm_nodob_b1, NULL);

mod14_scr_2 := if((integer)dobpop = 0, mod14_scr_b1, mod14_scr);

mod14_xm_nodob := if((integer)dobpop = 0, mod14_xm_nodob_b1, NULL);

phat_2 := if((integer)dobpop = 0, phat_b1, phat);

ver_best_e_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_best_e_cnt_mod_xm_nodob_b1, NULL);

ver_element_cnt_mod_rm_nodob := if((integer)dobpop = 0, ver_element_cnt_mod_rm_nodob_b1, NULL);

fp_mod5_om_nodob := if((integer)dobpop = 0, fp_mod5_om_nodob_b1, NULL);

ver_element_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_element_cnt_mod_xm_nodob_b1, NULL);

ver_notbest_e_cnt_mod_rm_nodob := if((integer)dobpop = 0, ver_notbest_e_cnt_mod_rm_nodob_b1, NULL);

ver_notbest_e_cnt_mod_xm_nodob := if((integer)dobpop = 0, ver_notbest_e_cnt_mod_xm_nodob_b1, NULL);

mod14_rm_nodob := if((integer)dobpop = 0, mod14_rm_nodob_b1, NULL);

fp_mod5_dm_nodob := if((integer)dobpop = 0, fp_mod5_dm_nodob_b1, NULL);

ver_best_e_cnt_mod_rm_nodob := if((integer)dobpop = 0, ver_best_e_cnt_mod_rm_nodob_b1, NULL);

RVB1003 := min(900, if(max(501, mod14_scr_2) = NULL, -NULL, max(501, mod14_scr_2)));

ov_ssndead := (((integer)ssnlength > 0) and ((integer)rc_decsflag = 1));

ov_ssnprior := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

ov_criminal_flag := (criminal_count > 0);

ov_corrections := ((integer)rc_hrisksic = 2225);

ov_impulse := (impulse_count > 0);

rvb1003_2 :=  if((RVB1003 > 680) and (ov_ssndead or (ov_ssnprior or (ov_criminal_flag or (ov_corrections or ov_impulse)))), 680, RVB1003);

scored_222s := ((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) OR (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag > 0) or (ssn_deceased or truedid)))))));

rvb1003_3 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvb1003_2);

		#if(RVB_DEBUG)
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
			self.rc_lnamecount := rc_lnamecount;
			self.rc_addrcount := rc_addrcount;
			self.rc_phonelnamecount := rc_phonelnamecount;
			self.rc_phonephonecount := rc_phonephonecount;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_ziptypeflag := rc_ziptypeflag;
			self.rc_cityzipflag := rc_cityzipflag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_dobscore := combo_dobscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_addrcount := combo_addrcount;
			self.combo_ssncount := combo_ssncount;
			self.combo_dobcount := combo_dobcount;
			self.rc_watchlist_flag := rc_watchlist_flag;
			self.eq_count := eq_count;
			self.pr_count := pr_count;
			self.adl_eq_first_seen := adl_eq_first_seen;
			self.adl_en_first_seen := adl_en_first_seen;
			self.adl_pr_first_seen := adl_pr_first_seen;
			self.adl_em_first_seen := adl_em_first_seen;
			self.adl_vo_first_seen := adl_vo_first_seen;
			self.adl_em_only_first_seen := adl_em_only_first_seen;
			self.adl_w_first_seen := adl_w_first_seen;
			self.fname_sources := fname_sources;
			self.lname_sources := lname_sources;
			self.addr_sources := addr_sources;
			self.ssn_sources := ssn_sources;
			self.em_only_sources := em_only_sources;
			self.voter_avail := voter_avail;
			self.ssnlength := ssnlength;
			self.dobpop := dobpop;
			self.lname_change_date := lname_change_date;
			self.lname_eda_sourced := lname_eda_sourced;
			self.lname_eda_sourced_type := lname_eda_sourced_type;
			self.age := age;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_unit_count := add1_unit_count;
			self.add1_lres := add1_lres;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_recording_date := add1_avm_recording_date;
			self.add1_avm_assessed_value_year := add1_avm_assessed_value_year;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_price_index_valuation := add1_avm_price_index_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_automated_valuation_3 := add1_avm_automated_valuation_3;
			self.add1_avm_automated_valuation_4 := add1_avm_automated_valuation_4;
			self.add1_avm_confidence_score := add1_avm_confidence_score;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_amount := add1_purchase_amount;
			self.add1_mortgage_date := add1_mortgage_date;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_mortgage_due_date := add1_mortgage_due_date;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_land_use_code := add1_land_use_code;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_rooms := add1_no_of_rooms;
			self.add1_no_of_baths := add1_no_of_baths;
			self.add1_pop := add1_pop;
			self.property_owned_total := property_owned_total;
			self.property_owned_assessed_total := property_owned_assessed_total;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add2_lres := add2_lres;
			self.add2_avm_land_use := add2_avm_land_use;
			self.add2_avm_sales_price := add2_avm_sales_price;
			self.add2_avm_tax_assessed_valuation := add2_avm_tax_assessed_valuation;
			self.add2_avm_price_index_valuation := add2_avm_price_index_valuation;
			self.add2_avm_hedonic_valuation := add2_avm_hedonic_valuation;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_automated_valuation_2 := add2_avm_automated_valuation_2;
			self.add2_avm_automated_valuation_3 := add2_avm_automated_valuation_3;
			self.add2_avm_confidence_score := add2_avm_confidence_score;
			self.add2_sources := add2_sources;
			self.add2_naprop := add2_naprop;
			self.add2_building_area := add2_building_area;
			self.add2_no_of_buildings := add2_no_of_buildings;
			self.add2_garage_type_code := add2_garage_type_code;
			self.add2_parking_no_of_cars := add2_parking_no_of_cars;
			self.add2_assessed_value_year := add2_assessed_value_year;
			self.add2_mortgage_due_date := add2_mortgage_due_date;
			self.add2_assessed_amount := add2_assessed_amount;
			self.add2_date_first_seen := add2_date_first_seen;
			self.add2_pop := add2_pop;
			self.add3_lres := add3_lres;
			self.add3_sources := add3_sources;
			self.add3_naprop := add3_naprop;
			self.add3_mortgage_type := add3_mortgage_type;
			self.add3_financing_type := add3_financing_type;
			self.add3_assessed_amount := add3_assessed_amount;
			self.add3_date_first_seen := add3_date_first_seen;
			self.add3_pop := add3_pop;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.addrs_prison_history := addrs_prison_history;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.header_first_seen := header_first_seen;
			self.inputssncharflag := inputssncharflag;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.invalid_addrs_per_adl_c6 := invalid_addrs_per_adl_c6;
			self.infutor_first_seen := infutor_first_seen;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_num_sold180 := attr_num_sold180;
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
			self.liens_unrel_o_ct := liens_unrel_o_ct;
			self.liens_unrel_ot_ct := liens_unrel_ot_ct;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_last_date := felony_last_date;
			self.ams_dob := ams_dob;
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
			self.sysdate := sysdate;
			self.sysyear := sysyear;
			self._daycap_b1 := _daycap_b1;
			self.in_dob2 := in_dob2;
			self._y := _y;
			self._m := _m;
			self._d := _d;
			self._daycap := _daycap;
			self.years_in_dob := years_in_dob;
			self._daycap_b1_2 := _daycap_b1_2;
			self.rc_ssnhighissue2 := rc_ssnhighissue2;
			self._y_2 := _y_2;
			self._m_2 := _m_2;
			self._d_2 := _d_2;
			self._daycap_2 := _daycap_2;
			self.years_rc_ssnhighissue := years_rc_ssnhighissue;
			self._daycap_b1_3 := _daycap_b1_3;
			self._y_3 := _y_3;
			self._m_3 := _m_3;
			self._d_3 := _d_3;
			self._daycap_3 := _daycap_3;
			self.rc_areacodesplitdate2 := rc_areacodesplitdate2;
			self.years_rc_areacodesplitdate := years_rc_areacodesplitdate;
			self._daycap_b1_4 := _daycap_b1_4;
			self.adl_eq_first_seen2 := adl_eq_first_seen2;
			self._y_4 := _y_4;
			self._m_4 := _m_4;
			self._d_4 := _d_4;
			self._daycap_4 := _daycap_4;
			self.years_adl_eq_first_seen := years_adl_eq_first_seen;
			self.months_adl_eq_first_seen := months_adl_eq_first_seen;
			self._daycap_b1_5 := _daycap_b1_5;
			self._y_5 := _y_5;
			self._m_5 := _m_5;
			self.adl_en_first_seen2 := adl_en_first_seen2;
			self._d_5 := _d_5;
			self._daycap_5 := _daycap_5;
			self.years_adl_en_first_seen := years_adl_en_first_seen;
			self.months_adl_en_first_seen := months_adl_en_first_seen;
			self._daycap_b1_6 := _daycap_b1_6;
			self._y_6 := _y_6;
			self._m_6 := _m_6;
			self.adl_pr_first_seen2 := adl_pr_first_seen2;
			self._d_6 := _d_6;
			self._daycap_6 := _daycap_6;
			self.years_adl_pr_first_seen := years_adl_pr_first_seen;
			self.months_adl_pr_first_seen := months_adl_pr_first_seen;
			self._daycap_b1_7 := _daycap_b1_7;
			self.adl_em_first_seen2 := adl_em_first_seen2;
			self._y_7 := _y_7;
			self._m_7 := _m_7;
			self._d_7 := _d_7;
			self._daycap_7 := _daycap_7;
			self.years_adl_em_first_seen := years_adl_em_first_seen;
			self.months_adl_em_first_seen := months_adl_em_first_seen;
			self._daycap_b1_8 := _daycap_b1_8;
			self.adl_vo_first_seen2 := adl_vo_first_seen2;
			self._y_8 := _y_8;
			self._m_8 := _m_8;
			self._d_8 := _d_8;
			self._daycap_8 := _daycap_8;
			self.years_adl_vo_first_seen := years_adl_vo_first_seen;
			self.months_adl_vo_first_seen := months_adl_vo_first_seen;
			self._daycap_b1_9 := _daycap_b1_9;
			self._y_9 := _y_9;
			self._m_9 := _m_9;
			self._d_9 := _d_9;
			self._daycap_9 := _daycap_9;
			self.adl_em_only_first_seen2 := adl_em_only_first_seen2;
			self.years_adl_em_only_first_seen := years_adl_em_only_first_seen;
			self.months_adl_em_only_first_seen := months_adl_em_only_first_seen;
			self._daycap_b1_10 := _daycap_b1_10;
			self.adl_w_first_seen2 := adl_w_first_seen2;
			self._y_10 := _y_10;
			self._m_10 := _m_10;
			self._d_10 := _d_10;
			self._daycap_10 := _daycap_10;
			self.years_adl_w_first_seen := years_adl_w_first_seen;
			self.months_adl_w_first_seen := months_adl_w_first_seen;
			self._daycap_b1_11 := _daycap_b1_11;
			self._y_11 := _y_11;
			self._m_11 := _m_11;
			self._d_11 := _d_11;
			self.lname_change_date2 := lname_change_date2;
			self._daycap_11 := _daycap_11;
			self.years_lname_change_date := years_lname_change_date;
			self._daycap_b1_12 := _daycap_b1_12;
			self._y_12 := _y_12;
			self.add1_avm_recording_date2 := add1_avm_recording_date2;
			self._m_12 := _m_12;
			self._d_12 := _d_12;
			self._daycap_12 := _daycap_12;
			self.years_add1_avm_recording_date := years_add1_avm_recording_date;
			self._daycap_b1_13 := _daycap_b1_13;
			self._y_13 := _y_13;
			self._m_13 := _m_13;
			self.add1_avm_assessed_value_year2 := add1_avm_assessed_value_year2;
			self._d_13 := _d_13;
			self._daycap_13 := _daycap_13;
			self.years_add1_avm_assess_year := years_add1_avm_assess_year;
			self._daycap_b1_14 := _daycap_b1_14;
			self._y_14 := _y_14;
			self._m_14 := _m_14;
			self._d_14 := _d_14;
			self.add1_mortgage_date2 := add1_mortgage_date2;
			self._daycap_14 := _daycap_14;
			self.years_add1_mortgage_date := years_add1_mortgage_date;
			self._daycap_b1_15 := _daycap_b1_15;
			self._y_15 := _y_15;
			self._m_15 := _m_15;
			self.add1_mortgage_due_date2 := add1_mortgage_due_date2;
			self._d_15 := _d_15;
			self._daycap_15 := _daycap_15;
			self.years_add1_mortgage_due_date := years_add1_mortgage_due_date;
			self._daycap_b1_16 := _daycap_b1_16;
			self.add1_date_first_seen2 := add1_date_first_seen2;
			self._y_16 := _y_16;
			self._m_16 := _m_16;
			self._d_16 := _d_16;
			self._daycap_16 := _daycap_16;
			self.years_add1_date_first_seen := years_add1_date_first_seen;
			self.months_add1_date_first_seen := months_add1_date_first_seen;
			self._daycap_b1_17 := _daycap_b1_17;
			self._y_17 := _y_17;
			self._m_17 := _m_17;
			self.add2_assessed_value_year2 := add2_assessed_value_year2;
			self._d_17 := _d_17;
			self._daycap_17 := _daycap_17;
			self.years_add2_assessed_value_year := years_add2_assessed_value_year;
			self._daycap_b1_18 := _daycap_b1_18;
			self._y_18 := _y_18;
			self._m_18 := _m_18;
			self.add2_mortgage_due_date2 := add2_mortgage_due_date2;
			self._d_18 := _d_18;
			self._daycap_18 := _daycap_18;
			self.years_add2_mortgage_due_date := years_add2_mortgage_due_date;
			self._daycap_b1_19 := _daycap_b1_19;
			self.add2_date_first_seen2 := add2_date_first_seen2;
			self._y_19 := _y_19;
			self._m_19 := _m_19;
			self._d_19 := _d_19;
			self._daycap_19 := _daycap_19;
			self.years_add2_date_first_seen := years_add2_date_first_seen;
			self.months_add2_date_first_seen := months_add2_date_first_seen;
			self._daycap_b1_20 := _daycap_b1_20;
			self._y_20 := _y_20;
			self._m_20 := _m_20;
			self.add3_date_first_seen2 := add3_date_first_seen2;
			self._d_20 := _d_20;
			self._daycap_20 := _daycap_20;
			self.years_add3_date_first_seen := years_add3_date_first_seen;
			self.months_add3_date_first_seen := months_add3_date_first_seen;
			self._daycap_b1_21 := _daycap_b1_21;
			self._y_21 := _y_21;
			self._m_21 := _m_21;
			self._d_21 := _d_21;
			self._daycap_21 := _daycap_21;
			self.gong_did_first_seen2 := gong_did_first_seen2;
			self.years_gong_did_first_seen := years_gong_did_first_seen;
			self._daycap_b1_22 := _daycap_b1_22;
			self.header_first_seen2 := header_first_seen2;
			self._y_22 := _y_22;
			self._m_22 := _m_22;
			self._d_22 := _d_22;
			self._daycap_22 := _daycap_22;
			self.years_header_first_seen := years_header_first_seen;
			self._daycap_b1_23 := _daycap_b1_23;
			self._y_23 := _y_23;
			self._m_23 := _m_23;
			self._d_23 := _d_23;
			self.infutor_first_seen2 := infutor_first_seen2;
			self._daycap_23 := _daycap_23;
			self.years_infutor_first_seen := years_infutor_first_seen;
			self._daycap_b1_24 := _daycap_b1_24;
			self._y_24 := _y_24;
			self._m_24 := _m_24;
			self._d_24 := _d_24;
			self.date_last_seen2 := date_last_seen2;
			self._daycap_24 := _daycap_24;
			self.years_date_last_seen := years_date_last_seen;
			self._daycap_b1_25 := _daycap_b1_25;
			self._y_25 := _y_25;
			self._m_25 := _m_25;
			self._d_25 := _d_25;
			self._daycap_25 := _daycap_25;
			self.liens_last_unrel_date2 := liens_last_unrel_date2;
			self.years_liens_last_unrel_date := years_liens_last_unrel_date;
			self._daycap_b1_26 := _daycap_b1_26;
			self._y_26 := _y_26;
			self._m_26 := _m_26;
			self._d_26 := _d_26;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self._daycap_26 := _daycap_26;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self._daycap_b1_27 := _daycap_b1_27;
			self.criminal_last_date2 := criminal_last_date2;
			self._y_27 := _y_27;
			self._m_27 := _m_27;
			self._d_27 := _d_27;
			self._daycap_27 := _daycap_27;
			self.years_criminal_last_date := years_criminal_last_date;
			self._daycap_b1_28 := _daycap_b1_28;
			self._y_28 := _y_28;
			self.felony_last_date2 := felony_last_date2;
			self._m_28 := _m_28;
			self._d_28 := _d_28;
			self._daycap_28 := _daycap_28;
			self.years_felony_last_date := years_felony_last_date;
			self._daycap_b1_29 := _daycap_b1_29;
			self.ams_dob2 := ams_dob2;
			self._y_29 := _y_29;
			self._m_29 := _m_29;
			self._d_29 := _d_29;
			self._daycap_29 := _daycap_29;
			self.years_ams_dob := years_ams_dob;
			self._daycap_b1_30 := _daycap_b1_30;
			self._y_30 := _y_30;
			self._m_30 := _m_30;
			self._d_30 := _d_30;
			self._daycap_30 := _daycap_30;
			self.reported_dob2 := reported_dob2;
			self.years_reported_dob := years_reported_dob;
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
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.source_tot_P := source_tot_P;
			self.source_tot_W := source_tot_W;
			self.source_tot_voter := source_tot_voter;
			self.source_fst_P := source_fst_P;
			self.source_fst_PL := source_fst_PL;
			self.source_lst_P := source_lst_P;
			self.source_lst_PL := source_lst_PL;
			self.source_add_P := source_add_P;
			self.source_add_PL := source_add_PL;
			self.source_ssn_P := source_ssn_P;
			self.source_add2_EM := source_add2_EM;
			self.source_add2_VO := source_add2_VO;
			self.source_add2_EQ := source_add2_EQ;
			self.source_add2_P := source_add2_P;
			self.source_add2_WP := source_add2_WP;
			self.source_add2_voter := source_add2_voter;
			self.source_add3_P := source_add3_P;
			self.nas_summary_p := nas_summary_p;
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
			self.phn_highrisk2 := phn_highrisk2;
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
			self.pk_yr_adl_em_only_first_seen := pk_yr_adl_em_only_first_seen;
			self.pk_yr_adl_first_seen_max_fcra := pk_yr_adl_first_seen_max_fcra;
			self.pk_mo_adl_first_seen_max_fcra := pk_mo_adl_first_seen_max_fcra;
			self.pk_yr_lname_change_date := pk_yr_lname_change_date;
			self.pk_yr_gong_did_first_seen := pk_yr_gong_did_first_seen;
			self.pk_yr_header_first_seen := pk_yr_header_first_seen;
			self.pk_yr_infutor_first_seen := pk_yr_infutor_first_seen;
			self.pk_multi_did := pk_multi_did;
			self.pk_nas_summary := pk_nas_summary;
			self.pk_nap_summary := pk_nap_summary;
			self.pk_combo_fnamecount := pk_combo_fnamecount;
			self.pk_combo_fnamecount_nb := pk_combo_fnamecount_nb;
			self.pk_rc_fnamecount := pk_rc_fnamecount;
			self.pk_rc_lnamecount_nb := pk_rc_lnamecount_nb;
			self.pk_rc_phonelnamecount := pk_rc_phonelnamecount;
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
			self.pk_lname_eda_sourced_type_lvl := pk_lname_eda_sourced_type_lvl;
			self.pk_add1_unit_count2 := pk_add1_unit_count2;
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
			self.pk_em_only_ver_lvl := pk_em_only_ver_lvl;
			self.pk_add2_em_ver_lvl := pk_add2_em_ver_lvl;
			self.pk_infutor_risk_lvl := pk_infutor_risk_lvl;
			self.pk_infutor_risk_lvl_nb := pk_infutor_risk_lvl_nb;
			self.pk_yr_adl_em_only_first_seen2 := pk_yr_adl_em_only_first_seen2;
			self.pk_yrmo_adl_first_seen_max_fcra2 := pk_yrmo_adl_first_seen_max_fcra2;
			self.pk_yr_lname_change_date2 := pk_yr_lname_change_date2;
			self.pk_yr_gong_did_first_seen2 := pk_yr_gong_did_first_seen2;
			self.pk_yr_header_first_seen2 := pk_yr_header_first_seen2;
			self.pk_yr_infutor_first_seen2 := pk_yr_infutor_first_seen2;
			self.pk_estimated_income := pk_estimated_income;
			self.pk_yr_adl_pr_first_seen := pk_yr_adl_pr_first_seen;
			self.pk_yr_adl_w_first_seen := pk_yr_adl_w_first_seen;
			self.pk_yr_add1_mortgage_date := pk_yr_add1_mortgage_date;
			self.pk_yr_add1_mortgage_due_date := pk_yr_add1_mortgage_due_date;
			self.pk_yr_add1_date_first_seen := pk_yr_add1_date_first_seen;
			self.pk_yr_add2_assessed_value_year := pk_yr_add2_assessed_value_year;
			self.pk_yr_add2_mortgage_due_date := pk_yr_add2_mortgage_due_date;
			self.pk_yr_add2_date_first_seen := pk_yr_add2_date_first_seen;
			self.pk_yr_add3_date_first_seen := pk_yr_add3_date_first_seen;
			self.pk_property_owned_assessed_total := pk_property_owned_assessed_total;
			self.pk_add1_purchase_amount := pk_add1_purchase_amount;
			self.pk_add1_assessed_amount := pk_add1_assessed_amount;
			self.pk_add2_assessed_amount := pk_add2_assessed_amount;
			self.pk_add3_assessed_amount := pk_add3_assessed_amount;
			self.pk_property_owned_assessed_total_2 := pk_property_owned_assessed_total_2;
			self.pk_add1_purchase_amount_2 := pk_add1_purchase_amount_2;
			self.pk_add1_assessed_amount_2 := pk_add1_assessed_amount_2;
			self.pk_add2_assessed_amount_2 := pk_add2_assessed_amount_2;
			self.pk_add3_assessed_amount_2 := pk_add3_assessed_amount_2;
			self.pk_add1_building_area := pk_add1_building_area;
			self.pk_add2_building_area := pk_add2_building_area;
			self.pk_yr_adl_pr_first_seen2 := pk_yr_adl_pr_first_seen2;
			self.pk_yr_adl_w_first_seen2 := pk_yr_adl_w_first_seen2;
			self.pk_pr_count := pk_pr_count;
			self.pk_nas_summary_p := pk_nas_summary_p;
			self.pk_addrs_sourced_lvl := pk_addrs_sourced_lvl;
			self.pk_naprop_level := pk_naprop_level;
			self.pk_naprop_level2_b1 := pk_naprop_level2_b1;
			self.pk_naprop_level2 := pk_naprop_level2;
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
			self.pk_add1_no_of_rooms := pk_add1_no_of_rooms;
			self.pk_add1_no_of_baths := pk_add1_no_of_baths;
			self.pk_property_owned_total := pk_property_owned_total;
			self.pk_prop_own_assess_tot2 := pk_prop_own_assess_tot2;
			self.pk_add2_building_area2 := pk_add2_building_area2;
			self.pk_add2_no_of_buildings := pk_add2_no_of_buildings;
			self.pk_add2_garage_type_risk_level := pk_add2_garage_type_risk_level;
			self.pk_add2_parking_no_of_cars := pk_add2_parking_no_of_cars;
			self.pk_yr_add2_assessed_value_year2 := pk_yr_add2_assessed_value_year2;
			self.pk_yr_add2_mortgage_due_date2 := pk_yr_add2_mortgage_due_date2;
			self.pk_add2_assessed_amount2 := pk_add2_assessed_amount2;
			self.pk_yr_add2_date_first_seen2 := pk_yr_add2_date_first_seen2;
			self.pk_add3_mortgage_risk := pk_add3_mortgage_risk;
			self.pk_add3_adjustable_financing := pk_add3_adjustable_financing;
			self.pk_add3_assessed_amount2 := pk_add3_assessed_amount2;
			self.pk_yr_add3_date_first_seen2 := pk_yr_add3_date_first_seen2;
			self.pk_attr_num_sold180 := pk_attr_num_sold180;
			self.pk_yr_liens_last_unrel_date := pk_yr_liens_last_unrel_date;
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
			self.pk_attr_eviction_count := pk_attr_eviction_count;
			self.pk_eviction_level := pk_eviction_level;
			self.pk_yr_criminal_last_date2 := pk_yr_criminal_last_date2;
			self.pk_yr_felony_last_date2 := pk_yr_felony_last_date2;
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
			self.pk_add_lres_month_avg := pk_add_lres_month_avg;
			self.pk_add1_lres := pk_add1_lres;
			self.pk_add2_lres := pk_add2_lres;
			self.pk_add3_lres := pk_add3_lres;
			self.pk_add1_lres_flag := pk_add1_lres_flag;
			self.pk_add2_lres_flag := pk_add2_lres_flag;
			self.pk_add3_lres_flag := pk_add3_lres_flag;
			self.pk_lres_flag_level := pk_lres_flag_level;
			self.pk_addrs_5yr := pk_addrs_5yr;
			self.pk_addrs_15yr := pk_addrs_15yr;
			self.pk_add_lres_month_avg2 := pk_add_lres_month_avg2;
			self.pk_ssns_per_adl := pk_ssns_per_adl;
			self.pk_addrs_per_adl := pk_addrs_per_adl;
			self.pk_phones_per_adl := pk_phones_per_adl;
			self.pk_adlperssn_count := pk_adlperssn_count;
			self.pk_adls_per_addr_b1 := pk_adls_per_addr_b1;
			self.pk_ssns_per_addr2_b1 := pk_ssns_per_addr2_b1;
			self.pk_adls_per_addr_b2 := pk_adls_per_addr_b2;
			self.pk_ssns_per_addr2_b2 := pk_ssns_per_addr2_b2;
			self.pk_adls_per_addr := pk_adls_per_addr;
			self.pk_ssns_per_addr2 := pk_ssns_per_addr2;
			self.pk_adls_per_phone := pk_adls_per_phone;
			self.pk_ssns_per_adl_c6 := pk_ssns_per_adl_c6;
			self.pk_ssns_per_addr_c6_b1 := pk_ssns_per_addr_c6_b1;
			self.pk_ssns_per_addr_c6_b2 := pk_ssns_per_addr_c6_b2;
			self.pk_ssns_per_addr_c6 := pk_ssns_per_addr_c6;
			self.pk_adls_per_phone_c6 := pk_adls_per_phone_c6;
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
			self.pk_ams_4yr_college := pk_ams_4yr_college;
			self.pk_ams_college_type := pk_ams_college_type;
			self.pk_ams_income_level_code := pk_ams_income_level_code;
			self.pk_yr_in_dob := pk_yr_in_dob;
			self.pk_yr_ams_dob := pk_yr_ams_dob;
			self.pk_yr_reported_dob := pk_yr_reported_dob;
			self.pk_yr_in_dob2 := pk_yr_in_dob2;
			self.pk_yr_ams_dob2 := pk_yr_ams_dob2;
			self.pk_inferred_age := pk_inferred_age;
			self.pk_yr_reported_dob2 := pk_yr_reported_dob2;
			self.pk_yr_add1_avm_recording_date := pk_yr_add1_avm_recording_date;
			self.pk_yr_add1_avm_assess_year := pk_yr_add1_avm_assess_year;
			self.pk_add1_avm_mkt := pk_add1_avm_mkt;
			self.pk_add1_avm_pi := pk_add1_avm_pi;
			self.pk_add1_avm_auto := pk_add1_avm_auto;
			self.pk_add1_avm_auto2 := pk_add1_avm_auto2;
			self.pk_add1_avm_auto3 := pk_add1_avm_auto3;
			self.pk_add1_avm_auto4 := pk_add1_avm_auto4;
			self.pk_add1_avm_med := pk_add1_avm_med;
			self.pk_add2_avm_sp := pk_add2_avm_sp;
			self.pk_add2_avm_ta := pk_add2_avm_ta;
			self.pk_add2_avm_pi := pk_add2_avm_pi;
			self.pk_add2_avm_hed := pk_add2_avm_hed;
			self.pk_add2_avm_auto := pk_add2_avm_auto;
			self.pk_add2_avm_auto2 := pk_add2_avm_auto2;
			self.pk_add2_avm_auto3 := pk_add2_avm_auto3;
			self.pk_add1_avm_mkt_2 := pk_add1_avm_mkt_2;
			self.pk_add1_avm_pi_2 := pk_add1_avm_pi_2;
			self.pk_add1_avm_auto_2 := pk_add1_avm_auto_2;
			self.pk_add1_avm_auto2_2 := pk_add1_avm_auto2_2;
			self.pk_add1_avm_auto3_2 := pk_add1_avm_auto3_2;
			self.pk_add1_avm_auto4_2 := pk_add1_avm_auto4_2;
			self.pk_add1_avm_med_2 := pk_add1_avm_med_2;
			self.pk_add2_avm_sp_2 := pk_add2_avm_sp_2;
			self.pk_add2_avm_ta_2 := pk_add2_avm_ta_2;
			self.pk_add2_avm_pi_2 := pk_add2_avm_pi_2;
			self.pk_add2_avm_hed_2 := pk_add2_avm_hed_2;
			self.pk_add2_avm_auto_2 := pk_add2_avm_auto_2;
			self.pk_add2_avm_auto2_2 := pk_add2_avm_auto2_2;
			self.pk_add2_avm_auto3_2 := pk_add2_avm_auto3_2;
			self.pk_add1_avm_to_med_ratio := pk_add1_avm_to_med_ratio;
			self.pk_add1_avm_to_med_ratio_2 := pk_add1_avm_to_med_ratio_2;
			self.pk_add1_avm_confidence_score := pk_add1_avm_confidence_score;
			self.pk2_add1_avm_mkt := pk2_add1_avm_mkt;
			self.pk2_add1_avm_pi := pk2_add1_avm_pi;
			self.pk2_add1_avm_auto := pk2_add1_avm_auto;
			self.pk2_add1_avm_auto2 := pk2_add1_avm_auto2;
			self.pk2_add1_avm_auto3 := pk2_add1_avm_auto3;
			self.pk_avm_auto_diff2 := pk_avm_auto_diff2;
			self.pk_avm_auto_diff4 := pk_avm_auto_diff4;
			self.pk_avm_auto_diff2_lvl := pk_avm_auto_diff2_lvl;
			self.pk_avm_auto_diff4_lvl := pk_avm_auto_diff4_lvl;
			self.pk2_add1_avm_med := pk2_add1_avm_med;
			self.pk2_add1_avm_to_med_ratio := pk2_add1_avm_to_med_ratio;
			self.pk_add2_avm_hit := pk_add2_avm_hit;
			self.pk_avm_hit_level := pk_avm_hit_level;
			self.pk_add2_avm_confidence_score := pk_add2_avm_confidence_score;
			self.pk_avm_confidence_level := pk_avm_confidence_level;
			self.pk2_add2_avm_sp := pk2_add2_avm_sp;
			self.pk2_add2_avm_ta := pk2_add2_avm_ta;
			self.pk2_add2_avm_pi := pk2_add2_avm_pi;
			self.pk2_add2_avm_hed := pk2_add2_avm_hed;
			self.pk2_add2_avm_auto := pk2_add2_avm_auto;
			self.pk2_add2_avm_auto3 := pk2_add2_avm_auto3;
			self.pk_add2_avm_auto_diff2 := pk_add2_avm_auto_diff2;
			self.pk_add2_avm_auto_diff2_lvl := pk_add2_avm_auto_diff2_lvl;
			self.pk2_yr_add1_avm_recording_date := pk2_yr_add1_avm_recording_date;
			self.pk2_yr_add1_avm_assess_year := pk2_yr_add1_avm_assess_year;
			self.pk_dist_a1toa2_2 := pk_dist_a1toa2_2;
			self.pk_dist_a1toa3_2 := pk_dist_a1toa3_2;
			self.pk_rc_disthphoneaddr_2 := pk_rc_disthphoneaddr_2;
			self.pk_out_st_division_lvl := pk_out_st_division_lvl;
			self.pk_wealth_index_2 := pk_wealth_index_2;
			self.pk_impulse_count := pk_impulse_count;
			self.pk_impulse_count_2 := pk_impulse_count_2;
			self.pk_attr_total_number_derogs_3 := pk_attr_total_number_derogs_3;
			self.pk_attr_total_number_derogs_4 := pk_attr_total_number_derogs_4;
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
			self.pk_nap_summary_mm_b1_c2_b1 := pk_nap_summary_mm_b1_c2_b1;
			self.pk_combo_fnamecount_mm_b1_c2_b1 := pk_combo_fnamecount_mm_b1_c2_b1;
			self.pk_rc_fnamecount_mm_b1_c2_b1 := pk_rc_fnamecount_mm_b1_c2_b1;
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
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b1;
			self.pk_add2_pos_sources_mm_b1_c2_b1 := pk_add2_pos_sources_mm_b1_c2_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b1;
			self.pk_infutor_risk_lvl_mm_b1_c2_b1 := pk_infutor_risk_lvl_mm_b1_c2_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b1;
			self.pk_yr_lname_change_date2_mm_b1_c2_b1 := pk_yr_lname_change_date2_mm_b1_c2_b1;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b1 := pk_yr_gong_did_first_seen2_mm_b1_c2_b1;
			self.pk_yr_header_first_seen2_mm_b1_c2_b1 := pk_yr_header_first_seen2_mm_b1_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b1 := pk_yr_infutor_first_seen2_mm_b1_c2_b1;
			self.pk_em_only_ver_lvl_mm_b1_c2_b1 := pk_em_only_ver_lvl_mm_b1_c2_b1;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b1 := pk_add2_em_ver_lvl_mm_b1_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b1;
			self.pk_nas_summary_mm_b1_c2_b2 := pk_nas_summary_mm_b1_c2_b2;
			self.pk_nap_summary_mm_b1_c2_b2 := pk_nap_summary_mm_b1_c2_b2;
			self.pk_combo_fnamecount_mm_b1_c2_b2 := pk_combo_fnamecount_mm_b1_c2_b2;
			self.pk_rc_fnamecount_mm_b1_c2_b2 := pk_rc_fnamecount_mm_b1_c2_b2;
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
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b2;
			self.pk_add2_pos_sources_mm_b1_c2_b2 := pk_add2_pos_sources_mm_b1_c2_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b2;
			self.pk_infutor_risk_lvl_mm_b1_c2_b2 := pk_infutor_risk_lvl_mm_b1_c2_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b2;
			self.pk_yr_lname_change_date2_mm_b1_c2_b2 := pk_yr_lname_change_date2_mm_b1_c2_b2;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b2 := pk_yr_gong_did_first_seen2_mm_b1_c2_b2;
			self.pk_yr_header_first_seen2_mm_b1_c2_b2 := pk_yr_header_first_seen2_mm_b1_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b2 := pk_yr_infutor_first_seen2_mm_b1_c2_b2;
			self.pk_em_only_ver_lvl_mm_b1_c2_b2 := pk_em_only_ver_lvl_mm_b1_c2_b2;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b2 := pk_add2_em_ver_lvl_mm_b1_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b2;
			self.pk_nas_summary_mm_b1_c2_b3 := pk_nas_summary_mm_b1_c2_b3;
			self.pk_nap_summary_mm_b1_c2_b3 := pk_nap_summary_mm_b1_c2_b3;
			self.pk_combo_fnamecount_mm_b1_c2_b3 := pk_combo_fnamecount_mm_b1_c2_b3;
			self.pk_rc_fnamecount_mm_b1_c2_b3 := pk_rc_fnamecount_mm_b1_c2_b3;
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
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b3;
			self.pk_add2_pos_sources_mm_b1_c2_b3 := pk_add2_pos_sources_mm_b1_c2_b3;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b3;
			self.pk_infutor_risk_lvl_mm_b1_c2_b3 := pk_infutor_risk_lvl_mm_b1_c2_b3;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b3;
			self.pk_yr_lname_change_date2_mm_b1_c2_b3 := pk_yr_lname_change_date2_mm_b1_c2_b3;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b3 := pk_yr_gong_did_first_seen2_mm_b1_c2_b3;
			self.pk_yr_header_first_seen2_mm_b1_c2_b3 := pk_yr_header_first_seen2_mm_b1_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b3 := pk_yr_infutor_first_seen2_mm_b1_c2_b3;
			self.pk_em_only_ver_lvl_mm_b1_c2_b3 := pk_em_only_ver_lvl_mm_b1_c2_b3;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b3 := pk_add2_em_ver_lvl_mm_b1_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b3;
			self.pk_nas_summary_mm_b1_c2_b4 := pk_nas_summary_mm_b1_c2_b4;
			self.pk_nap_summary_mm_b1_c2_b4 := pk_nap_summary_mm_b1_c2_b4;
			self.pk_combo_fnamecount_mm_b1_c2_b4 := pk_combo_fnamecount_mm_b1_c2_b4;
			self.pk_rc_fnamecount_mm_b1_c2_b4 := pk_rc_fnamecount_mm_b1_c2_b4;
			self.pk_rc_phonelnamecount_mm_b1_c2_b4 := pk_rc_phonelnamecount_mm_b1_c2_b4;
			self.pk_rc_addrcount_mm_b1_c2_b4 := pk_rc_addrcount_mm_b1_c2_b4;
			self.pk_rc_phonephonecount_mm_b1_c2_b4 := pk_rc_phonephonecount_mm_b1_c2_b4;
			self.pk_ver_phncount_mm_b1_c2_b4 := pk_ver_phncount_mm_b1_c2_b4;
			self.pk_gong_did_phone_ct_mm_b1_c2_b4 := pk_gong_did_phone_ct_mm_b1_c2_b4;
			self.pk_combo_ssncount_mm_b1_c2_b4 := pk_combo_ssncount_mm_b1_c2_b4;
			self.pk_combo_dobcount_mm_b1_c2_b4 := pk_combo_dobcount_mm_b1_c2_b4;
			self.pk_eq_count_mm_b1_c2_b4 := pk_eq_count_mm_b1_c2_b4;
			self.pk_pos_secondary_sources_mm_b1_c2_b4 := pk_pos_secondary_sources_mm_b1_c2_b4;
			self.pk_voter_flag_mm_b1_c2_b4 := pk_voter_flag_mm_b1_c2_b4;
			self.pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4 := pk_lname_eda_sourced_type_lvl_mm_b1_c2_b4;
			self.pk_add2_pos_sources_mm_b1_c2_b4 := pk_add2_pos_sources_mm_b1_c2_b4;
			self.pk_ssnchar_invalid_or_recent_mm_b1_c2_b4 := pk_ssnchar_invalid_or_recent_mm_b1_c2_b4;
			self.pk_infutor_risk_lvl_mm_b1_c2_b4 := pk_infutor_risk_lvl_mm_b1_c2_b4;
			self.pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4 := pk_yr_adl_em_only_first_seen2_mm_b1_c2_b4;
			self.pk_yr_lname_change_date2_mm_b1_c2_b4 := pk_yr_lname_change_date2_mm_b1_c2_b4;
			self.pk_yr_gong_did_first_seen2_mm_b1_c2_b4 := pk_yr_gong_did_first_seen2_mm_b1_c2_b4;
			self.pk_yr_header_first_seen2_mm_b1_c2_b4 := pk_yr_header_first_seen2_mm_b1_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b1_c2_b4 := pk_yr_infutor_first_seen2_mm_b1_c2_b4;
			self.pk_em_only_ver_lvl_mm_b1_c2_b4 := pk_em_only_ver_lvl_mm_b1_c2_b4;
			self.pk_add2_em_ver_lvl_mm_b1_c2_b4 := pk_add2_em_ver_lvl_mm_b1_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1_c2_b4;
			self.pk_nap_summary_mm_b1 := pk_nap_summary_mm_b1;
			self.pk_yr_gong_did_first_seen2_mm_b1 := pk_yr_gong_did_first_seen2_mm_b1;
			self.pk_gong_did_phone_ct_mm_b1 := pk_gong_did_phone_ct_mm_b1;
			self.pk_rc_addrcount_mm_b1 := pk_rc_addrcount_mm_b1;
			self.pk_nas_summary_mm_b1 := pk_nas_summary_mm_b1;
			self.pk_yr_infutor_first_seen2_mm_b1 := pk_yr_infutor_first_seen2_mm_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b1 := pk_yr_adl_em_only_first_seen2_mm_b1;
			self.pk_yr_lname_change_date2_mm_b1 := pk_yr_lname_change_date2_mm_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b1 := pk_ssnchar_invalid_or_recent_mm_b1;
			self.pk_add2_em_ver_lvl_mm_b1 := pk_add2_em_ver_lvl_mm_b1;
			self.pk_rc_phonelnamecount_mm_b1 := pk_rc_phonelnamecount_mm_b1;
			self.pk_yr_header_first_seen2_mm_b1 := pk_yr_header_first_seen2_mm_b1;
			self.pk_eq_count_mm_b1 := pk_eq_count_mm_b1;
			self.pk_em_only_ver_lvl_mm_b1 := pk_em_only_ver_lvl_mm_b1;
			self.pk_combo_ssncount_mm_b1 := pk_combo_ssncount_mm_b1;
			self.pk_combo_fnamecount_mm_b1 := pk_combo_fnamecount_mm_b1;
			self.pk_pos_secondary_sources_mm_b1 := pk_pos_secondary_sources_mm_b1;
			self.pk_rc_phonephonecount_mm_b1 := pk_rc_phonephonecount_mm_b1;
			self.pk_voter_flag_mm_b1 := pk_voter_flag_mm_b1;
			self.pk_rc_fnamecount_mm_b1 := pk_rc_fnamecount_mm_b1;
			self.pk_add2_pos_sources_mm_b1 := pk_add2_pos_sources_mm_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b1;
			self.pk_infutor_risk_lvl_mm_b1 := pk_infutor_risk_lvl_mm_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b1 := pk_lname_eda_sourced_type_lvl_mm_b1;
			self.pk_ver_phncount_mm_b1 := pk_ver_phncount_mm_b1;
			self.pk_combo_dobcount_mm_b1 := pk_combo_dobcount_mm_b1;
			self.pk_nas_summary_mm_b2_c2_b1 := pk_nas_summary_mm_b2_c2_b1;
			self.pk_nap_summary_mm_b2_c2_b1 := pk_nap_summary_mm_b2_c2_b1;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b1 := pk_combo_fnamecount_nb_mm_b2_c2_b1;
			self.pk_rc_lnamecount_nb_mm_b2_c2_b1 := pk_rc_lnamecount_nb_mm_b2_c2_b1;
			self.pk_rc_phonelnamecount_mm_b2_c2_b1 := pk_rc_phonelnamecount_mm_b2_c2_b1;
			self.pk_rc_addrcount_nb_mm_b2_c2_b1 := pk_rc_addrcount_nb_mm_b2_c2_b1;
			self.pk_rc_phonephonecount_mm_b2_c2_b1 := pk_rc_phonephonecount_mm_b2_c2_b1;
			self.pk_ver_phncount_mm_b2_c2_b1 := pk_ver_phncount_mm_b2_c2_b1;
			self.pk_gong_did_phone_ct_nb_mm_b2_c2_b1 := pk_gong_did_phone_ct_nb_mm_b2_c2_b1;
			self.pk_combo_ssncount_mm_b2_c2_b1 := pk_combo_ssncount_mm_b2_c2_b1;
			self.pk_combo_dobcount_nb_mm_b2_c2_b1 := pk_combo_dobcount_nb_mm_b2_c2_b1;
			self.pk_eq_count_mm_b2_c2_b1 := pk_eq_count_mm_b2_c2_b1;
			self.pk_pos_secondary_sources_mm_b2_c2_b1 := pk_pos_secondary_sources_mm_b2_c2_b1;
			self.pk_voter_flag_mm_b2_c2_b1 := pk_voter_flag_mm_b2_c2_b1;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b1;
			self.pk_add2_pos_sources_mm_b2_c2_b1 := pk_add2_pos_sources_mm_b2_c2_b1;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b1 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b1;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b1 := pk_infutor_risk_lvl_nb_mm_b2_c2_b1;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b1;
			self.pk_yr_lname_change_date2_mm_b2_c2_b1 := pk_yr_lname_change_date2_mm_b2_c2_b1;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b1 := pk_yr_gong_did_first_seen2_mm_b2_c2_b1;
			self.pk_yr_header_first_seen2_mm_b2_c2_b1 := pk_yr_header_first_seen2_mm_b2_c2_b1;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b1 := pk_yr_infutor_first_seen2_mm_b2_c2_b1;
			self.pk_em_only_ver_lvl_mm_b2_c2_b1 := pk_em_only_ver_lvl_mm_b2_c2_b1;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b1;
			self.pk_nas_summary_mm_b2_c2_b2 := pk_nas_summary_mm_b2_c2_b2;
			self.pk_nap_summary_mm_b2_c2_b2 := pk_nap_summary_mm_b2_c2_b2;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b2 := pk_combo_fnamecount_nb_mm_b2_c2_b2;
			self.pk_rc_lnamecount_nb_mm_b2_c2_b2 := pk_rc_lnamecount_nb_mm_b2_c2_b2;
			self.pk_rc_phonelnamecount_mm_b2_c2_b2 := pk_rc_phonelnamecount_mm_b2_c2_b2;
			self.pk_rc_addrcount_nb_mm_b2_c2_b2 := pk_rc_addrcount_nb_mm_b2_c2_b2;
			self.pk_rc_phonephonecount_mm_b2_c2_b2 := pk_rc_phonephonecount_mm_b2_c2_b2;
			self.pk_ver_phncount_mm_b2_c2_b2 := pk_ver_phncount_mm_b2_c2_b2;
			self.pk_gong_did_phone_ct_nb_mm_b2_c2_b2 := pk_gong_did_phone_ct_nb_mm_b2_c2_b2;
			self.pk_combo_ssncount_mm_b2_c2_b2 := pk_combo_ssncount_mm_b2_c2_b2;
			self.pk_combo_dobcount_nb_mm_b2_c2_b2 := pk_combo_dobcount_nb_mm_b2_c2_b2;
			self.pk_eq_count_mm_b2_c2_b2 := pk_eq_count_mm_b2_c2_b2;
			self.pk_pos_secondary_sources_mm_b2_c2_b2 := pk_pos_secondary_sources_mm_b2_c2_b2;
			self.pk_voter_flag_mm_b2_c2_b2 := pk_voter_flag_mm_b2_c2_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b2;
			self.pk_add2_pos_sources_mm_b2_c2_b2 := pk_add2_pos_sources_mm_b2_c2_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b2 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b2;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b2 := pk_infutor_risk_lvl_nb_mm_b2_c2_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b2;
			self.pk_yr_lname_change_date2_mm_b2_c2_b2 := pk_yr_lname_change_date2_mm_b2_c2_b2;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b2 := pk_yr_gong_did_first_seen2_mm_b2_c2_b2;
			self.pk_yr_header_first_seen2_mm_b2_c2_b2 := pk_yr_header_first_seen2_mm_b2_c2_b2;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b2 := pk_yr_infutor_first_seen2_mm_b2_c2_b2;
			self.pk_em_only_ver_lvl_mm_b2_c2_b2 := pk_em_only_ver_lvl_mm_b2_c2_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b2;
			self.pk_nas_summary_mm_b2_c2_b3 := pk_nas_summary_mm_b2_c2_b3;
			self.pk_nap_summary_mm_b2_c2_b3 := pk_nap_summary_mm_b2_c2_b3;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b3 := pk_combo_fnamecount_nb_mm_b2_c2_b3;
			self.pk_rc_lnamecount_nb_mm_b2_c2_b3 := pk_rc_lnamecount_nb_mm_b2_c2_b3;
			self.pk_rc_phonelnamecount_mm_b2_c2_b3 := pk_rc_phonelnamecount_mm_b2_c2_b3;
			self.pk_rc_addrcount_nb_mm_b2_c2_b3 := pk_rc_addrcount_nb_mm_b2_c2_b3;
			self.pk_rc_phonephonecount_mm_b2_c2_b3 := pk_rc_phonephonecount_mm_b2_c2_b3;
			self.pk_ver_phncount_mm_b2_c2_b3 := pk_ver_phncount_mm_b2_c2_b3;
			self.pk_gong_did_phone_ct_nb_mm_b2_c2_b3 := pk_gong_did_phone_ct_nb_mm_b2_c2_b3;
			self.pk_combo_ssncount_mm_b2_c2_b3 := pk_combo_ssncount_mm_b2_c2_b3;
			self.pk_combo_dobcount_nb_mm_b2_c2_b3 := pk_combo_dobcount_nb_mm_b2_c2_b3;
			self.pk_eq_count_mm_b2_c2_b3 := pk_eq_count_mm_b2_c2_b3;
			self.pk_pos_secondary_sources_mm_b2_c2_b3 := pk_pos_secondary_sources_mm_b2_c2_b3;
			self.pk_voter_flag_mm_b2_c2_b3 := pk_voter_flag_mm_b2_c2_b3;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b3;
			self.pk_add2_pos_sources_mm_b2_c2_b3 := pk_add2_pos_sources_mm_b2_c2_b3;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b3 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b3;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b3 := pk_infutor_risk_lvl_nb_mm_b2_c2_b3;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b3;
			self.pk_yr_lname_change_date2_mm_b2_c2_b3 := pk_yr_lname_change_date2_mm_b2_c2_b3;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b3 := pk_yr_gong_did_first_seen2_mm_b2_c2_b3;
			self.pk_yr_header_first_seen2_mm_b2_c2_b3 := pk_yr_header_first_seen2_mm_b2_c2_b3;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b3 := pk_yr_infutor_first_seen2_mm_b2_c2_b3;
			self.pk_em_only_ver_lvl_mm_b2_c2_b3 := pk_em_only_ver_lvl_mm_b2_c2_b3;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b3;
			self.pk_nas_summary_mm_b2_c2_b4 := pk_nas_summary_mm_b2_c2_b4;
			self.pk_nap_summary_mm_b2_c2_b4 := pk_nap_summary_mm_b2_c2_b4;
			self.pk_combo_fnamecount_nb_mm_b2_c2_b4 := pk_combo_fnamecount_nb_mm_b2_c2_b4;
			self.pk_rc_lnamecount_nb_mm_b2_c2_b4 := pk_rc_lnamecount_nb_mm_b2_c2_b4;
			self.pk_rc_phonelnamecount_mm_b2_c2_b4 := pk_rc_phonelnamecount_mm_b2_c2_b4;
			self.pk_rc_addrcount_nb_mm_b2_c2_b4 := pk_rc_addrcount_nb_mm_b2_c2_b4;
			self.pk_rc_phonephonecount_mm_b2_c2_b4 := pk_rc_phonephonecount_mm_b2_c2_b4;
			self.pk_ver_phncount_mm_b2_c2_b4 := pk_ver_phncount_mm_b2_c2_b4;
			self.pk_gong_did_phone_ct_nb_mm_b2_c2_b4 := pk_gong_did_phone_ct_nb_mm_b2_c2_b4;
			self.pk_combo_ssncount_mm_b2_c2_b4 := pk_combo_ssncount_mm_b2_c2_b4;
			self.pk_combo_dobcount_nb_mm_b2_c2_b4 := pk_combo_dobcount_nb_mm_b2_c2_b4;
			self.pk_eq_count_mm_b2_c2_b4 := pk_eq_count_mm_b2_c2_b4;
			self.pk_pos_secondary_sources_mm_b2_c2_b4 := pk_pos_secondary_sources_mm_b2_c2_b4;
			self.pk_voter_flag_mm_b2_c2_b4 := pk_voter_flag_mm_b2_c2_b4;
			self.pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4 := pk_lname_eda_sourced_type_lvl_mm_b2_c2_b4;
			self.pk_add2_pos_sources_mm_b2_c2_b4 := pk_add2_pos_sources_mm_b2_c2_b4;
			self.pk_ssnchar_invalid_or_recent_mm_b2_c2_b4 := pk_ssnchar_invalid_or_recent_mm_b2_c2_b4;
			self.pk_infutor_risk_lvl_nb_mm_b2_c2_b4 := pk_infutor_risk_lvl_nb_mm_b2_c2_b4;
			self.pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4 := pk_yr_adl_em_only_first_seen2_mm_b2_c2_b4;
			self.pk_yr_lname_change_date2_mm_b2_c2_b4 := pk_yr_lname_change_date2_mm_b2_c2_b4;
			self.pk_yr_gong_did_first_seen2_mm_b2_c2_b4 := pk_yr_gong_did_first_seen2_mm_b2_c2_b4;
			self.pk_yr_header_first_seen2_mm_b2_c2_b4 := pk_yr_header_first_seen2_mm_b2_c2_b4;
			self.pk_yr_infutor_first_seen2_mm_b2_c2_b4 := pk_yr_infutor_first_seen2_mm_b2_c2_b4;
			self.pk_em_only_ver_lvl_mm_b2_c2_b4 := pk_em_only_ver_lvl_mm_b2_c2_b4;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2_c2_b4;
			self.pk_nap_summary_mm_b2 := pk_nap_summary_mm_b2;
			self.pk_yr_gong_did_first_seen2_mm_b2 := pk_yr_gong_did_first_seen2_mm_b2;
			self.pk_nas_summary_mm_b2 := pk_nas_summary_mm_b2;
			self.pk_yr_infutor_first_seen2_mm_b2 := pk_yr_infutor_first_seen2_mm_b2;
			self.pk_yr_adl_em_only_first_seen2_mm_b2 := pk_yr_adl_em_only_first_seen2_mm_b2;
			self.pk_yr_lname_change_date2_mm_b2 := pk_yr_lname_change_date2_mm_b2;
			self.pk_ssnchar_invalid_or_recent_mm_b2 := pk_ssnchar_invalid_or_recent_mm_b2;
			self.pk_infutor_risk_lvl_nb_mm_b2 := pk_infutor_risk_lvl_nb_mm_b2;
			self.pk_gong_did_phone_ct_nb_mm_b2 := pk_gong_did_phone_ct_nb_mm_b2;
			self.pk_combo_dobcount_nb_mm_b2 := pk_combo_dobcount_nb_mm_b2;
			self.pk_rc_phonelnamecount_mm_b2 := pk_rc_phonelnamecount_mm_b2;
			self.pk_yr_header_first_seen2_mm_b2 := pk_yr_header_first_seen2_mm_b2;
			self.pk_eq_count_mm_b2 := pk_eq_count_mm_b2;
			self.pk_combo_fnamecount_nb_mm_b2 := pk_combo_fnamecount_nb_mm_b2;
			self.pk_em_only_ver_lvl_mm_b2 := pk_em_only_ver_lvl_mm_b2;
			self.pk_rc_lnamecount_nb_mm_b2 := pk_rc_lnamecount_nb_mm_b2;
			self.pk_combo_ssncount_mm_b2 := pk_combo_ssncount_mm_b2;
			self.pk_pos_secondary_sources_mm_b2 := pk_pos_secondary_sources_mm_b2;
			self.pk_rc_phonephonecount_mm_b2 := pk_rc_phonephonecount_mm_b2;
			self.pk_voter_flag_mm_b2 := pk_voter_flag_mm_b2;
			self.pk_rc_addrcount_nb_mm_b2 := pk_rc_addrcount_nb_mm_b2;
			self.pk_add2_pos_sources_mm_b2 := pk_add2_pos_sources_mm_b2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_b2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_b2;
			self.pk_lname_eda_sourced_type_lvl_mm_b2 := pk_lname_eda_sourced_type_lvl_mm_b2;
			self.pk_ver_phncount_mm_b2 := pk_ver_phncount_mm_b2;
			self.pk_nap_summary_mm := pk_nap_summary_mm;
			self.pk_yr_infutor_first_seen2_mm := pk_yr_infutor_first_seen2_mm;
			self.pk_yr_lname_change_date2_mm := pk_yr_lname_change_date2_mm;
			self.pk_ssnchar_invalid_or_recent_mm := pk_ssnchar_invalid_or_recent_mm;
			self.pk_gong_did_phone_ct_nb_mm := pk_gong_did_phone_ct_nb_mm;
			self.pk_combo_dobcount_nb_mm := pk_combo_dobcount_nb_mm;
			self.pk_rc_phonelnamecount_mm := pk_rc_phonelnamecount_mm;
			self.pk_combo_fnamecount_nb_mm := pk_combo_fnamecount_nb_mm;
			self.pk_rc_lnamecount_nb_mm := pk_rc_lnamecount_nb_mm;
			self.pk_combo_ssncount_mm := pk_combo_ssncount_mm;
			self.pk_pos_secondary_sources_mm := pk_pos_secondary_sources_mm;
			self.pk_voter_flag_mm := pk_voter_flag_mm;
			self.pk_rc_fnamecount_mm := pk_rc_fnamecount_mm;
			self.pk_lname_eda_sourced_type_lvl_mm := pk_lname_eda_sourced_type_lvl_mm;
			self.pk_ver_phncount_mm := pk_ver_phncount_mm;
			self.pk_combo_dobcount_mm := pk_combo_dobcount_mm;
			self.pk_nas_summary_mm := pk_nas_summary_mm;
			self.pk_rc_addrcount_mm := pk_rc_addrcount_mm;
			self.pk_gong_did_phone_ct_mm := pk_gong_did_phone_ct_mm;
			self.pk_yr_gong_did_first_seen2_mm := pk_yr_gong_did_first_seen2_mm;
			self.pk_yr_adl_em_only_first_seen2_mm := pk_yr_adl_em_only_first_seen2_mm;
			self.pk_add2_em_ver_lvl_mm := pk_add2_em_ver_lvl_mm;
			self.pk_infutor_risk_lvl_nb_mm := pk_infutor_risk_lvl_nb_mm;
			self.pk_eq_count_mm := pk_eq_count_mm;
			self.pk_yr_header_first_seen2_mm := pk_yr_header_first_seen2_mm;
			self.pk_em_only_ver_lvl_mm := pk_em_only_ver_lvl_mm;
			self.pk_combo_fnamecount_mm := pk_combo_fnamecount_mm;
			self.pk_rc_phonephonecount_mm := pk_rc_phonephonecount_mm;
			self.pk_add2_pos_sources_mm := pk_add2_pos_sources_mm;
			self.pk_rc_addrcount_nb_mm := pk_rc_addrcount_nb_mm;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm := pk_yrmo_adl_f_sn_mx_fcra2_mm;
			self.pk_infutor_risk_lvl_mm := pk_infutor_risk_lvl_mm;
			self.pk_estimated_income_mm_b1 := pk_estimated_income_mm_b1;
			self.pk_yr_adl_pr_first_seen2_mm_b1 := pk_yr_adl_pr_first_seen2_mm_b1;
			self.pk_yr_adl_w_first_seen2_mm_b1 := pk_yr_adl_w_first_seen2_mm_b1;
			self.pk_pr_count_mm_b1 := pk_pr_count_mm_b1;
			self.pk_addrs_sourced_lvl_mm_b1 := pk_addrs_sourced_lvl_mm_b1;
			self.pk_naprop_level2_mm_b1 := pk_naprop_level2_mm_b1;
			self.pk_add1_purchase_amount2_mm_b1 := pk_add1_purchase_amount2_mm_b1;
			self.pk_yr_add1_mortgage_date2_mm_b1 := pk_yr_add1_mortgage_date2_mm_b1;
			self.pk_add1_mortgage_risk_mm_b1 := pk_add1_mortgage_risk_mm_b1;
			self.pk_add1_assessed_amount2_mm_b1 := pk_add1_assessed_amount2_mm_b1;
			self.pk_yr_add1_mortgage_due_date2_mm_b1 := pk_yr_add1_mortgage_due_date2_mm_b1;
			self.pk_yr_add1_date_first_seen2_mm_b1 := pk_yr_add1_date_first_seen2_mm_b1;
			self.pk_add1_land_use_risk_level_mm_b1 := pk_add1_land_use_risk_level_mm_b1;
			self.pk_add1_building_area2_mm_b1 := pk_add1_building_area2_mm_b1;
			self.pk_add1_no_of_rooms_mm_b1 := pk_add1_no_of_rooms_mm_b1;
			self.pk_add1_no_of_baths_mm_b1 := pk_add1_no_of_baths_mm_b1;
			self.pk_property_owned_total_mm_b1 := pk_property_owned_total_mm_b1;
			self.pk_prop_own_assess_tot2_mm_b1 := pk_prop_own_assess_tot2_mm_b1;
			self.pk_add2_building_area2_mm_b1 := pk_add2_building_area2_mm_b1;
			self.pk_add2_no_of_buildings_mm_b1 := pk_add2_no_of_buildings_mm_b1;
			self.pk_add2_garage_type_risk_lvl_mm_b1 := pk_add2_garage_type_risk_lvl_mm_b1;
			self.pk_add2_parking_no_of_cars_mm_b1 := pk_add2_parking_no_of_cars_mm_b1;
			self.pk_yr_add2_mortgage_due_date2_mm_b1 := pk_yr_add2_mortgage_due_date2_mm_b1;
			self.pk_add2_assessed_amount2_mm_b1 := pk_add2_assessed_amount2_mm_b1;
			self.pk_yr_add2_date_first_seen2_mm_b1 := pk_yr_add2_date_first_seen2_mm_b1;
			self.pk_add3_mortgage_risk_mm_b1 := pk_add3_mortgage_risk_mm_b1;
			self.pk_add3_assessed_amount2_mm_b1 := pk_add3_assessed_amount2_mm_b1;
			self.pk_yr_add3_date_first_seen2_mm_b1 := pk_yr_add3_date_first_seen2_mm_b1;
			self.pk_bk_level_mm_b1 := pk_bk_level_mm_b1;
			self.pk_eviction_level_mm_b1 := pk_eviction_level_mm_b1;
			self.pk_lien_type_level_mm_b1 := pk_lien_type_level_mm_b1;
			self.pk_yr_liens_last_unrel_date3_mm_b1 := pk_yr_liens_last_unrel_date3_mm_b1;
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
			self.pk_addrs_15yr_mm_b1 := pk_addrs_15yr_mm_b1;
			self.pk_add_lres_month_avg2_mm_b1 := pk_add_lres_month_avg2_mm_b1;
			self.pk_ssns_per_adl_mm_b1 := pk_ssns_per_adl_mm_b1;
			self.pk_addrs_per_adl_mm_b1 := pk_addrs_per_adl_mm_b1;
			self.pk_phones_per_adl_mm_b1 := pk_phones_per_adl_mm_b1;
			self.pk_adlperssn_count_mm_b1 := pk_adlperssn_count_mm_b1;
			self.pk_adls_per_addr_mm_b1 := pk_adls_per_addr_mm_b1;
			self.pk_adls_per_phone_mm_b1 := pk_adls_per_phone_mm_b1;
			self.pk_ssns_per_adl_c6_mm_b1 := pk_ssns_per_adl_c6_mm_b1;
			self.pk_ssns_per_addr_c6_mm_b1 := pk_ssns_per_addr_c6_mm_b1;
			self.pk_adls_per_phone_c6_mm_b1 := pk_adls_per_phone_c6_mm_b1;
			self.pk_attr_addrs_last90_mm_b1 := pk_attr_addrs_last90_mm_b1;
			self.pk_attr_addrs_last12_mm_b1 := pk_attr_addrs_last12_mm_b1;
			self.pk_attr_addrs_last24_mm_b1 := pk_attr_addrs_last24_mm_b1;
			self.pk_ams_class_level_mm_b1 := pk_ams_class_level_mm_b1;
			self.pk_ams_4yr_college_mm_b1 := pk_ams_4yr_college_mm_b1;
			self.pk_ams_college_type_mm_b1 := pk_ams_college_type_mm_b1;
			self.pk_ams_income_level_code_mm_b1 := pk_ams_income_level_code_mm_b1;
			self.pk_yr_in_dob2_mm_b1 := pk_yr_in_dob2_mm_b1;
			self.pk_yr_ams_dob2_mm_b1 := pk_yr_ams_dob2_mm_b1;
			self.pk_inferred_age_mm_b1 := pk_inferred_age_mm_b1;
			self.pk_yr_reported_dob2_mm_b1 := pk_yr_reported_dob2_mm_b1;
			self.pk_avm_hit_level_mm_b1 := pk_avm_hit_level_mm_b1;
			self.pk_avm_auto_diff2_lvl_mm_b1 := pk_avm_auto_diff2_lvl_mm_b1;
			self.pk_avm_auto_diff4_lvl_mm_b1 := pk_avm_auto_diff4_lvl_mm_b1;
			self.pk_add2_avm_auto_diff2_lvl_mm_b1 := pk_add2_avm_auto_diff2_lvl_mm_b1;
			self.pk_avm_confidence_level_mm_b1 := pk_avm_confidence_level_mm_b1;
			self.pk2_add1_avm_mkt_mm_b1 := pk2_add1_avm_mkt_mm_b1;
			self.pk2_add1_avm_pi_mm_b1 := pk2_add1_avm_pi_mm_b1;
			self.pk2_add1_avm_auto_mm_b1 := pk2_add1_avm_auto_mm_b1;
			self.pk2_add1_avm_auto2_mm_b1 := pk2_add1_avm_auto2_mm_b1;
			self.pk2_add1_avm_auto3_mm_b1 := pk2_add1_avm_auto3_mm_b1;
			self.pk2_add1_avm_med_mm_b1 := pk2_add1_avm_med_mm_b1;
			self.pk2_add1_avm_to_med_ratio_mm_b1 := pk2_add1_avm_to_med_ratio_mm_b1;
			self.pk2_add2_avm_sp_mm_b1 := pk2_add2_avm_sp_mm_b1;
			self.pk2_add2_avm_ta_mm_b1 := pk2_add2_avm_ta_mm_b1;
			self.pk2_add2_avm_pi_mm_b1 := pk2_add2_avm_pi_mm_b1;
			self.pk2_add2_avm_hed_mm_b1 := pk2_add2_avm_hed_mm_b1;
			self.pk2_add2_avm_auto_mm_b1 := pk2_add2_avm_auto_mm_b1;
			self.pk2_add2_avm_auto3_mm_b1 := pk2_add2_avm_auto3_mm_b1;
			self.pk2_yr_add1_avm_rec_dt_mm_b1 := pk2_yr_add1_avm_rec_dt_mm_b1;
			self.pk2_yr_add1_avm_assess_year_mm_b1 := pk2_yr_add1_avm_assess_year_mm_b1;
			self.pk_dist_a1toa2_mm_b1 := pk_dist_a1toa2_mm_b1;
			self.pk_dist_a1toa3_mm_b1 := pk_dist_a1toa3_mm_b1;
			self.pk_rc_disthphoneaddr_mm_b1 := pk_rc_disthphoneaddr_mm_b1;
			self.pk_out_st_division_lvl_mm_b1 := pk_out_st_division_lvl_mm_b1;
			self.pk_wealth_index_mm_b1 := pk_wealth_index_mm_b1;
			self.pk_attr_num_nonderogs90_b_mm_b1 := pk_attr_num_nonderogs90_b_mm_b1;
			self.pk_ssns_per_addr2_mm_b1 := pk_ssns_per_addr2_mm_b1;
			self.pk_yr_add2_assess_val_yr2_mm_b1 := pk_yr_add2_assess_val_yr2_mm_b1;
			self.pk_estimated_income_mm_b2 := pk_estimated_income_mm_b2;
			self.pk_yr_adl_pr_first_seen2_mm_b2 := pk_yr_adl_pr_first_seen2_mm_b2;
			self.pk_yr_adl_w_first_seen2_mm_b2 := pk_yr_adl_w_first_seen2_mm_b2;
			self.pk_pr_count_mm_b2 := pk_pr_count_mm_b2;
			self.pk_addrs_sourced_lvl_mm_b2 := pk_addrs_sourced_lvl_mm_b2;
			self.pk_naprop_level2_mm_b2 := pk_naprop_level2_mm_b2;
			self.pk_add1_purchase_amount2_mm_b2 := pk_add1_purchase_amount2_mm_b2;
			self.pk_yr_add1_mortgage_date2_mm_b2 := pk_yr_add1_mortgage_date2_mm_b2;
			self.pk_add1_mortgage_risk_mm_b2 := pk_add1_mortgage_risk_mm_b2;
			self.pk_add1_assessed_amount2_mm_b2 := pk_add1_assessed_amount2_mm_b2;
			self.pk_yr_add1_mortgage_due_date2_mm_b2 := pk_yr_add1_mortgage_due_date2_mm_b2;
			self.pk_yr_add1_date_first_seen2_mm_b2 := pk_yr_add1_date_first_seen2_mm_b2;
			self.pk_add1_land_use_risk_level_mm_b2 := pk_add1_land_use_risk_level_mm_b2;
			self.pk_add1_building_area2_mm_b2 := pk_add1_building_area2_mm_b2;
			self.pk_add1_no_of_rooms_mm_b2 := pk_add1_no_of_rooms_mm_b2;
			self.pk_add1_no_of_baths_mm_b2 := pk_add1_no_of_baths_mm_b2;
			self.pk_property_owned_total_mm_b2 := pk_property_owned_total_mm_b2;
			self.pk_prop_own_assess_tot2_mm_b2 := pk_prop_own_assess_tot2_mm_b2;
			self.pk_add2_building_area2_mm_b2 := pk_add2_building_area2_mm_b2;
			self.pk_add2_no_of_buildings_mm_b2 := pk_add2_no_of_buildings_mm_b2;
			self.pk_add2_garage_type_risk_lvl_mm_b2 := pk_add2_garage_type_risk_lvl_mm_b2;
			self.pk_add2_parking_no_of_cars_mm_b2 := pk_add2_parking_no_of_cars_mm_b2;
			self.pk_yr_add2_mortgage_due_date2_mm_b2 := pk_yr_add2_mortgage_due_date2_mm_b2;
			self.pk_add2_assessed_amount2_mm_b2 := pk_add2_assessed_amount2_mm_b2;
			self.pk_yr_add2_date_first_seen2_mm_b2 := pk_yr_add2_date_first_seen2_mm_b2;
			self.pk_add3_mortgage_risk_mm_b2 := pk_add3_mortgage_risk_mm_b2;
			self.pk_add3_assessed_amount2_mm_b2 := pk_add3_assessed_amount2_mm_b2;
			self.pk_yr_add3_date_first_seen2_mm_b2 := pk_yr_add3_date_first_seen2_mm_b2;
			self.pk_bk_level_mm_b2 := pk_bk_level_mm_b2;
			self.pk_eviction_level_mm_b2 := pk_eviction_level_mm_b2;
			self.pk_lien_type_level_mm_b2 := pk_lien_type_level_mm_b2;
			self.pk_yr_liens_last_unrel_date3_mm_b2 := pk_yr_liens_last_unrel_date3_mm_b2;
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
			self.pk_addrs_15yr_mm_b2 := pk_addrs_15yr_mm_b2;
			self.pk_add_lres_month_avg2_mm_b2 := pk_add_lres_month_avg2_mm_b2;
			self.pk_ssns_per_adl_mm_b2 := pk_ssns_per_adl_mm_b2;
			self.pk_addrs_per_adl_mm_b2 := pk_addrs_per_adl_mm_b2;
			self.pk_phones_per_adl_mm_b2 := pk_phones_per_adl_mm_b2;
			self.pk_adlperssn_count_mm_b2 := pk_adlperssn_count_mm_b2;
			self.pk_adls_per_addr_mm_b2 := pk_adls_per_addr_mm_b2;
			self.pk_adls_per_phone_mm_b2 := pk_adls_per_phone_mm_b2;
			self.pk_ssns_per_adl_c6_mm_b2 := pk_ssns_per_adl_c6_mm_b2;
			self.pk_ssns_per_addr_c6_mm_b2 := pk_ssns_per_addr_c6_mm_b2;
			self.pk_adls_per_phone_c6_mm_b2 := pk_adls_per_phone_c6_mm_b2;
			self.pk_attr_addrs_last90_mm_b2 := pk_attr_addrs_last90_mm_b2;
			self.pk_attr_addrs_last12_mm_b2 := pk_attr_addrs_last12_mm_b2;
			self.pk_attr_addrs_last24_mm_b2 := pk_attr_addrs_last24_mm_b2;
			self.pk_ams_class_level_mm_b2 := pk_ams_class_level_mm_b2;
			self.pk_ams_4yr_college_mm_b2 := pk_ams_4yr_college_mm_b2;
			self.pk_ams_college_type_mm_b2 := pk_ams_college_type_mm_b2;
			self.pk_ams_income_level_code_mm_b2 := pk_ams_income_level_code_mm_b2;
			self.pk_yr_in_dob2_mm_b2 := pk_yr_in_dob2_mm_b2;
			self.pk_yr_ams_dob2_mm_b2 := pk_yr_ams_dob2_mm_b2;
			self.pk_inferred_age_mm_b2 := pk_inferred_age_mm_b2;
			self.pk_yr_reported_dob2_mm_b2 := pk_yr_reported_dob2_mm_b2;
			self.pk_avm_hit_level_mm_b2 := pk_avm_hit_level_mm_b2;
			self.pk_avm_auto_diff2_lvl_mm_b2 := pk_avm_auto_diff2_lvl_mm_b2;
			self.pk_avm_auto_diff4_lvl_mm_b2 := pk_avm_auto_diff4_lvl_mm_b2;
			self.pk_add2_avm_auto_diff2_lvl_mm_b2 := pk_add2_avm_auto_diff2_lvl_mm_b2;
			self.pk_avm_confidence_level_mm_b2 := pk_avm_confidence_level_mm_b2;
			self.pk2_add1_avm_mkt_mm_b2 := pk2_add1_avm_mkt_mm_b2;
			self.pk2_add1_avm_pi_mm_b2 := pk2_add1_avm_pi_mm_b2;
			self.pk2_add1_avm_auto_mm_b2 := pk2_add1_avm_auto_mm_b2;
			self.pk2_add1_avm_auto2_mm_b2 := pk2_add1_avm_auto2_mm_b2;
			self.pk2_add1_avm_auto3_mm_b2 := pk2_add1_avm_auto3_mm_b2;
			self.pk2_add1_avm_med_mm_b2 := pk2_add1_avm_med_mm_b2;
			self.pk2_add1_avm_to_med_ratio_mm_b2 := pk2_add1_avm_to_med_ratio_mm_b2;
			self.pk2_add2_avm_sp_mm_b2 := pk2_add2_avm_sp_mm_b2;
			self.pk2_add2_avm_ta_mm_b2 := pk2_add2_avm_ta_mm_b2;
			self.pk2_add2_avm_pi_mm_b2 := pk2_add2_avm_pi_mm_b2;
			self.pk2_add2_avm_hed_mm_b2 := pk2_add2_avm_hed_mm_b2;
			self.pk2_add2_avm_auto_mm_b2 := pk2_add2_avm_auto_mm_b2;
			self.pk2_add2_avm_auto3_mm_b2 := pk2_add2_avm_auto3_mm_b2;
			self.pk2_yr_add1_avm_rec_dt_mm_b2 := pk2_yr_add1_avm_rec_dt_mm_b2;
			self.pk2_yr_add1_avm_assess_year_mm_b2 := pk2_yr_add1_avm_assess_year_mm_b2;
			self.pk_dist_a1toa2_mm_b2 := pk_dist_a1toa2_mm_b2;
			self.pk_dist_a1toa3_mm_b2 := pk_dist_a1toa3_mm_b2;
			self.pk_rc_disthphoneaddr_mm_b2 := pk_rc_disthphoneaddr_mm_b2;
			self.pk_out_st_division_lvl_mm_b2 := pk_out_st_division_lvl_mm_b2;
			self.pk_wealth_index_mm_b2 := pk_wealth_index_mm_b2;
			self.pk_attr_num_nonderogs90_b_mm_b2 := pk_attr_num_nonderogs90_b_mm_b2;
			self.pk_ssns_per_addr2_mm_b2 := pk_ssns_per_addr2_mm_b2;
			self.pk_yr_add2_assess_val_yr2_mm_b2 := pk_yr_add2_assess_val_yr2_mm_b2;
			self.pk_estimated_income_mm_b3 := pk_estimated_income_mm_b3;
			self.pk_yr_adl_pr_first_seen2_mm_b3 := pk_yr_adl_pr_first_seen2_mm_b3;
			self.pk_yr_adl_w_first_seen2_mm_b3 := pk_yr_adl_w_first_seen2_mm_b3;
			self.pk_pr_count_mm_b3 := pk_pr_count_mm_b3;
			self.pk_addrs_sourced_lvl_mm_b3 := pk_addrs_sourced_lvl_mm_b3;
			self.pk_naprop_level2_mm_b3 := pk_naprop_level2_mm_b3;
			self.pk_add1_purchase_amount2_mm_b3 := pk_add1_purchase_amount2_mm_b3;
			self.pk_yr_add1_mortgage_date2_mm_b3 := pk_yr_add1_mortgage_date2_mm_b3;
			self.pk_add1_mortgage_risk_mm_b3 := pk_add1_mortgage_risk_mm_b3;
			self.pk_add1_assessed_amount2_mm_b3 := pk_add1_assessed_amount2_mm_b3;
			self.pk_yr_add1_mortgage_due_date2_mm_b3 := pk_yr_add1_mortgage_due_date2_mm_b3;
			self.pk_yr_add1_date_first_seen2_mm_b3 := pk_yr_add1_date_first_seen2_mm_b3;
			self.pk_add1_land_use_risk_level_mm_b3 := pk_add1_land_use_risk_level_mm_b3;
			self.pk_add1_building_area2_mm_b3 := pk_add1_building_area2_mm_b3;
			self.pk_add1_no_of_rooms_mm_b3 := pk_add1_no_of_rooms_mm_b3;
			self.pk_add1_no_of_baths_mm_b3 := pk_add1_no_of_baths_mm_b3;
			self.pk_property_owned_total_mm_b3 := pk_property_owned_total_mm_b3;
			self.pk_prop_own_assess_tot2_mm_b3 := pk_prop_own_assess_tot2_mm_b3;
			self.pk_add2_building_area2_mm_b3 := pk_add2_building_area2_mm_b3;
			self.pk_add2_no_of_buildings_mm_b3 := pk_add2_no_of_buildings_mm_b3;
			self.pk_add2_garage_type_risk_lvl_mm_b3 := pk_add2_garage_type_risk_lvl_mm_b3;
			self.pk_add2_parking_no_of_cars_mm_b3 := pk_add2_parking_no_of_cars_mm_b3;
			self.pk_yr_add2_mortgage_due_date2_mm_b3 := pk_yr_add2_mortgage_due_date2_mm_b3;
			self.pk_add2_assessed_amount2_mm_b3 := pk_add2_assessed_amount2_mm_b3;
			self.pk_yr_add2_date_first_seen2_mm_b3 := pk_yr_add2_date_first_seen2_mm_b3;
			self.pk_add3_mortgage_risk_mm_b3 := pk_add3_mortgage_risk_mm_b3;
			self.pk_add3_assessed_amount2_mm_b3 := pk_add3_assessed_amount2_mm_b3;
			self.pk_yr_add3_date_first_seen2_mm_b3 := pk_yr_add3_date_first_seen2_mm_b3;
			self.pk_bk_level_mm_b3 := pk_bk_level_mm_b3;
			self.pk_eviction_level_mm_b3 := pk_eviction_level_mm_b3;
			self.pk_lien_type_level_mm_b3 := pk_lien_type_level_mm_b3;
			self.pk_yr_liens_last_unrel_date3_mm_b3 := pk_yr_liens_last_unrel_date3_mm_b3;
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
			self.pk_addrs_15yr_mm_b3 := pk_addrs_15yr_mm_b3;
			self.pk_add_lres_month_avg2_mm_b3 := pk_add_lres_month_avg2_mm_b3;
			self.pk_ssns_per_adl_mm_b3 := pk_ssns_per_adl_mm_b3;
			self.pk_addrs_per_adl_mm_b3 := pk_addrs_per_adl_mm_b3;
			self.pk_phones_per_adl_mm_b3 := pk_phones_per_adl_mm_b3;
			self.pk_adlperssn_count_mm_b3 := pk_adlperssn_count_mm_b3;
			self.pk_adls_per_addr_mm_b3 := pk_adls_per_addr_mm_b3;
			self.pk_adls_per_phone_mm_b3 := pk_adls_per_phone_mm_b3;
			self.pk_ssns_per_adl_c6_mm_b3 := pk_ssns_per_adl_c6_mm_b3;
			self.pk_ssns_per_addr_c6_mm_b3 := pk_ssns_per_addr_c6_mm_b3;
			self.pk_adls_per_phone_c6_mm_b3 := pk_adls_per_phone_c6_mm_b3;
			self.pk_attr_addrs_last90_mm_b3 := pk_attr_addrs_last90_mm_b3;
			self.pk_attr_addrs_last12_mm_b3 := pk_attr_addrs_last12_mm_b3;
			self.pk_attr_addrs_last24_mm_b3 := pk_attr_addrs_last24_mm_b3;
			self.pk_ams_class_level_mm_b3 := pk_ams_class_level_mm_b3;
			self.pk_ams_4yr_college_mm_b3 := pk_ams_4yr_college_mm_b3;
			self.pk_ams_college_type_mm_b3 := pk_ams_college_type_mm_b3;
			self.pk_ams_income_level_code_mm_b3 := pk_ams_income_level_code_mm_b3;
			self.pk_yr_in_dob2_mm_b3 := pk_yr_in_dob2_mm_b3;
			self.pk_yr_ams_dob2_mm_b3 := pk_yr_ams_dob2_mm_b3;
			self.pk_inferred_age_mm_b3 := pk_inferred_age_mm_b3;
			self.pk_yr_reported_dob2_mm_b3 := pk_yr_reported_dob2_mm_b3;
			self.pk_avm_hit_level_mm_b3 := pk_avm_hit_level_mm_b3;
			self.pk_avm_auto_diff2_lvl_mm_b3 := pk_avm_auto_diff2_lvl_mm_b3;
			self.pk_avm_auto_diff4_lvl_mm_b3 := pk_avm_auto_diff4_lvl_mm_b3;
			self.pk_add2_avm_auto_diff2_lvl_mm_b3 := pk_add2_avm_auto_diff2_lvl_mm_b3;
			self.pk_avm_confidence_level_mm_b3 := pk_avm_confidence_level_mm_b3;
			self.pk2_add1_avm_mkt_mm_b3 := pk2_add1_avm_mkt_mm_b3;
			self.pk2_add1_avm_pi_mm_b3 := pk2_add1_avm_pi_mm_b3;
			self.pk2_add1_avm_auto_mm_b3 := pk2_add1_avm_auto_mm_b3;
			self.pk2_add1_avm_auto2_mm_b3 := pk2_add1_avm_auto2_mm_b3;
			self.pk2_add1_avm_auto3_mm_b3 := pk2_add1_avm_auto3_mm_b3;
			self.pk2_add1_avm_med_mm_b3 := pk2_add1_avm_med_mm_b3;
			self.pk2_add1_avm_to_med_ratio_mm_b3 := pk2_add1_avm_to_med_ratio_mm_b3;
			self.pk2_add2_avm_sp_mm_b3 := pk2_add2_avm_sp_mm_b3;
			self.pk2_add2_avm_ta_mm_b3 := pk2_add2_avm_ta_mm_b3;
			self.pk2_add2_avm_pi_mm_b3 := pk2_add2_avm_pi_mm_b3;
			self.pk2_add2_avm_hed_mm_b3 := pk2_add2_avm_hed_mm_b3;
			self.pk2_add2_avm_auto_mm_b3 := pk2_add2_avm_auto_mm_b3;
			self.pk2_add2_avm_auto3_mm_b3 := pk2_add2_avm_auto3_mm_b3;
			self.pk2_yr_add1_avm_rec_dt_mm_b3 := pk2_yr_add1_avm_rec_dt_mm_b3;
			self.pk2_yr_add1_avm_assess_year_mm_b3 := pk2_yr_add1_avm_assess_year_mm_b3;
			self.pk_dist_a1toa2_mm_b3 := pk_dist_a1toa2_mm_b3;
			self.pk_dist_a1toa3_mm_b3 := pk_dist_a1toa3_mm_b3;
			self.pk_rc_disthphoneaddr_mm_b3 := pk_rc_disthphoneaddr_mm_b3;
			self.pk_out_st_division_lvl_mm_b3 := pk_out_st_division_lvl_mm_b3;
			self.pk_wealth_index_mm_b3 := pk_wealth_index_mm_b3;
			self.pk_attr_num_nonderogs90_b_mm_b3 := pk_attr_num_nonderogs90_b_mm_b3;
			self.pk_ssns_per_addr2_mm_b3 := pk_ssns_per_addr2_mm_b3;
			self.pk_yr_add2_assess_val_yr2_mm_b3 := pk_yr_add2_assess_val_yr2_mm_b3;
			self.pk_estimated_income_mm_b4 := pk_estimated_income_mm_b4;
			self.pk_yr_adl_pr_first_seen2_mm_b4 := pk_yr_adl_pr_first_seen2_mm_b4;
			self.pk_yr_adl_w_first_seen2_mm_b4 := pk_yr_adl_w_first_seen2_mm_b4;
			self.pk_pr_count_mm_b4 := pk_pr_count_mm_b4;
			self.pk_addrs_sourced_lvl_mm_b4 := pk_addrs_sourced_lvl_mm_b4;
			self.pk_naprop_level2_mm_b4 := pk_naprop_level2_mm_b4;
			self.pk_add1_purchase_amount2_mm_b4 := pk_add1_purchase_amount2_mm_b4;
			self.pk_yr_add1_mortgage_date2_mm_b4 := pk_yr_add1_mortgage_date2_mm_b4;
			self.pk_add1_mortgage_risk_mm_b4 := pk_add1_mortgage_risk_mm_b4;
			self.pk_add1_assessed_amount2_mm_b4 := pk_add1_assessed_amount2_mm_b4;
			self.pk_yr_add1_mortgage_due_date2_mm_b4 := pk_yr_add1_mortgage_due_date2_mm_b4;
			self.pk_yr_add1_date_first_seen2_mm_b4 := pk_yr_add1_date_first_seen2_mm_b4;
			self.pk_add1_land_use_risk_level_mm_b4 := pk_add1_land_use_risk_level_mm_b4;
			self.pk_add1_building_area2_mm_b4 := pk_add1_building_area2_mm_b4;
			self.pk_add1_no_of_rooms_mm_b4 := pk_add1_no_of_rooms_mm_b4;
			self.pk_add1_no_of_baths_mm_b4 := pk_add1_no_of_baths_mm_b4;
			self.pk_property_owned_total_mm_b4 := pk_property_owned_total_mm_b4;
			self.pk_prop_own_assess_tot2_mm_b4 := pk_prop_own_assess_tot2_mm_b4;
			self.pk_add2_building_area2_mm_b4 := pk_add2_building_area2_mm_b4;
			self.pk_add2_no_of_buildings_mm_b4 := pk_add2_no_of_buildings_mm_b4;
			self.pk_add2_garage_type_risk_lvl_mm_b4 := pk_add2_garage_type_risk_lvl_mm_b4;
			self.pk_add2_parking_no_of_cars_mm_b4 := pk_add2_parking_no_of_cars_mm_b4;
			self.pk_yr_add2_mortgage_due_date2_mm_b4 := pk_yr_add2_mortgage_due_date2_mm_b4;
			self.pk_add2_assessed_amount2_mm_b4 := pk_add2_assessed_amount2_mm_b4;
			self.pk_yr_add2_date_first_seen2_mm_b4 := pk_yr_add2_date_first_seen2_mm_b4;
			self.pk_add3_mortgage_risk_mm_b4 := pk_add3_mortgage_risk_mm_b4;
			self.pk_add3_assessed_amount2_mm_b4 := pk_add3_assessed_amount2_mm_b4;
			self.pk_yr_add3_date_first_seen2_mm_b4 := pk_yr_add3_date_first_seen2_mm_b4;
			self.pk_bk_level_mm_b4 := pk_bk_level_mm_b4;
			self.pk_eviction_level_mm_b4 := pk_eviction_level_mm_b4;
			self.pk_lien_type_level_mm_b4 := pk_lien_type_level_mm_b4;
			self.pk_yr_liens_last_unrel_date3_mm_b4 := pk_yr_liens_last_unrel_date3_mm_b4;
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
			self.pk_addrs_15yr_mm_b4 := pk_addrs_15yr_mm_b4;
			self.pk_add_lres_month_avg2_mm_b4 := pk_add_lres_month_avg2_mm_b4;
			self.pk_ssns_per_adl_mm_b4 := pk_ssns_per_adl_mm_b4;
			self.pk_addrs_per_adl_mm_b4 := pk_addrs_per_adl_mm_b4;
			self.pk_phones_per_adl_mm_b4 := pk_phones_per_adl_mm_b4;
			self.pk_adlperssn_count_mm_b4 := pk_adlperssn_count_mm_b4;
			self.pk_adls_per_addr_mm_b4 := pk_adls_per_addr_mm_b4;
			self.pk_adls_per_phone_mm_b4 := pk_adls_per_phone_mm_b4;
			self.pk_ssns_per_adl_c6_mm_b4 := pk_ssns_per_adl_c6_mm_b4;
			self.pk_ssns_per_addr_c6_mm_b4 := pk_ssns_per_addr_c6_mm_b4;
			self.pk_adls_per_phone_c6_mm_b4 := pk_adls_per_phone_c6_mm_b4;
			self.pk_attr_addrs_last90_mm_b4 := pk_attr_addrs_last90_mm_b4;
			self.pk_attr_addrs_last12_mm_b4 := pk_attr_addrs_last12_mm_b4;
			self.pk_attr_addrs_last24_mm_b4 := pk_attr_addrs_last24_mm_b4;
			self.pk_ams_class_level_mm_b4 := pk_ams_class_level_mm_b4;
			self.pk_ams_4yr_college_mm_b4 := pk_ams_4yr_college_mm_b4;
			self.pk_ams_college_type_mm_b4 := pk_ams_college_type_mm_b4;
			self.pk_ams_income_level_code_mm_b4 := pk_ams_income_level_code_mm_b4;
			self.pk_yr_in_dob2_mm_b4 := pk_yr_in_dob2_mm_b4;
			self.pk_yr_ams_dob2_mm_b4 := pk_yr_ams_dob2_mm_b4;
			self.pk_inferred_age_mm_b4 := pk_inferred_age_mm_b4;
			self.pk_yr_reported_dob2_mm_b4 := pk_yr_reported_dob2_mm_b4;
			self.pk_avm_hit_level_mm_b4 := pk_avm_hit_level_mm_b4;
			self.pk_avm_auto_diff2_lvl_mm_b4 := pk_avm_auto_diff2_lvl_mm_b4;
			self.pk_avm_auto_diff4_lvl_mm_b4 := pk_avm_auto_diff4_lvl_mm_b4;
			self.pk_add2_avm_auto_diff2_lvl_mm_b4 := pk_add2_avm_auto_diff2_lvl_mm_b4;
			self.pk_avm_confidence_level_mm_b4 := pk_avm_confidence_level_mm_b4;
			self.pk2_add1_avm_mkt_mm_b4 := pk2_add1_avm_mkt_mm_b4;
			self.pk2_add1_avm_pi_mm_b4 := pk2_add1_avm_pi_mm_b4;
			self.pk2_add1_avm_auto_mm_b4 := pk2_add1_avm_auto_mm_b4;
			self.pk2_add1_avm_auto2_mm_b4 := pk2_add1_avm_auto2_mm_b4;
			self.pk2_add1_avm_auto3_mm_b4 := pk2_add1_avm_auto3_mm_b4;
			self.pk2_add1_avm_med_mm_b4 := pk2_add1_avm_med_mm_b4;
			self.pk2_add1_avm_to_med_ratio_mm_b4 := pk2_add1_avm_to_med_ratio_mm_b4;
			self.pk2_add2_avm_sp_mm_b4 := pk2_add2_avm_sp_mm_b4;
			self.pk2_add2_avm_ta_mm_b4 := pk2_add2_avm_ta_mm_b4;
			self.pk2_add2_avm_pi_mm_b4 := pk2_add2_avm_pi_mm_b4;
			self.pk2_add2_avm_hed_mm_b4 := pk2_add2_avm_hed_mm_b4;
			self.pk2_add2_avm_auto_mm_b4 := pk2_add2_avm_auto_mm_b4;
			self.pk2_add2_avm_auto3_mm_b4 := pk2_add2_avm_auto3_mm_b4;
			self.pk2_yr_add1_avm_rec_dt_mm_b4 := pk2_yr_add1_avm_rec_dt_mm_b4;
			self.pk2_yr_add1_avm_assess_year_mm_b4 := pk2_yr_add1_avm_assess_year_mm_b4;
			self.pk_dist_a1toa2_mm_b4 := pk_dist_a1toa2_mm_b4;
			self.pk_dist_a1toa3_mm_b4 := pk_dist_a1toa3_mm_b4;
			self.pk_rc_disthphoneaddr_mm_b4 := pk_rc_disthphoneaddr_mm_b4;
			self.pk_out_st_division_lvl_mm_b4 := pk_out_st_division_lvl_mm_b4;
			self.pk_wealth_index_mm_b4 := pk_wealth_index_mm_b4;
			self.pk_attr_num_nonderogs90_b_mm_b4 := pk_attr_num_nonderogs90_b_mm_b4;
			self.pk_ssns_per_addr2_mm_b4 := pk_ssns_per_addr2_mm_b4;
			self.pk_yr_add2_assess_val_yr2_mm_b4 := pk_yr_add2_assess_val_yr2_mm_b4;
			self.pk_yr_criminal_last_date2_mm := pk_yr_criminal_last_date2_mm;
			self.pk_add2_garage_type_risk_lvl_mm := pk_add2_garage_type_risk_lvl_mm;
			self.pk_prop_own_assess_tot2_mm := pk_prop_own_assess_tot2_mm;
			self.pk_yr_add1_date_first_seen2_mm := pk_yr_add1_date_first_seen2_mm;
			self.pk_attr_addrs_last90_mm := pk_attr_addrs_last90_mm;
			self.pk_add1_purchase_amount2_mm := pk_add1_purchase_amount2_mm;
			self.pk_adls_per_phone_mm := pk_adls_per_phone_mm;
			self.pk_ssns_per_addr2_mm := pk_ssns_per_addr2_mm;
			self.pk_property_owned_total_mm := pk_property_owned_total_mm;
			self.pk_ams_class_level_mm := pk_ams_class_level_mm;
			self.pk_attr_addrs_last12_mm := pk_attr_addrs_last12_mm;
			self.pk_adls_per_phone_c6_mm := pk_adls_per_phone_c6_mm;
			self.pk_yr_add2_date_first_seen2_mm := pk_yr_add2_date_first_seen2_mm;
			self.pk_adlperssn_count_mm := pk_adlperssn_count_mm;
			self.pk2_add2_avm_auto_mm := pk2_add2_avm_auto_mm;
			self.pk2_add2_avm_hed_mm := pk2_add2_avm_hed_mm;
			self.pk_avm_auto_diff4_lvl_mm := pk_avm_auto_diff4_lvl_mm;
			self.pk_ams_college_type_mm := pk_ams_college_type_mm;
			self.pk_yr_add3_date_first_seen2_mm := pk_yr_add3_date_first_seen2_mm;
			self.pk_add1_land_use_risk_level_mm := pk_add1_land_use_risk_level_mm;
			self.pk2_add2_avm_ta_mm := pk2_add2_avm_ta_mm;
			self.pk_add2_lres_mm := pk_add2_lres_mm;
			self.pk_addrs_sourced_lvl_mm := pk_addrs_sourced_lvl_mm;
			self.pk_add_lres_month_avg2_mm := pk_add_lres_month_avg2_mm;
			self.pk_rc_disthphoneaddr_mm := pk_rc_disthphoneaddr_mm;
			self.pk_add1_lres_mm := pk_add1_lres_mm;
			self.pk_attr_total_number_derogs_mm := pk_attr_total_number_derogs_mm;
			self.pk2_add2_avm_sp_mm := pk2_add2_avm_sp_mm;
			self.pk_addrs_per_adl_mm := pk_addrs_per_adl_mm;
			self.pk_naprop_level2_mm := pk_naprop_level2_mm;
			self.pk2_add1_avm_auto3_mm := pk2_add1_avm_auto3_mm;
			self.pk2_add1_avm_mkt_mm := pk2_add1_avm_mkt_mm;
			self.pk_yr_reported_dob2_mm := pk_yr_reported_dob2_mm;
			self.pk_ssns_per_adl_mm := pk_ssns_per_adl_mm;
			self.pk_ams_income_level_code_mm := pk_ams_income_level_code_mm;
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
			self.pk_add1_no_of_rooms_mm := pk_add1_no_of_rooms_mm;
			self.pk2_add1_avm_auto2_mm := pk2_add1_avm_auto2_mm;
			self.pk_ams_4yr_college_mm := pk_ams_4yr_college_mm;
			self.pk_ssns_per_addr_c6_mm := pk_ssns_per_addr_c6_mm;
			self.pk2_yr_add1_avm_rec_dt_mm := pk2_yr_add1_avm_rec_dt_mm;
			self.pk_add1_mortgage_risk_mm := pk_add1_mortgage_risk_mm;
			self.pk_yr_add2_assess_val_yr2_mm := pk_yr_add2_assess_val_yr2_mm;
			self.pk_pl_sourced_level_mm := pk_pl_sourced_level_mm;
			self.pk_add2_assessed_amount2_mm := pk_add2_assessed_amount2_mm;
			self.pk_prof_lic_cat_mm := pk_prof_lic_cat_mm;
			self.pk_dist_a1toa3_mm := pk_dist_a1toa3_mm;
			self.pk_eviction_level_mm := pk_eviction_level_mm;
			self.pk_attr_num_nonderogs90_b_mm := pk_attr_num_nonderogs90_b_mm;
			self.pk_adls_per_addr_mm := pk_adls_per_addr_mm;
			self.pk_yr_ams_dob2_mm := pk_yr_ams_dob2_mm;
			self.pk_ssns_per_adl_c6_mm := pk_ssns_per_adl_c6_mm;
			self.pk_attr_addrs_last24_mm := pk_attr_addrs_last24_mm;
			self.pk_add2_avm_auto_diff2_lvl_mm := pk_add2_avm_auto_diff2_lvl_mm;
			self.pk_add3_mortgage_risk_mm := pk_add3_mortgage_risk_mm;
			self.pk_add2_parking_no_of_cars_mm := pk_add2_parking_no_of_cars_mm;
			self.pk2_add1_avm_med_mm := pk2_add1_avm_med_mm;
			self.pk_avm_confidence_level_mm := pk_avm_confidence_level_mm;
			self.pk_add2_no_of_buildings_mm := pk_add2_no_of_buildings_mm;
			self.pk_yr_add2_mortgage_due_date2_mm := pk_yr_add2_mortgage_due_date2_mm;
			self.pk_yr_add1_mortgage_date2_mm := pk_yr_add1_mortgage_date2_mm;
			self.pk_addrs_15yr_mm := pk_addrs_15yr_mm;
			self.pk_yr_in_dob2_mm := pk_yr_in_dob2_mm;
			self.pk_avm_hit_level_mm := pk_avm_hit_level_mm;
			self.pk_bk_level_mm := pk_bk_level_mm;
			self.pk_wealth_index_mm := pk_wealth_index_mm;
			self.pk2_add2_avm_pi_mm := pk2_add2_avm_pi_mm;
			self.pk2_add1_avm_to_med_ratio_mm := pk2_add1_avm_to_med_ratio_mm;
			self.pk2_add1_avm_auto_mm := pk2_add1_avm_auto_mm;
			self.pk_yr_adl_pr_first_seen2_mm := pk_yr_adl_pr_first_seen2_mm;
			self.pk_add1_assessed_amount2_mm := pk_add1_assessed_amount2_mm;
			self.pk_add3_lres_mm := pk_add3_lres_mm;
			self.pk_lres_flag_level_mm := pk_lres_flag_level_mm;
			self.pk_estimated_income_mm := pk_estimated_income_mm;
			self.pk_yr_adl_w_first_seen2_mm := pk_yr_adl_w_first_seen2_mm;
			self.pk_yr_add1_mortgage_due_date2_mm := pk_yr_add1_mortgage_due_date2_mm;
			self.pk_dist_a1toa2_mm := pk_dist_a1toa2_mm;
			self.pk_add3_assessed_amount2_mm := pk_add3_assessed_amount2_mm;
			self.pk_yr_felony_last_date2_mm := pk_yr_felony_last_date2_mm;
			self.pk_addrs_5yr_mm := pk_addrs_5yr_mm;
			self.pk_lien_type_level_mm := pk_lien_type_level_mm;
			self.pk2_add2_avm_auto3_mm := pk2_add2_avm_auto3_mm;
			self.pk2_add1_avm_pi_mm := pk2_add1_avm_pi_mm;
			self.pk_yr_liens_last_unrel_date3_mm := pk_yr_liens_last_unrel_date3_mm;
			self.segment_mean := segment_mean;
			self.pk_add_lres_month_avg2_mm_2 := pk_add_lres_month_avg2_mm_2;
			self.pk_add1_assessed_amount2_mm_2 := pk_add1_assessed_amount2_mm_2;
			self.pk_add1_building_area2_mm_2 := pk_add1_building_area2_mm_2;
			self.pk_add1_land_use_risk_level_mm_2 := pk_add1_land_use_risk_level_mm_2;
			self.pk_add1_lres_mm_2 := pk_add1_lres_mm_2;
			self.pk_add1_mortgage_risk_mm_2 := pk_add1_mortgage_risk_mm_2;
			self.pk_add1_no_of_baths_mm_2 := pk_add1_no_of_baths_mm_2;
			self.pk_add1_no_of_rooms_mm_2 := pk_add1_no_of_rooms_mm_2;
			self.pk_add1_purchase_amount2_mm_2 := pk_add1_purchase_amount2_mm_2;
			self.pk_add2_assessed_amount2_mm_2 := pk_add2_assessed_amount2_mm_2;
			self.pk_add2_avm_auto_diff2_lvl_mm_2 := pk_add2_avm_auto_diff2_lvl_mm_2;
			self.pk_add2_building_area2_mm_2 := pk_add2_building_area2_mm_2;
			self.pk_add2_em_ver_lvl_mm_2 := pk_add2_em_ver_lvl_mm_2;
			self.pk_add2_garage_type_risk_lvl_mm_2 := pk_add2_garage_type_risk_lvl_mm_2;
			self.pk_add2_lres_mm_2 := pk_add2_lres_mm_2;
			self.pk_add2_no_of_buildings_mm_2 := pk_add2_no_of_buildings_mm_2;
			self.pk_add2_parking_no_of_cars_mm_2 := pk_add2_parking_no_of_cars_mm_2;
			self.pk_add2_pos_sources_mm_2 := pk_add2_pos_sources_mm_2;
			self.pk_add3_assessed_amount2_mm_2 := pk_add3_assessed_amount2_mm_2;
			self.pk_add3_lres_mm_2 := pk_add3_lres_mm_2;
			self.pk_add3_mortgage_risk_mm_2 := pk_add3_mortgage_risk_mm_2;
			self.pk_addrs_15yr_mm_2 := pk_addrs_15yr_mm_2;
			self.pk_addrs_5yr_mm_2 := pk_addrs_5yr_mm_2;
			self.pk_addrs_per_adl_mm_2 := pk_addrs_per_adl_mm_2;
			self.pk_addrs_sourced_lvl_mm_2 := pk_addrs_sourced_lvl_mm_2;
			self.pk_adlperssn_count_mm_2 := pk_adlperssn_count_mm_2;
			self.pk_adls_per_addr_mm_2 := pk_adls_per_addr_mm_2;
			self.pk_adls_per_phone_c6_mm_2 := pk_adls_per_phone_c6_mm_2;
			self.pk_adls_per_phone_mm_2 := pk_adls_per_phone_mm_2;
			self.pk_ams_4yr_college_mm_2 := pk_ams_4yr_college_mm_2;
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
			self.pk_avm_confidence_level_mm_2 := pk_avm_confidence_level_mm_2;
			self.pk_avm_hit_level_mm_2 := pk_avm_hit_level_mm_2;
			self.pk_bk_level_mm_2 := pk_bk_level_mm_2;
			self.pk_combo_dobcount_mm_2 := pk_combo_dobcount_mm_2;
			self.pk_combo_dobcount_nb_mm_2 := pk_combo_dobcount_nb_mm_2;
			self.pk_combo_fnamecount_mm_2 := pk_combo_fnamecount_mm_2;
			self.pk_combo_fnamecount_nb_mm_2 := pk_combo_fnamecount_nb_mm_2;
			self.pk_combo_ssncount_mm_2 := pk_combo_ssncount_mm_2;
			self.pk_dist_a1toa2_mm_2 := pk_dist_a1toa2_mm_2;
			self.pk_dist_a1toa3_mm_2 := pk_dist_a1toa3_mm_2;
			self.pk_em_only_ver_lvl_mm_2 := pk_em_only_ver_lvl_mm_2;
			self.pk_eq_count_mm_2 := pk_eq_count_mm_2;
			self.pk_estimated_income_mm_2 := pk_estimated_income_mm_2;
			self.pk_eviction_level_mm_2 := pk_eviction_level_mm_2;
			self.pk_gong_did_phone_ct_mm_2 := pk_gong_did_phone_ct_mm_2;
			self.pk_gong_did_phone_ct_nb_mm_2 := pk_gong_did_phone_ct_nb_mm_2;
			self.pk_inferred_age_mm_2 := pk_inferred_age_mm_2;
			self.pk_infutor_risk_lvl_mm_2 := pk_infutor_risk_lvl_mm_2;
			self.pk_infutor_risk_lvl_nb_mm_2 := pk_infutor_risk_lvl_nb_mm_2;
			self.pk_lien_type_level_mm_2 := pk_lien_type_level_mm_2;
			self.pk_lname_eda_sourced_type_lvl_mm_2 := pk_lname_eda_sourced_type_lvl_mm_2;
			self.pk_lres_flag_level_mm_2 := pk_lres_flag_level_mm_2;
			self.pk_nap_summary_mm_2 := pk_nap_summary_mm_2;
			self.pk_naprop_level2_mm_2 := pk_naprop_level2_mm_2;
			self.pk_nas_summary_mm_2 := pk_nas_summary_mm_2;
			self.pk_out_st_division_lvl_mm_2 := pk_out_st_division_lvl_mm_2;
			self.pk_phones_per_adl_mm_2 := pk_phones_per_adl_mm_2;
			self.pk_pl_sourced_level_mm_2 := pk_pl_sourced_level_mm_2;
			self.pk_pos_secondary_sources_mm_2 := pk_pos_secondary_sources_mm_2;
			self.pk_pr_count_mm_2 := pk_pr_count_mm_2;
			self.pk_prof_lic_cat_mm_2 := pk_prof_lic_cat_mm_2;
			self.pk_prop_own_assess_tot2_mm_2 := pk_prop_own_assess_tot2_mm_2;
			self.pk_property_owned_total_mm_2 := pk_property_owned_total_mm_2;
			self.pk_rc_addrcount_mm_2 := pk_rc_addrcount_mm_2;
			self.pk_rc_addrcount_nb_mm_2 := pk_rc_addrcount_nb_mm_2;
			self.pk_rc_disthphoneaddr_mm_2 := pk_rc_disthphoneaddr_mm_2;
			self.pk_rc_fnamecount_mm_2 := pk_rc_fnamecount_mm_2;
			self.pk_rc_lnamecount_nb_mm_2 := pk_rc_lnamecount_nb_mm_2;
			self.pk_rc_phonelnamecount_mm_2 := pk_rc_phonelnamecount_mm_2;
			self.pk_rc_phonephonecount_mm_2 := pk_rc_phonephonecount_mm_2;
			self.pk_ssnchar_invalid_or_recent_mm_2 := pk_ssnchar_invalid_or_recent_mm_2;
			self.pk_ssns_per_addr_c6_mm_2 := pk_ssns_per_addr_c6_mm_2;
			self.pk_ssns_per_addr2_mm_2 := pk_ssns_per_addr2_mm_2;
			self.pk_ssns_per_adl_c6_mm_2 := pk_ssns_per_adl_c6_mm_2;
			self.pk_ssns_per_adl_mm_2 := pk_ssns_per_adl_mm_2;
			self.pk_ver_phncount_mm_2 := pk_ver_phncount_mm_2;
			self.pk_voter_flag_mm_2 := pk_voter_flag_mm_2;
			self.pk_wealth_index_mm_2 := pk_wealth_index_mm_2;
			self.pk_yr_add1_date_first_seen2_mm_2 := pk_yr_add1_date_first_seen2_mm_2;
			self.pk_yr_add1_mortgage_date2_mm_2 := pk_yr_add1_mortgage_date2_mm_2;
			self.pk_yr_add1_mortgage_due_date2_mm_2 := pk_yr_add1_mortgage_due_date2_mm_2;
			self.pk_yr_add2_assess_val_yr2_mm_2 := pk_yr_add2_assess_val_yr2_mm_2;
			self.pk_yr_add2_date_first_seen2_mm_2 := pk_yr_add2_date_first_seen2_mm_2;
			self.pk_yr_add2_mortgage_due_date2_mm_2 := pk_yr_add2_mortgage_due_date2_mm_2;
			self.pk_yr_add3_date_first_seen2_mm_2 := pk_yr_add3_date_first_seen2_mm_2;
			self.pk_yr_adl_em_only_first_seen2_mm_2 := pk_yr_adl_em_only_first_seen2_mm_2;
			self.pk_yr_adl_pr_first_seen2_mm_2 := pk_yr_adl_pr_first_seen2_mm_2;
			self.pk_yr_adl_w_first_seen2_mm_2 := pk_yr_adl_w_first_seen2_mm_2;
			self.pk_yr_ams_dob2_mm_2 := pk_yr_ams_dob2_mm_2;
			self.pk_yr_criminal_last_date2_mm_2 := pk_yr_criminal_last_date2_mm_2;
			self.pk_yr_felony_last_date2_mm_2 := pk_yr_felony_last_date2_mm_2;
			self.pk_yr_gong_did_first_seen2_mm_2 := pk_yr_gong_did_first_seen2_mm_2;
			self.pk_yr_header_first_seen2_mm_2 := pk_yr_header_first_seen2_mm_2;
			self.pk_yr_in_dob2_mm_2 := pk_yr_in_dob2_mm_2;
			self.pk_yr_infutor_first_seen2_mm_2 := pk_yr_infutor_first_seen2_mm_2;
			self.pk_yr_liens_last_unrel_date3_mm_2 := pk_yr_liens_last_unrel_date3_mm_2;
			self.pk_yr_lname_change_date2_mm_2 := pk_yr_lname_change_date2_mm_2;
			self.pk_yr_rc_ssnhighissue2_mm_2 := pk_yr_rc_ssnhighissue2_mm_2;
			self.pk_yr_reported_dob2_mm_2 := pk_yr_reported_dob2_mm_2;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm_2 := pk_yrmo_adl_f_sn_mx_fcra2_mm_2;
			self.pk2_add1_avm_auto_mm_2 := pk2_add1_avm_auto_mm_2;
			self.pk2_add1_avm_auto2_mm_2 := pk2_add1_avm_auto2_mm_2;
			self.pk2_add1_avm_auto3_mm_2 := pk2_add1_avm_auto3_mm_2;
			self.pk2_add1_avm_med_mm_2 := pk2_add1_avm_med_mm_2;
			self.pk2_add1_avm_mkt_mm_2 := pk2_add1_avm_mkt_mm_2;
			self.pk2_add1_avm_pi_mm_2 := pk2_add1_avm_pi_mm_2;
			self.pk2_add1_avm_to_med_ratio_mm_2 := pk2_add1_avm_to_med_ratio_mm_2;
			self.pk2_add2_avm_auto_mm_2 := pk2_add2_avm_auto_mm_2;
			self.pk2_add2_avm_auto3_mm_2 := pk2_add2_avm_auto3_mm_2;
			self.pk2_add2_avm_hed_mm_2 := pk2_add2_avm_hed_mm_2;
			self.pk2_add2_avm_pi_mm_2 := pk2_add2_avm_pi_mm_2;
			self.pk2_add2_avm_sp_mm_2 := pk2_add2_avm_sp_mm_2;
			self.pk2_add2_avm_ta_mm_2 := pk2_add2_avm_ta_mm_2;
			self.pk2_yr_add1_avm_assess_year_mm_2 := pk2_yr_add1_avm_assess_year_mm_2;
			self.pk2_yr_add1_avm_rec_dt_mm_2 := pk2_yr_add1_avm_rec_dt_mm_2;
			self.addprob3_mod_dm_b1 := addprob3_mod_dm_b1;
			self.phnprob_mod_dm_b1 := phnprob_mod_dm_b1;
			self.ssnprob2_mod_dm_b1 := ssnprob2_mod_dm_b1;
			self.fp_mod5_dm_b1 := fp_mod5_dm_b1;
			self.age_mod3_dm_b1 := age_mod3_dm_b1;
			self.amstudent_mod_dm_b1 := amstudent_mod_dm_b1;
			self.avm_mod_dm_b1 := avm_mod_dm_b1;
			self.derog_mod3_dm_b1 := derog_mod3_dm_b1;
			self.lien_mod_dm_b1 := lien_mod_dm_b1;
			self.lres_mod_dm_b1 := lres_mod_dm_b1;
			self.property_mod_dm_b1 := property_mod_dm_b1;
			self.velocity2_mod_dm_b1 := velocity2_mod_dm_b1;
			self.ver_best_element_cnt_mod_dm_b1 := ver_best_element_cnt_mod_dm_b1;
			self.ver_best_src_cnt_mod_dm_b1 := ver_best_src_cnt_mod_dm_b1;
			self.ver_best_src_time_mod_dm_b1 := ver_best_src_time_mod_dm_b1;
			self.ver_notbest_element_cnt_mod_dm_b1 := ver_notbest_element_cnt_mod_dm_b1;
			self.ver_notbest_src_cnt_mod_dm_b1 := ver_notbest_src_cnt_mod_dm_b1;
			self.ver_notbest_src_time_mod_dm_b1 := ver_notbest_src_time_mod_dm_b1;
			self.ver_element_cnt_mod_dm_b1 := ver_element_cnt_mod_dm_b1;
			self.ver_src_cnt_mod_dm_b1 := ver_src_cnt_mod_dm_b1;
			self.ver_src_time_mod_dm_b1 := ver_src_time_mod_dm_b1;
			self.mod14_dm_b1 := mod14_dm_b1;
			self.addprob3_mod_om_b2 := addprob3_mod_om_b2;
			self.phnprob_mod_om_b2 := phnprob_mod_om_b2;
			self.ssnprob2_mod_om_b2 := ssnprob2_mod_om_b2;
			self.fp_mod5_om_b2 := fp_mod5_om_b2;
			self.age_mod3_nodob_om_b2 := age_mod3_nodob_om_b2;
			self.age_mod3_om_b2 := age_mod3_om_b2;
			self.avm_mod_om_b2 := avm_mod_om_b2;
			self.property_mod_om_b2 := property_mod_om_b2;
			self.velocity2_mod_om_b2 := velocity2_mod_om_b2;
			self.ver_best_src_cnt_mod_om_b2 := ver_best_src_cnt_mod_om_b2;
			self.ver_best_src_time_mod_om_b2 := ver_best_src_time_mod_om_b2;
			self.ver_notbest_src_cnt_mod_om_b2 := ver_notbest_src_cnt_mod_om_b2;
			self.ver_notbest_src_time_mod_om_b2 := ver_notbest_src_time_mod_om_b2;
			self.ver_src_time_mod_om_b2 := ver_src_time_mod_om_b2;
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
			self.ver_best_src_cnt_mod_rm_b3 := ver_best_src_cnt_mod_rm_b3;
			self.ver_notbest_element_cnt_mod_rm_b3 := ver_notbest_element_cnt_mod_rm_b3;
			self.ver_notbest_src_cnt_mod_rm_b3 := ver_notbest_src_cnt_mod_rm_b3;
			self.ver_element_cnt_mod_rm_b3 := ver_element_cnt_mod_rm_b3;
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
			self.property_mod_xm_b4 := property_mod_xm_b4;
			self.velocity2_mod_xm_b4 := velocity2_mod_xm_b4;
			self.ver_best_element_cnt_mod_xm_b4 := ver_best_element_cnt_mod_xm_b4;
			self.ver_best_src_cnt_mod_xm_b4 := ver_best_src_cnt_mod_xm_b4;
			self.ver_best_src_time_mod_xm_b4 := ver_best_src_time_mod_xm_b4;
			self.ver_notbest_element_cnt_mod_xm_b4 := ver_notbest_element_cnt_mod_xm_b4;
			self.ver_notbest_src_cnt_mod_xm_b4 := ver_notbest_src_cnt_mod_xm_b4;
			self.ver_notbest_src_time_mod_xm_b4 := ver_notbest_src_time_mod_xm_b4;
			self.ver_element_cnt_mod_xm_b4 := ver_element_cnt_mod_xm_b4;
			self.ver_src_time_mod_xm_b4 := ver_src_time_mod_xm_b4;
			self.ver_src_cnt_mod_xm_b4 := ver_src_cnt_mod_xm_b4;
			self.mod14_xm_b4 := mod14_xm_b4;
			self.velocity2_mod_rm := velocity2_mod_rm;
			self.lien_mod_dm := lien_mod_dm;
			self.phat := phat;
			self.addprob3_mod_dm := addprob3_mod_dm;
			self.age_mod3_nodob_xm := age_mod3_nodob_xm;
			self.avm_mod_om := avm_mod_om;
			self.ver_best_src_time_mod_dm := ver_best_src_time_mod_dm;
			self.fp_mod5_dm := fp_mod5_dm;
			self.property_mod_xm := property_mod_xm;
			self.velocity2_mod_dm := velocity2_mod_dm;
			self.age_mod3_dm := age_mod3_dm;
			self.ver_notbest_element_cnt_mod_rm := ver_notbest_element_cnt_mod_rm;
			self.age_mod3_rm := age_mod3_rm;
			self.ver_notbest_src_time_mod_dm := ver_notbest_src_time_mod_dm;
			self.property_mod_rm := property_mod_rm;
			self.addprob3_mod_rm := addprob3_mod_rm;
			self.age_mod3_nodob_om := age_mod3_nodob_om;
			self.velocity2_mod_om := velocity2_mod_om;
			self.ver_element_cnt_mod_rm := ver_element_cnt_mod_rm;
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
			self.avm_mod_dm := avm_mod_dm;
			self.ver_best_src_cnt_mod_rm := ver_best_src_cnt_mod_rm;
			self.ver_element_cnt_mod_xm := ver_element_cnt_mod_xm;
			self.ssnprob2_mod_xm := ssnprob2_mod_xm;
			self.lres_mod_rm := lres_mod_rm;
			self.distance_mod2_rm := distance_mod2_rm;
			self.ver_best_src_cnt_mod_om := ver_best_src_cnt_mod_om;
			self.addprob3_mod_xm := addprob3_mod_xm;
			self.age_mod3_nodob_rm := age_mod3_nodob_rm;
			self.phnprob_mod_rm := phnprob_mod_rm;
			self.ver_src_cnt_mod_dm := ver_src_cnt_mod_dm;
			self.ver_best_element_cnt_mod_rm := ver_best_element_cnt_mod_rm;
			self.ssnprob2_mod_dm := ssnprob2_mod_dm;
			self.derog_mod3_dm := derog_mod3_dm;
			self.ver_src_time_mod_om := ver_src_time_mod_om;
			self.mod14_om := mod14_om;
			self.mod14_xm := mod14_xm;
			self.ver_notbest_src_cnt_mod_om := ver_notbest_src_cnt_mod_om;
			self.ver_notbest_src_cnt_mod_rm := ver_notbest_src_cnt_mod_rm;
			self.fp_mod5_om := fp_mod5_om;
			self.ver_notbest_element_cnt_mod_dm := ver_notbest_element_cnt_mod_dm;
			self.ver_best_src_cnt_mod_dm := ver_best_src_cnt_mod_dm;
			self.ver_src_cnt_mod_xm := ver_src_cnt_mod_xm;
			self.ver_notbest_src_time_mod_xm := ver_notbest_src_time_mod_xm;
			self.addprob3_mod_om := addprob3_mod_om;
			self.fp_mod5_rm := fp_mod5_rm;
			self.ver_notbest_element_cnt_mod_xm := ver_notbest_element_cnt_mod_xm;
			self.amstudent_mod_dm := amstudent_mod_dm;
			self.ver_notbest_src_time_mod_om := ver_notbest_src_time_mod_om;
			self.mod14_rm := mod14_rm;
			self.ver_best_src_time_mod_xm := ver_best_src_time_mod_xm;
			self.ver_src_cnt_mod_om := ver_src_cnt_mod_om;
			self.amstudent_mod_xm := amstudent_mod_xm;
			self.avm_mod_xm := avm_mod_xm;
			self.distance_mod2_xm := distance_mod2_xm;
			self.age_mod3_om := age_mod3_om;
			self.fp_mod5_xm := fp_mod5_xm;
			self.phnprob_mod_dm := phnprob_mod_dm;
			self.ver_src_cnt_mod_rm := ver_src_cnt_mod_rm;
			self.phnprob_mod_xm := phnprob_mod_xm;
			self.mod14_scr := mod14_scr;
			self.ver_best_element_cnt_mod_dm := ver_best_element_cnt_mod_dm;
			self.ver_element_cnt_mod_dm := ver_element_cnt_mod_dm;
			self.lres_mod_dm := lres_mod_dm;
			self.mod14_dm := mod14_dm;
			self.phnprob_mod_om := phnprob_mod_om;
			self.ver_notbest_src_cnt_mod_dm := ver_notbest_src_cnt_mod_dm;
			self.ver_src_time_mod_xm := ver_src_time_mod_xm;
			self.property_mod_om := property_mod_om;
			self.ver_best_element_cnt_mod_xm := ver_best_element_cnt_mod_xm;
			self.ssnprob2_mod_dm_nodob_b1_c2_b1 := ssnprob2_mod_dm_nodob_b1_c2_b1;
			self.fp_mod5_dm_nodob_b1_c2_b1 := fp_mod5_dm_nodob_b1_c2_b1;
			self.mod14_dm_nodob_b1_c2_b1 := mod14_dm_nodob_b1_c2_b1;
			self.ssnprob2_mod_om_nodob_b1_c2_b2 := ssnprob2_mod_om_nodob_b1_c2_b2;
			self.fp_mod5_om_nodob_b1_c2_b2 := fp_mod5_om_nodob_b1_c2_b2;
			self.mod14_om_nodob_b1_c2_b2 := mod14_om_nodob_b1_c2_b2;
			self.ver_best_e_cnt_mod_rm_nodob_b1_c2_b3 := ver_best_e_cnt_mod_rm_nodob_b1_c2_b3;
			self.ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3 := ver_notbest_e_cnt_mod_rm_nodob_b1_c2_b3;
			self.ver_element_cnt_mod_rm_nodob_b1_c2_b3 := ver_element_cnt_mod_rm_nodob_b1_c2_b3;
			self.mod14_rm_nodob_b1_c2_b3 := mod14_rm_nodob_b1_c2_b3;
			self.ver_best_e_cnt_mod_xm_nodob_b1_c2_b4 := ver_best_e_cnt_mod_xm_nodob_b1_c2_b4;
			self.ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4 := ver_notbest_e_cnt_mod_xm_nodob_b1_c2_b4;
			self.ver_element_cnt_mod_xm_nodob_b1_c2_b4 := ver_element_cnt_mod_xm_nodob_b1_c2_b4;
			self.mod14_xm_nodob_b1_c2_b4 := mod14_xm_nodob_b1_c2_b4;
			self.ssnprob2_mod_om_nodob_b1 := ssnprob2_mod_om_nodob_b1;
			self.mod14_om_nodob_b1 := mod14_om_nodob_b1;
			self.mod14_dm_nodob_b1 := mod14_dm_nodob_b1;
			self.ssnprob2_mod_dm_nodob_b1 := ssnprob2_mod_dm_nodob_b1;
			self.mod14_scr_b1 := mod14_scr_b1;
			self.mod14_xm_nodob_b1 := mod14_xm_nodob_b1;
			self.phat_b1 := phat_b1;
			self.ver_best_e_cnt_mod_xm_nodob_b1 := ver_best_e_cnt_mod_xm_nodob_b1;
			self.ver_element_cnt_mod_rm_nodob_b1 := ver_element_cnt_mod_rm_nodob_b1;
			self.fp_mod5_om_nodob_b1 := fp_mod5_om_nodob_b1;
			self.ver_element_cnt_mod_xm_nodob_b1 := ver_element_cnt_mod_xm_nodob_b1;
			self.ver_notbest_e_cnt_mod_rm_nodob_b1 := ver_notbest_e_cnt_mod_rm_nodob_b1;
			self.ver_notbest_e_cnt_mod_xm_nodob_b1 := ver_notbest_e_cnt_mod_xm_nodob_b1;
			self.mod14_rm_nodob_b1 := mod14_rm_nodob_b1;
			self.fp_mod5_dm_nodob_b1 := fp_mod5_dm_nodob_b1;
			self.ver_best_e_cnt_mod_rm_nodob_b1 := ver_best_e_cnt_mod_rm_nodob_b1;
			self.ssnprob2_mod_om_nodob := ssnprob2_mod_om_nodob;
			self.mod14_om_nodob := mod14_om_nodob;
			self.mod14_dm_nodob := mod14_dm_nodob;
			self.ssnprob2_mod_dm_nodob := ssnprob2_mod_dm_nodob;
			self.mod14_scr_2 := mod14_scr_2;
			self.mod14_xm_nodob := mod14_xm_nodob;
			self.phat_2 := phat_2;
			self.ver_best_e_cnt_mod_xm_nodob := ver_best_e_cnt_mod_xm_nodob;
			self.ver_element_cnt_mod_rm_nodob := ver_element_cnt_mod_rm_nodob;
			self.fp_mod5_om_nodob := fp_mod5_om_nodob;
			self.ver_element_cnt_mod_xm_nodob := ver_element_cnt_mod_xm_nodob;
			self.ver_notbest_e_cnt_mod_rm_nodob := ver_notbest_e_cnt_mod_rm_nodob;
			self.ver_notbest_e_cnt_mod_xm_nodob := ver_notbest_e_cnt_mod_xm_nodob;
			self.mod14_rm_nodob := mod14_rm_nodob;
			self.fp_mod5_dm_nodob := fp_mod5_dm_nodob;
			self.ver_best_e_cnt_mod_rm_nodob := ver_best_e_cnt_mod_rm_nodob;
			self.RVB1003 := RVB1003;
			self.ov_ssndead := ov_ssndead;
			self.ov_ssnprior := ov_ssnprior;
			self.ov_criminal_flag := ov_criminal_flag;
			self.ov_corrections := ov_corrections;
			self.ov_impulse := ov_impulse;
			self.rvb1003_2 := rvb1003_2;
			self.scored_222s := scored_222s;
			self.rvb1003_3 := rvb1003_3;
		#else
			self.seq := le.seq;

			inCalif := isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

			self.ri := riskwise.rv3bankcardReasonCodes( le, 4, inCalif, PreScreenOptOut );

			self.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				intformat(rvb1003_3,3,1)
			);
		#end
	end;

	model := project( clam, doModel(left) );
	return model;
end;
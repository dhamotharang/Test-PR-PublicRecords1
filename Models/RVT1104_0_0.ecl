import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

ds_layout := {STRING rc, REAL value};

export RVT1104_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPreScreenOptOut ) := FUNCTION

	RVT_DEBUG := false;

	#if(RVT_DEBUG)
	debug_layout := record
		risk_indicators.Layout_Boca_Shell clam;
		Boolean trueDID;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String NAP_Status;
		Integer did_count;
		Boolean rc_non_us_ssn;
		Integer rc_combo_sec_rangescore;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_ssnvalflag;
		String rc_pwssnvalflag;
		String rc_addrvalflag;
		String rc_dwelltype;
		String rc_bansflag;
		Boolean rc_addrmiskeyflag;
		String rc_hrisksic;
		Integer rc_disthphoneaddr;
		String rc_phonetype;
		String rc_cityzipflag;
		Integer combo_ssnscore;
		Integer combo_dobscore;
		Integer combo_dobcount;
		qstring100 ver_sources;
		qstring200 ver_sources_first_seen;
		qstring200 ver_sources_last_seen;
		qstring100 ver_sources_count;
		Boolean add1_isbestmatch;
		String add1_advo_address_vacancy;
		String add1_advo_seasonal_delivery;
		String add1_advo_dnd;
		String add1_advo_college;
		String add1_advo_mixed_address_usage;
		String add1_avm_land_use;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Boolean add1_applicant_owned;
		Boolean add1_occupant_owned;
		Boolean add1_family_owned;
		Integer add1_naprop;
		String add1_mortgage_type;
		String add1_financing_type;
		String add1_land_use_code;
		Integer property_owned_total;
		Integer property_sold_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Boolean add2_isbestmatch;
		Integer add2_avm_automated_valuation;
		Integer add2_avm_med_fips;
		Integer add2_avm_med_geo11;
		Integer add2_avm_med_geo12;
		Boolean add2_family_owned;
		String add2_mortgage_type;
		Integer add2_date_last_seen;
		Integer addrs_15yr;
		Boolean addrs_prison_history;
		Integer unique_addr_count;
		Integer addr_count_ge3;
		String telcordia_type;
		Integer recent_disconnects;
		String gong_did_first_seen;
		String gong_did_last_seen;
		Integer gong_did_phone_ct;
		Integer gong_did_addr_ct;
		Integer namePerSSN_count;
		Integer header_first_seen;
		Integer ssns_per_adl;
		Integer ssns_per_addr;
		Integer phones_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer addrs_per_ssn_c6;
		Integer ssns_per_addr_c6;
		Integer adls_per_phone_c6;
		Integer vo_addrs_per_adl;
		Integer inq_count12;
		Integer paw_source_count;
		Integer infutor_nap;
		Integer impulse_count;
		Integer email_count;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Integer attr_date_last_eviction;
		Integer attr_num_proflic60;
		Boolean Bankrupt;
		String disposition;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_unrel_sc_ct;
		Integer criminal_count;
		Integer felony_count;
		Integer watercraft_count;
		String ams_class;
		String ams_income_level_code;
		String ams_college_tier;
		Boolean prof_license_flag;
		String prof_license_category;
		String wealth_index;
		String input_dob_match_level;
		Integer inferred_age;
		Integer estimated_income;
		Integer archive_date;
		Integer in_dob2;
		Real yr_in_dob;
		Integer add2_date_last_seen2;
		Real mth_add2_date_last_seen;
		Integer attr_date_last_eviction2;
		Real mth_attr_date_last_eviction;
		Integer header_first_seen2;
		Real mth_header_first_seen;
		Integer gong_did_first_seen2;
		Real mth_gong_did_first_seen;
		Integer gong_did_last_seen2;
		Real mth_gong_did_last_seen;
		Integer ver_src_cnt;
		Integer ver_src_am_pos;
		Boolean ver_src_am;
		Integer ver_src_ba_pos;
		Boolean ver_src_ba;
		Integer ver_src_ds_pos;
		Boolean ver_src_ds;
		Integer ver_src_eq_pos;
		String ver_src_fdate_eq;
		Integer ver_src_fdate_eq2;
		Real mth_ver_src_fdate_eq;
		String ver_src_ldate_eq;
		Integer ver_src_ldate_eq2;
		Real mth_ver_src_ldate_eq;
		Integer ver_src_l2_pos;
		Boolean ver_src_l2;
		Integer ver_src_li_pos;
		Boolean ver_src_li;
		Integer ver_src_p_pos;
		String ver_src_ldate_p;
		Integer ver_src_ldate_p2;
		Real mth_ver_src_ldate_p;
		Integer ver_src_vo_pos;
		Real ver_src_cnt_vo;
		Integer ver_src_w_pos;
		Boolean ver_src_w;
		Integer ver_src_wp_pos;
		String ver_src_fdate_wp;
		Integer ver_src_fdate_wp2;
		Real mth_ver_src_fdate_wp;
		String ver_src_ldate_wp;
		Integer ver_src_ldate_wp2;
		Real mth_ver_src_ldate_wp;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean impulse_flag;
		Boolean attr_derog_flag;
		Boolean lien_flag;
		Boolean attr_eviction_flag;
		Boolean bk_flag;
		Boolean ssn_deceased;
		Integer add1_avm_med;
		Integer add2_avm_med;
		String add1_land_use_code2;
		Integer add_bestmatch_level;
		Integer prop_ownership;
		Boolean ssn_adl_prob;
		Integer dist2_a1toa2;
		Integer dist2_a1toa3;
		Integer dist2_a2toa3;
		Integer distance_max;
		Integer property_owner;
		Integer impulse_count_min2;
		Integer yr_in_dob_int;
		Integer age_estimate;
		Integer bs_attr_derog_flag2;
		Boolean no222score;
		String segment40;
		Boolean no_adls_per_phone;
		Boolean phn_nap_disconnected;
		Boolean phn_notpots;
		Boolean no_gong_did_addr;
		Boolean phn_high_risk;
		Boolean phn_recent_disconnect;
		Boolean phn_invalid;
		Boolean phn_nonus;
		Boolean phn_no_zip_match;
		Boolean ssn_priordob;
		Boolean ssn_improper;
		Boolean lo_combo_ssnscore;
		Boolean add_apt;
		Boolean add_inval;
		Boolean add_zipcitymismatch;
		Integer d_age_estimate;
		Integer d_nap_nas;
		Integer d_rc_disthphoneaddr;
		Integer d_combo_dobcount;
		Integer d_mth_ver_src_fdate_wp;
		Integer d_add1_avm_med_mm;
		Integer d_add1_avm_automated_val;
		Real d_add1_avm_automated_val_cf;
		Integer d_add1_avm_automated_val_cfb;
		Integer d_addr_count_ge3;
		Integer d_gong_did_phone_ct;
		Integer d_nameperssn_count;
		Integer d_mth_header_first_seen;
		Integer d_ssns_per_adl;
		Integer d_ssns_per_adl_c6;
		Integer d_addrs_per_ssn_c6;
		Integer d_vo_addrs_per_adl;
		Integer d_inq_count12;
		Integer d_paw_source_count_ind;
		Integer d_infutor_nap_grp;
		Integer d_ams_college_tier;
		Integer d_estimated_income;
		Integer d_add1_land_use;
		Boolean d_ssn_low_risk;
		Integer d_add1_advo_address_vacancy;
		Integer d_add1_advo_mixed_addr_usage;
		Integer d_prop_ownership;
		Integer d_add1_ownership_level;
		Integer d_watercraft_count_cap2;
		Integer d_attr_total_number_derogs;
		Integer d_mth_attr_date_last_eviction;
		Integer d_disposition;
		Integer d_felony_count_cap2;
		Integer d_liens_unrel_sc_ct_cap2;
		Real d_add1_advo_mixed_addr_usage_cm;
		Real d_add1_avm_automated_val_cfb_cm;
		Real d_addr_count_ge3_cm;
		Real d_addrs_per_ssn_c6_cm;
		Real d_ams_college_tier_cm;
		Real d_combo_dobcount_cm;
		Real d_gong_did_phone_ct_cm;
		Real d_mth_header_first_seen_cm;
		Real d_mth_ver_src_fdate_wp_cm;
		Real d_nap_nas_cm;
		Real d_ssns_per_adl_cm;
		Real d_ssns_per_adl_c6_cm;
		Real d_vo_addrs_per_adl_cm;
		Real d_felony_count_cap2_cm;
		Real d_infutor_nap_grp_cm;
		Real d_liens_unrel_sc_ct_cap2_cm;
		Real d_watercraft_count_cap2_cm;
		Real d_inq_count12_cm;
		Real d_add1_ownership_level_cm;
		Real d_age_estimate_cm;
		Real d_attr_total_number_derogs_cm;
		Real d_disposition_cm;
		Real d_mth_attr_date_last_eviction_cm;
		Real d_prop_ownership_cm;
		Real d_add1_land_use_cm;
		Real d_add1_advo_address_vacancy_cm;
		Real dmod_phn_prob;
		Real dmod_ssn_prob;
		Real dmod_add_prob02;
		Real dmod02;
		Real d_phat;
		Integer y_age_estimate;
		Integer y_nap_nas;
		Integer y_did_count;
		Integer y_ver_src_cnt;
		Integer y_add1_avm_med_mm;
		Integer y_add1_avm_automated_val;
		Real y_add1_avm_automated_val_cf;
		Integer y_add1_avm_automated_val_cfb;
		Integer y_unique_addr_count;
		Integer y_addr_count_ge3;
		Integer y_mth_gong_did_first_seen;
		Integer y_ssns_per_adl;
		Integer y_addrs_per_ssn_c6;
		Integer y_inq_count12;
		Integer y_paw_source_count_ind;
		Integer y_infutor_nap_grp;
		Integer y_email_count;
		Integer y_ams_college_tier;
		String y_wealth_index;
		Real y_add_bestmatch_level;
		Integer y_add1_land_use;
		Integer y_telcordia_type;
		Boolean y_ssn_low_risk;
		Integer y_add1_advo_address_vacancy;
		Integer y_add1_advo_mixed_addr_usage;
		Integer y_mth_ver_src_fdate_eq;
		Integer y_mth_ver_src_ldate_eq;
		Integer y_mth_fdate_x_ldate_eq;
		Integer y_add1_ownership_level;
		Real y_add_bestmatch_level_cm;
		Real y_add1_advo_mixed_addr_usage_cm;
		Real y_add1_avm_automated_val_cfb_cm;
		Real y_addr_count_ge3_cm;
		Real y_addrs_per_ssn_c6_cm;
		Real y_ams_college_tier_cm;
		Real y_mth_fdate_x_ldate_eq_cm;
		Real y_nap_nas_cm;
		Real y_ssns_per_adl_cm;
		Real y_unique_addr_count_cm;
		Real y_wealth_index_cm;
		Real y_infutor_nap_grp_cm;
		Real y_inq_count12_cm;
		Real y_add1_ownership_level_cm;
		Real y_age_estimate_cm;
		Real y_ver_src_cnt_cm;
		Real y_add1_land_use_cm;
		Real y_add1_advo_address_vacancy_cm;
		Real y_did_count_cm;
		Real y_email_count_cm;
		Real y_mth_gong_did_first_seen_cm;
		Real ymod_phn_prob;
		Real ymod_add_prob;
		Real ymod_ssn_prob;
		Real ymod02;
		Real y_phat;
		Integer o_nap_nas;
		Integer o_did_count;
		Integer o_rc_disthphoneaddr;
		Integer o_combo_dobcount;
		Integer o_mth_ver_src_fdate_wp;
		Integer o_mth_ver_src_ldate_wp;
		Integer o_mth_fdate_x_ldate_wp;
		Integer o_add1_avm_med_mm;
		Integer o_add1_avm_automated_val;
		Real o_add1_avm_automated_val_cf;
		Integer o_add1_avm_automated_val_cfb;
		Integer o_addrs_15yr;
		Integer o_nameperssn_count;
		Integer o_ssns_per_adl;
		Integer o_addrs_per_ssn_c6;
		Integer o_vo_addrs_per_adl;
		Integer o_inq_count12;
		Integer o_infutor_nap_grp;
		Integer o_ams_college_tier;
		String o_wealth_index;
		Integer o_prof_license_category;
		Boolean o_ssn_low_risk;
		Integer o_add1_advo_address_vacancy;
		Integer o_advo_low_risk;
		Integer o_add1_advo_mixed_addr_usage;
		Integer o_mth_ver_src_fdate_eq;
		Integer o_mth_ver_src_ldate_eq;
		Integer o_mth_fdate_x_ldate_eq;
		Integer o_prop_ownership;
		Integer o_add1_ownership_level;
		Integer o_add1_financing_type;
		Integer o_watercraft_count_cap2;
		Real o_add1_advo_mixed_addr_usage_cm;
		Real o_add1_avm_automated_val_cfb_cm;
		Real o_add1_financing_type_cm;
		Real o_addrs_15yr_cm;
		Real o_addrs_per_ssn_c6_cm;
		Real o_ams_college_tier_cm;
		Real o_combo_dobcount_cm;
		Real o_mth_fdate_x_ldate_eq_cm;
		Real o_nap_nas_cm;
		Real o_prof_license_category_cm;
		Real o_ssns_per_adl_cm;
		Real o_vo_addrs_per_adl_cm;
		Real o_wealth_index_cm;
		Real o_infutor_nap_grp_cm;
		Real o_watercraft_count_cap2_cm;
		Real o_inq_count12_cm;
		Real o_add1_ownership_level_cm;
		Real o_prop_ownership_cm;
		Real o_advo_low_risk_cm;
		Real o_add1_advo_address_vacancy_cm;
		Real o_did_count_cm;
		Real o_mth_fdate_x_ldate_wp_cm;
		Real omod_phn_prob;
		Real omod_ssn_prob;
		Real omod_add_prob;
		Real omod03;
		Real o_phat;
		Integer x_age_estimate;
		Integer ssn_ms;
		Integer x_nap_nas;
		Integer x_did_count;
		Integer x_rc_combo_sec_rangescore100;
		Integer x_mth_ver_src_fdate_wp;
		Integer x_add1_avm_med_mm;
		Integer x_add1_avm_automated_val;
		Real x_add1_avm_automated_val_cf;
		Integer x_add1_avm_automated_val_cfb;
		Integer x_add1_mortgage_type_risk;
		Integer x_distance_max;
		Integer x_add2_avm_med_mm;
		Integer x_add2_avm_automated_val;
		Real x_add2_avm_automated_val_cf;
		Integer x_add2_avm_automated_val_cfb;
		Integer x_add2_mortgage_type_risk;
		Integer x_mth_add2_date_last_seen;
		Integer x_addrs_15yr;
		Integer x_mth_gong_did_first_seen;
		Integer x_mth_gong_did_last_seen;
		Integer x_gong_did_phone_ct;
		Integer x_ssns_per_adl;
		Integer x_ssns_per_addr;
		Integer x_phones_per_addr;
		Integer x_addrs_per_ssn_c6;
		Integer x_ssns_per_addr_c6;
		Integer x_adls_per_phone_c6;
		Integer x_inq_count12;
		Integer x_infutor_nap_grp;
		Integer x_email_count;
		Integer x_attr_num_proflic60_ind;
		Integer x_ams_class;
		Integer x_ams_income_level_code;
		String x_wealth_index;
		Integer x_input_dob_match_level;
		Integer x_mth_ver_src_ldate_p;
		Real x_ver_src_cnt_vo;
		Integer x_add1_land_use;
		Integer x_telcordia_type;
		Boolean x_ssn_low_risk;
		Integer x_add1_advo_address_vacancy;
		Integer x_add1_advo_mixed_address_usage;
		Real x_age_estimate_cm;
		Real x_nap_nas_cm;
		Real x_did_count_cm;
		Real x_mth_ver_src_fdate_wp_cm;
		Real x_add1_advo_address_vacancy_cm;
		Real x_add1_advo_mixed_addr_usage_cm;
		Real x_add1_avm_automated_val_cfb_cm;
		Real x_add1_mortgage_type_risk_cm;
		Real x_distance_max_cm;
		Real x_add2_mortgage_type_risk_cm;
		Real x_mth_add2_date_last_seen_cm;
		Real x_addrs_15yr_cm;
		Real x_telcordia_type_cm;
		Real x_mth_gong_did_first_seen_cm;
		Real x_mth_gong_did_last_seen_cm;
		Real x_gong_did_phone_ct_cm;
		Real x_ssns_per_adl_cm;
		Real x_ssns_per_addr_cm;
		Real x_phones_per_addr_cm;
		Real x_addrs_per_ssn_c6_cm;
		Real x_ssns_per_addr_c6_cm;
		Real x_adls_per_phone_c6_cm;
		Real x_infutor_nap_grp_cm;
		Real x_email_count_cm;
		Real x_attr_num_proflic60_ind_cm;
		Real x_ams_class_cm;
		Real x_ams_income_level_code_cm;
		Real x_wealth_index_cm;
		Real x_input_dob_match_level_cm;
		Real x_rc_combo_sec_rangescore100_cm;
		Real x_mth_ver_src_ldate_p_cm;
		Real x_add2_avm_automated_val_cfb_cm;
		Real x_ver_src_cnt_vo_cm;
		Real x_inq_count12_cm;
		Real x_add1_land_use_cm;
		Real xmod_phn_prob;
		Real xmod_ssn_prob;
		Real xmod_add_prob;
		Real xmod01;
		Real x_phat;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Integer RVT1104_0_0;
		
		integer segment_d;
		integer segment_y;
		integer segment_o;
		integer segment_x;
		integer glrc9c;
		integer glrc9k;
		integer glrc9l;
		integer glrc9n;
		boolean glrc9a;
		integer glrc9e;
		Boolean glrc9t;
		Boolean glrc9u;
		Boolean glrc9v;
		Boolean glrc3;
		Boolean glrc7;
		integer glrc16;
		Boolean glrc20;
		Boolean glrc25;
		integer glrc26;
		Boolean glrc27;
		Boolean glrc28;
		integer glrc36;
		integer glrc37;
		Boolean glrc49;
		integer glrc74;
		integer glrc79;
		Boolean glrc97;
		Boolean glrc98;
		Boolean glrc99;
		Boolean glrc9d;
		Boolean glrc9g;
		Boolean glrc9h;
		integer glrc9i;
		Boolean glrc9j;
		Boolean glrc9o;
		Boolean glrc9q;
		integer glrc9s;
		Boolean glrcev;
		Boolean glrcmi;
		Boolean glrcms;
		Integer aptflag;
		Integer add1_econval;
		Integer add1_aptval;
		String add1_econcode;
		Integer glrcpv;
		Boolean glrc9m;
		Integer glrc9r;
		Boolean glrc9w;
		Real rcvalue16_1;
		Real rcvalue16_2;
		Real rcvalue16;
		Real rcvalue28_1;
		Real rcvalue28_2;
		Real rcvalue28_3;
		Real rcvalue28;
		Real rcvalue36_1;
		Real rcvalue36_2;
		Real rcvalue36_3;
		Real rcvalue36_4;
		Real rcvalue36_5;
		Real rcvalue36_6;
		Real rcvalue36_7;
		Real rcvalue36_8;
		Real rcvalue36_9;
		Real rcvalue36_10;
		Real rcvalue36_11;
		Real rcvalue36;
		Real rcvalue49_1;
		Real rcvalue49_2;
		Real rcvalue49;
		Real rcvalue79_1;
		Real rcvalue79_2;
		Real rcvalue79;
		Real rcvalue97_1;
		Real rcvalue97_2;
		Real rcvalue97;
		Real rcvalue98_1;
		Real rcvalue98_2;
		Real rcvalue98;
		Real rcvalue99_1;
		Real rcvalue99;
		Real rcvalue9a_1;
		Real rcvalue9a_2;
		Real rcvalue9a_3;
		Real rcvalue9a_4;
		Real rcvalue9a_5;
		Real rcvalue9a_6;
		Real rcvalue9a;
		Real rcvalue9c_1;
		Real rcvalue9c;
		Real rcvalue9d_1;
		Real rcvalue9d_2;
		Real rcvalue9d_3;
		Real rcvalue9d_4;
		Real rcvalue9d_5;
		Real rcvalue9d_6;
		Real rcvalue9d_7;
		Real rcvalue9d_8;
		Real rcvalue9d_9;
		Real rcvalue9d;
		Real rcvalue9e_1;
		Real rcvalue9e;
		Real rcvalue9g_1;
		Real rcvalue9g_2;
		Real rcvalue9g_3;
		Real rcvalue9g_4;
		Real rcvalue9g;
		Real rcvalue9h_1;
		Real rcvalue9h_2;
		Real rcvalue9h;
		Real rcvalue9i_1;
		Real rcvalue9i;
		Real rcvalue9j_1;
		Real rcvalue9j;
		Real rcvalue9k_1;
		Real rcvalue9k_2;
		Real rcvalue9k_3;
		Real rcvalue9k_4;
		Real rcvalue9k_5;
		Real rcvalue9k_6;
		Real rcvalue9k_7;
		Real rcvalue9k;
		Real rcvalue9l_1;
		Real rcvalue9l;
		Real rcvalue9m_1;
		Real rcvalue9m_2;
		Real rcvalue9m_3;
		Real rcvalue9m_4;
		Real rcvalue9m_5;
		Real rcvalue9m_6;
		Real rcvalue9m_7;
		Real rcvalue9m_8;
		Real rcvalue9m;
		Real rcvalue9n_1;
		Real rcvalue9n_2;
		Real rcvalue9n_3;
		Real rcvalue9n;
		Real rcvalue9o_1;
		Real rcvalue9o_2;
		Real rcvalue9o_3;
		Real rcvalue9o;
		Real rcvalue9q_1;
		Real rcvalue9q_2;
		Real rcvalue9q_3;
		Real rcvalue9q_4;
		Real rcvalue9q;
		Real rcvalue9r_1;
		Real rcvalue9r_2;
		Real rcvalue9r_3;
		Real rcvalue9r_4;
		Real rcvalue9r_5;
		Real rcvalue9r_6;
		Real rcvalue9r_7;
		Real rcvalue9r_8;
		Real rcvalue9r_9;
		Real rcvalue9r_10;
		Real rcvalue9r_11;
		Real rcvalue9r_12;
		Real rcvalue9r_13;
		Real rcvalue9r_14;
		Real rcvalue9r_15;
		Real rcvalue9r_16;
		Real rcvalue9r_17;
		Real rcvalue9r;
		Real rcvalue9s_1;
		Real rcvalue9s_2;
		Real rcvalue9s_3;
		Real rcvalue9s;
		Real rcvalue9t_1;
		Real rcvalue9t_2;
		Real rcvalue9t_3;
		Real rcvalue9t_4;
		Real rcvalue9t_5;
		Real rcvalue9t_6;
		Real rcvalue9t_7;
		Real rcvalue9t_8;
		Real rcvalue9t_9;
		Real rcvalue9t_10;
		Real rcvalue9t_11;
		Real rcvalue9t_12;
		Real rcvalue9t_13;
		Real rcvalue9t_14;
		Real rcvalue9t;
		Real rcvalue9u_1;
		Real rcvalue9u_2;
		Real rcvalue9u_3;
		Real rcvalue9u_4;
		Real rcvalue9u_5;
		Real rcvalue9u_6;
		Real rcvalue9u_7;
		Real rcvalue9u_8;
		Real rcvalue9u_9;
		Real rcvalue9u_10;
		Real rcvalue9u_11;
		Real rcvalue9u;
		Real rcvalue9v_1;
		Real rcvalue9v_2;
		Real rcvalue9v_3;
		Real rcvalue9v_4;
		Real rcvalue9v_5;
		Real rcvalue9v_6;
		Real rcvalue9v_7;
		Real rcvalue9v_8;
		Real rcvalue9v_9;
		Real rcvalue9v_10;
		Real rcvalue9v;
		Real rcvalue9w_1;
		Real rcvalue9w_2;
		Real rcvalue9w;
		Real rcvalueev_1;
		Real rcvalueev_2;
		Real rcvalueev;
		Real rcvaluemi_1;
		Real rcvaluemi_2;
		Real rcvaluemi;
		Real rcvaluems_1;
		Real rcvaluems_2;
		Real rcvaluems_3;
		Real rcvaluems_4;
		Real rcvaluems_5;
		Real rcvaluems;
		Real rcvaluepv_1;
		Real rcvaluepv_2;
		Real rcvaluepv_3;
		Real rcvaluepv_4;
		Real rcvaluepv_5;
		Real rcvaluepv;
		string2 rc1;
		string2 rc2;
		string2 rc3;
		string2 rc4;
		string2 rc5;
		real rc1_value;
		real rc2_value;
		real rc3_value;
		real rc4_value;
		real rc5_value;

boolean addrpop;
boolean hphnpop;
boolean dobpop;
integer add2_naprop;
integer add3_naprop;
boolean add2_applicant_owned;
boolean add3_applicant_owned;
boolean add3_family_owned;
unsigned property_ambig_total;
string ssnlength;
string in_zipcode;
integer attr_addrs_last12;
boolean add1_eda_sourced;
unsigned adlperssn_count;
unsigned add1_assessed_total_value;

		models.Layout_ModelOut;

dataset(ds_layout) rc_dataset;
dataset(ds_layout) rcs_top4;
dataset(ds_layout) rcs_9q;
dataset(ds_layout) rcs_9g_9a;
dataset(ds_layout) rcs_override;

	end;
	
	debug_layout doModel( clam le ) := TRANSFORM
	#else
	models.layout_modelout doModel( clam le ) := TRANSFORM
	#end
	

		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		did_count                        := le.iid.didcount;
		rc_non_us_ssn                    := le.iid.non_us_ssn;
		rc_combo_sec_rangescore          := le.iid.combo_sec_rangescore;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_cityzipflag                   := le.iid.cityzipflag;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_dobcount                   := le.iid.combo_dobcount;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
		add1_advo_dnd                    := le.advo_input_addr.dnd_indicator;
		add1_advo_college                := le.advo_input_addr.college_indicator;
		add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		addrs_prison_history             := le.other_address_info.isprison;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		addr_count_ge3                   := le.address_history_summary.addr_count3;
		telcordia_type                   := le.phone_verification.telcordia_type;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		inq_count12                      := le.acc_logs.inquiries.count12;
		paw_source_count                 := le.employment.source_ct;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_num_proflic60               := le.professional_license.proflic_count60;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_class                        := le.student.class;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		estimated_income                 := le.estimated_income;
		ssnlength                        := le.input_validation.ssn_length;
		in_zipcode											 := le.shell_input.in_zipcode;




		NULL := -999999999;

		archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

		sysdate := models.common.sas_date((string)(archive_date));

		in_dob2 := models.common.sas_date((string)(in_dob));

		yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);

		add2_date_last_seen2 := models.common.sas_date((string)(add2_date_last_seen));

		mth_add2_date_last_seen := if(min(sysdate, add2_date_last_seen2) = NULL, NULL, (sysdate - add2_date_last_seen2) / 30.5);

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		mth_attr_date_last_eviction := if(min(sysdate, attr_date_last_eviction2) = NULL, NULL, (sysdate - attr_date_last_eviction2) / 30.5);

		header_first_seen2 := models.common.sas_date((string)(header_first_seen));

		mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

		gong_did_first_seen2 := models.common.sas_date((string)(gong_did_first_seen));

		mth_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

		gong_did_last_seen2 := models.common.sas_date((string)(gong_did_last_seen));

		mth_gong_did_last_seen := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, (sysdate - gong_did_last_seen2) / 30.5);

		ver_src_cnt := models.common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

		ver_src_am_pos := models.common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie');

		ver_src_am := ver_src_am_pos > 0;

		ver_src_ba_pos := models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_eq_pos := models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		ver_src_fdate_eq := if(ver_src_eq_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

		ver_src_fdate_eq2 := models.common.sas_date((string)(ver_src_fdate_eq));

		mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

		ver_src_ldate_eq := if(ver_src_eq_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_eq_pos), '0');

		ver_src_ldate_eq2 := models.common.sas_date((string)(ver_src_ldate_eq));

		mth_ver_src_ldate_eq := if(min(sysdate, ver_src_ldate_eq2) = NULL, NULL, (sysdate - ver_src_ldate_eq2) / 30.5);

		ver_src_l2_pos := models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_li_pos := models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		ver_src_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		ver_src_ldate_p := if(ver_src_p_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_p_pos), '0');

		ver_src_ldate_p2 := models.common.sas_date((string)(ver_src_ldate_p));

		mth_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, (sysdate - ver_src_ldate_p2) / 30.5);

		ver_src_vo_pos := models.common.findw_cpp(ver_sources, 'VO' , ' ,', 'ie');

		ver_src_cnt_vo := if(ver_src_vo_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_vo_pos), 0);

		ver_src_w_pos := models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');

		ver_src_w := ver_src_w_pos > 0;

		ver_src_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

		ver_src_fdate_wp := if(ver_src_wp_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

		ver_src_fdate_wp2 := models.common.sas_date((string)(ver_src_fdate_wp));

		mth_ver_src_fdate_wp := if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, (sysdate - ver_src_fdate_wp2) / 30.5);

		ver_src_ldate_wp := if(ver_src_wp_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_wp_pos), '0');

		ver_src_ldate_wp2 := models.common.sas_date((string)(ver_src_ldate_wp));

		mth_ver_src_ldate_wp := if(min(sysdate, ver_src_ldate_wp2) = NULL, NULL, (sysdate - ver_src_ldate_wp2) / 30.5);

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		impulse_flag := impulse_count > 0;

		attr_derog_flag := attr_total_number_derogs > 0;

		lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		attr_eviction_flag := attr_eviction_count > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		ssn_deceased := rc_decsflag = (string)1 or (integer)ver_src_ds = 1;

		add1_avm_med := map(
			ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
			ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
									  ADD1_AVM_MED_FIPS);

		add2_avm_med := map(
			add2_AVM_MED_GEO12 > 0 => add2_AVM_MED_GEO12,
			add2_AVM_MED_GEO11 > 0 => add2_AVM_MED_GEO11,
									  add2_AVM_MED_FIPS);

		add1_land_use_code2 := (trim(add1_land_use_code, LEFT))[1..2];

		add_bestmatch_level := map(
			add1_isbestmatch => 0,
			add2_isbestmatch => 2,
								1);

		prop_ownership := map(
			property_owned_total = 0 and property_sold_total = 0 => 0,
			property_owned_total = 0 and property_sold_total > 0 => 1,
			property_owned_total > 0 and property_sold_total = 0 => 2,
																	3);

		ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

		dist2_a1toa2 := if(dist_a1toa2 = 9999, -9999, dist_a1toa2);

		dist2_a1toa3 := if(dist_a1toa3 = 9999, -9999, dist_a1toa3);

		dist2_a2toa3 := if(dist_a2toa3 = 9999, -9999, dist_a2toa3);

		distance_max := max(dist2_a1toa2, dist2_a1toa3, dist2_a2toa3);

		property_owner := if(Add1_NaProp = 4 or Property_Owned_Total > 0, 1, 0);

		impulse_count_min2 := min(2, if(impulse_count = NULL, -NULL, impulse_count));

		yr_in_dob_int := truncate(yr_in_dob);

		age_estimate := if(yr_in_dob_int > 0, yr_in_dob_int, inferred_age);

		bs_attr_derog_flag2 := if((integer)attr_derog_flag > 0 or (integer)lien_flag > 0 or (integer)attr_eviction_flag > 0 or impulse_count_min2 > 0 or (integer)bk_flag > 0 or (integer)ssn_deceased > 0, 1, 0);

		no222score := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		segment40 := map(
			(integer)ssn_deceased > 0                                                      => 'X 200  ',
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 'X 222  ',
			bs_attr_derog_flag2 = 1                                                        => '0 Derog',
			age_estimate <= 22                                                             => '1 Young',
			property_owner = 1                                                             => '2 Owner',
																							  '3 Other');

		no_adls_per_phone := adls_per_phone = 0;

		phn_nap_disconnected := trim(nap_status, LEFT, RIGHT) = 'D';

		phn_notpots := trim(telcordia_type, LEFT, RIGHT) != '00';

		no_gong_did_addr := gong_did_addr_ct = 0;

		phn_high_risk := (rc_hriskphoneflag in ['1', '2', '4', '5']) or (trim(rc_hphonetypeflag, LEFT, RIGHT) in ['1', '2', '6', '7', 'A', 'U']);

		phn_recent_disconnect := recent_disconnects > 0;

		phn_invalid := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0;

		phn_nonus := (rc_phonetype in ['3', '4']);

		phn_no_zip_match := rc_phonezipflag = (string)1 or rc_pwphonezipflag = (string)1;

		ssn_ms_1 := (integer)(rc_ssnvalflag = (string)3);

		ssn_priordob := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ssn_improper := rc_ssnvalflag = (string)2;

		lo_combo_ssnscore := combo_ssnscore < 100;

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		add_inval := StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V';

		add_zipcitymismatch := rc_cityzipflag != (string)0;

		d_age_estimate := map(
			age_estimate <= 25 => 9,
			age_estimate <= 30 => 8,
			age_estimate <= 35 => 7,
			age_estimate <= 40 => 6,
			age_estimate <= 45 => 5,
			age_estimate <= 50 => 4,
			age_estimate <= 55 => 3,
			age_estimate <= 60 => 2,
								  1);

		d_nap_nas_c159 := map(
			nap_summary = 0 and (nas_summary in [0, 1, 2, 4, 5, 7])  => 5,
			nap_summary = 1 and (nas_summary in [2, 4, 7, 8])        => 5,
			nap_summary = 4 and nas_summary = 0                      => 5,
			nap_summary = 5 and (nas_summary in [0, 2, 4, 9])        => 5,
			nap_summary = 6 and (nas_summary in [0, 2, 4, 9])        => 5,
			nap_summary = 7 and (nas_summary in [0, 2, 4])           => 5,
			nap_summary = 8 and nas_summary = 0                      => 5,
			nap_summary = 10 and nas_summary = 9                     => 5,
			nap_summary = 11 and (nas_summary in [0, 4, 9])          => 5,
			nap_summary = 0 and (nas_summary in [7, 8, 9])           => 4,
			nap_summary = 1 and (nas_summary in [5, 9, 10])          => 4,
			nap_summary = 2 and nas_summary = 2                      => 4,
			nap_summary = 3 and (nas_summary in [2, 3, 4, 7, 8, 9])  => 4,
			nap_summary = 4 and (nas_summary in [7, 9])              => 4,
			nap_summary = 5 and (nas_summary in [5, 8, 10])          => 4,
			nap_summary = 6 and (nas_summary in [1, 8, 10])          => 4,
			nap_summary = 8 and (nas_summary in [4, 5, 6, 7, 9])     => 4,
			nap_summary = 9 and (nas_summary in [1, 4])              => 4,
			nap_summary = 10 and nas_summary = 0                     => 4,
			nap_summary = 11 and (nas_summary in [5, 6, 7])          => 4,
			nap_summary = 12 and nas_summary = 9                     => 4,
			nap_summary = 0 and (nas_summary in [11, 12])            => 2,
			nap_summary = 3 and (nas_summary in [10])                => 2,
			nap_summary = 4 and (nas_summary in [12])                => 2,
			nap_summary = 5 and (nas_summary in [11, 12])            => 2,
			nap_summary = 6 and (nas_summary in [12])                => 2,
			nap_summary = 7 and (nas_summary in [7, 8, 10, 12])      => 2,
			nap_summary = 8 and (nas_summary in [1])                 => 2,
			nap_summary = 9 and (nas_summary in [0, 10, 11])         => 2,
			nap_summary = 10 and (nas_summary in [1, 3, 10])         => 2,
			nap_summary = 12 and (nas_summary in [3, 4, 5, 10])      => 2,
			nap_summary = 1 and (nas_summary in [11])                => 1,
			nap_summary = 5 and (nas_summary in [1])                 => 1,
			nap_summary = 6 and (nas_summary in [6, 11])             => 1,
			nap_summary = 7 and (nas_summary in [6, 11])             => 1,
			nap_summary = 8 and (nas_summary in [8, 11, 12])         => 1,
			nap_summary = 9 and (nas_summary in [2, 7, 8, 9, 12])    => 1,
			nap_summary = 10 and (nas_summary in [4, 11, 12])        => 1,
			nap_summary = 11 and (nas_summary in [1, 8, 10, 11, 12]) => 1,
			nap_summary = 12 and (nas_summary in [1, 8, 11, 12])     => 1,
																		3);

		d_nap_nas_c160 := map(
			nap_summary = 0 and (nas_summary in [0, 3])       => 5,
			nap_summary = 1 and (nas_summary in [0])          => 5,
			nap_summary = 3 and (nas_summary in [0, 2])       => 5,
			nap_summary = 5 and (nas_summary in [0, 2])       => 5,
			nap_summary = 6 and (nas_summary in [0, 2])       => 5,
			nap_summary = 7 and (nas_summary in [0])          => 5,
			nap_summary = 8 and (nas_summary in [0, 5])       => 5,
			nap_summary = 10 and (nas_summary in [0])         => 5,
			nap_summary = 0 and (nas_summary in [2])          => 4,
			nap_summary = 1 and (nas_summary in [2, 3, 5, 8]) => 4,
			nap_summary = 3 and (nas_summary in [8])          => 4,
			nap_summary = 4 and (nas_summary in [0, 8])       => 4,
			nap_summary = 5 and (nas_summary in [3, 5, 8])    => 4,
			nap_summary = 6 and (nas_summary in [3])          => 4,
			nap_summary = 7 and (nas_summary in [2])          => 4,
			nap_summary = 8 and (nas_summary in [2])          => 4,
			nap_summary = 10 and (nas_summary in [2])         => 4,
			nap_summary = 11 and (nas_summary in [0, 2, 3])   => 4,
			nap_summary = 3 and (nas_summary in [3])          => 2,
			nap_summary = 4 and (nas_summary in [3])          => 2,
			nap_summary = 6 and (nas_summary in [5])          => 2,
			nap_summary = 7 and (nas_summary in [5])          => 2,
			nap_summary = 10 and (nas_summary in [3, 8])      => 2,
			nap_summary = 11 and (nas_summary in [5])         => 2,
			nap_summary = 7 and (nas_summary in [8])          => 1,
			nap_summary = 9 and (nas_summary in [2, 8])       => 1,
			nap_summary = 11 and (nas_summary in [8])         => 1,
			nap_summary = 12 and (nas_summary in [3, 5, 8])   => 1,
																 3);

		d_nap_nas := if(ssn_ms_1 = 0, d_nap_nas_c159, d_nap_nas_c160);

		d_rc_disthphoneaddr := map(
			rc_disthphoneaddr = 0  => 1,
			rc_disthphoneaddr <= 1 => 3,
									  2);

		d_combo_dobcount := map(
			combo_dobcount <= 1 => 4,
			combo_dobcount = 2  => 3,
			combo_dobcount = 3  => 2,
								   1);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_mth_ver_src_fdate_wp := map(
			mth_ver_src_fdate_wp = NULL => 2,
			mth_ver_src_fdate_wp < 12   => 3,
										   1);

		d_add1_avm_med_mm := if(add1_avm_med <= 0, 204870, add1_avm_med);

		d_add1_avm_automated_val := if(add1_avm_automated_valuation <= 0, d_add1_avm_med_mm, add1_avm_automated_valuation);

		d_add1_avm_automated_val_cf := min(300000, if(max((real)50000, d_add1_avm_automated_val) = NULL, -NULL, max((real)50000, d_add1_avm_automated_val)));

		d_add1_avm_automated_val_cfb := 50000 * round(d_add1_avm_automated_val_cf / 50000);

		d_addr_count_ge3 := map(
			addr_count_ge3 < 0 => 4,
			addr_count_ge3 = 0 => 3,
			addr_count_ge3 = 1 => 2,
			addr_count_ge3 = 2 => 1,
								  0);

		d_gong_did_phone_ct := map(
			gong_did_phone_ct = 0  => 2,
			gong_did_phone_ct = 1  => 1,
			gong_did_phone_ct = 2  => 2,
			gong_did_phone_ct <= 4 => 3,
									  4);

		d_nameperssn_count := (integer)(nameperssn_count > 0);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_mth_header_first_seen := map(
			mth_header_first_seen = NULL => 4,
			mth_header_first_seen < 24   => 3,
			mth_header_first_seen < 240  => 2,
											1);

		d_ssns_per_adl := map(
			ssns_per_adl = 0 => 3,
			ssns_per_adl = 1 => 1,
			ssns_per_adl = 2 => 2,
								3);

		d_ssns_per_adl_c6 := map(
			ssns_per_adl_c6 <= 0 => 2,
			ssns_per_adl_c6 <= 1 => 1,
									3);

		d_addrs_per_ssn_c6 := map(
			addrs_per_ssn_c6 <= 0 => 1,
			addrs_per_ssn_c6 <= 1 => 2,
									 3);

		d_vo_addrs_per_adl := map(
			vo_addrs_per_adl <= 0 => 4,
			vo_addrs_per_adl <= 1 => 3,
			vo_addrs_per_adl <= 2 => 2,
									 1);

		d_inq_count12 := map(
			inq_count12 <= 0 => 1,
			inq_count12 <= 1 => 2,
								3);

		d_paw_source_count_ind := (integer)(PAW_Source_count > 0);

		d_infutor_nap_grp := map(
			infutor_nap <= 0 or (infutor_nap in [4, 7]) => 2,
			(infutor_nap in [1, 6])                     => 4,
			(infutor_nap in [9, 11, 12])                => 1,
			infutor_nap = 10                            => 3,
														   2);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_ams_college_tier := map(
			ams_college_tier = ''     => 5,
			(integer1)ams_college_tier <= 0 => 2,
			(integer1)ams_college_tier <= 3 => 1,
			(integer1)ams_college_tier <= 4 => 2,
			(integer1)ams_college_tier <= 5 => 3,
										   4);

		d_estimated_income := if(estimated_income = 0, 30000, min(if(estimated_income = NULL, -NULL, estimated_income), 150000));


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_add1_land_use_c178 := if(add1_avm_land_use = '' or add1_avm_land_use = (string)2, 1, 2);

		d_add1_land_use_c179 := if(add1_avm_land_use = (string)2, 1, 2);

		d_add1_land_use_c180 := if(add1_avm_land_use = (string)2, 1, 2);

		d_add1_land_use := map(
			(add1_land_use_code in ['1002', '1004', '1010', '1114']) => d_add1_land_use_c178,
			(trim(add1_land_use_code2, LEFT, RIGHT) in ['10', ' '])  => d_add1_land_use_c179,
			(add1_land_use_code2 in ['19', '80'])                    => d_add1_land_use_c180,
																		3);

		d_ssn_low_risk := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['4', '5']) or (integer)rc_non_us_ssn = 1;


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_add1_advo_address_vacancy := map(
			add1_advo_address_vacancy = ''        => 2,
			(string)add1_advo_address_vacancy = 'N' => 1,
													   3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_add1_advo_mixed_addr_usage := map(
			add1_advo_mixed_address_usage = ''        => 4,
			(string)add1_advo_mixed_address_usage = 'A' => 1,
			(string)add1_advo_mixed_address_usage = 'B' => 3,
			(string)add1_advo_mixed_address_usage = 'C' => 2,
														   4);

		d_prop_ownership := map(
			prop_ownership <= 0 => 4,
			prop_ownership <= 1 => 3,
			prop_ownership <= 2 => 2,
								   1);

		d_add1_ownership_level := map(
			(integer)add1_applicant_owned = 1 => 1,
			(integer)add1_family_owned = 1    => 2,
			(integer)add1_occupant_owned = 1  => 3,
												 4);

		d_watercraft_count_cap2 := min(2, if(watercraft_count = NULL, -NULL, watercraft_count));

		d_attr_total_number_derogs := min(5, if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs));


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		d_mth_attr_date_last_eviction := map(
			mth_attr_date_last_eviction = NULL => 1,
			mth_attr_date_last_eviction < 6    => 5,
			mth_attr_date_last_eviction < 36   => 4,
			mth_attr_date_last_eviction < 60   => 3,
												  2);

		d_disposition := map(
			disposition = 'Discharged' => 1,
			disposition = 'Dismissed'  => 3,
										  2);

		d_felony_count_cap2 := min(2, if(felony_count = NULL, -NULL, felony_count));

		d_liens_unrel_sc_ct_cap2 := min(2, if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct));

		d_add1_advo_mixed_addr_usage_cm := map(
			d_add1_advo_mixed_addr_usage = 1 => 0.2869118277,
			d_add1_advo_mixed_addr_usage = 2 => 0.3492706645,
			d_add1_advo_mixed_addr_usage = 3 => 0.3363222698,
			d_add1_advo_mixed_addr_usage = 4 => 0.3758359873,
												0.341479513);

		d_add1_avm_automated_val_cfb_cm := map(
			d_add1_avm_automated_val_cfb = 50000  => 0.4558087827,
			d_add1_avm_automated_val_cfb = 100000 => 0.3597511807,
			d_add1_avm_automated_val_cfb = 150000 => 0.3501041667,
			d_add1_avm_automated_val_cfb = 200000 => 0.3436241611,
			d_add1_avm_automated_val_cfb = 250000 => 0.3103833271,
			d_add1_avm_automated_val_cfb = 300000 => 0.2851817335,
													 0.341479513);

		d_addr_count_ge3_cm := map(
			d_addr_count_ge3 = 0 => 0.2879899595,
			d_addr_count_ge3 = 1 => 0.3250222618,
			d_addr_count_ge3 = 2 => 0.3699258968,
			d_addr_count_ge3 = 3 => 0.4517622845,
			d_addr_count_ge3 = 4 => 0.4497206704,
									0.341479513);

		d_addrs_per_ssn_c6_cm := map(
			d_addrs_per_ssn_c6 = 1 => 0.3156453689,
			d_addrs_per_ssn_c6 = 2 => 0.4778749159,
			d_addrs_per_ssn_c6 = 3 => 0.5505430242,
									  0.341479513);

		d_ams_college_tier_cm := map(
			d_ams_college_tier = 1 => 0.1790780142,
			d_ams_college_tier = 2 => 0.2424242424,
			d_ams_college_tier = 3 => 0.3154574132,
			d_ams_college_tier = 4 => 0.2837465565,
			d_ams_college_tier = 5 => 0.3454835899,
									  0.341479513);

		d_combo_dobcount_cm := map(
			d_combo_dobcount = 1 => 0.275321316,
			d_combo_dobcount = 2 => 0.3470901483,
			d_combo_dobcount = 3 => 0.4004417797,
			d_combo_dobcount = 4 => 0.3578518015,
									0.341479513);

		d_gong_did_phone_ct_cm := map(
			d_gong_did_phone_ct = 1 => 0.323699747,
			d_gong_did_phone_ct = 2 => 0.3407111871,
			d_gong_did_phone_ct = 3 => 0.3730036855,
			d_gong_did_phone_ct = 4 => 0.4212389381,
									   0.341479513);

		d_mth_header_first_seen_cm := map(
			d_mth_header_first_seen = 1 => 0.2594951207,
			d_mth_header_first_seen = 2 => 0.3884288113,
			d_mth_header_first_seen = 3 => 0.5973741794,
			d_mth_header_first_seen = 4 => 0.4933333333,
										   0.341479513);

		d_mth_ver_src_fdate_wp_cm := map(
			d_mth_ver_src_fdate_wp = 1 => 0.2877382358,
			d_mth_ver_src_fdate_wp = 2 => 0.3623003368,
			d_mth_ver_src_fdate_wp = 3 => 0.4051782112,
										  0.341479513);

		d_nap_nas_cm := map(
			d_nap_nas = 1 => 0.2416530469,
			d_nap_nas = 2 => 0.3030995106,
			d_nap_nas = 3 => 0.3617424242,
			d_nap_nas = 4 => 0.3893816313,
			d_nap_nas = 5 => 0.5019633508,
							 0.341479513);

		d_ssns_per_adl_cm := map(
			d_ssns_per_adl = 1 => 0.321800554,
			d_ssns_per_adl = 2 => 0.3546857257,
			d_ssns_per_adl = 3 => 0.4203322055,
								  0.341479513);

		d_ssns_per_adl_c6_cm := map(
			d_ssns_per_adl_c6 = 1 => 0.346757634,
			d_ssns_per_adl_c6 = 2 => 0.3286073015,
			d_ssns_per_adl_c6 = 3 => 0.4578313253,
									 0.341479513);

		d_vo_addrs_per_adl_cm := map(
			d_vo_addrs_per_adl = 1 => 0.3068783069,
			d_vo_addrs_per_adl = 2 => 0.3198083067,
			d_vo_addrs_per_adl = 3 => 0.3144704931,
			d_vo_addrs_per_adl = 4 => 0.3576220282,
									  0.341479513);

		d_felony_count_cap2_cm := map(
			d_felony_count_cap2 = 0 => 0.3318632255,
			d_felony_count_cap2 = 1 => 0.5423330198,
			d_felony_count_cap2 = 2 => 0.6361031519,
									   0.341479513);

		d_infutor_nap_grp_cm := map(
			d_infutor_nap_grp = 1 => 0.2807212205,
			d_infutor_nap_grp = 2 => 0.3289912318,
			d_infutor_nap_grp = 3 => 0.3475609756,
			d_infutor_nap_grp = 4 => 0.4425988804,
									 0.341479513);

		d_liens_unrel_sc_ct_cap2_cm := map(
			d_liens_unrel_sc_ct_cap2 = 0 => 0.3294751115,
			d_liens_unrel_sc_ct_cap2 = 1 => 0.4203179527,
			d_liens_unrel_sc_ct_cap2 = 2 => 0.4751308901,
											0.341479513);

		d_watercraft_count_cap2_cm := map(
			d_watercraft_count_cap2 = 0 => 0.3445108435,
			d_watercraft_count_cap2 = 1 => 0.2036809816,
			d_watercraft_count_cap2 = 2 => 0.1808219178,
										   0.341479513);

		d_inq_count12_cm := map(
			d_inq_count12 = 1 => 0.3198125468,
			d_inq_count12 = 2 => 0.4815789474,
			d_inq_count12 = 3 => 0.5835037491,
								 0.341479513);

		d_add1_ownership_level_cm := map(
			d_add1_ownership_level = 1 => 0.1680381117,
			d_add1_ownership_level = 2 => 0.3003508772,
			d_add1_ownership_level = 3 => 0.3647305553,
			d_add1_ownership_level = 4 => 0.3838933951,
										  0.341479513);

		d_age_estimate_cm := map(
			d_age_estimate = 1 => 0.2126298961,
			d_age_estimate = 2 => 0.2397205052,
			d_age_estimate = 3 => 0.2629906542,
			d_age_estimate = 4 => 0.2963862305,
			d_age_estimate = 5 => 0.3211856171,
			d_age_estimate = 6 => 0.34364342,
			d_age_estimate = 7 => 0.3902501276,
			d_age_estimate = 8 => 0.4364031907,
			d_age_estimate = 9 => 0.5146094216,
								  0.341479513);

		d_attr_total_number_derogs_cm := map(
			d_attr_total_number_derogs = 0 => 0.2563069866,
			d_attr_total_number_derogs = 1 => 0.3321636894,
			d_attr_total_number_derogs = 2 => 0.410295858,
			d_attr_total_number_derogs = 3 => 0.4414698163,
			d_attr_total_number_derogs = 4 => 0.4595375723,
			d_attr_total_number_derogs = 5 => 0.493559719,
											  0.341479513);

		d_disposition_cm := map(
			d_disposition = 1 => 0.2375826997,
			d_disposition = 2 => 0.3613748742,
			d_disposition = 3 => 0.4235632184,
								 0.341479513);

		d_mth_attr_date_last_eviction_cm := map(
			d_mth_attr_date_last_eviction = 1 => 0.3031702128,
			d_mth_attr_date_last_eviction = 2 => 0.4449636552,
			d_mth_attr_date_last_eviction = 3 => 0.4740683826,
			d_mth_attr_date_last_eviction = 4 => 0.5401296669,
			d_mth_attr_date_last_eviction = 5 => 0.5754296626,
												 0.341479513);

		d_prop_ownership_cm := map(
			d_prop_ownership = 1 => 0.1728367529,
			d_prop_ownership = 2 => 0.2280874234,
			d_prop_ownership = 3 => 0.2703117016,
			d_prop_ownership = 4 => 0.4119659546,
									0.341479513);

		d_add1_land_use_cm := map(
			d_add1_land_use = 1 => 0.2735404896,
			d_add1_land_use = 2 => 0.340412923,
			d_add1_land_use = 3 => 0.4052245938,
								   0.341479513);

		d_add1_advo_address_vacancy_cm := map(
			d_add1_advo_address_vacancy = 1 => 0.325352274,
			d_add1_advo_address_vacancy = 2 => 0.3794124907,
			d_add1_advo_address_vacancy = 3 => 0.4783098592,
											   0.341479513);

		dmod_phn_prob := -0.958711993 +
			(integer)phn_nap_disconnected * 0.1459274965 +
			(integer)phn_notpots * 0.2067140186 +
			(integer)phn_recent_disconnect * -0.343887438 +
			(integer)phn_nonus * 0.5413535885 +
			(integer)phn_no_zip_match * 0.2267286606 +
			d_rc_disthphoneaddr * 0.1058501443;

		dmod_ssn_prob := -0.6551 +
			(integer)ssn_priordob * 0.6125 +
			(integer)d_ssn_low_risk * -0.4079 +
			ssn_ms_1 * 0.1343;

		dmod_add_prob02 := -4.174779183 +
			(integer)add_apt * 0.1614995388 +
			(integer)add_inval * -0.219155605 +
			d_add1_advo_address_vacancy_cm * 3.2845559152 +
			(integer)addrs_prison_history * 0.8288095349 +
			d_add1_land_use_cm * 3.6427994372 +
			(integer)rc_addrmiskeyflag * 0.1803108262 +
			d_add1_advo_mixed_addr_usage_cm * 3.2411040212;

		dmod02 := -16.85785587 +
			(integer)impulse_flag * 0.244835559 +
			d_prop_ownership_cm * 1.4012884681 +
			d_mth_attr_date_last_eviction_cm * 1.5899937521 +
			d_age_estimate_cm * 1.2303095152 +
			d_inq_count12_cm * 2.6411221641 +
			d_addrs_per_ssn_c6_cm * 2.4911461811 +
			d_infutor_nap_grp_cm * 2.7236724249 +
			d_add1_avm_automated_val_cfb_cm * 3.1666044956 +
			d_disposition_cm * 3.5438700951 +
			d_attr_total_number_derogs_cm * 1.9245774707 +
			dmod_add_prob02 * 0.5037801871 +
			d_nap_nas_cm * 1.4442102527 +
			d_ssns_per_adl_cm * 3.4798541737 +
			d_combo_dobcount_cm * 1.8331144589 +
			d_ams_college_tier_cm * 4.9986664889 +
			d_estimated_income * -4.103631E-6 +
			d_felony_count_cap2_cm * 1.6664801337 +
			d_mth_header_first_seen_cm * 1.1409773201 +
			dmod_ssn_prob * 0.5648789717 +
			d_add1_ownership_level_cm * 0.9457615579 +
			d_nameperssn_count * 0.2162471363 +
			d_addr_count_ge3_cm * 1.0084941152 +
			d_ssns_per_adl_c6_cm * 2.7063136962 +
			d_gong_did_phone_ct_cm * 3.3060695282 +
			dmod_phn_prob * 0.2300006999 +
			d_vo_addrs_per_adl_cm * 2.4540011992 +
			d_paw_source_count_ind * -0.157470809 +
			d_mth_ver_src_fdate_wp_cm * 1.2910463792 +
			d_liens_unrel_sc_ct_cap2_cm * 1.4024339759 +
			d_watercraft_count_cap2_cm * 1.7221737197;

		d_phat := exp(dmod02) / (1 + exp(dmod02));

		y_age_estimate := map(
			age_estimate <= 16 => 0,
			age_estimate <= 18 => 5,
			age_estimate <= 19 => 4,
			age_estimate <= 20 => 3,
			age_estimate <= 21 => 2,
			age_estimate <= 22 => 1,
								  0);

		y_nap_nas_c215 := map(
			nap_summary = 0 and nas_summary = 0   => 8,
			nap_summary = 0 and nas_summary = 1   => 7,
			nap_summary = 0 and nas_summary = 2   => 7,
			nap_summary = 0 and nas_summary = 3   => 4,
			nap_summary = 0 and nas_summary = 4   => 8,
			nap_summary = 0 and nas_summary = 5   => 7,
			nap_summary = 0 and nas_summary = 6   => 4,
			nap_summary = 0 and nas_summary = 7   => 8,
			nap_summary = 0 and nas_summary = 8   => 3,
			nap_summary = 0 and nas_summary = 9   => 5,
			nap_summary = 0 and nas_summary = 10  => 3,
			nap_summary = 0 and nas_summary = 11  => 3,
			nap_summary = 0 and nas_summary = 12  => 3,
			nap_summary = 1 and nas_summary = 0   => 7,
			nap_summary = 1 and nas_summary = 1   => 7,
			nap_summary = 1 and nas_summary = 2   => 8,
			nap_summary = 1 and nas_summary = 3   => 7,
			nap_summary = 1 and nas_summary = 4   => 8,
			nap_summary = 1 and nas_summary = 6   => 7,
			nap_summary = 1 and nas_summary = 7   => 7,
			nap_summary = 1 and nas_summary = 8   => 7,
			nap_summary = 1 and nas_summary = 9   => 4,
			nap_summary = 1 and nas_summary = 10  => 6,
			nap_summary = 1 and nas_summary = 11  => 2,
			nap_summary = 1 and nas_summary = 12  => 4,
			nap_summary = 3 and nas_summary = 0   => 6,
			nap_summary = 3 and nas_summary = 2   => 7,
			nap_summary = 3 and nas_summary = 3   => 7,
			nap_summary = 3 and nas_summary = 4   => 5,
			nap_summary = 3 and nas_summary = 8   => 6,
			nap_summary = 3 and nas_summary = 9   => 6,
			nap_summary = 3 and nas_summary = 10  => 2,
			nap_summary = 3 and nas_summary = 12  => 3,
			nap_summary = 4 and nas_summary = 2   => 5,
			nap_summary = 4 and nas_summary = 3   => 5,
			nap_summary = 4 and nas_summary = 4   => 5,
			nap_summary = 4 and nas_summary = 6   => 5,
			nap_summary = 4 and nas_summary = 8   => 5,
			nap_summary = 4 and nas_summary = 9   => 5,
			nap_summary = 4 and nas_summary = 10  => 4,
			nap_summary = 4 and nas_summary = 12  => 3,
			nap_summary = 5 and nas_summary = 0   => 7,
			nap_summary = 5 and nas_summary = 2   => 7,
			nap_summary = 5 and nas_summary = 4   => 7,
			nap_summary = 5 and nas_summary = 6   => 4,
			nap_summary = 5 and nas_summary = 7   => 4,
			nap_summary = 5 and nas_summary = 8   => 7,
			nap_summary = 5 and nas_summary = 9   => 7,
			nap_summary = 5 and nas_summary = 10  => 7,
			nap_summary = 5 and nas_summary = 11  => 3,
			nap_summary = 5 and nas_summary = 12  => 3,
			nap_summary = 6 and nas_summary = 0   => 7,
			nap_summary = 6 and nas_summary = 1   => 4,
			nap_summary = 6 and nas_summary = 2   => 7,
			nap_summary = 6 and nas_summary = 3   => 4,
			nap_summary = 6 and nas_summary = 4   => 7,
			nap_summary = 6 and nas_summary = 5   => 4,
			nap_summary = 6 and nas_summary = 6   => 7,
			nap_summary = 6 and nas_summary = 7   => 4,
			nap_summary = 6 and nas_summary = 8   => 7,
			nap_summary = 6 and nas_summary = 9   => 8,
			nap_summary = 6 and nas_summary = 10  => 8,
			nap_summary = 6 and nas_summary = 11  => 2,
			nap_summary = 6 and nas_summary = 12  => 3,
			nap_summary = 7 and nas_summary = 0   => 6,
			nap_summary = 7 and nas_summary = 2   => 6,
			nap_summary = 7 and nas_summary = 4   => 6,
			nap_summary = 7 and nas_summary = 6   => 1,
			nap_summary = 7 and nas_summary = 7   => 2,
			nap_summary = 7 and nas_summary = 8   => 2,
			nap_summary = 7 and nas_summary = 9   => 6,
			nap_summary = 7 and nas_summary = 10  => 2,
			nap_summary = 7 and nas_summary = 11  => 2,
			nap_summary = 7 and nas_summary = 12  => 2,
			nap_summary = 8 and nas_summary = 0   => 6,
			nap_summary = 8 and nas_summary = 2   => 4,
			nap_summary = 8 and nas_summary = 4   => 6,
			nap_summary = 8 and nas_summary = 6   => 6,
			nap_summary = 8 and nas_summary = 7   => 6,
			nap_summary = 8 and nas_summary = 8   => 1,
			nap_summary = 8 and nas_summary = 9   => 6,
			nap_summary = 8 and nas_summary = 10  => 4,
			nap_summary = 8 and nas_summary = 11  => 2,
			nap_summary = 8 and nas_summary = 12  => 2,
			nap_summary = 9 and nas_summary = 0   => 2,
			nap_summary = 9 and nas_summary = 2   => 1,
			nap_summary = 9 and nas_summary = 4   => 5,
			nap_summary = 9 and nas_summary = 5   => 4,
			nap_summary = 9 and nas_summary = 7   => 2,
			nap_summary = 9 and nas_summary = 8   => 1,
			nap_summary = 9 and nas_summary = 9   => 3,
			nap_summary = 9 and nas_summary = 10  => 2,
			nap_summary = 9 and nas_summary = 11  => 2,
			nap_summary = 9 and nas_summary = 12  => 1,
			nap_summary = 10 and nas_summary = 3  => 3,
			nap_summary = 10 and nas_summary = 4  => 2,
			nap_summary = 10 and nas_summary = 7  => 6,
			nap_summary = 10 and nas_summary = 8  => 6,
			nap_summary = 10 and nas_summary = 9  => 6,
			nap_summary = 10 and nas_summary = 10 => 3,
			nap_summary = 10 and nas_summary = 12 => 1,
			nap_summary = 11 and nas_summary = 0  => 6,
			nap_summary = 11 and nas_summary = 2  => 7,
			nap_summary = 11 and nas_summary = 4  => 6,
			nap_summary = 11 and nas_summary = 7  => 5,
			nap_summary = 11 and nas_summary = 8  => 1,
			nap_summary = 11 and nas_summary = 9  => 8,
			nap_summary = 11 and nas_summary = 10 => 1,
			nap_summary = 11 and nas_summary = 11 => 2,
			nap_summary = 11 and nas_summary = 12 => 2,
			nap_summary = 12 and nas_summary = 0  => 7,
			nap_summary = 12 and nas_summary = 2  => 4,
			nap_summary = 12 and nas_summary = 4  => 3,
			nap_summary = 12 and nas_summary = 5  => 2,
			nap_summary = 12 and nas_summary = 8  => 1,
			nap_summary = 12 and nas_summary = 9  => 3,
			nap_summary = 12 and nas_summary = 10 => 2,
			nap_summary = 12 and nas_summary = 11 => 1,
			nap_summary = 12 and nas_summary = 12 => 1,
													 3);

		y_nap_nas_c216 := map(
			nap_summary = 0 and nas_summary = 0  => 7,
			nap_summary = 0 and nas_summary = 2  => 5,
			nap_summary = 0 and nas_summary = 3  => 7,
			nap_summary = 0 and nas_summary = 5  => 5,
			nap_summary = 0 and nas_summary = 8  => 4,
			nap_summary = 1 and nas_summary = 0  => 7,
			nap_summary = 1 and nas_summary = 2  => 6,
			nap_summary = 1 and nas_summary = 3  => 6,
			nap_summary = 1 and nas_summary = 8  => 6,
			nap_summary = 3 and nas_summary = 2  => 7,
			nap_summary = 3 and nas_summary = 8  => 5,
			nap_summary = 4 and nas_summary = 0  => 5,
			nap_summary = 4 and nas_summary = 2  => 5,
			nap_summary = 4 and nas_summary = 8  => 5,
			nap_summary = 5 and nas_summary = 0  => 7,
			nap_summary = 5 and nas_summary = 2  => 7,
			nap_summary = 5 and nas_summary = 3  => 7,
			nap_summary = 5 and nas_summary = 5  => 7,
			nap_summary = 5 and nas_summary = 8  => 3,
			nap_summary = 6 and nas_summary = 0  => 7,
			nap_summary = 6 and nas_summary = 2  => 8,
			nap_summary = 6 and nas_summary = 3  => 7,
			nap_summary = 6 and nas_summary = 5  => 3,
			nap_summary = 6 and nas_summary = 8  => 3,
			nap_summary = 7 and nas_summary = 0  => 7,
			nap_summary = 7 and nas_summary = 2  => 5,
			nap_summary = 7 and nas_summary = 3  => 4,
			nap_summary = 7 and nas_summary = 8  => 1,
			nap_summary = 8 and nas_summary = 2  => 4,
			nap_summary = 8 and nas_summary = 8  => 3,
			nap_summary = 9 and nas_summary = 0  => 4,
			nap_summary = 9 and nas_summary = 2  => 2,
			nap_summary = 9 and nas_summary = 5  => 4,
			nap_summary = 9 and nas_summary = 8  => 1,
			nap_summary = 10 and nas_summary = 2 => 5,
			nap_summary = 10 and nas_summary = 3 => 2,
			nap_summary = 10 and nas_summary = 8 => 3,
			nap_summary = 11 and nas_summary = 0 => 5,
			nap_summary = 11 and nas_summary = 2 => 5,
			nap_summary = 11 and nas_summary = 5 => 3,
			nap_summary = 11 and nas_summary = 8 => 1,
			nap_summary = 12 and nas_summary = 0 => 7,
			nap_summary = 12 and nas_summary = 2 => 7,
			nap_summary = 12 and nas_summary = 8 => 1,
													4);

		y_nap_nas := if(ssn_ms_1 = 0, y_nap_nas_c215, y_nap_nas_c216);

		y_did_count := map(
			did_count = 0 => 1,
			did_count = 1 => 3,
							 2);

		y_ver_src_cnt := max(1, min(8, if(ver_src_cnt = NULL, -NULL, ver_src_cnt)));

		y_add1_avm_med_mm := if(add1_avm_med <= 0, 176194, add1_avm_med);

		y_add1_avm_automated_val := if(add1_avm_automated_valuation <= 0, y_add1_avm_med_mm, add1_avm_automated_valuation);

		y_add1_avm_automated_val_cf := min(300000, if(max((real)50000, y_add1_avm_automated_val) = NULL, -NULL, max((real)50000, y_add1_avm_automated_val)));

		y_add1_avm_automated_val_cfb := 50000 * round(y_add1_avm_automated_val_cf / 50000);

		y_unique_addr_count := min(6, if(unique_addr_count = NULL, -NULL, unique_addr_count));

		y_addr_count_ge3 := map(
			addr_count_ge3 < 0 => 4,
			addr_count_ge3 = 0 => 5,
			addr_count_ge3 = 1 => 3,
			addr_count_ge3 = 2 => 2,
								  1);

		y_mth_gong_did_first_seen := map(
			mth_gong_did_first_seen <= 0 => 1,
			mth_gong_did_first_seen < 6  => 4,
			mth_gong_did_first_seen < 24 => 3,
											2);

		y_ssns_per_adl := map(
			ssns_per_adl = 0 => 1,
			ssns_per_adl = 1 => 1,
			ssns_per_adl = 2 => 2,
								3);

		y_addrs_per_ssn_c6 := map(
			addrs_per_ssn_c6 <= 0 => 1,
			addrs_per_ssn_c6 <= 1 => 2,
									 3);

		y_inq_count12 := map(
			inq_count12 <= 0 => 1,
			inq_count12 <= 1 => 2,
								3);

		y_paw_source_count_ind := (integer)(PAW_Source_count > 0);

		y_infutor_nap_grp := map(
			infutor_nap <= 0         => 5,
			infutor_nap <= 1         => 7,
			(infutor_nap in [4, 12]) => 3,
			infutor_nap = 6          => 8,
			infutor_nap = 7          => 2,
			infutor_nap = 9          => 1,
			infutor_nap = 10         => 6,
			infutor_nap = 11         => 4,
										5);

		y_email_count := map(
			email_count <= 0 => 1,
			email_count <= 1 => 2,
			email_count <= 2 => 3,
								4);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_ams_college_tier := map(
			ams_college_tier = ''     => 6,
			(integer1)ams_college_tier <= 0 => 3,
			(integer1)ams_college_tier <= 3 => 1,
			(integer1)ams_college_tier <= 4 => 2,
			(integer1)ams_college_tier <= 5 => 4,
										   5);

		y_wealth_index := wealth_index;

		y_add_bestmatch_level := map(
			add_bestmatch_level <= 0 => 1,
			add_bestmatch_level <= 1 => 3,
			add_bestmatch_level <= 2 => 2,
										1.5);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_add1_land_use_c230 := if(add1_avm_land_use = '' or add1_avm_land_use = (string)2, 1, 2);

		y_add1_land_use_c231 := if(add1_avm_land_use = (string)2, 1, 2);

		y_add1_land_use_c232 := if(add1_avm_land_use = (string)2, 1, 2);

		y_add1_land_use := map(
			(add1_land_use_code in ['1002', '1004', '1010', '1114']) => y_add1_land_use_c230,
			(trim(add1_land_use_code2, LEFT, RIGHT) in ['10', ' '])  => y_add1_land_use_c231,
			(add1_land_use_code2 in ['19', '80'])                    => y_add1_land_use_c232,
																		3);

		y_telcordia_type := if((trim(telcordia_type, LEFT, RIGHT) in ['04', '65']), 1, 2);

		y_ssn_low_risk := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['4', '5']) or (integer)rc_non_us_ssn = 1;


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_add1_advo_address_vacancy := map(
			add1_advo_address_vacancy = ''        => 2,
			(string)add1_advo_address_vacancy = 'N' => 1,
													   3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_add1_advo_mixed_addr_usage := map(
			add1_advo_mixed_address_usage = ''        => 4,
			(string)add1_advo_mixed_address_usage = 'A' => 1,
			(string)add1_advo_mixed_address_usage = 'B' => 3,
			(string)add1_advo_mixed_address_usage = 'C' => 2,
														   4);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_mth_ver_src_fdate_eq := map(
			mth_ver_src_fdate_eq = NULL => 3,
			mth_ver_src_fdate_eq < 12   => 4,
			mth_ver_src_fdate_eq < 24   => 3,
			mth_ver_src_fdate_eq < 36   => 2,
			mth_ver_src_fdate_eq < 60   => 1,
			mth_ver_src_fdate_eq < 120  => 5,
										   6);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		y_mth_ver_src_ldate_eq := map(
			mth_ver_src_ldate_eq = NULL => 2,
			mth_ver_src_ldate_eq <= 0   => 2,
			mth_ver_src_ldate_eq < 6    => 1,
										   3);

		y_mth_fdate_x_ldate_eq_c239 := map(
			y_mth_ver_src_fdate_eq = 1            => 1,
			(y_mth_ver_src_fdate_eq in [2, 3, 4]) => 2,
			y_mth_ver_src_fdate_eq = 5            => 5,
													 6);

		y_mth_fdate_x_ldate_eq_c240 := map(
			y_mth_ver_src_fdate_eq = 1         => 1,
			(y_mth_ver_src_fdate_eq in [2, 3]) => 2,
			y_mth_ver_src_fdate_eq = 4         => 4,
			y_mth_ver_src_fdate_eq <= 5        => 5,
												  6);

		y_mth_fdate_x_ldate_eq_c241 := if(y_mth_ver_src_fdate_eq <= 3, 3, 6);

		y_mth_fdate_x_ldate_eq := map(
			y_mth_ver_src_ldate_eq = 1 => y_mth_fdate_x_ldate_eq_c239,
			y_mth_ver_src_ldate_eq = 2 => y_mth_fdate_x_ldate_eq_c240,
			y_mth_ver_src_ldate_eq = 3 => y_mth_fdate_x_ldate_eq_c241,
										  2);

		y_add1_ownership_level_c244 := if((integer)add1_family_owned = 0, 2, 3);

		y_add1_ownership_level_c243 := if((integer)add1_occupant_owned = 0, 1, y_add1_ownership_level_c244);

		y_add1_ownership_level_c246 := if((integer)add1_occupant_owned = 0, 4, 5);

		y_add1_ownership_level_c245 := if((integer)add1_family_owned = 1, y_add1_ownership_level_c246, 6);

		y_add1_ownership_level := if((integer)add1_applicant_owned = 1, y_add1_ownership_level_c243, y_add1_ownership_level_c245);

		y_add_bestmatch_level_cm := map(
			y_add_bestmatch_level = 1 => 0.3095534787,
			y_add_bestmatch_level = 2 => 0.3440583441,
			y_add_bestmatch_level = 3 => 0.3498727735,
										 0.3332980376);

		y_add1_advo_mixed_addr_usage_cm := map(
			y_add1_advo_mixed_addr_usage = 1 => 0.3261473134,
			y_add1_advo_mixed_addr_usage = 2 => 0.2785108388,
			y_add1_advo_mixed_addr_usage = 3 => 0.3116366191,
			y_add1_advo_mixed_addr_usage = 4 => 0.3752160387,
												0.3332980376);

		y_add1_avm_automated_val_cfb_cm := map(
			y_add1_avm_automated_val_cfb = 50000  => 0.4811443433,
			y_add1_avm_automated_val_cfb = 100000 => 0.3868366285,
			y_add1_avm_automated_val_cfb = 150000 => 0.3248856707,
			y_add1_avm_automated_val_cfb = 200000 => 0.3485513608,
			y_add1_avm_automated_val_cfb = 250000 => 0.2824956672,
			y_add1_avm_automated_val_cfb = 300000 => 0.2694760189,
													 0.3332980376);

		y_addr_count_ge3_cm := map(
			y_addr_count_ge3 = 1 => 0.2325249643,
			y_addr_count_ge3 = 2 => 0.2749262537,
			y_addr_count_ge3 = 3 => 0.321996536,
			y_addr_count_ge3 = 4 => 0.3373743347,
			y_addr_count_ge3 = 5 => 0.3473430846,
									0.3332980376);

		y_addrs_per_ssn_c6_cm := map(
			y_addrs_per_ssn_c6 = 1 => 0.3092404331,
			y_addrs_per_ssn_c6 = 2 => 0.4540525114,
			y_addrs_per_ssn_c6 = 3 => 0.5857142857,
									  0.3332980376);

		y_ams_college_tier_cm := map(
			y_ams_college_tier = 1 => 0.1052023121,
			y_ams_college_tier = 2 => 0.1352405722,
			y_ams_college_tier = 3 => 0.1851851852,
			y_ams_college_tier = 4 => 0.2336633663,
			y_ams_college_tier = 5 => 0.2636655949,
			y_ams_college_tier = 6 => 0.3499303082,
									  0.3332980376);

		y_mth_fdate_x_ldate_eq_cm := map(
			y_mth_fdate_x_ldate_eq = 1 => 0.2808376363,
			y_mth_fdate_x_ldate_eq = 2 => 0.3294587214,
			y_mth_fdate_x_ldate_eq = 3 => 0.3680781759,
			y_mth_fdate_x_ldate_eq = 4 => 0.3789583333,
			y_mth_fdate_x_ldate_eq = 5 => 0.4031657356,
			y_mth_fdate_x_ldate_eq = 6 => 0.510998308,
										  0.3332980376);

		y_nap_nas_cm := map(
			y_nap_nas = 1 => 0.2831683168,
			y_nap_nas = 2 => 0.2893530311,
			y_nap_nas = 3 => 0.326287349,
			y_nap_nas = 4 => 0.3784087714,
			y_nap_nas = 5 => 0.3142162326,
			y_nap_nas = 6 => 0.345709571,
			y_nap_nas = 7 => 0.3633746041,
			y_nap_nas = 8 => 0.4267782427,
							 0.3332980376);

		y_ssns_per_adl_cm := map(
			y_ssns_per_adl = 1 => 0.328104075,
			y_ssns_per_adl = 2 => 0.3849950642,
			y_ssns_per_adl = 3 => 0.514619883,
								  0.3332980376);

		y_unique_addr_count_cm := map(
			y_unique_addr_count = 0 => 0.3373743347,
			y_unique_addr_count = 1 => 0.3431897722,
			y_unique_addr_count = 2 => 0.3292349727,
			y_unique_addr_count = 3 => 0.3157311669,
			y_unique_addr_count = 4 => 0.3052415211,
			y_unique_addr_count = 5 => 0.2729468599,
			y_unique_addr_count = 6 => 0.2368421053,
									   0.3332980376);

		y_wealth_index_cm := map(
			y_wealth_index = (string)0 => 0.3416634976,
			y_wealth_index = (string)1 => 0.4718030183,
			y_wealth_index = (string)2 => 0.3786574871,
			y_wealth_index = (string)3 => 0.3075248004,
			y_wealth_index = (string)4 => 0.2676104972,
			y_wealth_index = (string)5 => 0.1670761671,
			y_wealth_index = (string)6 => 0.0882352941,
										  0.3332980376);

		y_infutor_nap_grp_cm := map(
			y_infutor_nap_grp = 1 => 0.2102893891,
			y_infutor_nap_grp = 2 => 0.2341337907,
			y_infutor_nap_grp = 3 => 0.2979423868,
			y_infutor_nap_grp = 4 => 0.3126252505,
			y_infutor_nap_grp = 5 => 0.3262832838,
			y_infutor_nap_grp = 6 => 0.3764705882,
			y_infutor_nap_grp = 7 => 0.4054438351,
			y_infutor_nap_grp = 8 => 0.4409127954,
									 0.3332980376);

		y_inq_count12_cm := map(
			y_inq_count12 = 1 => 0.3181976947,
			y_inq_count12 = 2 => 0.461961962,
			y_inq_count12 = 3 => 0.5661375661,
								 0.3332980376);

		y_add1_ownership_level_cm := map(
			y_add1_ownership_level = 1 => 0.0824175824,
			y_add1_ownership_level = 2 => 0.1716738197,
			y_add1_ownership_level = 3 => 0.2113207547,
			y_add1_ownership_level = 4 => 0.2356979405,
			y_add1_ownership_level = 5 => 0.2587939698,
			y_add1_ownership_level = 6 => 0.351510593,
										  0.3332980376);

		y_age_estimate_cm := map(
			y_age_estimate = 0 => 0.3051171688,
			y_age_estimate = 1 => 0.2834317471,
			y_age_estimate = 2 => 0.3044436284,
			y_age_estimate = 3 => 0.3301835363,
			y_age_estimate = 4 => 0.3682503339,
			y_age_estimate = 5 => 0.4118332169,
								  0.3332980376);

		y_ver_src_cnt_cm := map(
			y_ver_src_cnt = 1 => 0.344091653,
			y_ver_src_cnt = 2 => 0.3315095398,
			y_ver_src_cnt = 3 => 0.3170792079,
			y_ver_src_cnt = 4 => 0.2908961593,
			y_ver_src_cnt = 5 => 0.2803970223,
			y_ver_src_cnt = 6 => 0.2465753425,
			y_ver_src_cnt = 7 => 0.4285714286,
								 0.3332980376);

		y_add1_land_use_cm := map(
			y_add1_land_use = 1 => 0.2327898551,
			y_add1_land_use = 2 => 0.3345414864,
			y_add1_land_use = 3 => 0.3836838751,
								   0.3332980376);

		y_add1_advo_address_vacancy_cm := map(
			y_add1_advo_address_vacancy = 1 => 0.3173253368,
			y_add1_advo_address_vacancy = 2 => 0.3860510806,
			y_add1_advo_address_vacancy = 3 => 0.4315906563,
											   0.3332980376);

		y_did_count_cm := map(
			y_did_count = 1 => 0.2269789984,
			y_did_count = 2 => 0.3100775194,
			y_did_count = 3 => 0.3385629236,
							   0.3332980376);

		y_email_count_cm := map(
			y_email_count = 1 => 0.3275063369,
			y_email_count = 2 => 0.3462043604,
			y_email_count = 3 => 0.3775811209,
			y_email_count = 4 => 0.3945686901,
								 0.3332980376);

		y_mth_gong_did_first_seen_cm := map(
			y_mth_gong_did_first_seen = 1 => 0.3152306353,
			y_mth_gong_did_first_seen = 2 => 0.3779850746,
			y_mth_gong_did_first_seen = 3 => 0.4288008565,
			y_mth_gong_did_first_seen = 4 => 0.4788557214,
											 0.3332980376);

		ymod_phn_prob := -0.787470765 +
			(integer)phn_nap_disconnected * 0.2839577747 +
			(integer)no_gong_did_addr * -0.419821478 +
			(integer)phn_nonus * 0.6122939449 +
			y_telcordia_type * 0.2550566242;

		ymod_add_prob := -3.813210503 +
			y_add1_advo_address_vacancy_cm * 2.6636632603 +
			y_add1_land_use_cm * 3.4510686876 +
			y_add1_advo_mixed_addr_usage_cm * 3.2251957276;

		ymod_ssn_prob := -0.52378724 +
			(integer)y_ssn_low_risk * -0.857194789 +
			ssn_ms_1 * -0.284233635 +
			(integer)ssn_improper * -0.565388279 +
			(integer)lo_combo_ssnscore * 0.3916663318;

		ymod02 := -19.59578875 +
			y_paw_source_count_ind * -0.30877877 +
			y_add_bestmatch_level_cm * 3.9497588818 +
			y_add1_avm_automated_val_cfb_cm * 3.0735450864 +
			y_addr_count_ge3_cm * 2.9177444183 +
			y_addrs_per_ssn_c6_cm * 2.8644525272 +
			y_ams_college_tier_cm * 5.4306632735 +
			y_email_count_cm * 4.2604330008 +
			y_mth_gong_did_first_seen_cm * 3.5975192276 +
			y_mth_fdate_x_ldate_eq_cm * 2.284187076 +
			y_ssns_per_adl_cm * 3.7211694996 +
			y_unique_addr_count_cm * 2.6481731824 +
			y_wealth_index_cm * 1.568032242 +
			y_infutor_nap_grp_cm * 3.6678398218 +
			y_inq_count12_cm * 3.4774704882 +
			y_add1_ownership_level_cm * 3.9918909258 +
			y_ver_src_cnt_cm * 3.1465452184 +
			y_did_count_cm * 4.3468489835 +
			ymod_phn_prob * 0.2566426986 +
			ymod_ssn_prob * 0.7338275798 +
			ymod_add_prob * 0.5411929642 +
			(integer)ssn_adl_prob * 0.1409577388 +
			y_age_estimate_cm * 1.5304309758 +
			(integer)prof_license_flag * -0.499780561 +
			y_nap_nas_cm * 3.1638959272;

		y_phat := exp(ymod02) / (1 + exp(ymod02));

		o_nap_nas_c270 := map(
			nap_summary = 0 and nas_summary = 0   => 6,
			nap_summary = 0 and nas_summary = 1   => 8,
			nap_summary = 0 and nas_summary = 2   => 8,
			nap_summary = 0 and nas_summary = 4   => 7,
			nap_summary = 0 and nas_summary = 5   => 6,
			nap_summary = 0 and nas_summary = 7   => 5,
			nap_summary = 0 and nas_summary = 8   => 4,
			nap_summary = 0 and nas_summary = 9   => 7,
			nap_summary = 0 and nas_summary = 10  => 6,
			nap_summary = 0 and nas_summary = 11  => 4,
			nap_summary = 0 and nas_summary = 12  => 4,
			nap_summary = 1 and nas_summary = 0   => 5,
			nap_summary = 1 and nas_summary = 1   => 5,
			nap_summary = 1 and nas_summary = 2   => 7,
			nap_summary = 1 and nas_summary = 4   => 6,
			nap_summary = 1 and nas_summary = 8   => 6,
			nap_summary = 1 and nas_summary = 9   => 4,
			nap_summary = 1 and nas_summary = 12  => 4,
			nap_summary = 3 and nas_summary = 2   => 6,
			nap_summary = 3 and nas_summary = 7   => 5,
			nap_summary = 3 and nas_summary = 8   => 5,
			nap_summary = 3 and nas_summary = 9   => 6,
			nap_summary = 3 and nas_summary = 12  => 5,
			nap_summary = 4 and nas_summary = 0   => 6,
			nap_summary = 4 and nas_summary = 2   => 6,
			nap_summary = 4 and nas_summary = 9   => 6,
			nap_summary = 4 and nas_summary = 12  => 3,
			nap_summary = 5 and nas_summary = 0   => 5,
			nap_summary = 5 and nas_summary = 1   => 5,
			nap_summary = 5 and nas_summary = 2   => 5,
			nap_summary = 5 and nas_summary = 4   => 5,
			nap_summary = 5 and nas_summary = 8   => 4,
			nap_summary = 5 and nas_summary = 9   => 8,
			nap_summary = 5 and nas_summary = 10  => 4,
			nap_summary = 5 and nas_summary = 12  => 5,
			nap_summary = 6 and nas_summary = 0   => 6,
			nap_summary = 6 and nas_summary = 2   => 6,
			nap_summary = 6 and nas_summary = 8   => 6,
			nap_summary = 6 and nas_summary = 9   => 8,
			nap_summary = 6 and nas_summary = 10  => 6,
			nap_summary = 6 and nas_summary = 11  => 5,
			nap_summary = 6 and nas_summary = 12  => 5,
			nap_summary = 7 and nas_summary = 0   => 4,
			nap_summary = 7 and nas_summary = 2   => 4,
			nap_summary = 7 and nas_summary = 8   => 4,
			nap_summary = 7 and nas_summary = 9   => 6,
			nap_summary = 7 and nas_summary = 12  => 2,
			nap_summary = 8 and nas_summary = 0   => 7,
			nap_summary = 8 and nas_summary = 1   => 5,
			nap_summary = 8 and nas_summary = 2   => 7,
			nap_summary = 8 and nas_summary = 4   => 5,
			nap_summary = 8 and nas_summary = 5   => 5,
			nap_summary = 8 and nas_summary = 7   => 4,
			nap_summary = 8 and nas_summary = 8   => 2,
			nap_summary = 8 and nas_summary = 9   => 6,
			nap_summary = 8 and nas_summary = 11  => 3,
			nap_summary = 8 and nas_summary = 12  => 4,
			nap_summary = 9 and nas_summary = 0   => 4,
			nap_summary = 9 and nas_summary = 2   => 3,
			nap_summary = 9 and nas_summary = 8   => 1,
			nap_summary = 9 and nas_summary = 9   => 6,
			nap_summary = 9 and nas_summary = 12  => 2,
			nap_summary = 10 and nas_summary = 0  => 5,
			nap_summary = 10 and nas_summary = 6  => 5,
			nap_summary = 10 and nas_summary = 8  => 5,
			nap_summary = 10 and nas_summary = 9  => 4,
			nap_summary = 10 and nas_summary = 12 => 3,
			nap_summary = 11 and nas_summary = 0  => 3,
			nap_summary = 11 and nas_summary = 1  => 4,
			nap_summary = 11 and nas_summary = 2  => 4,
			nap_summary = 11 and nas_summary = 4  => 4,
			nap_summary = 11 and nas_summary = 8  => 1,
			nap_summary = 11 and nas_summary = 9  => 6,
			nap_summary = 11 and nas_summary = 11 => 1,
			nap_summary = 11 and nas_summary = 12 => 2,
			nap_summary = 12 and nas_summary = 0  => 5,
			nap_summary = 12 and nas_summary = 1  => 4,
			nap_summary = 12 and nas_summary = 2  => 2,
			nap_summary = 12 and nas_summary = 3  => 4,
			nap_summary = 12 and nas_summary = 4  => 4,
			nap_summary = 12 and nas_summary = 7  => 3,
			nap_summary = 12 and nas_summary = 8  => 1,
			nap_summary = 12 and nas_summary = 9  => 5,
			nap_summary = 12 and nas_summary = 11 => 2,
			nap_summary = 12 and nas_summary = 12 => 1,
													 NULL);

		o_nap_nas_c271 := map(
			nap_summary = 0 and nas_summary = 0  => 7,
			nap_summary = 0 and nas_summary = 2  => 7,
			nap_summary = 0 and nas_summary = 3  => 6,
			nap_summary = 0 and nas_summary = 5  => 5,
			nap_summary = 0 and nas_summary = 8  => 6,
			nap_summary = 1 and nas_summary = 0  => 6,
			nap_summary = 1 and nas_summary = 2  => 6,
			nap_summary = 1 and nas_summary = 5  => 5,
			nap_summary = 1 and nas_summary = 8  => 4,
			nap_summary = 3 and nas_summary = 0  => 6,
			nap_summary = 3 and nas_summary = 2  => 8,
			nap_summary = 3 and nas_summary = 8  => 5,
			nap_summary = 4 and nas_summary = 2  => 5,
			nap_summary = 4 and nas_summary = 8  => 5,
			nap_summary = 5 and nas_summary = 0  => 5,
			nap_summary = 5 and nas_summary = 2  => 8,
			nap_summary = 5 and nas_summary = 8  => 7,
			nap_summary = 6 and nas_summary = 0  => 5,
			nap_summary = 6 and nas_summary = 2  => 5,
			nap_summary = 6 and nas_summary = 8  => 2,
			nap_summary = 7 and nas_summary = 2  => 3,
			nap_summary = 7 and nas_summary = 8  => 1,
			nap_summary = 8 and nas_summary = 0  => 7,
			nap_summary = 8 and nas_summary = 2  => 6,
			nap_summary = 8 and nas_summary = 5  => 5,
			nap_summary = 8 and nas_summary = 8  => 7,
			nap_summary = 9 and nas_summary = 0  => 6,
			nap_summary = 9 and nas_summary = 2  => 3,
			nap_summary = 9 and nas_summary = 8  => 2,
			nap_summary = 10 and nas_summary = 2 => 6,
			nap_summary = 10 and nas_summary = 8 => 5,
			nap_summary = 11 and nas_summary = 2 => 7,
			nap_summary = 11 and nas_summary = 8 => 4,
			nap_summary = 12 and nas_summary = 0 => 5,
			nap_summary = 12 and nas_summary = 2 => 3,
			nap_summary = 12 and nas_summary = 5 => 3,
			nap_summary = 12 and nas_summary = 8 => 2,
													NULL);

		o_nap_nas := if(ssn_ms_1 = 0, o_nap_nas_c270, o_nap_nas_c271);

		o_did_count := map(
			did_count = 1         => 1,
			(did_count in [0, 1]) => 2,
									 3);

		o_rc_disthphoneaddr := map(
			rc_disthphoneaddr = 0  => 1,
			rc_disthphoneaddr <= 1 => 3,
									  2);

		o_combo_dobcount := map(
			combo_dobcount <= 0 => 1,
			combo_dobcount <= 1 => 2,
			combo_dobcount <= 2 => 3,
			combo_dobcount <= 5 => 4,
			combo_dobcount <= 6 => 5,
								   6);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_mth_ver_src_fdate_wp := map(
			mth_ver_src_fdate_wp = NULL => 2,
			mth_ver_src_fdate_wp < 12   => 3,
			mth_ver_src_fdate_wp < 60   => 1,
										   3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_mth_ver_src_ldate_wp := map(
			mth_ver_src_ldate_wp = NULL => 2,
			mth_ver_src_ldate_wp < 6    => 1,
										   3);

		o_mth_fdate_x_ldate_wp := map(
			o_mth_ver_src_fdate_wp = 1 and o_mth_ver_src_ldate_wp = 1 => 1,
			o_mth_ver_src_fdate_wp = 3 and o_mth_ver_src_ldate_wp = 1 => 3,
			o_mth_ver_src_fdate_wp = 3 and o_mth_ver_src_ldate_wp = 3 => 5,
																		 2);

		o_add1_avm_med_mm := if(add1_avm_med <= 0, 201134, add1_avm_med);

		o_add1_avm_automated_val := if(add1_avm_automated_valuation <= 0, o_add1_avm_med_mm, add1_avm_automated_valuation);

		o_add1_avm_automated_val_cf := min(300000, if(max((real)50000, o_add1_avm_automated_val) = NULL, -NULL, max((real)50000, o_add1_avm_automated_val)));

		o_add1_avm_automated_val_cfb := 50000 * round(o_add1_avm_automated_val_cf / 50000);

		o_addrs_15yr := map(
			addrs_15yr <= 0 => 1,
			addrs_15yr <= 1 => 2,
			addrs_15yr <= 2 => 3,
			addrs_15yr <= 4 => 4,
			addrs_15yr <= 7 => 5,
			addrs_15yr <= 9 => 6,
							   7);

		o_nameperssn_count := (integer)(nameperssn_count > 0);

		o_ssns_per_adl := map(
			ssns_per_adl = 0 => 4,
			ssns_per_adl = 1 => 1,
			ssns_per_adl = 2 => 2,
			ssns_per_adl = 3 => 3,
								4);

		o_addrs_per_ssn_c6 := map(
			addrs_per_ssn_c6 <= 0 => 1,
			addrs_per_ssn_c6 <= 1 => 2,
									 3);

		o_vo_addrs_per_adl := map(
			vo_addrs_per_adl = 1 => 2,
			vo_addrs_per_adl = 3 => 1,
									3);

		o_inq_count12 := map(
			inq_count12 <= 0 => 1,
			inq_count12 <= 1 => 2,
								3);

		o_infutor_nap_grp := map(
			infutor_nap <= 0 or (infutor_nap in [11, 12]) => 1,
			infutor_nap = 1                               => 4,
			(infutor_nap in [4, 6])                       => 5,
			(infutor_nap in [7, 9])                       => 2,
			infutor_nap = 10                              => 3,
															 2);

		o_ams_college_tier := map(
			ams_college_tier = (string)0 => 2,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 3,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 7,
											6);

		o_wealth_index := wealth_index;


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_prof_license_category := map(
			prof_license_category = ''    => 5,
			(real)prof_license_category = 0 => 4,
			(real)prof_license_category = 1 => 6,
			(real)prof_license_category = 2 => 4,
			(real)prof_license_category = 3 => 3,
			(real)prof_license_category = 4 => 2,
			(real)prof_license_category = 5 => 1,
											   5);

		o_ssn_low_risk := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['4', '5']) or (integer)rc_non_us_ssn = 1;


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_add1_advo_address_vacancy := map(
			add1_advo_address_vacancy = ''        => 2,
			(string)add1_advo_address_vacancy = 'N' => 1,
													   3);

		o_advo_low_risk := map(
			(string)add1_advo_dnd = 'Y' or (add1_advo_seasonal_delivery in ['E', 'Y'])                                  => 3,
			(string)add1_advo_dnd = 'N' or (string)add1_advo_seasonal_delivery = 'N' or (string)add1_advo_college = 'N' => 2,
																														   1);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_add1_advo_mixed_addr_usage := map(
			add1_advo_mixed_address_usage = ''        => 4,
			(string)add1_advo_mixed_address_usage = 'A' => 1,
			(string)add1_advo_mixed_address_usage = 'B' => 3,
			(string)add1_advo_mixed_address_usage = 'C' => 2,
														   4);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_mth_ver_src_fdate_eq := map(
			mth_ver_src_fdate_eq = NULL => 5,
			mth_ver_src_fdate_eq < 120  => 4,
			mth_ver_src_fdate_eq < 240  => 3,
			mth_ver_src_fdate_eq < 360  => 2,
										   1);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		o_mth_ver_src_ldate_eq := map(
			mth_ver_src_ldate_eq = NULL => 3,
			mth_ver_src_ldate_eq < 12   => 2,
										   1);

		o_mth_fdate_x_ldate_eq_9 := if(o_mth_ver_src_ldate_eq = 1 and o_mth_ver_src_fdate_eq = 1, 1, NULL);

		o_mth_fdate_x_ldate_eq_8 := if(o_mth_ver_src_ldate_eq = 1 and o_mth_ver_src_fdate_eq = 2, 1, o_mth_fdate_x_ldate_eq_9);

		o_mth_fdate_x_ldate_eq_7 := if(o_mth_ver_src_ldate_eq = 2 and o_mth_ver_src_fdate_eq = 1, 1, o_mth_fdate_x_ldate_eq_8);

		o_mth_fdate_x_ldate_eq_6 := if(o_mth_ver_src_ldate_eq = 2 and o_mth_ver_src_fdate_eq = 2, 2, o_mth_fdate_x_ldate_eq_7);

		o_mth_fdate_x_ldate_eq_5 := if(o_mth_ver_src_ldate_eq = 1 and o_mth_ver_src_fdate_eq = 4, 3, o_mth_fdate_x_ldate_eq_6);

		o_mth_fdate_x_ldate_eq_4 := if(o_mth_ver_src_ldate_eq = 2 and o_mth_ver_src_fdate_eq = 3, 3, o_mth_fdate_x_ldate_eq_5);

		o_mth_fdate_x_ldate_eq_3 := if(o_mth_ver_src_ldate_eq = 1 and o_mth_ver_src_fdate_eq = 3, 4, o_mth_fdate_x_ldate_eq_4);

		o_mth_fdate_x_ldate_eq_2 := if(o_mth_ver_src_ldate_eq = 2 and o_mth_ver_src_fdate_eq = 4, 4, o_mth_fdate_x_ldate_eq_3);

		o_mth_fdate_x_ldate_eq_1 := if(o_mth_ver_src_ldate_eq = 3 and o_mth_ver_src_fdate_eq = 4, 4, o_mth_fdate_x_ldate_eq_2);

		o_mth_fdate_x_ldate_eq := if(o_mth_ver_src_ldate_eq = 3 and o_mth_ver_src_fdate_eq = 5, 5, o_mth_fdate_x_ldate_eq_1);

		o_prop_ownership := map(
			prop_ownership <= 0 => 4,
			prop_ownership <= 1 => 3,
			prop_ownership <= 2 => 2,
								   1);

		o_add1_ownership_level := map(
			(integer)add1_applicant_owned = 1 and (integer)add1_family_owned = 1 and (integer)add1_occupant_owned = 0 => 1,
			(integer)add1_applicant_owned = 1 and (integer)add1_family_owned = 1 and (integer)add1_occupant_owned = 1 => 2,
			(integer)add1_applicant_owned = 1 and (integer)add1_family_owned = 0 and (integer)add1_occupant_owned = 0 => 2,
			(integer)add1_applicant_owned = 1 and (integer)add1_family_owned = 0 and (integer)add1_occupant_owned = 1 => 3,
			(integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 1 and (integer)add1_occupant_owned = 0 => 4,
			(integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 1 and (integer)add1_occupant_owned = 1 => 4,
			(integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add1_occupant_owned = 0 => 6,
																														 5);

		o_add1_financing_type := map(
			add1_financing_type = 'ADJ' => 4,
			add1_financing_type = 'CNV' => 2,
			add1_financing_type = 'OTH' => 1,
										   3);

		o_watercraft_count_cap2 := min(2, if(watercraft_count = NULL, -NULL, watercraft_count));

		o_add1_advo_mixed_addr_usage_cm := map(
			o_add1_advo_mixed_addr_usage = 1 => 0.0638438469,
			o_add1_advo_mixed_addr_usage = 2 => 0.1115044248,
			o_add1_advo_mixed_addr_usage = 3 => 0.0829113924,
			o_add1_advo_mixed_addr_usage = 4 => 0.1053497942,
												0.0857689961);

		o_add1_avm_automated_val_cfb_cm := map(
			o_add1_avm_automated_val_cfb = 50000  => 0.1553918285,
			o_add1_avm_automated_val_cfb = 100000 => 0.1105163184,
			o_add1_avm_automated_val_cfb = 150000 => 0.0965455014,
			o_add1_avm_automated_val_cfb = 200000 => 0.0850547958,
			o_add1_avm_automated_val_cfb = 250000 => 0.0753202065,
			o_add1_avm_automated_val_cfb = 300000 => 0.06163408,
													 0.0857689961);

		o_add1_financing_type_cm := map(
			o_add1_financing_type = 1 => 0.0595238095,
			o_add1_financing_type = 2 => 0.0703472841,
			o_add1_financing_type = 3 => 0.0854662757,
			o_add1_financing_type = 4 => 0.0971212562,
										 0.0857689961);

		o_addrs_15yr_cm := map(
			o_addrs_15yr = 1 => 0.0594493116,
			o_addrs_15yr = 2 => 0.0646160198,
			o_addrs_15yr = 3 => 0.0727837185,
			o_addrs_15yr = 4 => 0.0850779882,
			o_addrs_15yr = 5 => 0.0916272946,
			o_addrs_15yr = 6 => 0.100901297,
			o_addrs_15yr = 7 => 0.1154390935,
								0.0857689961);

		o_addrs_per_ssn_c6_cm := map(
			o_addrs_per_ssn_c6 = 1 => 0.0805792466,
			o_addrs_per_ssn_c6 = 2 => 0.1718004338,
			o_addrs_per_ssn_c6 = 3 => 0.2680412371,
									  0.0857689961);

		o_ams_college_tier_cm := map(
			o_ams_college_tier = 1 => 0.015503876,
			o_ams_college_tier = 2 => 0.0353982301,
			o_ams_college_tier = 3 => 0.0405854957,
			o_ams_college_tier = 4 => 0.0532687651,
			o_ams_college_tier = 5 => 0.0747474747,
			o_ams_college_tier = 6 => 0.0886316319,
			o_ams_college_tier = 7 => 0.0955223881,
									  0.0857689961);

		o_combo_dobcount_cm := map(
			o_combo_dobcount = 1 => 0.1020113979,
			o_combo_dobcount = 2 => 0.0874730022,
			o_combo_dobcount = 3 => 0.0768442623,
			o_combo_dobcount = 4 => 0.0546352342,
			o_combo_dobcount = 5 => 0.0353798127,
			o_combo_dobcount = 6 => 0.0217391304,
									0.0857689961);

		o_mth_fdate_x_ldate_eq_cm := map(
			o_mth_fdate_x_ldate_eq = 1 => 0.042158516,
			o_mth_fdate_x_ldate_eq = 2 => 0.0627067523,
			o_mth_fdate_x_ldate_eq = 3 => 0.0962633151,
			o_mth_fdate_x_ldate_eq = 4 => 0.1200289226,
			o_mth_fdate_x_ldate_eq = 5 => 0.1741741742,
										  0.0857689961);

		o_nap_nas_cm := map(
			o_nap_nas = 1 => 0.0401891253,
			o_nap_nas = 2 => 0.0495525356,
			o_nap_nas = 3 => 0.0628272251,
			o_nap_nas = 4 => 0.0833278699,
			o_nap_nas = 5 => 0.096,
			o_nap_nas = 6 => 0.1119614512,
			o_nap_nas = 7 => 0.1429867332,
			o_nap_nas = 8 => 0.2064606742,
							 0.0857689961);

		o_prof_license_category_cm := map(
			o_prof_license_category = 1 => 0.0305444887,
			o_prof_license_category = 2 => 0.0598006645,
			o_prof_license_category = 3 => 0.0681381958,
			o_prof_license_category = 4 => 0.0785498489,
			o_prof_license_category = 5 => 0.0874643742,
			o_prof_license_category = 6 => 0.1271523179,
										   0.0857689961);

		o_ssns_per_adl_cm := map(
			o_ssns_per_adl = 1 => 0.076559081,
			o_ssns_per_adl = 2 => 0.1087231353,
			o_ssns_per_adl = 3 => 0.1336260979,
			o_ssns_per_adl = 4 => 0.1766467066,
								  0.0857689961);

		o_vo_addrs_per_adl_cm := map(
			o_vo_addrs_per_adl = 1 => 0.0513290559,
			o_vo_addrs_per_adl = 2 => 0.0798816568,
			o_vo_addrs_per_adl = 3 => 0.0895272366,
									  0.0857689961);

		o_wealth_index_cm := map(
			o_wealth_index = (string)0 => 0.0798449612,
			o_wealth_index = (string)2 => 0.1710752319,
			o_wealth_index = (string)3 => 0.1161782297,
			o_wealth_index = (string)4 => 0.0849346036,
			o_wealth_index = (string)5 => 0.0644075755,
			o_wealth_index = (string)6 => 0.0549597855,
										  0.0857689961);

		o_infutor_nap_grp_cm := map(
			o_infutor_nap_grp = 1 => 0.072890164,
			o_infutor_nap_grp = 2 => 0.1095586605,
			o_infutor_nap_grp = 3 => 0.1326530612,
			o_infutor_nap_grp = 4 => 0.1444821393,
			o_infutor_nap_grp = 5 => 0.1584984359,
									 0.0857689961);

		o_watercraft_count_cap2_cm := map(
			o_watercraft_count_cap2 = 0 => 0.0879391461,
			o_watercraft_count_cap2 = 1 => 0.03878327,
			o_watercraft_count_cap2 = 2 => 0.0346260388,
										   0.0857689961);

		o_inq_count12_cm := map(
			o_inq_count12 = 1 => 0.0813281064,
			o_inq_count12 = 2 => 0.2258883249,
			o_inq_count12 = 3 => 0.3176470588,
								 0.0857689961);

		o_add1_ownership_level_cm := map(
			o_add1_ownership_level = 1 => 0.0464344942,
			o_add1_ownership_level = 2 => 0.0559461571,
			o_add1_ownership_level = 3 => 0.0833923692,
			o_add1_ownership_level = 4 => 0.104281768,
			o_add1_ownership_level = 5 => 0.1254332756,
			o_add1_ownership_level = 6 => 0.1180838323,
										  0.0857689961);

		o_prop_ownership_cm := map(
			o_prop_ownership = 1 => 0.0627419992,
			o_prop_ownership = 2 => 0.0937791836,
			o_prop_ownership = 3 => 0.1062240664,
			o_prop_ownership = 4 => 0.0876068376,
									0.0857689961);

		o_advo_low_risk_cm := map(
			o_advo_low_risk = 1 => 0.1043003851,
			o_advo_low_risk = 2 => 0.0837939203,
			o_advo_low_risk = 3 => 0.0393184797,
								   0.0857689961);

		o_add1_advo_address_vacancy_cm := map(
			o_add1_advo_address_vacancy = 1 => 0.08094156,
			o_add1_advo_address_vacancy = 2 => 0.1043003851,
			o_add1_advo_address_vacancy = 3 => 0.1850931677,
											   0.0857689961);

		o_did_count_cm := map(
			o_did_count = 1 => 0.0834008274,
			o_did_count = 2 => 0.11,
			o_did_count = 3 => 0.1465517241,
							   0.0857689961);

		o_mth_fdate_x_ldate_wp_cm := map(
			o_mth_fdate_x_ldate_wp = 1 => 0.0593267278,
			o_mth_fdate_x_ldate_wp = 2 => 0.0970565121,
			o_mth_fdate_x_ldate_wp = 3 => 0.1149713467,
			o_mth_fdate_x_ldate_wp = 5 => 0.1516393443,
										  0.0857689961);

		omod_phn_prob := -3.038770368 +
			(integer)phn_notpots * 0.7341423575 +
			(integer)no_gong_did_addr * 0.1093571619 +
			(integer)phn_high_risk * 0.1674883146 +
			(integer)phn_no_zip_match * 0.677734024 +
			o_rc_disthphoneaddr * 0.1448622431;

		omod_ssn_prob := -2.397533309 +
			(integer)o_ssn_low_risk * -0.288480047 +
			ssn_ms_1 * 0.3726426484 +
			(integer)ssn_improper * 1.1163562349 +
			(integer)lo_combo_ssnscore * -0.585452725;

		omod_add_prob := -4.548974896 +
			(integer)add_apt * 0.2643403937 +
			(integer)add_inval * -0.628558487 +
			o_add1_advo_address_vacancy_cm * 6.7331472233 +
			(integer)addrs_prison_history * 1.2075398077 +
			o_advo_low_risk_cm * 8.1138356902 +
			o_add1_advo_mixed_addr_usage_cm * 10.022677775;

		omod03 := -13.45224818 +
			o_add1_avm_automated_val_cfb_cm * 8.3038668407 +
			o_add1_financing_type_cm * 17.512042782 +
			o_addrs_15yr_cm * 8.1881750865 +
			o_addrs_per_ssn_c6_cm * 6.9595094252 +
			o_ams_college_tier_cm * 18.92566193 +
			o_combo_dobcount_cm * 6.4565297931 +
			o_mth_fdate_x_ldate_eq_cm * 5.990830641 +
			o_mth_fdate_x_ldate_wp_cm * 5.3577529174 +
			o_nap_nas_cm * 5.2119900467 +
			o_prof_license_category_cm * 8.591373986 +
			o_ssns_per_adl_cm * 7.0052997744 +
			o_vo_addrs_per_adl_cm * 11.131023009 +
			o_wealth_index_cm * 8.1167526908 +
			o_infutor_nap_grp_cm * 4.2866783709 +
			o_watercraft_count_cap2_cm * 12.542692122 +
			o_inq_count12_cm * 5.4176165035 +
			o_add1_ownership_level_cm * 4.5669211456 +
			o_prop_ownership_cm * 10.605224401 +
			o_did_count_cm * 5.0234716198 +
			omod_phn_prob * 0.433279685 +
			omod_ssn_prob * 0.3663908736 +
			omod_add_prob * 0.4479554995 +
			o_nameperssn_count * 0.2516065327;

		o_phat := exp(omod03) / (1 + exp(omod03));

		x_age_estimate := map(
			age_estimate <= 35 => 35,
			age_estimate <= 40 => 40,
			age_estimate <= 45 => 45,
			age_estimate <= 50 => 50,
			age_estimate <= 55 => 55,
			age_estimate <= 60 => 60,
								  61);

		ssn_ms := (integer)(rc_ssnvalflag = (string)3);

		x_nap_nas_c331 := map(
			nap_summary = 0 and (nas_summary in [1, 2, 4, 5, 7, 8])  => 5,
			nap_summary = 1 and (nas_summary in [2, 4, 7, 8])        => 5,
			nap_summary = 4 and nas_summary = 0                      => 5,
			nap_summary = 5 and (nas_summary in [0, 4, 8, 9])        => 5,
			nap_summary = 6 and (nas_summary in [0, 2, 4, 9])        => 5,
			nap_summary = 7 and (nas_summary in [0, 2, 4])           => 5,
			nap_summary = 8 and nas_summary = 0                      => 5,
			nap_summary = 10 and nas_summary = 9                     => 5,
			nap_summary = 11 and (nas_summary in [0, 4, 9])          => 5,
			nap_summary = 12 and (nas_summary in [0, 4])             => 5,
			nap_summary = 0 and (nas_summary in [0, 9])              => 4,
			nap_summary = 1 and (nas_summary in [5, 9, 10, 12])      => 4,
			nap_summary = 2 and nas_summary = 2                      => 4,
			nap_summary = 3 and (nas_summary in [2, 3, 4, 7, 8, 9])  => 4,
			nap_summary = 4 and (nas_summary in [4, 7, 9])           => 4,
			nap_summary = 5 and (nas_summary in [5, 10])             => 4,
			nap_summary = 8 and (nas_summary in [4, 5, 7, 9])        => 4,
			nap_summary = 9 and (nas_summary in [1, 4])              => 4,
			nap_summary = 10 and nas_summary = 0                     => 4,
			nap_summary = 11 and (nas_summary in [5, 6, 7])          => 4,
			nap_summary = 12 and nas_summary = 9                     => 4,
			nap_summary = 0 and (nas_summary in [11, 12])            => 2,
			nap_summary = 4 and (nas_summary in [12])                => 2,
			nap_summary = 5 and (nas_summary in [12])                => 2,
			nap_summary = 6 and (nas_summary in [1, 8, 10, 12])      => 2,
			nap_summary = 7 and (nas_summary in [7, 8])              => 2,
			nap_summary = 8 and (nas_summary in [1])                 => 2,
			nap_summary = 9 and (nas_summary in [0])                 => 2,
			nap_summary = 10 and (nas_summary in [1, 3])             => 2,
			nap_summary = 12 and (nas_summary in [3])                => 2,
			nap_summary = 1 and (nas_summary in [11])                => 1,
			nap_summary = 3 and (nas_summary in [10])                => 1,
			nap_summary = 5 and (nas_summary in [1, 6, 11])          => 1,
			nap_summary = 6 and (nas_summary in [6, 11])             => 1,
			nap_summary = 7 and (nas_summary in [6, 11, 12])         => 1,
			nap_summary = 8 and (nas_summary in [8, 11])             => 1,
			nap_summary = 9 and (nas_summary in [2, 7, 8, 9, 12])    => 1,
			nap_summary = 10 and (nas_summary in [4, 10, 11, 12])    => 1,
			nap_summary = 11 and (nas_summary in [1, 8, 10, 11, 12]) => 1,
			nap_summary = 12 and (nas_summary in [1, 8, 11, 12])     => 1,
																		3);

		x_nap_nas_c332 := map(
			nap_summary = 0 and (nas_summary in [0, 3])       => 5,
			nap_summary = 1 and (nas_summary in [0, 8])       => 5,
			nap_summary = 3 and (nas_summary in [0, 2])       => 5,
			nap_summary = 5 and (nas_summary in [0, 2])       => 5,
			nap_summary = 6 and (nas_summary in [0, 2])       => 5,
			nap_summary = 7 and (nas_summary in [0])          => 5,
			nap_summary = 8 and (nas_summary in [0, 2, 5, 8]) => 5,
			nap_summary = 10 and (nas_summary in [0])         => 5,
			nap_summary = 12 and (nas_summary in [0])         => 5,
			nap_summary = 1 and (nas_summary in [2, 3, 5])    => 4,
			nap_summary = 3 and (nas_summary in [8])          => 4,
			nap_summary = 4 and (nas_summary in [0, 8])       => 4,
			nap_summary = 5 and (nas_summary in [3, 5, 8])    => 4,
			nap_summary = 6 and (nas_summary in [3])          => 4,
			nap_summary = 7 and (nas_summary in [2])          => 4,
			nap_summary = 10 and (nas_summary in [2])         => 4,
			nap_summary = 11 and (nas_summary in [0, 2, 3])   => 4,
			nap_summary = 3 and (nas_summary in [3])          => 2,
			nap_summary = 4 and (nas_summary in [3])          => 2,
			nap_summary = 6 and (nas_summary in [5])          => 2,
			nap_summary = 7 and (nas_summary in [5])          => 2,
			nap_summary = 9 and (nas_summary in [8])          => 2,
			nap_summary = 11 and (nas_summary in [5])         => 2,
			nap_summary = 12 and (nas_summary in [2])         => 2,
			nap_summary = 7 and (nas_summary in [8])          => 1,
			nap_summary = 9 and (nas_summary in [2])          => 1,
			nap_summary = 10 and (nas_summary in [3, 8])      => 1,
			nap_summary = 11 and (nas_summary in [8])         => 1,
			nap_summary = 12 and (nas_summary in [3, 5, 8])   => 1,
																 3);

		x_nap_nas := if(ssn_ms = 0, x_nap_nas_c331, x_nap_nas_c332);

		x_did_count := map(
			did_count = 0 => 1,
			did_count = 1 => 2,
							 3);

		x_rc_combo_sec_rangescore100 := map(
			rc_combo_sec_rangescore = 255 => 2,
			rc_combo_sec_rangescore >= 90 => 1,
											 3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_mth_ver_src_fdate_wp := map(
			mth_ver_src_fdate_wp = NULL => 2,
			mth_ver_src_fdate_wp < 12   => 3,
										   1);

		x_add1_avm_med_mm := if(add1_avm_med <= 0, 204870, add1_avm_med);

		x_add1_avm_automated_val := if(add1_avm_automated_valuation <= 0, x_add1_avm_med_mm, add1_avm_automated_valuation);

		x_add1_avm_automated_val_cf := min(300000, if(max((real)50000, x_add1_avm_automated_val) = NULL, -NULL, max((real)50000, x_add1_avm_automated_val)));

		x_add1_avm_automated_val_cfb := 50000 * round(x_add1_avm_automated_val_cf / 50000);

		x_add1_mortgage_type_risk := map(
			(add1_mortgage_type in ['1', '2', 'G', 'H']) => 3,
			(add1_mortgage_type in ['CNS', 'E', 'N'])    => 1,
															2);

		x_distance_max := map(
			distance_max < 0   => 3,
			distance_max <= 1  => 5,
			distance_max <= 5  => 3,
			distance_max <= 10 => 5,
								  11);

		x_add2_avm_med_mm := if(add2_avm_med <= 0, 201420, add2_avm_med);

		x_add2_avm_automated_val := if(add2_avm_automated_valuation <= 0, x_add2_avm_med_mm, add2_avm_automated_valuation);

		x_add2_avm_automated_val_cf := min(650000, if(max((real)20000, x_add2_avm_automated_val) = NULL, -NULL, max((real)20000, x_add2_avm_automated_val)));

		x_add2_avm_automated_val_cfb := 50000 * round(x_add2_avm_automated_val_cf / 50000);

		x_add2_mortgage_type_risk := map(
			(add2_mortgage_type in ['1', 'FHA', 'G', 'H', 'R']) => 3,
			(add2_mortgage_type in ['CNS', 'E', 'VA'])          => 1,
																   2);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_mth_add2_date_last_seen := if(mth_add2_date_last_seen = NULL, 0, (integer)(mth_add2_date_last_seen > 0));

		x_addrs_15yr := map(
			addrs_15yr <= 2 => 1,
			addrs_15yr <= 6 => 2,
							   3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_mth_gong_did_first_seen := map(
			mth_gong_did_first_seen = NULL => 2,
			mth_gong_did_first_seen < 24   => 3,
			mth_gong_did_first_seen < 36   => 2,
											  1);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_mth_gong_did_last_seen := map(
			mth_gong_did_last_seen = NULL => 2,
			mth_gong_did_last_seen = 0    => 1,
			mth_gong_did_last_seen < 6    => 2,
											 3);

		x_gong_did_phone_ct := map(
			gong_did_phone_ct = 0  => 2,
			gong_did_phone_ct = 1  => 1,
			gong_did_phone_ct = 2  => 2,
			gong_did_phone_ct <= 4 => 3,
									  4);

		x_ssns_per_adl := map(
			ssns_per_adl = 0 => 3,
			ssns_per_adl = 1 => 1,
			ssns_per_adl = 2 => 2,
								3);

		x_ssns_per_addr := map(
			ssns_per_addr <= 0 => 6,
			ssns_per_addr <= 1 => 4,
			ssns_per_addr <= 2 => 1,
			ssns_per_addr <= 4 => 2,
			ssns_per_addr <= 6 => 3,
			ssns_per_addr <= 9 => 5,
								  7);

		x_phones_per_addr := map(
			phones_per_addr <= 0 => 2,
			phones_per_addr <= 1 => 1,
			phones_per_addr <= 3 => 5,
			phones_per_addr <= 9 => 4,
									3);

		x_addrs_per_ssn_c6 := map(
			addrs_per_ssn_c6 <= 0 => 1,
			addrs_per_ssn_c6 <= 1 => 2,
									 3);

		x_ssns_per_addr_c6 := map(
			ssns_per_addr_c6 <= 0 => 3,
			ssns_per_addr_c6 <= 1 => 4,
			ssns_per_addr_c6 <= 2 => 1,
			ssns_per_addr_c6 <= 3 => 2,
			ssns_per_addr_c6 <= 4 => 4,
									 5);

		x_adls_per_phone_c6 := map(
			adls_per_phone_c6 <= 0 => 2,
			adls_per_phone_c6 <= 1 => 3,
									  1);

		x_inq_count12 := map(
			inq_count12 <= 0 => 1,
			inq_count12 <= 1 => 2,
								3);

		x_infutor_nap_grp := map(
			infutor_nap <= 0 or (infutor_nap in [4, 7]) => 2,
			(infutor_nap in [1, 6])                     => 4,
			(infutor_nap in [9, 11, 12])                => 1,
			infutor_nap = 10                            => 3,
														   2);

		x_email_count := map(
			email_count <= 0 => 2,
			email_count <= 1 => 1,
			email_count <= 2 => 2,
			email_count <= 3 => 3,
								4);

		x_attr_num_proflic60_ind := (integer)(attr_num_proflic60 > 0);

		x_ams_class := if((ams_class in ['FR', 'GR', 'JR', 'SO', 'SR', 'UN']), 1, 2);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_ams_income_level_code := map(
			ams_income_level_code = ''               => 5,
			(ams_income_level_code in ['A', 'B', 'C']) => 6,
			(ams_income_level_code in ['D', 'E'])      => 4,
			(ams_income_level_code in ['F', 'G', 'H']) => 3,
			(ams_income_level_code in ['I', 'J'])      => 2,
														  1);

		x_wealth_index := wealth_index;

		x_input_dob_match_level := map(
			input_dob_match_level <= (string)0 => 2,
			input_dob_match_level <= (string)7 => 3,
												  1);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_mth_ver_src_ldate_p := map(
			mth_ver_src_ldate_p = NULL => 4,
			mth_ver_src_ldate_p < 6    => 1,
			mth_ver_src_ldate_p < 24   => 2,
										  3);

		x_ver_src_cnt_vo := min(if(ver_src_cnt_vo = NULL, -NULL, ver_src_cnt_vo), 4);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_add1_land_use_c363 := if(add1_avm_land_use = '' or add1_avm_land_use = (string)2, 1, 2);

		x_add1_land_use_c364 := if(add1_avm_land_use = (string)2, 1, 2);

		x_add1_land_use_c365 := if(add1_avm_land_use = (string)2, 1, 2);

		x_add1_land_use := map(
			(add1_land_use_code in ['1002', '1004', '1010', '1114']) => x_add1_land_use_c363,
			(trim(add1_land_use_code2, LEFT, RIGHT) in ['10', ' '])  => x_add1_land_use_c364,
			(add1_land_use_code2 in ['19', '80'])                    => x_add1_land_use_c365,
																		3);

		x_telcordia_type := map(
			(trim(telcordia_type, LEFT, RIGHT) in ['', ' ', '04', '51', '52']) => 3,
			(telcordia_type in ['00', '65'])                                   => 2,
			(telcordia_type in ['02', '50', '54', '55', '56', '60'])           => 4,
																				  1);

		x_ssn_low_risk := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['4', '5']) or (integer)rc_non_us_ssn = 1;


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_add1_advo_address_vacancy := map(
			add1_advo_address_vacancy = ''        => 2,
			(string)add1_advo_address_vacancy = 'N' => 1,
													   3);


		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		x_add1_advo_mixed_address_usage := map(
			add1_advo_mixed_address_usage = ''        => 4,
			(string)add1_advo_mixed_address_usage = 'A' => 1,
			(string)add1_advo_mixed_address_usage = 'B' => 3,
			(string)add1_advo_mixed_address_usage = 'C' => 2,
														   4);

		x_age_estimate_cm := map(
			x_age_estimate = 35 => 0.2781847563,
			x_age_estimate = 40 => 0.2742899851,
			x_age_estimate = 45 => 0.2586900842,
			x_age_estimate = 50 => 0.2299741602,
			x_age_estimate = 55 => 0.2051419389,
			x_age_estimate = 60 => 0.1986062718,
			x_age_estimate = 61 => 0.1465717125,
								   0.253364778);

		x_nap_nas_cm := map(
			x_nap_nas = 1 => 0.1426190035,
			x_nap_nas = 2 => 0.224351145,
			x_nap_nas = 3 => 0.2453978838,
			x_nap_nas = 4 => 0.2872209286,
			x_nap_nas = 5 => 0.3887853148,
							 0.253364778);

		x_did_count_cm := map(
			x_did_count = 1 => 0.2036199095,
			x_did_count = 2 => 0.2511563945,
			x_did_count = 3 => 0.3297474275,
							   0.253364778);

		x_mth_ver_src_fdate_wp_cm := map(
			x_mth_ver_src_fdate_wp = 1 => 0.19658374,
			x_mth_ver_src_fdate_wp = 2 => 0.2702904582,
			x_mth_ver_src_fdate_wp = 3 => 0.3086165465,
										  0.253364778);

		x_add1_advo_address_vacancy_cm := map(
			x_add1_advo_address_vacancy = 1 => 0.2360140566,
			x_add1_advo_address_vacancy = 2 => 0.2955015512,
			x_add1_advo_address_vacancy = 3 => 0.3839848676,
											   0.253364778);

		x_add1_advo_mixed_addr_usage_cm := map(
			x_add1_advo_mixed_address_usage = 1 => 0.2132196162,
			x_add1_advo_mixed_address_usage = 2 => 0.2271087055,
			x_add1_advo_mixed_address_usage = 3 => 0.2342611396,
			x_add1_advo_mixed_address_usage = 4 => 0.2930611681,
												   0.253364778);

		x_add1_avm_automated_val_cfb_cm := map(
			x_add1_avm_automated_val_cfb = 50000  => 0.4046659597,
			x_add1_avm_automated_val_cfb = 100000 => 0.3053540155,
			x_add1_avm_automated_val_cfb = 150000 => 0.2712045964,
			x_add1_avm_automated_val_cfb = 200000 => 0.2402234637,
			x_add1_avm_automated_val_cfb = 250000 => 0.222705146,
			x_add1_avm_automated_val_cfb = 300000 => 0.2043385411,
													 0.253364778);

		x_add1_mortgage_type_risk_cm := map(
			x_add1_mortgage_type_risk = 1 => 0.2003710575,
			x_add1_mortgage_type_risk = 2 => 0.2541963743,
			x_add1_mortgage_type_risk = 3 => 0.2867883996,
											 0.253364778);

		x_distance_max_cm := map(
			x_distance_max = 3  => 0.2894049347,
			x_distance_max = 5  => 0.2651374599,
			x_distance_max = 11 => 0.2331952578,
								   0.253364778);

		x_add2_mortgage_type_risk_cm := map(
			x_add2_mortgage_type_risk = 1 => 0.1810385898,
			x_add2_mortgage_type_risk = 2 => 0.2544556034,
			x_add2_mortgage_type_risk = 3 => 0.3012048193,
											 0.253364778);

		x_mth_add2_date_last_seen_cm := map(
			x_mth_add2_date_last_seen = 0 => 0.2704532192,
			x_mth_add2_date_last_seen = 1 => 0.1954227674,
											 0.253364778);

		x_addrs_15yr_cm := map(
			x_addrs_15yr = 1 => 0.2437325905,
			x_addrs_15yr = 2 => 0.2567868852,
			x_addrs_15yr = 3 => 0.2613290864,
								0.253364778);

		x_telcordia_type_cm := map(
			x_telcordia_type = 1 => 0.2352941176,
			x_telcordia_type = 2 => 0.2439662154,
			x_telcordia_type = 3 => 0.2693167375,
			x_telcordia_type = 4 => 0.337944664,
									0.253364778);

		x_mth_gong_did_first_seen_cm := map(
			x_mth_gong_did_first_seen = 1 => 0.2328451117,
			x_mth_gong_did_first_seen = 2 => 0.2615039609,
			x_mth_gong_did_first_seen = 3 => 0.3103938287,
											 0.253364778);

		x_mth_gong_did_last_seen_cm := map(
			x_mth_gong_did_last_seen = 1 => 0.1804347826,
			x_mth_gong_did_last_seen = 2 => 0.2600154414,
			x_mth_gong_did_last_seen = 3 => 0.3066195725,
											0.253364778);

		x_gong_did_phone_ct_cm := map(
			x_gong_did_phone_ct = 1 => 0.2295382041,
			x_gong_did_phone_ct = 2 => 0.2561758598,
			x_gong_did_phone_ct = 3 => 0.2986591696,
			x_gong_did_phone_ct = 4 => 0.3913978495,
									   0.253364778);

		x_ssns_per_adl_cm := map(
			x_ssns_per_adl = 1 => 0.2290684376,
			x_ssns_per_adl = 2 => 0.3017004937,
			x_ssns_per_adl = 3 => 0.3711375798,
								  0.253364778);

		x_ssns_per_addr_cm := map(
			x_ssns_per_addr = 1 => 0.1380116959,
			x_ssns_per_addr = 2 => 0.1726488871,
			x_ssns_per_addr = 3 => 0.1973333333,
			x_ssns_per_addr = 4 => 0.2207792208,
			x_ssns_per_addr = 5 => 0.2354145343,
			x_ssns_per_addr = 6 => 0.2582106455,
			x_ssns_per_addr = 7 => 0.2987647967,
								   0.253364778);

		x_phones_per_addr_cm := map(
			x_phones_per_addr = 1 => 0.2304556223,
			x_phones_per_addr = 2 => 0.2473684211,
			x_phones_per_addr = 3 => 0.2523022432,
			x_phones_per_addr = 4 => 0.2683085603,
			x_phones_per_addr = 5 => 0.2972286863,
									 0.253364778);

		x_addrs_per_ssn_c6_cm := map(
			x_addrs_per_ssn_c6 = 1 => 0.2341941077,
			x_addrs_per_ssn_c6 = 2 => 0.3844918224,
			x_addrs_per_ssn_c6 = 3 => 0.5083240844,
									  0.253364778);

		x_ssns_per_addr_c6_cm := map(
			x_ssns_per_addr_c6 = 1 => 0.2161645849,
			x_ssns_per_addr_c6 = 2 => 0.2364597094,
			x_ssns_per_addr_c6 = 3 => 0.2528417956,
			x_ssns_per_addr_c6 = 4 => 0.2741666667,
			x_ssns_per_addr_c6 = 5 => 0.3571428571,
									  0.253364778);

		x_adls_per_phone_c6_cm := map(
			x_adls_per_phone_c6 = 1 => 0.1327913279,
			x_adls_per_phone_c6 = 2 => 0.2535976809,
			x_adls_per_phone_c6 = 3 => 0.2693383038,
									   0.253364778);

		x_infutor_nap_grp_cm := map(
			x_infutor_nap_grp = 1 => 0.2010323282,
			x_infutor_nap_grp = 2 => 0.2380064339,
			x_infutor_nap_grp = 3 => 0.2663755459,
			x_infutor_nap_grp = 4 => 0.3528463151,
									 0.253364778);

		x_email_count_cm := map(
			x_email_count = 1 => 0.2249270697,
			x_email_count = 2 => 0.2563181574,
			x_email_count = 3 => 0.2696041822,
			x_email_count = 4 => 0.3325526932,
								 0.253364778);

		x_attr_num_proflic60_ind_cm := map(
			x_attr_num_proflic60_ind = 0 => 0.2578524585,
			x_attr_num_proflic60_ind = 1 => 0.1524347212,
											0.253364778);

		x_ams_class_cm := map(
			x_ams_class = 1 => 0.1157662624,
			x_ams_class = 2 => 0.2634234408,
							   0.253364778);

		x_ams_income_level_code_cm := map(
			x_ams_income_level_code = 1 => 0.0975609756,
			x_ams_income_level_code = 2 => 0.1165884194,
			x_ams_income_level_code = 3 => 0.1733966746,
			x_ams_income_level_code = 4 => 0.2287566011,
			x_ams_income_level_code = 5 => 0.2660198514,
			x_ams_income_level_code = 6 => 0.3364383562,
										   0.253364778);

		x_wealth_index_cm := map(
			x_wealth_index = (string)0 => 0.2579535309,
			x_wealth_index = (string)1 => 0.3973998595,
			x_wealth_index = (string)2 => 0.2903225806,
			x_wealth_index = (string)3 => 0.2287581699,
			x_wealth_index = (string)4 => 0.1977850569,
			x_wealth_index = (string)5 => 0.0976220275,
			x_wealth_index = (string)6 => 0.0606060606,
										  0.253364778);

		x_input_dob_match_level_cm := map(
			x_input_dob_match_level = 1 => 0.216753167,
			x_input_dob_match_level = 2 => 0.2616713557,
			x_input_dob_match_level = 3 => 0.3414634146,
										   0.253364778);

		x_rc_combo_sec_rangescore100_cm := map(
			x_rc_combo_sec_rangescore100 = 1 => 0.1923576063,
			x_rc_combo_sec_rangescore100 = 2 => 0.2595394449,
			x_rc_combo_sec_rangescore100 = 3 => 0.2812006319,
												0.253364778);

		x_mth_ver_src_ldate_p_cm := map(
			x_mth_ver_src_ldate_p = 1 => 0.1097234612,
			x_mth_ver_src_ldate_p = 2 => 0.1428571429,
			x_mth_ver_src_ldate_p = 3 => 0.1581508516,
			x_mth_ver_src_ldate_p = 4 => 0.2730645473,
										 0.253364778);

		x_add2_avm_automated_val_cfb_cm := map(
			x_add2_avm_automated_val_cfb = 0      => 0.4507042254,
			x_add2_avm_automated_val_cfb = 50000  => 0.3641713748,
			x_add2_avm_automated_val_cfb = 100000 => 0.3036847078,
			x_add2_avm_automated_val_cfb = 150000 => 0.2622381539,
			x_add2_avm_automated_val_cfb = 200000 => 0.2533982968,
			x_add2_avm_automated_val_cfb = 250000 => 0.2213391615,
			x_add2_avm_automated_val_cfb = 300000 => 0.2112802149,
			x_add2_avm_automated_val_cfb = 350000 => 0.2085497403,
			x_add2_avm_automated_val_cfb = 400000 => 0.2234332425,
			x_add2_avm_automated_val_cfb = 450000 => 0.2174900625,
			x_add2_avm_automated_val_cfb = 500000 => 0.2230113636,
			x_add2_avm_automated_val_cfb = 550000 => 0.1979575805,
			x_add2_avm_automated_val_cfb = 600000 => 0.1633165829,
			x_add2_avm_automated_val_cfb = 650000 => 0.154037709,
													 0.253364778);

		x_ver_src_cnt_vo_cm := map(
			x_ver_src_cnt_vo = 0 => 0.2659516845,
			x_ver_src_cnt_vo = 1 => 0.2362576346,
			x_ver_src_cnt_vo = 2 => 0.2208918966,
			x_ver_src_cnt_vo = 3 => 0.2050343249,
			x_ver_src_cnt_vo = 4 => 0.1912206855,
									0.253364778);

		x_inq_count12_cm := map(
			x_inq_count12 = 1 => 0.2384376558,
			x_inq_count12 = 2 => 0.4461623412,
			x_inq_count12 = 3 => 0.5451080051,
								 0.253364778);

		x_add1_land_use_cm := map(
			x_add1_land_use = 1 => 0.1867891514,
			x_add1_land_use = 2 => 0.2523356759,
			x_add1_land_use = 3 => 0.3096300184,
								   0.253364778);

		xmod_phn_prob := -2.3410 +
			0.7017 * (integer)phn_nonus +
			0.1077 * (integer)no_adls_per_phone +
			0.1637 * (integer)phn_no_zip_match +
			0.2329 * (integer)phn_nap_disconnected +
			4.5020 * x_telcordia_type_cm +
			0.2343 * (integer)phn_invalid +
			-0.2679 * (integer)phn_recent_disconnect;

		xmod_ssn_prob := -1.0410 +
			-0.4127 * (integer)x_ssn_low_risk +
			0.8131 * (integer)ssn_priordob +
			0.4004 * (integer)ssn_improper;

		xmod_add_prob := -3.8406 +
			3.9725 * x_add1_advo_mixed_addr_usage_cm +
			3.4062 * x_add1_advo_address_vacancy_cm +
			2.1283 * (integer)addrs_prison_history +
			3.4002 * x_add1_land_use_cm +
			-0.1877 * (integer)add_inval +
			0.0721 * (integer)add_apt +
			0.5399 * (integer)add_zipcitymismatch;

		xmod01 := -25.07343151 +
			x_nap_nas_cm * 2.3762699163 +
			x_inq_count12_cm * 3.4342314665 +
			x_add1_avm_automated_val_cfb_cm * 2.7265430816 +
			x_addrs_per_ssn_c6_cm * 3.4645448446 +
			x_mth_ver_src_ldate_p_cm * 3.4031565328 +
			x_ams_income_level_code_cm * 3.8929138787 +
			x_infutor_nap_grp_cm * 3.271173567 +
			xmod_add_prob * 0.6603790599 +
			x_ssns_per_addr_cm * 3.3456940147 +
			x_ssns_per_adl_cm * 2.5479716621 +
			x_age_estimate_cm * 3.2865813369 +
			x_ams_class_cm * 4.7136789857 +
			xmod_ssn_prob * 0.8993384485 +
			x_add2_avm_automated_val_cfb_cm * 2.9798299357 +
			x_input_dob_match_level_cm * 3.659599421 +
			x_mth_gong_did_last_seen_cm * 2.9189639943 +
			x_wealth_index_cm * 2.7847856046 +
			x_gong_did_phone_ct_cm * 3.796625749 +
			x_mth_gong_did_first_seen_cm * 2.902210773 +
			xmod_phn_prob * 0.4700169745 +
			x_ssns_per_addr_c6_cm * 3.6039906144 +
			x_attr_num_proflic60_ind_cm * 3.6052326245 +
			(integer)add2_family_owned * -0.197441075 +
			x_mth_add2_date_last_seen_cm * 1.6027888898 +
			x_distance_max_cm * 1.7828325008 +
			x_email_count_cm * 3.7110777358 +
			(integer)ver_src_w * -0.447552736 +
			x_add2_mortgage_type_risk_cm * 3.8204265194 +
			x_adls_per_phone_c6_cm * 4.5564525053 +
			x_did_count_cm * 3.2827380672 +
			(integer)ver_src_am * -1.238617542 +
			x_addrs_15yr_cm * 7.8429167165 +
			x_mth_ver_src_fdate_wp_cm * 1.6728544689 +
			x_ver_src_cnt_vo_cm * 3.0962713246 +
			x_phones_per_addr_cm * 2.1231850589 +
			x_rc_combo_sec_rangescore100_cm * 2.8415732643 +
			x_add1_mortgage_type_risk_cm * 3.7656242348;

		x_phat := exp(xmod01) / (1 + exp(xmod01));

		score_c404_b1 := round(-40 * (ln(d_phat / (1 - d_phat)) - ln(1 / 20)) / ln(2) + 700);

		score_c404_b2 := round(-40 * (ln(y_phat / (1 - y_phat)) - ln(1 / 20)) / ln(2) + 700);

		score_c404_b3 := round(-40 * (ln(o_phat / (1 - o_phat)) - ln(1 / 20)) / ln(2) + 700);

		score_c404_b4 := round(-40 * (ln(x_phat / (1 - x_phat)) - ln(1 / 20)) / ln(2) + 700);

		rvt1104_0_0_1 := map(
			segment40 = '0 Derog' => min(900, if(max(501, score_c404_b1) = NULL, -NULL, max(501, score_c404_b1))),
			segment40 = '1 Young' => min(900, if(max(501, score_c404_b2) = NULL, -NULL, max(501, score_c404_b2))),
			segment40 = '2 Owner' => min(900, if(max(501, score_c404_b3) = NULL, -NULL, max(501, score_c404_b3))),
			segment40 = '3 Other' => min(900, if(max(501, score_c404_b4) = NULL, -NULL, max(501, score_c404_b4))),
			segment40 = 'X 200  ' => 200,
			segment40 = 'X 222  ' => 222,
									 0);

		ov_ssnprior := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = (string)2225;

		ov_impulse := impulse_count > 0;

		rvt1104_0_0 := if(rvt1104_0_0_1 > 680 and (ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 680, rvt1104_0_0_1);



		// REASON CODES
		in_phone10                       := le.shell_input.phone10;
		// rc_non_us_ssn                    := le.iid.non_us_ssn;
		// rc_hriskphoneflag                := le.iid.hriskphoneflag;
		// rc_ssndobflag                    := le.iid.socsdobflag;
		// rc_ssnvalflag                    := le.iid.socsvalflag;
		// rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		// rc_dwelltype                     := le.iid.dwelltype;
		// rc_bansflag                      := le.iid.bansflag;
		// rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
		// rc_disthphoneaddr                := le.iid.disthphoneaddr;
		// combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_hphonecount                := le.iid.combo_hphonecount;
		combo_ssncount                   := le.iid.combo_ssncount;
		// combo_dobcount                   := le.iid.combo_dobcount;
		addrpop                          := le.input_validation.address;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		// add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		// add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		// add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		// add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		// add1_family_owned                := le.address_verification.input_address_information.family_owned;
		// add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
		// property_owned_total             := le.address_verification.owned.property_total;
		// property_sold_total              := le.address_verification.sold.property_total;
		property_ambig_total             := le.address_verification.ambiguous.property_total;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		// add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		// addrs_prison_history             := le.other_address_info.isprison;
		// ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		// inq_count12                      := le.acc_logs.inquiries.count12;
		// impulse_count                    := le.impulse.count;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		// attr_eviction_count              := le.bjl.eviction_count;
		// bankrupt                         := le.bjl.bankrupt;
		// filing_count                     := le.bjl.filing_count;
		// bk_recent_count                  := le.bjl.bk_recent_count;
		// liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		// liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		// criminal_count                   := le.bjl.criminal_count;
		// felony_count                     := le.bjl.felony_count;
		// wealth_index                     := le.wealth_indicator;

segment_d := (integer)(segment40 = '0 Derog');
segment_y := (integer)(segment40 = '1 Young');
segment_o := (integer)(segment40 = '2 Owner');
segment_x := (integer)(segment40 = '3 Other');

glrc9c := if((integer)addrpop>0, 1, 0);
glrc9k := if((integer)addrpop>0, 1, 0);
glrc9l := if((integer)addrpop>0, 1, 0);
glrc9n := if((integer)addrpop>0, 1, 0);
glrc9a := (add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0;
glrc9e := if((integer)addrpop>0, 1, 0);
glrc9t := if((integer)hphnpop>0, 1, 0);
glrc9u := (integer)addrpop>0 and (
(string)add1_advo_address_vacancy = 'Y' OR (boolean)(integer)add_inval OR (boolean)(integer)add_zipcitymismatch);
glrc9v := (integer)ssnlength>0 and (ssn_ms = 0 AND (rc_ssnvalflag != (string)0 OR rc_pwssnvalflag != (string)0 OR (integer)rc_non_us_ssn != 0 OR combo_ssnscore < 100 OR ssn_improper OR ssn_priordob));
glrc3 := rc_ssndobflag = (string)1;
glrc7 := rc_hriskphoneflag = (string)5;
glrc16 := if((integer)hphnpop>0 and in_zipcode<>'', 1, 0);
glrc20 := combo_lnamecount = 0 or combo_addrcount = 0 or combo_hphonecount = 0 or combo_ssncount > 0;
glrc25 := (integer)addrpop = 1 and combo_addrcount = 0;
glrc26 := 1;
glrc27 := length(in_phone10) = 10 and combo_hphonecount = 0;
glrc28 := (integer)dobpop > 0 and combo_dobcount = 0;
glrc36 := 1;
glrc37 := 1;
glrc49 := ((integer)addrpop > 0 and (integer)hphnpop>0) and rc_disthphoneaddr >= 10 and rc_disthphoneaddr != 9999;
glrc74 := 1;
glrc79 := 1;
glrc97 := criminal_count > 0 or felony_count > 0;
glrc98 := ver_src_L2 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
glrc99 := (integer)addrpop>0 and (integer)add1_isbestmatch = 0;
glrc9d := (integer) addrpop>0 and attr_addrs_last12>0 and addrs_15yr>=3;
glrc9g := (integer)dobpop>0 and age_estimate <= 35;
glrc9h := impulse_count > 0;
glrc9i := 0;
glrc9j := mth_header_first_seen < 60;
glrc9o := (integer)addrpop>0 and (integer)add1_eda_sourced = 0;
glrc9q := Inq_count12 > 0;
glrc9s := if((integer)addrpop>0, 1, 0);
glrcev := attr_eviction_count > 0;
glrcmi := (integer)ssnlength>0 and adlperssn_count >= 3;
glrcms := ssns_per_adl >= 3;

aptflag_1 := 0;

aptflag := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, aptflag_1);

add1_econval := map(
    aptflag = 0 and add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
    aptflag = 0 and add1_assessed_total_value > 0    => add1_assessed_total_value,
    aptflag = 0 and add1_avm_med > 0                 => add1_avm_med,
                                                        NULL);

add1_aptval := if(aptflag = 1 and add1_avm_med > 0, add1_avm_med, NULL);

add1_econcode := map(
    aptflag = 0 and add1_econval > 650000 => 'A',
    aptflag = 0 and add1_econval > 450000 => 'B',
    aptflag = 0 and add1_econval > 250000 => 'C',
    aptflag = 0 and add1_econval > 125000 => 'D',
    aptflag = 0 and add1_econval > 75000  => 'E',
    aptflag = 0 and add1_econval > 0      => 'F',
    aptflag = 1 and add1_aptval > 1000000 => 'C',
    aptflag = 1 and add1_aptval > 500000  => 'D',
    aptflag = 1 and add1_aptval > 175000  => 'E',
    aptflag = 1 and add1_aptval > 0       => 'F',
                                             'U');

glrcpv := if(add1_econcode = 'F', 1, 0);

glrc9m := wealth_index < (string)5;

glrc9r := 1;

glrc9w := (integer)bankrupt > 0;

rcvalue16_1 := (integer)segment_d * 0.226728661 * ((integer)phn_no_zip_match - 0.0362843694);

rcvalue16_2 := (integer)segment_o * 0.677734024 * ((integer)phn_no_zip_match - 0.0375818025);

rcvalue16 := glrc16 * sum(rcvalue16_1, rcvalue16_2);

rcvalue28_1 := (integer)segment_d * 1.912654144 * ((real)d_combo_dobcount_cm - 0.341479513);

rcvalue28_2 := (integer)segment_o * 6.456529793 * ((real)o_combo_dobcount_cm - 0.0857689961);

rcvalue28_3 := (integer)segment_x * 3.659599421 * ((real)x_input_dob_match_level_cm - 0.253364778);

rcvalue28 := (integer)glrc28 * sum(rcvalue28_1, rcvalue28_2, rcvalue28_3);

rcvalue36_1 := (integer)segment_d * 1.499502551 * ((real)d_nap_nas_cm - 0.341479513);

rcvalue36_2 := (integer)segment_d * 2.497606699 * ((real)d_vo_addrs_per_adl_cm - 0.3414795129);

rcvalue36_3 := (integer)segment_o * 5.02347162 * ((real)o_did_count_cm - 0.085768996);

rcvalue36_4 := (integer)segment_o * 5.211990047 * ((real)o_nap_nas_cm - 0.0857689961);

rcvalue36_5 := (integer)segment_o * 11.13102301 * ((real)o_vo_addrs_per_adl_cm - 0.085768996);

rcvalue36_6 := (integer)segment_x * -1.238617542 * ((real)ver_src_AM - 0.0044763564);

rcvalue36_7 := (integer)segment_x * 3.282738067 * ((real)x_did_count_cm - 0.2533647779);

rcvalue36_8 := (integer)segment_x * 2.376269916 * ((real)x_nap_nas_cm - 0.253364778);

rcvalue36_9 := (integer)segment_x * 3.096271325 * ((real)x_ver_src_cnt_VO_cm - 0.2533647779);

rcvalue36_10 := (integer)segment_y * 4.346848984 * ((real)y_did_count_cm - 0.3332980376);

rcvalue36_11 := (integer)segment_y * 3.163895927 * ((real)y_nap_nas_cm - 0.3332980375);

rcvalue36 := glrc36 * sum(rcvalue36_1, rcvalue36_2, rcvalue36_3, rcvalue36_4, rcvalue36_5, rcvalue36_6, rcvalue36_7, rcvalue36_8, rcvalue36_9, rcvalue36_10, rcvalue36_11);

rcvalue49_1 := (integer)segment_d * 0.105850144 * ((real)d_rc_disthphoneaddr - 1.8609938687);

rcvalue49_2 := (integer)segment_o * 0.144862243 * ((real)o_rc_disthphoneaddr - 1.7316457294);

rcvalue49 := (integer)glrc49 * sum(rcvalue49_1, rcvalue49_2);

rcvalue79_1 := (integer)segment_d * 0.1343 * ((real)ssn_ms - 0.1991558543);

rcvalue79_2 := (integer)segment_o * 0.372642648 * ((real)ssn_ms - 0.173768491);

rcvalue79 := glrc79 * sum(rcvalue79_1, rcvalue79_2);

rcvalue97_1 := (integer)(criminal_count > 0 or felony_count > 0) * (integer)segment_d * (-0.656707946 - -0.887026249);

rcvalue97_2 := (integer)segment_d * 1.671106493 * ((real)d_felony_count_cap2_cm - 0.3414795129);

rcvalue97 := (integer)glrc97 * sum(rcvalue97_1, rcvalue97_2);

rcvalue98_1 := (integer)(ver_src_L2 or lien_rec_unrel_flag or lien_hist_unrel_flag) * (integer)segment_d * (-0.656707946 - -0.887026249);

rcvalue98_2 := (integer)segment_d * 1.376461682 * ((real)d_liens_unrel_SC_ct_cap2_cm - 0.3414795129);

rcvalue98 := (integer)glrc98 * sum(rcvalue98_1, rcvalue98_2);

rcvalue99_1 := (integer)segment_y * 3.949758882 * ((real)y_add_bestmatch_level_cm - 0.3332980376);

rcvalue99 := (integer)glrc99 * sum(rcvalue99_1);

rcvalue9a_1 := (integer)segment_d * 1.080649782 * ((real)d_add1_ownership_level_cm - 0.3414795129);

rcvalue9a_2 := (integer)segment_d * 1.385631721 * ((real)d_prop_ownership_cm - 0.341479513);

rcvalue9a_3 := (integer)segment_o * 4.566921146 * ((real)o_add1_ownership_level_cm - 0.0857689961);

rcvalue9a_4 := (integer)segment_o * 10.6052244 * ((real)o_prop_ownership_cm - 0.0857689961);

rcvalue9a_5 := (integer)segment_x * -0.197441075 * ((integer)add2_family_owned - 0.1021300246);

rcvalue9a_6 := (integer)segment_y * 3.991890926 * ((real)y_add1_ownership_level_cm - 0.3332980376);

rcvalue9a := (integer)glrc9a * sum(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3, rcvalue9a_4, rcvalue9a_5, rcvalue9a_6);

rcvalue9c_1 := (integer)segment_x * 1.60278889 * ((real)x_mth_add2_date_last_seen_cm - 0.253364778);

rcvalue9c := glrc9c * sum(rcvalue9c_1);

rcvalue9d_1 := (integer)segment_d * 1.041798077 * ((real)d_addr_count_ge3_cm - 0.341479513);

rcvalue9d_2 := (integer)segment_d * 2.479261477 * ((real)d_addrs_per_ssn_c6_cm - 0.3414795129);

rcvalue9d_3 := (integer)segment_o * 8.188175087 * ((real)o_addrs_15yr_cm - 0.0857689961);

rcvalue9d_4 := (integer)segment_o * 6.959509425 * ((real)o_addrs_per_ssn_c6_cm - 0.085768996);

rcvalue9d_5 := (integer)segment_x * 7.842916717 * ((real)x_addrs_15yr_cm - 0.2533647779);

rcvalue9d_6 := (integer)segment_x * 3.464544845 * ((real)x_addrs_per_ssn_c6_cm - 0.2533647779);

rcvalue9d_7 := (integer)segment_y * 2.917744418 * ((real)y_addr_count_ge3_cm - 0.3332980375);

rcvalue9d_8 := (integer)segment_y * 2.864452527 * ((real)y_addrs_per_ssn_c6_cm - 0.3332980376);

rcvalue9d_9 := (integer)segment_y * 2.648173182 * ((real)y_unique_addr_count_cm - 0.3332980376);

rcvalue9d := (integer)glrc9d * sum(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3, rcvalue9d_4, rcvalue9d_5, rcvalue9d_6, rcvalue9d_7, rcvalue9d_8, rcvalue9d_9);

rcvalue9e_1 := (integer)segment_y * 3.146545218 * ((real)y_ver_src_cnt_cm - 0.3332980375);

rcvalue9e := glrc9e * sum(rcvalue9e_1);

rcvalue9g_1 := (integer)segment_d * 1.240724841 * ((real)d_age_estimate_cm - 0.341479513);

rcvalue9g_2 := (integer)segment_x * 3.286581337 * ((real)x_age_estimate_cm - 0.253364778);

rcvalue9g_3 := (integer)segment_y * (-0.693306016 - -0.887026249);

rcvalue9g_4 := (integer)segment_y * 1.530430976 * ((real)y_age_estimate_cm - 0.3332980376);

rcvalue9g := (integer)glrc9g * sum(rcvalue9g_1, rcvalue9g_2, rcvalue9g_3, rcvalue9g_4);

rcvalue9h_1 := (integer)(impulse_count > 0) * (integer)segment_d * (-0.656707946 - -0.887026249);

rcvalue9h_2 := (integer)segment_d * 0.245774576 * ((real)impulse_flag - 0.0091883348);

rcvalue9h := (integer)glrc9h * sum(rcvalue9h_1, rcvalue9h_2);

rcvalue9i_1 := (integer)segment_x * 4.713678986 * ((real)x_ams_class_cm - 0.2533647779);

rcvalue9i := glrc9i * sum(rcvalue9i_1);

rcvalue9j_1 := (integer)segment_d * 1.146648956 * ((real)d_mth_header_first_seen_cm - 0.341479513);

rcvalue9j := (integer)glrc9j * sum(rcvalue9j_1);

rcvalue9k_1 := (integer)segment_d * 0.161499539 * ((real)add_apt - 0.3000712139);

rcvalue9k_2 := (integer)segment_d * 3.642799437 * ((real)d_add1_land_use_cm - 0.341479513);

rcvalue9k_3 := (integer)segment_o * 0.264340394 * ((real)add_apt - 0.1525787513);

rcvalue9k_4 := (integer)segment_x * 0.0721 * ((real)add_apt - 0.3783722886);

rcvalue9k_5 := (integer)segment_x * 3.4002 * ((real)x_add1_land_use_cm - 0.253364778);

rcvalue9k_6 := (integer)segment_x * 2.841573264 * ((real)x_rc_combo_sec_rangescore100_cm - 0.253364778);

rcvalue9k_7 := (integer)segment_y * 3.451068688 * ((real)y_add1_land_use_cm - 0.3332980375);

rcvalue9k := glrc9k * sum(rcvalue9k_1, rcvalue9k_2, rcvalue9k_3, rcvalue9k_4, rcvalue9k_5, rcvalue9k_6, rcvalue9k_7);

rcvalue9l_1 := (integer)segment_x * 1.782832501 * ((real)x_distance_max_cm - 0.253364778);

rcvalue9l := glrc9l * sum(rcvalue9l_1);

rcvalue9m_1 := (integer)segment_d * -4.13E-6 * ((real)d_estimated_income - 36556.624112);

rcvalue9m_2 := (integer)segment_d * 1.708455986 * ((real)d_watercraft_count_cap2_cm - 0.3414795129);

rcvalue9m_3 := (integer)segment_o * 12.54269212 * ((real)o_watercraft_count_cap2_cm - 0.0857689961);

rcvalue9m_4 := (integer)segment_o * 8.116752691 * ((real)o_wealth_index_cm - 0.0857689961);

rcvalue9m_5 := (integer)segment_x * -0.447552736 * ((real)ver_src_W - 0.0283302289);

rcvalue9m_6 := (integer)segment_x * 3.892913879 * ((real)x_ams_income_level_code_cm - 0.253364778);

rcvalue9m_7 := (integer)segment_x * 2.784785605 * ((real)x_wealth_index_cm - 0.253364778);

rcvalue9m_8 := (integer)segment_y * 1.568032242 * ((real)y_wealth_index_cm - 0.3332980376);

rcvalue9m := (integer)glrc9m * sum(rcvalue9m_1, rcvalue9m_2, rcvalue9m_3, rcvalue9m_4, rcvalue9m_5, rcvalue9m_6, rcvalue9m_7, rcvalue9m_8);

rcvalue9n_1 := (integer)segment_d * 0.828809535 * ((integer)addrs_prison_history - 0.0020148333);

rcvalue9n_2 := (integer)segment_o * 1.207539808 * ((integer)addrs_prison_history - 0.0005471035);

rcvalue9n_3 := (integer)segment_x * 2.1283 * ((integer)addrs_prison_history - 0.0007660878);

rcvalue9n := glrc9n * sum(rcvalue9n_1, rcvalue9n_2, rcvalue9n_3);

rcvalue9o_1 := (integer)segment_d * 3.201721218 * ((real)d_gong_did_phone_ct_cm - 0.341479513);

rcvalue9o_2 := (integer)segment_x * 3.796625749 * ((real)x_gong_did_phone_ct_cm - 0.253364778);

rcvalue9o_3 := (integer)segment_x * 2.123185059 * ((real)x_phones_per_addr_cm - 0.253364778);

rcvalue9o := (integer)glrc9o * sum(rcvalue9o_1, rcvalue9o_2, rcvalue9o_3);

rcvalue9q_1 := (integer)segment_d * 2.627978751 * ((real)d_inq_count12_cm - 0.341479513);

rcvalue9q_2 := (integer)segment_o * 5.417616504 * ((real)o_inq_count12_cm - 0.0857689961);

rcvalue9q_3 := (integer)segment_x * 3.434231467 * ((real)x_inq_count12_cm - 0.2533647779);

rcvalue9q_4 := (integer)segment_y * 3.477470488 * ((real)y_inq_count12_cm - 0.3332980375);

rcvalue9q := (integer)glrc9q * sum(rcvalue9q_1, rcvalue9q_2, rcvalue9q_3, rcvalue9q_4);

rcvalue9r_1 := (integer)segment_d * -0.155242951 * ((real)d_PAW_Source_count_ind - 0.1331353238);

rcvalue9r_2 := (integer)segment_d * 2.714345144 * ((real)d_infutor_nap_grp_cm - 0.341479513);

rcvalue9r_3 := (integer)segment_d * 1.325174213 * ((real)d_mth_ver_src_fdate_WP_cm - 0.3414795129);

rcvalue9r_4 := (integer)segment_o * 4.286678371 * ((real)o_infutor_nap_grp_cm - 0.0857689961);

rcvalue9r_5 := (integer)segment_o * 5.990830641 * ((real)o_mth_fdate_x_ldate_EQ_cm - 0.0857689961);

rcvalue9r_6 := (integer)segment_o * 5.357752917 * ((real)o_mth_fdate_x_ldate_WP_cm - 0.0857689961);

rcvalue9r_7 := (integer)segment_x * 3.711077736 * ((real)x_email_count_cm - 0.253364778);

rcvalue9r_8 := (integer)segment_x * 3.271173567 * ((real)x_infutor_nap_grp_cm - 0.253364778);

rcvalue9r_9 := (integer)segment_x * 2.902210773 * ((real)x_mth_gong_did_first_seen_cm - 0.253364778);

rcvalue9r_10 := (integer)segment_x * 2.918963994 * ((real)x_mth_gong_did_last_seen_cm - 0.253364778);

rcvalue9r_11 := (integer)segment_x * 1.672854469 * ((real)x_mth_ver_src_fdate_WP_cm - 0.253364778);

rcvalue9r_12 := (integer)segment_x * 3.403156533 * ((real)x_mth_ver_src_ldate_P_cm - 0.253364778);

rcvalue9r_13 := (integer)segment_y * -0.30877877 * ((real)y_PAW_Source_count_ind - 0.0202950727);

rcvalue9r_14 := (integer)segment_y * 4.260433001 * ((real)y_email_count_cm - 0.3332980376);

rcvalue9r_15 := (integer)segment_y * 3.667839822 * ((real)y_infutor_nap_grp_cm - 0.3332980376);

rcvalue9r_16 := (integer)segment_y * 2.284187076 * ((real)y_mth_fdate_x_ldate_EQ_cm - 0.3332980376);

rcvalue9r_17 := (integer)segment_y * 3.597519228 * ((real)y_mth_gong_did_first_seen_cm - 0.3332980375);

rcvalue9r := glrc9r * sum(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3, rcvalue9r_4, rcvalue9r_5, rcvalue9r_6, rcvalue9r_7, rcvalue9r_8, rcvalue9r_9, rcvalue9r_10, rcvalue9r_11, rcvalue9r_12, rcvalue9r_13, rcvalue9r_14, rcvalue9r_15, rcvalue9r_16, rcvalue9r_17);

rcvalue9s_1 := (integer)segment_o * 17.51204278 * ((real)o_add1_financing_type_cm - 0.0857689961);

rcvalue9s_2 := (integer)segment_x * 3.765624235 * ((real)x_add1_mortgage_type_risk_cm - 0.253364778);

rcvalue9s_3 := (integer)segment_x * 3.820426519 * ((real)x_add2_mortgage_type_risk_cm - 0.253364778);

rcvalue9s := glrc9s * sum(rcvalue9s_1, rcvalue9s_2, rcvalue9s_3);

rcvalue9t_1 := (integer)segment_d * 0.145927497 * ((real)phn_nap_disconnected - 0.1201257534);

rcvalue9t_2 := (integer)segment_d * 0.541353589 * ((real)phn_nonUs - 0.002952773);

rcvalue9t_3 := (integer)segment_d * 0.206714019 * ((real)phn_notpots - 0.3814114255);

rcvalue9t_4 := (integer)segment_o * 0.109357162 * ((real)no_gong_did_addr - 0.3040422532);

rcvalue9t_5 := (integer)segment_o * 0.167488315 * ((real)phn_high_risk - 0.3169412705);

rcvalue9t_6 := (integer)segment_o * 0.734142358 * ((real)phn_notpots - 0.3112387686);

rcvalue9t_7 := (integer)segment_x * 0.1077 * ((real)no_adls_per_phone - 0.6570480082);

rcvalue9t_8 := (integer)segment_x * 0.2343 * ((real)phn_invalid - 0.0105900379);

rcvalue9t_9 := (integer)segment_x * 0.2329 * ((real)phn_nap_disconnected - 0.1026557712);

rcvalue9t_10 := (integer)segment_x * 0.1637 * ((integer)phn_no_zip_match - 0.037883795);

rcvalue9t_11 := (integer)segment_x * 0.7017 * ((real)phn_nonUs - 0.019783092);

rcvalue9t_12 := (integer)segment_x * 4.502 * ((real)x_telcordia_type_cm - 0.253364778);

rcvalue9t_13 := (integer)segment_y * 0.283957775 * ((real)phn_nap_disconnected - 0.0847451645);

rcvalue9t_14 := (integer)segment_y * 0.612293945 * ((real)phn_nonUs - 0.0058238035);

rcvalue9t := (integer)glrc9t * sum(rcvalue9t_1, rcvalue9t_2, rcvalue9t_3, rcvalue9t_4, rcvalue9t_5, rcvalue9t_6, rcvalue9t_7, rcvalue9t_8, rcvalue9t_9, rcvalue9t_10, rcvalue9t_11, rcvalue9t_12, rcvalue9t_13, rcvalue9t_14);

rcvalue9u_1 := (integer)segment_d * 3.284555915 * ((real)d_add1_advo_address_vacancy_cm - 0.3414795129);

rcvalue9u_2 := (integer)segment_d * 3.241104021 * ((real)d_add1_advo_mixed_addr_usage_cm - 0.341479513);

rcvalue9u_3 := (integer)segment_d * 0.180310826 * ((integer)rc_addrmiskeyflag - 0.0172129297);

rcvalue9u_4 := (integer)segment_o * 6.733147223 * ((real)o_add1_advo_address_vacancy_cm - 0.085768996);

rcvalue9u_5 := (integer)segment_o * 10.02267778 * ((real)o_add1_advo_mixed_addr_usage_cm - 0.0857689961);

rcvalue9u_6 := (integer)segment_o * 8.11383569 * ((real)o_advo_low_risk_cm - 0.0857689961);

rcvalue9u_7 := (integer)segment_x * 0.5399 * ((real)add_zipcitymismatch - 0.0030643514);

rcvalue9u_8 := (integer)segment_x * 3.4062 * ((real)x_add1_advo_address_vacancy_cm - 0.253364778);

rcvalue9u_9 := (integer)segment_x * 3.9725 * ((real)x_add1_advo_mixed_addr_usage_cm - 0.253364778);

rcvalue9u_10 := (integer)segment_y * 2.66366326 * ((real)y_add1_advo_address_vacancy_cm - 0.3332980376);

rcvalue9u_11 := (integer)segment_y * 3.225195728 * ((real)y_add1_advo_mixed_addr_usage_cm - 0.3332980375);

rcvalue9u := (integer)glrc9u * sum(rcvalue9u_1, rcvalue9u_2, rcvalue9u_3, rcvalue9u_4, rcvalue9u_5, rcvalue9u_6, rcvalue9u_7, rcvalue9u_8, rcvalue9u_9, rcvalue9u_10, rcvalue9u_11);

rcvalue9v_1 := (integer)segment_d * -0.4079 * ((real)d_ssn_low_risk - 0.0791690549);

rcvalue9v_2 := (integer)segment_d * 0.6125 * ((real)ssn_priordob - 0.0016327098);

rcvalue9v_3 := (integer)segment_o * -0.288480047 * ((real)o_ssn_low_risk - 0.1305262715);

rcvalue9v_4 := (integer)segment_o * 1.116356235 * ((real)ssn_improper - 0.0074279822);

rcvalue9v_5 := (integer)segment_x * 0.4004 * ((real)ssn_improper - 0.0080213904);

rcvalue9v_6 := (integer)segment_x * 0.8131 * ((real)ssn_priordob - 0.0025085622);

rcvalue9v_7 := (integer)segment_x * -0.4127 * ((real)x_ssn_low_risk - 0.1219732019);

rcvalue9v_8 := (integer)segment_y * 0.391666332 * ((real)lo_combo_ssnscore - 0.0187773542);

rcvalue9v_9 := (integer)segment_y * 0.140957739 * ((real)ssn_adl_prob - 0.1789495976);

rcvalue9v_10 := (integer)segment_y * -0.857194789 * ((real)y_ssn_low_risk - 0.0877100099);

rcvalue9v := (integer)glrc9v * sum(rcvalue9v_1, rcvalue9v_2, rcvalue9v_3, rcvalue9v_4, rcvalue9v_5, rcvalue9v_6, rcvalue9v_7, rcvalue9v_8, rcvalue9v_9, rcvalue9v_10);

rcvalue9w_1 := (integer)((rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0) * (integer)segment_d * (-0.656707946 - -0.887026249);

rcvalue9w_2 := (integer)segment_d * 3.551600965 * ((real)d_disposition_cm - 0.341479513);

rcvalue9w := (integer)glrc9w * sum(rcvalue9w_1, rcvalue9w_2);

rcvalueev_1 := (integer)(attr_eviction_count > 0) * (integer)segment_d * (-0.656707946 - -0.887026249);

rcvalueev_2 := (integer)segment_d * 1.594503303 * ((real)d_mth_attr_date_last_eviction_cm - 0.341479513);

rcvalueev := (integer)glrcev * sum(rcvalueev_1, rcvalueev_2);

rcvaluemi_1 := (integer)segment_d * 0.218043084 * ((real)d_nameperssn_count - 0.0854046167);

rcvaluemi_2 := (integer)segment_o * 0.251606533 * ((real)o_nameperssn_count - 0.0698819519);

rcvaluemi := (integer)glrcmi * sum(rcvaluemi_1, rcvaluemi_2);

rcvaluems_1 := (integer)segment_d * 2.635939453 * ((real)d_ssns_per_adl_c6_cm - 0.341479513);

rcvaluems_2 := (integer)segment_d * 3.505658395 * ((real)d_ssns_per_adl_cm - 0.3414795129);

rcvaluems_3 := (integer)segment_o * 7.005299774 * ((real)o_ssns_per_adl_cm - 0.0857689961);

rcvaluems_4 := (integer)segment_x * 2.547971662 * ((real)x_ssns_per_adl_cm - 0.253364778);

rcvaluems_5 := (integer)segment_y * 3.7211695 * ((real)y_ssns_per_adl_cm - 0.3332980376);

rcvaluems := (integer)glrcms * sum(rcvaluems_1, rcvaluems_2, rcvaluems_3, rcvaluems_4, rcvaluems_5);

rcvaluepv_1 := (integer)segment_d * 3.130827449 * ((real)d_add1_avm_automated_val_cfb_cm - 0.341479513);

rcvaluepv_2 := (integer)segment_o * 8.303866841 * ((real)o_add1_avm_automated_val_cfb_cm - 0.085768996);

rcvaluepv_3 := (integer)segment_x * 2.726543082 * ((real)x_add1_avm_automated_val_cfb_cm - 0.253364778);

rcvaluepv_4 := (integer)segment_x * 2.979829936 * ((real)x_add2_avm_automated_val_cfb_cm - 0.253364778);

rcvaluepv_5 := (integer)segment_y * 3.073545086 * ((real)y_add1_avm_automated_val_cfb_cm - 0.3332980375);




rcvaluepv := glrcpv * sum(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4, rcvaluepv_5);

// ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'16', rcvalue16},
	{'28', rcvalue28},
	{'36', rcvalue36},
	{'49', rcvalue49},
	{'79', rcvalue79},
	{'97', rcvalue97},
	{'98', rcvalue98},
	{'99', rcvalue99},
	{'9A', rcvalue9a},
	{'9C', rcvalue9c},
	{'9D', rcvalue9d},
	{'9E', rcvalue9e},
	{'9G', rcvalue9g},
	{'9H', rcvalue9h},
	{'9I', rcvalue9i},
	{'9J', rcvalue9j},
	{'9K', rcvalue9k},
	{'9L', rcvalue9l},
	{'9M', rcvalue9m},
	{'9N', rcvalue9n},
	{'9O', rcvalue9o},
	{'9Q', rcvalue9q},
	{'9R', rcvalue9r},
	{'9S', rcvalue9s},
	{'9T', rcvalue9t},
	{'9U', rcvalue9u},
	{'9V', rcvalue9v},
	{'9W', rcvalue9w},
	{'EV', rcvalueev},
	{'MI', rcvaluemi},
	{'MS', rcvaluems},
	{'PV', rcvaluepv}
	], ds_layout)(value > 0);

	rcs_top4 := choosen(sort(rc_dataset, -value), 4);

	/* pop rc5 as inquiry if it's triggered and not in rc1-rc4     ***********/
	rcs_9q := rcs_top4 & if( inq_count12 > 0 and 0 = count( rcs_top4( rc='9Q' ) ), dataset( [{'9Q', NULL}], ds_layout ) );


	rcs_9g_9a := map(
		segment_y=1 and 0 = count(rcs_9q) => dataset( [{'9G', NULL}], ds_layout ), // Young segment RC if all RCs missing -- Insufficient Age
		segment_x=1 and 0 = count(rcs_9q) => dataset( [{'9A', NULL}], ds_layout ), // Other segment RC if all RCs missing -- No evidence of Property
		rcs_9q
	);

	rcs_override := map(
		rvt1104_0_0 = 222 => dataset( [{'9X', NULL}], ds_layout ),
		rvt1104_0_0 = 200 => dataset( [{'02', NULL}], ds_layout ),
		0 = count( rcs_9g_9a ) => dataset( [{'36', NULL}], ds_layout ),
		rcs_9g_9a
	);
	

		#if(RVT_DEBUG)
			self.clam := le;
			self.truedid := truedid;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.rc_non_us_ssn := rc_non_us_ssn;
			self.rc_combo_sec_rangescore := rc_combo_sec_rangescore;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_addrmiskeyflag := rc_addrmiskeyflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_cityzipflag := rc_cityzipflag;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_dobcount := combo_dobcount;
			self.ver_sources := ver_sources;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_sources_last_seen := ver_sources_last_seen;
			self.ver_sources_count := ver_sources_count;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_advo_seasonal_delivery := add1_advo_seasonal_delivery;
			self.add1_advo_dnd := add1_advo_dnd;
			self.add1_advo_college := add1_advo_college;
			self.add1_advo_mixed_address_usage := add1_advo_mixed_address_usage;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_land_use_code := add1_land_use_code;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add2_isbestmatch := add2_isbestmatch;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_med_fips := add2_avm_med_fips;
			self.add2_avm_med_geo11 := add2_avm_med_geo11;
			self.add2_avm_med_geo12 := add2_avm_med_geo12;
			self.add2_family_owned := add2_family_owned;
			self.add2_mortgage_type := add2_mortgage_type;
			self.add2_date_last_seen := add2_date_last_seen;
			self.addrs_15yr := addrs_15yr;
			self.addrs_prison_history := addrs_prison_history;
			self.unique_addr_count := unique_addr_count;
			self.addr_count_ge3 := addr_count_ge3;
			self.telcordia_type := telcordia_type;
			self.recent_disconnects := recent_disconnects;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_last_seen := gong_did_last_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_addr_ct := gong_did_addr_ct;
			self.nameperssn_count := nameperssn_count;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.inq_count12 := inq_count12;
			self.paw_source_count := paw_source_count;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.attr_num_proflic60 := attr_num_proflic60;
			self.bankrupt := bankrupt;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.watercraft_count := watercraft_count;
			self.ams_class := ams_class;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_flag := prof_license_flag;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.estimated_income := estimated_income;
			self.archive_date                     := archive_date;
			self.in_dob2                          := in_dob2;
			self.yr_in_dob                        := yr_in_dob;
			self.add2_date_last_seen2             := add2_date_last_seen2;
			self.mth_add2_date_last_seen          := mth_add2_date_last_seen;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mth_attr_date_last_eviction      := mth_attr_date_last_eviction;
			self.header_first_seen2               := header_first_seen2;
			self.mth_header_first_seen            := mth_header_first_seen;
			self.gong_did_first_seen2             := gong_did_first_seen2;
			self.mth_gong_did_first_seen          := mth_gong_did_first_seen;
			self.gong_did_last_seen2              := gong_did_last_seen2;
			self.mth_gong_did_last_seen           := mth_gong_did_last_seen;
			self.ver_src_cnt                      := ver_src_cnt;
			self.ver_src_am_pos                   := ver_src_am_pos;
			self.ver_src_am                       := ver_src_am;
			self.ver_src_ba_pos                   := ver_src_ba_pos;
			self.ver_src_ba                       := ver_src_ba;
			self.ver_src_ds_pos                   := ver_src_ds_pos;
			self.ver_src_ds                       := ver_src_ds;
			self.ver_src_eq_pos                   := ver_src_eq_pos;
			self.ver_src_fdate_eq                 := ver_src_fdate_eq;
			self.ver_src_fdate_eq2                := ver_src_fdate_eq2;
			self.mth_ver_src_fdate_eq             := mth_ver_src_fdate_eq;
			self.ver_src_ldate_eq                 := ver_src_ldate_eq;
			self.ver_src_ldate_eq2                := ver_src_ldate_eq2;
			self.mth_ver_src_ldate_eq             := mth_ver_src_ldate_eq;
			self.ver_src_l2_pos                   := ver_src_l2_pos;
			self.ver_src_l2                       := ver_src_l2;
			self.ver_src_li_pos                   := ver_src_li_pos;
			self.ver_src_li                       := ver_src_li;
			self.ver_src_p_pos                    := ver_src_p_pos;
			self.ver_src_ldate_p                  := ver_src_ldate_p;
			self.ver_src_ldate_p2                 := ver_src_ldate_p2;
			self.mth_ver_src_ldate_p              := mth_ver_src_ldate_p;
			self.ver_src_vo_pos                   := ver_src_vo_pos;
			self.ver_src_cnt_vo                   := ver_src_cnt_vo;
			self.ver_src_w_pos                    := ver_src_w_pos;
			self.ver_src_w                        := ver_src_w;
			self.ver_src_wp_pos                   := ver_src_wp_pos;
			self.ver_src_fdate_wp                 := ver_src_fdate_wp;
			self.ver_src_fdate_wp2                := ver_src_fdate_wp2;
			self.mth_ver_src_fdate_wp             := mth_ver_src_fdate_wp;
			self.ver_src_ldate_wp                 := ver_src_ldate_wp;
			self.ver_src_ldate_wp2                := ver_src_ldate_wp2;
			self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.impulse_flag                     := impulse_flag;
			self.attr_derog_flag                  := attr_derog_flag;
			self.lien_flag                        := lien_flag;
			self.attr_eviction_flag               := attr_eviction_flag;
			self.bk_flag                          := bk_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.add1_avm_med                     := add1_avm_med;
			self.add2_avm_med                     := add2_avm_med;
			self.add1_land_use_code2              := add1_land_use_code2;
			self.add_bestmatch_level              := add_bestmatch_level;
			self.prop_ownership                   := prop_ownership;
			self.ssn_adl_prob                     := ssn_adl_prob;
			self.dist2_a1toa2                     := dist2_a1toa2;
			self.dist2_a1toa3                     := dist2_a1toa3;
			self.dist2_a2toa3                     := dist2_a2toa3;
			self.distance_max                     := distance_max;
			self.property_owner                   := property_owner;
			self.impulse_count_min2               := impulse_count_min2;
			self.yr_in_dob_int                    := yr_in_dob_int;
			self.age_estimate                     := age_estimate;
			self.bs_attr_derog_flag2              := bs_attr_derog_flag2;
			self.no222score                       := no222score;
			self.segment40                        := segment40;
			self.no_adls_per_phone                := no_adls_per_phone;
			self.phn_nap_disconnected             := phn_nap_disconnected;
			self.phn_notpots                      := phn_notpots;
			self.no_gong_did_addr                 := no_gong_did_addr;
			self.phn_high_risk                    := phn_high_risk;
			self.phn_recent_disconnect            := phn_recent_disconnect;
			self.phn_invalid                      := phn_invalid;
			self.phn_nonus                        := phn_nonus;
			self.phn_no_zip_match                 := phn_no_zip_match;
			self.ssn_priordob                     := ssn_priordob;
			self.ssn_improper                     := ssn_improper;
			self.lo_combo_ssnscore                := lo_combo_ssnscore;
			self.add_apt                          := add_apt;
			self.add_inval                        := add_inval;
			self.add_zipcitymismatch              := add_zipcitymismatch;
			self.d_age_estimate                   := d_age_estimate;
			self.d_nap_nas                        := d_nap_nas;
			self.d_rc_disthphoneaddr              := d_rc_disthphoneaddr;
			self.d_combo_dobcount                 := d_combo_dobcount;
			self.d_mth_ver_src_fdate_wp           := d_mth_ver_src_fdate_wp;
			self.d_add1_avm_med_mm                := d_add1_avm_med_mm;
			self.d_add1_avm_automated_val         := d_add1_avm_automated_val;
			self.d_add1_avm_automated_val_cf      := d_add1_avm_automated_val_cf;
			self.d_add1_avm_automated_val_cfb     := d_add1_avm_automated_val_cfb;
			self.d_addr_count_ge3                 := d_addr_count_ge3;
			self.d_gong_did_phone_ct              := d_gong_did_phone_ct;
			self.d_nameperssn_count               := d_nameperssn_count;
			self.d_mth_header_first_seen          := d_mth_header_first_seen;
			self.d_ssns_per_adl                   := d_ssns_per_adl;
			self.d_ssns_per_adl_c6                := d_ssns_per_adl_c6;
			self.d_addrs_per_ssn_c6               := d_addrs_per_ssn_c6;
			self.d_vo_addrs_per_adl               := d_vo_addrs_per_adl;
			self.d_inq_count12                    := d_inq_count12;
			self.d_paw_source_count_ind           := d_paw_source_count_ind;
			self.d_infutor_nap_grp                := d_infutor_nap_grp;
			self.d_ams_college_tier               := d_ams_college_tier;
			self.d_estimated_income               := d_estimated_income;
			self.d_add1_land_use                  := d_add1_land_use;
			self.d_ssn_low_risk                   := d_ssn_low_risk;
			self.d_add1_advo_address_vacancy      := d_add1_advo_address_vacancy;
			self.d_add1_advo_mixed_addr_usage     := d_add1_advo_mixed_addr_usage;
			self.d_prop_ownership                 := d_prop_ownership;
			self.d_add1_ownership_level           := d_add1_ownership_level;
			self.d_watercraft_count_cap2          := d_watercraft_count_cap2;
			self.d_attr_total_number_derogs       := d_attr_total_number_derogs;
			self.d_mth_attr_date_last_eviction    := d_mth_attr_date_last_eviction;
			self.d_disposition                    := d_disposition;
			self.d_felony_count_cap2              := d_felony_count_cap2;
			self.d_liens_unrel_sc_ct_cap2         := d_liens_unrel_sc_ct_cap2;
			self.d_add1_advo_mixed_addr_usage_cm  := d_add1_advo_mixed_addr_usage_cm;
			self.d_add1_avm_automated_val_cfb_cm  := d_add1_avm_automated_val_cfb_cm;
			self.d_addr_count_ge3_cm              := d_addr_count_ge3_cm;
			self.d_addrs_per_ssn_c6_cm            := d_addrs_per_ssn_c6_cm;
			self.d_ams_college_tier_cm            := d_ams_college_tier_cm;
			self.d_combo_dobcount_cm              := d_combo_dobcount_cm;
			self.d_gong_did_phone_ct_cm           := d_gong_did_phone_ct_cm;
			self.d_mth_header_first_seen_cm       := d_mth_header_first_seen_cm;
			self.d_mth_ver_src_fdate_wp_cm        := d_mth_ver_src_fdate_wp_cm;
			self.d_nap_nas_cm                     := d_nap_nas_cm;
			self.d_ssns_per_adl_cm                := d_ssns_per_adl_cm;
			self.d_ssns_per_adl_c6_cm             := d_ssns_per_adl_c6_cm;
			self.d_vo_addrs_per_adl_cm            := d_vo_addrs_per_adl_cm;
			self.d_felony_count_cap2_cm           := d_felony_count_cap2_cm;
			self.d_infutor_nap_grp_cm             := d_infutor_nap_grp_cm;
			self.d_liens_unrel_sc_ct_cap2_cm      := d_liens_unrel_sc_ct_cap2_cm;
			self.d_watercraft_count_cap2_cm       := d_watercraft_count_cap2_cm;
			self.d_inq_count12_cm                 := d_inq_count12_cm;
			self.d_add1_ownership_level_cm        := d_add1_ownership_level_cm;
			self.d_age_estimate_cm                := d_age_estimate_cm;
			self.d_attr_total_number_derogs_cm    := d_attr_total_number_derogs_cm;
			self.d_disposition_cm                 := d_disposition_cm;
			self.d_mth_attr_date_last_eviction_cm := d_mth_attr_date_last_eviction_cm;
			self.d_prop_ownership_cm              := d_prop_ownership_cm;
			self.d_add1_land_use_cm               := d_add1_land_use_cm;
			self.d_add1_advo_address_vacancy_cm   := d_add1_advo_address_vacancy_cm;
			self.dmod_phn_prob                    := dmod_phn_prob;
			self.dmod_ssn_prob                    := dmod_ssn_prob;
			self.dmod_add_prob02                  := dmod_add_prob02;
			self.dmod02                           := dmod02;
			self.d_phat                           := d_phat;
			self.y_age_estimate                   := y_age_estimate;
			self.y_nap_nas                        := y_nap_nas;
			self.y_did_count                      := y_did_count;
			self.y_ver_src_cnt                    := y_ver_src_cnt;
			self.y_add1_avm_med_mm                := y_add1_avm_med_mm;
			self.y_add1_avm_automated_val         := y_add1_avm_automated_val;
			self.y_add1_avm_automated_val_cf      := y_add1_avm_automated_val_cf;
			self.y_add1_avm_automated_val_cfb     := y_add1_avm_automated_val_cfb;
			self.y_unique_addr_count              := y_unique_addr_count;
			self.y_addr_count_ge3                 := y_addr_count_ge3;
			self.y_mth_gong_did_first_seen        := y_mth_gong_did_first_seen;
			self.y_ssns_per_adl                   := y_ssns_per_adl;
			self.y_addrs_per_ssn_c6               := y_addrs_per_ssn_c6;
			self.y_inq_count12                    := y_inq_count12;
			self.y_paw_source_count_ind           := y_paw_source_count_ind;
			self.y_infutor_nap_grp                := y_infutor_nap_grp;
			self.y_email_count                    := y_email_count;
			self.y_ams_college_tier               := y_ams_college_tier;
			self.y_wealth_index                   := y_wealth_index;
			self.y_add_bestmatch_level            := y_add_bestmatch_level;
			self.y_add1_land_use                  := y_add1_land_use;
			self.y_telcordia_type                 := y_telcordia_type;
			self.y_ssn_low_risk                   := y_ssn_low_risk;
			self.y_add1_advo_address_vacancy      := y_add1_advo_address_vacancy;
			self.y_add1_advo_mixed_addr_usage     := y_add1_advo_mixed_addr_usage;
			self.y_mth_ver_src_fdate_eq           := y_mth_ver_src_fdate_eq;
			self.y_mth_ver_src_ldate_eq           := y_mth_ver_src_ldate_eq;
			self.y_mth_fdate_x_ldate_eq           := y_mth_fdate_x_ldate_eq;
			self.y_add1_ownership_level           := y_add1_ownership_level;
			self.y_add_bestmatch_level_cm         := y_add_bestmatch_level_cm;
			self.y_add1_advo_mixed_addr_usage_cm  := y_add1_advo_mixed_addr_usage_cm;
			self.y_add1_avm_automated_val_cfb_cm  := y_add1_avm_automated_val_cfb_cm;
			self.y_addr_count_ge3_cm              := y_addr_count_ge3_cm;
			self.y_addrs_per_ssn_c6_cm            := y_addrs_per_ssn_c6_cm;
			self.y_ams_college_tier_cm            := y_ams_college_tier_cm;
			self.y_mth_fdate_x_ldate_eq_cm        := y_mth_fdate_x_ldate_eq_cm;
			self.y_nap_nas_cm                     := y_nap_nas_cm;
			self.y_ssns_per_adl_cm                := y_ssns_per_adl_cm;
			self.y_unique_addr_count_cm           := y_unique_addr_count_cm;
			self.y_wealth_index_cm                := y_wealth_index_cm;
			self.y_infutor_nap_grp_cm             := y_infutor_nap_grp_cm;
			self.y_inq_count12_cm                 := y_inq_count12_cm;
			self.y_add1_ownership_level_cm        := y_add1_ownership_level_cm;
			self.y_age_estimate_cm                := y_age_estimate_cm;
			self.y_ver_src_cnt_cm                 := y_ver_src_cnt_cm;
			self.y_add1_land_use_cm               := y_add1_land_use_cm;
			self.y_add1_advo_address_vacancy_cm   := y_add1_advo_address_vacancy_cm;
			self.y_did_count_cm                   := y_did_count_cm;
			self.y_email_count_cm                 := y_email_count_cm;
			self.y_mth_gong_did_first_seen_cm     := y_mth_gong_did_first_seen_cm;
			self.ymod_phn_prob                    := ymod_phn_prob;
			self.ymod_add_prob                    := ymod_add_prob;
			self.ymod_ssn_prob                    := ymod_ssn_prob;
			self.ymod02                           := ymod02;
			self.y_phat                           := y_phat;
			self.o_nap_nas                        := o_nap_nas;
			self.o_did_count                      := o_did_count;
			self.o_rc_disthphoneaddr              := o_rc_disthphoneaddr;
			self.o_combo_dobcount                 := o_combo_dobcount;
			self.o_mth_ver_src_fdate_wp           := o_mth_ver_src_fdate_wp;
			self.o_mth_ver_src_ldate_wp           := o_mth_ver_src_ldate_wp;
			self.o_mth_fdate_x_ldate_wp           := o_mth_fdate_x_ldate_wp;
			self.o_add1_avm_med_mm                := o_add1_avm_med_mm;
			self.o_add1_avm_automated_val         := o_add1_avm_automated_val;
			self.o_add1_avm_automated_val_cf      := o_add1_avm_automated_val_cf;
			self.o_add1_avm_automated_val_cfb     := o_add1_avm_automated_val_cfb;
			self.o_addrs_15yr                     := o_addrs_15yr;
			self.o_nameperssn_count               := o_nameperssn_count;
			self.o_ssns_per_adl                   := o_ssns_per_adl;
			self.o_addrs_per_ssn_c6               := o_addrs_per_ssn_c6;
			self.o_vo_addrs_per_adl               := o_vo_addrs_per_adl;
			self.o_inq_count12                    := o_inq_count12;
			self.o_infutor_nap_grp                := o_infutor_nap_grp;
			self.o_ams_college_tier               := o_ams_college_tier;
			self.o_wealth_index                   := o_wealth_index;
			self.o_prof_license_category          := o_prof_license_category;
			self.o_ssn_low_risk                   := o_ssn_low_risk;
			self.o_add1_advo_address_vacancy      := o_add1_advo_address_vacancy;
			self.o_advo_low_risk                  := o_advo_low_risk;
			self.o_add1_advo_mixed_addr_usage     := o_add1_advo_mixed_addr_usage;
			self.o_mth_ver_src_fdate_eq           := o_mth_ver_src_fdate_eq;
			self.o_mth_ver_src_ldate_eq           := o_mth_ver_src_ldate_eq;
			self.o_mth_fdate_x_ldate_eq           := o_mth_fdate_x_ldate_eq;
			self.o_prop_ownership                 := o_prop_ownership;
			self.o_add1_ownership_level           := o_add1_ownership_level;
			self.o_add1_financing_type            := o_add1_financing_type;
			self.o_watercraft_count_cap2          := o_watercraft_count_cap2;
			self.o_add1_advo_mixed_addr_usage_cm  := o_add1_advo_mixed_addr_usage_cm;
			self.o_add1_avm_automated_val_cfb_cm  := o_add1_avm_automated_val_cfb_cm;
			self.o_add1_financing_type_cm         := o_add1_financing_type_cm;
			self.o_addrs_15yr_cm                  := o_addrs_15yr_cm;
			self.o_addrs_per_ssn_c6_cm            := o_addrs_per_ssn_c6_cm;
			self.o_ams_college_tier_cm            := o_ams_college_tier_cm;
			self.o_combo_dobcount_cm              := o_combo_dobcount_cm;
			self.o_mth_fdate_x_ldate_eq_cm        := o_mth_fdate_x_ldate_eq_cm;
			self.o_nap_nas_cm                     := o_nap_nas_cm;
			self.o_prof_license_category_cm       := o_prof_license_category_cm;
			self.o_ssns_per_adl_cm                := o_ssns_per_adl_cm;
			self.o_vo_addrs_per_adl_cm            := o_vo_addrs_per_adl_cm;
			self.o_wealth_index_cm                := o_wealth_index_cm;
			self.o_infutor_nap_grp_cm             := o_infutor_nap_grp_cm;
			self.o_watercraft_count_cap2_cm       := o_watercraft_count_cap2_cm;
			self.o_inq_count12_cm                 := o_inq_count12_cm;
			self.o_add1_ownership_level_cm        := o_add1_ownership_level_cm;
			self.o_prop_ownership_cm              := o_prop_ownership_cm;
			self.o_advo_low_risk_cm               := o_advo_low_risk_cm;
			self.o_add1_advo_address_vacancy_cm   := o_add1_advo_address_vacancy_cm;
			self.o_did_count_cm                   := o_did_count_cm;
			self.o_mth_fdate_x_ldate_wp_cm        := o_mth_fdate_x_ldate_wp_cm;
			self.omod_phn_prob                    := omod_phn_prob;
			self.omod_ssn_prob                    := omod_ssn_prob;
			self.omod_add_prob                    := omod_add_prob;
			self.omod03                           := omod03;
			self.o_phat                           := o_phat;
			self.x_age_estimate                   := x_age_estimate;
			self.ssn_ms                           := ssn_ms;
			self.x_nap_nas                        := x_nap_nas;
			self.x_did_count                      := x_did_count;
			self.x_rc_combo_sec_rangescore100     := x_rc_combo_sec_rangescore100;
			self.x_mth_ver_src_fdate_wp           := x_mth_ver_src_fdate_wp;
			self.x_add1_avm_med_mm                := x_add1_avm_med_mm;
			self.x_add1_avm_automated_val         := x_add1_avm_automated_val;
			self.x_add1_avm_automated_val_cf      := x_add1_avm_automated_val_cf;
			self.x_add1_avm_automated_val_cfb     := x_add1_avm_automated_val_cfb;
			self.x_add1_mortgage_type_risk        := x_add1_mortgage_type_risk;
			self.x_distance_max                   := x_distance_max;
			self.x_add2_avm_med_mm                := x_add2_avm_med_mm;
			self.x_add2_avm_automated_val         := x_add2_avm_automated_val;
			self.x_add2_avm_automated_val_cf      := x_add2_avm_automated_val_cf;
			self.x_add2_avm_automated_val_cfb     := x_add2_avm_automated_val_cfb;
			self.x_add2_mortgage_type_risk        := x_add2_mortgage_type_risk;
			self.x_mth_add2_date_last_seen        := x_mth_add2_date_last_seen;
			self.x_addrs_15yr                     := x_addrs_15yr;
			self.x_mth_gong_did_first_seen        := x_mth_gong_did_first_seen;
			self.x_mth_gong_did_last_seen         := x_mth_gong_did_last_seen;
			self.x_gong_did_phone_ct              := x_gong_did_phone_ct;
			self.x_ssns_per_adl                   := x_ssns_per_adl;
			self.x_ssns_per_addr                  := x_ssns_per_addr;
			self.x_phones_per_addr                := x_phones_per_addr;
			self.x_addrs_per_ssn_c6               := x_addrs_per_ssn_c6;
			self.x_ssns_per_addr_c6               := x_ssns_per_addr_c6;
			self.x_adls_per_phone_c6              := x_adls_per_phone_c6;
			self.x_inq_count12                    := x_inq_count12;
			self.x_infutor_nap_grp                := x_infutor_nap_grp;
			self.x_email_count                    := x_email_count;
			self.x_attr_num_proflic60_ind         := x_attr_num_proflic60_ind;
			self.x_ams_class                      := x_ams_class;
			self.x_ams_income_level_code          := x_ams_income_level_code;
			self.x_wealth_index                   := x_wealth_index;
			self.x_input_dob_match_level          := x_input_dob_match_level;
			self.x_mth_ver_src_ldate_p            := x_mth_ver_src_ldate_p;
			self.x_ver_src_cnt_vo                 := x_ver_src_cnt_vo;
			self.x_add1_land_use                  := x_add1_land_use;
			self.x_telcordia_type                 := x_telcordia_type;
			self.x_ssn_low_risk                   := x_ssn_low_risk;
			self.x_add1_advo_address_vacancy      := x_add1_advo_address_vacancy;
			self.x_add1_advo_mixed_address_usage  := x_add1_advo_mixed_address_usage;
			self.x_age_estimate_cm                := x_age_estimate_cm;
			self.x_nap_nas_cm                     := x_nap_nas_cm;
			self.x_did_count_cm                   := x_did_count_cm;
			self.x_mth_ver_src_fdate_wp_cm        := x_mth_ver_src_fdate_wp_cm;
			self.x_add1_advo_address_vacancy_cm   := x_add1_advo_address_vacancy_cm;
			self.x_add1_advo_mixed_addr_usage_cm  := x_add1_advo_mixed_addr_usage_cm;
			self.x_add1_avm_automated_val_cfb_cm  := x_add1_avm_automated_val_cfb_cm;
			self.x_add1_mortgage_type_risk_cm     := x_add1_mortgage_type_risk_cm;
			self.x_distance_max_cm                := x_distance_max_cm;
			self.x_add2_mortgage_type_risk_cm     := x_add2_mortgage_type_risk_cm;
			self.x_mth_add2_date_last_seen_cm     := x_mth_add2_date_last_seen_cm;
			self.x_addrs_15yr_cm                  := x_addrs_15yr_cm;
			self.x_telcordia_type_cm              := x_telcordia_type_cm;
			self.x_mth_gong_did_first_seen_cm     := x_mth_gong_did_first_seen_cm;
			self.x_mth_gong_did_last_seen_cm      := x_mth_gong_did_last_seen_cm;
			self.x_gong_did_phone_ct_cm           := x_gong_did_phone_ct_cm;
			self.x_ssns_per_adl_cm                := x_ssns_per_adl_cm;
			self.x_ssns_per_addr_cm               := x_ssns_per_addr_cm;
			self.x_phones_per_addr_cm             := x_phones_per_addr_cm;
			self.x_addrs_per_ssn_c6_cm            := x_addrs_per_ssn_c6_cm;
			self.x_ssns_per_addr_c6_cm            := x_ssns_per_addr_c6_cm;
			self.x_adls_per_phone_c6_cm           := x_adls_per_phone_c6_cm;
			self.x_infutor_nap_grp_cm             := x_infutor_nap_grp_cm;
			self.x_email_count_cm                 := x_email_count_cm;
			self.x_attr_num_proflic60_ind_cm      := x_attr_num_proflic60_ind_cm;
			self.x_ams_class_cm                   := x_ams_class_cm;
			self.x_ams_income_level_code_cm       := x_ams_income_level_code_cm;
			self.x_wealth_index_cm                := x_wealth_index_cm;
			self.x_input_dob_match_level_cm       := x_input_dob_match_level_cm;
			self.x_rc_combo_sec_rangescore100_cm  := x_rc_combo_sec_rangescore100_cm;
			self.x_mth_ver_src_ldate_p_cm         := x_mth_ver_src_ldate_p_cm;
			self.x_add2_avm_automated_val_cfb_cm  := x_add2_avm_automated_val_cfb_cm;
			self.x_ver_src_cnt_vo_cm              := x_ver_src_cnt_vo_cm;
			self.x_inq_count12_cm                 := x_inq_count12_cm;
			self.x_add1_land_use_cm               := x_add1_land_use_cm;
			self.xmod_phn_prob                    := xmod_phn_prob;
			self.xmod_ssn_prob                    := xmod_ssn_prob;
			self.xmod_add_prob                    := xmod_add_prob;
			self.xmod01                           := xmod01;
			self.x_phat                           := x_phat;
			self.ov_ssnprior                      := ov_ssnprior;
			self.ov_criminal_flag                 := ov_criminal_flag;
			self.ov_corrections                   := ov_corrections;
			self.ov_impulse                       := ov_impulse;
			self.rvt1104_0_0                      := rvt1104_0_0;
			
			self.segment_d                        := segment_d;
			self.segment_y                        := segment_y;
			self.segment_o                        := segment_o;
			self.segment_x                        := segment_x;
			self.glrc9c                           := glrc9c;
			self.glrc9k                           := glrc9k;
			self.glrc9l                           := glrc9l;
			self.glrc9n                           := glrc9n;
			self.glrc9a                           := glrc9a;
			self.glrc9e                           := glrc9e;
			self.glrc9t                           := glrc9t;
			self.glrc9u                           := glrc9u;
			self.glrc9v                           := glrc9v;
			self.glrc3                            := glrc3;
			self.glrc7                            := glrc7;
			self.glrc16                           := glrc16;
			self.glrc20                           := glrc20;
			self.glrc25                           := glrc25;
			self.glrc26                           := glrc26;
			self.glrc27                           := glrc27;
			self.glrc28                           := glrc28;
			self.glrc36                           := glrc36;
			self.glrc37                           := glrc37;
			self.glrc49                           := glrc49;
			self.glrc74                           := glrc74;
			self.glrc79                           := glrc79;
			self.glrc97                           := glrc97;
			self.glrc98                           := glrc98;
			self.glrc99                           := glrc99;
			self.glrc9d                           := glrc9d;
			self.glrc9g                           := glrc9g;
			self.glrc9h                           := glrc9h;
			self.glrc9i                           := glrc9i;
			self.glrc9j                           := glrc9j;
			self.glrc9o                           := glrc9o;
			self.glrc9q                           := glrc9q;
			self.glrc9s                           := glrc9s;
			self.glrcev                           := glrcev;
			self.glrcmi                           := glrcmi;
			self.glrcms                           := glrcms;
			self.aptflag                          := aptflag;
			self.add1_econval                     := add1_econval;
			self.add1_aptval                      := add1_aptval;
			self.add1_econcode                    := add1_econcode;
			self.glrcpv                           := glrcpv;
			self.glrc9m                           := glrc9m;
			self.glrc9r                           := glrc9r;
			self.glrc9w                           := glrc9w;
			self.rcvalue16_1                      := rcvalue16_1;
			self.rcvalue16_2                      := rcvalue16_2;
			self.rcvalue16                        := rcvalue16;
			self.rcvalue28_1                      := rcvalue28_1;
			self.rcvalue28_2                      := rcvalue28_2;
			self.rcvalue28_3                      := rcvalue28_3;
			self.rcvalue28                        := rcvalue28;
			self.rcvalue36_1                      := rcvalue36_1;
			self.rcvalue36_2                      := rcvalue36_2;
			self.rcvalue36_3                      := rcvalue36_3;
			self.rcvalue36_4                      := rcvalue36_4;
			self.rcvalue36_5                      := rcvalue36_5;
			self.rcvalue36_6                      := rcvalue36_6;
			self.rcvalue36_7                      := rcvalue36_7;
			self.rcvalue36_8                      := rcvalue36_8;
			self.rcvalue36_9                      := rcvalue36_9;
			self.rcvalue36_10                     := rcvalue36_10;
			self.rcvalue36_11                     := rcvalue36_11;
			self.rcvalue36                        := rcvalue36;
			self.rcvalue49_1                      := rcvalue49_1;
			self.rcvalue49_2                      := rcvalue49_2;
			self.rcvalue49                        := rcvalue49;
			self.rcvalue79_1                      := rcvalue79_1;
			self.rcvalue79_2                      := rcvalue79_2;
			self.rcvalue79                        := rcvalue79;
			self.rcvalue97_1                      := rcvalue97_1;
			self.rcvalue97_2                      := rcvalue97_2;
			self.rcvalue97                        := rcvalue97;
			self.rcvalue98_1                      := rcvalue98_1;
			self.rcvalue98_2                      := rcvalue98_2;
			self.rcvalue98                        := rcvalue98;
			self.rcvalue99_1                      := rcvalue99_1;
			self.rcvalue99                        := rcvalue99;
			self.rcvalue9a_1                      := rcvalue9a_1;
			self.rcvalue9a_2                      := rcvalue9a_2;
			self.rcvalue9a_3                      := rcvalue9a_3;
			self.rcvalue9a_4                      := rcvalue9a_4;
			self.rcvalue9a_5                      := rcvalue9a_5;
			self.rcvalue9a_6                      := rcvalue9a_6;
			self.rcvalue9a                        := rcvalue9a;
			self.rcvalue9c_1                      := rcvalue9c_1;
			self.rcvalue9c                        := rcvalue9c;
			self.rcvalue9d_1                      := rcvalue9d_1;
			self.rcvalue9d_2                      := rcvalue9d_2;
			self.rcvalue9d_3                      := rcvalue9d_3;
			self.rcvalue9d_4                      := rcvalue9d_4;
			self.rcvalue9d_5                      := rcvalue9d_5;
			self.rcvalue9d_6                      := rcvalue9d_6;
			self.rcvalue9d_7                      := rcvalue9d_7;
			self.rcvalue9d_8                      := rcvalue9d_8;
			self.rcvalue9d_9                      := rcvalue9d_9;
			self.rcvalue9d                        := rcvalue9d;
			self.rcvalue9e_1                      := rcvalue9e_1;
			self.rcvalue9e                        := rcvalue9e;
			self.rcvalue9g_1                      := rcvalue9g_1;
			self.rcvalue9g_2                      := rcvalue9g_2;
			self.rcvalue9g_3                      := rcvalue9g_3;
			self.rcvalue9g_4                      := rcvalue9g_4;
			self.rcvalue9g                        := rcvalue9g;
			self.rcvalue9h_1                      := rcvalue9h_1;
			self.rcvalue9h_2                      := rcvalue9h_2;
			self.rcvalue9h                        := rcvalue9h;
			self.rcvalue9i_1                      := rcvalue9i_1;
			self.rcvalue9i                        := rcvalue9i;
			self.rcvalue9j_1                      := rcvalue9j_1;
			self.rcvalue9j                        := rcvalue9j;
			self.rcvalue9k_1                      := rcvalue9k_1;
			self.rcvalue9k_2                      := rcvalue9k_2;
			self.rcvalue9k_3                      := rcvalue9k_3;
			self.rcvalue9k_4                      := rcvalue9k_4;
			self.rcvalue9k_5                      := rcvalue9k_5;
			self.rcvalue9k_6                      := rcvalue9k_6;
			self.rcvalue9k_7                      := rcvalue9k_7;
			self.rcvalue9k                        := rcvalue9k;
			self.rcvalue9l_1                      := rcvalue9l_1;
			self.rcvalue9l                        := rcvalue9l;
			self.rcvalue9m_1                      := rcvalue9m_1;
			self.rcvalue9m_2                      := rcvalue9m_2;
			self.rcvalue9m_3                      := rcvalue9m_3;
			self.rcvalue9m_4                      := rcvalue9m_4;
			self.rcvalue9m_5                      := rcvalue9m_5;
			self.rcvalue9m_6                      := rcvalue9m_6;
			self.rcvalue9m_7                      := rcvalue9m_7;
			self.rcvalue9m_8                      := rcvalue9m_8;
			self.rcvalue9m                        := rcvalue9m;
			self.rcvalue9n_1                      := rcvalue9n_1;
			self.rcvalue9n_2                      := rcvalue9n_2;
			self.rcvalue9n_3                      := rcvalue9n_3;
			self.rcvalue9n                        := rcvalue9n;
			self.rcvalue9o_1                      := rcvalue9o_1;
			self.rcvalue9o_2                      := rcvalue9o_2;
			self.rcvalue9o_3                      := rcvalue9o_3;
			self.rcvalue9o                        := rcvalue9o;
			self.rcvalue9q_1                      := rcvalue9q_1;
			self.rcvalue9q_2                      := rcvalue9q_2;
			self.rcvalue9q_3                      := rcvalue9q_3;
			self.rcvalue9q_4                      := rcvalue9q_4;
			self.rcvalue9q                        := rcvalue9q;
			self.rcvalue9r_1                      := rcvalue9r_1;
			self.rcvalue9r_2                      := rcvalue9r_2;
			self.rcvalue9r_3                      := rcvalue9r_3;
			self.rcvalue9r_4                      := rcvalue9r_4;
			self.rcvalue9r_5                      := rcvalue9r_5;
			self.rcvalue9r_6                      := rcvalue9r_6;
			self.rcvalue9r_7                      := rcvalue9r_7;
			self.rcvalue9r_8                      := rcvalue9r_8;
			self.rcvalue9r_9                      := rcvalue9r_9;
			self.rcvalue9r_10                     := rcvalue9r_10;
			self.rcvalue9r_11                     := rcvalue9r_11;
			self.rcvalue9r_12                     := rcvalue9r_12;
			self.rcvalue9r_13                     := rcvalue9r_13;
			self.rcvalue9r_14                     := rcvalue9r_14;
			self.rcvalue9r_15                     := rcvalue9r_15;
			self.rcvalue9r_16                     := rcvalue9r_16;
			self.rcvalue9r_17                     := rcvalue9r_17;
			self.rcvalue9r                        := rcvalue9r;
			self.rcvalue9s_1                      := rcvalue9s_1;
			self.rcvalue9s_2                      := rcvalue9s_2;
			self.rcvalue9s_3                      := rcvalue9s_3;
			self.rcvalue9s                        := rcvalue9s;
			self.rcvalue9t_1                      := rcvalue9t_1;
			self.rcvalue9t_2                      := rcvalue9t_2;
			self.rcvalue9t_3                      := rcvalue9t_3;
			self.rcvalue9t_4                      := rcvalue9t_4;
			self.rcvalue9t_5                      := rcvalue9t_5;
			self.rcvalue9t_6                      := rcvalue9t_6;
			self.rcvalue9t_7                      := rcvalue9t_7;
			self.rcvalue9t_8                      := rcvalue9t_8;
			self.rcvalue9t_9                      := rcvalue9t_9;
			self.rcvalue9t_10                     := rcvalue9t_10;
			self.rcvalue9t_11                     := rcvalue9t_11;
			self.rcvalue9t_12                     := rcvalue9t_12;
			self.rcvalue9t_13                     := rcvalue9t_13;
			self.rcvalue9t_14                     := rcvalue9t_14;
			self.rcvalue9t                        := rcvalue9t;
			self.rcvalue9u_1                      := rcvalue9u_1;
			self.rcvalue9u_2                      := rcvalue9u_2;
			self.rcvalue9u_3                      := rcvalue9u_3;
			self.rcvalue9u_4                      := rcvalue9u_4;
			self.rcvalue9u_5                      := rcvalue9u_5;
			self.rcvalue9u_6                      := rcvalue9u_6;
			self.rcvalue9u_7                      := rcvalue9u_7;
			self.rcvalue9u_8                      := rcvalue9u_8;
			self.rcvalue9u_9                      := rcvalue9u_9;
			self.rcvalue9u_10                     := rcvalue9u_10;
			self.rcvalue9u_11                     := rcvalue9u_11;
			self.rcvalue9u                        := rcvalue9u;
			self.rcvalue9v_1                      := rcvalue9v_1;
			self.rcvalue9v_2                      := rcvalue9v_2;
			self.rcvalue9v_3                      := rcvalue9v_3;
			self.rcvalue9v_4                      := rcvalue9v_4;
			self.rcvalue9v_5                      := rcvalue9v_5;
			self.rcvalue9v_6                      := rcvalue9v_6;
			self.rcvalue9v_7                      := rcvalue9v_7;
			self.rcvalue9v_8                      := rcvalue9v_8;
			self.rcvalue9v_9                      := rcvalue9v_9;
			self.rcvalue9v_10                     := rcvalue9v_10;
			self.rcvalue9v                        := rcvalue9v;
			self.rcvalue9w_1                      := rcvalue9w_1;
			self.rcvalue9w_2                      := rcvalue9w_2;
			self.rcvalue9w                        := rcvalue9w;
			self.rcvalueev_1                      := rcvalueev_1;
			self.rcvalueev_2                      := rcvalueev_2;
			self.rcvalueev                        := rcvalueev;
			self.rcvaluemi_1                      := rcvaluemi_1;
			self.rcvaluemi_2                      := rcvaluemi_2;
			self.rcvaluemi                        := rcvaluemi;
			self.rcvaluems_1                      := rcvaluems_1;
			self.rcvaluems_2                      := rcvaluems_2;
			self.rcvaluems_3                      := rcvaluems_3;
			self.rcvaluems_4                      := rcvaluems_4;
			self.rcvaluems_5                      := rcvaluems_5;
			self.rcvaluems                        := rcvaluems;
			self.rcvaluepv_1                      := rcvaluepv_1;
			self.rcvaluepv_2                      := rcvaluepv_2;
			self.rcvaluepv_3                      := rcvaluepv_3;
			self.rcvaluepv_4                      := rcvaluepv_4;
			self.rcvaluepv_5                      := rcvaluepv_5;
			self.rcvaluepv                        := rcvaluepv;
			
			rc1 := rcs_override[1].rc;
			rc2 := rcs_override[2].rc;
			rc3 := rcs_override[3].rc;
			rc4 := rcs_override[4].rc;
			rc5 := rcs_override[5].rc;

			rc1_value := rcs_override[1].value;
			rc2_value := rcs_override[2].value;
			rc3_value := rcs_override[3].value;
			rc4_value := rcs_override[4].value;
			rc5_value := rcs_override[5].value;
			self.rc1                              := rc1;
			self.rc2                              := rc2;
			self.rc3                              := rc3;
			self.rc4                              := rc4;
			self.rc5                              := rc5;
			self.rc1_value                        := rc1_value;
			self.rc2_value                        := rc2_value;
			self.rc3_value                        := rc3_value;
			self.rc4_value                        := rc4_value;
			self.rc5_value                        := rc5_value;

			self.rc_dataset := rc_dataset;
			self.rcs_top4 := rcs_top4;
			self.rcs_9q := rcs_9q;
			self.rcs_9g_9a := rcs_9g_9a;
			self.rcs_override := rcs_override;
			
self.addrpop := addrpop;
self.hphnpop := hphnpop;
self.dobpop := dobpop;
self.add2_naprop := add2_naprop;
self.add3_naprop := add3_naprop;
self.add2_applicant_owned := add2_applicant_owned;
self.add3_applicant_owned := add3_applicant_owned;
self.add3_family_owned := add3_family_owned;
self.property_ambig_total := property_ambig_total;
self.ssnlength := ssnlength;
self.in_zipcode := in_zipcode;
self.attr_addrs_last12 := attr_addrs_last12;
self.add1_eda_sourced := add1_eda_sourced;
self.adlperssn_count := adlperssn_count;
self.add1_assessed_total_value := add1_assessed_total_value;

		#end
		
		self.seq := le.seq;		
		riTemp := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		rcs_final := project( rcs_override, transform( risk_indicators.Layout_Desc,
			self.hri := left.rc,
			self.desc := risk_indicators.getHRIDesc(left.rc)
		));


		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		PrescreenOptOut := xmlPrescreenOptOut or risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
		ri := map(
			riTemp[1].hri <> '00' => riTemp,
			risk_indicators.rcSet.isCode95(PreScreenOptOut) => DATASET([{'95',risk_indicators.getHRIDesc('95')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			inCalif => DATASET([{'35',risk_indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			rcs_final
		);
		zeros := dataset( [ {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc);
		self.ri := choosen( ri & zeros, 5 );

		self.score := map(
			riTemp[1].hri in ['91','92','93','94'] => (string3)((integer)riTemp[1].hri + 10),
			risk_indicators.rcSet.isCode95(PreScreenOptOut) => '222',
			self.ri[1].hri='35' => '100',
			(string3)rvt1104_0_0
		);
	end;
	
	model := project( clam, doModel(left) );
	return model;
end;

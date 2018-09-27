import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVR1103_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia=false, boolean xmlPreScreenOptOut=false ) := FUNCTION

	RVR_DEBUG := false;

	#if(RVR_DEBUG)
	debug_layout := record
		risk_indicators.Layout_Boca_Shell clam;
		Boolean trueDID;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String nap_status;
		Boolean rc_input_addr_not_most_recent;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_pwssnvalflag;
		Integer rc_ssnlowissue;
		String rc_addrvalflag;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_addrcommflag;
		String rc_hrisksic;
		String rc_hrisksicphone;
		Integer rc_disthphoneaddr;
		String rc_phonetype;
		Boolean rc_fnamessnmatch;
		Integer combo_hphonescore;
		Integer combo_ssnscore;
		Integer combo_dobscore;
		Integer combo_hphonecount;
		qstring100 ver_sources;
		qstring100 ver_sources_NAS;
		qstring200 ver_sources_first_seen;
		qstring200 ver_sources_last_seen;
		qstring100 ver_addr_sources;
		qstring100 ver_dob_sources;
		String SSNLength;
		Boolean dobpop;
		String fname_eda_sourced_type;
		String lname_eda_sourced_type;
		Boolean add1_house_number_match;
		Boolean add1_isbestmatch;
		String add1_advo_address_vacancy;
		String add1_advo_throw_back;
		String add1_advo_seasonal_delivery;
		String add1_advo_college;
		String add1_advo_drop;
		String add1_advo_res_or_business;
		String add1_advo_mixed_address_usage;
		Integer add1_avm_automated_valuation;
		Boolean add1_eda_sourced;
		Boolean add1_applicant_owned;
		Boolean add1_occupant_owned;
		Boolean add1_family_owned;
		Integer ADD1_NAPROP;
		Integer add1_purchase_date;
		Integer add1_built_date;
		String add1_financing_type;
		Integer add1_date_first_seen;
		Integer PROPERTY_OWNED_TOTAL;
		Integer property_owned_purchase_count;
		Integer property_owned_assessed_count;
		Integer PROPERTY_SOLD_TOTAL;
		Integer PROPERTY_SOLD_PURCHASE_COUNT;
		Integer property_sold_assessed_count;
		Integer PROPERTY_AMBIG_TOTAL;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer ADD2_NAPROP;
		Integer ADD3_NAPROP;
		Integer addrs_5yr;
		Integer unique_addr_count;
		Integer avg_mo_per_addr;
		Integer addr_count_ge3;
		Boolean addr_hist_advo_college;
		String telcordia_type;
		String gong_did_first_seen;
		Integer namePerSSN_count;
		Integer header_first_seen;
		Integer ssns_per_adl;
		Integer addrs_per_adl;
		Integer phones_per_adl;
		Integer adlPerSSN_count;
		Integer addrs_per_ssn;
		Integer ssns_per_addr;
		Integer phones_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer lnames_per_adl_c6;
		Integer addrs_per_ssn_c6;
		Integer adls_per_addr_c6;
		Integer ssns_per_addr_c6;
		Integer phones_per_addr_c6;
		Integer invalid_phones_per_adl_c6;
		Integer invalid_addrs_per_adl_c6;
		Integer INQ_COUNT;
		Integer inq_count06;
		Integer inq_banking_count06;
		Integer inq_peradl;
		Integer inq_adlsperaddr;
		Integer inq_ssnsperaddr;
		Integer inq_perphone;
		Integer inq_adlsperphone;
		qstring100 paw_company_title;
		Integer infutor_first_seen;
		Integer infutor_nap;
		Integer impulse_count;
		Integer email_count;
		Integer email_domain_free_count;
		qstring50 email_source_list;
		Integer attr_addrs_last12;
		Integer attr_addrs_last24;
		Integer attr_addrs_last36;
		Integer attr_date_first_purchase;
		Integer attr_num_sold60;
		Integer attr_num_aircraft;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Integer attr_date_last_eviction;
		Integer attr_num_nonderogs;
		Integer attr_num_nonderogs180;
		Boolean Bankrupt;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		String liens_last_unrel_date;
		Integer liens_unrel_cj_ct;
		Integer liens_unrel_cj_last_seen;
		Integer liens_rel_cj_ct;
		Integer liens_unrel_lt_ct;
		Integer liens_unrel_lt_last_seen;
		Integer liens_rel_lt_ct;
		Integer liens_unrel_sc_ct;
		Integer liens_unrel_sc_last_seen;
		Integer criminal_count;
		Integer criminal_last_date;
		Integer felony_last_date;
		Integer watercraft_count;
		String ams_age;
		String ams_college_code;
		String ams_college_type;
		String ams_income_level_code;
		String ams_college_tier;
		String prof_license_category;
		String input_dob_match_level;
		Integer inferred_age;
		Integer estimated_income;
		Integer archive_date;
		Integer sysdate;
		Integer in_dob2;
		Real4 yr_in_dob;
		Integer rc_ssnlowissue2;
		Integer add1_purchase_date2;
		Real4 mth_add1_purchase_date;
		Integer add1_built_date2;
		Real4 mth_add1_built_date;
		Integer add1_date_first_seen2;
		Real4 mth_add1_date_first_seen;
		Integer gong_did_first_seen2;
		Real4 mth_gong_did_first_seen;
		Integer header_first_seen2;
		Real4 mth_header_first_seen;
		Integer infutor_first_seen2;
		Real4 mth_infutor_first_seen;
		Integer attr_date_first_purchase2;
		Real4 mth_attr_date_first_purchase;
		Integer attr_date_last_eviction2;
		Real4 yr_attr_date_last_eviction;
		Integer liens_last_unrel_date2;
		Real4 yr_liens_last_unrel_date;
		Integer liens_unrel_cj_last_seen2;
		Real4 yr_liens_unrel_cj_last_seen;
		Integer liens_unrel_lt_last_seen2;
		Real4 yr_liens_unrel_lt_last_seen;
		Integer liens_unrel_sc_last_seen2;
		Real4 yr_liens_unrel_sc_last_seen;
		Integer criminal_last_date2;
		Real4 yr_criminal_last_date;
		Integer felony_last_date2;
		Real4 yr_felony_last_date;
		Integer ver_src_cnt;
		Integer ver_src_ar_pos;
		Boolean ver_src_ar;
		Integer ver_src_ba_pos;
		Boolean ver_src_ba;
		Integer ver_src_ds_pos;
		Boolean ver_src_ds;
		Integer ver_src_eb_pos;
		Boolean ver_src_eb;
		Integer ver_src_eq_pos;
		Boolean ver_src_eq;
		String ver_src_fdate_eq;
		Integer ver_src_fdate_eq2;
		Real4 mth_ver_src_fdate_eq;
		Integer ver_src_en_pos;
		Boolean ver_src_en;
		String ver_src_fdate_en;
		Integer ver_src_fdate_en2;
		Real4 mth_ver_src_fdate_en;
		Integer ver_src_p_pos;
		Real4 ver_src_nas_p;
		Integer ver_src_li_pos;
		Boolean ver_src_li;
		String ver_src_ldate_li;
		Integer ver_src_ldate_li2;
		Real4 mth_ver_src_ldate_li;
		Integer ver_src_l2_pos;
		Boolean ver_src_l2;
		String ver_src_ldate_l2;
		Integer ver_src_ldate_l22;
		Real4 mth_ver_src_ldate_l2;
		Integer ver_src_ts_pos;
		String ver_src_fdate_ts;
		Integer ver_src_fdate_ts2;
		Real4 mth_ver_src_fdate_ts;
		Integer ver_src_w_pos;
		Boolean ver_src_w;
		Integer ver_src_wp_pos;
		String ver_src_fdate_wp;
		Integer ver_src_fdate_wp2;
		Real4 mth_ver_src_fdate_wp;
		Integer ver_addr_src_ak_pos;
		Boolean ver_addr_src_ak;
		Integer ver_addr_src_am_pos;
		Boolean ver_addr_src_am;
		Integer ver_addr_src_ar_pos;
		Boolean ver_addr_src_ar;
		Integer ver_addr_src_cg_pos;
		Boolean ver_addr_src_cg;
		Integer ver_addr_src_eb_pos;
		Boolean ver_addr_src_eb;
		Integer ver_addr_src_eq_pos;
		Boolean ver_addr_src_eq;
		Integer ver_addr_src_en_pos;
		Boolean ver_addr_src_en;
		Integer ver_addr_src_em_pos;
		Boolean ver_addr_src_em;
		Integer ver_addr_src_e1_pos;
		Boolean ver_addr_src_e1;
		Integer ver_addr_src_e2_pos;
		Boolean ver_addr_src_e2;
		Integer ver_addr_src_e3_pos;
		Boolean ver_addr_src_e3;
		Integer ver_addr_src_e4_pos;
		Boolean ver_addr_src_e4;
		Integer ver_addr_src_pl_pos;
		Boolean ver_addr_src_pl;
		Integer ver_addr_src_vo_pos;
		Boolean ver_addr_src_vo;
		Integer ver_addr_src_w_pos;
		Boolean ver_addr_src_w;
		Integer ver_addr_src_wp_pos;
		Boolean ver_addr_src_wp;
		Integer ver_dob_src_ak_pos;
		Boolean ver_dob_src_ak;
		Integer ver_dob_src_am_pos;
		Boolean ver_dob_src_am;
		Integer ver_dob_src_ar_pos;
		Boolean ver_dob_src_ar;
		Integer ver_dob_src_cg_pos;
		Boolean ver_dob_src_cg;
		Integer ver_dob_src_eb_pos;
		Boolean ver_dob_src_eb;
		Integer ver_dob_src_eq_pos;
		Boolean ver_dob_src_eq;
		Integer ver_dob_src_en_pos;
		Boolean ver_dob_src_en;
		Integer ver_dob_src_em_pos;
		Boolean ver_dob_src_em;
		Integer ver_dob_src_e1_pos;
		Boolean ver_dob_src_e1;
		Integer ver_dob_src_e2_pos;
		Boolean ver_dob_src_e2;
		Integer ver_dob_src_e3_pos;
		Boolean ver_dob_src_e3;
		Integer ver_dob_src_e4_pos;
		Boolean ver_dob_src_e4;
		Integer ver_dob_src_pl_pos;
		Boolean ver_dob_src_pl;
		Integer ver_dob_src_vo_pos;
		Boolean ver_dob_src_vo;
		Integer ver_dob_src_w_pos;
		Boolean ver_dob_src_w;
		Integer ver_dob_src_wp_pos;
		Boolean ver_dob_src_wp;
		Integer email_src_cnt;
		Boolean add_apt;
		// Boolean phn_highrisk2;
		// Boolean phn_notpots;
		// Boolean phn_correction;
		Boolean ssn_issued18;
		Boolean ssn_deceased;
		Real4 ssn_lowissue_age;
		Integer Prop_Owner;
		Integer add_naprop_level;
		Integer add1_ownership;
		Boolean bk_flag;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean lien_flag;
		Integer pk_property_owner;
		Integer pk_impulse_count;
		Integer pk_yr_in_dob;
		Integer pk_age_estimate;
		Integer bs_attr_derog_flag;
		Integer bs_attr_eviction_flag;
		Integer bs_attr_derog_flag2;
		Boolean scored_222s;
		Integer pk_222_flag;
		String pk_segment_40;
		Integer pk_age_estimate_s1;
		Integer pk_age_estimate_s2;
		Integer pk_age_estimate_s3;
		// Integer pk_estimated_income_s0;
		Integer pk_estimated_income_s1;
		Integer pk_estimated_income_s2;
		// Integer pk_estimated_income_s3;
		Integer pk_add1_avm_auto_val_s1;
		Integer pk_add1_avm_auto_val_s2;
		Integer pk_add1_avm_auto_val_s3;
		Integer pk_combo_hphonescore;
		Integer pk_combo_ssnscore;
		Integer pk_combo_dobscore;
		Integer pk_hphn_score_ver;
		Integer pk_ssn_score_ver;
		Integer pk_dob_score_ver;
		Integer nas_summary_ver;
		Integer pk_nap_summary_ver;
		Integer pk_rc_fnamessnmatch;
		Integer pk_add1_house_number_match;
		Integer eda_sourced_level;
		Integer pk_infutor_nap;
		Integer pk_input_dob_match_level;
		Integer pk_ams_age;
		Integer pk_ams_4yr_college;
		Integer pk_ams_college_type;
		Integer pk_ams_income_level_code;
		Integer pk_ams_college_tier;
		Integer pk_combo_hphonecount;
		Integer pk_attr_num_nonderogs;
		Integer pk_attr_num_nonderogs180;
		Integer pk_email_count;
		Integer pk_email_domain_free_count;
		Integer pk_email_src_cnt;
		Integer pk_paw_company_title;
		Integer pk_prof_license_category;
		Integer pk_pos_addr_src_minor;
		Boolean pk_pos_addr_src_minor_flag;
		Integer pk_pos_dob_src_minor;
		Boolean pk_pos_dob_src_minor_flag;
		Boolean ver_src_bureau;
		Boolean ver_addr_src_bureau;
		Boolean ver_dob_src_bureau;
		Integer ver_addr_src_emerge;
		Integer ver_dob_src_emerge;
		Integer pk_pos_addr_src_major;
		Integer pk_pos_dob_src_major;
		Integer pk_pos_addr_src_cnt;
		Integer pk_pos_dob_src_cnt;
		Integer pk_bureau_only;
		Integer pk_mth_gong_did_first_seen;
		Integer pk_mth_gong_did_first_seen2;
		Integer pk_mth_header_first_seen;
		Integer pk_mth_header_first_seen2_s0;
		Integer pk_mth_header_first_seen2_s2;
		Integer pk_mth_header_first_seen2_s3;
		Integer pk_mth_infutor_first_seen;
		Integer pk_mth_infutor_first_seen2;
		Integer pk_mth_ver_src_fdate_en;
		Integer pk_mth_ver_src_fdate_eq;
		Integer pk_mth_ver_src_fdate_ts;
		Integer pk_mth_ver_src_fdate_wp;
		Integer pk_mth_ver_src_fdate_bureau;
		Integer pk_mth_ver_src_fdate_ts2;
		Integer pk_mth_ver_src_fdate_wp2_s3;
		Boolean time_on_cb_gt_age;
		Integer pk_time_on_bureau_120;
		Integer pk_time_on_cb_120b_s0;
		Integer pk_time_on_cb_120b_s1;
		Integer pk_time_on_cb_120b_s2;
		Integer pk_time_on_cb_120b_s3;
		Boolean pk_addr_hist_advo_college;
		Integer pk_mth_add1_purchase_date;
		Integer pk_mth_add1_built_date;
		Integer pk_mth_add1_date_first_seen;
		Integer pk_mth_attr_date_first_purchase;
		Integer pk_adj_finance;
		Integer pk_prop_owned_purch_flag;
		Integer pk_prop_owned_assess_flag;
		Integer pk_prop_sold_purch_flag;
		Integer pk_prop_sold_assess_flag;
		Integer pk_prop_owned_sold_lvl;
		Integer pk_ver_src_nas_p_lvl;
		Boolean pk_boat_plane_flag;
		Integer pk_property_owned_total;
		Integer pk_property_sold_total;
		Integer pk_prop_os_tot_tree;
		Integer pk_attr_num_sold60;
		Integer pk_addrs_5yr_s0;
		Integer pk_unique_addr_count_s0;
		Integer pk_avg_mo_per_addr_s0;
		Integer pk_addr_count_ge3_s0;
		Integer pk_mth_add1_dt_f_sn_s0;
		Integer pk_ver_src_nas_p_lvl_s0;
		Integer pk_prop_os_tot_tree_s0;
		Integer pk_unique_addr_count_s1;
		Integer pk_avg_mo_per_addr_s1;
		Integer pk_addr_count_ge3_s1;
		Integer pk_add_naprop_level_s1;
		Integer pk_mth_add1_built_date_s1;
		Integer pk_mth_add1_dt_f_sn_s1;
		Integer pk_addrs_5yr_s2;
		Integer pk_avg_mo_per_addr_s2;
		Integer pk_add1_ownership_s2;
		Integer pk_mth_add1_purchase_date_s2;
		Integer pk_mth_attr_dt_first_prch_s2;
		Integer pk_prop_owned_sold_lvl_s2;
		Integer pk_ver_src_nas_p_lvl_s2;
		Integer pk_avg_mo_per_addr_s3;
		Integer pk_addr_count_ge3_s3;
		Integer pk_mth_add1_dt_f_sn_s3;
		Integer pk_ver_src_nas_p_lvl_s3;
		Integer pk_yr_criminal_last_date;
		Integer pk_yr_felony_last_date;
		Integer pk_yr_attr_date_last_eviction;
		Integer pk_yr_liens_last_unrel_date;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk_yr_liens_unrel_lt_last_seen;
		Integer pk_yr_liens_unrel_sc_last_seen;
		Integer pk_mth_ver_src_ldate_l2;
		Integer pk_mth_ver_src_ldate_li;
		Integer pk_yr_criminal_last_date2;
		Integer pk_yr_felony_last_date2;
		Integer pk_crim_fel_date;
		Integer pk_yr_attr_dt_last_evict2;
		Integer pk_liens_unrel_cj_ct;
		Integer pk_liens_rel_cj_ct;
		Integer pk_liens_unrel_lt_ct;
		Integer pk_liens_rel_lt_ct;
		Integer pk_liens_unrel_sc_ct;
		Integer pk_lien_tree;
		Integer pk_unrel_last_sn_dt;
		Integer pk_ver_src_ldate_lien;
		Integer pk_ver_src_ldate_lien2;
		Integer pk_unrel_last_sn_dt2;
		Integer inq_hit;
		Integer pk_inq_banking_count06_s2;
		Integer pk_inq_banking_count06_s3;
		Integer pk_inq_count06_s1;
		Integer pk_inq_peradl;
		Integer pk_inq_adlsperaddr_s2;
		Integer pk_inq_ssnsperaddr;
		Integer pk_inq_perphone_s1;
		Integer pk_inq_perphone_s2;
		Integer pk_inq_adlsperphone_s3;
		// Integer pk_dist_a1toa2;
		// Integer pk_dist_a1toa3_s1;
		Integer pk_per_adl_tree2;
		Integer pk_addrs_per_ssn_c6;
		Integer pk_adls_per_addr_c6_s0;
		Integer pk_adls_per_addr_c6_s1;
		Integer pk_ssns_per_addr_c6_s2;
		Integer pk_ssns_per_addr_c6_s3;
		Integer pk_phones_per_addr_c6_s0;
		Integer pk_phones_per_addr_c6_s1;
		Integer pk_phones_per_addr_c6_s3;
		Integer pk_attr_addrs_last12;
		Integer pk_addr_adl_tree;
		Integer pk_ssns_per_adl_s1;
		Integer pk_ssns_per_adl_s2;
		Integer pk_ssns_per_adl_s3;
		Integer pk_addrs_per_adl_s0;
		Integer pk_phones_per_adl_s3;
		Integer pk_nameperssn_count;
		Integer pk_adlperssn_count_s1;
		Integer pk_adlperssn_count_s3;
		Integer pk_addrs_per_ssn_s1;
		Integer pk_addrs_per_ssn_s2;
		Integer pk_addrs_per_ssn_s3;
		Integer pk_ssns_per_addr_s1;
		Integer pk_ssns_per_addr_s2;
		Integer pk_ssns_per_addr_s3;
		Integer pk_phones_per_addr_s3;
		Integer pk_adls_per_phone_s1;
		Integer pk_adls_per_phone_s2;
		Integer pk_adls_per_phone_s3;
		// Integer pk_add_inval;
		// Integer pk_add_hirisk_comm;
		// Integer pk_advo_no_hit;
		// Integer pk_add1_advo_address_vacancy;
		// Integer pk_add1_advo_throw_back;
		// Integer pk_add1_advo_seasonal_delivery;
		// Integer pk_add1_advo_college;
		// Integer pk_add1_advo_drop;
		// Integer pk_add1_advo_res_or_business;
		// Integer pk_add1_advo_mixed_address_usage;
		// Boolean pk_invalid_addrs_per_adl_c6;
		// Integer pk_addprob_s2;
		// Integer pk_rc_disthphoneaddr_s0;
		// Integer pk_phn_cell;
		// Integer pk_phn_pager;
		// Integer pk_phn_pcs;
		// Integer pk_phn_disconnect;
		// Integer pk_phn_cell2;
		// Integer pk_phn_pager2;
		// Integer pk_phn_pcs2;
		// Integer pk_phn_payphone;
		// Integer pk_phn_fax;
		// Integer pk_phn_invalid;
		// Integer pk_phn_usage_unknown;
		// Integer pk_phn_invalid2;
		// Integer pk_phn_notpots;
		// Integer pk_phn_usage_unknown2;
		// Integer pk_phn_phnzipmismatch;
		// Integer pk_phn_phnzipmismatch2;
		// Integer pk_phn_phn_not_issued;
		// Integer pk_phn_nonus;
		// Integer pk_phn_pager3;
		// Integer pk_phn_cell3;
		// Integer pk_phn_cell4;
		// Integer pk_phn_pager4;
		// Integer pk_phn_mobile;
		// Integer pk_phn_cpm;
		// Integer pk_phn_cell5;
		// Integer pk_phn_pager5;
		// Integer pk_phn_mobile2;
		// Integer pk_phn_cpm2;
		// Integer pk_phn_pcs3;
		// Integer pk_phn_pcs4;
		// Integer pk_phn_pcs5;
		// Integer pk_phn_pcs6;
		// Integer pk_phn_pcs7;
		// Integer pk_phn_cpm_flag;
		// Integer pk_phn_pcs_flag;
		// Integer pk_phn_phnzipmis_flag;
		// Integer pk_phn_notpots_flag;
		// Integer pk_phn_invalid_flag;
		// Integer pk_phnprob_s2;
		// Integer pk_phnprob2_s2;
		Integer pk_ssn_lowissue_age;
		Integer pk_ssn_lowissue_age2_s0;
		Integer pk_ssn_lowissue_age2_s1;
		Integer pk_dist_a1toa2_b;
		Real4 pk_dist_a1toa2_b_1m;
		Real4 pk_dist_a1toa2_b_2m;
		Real4 pk_age_estimate_s1_1m;
		Real4 pk_age_estimate_s2_2m;
		Real4 pk_age_estimate_s3_3m;
		Real4 pk_crim_fel_date_0m;
		Real4 pk_yr_attr_dt_last_evict2_0m;
		Real4 pk_lien_tree_0m;
		Real4 pk_unrel_last_sn_dt2_0m;
		// Real4 pk_estimated_income_s0_0m;
		Real4 pk_estimated_income_s1_1m;
		Real4 pk_add1_avm_auto_val_s1_1m;
		Real4 pk_estimated_income_s2_2m;
		Real4 pk_add1_avm_auto_val_s2_2m;
		// Real4 pk_estimated_income_s3_3m;
		Real4 pk_add1_avm_auto_val_s3_3m;
		Real4 pk_addrs_5yr_s0_0m;
		Real4 pk_unique_addr_count_s0_0m;
		Real4 pk_avg_mo_per_addr_s0_0m;
		Real4 pk_addr_count_ge3_s0_0m;
		Real4 pk_mth_add1_dt_f_sn_s0_0m;
		Real4 pk_ver_src_nas_p_lvl_s0_0m;
		Real4 pk_prop_os_tot_tree_s0_0m;
		Real4 pk_unique_addr_count_s1_1m;
		Real4 pk_avg_mo_per_addr_s1_1m;
		Real4 pk_addr_count_ge3_s1_1m;
		Real4 pk_add_naprop_level_s1_1m;
		Real4 pk_mth_add1_built_date_s1_1m;
		Real4 pk_mth_add1_dt_f_sn_s1_1m;
		Real4 pk_addrs_5yr_s2_2m;
		Real4 pk_avg_mo_per_addr_s2_2m;
		Real4 pk_add1_ownership_s2_2m;
		Real4 pk_mth_add1_purchase_date_s2_2m;
		Real4 pk_mth_attr_dt_first_prch_s2_2m;
		Real4 pk_prop_owned_sold_lvl_s2_2m;
		Real4 pk_ver_src_nas_p_lvl_s2_2m;
		Real4 pk_avg_mo_per_addr_s3_3m;
		Real4 pk_addr_count_ge3_s3_3m;
		Real4 pk_mth_add1_dt_f_sn_s3_3m;
		Real4 pk_ver_src_nas_p_lvl_s3_3m;
		Real4 pk_impulse_count_0m;
		Real4 pk_inq_peradl_0m;
		Real4 pk_inq_ssnsperaddr_0m;
		Real4 pk_inq_count06_s1_1m;
		Real4 pk_inq_ssnsperaddr_1m;
		Real4 pk_inq_perphone_s1_1m;
		Real4 pk_inq_banking_count06_s2_2m;
		Real4 pk_inq_adlsperaddr_s2_2m;
		Real4 pk_inq_perphone_s2_2m;
		Real4 pk_inq_banking_count06_s3_3m;
		Real4 pk_inq_ssnsperaddr_3m;
		Real4 pk_inq_adlsperphone_s3_3m;
		Real4 pk_addrs_per_adl_s0_0m;
		Real4 pk_ssns_per_adl_s1_1m;
		Real4 pk_adlperssn_count_s1_1m;
		Real4 pk_addrs_per_ssn_s1_1m;
		Real4 pk_ssns_per_addr_s1_1m;
		Real4 pk_adls_per_phone_s1_1m;
		Real4 pk_ssns_per_adl_s2_2m;
		Real4 pk_addrs_per_ssn_s2_2m;
		Real4 pk_ssns_per_addr_s2_2m;
		Real4 pk_adls_per_phone_s2_2m;
		Real4 pk_ssns_per_adl_s3_3m;
		Real4 pk_phones_per_adl_s3_3m;
		Real4 pk_nameperssn_count_3m;
		Real4 pk_adlperssn_count_s3_3m;
		Real4 pk_addrs_per_ssn_s3_3m;
		Real4 pk_ssns_per_addr_s3_3m;
		Real4 pk_phones_per_addr_s3_3m;
		Real4 pk_adls_per_phone_s3_3m;
		Real4 pk_addr_adl_tree_0m;
		Real4 pk_addrs_per_ssn_c6_0m;
		Real4 pk_adls_per_addr_c6_s0_0m;
		Real4 pk_phones_per_addr_c6_s0_0m;
		Real4 pk_addr_adl_tree_1m;
		Real4 pk_addrs_per_ssn_c6_1m;
		Real4 pk_adls_per_addr_c6_s1_1m;
		Real4 pk_phones_per_addr_c6_s1_1m;
		Real4 pk_addrs_per_ssn_c6_2m;
		Real4 pk_ssns_per_addr_c6_s2_2m;
		Real4 pk_addr_adl_tree_3m;
		Real4 pk_addrs_per_ssn_c6_3m;
		Real4 pk_ssns_per_addr_c6_s3_3m;
		Real4 pk_phones_per_addr_c6_s3_3m;
		// Real4 pk_dist_a1toa2_0m;
		// Real4 pk_dist_a1toa2_1m;
		// Real4 pk_dist_a1toa3_s1_1m;
		// Real4 pk_rc_disthphoneaddr_s0_0m;
		Real4 pk_ssn_lowissue_age2_s0_0m;
		Real4 pk_ssn_lowissue_age2_s1_1m;
		Real4 ssn_issued18_1m;
		Real4 ssn_issued18_2m;
		// Real4 pk_addprob_s2_2m;
		// Real4 pk_phnprob2_s2_2m;
		Real4 ssn_issued18_3m;
		Real4 pk_add1_house_number_match_0mn;
		Real4 eda_sourced_level_0mn;
		Real4 pk_infutor_nap_0mn;
		Real4 pk_input_dob_match_level_0mn;
		Real4 pk_ams_4yr_college_0mn;
		Real4 pk_attr_num_nonderogs180_0mn;
		Real4 pk_email_count_0mn;
		Real4 pk_email_domain_free_count_0mn;
		Real4 pk_combo_hphonecount_0mn;
		Real4 pk_mth_header_first_seen2_s0_0mn;
		Real4 pk_mth_ver_src_fdate_ts2_0mn;
		Real4 pk_time_on_cb_120b_s0_0mn;
		Real4 pk_dob_score_ver_1mn;
		Real4 nas_summary_ver_1mn;
		Real4 pk_nap_summary_ver_1mn;
		Real4 eda_sourced_level_1mn;
		Real4 pk_infutor_nap_1mn;
		Real4 pk_ams_age_1mn;
		Real4 pk_ams_income_level_code_1mn;
		Real4 pk_ams_college_tier_1mn;
		Real4 pk_attr_num_nonderogs180_1mn;
		Real4 pk_email_count_1mn;
		Real4 pk_paw_company_title_1mn;
		Real4 pk_mth_gong_did_first_seen2_1mn;
		Real4 pk_mth_infutor_first_seen2_1mn;
		Real4 pk_time_on_cb_120b_s1_1mn;
		Real4 pk_hphn_score_ver_2mn;
		Real4 eda_sourced_level_2mn;
		Real4 pk_ams_4yr_college_2mn;
		Real4 pk_ams_college_tier_2mn;
		Real4 pk_pos_addr_src_cnt_2mn;
		Real4 pk_mth_header_first_seen2_s2_2mn;
		Real4 pk_mth_infutor_first_seen2_2mn;
		Real4 pk_add1_house_number_match_3mn;
		Real4 eda_sourced_level_3mn;
		Real4 pk_ams_college_tier_3mn;
		Real4 pk_attr_num_nonderogs180_3mn;
		Real4 pk_email_count_3mn;
		Real4 pk_prof_license_category_3mn;
		Real4 pk_combo_hphonecount_3mn;
		Real4 pk_mth_infutor_first_seen2_3mn;
		Real4 pk_mth_ver_src_fdate_ts2_3mn;
		Real4 pk_time_on_cb_120b_s3_3mn;
		Real4 pk_nap_summary_ver_0mb;
		Real4 pk_infutor_nap_0mb;
		Real4 pk_ams_college_type_0mb;
		Real4 pk_ams_income_level_code_0mb;
		Real4 pk_attr_num_nonderogs_0mb;
		Real4 pk_attr_num_nonderogs180_0mb;
		Real4 pk_email_count_0mb;
		Real4 pk_bureau_only_0mb;
		Real4 pk_mth_gong_did_first_seen2_0mb;
		Real4 pk_mth_header_first_seen2_s0_0mb;
		Real4 pk_mth_infutor_first_seen2_0mb;
		Real4 pk_mth_ver_src_fdate_ts2_0mb;
		Real4 pk_time_on_cb_120b_s0_0mb;
		Real4 pk_ssn_score_ver_1mb;
		Real4 eda_sourced_level_1mb;
		Real4 pk_ams_age_1mb;
		Real4 pk_ams_income_level_code_1mb;
		Real4 pk_ams_college_tier_1mb;
		Real4 pk_attr_num_nonderogs180_1mb;
		Real4 pk_email_count_1mb;
		Real4 pk_email_domain_free_count_1mb;
		Real4 pk_prof_license_category_1mb;
		Real4 pk_pos_dob_src_cnt_1mb;
		Real4 pk_mth_gong_did_first_seen2_1mb;
		Real4 pk_mth_infutor_first_seen2_1mb;
		Real4 pk_time_on_cb_120b_s1_1mb;
		Real4 pk_nap_summary_ver_2mb;
		Real4 pk_rc_fnamessnmatch_2mb;
		Real4 pk_ams_4yr_college_2mb;
		Real4 pk_email_src_cnt_2mb;
		Real4 pk_pos_addr_src_cnt_2mb;
		Real4 pk_mth_gong_did_first_seen2_2mb;
		Real4 pk_mth_header_first_seen2_s2_2mb;
		Real4 pk_mth_infutor_first_seen2_2mb;
		Real4 pk_time_on_cb_120b_s2_2mb;
		Real4 pk_dob_score_ver_3mb;
		Real4 pk_nap_summary_ver_3mb;
		Real4 pk_ams_4yr_college_3mb;
		Real4 pk_ams_income_level_code_3mb;
		Real4 pk_attr_num_nonderogs180_3mb;
		Real4 pk_email_src_cnt_3mb;
		Real4 pk_prof_license_category_3mb;
		Real4 pk_mth_gong_did_first_seen2_3mb;
		Real4 pk_mth_header_first_seen2_s3_3mb;
		Real4 pk_mth_infutor_first_seen2_3mb;
		Real4 pk_mth_ver_src_fdate_wp2_s3_3mb;
		Real4 derog_mod2_0m;
		Real4 prop_mod3_0m;
		Real4 prop_mod3_1m;
		Real4 prop_mod3_2m;
		Real4 prop_mod3_3m;
		Real4 velocity_mod2_0m;
		Real4 velocity_mod2_1m;
		Real4 velocity_mod2_2m;
		Real4 velocity_mod2_3m;
		Real4 multi_mod_1m;
		Real4 multi_mod_2m;
		Real4 multi_mod_3m;
		Real4 ver_mod2_best_0m;
		Real4 ver_mod2_best_1m;
		Real4 ver_mod2_best_2m;
		Real4 ver_mod2_best_3m;
		Real4 ver_mod2_best_nodob_0m;
		Real4 ver_mod2_best_nodob_1m;
		Real4 ver_mod2_best_nodob_2m;
		Real4 ver_mod2_best_nodob_3m;
		Real4 ver_mod2_notbest_0m;
		Real4 ver_mod2_notbest_1m;
		Real4 ver_mod2_notbest_2m;
		Real4 ver_mod2_notbest_3m;
		Real4 ver_mod2_notbest_nodob_0m;
		Real4 ver_mod2_notbest_nodob_1m;
		Real4 ver_mod2_notbest_nodob_2m;
		Real4 ver_mod2_notbest_nodob_3m;
		Real4 ver_mod2_nodob_0m;
		Real4 ver_mod2_nodob_2m;
		Real4 ver_mod2_nodob_3m;
		Real4 ver_mod2_3m;
		Real4 ver_mod2_2m;
		Real4 ver_mod2_1m;
		Real4 ver_mod2_0m;
		Real4 ver_mod2_nodob_1m;
		Real4 inquiry_mod3_0m;
		Real4 inquiry_mod3_1m;
		Real4 inquiry_mod3_2m;
		Real4 inquiry_mod3_3m;
		Real4 mod15_0m;
		Real4 mod15_1m;
		Real4 mod15_2m;
		Real4 mod15_3m;
		Real4 mod15_nodob_0m;
		Real4 mod15_nodob_1m;
		Real4 mod15_nodob_2m;
		Real4 mod15_nodob_3m;
		Real4 mod15_nodob;
		Real4 mod15;
		Real4 mod15_phat;
		Real4 mod15_scr;
		Real4 mod15_nodob_phat;
		Real4 mod15_nodob_scr;

		// Real4 fp_mod_2m;
		// Real4 fp_mod_nodob_2m;
		// Real4 mod12_0m;
		// Real4 mod12_1m;
		// Real4 mod12_2m;
		// Real4 mod12_3m;
		// Real4 mod12_nodob_0m;
		// Real4 mod12_nodob_1m;
		// Real4 mod12_nodob_2m;
		// Real4 mod12_nodob_3m;
		// Real4 mod12_nodob;
		// Real4 mod12;
		// Real4 mod12_phat;
		// Integer mod12_scr;
		// Real4 mod12_nodob_phat;
		// Integer mod12_nodob_scr;
		Integer rvr1103a;
		Real4 rvr1103b;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Real4 rvr1103c;
		Real4 rvr1103d;
		Real4 rvr1103;



		Integer pk_phn_cell;
		Integer pk_phn_pager;
		Integer pk_phn_pcs;
		Integer pk_phn_Disconnect;
		Integer pk_phn_cell2;
		Integer pk_phn_pager2;
		Integer pk_phn_pcs2;
		Integer pk_phn_PayPhone;
		Integer pk_phn_Fax;
		Integer pk_phn_invalid;
		Integer pk_phn_Usage_Unknown;
		Integer pk_phn_invalid2;
		Integer pk_phn_notpots;
		Integer pk_phn_Usage_Unknown2;
		Integer pk_phn_phnzipmismatch;
		Integer pk_phn_phnzipmismatch2;
		Integer pk_phn_Phn_Not_Issued;
		Integer pk_phn_NonUS;
		Integer pk_phn_pager3;
		Integer pk_phn_cell3;
		Integer pk_phn_cell4;
		Integer pk_phn_pager4;
		Integer pk_phn_mobile;
		Integer pk_phn_cpm;
		Integer pk_phn_cell5;
		Integer pk_phn_pager5;
		Integer pk_phn_mobile2;
		Integer pk_phn_cpm2;
		Integer pk_phn_pcs3;
		Integer pk_phn_pcs4;
		Integer pk_phn_pcs5;
		Integer pk_phn_pcs6;
		Integer pk_phn_pcs7;
		Integer pk_phn_cpm_flag;
		Integer pk_phn_pcs_flag;
		Integer pk_phn_PhnZipMis_flag;
		Boolean phn_notpots;
		Integer pk_phn_Invalid_Flag;
		Integer pk_phn_NotPOTS_Flag;
		Boolean phn_highrisk2;
		Boolean phn_correction;
		// Integer glrc9t;
		Integer pk_add1_advo_address_vacancy;
		Integer pk_add1_advo_throw_back;
		Integer pk_add1_advo_seasonal_delivery;
		Integer pk_add1_advo_college;
		Integer pk_add1_advo_res_or_business;
		Integer pk_add1_advo_drop;
		Integer pk_add_inval;
		Integer pk_add1_advo_mixed_address_usage;
		Integer pk_add_hirisk_comm;
		// Integer glrc9u;
		// Integer glrc9w;
		// Integer glrcev;
		// Integer glrcmi;
		// Integer glrcms;
		Integer aptflag;
		Integer add1_econval;
		Integer add1_aptval;
		String add1_econcode;
		// Integer glrcpv;
		Real4 m_ver_mod2_0m_c34_b1;
		Real4 m_ver_mod2_best_0m_c35;
		Real4 m_ver_mod2_notbest_0m_c35;
		Real4 m_ver_mod2_best_0m_c34;
		Real4 m_velocity_mod2_0m_c34;
		Real4 m_derog_mod2_0m_c34;
		Real4 m_inquiry_mod3_0m_c34;
		Real4 m_prop_mod3_0m_c34;
		Real4 m_ver_mod2_notbest_0m_c34;
		Real4 m_ver_mod2_1m_c36_b1;
		Real4 m_ver_mod2_notbest_1m_c37;
		Real4 m_ver_mod2_best_1m_c37;
		Real4 m_velocity_mod2_1m_c36;
		Real4 m_ver_mod2_notbest_1m_c36;
		Real4 m_prop_mod3_1m_c36;
		Real4 m_multi_mod_1m_c36;
		Real4 m_inquiry_mod3_1m_c36;
		Real4 m_ver_mod2_best_1m_c36;
		Real4 m_ver_mod2_2m_c38_b1;
		Real4 m_ver_mod2_best_2m_c39;
		Real4 m_ver_mod2_notbest_2m_c39;
		Real4 m_inquiry_mod3_2m_c38;
		Real4 m_prop_mod3_2m_c38;
		Real4 m_velocity_mod2_2m_c38;
		Real4 m_ver_mod2_best_2m_c38;
		Real4 m_multi_mod_2m_c38;
		Real4 m_ver_mod2_notbest_2m_c38;
		Real4 m_ver_mod2_3m_c40_b1;
		Real4 m_ver_mod2_best_3m_c41;
		Real4 m_ver_mod2_notbest_3m_c41;
		Real4 m_multi_mod_3m_c40;
		Real4 m_ver_mod2_notbest_3m_c40;
		Real4 m_ver_mod2_best_3m_c40;
		Real4 m_prop_mod3_3m_c40;
		Real4 m_inquiry_mod3_3m_c40;
		Real4 m_velocity_mod2_3m_c40;
		Real4 seg_s0_crime_c43_b1;
		Real4 _97_0_c43;
		Real4 seg_s0_lien_c44_b1;
		Real4 _98_0_c44;
		Real4 seg_s0_eviction_c45_b1;
		Real4 _ev_0_c45;
		Real4 seg_s0_impulse_c46_b1;
		Real4 _9h_0_c46;
		Real4 seg_s0_bk_c47_b1;
		Real4 _9w_0_c47;
		Real4 _9d_3_c42;
		Real4 _9r_5_c42;
		Real4 _9q_1_c42;
		Real4 _9e_2_c42;
		Real4 _9r_4_c42;
		Real4 _ev_1_c42;
		Real4 _x11_3_c42;
		Real4 _9h_1_c42;
		Real4 _25_1_c42;
		Real4 _9r_3_c42;
		Real4 _9o_1_c42;
		Real4 _x11_2_c42;
		Real4 _9g_1_c42;
		Real4 _9r_11_c42;
		Real4 _9a_1_c42;
		Real4 _9r_6_c42;
		Real4 _9e_3_c42;
		Real4 _9j_2_c42;
		Real4 _9w_0_c42;
		Real4 _9c_1_c42;
		Real4 _9e_1_c42;
		Real4 _97_1_c42;
		Real4 _98_0_c42;
		Real4 _9m_1_c42;
		Real4 _9r_10_c42;
		Real4 _ev_0_c42;
		Real4 _98_1_c42;
		Real4 _9h_0_c42;
		Real4 _9q_2_c42;
		Real4 _9d_2_c42;
		Real4 _27_1_c42;
		Real4 _9j_1_c42;
		Real4 _9d_1_c42;
		Real4 _9r_9_c42;
		Real4 _98_2_c42;
		Real4 _9d_4_c42;
		Real4 _9c_2_c42;
		Real4 _28_1_c42;
		Real4 _9c_3_c42;
		Real4 _9r_7_c42;
		Real4 _9r_1_c42;
		Real4 _9e_5_c42;
		Real4 _9r_2_c42;
		Real4 _9d_5_c42;
		Real4 _97_0_c42;
		Real4 _9r_8_c42;
		Real4 _9e_4_c42;
		// Real4 _x11_1_c42_2;
		Real4 _9a_2_c42;
		Real4 seg_s1_c48_b1;
		Real4 _x11_6_c48;
		Real4 _9m_3_c48;
		Real4 _9e_7_c48;
		Real4 _9o_2_c48;
		Real4 _9c_4_c48;
		Real4 _26_1_c48;
		Real4 _9g_5_c48;
		Real4 _ms_1_c48;
		Real4 _9o_3_c48;
		Real4 _9c_6_c48;
		Real4 _9r_21_c48;
		Real4 _x11_4_c48;
		Real4 _9d_6_c48;
		Real4 _9r_15_c48;
		Real4 _9q_5_c48;
		Real4 _mi_1_c48;
		Real4 _9r_16_c48;
		Real4 _9e_6_c48;
		Real4 _9r_14_c48;
		Real4 _9r_20_c48;
		Real4 _9q_3_c48;
		Real4 _x11_5_c48;
		Real4 _9q_4_c48;
		Real4 _28_2_c48;
		Real4 _9g_2_c48;
		Real4 _9r_19_c48;
		Real4 _9g_4_c48;
		Real4 _9d_7_c48;
		Real4 _9g_6_c48;
		Real4 _9r_17_c48;
		Real4 _9r_12_c48;
		Real4 _9r_18_c48;
		Real4 _9c_5_c48;
		Real4 _9d_8_c48;
		Real4 _9d_9_c48;
		Real4 _x11_7_c48;
		Real4 _9g_3_c48;
		Real4 _9e_8_c48;
		Real4 _9m_4_c48;
		Real4 _9r_13_c48;
		Real4 _pv_1_c48;
		Real4 _9l_1_c48;
		Real4 _9m_2_c48;
		Real4 _9q_8_c49;
		Real4 _9d_11_c49;
		Real4 _9o_4_c49;
		Real4 _9r_25_c49;
		Real4 _9j_3_c49;
		Real4 _9l_2_c49;
		Real4 _9q_6_c49;
		Real4 _9e_9_c49;
		Real4 _9r_22_c49;
		Real4 _9s_1_c49;
		Real4 _pv_2_c49;
		Real4 _9a_4_c49;
		Real4 _9d_12_c49;
		Real4 _9a_6_c49;
		Real4 _27_2_c49;
		Real4 _ms_2_c49;
		Real4 _9r_24_c49;
		Real4 _9c_7_c49;
		Real4 _9e_11_c49;
		Real4 _9e_10_c49;
		Real4 _x11_8_c49;
		Real4 _9q_7_c49;
		Real4 _9g_7_c49;
		Real4 _9m_5_c49;
		Real4 _x11_9_c49;
		Real4 _52_1_c49;
		Real4 _9r_26_c49;
		Real4 _9a_5_c49;
		Real4 _9a_3_c49;
		Real4 _9j_4_c49;
		Real4 _9c_8_c49;
		Real4 _9d_10_c49;
		Real4 _9r_23_c49;
		// Real4 _x11_1_c49_1;
		// Real4 _x11_1_c50_b1_4;
		// Real4 _x11_1_c50_b1_3;
		// Real4 _x11_1_c50_b1_2;
		// Real4 _x11_1_c50_b1_1;
		Real4 _9r_34_c50;
		Real4 _9q_9_c50;
		Real4 _9r_33_c50;
		Real4 _9m_6_c50;
		Real4 _9r_27_c50;
		Real4 _9a_7_c50;
		Real4 _9d_13_c50;
		Real4 _9d_15_c50;
		Real4 _9r_31_c50;
		Real4 _9r_30_c50;
		Real4 _9r_32_c50;
		Real4 _mi_2_c50;
		Real4 _9q_11_c50;
		Real4 _9e_14_c50;
		Real4 _9j_5_c50;
		Real4 _9g_8_c50;
		Real4 _9r_29_c50;
		Real4 _9d_14_c50;
		Real4 _pv_3_c50;
		Real4 _27_3_c50;
		Real4 _38_1_c50;
		Real4 _9c_10_c50;
		Real4 _9e_12_c50;
		Real4 _9r_28_c50;
		Real4 _9c_9_c50;
		Real4 _9o_5_c50;
		Real4 _9q_10_c50;
		Real4 _28_3_c50;
		Real4 _ms_3_c50;
		// Real4 _x11_1_c50;
		Real4 _9c_11_c50;
		Real4 _25_2_c50;
		Real4 _9e_13_c50;
		Real4 M_Ver_mod2_NoDob_0M;
		Real4 m_ver_mod2_notbest_nodob_0m_c52;
		Real4 m_ver_mod2_best_nodob_0m_c52;
		Real4 m_velocity_mod2_0m_c51;
		Real4 m_derog_mod2_0m_c51;
		Real4 m_inquiry_mod3_0m_c51;
		Real4 m_ver_mod2_notbest_nodob_0m_c51;
		Real4 m_ver_mod2_best_nodob_0m_c51;
		Real4 m_prop_mod3_0m_c51;
		Real4 m_ver_mod2_nodob_1m_c53_b1;
		Real4 m_ver_mod2_best_nodob_1m_c54;
		Real4 m_ver_mod2_notbest_nodob_1m_c54;
		Real4 m_velocity_mod2_1m_c53;
		Real4 m_ver_mod2_best_nodob_1m_c53;
		Real4 m_prop_mod3_1m_c53;
		Real4 m_multi_mod_1m_c53;
		Real4 m_inquiry_mod3_1m_c53;
		Real4 m_ver_mod2_notbest_nodob_1m_c53;
		Real4 m_ver_mod2_nodob_2m_c55_b1;
		Real4 m_ver_mod2_notbest_nodob_2m_c56;
		Real4 m_ver_mod2_best_nodob_2m_c56;
		Real4 m_inquiry_mod3_2m_c55;
		Real4 m_prop_mod3_2m_c55;
		Real4 m_velocity_mod2_2m_c55;
		Real4 m_ver_mod2_notbest_nodob_2m_c55;
		Real4 m_ver_mod2_best_nodob_2m_c55;
		Real4 m_multi_mod_2m_c55;
		Real4 m_ver_mod2_nodob_3m_c57_b1;
		Real4 m_ver_mod2_best_nodob_3m_c58;
		Real4 m_ver_mod2_notbest_nodob_3m_c58;
		Real4 m_multi_mod_3m_c57;
		Real4 m_ver_mod2_best_nodob_3m_c57;
		Real4 m_ver_mod2_notbest_nodob_3m_c57;
		Real4 m_prop_mod3_3m_c57;
		Real4 m_inquiry_mod3_3m_c57;
		Real4 m_velocity_mod2_3m_c57;
		Real4 seg_s0_crime_c60_b1;
		Real4 _97_0_c60;
		Real4 seg_s0_lien_c61_b1;
		Real4 _98_0_c61;
		Real4 seg_s0_eviction_c62_b1;
		Real4 _ev_0_c62;
		Real4 seg_s0_impulse_c63_b1;
		Real4 _9h_0_c63;
		Real4 seg_s0_bk_c64_b1;
		Real4 _9w_0_c64;
		Real4 _9d_3_c59;
		Real4 _9r_5_c59;
		Real4 _9q_1_c59;
		Real4 _9e_2_c59;
		Real4 _9r_4_c59;
		Real4 _ev_1_c59;
		Real4 _x11_3_c59;
		Real4 _9h_1_c59;
		Real4 _25_1_c59;
		Real4 _9r_3_c59;
		Real4 _9o_1_c59;
		Real4 _x11_2_c59;
		Real4 _9r_11_c59;
		Real4 _9a_1_c59;
		Real4 _9r_6_c59;
		Real4 _9e_3_c59;
		Real4 _9j_2_c59;
		Real4 _9w_0_c59;
		Real4 _9c_1_c59;
		Real4 _9e_1_c59;
		Real4 _97_1_c59;
		Real4 _98_0_c59;
		Real4 _9m_1_c59;
		Real4 _9r_10_c59;
		Real4 _ev_0_c59;
		Real4 _98_1_c59;
		Real4 _9h_0_c59;
		Real4 _9q_2_c59;
		Real4 _9d_2_c59;
		Real4 _27_1_c59;
		Real4 _9j_1_c59;
		Real4 _9d_1_c59;
		Real4 _9r_9_c59;
		Real4 _98_2_c59;
		Real4 _9d_4_c59;
		Real4 _9c_2_c59;
		Real4 _9c_3_c59;
		Real4 _9r_7_c59;
		Real4 _9r_1_c59;
		Real4 _9e_5_c59;
		Real4 _9r_2_c59;
		Real4 _9d_5_c59;
		Real4 _97_0_c59;
		Real4 _9r_8_c59;
		Real4 _9e_4_c59;
		// Real4 _x11_1_c59_2;
		Real4 _9a_2_c59;
		Real4 seg_s1_c65_b1;
		Real4 _x11_6_c65;
		Real4 _9m_3_c65;
		Real4 _9e_7_c65;
		Real4 _9o_2_c65;
		Real4 _9c_4_c65;
		Real4 _26_1_c65;
		Real4 _9g_1_c65;
		Real4 _ms_1_c65;
		Real4 _9o_3_c65;
		Real4 _9c_6_c65;
		Real4 _9r_21_c65;
		Real4 _x11_4_c65;
		Real4 _9d_6_c65;
		Real4 _9r_15_c65;
		Real4 _9q_5_c65;
		Real4 _mi_1_c65;
		Real4 _9r_16_c65;
		Real4 _9e_6_c65;
		Real4 _9r_14_c65;
		Real4 _9r_20_c65;
		Real4 _9q_3_c65;
		Real4 _x11_5_c65;
		Real4 _9q_4_c65;
		Real4 _9g_2_c65;
		Real4 _9r_19_c65;
		Real4 _9g_4_c65;
		Real4 _9d_7_c65;
		Real4 _9r_17_c65;
		Real4 _9r_12_c65;
		Real4 _9r_18_c65;
		Real4 _9c_5_c65;
		Real4 _9d_8_c65;
		Real4 _9d_9_c65;
		Real4 _x11_7_c65;
		Real4 _9e_8_c65;
		Real4 _9g_3_c65;
		Real4 _9m_4_c65;
		Real4 _9r_13_c65;
		Real4 _pv_1_c65;
		Real4 _9l_1_c65;
		Real4 _9m_2_c65;
		Real4 _9q_8_c66;
		Real4 _9d_11_c66;
		Real4 _9o_4_c66;
		Real4 _9r_25_c66;
		Real4 _9j_3_c66;
		Real4 _9l_2_c66;
		Real4 _9q_6_c66;
		Real4 _9e_9_c66;
		Real4 _9r_22_c66;
		Real4 _9s_1_c66;
		Real4 _9g_5_c66;
		Real4 _pv_2_c66;
		Real4 _9a_4_c66;
		Real4 _9d_12_c66;
		Real4 _9a_6_c66;
		Real4 _27_2_c66;
		Real4 _ms_2_c66;
		Real4 _9r_24_c66;
		Real4 _9c_7_c66;
		Real4 _9e_11_c66;
		Real4 _9e_10_c66;
		Real4 _x11_8_c66;
		Real4 _9q_7_c66;
		Real4 _9m_5_c66;
		Real4 _x11_9_c66;
		Real4 _52_1_c66;
		Real4 _9r_26_c66;
		Real4 _9a_5_c66;
		Real4 _9a_3_c66;
		Real4 _9j_4_c66;
		Real4 _9c_8_c66;
		Real4 _9d_10_c66;
		Real4 _9r_23_c66;
		// Real4 _x11_1_c66_1;
		// Real4 _x11_1_c67_b1_4;
		// Real4 _x11_1_c67_b1_3;
		// Real4 _x11_1_c67_b1_2;
		// Real4 _x11_1_c67_b1_1;
		// Real4 _9d_14_c67;
		// Real4 _pv_3_c67;
		// Real4 _27_3_c67;
		// Real4 _38_1_c67;
		// Real4 _9q_9_c67;
		// Real4 _9c_10_c67;
		// Real4 _9r_27_c67;
		// Real4 _9r_33_c67;
		// Real4 _9m_6_c67;
		// Real4 _9g_6_c67;
		// Real4 _9a_7_c67;
		// Real4 _9e_12_c67;
		// Real4 _9r_28_c67;
		// Real4 _9d_13_c67;
		// Real4 _9d_15_c67;
		// Real4 _9c_9_c67;
		// Real4 _9o_5_c67;
		// Real4 _9r_31_c67;
		// Real4 _9q_10_c67;
		// Real4 _9r_30_c67;
		// Real4 _9r_32_c67;
		// Real4 _mi_2_c67;
		// Real4 _9e_14_c67;
		// Real4 _ms_3_c67;
		// Real4 _9q_11_c67;
		// Real4 _x11_1_c67;
		// Real4 _9c_11_c67;
		// Real4 _9j_5_c67;
		// Real4 _9e_13_c67;
		// Real4 _25_2_c67;
		// Real4 _9r_29_c67;
		Real4 _9h;
		Real4 _9c;
		Real4 _26;
		Real4 _mi;
		Integer _9u;
		Real4 _9j;
		Real4 _9o;
		Integer _9t;
		Real4 _9e;
		Real4 _28;
		Real4 _9w;
		Real4 _9m;
		Real4 _ev;
		Real4 _38;
		Real4 _pv;
		Real4 _97;
		Real4 _9r;
		Real4 _9q;
		Real4 _9l;
		Real4 _9g;
		Real4 _9s;
		Real4 _x11;
		Real4 _52;
		Real4 _98;
		Real4 _27;
		Real4 _ms;
		Integer _9k;
		Real4 _9a;
		Real4 _25;
		Integer _49;
		Real4 _9d;
		// data rc_dataset;
		// data rcs_top4;
		// String rv40_rc1_c68_b3_2;
		// String rv40_rc2_c68_b3;
		// String rv40_rc3_c68_b3;
		// String rv40_rc4_c68_b3;
		// String rv40_rc5_c68_b3_1;
		// String rv40_rc1_c69_1;
		// String rv40_rc5_c71;
		// String rv40_rc5_c70;
		// String rv40_rc1_c72;
		// String rv40_rc4;
		// String rv40_rc5;
		// String rv40_rc1;
		// String rv40_rc2;
		// String rv40_rc3;
		string2 rc1 := '';
		string2 rc2 := '';
		string2 rc3 := '';
		string2 rc4 := '';
		string2 rc5 := '';

		integer1 glrc25;
		integer1 glrc26;
		integer1 glrc27;
		integer1 glrc28;
		integer1 glrc38;
		integer1 glrc49;
		integer1 glrc52;
		integer1 glrc97;
		integer1 glrc98;
		integer1 glrc9a;
		integer1 glrc9c;
		integer1 glrc9d;
		integer1 glrc9e;
		integer1 glrc9g;
		integer1 glrc9h;
		integer1 glrc9j;
		integer1 glrc9k;
		integer1 glrc9l;
		integer1 glrc9m;
		integer1 glrc9o;
		integer1 glrc9q;
		integer1 glrc9r;
		integer1 glrc9s;
		// integer1 glrc9t;
		integer1 glrc9u;
		integer1 glrc9w;
		integer1 glrcev;
		integer1 glrcmi;
		integer1 glrcms;
		integer1 glrc9t;
		integer1 glrcpv;

		string2 rc1_rc;
		string2 rc2_rc;
		string2 rc3_rc;
		string2 rc4_rc;
		string2 rc5_rc;
		models.layout_modelout;
	end;
	debug_layout doModel(clam le) := TRANSFORM
	#else
	models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end


		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_hrisksicphone                 := le.iid.hrisksicphone;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_hphonescore                := le.iid.combo_hphonescore;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_hphonecount                := le.iid.combo_hphonecount;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_nas                  := le.header_summary.ver_sources_nas;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
		ver_addr_sources                 := le.header_summary.ver_addr_sources;
		ver_dob_sources                  := le.header_summary.ver_dob_sources;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
		add1_advo_college                := le.advo_input_addr.college_indicator;
		add1_advo_drop                   := le.advo_input_addr.drop_indicator;
		add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
		add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_purchase_date               := le.address_verification.input_address_information.purchase_date;
		add1_built_date                  := le.address_verification.input_address_information.built_date;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
		property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
		property_sold_assessed_count     := le.address_verification.sold.property_owned_assessed_count;
		property_ambig_total             := le.address_verification.ambiguous.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
		addr_count_ge3                   := le.address_history_summary.addr_count3;
		addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		lnames_per_adl_c6                := le.velocity_counters.lnames_per_adl180;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		invalid_phones_per_adl_c6        := le.velocity_counters.invalid_phones_per_adl_created_6months;
		invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
		inq_count                        := le.acc_logs.inquiries.counttotal;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_banking_count06              := le.acc_logs.banking.count06;
		inq_peradl                       := le.acc_logs.inquiryperadl;
		inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
		inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
		inq_perphone                     := le.acc_logs.inquiryperphone;
		inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
		paw_company_title                := le.employment.company_title;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_date_first_purchase         := le.other_address_info.date_first_purchase;
		attr_num_sold60                  := le.other_address_info.num_sold60;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_last_unrel_date            := le.bjl.last_liens_unreleased_date;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_lt_last_seen         := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
		liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_last_date                 := le.bjl.last_felony_date;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		estimated_income                 := le.estimated_income;
		archive_date                     := le.historydate;




		NULL := -999999999;


		sysdate := map(
			trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
			length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																   NULL);

		in_dob2 := models.common.sas_date((string)(in_dob));

		yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);

		rc_ssnlowissue2 := models.common.sas_date((string)(rc_ssnlowissue));

		add1_purchase_date2 := models.common.sas_date((string)(add1_purchase_date));

		mth_add1_purchase_date := if(min(sysdate, add1_purchase_date2) = NULL, NULL, (sysdate - add1_purchase_date2) / 30.5);

		add1_built_date2 := models.common.sas_date((string)(add1_built_date));

		mth_add1_built_date := if(min(sysdate, add1_built_date2) = NULL, NULL, (sysdate - add1_built_date2) / 30.5);

		add1_date_first_seen2 := models.common.sas_date((string)(add1_date_first_seen));

		mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 30.5);

		gong_did_first_seen2 := models.common.sas_date((string)(gong_did_first_seen));

		mth_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

		header_first_seen2 := models.common.sas_date((string)(header_first_seen));

		mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

		infutor_first_seen2 := models.common.sas_date((string)(infutor_first_seen));

		mth_infutor_first_seen := if(min(sysdate, infutor_first_seen2) = NULL, NULL, (sysdate - infutor_first_seen2) / 30.5);

		attr_date_first_purchase2 := models.common.sas_date((string)(attr_date_first_purchase));

		mth_attr_date_first_purchase := if(min(sysdate, attr_date_first_purchase2) = NULL, NULL, (sysdate - attr_date_first_purchase2) / 30.5);

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		yr_attr_date_last_eviction := if(min(sysdate, attr_date_last_eviction2) = NULL, NULL, (sysdate - attr_date_last_eviction2) / 365.25);

		liens_last_unrel_date2 := models.common.sas_date((string)(liens_last_unrel_date));

		yr_liens_last_unrel_date := if(min(sysdate, liens_last_unrel_date2) = NULL, NULL, (sysdate - liens_last_unrel_date2) / 365.25);

		liens_unrel_cj_last_seen2 := models.common.sas_date((string)(liens_unrel_cj_last_seen));

		yr_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 365.25);

		liens_unrel_lt_last_seen2 := models.common.sas_date((string)(liens_unrel_lt_last_seen));

		yr_liens_unrel_lt_last_seen := if(min(sysdate, liens_unrel_lt_last_seen2) = NULL, NULL, (sysdate - liens_unrel_lt_last_seen2) / 365.25);

		liens_unrel_sc_last_seen2 := models.common.sas_date((string)(liens_unrel_sc_last_seen));

		yr_liens_unrel_sc_last_seen := if(min(sysdate, liens_unrel_sc_last_seen2) = NULL, NULL, (sysdate - liens_unrel_sc_last_seen2) / 365.25);

		criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

		yr_criminal_last_date := if(min(sysdate, criminal_last_date2) = NULL, NULL, (sysdate - criminal_last_date2) / 365.25);

		felony_last_date2 := models.common.sas_date((string)(felony_last_date));

		yr_felony_last_date := if(min(sysdate, felony_last_date2) = NULL, NULL, (sysdate - felony_last_date2) / 365.25);

		ver_src_cnt := models.common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

		ver_src_ar_pos := models.common.findw_cpp(ver_sources, 'AR' , ' ,', 'ie');

		ver_src_ar := ver_src_ar_pos > 0;

		ver_src_ba_pos := models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_eb_pos := models.common.findw_cpp(ver_sources, 'EB' , ' ,', 'ie');

		ver_src_eb := ver_src_eb_pos > 0;

		ver_src_eq_pos := models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		ver_src_eq := ver_src_eq_pos > 0;

		ver_src_fdate_eq := if(ver_src_eq_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

		ver_src_fdate_eq2 := models.common.sas_date((string)(ver_src_fdate_eq));

		mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

		ver_src_en_pos := models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

		ver_src_en := ver_src_en_pos > 0;

		ver_src_fdate_en := if(ver_src_en_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

		ver_src_fdate_en2 := models.common.sas_date((string)(ver_src_fdate_en));

		mth_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 30.5);

		ver_src_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		ver_src_nas_p := if(ver_src_p_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_p_pos), 0);

		ver_src_li_pos := models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		ver_src_ldate_li := if(ver_src_li_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_li_pos), '0');

		ver_src_ldate_li2 := models.common.sas_date((string)(ver_src_ldate_li));

		mth_ver_src_ldate_li := if(min(sysdate, ver_src_ldate_li2) = NULL, NULL, (sysdate - ver_src_ldate_li2) / 30.5);

		ver_src_l2_pos := models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_ldate_l2 := if(ver_src_l2_pos > 0, models.common.getw(ver_sources_last_seen, ver_src_l2_pos), '0');

		ver_src_ldate_l22 := models.common.sas_date((string)(ver_src_ldate_l2));

		mth_ver_src_ldate_l2 := if(min(sysdate, ver_src_ldate_l22) = NULL, NULL, (sysdate - ver_src_ldate_l22) / 30.5);

		ver_src_ts_pos := models.common.findw_cpp(ver_sources, 'TS' , ' ,', 'ie');

		ver_src_fdate_ts := if(ver_src_ts_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

		ver_src_fdate_ts2 := models.common.sas_date((string)(ver_src_fdate_ts));

		mth_ver_src_fdate_ts := if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, (sysdate - ver_src_fdate_ts2) / 30.5);

		ver_src_w_pos := models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');

		ver_src_w := ver_src_w_pos > 0;

		ver_src_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

		ver_src_fdate_wp := if(ver_src_wp_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

		ver_src_fdate_wp2 := models.common.sas_date((string)(ver_src_fdate_wp));

		mth_ver_src_fdate_wp := if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, (sysdate - ver_src_fdate_wp2) / 30.5);

		ver_addr_src_ak_pos := models.common.findw_cpp(ver_addr_sources, 'AK' , ' ,', 'ie');

		ver_addr_src_ak := ver_addr_src_ak_pos > 0;

		ver_addr_src_am_pos := models.common.findw_cpp(ver_addr_sources, 'AM' , ' ,', 'ie');

		ver_addr_src_am := ver_addr_src_am_pos > 0;

		ver_addr_src_ar_pos := models.common.findw_cpp(ver_addr_sources, 'AR' , ' ,', 'ie');

		ver_addr_src_ar := ver_addr_src_ar_pos > 0;

		ver_addr_src_cg_pos := models.common.findw_cpp(ver_addr_sources, 'CG' , ' ,', 'ie');

		ver_addr_src_cg := ver_addr_src_cg_pos > 0;

		ver_addr_src_eb_pos := models.common.findw_cpp(ver_addr_sources, 'EB' , ' ,', 'ie');

		ver_addr_src_eb := ver_addr_src_eb_pos > 0;

		ver_addr_src_eq_pos := models.common.findw_cpp(ver_addr_sources, 'EQ' , ' ,', 'ie');

		ver_addr_src_eq := ver_addr_src_eq_pos > 0;

		ver_addr_src_en_pos := models.common.findw_cpp(ver_addr_sources, 'EN' , ' ,', 'ie');

		ver_addr_src_en := ver_addr_src_en_pos > 0;

		ver_addr_src_em_pos := models.common.findw_cpp(ver_addr_sources, 'EM' , ' ,', 'ie');

		ver_addr_src_em := ver_addr_src_em_pos > 0;

		ver_addr_src_e1_pos := models.common.findw_cpp(ver_addr_sources, 'E1' , ' ,', 'ie');

		ver_addr_src_e1 := ver_addr_src_e1_pos > 0;

		ver_addr_src_e2_pos := models.common.findw_cpp(ver_addr_sources, 'E2' , ' ,', 'ie');

		ver_addr_src_e2 := ver_addr_src_e2_pos > 0;

		ver_addr_src_e3_pos := models.common.findw_cpp(ver_addr_sources, 'E3' , ' ,', 'ie');

		ver_addr_src_e3 := ver_addr_src_e3_pos > 0;

		ver_addr_src_e4_pos := models.common.findw_cpp(ver_addr_sources, 'E4' , ' ,', 'ie');

		ver_addr_src_e4 := ver_addr_src_e4_pos > 0;

		ver_addr_src_pl_pos := models.common.findw_cpp(ver_addr_sources, 'PL' , ' ,', 'ie');

		ver_addr_src_pl := ver_addr_src_pl_pos > 0;

		ver_addr_src_vo_pos := models.common.findw_cpp(ver_addr_sources, 'VO' , ' ,', 'ie');

		ver_addr_src_vo := ver_addr_src_vo_pos > 0;

		ver_addr_src_w_pos := models.common.findw_cpp(ver_addr_sources, 'W' , ' ,', 'ie');

		ver_addr_src_w := ver_addr_src_w_pos > 0;

		ver_addr_src_wp_pos := models.common.findw_cpp(ver_addr_sources, 'WP' , ' ,', 'ie');

		ver_addr_src_wp := ver_addr_src_wp_pos > 0;

		ver_dob_src_ak_pos := models.common.findw_cpp(ver_dob_sources, 'AK' , ' ,', 'ie');

		ver_dob_src_ak := ver_dob_src_ak_pos > 0;

		ver_dob_src_am_pos := models.common.findw_cpp(ver_dob_sources, 'AM' , ' ,', 'ie');

		ver_dob_src_am := ver_dob_src_am_pos > 0;

		ver_dob_src_ar_pos := models.common.findw_cpp(ver_dob_sources, 'AR' , ' ,', 'ie');

		ver_dob_src_ar := ver_dob_src_ar_pos > 0;

		ver_dob_src_cg_pos := models.common.findw_cpp(ver_dob_sources, 'CG' , ' ,', 'ie');

		ver_dob_src_cg := ver_dob_src_cg_pos > 0;

		ver_dob_src_eb_pos := models.common.findw_cpp(ver_dob_sources, 'EB' , ' ,', 'ie');

		ver_dob_src_eb := ver_dob_src_eb_pos > 0;

		ver_dob_src_eq_pos := models.common.findw_cpp(ver_dob_sources, 'EQ' , ' ,', 'ie');

		ver_dob_src_eq := ver_dob_src_eq_pos > 0;

		ver_dob_src_en_pos := models.common.findw_cpp(ver_dob_sources, 'EN' , ' ,', 'ie');

		ver_dob_src_en := ver_dob_src_en_pos > 0;

		ver_dob_src_em_pos := models.common.findw_cpp(ver_dob_sources, 'EM' , ' ,', 'ie');

		ver_dob_src_em := ver_dob_src_em_pos > 0;

		ver_dob_src_e1_pos := models.common.findw_cpp(ver_dob_sources, 'E1' , ' ,', 'ie');

		ver_dob_src_e1 := ver_dob_src_e1_pos > 0;

		ver_dob_src_e2_pos := models.common.findw_cpp(ver_dob_sources, 'E2' , ' ,', 'ie');

		ver_dob_src_e2 := ver_dob_src_e2_pos > 0;

		ver_dob_src_e3_pos := models.common.findw_cpp(ver_dob_sources, 'E3' , ' ,', 'ie');

		ver_dob_src_e3 := ver_dob_src_e3_pos > 0;

		ver_dob_src_e4_pos := models.common.findw_cpp(ver_dob_sources, 'E4' , ' ,', 'ie');

		ver_dob_src_e4 := ver_dob_src_e4_pos > 0;

		ver_dob_src_pl_pos := models.common.findw_cpp(ver_dob_sources, 'PL' , ' ,', 'ie');

		ver_dob_src_pl := ver_dob_src_pl_pos > 0;

		ver_dob_src_vo_pos := models.common.findw_cpp(ver_dob_sources, 'VO' , ' ,', 'ie');

		ver_dob_src_vo := ver_dob_src_vo_pos > 0;

		ver_dob_src_w_pos := models.common.findw_cpp(ver_dob_sources, 'W' , ' ,', 'ie');

		ver_dob_src_w := ver_dob_src_w_pos > 0;

		ver_dob_src_wp_pos := models.common.findw_cpp(ver_dob_sources, 'WP' , ' ,', 'ie');

		ver_dob_src_wp := ver_dob_src_wp_pos > 0;

		email_src_cnt := models.common.countw((string)(email_source_list), ' !$%&()*+,-./;<^|');

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		ssn_issued18 := rc_pwssnvalflag = (string)5;

		ssn_deceased := rc_decsflag = (string)1 or (integer)ver_src_ds = 1;

		ssn_lowissue_age := if(in_dob2 != NULL and rc_ssnlowissue2 != NULL, (rc_ssnlowissue2 - in_dob2) / 365.2, NULL);

		prop_owner := map(
			add1_naprop = 4 or add2_naprop = 4 or add3_naprop = 4                           => 2,
			property_owned_total > 0 or property_sold_total > 0 or property_ambig_total > 0 => 1,
																							   0);

		add_naprop_level := map(
			add1_naprop = 4                    => 2,
			add1_naprop = 3 or prop_owner >= 1 => 1,
												  0);

		add1_ownership := map(
			add1_applicant_owned and add1_family_owned => 4,
			add1_applicant_owned                       => 3,
			add1_family_owned                          => 2,
			add1_occupant_owned                        => 1,
														  0);

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		pk_property_owner := if(Add1_NaProp = 4 or Property_Owned_Total > 0, 1, 0);

		pk_impulse_count := min(2, if(impulse_count = NULL, -NULL, impulse_count));

		pk_yr_in_dob := truncate(yr_in_dob);

		pk_age_estimate := if(pk_yr_in_dob > 0, pk_yr_in_dob, inferred_age);

		bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

		bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

		bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag > 0 or (integer)ssn_deceased > 0, 1, 0);

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		pk_222_flag := if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 1, 0);

		pk_segment_40 := map(
			(integer)ssn_deceased > 0                            => 'X 200  ',
			pk_222_flag = 1                                      => 'X 222  ',
			bs_attr_derog_flag2 = 1                              => '0 Derog',
			pk_age_estimate <= 24                                => '1 Young',
			pk_property_owner = 1                                => '2 Owner',
																	'3 Other');

		pk_age_estimate_s1 := map(
			pk_age_estimate <= 18 => 0,
			pk_age_estimate <= 19 => 1,
			pk_age_estimate <= 20 => 2,
			pk_age_estimate <= 21 => 3,
			pk_age_estimate <= 22 => 4,
									 5);

		pk_age_estimate_s2 := map(
			pk_age_estimate <= 26 => 0,
			pk_age_estimate <= 34 => 1,
			pk_age_estimate <= 38 => 2,
			pk_age_estimate <= 43 => 3,
			pk_age_estimate <= 56 => 4,
			pk_age_estimate <= 61 => 5,
									 6);

		pk_age_estimate_s3 := map(
			pk_age_estimate <= 34 => 0,
			pk_age_estimate <= 40 => 1,
			pk_age_estimate <= 44 => 2,
			pk_age_estimate <= 52 => 3,
			pk_age_estimate <= 61 => 4,
									 5);

		pk_estimated_income_s1 := map(
			estimated_income <= 19999 => 0,
			estimated_income <= 20000 => 1,
			estimated_income <= 21000 => 2,
			estimated_income <= 22000 => 3,
			estimated_income <= 23000 => 4,
			estimated_income <= 24000 => 5,
			estimated_income <= 26000 => 6,
			estimated_income <= 29000 => 7,
			estimated_income <= 40000 => 8,
										 9);

		pk_estimated_income_s2 := map(
			estimated_income <= 23000 => 0,
			estimated_income <= 37000 => 1,
			estimated_income <= 75000 => 2,
										 3);

		pk_add1_avm_auto_val_s1 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 49211  => 0,
			add1_avm_automated_valuation <= 66977  => 1,
			add1_avm_automated_valuation <= 80000  => 2,
			add1_avm_automated_valuation <= 135236 => 3,
			add1_avm_automated_valuation <= 323229 => 4,
			add1_avm_automated_valuation <= 565000 => 5,
													  6);

		pk_add1_avm_auto_val_s2 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 69675  => 0,
			add1_avm_automated_valuation <= 128103 => 1,
													  2);

		pk_add1_avm_auto_val_s3 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 46432  => 0,
			add1_avm_automated_valuation <= 75658  => 1,
			add1_avm_automated_valuation <= 113043 => 2,
													  3);

		pk_combo_hphonescore := map(
			combo_hphonescore = 255 => -1,
			combo_hphonescore <= 89 => 0,
									   1);

		pk_combo_ssnscore := map(
			combo_ssnscore = 255 => -1,
			combo_ssnscore <= 99 => 0,
									1);

		pk_combo_dobscore := map(
			combo_dobscore = 255 => -1,
			combo_dobscore <= 95 => 0,
									1);

		pk_hphn_score_ver := if(pk_combo_hphonescore = 1, 1, 0);

		pk_ssn_score_ver := if(pk_combo_ssnscore = 1, 1, 0);

		pk_dob_score_ver := if(pk_combo_dobscore = 1, 1, 0);

		nas_summary_ver := if(nas_summary >= 10, 1, 0);

		pk_nap_summary_ver := map(
			nap_summary >= 10       => 2,
			(nap_summary in [7, 9]) => 2,
			(nap_summary in [8])    => 1,
			nap_summary >= 2        => 1,
			nap_summary = 1         => -1,
									   0);

		pk_rc_fnamessnmatch := if((integer)rc_fnamessnmatch <= 0, 0, 1);

		pk_add1_house_number_match := if((integer)add1_house_number_match <= 0, 0, 1);

		eda_sourced_level := map(
			(integer)add1_eda_sourced = 1 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP' and (trim(trim(fname_eda_sourced_type, LEFT), LEFT, RIGHT) in ['AP', 'A']) => 2,
			(integer)add1_eda_sourced = 1 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP'                                                                            => 2,
			(integer)add1_eda_sourced = 1 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A' and (trim(trim(fname_eda_sourced_type, LEFT), LEFT, RIGHT) in ['A'])        => 1,
			(integer)add1_eda_sourced = 1 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'                                                                             => 1,
			(integer)add1_eda_sourced = 1 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'A'                                                                             => 1,
			(integer)add1_eda_sourced = 1                                                                                                                                             => 0,
			(integer)add1_eda_sourced = 0 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'P'                                                                             => 2,
			(integer)add1_eda_sourced = 0 and trim(trim(lname_eda_sourced_type, LEFT), LEFT, RIGHT) = 'AP'                                                                            => 1,
																																														 0);

		pk_infutor_nap := map(
			infutor_nap <= 0        => -2,
			(infutor_nap in [1, 6]) => -1,
			infutor_nap <= 10       => 0,
									   1);

		pk_input_dob_match_level := map(
			input_dob_match_level <= (string)0 => 0,
			input_dob_match_level <= (string)6 => 1,
												  2);

		pk_ams_age := map(
			ams_age <= (string)0  => -1,
			ams_age <= (string)22 => 0,
			ams_age <= (string)25 => 1,
									 2);

		pk_ams_4yr_college := if(ams_college_code = (string)4, 1, 0);

		pk_ams_college_type := map(
			trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'P' => 1,
			trim(trim(ams_college_type, LEFT), LEFT, RIGHT) = 'S' => 1,
																	 0);

		pk_ams_income_level_code := map(
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['A', 'B']) => 0,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['C'])      => 0,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['D'])      => 1,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['E'])      => 1,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['F', 'G']) => 1,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['H'])      => 2,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['I', 'J']) => 2,
			(trim(trim(ams_income_level_code, LEFT), LEFT, RIGHT) in ['K'])      => 2,
																					-1);

		pk_ams_college_tier := map(
			(ams_college_tier in ['0', '1', '2']) => 1,
			(ams_college_tier in ['3'])           => 1,
			(ams_college_tier in ['4'])           => 1,
			(ams_college_tier in ['5'])           => 0,
			(ams_college_tier in ['6'])           => 0,
															  -1);

		pk_combo_hphonecount := if(combo_hphonecount > 0, 1, 0);

		pk_attr_num_nonderogs := map(
			attr_num_nonderogs <= 1 => 0,
			attr_num_nonderogs <= 2 => 1,
			attr_num_nonderogs <= 3 => 2,
			attr_num_nonderogs <= 4 => 3,
									   4);

		pk_attr_num_nonderogs180 := map(
			attr_num_nonderogs180 <= 1                                  => 0,
			attr_num_nonderogs180 <= 2                                  => 1,
			attr_num_nonderogs180 <= 3 or (integer)add1_isbestmatch = 0 => 2,
																		   3);

		pk_email_count := map(
			email_count <= 0 => 0,
			email_count <= 2 => 1,
								2);

		pk_email_domain_free_count := map(
			email_domain_free_count <= 0 => 0,
			email_domain_free_count <= 1 => 1,
											2);

		pk_email_src_cnt := map(
			email_src_cnt <= 0 => 0,
			email_src_cnt <= 1 => 1,
								  2);

		pk_paw_company_title := if(trim(trim((string)paw_company_title, LEFT), LEFT, RIGHT) = '', 0, 1);

		pk_prof_license_category := map(
			prof_license_category <= (string)NULL => -1,
			prof_license_category <= (string)1    => 0,
													 1);

		pk_pos_addr_src_minor := if(max((integer)ver_addr_src_ak, (integer)ver_addr_src_am, (integer)ver_addr_src_ar, (integer)ver_addr_src_cg, (integer)ver_addr_src_w, (integer)ver_addr_src_eb) = NULL, NULL, sum((integer)ver_addr_src_ak, (integer)ver_addr_src_am, (integer)ver_addr_src_ar, (integer)ver_addr_src_cg, (integer)ver_addr_src_w, (integer)ver_addr_src_eb));

		pk_pos_addr_src_minor_flag := pk_pos_addr_src_minor > 0;

		pk_pos_dob_src_minor := if(max((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb) = NULL, NULL, sum((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb));

		pk_pos_dob_src_minor_flag := pk_pos_dob_src_minor > 0;

		ver_src_bureau := ver_src_en or ver_src_eq;

		ver_addr_src_bureau := ver_addr_src_en or ver_addr_src_eq;

		ver_dob_src_bureau := ver_dob_src_en or ver_dob_src_eq;

		ver_addr_src_emerge := max((integer)ver_addr_src_em, (integer)(integer)ver_addr_src_e1, (integer)(integer)ver_addr_src_e2, (integer)(integer)ver_addr_src_e3, (integer)(integer)ver_addr_src_e4);

		ver_dob_src_emerge := max((integer)ver_dob_src_em, (integer)(integer)ver_dob_src_e1, (integer)(integer)ver_dob_src_e2, (integer)(integer)ver_dob_src_e3, (integer)(integer)ver_dob_src_e4);

		pk_pos_addr_src_major := if(max(ver_addr_src_emerge, (integer)ver_addr_src_bureau, (integer)ver_addr_src_pl, (integer)ver_addr_src_vo, (integer)ver_addr_src_wp, (integer)pk_pos_addr_src_minor_flag) = NULL, NULL, sum(if(ver_addr_src_emerge = NULL, 0, ver_addr_src_emerge), (integer)ver_addr_src_bureau, (integer)ver_addr_src_pl, (integer)ver_addr_src_vo, (integer)ver_addr_src_wp, (integer)pk_pos_addr_src_minor_flag));

		pk_pos_dob_src_major := if(max(ver_dob_src_emerge, (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag) = NULL, NULL, sum(if(ver_dob_src_emerge = NULL, 0, ver_dob_src_emerge), (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag));

		pk_pos_addr_src_cnt := min(3, if(pk_pos_addr_src_major = NULL, -NULL, pk_pos_addr_src_major));

		pk_pos_dob_src_cnt := min(2, if(pk_pos_dob_src_major = NULL, -NULL, pk_pos_dob_src_major));

		pk_bureau_only := if(ver_src_cnt = 1 and (integer)ver_src_bureau = 1, 1, 0);

		pk_mth_gong_did_first_seen := if (mth_gong_did_first_seen >= 0, roundup(mth_gong_did_first_seen), truncate(mth_gong_did_first_seen));

		pk_mth_gong_did_first_seen2 := map(
			pk_mth_gong_did_first_seen <= NULL => -1,
			pk_mth_gong_did_first_seen <= 25   => 0,
			pk_mth_gong_did_first_seen <= 40   => 1,
												  2);

		pk_mth_header_first_seen := if (mth_header_first_seen >= 0, roundup(mth_header_first_seen), truncate(mth_header_first_seen));

		pk_mth_header_first_seen2_s0 := map(
			pk_mth_header_first_seen <= NULL => -1,
			pk_mth_header_first_seen <= 13   => 0,
			pk_mth_header_first_seen <= 25   => 1,
			pk_mth_header_first_seen <= 41   => 2,
			pk_mth_header_first_seen <= 64   => 3,
			pk_mth_header_first_seen <= 100  => 4,
			pk_mth_header_first_seen <= 163  => 5,
			pk_mth_header_first_seen <= 207  => 6,
			pk_mth_header_first_seen <= 252  => 7,
			pk_mth_header_first_seen <= 319  => 8,
												9);

		pk_mth_header_first_seen2_s2 := map(
			pk_mth_header_first_seen <= NULL => -1,
			pk_mth_header_first_seen <= 100  => 0,
			pk_mth_header_first_seen <= 163  => 1,
			pk_mth_header_first_seen <= 207  => 2,
			pk_mth_header_first_seen <= 252  => 3,
			pk_mth_header_first_seen <= 319  => 4,
												5);

		pk_mth_header_first_seen2_s3 := map(
			pk_mth_header_first_seen <= NULL => -1,
			pk_mth_header_first_seen <= 100  => 0,
			pk_mth_header_first_seen <= 163  => 1,
			pk_mth_header_first_seen <= 207  => 2,
			pk_mth_header_first_seen <= 252  => 3,
			pk_mth_header_first_seen <= 319  => 4,
												5);

		pk_mth_infutor_first_seen := if (mth_infutor_first_seen >= 0, roundup(mth_infutor_first_seen), truncate(mth_infutor_first_seen));

		pk_mth_infutor_first_seen2 := map(
			pk_mth_infutor_first_seen <= NULL => -1,
			pk_mth_infutor_first_seen <= 28   => 0,
			pk_mth_infutor_first_seen <= 46   => 1,
												 2);

		pk_mth_ver_src_fdate_en := if (mth_ver_src_fdate_en >= 0, roundup(mth_ver_src_fdate_en), truncate(mth_ver_src_fdate_en));

		pk_mth_ver_src_fdate_eq := if (mth_ver_src_fdate_eq >= 0, roundup(mth_ver_src_fdate_eq), truncate(mth_ver_src_fdate_eq));

		pk_mth_ver_src_fdate_ts := if (mth_ver_src_fdate_ts >= 0, roundup(mth_ver_src_fdate_ts), truncate(mth_ver_src_fdate_ts));

		pk_mth_ver_src_fdate_wp := if (mth_ver_src_fdate_wp >= 0, roundup(mth_ver_src_fdate_wp), truncate(mth_ver_src_fdate_wp));

		pk_mth_ver_src_fdate_bureau := max(pk_mth_ver_src_fdate_eq, pk_mth_ver_src_fdate_en);

		pk_mth_ver_src_fdate_ts2 := map(
			pk_mth_ver_src_fdate_ts <= NULL => -1,
			pk_mth_ver_src_fdate_ts <= 13   => 0,
			pk_mth_ver_src_fdate_ts <= 37   => 1,
											   2);

		pk_mth_ver_src_fdate_wp2_s3 := map(
			pk_mth_ver_src_fdate_wp <= NULL => -1,
			pk_mth_ver_src_fdate_wp <= 14   => 0,
			pk_mth_ver_src_fdate_wp <= 23   => 1,
											   2);

		time_on_cb_gt_age := pk_age_estimate - 17 > truncate(pk_mth_ver_src_fdate_bureau / 12);

		pk_time_on_bureau_120 := map(
			NULL < pk_mth_ver_src_fdate_bureau and time_on_cb_gt_age => pk_mth_ver_src_fdate_bureau,
			pk_mth_ver_src_fdate_bureau = NULL                       => -10,
																		- 20);

		pk_time_on_cb_120b_s0 := map(
			pk_time_on_bureau_120 = -20  => -20,
			pk_time_on_bureau_120 = -10  => -10,
			pk_time_on_bureau_120 <= 25  => 0,
			pk_time_on_bureau_120 <= 35  => 1,
			pk_time_on_bureau_120 <= 54  => 2,
			pk_time_on_bureau_120 <= 100 => 3,
			pk_time_on_bureau_120 <= 146 => 4,
			pk_time_on_bureau_120 <= 198 => 5,
			pk_time_on_bureau_120 <= 248 => 6,
											7);

		pk_time_on_cb_120b_s1 := map(
			pk_time_on_bureau_120 = -20  => -20,
			pk_time_on_bureau_120 = -10  => -10,
			pk_time_on_bureau_120 <= 3   => 0,
			pk_time_on_bureau_120 <= 11  => 1,
			pk_time_on_bureau_120 <= 25  => 2,
			pk_time_on_bureau_120 <= 35  => 3,
			pk_time_on_bureau_120 <= 54  => 4,
			pk_time_on_bureau_120 <= 100 => 5,
			pk_time_on_bureau_120 <= 146 => 6,
			pk_time_on_bureau_120 <= 198 => 7,
			pk_time_on_bureau_120 <= 248 => 8,
											9);

		pk_time_on_cb_120b_s2 := map(
			pk_time_on_bureau_120 = -20  => -20,
			pk_time_on_bureau_120 = -10  => -10,
			pk_time_on_bureau_120 <= 146 => 0,
			pk_time_on_bureau_120 <= 198 => 1,
			pk_time_on_bureau_120 <= 248 => 2,
											3);

		pk_time_on_cb_120b_s3 := map(
			pk_time_on_bureau_120 = -20  => -20,
			pk_time_on_bureau_120 = -10  => -10,
			pk_time_on_bureau_120 <= 54  => 0,
			pk_time_on_bureau_120 <= 100 => 1,
			pk_time_on_bureau_120 <= 146 => 2,
			pk_time_on_bureau_120 <= 198 => 3,
			pk_time_on_bureau_120 <= 248 => 4,
											5);

		pk_addr_hist_advo_college := if(addr_hist_advo_college, 1, 0);

		pk_mth_add1_purchase_date := if (mth_add1_purchase_date >= 0, roundup(mth_add1_purchase_date), truncate(mth_add1_purchase_date));

		pk_mth_add1_built_date := if (mth_add1_built_date >= 0, roundup(mth_add1_built_date), truncate(mth_add1_built_date));

		pk_mth_add1_date_first_seen := if (mth_add1_date_first_seen >= 0, roundup(mth_add1_date_first_seen), truncate(mth_add1_date_first_seen));

		pk_mth_attr_date_first_purchase := if (mth_attr_date_first_purchase >= 0, roundup(mth_attr_date_first_purchase), truncate(mth_attr_date_first_purchase));

		pk_adj_finance := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

		pk_prop_owned_purch_flag := if(property_owned_purchase_count > 0, 1, 0);

		pk_prop_owned_assess_flag := if(property_owned_assessed_count > 0, 1, 0);

		pk_prop_sold_purch_flag := if(property_sold_purchase_count > 0, 1, 0);

		pk_prop_sold_assess_flag := if(property_sold_assessed_count > 0, 1, 0);

		pk_prop_owned_sold_lvl := map(
			pk_prop_owned_purch_flag = 1 and pk_prop_owned_assess_flag = 1 and (pk_prop_sold_purch_flag = 1 or pk_prop_sold_assess_flag = 1) => 4,
			pk_prop_owned_purch_flag = 1 and pk_prop_owned_assess_flag = 1                                                                   => 3,
			pk_prop_owned_purch_flag = 1 or pk_prop_owned_assess_flag = 1                                                                    => 2,
			pk_prop_sold_purch_flag = 1 or pk_prop_sold_assess_flag = 1                                                                      => 1,
																																				0);

		pk_ver_src_nas_p_lvl := map(
			ver_src_nas_p = 0  => 0,
			ver_src_nas_p <= 2 => 1,
								  2);

		pk_boat_plane_flag := watercraft_count > 0 or attr_num_aircraft > 0 or (integer)ver_src_eb > 0 or (integer)ver_src_w > 0 or (integer)ver_src_ar > 0;

		pk_property_owned_total := map(
			property_owned_total <= 0 => 0,
			property_owned_total <= 1 => 1,
			property_owned_total <= 4 => 2,
										 3);

		pk_property_sold_total := map(
			property_sold_total <= 0 => 0,
			property_sold_total <= 3 => 1,
										2);

		pk_prop_os_tot_tree := map(
			pk_property_owned_total = 3                                => 4,
			pk_property_owned_total = 2                                => 3,
			pk_property_owned_total = 1 and pk_property_sold_total > 0 => 3,
			pk_property_owned_total = 1                                => 2,
			pk_property_owned_total = 0 and pk_property_sold_total > 0 => 1,
																		  0);

		pk_attr_num_sold60 := if(attr_num_sold60 > 0, 1, 0);

		pk_addrs_5yr_s0 := map(
			addrs_5yr <= 0 => 0,
			addrs_5yr <= 1 => 1,
			addrs_5yr <= 2 => 2,
			addrs_5yr <= 4 => 3,
							  4);

		pk_unique_addr_count_s0 := map(
			unique_addr_count <= 0 => 0,
			unique_addr_count <= 1 => 1,
			unique_addr_count <= 2 => 2,
									  3);

		pk_avg_mo_per_addr_s0 := map(
			avg_mo_per_addr = -9999 => -1,
			avg_mo_per_addr <= 11   => 0,
			avg_mo_per_addr <= 15   => 1,
			avg_mo_per_addr <= 22   => 2,
			avg_mo_per_addr <= 41   => 3,
									   4);

		pk_addr_count_ge3_s0 := map(
			addr_count_ge3 <= -9999 => -1,
			addr_count_ge3 <= 0     => 0,
			addr_count_ge3 <= 1     => 1,
									   2);

		pk_mth_add1_dt_f_sn_s0 := map(
			pk_mth_add1_date_first_seen <= NULL => -1,
			pk_mth_add1_date_first_seen <= 8    => 0,
			pk_mth_add1_date_first_seen <= 11   => 1,
			pk_mth_add1_date_first_seen <= 13   => 2,
			pk_mth_add1_date_first_seen <= 27   => 3,
			pk_mth_add1_date_first_seen <= 44   => 4,
			pk_mth_add1_date_first_seen <= 56   => 5,
			pk_mth_add1_date_first_seen <= 149  => 6,
			pk_mth_add1_date_first_seen <= 233  => 7,
												   8);

		pk_ver_src_nas_p_lvl_s0 := map(
			pk_ver_src_nas_p_lvl <= 0 => 0,
			pk_ver_src_nas_p_lvl <= 1 => 1,
										 2);

		pk_prop_os_tot_tree_s0 := map(
			pk_prop_os_tot_tree <= 0 => 0,
			pk_prop_os_tot_tree <= 1 => 1,
			pk_prop_os_tot_tree <= 2 => 2,
			pk_prop_os_tot_tree <= 3 => 3,
										4);

		pk_unique_addr_count_s1 := map(
			unique_addr_count <= 2 => 0,
			unique_addr_count <= 3 => 1,
			unique_addr_count <= 4 => 2,
									  3);

		pk_avg_mo_per_addr_s1 := map(
			avg_mo_per_addr <= -9999 => -1,
			avg_mo_per_addr <= 3     => 0,
			avg_mo_per_addr <= 5     => 1,
			avg_mo_per_addr <= 8     => 2,
			avg_mo_per_addr <= 13    => 3,
			avg_mo_per_addr <= 26    => 4,
			avg_mo_per_addr <= 37    => 5,
										6);

		pk_addr_count_ge3_s1 := map(
			addr_count_ge3 <= 0 => 0,
			addr_count_ge3 <= 1 => 1,
								   2);

		pk_add_naprop_level_s1 := if(add_naprop_level <= 0, 0, 1);

		pk_mth_add1_built_date_s1 := map(
			pk_mth_add1_built_date <= NULL => -1,
			pk_mth_add1_built_date <= 335  => 0,
			pk_mth_add1_built_date <= 419  => 1,
			pk_mth_add1_built_date <= 635  => 2,
											  3);

		pk_mth_add1_dt_f_sn_s1 := map(
			pk_mth_add1_date_first_seen <= NULL => -1,
			pk_mth_add1_date_first_seen <= 3    => 0,
			pk_mth_add1_date_first_seen <= 13   => 1,
			pk_mth_add1_date_first_seen <= 37   => 2,
												   3);

		pk_addrs_5yr_s2 := map(
			addrs_5yr <= 0 => 0,
			addrs_5yr <= 1 => 1,
			addrs_5yr <= 2 => 2,
			addrs_5yr <= 3 => 3,
			addrs_5yr <= 4 => 4,
							  5);

		pk_avg_mo_per_addr_s2 := map(
			avg_mo_per_addr <= -9999 => -1,
			avg_mo_per_addr <= 18    => 0,
			avg_mo_per_addr <= 28    => 1,
			avg_mo_per_addr <= 33    => 2,
			avg_mo_per_addr <= 42    => 3,
			avg_mo_per_addr <= 55    => 4,
			avg_mo_per_addr <= 99    => 5,
										6);

		pk_add1_ownership_s2 := map(
			add1_ownership <= 1 => 0,
			add1_ownership <= 2 => 1,
			add1_ownership <= 3 => 2,
								   3);

		pk_mth_add1_purchase_date_s2 := map(
			pk_mth_add1_purchase_date <= NULL => -1,
			pk_mth_add1_purchase_date <= 20   => 0,
			pk_mth_add1_purchase_date <= 29   => 1,
			pk_mth_add1_purchase_date <= 38   => 2,
			pk_mth_add1_purchase_date <= 132  => 3,
												 4);

		pk_mth_attr_dt_first_prch_s2 := map(
			pk_mth_attr_date_first_purchase <= NULL => -1,
			pk_mth_attr_date_first_purchase <= 21   => 0,
			pk_mth_attr_date_first_purchase <= 51   => 1,
			pk_mth_attr_date_first_purchase <= 124  => 2,
			pk_mth_attr_date_first_purchase <= 194  => 3,
													   4);

		pk_prop_owned_sold_lvl_s2 := map(
			pk_prop_owned_sold_lvl <= 1 => 0,
			pk_prop_owned_sold_lvl <= 2 => 1,
			pk_prop_owned_sold_lvl <= 3 => 2,
										   3);

		pk_ver_src_nas_p_lvl_s2 := map(
			pk_ver_src_nas_p_lvl <= 0 => 0,
			pk_ver_src_nas_p_lvl <= 1 => 1,
										 2);

		pk_avg_mo_per_addr_s3 := map(
			avg_mo_per_addr <= 17 => 0,
			avg_mo_per_addr <= 29 => 1,
			avg_mo_per_addr <= 50 => 2,
			avg_mo_per_addr <= 66 => 3,
									 4);

		pk_addr_count_ge3_s3 := map(
			addr_count_ge3 <= -9999 => -1,
			addr_count_ge3 <= 0     => 0,
			addr_count_ge3 <= 1     => 1,
			addr_count_ge3 <= 2     => 2,
									   3);

		pk_mth_add1_dt_f_sn_s3 := map(
			pk_mth_add1_date_first_seen <= NULL => -1,
			pk_mth_add1_date_first_seen <= 2    => 0,
			pk_mth_add1_date_first_seen <= 4    => 1,
			pk_mth_add1_date_first_seen <= 27   => 2,
			pk_mth_add1_date_first_seen <= 101  => 3,
			pk_mth_add1_date_first_seen <= 152  => 4,
												   5);

		pk_ver_src_nas_p_lvl_s3 := map(
			pk_ver_src_nas_p_lvl <= 0 => 0,
			pk_ver_src_nas_p_lvl <= 1 => 1,
										 2);

		pk_yr_criminal_last_date := if (yr_criminal_last_date >= 0, roundup(yr_criminal_last_date), truncate(yr_criminal_last_date));

		pk_yr_felony_last_date := if (yr_felony_last_date >= 0, roundup(yr_felony_last_date), truncate(yr_felony_last_date));

		pk_yr_attr_date_last_eviction := if (yr_attr_date_last_eviction >= 0, roundup(yr_attr_date_last_eviction), truncate(yr_attr_date_last_eviction));

		pk_yr_liens_last_unrel_date := if (yr_liens_last_unrel_date >= 0, roundup(yr_liens_last_unrel_date), truncate(yr_liens_last_unrel_date));

		pk_yr_liens_unrel_cj_last_seen := if (yr_liens_unrel_cj_last_seen >= 0, roundup(yr_liens_unrel_cj_last_seen), truncate(yr_liens_unrel_cj_last_seen));

		pk_yr_liens_unrel_lt_last_seen := if (yr_liens_unrel_lt_last_seen >= 0, roundup(yr_liens_unrel_lt_last_seen), truncate(yr_liens_unrel_lt_last_seen));

		pk_yr_liens_unrel_sc_last_seen := if (yr_liens_unrel_sc_last_seen >= 0, roundup(yr_liens_unrel_sc_last_seen), truncate(yr_liens_unrel_sc_last_seen));

		pk_mth_ver_src_ldate_l2 := if (mth_ver_src_ldate_l2 >= 0, roundup(mth_ver_src_ldate_l2), truncate(mth_ver_src_ldate_l2));

		pk_mth_ver_src_ldate_li := if (mth_ver_src_ldate_li >= 0, roundup(mth_ver_src_ldate_li), truncate(mth_ver_src_ldate_li));

		pk_yr_criminal_last_date2 := map(
			pk_yr_criminal_last_date <= NULL => -1,
			pk_yr_criminal_last_date <= 1    => 1,
			pk_yr_criminal_last_date <= 2    => 2,
			pk_yr_criminal_last_date <= 3    => 3,
			pk_yr_criminal_last_date <= 4    => 4,
			pk_yr_criminal_last_date <= 5    => 5,
			pk_yr_criminal_last_date <= 6    => 6,
												7);

		pk_yr_felony_last_date2 := map(
			pk_yr_felony_last_date <= NULL => -1,
			pk_yr_felony_last_date <= 1    => 1,
			pk_yr_felony_last_date <= 2    => 2,
			pk_yr_felony_last_date <= 3    => 3,
			pk_yr_felony_last_date <= 4    => 4,
											  5);

		pk_crim_fel_date := map(
			pk_yr_felony_last_date2 >= 1             => pk_yr_felony_last_date2,
			(pk_yr_criminal_last_date2 in [1, 2])    => 6,
			(pk_yr_criminal_last_date2 in [3, 4, 5]) => 7,
														-1);

		pk_yr_attr_dt_last_evict2 := map(
			pk_yr_attr_date_last_eviction <= NULL => -1,
			pk_yr_attr_date_last_eviction <= 1    => 1,
			pk_yr_attr_date_last_eviction <= 2    => 2,
			pk_yr_attr_date_last_eviction <= 3    => 3,
			pk_yr_attr_date_last_eviction <= 4    => 4,
			pk_yr_attr_date_last_eviction <= 5    => 5,
													 6);

		pk_liens_unrel_cj_ct := map(
			liens_unrel_cj_ct <= 0 => 0,
			liens_unrel_cj_ct <= 1 => 1,
			liens_unrel_cj_ct <= 2 => 2,
									  3);

		pk_liens_rel_cj_ct := if(liens_rel_cj_ct <= 0, 0, 1);

		pk_liens_unrel_lt_ct := if(liens_unrel_lt_ct <= 0, 0, 1);

		pk_liens_rel_lt_ct := if(liens_rel_lt_ct <= 0, 0, 1);

		pk_liens_unrel_sc_ct := map(
			liens_unrel_sc_ct <= 0 => 0,
			liens_unrel_sc_ct <= 1 => 1,
									  2);

		pk_lien_tree := map(
			pk_liens_unrel_lt_ct > 0                               => 4,
			pk_liens_unrel_cj_ct >= 3 or pk_liens_unrel_sc_ct >= 2 => 3,
			pk_liens_unrel_cj_ct >= 1 or pk_liens_unrel_sc_ct >= 1 => 2,
			pk_liens_rel_cj_ct > 0 or pk_liens_rel_lt_ct > 0       => 1,
																	  0);

		pk_unrel_last_sn_dt := if(max(pk_yr_liens_unrel_cj_last_seen, pk_yr_liens_unrel_lt_last_seen, pk_yr_liens_unrel_sc_last_seen) = NULL, NULL, min(if(pk_yr_liens_unrel_cj_last_seen = NULL, -NULL, pk_yr_liens_unrel_cj_last_seen), if(pk_yr_liens_unrel_lt_last_seen = NULL, -NULL, pk_yr_liens_unrel_lt_last_seen), if(pk_yr_liens_unrel_sc_last_seen = NULL, -NULL, pk_yr_liens_unrel_sc_last_seen)));

		pk_ver_src_ldate_lien := if(max(pk_mth_ver_src_ldate_li, pk_mth_ver_src_ldate_l2) = NULL, NULL, min(if(pk_mth_ver_src_ldate_li = NULL, -NULL, pk_mth_ver_src_ldate_li), if(pk_mth_ver_src_ldate_l2 = NULL, -NULL, pk_mth_ver_src_ldate_l2)));

		pk_ver_src_ldate_lien2 := map(
			pk_ver_src_ldate_lien <= NULL => -1,
			pk_ver_src_ldate_lien <= 13   => 0,
			pk_ver_src_ldate_lien <= 24   => 1,
			pk_ver_src_ldate_lien <= 40   => 2,
			pk_ver_src_ldate_lien <= 84   => 3,
											 4);

		pk_unrel_last_sn_dt2 := map(
			pk_unrel_last_sn_dt >= 4                                                               => 4,
			pk_unrel_last_sn_dt >= 1                                                               => pk_unrel_last_sn_dt,
			(pk_yr_liens_last_unrel_date in [1, 2, 3, 4]) or (pk_ver_src_ldate_lien2 in [0, 1, 2]) => 5,
																									  0);

		inq_hit := if(inq_count12 > 0, 1, 0);

		pk_inq_banking_count06_s2 := map(
			inq_hit = 0              => -1,
			inq_banking_count06 <= 0 => 0,
										1);

		pk_inq_banking_count06_s3 := map(
			inq_hit = 0              => -1,
			inq_banking_count06 <= 0 => 0,
										1);

		pk_inq_count06_s1 := map(
			inq_hit = 0      => -1,
			inq_count06 <= 0 => 0,
			inq_count06 <= 1 => 1,
								2);

		pk_inq_peradl := map(
			inq_peradl <= 0 => 0,
			inq_peradl <= 1 => 1,
							   2);

		pk_inq_adlsperaddr_s2 := map(
			(integer)add_apt = 0 and inq_adlsperaddr <= 0 => 0,
			(integer)add_apt = 0 and inq_adlsperaddr <= 1 => 1,
			(integer)add_apt = 0                          => 2,
			(integer)add_apt = 1 and inq_adlsperaddr <= 0 => 10,
															 11);

		pk_inq_ssnsperaddr := map(
			(integer)add_apt = 0 and inq_ssnsperaddr <= 0 => 0,
			(integer)add_apt = 0 and inq_ssnsperaddr <= 1 => 1,
			(integer)add_apt = 0                          => 2,
			(integer)add_apt = 1 and inq_ssnsperaddr <= 0 => 10,
															 11);

		pk_inq_perphone_s1 := map(
			inq_perphone <= 0 => 0,
			inq_perphone <= 1 => 1,
								 2);

		pk_inq_perphone_s2 := if(inq_perphone <= 0, 0, 1);

		pk_inq_adlsperphone_s3 := map(
			inq_adlsperphone <= 0 => 0,
			inq_adlsperphone <= 1 => 1,
									 2);

		pk_per_adl_tree2 := if(lnames_per_adl_c6 >= 2 or ssns_per_adl_c6 >= 3, 1, 0);

		pk_addrs_per_ssn_c6 := map(
			addrs_per_ssn_c6 <= 0 => 0,
			addrs_per_ssn_c6 <= 1 => 1,
									 2);

		pk_adls_per_addr_c6_s0 := map(
			(integer)add_apt = 0 and adls_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 2 => 2,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 4 => 3,
			(integer)add_apt = 0                           => 4,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 1 => 11,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 2 => 12,
															  13);

		pk_adls_per_addr_c6_s1 := map(
			(integer)add_apt = 0 and adls_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 2 => 2,
			(integer)add_apt = 0 and adls_per_addr_c6 <= 4 => 3,
			(integer)add_apt = 0                           => 4,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 1 => 11,
			(integer)add_apt = 1 and adls_per_addr_c6 <= 2 => 12,
															  13);

		pk_ssns_per_addr_c6_s2 := map(
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 2 => 2,
			(integer)add_apt = 0                           => 3,
			(integer)add_apt = 1 and ssns_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and ssns_per_addr_c6 <= 1 => 11,
															  12);

		pk_ssns_per_addr_c6_s3 := map(
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 2 => 2,
			(integer)add_apt = 0 and ssns_per_addr_c6 <= 3 => 3,
			(integer)add_apt = 0                           => 4,
			(integer)add_apt = 1 and ssns_per_addr_c6 <= 0 => 10,
															  11);

		pk_phones_per_addr_c6_s0 := map(
			(integer)add_apt = 0 and phones_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and phones_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0                             => 2,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 1 => 11,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 2 => 12,
																13);

		pk_phones_per_addr_c6_s1 := map(
			(integer)add_apt = 0 and phones_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0                             => 1,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 1 => 11,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 2 => 12,
																13);

		pk_phones_per_addr_c6_s3 := map(
			(integer)add_apt = 0 and phones_per_addr_c6 <= 0 => 0,
			(integer)add_apt = 0 and phones_per_addr_c6 <= 1 => 1,
			(integer)add_apt = 0                             => 2,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 0 => 10,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 1 => 11,
			(integer)add_apt = 1 and phones_per_addr_c6 <= 2 => 12,
																13);

		pk_attr_addrs_last12 := map(
			attr_addrs_last12 <= 0 => 0,
			attr_addrs_last12 <= 1 => 1,
			attr_addrs_last12 <= 2 => 2,
									  3);

		pk_addr_adl_tree := map(
			pk_attr_addrs_last12 > 0 => pk_attr_addrs_last12,
			attr_addrs_last36 = 0    => -2,
			attr_addrs_last24 = 0    => -1,
										0);

		pk_ssns_per_adl_s1 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
			ssns_per_adl <= 2 => 1,
			ssns_per_adl <= 3 => 2,
								 3);

		pk_ssns_per_adl_s2 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
			ssns_per_adl <= 2 => 1,
								 2);

		pk_ssns_per_adl_s3 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
			ssns_per_adl <= 2 => 1,
			ssns_per_adl <= 3 => 2,
								 3);

		pk_addrs_per_adl_s0 := map(
			addrs_per_adl <= 0 => -1,
			addrs_per_adl <= 1 => 0,
			addrs_per_adl <= 2 => 1,
			addrs_per_adl <= 3 => 2,
			addrs_per_adl <= 4 => 3,
			addrs_per_adl <= 5 => 4,
								  5);

		pk_phones_per_adl_s3 := map(
			phones_per_adl <= 0 => -1,
			phones_per_adl <= 1 => 0,
								   1);

		pk_nameperssn_count := if(nameperssn_count <= 0, 0, 1);

		pk_adlperssn_count_s1 := map(
			adlperssn_count <= 0 => -1,
			adlperssn_count <= 1 => 0,
			adlperssn_count <= 2 => 1,
									2);

		pk_adlperssn_count_s3 := map(
			adlperssn_count <= 0 => -1,
			adlperssn_count <= 1 => 0,
			adlperssn_count <= 2 => 1,
									2);

		pk_addrs_per_ssn_s1 := map(
			addrs_per_ssn <= 0 => -1,
			addrs_per_ssn <= 1 => 0,
			addrs_per_ssn <= 2 => 1,
								  2);

		pk_addrs_per_ssn_s2 := map(
			addrs_per_ssn <= 0 => -1,
			addrs_per_ssn <= 1 => 0,
			addrs_per_ssn <= 2 => 1,
								  2);

		pk_addrs_per_ssn_s3 := map(
			addrs_per_ssn <= 0 => -1,
			addrs_per_ssn <= 1 => 0,
			addrs_per_ssn <= 2 => 1,
								  2);

		pk_ssns_per_addr_s1 := map(
			(integer)add_apt = 0 and ssns_per_addr <= 1  => -2,
			(integer)add_apt = 0 and ssns_per_addr <= 2  => -1,
			(integer)add_apt = 0 and ssns_per_addr <= 4  => 0,
			(integer)add_apt = 0 and ssns_per_addr <= 5  => 1,
			(integer)add_apt = 0 and ssns_per_addr <= 6  => 2,
			(integer)add_apt = 0 and ssns_per_addr <= 8  => 3,
			(integer)add_apt = 0 and ssns_per_addr <= 10 => 4,
			(integer)add_apt = 0 and ssns_per_addr <= 11 => 5,
			(integer)add_apt = 0 and ssns_per_addr <= 12 => 6,
			(integer)add_apt = 0 and ssns_per_addr <= 15 => 7,
			(integer)add_apt = 0 and ssns_per_addr <= 19 => 8,
			(integer)add_apt = 0                         => 9,
			(integer)add_apt = 1 and ssns_per_addr <= 1  => -101,
			(integer)add_apt = 1 and ssns_per_addr <= 2  => 100,
															101);

		pk_ssns_per_addr_s2 := map(
			(integer)add_apt = 0 and ssns_per_addr <= 0  => -2,
			(integer)add_apt = 0 and ssns_per_addr <= 1  => -1,
			(integer)add_apt = 0 and ssns_per_addr <= 2  => 0,
			(integer)add_apt = 0 and ssns_per_addr <= 4  => 1,
			(integer)add_apt = 0 and ssns_per_addr <= 6  => 2,
			(integer)add_apt = 0 and ssns_per_addr <= 8  => 3,
			(integer)add_apt = 0 and ssns_per_addr <= 9  => 4,
			(integer)add_apt = 0 and ssns_per_addr <= 12 => 5,
			(integer)add_apt = 0 and ssns_per_addr <= 15 => 6,
			(integer)add_apt = 0 and ssns_per_addr <= 19 => 7,
			(integer)add_apt = 0                         => 8,
			(integer)add_apt = 1 and ssns_per_addr <= 1  => -101,
			(integer)add_apt = 1 and ssns_per_addr <= 2  => 100,
															101);

		pk_ssns_per_addr_s3 := map(
			(integer)add_apt = 0 and ssns_per_addr <= 0  => -2,
			(integer)add_apt = 0 and ssns_per_addr <= 1  => -1,
			(integer)add_apt = 0 and ssns_per_addr <= 2  => 0,
			(integer)add_apt = 0 and ssns_per_addr <= 4  => 1,
			(integer)add_apt = 0 and ssns_per_addr <= 5  => 2,
			(integer)add_apt = 0 and ssns_per_addr <= 7  => 3,
			(integer)add_apt = 0 and ssns_per_addr <= 8  => 4,
			(integer)add_apt = 0 and ssns_per_addr <= 9  => 5,
			(integer)add_apt = 0 and ssns_per_addr <= 10 => 6,
			(integer)add_apt = 0 and ssns_per_addr <= 12 => 7,
			(integer)add_apt = 0 and ssns_per_addr <= 15 => 8,
			(integer)add_apt = 0 and ssns_per_addr <= 19 => 9,
			(integer)add_apt = 0                         => 10,
															100);

		pk_phones_per_addr_s3 := map(
			(integer)add_apt = 0 and phones_per_addr <= 0 => -1,
			(integer)add_apt = 0 and phones_per_addr <= 1 => 0,
			(integer)add_apt = 0 and phones_per_addr <= 2 => 1,
			(integer)add_apt = 0 and phones_per_addr <= 3 => 2,
			(integer)add_apt = 0                          => 3,
			(integer)add_apt = 1 and phones_per_addr <= 2 => 10,
															 11);

		pk_adls_per_phone_s1 := map(
			adls_per_phone <= 0 => 0,
			adls_per_phone <= 1 => 1,
								   2);

		pk_adls_per_phone_s2 := map(
			adls_per_phone <= 0 => 0,
			adls_per_phone <= 1 => 1,
								   2);

		pk_adls_per_phone_s3 := if(adls_per_phone <= 0, 0, 1);

		pk_ssn_lowissue_age := if (ssn_lowissue_age >= 0, roundup(ssn_lowissue_age), truncate(ssn_lowissue_age));

		pk_ssn_lowissue_age2_s0 := map(
			pk_ssn_lowissue_age = NULL => -1,
			pk_ssn_lowissue_age <= 0   => 0,
			pk_ssn_lowissue_age <= 1   => 1,
			pk_ssn_lowissue_age <= 3   => 2,
			pk_ssn_lowissue_age <= 5   => 3,
			pk_ssn_lowissue_age <= 7   => 4,
			pk_ssn_lowissue_age <= 10  => 5,
			pk_ssn_lowissue_age <= 13  => 6,
										  7);

		pk_ssn_lowissue_age2_s1 := map(
			pk_ssn_lowissue_age = NULL => -1,
			pk_ssn_lowissue_age <= 0   => 0,
			pk_ssn_lowissue_age <= 1   => 1,
										  2);

		pk_dist_a1toa2_b := map(
			dist_a1toa2 = 9999 => -9,
			dist_a1toa2 <= 0   => -1,
			dist_a1toa2 <= 2   => 0,
			dist_a1toa2 <= 10  => 1,
			dist_a1toa2 <= 50  => 2,
								  3);

		pk_dist_a1toa2_b_1m := map(
			pk_dist_a1toa2_b = -9 => 0.1363990647,
			pk_dist_a1toa2_b = -1 => 0.1579169837,
			pk_dist_a1toa2_b = 0  => 0.2220140515,
			pk_dist_a1toa2_b = 1  => 0.1796176903,
			pk_dist_a1toa2_b = 2  => 0.1562400762,
			pk_dist_a1toa2_b = 3  => 0.1344882836,
									 0.1519197544);

		pk_dist_a1toa2_b_2m := map(
			pk_dist_a1toa2_b = -9 => 0.022759202,
			pk_dist_a1toa2_b = -1 => 0.0344738589,
			pk_dist_a1toa2_b = 0  => 0.0434052758,
			pk_dist_a1toa2_b = 1  => 0.0411321523,
			pk_dist_a1toa2_b = 2  => 0.0396656535,
			pk_dist_a1toa2_b = 3  => 0.0291432822,
									 0.0358788996);

		pk_age_estimate_s1_1m := map(
			pk_age_estimate_s1 = 0 => 0.2063354516,
			pk_age_estimate_s1 = 1 => 0.179739431,
			pk_age_estimate_s1 = 2 => 0.1562899577,
			pk_age_estimate_s1 = 3 => 0.1455897981,
			pk_age_estimate_s1 = 4 => 0.1181355478,
			pk_age_estimate_s1 = 5 => 0.0997805166,
									  0.1519197544);

		pk_age_estimate_s2_2m := map(
			pk_age_estimate_s2 = 0 => 0.0746812386,
			pk_age_estimate_s2 = 1 => 0.0699196111,
			pk_age_estimate_s2 = 2 => 0.0546147333,
			pk_age_estimate_s2 = 3 => 0.0424325381,
			pk_age_estimate_s2 = 4 => 0.0297116737,
			pk_age_estimate_s2 = 5 => 0.0179874214,
			pk_age_estimate_s2 = 6 => 0.0149564559,
									  0.0358788996);

		pk_age_estimate_s3_3m := map(
			pk_age_estimate_s3 = 0 => 0.0930447224,
			pk_age_estimate_s3 = 1 => 0.0888619202,
			pk_age_estimate_s3 = 2 => 0.0651025153,
			pk_age_estimate_s3 = 3 => 0.0493748676,
			pk_age_estimate_s3 = 4 => 0.0400281723,
			pk_age_estimate_s3 = 5 => 0.0239539749,
									  0.0655296669);

		pk_crim_fel_date_0m := map(
			pk_crim_fel_date = -1 => 0.1423313266,
			pk_crim_fel_date = 1  => 0.448,
			pk_crim_fel_date = 2  => 0.3859649123,
			pk_crim_fel_date = 3  => 0.3363636364,
			pk_crim_fel_date = 4  => 0.3177570093,
			pk_crim_fel_date = 5  => 0.2661596958,
			pk_crim_fel_date = 6  => 0.2368775236,
			pk_crim_fel_date = 7  => 0.1769436997,
									 0.1491814282);

		pk_yr_attr_dt_last_evict2_0m := map(
			pk_yr_attr_dt_last_evict2 = -1 => 0.1401640117,
			pk_yr_attr_dt_last_evict2 = 1  => 0.3885601578,
			pk_yr_attr_dt_last_evict2 = 2  => 0.3464566929,
			pk_yr_attr_dt_last_evict2 = 3  => 0.2679127726,
			pk_yr_attr_dt_last_evict2 = 4  => 0.2334384858,
			pk_yr_attr_dt_last_evict2 = 5  => 0.2012987013,
			pk_yr_attr_dt_last_evict2 = 6  => 0.1650165017,
											  0.1491814282);

		pk_lien_tree_0m := map(
			pk_lien_tree = 0 => 0.1351682199,
			pk_lien_tree = 1 => 0.1432360743,
			pk_lien_tree = 2 => 0.1758474576,
			pk_lien_tree = 3 => 0.234705228,
			pk_lien_tree = 4 => 0.3049853372,
								0.1491814282);

		pk_unrel_last_sn_dt2_0m := map(
			pk_unrel_last_sn_dt2 = 0 => 0.1348257006,
			pk_unrel_last_sn_dt2 = 1 => 0.2829940906,
			pk_unrel_last_sn_dt2 = 2 => 0.2151589242,
			pk_unrel_last_sn_dt2 = 3 => 0.1703056769,
			pk_unrel_last_sn_dt2 = 4 => 0.160922217,
			pk_unrel_last_sn_dt2 = 5 => 0.1404494382,
										0.1491814282);

		pk_estimated_income_s1_1m := map(
			pk_estimated_income_s1 = 0 => 0.2231075697,
			pk_estimated_income_s1 = 1 => 0.2141700405,
			pk_estimated_income_s1 = 2 => 0.1946554886,
			pk_estimated_income_s1 = 3 => 0.1754944306,
			pk_estimated_income_s1 = 4 => 0.1653150343,
			pk_estimated_income_s1 = 5 => 0.1619458128,
			pk_estimated_income_s1 = 6 => 0.1471165644,
			pk_estimated_income_s1 = 7 => 0.1368865931,
			pk_estimated_income_s1 = 8 => 0.117768766,
			pk_estimated_income_s1 = 9 => 0.1058351446,
										  0.1519197544);

		pk_add1_avm_auto_val_s1_1m := map(
			pk_add1_avm_auto_val_s1 = -1 => 0.1636079656,
			pk_add1_avm_auto_val_s1 = 0  => 0.2494929006,
			pk_add1_avm_auto_val_s1 = 1  => 0.2204081633,
			pk_add1_avm_auto_val_s1 = 2  => 0.1940298507,
			pk_add1_avm_auto_val_s1 = 3  => 0.159370587,
			pk_add1_avm_auto_val_s1 = 4  => 0.128260534,
			pk_add1_avm_auto_val_s1 = 5  => 0.1218536423,
			pk_add1_avm_auto_val_s1 = 6  => 0.0945,
											0.1519197544);

		pk_estimated_income_s2_2m := map(
			pk_estimated_income_s2 = 0 => 0.0527363184,
			pk_estimated_income_s2 = 1 => 0.0403051349,
			pk_estimated_income_s2 = 2 => 0.0326581702,
			pk_estimated_income_s2 = 3 => 0.0305692515,
										  0.0358788996);

		pk_add1_avm_auto_val_s2_2m := map(
			pk_add1_avm_auto_val_s2 = -1 => 0.0358698234,
			pk_add1_avm_auto_val_s2 = 0  => 0.0515214385,
			pk_add1_avm_auto_val_s2 = 1  => 0.0403025177,
			pk_add1_avm_auto_val_s2 = 2  => 0.033856933,
											0.0358788996);

		pk_add1_avm_auto_val_s3_3m := map(
			pk_add1_avm_auto_val_s3 = -1 => 0.061606087,
			pk_add1_avm_auto_val_s3 = 0  => 0.1280353201,
			pk_add1_avm_auto_val_s3 = 1  => 0.1018981019,
			pk_add1_avm_auto_val_s3 = 2  => 0.0799200799,
			pk_add1_avm_auto_val_s3 = 3  => 0.0718333589,
											0.0655296669);

		pk_addrs_5yr_s0_0m := map(
			pk_addrs_5yr_s0 = 0 => 0.1040223162,
			pk_addrs_5yr_s0 = 1 => 0.151718081,
			pk_addrs_5yr_s0 = 2 => 0.1668007077,
			pk_addrs_5yr_s0 = 3 => 0.1894719082,
			pk_addrs_5yr_s0 = 4 => 0.2177801157,
								   0.1491814282);

		pk_unique_addr_count_s0_0m := map(
			pk_unique_addr_count_s0 = 0 => 0.3176470588,
			pk_unique_addr_count_s0 = 1 => 0.2554240631,
			pk_unique_addr_count_s0 = 2 => 0.1944084429,
			pk_unique_addr_count_s0 = 3 => 0.1259452717,
										   0.1491814282);

		pk_avg_mo_per_addr_s0_0m := map(
			pk_avg_mo_per_addr_s0 = -1 => 0.2955665025,
			pk_avg_mo_per_addr_s0 = 0  => 0.3877703207,
			pk_avg_mo_per_addr_s0 = 1  => 0.2638259293,
			pk_avg_mo_per_addr_s0 = 2  => 0.1930900872,
			pk_avg_mo_per_addr_s0 = 3  => 0.1479424618,
			pk_avg_mo_per_addr_s0 = 4  => 0.115057871,
										  0.1491814282);

		pk_addr_count_ge3_s0_0m := map(
			pk_addr_count_ge3_s0 = -1 => 0.3176470588,
			pk_addr_count_ge3_s0 = 0  => 0.2980743152,
			pk_addr_count_ge3_s0 = 1  => 0.1729174403,
			pk_addr_count_ge3_s0 = 2  => 0.1147284045,
										 0.1491814282);

		pk_mth_add1_dt_f_sn_s0_0m := map(
			pk_mth_add1_dt_f_sn_s0 = -1 => 0.2738990333,
			pk_mth_add1_dt_f_sn_s0 = 0  => 0.2258258258,
			pk_mth_add1_dt_f_sn_s0 = 1  => 0.2007874016,
			pk_mth_add1_dt_f_sn_s0 = 2  => 0.1864181092,
			pk_mth_add1_dt_f_sn_s0 = 3  => 0.1653504442,
			pk_mth_add1_dt_f_sn_s0 = 4  => 0.1549124514,
			pk_mth_add1_dt_f_sn_s0 = 5  => 0.1378755365,
			pk_mth_add1_dt_f_sn_s0 = 6  => 0.1160454417,
			pk_mth_add1_dt_f_sn_s0 = 7  => 0.0857972545,
			pk_mth_add1_dt_f_sn_s0 = 8  => 0.0659685864,
										   0.1491814282);

		pk_ver_src_nas_p_lvl_s0_0m := map(
			pk_ver_src_nas_p_lvl_s0 = 0 => 0.2041919806,
			pk_ver_src_nas_p_lvl_s0 = 1 => 0.1041666667,
			pk_ver_src_nas_p_lvl_s0 = 2 => 0.0932886609,
										   0.1491814282);

		pk_prop_os_tot_tree_s0_0m := map(
			pk_prop_os_tot_tree_s0 = 0 => 0.2003240713,
			pk_prop_os_tot_tree_s0 = 1 => 0.1176786674,
			pk_prop_os_tot_tree_s0 = 2 => 0.1020624008,
			pk_prop_os_tot_tree_s0 = 3 => 0.0952302087,
			pk_prop_os_tot_tree_s0 = 4 => 0.06,
										  0.1491814282);

		pk_unique_addr_count_s1_1m := map(
			pk_unique_addr_count_s1 = 0 => 0.1555290695,
			pk_unique_addr_count_s1 = 1 => 0.1413255361,
			pk_unique_addr_count_s1 = 2 => 0.1255605381,
			pk_unique_addr_count_s1 = 3 => 0.1203007519,
										   0.1519197544);

		pk_avg_mo_per_addr_s1_1m := map(
			pk_avg_mo_per_addr_s1 = -1 => 0.1555880205,
			pk_avg_mo_per_addr_s1 = 0  => 0.2389254073,
			pk_avg_mo_per_addr_s1 = 1  => 0.1941505912,
			pk_avg_mo_per_addr_s1 = 2  => 0.1840518541,
			pk_avg_mo_per_addr_s1 = 3  => 0.1679009733,
			pk_avg_mo_per_addr_s1 = 4  => 0.1410060544,
			pk_avg_mo_per_addr_s1 = 5  => 0.1228830782,
			pk_avg_mo_per_addr_s1 = 6  => 0.1068025704,
										  0.1519197544);

		pk_addr_count_ge3_s1_1m := map(
			pk_addr_count_ge3_s1 = 0 => 0.1631896528,
			pk_addr_count_ge3_s1 = 1 => 0.141567375,
			pk_addr_count_ge3_s1 = 2 => 0.1130448416,
										0.1519197544);

		pk_add_naprop_level_s1_1m := map(
			pk_add_naprop_level_s1 = 0 => 0.1835601617,
			pk_add_naprop_level_s1 = 1 => 0.1065523576,
										  0.1519197544);

		pk_mth_add1_built_date_s1_1m := map(
			pk_mth_add1_built_date_s1 = -1 => 0.1588773055,
			pk_mth_add1_built_date_s1 = 0  => 0.1189470263,
			pk_mth_add1_built_date_s1 = 1  => 0.1322256836,
			pk_mth_add1_built_date_s1 = 2  => 0.1535598706,
			pk_mth_add1_built_date_s1 = 3  => 0.1852795471,
											  0.1519197544);

		pk_mth_add1_dt_f_sn_s1_1m := map(
			pk_mth_add1_dt_f_sn_s1 = -1 => 0.1982918992,
			pk_mth_add1_dt_f_sn_s1 = 0  => 0.1927710843,
			pk_mth_add1_dt_f_sn_s1 = 1  => 0.1585373489,
			pk_mth_add1_dt_f_sn_s1 = 2  => 0.1309403136,
			pk_mth_add1_dt_f_sn_s1 = 3  => 0.1038961039,
										   0.1519197544);

		pk_addrs_5yr_s2_2m := map(
			pk_addrs_5yr_s2 = 0 => 0.0247036063,
			pk_addrs_5yr_s2 = 1 => 0.0362266338,
			pk_addrs_5yr_s2 = 2 => 0.0473598258,
			pk_addrs_5yr_s2 = 3 => 0.0554363376,
			pk_addrs_5yr_s2 = 4 => 0.0697240865,
			pk_addrs_5yr_s2 = 5 => 0.0907381288,
								   0.0358788996);

		pk_avg_mo_per_addr_s2_2m := map(
			pk_avg_mo_per_addr_s2 = -1 => 0.0961538462,
			pk_avg_mo_per_addr_s2 = 0  => 0.0824852705,
			pk_avg_mo_per_addr_s2 = 1  => 0.0631938514,
			pk_avg_mo_per_addr_s2 = 2  => 0.0526929808,
			pk_avg_mo_per_addr_s2 = 3  => 0.0440779921,
			pk_avg_mo_per_addr_s2 = 4  => 0.031707136,
			pk_avg_mo_per_addr_s2 = 5  => 0.0266471562,
			pk_avg_mo_per_addr_s2 = 6  => 0.0182135729,
										  0.0358788996);

		pk_add1_ownership_s2_2m := map(
			pk_add1_ownership_s2 = 0 => 0.0520825101,
			pk_add1_ownership_s2 = 1 => 0.0436893204,
			pk_add1_ownership_s2 = 2 => 0.0403580863,
			pk_add1_ownership_s2 = 3 => 0.0290110836,
										0.0358788996);

		pk_mth_add1_purchase_date_s2_2m := map(
			pk_mth_add1_purchase_date_s2 = -1 => 0.0332513054,
			pk_mth_add1_purchase_date_s2 = 0  => 0.0561907418,
			pk_mth_add1_purchase_date_s2 = 1  => 0.0460768438,
			pk_mth_add1_purchase_date_s2 = 2  => 0.0339927021,
			pk_mth_add1_purchase_date_s2 = 3  => 0.0245196706,
			pk_mth_add1_purchase_date_s2 = 4  => 0.0162390699,
												 0.0358788996);

		pk_mth_attr_dt_first_prch_s2_2m := map(
			pk_mth_attr_dt_first_prch_s2 = -1 => 0.0286217525,
			pk_mth_attr_dt_first_prch_s2 = 0  => 0.0632780083,
			pk_mth_attr_dt_first_prch_s2 = 1  => 0.0539325843,
			pk_mth_attr_dt_first_prch_s2 = 2  => 0.0381729201,
			pk_mth_attr_dt_first_prch_s2 = 3  => 0.0262826879,
			pk_mth_attr_dt_first_prch_s2 = 4  => 0.019719507,
												 0.0358788996);

		pk_prop_owned_sold_lvl_s2_2m := map(
			pk_prop_owned_sold_lvl_s2 = 0 => 0.0401570813,
			pk_prop_owned_sold_lvl_s2 = 1 => 0.0362068489,
			pk_prop_owned_sold_lvl_s2 = 2 => 0.0312951094,
			pk_prop_owned_sold_lvl_s2 = 3 => 0.0294564804,
											 0.0358788996);

		pk_ver_src_nas_p_lvl_s2_2m := map(
			pk_ver_src_nas_p_lvl_s2 = 0 => 0.044991511,
			pk_ver_src_nas_p_lvl_s2 = 1 => 0.0375450389,
			pk_ver_src_nas_p_lvl_s2 = 2 => 0.0333815792,
										   0.0358788996);

		pk_avg_mo_per_addr_s3_3m := map(
			pk_avg_mo_per_addr_s3 = 0 => 0.1020282729,
			pk_avg_mo_per_addr_s3 = 1 => 0.085734364,
			pk_avg_mo_per_addr_s3 = 2 => 0.0713834491,
			pk_avg_mo_per_addr_s3 = 3 => 0.0529284686,
			pk_avg_mo_per_addr_s3 = 4 => 0.0400566245,
										 0.0655296669);

		pk_addr_count_ge3_s3_3m := map(
			pk_addr_count_ge3_s3 = -1 => 0.1206896552,
			pk_addr_count_ge3_s3 = 0  => 0.0940560237,
			pk_addr_count_ge3_s3 = 1  => 0.0635507917,
			pk_addr_count_ge3_s3 = 2  => 0.0566955464,
			pk_addr_count_ge3_s3 = 3  => 0.0503854456,
										 0.0655296669);

		pk_mth_add1_dt_f_sn_s3_3m := map(
			pk_mth_add1_dt_f_sn_s3 = -1 => 0.1076808629,
			pk_mth_add1_dt_f_sn_s3 = 0  => 0.1035625518,
			pk_mth_add1_dt_f_sn_s3 = 1  => 0.0904584882,
			pk_mth_add1_dt_f_sn_s3 = 2  => 0.084230572,
			pk_mth_add1_dt_f_sn_s3 = 3  => 0.0648187633,
			pk_mth_add1_dt_f_sn_s3 = 4  => 0.0441265608,
			pk_mth_add1_dt_f_sn_s3 = 5  => 0.0283428797,
										   0.0655296669);

		pk_ver_src_nas_p_lvl_s3_3m := map(
			pk_ver_src_nas_p_lvl_s3 = 0 => 0.0713321464,
			pk_ver_src_nas_p_lvl_s3 = 1 => 0.0453102962,
			pk_ver_src_nas_p_lvl_s3 = 2 => 0.025516938,
										   0.0655296669);

		pk_impulse_count_0m := map(
			pk_impulse_count = 0 => 0.1301859357,
			pk_impulse_count = 1 => 0.4511278195,
			pk_impulse_count = 2 => 0.576744186,
									0.1491814282);

		pk_inq_peradl_0m := map(
			pk_inq_peradl = 0 => 0.1352414584,
			pk_inq_peradl = 1 => 0.3430267062,
			pk_inq_peradl = 2 => 0.5618729097,
								 0.1491814282);

		pk_inq_ssnsperaddr_0m := map(
			pk_inq_ssnsperaddr = 0  => 0.1233882317,
			pk_inq_ssnsperaddr = 1  => 0.2678571429,
			pk_inq_ssnsperaddr = 2  => 0.385786802,
			pk_inq_ssnsperaddr = 10 => 0.1998702141,
			pk_inq_ssnsperaddr = 11 => 0.2671480144,
									   0.1491814282);

		pk_inq_count06_s1_1m := map(
			pk_inq_count06_s1 = -1 => 0.1372722579,
			pk_inq_count06_s1 = 0  => 0.2357673267,
			pk_inq_count06_s1 = 1  => 0.3086578693,
			pk_inq_count06_s1 = 2  => 0.4099099099,
									  0.1519197544);

		pk_inq_ssnsperaddr_1m := map(
			pk_inq_ssnsperaddr = 0  => 0.128611965,
			pk_inq_ssnsperaddr = 1  => 0.242757454,
			pk_inq_ssnsperaddr = 2  => 0.3210616438,
			pk_inq_ssnsperaddr = 10 => 0.1704656996,
			pk_inq_ssnsperaddr = 11 => 0.2352941176,
									   0.1519197544);

		pk_inq_perphone_s1_1m := map(
			pk_inq_perphone_s1 = 0 => 0.1428443345,
			pk_inq_perphone_s1 = 1 => 0.2636363636,
			pk_inq_perphone_s1 = 2 => 0.3787878788,
									  0.1519197544);

		pk_inq_banking_count06_s2_2m := map(
			pk_inq_banking_count06_s2 = -1 => 0.034514581,
			pk_inq_banking_count06_s2 = 0  => 0.1029239766,
			pk_inq_banking_count06_s2 = 1  => 0.2037617555,
											  0.0358788996);

		pk_inq_adlsperaddr_s2_2m := map(
			pk_inq_adlsperaddr_s2 = 0  => 0.0323563706,
			pk_inq_adlsperaddr_s2 = 1  => 0.0822134387,
			pk_inq_adlsperaddr_s2 = 2  => 0.1649484536,
			pk_inq_adlsperaddr_s2 = 10 => 0.0586659523,
			pk_inq_adlsperaddr_s2 = 11 => 0.0980861244,
										  0.0358788996);

		pk_inq_perphone_s2_2m := map(
			pk_inq_perphone_s2 = 0 => 0.0345173019,
			pk_inq_perphone_s2 = 1 => 0.105296343,
									  0.0358788996);

		pk_inq_banking_count06_s3_3m := map(
			pk_inq_banking_count06_s3 = -1 => 0.0611931742,
			pk_inq_banking_count06_s3 = 0  => 0.1627118644,
			pk_inq_banking_count06_s3 = 1  => 0.2337662338,
											  0.0655296669);

		pk_inq_ssnsperaddr_3m := map(
			pk_inq_ssnsperaddr = 0  => 0.0532185482,
			pk_inq_ssnsperaddr = 1  => 0.1399825022,
			pk_inq_ssnsperaddr = 2  => 0.1811926606,
			pk_inq_ssnsperaddr = 10 => 0.0875719543,
			pk_inq_ssnsperaddr = 11 => 0.1212121212,
									   0.0655296669);

		pk_inq_adlsperphone_s3_3m := map(
			pk_inq_adlsperphone_s3 = 0 => 0.0617454877,
			pk_inq_adlsperphone_s3 = 1 => 0.1644329897,
			pk_inq_adlsperphone_s3 = 2 => 0.262195122,
										  0.0655296669);

		pk_addrs_per_adl_s0_0m := map(
			pk_addrs_per_adl_s0 = -1 => 0.3461538462,
			pk_addrs_per_adl_s0 = 0  => 0.2733748887,
			pk_addrs_per_adl_s0 = 1  => 0.2261251372,
			pk_addrs_per_adl_s0 = 2  => 0.193819153,
			pk_addrs_per_adl_s0 = 3  => 0.1692515172,
			pk_addrs_per_adl_s0 = 4  => 0.1449713078,
			pk_addrs_per_adl_s0 = 5  => 0.1289558377,
										0.1491814282);

		pk_ssns_per_adl_s1_1m := map(
			pk_ssns_per_adl_s1 = -1 => 0.1607806691,
			pk_ssns_per_adl_s1 = 0  => 0.1477155164,
			pk_ssns_per_adl_s1 = 1  => 0.1969465649,
			pk_ssns_per_adl_s1 = 2  => 0.2044025157,
			pk_ssns_per_adl_s1 = 3  => 0.3518518519,
									   0.1519197544);

		pk_adlperssn_count_s1_1m := map(
			pk_adlperssn_count_s1 = -1 => 0.1960227273,
			pk_adlperssn_count_s1 = 0  => 0.143471833,
			pk_adlperssn_count_s1 = 1  => 0.1704861111,
			pk_adlperssn_count_s1 = 2  => 0.2151690025,
										  0.1519197544);

		pk_addrs_per_ssn_s1_1m := map(
			pk_addrs_per_ssn_s1 = -1 => 0.1849593496,
			pk_addrs_per_ssn_s1 = 0  => 0.1215033098,
			pk_addrs_per_ssn_s1 = 1  => 0.1417772699,
			pk_addrs_per_ssn_s1 = 2  => 0.1619248606,
										0.1519197544);

		pk_ssns_per_addr_s1_1m := map(
			pk_ssns_per_addr_s1 = -101 => 0.180689473,
			pk_ssns_per_addr_s1 = -2   => 0.1695402299,
			pk_ssns_per_addr_s1 = -1   => 0.1319534282,
			pk_ssns_per_addr_s1 = 0    => 0.0901017576,
			pk_ssns_per_addr_s1 = 1    => 0.0969118755,
			pk_ssns_per_addr_s1 = 2    => 0.1070259381,
			pk_ssns_per_addr_s1 = 3    => 0.1164510166,
			pk_ssns_per_addr_s1 = 4    => 0.1374218207,
			pk_ssns_per_addr_s1 = 5    => 0.1454700128,
			pk_ssns_per_addr_s1 = 6    => 0.1771090281,
			pk_ssns_per_addr_s1 = 7    => 0.1845644983,
			pk_ssns_per_addr_s1 = 8    => 0.1955768718,
			pk_ssns_per_addr_s1 = 9    => 0.2101316752,
			pk_ssns_per_addr_s1 = 100  => 0.1438848921,
			pk_ssns_per_addr_s1 = 101  => 0.1900537634,
										  0.1519197544);

		pk_adls_per_phone_s1_1m := map(
			pk_adls_per_phone_s1 = 0 => 0.1640049606,
			pk_adls_per_phone_s1 = 1 => 0.1326460481,
			pk_adls_per_phone_s1 = 2 => 0.1107047062,
										0.1519197544);

		pk_ssns_per_adl_s2_2m := map(
			pk_ssns_per_adl_s2 = -1 => 0.0865800866,
			pk_ssns_per_adl_s2 = 0  => 0.0340343361,
			pk_ssns_per_adl_s2 = 1  => 0.0404995935,
			pk_ssns_per_adl_s2 = 2  => 0.0559265442,
									   0.0358788996);

		pk_addrs_per_ssn_s2_2m := map(
			pk_addrs_per_ssn_s2 = -1 => 0.0545454545,
			pk_addrs_per_ssn_s2 = 0  => 0.0128891051,
			pk_addrs_per_ssn_s2 = 1  => 0.0203767782,
			pk_addrs_per_ssn_s2 = 2  => 0.0388854912,
										0.0358788996);

		pk_ssns_per_addr_s2_2m := map(
			pk_ssns_per_addr_s2 = -101 => 0.0624054463,
			pk_ssns_per_addr_s2 = -2   => 0.0349712262,
			pk_ssns_per_addr_s2 = -1   => 0.0291970803,
			pk_ssns_per_addr_s2 = 0    => 0.0210941753,
			pk_ssns_per_addr_s2 = 1    => 0.0232150679,
			pk_ssns_per_addr_s2 = 2    => 0.02925377,
			pk_ssns_per_addr_s2 = 3    => 0.034895568,
			pk_ssns_per_addr_s2 = 4    => 0.0387212967,
			pk_ssns_per_addr_s2 = 5    => 0.043977683,
			pk_ssns_per_addr_s2 = 6    => 0.0524737631,
			pk_ssns_per_addr_s2 = 7    => 0.0593301435,
			pk_ssns_per_addr_s2 = 8    => 0.0661764706,
			pk_ssns_per_addr_s2 = 100  => 0.0566801619,
			pk_ssns_per_addr_s2 = 101  => 0.0642857143,
										  0.0358788996);

		pk_adls_per_phone_s2_2m := map(
			pk_adls_per_phone_s2 = 0 => 0.0540237143,
			pk_adls_per_phone_s2 = 1 => 0.0273033408,
			pk_adls_per_phone_s2 = 2 => 0.0229839665,
										0.0358788996);

		pk_ssns_per_adl_s3_3m := map(
			pk_ssns_per_adl_s3 = -1 => 0.1328125,
			pk_ssns_per_adl_s3 = 0  => 0.0621186911,
			pk_ssns_per_adl_s3 = 1  => 0.0769230769,
			pk_ssns_per_adl_s3 = 2  => 0.0836445108,
			pk_ssns_per_adl_s3 = 3  => 0.1510204082,
									   0.0655296669);

		pk_phones_per_adl_s3_3m := map(
			pk_phones_per_adl_s3 = -1 => 0.0730486991,
			pk_phones_per_adl_s3 = 0  => 0.0509962517,
			pk_phones_per_adl_s3 = 1  => 0.066314272,
										 0.0655296669);

		pk_nameperssn_count_3m := map(
			pk_nameperssn_count = 0 => 0.0639080541,
			pk_nameperssn_count = 1 => 0.0859357697,
									   0.0655296669);

		pk_adlperssn_count_s3_3m := map(
			pk_adlperssn_count_s3 = -1 => 0.109375,
			pk_adlperssn_count_s3 = 0  => 0.0621496985,
			pk_adlperssn_count_s3 = 1  => 0.0675119945,
			pk_adlperssn_count_s3 = 2  => 0.0893909627,
										  0.0655296669);

		pk_addrs_per_ssn_s3_3m := map(
			pk_addrs_per_ssn_s3 = -1 => 0.0775862069,
			pk_addrs_per_ssn_s3 = 0  => 0.04,
			pk_addrs_per_ssn_s3 = 1  => 0.0440074906,
			pk_addrs_per_ssn_s3 = 2  => 0.0712982543,
										0.0655296669);

		pk_ssns_per_addr_s3_3m := map(
			pk_ssns_per_addr_s3 = -2  => 0.0583887657,
			pk_ssns_per_addr_s3 = -1  => 0.0438448567,
			pk_ssns_per_addr_s3 = 0   => 0.0257520017,
			pk_ssns_per_addr_s3 = 1   => 0.0363306085,
			pk_ssns_per_addr_s3 = 2   => 0.0395604396,
			pk_ssns_per_addr_s3 = 3   => 0.0535439676,
			pk_ssns_per_addr_s3 = 4   => 0.0604354354,
			pk_ssns_per_addr_s3 = 5   => 0.0618510158,
			pk_ssns_per_addr_s3 = 6   => 0.0725212465,
			pk_ssns_per_addr_s3 = 7   => 0.0775300172,
			pk_ssns_per_addr_s3 = 8   => 0.0943719973,
			pk_ssns_per_addr_s3 = 9   => 0.098796181,
			pk_ssns_per_addr_s3 = 10  => 0.1157781368,
			pk_ssns_per_addr_s3 = 100 => 0.0929421094,
										 0.0655296669);

		pk_phones_per_addr_s3_3m := map(
			pk_phones_per_addr_s3 = -1 => 0.069124159,
			pk_phones_per_addr_s3 = 0  => 0.0475366679,
			pk_phones_per_addr_s3 = 1  => 0.0753443154,
			pk_phones_per_addr_s3 = 2  => 0.0895295903,
			pk_phones_per_addr_s3 = 3  => 0.1131578947,
			pk_phones_per_addr_s3 = 10 => 0.089746369,
			pk_phones_per_addr_s3 = 11 => 0.0947855446,
										  0.0655296669);

		pk_adls_per_phone_s3_3m := map(
			pk_adls_per_phone_s3 = 0 => 0.0888121648,
			pk_adls_per_phone_s3 = 1 => 0.0469432635,
										0.0655296669);

		pk_addr_adl_tree_0m := map(
			pk_addr_adl_tree = -2 => 0.1113564054,
			pk_addr_adl_tree = -1 => 0.143627451,
			pk_addr_adl_tree = 0  => 0.1609764727,
			pk_addr_adl_tree = 1  => 0.1911976912,
			pk_addr_adl_tree = 2  => 0.252283105,
			pk_addr_adl_tree = 3  => 0.2971175166,
									 0.1491814282);

		pk_addrs_per_ssn_c6_0m := map(
			pk_addrs_per_ssn_c6 = 0 => 0.1348231748,
			pk_addrs_per_ssn_c6 = 1 => 0.2835714286,
			pk_addrs_per_ssn_c6 = 2 => 0.4064748201,
									   0.1491814282);

		pk_adls_per_addr_c6_s0_0m := map(
			pk_adls_per_addr_c6_s0 = 0  => 0.1171607604,
			pk_adls_per_addr_c6_s0 = 1  => 0.1575051189,
			pk_adls_per_addr_c6_s0 = 2  => 0.1955537258,
			pk_adls_per_addr_c6_s0 = 3  => 0.2484076433,
			pk_adls_per_addr_c6_s0 = 4  => 0.3137254902,
			pk_adls_per_addr_c6_s0 = 10 => 0.2014909011,
			pk_adls_per_addr_c6_s0 = 11 => 0.2380106572,
			pk_adls_per_addr_c6_s0 = 12 => 0.2836538462,
			pk_adls_per_addr_c6_s0 = 13 => 0.2786885246,
										   0.1491814282);

		pk_phones_per_addr_c6_s0_0m := map(
			pk_phones_per_addr_c6_s0 = 0  => 0.1332162761,
			pk_phones_per_addr_c6_s0 = 1  => 0.1762993763,
			pk_phones_per_addr_c6_s0 = 2  => 0.2476190476,
			pk_phones_per_addr_c6_s0 = 10 => 0.1935246505,
			pk_phones_per_addr_c6_s0 = 11 => 0.2047477745,
			pk_phones_per_addr_c6_s0 = 12 => 0.2334293948,
			pk_phones_per_addr_c6_s0 = 13 => 0.2622478386,
											 0.1491814282);

		pk_addr_adl_tree_1m := map(
			pk_addr_adl_tree = -2 => 0.1183326333,
			pk_addr_adl_tree = -1 => 0.1345665579,
			pk_addr_adl_tree = 0  => 0.1539256198,
			pk_addr_adl_tree = 1  => 0.1748065119,
			pk_addr_adl_tree = 2  => 0.1935007386,
			pk_addr_adl_tree = 3  => 0.2465166131,
									 0.1519197544);

		pk_addrs_per_ssn_c6_1m := map(
			pk_addrs_per_ssn_c6 = 0 => 0.1379811184,
			pk_addrs_per_ssn_c6 = 1 => 0.2108552632,
			pk_addrs_per_ssn_c6 = 2 => 0.3178378378,
									   0.1519197544);

		pk_adls_per_addr_c6_s1_1m := map(
			pk_adls_per_addr_c6_s1 = 0  => 0.1214449495,
			pk_adls_per_addr_c6_s1 = 1  => 0.1617546732,
			pk_adls_per_addr_c6_s1 = 2  => 0.1688905136,
			pk_adls_per_addr_c6_s1 = 3  => 0.200146092,
			pk_adls_per_addr_c6_s1 = 4  => 0.2169197397,
			pk_adls_per_addr_c6_s1 = 10 => 0.1789094187,
			pk_adls_per_addr_c6_s1 = 11 => 0.1907107671,
			pk_adls_per_addr_c6_s1 = 12 => 0.2070365359,
			pk_adls_per_addr_c6_s1 = 13 => 0.2106598985,
										   0.1519197544);

		pk_phones_per_addr_c6_s1_1m := map(
			pk_phones_per_addr_c6_s1 = 0  => 0.1404480299,
			pk_phones_per_addr_c6_s1 = 1  => 0.1855550395,
			pk_phones_per_addr_c6_s1 = 10 => 0.1770376862,
			pk_phones_per_addr_c6_s1 = 11 => 0.1789855072,
			pk_phones_per_addr_c6_s1 = 12 => 0.1901754386,
			pk_phones_per_addr_c6_s1 = 13 => 0.2077922078,
											 0.1519197544);

		pk_addrs_per_ssn_c6_2m := map(
			pk_addrs_per_ssn_c6 = 0 => 0.034006564,
			pk_addrs_per_ssn_c6 = 1 => 0.0809743252,
			pk_addrs_per_ssn_c6 = 2 => 0.0967741935,
									   0.0358788996);

		pk_ssns_per_addr_c6_s2_2m := map(
			pk_ssns_per_addr_c6_s2 = 0  => 0.02946765,
			pk_ssns_per_addr_c6_s2 = 1  => 0.049270073,
			pk_ssns_per_addr_c6_s2 = 2  => 0.0540954325,
			pk_ssns_per_addr_c6_s2 = 3  => 0.0884146341,
			pk_ssns_per_addr_c6_s2 = 10 => 0.0598965423,
			pk_ssns_per_addr_c6_s2 = 11 => 0.0787671233,
			pk_ssns_per_addr_c6_s2 = 12 => 0.0913978495,
										   0.0358788996);

		pk_addr_adl_tree_3m := map(
			pk_addr_adl_tree = -2 => 0.0487126179,
			pk_addr_adl_tree = -1 => 0.0666078518,
			pk_addr_adl_tree = 0  => 0.0802047782,
			pk_addr_adl_tree = 1  => 0.0883339216,
			pk_addr_adl_tree = 2  => 0.100496752,
			pk_addr_adl_tree = 3  => 0.1406844106,
									 0.0655296669);

		pk_addrs_per_ssn_c6_3m := map(
			pk_addrs_per_ssn_c6 = 0 => 0.0608578761,
			pk_addrs_per_ssn_c6 = 1 => 0.1277602524,
			pk_addrs_per_ssn_c6 = 2 => 0.1910569106,
									   0.0655296669);

		pk_ssns_per_addr_c6_s3_3m := map(
			pk_ssns_per_addr_c6_s3 = 0  => 0.0481777198,
			pk_ssns_per_addr_c6_s3 = 1  => 0.0856953642,
			pk_ssns_per_addr_c6_s3 = 2  => 0.0863285186,
			pk_ssns_per_addr_c6_s3 = 3  => 0.0984162896,
			pk_ssns_per_addr_c6_s3 = 4  => 0.1680327869,
			pk_ssns_per_addr_c6_s3 = 10 => 0.088824949,
			pk_ssns_per_addr_c6_s3 = 11 => 0.1171023965,
										   0.0655296669);

		pk_phones_per_addr_c6_s3_3m := map(
			pk_phones_per_addr_c6_s3 = 0  => 0.0564617592,
			pk_phones_per_addr_c6_s3 = 1  => 0.0838059231,
			pk_phones_per_addr_c6_s3 = 2  => 0.0950413223,
			pk_phones_per_addr_c6_s3 = 10 => 0.0883470551,
			pk_phones_per_addr_c6_s3 = 11 => 0.0948220065,
			pk_phones_per_addr_c6_s3 = 12 => 0.0987491771,
			pk_phones_per_addr_c6_s3 = 13 => 0.1014836795,
											 0.0655296669);

		pk_ssn_lowissue_age2_s0_0m := map(
			pk_ssn_lowissue_age2_s0 = -1 => 0.1886792453,
			pk_ssn_lowissue_age2_s0 = 0  => 0.3251748252,
			pk_ssn_lowissue_age2_s0 = 1  => 0.2984395319,
			pk_ssn_lowissue_age2_s0 = 2  => 0.2061381074,
			pk_ssn_lowissue_age2_s0 = 3  => 0.1978417266,
			pk_ssn_lowissue_age2_s0 = 4  => 0.171641791,
			pk_ssn_lowissue_age2_s0 = 5  => 0.1471594798,
			pk_ssn_lowissue_age2_s0 = 6  => 0.1206217163,
			pk_ssn_lowissue_age2_s0 = 7  => 0.1092089389,
											0.1491814282);

		pk_ssn_lowissue_age2_s1_1m := map(
			pk_ssn_lowissue_age2_s1 = -1 => 0.2146892655,
			pk_ssn_lowissue_age2_s1 = 0  => 0.1900455199,
			pk_ssn_lowissue_age2_s1 = 1  => 0.1671617824,
			pk_ssn_lowissue_age2_s1 = 2  => 0.1242695368,
											0.1519197544);

		ssn_issued18_1m := map(
			(integer)ssn_issued18 = 0 => 0.1530072532,
			(integer)ssn_issued18 = 1 => 0.1118170267,
										 0.1519197544);

		ssn_issued18_2m := map(
			(integer)ssn_issued18 = 0 => 0.0378168579,
			(integer)ssn_issued18 = 1 => 0.0312190287,
										 0.0358788996);

		ssn_issued18_3m := map(
			(integer)ssn_issued18 = 0 => 0.0690272575,
			(integer)ssn_issued18 = 1 => 0.057667867,
										 0.0655296669);

		pk_add1_house_number_match_0mn := map(
			pk_add1_house_number_match = 0 => 0.2822822823,
			pk_add1_house_number_match = 1 => 0.1532916867,
											  0.1918715617);

		eda_sourced_level_0mn := map(
			eda_sourced_level = 0 => 0.2430813713,
			eda_sourced_level = 1 => 0.1755555556,
			eda_sourced_level = 2 => 0.1086556169,
									 0.1918715617);

		pk_infutor_nap_0mn := map(
			pk_infutor_nap = -2 => 0.1926457399,
			pk_infutor_nap = -1 => 0.2626641651,
			pk_infutor_nap = 0  => 0.1764705882,
			pk_infutor_nap = 1  => 0.1372377622,
								   0.1918715617);

		pk_input_dob_match_level_0mn := map(
			pk_input_dob_match_level = 0 => 0.4353120244,
			pk_input_dob_match_level = 1 => 0.2170542636,
			pk_input_dob_match_level = 2 => 0.169511249,
											0.1918715617);

		pk_ams_4yr_college_0mn := map(
			pk_ams_4yr_college = 0 => 0.1923664122,
			pk_ams_4yr_college = 1 => 0.181122449,
									  0.1918715617);

		pk_attr_num_nonderogs180_0mn := map(
			pk_attr_num_nonderogs180 = 0 => 0.2727272727,
			pk_attr_num_nonderogs180 = 1 => 0.1714100906,
			pk_attr_num_nonderogs180 = 2 => 0.1196388262,
											0.1918715617);

		pk_email_count_0mn := map(
			pk_email_count = 0 => 0.1821289063,
			pk_email_count = 1 => 0.2038216561,
			pk_email_count = 2 => 0.2696078431,
								  0.1918715617);

		pk_email_domain_free_count_0mn := map(
			pk_email_domain_free_count = 0 => 0.1793852676,
			pk_email_domain_free_count = 1 => 0.2434529583,
			pk_email_domain_free_count = 2 => 0.3170731707,
											  0.1918715617);

		pk_combo_hphonecount_0mn := map(
			pk_combo_hphonecount = 0 => 0.2337762372,
			pk_combo_hphonecount = 1 => 0.133279483,
										0.1918715617);

		pk_mth_header_first_seen2_s0_0mn := map(
			pk_mth_header_first_seen2_s0 = -1 => 0.3333333333,
			pk_mth_header_first_seen2_s0 = 0  => 0.5,
			pk_mth_header_first_seen2_s0 = 1  => 0.4900662252,
			pk_mth_header_first_seen2_s0 = 2  => 0.4503816794,
			pk_mth_header_first_seen2_s0 = 3  => 0.3927492447,
			pk_mth_header_first_seen2_s0 = 4  => 0.3036649215,
			pk_mth_header_first_seen2_s0 = 5  => 0.2305246423,
			pk_mth_header_first_seen2_s0 = 6  => 0.1751509922,
			pk_mth_header_first_seen2_s0 = 7  => 0.1412918108,
			pk_mth_header_first_seen2_s0 = 8  => 0.11000356,
			pk_mth_header_first_seen2_s0 = 9  => 0.0723404255,
												 0.1918715617);

		pk_mth_ver_src_fdate_ts2_0mn := map(
			pk_mth_ver_src_fdate_ts2 = -1 => 0.1870748299,
			pk_mth_ver_src_fdate_ts2 = 0  => 0.2648401826,
			pk_mth_ver_src_fdate_ts2 = 1  => 0.230125523,
			pk_mth_ver_src_fdate_ts2 = 2  => 0.1961130742,
											 0.1918715617);

		pk_time_on_cb_120b_s0_0mn := map(
			pk_time_on_cb_120b_s0 = -20 => 0.347826087,
			pk_time_on_cb_120b_s0 = -10 => 0.2795698925,
			pk_time_on_cb_120b_s0 = 0   => 0.5090909091,
			pk_time_on_cb_120b_s0 = 1   => 0.4306569343,
			pk_time_on_cb_120b_s0 = 2   => 0.3779527559,
			pk_time_on_cb_120b_s0 = 3   => 0.2915082383,
			pk_time_on_cb_120b_s0 = 4   => 0.2171779141,
			pk_time_on_cb_120b_s0 = 5   => 0.1770157553,
			pk_time_on_cb_120b_s0 = 6   => 0.1315053162,
			pk_time_on_cb_120b_s0 = 7   => 0.1072733311,
										   0.1918715617);

		pk_dob_score_ver_1mn := map(
			pk_dob_score_ver = 0 => 0.2107684266,
			pk_dob_score_ver = 1 => 0.1534017215,
									0.1838080461);

		nas_summary_ver_1mn := map(
			nas_summary_ver = 0 => 0.202047215,
			nas_summary_ver = 1 => 0.1563454596,
								   0.1838080461);

		pk_nap_summary_ver_1mn := map(
			pk_nap_summary_ver = -1 => 0.2751322751,
			pk_nap_summary_ver = 0  => 0.1950434189,
			pk_nap_summary_ver = 1  => 0.190343075,
			pk_nap_summary_ver = 2  => 0.133467279,
									   0.1838080461);

		eda_sourced_level_1mn := map(
			eda_sourced_level = 0 => 0.2029494919,
			eda_sourced_level = 1 => 0.1471273292,
			eda_sourced_level = 2 => 0.1183382291,
									 0.1838080461);

		pk_infutor_nap_1mn := map(
			pk_infutor_nap = -2 => 0.1818888793,
			pk_infutor_nap = -1 => 0.2191684285,
			pk_infutor_nap = 0  => 0.163256785,
			pk_infutor_nap = 1  => 0.160483871,
								   0.1838080461);

		pk_ams_age_1mn := map(
			pk_ams_age = -1 => 0.1890577508,
			pk_ams_age = 0  => 0.2162471396,
			pk_ams_age = 1  => 0.1784037559,
			pk_ams_age = 2  => 0.0892710893,
							   0.1838080461);

		pk_ams_income_level_code_1mn := map(
			pk_ams_income_level_code = -1 => 0.2090883485,
			pk_ams_income_level_code = 0  => 0.247113164,
			pk_ams_income_level_code = 1  => 0.1471186441,
			pk_ams_income_level_code = 2  => 0.1069391635,
											 0.1838080461);

		pk_ams_college_tier_1mn := map(
			pk_ams_college_tier = -1 => 0.2053409566,
			pk_ams_college_tier = 0  => 0.157,
			pk_ams_college_tier = 1  => 0.0795118343,
										0.1838080461);

		pk_attr_num_nonderogs180_1mn := map(
			pk_attr_num_nonderogs180 = 0 => 0.1936449963,
			pk_attr_num_nonderogs180 = 1 => 0.1596783458,
			pk_attr_num_nonderogs180 = 2 => 0.1258581236,
											0.1838080461);

		pk_email_count_1mn := map(
			pk_email_count = 0 => 0.1787202381,
			pk_email_count = 1 => 0.1953465826,
			pk_email_count = 2 => 0.2270833333,
								  0.1838080461);

		pk_paw_company_title_1mn := map(
			pk_paw_company_title = 0 => 0.1844958641,
			pk_paw_company_title = 1 => 0.1038961039,
										0.1838080461);

		pk_mth_gong_did_first_seen2_1mn := map(
			pk_mth_gong_did_first_seen2 = -1 => 0.1776476009,
			pk_mth_gong_did_first_seen2 = 0  => 0.2633361558,
			pk_mth_gong_did_first_seen2 = 1  => 0.2044444444,
			pk_mth_gong_did_first_seen2 = 2  => 0.1759410802,
												0.1838080461);

		pk_mth_infutor_first_seen2_1mn := map(
			pk_mth_infutor_first_seen2 = -1 => 0.1818888793,
			pk_mth_infutor_first_seen2 = 0  => 0.19453125,
			pk_mth_infutor_first_seen2 = 1  => 0.1648590022,
			pk_mth_infutor_first_seen2 = 2  => 0.1484918794,
											   0.1838080461);

		pk_time_on_cb_120b_s1_1mn := map(
			pk_time_on_cb_120b_s1 = -20 => 0.2147957726,
			pk_time_on_cb_120b_s1 = -10 => 0.1680942184,
			pk_time_on_cb_120b_s1 = 0   => 0.2942643392,
			pk_time_on_cb_120b_s1 = 1   => 0.2416839917,
			pk_time_on_cb_120b_s1 = 2   => 0.2076974121,
			pk_time_on_cb_120b_s1 = 3   => 0.1656833825,
			pk_time_on_cb_120b_s1 = 4   => 0.1461249573,
			pk_time_on_cb_120b_s1 = 5   => 0.1166315789,
										   0.1838080461);

		pk_hphn_score_ver_2mn := map(
			pk_hphn_score_ver = 0 => 0.0725623583,
			pk_hphn_score_ver = 1 => 0.035315392,
									 0.0487306881);

		eda_sourced_level_2mn := map(
			eda_sourced_level = 0 => 0.0745800672,
			eda_sourced_level = 1 => 0.0539669754,
			eda_sourced_level = 2 => 0.032149774,
									 0.0487306881);

		pk_ams_4yr_college_2mn := map(
			pk_ams_4yr_college = 0 => 0.0494885463,
			pk_ams_4yr_college = 1 => 0.0357583231,
									  0.0487306881);

		pk_ams_college_tier_2mn := map(
			pk_ams_college_tier = -1 => 0.0489801886,
			pk_ams_college_tier = 0  => 0.0769230769,
			pk_ams_college_tier = 1  => 0.0344827586,
										0.0487306881);

		pk_pos_addr_src_cnt_2mn := map(
			pk_pos_addr_src_cnt = 0 => 0.0677244582,
			pk_pos_addr_src_cnt = 1 => 0.0540783327,
			pk_pos_addr_src_cnt = 2 => 0.0393992164,
			pk_pos_addr_src_cnt = 3 => 0.0302719343,
									   0.0487306881);

		pk_mth_header_first_seen2_s2_2mn := map(
			pk_mth_header_first_seen2_s2 = -1 => 0.0643274854,
			pk_mth_header_first_seen2_s2 = 0  => 0.1056829511,
			pk_mth_header_first_seen2_s2 = 1  => 0.0710875332,
			pk_mth_header_first_seen2_s2 = 2  => 0.0652173913,
			pk_mth_header_first_seen2_s2 = 3  => 0.043956044,
			pk_mth_header_first_seen2_s2 = 4  => 0.0320641283,
			pk_mth_header_first_seen2_s2 = 5  => 0.0318809777,
												 0.0487306881);

		pk_mth_infutor_first_seen2_2mn := map(
			pk_mth_infutor_first_seen2 = -1 => 0.0399017802,
			pk_mth_infutor_first_seen2 = 0  => 0.073149492,
			pk_mth_infutor_first_seen2 = 1  => 0.0528301887,
			pk_mth_infutor_first_seen2 = 2  => 0.0471281296,
											   0.0487306881);

		pk_add1_house_number_match_3mn := map(
			pk_add1_house_number_match = 0 => 0.1128164242,
			pk_add1_house_number_match = 1 => 0.0699885093,
											  0.0847155586);

		eda_sourced_level_3mn := map(
			eda_sourced_level = 0 => 0.1115141744,
			eda_sourced_level = 1 => 0.0860155383,
			eda_sourced_level = 2 => 0.0469597755,
									 0.0847155586);

		pk_ams_college_tier_3mn := map(
			pk_ams_college_tier = -1 => 0.0874686526,
			pk_ams_college_tier = 0  => 0.0892448513,
			pk_ams_college_tier = 1  => 0.046277666,
										0.0847155586);

		pk_attr_num_nonderogs180_3mn := map(
			pk_attr_num_nonderogs180 = 0 => 0.1113703531,
			pk_attr_num_nonderogs180 = 1 => 0.0710290828,
			pk_attr_num_nonderogs180 = 2 => 0.049696103,
											0.0847155586);

		pk_email_count_3mn := map(
			pk_email_count = 0 => 0.0810018652,
			pk_email_count = 1 => 0.0912863071,
			pk_email_count = 2 => 0.1366742597,
								  0.0847155586);

		pk_prof_license_category_3mn := map(
			pk_prof_license_category = -1 => 0.0869724502,
			pk_prof_license_category = 0  => 0.0857142857,
			pk_prof_license_category = 1  => 0.0350877193,
											 0.0847155586);

		pk_combo_hphonecount_3mn := map(
			pk_combo_hphonecount = 0 => 0.1127124405,
			pk_combo_hphonecount = 1 => 0.0562543193,
										0.0847155586);

		pk_mth_infutor_first_seen2_3mn := map(
			pk_mth_infutor_first_seen2 = -1 => 0.0746973117,
			pk_mth_infutor_first_seen2 = 0  => 0.1098599286,
			pk_mth_infutor_first_seen2 = 1  => 0.0895522388,
			pk_mth_infutor_first_seen2 = 2  => 0.0901287554,
											   0.0847155586);

		pk_mth_ver_src_fdate_ts2_3mn := map(
			pk_mth_ver_src_fdate_ts2 = -1 => 0.0834823164,
			pk_mth_ver_src_fdate_ts2 = 0  => 0.1118881119,
			pk_mth_ver_src_fdate_ts2 = 1  => 0.0925666199,
			pk_mth_ver_src_fdate_ts2 = 2  => 0.08815427,
											 0.0847155586);

		pk_time_on_cb_120b_s3_3mn := map(
			pk_time_on_cb_120b_s3 = -20 => 0.142557652,
			pk_time_on_cb_120b_s3 = -10 => 0.1262135922,
			pk_time_on_cb_120b_s3 = 0   => 0.1224707135,
			pk_time_on_cb_120b_s3 = 1   => 0.1095070423,
			pk_time_on_cb_120b_s3 = 2   => 0.1015588096,
			pk_time_on_cb_120b_s3 = 3   => 0.0917487685,
			pk_time_on_cb_120b_s3 = 4   => 0.0639899624,
			pk_time_on_cb_120b_s3 = 5   => 0.0477780632,
										   0.0847155586);

		pk_nap_summary_ver_0mb := map(
			pk_nap_summary_ver = -1 => 0.2330508475,
			pk_nap_summary_ver = 0  => 0.1665961349,
			pk_nap_summary_ver = 1  => 0.1518255411,
			pk_nap_summary_ver = 2  => 0.1041562344,
									   0.1341876972);

		pk_infutor_nap_0mb := map(
			pk_infutor_nap = -2 => 0.120539769,
			pk_infutor_nap = -1 => 0.2003891051,
			pk_infutor_nap = 0  => 0.1471540953,
			pk_infutor_nap = 1  => 0.1365292426,
								   0.1341876972);

		pk_ams_college_type_0mb := map(
			pk_ams_college_type = 0 => 0.1345448483,
			pk_ams_college_type = 1 => 0.1279239766,
									   0.1341876972);

		pk_ams_income_level_code_0mb := map(
			pk_ams_income_level_code = -1 => 0.1287998913,
			pk_ams_income_level_code = 0  => 0.2359550562,
			pk_ams_income_level_code = 1  => 0.1662506241,
			pk_ams_income_level_code = 2  => 0.1346666667,
											 0.1341876972);

		pk_attr_num_nonderogs_0mb := map(
			pk_attr_num_nonderogs = 0 => 0.210939861,
			pk_attr_num_nonderogs = 1 => 0.1560587515,
			pk_attr_num_nonderogs = 2 => 0.1125546865,
			pk_attr_num_nonderogs = 3 => 0.1091463415,
			pk_attr_num_nonderogs = 4 => 0.0979685452,
										 0.1341876972);

		pk_attr_num_nonderogs180_0mb := map(
			pk_attr_num_nonderogs180 = 0 => 0.1831538807,
			pk_attr_num_nonderogs180 = 1 => 0.1188507209,
			pk_attr_num_nonderogs180 = 2 => 0.0931773879,
			pk_attr_num_nonderogs180 = 3 => 0.0908607864,
											0.1341876972);

		pk_email_count_0mb := map(
			pk_email_count = 0 => 0.1292080613,
			pk_email_count = 1 => 0.1409139538,
			pk_email_count = 2 => 0.1705490849,
								  0.1341876972);

		pk_bureau_only_0mb := map(
			pk_bureau_only = 0 => 0.1272528008,
			pk_bureau_only = 1 => 0.3701657459,
								  0.1341876972);

		pk_mth_gong_did_first_seen2_0mb := map(
			pk_mth_gong_did_first_seen2 = -1 => 0.1581703537,
			pk_mth_gong_did_first_seen2 = 0  => 0.1820250284,
			pk_mth_gong_did_first_seen2 = 1  => 0.1372901679,
			pk_mth_gong_did_first_seen2 = 2  => 0.1092470382,
												0.1341876972);

		pk_mth_header_first_seen2_s0_0mb := map(
			pk_mth_header_first_seen2_s0 = -1 => 0.0833333333,
			pk_mth_header_first_seen2_s0 = 0  => 0.4485294118,
			pk_mth_header_first_seen2_s0 = 1  => 0.4021352313,
			pk_mth_header_first_seen2_s0 = 2  => 0.3366583541,
			pk_mth_header_first_seen2_s0 = 3  => 0.2844677138,
			pk_mth_header_first_seen2_s0 = 4  => 0.2167982771,
			pk_mth_header_first_seen2_s0 = 5  => 0.1579710145,
			pk_mth_header_first_seen2_s0 = 6  => 0.1250744491,
			pk_mth_header_first_seen2_s0 = 7  => 0.1205711264,
			pk_mth_header_first_seen2_s0 = 8  => 0.0931840632,
			pk_mth_header_first_seen2_s0 = 9  => 0.0825358852,
												 0.1341876972);

		pk_mth_infutor_first_seen2_0mb := map(
			pk_mth_infutor_first_seen2 = -1 => 0.120539769,
			pk_mth_infutor_first_seen2 = 0  => 0.1598099117,
			pk_mth_infutor_first_seen2 = 1  => 0.1439539347,
			pk_mth_infutor_first_seen2 = 2  => 0.1404715128,
											   0.1341876972);

		pk_mth_ver_src_fdate_ts2_0mb := map(
			pk_mth_ver_src_fdate_ts2 = -1 => 0.1309935953,
			pk_mth_ver_src_fdate_ts2 = 0  => 0.2138728324,
			pk_mth_ver_src_fdate_ts2 = 1  => 0.1710816777,
			pk_mth_ver_src_fdate_ts2 = 2  => 0.147,
											 0.1341876972);

		pk_time_on_cb_120b_s0_0mb := map(
			pk_time_on_cb_120b_s0 = -20 => 0.2798690671,
			pk_time_on_cb_120b_s0 = -10 => 0.0714285714,
			pk_time_on_cb_120b_s0 = 0   => 0.417132216,
			pk_time_on_cb_120b_s0 = 1   => 0.3394495413,
			pk_time_on_cb_120b_s0 = 2   => 0.2549450549,
			pk_time_on_cb_120b_s0 = 3   => 0.1913965087,
			pk_time_on_cb_120b_s0 = 4   => 0.1453068592,
			pk_time_on_cb_120b_s0 = 5   => 0.1268882175,
			pk_time_on_cb_120b_s0 = 6   => 0.1183391003,
			pk_time_on_cb_120b_s0 = 7   => 0.0912912913,
										   0.1341876972);

		pk_ssn_score_ver_1mb := map(
			pk_ssn_score_ver = 0 => 0.1457965902,
			pk_ssn_score_ver = 1 => 0.13774768,
									0.1380770248);

		eda_sourced_level_1mb := map(
			eda_sourced_level = 0 => 0.1652065681,
			eda_sourced_level = 1 => 0.1304916603,
			eda_sourced_level = 2 => 0.0948822661,
									 0.1380770248);

		pk_ams_age_1mb := map(
			pk_ams_age = -1 => 0.143442623,
			pk_ams_age = 0  => 0.1490649065,
			pk_ams_age = 1  => 0.1271220695,
			pk_ams_age = 2  => 0.0774513544,
							   0.1380770248);

		pk_ams_income_level_code_1mb := map(
			pk_ams_income_level_code = -1 => 0.1567099567,
			pk_ams_income_level_code = 0  => 0.1873378308,
			pk_ams_income_level_code = 1  => 0.1210526316,
			pk_ams_income_level_code = 2  => 0.0797764228,
											 0.1380770248);

		pk_ams_college_tier_1mb := map(
			pk_ams_college_tier = -1 => 0.1532853395,
			pk_ams_college_tier = 0  => 0.1404761905,
			pk_ams_college_tier = 1  => 0.0575849418,
										0.1380770248);

		pk_attr_num_nonderogs180_1mb := map(
			pk_attr_num_nonderogs180 = 0 => 0.142676417,
			pk_attr_num_nonderogs180 = 1 => 0.1265670846,
			pk_attr_num_nonderogs180 = 2 => 0.10625,
			pk_attr_num_nonderogs180 = 3 => 0.0625,
											0.1380770248);

		pk_email_count_1mb := map(
			pk_email_count = 0 => 0.1347143551,
			pk_email_count = 1 => 0.1452820242,
			pk_email_count = 2 => 0.1679261125,
								  0.1380770248);

		pk_email_domain_free_count_1mb := map(
			pk_email_domain_free_count = 0 => 0.13494551,
			pk_email_domain_free_count = 1 => 0.1475078168,
			pk_email_domain_free_count = 2 => 0.1805453206,
											  0.1380770248);

		pk_prof_license_category_1mb := map(
			pk_prof_license_category = -1 => 0.1390930624,
			pk_prof_license_category = 0  => 0.0859598854,
			pk_prof_license_category = 1  => 0.0516605166,
											 0.1380770248);

		pk_pos_dob_src_cnt_1mb := map(
			pk_pos_dob_src_cnt = 0 => 0.1449262484,
			pk_pos_dob_src_cnt = 1 => 0.111024724,
			pk_pos_dob_src_cnt = 2 => 0.0965166909,
									  0.1380770248);

		pk_mth_gong_did_first_seen2_1mb := map(
			pk_mth_gong_did_first_seen2 = -1 => 0.1346387539,
			pk_mth_gong_did_first_seen2 = 0  => 0.194109126,
			pk_mth_gong_did_first_seen2 = 1  => 0.1504702194,
			pk_mth_gong_did_first_seen2 = 2  => 0.1366167024,
												0.1380770248);

		pk_mth_infutor_first_seen2_1mb := map(
			pk_mth_infutor_first_seen2 = -1 => 0.132865524,
			pk_mth_infutor_first_seen2 = 0  => 0.1508682762,
			pk_mth_infutor_first_seen2 = 1  => 0.1352511808,
			pk_mth_infutor_first_seen2 = 2  => 0.1318114875,
											   0.1380770248);

		pk_time_on_cb_120b_s1_1mb := map(
			pk_time_on_cb_120b_s1 = -20 => 0.1536705972,
			pk_time_on_cb_120b_s1 = -10 => 0.1169811321,
			pk_time_on_cb_120b_s1 = 0   => 0.2027534418,
			pk_time_on_cb_120b_s1 = 1   => 0.1767883451,
			pk_time_on_cb_120b_s1 = 2   => 0.1527624648,
			pk_time_on_cb_120b_s1 = 3   => 0.128115345,
			pk_time_on_cb_120b_s1 = 4   => 0.1062195302,
			pk_time_on_cb_120b_s1 = 5   => 0.0821130677,
										   0.1380770248);

		pk_nap_summary_ver_2mb := map(
			pk_nap_summary_ver = -1 => 0.0604229607,
			pk_nap_summary_ver = 0  => 0.051272627,
			pk_nap_summary_ver = 1  => 0.0509985735,
			pk_nap_summary_ver = 2  => 0.0240947905,
									   0.0330917625);

		pk_rc_fnamessnmatch_2mb := map(
			pk_rc_fnamessnmatch = 0 => 0.0510216718,
			pk_rc_fnamessnmatch = 1 => 0.0306655942,
									   0.0330917625);

		pk_ams_4yr_college_2mb := map(
			pk_ams_4yr_college = 0 => 0.0335956038,
			pk_ams_4yr_college = 1 => 0.0243572395,
									  0.0330917625);

		pk_email_src_cnt_2mb := map(
			pk_email_src_cnt = 0 => 0.0305416277,
			pk_email_src_cnt = 1 => 0.0388308267,
			pk_email_src_cnt = 2 => 0.0518560499,
									0.0330917625);

		pk_pos_addr_src_cnt_2mb := map(
			pk_pos_addr_src_cnt = 0 => 0.0605263158,
			pk_pos_addr_src_cnt = 1 => 0.0407100592,
			pk_pos_addr_src_cnt = 2 => 0.0312069603,
			pk_pos_addr_src_cnt = 3 => 0.0210577865,
									   0.0330917625);

		pk_mth_gong_did_first_seen2_2mb := map(
			pk_mth_gong_did_first_seen2 = -1 => 0.0324467637,
			pk_mth_gong_did_first_seen2 = 0  => 0.0509923664,
			pk_mth_gong_did_first_seen2 = 1  => 0.0485302274,
			pk_mth_gong_did_first_seen2 = 2  => 0.0304247063,
												0.0330917625);

		pk_mth_header_first_seen2_s2_2mb := map(
			pk_mth_header_first_seen2_s2 = -1 => 0.3,
			pk_mth_header_first_seen2_s2 = 0  => 0.0653714286,
			pk_mth_header_first_seen2_s2 = 1  => 0.0589468492,
			pk_mth_header_first_seen2_s2 = 2  => 0.0443055178,
			pk_mth_header_first_seen2_s2 = 3  => 0.0317965024,
			pk_mth_header_first_seen2_s2 = 4  => 0.0223305055,
			pk_mth_header_first_seen2_s2 = 5  => 0.0130081301,
												 0.0330917625);

		pk_mth_infutor_first_seen2_2mb := map(
			pk_mth_infutor_first_seen2 = -1 => 0.0249518121,
			pk_mth_infutor_first_seen2 = 0  => 0.0555395476,
			pk_mth_infutor_first_seen2 = 1  => 0.0496580434,
			pk_mth_infutor_first_seen2 = 2  => 0.0382397572,
											   0.0330917625);

		pk_time_on_cb_120b_s2_2mb := map(
			pk_time_on_cb_120b_s2 = -20 => 0.0555555556,
			pk_time_on_cb_120b_s2 = -10 => 0.1034482759,
			pk_time_on_cb_120b_s2 = 0   => 0.0587331707,
			pk_time_on_cb_120b_s2 = 1   => 0.047404354,
			pk_time_on_cb_120b_s2 = 2   => 0.0313430815,
			pk_time_on_cb_120b_s2 = 3   => 0.0208453966,
										   0.0330917625);

		pk_dob_score_ver_3mb := map(
			pk_dob_score_ver = 0 => 0.0880778589,
			pk_dob_score_ver = 1 => 0.0534513642,
									0.0595408742);

		pk_nap_summary_ver_3mb := map(
			pk_nap_summary_ver = -1 => 0.0964705882,
			pk_nap_summary_ver = 0  => 0.0845545922,
			pk_nap_summary_ver = 1  => 0.0841167135,
			pk_nap_summary_ver = 2  => 0.0379005261,
									   0.0595408742);

		pk_ams_4yr_college_3mb := map(
			pk_ams_4yr_college = 0 => 0.0609452162,
			pk_ams_4yr_college = 1 => 0.0416788964,
									  0.0595408742);

		pk_ams_income_level_code_3mb := map(
			pk_ams_income_level_code = -1 => 0.0589933572,
			pk_ams_income_level_code = 0  => 0.0881392818,
			pk_ams_income_level_code = 1  => 0.0629838878,
			pk_ams_income_level_code = 2  => 0.0483447189,
											 0.0595408742);

		pk_attr_num_nonderogs180_3mb := map(
			pk_attr_num_nonderogs180 = 0 => 0.0742162508,
			pk_attr_num_nonderogs180 = 1 => 0.0504113426,
			pk_attr_num_nonderogs180 = 2 => 0.0391969407,
			pk_attr_num_nonderogs180 = 3 => 0.033933518,
											0.0595408742);

		pk_email_src_cnt_3mb := map(
			pk_email_src_cnt = 0 => 0.0559321569,
			pk_email_src_cnt = 1 => 0.0698869476,
			pk_email_src_cnt = 2 => 0.0797619048,
									0.0595408742);

		pk_prof_license_category_3mb := map(
			pk_prof_license_category = -1 => 0.0606541399,
			pk_prof_license_category = 0  => 0.0669593853,
			pk_prof_license_category = 1  => 0.0268848627,
											 0.0595408742);

		pk_mth_gong_did_first_seen2_3mb := map(
			pk_mth_gong_did_first_seen2 = -1 => 0.0617210411,
			pk_mth_gong_did_first_seen2 = 0  => 0.0857031554,
			pk_mth_gong_did_first_seen2 = 1  => 0.0745735819,
			pk_mth_gong_did_first_seen2 = 2  => 0.0518432599,
												0.0595408742);

		pk_mth_header_first_seen2_s3_3mb := map(
			pk_mth_header_first_seen2_s3 = -1 => 0.2857142857,
			pk_mth_header_first_seen2_s3 = 0  => 0.0905726709,
			pk_mth_header_first_seen2_s3 = 1  => 0.0776318821,
			pk_mth_header_first_seen2_s3 = 2  => 0.0730452675,
			pk_mth_header_first_seen2_s3 = 3  => 0.0463699652,
			pk_mth_header_first_seen2_s3 = 4  => 0.0296268088,
			pk_mth_header_first_seen2_s3 = 5  => 0.0090984285,
												 0.0595408742);

		pk_mth_infutor_first_seen2_3mb := map(
			pk_mth_infutor_first_seen2 = -1 => 0.0477428883,
			pk_mth_infutor_first_seen2 = 0  => 0.0880620985,
			pk_mth_infutor_first_seen2 = 1  => 0.0749279539,
			pk_mth_infutor_first_seen2 = 2  => 0.0648621042,
											   0.0595408742);

		pk_mth_ver_src_fdate_wp2_s3_3mb := map(
			pk_mth_ver_src_fdate_wp2_s3 = -1 => 0.0651410153,
			pk_mth_ver_src_fdate_wp2_s3 = 0  => 0.0898876404,
			pk_mth_ver_src_fdate_wp2_s3 = 1  => 0.0544276458,
			pk_mth_ver_src_fdate_wp2_s3 = 2  => 0.041698449,
												0.0595408742);

		derog_mod2_0m := -5.290489495 +
			pk_crim_fel_date_0m * 6.8518336867 +
			pk_yr_attr_dt_last_evict2_0m * 3.4981851095 +
			pk_lien_tree_0m * 2.9941440297 +
			pk_unrel_last_sn_dt2_0m * 4.0462686252 +
			pk_impulse_count_0m * 5.6731345565;

		prop_mod3_0m := -5.099359928 +
			(integer)pk_boat_plane_flag * -0.40399239 +
			pk_addrs_5yr_s0_0m * 3.0427812845 +
			pk_unique_addr_count_s0_0m * 2.344032964 +
			pk_avg_mo_per_addr_s0_0m * 1.7013607216 +
			pk_addr_count_ge3_s0_0m * 1.6906705271 +
			pk_mth_add1_dt_f_sn_s0_0m * 2.9693976211 +
			pk_ver_src_nas_p_lvl_s0_0m * 2.8668277273 +
			pk_prop_os_tot_tree_s0_0m * 2.0744598126 +
			pk_addrs_per_adl_s0_0m * 2.7849444117 +
			pk_addr_adl_tree_0m * 2.3103518938;

		prop_mod3_1m := -8.544525356 +
			pk_addr_hist_advo_college * -0.625722731 +
			pk_attr_num_sold60 * 0.6949243748 +
			pk_unique_addr_count_s1_1m * 15.180834187 +
			pk_avg_mo_per_addr_s1_1m * 3.6791525371 +
			pk_addr_count_ge3_s1_1m * 4.7476141306 +
			pk_add_naprop_level_s1_1m * 5.7473946685 +
			pk_mth_add1_built_date_s1_1m * 3.9164095576 +
			pk_mth_add1_dt_f_sn_s1_1m * 2.5628573759 +
			pk_add1_avm_auto_val_s1_1m * 4.5055167174 +
			pk_addr_adl_tree_1m * 4.1294041852;

		prop_mod3_2m := -9.588235985 +
			pk_adj_finance * 0.3019660959 +
			pk_addrs_5yr_s2_2m * 7.3320048268 +
			pk_avg_mo_per_addr_s2_2m * 12.623750588 +
			pk_add1_ownership_s2_2m * 18.028345846 +
			pk_mth_add1_purchase_date_s2_2m * 19.347329476 +
			pk_mth_attr_dt_first_prch_s2_2m * 8.4225607355 +
			pk_prop_owned_sold_lvl_s2_2m * 32.609075365 +
			pk_ver_src_nas_p_lvl_s2_2m * 34.832765912 +
			pk_add1_avm_auto_val_s2_2m * 36.807049194;

		prop_mod3_3m := -6.406265293 +
			pk_addr_hist_advo_college * -0.728478651 +
			(integer)pk_boat_plane_flag * -0.683164543 +
			pk_avg_mo_per_addr_s3_3m * 5.2353257748 +
			pk_addr_count_ge3_s3_3m * 6.6587194786 +
			pk_mth_add1_dt_f_sn_s3_3m * 10.40804382 +
			pk_ver_src_nas_p_lvl_s3_3m * 15.519318588 +
			pk_add1_avm_auto_val_s3_3m * 13.328567339 +
			pk_addr_adl_tree_3m * 4.8495549202;

		velocity_mod2_0m := -3.747602022 +
			pk_per_adl_tree2 * 1.0867113227 +
			pk_addrs_per_ssn_c6_0m * 5.4362296312 +
			pk_adls_per_addr_c6_s0_0m * 5.5250476734 +
			pk_phones_per_addr_c6_s0_0m * 2.0935362135;

		velocity_mod2_1m := -4.075765096 +
			pk_addrs_per_ssn_c6_1m * 6.2127523934 +
			pk_adls_per_addr_c6_s1_1m * 6.3944644454 +
			pk_phones_per_addr_c6_s1_1m * 2.6897227927;

		velocity_mod2_2m := -4.734947838 +
			pk_addrs_per_ssn_c6_2m * 17.521424672 +
			pk_ssns_per_addr_c6_s2_2m * 21.157258935;

		velocity_mod2_3m := -4.414174515 +
			pk_addrs_per_ssn_c6_3m * 10.085456293 +
			pk_ssns_per_addr_c6_s3_3m * 12.034307813 +
			pk_phones_per_addr_c6_s3_3m * 3.6565553387;

		multi_mod_1m := -5.716401865 +
			pk_ssns_per_adl_s1_1m * 5.3703403836 +
			pk_adlperssn_count_s1_1m * 5.9197343157 +
			pk_addrs_per_ssn_s1_1m * 2.403109629 +
			pk_ssns_per_addr_s1_1m * 7.4074183839 +
			pk_adls_per_phone_s1_1m * 4.9056517789;

		multi_mod_2m := -6.571703473 +
			pk_ssns_per_adl_s2_2m * 15.777487667 +
			pk_addrs_per_ssn_s2_2m * 29.609841917 +
			pk_ssns_per_addr_s2_2m * 20.159096122 +
			pk_adls_per_phone_s2_2m * 22.352221451;

		multi_mod_3m := -7.366876873 +
			pk_ssns_per_adl_s3_3m * 9.403316697 +
			pk_phones_per_adl_s3_3m * 5.7764866897 +
			pk_nameperssn_count_3m * 10.872661802 +
			pk_adlperssn_count_s3_3m * 8.2698873761 +
			pk_addrs_per_ssn_s3_3m * 10.48741794 +
			pk_ssns_per_addr_s3_3m * 12.483268484 +
			pk_phones_per_addr_s3_3m * 3.3856906889 +
			pk_adls_per_phone_s3_3m * 9.2201735363;

		ver_mod2_best_0m := -16.64638261 +
			pk_nap_summary_ver_0mb * 3.6283003352 +
			pk_infutor_nap_0mb * 3.1534003122 +
			pk_ams_college_type_0mb * 62.279203973 +
			pk_ams_income_level_code_0mb * 5.1916392813 +
			pk_attr_num_nonderogs_0mb * 2.7612560199 +
			pk_attr_num_nonderogs180_0mb * 2.5431474304 +
			pk_email_count_0mb * 8.5594143707 +
			pk_bureau_only_0mb * 1.0758001771 +
			pk_mth_gong_did_first_seen2_0mb * 1.993071646 +
			pk_mth_header_first_seen2_s0_0mb * 1.3390632614 +
			pk_mth_infutor_first_seen2_0mb * 3.8689686942 +
			pk_mth_ver_src_fdate_ts2_0mb * 9.2400478523 +
			pk_time_on_cb_120b_s0_0mb * 3.6984753179;

		ver_mod2_best_1m := -16.06363939 +
			pk_ssn_score_ver_1mb * 25.252416541 +
			eda_sourced_level_1mb * 8.4804504271 +
			pk_ams_age_1mb * 3.064931632 +
			pk_ams_income_level_code_1mb * 4.1247379318 +
			pk_ams_college_tier_1mb * 8.5345516123 +
			pk_attr_num_nonderogs180_1mb * 4.8399778917 +
			pk_email_count_1mb * 9.3448592901 +
			pk_email_domain_free_count_1mb * 5.338197062 +
			pk_prof_license_category_1mb * 8.09220382 +
			pk_pos_dob_src_cnt_1mb * 2.438665381 +
			pk_mth_gong_did_first_seen2_1mb * 10.686917365 +
			pk_mth_infutor_first_seen2_1mb * 3.8293601873 +
			pk_time_on_cb_120b_s1_1mb * 8.2046162375;

		ver_mod2_best_2m := -10.35504428 +
			pk_nap_summary_ver_2mb * 15.539731422 +
			pk_rc_fnamessnmatch_2mb * 13.57531086 +
			pk_ams_4yr_college_2mb * 79.928461121 +
			pk_email_src_cnt_2mb * 26.950644912 +
			pk_pos_addr_src_cnt_2mb * 12.62432316 +
			pk_mth_gong_did_first_seen2_2mb * 15.6864953 +
			pk_mth_header_first_seen2_s2_2mb * 10.951243793 +
			pk_mth_infutor_first_seen2_2mb * 17.693309572 +
			pk_time_on_cb_120b_s2_2mb * 12.220292677;

		ver_mod2_best_3m := -10.94590777 +
			pk_dob_score_ver_3mb * 2.9970091846 +
			pk_nap_summary_ver_3mb * 10.166546539 +
			pk_ams_4yr_college_3mb * 36.01332019 +
			pk_ams_income_level_code_3mb * 13.355119843 +
			pk_attr_num_nonderogs180_3mb * 4.8183868859 +
			pk_email_src_cnt_3mb * 15.28958683 +
			pk_prof_license_category_3mb * 17.900348898 +
			pk_mth_gong_did_first_seen2_3mb * 4.7514064218 +
			pk_mth_header_first_seen2_s3_3mb * 13.512037244 +
			pk_mth_infutor_first_seen2_3mb * 9.9339582815 +
			pk_mth_ver_src_fdate_wp2_s3_3mb * 5.6898716025;

		ver_mod2_best_nodob_0m := -16.64638261 +
			pk_nap_summary_ver_0mb * 3.6283003352 +
			pk_infutor_nap_0mb * 3.1534003122 +
			pk_ams_college_type_0mb * 62.279203973 +
			pk_ams_income_level_code_0mb * 5.1916392813 +
			pk_attr_num_nonderogs_0mb * 2.7612560199 +
			pk_attr_num_nonderogs180_0mb * 2.5431474304 +
			pk_email_count_0mb * 8.5594143707 +
			pk_bureau_only_0mb * 1.0758001771 +
			pk_mth_gong_did_first_seen2_0mb * 1.993071646 +
			pk_mth_header_first_seen2_s0_0mb * 1.3390632614 +
			pk_mth_infutor_first_seen2_0mb * 3.8689686942 +
			pk_mth_ver_src_fdate_ts2_0mb * 9.2400478523 +
			pk_time_on_cb_120b_s0_0mb * 3.6984753179;

		ver_mod2_best_nodob_1m := -15.95907716 +
			pk_ssn_score_ver_1mb * 25.415123012 +
			eda_sourced_level_1mb * 8.4791012236 +
			pk_ams_age_1mb * 3.1641213343 +
			pk_ams_income_level_code_1mb * 4.1777462476 +
			pk_ams_college_tier_1mb * 8.5434372495 +
			pk_attr_num_nonderogs180_1mb * 6.0560720776 +
			pk_email_count_1mb * 9.2266766518 +
			pk_email_domain_free_count_1mb * 5.4094784887 +
			pk_prof_license_category_1mb * 7.9077033772 +
			pk_mth_gong_did_first_seen2_1mb * 10.865777734 +
			pk_mth_infutor_first_seen2_1mb * 3.8700300272 +
			pk_time_on_cb_120b_s1_1mb * 8.3619969329;

		ver_mod2_best_nodob_2m := -10.35504428 +
			pk_nap_summary_ver_2mb * 15.539731422 +
			pk_rc_fnamessnmatch_2mb * 13.57531086 +
			pk_ams_4yr_college_2mb * 79.928461121 +
			pk_email_src_cnt_2mb * 26.950644912 +
			pk_pos_addr_src_cnt_2mb * 12.62432316 +
			pk_mth_gong_did_first_seen2_2mb * 15.6864953 +
			pk_mth_header_first_seen2_s2_2mb * 10.951243793 +
			pk_mth_infutor_first_seen2_2mb * 17.693309572 +
			pk_time_on_cb_120b_s2_2mb * 12.220292677;

		ver_mod2_best_nodob_3m := -10.64827732 +
			pk_nap_summary_ver_3mb * 10.160173856 +
			pk_ams_4yr_college_3mb * 37.475036319 +
			pk_ams_income_level_code_3mb * 12.798231916 +
			pk_attr_num_nonderogs180_3mb * 5.1624247051 +
			pk_email_src_cnt_3mb * 14.464016015 +
			pk_prof_license_category_3mb * 18.00077315 +
			pk_mth_header_first_seen2_s3_3mb * 14.208883648 +
			pk_mth_infutor_first_seen2_3mb * 10.060818479 +
			pk_mth_ver_src_fdate_wp2_s3_3mb * 7.1101884192;

		ver_mod2_notbest_0m := -14.25737463 +
			pk_add1_house_number_match_0mn * 1.9109518148 +
			eda_sourced_level_0mn * 2.0709735811 +
			pk_infutor_nap_0mn * 2.4853257558 +
			pk_input_dob_match_level_0mn * 0.8059595281 +
			pk_ams_4yr_college_0mn * 36.459268253 +
			pk_attr_num_nonderogs180_0mn * 2.3142891434 +
			pk_email_count_0mn * 4.1395114804 +
			pk_email_domain_free_count_0mn * 2.1946292637 +
			pk_combo_hphonecount_0mn * 1.9404143199 +
			pk_mth_header_first_seen2_s0_0mn * 1.6472796029 +
			pk_mth_ver_src_fdate_ts2_0mn * 7.3302006881 +
			pk_time_on_cb_120b_s0_0mn * 2.7115121507;

		ver_mod2_notbest_1m := -14.65407926 +
			pk_dob_score_ver_1mn * 1.824688022 +
			nas_summary_ver_1mn * 3.2738323827 +
			pk_nap_summary_ver_1mn * 2.6202812015 +
			eda_sourced_level_1mn * 4.2130475366 +
			pk_infutor_nap_1mn * 3.8876924954 +
			pk_ams_age_1mn * 4.4678353796 +
			pk_ams_income_level_code_1mn * 2.9555163974 +
			pk_ams_college_tier_1mn * 6.435614271 +
			pk_attr_num_nonderogs180_1mn * 4.3729928781 +
			pk_email_count_1mn * 11.311501944 +
			pk_paw_company_title_1mn * 6.8069907507 +
			pk_mth_gong_did_first_seen2_1mn * 8.1799909836 +
			pk_mth_infutor_first_seen2_1mn * 5.519520933 +
			pk_time_on_cb_120b_s1_1mn * 5.1380271106;

		ver_mod2_notbest_2m := -8.082533421 +
			pk_hphn_score_ver_2mn * 7.358742569 +
			eda_sourced_level_2mn * 7.9806402465 +
			pk_ams_4yr_college_2mn * 32.521400845 +
			pk_ams_college_tier_2mn * 15.270196071 +
			pk_pos_addr_src_cnt_2mn * 12.119035749 +
			pk_mth_header_first_seen2_s2_2mn * 14.56131646 +
			pk_mth_infutor_first_seen2_2mn * 11.896214119;

		ver_mod2_notbest_3m := -11.09171345 +
			pk_add1_house_number_match_3mn * 6.2238683008 +
			eda_sourced_level_3mn * 4.9679172668 +
			pk_ams_college_tier_3mn * 21.888177645 +
			pk_attr_num_nonderogs180_3mn * 7.0608095826 +
			pk_email_count_3mn * 10.949529591 +
			pk_prof_license_category_3mn * 11.206578638 +
			pk_combo_hphonecount_3mn * 5.091109502 +
			pk_mth_infutor_first_seen2_3mn * 6.9384413464 +
			pk_mth_ver_src_fdate_ts2_3mn * 18.405606911 +
			pk_time_on_cb_120b_s3_3mn * 8.2070443967;

		ver_mod2_notbest_nodob_0m := -14.43623914 +
			pk_add1_house_number_match_0mn * 1.9460948246 +
			eda_sourced_level_0mn * 2.0554635487 +
			pk_infutor_nap_0mn * 2.4939772668 +
			pk_ams_4yr_college_0mn * 37.876163861 +
			pk_attr_num_nonderogs180_0mn * 2.4086748386 +
			pk_email_count_0mn * 3.9952402281 +
			pk_email_domain_free_count_0mn * 2.1684190475 +
			pk_combo_hphonecount_0mn * 1.9196277005 +
			pk_mth_header_first_seen2_s0_0mn * 1.8862971104 +
			pk_mth_ver_src_fdate_ts2_0mn * 7.4217712708 +
			pk_time_on_cb_120b_s0_0mn * 2.7663458563;

		ver_mod2_notbest_nodob_1m := -14.48877222 +
			nas_summary_ver_1mn * 3.3705278515 +
			pk_nap_summary_ver_1mn * 2.4410979187 +
			eda_sourced_level_1mn * 4.3121268207 +
			pk_infutor_nap_1mn * 3.8864473973 +
			pk_ams_age_1mn * 4.5245115251 +
			pk_ams_income_level_code_1mn * 3.455004265 +
			pk_ams_college_tier_1mn * 6.4119789923 +
			pk_attr_num_nonderogs180_1mn * 4.9380956098 +
			pk_email_count_1mn * 10.985959156 +
			pk_paw_company_title_1mn * 6.8165291421 +
			pk_mth_gong_did_first_seen2_1mn * 8.2543562744 +
			pk_mth_infutor_first_seen2_1mn * 5.4745732211 +
			pk_time_on_cb_120b_s1_1mn * 5.2406554273;

		ver_mod2_notbest_nodob_2m := -8.082533421 +
			pk_hphn_score_ver_2mn * 7.358742569 +
			eda_sourced_level_2mn * 7.9806402465 +
			pk_ams_4yr_college_2mn * 32.521400845 +
			pk_ams_college_tier_2mn * 15.270196071 +
			pk_pos_addr_src_cnt_2mn * 12.119035749 +
			pk_mth_header_first_seen2_s2_2mn * 14.56131646 +
			pk_mth_infutor_first_seen2_2mn * 11.896214119;

		ver_mod2_notbest_nodob_3m := -11.09171345 +
			pk_add1_house_number_match_3mn * 6.2238683008 +
			eda_sourced_level_3mn * 4.9679172668 +
			pk_ams_college_tier_3mn * 21.888177645 +
			pk_attr_num_nonderogs180_3mn * 7.0608095826 +
			pk_email_count_3mn * 10.949529591 +
			pk_prof_license_category_3mn * 11.206578638 +
			pk_combo_hphonecount_3mn * 5.091109502 +
			pk_mth_infutor_first_seen2_3mn * 6.9384413464 +
			pk_mth_ver_src_fdate_ts2_3mn * 18.405606911 +
			pk_time_on_cb_120b_s3_3mn * 8.2070443967;

		ver_mod2_nodob_0m := if((integer)add1_isbestmatch = 1, ver_mod2_best_nodob_0m, ver_mod2_notbest_nodob_0m);

		ver_mod2_nodob_2m := if((integer)add1_isbestmatch = 1, ver_mod2_best_nodob_2m, ver_mod2_notbest_nodob_2m);

		ver_mod2_nodob_3m := if((integer)add1_isbestmatch = 1, ver_mod2_best_nodob_3m, ver_mod2_notbest_nodob_3m);

		ver_mod2_3m := if((integer)add1_isbestmatch = 1, ver_mod2_best_3m, ver_mod2_notbest_3m);

		ver_mod2_2m := if((integer)add1_isbestmatch = 1, ver_mod2_best_2m, ver_mod2_notbest_2m);

		ver_mod2_1m := if((integer)add1_isbestmatch = 1, ver_mod2_best_1m, ver_mod2_notbest_1m);

		ver_mod2_0m := if((integer)add1_isbestmatch = 1, ver_mod2_best_0m, ver_mod2_notbest_0m);

		ver_mod2_nodob_1m := if((integer)add1_isbestmatch = 1, ver_mod2_best_nodob_1m, ver_mod2_notbest_nodob_1m);

		inquiry_mod3_0m := -3.007021351 +
			pk_inq_peradl_0m * 3.855531946 +
			pk_inq_ssnsperaddr_0m * 4.2911860475;

		inquiry_mod3_1m := -3.106182952 +
			pk_inq_count06_s1_1m * 3.8457211099 +
			pk_inq_ssnsperaddr_1m * 4.0435754671 +
			pk_inq_perphone_s1_1m * 0.9769414713;

		inquiry_mod3_2m := -4.161396696 +
			pk_inq_banking_count06_s2_2m * 6.8587445606 +
			pk_inq_adlsperaddr_s2_2m * 12.294831112 +
			pk_inq_perphone_s2_2m * 4.095272152;

		inquiry_mod3_3m := -3.781767222 +
			pk_inq_banking_count06_s3_3m * 5.15317718 +
			pk_inq_ssnsperaddr_3m * 9.0405770439 +
			pk_inq_adlsperphone_s3_3m * 2.1460583078;

		mod15_0m_1 := 1.7635671725 +
			prop_mod3_0m * 0.1606350812 +
			derog_mod2_0m * 0.5548200937 +
			inquiry_mod3_0m * 0.5674479674 +
			velocity_mod2_0m * 0.3733283276 +
			ver_mod2_0m * 0.4281009662 +
			pk_ssn_lowissue_age2_s0_0m * 0.8294664508;

		mod15_0m := 100 * exp(mod15_0m_1) / (1 + exp(mod15_0m_1));

		mod15_1m_1 := -1.564170866 +
			pk_age_estimate_s1_1m * 2.0850957053 +
			pk_estimated_income_s1_1m * 1.0619892615 +
			prop_mod3_1m * 0.2494387785 +
			inquiry_mod3_1m * 0.6975027596 +
			multi_mod_1m * 0.5325585325 +
			velocity_mod2_1m * 0.3717612878 +
			ver_mod2_1m * 0.6344982786 +
			pk_dist_a1toa2_b_1m * 4.4847008139 +
			pk_ssn_lowissue_age2_s1_1m * 4.3261600786 +
			ssn_issued18_1m * 14.96480137;

		mod15_1m := 100 * exp(mod15_1m_1) / (1 + exp(mod15_1m_1));

		mod15_2m_1 := 1.9994901905 +
			pk_age_estimate_s2_2m * 4.114755999 +
			pk_estimated_income_s2_2m * 17.818666705 +
			prop_mod3_2m * 0.4735462055 +
			inquiry_mod3_2m * 0.6552632345 +
			multi_mod_2m * 0.2848447467 +
			velocity_mod2_2m * 0.2807039066 +
			ver_mod2_2m * 0.516177142 +
			pk_dist_a1toa2_b_2m * 16.317252568 +
			ssn_issued18_2m * 16.227834824;

		mod15_2m := 100 * exp(mod15_2m_1) / (1 + exp(mod15_2m_1));

		mod15_3m_1 := 0.9361085538 +
			pk_age_estimate_s3_3m * 1.780055564 +
			prop_mod3_3m * 0.2684046905 +
			inquiry_mod3_3m * 0.606345325 +
			multi_mod_3m * 0.2753883978 +
			velocity_mod2_3m * 0.2825278284 +
			ver_mod2_3m * 0.614708693 +
			ssn_issued18_3m * 26.060662406;

		mod15_3m := 100 * exp(mod15_3m_1) / (1 + exp(mod15_3m_1));

		mod15_nodob_0m_1 := 1.9929613692 +
			prop_mod3_0m * 0.1790111784 +
			derog_mod2_0m * 0.5642028718 +
			inquiry_mod3_0m * 0.5683270118 +
			velocity_mod2_0m * 0.3722225823 +
			ver_mod2_nodob_0m * 0.4568758982;

		mod15_nodob_0m := 100 * exp(mod15_nodob_0m_1) / (1 + exp(mod15_nodob_0m_1));

		mod15_nodob_1m_1 := 1.0274284334 +
			pk_age_estimate_s1_1m * 3.5243458288 +
			pk_estimated_income_s1_1m * 1.2394518323 +
			prop_mod3_1m * 0.2386956044 +
			inquiry_mod3_1m * 0.689418861 +
			multi_mod_1m * 0.5370315324 +
			velocity_mod2_1m * 0.3596340529 +
			ver_mod2_nodob_1m * 0.6171406593 +
			pk_dist_a1toa2_b_1m * 4.633801256;

		mod15_nodob_1m := 100 * exp(mod15_nodob_1m_1) / (1 + exp(mod15_nodob_1m_1));

		mod15_nodob_2m_1 := 2.4532064437 +
			pk_age_estimate_s2_2m * 5.177626719 +
			pk_estimated_income_s2_2m * 17.843598304 +
			prop_mod3_2m * 0.4660665218 +
			inquiry_mod3_2m * 0.6493123712 +
			multi_mod_2m * 0.2909255116 +
			velocity_mod2_2m * 0.2767693539 +
			ver_mod2_nodob_2m * 0.499899972 +
			pk_dist_a1toa2_b_2m * 16.224007824;

		mod15_nodob_2m := 100 * exp(mod15_nodob_2m_1) / (1 + exp(mod15_nodob_2m_1));

		mod15_nodob_3m_1 := 2.2128049104 +
			pk_age_estimate_s3_3m * 4.0306231422 +
			prop_mod3_3m * 0.2489293165 +
			inquiry_mod3_3m * 0.5831345921 +
			multi_mod_3m * 0.2782832385 +
			velocity_mod2_3m * 0.2597414669 +
			ver_mod2_nodob_3m * 0.5726880959;

		mod15_nodob_3m := 100 * exp(mod15_nodob_3m_1) / (1 + exp(mod15_nodob_3m_1));

		mod15_nodob := map(
			pk_segment_40 = '0 Derog' => mod15_nodob_0m,
			pk_segment_40 = '1 Young' => mod15_nodob_1m,
			pk_segment_40 = '2 Owner' => mod15_nodob_2m,
										 mod15_nodob_3m);

		mod15 := map(
			pk_segment_40 = '0 Derog' => mod15_0m,
			pk_segment_40 = '1 Young' => mod15_1m,
			pk_segment_40 = '2 Owner' => mod15_2m,
										 mod15_3m);

		mod15_phat := mod15 / 100;

		mod15_scr := round(-40 * (ln(mod15_phat / (1 - mod15_phat)) - ln(1 / 20)) / ln(2) + 700);

		mod15_nodob_phat := mod15_nodob / 100;

		mod15_nodob_scr := round(-40 * (ln(mod15_nodob_phat / (1 - mod15_nodob_phat)) - ln(1 / 20)) / ln(2) + 700);

		rvr1103a := if((integer)dobpop = 1, mod15_scr, mod15_nodob_scr);

		rvr1103b := min(900, if(max((real)501, rvr1103a) = NULL, -NULL, max((real)501, rvr1103a)));

		ov_ssndead := ssnlength > (string)0 and rc_decsflag = (string)1;

		ov_ssnprior := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = (string)2225;

		ov_impulse := impulse_count > 0;

		rvr1103c := if(rvr1103b > 680 and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 680, rvr1103b);

		//can we use isRV3Unscorable here?
		//scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		rvr1103d := if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, rvr1103c);

		rvr1103 := if((integer)ssn_deceased > 0, 200, rvr1103d);




	// REASON CODES
		in_phone10                       := le.shell_input.phone10;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_ssncount                   := le.iid.combo_ssncount;
		combo_dobcount                   := le.iid.combo_dobcount;
		fnamepop                         := le.input_validation.firstname;
		addrpop                          := le.input_validation.address;
		hphnpop                          := le.input_validation.homephone;
		add1_lres                        := le.lres;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_market_total_value          := le.address_verification.input_address_information.assessed_amount;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		wealth_index                     := le.wealth_indicator;



		RC_NULL := 0;

pk_mth_hdr_frst_sn2_s0_0mb := pk_mth_header_first_seen2_S0_0mb;
pk_mth_hdr_frst_sn2_s0_0mn := pk_mth_header_first_seen2_S0_0mn;
pk_mth_hdr_frst_sn2_s2_2mb := pk_mth_header_first_seen2_S2_2mb;
pk_mth_hdr_frst_sn2_s2_2mn := pk_mth_header_first_seen2_S2_2mn;
pk_mth_hdr_frst_sn2_s3_3mb := pk_mth_header_first_seen2_S3_3mb;
pk_mth_gong_did_frst_sn2_0mb := pk_mth_gong_did_first_seen2_0mb;
pk_mth_gong_did_frst_sn2_1mb := pk_mth_gong_did_first_seen2_1mb;
pk_mth_gong_did_frst_sn2_1mn := pk_mth_gong_did_first_seen2_1mn;
pk_mth_gong_did_frst_sn2_2mb := pk_mth_gong_did_first_seen2_2mb;
pk_mth_gong_did_frst_sn2_3mb := pk_mth_gong_did_first_seen2_3mb;
pk_mth_add1_prch_dt_s2_2m := pk_mth_add1_purchase_date_S2_2m;
pk_mth_attr_dt_frst_prch_s2_2m := pk_mth_attr_dt_first_prch_S2_2m;
pk_mth_ver_src_fdt_wp2_s3_3mb := pk_mth_ver_src_fdate_WP2_S3_3mb;

rc1 := '';
_rc1 := 0;
rc1_var := '';
rc2 := '';
_rc2 := 0;
rc2_var := '';
rc3 := '';
_rc3 := 0;
rc3_var := '';
rc4 := '';
_rc4 := 0;
rc4_var := '';

add1_assessed_amount := add1_market_total_value;

glrc25 := if((integer)addrpop = 1 and combo_addrcount = 0, 1, 0);

glrc26 := if(ssnlength > (string)3 and (integer1)ssnlength < 10 and combo_ssncount = 0, 1, 0);

glrc27 := if(length(trim(in_phone10)) = 10 and combo_hphonecount = 0, 1, 0);

glrc28 := if((integer)dobpop > 0 and combo_dobcount = 0, 1, 0);

// glrc38 := if(nameperssn_count >= 2, 1, 0);
glrc38 := 0; // disabled per bug 83511

glrc49 := if((integer)hphnpop>0 and (integer)addrpop>0 and rc_disthphoneaddr >= 7 and rc_disthphoneaddr != 9999, 1, 0);

glrc52 := if((integer)fnamepop = 1 and ssnlength = (string)9 and (integer)rc_fnamessnmatch = 0 and (nas_summary = 1 or nas_summary = 2 or nas_summary = 3 or nas_summary = 5 or nas_summary = 6 or nas_summary = 7 or nas_summary = 8 or nas_summary = 11), 1, 0);

glrc97 := if(criminal_count > 0, 1, 0);

glrc98 := if(liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0, 1, 0);

glrc9a := if((add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0, 1, 0);

glrc9c := if(add1_lres <= 72, 1, 0);

glrc9d := if(attr_addrs_last12 > 1, 1, 0);

glrc9e := 1;

glrc9g := if((integer)dobpop>0 and pk_age_estimate <= 35, 1, 0);

glrc9h := if(impulse_count > 0, 1, 0);

glrc9j := if(pk_mth_header_first_seen < 60, 1, 0);

glrc9k := if((integer)addrpop>0 and add_apt, 1, 0);

glrc9l := if((integer)addrpop>0 and dist_a1toa2 > 0 and dist_a1toa2 <= 50, 1, 0);

glrc9m := if(wealth_index < (string)5, 1, 0);

glrc9o := if((integer)addrpop>0 and (integer)add1_eda_sourced = 0, 1, 0);

glrc9q := if(Inq_count12 > 0, 1, 0);

glrc9r := 1;

glrc9s := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);




pk_phn_Cell := if( rc_hriskphoneflag = '1', 1, 0 );
pk_phn_Pager := if( rc_hriskphoneflag = '2', 1, 0 );
pk_phn_PCS := if( rc_hriskphoneflag = '3', 1, 0 );
pk_phn_Disconnect := if( rc_hriskphoneflag = '5', 1, 0 );
pk_phn_Cell2 := if( trim(rc_hphonetypeflag) = '1', 1, 0 );
pk_phn_Pager2 := if( trim(rc_hphonetypeflag) = '2', 1, 0 );
pk_phn_PCS2 := if( trim(rc_hphonetypeflag) = '3', 1, 0 );
pk_phn_PayPhone := if( trim(rc_hphonetypeflag) = 'A', 1, 0 );
pk_phn_Fax := if( trim(rc_hphonetypeflag) = 'B', 1, 0 );
pk_phn_Invalid := if( rc_phonevalflag = '0', 1, 0 );
pk_phn_Usage_Unknown := if( rc_phonevalflag = '3', 1, 0 );
pk_phn_Invalid2 := if( rc_hphonevalflag = '0', 1, 0 );
pk_phn_NotPOTS  := if( rc_hphonevalflag = '4', 1, 0 );
pk_phn_Usage_Unknown2 := if( rc_hphonevalflag = '5', 1, 0 );
pk_phn_PhnZipMismatch := if( rc_phonezipflag = '1', 1, 0 );
pk_phn_PhnZipMismatch2 := if( rc_pwphonezipflag = '1', 1, 0 );
pk_phn_Phn_Not_Issued := if( rc_pwphonezipflag = '4', 1, 0 );
pk_phn_NonUS := if( rc_phonetype in ['3','4'], 1, 0 );
pk_phn_Pager3 := if( trim(telcordia_type) = '02', 1, 0 );
pk_phn_Cell3 := if( trim(telcordia_type) = '04', 1, 0 );
pk_phn_Cell4 := if( trim(telcordia_type) = '55', 1, 0 );
pk_phn_Pager4 := if( trim(telcordia_type) = '56', 1, 0 );
pk_phn_Mobile := if( trim(telcordia_type) = '57', 1, 0 );
pk_phn_CPM := if( trim(telcordia_type) = '58', 1, 0 );
pk_phn_Cell5 := if( trim(telcordia_type) = '60', 1, 0 );
pk_phn_Pager5 := if( trim(telcordia_type) = '61', 1, 0 );
pk_phn_Mobile2 := if( trim(telcordia_type) = '62', 1, 0 );
pk_phn_CPM2 := if( trim(telcordia_type) = '63', 1, 0 );
pk_phn_PCS3 := if( trim(telcordia_type) = '64', 1, 0 );
pk_phn_PCS4 := if( trim(telcordia_type) = '65', 1, 0 );
pk_phn_PCS5 := if( trim(telcordia_type) = '66', 1, 0 );
pk_phn_PCS6 := if( trim(telcordia_type) = '67', 1, 0 );
pk_phn_PCS7 := if( trim(telcordia_type) = '68', 1, 0 );





// pk_phn_NotPOTS := rc_hphonevalflag = '1';
pk_phn_CPM_flag := max(
	pk_phn_Cell    , pk_phn_Cell2   , pk_phn_Cell3   , pk_phn_Cell4   , pk_phn_Cell5   ,
	pk_phn_Pager   , pk_phn_Pager2  , pk_phn_Pager3  , pk_phn_Pager4  , pk_phn_Pager5  ,
	pk_phn_Mobile  , pk_phn_Mobile2 , pk_phn_CPM     , pk_phn_CPM2    );
pk_phn_PCS_flag := max( pk_phn_PCS  , pk_phn_PCS2 , pk_phn_PCS3 , pk_phn_PCS4 , pk_phn_PCS5 , pk_phn_PCS6 , pk_phn_PCS7 );
pk_phn_PhnZipMis_flag := max( pk_phn_PhnZipMismatch , pk_phn_PhnZipMismatch2 );

// pk_phn_PayPhone := rc_hphonetypeflag = 'A';
// pk_phn_Fax := rc_hphonetypeflag = 'B';
phn_highrisk2 := (integer)( rc_hriskphoneflag not in ['0','7'] );
phn_notpots := telcordia_type not in ['00', '50', '51', '52', '54'];
phn_correction := (integer)( rc_hrisksicphone = '2225' );

pk_phn_NotPOTS_Flag := max( pk_phn_NotPOTS  , pk_phn_CPM_flag , pk_phn_PCS_flag, pk_phn_PayPhone, pk_phn_Fax, phn_notpots );
pk_phn_Invalid_Flag := max( pk_phn_Invalid, pk_phn_Invalid2 );


glrc9t := if((integer)hphnpop * (integer)(pk_phn_NotPOTS_Flag = 1 or pk_phn_Invalid_Flag = 1 or pk_phn_PhnZipMis_flag = 1 or pk_phn_Disconnect = 1 or pk_phn_Usage_Unknown = 1 or pk_phn_Usage_Unknown2 = 1 or pk_phn_NonUS = 1 or pk_phn_Phn_Not_Issued = 1 or phn_highrisk2 = 1 or phn_correction = 1 or trim(trim(nap_status, LEFT), LEFT, RIGHT) != 'C') = 1, 1, 0);

pk_add1_advo_address_vacancy      := if( trim( add1_advo_address_vacancy       ) = 'Y', 1, 0 );
pk_add1_advo_throw_back           := if( trim( add1_advo_throw_back            ) = 'Y', 1, 0 );
pk_add1_advo_seasonal_delivery    := if( trim( add1_advo_seasonal_delivery     ) = 'E', 1, 0 );
pk_add1_advo_college              := if( trim( add1_advo_college               ) = 'Y', 1, 0 );
pk_add1_advo_drop                 := if( trim( add1_advo_drop                  ) = 'Y', 1, 0 );
pk_add1_advo_res_or_business      := if( trim( add1_advo_res_or_business       ) = 'B', 1, 0 );
pk_add1_advo_mixed_address_usage  := if( trim( add1_advo_mixed_address_usage   ) in [ 'A','' ] , 1, 0 );

pk_add_inval := if( trim(rc_addrvalflag) = 'N', 1, 0 );
pk_add_hirisk_comm := if( rc_addrcommflag = '2', 1, 0 );
pk_ADVO_No_Hit := if( trim(add1_advo_address_vacancy) = '', 1, 0 );


glrc9u := if((integer)addrpop * (integer)(pk_add1_advo_address_vacancy = 1 or pk_add1_advo_throw_back = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 or pk_add1_advo_drop = 1 or pk_add_inval = 1 or pk_add1_advo_mixed_address_usage = 1 or pk_add_hirisk_comm = 1) = 1, 1, 0);

glrc9w := if((integer)bankrupt > 0, 1, 0);

glrcev := if(attr_eviction_count > 0, 1, 0);

glrcmi := if((integer)ssnlength > 0 and adlperssn_count >= 3, 1, 0);

glrcms := if(ssns_per_adl >= 3, 1, 0);

aptflag_1 := 0;

aptflag := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, aptflag_1);

add1_econval := map(
    aptflag = 0 and add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
    aptflag = 0 and add1_assessed_amount > 0         => add1_assessed_amount,
    aptflag = 0 and add1_avm_med_geo12 > 0           => add1_avm_med_geo12,
    aptflag = 0 and add1_avm_med_geo11 > 0           => add1_avm_med_geo11,
    aptflag = 0 and add1_avm_med_fips > 0            => add1_avm_med_fips,
                                                        NULL);

add1_aptval := map(
    aptflag = 1 and add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    aptflag = 1 and add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    aptflag = 1 and add1_avm_med_fips > 0  => add1_avm_med_fips,
                                              NULL);

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

glrcpv := if((integer)addrpop>0 and add1_econcode = 'F', 1, 0);

glrcx11 := 0;

m_ver_mod2_0m_c34_b1 := 0.4281009662;

m_ver_mod2_best_0m_c35 := if((integer)add1_isbestmatch = 1, m_ver_mod2_0m_c34_b1, 0);

m_ver_mod2_notbest_0m_c35 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_0m_c34_b1);

m_ver_mod2_best_0m_c34 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c35, 0);

m_velocity_mod2_0m_c34 := if((string)pk_Segment_40 = '0 Derog', 0.3733283276, 0);

m_derog_mod2_0m_c34 := if((string)pk_Segment_40 = '0 Derog', 0.5548200937, 0);

m_inquiry_mod3_0m_c34 := if((string)pk_Segment_40 = '0 Derog', 0.5674479674, 0);

m_prop_mod3_0m_c34 := if((string)pk_Segment_40 = '0 Derog', 0.1606350812, 0);

m_ver_mod2_notbest_0m_c34 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c35, 0);

m_ver_mod2_1m_c36_b1 := 0.6344982786;

m_ver_mod2_notbest_1m_c37 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_1m_c36_b1);

m_ver_mod2_best_1m_c37 := if((integer)add1_isbestmatch = 1, m_ver_mod2_1m_c36_b1, 0);

m_velocity_mod2_1m_c36 := if((string)pk_Segment_40 = '1 Young', 0.3717612878, 0);

m_ver_mod2_notbest_1m_c36 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c37, 0);

m_prop_mod3_1m_c36 := if((string)pk_Segment_40 = '1 Young', 0.2494387785, 0);

m_multi_mod_1m_c36 := if((string)pk_Segment_40 = '1 Young', 0.5325585325, 0);

m_inquiry_mod3_1m_c36 := if((string)pk_Segment_40 = '1 Young', 0.6975027596, 0);

m_ver_mod2_best_1m_c36 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c37, 0);

m_ver_mod2_2m_c38_b1 := 0.516177142;

m_ver_mod2_best_2m_c39 := if((integer)add1_isbestmatch = 1, m_ver_mod2_2m_c38_b1, 0);

m_ver_mod2_notbest_2m_c39 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_2m_c38_b1);

m_inquiry_mod3_2m_c38 := if((string)pk_Segment_40 = '2 Owner', 0.6552632345, 0);

m_prop_mod3_2m_c38 := if((string)pk_Segment_40 = '2 Owner', 0.4735462055, 0);

m_velocity_mod2_2m_c38 := if((string)pk_Segment_40 = '2 Owner', 0.2807039066, 0);

m_ver_mod2_best_2m_c38 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c39, 0);

m_multi_mod_2m_c38 := if((string)pk_Segment_40 = '2 Owner', 0.2848447467, 0);

m_ver_mod2_notbest_2m_c38 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c39, 0);

m_ver_mod2_3m_c40_b1 := 0.614708693;

m_ver_mod2_best_3m_c41 := if((integer)add1_isbestmatch = 1, m_ver_mod2_3m_c40_b1, 0);

m_ver_mod2_notbest_3m_c41 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_3m_c40_b1);

m_multi_mod_3m_c40 := if((string)pk_Segment_40 = '3 Other', 0.2753883978, 0);

m_ver_mod2_notbest_3m_c40 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c41, 0);

m_ver_mod2_best_3m_c40 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c41, 0);

m_prop_mod3_3m_c40 := if((string)pk_Segment_40 = '3 Other', 0.2684046905, 0);

m_inquiry_mod3_3m_c40 := if((string)pk_Segment_40 = '3 Other', 0.606345325, 0);

m_velocity_mod2_3m_c40 := if((string)pk_Segment_40 = '3 Other', 0.2825278284, 0);

_25_0_c33_b1 := 0;
_25_1_c33_b1_1 := 0;
_25_2_c33_b1_1 := 0;
_26_0_c33_b1 := 0;
_26_1_c33_b1_1 := 0;
_27_0_c33_b1 := 0;
_27_1_c33_b1_1 := 0;
_27_2_c33_b1_1 := 0;
_27_3_c33_b1_1 := 0;
_28_0_c33_b1 := 0;
_28_1_c33_b1_1 := 0;
_28_2_c33_b1_1 := 0;
_28_3_c33_b1_1 := 0;
_38_0_c33_b1 := 0;
_38_1_c33_b1_1 := 0;
_49_0_c33_b1 := 0;
_52_0_c33_b1 := 0;
_52_1_c33_b1_1 := 0;
_97_0_c33_b1_1 := 0;
_97_1_c33_b1_1 := 0;
_98_0_c33_b1_1 := 0;
_98_1_c33_b1_1 := 0;
_98_2_c33_b1_1 := 0;
_9a_0_c33_b1 := 0;
_9a_1_c33_b1_1 := 0;
_9a_2_c33_b1_1 := 0;
_9a_3_c33_b1_1 := 0;
_9a_4_c33_b1_1 := 0;
_9a_5_c33_b1_1 := 0;
_9a_6_c33_b1_1 := 0;
_9a_7_c33_b1_1 := 0;
_9c_0_c33_b1 := 0;
_9c_1_c33_b1_1 := 0;
_9c_2_c33_b1_1 := 0;
_9c_3_c33_b1_1 := 0;
_9c_4_c33_b1_1 := 0;
_9c_5_c33_b1_1 := 0;
_9c_6_c33_b1_1 := 0;
_9c_7_c33_b1_1 := 0;
_9c_8_c33_b1_1 := 0;
_9c_9_c33_b1_1 := 0;
_9c_10_c33_b1_1 := 0;
_9c_11_c33_b1_1 := 0;
_9d_0_c33_b1 := 0;
_9d_1_c33_b1_1 := 0;
_9d_2_c33_b1_1 := 0;
_9d_3_c33_b1_1 := 0;
_9d_4_c33_b1_1 := 0;
_9d_5_c33_b1_1 := 0;
_9d_6_c33_b1_1 := 0;
_9d_7_c33_b1_1 := 0;
_9d_8_c33_b1_1 := 0;
_9d_9_c33_b1_1 := 0;
_9d_10_c33_b1_1 := 0;
_9d_11_c33_b1_1 := 0;
_9d_12_c33_b1_1 := 0;
_9d_13_c33_b1_1 := 0;
_9d_14_c33_b1_1 := 0;
_9d_15_c33_b1_1 := 0;
_9e_0_c33_b1 := 0;
_9e_1_c33_b1_1 := 0;
_9e_2_c33_b1_1 := 0;
_9e_3_c33_b1_1 := 0;
_9e_4_c33_b1_1 := 0;
_9e_5_c33_b1_1 := 0;
_9e_6_c33_b1_1 := 0;
_9e_7_c33_b1_1 := 0;
_9e_8_c33_b1_1 := 0;
_9e_9_c33_b1_1 := 0;
_9e_10_c33_b1_1 := 0;
_9e_11_c33_b1_1 := 0;
_9e_12_c33_b1_1 := 0;
_9e_13_c33_b1_1 := 0;
_9e_14_c33_b1_1 := 0;
_9g_0_c33_b1 := 0;
_9g_1_c33_b1_1 := 0;
_9g_2_c33_b1_1 := 0;
_9g_3_c33_b1_1 := 0;
_9g_4_c33_b1_1 := 0;
_9g_5_c33_b1_1 := 0;
_9g_6_c33_b1_1 := 0;
_9g_7_c33_b1_1 := 0;
_9g_8_c33_b1_1 := 0;
_9h_0_c33_b1_1 := 0;
_9h_1_c33_b1_1 := 0;
_9j_0_c33_b1 := 0;
_9j_1_c33_b1_1 := 0;
_9j_2_c33_b1_1 := 0;
_9j_3_c33_b1_1 := 0;
_9j_4_c33_b1_1 := 0;
_9j_5_c33_b1_1 := 0;
_9k_0_c33_b1 := 0;
_9l_0_c33_b1 := 0;
_9l_1_c33_b1_1 := 0;
_9l_2_c33_b1_1 := 0;
_9m_0_c33_b1 := 0;
_9m_1_c33_b1_1 := 0;
_9m_2_c33_b1_1 := 0;
_9m_3_c33_b1_1 := 0;
_9m_4_c33_b1_1 := 0;
_9m_5_c33_b1_1 := 0;
_9m_6_c33_b1_1 := 0;
_9o_0_c33_b1 := 0;
_9o_1_c33_b1_1 := 0;
_9o_2_c33_b1_1 := 0;
_9o_3_c33_b1_1 := 0;
_9o_4_c33_b1_1 := 0;
_9o_5_c33_b1_1 := 0;
_9q_0_c33_b1 := 0;
_9q_1_c33_b1_1 := 0;
_9q_2_c33_b1_1 := 0;
_9q_3_c33_b1_1 := 0;
_9q_4_c33_b1_1 := 0;
_9q_5_c33_b1_1 := 0;
_9q_6_c33_b1_1 := 0;
_9q_7_c33_b1_1 := 0;
_9q_8_c33_b1_1 := 0;
_9q_9_c33_b1_1 := 0;
_9q_10_c33_b1_1 := 0;
_9q_11_c33_b1_1 := 0;
_9r_0_c33_b1 := 0;
_9r_1_c33_b1_1 := 0;
_9r_2_c33_b1_1 := 0;
_9r_3_c33_b1_1 := 0;
_9r_4_c33_b1_1 := 0;
_9r_5_c33_b1_1 := 0;
_9r_6_c33_b1_1 := 0;
_9r_7_c33_b1_1 := 0;
_9r_8_c33_b1_1 := 0;
_9r_9_c33_b1_1 := 0;
_9r_10_c33_b1_1 := 0;
_9r_11_c33_b1_1 := 0;
_9r_12_c33_b1_1 := 0;
_9r_13_c33_b1_1 := 0;
_9r_14_c33_b1_1 := 0;
_9r_15_c33_b1_1 := 0;
_9r_16_c33_b1_1 := 0;
_9r_17_c33_b1_1 := 0;
_9r_18_c33_b1_1 := 0;
_9r_19_c33_b1_1 := 0;
_9r_20_c33_b1_1 := 0;
_9r_21_c33_b1_1 := 0;
_9r_22_c33_b1_1 := 0;
_9r_23_c33_b1_1 := 0;
_9r_24_c33_b1_1 := 0;
_9r_25_c33_b1_1 := 0;
_9r_26_c33_b1_1 := 0;
_9r_27_c33_b1_1 := 0;
_9r_28_c33_b1_1 := 0;
_9r_29_c33_b1_1 := 0;
_9r_30_c33_b1_1 := 0;
_9r_31_c33_b1_1 := 0;
_9r_32_c33_b1_1 := 0;
_9r_33_c33_b1_1 := 0;
_9r_34_c33_b1_1 := 0;
_9s_0_c33_b1 := 0;
_9s_1_c33_b1_1 := 0;
_9t_0_c33_b1 := 0;
_9u_0_c33_b1 := 0;
_9w_0_c33_b1_1 := 0;
_9w_1_c33_b1 := 0;
_ev_0_c33_b1_1 := 0;
_ev_1_c33_b1_1 := 0;
_mi_0_c33_b1 := 0;
_mi_1_c33_b1_1 := 0;
_mi_2_c33_b1_1 := 0;
_ms_0_c33_b1 := 0;
_ms_1_c33_b1_1 := 0;
_ms_2_c33_b1_1 := 0;
_ms_3_c33_b1_1 := 0;
_pv_0_c33_b1 := 0;
_pv_1_c33_b1_1 := 0;
_pv_2_c33_b1_1 := 0;
_pv_3_c33_b1_1 := 0;
_x11_0_c33_b1 := 0;
_x11_1_c33_b1_1 := 0;
_x11_2_c33_b1_1 := 0;
_x11_3_c33_b1_1 := 0;
_x11_4_c33_b1_1 := 0;
_x11_5_c33_b1_1 := 0;
_x11_6_c33_b1_1 := 0;
_x11_7_c33_b1_1 := 0;
_x11_8_c33_b1_1 := 0;
_x11_9_c33_b1_1 := 0;
_x11_10_c33_b1_1 := 0;
_x11_11_c33_b1_1 := 0;
_x11_12_c33_b1_1 := 0;
_x11_13_c33_b1_1 := 0;
_x11_14_c33_b1_1 := 0;
_x11_15_c33_b1_1 := 0;

seg_s0_crime_c43_b1 := -1.74103570759888;

_97_0_c43 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (seg_s0_crime_c43_b1 - -2.65747691), 0);

seg_s0_lien_c44_b1 := -1.74103570759888;

_98_0_c44 := if(lien_flag, (seg_s0_lien_c44_b1 - -2.65747691), 0);

seg_s0_eviction_c45_b1 := -1.74103570759888;

_ev_0_c45 := if(bs_attr_eviction_flag > 0, (seg_s0_eviction_c45_b1 - -2.65747691), 0);

seg_s0_impulse_c46_b1 := -1.74103570759888;

_9h_0_c46 := if(pk_impulse_count > 0, (seg_s0_impulse_c46_b1 - -2.65747691), 0);

seg_s0_bk_c47_b1 := -1.74103570759888;

_9w_0_c47 := if(bk_flag, (seg_s0_bk_c47_b1 - -2.65747691), 0);

_9d_3_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.344032964 * (pk_unique_addr_count_S0_0m - 0.1259452717), _9d_3_c33_b1_1);

_9r_5_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 2.7115121507 * (pk_Time_on_CB_120b_S0_0mn - 0.1315053162), _9r_5_c33_b1_1);

_9q_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod3_0m_c34 * 3.855531946 * (pk_inq_peradl_0m - 0.1352414584), _9q_1_c33_b1_1);

_9e_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 3.6283003352 * (pk_nap_summary_ver_0mb - 0.1518255411), _9e_2_c33_b1_1);

_9r_4_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 7.3302006881 * (pk_mth_ver_src_fdate_TS2_0mn - 0.1870748299), _9r_4_c33_b1_1);

_ev_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c34 * 3.4981851095 * (pk_yr_attr_dt_last_evict2_0m - 0.1401640117), _ev_1_c33_b1_1);

_x11_3_c42 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c34 * 2.0935362135 * (pk_phones_per_addr_c6_S0_0m - 0.1332162761), _x11_3_c33_b1_1);

_9h_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c34 * 5.6731345565 * (pk_impulse_count_0m - 0.1301859357), _9h_1_c33_b1_1);

_25_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 1.9109518148 * (pk_add1_house_number_match_0mn - 0.2822822823), _25_1_c33_b1_1);

_9r_3_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 2.1946292637 * (pk_email_domain_free_count_0mn - 0.1793852676), _9r_3_c33_b1_1);

_9o_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 2.0709735811 * (eda_sourced_level_0mn - 0.1755555556), _9o_1_c33_b1_1);

_x11_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c34 * 5.5250476734 * (pk_adls_per_addr_c6_S0_0m - 0.1171607604), _x11_2_c33_b1_1);

_9g_1_c42 := if((string)pk_Segment_40 = '0 Derog', 0.8294664508 * (pk_ssn_lowissue_age2_S0_0m - 0.1092089389), _9g_1_c33_b1_1);

_9r_11_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 3.6984753179 * (pk_Time_on_CB_120b_S0_0mb - 0.1183391003), _9r_11_c33_b1_1);

_9a_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.8668277273 * (pk_ver_src_nas_P_lvl_S0_0m - 0.1041666667), _9a_1_c33_b1_1);

_9r_6_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 3.1534003122 * (pk_infutor_nap_0mb - 0.120539769), _9r_6_c33_b1_1);

_9e_3_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 2.7612560199 * (pk_attr_num_nonderogs_0mb - 0.1125546865), _9e_3_c33_b1_1);

_9j_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 1.3390632614 * (pk_mth_hdr_frst_sn2_s0_0mb - 0.1205711264), _9j_2_c33_b1_1);

_9w_0_c42 := if((string)pk_Segment_40 = '0 Derog', _9w_0_c47, _9w_0_c33_b1_1);

_9c_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 1.7013607216 * (pk_avg_mo_per_addr_S0_0m - 0.115057871), _9c_1_c33_b1_1);

_9e_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 2.3142891434 * (pk_attr_num_nonderogs180_0mn - 0.1714100906), _9e_1_c33_b1_1);

_97_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c34 * 6.8518336867 * (pk_crim_fel_date_0m - 0.1423313266), _97_1_c33_b1_1);

_98_0_c42 := if((string)pk_Segment_40 = '0 Derog', _98_0_c44, _98_0_c33_b1_1);

_9m_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 5.1916392813 * (pk_ams_income_level_code_0mb - 0.1287998913), _9m_1_c33_b1_1);

_9r_10_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 9.2400478523 * (pk_mth_ver_src_fdate_TS2_0mb - 0.1309935953), _9r_10_c33_b1_1);

_ev_0_c42 := if((string)pk_Segment_40 = '0 Derog', _ev_0_c45, _ev_0_c33_b1_1);

_98_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c34 * 2.9941440297 * (pk_lien_tree_0m - 0.1351682199), _98_1_c33_b1_1);

_9h_0_c42 := if((string)pk_Segment_40 = '0 Derog', _9h_0_c46, _9h_0_c33_b1_1);

_9q_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod3_0m_c34 * 4.2911860475 * (pk_inq_ssnsperaddr_0m - 0.1233882317), _9q_2_c33_b1_1);

_9d_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 3.0427812845 * (pk_addrs_5yr_S0_0m - 0.151718081), _9d_2_c33_b1_1);

_27_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 1.9404143199 * (pk_combo_hphonecount_0mn - 0.133279483), _27_1_c33_b1_1);

_9j_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 1.6472796029 * (pk_mth_hdr_frst_sn2_s0_0mn - 0.1412918108), _9j_1_c33_b1_1);

_9d_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c34 * 5.4362296312 * (pk_addrs_per_ssn_c6_0m - 0.1348231748), _9d_1_c33_b1_1);

_9r_9_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 3.8689686942 * (pk_mth_infutor_first_seen2_0mb - 0.120539769), _9r_9_c33_b1_1);

_98_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c34 * 4.0462686252 * (pk_unrel_last_sn_dt2_0m - 0.1348257006), _98_2_c33_b1_1);

_9d_4_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.7849444117 * (pk_addrs_per_adl_S0_0m - 0.1289558377), _9d_4_c33_b1_1);

_9c_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 1.6906705271 * (pk_addr_count_ge3_S0_0m - 0.1147284045), _9c_2_c33_b1_1);

_28_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 0.8059595281 * (pk_input_dob_match_level_0mn - 0.169511249), _28_1_c33_b1_1);

_9c_3_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.9693976211 * (pk_mth_add1_dt_f_sn_S0_0m - 0.1378755365), _9c_3_c33_b1_1);

_9r_7_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 8.5594143707 * (pk_email_count_0mb - 0.1292080613), _9r_7_c33_b1_1);

_9r_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 2.4853257558 * (pk_infutor_nap_0mn - 0.1926457399), _9r_1_c33_b1_1);

_9e_5_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 1.0758001771 * (pk_Bureau_Only_0mb - 0.1272528008), _9e_5_c33_b1_1);

_9r_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_0m_c34 * 4.1395114804 * (pk_email_count_0mn - 0.1821289063), _9r_2_c33_b1_1);

_9d_5_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.3103518938 * (pk_addr_adl_tree_0m - 0.143627451), _9d_5_c33_b1_1);

_97_0_c42 := if((string)pk_Segment_40 = '0 Derog', _97_0_c43, _97_0_c33_b1_1);

_9r_8_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 1.993071646 * (pk_mth_gong_did_frst_sn2_0mb - 0.1372901679), _9r_8_c33_b1_1);

_9e_4_c42 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_0m_c34 * 2.5431474304 * (pk_attr_num_nonderogs180_0mb - 0.1188507209), _9e_4_c33_b1_1);

_x11_1_c42 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c34 * 1.0867113227 * (pk_per_adl_tree2 - 0), _x11_1_c33_b1_1);

_9a_2_c42 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c34 * 2.0744598126 * (pk_prop_os_tot_tree_S0_0m - 0.1176786674), _9a_2_c33_b1_1);

seg_s1_c48_b1 := -1.71962281044579;

_x11_6_c48 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c36 * 7.4074183839 * (pk_ssns_per_addr_S1_1m - 0.1695402299), _x11_6_c33_b1_1);

_9m_3_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 4.1247379318 * (pk_ams_income_level_code_1mb - 0.1567099567), _9m_3_c33_b1_1);

_9e_7_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 4.3729928781 * (pk_attr_num_nonderogs180_1mn - 0.1936449963), _9e_7_c33_b1_1);

_9o_2_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 4.2130475366 * (eda_sourced_level_1mn - 0.2029494919), _9o_2_c33_b1_1);

_9c_4_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 3.6791525371 * (pk_avg_mo_per_addr_S1_1m - 0.1410060544), _9c_4_c33_b1_1);

_26_1_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 25.252416541 * (pk_ssn_score_ver_1mb - 0.13774768), _26_1_c33_b1_1);

_9g_5_c48 := if((string)pk_Segment_40 = '1 Young', 2.0850957053 * (pk_age_estimate_S1_1m - 0.1562899577), _9g_5_c33_b1_1);

_ms_1_c48 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c36 * 5.3703403836 * (pk_ssns_per_adl_S1_1m - 0.1477155164), _ms_1_c33_b1_1);

_9o_3_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 8.4804504271 * (eda_sourced_level_1mb - 0.1652065681), _9o_3_c33_b1_1);

_9c_6_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 2.5628573759 * (pk_mth_add1_dt_f_sn_S1_1m - 0.1585373489), _9c_6_c33_b1_1);

_9r_21_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 8.2046162375 * (pk_Time_on_CB_120b_S1_1mb - 0.1527624648), _9r_21_c33_b1_1);

_x11_4_c48 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c36 * 6.3944644454 * (pk_adls_per_addr_c6_S1_1m - 0.1617546732), _x11_4_c33_b1_1);

_9d_6_c48 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c36 * 6.2127523934 * (pk_addrs_per_ssn_c6_1m - 0.1379811184), _9d_6_c33_b1_1);

_9r_15_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 5.519520933 * (pk_mth_infutor_first_seen2_1mn - 0.1818888793), _9r_15_c33_b1_1);

_9q_5_c48 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c36 * 0.9769414713 * (pk_inq_perphone_S1_1m - 0.1428443345), _9q_5_c33_b1_1);

_mi_1_c48 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c36 * 5.9197343157 * (pk_adlperssn_count_S1_1m - 0.143471833), _mi_1_c33_b1_1);

_9r_16_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 5.1380271106 * (pk_Time_on_CB_120b_S1_1mn - 0.2076974121), _9r_16_c33_b1_1);

_9e_6_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 2.6202812015 * (pk_nap_summary_ver_1mn - 0.190343075), _9e_6_c33_b1_1);

_9r_14_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 8.1799909836 * (pk_mth_gong_did_frst_sn2_1mn - 0.1776476009), _9r_14_c33_b1_1);

_9r_20_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 3.8293601873 * (pk_mth_infutor_first_seen2_1mb - 0.132865524), _9r_20_c33_b1_1);

_9q_3_c48 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c36 * 3.8457211099 * (pk_inq_count06_S1_1m - 0.1372722579), _9q_3_c33_b1_1);

_x11_5_c48 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c36 * 2.6897227927 * (pk_phones_per_addr_c6_S1_1m - 0.1404480299), _x11_5_c33_b1_1);

_9q_4_c48 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c36 * 4.0435754671 * (pk_inq_ssnsperaddr_1m - 0.128611965), _9q_4_c33_b1_1);

_28_2_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 1.824688022 * (pk_dob_score_ver_1mn - 0.2107684266), _28_2_c33_b1_1);

_9g_2_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 4.4678353796 * (pk_ams_age_1mn - 0.1890577508), _9g_2_c33_b1_1);

_9r_19_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 10.686917365 * (pk_mth_gong_did_frst_sn2_1mb - 0.1346387539), _9r_19_c33_b1_1);

_9g_4_c48 := if((string)pk_Segment_40 = '1 Young', (seg_s1_c48_b1 - -2.65747691), _9g_4_c33_b1_1);

_9d_7_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 15.180834187 * (pk_unique_addr_count_S1_1m - 0.1555290695), _9d_7_c33_b1_1);

_9g_6_c48 := if((string)pk_Segment_40 = '1 Young', 4.3261600786 * (pk_ssn_lowissue_age2_S1_1m - 0.1242695368), _9g_6_c33_b1_1);

_9r_17_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 9.3448592901 * (pk_email_count_1mb - 0.1347143551), _9r_17_c33_b1_1);

_9r_12_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 3.8876924954 * (pk_infutor_nap_1mn - 0.163256785), _9r_12_c33_b1_1);

_9r_18_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 5.338197062 * (pk_email_domain_free_count_1mb - 0.13494551), _9r_18_c33_b1_1);

_9c_5_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 4.7476141306 * (pk_addr_count_ge3_S1_1m - 0.1631896528), _9c_5_c33_b1_1);

_9d_8_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 4.1294041852 * (pk_addr_adl_tree_1m - 0.1539256198), _9d_8_c33_b1_1);

_9d_9_c48 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c36 * 2.403109629 * (pk_addrs_per_ssn_S1_1m - 0.1619248606), _9d_9_c33_b1_1);

_x11_7_c48 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c36 * 4.9056517789 * (pk_adls_per_phone_S1_1m - 0.1640049606), _x11_7_c33_b1_1);

_9g_3_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 3.064931632 * (pk_ams_age_1mb - 0.143442623), _9g_3_c33_b1_1);

_9e_8_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_1m_c36 * 4.8399778917 * (pk_attr_num_nonderogs180_1mb - 0.142676417), _9e_8_c33_b1_1);

_9m_4_c48 := if((string)pk_Segment_40 = '1 Young', 1.0619892615 * (pk_estimated_income_S1_1m - 0.1471165644), _9m_4_c33_b1_1);

_9r_13_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 11.311501944 * (pk_email_count_1mn - 0.1787202381), _9r_13_c33_b1_1);

_pv_1_c48 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c36 * 4.5055167174 * (pk_add1_avm_auto_val_S1_1m - 0.1636079656), _pv_1_c33_b1_1);

_9l_1_c48 := if((string)pk_Segment_40 = '1 Young', 4.4847008139 * (pk_dist_a1toa2_b_1m - 0.1363990647), _9l_1_c33_b1_1);

_9m_2_c48 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_1m_c36 * 2.9555163974 * (pk_ams_income_level_code_1mn - 0.2090883485), _9m_2_c33_b1_1);

_9q_8_c49 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c38 * 4.095272152 * (pk_inq_perphone_S2_2m - 0.0345173019), _9q_8_c33_b1_1);

_9d_11_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 7.3320048268 * (pk_addrs_5yr_S2_2m - 0.0362266338), _9d_11_c33_b1_1);

_9o_4_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c38 * 7.9806402465 * (eda_sourced_level_2mn - 0.032149774), _9o_4_c33_b1_1);

_9r_25_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 17.693309572 * (pk_mth_infutor_first_seen2_2mb - 0.0249518121), _9r_25_c33_b1_1);

_9j_3_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c38 * 14.56131646 * (pk_mth_hdr_frst_sn2_s2_2mn - 0.043956044), _9j_3_c33_b1_1);

_9l_2_c49 := if((string)pk_Segment_40 = '2 Owner', 16.317252568 * (pk_dist_a1toa2_b_2m - 0.0344738589), _9l_2_c33_b1_1);

_9q_6_c49 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c38 * 6.8587445606 * (pk_inq_banking_count06_S2_2m - 0.034514581), _9q_6_c33_b1_1);

_9e_9_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c38 * 12.119035749 * (pk_pos_addr_src_cnt_2mn - 0.0393992164), _9e_9_c33_b1_1);

_9r_22_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c38 * 11.896214119 * (pk_mth_infutor_first_seen2_2mn - 0.0399017802), _9r_22_c33_b1_1);

_9s_1_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 0.3019660959 * (pk_adj_finance - 0), _9s_1_c33_b1_1);

_pv_2_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 36.807049194 * (pk_add1_avm_auto_val_S2_2m - 0.033856933), _pv_2_c33_b1_1);

_9a_4_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 8.4225607355 * (pk_mth_attr_dt_frst_prch_s2_2m - 0.0381729201), _9a_4_c33_b1_1);

_9d_12_c49 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c38 * 29.609841917 * (pk_addrs_per_ssn_S2_2m - 0.0388854912), _9d_12_c33_b1_1);

_9a_6_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 34.832765912 * (pk_ver_src_nas_P_lvl_S2_2m - 0.0333815792), _9a_6_c33_b1_1);

_27_2_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_2m_c38 * 7.358742569 * (pk_hphn_score_ver_2mn - 0.035315392), _27_2_c33_b1_1);

_ms_2_c49 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c38 * 15.777487667 * (pk_ssns_per_adl_S2_2m - 0.0340343361), _ms_2_c33_b1_1);

_9r_24_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 15.6864953 * (pk_mth_gong_did_frst_sn2_2mb - 0.0304247063), _9r_24_c33_b1_1);

_9c_7_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 12.623750588 * (pk_avg_mo_per_addr_S2_2m - 0.0266471562), _9c_7_c33_b1_1);

_9e_11_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 12.62432316 * (pk_pos_addr_src_cnt_2mb - 0.0312069603), _9e_11_c33_b1_1);

_9e_10_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 15.539731422 * (pk_nap_summary_ver_2mb - 0.0240947905), _9e_10_c33_b1_1);

_x11_8_c49 := if((string)pk_Segment_40 = '2 Owner', m_velocity_mod2_2m_c38 * 21.157258935 * (pk_ssns_per_addr_c6_S2_2m - 0.02946765), _x11_8_c33_b1_1);

_9q_7_c49 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c38 * 12.294831112 * (pk_inq_adlsperaddr_S2_2m - 0.0323563706), _9q_7_c33_b1_1);

_9g_7_c49 := if((string)pk_Segment_40 = '2 Owner', 4.114755999 * (pk_age_estimate_S2_2m - 0.0297116737), _9g_7_c33_b1_1);

_9m_5_c49 := if((string)pk_Segment_40 = '2 Owner', 17.818666705 * (pk_estimated_income_S2_2m - 0.0326581702), _9m_5_c33_b1_1);

_x11_9_c49 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c38 * 20.159096122 * (pk_ssns_per_addr_S2_2m - 0.034895568), _x11_9_c33_b1_1);

_52_1_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 13.57531086 * (pk_rc_fnamessnmatch_2mb - 0.0306655942), _52_1_c33_b1_1);

_9r_26_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 12.220292677 * (pk_Time_on_CB_120b_S2_2mb - 0.0313430815), _9r_26_c33_b1_1);

_9a_5_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 32.609075365 * (pk_prop_owned_sold_lvl_S2_2m - 0.0362068489), _9a_5_c33_b1_1);

_9a_3_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 18.028345846 * (pk_add1_ownership_S2_2m - 0.0290110836), _9a_3_c33_b1_1);

_9j_4_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 10.951243793 * (pk_mth_hdr_frst_sn2_s2_2mb - 0.0317965024), _9j_4_c33_b1_1);

_9c_8_c49 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c38 * 19.347329476 * (pk_mth_add1_prch_dt_s2_2m - 0.0332513054), _9c_8_c33_b1_1);

_x11_10_c49 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c38 * 22.352221451 * (pk_adls_per_phone_S2_2m - 0.0273033408), _x11_10_c33_b1_1);

_9r_23_c49 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_2m_c38 * 26.950644912 * (pk_email_src_cnt_2mb - 0.0305416277), _9r_23_c33_b1_1);

_9d_10_c49 := if((string)pk_Segment_40 = '2 Owner', m_velocity_mod2_2m_c38 * 17.521424672 * (pk_addrs_per_ssn_c6_2m - 0.034006564), _9d_10_c33_b1_1);

_9r_34_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 5.6898716025 * (pk_mth_ver_src_fdt_wp2_s3_3mb - 0.0651410153), _9r_34_c33_b1_1);

_9q_9_c50 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c40 * 5.15317718 * (pk_inq_banking_count06_S3_3m - 0.0611931742), _9q_9_c33_b1_1);

_9r_33_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 9.9339582815 * (pk_mth_infutor_first_seen2_3mb - 0.0477428883), _9r_33_c33_b1_1);

_9m_6_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 13.355119843 * (pk_ams_income_level_code_3mb - 0.0589933572), _9m_6_c33_b1_1);

_9r_27_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 10.949529591 * (pk_email_count_3mn - 0.0810018652), _9r_27_c33_b1_1);

_9a_7_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 15.519318588 * (pk_ver_src_nas_P_lvl_S3_3m - 0.0713321464), _9a_7_c33_b1_1);

_9d_13_c50 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c40 * 10.085456293 * (pk_addrs_per_ssn_c6_3m - 0.0608578761), _9d_13_c33_b1_1);

_x11_13_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 12.483268484 * (pk_ssns_per_addr_S3_3m - 0.0604354354), _x11_13_c33_b1_1);

_9d_15_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 10.48741794 * (pk_addrs_per_ssn_S3_3m - 0.0712982543), _9d_15_c33_b1_1);

_9r_31_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 15.28958683 * (pk_email_src_cnt_3mb - 0.0559321569), _9r_31_c33_b1_1);

_9r_30_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 8.2070443967 * (pk_Time_on_CB_120b_S3_3mn - 0.0917487685), _9r_30_c33_b1_1);

_x11_12_c50 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c40 * 3.6565553387 * (pk_phones_per_addr_c6_S3_3m - 0.0564617592), _x11_12_c33_b1_1);

_9r_32_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 4.7514064218 * (pk_mth_gong_did_frst_sn2_3mb - 0.0617210411), _9r_32_c33_b1_1);

_mi_2_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 8.2698873761 * (pk_adlperssn_count_S3_3m - 0.0621496985), _mi_2_c33_b1_1);

_9q_11_c50 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c40 * 2.1460583078 * (pk_inq_adlsperphone_S3_3m - 0.0617454877), _9q_11_c33_b1_1);

_9e_14_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 4.8183868859 * (pk_attr_num_nonderogs180_3mb - 0.0504113426), _9e_14_c33_b1_1);

_9j_5_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 13.512037244 * (pk_mth_hdr_frst_sn2_s3_3mb - 0.0730452675), _9j_5_c33_b1_1);

_9r_29_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 18.405606911 * (pk_mth_ver_src_fdate_TS2_3mn - 0.0834823164), _9r_29_c33_b1_1);

_9g_8_c50 := if((string)pk_Segment_40 = '3 Other', 1.780055564 * (pk_age_estimate_S3_3m - 0.0651025153), _9g_8_c33_b1_1);

_9d_14_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 4.8495549202 * (pk_addr_adl_tree_3m - 0.0487126179), _9d_14_c33_b1_1);

_x11_15_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 9.2201735363 * (pk_adls_per_phone_S3_3m - 0.0469432635), _x11_15_c33_b1_1);

_x11_14_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 3.3856906889 * (pk_phones_per_addr_S3_3m - 0.069124159), _x11_14_c33_b1_1);

_pv_3_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 13.328567339 * (pk_add1_avm_auto_val_S3_3m - 0.061606087), _pv_3_c33_b1_1);

_27_3_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 5.091109502 * (pk_combo_hphonecount_3mn - 0.0562543193), _27_3_c33_b1_1);

_38_1_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 10.872661802 * (pk_nameperssn_count_3m - 0.0639080541), _38_1_c33_b1_1);

_9c_10_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 6.6587194786 * (pk_addr_count_ge3_S3_3m - 0.0635507917), _9c_10_c33_b1_1);

_9e_12_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 7.0608095826 * (pk_attr_num_nonderogs180_3mn - 0.0710290828), _9e_12_c33_b1_1);

_9r_28_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 6.9384413464 * (pk_mth_infutor_first_seen2_3mn - 0.0746973117), _9r_28_c33_b1_1);

_9c_9_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 5.2353257748 * (pk_avg_mo_per_addr_S3_3m - 0.0713834491), _9c_9_c33_b1_1);

_9o_5_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 4.9679172668 * (eda_sourced_level_3mn - 0.0860155383), _9o_5_c33_b1_1);

_9q_10_c50 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c40 * 9.0405770439 * (pk_inq_ssnsperaddr_3m - 0.0532185482), _9q_10_c33_b1_1);

_x11_11_c50 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c40 * 12.034307813 * (pk_ssns_per_addr_c6_S3_3m - 0.0481777198), _x11_11_c33_b1_1);

_28_3_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 2.9970091846 * (pk_dob_score_ver_3mb - 0.0534513642), _28_3_c33_b1_1);

_ms_3_c50 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c40 * 9.403316697 * (pk_ssns_per_adl_S3_3m - 0.0621186911), _ms_3_c33_b1_1);

_9c_11_c50 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c40 * 10.40804382 * (pk_mth_add1_dt_f_sn_S3_3m - 0.0648187633), _9c_11_c33_b1_1);

_25_2_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_3m_c40 * 6.2238683008 * (pk_add1_house_number_match_3mn - 0.0699885093), _25_2_c33_b1_1);

_9e_13_c50 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_3m_c40 * 10.166546539 * (pk_nap_summary_ver_3mb - 0.0379005261), _9e_13_c33_b1_1);

m_ver_mod2_nodob_0m_c51_b1 := 0.4568758982;
M_Ver_mod2_NoDob_0M := M_Ver_mod2_NoDob_0M_c51_b1;

m_ver_mod2_notbest_nodob_0m_c52 := if((integer)add1_isbestmatch = 1, 0, M_Ver_mod2_NoDob_0M);

m_ver_mod2_best_nodob_0m_c52 := if((integer)add1_isbestmatch = 1, M_Ver_mod2_NoDob_0M, 0);

m_velocity_mod2_0m_c51 := if((string)pk_Segment_40 = '0 Derog', 0.3722225823, 0);

m_derog_mod2_0m_c51 := if((string)pk_Segment_40 = '0 Derog', 0.5642028718, 0);

m_inquiry_mod3_0m_c51 := if((string)pk_Segment_40 = '0 Derog', 0.5683270118, 0);

m_ver_mod2_notbest_nodob_0m_c51 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c52, 0);

m_ver_mod2_best_nodob_0m_c51 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c52, 0);

m_prop_mod3_0m_c51 := if((string)pk_Segment_40 = '0 Derog', 0.1790111784, 0);

m_ver_mod2_nodob_1m_c53_b1 := 0.6171406593;

m_ver_mod2_best_nodob_1m_c54 := if((integer)add1_isbestmatch = 1, m_ver_mod2_nodob_1m_c53_b1, 0);

m_ver_mod2_notbest_nodob_1m_c54 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_nodob_1m_c53_b1);

m_velocity_mod2_1m_c53 := if((string)pk_Segment_40 = '1 Young', 0.3596340529, 0);

m_ver_mod2_best_nodob_1m_c53 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c54, 0);

m_prop_mod3_1m_c53 := if((string)pk_Segment_40 = '1 Young', 0.2386956044, 0);

m_multi_mod_1m_c53 := if((string)pk_Segment_40 = '1 Young', 0.5370315324, 0);

m_inquiry_mod3_1m_c53 := if((string)pk_Segment_40 = '1 Young', 0.689418861, 0);

m_ver_mod2_notbest_nodob_1m_c53 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c54, 0);

m_ver_mod2_nodob_2m_c55_b1 := 0.499899972;

m_ver_mod2_notbest_nodob_2m_c56 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_nodob_2m_c55_b1);

m_ver_mod2_best_nodob_2m_c56 := if((integer)add1_isbestmatch = 1, m_ver_mod2_nodob_2m_c55_b1, 0);

m_inquiry_mod3_2m_c55 := if((string)pk_Segment_40 = '2 Owner', 0.6493123712, 0);

m_prop_mod3_2m_c55 := if((string)pk_Segment_40 = '2 Owner', 0.4660665218, 0);

m_velocity_mod2_2m_c55 := if((string)pk_Segment_40 = '2 Owner', 0.2767693539, 0);

m_ver_mod2_notbest_nodob_2m_c55 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c56, 0);

m_ver_mod2_best_nodob_2m_c55 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c56, 0);

m_multi_mod_2m_c55 := if((string)pk_Segment_40 = '2 Owner', 0.2909255116, 0);

m_ver_mod2_nodob_3m_c57_b1 := 0.5726880959;

m_ver_mod2_best_nodob_3m_c58 := if((integer)add1_isbestmatch = 1, m_ver_mod2_nodob_3m_c57_b1, 0);

m_ver_mod2_notbest_nodob_3m_c58 := if((integer)add1_isbestmatch = 1, 0, m_ver_mod2_nodob_3m_c57_b1);

m_multi_mod_3m_c57 := if((string)pk_Segment_40 = '3 Other', 0.2782832385, 0);

m_ver_mod2_best_nodob_3m_c57 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c58, 0);

m_ver_mod2_notbest_nodob_3m_c57 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c58, 0);

m_prop_mod3_3m_c57 := if((string)pk_Segment_40 = '3 Other', 0.2489293165, 0);

m_inquiry_mod3_3m_c57 := if((string)pk_Segment_40 = '3 Other', 0.5831345921, 0);

m_velocity_mod2_3m_c57 := if((string)pk_Segment_40 = '3 Other', 0.2597414669, 0);

_25_0_c33_b2 := 0;
_25_1_c33_b2_1 := 0;
_25_2_c33_b2_1 := 0;
_26_0_c33_b2 := 0;
_26_1_c33_b2_1 := 0;
_27_0_c33_b2 := 0;
_27_1_c33_b2_1 := 0;
_27_2_c33_b2_1 := 0;
_27_3_c33_b2_1 := 0;
_28_0_c33_b2 := 0;
_38_0_c33_b2 := 0;
_38_1_c33_b2_1 := 0;
_49_0_c33_b2 := 0;
_52_0_c33_b2 := 0;
_52_1_c33_b2_1 := 0;
_97_0_c33_b2_1 := 0;
_97_1_c33_b2_1 := 0;
_98_0_c33_b2_1 := 0;
_98_1_c33_b2_1 := 0;
_98_2_c33_b2_1 := 0;
_9a_0_c33_b2 := 0;
_9a_1_c33_b2_1 := 0;
_9a_2_c33_b2_1 := 0;
_9a_3_c33_b2_1 := 0;
_9a_4_c33_b2_1 := 0;
_9a_5_c33_b2_1 := 0;
_9a_6_c33_b2_1 := 0;
_9a_7_c33_b2_1 := 0;
_9c_0_c33_b2 := 0;
_9c_1_c33_b2_1 := 0;
_9c_2_c33_b2_1 := 0;
_9c_3_c33_b2_1 := 0;
_9c_4_c33_b2_1 := 0;
_9c_5_c33_b2_1 := 0;
_9c_6_c33_b2_1 := 0;
_9c_7_c33_b2_1 := 0;
_9c_8_c33_b2_1 := 0;
_9c_9_c33_b2_1 := 0;
_9c_10_c33_b2_1 := 0;
_9c_11_c33_b2_1 := 0;
_9d_0_c33_b2 := 0;
_9d_1_c33_b2_1 := 0;
_9d_2_c33_b2_1 := 0;
_9d_3_c33_b2_1 := 0;
_9d_4_c33_b2_1 := 0;
_9d_5_c33_b2_1 := 0;
_9d_6_c33_b2_1 := 0;
_9d_7_c33_b2_1 := 0;
_9d_8_c33_b2_1 := 0;
_9d_9_c33_b2_1 := 0;
_9d_10_c33_b2_1 := 0;
_9d_11_c33_b2_1 := 0;
_9d_12_c33_b2_1 := 0;
_9d_13_c33_b2_1 := 0;
_9d_14_c33_b2_1 := 0;
_9d_15_c33_b2_1 := 0;
_9e_0_c33_b2 := 0;
_9e_1_c33_b2_1 := 0;
_9e_2_c33_b2_1 := 0;
_9e_3_c33_b2_1 := 0;
_9e_4_c33_b2_1 := 0;
_9e_5_c33_b2_1 := 0;
_9e_6_c33_b2_1 := 0;
_9e_7_c33_b2_1 := 0;
_9e_8_c33_b2_1 := 0;
_9e_9_c33_b2_1 := 0;
_9e_10_c33_b2_1 := 0;
_9e_11_c33_b2_1 := 0;
_9e_12_c33_b2_1 := 0;
_9e_13_c33_b2_1 := 0;
_9e_14_c33_b2_1 := 0;
_9g_0_c33_b2 := 0;
_9g_1_c33_b2_1 := 0;
_9g_2_c33_b2_1 := 0;
_9g_3_c33_b2_1 := 0;
_9g_4_c33_b2_1 := 0;
_9g_5_c33_b2_1 := 0;
_9g_6_c33_b2_1 := 0;
_9h_0_c33_b2_1 := 0;
_9h_1_c33_b2_1 := 0;
_9j_0_c33_b2 := 0;
_9j_1_c33_b2_1 := 0;
_9j_2_c33_b2_1 := 0;
_9j_3_c33_b2_1 := 0;
_9j_4_c33_b2_1 := 0;
_9j_5_c33_b2_1 := 0;
_9k_0_c33_b2_1 := 0;
_9l_0_c33_b2 := 0;
_9l_1_c33_b2_1 := 0;
_9l_2_c33_b2_1 := 0;
_9m_0_c33_b2 := 0;
_9m_1_c33_b2_1 := 0;
_9m_2_c33_b2_1 := 0;
_9m_3_c33_b2_1 := 0;
_9m_4_c33_b2_1 := 0;
_9m_5_c33_b2_1 := 0;
_9m_6_c33_b2_1 := 0;
_9o_0_c33_b2 := 0;
_9o_1_c33_b2_1 := 0;
_9o_2_c33_b2_1 := 0;
_9o_3_c33_b2_1 := 0;
_9o_4_c33_b2_1 := 0;
_9o_5_c33_b2_1 := 0;
_9q_0_c33_b2 := 0;
_9q_1_c33_b2_1 := 0;
_9q_2_c33_b2_1 := 0;
_9q_3_c33_b2_1 := 0;
_9q_4_c33_b2_1 := 0;
_9q_5_c33_b2_1 := 0;
_9q_6_c33_b2_1 := 0;
_9q_7_c33_b2_1 := 0;
_9q_8_c33_b2_1 := 0;
_9q_9_c33_b2_1 := 0;
_9q_10_c33_b2_1 := 0;
_9q_11_c33_b2_1 := 0;
_9r_0_c33_b2 := 0;
_9r_1_c33_b2_1 := 0;
_9r_2_c33_b2_1 := 0;
_9r_3_c33_b2_1 := 0;
_9r_4_c33_b2_1 := 0;
_9r_5_c33_b2_1 := 0;
_9r_6_c33_b2_1 := 0;
_9r_7_c33_b2_1 := 0;
_9r_8_c33_b2_1 := 0;
_9r_9_c33_b2_1 := 0;
_9r_10_c33_b2_1 := 0;
_9r_11_c33_b2_1 := 0;
_9r_12_c33_b2_1 := 0;
_9r_13_c33_b2_1 := 0;
_9r_14_c33_b2_1 := 0;
_9r_15_c33_b2_1 := 0;
_9r_16_c33_b2_1 := 0;
_9r_17_c33_b2_1 := 0;
_9r_18_c33_b2_1 := 0;
_9r_19_c33_b2_1 := 0;
_9r_20_c33_b2_1 := 0;
_9r_21_c33_b2_1 := 0;
_9r_22_c33_b2_1 := 0;
_9r_23_c33_b2_1 := 0;
_9r_24_c33_b2_1 := 0;
_9r_25_c33_b2_1 := 0;
_9r_26_c33_b2_1 := 0;
_9r_27_c33_b2_1 := 0;
_9r_28_c33_b2_1 := 0;
_9r_29_c33_b2_1 := 0;
_9r_30_c33_b2_1 := 0;
_9r_31_c33_b2_1 := 0;
_9r_32_c33_b2_1 := 0;
_9r_33_c33_b2_1 := 0;
_9s_0_c33_b2 := 0;
_9s_1_c33_b2_1 := 0;
_9t_0_c33_b2 := 0;
_9t_1_c33_b2_1 := 0;
_9u_0_c33_b2 := 0;
_9u_1_c33_b2_1 := 0;
_9w_0_c33_b2_1 := 0;
_9w_1_c33_b2 := 0;
_ev_0_c33_b2_1 := 0;
_ev_1_c33_b2_1 := 0;
_mi_0_c33_b2 := 0;
_mi_1_c33_b2_1 := 0;
_mi_2_c33_b2_1 := 0;
_ms_0_c33_b2 := 0;
_ms_1_c33_b2_1 := 0;
_ms_2_c33_b2_1 := 0;
_ms_3_c33_b2_1 := 0;
_pv_0_c33_b2 := 0;
_pv_1_c33_b2_1 := 0;
_pv_2_c33_b2_1 := 0;
_pv_3_c33_b2_1 := 0;
_x11_0_c33_b2 := 0;
_x11_1_c33_b2_1 := 0;
_x11_2_c33_b2_1 := 0;
_x11_3_c33_b2_1 := 0;
_x11_4_c33_b2_1 := 0;
_x11_5_c33_b2_1 := 0;
_x11_6_c33_b2_1 := 0;
_x11_7_c33_b2_1 := 0;
_x11_8_c33_b2_1 := 0;
_x11_9_c33_b2_1 := 0;
_x11_10_c33_b2_1 := 0;
_x11_11_c33_b2_1 := 0;
_x11_12_c33_b2_1 := 0;
_x11_13_c33_b2_1 := 0;
_x11_14_c33_b2_1 := 0;
_x11_15_c33_b2_1 := 0;

seg_s0_crime_c60_b1 := -1.74103570759888;

_97_0_c60 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (seg_s0_crime_c60_b1 - -2.65747691), 0);

seg_s0_lien_c61_b1 := -1.74103570759888;

_98_0_c61 := if(lien_flag, (seg_s0_lien_c61_b1 - -2.65747691), 0);

seg_s0_eviction_c62_b1 := -1.74103570759888;

_ev_0_c62 := if(bs_attr_eviction_flag > 0, (seg_s0_eviction_c62_b1 - -2.65747691), 0);

seg_s0_impulse_c63_b1 := -1.74103570759888;

_9h_0_c63 := if(pk_impulse_count > 0, (seg_s0_impulse_c63_b1 - -2.65747691), 0);

seg_s0_bk_c64_b1 := -1.74103570759888;

_9w_0_c64 := if(bk_flag, (seg_s0_bk_c64_b1 - -2.65747691), 0);

_9d_3_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.344032964 * (pk_unique_addr_count_S0_0m - 0.1259452717), _9d_3_c33_b2_1);

_9r_5_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 2.7663458563 * (pk_Time_on_CB_120b_S0_0mn - 0.1315053162), _9r_5_c33_b2_1);

_9q_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod3_0m_c51 * 3.855531946 * (pk_inq_peradl_0m - 0.1352414584), _9q_1_c33_b2_1);

_9e_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 3.6283003352 * (pk_nap_summary_ver_0mb - 0.1518255411), _9e_2_c33_b2_1);

_9r_4_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 7.4217712708 * (pk_mth_ver_src_fdate_TS2_0mn - 0.1870748299), _9r_4_c33_b2_1);

_ev_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c51 * 3.4981851095 * (pk_yr_attr_dt_last_evict2_0m - 0.1401640117), _ev_1_c33_b2_1);

_x11_3_c59 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c51 * 2.0935362135 * (pk_phones_per_addr_c6_S0_0m - 0.1332162761), _x11_3_c33_b2_1);

_9h_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c51 * 5.6731345565 * (pk_impulse_count_0m - 0.1301859357), _9h_1_c33_b2_1);

_25_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 1.9460948246 * (pk_add1_house_number_match_0mn - 0.2822822823), _25_1_c33_b2_1);

_9r_3_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 2.1684190475 * (pk_email_domain_free_count_0mn - 0.1793852676), _9r_3_c33_b2_1);

_9o_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 2.0554635487 * (eda_sourced_level_0mn - 0.1755555556), _9o_1_c33_b2_1);

_x11_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c51 * 5.5250476734 * (pk_adls_per_addr_c6_S0_0m - 0.1171607604), _x11_2_c33_b2_1);

_9r_11_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 3.6984753179 * (pk_Time_on_CB_120b_S0_0mb - 0.1183391003), _9r_11_c33_b2_1);

_9a_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.8668277273 * (pk_ver_src_nas_P_lvl_S0_0m - 0.1041666667), _9a_1_c33_b2_1);

_9r_6_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 3.1534003122 * (pk_infutor_nap_0mb - 0.120539769), _9r_6_c33_b2_1);

_9e_3_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 2.7612560199 * (pk_attr_num_nonderogs_0mb - 0.1125546865), _9e_3_c33_b2_1);

_9j_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 1.3390632614 * (pk_mth_hdr_frst_sn2_s0_0mb - 0.1205711264), _9j_2_c33_b2_1);

_9w_0_c59 := if((string)pk_Segment_40 = '0 Derog', _9w_0_c64, _9w_0_c33_b2_1);

_9c_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 1.7013607216 * (pk_avg_mo_per_addr_S0_0m - 0.115057871), _9c_1_c33_b2_1);

_9e_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 2.4086748386 * (pk_attr_num_nonderogs180_0mn - 0.1714100906), _9e_1_c33_b2_1);

_97_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c51 * 6.8518336867 * (pk_crim_fel_date_0m - 0.1423313266), _97_1_c33_b2_1);

_98_0_c59 := if((string)pk_Segment_40 = '0 Derog', _98_0_c61, _98_0_c33_b2_1);

_9m_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 5.1916392813 * (pk_ams_income_level_code_0mb - 0.1287998913), _9m_1_c33_b2_1);

_9r_10_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 9.2400478523 * (pk_mth_ver_src_fdate_TS2_0mb - 0.1309935953), _9r_10_c33_b2_1);

_ev_0_c59 := if((string)pk_Segment_40 = '0 Derog', _ev_0_c62, _ev_0_c33_b2_1);

_98_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c51 * 2.9941440297 * (pk_lien_tree_0m - 0.1351682199), _98_1_c33_b2_1);

_9h_0_c59 := if((string)pk_Segment_40 = '0 Derog', _9h_0_c63, _9h_0_c33_b2_1);

_9q_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod3_0m_c51 * 4.2911860475 * (pk_inq_ssnsperaddr_0m - 0.1233882317), _9q_2_c33_b2_1);

_9d_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 3.0427812845 * (pk_addrs_5yr_S0_0m - 0.151718081), _9d_2_c33_b2_1);

_27_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 1.9196277005 * (pk_combo_hphonecount_0mn - 0.133279483), _27_1_c33_b2_1);

_9j_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 1.8862971104 * (pk_mth_hdr_frst_sn2_s0_0mn - 0.1412918108), _9j_1_c33_b2_1);

_9d_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c51 * 5.4362296312 * (pk_addrs_per_ssn_c6_0m - 0.1348231748), _9d_1_c33_b2_1);

_9r_9_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 3.8689686942 * (pk_mth_infutor_first_seen2_0mb - 0.120539769), _9r_9_c33_b2_1);

_98_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod2_0m_c51 * 4.0462686252 * (pk_unrel_last_sn_dt2_0m - 0.1348257006), _98_2_c33_b2_1);

_9d_4_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.7849444117 * (pk_addrs_per_adl_S0_0m - 0.1289558377), _9d_4_c33_b2_1);

_9c_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 1.6906705271 * (pk_addr_count_ge3_S0_0m - 0.1147284045), _9c_2_c33_b2_1);

_9c_3_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.9693976211 * (pk_mth_add1_dt_f_sn_S0_0m - 0.1378755365), _9c_3_c33_b2_1);

_9r_7_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 8.5594143707 * (pk_email_count_0mb - 0.1292080613), _9r_7_c33_b2_1);

_9r_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 2.4939772668 * (pk_infutor_nap_0mn - 0.1926457399), _9r_1_c33_b2_1);

_9e_5_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 1.0758001771 * (pk_Bureau_Only_0mb - 0.1272528008), _9e_5_c33_b2_1);

_9r_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_notbest_nodob_0m_c51 * 3.9952402281 * (pk_email_count_0mn - 0.1821289063), _9r_2_c33_b2_1);

_9d_5_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.3103518938 * (pk_addr_adl_tree_0m - 0.143627451), _9d_5_c33_b2_1);

_97_0_c59 := if((string)pk_Segment_40 = '0 Derog', _97_0_c60, _97_0_c33_b2_1);

_9r_8_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 1.993071646 * (pk_mth_gong_did_frst_sn2_0mb - 0.1372901679), _9r_8_c33_b2_1);

_9e_4_c59 := if((string)pk_Segment_40 = '0 Derog', m_ver_mod2_best_nodob_0m_c51 * 2.5431474304 * (pk_attr_num_nonderogs180_0mb - 0.1188507209), _9e_4_c33_b2_1);

_x11_1_c59 := if((string)pk_Segment_40 = '0 Derog', m_velocity_mod2_0m_c51 * 1.0867113227 * (pk_per_adl_tree2 - 0), _x11_1_c33_b2_1);

_9a_2_c59 := if((string)pk_Segment_40 = '0 Derog', m_prop_mod3_0m_c51 * 2.0744598126 * (pk_prop_os_tot_tree_S0_0m - 0.1176786674), _9a_2_c33_b2_1);

seg_s1_c65_b1 := -1.71962281044579;

_x11_6_c65 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c53 * 7.4074183839 * (pk_ssns_per_addr_S1_1m - 0.1695402299), _x11_6_c33_b2_1);

_9m_3_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 4.1777462476 * (pk_ams_income_level_code_1mb - 0.1567099567), _9m_3_c33_b2_1);

_9e_7_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 4.9380956098 * (pk_attr_num_nonderogs180_1mn - 0.1936449963), _9e_7_c33_b2_1);

_9o_2_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 4.3121268207 * (eda_sourced_level_1mn - 0.2029494919), _9o_2_c33_b2_1);

_9c_4_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 3.6791525371 * (pk_avg_mo_per_addr_S1_1m - 0.1410060544), _9c_4_c33_b2_1);

_26_1_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 25.415123012 * (pk_ssn_score_ver_1mb - 0.13774768), _26_1_c33_b2_1);

_9g_1_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 4.5245115251 * (pk_ams_age_1mn - 0.1890577508), _9g_1_c33_b2_1);

_ms_1_c65 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c53 * 5.3703403836 * (pk_ssns_per_adl_S1_1m - 0.1477155164), _ms_1_c33_b2_1);

_9o_3_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 8.4791012236 * (eda_sourced_level_1mb - 0.1652065681), _9o_3_c33_b2_1);

_9c_6_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 2.5628573759 * (pk_mth_add1_dt_f_sn_S1_1m - 0.1585373489), _9c_6_c33_b2_1);

_9r_21_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 8.3619969329 * (pk_Time_on_CB_120b_S1_1mb - 0.1527624648), _9r_21_c33_b2_1);

_x11_4_c65 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c53 * 6.3944644454 * (pk_adls_per_addr_c6_S1_1m - 0.1617546732), _x11_4_c33_b2_1);

_9d_6_c65 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c53 * 6.2127523934 * (pk_addrs_per_ssn_c6_1m - 0.1379811184), _9d_6_c33_b2_1);

_9r_15_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 5.4745732211 * (pk_mth_infutor_first_seen2_1mn - 0.1818888793), _9r_15_c33_b2_1);

_9q_5_c65 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c53 * 0.9769414713 * (pk_inq_perphone_S1_1m - 0.1428443345), _9q_5_c33_b2_1);

_mi_1_c65 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c53 * 5.9197343157 * (pk_adlperssn_count_S1_1m - 0.143471833), _mi_1_c33_b2_1);

_9r_16_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 5.2406554273 * (pk_Time_on_CB_120b_S1_1mn - 0.2076974121), _9r_16_c33_b2_1);

_9e_6_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 2.4410979187 * (pk_nap_summary_ver_1mn - 0.190343075), _9e_6_c33_b2_1);

_9r_14_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 8.2543562744 * (pk_mth_gong_did_frst_sn2_1mn - 0.1776476009), _9r_14_c33_b2_1);

_9r_20_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 3.8700300272 * (pk_mth_infutor_first_seen2_1mb - 0.132865524), _9r_20_c33_b2_1);

_9q_3_c65 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c53 * 3.8457211099 * (pk_inq_count06_S1_1m - 0.1372722579), _9q_3_c33_b2_1);

_x11_5_c65 := if((string)pk_Segment_40 = '1 Young', m_velocity_mod2_1m_c53 * 2.6897227927 * (pk_phones_per_addr_c6_S1_1m - 0.1404480299), _x11_5_c33_b2_1);

_9q_4_c65 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod3_1m_c53 * 4.0435754671 * (pk_inq_ssnsperaddr_1m - 0.128611965), _9q_4_c33_b2_1);

_9g_2_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 3.1641213343 * (pk_ams_age_1mb - 0.143442623), _9g_2_c33_b2_1);

_9r_19_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 10.865777734 * (pk_mth_gong_did_frst_sn2_1mb - 0.1346387539), _9r_19_c33_b2_1);

_9g_4_c65 := if((string)pk_Segment_40 = '1 Young', 3.5243458288 * (pk_age_estimate_S1_1m - 0.1562899577), _9g_4_c33_b2_1);

_9d_7_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 15.180834187 * (pk_unique_addr_count_S1_1m - 0.1555290695), _9d_7_c33_b2_1);

_9r_17_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 9.2266766518 * (pk_email_count_1mb - 0.1347143551), _9r_17_c33_b2_1);

_9r_12_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 3.8864473973 * (pk_infutor_nap_1mn - 0.163256785), _9r_12_c33_b2_1);

_9r_18_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 5.4094784887 * (pk_email_domain_free_count_1mb - 0.13494551), _9r_18_c33_b2_1);

_9c_5_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 4.7476141306 * (pk_addr_count_ge3_S1_1m - 0.1631896528), _9c_5_c33_b2_1);

_9d_8_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 4.1294041852 * (pk_addr_adl_tree_1m - 0.1539256198), _9d_8_c33_b2_1);

_9d_9_c65 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c53 * 2.403109629 * (pk_addrs_per_ssn_S1_1m - 0.1619248606), _9d_9_c33_b2_1);

_x11_7_c65 := if((string)pk_Segment_40 = '1 Young', m_multi_mod_1m_c53 * 4.9056517789 * (pk_adls_per_phone_S1_1m - 0.1640049606), _x11_7_c33_b2_1);

_9e_8_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_best_nodob_1m_c53 * 6.0560720776 * (pk_attr_num_nonderogs180_1mb - 0.142676417), _9e_8_c33_b2_1);

_9g_3_c65 := if((string)pk_Segment_40 = '1 Young', (seg_s1_c65_b1 - -2.65747691), _9g_3_c33_b2_1);

_9m_4_c65 := if((string)pk_Segment_40 = '1 Young', 1.2394518323 * (pk_estimated_income_S1_1m - 0.1471165644), _9m_4_c33_b2_1);

_9r_13_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 10.985959156 * (pk_email_count_1mn - 0.1787202381), _9r_13_c33_b2_1);

_pv_1_c65 := if((string)pk_Segment_40 = '1 Young', m_prop_mod3_1m_c53 * 4.5055167174 * (pk_add1_avm_auto_val_S1_1m - 0.1636079656), _pv_1_c33_b2_1);

_9l_1_c65 := if((string)pk_Segment_40 = '1 Young', 4.633801256 * (pk_dist_a1toa2_b_1m - 0.1363990647), _9l_1_c33_b2_1);

_9m_2_c65 := if((string)pk_Segment_40 = '1 Young', m_ver_mod2_notbest_nodob_1m_c53 * 3.455004265 * (pk_ams_income_level_code_1mn - 0.2090883485), _9m_2_c33_b2_1);

// _9u_1_c67 := if(add_apt and pk_add1_advo_address_vacancy = 0 and pk_add1_advo_throw_back = 0 and pk_add1_advo_seasonal_delivery = 0 and pk_add1_advo_college = 0 and pk_add1_advo_res_or_business = 0 and pk_add1_advo_drop = 0 and pk_add_inval = 0 and pk_add1_advo_mixed_address_usage = 0 and pk_add_hirisk_comm = 0, 0, M_FP_mod_NoDob_2M * 14.637609692 * (pk_AddProb_S2_2m - 0.0266113577));

// _9k_0_c67 := if(add_apt and pk_add1_advo_address_vacancy = 0 and pk_add1_advo_throw_back = 0 and pk_add1_advo_seasonal_delivery = 0 and pk_add1_advo_college = 0 and pk_add1_advo_res_or_business = 0 and pk_add1_advo_drop = 0 and pk_add_inval = 0 and pk_add1_advo_mixed_address_usage = 0 and pk_add_hirisk_comm = 0, M_FP_mod_NoDob_2M * 14.637609692 * (pk_AddProb_S2_2m - 0.0266113577), 0);

_9q_8_c66 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c55 * 4.095272152 * (pk_inq_perphone_S2_2m - 0.0345173019), _9q_8_c33_b2_1);

_9d_11_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 7.3320048268 * (pk_addrs_5yr_S2_2m - 0.0362266338), _9d_11_c33_b2_1);

_9o_4_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c55 * 7.9806402465 * (eda_sourced_level_2mn - 0.032149774), _9o_4_c33_b2_1);

_9r_25_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 17.693309572 * (pk_mth_infutor_first_seen2_2mb - 0.0249518121), _9r_25_c33_b2_1);

_9j_3_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c55 * 14.56131646 * (pk_mth_hdr_frst_sn2_s2_2mn - 0.043956044), _9j_3_c33_b2_1);

_9l_2_c66 := if((string)pk_Segment_40 = '2 Owner', 16.224007824 * (pk_dist_a1toa2_b_2m - 0.0344738589), _9l_2_c33_b2_1);

_9q_6_c66 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c55 * 6.8587445606 * (pk_inq_banking_count06_S2_2m - 0.034514581), _9q_6_c33_b2_1);

_9e_9_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c55 * 12.119035749 * (pk_pos_addr_src_cnt_2mn - 0.0393992164), _9e_9_c33_b2_1);

_9r_22_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c55 * 11.896214119 * (pk_mth_infutor_first_seen2_2mn - 0.0399017802), _9r_22_c33_b2_1);

_9s_1_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 0.3019660959 * (pk_adj_finance - 0), _9s_1_c33_b2_1);

_9g_5_c66 := if((string)pk_Segment_40 = '2 Owner', 5.177626719 * (pk_age_estimate_S2_2m - 0.0297116737), _9g_5_c33_b2_1);

_pv_2_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 36.807049194 * (pk_add1_avm_auto_val_S2_2m - 0.033856933), _pv_2_c33_b2_1);

_9a_4_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 8.4225607355 * (pk_mth_attr_dt_frst_prch_s2_2m - 0.0381729201), _9a_4_c33_b2_1);

_9d_12_c66 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c55 * 29.609841917 * (pk_addrs_per_ssn_S2_2m - 0.0388854912), _9d_12_c33_b2_1);

_9a_6_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 34.832765912 * (pk_ver_src_nas_P_lvl_S2_2m - 0.0333815792), _9a_6_c33_b2_1);

_27_2_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_notbest_nodob_2m_c55 * 7.358742569 * (pk_hphn_score_ver_2mn - 0.035315392), _27_2_c33_b2_1);

// _9u_1_c66 := if((string)pk_Segment_40 = '2 Owner', _9u_1_c67, _9u_1_c33_b2_1);
_9u_1_c66 := if((string)pk_Segment_40 = '2 Owner', 0, _9u_1_c33_b2_1);

_ms_2_c66 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c55 * 15.777487667 * (pk_ssns_per_adl_S2_2m - 0.0340343361), _ms_2_c33_b2_1);

// _9t_1_c66 := if((string)pk_Segment_40 = '2 Owner', M_FP_mod_NoDob_2M * 22.254455306 * (pk_PhnProb2_S2_2m - 0.0266016951), _9t_1_c33_b2_1);

_9r_24_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 15.6864953 * (pk_mth_gong_did_frst_sn2_2mb - 0.0304247063), _9r_24_c33_b2_1);

_9c_7_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 12.623750588 * (pk_avg_mo_per_addr_S2_2m - 0.0266471562), _9c_7_c33_b2_1);

_9e_11_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 12.62432316 * (pk_pos_addr_src_cnt_2mb - 0.0312069603), _9e_11_c33_b2_1);

_9e_10_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 15.539731422 * (pk_nap_summary_ver_2mb - 0.0240947905), _9e_10_c33_b2_1);

_x11_8_c66 := if((string)pk_Segment_40 = '2 Owner', m_velocity_mod2_2m_c55 * 21.157258935 * (pk_ssns_per_addr_c6_S2_2m - 0.02946765), _x11_8_c33_b2_1);

_9q_7_c66 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod3_2m_c55 * 12.294831112 * (pk_inq_adlsperaddr_S2_2m - 0.0323563706), _9q_7_c33_b2_1);

_9m_5_c66 := if((string)pk_Segment_40 = '2 Owner', 17.843598304 * (pk_estimated_income_S2_2m - 0.0326581702), _9m_5_c33_b2_1);

_x11_9_c66 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c55 * 20.159096122 * (pk_ssns_per_addr_S2_2m - 0.034895568), _x11_9_c33_b2_1);

_52_1_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 13.57531086 * (pk_rc_fnamessnmatch_2mb - 0.0306655942), _52_1_c33_b2_1);

_9r_26_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 12.220292677 * (pk_Time_on_CB_120b_S2_2mb - 0.0313430815), _9r_26_c33_b2_1);

_9a_5_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 32.609075365 * (pk_prop_owned_sold_lvl_S2_2m - 0.0362068489), _9a_5_c33_b2_1);

_9a_3_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 18.028345846 * (pk_add1_ownership_S2_2m - 0.0290110836), _9a_3_c33_b2_1);

_9j_4_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 10.951243793 * (pk_mth_hdr_frst_sn2_s2_2mb - 0.0317965024), _9j_4_c33_b2_1);

_x11_10_c66 := if((string)pk_Segment_40 = '2 Owner', m_multi_mod_2m_c55 * 22.352221451 * (pk_adls_per_phone_S2_2m - 0.0273033408), _x11_10_c33_b2_1);

_9c_8_c66 := if((string)pk_Segment_40 = '2 Owner', m_prop_mod3_2m_c55 * 19.347329476 * (pk_mth_add1_prch_dt_s2_2m - 0.0332513054), _9c_8_c33_b2_1);

// _9k_0_c66 := if((string)pk_Segment_40 = '2 Owner', _9k_0_c67, _9k_0_c33_b2_1);
_9k_0_c66 := if((string)pk_Segment_40 = '2 Owner', 0, _9k_0_c33_b2_1);

_9r_23_c66 := if((string)pk_Segment_40 = '2 Owner', m_ver_mod2_best_nodob_2m_c55 * 26.950644912 * (pk_email_src_cnt_2mb - 0.0305416277), _9r_23_c33_b2_1);

_9d_10_c66 := if((string)pk_Segment_40 = '2 Owner', m_velocity_mod2_2m_c55 * 17.521424672 * (pk_addrs_per_ssn_c6_2m - 0.034006564), _9d_10_c33_b2_1);

_9q_9_c68 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c57 * 5.15317718 * (pk_inq_banking_count06_S3_3m - 0.0611931742), _9q_9_c33_b2_1);

_9r_33_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 7.1101884192 * (pk_mth_ver_src_fdt_wp2_s3_3mb - 0.0651410153), _9r_33_c33_b2_1);

_9m_6_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 12.798231916 * (pk_ams_income_level_code_3mb - 0.0589933572), _9m_6_c33_b2_1);

_9r_27_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 10.949529591 * (pk_email_count_3mn - 0.0810018652), _9r_27_c33_b2_1);

_9a_7_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 15.519318588 * (pk_ver_src_nas_P_lvl_S3_3m - 0.0713321464), _9a_7_c33_b2_1);

_9d_13_c68 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c57 * 10.085456293 * (pk_addrs_per_ssn_c6_3m - 0.0608578761), _9d_13_c33_b2_1);

_x11_13_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 12.483268484 * (pk_ssns_per_addr_S3_3m - 0.0604354354), _x11_13_c33_b2_1);

_9d_15_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 10.48741794 * (pk_addrs_per_ssn_S3_3m - 0.0712982543), _9d_15_c33_b2_1);

_9r_31_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 14.464016015 * (pk_email_src_cnt_3mb - 0.0559321569), _9r_31_c33_b2_1);

_9r_30_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 8.2070443967 * (pk_Time_on_CB_120b_S3_3mn - 0.0917487685), _9r_30_c33_b2_1);

_x11_12_c68 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c57 * 3.6565553387 * (pk_phones_per_addr_c6_S3_3m - 0.0564617592), _x11_12_c33_b2_1);

_9r_32_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 10.060818479 * (pk_mth_infutor_first_seen2_3mb - 0.0477428883), _9r_32_c33_b2_1);

_mi_2_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 8.2698873761 * (pk_adlperssn_count_S3_3m - 0.0621496985), _mi_2_c33_b2_1);

_9q_11_c68 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c57 * 2.1460583078 * (pk_inq_adlsperphone_S3_3m - 0.0617454877), _9q_11_c33_b2_1);

_9e_14_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 5.1624247051 * (pk_attr_num_nonderogs180_3mb - 0.0504113426), _9e_14_c33_b2_1);

_9j_5_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 14.208883648 * (pk_mth_hdr_frst_sn2_s3_3mb - 0.0730452675), _9j_5_c33_b2_1);

_9r_29_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 18.405606911 * (pk_mth_ver_src_fdate_TS2_3mn - 0.0834823164), _9r_29_c33_b2_1);

_9d_14_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 4.8495549202 * (pk_addr_adl_tree_3m - 0.0487126179), _9d_14_c33_b2_1);

_x11_14_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 3.3856906889 * (pk_phones_per_addr_S3_3m - 0.069124159), _x11_14_c33_b2_1);

_x11_15_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 9.2201735363 * (pk_adls_per_phone_S3_3m - 0.0469432635), _x11_15_c33_b2_1);

_pv_3_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 13.328567339 * (pk_add1_avm_auto_val_S3_3m - 0.061606087), _pv_3_c33_b2_1);

_27_3_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 5.091109502 * (pk_combo_hphonecount_3mn - 0.0562543193), _27_3_c33_b2_1);

_38_1_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 10.872661802 * (pk_nameperssn_count_3m - 0.0639080541), _38_1_c33_b2_1);

_9c_10_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 6.6587194786 * (pk_addr_count_ge3_S3_3m - 0.0635507917), _9c_10_c33_b2_1);

_9g_6_c68 := if((string)pk_Segment_40 = '3 Other', 4.0306231422 * (pk_age_estimate_S3_3m - 0.0651025153), _9g_6_c33_b2_1);

_9e_12_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 7.0608095826 * (pk_attr_num_nonderogs180_3mn - 0.0710290828), _9e_12_c33_b2_1);

_9r_28_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 6.9384413464 * (pk_mth_infutor_first_seen2_3mn - 0.0746973117), _9r_28_c33_b2_1);

_9c_9_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 5.2353257748 * (pk_avg_mo_per_addr_S3_3m - 0.0713834491), _9c_9_c33_b2_1);

_9o_5_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 4.9679172668 * (eda_sourced_level_3mn - 0.0860155383), _9o_5_c33_b2_1);

_9q_10_c68 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod3_3m_c57 * 9.0405770439 * (pk_inq_ssnsperaddr_3m - 0.0532185482), _9q_10_c33_b2_1);

_x11_11_c68 := if((string)pk_Segment_40 = '3 Other', m_velocity_mod2_3m_c57 * 12.034307813 * (pk_ssns_per_addr_c6_S3_3m - 0.0481777198), _x11_11_c33_b2_1);

_ms_3_c68 := if((string)pk_Segment_40 = '3 Other', m_multi_mod_3m_c57 * 9.403316697 * (pk_ssns_per_adl_S3_3m - 0.0621186911), _ms_3_c33_b2_1);

_9c_11_c68 := if((string)pk_Segment_40 = '3 Other', m_prop_mod3_3m_c57 * 10.40804382 * (pk_mth_add1_dt_f_sn_S3_3m - 0.0648187633), _9c_11_c33_b2_1);

_25_2_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_notbest_nodob_3m_c57 * 6.2238683008 * (pk_add1_house_number_match_3mn - 0.0699885093), _25_2_c33_b2_1);

_9e_13_c68 := if((string)pk_Segment_40 = '3 Other', m_ver_mod2_best_nodob_3m_c57 * 10.160173856 * (pk_nap_summary_ver_3mb - 0.0379005261), _9e_13_c33_b2_1);

_9h := if((integer)dobpop = 1, glrc9h * sum(_9h_0_c42, _9h_1_c42), glrc9h * sum(_9h_0_c59, _9h_1_c59));

_9c := if((integer)dobpop = 1, glrc9c * sum(_9c_0_c33_b1, _9c_1_c42, _9c_2_c42, _9c_3_c42, _9c_4_c48, _9c_5_c48, _9c_6_c48, _9c_7_c49, _9c_8_c49, _9c_9_c50, _9c_10_c50, _9c_11_c50), glrc9c * sum(_9c_0_c33_b2, _9c_1_c59, _9c_2_c59, _9c_3_c59, _9c_4_c65, _9c_5_c65, _9c_6_c65, _9c_7_c66, _9c_8_c66, _9c_9_c68, _9c_10_c68, _9c_11_c68));

_26 := if((integer)dobpop = 1, glrc26 * sum(_26_0_c33_b1, _26_1_c48), glrc26 * sum(_26_0_c33_b2, _26_1_c65));

_mi := if((integer)dobpop = 1, glrcmi * sum(_mi_0_c33_b1, _mi_1_c48, _mi_2_c50), glrcmi * sum(_mi_0_c33_b2, _mi_1_c65, _mi_2_c68));

_9u := if((integer)dobpop = 1, glrc9u * sum(_9u_0_c33_b1), glrc9u * sum(_9u_0_c33_b2, _9u_1_c66));

_9j := if((integer)dobpop = 1, glrc9j * sum(_9j_0_c33_b1, _9j_1_c42, _9j_2_c42, _9j_3_c49, _9j_4_c49, _9j_5_c50), glrc9j * sum(_9j_0_c33_b2, _9j_1_c59, _9j_2_c59, _9j_3_c66, _9j_4_c66, _9j_5_c68));

_9o := if((integer)dobpop = 1, glrc9o * sum(_9o_0_c33_b1, _9o_1_c42, _9o_2_c48, _9o_3_c48, _9o_4_c49, _9o_5_c50), glrc9o * sum(_9o_0_c33_b2, _9o_1_c59, _9o_2_c65, _9o_3_c65, _9o_4_c66, _9o_5_c68));

// _9t := if((integer)dobpop = 1, glrc9t * sum(_9t_0_c33_b1), glrc9t * sum(_9t_0_c33_b2, _9t_1_c66));
_9t := if((integer)dobpop = 1, glrc9t * sum(_9t_0_c33_b1), glrc9t * sum(_9t_0_c33_b2, 0));

_9e := if((integer)dobpop = 1, glrc9e * sum(_9e_0_c33_b1, _9e_1_c42, _9e_2_c42, _9e_3_c42, _9e_4_c42, _9e_5_c42, _9e_6_c48, _9e_7_c48, _9e_8_c48, _9e_9_c49, _9e_10_c49, _9e_11_c49, _9e_12_c50, _9e_13_c50, _9e_14_c50), glrc9e * sum(_9e_0_c33_b2, _9e_1_c59, _9e_2_c59, _9e_3_c59, _9e_4_c59, _9e_5_c59, _9e_6_c65, _9e_7_c65, _9e_8_c65, _9e_9_c66, _9e_10_c66, _9e_11_c66, _9e_12_c68, _9e_13_c68, _9e_14_c68));

_28 := if((integer)dobpop = 1, glrc28 * sum(_28_0_c33_b1, _28_1_c42, _28_2_c48, _28_3_c50), glrc28 * sum(_28_0_c33_b2));

_9w := if((integer)dobpop = 1, glrc9w * sum(_9w_0_c42, _9w_1_c33_b1), glrc9w * sum(_9w_0_c59, _9w_1_c33_b2));

_9m := if((integer)dobpop = 1, glrc9m * sum(_9m_0_c33_b1, _9m_1_c42, _9m_2_c48, _9m_3_c48, _9m_4_c48, _9m_5_c49, _9m_6_c50), glrc9m * sum(_9m_0_c33_b2, _9m_1_c59, _9m_2_c65, _9m_3_c65, _9m_4_c65, _9m_5_c66, _9m_6_c68));

_ev := if((integer)dobpop = 1, glrcev * sum(_ev_0_c42, _ev_1_c42), glrcev * sum(_ev_0_c59, _ev_1_c59));

_38 := if((integer)dobpop = 1, glrc38 * sum(_38_0_c33_b1, _38_1_c50), glrc38 * sum(_38_0_c33_b2, _38_1_c68));

_pv := if((integer)dobpop = 1, glrcpv * sum(_pv_0_c33_b1, _pv_1_c48, _pv_2_c49, _pv_3_c50), glrcpv * sum(_pv_0_c33_b2, _pv_1_c65, _pv_2_c66, _pv_3_c68));

_97 := if((integer)dobpop = 1, glrc97 * sum(_97_0_c42, _97_1_c42), glrc97 * sum(_97_0_c59, _97_1_c59));

_9r := if((integer)dobpop = 1, glrc9r * sum(_9r_0_c33_b1, _9r_1_c42, _9r_2_c42, _9r_3_c42, _9r_4_c42, _9r_5_c42, _9r_6_c42, _9r_7_c42, _9r_8_c42, _9r_9_c42, _9r_10_c42, _9r_11_c42, _9r_12_c48, _9r_13_c48, _9r_14_c48, _9r_15_c48, _9r_16_c48, _9r_17_c48, _9r_18_c48, _9r_19_c48, _9r_20_c48, _9r_21_c48, _9r_22_c49, _9r_23_c49, _9r_24_c49, _9r_25_c49, _9r_26_c49, _9r_27_c50, _9r_28_c50, _9r_29_c50, _9r_30_c50, _9r_31_c50, _9r_32_c50, _9r_33_c50, _9r_34_c50), glrc9r * sum(_9r_0_c33_b2, _9r_1_c59, _9r_2_c59, _9r_3_c59, _9r_4_c59, _9r_5_c59, _9r_6_c59, _9r_7_c59, _9r_8_c59, _9r_9_c59, _9r_10_c59, _9r_11_c59, _9r_12_c65, _9r_13_c65, _9r_14_c65, _9r_15_c65, _9r_16_c65, _9r_17_c65, _9r_18_c65, _9r_19_c65, _9r_20_c65, _9r_21_c65, _9r_22_c66, _9r_23_c66, _9r_24_c66, _9r_25_c66, _9r_26_c66, _9r_27_c68, _9r_28_c68, _9r_29_c68, _9r_30_c68, _9r_31_c68, _9r_32_c68, _9r_33_c68));

_9q := if((integer)dobpop = 1, glrc9q * sum(_9q_0_c33_b1, _9q_1_c42, _9q_2_c42, _9q_3_c48, _9q_4_c48, _9q_5_c48, _9q_6_c49, _9q_7_c49, _9q_8_c49, _9q_9_c50, _9q_10_c50, _9q_11_c50), glrc9q * sum(_9q_0_c33_b2, _9q_1_c59, _9q_2_c59, _9q_3_c65, _9q_4_c65, _9q_5_c65, _9q_6_c66, _9q_7_c66, _9q_8_c66, _9q_9_c68, _9q_10_c68, _9q_11_c68));

_9l := if((integer)dobpop = 1, glrc9l * sum(_9l_0_c33_b1, _9l_1_c48, _9l_2_c49), glrc9l * sum(_9l_0_c33_b2, _9l_1_c65, _9l_2_c66));

_9g := if((integer)dobpop = 1, glrc9g * sum(_9g_0_c33_b1, _9g_1_c42, _9g_2_c48, _9g_3_c48, _9g_4_c48, _9g_5_c48, _9g_6_c48, _9g_7_c49, _9g_8_c50), glrc9g * sum(_9g_0_c33_b2, _9g_1_c65, _9g_2_c65, _9g_3_c65, _9g_4_c65, _9g_5_c66, _9g_6_c68));

_9s := if((integer)dobpop = 1, glrc9s * sum(_9s_0_c33_b1, _9s_1_c49), glrc9s * sum(_9s_0_c33_b2, _9s_1_c66));

_x11 := if((integer)dobpop = 1, glrcx11 * sum(_x11_0_c33_b1, _x11_1_c42, _x11_2_c42, _x11_3_c42, _x11_4_c48, _x11_5_c48, _x11_6_c48, _x11_7_c48, _x11_8_c49, _x11_9_c49, _x11_10_c49, _x11_11_c50, _x11_12_c50, _x11_13_c50, _x11_14_c50, _x11_15_c50), glrcx11 * sum(_x11_0_c33_b2, _x11_1_c59, _x11_2_c59, _x11_3_c59, _x11_4_c65, _x11_5_c65, _x11_6_c65, _x11_7_c65, _x11_8_c66, _x11_9_c66, _x11_10_c66, _x11_11_c68, _x11_12_c68, _x11_13_c68, _x11_14_c68, _x11_15_c68));

_52 := if((integer)dobpop = 1, glrc52 * sum(_52_0_c33_b1, _52_1_c49), glrc52 * sum(_52_0_c33_b2, _52_1_c66));

_98 := if((integer)dobpop = 1, glrc98 * sum(_98_0_c42, _98_1_c42, _98_2_c42), glrc98 * sum(_98_0_c59, _98_1_c59, _98_2_c59));

_27 := if((integer)dobpop = 1, glrc27 * sum(_27_0_c33_b1, _27_1_c42, _27_2_c49, _27_3_c50), glrc27 * sum(_27_0_c33_b2, _27_1_c59, _27_2_c66, _27_3_c68));

_ms := if((integer)dobpop = 1, glrcms * sum(_ms_0_c33_b1, _ms_1_c48, _ms_2_c49, _ms_3_c50), glrcms * sum(_ms_0_c33_b2, _ms_1_c65, _ms_2_c66, _ms_3_c68));

_9k := if((integer)dobpop = 1, glrc9k * sum(_9k_0_c33_b1), glrc9k * sum(_9k_0_c66));

_9a := if((integer)dobpop = 1, glrc9a * sum(_9a_0_c33_b1, _9a_1_c42, _9a_2_c42, _9a_3_c49, _9a_4_c49, _9a_5_c49, _9a_6_c49, _9a_7_c50), glrc9a * sum(_9a_0_c33_b2, _9a_1_c59, _9a_2_c59, _9a_3_c66, _9a_4_c66, _9a_5_c66, _9a_6_c66, _9a_7_c68));

_25 := if((integer)dobpop = 1, glrc25 * sum(_25_0_c33_b1, _25_1_c42, _25_2_c50), glrc25 * sum(_25_0_c33_b2, _25_1_c59, _25_2_c68));

_49 := if((integer)dobpop = 1, glrc49 * sum(_49_0_c33_b1), glrc49 * sum(_49_0_c33_b2));

_9d := if((integer)dobpop = 1, glrc9d * sum(_9d_0_c33_b1, _9d_1_c42, _9d_2_c42, _9d_3_c42, _9d_4_c42, _9d_5_c42, _9d_6_c48, _9d_7_c48, _9d_8_c48, _9d_9_c48, _9d_10_c49, _9d_11_c49, _9d_12_c49, _9d_13_c50, _9d_14_c50, _9d_15_c50), glrc9d * sum(_9d_0_c33_b2, _9d_1_c59, _9d_2_c59, _9d_3_c59, _9d_4_c59, _9d_5_c59, _9d_6_c65, _9d_7_c65, _9d_8_c65, _9d_9_c65, _9d_10_c66, _9d_11_c66, _9d_12_c66, _9d_13_c68, _9d_14_c68, _9d_15_c68));

ds_layout := {STRING rc, Real4 value};
rc_dataset := DATASET([
	{'9H', _9h},
	{'9C', _9c},
	{'26', _26},
	{'MI', _mi},
	{'9U', _9u},
	{'9J', _9j},
	{'9O', _9o},
	{'9T', _9t},
	{'9E', _9e},
	{'28', _28},
	{'9W', _9w},
	{'9M', _9m},
	{'EV', _ev},
	{'38', _38},
	{'PV', _pv},
	{'97', _97},
	{'9R', _9r},
	{'9Q', _9q},
	{'9L', _9l},
	{'9G', _9g},
	{'9S', _9s},
	{'X11', _x11},
	{'52', _52},
	{'98', _98},
	{'27', _27},
	{'MS', _ms},
	{'9K', _9k},
	{'9A', _9a},
	{'25', _25},
	{'49', _49},
	{'9D', _9d}
	], ds_layout)(value > 0);

rcs_top4 := choosen(sort(rc_dataset, -value, rc), 4);


		rcs_override1 := if( /*rvr1103 > 222 and*/ pk_segment_40 = '3 Other' and 0 = count(rcs_top4),
			dataset( [{'9A', RC_NULL}], ds_layout ),
			rcs_top4
		);

		rcs_override2 := rcs_override1 &
			if( 0 = count( rcs_override1(rc='9Q') )
				and GLRC9Q = 1
				and
				(
					pk_inq_peradl_0m > 0.1352414584                 and pk_Segment_40 = '0 Derog'
					or pk_inq_count06_S1_1m > 0.1372722579          and pk_Segment_40 = '1 Young'
					or pk_inq_banking_count06_S2_2m > 0.034514581   and pk_Segment_40 = '2 Owner'
					or pk_inq_banking_count06_S3_3m > 0.0611931742  and pk_Segment_40 = '3 Other'
				), dataset( [{'9Q', _9Q}], ds_layout )
			);

		rcs_override3 := if( 0 = count(rcs_override2),
			dataset( [{'36', RC_NULL}], ds_layout ),
			rcs_override2
		);


		rcs_final := map(
			rvr1103 = 200 => dataset( [{'02', NULL}], ds_layout ),
			rvr1103 = 222 => dataset( [{'9X', NULL}], ds_layout ),
			rcs_override3
		);
		
		
		#if(RVR_DEBUG)
			self.truedid := truedid;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_addrcommflag := rc_addrcommflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_hrisksicphone := rc_hrisksicphone;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_hphonescore := combo_hphonescore;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_hphonecount := combo_hphonecount;
			self.ver_sources := ver_sources;
			self.ver_sources_nas := ver_sources_nas;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_sources_last_seen := ver_sources_last_seen;
			self.ver_addr_sources := ver_addr_sources;
			self.ver_dob_sources := ver_dob_sources;
			self.ssnlength := ssnlength;
			self.dobpop := dobpop;
			self.fname_eda_sourced_type := fname_eda_sourced_type;
			self.lname_eda_sourced_type := lname_eda_sourced_type;
			self.add1_house_number_match := add1_house_number_match;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_advo_throw_back := add1_advo_throw_back;
			self.add1_advo_seasonal_delivery := add1_advo_seasonal_delivery;
			self.add1_advo_college := add1_advo_college;
			self.add1_advo_drop := add1_advo_drop;
			self.add1_advo_res_or_business := add1_advo_res_or_business;
			self.add1_advo_mixed_address_usage := add1_advo_mixed_address_usage;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_eda_sourced := add1_eda_sourced;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_date := add1_purchase_date;
			self.add1_built_date := add1_built_date;
			self.add1_financing_type := add1_financing_type;
			self.add1_date_first_seen := add1_date_first_seen;
			self.property_owned_total := property_owned_total;
			self.property_owned_purchase_count := property_owned_purchase_count;
			self.property_owned_assessed_count := property_owned_assessed_count;
			self.property_sold_total := property_sold_total;
			self.property_sold_purchase_count := property_sold_purchase_count;
			self.property_sold_assessed_count := property_sold_assessed_count;
			self.property_ambig_total := property_ambig_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.add2_naprop := add2_naprop;
			self.add3_naprop := add3_naprop;
			self.addrs_5yr := addrs_5yr;
			self.unique_addr_count := unique_addr_count;
			self.avg_mo_per_addr := avg_mo_per_addr;
			self.addr_count_ge3 := addr_count_ge3;
			self.addr_hist_advo_college := addr_hist_advo_college;
			self.telcordia_type := telcordia_type;
			self.gong_did_first_seen := gong_did_first_seen;
			self.nameperssn_count := nameperssn_count;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.lnames_per_adl_c6 := lnames_per_adl_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.invalid_phones_per_adl_c6 := invalid_phones_per_adl_c6;
			self.invalid_addrs_per_adl_c6 := invalid_addrs_per_adl_c6;
			self.inq_count := inq_count;
			self.inq_count06 := inq_count06;
			self.inq_banking_count06 := inq_banking_count06;
			self.inq_peradl := inq_peradl;
			self.inq_adlsperaddr := inq_adlsperaddr;
			self.inq_ssnsperaddr := inq_ssnsperaddr;
			self.inq_perphone := inq_perphone;
			self.inq_adlsperphone := inq_adlsperphone;
			self.paw_company_title := paw_company_title;
			self.infutor_first_seen := infutor_first_seen;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_source_list := email_source_list;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_date_first_purchase := attr_date_first_purchase;
			self.attr_num_sold60 := attr_num_sold60;
			self.attr_num_aircraft := attr_num_aircraft;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs180 := attr_num_nonderogs180;
			self.bankrupt := bankrupt;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_last_unrel_date := liens_last_unrel_date;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_rel_cj_ct := liens_rel_cj_ct;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_lt_last_seen := liens_unrel_lt_last_seen;
			self.liens_rel_lt_ct := liens_rel_lt_ct;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.liens_unrel_sc_last_seen := liens_unrel_sc_last_seen;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_last_date := felony_last_date;
			self.watercraft_count := watercraft_count;
			self.ams_age := ams_age;
			self.ams_college_code := ams_college_code;
			self.ams_college_type := ams_college_type;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.estimated_income := estimated_income;
			self.archive_date := archive_date;
                    self.sysdate                          := sysdate;
                    self.in_dob2                          := in_dob2;
                    self.yr_in_dob                        := yr_in_dob;
                    self.rc_ssnlowissue2                  := rc_ssnlowissue2;
                    self.add1_purchase_date2              := add1_purchase_date2;
                    self.mth_add1_purchase_date           := mth_add1_purchase_date;
                    self.add1_built_date2                 := add1_built_date2;
                    self.mth_add1_built_date              := mth_add1_built_date;
                    self.add1_date_first_seen2            := add1_date_first_seen2;
                    self.mth_add1_date_first_seen         := mth_add1_date_first_seen;
                    self.gong_did_first_seen2             := gong_did_first_seen2;
                    self.mth_gong_did_first_seen          := mth_gong_did_first_seen;
                    self.header_first_seen2               := header_first_seen2;
                    self.mth_header_first_seen            := mth_header_first_seen;
                    self.infutor_first_seen2              := infutor_first_seen2;
                    self.mth_infutor_first_seen           := mth_infutor_first_seen;
                    self.attr_date_first_purchase2        := attr_date_first_purchase2;
                    self.mth_attr_date_first_purchase     := mth_attr_date_first_purchase;
                    self.attr_date_last_eviction2         := attr_date_last_eviction2;
                    self.yr_attr_date_last_eviction       := yr_attr_date_last_eviction;
                    self.liens_last_unrel_date2           := liens_last_unrel_date2;
                    self.yr_liens_last_unrel_date         := yr_liens_last_unrel_date;
                    self.liens_unrel_cj_last_seen2        := liens_unrel_cj_last_seen2;
                    self.yr_liens_unrel_cj_last_seen      := yr_liens_unrel_cj_last_seen;
                    self.liens_unrel_lt_last_seen2        := liens_unrel_lt_last_seen2;
                    self.yr_liens_unrel_lt_last_seen      := yr_liens_unrel_lt_last_seen;
                    self.liens_unrel_sc_last_seen2        := liens_unrel_sc_last_seen2;
                    self.yr_liens_unrel_sc_last_seen      := yr_liens_unrel_sc_last_seen;
                    self.criminal_last_date2              := criminal_last_date2;
                    self.yr_criminal_last_date            := yr_criminal_last_date;
                    self.felony_last_date2                := felony_last_date2;
                    self.yr_felony_last_date              := yr_felony_last_date;
                    self.ver_src_cnt                      := ver_src_cnt;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self.ver_src_ba_pos                   := ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self.ver_src_ds_pos                   := ver_src_ds_pos;
                    self.ver_src_ds                       := ver_src_ds;
                    self.ver_src_eb_pos                   := ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_fdate_eq2                := ver_src_fdate_eq2;
                    self.mth_ver_src_fdate_eq             := mth_ver_src_fdate_eq;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_fdate_en2                := ver_src_fdate_en2;
                    self.mth_ver_src_fdate_en             := mth_ver_src_fdate_en;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_nas_p                    := ver_src_nas_p;
                    self.ver_src_li_pos                   := ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self.ver_src_ldate_li                 := ver_src_ldate_li;
                    self.ver_src_ldate_li2                := ver_src_ldate_li2;
                    self.mth_ver_src_ldate_li             := mth_ver_src_ldate_li;
                    self.ver_src_l2_pos                   := ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self.ver_src_ldate_l2                 := ver_src_ldate_l2;
                    self.ver_src_ldate_l22                := ver_src_ldate_l22;
                    self.mth_ver_src_ldate_l2             := mth_ver_src_ldate_l2;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self.ver_src_fdate_ts2                := ver_src_fdate_ts2;
                    self.mth_ver_src_fdate_ts             := mth_ver_src_fdate_ts;
                    self.ver_src_w_pos                    := ver_src_w_pos;
                    self.ver_src_w                        := ver_src_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self.ver_src_fdate_wp                 := ver_src_fdate_wp;
                    self.ver_src_fdate_wp2                := ver_src_fdate_wp2;
                    self.mth_ver_src_fdate_wp             := mth_ver_src_fdate_wp;
                    self.ver_addr_src_ak_pos              := ver_addr_src_ak_pos;
                    self.ver_addr_src_ak                  := ver_addr_src_ak;
                    self.ver_addr_src_am_pos              := ver_addr_src_am_pos;
                    self.ver_addr_src_am                  := ver_addr_src_am;
                    self.ver_addr_src_ar_pos              := ver_addr_src_ar_pos;
                    self.ver_addr_src_ar                  := ver_addr_src_ar;
                    self.ver_addr_src_cg_pos              := ver_addr_src_cg_pos;
                    self.ver_addr_src_cg                  := ver_addr_src_cg;
                    self.ver_addr_src_eb_pos              := ver_addr_src_eb_pos;
                    self.ver_addr_src_eb                  := ver_addr_src_eb;
                    self.ver_addr_src_eq_pos              := ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := ver_addr_src_eq;
                    self.ver_addr_src_en_pos              := ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := ver_addr_src_en;
                    self.ver_addr_src_em_pos              := ver_addr_src_em_pos;
                    self.ver_addr_src_em                  := ver_addr_src_em;
                    self.ver_addr_src_e1_pos              := ver_addr_src_e1_pos;
                    self.ver_addr_src_e1                  := ver_addr_src_e1;
                    self.ver_addr_src_e2_pos              := ver_addr_src_e2_pos;
                    self.ver_addr_src_e2                  := ver_addr_src_e2;
                    self.ver_addr_src_e3_pos              := ver_addr_src_e3_pos;
                    self.ver_addr_src_e3                  := ver_addr_src_e3;
                    self.ver_addr_src_e4_pos              := ver_addr_src_e4_pos;
                    self.ver_addr_src_e4                  := ver_addr_src_e4;
                    self.ver_addr_src_pl_pos              := ver_addr_src_pl_pos;
                    self.ver_addr_src_pl                  := ver_addr_src_pl;
                    self.ver_addr_src_vo_pos              := ver_addr_src_vo_pos;
                    self.ver_addr_src_vo                  := ver_addr_src_vo;
                    self.ver_addr_src_w_pos               := ver_addr_src_w_pos;
                    self.ver_addr_src_w                   := ver_addr_src_w;
                    self.ver_addr_src_wp_pos              := ver_addr_src_wp_pos;
                    self.ver_addr_src_wp                  := ver_addr_src_wp;
                    self.ver_dob_src_ak_pos               := ver_dob_src_ak_pos;
                    self.ver_dob_src_ak                   := ver_dob_src_ak;
                    self.ver_dob_src_am_pos               := ver_dob_src_am_pos;
                    self.ver_dob_src_am                   := ver_dob_src_am;
                    self.ver_dob_src_ar_pos               := ver_dob_src_ar_pos;
                    self.ver_dob_src_ar                   := ver_dob_src_ar;
                    self.ver_dob_src_cg_pos               := ver_dob_src_cg_pos;
                    self.ver_dob_src_cg                   := ver_dob_src_cg;
                    self.ver_dob_src_eb_pos               := ver_dob_src_eb_pos;
                    self.ver_dob_src_eb                   := ver_dob_src_eb;
                    self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := ver_dob_src_eq;
                    self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := ver_dob_src_en;
                    self.ver_dob_src_em_pos               := ver_dob_src_em_pos;
                    self.ver_dob_src_em                   := ver_dob_src_em;
                    self.ver_dob_src_e1_pos               := ver_dob_src_e1_pos;
                    self.ver_dob_src_e1                   := ver_dob_src_e1;
                    self.ver_dob_src_e2_pos               := ver_dob_src_e2_pos;
                    self.ver_dob_src_e2                   := ver_dob_src_e2;
                    self.ver_dob_src_e3_pos               := ver_dob_src_e3_pos;
                    self.ver_dob_src_e3                   := ver_dob_src_e3;
                    self.ver_dob_src_e4_pos               := ver_dob_src_e4_pos;
                    self.ver_dob_src_e4                   := ver_dob_src_e4;
                    self.ver_dob_src_pl_pos               := ver_dob_src_pl_pos;
                    self.ver_dob_src_pl                   := ver_dob_src_pl;
                    self.ver_dob_src_vo_pos               := ver_dob_src_vo_pos;
                    self.ver_dob_src_vo                   := ver_dob_src_vo;
                    self.ver_dob_src_w_pos                := ver_dob_src_w_pos;
                    self.ver_dob_src_w                    := ver_dob_src_w;
                    self.ver_dob_src_wp_pos               := ver_dob_src_wp_pos;
                    self.ver_dob_src_wp                   := ver_dob_src_wp;
                    self.email_src_cnt                    := email_src_cnt;
                    self.add_apt                          := add_apt;
			// self.phn_highrisk2                    := phn_highrisk2;
			// self.phn_notpots                      := phn_notpots;
			// self.phn_correction                   := phn_correction;
                    self.ssn_issued18                     := ssn_issued18;
                    self.ssn_deceased                     := ssn_deceased;
                    self.ssn_lowissue_age                 := ssn_lowissue_age;
                    self.prop_owner                       := prop_owner;
                    self.add_naprop_level                 := add_naprop_level;
                    self.add1_ownership                   := add1_ownership;
                    self.bk_flag                          := bk_flag;
                    self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
                    self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
                    self.lien_flag                        := lien_flag;
                    self.pk_property_owner                := pk_property_owner;
                    self.pk_impulse_count                 := pk_impulse_count;
                    self.pk_yr_in_dob                     := pk_yr_in_dob;
                    self.pk_age_estimate                  := pk_age_estimate;
                    self.bs_attr_derog_flag               := bs_attr_derog_flag;
                    self.bs_attr_eviction_flag            := bs_attr_eviction_flag;
                    self.bs_attr_derog_flag2              := bs_attr_derog_flag2;
			self.scored_222s                      := scored_222s;
                    self.pk_222_flag                      := pk_222_flag;
                    self.pk_segment_40                    := pk_segment_40;
                    self.pk_age_estimate_s1               := pk_age_estimate_s1;
                    self.pk_age_estimate_s2               := pk_age_estimate_s2;
                    self.pk_age_estimate_s3               := pk_age_estimate_s3;
			// self.pk_estimated_income_s0           := pk_estimated_income_s0;
                    self.pk_estimated_income_s1           := pk_estimated_income_s1;
                    self.pk_estimated_income_s2           := pk_estimated_income_s2;
			// self.pk_estimated_income_s3           := pk_estimated_income_s3;
                    self.pk_add1_avm_auto_val_s1          := pk_add1_avm_auto_val_s1;
                    self.pk_add1_avm_auto_val_s2          := pk_add1_avm_auto_val_s2;
                    self.pk_add1_avm_auto_val_s3          := pk_add1_avm_auto_val_s3;
                    self.pk_combo_hphonescore             := pk_combo_hphonescore;
                    self.pk_combo_ssnscore                := pk_combo_ssnscore;
                    self.pk_combo_dobscore                := pk_combo_dobscore;
                    self.pk_hphn_score_ver                := pk_hphn_score_ver;
                    self.pk_ssn_score_ver                 := pk_ssn_score_ver;
                    self.pk_dob_score_ver                 := pk_dob_score_ver;
                    self.nas_summary_ver                  := nas_summary_ver;
                    self.pk_nap_summary_ver               := pk_nap_summary_ver;
                    self.pk_rc_fnamessnmatch              := pk_rc_fnamessnmatch;
                    self.pk_add1_house_number_match       := pk_add1_house_number_match;
                    self.eda_sourced_level                := eda_sourced_level;
                    self.pk_infutor_nap                   := pk_infutor_nap;
                    self.pk_input_dob_match_level         := pk_input_dob_match_level;
                    self.pk_ams_age                       := pk_ams_age;
                    self.pk_ams_4yr_college               := pk_ams_4yr_college;
                    self.pk_ams_college_type              := pk_ams_college_type;
                    self.pk_ams_income_level_code         := pk_ams_income_level_code;
                    self.pk_ams_college_tier              := pk_ams_college_tier;
                    self.pk_combo_hphonecount             := pk_combo_hphonecount;
                    self.pk_attr_num_nonderogs            := pk_attr_num_nonderogs;
                    self.pk_attr_num_nonderogs180         := pk_attr_num_nonderogs180;
                    self.pk_email_count                   := pk_email_count;
                    self.pk_email_domain_free_count       := pk_email_domain_free_count;
                    self.pk_email_src_cnt                 := pk_email_src_cnt;
                    self.pk_paw_company_title             := pk_paw_company_title;
                    self.pk_prof_license_category         := pk_prof_license_category;
                    self.pk_pos_addr_src_minor            := pk_pos_addr_src_minor;
                    self.pk_pos_addr_src_minor_flag       := pk_pos_addr_src_minor_flag;
                    self.pk_pos_dob_src_minor             := pk_pos_dob_src_minor;
                    self.pk_pos_dob_src_minor_flag        := pk_pos_dob_src_minor_flag;
                    self.ver_src_bureau                   := ver_src_bureau;
                    self.ver_addr_src_bureau              := ver_addr_src_bureau;
                    self.ver_dob_src_bureau               := ver_dob_src_bureau;
                    self.ver_addr_src_emerge              := ver_addr_src_emerge;
                    self.ver_dob_src_emerge               := ver_dob_src_emerge;
                    self.pk_pos_addr_src_major            := pk_pos_addr_src_major;
                    self.pk_pos_dob_src_major             := pk_pos_dob_src_major;
                    self.pk_pos_addr_src_cnt              := pk_pos_addr_src_cnt;
                    self.pk_pos_dob_src_cnt               := pk_pos_dob_src_cnt;
                    self.pk_bureau_only                   := pk_bureau_only;
                    self.pk_mth_gong_did_first_seen       := pk_mth_gong_did_first_seen;
                    self.pk_mth_gong_did_first_seen2      := pk_mth_gong_did_first_seen2;
                    self.pk_mth_header_first_seen         := pk_mth_header_first_seen;
                    self.pk_mth_header_first_seen2_s0     := pk_mth_header_first_seen2_s0;
                    self.pk_mth_header_first_seen2_s2     := pk_mth_header_first_seen2_s2;
                    self.pk_mth_header_first_seen2_s3     := pk_mth_header_first_seen2_s3;
                    self.pk_mth_infutor_first_seen        := pk_mth_infutor_first_seen;
                    self.pk_mth_infutor_first_seen2       := pk_mth_infutor_first_seen2;
                    self.pk_mth_ver_src_fdate_en          := pk_mth_ver_src_fdate_en;
                    self.pk_mth_ver_src_fdate_eq          := pk_mth_ver_src_fdate_eq;
                    self.pk_mth_ver_src_fdate_ts          := pk_mth_ver_src_fdate_ts;
                    self.pk_mth_ver_src_fdate_wp          := pk_mth_ver_src_fdate_wp;
                    self.pk_mth_ver_src_fdate_bureau      := pk_mth_ver_src_fdate_bureau;
                    self.pk_mth_ver_src_fdate_ts2         := pk_mth_ver_src_fdate_ts2;
                    self.pk_mth_ver_src_fdate_wp2_s3      := pk_mth_ver_src_fdate_wp2_s3;
                    self.time_on_cb_gt_age                := time_on_cb_gt_age;
                    self.pk_time_on_bureau_120            := pk_time_on_bureau_120;
                    self.pk_time_on_cb_120b_s0            := pk_time_on_cb_120b_s0;
                    self.pk_time_on_cb_120b_s1            := pk_time_on_cb_120b_s1;
                    self.pk_time_on_cb_120b_s2            := pk_time_on_cb_120b_s2;
                    self.pk_time_on_cb_120b_s3            := pk_time_on_cb_120b_s3;
                    self.pk_addr_hist_advo_college        := pk_addr_hist_advo_college;
                    self.pk_mth_add1_purchase_date        := pk_mth_add1_purchase_date;
                    self.pk_mth_add1_built_date           := pk_mth_add1_built_date;
                    self.pk_mth_add1_date_first_seen      := pk_mth_add1_date_first_seen;
                    self.pk_mth_attr_date_first_purchase  := pk_mth_attr_date_first_purchase;
                    self.pk_adj_finance                   := pk_adj_finance;
                    self.pk_prop_owned_purch_flag         := pk_prop_owned_purch_flag;
                    self.pk_prop_owned_assess_flag        := pk_prop_owned_assess_flag;
                    self.pk_prop_sold_purch_flag          := pk_prop_sold_purch_flag;
                    self.pk_prop_sold_assess_flag         := pk_prop_sold_assess_flag;
                    self.pk_prop_owned_sold_lvl           := pk_prop_owned_sold_lvl;
                    self.pk_ver_src_nas_p_lvl             := pk_ver_src_nas_p_lvl;
                    self.pk_boat_plane_flag               := pk_boat_plane_flag;
                    self.pk_property_owned_total          := pk_property_owned_total;
                    self.pk_property_sold_total           := pk_property_sold_total;
                    self.pk_prop_os_tot_tree              := pk_prop_os_tot_tree;
                    self.pk_attr_num_sold60               := pk_attr_num_sold60;
                    self.pk_addrs_5yr_s0                  := pk_addrs_5yr_s0;
                    self.pk_unique_addr_count_s0          := pk_unique_addr_count_s0;
                    self.pk_avg_mo_per_addr_s0            := pk_avg_mo_per_addr_s0;
                    self.pk_addr_count_ge3_s0             := pk_addr_count_ge3_s0;
                    self.pk_mth_add1_dt_f_sn_s0           := pk_mth_add1_dt_f_sn_s0;
                    self.pk_ver_src_nas_p_lvl_s0          := pk_ver_src_nas_p_lvl_s0;
                    self.pk_prop_os_tot_tree_s0           := pk_prop_os_tot_tree_s0;
                    self.pk_unique_addr_count_s1          := pk_unique_addr_count_s1;
                    self.pk_avg_mo_per_addr_s1            := pk_avg_mo_per_addr_s1;
                    self.pk_addr_count_ge3_s1             := pk_addr_count_ge3_s1;
                    self.pk_add_naprop_level_s1           := pk_add_naprop_level_s1;
                    self.pk_mth_add1_built_date_s1        := pk_mth_add1_built_date_s1;
                    self.pk_mth_add1_dt_f_sn_s1           := pk_mth_add1_dt_f_sn_s1;
                    self.pk_addrs_5yr_s2                  := pk_addrs_5yr_s2;
                    self.pk_avg_mo_per_addr_s2            := pk_avg_mo_per_addr_s2;
                    self.pk_add1_ownership_s2             := pk_add1_ownership_s2;
                    self.pk_mth_add1_purchase_date_s2     := pk_mth_add1_purchase_date_s2;
                    self.pk_mth_attr_dt_first_prch_s2     := pk_mth_attr_dt_first_prch_s2;
                    self.pk_prop_owned_sold_lvl_s2        := pk_prop_owned_sold_lvl_s2;
                    self.pk_ver_src_nas_p_lvl_s2          := pk_ver_src_nas_p_lvl_s2;
                    self.pk_avg_mo_per_addr_s3            := pk_avg_mo_per_addr_s3;
                    self.pk_addr_count_ge3_s3             := pk_addr_count_ge3_s3;
                    self.pk_mth_add1_dt_f_sn_s3           := pk_mth_add1_dt_f_sn_s3;
                    self.pk_ver_src_nas_p_lvl_s3          := pk_ver_src_nas_p_lvl_s3;
                    self.pk_yr_criminal_last_date         := pk_yr_criminal_last_date;
                    self.pk_yr_felony_last_date           := pk_yr_felony_last_date;
                    self.pk_yr_attr_date_last_eviction    := pk_yr_attr_date_last_eviction;
                    self.pk_yr_liens_last_unrel_date      := pk_yr_liens_last_unrel_date;
                    self.pk_yr_liens_unrel_cj_last_seen   := pk_yr_liens_unrel_cj_last_seen;
                    self.pk_yr_liens_unrel_lt_last_seen   := pk_yr_liens_unrel_lt_last_seen;
                    self.pk_yr_liens_unrel_sc_last_seen   := pk_yr_liens_unrel_sc_last_seen;
                    self.pk_mth_ver_src_ldate_l2          := pk_mth_ver_src_ldate_l2;
                    self.pk_mth_ver_src_ldate_li          := pk_mth_ver_src_ldate_li;
                    self.pk_yr_criminal_last_date2        := pk_yr_criminal_last_date2;
                    self.pk_yr_felony_last_date2          := pk_yr_felony_last_date2;
                    self.pk_crim_fel_date                 := pk_crim_fel_date;
                    self.pk_yr_attr_dt_last_evict2        := pk_yr_attr_dt_last_evict2;
                    self.pk_liens_unrel_cj_ct             := pk_liens_unrel_cj_ct;
                    self.pk_liens_rel_cj_ct               := pk_liens_rel_cj_ct;
                    self.pk_liens_unrel_lt_ct             := pk_liens_unrel_lt_ct;
                    self.pk_liens_rel_lt_ct               := pk_liens_rel_lt_ct;
                    self.pk_liens_unrel_sc_ct             := pk_liens_unrel_sc_ct;
                    self.pk_lien_tree                     := pk_lien_tree;
                    self.pk_unrel_last_sn_dt              := pk_unrel_last_sn_dt;
                    self.pk_ver_src_ldate_lien            := pk_ver_src_ldate_lien;
                    self.pk_ver_src_ldate_lien2           := pk_ver_src_ldate_lien2;
                    self.pk_unrel_last_sn_dt2             := pk_unrel_last_sn_dt2;
                    self.inq_hit                          := inq_hit;
                    self.pk_inq_banking_count06_s2        := pk_inq_banking_count06_s2;
                    self.pk_inq_banking_count06_s3        := pk_inq_banking_count06_s3;
                    self.pk_inq_count06_s1                := pk_inq_count06_s1;
                    self.pk_inq_peradl                    := pk_inq_peradl;
                    self.pk_inq_adlsperaddr_s2            := pk_inq_adlsperaddr_s2;
                    self.pk_inq_ssnsperaddr               := pk_inq_ssnsperaddr;
                    self.pk_inq_perphone_s1               := pk_inq_perphone_s1;
                    self.pk_inq_perphone_s2               := pk_inq_perphone_s2;
                    self.pk_inq_adlsperphone_s3           := pk_inq_adlsperphone_s3;
			// self.pk_dist_a1toa2                   := pk_dist_a1toa2;
			// self.pk_dist_a1toa3_s1                := pk_dist_a1toa3_s1;
                    self.pk_per_adl_tree2                 := pk_per_adl_tree2;
                    self.pk_addrs_per_ssn_c6              := pk_addrs_per_ssn_c6;
                    self.pk_adls_per_addr_c6_s0           := pk_adls_per_addr_c6_s0;
                    self.pk_adls_per_addr_c6_s1           := pk_adls_per_addr_c6_s1;
                    self.pk_ssns_per_addr_c6_s2           := pk_ssns_per_addr_c6_s2;
                    self.pk_ssns_per_addr_c6_s3           := pk_ssns_per_addr_c6_s3;
                    self.pk_phones_per_addr_c6_s0         := pk_phones_per_addr_c6_s0;
                    self.pk_phones_per_addr_c6_s1         := pk_phones_per_addr_c6_s1;
                    self.pk_phones_per_addr_c6_s3         := pk_phones_per_addr_c6_s3;
                    self.pk_attr_addrs_last12             := pk_attr_addrs_last12;
                    self.pk_addr_adl_tree                 := pk_addr_adl_tree;
                    self.pk_ssns_per_adl_s1               := pk_ssns_per_adl_s1;
                    self.pk_ssns_per_adl_s2               := pk_ssns_per_adl_s2;
                    self.pk_ssns_per_adl_s3               := pk_ssns_per_adl_s3;
                    self.pk_addrs_per_adl_s0              := pk_addrs_per_adl_s0;
                    self.pk_phones_per_adl_s3             := pk_phones_per_adl_s3;
                    self.pk_nameperssn_count              := pk_nameperssn_count;
                    self.pk_adlperssn_count_s1            := pk_adlperssn_count_s1;
                    self.pk_adlperssn_count_s3            := pk_adlperssn_count_s3;
                    self.pk_addrs_per_ssn_s1              := pk_addrs_per_ssn_s1;
                    self.pk_addrs_per_ssn_s2              := pk_addrs_per_ssn_s2;
                    self.pk_addrs_per_ssn_s3              := pk_addrs_per_ssn_s3;
                    self.pk_ssns_per_addr_s1              := pk_ssns_per_addr_s1;
                    self.pk_ssns_per_addr_s2              := pk_ssns_per_addr_s2;
                    self.pk_ssns_per_addr_s3              := pk_ssns_per_addr_s3;
                    self.pk_phones_per_addr_s3            := pk_phones_per_addr_s3;
                    self.pk_adls_per_phone_s1             := pk_adls_per_phone_s1;
                    self.pk_adls_per_phone_s2             := pk_adls_per_phone_s2;
                    self.pk_adls_per_phone_s3             := pk_adls_per_phone_s3;
			// self.pk_add_inval                     := pk_add_inval;
			// self.pk_add_hirisk_comm               := pk_add_hirisk_comm;
			// self.pk_advo_no_hit                   := pk_advo_no_hit;
			// self.pk_add1_advo_address_vacancy     := pk_add1_advo_address_vacancy;
			// self.pk_add1_advo_throw_back          := pk_add1_advo_throw_back;
			// self.pk_add1_advo_seasonal_delivery   := pk_add1_advo_seasonal_delivery;
			// self.pk_add1_advo_college             := pk_add1_advo_college;
			// self.pk_add1_advo_drop                := pk_add1_advo_drop;
			// self.pk_add1_advo_res_or_business     := pk_add1_advo_res_or_business;
			// self.pk_add1_advo_mixed_address_usage := pk_add1_advo_mixed_address_usage;
			// self.pk_invalid_addrs_per_adl_c6      := pk_invalid_addrs_per_adl_c6;
			// self.pk_addprob_s2                    := pk_addprob_s2;
			// self.pk_rc_disthphoneaddr_s0          := pk_rc_disthphoneaddr_s0;
			// self.pk_phn_cell                      := pk_phn_cell;
			// self.pk_phn_pager                     := pk_phn_pager;
			// self.pk_phn_pcs                       := pk_phn_pcs;
			// self.pk_phn_disconnect                := pk_phn_disconnect;
			// self.pk_phn_cell2                     := pk_phn_cell2;
			// self.pk_phn_pager2                    := pk_phn_pager2;
			// self.pk_phn_pcs2                      := pk_phn_pcs2;
			// self.pk_phn_payphone                  := pk_phn_payphone;
			// self.pk_phn_fax                       := pk_phn_fax;
			// self.pk_phn_invalid                   := pk_phn_invalid;
			// self.pk_phn_usage_unknown             := pk_phn_usage_unknown;
			// self.pk_phn_invalid2                  := pk_phn_invalid2;
			// self.pk_phn_notpots                   := pk_phn_notpots;
			// self.pk_phn_usage_unknown2            := pk_phn_usage_unknown2;
			// self.pk_phn_phnzipmismatch            := pk_phn_phnzipmismatch;
			// self.pk_phn_phnzipmismatch2           := pk_phn_phnzipmismatch2;
			// self.pk_phn_phn_not_issued            := pk_phn_phn_not_issued;
			// self.pk_phn_nonus                     := pk_phn_nonus;
			// self.pk_phn_pager3                    := pk_phn_pager3;
			// self.pk_phn_cell3                     := pk_phn_cell3;
			// self.pk_phn_cell4                     := pk_phn_cell4;
			// self.pk_phn_pager4                    := pk_phn_pager4;
			// self.pk_phn_mobile                    := pk_phn_mobile;
			// self.pk_phn_cpm                       := pk_phn_cpm;
			// self.pk_phn_cell5                     := pk_phn_cell5;
			// self.pk_phn_pager5                    := pk_phn_pager5;
			// self.pk_phn_mobile2                   := pk_phn_mobile2;
			// self.pk_phn_cpm2                      := pk_phn_cpm2;
			// self.pk_phn_pcs3                      := pk_phn_pcs3;
			// self.pk_phn_pcs4                      := pk_phn_pcs4;
			// self.pk_phn_pcs5                      := pk_phn_pcs5;
			// self.pk_phn_pcs6                      := pk_phn_pcs6;
			// self.pk_phn_pcs7                      := pk_phn_pcs7;
			// self.pk_phn_cpm_flag                  := pk_phn_cpm_flag;
			// self.pk_phn_pcs_flag                  := pk_phn_pcs_flag;
			// self.pk_phn_phnzipmis_flag            := pk_phn_phnzipmis_flag;
			// self.pk_phn_notpots_flag              := pk_phn_notpots_flag;
			// self.pk_phn_invalid_flag              := pk_phn_invalid_flag;
			// self.pk_phnprob_s2                    := pk_phnprob_s2;
			// self.pk_phnprob2_s2                   := pk_phnprob2_s2;
                    self.pk_ssn_lowissue_age              := pk_ssn_lowissue_age;
                    self.pk_ssn_lowissue_age2_s0          := pk_ssn_lowissue_age2_s0;
                    self.pk_ssn_lowissue_age2_s1          := pk_ssn_lowissue_age2_s1;
                    self.pk_dist_a1toa2_b                 := pk_dist_a1toa2_b;
                    self.pk_dist_a1toa2_b_1m              := pk_dist_a1toa2_b_1m;
                    self.pk_dist_a1toa2_b_2m              := pk_dist_a1toa2_b_2m;
                    self.pk_age_estimate_s1_1m            := pk_age_estimate_s1_1m;
                    self.pk_age_estimate_s2_2m            := pk_age_estimate_s2_2m;
                    self.pk_age_estimate_s3_3m            := pk_age_estimate_s3_3m;
                    self.pk_crim_fel_date_0m              := pk_crim_fel_date_0m;
                    self.pk_yr_attr_dt_last_evict2_0m     := pk_yr_attr_dt_last_evict2_0m;
                    self.pk_lien_tree_0m                  := pk_lien_tree_0m;
                    self.pk_unrel_last_sn_dt2_0m          := pk_unrel_last_sn_dt2_0m;
			// self.pk_estimated_income_s0_0m        := pk_estimated_income_s0_0m;
                    self.pk_estimated_income_s1_1m        := pk_estimated_income_s1_1m;
                    self.pk_add1_avm_auto_val_s1_1m       := pk_add1_avm_auto_val_s1_1m;
                    self.pk_estimated_income_s2_2m        := pk_estimated_income_s2_2m;
                    self.pk_add1_avm_auto_val_s2_2m       := pk_add1_avm_auto_val_s2_2m;
			// self.pk_estimated_income_s3_3m        := pk_estimated_income_s3_3m;
                    self.pk_add1_avm_auto_val_s3_3m       := pk_add1_avm_auto_val_s3_3m;
                    self.pk_addrs_5yr_s0_0m               := pk_addrs_5yr_s0_0m;
                    self.pk_unique_addr_count_s0_0m       := pk_unique_addr_count_s0_0m;
                    self.pk_avg_mo_per_addr_s0_0m         := pk_avg_mo_per_addr_s0_0m;
                    self.pk_addr_count_ge3_s0_0m          := pk_addr_count_ge3_s0_0m;
                    self.pk_mth_add1_dt_f_sn_s0_0m        := pk_mth_add1_dt_f_sn_s0_0m;
                    self.pk_ver_src_nas_p_lvl_s0_0m       := pk_ver_src_nas_p_lvl_s0_0m;
                    self.pk_prop_os_tot_tree_s0_0m        := pk_prop_os_tot_tree_s0_0m;
                    self.pk_unique_addr_count_s1_1m       := pk_unique_addr_count_s1_1m;
                    self.pk_avg_mo_per_addr_s1_1m         := pk_avg_mo_per_addr_s1_1m;
                    self.pk_addr_count_ge3_s1_1m          := pk_addr_count_ge3_s1_1m;
                    self.pk_add_naprop_level_s1_1m        := pk_add_naprop_level_s1_1m;
                    self.pk_mth_add1_built_date_s1_1m     := pk_mth_add1_built_date_s1_1m;
                    self.pk_mth_add1_dt_f_sn_s1_1m        := pk_mth_add1_dt_f_sn_s1_1m;
                    self.pk_addrs_5yr_s2_2m               := pk_addrs_5yr_s2_2m;
                    self.pk_avg_mo_per_addr_s2_2m         := pk_avg_mo_per_addr_s2_2m;
                    self.pk_add1_ownership_s2_2m          := pk_add1_ownership_s2_2m;
                    self.pk_mth_add1_purchase_date_s2_2m  := pk_mth_add1_purchase_date_s2_2m;
                    self.pk_mth_attr_dt_first_prch_s2_2m  := pk_mth_attr_dt_first_prch_s2_2m;
                    self.pk_prop_owned_sold_lvl_s2_2m     := pk_prop_owned_sold_lvl_s2_2m;
                    self.pk_ver_src_nas_p_lvl_s2_2m       := pk_ver_src_nas_p_lvl_s2_2m;
                    self.pk_avg_mo_per_addr_s3_3m         := pk_avg_mo_per_addr_s3_3m;
                    self.pk_addr_count_ge3_s3_3m          := pk_addr_count_ge3_s3_3m;
                    self.pk_mth_add1_dt_f_sn_s3_3m        := pk_mth_add1_dt_f_sn_s3_3m;
                    self.pk_ver_src_nas_p_lvl_s3_3m       := pk_ver_src_nas_p_lvl_s3_3m;
                    self.pk_impulse_count_0m              := pk_impulse_count_0m;
                    self.pk_inq_peradl_0m                 := pk_inq_peradl_0m;
                    self.pk_inq_ssnsperaddr_0m            := pk_inq_ssnsperaddr_0m;
                    self.pk_inq_count06_s1_1m             := pk_inq_count06_s1_1m;
                    self.pk_inq_ssnsperaddr_1m            := pk_inq_ssnsperaddr_1m;
                    self.pk_inq_perphone_s1_1m            := pk_inq_perphone_s1_1m;
                    self.pk_inq_banking_count06_s2_2m     := pk_inq_banking_count06_s2_2m;
                    self.pk_inq_adlsperaddr_s2_2m         := pk_inq_adlsperaddr_s2_2m;
                    self.pk_inq_perphone_s2_2m            := pk_inq_perphone_s2_2m;
                    self.pk_inq_banking_count06_s3_3m     := pk_inq_banking_count06_s3_3m;
                    self.pk_inq_ssnsperaddr_3m            := pk_inq_ssnsperaddr_3m;
                    self.pk_inq_adlsperphone_s3_3m        := pk_inq_adlsperphone_s3_3m;
                    self.pk_addrs_per_adl_s0_0m           := pk_addrs_per_adl_s0_0m;
                    self.pk_ssns_per_adl_s1_1m            := pk_ssns_per_adl_s1_1m;
                    self.pk_adlperssn_count_s1_1m         := pk_adlperssn_count_s1_1m;
                    self.pk_addrs_per_ssn_s1_1m           := pk_addrs_per_ssn_s1_1m;
                    self.pk_ssns_per_addr_s1_1m           := pk_ssns_per_addr_s1_1m;
                    self.pk_adls_per_phone_s1_1m          := pk_adls_per_phone_s1_1m;
                    self.pk_ssns_per_adl_s2_2m            := pk_ssns_per_adl_s2_2m;
                    self.pk_addrs_per_ssn_s2_2m           := pk_addrs_per_ssn_s2_2m;
                    self.pk_ssns_per_addr_s2_2m           := pk_ssns_per_addr_s2_2m;
                    self.pk_adls_per_phone_s2_2m          := pk_adls_per_phone_s2_2m;
                    self.pk_ssns_per_adl_s3_3m            := pk_ssns_per_adl_s3_3m;
                    self.pk_phones_per_adl_s3_3m          := pk_phones_per_adl_s3_3m;
                    self.pk_nameperssn_count_3m           := pk_nameperssn_count_3m;
                    self.pk_adlperssn_count_s3_3m         := pk_adlperssn_count_s3_3m;
                    self.pk_addrs_per_ssn_s3_3m           := pk_addrs_per_ssn_s3_3m;
                    self.pk_ssns_per_addr_s3_3m           := pk_ssns_per_addr_s3_3m;
                    self.pk_phones_per_addr_s3_3m         := pk_phones_per_addr_s3_3m;
                    self.pk_adls_per_phone_s3_3m          := pk_adls_per_phone_s3_3m;
                    self.pk_addr_adl_tree_0m              := pk_addr_adl_tree_0m;
                    self.pk_addrs_per_ssn_c6_0m           := pk_addrs_per_ssn_c6_0m;
                    self.pk_adls_per_addr_c6_s0_0m        := pk_adls_per_addr_c6_s0_0m;
                    self.pk_phones_per_addr_c6_s0_0m      := pk_phones_per_addr_c6_s0_0m;
                    self.pk_addr_adl_tree_1m              := pk_addr_adl_tree_1m;
                    self.pk_addrs_per_ssn_c6_1m           := pk_addrs_per_ssn_c6_1m;
                    self.pk_adls_per_addr_c6_s1_1m        := pk_adls_per_addr_c6_s1_1m;
                    self.pk_phones_per_addr_c6_s1_1m      := pk_phones_per_addr_c6_s1_1m;
                    self.pk_addrs_per_ssn_c6_2m           := pk_addrs_per_ssn_c6_2m;
                    self.pk_ssns_per_addr_c6_s2_2m        := pk_ssns_per_addr_c6_s2_2m;
                    self.pk_addr_adl_tree_3m              := pk_addr_adl_tree_3m;
                    self.pk_addrs_per_ssn_c6_3m           := pk_addrs_per_ssn_c6_3m;
                    self.pk_ssns_per_addr_c6_s3_3m        := pk_ssns_per_addr_c6_s3_3m;
                    self.pk_phones_per_addr_c6_s3_3m      := pk_phones_per_addr_c6_s3_3m;
			// self.pk_dist_a1toa2_0m                := pk_dist_a1toa2_0m;
			// self.pk_dist_a1toa2_1m                := pk_dist_a1toa2_1m;
			// self.pk_dist_a1toa3_s1_1m             := pk_dist_a1toa3_s1_1m;
			// self.pk_rc_disthphoneaddr_s0_0m       := pk_rc_disthphoneaddr_s0_0m;
                    self.pk_ssn_lowissue_age2_s0_0m       := pk_ssn_lowissue_age2_s0_0m;
                    self.pk_ssn_lowissue_age2_s1_1m       := pk_ssn_lowissue_age2_s1_1m;
                    self.ssn_issued18_1m                  := ssn_issued18_1m;
                    self.ssn_issued18_2m                  := ssn_issued18_2m;
			// self.pk_phnprob2_s2_2m                := pk_phnprob2_s2_2m;
                    self.ssn_issued18_3m                  := ssn_issued18_3m;
                    self.pk_add1_house_number_match_0mn   := pk_add1_house_number_match_0mn;
                    self.eda_sourced_level_0mn            := eda_sourced_level_0mn;
                    self.pk_infutor_nap_0mn               := pk_infutor_nap_0mn;
                    self.pk_input_dob_match_level_0mn     := pk_input_dob_match_level_0mn;
                    self.pk_ams_4yr_college_0mn           := pk_ams_4yr_college_0mn;
                    self.pk_attr_num_nonderogs180_0mn     := pk_attr_num_nonderogs180_0mn;
                    self.pk_email_count_0mn               := pk_email_count_0mn;
                    self.pk_email_domain_free_count_0mn   := pk_email_domain_free_count_0mn;
                    self.pk_combo_hphonecount_0mn         := pk_combo_hphonecount_0mn;
                    self.pk_mth_header_first_seen2_s0_0mn := pk_mth_header_first_seen2_s0_0mn;
                    self.pk_mth_ver_src_fdate_ts2_0mn     := pk_mth_ver_src_fdate_ts2_0mn;
                    self.pk_time_on_cb_120b_s0_0mn        := pk_time_on_cb_120b_s0_0mn;
                    self.pk_dob_score_ver_1mn             := pk_dob_score_ver_1mn;
                    self.nas_summary_ver_1mn              := nas_summary_ver_1mn;
                    self.pk_nap_summary_ver_1mn           := pk_nap_summary_ver_1mn;
                    self.eda_sourced_level_1mn            := eda_sourced_level_1mn;
                    self.pk_infutor_nap_1mn               := pk_infutor_nap_1mn;
                    self.pk_ams_age_1mn                   := pk_ams_age_1mn;
                    self.pk_ams_income_level_code_1mn     := pk_ams_income_level_code_1mn;
                    self.pk_ams_college_tier_1mn          := pk_ams_college_tier_1mn;
                    self.pk_attr_num_nonderogs180_1mn     := pk_attr_num_nonderogs180_1mn;
                    self.pk_email_count_1mn               := pk_email_count_1mn;
                    self.pk_paw_company_title_1mn         := pk_paw_company_title_1mn;
                    self.pk_mth_gong_did_first_seen2_1mn  := pk_mth_gong_did_first_seen2_1mn;
                    self.pk_mth_infutor_first_seen2_1mn   := pk_mth_infutor_first_seen2_1mn;
                    self.pk_time_on_cb_120b_s1_1mn        := pk_time_on_cb_120b_s1_1mn;
                    self.pk_hphn_score_ver_2mn            := pk_hphn_score_ver_2mn;
                    self.eda_sourced_level_2mn            := eda_sourced_level_2mn;
                    self.pk_ams_4yr_college_2mn           := pk_ams_4yr_college_2mn;
                    self.pk_ams_college_tier_2mn          := pk_ams_college_tier_2mn;
                    self.pk_pos_addr_src_cnt_2mn          := pk_pos_addr_src_cnt_2mn;
                    self.pk_mth_header_first_seen2_s2_2mn := pk_mth_header_first_seen2_s2_2mn;
                    self.pk_mth_infutor_first_seen2_2mn   := pk_mth_infutor_first_seen2_2mn;
                    self.pk_add1_house_number_match_3mn   := pk_add1_house_number_match_3mn;
                    self.eda_sourced_level_3mn            := eda_sourced_level_3mn;
                    self.pk_ams_college_tier_3mn          := pk_ams_college_tier_3mn;
                    self.pk_attr_num_nonderogs180_3mn     := pk_attr_num_nonderogs180_3mn;
                    self.pk_email_count_3mn               := pk_email_count_3mn;
                    self.pk_prof_license_category_3mn     := pk_prof_license_category_3mn;
                    self.pk_combo_hphonecount_3mn         := pk_combo_hphonecount_3mn;
                    self.pk_mth_infutor_first_seen2_3mn   := pk_mth_infutor_first_seen2_3mn;
                    self.pk_mth_ver_src_fdate_ts2_3mn     := pk_mth_ver_src_fdate_ts2_3mn;
                    self.pk_time_on_cb_120b_s3_3mn        := pk_time_on_cb_120b_s3_3mn;
                    self.pk_nap_summary_ver_0mb           := pk_nap_summary_ver_0mb;
                    self.pk_infutor_nap_0mb               := pk_infutor_nap_0mb;
                    self.pk_ams_college_type_0mb          := pk_ams_college_type_0mb;
                    self.pk_ams_income_level_code_0mb     := pk_ams_income_level_code_0mb;
                    self.pk_attr_num_nonderogs_0mb        := pk_attr_num_nonderogs_0mb;
                    self.pk_attr_num_nonderogs180_0mb     := pk_attr_num_nonderogs180_0mb;
                    self.pk_email_count_0mb               := pk_email_count_0mb;
                    self.pk_bureau_only_0mb               := pk_bureau_only_0mb;
                    self.pk_mth_gong_did_first_seen2_0mb  := pk_mth_gong_did_first_seen2_0mb;
                    self.pk_mth_header_first_seen2_s0_0mb := pk_mth_header_first_seen2_s0_0mb;
                    self.pk_mth_infutor_first_seen2_0mb   := pk_mth_infutor_first_seen2_0mb;
                    self.pk_mth_ver_src_fdate_ts2_0mb     := pk_mth_ver_src_fdate_ts2_0mb;
                    self.pk_time_on_cb_120b_s0_0mb        := pk_time_on_cb_120b_s0_0mb;
                    self.pk_ssn_score_ver_1mb             := pk_ssn_score_ver_1mb;
                    self.eda_sourced_level_1mb            := eda_sourced_level_1mb;
                    self.pk_ams_age_1mb                   := pk_ams_age_1mb;
                    self.pk_ams_income_level_code_1mb     := pk_ams_income_level_code_1mb;
                    self.pk_ams_college_tier_1mb          := pk_ams_college_tier_1mb;
                    self.pk_attr_num_nonderogs180_1mb     := pk_attr_num_nonderogs180_1mb;
                    self.pk_email_count_1mb               := pk_email_count_1mb;
                    self.pk_email_domain_free_count_1mb   := pk_email_domain_free_count_1mb;
                    self.pk_prof_license_category_1mb     := pk_prof_license_category_1mb;
                    self.pk_pos_dob_src_cnt_1mb           := pk_pos_dob_src_cnt_1mb;
                    self.pk_mth_gong_did_first_seen2_1mb  := pk_mth_gong_did_first_seen2_1mb;
                    self.pk_mth_infutor_first_seen2_1mb   := pk_mth_infutor_first_seen2_1mb;
                    self.pk_time_on_cb_120b_s1_1mb        := pk_time_on_cb_120b_s1_1mb;
                    self.pk_nap_summary_ver_2mb           := pk_nap_summary_ver_2mb;
                    self.pk_rc_fnamessnmatch_2mb          := pk_rc_fnamessnmatch_2mb;
                    self.pk_ams_4yr_college_2mb           := pk_ams_4yr_college_2mb;
                    self.pk_email_src_cnt_2mb             := pk_email_src_cnt_2mb;
                    self.pk_pos_addr_src_cnt_2mb          := pk_pos_addr_src_cnt_2mb;
                    self.pk_mth_gong_did_first_seen2_2mb  := pk_mth_gong_did_first_seen2_2mb;
                    self.pk_mth_header_first_seen2_s2_2mb := pk_mth_header_first_seen2_s2_2mb;
                    self.pk_mth_infutor_first_seen2_2mb   := pk_mth_infutor_first_seen2_2mb;
                    self.pk_time_on_cb_120b_s2_2mb        := pk_time_on_cb_120b_s2_2mb;
                    self.pk_dob_score_ver_3mb             := pk_dob_score_ver_3mb;
                    self.pk_nap_summary_ver_3mb           := pk_nap_summary_ver_3mb;
                    self.pk_ams_4yr_college_3mb           := pk_ams_4yr_college_3mb;
                    self.pk_ams_income_level_code_3mb     := pk_ams_income_level_code_3mb;
                    self.pk_attr_num_nonderogs180_3mb     := pk_attr_num_nonderogs180_3mb;
                    self.pk_email_src_cnt_3mb             := pk_email_src_cnt_3mb;
                    self.pk_prof_license_category_3mb     := pk_prof_license_category_3mb;
                    self.pk_mth_gong_did_first_seen2_3mb  := pk_mth_gong_did_first_seen2_3mb;
                    self.pk_mth_header_first_seen2_s3_3mb := pk_mth_header_first_seen2_s3_3mb;
                    self.pk_mth_infutor_first_seen2_3mb   := pk_mth_infutor_first_seen2_3mb;
                    self.pk_mth_ver_src_fdate_wp2_s3_3mb  := pk_mth_ver_src_fdate_wp2_s3_3mb;
                    self.derog_mod2_0m                    := derog_mod2_0m;
                    self.prop_mod3_0m                     := prop_mod3_0m;
                    self.prop_mod3_1m                     := prop_mod3_1m;
                    self.prop_mod3_2m                     := prop_mod3_2m;
                    self.prop_mod3_3m                     := prop_mod3_3m;
                    self.velocity_mod2_0m                 := velocity_mod2_0m;
                    self.velocity_mod2_1m                 := velocity_mod2_1m;
                    self.velocity_mod2_2m                 := velocity_mod2_2m;
                    self.velocity_mod2_3m                 := velocity_mod2_3m;
                    self.multi_mod_1m                     := multi_mod_1m;
                    self.multi_mod_2m                     := multi_mod_2m;
                    self.multi_mod_3m                     := multi_mod_3m;
                    self.ver_mod2_best_0m                 := ver_mod2_best_0m;
                    self.ver_mod2_best_1m                 := ver_mod2_best_1m;
                    self.ver_mod2_best_2m                 := ver_mod2_best_2m;
                    self.ver_mod2_best_3m                 := ver_mod2_best_3m;
                    self.ver_mod2_best_nodob_0m           := ver_mod2_best_nodob_0m;
                    self.ver_mod2_best_nodob_1m           := ver_mod2_best_nodob_1m;
                    self.ver_mod2_best_nodob_2m           := ver_mod2_best_nodob_2m;
                    self.ver_mod2_best_nodob_3m           := ver_mod2_best_nodob_3m;
                    self.ver_mod2_notbest_0m              := ver_mod2_notbest_0m;
                    self.ver_mod2_notbest_1m              := ver_mod2_notbest_1m;
                    self.ver_mod2_notbest_2m              := ver_mod2_notbest_2m;
                    self.ver_mod2_notbest_3m              := ver_mod2_notbest_3m;
                    self.ver_mod2_notbest_nodob_0m        := ver_mod2_notbest_nodob_0m;
                    self.ver_mod2_notbest_nodob_1m        := ver_mod2_notbest_nodob_1m;
                    self.ver_mod2_notbest_nodob_2m        := ver_mod2_notbest_nodob_2m;
                    self.ver_mod2_notbest_nodob_3m        := ver_mod2_notbest_nodob_3m;
                    self.ver_mod2_nodob_0m                := ver_mod2_nodob_0m;
                    self.ver_mod2_nodob_2m                := ver_mod2_nodob_2m;
                    self.ver_mod2_nodob_3m                := ver_mod2_nodob_3m;
                    self.ver_mod2_3m                      := ver_mod2_3m;
                    self.ver_mod2_2m                      := ver_mod2_2m;
                    self.ver_mod2_1m                      := ver_mod2_1m;
                    self.ver_mod2_0m                      := ver_mod2_0m;
                    self.ver_mod2_nodob_1m                := ver_mod2_nodob_1m;
                    self.inquiry_mod3_0m                  := inquiry_mod3_0m;
                    self.inquiry_mod3_1m                  := inquiry_mod3_1m;
                    self.inquiry_mod3_2m                  := inquiry_mod3_2m;
                    self.inquiry_mod3_3m                  := inquiry_mod3_3m;
                    self.mod15_0m                         := mod15_0m;
                    self.mod15_1m                         := mod15_1m;
                    self.mod15_2m                         := mod15_2m;
                    self.mod15_3m                         := mod15_3m;
                    self.mod15_nodob_0m                   := mod15_nodob_0m;
                    self.mod15_nodob_1m                   := mod15_nodob_1m;
                    self.mod15_nodob_2m                   := mod15_nodob_2m;
                    self.mod15_nodob_3m                   := mod15_nodob_3m;
                    self.mod15_nodob                      := mod15_nodob;
                    self.mod15                            := mod15;
                    self.mod15_phat                       := mod15_phat;
                    self.mod15_scr                        := mod15_scr;
                    self.mod15_nodob_phat                 := mod15_nodob_phat;
                    self.mod15_nodob_scr                  := mod15_nodob_scr;
			// self.mod12_nodob_phat                 := mod12_nodob_phat;
			// self.mod12_nodob_scr                  := mod12_nodob_scr;
                    self.rvr1103a                         := rvr1103a;
                    self.rvr1103b                         := rvr1103b;
                    self.ov_ssndead                       := ov_ssndead;
                    self.ov_ssnprior                      := ov_ssnprior;
                    self.ov_criminal_flag                 := ov_criminal_flag;
                    self.ov_corrections                   := ov_corrections;
                    self.ov_impulse                       := ov_impulse;
                    self.rvr1103c                         := rvr1103c;
                    // self.scored_222s                      := scored_222s;
                    self.rvr1103d                         := rvr1103d;
                    self.rvr1103                          := rvr1103;

					// self.phn_notpots := phn_notpots;
					// self.pk_estimated_income_s0 := pk_estimated_income_s0;
					// self.pk_phnprob_s2 := pk_phnprob_s2;
					// self.pk_phnprob2_s2 := pk_phnprob2_s2;
					// self.pk_estimated_income_s3_3m := pk_estimated_income_s3_3m;
					// self.fp_mod_2m := fp_mod_2m;
					// self.fp_mod_nodob_2m := fp_mod_nodob_2m;
					// self.mod12_0m := mod12_0m;
					// self.mod12_1m := mod12_1m;
					// self.mod12_2m := mod12_2m;
					// self.mod12_3m := mod12_3m;
					// self.mod12_nodob_0m := mod12_nodob_0m;
					// self.mod12_nodob_1m := mod12_nodob_1m;
					// self.mod12_nodob_2m := mod12_nodob_2m;
					// self.mod12_nodob_3m := mod12_nodob_3m;
					// self.mod12_nodob := mod12_nodob;
					// self.mod12 := mod12;
					// self.mod12_phat := mod12_phat;
					// self.mod12_scr := mod12_scr;

				self.pk_phn_cell := pk_phn_cell;
				self.pk_phn_pager := pk_phn_pager;
				self.pk_phn_pcs := pk_phn_pcs;
				self.pk_phn_disconnect := pk_phn_disconnect;
				self.pk_phn_cell2 := pk_phn_cell2;
				self.pk_phn_pager2 := pk_phn_pager2;
				self.pk_phn_pcs2 := pk_phn_pcs2;
				self.pk_phn_payphone := pk_phn_payphone;
				self.pk_phn_fax := pk_phn_fax;
				self.pk_phn_invalid := pk_phn_invalid;
				self.pk_phn_usage_unknown := pk_phn_usage_unknown;
				self.pk_phn_invalid2 := pk_phn_invalid2;
				self.pk_phn_notpots := pk_phn_notpots;
				self.pk_phn_usage_unknown2 := pk_phn_usage_unknown2;
				self.pk_phn_phnzipmismatch := pk_phn_phnzipmismatch;
				self.pk_phn_phnzipmismatch2 := pk_phn_phnzipmismatch2;
				self.pk_phn_phn_not_issued := pk_phn_phn_not_issued;
				self.pk_phn_nonus := pk_phn_nonus;
				self.pk_phn_pager3 := pk_phn_pager3;
				self.pk_phn_cell3 := pk_phn_cell3;
				self.pk_phn_cell4 := pk_phn_cell4;
				self.pk_phn_pager4 := pk_phn_pager4;
				self.pk_phn_mobile := pk_phn_mobile;
				self.pk_phn_cpm := pk_phn_cpm;
				self.pk_phn_cell5 := pk_phn_cell5;
				self.pk_phn_pager5 := pk_phn_pager5;
				self.pk_phn_mobile2 := pk_phn_mobile2;
				self.pk_phn_cpm2 := pk_phn_cpm2;
				self.pk_phn_pcs3 := pk_phn_pcs3;
				self.pk_phn_pcs4 := pk_phn_pcs4;
				self.pk_phn_pcs5 := pk_phn_pcs5;
				self.pk_phn_pcs6 := pk_phn_pcs6;
				self.pk_phn_pcs7 := pk_phn_pcs7;
				self.pk_phn_cpm_flag := pk_phn_cpm_flag;
				self.pk_phn_pcs_flag := pk_phn_pcs_flag;
				self.pk_phn_phnzipmis_flag := pk_phn_phnzipmis_flag;
				self.phn_notpots := phn_notpots;
				self.pk_phn_invalid_flag := pk_phn_invalid_flag;
				self.pk_phn_NotPOTS_Flag := pk_phn_NotPOTS_Flag;
				self.phn_highrisk2 := phn_highrisk2;
				self.phn_correction := phn_correction;
				self.glrc9t := glrc9t;
				self.pk_add1_advo_address_vacancy := pk_add1_advo_address_vacancy;
				self.pk_add1_advo_throw_back := pk_add1_advo_throw_back;
				self.pk_add1_advo_seasonal_delivery := pk_add1_advo_seasonal_delivery;
				self.pk_add1_advo_college := pk_add1_advo_college;
				self.pk_add1_advo_res_or_business := pk_add1_advo_res_or_business;
				self.pk_add1_advo_drop := pk_add1_advo_drop;
				self.pk_add_inval := pk_add_inval;
				self.pk_add1_advo_mixed_address_usage := pk_add1_advo_mixed_address_usage;
				self.pk_add_hirisk_comm := pk_add_hirisk_comm;
				self.glrc9u := glrc9u;
				self.glrc9w := glrc9w;
				self.glrcev := glrcev;
				self.glrcmi := glrcmi;
				self.glrcms := glrcms;
				self.aptflag := aptflag;
				self.add1_econval := add1_econval;
				self.add1_aptval := add1_aptval;
				self.add1_econcode := add1_econcode;
				self.glrcpv := glrcpv;
				self.m_ver_mod2_0m_c34_b1 := m_ver_mod2_0m_c34_b1;
				self.m_ver_mod2_best_0m_c35 := m_ver_mod2_best_0m_c35;
				self.m_ver_mod2_notbest_0m_c35 := m_ver_mod2_notbest_0m_c35;
				self.m_ver_mod2_best_0m_c34 := m_ver_mod2_best_0m_c34;
				self.m_velocity_mod2_0m_c34 := m_velocity_mod2_0m_c34;
				self.m_derog_mod2_0m_c34 := m_derog_mod2_0m_c34;
				self.m_inquiry_mod3_0m_c34 := m_inquiry_mod3_0m_c34;
				self.m_prop_mod3_0m_c34 := m_prop_mod3_0m_c34;
				self.m_ver_mod2_notbest_0m_c34 := m_ver_mod2_notbest_0m_c34;
				self.m_ver_mod2_1m_c36_b1 := m_ver_mod2_1m_c36_b1;
				self.m_ver_mod2_notbest_1m_c37 := m_ver_mod2_notbest_1m_c37;
				self.m_ver_mod2_best_1m_c37 := m_ver_mod2_best_1m_c37;
				self.m_velocity_mod2_1m_c36 := m_velocity_mod2_1m_c36;
				self.m_ver_mod2_notbest_1m_c36 := m_ver_mod2_notbest_1m_c36;
				self.m_prop_mod3_1m_c36 := m_prop_mod3_1m_c36;
				self.m_multi_mod_1m_c36 := m_multi_mod_1m_c36;
				self.m_inquiry_mod3_1m_c36 := m_inquiry_mod3_1m_c36;
				self.m_ver_mod2_best_1m_c36 := m_ver_mod2_best_1m_c36;
				self.m_ver_mod2_2m_c38_b1 := m_ver_mod2_2m_c38_b1;
				self.m_ver_mod2_best_2m_c39 := m_ver_mod2_best_2m_c39;
				self.m_ver_mod2_notbest_2m_c39 := m_ver_mod2_notbest_2m_c39;
				self.m_inquiry_mod3_2m_c38 := m_inquiry_mod3_2m_c38;
				self.m_prop_mod3_2m_c38 := m_prop_mod3_2m_c38;
				self.m_velocity_mod2_2m_c38 := m_velocity_mod2_2m_c38;
				self.m_ver_mod2_best_2m_c38 := m_ver_mod2_best_2m_c38;
				self.m_multi_mod_2m_c38 := m_multi_mod_2m_c38;
				self.m_ver_mod2_notbest_2m_c38 := m_ver_mod2_notbest_2m_c38;
				self.m_ver_mod2_3m_c40_b1 := m_ver_mod2_3m_c40_b1;
				self.m_ver_mod2_best_3m_c41 := m_ver_mod2_best_3m_c41;
				self.m_ver_mod2_notbest_3m_c41 := m_ver_mod2_notbest_3m_c41;
				self.m_multi_mod_3m_c40 := m_multi_mod_3m_c40;
				self.m_ver_mod2_notbest_3m_c40 := m_ver_mod2_notbest_3m_c40;
				self.m_ver_mod2_best_3m_c40 := m_ver_mod2_best_3m_c40;
				self.m_prop_mod3_3m_c40 := m_prop_mod3_3m_c40;
				self.m_inquiry_mod3_3m_c40 := m_inquiry_mod3_3m_c40;
				self.m_velocity_mod2_3m_c40 := m_velocity_mod2_3m_c40;
				self.seg_s0_crime_c43_b1 := seg_s0_crime_c43_b1;
				self._97_0_c43 := _97_0_c43;
				self.seg_s0_lien_c44_b1 := seg_s0_lien_c44_b1;
				self._98_0_c44 := _98_0_c44;
				self.seg_s0_eviction_c45_b1 := seg_s0_eviction_c45_b1;
				self._ev_0_c45 := _ev_0_c45;
				self.seg_s0_impulse_c46_b1 := seg_s0_impulse_c46_b1;
				self._9h_0_c46 := _9h_0_c46;
				self.seg_s0_bk_c47_b1 := seg_s0_bk_c47_b1;
				self._9w_0_c47 := _9w_0_c47;
				self._9d_3_c42 := _9d_3_c42;
				self._9r_5_c42 := _9r_5_c42;
				self._9q_1_c42 := _9q_1_c42;
				self._9e_2_c42 := _9e_2_c42;
				self._9r_4_c42 := _9r_4_c42;
				self._ev_1_c42 := _ev_1_c42;
				self._x11_3_c42 := _x11_3_c42;
				self._9h_1_c42 := _9h_1_c42;
				self._25_1_c42 := _25_1_c42;
				self._9r_3_c42 := _9r_3_c42;
				self._9o_1_c42 := _9o_1_c42;
				self._x11_2_c42 := _x11_2_c42;
				self._9g_1_c42 := _9g_1_c42;
				self._9r_11_c42 := _9r_11_c42;
				self._9a_1_c42 := _9a_1_c42;
				self._9r_6_c42 := _9r_6_c42;
				self._9e_3_c42 := _9e_3_c42;
				self._9j_2_c42 := _9j_2_c42;
				self._9w_0_c42 := _9w_0_c42;
				self._9c_1_c42 := _9c_1_c42;
				self._9e_1_c42 := _9e_1_c42;
				self._97_1_c42 := _97_1_c42;
				self._98_0_c42 := _98_0_c42;
				self._9m_1_c42 := _9m_1_c42;
				self._9r_10_c42 := _9r_10_c42;
				self._ev_0_c42 := _ev_0_c42;
				self._98_1_c42 := _98_1_c42;
				self._9h_0_c42 := _9h_0_c42;
				self._9q_2_c42 := _9q_2_c42;
				self._9d_2_c42 := _9d_2_c42;
				self._27_1_c42 := _27_1_c42;
				self._9j_1_c42 := _9j_1_c42;
				self._9d_1_c42 := _9d_1_c42;
				self._9r_9_c42 := _9r_9_c42;
				self._98_2_c42 := _98_2_c42;
				self._9d_4_c42 := _9d_4_c42;
				self._9c_2_c42 := _9c_2_c42;
				self._28_1_c42 := _28_1_c42;
				self._9c_3_c42 := _9c_3_c42;
				self._9r_7_c42 := _9r_7_c42;
				self._9r_1_c42 := _9r_1_c42;
				self._9e_5_c42 := _9e_5_c42;
				self._9r_2_c42 := _9r_2_c42;
				self._9d_5_c42 := _9d_5_c42;
				self._97_0_c42 := _97_0_c42;
				self._9r_8_c42 := _9r_8_c42;
				self._9e_4_c42 := _9e_4_c42;
				// self._x11_1_c42_2 := _x11_1_c42_2;
				self._9a_2_c42 := _9a_2_c42;
				self.seg_s1_c48_b1 := seg_s1_c48_b1;
				self._x11_6_c48 := _x11_6_c48;
				self._9m_3_c48 := _9m_3_c48;
				self._9e_7_c48 := _9e_7_c48;
				self._9o_2_c48 := _9o_2_c48;
				self._9c_4_c48 := _9c_4_c48;
				self._26_1_c48 := _26_1_c48;
				self._9g_5_c48 := _9g_5_c48;
				self._ms_1_c48 := _ms_1_c48;
				self._9o_3_c48 := _9o_3_c48;
				self._9c_6_c48 := _9c_6_c48;
				self._9r_21_c48 := _9r_21_c48;
				self._x11_4_c48 := _x11_4_c48;
				self._9d_6_c48 := _9d_6_c48;
				self._9r_15_c48 := _9r_15_c48;
				self._9q_5_c48 := _9q_5_c48;
				self._mi_1_c48 := _mi_1_c48;
				self._9r_16_c48 := _9r_16_c48;
				self._9e_6_c48 := _9e_6_c48;
				self._9r_14_c48 := _9r_14_c48;
				self._9r_20_c48 := _9r_20_c48;
				self._9q_3_c48 := _9q_3_c48;
				self._x11_5_c48 := _x11_5_c48;
				self._9q_4_c48 := _9q_4_c48;
				self._28_2_c48 := _28_2_c48;
				self._9g_2_c48 := _9g_2_c48;
				self._9r_19_c48 := _9r_19_c48;
				self._9g_4_c48 := _9g_4_c48;
				self._9d_7_c48 := _9d_7_c48;
				self._9g_6_c48 := _9g_6_c48;
				self._9r_17_c48 := _9r_17_c48;
				self._9r_12_c48 := _9r_12_c48;
				self._9r_18_c48 := _9r_18_c48;
				self._9c_5_c48 := _9c_5_c48;
				self._9d_8_c48 := _9d_8_c48;
				self._9d_9_c48 := _9d_9_c48;
				self._x11_7_c48 := _x11_7_c48;
				self._9g_3_c48 := _9g_3_c48;
				self._9e_8_c48 := _9e_8_c48;
				self._9m_4_c48 := _9m_4_c48;
				self._9r_13_c48 := _9r_13_c48;
				self._pv_1_c48 := _pv_1_c48;
				self._9l_1_c48 := _9l_1_c48;
				self._9m_2_c48 := _9m_2_c48;
				self._9q_8_c49 := _9q_8_c49;
				self._9d_11_c49 := _9d_11_c49;
				self._9o_4_c49 := _9o_4_c49;
				self._9r_25_c49 := _9r_25_c49;
				self._9j_3_c49 := _9j_3_c49;
				self._9l_2_c49 := _9l_2_c49;
				self._9q_6_c49 := _9q_6_c49;
				self._9e_9_c49 := _9e_9_c49;
				self._9r_22_c49 := _9r_22_c49;
				self._9s_1_c49 := _9s_1_c49;
				self._pv_2_c49 := _pv_2_c49;
				self._9a_4_c49 := _9a_4_c49;
				self._9d_12_c49 := _9d_12_c49;
				self._9a_6_c49 := _9a_6_c49;
				self._27_2_c49 := _27_2_c49;
				self._ms_2_c49 := _ms_2_c49;
				self._9r_24_c49 := _9r_24_c49;
				self._9c_7_c49 := _9c_7_c49;
				self._9e_11_c49 := _9e_11_c49;
				self._9e_10_c49 := _9e_10_c49;
				self._x11_8_c49 := _x11_8_c49;
				self._9q_7_c49 := _9q_7_c49;
				self._9g_7_c49 := _9g_7_c49;
				self._9m_5_c49 := _9m_5_c49;
				self._x11_9_c49 := _x11_9_c49;
				self._52_1_c49 := _52_1_c49;
				self._9r_26_c49 := _9r_26_c49;
				self._9a_5_c49 := _9a_5_c49;
				self._9a_3_c49 := _9a_3_c49;
				self._9j_4_c49 := _9j_4_c49;
				self._9c_8_c49 := _9c_8_c49;
				self._9d_10_c49 := _9d_10_c49;
				self._9r_23_c49 := _9r_23_c49;
				// self._x11_1_c49_1 := _x11_1_c49_1;
				// self._x11_1_c50_b1_4 := _x11_1_c50_b1_4;
				// self._x11_1_c50_b1_3 := _x11_1_c50_b1_3;
				// self._x11_1_c50_b1_2 := _x11_1_c50_b1_2;
				// self._x11_1_c50_b1_1 := _x11_1_c50_b1_1;
				self._9r_34_c50 := _9r_34_c50;
				self._9q_9_c50 := _9q_9_c50;
				self._9r_33_c50 := _9r_33_c50;
				self._9m_6_c50 := _9m_6_c50;
				self._9r_27_c50 := _9r_27_c50;
				self._9a_7_c50 := _9a_7_c50;
				self._9d_13_c50 := _9d_13_c50;
				self._9d_15_c50 := _9d_15_c50;
				self._9r_31_c50 := _9r_31_c50;
				self._9r_30_c50 := _9r_30_c50;
				self._9r_32_c50 := _9r_32_c50;
				self._mi_2_c50 := _mi_2_c50;
				self._9q_11_c50 := _9q_11_c50;
				self._9e_14_c50 := _9e_14_c50;
				self._9j_5_c50 := _9j_5_c50;
				self._9g_8_c50 := _9g_8_c50;
				self._9r_29_c50 := _9r_29_c50;
				self._9d_14_c50 := _9d_14_c50;
				self._pv_3_c50 := _pv_3_c50;
				self._27_3_c50 := _27_3_c50;
				self._38_1_c50 := _38_1_c50;
				self._9c_10_c50 := _9c_10_c50;
				self._9e_12_c50 := _9e_12_c50;
				self._9r_28_c50 := _9r_28_c50;
				self._9c_9_c50 := _9c_9_c50;
				self._9o_5_c50 := _9o_5_c50;
				self._9q_10_c50 := _9q_10_c50;
				self._28_3_c50 := _28_3_c50;
				self._ms_3_c50 := _ms_3_c50;
				// self._x11_1_c50 := _x11_1_c50;
				self._9c_11_c50 := _9c_11_c50;
				self._25_2_c50 := _25_2_c50;
				self._9e_13_c50 := _9e_13_c50;
				self.m_ver_mod2_nodob_0m := m_ver_mod2_nodob_0m;
				self.m_ver_mod2_notbest_nodob_0m_c52 := m_ver_mod2_notbest_nodob_0m_c52;
				self.m_ver_mod2_best_nodob_0m_c52 := m_ver_mod2_best_nodob_0m_c52;
				self.m_velocity_mod2_0m_c51 := m_velocity_mod2_0m_c51;
				self.m_derog_mod2_0m_c51 := m_derog_mod2_0m_c51;
				self.m_inquiry_mod3_0m_c51 := m_inquiry_mod3_0m_c51;
				self.m_ver_mod2_notbest_nodob_0m_c51 := m_ver_mod2_notbest_nodob_0m_c51;
				self.m_ver_mod2_best_nodob_0m_c51 := m_ver_mod2_best_nodob_0m_c51;
				self.m_prop_mod3_0m_c51 := m_prop_mod3_0m_c51;
				self.m_ver_mod2_nodob_1m_c53_b1 := m_ver_mod2_nodob_1m_c53_b1;
				self.m_ver_mod2_best_nodob_1m_c54 := m_ver_mod2_best_nodob_1m_c54;
				self.m_ver_mod2_notbest_nodob_1m_c54 := m_ver_mod2_notbest_nodob_1m_c54;
				self.m_velocity_mod2_1m_c53 := m_velocity_mod2_1m_c53;
				self.m_ver_mod2_best_nodob_1m_c53 := m_ver_mod2_best_nodob_1m_c53;
				self.m_prop_mod3_1m_c53 := m_prop_mod3_1m_c53;
				self.m_multi_mod_1m_c53 := m_multi_mod_1m_c53;
				self.m_inquiry_mod3_1m_c53 := m_inquiry_mod3_1m_c53;
				self.m_ver_mod2_notbest_nodob_1m_c53 := m_ver_mod2_notbest_nodob_1m_c53;
				self.m_ver_mod2_nodob_2m_c55_b1 := m_ver_mod2_nodob_2m_c55_b1;
				self.m_ver_mod2_notbest_nodob_2m_c56 := m_ver_mod2_notbest_nodob_2m_c56;
				self.m_ver_mod2_best_nodob_2m_c56 := m_ver_mod2_best_nodob_2m_c56;
				self.m_inquiry_mod3_2m_c55 := m_inquiry_mod3_2m_c55;
				self.m_prop_mod3_2m_c55 := m_prop_mod3_2m_c55;
				self.m_velocity_mod2_2m_c55 := m_velocity_mod2_2m_c55;
				self.m_ver_mod2_notbest_nodob_2m_c55 := m_ver_mod2_notbest_nodob_2m_c55;
				self.m_ver_mod2_best_nodob_2m_c55 := m_ver_mod2_best_nodob_2m_c55;
				self.m_multi_mod_2m_c55 := m_multi_mod_2m_c55;
				self.m_ver_mod2_nodob_3m_c57_b1 := m_ver_mod2_nodob_3m_c57_b1;
				self.m_ver_mod2_best_nodob_3m_c58 := m_ver_mod2_best_nodob_3m_c58;
				self.m_ver_mod2_notbest_nodob_3m_c58 := m_ver_mod2_notbest_nodob_3m_c58;
				self.m_multi_mod_3m_c57 := m_multi_mod_3m_c57;
				self.m_ver_mod2_best_nodob_3m_c57 := m_ver_mod2_best_nodob_3m_c57;
				self.m_ver_mod2_notbest_nodob_3m_c57 := m_ver_mod2_notbest_nodob_3m_c57;
				self.m_prop_mod3_3m_c57 := m_prop_mod3_3m_c57;
				self.m_inquiry_mod3_3m_c57 := m_inquiry_mod3_3m_c57;
				self.m_velocity_mod2_3m_c57 := m_velocity_mod2_3m_c57;
				self.seg_s0_crime_c60_b1 := seg_s0_crime_c60_b1;
				self._97_0_c60 := _97_0_c60;
				self.seg_s0_lien_c61_b1 := seg_s0_lien_c61_b1;
				self._98_0_c61 := _98_0_c61;
				self.seg_s0_eviction_c62_b1 := seg_s0_eviction_c62_b1;
				self._ev_0_c62 := _ev_0_c62;
				self.seg_s0_impulse_c63_b1 := seg_s0_impulse_c63_b1;
				self._9h_0_c63 := _9h_0_c63;
				self.seg_s0_bk_c64_b1 := seg_s0_bk_c64_b1;
				self._9w_0_c64 := _9w_0_c64;
				self._9d_3_c59 := _9d_3_c59;
				self._9r_5_c59 := _9r_5_c59;
				self._9q_1_c59 := _9q_1_c59;
				self._9e_2_c59 := _9e_2_c59;
				self._9r_4_c59 := _9r_4_c59;
				self._ev_1_c59 := _ev_1_c59;
				self._x11_3_c59 := _x11_3_c59;
				self._9h_1_c59 := _9h_1_c59;
				self._25_1_c59 := _25_1_c59;
				self._9r_3_c59 := _9r_3_c59;
				self._9o_1_c59 := _9o_1_c59;
				self._x11_2_c59 := _x11_2_c59;
				self._9r_11_c59 := _9r_11_c59;
				self._9a_1_c59 := _9a_1_c59;
				self._9r_6_c59 := _9r_6_c59;
				self._9e_3_c59 := _9e_3_c59;
				self._9j_2_c59 := _9j_2_c59;
				self._9w_0_c59 := _9w_0_c59;
				self._9c_1_c59 := _9c_1_c59;
				self._9e_1_c59 := _9e_1_c59;
				self._97_1_c59 := _97_1_c59;
				self._98_0_c59 := _98_0_c59;
				self._9m_1_c59 := _9m_1_c59;
				self._9r_10_c59 := _9r_10_c59;
				self._ev_0_c59 := _ev_0_c59;
				self._98_1_c59 := _98_1_c59;
				self._9h_0_c59 := _9h_0_c59;
				self._9q_2_c59 := _9q_2_c59;
				self._9d_2_c59 := _9d_2_c59;
				self._27_1_c59 := _27_1_c59;
				self._9j_1_c59 := _9j_1_c59;
				self._9d_1_c59 := _9d_1_c59;
				self._9r_9_c59 := _9r_9_c59;
				self._98_2_c59 := _98_2_c59;
				self._9d_4_c59 := _9d_4_c59;
				self._9c_2_c59 := _9c_2_c59;
				self._9c_3_c59 := _9c_3_c59;
				self._9r_7_c59 := _9r_7_c59;
				self._9r_1_c59 := _9r_1_c59;
				self._9e_5_c59 := _9e_5_c59;
				self._9r_2_c59 := _9r_2_c59;
				self._9d_5_c59 := _9d_5_c59;
				self._97_0_c59 := _97_0_c59;
				self._9r_8_c59 := _9r_8_c59;
				self._9e_4_c59 := _9e_4_c59;
				// self._x11_1_c59_2 := _x11_1_c59_2;
				self._9a_2_c59 := _9a_2_c59;
				self.seg_s1_c65_b1 := seg_s1_c65_b1;
				self._x11_6_c65 := _x11_6_c65;
				self._9m_3_c65 := _9m_3_c65;
				self._9e_7_c65 := _9e_7_c65;
				self._9o_2_c65 := _9o_2_c65;
				self._9c_4_c65 := _9c_4_c65;
				self._26_1_c65 := _26_1_c65;
				self._9g_1_c65 := _9g_1_c65;
				self._ms_1_c65 := _ms_1_c65;
				self._9o_3_c65 := _9o_3_c65;
				self._9c_6_c65 := _9c_6_c65;
				self._9r_21_c65 := _9r_21_c65;
				self._x11_4_c65 := _x11_4_c65;
				self._9d_6_c65 := _9d_6_c65;
				self._9r_15_c65 := _9r_15_c65;
				self._9q_5_c65 := _9q_5_c65;
				self._mi_1_c65 := _mi_1_c65;
				self._9r_16_c65 := _9r_16_c65;
				self._9e_6_c65 := _9e_6_c65;
				self._9r_14_c65 := _9r_14_c65;
				self._9r_20_c65 := _9r_20_c65;
				self._9q_3_c65 := _9q_3_c65;
				self._x11_5_c65 := _x11_5_c65;
				self._9q_4_c65 := _9q_4_c65;
				self._9g_2_c65 := _9g_2_c65;
				self._9r_19_c65 := _9r_19_c65;
				self._9g_4_c65 := _9g_4_c65;
				self._9d_7_c65 := _9d_7_c65;
				self._9r_17_c65 := _9r_17_c65;
				self._9r_12_c65 := _9r_12_c65;
				self._9r_18_c65 := _9r_18_c65;
				self._9c_5_c65 := _9c_5_c65;
				self._9d_8_c65 := _9d_8_c65;
				self._9d_9_c65 := _9d_9_c65;
				self._x11_7_c65 := _x11_7_c65;
				self._9e_8_c65 := _9e_8_c65;
				self._9g_3_c65 := _9g_3_c65;
				self._9m_4_c65 := _9m_4_c65;
				self._9r_13_c65 := _9r_13_c65;
				self._pv_1_c65 := _pv_1_c65;
				self._9l_1_c65 := _9l_1_c65;
				self._9m_2_c65 := _9m_2_c65;
				self._9q_8_c66 := _9q_8_c66;
				self._9d_11_c66 := _9d_11_c66;
				self._9o_4_c66 := _9o_4_c66;
				self._9r_25_c66 := _9r_25_c66;
				self._9j_3_c66 := _9j_3_c66;
				self._9l_2_c66 := _9l_2_c66;
				self._9q_6_c66 := _9q_6_c66;
				self._9e_9_c66 := _9e_9_c66;
				self._9r_22_c66 := _9r_22_c66;
				self._9s_1_c66 := _9s_1_c66;
				self._9g_5_c66 := _9g_5_c66;
				self._pv_2_c66 := _pv_2_c66;
				self._9a_4_c66 := _9a_4_c66;
				self._9d_12_c66 := _9d_12_c66;
				self._9a_6_c66 := _9a_6_c66;
				self._27_2_c66 := _27_2_c66;
				self._ms_2_c66 := _ms_2_c66;
				self._9r_24_c66 := _9r_24_c66;
				self._9c_7_c66 := _9c_7_c66;
				self._9e_11_c66 := _9e_11_c66;
				self._9e_10_c66 := _9e_10_c66;
				self._x11_8_c66 := _x11_8_c66;
				self._9q_7_c66 := _9q_7_c66;
				self._9m_5_c66 := _9m_5_c66;
				self._x11_9_c66 := _x11_9_c66;
				self._52_1_c66 := _52_1_c66;
				self._9r_26_c66 := _9r_26_c66;
				self._9a_5_c66 := _9a_5_c66;
				self._9a_3_c66 := _9a_3_c66;
				self._9j_4_c66 := _9j_4_c66;
				self._9c_8_c66 := _9c_8_c66;
				self._9d_10_c66 := _9d_10_c66;
				self._9r_23_c66 := _9r_23_c66;
				// self._x11_1_c66_1 := _x11_1_c66_1;
				// self._x11_1_c67_b1_4 := _x11_1_c67_b1_4;
				// self._x11_1_c67_b1_3 := _x11_1_c67_b1_3;
				// self._x11_1_c67_b1_2 := _x11_1_c67_b1_2;
				// self._x11_1_c67_b1_1 := _x11_1_c67_b1_1;
				// self._9d_14_c67 := _9d_14_c67;
				// self._pv_3_c67 := _pv_3_c67;
				// self._27_3_c67 := _27_3_c67;
				// self._38_1_c67 := _38_1_c67;
				// self._9q_9_c67 := _9q_9_c67;
				// self._9c_10_c67 := _9c_10_c67;
				// self._9r_27_c67 := _9r_27_c67;
				// self._9r_33_c67 := _9r_33_c67;
				// self._9m_6_c67 := _9m_6_c67;
				// self._9g_6_c67 := _9g_6_c67;
				// self._9a_7_c67 := _9a_7_c67;
				// self._9e_12_c67 := _9e_12_c67;
				// self._9r_28_c67 := _9r_28_c67;
				// self._9d_13_c67 := _9d_13_c67;
				// self._9d_15_c67 := _9d_15_c67;
				// self._9c_9_c67 := _9c_9_c67;
				// self._9o_5_c67 := _9o_5_c67;
				// self._9r_31_c67 := _9r_31_c67;
				// self._9q_10_c67 := _9q_10_c67;
				// self._9r_30_c67 := _9r_30_c67;
				// self._9r_32_c67 := _9r_32_c67;
				// self._mi_2_c67 := _mi_2_c67;
				// self._9e_14_c67 := _9e_14_c67;
				// self._ms_3_c67 := _ms_3_c67;
				// self._9q_11_c67 := _9q_11_c67;
				// self._x11_1_c67 := _x11_1_c67;
				// self._9c_11_c67 := _9c_11_c67;
				// self._9j_5_c67 := _9j_5_c67;
				// self._9e_13_c67 := _9e_13_c67;
				// self._25_2_c67 := _25_2_c67;
				// self._9r_29_c67 := _9r_29_c67;
				self._9h := _9h;
				self._9c := _9c;
				self._26 := _26;
				self._mi := _mi;
				self._9u := _9u;
				self._9j := _9j;
				self._9o := _9o;
				self._9t := _9t;
				self._9e := _9e;
				self._28 := _28;
				self._9w := _9w;
				self._9m := _9m;
				self._ev := _ev;
				self._38 := _38;
				self._pv := _pv;
				self._97 := _97;
				self._9r := _9r;
				self._9q := _9q;
				self._9l := _9l;
				self._9g := _9g;
				self._9s := _9s;
				self._x11 := _x11;
				self._52 := _52;
				self._98 := _98;
				self._27 := _27;
				self._ms := _ms;
				self._9k := _9k;
				self._9a := _9a;
				self._25 := _25;
				self._49 := _49;
				self._9d := _9d;
				// self.ds_layout := ds_layout;
				// self.rc_dataset := rc_dataset;
				// self.rcs_top4 := rcs_top4;
				// self.rv40_rc1_c68_b3_2 := rv40_rc1_c68_b3_2;
				// self.rv40_rc2_c68_b3 := rv40_rc2_c68_b3;
				// self.rv40_rc3_c68_b3 := rv40_rc3_c68_b3;
				// self.rv40_rc4_c68_b3 := rv40_rc4_c68_b3;
				// self.rv40_rc5_c68_b3_1 := rv40_rc5_c68_b3_1;
				// self.rv40_rc1_c69_1 := rv40_rc1_c69_1;
				// self.rv40_rc5_c71 := rv40_rc5_c71;
				// self.rv40_rc5_c70 := rv40_rc5_c70;
				// self.rv40_rc1_c72 := rv40_rc1_c72;
				// self.rv40_rc4 := rv40_rc4;
				// self.rv40_rc5 := rv40_rc5;
				// self.rv40_rc1 := rv40_rc1;
				// self.rv40_rc2 := rv40_rc2;
				// self.rv40_rc3 := rv40_rc3;


				self.rc1 := rcs_final[1].rc;
				self.rc2 := rcs_final[2].rc;
				self.rc3 := rcs_final[3].rc;
				self.rc4 := rcs_final[4].rc;
				self.rc5 := rcs_final[5].rc;
				
				self.glrc25 := glrc25;
				self.glrc26 := glrc26;
				self.glrc27 := glrc27;
				self.glrc28 := glrc28;
				self.glrc38 := glrc38;
				self.glrc49 := glrc49;
				self.glrc52 := glrc52;
				self.glrc97 := glrc97;
				self.glrc98 := glrc98;
				self.glrc9a := glrc9a;
				self.glrc9c := glrc9c;
				self.glrc9d := glrc9d;
				self.glrc9e := glrc9e;
				self.glrc9g := glrc9g;
				self.glrc9h := glrc9h;
				self.glrc9j := glrc9j;
				self.glrc9k := glrc9k;
				self.glrc9l := glrc9l;
				self.glrc9m := glrc9m;
				self.glrc9o := glrc9o;
				self.glrc9q := glrc9q;
				self.glrc9r := glrc9r;
				self.glrc9s := glrc9s;
				// self.glrc9t := glrc9t;
				// self.glrc9u := glrc9u;
				// self.glrc9w := glrc9w;
				// self.glrcev := glrcev;
				// self.glrcmi := glrcmi;
				// self.glrcms := glrcms;

				self.rc1_rc := rcs_final[1].rc;
				self.rc2_rc := rcs_final[2].rc;
				self.rc3_rc := rcs_final[3].rc;
				self.rc4_rc := rcs_final[4].rc;
				self.rc5_rc := rcs_final[5].rc;

			self.clam := le;
		#end
		
		
		self.seq := le.seq;
		
		riTemp := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		rcs_final_desc := project( rcs_final, transform( risk_indicators.Layout_Desc,
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
			rcs_final_desc
		);
		zeros := dataset( [ {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc);
		self.ri := choosen( ri & zeros, 5 );

		self.score := map(
			riTemp[1].hri in ['91','92','93','94'] => (string3)((integer)riTemp[1].hri + 10),
			risk_indicators.rcSet.isCode95(PreScreenOptOut) => '222',
			self.ri[1].hri='35' => '100',
			(string3)(integer)rvr1103
		);
		
	END;
	
	model := project( clam, doModel(left) );
	
	return model;
END;

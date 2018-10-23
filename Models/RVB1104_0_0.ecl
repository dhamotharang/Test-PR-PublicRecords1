import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVB1104_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPreScreenOptOut ) := FUNCTION

	RVB_DEBUG := false;

	#if(RVB_DEBUG)
		debug_layout := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String out_addr_type;
			String out_addr_status;
			String in_dob;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String NAP_Status;
			Boolean rc_input_addr_not_most_recent;
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
			String rc_pwssnvalflag;
			String rc_addrvalflag;
			String rc_dwelltype;
			String rc_bansflag;
			String rc_addrcommflag;
			String rc_hrisksic;
			String rc_phonetype;
			Integer combo_dobscore;
			qstring100 ver_sources;
			qstring200 ver_sources_first_seen;
			qstring200 ver_sources_last_seen;
			qstring100 ver_dob_sources;
			String ssnlength;
			Boolean dobpop;
			Boolean add1_house_number_match;
			String add1_advo_address_vacancy;
			String add1_advo_throw_back;
			String add1_advo_seasonal_delivery;
			String add1_advo_college;
			String add1_advo_drop;
			String add1_advo_res_or_business;
			String add1_advo_mixed_address_usage;
			Integer add1_avm_automated_valuation;
			Integer add1_naprop;
			String add1_mortgage_type;
			String add1_financing_type;
			Integer add1_date_first_seen;
			Integer property_owned_total;
			Integer property_owned_purchase_count;
			Integer property_sold_total;
			Integer addrs_5yr;
			Boolean addrs_prison_history;
			Boolean addr_hist_advo_college;
			String telcordia_type;
			String gong_did_first_seen;
			Integer header_first_seen;
			Integer ssns_per_adl;
			Integer phones_per_adl;
			Integer adlPerSSN_count;
			Integer ssns_per_addr;
			Integer phones_per_addr;
			Integer adls_per_phone;
			Integer ssns_per_adl_c6;
			Integer phones_per_adl_c6;
			Integer addrs_per_ssn_c6;
			Integer adls_per_addr_c6;
			Integer ssns_per_addr_c6;
			Integer phones_per_addr_c6;
			Integer adls_per_phone_c6;
			String inq_first_log_date;
			Integer inq_count03;
			Integer inq_count06;
			Integer inq_count12;
			Integer inq_peradl;
			Integer inq_peraddr;
			Integer inq_adlsperphone;
			Integer infutor_nap;
			Integer impulse_count;
			Integer email_count;
			Integer email_domain_free_count;
			qstring50 email_source_list;
			Integer attr_addrs_last90;
			Integer attr_addrs_last12;
			Integer attr_addrs_last24;
			Integer attr_addrs_last36;
			Integer attr_total_number_derogs;
			Integer attr_num_unrel_liens180;
			Integer attr_num_unrel_liens12;
			Integer attr_num_unrel_liens24;
			Integer attr_num_unrel_liens60;
			Integer attr_eviction_count;
			Integer attr_eviction_count180;
			Integer attr_eviction_count12;
			Integer attr_eviction_count24;
			Integer attr_num_nonderogs90;
			Boolean Bankrupt;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer criminal_count;
			Integer felony_count;
			String ams_class;
			String ams_college_code;
			String ams_college_tier;
			String prof_license_category;
			String input_dob_match_level;
			Integer inferred_age;
			Integer estimated_income;
			Integer archive_date;

			Integer sysdate;
			Integer in_dob2;
			Real yr_in_dob;
			Integer add1_date_first_seen2;
			Real mth_add1_date_first_seen;
			Integer gong_did_first_seen2;
			Real mth_gong_did_first_seen;
			Integer header_first_seen2;
			Real mth_header_first_seen;
			Integer ver_src_ba_pos;
			Boolean ver_src_ba;
			Integer ver_src_ds_pos;
			Boolean ver_src_ds;
			Integer ver_src_en_pos;
			String ver_src_fdate_en;
			Integer ver_src_fdate_en2;
			Real mth_ver_src_fdate_en;
			String ver_src_ldate_en;
			Integer ver_src_ldate_en2;
			Real mth_ver_src_ldate_en;
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
			Boolean ver_src_p;
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
			Integer ver_dob_src_en_pos;
			Boolean ver_dob_src_en;
			Integer ver_dob_src_eq_pos;
			Boolean ver_dob_src_eq;
			Integer ver_dob_src_pl_pos;
			Boolean ver_dob_src_pl;
			Integer ver_dob_src_vo_pos;
			Boolean ver_dob_src_vo;
			Integer ver_dob_src_w_pos;
			Boolean ver_dob_src_w;
			Integer ver_dob_src_wp_pos;
			Boolean ver_dob_src_wp;
			Integer email_src_im_pos;
			Boolean email_src_im;
			String add_ec1;
			String add_ec3;
			String add_ec4;
			Boolean phn_disconnected;
			Boolean phn_inval;
			Boolean phn_highrisk2;
			Boolean phn_notpots;
			Boolean phn_cell;
			Boolean phn_zipmismatch;
			Boolean ssn_issued18;
			Boolean ssn_deceased;
			Boolean ssn_adl_prob;
			Boolean impulse_flag;
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
			Integer pk_222_flag;
			String pk_segment_40;
			Integer pk_age_estimate_s0;
			Integer pk_age_estimate_s1;
			Integer pk_age_estimate_s2;
			Integer pk_age_estimate_s3;
			Integer pk_estimated_income_s0;
			Integer pk_estimated_income_s1;
			Integer pk_estimated_income_s2;
			Integer pk_estimated_income_s3;
			Integer pk_add1_avm_auto_val_s0;
			Integer pk_add1_avm_auto_val_s1;
			Integer pk_add1_avm_auto_val_s2;
			Integer pk_add1_avm_auto_val_s3;
			Integer pk_verx_s0;
			Integer pk_verx_s1;
			Integer pk_verx_s3;
			Integer inq_first_log_date2;
			Real mth_inq_first_log_date;
			Integer pk_mth_inq_first_log_date;
			Integer pk_inq_recent_lvl;
			Integer pk_inq_recent_lvl_s0;
			Integer pk_inq_recent_lvl_s1;
			Integer pk_inq_recent_lvl_s3;
			Integer pk_mth_inq_frst_log_dt2_s2;
			Integer pk_impulse_flag;
			Integer pk_inq_peradl;
			Integer pk_inq_peradl_s0;
			Integer pk_inq_peraddr;
			Integer pk_inq_adlsperphone;
			Integer pk_inq_adlsperphone_s0;
			Integer pk_inq_adlsperphone_s3;
			Integer pk_mth_header_first_seen;
			Integer pk_mth_hdr_frst_sn_s2;
			Integer pk_dob_ver;
			Integer pk_attr_total_number_derogs;
			Integer pk_crim_fel_flag;
			Integer pk_eviction_lvl;
			Integer pk_unrel_lien_lvl;
			Integer pk_adlperssn_count_s1;
			Integer pk_adlperssn_count_s3;
			Integer pk_ssns_per_adl_s1;
			Integer pk_ssns_per_adl_s2;
			Integer pk_ssns_per_adl_s3;
			Integer pk_addrs_per_ssn_c6_s0;
			Integer pk_addrs_per_ssn_c6_s1;
			Integer pk_addrs_per_ssn_c6_s2;
			Integer pk_addrs_per_ssn_c6_s3;
			Integer pk_ssns_per_adl_c6;
			Integer pk_phones_per_adl_c6_s3;
			Integer pk_adls_per_addr_c6_s2;
			Integer pk_ssns_per_addr_c6_s0;
			Integer pk_ssns_per_addr_c6_s1;
			Integer pk_ssns_per_addr_c6_s3;
			Integer pk_phones_per_addr_c6;
			Integer pk_adls_per_phone_c6;
			Integer pk_attr_addrs_last12_s1;
			Integer pk_attr_addrs_last24_s0;
			Integer pk_attr_addrs_last36_s2;
			Integer pk_attr_addrs_last36_s3;
			Integer pk_recent_addr_s0;
			Integer pk_recent_addr_s2;
			Integer pk_phones_per_adl_s0;
			Integer pk_ssns_per_addr;
			Integer pk_phones_per_addr_s0;
			Integer pk_phones_per_addr_s2;
			Integer pk_phones_per_addr_s3;
			Integer pk_adls_per_phone;
			Integer pk_prof_lic_cat_s2;
			Integer pk_prof_lic_cat_s3;
			Integer pk_2nd_mortgage;
			Integer pk_baloon_mortgage;
			Integer pk_adj_finance;
			Integer pk_addrs_prison_history;
			Integer pk_ver_src_p;
			Integer pk_prop_owned_purch_flag;
			Integer pk_add1_naprop4;
			Integer pk_addrs_5yr_s0;
			Integer pk_addrs_5yr_s2;
			Integer pk_addrs_5yr_s3;
			Integer pk_email_count_s1;
			Integer pk_email_domain_free_count_s2;
			Integer pk_email_domain_free_count_s3;
			Integer pk_add_apt1;
			Integer pk_add_standarization_err;
			Integer pk_addr_changed;
			Integer pk_unit_changed;
			Integer pk_zip_po;
			Integer pk_zip_corp_mil;
			Integer pk_zip_hirisk_comm;
			Integer pk_add_inval;
			Integer pk_add_apt2;
			Integer pk_add_hirisk_comm;
			Integer pk_add1_advo_address_vacancy;
			Integer pk_add1_advo_throw_back;
			Integer pk_add1_advo_seasonal_delivery;
			Integer pk_add1_advo_college;
			Integer pk_add1_advo_drop;
			Integer pk_add1_advo_res_or_business;
			Integer pk_add1_advo_mixed_address_usage;
			Integer pk_addprob_s1;
			Integer pk_addprob_s2;
			Integer pk_addprob_s3;
			Integer pk_phn_nongeo;
			Integer pk_phn_phn_not_issued;
			Integer pk_phnprob_s2;
			Integer pk_grad_student;
			Integer pk_ams_senior;
			Integer pk_4yr_college;
			Integer pk_college_tier_s0;
			Integer pk_college_tier_s1;
			Integer pk_college_tier_s2;
			Integer pk_contrary_infutor_ver;
			Integer pk_num_nonderogs90_s0;
			Integer pk_mth_gong_did_fst_sn;
			Integer pk_mth_gong_did_fst_sn2_s0;
			Integer pk_mth_gong_did_fst_sn2_s1;
			Integer pk_mth_gong_did_fst_sn2_s2;
			Integer pk_mth_gong_did_fst_sn2_s3;
			Integer pk_mth_add1_date_fst_sn;
			Integer pk_mth_add1_date_fst_sn2_s3;
			Integer pk_mth_ver_src_fdate_en;
			Integer pk_mth_ver_src_fdate_eq;
			Integer pk_mth_ver_src_fdate_bureau;
			Boolean pk_too_young_at_bureau;
			Integer pk_addr_hist_advo_college;
			Integer pk_add1_house_number_match;
			Integer pk_nap_summary_ver_s1;
			Integer pk_pos_dob_src_minor;
			Boolean pk_pos_dob_src_minor_flag;
			Boolean ver_dob_src_bureau;
			Integer ver_dob_src_emerge;
			Integer pk_pos_dob_src_major;
			Integer pk_pos_dob_src_cnt_s2;
			Integer pk_mth_ver_src_ldate_en;
			Integer pk_mth_ver_src_ldate_eq;
			Integer pk_mth_ver_src_ldate_bureau;
			Integer pk_time_on_cb;
			Integer pk_time_on_cb2_s1;
			Integer pk_time_since_cb3;
			Real pk_age_estimate_s0_0m;
			Real pk_estimated_income_s0_0m;
			Real pk_add1_avm_auto_val_s0_0m;
			Real pk_age_estimate_s1_1m;
			Real pk_estimated_income_s1_1m;
			Real pk_add1_avm_auto_val_s1_1m;
			Real pk_age_estimate_s2_2m;
			Real pk_estimated_income_s2_2m;
			Real pk_add1_avm_auto_val_s2_2m;
			Real pk_age_estimate_s3_3m;
			Real pk_estimated_income_s3_3m;
			Real pk_add1_avm_auto_val_s3_3m;
			Real pk_verx_s0_0m;
			Real pk_verx_s1_1m;
			Real pk_verx_s3_3m;
			Real pk_inq_recent_lvl_s0_0m;
			Real pk_inq_peradl_s0_0m;
			Real pk_inq_adlsperphone_s0_0m;
			Real pk_inq_recent_lvl_s1_1m;
			Real pk_inq_peraddr_1m;
			Real pk_mth_inq_frst_log_dt2_s2_2m;
			Real pk_inq_recent_lvl_s3_3m;
			Real pk_inq_peraddr_3m;
			Real pk_inq_adlsperphone_s3_3m;
			Real pk_mth_hdr_frst_sn_s2_2m;
			Real pk_dob_ver_1m;
			Real pk_dob_ver_3m;
			Real pk_attr_total_number_derogs_0m;
			Real pk_crim_fel_flag_0m;
			Real pk_eviction_lvl_0m;
			Real pk_unrel_lien_lvl_0m;
			Real bankrupt_0m;
			Real pk_addrs_per_ssn_c6_s0_0m;
			Real pk_ssns_per_adl_c6_0m;
			Real pk_ssns_per_addr_c6_s0_0m;
			Real pk_attr_addrs_last24_s0_0m;
			Real pk_recent_addr_s0_0m;
			Real pk_phones_per_adl_s0_0m;
			Real pk_ssns_per_addr_0m;
			Real pk_phones_per_addr_s0_0m;
			Real pk_adlperssn_count_s1_1m;
			Real pk_ssns_per_adl_s1_1m;
			Real pk_addrs_per_ssn_c6_s1_1m;
			Real pk_ssns_per_adl_c6_1m;
			Real pk_ssns_per_addr_c6_s1_1m;
			Real pk_phones_per_addr_c6_1m;
			Real pk_attr_addrs_last12_s1_1m;
			Real pk_ssns_per_adl_s2_2m;
			Real pk_addrs_per_ssn_c6_s2_2m;
			Real pk_adls_per_addr_c6_s2_2m;
			Real pk_adls_per_phone_c6_2m;
			Real pk_attr_addrs_last36_s2_2m;
			Real pk_recent_addr_s2_2m;
			Real pk_ssns_per_addr_2m;
			Real pk_phones_per_addr_s2_2m;
			Real pk_adls_per_phone_2m;
			Real pk_adlperssn_count_s3_3m;
			Real pk_ssns_per_adl_s3_3m;
			Real pk_addrs_per_ssn_c6_s3_3m;
			Real pk_phones_per_adl_c6_s3_3m;
			Real pk_ssns_per_addr_c6_s3_3m;
			Real pk_phones_per_addr_c6_3m;
			Real pk_attr_addrs_last36_s3_3m;
			Real pk_phones_per_addr_s3_3m;
			Real pk_adls_per_phone_3m;
			Real pk_prof_lic_cat_s2_2m;
			Real pk_prof_lic_cat_s3_3m;
			Real pk_ver_src_p_0m;
			Real pk_prop_owned_purch_flag_0m;
			Real pk_add1_naprop4_0m;
			Real pk_ver_src_p_1m;
			Real pk_add1_naprop4_1m;
			Real pk_ver_src_p_3m;
			Real pk_addrs_5yr_s0_0m;
			Real pk_addrs_5yr_s2_2m;
			Real pk_addrs_5yr_s3_3m;
			Real pk_email_count_s1_1m;
			Real pk_email_domain_free_count_s2_2m;
			Real pk_email_domain_free_count_s3_3m;
			Real ssn_adl_prob_0m;
			Real ssn_issued18_0m;
			Real pk_addprob_s1_1m;
			Real ssn_issued18_1m;
			Real pk_addprob_s2_2m;
			Real pk_phnprob_s2_2m;
			Real pk_addprob_s3_3m;
			Real ssn_issued18_3m;
			Real pk_college_tier_s0_0m;
			Real pk_grad_student_1m;
			Real pk_ams_senior_1m;
			Real pk_college_tier_s1_1m;
			Real pk_grad_student_2m;
			Real pk_college_tier_s2_2m;
			Real pk_4yr_college_3m;
			Real pk_contrary_infutor_ver_1m;
			Real pk_contrary_infutor_ver_2m;
			Real pk_contrary_infutor_ver_3m;
			Real pk_num_nonderogs90_s0_0m;
			Real pk_mth_gong_did_fst_sn2_s0_0m;
			Real pk_mth_gong_did_fst_sn2_s1_1m;
			Real pk_too_young_at_bureau_1m;
			Real pk_addr_hist_advo_college_1m;
			Real pk_nap_summary_ver_s1_1m;
			Real pk_mth_gong_did_fst_sn2_s2_2m;
			Real pk_addr_hist_advo_college_2m;
			Real pk_add1_house_number_match_2m;
			Real pk_mth_gong_did_fst_sn2_s3_3m;
			Real pk_mth_add1_date_fst_sn2_s3_3m;
			Real pk_addr_hist_advo_college_3m;
			Real pk_add1_house_number_match_3m;
			Real pk_time_on_cb2_s1_1m;
			Real pk_time_since_cb3_1m;
			Real pk_pos_dob_src_cnt_s2_2m;
			Real derog_mod_0m;
			Real prop_owner_mod_0m;
			Real prop_owner_mod_1m;
			Real prop_owner_mod_3m;
			Real financing_mod_0m;
			Real financing_mod_2m;
			Real financing_mod_3m;
			Real email_mod_1m;
			Real email_mod_2m;
			Real email_mod_3m;
			Real fp_mod2_1m;
			Real ams_mod_0m;
			Real ams_mod_1m;
			Real ams_mod_2m;
			Real ams_mod_3m;
			Real inquiry_mod_0m;
			Real inquiry_mod_1m;
			Real inquiry_mod_2m;
			Real inquiry_mod_3m;
			Real velo_mod_0m;
			Real velo_mod_1m;
			Real velo_mod_2m;
			Real velo_mod_3m;
			Real mod8_0m;
			Real mod8_1m;
			Real mod8_2m;
			Real mod8_3m;
			Real mod8_nodob_0m;
			Real mod8_nodob_1m;
			Real mod8_nodob_2m;
			Real mod8_nodob_3m;
			Real mod8_nodob;
			Real mod8;
			Real mod8_phat;
			Integer mod8_scr;
			Real mod8_nodob_phat;
			Integer mod8_nodob_scr;
			Integer rvb1104a;
			Real rvb1104b;
			Boolean ov_ssndead;
			Boolean ov_ssnprior;
			Boolean ov_criminal_flag;
			Boolean ov_corrections;
			Boolean ov_impulse;
			Real rvb1104c;
			Boolean scored_222s;
			Real rvb1104d;
			Real rvb1104e;
			Real rvb1104;


			Real pk_em_domain_free_count_s2_2m;
			Real pk_em_domain_free_count_s3_3m;
			String rc1;
			Integer _rc1;
			String rc1_var;
			String rc2;
			Integer _rc2;
			String rc2_var;
			String rc3;
			Integer _rc3;
			String rc3_var;
			String rc4;
			Integer _rc4;
			String rc4_var;
			Integer ADD1_ASSESSED_AMOUNT;
			Integer glrc25;
			Integer glrc28;
			Integer glrc36;
			Integer glrc97;
			Integer glrc98;
			Boolean glrc99;
			Integer glrc9a;
			Integer glrc9c;
			Integer glrc9d;
			Integer glrc9e;
			Integer glrc9g;
			Integer glrc9h;
			Integer glrc9j;
			Integer glrc9m;
			Integer glrc9n;
			Integer glrc9q;
			Integer glrc9r;
			Integer glrc9s;
			Boolean phn_business;
			Integer glrc9t;
			Integer glrc9u;
			Integer glrc9w;
			Integer glrcev;
			Integer glrcmi;
			Integer glrcms;
			Integer aptflag_1;
			Integer aptflag;
			Integer add1_econval;
			Integer add1_aptval;
			String add1_econcode;
			Integer glrcpv;
			Integer glrcx11;
			Real m_financing_mod_2m;
			Real m_prop_owner_mod_3m;
			Real m_velo_mod_3m;
			Real m_inquiry_mod_2m;
			Real m_velo_mod_1m;
			Real m_email_mod_1m;
			Real m_prop_owner_mod_1m;
			Real m_fp_mod2_1m;
			Real m_email_mod_2m;
			Real m_inquiry_mod_0m;
			Real m_derog_mod_0m;
			Real m_velo_mod_2m;
			Real m_financing_mod_0m;
			Real m_inquiry_mod_3m;
			Real m_prop_owner_mod_0m;
			Real m_inquiry_mod_1m;
			Real m_email_mod_3m;
			Real m_financing_mod_3m;
			Real m_velo_mod_0m;
			Real seg_s0_crime_c37_b1;
			Real _97_0_c37;
			Real seg_s0_lien_c38_b1;
			Real _98_0_c38;
			Real seg_s0_eviction_c39_b1;
			Real _ev_0_c39;
			Real seg_s0_impulse_c40_b1;
			Real _9h_0_c40;
			Real seg_s0_bk_c41_b1;
			Real _9w_0_c41;
			Real _9d_3_c36;
			Real _9q_1_c36;
			Real _ev_1_c36;
			Real _x11_3_c36;
			Real _9h_1_c36;
			Real _9w_1_c36;
			Real _x11_2_c36;
			Real _9g_1_c36;
			Real _9s_1_c36;
			Real _36_1_c36;
			Real _ms_1_c36;
			Real _9a_1_c36;
			Real _9w_0_c36;
			Real _x11_4_c36;
			Real _9e_1_c36;
			Real _98_0_c36;
			Real _97_1_c36;
			Real _9m_1_c36;
			Real _ms_2_c36;
			Real _9q_3_c36;
			Real _98_1_c36;
			Real _ev_0_c36;
			Real _9q_2_c36;
			Real _9h_0_c36;
			Real _9d_2_c36;
			Real _9d_1_c36;
			Real _9d_4_c36;
			Real _9n_1_c36;
			Real _9a_3_c36;
			Real _9r_1_c36;
			Real _pv_1_c36;
			Real _97_0_c36;
			Real _x11_1_c36;
			Real _9a_2_c36;
			Real _9u_1_c43;
			Real seg_s1_c42_b1;
			Real _x11_5_c42;
			Real _x11_6_c42;
			Real _9q_4_c42;
			Real _9g_2_c42;
			Real _9g_4_c42;
			Real _9r_5_c42;
			Real _9e_2_c42;
			Real _9r_4_c42;
			Real _ms_4_c42;
			Real _9r_3_c42;
			Real _pv_2_c42;
			Real _9a_4_c42;
			Real _9d_6_c42;
			Real _9g_3_c42;
			Real _28_1_c42;
			Real _36_2_c42;
			Real _9q_5_c42;
			Real _9a_5_c42;
			Real _mi_1_c42;
			Real _9u_1_c42;
			Real _9r_2_c42;
			Real _9d_5_c42;
			Real _ms_3_c42;
			Real _9m_2_c42;
			Real _9m_3_c44;
			Real _28_2_c44;
			Real _pv_3_c44;
			Real _ms_5_c44;
			Real _9d_7_c44;
			Real _9q_6_c44;
			Real _x11_8_c44;
			Real _9u_2_c44;
			Real _9s_2_c44;
			Real _25_1_c44;
			Real _x11_9_c44;
			Real _9d_8_c44;
			Real _9g_5_c44;
			Real _9r_6_c44;
			Real _x11_7_c44;
			Real _9d_9_c44;
			Real _99_1_c44;
			Real _9s_4_c44;
			Real _x11_11_c44;
			Real _9r_7_c44;
			Real _9s_3_c44;
			Real _x11_10_c44;
			Real _9t_1_c44;
			Real _9r_8_c44;
			Real _9d_10_c44;
			Real seg_s3_c45_b1;
			Real _ms_6_c45;
			Real _9q_8_c45;
			Real _x11_14_c45;
			Real _x11_15_c45;
			Real _9d_11_c45;
			Real _pv_4_c45;
			Real _9q_9_c45;
			Real _9u_3_c45;
			Real _9r_9_c45;
			Real _9a_7_c45;
			Real _9q_7_c45;
			Real _9d_13_c45;
			Real _x11_13_c45;
			Real _9r_11_c45;
			Real _9s_5_c45;
			Real _9c_1_c45;
			Real _9d_12_c45;
			Real _9a_6_c45;
			Real _9m_4_c45;
			Real _x11_12_c45;
			Real _28_3_c45;
			Real _36_3_c45;
			Real _x11_16_c45;
			Real _9r_10_c45;
			Real _9s_6_c45;
			Real _mi_2_c45;
			Real _25_2_c45;
			Real seg_s0_crime_c47_b1;
			Real Seg_S0_Crime;
			Real _97_0_c47;
			Real seg_s0_lien_c48_b1;
			Real Seg_S0_Lien;
			Real _98_0_c48;
			Real seg_s0_eviction_c49_b1;
			Real seg_s0_eviction;
			Real _ev_0_c49;
			Real seg_s0_impulse_c50_b1;
			Real seg_s0_impulse;
			Real _9h_0_c50;
			Real seg_s0_bk_c51_b1;
			Real seg_s0_bk;
			Real _9w_0_c51;
			Real _9d_3_c46;
			Real _9q_1_c46;
			Real _ev_1_c46;
			Real _x11_3_c46;
			Real _9h_1_c46;
			Real _9w_1_c46;
			Real _x11_2_c46;
			Real _9g_1_c46;
			Real _9s_1_c46;
			Real _36_1_c46;
			Real _ms_1_c46;
			Real _9a_1_c46;
			Real _9w_0_c46;
			Real _x11_4_c46;
			Real _9e_1_c46;
			Real _98_0_c46;
			Real _97_1_c46;
			Real _9m_1_c46;
			Real _ms_2_c46;
			Real _9q_3_c46;
			Real _98_1_c46;
			Real _ev_0_c46;
			Real _9q_2_c46;
			Real _9h_0_c46;
			Real _9d_2_c46;
			Real _9d_1_c46;
			Real _9d_4_c46;
			Real _9n_1_c46;
			Real _9a_3_c46;
			Real _9r_1_c46;
			Real _pv_1_c46;
			Real _97_0_c46;
			Real _x11_1_c46;
			Real _9a_2_c46;
			Real seg_s1_c52_b1;
			Real _x11_5_c52;
			Real _x11_6_c52;
			Real _9q_4_c52;
			Real _9g_2_c52;
			Real _9r_4_c52;
			Real _9e_2_c52;
			Real _ms_4_c52;
			Real _9r_3_c52;
			Real _pv_2_c52;
			Real _9a_4_c52;
			Real _9d_6_c52;
			Real _36_2_c52;
			Real _9q_5_c52;
			Real _9g_3_c52;
			Real _9a_5_c52;
			Real _mi_1_c52;
			Real _9u_1_c52;
			Real _9r_2_c52;
			Real _9d_5_c52;
			Real _mi_2_c52;
			Real _ms_3_c52;
			Real _9m_2_c52;
			Real _9m_3_c53;
			Real _9r_5_c53;
			Real _9g_4_c53;
			Real _pv_3_c53;
			Real _ms_5_c53;
			Real _9d_7_c53;
			Real _9q_6_c53;
			Real _x11_8_c53;
			Real _9u_2_c53;
			Real _9s_2_c53;
			Real _25_1_c53;
			Real _x11_9_c53;
			Real _9d_8_c53;
			Real _9r_6_c53;
			Real _x11_7_c53;
			Real _9d_9_c53;
			Real _99_1_c53;
			Real _9s_4_c53;
			Real _x11_11_c53;
			Real _9r_7_c53;
			Real _9s_3_c53;
			Real _x11_10_c53;
			Real _9t_1_c53;
			Real _9d_10_c53;
			Real seg_s3_c54_b1;
			Real _ms_6_c54;
			Real _9q_8_c54;
			Real _x11_14_c54;
			Real _x11_15_c54;
			Real _mi_3_c54;
			Real _9d_11_c54;
			Real _pv_4_c54;
			Real _9q_9_c54;
			Real _9u_3_c54;
			Real _9a_7_c54;
			Real _9r_9_c54;
			Real _9q_7_c54;
			Real _9d_13_c54;
			Real _x11_13_c54;
			Real _ms_7_c54;
			Real _9s_5_c54;
			Real _9g_5_c54;
			Real _9d_12_c54;
			Real _9a_6_c54;
			Real _9m_4_c54;
			Real _x11_12_c54;
			Real _36_3_c54;
			Real _x11_16_c54;
			Real _9r_10_c54;
			Real _9s_6_c54;
			Real _9r_8_c54;
			Real _25_2_c54;
			Real _ms_6;
			Real _9q_8;
			Real _9m_3;
			Real _9d_11;
			Real _9d_3;
			Real _9q_9;
			Real _9q_1;
			Real _9q_6;
			Real _9u_3;
			Real _9a_7;
			Real _ev_1;
			Real _9w_1;
			Real _25_1;
			Real _9s_1;
			Real _x11_13;
			Real _9a_1;
			Real _ms_1;
			Real _36_1;
			Real _9s_5;
			Real _9q_5;
			Real _99_1;
			Real _9a_6;
			Real _x11_12;
			Real _98_0;
			Real _9s_3;
			Real _ms_2;
			Real _mi_2;
			Real _x11_5;
			Real _9q_3;
			Real _ev_0;
			Real _9q_4;
			Real _9q_2;
			Real _9g_2;
			Real _9g_4;
			Real _ms_5;
			Real _9u_2;
			Real _9s_2;
			Real _9d_4;
			Real _ms_7;
			Real _9n_1;
			Real _36_2;
			Real _9a_5;
			Real _x11_11;
			Real _9m_4;
			Real _9r_7;
			Real _36_3;
			Real _97_0;
			Real _9d_5;
			Real _x11_10;
			Real _9r_8;
			Real _9d_10;
			Real _x11_1;
			Real _x11_6;
			Real _pv_4;
			Real _9r_5;
			Real _9r_4;
			Real _9e_2;
			Real _x11_3;
			Real _9h_1;
			Real _9d_13;
			Real _ms_4;
			Real _x11_2;
			Real _9g_1;
			Real _9r_3;
			Real _9r_11;
			Real _pv_2;
			Real _9g_5;
			Real _9r_6;
			Real _9a_4;
			Real _9w_0;
			Real _9d_6;
			Real _x11_4;
			Real _9c_1;
			Real _9e_1;
			Real _9d_12;
			Real _mi_1;
			Real _97_1;
			Real _9u_1;
			Real _9m_1;
			Real _x11_16;
			Real _9r_10;
			Real _9t_1;
			Real _98_1;
			Real _x11_14;
			Real _x11_15;
			Real _mi_3;
			Real _9h_0;
			Real _9j_0;
			Real _9j_1;
			Real _28_2;
			Real _pv_3;
			Real _9d_2;
			Real _9d_7;
			Real _9d_1;
			Real _9r_9;
			Real _x11_8;
			Real _9q_7;
			Real _x11_9;
			Real _9d_8;
			Real _x11_7;
			Real _9d_9;
			Real _28_1;
			Real _9g_3;
			Real _9s_4;
			Real _9a_3;
			Real _28_3;
			Real _9r_1;
			Real _pv_1;
			Real _9r_2;
			Real _9s_6;
			Real _ms_3;
			Real _9m_2;
			Real _9a_2;
			Real _25_2;
			Real _25;
			Real _28;
			Real _36;
			Real _97;
			Real _98;
			Real _99;
			Real _9a;
			Real _9c;
			Real _9d;
			Real _9e;
			Real _9g;
			Real _9h;
			Real _9j;
			Real _9m;
			Real _9n;
			Real _9q;
			Real _9r;
			Real _9s;
			Real _9t;
			Real _9u;
			Real _9w;
			Real _ev;
			Real _mi;
			Real _ms;
			Real _pv;
			Real _x11;
			//data rc_dataset;
			
			string2 rc1_rc := '';
			string2 rc2_rc := '';
			string2 rc3_rc := '';
			string2 rc4_rc := '';
			string2 rc5_rc := '';
			real4 rc1_value := 0.0;
			real4 rc2_value := 0.0;
			real4 rc3_value := 0.0;
			real4 rc4_value := 0.0;
			real4 rc5_value := 0.0;

			Models.Layout_ModelOut;
		end;
		debug_layout doModel( clam le ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end



		truedid                          := le.truedid;
		out_addr_type                    := le.shell_input.addr_type;
		out_addr_status                  := le.shell_input.addr_status;
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
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_phonetype                     := le.iid.phonetype;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
		ver_dob_sources                  := le.header_summary.ver_dob_sources;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
		add1_advo_college                := le.advo_input_addr.college_indicator;
		add1_advo_drop                   := le.advo_input_addr.drop_indicator;
		add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
		add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
		property_sold_total              := le.address_verification.sold.property_total;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_prison_history             := le.other_address_info.isprison;
		addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		inq_first_log_date               := le.acc_logs.first_log_date;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_peradl                       := le.acc_logs.inquiryperadl;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
		attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
		attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		ams_class                        := le.student.class;
		ams_college_code                 := le.student.college_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		estimated_income                 := le.estimated_income;
		archive_date                     := le.historydate;









		NULL := -999999999;


		sysdate := map(
			trim((string)archive_date, LEFT, RIGHT) = '999999'  => Models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
			length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																   NULL);

		in_dob2 := Models.common.sas_date((string)(in_dob));

		yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);

		add1_date_first_seen2 := Models.common.sas_date((string)(add1_date_first_seen));

		mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 30.5);

		gong_did_first_seen2 := Models.common.sas_date((string)(gong_did_first_seen));

		mth_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

		header_first_seen2 := Models.common.sas_date((string)(header_first_seen));

		mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

		ver_src_ba_pos := Models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := Models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_en_pos := Models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

		ver_src_fdate_en := if(ver_src_en_pos > 0, Models.common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

		ver_src_fdate_en2 := Models.common.sas_date((string)(ver_src_fdate_en));

		mth_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 30.5);

		ver_src_ldate_en := if(ver_src_en_pos > 0, Models.common.getw(ver_sources_last_seen, ver_src_en_pos), '0');

		ver_src_ldate_en2 := Models.common.sas_date((string)(ver_src_ldate_en));

		mth_ver_src_ldate_en := if(min(sysdate, ver_src_ldate_en2) = NULL, NULL, (sysdate - ver_src_ldate_en2) / 30.5);

		ver_src_eq_pos := Models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

		ver_src_fdate_eq2 := Models.common.sas_date((string)(ver_src_fdate_eq));

		mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

		ver_src_ldate_eq := if(ver_src_eq_pos > 0, Models.common.getw(ver_sources_last_seen, ver_src_eq_pos), '0');

		ver_src_ldate_eq2 := Models.common.sas_date((string)(ver_src_ldate_eq));

		mth_ver_src_ldate_eq := if(min(sysdate, ver_src_ldate_eq2) = NULL, NULL, (sysdate - ver_src_ldate_eq2) / 30.5);

		ver_src_l2_pos := Models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_li_pos := Models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		ver_src_p_pos := Models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		ver_src_p := ver_src_p_pos > 0;

		ver_dob_src_ak_pos := Models.common.findw_cpp(ver_dob_sources, 'AK' , ' ,', 'ie');

		ver_dob_src_ak := ver_dob_src_ak_pos > 0;

		ver_dob_src_am_pos := Models.common.findw_cpp(ver_dob_sources, 'AM' , ' ,', 'ie');

		ver_dob_src_am := ver_dob_src_am_pos > 0;

		ver_dob_src_ar_pos := Models.common.findw_cpp(ver_dob_sources, 'AR' , ' ,', 'ie');

		ver_dob_src_ar := ver_dob_src_ar_pos > 0;

		ver_dob_src_cg_pos := Models.common.findw_cpp(ver_dob_sources, 'CG' , ' ,', 'ie');

		ver_dob_src_cg := ver_dob_src_cg_pos > 0;

		ver_dob_src_eb_pos := Models.common.findw_cpp(ver_dob_sources, 'EB' , ' ,', 'ie');

		ver_dob_src_eb := ver_dob_src_eb_pos > 0;

		ver_dob_src_em_pos := Models.common.findw_cpp(ver_dob_sources, 'EM' , ' ,', 'ie');

		ver_dob_src_em := ver_dob_src_em_pos > 0;

		ver_dob_src_e1_pos := Models.common.findw_cpp(ver_dob_sources, 'E1' , ' ,', 'ie');

		ver_dob_src_e1 := ver_dob_src_e1_pos > 0;

		ver_dob_src_e2_pos := Models.common.findw_cpp(ver_dob_sources, 'E2' , ' ,', 'ie');

		ver_dob_src_e2 := ver_dob_src_e2_pos > 0;

		ver_dob_src_e3_pos := Models.common.findw_cpp(ver_dob_sources, 'E3' , ' ,', 'ie');

		ver_dob_src_e3 := ver_dob_src_e3_pos > 0;

		ver_dob_src_e4_pos := Models.common.findw_cpp(ver_dob_sources, 'E4' , ' ,', 'ie');

		ver_dob_src_e4 := ver_dob_src_e4_pos > 0;

		ver_dob_src_en_pos := Models.common.findw_cpp(ver_dob_sources, 'EN' , ' ,', 'ie');

		ver_dob_src_en := ver_dob_src_en_pos > 0;

		ver_dob_src_eq_pos := Models.common.findw_cpp(ver_dob_sources, 'EQ' , ' ,', 'ie');

		ver_dob_src_eq := ver_dob_src_eq_pos > 0;

		ver_dob_src_pl_pos := Models.common.findw_cpp(ver_dob_sources, 'PL' , ' ,', 'ie');

		ver_dob_src_pl := ver_dob_src_pl_pos > 0;

		ver_dob_src_vo_pos := Models.common.findw_cpp(ver_dob_sources, 'VO' , ' ,', 'ie');

		ver_dob_src_vo := ver_dob_src_vo_pos > 0;

		ver_dob_src_w_pos := Models.common.findw_cpp(ver_dob_sources, 'W' , ' ,', 'ie');

		ver_dob_src_w := ver_dob_src_w_pos > 0;

		ver_dob_src_wp_pos := Models.common.findw_cpp(ver_dob_sources, 'WP' , ' ,', 'ie');

		ver_dob_src_wp := ver_dob_src_wp_pos > 0;

		email_src_im_pos := Models.common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		email_src_im := email_src_im_pos > 0;

		add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

		add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

		add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

		phn_disconnected := rc_hriskphoneflag = (string)5;

		phn_inval := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']);

		phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

		phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

		phn_cell := (rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']);

		phn_zipmismatch := rc_phonezipflag = (string)1 or rc_pwphonezipflag = (string)1;

		ssn_issued18 := rc_pwssnvalflag = (string)5;

		ssn_deceased := rc_decsflag = (string)1 or (integer)ver_src_ds = 1;

		ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

		impulse_flag := impulse_count > 0;

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

		scored_222s_1 := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		pk_222_flag := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 1, 0);

		pk_segment_40 := map(
			(integer)ssn_deceased > 0                            => 'X 200  ',
			pk_222_flag = 1                                      => 'X 222  ',
			bs_attr_derog_flag2 = 1                              => '0 Derog',
			pk_age_estimate <= 24                                => '1 Young',
			pk_property_owner = 1                                => '2 Owner',
																	'3 Other');

		pk_age_estimate_s0 := map(
			pk_age_estimate <= 20 => 0,
			pk_age_estimate <= 22 => 1,
			pk_age_estimate <= 27 => 2,
			pk_age_estimate <= 30 => 3,
			pk_age_estimate <= 33 => 4,
			pk_age_estimate <= 47 => 5,
			pk_age_estimate <= 61 => 6,
									 7);

		pk_age_estimate_s1 := map(
			pk_age_estimate <= 18 => 0,
			pk_age_estimate <= 19 => 1,
			pk_age_estimate <= 20 => 2,
			pk_age_estimate <= 21 => 3,
			pk_age_estimate <= 23 => 4,
									 5);

		pk_age_estimate_s2 := map(
			pk_age_estimate <= 27 => 0,
			pk_age_estimate <= 30 => 1,
			pk_age_estimate <= 34 => 2,
			pk_age_estimate <= 38 => 3,
			pk_age_estimate <= 47 => 4,
			pk_age_estimate <= 56 => 5,
									 6);

		pk_age_estimate_s3 := map(
			pk_age_estimate <= 32 => 0,
			pk_age_estimate <= 40 => 1,
			pk_age_estimate <= 47 => 2,
			pk_age_estimate <= 54 => 3,
									 4);

		pk_estimated_income_s0 := map(
			estimated_income <= 20000  => 0,
			estimated_income <= 23000  => 1,
			estimated_income <= 25000  => 2,
			estimated_income <= 27000  => 3,
			estimated_income <= 30000  => 4,
			estimated_income <= 35000  => 5,
			estimated_income <= 95000  => 6,
			estimated_income <= 125000 => 7,
										  8);

		pk_estimated_income_s1 := map(
			estimated_income <= 20000 => 0,
			estimated_income <= 21000 => 1,
			estimated_income <= 24000 => 2,
			estimated_income <= 25000 => 3,
			estimated_income <= 28000 => 4,
			estimated_income <= 30000 => 5,
			estimated_income <= 35000 => 6,
			estimated_income <= 40000 => 7,
			estimated_income <= 55000 => 8,
			estimated_income <= 70000 => 9,
			estimated_income <= 95000 => 10,
										 11);

		pk_estimated_income_s2 := map(
			estimated_income <= 35000  => 0,
			estimated_income <= 45000  => 1,
			estimated_income <= 80000  => 2,
			estimated_income <= 155000 => 3,
										  4);

		pk_estimated_income_s3 := map(
			estimated_income <= 21000  => 0,
			estimated_income <= 24000  => 1,
			estimated_income <= 27000  => 2,
			estimated_income <= 29000  => 3,
			estimated_income <= 100000 => 4,
										  5);

		pk_add1_avm_auto_val_s0 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 50000  => 0,
			add1_avm_automated_valuation <= 80000  => 1,
			add1_avm_automated_valuation <= 200000 => 2,
			add1_avm_automated_valuation <= 420000 => 3,
													  4);

		pk_add1_avm_auto_val_s1 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 70000  => 0,
			add1_avm_automated_valuation <= 100000 => 1,
			add1_avm_automated_valuation <= 180000 => 2,
			add1_avm_automated_valuation <= 220000 => 3,
			add1_avm_automated_valuation <= 320000 => 4,
			add1_avm_automated_valuation <= 560000 => 5,
													  6);

		pk_add1_avm_auto_val_s2 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 90000  => 0,
			add1_avm_automated_valuation <= 140000 => 1,
			add1_avm_automated_valuation <= 240000 => 2,
			add1_avm_automated_valuation <= 480000 => 3,
													  4);

		pk_add1_avm_auto_val_s3 := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 80000  => 0,
			add1_avm_automated_valuation <= 340000 => 1,
			add1_avm_automated_valuation <= 500000 => 2,
													  3);

		pk_verx_s0 := map(
			(nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 4,
			(nas_summary in [10, 11, 12]) and nap_summary = 0                  => 2,
			(nas_summary in [10, 11, 12]) and nap_summary = 1                  => 1,
			(nas_summary in [10, 11, 12])                                      => 3,
			nap_summary = 12                                                   => 1,
			(nap_summary in [9, 10, 11])                                       => 1,
																				  0);

		pk_verx_s1 := map(
			(nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 2,
			(nas_summary in [10, 11, 12]) and nap_summary = 0                  => 1,
			(nas_summary in [10, 11, 12]) and nap_summary = 1                  => 0,
			(nas_summary in [10, 11, 12])                                      => 1,
			nap_summary = 12                                                   => 0,
			(nap_summary in [9, 10, 11])                                       => 0,
																				  0);

		pk_verx_s3 := map(
			(nas_summary in [10, 11, 12]) and (nap_summary in [9, 10, 11, 12]) => 4,
			(nas_summary in [10, 11, 12]) and nap_summary = 0                  => 2,
			(nas_summary in [10, 11, 12]) and nap_summary = 1                  => 1,
			(nas_summary in [10, 11, 12])                                      => 3,
			nap_summary = 12                                                   => 1,
			(nap_summary in [9, 10, 11])                                       => 1,
																				  0);

		inq_first_log_date2 := Models.common.sas_date((string)(inq_first_log_date));

		mth_inq_first_log_date := if(min(sysdate, inq_first_log_date2) = NULL, NULL, (sysdate - inq_first_log_date2) / 30.5);

		pk_mth_inq_first_log_date := if (mth_inq_first_log_date >= 0, roundup(mth_inq_first_log_date), truncate(mth_inq_first_log_date));

		pk_inq_recent_lvl := map(
			inq_count03 >= 2 => 4,
			inq_count06 >= 2 => 3,
			inq_count12 >= 2 => 2,
			inq_count03 >= 1 => 2,
			inq_count06 >= 1 => 1,
			inq_count12 >= 1 => 1,
								0);

		pk_inq_recent_lvl_s0 := pk_inq_recent_lvl;

		pk_inq_recent_lvl_s1 := pk_inq_recent_lvl;

		pk_inq_recent_lvl_s3 := pk_inq_recent_lvl;

		pk_mth_inq_frst_log_dt2_s2 := map(
			pk_mth_inq_first_log_date = NULL => 0,
			pk_mth_inq_first_log_date <= 3   => 2,
			pk_mth_inq_first_log_date <= 12  => 1,
												0);

		pk_impulse_flag := if((integer)impulse_flag > 0 or (integer)email_src_im > 0, 1, 0);

		pk_inq_peradl := map(
			inq_count12 = 0 => -1,
			inq_peradl <= 0 => 0,
			inq_peradl <= 1 => 1,
							   2);

		pk_inq_peradl_s0 := pk_inq_peradl;

		pk_inq_peraddr := map(
			inq_count12 = 0  => -1,
			inq_peraddr <= 0 => 0,
			inq_peraddr <= 1 => 1,
			inq_peraddr <= 2 => 2,
								3);

		pk_inq_adlsperphone := map(
			inq_count12 = 0       => -1,
			inq_adlsperphone <= 0 => 0,
			inq_adlsperphone <= 1 => 1,
									 2);

		pk_inq_adlsperphone_s0 := pk_inq_adlsperphone;

		pk_inq_adlsperphone_s3 := pk_inq_adlsperphone;

		pk_mth_header_first_seen := if (mth_header_first_seen >= 0, roundup(mth_header_first_seen), truncate(mth_header_first_seen));

		pk_mth_hdr_frst_sn_s2 := map(
			pk_mth_header_first_seen <= 72  => 0,
			pk_mth_header_first_seen <= 96  => 1,
			pk_mth_header_first_seen <= 144 => 2,
			pk_mth_header_first_seen <= 168 => 3,
			pk_mth_header_first_seen <= 192 => 4,
			pk_mth_header_first_seen <= 240 => 5,
											   6);

		pk_dob_ver := if(combo_dobscore = 100, 1, 0);

		pk_attr_total_number_derogs := map(
			attr_total_number_derogs <= 0 => 0,
			attr_total_number_derogs <= 1 => 1,
			attr_total_number_derogs <= 2 => 2,
											 3);

		pk_crim_fel_flag := map(
			criminal_count >= 2 or felony_count >= 1 => 2,
			criminal_count >= 1                      => 1,
														0);

		pk_eviction_lvl := map(
			attr_eviction_count180 > 0 => 4,
			attr_eviction_count12 > 0  => 3,
			attr_eviction_count24 > 0  => 2,
			attr_eviction_count > 0    => 1,
										  0);

		pk_unrel_lien_lvl := map(
			attr_num_unrel_liens180 >= 1 or attr_num_unrel_liens12 >= 2 => 3,
			attr_num_unrel_liens12 >= 1 or attr_num_unrel_liens24 >= 2  => 2,
			attr_num_unrel_liens60 >= 1                                 => 1,
																		   0);

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

		pk_ssns_per_adl_s1 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
								 1);

		pk_ssns_per_adl_s2 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
								 1);

		pk_ssns_per_adl_s3 := map(
			ssns_per_adl <= 0 => -1,
			ssns_per_adl <= 1 => 0,
			ssns_per_adl <= 2 => 1,
								 2);

		pk_addrs_per_ssn_c6_s0 := map(
			addrs_per_ssn_c6 <= 0 => 0,
			addrs_per_ssn_c6 <= 1 => 1,
									 2);

		pk_addrs_per_ssn_c6_s1 := map(
			addrs_per_ssn_c6 <= 0 => 0,
			addrs_per_ssn_c6 <= 1 => 1,
									 2);

		pk_addrs_per_ssn_c6_s2 := if(addrs_per_ssn_c6 <= 0, 0, 2);

		pk_addrs_per_ssn_c6_s3 := map(
			addrs_per_ssn_c6 <= 0 => 0,
			addrs_per_ssn_c6 <= 1 => 1,
									 2);

		pk_ssns_per_adl_c6 := map(
			ssns_per_adl_c6 <= 0 => 0,
			ssns_per_adl_c6 <= 1 => 1,
									2);

		pk_phones_per_adl_c6_s3 := map(
			phones_per_adl_c6 <= 0 => 0,
			phones_per_adl_c6 <= 1 => 1,
									  2);

		pk_adls_per_addr_c6_s2 := map(
			adls_per_addr_c6 <= 0 => 0,
			adls_per_addr_c6 <= 1 => 1,
			adls_per_addr_c6 <= 2 => 2,
			adls_per_addr_c6 <= 3 => 3,
			adls_per_addr_c6 <= 4 => 4,
									 5);

		pk_ssns_per_addr_c6_s0 := map(
			ssns_per_addr_c6 <= 0 => 0,
			ssns_per_addr_c6 <= 1 => 1,
			ssns_per_addr_c6 <= 2 => 2,
			ssns_per_addr_c6 <= 3 => 3,
			ssns_per_addr_c6 <= 4 => 4,
									 5);

		pk_ssns_per_addr_c6_s1 := map(
			ssns_per_addr_c6 <= 0 => 0,
			ssns_per_addr_c6 <= 1 => 1,
			ssns_per_addr_c6 <= 2 => 2,
			ssns_per_addr_c6 <= 3 => 3,
									 4);

		pk_ssns_per_addr_c6_s3 := map(
			ssns_per_addr_c6 <= 0 => 0,
			ssns_per_addr_c6 <= 1 => 1,
			ssns_per_addr_c6 <= 2 => 2,
			ssns_per_addr_c6 <= 3 => 3,
			ssns_per_addr_c6 <= 4 => 4,
									 5);

		pk_phones_per_addr_c6 := if(phones_per_addr_c6 <= 0, 0, 1);

		pk_adls_per_phone_c6 := if(adls_per_phone_c6 <= 0, 0, 1);

		pk_attr_addrs_last12_s1 := if(attr_addrs_last12 <= 0, 0, 1);

		pk_attr_addrs_last24_s0 := map(
			attr_addrs_last24 <= 0 => 0,
			attr_addrs_last24 <= 1 => 1,
			attr_addrs_last24 <= 2 => 2,
			attr_addrs_last24 <= 3 => 3,
									  4);

		pk_attr_addrs_last36_s2 := map(
			attr_addrs_last36 <= 0 => 0,
			attr_addrs_last36 <= 1 => 1,
			attr_addrs_last36 <= 2 => 2,
			attr_addrs_last36 <= 3 => 3,
			attr_addrs_last36 <= 4 => 4,
			attr_addrs_last36 <= 5 => 5,
									  6);

		pk_attr_addrs_last36_s3 := if(attr_addrs_last36 <= 0, 0, 1);

		pk_recent_addr_s0 := map(
			attr_addrs_last90 > 0 => 4,
			attr_addrs_last12 > 0 => 3,
			attr_addrs_last24 > 0 => 2,
			attr_addrs_last36 > 0 => 1,
									 0);

		pk_recent_addr_s2 := map(
			attr_addrs_last90 > 0 => 4,
			attr_addrs_last12 > 0 => 3,
			attr_addrs_last24 > 0 => 2,
			attr_addrs_last36 > 0 => 1,
									 0);

		pk_phones_per_adl_s0 := if(phones_per_adl <= 0, 0, 1);

		pk_ssns_per_addr := if(ssns_per_addr <= 19, 0, 1);

		pk_phones_per_addr_s0 := map(
			phones_per_addr <= 0 => -1,
			phones_per_addr <= 1 => 0,
			phones_per_addr <= 2 => 1,
									2);

		pk_phones_per_addr_s2 := map(
			phones_per_addr <= 0 => -1,
			phones_per_addr <= 1 => 0,
			phones_per_addr <= 2 => 1,
									2);

		pk_phones_per_addr_s3 := map(
			phones_per_addr <= 0 => -1,
			phones_per_addr <= 1 => 0,
			phones_per_addr <= 2 => 1,
									2);

		pk_adls_per_phone := if(adls_per_phone <= 0, 0, 1);

		pk_prof_lic_cat_s2 := map(
			prof_license_category >= (string)5 => 5,
			prof_license_category >= (string)4 => 4,
			prof_license_category >= (string)3 => 3,
			prof_license_category >= (string)2 => 2,
			prof_license_category >= (string)0 => 1,
												  0);

		pk_prof_lic_cat_s3 := map(
			prof_license_category >= (string)5 => 4,
			prof_license_category >= (string)4 => 3,
			prof_license_category >= (string)3 => 2,
			prof_license_category >= (string)0 => 1,
												  0);

		pk_2nd_mortgage := if(trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) = '2', 1, 0);

		pk_baloon_mortgage := if(trim(trim(add1_mortgage_type, LEFT), LEFT, RIGHT) = 'H', 1, 0);

		pk_adj_finance := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

		pk_addrs_prison_history := if((integer)addrs_prison_history > 0, 1, 0);

		pk_ver_src_p := if(ver_src_P, 1, 0);

		pk_prop_owned_purch_flag := if(property_owned_purchase_count > 0, 1, 0);

		pk_add1_naprop4 := if(add1_naprop = 4, 1, 0);

		pk_addrs_5yr_s0 := map(
			addrs_5yr <= 0 => 0,
			addrs_5yr <= 1 => 1,
			addrs_5yr <= 4 => 2,
			addrs_5yr <= 6 => 3,
							  4);

		pk_addrs_5yr_s2 := map(
			addrs_5yr <= 0 => 0,
			addrs_5yr <= 1 => 1,
			addrs_5yr <= 4 => 2,
			addrs_5yr <= 6 => 3,
							  4);

		pk_addrs_5yr_s3 := if(addrs_5yr <= 0, 0, 1);

		pk_email_count_s1 := map(
			email_count <= 1 => 0,
			email_count <= 2 => 1,
			email_count <= 3 => 2,
			email_count <= 4 => 3,
								4);

		pk_email_domain_free_count_s2 := map(
			email_domain_free_count <= 0 => 0,
			email_domain_free_count <= 1 => 1,
			email_domain_free_count <= 2 => 2,
											3);

		pk_email_domain_free_count_s3 := map(
			email_domain_free_count <= 0 => 0,
			email_domain_free_count <= 1 => 1,
			email_domain_free_count <= 2 => 2,
											3);

		pk_add_apt1 := if(trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H', 1, 0);

		pk_add_standarization_err := if(trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E', 1, 0);

		pk_addr_changed := if(add_ec1 = 'S' and add_ec3 != '0', 1, 0);

		pk_unit_changed := if(add_ec1 = 'S' and add_ec4 != '0', 1, 0);

		pk_zip_po := if(rc_hriskaddrflag = (string)1, 1, 0);

		pk_zip_corp_mil := if((rc_hriskaddrflag in ['2', '3']), 1, 0);

		pk_zip_hirisk_comm := if(rc_hriskaddrflag = (string)4, 1, 0);

		pk_add_inval := if(trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N', 1, 0);

		pk_add_apt2 := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, 0);

		pk_add_hirisk_comm := if(rc_addrcommflag = (string)2, 1, 0);

		pk_add1_advo_address_vacancy := if(trim(trim((string)add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

		pk_add1_advo_throw_back := if(trim(trim((string)add1_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

		pk_add1_advo_seasonal_delivery := if(trim(trim((string)add1_advo_seasonal_delivery, LEFT), LEFT, RIGHT) = 'E', 1, 0);

		pk_add1_advo_college := if(trim(trim((string)add1_advo_college, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

		pk_add1_advo_drop := if(trim(trim((string)add1_advo_drop, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

		pk_add1_advo_res_or_business := if(trim(trim((string)add1_advo_res_or_business, LEFT), LEFT, RIGHT) = 'B', 1, 0);

		pk_add1_advo_mixed_address_usage := if((trim(trim((string)add1_advo_mixed_address_usage, LEFT), LEFT, RIGHT) in ['A', '']), 0, 1);

		pk_addprob_s1 := map(
			pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 2,
			pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 1,
			pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 1,
			pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
																																													   0);

		pk_addprob_s2 := map(
			pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 4,
			pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 3,
			pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 2,
			pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
																																													   0);

		pk_addprob_s3 := map(
			pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1                                                                                       => 4,
			pk_add1_advo_throw_back = 1 or pk_add_apt1 = 1 or pk_add_apt2 = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 => 3,
			pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1                                                                             => 2,
			pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1 or pk_unit_changed = 1 or pk_addr_changed = 1                                                            => 1,
																																													   0);

		pk_phn_nongeo := if(trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '7', 1, 0);

		pk_phn_phn_not_issued := if(rc_pwphonezipflag = (string)4, 1, 0);

		pk_phnprob_s2 := map(
			(integer)phn_cell = 1                                                                                                                                                                                                                                  => 2,
			trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' or pk_phn_nongeo = 1 or pk_phn_phn_not_issued = 1 or (integer)phn_disconnected = 1 or (integer)phn_inval = 1 or (integer)phn_highrisk2 = 1 or (integer)phn_zipmismatch = 1 or (integer)phn_notpots = 1 => 1,
																																																																	  0);

		pk_grad_student := if(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'GR', 1, 0);

		pk_ams_senior := if(trim(trim(ams_class, LEFT), LEFT, RIGHT) = 'SR', 1, 0);

		pk_4yr_college := if(ams_college_code = (string)4, 1, 0);

		pk_college_tier_s0 := map(
			(ams_college_tier in ['0', '1', '2']) => 3,
			(ams_college_tier in ['3'])           => 2,
			(ams_college_tier in ['4'])           => 1,
															  0);

		pk_college_tier_s1 := map(
			(ams_college_tier in ['0', '1', '2']) => 3,
			(ams_college_tier in ['3'])           => 2,
			(ams_college_tier in ['4'])           => 1,
															  0);

		pk_college_tier_s2 := map(
			(ams_college_tier in ['0', '1', '2']) => 2,
			(ams_college_tier in ['3', '4'])      => 1,
															  0);

		pk_contrary_infutor_ver := if((infutor_nap in [1, 6]), 1, 0);

		pk_num_nonderogs90_s0 := map(
			attr_num_nonderogs90 <= 1 => 0,
			attr_num_nonderogs90 <= 2 => 1,
			attr_num_nonderogs90 <= 3 => 2,
			attr_num_nonderogs90 <= 4 => 3,
										 4);

		pk_mth_gong_did_fst_sn := if (mth_gong_did_first_seen >= 0, roundup(mth_gong_did_first_seen), truncate(mth_gong_did_first_seen));

		pk_mth_gong_did_fst_sn2_s0 := map(
			pk_mth_gong_did_fst_sn = NULL => -1,
			pk_mth_gong_did_fst_sn >= 72  => 3,
			pk_mth_gong_did_fst_sn >= 24  => 2,
			pk_mth_gong_did_fst_sn >= 6   => 1,
											 0);

		pk_mth_gong_did_fst_sn2_s1 := map(
			pk_mth_gong_did_fst_sn = NULL => -1,
			pk_mth_gong_did_fst_sn >= 24  => 2,
			pk_mth_gong_did_fst_sn >= 6   => 1,
											 0);

		pk_mth_gong_did_fst_sn2_s2 := map(
			pk_mth_gong_did_fst_sn = NULL => -1,
			pk_mth_gong_did_fst_sn >= 72  => 3,
			pk_mth_gong_did_fst_sn >= 24  => 2,
			pk_mth_gong_did_fst_sn >= 6   => 1,
											 0);

		pk_mth_gong_did_fst_sn2_s3 := map(
			pk_mth_gong_did_fst_sn = NULL => -1,
			pk_mth_gong_did_fst_sn >= 72  => 3,
			pk_mth_gong_did_fst_sn >= 24  => 2,
			pk_mth_gong_did_fst_sn >= 6   => 1,
											 0);

		pk_mth_add1_date_fst_sn := if (mth_add1_date_first_seen >= 0, roundup(mth_add1_date_first_seen), truncate(mth_add1_date_first_seen));

		pk_mth_add1_date_fst_sn2_s3 := map(
			pk_mth_add1_date_fst_sn = NULL => -1,
			pk_mth_add1_date_fst_sn >= 120 => 5,
			pk_mth_add1_date_fst_sn >= 60  => 4,
			pk_mth_add1_date_fst_sn >= 36  => 3,
			pk_mth_add1_date_fst_sn >= 12  => 2,
			pk_mth_add1_date_fst_sn >= 6   => 1,
											  0);

		pk_mth_ver_src_fdate_en := if (mth_ver_src_fdate_en >= 0, roundup(mth_ver_src_fdate_en), truncate(mth_ver_src_fdate_en));

		pk_mth_ver_src_fdate_eq := if (mth_ver_src_fdate_eq >= 0, roundup(mth_ver_src_fdate_eq), truncate(mth_ver_src_fdate_eq));

		pk_mth_ver_src_fdate_bureau := max(pk_mth_ver_src_fdate_eq, pk_mth_ver_src_fdate_en);

		pk_too_young_at_bureau := truncate(pk_mth_ver_src_fdate_bureau / 12) > pk_age_estimate - 17;

		pk_addr_hist_advo_college := if(addr_hist_advo_college, 1, 0);

		pk_add1_house_number_match := if((integer)add1_house_number_match <= 0, 0, 1);

		pk_nap_summary_ver_s1 := map(
			nap_summary >= 10 => 1,
			nap_summary = 1   => -1,
								 0);

		pk_pos_dob_src_minor := if(max((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb) = NULL, NULL, sum((integer)ver_dob_src_ak, (integer)ver_dob_src_am, (integer)ver_dob_src_ar, (integer)ver_dob_src_cg, (integer)ver_dob_src_w, (integer)ver_dob_src_eb));

		pk_pos_dob_src_minor_flag := pk_pos_dob_src_minor > 0;

		ver_dob_src_bureau := ver_dob_src_en or ver_dob_src_eq;

		ver_dob_src_emerge := max((integer)ver_dob_src_em, (integer)(integer)ver_dob_src_e1, (integer)(integer)ver_dob_src_e2, (integer)(integer)ver_dob_src_e3, (integer)(integer)ver_dob_src_e4);

		pk_pos_dob_src_major := if(max(ver_dob_src_emerge, (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag) = NULL, NULL, sum(if(ver_dob_src_emerge = NULL, 0, ver_dob_src_emerge), (integer)ver_dob_src_bureau, (integer)ver_dob_src_pl, (integer)ver_dob_src_vo, (integer)ver_dob_src_wp, (integer)pk_pos_dob_src_minor_flag));

		pk_pos_dob_src_cnt_s2 := min(1, if(pk_pos_dob_src_major = NULL, -NULL, pk_pos_dob_src_major));

		pk_mth_ver_src_ldate_en := if (mth_ver_src_ldate_en >= 0, roundup(mth_ver_src_ldate_en), truncate(mth_ver_src_ldate_en));

		pk_mth_ver_src_ldate_eq := if (mth_ver_src_ldate_eq >= 0, roundup(mth_ver_src_ldate_eq), truncate(mth_ver_src_ldate_eq));

		pk_mth_ver_src_ldate_bureau := max(pk_mth_ver_src_ldate_eq, pk_mth_ver_src_ldate_en);

		// pk_time_on_cb := pk_mth_ver_src_fdate_bureau - pk_mth_ver_src_ldate_bureau;
		pk_time_on_cb := if( null in [pk_mth_ver_src_fdate_bureau, pk_mth_ver_src_ldate_bureau], NULL, pk_mth_ver_src_fdate_bureau - pk_mth_ver_src_ldate_bureau );

		pk_time_on_cb2_s1 := map(
			pk_time_on_cb = NULL => -1,
			pk_time_on_cb <= 6   => 0,
			pk_time_on_cb <= 12  => 1,
			pk_time_on_cb <= 24  => 2,
			pk_time_on_cb <= 36  => 3,
			pk_time_on_cb <= 48  => 4,
									5);

		pk_time_since_cb3 := map(
			pk_mth_ver_src_ldate_bureau = NULL => 0,
			pk_mth_ver_src_ldate_bureau <= 3   => 0,
												  1);

		pk_age_estimate_s0_0m := map(
			pk_age_estimate_s0 = 0 => 0.4766146993,
			pk_age_estimate_s0 = 1 => 0.1618705036,
			pk_age_estimate_s0 = 2 => 0.1191391238,
			pk_age_estimate_s0 = 3 => 0.0988654781,
			pk_age_estimate_s0 = 4 => 0.0784431138,
			pk_age_estimate_s0 = 5 => 0.0535984276,
			pk_age_estimate_s0 = 6 => 0.0340684956,
			pk_age_estimate_s0 = 7 => 0.0310559006,
									  0.0565434927);

		pk_estimated_income_s0_0m := map(
			pk_estimated_income_s0 = 0 => 0.178041543,
			pk_estimated_income_s0 = 1 => 0.1354883081,
			pk_estimated_income_s0 = 2 => 0.1189839572,
			pk_estimated_income_s0 = 3 => 0.0829896907,
			pk_estimated_income_s0 = 4 => 0.0653846154,
			pk_estimated_income_s0 = 5 => 0.0570987654,
			pk_estimated_income_s0 = 6 => 0.0389371862,
			pk_estimated_income_s0 = 7 => 0.0295995357,
			pk_estimated_income_s0 = 8 => 0.0161127895,
										  0.0565434927);

		pk_add1_avm_auto_val_s0_0m := map(
			pk_add1_avm_auto_val_s0 = -1 => 0.0677706449,
			pk_add1_avm_auto_val_s0 = 0  => 0.1101511879,
			pk_add1_avm_auto_val_s0 = 1  => 0.0801944107,
			pk_add1_avm_auto_val_s0 = 2  => 0.0598949212,
			pk_add1_avm_auto_val_s0 = 3  => 0.0422996333,
			pk_add1_avm_auto_val_s0 = 4  => 0.0341050021,
											0.0565434927);

		pk_age_estimate_s1_1m := map(
			pk_age_estimate_s1 = 0 => 0.1957849725,
			pk_age_estimate_s1 = 1 => 0.1385419692,
			pk_age_estimate_s1 = 2 => 0.096544158,
			pk_age_estimate_s1 = 3 => 0.0736484722,
			pk_age_estimate_s1 = 4 => 0.0511323838,
			pk_age_estimate_s1 = 5 => 0.0430183357,
									  0.0878498445);

		pk_estimated_income_s1_1m := map(
			pk_estimated_income_s1 = 0  => 0.1446933529,
			pk_estimated_income_s1 = 1  => 0.1263157895,
			pk_estimated_income_s1 = 2  => 0.1128469031,
			pk_estimated_income_s1 = 3  => 0.0954263128,
			pk_estimated_income_s1 = 4  => 0.0834858188,
			pk_estimated_income_s1 = 5  => 0.0768477729,
			pk_estimated_income_s1 = 6  => 0.06528,
			pk_estimated_income_s1 = 7  => 0.0562098501,
			pk_estimated_income_s1 = 8  => 0.0491905355,
			pk_estimated_income_s1 = 9  => 0.0419625565,
			pk_estimated_income_s1 = 10 => 0.0350194553,
			pk_estimated_income_s1 = 11 => 0.0440251572,
										   0.0878498445);

		pk_add1_avm_auto_val_s1_1m := map(
			pk_add1_avm_auto_val_s1 = -1 => 0.0956815016,
			pk_add1_avm_auto_val_s1 = 0  => 0.1577608142,
			pk_add1_avm_auto_val_s1 = 1  => 0.1178861789,
			pk_add1_avm_auto_val_s1 = 2  => 0.0978403141,
			pk_add1_avm_auto_val_s1 = 3  => 0.0941807044,
			pk_add1_avm_auto_val_s1 = 4  => 0.0756269592,
			pk_add1_avm_auto_val_s1 = 5  => 0.0498422713,
			pk_add1_avm_auto_val_s1 = 6  => 0.0362080316,
											0.0878498445);

		pk_age_estimate_s2_2m := map(
			pk_age_estimate_s2 = 0 => 0.0325741525,
			pk_age_estimate_s2 = 1 => 0.0285341595,
			pk_age_estimate_s2 = 2 => 0.0233476696,
			pk_age_estimate_s2 = 3 => 0.0193825813,
			pk_age_estimate_s2 = 4 => 0.014131362,
			pk_age_estimate_s2 = 5 => 0.0109003215,
			pk_age_estimate_s2 = 6 => 0.0074285867,
									  0.0140849078);

		pk_estimated_income_s2_2m := map(
			pk_estimated_income_s2 = 0 => 0.0178944229,
			pk_estimated_income_s2 = 1 => 0.0145617705,
			pk_estimated_income_s2 = 2 => 0.0128281981,
			pk_estimated_income_s2 = 3 => 0.0102739726,
			pk_estimated_income_s2 = 4 => 0.0064741036,
										  0.0140849078);

		pk_add1_avm_auto_val_s2_2m := map(
			pk_add1_avm_auto_val_s2 = -1 => 0.0152018172,
			pk_add1_avm_auto_val_s2 = 0  => 0.0249612403,
			pk_add1_avm_auto_val_s2 = 1  => 0.0179867987,
			pk_add1_avm_auto_val_s2 = 2  => 0.0148375451,
			pk_add1_avm_auto_val_s2 = 3  => 0.0121145374,
			pk_add1_avm_auto_val_s2 = 4  => 0.0093194418,
											0.0140849078);

		pk_age_estimate_s3_3m := map(
			pk_age_estimate_s3 = 0 => 0.0342703295,
			pk_age_estimate_s3 = 1 => 0.030909973,
			pk_age_estimate_s3 = 2 => 0.0269187301,
			pk_age_estimate_s3 = 3 => 0.0210030988,
			pk_age_estimate_s3 = 4 => 0.0164362118,
									  0.0270104534);

		pk_estimated_income_s3_3m := map(
			pk_estimated_income_s3 = 0 => 0.0428675666,
			pk_estimated_income_s3 = 1 => 0.0368736568,
			pk_estimated_income_s3 = 2 => 0.0308914387,
			pk_estimated_income_s3 = 3 => 0.0258293549,
			pk_estimated_income_s3 = 4 => 0.0213391108,
			pk_estimated_income_s3 = 5 => 0.0122282609,
										  0.0270104534);

		pk_add1_avm_auto_val_s3_3m := map(
			pk_add1_avm_auto_val_s3 = -1 => 0.0268399371,
			pk_add1_avm_auto_val_s3 = 0  => 0.0529925187,
			pk_add1_avm_auto_val_s3 = 1  => 0.0281143212,
			pk_add1_avm_auto_val_s3 = 2  => 0.0237699073,
			pk_add1_avm_auto_val_s3 = 3  => 0.019124424,
											0.0270104534);

		pk_verx_s0_0m := map(
			pk_verx_s0 = 0 => 0.1468058968,
			pk_verx_s0 = 1 => 0.0764248705,
			pk_verx_s0 = 2 => 0.0649536046,
			pk_verx_s0 = 3 => 0.0593320236,
			pk_verx_s0 = 4 => 0.0392888648,
							  0.0565434927);

		pk_verx_s1_1m := map(
			pk_verx_s1 = 0 => 0.1295222866,
			pk_verx_s1 = 1 => 0.0839347934,
			pk_verx_s1 = 2 => 0.063331649,
							  0.0878498445);

		pk_verx_s3_3m := map(
			pk_verx_s3 = 0 => 0.0553252838,
			pk_verx_s3 = 1 => 0.0426173052,
			pk_verx_s3 = 2 => 0.0316094932,
			pk_verx_s3 = 3 => 0.0291564173,
			pk_verx_s3 = 4 => 0.0163067733,
							  0.0270104534);

		pk_inq_recent_lvl_s0_0m := map(
			pk_inq_recent_lvl_s0 = 0 => 0.0510322723,
			pk_inq_recent_lvl_s0 = 1 => 0.1043478261,
			pk_inq_recent_lvl_s0 = 2 => 0.2363315697,
			pk_inq_recent_lvl_s0 = 3 => 0.4545454545,
			pk_inq_recent_lvl_s0 = 4 => 0.4769230769,
										0.0565434927);

		pk_inq_peradl_s0_0m := map(
			pk_inq_peradl_s0 = -1 => 0.0510322723,
			pk_inq_peradl_s0 = 0  => 0.0650406504,
			pk_inq_peradl_s0 = 1  => 0.1652816251,
			pk_inq_peradl_s0 = 2  => 0.4362416107,
									 0.0565434927);

		pk_inq_adlsperphone_s0_0m := map(
			pk_inq_adlsperphone_s0 = -1 => 0.0510322723,
			pk_inq_adlsperphone_s0 = 0  => 0.1265164645,
			pk_inq_adlsperphone_s0 = 1  => 0.2233285917,
			pk_inq_adlsperphone_s0 = 2  => 0.2933333333,
										   0.0565434927);

		pk_inq_recent_lvl_s1_1m := map(
			pk_inq_recent_lvl_s1 = 0 => 0.076869551,
			pk_inq_recent_lvl_s1 = 1 => 0.1034928849,
			pk_inq_recent_lvl_s1 = 2 => 0.1987951807,
			pk_inq_recent_lvl_s1 = 3 => 0.3333333333,
			pk_inq_recent_lvl_s1 = 4 => 0.3990147783,
										0.0878498445);

		pk_inq_peraddr_1m := map(
			pk_inq_peraddr = -1 => 0.076869551,
			pk_inq_peraddr = 0  => 0.1504424779,
			pk_inq_peraddr = 1  => 0.171286425,
			pk_inq_peraddr = 2  => 0.1875,
			pk_inq_peraddr = 3  => 0.4007782101,
								   0.0878498445);

		pk_mth_inq_frst_log_dt2_s2_2m := map(
			pk_mth_inq_frst_log_dt2_s2 = 0 => 0.0137038529,
			pk_mth_inq_frst_log_dt2_s2 = 1 => 0.036809816,
			pk_mth_inq_frst_log_dt2_s2 = 2 => 0.066552901,
											  0.0140849078);

		pk_inq_recent_lvl_s3_3m := map(
			pk_inq_recent_lvl_s3 = 0 => 0.0246590642,
			pk_inq_recent_lvl_s3 = 1 => 0.0700778643,
			pk_inq_recent_lvl_s3 = 2 => 0.1205673759,
			pk_inq_recent_lvl_s3 = 3 => 0.125,
			pk_inq_recent_lvl_s3 = 4 => 0.2173913043,
										0.0270104534);

		pk_inq_peraddr_3m := map(
			pk_inq_peraddr = -1 => 0.0246590642,
			pk_inq_peraddr = 0  => 0.0732356858,
			pk_inq_peraddr = 1  => 0.1082872928,
			pk_inq_peraddr = 2  => 0.134529148,
			pk_inq_peraddr = 3  => 0.1701030928,
								   0.0270104534);

		pk_inq_adlsperphone_s3_3m := map(
			pk_inq_adlsperphone_s3 = -1 => 0.0246590642,
			pk_inq_adlsperphone_s3 = 0  => 0.085106383,
			pk_inq_adlsperphone_s3 = 1  => 0.1070539419,
			pk_inq_adlsperphone_s3 = 2  => 0.1982758621,
										   0.0270104534);

		pk_mth_hdr_frst_sn_s2_2m := map(
			pk_mth_hdr_frst_sn_s2 = 0 => 0.0384740789,
			pk_mth_hdr_frst_sn_s2 = 1 => 0.0280804694,
			pk_mth_hdr_frst_sn_s2 = 2 => 0.0210875946,
			pk_mth_hdr_frst_sn_s2 = 3 => 0.0191352792,
			pk_mth_hdr_frst_sn_s2 = 4 => 0.016842578,
			pk_mth_hdr_frst_sn_s2 = 5 => 0.0143216167,
			pk_mth_hdr_frst_sn_s2 = 6 => 0.0099346299,
										 0.0140849078);

		pk_dob_ver_1m := map(
			pk_dob_ver = 0 => 0.1102297817,
			pk_dob_ver = 1 => 0.0693363999,
							  0.0878498445);

		pk_dob_ver_3m := map(
			pk_dob_ver = 0 => 0.0406756291,
			pk_dob_ver = 1 => 0.0234464902,
							  0.0270104534);

		pk_attr_total_number_derogs_0m := map(
			pk_attr_total_number_derogs = 0 => 0.0501858736,
			pk_attr_total_number_derogs = 1 => 0.0593814969,
			pk_attr_total_number_derogs = 2 => 0.0768251273,
			pk_attr_total_number_derogs = 3 => 0.098381071,
											   0.0565434927);

		pk_crim_fel_flag_0m := map(
			pk_crim_fel_flag = 0 => 0.0547007453,
			pk_crim_fel_flag = 1 => 0.065652522,
			pk_crim_fel_flag = 2 => 0.125748503,
									0.0565434927);

		pk_eviction_lvl_0m := map(
			pk_eviction_lvl = 0 => 0.0536455151,
			pk_eviction_lvl = 1 => 0.084989719,
			pk_eviction_lvl = 2 => 0.0968858131,
			pk_eviction_lvl = 3 => 0.1377245509,
			pk_eviction_lvl = 4 => 0.1941176471,
								   0.0565434927);

		pk_unrel_lien_lvl_0m := map(
			pk_unrel_lien_lvl = 0 => 0.0524842018,
			pk_unrel_lien_lvl = 1 => 0.0654168329,
			pk_unrel_lien_lvl = 2 => 0.0782997763,
			pk_unrel_lien_lvl = 3 => 0.1079478055,
									 0.0565434927);

		bankrupt_0m := map(
			(integer)bankrupt = 0 => 0.055950981,
			(integer)bankrupt = 1 => 0.0787037037,
									 0.0565434927);

		pk_addrs_per_ssn_c6_s0_0m := map(
			pk_addrs_per_ssn_c6_s0 = 0 => 0.052182623,
			pk_addrs_per_ssn_c6_s0 = 1 => 0.1150658216,
			pk_addrs_per_ssn_c6_s0 = 2 => 0.1404494382,
										  0.0565434927);

		pk_ssns_per_adl_c6_0m := map(
			pk_ssns_per_adl_c6 = 0 => 0.0496577474,
			pk_ssns_per_adl_c6 = 1 => 0.072160255,
			pk_ssns_per_adl_c6 = 2 => 0.1567944251,
									  0.0565434927);

		pk_ssns_per_addr_c6_s0_0m := map(
			pk_ssns_per_addr_c6_s0 = 0 => 0.0479833951,
			pk_ssns_per_addr_c6_s0 = 1 => 0.071100496,
			pk_ssns_per_addr_c6_s0 = 2 => 0.084078712,
			pk_ssns_per_addr_c6_s0 = 3 => 0.1081504702,
			pk_ssns_per_addr_c6_s0 = 4 => 0.15,
			pk_ssns_per_addr_c6_s0 = 5 => 0.2555555556,
										  0.0565434927);

		pk_attr_addrs_last24_s0_0m := map(
			pk_attr_addrs_last24_s0 = 0 => 0.0447368421,
			pk_attr_addrs_last24_s0 = 1 => 0.0694824509,
			pk_attr_addrs_last24_s0 = 2 => 0.0789641944,
			pk_attr_addrs_last24_s0 = 3 => 0.0808678501,
			pk_attr_addrs_last24_s0 = 4 => 0.1262729124,
										   0.0565434927);

		pk_recent_addr_s0_0m := map(
			pk_recent_addr_s0 = 0 => 0.0432328495,
			pk_recent_addr_s0 = 1 => 0.0507715281,
			pk_recent_addr_s0 = 2 => 0.0635507113,
			pk_recent_addr_s0 = 3 => 0.0735914143,
			pk_recent_addr_s0 = 4 => 0.102617366,
									 0.0565434927);

		pk_phones_per_adl_s0_0m := map(
			pk_phones_per_adl_s0 = 0 => 0.0667526604,
			pk_phones_per_adl_s0 = 1 => 0.0435080977,
										0.0565434927);

		pk_ssns_per_addr_0m := map(
			pk_ssns_per_addr = 0 => 0.0544585462,
			pk_ssns_per_addr = 1 => 0.0787900106,
									0.0565434927);

		pk_phones_per_addr_s0_0m := map(
			pk_phones_per_addr_s0 = -1 => 0.0581807725,
			pk_phones_per_addr_s0 = 0  => 0.048984306,
			pk_phones_per_addr_s0 = 1  => 0.0594892629,
			pk_phones_per_addr_s0 = 2  => 0.0748908297,
										  0.0565434927);

		pk_adlperssn_count_s1_1m := map(
			pk_adlperssn_count_s1 = -1 => 0.095890411,
			pk_adlperssn_count_s1 = 0  => 0.0847328244,
			pk_adlperssn_count_s1 = 1  => 0.0986083499,
			pk_adlperssn_count_s1 = 2  => 0.0990516333,
										  0.0878498445);

		pk_ssns_per_adl_s1_1m := map(
			pk_ssns_per_adl_s1 = -1 => 0.1458670989,
			pk_ssns_per_adl_s1 = 0  => 0.086062889,
			pk_ssns_per_adl_s1 = 1  => 0.0918315576,
									   0.0878498445);

		pk_addrs_per_ssn_c6_s1_1m := map(
			pk_addrs_per_ssn_c6_s1 = 0 => 0.0826655052,
			pk_addrs_per_ssn_c6_s1 = 1 => 0.1157246183,
			pk_addrs_per_ssn_c6_s1 = 2 => 0.1347962382,
										  0.0878498445);

		pk_ssns_per_adl_c6_1m := map(
			pk_ssns_per_adl_c6 = 0 => 0.0746622422,
			pk_ssns_per_adl_c6 = 1 => 0.1090270812,
			pk_ssns_per_adl_c6 = 2 => 0.156626506,
									  0.0878498445);

		pk_ssns_per_addr_c6_s1_1m := map(
			pk_ssns_per_addr_c6_s1 = 0 => 0.0677562778,
			pk_ssns_per_addr_c6_s1 = 1 => 0.1048498845,
			pk_ssns_per_addr_c6_s1 = 2 => 0.1261818182,
			pk_ssns_per_addr_c6_s1 = 3 => 0.1414048059,
			pk_ssns_per_addr_c6_s1 = 4 => 0.1536312849,
										  0.0878498445);

		pk_phones_per_addr_c6_1m := map(
			pk_phones_per_addr_c6 = 0 => 0.0840170509,
			pk_phones_per_addr_c6 = 1 => 0.103946102,
										 0.0878498445);

		pk_attr_addrs_last12_s1_1m := map(
			pk_attr_addrs_last12_s1 = 0 => 0.0725928619,
			pk_attr_addrs_last12_s1 = 1 => 0.1118089257,
										   0.0878498445);

		pk_ssns_per_adl_s2_2m := map(
			pk_ssns_per_adl_s2 = -1 => 0.0263157895,
			pk_ssns_per_adl_s2 = 0  => 0.0131222201,
			pk_ssns_per_adl_s2 = 1  => 0.0178780774,
									   0.0140849078);

		pk_addrs_per_ssn_c6_s2_2m := map(
			pk_addrs_per_ssn_c6_s2 = 0 => 0.0133419076,
			pk_addrs_per_ssn_c6_s2 = 2 => 0.0330937973,
										  0.0140849078);

		pk_adls_per_addr_c6_s2_2m := map(
			pk_adls_per_addr_c6_s2 = 0 => 0.0119689787,
			pk_adls_per_addr_c6_s2 = 1 => 0.01948116,
			pk_adls_per_addr_c6_s2 = 2 => 0.0234105155,
			pk_adls_per_addr_c6_s2 = 3 => 0.0305389222,
			pk_adls_per_addr_c6_s2 = 4 => 0.0407331976,
			pk_adls_per_addr_c6_s2 = 5 => 0.0637254902,
										  0.0140849078);

		pk_adls_per_phone_c6_2m := map(
			pk_adls_per_phone_c6 = 0 => 0.0171206452,
			pk_adls_per_phone_c6 = 1 => 0.0111842197,
										0.0140849078);

		pk_attr_addrs_last36_s2_2m := map(
			pk_attr_addrs_last36_s2 = 0 => 0.0100559976,
			pk_attr_addrs_last36_s2 = 1 => 0.016427289,
			pk_attr_addrs_last36_s2 = 2 => 0.0224276297,
			pk_attr_addrs_last36_s2 = 3 => 0.0263207019,
			pk_attr_addrs_last36_s2 = 4 => 0.0328125,
			pk_attr_addrs_last36_s2 = 5 => 0.0468018721,
			pk_attr_addrs_last36_s2 = 6 => 0.067833698,
										   0.0140849078);

		pk_recent_addr_s2_2m := map(
			pk_recent_addr_s2 = 0 => 0.0100559976,
			pk_recent_addr_s2 = 1 => 0.0160810006,
			pk_recent_addr_s2 = 2 => 0.0189860213,
			pk_recent_addr_s2 = 3 => 0.0233958134,
			pk_recent_addr_s2 = 4 => 0.0259854015,
									 0.0140849078);

		pk_ssns_per_addr_2m := map(
			pk_ssns_per_addr = 0 => 0.0134892288,
			pk_ssns_per_addr = 1 => 0.026433761,
									0.0140849078);

		pk_phones_per_addr_s2_2m := map(
			pk_phones_per_addr_s2 = -1 => 0.0160041569,
			pk_phones_per_addr_s2 = 0  => 0.011890263,
			pk_phones_per_addr_s2 = 1  => 0.0176896083,
			pk_phones_per_addr_s2 = 2  => 0.020051899,
										  0.0140849078);

		pk_adls_per_phone_2m := map(
			pk_adls_per_phone = 0 => 0.0200597182,
			pk_adls_per_phone = 1 => 0.0107968018,
									 0.0140849078);

		pk_adlperssn_count_s3_3m := map(
			pk_adlperssn_count_s3 = -1 => 0.037593985,
			pk_adlperssn_count_s3 = 0  => 0.0255366098,
			pk_adlperssn_count_s3 = 1  => 0.0288886086,
			pk_adlperssn_count_s3 = 2  => 0.0368585883,
										  0.0270104534);

		pk_ssns_per_adl_s3_3m := map(
			pk_ssns_per_adl_s3 = -1 => 0.0287474333,
			pk_ssns_per_adl_s3 = 0  => 0.0260587993,
			pk_ssns_per_adl_s3 = 1  => 0.0303092997,
			pk_ssns_per_adl_s3 = 2  => 0.0412757974,
									   0.0270104534);

		pk_addrs_per_ssn_c6_s3_3m := map(
			pk_addrs_per_ssn_c6_s3 = 0 => 0.0257084742,
			pk_addrs_per_ssn_c6_s3 = 1 => 0.042505087,
			pk_addrs_per_ssn_c6_s3 = 2 => 0.0803858521,
										  0.0270104534);

		pk_phones_per_adl_c6_s3_3m := map(
			pk_phones_per_adl_c6_s3 = 0 => 0.0290419517,
			pk_phones_per_adl_c6_s3 = 1 => 0.0217818539,
			pk_phones_per_adl_c6_s3 = 2 => 0.0212940213,
										   0.0270104534);

		pk_ssns_per_addr_c6_s3_3m := map(
			pk_ssns_per_addr_c6_s3 = 0 => 0.0223274821,
			pk_ssns_per_addr_c6_s3 = 1 => 0.0380358221,
			pk_ssns_per_addr_c6_s3 = 2 => 0.042204797,
			pk_ssns_per_addr_c6_s3 = 3 => 0.0559815951,
			pk_ssns_per_addr_c6_s3 = 4 => 0.0660592255,
			pk_ssns_per_addr_c6_s3 = 5 => 0.1078066914,
										  0.0270104534);

		pk_phones_per_addr_c6_3m := map(
			pk_phones_per_addr_c6 = 0 => 0.024502514,
			pk_phones_per_addr_c6 = 1 => 0.0373982547,
										 0.0270104534);

		pk_attr_addrs_last36_s3_3m := map(
			pk_attr_addrs_last36_s3 = 0 => 0.0196131273,
			pk_attr_addrs_last36_s3 = 1 => 0.0337372362,
										   0.0270104534);

		pk_phones_per_addr_s3_3m := map(
			pk_phones_per_addr_s3 = -1 => 0.0298539519,
			pk_phones_per_addr_s3 = 0  => 0.021727776,
			pk_phones_per_addr_s3 = 1  => 0.0307648483,
			pk_phones_per_addr_s3 = 2  => 0.031605001,
										  0.0270104534);

		pk_adls_per_phone_3m := map(
			pk_adls_per_phone = 0 => 0.0338609198,
			pk_adls_per_phone = 1 => 0.0207262387,
									 0.0270104534);

		pk_prof_lic_cat_s2_2m := map(
			pk_prof_lic_cat_s2 = 0 => 0.0145092731,
			pk_prof_lic_cat_s2 = 1 => 0.0141001855,
			pk_prof_lic_cat_s2 = 2 => 0.0138248848,
			pk_prof_lic_cat_s2 = 3 => 0.0127388535,
			pk_prof_lic_cat_s2 = 4 => 0.0090716078,
			pk_prof_lic_cat_s2 = 5 => 0.0058823529,
									  0.0140849078);

		pk_prof_lic_cat_s3_3m := map(
			pk_prof_lic_cat_s3 = 0 => 0.027853116,
			pk_prof_lic_cat_s3 = 1 => 0.0211459754,
			pk_prof_lic_cat_s3 = 2 => 0.0139771283,
			pk_prof_lic_cat_s3 = 3 => 0.0116883117,
			pk_prof_lic_cat_s3 = 4 => 0.0085959885,
									  0.0270104534);

		pk_ver_src_p_0m := map(
			pk_ver_src_p = 0 => 0.0936111111,
			pk_ver_src_p = 1 => 0.0386540352,
								0.0565434927);

		pk_prop_owned_purch_flag_0m := map(
			pk_prop_owned_purch_flag = 0 => 0.063502861,
			pk_prop_owned_purch_flag = 1 => 0.0352998656,
											0.0565434927);

		pk_add1_naprop4_0m := map(
			pk_add1_naprop4 = 0 => 0.0775136662,
			pk_add1_naprop4 = 1 => 0.0363378114,
								   0.0565434927);

		pk_ver_src_p_1m := map(
			pk_ver_src_p = 0 => 0.0907238734,
			pk_ver_src_p = 1 => 0.0515151515,
								0.0878498445);

		pk_add1_naprop4_1m := map(
			pk_add1_naprop4 = 0 => 0.090376569,
			pk_add1_naprop4 = 1 => 0.0547730829,
								   0.0878498445);

		pk_ver_src_p_3m := map(
			pk_ver_src_p = 0 => 0.0307300509,
			pk_ver_src_p = 1 => 0.0154871136,
								0.0270104534);

		pk_addrs_5yr_s0_0m := map(
			pk_addrs_5yr_s0 = 0 => 0.0414021049,
			pk_addrs_5yr_s0 = 1 => 0.0616986301,
			pk_addrs_5yr_s0 = 2 => 0.0632641719,
			pk_addrs_5yr_s0 = 3 => 0.0826446281,
			pk_addrs_5yr_s0 = 4 => 0.1025641026,
								   0.0565434927);

		pk_addrs_5yr_s2_2m := map(
			pk_addrs_5yr_s2 = 0 => 0.0092898878,
			pk_addrs_5yr_s2 = 1 => 0.013676897,
			pk_addrs_5yr_s2 = 2 => 0.020280278,
			pk_addrs_5yr_s2 = 3 => 0.0372037204,
			pk_addrs_5yr_s2 = 4 => 0.0486976217,
								   0.0140849078);

		pk_addrs_5yr_s3_3m := map(
			pk_addrs_5yr_s3 = 0 => 0.017539566,
			pk_addrs_5yr_s3 = 1 => 0.0321017432,
								   0.0270104534);

		pk_email_count_s1_1m := map(
			pk_email_count_s1 = 0 => 0.0876497315,
			pk_email_count_s1 = 1 => 0.0827464789,
			pk_email_count_s1 = 2 => 0.0943683409,
			pk_email_count_s1 = 3 => 0.1,
			pk_email_count_s1 = 4 => 0.1204188482,
									 0.0878498445);

		pk_email_domain_free_count_s2_2m := map(
			pk_email_domain_free_count_s2 = 0 => 0.0137043715,
			pk_email_domain_free_count_s2 = 1 => 0.0157808029,
			pk_email_domain_free_count_s2 = 2 => 0.0227617602,
			pk_email_domain_free_count_s2 = 3 => 0.0327868852,
												 0.0140849078);

		pk_email_domain_free_count_s3_3m := map(
			pk_email_domain_free_count_s3 = 0 => 0.0264255452,
			pk_email_domain_free_count_s3 = 1 => 0.0292780749,
			pk_email_domain_free_count_s3 = 2 => 0.0327983252,
			pk_email_domain_free_count_s3 = 3 => 0.0457038391,
												 0.0270104534);

		ssn_adl_prob_0m := map(
			(integer)ssn_adl_prob = 0 => 0.0549828179,
			(integer)ssn_adl_prob = 1 => 0.077186964,
										 0.0565434927);

		ssn_issued18_0m := map(
			(integer)ssn_issued18 = 0 => 0.0625974239,
			(integer)ssn_issued18 = 1 => 0.0397727273,
										 0.0565434927);

		pk_addprob_s1_1m := map(
			pk_addprob_s1 = 0 => 0.0832303718,
			pk_addprob_s1 = 1 => 0.0879845402,
			pk_addprob_s1 = 2 => 0.1631067961,
								 0.0878498445);

		ssn_issued18_1m := map(
			(integer)ssn_issued18 = 0 => 0.0892899176,
			(integer)ssn_issued18 = 1 => 0.0637319317,
										 0.0878498445);

		pk_addprob_s2_2m := map(
			pk_addprob_s2 = 0 => 0.0122826558,
			pk_addprob_s2 = 1 => 0.0140507795,
			pk_addprob_s2 = 2 => 0.018211534,
			pk_addprob_s2 = 3 => 0.0204901567,
			pk_addprob_s2 = 4 => 0.0613333333,
								 0.0140849078);

		pk_phnprob_s2_2m := map(
			pk_phnprob_s2 = 0 => 0.0110535714,
			pk_phnprob_s2 = 1 => 0.0224054111,
			pk_phnprob_s2 = 2 => 0.0277283666,
								 0.0140849078);

		pk_addprob_s3_3m := map(
			pk_addprob_s3 = 0 => 0.0212908634,
			pk_addprob_s3 = 1 => 0.0284013395,
			pk_addprob_s3 = 2 => 0.0288056725,
			pk_addprob_s3 = 3 => 0.0310133429,
			pk_addprob_s3 = 4 => 0.0575461455,
								 0.0270104534);

		ssn_issued18_3m := map(
			(integer)ssn_issued18 = 0 => 0.0277851051,
			(integer)ssn_issued18 = 1 => 0.0255796013,
										 0.0270104534);

		pk_college_tier_s0_0m := map(
			pk_college_tier_s0 = 0 => 0.0573688175,
			pk_college_tier_s0 = 1 => 0.0411184211,
			pk_college_tier_s0 = 2 => 0.0355555556,
			pk_college_tier_s0 = 3 => 0.02734375,
									  0.0565434927);

		pk_grad_student_1m := map(
			pk_grad_student = 0 => 0.088476752,
			pk_grad_student = 1 => 0.0093457944,
								   0.0878498445);

		pk_ams_senior_1m := map(
			pk_ams_senior = 0 => 0.0902708509,
			pk_ams_senior = 1 => 0.021141649,
								 0.0878498445);

		pk_college_tier_s1_1m := map(
			pk_college_tier_s1 = 0 => 0.1004968383,
			pk_college_tier_s1 = 1 => 0.042988741,
			pk_college_tier_s1 = 2 => 0.0250426864,
			pk_college_tier_s1 = 3 => 0.0172265289,
									  0.0878498445);

		pk_grad_student_2m := map(
			pk_grad_student = 0 => 0.0141783801,
			pk_grad_student = 1 => 0.0053655265,
								   0.0140849078);

		pk_college_tier_s2_2m := map(
			pk_college_tier_s2 = 0 => 0.0142526819,
			pk_college_tier_s2 = 1 => 0.0133744856,
			pk_college_tier_s2 = 2 => 0.0048205678,
									  0.0140849078);

		pk_4yr_college_3m := map(
			pk_4yr_college = 0 => 0.0279825816,
			pk_4yr_college = 1 => 0.0175115207,
								  0.0270104534);

		pk_contrary_infutor_ver_1m := map(
			pk_contrary_infutor_ver = 0 => 0.0845196488,
			pk_contrary_infutor_ver = 1 => 0.1098591549,
										   0.0878498445);

		pk_contrary_infutor_ver_2m := map(
			pk_contrary_infutor_ver = 0 => 0.0133991912,
			pk_contrary_infutor_ver = 1 => 0.0243819073,
										   0.0140849078);

		pk_contrary_infutor_ver_3m := map(
			pk_contrary_infutor_ver = 0 => 0.0247989169,
			pk_contrary_infutor_ver = 1 => 0.0459378408,
										   0.0270104534);

		pk_num_nonderogs90_s0_0m := map(
			pk_num_nonderogs90_s0 = 0 => 0.089698315,
			pk_num_nonderogs90_s0 = 1 => 0.0492027702,
			pk_num_nonderogs90_s0 = 2 => 0.035473395,
			pk_num_nonderogs90_s0 = 3 => 0.0344393112,
			pk_num_nonderogs90_s0 = 4 => 0.0216450216,
										 0.0565434927);

		pk_mth_gong_did_fst_sn2_s0_0m := map(
			pk_mth_gong_did_fst_sn2_s0 = -1 => 0.0742198225,
			pk_mth_gong_did_fst_sn2_s0 = 0  => 0.0970588235,
			pk_mth_gong_did_fst_sn2_s0 = 1  => 0.0775805391,
			pk_mth_gong_did_fst_sn2_s0 = 2  => 0.0472106878,
			pk_mth_gong_did_fst_sn2_s0 = 3  => 0.0419888316,
											   0.0565434927);

		pk_mth_gong_did_fst_sn2_s1_1m := map(
			pk_mth_gong_did_fst_sn2_s1 = -1 => 0.0873078961,
			pk_mth_gong_did_fst_sn2_s1 = 0  => 0.1787072243,
			pk_mth_gong_did_fst_sn2_s1 = 1  => 0.1064638783,
			pk_mth_gong_did_fst_sn2_s1 = 2  => 0.0681003584,
											   0.0878498445);

		pk_too_young_at_bureau_1m := map(
			(integer)pk_too_young_at_bureau = 0 => 0.0853538663,
			(integer)pk_too_young_at_bureau = 1 => 0.1113251156,
												   0.0878498445);

		pk_addr_hist_advo_college_1m := map(
			pk_addr_hist_advo_college = 0 => 0.0889132406,
			pk_addr_hist_advo_college = 1 => 0.0364963504,
											 0.0878498445);

		pk_nap_summary_ver_s1_1m := map(
			pk_nap_summary_ver_s1 = -1 => 0.1218637993,
			pk_nap_summary_ver_s1 = 0  => 0.0933044932,
			pk_nap_summary_ver_s1 = 1  => 0.0690032859,
										  0.0878498445);

		pk_mth_gong_did_fst_sn2_s2_2m := map(
			pk_mth_gong_did_fst_sn2_s2 = -1 => 0.0143733489,
			pk_mth_gong_did_fst_sn2_s2 = 0  => 0.0286436394,
			pk_mth_gong_did_fst_sn2_s2 = 1  => 0.0189183632,
			pk_mth_gong_did_fst_sn2_s2 = 2  => 0.0144554671,
			pk_mth_gong_did_fst_sn2_s2 = 3  => 0.0124786908,
											   0.0140849078);

		pk_addr_hist_advo_college_2m := map(
			pk_addr_hist_advo_college = 0 => 0.0141909843,
			pk_addr_hist_advo_college = 1 => 0.0053412463,
											 0.0140849078);

		pk_add1_house_number_match_2m := map(
			pk_add1_house_number_match = 0 => 0.036712217,
			pk_add1_house_number_match = 1 => 0.0132671939,
											  0.0140849078);

		pk_mth_gong_did_fst_sn2_s3_3m := map(
			pk_mth_gong_did_fst_sn2_s3 = -1 => 0.0290605992,
			pk_mth_gong_did_fst_sn2_s3 = 0  => 0.0570469799,
			pk_mth_gong_did_fst_sn2_s3 = 1  => 0.0366843034,
			pk_mth_gong_did_fst_sn2_s3 = 2  => 0.0246165008,
			pk_mth_gong_did_fst_sn2_s3 = 3  => 0.022530113,
											   0.0270104534);

		pk_mth_add1_date_fst_sn2_s3_3m := map(
			pk_mth_add1_date_fst_sn2_s3 = -1 => 0.0511262596,
			pk_mth_add1_date_fst_sn2_s3 = 0  => 0.04,
			pk_mth_add1_date_fst_sn2_s3 = 1  => 0.0369582043,
			pk_mth_add1_date_fst_sn2_s3 = 2  => 0.0286988019,
			pk_mth_add1_date_fst_sn2_s3 = 3  => 0.0270079019,
			pk_mth_add1_date_fst_sn2_s3 = 4  => 0.01966971,
			pk_mth_add1_date_fst_sn2_s3 = 5  => 0.0139283121,
												0.0270104534);

		pk_addr_hist_advo_college_3m := map(
			pk_addr_hist_advo_college = 0 => 0.0273249405,
			pk_addr_hist_advo_college = 1 => 0.0085251492,
											 0.0270104534);

		pk_add1_house_number_match_3m := map(
			pk_add1_house_number_match = 0 => 0.0524914979,
			pk_add1_house_number_match = 1 => 0.0242905395,
											  0.0270104534);

		pk_time_on_cb2_s1_1m := map(
			pk_time_on_cb2_s1 = -1 => 0.1422070535,
			pk_time_on_cb2_s1 = 0  => 0.1865008881,
			pk_time_on_cb2_s1 = 1  => 0.1563136456,
			pk_time_on_cb2_s1 = 2  => 0.1082239486,
			pk_time_on_cb2_s1 = 3  => 0.0775052192,
			pk_time_on_cb2_s1 = 4  => 0.0692247861,
			pk_time_on_cb2_s1 = 5  => 0.052691758,
									  0.0878498445);

		pk_time_since_cb3_1m := map(
			pk_time_since_cb3 = 0 => 0.0870101244,
			pk_time_since_cb3 = 1 => 0.1795918367,
									 0.0878498445);

		pk_pos_dob_src_cnt_s2_2m := map(
			pk_pos_dob_src_cnt_s2 = 0 => 0.019551348,
			pk_pos_dob_src_cnt_s2 = 1 => 0.0132078587,
										 0.0140849078);

		derog_mod_0m := -6.13576804 +
			pk_attr_total_number_derogs_0m * 9.3331496377 +
			pk_crim_fel_flag_0m * 13.143708695 +
			pk_eviction_lvl_0m * 7.3700576551 +
			pk_unrel_lien_lvl_0m * 8.9466402638 +
			bankrupt_0m * 16.011084801 +
			pk_impulse_flag * 2.4931427584;

		prop_owner_mod_0m := -4.41586031 +
			pk_ver_src_p_0m * 12.516565479 +
			pk_prop_owned_purch_flag_0m * 5.7187605132 +
			pk_add1_naprop4_0m * 8.2491242885;

		prop_owner_mod_1m := -4.119421276 +
			pk_ver_src_p_1m * 11.50422511 +
			pk_add1_naprop4_1m * 8.6236762719;

		prop_owner_mod_3m := -4.864143029 + pk_ver_src_p_3m * 45.975872588;

		financing_mod_0m := -2.819415198 + pk_baloon_mortgage * 1.209994132;

		financing_mod_2m := -4.318840575 +
			pk_2nd_mortgage * 0.7259505049 +
			pk_baloon_mortgage * 1.1630288186 +
			pk_adj_finance * 0.351346294;

		financing_mod_3m := -3.602956981 +
			pk_2nd_mortgage * 0.6638882749 +
			pk_adj_finance * 0.2750406154;

		email_mod_1m := -3.329001164 + pk_email_count_s1_1m * 11.248723668;

		email_mod_2m := -4.971433824 + pk_email_domain_free_count_s2_2m * 51.001538056;

		email_mod_3m := -4.425063336 + pk_email_domain_free_count_s3_3m * 31.051485866;

		fp_mod2_1m := -3.180987059 + pk_addprob_s1_1m * 9.5155297565;

		ams_mod_0m := -4.142233253 + pk_college_tier_s0_0m * 23.41466177;

		ams_mod_1m := -6.371983272 +
			pk_grad_student_1m * 17.937172019 +
			pk_ams_senior_1m * 9.8207615317 +
			pk_college_tier_s1_1m * 17.030952044;

		ams_mod_2m := -6.788452119 +
			pk_grad_student_2m * 85.041327392 +
			pk_college_tier_s2_2m * 94.762607215;

		ams_mod_3m := -4.829016474 + pk_4yr_college_3m * 45.786518183;

		inquiry_mod_0m := -3.435795816 +
			pk_inq_recent_lvl_s0_0m * 3.990328493 +
			pk_inq_peradl_s0_0m * 2.0027290764 +
			pk_inq_adlsperphone_s0_0m * 4.0228807529;

		inquiry_mod_1m := -3.137458578 +
			pk_inq_recent_lvl_s1_1m * 4.7485458561 +
			pk_inq_peraddr_1m * 3.7210059561;

		inquiry_mod_2m := -4.720980683 + pk_mth_inq_frst_log_dt2_s2_2m * 32.623012423;

		inquiry_mod_3m := -4.13003928 +
			pk_inq_recent_lvl_s3_3m * 7.3435047646 +
			pk_inq_peraddr_3m * 5.9686575266 +
			pk_inq_adlsperphone_s3_3m * 5.026470537;

		velo_mod_0m := -7.0238857 +
			pk_addrs_per_ssn_c6_s0_0m * 10.870842239 +
			pk_ssns_per_adl_c6_0m * 5.5370768191 +
			pk_ssns_per_addr_c6_s0_0m * 8.222562725 +
			pk_attr_addrs_last24_s0_0m * 5.4544984232 +
			pk_recent_addr_s0_0m * 5.8444054 +
			pk_phones_per_adl_s0_0m * 18.807703437 +
			pk_ssns_per_addr_0m * 6.3078515686 +
			pk_phones_per_addr_s0_0m * 11.589909799;

		velo_mod_1m := -7.903920386 +
			pk_adlperssn_count_s1_1m * 11.80976186 +
			pk_ssns_per_adl_s1_1m * 11.065233911 +
			pk_addrs_per_ssn_c6_s1_1m * 10.091573956 +
			pk_ssns_per_adl_c6_1m * 3.0964475191 +
			pk_ssns_per_addr_c6_s1_1m * 9.5011342145 +
			pk_phones_per_addr_c6_1m * 9.112129103 +
			pk_attr_addrs_last12_s1_1m * 7.8795300804;

		velo_mod_2m := -7.814850961 +
			pk_ssns_per_adl_s2_2m * 50.665296275 +
			pk_addrs_per_ssn_c6_s2_2m * 37.436601044 +
			pk_adls_per_addr_c6_s2_2m * 25.607924542 +
			pk_adls_per_phone_c6_2m * -30.29448194 +
			pk_attr_addrs_last36_s2_2m * 24.47530058 +
			pk_recent_addr_s2_2m * 21.510962018 +
			pk_ssns_per_addr_2m * 30.311887525 +
			pk_phones_per_addr_s2_2m * 20.370965388 +
			pk_adls_per_phone_2m * 63.388740934;

		velo_mod_3m := -9.259472734 +
			pk_adlperssn_count_s3_3m * 33.710646116 +
			pk_ssns_per_adl_s3_3m * 29.594364353 +
			pk_addrs_per_ssn_c6_s3_3m * 18.805570748 +
			pk_phones_per_adl_c6_s3_3m * 21.241190975 +
			pk_ssns_per_addr_c6_s3_3m * 20.663453736 +
			pk_phones_per_addr_c6_3m * 23.940623893 +
			pk_attr_addrs_last36_s3_3m * 22.92767413 +
			pk_phones_per_addr_s3_3m * 13.213015025 +
			pk_adls_per_phone_3m * 22.097757033;

		mod8_0m_1 := 6.26699123 +
			pk_age_estimate_s0_0m * 2.7739642504 +
			pk_estimated_income_s0_0m * 3.073745963 +
			pk_add1_avm_auto_val_s0_0m * 7.5049613997 +
			pk_verx_s0_0m * 4.8570873285 +
			derog_mod_0m * 0.5845651145 +
			financing_mod_0m * 1.1296665153 +
			pk_addrs_prison_history * 1.2808637342 +
			prop_owner_mod_0m * 0.151313427 +
			pk_addrs_5yr_s0_0m * 5.3712818446 +
			ssn_adl_prob_0m * 12.548101437 +
			ssn_issued18_0m * 12.004608552 +
			ams_mod_0m * 1.5491765648 +
			pk_num_nonderogs90_s0_0m * 2.9674684832 +
			pk_mth_gong_did_fst_sn2_s0_0m * 3.4814816546 +
			inquiry_mod_0m * 0.5473949502 +
			velo_mod_0m * 0.4028429785;

		mod8_0m := 100 * exp(mod8_0m_1) / (1 + exp(mod8_0m_1));

		mod8_1m_1 := -1.545301323 +
			pk_age_estimate_s1_1m * 5.377234959 +
			pk_estimated_income_s1_1m * 3.308268356 +
			pk_add1_avm_auto_val_s1_1m * 8.9453912632 +
			pk_verx_s1_1m * 4.5323070165 +
			pk_dob_ver_1m * 4.2869915006 +
			prop_owner_mod_1m * 0.417331337 +
			email_mod_1m * 1.0726725676 +
			fp_mod2_1m * 0.701579615 +
			ssn_issued18_1m * 22.981894417 +
			ams_mod_1m * 0.7800733285 +
			pk_contrary_infutor_ver_1m * 4.9731568391 +
			pk_mth_gong_did_fst_sn2_s1_1m * 8.7990093348 +
			pk_too_young_at_bureau_1m * 16.067713959 +
			pk_addr_hist_advo_college_1m * 10.326425575 +
			pk_nap_summary_ver_s1_1m * 8.4079610757 +
			pk_time_on_cb2_s1_1m * 2.2934957839 +
			inquiry_mod_1m * 0.6217063664 +
			velo_mod_1m * 0.5856058321;

		mod8_1m := 100 * exp(mod8_1m_1) / (1 + exp(mod8_1m_1));

		mod8_2m_1 := 7.0534390485 +
			pk_age_estimate_s2_2m * 34.274445838 +
			pk_estimated_income_s2_2m * 44.068470793 +
			pk_add1_avm_auto_val_s2_2m * 42.309811252 +
			pk_prof_lic_cat_s2_2m * 59.513874135 +
			financing_mod_2m * 0.918390981 +
			pk_addrs_5yr_s2_2m * 8.9339801963 +
			(integer)rc_input_addr_not_most_recent * 0.150249678 +
			email_mod_2m * 0.4605769252 +
			pk_addprob_s2_2m * 21.183754226 +
			pk_phnprob_s2_2m * 13.300651322 +
			ams_mod_2m * 1.4579276978 +
			pk_contrary_infutor_ver_2m * 18.495187271 +
			pk_mth_gong_did_fst_sn2_s2_2m * 22.698241364 +
			pk_addr_hist_advo_college_2m * 145.60658663 +
			pk_add1_house_number_match_2m * 28.212130098 +
			pk_pos_dob_src_cnt_s2_2m * 24.446265739 +
			inquiry_mod_2m * 0.7533049138 +
			velo_mod_2m * 0.6457800763;

		mod8_2m := 100 * exp(mod8_2m_1) / (1 + exp(mod8_2m_1));

		mod8_3m_1 := 1.9538188366 +
			pk_estimated_income_s3_3m * 9.9328006071 +
			pk_add1_avm_auto_val_s3_3m * 25.02124434 +
			pk_verx_s3_3m * 8.3122146315 +
			pk_dob_ver_3m * 10.879814814 +
			pk_prof_lic_cat_s3_3m * 34.436469725 +
			financing_mod_3m * 0.8304117363 +
			prop_owner_mod_3m * 0.6083182047 +
			pk_addrs_5yr_s3_3m * 10.250404543 +
			email_mod_3m * 0.7556213516 +
			pk_addprob_s3_3m * 10.028036081 +
			ssn_issued18_3m * 195.68639135 +
			ams_mod_3m * 1.1374960366 +
			pk_contrary_infutor_ver_3m * 17.317516468 +
			pk_mth_gong_did_fst_sn2_s3_3m * 11.303700779 +
			pk_mth_add1_date_fst_sn2_s3_3m * 2.710798666 +
			pk_addr_hist_advo_college_3m * 69.810935363 +
			pk_add1_house_number_match_3m * 10.471164629 +
			inquiry_mod_3m * 0.717546622 +
			velo_mod_3m * 0.6636221375;

		mod8_3m := 100 * exp(mod8_3m_1) / (1 + exp(mod8_3m_1));

		mod8_nodob_0m_1 := 6.7179860738 +
			pk_age_estimate_s0_0m * 2.9990337154 +
			pk_estimated_income_s0_0m * 2.9053537317 +
			pk_add1_avm_auto_val_s0_0m * 7.9015940165 +
			pk_verx_s0_0m * 4.8772596717 +
			derog_mod_0m * 0.5825820701 +
			financing_mod_0m * 1.1276870584 +
			pk_addrs_prison_history * 1.32874535 +
			prop_owner_mod_0m * 0.1608301108 +
			pk_addrs_5yr_s0_0m * 5.5050099401 +
			ssn_adl_prob_0m * 12.283213577 +
			ams_mod_0m * 1.4693423108 +
			pk_num_nonderogs90_s0_0m * 2.8365945639 +
			pk_mth_gong_did_fst_sn2_s0_0m * 3.521698492 +
			inquiry_mod_0m * 0.5488230536 +
			velo_mod_0m * 0.3973008626;

		mod8_nodob_0m := 100 * exp(mod8_nodob_0m_1) / (1 + exp(mod8_nodob_0m_1));

		mod8_nodob_1m_1 := -0.532648123 +
			pk_age_estimate_s1_1m * 7.5438290771 +
			pk_estimated_income_s1_1m * 3.0795096918 +
			pk_add1_avm_auto_val_s1_1m * 8.9942707659 +
			pk_verx_s1_1m * 4.3447325497 +
			pk_adlperssn_count_s1_1m * 7.7832928559 +
			prop_owner_mod_1m * 0.4240204337 +
			email_mod_1m * 1.0724514608 +
			pk_addprob_s1_1m * 6.6590588025 +
			ams_mod_1m * 0.7860016723 +
			pk_mth_gong_did_fst_sn2_s1_1m * 8.6557765439 +
			pk_addr_hist_advo_college_1m * 10.593898059 +
			pk_nap_summary_ver_s1_1m * 9.0980023527 +
			pk_time_since_cb3_1m * 3.8447802442 +
			inquiry_mod_1m * 0.6312569184 +
			velo_mod_1m * 0.579112048;

		mod8_nodob_1m := 100 * exp(mod8_nodob_1m_1) / (1 + exp(mod8_nodob_1m_1));

		mod8_nodob_2m_1 := 7.3468796986 +
			pk_age_estimate_s2_2m * 30.311783204 +
			pk_estimated_income_s2_2m * 43.827944495 +
			pk_add1_avm_auto_val_s2_2m * 41.98475476 +
			pk_mth_hdr_frst_sn_s2_2m * 8.7948373806 +
			pk_prof_lic_cat_s2_2m * 59.411647621 +
			financing_mod_2m * 0.9179262519 +
			pk_addrs_5yr_s2_2m * 8.4166631522 +
			(integer)rc_input_addr_not_most_recent * 0.1530566986 +
			email_mod_2m * 0.4537693766 +
			pk_addprob_s2_2m * 21.194302356 +
			pk_phnprob_s2_2m * 13.341843655 +
			ams_mod_2m * 1.4641307936 +
			pk_contrary_infutor_ver_2m * 18.388436107 +
			pk_mth_gong_did_fst_sn2_s2_2m * 22.992018739 +
			pk_addr_hist_advo_college_2m * 145.56396798 +
			pk_add1_house_number_match_2m * 27.934356076 +
			inquiry_mod_2m * 0.7562229974 +
			velo_mod_2m * 0.6438452239;

		mod8_nodob_2m := 100 * exp(mod8_nodob_2m_1) / (1 + exp(mod8_nodob_2m_1));

		mod8_nodob_3m_1 := 5.9615178992 +
			pk_age_estimate_s3_3m * 15.887767473 +
			pk_estimated_income_s3_3m * 7.015814043 +
			pk_add1_avm_auto_val_s3_3m * 26.986478198 +
			pk_verx_s3_3m * 9.2776087205 +
			pk_ssns_per_adl_s3_3m * 17.347371803 +
			pk_prof_lic_cat_s3_3m * 33.798090663 +
			financing_mod_3m * 0.7844396783 +
			prop_owner_mod_3m * 0.5880225978 +
			pk_addrs_5yr_s3_3m * 8.586665481 +
			email_mod_3m * 0.7036102492 +
			pk_addprob_s3_3m * 8.3556593541 +
			ams_mod_3m * 1.083068021 +
			pk_contrary_infutor_ver_3m * 16.419477069 +
			pk_mth_gong_did_fst_sn2_s3_3m * 10.797828779 +
			pk_addr_hist_advo_college_3m * 71.444809677 +
			pk_add1_house_number_match_3m * 12.439705792 +
			inquiry_mod_3m * 0.7079660055 +
			velo_mod_3m * 0.6229300386;

		mod8_nodob_3m := 100 * exp(mod8_nodob_3m_1) / (1 + exp(mod8_nodob_3m_1));

		mod8_nodob := map(
			pk_segment_40 = '0 Derog' => mod8_nodob_0m,
			pk_segment_40 = '1 Young' => mod8_nodob_1m,
			pk_segment_40 = '2 Owner' => mod8_nodob_2m,
										 mod8_nodob_3m);

		mod8 := map(
			pk_segment_40 = '0 Derog' => mod8_0m,
			pk_segment_40 = '1 Young' => mod8_1m,
			pk_segment_40 = '2 Owner' => mod8_2m,
										 mod8_3m);

		mod8_phat := mod8 / 100;

		mod8_scr := round(-40 * (ln(mod8_phat / (1 - mod8_phat)) - ln(1 / 20)) / ln(2) + 700);

		mod8_nodob_phat := mod8_nodob / 100;

		mod8_nodob_scr := round(-40 * (ln(mod8_nodob_phat / (1 - mod8_nodob_phat)) - ln(1 / 20)) / ln(2) + 700);

		rvb1104a := if((integer)dobpop = 1, mod8_scr, mod8_nodob_scr);

		rvb1104b := min(900, if(max((real)501, rvb1104a) = NULL, -NULL, max((real)501, rvb1104a)));

		ov_ssndead := ssnlength > (string)0 and rc_decsflag = (string)1;

		ov_ssnprior := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = (string)2225;

		ov_impulse := impulse_count > 0;

		rvb1104c := if(rvb1104b > 680 and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 680, rvb1104b);

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		rvb1104d := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvb1104c);

		rvb1104e := if((integer)ssn_deceased > 0, 200, rvb1104d);

		rvb1104 := rvb1104e;





		combo_addrcount                  := le.iid.combo_addrcount;
		combo_dobcount                   := le.iid.combo_dobcount;
		addrpop                          := le.input_validation.address;
		hphnpop                          := le.input_validation.homephone;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_lres                        := le.lres;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_market_total_value          := le.address_verification.input_address_information.assessed_amount;
		property_ambig_total             := le.address_verification.ambiguous.property_total;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		wealth_index                     := le.wealth_indicator;





pk_em_domain_free_count_s2_2m := pk_email_domain_free_count_S2_2m;

pk_em_domain_free_count_s3_3m := pk_email_domain_free_count_S3_3m;

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
glrc28 := if((integer)dobpop > 0 and combo_dobcount = 0, 1, 0);
glrc36 := 1;
glrc97 := if(criminal_count > 0, 1, 0);
glrc98 := if(liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0, 1, 0);
glrc99 := (integer)addrpop>0 and (integer)add1_isbestmatch = 0;
glrc9a := if((add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0, 1, 0);
glrc9c := if(add1_lres <= 72, 1, 0);
glrc9d := if(attr_addrs_last12 > 1, 1, 0);
glrc9e := 1;
glrc9g := if((integer)dobpop>0 and pk_age_estimate <= 35, 1, 0);
glrc9h := if(impulse_count > 0, 1, 0);
glrc9j := if(pk_mth_header_first_seen < 60, 1, 0);
glrc9m := if(wealth_index < (string)5, 1, 0);
glrc9n := if((integer)addrs_prison_history > 0, 1, 0);
glrc9q := if(Inq_count12 > 0, 1, 0);
glrc9r := 1;
glrc9s := if(trim(trim(add1_financing_type, LEFT), LEFT, RIGHT) = 'ADJ', 1, 0);

phn_business := ((integer)rc_hphonevalflag = 1);
glrc9t := if((integer)hphnpop * (integer)(phn_cell or trim(trim(nap_status, LEFT), LEFT, RIGHT) != 'C' or pk_phn_NonGEO = 1 or pk_phn_Phn_Not_Issued = 1 or phn_disconnected or phn_inval or phn_highrisk2 or phn_zipmismatch or phn_notpots or phn_business) = 1, 1, 0);
glrc9u := if((integer)addrpop * (integer)(pk_add1_advo_address_vacancy = 1 or pk_add_hirisk_comm = 1 or pk_zip_corp_mil = 1 or pk_add1_advo_throw_back = 1 or pk_add1_advo_seasonal_delivery = 1 or pk_add1_advo_college = 1 or pk_add1_advo_res_or_business = 1 or pk_add_standarization_err = 1 or pk_zip_po = 1 or pk_add_inval = 1 or pk_add1_advo_drop = 1 or pk_add1_advo_mixed_address_usage = 1 or pk_zip_hirisk_comm = 1) = 1, 1, 0);
glrc9w := if((integer)bankrupt > 0, 1, 0);
glrcev := if(attr_eviction_count > 0, 1, 0);
glrcmi := if((integer)ssnlength>0 and adlperssn_count >= 3, 1, 0);
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

m_financing_mod_2m := if((integer)dobpop = 1, 0.918390981, 0.9179262519);
m_prop_owner_mod_3m := if((integer)dobpop = 1, 0.6083182047, 0.5880225978);
m_velo_mod_3m := if((integer)dobpop = 1, 0.6636221375, 0.6229300386);
m_inquiry_mod_2m := if((integer)dobpop = 1, 0.7533049138, 0.7562229974);
m_velo_mod_1m := if((integer)dobpop = 1, 0.5856058321, 0.579112048);
m_email_mod_1m := if((integer)dobpop = 1, 1.0726725676, 1.0724514608);
m_prop_owner_mod_1m := if((integer)dobpop = 1, 0.417331337, 0.4240204337);
m_fp_mod2_1m := if((integer)dobpop = 1, 0.701579615, 0);
m_email_mod_2m := if((integer)dobpop = 1, 0.4605769252, 0.4537693766);
m_inquiry_mod_0m := if((integer)dobpop = 1, 0.5473949502, 0.5488230536);
m_derog_mod_0m := if((integer)dobpop = 1, 0.5845651145, 0.5825820701);
m_velo_mod_2m := if((integer)dobpop = 1, 0.6457800763, 0.6438452239);
m_financing_mod_0m := if((integer)dobpop = 1, 1.1296665153, 1.1276870584);
m_inquiry_mod_3m := if((integer)dobpop = 1, 0.717546622, 0.7079660055);
m_prop_owner_mod_0m := if((integer)dobpop = 1, 0.151313427, 0.1608301108);
m_inquiry_mod_1m := if((integer)dobpop = 1, 0.6217063664, 0.6312569184);
m_email_mod_3m := if((integer)dobpop = 1, 0.7556213516, 0.7036102492);
m_financing_mod_3m := if((integer)dobpop = 1, 0.8304117363, 0.7844396783);
m_velo_mod_0m := if((integer)dobpop = 1, 0.4028429785, 0.3973008626);

_25_0 := 0;
_25_1_1 := 0;
_25_2_1 := 0;
_28_0 := 0;
_28_1_1 := 0;
_28_2_1 := 0;
_28_3_1 := 0;
_36_0 := 0;
_36_1_1 := 0;
_36_2_1 := 0;
_36_3_1 := 0;
_97_0_1 := 0;
_97_1_1 := 0;
_98_0_1 := 0;
_98_1_1 := 0;
_99_0 := 0;
_99_1_1 := 0;
_9a_0 := 0;
_9a_1_1 := 0;
_9a_2_1 := 0;
_9a_3_1 := 0;
_9a_4_1 := 0;
_9a_5_1 := 0;
_9a_6_1 := 0;
_9a_7_1 := 0;
_9c_0 := 0;
_9c_1_1 := 0;
_9d_0 := 0;
_9d_1_1 := 0;
_9d_2_1 := 0;
_9d_3_1 := 0;
_9d_4_1 := 0;
_9d_5_1 := 0;
_9d_6_1 := 0;
_9d_7_1 := 0;
_9d_8_1 := 0;
_9d_9_1 := 0;
_9d_10_1 := 0;
_9d_11_1 := 0;
_9d_12_1 := 0;
_9d_13_1 := 0;
_9e_0 := 0;
_9e_1_1 := 0;
_9e_2_1 := 0;
_9g_0 := 0;
_9g_1_1 := 0;
_9g_2_1 := 0;
_9g_3_1 := 0;
_9g_4_1 := 0;
_9g_5_1 := 0;
_9h_0_1 := 0;
_9h_1_1 := 0;
_9m_0 := 0;
_9m_1_1 := 0;
_9m_2_1 := 0;
_9m_3_1 := 0;
_9m_4_1 := 0;
_9n_0 := 0;
_9n_1_1 := 0;
_9q_0 := 0;
_9q_1_1 := 0;
_9q_2_1 := 0;
_9q_3_1 := 0;
_9q_4_1 := 0;
_9q_5_1 := 0;
_9q_6_1 := 0;
_9q_7_1 := 0;
_9q_8_1 := 0;
_9q_9_1 := 0;
_9r_0 := 0;
_9r_1_1 := 0;
_9r_2_1 := 0;
_9r_3_1 := 0;
_9r_4_1 := 0;
_9r_5_1 := 0;
_9r_6_1 := 0;
_9r_7_1 := 0;
_9r_8_1 := 0;
_9r_9_1 := 0;
_9r_10_1 := 0;
_9r_11_1 := 0;
_9s_0 := 0;
_9s_1_1 := 0;
_9s_2_1 := 0;
_9s_3_1 := 0;
_9s_4_1 := 0;
_9s_5_1 := 0;
_9s_6_1 := 0;
_9t_0 := 0;
_9t_1_1 := 0;
_9u_0 := 0;
_9u_1_1 := 0;
_9u_2_1 := 0;
_9u_3_1 := 0;
_9w_0_1 := 0;
_9w_1_1 := 0;
_9w_2 := 0;
_ev_0_1 := 0;
_ev_1_1 := 0;
_mi_0 := 0;
_mi_1_1 := 0;
_mi_2_1 := 0;
_ms_0 := 0;
_ms_1_1 := 0;
_ms_2_1 := 0;
_ms_3_1 := 0;
_ms_4_1 := 0;
_ms_5_1 := 0;
_ms_6_1 := 0;
_pv_0 := 0;
_pv_1_1 := 0;
_pv_2_1 := 0;
_pv_3_1 := 0;
_pv_4_1 := 0;
_x11_0 := 0;
_x11_1_1 := 0;
_x11_2_1 := 0;
_x11_3_1 := 0;
_x11_4_1 := 0;
_x11_5_1 := 0;
_x11_6_1 := 0;
_x11_7_1 := 0;
_x11_8_1 := 0;
_x11_9_1 := 0;
_x11_10_1 := 0;
_x11_11_1 := 0;
_x11_12_1 := 0;
_x11_13_1 := 0;
_x11_14_1 := 0;
_x11_15_1 := 0;
_x11_16_1 := 0;

seg_s0_crime_c37_b1 := -2.81454014268427;

_97_0_c37 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (seg_s0_crime_c37_b1 - -4.248466382), 0);

seg_s0_lien_c38_b1 := -2.81454014268427;

_98_0_c38 := if(lien_flag, (seg_s0_lien_c38_b1 - -4.248466382), 0);

seg_s0_eviction_c39_b1 := -2.81454014268427;

_ev_0_c39 := if(bs_attr_eviction_flag > 0, (seg_s0_eviction_c39_b1 - -4.248466382), 0);

seg_s0_impulse_c40_b1 := -2.81454014268427;

_9h_0_c40 := if(pk_impulse_count > 0, (seg_s0_impulse_c40_b1 - -4.248466382), 0);

seg_s0_bk_c41_b1 := -2.81454014268427;

_9w_0_c41 := if(bk_flag, (seg_s0_bk_c41_b1 - -4.248466382), 0);

_9d_3_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.8444054 * (pk_recent_addr_S0_0m - 0.0507715281), 0);

_9q_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 3.990328493 * (pk_inq_recent_lvl_S0_0m - 0.0510322723), 0);

_ev_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 7.3700576551 * (pk_eviction_lvl_0m - 0.0536455151), 0);

_x11_3_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 6.3078515686 * (pk_ssns_per_addr_0m - 0.0544585462), 0);

_9h_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 2.4931427584 * (pk_impulse_flag - 0), 0);

_9w_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 16.011084801 * (bankrupt_0m - 0.055950981), 0);

_x11_2_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 18.807703437 * (pk_phones_per_adl_S0_0m - 0.0667526604), 0);

_9g_1_c36 := if((string)pk_Segment_40 = '0 Derog', 2.7739642504 * (pk_age_estimate_S0_0m - 0.0535984276), 0);

_9s_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_financing_mod_0m * 1.209994132 * (pk_Baloon_mortgage - 0), 0);

_36_1_c36 := if((string)pk_Segment_40 = '0 Derog', 4.8570873285 * (pk_verx_S0_0m - 0.0593320236), 0);

_ms_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.5370768191 * (pk_ssns_per_adl_c6_0m - 0.0496577474), 0);

_9a_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 12.516565479 * (pk_ver_src_P_0m - 0.0386540352), 0);

_9w_0_c36 := if((string)pk_Segment_40 = '0 Derog', _9w_0_c41, 0);

_x11_4_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 11.589909799 * (pk_phones_per_addr_S0_0m - 0.0581807725), 0);

_9e_1_c36 := if((string)pk_Segment_40 = '0 Derog', 2.9674684832 * (pk_num_nonderogs90_S0_0m - 0.0492027702), 0);

_98_0_c36 := if((string)pk_Segment_40 = '0 Derog', _98_0_c38, 0);

_97_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 13.143708695 * (pk_crim_fel_flag_0m - 0.0547007453), 0);

_9m_1_c36 := if((string)pk_Segment_40 = '0 Derog', 3.073745963 * (pk_estimated_income_S0_0m - 0.0389371862), 0);

_ms_2_c36 := if((string)pk_Segment_40 = '0 Derog', 12.548101437 * (ssn_adl_prob_0m - 0.0549828179), 0);

_9q_3_c36 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 4.0228807529 * (pk_inq_adlsperphone_S0_0m - 0.0510322723), 0);

_98_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 8.9466402638 * (pk_unrel_lien_lvl_0m - 0.0524842018), 0);

_ev_0_c36 := if((string)pk_Segment_40 = '0 Derog', _ev_0_c39, 0);

_9q_2_c36 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 2.0027290764 * (pk_inq_peradl_S0_0m - 0.0510322723), 0);

_9h_0_c36 := if((string)pk_Segment_40 = '0 Derog', _9h_0_c40, 0);

_9d_2_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.4544984232 * (pk_attr_addrs_last24_S0_0m - 0.0447368421), 0);

_9d_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 10.870842239 * (pk_addrs_per_ssn_c6_S0_0m - 0.052182623), 0);

_9d_4_c36 := if((string)pk_Segment_40 = '0 Derog', 5.3712818446 * (pk_addrs_5yr_S0_0m - 0.0616986301), 0);

_9n_1_c36 := if((string)pk_Segment_40 = '0 Derog', 1.2808637342 * (pk_addrs_prison_history - 0), 0);

_9a_3_c36 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 8.2491242885 * (pk_add1_naprop4_0m - 0.0363378114), 0);

_9r_1_c36 := if((string)pk_Segment_40 = '0 Derog', 3.4814816546 * (pk_mth_gong_did_fst_sn2_S0_0m - 0.0472106878), 0);

_pv_1_c36 := if((string)pk_Segment_40 = '0 Derog', 7.5049613997 * (pk_add1_avm_auto_val_S0_0m - 0.0598949212), 0);

_97_0_c36 := if((string)pk_Segment_40 = '0 Derog', _97_0_c37, 0);

_x11_1_c36 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 8.222562725 * (pk_ssns_per_addr_c6_S0_0m - 0.0479833951), 0);

_9a_2_c36 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 5.7187605132 * (pk_prop_owned_purch_flag_0m - 0.063502861), 0);

_9u_1_c43 := if((pk_add_apt1 = 1 or pk_add_apt2 = 1) and pk_add1_advo_address_vacancy = 0 and pk_add_hirisk_comm = 0 and pk_zip_corp_mil = 0 and pk_add1_advo_throw_back = 0 and pk_add1_advo_seasonal_delivery = 0 and pk_add1_advo_college = 0 and pk_add1_advo_res_or_business = 0 and pk_add_standarization_err = 0 and pk_zip_po = 0 and pk_add_inval = 0 and pk_add1_advo_drop = 0 and pk_add1_advo_mixed_address_usage = 0 and pk_zip_hirisk_comm = 0 and pk_unit_changed = 0 and pk_addr_changed = 0, 0, m_fp_mod2_1m * 9.5155297565 * (pk_AddProb_S1_1m - 0.0879845402));

seg_s1_c42_b1 := -2.34017557597253;

_x11_5_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 9.5011342145 * (pk_ssns_per_addr_c6_S1_1m - 0.0677562778), 0);

_x11_6_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 9.112129103 * (pk_phones_per_addr_c6_1m - 0.0840170509), 0);

_9q_4_c42 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod_1m * 4.7485458561 * (pk_inq_recent_lvl_S1_1m - 0.076869551), 0);

_9g_2_c42 := if((string)pk_Segment_40 = '1 Young', (seg_s1_c42_b1 - -4.248466382), 0);

_9g_4_c42 := if((string)pk_Segment_40 = '1 Young', 16.067713959 * (pk_Too_Young_At_Bureau_1m - 0.0853538663), 0);

_9r_5_c42 := if((string)pk_Segment_40 = '1 Young', 2.2934957839 * (pk_time_on_CB2_S1_1m - 0.0692247861), 0);

_9e_2_c42 := if((string)pk_Segment_40 = '1 Young', 8.4079610757 * (pk_nap_summary_ver_S1_1m - 0.0933044932), 0);

_9r_4_c42 := if((string)pk_Segment_40 = '1 Young', 8.7990093348 * (pk_mth_gong_did_fst_sn2_S1_1m - 0.0873078961), 0);

_ms_4_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 3.0964475191 * (pk_ssns_per_adl_c6_1m - 0.0746622422), 0);

_9r_3_c42 := if((string)pk_Segment_40 = '1 Young', 4.9731568391 * (pk_Contrary_Infutor_Ver_1m - 0.0845196488), 0);

_pv_2_c42 := if((string)pk_Segment_40 = '1 Young', 8.9453912632 * (pk_add1_avm_auto_val_S1_1m - 0.0956815016), 0);

_9a_4_c42 := if((string)pk_Segment_40 = '1 Young', m_prop_owner_mod_1m * 11.50422511 * (pk_ver_src_P_1m - 0.0907238734), 0);

_9d_6_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 7.8795300804 * (pk_attr_addrs_last12_S1_1m - 0.0725928619), 0);

_9g_3_c42 := if((string)pk_Segment_40 = '1 Young', 5.377234959 * (pk_age_estimate_S1_1m - 0.0736484722), 0);

_28_1_c42 := if((string)pk_Segment_40 = '1 Young', 4.2869915006 * (pk_dob_ver_1m - 0.0693363999), 0);

_36_2_c42 := if((string)pk_Segment_40 = '1 Young', 4.5323070165 * (pk_verx_S1_1m - 0.0839347934), 0);

_9q_5_c42 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod_1m * 3.7210059561 * (pk_inq_peraddr_1m - 0.076869551), 0);

_9a_5_c42 := if((string)pk_Segment_40 = '1 Young', m_prop_owner_mod_1m * 8.6236762719 * (pk_add1_naprop4_1m - 0.090376569), 0);

_mi_1_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 11.80976186 * (pk_adlperssn_count_S1_1m - 0.0847328244), 0);

_9u_1_c42 := if((string)pk_Segment_40 = '1 Young', _9u_1_c43, 0);

_9r_2_c42 := if((string)pk_Segment_40 = '1 Young', m_email_mod_1m * 11.248723668 * (pk_email_count_S1_1m - 0.0876497315), 0);

_9d_5_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 10.091573956 * (pk_addrs_per_ssn_c6_S1_1m - 0.0826655052), 0);

_ms_3_c42 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 11.065233911 * (pk_ssns_per_adl_S1_1m - 0.086062889), 0);

_9m_2_c42 := if((string)pk_Segment_40 = '1 Young', 3.308268356 * (pk_estimated_income_S1_1m - 0.0834858188), 0);

_9m_3_c44 := if((string)pk_Segment_40 = '2 Owner', 44.068470793 * (pk_estimated_income_S2_2m - 0.0145617705), 0);

_28_2_c44 := if((string)pk_Segment_40 = '2 Owner', 24.446265739 * (pk_pos_dob_src_cnt_S2_2m - 0.0132078587), 0);

_pv_3_c44 := if((string)pk_Segment_40 = '2 Owner', 42.309811252 * (pk_add1_avm_auto_val_S2_2m - 0.0148375451), 0);

_ms_5_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 50.665296275 * (pk_ssns_per_adl_S2_2m - 0.0131222201), 0);

_9d_7_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 37.436601044 * (pk_addrs_per_ssn_c6_S2_2m - 0.0133419076), 0);

_9q_6_c44 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod_2m * 32.623012423 * (pk_mth_inq_frst_log_dt2_S2_2m - 0.0137038529), 0);

_x11_8_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * -30.29448194 * (pk_adls_per_phone_c6_2m - 0.0111842197), 0);

_9u_2_c44 := if((string)pk_Segment_40 = '2 Owner', 21.183754226 * (pk_AddProb_S2_2m - 0.0140507795), 0);

_9s_2_c44 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 0.7259505049 * (pk_2nd_mortgage - 0), 0);

_25_1_c44 := if((string)pk_Segment_40 = '2 Owner', 28.212130098 * (pk_add1_house_number_match_2m - 0.0132671939), 0);

_x11_9_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 30.311887525 * (pk_ssns_per_addr_2m - 0.0134892288), 0);

_9d_8_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 24.47530058 * (pk_attr_addrs_last36_S2_2m - 0.0100559976), 0);

_9g_5_c44 := if((string)pk_Segment_40 = '2 Owner', 34.274445838 * (pk_age_estimate_S2_2m - 0.014131362), 0);

_9r_6_c44 := if((string)pk_Segment_40 = '2 Owner', m_email_mod_2m * 51.001538056 * (pk_em_domain_free_count_s2_2m - 0.0137043715), 0);

_x11_7_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 25.607924542 * (pk_adls_per_addr_c6_S2_2m - 0.0119689787), 0);

_9d_9_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 21.510962018 * (pk_recent_addr_S2_2m - 0.0100559976), 0);

_99_1_c44 := if((string)pk_Segment_40 = '2 Owner', 0.150249678 * ((integer)rc_input_addr_not_most_recent - 0), 0);

_9s_4_c44 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 0.351346294 * (pk_adj_finance - 0), 0);

_x11_11_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 63.388740934 * (pk_adls_per_phone_2m - 0.0107968018), 0);

_9r_7_c44 := if((string)pk_Segment_40 = '2 Owner', 18.495187271 * (pk_Contrary_Infutor_Ver_2m - 0.0133991912), 0);

_9s_3_c44 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 1.1630288186 * (pk_Baloon_mortgage - 0), 0);

_x11_10_c44 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 20.370965388 * (pk_phones_per_addr_S2_2m - 0.011890263), 0);

_9t_1_c44 := if((string)pk_Segment_40 = '2 Owner', 13.300651322 * (pk_PhnProb_S2_2m - 0.0110535714), 0);

_9r_8_c44 := if((string)pk_Segment_40 = '2 Owner', 22.698241364 * (pk_mth_gong_did_fst_sn2_S2_2m - 0.0143733489), 0);

_9d_10_c44 := if((string)pk_Segment_40 = '2 Owner', 8.9339801963 * (pk_addrs_5yr_S2_2m - 0.013676897), 0);

seg_s3_c45_b1 := -3.58414938616816;

_ms_6_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 29.594364353 * (pk_ssns_per_adl_S3_3m - 0.0260587993), 0);

_9q_8_c45 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 5.9686575266 * (pk_inq_peraddr_3m - 0.0246590642), 0);

_x11_14_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 23.940623893 * (pk_phones_per_addr_c6_3m - 0.024502514), 0);

_x11_15_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 13.213015025 * (pk_phones_per_addr_S3_3m - 0.0298539519), 0);

_9d_11_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 18.805570748 * (pk_addrs_per_ssn_c6_S3_3m - 0.0257084742), 0);

_pv_4_c45 := if((string)pk_Segment_40 = '3 Other', 25.02124434 * (pk_add1_avm_auto_val_S3_3m - 0.0268399371), 0);

_9q_9_c45 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 5.026470537 * (pk_inq_adlsperphone_S3_3m - 0.0246590642), 0);

_9u_3_c45 := if((string)pk_Segment_40 = '3 Other', 10.028036081 * (pk_AddProb_S3_3m - 0.0284013395), 0);

_9r_9_c45 := if((string)pk_Segment_40 = '3 Other', m_email_mod_3m * 31.051485866 * (pk_em_domain_free_count_s3_3m - 0.0264255452), 0);

_9a_7_c45 := if((string)pk_Segment_40 = '3 Other', (seg_s3_c45_b1 - -4.248466382), 0);

_9q_7_c45 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 7.3435047646 * (pk_inq_recent_lvl_S3_3m - 0.0246590642), 0);

_9d_13_c45 := if((string)pk_Segment_40 = '3 Other', 10.250404543 * (pk_addrs_5yr_S3_3m - 0.0321017432), 0);

_x11_13_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 20.663453736 * (pk_ssns_per_addr_c6_S3_3m - 0.0223274821), 0);

_9r_11_c45 := if((string)pk_Segment_40 = '3 Other', 11.303700779 * (pk_mth_gong_did_fst_sn2_S3_3m - 0.0246165008), 0);

_9s_5_c45 := if((string)pk_Segment_40 = '3 Other', m_financing_mod_3m * 0.6638882749 * (pk_2nd_mortgage - 0), 0);

_9c_1_c45 := if((string)pk_Segment_40 = '3 Other', 2.710798666 * (pk_mth_add1_date_fst_sn2_S3_3m - 0.0270079019), 0);

_9d_12_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 22.92767413 * (pk_attr_addrs_last36_S3_3m - 0.0337372362), 0);

_9a_6_c45 := if((string)pk_Segment_40 = '3 Other', m_prop_owner_mod_3m * 45.975872588 * (pk_ver_src_P_3m - 0.0307300509), 0);

_9m_4_c45 := if((string)pk_Segment_40 = '3 Other', 9.9328006071 * (pk_estimated_income_S3_3m - 0.0213391108), 0);

_x11_12_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 21.241190975 * (pk_phones_per_adl_c6_S3_3m - 0.0290419517), 0);

_28_3_c45 := if((string)pk_Segment_40 = '3 Other', 10.879814814 * (pk_dob_ver_3m - 0.0234464902), 0);

_36_3_c45 := if((string)pk_Segment_40 = '3 Other', 8.3122146315 * (pk_verx_S3_3m - 0.0291564173), 0);

_x11_16_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 22.097757033 * (pk_adls_per_phone_3m - 0.0207262387), 0);

_9r_10_c45 := if((string)pk_Segment_40 = '3 Other', 17.317516468 * (pk_Contrary_Infutor_Ver_3m - 0.0247989169), 0);

_9s_6_c45 := if((string)pk_Segment_40 = '3 Other', m_financing_mod_3m * 0.2750406154 * (pk_adj_finance - 0), 0);

_mi_2_c45 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 33.710646116 * (pk_adlperssn_count_S3_3m - 0.0255366098), 0);

_25_2_c45 := if((string)pk_Segment_40 = '3 Other', 10.471164629 * (pk_add1_house_number_match_3m - 0.0242905395), 0);

seg_s0_crime_c47_b1 := -2.81454014268427;
Seg_S0_Crime := seg_s0_crime_c47_b1;

_97_0_c47 := if(bs_attr_derog_flag > 0 and criminal_count > 0, (Seg_S0_Crime - -4.248466382), 0);

seg_s0_lien_c48_b1 := -2.81454014268427;
Seg_S0_Lien := seg_s0_lien_c48_b1;


_98_0_c48 := if(lien_flag, (Seg_S0_Lien - -4.248466382), 0);

seg_s0_eviction_c49_b1 := -2.81454014268427;
seg_s0_eviction := seg_s0_eviction_c49_b1;

_ev_0_c49 := if(bs_attr_eviction_flag > 0, (Seg_S0_Eviction - -4.248466382), 0);

seg_s0_impulse_c50_b1 := -2.81454014268427;
seg_s0_impulse := seg_s0_impulse_c50_b1;

_9h_0_c50 := if(pk_impulse_count > 0, (Seg_S0_Impulse - -4.248466382), 0);

seg_s0_bk_c51_b1 := -2.81454014268427;
seg_s0_bk := seg_s0_bk_c51_b1;

_9w_0_c51 := if(bk_flag, (Seg_S0_BK - -4.248466382), 0);

_9d_3_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.8444054 * (pk_recent_addr_S0_0m - 0.0507715281), 0);

_9q_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 3.990328493 * (pk_inq_recent_lvl_S0_0m - 0.0510322723), 0);

_ev_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 7.3700576551 * (pk_eviction_lvl_0m - 0.0536455151), 0);

_x11_3_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 6.3078515686 * (pk_ssns_per_addr_0m - 0.0544585462), 0);

_9h_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 2.4931427584 * (pk_impulse_flag - 0), 0);

_9w_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 16.011084801 * (bankrupt_0m - 0.055950981), 0);

_x11_2_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 18.807703437 * (pk_phones_per_adl_S0_0m - 0.0667526604), 0);

_9g_1_c46 := if((string)pk_Segment_40 = '0 Derog', 2.9990337154 * (pk_age_estimate_S0_0m - 0.0535984276), 0);

_9s_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_financing_mod_0m * 1.209994132 * (pk_Baloon_mortgage - 0), 0);

_36_1_c46 := if((string)pk_Segment_40 = '0 Derog', 4.8772596717 * (pk_verx_S0_0m - 0.0593320236), 0);

_ms_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.5370768191 * (pk_ssns_per_adl_c6_0m - 0.0496577474), 0);

_9a_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 12.516565479 * (pk_ver_src_P_0m - 0.0386540352), 0);

_9w_0_c46 := if((string)pk_Segment_40 = '0 Derog', _9w_0_c51, 0);

_x11_4_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 11.589909799 * (pk_phones_per_addr_S0_0m - 0.0581807725), 0);

_9e_1_c46 := if((string)pk_Segment_40 = '0 Derog', 2.8365945639 * (pk_num_nonderogs90_S0_0m - 0.0492027702), 0);

_98_0_c46 := if((string)pk_Segment_40 = '0 Derog', _98_0_c48, 0);

_97_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 13.143708695 * (pk_crim_fel_flag_0m - 0.0547007453), 0);

_9m_1_c46 := if((string)pk_Segment_40 = '0 Derog', 2.9053537317 * (pk_estimated_income_S0_0m - 0.0389371862), 0);

_ms_2_c46 := if((string)pk_Segment_40 = '0 Derog', 12.283213577 * (ssn_adl_prob_0m - 0.0549828179), 0);

_9q_3_c46 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 4.0228807529 * (pk_inq_adlsperphone_S0_0m - 0.0510322723), 0);

_98_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_derog_mod_0m * 8.9466402638 * (pk_unrel_lien_lvl_0m - 0.0524842018), 0);

_ev_0_c46 := if((string)pk_Segment_40 = '0 Derog', _ev_0_c49, 0);

_9q_2_c46 := if((string)pk_Segment_40 = '0 Derog', m_inquiry_mod_0m * 2.0027290764 * (pk_inq_peradl_S0_0m - 0.0510322723), 0);

_9h_0_c46 := if((string)pk_Segment_40 = '0 Derog', _9h_0_c50, 0);

_9d_2_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 5.4544984232 * (pk_attr_addrs_last24_S0_0m - 0.0447368421), 0);

_9d_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 10.870842239 * (pk_addrs_per_ssn_c6_S0_0m - 0.052182623), 0);

_9d_4_c46 := if((string)pk_Segment_40 = '0 Derog', 5.5050099401 * (pk_addrs_5yr_S0_0m - 0.0616986301), 0);

_9n_1_c46 := if((string)pk_Segment_40 = '0 Derog', 1.32874535 * (pk_addrs_prison_history - 0), 0);

_9a_3_c46 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 8.2491242885 * (pk_add1_naprop4_0m - 0.0363378114), 0);

_9r_1_c46 := if((string)pk_Segment_40 = '0 Derog', 3.521698492 * (pk_mth_gong_did_fst_sn2_S0_0m - 0.0472106878), 0);

_pv_1_c46 := if((string)pk_Segment_40 = '0 Derog', 7.9015940165 * (pk_add1_avm_auto_val_S0_0m - 0.0598949212), 0);

_97_0_c46 := if((string)pk_Segment_40 = '0 Derog', _97_0_c47, 0);

_x11_1_c46 := if((string)pk_Segment_40 = '0 Derog', m_velo_mod_0m * 8.222562725 * (pk_ssns_per_addr_c6_S0_0m - 0.0479833951), 0);

_9a_2_c46 := if((string)pk_Segment_40 = '0 Derog', m_prop_owner_mod_0m * 5.7187605132 * (pk_prop_owned_purch_flag_0m - 0.063502861), 0);

seg_s1_c52_b1 := -2.34017557597253;

_x11_5_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 9.5011342145 * (pk_ssns_per_addr_c6_S1_1m - 0.0677562778), 0);

_x11_6_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 9.112129103 * (pk_phones_per_addr_c6_1m - 0.0840170509), 0);

_9q_4_c52 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod_1m * 4.7485458561 * (pk_inq_recent_lvl_S1_1m - 0.076869551), 0);

_9g_2_c52 := if((string)pk_Segment_40 = '1 Young', (seg_s1_c52_b1 - -4.248466382), 0);

_9r_4_c52 := if((string)pk_Segment_40 = '1 Young', 3.8447802442 * (pk_time_since_CB3_1m - 0.0870101244), 0);

_9e_2_c52 := if((string)pk_Segment_40 = '1 Young', 9.0980023527 * (pk_nap_summary_ver_S1_1m - 0.0933044932), 0);

_ms_4_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 3.0964475191 * (pk_ssns_per_adl_c6_1m - 0.0746622422), 0);

_9r_3_c52 := if((string)pk_Segment_40 = '1 Young', 8.6557765439 * (pk_mth_gong_did_fst_sn2_S1_1m - 0.0873078961), 0);

_pv_2_c52 := if((string)pk_Segment_40 = '1 Young', 8.9942707659 * (pk_add1_avm_auto_val_S1_1m - 0.0956815016), 0);

_9a_4_c52 := if((string)pk_Segment_40 = '1 Young', m_prop_owner_mod_1m * 11.50422511 * (pk_ver_src_P_1m - 0.0907238734), 0);

_9d_6_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 7.8795300804 * (pk_attr_addrs_last12_S1_1m - 0.0725928619), 0);

_36_2_c52 := if((string)pk_Segment_40 = '1 Young', 4.3447325497 * (pk_verx_S1_1m - 0.0839347934), 0);

_9q_5_c52 := if((string)pk_Segment_40 = '1 Young', m_inquiry_mod_1m * 3.7210059561 * (pk_inq_peraddr_1m - 0.076869551), 0);

_9g_3_c52 := if((string)pk_Segment_40 = '1 Young', 7.5438290771 * (pk_age_estimate_S1_1m - 0.0736484722), 0);

_9a_5_c52 := if((string)pk_Segment_40 = '1 Young', m_prop_owner_mod_1m * 8.6236762719 * (pk_add1_naprop4_1m - 0.090376569), 0);

_mi_1_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 11.80976186 * (pk_adlperssn_count_S1_1m - 0.0847328244), 0);

_9u_1_c52 := if((string)pk_Segment_40 = '1 Young', 6.6590588025 * (pk_AddProb_S1_1m - 0.0879845402), 0);

_9r_2_c52 := if((string)pk_Segment_40 = '1 Young', m_email_mod_1m * 11.248723668 * (pk_email_count_S1_1m - 0.0876497315), 0);

_9d_5_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 10.091573956 * (pk_addrs_per_ssn_c6_S1_1m - 0.0826655052), 0);

_mi_2_c52 := if((string)pk_Segment_40 = '1 Young', 7.7832928559 * (pk_adlperssn_count_S1_1m - 0.0847328244), 0);

_ms_3_c52 := if((string)pk_Segment_40 = '1 Young', m_velo_mod_1m * 11.065233911 * (pk_ssns_per_adl_S1_1m - 0.086062889), 0);

_9m_2_c52 := if((string)pk_Segment_40 = '1 Young', 3.0795096918 * (pk_estimated_income_S1_1m - 0.0834858188), 0);

_9m_3_c53 := if((string)pk_Segment_40 = '2 Owner', 43.827944495 * (pk_estimated_income_S2_2m - 0.0145617705), 0);

_9r_5_c53 := if((string)pk_Segment_40 = '2 Owner', m_email_mod_2m * 51.001538056 * (pk_em_domain_free_count_s2_2m - 0.0137043715), 0);

_9g_4_c53 := if((string)pk_Segment_40 = '2 Owner', 30.311783204 * (pk_age_estimate_S2_2m - 0.014131362), 0);

_pv_3_c53 := if((string)pk_Segment_40 = '2 Owner', 41.98475476 * (pk_add1_avm_auto_val_S2_2m - 0.0148375451), 0);

_ms_5_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 50.665296275 * (pk_ssns_per_adl_S2_2m - 0.0131222201), 0);

_9d_7_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 37.436601044 * (pk_addrs_per_ssn_c6_S2_2m - 0.0133419076), 0);

_9q_6_c53 := if((string)pk_Segment_40 = '2 Owner', m_inquiry_mod_2m * 32.623012423 * (pk_mth_inq_frst_log_dt2_S2_2m - 0.0137038529), 0);

_x11_8_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * -30.29448194 * (pk_adls_per_phone_c6_2m - 0.0111842197), 0);

_9u_2_c53 := if((string)pk_Segment_40 = '2 Owner', 21.194302356 * (pk_AddProb_S2_2m - 0.0140507795), 0);

_9s_2_c53 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 0.7259505049 * (pk_2nd_mortgage - 0), 0);

_25_1_c53 := if((string)pk_Segment_40 = '2 Owner', 27.934356076 * (pk_add1_house_number_match_2m - 0.0132671939), 0);

_x11_9_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 30.311887525 * (pk_ssns_per_addr_2m - 0.0134892288), 0);

_9d_8_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 24.47530058 * (pk_attr_addrs_last36_S2_2m - 0.0100559976), 0);

_9r_6_c53 := if((string)pk_Segment_40 = '2 Owner', 18.388436107 * (pk_Contrary_Infutor_Ver_2m - 0.0133991912), 0);

_x11_7_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 25.607924542 * (pk_adls_per_addr_c6_S2_2m - 0.0119689787), 0);

_9d_9_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 21.510962018 * (pk_recent_addr_S2_2m - 0.0100559976), 0);

_99_1_c53 := if((string)pk_Segment_40 = '2 Owner', 0.1530566986 * ((integer)rc_input_addr_not_most_recent - 0), 0);

_9s_4_c53 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 0.351346294 * (pk_adj_finance - 0), 0);

_x11_11_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 63.388740934 * (pk_adls_per_phone_2m - 0.0107968018), 0);

_9r_7_c53 := if((string)pk_Segment_40 = '2 Owner', 22.992018739 * (pk_mth_gong_did_fst_sn2_S2_2m - 0.0143733489), 0);

_9s_3_c53 := if((string)pk_Segment_40 = '2 Owner', m_financing_mod_2m * 1.1630288186 * (pk_Baloon_mortgage - 0), 0);

_x11_10_c53 := if((string)pk_Segment_40 = '2 Owner', m_velo_mod_2m * 20.370965388 * (pk_phones_per_addr_S2_2m - 0.011890263), 0);

_9t_1_c53 := if((string)pk_Segment_40 = '2 Owner', 13.341843655 * (pk_PhnProb_S2_2m - 0.0110535714), 0);

_9d_10_c53 := if((string)pk_Segment_40 = '2 Owner', 8.4166631522 * (pk_addrs_5yr_S2_2m - 0.013676897), 0);

seg_s3_c54_b1 := -3.58414938616816;

_ms_6_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 29.594364353 * (pk_ssns_per_adl_S3_3m - 0.0260587993), 0);

_9q_8_c54 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 5.9686575266 * (pk_inq_peraddr_3m - 0.0246590642), 0);

_x11_14_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 23.940623893 * (pk_phones_per_addr_c6_3m - 0.024502514), 0);

_x11_15_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 13.213015025 * (pk_phones_per_addr_S3_3m - 0.0298539519), 0);

_mi_3_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 33.710646116 * (pk_adlperssn_count_S3_3m - 0.0255366098), 0);

_9d_11_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 18.805570748 * (pk_addrs_per_ssn_c6_S3_3m - 0.0257084742), 0);

_pv_4_c54 := if((string)pk_Segment_40 = '3 Other', 26.986478198 * (pk_add1_avm_auto_val_S3_3m - 0.0268399371), 0);

_9q_9_c54 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 5.026470537 * (pk_inq_adlsperphone_S3_3m - 0.0246590642), 0);

_9u_3_c54 := if((string)pk_Segment_40 = '3 Other', 8.3556593541 * (pk_AddProb_S3_3m - 0.0284013395), 0);

_9a_7_c54 := if((string)pk_Segment_40 = '3 Other', (seg_s3_c54_b1 - -4.248466382), 0);

_9r_9_c54 := if((string)pk_Segment_40 = '3 Other', 16.419477069 * (pk_Contrary_Infutor_Ver_3m - 0.0247989169), 0);

_9q_7_c54 := if((string)pk_Segment_40 = '3 Other', m_inquiry_mod_3m * 7.3435047646 * (pk_inq_recent_lvl_S3_3m - 0.0246590642), 0);

_9d_13_c54 := if((string)pk_Segment_40 = '3 Other', 8.586665481 * (pk_addrs_5yr_S3_3m - 0.0321017432), 0);

_x11_13_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 20.663453736 * (pk_ssns_per_addr_c6_S3_3m - 0.0223274821), 0);

_ms_7_c54 := if((string)pk_Segment_40 = '3 Other', 17.347371803 * (pk_ssns_per_adl_S3_3m - 0.0260587993), 0);

_9s_5_c54 := if((string)pk_Segment_40 = '3 Other', m_financing_mod_3m * 0.6638882749 * (pk_2nd_mortgage - 0), 0);

_9g_5_c54 := if((string)pk_Segment_40 = '3 Other', 15.887767473 * (pk_age_estimate_S3_3m - 0.030909973), 0);

_9d_12_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 22.92767413 * (pk_attr_addrs_last36_S3_3m - 0.0337372362), 0);

_9a_6_c54 := if((string)pk_Segment_40 = '3 Other', m_prop_owner_mod_3m * 45.975872588 * (pk_ver_src_P_3m - 0.0307300509), 0);

_9m_4_c54 := if((string)pk_Segment_40 = '3 Other', 7.015814043 * (pk_estimated_income_S3_3m - 0.0213391108), 0);

_x11_12_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 21.241190975 * (pk_phones_per_adl_c6_S3_3m - 0.0290419517), 0);

_36_3_c54 := if((string)pk_Segment_40 = '3 Other', 9.2776087205 * (pk_verx_S3_3m - 0.0291564173), 0);

_x11_16_c54 := if((string)pk_Segment_40 = '3 Other', m_velo_mod_3m * 22.097757033 * (pk_adls_per_phone_3m - 0.0207262387), 0);

_9r_10_c54 := if((string)pk_Segment_40 = '3 Other', 10.797828779 * (pk_mth_gong_did_fst_sn2_S3_3m - 0.0246165008), 0);

_9s_6_c54 := if((string)pk_Segment_40 = '3 Other', m_financing_mod_3m * 0.2750406154 * (pk_adj_finance - 0), 0);

_9r_8_c54 := if((string)pk_Segment_40 = '3 Other', m_email_mod_3m * 31.051485866 * (pk_em_domain_free_count_s3_3m - 0.0264255452), 0);

_25_2_c54 := if((string)pk_Segment_40 = '3 Other', 12.439705792 * (pk_add1_house_number_match_3m - 0.0242905395), 0);

_ms_6 := if((integer)dobpop = 1, _ms_6_c45, _ms_6_c54);

_9q_8 := if((integer)dobpop = 1, _9q_8_c45, _9q_8_c54);

_9m_3 := if((integer)dobpop = 1, _9m_3_c44, _9m_3_c53);

_9d_11 := if((integer)dobpop = 1, _9d_11_c45, _9d_11_c54);

_9d_3 := if((integer)dobpop = 1, _9d_3_c36, _9d_3_c46);

_9q_9 := if((integer)dobpop = 1, _9q_9_c45, _9q_9_c54);

_9q_1 := if((integer)dobpop = 1, _9q_1_c36, _9q_1_c46);

_9q_6 := if((integer)dobpop = 1, _9q_6_c44, _9q_6_c53);

_9u_3 := if((integer)dobpop = 1, _9u_3_c45, _9u_3_c54);

_9a_7 := if((integer)dobpop = 1, _9a_7_c45, _9a_7_c54);

_ev_1 := if((integer)dobpop = 1, _ev_1_c36, _ev_1_c46);

_9w_1 := if((integer)dobpop = 1, _9w_1_c36, _9w_1_c46);

_25_1 := if((integer)dobpop = 1, _25_1_c44, _25_1_c53);

_9s_1 := if((integer)dobpop = 1, _9s_1_c36, _9s_1_c46);

_x11_13 := if((integer)dobpop = 1, _x11_13_c45, _x11_13_c54);

_9a_1 := if((integer)dobpop = 1, _9a_1_c36, _9a_1_c46);

_ms_1 := if((integer)dobpop = 1, _ms_1_c36, _ms_1_c46);

_36_1 := if((integer)dobpop = 1, _36_1_c36, _36_1_c46);

_9s_5 := if((integer)dobpop = 1, _9s_5_c45, _9s_5_c54);

_9q_5 := if((integer)dobpop = 1, _9q_5_c42, _9q_5_c52);

_99_1 := if((integer)dobpop = 1, _99_1_c44, _99_1_c53);

_9a_6 := if((integer)dobpop = 1, _9a_6_c45, _9a_6_c54);

_x11_12 := if((integer)dobpop = 1, _x11_12_c45, _x11_12_c54);

_98_0 := if((integer)dobpop = 1, _98_0_c36, _98_0_c46);

_9s_3 := if((integer)dobpop = 1, _9s_3_c44, _9s_3_c53);

_ms_2 := if((integer)dobpop = 1, _ms_2_c36, _ms_2_c46);

_mi_2 := if((integer)dobpop = 1, _mi_2_c45, _mi_2_c52);

_x11_5 := if((integer)dobpop = 1, _x11_5_c42, _x11_5_c52);

_9q_3 := if((integer)dobpop = 1, _9q_3_c36, _9q_3_c46);

_ev_0 := if((integer)dobpop = 1, _ev_0_c36, _ev_0_c46);

_9q_4 := if((integer)dobpop = 1, _9q_4_c42, _9q_4_c52);

_9q_2 := if((integer)dobpop = 1, _9q_2_c36, _9q_2_c46);

_9g_2 := if((integer)dobpop = 1, _9g_2_c42, _9g_2_c52);

_9g_4 := if((integer)dobpop = 1, _9g_4_c42, _9g_4_c53);

_ms_5 := if((integer)dobpop = 1, _ms_5_c44, _ms_5_c53);

_9u_2 := if((integer)dobpop = 1, _9u_2_c44, _9u_2_c53);

_9s_2 := if((integer)dobpop = 1, _9s_2_c44, _9s_2_c53);

_9d_4 := if((integer)dobpop = 1, _9d_4_c36, _9d_4_c46);

_ms_7 := if((integer)dobpop = 1, 0, _ms_7_c54);

_9n_1 := if((integer)dobpop = 1, _9n_1_c36, _9n_1_c46);

_36_2 := if((integer)dobpop = 1, _36_2_c42, _36_2_c52);

_9a_5 := if((integer)dobpop = 1, _9a_5_c42, _9a_5_c52);

_x11_11 := if((integer)dobpop = 1, _x11_11_c44, _x11_11_c53);

_9m_4 := if((integer)dobpop = 1, _9m_4_c45, _9m_4_c54);

_9r_7 := if((integer)dobpop = 1, _9r_7_c44, _9r_7_c53);

_36_3 := if((integer)dobpop = 1, _36_3_c45, _36_3_c54);

_97_0 := if((integer)dobpop = 1, _97_0_c36, _97_0_c46);

_9d_5 := if((integer)dobpop = 1, _9d_5_c42, _9d_5_c52);

_x11_10 := if((integer)dobpop = 1, _x11_10_c44, _x11_10_c53);

_9r_8 := if((integer)dobpop = 1, _9r_8_c44, _9r_8_c54);

_9d_10 := if((integer)dobpop = 1, _9d_10_c44, _9d_10_c53);

_x11_1 := if((integer)dobpop = 1, _x11_1_c36, _x11_1_c46);

_x11_6 := if((integer)dobpop = 1, _x11_6_c42, _x11_6_c52);

_pv_4 := if((integer)dobpop = 1, _pv_4_c45, _pv_4_c54);

_9r_5 := if((integer)dobpop = 1, _9r_5_c42, _9r_5_c53);

_9r_4 := if((integer)dobpop = 1, _9r_4_c42, _9r_4_c52);

_9e_2 := if((integer)dobpop = 1, _9e_2_c42, _9e_2_c52);

_x11_3 := if((integer)dobpop = 1, _x11_3_c36, _x11_3_c46);

_9h_1 := if((integer)dobpop = 1, _9h_1_c36, _9h_1_c46);

_9d_13 := if((integer)dobpop = 1, _9d_13_c45, _9d_13_c54);

_ms_4 := if((integer)dobpop = 1, _ms_4_c42, _ms_4_c52);

_x11_2 := if((integer)dobpop = 1, _x11_2_c36, _x11_2_c46);

_9g_1 := if((integer)dobpop = 1, _9g_1_c36, _9g_1_c46);

_9r_3 := if((integer)dobpop = 1, _9r_3_c42, _9r_3_c52);

_9r_11 := if((integer)dobpop = 1, _9r_11_c45, _9r_11_1);

_pv_2 := if((integer)dobpop = 1, _pv_2_c42, _pv_2_c52);

_9g_5 := if((integer)dobpop = 1, _9g_5_c44, _9g_5_c54);

_9r_6 := if((integer)dobpop = 1, _9r_6_c44, _9r_6_c53);

_9a_4 := if((integer)dobpop = 1, _9a_4_c42, _9a_4_c52);

_9w_0 := if((integer)dobpop = 1, _9w_0_c36, _9w_0_c46);

_9d_6 := if((integer)dobpop = 1, _9d_6_c42, _9d_6_c52);

_x11_4 := if((integer)dobpop = 1, _x11_4_c36, _x11_4_c46);

_9c_1 := if((integer)dobpop = 1, _9c_1_c45, _9c_1_1);

_9e_1 := if((integer)dobpop = 1, _9e_1_c36, _9e_1_c46);

_9d_12 := if((integer)dobpop = 1, _9d_12_c45, _9d_12_c54);

_mi_1 := if((integer)dobpop = 1, _mi_1_c42, _mi_1_c52);

_97_1 := if((integer)dobpop = 1, _97_1_c36, _97_1_c46);

_9u_1 := if((integer)dobpop = 1, _9u_1_c42, _9u_1_c52);

_9m_1 := if((integer)dobpop = 1, _9m_1_c36, _9m_1_c46);

_x11_16 := if((integer)dobpop = 1, _x11_16_c45, _x11_16_c54);

_9r_10 := if((integer)dobpop = 1, _9r_10_c45, _9r_10_c54);

_9t_1 := if((integer)dobpop = 1, _9t_1_c44, _9t_1_c53);

_98_1 := if((integer)dobpop = 1, _98_1_c36, _98_1_c46);

_x11_14 := if((integer)dobpop = 1, _x11_14_c45, _x11_14_c54);

_x11_15 := if((integer)dobpop = 1, _x11_15_c45, _x11_15_c54);

_mi_3 := if((integer)dobpop = 1, 0, _mi_3_c54);

_9h_0 := if((integer)dobpop = 1, _9h_0_c36, _9h_0_c46);

_9j_0 := 0;
_9j_1 := if((integer)dobpop = 0 and (string)pk_Segment_40 = '2 Owner', 8.7948373806 * (pk_mth_hdr_frst_sn_S2_2m - 0.0099346299), 0);

_28_2 := if((integer)dobpop = 1, _28_2_c44, _28_2_1);

_pv_3 := if((integer)dobpop = 1, _pv_3_c44, _pv_3_c53);

_9d_2 := if((integer)dobpop = 1, _9d_2_c36, _9d_2_c46);

_9d_7 := if((integer)dobpop = 1, _9d_7_c44, _9d_7_c53);

_9d_1 := if((integer)dobpop = 1, _9d_1_c36, _9d_1_c46);

_9r_9 := if((integer)dobpop = 1, _9r_9_c45, _9r_9_c54);

_x11_8 := if((integer)dobpop = 1, _x11_8_c44, _x11_8_c53);

_9q_7 := if((integer)dobpop = 1, _9q_7_c45, _9q_7_c54);

_x11_9 := if((integer)dobpop = 1, _x11_9_c44, _x11_9_c53);

_9d_8 := if((integer)dobpop = 1, _9d_8_c44, _9d_8_c53);

_x11_7 := if((integer)dobpop = 1, _x11_7_c44, _x11_7_c53);

_9d_9 := if((integer)dobpop = 1, _9d_9_c44, _9d_9_c53);

_28_1 := if((integer)dobpop = 1, _28_1_c42, _28_1_1);

_9g_3 := if((integer)dobpop = 1, _9g_3_c42, _9g_3_c52);

_9s_4 := if((integer)dobpop = 1, _9s_4_c44, _9s_4_c53);

_9a_3 := if((integer)dobpop = 1, _9a_3_c36, _9a_3_c46);

_28_3 := if((integer)dobpop = 1, _28_3_c45, _28_3_1);

_9r_1 := if((integer)dobpop = 1, _9r_1_c36, _9r_1_c46);

_pv_1 := if((integer)dobpop = 1, _pv_1_c36, _pv_1_c46);

_9r_2 := if((integer)dobpop = 1, _9r_2_c42, _9r_2_c52);

_9s_6 := if((integer)dobpop = 1, _9s_6_c45, _9s_6_c54);

_ms_3 := if((integer)dobpop = 1, _ms_3_c42, _ms_3_c52);

_9m_2 := if((integer)dobpop = 1, _9m_2_c42, _9m_2_c52);

_9a_2 := if((integer)dobpop = 1, _9a_2_c36, _9a_2_c46);

_25_2 := if((integer)dobpop = 1, _25_2_c45, _25_2_c54);

_25 := glrc25 * sum(_25_0, _25_1, _25_2);

_28 := glrc28 * sum(_28_0, _28_1, _28_2, _28_3);

_36 := glrc36 * sum(_36_0, _36_1, _36_2, _36_3);

_97 := glrc97 * sum(_97_0, _97_1);

_98 := glrc98 * sum(_98_0, _98_1);

_99 := (integer)glrc99 * sum(_99_0, _99_1);

_9a := glrc9a * sum(_9a_0, _9a_1, _9a_2, _9a_3, _9a_4, _9a_5, _9a_6, _9a_7);

_9c := glrc9c * sum(_9c_0, _9c_1);

_9d := glrc9d * sum(_9d_0, _9d_1, _9d_2, _9d_3, _9d_4, _9d_5, _9d_6, _9d_7, _9d_8, _9d_9, _9d_10, _9d_11, _9d_12, _9d_13);

_9e := glrc9e * sum(_9e_0, _9e_1, _9e_2);

_9g := glrc9g * sum(_9g_0, _9g_1, _9g_2, _9g_3, _9g_4, _9g_5);

_9h := glrc9h * sum(_9h_0, _9h_1);

_9j := glrc9j * sum(_9j_0, _9j_1);

_9m := glrc9m * sum(_9m_0, _9m_1, _9m_2, _9m_3, _9m_4);

_9n := glrc9n * sum(_9n_0, _9n_1);

_9q := glrc9q * sum(_9q_0, _9q_1, _9q_2, _9q_3, _9q_4, _9q_5, _9q_6, _9q_7, _9q_8, _9q_9);

_9r := glrc9r * sum(_9r_0, _9r_1, _9r_2, _9r_3, _9r_4, _9r_5, _9r_6, _9r_7, _9r_8, _9r_9, _9r_10, _9r_11);

_9s := glrc9s * sum(_9s_0, _9s_1, _9s_2, _9s_3, _9s_4, _9s_5, _9s_6);

_9t := glrc9t * sum(_9t_0, _9t_1);

_9u := glrc9u * sum(_9u_0, _9u_1, _9u_2, _9u_3);

_9w := glrc9w * sum(_9w_0, _9w_1, _9w_2);

_ev := glrcev * sum(_ev_0, _ev_1);

_mi := glrcmi * sum(_mi_0, _mi_1, _mi_2, _mi_3);

_ms := glrcms * sum(_ms_0, _ms_1, _ms_2, _ms_3, _ms_4, _ms_5, _ms_6, _ms_7);

_pv := glrcpv * sum(_pv_0, _pv_1, _pv_2, _pv_3, _pv_4);

_x11 := glrcx11 * sum(_x11_0, _x11_1, _x11_2, _x11_3, _x11_4, _x11_5, _x11_6, _x11_7, _x11_8, _x11_9, _x11_10, _x11_11, _x11_12, _x11_13, _x11_14, _x11_15, _x11_16);

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'25', _25},
	{'28', _28},
	{'36', _36},
	{'97', _97},
	{'98', _98},
	{'99', _99},
	{'9A', _9a},
	{'9C', _9c},
	{'9D', _9d},
	{'9E', _9e},
	{'9G', _9g},
	{'9H', _9h},
	{'9J', _9j},
	{'9M', _9m},
	{'9N', _9n},
	{'9Q', _9q},
	{'9R', _9r},
	{'9S', _9s},
	{'9T', _9t},
	{'9U', _9u},
	{'9W', _9w},
	{'EV', _ev},
	{'MI', _mi},
	{'MS', _ms},
	{'PV', _pv},
	{'X11', _x11}
	], ds_layout)(value > 0);

rcs_top4 := choosen(sort(rc_dataset, -value), 4);




	/* pop rc5 as inquiry if it's triggered and not in rc1-rc4     ***********/
	rcs_9q := rcs_top4 &
		if(
			GLRC9Q=1
			and 0 = count( rcs_top4( rc='9Q' ) )
			and (
				( pk_inq_peradl_S0_0m > 0.0510322723           and pk_Segment_40 = '0 Derog' ) or
				( pk_inq_recent_lvl_S1_1m > 0.076869551        and pk_Segment_40 = '1 Young' ) or
				( pk_mth_inq_frst_log_dt2_S2_2m > 0.0137038529 and pk_Segment_40 = '2 Owner' ) or
				( pk_inq_recent_lvl_S3_3m > 0.0246590642       and pk_Segment_40 = '3 Other' )
			),
		dataset( [{'9Q', NULL}], ds_layout )
	);


	rcs_9g_9a := map(
		pk_segment_40 = '3 Other' and 0=count(rcs_9q) => dataset( [{'9A', NULL}], ds_layout ),
		// pk_segment_40 = '' and 0=count(rcs_9q) => dataset( [{'9G', NULL}], ds_layout ), // apparently no 9G override for bankcard
		rcs_9q
	);

	rcs_override := map(
		rvb1104 = 222 => dataset( [{'9X', NULL}], ds_layout ),
		rvb1104 = 200 => dataset( [{'02', NULL}], ds_layout ),
		0 = count( rcs_9g_9a ) => dataset( [{'36', NULL}], ds_layout ),
		rcs_9g_9a
	);


		#if(RVB_DEBUG)
			self.clam := le;
			self.truedid := truedid;
			self.out_addr_type := out_addr_type;
			self.out_addr_status := out_addr_status;
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
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_addrcommflag := rc_addrcommflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_phonetype := rc_phonetype;
			self.combo_dobscore := combo_dobscore;
			self.ver_sources := ver_sources;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_sources_last_seen := ver_sources_last_seen;
			self.ver_dob_sources := ver_dob_sources;
			self.ssnlength := ssnlength;
			self.dobpop := dobpop;
			self.add1_house_number_match := add1_house_number_match;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_advo_throw_back := add1_advo_throw_back;
			self.add1_advo_seasonal_delivery := add1_advo_seasonal_delivery;
			self.add1_advo_college := add1_advo_college;
			self.add1_advo_drop := add1_advo_drop;
			self.add1_advo_res_or_business := add1_advo_res_or_business;
			self.add1_advo_mixed_address_usage := add1_advo_mixed_address_usage;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_date_first_seen := add1_date_first_seen;
			self.property_owned_total := property_owned_total;
			self.property_owned_purchase_count := property_owned_purchase_count;
			self.property_sold_total := property_sold_total;
			self.addrs_5yr := addrs_5yr;
			self.addrs_prison_history := addrs_prison_history;
			self.addr_hist_advo_college := addr_hist_advo_college;
			self.telcordia_type := telcordia_type;
			self.gong_did_first_seen := gong_did_first_seen;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.phones_per_adl_c6 := phones_per_adl_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.inq_first_log_date := inq_first_log_date;
			self.inq_count03 := inq_count03;
			self.inq_count06 := inq_count06;
			self.inq_count12 := inq_count12;
			self.inq_peradl := inq_peradl;
			self.inq_peraddr := inq_peraddr;
			self.inq_adlsperphone := inq_adlsperphone;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_source_list := email_source_list;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_num_unrel_liens180 := attr_num_unrel_liens180;
			self.attr_num_unrel_liens12 := attr_num_unrel_liens12;
			self.attr_num_unrel_liens24 := attr_num_unrel_liens24;
			self.attr_num_unrel_liens60 := attr_num_unrel_liens60;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_eviction_count180 := attr_eviction_count180;
			self.attr_eviction_count12 := attr_eviction_count12;
			self.attr_eviction_count24 := attr_eviction_count24;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.ams_class := ams_class;
			self.ams_college_code := ams_college_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.estimated_income := estimated_income;
			self.archive_date := archive_date;


			self.sysdate                          := sysdate;
			self.in_dob2                          := in_dob2;
			self.yr_in_dob                        := yr_in_dob;
			self.add1_date_first_seen2            := add1_date_first_seen2;
			self.mth_add1_date_first_seen         := mth_add1_date_first_seen;
			self.gong_did_first_seen2             := gong_did_first_seen2;
			self.mth_gong_did_first_seen          := mth_gong_did_first_seen;
			self.header_first_seen2               := header_first_seen2;
			self.mth_header_first_seen            := mth_header_first_seen;
			self.ver_src_ba_pos                   := ver_src_ba_pos;
			self.ver_src_ba                       := ver_src_ba;
			self.ver_src_ds_pos                   := ver_src_ds_pos;
			self.ver_src_ds                       := ver_src_ds;
			self.ver_src_en_pos                   := ver_src_en_pos;
			self.ver_src_fdate_en                 := ver_src_fdate_en;
			self.ver_src_fdate_en2                := ver_src_fdate_en2;
			self.mth_ver_src_fdate_en             := mth_ver_src_fdate_en;
			self.ver_src_ldate_en                 := ver_src_ldate_en;
			self.ver_src_ldate_en2                := ver_src_ldate_en2;
			self.mth_ver_src_ldate_en             := mth_ver_src_ldate_en;
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
			self.ver_src_p                        := ver_src_p;
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
			self.ver_dob_src_en_pos               := ver_dob_src_en_pos;
			self.ver_dob_src_en                   := ver_dob_src_en;
			self.ver_dob_src_eq_pos               := ver_dob_src_eq_pos;
			self.ver_dob_src_eq                   := ver_dob_src_eq;
			self.ver_dob_src_pl_pos               := ver_dob_src_pl_pos;
			self.ver_dob_src_pl                   := ver_dob_src_pl;
			self.ver_dob_src_vo_pos               := ver_dob_src_vo_pos;
			self.ver_dob_src_vo                   := ver_dob_src_vo;
			self.ver_dob_src_w_pos                := ver_dob_src_w_pos;
			self.ver_dob_src_w                    := ver_dob_src_w;
			self.ver_dob_src_wp_pos               := ver_dob_src_wp_pos;
			self.ver_dob_src_wp                   := ver_dob_src_wp;
			self.email_src_im_pos                 := email_src_im_pos;
			self.email_src_im                     := email_src_im;
			self.add_ec1                          := add_ec1;
			self.add_ec3                          := add_ec3;
			self.add_ec4                          := add_ec4;
			self.phn_disconnected                 := phn_disconnected;
			self.phn_inval                        := phn_inval;
			self.phn_highrisk2                    := phn_highrisk2;
			self.phn_notpots                      := phn_notpots;
			self.phn_cell                         := phn_cell;
			self.phn_zipmismatch                  := phn_zipmismatch;
			self.ssn_issued18                     := ssn_issued18;
			self.ssn_deceased                     := ssn_deceased;
			self.ssn_adl_prob                     := ssn_adl_prob;
			self.impulse_flag                     := impulse_flag;
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
			self.pk_222_flag                      := pk_222_flag;
			self.pk_segment_40                    := pk_segment_40;
			self.pk_age_estimate_s0               := pk_age_estimate_s0;
			self.pk_age_estimate_s1               := pk_age_estimate_s1;
			self.pk_age_estimate_s2               := pk_age_estimate_s2;
			self.pk_age_estimate_s3               := pk_age_estimate_s3;
			self.pk_estimated_income_s0           := pk_estimated_income_s0;
			self.pk_estimated_income_s1           := pk_estimated_income_s1;
			self.pk_estimated_income_s2           := pk_estimated_income_s2;
			self.pk_estimated_income_s3           := pk_estimated_income_s3;
			self.pk_add1_avm_auto_val_s0          := pk_add1_avm_auto_val_s0;
			self.pk_add1_avm_auto_val_s1          := pk_add1_avm_auto_val_s1;
			self.pk_add1_avm_auto_val_s2          := pk_add1_avm_auto_val_s2;
			self.pk_add1_avm_auto_val_s3          := pk_add1_avm_auto_val_s3;
			self.pk_verx_s0                       := pk_verx_s0;
			self.pk_verx_s1                       := pk_verx_s1;
			self.pk_verx_s3                       := pk_verx_s3;
			self.inq_first_log_date2              := inq_first_log_date2;
			self.mth_inq_first_log_date           := mth_inq_first_log_date;
			self.pk_mth_inq_first_log_date        := pk_mth_inq_first_log_date;
			self.pk_inq_recent_lvl                := pk_inq_recent_lvl;
			self.pk_inq_recent_lvl_s0             := pk_inq_recent_lvl_s0;
			self.pk_inq_recent_lvl_s1             := pk_inq_recent_lvl_s1;
			self.pk_inq_recent_lvl_s3             := pk_inq_recent_lvl_s3;
			self.pk_mth_inq_frst_log_dt2_s2       := pk_mth_inq_frst_log_dt2_s2;
			self.pk_impulse_flag                  := pk_impulse_flag;
			self.pk_inq_peradl                    := pk_inq_peradl;
			self.pk_inq_peradl_s0                 := pk_inq_peradl_s0;
			self.pk_inq_peraddr                   := pk_inq_peraddr;
			self.pk_inq_adlsperphone              := pk_inq_adlsperphone;
			self.pk_inq_adlsperphone_s0           := pk_inq_adlsperphone_s0;
			self.pk_inq_adlsperphone_s3           := pk_inq_adlsperphone_s3;
			self.pk_mth_header_first_seen         := pk_mth_header_first_seen;
			self.pk_mth_hdr_frst_sn_s2            := pk_mth_hdr_frst_sn_s2;
			self.pk_dob_ver                       := pk_dob_ver;
			self.pk_attr_total_number_derogs      := pk_attr_total_number_derogs;
			self.pk_crim_fel_flag                 := pk_crim_fel_flag;
			self.pk_eviction_lvl                  := pk_eviction_lvl;
			self.pk_unrel_lien_lvl                := pk_unrel_lien_lvl;
			self.pk_adlperssn_count_s1            := pk_adlperssn_count_s1;
			self.pk_adlperssn_count_s3            := pk_adlperssn_count_s3;
			self.pk_ssns_per_adl_s1               := pk_ssns_per_adl_s1;
			self.pk_ssns_per_adl_s2               := pk_ssns_per_adl_s2;
			self.pk_ssns_per_adl_s3               := pk_ssns_per_adl_s3;
			self.pk_addrs_per_ssn_c6_s0           := pk_addrs_per_ssn_c6_s0;
			self.pk_addrs_per_ssn_c6_s1           := pk_addrs_per_ssn_c6_s1;
			self.pk_addrs_per_ssn_c6_s2           := pk_addrs_per_ssn_c6_s2;
			self.pk_addrs_per_ssn_c6_s3           := pk_addrs_per_ssn_c6_s3;
			self.pk_ssns_per_adl_c6               := pk_ssns_per_adl_c6;
			self.pk_phones_per_adl_c6_s3          := pk_phones_per_adl_c6_s3;
			self.pk_adls_per_addr_c6_s2           := pk_adls_per_addr_c6_s2;
			self.pk_ssns_per_addr_c6_s0           := pk_ssns_per_addr_c6_s0;
			self.pk_ssns_per_addr_c6_s1           := pk_ssns_per_addr_c6_s1;
			self.pk_ssns_per_addr_c6_s3           := pk_ssns_per_addr_c6_s3;
			self.pk_phones_per_addr_c6            := pk_phones_per_addr_c6;
			self.pk_adls_per_phone_c6             := pk_adls_per_phone_c6;
			self.pk_attr_addrs_last12_s1          := pk_attr_addrs_last12_s1;
			self.pk_attr_addrs_last24_s0          := pk_attr_addrs_last24_s0;
			self.pk_attr_addrs_last36_s2          := pk_attr_addrs_last36_s2;
			self.pk_attr_addrs_last36_s3          := pk_attr_addrs_last36_s3;
			self.pk_recent_addr_s0                := pk_recent_addr_s0;
			self.pk_recent_addr_s2                := pk_recent_addr_s2;
			self.pk_phones_per_adl_s0             := pk_phones_per_adl_s0;
			self.pk_ssns_per_addr                 := pk_ssns_per_addr;
			self.pk_phones_per_addr_s0            := pk_phones_per_addr_s0;
			self.pk_phones_per_addr_s2            := pk_phones_per_addr_s2;
			self.pk_phones_per_addr_s3            := pk_phones_per_addr_s3;
			self.pk_adls_per_phone                := pk_adls_per_phone;
			self.pk_prof_lic_cat_s2               := pk_prof_lic_cat_s2;
			self.pk_prof_lic_cat_s3               := pk_prof_lic_cat_s3;
			self.pk_2nd_mortgage                  := pk_2nd_mortgage;
			self.pk_baloon_mortgage               := pk_baloon_mortgage;
			self.pk_adj_finance                   := pk_adj_finance;
			self.pk_addrs_prison_history          := pk_addrs_prison_history;
			self.pk_ver_src_p                     := pk_ver_src_p;
			self.pk_prop_owned_purch_flag         := pk_prop_owned_purch_flag;
			self.pk_add1_naprop4                  := pk_add1_naprop4;
			self.pk_addrs_5yr_s0                  := pk_addrs_5yr_s0;
			self.pk_addrs_5yr_s2                  := pk_addrs_5yr_s2;
			self.pk_addrs_5yr_s3                  := pk_addrs_5yr_s3;
			self.pk_email_count_s1                := pk_email_count_s1;
			self.pk_email_domain_free_count_s2    := pk_email_domain_free_count_s2;
			self.pk_email_domain_free_count_s3    := pk_email_domain_free_count_s3;
			self.pk_add_apt1                      := pk_add_apt1;
			self.pk_add_standarization_err        := pk_add_standarization_err;
			self.pk_addr_changed                  := pk_addr_changed;
			self.pk_unit_changed                  := pk_unit_changed;
			self.pk_zip_po                        := pk_zip_po;
			self.pk_zip_corp_mil                  := pk_zip_corp_mil;
			self.pk_zip_hirisk_comm               := pk_zip_hirisk_comm;
			self.pk_add_inval                     := pk_add_inval;
			self.pk_add_apt2                      := pk_add_apt2;
			self.pk_add_hirisk_comm               := pk_add_hirisk_comm;
			self.pk_add1_advo_address_vacancy     := pk_add1_advo_address_vacancy;
			self.pk_add1_advo_throw_back          := pk_add1_advo_throw_back;
			self.pk_add1_advo_seasonal_delivery   := pk_add1_advo_seasonal_delivery;
			self.pk_add1_advo_college             := pk_add1_advo_college;
			self.pk_add1_advo_drop                := pk_add1_advo_drop;
			self.pk_add1_advo_res_or_business     := pk_add1_advo_res_or_business;
			self.pk_add1_advo_mixed_address_usage := pk_add1_advo_mixed_address_usage;
			self.pk_addprob_s1                    := pk_addprob_s1;
			self.pk_addprob_s2                    := pk_addprob_s2;
			self.pk_addprob_s3                    := pk_addprob_s3;
			self.pk_phn_nongeo                    := pk_phn_nongeo;
			self.pk_phn_phn_not_issued            := pk_phn_phn_not_issued;
			self.pk_phnprob_s2                    := pk_phnprob_s2;
			self.pk_grad_student                  := pk_grad_student;
			self.pk_ams_senior                    := pk_ams_senior;
			self.pk_4yr_college                   := pk_4yr_college;
			self.pk_college_tier_s0               := pk_college_tier_s0;
			self.pk_college_tier_s1               := pk_college_tier_s1;
			self.pk_college_tier_s2               := pk_college_tier_s2;
			self.pk_contrary_infutor_ver          := pk_contrary_infutor_ver;
			self.pk_num_nonderogs90_s0            := pk_num_nonderogs90_s0;
			self.pk_mth_gong_did_fst_sn           := pk_mth_gong_did_fst_sn;
			self.pk_mth_gong_did_fst_sn2_s0       := pk_mth_gong_did_fst_sn2_s0;
			self.pk_mth_gong_did_fst_sn2_s1       := pk_mth_gong_did_fst_sn2_s1;
			self.pk_mth_gong_did_fst_sn2_s2       := pk_mth_gong_did_fst_sn2_s2;
			self.pk_mth_gong_did_fst_sn2_s3       := pk_mth_gong_did_fst_sn2_s3;
			self.pk_mth_add1_date_fst_sn          := pk_mth_add1_date_fst_sn;
			self.pk_mth_add1_date_fst_sn2_s3      := pk_mth_add1_date_fst_sn2_s3;
			self.pk_mth_ver_src_fdate_en          := pk_mth_ver_src_fdate_en;
			self.pk_mth_ver_src_fdate_eq          := pk_mth_ver_src_fdate_eq;
			self.pk_mth_ver_src_fdate_bureau      := pk_mth_ver_src_fdate_bureau;
			self.pk_too_young_at_bureau           := pk_too_young_at_bureau;
			self.pk_addr_hist_advo_college        := pk_addr_hist_advo_college;
			self.pk_add1_house_number_match       := pk_add1_house_number_match;
			self.pk_nap_summary_ver_s1            := pk_nap_summary_ver_s1;
			self.pk_pos_dob_src_minor             := pk_pos_dob_src_minor;
			self.pk_pos_dob_src_minor_flag        := pk_pos_dob_src_minor_flag;
			self.ver_dob_src_bureau               := ver_dob_src_bureau;
			self.ver_dob_src_emerge               := ver_dob_src_emerge;
			self.pk_pos_dob_src_major             := pk_pos_dob_src_major;
			self.pk_pos_dob_src_cnt_s2            := pk_pos_dob_src_cnt_s2;
			self.pk_mth_ver_src_ldate_en          := pk_mth_ver_src_ldate_en;
			self.pk_mth_ver_src_ldate_eq          := pk_mth_ver_src_ldate_eq;
			self.pk_mth_ver_src_ldate_bureau      := pk_mth_ver_src_ldate_bureau;
			self.pk_time_on_cb                    := pk_time_on_cb;
			self.pk_time_on_cb2_s1                := pk_time_on_cb2_s1;
			self.pk_time_since_cb3                := pk_time_since_cb3;
			self.pk_age_estimate_s0_0m            := pk_age_estimate_s0_0m;
			self.pk_estimated_income_s0_0m        := pk_estimated_income_s0_0m;
			self.pk_add1_avm_auto_val_s0_0m       := pk_add1_avm_auto_val_s0_0m;
			self.pk_age_estimate_s1_1m            := pk_age_estimate_s1_1m;
			self.pk_estimated_income_s1_1m        := pk_estimated_income_s1_1m;
			self.pk_add1_avm_auto_val_s1_1m       := pk_add1_avm_auto_val_s1_1m;
			self.pk_age_estimate_s2_2m            := pk_age_estimate_s2_2m;
			self.pk_estimated_income_s2_2m        := pk_estimated_income_s2_2m;
			self.pk_add1_avm_auto_val_s2_2m       := pk_add1_avm_auto_val_s2_2m;
			self.pk_age_estimate_s3_3m            := pk_age_estimate_s3_3m;
			self.pk_estimated_income_s3_3m        := pk_estimated_income_s3_3m;
			self.pk_add1_avm_auto_val_s3_3m       := pk_add1_avm_auto_val_s3_3m;
			self.pk_verx_s0_0m                    := pk_verx_s0_0m;
			self.pk_verx_s1_1m                    := pk_verx_s1_1m;
			self.pk_verx_s3_3m                    := pk_verx_s3_3m;
			self.pk_inq_recent_lvl_s0_0m          := pk_inq_recent_lvl_s0_0m;
			self.pk_inq_peradl_s0_0m              := pk_inq_peradl_s0_0m;
			self.pk_inq_adlsperphone_s0_0m        := pk_inq_adlsperphone_s0_0m;
			self.pk_inq_recent_lvl_s1_1m          := pk_inq_recent_lvl_s1_1m;
			self.pk_inq_peraddr_1m                := pk_inq_peraddr_1m;
			self.pk_mth_inq_frst_log_dt2_s2_2m    := pk_mth_inq_frst_log_dt2_s2_2m;
			self.pk_inq_recent_lvl_s3_3m          := pk_inq_recent_lvl_s3_3m;
			self.pk_inq_peraddr_3m                := pk_inq_peraddr_3m;
			self.pk_inq_adlsperphone_s3_3m        := pk_inq_adlsperphone_s3_3m;
			self.pk_mth_hdr_frst_sn_s2_2m         := pk_mth_hdr_frst_sn_s2_2m;
			self.pk_dob_ver_1m                    := pk_dob_ver_1m;
			self.pk_dob_ver_3m                    := pk_dob_ver_3m;
			self.pk_attr_total_number_derogs_0m   := pk_attr_total_number_derogs_0m;
			self.pk_crim_fel_flag_0m              := pk_crim_fel_flag_0m;
			self.pk_eviction_lvl_0m               := pk_eviction_lvl_0m;
			self.pk_unrel_lien_lvl_0m             := pk_unrel_lien_lvl_0m;
			self.bankrupt_0m                      := bankrupt_0m;
			self.pk_addrs_per_ssn_c6_s0_0m        := pk_addrs_per_ssn_c6_s0_0m;
			self.pk_ssns_per_adl_c6_0m            := pk_ssns_per_adl_c6_0m;
			self.pk_ssns_per_addr_c6_s0_0m        := pk_ssns_per_addr_c6_s0_0m;
			self.pk_attr_addrs_last24_s0_0m       := pk_attr_addrs_last24_s0_0m;
			self.pk_recent_addr_s0_0m             := pk_recent_addr_s0_0m;
			self.pk_phones_per_adl_s0_0m          := pk_phones_per_adl_s0_0m;
			self.pk_ssns_per_addr_0m              := pk_ssns_per_addr_0m;
			self.pk_phones_per_addr_s0_0m         := pk_phones_per_addr_s0_0m;
			self.pk_adlperssn_count_s1_1m         := pk_adlperssn_count_s1_1m;
			self.pk_ssns_per_adl_s1_1m            := pk_ssns_per_adl_s1_1m;
			self.pk_addrs_per_ssn_c6_s1_1m        := pk_addrs_per_ssn_c6_s1_1m;
			self.pk_ssns_per_adl_c6_1m            := pk_ssns_per_adl_c6_1m;
			self.pk_ssns_per_addr_c6_s1_1m        := pk_ssns_per_addr_c6_s1_1m;
			self.pk_phones_per_addr_c6_1m         := pk_phones_per_addr_c6_1m;
			self.pk_attr_addrs_last12_s1_1m       := pk_attr_addrs_last12_s1_1m;
			self.pk_ssns_per_adl_s2_2m            := pk_ssns_per_adl_s2_2m;
			self.pk_addrs_per_ssn_c6_s2_2m        := pk_addrs_per_ssn_c6_s2_2m;
			self.pk_adls_per_addr_c6_s2_2m        := pk_adls_per_addr_c6_s2_2m;
			self.pk_adls_per_phone_c6_2m          := pk_adls_per_phone_c6_2m;
			self.pk_attr_addrs_last36_s2_2m       := pk_attr_addrs_last36_s2_2m;
			self.pk_recent_addr_s2_2m             := pk_recent_addr_s2_2m;
			self.pk_ssns_per_addr_2m              := pk_ssns_per_addr_2m;
			self.pk_phones_per_addr_s2_2m         := pk_phones_per_addr_s2_2m;
			self.pk_adls_per_phone_2m             := pk_adls_per_phone_2m;
			self.pk_adlperssn_count_s3_3m         := pk_adlperssn_count_s3_3m;
			self.pk_ssns_per_adl_s3_3m            := pk_ssns_per_adl_s3_3m;
			self.pk_addrs_per_ssn_c6_s3_3m        := pk_addrs_per_ssn_c6_s3_3m;
			self.pk_phones_per_adl_c6_s3_3m       := pk_phones_per_adl_c6_s3_3m;
			self.pk_ssns_per_addr_c6_s3_3m        := pk_ssns_per_addr_c6_s3_3m;
			self.pk_phones_per_addr_c6_3m         := pk_phones_per_addr_c6_3m;
			self.pk_attr_addrs_last36_s3_3m       := pk_attr_addrs_last36_s3_3m;
			self.pk_phones_per_addr_s3_3m         := pk_phones_per_addr_s3_3m;
			self.pk_adls_per_phone_3m             := pk_adls_per_phone_3m;
			self.pk_prof_lic_cat_s2_2m            := pk_prof_lic_cat_s2_2m;
			self.pk_prof_lic_cat_s3_3m            := pk_prof_lic_cat_s3_3m;
			self.pk_ver_src_p_0m                  := pk_ver_src_p_0m;
			self.pk_prop_owned_purch_flag_0m      := pk_prop_owned_purch_flag_0m;
			self.pk_add1_naprop4_0m               := pk_add1_naprop4_0m;
			self.pk_ver_src_p_1m                  := pk_ver_src_p_1m;
			self.pk_add1_naprop4_1m               := pk_add1_naprop4_1m;
			self.pk_ver_src_p_3m                  := pk_ver_src_p_3m;
			self.pk_addrs_5yr_s0_0m               := pk_addrs_5yr_s0_0m;
			self.pk_addrs_5yr_s2_2m               := pk_addrs_5yr_s2_2m;
			self.pk_addrs_5yr_s3_3m               := pk_addrs_5yr_s3_3m;
			self.pk_email_count_s1_1m             := pk_email_count_s1_1m;
			self.pk_email_domain_free_count_s2_2m := pk_email_domain_free_count_s2_2m;
			self.pk_email_domain_free_count_s3_3m := pk_email_domain_free_count_s3_3m;
			self.ssn_adl_prob_0m                  := ssn_adl_prob_0m;
			self.ssn_issued18_0m                  := ssn_issued18_0m;
			self.pk_addprob_s1_1m                 := pk_addprob_s1_1m;
			self.ssn_issued18_1m                  := ssn_issued18_1m;
			self.pk_addprob_s2_2m                 := pk_addprob_s2_2m;
			self.pk_phnprob_s2_2m                 := pk_phnprob_s2_2m;
			self.pk_addprob_s3_3m                 := pk_addprob_s3_3m;
			self.ssn_issued18_3m                  := ssn_issued18_3m;
			self.pk_college_tier_s0_0m            := pk_college_tier_s0_0m;
			self.pk_grad_student_1m               := pk_grad_student_1m;
			self.pk_ams_senior_1m                 := pk_ams_senior_1m;
			self.pk_college_tier_s1_1m            := pk_college_tier_s1_1m;
			self.pk_grad_student_2m               := pk_grad_student_2m;
			self.pk_college_tier_s2_2m            := pk_college_tier_s2_2m;
			self.pk_4yr_college_3m                := pk_4yr_college_3m;
			self.pk_contrary_infutor_ver_1m       := pk_contrary_infutor_ver_1m;
			self.pk_contrary_infutor_ver_2m       := pk_contrary_infutor_ver_2m;
			self.pk_contrary_infutor_ver_3m       := pk_contrary_infutor_ver_3m;
			self.pk_num_nonderogs90_s0_0m         := pk_num_nonderogs90_s0_0m;
			self.pk_mth_gong_did_fst_sn2_s0_0m    := pk_mth_gong_did_fst_sn2_s0_0m;
			self.pk_mth_gong_did_fst_sn2_s1_1m    := pk_mth_gong_did_fst_sn2_s1_1m;
			self.pk_too_young_at_bureau_1m        := pk_too_young_at_bureau_1m;
			self.pk_addr_hist_advo_college_1m     := pk_addr_hist_advo_college_1m;
			self.pk_nap_summary_ver_s1_1m         := pk_nap_summary_ver_s1_1m;
			self.pk_mth_gong_did_fst_sn2_s2_2m    := pk_mth_gong_did_fst_sn2_s2_2m;
			self.pk_addr_hist_advo_college_2m     := pk_addr_hist_advo_college_2m;
			self.pk_add1_house_number_match_2m    := pk_add1_house_number_match_2m;
			self.pk_mth_gong_did_fst_sn2_s3_3m    := pk_mth_gong_did_fst_sn2_s3_3m;
			self.pk_mth_add1_date_fst_sn2_s3_3m   := pk_mth_add1_date_fst_sn2_s3_3m;
			self.pk_addr_hist_advo_college_3m     := pk_addr_hist_advo_college_3m;
			self.pk_add1_house_number_match_3m    := pk_add1_house_number_match_3m;
			self.pk_time_on_cb2_s1_1m             := pk_time_on_cb2_s1_1m;
			self.pk_time_since_cb3_1m             := pk_time_since_cb3_1m;
			self.pk_pos_dob_src_cnt_s2_2m         := pk_pos_dob_src_cnt_s2_2m;
			self.derog_mod_0m                     := derog_mod_0m;
			self.prop_owner_mod_0m                := prop_owner_mod_0m;
			self.prop_owner_mod_1m                := prop_owner_mod_1m;
			self.prop_owner_mod_3m                := prop_owner_mod_3m;
			self.financing_mod_0m                 := financing_mod_0m;
			self.financing_mod_2m                 := financing_mod_2m;
			self.financing_mod_3m                 := financing_mod_3m;
			self.email_mod_1m                     := email_mod_1m;
			self.email_mod_2m                     := email_mod_2m;
			self.email_mod_3m                     := email_mod_3m;
			self.fp_mod2_1m                       := fp_mod2_1m;
			self.ams_mod_0m                       := ams_mod_0m;
			self.ams_mod_1m                       := ams_mod_1m;
			self.ams_mod_2m                       := ams_mod_2m;
			self.ams_mod_3m                       := ams_mod_3m;
			self.inquiry_mod_0m                   := inquiry_mod_0m;
			self.inquiry_mod_1m                   := inquiry_mod_1m;
			self.inquiry_mod_2m                   := inquiry_mod_2m;
			self.inquiry_mod_3m                   := inquiry_mod_3m;
			self.velo_mod_0m                      := velo_mod_0m;
			self.velo_mod_1m                      := velo_mod_1m;
			self.velo_mod_2m                      := velo_mod_2m;
			self.velo_mod_3m                      := velo_mod_3m;
			self.mod8_0m                          := mod8_0m;
			self.mod8_1m                          := mod8_1m;
			self.mod8_2m                          := mod8_2m;
			self.mod8_3m                          := mod8_3m;
			self.mod8_nodob_0m                    := mod8_nodob_0m;
			self.mod8_nodob_1m                    := mod8_nodob_1m;
			self.mod8_nodob_2m                    := mod8_nodob_2m;
			self.mod8_nodob_3m                    := mod8_nodob_3m;
			self.mod8_nodob                       := mod8_nodob;
			self.mod8                             := mod8;
			self.mod8_phat                        := mod8_phat;
			self.mod8_scr                         := mod8_scr;
			self.mod8_nodob_phat                  := mod8_nodob_phat;
			self.mod8_nodob_scr                   := mod8_nodob_scr;
			self.rvb1104a                         := rvb1104a;
			self.rvb1104b                         := rvb1104b;
			self.ov_ssndead                       := ov_ssndead;
			self.ov_ssnprior                      := ov_ssnprior;
			self.ov_criminal_flag                 := ov_criminal_flag;
			self.ov_corrections                   := ov_corrections;
			self.ov_impulse                       := ov_impulse;
			self.rvb1104c                         := rvb1104c;
			self.scored_222s                      := scored_222s;
			self.rvb1104d                         := rvb1104d;
			self.rvb1104e                         := rvb1104e;
			self.rvb1104                          := rvb1104;


			self.pk_em_domain_free_count_s2_2m := pk_em_domain_free_count_s2_2m;
			self.pk_em_domain_free_count_s3_3m := pk_em_domain_free_count_s3_3m;
			self.rc1 := rc1;
			self._rc1 := _rc1;
			self.rc1_var := rc1_var;
			self.rc2 := rc2;
			self._rc2 := _rc2;
			self.rc2_var := rc2_var;
			self.rc3 := rc3;
			self._rc3 := _rc3;
			self.rc3_var := rc3_var;
			self.rc4 := rc4;
			self._rc4 := _rc4;
			self.rc4_var := rc4_var;
			self.add1_assessed_amount := add1_assessed_amount;
			self.glrc25 := glrc25;
			self.glrc28 := glrc28;
			self.glrc36 := glrc36;
			self.glrc97 := glrc97;
			self.glrc98 := glrc98;
			self.glrc99 := glrc99;
			self.glrc9a := glrc9a;
			self.glrc9c := glrc9c;
			self.glrc9d := glrc9d;
			self.glrc9e := glrc9e;
			self.glrc9g := glrc9g;
			self.glrc9h := glrc9h;
			self.glrc9j := glrc9j;
			self.glrc9m := glrc9m;
			self.glrc9n := glrc9n;
			self.glrc9q := glrc9q;
			self.glrc9r := glrc9r;
			self.glrc9s := glrc9s;
			self.phn_business := phn_business;
			self.glrc9t := glrc9t;
			self.glrc9u := glrc9u;
			self.glrc9w := glrc9w;
			self.glrcev := glrcev;
			self.glrcmi := glrcmi;
			self.glrcms := glrcms;
			self.aptflag_1 := aptflag_1;
			self.aptflag := aptflag;
			self.add1_econval := add1_econval;
			self.add1_aptval := add1_aptval;
			self.add1_econcode := add1_econcode;
			self.glrcpv := glrcpv;
			self.glrcx11 := glrcx11;
			self.m_financing_mod_2m := m_financing_mod_2m;
			self.m_prop_owner_mod_3m := m_prop_owner_mod_3m;
			self.m_velo_mod_3m := m_velo_mod_3m;
			self.m_inquiry_mod_2m := m_inquiry_mod_2m;
			self.m_velo_mod_1m := m_velo_mod_1m;
			self.m_email_mod_1m := m_email_mod_1m;
			self.m_prop_owner_mod_1m := m_prop_owner_mod_1m;
			self.m_fp_mod2_1m := m_fp_mod2_1m;
			self.m_email_mod_2m := m_email_mod_2m;
			self.m_inquiry_mod_0m := m_inquiry_mod_0m;
			self.m_derog_mod_0m := m_derog_mod_0m;
			self.m_velo_mod_2m := m_velo_mod_2m;
			self.m_financing_mod_0m := m_financing_mod_0m;
			self.m_inquiry_mod_3m := m_inquiry_mod_3m;
			self.m_prop_owner_mod_0m := m_prop_owner_mod_0m;
			self.m_inquiry_mod_1m := m_inquiry_mod_1m;
			self.m_email_mod_3m := m_email_mod_3m;
			self.m_financing_mod_3m := m_financing_mod_3m;
			self.m_velo_mod_0m := m_velo_mod_0m;
			self.seg_s0_crime_c37_b1 := seg_s0_crime_c37_b1;
			self._97_0_c37 := _97_0_c37;
			self.seg_s0_lien_c38_b1 := seg_s0_lien_c38_b1;
			self._98_0_c38 := _98_0_c38;
			self.seg_s0_eviction_c39_b1 := seg_s0_eviction_c39_b1;
			self._ev_0_c39 := _ev_0_c39;
			self.seg_s0_impulse_c40_b1 := seg_s0_impulse_c40_b1;
			self._9h_0_c40 := _9h_0_c40;
			self.seg_s0_bk_c41_b1 := seg_s0_bk_c41_b1;
			self._9w_0_c41 := _9w_0_c41;
			self._9d_3_c36 := _9d_3_c36;
			self._9q_1_c36 := _9q_1_c36;
			self._ev_1_c36 := _ev_1_c36;
			self._x11_3_c36 := _x11_3_c36;
			self._9h_1_c36 := _9h_1_c36;
			self._9w_1_c36 := _9w_1_c36;
			self._x11_2_c36 := _x11_2_c36;
			self._9g_1_c36 := _9g_1_c36;
			self._9s_1_c36 := _9s_1_c36;
			self._36_1_c36 := _36_1_c36;
			self._ms_1_c36 := _ms_1_c36;
			self._9a_1_c36 := _9a_1_c36;
			self._9w_0_c36 := _9w_0_c36;
			self._x11_4_c36 := _x11_4_c36;
			self._9e_1_c36 := _9e_1_c36;
			self._98_0_c36 := _98_0_c36;
			self._97_1_c36 := _97_1_c36;
			self._9m_1_c36 := _9m_1_c36;
			self._ms_2_c36 := _ms_2_c36;
			self._9q_3_c36 := _9q_3_c36;
			self._98_1_c36 := _98_1_c36;
			self._ev_0_c36 := _ev_0_c36;
			self._9q_2_c36 := _9q_2_c36;
			self._9h_0_c36 := _9h_0_c36;
			self._9d_2_c36 := _9d_2_c36;
			self._9d_1_c36 := _9d_1_c36;
			self._9d_4_c36 := _9d_4_c36;
			self._9n_1_c36 := _9n_1_c36;
			self._9a_3_c36 := _9a_3_c36;
			self._9r_1_c36 := _9r_1_c36;
			self._pv_1_c36 := _pv_1_c36;
			self._97_0_c36 := _97_0_c36;
			self._x11_1_c36 := _x11_1_c36;
			self._9a_2_c36 := _9a_2_c36;
			self._9u_1_c43 := _9u_1_c43;
			self.seg_s1_c42_b1 := seg_s1_c42_b1;
			self._x11_5_c42 := _x11_5_c42;
			self._x11_6_c42 := _x11_6_c42;
			self._9q_4_c42 := _9q_4_c42;
			self._9g_2_c42 := _9g_2_c42;
			self._9g_4_c42 := _9g_4_c42;
			self._9r_5_c42 := _9r_5_c42;
			self._9e_2_c42 := _9e_2_c42;
			self._9r_4_c42 := _9r_4_c42;
			self._ms_4_c42 := _ms_4_c42;
			self._9r_3_c42 := _9r_3_c42;
			self._pv_2_c42 := _pv_2_c42;
			self._9a_4_c42 := _9a_4_c42;
			self._9d_6_c42 := _9d_6_c42;
			self._9g_3_c42 := _9g_3_c42;
			self._28_1_c42 := _28_1_c42;
			self._36_2_c42 := _36_2_c42;
			self._9q_5_c42 := _9q_5_c42;
			self._9a_5_c42 := _9a_5_c42;
			self._mi_1_c42 := _mi_1_c42;
			self._9u_1_c42 := _9u_1_c42;
			self._9r_2_c42 := _9r_2_c42;
			self._9d_5_c42 := _9d_5_c42;
			self._ms_3_c42 := _ms_3_c42;
			self._9m_2_c42 := _9m_2_c42;
			self._9m_3_c44 := _9m_3_c44;
			self._28_2_c44 := _28_2_c44;
			self._pv_3_c44 := _pv_3_c44;
			self._ms_5_c44 := _ms_5_c44;
			self._9d_7_c44 := _9d_7_c44;
			self._9q_6_c44 := _9q_6_c44;
			self._x11_8_c44 := _x11_8_c44;
			self._9u_2_c44 := _9u_2_c44;
			self._9s_2_c44 := _9s_2_c44;
			self._25_1_c44 := _25_1_c44;
			self._x11_9_c44 := _x11_9_c44;
			self._9d_8_c44 := _9d_8_c44;
			self._9g_5_c44 := _9g_5_c44;
			self._9r_6_c44 := _9r_6_c44;
			self._x11_7_c44 := _x11_7_c44;
			self._9d_9_c44 := _9d_9_c44;
			self._99_1_c44 := _99_1_c44;
			self._9s_4_c44 := _9s_4_c44;
			self._x11_11_c44 := _x11_11_c44;
			self._9r_7_c44 := _9r_7_c44;
			self._9s_3_c44 := _9s_3_c44;
			self._x11_10_c44 := _x11_10_c44;
			self._9t_1_c44 := _9t_1_c44;
			self._9r_8_c44 := _9r_8_c44;
			self._9d_10_c44 := _9d_10_c44;
			self.seg_s3_c45_b1 := seg_s3_c45_b1;
			self._ms_6_c45 := _ms_6_c45;
			self._9q_8_c45 := _9q_8_c45;
			self._x11_14_c45 := _x11_14_c45;
			self._x11_15_c45 := _x11_15_c45;
			self._9d_11_c45 := _9d_11_c45;
			self._pv_4_c45 := _pv_4_c45;
			self._9q_9_c45 := _9q_9_c45;
			self._9u_3_c45 := _9u_3_c45;
			self._9r_9_c45 := _9r_9_c45;
			self._9a_7_c45 := _9a_7_c45;
			self._9q_7_c45 := _9q_7_c45;
			self._9d_13_c45 := _9d_13_c45;
			self._x11_13_c45 := _x11_13_c45;
			self._9r_11_c45 := _9r_11_c45;
			self._9s_5_c45 := _9s_5_c45;
			self._9c_1_c45 := _9c_1_c45;
			self._9d_12_c45 := _9d_12_c45;
			self._9a_6_c45 := _9a_6_c45;
			self._9m_4_c45 := _9m_4_c45;
			self._x11_12_c45 := _x11_12_c45;
			self._28_3_c45 := _28_3_c45;
			self._36_3_c45 := _36_3_c45;
			self._x11_16_c45 := _x11_16_c45;
			self._9r_10_c45 := _9r_10_c45;
			self._9s_6_c45 := _9s_6_c45;
			self._mi_2_c45 := _mi_2_c45;
			self._25_2_c45 := _25_2_c45;
			self.seg_s0_crime_c47_b1 := seg_s0_crime_c47_b1;
			self.Seg_S0_Crime := Seg_S0_Crime;
			self._97_0_c47 := _97_0_c47;
			self.seg_s0_lien_c48_b1 := seg_s0_lien_c48_b1;
			self.Seg_S0_Lien := Seg_S0_Lien;
			self._98_0_c48 := _98_0_c48;
			self.seg_s0_eviction_c49_b1 := seg_s0_eviction_c49_b1;
			self.seg_s0_eviction := seg_s0_eviction;
			self._ev_0_c49 := _ev_0_c49;
			self.seg_s0_impulse_c50_b1 := seg_s0_impulse_c50_b1;
			self.seg_s0_impulse := seg_s0_impulse;
			self._9h_0_c50 := _9h_0_c50;
			self.seg_s0_bk_c51_b1 := seg_s0_bk_c51_b1;
			self.seg_s0_bk := seg_s0_bk;
			self._9w_0_c51 := _9w_0_c51;
			self._9d_3_c46 := _9d_3_c46;
			self._9q_1_c46 := _9q_1_c46;
			self._ev_1_c46 := _ev_1_c46;
			self._x11_3_c46 := _x11_3_c46;
			self._9h_1_c46 := _9h_1_c46;
			self._9w_1_c46 := _9w_1_c46;
			self._x11_2_c46 := _x11_2_c46;
			self._9g_1_c46 := _9g_1_c46;
			self._9s_1_c46 := _9s_1_c46;
			self._36_1_c46 := _36_1_c46;
			self._ms_1_c46 := _ms_1_c46;
			self._9a_1_c46 := _9a_1_c46;
			self._9w_0_c46 := _9w_0_c46;
			self._x11_4_c46 := _x11_4_c46;
			self._9e_1_c46 := _9e_1_c46;
			self._98_0_c46 := _98_0_c46;
			self._97_1_c46 := _97_1_c46;
			self._9m_1_c46 := _9m_1_c46;
			self._ms_2_c46 := _ms_2_c46;
			self._9q_3_c46 := _9q_3_c46;
			self._98_1_c46 := _98_1_c46;
			self._ev_0_c46 := _ev_0_c46;
			self._9q_2_c46 := _9q_2_c46;
			self._9h_0_c46 := _9h_0_c46;
			self._9d_2_c46 := _9d_2_c46;
			self._9d_1_c46 := _9d_1_c46;
			self._9d_4_c46 := _9d_4_c46;
			self._9n_1_c46 := _9n_1_c46;
			self._9a_3_c46 := _9a_3_c46;
			self._9r_1_c46 := _9r_1_c46;
			self._pv_1_c46 := _pv_1_c46;
			self._97_0_c46 := _97_0_c46;
			self._x11_1_c46 := _x11_1_c46;
			self._9a_2_c46 := _9a_2_c46;
			self.seg_s1_c52_b1 := seg_s1_c52_b1;
			self._x11_5_c52 := _x11_5_c52;
			self._x11_6_c52 := _x11_6_c52;
			self._9q_4_c52 := _9q_4_c52;
			self._9g_2_c52 := _9g_2_c52;
			self._9r_4_c52 := _9r_4_c52;
			self._9e_2_c52 := _9e_2_c52;
			self._ms_4_c52 := _ms_4_c52;
			self._9r_3_c52 := _9r_3_c52;
			self._pv_2_c52 := _pv_2_c52;
			self._9a_4_c52 := _9a_4_c52;
			self._9d_6_c52 := _9d_6_c52;
			self._36_2_c52 := _36_2_c52;
			self._9q_5_c52 := _9q_5_c52;
			self._9g_3_c52 := _9g_3_c52;
			self._9a_5_c52 := _9a_5_c52;
			self._mi_1_c52 := _mi_1_c52;
			self._9u_1_c52 := _9u_1_c52;
			self._9r_2_c52 := _9r_2_c52;
			self._9d_5_c52 := _9d_5_c52;
			self._mi_2_c52 := _mi_2_c52;
			self._ms_3_c52 := _ms_3_c52;
			self._9m_2_c52 := _9m_2_c52;
			self._9m_3_c53 := _9m_3_c53;
			self._9r_5_c53 := _9r_5_c53;
			self._9g_4_c53 := _9g_4_c53;
			self._pv_3_c53 := _pv_3_c53;
			self._ms_5_c53 := _ms_5_c53;
			self._9d_7_c53 := _9d_7_c53;
			self._9q_6_c53 := _9q_6_c53;
			self._x11_8_c53 := _x11_8_c53;
			self._9u_2_c53 := _9u_2_c53;
			self._9s_2_c53 := _9s_2_c53;
			self._25_1_c53 := _25_1_c53;
			self._x11_9_c53 := _x11_9_c53;
			self._9d_8_c53 := _9d_8_c53;
			self._9r_6_c53 := _9r_6_c53;
			self._x11_7_c53 := _x11_7_c53;
			self._9d_9_c53 := _9d_9_c53;
			self._99_1_c53 := _99_1_c53;
			self._9s_4_c53 := _9s_4_c53;
			self._x11_11_c53 := _x11_11_c53;
			self._9r_7_c53 := _9r_7_c53;
			self._9s_3_c53 := _9s_3_c53;
			self._x11_10_c53 := _x11_10_c53;
			self._9t_1_c53 := _9t_1_c53;
			self._9d_10_c53 := _9d_10_c53;
			self.seg_s3_c54_b1 := seg_s3_c54_b1;
			self._ms_6_c54 := _ms_6_c54;
			self._9q_8_c54 := _9q_8_c54;
			self._x11_14_c54 := _x11_14_c54;
			self._x11_15_c54 := _x11_15_c54;
			self._mi_3_c54 := _mi_3_c54;
			self._9d_11_c54 := _9d_11_c54;
			self._pv_4_c54 := _pv_4_c54;
			self._9q_9_c54 := _9q_9_c54;
			self._9u_3_c54 := _9u_3_c54;
			self._9a_7_c54 := _9a_7_c54;
			self._9r_9_c54 := _9r_9_c54;
			self._9q_7_c54 := _9q_7_c54;
			self._9d_13_c54 := _9d_13_c54;
			self._x11_13_c54 := _x11_13_c54;
			self._ms_7_c54 := _ms_7_c54;
			self._9s_5_c54 := _9s_5_c54;
			self._9g_5_c54 := _9g_5_c54;
			self._9d_12_c54 := _9d_12_c54;
			self._9a_6_c54 := _9a_6_c54;
			self._9m_4_c54 := _9m_4_c54;
			self._x11_12_c54 := _x11_12_c54;
			self._36_3_c54 := _36_3_c54;
			self._x11_16_c54 := _x11_16_c54;
			self._9r_10_c54 := _9r_10_c54;
			self._9s_6_c54 := _9s_6_c54;
			self._9r_8_c54 := _9r_8_c54;
			self._25_2_c54 := _25_2_c54;
			self._ms_6 := _ms_6;
			self._9q_8 := _9q_8;
			self._9m_3 := _9m_3;
			self._9d_11 := _9d_11;
			self._9d_3 := _9d_3;
			self._9q_9 := _9q_9;
			self._9q_1 := _9q_1;
			self._9q_6 := _9q_6;
			self._9u_3 := _9u_3;
			self._9a_7 := _9a_7;
			self._ev_1 := _ev_1;
			self._9w_1 := _9w_1;
			self._25_1 := _25_1;
			self._9s_1 := _9s_1;
			self._x11_13 := _x11_13;
			self._9a_1 := _9a_1;
			self._ms_1 := _ms_1;
			self._36_1 := _36_1;
			self._9s_5 := _9s_5;
			self._9q_5 := _9q_5;
			self._99_1 := _99_1;
			self._9a_6 := _9a_6;
			self._x11_12 := _x11_12;
			self._98_0 := _98_0;
			self._9s_3 := _9s_3;
			self._ms_2 := _ms_2;
			self._mi_2 := _mi_2;
			self._x11_5 := _x11_5;
			self._9q_3 := _9q_3;
			self._ev_0 := _ev_0;
			self._9q_4 := _9q_4;
			self._9q_2 := _9q_2;
			self._9g_2 := _9g_2;
			self._9g_4 := _9g_4;
			self._ms_5 := _ms_5;
			self._9u_2 := _9u_2;
			self._9s_2 := _9s_2;
			self._9d_4 := _9d_4;
			self._ms_7 := _ms_7;
			self._9n_1 := _9n_1;
			self._36_2 := _36_2;
			self._9a_5 := _9a_5;
			self._x11_11 := _x11_11;
			self._9m_4 := _9m_4;
			self._9r_7 := _9r_7;
			self._36_3 := _36_3;
			self._97_0 := _97_0;
			self._9d_5 := _9d_5;
			self._x11_10 := _x11_10;
			self._9r_8 := _9r_8;
			self._9d_10 := _9d_10;
			self._x11_1 := _x11_1;
			self._x11_6 := _x11_6;
			self._pv_4 := _pv_4;
			self._9r_5 := _9r_5;
			self._9r_4 := _9r_4;
			self._9e_2 := _9e_2;
			self._x11_3 := _x11_3;
			self._9h_1 := _9h_1;
			self._9d_13 := _9d_13;
			self._ms_4 := _ms_4;
			self._x11_2 := _x11_2;
			self._9g_1 := _9g_1;
			self._9r_3 := _9r_3;
			self._9r_11 := _9r_11;
			self._pv_2 := _pv_2;
			self._9g_5 := _9g_5;
			self._9r_6 := _9r_6;
			self._9a_4 := _9a_4;
			self._9w_0 := _9w_0;
			self._9d_6 := _9d_6;
			self._x11_4 := _x11_4;
			self._9c_1 := _9c_1;
			self._9e_1 := _9e_1;
			self._9d_12 := _9d_12;
			self._mi_1 := _mi_1;
			self._97_1 := _97_1;
			self._9u_1 := _9u_1;
			self._9m_1 := _9m_1;
			self._x11_16 := _x11_16;
			self._9r_10 := _9r_10;
			self._9t_1 := _9t_1;
			self._98_1 := _98_1;
			self._x11_14 := _x11_14;
			self._x11_15 := _x11_15;
			self._mi_3 := _mi_3;
			self._9h_0 := _9h_0;
			self._28_2 := _28_2;
			self._pv_3 := _pv_3;
			self._9d_2 := _9d_2;
			self._9d_7 := _9d_7;
			self._9d_1 := _9d_1;
			self._9r_9 := _9r_9;
			self._x11_8 := _x11_8;
			self._9q_7 := _9q_7;
			self._x11_9 := _x11_9;
			self._9d_8 := _9d_8;
			self._x11_7 := _x11_7;
			self._9d_9 := _9d_9;
			self._28_1 := _28_1;
			self._9g_3 := _9g_3;
			self._9s_4 := _9s_4;
			self._9a_3 := _9a_3;
			self._28_3 := _28_3;
			self._9r_1 := _9r_1;
			self._pv_1 := _pv_1;
			self._9r_2 := _9r_2;
			self._9s_6 := _9s_6;
			self._ms_3 := _ms_3;
			self._9m_2 := _9m_2;
			self._9a_2 := _9a_2;
			self._25_2 := _25_2;
			self._25 := _25;
			self._28 := _28;
			self._36 := _36;
			self._97 := _97;
			self._98 := _98;
			self._99 := _99;
			self._9a := _9a;
			self._9c := _9c;
			self._9d := _9d;
			self._9e := _9e;
			self._9g := _9g;
			self._9h := _9h;
			self._9j_0 := _9j_0;
			self._9j_1 := _9j_1;
			self._9j := _9j;
			self._9m := _9m;
			self._9n := _9n;
			self._9q := _9q;
			self._9r := _9r;
			self._9s := _9s;
			self._9t := _9t;
			self._9u := _9u;
			self._9w := _9w;
			self._ev := _ev;
			self._mi := _mi;
			self._ms := _ms;
			self._pv := _pv;
			self._x11 := _x11;
			// self.rc_dataset := rc_dataset;

			self.rc1_rc := rcs_override[1].rc;
			self.rc2_rc := rcs_override[2].rc;
			self.rc3_rc := rcs_override[3].rc;
			self.rc4_rc := rcs_override[4].rc;
			self.rc5_rc := rcs_override[5].rc;
			self.rc1_value := rcs_override[1].value;
			self.rc2_value := rcs_override[2].value;
			self.rc3_value := rcs_override[3].value;
			self.rc4_value := rcs_override[4].value;
			self.rc5_value := rcs_override[5].value;

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
			(string3)(integer)rvb1104
		);		
	END;
	
	model := project( clam, doModel(left) );
	
	return model;
end;
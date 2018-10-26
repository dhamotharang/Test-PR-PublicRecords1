import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVA1104_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPrescreenOptOut ) := FUNCTION

	RVA_DEBUG := false;

	#if(RVA_DEBUG)
	debug_layout := record
		risk_indicators.Layout_Boca_Shell clam;
		Boolean trueDID;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String nap_status;
		Integer did_count;
		Boolean rc_input_addr_not_most_recent;
		String rc_hriskphoneflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_ssnvalflag;
		Integer rc_ssnlowissue;
		String rc_addrvalflag;
		String rc_bansflag;
		Boolean rc_addrmiskeyflag;
		String rc_hrisksic;
		Integer rc_disthphoneaddr;
		String rc_statezipflag;
		Integer combo_fnamescore;
		Integer combo_lnamescore;
		Integer combo_addrscore;
		Integer combo_ssnscore;
		Integer combo_dobscore;
		Integer combo_fnamecount;
		Integer combo_lnamecount;
		Integer combo_addrcount;
		Integer combo_hphonecount;
		Integer combo_ssncount;
		Integer combo_dobcount;
		qstring100 ver_sources;
		qstring100 ver_sources_NAS;
		qstring200 ver_sources_first_seen;
		qstring200 ver_sources_last_seen;
		qstring100 ver_sources_count;
		Boolean dobpop;
		Boolean add1_isbestmatch;
		String add1_advo_address_vacancy;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_automated_valuation_2;
		Integer add1_avm_automated_valuation_3;
		Integer add1_avm_automated_valuation_4;
		Integer add1_avm_automated_valuation_5;
		Boolean add1_applicant_owned;
		Boolean add1_occupant_owned;
		Boolean add1_family_owned;
		Integer add1_naprop;
		Integer ADD1_PURCHASE_AMOUNT;
		String add1_financing_type;
		String add1_building_area;
		Integer property_owned_total;
		Integer property_sold_total;
		String add2_advo_address_vacancy;
		Integer addrs_5yr;
		Integer addrs_10yr;
		Integer addrs_15yr;
		Integer avg_mo_per_addr;
		Integer hist_addr_match;
		String telcordia_type;
		String gong_did_first_seen;
		String gong_did_last_seen;
		Integer gong_did_phone_ct;
		Integer gong_did_addr_ct;
		Integer gong_did_last_ct;
		Integer ssns_per_adl;
		Integer adlPerSSN_count;
		Integer addrs_per_ssn;
		Integer adls_per_addr;
		Integer ssns_per_addr;
		Integer phones_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer addrs_per_adl_c6;
		Integer lnames_per_adl_c6;
		Integer adls_per_ssn_c6;
		Integer addrs_per_ssn_c6;
		Integer adls_per_addr_c6;
		Integer ssns_per_addr_c6;
		Integer invalid_ssns_per_adl;
		String inq_last_log_date;
		Integer inq_count01;
		Integer inq_count03;
		Integer inq_count06;
		Integer inq_count12;
		Integer inq_collection_count01;
		Integer inq_collection_count03;
		Integer inq_collection_count06;
		Integer inq_collection_count12;
		Integer inq_addrsperadl;
		Integer inq_ssnsperaddr;
		Integer inq_perphone;
		Integer inq_adlsperphone;
		Integer paw_business_count;
		Integer paw_dead_business_count;
		Integer paw_active_phone_count;
		Integer infutor_nap;
		Integer impulse_count;
		Integer email_count;
		Integer email_domain_free_count;
		Integer email_domain_isp_count;
		Integer email_domain_edu_count;
		Integer email_domain_corp_count;
		qstring50 email_source_list;
		qstring50 email_source_count;
		Integer attr_addrs_last12;
		Integer attr_addrs_last24;
		Integer attr_addrs_last36;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Integer attr_date_last_eviction;
		Boolean Bankrupt;
		String disposition;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		String liens_last_unrel_date;
		Integer liens_unrel_sc_total_amount;
		Integer criminal_count;
		Integer criminal_last_date;
		String ams_college_code;
		String ams_income_level_code;
		String prof_license_category;
		String wealth_index;
		String input_dob_age;
		String input_dob_match_level;
		Integer inferred_age;
		Integer estimated_income;
		Integer archive_date;

		Integer today;
		Integer est_age;
		Integer hist_addr_match_n;
		Boolean add1_vacant_address;
		Boolean add2_vacant_address;
		Integer property_owned_ind;
		Integer rc_ssnlowissue2;
		Integer time_since_ssnlowissue;
		Integer rc_ssnlowissue_sas;
		Integer in_dob_sas;
		Integer age_at_ssnlowissue;
		Integer gong_did_first_seen2;
		Integer mosince_gong_did_ls;
		Integer gong_did_first_seen_sas;
		Integer gong_did_last_seen_sas;
		Integer time_on_gong;
		Integer inq_last_log_date2;
		Integer mosince_inq_last_log;
		Integer criminal_last_date2;
		Integer mosince_criminal_ls;
		Integer liens_last_unrel_date2;
		Integer mosince_liens_unrel_ls;
		Integer attr_date_last_eviction2;
		Integer mosince_eviction_ls;
		Integer tot_ak_pos;
		Real tot_cnt_ak;
		Integer tot_am_pos;
		Real tot_cnt_am;
		Integer tot_ar_pos;
		Real tot_cnt_ar;
		Integer tot_ba_pos;
		Real tot_cnt_ba;
		Integer tot_cg_pos;
		Real tot_cnt_cg;
		Integer tot_co_pos;
		Real tot_cnt_co;
		Integer tot_cy_pos;
		Real tot_cnt_cy;
		Integer tot_da_pos;
		Real tot_cnt_da;
		Integer tot_d_pos;
		Real tot_cnt_d;
		Integer tot_dl_pos;
		Real tot_cnt_dl;
		Integer tot_ds_pos;
		Real tot_cnt_ds;
		Integer tot_de_pos;
		Real tot_cnt_de;
		Integer tot_eb_pos;
		Real tot_cnt_eb;
		Integer tot_em_pos;
		Real tot_nas_em;
		Real tot_cnt_em;
		Integer tot_en_pos;
		Real tot_cnt_en;
		// Integer tot_eq_pos_a;
		Real tot_nas_en;
		Real tot_nas_e1;
		Real tot_nas_e2;
		Real tot_nas_e3;
		Real tot_nas_e4;
		Real tot_nas_eq;
		String tot_fdate_eq;
		String tot_fdate_en;
		Integer tot_fdate_eq2;
		Integer tot_fdate_en2;
		Integer tot_mosince_fdate_eq_a;
		Integer tot_mosince_fdate_en;
		String tot_ldate_eq;
		String tot_ldate_en;
		Integer tot_ldate_eq2;
		Integer tot_ldate_en2;
		Integer tot_mosince_ldate_eq_a;
		Integer tot_mosince_ldate_en;
		Real tot_cnt_eq_a;
		Real tot_cnt_eq;
		real tot_mosince_fdate_EQ;
		real tot_mosince_ldate_EQ;
		Integer tot_fe_pos;
		Real tot_cnt_fe;
		Integer tot_ff_pos;
		Real tot_cnt_ff;
		Integer tot_fr_pos;
		Real tot_cnt_fr;
		Integer tot_l2_pos;
		String tot_ldate_l2;
		Integer tot_ldate_l22;
		Integer tot_mosince_ldate_l2;
		Real tot_cnt_l2;
		Integer tot_li_pos;
		Real tot_cnt_li;
		Integer tot_mw_pos;
		Real tot_cnt_mw;
		Integer tot_nt_pos;
		Real tot_cnt_nt;
		Integer tot_p_pos;
		Real tot_nas_p;
		Real tot_cnt_p;
		Integer tot_pl_pos;
		Real tot_cnt_pl;
		Integer tot_ts_pos;
		Real tot_nas_ts;
		Real tot_cnt_ts;
		Integer tot_tu_pos;
		Real tot_cnt_tu;
		Integer tot_sl_pos;
		Real tot_cnt_sl;
		Integer tot_v_pos;
		Real tot_cnt_v;
		Integer tot_vo_pos;
		Real tot_nas_vo;
		Real tot_cnt_vo;
		Integer tot_w_pos;
		Real tot_cnt_w;
		Integer tot_wp_pos;
		Real tot_nas_wp;
		Real tot_cnt_wp;
		Real tot_eq_pos;
		// Real tot_cnt_em;
		// Real tot_nas_em;
		Real time_on_eq;
		Integer tot_source_ct;
		Integer email_im_pos;
		Real email_cnt_im;
		Integer max_email;
		Real email_cnt_im_ind;
		Integer email_domain_edu_ind;
		Integer email_domain_corp_ind;
		Integer paw_business_ind;
		Integer paw_dead_business_ind;
		Integer paw_active_phone_ind;
		Integer inq_noncoll_count01;
		Integer inq_noncoll_count03;
		Integer inq_noncoll_count06;
		Integer inq_noncoll_count12;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean lien_flag;
		Boolean source_tot_DS;
		Boolean source_tot_BA;
		Boolean bk_flag;
		Boolean ssn_deceased;
		Integer pk_impulse_count;
		// Integer pk_adl_cat_deceased;
		Integer bs_attr_derog_flag;
		Integer bs_attr_eviction_flag;
		Boolean Prop_Owner;
		Boolean segment_d;
		Boolean segment_y;
		Boolean segment_o;
		Boolean segment_x;
		Boolean d_vo_addr_ver;
		Boolean d_wp_addr_ver;
		Real d_p_addr_ver_summary_m;
		Real d_em_addr_ver_summary_m;
		Boolean d_eq_nas_ver;
		Boolean d_ts_nas_ver;
		Real d_tot_mosince_fdate_eq_480;
		Integer d_adls_per_addr_c6_4;
		Integer d_phones_per_addr_10;
		Integer d_addrs_per_ssn_25;
		Integer d_addrs_per_ssn_c6_2;
		Integer d_ssns_per_adl_5;
		Integer d_ssns_per_adl_c6_2;
		Real d_time_since_ssnlowissue_876;
		Boolean d_lo_combo_ssnscore;
		Real d_ssn_mod;
		Integer d_time_on_gong_120;
		Integer d_rc_disthphoneaddr_200;
		Boolean d_contrary_infutor_nap;
		Boolean d_pnotpots;
		Boolean d_hm_disconnected_phone;
		Integer d_gong_did_phone_ct_6;
		Boolean d_hi_gong_did_last_ct;
		Real d_phoneprob_mod;
		Boolean d_verfst_p;
		Boolean d_verphn_p;
		Real d_dob_ver_m;
		Boolean d_lo_source_ct;
		Real d_ver_mod;
		Real d_nodob_ver_mod;
		Real d_mosince_inq_last_log_12;
		Integer d_inq_noncoll_count_3;
		Real d_inq_noncoll_summary_m;
		Real d_add1_financing_type_m;
		Integer d_addrs_15yr_20;
		Real d_mosince_criminal_ls_84;
		Real d_mosince_liens_unrel_ls_84;
		Real d_mosince_eviction_ls_84;
		Real d_tot_mosince_ldate_l2_240;
		Boolean d_bk_dismissed;
		Boolean d_hi_filing_ct;
		Boolean d_bad_bk;
		Integer d_liens_unrel_sc_total_amt_10k;
		Integer d_liens_recent_unrel_ct_4;
		Boolean d_hi_email_ct;
		Real d_email_summary_m;
		Real d_paw_summary_m;
		Real d_prof_license_category_m;
		Integer d_ams_income_summary;
		Real d_ams_income_college_m;
		Real d_wealth_index_m;
		Real d_outest_dob;
		Real d_outest_nodob;
		Real d_outest;
		Boolean y_eq_nas_ver;
		Boolean y_ts_nas_ver;
		Boolean y_vo_addr_ver;
		Boolean y_time_on_eq_gt_age;
		Real y_time_on_eq_120;
		Boolean y_ssns_per_adl_gt1;
		Integer y_adlperssn_count_1_3;
		Integer y_addrs_per_ssn_c6_2;
		Integer y_ssns_per_addr_50;
		Integer y_ssns_per_addr_c6_5;
		Integer y_hm_rc_numelever;
		Integer y_hm_rc_numelever_3_6;
		Boolean y_did_ge2;
		Boolean y_dob_ver;
		Boolean y_verlst_p;
		Boolean y_verphn_p;
		Real y_ver_mod;
		Real y_ver_nodob_mod;
		Real y_mosince_gong_did_ls_108;
		Boolean y_no_adls_per_phone;
		Boolean y_hm_disconnected_phone;
		Boolean y_lo_infutor_nap;
		Real y_phoneprob_mod;
		Real y_est_age_18;
		Integer y_wealth_index_1_4;
		Real y_wealth_index_m;
		Boolean y_hi_prof_license_category;
		Integer y_ams_income_summary;
		Integer y_ams_college_summary;
		Real y_ams_income_college_m;
		Boolean y_hi_email_ct;
		Real y_email_summary_m;
		Real y_paw_summary_m;
		Integer y_inq_addrsperadl_2;
		Integer y_inq_adlsperphone_2;
		Boolean y_hr_add1_financing_type;
		Integer y_avg_mo_per_addr_60;
		Real y_addr_vacant_summary_m;
		Real y_add1_ownership_m;
		Boolean y_lo_addr_score;
		Boolean y_hm_invalid_addr;
		Boolean y_old_addr_match_input;
		Boolean y_no_addr_match_input;
		Integer y_addr_prob_summary;
		Real y_addr_prob_summary_m;
		Real y_outest_nodob;
		Real y_outest_dob;
		Real y_outest;
		Integer o_hm_rc_numelever;
		Integer o_hm_rc_numelever_4_6;
		Integer o_hm_rc_numelever_nodob;
		Integer o_hm_rc_numelever_nodob_3_5;
		Boolean o_lname_ver;
		Boolean o_dob_ver;
		Boolean o_infutor_ver;
		Boolean o_verfst_p;
		Boolean o_verphn_p;
		Boolean o_vo_addr_ver;
		Boolean o_wp_addr_ver;
		Boolean o_ts_nas_ver;
		Boolean o_did_ge2;
		Real o_ver_mod;
		Real o_ver_nodob_mod;
		Integer o_tot_source_ct_2_7;
		Real o_tot_mosince_fdate_eq_360;
		Real o_mosince_gong_did_ls_110;
		Boolean o_no_adls_per_phone;
		Boolean o_hm_disconnected_phone;
		Boolean o_pnotpots;
		Boolean o_no_gong_did_addr;
		Boolean o_lo_infutor_nap;
		Boolean o_hi_gong_did_last_ct;
		Real o_phoneprob_mod;
		Integer o_invalid_ssns_per_adl_ind;
		Boolean o_invalid_ssn;
		Boolean o_lo_combo_ssnscore;
		Boolean o_invalid_ssns_flag;
		Boolean o_ssn_issued_too_young_or_hi;
		Boolean o_ssns_per_adl_gt2;
		Integer o_ssns_per_adl_c6_2;
		Real o_time_since_ssnlowissue_480;
		Real o_ssn_mod;
		Real o_ssn_mod_nodob;
		Integer o_estimated_income_200k;
		Integer o_wealth_index_5;
		Real o_wealth_index_m;
		Integer o_ams_income_summary;
		Integer o_ams_college_summary;
		Real o_ams_income_college_m;
		Real o_prof_license_cat_m;
		Boolean o_hi_email_ct;
		Real o_email_summary_m;
		Real o_paw_summary_m;
		Integer o_inq_count12_2;
		Integer o_inq_ssnsperaddr_2;
		Integer o_inq_adlsperphone_2;
		Boolean o_hr_add1_financing_type;
		Boolean o_no_adls_per_addr;
		Boolean o_no_addr_match_input;
		Boolean o_lo_addr_score;
		Real o_addr_vacant_summary_m;
		Real o_addrprob_mod;
		Integer o_attr_addrs_last36_6;
		Integer o_add1_price_per_sqf;
		Integer o_add1_price_per_sqf_300;
		Integer o_avg_add1_avm_val_300k;
		Real o_add1_ownership_m;
		String o_address_recency;
		Real o_address_recency_m;
		Integer o_addrs_per_ssn_25;
		Integer o_addrs_per_ssn_c6_2;
		Integer o_adls_per_addr_10;
		Integer o_ssns_per_addr_35;
		Integer o_adls_per_addr_c6_3;
		Real o_outest_nodob;
		Real o_outest_dob;
		Real o_outest;
		Boolean x_did_ge2;
		Boolean x_fname_ver;
		Boolean x_addr_ver;
		Boolean x_ssn_ver;
		Boolean x_dob_ver;
		Boolean x_verphn_p;
		Boolean x_wp_addr_ver;
		Boolean x_vo_addr_ver;
		Boolean x_eq_nas_ver;
		Boolean x_ts_nas_ver;
		Real x_p_addr_ver_summary_m;
		Real x_ver_mod;
		Real x_ver_nodob_mod;
		Real x_mosince_gong_did_ls_110;
		Boolean x_no_adls_per_phone;
		Boolean x_pnotpots;
		Boolean x_hm_disconnected_phone;
		Boolean x_no_gong_did_addr;
		Real x_phoneprob_mod;
		Boolean x_ssn_issued_too_young_or_hi;
		Boolean x_lo_combo_ssnscore;
		Integer x_ssns_per_adl_c6_2;
		Boolean x_ssns_per_adl_gt1;
		Boolean x_invalid_ssn;
		Real x_ssn_mod;
		Real x_ssn_mod_nodob;
		Integer x_estimated_income_125k;
		Integer x_ams_income_summary;
		Integer x_ams_college_summary;
		Real x_ams_income_college_m;
		Boolean x_hi_prof_license_category;
		Boolean x_hi_email_ct;
		Real x_email_summary_m;
		Integer x_inq_count12_3;
		Integer x_inq_ssnsperaddr_2;
		Integer x_inq_perphone_2;
		Boolean x_hr_add1_financing_type;
		Real x_tot_mosince_fdate_eq_360;
		Boolean x_hi_ssns_per_adl_c6;
		Boolean x_hi_addrs_per_adl_c6;
		Boolean x_hi_lnames_per_adl_c6;
		Boolean x_adls_per_ssn_c6_ind;
		Boolean x_addrs_per_ssn_c6_ind;
		Boolean x_hi_adls_per_addr_c6;
		Boolean x_hi_ssns_per_addr_c6;
		Boolean x_too_recent_velocity;
		Integer x_addrs_per_ssn_25;
		Integer x_adls_per_addr_50;
		Real x_outest_nodob;
		Real x_outest_dob;
		Real x_outest;
		Real outest;
		Real phat;
		Integer score;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Boolean scored_222s;
		Integer RVA1104_0_0;
		
		Boolean addrPop;
		String in_phone10;
		Integer ADD2_NAPROP;
		Integer header_first_seen;
		Boolean add1_eda_sourced;
		String rc_dwelltype;
		Integer ADD3_NAPROP;
		String add1_avm_assessed_total_value;
		Integer add1_avm_med_geo12;
		Integer add1_avm_med_geo11;
		Boolean add2_applicant_owned;
		Boolean add3_applicant_owned;
		Boolean add2_family_owned;
		Boolean add3_family_owned;
		Integer add1_avm_med_fips;
		Integer add1_assessed_total_value;
		Integer PROPERTY_AMBIG_TOTAL;
		Integer felony_count;
		Boolean glrc3;
		Boolean glrc7;
		Boolean glrc20;
		Boolean glrc25;
		Integer glrc26;
		Boolean glrc27;
		Boolean glrc28;
		Integer glrc36;
		Integer glrc37;
		Boolean glrc49;
		Integer glrc74;
		Boolean glrc97;
		Boolean glrc98;
		Boolean glrc99;
		Boolean glrc9a;
		Boolean glrc9d;
		Integer glrc9e;
		Boolean glrc9g;
		Boolean glrc9h;
		Integer glrc9i;
		Integer header_first_seen2;
		Integer mosince_header_first_seen;
		Boolean glrc9j;
		Boolean glrc9o;
		Boolean glrc9q;
		Integer glrc9s;
		Boolean glrcev;
		Boolean glrcmi;
		Boolean glrcms;
		Integer aptflag_1;
		Integer aptflag;
		Integer add1_econval;
		Integer add1_aptval;
		String add1_econcode;
		Integer glrcpv;
		Boolean glrc9m;
		Integer glrc9r;
		Integer glrc9t;
		Boolean glrc9u;
		Integer glrc9v;
		Boolean glrc9w;

		Real rcvalue25_1_c10_b1;
		Real rcvalue25_2_c10_b1;
		Real rcvalue25_3_c10_b1;
		Real rcvalue25_4_c10_b1;
		Real rcvalue27_1_c10_b1;
		Real rcvalue27_2_c10_b1;
		Real rcvalue27_3_c10_b1;
		Real rcvalue27_4_c10_b1;
		Real rcvalue27_5_c10_b1;
		Real rcvalue27_6_c10_b1;
		Real rcvalue27_7_c10_b1;
		Real rcvalue28_1_c10_b1;
		Real rcvalue28_2_c10_b1;
		Real rcvalue28_3_c10_b1;
		Real rcvalue28_4_c10_b1;
		Real rcvalue36_1_c10_b1;
		Real rcvalue36_2_c10_b1;
		Real rcvalue36_3_c10_b1;
		Real rcvalue36_4_c10_b1;
		Real rcvalue36_5_c10_b1;
		Real rcvalue36_6_c10_b1;
		Real rcvalue36_7_c10_b1;
		Real rcvalue36_8_c10_b1;
		Real rcvalue36_9_c10_b1;
		Real rcvalue36_10_c10_b1;
		Real rcvalue36_11_c10_b1;
		Real rcvalue36_12_c10_b1;
		Real rcvalue36_13_c10_b1;
		Real rcvalue36_14_c10_b1;
		Real rcvalue36_15_c10_b1;
		Real rcvalue36_16_c10_b1;
		Real rcvalue36_17_c10_b1;
		Real rcvalue36_18_c10_b1;
		Real rcvalue36_19_c10_b1;
		Real rcvalue36_20_c10_b1;
		Real rcvalue36_21_c10_b1;
		Real rcvalue37_1_c10_b1;
		Real rcvalue37_2_c10_b1;
		Real rcvalue37_3_c10_b1;
		Real rcvalue37_4_c10_b1;
		Real rcvalue37_5_c10_b1;
		Real rcvalue49_1_c10_b1;
		Real rcvalue74_1_c10_b1;
		Real rcvalue74_2_c10_b1;
		Real rcvalue74_3_c10_b1;
		Real rcvalue97_1_c10_b1;
		Real rcvalue97_2_c10_b1;
		Real rcvalue98_1_c10_b1;
		Real rcvalue98_2_c10_b1;
		Real rcvalue98_3_c10_b1;
		Real rcvalue98_4_c10_b1;
		Real rcvalue99_1_c10_b1;
		Real rcvalue99_2_c10_b1;
		Real rcvalue99_3_c10_b1;
		Real rcvalue99_4_c10_b1;
		Real rcvalue99_5_c10_b1;
		Real rcvalue9a_1_c10_b1;
		Real rcvalue9a_2_c10_b1;
		Real rcvalue9a_3_c10_b1;
		Real rcvalue9d_1_c10_b1;
		Real rcvalue9d_2_c10_b1;
		Real rcvalue9d_3_c10_b1;
		Real rcvalue9d_4_c10_b1;
		Real rcvalue9d_5_c10_b1;
		Real rcvalue9d_6_c10_b1;
		Real rcvalue9d_7_c10_b1;
		Real rcvalue9d_8_c10_b1;
		Real rcvalue9e_1_c10_b1;
		Real rcvalue9e_2_c10_b1;
		Real rcvalue9g_1_c10_b1;
		Real rcvalue9g_2_c10_b1;
		Real rcvalue9g_3_c10_b1;
		Real rcvalue9g_4_c10_b1;
		Real rcvalue9h_1_c10_b1;
		Real rcvalue9m_1_c10_b1;
		Real rcvalue9m_2_c10_b1;
		Real rcvalue9m_3_c10_b1;
		Real rcvalue9m_4_c10_b1;
		Real rcvalue9m_5_c10_b1;
		Real rcvalue9m_6_c10_b1;
		Real rcvalue9m_7_c10_b1;
		Real rcvalue9m_8_c10_b1;
		Real rcvalue9m_9_c10_b1;
		Real rcvalue9o_1_c10_b1;
		Real rcvalue9o_2_c10_b1;
		Real rcvalue9q_1_c10_b1;
		Real rcvalue9q_2_c10_b1;
		Real rcvalue9q_3_c10_b1;
		Real rcvalue9q_4_c10_b1;
		Real rcvalue9q_5_c10_b1;
		Real rcvalue9q_6_c10_b1;
		Real rcvalue9q_7_c10_b1;
		Real rcvalue9q_8_c10_b1;
		Real rcvalue9q_9_c10_b1;
		Real rcvalue9q_10_c10_b1;
		Real rcvalue9r_1_c10_b1;
		Real rcvalue9r_2_c10_b1;
		Real rcvalue9r_3_c10_b1;
		Real rcvalue9r_4_c10_b1;
		Real rcvalue9r_5_c10_b1;
		Real rcvalue9r_6_c10_b1;
		Real rcvalue9r_7_c10_b1;
		Real rcvalue9r_8_c10_b1;
		Real rcvalue9r_9_c10_b1;
		Real rcvalue9r_10_c10_b1;
		Real rcvalue9r_11_c10_b1;
		Real rcvalue9r_12_c10_b1;
		Real rcvalue9r_13_c10_b1;
		Real rcvalue9r_14_c10_b1;
		Real rcvalue9r_15_c10_b1;
		Real rcvalue9r_16_c10_b1;
		Real rcvalue9r_17_c10_b1;
		Real rcvalue9s_1_c10_b1;
		Real rcvalue9s_2_c10_b1;
		Real rcvalue9s_3_c10_b1;
		Real rcvalue9t_1_c10_b1;
		Real rcvalue9t_2_c10_b1;
		Real rcvalue9t_3_c10_b1;
		Real rcvalue9t_4_c10_b1;
		Real rcvalue9t_5_c10_b1;
		Real rcvalue9t_6_c10_b1;
		Real rcvalue9t_7_c10_b1;
		Real rcvalue9u_1_c10_b1;
		Real rcvalue9u_2_c10_b1;
		Real rcvalue9u_3_c10_b1;
		Real rcvalue9v_1_c10_b1;
		Real rcvalue9v_2_c10_b1;
		Real rcvalue9v_3_c10_b1;
		Real rcvalue9w_1_c10_b1;
		Real rcvalue9w_2_c10_b1;
		Real rcvalueev_1_c10_b1;
		Real rcvalueev_2_c10_b1;
		Real rcvaluemi_1_c10_b1;
		Real rcvaluems_1_c10_b1;
		Real rcvaluems_2_c10_b1;
		Real rcvaluems_3_c10_b1;
		Real rcvaluems_4_c10_b1;
		Real rcvaluems_5_c10_b1;
		Real rcvaluems_6_c10_b1;
		Real rcvaluems_7_c10_b1;
		Real rcvaluepv_1_c10_b1;
		Real rcvaluepv_2_c10_b1;
		Real rcvalue25_1_c10_b2;
		Real rcvalue25_2_c10_b2;
		Real rcvalue25_3_c10_b2;
		Real rcvalue25_4_c10_b2;
		Real rcvalue26_1_c10_b2;
		Real rcvalue27_1_c10_b2;
		Real rcvalue27_2_c10_b2;
		Real rcvalue27_3_c10_b2;
		Real rcvalue27_4_c10_b2;
		Real rcvalue27_5_c10_b2;
		Real rcvalue27_6_c10_b2;
		Real rcvalue27_7_c10_b2;
		Real rcvalue36_1_c10_b2;
		Real rcvalue36_2_c10_b2;
		Real rcvalue36_3_c10_b2;
		Real rcvalue36_4_c10_b2;
		Real rcvalue36_5_c10_b2;
		Real rcvalue36_6_c10_b2;
		Real rcvalue36_7_c10_b2;
		Real rcvalue36_8_c10_b2;
		Real rcvalue36_9_c10_b2;
		Real rcvalue36_10_c10_b2;
		Real rcvalue36_11_c10_b2;
		Real rcvalue36_12_c10_b2;
		Real rcvalue36_13_c10_b2;
		Real rcvalue36_14_c10_b2;
		Real rcvalue36_15_c10_b2;
		Real rcvalue36_16_c10_b2;
		Real rcvalue36_17_c10_b2;
		Real rcvalue36_18_c10_b2;
		Real rcvalue36_19_c10_b2;
		Real rcvalue36_20_c10_b2;
		Real rcvalue36_21_c10_b2;
		Real rcvalue36_22_c10_b2;
		Real rcvalue36_23_c10_b2;
		Real rcvalue37_1_c10_b2;
		Real rcvalue37_2_c10_b2;
		Real rcvalue37_3_c10_b2;
		Real rcvalue37_4_c10_b2;
		Real rcvalue37_5_c10_b2;
		Real rcvalue49_1_c10_b2;
		Real rcvalue74_1_c10_b2;
		Real rcvalue74_2_c10_b2;
		Real rcvalue74_3_c10_b2;
		Real rcvalue97_1_c10_b2;
		Real rcvalue97_2_c10_b2;
		Real rcvalue98_1_c10_b2;
		Real rcvalue98_2_c10_b2;
		Real rcvalue98_3_c10_b2;
		Real rcvalue98_4_c10_b2;
		Real rcvalue99_1_c10_b2;
		Real rcvalue99_2_c10_b2;
		Real rcvalue99_3_c10_b2;
		Real rcvalue99_4_c10_b2;
		Real rcvalue99_5_c10_b2;
		Real rcvalue99_6_c10_b2;
		Real rcvalue99_7_c10_b2;
		Real rcvalue99_8_c10_b2;
		Real rcvalue99_9_c10_b2;
		Real rcvalue99_10_c10_b2;
		Real rcvalue99_11_c10_b2;
		Real rcvalue99_12_c10_b2;
		Real rcvalue99_13_c10_b2;
		Real rcvalue99_14_c10_b2;
		Real rcvalue99_15_c10_b2;
		Real rcvalue99_16_c10_b2;
		Real rcvalue99_17_c10_b2;
		Real rcvalue9a_1_c10_b2;
		Real rcvalue9a_2_c10_b2;
		Real rcvalue9a_3_c10_b2;
		Real rcvalue9d_1_c10_b2;
		Real rcvalue9d_2_c10_b2;
		Real rcvalue9d_3_c10_b2;
		Real rcvalue9d_4_c10_b2;
		Real rcvalue9d_5_c10_b2;
		Real rcvalue9d_6_c10_b2;
		Real rcvalue9d_7_c10_b2;
		Real rcvalue9d_8_c10_b2;
		Real rcvalue9e_1_c10_b2;
		Real rcvalue9e_2_c10_b2;
		Real rcvalue9g_1_c10_b2;
		Real rcvalue9g_2_c10_b2;
		Real rcvalue9g_3_c10_b2;
		Real rcvalue9h_1_c10_b2;
		Real rcvalue9m_1_c10_b2;
		Real rcvalue9m_2_c10_b2;
		Real rcvalue9m_3_c10_b2;
		Real rcvalue9m_4_c10_b2;
		Real rcvalue9m_5_c10_b2;
		Real rcvalue9m_6_c10_b2;
		Real rcvalue9m_7_c10_b2;
		Real rcvalue9m_8_c10_b2;
		Real rcvalue9m_9_c10_b2;
		Real rcvalue9m_10_c10_b2;
		Real rcvalue9o_1_c10_b2;
		Real rcvalue9o_2_c10_b2;
		Real rcvalue9q_1_c10_b2;
		Real rcvalue9q_2_c10_b2;
		Real rcvalue9q_3_c10_b2;
		Real rcvalue9q_4_c10_b2;
		Real rcvalue9q_5_c10_b2;
		Real rcvalue9q_6_c10_b2;
		Real rcvalue9q_7_c10_b2;
		Real rcvalue9q_8_c10_b2;
		Real rcvalue9q_9_c10_b2;
		Real rcvalue9q_10_c10_b2;
		Real rcvalue9r_1_c10_b2;
		Real rcvalue9r_2_c10_b2;
		Real rcvalue9r_3_c10_b2;
		Real rcvalue9r_4_c10_b2;
		Real rcvalue9r_5_c10_b2;
		Real rcvalue9r_6_c10_b2;
		Real rcvalue9r_7_c10_b2;
		Real rcvalue9r_8_c10_b2;
		Real rcvalue9r_9_c10_b2;
		Real rcvalue9r_10_c10_b2;
		Real rcvalue9r_11_c10_b2;
		Real rcvalue9r_12_c10_b2;
		Real rcvalue9r_13_c10_b2;
		Real rcvalue9r_14_c10_b2;
		Real rcvalue9r_15_c10_b2;
		Real rcvalue9r_16_c10_b2;
		Real rcvalue9r_17_c10_b2;
		Real rcvalue9s_1_c10_b2;
		Real rcvalue9s_2_c10_b2;
		Real rcvalue9s_3_c10_b2;
		Real rcvalue9s_4_c10_b2;
		Real rcvalue9t_1_c10_b2;
		Real rcvalue9t_2_c10_b2;
		Real rcvalue9t_3_c10_b2;
		Real rcvalue9t_4_c10_b2;
		Real rcvalue9t_5_c10_b2;
		Real rcvalue9t_6_c10_b2;
		Real rcvalue9t_7_c10_b2;
		Real rcvalue9u_1_c10_b2;
		Real rcvalue9u_2_c10_b2;
		Real rcvalue9v_1_c10_b2;
		Real rcvalue9v_2_c10_b2;
		Real rcvalue9w_1_c10_b2;
		Real rcvalue9w_2_c10_b2;
		Real rcvalueev_1_c10_b2;
		Real rcvalueev_2_c10_b2;
		Real rcvaluemi_1_c10_b2;
		Real rcvaluems_1_c10_b2;
		Real rcvaluems_2_c10_b2;
		Real rcvaluems_3_c10_b2;
		Real rcvaluems_4_c10_b2;
		Real rcvaluems_5_c10_b2;
		Real rcvaluems_6_c10_b2;
		Real rcvaluems_7_c10_b2;
		Real rcvaluepv_1_c10_b2;
		Real rcvaluepv_2_c10_b2;
		Real rcvaluemi;
		Real rcvalue27;
		Real rcvalue9r;
		Real rcvalue9d;
		Real rcvalue98;
		Real rcvaluepv;
		Real rcvalue99;
		Real rcvalue9s;
		Real rcvalueev;
		Real rcvalue49;
		Real rcvalue9m;
		Real rcvalue9a;
		Real rcvalue9v;
		Real rcvalue9o;
		Real rcvalue28;
		Real rcvalue9u;
		Real rcvalue25;
		Real rcvalue97;
		Real rcvalue9g;
		Real rcvalue26;
		Real rcvalue9t;
		Real rcvalue37;
		Real rcvalue9w;
		Real rcvalue74;
		Real rcvaluems;
		Real rcvalue36;
		Real rcvalue9h;
		Real rcvalue9e;
		Real rcvalue9q;
		
		string2 rc1;
		string2 rc2;
		string2 rc3;
		string2 rc4;
		string2 rc5;
		
		string	Ssnlength	;
		boolean	hphnpop	;
		boolean	fnamepop	;
		boolean	lnamepop	;

	end;
	debug_layout doModel( clam le ) := TRANSFORM
	#else
	models.layout_modelout doModel( clam le ) := TRANSFORM
	#end

	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	did_count                        := le.iid.didcount;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_statezipflag                  := le.iid.statezipflag;
	combo_fnamescore                 := le.iid.combo_firstscore;
	combo_lnamescore                 := le.iid.combo_lastscore;
	combo_addrscore                  := le.iid.combo_addrscore;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_fnamecount                 := le.iid.combo_firstcount;
	combo_lnamecount                 := le.iid.combo_lastcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_hphonecount                := le.iid.combo_hphonecount;
	combo_ssncount                   := le.iid.combo_ssncount;
	combo_dobcount                   := le.iid.combo_dobcount;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_nas                  := le.header_summary.ver_sources_nas;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	dobpop                           := le.input_validation.dateofbirth;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
	add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
	add1_avm_automated_valuation_5   := le.avm.input_address_information.avm_automated_valuation5;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_building_area               := (string)le.address_verification.input_address_information.building_area;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_advo_address_vacancy        := le.advo_addr_hist1.address_vacancy_indicator;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	hist_addr_match                  := le.address_history_summary.hist_addr_match;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
	gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	adls_per_phone                   := le.velocity_counters.adls_per_phone;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := le.velocity_counters.lnames_per_adl180;
	adls_per_ssn_c6                  := le.velocity_counters.adls_per_ssn_created_6months;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_last_log_date                := le.acc_logs.last_log_date;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
	inq_perphone                     := le.acc_logs.inquiryperphone;
	inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
	paw_business_count               := le.employment.business_ct;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	email_domain_edu_count           := le.email_summary.email_domain_edu_ct;
	email_domain_corp_count          := le.email_summary.email_domain_corp_ct;
	email_source_list                := le.email_summary.email_source_list;
	email_source_count               := le.email_summary.email_source_ct;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_date_last_eviction          := le.bjl.last_eviction_date;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_last_unrel_date            := le.bjl.last_liens_unreleased_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	ams_college_code                 := le.student.college_code;
	ams_income_level_code            := le.student.income_level_code;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;
	hphnpop                          := le.input_validation.homephone;
















		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target)
			OR (StringLib.StringFind(source, delim + target + delim, 1) > 0)
			OR (source[1..length(target)+1] = target + delim)
			OR (StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


		NULL := -999999999;


		archive_date := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);
		today := (ut.DaysSince1900(((string)archive_date)[1..4], ((string)archive_date)[5..6], (string)01) - ut.DaysSince1900('1960', '1', '1'));

		est_age := if((integer)input_dob_age != 0, (integer)input_dob_age, (integer)inferred_age);

		hist_addr_match_n := hist_addr_match;

		add1_vacant_address := (string)add1_advo_address_vacancy = 'Y';

		add2_vacant_address := (string)add2_advo_address_vacancy = 'Y';

		property_owned_ind := min(if(property_owned_total = NULL, -NULL, property_owned_total), 1);

		rc_ssnlowissue2 := models.common.sas_date((string)(rc_ssnlowissue));

		time_since_ssnlowissue := if(min(today, rc_ssnlowissue2) = NULL, NULL, (integer)((today - rc_ssnlowissue2) / 30.5));

		rc_ssnlowissue_sas := models.common.sas_date((string)(rc_ssnlowissue));

		in_dob_sas := models.common.sas_date1800s((string)(in_dob));

		age_at_ssnlowissue := if( NULL in [rc_ssnlowissue_sas,in_dob_sas], NULL, truncate((rc_ssnlowissue_sas - in_dob_sas) / 365.25) );

		gong_did_first_seen2 := models.common.sas_date((string)(gong_did_first_seen));

		mosince_gong_did_ls := if(min(today, gong_did_first_seen2) = NULL, NULL, (integer)((today - gong_did_first_seen2) / 30.5));

		gong_did_first_seen_sas := models.common.sas_date((string)(gong_did_first_seen));

		gong_did_last_seen_sas := models.common.sas_date((string)(gong_did_last_seen));

		time_on_gong := if( NULL in [gong_did_last_seen_sas,gong_did_first_seen_sas], NULL, truncate((gong_did_last_seen_sas - gong_did_first_seen_sas) / 30.5));

		inq_last_log_date2 := models.common.sas_date((string)(inq_last_log_date));

		mosince_inq_last_log := if(min(today, inq_last_log_date2) = NULL, NULL, (integer)((today - inq_last_log_date2) / 30.5));

		criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

		mosince_criminal_ls := if(min(today, criminal_last_date2) = NULL, NULL, (integer)((today - criminal_last_date2) / 30.5));

		liens_last_unrel_date2 := models.common.sas_date((string)(liens_last_unrel_date));

		mosince_liens_unrel_ls := if(min(today, liens_last_unrel_date2) = NULL, NULL, (integer)((today - liens_last_unrel_date2) / 30.5));

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		mosince_eviction_ls := if(min(today, attr_date_last_eviction2) = NULL, NULL, (integer)((today - attr_date_last_eviction2) / 30.5));

		tot_ak_pos := models.common.findw_cpp(ver_sources, 'AK' , ' ,', 'ie');

		tot_cnt_ak := if(tot_ak_pos > 0, (real)models.common.getw(ver_sources_count, tot_ak_pos), 0);

		tot_am_pos := models.common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie');

		tot_cnt_am := if(tot_am_pos > 0, (real)models.common.getw(ver_sources_count, tot_am_pos), 0);

		tot_ar_pos := models.common.findw_cpp(ver_sources, 'AR' , ' ,', 'ie');

		tot_cnt_ar := if(tot_ar_pos > 0, (real)models.common.getw(ver_sources_count, tot_ar_pos), 0);

		tot_ba_pos := models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		tot_cnt_ba := if(tot_ba_pos > 0, (real)models.common.getw(ver_sources_count, tot_ba_pos), 0);

		tot_cg_pos := models.common.findw_cpp(ver_sources, 'CG' , ' ,', 'ie');

		tot_cnt_cg := if(tot_cg_pos > 0, (real)models.common.getw(ver_sources_count, tot_cg_pos), 0);

		tot_co_pos := models.common.findw_cpp(ver_sources, 'CO' , ' ,', 'ie');

		tot_cnt_co := if(tot_co_pos > 0, (real)models.common.getw(ver_sources_count, tot_co_pos), 0);

		tot_cy_pos := models.common.findw_cpp(ver_sources, 'CY' , ' ,', 'ie');

		tot_cnt_cy := if(tot_cy_pos > 0, (real)models.common.getw(ver_sources_count, tot_cy_pos), 0);

		tot_da_pos := models.common.findw_cpp(ver_sources, 'DA' , ' ,', 'ie');

		tot_cnt_da := if(tot_da_pos > 0, (real)models.common.getw(ver_sources_count, tot_da_pos), 0);

		tot_d_pos := models.common.findw_cpp(ver_sources, 'D' , ' ,', 'ie');

		tot_cnt_d := if(tot_d_pos > 0, (real)models.common.getw(ver_sources_count, tot_d_pos), 0);

		tot_dl_pos := models.common.findw_cpp(ver_sources, 'DL' , ' ,', 'ie');

		tot_cnt_dl := if(tot_dl_pos > 0, (real)models.common.getw(ver_sources_count, tot_dl_pos), 0);

		tot_ds_pos := models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		tot_cnt_ds := if(tot_ds_pos > 0, (real)models.common.getw(ver_sources_count, tot_ds_pos), 0);

		tot_de_pos := models.common.findw_cpp(ver_sources, 'DE' , ' ,', 'ie');

		tot_cnt_de := if(tot_de_pos > 0, (real)models.common.getw(ver_sources_count, tot_de_pos), 0);

		tot_eb_pos := models.common.findw_cpp(ver_sources, 'EB' , ' ,', 'ie');

		tot_cnt_eb := if(tot_eb_pos > 0, (real)models.common.getw(ver_sources_count, tot_eb_pos), 0);

		tot_em_pos := models.common.findw_cpp(ver_sources, 'EM' , ' ,', 'ie');

		tot_nas_em_a := if(tot_em_pos > 0, (real)models.common.getw(ver_sources_nas, tot_em_pos), 0);

		tot_e1_pos := models.common.findw_cpp(ver_sources, 'E1' , ' ,', 'ie');
		tot_e2_pos := models.common.findw_cpp(ver_sources, 'E2' , ' ,', 'ie');
		tot_e3_pos := models.common.findw_cpp(ver_sources, 'E3' , ' ,', 'ie');
		tot_e4_pos := models.common.findw_cpp(ver_sources, 'E4' , ' ,', 'ie');

		tot_cnt_em_a := if(tot_em_pos > 0, (real)models.common.getw(ver_sources_count, tot_em_pos), 0);
		tot_cnt_e1 := if(tot_e1_pos > 0, (real)models.common.getw(ver_sources_count, tot_e1_pos), 0);
		tot_cnt_e2 := if(tot_e2_pos > 0, (real)models.common.getw(ver_sources_count, tot_e2_pos), 0);
		tot_cnt_e3 := if(tot_e3_pos > 0, (real)models.common.getw(ver_sources_count, tot_e3_pos), 0);
		tot_cnt_e4 := if(tot_e4_pos > 0, (real)models.common.getw(ver_sources_count, tot_e4_pos), 0);

		tot_en_pos := models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

		tot_cnt_en := if(tot_en_pos > 0, (real)models.common.getw(ver_sources_count, tot_en_pos), 0);

		tot_eq_pos := models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		tot_nas_eq_a := if(tot_eq_pos > 0, (real)models.common.getw(ver_sources_nas, tot_eq_pos), 0);
		tot_nas_en := if(tot_en_pos > 0, (real)models.common.getw(ver_sources_nas, tot_en_pos), 0);

		tot_nas_e1 := if(tot_e1_pos > 0, (real)models.common.getw(ver_sources_nas, tot_e1_pos), 0);
		tot_nas_e2 := if(tot_e2_pos > 0, (real)models.common.getw(ver_sources_nas, tot_e2_pos), 0);
		tot_nas_e3 := if(tot_e3_pos > 0, (real)models.common.getw(ver_sources_nas, tot_e3_pos), 0);
		tot_nas_e4 := if(tot_e4_pos > 0, (real)models.common.getw(ver_sources_nas, tot_e4_pos), 0);

		tot_fdate_eq := if(tot_eq_pos > 0, models.common.getw(ver_sources_first_seen, tot_eq_pos), '0');
		tot_fdate_en := if(tot_en_pos > 0, models.common.getw(ver_sources_first_seen, tot_en_pos), '0');

		tot_fdate_eq2 := models.common.sas_date((string)(tot_fdate_eq));
		tot_fdate_en2 := models.common.sas_date((string)(tot_fdate_en));

		tot_mosince_fdate_eq_a := if(min(today, tot_fdate_eq2) = NULL, NULL, (integer)((today - tot_fdate_eq2) / 30.5));
		tot_mosince_fdate_en   := if(min(today, tot_fdate_en2) = NULL, NULL, (integer)((today - tot_fdate_en2) / 30.5));

		tot_ldate_eq := if(tot_eq_pos > 0, models.common.getw(ver_sources_last_seen, tot_eq_pos), '0');
		tot_ldate_en := if(tot_en_pos > 0, models.common.getw(ver_sources_last_seen, tot_en_pos), '0');

		tot_ldate_eq2 := models.common.sas_date((string)(tot_ldate_eq));
		tot_ldate_en2 := models.common.sas_date((string)(tot_ldate_en));

		tot_mosince_ldate_eq_a := if(min(today, tot_ldate_eq2) = NULL, NULL, (integer)((today - tot_ldate_eq2) / 30.5));
		tot_mosince_ldate_en := if(min(today, tot_ldate_en2) = NULL, NULL, (integer)((today - tot_ldate_en2) / 30.5));

		tot_cnt_eq_a := if(tot_eq_pos > 0, (real)models.common.getw(ver_sources_count, tot_eq_pos), 0);

		/* Code adjustment to make sure credit sources checking both EQ & EN */
		Tot_cnt_EQ := sum(tot_cnt_EQ_a,Tot_Cnt_EN); 
		tot_mosince_fdate_EQ := max(tot_mosince_fdate_EQ_a,tot_mosince_fdate_EN); 
		// tot_mosince_ldate_EQ := min(tot_mosince_ldate_EQ_a,tot_mosince_ldate_EN);
		tot_mosince_ldate_EQ := map(
			tot_mosince_ldate_EQ_a = NULL => tot_mosince_ldate_EN,
			tot_mosince_ldate_EN = NULL => tot_mosince_ldate_EQ_a,
			min(tot_mosince_ldate_EN, tot_mosince_ldate_EQ_a)
		);
		tot_nas_EQ	:= max(tot_nas_EQ_a,tot_nas_EN);


		tot_fe_pos := models.common.findw_cpp(ver_sources, 'FE' , ' ,', 'ie');

		tot_cnt_fe := if(tot_fe_pos > 0, (real)models.common.getw(ver_sources_count, tot_fe_pos), 0);

		tot_ff_pos := models.common.findw_cpp(ver_sources, 'FF' , ' ,', 'ie');

		tot_cnt_ff := if(tot_ff_pos > 0, (real)models.common.getw(ver_sources_count, tot_ff_pos), 0);

		tot_fr_pos := models.common.findw_cpp(ver_sources, 'FR' , ' ,', 'ie');

		tot_cnt_fr := if(tot_fr_pos > 0, (real)models.common.getw(ver_sources_count, tot_fr_pos), 0);

		tot_l2_pos := models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		tot_ldate_l2 := if(tot_l2_pos > 0, models.common.getw(ver_sources_last_seen, tot_l2_pos), '0');

		tot_ldate_l22 := models.common.sas_date((string)(tot_ldate_l2));

		tot_mosince_ldate_l2 := if(min(today, tot_ldate_l22) = NULL, NULL, (integer)((today - tot_ldate_l22) / 30.5));

		tot_cnt_l2 := if(tot_l2_pos > 0, (real)models.common.getw(ver_sources_count, tot_l2_pos), 0);

		tot_li_pos := models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		tot_cnt_li := if(tot_li_pos > 0, (real)models.common.getw(ver_sources_count, tot_li_pos), 0);

		tot_mw_pos := models.common.findw_cpp(ver_sources, 'MW' , ' ,', 'ie');

		tot_cnt_mw := if(tot_mw_pos > 0, (real)models.common.getw(ver_sources_count, tot_mw_pos), 0);

		tot_nt_pos := models.common.findw_cpp(ver_sources, 'NT' , ' ,', 'ie');

		tot_cnt_nt := if(tot_nt_pos > 0, (real)models.common.getw(ver_sources_count, tot_nt_pos), 0);

		tot_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		tot_nas_p := if(tot_p_pos > 0, (real)models.common.getw(ver_sources_nas, tot_p_pos), 0);

		tot_cnt_p := if(tot_p_pos > 0, (real)models.common.getw(ver_sources_count, tot_p_pos), 0);

		tot_pl_pos := models.common.findw_cpp(ver_sources, 'PL' , ' ,', 'ie');

		tot_cnt_pl := if(tot_pl_pos > 0, (real)models.common.getw(ver_sources_count, tot_pl_pos), 0);

		tot_ts_pos := models.common.findw_cpp(ver_sources, 'TS' , ' ,', 'ie');

		tot_nas_ts := if(tot_ts_pos > 0, (real)models.common.getw(ver_sources_nas, tot_ts_pos), 0);

		tot_cnt_ts := if(tot_ts_pos > 0, (real)models.common.getw(ver_sources_count, tot_ts_pos), 0);

		tot_tu_pos := models.common.findw_cpp(ver_sources, 'TU' , ' ,', 'ie');

		tot_cnt_tu := if(tot_tu_pos > 0, (real)models.common.getw(ver_sources_count, tot_tu_pos), 0);

		tot_sl_pos := models.common.findw_cpp(ver_sources, 'SL' , ' ,', 'ie');

		tot_cnt_sl := if(tot_sl_pos > 0, (real)models.common.getw(ver_sources_count, tot_sl_pos), 0);

		tot_v_pos := models.common.findw_cpp(ver_sources, 'V' , ' ,', 'ie');

		tot_cnt_v := if(tot_v_pos > 0, (real)models.common.getw(ver_sources_count, tot_v_pos), 0);

		tot_vo_pos := models.common.findw_cpp(ver_sources, 'VO' , ' ,', 'ie');

		tot_nas_vo := if(tot_vo_pos > 0, (real)models.common.getw(ver_sources_nas, tot_vo_pos), 0);

		tot_cnt_vo := if(tot_vo_pos > 0, (real)models.common.getw(ver_sources_count, tot_vo_pos), 0);

		tot_w_pos := models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');

		tot_cnt_w := if(tot_w_pos > 0, (real)models.common.getw(ver_sources_count, tot_w_pos), 0);

		tot_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

		tot_nas_wp := if(tot_wp_pos > 0, (real)models.common.getw(ver_sources_nas, tot_wp_pos), 0);

		tot_cnt_wp := if(tot_wp_pos > 0, (real)models.common.getw(ver_sources_count, tot_wp_pos), 0);



	/* Code adjustment because development shell had EM, E1-E4 rolled up and subsequent shells will not */
	tot_cnt_EM := sum(tot_cnt_EM_a,tot_cnt_E1,tot_cnt_E2,tot_cnt_E3,tot_cnt_E4);
	tot_nas_EM := max(tot_nas_EM_a,tot_nas_E1,tot_nas_E2,tot_nas_E3,tot_nas_E4);



		time_on_eq := if( NULL in [tot_mosince_fdate_eq,tot_mosince_ldate_eq], NULL, tot_mosince_fdate_eq - tot_mosince_ldate_eq );

		tot_source_ct := //if(max((integer)tot_cnt_ak > 0, (integer)tot_cnt_am > 0, (integer)tot_cnt_ar > 0, (integer)tot_cnt_ba > 0, (integer)tot_cnt_cg > 0, (integer)tot_cnt_co > 0, (integer)tot_cnt_cy > 0, (integer)tot_cnt_da > 0, (integer)tot_cnt_d > 0, (integer)tot_cnt_dl > 0, (integer)tot_cnt_ds > 0, (integer)tot_cnt_de > 0, (integer)tot_cnt_eb > 0, (integer)tot_cnt_em > 0, (integer)tot_cnt_en > 0, (integer)tot_cnt_eq > 0, (integer)tot_cnt_fe > 0, (integer)tot_cnt_ff > 0, (integer)tot_cnt_fr > 0, (integer)tot_cnt_l2 > 0, (integer)tot_cnt_li > 0, (integer)tot_cnt_mw > 0, (integer)tot_cnt_nt > 0, (integer)tot_cnt_p > 0, (integer)tot_cnt_pl > 0, (integer)tot_cnt_ts > 0, (integer)tot_cnt_tu > 0, (integer)tot_cnt_sl > 0, (integer)tot_cnt_v > 0, (integer)tot_cnt_vo > 0, (integer)tot_cnt_w > 0, (integer)tot_cnt_wp > 0) = NULL, NULL,
			sum((integer)((integer)tot_cnt_ak > 0), (integer)((integer)tot_cnt_am > 0), (integer)((integer)tot_cnt_ar > 0), (integer)((integer)tot_cnt_ba > 0), (integer)((integer)tot_cnt_cg > 0), (integer)((integer)tot_cnt_co > 0), (integer)((integer)tot_cnt_cy > 0), (integer)((integer)tot_cnt_da > 0), (integer)((integer)tot_cnt_d > 0), (integer)((integer)tot_cnt_dl > 0), (integer)((integer)tot_cnt_ds > 0), (integer)((integer)tot_cnt_de > 0), (integer)((integer)tot_cnt_eb > 0), (integer)((integer)tot_cnt_em > 0), (integer)((integer)tot_cnt_en > 0), (integer)((integer)tot_cnt_eq > 0), (integer)((integer)tot_cnt_fe > 0), (integer)((integer)tot_cnt_ff > 0), (integer)((integer)tot_cnt_fr > 0), (integer)((integer)tot_cnt_l2 > 0), (integer)((integer)tot_cnt_li > 0), (integer)((integer)tot_cnt_mw > 0), (integer)((integer)tot_cnt_nt > 0), (integer)((integer)tot_cnt_p > 0), (integer)((integer)tot_cnt_pl > 0), (integer)((integer)tot_cnt_ts > 0), (integer)((integer)tot_cnt_tu > 0), (integer)((integer)tot_cnt_sl > 0), (integer)((integer)tot_cnt_v > 0), (integer)((integer)tot_cnt_vo > 0), (integer)((integer)tot_cnt_w > 0), (integer)((integer)tot_cnt_wp > 0))
			;

		email_im_pos := models.common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		email_cnt_im := if(email_im_pos > 0, (real)models.common.getw(email_source_count, email_im_pos), 0);

		max_email := max(email_domain_free_count, email_domain_isp_count, email_domain_edu_count, email_domain_corp_count);

		email_cnt_im_ind := min(if(email_cnt_im = NULL, -NULL, email_cnt_im), 1);

		email_domain_edu_ind := min(if(email_domain_edu_count = NULL, -NULL, email_domain_edu_count), 1);

		email_domain_corp_ind := min(if(email_domain_corp_count = NULL, -NULL, email_domain_corp_count), 1);

		paw_business_ind := min(if(PAW_Business_count = NULL, -NULL, PAW_Business_count), 1);

		paw_dead_business_ind := min(if(PAW_Dead_business_count = NULL, -NULL, PAW_Dead_business_count), 1);

		paw_active_phone_ind := min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 1);

		inq_noncoll_count01 := inq_count01 - inq_collection_count01;

		inq_noncoll_count03 := inq_count03 - inq_collection_count03;

		inq_noncoll_count06 := inq_count06 - inq_collection_count06;

		inq_noncoll_count12 := inq_count12 - inq_collection_count12;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'L2', ',') > 0;

		source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'LI', ',') > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'DS', ',') > 0;

		source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'BA', ',') > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

		pk_impulse_count_1 := impulse_count;

		pk_impulse_count := if(pk_impulse_count_1 > 2, 2, pk_impulse_count_1);

		bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

		bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

		prop_owner := add1_naprop = 4 or property_owned_total > 0;

		segment_d := bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag > 0 or (integer)ssn_deceased > 0;

		segment_y := not(segment_d) and est_age <= 27;

		segment_o := not(segment_d or segment_y) and prop_owner;

		segment_x := not(segment_d or segment_y or segment_o);

		d_vo_addr_ver := tot_nas_vo = 8;

		d_wp_addr_ver := (tot_nas_wp in [3, 5, 8]);

		d_p_addr_ver_summary_m := map(
			tot_nas_p = 0 => 14.66,
			tot_nas_p < 8 => 10.70,
							 9.16);

		d_em_addr_ver_summary_m := map(
			tot_nas_em = 0 => 11.98,
			tot_nas_em < 8 => 12.33,
							  7.82);

		d_eq_nas_ver := tot_nas_eq > 9;

		d_ts_nas_ver := tot_nas_ts >= 9;

		// d_tot_mosince_fdate_eq_480 := min(if(tot_mosince_fdate_eq = NULL, -NULL, tot_mosince_fdate_eq), 480);
		// d_tot_mosince_fdate_eq_480 := if(tot_mosince_fdate_eq = NULL, 120, min(tot_mosince_fdate_eq, 480));
		d_tot_mosince_fdate_eq_480 := if(tot_mosince_fdate_eq = NULL, 480, min(tot_mosince_fdate_eq, 480));

		d_adls_per_addr_c6_4 := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 4);

		d_phones_per_addr_10 := min(if(phones_per_addr = NULL, -NULL, phones_per_addr), 10);

		d_addrs_per_ssn_25 := min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 25);

		d_addrs_per_ssn_c6_2 := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

		d_ssns_per_adl_5 := min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 5);

		d_ssns_per_adl_c6_2 := min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 2);

		// d_time_since_ssnlowissue_876 := if(time_since_ssnlowissue = NULL, 877, min(if(time_since_ssnlowissue = NULL, -NULL, time_since_ssnlowissue), 876));
		d_time_since_ssnlowissue_876 := if(time_since_ssnlowissue = NULL, 877, min(time_since_ssnlowissue, 876));

		d_lo_combo_ssnscore := combo_ssnscore < 100;

		d_ssn_mod := -1.737588599 +
			d_ssns_per_adl_c6_2 * 0.1431617449 +
			d_ssns_per_adl_5 * 0.1907374241 +
			(integer)d_lo_combo_ssnscore * 0.3572441521 +
			d_time_since_ssnlowissue_876 * -0.00161749;

		d_time_on_gong_120 := if(time_on_gong = NULL, 22, min(time_on_gong, 120));

		d_rc_disthphoneaddr_200 := min(if(rc_disthphoneaddr = NULL, -NULL, rc_disthphoneaddr), 200);

		d_contrary_infutor_nap := infutor_nap = 1;

		d_pnotpots := telcordia_type != '00';

		d_hm_disconnected_phone := rc_hriskphoneflag = (string)5;

		d_gong_did_phone_ct_6 := min(if(gong_did_phone_ct = NULL, -NULL, gong_did_phone_ct), 6);

		d_hi_gong_did_last_ct := gong_did_last_ct >= 2;

		d_phoneprob_mod := -2.34738927 +
			(integer)d_contrary_infutor_nap * 0.1679675264 +
			(integer)d_hm_disconnected_phone * 0.4598819433 +
			(integer)d_pnotpots * 0.3854004928 +
			d_rc_disthphoneaddr_200 * 0.0008656986 +
			d_gong_did_phone_ct_6 * 0.0419115882 +
			(integer)d_hi_gong_did_last_ct * 0.1921710253;

		d_verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

		d_verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		d_dob_ver_m := map(
			combo_dobscore < 100 => 14.62,
			combo_dobscore = 100 => 11.47,
									19.00);

		d_lo_source_ct := tot_source_ct <= 2;

		d_ver_mod := -1.91419624 +
			(integer)d_lo_source_ct * 0.1273191366 +
			(integer)add1_isbestmatch * -0.085303987 +
			(integer)d_wp_addr_ver * -0.111737504 +
			(integer)d_eq_nas_ver * -0.270944173 +
			(integer)d_ts_nas_ver * -0.169875384 +
			(integer)d_vo_addr_ver * -0.202934578 +
			d_p_addr_ver_summary_m * 0.0543641608 +
			d_em_addr_ver_summary_m * 0.0793616838 +
			(integer)d_verfst_p * -0.097647854 +
			(integer)d_verphn_p * -0.24470968 +
			d_dob_ver_m * 0.0351999471 +
			d_ssn_mod * 0.7897374636;

		d_nodob_ver_mod := -1.448689607 +
			(integer)d_lo_source_ct * 0.1780181412 +
			(integer)add1_isbestmatch * -0.086335406 +
			(integer)d_wp_addr_ver * -0.109943598 +
			(integer)d_eq_nas_ver * -0.27407115 +
			(integer)d_ts_nas_ver * -0.177240955 +
			(integer)d_vo_addr_ver * -0.212285317 +
			d_p_addr_ver_summary_m * 0.0549556897 +
			d_em_addr_ver_summary_m * 0.0794209704 +
			(integer)d_verfst_p * -0.100415632 +
			(integer)d_verphn_p * -0.245381614 +
			d_ssn_mod * 0.8122684917;

		d_mosince_inq_last_log_12_1 := if(NULL < mosince_inq_last_log AND mosince_inq_last_log > 12, 20, mosince_inq_last_log);

		// d_mosince_inq_last_log_12 := if(mosince_inq_last_log = NULL, 20, d_mosince_inq_last_log_12_1);
		d_mosince_inq_last_log_12 := map(
			mosince_inq_last_log = NULL => 20,
			mosince_inq_last_log > 20   => 20,
			mosince_inq_last_log
		);


		d_inq_noncoll_count_3 := min(if(inq_noncoll_count12 = NULL, -NULL, inq_noncoll_count12), 3);

		d_inq_noncoll_summary_m := map(
			inq_noncoll_count01 > 0 => 27.57,
			inq_noncoll_count03 > 0 => 24.47,
			inq_noncoll_count06 > 0 => 24.40,
			inq_noncoll_count12 > 0 => 18.55,
									   10.83);

		d_add1_financing_type_m := map(
			add1_financing_type = 'ADJ' => 12.91,
			add1_financing_type = 'CNV' => 10.61,
										   11.89);

		d_addrs_15yr_20 := min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 20);

		// d_mosince_criminal_ls_84 := if(mosince_criminal_ls != NULL, min(if(mosince_criminal_ls = NULL, -NULL, mosince_criminal_ls), 84), 90);
		// if mosince_criminal_ls ^= . then d_mosince_criminal_ls_84 = min(mosince_criminal_ls,84);
		// else d_mosince_criminal_ls_84 = 90;
		d_mosince_criminal_ls_84 := if( mosince_criminal_ls != NULL, min(mosince_criminal_ls,84), 90 );



		// d_mosince_liens_unrel_ls_84 := if(mosince_liens_unrel_ls != NULL, min(if(mosince_liens_unrel_ls = NULL, -NULL, mosince_liens_unrel_ls), 84), 90);
		d_mosince_liens_unrel_ls_84 := if(mosince_liens_unrel_ls != NULL, min(mosince_liens_unrel_ls, 84), 90);

		d_mosince_eviction_ls_84 := if(mosince_eviction_ls != NULL, min(mosince_eviction_ls, 84), 90);

		// d_tot_mosince_ldate_l2_240 := if( tot_mosince_ldate_l2 = NULL, 144, min( tot_mosince_ldate_l2, 240 ) );
		// per heather (may 10, 2011), the model incorrectly ignored the first calculation, so nulls became 240. it's too late to fix this, so we're going with 240 instead of 144.
		d_tot_mosince_ldate_l2_240 := if( tot_mosince_ldate_l2 = NULL, 240, min( tot_mosince_ldate_l2, 240 ) );

		d_bk_dismissed := StringLib.StringToUpperCase(disposition)[1..7] = 'DISMISS';

		d_hi_filing_ct := filing_count > 1;

		d_bad_bk := bankrupt and (d_hi_filing_ct or d_bk_dismissed);

		d_liens_unrel_sc_total_amt_10k := min(if(liens_unrel_SC_total_amount = NULL, -NULL, liens_unrel_SC_total_amount), 10000);

		d_liens_recent_unrel_ct_4 := min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 4);

		d_hi_email_ct := email_count >= 7;

		d_email_summary_m := map(
			(boolean)email_cnt_im_ind or max_email = email_domain_free_count and d_hi_email_ct => 26.3,
			email_domain_edu_ind > 0                                                           => 7.23,
			email_domain_corp_ind > 0                                                          => 10.53,
			email_count != 0 and max_email = email_domain_free_count                           => 12.10,
			email_count != 0 and max_email = email_domain_isp_count                            => 10.75,
																								  12.05);

		d_paw_summary_m := map(
			(boolean)paw_dead_business_ind and not((boolean)paw_active_phone_ind)      => 13.24,
			not((boolean)paw_business_ind)                                             => 12.01,
			not((boolean)paw_dead_business_ind) and not((boolean)paw_active_phone_ind) => 10.92,
																						  4.19);

		d_prof_license_category_m := map(
			prof_license_category = (string)0 => 13.93,
			prof_license_category = (string)1 => 12.14,
			prof_license_category = (string)2 => 11.33,
			prof_license_category = (string)3 => 11.66,
			prof_license_category = (string)4 => 9.24,
			prof_license_category = (string)5 => 3.55,
												 12.08);

		d_ams_income_summary := map(
			ams_income_level_code = ''   => 0,
			ams_income_level_code <= 'C' => 1,
			ams_income_level_code <= 'G' => 2,
											3);

		d_ams_income_college_m := map(
			d_ams_income_summary = 0                                                                                                   => 11.92,
			(ams_college_code in ['', '2']) and d_ams_income_summary = 1                                                               => 16.12,
			ams_college_code = '' and d_ams_income_summary = 2                                                               => 14.60,
			ams_college_code = '' and d_ams_income_summary = 3                                                               => 12.58,
			ams_college_code = '2' and d_ams_income_summary = 2 or (ams_college_code in ['1', '4']) and d_ams_income_summary = 1 => 11.30,
																																		  8.22);

		d_wealth_index_m := map(
			wealth_index = (string)0 => 13.01,
			wealth_index = (string)1 => 17.24,
			wealth_index = (string)2 => 13.02,
			wealth_index = (string)3 => 11.33,
			wealth_index = (string)4 => 10.94,
			wealth_index = (string)5 => 10.09,
										8.65);

		d_outest_dob := -4.544427698 +
			estimated_income * -1.895736E-6 +
			d_wealth_index_m * 0.0387436787 +
			d_ams_income_college_m * 0.0545014455 +
			d_ver_mod * 0.4702449445 +
			d_time_on_gong_120 * -0.002166893 +
			d_phoneprob_mod * 0.311974063 +
			d_prof_license_category_m * 0.0778742567 +
			d_email_summary_m * 0.04321931 +
			d_paw_summary_m * 0.0928308749 +
			d_mosince_inq_last_log_12 * -0.021519955 +
			d_inq_noncoll_count_3 * 0.1870454194 +
			d_add1_financing_type_m * 0.1429420066 +
			d_addrs_15yr_20 * 0.0302829445 +
			d_mosince_criminal_ls_84 * -0.006688162 +
			(integer)d_bad_bk * 0.3775276643 +
			d_mosince_liens_unrel_ls_84 * -0.001491068 +
			d_mosince_eviction_ls_84 * -0.004058287 +
			d_liens_unrel_sc_total_amt_10k * 0.000052305 +
			d_tot_mosince_ldate_l2_240 * -0.000549226 +
			d_tot_mosince_fdate_eq_480 * -0.000693568 +
			d_addrs_per_ssn_25 * 0.0166414488 +
			d_addrs_per_ssn_c6_2 * 0.2831768645 +
			d_phones_per_addr_10 * 0.0210681989 +
			d_adls_per_addr_c6_4 * 0.1320538636;

		d_outest_nodob := -5.34310788 +
			estimated_income * -1.849732E-6 +
			d_wealth_index_m * 0.0400566953 +
			d_ams_income_college_m * 0.0529911449 +
			d_prof_license_category_m * 0.0788099585 +
			d_email_summary_m * 0.0426121535 +
			d_paw_summary_m * 0.0926772124 +
			d_nodob_ver_mod * 0.4483447056 +
			d_time_on_gong_120 * -0.002256723 +
			d_phoneprob_mod * 0.3210823422 +
			d_inq_noncoll_summary_m * 0.0268121239 +
			d_inq_noncoll_count_3 * 0.1953453786 +
			d_add1_financing_type_m * 0.1421143861 +
			d_addrs_15yr_20 * 0.0295903602 +
			d_mosince_criminal_ls_84 * -0.00675395 +
			(integer)d_bad_bk * 0.3746171573 +
			d_mosince_eviction_ls_84 * -0.003976705 +
			d_liens_recent_unrel_ct_4 * 0.0650641728 +
			d_liens_unrel_sc_total_amt_10k * 0.0000532139 +
			d_tot_mosince_ldate_l2_240 * -0.000711789 +
			d_tot_mosince_fdate_eq_480 * -0.000822914 +
			d_addrs_per_ssn_25 * 0.0167359671 +
			d_addrs_per_ssn_c6_2 * 0.2833683937 +
			d_phones_per_addr_10 * 0.0212861802 +
			d_adls_per_addr_c6_4 * 0.1333920916;

		d_outest := (integer)dobpop * d_outest_dob + (1 - (integer)dobpop) * d_outest_nodob;

		y_eq_nas_ver := tot_nas_eq > 9;

		y_ts_nas_ver := tot_nas_ts >= 9;

		y_vo_addr_ver := tot_nas_vo = 8;

		y_time_on_eq_gt_age := (est_age - 17) > truncate(time_on_eq / 12);

		y_time_on_eq_120 := map(
			time_on_eq = NULL   => 108,
			y_time_on_eq_gt_age => time_on_eq,
								30);

		y_ssns_per_adl_gt1 := ssns_per_adl > 1;

		y_adlperssn_count_1_3 := max(min(if(adlperssn_count = NULL, -NULL, adlperssn_count), 3), 1);

		y_addrs_per_ssn_c6_2 := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

		y_ssns_per_addr_50 := min(if(ssns_per_addr = NULL, -NULL, ssns_per_addr), 50);

		y_ssns_per_addr_c6_5 := min(if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6), 5);

		y_hm_rc_numelever := //if(max((integer)combo_fnamecount > 0, (integer)combo_lnamecount > 0, (integer)combo_addrcount > 0, (integer)combo_hphonecount > 0, (integer)combo_ssncount > 0, (integer)combo_dobcount > 0) = NULL, NULL,
			sum((integer)((integer)combo_fnamecount > 0), (integer)((integer)combo_lnamecount > 0), (integer)((integer)combo_addrcount > 0), (integer)((integer)combo_hphonecount > 0), (integer)((integer)combo_ssncount > 0), (integer)((integer)combo_dobcount > 0))
			;

		y_hm_rc_numelever_3_6 := min(if(max(y_hm_rc_numelever, 3) = NULL, -NULL, max(y_hm_rc_numelever, 3)), 6);

		y_did_ge2 := did_count > 1;

		y_dob_ver := combo_dobscore = 100;

		y_verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

		y_verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		y_ver_mod := -1.166169665 +
			(integer)add1_isbestmatch * -0.230980438 +
			y_hm_rc_numelever_3_6 * -0.091217941 +
			(integer)y_dob_ver * -0.344702845 +
			(integer)y_verlst_p * -0.123934361 +
			(integer)y_verphn_p * -0.169932876 +
			(integer)y_vo_addr_ver * -0.216900899 +
			(integer)y_ts_nas_ver * -0.198586897;

		y_ver_nodob_mod := -1.642703101 +
			(integer)y_did_ge2 * 0.5852075016 +
			(integer)add1_isbestmatch * -0.201136178 +
			(integer)y_verlst_p * -0.144136351 +
			(integer)y_verphn_p * -0.234684655 +
			(integer)y_vo_addr_ver * -0.367099627 +
			(integer)y_eq_nas_ver * -0.141605682 +
			(integer)y_ts_nas_ver * -0.338330765;

		y_mosince_gong_did_ls_108 := if(mosince_gong_did_ls = NULL, 25, min(if(mosince_gong_did_ls = NULL, -NULL, mosince_gong_did_ls), 108));

		y_no_adls_per_phone := adls_per_phone = 0;

		y_hm_disconnected_phone := rc_hriskphoneflag = (string)5 or nap_status = 'D';

		y_lo_infutor_nap := infutor_nap <= 6;

		y_phoneprob_mod := -2.480066785 +
			(integer)y_no_adls_per_phone * 0.2805338406 +
			(integer)y_hm_disconnected_phone * 0.5249207844 +
			(integer)y_lo_infutor_nap * 0.3067209049;

		// y_est_age_18 := max(est_age, (real)18);
		y_est_age_18 := min(max(est_age, (real)18), 62);

		// y_wealth_index_1_4 := max(min(if(wealth_index = NULL, -NULL, wealth_index), 4), 1);
		y_wealth_index_1_4 := if( wealth_index='', NULL, max(min((integer)wealth_index, 4), 1));

		y_wealth_index_m := map(
			y_wealth_index_1_4 = 1 => 12.77,
			y_wealth_index_1_4 = 2 => 10.60,
			y_wealth_index_1_4 = 3 => 10.85,
									  9.49);

		y_hi_prof_license_category := prof_license_category >= (string)4;

		y_ams_income_summary := map(
			ams_income_level_code <= 'C' => 1,
			ams_income_level_code = 'D'  => 2,
			ams_income_level_code <= 'F' => 3,
			ams_income_level_code <= 'I' => 4,
											5);

		y_ams_college_summary := map(
			ams_college_code='' => null,
			ams_college_code = '1' => 4,
			(integer)ams_college_code
		);

		y_ams_income_college_m := map(
			y_ams_income_summary <= 2 and y_ams_college_summary = NULL                                                                                                                      => 13.59,
			y_ams_income_summary = 3 and y_ams_college_summary = NULL                                                                                                                       => 12.72,
			y_ams_income_summary = 4 and y_ams_college_summary = NULL or y_ams_income_summary <= 2 and y_ams_college_summary = 2 or y_ams_income_summary <= 1 and y_ams_college_summary = 4 => 10.55,
			y_ams_income_summary = 5 and y_ams_college_summary = NULL or y_ams_college_summary = 2                                                                                          => 7.55,
																																															   4.37);

		y_hi_email_ct := email_count >= 5;

		y_email_summary_m := map(
			(boolean)email_cnt_im_ind or max_email = email_domain_free_count and y_hi_email_ct => 20.13,
			email_domain_edu_ind > 0                                                           => 4.26,
			email_domain_corp_ind > 0                                                          => 8.70,
			email_count != 0 and max_email = email_domain_free_count                           => 12.00,
			email_count != 0 and max_email = email_domain_isp_count                            => 10.82,
																								  11.83);

		y_paw_summary_m := map(
			not((boolean)paw_business_ind or (boolean)paw_dead_business_ind)  => 11.63,
			(boolean)paw_business_ind and not((boolean)paw_dead_business_ind) => 12.95,
																				 19.85);

		y_inq_addrsperadl_2 := min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 2);

		y_inq_adlsperphone_2 := min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 2);

		y_hr_add1_financing_type := (add1_financing_type in ['ADJ', 'OTH']);

		// y_avg_mo_per_addr_60 := min(if(avg_mo_per_addr = NULL, -NULL, avg_mo_per_addr), 60);
		y_avg_mo_per_addr_60 := map(
			avg_mo_per_addr = -9999 => 0,
			avg_mo_per_addr = NULL => 60,
			min(avg_mo_per_addr, 60)
		);

		y_addr_vacant_summary_m := map(
			not(add1_vacant_address or add2_vacant_address) => 11.57,
			add1_vacant_address                             => 20.59,
															   13.21);

		y_add1_ownership_m := map(
			not(add1_applicant_owned) and not(add1_occupant_owned or add1_family_owned)  => 12.66,
			not(add1_applicant_owned) and add1_occupant_owned and not(add1_family_owned) => 14.52,
			add1_applicant_owned and not(add1_family_owned)                              => 10.83,
																							8.38);

		y_lo_addr_score := combo_addrscore <= 90;

		y_hm_invalid_addr := (rc_addrvalflag in ['M', 'N']) or (boolean)(integer)rc_statezipflag;

		y_old_addr_match_input := hist_addr_match_n >= 4;

		y_no_addr_match_input := hist_addr_match_n = 0;

		y_addr_prob_summary := map(
			not(rc_addrmiskeyflag or y_no_addr_match_input or y_old_addr_match_input or y_hm_invalid_addr or y_lo_addr_score) => 0,
			not(rc_addrmiskeyflag) and (y_no_addr_match_input or y_old_addr_match_input)                                      => 1,
																																 2);

		y_addr_prob_summary_m := map(
			y_addr_prob_summary = 0 => 10.42,
			y_addr_prob_summary = 1 => 14.52,
									   12.86);

		y_outest_nodob := -5.378340432 +
			y_wealth_index_m * 0.0488356425 +
			y_ams_income_college_m * 0.1046594963 +
			(integer)y_hi_prof_license_category * -0.758635382 +
			y_ver_nodob_mod * 0.534884249 +
			y_mosince_gong_did_ls_108 * -0.003005208 +
			y_phoneprob_mod * 0.5084712415 +
			y_email_summary_m * 0.0792733804 +
			y_paw_summary_m * 0.0993488552 +
			y_inq_addrsperadl_2 * 0.5599936105 +
			y_inq_adlsperphone_2 * 0.2132491432 +
			(integer)y_hr_add1_financing_type * 0.1978811036 +
			y_avg_mo_per_addr_60 * -0.005383868 +
			y_addr_vacant_summary_m * 0.0626663079 +
			y_add1_ownership_m * 0.0347306603 +
			(integer)y_ssns_per_adl_gt1 * 0.234288396 +
			y_adlperssn_count_1_3 * 0.1517401144 +
			y_addrs_per_ssn_c6_2 * 0.2155041283 +
			y_ssns_per_addr_50 * 0.0097417354 +
			y_ssns_per_addr_c6_5 * 0.0922638762;

		y_outest_dob := -4.744937059 +
			y_ams_income_college_m * 0.0954526084 +
			y_est_age_18 * -0.038613902 +
			y_ver_mod * 0.3270662756 +
			y_phoneprob_mod * 0.5561415633 +
			y_email_summary_m * 0.0775111778 +
			y_paw_summary_m * 0.1129396108 +
			y_inq_addrsperadl_2 * 0.5121144948 +
			y_inq_adlsperphone_2 * 0.1984784945 +
			y_addr_vacant_summary_m * 0.0658669793 +
			y_addr_prob_summary_m * 0.033844887 +
			y_add1_ownership_m * 0.0422248561 +
			y_time_on_eq_120 * -0.005193519 +
			(integer)y_ssns_per_adl_gt1 * 0.2787132173 +
			y_adlperssn_count_1_3 * 0.1675343918 +
			y_addrs_per_ssn_c6_2 * 0.2021892296 +
			y_ssns_per_addr_50 * 0.0099137516 +
			y_ssns_per_addr_c6_5 * 0.0907686215;

		y_outest := (integer)dobpop * y_outest_dob + (1 - (integer)dobpop) * y_outest_nodob;

		o_hm_rc_numelever := //if(
			// max((integer)combo_fnamecount > 0, (integer)combo_lnamecount > 0, (integer)combo_addrcount > 0, (integer)combo_hphonecount > 0, (integer)combo_ssncount > 0, (integer)combo_dobcount > 0) = NULL, NULL,
			sum((integer)((integer)combo_fnamecount > 0), (integer)((integer)combo_lnamecount > 0), (integer)((integer)combo_addrcount > 0), (integer)((integer)combo_hphonecount > 0), (integer)((integer)combo_ssncount > 0), (integer)((integer)combo_dobcount > 0));

		o_hm_rc_numelever_4_6 := min(max(o_hm_rc_numelever, 4), 6);

		o_hm_rc_numelever_nodob := //if(max((integer)combo_fnamecount > 0, (integer)combo_lnamecount > 0, (integer)combo_addrcount > 0, (integer)combo_hphonecount > 0, (integer)combo_ssncount > 0) = NULL, NULL,
		sum((integer)((integer)combo_fnamecount > 0), (integer)((integer)combo_lnamecount > 0), (integer)((integer)combo_addrcount > 0), (integer)((integer)combo_hphonecount > 0), (integer)((integer)combo_ssncount > 0));

		o_hm_rc_numelever_nodob_3_5 := min(if(max(o_hm_rc_numelever_nodob, 3) = NULL, -NULL, max(o_hm_rc_numelever_nodob, 3)), 5);

		o_lname_ver := 100 <= combo_lnamescore;

		o_dob_ver := combo_dobscore = 100;

		o_infutor_ver := infutor_nap >= 9;

		o_verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

		o_verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		o_vo_addr_ver := tot_nas_vo = 8;

		o_wp_addr_ver := (tot_nas_wp in [3, 5, 8]);

		o_ts_nas_ver := tot_nas_ts >= 9;

		o_did_ge2 := did_count > 1;

		o_ver_mod := -0.513249974 +
			o_hm_rc_numelever_4_6 * -0.232325499 +
			(integer)o_lname_ver * -0.240113233 +
			(integer)o_dob_ver * -0.33826521 +
			(integer)add1_isbestmatch * -0.25513914 +
			(integer)o_infutor_ver * 0.1629795591 +
			(integer)o_verfst_p * -0.170968756 +
			(integer)o_verphn_p * -0.295602632 +
			(integer)o_wp_addr_ver * -0.263400402 +
			(integer)o_ts_nas_ver * -0.362990667 +
			(integer)o_vo_addr_ver * -0.396098999;

		o_ver_nodob_mod := -1.293461655 +
			(integer)o_did_ge2 * 0.3315571524 +
			o_hm_rc_numelever_nodob_3_5 * -0.132275705 +
			(integer)o_lname_ver * -0.294143204 +
			(integer)add1_isbestmatch * -0.281515133 +
			(integer)o_infutor_ver * 0.1544651258 +
			(integer)o_verfst_p * -0.180459647 +
			(integer)o_verphn_p * -0.396321634 +
			(integer)o_wp_addr_ver * -0.287653937 +
			(integer)o_ts_nas_ver * -0.413638696 +
			(integer)o_vo_addr_ver * -0.45200191;

		o_tot_source_ct_2_7 := min(if(max(tot_source_ct, 2) = NULL, -NULL, max(tot_source_ct, 2)), 7);

		// o_tot_mosince_fdate_eq_360 := if( tot_mosince_fdate_eq=NULL, 204, min(tot_mosince_fdate_eq, 360));
		o_tot_mosince_fdate_eq_360 := if( tot_mosince_fdate_eq=NULL, 360, min(tot_mosince_fdate_eq, 360));

		o_mosince_gong_did_ls_110 := if(mosince_gong_did_ls = NULL, 48, min(mosince_gong_did_ls, 110));

		o_no_adls_per_phone := adls_per_phone = 0;

		o_hm_disconnected_phone := rc_hriskphoneflag = (string)5 or nap_status = 'D';

		o_pnotpots := telcordia_type != '00';

		o_no_gong_did_addr := gong_did_addr_ct = 0;

		o_lo_infutor_nap := 0 < infutor_nap AND infutor_nap <= 10;

		o_hi_gong_did_last_ct := gong_did_last_ct >= 3;

		o_phoneprob_mod := -3.51655798 +
			(integer)o_no_adls_per_phone * 0.3104468132 +
			(integer)o_hm_disconnected_phone * 0.6364231704 +
			(integer)o_pnotpots * 0.603437617 +
			(integer)o_no_gong_did_addr * 0.174602857 +
			(integer)o_lo_infutor_nap * 0.2781418006 +
			(integer)o_hi_gong_did_last_ct * 0.7196723547;

		o_invalid_ssns_per_adl_ind := min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 1);

		o_invalid_ssn := rc_ssnvalflag = (string)1;

		o_lo_combo_ssnscore := combo_ssnscore < 90;

		o_invalid_ssns_flag := (boolean)o_invalid_ssns_per_adl_ind or o_invalid_ssn or o_lo_combo_ssnscore or rc_ssndobflag = (string)1;

		o_ssn_issued_too_young_or_hi := age_at_ssnlowissue < -7 or age_at_ssnlowissue >= 21;

		o_ssns_per_adl_gt2 := ssns_per_adl > 2;

		o_ssns_per_adl_c6_2 := min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 2);

		o_time_since_ssnlowissue_480 := if(time_since_ssnlowissue = NULL, 276, min(time_since_ssnlowissue, 480));

		o_ssn_mod := -1.805737443 +
			(integer)o_invalid_ssns_flag * 0.7088359702 +
			(integer)o_ssn_issued_too_young_or_hi * 0.1548022748 +
			o_ssns_per_adl_c6_2 * 0.1579391596 +
			(integer)o_ssns_per_adl_gt2 * 0.5571488369 +
			o_time_since_ssnlowissue_480 * -0.003684632;

		o_ssn_mod_nodob := -1.664590523 +
			(integer)o_invalid_ssns_flag * 0.7317174087 +
			o_ssns_per_adl_c6_2 * 0.1537287895 +
			(integer)o_ssns_per_adl_gt2 * 0.5653672629 +
			o_time_since_ssnlowissue_480 * -0.004005483;

		o_estimated_income_200k := min(if(estimated_income = NULL, -NULL, estimated_income), 200000);

		o_wealth_index_5 := if( wealth_index='', NULL, min((integer)wealth_index, 5));

		o_wealth_index_m := map(
			o_wealth_index_5 = 0 => 5.04,
			o_wealth_index_5 = 2 => 7.36,
			o_wealth_index_5 = 3 => 5.59,
			o_wealth_index_5 = 4 => 4.27,
			o_wealth_index_5 = 5 => 3.94,
									5.04);

		o_ams_income_summary := map(
			ams_income_level_code = ''   => 0,
			ams_income_level_code <= 'D' => 1,
			ams_income_level_code <= 'G' => 2,
			ams_income_level_code <= 'J' => 3,
											4);

		o_ams_college_summary := map(
			ams_college_code = '' => NULL,
			ams_college_code = '1' => 4,
			(integer)ams_college_code
		);

		o_ams_income_college_m := map(
			o_ams_income_summary = 0                                                               => 4.66,
			o_ams_income_summary = 1 and o_ams_college_summary < 4                                 => 9.78,
			o_ams_income_summary = 2 and o_ams_college_summary = NULL                              => 6.94,
			o_ams_college_summary = NULL or o_ams_income_summary = 2 and o_ams_college_summary = 2 => 4.84,
			o_ams_college_summary = 2 or o_ams_income_summary <= 2 and o_ams_college_summary = 4   => 3.53,
																									  1.62);

		o_prof_license_cat_m := map(
			prof_license_category = (string)1 => 6.76,
			prof_license_category = (string)2 => 5.31,
			prof_license_category = (string)3 => 5.42,
			prof_license_category = (string)4 => 3.32,
			prof_license_category = (string)5 => 1.12,
												 4.75);

		o_hi_email_ct := email_count >= 5;

		o_email_summary_m := map(
			(boolean)email_cnt_im_ind or max_email = email_domain_free_count and o_hi_email_ct => 8.46,
			email_count != 0                                                                   => 4.04,
																								  4.86);

		o_paw_summary_m := map(
			not((boolean)paw_business_ind or (boolean)paw_dead_business_ind)  => 4.43,
			(boolean)paw_active_phone_ind                                              => 3.06,
			(boolean)paw_business_ind and not((boolean)paw_dead_business_ind) => 5.23,
																				 7.22);

		o_inq_count12_2 := min(if(inq_count12 = NULL, -NULL, inq_count12), 2);

		o_inq_ssnsperaddr_2 := min(if(Inq_SSNsPerAddr = NULL, -NULL, Inq_SSNsPerAddr), 2);

		o_inq_adlsperphone_2 := min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 2);

		o_hr_add1_financing_type := (add1_financing_type in ['ADJ', 'OTH']);

		o_no_adls_per_addr := adls_per_addr = 0;

		o_no_addr_match_input := hist_addr_match_n = 0;

		o_lo_addr_score := combo_addrscore <= 90 or combo_addrscore = 255;

		o_addr_vacant_summary_m := map(
			not(add1_vacant_address or add2_vacant_address) => 4.55,
			add1_vacant_address                             => 16.64,
															   5.83);

		o_addrprob_mod := -3.719662179 +
			(integer)o_no_addr_match_input * 0.4427210017 +
			(integer)o_lo_addr_score * 0.2381299541 +
			(integer)rc_input_addr_not_most_recent * 0.2812548425 +
			o_addr_vacant_summary_m * 0.1182332106 +
			(integer)o_no_adls_per_addr * 0.1954345038;

		o_attr_addrs_last36_6 := min(if(attr_addrs_last36 = NULL, -NULL, attr_addrs_last36), 6);

		o_add1_price_per_sqf := if(add1_purchase_amount > 0 and (integer)add1_building_area > 0, round(add1_purchase_amount / (real)add1_building_area), NULL);

		o_add1_price_per_sqf_300 := if(o_add1_price_per_sqf != NULL, min(if(o_add1_price_per_sqf = NULL, -NULL, o_add1_price_per_sqf), 300), 180);

		o_avg_add1_avm_val_300k_1 := round(min(if(if(max(add1_avm_automated_valuation, add1_avm_automated_valuation_2, add1_avm_automated_valuation_3, add1_avm_automated_valuation_4, add1_avm_automated_valuation_5) = NULL, NULL, (if(max(add1_avm_automated_valuation, add1_avm_automated_valuation_2, add1_avm_automated_valuation_3, add1_avm_automated_valuation_4, add1_avm_automated_valuation_5) = NULL, NULL, SUM(if(add1_avm_automated_valuation = NULL, 0, add1_avm_automated_valuation), if(add1_avm_automated_valuation_2 = NULL, 0, add1_avm_automated_valuation_2), if(add1_avm_automated_valuation_3 = NULL, 0, add1_avm_automated_valuation_3), if(add1_avm_automated_valuation_4 = NULL, 0, add1_avm_automated_valuation_4), if(add1_avm_automated_valuation_5 = NULL, 0, add1_avm_automated_valuation_5)))/sum(if(add1_avm_automated_valuation = NULL, 0, 1), if(add1_avm_automated_valuation_2 = NULL, 0, 1), if(add1_avm_automated_valuation_3 = NULL, 0, 1), if(add1_avm_automated_valuation_4 = NULL, 0, 1), if(add1_avm_automated_valuation_5 = NULL, 0, 1)))) / 1000 = NULL, -NULL, if(max(add1_avm_automated_valuation, add1_avm_automated_valuation_2, add1_avm_automated_valuation_3, add1_avm_automated_valuation_4, add1_avm_automated_valuation_5) = NULL, NULL, (if(max(add1_avm_automated_valuation, add1_avm_automated_valuation_2, add1_avm_automated_valuation_3, add1_avm_automated_valuation_4, add1_avm_automated_valuation_5) = NULL, NULL, SUM(if(add1_avm_automated_valuation = NULL, 0, add1_avm_automated_valuation), if(add1_avm_automated_valuation_2 = NULL, 0, add1_avm_automated_valuation_2), if(add1_avm_automated_valuation_3 = NULL, 0, add1_avm_automated_valuation_3), if(add1_avm_automated_valuation_4 = NULL, 0, add1_avm_automated_valuation_4), if(add1_avm_automated_valuation_5 = NULL, 0, add1_avm_automated_valuation_5)))/sum(if(add1_avm_automated_valuation = NULL, 0, 1), if(add1_avm_automated_valuation_2 = NULL, 0, 1), if(add1_avm_automated_valuation_3 = NULL, 0, 1), if(add1_avm_automated_valuation_4 = NULL, 0, 1), if(add1_avm_automated_valuation_5 = NULL, 0, 1)))) / 1000), 300));

		o_avg_add1_avm_val_300k := if(o_avg_add1_avm_val_300k_1 = 0, 72, o_avg_add1_avm_val_300k_1);

		o_add1_ownership_m := map(
			not(add1_applicant_owned) and not(add1_family_owned) and add1_occupant_owned => 7.63,
			not(add1_applicant_owned)                                                    => 6.73,
			add1_applicant_owned and not(add1_family_owned)                              => 5.71,
																							3.40);

		o_address_recency := map(
			attr_addrs_last12 > 0 => 'm12',
			attr_addrs_last24 > 0 => 'm24',
			attr_addrs_last36 > 0 => 'm36',
			addrs_5yr > 0         => 'y05',
			addrs_10yr > 0        => 'y10',
			addrs_15yr > 0        => 'y15',
									 ' na');

		o_address_recency_m := map(
			o_address_recency = ' na' => 2.19,
			o_address_recency = 'm12' => 6.17,
			o_address_recency = 'm24' => 6.57,
			o_address_recency = 'm36' => 5.28,
			o_address_recency = 'y05' => 4.54,
			o_address_recency = 'y10' => 3.53,
										 2.82);

		o_addrs_per_ssn_25 := min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 25);

		o_addrs_per_ssn_c6_2 := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

		o_adls_per_addr_10 := min(if(adls_per_addr = NULL, -NULL, adls_per_addr), 10);

		o_ssns_per_addr_35 := min(if(ssns_per_addr = NULL, -NULL, ssns_per_addr), 35);

		o_adls_per_addr_c6_3 := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 3);

		o_outest_nodob := -1.677105792 +
			o_estimated_income_200k * -2.493375E-6 +
			o_wealth_index_m * 0.155307146 +
			o_ams_income_college_m * 0.1013611605 +
			o_prof_license_cat_m * 0.1709183222 +
			o_ver_nodob_mod * 0.3156337416 +
			o_tot_source_ct_2_7 * -0.059402598 +
			o_tot_mosince_fdate_eq_360 * -0.001396618 +
			o_mosince_gong_did_ls_110 * -0.004215926 +
			o_phoneprob_mod * 0.3581278237 +
			o_ssn_mod_nodob * 0.4971434181 +
			o_email_summary_m * 0.1638302531 +
			o_paw_summary_m * 0.1923847589 +
			o_inq_count12_2 * 0.328685825 +
			o_inq_ssnsperaddr_2 * 0.2805734036 +
			o_inq_adlsperphone_2 * 0.3491225226 +
			property_owned_ind * -0.254001204 +
			o_add1_price_per_sqf_300 * -0.001057346 +
			o_avg_add1_avm_val_300k * -0.001351534 +
			(integer)o_hr_add1_financing_type * 0.2965238948 +
			o_attr_addrs_last36_6 * 0.0669169165 +
			o_addrprob_mod * 0.3775957756 +
			o_add1_ownership_m * 0.0477894701 +
			o_addrs_per_ssn_25 * 0.0401283826 +
			o_addrs_per_ssn_c6_2 * 0.4650677597 +
			o_adls_per_addr_10 * 0.0264465636 +
			o_ssns_per_addr_35 * 0.0136230245 +
			o_adls_per_addr_c6_3 * 0.1187665747;

		o_outest_dob := -2.031914288 +
			o_estimated_income_200k * -2.468697E-6 +
			o_wealth_index_m * 0.1572636034 +
			o_ams_income_college_m * 0.1035232387 +
			o_prof_license_cat_m * 0.1721351318 +
			o_ver_mod * 0.3400750873 +
			o_tot_source_ct_2_7 * -0.051374603 +
			o_tot_mosince_fdate_eq_360 * -0.001239425 +
			o_mosince_gong_did_ls_110 * -0.00417883 +
			o_phoneprob_mod * 0.3514192475 +
			o_ssn_mod * 0.4833093726 +
			o_email_summary_m * 0.1588777445 +
			o_paw_summary_m * 0.1928732775 +
			o_inq_count12_2 * 0.332684473 +
			o_inq_ssnsperaddr_2 * 0.2748417845 +
			o_inq_adlsperphone_2 * 0.3434024762 +
			property_owned_ind * -0.249499714 +
			o_add1_price_per_sqf_300 * -0.001073342 +
			o_avg_add1_avm_val_300k * -0.001430815 +
			(integer)o_hr_add1_financing_type * 0.2916162395 +
			o_addrprob_mod * 0.3622161452 +
			o_add1_ownership_m * 0.0456884379 +
			o_address_recency_m * 0.06537428 +
			o_addrs_per_ssn_25 * 0.0422958787 +
			o_addrs_per_ssn_c6_2 * 0.4670113162 +
			o_adls_per_addr_10 * 0.0259984703 +
			o_ssns_per_addr_35 * 0.0130984333 +
			o_adls_per_addr_c6_3 * 0.1199302948;

		o_outest := (integer)dobpop * o_outest_dob + (1 - (integer)dobpop) * o_outest_nodob;

		x_did_ge2 := did_count > 1;

		x_fname_ver := 100 <= combo_fnamescore;

		x_addr_ver := combo_addrscore = 100;

		x_ssn_ver := combo_ssnscore >= 100;

		x_dob_ver := combo_dobscore = 100;

		x_verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		x_wp_addr_ver := (tot_nas_wp in [3, 5, 8]);

		x_vo_addr_ver := tot_nas_vo = 8;

		x_eq_nas_ver := tot_nas_eq > 9;

		x_ts_nas_ver := tot_nas_ts >= 9;

		x_p_addr_ver_summary_m := map(
			tot_nas_p = 0 => 9.39,
			tot_nas_p = 2 => 8.26,
			tot_nas_p < 8 => 7.42,
							 4.09);

		x_ver_mod := -2.488959788 +
			(integer)x_did_ge2 * 0.408692607 +
			(integer)add1_isbestmatch * -0.198686201 +
			(integer)x_fname_ver * 0.3087274356 +
			(integer)x_addr_ver * -0.129802097 +
			(integer)x_dob_ver * -0.394543756 +
			(integer)x_verphn_p * -0.470129219 +
			(integer)x_vo_addr_ver * -0.480761437 +
			(integer)x_wp_addr_ver * -0.144697991 +
			(integer)x_eq_nas_ver * -0.125582126 +
			(integer)x_ts_nas_ver * -0.212186721 +
			x_p_addr_ver_summary_m * 0.0909054771;

		x_ver_nodob_mod := -2.520159658 +
			(integer)x_did_ge2 * 0.461736416 +
			(integer)add1_isbestmatch * -0.195996519 +
			(integer)x_fname_ver * 0.2782655 +
			(integer)x_addr_ver * -0.140921672 +
			(integer)x_ssn_ver * -0.315983204 +
			(integer)x_verphn_p * -0.472765161 +
			(integer)x_vo_addr_ver * -0.54818242 +
			(integer)x_wp_addr_ver * -0.163641339 +
			(integer)x_eq_nas_ver * -0.13022579 +
			(integer)x_ts_nas_ver * -0.306689089 +
			x_p_addr_ver_summary_m * 0.1060150762;

		x_mosince_gong_did_ls_110 := if(mosince_gong_did_ls = NULL, 36, min(mosince_gong_did_ls, 110));

		x_no_adls_per_phone := adls_per_phone = 0;

		x_pnotpots := telcordia_type != '00';

		x_hm_disconnected_phone := rc_hriskphoneflag = (string)5 or nap_status = 'D';

		x_no_gong_did_addr := gong_did_addr_ct = 0;

		x_phoneprob_mod := -2.747442131 +
			(integer)x_no_adls_per_phone * 0.2369351597 +
			(integer)x_hm_disconnected_phone * 0.3592637335 +
			(integer)x_pnotpots * 0.4704700833 +
			(integer)x_no_gong_did_addr * 0.1541541064;

		x_ssn_issued_too_young_or_hi := age_at_ssnlowissue < -7 or age_at_ssnlowissue >= 25;

		x_lo_combo_ssnscore := combo_ssnscore < 100;

		x_ssns_per_adl_c6_2 := min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 2);

		x_ssns_per_adl_gt1 := ssns_per_adl > 1;

		x_invalid_ssn := rc_ssnvalflag = (string)1;

		x_ssn_mod := -2.575902204 +
			(integer)x_ssn_issued_too_young_or_hi * 0.5183466615 +
			x_ssns_per_adl_c6_2 * 0.1663348321 +
			(integer)x_ssns_per_adl_gt1 * 0.3467038551 +
			(integer)x_lo_combo_ssnscore * 0.3710859834;

		x_ssn_mod_nodob := -2.477902109 +
			(integer)x_invalid_ssn * 0.6030818448 +
			x_ssns_per_adl_c6_2 * 0.1438047578 +
			(integer)x_ssns_per_adl_gt1 * 0.3467689994 +
			(integer)x_lo_combo_ssnscore * 0.3982163485;

		x_estimated_income_125k := min(if(estimated_income = NULL, -NULL, estimated_income), 125000);

		x_ams_income_summary := map(
			ams_income_level_code = ''   => 0,
			ams_income_level_code <= 'D' => 1,
			ams_income_level_code = 'E'  => 2,
											3);

		x_ams_college_summary := map(
			ams_college_code = '' => NULL,
			ams_college_code = '1' => 4,
			(integer)ams_college_code
		);

		x_ams_income_college_m := map(
			x_ams_income_summary <= 2 and x_ams_college_summary = NULL => 9.49,
			x_ams_income_summary = 3 and x_ams_college_summary = NULL  => 6.88,
			x_ams_college_summary = 2 or x_ams_income_summary <= 2     => 5.53,
																		  2.63);

		x_hi_prof_license_category := (integer)prof_license_category >= 3;

		x_hi_email_ct := email_count >= 5;

		x_email_summary_m := map(
			(boolean)email_cnt_im_ind or max_email = email_domain_free_count and x_hi_email_ct => 13.79,
			email_domain_edu_ind > 0                                                           => 5.85,
			email_domain_corp_ind > 0                                                          => 6.90,
			email_count != 0 and max_email = email_domain_free_count                           => 8.46,
			email_count != 0 and max_email = email_domain_isp_count                            => 7.52,
																								  9.28);

		x_inq_count12_3 := min(if(inq_count12 = NULL, -NULL, inq_count12), 3);

		x_inq_ssnsperaddr_2 := min(if(Inq_SSNsPerAddr = NULL, -NULL, Inq_SSNsPerAddr), 2);

		x_inq_perphone_2 := min(if(inq_perphone = NULL, -NULL, inq_perphone), 2);

		x_hr_add1_financing_type := (add1_financing_type in ['ADJ', 'OTH']);

		// x_tot_mosince_fdate_eq_360 := if(tot_mosince_fdate_eq = NULL, 204, min(tot_mosince_fdate_eq, 360));
		x_tot_mosince_fdate_eq_360 := if(tot_mosince_fdate_eq = NULL, 360, min(tot_mosince_fdate_eq, 360));

		x_hi_ssns_per_adl_c6 := ssns_per_adl_c6 >= 2;

		x_hi_addrs_per_adl_c6 := addrs_per_adl_c6 >= 3;

		x_hi_lnames_per_adl_c6 := lnames_per_adl_c6 >= 2;

		x_adls_per_ssn_c6_ind := adls_per_ssn_c6 > 0;

		x_addrs_per_ssn_c6_ind := addrs_per_ssn_c6 > 0;

		x_hi_adls_per_addr_c6 := adls_per_addr_c6 >= 3;

		x_hi_ssns_per_addr_c6 := ssns_per_addr_c6 >= 3;

		x_too_recent_velocity := x_hi_ssns_per_adl_c6 or x_hi_addrs_per_adl_c6 or x_hi_lnames_per_adl_c6 or x_adls_per_ssn_c6_ind or x_addrs_per_ssn_c6_ind or x_hi_adls_per_addr_c6 or x_hi_ssns_per_addr_c6;

		x_addrs_per_ssn_25 := min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 25);

		x_adls_per_addr_50 := min(if(adls_per_addr = NULL, -NULL, adls_per_addr), 50);

		x_outest_nodob := -0.597107164 +
			x_estimated_income_125k * -6.518049E-6 +
			x_ams_income_college_m * 0.1753995059 +
			(integer)x_hi_prof_license_category * -0.48597595 +
			x_ver_nodob_mod * 0.6140411902 +
			x_mosince_gong_did_ls_110 * -0.00266634 +
			x_phoneprob_mod * 0.2794381972 +
			x_ssn_mod_nodob * 0.7738781972 +
			x_email_summary_m * 0.0769377736 +
			x_inq_count12_3 * 0.2375914996 +
			x_inq_ssnsperaddr_2 * 0.3380226582 +
			x_inq_perphone_2 * 0.2068126664 +
			(integer)x_hr_add1_financing_type * 0.2682287753 +
			x_tot_mosince_fdate_eq_360 * -0.001860357 +
			(integer)x_too_recent_velocity * 0.3038573181 +
			x_addrs_per_ssn_25 * 0.039323947 +
			x_adls_per_addr_50 * 0.0094901946;

		x_outest_dob := -1.438142237 +
			x_estimated_income_125k * -6.770301E-6 +
			x_ams_income_college_m * 0.1585654058 +
			(integer)x_hi_prof_license_category * -0.479374928 +
			x_ver_mod * 0.5838203593 +
			x_mosince_gong_did_ls_110 * -0.002172583 +
			x_phoneprob_mod * 0.3136413615 +
			x_ssn_mod * 0.380830475 +
			x_email_summary_m * 0.0665845191 +
			x_inq_count12_3 * 0.2443891551 +
			x_inq_ssnsperaddr_2 * 0.3360210635 +
			x_inq_perphone_2 * 0.2038253663 +
			(integer)x_hr_add1_financing_type * 0.2621428285 +
			x_tot_mosince_fdate_eq_360 * -0.001083155 +
			(integer)x_too_recent_velocity * 0.315629193 +
			x_addrs_per_ssn_25 * 0.0452817973 +
			x_adls_per_addr_50 * 0.0082594201;

		x_outest := (integer)dobpop * x_outest_dob + (1 - (integer)dobpop) * x_outest_nodob;

		outest := (integer)segment_d * d_outest +
			(integer)segment_y * y_outest +
			(integer)segment_o * o_outest +
			(integer)segment_x * x_outest;

		phat := exp(outest) / (1 + exp(outest));

		score := round(-40 * (ln(phat / (1 - phat)) - ln(1 / 20)) / ln(2) + 700);

		rva1104_0_0_3 := min(900, if(max(501, score) = NULL, -NULL, max(501, score)));

		ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = '2225';

		ov_impulse := impulse_count > 0;

		rva1104_0_0_2 := if(rva1104_0_0_3 > 680 and (ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 680, rva1104_0_0_3);

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		rva1104_0_0_1 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rva1104_0_0_2);

		rva1104_0_0 := if(rc_decsflag = '1' or source_tot_ds, 200, rva1104_0_0_1);



// REASON CODES
// addrpop                          := le.addrpop;
addrpop                          := le.input_validation.Address;
fnamepop                          := le.input_validation.firstname;
lnamepop                          := le.input_validation.lastname;
in_phone10                       := le.shell_input.phone10;
add2_naprop                      := le.address_verification.address_history_1.naprop;
header_first_seen                := le.ssn_verification.header_first_seen;
add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
rc_dwelltype                     := le.iid.dwelltype;
add3_naprop                      := le.address_verification.address_history_2.naprop;
add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
add2_family_owned                := le.address_verification.address_history_1.family_owned;
add3_family_owned                := le.address_verification.address_history_2.family_owned;
add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
property_ambig_total             := le.address_verification.ambiguous.property_total;
felony_count                     := le.bjl.felony_count;
ssnlength                        := le.input_validation.ssn_length;


// rc1_5 := '';
// rc1v := 0;
// rc2 := '';
// rc2v := 0;
// rc3 := '';
// rc3v := 0;
// rc4 := '';
// rc4v := 0;

// segment_d := if((string)segment = 'd', 1, 0);
// segment_y := if((string)segment = 'y', 1, 0);
// segment_o := if((string)segment = 'o', 1, 0);
// segment_x := if((string)segment = 'x', 1, 0);

glrc3 := (integer)ssnlength>0 and rc_ssndobflag = (string)1;
glrc7 := (integer)hphnpop>0 and rc_hriskphoneflag = (string)5;
glrc20 := ((integer)fnamepop>0 or (integer)lnamepop>0 or (integer)addrpop>0 or (integer)hphnpop>0) and (combo_lnamecount = 0 or combo_addrcount = 0 or combo_hphonecount = 0 or combo_ssncount > 0);
glrc25 := addrpop and combo_addrcount = 0;
glrc26 := 1;
glrc27 := length(trim(in_phone10)) = 10 and combo_hphonecount = 0;
glrc28 := (integer)dobpop > 0 and combo_dobcount = 0;
glrc36 := 1;
glrc37 := 1;
glrc49 := (integer)hphnpop>0 and (integer)addrpop>0 and rc_disthphoneaddr >= 10 and rc_disthphoneaddr != 9999;
glrc74 := if((integer)hphnpop>0, 1, 0);
glrc97 := criminal_count > 0;
glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
glrc99 := (integer)addrpop>0 and (integer)add1_isbestmatch = 0;
glrc9a := (add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0;
glrc9d := attr_addrs_last12 > 0;
glrc9e := 1;
glrc9g := (integer)dobpop>0 and est_age <= 35;
glrc9h := impulse_count > 0;
glrc9i := 0;

header_first_seen2 := models.common.sas_date((string)(header_first_seen));
mosince_header_first_seen := (integer)((today - header_first_seen2) / 30.5);
glrc9j := mosince_header_first_seen < 60;
glrc9o := (integer)addrpop>0 and (integer)add1_eda_sourced = 0;
glrc9q := Inq_count12 > 0;
glrc9s := 1;
glrcev := attr_eviction_count > 0;
glrcmi := (integer)ssnlength>0 and adlperssn_count >= 3;
glrcms := ssns_per_adl >= 3;

aptflag_1 := 0;

aptflag := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, aptflag_1);

add1_econval := map(
    aptflag = 0 and add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
    aptflag = 0 and add1_assessed_total_value > 0    => add1_assessed_total_value,
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

glrc9m := wealth_index < (string)5;

glrc9r := 1;

glrc9t := (integer1)hphnpop;

glrc9u := (integer)addrpop>0 and ((boolean)(integer)add1_vacant_address or (boolean)(integer)add2_vacant_address or (boolean)(integer)y_hm_invalid_addr or (boolean)(integer)y_no_addr_match_input);

glrc9V := (integer1)((integer1)ssnlength>0);

glrc9w := (integer)bankrupt > 0;

rcvalue25_1_c10_b1 := (integer)segment_o * 0.086254514 * ((real)o_lo_addr_score - 0.0738297338);

rcvalue25_2_c10_b1 := (integer)segment_o * 0.160360695 * ((real)o_no_addr_match_input - 0.0871526227);

rcvalue25_3_c10_b1 := (integer)segment_o * 0.070789533 * ((real)o_no_adls_per_addr - 0.0674345024);

rcvalue25_4_c10_b1 := (integer)segment_x * -0.075781107 * ((real)x_addr_ver - 0.7730492885);

rcvalue27_1_c10_b1 := (integer)segment_d * -0.11507349 * ((real)d_verphn_p - 0.4221635642);

rcvalue27_2_c10_b1 := (integer)segment_o * 0.109096985 * ((real)o_no_adls_per_phone - 0.4593091926);

rcvalue27_3_c10_b1 := (integer)segment_o * -0.100527091 * ((real)o_verphn_p - 0.5630832971);

rcvalue27_4_c10_b1 := (integer)segment_x * 0.074312666 * ((real)x_no_adls_per_phone - 0.5769073779);

rcvalue27_5_c10_b1 := (integer)segment_x * -0.27447101 * ((real)x_verphn_p - 0.4296401912);

rcvalue27_6_c10_b1 := (integer)segment_y * 0.156016529 * ((real)y_no_adls_per_phone - 0.7453955559);

rcvalue27_7_c10_b1 := (integer)segment_y * -0.055579313 * ((real)y_verphn_p - 0.2524616139);

rcvalue28_1_c10_b1 := (integer)segment_d * 0.016552597 * ((real)d_dob_ver_m - 11.972190937);

rcvalue28_2_c10_b1 := (integer)segment_o * -0.115035571 * ((real)o_dob_ver - 0.886418854);

rcvalue28_3_c10_b1 := (integer)segment_x * -0.230342677 * ((real)x_dob_ver - 0.7752243563);

rcvalue28_4_c10_b1 := (integer)segment_y * -0.112740676 * ((real)y_dob_ver - 0.5770928434);

rcvalue36_1_c10_b1 := (integer)segment_d * 0.037319431 * ((real)d_em_addr_ver_summary_m - 11.939473482);

rcvalue36_2_c10_b1 := (integer)segment_d * -0.127410128 * ((real)d_eq_nas_ver - 0.8542111688);

rcvalue36_3_c10_b1 := (integer)segment_d * 0.132669779 * ((real)d_lo_combo_ssnscore - 0.0079066219);

rcvalue36_4_c10_b1 := (integer)segment_d * 0.025564472 * ((real)d_p_addr_ver_summary_m - 11.903716204);

rcvalue36_5_c10_b1 := (integer)segment_d * -0.079883041 * ((real)d_ts_nas_ver - 0.4589288984);

rcvalue36_6_c10_b1 := (integer)segment_d * -0.095428959 * ((real)d_vo_addr_ver - 0.117314617);

rcvalue36_7_c10_b1 := (integer)segment_d * -0.052543996 * ((real)d_wp_addr_ver - 0.3269911504);

rcvalue36_8_c10_b1 := (integer)segment_o * -0.079008114 * ((real)o_hm_rc_numelever_4_6 - 5.456145236);

rcvalue36_9_c10_b1 := (integer)segment_o * -0.123444083 * ((real)o_ts_nas_ver - 0.485168571);

rcvalue36_10_c10_b1 := (integer)segment_o * -0.134703402 * ((real)o_vo_addr_ver - 0.1939407477);

rcvalue36_11_c10_b1 := (integer)segment_o * -0.089575915 * ((real)o_wp_addr_ver - 0.4599670753);

rcvalue36_12_c10_b1 := (integer)segment_x * 0.238603065 * ((real)x_did_ge2 - 0.0081355364);

rcvalue36_13_c10_b1 := (integer)segment_x * -0.073317402 * ((real)x_eq_nas_ver - 0.7826274148);

rcvalue36_14_c10_b1 := (integer)segment_x * 0.141320851 * ((real)x_lo_combo_ssnscore - 0.0090245744);

rcvalue36_15_c10_b1 := (integer)segment_x * 0.053072468 * ((real)x_p_addr_ver_summary_m - 9.0155702424);

rcvalue36_16_c10_b1 := (integer)segment_x * -0.123878928 * ((real)x_ts_nas_ver - 0.3857977578);

rcvalue36_17_c10_b1 := (integer)segment_x * -0.280678315 * ((real)x_vo_addr_ver - 0.0908104783);

rcvalue36_18_c10_b1 := (integer)segment_x * -0.084477633 * ((real)x_wp_addr_ver - 0.2597724286);

rcvalue36_19_c10_b1 := (integer)segment_y * -0.029834312 * ((real)y_hm_rc_numelever_3_6 - 4.6536462067);

rcvalue36_20_c10_b1 := (integer)segment_y * -0.064951077 * ((real)y_ts_nas_ver - 0.0849285095);

rcvalue36_21_c10_b1 := (integer)segment_y * -0.070940969 * ((real)y_vo_addr_ver - 0.0589051949);

rcvalue37_1_c10_b1 := (integer)segment_d * -0.04591841 * ((real)d_verfst_p - 0.3922429051);

rcvalue37_2_c10_b1 := (integer)segment_o * -0.081656529 * ((real)o_lname_ver - 0.9771393426);

rcvalue37_3_c10_b1 := (integer)segment_o * -0.058142215 * ((real)o_verfst_p - 0.5310857206);

rcvalue37_4_c10_b1 := (integer)segment_x * 0.180241362 * ((real)x_fname_ver - 0.9507338757);

rcvalue37_5_c10_b1 := (integer)segment_y * -0.04053475 * ((real)y_verlst_p - 0.3458029954);

rcvalue49_1_c10_b1 := (integer)segment_d * 0.000270076 * ((real)d_rc_disthphoneaddr_200 - 108.84899908);

rcvalue74_1_c10_b1 := (integer)segment_d * 0.052401512 * ((real)d_contrary_infutor_nap - 0.1084559048);

rcvalue74_2_c10_b1 := (integer)segment_d * 0.059952376 * ((real)d_hi_gong_did_last_ct - 0.056225206);

rcvalue74_3_c10_b1 := (integer)segment_o * 0.252906717 * ((real)o_hi_gong_did_last_ct - 0.0026621298);

rcvalue97_1_c10_b1 := (integer)(criminal_count > 0 or felony_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue97_2_c10_b1 := (integer)segment_d * -0.006688162 * ((real)d_mosince_criminal_ls_84 - 87.389032652);

rcvalue98_1_c10_b1 := (integer)((boolean)(integer)lien_rec_unrel_flag or (boolean)(integer)lien_hist_unrel_flag) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue98_2_c10_b1 := (integer)segment_d * 0.000052305 * ((real)d_liens_unrel_SC_total_amt_10k - 155.58927678);

rcvalue98_3_c10_b1 := (integer)segment_d * -0.001491068 * ((real)d_mosince_liens_unrel_ls_84 - 70.72749466);

rcvalue98_4_c10_b1 := (integer)segment_d * -0.000549226 * ((real)d_tot_mosince_ldate_L2_240 - 137.00754043);

rcvalue99_1_c10_b1 := (integer)segment_d * -0.040113769 * ((real)(integer)add1_isbestmatch - 0.6677448886);

rcvalue99_2_c10_b1 := (integer)segment_o * -0.086766465 * ((real)(integer)add1_isbestmatch - 0.7483399938);

rcvalue99_3_c10_b1 := (integer)segment_o * 0.101875045 * ((real)(integer)rc_input_addr_not_most_recent - 0.1728732031);

rcvalue99_4_c10_b1 := (integer)segment_x * -0.115997049 * ((real)(integer)add1_isbestmatch - 0.6418518829);

rcvalue99_5_c10_b1 := (integer)segment_y * -0.075545912 * ((real)(integer)add1_isbestmatch - 0.6490889199);

rcvalue9a_1_c10_b1 := (integer)segment_o * 0.045688438 * ((real)o_add1_ownership_m - 4.6901510988);

rcvalue9a_2_c10_b1 := (integer)segment_o * -0.249499714 * ((real)property_owned_ind - 0.9444043255);

rcvalue9a_3_c10_b1 := (integer)segment_y * 0.042224856 * ((real)y_add1_ownership_m - 11.763001698);

rcvalue9d_1_c10_b1 := (integer)segment_d * 0.030282945 * ((real)d_addrs_15yr_20 - 5.8556179432);

rcvalue9d_2_c10_b1 := (integer)segment_d * 0.016641449 * ((real)d_addrs_per_ssn_25 - 8.8883368935);

rcvalue9d_3_c10_b1 := (integer)segment_d * 0.283176865 * ((real)d_addrs_per_ssn_c6_2 - 0.1063655783);

rcvalue9d_4_c10_b1 := (integer)segment_o * 0.06537428 * ((real)o_address_recency_m - 4.7292152225);

rcvalue9d_5_c10_b1 := (integer)segment_o * 0.042295879 * ((real)o_addrs_per_ssn_25 - 7.1644339455);

rcvalue9d_6_c10_b1 := (integer)segment_o * 0.467011316 * ((real)o_addrs_per_ssn_c6_2 - 0.0586617137);

rcvalue9d_7_c10_b1 := (integer)segment_x * 0.045281797 * ((real)x_addrs_per_ssn_25 - 6.8129721267);

rcvalue9d_8_c10_b1 := (integer)segment_y * 0.20218923 * ((real)y_addrs_per_ssn_c6_2 - 0.1715395933);

rcvalue9e_1_c10_b1 := (integer)segment_d * 0.05987118 * ((real)d_lo_source_ct - 0.0649740616);

rcvalue9e_2_c10_b1 := (integer)segment_o * -0.051374603 * ((real)o_tot_source_ct_2_7 - 4.0673029259);

rcvalue9g_1_c10_b1 := (integer)segment_d * -0.000600687 * ((real)d_time_since_ssnlowissue_876 - 400.94127861);

rcvalue9g_2_c10_b1 := (integer)segment_o * -0.001780817 * ((real)o_time_since_ssnlowissue_480 - 377.62261097);

rcvalue9g_3_c10_b1 := (integer)segment_y * (-2.282360767 - 0.092594409);

rcvalue9g_4_c10_b1 := (integer)segment_y * -0.038613902 * ((real)y_est_age_18 - 23.55835817);

rcvalue9h_1_c10_b1 := (integer)(impulse_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue9m_1_c10_b1 := (integer)segment_d * 0.054501446 * ((real)d_ams_income_college_m - 11.951359658);

rcvalue9m_2_c10_b1 := (integer)segment_d * 0.038743679 * ((real)d_wealth_index_m - 11.94109112);

rcvalue9m_3_c10_b1 := (integer)segment_d * -1.896E-6 * (estimated_income - 45500.088599);

rcvalue9m_4_c10_b1 := (integer)segment_o * 0.103523239 * ((real)o_ams_income_college_m - 4.6801870529);

rcvalue9m_5_c10_b1 := (integer)segment_o * -2.469E-6 * (o_estimated_income_200k - 57401.864804);

rcvalue9m_6_c10_b1 := (integer)segment_o * 0.157263603 * ((real)o_wealth_index_m - 4.6675047276);

rcvalue9m_7_c10_b1 := (integer)segment_x * 0.158565406 * ((real)x_ams_income_college_m - 9.0017027034);

rcvalue9m_8_c10_b1 := (integer)segment_x * -6.77E-6 * (x_estimated_income_125k - 36568.72673);

rcvalue9m_9_c10_b1 := (integer)segment_y * 0.095452608 * ((real)y_ams_income_college_m - 11.843451843);

rcvalue9o_1_c10_b1 := (integer)segment_o * 0.061358805 * ((real)o_no_gong_did_addr - 0.3030421718);

rcvalue9o_2_c10_b1 := (integer)segment_x * 0.048349104 * ((real)x_no_gong_did_addr - 0.4172887137);

rcvalue9q_1_c10_b1 := (integer)segment_d * 0.187045419 * ((real)d_inq_noncoll_count_3 - 0.1056759231);

rcvalue9q_2_c10_b1 := (integer)segment_d * -0.021519955 * ((real)d_mosince_inq_last_log_12 - 18.61732072);

rcvalue9q_3_c10_b1 := (integer)segment_o * 0.274841785 * ((real)o_Inq_SSNsPerAddr_2 - 0.0892823265);

rcvalue9q_4_c10_b1 := (integer)segment_o * 0.343402476 * ((real)o_inq_adlsperphone_2 - 0.0403511563);

rcvalue9q_5_c10_b1 := (integer)segment_o * 0.332684473 * ((real)o_inq_count12_2 - 0.0288152604);

rcvalue9q_6_c10_b1 := (integer)segment_x * 0.336021064 * ((real)x_Inq_SSNsPerAddr_2 - 0.1593167268);

rcvalue9q_7_c10_b1 := (integer)segment_x * 0.244389155 * ((real)x_inq_count12_3 - 0.0718946574);

rcvalue9q_8_c10_b1 := (integer)segment_x * 0.203825366 * ((real)x_inq_perphone_2 - 0.0718051944);

rcvalue9q_9_c10_b1 := (integer)segment_y * 0.512114495 * ((real)y_inq_addrsperadl_2 - 0.09733278);

rcvalue9q_10_c10_b1 := (integer)segment_y * 0.198478495 * ((real)y_inq_adlsperphone_2 - 0.0729844947);

rcvalue9r_1_c10_b1 := (integer)segment_d * 0.04321931 * ((real)d_email_summary_m - 11.947325328);
rcvalue9r_2_c10_b1 := (integer)segment_d * 0.092830875 * ((real)d_paw_summary_m - 11.949474733);
rcvalue9r_3_c10_b1 := (integer)segment_d * -0.002166893 * ((real)d_time_on_gong_120 - 42.8593195);
rcvalue9r_4_c10_b1 := (integer)segment_d * -0.000693568 * ((real)d_tot_mosince_fdate_EQ_480 - 228.07075679);
rcvalue9r_5_c10_b1 := (integer)segment_o * 0.158877745 * ((real)o_email_summary_m - 4.6689587095);
rcvalue9r_6_c10_b1 := (integer)segment_o * 0.055425288 * ((real)o_infutor_ver - 0.2688689926);
rcvalue9r_7_c10_b1 := (integer)segment_o * 0.097744382 * ((real)o_lo_infutor_nap - 0.1876158944);
rcvalue9r_8_c10_b1 := (integer)segment_o * -0.00417883 * ((real)o_mosince_gong_did_ls_110 - 63.863613275);
rcvalue9r_9_c10_b1 := (integer)segment_o * 0.192873278 * ((real)o_paw_summary_m - 4.6718657246);
rcvalue9r_10_c10_b1 := (integer)segment_o * -0.001239425 * ((real)o_tot_mosince_fdate_EQ_360 - 227.57945387);
rcvalue9r_11_c10_b1 := (integer)segment_x * 0.066584519 * ((real)x_email_summary_m - 9.0139677934);
rcvalue9r_12_c10_b1 := (integer)segment_x * -0.002172583 * ((real)x_mosince_gong_did_ls_110 - 53.385283346);
rcvalue9r_13_c10_b1 := (integer)segment_x * -0.001083155 * ((real)x_tot_mosince_fdate_EQ_360 - 190.8813945);
rcvalue9r_14_c10_b1 := (integer)segment_y * 0.077511178 * ((real)y_email_summary_m - 11.745411401);
rcvalue9r_15_c10_b1 := (integer)segment_y * 0.170580244 * ((real)y_lo_infutor_nap - 0.7525182027);
rcvalue9r_16_c10_b1 := (integer)segment_y * 0.112939611 * ((real)y_paw_summary_m - 11.761895424);
rcvalue9r_17_c10_b1 := (integer)segment_y * -0.005193519 * ((real)y_time_on_EQ_120 - 58.459750255);

rcvalue9s_1_c10_b1 := (integer)segment_d * 0.142942007 * ((real)d_add1_financing_type_m - 11.945922795);
rcvalue9s_2_c10_b1 := (integer)segment_o * 0.29161624 * ((real)o_hr_add1_financing_type - 0.1042820511);
rcvalue9s_3_c10_b1 := (integer)segment_x * 0.262142829 * ((real)x_hr_add1_financing_type - 0.0455478207);

rcvalue9t_1_c10_b1 := (integer)segment_d * 0.143471238 * ((real)d_hm_disconnected_phone - 0.0291547147);
rcvalue9t_2_c10_b1 := (integer)segment_d * 0.120234958 * ((real)d_pnotpots - 0.3620598108);
rcvalue9t_3_c10_b1 := (integer)segment_o * 0.223651352 * ((real)o_hm_disconnected_phone - 0.0344118529);
rcvalue9t_4_c10_b1 := (integer)segment_o * 0.212059593 * ((real)o_pnotpots - 0.2535602162);
rcvalue9t_5_c10_b1 := (integer)segment_x * 0.112679967 * ((real)x_hm_disconnected_phone - 0.0312113842);
rcvalue9t_6_c10_b1 := (integer)segment_x * 0.147558877 * ((real)x_pnotpots - 0.3966171825);
rcvalue9t_7_c10_b1 := (integer)segment_y * 0.291930266 * ((real)y_hm_disconnected_phone - 0.0209906817);

rcvalue9u_1_c10_b1 := (integer)segment_o * 0.042825978 * ((real)o_addr_vacant_summary_m - 4.6854864048);
rcvalue9u_2_c10_b1 := (integer)segment_y * 0.033844887 * ((real)y_addr_prob_summary_m - 11.726220244);
rcvalue9u_3_c10_b1 := (integer)segment_y * 0.065866979 * ((real)y_addr_vacant_summary_m - 11.729990795);

rcvalue9v_1_c10_b1 := (integer)segment_o * 0.342587068 * ((real)o_invalid_ssns_flag - 0.0132372111);
rcvalue9v_2_c10_b1 := (integer)segment_o * 0.07481739 * ((real)o_ssn_issued_too_young_or_hi - 0.1162218564);
rcvalue9v_3_c10_b1 := (integer)segment_x * 0.197402205 * ((real)x_ssn_issued_too_young_or_hi - 0.1524113059);

rcvalue9w_1_c10_b1 := (integer)((rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);
rcvalue9w_2_c10_b1 := (integer)segment_d * 0.377527664 * ((real)d_bad_bk - 0.0208178212);

rcvalueev_1_c10_b1 := (integer)(attr_eviction_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);
rcvalueev_2_c10_b1 := (integer)segment_d * -0.004058287 * ((real)d_mosince_eviction_ls_84 - 86.691046689);

rcvaluemi_1_c10_b1 := (integer)segment_y * 0.167534392 * ((real)y_adlperssn_count_1_3 - 1.3255668314);

rcvaluems_1_c10_b1 := (integer)segment_d * 0.070834167 * ((real)d_ssns_per_adl_5 - 1.4540341776);
rcvaluems_2_c10_b1 := (integer)segment_d * 0.053165984 * ((real)d_ssns_per_adl_c6_2 - 0.5767989014);
rcvaluems_3_c10_b1 := (integer)segment_o * 0.076333476 * ((real)o_ssns_per_adl_c6_2 - 0.4980967302);
rcvaluems_4_c10_b1 := (integer)segment_o * 0.269275255 * ((real)o_ssns_per_adl_gt2 - 0.0405500511);
rcvaluems_5_c10_b1 := (integer)segment_x * 0.063345373 * ((real)x_ssns_per_adl_c6_2 - 0.4947188907);
rcvaluems_6_c10_b1 := (integer)segment_x * 0.132035394 * ((real)x_ssns_per_adl_gt1 - 0.2128826638);
rcvaluems_7_c10_b1 := (integer)segment_y * 0.278713217 * ((real)y_ssns_per_adl_gt1 - 0.1146791414);

rcvaluepv_1_c10_b1 := (integer)segment_o * -0.001073342 * ((real)o_add1_price_per_sqf_300 - 166.24287498);

rcvaluepv_2_c10_b1 := (integer)segment_o * -0.001430815 * ((real)o_avg_add1_avm_val_300k - 152.87359167);

rcvalue25_1_c10_b2 := (integer)segment_o * ((real)o_no_addr_match_input - 0.0871526227);

rcvalue25_2_c10_b2 := (integer)segment_o * ((real)o_lo_addr_score - 0.0738297338);

rcvalue25_3_c10_b2 := (integer)segment_o * ((real)o_no_adls_per_addr - 0.0674345024);

rcvalue25_4_c10_b2 := (integer)segment_x * ((real)x_addr_ver - 0.7730492885);

rcvalue26_1_c10_b2 := (integer)segment_x * ((real)x_ssn_ver - 0.9909754256);

rcvalue27_1_c10_b2 := (integer)segment_d * ((real)d_verphn_p - 0.4221635642);

rcvalue27_2_c10_b2 := (integer)segment_o * ((real)o_verphn_p - 0.5630832971);

rcvalue27_3_c10_b2 := (integer)segment_o * ((real)o_no_adls_per_phone - 0.4593091926);

rcvalue27_4_c10_b2 := (integer)segment_x * ((real)x_verphn_p - 0.4296401912);

rcvalue27_5_c10_b2 := (integer)segment_x * ((real)x_no_adls_per_phone - 0.5769073779);

rcvalue27_6_c10_b2 := (integer)segment_y * ((real)y_verphn_p - 0.2524616139);

rcvalue27_7_c10_b2 := (integer)segment_y * ((real)y_no_adls_per_phone - 0.7453955559);

rcvalue36_1_c10_b2 := (integer)segment_d * ((real)d_wp_addr_ver - 0.3269911504);

rcvalue36_2_c10_b2 := (integer)segment_d * ((real)d_eq_nas_ver - 0.8542111688);

rcvalue36_3_c10_b2 := (integer)segment_d * ((real)d_ts_nas_ver - 0.4589288984);

rcvalue36_4_c10_b2 := (integer)segment_d * ((real)d_vo_addr_ver - 0.117314617);

rcvalue36_5_c10_b2 := (integer)segment_d * ((real)d_p_addr_ver_summary_m - 11.903716204);

rcvalue36_6_c10_b2 := (integer)segment_d * ((real)d_em_addr_ver_summary_m - 11.939473482);

rcvalue36_7_c10_b2 := (integer)segment_d * ((real)d_lo_combo_ssnscore - 0.0079066219);

rcvalue36_8_c10_b2 := (integer)segment_o * ((real)o_did_ge2 - 0.0085800138);

rcvalue36_9_c10_b2 := (integer)segment_o * ((real)o_hm_rc_numelever_nodob_3_5 - 4.5132463908);

rcvalue36_10_c10_b2 := (integer)segment_o * ((real)o_wp_addr_ver - 0.4599670753);

rcvalue36_11_c10_b2 := (integer)segment_o * ((real)o_ts_nas_ver - 0.485168571);

rcvalue36_12_c10_b2 := (integer)segment_o * ((real)o_vo_addr_ver - 0.1939407477);

rcvalue36_13_c10_b2 := (integer)segment_x * ((real)x_did_ge2 - 0.0081355364);

rcvalue36_14_c10_b2 := (integer)segment_x * ((real)x_vo_addr_ver - 0.0908104783);

rcvalue36_15_c10_b2 := (integer)segment_x * ((real)x_wp_addr_ver - 0.2597724286);

rcvalue36_16_c10_b2 := (integer)segment_x * ((real)x_eq_nas_ver - 0.7826274148);

rcvalue36_17_c10_b2 := (integer)segment_x * ((real)x_ts_nas_ver - 0.3857977578);

rcvalue36_18_c10_b2 := (integer)segment_x * ((real)x_p_addr_ver_summary_m - 9.0155702424);

rcvalue36_19_c10_b2 := (integer)segment_x * ((real)x_lo_combo_ssnscore - 0.0090245744);

rcvalue36_20_c10_b2 := (integer)segment_y * ((real)y_did_ge2 - 0.004481835);

rcvalue36_21_c10_b2 := (integer)segment_y * ((real)y_vo_addr_ver - 0.0589051949);

rcvalue36_22_c10_b2 := (integer)segment_y * ((real)y_eq_nas_ver - 0.7608858037);

rcvalue36_23_c10_b2 := (integer)segment_y * ((real)y_ts_nas_ver - 0.0849285095);

rcvalue37_1_c10_b2 := (integer)segment_d * ((real)d_verfst_p - 0.3922429051);

rcvalue37_2_c10_b2 := (integer)segment_o * ((real)o_lname_ver - 0.9771393426);

rcvalue37_3_c10_b2 := (integer)segment_o * ((real)o_verfst_p - 0.5310857206);

rcvalue37_4_c10_b2 := (integer)segment_x * ((real)x_fname_ver - 0.9507338757);

rcvalue37_5_c10_b2 := (integer)segment_y * ((real)y_verlst_p - 0.3458029954);

rcvalue49_1_c10_b2 := (integer)segment_d * ((real)d_rc_disthphoneaddr_200 - 108.84899908);

rcvalue74_1_c10_b2 := (integer)segment_d * ((real)d_contrary_infutor_nap - 0.1084559048);

rcvalue74_2_c10_b2 := (integer)segment_d * ((real)d_hi_gong_did_last_ct - 0.056225206);

rcvalue74_3_c10_b2 := (integer)segment_o * ((real)o_hi_gong_did_last_ct - 0.0026621298);

rcvalue97_1_c10_b2 := (integer)(criminal_count > 0 or felony_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue97_2_c10_b2 := (integer)segment_d * ((real)d_mosince_criminal_ls_84 - 87.389032652);

rcvalue98_1_c10_b2 := (integer)((boolean)(integer)lien_rec_unrel_flag or (boolean)(integer)lien_hist_unrel_flag) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue98_2_c10_b2 := (integer)segment_d * ((real)d_liens_recent_unrel_ct_4 - 0.1934604821);

rcvalue98_3_c10_b2 := (integer)segment_d * ((real)d_liens_unrel_SC_total_amt_10k - 155.58927678);

rcvalue98_4_c10_b2 := (integer)segment_d * ((real)d_tot_mosince_ldate_L2_240 - 137.00754043);

rcvalue99_1_c10_b2 := (integer)segment_d * ((real)(integer)add1_isbestmatch - 0.6677448886);

rcvalue99_2_c10_b2 := (integer)segment_d * ((real)(integer)add1_isbestmatch - 0.6677448886);

rcvalue99_3_c10_b2 := (integer)segment_d * ((real)(integer)add1_isbestmatch - 0.6677448886);

rcvalue99_4_c10_b2 := (integer)segment_d * ((real)(integer)add1_isbestmatch - 0.6677448886);

rcvalue99_5_c10_b2 := (integer)segment_o * ((real)(integer)add1_isbestmatch - 0.7483399938);

rcvalue99_6_c10_b2 := (integer)segment_o * ((real)(integer)add1_isbestmatch - 0.7483399938);

rcvalue99_7_c10_b2 := (integer)segment_o * ((real)(integer)rc_input_addr_not_most_recent - 0.1728732031);

rcvalue99_8_c10_b2 := (integer)segment_o * ((real)(integer)add1_isbestmatch - 0.7483399938);

rcvalue99_9_c10_b2 := (integer)segment_o * ((real)(integer)add1_isbestmatch - 0.7483399938);

rcvalue99_10_c10_b2 := (integer)segment_x * ((real)(integer)add1_isbestmatch - 0.6418518829);

rcvalue99_11_c10_b2 := (integer)segment_x * ((real)(integer)add1_isbestmatch - 0.6418518829);

rcvalue99_12_c10_b2 := (integer)segment_x * ((real)(integer)add1_isbestmatch - 0.6418518829);

rcvalue99_13_c10_b2 := (integer)segment_x * ((real)(integer)add1_isbestmatch - 0.6418518829);

rcvalue99_14_c10_b2 := (integer)segment_y * ((real)(integer)add1_isbestmatch - 0.6490889199);

rcvalue99_15_c10_b2 := (integer)segment_y * ((real)(integer)add1_isbestmatch - 0.6490889199);

rcvalue99_16_c10_b2 := (integer)segment_y * ((real)(integer)add1_isbestmatch - 0.6490889199);

rcvalue99_17_c10_b2 := (integer)segment_y * ((real)(integer)add1_isbestmatch - 0.6490889199);

rcvalue9a_1_c10_b2 := (integer)segment_o * ((real)property_owned_ind - 0.9444043255);

rcvalue9a_2_c10_b2 := (integer)segment_o * ((real)o_add1_ownership_m - 4.6901510988);

rcvalue9a_3_c10_b2 := (integer)segment_y * ((real)y_add1_ownership_m - 11.763001698);

rcvalue9d_1_c10_b2 := (integer)segment_d * ((real)d_addrs_15yr_20 - 5.8556179432);

rcvalue9d_2_c10_b2 := (integer)segment_d * ((real)d_addrs_per_ssn_25 - 8.8883368935);

rcvalue9d_3_c10_b2 := (integer)segment_d * ((real)d_addrs_per_ssn_c6_2 - 0.1063655783);

rcvalue9d_4_c10_b2 := (integer)segment_o * ((real)o_attr_addrs_last36_6 - 0.8448835089);

rcvalue9d_5_c10_b2 := (integer)segment_o * ((real)o_addrs_per_ssn_25 - 7.1644339455);

rcvalue9d_6_c10_b2 := (integer)segment_o * ((real)o_addrs_per_ssn_c6_2 - 0.0586617137);

rcvalue9d_7_c10_b2 := (integer)segment_x * ((real)x_addrs_per_ssn_25 - 6.8129721267);

rcvalue9d_8_c10_b2 := (integer)segment_y * ((real)y_addrs_per_ssn_c6_2 - 0.1715395933);

rcvalue9e_1_c10_b2 := (integer)segment_d * ((real)d_lo_source_ct - 0.0649740616);

rcvalue9e_2_c10_b2 := (integer)segment_o * ((real)o_tot_source_ct_2_7 - 4.0673029259);

rcvalue9g_1_c10_b2 := (integer)segment_d * ((real)d_time_since_ssnlowissue_876 - 400.94127861);

rcvalue9g_2_c10_b2 := (integer)segment_o * ((real)o_time_since_ssnlowissue_480 - 377.62261097);

rcvalue9g_3_c10_b2 := (integer)segment_y * ((real)-2.282360767 - 0.092594409);

rcvalue9h_1_c10_b2 := (integer)(impulse_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue9m_1_c10_b2 := (integer)segment_d * ((real)estimated_income - 45500.088599);

rcvalue9m_2_c10_b2 := (integer)segment_d * ((real)d_wealth_index_m - 11.94109112);

rcvalue9m_3_c10_b2 := (integer)segment_d * ((real)d_ams_income_college_m - 11.951359658);

rcvalue9m_4_c10_b2 := (integer)segment_o * ((real)o_estimated_income_200k - 57401.864804);

rcvalue9m_5_c10_b2 := (integer)segment_o * ((real)o_wealth_index_m - 4.6675047276);

rcvalue9m_6_c10_b2 := (integer)segment_o * ((real)o_ams_income_college_m - 4.6801870529);

rcvalue9m_7_c10_b2 := (integer)segment_x * ((real)x_estimated_income_125k - 36568.72673);

rcvalue9m_8_c10_b2 := (integer)segment_x * ((real)x_ams_income_college_m - 9.0017027034);

rcvalue9m_9_c10_b2 := (integer)segment_y * ((real)y_wealth_index_m - 11.748757158);

rcvalue9m_10_c10_b2 := (integer)segment_y * ((real)y_ams_income_college_m - 11.843451843);

rcvalue9o_1_c10_b2 := (integer)segment_o * ((real)o_no_gong_did_addr - 0.3030421718);

rcvalue9o_2_c10_b2 := (integer)segment_x * ((real)x_no_gong_did_addr - 0.4172887137);

rcvalue9q_1_c10_b2 := (integer)segment_d * ((real)d_inq_noncoll_summary_m - 11.854802807);

rcvalue9q_2_c10_b2 := (integer)segment_d * ((real)d_inq_noncoll_count_3 - 0.1056759231);

rcvalue9q_3_c10_b2 := (integer)segment_o * ((real)o_inq_count12_2 - 0.0288152604);

rcvalue9q_4_c10_b2 := (integer)segment_o * ((real)o_Inq_SSNsPerAddr_2 - 0.0892823265);

rcvalue9q_5_c10_b2 := (integer)segment_o * ((real)o_inq_adlsperphone_2 - 0.0403511563);

rcvalue9q_6_c10_b2 := (integer)segment_x * ((real)x_inq_count12_3 - 0.0718946574);

rcvalue9q_7_c10_b2 := (integer)segment_x * ((real)x_Inq_SSNsPerAddr_2 - 0.1593167268);

rcvalue9q_8_c10_b2 := (integer)segment_x * ((real)x_inq_perphone_2 - 0.0718051944);

rcvalue9q_9_c10_b2 := (integer)segment_y * ((real)y_inq_addrsperadl_2 - 0.09733278);

rcvalue9q_10_c10_b2 := (integer)segment_y * ((real)y_inq_adlsperphone_2 - 0.0729844947);

rcvalue9r_1_c10_b2 := (integer)segment_d * ((real)d_email_summary_m - 11.947325328);

rcvalue9r_2_c10_b2 := (integer)segment_d * ((real)d_paw_summary_m - 11.949474733);

rcvalue9r_3_c10_b2 := (integer)segment_d * ((real)d_time_on_gong_120 - 42.8593195);

rcvalue9r_4_c10_b2 := (integer)segment_d * ((real)d_tot_mosince_fdate_EQ_480 - 228.07075679);

rcvalue9r_5_c10_b2 := (integer)segment_o * ((real)o_tot_mosince_fdate_EQ_360 - 227.57945387);

rcvalue9r_6_c10_b2 := (integer)segment_o * ((real)o_mosince_gong_did_ls_110 - 63.863613275);

rcvalue9r_7_c10_b2 := (integer)segment_o * ((real)o_email_summary_m - 4.6689587095);

rcvalue9r_8_c10_b2 := (integer)segment_o * ((real)o_paw_summary_m - 4.6718657246);

rcvalue9r_9_c10_b2 := (integer)segment_o * ((real)o_infutor_ver - 0.2688689926);

rcvalue9r_10_c10_b2 := (integer)segment_o * ((real)o_lo_infutor_nap - 0.1876158944);

rcvalue9r_11_c10_b2 := (integer)segment_x * ((real)x_mosince_gong_did_ls_110 - 53.385283346);

rcvalue9r_12_c10_b2 := (integer)segment_x * ((real)x_email_summary_m - 9.0139677934);

rcvalue9r_13_c10_b2 := (integer)segment_x * ((real)x_tot_mosince_fdate_EQ_360 - 190.8813945);

rcvalue9r_14_c10_b2 := (integer)segment_y * ((real)y_mosince_gong_did_ls_108 - 31.748232542);

rcvalue9r_15_c10_b2 := (integer)segment_y * ((real)y_email_summary_m - 11.745411401);

rcvalue9r_16_c10_b2 := (integer)segment_y * ((real)y_paw_summary_m - 11.761895424);

rcvalue9r_17_c10_b2 := (integer)segment_y * ((real)y_lo_infutor_nap - 0.7525182027);

rcvalue9s_1_c10_b2 := (integer)segment_d * ((real)d_add1_financing_type_m - 11.945922795);

rcvalue9s_2_c10_b2 := (integer)segment_o * ((real)o_hr_add1_financing_type - 0.1042820511);

rcvalue9s_3_c10_b2 := (integer)segment_x * ((real)x_hr_add1_financing_type - 0.0455478207);

rcvalue9s_4_c10_b2 := (integer)segment_y * ((real)y_hr_add1_financing_type - 0.0661183838);

rcvalue9t_1_c10_b2 := (integer)segment_d * ((real)d_hm_disconnected_phone - 0.0291547147);

rcvalue9t_2_c10_b2 := (integer)segment_d * ((real)d_pnotpots - 0.3620598108);

rcvalue9t_3_c10_b2 := (integer)segment_o * ((real)o_hm_disconnected_phone - 0.0344118529);

rcvalue9t_4_c10_b2 := (integer)segment_o * ((real)o_pnotpots - 0.2535602162);

rcvalue9t_5_c10_b2 := (integer)segment_x * ((real)x_hm_disconnected_phone - 0.0312113842);

rcvalue9t_6_c10_b2 := (integer)segment_x * ((real)x_pnotpots - 0.3966171825);

rcvalue9t_7_c10_b2 := (integer)segment_y * ((real)y_hm_disconnected_phone - 0.0209906817);

rcvalue9u_1_c10_b2 := (integer)segment_o * ((real)o_addr_vacant_summary_m - 4.6854864048);

rcvalue9u_2_c10_b2 := (integer)segment_y * ((real)y_addr_vacant_summary_m - 11.729990795);

rcvalue9v_1_c10_b2 := (integer)segment_o * ((real)o_invalid_ssns_flag - 0.0132372111);

rcvalue9v_2_c10_b2 := (integer)segment_x * ((real)x_invalid_ssn - 0.0038301322);

rcvalue9w_1_c10_b2 := (integer)((rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalue9w_2_c10_b2 := (integer)segment_d * ((real)d_bad_bk - 0.0208178212);

rcvalueev_1_c10_b2 := (integer)(attr_eviction_count > 0) * (integer)segment_d * (-2.296430939 - -2.62224529);

rcvalueev_2_c10_b2 := (integer)segment_d * ((real)d_mosince_eviction_ls_84 - 86.691046689);

rcvaluemi_1_c10_b2 := (integer)segment_y * ((real)y_adlperssn_count_1_3 - 1.3255668314);

rcvaluems_1_c10_b2 := (integer)segment_d * ((real)d_ssns_per_adl_c6_2 - 0.5767989014);

rcvaluems_2_c10_b2 := (integer)segment_d * ((real)d_ssns_per_adl_5 - 1.4540341776);

rcvaluems_3_c10_b2 := (integer)segment_o * ((real)o_ssns_per_adl_c6_2 - 0.4980967302);

rcvaluems_4_c10_b2 := (integer)segment_o * ((real)o_ssns_per_adl_gt2 - 0.0405500511);

rcvaluems_5_c10_b2 := (integer)segment_x * ((real)x_ssns_per_adl_c6_2 - 0.4947188907);

rcvaluems_6_c10_b2 := (integer)segment_x * ((real)x_ssns_per_adl_gt1 - 0.2128826638);

rcvaluems_7_c10_b2 := (integer)segment_y * ((real)y_ssns_per_adl_gt1 - 0.1146791414);

rcvaluepv_1_c10_b2 := (integer)segment_o * ((real)o_add1_price_per_sqf_300 - 166.24287498);

rcvaluepv_2_c10_b2 := (integer)segment_o * ((real)o_avg_add1_avm_val_300k - 152.87359167);


rcvaluemi := if(dobpop, (integer)glrcmi * sum(rcvaluemi_1_c10_b1), (integer)glrcmi * sum(rcvaluemi_1_c10_b2));

rcvalue27 := if(dobpop,
	(integer)glrc27 * sum(rcvalue27_1_c10_b1, rcvalue27_2_c10_b1, rcvalue27_3_c10_b1, rcvalue27_4_c10_b1, rcvalue27_5_c10_b1, rcvalue27_6_c10_b1, rcvalue27_7_c10_b1),
	(integer)glrc27 * sum(rcvalue27_1_c10_b2, rcvalue27_2_c10_b2, rcvalue27_3_c10_b2, rcvalue27_4_c10_b2, rcvalue27_5_c10_b2, rcvalue27_6_c10_b2, rcvalue27_7_c10_b2))
;

rcvalue9r := if(dobpop,
	glrc9r * sum(rcvalue9r_1_c10_b1, rcvalue9r_2_c10_b1, rcvalue9r_3_c10_b1, rcvalue9r_4_c10_b1, rcvalue9r_5_c10_b1, rcvalue9r_6_c10_b1, rcvalue9r_7_c10_b1, rcvalue9r_8_c10_b1, rcvalue9r_9_c10_b1, rcvalue9r_10_c10_b1, rcvalue9r_11_c10_b1, rcvalue9r_12_c10_b1, rcvalue9r_13_c10_b1, rcvalue9r_14_c10_b1, rcvalue9r_15_c10_b1, rcvalue9r_16_c10_b1, rcvalue9r_17_c10_b1),
	glrc9r * sum(rcvalue9r_1_c10_b2, rcvalue9r_2_c10_b2, rcvalue9r_3_c10_b2, rcvalue9r_4_c10_b2, rcvalue9r_5_c10_b2, rcvalue9r_6_c10_b2, rcvalue9r_7_c10_b2, rcvalue9r_8_c10_b2, rcvalue9r_9_c10_b2, rcvalue9r_10_c10_b2, rcvalue9r_11_c10_b2, rcvalue9r_12_c10_b2, rcvalue9r_13_c10_b2, rcvalue9r_14_c10_b2, rcvalue9r_15_c10_b2, rcvalue9r_16_c10_b2, rcvalue9r_17_c10_b2))
;

rcvalue9d := if(dobpop, (integer)glrc9d * sum(rcvalue9d_1_c10_b1, rcvalue9d_2_c10_b1, rcvalue9d_3_c10_b1, rcvalue9d_4_c10_b1, rcvalue9d_5_c10_b1, rcvalue9d_6_c10_b1, rcvalue9d_7_c10_b1, rcvalue9d_8_c10_b1), (integer)glrc9d * sum(rcvalue9d_1_c10_b2, rcvalue9d_2_c10_b2, rcvalue9d_3_c10_b2, rcvalue9d_4_c10_b2, rcvalue9d_5_c10_b2, rcvalue9d_6_c10_b2, rcvalue9d_7_c10_b2, rcvalue9d_8_c10_b2));

rcvalue98 := if(dobpop, (integer)glrc98 * sum(rcvalue98_1_c10_b1, rcvalue98_2_c10_b1, rcvalue98_3_c10_b1, rcvalue98_4_c10_b1), (integer)glrc98 * sum(rcvalue98_1_c10_b2, rcvalue98_2_c10_b2, rcvalue98_3_c10_b2, rcvalue98_4_c10_b2));

rcvaluepv := if(dobpop, glrcpv * sum(rcvaluepv_1_c10_b1, rcvaluepv_2_c10_b1), glrcpv * sum(rcvaluepv_1_c10_b2, rcvaluepv_2_c10_b2));

rcvalue99 := if(dobpop, (integer)glrc99 * sum(rcvalue99_1_c10_b1, rcvalue99_2_c10_b1, rcvalue99_3_c10_b1, rcvalue99_4_c10_b1, rcvalue99_5_c10_b1), (integer)glrc99 * sum(rcvalue99_1_c10_b2, rcvalue99_2_c10_b2, rcvalue99_3_c10_b2, rcvalue99_4_c10_b2, rcvalue99_5_c10_b2, rcvalue99_6_c10_b2, rcvalue99_7_c10_b2, rcvalue99_8_c10_b2, rcvalue99_9_c10_b2, rcvalue99_10_c10_b2, rcvalue99_11_c10_b2, rcvalue99_12_c10_b2, rcvalue99_13_c10_b2, rcvalue99_14_c10_b2, rcvalue99_15_c10_b2, rcvalue99_16_c10_b2, rcvalue99_17_c10_b2));

rcvalue9s := if(dobpop, glrc9s * sum(rcvalue9s_1_c10_b1, rcvalue9s_2_c10_b1, rcvalue9s_3_c10_b1), glrc9s * sum(rcvalue9s_1_c10_b2, rcvalue9s_2_c10_b2, rcvalue9s_3_c10_b2, rcvalue9s_4_c10_b2));

rcvalueev := if(dobpop, (integer)glrcev * sum(rcvalueev_1_c10_b1, rcvalueev_2_c10_b1), (integer)glrcev * sum(rcvalueev_1_c10_b2, rcvalueev_2_c10_b2));

rcvalue49 := if(dobpop, (integer)glrc49 * sum(rcvalue49_1_c10_b1), (integer)glrc49 * sum(rcvalue49_1_c10_b2));

rcvalue9m := if(dobpop, (integer)glrc9m * sum(rcvalue9m_1_c10_b1, rcvalue9m_2_c10_b1, rcvalue9m_3_c10_b1, rcvalue9m_4_c10_b1, rcvalue9m_5_c10_b1, rcvalue9m_6_c10_b1, rcvalue9m_7_c10_b1, rcvalue9m_8_c10_b1, rcvalue9m_9_c10_b1), (integer)glrc9m * sum(rcvalue9m_1_c10_b2, rcvalue9m_2_c10_b2, rcvalue9m_3_c10_b2, rcvalue9m_4_c10_b2, rcvalue9m_5_c10_b2, rcvalue9m_6_c10_b2, rcvalue9m_7_c10_b2, rcvalue9m_8_c10_b2, rcvalue9m_9_c10_b2, rcvalue9m_10_c10_b2));

rcvalue9a := if(dobpop, (integer)glrc9a * sum(rcvalue9a_1_c10_b1, rcvalue9a_2_c10_b1, rcvalue9a_3_c10_b1), (integer)glrc9a * sum(rcvalue9a_1_c10_b2, rcvalue9a_2_c10_b2, rcvalue9a_3_c10_b2));

rcvalue9v := if(dobpop, glrc9v * sum(rcvalue9v_1_c10_b1, rcvalue9v_2_c10_b1, rcvalue9v_3_c10_b1), glrc9v * sum(rcvalue9v_1_c10_b2, rcvalue9v_2_c10_b2));

rcvalue9o := if(dobpop, (integer)glrc9o * sum(rcvalue9o_1_c10_b1, rcvalue9o_2_c10_b1), (integer)glrc9o * sum(rcvalue9o_1_c10_b2, rcvalue9o_2_c10_b2));

rcvalue28 := if(dobpop, (integer)glrc28 * sum(rcvalue28_1_c10_b1, rcvalue28_2_c10_b1, rcvalue28_3_c10_b1, rcvalue28_4_c10_b1), NULL);

rcvalue9u := if(dobpop, (integer)glrc9u * sum(rcvalue9u_1_c10_b1, rcvalue9u_2_c10_b1, rcvalue9u_3_c10_b1), (integer)glrc9u * sum(rcvalue9u_1_c10_b2, rcvalue9u_2_c10_b2));

rcvalue25 := if(dobpop, (integer)glrc25 * sum(rcvalue25_1_c10_b1, rcvalue25_2_c10_b1, rcvalue25_3_c10_b1, rcvalue25_4_c10_b1), (integer)glrc25 * sum(rcvalue25_1_c10_b2, rcvalue25_2_c10_b2, rcvalue25_3_c10_b2, rcvalue25_4_c10_b2));

rcvalue97 := if(dobpop, (integer)glrc97 * sum(rcvalue97_1_c10_b1, rcvalue97_2_c10_b1), (integer)glrc97 * sum(rcvalue97_1_c10_b2, rcvalue97_2_c10_b2));

rcvalue9g := if(dobpop, (integer)glrc9g * sum(rcvalue9g_1_c10_b1, rcvalue9g_2_c10_b1, rcvalue9g_3_c10_b1, rcvalue9g_4_c10_b1), (integer)glrc9g * sum(rcvalue9g_1_c10_b2, rcvalue9g_2_c10_b2, rcvalue9g_3_c10_b2));

rcvalue26 := if(dobpop, NULL, glrc26 * sum(rcvalue26_1_c10_b2));

rcvalue9t := if(dobpop, glrc9t * sum(rcvalue9t_1_c10_b1, rcvalue9t_2_c10_b1, rcvalue9t_3_c10_b1, rcvalue9t_4_c10_b1, rcvalue9t_5_c10_b1, rcvalue9t_6_c10_b1, rcvalue9t_7_c10_b1), glrc9t * sum(rcvalue9t_1_c10_b2, rcvalue9t_2_c10_b2, rcvalue9t_3_c10_b2, rcvalue9t_4_c10_b2, rcvalue9t_5_c10_b2, rcvalue9t_6_c10_b2, rcvalue9t_7_c10_b2));

rcvalue37 := if(dobpop, glrc37 * sum(rcvalue37_1_c10_b1, rcvalue37_2_c10_b1, rcvalue37_3_c10_b1, rcvalue37_4_c10_b1, rcvalue37_5_c10_b1), glrc37 * sum(rcvalue37_1_c10_b2, rcvalue37_2_c10_b2, rcvalue37_3_c10_b2, rcvalue37_4_c10_b2, rcvalue37_5_c10_b2));

rcvalue9w := if(dobpop, (integer)glrc9w * sum(rcvalue9w_1_c10_b1, rcvalue9w_2_c10_b1), (integer)glrc9w * sum(rcvalue9w_1_c10_b2, rcvalue9w_2_c10_b2));

rcvalue74 := if(dobpop, glrc74 * sum(rcvalue74_1_c10_b1, rcvalue74_2_c10_b1, rcvalue74_3_c10_b1), glrc74 * sum(rcvalue74_1_c10_b2, rcvalue74_2_c10_b2, rcvalue74_3_c10_b2));

rcvaluems := if(dobpop, (integer)glrcms * sum(rcvaluems_1_c10_b1, rcvaluems_2_c10_b1, rcvaluems_3_c10_b1, rcvaluems_4_c10_b1, rcvaluems_5_c10_b1, rcvaluems_6_c10_b1, rcvaluems_7_c10_b1), (integer)glrcms * sum(rcvaluems_1_c10_b2, rcvaluems_2_c10_b2, rcvaluems_3_c10_b2, rcvaluems_4_c10_b2, rcvaluems_5_c10_b2, rcvaluems_6_c10_b2, rcvaluems_7_c10_b2));

rcvalue36 := if(dobpop, glrc36 * sum(rcvalue36_1_c10_b1, rcvalue36_2_c10_b1, rcvalue36_3_c10_b1, rcvalue36_4_c10_b1, rcvalue36_5_c10_b1, rcvalue36_6_c10_b1, rcvalue36_7_c10_b1, rcvalue36_8_c10_b1, rcvalue36_9_c10_b1, rcvalue36_10_c10_b1, rcvalue36_11_c10_b1, rcvalue36_12_c10_b1, rcvalue36_13_c10_b1, rcvalue36_14_c10_b1, rcvalue36_15_c10_b1, rcvalue36_16_c10_b1, rcvalue36_17_c10_b1, rcvalue36_18_c10_b1, rcvalue36_19_c10_b1, rcvalue36_20_c10_b1, rcvalue36_21_c10_b1), glrc36 * sum(rcvalue36_1_c10_b2, rcvalue36_2_c10_b2, rcvalue36_3_c10_b2, rcvalue36_4_c10_b2, rcvalue36_5_c10_b2, rcvalue36_6_c10_b2, rcvalue36_7_c10_b2, rcvalue36_8_c10_b2, rcvalue36_9_c10_b2, rcvalue36_10_c10_b2, rcvalue36_11_c10_b2, rcvalue36_12_c10_b2, rcvalue36_13_c10_b2, rcvalue36_14_c10_b2, rcvalue36_15_c10_b2, rcvalue36_16_c10_b2, rcvalue36_17_c10_b2, rcvalue36_18_c10_b2, rcvalue36_19_c10_b2, rcvalue36_20_c10_b2, rcvalue36_21_c10_b2, rcvalue36_22_c10_b2, rcvalue36_23_c10_b2));

rcvalue9h := if(dobpop, (integer)glrc9h * sum(rcvalue9h_1_c10_b1), (integer)glrc9h * sum(rcvalue9h_1_c10_b2));

rcvalue9e := if(dobpop, glrc9e * sum(rcvalue9e_1_c10_b1, rcvalue9e_2_c10_b1), glrc9e * sum(rcvalue9e_1_c10_b2, rcvalue9e_2_c10_b2));

rcvalue9q := if(dobpop, (integer)glrc9q * sum(rcvalue9q_1_c10_b1, rcvalue9q_2_c10_b1, rcvalue9q_3_c10_b1, rcvalue9q_4_c10_b1, rcvalue9q_5_c10_b1, rcvalue9q_6_c10_b1, rcvalue9q_7_c10_b1, rcvalue9q_8_c10_b1, rcvalue9q_9_c10_b1, rcvalue9q_10_c10_b1), (integer)glrc9q * sum(rcvalue9q_1_c10_b2, rcvalue9q_2_c10_b2, rcvalue9q_3_c10_b2, rcvalue9q_4_c10_b2, rcvalue9q_5_c10_b2, rcvalue9q_6_c10_b2, rcvalue9q_7_c10_b2, rcvalue9q_8_c10_b2, rcvalue9q_9_c10_b2, rcvalue9q_10_c10_b2));


ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
	{'MI', rcvaluemi},
	{'27', rcvalue27},
	{'9R', rcvalue9r},
	{'9D', rcvalue9d},
	{'98', rcvalue98},
	{'PV', rcvaluepv},
	{'99', rcvalue99},
	{'9S', rcvalue9s},
	{'EV', rcvalueev},
	{'49', rcvalue49},
	{'9M', rcvalue9m},
	{'9A', rcvalue9a},
	{'9V', rcvalue9v},
	{'9O', rcvalue9o},
	{'28', rcvalue28},
	{'9U', rcvalue9u},
	{'25', rcvalue25},
	{'97', rcvalue97},
	{'9G', rcvalue9g},
	{'26', rcvalue26},
	{'9T', rcvalue9t},
	{'37', rcvalue37},
	{'9W', rcvalue9w},
	{'74', rcvalue74},
	{'MS', rcvaluems},
	{'36', rcvalue36},
	{'9H', rcvalue9h},
	{'9E', rcvalue9e},
	{'9Q', rcvalue9q}
	], ds_layout )( value > 0 );

	rcs_top4 := choosen( sort(rc_dataset,-value), 4 ); // take the top four reason codes

	rcs_9q := rcs_top4 &
		if( not exists(rcs_top4(rc='9Q')) and 
			(
				(segment_x and x_inq_count12_3 > 0) or 
				(segment_o and o_inq_count12_2 > 0) or 
				(segment_d and d_inq_noncoll_count_3 > 0)
			),
			dataset( [{'9Q',NULL}], ds_layout )
		)
	;

	rcs_override := map(
		rva1104_0_0 = 200 => dataset( [{'02', NULL}], ds_layout ),
		rva1104_0_0 = 222 => dataset( [{'9X', NULL}], ds_layout ),
		segment_x and not exists(rcs_9q) => dataset( [{'9A', NULL}], ds_layout ),
		segment_y and not exists(rcs_9q) => dataset( [{'9G', NULL}], ds_layout ),
		not exists(rcs_9q) => dataset( [{'36', NULL}], ds_layout  ),
		rcs_9q
	);


		#if(RVA_DEBUG)
			self.clam := le;
			self.truedid := truedid;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_bansflag := rc_bansflag;
			self.rc_addrmiskeyflag := rc_addrmiskeyflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_statezipflag := rc_statezipflag;
			self.combo_fnamescore := combo_fnamescore;
			self.combo_lnamescore := combo_lnamescore;
			self.combo_addrscore := combo_addrscore;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_lnamecount := combo_lnamecount;
			self.combo_addrcount := combo_addrcount;
			self.combo_hphonecount := combo_hphonecount;
			self.combo_ssncount := combo_ssncount;
			self.combo_dobcount := combo_dobcount;
			self.ver_sources := ver_sources;
			self.ver_sources_nas := ver_sources_nas;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_sources_last_seen := ver_sources_last_seen;
			self.ver_sources_count := ver_sources_count;
			self.dobpop := dobpop;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_automated_valuation_3 := add1_avm_automated_valuation_3;
			self.add1_avm_automated_valuation_4 := add1_avm_automated_valuation_4;
			self.add1_avm_automated_valuation_5 := add1_avm_automated_valuation_5;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_amount := add1_purchase_amount;
			self.add1_financing_type := add1_financing_type;
			self.add1_building_area := add1_building_area;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.add2_advo_address_vacancy := add2_advo_address_vacancy;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.avg_mo_per_addr := avg_mo_per_addr;
			self.hist_addr_match := hist_addr_match;
			self.telcordia_type := telcordia_type;
			self.gong_did_first_seen := gong_did_first_seen;
			self.gong_did_last_seen := gong_did_last_seen;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_addr_ct := gong_did_addr_ct;
			self.gong_did_last_ct := gong_did_last_ct;
			self.ssns_per_adl := ssns_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.lnames_per_adl_c6 := lnames_per_adl_c6;
			self.adls_per_ssn_c6 := adls_per_ssn_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.invalid_ssns_per_adl := invalid_ssns_per_adl;
			self.inq_last_log_date := inq_last_log_date;
			self.inq_count01 := inq_count01;
			self.inq_count03 := inq_count03;
			self.inq_count06 := inq_count06;
			self.inq_count12 := inq_count12;
			self.inq_collection_count01 := inq_collection_count01;
			self.inq_collection_count03 := inq_collection_count03;
			self.inq_collection_count06 := inq_collection_count06;
			self.inq_collection_count12 := inq_collection_count12;
			self.inq_addrsperadl := inq_addrsperadl;
			self.inq_ssnsperaddr := inq_ssnsperaddr;
			self.inq_perphone := inq_perphone;
			self.inq_adlsperphone := inq_adlsperphone;
			self.paw_business_count := paw_business_count;
			self.paw_dead_business_count := paw_dead_business_count;
			self.paw_active_phone_count := paw_active_phone_count;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_domain_isp_count := email_domain_isp_count;
			self.email_domain_edu_count := email_domain_edu_count;
			self.email_domain_corp_count := email_domain_corp_count;
			self.email_source_list := email_source_list;
			self.email_source_count := email_source_count;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.bankrupt := bankrupt;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_last_unrel_date := liens_last_unrel_date;
			self.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_age := input_dob_age;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.estimated_income := estimated_income;
			self.archive_date := archive_date;

			self.today                            := today;
			self.est_age                          := est_age;
			self.hist_addr_match_n                := hist_addr_match_n;
			self.add1_vacant_address              := add1_vacant_address;
			self.add2_vacant_address              := add2_vacant_address;
			self.property_owned_ind               := property_owned_ind;
			self.rc_ssnlowissue2                  := rc_ssnlowissue2;
			self.time_since_ssnlowissue           := time_since_ssnlowissue;
			self.rc_ssnlowissue_sas               := rc_ssnlowissue_sas;
			self.in_dob_sas                       := in_dob_sas;
			self.age_at_ssnlowissue               := age_at_ssnlowissue;
			self.gong_did_first_seen2             := gong_did_first_seen2;
			self.mosince_gong_did_ls              := mosince_gong_did_ls;
			self.gong_did_first_seen_sas          := gong_did_first_seen_sas;
			self.gong_did_last_seen_sas           := gong_did_last_seen_sas;
			self.time_on_gong                     := time_on_gong;
			self.inq_last_log_date2               := inq_last_log_date2;
			self.mosince_inq_last_log             := mosince_inq_last_log;
			self.criminal_last_date2              := criminal_last_date2;
			self.mosince_criminal_ls              := mosince_criminal_ls;
			self.liens_last_unrel_date2           := liens_last_unrel_date2;
			self.mosince_liens_unrel_ls           := mosince_liens_unrel_ls;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mosince_eviction_ls              := mosince_eviction_ls;
			self.tot_ak_pos                       := tot_ak_pos;
			self.tot_cnt_ak                       := tot_cnt_ak;
			self.tot_am_pos                       := tot_am_pos;
			self.tot_cnt_am                       := tot_cnt_am;
			self.tot_ar_pos                       := tot_ar_pos;
			self.tot_cnt_ar                       := tot_cnt_ar;
			self.tot_ba_pos                       := tot_ba_pos;
			self.tot_cnt_ba                       := tot_cnt_ba;
			self.tot_cg_pos                       := tot_cg_pos;
			self.tot_cnt_cg                       := tot_cnt_cg;
			self.tot_co_pos                       := tot_co_pos;
			self.tot_cnt_co                       := tot_cnt_co;
			self.tot_cy_pos                       := tot_cy_pos;
			self.tot_cnt_cy                       := tot_cnt_cy;
			self.tot_da_pos                       := tot_da_pos;
			self.tot_cnt_da                       := tot_cnt_da;
			self.tot_d_pos                        := tot_d_pos;
			self.tot_cnt_d                        := tot_cnt_d;
			self.tot_dl_pos                       := tot_dl_pos;
			self.tot_cnt_dl                       := tot_cnt_dl;
			self.tot_ds_pos                       := tot_ds_pos;
			self.tot_cnt_ds                       := tot_cnt_ds;
			self.tot_de_pos                       := tot_de_pos;
			self.tot_cnt_de                       := tot_cnt_de;
			self.tot_eb_pos                       := tot_eb_pos;
			self.tot_cnt_eb                       := tot_cnt_eb;
			self.tot_em_pos                       := tot_em_pos;
			self.tot_nas_em                       := tot_nas_em;
			self.tot_cnt_em                       := tot_cnt_em;
			self.tot_en_pos                       := tot_en_pos;
			self.tot_cnt_en                       := tot_cnt_en;
			self.tot_eq_pos                       := tot_eq_pos;
			self.tot_nas_eq                       := tot_nas_eq;
			self.tot_fdate_eq                     := tot_fdate_eq;
			self.tot_fdate_eq2                    := tot_fdate_eq2;
			self.tot_mosince_fdate_eq             := tot_mosince_fdate_eq;
			self.tot_ldate_eq                     := tot_ldate_eq;
			self.tot_ldate_eq2                    := tot_ldate_eq2;
			self.tot_mosince_ldate_eq             := tot_mosince_ldate_eq;
			self.tot_cnt_eq                       := tot_cnt_eq;
			self.tot_fe_pos                       := tot_fe_pos;
			self.tot_cnt_fe                       := tot_cnt_fe;
			self.tot_ff_pos                       := tot_ff_pos;
			self.tot_cnt_ff                       := tot_cnt_ff;
			self.tot_fr_pos                       := tot_fr_pos;
			self.tot_cnt_fr                       := tot_cnt_fr;
			self.tot_l2_pos                       := tot_l2_pos;
			self.tot_ldate_l2                     := tot_ldate_l2;
			self.tot_ldate_l22                    := tot_ldate_l22;
			self.tot_mosince_ldate_l2             := tot_mosince_ldate_l2;
			self.tot_cnt_l2                       := tot_cnt_l2;
			self.tot_li_pos                       := tot_li_pos;
			self.tot_cnt_li                       := tot_cnt_li;
			self.tot_mw_pos                       := tot_mw_pos;
			self.tot_cnt_mw                       := tot_cnt_mw;
			self.tot_nt_pos                       := tot_nt_pos;
			self.tot_cnt_nt                       := tot_cnt_nt;
			self.tot_p_pos                        := tot_p_pos;
			self.tot_nas_p                        := tot_nas_p;
			self.tot_cnt_p                        := tot_cnt_p;
			self.tot_pl_pos                       := tot_pl_pos;
			self.tot_cnt_pl                       := tot_cnt_pl;
			self.tot_ts_pos                       := tot_ts_pos;
			self.tot_nas_ts                       := tot_nas_ts;
			self.tot_cnt_ts                       := tot_cnt_ts;
			self.tot_tu_pos                       := tot_tu_pos;
			self.tot_cnt_tu                       := tot_cnt_tu;
			self.tot_sl_pos                       := tot_sl_pos;
			self.tot_cnt_sl                       := tot_cnt_sl;
			self.tot_v_pos                        := tot_v_pos;
			self.tot_cnt_v                        := tot_cnt_v;
			self.tot_vo_pos                       := tot_vo_pos;
			self.tot_nas_vo                       := tot_nas_vo;
			self.tot_cnt_vo                       := tot_cnt_vo;
			self.tot_w_pos                        := tot_w_pos;
			self.tot_cnt_w                        := tot_cnt_w;
			self.tot_wp_pos                       := tot_wp_pos;
			self.tot_nas_wp                       := tot_nas_wp;
			self.tot_cnt_wp                       := tot_cnt_wp;
			self.time_on_eq                       := time_on_eq;
			self.tot_source_ct                    := tot_source_ct;
			self.email_im_pos                     := email_im_pos;
			self.email_cnt_im                     := email_cnt_im;
			self.max_email                        := max_email;
			self.email_cnt_im_ind                 := email_cnt_im_ind;
			self.email_domain_edu_ind             := email_domain_edu_ind;
			self.email_domain_corp_ind            := email_domain_corp_ind;
			self.paw_business_ind                 := paw_business_ind;
			self.paw_dead_business_ind            := paw_dead_business_ind;
			self.paw_active_phone_ind             := paw_active_phone_ind;
			self.inq_noncoll_count01              := inq_noncoll_count01;
			self.inq_noncoll_count03              := inq_noncoll_count03;
			self.inq_noncoll_count06              := inq_noncoll_count06;
			self.inq_noncoll_count12              := inq_noncoll_count12;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.source_tot_l2                    := source_tot_l2;
			self.source_tot_li                    := source_tot_li;
			self.lien_flag                        := lien_flag;
			self.source_tot_ds                    := source_tot_ds;
			self.source_tot_ba                    := source_tot_ba;
			self.bk_flag                          := bk_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.pk_impulse_count                 := pk_impulse_count;
			// self.pk_adl_cat_deceased              := pk_adl_cat_deceased;
			self.bs_attr_derog_flag               := bs_attr_derog_flag;
			self.bs_attr_eviction_flag            := bs_attr_eviction_flag;
			self.prop_owner                       := prop_owner;
			self.segment_d                        := segment_d;
			self.segment_y                        := segment_y;
			self.segment_o                        := segment_o;
			self.segment_x                        := segment_x;
			self.d_vo_addr_ver                    := d_vo_addr_ver;
			self.d_wp_addr_ver                    := d_wp_addr_ver;
			self.d_p_addr_ver_summary_m           := d_p_addr_ver_summary_m;
			self.d_em_addr_ver_summary_m          := d_em_addr_ver_summary_m;
			self.d_eq_nas_ver                     := d_eq_nas_ver;
			self.d_ts_nas_ver                     := d_ts_nas_ver;
			self.d_tot_mosince_fdate_eq_480       := d_tot_mosince_fdate_eq_480;
			self.d_adls_per_addr_c6_4             := d_adls_per_addr_c6_4;
			self.d_phones_per_addr_10             := d_phones_per_addr_10;
			self.d_addrs_per_ssn_25               := d_addrs_per_ssn_25;
			self.d_addrs_per_ssn_c6_2             := d_addrs_per_ssn_c6_2;
			self.d_ssns_per_adl_5                 := d_ssns_per_adl_5;
			self.d_ssns_per_adl_c6_2              := d_ssns_per_adl_c6_2;
			self.d_time_since_ssnlowissue_876     := d_time_since_ssnlowissue_876;
			self.d_lo_combo_ssnscore              := d_lo_combo_ssnscore;
			self.d_ssn_mod                        := d_ssn_mod;
			self.d_time_on_gong_120               := d_time_on_gong_120;
			self.d_rc_disthphoneaddr_200          := d_rc_disthphoneaddr_200;
			self.d_contrary_infutor_nap           := d_contrary_infutor_nap;
			self.d_pnotpots                       := d_pnotpots;
			self.d_hm_disconnected_phone          := d_hm_disconnected_phone;
			self.d_gong_did_phone_ct_6            := d_gong_did_phone_ct_6;
			self.d_hi_gong_did_last_ct            := d_hi_gong_did_last_ct;
			self.d_phoneprob_mod                  := d_phoneprob_mod;
			self.d_verfst_p                       := d_verfst_p;
			self.d_verphn_p                       := d_verphn_p;
			self.d_dob_ver_m                      := d_dob_ver_m;
			self.d_lo_source_ct                   := d_lo_source_ct;
			self.d_ver_mod                        := d_ver_mod;
			self.d_nodob_ver_mod                  := d_nodob_ver_mod;
			self.d_mosince_inq_last_log_12        := d_mosince_inq_last_log_12;
			self.d_inq_noncoll_count_3            := d_inq_noncoll_count_3;
			self.d_inq_noncoll_summary_m          := d_inq_noncoll_summary_m;
			self.d_add1_financing_type_m          := d_add1_financing_type_m;
			self.d_addrs_15yr_20                  := d_addrs_15yr_20;
			self.d_mosince_criminal_ls_84         := d_mosince_criminal_ls_84;
			self.d_mosince_liens_unrel_ls_84      := d_mosince_liens_unrel_ls_84;
			self.d_mosince_eviction_ls_84         := d_mosince_eviction_ls_84;
			self.d_tot_mosince_ldate_l2_240       := d_tot_mosince_ldate_l2_240;
			self.d_bk_dismissed                   := d_bk_dismissed;
			self.d_hi_filing_ct                   := d_hi_filing_ct;
			self.d_bad_bk                         := d_bad_bk;
			self.d_liens_unrel_sc_total_amt_10k   := d_liens_unrel_sc_total_amt_10k;
			self.d_liens_recent_unrel_ct_4        := d_liens_recent_unrel_ct_4;
			self.d_hi_email_ct                    := d_hi_email_ct;
			self.d_email_summary_m                := d_email_summary_m;
			self.d_paw_summary_m                  := d_paw_summary_m;
			self.d_prof_license_category_m        := d_prof_license_category_m;
			self.d_ams_income_summary             := d_ams_income_summary;
			self.d_ams_income_college_m           := d_ams_income_college_m;
			self.d_wealth_index_m                 := d_wealth_index_m;
			self.d_outest_dob                     := d_outest_dob;
			self.d_outest_nodob                   := d_outest_nodob;
			self.d_outest                         := d_outest;
			self.y_eq_nas_ver                     := y_eq_nas_ver;
			self.y_ts_nas_ver                     := y_ts_nas_ver;
			self.y_vo_addr_ver                    := y_vo_addr_ver;
			self.y_time_on_eq_gt_age              := y_time_on_eq_gt_age;
			self.y_time_on_eq_120                 := y_time_on_eq_120;
			self.y_ssns_per_adl_gt1               := y_ssns_per_adl_gt1;
			self.y_adlperssn_count_1_3            := y_adlperssn_count_1_3;
			self.y_addrs_per_ssn_c6_2             := y_addrs_per_ssn_c6_2;
			self.y_ssns_per_addr_50               := y_ssns_per_addr_50;
			self.y_ssns_per_addr_c6_5             := y_ssns_per_addr_c6_5;
			self.y_hm_rc_numelever                := y_hm_rc_numelever;
			self.y_hm_rc_numelever_3_6            := y_hm_rc_numelever_3_6;
			self.y_did_ge2                        := y_did_ge2;
			self.y_dob_ver                        := y_dob_ver;
			self.y_verlst_p                       := y_verlst_p;
			self.y_verphn_p                       := y_verphn_p;
			self.y_ver_mod                        := y_ver_mod;
			self.y_ver_nodob_mod                  := y_ver_nodob_mod;
			self.y_mosince_gong_did_ls_108        := y_mosince_gong_did_ls_108;
			self.y_no_adls_per_phone              := y_no_adls_per_phone;
			self.y_hm_disconnected_phone          := y_hm_disconnected_phone;
			self.y_lo_infutor_nap                 := y_lo_infutor_nap;
			self.y_phoneprob_mod                  := y_phoneprob_mod;
			self.y_est_age_18                     := y_est_age_18;
			self.y_wealth_index_1_4               := y_wealth_index_1_4;
			self.y_wealth_index_m                 := y_wealth_index_m;
			self.y_hi_prof_license_category       := y_hi_prof_license_category;
			self.y_ams_income_summary             := y_ams_income_summary;
			self.y_ams_college_summary            := y_ams_college_summary;
			self.y_ams_income_college_m           := y_ams_income_college_m;
			self.y_hi_email_ct                    := y_hi_email_ct;
			self.y_email_summary_m                := y_email_summary_m;
			self.y_paw_summary_m                  := y_paw_summary_m;
			self.y_inq_addrsperadl_2              := y_inq_addrsperadl_2;
			self.y_inq_adlsperphone_2             := y_inq_adlsperphone_2;
			self.y_hr_add1_financing_type         := y_hr_add1_financing_type;
			self.y_avg_mo_per_addr_60             := y_avg_mo_per_addr_60;
			self.y_addr_vacant_summary_m          := y_addr_vacant_summary_m;
			self.y_add1_ownership_m               := y_add1_ownership_m;
			self.y_lo_addr_score                  := y_lo_addr_score;
			self.y_hm_invalid_addr                := y_hm_invalid_addr;
			self.y_old_addr_match_input           := y_old_addr_match_input;
			self.y_no_addr_match_input            := y_no_addr_match_input;
			self.y_addr_prob_summary              := y_addr_prob_summary;
			self.y_addr_prob_summary_m            := y_addr_prob_summary_m;
			self.y_outest_nodob                   := y_outest_nodob;
			self.y_outest_dob                     := y_outest_dob;
			self.y_outest                         := y_outest;
			self.o_hm_rc_numelever                := o_hm_rc_numelever;
			self.o_hm_rc_numelever_4_6            := o_hm_rc_numelever_4_6;
			self.o_hm_rc_numelever_nodob          := o_hm_rc_numelever_nodob;
			self.o_hm_rc_numelever_nodob_3_5      := o_hm_rc_numelever_nodob_3_5;
			self.o_lname_ver                      := o_lname_ver;
			self.o_dob_ver                        := o_dob_ver;
			self.o_infutor_ver                    := o_infutor_ver;
			self.o_verfst_p                       := o_verfst_p;
			self.o_verphn_p                       := o_verphn_p;
			self.o_vo_addr_ver                    := o_vo_addr_ver;
			self.o_wp_addr_ver                    := o_wp_addr_ver;
			self.o_ts_nas_ver                     := o_ts_nas_ver;
			self.o_did_ge2                        := o_did_ge2;
			self.o_ver_mod                        := o_ver_mod;
			self.o_ver_nodob_mod                  := o_ver_nodob_mod;
			self.o_tot_source_ct_2_7              := o_tot_source_ct_2_7;
			self.o_tot_mosince_fdate_eq_360       := o_tot_mosince_fdate_eq_360;
			self.o_mosince_gong_did_ls_110        := o_mosince_gong_did_ls_110;
			self.o_no_adls_per_phone              := o_no_adls_per_phone;
			self.o_hm_disconnected_phone          := o_hm_disconnected_phone;
			self.o_pnotpots                       := o_pnotpots;
			self.o_no_gong_did_addr               := o_no_gong_did_addr;
			self.o_lo_infutor_nap                 := o_lo_infutor_nap;
			self.o_hi_gong_did_last_ct            := o_hi_gong_did_last_ct;
			self.o_phoneprob_mod                  := o_phoneprob_mod;
			self.o_invalid_ssns_per_adl_ind       := o_invalid_ssns_per_adl_ind;
			self.o_invalid_ssn                    := o_invalid_ssn;
			self.o_lo_combo_ssnscore              := o_lo_combo_ssnscore;
			self.o_invalid_ssns_flag              := o_invalid_ssns_flag;
			self.o_ssn_issued_too_young_or_hi     := o_ssn_issued_too_young_or_hi;
			self.o_ssns_per_adl_gt2               := o_ssns_per_adl_gt2;
			self.o_ssns_per_adl_c6_2              := o_ssns_per_adl_c6_2;
			self.o_time_since_ssnlowissue_480     := o_time_since_ssnlowissue_480;
			self.o_ssn_mod                        := o_ssn_mod;
			self.o_ssn_mod_nodob                  := o_ssn_mod_nodob;
			self.o_estimated_income_200k          := o_estimated_income_200k;
			self.o_wealth_index_5                 := o_wealth_index_5;
			self.o_wealth_index_m                 := o_wealth_index_m;
			self.o_ams_income_summary             := o_ams_income_summary;
			self.o_ams_college_summary            := o_ams_college_summary;
			self.o_ams_income_college_m           := o_ams_income_college_m;
			self.o_prof_license_cat_m             := o_prof_license_cat_m;
			self.o_hi_email_ct                    := o_hi_email_ct;
			self.o_email_summary_m                := o_email_summary_m;
			self.o_paw_summary_m                  := o_paw_summary_m;
			self.o_inq_count12_2                  := o_inq_count12_2;
			self.o_inq_ssnsperaddr_2              := o_inq_ssnsperaddr_2;
			self.o_inq_adlsperphone_2             := o_inq_adlsperphone_2;
			self.o_hr_add1_financing_type         := o_hr_add1_financing_type;
			self.o_no_adls_per_addr               := o_no_adls_per_addr;
			self.o_no_addr_match_input            := o_no_addr_match_input;
			self.o_lo_addr_score                  := o_lo_addr_score;
			self.o_addr_vacant_summary_m          := o_addr_vacant_summary_m;
			self.o_addrprob_mod                   := o_addrprob_mod;
			self.o_attr_addrs_last36_6            := o_attr_addrs_last36_6;
			self.o_add1_price_per_sqf             := o_add1_price_per_sqf;
			self.o_add1_price_per_sqf_300         := o_add1_price_per_sqf_300;
			self.o_avg_add1_avm_val_300k          := o_avg_add1_avm_val_300k;
			self.o_add1_ownership_m               := o_add1_ownership_m;
			self.o_address_recency                := o_address_recency;
			self.o_address_recency_m              := o_address_recency_m;
			self.o_addrs_per_ssn_25               := o_addrs_per_ssn_25;
			self.o_addrs_per_ssn_c6_2             := o_addrs_per_ssn_c6_2;
			self.o_adls_per_addr_10               := o_adls_per_addr_10;
			self.o_ssns_per_addr_35               := o_ssns_per_addr_35;
			self.o_adls_per_addr_c6_3             := o_adls_per_addr_c6_3;
			self.o_outest_nodob                   := o_outest_nodob;
			self.o_outest_dob                     := o_outest_dob;
			self.o_outest                         := o_outest;
			self.x_did_ge2                        := x_did_ge2;
			self.x_fname_ver                      := x_fname_ver;
			self.x_addr_ver                       := x_addr_ver;
			self.x_ssn_ver                        := x_ssn_ver;
			self.x_dob_ver                        := x_dob_ver;
			self.x_verphn_p                       := x_verphn_p;
			self.x_wp_addr_ver                    := x_wp_addr_ver;
			self.x_vo_addr_ver                    := x_vo_addr_ver;
			self.x_eq_nas_ver                     := x_eq_nas_ver;
			self.x_ts_nas_ver                     := x_ts_nas_ver;
			self.x_p_addr_ver_summary_m           := x_p_addr_ver_summary_m;
			self.x_ver_mod                        := x_ver_mod;
			self.x_ver_nodob_mod                  := x_ver_nodob_mod;
			self.x_mosince_gong_did_ls_110        := x_mosince_gong_did_ls_110;
			self.x_no_adls_per_phone              := x_no_adls_per_phone;
			self.x_pnotpots                       := x_pnotpots;
			self.x_hm_disconnected_phone          := x_hm_disconnected_phone;
			self.x_no_gong_did_addr               := x_no_gong_did_addr;
			self.x_phoneprob_mod                  := x_phoneprob_mod;
			self.x_ssn_issued_too_young_or_hi     := x_ssn_issued_too_young_or_hi;
			self.x_lo_combo_ssnscore              := x_lo_combo_ssnscore;
			self.x_ssns_per_adl_c6_2              := x_ssns_per_adl_c6_2;
			self.x_ssns_per_adl_gt1               := x_ssns_per_adl_gt1;
			self.x_invalid_ssn                    := x_invalid_ssn;
			self.x_ssn_mod                        := x_ssn_mod;
			self.x_ssn_mod_nodob                  := x_ssn_mod_nodob;
			self.x_estimated_income_125k          := x_estimated_income_125k;
			self.x_ams_income_summary             := x_ams_income_summary;
			self.x_ams_college_summary            := x_ams_college_summary;
			self.x_ams_income_college_m           := x_ams_income_college_m;
			self.x_hi_prof_license_category       := x_hi_prof_license_category;
			self.x_hi_email_ct                    := x_hi_email_ct;
			self.x_email_summary_m                := x_email_summary_m;
			self.x_inq_count12_3                  := x_inq_count12_3;
			self.x_inq_ssnsperaddr_2              := x_inq_ssnsperaddr_2;
			self.x_inq_perphone_2                 := x_inq_perphone_2;
			self.x_hr_add1_financing_type         := x_hr_add1_financing_type;
			self.x_tot_mosince_fdate_eq_360       := x_tot_mosince_fdate_eq_360;
			self.x_hi_ssns_per_adl_c6             := x_hi_ssns_per_adl_c6;
			self.x_hi_addrs_per_adl_c6            := x_hi_addrs_per_adl_c6;
			self.x_hi_lnames_per_adl_c6           := x_hi_lnames_per_adl_c6;
			self.x_adls_per_ssn_c6_ind            := x_adls_per_ssn_c6_ind;
			self.x_addrs_per_ssn_c6_ind           := x_addrs_per_ssn_c6_ind;
			self.x_hi_adls_per_addr_c6            := x_hi_adls_per_addr_c6;
			self.x_hi_ssns_per_addr_c6            := x_hi_ssns_per_addr_c6;
			self.x_too_recent_velocity            := x_too_recent_velocity;
			self.x_addrs_per_ssn_25               := x_addrs_per_ssn_25;
			self.x_adls_per_addr_50               := x_adls_per_addr_50;
			self.x_outest_nodob                   := x_outest_nodob;
			self.x_outest_dob                     := x_outest_dob;
			self.x_outest                         := x_outest;
			self.outest                           := outest;
			self.phat                             := phat;
			self.score                            := score;
			self.ov_ssnprior                      := ov_ssnprior;
			self.ov_criminal_flag                 := ov_criminal_flag;
			self.ov_corrections                   := ov_corrections;
			self.ov_impulse                       := ov_impulse;
			self.scored_222s                      := scored_222s;
			self.rva1104_0_0                      := rva1104_0_0;

			// new fields to handle 4/22/11 updated code:
			SELF.tot_nas_EN := tot_nas_EN;
			SELF.tot_nas_E1 := tot_nas_E1;
			SELF.tot_nas_E2 := tot_nas_E2;
			SELF.tot_nas_E3 := tot_nas_E3;
			SELF.tot_nas_E4 := tot_nas_E4;
			SELF.tot_fdate_en := tot_fdate_en;
			SELF.tot_fdate_en2 := tot_fdate_en2;
			SELF.tot_mosince_fdate_eq_a := tot_mosince_fdate_eq_a;
			SELF.tot_mosince_fdate_EN := tot_mosince_fdate_EN;
			SELF.tot_ldate_en := tot_ldate_en;
			SELF.tot_ldate_en2 := tot_ldate_en2;
			SELF.tot_mosince_ldate_eq_a := tot_mosince_ldate_eq_a;
			SELF.tot_mosince_ldate_EN := tot_mosince_ldate_EN;
			SELF.tot_cnt_eq_a := tot_cnt_eq_a;
			
			// REASONS
			self.addrpop := addrpop;
			self.in_phone10 := in_phone10;
			self.add2_naprop := add2_naprop;
			self.header_first_seen := header_first_seen;
			self.add1_eda_sourced := add1_eda_sourced;
			self.rc_dwelltype := rc_dwelltype;
			self.add3_naprop := add3_naprop;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add3_applicant_owned := add3_applicant_owned;
			self.add2_family_owned := add2_family_owned;
			self.add3_family_owned := add3_family_owned;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_assessed_total_value := add1_assessed_total_value;
			self.property_ambig_total := property_ambig_total;
			self.felony_count := felony_count;
			self.glrc3 := glrc3;
			self.glrc7 := glrc7;
			self.glrc20 := glrc20;
			self.glrc25 := glrc25;
			self.glrc26 := glrc26;
			self.glrc27 := glrc27;
			self.glrc28 := glrc28;
			self.glrc36 := glrc36;
			self.glrc37 := glrc37;
			self.glrc49 := glrc49;
			self.glrc74 := glrc74;
			self.glrc97 := glrc97;
			self.glrc98 := glrc98;
			self.glrc99 := glrc99;
			self.glrc9a := glrc9a;
			self.glrc9d := glrc9d;
			self.glrc9e := glrc9e;
			self.glrc9g := glrc9g;
			self.glrc9h := glrc9h;
			self.glrc9i := glrc9i;
			self.header_first_seen2 := header_first_seen2;
			self.mosince_header_first_seen := mosince_header_first_seen;
			self.glrc9j := glrc9j;
			self.glrc9o := glrc9o;
			self.glrc9q := glrc9q;
			self.glrc9s := glrc9s;
			self.glrcev := glrcev;
			self.glrcmi := glrcmi;
			self.glrcms := glrcms;
			self.aptflag_1 := aptflag_1;
			self.aptflag := aptflag;
			self.add1_econval := add1_econval;
			self.add1_aptval := add1_aptval;
			self.add1_econcode := add1_econcode;
			self.glrcpv := glrcpv;
			self.glrc9m := glrc9m;
			self.glrc9r := glrc9r;
			self.glrc9t := glrc9t;
			self.glrc9u := glrc9u;
			self.glrc9v := glrc9v;
			self.glrc9w := glrc9w;
			self.rcvalue25_1_c10_b1 := rcvalue25_1_c10_b1;
			self.rcvalue25_2_c10_b1 := rcvalue25_2_c10_b1;
			self.rcvalue25_3_c10_b1 := rcvalue25_3_c10_b1;
			self.rcvalue25_4_c10_b1 := rcvalue25_4_c10_b1;
			self.rcvalue27_1_c10_b1 := rcvalue27_1_c10_b1;
			self.rcvalue27_2_c10_b1 := rcvalue27_2_c10_b1;
			self.rcvalue27_3_c10_b1 := rcvalue27_3_c10_b1;
			self.rcvalue27_4_c10_b1 := rcvalue27_4_c10_b1;
			self.rcvalue27_5_c10_b1 := rcvalue27_5_c10_b1;
			self.rcvalue27_6_c10_b1 := rcvalue27_6_c10_b1;
			self.rcvalue27_7_c10_b1 := rcvalue27_7_c10_b1;
			self.rcvalue28_1_c10_b1 := rcvalue28_1_c10_b1;
			self.rcvalue28_2_c10_b1 := rcvalue28_2_c10_b1;
			self.rcvalue28_3_c10_b1 := rcvalue28_3_c10_b1;
			self.rcvalue28_4_c10_b1 := rcvalue28_4_c10_b1;
			self.rcvalue36_1_c10_b1 := rcvalue36_1_c10_b1;
			self.rcvalue36_2_c10_b1 := rcvalue36_2_c10_b1;
			self.rcvalue36_3_c10_b1 := rcvalue36_3_c10_b1;
			self.rcvalue36_4_c10_b1 := rcvalue36_4_c10_b1;
			self.rcvalue36_5_c10_b1 := rcvalue36_5_c10_b1;
			self.rcvalue36_6_c10_b1 := rcvalue36_6_c10_b1;
			self.rcvalue36_7_c10_b1 := rcvalue36_7_c10_b1;
			self.rcvalue36_8_c10_b1 := rcvalue36_8_c10_b1;
			self.rcvalue36_9_c10_b1 := rcvalue36_9_c10_b1;
			self.rcvalue36_10_c10_b1 := rcvalue36_10_c10_b1;
			self.rcvalue36_11_c10_b1 := rcvalue36_11_c10_b1;
			self.rcvalue36_12_c10_b1 := rcvalue36_12_c10_b1;
			self.rcvalue36_13_c10_b1 := rcvalue36_13_c10_b1;
			self.rcvalue36_14_c10_b1 := rcvalue36_14_c10_b1;
			self.rcvalue36_15_c10_b1 := rcvalue36_15_c10_b1;
			self.rcvalue36_16_c10_b1 := rcvalue36_16_c10_b1;
			self.rcvalue36_17_c10_b1 := rcvalue36_17_c10_b1;
			self.rcvalue36_18_c10_b1 := rcvalue36_18_c10_b1;
			self.rcvalue36_19_c10_b1 := rcvalue36_19_c10_b1;
			self.rcvalue36_20_c10_b1 := rcvalue36_20_c10_b1;
			self.rcvalue36_21_c10_b1 := rcvalue36_21_c10_b1;
			self.rcvalue37_1_c10_b1 := rcvalue37_1_c10_b1;
			self.rcvalue37_2_c10_b1 := rcvalue37_2_c10_b1;
			self.rcvalue37_3_c10_b1 := rcvalue37_3_c10_b1;
			self.rcvalue37_4_c10_b1 := rcvalue37_4_c10_b1;
			self.rcvalue37_5_c10_b1 := rcvalue37_5_c10_b1;
			self.rcvalue49_1_c10_b1 := rcvalue49_1_c10_b1;
			self.rcvalue74_1_c10_b1 := rcvalue74_1_c10_b1;
			self.rcvalue74_2_c10_b1 := rcvalue74_2_c10_b1;
			self.rcvalue74_3_c10_b1 := rcvalue74_3_c10_b1;
			self.rcvalue97_1_c10_b1 := rcvalue97_1_c10_b1;
			self.rcvalue97_2_c10_b1 := rcvalue97_2_c10_b1;
			self.rcvalue98_1_c10_b1 := rcvalue98_1_c10_b1;
			self.rcvalue98_2_c10_b1 := rcvalue98_2_c10_b1;
			self.rcvalue98_3_c10_b1 := rcvalue98_3_c10_b1;
			self.rcvalue98_4_c10_b1 := rcvalue98_4_c10_b1;
			self.rcvalue99_1_c10_b1 := rcvalue99_1_c10_b1;
			self.rcvalue99_2_c10_b1 := rcvalue99_2_c10_b1;
			self.rcvalue99_3_c10_b1 := rcvalue99_3_c10_b1;
			self.rcvalue99_4_c10_b1 := rcvalue99_4_c10_b1;
			self.rcvalue99_5_c10_b1 := rcvalue99_5_c10_b1;
			self.rcvalue9a_1_c10_b1 := rcvalue9a_1_c10_b1;
			self.rcvalue9a_2_c10_b1 := rcvalue9a_2_c10_b1;
			self.rcvalue9a_3_c10_b1 := rcvalue9a_3_c10_b1;
			self.rcvalue9d_1_c10_b1 := rcvalue9d_1_c10_b1;
			self.rcvalue9d_2_c10_b1 := rcvalue9d_2_c10_b1;
			self.rcvalue9d_3_c10_b1 := rcvalue9d_3_c10_b1;
			self.rcvalue9d_4_c10_b1 := rcvalue9d_4_c10_b1;
			self.rcvalue9d_5_c10_b1 := rcvalue9d_5_c10_b1;
			self.rcvalue9d_6_c10_b1 := rcvalue9d_6_c10_b1;
			self.rcvalue9d_7_c10_b1 := rcvalue9d_7_c10_b1;
			self.rcvalue9d_8_c10_b1 := rcvalue9d_8_c10_b1;
			self.rcvalue9e_1_c10_b1 := rcvalue9e_1_c10_b1;
			self.rcvalue9e_2_c10_b1 := rcvalue9e_2_c10_b1;
			self.rcvalue9g_1_c10_b1 := rcvalue9g_1_c10_b1;
			self.rcvalue9g_2_c10_b1 := rcvalue9g_2_c10_b1;
			self.rcvalue9g_3_c10_b1 := rcvalue9g_3_c10_b1;
			self.rcvalue9g_4_c10_b1 := rcvalue9g_4_c10_b1;
			self.rcvalue9h_1_c10_b1 := rcvalue9h_1_c10_b1;
			self.rcvalue9m_1_c10_b1 := rcvalue9m_1_c10_b1;
			self.rcvalue9m_2_c10_b1 := rcvalue9m_2_c10_b1;
			self.rcvalue9m_3_c10_b1 := rcvalue9m_3_c10_b1;
			self.rcvalue9m_4_c10_b1 := rcvalue9m_4_c10_b1;
			self.rcvalue9m_5_c10_b1 := rcvalue9m_5_c10_b1;
			self.rcvalue9m_6_c10_b1 := rcvalue9m_6_c10_b1;
			self.rcvalue9m_7_c10_b1 := rcvalue9m_7_c10_b1;
			self.rcvalue9m_8_c10_b1 := rcvalue9m_8_c10_b1;
			self.rcvalue9m_9_c10_b1 := rcvalue9m_9_c10_b1;
			self.rcvalue9o_1_c10_b1 := rcvalue9o_1_c10_b1;
			self.rcvalue9o_2_c10_b1 := rcvalue9o_2_c10_b1;
			self.rcvalue9q_1_c10_b1 := rcvalue9q_1_c10_b1;
			self.rcvalue9q_2_c10_b1 := rcvalue9q_2_c10_b1;
			self.rcvalue9q_3_c10_b1 := rcvalue9q_3_c10_b1;
			self.rcvalue9q_4_c10_b1 := rcvalue9q_4_c10_b1;
			self.rcvalue9q_5_c10_b1 := rcvalue9q_5_c10_b1;
			self.rcvalue9q_6_c10_b1 := rcvalue9q_6_c10_b1;
			self.rcvalue9q_7_c10_b1 := rcvalue9q_7_c10_b1;
			self.rcvalue9q_8_c10_b1 := rcvalue9q_8_c10_b1;
			self.rcvalue9q_9_c10_b1 := rcvalue9q_9_c10_b1;
			self.rcvalue9q_10_c10_b1 := rcvalue9q_10_c10_b1;
			self.rcvalue9r_1_c10_b1 := rcvalue9r_1_c10_b1;
			self.rcvalue9r_2_c10_b1 := rcvalue9r_2_c10_b1;
			self.rcvalue9r_3_c10_b1 := rcvalue9r_3_c10_b1;
			self.rcvalue9r_4_c10_b1 := rcvalue9r_4_c10_b1;
			self.rcvalue9r_5_c10_b1 := rcvalue9r_5_c10_b1;
			self.rcvalue9r_6_c10_b1 := rcvalue9r_6_c10_b1;
			self.rcvalue9r_7_c10_b1 := rcvalue9r_7_c10_b1;
			self.rcvalue9r_8_c10_b1 := rcvalue9r_8_c10_b1;
			self.rcvalue9r_9_c10_b1 := rcvalue9r_9_c10_b1;
			self.rcvalue9r_10_c10_b1 := rcvalue9r_10_c10_b1;
			self.rcvalue9r_11_c10_b1 := rcvalue9r_11_c10_b1;
			self.rcvalue9r_12_c10_b1 := rcvalue9r_12_c10_b1;
			self.rcvalue9r_13_c10_b1 := rcvalue9r_13_c10_b1;
			self.rcvalue9r_14_c10_b1 := rcvalue9r_14_c10_b1;
			self.rcvalue9r_15_c10_b1 := rcvalue9r_15_c10_b1;
			self.rcvalue9r_16_c10_b1 := rcvalue9r_16_c10_b1;
			self.rcvalue9r_17_c10_b1 := rcvalue9r_17_c10_b1;
			self.rcvalue9s_1_c10_b1 := rcvalue9s_1_c10_b1;
			self.rcvalue9s_2_c10_b1 := rcvalue9s_2_c10_b1;
			self.rcvalue9s_3_c10_b1 := rcvalue9s_3_c10_b1;
			self.rcvalue9t_1_c10_b1 := rcvalue9t_1_c10_b1;
			self.rcvalue9t_2_c10_b1 := rcvalue9t_2_c10_b1;
			self.rcvalue9t_3_c10_b1 := rcvalue9t_3_c10_b1;
			self.rcvalue9t_4_c10_b1 := rcvalue9t_4_c10_b1;
			self.rcvalue9t_5_c10_b1 := rcvalue9t_5_c10_b1;
			self.rcvalue9t_6_c10_b1 := rcvalue9t_6_c10_b1;
			self.rcvalue9t_7_c10_b1 := rcvalue9t_7_c10_b1;
			self.rcvalue9u_1_c10_b1 := rcvalue9u_1_c10_b1;
			self.rcvalue9u_2_c10_b1 := rcvalue9u_2_c10_b1;
			self.rcvalue9u_3_c10_b1 := rcvalue9u_3_c10_b1;
			self.rcvalue9v_1_c10_b1 := rcvalue9v_1_c10_b1;
			self.rcvalue9v_2_c10_b1 := rcvalue9v_2_c10_b1;
			self.rcvalue9v_3_c10_b1 := rcvalue9v_3_c10_b1;
			self.rcvalue9w_1_c10_b1 := rcvalue9w_1_c10_b1;
			self.rcvalue9w_2_c10_b1 := rcvalue9w_2_c10_b1;
			self.rcvalueev_1_c10_b1 := rcvalueev_1_c10_b1;
			self.rcvalueev_2_c10_b1 := rcvalueev_2_c10_b1;
			self.rcvaluemi_1_c10_b1 := rcvaluemi_1_c10_b1;
			self.rcvaluems_1_c10_b1 := rcvaluems_1_c10_b1;
			self.rcvaluems_2_c10_b1 := rcvaluems_2_c10_b1;
			self.rcvaluems_3_c10_b1 := rcvaluems_3_c10_b1;
			self.rcvaluems_4_c10_b1 := rcvaluems_4_c10_b1;
			self.rcvaluems_5_c10_b1 := rcvaluems_5_c10_b1;
			self.rcvaluems_6_c10_b1 := rcvaluems_6_c10_b1;
			self.rcvaluems_7_c10_b1 := rcvaluems_7_c10_b1;
			self.rcvaluepv_1_c10_b1 := rcvaluepv_1_c10_b1;
			self.rcvaluepv_2_c10_b1 := rcvaluepv_2_c10_b1;
			self.rcvalue25_1_c10_b2 := rcvalue25_1_c10_b2;
			self.rcvalue25_2_c10_b2 := rcvalue25_2_c10_b2;
			self.rcvalue25_3_c10_b2 := rcvalue25_3_c10_b2;
			self.rcvalue25_4_c10_b2 := rcvalue25_4_c10_b2;
			self.rcvalue26_1_c10_b2 := rcvalue26_1_c10_b2;
			self.rcvalue27_1_c10_b2 := rcvalue27_1_c10_b2;
			self.rcvalue27_2_c10_b2 := rcvalue27_2_c10_b2;
			self.rcvalue27_3_c10_b2 := rcvalue27_3_c10_b2;
			self.rcvalue27_4_c10_b2 := rcvalue27_4_c10_b2;
			self.rcvalue27_5_c10_b2 := rcvalue27_5_c10_b2;
			self.rcvalue27_6_c10_b2 := rcvalue27_6_c10_b2;
			self.rcvalue27_7_c10_b2 := rcvalue27_7_c10_b2;
			self.rcvalue36_1_c10_b2 := rcvalue36_1_c10_b2;
			self.rcvalue36_2_c10_b2 := rcvalue36_2_c10_b2;
			self.rcvalue36_3_c10_b2 := rcvalue36_3_c10_b2;
			self.rcvalue36_4_c10_b2 := rcvalue36_4_c10_b2;
			self.rcvalue36_5_c10_b2 := rcvalue36_5_c10_b2;
			self.rcvalue36_6_c10_b2 := rcvalue36_6_c10_b2;
			self.rcvalue36_7_c10_b2 := rcvalue36_7_c10_b2;
			self.rcvalue36_8_c10_b2 := rcvalue36_8_c10_b2;
			self.rcvalue36_9_c10_b2 := rcvalue36_9_c10_b2;
			self.rcvalue36_10_c10_b2 := rcvalue36_10_c10_b2;
			self.rcvalue36_11_c10_b2 := rcvalue36_11_c10_b2;
			self.rcvalue36_12_c10_b2 := rcvalue36_12_c10_b2;
			self.rcvalue36_13_c10_b2 := rcvalue36_13_c10_b2;
			self.rcvalue36_14_c10_b2 := rcvalue36_14_c10_b2;
			self.rcvalue36_15_c10_b2 := rcvalue36_15_c10_b2;
			self.rcvalue36_16_c10_b2 := rcvalue36_16_c10_b2;
			self.rcvalue36_17_c10_b2 := rcvalue36_17_c10_b2;
			self.rcvalue36_18_c10_b2 := rcvalue36_18_c10_b2;
			self.rcvalue36_19_c10_b2 := rcvalue36_19_c10_b2;
			self.rcvalue36_20_c10_b2 := rcvalue36_20_c10_b2;
			self.rcvalue36_21_c10_b2 := rcvalue36_21_c10_b2;
			self.rcvalue36_22_c10_b2 := rcvalue36_22_c10_b2;
			self.rcvalue36_23_c10_b2 := rcvalue36_23_c10_b2;
			self.rcvalue37_1_c10_b2 := rcvalue37_1_c10_b2;
			self.rcvalue37_2_c10_b2 := rcvalue37_2_c10_b2;
			self.rcvalue37_3_c10_b2 := rcvalue37_3_c10_b2;
			self.rcvalue37_4_c10_b2 := rcvalue37_4_c10_b2;
			self.rcvalue37_5_c10_b2 := rcvalue37_5_c10_b2;
			self.rcvalue49_1_c10_b2 := rcvalue49_1_c10_b2;
			self.rcvalue74_1_c10_b2 := rcvalue74_1_c10_b2;
			self.rcvalue74_2_c10_b2 := rcvalue74_2_c10_b2;
			self.rcvalue74_3_c10_b2 := rcvalue74_3_c10_b2;
			self.rcvalue97_1_c10_b2 := rcvalue97_1_c10_b2;
			self.rcvalue97_2_c10_b2 := rcvalue97_2_c10_b2;
			self.rcvalue98_1_c10_b2 := rcvalue98_1_c10_b2;
			self.rcvalue98_2_c10_b2 := rcvalue98_2_c10_b2;
			self.rcvalue98_3_c10_b2 := rcvalue98_3_c10_b2;
			self.rcvalue98_4_c10_b2 := rcvalue98_4_c10_b2;
			self.rcvalue99_1_c10_b2 := rcvalue99_1_c10_b2;
			self.rcvalue99_2_c10_b2 := rcvalue99_2_c10_b2;
			self.rcvalue99_3_c10_b2 := rcvalue99_3_c10_b2;
			self.rcvalue99_4_c10_b2 := rcvalue99_4_c10_b2;
			self.rcvalue99_5_c10_b2 := rcvalue99_5_c10_b2;
			self.rcvalue99_6_c10_b2 := rcvalue99_6_c10_b2;
			self.rcvalue99_7_c10_b2 := rcvalue99_7_c10_b2;
			self.rcvalue99_8_c10_b2 := rcvalue99_8_c10_b2;
			self.rcvalue99_9_c10_b2 := rcvalue99_9_c10_b2;
			self.rcvalue99_10_c10_b2 := rcvalue99_10_c10_b2;
			self.rcvalue99_11_c10_b2 := rcvalue99_11_c10_b2;
			self.rcvalue99_12_c10_b2 := rcvalue99_12_c10_b2;
			self.rcvalue99_13_c10_b2 := rcvalue99_13_c10_b2;
			self.rcvalue99_14_c10_b2 := rcvalue99_14_c10_b2;
			self.rcvalue99_15_c10_b2 := rcvalue99_15_c10_b2;
			self.rcvalue99_16_c10_b2 := rcvalue99_16_c10_b2;
			self.rcvalue99_17_c10_b2 := rcvalue99_17_c10_b2;
			self.rcvalue9a_1_c10_b2 := rcvalue9a_1_c10_b2;
			self.rcvalue9a_2_c10_b2 := rcvalue9a_2_c10_b2;
			self.rcvalue9a_3_c10_b2 := rcvalue9a_3_c10_b2;
			self.rcvalue9d_1_c10_b2 := rcvalue9d_1_c10_b2;
			self.rcvalue9d_2_c10_b2 := rcvalue9d_2_c10_b2;
			self.rcvalue9d_3_c10_b2 := rcvalue9d_3_c10_b2;
			self.rcvalue9d_4_c10_b2 := rcvalue9d_4_c10_b2;
			self.rcvalue9d_5_c10_b2 := rcvalue9d_5_c10_b2;
			self.rcvalue9d_6_c10_b2 := rcvalue9d_6_c10_b2;
			self.rcvalue9d_7_c10_b2 := rcvalue9d_7_c10_b2;
			self.rcvalue9d_8_c10_b2 := rcvalue9d_8_c10_b2;
			self.rcvalue9e_1_c10_b2 := rcvalue9e_1_c10_b2;
			self.rcvalue9e_2_c10_b2 := rcvalue9e_2_c10_b2;
			self.rcvalue9g_1_c10_b2 := rcvalue9g_1_c10_b2;
			self.rcvalue9g_2_c10_b2 := rcvalue9g_2_c10_b2;
			self.rcvalue9g_3_c10_b2 := rcvalue9g_3_c10_b2;
			self.rcvalue9h_1_c10_b2 := rcvalue9h_1_c10_b2;
			self.rcvalue9m_1_c10_b2 := rcvalue9m_1_c10_b2;
			self.rcvalue9m_2_c10_b2 := rcvalue9m_2_c10_b2;
			self.rcvalue9m_3_c10_b2 := rcvalue9m_3_c10_b2;
			self.rcvalue9m_4_c10_b2 := rcvalue9m_4_c10_b2;
			self.rcvalue9m_5_c10_b2 := rcvalue9m_5_c10_b2;
			self.rcvalue9m_6_c10_b2 := rcvalue9m_6_c10_b2;
			self.rcvalue9m_7_c10_b2 := rcvalue9m_7_c10_b2;
			self.rcvalue9m_8_c10_b2 := rcvalue9m_8_c10_b2;
			self.rcvalue9m_9_c10_b2 := rcvalue9m_9_c10_b2;
			self.rcvalue9m_10_c10_b2 := rcvalue9m_10_c10_b2;
			self.rcvalue9o_1_c10_b2 := rcvalue9o_1_c10_b2;
			self.rcvalue9o_2_c10_b2 := rcvalue9o_2_c10_b2;
			self.rcvalue9q_1_c10_b2 := rcvalue9q_1_c10_b2;
			self.rcvalue9q_2_c10_b2 := rcvalue9q_2_c10_b2;
			self.rcvalue9q_3_c10_b2 := rcvalue9q_3_c10_b2;
			self.rcvalue9q_4_c10_b2 := rcvalue9q_4_c10_b2;
			self.rcvalue9q_5_c10_b2 := rcvalue9q_5_c10_b2;
			self.rcvalue9q_6_c10_b2 := rcvalue9q_6_c10_b2;
			self.rcvalue9q_7_c10_b2 := rcvalue9q_7_c10_b2;
			self.rcvalue9q_8_c10_b2 := rcvalue9q_8_c10_b2;
			self.rcvalue9q_9_c10_b2 := rcvalue9q_9_c10_b2;
			self.rcvalue9q_10_c10_b2 := rcvalue9q_10_c10_b2;
			self.rcvalue9r_1_c10_b2 := rcvalue9r_1_c10_b2;
			self.rcvalue9r_2_c10_b2 := rcvalue9r_2_c10_b2;
			self.rcvalue9r_3_c10_b2 := rcvalue9r_3_c10_b2;
			self.rcvalue9r_4_c10_b2 := rcvalue9r_4_c10_b2;
			self.rcvalue9r_5_c10_b2 := rcvalue9r_5_c10_b2;
			self.rcvalue9r_6_c10_b2 := rcvalue9r_6_c10_b2;
			self.rcvalue9r_7_c10_b2 := rcvalue9r_7_c10_b2;
			self.rcvalue9r_8_c10_b2 := rcvalue9r_8_c10_b2;
			self.rcvalue9r_9_c10_b2 := rcvalue9r_9_c10_b2;
			self.rcvalue9r_10_c10_b2 := rcvalue9r_10_c10_b2;
			self.rcvalue9r_11_c10_b2 := rcvalue9r_11_c10_b2;
			self.rcvalue9r_12_c10_b2 := rcvalue9r_12_c10_b2;
			self.rcvalue9r_13_c10_b2 := rcvalue9r_13_c10_b2;
			self.rcvalue9r_14_c10_b2 := rcvalue9r_14_c10_b2;
			self.rcvalue9r_15_c10_b2 := rcvalue9r_15_c10_b2;
			self.rcvalue9r_16_c10_b2 := rcvalue9r_16_c10_b2;
			self.rcvalue9r_17_c10_b2 := rcvalue9r_17_c10_b2;
			self.rcvalue9s_1_c10_b2 := rcvalue9s_1_c10_b2;
			self.rcvalue9s_2_c10_b2 := rcvalue9s_2_c10_b2;
			self.rcvalue9s_3_c10_b2 := rcvalue9s_3_c10_b2;
			self.rcvalue9s_4_c10_b2 := rcvalue9s_4_c10_b2;
			self.rcvalue9t_1_c10_b2 := rcvalue9t_1_c10_b2;
			self.rcvalue9t_2_c10_b2 := rcvalue9t_2_c10_b2;
			self.rcvalue9t_3_c10_b2 := rcvalue9t_3_c10_b2;
			self.rcvalue9t_4_c10_b2 := rcvalue9t_4_c10_b2;
			self.rcvalue9t_5_c10_b2 := rcvalue9t_5_c10_b2;
			self.rcvalue9t_6_c10_b2 := rcvalue9t_6_c10_b2;
			self.rcvalue9t_7_c10_b2 := rcvalue9t_7_c10_b2;
			self.rcvalue9u_1_c10_b2 := rcvalue9u_1_c10_b2;
			self.rcvalue9u_2_c10_b2 := rcvalue9u_2_c10_b2;
			self.rcvalue9v_1_c10_b2 := rcvalue9v_1_c10_b2;
			self.rcvalue9v_2_c10_b2 := rcvalue9v_2_c10_b2;
			self.rcvalue9w_1_c10_b2 := rcvalue9w_1_c10_b2;
			self.rcvalue9w_2_c10_b2 := rcvalue9w_2_c10_b2;
			self.rcvalueev_1_c10_b2 := rcvalueev_1_c10_b2;
			self.rcvalueev_2_c10_b2 := rcvalueev_2_c10_b2;
			self.rcvaluemi_1_c10_b2 := rcvaluemi_1_c10_b2;
			self.rcvaluems_1_c10_b2 := rcvaluems_1_c10_b2;
			self.rcvaluems_2_c10_b2 := rcvaluems_2_c10_b2;
			self.rcvaluems_3_c10_b2 := rcvaluems_3_c10_b2;
			self.rcvaluems_4_c10_b2 := rcvaluems_4_c10_b2;
			self.rcvaluems_5_c10_b2 := rcvaluems_5_c10_b2;
			self.rcvaluems_6_c10_b2 := rcvaluems_6_c10_b2;
			self.rcvaluems_7_c10_b2 := rcvaluems_7_c10_b2;
			self.rcvaluepv_1_c10_b2 := rcvaluepv_1_c10_b2;
			self.rcvaluepv_2_c10_b2 := rcvaluepv_2_c10_b2;
			self.rcvaluemi := rcvaluemi;
			self.rcvalue27 := rcvalue27;
			self.rcvalue9r := rcvalue9r;
			self.rcvalue9d := rcvalue9d;
			self.rcvalue98 := rcvalue98;
			self.rcvaluepv := rcvaluepv;
			self.rcvalue99 := rcvalue99;
			self.rcvalue9s := rcvalue9s;
			self.rcvalueev := rcvalueev;
			self.rcvalue49 := rcvalue49;
			self.rcvalue9m := rcvalue9m;
			self.rcvalue9a := rcvalue9a;
			self.rcvalue9v := rcvalue9v;
			self.rcvalue9o := rcvalue9o;
			self.rcvalue28 := rcvalue28;
			self.rcvalue9u := rcvalue9u;
			self.rcvalue25 := rcvalue25;
			self.rcvalue97 := rcvalue97;
			self.rcvalue9g := rcvalue9g;
			self.rcvalue26 := rcvalue26;
			self.rcvalue9t := rcvalue9t;
			self.rcvalue37 := rcvalue37;
			self.rcvalue9w := rcvalue9w;
			self.rcvalue74 := rcvalue74;
			self.rcvaluems := rcvaluems;
			self.rcvalue36 := rcvalue36;
			self.rcvalue9h := rcvalue9h;
			self.rcvalue9e := rcvalue9e;
			self.rcvalue9q := rcvalue9q;
			
			self.rc1 := rcs_override[1].rc;
			self.rc2 := rcs_override[2].rc;
			self.rc3 := rcs_override[3].rc;
			self.rc4 := rcs_override[4].rc;
			self.rc5 := rcs_override[5].rc;
			
self.Ssnlength	:= 	Ssnlength	;
self.hphnpop	:= 	hphnpop	;
self.fnamepop	:= 	fnamepop	;
self.lnamepop	:= 	lnamepop	;

		#else
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
				(string3)(integer)rva1104_0_0
			);
		#end
		
	END;
	
	model := project( clam, doModel(left) );
	return model;
	
END;

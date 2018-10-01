/*2017-06-23T19:59:56Z (dschlangen)
C:\Users\schlandv\AppData\Roaming\HPCC Systems\eclide\dschlangen\dataland_staging\Models\SBBM1601_0_0\2017-06-23T19_59_56Z.ecl
*/
IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, Business_Risk_BIP, std;

EXPORT SBBM1601_0_0 (GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell, GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam /*, other parameters?? */) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
       BOOLEAN source_ar;
       BOOLEAN source_ba;
       BOOLEAN source_bm;
       BOOLEAN source_c;
       BOOLEAN source_cs;
       BOOLEAN source_dn;
       BOOLEAN source_ef;
       BOOLEAN source_ft;
       BOOLEAN source_i;
       BOOLEAN source_ia;
       BOOLEAN source_in;
       BOOLEAN source_l2;
       BOOLEAN source_p;
       BOOLEAN source_ut;
       BOOLEAN source_v2;
       BOOLEAN source_wk;
       INTEGER sysdate;
       BOOLEAN _ver_src_id__br;
       INTEGER _ver_src_id_c_pos;
       BOOLEAN _ver_src_id__c;
       INTEGER _ver_src_id_d_pos;
       BOOLEAN _ver_src_id__d;
       INTEGER _ver_src_id_df_pos;
       BOOLEAN _ver_src_id__df;
       INTEGER _ver_src_id_dn_pos;
       BOOLEAN _ver_src_id__dn;
       INTEGER _ver_src_id_fb_pos;
       BOOLEAN _ver_src_id__fb;
       INTEGER _ver_src_id_l0_pos;
       BOOLEAN _ver_src_id__l0;
       INTEGER _ver_src_id_l2_pos;
       BOOLEAN _ver_src_id__l2;
       INTEGER _ver_src_id_u2_pos;
       BOOLEAN _ver_src_id__u2;
       INTEGER _ver_src_id_ar_pos;
       BOOLEAN _ver_src_id__ar;
       INTEGER _ver_src_id_ba_pos;
       BOOLEAN _ver_src_id__ba;
       INTEGER _ver_src_id_bm_pos;
       BOOLEAN _ver_src_id__bm;
       INTEGER _ver_src_id_bn_pos;
       BOOLEAN _ver_src_id__bn;
       INTEGER _ver_src_id_cu_pos;
       BOOLEAN _ver_src_id__cu;
       INTEGER _ver_src_id_da_pos;
       BOOLEAN _ver_src_id__da;
       INTEGER _ver_src_id_ef_pos;
       BOOLEAN _ver_src_id__ef;
       INTEGER _ver_src_id_fi_pos;
       BOOLEAN _ver_src_id__fi;
       INTEGER _ver_src_id_i_pos;
       BOOLEAN _ver_src_id__i;
       INTEGER _ver_src_id_ia_pos;
       BOOLEAN _ver_src_id__ia;
       INTEGER _ver_src_id_in_pos;
       BOOLEAN _ver_src_id__in;
       INTEGER _ver_src_id_os_pos;
       BOOLEAN _ver_src_id__os;
       INTEGER _ver_src_id_p_pos;
       BOOLEAN _ver_src_id__p;
       STRING _ver_src_id_ldate_p;
       BOOLEAN _ver_src_id_ldate_p2;
       INTEGER mth__ver_src_id_ldate_p;
       INTEGER _ver_src_id_pl_pos;
       BOOLEAN _ver_src_id__pl;
       INTEGER _ver_src_id_q3_pos;
       BOOLEAN _ver_src_id__q3;
       STRING _ver_src_id_fdate_q3;
       INTEGER _ver_src_id_fdate_q32;
       INTEGER mth__ver_src_id_fdate_q3;
       INTEGER _ver_src_id_sk_pos;
       BOOLEAN _ver_src_id__sk;
       INTEGER _ver_src_id_tx_pos;
       BOOLEAN _ver_src_id__tx;
       INTEGER _ver_src_id_v2_pos;
       BOOLEAN _ver_src_id__v2;
       INTEGER _ver_src_id_wa_pos;
       BOOLEAN _ver_src_id__wa;
       INTEGER _ver_src_id_by_pos;
       BOOLEAN _ver_src_id__by;
       INTEGER _ver_src_id_cf_pos;
       BOOLEAN _ver_src_id__cf;
       INTEGER _ver_src_id_e_pos;
       BOOLEAN _ver_src_id__e;
       INTEGER _ver_src_id_ey_pos;
       BOOLEAN _ver_src_id__ey;
       INTEGER _ver_src_id_f_pos;
       BOOLEAN _ver_src_id__f;
       INTEGER _ver_src_id_fk_pos;
       BOOLEAN _ver_src_id__fk;
       INTEGER _ver_src_id_fr_pos;
       BOOLEAN _ver_src_id__fr;
       INTEGER _ver_src_id_ft_pos;
       BOOLEAN _ver_src_id__ft;
       INTEGER _ver_src_id_gr_pos;
       BOOLEAN _ver_src_id__gr;
       INTEGER _ver_src_id_h7_pos;
       BOOLEAN _ver_src_id__h7;
       INTEGER _ver_src_id_ic_pos;
       BOOLEAN _ver_src_id__ic;
       INTEGER _ver_src_id_ip_pos;
       BOOLEAN _ver_src_id__ip;
       INTEGER _ver_src_id_is_pos;
       BOOLEAN _ver_src_id__is;
       INTEGER _ver_src_id_it_pos;
       BOOLEAN _ver_src_id__it;
       INTEGER _ver_src_id_j2_pos;
       BOOLEAN _ver_src_id__j2;
       INTEGER _ver_src_id_kc_pos;
       BOOLEAN _ver_src_id__kc;
       INTEGER _ver_src_id_mh_pos;
       BOOLEAN _ver_src_id__mh;
       INTEGER _ver_src_id_mw_pos;
       BOOLEAN _ver_src_id__mw;
       INTEGER _ver_src_id_np_pos;
       BOOLEAN _ver_src_id__np;
       INTEGER _ver_src_id_nr_pos;
       BOOLEAN _ver_src_id__nr;
       INTEGER _ver_src_id_sa_pos;
       BOOLEAN _ver_src_id__sa;
       INTEGER _ver_src_id_sb_pos;
       BOOLEAN _ver_src_id__sb;
       INTEGER _ver_src_id_sg_pos;
       BOOLEAN _ver_src_id__sg;
       INTEGER _ver_src_id_sj_pos;
       BOOLEAN _ver_src_id__sj;
       INTEGER _ver_src_id_sp_pos;
       BOOLEAN _ver_src_id__sp;
       INTEGER _ver_src_id_ut_pos;
       BOOLEAN _ver_src_id__ut;
       INTEGER _ver_src_id_v_pos;
       BOOLEAN _ver_src_id__v;
       INTEGER _ver_src_id_wb_pos;
       BOOLEAN _ver_src_id__wb;
       INTEGER _ver_src_id_wc_pos;
       BOOLEAN _ver_src_id__wc;
       INTEGER _ver_src_id_wk_pos;
       BOOLEAN _ver_src_id__wk;
       INTEGER _ver_src_id_wx_pos;
       BOOLEAN _ver_src_id__wx;
       INTEGER _ver_src_id_zo_pos;
       BOOLEAN _ver_src_id__zo;
       INTEGER _ver_src_id_y_pos;
       BOOLEAN _ver_src_id__y;
       INTEGER _ver_src_id_gb_pos;
       BOOLEAN _ver_src_id__gb;
       STRING _ver_src_id_fdate_gb;
       INTEGER _ver_src_id_fdate_gb2;
       REAL mth__ver_src_id_fdate_gb;
       STRING _ver_src_id_ldate_gb;
       INTEGER _ver_src_id_ldate_gb2;
       REAL mth__ver_src_id_ldate_gb;
       INTEGER _ver_src_id_cs_pos;
       BOOLEAN _ver_src_id__cs;
       INTEGER _ne_ver_src_id_count;
       BOOLEAN truebiz;
       STRING ne_bv_truebiz_category;
       STRING seg_business_score;
       INTEGER iv_rv5_unscorable;
       REAL vs_gb_id_mth_fseen;
       REAL vs_gb_id_mth_lseen;
       INTEGER vs_ver_src_id__bm;
       INTEGER vs_ver_src_id__in;
       INTEGER vs_adl_util_i;
       INTEGER vs_util_adl_count;
       INTEGER _util_adl_first_seen;
       REAL vs_util_adl_mths_fs;
       INTEGER _gong_did_last_seen;
       REAL vs_gong_adl_mths_ls;
       INTEGER _header_first_seen;
       REAL vs_header_mths_fs;
       INTEGER _pb_first_seen;
       REAL vs_pb_mths_fs;
       INTEGER _pb_last_seen;
       REAL vs_pb_mths_ls;
       INTEGER vs_pb_number_of_sources;
       REAL vs_br_mths_fs;
       INTEGER vs_br_business_count;
       INTEGER vs_br_dead_business_count;
       INTEGER vs_br_active_phone_count;
       INTEGER vs_email_count;
       INTEGER vs_email_domain_free_count;
       INTEGER vs_email_domain_edu_count;
       INTEGER vs_historical_count;
       INTEGER vs_college_tier;
       INTEGER vs_prof_license_flag;
       INTEGER ver_src_cons_vo_pos;
       STRING ver_src_cons_ldate_vo;
       INTEGER ver_src_cons_wp_pos;
       INTEGER ver_src_cons_am_pos;
       INTEGER ver_src_cons_e1_pos;
       INTEGER _ver_src_cons_ldate_vo;
       REAL vs_ver_src_cons_vo_mths_ls;
       INTEGER vs_ver_sources_wp_pop;
       INTEGER vs_ver_sources_am_pop;
       INTEGER vs_ver_sources_e1_pop;
       REAL c_vs_gb_id_mth_fseen_w;
       REAL c_vs_gb_id_mth_lseen_w;
       REAL c_vs_ver_src_id__bm_w;
       REAL c_vs_ver_src_id__in_w;
       REAL c_vs_util_adl_count_w;
       REAL c_vs_util_adl_mths_fs_w;
       REAL c_vs_gong_adl_mths_ls_w;
       REAL c_vs_header_mths_fs_w;
       REAL c_vs_pb_mths_fs_w;
       REAL c_vs_pb_mths_ls_w;
       REAL c_vs_pb_number_of_sources_w;
       REAL c_vs_br_mths_fs_w;
       REAL c_vs_br_dead_business_count_w;
       REAL c_vs_br_active_phone_count_w;
       REAL c_vs_email_count_w;
       REAL c_vs_email_domain_free_count_w;
       REAL c_vs_email_domain_edu_count_w;
       REAL c_vs_college_tier_w;
       REAL c_vs_prof_license_flag_w;
       REAL c_vs_ver_src_cons_vo_mths_ls_w;
       REAL c_vs_ver_sources_am_pop_w;
       REAL bv_bus_rep_source_profile;
       REAL r_vs_adl_util_i_w;
       REAL r_vs_util_adl_count_w;
       REAL r_vs_util_adl_mths_fs_w;
       REAL r_vs_gong_adl_mths_ls_w;
       REAL r_vs_header_mths_fs_w;
       REAL r_vs_pb_mths_fs_w;
       REAL r_vs_pb_mths_ls_w;
       REAL r_vs_pb_number_of_sources_w;
       REAL r_vs_br_mths_fs_w;
       REAL r_vs_br_business_count_w;
       REAL r_vs_br_dead_business_count_w;
       REAL r_vs_br_active_phone_count_w;
       REAL r_vs_email_count_w;
       REAL r_vs_email_domain_free_count_w;
       REAL r_vs_email_domain_edu_count_w;
       REAL r_vs_historical_count_w;
       REAL r_vs_college_tier_w;
       REAL r_vs_prof_license_flag_w;
       REAL r_vs_ver_src_cons_vo_mths_ls_w;
       REAL r_vs_ver_sources_wp_pop_w;
       REAL r_vs_ver_sources_am_pop_w;
       REAL r_vs_ver_sources_e1_pop_w;
       REAL bv_rep_only_source_profile;
       INTEGER rv_d30_derog_count;
       INTEGER _criminal_last_date;
       INTEGER rv_d32_mos_since_crim_ls;
       STRING rv_d31_mostrec_bk;
       INTEGER rv_a46_curr_avm_autoval;
       REAL rv_a49_curr_avm_chg_1yr_pct;
       STRING rv_a41_prop_owner;
       STRING rv_e55_college_ind;
       INTEGER rv_i60_inq_hiriskcred_recency;
       INTEGER rv_c18_invalid_addrs_per_adl;
       INTEGER rv_d34_attr_liens_recency;
       INTEGER rv_e58_br_dead_business_count;
       INTEGER nf_inq_collection_count;
       INTEGER _acc_last_seen;
       INTEGER nf_mos_acc_lseen;
       STRING rv_d31_bk_chapter;
       INTEGER rv_d34_unrel_liens_ct;
       STRING rv_a41_a42_prop_owner_history;
       INTEGER rv_i61_inq_collection_recency;
       INTEGER rv_i60_inq_auto_recency;
       INTEGER br_first_seen_char;
       INTEGER _br_first_seen;
       INTEGER rv_mos_since_br_first_seen;
       INTEGER iv_d34_liens_rel_sc_ct;
       INTEGER nf_inq_highriskcredit_count;
       INTEGER _inq_banko_cm_first_seen;
       INTEGER nf_mos_inq_banko_cm_fseen;
       INTEGER nf_fp_vardobcountnew;
       INTEGER nf_fp_srchfraudsrchcountmo;
       STRING nf_fp_prevaddrstatus;
       INTEGER bureau_adl_en_fseen_pos;
       STRING bureau_adl_fseen_en;
       INTEGER _bureau_adl_fseen_en;
       INTEGER _src_bureau_adl_fseen_notu;
       INTEGER nf_m_bureau_adl_fs_notu;
       INTEGER rv_d31_attr_bankruptcy_recency;
       INTEGER rv_d31_bk_disposed_hist_count;
       INTEGER rv_c21_stl_inq_count;
       STRING rv_d33_eviction_recency;
       INTEGER rv_d34_unrel_lien60_count;
       INTEGER bureau_adl_eq_fseen_pos;
       STRING bureau_adl_fseen_eq;
       INTEGER _bureau_adl_fseen_eq;
       INTEGER _src_bureau_adl_fseen;
       INTEGER rv_c20_m_bureau_adl_fs;
       INTEGER rv_i61_inq_collection_count12;
       INTEGER rv_l79_adls_per_addr_curr;
       INTEGER rv_a50_pb_average_dollars;
       INTEGER iv_c13_avg_lres;
       INTEGER rv_i60_inq_other_recency;
       INTEGER iv_d34_liens_unrel_cj_ct;
       INTEGER iv_d34_liens_unrel_sc_ct;
       INTEGER nf_inq_auto_count;
       INTEGER nf_inq_communications_count24;
       INTEGER _inq_banko_om_last_seen;
       INTEGER nf_mos_inq_banko_om_lseen;
       INTEGER nf_accident_count;
       INTEGER nf_fp_srchunvrfdssncount;
       INTEGER nf_fp_srchunvrfdaddrcount;
       STRING nf_fp_curraddractivephonelist;
       INTEGER td_sbfe_avg_util_pct06;
       INTEGER td_acct_dpd_1p_recency;
       INTEGER _sbfe_acct_datefirstopen;
       INTEGER td_mth_acct_firstopen;
       INTEGER td_sbfe_avg_util_pct_cc;
       INTEGER td_sbfe_util_pct_cc;
       INTEGER _sos_inc_filing_firstseen;
       INTEGER bv_sos_mth_fs;
       REAL td_sbfe_closed_pct_invol;
       INTEGER num_pos_sources;
       INTEGER num_neg_sources;
       REAL bv_ver_src_derog_ratio;
       REAL bv_mth_ver_src_q3_fs;
       INTEGER _sbfe_datefirstseen;
       REAL td_mth_sbfe_datefirstseen;
       REAL td_acct_pct_closed;
       INTEGER _sbfe_dlq_datelastseen;
       REAL td_mth_dlq_lastseen;
       INTEGER _inq_lastseen;
       INTEGER bv_mths_inq_lastseen;
       INTEGER bv_prop_assessed_value;
       REAL bv_mth_ver_src_p_ls;
       INTEGER bv_lien_judg_index;
       INTEGER _phn_input_firstseen_id;
       INTEGER bv_src_id_phn_mth_fs;
       INTEGER bv_assoc_bk_tot;
       INTEGER bv_sos_defunct_status;
       INTEGER bv_lien_filed_count;
       INTEGER _ucc_lastseen;
       INTEGER bv_ucc_mth_ls;
       INTEGER bv_ucc_index;
       INTEGER td_sbfe_worst_perf06;
       INTEGER td_sbfe_worst_perf60_loan;
       INTEGER td_sbfe_worst_perf12_oel;
       INTEGER td_acct_dpd_31p_recency_cc;
       INTEGER td_acct_dpd_91p_recency_lse;
       INTEGER td_sbfe_util_pct;
       INTEGER td_sbfe_avg_util_pct24;
       INTEGER td_sbfe_avg_past_due_amt24;
       INTEGER td_sbfe_avg_past_due_amt;
       INTEGER td_sbfe_avg_util_pct12;
       INTEGER td_sbfe_worst_perf84;
       INTEGER bv_assoc_derog_flag;
       REAL s_bv_src_id_phn_mth_fs_w;
       REAL s_aa_dist_1;
       STRING s_aa_code_1;
       REAL s_bv_assoc_bk_tot_w;
       REAL s_aa_dist_2;
       STRING s_aa_code_2;
       REAL s_bv_sos_defunct_status_w;
       REAL s_aa_dist_3;
       STRING s_aa_code_3;
       REAL s_bv_lien_filed_count_w;
       REAL s_aa_dist_4;
       STRING s_aa_code_4;
       REAL s_bv_ucc_index_w;
       REAL s_aa_dist_5;
       STRING s_aa_code_5;
       REAL s_bv_prop_assessed_value_w;
       REAL s_aa_dist_6;
       STRING s_aa_code_6;
       REAL s_td_mth_sbfe_datefirstseen_w;
       REAL s_aa_dist_7;
       STRING s_aa_code_7;
       REAL s_td_mth_acct_firstopen_w;
       REAL s_aa_dist_8;
       STRING s_aa_code_8;
       REAL s_td_mth_dlq_lastseen_w;
       REAL s_aa_dist_9;
       STRING s_aa_code_9;
       REAL s_td_acct_pct_closed_w;
       REAL s_aa_dist_10;
       STRING s_aa_code_10;
       REAL s_td_sbfe_worst_perf06_w;
       REAL s_aa_dist_11;
       STRING s_aa_code_11;
       REAL s_td_sbfe_worst_perf60_loan_w;
       REAL s_aa_dist_12;
       STRING s_aa_code_12;
       REAL s_td_sbfe_worst_perf12_oel_w;
       REAL s_aa_dist_13;
       STRING s_aa_code_13;
       REAL s_td_acct_dpd_31p_recency_cc_w;
       REAL s_aa_dist_14;
       STRING s_aa_code_14;
       REAL s_td_acct_dpd_91p_recency_lse_w;
       REAL s_aa_dist_15;
       STRING s_aa_code_15;
       REAL s_td_sbfe_closed_pct_invol_w;
       REAL s_aa_dist_16;
       STRING s_aa_code_16;
       REAL s_td_sbfe_util_pct_w;
       REAL s_aa_dist_17;
       STRING s_aa_code_17;
       REAL s_td_sbfe_util_pct_cc_w;
       REAL s_aa_dist_18;
       STRING s_aa_code_18;
       REAL s_td_sbfe_avg_util_pct06_w;
       REAL s_aa_dist_19;
       STRING s_aa_code_19;
       REAL s_td_sbfe_avg_util_pct24_w;
       REAL s_aa_dist_20;
       STRING s_aa_code_20;
       REAL s_td_sbfe_avg_util_pct_cc_w;
       REAL s_aa_dist_21;
       STRING s_aa_code_21;
       REAL s_td_sbfe_avg_past_due_amt24_w;
       REAL s_aa_dist_22;
       STRING s_aa_code_22;
       REAL s_td_sbfe_avg_past_due_amt_w;
       REAL s_aa_dist_23;
       STRING s_aa_code_23;
       REAL s_bv_ver_src_derog_ratio_w;
       REAL s_aa_dist_24;
       STRING s_aa_code_24;
       REAL s_rv_d30_derog_count_w;
       REAL s_aa_dist_25;
       STRING s_aa_code_25;
       REAL s_rv_d32_mos_since_crim_ls_w;
       REAL s_aa_dist_26;
       STRING s_aa_code_26;
       REAL s_rv_d31_mostrec_bk_w;
       REAL s_aa_dist_27;
       STRING s_aa_code_27;
       REAL s_rv_a46_curr_avm_autoval_w;
       REAL s_aa_dist_28;
       STRING s_aa_code_28;
       REAL s_rv_a49_curr_avm_chg_1yr_pct_w;
       REAL s_aa_dist_29;
       STRING s_aa_code_29;
       REAL s_rv_a41_prop_owner_w;
       REAL s_aa_dist_30;
       STRING s_aa_code_30;
       REAL s_rv_e55_college_ind_w;
       REAL s_aa_dist_31;
       STRING s_aa_code_31;
       REAL s_rv_i60_inq_hiriskcred_rec_w;
       REAL s_aa_dist_32;
       STRING s_aa_code_32;
       REAL s_rv_c18_inv_addrs_per_adl_w;
       REAL s_aa_dist_33;
       STRING s_aa_code_33;
       REAL s_rv_d34_attr_liens_recency_w;
       REAL s_aa_dist_34;
       STRING s_aa_code_34;
       REAL s_rv_e58_br_dead_bus_count_w;
       REAL s_aa_dist_35;
       STRING s_aa_code_35;
       REAL s_nf_inq_collection_count_w;
       REAL s_aa_dist_36;
       STRING s_aa_code_36;
       REAL s_nf_mos_acc_lseen_w;
       REAL s_aa_dist_37;
       STRING s_aa_code_37;
       REAL s_bv_bus_rep_source_profile_w;
       REAL s_aa_dist_38;
       STRING s_aa_code_38;
       REAL s_bv_rep_only_source_profile_w;
       REAL s_aa_dist_39;
       STRING s_aa_code_39;
       REAL s_td_sbfe_avg_util_pct12_w;
       REAL s_aa_dist_40;
       STRING s_aa_code_40;
       REAL s_td_acct_dpd_1p_recency_w;
       REAL s_aa_dist_41;
       STRING s_aa_code_41;
       REAL s_td_sbfe_worst_perf84_w;
       REAL s_aa_dist_42;
       STRING s_aa_code_42;
       REAL s_rcvalueb037;
       REAL s_rcvaluep531;
       REAL s_rcvaluep532;
       REAL s_rcvalueb034;
       REAL s_rcvaluep534;
       REAL s_rcvaluep535;
       REAL s_rcvalueb031;
       REAL s_rcvaluep516;
       REAL s_rcvaluep539;
       REAL s_rcvalueb017;
       REAL s_rcvaluep515;
       REAL s_rcvaluep521;
       REAL s_rcvaluebf142;
       REAL s_rcvaluep511;
       REAL s_rcvaluebf113;
       REAL s_rcvaluebf134;
       REAL s_rcvaluebf110;
       REAL s_rcvaluebf117;
       REAL s_rcvaluebf133;
       REAL s_rcvaluebf136;
       REAL s_rcvaluep509;
       REAL s_rcvaluebf141;
       REAL s_rcvalueb026;
       REAL s_rcvaluebf143;
       REAL s_rcvaluep526;
       REAL s_rcvalueb063;
       REAL s_rcvalueb066;
       REAL s_rcvaluebf126;
       REAL s_rcvaluebf127;
       REAL s_rcvaluebf125;
       REAL s_rcvaluebf120;
       REAL s_rcvaluebf105;
       REAL s_rcvaluebf106;
       REAL s_rcvaluebf128;
       REAL s_rcvaluebf129;
       REAL s_rcvaluebf135;
       REAL s_rcvaluep502;
       REAL s_rcvalueb053;
       REAL s_rcvalueb052;
       REAL s_rcvalueb055;
       REAL s_rcvalueb059;
       REAL s_final_score;
       REAL l_bv_src_id_phn_mth_fs_w;
       REAL l_aa_dist_1;
       STRING l_aa_code_1;
       REAL l_bv_sos_mth_fs_w;
       REAL l_aa_dist_2;
       STRING l_aa_code_2;
       REAL l_bv_lien_judg_index_w;
       REAL l_aa_dist_3;
       STRING l_aa_code_3;
       REAL l_bv_prop_assessed_value_w;
       REAL l_aa_dist_4;
       STRING l_aa_code_4;
       REAL l_bv_mths_inq_lastseen_w;
       REAL l_aa_dist_5;
       STRING l_aa_code_5;
       REAL l_bv_mth_ver_src_p_ls_w;
       REAL l_aa_dist_6;
       STRING l_aa_code_6;
       REAL l_bv_mth_ver_src_q3_fs_w;
       REAL l_aa_dist_7;
       STRING l_aa_code_7;
       REAL l_rv_d30_derog_count_w;
       REAL l_aa_dist_8;
       STRING l_aa_code_8;
       REAL l_rv_d31_bk_chapter_w;
       REAL l_aa_dist_9;
       STRING l_aa_code_9;
       REAL l_rv_d34_unrel_liens_ct_w;
       REAL l_aa_dist_10;
       STRING l_aa_code_10;
       REAL l_rv_a46_curr_avm_autoval_w;
       REAL l_aa_dist_11;
       STRING l_aa_code_11;
       REAL l_rv_a41_a42_prop_owner_hist_w;
       REAL l_aa_dist_12;
       STRING l_aa_code_12;
       REAL l_rv_e55_college_ind_w;
       REAL l_aa_dist_13;
       STRING l_aa_code_13;
       REAL l_rv_i61_inq_collection_rec_w;
       REAL l_aa_dist_14;
       STRING l_aa_code_14;
       REAL l_rv_i60_inq_auto_recency_w;
       REAL l_aa_dist_15;
       STRING l_aa_code_15;
       REAL l_rv_d34_attr_liens_recency_w;
       REAL l_aa_dist_16;
       STRING l_aa_code_16;
       REAL l_rv_mos_since_br_first_seen_w;
       REAL l_aa_dist_17;
       STRING l_aa_code_17;
       REAL l_iv_d34_liens_rel_sc_ct_w;
       REAL l_aa_dist_18;
       STRING l_aa_code_18;
       REAL l_nf_inq_highriskcredit_count_w;
       REAL l_aa_dist_19;
       STRING l_aa_code_19;
       REAL l_nf_mos_inq_banko_cm_fseen_w;
       REAL l_aa_dist_20;
       STRING l_aa_code_20;
       REAL l_nf_mos_acc_lseen_w;
       REAL l_aa_dist_21;
       STRING l_aa_code_21;
       REAL l_nf_fp_vardobcountnew_w;
       REAL l_aa_dist_22;
       STRING l_aa_code_22;
       REAL l_nf_fp_srchfraudsrchcountmo_w;
       REAL l_aa_dist_23;
       STRING l_aa_code_23;
       REAL l_nf_fp_prevaddrstatus_w;
       REAL l_aa_dist_24;
       STRING l_aa_code_24;
       REAL l_bv_bus_rep_source_profile_w;
       REAL l_aa_dist_25;
       STRING l_aa_code_25;
       REAL l_bv_rep_only_source_profile_w;
       REAL l_aa_dist_26;
       STRING l_aa_code_26;
       REAL l_bv_assoc_derog_flag_w;
       REAL l_aa_dist_27;
       STRING l_aa_code_27;
       REAL l_nf_m_bureau_adl_fs_notu_w;
       REAL l_aa_dist_28;
       STRING l_aa_code_28;
       STRING l_aa_code_29;
       REAL l_aa_dist_29;
       REAL l_rcvalueb037;
       REAL l_rcvaluep531;
       REAL l_rcvaluep532;
       REAL l_rcvalueb034;
       REAL l_rcvaluep534;
       REAL l_rcvaluep535;
       REAL l_rcvalueb031;
       REAL l_rcvalueb015;
       REAL l_rcvaluep539;
       REAL l_rcvalueb017;
       REAL l_rcvaluep515;
       REAL l_rcvalueb038;
       REAL l_rcvalueb040;
       REAL l_rcvaluep509;
       REAL l_rcvalueb026;
       REAL l_rcvaluep526;
       REAL l_rcvalueb063;
       REAL l_rcvaluep506;
       REAL l_rcvaluebf108;
       REAL l_rcvaluep562;
       REAL l_rcvalueb053;
       REAL l_rcvalueb052;
       REAL l_rcvalueb055;
       REAL l_rcvalueb057;
       REAL l_rcvaluep523;
       REAL l_final_score;
       REAL u_rv_d30_derog_count_w;
       REAL u_aa_dist_1;
       STRING u_aa_code_1;
       REAL u_rv_d31_attr_bk_recency_w;
       REAL u_aa_dist_2;
       STRING u_aa_code_2;
       REAL u_rv_d31_bk_disposed_hist_cnt_w;
       REAL u_aa_dist_3;
       STRING u_aa_code_3;
       REAL u_rv_c21_stl_inq_count_w;
       REAL u_aa_dist_4;
       STRING u_aa_code_4;
       REAL u_rv_d33_eviction_recency_w;
       REAL u_aa_dist_5;
       STRING u_aa_code_5;
       REAL u_rv_d34_unrel_lien60_count_w;
       REAL u_aa_dist_6;
       STRING u_aa_code_6;
       REAL u_rv_c20_m_bureau_adl_fs_w;
       REAL u_aa_dist_7;
       STRING u_aa_code_7;
       REAL u_rv_a46_curr_avm_autoval_w;
       REAL u_aa_dist_8;
       STRING u_aa_code_8;
       REAL u_rv_a49_curr_avm_chg_1yr_pct_w;
       REAL u_aa_dist_9;
       STRING u_aa_code_9;
       REAL u_rv_a41_prop_owner_w;
       REAL u_aa_dist_10;
       STRING u_aa_code_10;
       REAL u_rv_e55_college_ind_w;
       REAL u_aa_dist_11;
       STRING u_aa_code_11;
       REAL u_rv_i61_inq_collection_cnt12_w;
       REAL u_aa_dist_12;
       STRING u_aa_code_12;
       REAL u_rv_l79_adls_per_addr_curr_w;
       REAL u_aa_dist_13;
       STRING u_aa_code_13;
       REAL u_rv_d34_attr_liens_recency_w;
       REAL u_aa_dist_14;
       STRING u_aa_code_14;
       REAL u_rv_a50_pb_average_dollars_w;
       REAL u_aa_dist_15;
       STRING u_aa_code_15;
       REAL u_iv_c13_avg_lres_w;
       REAL u_aa_dist_16;
       STRING u_aa_code_16;
       REAL u_rv_i60_inq_other_recency_w;
       REAL u_aa_dist_17;
       STRING u_aa_code_17;
       REAL u_rv_mos_since_br_first_seen_w;
       REAL u_aa_dist_18;
       STRING u_aa_code_18;
       REAL u_iv_d34_liens_unrel_cj_ct_w;
       REAL u_aa_dist_19;
       STRING u_aa_code_19;
       REAL u_iv_d34_liens_unrel_sc_ct_w;
       REAL u_aa_dist_20;
       STRING u_aa_code_20;
       REAL u_nf_inq_auto_count_w;
       REAL u_aa_dist_21;
       STRING u_aa_code_21;
       REAL u_nf_inq_collection_count_w;
       REAL u_aa_dist_22;
       STRING u_aa_code_22;
       REAL u_nf_inq_communications_cnt24_w;
       REAL u_aa_dist_23;
       STRING u_aa_code_23;
       REAL u_nf_inq_highriskcredit_count_w;
       REAL u_aa_dist_24;
       STRING u_aa_code_24;
       REAL u_nf_mos_inq_banko_cm_fseen_w;
       REAL u_aa_dist_25;
       STRING u_aa_code_25;
       REAL u_nf_mos_inq_banko_om_lseen_w;
       REAL u_aa_dist_26;
       STRING u_aa_code_26;
       REAL u_nf_accident_count_w;
       REAL u_aa_dist_27;
       STRING u_aa_code_27;
       REAL u_nf_fp_vardobcountnew_w;
       REAL u_aa_dist_28;
       STRING u_aa_code_28;
       REAL u_nf_fp_srchunvrfdssncount_w;
       REAL u_aa_dist_29;
       STRING u_aa_code_29;
       REAL u_nf_fp_srchunvrfdaddrcount_w;
       REAL u_aa_dist_30;
       STRING u_aa_code_30;
       REAL u_nf_fp_curraddractivephnlist_w;
       REAL u_aa_dist_31;
       STRING u_aa_code_31;
       REAL u_bv_rep_only_source_profile_w;
       REAL u_aa_dist_32;
       STRING u_aa_code_32;
       REAL u_nf_m_bureau_adl_fs_notu_w;
       REAL u_aa_dist_33;
       STRING u_aa_code_33;
       STRING u_aa_code_34;
       REAL u_aa_dist_34;
       REAL u_rcvaluep523;
       REAL u_rcvaluep509;
       REAL u_rcvaluep532;
       REAL u_rcvaluep502;
       REAL u_rcvaluep534;
       REAL u_rcvaluep535;
       REAL u_rcvaluep531;
       REAL u_rcvaluep524;
       REAL u_rcvaluep516;
       REAL u_rcvaluep539;
       REAL u_rcvaluep515;
       REAL u_rcvaluep512;
       REAL u_rcvaluep511;
       REAL u_rcvaluep538;
       REAL u_rcvaluep550;
       REAL u_rcvalueb067;
       REAL u_rcvaluep549;
       REAL u_rcvaluep562;
       REAL u_rcvaluep526;
       REAL u_final_score;
       INTEGER base;
       INTEGER pts;
       REAL lgt;
       REAL blend_mod_final_lgt;
       INTEGER _sbbm1601_0_0;
       STRING l_rc1;
       STRING l_rc2;
       STRING l_rc3;
       STRING l_rc4;
       STRING l_rc5;
       STRING l_rc6;
       STRING l_rc7;
       STRING l_rc8;
       STRING l_rc9;
       STRING l_rc10;
       STRING l_rc11;
       STRING l_rc12;
       STRING l_rc13;
       STRING l_rc14;
       STRING l_rc15;
       STRING l_rc16;
       STRING l_rc17;
       STRING l_rc18;
       STRING l_rc19;
       STRING l_rc20;
       STRING l_rc21;
       STRING l_rc22;
       STRING l_rc23;
       STRING l_rc24;
       STRING l_rc25;
       STRING l_rc26;
       STRING l_rc27;
       STRING l_rc28;
       STRING l_rc29;
       STRING l_rc30;
       STRING l_rc31;
       STRING l_rc32;
       STRING l_rc33;
       STRING l_rc34;
       STRING l_rc35;
       STRING l_rc36;
       STRING l_rc37;
       STRING l_rc38;
       STRING l_rc39;
       STRING l_rc40;
       STRING l_rc41;
       STRING l_rc42;
       STRING l_rc43;
       STRING l_rc44;
       STRING l_rc45;
       STRING l_rc46;
       STRING l_rc47;
       STRING l_rc48;
       STRING l_rc49;
       STRING l_rc50;
       STRING s_rc1;
       STRING s_rc2;
       STRING s_rc3;
       STRING s_rc4;
       STRING s_rc5;
       STRING s_rc6;
       STRING s_rc7;
       STRING s_rc8;
       STRING s_rc9;
       STRING s_rc10;
       STRING s_rc11;
       STRING s_rc12;
       STRING s_rc13;
       STRING s_rc14;
       STRING s_rc15;
       STRING s_rc16;
       STRING s_rc17;
       STRING s_rc18;
       STRING s_rc19;
       STRING s_rc20;
       STRING s_rc21;
       STRING s_rc22;
       STRING s_rc23;
       STRING s_rc24;
       STRING s_rc25;
       STRING s_rc26;
       STRING s_rc27;
       STRING s_rc28;
       STRING s_rc29;
       STRING s_rc30;
       STRING s_rc31;
       STRING s_rc32;
       STRING s_rc33;
       STRING s_rc34;
       STRING s_rc35;
       STRING s_rc36;
       STRING s_rc37;
       STRING s_rc38;
       STRING s_rc39;
       STRING s_rc40;
       STRING s_rc41;
       STRING s_rc42;
       STRING s_rc43;
       STRING s_rc44;
       STRING s_rc45;
       STRING s_rc46;
       STRING s_rc47;
       STRING s_rc48;
       STRING s_rc49;
       STRING s_rc50;
       STRING u_rc1;
       STRING u_rc2;
       STRING u_rc3;
       STRING u_rc4;
       STRING u_rc5;
       STRING u_rc6;
       STRING u_rc7;
       STRING u_rc8;
       STRING u_rc9;
       STRING u_rc10;
       STRING u_rc11;
       STRING u_rc12;
       STRING u_rc13;
       STRING u_rc14;
       STRING u_rc15;
       STRING u_rc16;
       STRING u_rc17;
       STRING u_rc18;
       STRING u_rc19;
       STRING u_rc20;
       STRING u_rc21;
       STRING u_rc22;
       STRING u_rc23;
       STRING u_rc24;
       STRING u_rc25;
       STRING u_rc26;
       STRING u_rc27;
       STRING u_rc28;
       STRING u_rc29;
       STRING u_rc30;
       STRING u_rc31;
       STRING u_rc32;
       STRING u_rc33;
       STRING u_rc34;
       STRING u_rc35;
       STRING u_rc36;
       STRING u_rc37;
       STRING u_rc38;
       STRING u_rc39;
       STRING u_rc40;
       STRING u_rc41;
       STRING u_rc42;
       STRING u_rc43;
       STRING u_rc44;
       STRING u_rc45;
       STRING u_rc46;
       STRING u_rc47;
       STRING u_rc48;
       STRING u_rc49;
       STRING u_rc50;
       STRING blend_mod_rc41;
       STRING blend_mod_rc36;
       STRING blend_mod_rc45;
       STRING blend_mod_rc35;
       STRING blend_mod_rc3;
       STRING blend_mod_rc42;
       STRING blend_mod_rc46;
       STRING blend_mod_rc19;
       STRING blend_mod_rc2;
       STRING blend_mod_rc33;
       STRING blend_mod_rc16;
       STRING blend_mod_rc8;
       STRING blend_mod_rc40;
       STRING blend_mod_rc32;
       STRING blend_mod_rc38;
       STRING blend_mod_rc29;
       STRING blend_mod_rc20;
       STRING blend_mod_rc9;
       STRING blend_mod_rc26;
       STRING blend_mod_rc34;
       STRING blend_mod_rc39;
       STRING blend_mod_rc5;
       STRING blend_mod_rc30;
       INTEGER sbbm1601_0_0;
       STRING blend_mod_rc13;
       STRING blend_mod_rc24;
       STRING blend_mod_rc12;
       STRING blend_mod_rc44;
       STRING blend_mod_rc48;
       STRING blend_mod_rc23;
       STRING blend_mod_rc50;
       STRING blend_mod_rc31;
       STRING blend_mod_rc22;
       STRING blend_mod_rc47;
       STRING blend_mod_rc18;
       STRING blend_mod_rc25;
       STRING blend_mod_rc49;
       STRING blend_mod_rc43;
       STRING blend_mod_rc10;
       STRING blend_mod_rc17;
       STRING blend_mod_rc11;
       STRING blend_mod_rc27;
       STRING blend_mod_rc37;
       STRING blend_mod_rc21;
       STRING blend_mod_rc15;
       STRING blend_mod_rc6;
       STRING blend_mod_rc1;
       STRING blend_mod_rc28;
       STRING blend_mod_rc14;
       STRING blend_mod_rc7;
       STRING blend_mod_rc4;
       STRING sbbm_rc1;
       STRING sbbm_rc2;
       STRING sbbm_rc4;
       STRING sbbm_rc3;

			Risk_Indicators.Layout_Boca_Shell clam;
		 Business_Risk_BIP.Layouts.OutputLayout busShell;
		END;
		Layout_Debug doModel(BusShell le, clam ri) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(BusShell le, clam ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
			MaxSASLength := 1000; // Max length for the list fields to be imported into SAS (Technically SAS can handle up to 32,767 - but modeling only wants 1,000 to help with speed of imports)
		
			
  ver_src_list                     := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelist, MaxSASLength);
	history_date                     := le.Input_Echo.historydate;
	history_datetime                 := le.Input_Echo.historydatetime;
	ver_src_id_firstseen_list        := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatefirstseenlistID, MaxSASLength);
	ver_src_id_list                  := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcelistID, MaxSASLength);
	ver_src_id_lastseen_list         := Business_Risk_BIP.Common.truncate_list(le.Verification.sourcedatelastseenlistID, MaxSASLength);
	ver_src_id_count                 := le.Verification.SourceCountID;
	id_seleid                        := le.Verification.inputidmatchseleid;
	sbfe_acct_cnt                    := le.SBFE.SBFEAccountCount;
	sbfe_avg_util_pct06              := le.SBFE.SBFEUtilizationAve06;
	assoc_count                      := le.Associates.AssociateCount;
	assoc_felony_count               := le.Associates.AssociateCountWithFelony;
	assoc_bankruptcy_count           := le.Associates.AssociateCountWithBankruptcy;
	assoc_lien_count                 := le.Associates.AssociateCountWithLien;
	assoc_judg_count                 := le.Associates.AssociateCountWithJudgment;
	sbfe_acct_dpd_1p_cnt00           := le.SBFE.SBFEDPD1Count;
	sbfe_acct_dpd_1p_cnt06           := le.SBFE.SBFEDPD1Count06;
	sbfe_acct_dpd_1p_cnt12           := le.SBFE.SBFEDPD1Count12;
	sbfe_acct_dpd_1p_cnt24           := le.SBFE.SBFEDPD1Count24;
	sbfe_acct_dpd_1p_cnt36           := le.SBFE.SBFEDPD1Count36;
	sbfe_acct_dpd_1p_cnt60           := le.SBFE.SBFEDPD1Count60;
	sbfe_acct_dpd_1p_cnt84           := le.SBFE.SBFEDPD1Count84;
	sbfe_acct_dpd_1p_cnt             := le.SBFE.SBFEDPD1CountEver;
	sbfe_acct_datefirstopen          := le.SBFE.SBFEDateOpenFirstSeenAll;
	sbfe_avg_util_pct_cc             := le.SBFE.SBFEUtilizationAveEverCard;
	sbfe_util_pct_cc                 := le.SBFE.SBFEUtilizationCurrentCard;
	sos_inc_filing_firstseen         := le.SOS.SOSIncorporationDateFirstSeen;
	sos_ever_defunct                 := le.SOS.soseverdefunct;
	sos_inc_filing_count             := le.SOS.SOSIncorporationCount;
	sbfe_closed_cnt                  := le.SBFE.SBFEClosedCount;
	sbfe_closed_cnt_invol            := le.SBFE.SBFEClosedCountInvoluntary;
	lien_filed_count03               := le.Lien_And_Judgment.LienFiledCount03;
	lien_filed_count12               := le.Lien_And_Judgment.LienFiledCount12;
	lien_filed_count                 := le.Lien_And_Judgment.LienCount;
	sbfe_datefirstseen               := le.SBFE.SBFEDateFirstCycleAll;
	judg_filed_count12               := le.Lien_And_Judgment.JudgmentFiledCount12;
	judg_filed_count                 := le.Lien_And_Judgment.JudgmentCount;
	sbfe_dlq_datelastseen            := le.SBFE.SBFEDPDDateLastSeen;
	inq_lastseen                     := le.Inquiry.InquiryDateLastSeen;
	prop_count                       := le.Asset_Information.AssetPropertyCount;
	prop_assessed_value_total        := le.Asset_Information.AssetPropertyAssessedTotal;
	phn_input_firstseen_id           := le.Verification.PhoneMatchDateFirstSeenID;
	ver_phn_src_id_count             := le.Verification.PhoneMatchSourceCountID;
	assoc_bankruptcy_total           := le.Associates.AssociateBankruptCount;
	ucc_lastseen                     := le.Public_Record.UCCInitialFilingDateLastSeen;
	ucc_terminated_count             := le.Public_Record.UCCTerminatedCount;
	ucc_count                        := le.Public_Record.ucccount;
	ucc_active_count                 := le.Public_Record.UCCActiveCount;
	sbfe_worst_perf06                := le.SBFE.SBFEWorst06;
	sbfe_worst_perf60_loan           := le.SBFE.SBFEWorstLoan60;
	sbfe_worst_perf12_oel            := le.SBFE.SBFEWorstOLine12;
	sbfe_acct_dpd_31p_cnt00_cc       := le.SBFE.SBFEDPD31CountCard;
	sbfe_acct_dpd_31p_cnt06_cc       := le.SBFE.SBFEDPD31CountCard06;
	sbfe_acct_dpd_31p_cnt12_cc       := le.SBFE.SBFEDPD31CountCard12;
	sbfe_acct_dpd_31p_cnt24_cc       := le.SBFE.SBFEDPD31CountCard24;
	sbfe_acct_dpd_31p_cnt36_cc       := le.SBFE.SBFEDPD31CountCard36;
	sbfe_acct_dpd_31p_cnt60_cc       := le.SBFE.SBFEDPD31CountCard60;
	sbfe_acct_dpd_31p_cnt84_cc       := le.SBFE.SBFEDPD31CountCard84;
	sbfe_acct_dpd_31p_cnt_cc         := le.SBFE.SBFEDPD31CountCardEver;
	sbfe_acct_dpd_91p_cnt00_lse      := le.SBFE.SBFEDPD91CountLease;
	sbfe_acct_dpd_91p_cnt06_lse      := le.SBFE.SBFEDPD91CountLease06;
	sbfe_acct_dpd_91p_cnt12_lse      := le.SBFE.SBFEDPD91CountLease12;
	sbfe_acct_dpd_91p_cnt24_lse      := le.SBFE.SBFEDPD91CountLease24;
	sbfe_acct_dpd_91p_cnt36_lse      := le.SBFE.SBFEDPD91CountLease36;
	sbfe_acct_dpd_91p_cnt60_lse      := le.SBFE.SBFEDPD91CountLease60;
	sbfe_acct_dpd_91p_cnt84_lse      := le.SBFE.SBFEDPD91CountLease84;
	sbfe_acct_dpd_91p_cnt_lse        := le.SBFE.SBFEDPD91CountLeaseEver;
	sbfe_util_pct                    := le.SBFE.SBFEUtilizationCurrentRevolving;
	sbfe_avg_util_pct24              := le.SBFE.SBFEUtilizationAve24;
	sbfe_avg_past_due_amt24          := le.SBFE.SBFEDPDAveAmount24;
	sbfe_avg_past_due_amt            := le.SBFE.SBFEDPDAveAmountEver;
	sbfe_avg_util_pct12              := le.SBFE.SBFEUtilizationAve12;
	sbfe_worst_perf84                := le.SBFE.SBFEWorst84;
	sbfe_acct_dpd_91p_cnt84          := le.SBFE.SBFEDPD91Count84;
	sbfe_acct_dpd_91p_cnt06_cc       := le.SBFE.SBFEDPD91CountCard06;
	sbfe_chargeoff_cnt               := le.SBFE.SBFEChargeoffCount;
	sbfe_avg_util_pct06_cc           := le.SBFE.SBFEUtilizationAve06Card;
	sbfe_avg_util_pct24_cc           := le.SBFE.SBFEUtilizationAve24Card;
	sbfe_acct_dpd_91p_cnt24          := le.SBFE.SBFEDPD91Count24;
	sbfe_avg_util_pct12_cc           := le.SBFE.SBFEUtilizationAve12Card;
	sbfe_acct_dpd_91p_cnt00          := le.SBFE.SBFEDPD91Count;
	truedid                          := ri.truedid;
	nas_summary                      := ri.iid.nas_summary;
	nap_summary                      := ri.iid.nap_summary;
	ver_sources                      := ri.header_summary.ver_sources;
	ver_sources_first_seen           := ri.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := ri.header_summary.ver_sources_last_seen_date;
	addrpop                          := ri.input_validation.address;
	util_adl_type_list               := ri.utility.utili_adl_type;
	util_adl_count                   := ri.utility.utili_adl_count;
	util_adl_first_seen              := ri.utility.utili_adl_earliest_dt_first_seen;
	add_input_naprop                 := ri.address_verification.input_address_information.naprop;
	property_owned_total             := ri.address_verification.owned.property_total;
	add_curr_lres                    := ri.lres2;
	add_curr_avm_auto_val            := ri.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := ri.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := ri.address_verification.address_history_1.naprop;
	add_prev_naprop                  := ri.address_verification.address_history_2.naprop;
	avg_lres                         := ri.other_address_info.avg_lres;
	gong_did_last_seen               := ri.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	header_first_seen                := ri.ssn_verification.header_first_seen;
	adls_per_addr_curr               := ri.velocity_counters.adls_per_addr_current;
	invalid_addrs_per_adl            := ri.velocity_counters.invalid_addrs_per_adl;
	inq_auto_count                   := ri.acc_logs.auto.counttotal;
	inq_auto_count01                 := ri.acc_logs.auto.count01;
	inq_auto_count03                 := ri.acc_logs.auto.count03;
	inq_auto_count06                 := ri.acc_logs.auto.count06;
	inq_auto_count12                 := ri.acc_logs.auto.count12;
	inq_auto_count24                 := ri.acc_logs.auto.count24;
	inq_collection_count             := ri.acc_logs.collection.counttotal;
	inq_collection_count01           := ri.acc_logs.collection.count01;
	inq_collection_count03           := ri.acc_logs.collection.count03;
	inq_collection_count06           := ri.acc_logs.collection.count06;
	inq_collection_count12           := ri.acc_logs.collection.count12;
	inq_collection_count24           := ri.acc_logs.collection.count24;
	inq_communications_count24       := ri.acc_logs.communications.count24;
	inq_highriskcredit_count         := ri.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := ri.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := ri.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := ri.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := ri.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := ri.acc_logs.highriskcredit.count24;
	inq_other_count                  := ri.acc_logs.other.counttotal;
	inq_other_count01                := ri.acc_logs.other.count01;
	inq_other_count03                := ri.acc_logs.other.count03;
	inq_other_count06                := ri.acc_logs.other.count06;
	inq_other_count12                := ri.acc_logs.other.count12;
	inq_other_count24                := ri.acc_logs.other.count24;
	inq_banko_cm_first_seen          := ri.acc_logs.cm_first_seen_date;
	inq_banko_om_last_seen           := ri.acc_logs.om_last_seen_date;
	pb_first_seen                    := ri.ibehavior.cnsmr_date_first_seen;
	pb_last_seen                     := ri.ibehavior.cnsmr_date_last_seen;
	pb_number_of_sources             := ri.ibehavior.number_of_sources;
	pb_average_dollars               := ri.ibehavior.average_amount_per_order;
	br_first_seen                    := ri.employment.first_seen_date;
	br_business_count                := ri.employment.business_ct;
	br_dead_business_count           := ri.employment.dead_business_ct;
	br_active_phone_count            := ri.employment.business_active_phone_ct;
	infutor_nap                      := ri.infutor_phone.infutor_nap;
	stl_inq_count                    := ri.impulse.count;
	email_count                      := ri.email_summary.email_ct;
	email_domain_free_count          := ri.email_summary.email_domain_free_ct;
	email_domain_edu_count           := ri.email_summary.email_domain_edu_ct;
	attr_total_number_derogs         := ri.total_number_derogs;
	attr_num_unrel_liens30           := ri.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := ri.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := ri.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := ri.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := ri.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := ri.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := ri.bjl.liens_unreleased_count60;
	attr_num_rel_liens30             := ri.bjl.liens_released_count30;
	attr_num_rel_liens90             := ri.bjl.liens_released_count90;
	attr_num_rel_liens180            := ri.bjl.liens_released_count180;
	attr_num_rel_liens12             := ri.bjl.liens_released_count12;
	attr_num_rel_liens24             := ri.bjl.liens_released_count24;
	attr_num_rel_liens36             := ri.bjl.liens_released_count36;
	attr_num_rel_liens60             := ri.bjl.liens_released_count60;
	attr_bankruptcy_count30          := ri.bjl.bk_count30;
	attr_bankruptcy_count90          := ri.bjl.bk_count90;
	attr_bankruptcy_count180         := ri.bjl.bk_count180;
	attr_bankruptcy_count12          := ri.bjl.bk_count12;
	attr_bankruptcy_count24          := ri.bjl.bk_count24;
	attr_bankruptcy_count36          := ri.bjl.bk_count36;
	attr_bankruptcy_count60          := ri.bjl.bk_count60;
	attr_eviction_count              := ri.bjl.eviction_count;
	attr_eviction_count90            := ri.bjl.eviction_count90;
	attr_eviction_count180           := ri.bjl.eviction_count180;
	attr_eviction_count12            := ri.bjl.eviction_count12;
	attr_eviction_count24            := ri.bjl.eviction_count24;
	attr_eviction_count36            := ri.bjl.eviction_count36;
	attr_eviction_count60            := ri.bjl.eviction_count60;
	fp_vardobcountnew                := ri.fdattributesv2.variationdobcountnew;
	fp_srchunvrfdssncount            := ri.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := ri.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchfraudsrchcountmo          := ri.fdattributesv2.searchfraudsearchcountmonth;
	fp_curraddractivephonelist       := ri.fdattributesv2.curraddractivephonelist;
	fp_prevaddrstatus                := ri.fdattributesv2.prevaddrstatus;
	bankrupt                         := ri.bjl.bankrupt;
	disposition                      := ri.bjl.disposition;
	filing_count                     := ri.bjl.filing_count;
	bk_chapter                       := ri.bjl.bk_chapter;
	bk_disposed_historical_count     := ri.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := ri.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := ri.bjl.liens_historical_unreleased_count;
	liens_historical_released_count  := ri.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := ri.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_sc_ct                := ri.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := ri.liens.liens_released_small_claims.count;
	criminal_last_date               := ri.bjl.last_criminal_date;
	historical_count                 := ri.vehicles.historical_count;
	acc_count                        := ri.accident_data.acc.num_accidents;
	acc_last_seen                    := ri.accident_data.acc.datelastaccident;
	college_file_type                := ri.student.file_type2;
	college_tier                     := ri.student.college_tier;
	college_attendance               := ri.attended_college;
	prof_license_flag                := ri.professional_license.professional_license_flag;



	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

source_ar := __common__( Models.Common.findw_cpp(ver_src_list, 'AR' ,  , '') > 0 ) ;

source_ba := __common__( Models.Common.findw_cpp(ver_src_list, 'BA' ,  , '') > 0 ) ;

source_bm := __common__( Models.Common.findw_cpp(ver_src_list, 'BM' ,  , '') > 0 ) ;

source_c := __common__( Models.Common.findw_cpp(ver_src_list, 'C' , ' ,' , '') > 0 ) ;

source_cs := __common__( Models.Common.findw_cpp(ver_src_list, 'C#' ,  , '') > 0 ) ;

source_dn := __common__( Models.Common.findw_cpp(ver_src_list, 'DN' ,  , '') > 0 ) ;

source_ef := __common__( Models.Common.findw_cpp(ver_src_list, 'EF' ,  , '') > 0 ) ;

source_ft := __common__( Models.Common.findw_cpp(ver_src_list, 'FT' ,  , '') > 0 ) ;

source_i := __common__( Models.Common.findw_cpp(ver_src_list, 'I' ,  , '') > 0 ) ;

source_ia := __common__( Models.Common.findw_cpp(ver_src_list, 'IA' ,  , '') > 0 ) ;

source_in := __common__( Models.Common.findw_cpp(ver_src_list, 'IN' ,  , '') > 0 ) ;

source_l2 := __common__( Models.Common.findw_cpp(ver_src_list, 'L2' ,  , '') > 0 ) ;

source_p := __common__( Models.Common.findw_cpp(ver_src_list, 'P' ,  , '') > 0 ) ;

source_ut := __common__( Models.Common.findw_cpp(ver_src_list, 'UT' ,  , '') > 0 ) ;

source_v2 := __common__( Models.Common.findw_cpp(ver_src_list, 'V2' ,  , '') > 0 ) ;

source_wk := __common__( Models.Common.findw_cpp(ver_src_list, 'WK' ,  , '') > 0 ) ;

sysdate := __common__( common.sas_date(if(history_date=999999 or history_date = 0, (STRING)Std.Date.Today(), (string6)history_date+'01')) ) ;

sysdate_days := __common__( common.sas_date(if(((string)history_datetime)[1..6]='999999' or history_datetime = 0, (STRING)Std.Date.Today(), (string)history_datetime)) ) ;

_ver_src_id_br_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BR' , '  ,', 'ie') ) ;

_ver_src_id__br := __common__( _ver_src_id_br_pos > 0 ) ;

_ver_src_id_c_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C' , '  ,', 'ie') ) ;

_ver_src_id__c := __common__( _ver_src_id_c_pos > 0 ) ;

_ver_src_id_d_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'D' , '  ,', 'ie') ) ;

_ver_src_id__d := __common__( _ver_src_id_d_pos > 0 ) ;

_ver_src_id_df_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DF' , '  ,', 'ie') ) ;

_ver_src_id__df := __common__( _ver_src_id_df_pos > 0 ) ;

_ver_src_id_dn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DN' , '  ,', 'ie') ) ;

_ver_src_id__dn := __common__( _ver_src_id_dn_pos > 0 ) ;

_ver_src_id_fb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FB' , '  ,', 'ie') ) ;

_ver_src_id__fb := __common__( _ver_src_id_fb_pos > 0 ) ;

_ver_src_id_l0_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L0' , '  ,', 'ie') ) ;

_ver_src_id__l0 := __common__( _ver_src_id_l0_pos > 0 ) ;

_ver_src_id_l2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'L2' , '  ,', 'ie') ) ;

_ver_src_id__l2 := __common__( _ver_src_id_l2_pos > 0 ) ;

_ver_src_id_u2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'U2' , '  ,', 'ie') ) ;

_ver_src_id__u2 := __common__( _ver_src_id_u2_pos > 0 ) ;

_ver_src_id_ar_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'AR' , '  ,', 'ie') ) ;

_ver_src_id__ar := __common__( _ver_src_id_ar_pos > 0 ) ;

_ver_src_id_ba_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BA' , '  ,', 'ie') ) ;

_ver_src_id__ba := __common__( _ver_src_id_ba_pos > 0 ) ;

_ver_src_id_bm_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BM' , '  ,', 'ie') ) ;

_ver_src_id__bm := __common__( _ver_src_id_bm_pos > 0 ) ;

_ver_src_id_bn_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BN' , '  ,', 'ie') ) ;

_ver_src_id__bn := __common__( _ver_src_id_bn_pos > 0 ) ;

_ver_src_id_cu_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CU' , '  ,', 'ie') ) ;

_ver_src_id__cu := __common__( _ver_src_id_cu_pos > 0 ) ;

_ver_src_id_da_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'DA' , '  ,', 'ie') ) ;

_ver_src_id__da := __common__( _ver_src_id_da_pos > 0 ) ;

_ver_src_id_ef_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EF' , '  ,', 'ie') ) ;

_ver_src_id__ef := __common__( _ver_src_id_ef_pos > 0 ) ;

_ver_src_id_fi_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FI' , '  ,', 'ie') ) ;

_ver_src_id__fi := __common__( _ver_src_id_fi_pos > 0 ) ;

_ver_src_id_i_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'I' , '  ,', 'ie') ) ;

_ver_src_id__i := __common__( _ver_src_id_i_pos > 0 ) ;

_ver_src_id_ia_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IA' , '  ,', 'ie') ) ;

_ver_src_id__ia := __common__( _ver_src_id_ia_pos > 0 ) ;

_ver_src_id_in_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IN' , '  ,', 'ie') ) ;

_ver_src_id__in := __common__( _ver_src_id_in_pos > 0 ) ;

_ver_src_id_os_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'OS' , '  ,', 'ie') ) ;

_ver_src_id__os := __common__( _ver_src_id_os_pos > 0 ) ;

_ver_src_id_p_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'P' , '  ,', 'ie') ) ;

_ver_src_id__p := __common__( _ver_src_id_p_pos > 0 ) ;

_ver_src_id_ldate_p := __common__( if(_ver_src_id_p_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_p_pos), '0') ) ;

_ver_src_id_ldate_p2 := __common__( common.sas_date((string)(_ver_src_id_ldate_p)) ) ;

mth__ver_src_id_ldate_p := __common__( if(min(sysdate, _ver_src_id_ldate_p2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_ldate_p2) / 30.5)) ) ;

_ver_src_id_pl_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'PL' , '  ,', 'ie') ) ;

_ver_src_id__pl := __common__( _ver_src_id_pl_pos > 0 ) ;

_ver_src_id_q3_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Q3' , '  ,', 'ie') ) ;

_ver_src_id__q3 := __common__( _ver_src_id_q3_pos > 0 ) ;

_ver_src_id_fdate_q3 := __common__( if(_ver_src_id_q3_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_q3_pos), '0') ) ;

_ver_src_id_fdate_q32 := __common__( common.sas_date((string)(_ver_src_id_fdate_q3)) ) ;

mth__ver_src_id_fdate_q3 := __common__( if(min(sysdate, _ver_src_id_fdate_q32) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_q32) / 30.5)) ) ;

_ver_src_id_sk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SK' , '  ,', 'ie') ) ;

_ver_src_id__sk := __common__( _ver_src_id_sk_pos > 0 ) ;

_ver_src_id_tx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'TX' , '  ,', 'ie') ) ;

_ver_src_id__tx := __common__( _ver_src_id_tx_pos > 0 ) ;

_ver_src_id_v2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V2' , '  ,', 'ie') ) ;

_ver_src_id__v2 := __common__( _ver_src_id_v2_pos > 0 ) ;

_ver_src_id_wa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WA' , '  ,', 'ie') ) ;

_ver_src_id__wa := __common__( _ver_src_id_wa_pos > 0 ) ;

_ver_src_id_by_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'BY' , '  ,', 'ie') ) ;

_ver_src_id__by := __common__( _ver_src_id_by_pos > 0 ) ;

_ver_src_id_cf_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'CF' , '  ,', 'ie') ) ;

_ver_src_id__cf := __common__( _ver_src_id_cf_pos > 0 ) ;

_ver_src_id_e_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'E' , '  ,', 'ie') ) ;

_ver_src_id__e := __common__( _ver_src_id_e_pos > 0 ) ;

_ver_src_id_ey_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'EY' , '  ,', 'ie') ) ;

_ver_src_id__ey := __common__( _ver_src_id_ey_pos > 0 ) ;

_ver_src_id_f_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'F' , '  ,', 'ie') ) ;

_ver_src_id__f := __common__( _ver_src_id_f_pos > 0 ) ;

_ver_src_id_fk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FK' , '  ,', 'ie') ) ;

_ver_src_id__fk := __common__( _ver_src_id_fk_pos > 0 ) ;

_ver_src_id_fr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FR' , '  ,', 'ie') ) ;

_ver_src_id__fr := __common__( _ver_src_id_fr_pos > 0 ) ;

_ver_src_id_ft_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'FT' , '  ,', 'ie') ) ;

_ver_src_id__ft := __common__( _ver_src_id_ft_pos > 0 ) ;

_ver_src_id_gr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GR' , '  ,', 'ie') ) ;

_ver_src_id__gr := __common__( _ver_src_id_gr_pos > 0 ) ;

_ver_src_id_h7_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'H7' , '  ,', 'ie') ) ;

_ver_src_id__h7 := __common__( _ver_src_id_h7_pos > 0 ) ;

_ver_src_id_ic_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IC' , '  ,', 'ie') ) ;

_ver_src_id__ic := __common__( _ver_src_id_ic_pos > 0 ) ;

_ver_src_id_ip_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IP' , '  ,', 'ie') ) ;

_ver_src_id__ip := __common__( _ver_src_id_ip_pos > 0 ) ;

_ver_src_id_is_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IS' , '  ,', 'ie') ) ;

_ver_src_id__is := __common__( _ver_src_id_is_pos > 0 ) ;

_ver_src_id_it_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'IT' , '  ,', 'ie') ) ;

_ver_src_id__it := __common__( _ver_src_id_it_pos > 0 ) ;

_ver_src_id_j2_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'J2' , '  ,', 'ie') ) ;

_ver_src_id__j2 := __common__( _ver_src_id_j2_pos > 0 ) ;

_ver_src_id_kc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'KC' , '  ,', 'ie') ) ;

_ver_src_id__kc := __common__( _ver_src_id_kc_pos > 0 ) ;

_ver_src_id_mh_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MH' , '  ,', 'ie') ) ;

_ver_src_id__mh := __common__( _ver_src_id_mh_pos > 0 ) ;

_ver_src_id_mw_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'MW' , '  ,', 'ie') ) ;

_ver_src_id__mw := __common__( _ver_src_id_mw_pos > 0 ) ;

_ver_src_id_np_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NP' , '  ,', 'ie') ) ;

_ver_src_id__np := __common__( _ver_src_id_np_pos > 0 ) ;

_ver_src_id_nr_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'NR' , '  ,', 'ie') ) ;

_ver_src_id__nr := __common__( _ver_src_id_nr_pos > 0 ) ;

_ver_src_id_sa_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SA' , '  ,', 'ie') ) ;

_ver_src_id__sa := __common__( _ver_src_id_sa_pos > 0 ) ;

_ver_src_id_sb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SB' , '  ,', 'ie') ) ;

_ver_src_id__sb := __common__( _ver_src_id_sb_pos > 0 ) ;

_ver_src_id_sg_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SG' , '  ,', 'ie') ) ;

_ver_src_id__sg := __common__( _ver_src_id_sg_pos > 0 ) ;

_ver_src_id_sj_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SJ' , '  ,', 'ie') ) ;

_ver_src_id__sj := __common__( _ver_src_id_sj_pos > 0 ) ;

_ver_src_id_sp_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'SP' , '  ,', 'ie') ) ;

_ver_src_id__sp := __common__( _ver_src_id_sp_pos > 0 ) ;

_ver_src_id_ut_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'UT' , '  ,', 'ie') ) ;

_ver_src_id__ut := __common__( _ver_src_id_ut_pos > 0 ) ;

_ver_src_id_v_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'V' , '  ,', 'ie') ) ;

_ver_src_id__v := __common__( _ver_src_id_v_pos > 0 ) ;

_ver_src_id_wb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WB' , '  ,', 'ie') ) ;

_ver_src_id__wb := __common__( _ver_src_id_wb_pos > 0 ) ;

_ver_src_id_wc_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WC' , '  ,', 'ie') ) ;

_ver_src_id__wc := __common__( _ver_src_id_wc_pos > 0 ) ;

_ver_src_id_wk_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WK' , '  ,', 'ie') ) ;

_ver_src_id__wk := __common__( _ver_src_id_wk_pos > 0 ) ;

_ver_src_id_wx_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'WX' , '  ,', 'ie') ) ;

_ver_src_id__wx := __common__( _ver_src_id_wx_pos > 0 ) ;

_ver_src_id_zo_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'ZO' , '  ,', 'ie') ) ;

_ver_src_id__zo := __common__( _ver_src_id_zo_pos > 0 ) ;

_ver_src_id_y_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'Y' , '  ,', 'ie') ) ;

_ver_src_id__y := __common__( _ver_src_id_y_pos > 0 ) ;

_ver_src_id_gb_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'GB' , '  ,', 'ie') ) ;

_ver_src_id__gb := __common__( _ver_src_id_gb_pos > 0 ) ;

_ver_src_id_fdate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_firstseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_fdate_gb2 := __common__( common.sas_date((string)(_ver_src_id_fdate_gb)) ) ;

mth__ver_src_id_fdate_gb := __common__( if(min(sysdate, _ver_src_id_fdate_gb2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_fdate_gb2) / 30.5)) ) ;

_ver_src_id_ldate_gb := __common__( if(_ver_src_id_gb_pos > 0, Models.Common.getw(ver_src_id_lastseen_list, _ver_src_id_gb_pos), '0') ) ;

_ver_src_id_ldate_gb2 := __common__( common.sas_date((string)(_ver_src_id_ldate_gb)) ) ;

mth__ver_src_id_ldate_gb := __common__( if(min(sysdate, _ver_src_id_ldate_gb2) = NULL, NULL, ROUNDUP((sysdate - _ver_src_id_ldate_gb2) / 30.5)) ) ;

_ver_src_id_cs_pos := __common__( Models.Common.findw_cpp(ver_src_id_list, 'C#' , ' ,', 'ie') ) ;

_ver_src_id__cs := __common__( _ver_src_id_cs_pos > 0 ) ;

_ne_ver_src_id_count_1 := __common__( (integer)_ver_src_id__br +
    (integer)_ver_src_id__c +
    (integer)_ver_src_id__d +
    (integer)_ver_src_id__df +
    (integer)_ver_src_id__dn +
    (integer)_ver_src_id__fb +
    (integer)_ver_src_id__l0 +
    (integer)_ver_src_id__l2 +
    (integer)_ver_src_id__u2 +
    (integer)_ver_src_id__ar +
    (integer)_ver_src_id__ba +
    (integer)_ver_src_id__bm +
    (integer)_ver_src_id__bn +
    (integer)_ver_src_id__cu +
    (integer)_ver_src_id__da +
    (integer)_ver_src_id__ef +
    (integer)_ver_src_id__fi +
    (integer)_ver_src_id__i +
    (integer)_ver_src_id__ia +
    (integer)_ver_src_id__in +
    (integer)_ver_src_id__os +
    (integer)_ver_src_id__p +
    (integer)_ver_src_id__pl +
    (integer)_ver_src_id__q3 +
    (integer)_ver_src_id__sk +
    (integer)_ver_src_id__tx +
    (integer)_ver_src_id__v2 +
    (integer)_ver_src_id__wa +
    (integer)_ver_src_id__by +
    (integer)_ver_src_id__cf +
    (integer)_ver_src_id__e +
    (integer)_ver_src_id__ey +
    (integer)_ver_src_id__f +
    (integer)_ver_src_id__fk +
    (integer)_ver_src_id__fr +
    (integer)_ver_src_id__ft +
    (integer)_ver_src_id__gr +
    (integer)_ver_src_id__h7 +
    (integer)_ver_src_id__ic +
    (integer)_ver_src_id__ip +
    (integer)_ver_src_id__is +
    (integer)_ver_src_id__it +
    (integer)_ver_src_id__j2 +
    (integer)_ver_src_id__kc +
    (integer)_ver_src_id__mh +
    (integer)_ver_src_id__mw +
    (integer)_ver_src_id__np +
    (integer)_ver_src_id__nr +
    (integer)_ver_src_id__sa +
    (integer)_ver_src_id__sb +
    (integer)_ver_src_id__sg +
    (integer)_ver_src_id__sj +
    (integer)_ver_src_id__sp +
    (integer)_ver_src_id__ut +
    (integer)_ver_src_id__v +
    (integer)_ver_src_id__wb +
    (integer)_ver_src_id__wc +
    (integer)_ver_src_id__wk +
    (integer)_ver_src_id__wx +
    (integer)_ver_src_id__zo +
    (integer)_ver_src_id__y +
    (integer)_ver_src_id__gb +
    (integer)_ver_src_id__cs ) ;

_ne_ver_src_id_count := __common__( if((integer)ver_src_id_count = -1, -1, _ne_ver_src_id_count_1) ) ;

truebiz := __common__( id_seleID != '0' and NOT((_ne_ver_src_id_count in [-1, 0]) and (integer)sbfe_acct_cnt < 1) ) ;

ne_bv_truebiz_category := __common__( map(
    id_seleID = '0'                                         				 => '0 NO BIP ID',
    (_ne_ver_src_id_count in [-1, 0]) and (integer)sbfe_acct_cnt < 1 => '1 NOT TRUEBIZ',
    (_ne_ver_src_id_count in [-1, 0])                      					 => '2 SBFE ONLY',
    (integer)sbfe_acct_cnt < 1                                       => '3 LN ONLY',
																																				'4 SBFE AND LN') ) ;

seg_business_score := __common__( map(
    (ne_bv_truebiz_category in ['4 SBFE AND LN', '2 SBFE ONLY']) => 'LN & SBFE',
    ne_bv_truebiz_category = '3 LN ONLY'                         => 'LN ONLY',
                                                                    'UNSCORABLE') ) ;

iv_rv5_unscorable := __common__( if(NAS_Summary <= 4 and NAP_Summary <= 4 and Infutor_NAP <= 4 and Add_Input_NAProp <= 3 and NOT TrueDID, 1, 0) ) ;

vs_gb_id_mth_fseen := __common__( mth__ver_src_id_fdate_gb ) ;

vs_gb_id_mth_lseen := __common__( mth__ver_src_id_ldate_gb ) ;

vs_ver_src_id__bm := __common__( (INTEGER)_ver_src_id__bm ) ;

vs_ver_src_id__in := __common__( (INTEGER)_ver_src_id__in ) ;

vs_adl_util_i := __common__( if(util_adl_type_list = '', -1, (integer)(contains_i(util_adl_type_list, '1') > 0)) ) ;

vs_util_adl_count := __common__( if(not(truedid), NULL, util_adl_count) ) ;

_util_adl_first_seen := __common__( common.sas_date((string)(util_adl_first_seen)) ) ;

vs_util_adl_mths_fs := __common__( map(
    not(truedid)                => NULL,
    _util_adl_first_seen = NULL => -1,
                                   (sysdate - _util_adl_first_seen) / (365.25 / 12)) ) ;

_gong_did_last_seen := __common__( common.sas_date((string)(gong_did_last_seen)) ) ;

vs_gong_adl_mths_ls := __common__( map(
    not(truedid)               => NULL,
    _gong_did_last_seen = NULL => -1,
                                  (sysdate - _gong_did_last_seen) / (365.25 / 12)) ) ;

_header_first_seen := __common__( common.sas_date((string)(header_first_seen)) ) ;

vs_header_mths_fs := __common__( map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 (sysdate - _header_first_seen) / (365.25 / 12)) ) ;

_pb_first_seen := __common__( common.sas_date((string)(pb_first_seen)) ) ;

vs_pb_mths_fs := __common__( map(
    not(truedid)          => NULL,
    _pb_first_seen = NULL => -1,
                             // (sysdate - _pb_first_seen) / (365.25 / 12)) ) ;
                             -1) ) ;  // reason code edit for iBehavior removal

_pb_last_seen := __common__( common.sas_date((string)(pb_last_seen)) ) ;

vs_pb_mths_ls := __common__( map(
    not(truedid)         => NULL,
    _pb_last_seen = NULL => -1,
                            // (sysdate - _pb_last_seen) / (365.25 / 12)) ) ;
                            -1) ) ;  // reason code edit for iBehavior removal

vs_pb_number_of_sources := __common__( map(
		not(truedid) 							=> -1, 
		pb_number_of_sources = '' => NULL,
																 // (INTEGER)pb_number_of_sources) ) ;
																 -1) ) ;  // reason code edit for iBehavior removal

_br_first_seen_1 := __common__( common.sas_date((string)(br_First_seen)) ) ;

vs_br_mths_fs := __common__( map(
    not(truedid)            => NULL,
    _br_first_seen_1 = NULL => -1,
                               (sysdate - _br_first_seen_1) / (365.25 / 12)) ) ;

vs_br_business_count := __common__( if(not(truedid), -1, br_business_count) ) ;

vs_br_dead_business_count := __common__( if(not(truedid), -1, br_dead_business_count) ) ;

vs_br_active_phone_count := __common__( if(not(truedid), -1, br_active_phone_count) ) ;

vs_email_count := __common__( if(not(truedid), -1, email_count) ) ;

vs_email_domain_free_count := __common__( if(not(truedid), -1, email_domain_free_count) ) ;

vs_email_domain_edu_count := __common__( if(not(truedid), -1, email_domain_EDU_count) ) ;

vs_historical_count := __common__( if(not(truedid), -1, historical_count) ) ;

vs_college_tier := __common__( map(not(truedid) => -1,
											 college_tier = '' => NULL,
																					(integer)college_tier) ) ;

vs_prof_license_flag := __common__( if(not(truedid), -1, (INTEGER)prof_license_flag) ) ;

ver_src_cons_vo_pos := __common__( Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie') ) ;

ver_src_cons_ldate_vo := __common__( if(ver_src_cons_vo_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_cons_vo_pos), '0') ) ;

ver_src_cons_wp_pos := __common__( Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie') ) ;

ver_src_cons_am_pos := __common__( Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie') ) ;

ver_src_cons_e1_pos := __common__( Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie') ) ;

_ver_src_cons_ldate_vo := __common__( common.sas_date((string)(ver_src_cons_ldate_vo)) ) ;

vs_ver_src_cons_vo_mths_ls := __common__( map(
    not(truedid)                  => NULL,
    _ver_src_cons_ldate_vo = NULL => -1,
                                     (sysdate - _ver_src_cons_ldate_vo) / (365.25 / 12)) ) ;

vs_ver_sources_wp_pop := __common__( if(not(truedid), NULL, (INTEGER)(ver_src_cons_wp_pos > 0)) ) ;

vs_ver_sources_am_pop := __common__( if(not(truedid), NULL, (INTEGER)(ver_src_cons_am_pos > 0)) ) ;

vs_ver_sources_e1_pop := __common__( if(not(truedid), NULL, (INTEGER)(ver_src_cons_e1_pos > 0)) ) ;

c_vs_gb_id_mth_fseen_w := __common__( map(
    vs_gb_id_mth_fseen = NULL  => 0.00000,
    vs_gb_id_mth_fseen <= 3.5  => 0.91610,
    vs_gb_id_mth_fseen <= 7.5  => 0.88764,
    vs_gb_id_mth_fseen <= 13.5 => 0.76509,
    vs_gb_id_mth_fseen <= 19.5 => 0.60945,
    vs_gb_id_mth_fseen <= 24.5 => 0.35735,
    vs_gb_id_mth_fseen <= 32.5 => 0.22964,
    vs_gb_id_mth_fseen <= 39.5 => 0.21626,
    vs_gb_id_mth_fseen <= 43.5 => 0.08935,
    vs_gb_id_mth_fseen <= 52.5 => 0.05666,
    vs_gb_id_mth_fseen <= 85.5 => -0.00212,
    vs_gb_id_mth_fseen <= 97.5 => -0.19392,
                                  -0.33280) ) ;

c_vs_gb_id_mth_lseen_w := __common__( map(
    vs_gb_id_mth_lseen = NULL   => 0.00000,
    vs_gb_id_mth_lseen <= 13.5  => 0.27213,
    vs_gb_id_mth_lseen <= 38.5  => -0.05875,
    vs_gb_id_mth_lseen <= 50.5  => -0.22762,
    vs_gb_id_mth_lseen <= 125.5 => -0.24205,
    vs_gb_id_mth_lseen <= 136.5 => -0.28738,
                                   -0.44975) ) ;

c_vs_ver_src_id__bm_w := __common__( map(
    vs_ver_src_id__bm = NULL => 0.00000,
    vs_ver_src_id__bm <= 0   => 0.00329,
                                -1.30107) ) ;

c_vs_ver_src_id__in_w := __common__( map(
    vs_ver_src_id__in = NULL => 0.00000,
    vs_ver_src_id__in <= 0.5 => 0.00723,
                                -0.84185) ) ;

c_vs_util_adl_count_w := __common__( map(
    vs_util_adl_count = NULL => 0.00000,
    vs_util_adl_count <= 0.5 => -0.21937,
    vs_util_adl_count <= 1.5 => -0.06067,
    vs_util_adl_count <= 2.5 => 0.15314,
    vs_util_adl_count <= 4.5 => 0.29960,
    vs_util_adl_count <= 6.5 => 0.44774,
    vs_util_adl_count <= 7.5 => 0.53142,
                                0.64580) ) ;

c_vs_util_adl_mths_fs_w := __common__( map(
    vs_util_adl_mths_fs = NULL           => 0.00000,
    vs_util_adl_mths_fs = -1             => -0.17300,
    vs_util_adl_mths_fs <= 18.1190965095 => 0.17201,
    vs_util_adl_mths_fs <= 43.0554414785 => 0.30402,
    vs_util_adl_mths_fs <= 63.09650924   => 0.45759,
                                            0.77814) ) ;

c_vs_gong_adl_mths_ls_w := __common__( map(
    vs_gong_adl_mths_ls = NULL           => 0.00000,
    vs_gong_adl_mths_ls = -1             => 0.18245,
    vs_gong_adl_mths_ls <= 1.1663244353  => -0.25396,
    vs_gong_adl_mths_ls <= 43.6468172485 => 0.12138,
    vs_gong_adl_mths_ls <= 98.316221766  => 0.17905,
    vs_gong_adl_mths_ls <= 131.039014375 => 0.25395,
                                            0.32975) ) ;

c_vs_header_mths_fs_w := __common__( map(
    vs_header_mths_fs = NULL           => 0.00000,
    vs_header_mths_fs = -1             => 0.00000,
    vs_header_mths_fs <= 52.501026694  => 0.98807,
    vs_header_mths_fs <= 77.979466119  => 0.71402,
    vs_header_mths_fs <= 102.981519505 => 0.59182,
    vs_header_mths_fs <= 115.006160165 => 0.42455,
    vs_header_mths_fs <= 125.026694045 => 0.41659,
    vs_header_mths_fs <= 128.016427105 => 0.35482,
    vs_header_mths_fs <= 151.014373715 => 0.29992,
    vs_header_mths_fs <= 233.971252565 => 0.18535,
    vs_header_mths_fs <= 266.480492815 => 0.15573,
    vs_header_mths_fs <= 273.034907595 => 0.11123,
    vs_header_mths_fs <= 286.50513347  => 0.07083,
    vs_header_mths_fs <= 288.476386035 => -0.00697,
    vs_header_mths_fs <= 302.488706365 => -0.04193,
    vs_header_mths_fs <= 337.002053385 => -0.08453,
    vs_header_mths_fs <= 344           => -0.12862,
    vs_header_mths_fs <= 357.010266945 => -0.19123,
    vs_header_mths_fs <= 360.985626285 => -0.23830,
    vs_header_mths_fs <= 403.991786445 => -0.30308,
    vs_header_mths_fs <= 426.989733055 => -0.31986,
                                          -0.46326) ) ;

c_vs_pb_mths_fs_w := __common__( map(
    vs_pb_mths_fs = NULL          => 0.00000,
    vs_pb_mths_fs = -1            => 0.23415,
    vs_pb_mths_fs <= 3.2361396304 => 0.32015,
    vs_pb_mths_fs <= 18.858316222 => 0.26246,
                                     -0.15106) ) ;

c_vs_pb_mths_ls_w := __common__( map(
    vs_pb_mths_ls = NULL           => 0.00000,
    vs_pb_mths_ls = -1             => 0.23415,
    vs_pb_mths_ls <= 0.0164271047  => -0.15414,
    vs_pb_mths_ls <= 36.4845995895 => 0.13227,
    vs_pb_mths_ls <= 37.470225873  => 0.17374,
    vs_pb_mths_ls <= 41.4620123205 => 0.20298,
    vs_pb_mths_ls <= 42.4640657085 => 0.38828,
                                      0.50692) ) ;

c_vs_pb_number_of_sources_w := __common__( map(
    vs_pb_number_of_sources = NULL => 0.00000,
    vs_pb_number_of_sources = -1   => 0.00000,
    vs_pb_number_of_sources <= 1.5 => 0.13516,
    vs_pb_number_of_sources <= 2.5 => -0.00289,
    vs_pb_number_of_sources <= 4.5 => -0.05995,
    vs_pb_number_of_sources <= 6.5 => -0.19746,
                                      -0.23315) ) ;

c_vs_br_mths_fs_w := __common__( map(
    vs_br_mths_fs = NULL           => 0.00000,
    vs_br_mths_fs = -1             => 0.15995,
    vs_br_mths_fs <= 40.0328542095 => 0.16446,
    vs_br_mths_fs <= 46.045174538  => 0.10620,
    vs_br_mths_fs <= 52.0574948665 => 0.06927,
    vs_br_mths_fs <= 79.9835728955 => -0.02668,
    vs_br_mths_fs <= 113.954825465 => -0.16575,
    vs_br_mths_fs <= 215.047227925 => -0.23042,
    vs_br_mths_fs <= 259.466119095 => -0.32882,
    vs_br_mths_fs <= 288.887063655 => -0.56406,
    vs_br_mths_fs <= 439.03080082  => -0.64676,
                                      -0.90995) ) ;

c_vs_br_dead_business_count_w := __common__( map(
    vs_br_dead_business_count = NULL => 0.00000,
    vs_br_dead_business_count = -1   => 0.00000,
    vs_br_dead_business_count <= 0.5 => -0.03651,
                                        0.11377) ) ;

c_vs_br_active_phone_count_w := __common__( map(
    vs_br_active_phone_count = NULL => 0.00000,
    vs_br_active_phone_count = -1   => 0.00000,
    vs_br_active_phone_count <= 0.5 => 0.14873,
    vs_br_active_phone_count <= 1.5 => -0.14960,
    vs_br_active_phone_count <= 2.5 => -0.31082,
    vs_br_active_phone_count <= 3.5 => -0.39871,
    vs_br_active_phone_count <= 4.5 => -0.47623,
    vs_br_active_phone_count <= 5.5 => -0.82346,
                                       -0.95214) ) ;

c_vs_email_count_w := __common__( map(
    vs_email_count = NULL => 0.00000,
    vs_email_count = -1   => 0.00000,
    vs_email_count <= 0   => 0.12660,
    vs_email_count <= 1   => -0.04445,
    vs_email_count <= 2   => -0.07738,
    vs_email_count <= 5   => -0.10033,
    vs_email_count <= 9.5 => 0.21847,
                             0.58567) ) ;

c_vs_email_domain_free_count_w := __common__( map(
    vs_email_domain_free_count = NULL => 0.00000,
    vs_email_domain_free_count = -1   => 0.00000,
    vs_email_domain_free_count <= 0.5 => -0.06058,
    vs_email_domain_free_count <= 1.5 => 0.02192,
    vs_email_domain_free_count <= 2.5 => 0.09472,
    vs_email_domain_free_count <= 3.5 => 0.17439,
    vs_email_domain_free_count <= 4.5 => 0.37563,
                                         0.51286) ) ;

c_vs_email_domain_edu_count_w := __common__( map(
    vs_email_domain_edu_count = NULL => 0.00000,
    vs_email_domain_edu_count = -1   => 0.00000,
    vs_email_domain_edu_count <= 0.5 => 0.00745,
                                        -0.39425) ) ;

c_vs_college_tier_w := __common__( map(
    vs_college_tier = NULL => 0.00000,
    vs_college_tier = -1   => 1.11226,
    vs_college_tier <= 1.5 => -0.80274,
    vs_college_tier <= 2.5 => -0.31965,
    vs_college_tier <= 3.5 => -0.05275,
    vs_college_tier <= 4.5 => 0.10779,
                              0.54352) ) ;

c_vs_prof_license_flag_w := __common__( map(
    vs_prof_license_flag = NULL => 0.00000,
    vs_prof_license_flag = -1   => 0.00000,
    vs_prof_license_flag <= 0.5 => 0.05818,
                                   -0.38783) ) ;

c_vs_ver_src_cons_vo_mths_ls_w := __common__( map(
    vs_ver_src_cons_vo_mths_ls = NULL          => 0.00000,
    vs_ver_src_cons_vo_mths_ls = -1            => 0.01379,
    vs_ver_src_cons_vo_mths_ls <= 1.0020533881 => -0.24285,
                                                  0.31383) ) ;

c_vs_ver_sources_am_pop_w := __common__( map(
    vs_ver_sources_am_pop = NULL => 0.00000,
    vs_ver_sources_am_pop <= 0.5 => 0.00790,
                                    -0.50074) ) ;

bv_bus_rep_source_profile := __common__( -2.39363071732448 +
    c_vs_gb_id_mth_fseen_w * 0.561921735535521 +
    c_vs_gb_id_mth_lseen_w * 0.446192049813919 +
    c_vs_ver_src_id__bm_w * 0.815988410427249 +
    c_vs_ver_src_id__in_w * 0.722107251116503 +
    c_vs_util_adl_count_w * 0.23652709024066 +
    c_vs_util_adl_mths_fs_w * 0.834215722197455 +
    c_vs_gong_adl_mths_ls_w * 0.642495107692174 +
    c_vs_header_mths_fs_w * 0.45748271601604 +
    c_vs_pb_mths_fs_w * 0.314196492271953 +
    c_vs_pb_mths_ls_w * 0.384212704955365 +
    c_vs_pb_number_of_sources_w * 0.465079988542644 +
    c_vs_br_mths_fs_w * 0.466139725154086 +
    c_vs_br_dead_business_count_w * 1.85569892438593 +
    c_vs_br_active_phone_count_w * 0.432879002285089 +
    c_vs_email_count_w * 0.430921169156664 +
    c_vs_email_domain_free_count_w * 0.866803684901861 +
    c_vs_email_domain_edu_count_w * 1.01800026256824 +
    c_vs_college_tier_w * 0.982093772667627 +
    c_vs_prof_license_flag_w * 0.660765941536277 +
    c_vs_ver_src_cons_vo_mths_ls_w * 0.677134518064185 +
    c_vs_ver_sources_am_pop_w * 0.860183034397654 ) ;

r_vs_adl_util_i_w := __common__( map(
    vs_adl_util_i = NULL => 0.00000,
    vs_adl_util_i = -1   => -0.21442,
    vs_adl_util_i <= 0.5 => 0.16661,
                            0.32090) ) ;

r_vs_util_adl_count_w := __common__( map(
    vs_util_adl_count = NULL  => 0.00000,
    vs_util_adl_count <= 0.5  => -0.21937,
    vs_util_adl_count <= 1.5  => -0.06067,
    vs_util_adl_count <= 2.5  => 0.15314,
    vs_util_adl_count <= 4.5  => 0.29960,
    vs_util_adl_count <= 6.5  => 0.44774,
    vs_util_adl_count <= 7.5  => 0.53142,
    vs_util_adl_count <= 11.5 => 0.58502,
                                 0.80562) ) ;

r_vs_util_adl_mths_fs_w := __common__( map(
    vs_util_adl_mths_fs = NULL           => 0.00000,
    vs_util_adl_mths_fs = -1             => -0.17300,
    vs_util_adl_mths_fs <= 18.1190965095 => 0.17201,
    vs_util_adl_mths_fs <= 43.0554414785 => 0.30402,
    vs_util_adl_mths_fs <= 63.09650924   => 0.45759,
                                            0.77814) ) ;

r_vs_gong_adl_mths_ls_w := __common__( map(
    vs_gong_adl_mths_ls = NULL           => 0.00000,
    vs_gong_adl_mths_ls = -1             => 0.18245,
    vs_gong_adl_mths_ls <= 1.1663244353  => -0.25396,
    vs_gong_adl_mths_ls <= 43.6468172485 => 0.12138,
    vs_gong_adl_mths_ls <= 98.316221766  => 0.17905,
                                            0.26491) ) ;

r_vs_header_mths_fs_w := __common__( map(
    vs_header_mths_fs = NULL           => 0.00000,
    vs_header_mths_fs = -1             => 0.00000,
    vs_header_mths_fs <= 52.501026694  => 0.98807,
    vs_header_mths_fs <= 77.979466119  => 0.71402,
    vs_header_mths_fs <= 102.981519505 => 0.59182,
    vs_header_mths_fs <= 125.026694045 => 0.42053,
    vs_header_mths_fs <= 128.016427105 => 0.35482,
    vs_header_mths_fs <= 151.014373715 => 0.29992,
    vs_header_mths_fs <= 233.971252565 => 0.18535,
    vs_header_mths_fs <= 266.480492815 => 0.15573,
    vs_header_mths_fs <= 273.034907595 => 0.11123,
    vs_header_mths_fs <= 286.50513347  => 0.07083,
    vs_header_mths_fs <= 288.476386035 => -0.00697,
    vs_header_mths_fs <= 302.488706365 => -0.04193,
    vs_header_mths_fs <= 337.002053385 => -0.08453,
    vs_header_mths_fs <= 344           => -0.12862,
    vs_header_mths_fs <= 357.010266945 => -0.19123,
    vs_header_mths_fs <= 360.985626285 => -0.23830,
    vs_header_mths_fs <= 403.991786445 => -0.30308,
    vs_header_mths_fs <= 426.989733055 => -0.31986,
                                          -0.46326) ) ;

r_vs_pb_mths_fs_w := __common__( map(
    vs_pb_mths_fs = NULL          => 0.00000,
    vs_pb_mths_fs = -1            => 0.23415,
    vs_pb_mths_fs <= 18.858316222 => 0.29443,
                                     -0.15106) ) ;

r_vs_pb_mths_ls_w := __common__( map(
    vs_pb_mths_ls = NULL           => 0.00000,
    vs_pb_mths_ls = -1             => 0.23415,
    vs_pb_mths_ls <= 0.0164271047  => -0.15414,
    vs_pb_mths_ls <= 41.4620123205 => 0.16069,
    vs_pb_mths_ls <= 42.4640657085 => 0.38828,
                                      0.50692) ) ;

r_vs_pb_number_of_sources_w := __common__( map(
    vs_pb_number_of_sources = NULL => 0.00000,
    vs_pb_number_of_sources = -1   => 0.00000,
    vs_pb_number_of_sources <= 1.5 => 0.13516,
    vs_pb_number_of_sources <= 2.5 => -0.00289,
    vs_pb_number_of_sources <= 4.5 => -0.05995,
    vs_pb_number_of_sources <= 6.5 => -0.19746,
                                      -0.23315) ) ;

r_vs_br_mths_fs_w := __common__( map(
    vs_br_mths_fs = NULL           => 0.00000,
    vs_br_mths_fs = -1             => 0.15995,
    vs_br_mths_fs <= 17.527720739  => 0.17528,
    vs_br_mths_fs <= 40.0328542095 => 0.15277,
    vs_br_mths_fs <= 46.045174538  => 0.10620,
    vs_br_mths_fs <= 52.0574948665 => 0.06927,
    vs_br_mths_fs <= 71.0143737165 => -0.02151,
    vs_br_mths_fs <= 79.9835728955 => -0.03871,
    vs_br_mths_fs <= 113.954825465 => -0.16575,
    vs_br_mths_fs <= 122.529774125 => -0.21536,
    vs_br_mths_fs <= 215.047227925 => -0.23296,
    vs_br_mths_fs <= 222.899383985 => -0.29299,
    vs_br_mths_fs <= 259.466119095 => -0.33784,
    vs_br_mths_fs <= 288.887063655 => -0.56406,
    vs_br_mths_fs <= 439.03080082  => -0.64676,
                                      -0.90995) ) ;

r_vs_br_business_count_w := __common__( map(
    vs_br_business_count = NULL  => 0.00000,
    vs_br_business_count = -1    => 0.00000,
    vs_br_business_count <= 0.5  => 0.17346,
    vs_br_business_count <= 1.5  => 0.03279,
    vs_br_business_count <= 2.5  => -0.01283,
    vs_br_business_count <= 4.5  => -0.06774,
    vs_br_business_count <= 6.5  => -0.08541,
    vs_br_business_count <= 10.5 => -0.12807,
    vs_br_business_count <= 12.5 => -0.16932,
                                    -0.41378) ) ;

r_vs_br_dead_business_count_w := __common__( map(
    vs_br_dead_business_count = NULL => 0.00000,
    vs_br_dead_business_count = -1   => 0.00000,
    vs_br_dead_business_count <= 0.5 => -0.03651,
    vs_br_dead_business_count <= 8.5 => 0.11186,
                                        0.19728) ) ;

r_vs_br_active_phone_count_w := __common__( map(
    vs_br_active_phone_count = NULL => 0.00000,
    vs_br_active_phone_count = -1   => 0.00000,
    vs_br_active_phone_count <= 0.5 => 0.14873,
    vs_br_active_phone_count <= 1.5 => -0.14960,
    vs_br_active_phone_count <= 2.5 => -0.31082,
    vs_br_active_phone_count <= 3.5 => -0.39871,
    vs_br_active_phone_count <= 4.5 => -0.47623,
    vs_br_active_phone_count <= 5.5 => -0.82346,
                                       -0.95214) ) ;

r_vs_email_count_w := __common__( map(
    vs_email_count = NULL => 0.00000,
    vs_email_count = -1   => 0.00000,
    vs_email_count <= 0   => 0.12660,
    vs_email_count <= 1   => -0.04445,
    vs_email_count <= 2   => -0.07738,
    vs_email_count <= 3   => -0.11055,
    vs_email_count <= 5   => -0.08999,
    vs_email_count <= 9.5 => 0.21847,
                             0.58567) ) ;

r_vs_email_domain_free_count_w := __common__( map(
    vs_email_domain_free_count = NULL => 0.00000,
    vs_email_domain_free_count = -1   => 1.03909,
    vs_email_domain_free_count <= 0.5 => -0.06342,
    vs_email_domain_free_count <= 1.5 => 0.01909,
    vs_email_domain_free_count <= 2.5 => 0.09188,
    vs_email_domain_free_count <= 3.5 => 0.17155,
    vs_email_domain_free_count <= 4.5 => 0.37279,
                                         0.51003) ) ;

r_vs_email_domain_edu_count_w := __common__( map(
    vs_email_domain_edu_count = NULL => 0.00000,
    vs_email_domain_edu_count = -1   => 0.00000,
    vs_email_domain_edu_count <= 0.5 => 0.00745,
                                        -0.39425) ) ;

r_vs_historical_count_w := __common__( map(
    vs_historical_count = NULL  => 0.00000,
    vs_historical_count = -1    => 0.00000,
    vs_historical_count <= 0.5  => -0.06391,
    vs_historical_count <= 23.5 => 0.04499,
                                   0.25088) ) ;

r_vs_college_tier_w := __common__( map(
    vs_college_tier = NULL => 0.00000,
    vs_college_tier = -1   => 1.11226,
    vs_college_tier <= 1.5 => -0.80274,
    vs_college_tier <= 2.5 => -0.31965,
    vs_college_tier <= 3.5 => -0.05275,
    vs_college_tier <= 4.5 => 0.10779,
                              0.54352) ) ;

r_vs_prof_license_flag_w := __common__( map(
    vs_prof_license_flag = NULL => 0.00000,
    vs_prof_license_flag = -1   => 0.00000,
    vs_prof_license_flag <= 0.5 => 0.05818,
                                   -0.38783) ) ;

r_vs_ver_src_cons_vo_mths_ls_w := __common__( map(
    vs_ver_src_cons_vo_mths_ls = NULL          => 0.00000,
    vs_ver_src_cons_vo_mths_ls = -1            => 0.01379,
    vs_ver_src_cons_vo_mths_ls <= 1.0020533881 => -0.24285,
    vs_ver_src_cons_vo_mths_ls <= 12.501026694 => 0.22439,
                                                  0.32655) ) ;

r_vs_ver_sources_wp_pop_w := __common__( map(
    vs_ver_sources_wp_pop = NULL => 0.00000,
    vs_ver_sources_wp_pop <= 0.5 => 0.17600,
                                    -0.07426) ) ;

r_vs_ver_sources_am_pop_w := __common__( map(
    vs_ver_sources_am_pop = NULL => 0.00000,
    vs_ver_sources_am_pop <= 0.5 => 0.00790,
                                    -0.50074) ) ;

r_vs_ver_sources_e1_pop_w := __common__( map(
    vs_ver_sources_e1_pop = NULL => 0.00000,
    vs_ver_sources_e1_pop <= 0.5 => 0.00829,
                                    -0.10771) ) ;

bv_rep_only_source_profile := __common__( -2.39308403795477 +
    r_vs_adl_util_i_w * 0.0145303904477801 +
    r_vs_util_adl_count_w * 0.301080905323183 +
    r_vs_util_adl_mths_fs_w * 0.784719506644756 +
    r_vs_gong_adl_mths_ls_w * 0.630896965014121 +
    r_vs_header_mths_fs_w * 0.53388040642068 +
    r_vs_pb_mths_fs_w * 0.322051661030712 +
    r_vs_pb_mths_ls_w * 0.375041049591824 +
    r_vs_pb_number_of_sources_w * 0.438136773478832 +
    r_vs_br_mths_fs_w * 0.499172726775049 +
    r_vs_br_business_count_w * 0.00539884864031974 +
    r_vs_br_dead_business_count_w * 1.89910108177779 +
    r_vs_br_active_phone_count_w * 0.477752147732435 +
    r_vs_email_count_w * 0.468259946672664 +
    r_vs_email_domain_free_count_w * 0.619360369537691 +
    r_vs_email_domain_edu_count_w * 1.03144544841865 +
    r_vs_historical_count_w * 1.47932630371083 +
    r_vs_college_tier_w * 0.75027291107173 +
    r_vs_prof_license_flag_w * 0.639957001524596 +
    r_vs_ver_src_cons_vo_mths_ls_w * 0.737884857021843 +
    r_vs_ver_sources_wp_pop_w * 0.0574268119550084 +
    r_vs_ver_sources_am_pop_w * 0.854315518533643 +
    r_vs_ver_sources_e1_pop_w * 0.41909038777041 ) ;

rv_d30_derog_count := __common__( if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999)) ) ;

_criminal_last_date := __common__( common.sas_date((string)(criminal_last_date)) ) ;

rv_d32_mos_since_crim_ls := __common__( map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)) ) ;

rv_d31_mostrec_bk := __common__( map(
    not(truedid)                     																	=> '',
    TRIM(StringLib.StringToUppercase(disposition))[1..7] = 'DISMISS'  => '1 - BK DISMISSED ',
    TRIM(StringLib.StringToUppercase(disposition))[1..8] = 'DISCHARG' => '2 - BK DISCHARGED',
    bankrupt or filing_count > 0 																			=> '3 - BK OTHER     ',
																																				 '0 - NO BK        ') ) ;

rv_a46_curr_avm_autoval := __common__( if(not(truedid), NULL, add_curr_avm_auto_val) ) ;

rv_a49_curr_avm_chg_1yr_pct := __common__( map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL) ) ;

rv_a41_prop_owner := __common__( map(
    not(truedid)                                                                                   => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
                                                                                                      '0') ) ;

rv_e55_college_ind := __common__( map(
    not(truedid)                           => ' ',
    (college_file_type in ['H', 'C', 'A']) => '1',
    college_attendance                     => '1',
                                              '0') ) ;

rv_i60_inq_hiriskcred_recency := __common__( map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count   > 0 => 99,
                                   0) ) ;

rv_c18_invalid_addrs_per_adl := __common__( if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999)) ) ;

rv_d34_attr_liens_recency := __common__( map(
    not(truedid)                                                              => NULL,
    (boolean)attr_num_rel_liens30 or (boolean)attr_num_unrel_liens30          => 1,
    (boolean)attr_num_rel_liens90 or (boolean)attr_num_unrel_liens90          => 3,
    (boolean)attr_num_rel_liens180 or (boolean)attr_num_unrel_liens180        => 6,
    (boolean)attr_num_rel_liens12 or (boolean)attr_num_unrel_liens12          => 12,
    (boolean)attr_num_rel_liens24 or (boolean)attr_num_unrel_liens24          => 24,
    (boolean)attr_num_rel_liens36 or (boolean)attr_num_unrel_liens36          => 36,
    (boolean)attr_num_rel_liens60 or (boolean)attr_num_unrel_liens60          => 60,
    liens_historical_released_count > 0 or liens_historical_unreleased_ct > 0 => 99,
                                                                                 0) ) ;

rv_e58_br_dead_business_count := __common__( if(not(truedid), NULL, min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 999)) ) ;

nf_inq_collection_count := __common__( if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999)) ) ;

_acc_last_seen := __common__( common.sas_date((string)(acc_last_seen)) ) ;

nf_mos_acc_lseen := __common__( map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => -1,
                             min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)) ) ;

rv_d31_bk_chapter := __common__( map(
    not(truedid)    => '',
    bk_chapter = '' => '0',
                       trim(bk_chapter, LEFT)) ) ;

rv_d34_unrel_liens_ct := __common__( if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999)) ) ;

rv_a41_a42_prop_owner_history := __common__( map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER') ) ;

rv_i61_inq_collection_recency := __common__( map(
    not(truedid)           => NULL,
    inq_collection_count01 > 0 => 1,
    inq_collection_count03 > 0 => 3,
    inq_collection_count06 > 0 => 6,
    inq_collection_count12 > 0 => 12,
    inq_collection_count24 > 0 => 24,
    inq_collection_count   > 0 => 99,
                                  0) ) ;

rv_i60_inq_auto_recency := __common__( map(
    not(truedid)     => NULL,
    inq_auto_count01 > 0 => 1,
    inq_auto_count03 > 0 => 3,
    inq_auto_count06 > 0 => 6,
    inq_auto_count12 > 0 => 12,
    inq_auto_count24 > 0 => 24,
    inq_auto_count   > 0 => 99,
                            0) ) ;

br_first_seen_char := __common__( br_first_seen ) ;

_br_first_seen := __common__( common.sas_date((string)(br_first_seen_char)) ) ;

rv_mos_since_br_first_seen := __common__( map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999)) ) ;

iv_d34_liens_rel_sc_ct := __common__( if(not(truedid), NULL, min(if(liens_rel_SC_ct = NULL, -NULL, liens_rel_SC_ct), 999)) ) ;

nf_inq_highriskcredit_count := __common__( if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999)) ) ;

_inq_banko_cm_first_seen := __common__( common.sas_date((string)(Inq_banko_cm_first_seen)) ) ;

nf_mos_inq_banko_cm_fseen := __common__( map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => -1,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999)) ) ;

nf_fp_vardobcountnew := __common__( if(not(truedid), NULL, min(if((INTEGER)fp_vardobcountnew = NULL, -NULL, (INTEGER)fp_vardobcountnew), 999)) ) ;

nf_fp_srchfraudsrchcountmo := __common__( if(not(truedid), NULL, min(if((integer)fp_srchfraudsrchcountmo = NULL, -NULL, (integer)fp_srchfraudsrchcountmo), 999)) ) ;

nf_fp_prevaddrstatus := __common__( if(not(truedid), '', fp_prevaddrstatus) ) ;

bureau_adl_eq_fseen_pos_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') ) ;

bureau_adl_fseen_eq_1 := __common__( if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ',')) ) ;

_bureau_adl_fseen_eq_1 := __common__( common.sas_date((string)(bureau_adl_fseen_eq_1)) ) ;

bureau_adl_en_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E') ) ;

bureau_adl_fseen_en := __common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')) ) ;

_bureau_adl_fseen_en := __common__( common.sas_date((string)(bureau_adl_fseen_en)) ) ;

_src_bureau_adl_fseen_notu := __common__( min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999) ) ;

nf_m_bureau_adl_fs_notu := __common__( map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => -1,
                                           if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))) ) ;

rv_d31_attr_bankruptcy_recency := __common__( map(
    not(truedid)             		 => NULL,
    attr_bankruptcy_count30  > 0 => 1,
    attr_bankruptcy_count90  > 0 => 3,
    attr_bankruptcy_count180 > 0 => 6,
    attr_bankruptcy_count12  > 0 => 12,
    attr_bankruptcy_count24  > 0 => 24,
    attr_bankruptcy_count36  > 0 => 36,
    attr_bankruptcy_count60  > 0 => 60,
    bankrupt                 => 99,
    filing_count > 0         => 99,
                                0) ) ;

rv_d31_bk_disposed_hist_count := __common__( if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999)) ) ;

rv_c21_stl_inq_count := __common__( if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999)) ) ;

rv_d33_eviction_recency := __common__( map(
    not(truedid)                                           => '  ',
    attr_eviction_count90 > 0                              => '03',
    attr_eviction_count180 > 0                             => '06',
    attr_eviction_count12 > 0                              => '12',
    attr_eviction_count24 > 0 and attr_eviction_count >= 2 => '24',
    attr_eviction_count24 > 0                              => '25',
    attr_eviction_count36 > 0 and attr_eviction_count >= 2 => '36',
    attr_eviction_count36 > 0                              => '37',
    attr_eviction_count60 > 0 and attr_eviction_count >= 2 => '60',
    attr_eviction_count60 > 0                              => '61',
    attr_eviction_count >= 2                               => '98',
    attr_eviction_count >= 1                               => '99',
                                                              '00') ) ;

rv_d34_unrel_lien60_count := __common__( if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999)) ) ;

bureau_adl_eq_fseen_pos := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') ) ;

bureau_adl_fseen_eq := __common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')) ) ;

_bureau_adl_fseen_eq := __common__( common.sas_date((string)(bureau_adl_fseen_eq)) ) ;

_src_bureau_adl_fseen := __common__( min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999) ) ;

rv_c20_m_bureau_adl_fs := __common__( map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999)) ) ;

rv_i61_inq_collection_count12 := __common__( if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999)) ) ;

rv_l79_adls_per_addr_curr := __common__( if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999)) ) ;

rv_a50_pb_average_dollars := __common__( map(
    not(truedid)            => NULL,
    pb_average_dollars = '' => -1,
                               // (integer)pb_average_dollars) ) ;
                               -1) ) ;  // reason code edit for iBehavior removal

iv_c13_avg_lres := __common__( if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999)) ) ;

rv_i60_inq_other_recency := __common__( map(
    not(truedid)      => NULL,
    inq_other_count01 > 0 => 1,
    inq_other_count03 > 0 => 3,
    inq_other_count06 > 0 => 6,
    inq_other_count12 > 0 => 12,
    inq_other_count24 > 0 => 24,
    inq_other_count   > 0 => 99,
                             0) ) ;

iv_d34_liens_unrel_cj_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_CJ_ct = NULL, -NULL, liens_unrel_CJ_ct), 999)) ) ;

iv_d34_liens_unrel_sc_ct := __common__( if(not(truedid), NULL, min(if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct), 999)) ) ;

nf_inq_auto_count := __common__( if(not(truedid), NULL, min(if(inq_Auto_count = NULL, -NULL, inq_Auto_count), 999)) ) ;

nf_inq_communications_count24 := __common__( if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999)) ) ;

_inq_banko_om_last_seen := __common__( common.sas_date((string)(Inq_banko_om_last_seen)) ) ;

nf_mos_inq_banko_om_lseen := __common__( map(
    not(truedid)                   => NULL,
    _inq_banko_om_last_seen = NULL => -1,
                                      min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999)) ) ;

nf_accident_count := __common__( if(not(truedid), NULL, min(if(acc_count = NULL, -NULL, acc_count), 999)) ) ;

nf_fp_srchunvrfdssncount := __common__( if(not(truedid), NULL, min(if((integer)fp_srchunvrfdssncount = NULL, -NULL, (integer)fp_srchunvrfdssncount), 999)) ) ;

nf_fp_srchunvrfdaddrcount := __common__( if(not(truedid), NULL, min(if((integer)fp_srchunvrfdaddrcount = NULL, -NULL, (integer)fp_srchunvrfdaddrcount), 999)) ) ;

nf_fp_curraddractivephonelist := __common__( map(
    not(truedid)                      => '',
    fp_curraddractivephonelist = ''   => '',
                                         trim(fp_curraddractivephonelist, LEFT)) ) ;

td_sbfe_avg_util_pct06 := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct06) ) ;

td_acct_dpd_1p_recency := __common__( map(
    not(truebiz)               => NULL,
    (integer)sbfe_acct_dpd_1p_cnt00 > 0 => 1,
    (integer)sbfe_acct_dpd_1p_cnt06 > 0 => 6,
    (integer)sbfe_acct_dpd_1p_cnt12 > 0 => 12,
    (integer)sbfe_acct_dpd_1p_cnt24 > 0 => 24,
    (integer)sbfe_acct_dpd_1p_cnt36 > 0 => 36,
    (integer)sbfe_acct_dpd_1p_cnt60 > 0 => 60,
    (integer)sbfe_acct_dpd_1p_cnt84 > 0 => 84,
    (integer)sbfe_acct_dpd_1p_cnt > 0   => 99,
																					 (integer)sbfe_acct_dpd_1p_cnt) ) ;

_sbfe_acct_datefirstopen := __common__( common.sas_date((string)(sbfe_acct_datefirstopen)) ) ;

td_mth_acct_firstopen := __common__( map(
    not(truebiz)                    => NULL,
    _sbfe_acct_datefirstopen = NULL => -1,
    (integer)sbfe_acct_cnt = -99    => -99,
                                       if ((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_acct_datefirstopen) / (365.25 / 12)))) ) ;

td_sbfe_avg_util_pct_cc := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct_cc) ) ;

td_sbfe_util_pct_cc := __common__( if(not(truebiz), NULL, (integer)sbfe_util_pct_cc) ) ;

_sos_inc_filing_firstseen := __common__( common.sas_date((string)(sos_inc_filing_firstseen)) ) ;

bv_sos_mth_fs := __common__( map(
    not(truebiz)                     => NULL,
    _sos_inc_filing_firstseen = NULL => -1,
                                        if ((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12) >= 0, roundup((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)), truncate((sysdate - _sos_inc_filing_firstseen) / (365.25 / 12)))) ) ;

td_sbfe_closed_pct_invol := __common__( map(
    not(truebiz)         					=> NULL,
    (integer)sbfe_closed_cnt <= 0 => (integer)sbfe_closed_cnt,
																		 (integer)sbfe_closed_cnt_invol / (integer)sbfe_closed_cnt) ) ;

num_pos_sources := __common__( if(max((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk) = 0, 0, sum((integer)source_ar, (integer)source_bm, (integer)source_c, (integer)source_cs, (integer)source_dn, (integer)source_ef, (integer)source_ft, (integer)source_i, (integer)source_ia, (integer)source_in, (integer)source_p, (integer)source_v2, (integer)source_wk)) ) ;

num_neg_sources := __common__( if(max((integer)source_ba, (integer)source_l2, (integer)source_ut) = 0, 0, sum((integer)source_ba, (integer)source_l2, (integer)source_ut)) ) ;

bv_ver_src_derog_ratio := __common__( map(
    not(truebiz)                                                                                                                                                    => NULL,
    ver_src_list = ''                                                                                                                                             => -1,
    if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources))) = 0 => -2,
    num_neg_sources > 0                                                                                                                                             => round(num_neg_sources / if(max(num_pos_sources, num_neg_sources) = NULL, NULL, sum(if(num_pos_sources = NULL, 0, num_pos_sources), if(num_neg_sources = NULL, 0, num_neg_sources)))/.1)*.1,
                                                                                                                                                                       100 + num_pos_sources) ) ;

bv_mth_ver_src_q3_fs := __common__( if(not(_ver_src_id__q3), -1, mth__ver_src_id_fdate_q3) ) ;

_sbfe_datefirstseen := __common__( common.sas_date((string)(sbfe_datefirstseen)) ) ;

td_mth_sbfe_datefirstseen := __common__( map(
    not(truebiz)               		=> NULL,
    (integer)sbfe_acct_cnt = -99  => -99,
    _sbfe_datefirstseen = NULL 		=> -1,
																		 if ((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_datefirstseen) / (365.25 / 12)))) ) ;

td_acct_pct_closed := __common__( map(
    not(truebiz)        				 => NULL,
    (INTEGER)sbfe_acct_cnt = -99 => -99,
    (INTEGER)sbfe_closed_cnt = 0 => 0,
																		10 * if (10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt >= 0, roundup(10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt), truncate(10 * (integer)sbfe_closed_cnt / (integer)sbfe_acct_cnt))) ) ;

_sbfe_dlq_datelastseen := __common__( common.sas_date((string)(sbfe_dlq_datelastseen)) ) ;

td_mth_dlq_lastseen := __common__( map(
    not(truebiz)                  => NULL,
    (integer)sbfe_acct_cnt = -99  => -99,
    _sbfe_dlq_datelastseen = NULL => -1,
                                     if ((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12) >= 0, roundup((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12)), truncate((sysdate_days - _sbfe_dlq_datelastseen) / (365.25 / 12)))) ) ;

_inq_lastseen := __common__( common.sas_date((string)(inq_lastseen)) ) ;

bv_mths_inq_lastseen := __common__( map(
    not(truebiz)         => NULL,
    _inq_lastseen = NULL => -1,
                            if ((sysdate - _inq_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _inq_lastseen) / (365.25 / 12)), truncate((sysdate - _inq_lastseen) / (365.25 / 12)))) ) ;

bv_prop_assessed_value := __common__( map(
    not(truebiz)   					=> NULL,
    (integer)prop_count = 0 => -1,
															 (integer)prop_assessed_value_total) ) ;

bv_mth_ver_src_p_ls := __common__( if(not(_ver_src_id__p), -1, mth__ver_src_id_ldate_p) ) ;

bv_lien_judg_index := __common__( map(
    not(truebiz)                                                                                                                                                          																									 => NULL,
    (integer)lien_filed_count03 > 0                                                                                                                                               																					 => 4,
    (integer)lien_filed_count12 > 0 or (integer)judg_filed_count12 > 0                                                                                                                      																 => 3,
    if(max((integer)lien_filed_count, (integer)judg_filed_count) = 0, NULL, sum(if((integer)lien_filed_count = NULL, 0, (integer)lien_filed_count), if((integer)judg_filed_count = NULL, 0, (integer)judg_filed_count))) > 1 => 2,
    if(max((integer)lien_filed_count, (integer)judg_filed_count) = 0, NULL, sum(if((integer)lien_filed_count = NULL, 0, (integer)lien_filed_count), if((integer)judg_filed_count = NULL, 0, (integer)judg_filed_count))) > 0 => 1,
																																																																																																																0) ) ;

_phn_input_firstseen_id := __common__( common.sas_date((string)(phn_input_firstseen_id)) ) ;

bv_src_id_phn_mth_fs := __common__( map(
    not(truebiz)                                              								=> NULL,
		(integer)phn_input_firstseen_id = 0	and (integer)ver_phn_src_id_count > 0 => NULL,
    (integer)ver_phn_src_id_count = 0 or _phn_input_firstseen_id = 0 					=> -1,
																																								 if ((sysdate - _phn_input_firstseen_id) / (365.25 / 12) >= 0, roundup((sysdate - _phn_input_firstseen_id) / (365.25 / 12)), truncate((sysdate - _phn_input_firstseen_id) / (365.25 / 12)))) ) ;

bv_assoc_bk_tot := __common__( map(
    not(truebiz)    				 => NULL,
    (integer)assoc_count = 0 => -1,
																(integer)assoc_bankruptcy_total) ) ;

bv_sos_defunct_status := __common__( map(
    not(truebiz)             				 	=> NULL,
    (integer)sos_inc_filing_count = 0 => -1,
																				 (integer)sos_ever_defunct) ) ;

bv_lien_filed_count := __common__( if(not(truebiz), NULL, (integer)lien_filed_count) ) ;

_ucc_lastseen := __common__( common.sas_date((string)(ucc_lastseen)) ) ;

bv_ucc_mth_ls := __common__( map(
    not(truebiz)         => NULL,
    _ucc_lastseen = NULL => -1,
                            if ((sysdate - _ucc_lastseen) / (365.25 / 12) >= 0, roundup((sysdate - _ucc_lastseen) / (365.25 / 12)), truncate((sysdate - _ucc_lastseen) / (365.25 / 12)))) ) ;

bv_ucc_index := __common__( map(
    not(truebiz)                                                           					 => NULL,
    0 <= bv_ucc_mth_ls AND bv_ucc_mth_ls <= 12 and (integer)ucc_terminated_count = 0 => 0,
    (integer)ucc_count = 0                                                           => 1,
    0 <= bv_ucc_mth_ls AND bv_ucc_mth_ls <= 12 or (integer)ucc_terminated_count = 0  => 2,
    (integer)ucc_active_count > 3                                                    => 3,
																																												4) ) ;

td_sbfe_worst_perf06 := __common__( if(not(truebiz), NULL, (integer)sbfe_worst_perf06) ) ;

td_sbfe_worst_perf60_loan := __common__( if(not(truebiz), NULL, (integer)sbfe_worst_perf60_loan) ) ;

td_sbfe_worst_perf12_oel := __common__( if(not(truebiz), NULL, (integer)sbfe_worst_perf12_oel) ) ;

td_acct_dpd_31p_recency_cc := __common__( map(
    not(truebiz)                   					=> NULL,
    (integer)sbfe_acct_dpd_31p_cnt00_cc > 0 => 1,
    (integer)sbfe_acct_dpd_31p_cnt06_cc > 0 => 6,
    (integer)sbfe_acct_dpd_31p_cnt12_cc > 0 => 12,
    (integer)sbfe_acct_dpd_31p_cnt24_cc > 0 => 24,
    (integer)sbfe_acct_dpd_31p_cnt36_cc > 0 => 36,
    (integer)sbfe_acct_dpd_31p_cnt60_cc > 0 => 60,
    (integer)sbfe_acct_dpd_31p_cnt84_cc > 0 => 84,
    (integer)sbfe_acct_dpd_31p_cnt_cc > 0   => 99,
																							 (integer)sbfe_acct_dpd_31p_cnt_cc) ) ;

td_acct_dpd_91p_recency_lse := __common__( map(
    not(truebiz)                    				 => NULL,
    (integer)sbfe_acct_dpd_91p_cnt00_lse > 0 => 1,
    (integer)sbfe_acct_dpd_91p_cnt06_lse > 0 => 6,
    (integer)sbfe_acct_dpd_91p_cnt12_lse > 0 => 12,
    (integer)sbfe_acct_dpd_91p_cnt24_lse > 0 => 24,
    (integer)sbfe_acct_dpd_91p_cnt36_lse > 0 => 36,
    (integer)sbfe_acct_dpd_91p_cnt60_lse > 0 => 60,
    (integer)sbfe_acct_dpd_91p_cnt84_lse > 0 => 84,
    (integer)sbfe_acct_dpd_91p_cnt_lse > 0   => 99,
																								(integer)sbfe_acct_dpd_91p_cnt_lse) ) ;

td_sbfe_util_pct := __common__( if(not(truebiz), NULL, (integer)sbfe_util_pct) ) ;

td_sbfe_avg_util_pct24 := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct24) ) ;

td_sbfe_avg_past_due_amt24 := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_past_due_amt24) ) ;

td_sbfe_avg_past_due_amt := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_past_due_amt) ) ;

td_sbfe_avg_util_pct12 := __common__( if(not(truebiz), NULL, (integer)sbfe_avg_util_pct12) ) ;

td_sbfe_worst_perf84 := __common__( if(not(truebiz), NULL, (integer)sbfe_worst_perf84) ) ;

bv_assoc_derog_flag := __common__( map(
    not(truebiz)    				 => NULL,
    (integer)assoc_count = 0 => -1,
																(integer)((integer)assoc_felony_count > 0 or (integer)assoc_bankruptcy_count > 0 or (integer)assoc_lien_count > 0 or (integer)assoc_judg_count > 0)) ) ;

s_bv_src_id_phn_mth_fs_w := __common__( map(
    bv_src_id_phn_mth_fs = NULL   => 0.00000,
    bv_src_id_phn_mth_fs = -1     => 0.09629,
    bv_src_id_phn_mth_fs <= 18.5  => 0.52621,
    bv_src_id_phn_mth_fs <= 133.5 => 0.08199,
    bv_src_id_phn_mth_fs <= 166.5 => -0.16664,
    bv_src_id_phn_mth_fs <= 274.5 => -0.24520,
                                     -0.33380) ) ;

s_aa_dist_1 := __common__( (0.00000 - s_bv_src_id_phn_mth_fs_w) * 0.23236 ) ;

s_aa_code_1 := __common__( map(
    s_bv_src_id_phn_mth_fs_w = -0.33380 => '',
    bv_src_id_phn_mth_fs = NULL         => 'B037',
    bv_src_id_phn_mth_fs = -1           => 'B034',
    bv_src_id_phn_mth_fs <= 18.5        => 'B037',
    bv_src_id_phn_mth_fs <= 133.5       => 'B037',
    bv_src_id_phn_mth_fs <= 166.5       => 'B037',
    bv_src_id_phn_mth_fs <= 274.5       => 'B037',
                                           'B037') ) ;

s_bv_assoc_bk_tot_w := __common__( map(
    bv_assoc_bk_tot = NULL => 0.00000,
    bv_assoc_bk_tot = -1   => -0.04540,
    bv_assoc_bk_tot <= 0.5 => -0.07936,
    bv_assoc_bk_tot <= 1.5 => 0.79029,
                              0.96416) ) ;

s_aa_dist_2 := __common__( (0.00000 - s_bv_assoc_bk_tot_w) * 0.27649 ) ;

s_aa_code_2 := __common__( map(
    s_bv_assoc_bk_tot_w = -0.07936 => '',
    bv_assoc_bk_tot = NULL         => 'B031',
    bv_assoc_bk_tot = -1           => 'B017',
    bv_assoc_bk_tot <= 0.5         => 'B026',
    bv_assoc_bk_tot <= 1.5         => 'B026',
                                      'B026') ) ;

s_bv_sos_defunct_status_w := __common__( map(
    bv_sos_defunct_status = NULL => 0.00000,
    bv_sos_defunct_status = -1   => 0.05566,
    bv_sos_defunct_status <= 0.5 => -0.06841,
                                    0.61119) ) ;

s_aa_dist_3 := __common__( (0.00000 - s_bv_sos_defunct_status_w) * 0.75604 ) ;

s_aa_code_3 := __common__( map(
    s_bv_sos_defunct_status_w = -0.06841 => '',
    bv_sos_defunct_status = NULL         => 'B031',
    bv_sos_defunct_status = -1           => 'B055',
    bv_sos_defunct_status <= 0.5         => 'B055',
                                            'B059') ) ;

s_bv_lien_filed_count_w := __common__( map(
    bv_lien_filed_count = NULL => 0.00000,
    bv_lien_filed_count <= 1.5 => -0.03939,
    bv_lien_filed_count <= 3.5 => 1.04260,
                                  1.25250) ) ;

s_aa_dist_4 := __common__( (0.00000 - s_bv_lien_filed_count_w) * 0.32029 ) ;

s_aa_code_4 := __common__( map(
    s_bv_lien_filed_count_w = -0.03939 => '',
    bv_lien_filed_count = NULL         => 'B031',
    bv_lien_filed_count <= 1.5         => 'B063',
    bv_lien_filed_count <= 3.5         => 'B063',
                                          'B063') ) ;

s_bv_ucc_index_w := __common__( map(
    bv_ucc_index = NULL => 0.00000,
    bv_ucc_index <= 2.5 => 0.02762,
    bv_ucc_index <= 3.5 => -0.23569,
                           -0.50858) ) ;

s_aa_dist_5 := __common__( (0.00000 - s_bv_ucc_index_w) * 0.78948 ) ;

s_aa_code_5 := __common__( map(
    s_bv_ucc_index_w = -0.50858 => '',
    bv_ucc_index = NULL         => 'B031',
    bv_ucc_index <= 2.5         => 'B066',
    bv_ucc_index <= 3.5         => 'B066',
                                   'B066') ) ;

s_bv_prop_assessed_value_w := __common__( map(
    bv_prop_assessed_value = NULL   => 0.00000,
    bv_prop_assessed_value = -1     => 0.06814,
    bv_prop_assessed_value <= 0     => 0.10882,
    bv_prop_assessed_value <= 51728 => 0.06049,
                                       -0.49055) ) ;

s_aa_dist_6 := __common__( (0.00000 - s_bv_prop_assessed_value_w) * 0.74352 ) ;

s_aa_code_6 := __common__( map(
    s_bv_prop_assessed_value_w = -0.49055 => '',
    bv_prop_assessed_value = NULL         => 'B031',
    bv_prop_assessed_value = -1           => 'B052',
    bv_prop_assessed_value <= 0           => 'B053',
    bv_prop_assessed_value <= 51728       => 'B053',
                                             'B053') ) ;

s_td_mth_sbfe_datefirstseen_w := __common__( map(
    td_mth_sbfe_datefirstseen = NULL  => 0.00000,
    td_mth_sbfe_datefirstseen = -1    => -0.03310,
    td_mth_sbfe_datefirstseen <= 10.5 => 0.54958,
    td_mth_sbfe_datefirstseen <= 20.5 => 0.35712,
                                         -0.03310) ) ;

s_aa_dist_7 := __common__( (0.00000 - s_td_mth_sbfe_datefirstseen_w) * 0.60977 ) ;

s_aa_code_7 := __common__( map(
    s_td_mth_sbfe_datefirstseen_w = -0.03310 => '',
    td_mth_sbfe_datefirstseen = NULL         => 'BF105',
    td_mth_sbfe_datefirstseen = -1           => 'BF106',
    td_mth_sbfe_datefirstseen <= 10.5        => 'BF106',
    td_mth_sbfe_datefirstseen <= 20.5        => 'BF106',
                                                'BF106') ) ;

s_td_mth_acct_firstopen_w := __common__( map(
    td_mth_acct_firstopen = NULL   => 0.00000,
    td_mth_acct_firstopen = -1     => -0.47594,
    td_mth_acct_firstopen <= 9.5   => 0.65331,
    td_mth_acct_firstopen <= 21.5  => 0.42522,
    td_mth_acct_firstopen <= 107.5 => 0.09130,
    td_mth_acct_firstopen <= 207.5 => -0.11303,
                                      -0.47594) ) ;

s_aa_dist_8 := __common__( (0.00000 - s_td_mth_acct_firstopen_w) * 0.72726 ) ;

s_aa_code_8 := __common__( map(
    s_td_mth_acct_firstopen_w = -0.47594 => '',
    td_mth_acct_firstopen = NULL         => 'BF105',
    td_mth_acct_firstopen = -1           => 'BF117',
    td_mth_acct_firstopen <= 9.5         => 'BF117',
    td_mth_acct_firstopen <= 21.5        => 'BF117',
    td_mth_acct_firstopen <= 107.5       => 'BF117',
    td_mth_acct_firstopen <= 207.5       => 'BF117',
                                            'BF117') ) ;

s_td_mth_dlq_lastseen_w := __common__( map(
    td_mth_dlq_lastseen = NULL  => 0.00000,
    td_mth_dlq_lastseen = -1    => -0.21944,
    td_mth_dlq_lastseen <= 1.5  => 1.18962,
    td_mth_dlq_lastseen <= 2.5  => 0.96075,
    td_mth_dlq_lastseen <= 3.5  => 0.70223,
    td_mth_dlq_lastseen <= 5.5  => 0.58307,
    td_mth_dlq_lastseen <= 43.5 => 0.34582,
                                   0.01962) ) ;

s_aa_dist_9 := __common__( (0.00000 - s_td_mth_dlq_lastseen_w) * 0.23844 ) ;

s_aa_code_9 := __common__( map(
    s_td_mth_dlq_lastseen_w = -0.21944 		=> '',
    td_mth_dlq_lastseen = NULL         		=> 'BF105',
    (integer)sbfe_acct_dpd_91p_cnt84 > 0  => 'BF142',
																						 'BF141') ) ;

s_td_acct_pct_closed_w := __common__( map(
    td_acct_pct_closed = NULL => 0.00000,
    td_acct_pct_closed <= 0   => -0.10037,
    td_acct_pct_closed <= 25  => -0.36144,
    td_acct_pct_closed <= 35  => -0.29274,
    td_acct_pct_closed <= 75  => 0.07234,
                                 0.37230) ) ;

s_aa_dist_10 := __common__( (0.00000 - s_td_acct_pct_closed_w) * 0.46319 ) ;

s_aa_code_10 := __common__( map(
    s_td_acct_pct_closed_w = -0.36144 => '',
    td_acct_pct_closed = NULL         => 'BF105',
    td_acct_pct_closed <= 0           => 'BF113',
    td_acct_pct_closed <= 25          => 'BF113',
    td_acct_pct_closed <= 35          => 'BF113',
    td_acct_pct_closed <= 75          => 'BF113',
                                         'BF113') ) ;

s_td_sbfe_worst_perf06_w := __common__( map(
    td_sbfe_worst_perf06 = NULL => 0.00000,
    td_sbfe_worst_perf06 = -98  => 0.11504,
    td_sbfe_worst_perf06 = -97  => -0.27615,
    td_sbfe_worst_perf06 <= 0.5 => -0.27615,
    td_sbfe_worst_perf06 <= 2.5 => 0.57752,
    td_sbfe_worst_perf06 <= 4.5 => 1.15898,
                                   1.70009) ) ;

s_aa_dist_11 := __common__( (0.00000 - s_td_sbfe_worst_perf06_w) * 0.14616 ) ;

s_aa_code_11 := __common__( map(
    s_td_sbfe_worst_perf06_w = -0.27615 => '',
    td_sbfe_worst_perf06 = NULL         => 'BF141',
    td_sbfe_worst_perf06 = -98          => 'BF125',
    td_sbfe_worst_perf06 = -97          => 'BF141',
    td_sbfe_worst_perf06 <= 0.5         => 'BF141',
    td_sbfe_worst_perf06 <= 2.5         => 'BF141',
    td_sbfe_worst_perf06 <= 4.5         => 'BF141',
    (integer)sbfe_worst_perf06 > 8      => 'BF143',
                                           'BF142') ) ;

s_td_sbfe_worst_perf60_loan_w := __common__( map(
    td_sbfe_worst_perf60_loan = NULL => 0.00000,
    td_sbfe_worst_perf60_loan = -98  => -0.00512,
    td_sbfe_worst_perf60_loan = -97  => -0.26543,
    td_sbfe_worst_perf60_loan <= 0.5 => -0.26543,
    td_sbfe_worst_perf60_loan <= 2.5 => 0.43116,
                                        1.25348) ) ;

s_aa_dist_12 := __common__( (0.00000 - s_td_sbfe_worst_perf60_loan_w) * 0.47246 ) ;

s_aa_code_12 := __common__( map(
    s_td_sbfe_worst_perf60_loan_w = -0.26543 => '',
    td_sbfe_worst_perf60_loan = NULL         => 'BF105',
    td_sbfe_worst_perf60_loan = -98          => 'BF126',
    td_sbfe_worst_perf60_loan = -97          => 'BF141',
    td_sbfe_worst_perf60_loan <= 0.5         => 'BF141',
    td_sbfe_worst_perf60_loan <= 2.5         => 'BF141',
    (integer)sbfe_worst_perf60_loan > 8      => 'BF143',
    (integer)sbfe_worst_perf60_loan > 4      => 'BF142',
                                                'BF141') ) ;

s_td_sbfe_worst_perf12_oel_w := __common__( map(
    td_sbfe_worst_perf12_oel = NULL => 0.00000,
    td_sbfe_worst_perf12_oel = -98  => 0.01437,
    td_sbfe_worst_perf12_oel <= 0.5 => -0.37736,
    td_sbfe_worst_perf12_oel <= 2.5 => 0.63427,
                                       1.27559) ) ;

s_aa_dist_13 := __common__( (0.00000 - s_td_sbfe_worst_perf12_oel_w) * 0.23160 ) ;

s_aa_code_13 := __common__( map(
    s_td_sbfe_worst_perf12_oel_w = -0.37736 => '',
    td_sbfe_worst_perf12_oel = NULL         => 'BF105',
    td_sbfe_worst_perf12_oel = -98          => 'BF127',
    td_sbfe_worst_perf12_oel <= 0.5         => 'BF141',
    td_sbfe_worst_perf12_oel <= 2.5         => 'BF141',
    td_sbfe_worst_perf12_oel > 8            => 'BF143',
    td_sbfe_worst_perf12_oel > 4            => 'BF142',
                                               'BF141') ) ;

s_td_acct_dpd_31p_recency_cc_w := __common__( map(
    td_acct_dpd_31p_recency_cc = NULL => 0.00000,
    td_acct_dpd_31p_recency_cc = -98  => -0.07037,
    td_acct_dpd_31p_recency_cc <= 0.5 => -0.19698,
    td_acct_dpd_31p_recency_cc <= 9   => 1.46265,
    td_acct_dpd_31p_recency_cc <= 18  => 1.30447,
    td_acct_dpd_31p_recency_cc <= 30  => 1.03269,
    td_acct_dpd_31p_recency_cc <= 48  => 0.88635,
    td_acct_dpd_31p_recency_cc <= 72  => 0.47462,
                                         0.29378) ) ;

s_aa_dist_14 := __common__( (0.00000 - s_td_acct_dpd_31p_recency_cc_w) * 0.20843 ) ;

s_aa_code_14 := __common__( map(
    s_td_acct_dpd_31p_recency_cc_w = -0.19698 => '',
    td_acct_dpd_31p_recency_cc = NULL         => 'BF105',
    td_acct_dpd_31p_recency_cc = -98          => 'BF128',
    td_acct_dpd_31p_recency_cc <= 0.5         => 'BF141',
    (integer)sbfe_acct_dpd_91p_cnt06_cc > 0   => 'BF142',
                                                 'BF141') ) ;

s_td_acct_dpd_91p_recency_lse_w := __common__( map(
    td_acct_dpd_91p_recency_lse = NULL => 0.00000,
    td_acct_dpd_91p_recency_lse = -98  => -0.00455,
    td_acct_dpd_91p_recency_lse = -97  => -0.14730,
    td_acct_dpd_91p_recency_lse <= 0.5 => -0.14730,
                                          1.29679) ) ;

s_aa_dist_15 := __common__( (0.00000 - s_td_acct_dpd_91p_recency_lse_w) * 0.37346 ) ;

s_aa_code_15 := __common__( map(
    s_td_acct_dpd_91p_recency_lse_w = -0.14730 => '',
    td_acct_dpd_91p_recency_lse = NULL         => 'BF142',
    td_acct_dpd_91p_recency_lse = -98          => 'BF129',
    td_acct_dpd_91p_recency_lse = -97          => 'BF142',
    td_acct_dpd_91p_recency_lse <= 0.5         => 'BF142',
                                                  'BF142') ) ;

s_td_sbfe_closed_pct_invol_w := __common__( map(
    td_sbfe_closed_pct_invol = NULL          => 0.00000,
    td_sbfe_closed_pct_invol <= 0.0527777778 => -0.15376,
    td_sbfe_closed_pct_invol <= 0.3827838828 => -0.01635,
    td_sbfe_closed_pct_invol <= 0.5527777778 => 0.19416,
                                                0.51314) ) ;

s_aa_dist_16 := __common__( (0.00000 - s_td_sbfe_closed_pct_invol_w) * 0.43846 ) ;

s_aa_code_16 := __common__( map(
    s_td_sbfe_closed_pct_invol_w = -0.15376 => '',
    td_sbfe_closed_pct_invol = NULL         => 'BF105',
    (integer)sbfe_chargeoff_cnt > 0         => 'BF143',
                                               'BF120') ) ;

s_td_sbfe_util_pct_w := __common__( map(
    td_sbfe_util_pct = NULL  => 0.00000,
    td_sbfe_util_pct = -98   => 0.14159,
    td_sbfe_util_pct = -97   => -1.06440,
    td_sbfe_util_pct <= 0    => -0.24796,
    td_sbfe_util_pct <= 6    => -1.06440,
    td_sbfe_util_pct <= 25   => -0.72586,
    td_sbfe_util_pct <= 38.5 => -0.37855,
    td_sbfe_util_pct <= 71.5 => 0.24534,
    td_sbfe_util_pct <= 79.5 => 0.59037,
    td_sbfe_util_pct <= 83.5 => 1.02053,
    td_sbfe_util_pct <= 94.5 => 1.26708,
                                1.56594) ) ;

s_aa_dist_17 := __common__( (0.00000 - s_td_sbfe_util_pct_w) * 0.13927 ) ;

s_aa_code_17 := __common__( map(
    s_td_sbfe_util_pct_w = -1.06440 => '',
    td_sbfe_util_pct = NULL         => 'BF105',
    td_sbfe_util_pct = -98          => 'BF110',
    td_sbfe_util_pct = -97          => 'BF135',
    td_sbfe_util_pct <= 0           => 'BF136',
    td_sbfe_util_pct <= 6           => 'BF135',
    td_sbfe_util_pct <= 25          => 'BF135',
    td_sbfe_util_pct <= 38.5        => 'BF135',
    td_sbfe_util_pct <= 71.5        => 'BF135',
    td_sbfe_util_pct <= 79.5        => 'BF135',
    td_sbfe_util_pct <= 83.5        => 'BF135',
    td_sbfe_util_pct <= 94.5        => 'BF135',
                                       'BF135') ) ;

s_td_sbfe_util_pct_cc_w := __common__( map(
    td_sbfe_util_pct_cc = NULL  => 0.00000,
    td_sbfe_util_pct_cc = -98   => 0.15651,
    td_sbfe_util_pct_cc = -97   => -1.16632,
    td_sbfe_util_pct_cc <= 0.5  => -0.24149,
    td_sbfe_util_pct_cc <= 4.5  => -1.02139,
    td_sbfe_util_pct_cc <= 8.5  => -1.16632,
    td_sbfe_util_pct_cc <= 32.5 => -0.61501,
    td_sbfe_util_pct_cc <= 39.5 => -0.15488,
    td_sbfe_util_pct_cc <= 71.5 => 0.28833,
    td_sbfe_util_pct_cc <= 79.5 => 0.62663,
    td_sbfe_util_pct_cc <= 84.5 => 1.13158,
    td_sbfe_util_pct_cc <= 94.5 => 1.36493,
                                   1.56153) ) ;

s_aa_dist_18 := __common__( (0.00000 - s_td_sbfe_util_pct_cc_w) * 0.23574 ) ;

s_aa_code_18 := __common__( map(
    s_td_sbfe_util_pct_cc_w = -1.16632 => '',
    td_sbfe_util_pct_cc = NULL         => 'BF105',
    td_sbfe_util_pct_cc = -98          => 'BF128',
    td_sbfe_util_pct_cc = -97          => 'BF135',
    td_sbfe_util_pct_cc <= 0.5         => 'BF136',
    td_sbfe_util_pct_cc <= 4.5         => 'BF136',
    td_sbfe_util_pct_cc <= 8.5         => 'BF135',
    td_sbfe_util_pct_cc <= 32.5        => 'BF135',
    td_sbfe_util_pct_cc <= 39.5        => 'BF135',
    td_sbfe_util_pct_cc <= 71.5        => 'BF135',
    td_sbfe_util_pct_cc <= 79.5        => 'BF135',
    td_sbfe_util_pct_cc <= 84.5        => 'BF135',
    td_sbfe_util_pct_cc <= 94.5        => 'BF135',
                                          'BF135') ) ;

s_td_sbfe_avg_util_pct06_w := __common__( map(
    td_sbfe_avg_util_pct06 = NULL  => 0.00000,
    td_sbfe_avg_util_pct06 = -98   => 0.17626,
    td_sbfe_avg_util_pct06 = -97   => -1.05531,
    td_sbfe_avg_util_pct06 <= 0.5  => -0.22747,
    td_sbfe_avg_util_pct06 <= 13.5 => -1.05531,
    td_sbfe_avg_util_pct06 <= 29.5 => -0.58709,
    td_sbfe_avg_util_pct06 <= 42.5 => -0.02656,
    td_sbfe_avg_util_pct06 <= 63.5 => 0.27031,
    td_sbfe_avg_util_pct06 <= 81.5 => 0.47341,
    td_sbfe_avg_util_pct06 <= 87.5 => 1.22009,
    td_sbfe_avg_util_pct06 <= 97.5 => 1.46911,
                                      1.86091) ) ;

s_aa_dist_19 := __common__( (0.00000 - s_td_sbfe_avg_util_pct06_w) * 0.20554 ) ;

s_aa_code_19 := __common__( map(
    s_td_sbfe_avg_util_pct06_w = -1.05531                         				 => '',
    td_sbfe_avg_util_pct06 = NULL                                 				 => 'BF105',
    td_sbfe_avg_util_pct06 = -98 and (integer)sbfe_avg_util_pct06_cc = -98 => 'BF128',
    td_sbfe_avg_util_pct06 = -98                                  				 => 'BF127',
    td_sbfe_avg_util_pct06 = -97                                  				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 0.5                                 				 => 'BF134',
    td_sbfe_avg_util_pct06 <= 13.5                                				 => '',
    td_sbfe_avg_util_pct06 <= 29.5                                				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 42.5                                				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 63.5                                				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 81.5                                				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 87.5                                				 => 'BF133',
    td_sbfe_avg_util_pct06 <= 97.5                                				 => 'BF133',
																																							'BF133') ) ;

s_td_sbfe_avg_util_pct24_w := __common__( map(
    td_sbfe_avg_util_pct24 = NULL  => 0.00000,
    td_sbfe_avg_util_pct24 = -98   => 0.07749,
    td_sbfe_avg_util_pct24 = -97   => -1.11953,
    td_sbfe_avg_util_pct24 <= 0.5  => -0.18055,
    td_sbfe_avg_util_pct24 <= 5.5  => -1.11953,
    td_sbfe_avg_util_pct24 <= 28.5 => -0.60499,
    td_sbfe_avg_util_pct24 <= 51.5 => 0.02566,
    td_sbfe_avg_util_pct24 <= 76.5 => 0.73747,
    td_sbfe_avg_util_pct24 <= 85.5 => 1.19215,
    td_sbfe_avg_util_pct24 <= 94.5 => 1.42545,
                                      1.93178) ) ;

s_aa_dist_20 := __common__( (0.00000 - s_td_sbfe_avg_util_pct24_w) * 0.20150 ) ;

s_aa_code_20 := __common__( map(
    s_td_sbfe_avg_util_pct24_w = -1.11953                        					 => '',
    td_sbfe_avg_util_pct24 = NULL                                					 => 'BF105',
    td_sbfe_avg_util_pct24 = -98 and (integer)sbfe_avg_util_pct24_cc = -98 => 'BF128',
    td_sbfe_avg_util_pct24 = -98                                 					 => 'BF127',
    td_sbfe_avg_util_pct24 = -97                                 					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 0.5                                					 => 'BF134',
    td_sbfe_avg_util_pct24 <= 5.5                                					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 28.5                               					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 51.5                               					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 76.5                               					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 85.5                               					 => 'BF133',
    td_sbfe_avg_util_pct24 <= 94.5                               					 => 'BF133',
																																							'BF133') ) ;

s_td_sbfe_avg_util_pct_cc_w := __common__( map(
    td_sbfe_avg_util_pct_cc = NULL  => 0.00000,
    td_sbfe_avg_util_pct_cc = -98   => 0.02275,
    td_sbfe_avg_util_pct_cc = -97   => -1.06886,
    td_sbfe_avg_util_pct_cc <= 0.5  => -0.23692,
    td_sbfe_avg_util_pct_cc <= 3.5  => -1.06886,
    td_sbfe_avg_util_pct_cc <= 16.5 => -0.63721,
    td_sbfe_avg_util_pct_cc <= 33.5 => -0.14653,
    td_sbfe_avg_util_pct_cc <= 39.5 => 0.28224,
    td_sbfe_avg_util_pct_cc <= 44.5 => 0.46071,
    td_sbfe_avg_util_pct_cc <= 53.5 => 0.60015,
    td_sbfe_avg_util_pct_cc <= 63.5 => 0.86598,
    td_sbfe_avg_util_pct_cc <= 76.5 => 1.12632,
                                       1.61995) ) ;

s_aa_dist_21 := __common__( (0.00000 - s_td_sbfe_avg_util_pct_cc_w) * 0.13800 ) ;

s_aa_code_21 := __common__( map(
    s_td_sbfe_avg_util_pct_cc_w = -1.06886 => '',
    td_sbfe_avg_util_pct_cc = NULL         => 'BF105',
    td_sbfe_avg_util_pct_cc = -98          => 'BF128',
    td_sbfe_avg_util_pct_cc = -97          => 'BF133',
    td_sbfe_avg_util_pct_cc <= 0.5         => 'BF134',
    td_sbfe_avg_util_pct_cc <= 3.5         => 'BF133',
    td_sbfe_avg_util_pct_cc <= 16.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 33.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 39.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 44.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 53.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 63.5        => 'BF133',
    td_sbfe_avg_util_pct_cc <= 76.5        => 'BF133',
                                              'BF133') ) ;

s_td_sbfe_avg_past_due_amt24_w := __common__( map(
    td_sbfe_avg_past_due_amt24 = NULL   => 0.00000,
    td_sbfe_avg_past_due_amt24 = -98    => 0.13695,
    td_sbfe_avg_past_due_amt24 = -97    => -0.42723,
    td_sbfe_avg_past_due_amt24 <= 0.5   => -0.42723,
    td_sbfe_avg_past_due_amt24 <= 2.5   => -0.09972,
    td_sbfe_avg_past_due_amt24 <= 15.5  => 0.34945,
    td_sbfe_avg_past_due_amt24 <= 37.5  => 0.65459,
    td_sbfe_avg_past_due_amt24 <= 112.5 => 0.75849,
    td_sbfe_avg_past_due_amt24 <= 167.5 => 0.89621,
    td_sbfe_avg_past_due_amt24 <= 633.5 => 1.08625,
                                           1.38287) ) ;

s_aa_dist_22 := __common__( (0.00000 - s_td_sbfe_avg_past_due_amt24_w) * 0.24473 ) ;

s_aa_code_22 := __common__( if((integer)sbfe_acct_dpd_91p_cnt24 > 0, 'BF142', 'BF141') ) ;

s_td_sbfe_avg_past_due_amt_w := __common__( map(
    td_sbfe_avg_past_due_amt = NULL   => 0.00000,
    td_sbfe_avg_past_due_amt = -98    => 0.08408,
    td_sbfe_avg_past_due_amt = -97    => -0.41726,
    td_sbfe_avg_past_due_amt <= 0.5   => -0.41726,
    td_sbfe_avg_past_due_amt <= 19.5  => 0.04979,
    td_sbfe_avg_past_due_amt <= 30.5  => 0.35305,
    td_sbfe_avg_past_due_amt <= 197.5 => 0.57809,
    td_sbfe_avg_past_due_amt <= 543.5 => 0.83310,
                                         1.03688) ) ;

s_aa_dist_23 := __common__( (0.00000 - s_td_sbfe_avg_past_due_amt_w) * 0.20638 ) ;

s_aa_code_23 := __common__( if((integer)sbfe_acct_dpd_91p_cnt84 > 0, 'BF142', 'BF141') ) ;

s_bv_ver_src_derog_ratio_w := __common__( map(
    bv_ver_src_derog_ratio = NULL  => 0.00000,
    bv_ver_src_derog_ratio = -1    => -0.39080,
    bv_ver_src_derog_ratio <= 0.25 => 0.15571,
    bv_ver_src_derog_ratio <= 0.35 => 0.60066,
    bv_ver_src_derog_ratio <= 51   => 0.73005,
    bv_ver_src_derog_ratio <= 102  => -0.06279,
                                      -0.39080) ) ;

s_aa_dist_24 := __common__( (0.00000 - s_bv_ver_src_derog_ratio_w) * 0.26224 ) ;

s_aa_code_24 := __common__( map(
    s_bv_ver_src_derog_ratio_w = -0.39080 => '',
    bv_ver_src_derog_ratio = NULL         => 'B031',
    bv_ver_src_derog_ratio = -1           => 'B034',
    source_ba or source_l2        				=> 'B063',
                                             'B034') ) ;

s_rv_d30_derog_count_w := __common__( map(
    rv_d30_derog_count = NULL => 0.00000,
    rv_d30_derog_count <= 0.5 => -0.29187,
    rv_d30_derog_count <= 1.5 => 0.10903,
    rv_d30_derog_count <= 2.5 => 0.42696,
    rv_d30_derog_count <= 5.5 => 0.54183,
    rv_d30_derog_count <= 9.5 => 0.66397,
                                 1.35162) ) ;

s_aa_dist_25 := __common__( (0.00000 - s_rv_d30_derog_count_w) * 0.28197 ) ;

s_aa_code_25 := __common__( map(
    s_rv_d30_derog_count_w = -0.29187 => '',
    rv_d30_derog_count = NULL         => 'P535',
    rv_d30_derog_count <= 0.5         => 'P526',
    rv_d30_derog_count <= 1.5         => 'P526',
    rv_d30_derog_count <= 2.5         => 'P526',
    rv_d30_derog_count <= 5.5         => 'P526',
    rv_d30_derog_count <= 9.5         => 'P526',
                                         'P526') ) ;

s_rv_d32_mos_since_crim_ls_w := __common__( map(
    rv_d32_mos_since_crim_ls = NULL   => 0.00000,
    rv_d32_mos_since_crim_ls = -1     => -0.10038,
    rv_d32_mos_since_crim_ls <= 3.5   => 0.95722,
    rv_d32_mos_since_crim_ls <= 108.5 => 0.38312,
                                         0.03042) ) ;

s_aa_dist_26 := __common__( (0.00000 - s_rv_d32_mos_since_crim_ls_w) * 0.37003 ) ;

s_aa_code_26 := __common__( map(
    s_rv_d32_mos_since_crim_ls_w = -0.10038 => '',
    rv_d32_mos_since_crim_ls = NULL         => 'P535',
    rv_d32_mos_since_crim_ls = -1           => 'P526',
    rv_d32_mos_since_crim_ls <= 3.5         => 'P526',
    rv_d32_mos_since_crim_ls <= 108.5       => 'P526',
                                               'P526') ) ;

s_rv_d31_mostrec_bk_w := __common__( map(
    rv_d31_mostrec_bk = ''                                                        	 => 0.00000,
    (rv_d31_mostrec_bk in [' ', '0 - NO BK'])                                        => -0.07258,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED', '2 - BK DISCHARGED', '3 - BK OTHER']) => 0.91221,
                                                                                        0.00000) ) ;

s_aa_dist_27 := __common__( (0.00000 - s_rv_d31_mostrec_bk_w) * 0.34996 ) ;

s_aa_code_27 := __common__( map(
    s_rv_d31_mostrec_bk_w = -0.07258                                                 => '',
    rv_d31_mostrec_bk =  ''                                                     		 => 'P535',
    (rv_d31_mostrec_bk in [' ', '0 - NO BK'])                                        => 'P526',
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED', '2 - BK DISCHARGED', '3 - BK OTHER']) => 'P526',
                                                                                        'P535') ) ;

s_rv_a46_curr_avm_autoval_w := __common__( map(
    rv_a46_curr_avm_autoval = NULL    => 0.00000,
    rv_a46_curr_avm_autoval <= 0      => -0.01486,
    rv_a46_curr_avm_autoval <= 180000 => 0.21884,
    rv_a46_curr_avm_autoval <= 275000 => -0.00185,
                                         -0.14524) ) ;

s_aa_dist_28 := __common__( (0.00000 - s_rv_a46_curr_avm_autoval_w) * 0.68191 ) ;

s_aa_code_28 := __common__( map(
    s_rv_a46_curr_avm_autoval_w = -0.14524 => '',
    rv_a46_curr_avm_autoval = NULL         => 'P535',
    rv_a46_curr_avm_autoval <= 0           => 'P509',
    rv_a46_curr_avm_autoval <= 180000      => 'P509',
    rv_a46_curr_avm_autoval <= 275000      => 'P509',
                                              'P509') ) ;

s_rv_a49_curr_avm_chg_1yr_pct_w := __common__( map(
    rv_a49_curr_avm_chg_1yr_pct = NULL   => 0.00000,
    rv_a49_curr_avm_chg_1yr_pct <= 88.15 => 0.16262,
                                            -0.06477) ) ;

s_aa_dist_29 := __common__( (0.00000 - s_rv_a49_curr_avm_chg_1yr_pct_w) * 0.77100 ) ;

s_aa_code_29 := __common__( map(
    s_rv_a49_curr_avm_chg_1yr_pct_w = -0.06477                => '',
    rv_a49_curr_avm_chg_1yr_pct = NULL and not(truedid)       => 'P535',
    rv_a49_curr_avm_chg_1yr_pct = NULL and add_curr_lres < 12 => 'P516',
    rv_a49_curr_avm_chg_1yr_pct = NULL                        => 'P509',
    rv_a49_curr_avm_chg_1yr_pct <= 88.15                      => 'P511',
                                                                 'P511') ) ;

s_rv_a41_prop_owner_w := __common__( map(
    rv_a41_prop_owner = '' 	=> 0.00000,
    rv_a41_prop_owner = '0' => 0.74232,
                                -0.04203) ) ;

s_aa_dist_30 := __common__( (0.00000 - s_rv_a41_prop_owner_w) * 0.67200 ) ;

s_aa_code_30 := __common__( map(
    s_rv_a41_prop_owner_w = -0.04203 => '',
    rv_a41_prop_owner = ''           => 'P535',
    rv_a41_prop_owner = '0'          => 'P502',
                                        'P502') ) ;

s_rv_e55_college_ind_w := __common__( map(
    rv_e55_college_ind = ''  => 0.00000,
    rv_e55_college_ind = '0' => 0.06440,
                                 -0.40475) ) ;

s_aa_dist_31 := __common__( (0.00000 - s_rv_e55_college_ind_w) * 0.68125 ) ;

s_aa_code_31 := __common__( map(
    s_rv_e55_college_ind_w = -0.40475 => '',
    rv_e55_college_ind = ''         	=> 'P535',
    rv_e55_college_ind = '0'        	=> 'P532',
                                         'P532') ) ;

s_rv_i60_inq_hiriskcred_rec_w := __common__( map(
    rv_i60_inq_hiriskcred_recency = NULL => 0.00000,
    rv_i60_inq_hiriskcred_recency <= 0.5 => -0.01554,
                                            0.96357) ) ;


s_aa_dist_32 := __common__( (0.00000 - s_rv_i60_inq_hiriskcred_rec_w) * 0.61014 ) ;

s_aa_code_32 := __common__( map(
    s_rv_i60_inq_hiriskcred_rec_w = -0.01554 => '',
    rv_i60_inq_hiriskcred_recency = NULL     => 'P535',
    rv_i60_inq_hiriskcred_recency <= 0.5     => 'P539',
                                                'P539') ) ;

s_rv_c18_inv_addrs_per_adl_w := __common__( map(
    rv_c18_invalid_addrs_per_adl = NULL => 0.00000,
    rv_c18_invalid_addrs_per_adl <= 1.5 => -0.18219,
                                           0.09195) ) ;

s_aa_dist_33 := __common__( (0.00000 - s_rv_c18_inv_addrs_per_adl_w) * 0.85450 ) ;

s_aa_code_33 := __common__( map(
    s_rv_c18_inv_addrs_per_adl_w = -0.18219 => '',
    rv_c18_invalid_addrs_per_adl = NULL     => 'P535',
    rv_c18_invalid_addrs_per_adl <= 1.5     => 'P521',
                                               'P521') ) ;

s_rv_d34_attr_liens_recency_w := __common__( map(
    rv_d34_attr_liens_recency = NULL => 0.00000,
    rv_d34_attr_liens_recency <= 0.5 => -0.17030,
    rv_d34_attr_liens_recency <= 48  => 1.15892,
                                        0.46646) ) ;

s_aa_dist_34 := __common__( (0.00000 - s_rv_d34_attr_liens_recency_w) * 0.31435 ) ;

s_aa_code_34 := __common__( map(
    s_rv_d34_attr_liens_recency_w = -0.17030 => '',
    rv_d34_attr_liens_recency = NULL         => 'P535',
    rv_d34_attr_liens_recency <= 0.5         => 'P526',
    rv_d34_attr_liens_recency <= 48          => 'P526',
                                                'P526') ) ;

s_rv_e58_br_dead_bus_count_w := __common__( map(
    rv_e58_br_dead_business_count = NULL => 0.00000,
    rv_e58_br_dead_business_count <= 0.5 => -0.12693,
    rv_e58_br_dead_business_count <= 3.5 => 0.24546,
                                            0.52510) ) ;

s_aa_dist_35 := __common__( (0.00000 - s_rv_e58_br_dead_bus_count_w) * 0.33511 ) ;

s_aa_code_35 := __common__( map(
    s_rv_e58_br_dead_bus_count_w = -0.12693 => '',
    rv_e58_br_dead_business_count = NULL    => 'P535',
    rv_e58_br_dead_business_count <= 0.5    => 'P534',
    rv_e58_br_dead_business_count <= 3.5    => 'P534',
                                               'P534') ) ;

s_nf_inq_collection_count_w := __common__( map(
    nf_inq_collection_count = NULL  => 0.00000,
    nf_inq_collection_count <= 0.5  => -0.21595,
    nf_inq_collection_count <= 1.5  => -0.02558,
    nf_inq_collection_count <= 2.5  => 0.12936,
    nf_inq_collection_count <= 5.5  => 0.32233,
    nf_inq_collection_count <= 10.5 => 0.63318,
                                       0.75849) ) ;

s_aa_dist_36 := __common__( (0.00000 - s_nf_inq_collection_count_w) * 0.30703 ) ;

s_aa_code_36 := __common__( map(
    s_nf_inq_collection_count_w = -0.21595 => '',
    nf_inq_collection_count = NULL         => 'P535',
    nf_inq_collection_count <= 0.5         => 'P539',
    nf_inq_collection_count <= 1.5         => 'P539',
    nf_inq_collection_count <= 2.5         => 'P539',
    nf_inq_collection_count <= 5.5         => 'P539',
    nf_inq_collection_count <= 10.5        => 'P539',
                                              'P539') ) ;

s_nf_mos_acc_lseen_w := __common__( map(
    nf_mos_acc_lseen = NULL  => 0.00000,
    nf_mos_acc_lseen = -1    => -0.04845,
    nf_mos_acc_lseen <= 33.5 => 0.37307,
    nf_mos_acc_lseen <= 96.5 => 0.25440,
                                0.07807) ) ;

s_aa_dist_37 := __common__( (0.00000 - s_nf_mos_acc_lseen_w) * 0.47679 ) ;

s_aa_code_37 := __common__( map(
    s_nf_mos_acc_lseen_w = -0.04845 => '',
    nf_mos_acc_lseen = NULL         => 'P535',
    nf_mos_acc_lseen = -1           => 'P531',
    nf_mos_acc_lseen <= 33.5        => 'P531',
    nf_mos_acc_lseen <= 96.5        => 'P531',
                                       'P531') ) ;

s_bv_bus_rep_source_profile_w := __common__( map(
    bv_bus_rep_source_profile = NULL           => 0.00000,
    bv_bus_rep_source_profile <= -3.504701061  => -1.19811,
    bv_bus_rep_source_profile <= -3.2564822145 => -0.73841,
    bv_bus_rep_source_profile <= -3.0986489445 => -0.39662,
    bv_bus_rep_source_profile <= -2.7010177855 => -0.35388,
    bv_bus_rep_source_profile <= -2.529098098  => 0.06960,
    bv_bus_rep_source_profile <= -2.120465409  => 0.28126,
    bv_bus_rep_source_profile <= -1.7855706545 => 0.48197,
    bv_bus_rep_source_profile <= -1.6908738405 => 0.65107,
    bv_bus_rep_source_profile <= -1.4462576535 => 0.84456,
                                                  1.14431) ) ;

s_aa_dist_38 := __common__( (0.00000 - s_bv_bus_rep_source_profile_w) * 0.57257 ) ;

s_aa_code_38 := __common__( map(
    s_bv_bus_rep_source_profile_w = -1.19811   => '',
    bv_bus_rep_source_profile = NULL           => 'B031',
    bv_bus_rep_source_profile <= -3.504701061  => 'B034',
    bv_bus_rep_source_profile <= -3.2564822145 => 'B034',
    bv_bus_rep_source_profile <= -3.0986489445 => 'B034',
    bv_bus_rep_source_profile <= -2.7010177855 => 'B034',
    bv_bus_rep_source_profile <= -2.529098098  => 'B034',
    bv_bus_rep_source_profile <= -2.120465409  => 'B034',
    bv_bus_rep_source_profile <= -1.7855706545 => 'B034',
    bv_bus_rep_source_profile <= -1.6908738405 => 'B034',
    bv_bus_rep_source_profile <= -1.4462576535 => 'B034',
                                                  'B034') ) ;

s_bv_rep_only_source_profile_w := __common__( map(
    bv_rep_only_source_profile = NULL           => 0.00000,
    bv_rep_only_source_profile <= -3.384350875  => -1.07617,
    bv_rep_only_source_profile <= -3.1201998525 => -0.54694,
    bv_rep_only_source_profile <= -2.690252739  => -0.32650,
    bv_rep_only_source_profile <= -2.604675502  => -0.18823,
    bv_rep_only_source_profile <= -2.4237933835 => 0.05870,
    bv_rep_only_source_profile <= -2.0889370475 => 0.27182,
    bv_rep_only_source_profile <= -1.9956978825 => 0.45032,
    bv_rep_only_source_profile <= -1.724420963  => 0.57998,
                                                   0.94798) ) ;

s_aa_dist_39 := __common__( (0.00000 - s_bv_rep_only_source_profile_w) * 0.16965 ) ;

s_aa_code_39 := __common__( map(
    s_bv_rep_only_source_profile_w = -1.07617   => '',
    bv_rep_only_source_profile = NULL           => 'P535',
    bv_rep_only_source_profile <= -3.384350875  => 'P515',
    bv_rep_only_source_profile <= -3.1201998525 => 'P515',
    bv_rep_only_source_profile <= -2.690252739  => 'P515',
    bv_rep_only_source_profile <= -2.604675502  => 'P515',
    bv_rep_only_source_profile <= -2.4237933835 => 'P515',
    bv_rep_only_source_profile <= -2.0889370475 => 'P515',
    bv_rep_only_source_profile <= -1.9956978825 => 'P515',
    bv_rep_only_source_profile <= -1.724420963  => 'P515',
                                                   'P515') ) ;

s_td_sbfe_avg_util_pct12_w := __common__( map(
    td_sbfe_avg_util_pct12 = NULL  => 0.00000,
    td_sbfe_avg_util_pct12 = -98   => 0.12537,
    td_sbfe_avg_util_pct12 = -97   => -1.13416,
    td_sbfe_avg_util_pct12 <= 0.5  => -0.18433,
    td_sbfe_avg_util_pct12 <= 6.5  => -1.13416,
    td_sbfe_avg_util_pct12 <= 27.5 => -0.71739,
    td_sbfe_avg_util_pct12 <= 49.5 => 0.05600,
    td_sbfe_avg_util_pct12 <= 55.5 => 0.31528,
    td_sbfe_avg_util_pct12 <= 76.5 => 0.61224,
    td_sbfe_avg_util_pct12 <= 85.5 => 0.95265,
    td_sbfe_avg_util_pct12 <= 94.5 => 1.38251,
                                      1.89168) ) ;

s_aa_dist_40 := __common__( (0.00000 - s_td_sbfe_avg_util_pct12_w) * 0.09199 ) ;

s_aa_code_40 := __common__( map(
    s_td_sbfe_avg_util_pct12_w = -1.13416                        					 => '',
    td_sbfe_avg_util_pct12 = NULL                                					 => 'BF105',
    td_sbfe_avg_util_pct12 = -98 and (integer)sbfe_avg_util_pct12_cc = -98 => 'BF128',
    td_sbfe_avg_util_pct12 = -98                                 					 => 'BF127',
    td_sbfe_avg_util_pct12 = -97                                  				 => 'BF133',
    td_sbfe_avg_util_pct12 <= 0.5                                					 => 'BF134',
    td_sbfe_avg_util_pct12 <= 6.5                                					 => 'BF133',
    td_sbfe_avg_util_pct12 <= 27.5                               					 => 'BF133',
    td_sbfe_avg_util_pct12 <= 49.5                               					 => 'BF133',
    td_sbfe_avg_util_pct12 <= 55.5                               					 => 'BF133',
    td_sbfe_avg_util_pct12 <= 76.5                                				 => 'BF133',
    td_sbfe_avg_util_pct12 <= 85.5                               					 => 'BF133',
    td_sbfe_avg_util_pct12 <= 94.5                               					 => 'BF133',
																																							'BF133') ) ;

s_td_acct_dpd_1p_recency_w := __common__( map(
    td_acct_dpd_1p_recency = NULL => 0.00000,
    td_acct_dpd_1p_recency = -97  => -0.37414,
    td_acct_dpd_1p_recency <= 0.5 => -0.37414,
    td_acct_dpd_1p_recency <= 3.5 => 0.93463,
    td_acct_dpd_1p_recency <= 9   => 0.66793,
                                     0.03475) ) ;

s_aa_dist_41 := __common__( (0.00000 - s_td_acct_dpd_1p_recency_w) * 0.17668 ) ;

s_aa_code_41 := __common__( map(
    s_td_acct_dpd_1p_recency_w = -0.37414 => '',
    td_acct_dpd_1p_recency = NULL         => 'BF105',
    td_acct_dpd_1p_recency = -97          => 'BF141',
    td_acct_dpd_1p_recency <= 0.5         => 'BF141',
    (integer)sbfe_acct_dpd_91p_cnt00 > 0  => 'BF142',
                                             'BF141') ) ;

s_td_sbfe_worst_perf84_w := __common__( map(
    td_sbfe_worst_perf84 = NULL => 0.00000,
    td_sbfe_worst_perf84 = -98  => -0.21626,
    td_sbfe_worst_perf84 = -97  => -0.36334,
    td_sbfe_worst_perf84 <= 0.5 => -0.36334,
    td_sbfe_worst_perf84 <= 3.5 => 0.06296,
    td_sbfe_worst_perf84 <= 5.5 => 0.76151,
                                   1.30302) ) ;

s_aa_dist_42 := __common__( (0.00000 - s_td_sbfe_worst_perf84_w) * 0.07518 ) ;

s_aa_code_42 := __common__( map(
    s_td_sbfe_worst_perf84_w = -0.36334 => '',
    td_sbfe_worst_perf84 = NULL         => 'BF105',
    td_sbfe_worst_perf84 = -98          => 'BF125',
    td_sbfe_worst_perf84 = -97          => 'BF141',
    td_sbfe_worst_perf84 <= 0.5         => 'BF141',
    td_sbfe_worst_perf84 <= 3.5         => 'BF141',
    (integer)sbfe_worst_perf84 > 4      => 'BF143',
                                           'BF142') ) ;

s_rcvalueb037 := __common__( (integer)(s_aa_code_1 = 'B037') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B037') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B037') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B037') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B037') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B037') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B037') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B037') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B037') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B037') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B037') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B037') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B037') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B037') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B037') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B037') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B037') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B037') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B037') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B037') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B037') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B037') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B037') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B037') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B037') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B037') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B037') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B037') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B037') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B037') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B037') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B037') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B037') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B037') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B037') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B037') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B037') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B037') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B037') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B037') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B037') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B037') * s_aa_dist_42 ) ;

s_rcvaluep531 := __common__( (integer)(s_aa_code_1 = 'P531') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P531') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P531') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P531') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P531') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P531') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P531') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P531') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P531') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P531') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P531') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P531') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P531') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P531') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P531') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P531') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P531') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P531') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P531') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P531') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P531') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P531') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P531') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P531') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P531') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P531') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P531') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P531') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P531') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P531') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P531') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P531') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P531') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P531') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P531') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P531') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P531') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P531') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P531') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P531') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P531') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P531') * s_aa_dist_42 ) ;

s_rcvaluep532 := __common__( (integer)(s_aa_code_1 = 'P532') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P532') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P532') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P532') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P532') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P532') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P532') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P532') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P532') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P532') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P532') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P532') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P532') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P532') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P532') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P532') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P532') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P532') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P532') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P532') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P532') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P532') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P532') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P532') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P532') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P532') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P532') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P532') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P532') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P532') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P532') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P532') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P532') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P532') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P532') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P532') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P532') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P532') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P532') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P532') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P532') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P532') * s_aa_dist_42 ) ;

s_rcvalueb034 := __common__( (integer)(s_aa_code_1 = 'B034') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B034') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B034') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B034') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B034') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B034') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B034') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B034') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B034') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B034') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B034') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B034') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B034') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B034') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B034') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B034') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B034') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B034') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B034') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B034') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B034') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B034') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B034') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B034') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B034') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B034') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B034') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B034') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B034') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B034') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B034') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B034') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B034') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B034') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B034') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B034') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B034') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B034') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B034') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B034') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B034') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B034') * s_aa_dist_42 ) ;

s_rcvaluep534 := __common__( (integer)(s_aa_code_1 = 'P534') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P534') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P534') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P534') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P534') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P534') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P534') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P534') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P534') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P534') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P534') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P534') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P534') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P534') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P534') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P534') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P534') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P534') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P534') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P534') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P534') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P534') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P534') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P534') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P534') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P534') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P534') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P534') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P534') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P534') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P534') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P534') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P534') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P534') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P534') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P534') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P534') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P534') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P534') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P534') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P534') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P534') * s_aa_dist_42 ) ;

s_rcvaluep535 := __common__( (integer)(s_aa_code_1 = 'P535') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P535') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P535') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P535') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P535') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P535') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P535') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P535') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P535') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P535') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P535') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P535') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P535') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P535') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P535') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P535') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P535') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P535') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P535') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P535') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P535') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P535') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P535') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P535') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P535') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P535') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P535') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P535') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P535') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P535') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P535') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P535') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P535') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P535') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P535') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P535') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P535') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P535') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P535') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P535') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P535') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P535') * s_aa_dist_42 ) ;

s_rcvalueb031 := __common__( (integer)(s_aa_code_1 = 'B031') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B031') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B031') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B031') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B031') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B031') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B031') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B031') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B031') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B031') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B031') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B031') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B031') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B031') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B031') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B031') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B031') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B031') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B031') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B031') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B031') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B031') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B031') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B031') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B031') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B031') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B031') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B031') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B031') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B031') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B031') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B031') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B031') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B031') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B031') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B031') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B031') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B031') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B031') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B031') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B031') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B031') * s_aa_dist_42 ) ;

s_rcvaluep516 := __common__( (integer)(s_aa_code_1 = 'P516') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P516') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P516') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P516') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P516') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P516') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P516') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P516') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P516') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P516') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P516') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P516') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P516') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P516') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P516') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P516') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P516') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P516') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P516') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P516') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P516') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P516') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P516') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P516') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P516') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P516') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P516') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P516') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P516') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P516') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P516') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P516') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P516') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P516') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P516') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P516') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P516') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P516') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P516') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P516') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P516') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P516') * s_aa_dist_42 ) ;

s_rcvaluep539 := __common__( (integer)(s_aa_code_1 = 'P539') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P539') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P539') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P539') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P539') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P539') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P539') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P539') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P539') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P539') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P539') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P539') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P539') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P539') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P539') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P539') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P539') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P539') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P539') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P539') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P539') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P539') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P539') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P539') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P539') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P539') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P539') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P539') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P539') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P539') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P539') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P539') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P539') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P539') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P539') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P539') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P539') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P539') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P539') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P539') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P539') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P539') * s_aa_dist_42 ) ;

s_rcvalueb017 := __common__( (integer)(s_aa_code_1 = 'B017') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B017') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B017') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B017') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B017') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B017') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B017') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B017') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B017') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B017') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B017') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B017') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B017') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B017') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B017') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B017') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B017') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B017') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B017') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B017') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B017') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B017') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B017') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B017') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B017') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B017') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B017') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B017') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B017') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B017') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B017') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B017') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B017') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B017') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B017') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B017') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B017') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B017') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B017') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B017') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B017') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B017') * s_aa_dist_42 ) ;

s_rcvaluep515 := __common__( (integer)(s_aa_code_1 = 'P515') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P515') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P515') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P515') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P515') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P515') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P515') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P515') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P515') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P515') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P515') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P515') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P515') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P515') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P515') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P515') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P515') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P515') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P515') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P515') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P515') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P515') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P515') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P515') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P515') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P515') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P515') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P515') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P515') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P515') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P515') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P515') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P515') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P515') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P515') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P515') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P515') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P515') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P515') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P515') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P515') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P515') * s_aa_dist_42 ) ;

s_rcvaluep521 := __common__( (integer)(s_aa_code_1 = 'P521') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P521') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P521') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P521') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P521') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P521') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P521') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P521') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P521') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P521') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P521') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P521') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P521') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P521') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P521') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P521') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P521') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P521') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P521') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P521') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P521') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P521') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P521') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P521') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P521') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P521') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P521') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P521') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P521') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P521') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P521') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P521') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P521') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P521') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P521') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P521') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P521') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P521') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P521') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P521') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P521') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P521') * s_aa_dist_42 ) ;

s_rcvaluebf142 := __common__( (integer)(s_aa_code_1 = 'BF142') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF142') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF142') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF142') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF142') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF142') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF142') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF142') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF142') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF142') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF142') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF142') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF142') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF142') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF142') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF142') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF142') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF142') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF142') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF142') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF142') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF142') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF142') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF142') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF142') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF142') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF142') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF142') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF142') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF142') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF142') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF142') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF142') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF142') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF142') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF142') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF142') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF142') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF142') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF142') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF142') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF142') * s_aa_dist_42 ) ;

s_rcvaluep511 := __common__( (integer)(s_aa_code_1 = 'P511') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P511') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P511') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P511') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P511') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P511') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P511') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P511') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P511') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P511') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P511') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P511') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P511') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P511') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P511') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P511') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P511') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P511') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P511') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P511') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P511') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P511') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P511') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P511') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P511') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P511') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P511') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P511') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P511') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P511') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P511') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P511') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P511') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P511') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P511') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P511') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P511') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P511') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P511') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P511') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P511') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P511') * s_aa_dist_42 ) ;

s_rcvaluebf113 := __common__( (integer)(s_aa_code_1 = 'BF113') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF113') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF113') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF113') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF113') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF113') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF113') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF113') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF113') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF113') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF113') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF113') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF113') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF113') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF113') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF113') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF113') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF113') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF113') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF113') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF113') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF113') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF113') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF113') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF113') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF113') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF113') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF113') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF113') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF113') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF113') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF113') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF113') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF113') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF113') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF113') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF113') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF113') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF113') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF113') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF113') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF113') * s_aa_dist_42 ) ;

s_rcvaluebf134 := __common__( (integer)(s_aa_code_1 = 'BF134') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF134') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF134') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF134') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF134') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF134') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF134') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF134') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF134') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF134') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF134') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF134') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF134') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF134') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF134') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF134') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF134') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF134') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF134') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF134') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF134') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF134') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF134') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF134') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF134') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF134') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF134') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF134') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF134') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF134') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF134') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF134') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF134') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF134') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF134') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF134') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF134') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF134') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF134') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF134') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF134') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF134') * s_aa_dist_42 ) ;

s_rcvaluebf110 := __common__( (integer)(s_aa_code_1 = 'BF110') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF110') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF110') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF110') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF110') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF110') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF110') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF110') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF110') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF110') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF110') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF110') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF110') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF110') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF110') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF110') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF110') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF110') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF110') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF110') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF110') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF110') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF110') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF110') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF110') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF110') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF110') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF110') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF110') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF110') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF110') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF110') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF110') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF110') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF110') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF110') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF110') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF110') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF110') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF110') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF110') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF110') * s_aa_dist_42 ) ;

s_rcvaluebf117 := __common__( (integer)(s_aa_code_1 = 'BF117') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF117') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF117') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF117') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF117') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF117') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF117') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF117') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF117') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF117') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF117') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF117') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF117') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF117') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF117') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF117') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF117') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF117') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF117') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF117') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF117') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF117') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF117') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF117') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF117') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF117') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF117') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF117') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF117') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF117') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF117') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF117') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF117') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF117') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF117') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF117') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF117') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF117') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF117') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF117') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF117') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF117') * s_aa_dist_42 ) ;

s_rcvaluebf133 := __common__( (integer)(s_aa_code_1 = 'BF133') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF133') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF133') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF133') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF133') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF133') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF133') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF133') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF133') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF133') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF133') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF133') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF133') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF133') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF133') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF133') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF133') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF133') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF133') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF133') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF133') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF133') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF133') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF133') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF133') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF133') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF133') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF133') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF133') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF133') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF133') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF133') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF133') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF133') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF133') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF133') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF133') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF133') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF133') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF133') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF133') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF133') * s_aa_dist_42 ) ;

s_rcvaluebf136 := __common__( (integer)(s_aa_code_1 = 'BF136') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF136') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF136') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF136') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF136') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF136') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF136') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF136') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF136') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF136') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF136') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF136') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF136') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF136') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF136') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF136') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF136') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF136') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF136') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF136') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF136') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF136') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF136') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF136') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF136') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF136') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF136') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF136') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF136') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF136') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF136') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF136') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF136') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF136') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF136') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF136') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF136') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF136') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF136') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF136') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF136') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF136') * s_aa_dist_42 ) ;

s_rcvaluep509 := __common__( (integer)(s_aa_code_1 = 'P509') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P509') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P509') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P509') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P509') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P509') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P509') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P509') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P509') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P509') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P509') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P509') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P509') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P509') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P509') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P509') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P509') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P509') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P509') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P509') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P509') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P509') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P509') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P509') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P509') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P509') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P509') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P509') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P509') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P509') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P509') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P509') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P509') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P509') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P509') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P509') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P509') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P509') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P509') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P509') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P509') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P509') * s_aa_dist_42 ) ;

s_rcvaluebf141 := __common__( (integer)(s_aa_code_1 = 'BF141') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF141') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF141') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF141') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF141') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF141') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF141') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF141') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF141') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF141') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF141') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF141') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF141') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF141') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF141') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF141') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF141') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF141') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF141') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF141') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF141') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF141') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF141') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF141') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF141') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF141') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF141') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF141') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF141') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF141') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF141') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF141') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF141') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF141') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF141') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF141') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF141') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF141') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF141') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF141') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF141') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF141') * s_aa_dist_42 ) ;

s_rcvalueb026 := __common__( (integer)(s_aa_code_1 = 'B026') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B026') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B026') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B026') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B026') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B026') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B026') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B026') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B026') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B026') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B026') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B026') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B026') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B026') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B026') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B026') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B026') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B026') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B026') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B026') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B026') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B026') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B026') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B026') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B026') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B026') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B026') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B026') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B026') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B026') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B026') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B026') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B026') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B026') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B026') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B026') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B026') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B026') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B026') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B026') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B026') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B026') * s_aa_dist_42 ) ;

s_rcvaluebf143 := __common__( (integer)(s_aa_code_1 = 'BF143') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF143') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF143') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF143') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF143') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF143') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF143') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF143') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF143') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF143') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF143') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF143') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF143') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF143') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF143') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF143') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF143') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF143') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF143') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF143') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF143') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF143') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF143') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF143') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF143') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF143') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF143') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF143') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF143') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF143') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF143') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF143') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF143') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF143') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF143') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF143') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF143') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF143') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF143') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF143') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF143') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF143') * s_aa_dist_42 ) ;

s_rcvaluep526 := __common__( (integer)(s_aa_code_1 = 'P526') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P526') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P526') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P526') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P526') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P526') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P526') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P526') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P526') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P526') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P526') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P526') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P526') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P526') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P526') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P526') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P526') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P526') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P526') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P526') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P526') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P526') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P526') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P526') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P526') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P526') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P526') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P526') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P526') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P526') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P526') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P526') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P526') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P526') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P526') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P526') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P526') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P526') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P526') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P526') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P526') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P526') * s_aa_dist_42 ) ;

s_rcvalueb063 := __common__( (integer)(s_aa_code_1 = 'B063') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B063') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B063') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B063') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B063') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B063') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B063') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B063') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B063') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B063') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B063') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B063') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B063') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B063') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B063') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B063') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B063') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B063') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B063') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B063') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B063') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B063') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B063') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B063') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B063') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B063') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B063') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B063') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B063') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B063') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B063') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B063') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B063') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B063') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B063') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B063') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B063') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B063') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B063') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B063') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B063') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B063') * s_aa_dist_42 ) ;

s_rcvalueb066 := __common__( (integer)(s_aa_code_1 = 'B066') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B066') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B066') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B066') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B066') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B066') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B066') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B066') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B066') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B066') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B066') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B066') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B066') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B066') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B066') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B066') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B066') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B066') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B066') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B066') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B066') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B066') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B066') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B066') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B066') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B066') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B066') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B066') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B066') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B066') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B066') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B066') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B066') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B066') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B066') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B066') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B066') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B066') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B066') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B066') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B066') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B066') * s_aa_dist_42 ) ;

s_rcvaluebf126 := __common__( (integer)(s_aa_code_1 = 'BF126') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF126') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF126') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF126') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF126') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF126') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF126') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF126') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF126') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF126') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF126') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF126') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF126') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF126') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF126') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF126') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF126') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF126') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF126') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF126') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF126') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF126') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF126') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF126') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF126') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF126') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF126') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF126') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF126') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF126') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF126') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF126') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF126') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF126') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF126') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF126') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF126') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF126') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF126') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF126') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF126') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF126') * s_aa_dist_42 ) ;

s_rcvaluebf127 := __common__( (integer)(s_aa_code_1 = 'BF127') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF127') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF127') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF127') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF127') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF127') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF127') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF127') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF127') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF127') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF127') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF127') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF127') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF127') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF127') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF127') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF127') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF127') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF127') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF127') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF127') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF127') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF127') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF127') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF127') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF127') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF127') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF127') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF127') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF127') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF127') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF127') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF127') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF127') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF127') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF127') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF127') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF127') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF127') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF127') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF127') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF127') * s_aa_dist_42 ) ;

s_rcvaluebf125 := __common__( (integer)(s_aa_code_1 = 'BF125') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF125') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF125') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF125') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF125') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF125') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF125') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF125') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF125') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF125') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF125') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF125') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF125') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF125') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF125') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF125') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF125') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF125') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF125') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF125') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF125') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF125') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF125') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF125') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF125') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF125') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF125') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF125') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF125') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF125') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF125') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF125') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF125') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF125') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF125') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF125') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF125') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF125') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF125') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF125') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF125') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF125') * s_aa_dist_42 ) ;

s_rcvaluebf120 := __common__( (integer)(s_aa_code_1 = 'BF120') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF120') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF120') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF120') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF120') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF120') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF120') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF120') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF120') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF120') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF120') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF120') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF120') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF120') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF120') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF120') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF120') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF120') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF120') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF120') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF120') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF120') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF120') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF120') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF120') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF120') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF120') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF120') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF120') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF120') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF120') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF120') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF120') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF120') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF120') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF120') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF120') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF120') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF120') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF120') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF120') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF120') * s_aa_dist_42 ) ;

s_rcvaluebf105 := __common__( (integer)(s_aa_code_1 = 'BF105') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF105') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF105') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF105') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF105') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF105') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF105') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF105') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF105') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF105') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF105') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF105') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF105') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF105') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF105') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF105') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF105') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF105') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF105') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF105') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF105') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF105') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF105') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF105') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF105') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF105') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF105') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF105') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF105') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF105') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF105') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF105') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF105') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF105') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF105') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF105') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF105') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF105') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF105') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF105') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF105') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF105') * s_aa_dist_42 ) ;

s_rcvaluebf106 := __common__( (integer)(s_aa_code_1 = 'BF106') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF106') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF106') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF106') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF106') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF106') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF106') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF106') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF106') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF106') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF106') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF106') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF106') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF106') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF106') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF106') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF106') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF106') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF106') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF106') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF106') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF106') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF106') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF106') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF106') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF106') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF106') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF106') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF106') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF106') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF106') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF106') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF106') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF106') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF106') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF106') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF106') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF106') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF106') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF106') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF106') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF106') * s_aa_dist_42 ) ;

s_rcvaluebf128 := __common__( (integer)(s_aa_code_1 = 'BF128') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF128') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF128') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF128') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF128') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF128') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF128') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF128') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF128') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF128') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF128') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF128') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF128') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF128') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF128') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF128') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF128') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF128') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF128') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF128') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF128') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF128') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF128') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF128') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF128') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF128') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF128') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF128') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF128') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF128') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF128') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF128') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF128') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF128') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF128') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF128') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF128') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF128') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF128') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF128') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF128') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF128') * s_aa_dist_42 ) ;

s_rcvaluebf129 := __common__( (integer)(s_aa_code_1 = 'BF129') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF129') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF129') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF129') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF129') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF129') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF129') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF129') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF129') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF129') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF129') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF129') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF129') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF129') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF129') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF129') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF129') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF129') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF129') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF129') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF129') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF129') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF129') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF129') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF129') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF129') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF129') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF129') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF129') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF129') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF129') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF129') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF129') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF129') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF129') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF129') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF129') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF129') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF129') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF129') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF129') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF129') * s_aa_dist_42 ) ;

s_rcvaluebf135 := __common__( (integer)(s_aa_code_1 = 'BF135') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'BF135') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'BF135') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'BF135') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'BF135') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'BF135') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'BF135') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'BF135') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'BF135') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'BF135') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'BF135') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'BF135') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'BF135') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'BF135') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'BF135') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'BF135') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'BF135') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'BF135') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'BF135') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'BF135') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'BF135') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'BF135') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'BF135') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'BF135') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'BF135') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'BF135') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'BF135') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'BF135') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'BF135') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'BF135') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'BF135') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'BF135') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'BF135') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'BF135') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'BF135') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'BF135') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'BF135') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'BF135') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'BF135') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'BF135') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'BF135') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'BF135') * s_aa_dist_42 ) ;

s_rcvaluep502 := __common__( (integer)(s_aa_code_1 = 'P502') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'P502') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'P502') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'P502') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'P502') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'P502') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'P502') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'P502') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'P502') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'P502') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'P502') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'P502') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'P502') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'P502') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'P502') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'P502') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'P502') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'P502') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'P502') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'P502') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'P502') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'P502') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'P502') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'P502') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'P502') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'P502') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'P502') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'P502') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'P502') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'P502') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'P502') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'P502') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'P502') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'P502') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'P502') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'P502') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'P502') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'P502') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'P502') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'P502') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'P502') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'P502') * s_aa_dist_42 ) ;

s_rcvalueb053 := __common__( (integer)(s_aa_code_1 = 'B053') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B053') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B053') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B053') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B053') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B053') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B053') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B053') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B053') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B053') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B053') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B053') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B053') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B053') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B053') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B053') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B053') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B053') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B053') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B053') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B053') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B053') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B053') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B053') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B053') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B053') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B053') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B053') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B053') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B053') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B053') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B053') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B053') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B053') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B053') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B053') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B053') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B053') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B053') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B053') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B053') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B053') * s_aa_dist_42 ) ;

s_rcvalueb052 := __common__( (integer)(s_aa_code_1 = 'B052') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B052') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B052') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B052') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B052') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B052') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B052') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B052') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B052') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B052') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B052') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B052') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B052') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B052') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B052') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B052') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B052') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B052') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B052') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B052') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B052') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B052') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B052') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B052') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B052') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B052') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B052') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B052') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B052') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B052') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B052') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B052') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B052') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B052') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B052') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B052') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B052') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B052') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B052') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B052') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B052') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B052') * s_aa_dist_42 ) ;

s_rcvalueb055 := __common__( (integer)(s_aa_code_1 = 'B055') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B055') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B055') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B055') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B055') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B055') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B055') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B055') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B055') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B055') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B055') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B055') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B055') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B055') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B055') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B055') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B055') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B055') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B055') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B055') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B055') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B055') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B055') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B055') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B055') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B055') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B055') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B055') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B055') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B055') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B055') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B055') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B055') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B055') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B055') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B055') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B055') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B055') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B055') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B055') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B055') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B055') * s_aa_dist_42 ) ;

s_rcvalueb059 := __common__( (integer)(s_aa_code_1 = 'B059') * s_aa_dist_1 +
    (integer)(s_aa_code_2 = 'B059') * s_aa_dist_2 +
    (integer)(s_aa_code_3 = 'B059') * s_aa_dist_3 +
    (integer)(s_aa_code_4 = 'B059') * s_aa_dist_4 +
    (integer)(s_aa_code_5 = 'B059') * s_aa_dist_5 +
    (integer)(s_aa_code_6 = 'B059') * s_aa_dist_6 +
    (integer)(s_aa_code_7 = 'B059') * s_aa_dist_7 +
    (integer)(s_aa_code_8 = 'B059') * s_aa_dist_8 +
    (integer)(s_aa_code_9 = 'B059') * s_aa_dist_9 +
    (integer)(s_aa_code_10 = 'B059') * s_aa_dist_10 +
    (integer)(s_aa_code_11 = 'B059') * s_aa_dist_11 +
    (integer)(s_aa_code_12 = 'B059') * s_aa_dist_12 +
    (integer)(s_aa_code_13 = 'B059') * s_aa_dist_13 +
    (integer)(s_aa_code_14 = 'B059') * s_aa_dist_14 +
    (integer)(s_aa_code_15 = 'B059') * s_aa_dist_15 +
    (integer)(s_aa_code_16 = 'B059') * s_aa_dist_16 +
    (integer)(s_aa_code_17 = 'B059') * s_aa_dist_17 +
    (integer)(s_aa_code_18 = 'B059') * s_aa_dist_18 +
    (integer)(s_aa_code_19 = 'B059') * s_aa_dist_19 +
    (integer)(s_aa_code_20 = 'B059') * s_aa_dist_20 +
    (integer)(s_aa_code_21 = 'B059') * s_aa_dist_21 +
    (integer)(s_aa_code_22 = 'B059') * s_aa_dist_22 +
    (integer)(s_aa_code_23 = 'B059') * s_aa_dist_23 +
    (integer)(s_aa_code_24 = 'B059') * s_aa_dist_24 +
    (integer)(s_aa_code_25 = 'B059') * s_aa_dist_25 +
    (integer)(s_aa_code_26 = 'B059') * s_aa_dist_26 +
    (integer)(s_aa_code_27 = 'B059') * s_aa_dist_27 +
    (integer)(s_aa_code_28 = 'B059') * s_aa_dist_28 +
    (integer)(s_aa_code_29 = 'B059') * s_aa_dist_29 +
    (integer)(s_aa_code_30 = 'B059') * s_aa_dist_30 +
    (integer)(s_aa_code_31 = 'B059') * s_aa_dist_31 +
    (integer)(s_aa_code_32 = 'B059') * s_aa_dist_32 +
    (integer)(s_aa_code_33 = 'B059') * s_aa_dist_33 +
    (integer)(s_aa_code_34 = 'B059') * s_aa_dist_34 +
    (integer)(s_aa_code_35 = 'B059') * s_aa_dist_35 +
    (integer)(s_aa_code_36 = 'B059') * s_aa_dist_36 +
    (integer)(s_aa_code_37 = 'B059') * s_aa_dist_37 +
    (integer)(s_aa_code_38 = 'B059') * s_aa_dist_38 +
    (integer)(s_aa_code_39 = 'B059') * s_aa_dist_39 +
    (integer)(s_aa_code_40 = 'B059') * s_aa_dist_40 +
    (integer)(s_aa_code_41 = 'B059') * s_aa_dist_41 +
    (integer)(s_aa_code_42 = 'B059') * s_aa_dist_42 ) ;

s_final_score := __common__( -2.76933408596469 +
    s_bv_src_id_phn_mth_fs_w * 0.232359049608153 +
    s_bv_assoc_bk_tot_w * 0.276488218878796 +
    s_bv_sos_defunct_status_w * 0.7560429312981 +
    s_bv_lien_filed_count_w * 0.320286390697189 +
    s_bv_ucc_index_w * 0.789484527426187 +
    s_bv_prop_assessed_value_w * 0.74351502432743 +
    s_td_mth_sbfe_datefirstseen_w * 0.609768800808831 +
    s_td_mth_acct_firstopen_w * 0.727260538948117 +
    s_td_mth_dlq_lastseen_w * 0.238441299858662 +
    s_td_acct_pct_closed_w * 0.463186506014323 +
    s_td_sbfe_worst_perf06_w * 0.146163918982002 +
    s_td_sbfe_worst_perf60_loan_w * 0.472455557786343 +
    s_td_sbfe_worst_perf12_oel_w * 0.231603138219537 +
    s_td_acct_dpd_31p_recency_cc_w * 0.208425429381451 +
    s_td_acct_dpd_91p_recency_lse_w * 0.373455495922547 +
    s_td_sbfe_closed_pct_invol_w * 0.438455156820793 +
    s_td_sbfe_util_pct_w * 0.139270853941596 +
    s_td_sbfe_util_pct_cc_w * 0.235740428079869 +
    s_td_sbfe_avg_util_pct06_w * 0.205538459415106 +
    s_td_sbfe_avg_util_pct24_w * 0.201499782146964 +
    s_td_sbfe_avg_util_pct_cc_w * 0.138002567755652 +
    s_td_sbfe_avg_past_due_amt24_w * 0.244728788532036 +
    s_td_sbfe_avg_past_due_amt_w * 0.20638114586944 +
    s_bv_ver_src_derog_ratio_w * 0.262237261164923 +
    s_rv_d30_derog_count_w * 0.281971262561425 +
    s_rv_d32_mos_since_crim_ls_w * 0.370026448985264 +
    s_rv_d31_mostrec_bk_w * 0.349960390814444 +
    s_rv_a46_curr_avm_autoval_w * 0.681907525365305 +
    s_rv_a49_curr_avm_chg_1yr_pct_w * 0.770996810416922 +
    s_rv_a41_prop_owner_w * 0.671999470118929 +
    s_rv_e55_college_ind_w * 0.68125173250481 +
    s_rv_i60_inq_hiriskcred_rec_w * 0.610136578460554 +
    s_rv_c18_inv_addrs_per_adl_w * 0.854501253994341 +
    s_rv_d34_attr_liens_recency_w * 0.314345756414679 +
    s_rv_e58_br_dead_bus_count_w * 0.335110439719222 +
    s_nf_inq_collection_count_w * 0.307034696124288 +
    s_nf_mos_acc_lseen_w * 0.476790366744614 +
    s_bv_bus_rep_source_profile_w * 0.572569309193263 +
    s_bv_rep_only_source_profile_w * 0.169653889792367 +
    s_td_sbfe_avg_util_pct12_w * 0.091989029803415 +
    s_td_acct_dpd_1p_recency_w * 0.176676525790792 +
    s_td_sbfe_worst_perf84_w * 0.0751802125664321 ) ;

l_bv_src_id_phn_mth_fs_w := __common__( map(
    bv_src_id_phn_mth_fs = NULL  => 0.00000,
    bv_src_id_phn_mth_fs = -1    => 0.03157,
    bv_src_id_phn_mth_fs <= 8.5  => 0.77191,
    bv_src_id_phn_mth_fs <= 12.5 => 0.62798,
    bv_src_id_phn_mth_fs <= 32.5 => 0.29395,
    bv_src_id_phn_mth_fs <= 89.5 => -0.17597,
                                    -0.43169) ) ;

l_aa_dist_1 := __common__( (0.00000 - l_bv_src_id_phn_mth_fs_w) * 0.39552 ) ;

l_aa_code_1 := __common__( map(
    l_bv_src_id_phn_mth_fs_w = -0.43169 => '',
    bv_src_id_phn_mth_fs = NULL         => 'B037',
    bv_src_id_phn_mth_fs = -1           => 'B034',
    bv_src_id_phn_mth_fs <= 8.5         => 'B037',
    bv_src_id_phn_mth_fs <= 12.5        => 'B037',
    bv_src_id_phn_mth_fs <= 32.5        => 'B037',
    bv_src_id_phn_mth_fs <= 89.5        => 'B037',
                                           'B037') ) ;

l_bv_sos_mth_fs_w := __common__( map(
    bv_sos_mth_fs = NULL  => 0.00000,
    bv_sos_mth_fs = -1    => -0.01270,
    bv_sos_mth_fs <= 41.5 => 0.15957,
                             -0.37590) ) ;

l_aa_dist_2 := __common__( (0.00000 - l_bv_sos_mth_fs_w) * 0.29495 ) ;

l_aa_code_2 := __common__( map(
    l_bv_sos_mth_fs_w = -0.37590 => '',
    bv_sos_mth_fs = NULL         => 'B031',
    bv_sos_mth_fs = -1           => 'B055',
    bv_sos_mth_fs <= 41.5        => 'B057',
                                    'B057') ) ;

l_bv_lien_judg_index_w := __common__( map(
    bv_lien_judg_index = NULL => 0.00000,
    bv_lien_judg_index <= 0   => -0.01731,
                                 1.07247) ) ;

l_aa_dist_3 := __common__( (0.00000 - l_bv_lien_judg_index_w) * 0.68527 ) ;

l_aa_code_3 := __common__( map(
    l_bv_lien_judg_index_w = -0.01731 => '',
    bv_lien_judg_index = NULL         => 'B031',
    bv_lien_judg_index <= 0           => 'B063',
                                         'B063') ) ;

l_bv_prop_assessed_value_w := __common__( map(
    bv_prop_assessed_value = NULL    => 0.00000,
    bv_prop_assessed_value = -1      => 0.07628,
    bv_prop_assessed_value <= 0      => -0.00177,
    bv_prop_assessed_value <= 126208 => -0.30584,
                                        -1.51621) ) ;

l_aa_dist_4 := __common__( (0.00000 - l_bv_prop_assessed_value_w) * 0.45444 ) ;

l_aa_code_4 := __common__( map(
    l_bv_prop_assessed_value_w = -1.51621 => '',
    bv_prop_assessed_value = NULL         => 'B031',
    bv_prop_assessed_value = -1           => 'B052',
    bv_prop_assessed_value <= 0           => 'B053',
    bv_prop_assessed_value <= 126208      => 'B053',
                                             'B053') ) ;

l_bv_mths_inq_lastseen_w := __common__( map(
    bv_mths_inq_lastseen = NULL  => 0.00000,
    bv_mths_inq_lastseen = -1    => -0.07352,
    bv_mths_inq_lastseen <= 17.5 => 0.50892,
                                    0.09035) ) ;

l_aa_dist_5 := __common__( (0.00000 - l_bv_mths_inq_lastseen_w) * 0.35857 ) ;

l_aa_code_5 := __common__( map(
    l_bv_mths_inq_lastseen_w = -0.07352 => '',
    bv_mths_inq_lastseen = NULL         => 'B031',
    bv_mths_inq_lastseen = -1           => 'B040',
    bv_mths_inq_lastseen <= 17.5        => 'B040',
                                           'B040') ) ;

l_bv_mth_ver_src_p_ls_w := __common__( map(
    bv_mth_ver_src_p_ls = NULL  => 0.00000,
    bv_mth_ver_src_p_ls = -1    => 0.08560,
    bv_mth_ver_src_p_ls <= 7.5  => -1.19482,
    bv_mth_ver_src_p_ls <= 22.5 => -0.92452,
                                   -0.33550) ) ;

l_aa_dist_6 := __common__( (0.00000 - l_bv_mth_ver_src_p_ls_w) * 0.43513 ) ;

l_aa_code_6 := __common__( map(
    l_bv_mth_ver_src_p_ls_w = -1.19482 => '',
    bv_mth_ver_src_p_ls = NULL         => 'B038',
    bv_mth_ver_src_p_ls = -1           => 'B052',
    bv_mth_ver_src_p_ls <= 7.5         => 'B038',
    bv_mth_ver_src_p_ls <= 22.5        => 'B038',
                                          'B038') ) ;

l_bv_mth_ver_src_q3_fs_w := __common__( map(
    bv_mth_ver_src_q3_fs = NULL  => 0.00000,
    bv_mth_ver_src_q3_fs = -1    => -0.12328,
    bv_mth_ver_src_q3_fs <= 10.5 => 0.54942,
    bv_mth_ver_src_q3_fs <= 39.5 => 0.39845,
                                    -0.01455) ) ;

l_aa_dist_7 := __common__( (0.00000 - l_bv_mth_ver_src_q3_fs_w) * 0.21837 ) ;

l_aa_code_7 := __common__( map(
    l_bv_mth_ver_src_q3_fs_w = -0.12328 => '',
    bv_mth_ver_src_q3_fs = NULL         => 'B031',
    bv_mth_ver_src_q3_fs = -1           => 'B034',
    bv_mth_ver_src_q3_fs <= 10.5        => 'B037',
    bv_mth_ver_src_q3_fs <= 39.5        => 'B037',
                                           'B037') ) ;

l_rv_d30_derog_count_w := __common__( map(
    rv_d30_derog_count = NULL => 0.00000,
    rv_d30_derog_count <= 0.5 => -0.26285,
    rv_d30_derog_count <= 1.5 => 0.21632,
    rv_d30_derog_count <= 3.5 => 0.35376,
    rv_d30_derog_count <= 4.5 => 0.64221,
    rv_d30_derog_count <= 7.5 => 0.75747,
                                 1.06239) ) ;

l_aa_dist_8 := __common__( (0.00000 - l_rv_d30_derog_count_w) * 0.21478 ) ;

l_aa_code_8 := __common__( map(
    l_rv_d30_derog_count_w = -0.26285 => '',
    rv_d30_derog_count = NULL         => 'P535',
    rv_d30_derog_count <= 0.5         => 'P526',
    rv_d30_derog_count <= 1.5         => 'P526',
    rv_d30_derog_count <= 3.5         => 'P526',
    rv_d30_derog_count <= 4.5         => 'P526',
    rv_d30_derog_count <= 7.5         => 'P526',
                                         'P526') ) ;

l_rv_d31_bk_chapter_w := __common__( map(
    rv_d31_bk_chapter = '' 						=> 0.00000,
    (integer)rv_d31_bk_chapter <= 3.5 => -0.08570,
																				 0.99863) ) ;

l_aa_dist_9 := __common__( (0.00000 - l_rv_d31_bk_chapter_w) * 0.49892 ) ;

l_aa_code_9 := __common__( map(
    l_rv_d31_bk_chapter_w = -0.08570 	=> '',
    rv_d31_bk_chapter = ''         		=> 'P535',
    (integer)rv_d31_bk_chapter <= 3.5 => 'P526',
                                         'P526') ) ;

l_rv_d34_unrel_liens_ct_w := __common__( map(
    rv_d34_unrel_liens_ct = NULL => 0.00000,
    rv_d34_unrel_liens_ct <= 0.5 => -0.13562,
    rv_d34_unrel_liens_ct <= 1.5 => 0.55464,
    rv_d34_unrel_liens_ct <= 4.5 => 0.82155,
                                    1.11030) ) ;

l_aa_dist_10 := __common__( (0.00000 - l_rv_d34_unrel_liens_ct_w) * 0.27430 ) ;

l_aa_code_10 := __common__( map(
    l_rv_d34_unrel_liens_ct_w = -0.13562 => '',
    rv_d34_unrel_liens_ct = NULL         => 'P535',
    rv_d34_unrel_liens_ct <= 0.5         => 'P526',
    rv_d34_unrel_liens_ct <= 1.5         => 'P526',
    rv_d34_unrel_liens_ct <= 4.5         => 'P526',
                                            'P526') ) ;

l_rv_a46_curr_avm_autoval_w := __common__( map(
    rv_a46_curr_avm_autoval = NULL    => 0.00000,
    rv_a46_curr_avm_autoval <= 0      => 0.08924,
    rv_a46_curr_avm_autoval <= 115000 => 0.53006,
    rv_a46_curr_avm_autoval <= 173389 => 0.36358,
    rv_a46_curr_avm_autoval <= 193987 => 0.22248,
    rv_a46_curr_avm_autoval <= 270119 => -0.09970,
                                         -0.54774) ) ;

l_aa_dist_11 := __common__( (0.00000 - l_rv_a46_curr_avm_autoval_w) * 0.80079 ) ;

l_aa_code_11 := __common__( map(
    l_rv_a46_curr_avm_autoval_w = -0.54774 => '',
    rv_a46_curr_avm_autoval = NULL         => 'P535',
    rv_a46_curr_avm_autoval <= 0           => 'P509',
    rv_a46_curr_avm_autoval <= 115000      => 'P509',
    rv_a46_curr_avm_autoval <= 173389      => 'P509',
    rv_a46_curr_avm_autoval <= 193987      => 'P509',
    rv_a46_curr_avm_autoval <= 270119      => 'P509',
                                              'P509') ) ;

l_rv_a41_a42_prop_owner_hist_w := __common__( map(
    rv_a41_a42_prop_owner_history = ''              	=> 0.00000,
    (rv_a41_a42_prop_owner_history in [' '])          => -0.11029,
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => -0.11029,
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 0.73577,
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 0.90525,
                                                         0.00000) ) ;

l_aa_dist_12 := __common__( (0.00000 - l_rv_a41_a42_prop_owner_hist_w) * 0.30565 ) ;

l_aa_code_12 := __common__( map(
    l_rv_a41_a42_prop_owner_hist_w = -0.11029         => '',
    rv_a41_a42_prop_owner_history = ''              	=> 'P535',
    (rv_a41_a42_prop_owner_history in [' '])          => 'P506',
    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 'P506',
    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'P506',
    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'P506',
                                                         'P535') ) ;

l_rv_e55_college_ind_w := __common__( map(
    rv_e55_college_ind = '' => 0.00000,
    rv_e55_college_ind = '0' => 0.06972,
                                 -0.33938) ) ;

l_aa_dist_13 := __common__( (0.00000 - l_rv_e55_college_ind_w) * 0.90180 ) ;

l_aa_code_13 := __common__( map(
    l_rv_e55_college_ind_w = -0.33938 => '',
    rv_e55_college_ind = ''         	=> 'P535',
    rv_e55_college_ind = '0'          => 'P532',
                                         'P532') ) ;

l_rv_i61_inq_collection_rec_w := __common__( map(
    rv_i61_inq_collection_recency = NULL  => 0.00000,
    rv_i61_inq_collection_recency <= 0.5  => -0.24862,
    rv_i61_inq_collection_recency <= 4.5  => 0.91222,
    rv_i61_inq_collection_recency <= 61.5 => 0.39889,
                                             0.15346) ) ;

l_aa_dist_14 := __common__( (0.00000 - l_rv_i61_inq_collection_rec_w) * 0.48060 ) ;

l_aa_code_14 := __common__( map(
    l_rv_i61_inq_collection_rec_w = -0.24862 => '',
    rv_i61_inq_collection_recency = NULL     => 'P535',
    rv_i61_inq_collection_recency <= 0.5     => 'P539',
    rv_i61_inq_collection_recency <= 4.5     => 'P539',
    rv_i61_inq_collection_recency <= 61.5    => 'P539',
                                                'P539') ) ;

l_rv_i60_inq_auto_recency_w := __common__( map(
    rv_i60_inq_auto_recency = NULL => 0.00000,
    rv_i60_inq_auto_recency <= 0.5 => -0.07858,
                                      0.65157) ) ;

l_aa_dist_15 := __common__( (0.00000 - l_rv_i60_inq_auto_recency_w) * 0.43425 ) ;

l_aa_code_15 := __common__( map(
    l_rv_i60_inq_auto_recency_w = -0.07858 => '',
    rv_i60_inq_auto_recency = NULL         => 'P535',
    rv_i60_inq_auto_recency <= 0.5         => 'P539',
                                              'P539') ) ;

l_rv_d34_attr_liens_recency_w := __common__( map(
    rv_d34_attr_liens_recency = NULL  => 0.00000,
    rv_d34_attr_liens_recency <= 0.5  => -0.14865,
    rv_d34_attr_liens_recency <= 18   => 1.05628,
    rv_d34_attr_liens_recency <= 79.5 => 0.82860,
                                         0.60523) ) ;

l_aa_dist_16 := __common__( (0.00000 - l_rv_d34_attr_liens_recency_w) * 0.20213 ) ;

l_aa_code_16 := __common__( map(
    l_rv_d34_attr_liens_recency_w = -0.14865 => '',
    rv_d34_attr_liens_recency = NULL         => 'P535',
    rv_d34_attr_liens_recency <= 0.5         => 'P526',
    rv_d34_attr_liens_recency <= 18          => 'P526',
    rv_d34_attr_liens_recency <= 79.5        => 'P526',
                                                'P526') ) ;

l_rv_mos_since_br_first_seen_w := __common__( map(
    rv_mos_since_br_first_seen = NULL   => 0.00000,
    rv_mos_since_br_first_seen = -1     => 0.09290,
    rv_mos_since_br_first_seen <= 70.5  => 0.18119,
    rv_mos_since_br_first_seen <= 121.5 => -0.14384,
                                           -0.36215) ) ;

l_aa_dist_17 := __common__( (0.00000 - l_rv_mos_since_br_first_seen_w) * 0.33850 ) ;

l_aa_code_17 := __common__( map(
    l_rv_mos_since_br_first_seen_w = -0.36215 => '',
    rv_mos_since_br_first_seen = NULL         => 'P535',
    rv_mos_since_br_first_seen = -1           => 'P534',
    rv_mos_since_br_first_seen <= 70.5        => 'P534',
    rv_mos_since_br_first_seen <= 121.5       => 'P534',
                                                 'P534') ) ;

l_iv_d34_liens_rel_sc_ct_w := __common__( map(
    iv_d34_liens_rel_sc_ct = NULL => 0.00000,
    iv_d34_liens_rel_sc_ct <= 0.5 => -0.01219,
                                     0.91531) ) ;

l_aa_dist_18 := __common__( (0.00000 - l_iv_d34_liens_rel_sc_ct_w) * 0.47831 ) ;

l_aa_code_18 := __common__( map(
    l_iv_d34_liens_rel_sc_ct_w = -0.01219 => '',
    iv_d34_liens_rel_sc_ct = NULL         => 'P535',
    iv_d34_liens_rel_sc_ct <= 0.5         => 'P526',
                                             'P526') ) ;

l_nf_inq_highriskcredit_count_w := __common__( map(
    nf_inq_highriskcredit_count = NULL => 0.00000,
    nf_inq_highriskcredit_count <= 0.5 => -0.02564,
                                          1.20086) ) ;

l_aa_dist_19 := __common__( (0.00000 - l_nf_inq_highriskcredit_count_w) * 0.42295 ) ;

l_aa_code_19 := __common__( map(
    l_nf_inq_highriskcredit_count_w = -0.02564 => '',
    nf_inq_highriskcredit_count = NULL         => 'P535',
    nf_inq_highriskcredit_count <= 0.5         => 'P539',
                                                  'P539') ) ;

l_nf_mos_inq_banko_cm_fseen_w := __common__( map(
    nf_mos_inq_banko_cm_fseen = NULL => 0.00000,
    nf_mos_inq_banko_cm_fseen = -1   => -0.14661,
                                        0.79274) ) ;

l_aa_dist_20 := __common__( (0.00000 - l_nf_mos_inq_banko_cm_fseen_w) * 0.44918 ) ;

l_aa_code_20 := __common__( map(
    l_nf_mos_inq_banko_cm_fseen_w = -0.14661 => '',
    nf_mos_inq_banko_cm_fseen = NULL         => 'P535',
    nf_mos_inq_banko_cm_fseen = -1           => 'P539',
                                                'P539') ) ;

l_nf_mos_acc_lseen_w := __common__( map(
    nf_mos_acc_lseen = NULL  => 0.00000,
    nf_mos_acc_lseen = -1    => -0.05444,
    nf_mos_acc_lseen <= 52.5 => 0.42884,
                                0.16057) ) ;

l_aa_dist_21 := __common__( (0.00000 - l_nf_mos_acc_lseen_w) * 0.48429 ) ;

l_aa_code_21 := __common__( map(
    l_nf_mos_acc_lseen_w = -0.05444 => '',
    nf_mos_acc_lseen = NULL         => 'P535',
    nf_mos_acc_lseen = -1           => 'P531',
    nf_mos_acc_lseen <= 52.5        => 'P531',
                                       'P531') ) ;

l_nf_fp_vardobcountnew_w := __common__( map(
    nf_fp_vardobcountnew = NULL => 0.00000,
    nf_fp_vardobcountnew <= 0.5 => -0.10184,
                                   0.50518) ) ;

l_aa_dist_22 := __common__( (0.00000 - l_nf_fp_vardobcountnew_w) * 0.37684 ) ;

l_aa_code_22 := __common__( map(
    l_nf_fp_vardobcountnew_w = -0.10184 => '',
    nf_fp_vardobcountnew = NULL         => 'P535',
    nf_fp_vardobcountnew <= 0.5         => 'P562',
                                           'P562') ) ;

l_nf_fp_srchfraudsrchcountmo_w := __common__( map(
    nf_fp_srchfraudsrchcountmo = NULL => 0.00000,
    nf_fp_srchfraudsrchcountmo <= 0.5 => -0.04952,
                                         0.66454) ) ;

l_aa_dist_23 := __common__( (0.00000 - l_nf_fp_srchfraudsrchcountmo_w) * 0.46921 ) ;

l_aa_code_23 := __common__( map(
    l_nf_fp_srchfraudsrchcountmo_w = -0.04952 => '',
    nf_fp_srchfraudsrchcountmo = NULL         => 'P535',
    nf_fp_srchfraudsrchcountmo <= 0.5         => 'P539',
                                                 'P539') ) ;

l_nf_fp_prevaddrstatus_w := __common__( map(
    nf_fp_prevaddrstatus = ''            => 0.00000,
    (nf_fp_prevaddrstatus in ['-1'])     => -0.17631,
    (nf_fp_prevaddrstatus in ['O'])      => -0.17631,
    (nf_fp_prevaddrstatus in ['R', 'U']) => 0.43669,
                                            0.00000) ) ;

l_aa_dist_24 := __common__( (0.00000 - l_nf_fp_prevaddrstatus_w) * 0.23004 ) ;

l_aa_code_24 := __common__( map(
    l_nf_fp_prevaddrstatus_w = -0.17631  => '',
    nf_fp_prevaddrstatus = ''          	 => 'P535',
    (nf_fp_prevaddrstatus in ['-1'])     => 'P506',
    (nf_fp_prevaddrstatus in ['O'])      => 'P506',
    (nf_fp_prevaddrstatus in ['R', 'U']) => 'P506',
                                            'P535') ) ;

l_bv_bus_rep_source_profile_w := __common__( map(
    bv_bus_rep_source_profile = NULL           => 0.00000,
    bv_bus_rep_source_profile <= -3.2732094445 => -1.23387,
    bv_bus_rep_source_profile <= -3.108428272  => -0.83121,
    bv_bus_rep_source_profile <= -2.9163107055 => -0.69887,
    bv_bus_rep_source_profile <= -2.4983078675 => -0.38913,
    bv_bus_rep_source_profile <= -2.3534853325 => -0.06630,
    bv_bus_rep_source_profile <= -2.04444081   => 0.21320,
    bv_bus_rep_source_profile <= -1.810716923  => 0.44392,
                                                  0.84973) ) ;

l_aa_dist_25 := __common__( (0.00000 - l_bv_bus_rep_source_profile_w) * 0.35584 ) ;

l_aa_code_25 := __common__( map(
    l_bv_bus_rep_source_profile_w = -1.23387                                                                                                                                                                                                                                                                                        => '',
    bv_bus_rep_source_profile = NULL                                                                                                                                                                                                                                                                                                => 'B015',
    c_vs_gb_id_mth_fseen_w > -0.332795531639556 and not(vs_gb_id_mth_fseen = NULL) or c_vs_gb_id_mth_lseen_w > -0.449754168846876 and not(vs_gb_id_mth_lseen = NULL) or c_vs_ver_src_id__bm_w > -1.30106683426937 and not(vs_ver_src_id__bm = NULL) or c_vs_ver_src_id__in_w > -0.841849028747299 and not(vs_ver_src_id__in = NULL) => 'B034',
                                                                                                                                                                                                                                                                                                                                       'P515') ) ;

l_bv_rep_only_source_profile_w := __common__( map(
    bv_rep_only_source_profile = NULL           => 0.00000,
    bv_rep_only_source_profile <= -3.351397782  => -1.30380,
    bv_rep_only_source_profile <= -3.036453869  => -0.87351,
    bv_rep_only_source_profile <= -2.8822673305 => -0.57121,
    bv_rep_only_source_profile <= -2.673008193  => -0.45494,
    bv_rep_only_source_profile <= -2.370716195  => -0.14977,
    bv_rep_only_source_profile <= -2.238623317  => 0.09605,
    bv_rep_only_source_profile <= -1.709934168  => 0.40452,
    bv_rep_only_source_profile <= -1.4589158935 => 0.76427,
                                                   1.12640) ) ;

l_aa_dist_26 := __common__( (0.00000 - l_bv_rep_only_source_profile_w) * 0.29460 ) ;

l_aa_code_26 := __common__( map(
    l_bv_rep_only_source_profile_w = -1.30380   => '',
    bv_rep_only_source_profile = NULL           => 'P535',
    bv_rep_only_source_profile <= -3.351397782  => 'P515',
    bv_rep_only_source_profile <= -3.036453869  => 'P515',
    bv_rep_only_source_profile <= -2.8822673305 => 'P515',
    bv_rep_only_source_profile <= -2.673008193  => 'P515',
    bv_rep_only_source_profile <= -2.370716195  => 'P515',
    bv_rep_only_source_profile <= -2.238623317  => 'P515',
    bv_rep_only_source_profile <= -1.709934168  => 'P515',
    bv_rep_only_source_profile <= -1.4589158935 => 'P515',
                                                   'P515') ) ;

l_bv_assoc_derog_flag_w := __common__( map(
    bv_assoc_derog_flag = NULL => 0.00000,
    bv_assoc_derog_flag = -1   => -0.04143,
    bv_assoc_derog_flag <= 0.5 => -0.16099,
                                  0.79617) ) ;

l_aa_dist_27 := __common__( (0.00000 - l_bv_assoc_derog_flag_w) * 0.27679 ) ;

l_aa_code_27 := __common__( map(
    l_bv_assoc_derog_flag_w = -0.16099 => '',
    bv_assoc_derog_flag = NULL         => 'B031',
    bv_assoc_derog_flag = -1           => 'B017',
    bv_assoc_derog_flag <= 0.5         => 'B026',
                                          'B026') ) ;

l_nf_m_bureau_adl_fs_notu_w := __common__( map(
    nf_m_bureau_adl_fs_notu = NULL   => 0.00000,
    nf_m_bureau_adl_fs_notu = -1     => 0.00000,
    nf_m_bureau_adl_fs_notu <= 54.5  => 0.93231,
    nf_m_bureau_adl_fs_notu <= 69.5  => 0.77138,
    nf_m_bureau_adl_fs_notu <= 85.5  => 0.64839,
    nf_m_bureau_adl_fs_notu <= 182.5 => 0.25865,
    nf_m_bureau_adl_fs_notu <= 233.5 => 0.18218,
    nf_m_bureau_adl_fs_notu <= 282.5 => 0.07435,
    nf_m_bureau_adl_fs_notu <= 306.5 => -0.10472,
    nf_m_bureau_adl_fs_notu <= 338.5 => -0.21321,
                                        -0.40789) ) ;

l_aa_dist_28 := __common__( (0.00000 - l_nf_m_bureau_adl_fs_notu_w) * 0.13872 ) ;

l_aa_code_28 := __common__( map(
    l_nf_m_bureau_adl_fs_notu_w = -0.40789 => '',
    nf_m_bureau_adl_fs_notu = NULL         => 'P535',
    nf_m_bureau_adl_fs_notu = -1           => 'P515',
    nf_m_bureau_adl_fs_notu <= 54.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 69.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 85.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 182.5       => 'P523',
    nf_m_bureau_adl_fs_notu <= 233.5       => 'P523',
    nf_m_bureau_adl_fs_notu <= 282.5       => 'P523',
    nf_m_bureau_adl_fs_notu <= 306.5       => 'P523',
    nf_m_bureau_adl_fs_notu <= 338.5       => 'P523',
                                              'P523') ) ;

l_aa_code_29 := __common__( 'BF108' ) ;

l_aa_dist_29 := __common__( -999 ) ;

l_rcvalueb037 := __common__( (integer)(l_aa_code_1 = 'B037') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B037') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B037') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B037') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B037') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B037') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B037') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B037') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B037') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B037') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B037') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B037') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B037') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B037') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B037') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B037') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B037') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B037') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B037') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B037') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B037') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B037') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B037') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B037') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B037') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B037') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B037') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B037') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B037') * l_aa_dist_29 ) ;

l_rcvaluep531 := __common__( (integer)(l_aa_code_1 = 'P531') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P531') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P531') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P531') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P531') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P531') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P531') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P531') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P531') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P531') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P531') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P531') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P531') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P531') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P531') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P531') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P531') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P531') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P531') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P531') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P531') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P531') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P531') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P531') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P531') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P531') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P531') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P531') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P531') * l_aa_dist_29 ) ;

l_rcvaluep532 := __common__( (integer)(l_aa_code_1 = 'P532') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P532') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P532') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P532') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P532') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P532') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P532') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P532') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P532') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P532') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P532') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P532') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P532') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P532') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P532') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P532') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P532') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P532') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P532') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P532') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P532') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P532') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P532') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P532') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P532') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P532') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P532') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P532') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P532') * l_aa_dist_29 ) ;

l_rcvalueb034 := __common__( (integer)(l_aa_code_1 = 'B034') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B034') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B034') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B034') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B034') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B034') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B034') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B034') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B034') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B034') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B034') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B034') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B034') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B034') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B034') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B034') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B034') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B034') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B034') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B034') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B034') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B034') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B034') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B034') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B034') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B034') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B034') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B034') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B034') * l_aa_dist_29 ) ;

l_rcvaluep534 := __common__( (integer)(l_aa_code_1 = 'P534') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P534') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P534') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P534') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P534') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P534') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P534') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P534') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P534') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P534') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P534') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P534') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P534') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P534') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P534') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P534') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P534') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P534') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P534') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P534') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P534') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P534') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P534') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P534') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P534') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P534') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P534') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P534') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P534') * l_aa_dist_29 ) ;

l_rcvaluep535 := __common__( (integer)(l_aa_code_1 = 'P535') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P535') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P535') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P535') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P535') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P535') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P535') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P535') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P535') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P535') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P535') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P535') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P535') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P535') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P535') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P535') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P535') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P535') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P535') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P535') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P535') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P535') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P535') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P535') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P535') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P535') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P535') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P535') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P535') * l_aa_dist_29 ) ;

l_rcvalueb031 := __common__( (integer)(l_aa_code_1 = 'B031') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B031') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B031') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B031') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B031') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B031') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B031') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B031') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B031') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B031') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B031') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B031') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B031') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B031') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B031') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B031') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B031') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B031') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B031') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B031') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B031') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B031') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B031') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B031') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B031') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B031') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B031') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B031') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B031') * l_aa_dist_29 ) ;

l_rcvalueb015 := __common__( (integer)(l_aa_code_1 = 'B015') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B015') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B015') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B015') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B015') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B015') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B015') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B015') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B015') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B015') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B015') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B015') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B015') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B015') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B015') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B015') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B015') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B015') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B015') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B015') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B015') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B015') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B015') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B015') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B015') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B015') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B015') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B015') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B015') * l_aa_dist_29 ) ;

l_rcvaluep539 := __common__( (integer)(l_aa_code_1 = 'P539') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P539') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P539') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P539') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P539') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P539') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P539') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P539') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P539') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P539') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P539') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P539') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P539') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P539') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P539') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P539') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P539') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P539') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P539') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P539') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P539') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P539') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P539') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P539') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P539') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P539') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P539') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P539') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P539') * l_aa_dist_29 ) ;

l_rcvalueb017 := __common__( (integer)(l_aa_code_1 = 'B017') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B017') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B017') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B017') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B017') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B017') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B017') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B017') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B017') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B017') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B017') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B017') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B017') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B017') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B017') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B017') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B017') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B017') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B017') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B017') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B017') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B017') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B017') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B017') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B017') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B017') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B017') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B017') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B017') * l_aa_dist_29 ) ;

l_rcvaluep515 := __common__( (integer)(l_aa_code_1 = 'P515') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P515') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P515') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P515') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P515') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P515') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P515') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P515') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P515') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P515') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P515') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P515') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P515') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P515') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P515') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P515') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P515') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P515') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P515') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P515') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P515') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P515') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P515') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P515') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P515') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P515') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P515') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P515') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P515') * l_aa_dist_29 ) ;

l_rcvalueb038 := __common__( (integer)(l_aa_code_1 = 'B038') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B038') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B038') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B038') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B038') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B038') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B038') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B038') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B038') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B038') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B038') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B038') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B038') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B038') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B038') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B038') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B038') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B038') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B038') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B038') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B038') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B038') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B038') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B038') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B038') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B038') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B038') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B038') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B038') * l_aa_dist_29 ) ;

l_rcvalueb040 := __common__( (integer)(l_aa_code_1 = 'B040') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B040') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B040') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B040') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B040') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B040') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B040') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B040') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B040') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B040') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B040') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B040') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B040') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B040') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B040') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B040') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B040') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B040') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B040') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B040') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B040') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B040') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B040') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B040') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B040') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B040') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B040') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B040') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B040') * l_aa_dist_29 ) ;

l_rcvaluep509 := __common__( (integer)(l_aa_code_1 = 'P509') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P509') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P509') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P509') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P509') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P509') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P509') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P509') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P509') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P509') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P509') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P509') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P509') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P509') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P509') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P509') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P509') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P509') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P509') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P509') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P509') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P509') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P509') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P509') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P509') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P509') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P509') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P509') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P509') * l_aa_dist_29 ) ;

l_rcvalueb026 := __common__( (integer)(l_aa_code_1 = 'B026') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B026') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B026') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B026') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B026') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B026') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B026') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B026') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B026') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B026') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B026') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B026') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B026') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B026') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B026') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B026') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B026') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B026') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B026') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B026') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B026') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B026') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B026') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B026') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B026') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B026') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B026') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B026') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B026') * l_aa_dist_29 ) ;

l_rcvaluep526 := __common__( (integer)(l_aa_code_1 = 'P526') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P526') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P526') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P526') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P526') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P526') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P526') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P526') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P526') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P526') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P526') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P526') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P526') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P526') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P526') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P526') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P526') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P526') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P526') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P526') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P526') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P526') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P526') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P526') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P526') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P526') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P526') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P526') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P526') * l_aa_dist_29 ) ;

l_rcvalueb063 := __common__( (integer)(l_aa_code_1 = 'B063') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B063') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B063') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B063') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B063') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B063') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B063') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B063') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B063') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B063') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B063') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B063') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B063') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B063') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B063') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B063') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B063') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B063') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B063') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B063') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B063') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B063') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B063') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B063') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B063') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B063') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B063') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B063') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B063') * l_aa_dist_29 ) ;

l_rcvaluep506 := __common__( (integer)(l_aa_code_1 = 'P506') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P506') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P506') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P506') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P506') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P506') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P506') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P506') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P506') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P506') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P506') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P506') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P506') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P506') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P506') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P506') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P506') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P506') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P506') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P506') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P506') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P506') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P506') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P506') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P506') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P506') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P506') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P506') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P506') * l_aa_dist_29 ) ;

l_rcvaluebf108 := __common__( (integer)(l_aa_code_1 = 'BF108') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'BF108') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'BF108') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'BF108') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'BF108') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'BF108') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'BF108') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'BF108') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'BF108') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'BF108') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'BF108') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'BF108') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'BF108') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'BF108') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'BF108') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'BF108') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'BF108') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'BF108') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'BF108') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'BF108') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'BF108') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'BF108') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'BF108') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'BF108') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'BF108') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'BF108') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'BF108') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'BF108') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'BF108') * l_aa_dist_29 ) ;

l_rcvaluep562 := __common__( (integer)(l_aa_code_1 = 'P562') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P562') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P562') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P562') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P562') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P562') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P562') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P562') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P562') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P562') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P562') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P562') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P562') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P562') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P562') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P562') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P562') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P562') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P562') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P562') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P562') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P562') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P562') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P562') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P562') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P562') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P562') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P562') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P562') * l_aa_dist_29 ) ;

l_rcvalueb053 := __common__( (integer)(l_aa_code_1 = 'B053') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B053') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B053') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B053') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B053') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B053') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B053') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B053') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B053') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B053') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B053') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B053') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B053') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B053') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B053') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B053') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B053') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B053') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B053') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B053') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B053') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B053') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B053') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B053') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B053') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B053') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B053') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B053') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B053') * l_aa_dist_29 ) ;

l_rcvalueb052 := __common__( (integer)(l_aa_code_1 = 'B052') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B052') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B052') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B052') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B052') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B052') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B052') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B052') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B052') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B052') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B052') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B052') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B052') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B052') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B052') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B052') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B052') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B052') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B052') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B052') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B052') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B052') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B052') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B052') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B052') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B052') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B052') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B052') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B052') * l_aa_dist_29 ) ;

l_rcvalueb055 := __common__( (integer)(l_aa_code_1 = 'B055') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B055') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B055') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B055') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B055') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B055') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B055') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B055') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B055') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B055') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B055') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B055') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B055') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B055') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B055') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B055') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B055') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B055') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B055') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B055') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B055') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B055') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B055') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B055') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B055') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B055') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B055') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B055') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B055') * l_aa_dist_29 ) ;

l_rcvalueb057 := __common__( (integer)(l_aa_code_1 = 'B057') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'B057') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'B057') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'B057') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'B057') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'B057') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'B057') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'B057') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'B057') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'B057') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'B057') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'B057') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'B057') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'B057') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'B057') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'B057') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'B057') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'B057') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'B057') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'B057') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'B057') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'B057') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'B057') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'B057') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'B057') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'B057') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'B057') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'B057') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'B057') * l_aa_dist_29 ) ;

l_rcvaluep523 := __common__( (integer)(l_aa_code_1 = 'P523') * l_aa_dist_1 +
    (integer)(l_aa_code_2 = 'P523') * l_aa_dist_2 +
    (integer)(l_aa_code_3 = 'P523') * l_aa_dist_3 +
    (integer)(l_aa_code_4 = 'P523') * l_aa_dist_4 +
    (integer)(l_aa_code_5 = 'P523') * l_aa_dist_5 +
    (integer)(l_aa_code_6 = 'P523') * l_aa_dist_6 +
    (integer)(l_aa_code_7 = 'P523') * l_aa_dist_7 +
    (integer)(l_aa_code_8 = 'P523') * l_aa_dist_8 +
    (integer)(l_aa_code_9 = 'P523') * l_aa_dist_9 +
    (integer)(l_aa_code_10 = 'P523') * l_aa_dist_10 +
    (integer)(l_aa_code_11 = 'P523') * l_aa_dist_11 +
    (integer)(l_aa_code_12 = 'P523') * l_aa_dist_12 +
    (integer)(l_aa_code_13 = 'P523') * l_aa_dist_13 +
    (integer)(l_aa_code_14 = 'P523') * l_aa_dist_14 +
    (integer)(l_aa_code_15 = 'P523') * l_aa_dist_15 +
    (integer)(l_aa_code_16 = 'P523') * l_aa_dist_16 +
    (integer)(l_aa_code_17 = 'P523') * l_aa_dist_17 +
    (integer)(l_aa_code_18 = 'P523') * l_aa_dist_18 +
    (integer)(l_aa_code_19 = 'P523') * l_aa_dist_19 +
    (integer)(l_aa_code_20 = 'P523') * l_aa_dist_20 +
    (integer)(l_aa_code_21 = 'P523') * l_aa_dist_21 +
    (integer)(l_aa_code_22 = 'P523') * l_aa_dist_22 +
    (integer)(l_aa_code_23 = 'P523') * l_aa_dist_23 +
    (integer)(l_aa_code_24 = 'P523') * l_aa_dist_24 +
    (integer)(l_aa_code_25 = 'P523') * l_aa_dist_25 +
    (integer)(l_aa_code_26 = 'P523') * l_aa_dist_26 +
    (integer)(l_aa_code_27 = 'P523') * l_aa_dist_27 +
    (integer)(l_aa_code_28 = 'P523') * l_aa_dist_28 +
    (integer)(l_aa_code_29 = 'P523') * l_aa_dist_29 ) ;

l_final_score := __common__( -2.35817084802197 +
    l_bv_src_id_phn_mth_fs_w * 0.395519291061882 +
    l_bv_sos_mth_fs_w * 0.294952580230514 +
    l_bv_lien_judg_index_w * 0.685272352930671 +
    l_bv_prop_assessed_value_w * 0.454439835057305 +
    l_bv_mths_inq_lastseen_w * 0.358573738525966 +
    l_bv_mth_ver_src_p_ls_w * 0.435128893386933 +
    l_bv_mth_ver_src_q3_fs_w * 0.218370935192408 +
    l_rv_d30_derog_count_w * 0.214779158784365 +
    l_rv_d31_bk_chapter_w * 0.498923337968062 +
    l_rv_d34_unrel_liens_ct_w * 0.274298129796606 +
    l_rv_a46_curr_avm_autoval_w * 0.800785136303584 +
    l_rv_a41_a42_prop_owner_hist_w * 0.305652647885072 +
    l_rv_e55_college_ind_w * 0.901797744400152 +
    l_rv_i61_inq_collection_rec_w * 0.480598360162768 +
    l_rv_i60_inq_auto_recency_w * 0.434245872458094 +
    l_rv_d34_attr_liens_recency_w * 0.202126083388078 +
    l_rv_mos_since_br_first_seen_w * 0.338502139408868 +
    l_iv_d34_liens_rel_sc_ct_w * 0.47831064915699 +
    l_nf_inq_highriskcredit_count_w * 0.422950601396284 +
    l_nf_mos_inq_banko_cm_fseen_w * 0.449182628442498 +
    l_nf_mos_acc_lseen_w * 0.484290900840513 +
    l_nf_fp_vardobcountnew_w * 0.376837506376216 +
    l_nf_fp_srchfraudsrchcountmo_w * 0.469214394823393 +
    l_nf_fp_prevaddrstatus_w * 0.230044973750922 +
    l_bv_bus_rep_source_profile_w * 0.355843053847878 +
    l_bv_rep_only_source_profile_w * 0.294604952901796 +
    l_bv_assoc_derog_flag_w * 0.276786043880465 +
    l_nf_m_bureau_adl_fs_notu_w * 0.138717479300482 ) ;

u_rv_d30_derog_count_w := __common__( map(
    rv_d30_derog_count = NULL  => 0.00000,
    rv_d30_derog_count <= 0.5  => -0.23513,
    rv_d30_derog_count <= 1.5  => 0.08971,
    rv_d30_derog_count <= 3.5  => 0.42648,
    rv_d30_derog_count <= 4.5  => 0.53663,
    rv_d30_derog_count <= 7.5  => 0.58825,
    rv_d30_derog_count <= 11.5 => 0.88900,
                                  1.42800) ) ;

u_aa_dist_1 := __common__( (0.00000 - u_rv_d30_derog_count_w) * 0.42452 ) ;

u_aa_code_1 := __common__( map(
    u_rv_d30_derog_count_w = -0.23513 => '',
    rv_d30_derog_count = NULL         => 'P535',
    rv_d30_derog_count <= 0.5         => 'P526',
    rv_d30_derog_count <= 1.5         => 'P526',
    rv_d30_derog_count <= 3.5         => 'P526',
    rv_d30_derog_count <= 4.5         => 'P526',
    rv_d30_derog_count <= 7.5         => 'P526',
    rv_d30_derog_count <= 11.5        => 'P526',
                                         'P526') ) ;

u_rv_d31_attr_bk_recency_w := __common__( map(
    rv_d31_attr_bankruptcy_recency = NULL => 0.00000,
    rv_d31_attr_bankruptcy_recency <= 6   => -0.06563,
                                             0.75590) ) ;

u_aa_dist_2 := __common__( (0.00000 - u_rv_d31_attr_bk_recency_w) * 0.23212 ) ;

u_aa_code_2 := __common__( map(
    u_rv_d31_attr_bk_recency_w = -0.06563 => '',
    rv_d31_attr_bankruptcy_recency = NULL => 'P535',
    rv_d31_attr_bankruptcy_recency <= 6   => 'P526',
                                             'P526') ) ;

u_rv_d31_bk_disposed_hist_cnt_w := __common__( map(
    rv_d31_bk_disposed_hist_count = NULL => 0.00000,
    rv_d31_bk_disposed_hist_count <= 0.5 => -0.06479,
                                            0.75860) ) ;

u_aa_dist_3 := __common__( (0.00000 - u_rv_d31_bk_disposed_hist_cnt_w) * 0.26427 ) ;

u_aa_code_3 := __common__( map(
    u_rv_d31_bk_disposed_hist_cnt_w = -0.06479 => '',
    rv_d31_bk_disposed_hist_count = NULL       => 'P535',
    rv_d31_bk_disposed_hist_count <= 0.5       => 'P526',
                                                  'P526') ) ;

u_rv_c21_stl_inq_count_w := __common__( map(
    rv_c21_stl_inq_count = NULL => 0.00000,
    rv_c21_stl_inq_count <= 0.5 => -0.01950,
                                   0.63014) ) ;

u_aa_dist_4 := __common__( (0.00000 - u_rv_c21_stl_inq_count_w) * 0.75217 ) ;

u_aa_code_4 := __common__( map(
    u_rv_c21_stl_inq_count_w = -0.01950 => '',
    rv_c21_stl_inq_count = NULL         => 'P535',
    rv_c21_stl_inq_count <= 0.5         => 'P524',
                                           'P524') ) ;

u_rv_d33_eviction_recency_w := __common__( map(
    rv_d33_eviction_recency = '  '  				 => 0.00000,
    (integer)rv_d33_eviction_recency <= 1.5  => -0.02840,
    (integer)rv_d33_eviction_recency <= 98.5 => 1.40602,
																								0.87735) ) ;

u_aa_dist_5 := __common__( (0.00000 - u_rv_d33_eviction_recency_w) * 0.20497 ) ;

u_aa_code_5 := __common__( map(
    u_rv_d33_eviction_recency_w = -0.02840		 => '',
    rv_d33_eviction_recency = '  '         		 => 'P535',
    (integer)rv_d33_eviction_recency <= 1.5    => 'P526',
    (integer)rv_d33_eviction_recency <= 98.5   => 'P526',
																									'P526') ) ;

u_rv_d34_unrel_lien60_count_w := __common__( map(
    rv_d34_unrel_lien60_count = NULL => 0.00000,
    rv_d34_unrel_lien60_count <= 0.5 => -0.04327,
                                        1.03906) ) ;

u_aa_dist_6 := __common__( (0.00000 - u_rv_d34_unrel_lien60_count_w) * 0.16260 ) ;

u_aa_code_6 := __common__( map(
    u_rv_d34_unrel_lien60_count_w = -0.04327 => '',
    rv_d34_unrel_lien60_count = NULL         => 'P535',
    rv_d34_unrel_lien60_count <= 0.5         => 'P526',
                                                'P526') ) ;

u_rv_c20_m_bureau_adl_fs_w := __common__( map(
    rv_c20_m_bureau_adl_fs = NULL   => 0.00000,
    rv_c20_m_bureau_adl_fs = -1     => 0.00000,
    rv_c20_m_bureau_adl_fs <= 45.5  => 0.93818,
    rv_c20_m_bureau_adl_fs <= 71.5  => 0.58647,
    rv_c20_m_bureau_adl_fs <= 83.5  => 0.47943,
    rv_c20_m_bureau_adl_fs <= 142.5 => 0.23621,
                                       -0.09854) ) ;

u_aa_dist_7 := __common__( (0.00000 - u_rv_c20_m_bureau_adl_fs_w) * 0.17861 ) ;

u_aa_code_7 := __common__( map(
    u_rv_c20_m_bureau_adl_fs_w = -0.09854 => '',
    rv_c20_m_bureau_adl_fs = NULL         => 'P535',
    rv_c20_m_bureau_adl_fs = -1           => 'P515',
    rv_c20_m_bureau_adl_fs <= 45.5        => 'P523',
    rv_c20_m_bureau_adl_fs <= 71.5        => 'P523',
    rv_c20_m_bureau_adl_fs <= 83.5        => 'P523',
    rv_c20_m_bureau_adl_fs <= 142.5       => 'P523',
                                             'P523') ) ;

u_rv_a46_curr_avm_autoval_w := __common__( map(
    rv_a46_curr_avm_autoval = NULL    => 0.00000,
    rv_a46_curr_avm_autoval <= 0      => 0.09539,
    rv_a46_curr_avm_autoval <= 64261  => 0.73010,
    rv_a46_curr_avm_autoval <= 130360 => 0.44163,
    rv_a46_curr_avm_autoval <= 176135 => 0.01473,
    rv_a46_curr_avm_autoval <= 290472 => -0.06279,
                                         -0.47747) ) ;

u_aa_dist_8 := __common__( (0.00000 - u_rv_a46_curr_avm_autoval_w) * 0.69358 ) ;

u_aa_code_8 := __common__( map(
    u_rv_a46_curr_avm_autoval_w = -0.47747 => '',
    rv_a46_curr_avm_autoval = NULL         => 'P535',
    rv_a46_curr_avm_autoval <= 0           => 'P509',
    rv_a46_curr_avm_autoval <= 64261       => 'P509',
    rv_a46_curr_avm_autoval <= 130360      => 'P509',
    rv_a46_curr_avm_autoval <= 176135      => 'P509',
    rv_a46_curr_avm_autoval <= 290472      => 'P509',
                                              'P509') ) ;

u_rv_a49_curr_avm_chg_1yr_pct_w := __common__( map(
    rv_a49_curr_avm_chg_1yr_pct = NULL   => 0.00000,
    rv_a49_curr_avm_chg_1yr_pct <= 66.35 => 0.58537,
    rv_a49_curr_avm_chg_1yr_pct <= 75.55 => 0.35086,
                                            -0.04787) ) ;

u_aa_dist_9 := __common__( (0.00000 - u_rv_a49_curr_avm_chg_1yr_pct_w) * 0.37899 ) ;

u_aa_code_9 := __common__( map(
    u_rv_a49_curr_avm_chg_1yr_pct_w = -0.04787                => '',
    rv_a49_curr_avm_chg_1yr_pct = NULL and not(truedid)       => 'P535',
    rv_a49_curr_avm_chg_1yr_pct = NULL and add_curr_lres < 12 => 'P516',
    rv_a49_curr_avm_chg_1yr_pct = NULL                        => 'P509',
    rv_a49_curr_avm_chg_1yr_pct <= 66.35                      => 'P511',
    rv_a49_curr_avm_chg_1yr_pct <= 75.55                      => 'P511',
                                                                 'P511') ) ;

u_rv_a41_prop_owner_w := __common__( map(
    rv_a41_prop_owner = ''  => 0.00000,
    rv_a41_prop_owner = '0' => 0.61707,
                                -0.08257) ) ;

u_aa_dist_10 := __common__( (0.00000 - u_rv_a41_prop_owner_w) * 0.38671 ) ;

u_aa_code_10 := __common__( map(
    u_rv_a41_prop_owner_w = -0.08257 => '',
    rv_a41_prop_owner = ''           => 'P535',
    rv_a41_prop_owner = '0'          => 'P502',
                                        'P502') ) ;

u_rv_e55_college_ind_w := __common__( map(
    rv_e55_college_ind = ''  => 0.00000,
    rv_e55_college_ind = '0' => 0.06624,
                                 -0.28886) ) ;

u_aa_dist_11 := __common__( (0.00000 - u_rv_e55_college_ind_w) * 0.82870 ) ;

u_aa_code_11 := __common__( map(
    u_rv_e55_college_ind_w = -0.28886 => '',
    rv_e55_college_ind = ''           => 'P535',
    rv_e55_college_ind = '0'          => 'P532',
                                         'P532') ) ;

u_rv_i61_inq_collection_cnt12_w := __common__( map(
    rv_i61_inq_collection_count12 = NULL => 0.00000,
    rv_i61_inq_collection_count12 <= 0.5 => -0.03991,
    rv_i61_inq_collection_count12 <= 2.5 => 0.43428,
                                            0.65216) ) ;

u_aa_dist_12 := __common__( (0.00000 - u_rv_i61_inq_collection_cnt12_w) * 0.23951 ) ;

u_aa_code_12 := __common__( map(
    u_rv_i61_inq_collection_cnt12_w = -0.03991 => '',
    rv_i61_inq_collection_count12 = NULL       => 'P535',
    rv_i61_inq_collection_count12 <= 0.5       => 'P539',
    rv_i61_inq_collection_count12 <= 2.5       => 'P539',
                                                  'P539') ) ;

u_rv_l79_adls_per_addr_curr_w := __common__( map(
    rv_l79_adls_per_addr_curr = NULL => 0.00000,
    rv_l79_adls_per_addr_curr <= 6.5 => -0.01000,
                                        0.29661) ) ;

u_aa_dist_13 := __common__( (0.00000 - u_rv_l79_adls_per_addr_curr_w) * 0.49411 ) ;

u_aa_code_13 := __common__( map(
    u_rv_l79_adls_per_addr_curr_w = -0.01000 => '',
    rv_l79_adls_per_addr_curr = NULL         => 'P535',
    rv_l79_adls_per_addr_curr <= 6.5         => 'P550',
                                                'P550') ) ;

u_rv_d34_attr_liens_recency_w := __common__( map(
    rv_d34_attr_liens_recency = NULL  => 0.00000,
    rv_d34_attr_liens_recency <= 0.5  => -0.13409,
    rv_d34_attr_liens_recency <= 79.5 => 1.01299,
                                         0.52108) ) ;

u_aa_dist_14 := __common__( (0.00000 - u_rv_d34_attr_liens_recency_w) * 0.34744 ) ;

u_aa_code_14 := __common__( map(
    u_rv_d34_attr_liens_recency_w = -0.13409 => '',
    rv_d34_attr_liens_recency = NULL         => 'P535',
    rv_d34_attr_liens_recency <= 0.5         => 'P526',
    rv_d34_attr_liens_recency <= 79.5        => 'P526',
                                                'P526') ) ;

u_rv_a50_pb_average_dollars_w := __common__( map(
    rv_a50_pb_average_dollars = NULL   => 0.00000,
    rv_a50_pb_average_dollars = -1     => 0.19924,
    rv_a50_pb_average_dollars <= 58.5  => 0.02439,
    rv_a50_pb_average_dollars <= 210.5 => -0.20961,
                                          -0.27429) ) ;

u_aa_dist_15 := __common__( if(rv_a50_pb_average_dollars=null, ((0.00000 - u_rv_a50_pb_average_dollars_w) * 0.20553), 999999) ) ;  // reason code edit for iBehavior removal

u_aa_code_15 := __common__( map(
    u_rv_a50_pb_average_dollars_w = -0.27429 => '',
    rv_a50_pb_average_dollars = NULL         => 'P535',
    rv_a50_pb_average_dollars = -1           => '',  // reason code edit for iBehavior removal
    rv_a50_pb_average_dollars <= 58.5        => '',  // reason code edit for iBehavior removal
    rv_a50_pb_average_dollars <= 210.5       => '',  // reason code edit for iBehavior removal
                                                '') ) ; // reason code edit for iBehavior removal

u_iv_c13_avg_lres_w := __common__( map(
    iv_c13_avg_lres = NULL   => 0.00000,
    iv_c13_avg_lres <= 19.5  => 0.74202,
    iv_c13_avg_lres <= 36.5  => 0.38435,
    iv_c13_avg_lres <= 63.5  => 0.19882,
    iv_c13_avg_lres <= 107.5 => 0.12361,
    iv_c13_avg_lres <= 155.5 => -0.10322,
                                -0.51703) ) ;

u_aa_dist_16 := __common__( (0.00000 - u_iv_c13_avg_lres_w) * 0.22932 ) ;

u_aa_code_16 := __common__( map(
    u_iv_c13_avg_lres_w = -0.51703 => '',
    iv_c13_avg_lres = NULL         => 'P535',
    iv_c13_avg_lres <= 19.5        => 'P516',
    iv_c13_avg_lres <= 36.5        => 'P516',
    iv_c13_avg_lres <= 63.5        => 'P516',
    iv_c13_avg_lres <= 107.5       => 'P516',
    iv_c13_avg_lres <= 155.5       => 'P516',
                                      'P516') ) ;

u_rv_i60_inq_other_recency_w := __common__( map(
    rv_i60_inq_other_recency = NULL => 0.00000,
    rv_i60_inq_other_recency <= 18  => -0.03836,
                                       0.29330) ) ;

u_aa_dist_17 := __common__( (0.00000 - u_rv_i60_inq_other_recency_w) * 0.43471 ) ;

u_aa_code_17 := __common__( map(
    u_rv_i60_inq_other_recency_w = -0.03836 => '',
    rv_i60_inq_other_recency = NULL         => 'P535',
    rv_i60_inq_other_recency <= 18          => 'P539',
                                               'P539') ) ;

u_rv_mos_since_br_first_seen_w := __common__( map(
    rv_mos_since_br_first_seen = NULL => 0.00000,
    rv_mos_since_br_first_seen = -1   => 0.08255,
    rv_mos_since_br_first_seen <= 76  => -0.04609,
                                         -0.18988) ) ;

u_aa_dist_18 := __common__( (0.00000 - u_rv_mos_since_br_first_seen_w) * 0.37300 ) ;

u_aa_code_18 := __common__( map(
    u_rv_mos_since_br_first_seen_w = -0.18988 => '',
    rv_mos_since_br_first_seen = NULL         => 'P535',
    rv_mos_since_br_first_seen = -1           => 'P534',
    rv_mos_since_br_first_seen <= 76          => 'P534',
                                                 'P534') ) ;

u_iv_d34_liens_unrel_cj_ct_w := __common__( map(
    iv_d34_liens_unrel_cj_ct = NULL => 0.00000,
    iv_d34_liens_unrel_cj_ct <= 0.5 => -0.05948,
    iv_d34_liens_unrel_cj_ct <= 1.5 => 0.69625,
                                       1.12400) ) ;

u_aa_dist_19 := __common__( (0.00000 - u_iv_d34_liens_unrel_cj_ct_w) * 0.19745 ) ;

u_aa_code_19 := __common__( map(
    u_iv_d34_liens_unrel_cj_ct_w = -0.05948 => '',
    iv_d34_liens_unrel_cj_ct = NULL         => 'P535',
    iv_d34_liens_unrel_cj_ct <= 0.5         => 'P526',
    iv_d34_liens_unrel_cj_ct <= 1.5         => 'P526',
                                               'P526') ) ;

u_iv_d34_liens_unrel_sc_ct_w := __common__( map(
    iv_d34_liens_unrel_sc_ct = NULL => 0.00000,
    iv_d34_liens_unrel_sc_ct <= 0.5 => -0.03200,
                                       0.94892) ) ;

u_aa_dist_20 := __common__( (0.00000 - u_iv_d34_liens_unrel_sc_ct_w) * 0.28703 ) ;

u_aa_code_20 := __common__( map(
    u_iv_d34_liens_unrel_sc_ct_w = -0.03200 => '',
    iv_d34_liens_unrel_sc_ct = NULL         => 'P535',
    iv_d34_liens_unrel_sc_ct <= 0.5         => 'P526',
                                               'P526') ) ;

u_nf_inq_auto_count_w := __common__( map(
    nf_inq_auto_count = NULL => 0.00000,
    nf_inq_auto_count <= 0.5 => -0.06666,
    nf_inq_auto_count <= 3.5 => 0.47876,
                                1.18465) ) ;

u_aa_dist_21 := __common__( (0.00000 - u_nf_inq_auto_count_w) * 0.53115 ) ;

u_aa_code_21 := __common__( map(
    u_nf_inq_auto_count_w = -0.06666 => '',
    nf_inq_auto_count = NULL         => 'P535',
    nf_inq_auto_count <= 0.5         => 'P539',
    nf_inq_auto_count <= 3.5         => 'P539',
                                        'P539') ) ;

u_nf_inq_collection_count_w := __common__( map(
    nf_inq_collection_count = NULL => 0.00000,
    nf_inq_collection_count <= 0.5 => -0.17153,
    nf_inq_collection_count <= 1.5 => -0.07874,
    nf_inq_collection_count <= 2.5 => 0.11581,
    nf_inq_collection_count <= 7.5 => 0.33037,
                                      0.86413) ) ;

u_aa_dist_22 := __common__( (0.00000 - u_nf_inq_collection_count_w) * 0.51163 ) ;

u_aa_code_22 := __common__( map(
    u_nf_inq_collection_count_w = -0.17153 => '',
    nf_inq_collection_count = NULL         => 'P535',
    nf_inq_collection_count <= 0.5         => 'P539',
    nf_inq_collection_count <= 1.5         => 'P539',
    nf_inq_collection_count <= 2.5         => 'P539',
    nf_inq_collection_count <= 7.5         => 'P539',
                                              'P539') ) ;

u_nf_inq_communications_cnt24_w := __common__( map(
    nf_inq_communications_count24 = NULL => 0.00000,
    nf_inq_communications_count24 <= 0.5 => -0.03134,
                                            0.76570) ) ;

u_aa_dist_23 := __common__( (0.00000 - u_nf_inq_communications_cnt24_w) * 0.40601 ) ;

u_aa_code_23 := __common__( map(
    u_nf_inq_communications_cnt24_w = -0.03134 => '',
    nf_inq_communications_count24 = NULL       => 'P535',
    nf_inq_communications_count24 <= 0.5       => 'P539',
                                                  'P539') ) ;

u_nf_inq_highriskcredit_count_w := __common__( map(
    nf_inq_highriskcredit_count = NULL => 0.00000,
    nf_inq_highriskcredit_count <= 0.5 => -0.02397,
                                          1.03713) ) ;

u_aa_dist_24 := __common__( (0.00000 - u_nf_inq_highriskcredit_count_w) * 0.34206 ) ;

u_aa_code_24 := __common__( map(
    u_nf_inq_highriskcredit_count_w = -0.02397 => '',
    nf_inq_highriskcredit_count = NULL         => 'P535',
    nf_inq_highriskcredit_count <= 0.5         => 'P539',
                                                  'P539') ) ;

u_nf_mos_inq_banko_cm_fseen_w := __common__( map(
    nf_mos_inq_banko_cm_fseen = NULL => 0.00000,
    nf_mos_inq_banko_cm_fseen = -1   => -0.10757,
                                        0.65863) ) ;

u_aa_dist_25 := __common__( (0.00000 - u_nf_mos_inq_banko_cm_fseen_w) * 0.44534 ) ;

u_aa_code_25 := __common__( map(
    u_nf_mos_inq_banko_cm_fseen_w = -0.10757 => '',
    nf_mos_inq_banko_cm_fseen = NULL         => 'P535',
    nf_mos_inq_banko_cm_fseen = -1           => 'P539',
                                                'P539') ) ;

u_nf_mos_inq_banko_om_lseen_w := __common__( map(
    nf_mos_inq_banko_om_lseen = NULL => 0.00000,
    nf_mos_inq_banko_om_lseen = -1   => -0.04126,
    nf_mos_inq_banko_om_lseen <= 5.5 => 0.99456,
                                        0.19124) ) ;

u_aa_dist_26 := __common__( (0.00000 - u_nf_mos_inq_banko_om_lseen_w) * 0.31057 ) ;

u_aa_code_26 := __common__( map(
    u_nf_mos_inq_banko_om_lseen_w = -0.04126 => '',
    nf_mos_inq_banko_om_lseen = NULL         => 'P535',
    nf_mos_inq_banko_om_lseen = -1           => 'P539',
    nf_mos_inq_banko_om_lseen <= 5.5         => 'P539',
                                                'P539') ) ;

u_nf_accident_count_w := __common__( map(
    nf_accident_count = NULL => 0.00000,
    nf_accident_count <= 0.5 => -0.08799,
    nf_accident_count <= 1.5 => 0.20313,
    nf_accident_count <= 2.5 => 0.40960,
                                0.72966) ) ;

u_aa_dist_27 := __common__( (0.00000 - u_nf_accident_count_w) * 0.59079 ) ;

u_aa_code_27 := __common__( map(
    u_nf_accident_count_w = -0.08799 => '',
    nf_accident_count = NULL         => 'P535',
    nf_accident_count <= 0.5         => 'P531',
    nf_accident_count <= 1.5         => 'P531',
    nf_accident_count <= 2.5         => 'P531',
                                        'P531') ) ;

u_nf_fp_vardobcountnew_w := __common__( map(
    nf_fp_vardobcountnew = NULL => 0.00000,
    nf_fp_vardobcountnew <= 0.5 => -0.08075,
                                   0.33555) ) ;

u_aa_dist_28 := __common__( (0.00000 - u_nf_fp_vardobcountnew_w) * 0.28112 ) ;

u_aa_code_28 := __common__( map(
    u_nf_fp_vardobcountnew_w = -0.08075 => '',
    nf_fp_vardobcountnew = NULL         => 'P535',
    nf_fp_vardobcountnew <= 0.5         => 'P562',
                                           'P562') ) ;

u_nf_fp_srchunvrfdssncount_w := __common__( map(
    nf_fp_srchunvrfdssncount = NULL => 0.00000,
    nf_fp_srchunvrfdssncount <= 0.5 => -0.02241,
                                       0.51171) ) ;

u_aa_dist_29 := __common__( (0.00000 - u_nf_fp_srchunvrfdssncount_w) * 0.47837 ) ;

u_aa_code_29 := __common__( map(
    u_nf_fp_srchunvrfdssncount_w = -0.02241 => '',
    nf_fp_srchunvrfdssncount = NULL         => 'P535',
    nf_fp_srchunvrfdssncount <= 0.5         => 'P539',
                                               'P539') ) ;

u_nf_fp_srchunvrfdaddrcount_w := __common__( map(
    nf_fp_srchunvrfdaddrcount = NULL => 0.00000,
    nf_fp_srchunvrfdaddrcount <= 0.5 => -0.02488,
                                        0.78991) ) ;

u_aa_dist_30 := __common__( (0.00000 - u_nf_fp_srchunvrfdaddrcount_w) * 0.58133 ) ;

u_aa_code_30 := __common__( map(
    u_nf_fp_srchunvrfdaddrcount_w = -0.02488 => '',
    nf_fp_srchunvrfdaddrcount = NULL         => 'P535',
    nf_fp_srchunvrfdaddrcount <= 0.5         => 'P539',
                                                'P539') ) ;

u_nf_fp_curraddractivephnlist_w := __common__( map(
    nf_fp_curraddractivephonelist = '' => 0.00000,
    (integer)nf_fp_curraddractivephonelist = -1   => 0.23029,
    (integer)nf_fp_curraddractivephonelist <= 0.5 => 0.19566,
                                            -0.17661) ) ;

u_aa_dist_31 := __common__( (0.00000 - u_nf_fp_curraddractivephnlist_w) * 0.42890 ) ;

u_aa_code_31 := __common__( map(
    u_nf_fp_curraddractivephnlist_w = -0.17661 => '',
    nf_fp_curraddractivephonelist = ''       => 'P535',
    (integer)nf_fp_curraddractivephonelist = -1         => 'P538',
    (integer)nf_fp_curraddractivephonelist <= 0.5 => 'P549',
                                                  'P549') ) ;

u_bv_rep_only_source_profile_w := __common__( map(
    bv_rep_only_source_profile = NULL           => 0.00000,
    bv_rep_only_source_profile <= -3.1167311145 => -1.15727,
    bv_rep_only_source_profile <= -2.957044655  => -0.76274,
    bv_rep_only_source_profile <= -2.873788782  => -0.74271,
    bv_rep_only_source_profile <= -2.6368371665 => -0.51705,
    bv_rep_only_source_profile <= -2.1538732275 => -0.10964,
    bv_rep_only_source_profile <= -2.0965823065 => 0.16158,
    bv_rep_only_source_profile <= -1.886638341  => 0.34641,
    bv_rep_only_source_profile <= -1.612985294  => 0.52894,
    bv_rep_only_source_profile <= -1.422813123  => 0.68518,
                                                   0.89002) ) ;

u_aa_dist_32 := __common__( (0.00000 - u_bv_rep_only_source_profile_w) * 0.63013 ) ;

u_aa_code_32 := __common__( map(
    u_bv_rep_only_source_profile_w = -1.15727   => '',
    bv_rep_only_source_profile = NULL           => 'P535',
    bv_rep_only_source_profile <= -3.1167311145 => 'P515',
    bv_rep_only_source_profile <= -2.957044655  => 'P515',
    bv_rep_only_source_profile <= -2.873788782  => 'P515',
    bv_rep_only_source_profile <= -2.6368371665 => 'P515',
    bv_rep_only_source_profile <= -2.1538732275 => 'P515',
    bv_rep_only_source_profile <= -2.0965823065 => 'P515',
    bv_rep_only_source_profile <= -1.886638341  => 'P515',
    bv_rep_only_source_profile <= -1.612985294  => 'P515',
    bv_rep_only_source_profile <= -1.422813123  => 'P515',
                                                   'P515') ) ;

u_nf_m_bureau_adl_fs_notu_w := __common__( map(
    nf_m_bureau_adl_fs_notu = NULL   => 0.00000,
    nf_m_bureau_adl_fs_notu = -1     => 0.00000,
    nf_m_bureau_adl_fs_notu <= 47.5  => 1.01915,
    nf_m_bureau_adl_fs_notu <= 77.5  => 0.55475,
    nf_m_bureau_adl_fs_notu <= 84.5  => 0.29602,
    nf_m_bureau_adl_fs_notu <= 165.5 => 0.23475,
    nf_m_bureau_adl_fs_notu <= 343.5 => -0.05577,
                                        -0.39523) ) ;

u_aa_dist_33 := __common__( (0.00000 - u_nf_m_bureau_adl_fs_notu_w) * 0.30365 ) ;

u_aa_code_33 := __common__( map(
    u_nf_m_bureau_adl_fs_notu_w = -0.39523 => '',
    nf_m_bureau_adl_fs_notu = NULL         => 'P535',
    nf_m_bureau_adl_fs_notu = -1           => 'P515',
    nf_m_bureau_adl_fs_notu <= 47.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 77.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 84.5        => 'P523',
    nf_m_bureau_adl_fs_notu <= 165.5       => 'P523',
    nf_m_bureau_adl_fs_notu <= 343.5       => 'P523',
                                              'P523') ) ;

u_aa_code_34 := __common__( 'B067' ) ;

u_aa_dist_34 := __common__( -999 ) ;

u_rcvaluep523 := __common__( (integer)(u_aa_code_1 = 'P523') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P523') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P523') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P523') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P523') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P523') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P523') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P523') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P523') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P523') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P523') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P523') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P523') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P523') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P523') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P523') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P523') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P523') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P523') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P523') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P523') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P523') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P523') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P523') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P523') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P523') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P523') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P523') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P523') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P523') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P523') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P523') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P523') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P523') * u_aa_dist_34 ) ;

u_rcvaluep509 := __common__( (integer)(u_aa_code_1 = 'P509') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P509') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P509') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P509') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P509') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P509') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P509') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P509') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P509') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P509') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P509') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P509') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P509') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P509') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P509') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P509') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P509') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P509') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P509') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P509') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P509') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P509') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P509') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P509') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P509') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P509') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P509') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P509') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P509') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P509') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P509') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P509') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P509') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P509') * u_aa_dist_34 ) ;

u_rcvaluep532 := __common__( (integer)(u_aa_code_1 = 'P532') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P532') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P532') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P532') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P532') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P532') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P532') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P532') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P532') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P532') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P532') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P532') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P532') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P532') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P532') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P532') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P532') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P532') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P532') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P532') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P532') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P532') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P532') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P532') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P532') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P532') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P532') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P532') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P532') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P532') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P532') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P532') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P532') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P532') * u_aa_dist_34 ) ;

u_rcvaluep502 := __common__( (integer)(u_aa_code_1 = 'P502') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P502') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P502') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P502') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P502') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P502') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P502') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P502') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P502') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P502') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P502') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P502') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P502') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P502') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P502') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P502') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P502') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P502') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P502') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P502') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P502') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P502') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P502') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P502') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P502') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P502') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P502') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P502') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P502') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P502') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P502') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P502') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P502') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P502') * u_aa_dist_34 ) ;

u_rcvaluep534 := __common__( (integer)(u_aa_code_1 = 'P534') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P534') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P534') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P534') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P534') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P534') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P534') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P534') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P534') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P534') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P534') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P534') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P534') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P534') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P534') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P534') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P534') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P534') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P534') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P534') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P534') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P534') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P534') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P534') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P534') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P534') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P534') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P534') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P534') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P534') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P534') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P534') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P534') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P534') * u_aa_dist_34 ) ;

u_rcvaluep535 := __common__( (integer)(u_aa_code_1 = 'P535') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P535') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P535') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P535') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P535') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P535') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P535') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P535') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P535') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P535') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P535') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P535') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P535') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P535') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P535') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P535') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P535') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P535') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P535') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P535') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P535') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P535') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P535') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P535') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P535') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P535') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P535') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P535') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P535') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P535') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P535') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P535') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P535') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P535') * u_aa_dist_34 ) ;

u_rcvaluep531 := __common__( (integer)(u_aa_code_1 = 'P531') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P531') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P531') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P531') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P531') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P531') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P531') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P531') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P531') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P531') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P531') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P531') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P531') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P531') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P531') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P531') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P531') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P531') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P531') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P531') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P531') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P531') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P531') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P531') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P531') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P531') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P531') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P531') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P531') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P531') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P531') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P531') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P531') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P531') * u_aa_dist_34 ) ;

u_rcvaluep524 := __common__( (integer)(u_aa_code_1 = 'P524') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P524') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P524') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P524') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P524') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P524') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P524') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P524') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P524') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P524') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P524') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P524') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P524') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P524') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P524') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P524') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P524') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P524') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P524') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P524') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P524') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P524') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P524') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P524') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P524') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P524') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P524') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P524') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P524') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P524') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P524') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P524') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P524') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P524') * u_aa_dist_34 ) ;

u_rcvaluep516 := __common__( (integer)(u_aa_code_1 = 'P516') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P516') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P516') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P516') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P516') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P516') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P516') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P516') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P516') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P516') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P516') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P516') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P516') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P516') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P516') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P516') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P516') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P516') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P516') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P516') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P516') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P516') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P516') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P516') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P516') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P516') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P516') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P516') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P516') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P516') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P516') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P516') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P516') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P516') * u_aa_dist_34 ) ;

u_rcvaluep539 := __common__( (integer)(u_aa_code_1 = 'P539') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P539') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P539') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P539') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P539') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P539') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P539') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P539') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P539') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P539') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P539') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P539') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P539') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P539') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P539') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P539') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P539') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P539') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P539') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P539') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P539') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P539') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P539') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P539') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P539') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P539') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P539') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P539') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P539') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P539') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P539') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P539') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P539') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P539') * u_aa_dist_34 ) ;

u_rcvaluep515 := __common__( (integer)(u_aa_code_1 = 'P515') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P515') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P515') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P515') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P515') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P515') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P515') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P515') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P515') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P515') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P515') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P515') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P515') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P515') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P515') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P515') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P515') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P515') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P515') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P515') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P515') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P515') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P515') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P515') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P515') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P515') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P515') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P515') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P515') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P515') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P515') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P515') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P515') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P515') * u_aa_dist_34 ) ;

u_rcvaluep512 := __common__( (integer)(u_aa_code_1 = 'P512') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P512') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P512') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P512') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P512') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P512') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P512') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P512') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P512') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P512') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P512') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P512') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P512') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P512') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P512') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P512') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P512') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P512') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P512') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P512') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P512') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P512') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P512') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P512') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P512') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P512') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P512') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P512') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P512') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P512') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P512') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P512') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P512') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P512') * u_aa_dist_34 ) ;

u_rcvaluep511 := __common__( (integer)(u_aa_code_1 = 'P511') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P511') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P511') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P511') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P511') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P511') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P511') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P511') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P511') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P511') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P511') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P511') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P511') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P511') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P511') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P511') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P511') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P511') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P511') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P511') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P511') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P511') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P511') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P511') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P511') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P511') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P511') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P511') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P511') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P511') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P511') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P511') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P511') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P511') * u_aa_dist_34 ) ;

u_rcvaluep538 := __common__( (integer)(u_aa_code_1 = 'P538') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P538') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P538') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P538') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P538') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P538') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P538') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P538') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P538') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P538') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P538') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P538') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P538') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P538') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P538') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P538') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P538') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P538') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P538') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P538') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P538') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P538') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P538') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P538') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P538') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P538') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P538') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P538') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P538') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P538') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P538') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P538') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P538') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P538') * u_aa_dist_34 ) ;

u_rcvaluep550 := __common__( (integer)(u_aa_code_1 = 'P550') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P550') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P550') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P550') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P550') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P550') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P550') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P550') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P550') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P550') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P550') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P550') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P550') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P550') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P550') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P550') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P550') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P550') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P550') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P550') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P550') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P550') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P550') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P550') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P550') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P550') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P550') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P550') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P550') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P550') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P550') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P550') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P550') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P550') * u_aa_dist_34 ) ;

u_rcvalueb067 := __common__( (integer)(u_aa_code_1 = 'B067') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'B067') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'B067') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'B067') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'B067') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'B067') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'B067') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'B067') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'B067') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'B067') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'B067') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'B067') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'B067') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'B067') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'B067') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'B067') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'B067') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'B067') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'B067') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'B067') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'B067') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'B067') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'B067') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'B067') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'B067') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'B067') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'B067') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'B067') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'B067') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'B067') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'B067') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'B067') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'B067') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'B067') * u_aa_dist_34 ) ;

u_rcvaluep549 := __common__( (integer)(u_aa_code_1 = 'P549') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P549') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P549') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P549') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P549') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P549') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P549') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P549') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P549') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P549') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P549') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P549') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P549') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P549') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P549') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P549') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P549') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P549') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P549') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P549') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P549') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P549') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P549') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P549') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P549') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P549') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P549') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P549') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P549') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P549') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P549') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P549') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P549') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P549') * u_aa_dist_34 ) ;

u_rcvaluep562 := __common__( (integer)(u_aa_code_1 = 'P562') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P562') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P562') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P562') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P562') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P562') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P562') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P562') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P562') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P562') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P562') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P562') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P562') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P562') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P562') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P562') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P562') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P562') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P562') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P562') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P562') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P562') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P562') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P562') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P562') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P562') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P562') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P562') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P562') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P562') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P562') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P562') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P562') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P562') * u_aa_dist_34 ) ;

u_rcvaluep526 := __common__( (integer)(u_aa_code_1 = 'P526') * u_aa_dist_1 +
    (integer)(u_aa_code_2 = 'P526') * u_aa_dist_2 +
    (integer)(u_aa_code_3 = 'P526') * u_aa_dist_3 +
    (integer)(u_aa_code_4 = 'P526') * u_aa_dist_4 +
    (integer)(u_aa_code_5 = 'P526') * u_aa_dist_5 +
    (integer)(u_aa_code_6 = 'P526') * u_aa_dist_6 +
    (integer)(u_aa_code_7 = 'P526') * u_aa_dist_7 +
    (integer)(u_aa_code_8 = 'P526') * u_aa_dist_8 +
    (integer)(u_aa_code_9 = 'P526') * u_aa_dist_9 +
    (integer)(u_aa_code_10 = 'P526') * u_aa_dist_10 +
    (integer)(u_aa_code_11 = 'P526') * u_aa_dist_11 +
    (integer)(u_aa_code_12 = 'P526') * u_aa_dist_12 +
    (integer)(u_aa_code_13 = 'P526') * u_aa_dist_13 +
    (integer)(u_aa_code_14 = 'P526') * u_aa_dist_14 +
    (integer)(u_aa_code_15 = 'P526') * u_aa_dist_15 +
    (integer)(u_aa_code_16 = 'P526') * u_aa_dist_16 +
    (integer)(u_aa_code_17 = 'P526') * u_aa_dist_17 +
    (integer)(u_aa_code_18 = 'P526') * u_aa_dist_18 +
    (integer)(u_aa_code_19 = 'P526') * u_aa_dist_19 +
    (integer)(u_aa_code_20 = 'P526') * u_aa_dist_20 +
    (integer)(u_aa_code_21 = 'P526') * u_aa_dist_21 +
    (integer)(u_aa_code_22 = 'P526') * u_aa_dist_22 +
    (integer)(u_aa_code_23 = 'P526') * u_aa_dist_23 +
    (integer)(u_aa_code_24 = 'P526') * u_aa_dist_24 +
    (integer)(u_aa_code_25 = 'P526') * u_aa_dist_25 +
    (integer)(u_aa_code_26 = 'P526') * u_aa_dist_26 +
    (integer)(u_aa_code_27 = 'P526') * u_aa_dist_27 +
    (integer)(u_aa_code_28 = 'P526') * u_aa_dist_28 +
    (integer)(u_aa_code_29 = 'P526') * u_aa_dist_29 +
    (integer)(u_aa_code_30 = 'P526') * u_aa_dist_30 +
    (integer)(u_aa_code_31 = 'P526') * u_aa_dist_31 +
    (integer)(u_aa_code_32 = 'P526') * u_aa_dist_32 +
    (integer)(u_aa_code_33 = 'P526') * u_aa_dist_33 +
    (integer)(u_aa_code_34 = 'P526') * u_aa_dist_34 ) ;

u_final_score := __common__( -2.11317180468609 +
    u_rv_d30_derog_count_w * 0.424523351913032 +
    u_rv_d31_attr_bk_recency_w * 0.232123507647494 +
    u_rv_d31_bk_disposed_hist_cnt_w * 0.26426830439185 +
    u_rv_c21_stl_inq_count_w * 0.752173260284441 +
    u_rv_d33_eviction_recency_w * 0.204970483001378 +
    u_rv_d34_unrel_lien60_count_w * 0.162601244239547 +
    u_rv_c20_m_bureau_adl_fs_w * 0.178606468684702 +
    u_rv_a46_curr_avm_autoval_w * 0.693578450752235 +
    u_rv_a49_curr_avm_chg_1yr_pct_w * 0.378992223692093 +
    u_rv_a41_prop_owner_w * 0.386712778634776 +
    u_rv_e55_college_ind_w * 0.828700378756514 +
    u_rv_i61_inq_collection_cnt12_w * 0.239505905200266 +
    u_rv_l79_adls_per_addr_curr_w * 0.494111151155984 +
    u_rv_d34_attr_liens_recency_w * 0.347441864057038 +
    u_rv_a50_pb_average_dollars_w * 0.205533122408408 +
    u_iv_c13_avg_lres_w * 0.229316682828727 +
    u_rv_i60_inq_other_recency_w * 0.434708197110387 +
    u_rv_mos_since_br_first_seen_w * 0.372996846074626 +
    u_iv_d34_liens_unrel_cj_ct_w * 0.19744762733972 +
    u_iv_d34_liens_unrel_sc_ct_w * 0.287025555662378 +
    u_nf_inq_auto_count_w * 0.531151516195531 +
    u_nf_inq_collection_count_w * 0.511630039341262 +
    u_nf_inq_communications_cnt24_w * 0.406008007082952 +
    u_nf_inq_highriskcredit_count_w * 0.342064428361368 +
    u_nf_mos_inq_banko_cm_fseen_w * 0.445339826775509 +
    u_nf_mos_inq_banko_om_lseen_w * 0.310569729519996 +
    u_nf_accident_count_w * 0.590791592425623 +
    u_nf_fp_vardobcountnew_w * 0.281115017369795 +
    u_nf_fp_srchunvrfdssncount_w * 0.478369486428232 +
    u_nf_fp_srchunvrfdaddrcount_w * 0.58132817059393 +
    u_nf_fp_curraddractivephnlist_w * 0.428904292067726 +
    u_bv_rep_only_source_profile_w * 0.630130617054279 +
    u_nf_m_bureau_adl_fs_notu_w * 0.303653852507161 ) ;

base := __common__( 700 ) ;

pts := __common__( -40 ) ;

lgt := __common__( ln(0.10) ) ;

blend_mod_final_lgt := __common__( map(
    iv_rv5_unscorable = 1             => -1,
    seg_business_score = 'LN & SBFE'  => s_final_score,
    seg_business_score = 'LN ONLY'    => l_final_score,
    seg_business_score = 'UNSCORABLE' => u_final_score,
                                         -1) ) ;

_sbbm1601_0_0 := __common__( round(base + pts * (blend_mod_final_lgt - lgt) / ln(2)) ) ;

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value} ;

Null_ds := dataset([{'00', NULL}, {'00', NULL}, {'00', NULL}, {'00', NULL}], ds_layout)  ;

 
//*************************************************************************************//

l_code_set :=  [l_aa_code_1,
							 l_aa_code_2,
							 l_aa_code_3,
							 l_aa_code_4,
							 l_aa_code_5,
							 l_aa_code_6,
							 l_aa_code_7,
							 l_aa_code_8,
							 l_aa_code_9,
							 l_aa_code_10,
							 l_aa_code_11,
							 l_aa_code_12,
							 l_aa_code_13,
							 l_aa_code_14,
							 l_aa_code_15,
							 l_aa_code_16,
							 l_aa_code_17,
							 l_aa_code_18,
							 l_aa_code_19,
							 l_aa_code_20,
							 l_aa_code_21,
							 l_aa_code_22,
							 l_aa_code_23,
							 l_aa_code_24,
							 l_aa_code_25,
							 l_aa_code_26,
							 l_aa_code_27,
							 l_aa_code_28,
							 l_aa_code_29]  ;



rc_dataset_l := __common__( DATASET([
    {'B015', l_rcvalueB015},
    {'B017', l_rcvalueB017},
    {'B026', l_rcvalueB026},
    {'B031', l_rcvalueB031},
    {'B034', l_rcvalueB034},
    {'B037', l_rcvalueB037},
    {'B038', l_rcvalueB038},
    {'B040', l_rcvalueB040},
    {'B052', l_rcvalueB052},
    {'B053', l_rcvalueB053},
    {'B055', l_rcvalueB055},
    {'B057', l_rcvalueB057},
    {'B063', l_rcvalueB063},
    {'BF108', l_rcvalueBF108},
    {'P506', l_rcvalueP506},
    {'P509', l_rcvalueP509},
    {'P515', l_rcvalueP515},
    {'P523', l_rcvalueP523},
    {'P526', l_rcvalueP526},
    {'P531', l_rcvalueP531},
    {'P532', l_rcvalueP532},
    {'P534', l_rcvalueP534},
    {'P535', l_rcvalueP535},
    {'P539', l_rcvalueP539},
    {'P562', l_rcvalueP562}
    ], ds_layout)(rc in l_code_set) ) ;

//*************************************************************************************//
// If none of the first four RCs are a business reason code (rc[1] = 'B'), find the first 
// business reason code, and make that the fourh reason code. Then shift everything down
// one position to make room for that reason code.  
//*************************************************************************************//
rc_dataset_l_sorted := __common__( sort(rc_dataset_l, value, rc) ) ;

l_rc1  := __common__( rc_dataset_l_sorted[1].rc ) ;
l_rc2  := __common__( rc_dataset_l_sorted[2].rc ) ;
l_rc3  := __common__( rc_dataset_l_sorted[3].rc ) ;

do_new_l_sort := __common__( l_rc1[1] <> 'B' and l_rc2[1] <> 'B' and l_rc3[1] <> 'B' ) ;
rc_business_l := __common__( sort((rc_dataset_l_sorted(rc[1] = 'B')), value)[1] ) ;

// Use null ds to pad the new sort in order to keep the indexing between the original and new sorts the same.
rc_dataset_l_sorted_new := __common__( if(do_new_l_sort, SORT(Null_ds +  rc_dataset_l_sorted[4..], value, rc)(rc <> rc_business_l.rc), rc_dataset_l_sorted) ) ;

l_rc4  := __common__( IF(do_new_l_sort, rc_business_l.rc, rc_dataset_l_sorted_new[4].rc) ) ;
l_rc5  := __common__( rc_dataset_l_sorted_new[5].rc ) ;
l_rc6  := __common__( rc_dataset_l_sorted_new[6].rc ) ;
l_rc7  := __common__( rc_dataset_l_sorted_new[7].rc ) ;
l_rc8  := __common__( rc_dataset_l_sorted_new[8].rc ) ;
l_rc9  := __common__( rc_dataset_l_sorted_new[9].rc ) ;
l_rc10  := __common__( rc_dataset_l_sorted_new[10].rc ) ;
l_rc11  := __common__( rc_dataset_l_sorted_new[11].rc ) ;
l_rc12  := __common__( rc_dataset_l_sorted_new[12].rc ) ;
l_rc13  := __common__( rc_dataset_l_sorted_new[13].rc ) ;
l_rc14  := __common__( rc_dataset_l_sorted_new[14].rc ) ;
l_rc15  := __common__( rc_dataset_l_sorted_new[15].rc ) ;
l_rc16  := __common__( rc_dataset_l_sorted_new[16].rc ) ;
l_rc17  := __common__( rc_dataset_l_sorted_new[17].rc ) ;
l_rc18  := __common__( rc_dataset_l_sorted_new[18].rc ) ;
l_rc19  := __common__( rc_dataset_l_sorted_new[19].rc ) ;
l_rc20  := __common__( rc_dataset_l_sorted_new[20].rc ) ;
l_rc21  := __common__( rc_dataset_l_sorted_new[21].rc ) ;
l_rc22  := __common__( rc_dataset_l_sorted_new[22].rc ) ;
l_rc23  := __common__( rc_dataset_l_sorted_new[23].rc ) ;
l_rc24  := __common__( rc_dataset_l_sorted_new[24].rc ) ;
l_rc25  := __common__( rc_dataset_l_sorted_new[25].rc ) ;
l_rc26  := __common__( rc_dataset_l_sorted_new[26].rc ) ;
l_rc27  := __common__( rc_dataset_l_sorted_new[27].rc ) ;
l_rc28  := __common__( rc_dataset_l_sorted_new[28].rc ) ;
l_rc29  := __common__( rc_dataset_l_sorted_new[29].rc ) ;
l_rc30  := __common__( rc_dataset_l_sorted_new[30].rc ) ;
l_rc31  := __common__( rc_dataset_l_sorted_new[31].rc ) ;
l_rc32  := __common__( rc_dataset_l_sorted_new[32].rc ) ;
l_rc33  := __common__( rc_dataset_l_sorted_new[33].rc ) ;
l_rc34  := __common__( rc_dataset_l_sorted_new[34].rc ) ;
l_rc35  := __common__( rc_dataset_l_sorted_new[35].rc ) ;
l_rc36  := __common__( rc_dataset_l_sorted_new[36].rc ) ;
l_rc37  := __common__( rc_dataset_l_sorted_new[37].rc ) ;
l_rc38  := __common__( rc_dataset_l_sorted_new[38].rc ) ;
l_rc39  := __common__( rc_dataset_l_sorted_new[39].rc ) ;
l_rc40  := __common__( rc_dataset_l_sorted_new[40].rc ) ;
l_rc41  := __common__( rc_dataset_l_sorted_new[41].rc ) ;
l_rc42  := __common__( rc_dataset_l_sorted_new[42].rc ) ;
l_rc43  := __common__( rc_dataset_l_sorted_new[43].rc ) ;
l_rc44  := __common__( rc_dataset_l_sorted_new[44].rc ) ;
l_rc45  := __common__( rc_dataset_l_sorted_new[45].rc ) ;
l_rc46  := __common__( rc_dataset_l_sorted_new[46].rc ) ;
l_rc47  := __common__( rc_dataset_l_sorted_new[47].rc ) ;
l_rc48  := __common__( rc_dataset_l_sorted_new[48].rc ) ;
l_rc49  := __common__( rc_dataset_l_sorted_new[49].rc ) ;
l_rc50  := __common__( rc_dataset_l_sorted_new[50].rc ) ;
 
//*************************************************************************************//
s_code_set := __common__( [s_aa_code_1,
							 s_aa_code_2,
							 s_aa_code_3,
							 s_aa_code_4,
							 s_aa_code_5,
							 s_aa_code_6,
							 s_aa_code_7,
							 s_aa_code_8,
							 s_aa_code_9,
							 s_aa_code_10,
							 s_aa_code_11,
							 s_aa_code_12,
							 s_aa_code_13,
							 s_aa_code_14,
							 s_aa_code_15,
							 s_aa_code_16,
							 s_aa_code_17,
							 s_aa_code_18,
							 s_aa_code_19,
							 s_aa_code_20,
							 s_aa_code_21,
							 s_aa_code_22,
							 s_aa_code_23,
							 s_aa_code_24,
							 s_aa_code_25,
							 s_aa_code_26,
							 s_aa_code_27,
							 s_aa_code_28,
							 s_aa_code_29,
							 s_aa_code_30,
							 s_aa_code_31,
							 s_aa_code_32,
							 s_aa_code_33,
							 s_aa_code_34,
							 s_aa_code_35,
							 s_aa_code_36,
							 s_aa_code_37,
							 s_aa_code_38,
							 s_aa_code_39,
							 s_aa_code_40,
							 s_aa_code_41,
							 s_aa_code_42] ) ;
							 
rc_dataset_s := __common__( DATASET([
    {'B017', s_rcvalueB017},
    {'B026', s_rcvalueB026},
    {'B031', s_rcvalueB031},
    {'B034', s_rcvalueB034},
    {'B037', s_rcvalueB037},
    {'B052', s_rcvalueB052},
    {'B053', s_rcvalueB053},
    {'B055', s_rcvalueB055},
    {'B059', s_rcvalueB059},
    {'B063', s_rcvalueB063},
    {'B066', s_rcvalueB066},
    {'BF105', s_rcvalueBF105},
    {'BF106', s_rcvalueBF106},
    {'BF110', s_rcvalueBF110},
    {'BF113', s_rcvalueBF113},
    {'BF117', s_rcvalueBF117},
    {'BF120', s_rcvalueBF120},
    {'BF125', s_rcvalueBF125},
    {'BF126', s_rcvalueBF126},
    {'BF127', s_rcvalueBF127},
    {'BF128', s_rcvalueBF128},
    {'BF129', s_rcvalueBF129},
    {'BF133', s_rcvalueBF133},
    {'BF134', s_rcvalueBF134},
    {'BF135', s_rcvalueBF135},
    {'BF136', s_rcvalueBF136},
    {'BF141', s_rcvalueBF141},
    {'BF142', s_rcvalueBF142},
    {'BF143', s_rcvalueBF143},
    {'P502', s_rcvalueP502},
    {'P509', s_rcvalueP509},
    {'P511', s_rcvalueP511},
    {'P515', s_rcvalueP515},
    {'P516', s_rcvalueP516},
    {'P521', s_rcvalueP521},
    {'P526', s_rcvalueP526},
    {'P531', s_rcvalueP531},
    {'P532', s_rcvalueP532},
    {'P534', s_rcvalueP534},
    {'P535', s_rcvalueP535},
    {'P539', s_rcvalueP539}
    ], ds_layout)(rc in s_code_set) ) ;

//*************************************************************************************//
// If none of the first four RCs are a business reason code (rc[1] = 'B'), find the first 
// business reason code, and make that the fourh reason code. Then shift everything down
// one position to make room for that reason code.  
//*************************************************************************************//
rc_dataset_s_sorted := __common__( sort(rc_dataset_s, value, rc) ) ;

s_rc1  := __common__( rc_dataset_s_sorted[1].rc ) ;
s_rc2  := __common__( rc_dataset_s_sorted[2].rc ) ;
s_rc3  := __common__( rc_dataset_s_sorted[3].rc ) ;

do_new_s_sort := __common__( s_rc1[1] <> 'B' and s_rc2[1] <> 'B' and s_rc3[1] <> 'B' ) ;
rc_business_s := __common__( sort((rc_dataset_s_sorted(rc[1] = 'B')), value)[1] ) ;

// Use null ds to pad the new sort in order to keep the indexing between the original and new sorts the same.
rc_dataset_s_sorted_new := __common__( if(do_new_s_sort, SORT(Null_ds +  rc_dataset_s_sorted[4..], value, rc)(rc <> rc_business_s.rc), rc_dataset_s_sorted) ) ;

s_rc4  := __common__( IF(do_new_s_sort, rc_business_s.rc, rc_dataset_s_sorted_new[4].rc) ) ;
s_rc5  := __common__( rc_dataset_s_sorted_new[5].rc ) ;
s_rc6  := __common__( rc_dataset_s_sorted_new[6].rc ) ;
s_rc7  := __common__( rc_dataset_s_sorted_new[7].rc ) ;
s_rc8  := __common__( rc_dataset_s_sorted_new[8].rc ) ;
s_rc9  := __common__( rc_dataset_s_sorted_new[9].rc ) ;
s_rc10  := __common__( rc_dataset_s_sorted_new[10].rc ) ;
s_rc11  := __common__( rc_dataset_s_sorted_new[11].rc ) ;
s_rc12  := __common__( rc_dataset_s_sorted_new[12].rc ) ;
s_rc13  := __common__( rc_dataset_s_sorted_new[13].rc ) ;
s_rc14  := __common__( rc_dataset_s_sorted_new[14].rc ) ;
s_rc15  := __common__( rc_dataset_s_sorted_new[15].rc ) ;
s_rc16  := __common__( rc_dataset_s_sorted_new[16].rc ) ;
s_rc17  := __common__( rc_dataset_s_sorted_new[17].rc ) ;
s_rc18  := __common__( rc_dataset_s_sorted_new[18].rc ) ;
s_rc19  := __common__( rc_dataset_s_sorted_new[19].rc ) ;
s_rc20  := __common__( rc_dataset_s_sorted_new[20].rc ) ;
s_rc21  := __common__( rc_dataset_s_sorted_new[21].rc ) ;
s_rc22  := __common__( rc_dataset_s_sorted_new[22].rc ) ;
s_rc23  := __common__( rc_dataset_s_sorted_new[23].rc ) ;
s_rc24  := __common__( rc_dataset_s_sorted_new[24].rc ) ;
s_rc25  := __common__( rc_dataset_s_sorted_new[25].rc ) ;
s_rc26  := __common__( rc_dataset_s_sorted_new[26].rc ) ;
s_rc27  := __common__( rc_dataset_s_sorted_new[27].rc ) ;
s_rc28  := __common__( rc_dataset_s_sorted_new[28].rc ) ;
s_rc29  := __common__( rc_dataset_s_sorted_new[29].rc ) ;
s_rc30  := __common__( rc_dataset_s_sorted_new[30].rc ) ;
s_rc31  := __common__( rc_dataset_s_sorted_new[31].rc ) ;
s_rc32  := __common__( rc_dataset_s_sorted_new[32].rc ) ;
s_rc33  := __common__( rc_dataset_s_sorted_new[33].rc ) ;
s_rc34  := __common__( rc_dataset_s_sorted_new[34].rc ) ;
s_rc35  := __common__( rc_dataset_s_sorted_new[35].rc ) ;
s_rc36  := __common__( rc_dataset_s_sorted_new[36].rc ) ;
s_rc37  := __common__( rc_dataset_s_sorted_new[37].rc ) ;
s_rc38  := __common__( rc_dataset_s_sorted_new[38].rc ) ;
s_rc39  := __common__( rc_dataset_s_sorted_new[39].rc ) ;
s_rc40  := __common__( rc_dataset_s_sorted_new[40].rc ) ;
s_rc41  := __common__( rc_dataset_s_sorted_new[41].rc ) ;
s_rc42  := __common__( rc_dataset_s_sorted_new[42].rc ) ;
s_rc43  := __common__( rc_dataset_s_sorted_new[43].rc ) ;
s_rc44  := __common__( rc_dataset_s_sorted_new[44].rc ) ;
s_rc45  := __common__( rc_dataset_s_sorted_new[45].rc ) ;
s_rc46  := __common__( rc_dataset_s_sorted_new[46].rc ) ;
s_rc47  := __common__( rc_dataset_s_sorted_new[47].rc ) ;
s_rc48  := __common__( rc_dataset_s_sorted_new[48].rc ) ;
s_rc49  := __common__( rc_dataset_s_sorted_new[49].rc ) ;
s_rc50  := __common__( rc_dataset_s_sorted_new[50].rc ) ;
 
//*************************************************************************************//
u_code_set := __common__( [u_aa_code_1,
							 u_aa_code_2,
							 u_aa_code_3,
							 u_aa_code_4,
							 u_aa_code_5,
							 u_aa_code_6,
							 u_aa_code_7,
							 u_aa_code_8,
							 u_aa_code_9,
							 u_aa_code_10,
							 u_aa_code_11,
							 u_aa_code_12,
							 u_aa_code_13,
							 u_aa_code_14,
							 u_aa_code_15,
							 u_aa_code_16,
							 u_aa_code_17,
							 u_aa_code_18,
							 u_aa_code_19,
							 u_aa_code_20,
							 u_aa_code_21,
							 u_aa_code_22,
							 u_aa_code_23,
							 u_aa_code_24,
							 u_aa_code_25,
							 u_aa_code_26,
							 u_aa_code_27,
							 u_aa_code_28,
							 u_aa_code_29,
							 u_aa_code_30,
							 u_aa_code_31,
							 u_aa_code_32,
							 u_aa_code_33,
							 u_aa_code_34] ) ;
							 
rc_dataset_u := __common__( DATASET([
    {'B067', u_rcvalueB067},
    {'P502', u_rcvalueP502},
    {'P509', u_rcvalueP509},
    {'P511', u_rcvalueP511},
    {'P512', u_rcvalueP512},
    {'P515', u_rcvalueP515},
    {'P516', u_rcvalueP516},
    {'P523', u_rcvalueP523},
    {'P524', u_rcvalueP524},
    {'P526', u_rcvalueP526},
    {'P531', u_rcvalueP531},
    {'P532', u_rcvalueP532},
    {'P534', u_rcvalueP534},
    {'P535', u_rcvalueP535},
    {'P538', u_rcvalueP538},
    {'P539', u_rcvalueP539},
    {'P549', u_rcvalueP549},
    {'P550', u_rcvalueP550},
    {'P562', u_rcvalueP562}
    ], ds_layout)(rc in u_code_set) ) ;

//*************************************************************************************//
// If none of the first four RCs are a business reason code (rc[1] = 'B'), find the first 
// business reason code, and make that the fourh reason code. Then shift everything down
// one position to make room for that reason code.  
//*************************************************************************************//
rc_dataset_u_sorted := __common__( sort(rc_dataset_u, value, rc) ) ;

u_rc1  := __common__( rc_dataset_u_sorted[1].rc ) ;
u_rc2  := __common__( rc_dataset_u_sorted[2].rc ) ;
u_rc3  := __common__( rc_dataset_u_sorted[3].rc ) ;

do_new_u_sort := __common__( u_rc1[1] <> 'B' and u_rc2[1] <> 'B' and u_rc3[1] <> 'B' ) ;
rc_business_u := __common__( sort((rc_dataset_u_sorted(rc[1] = 'B')), value)[1] ) ;

// Use null ds to pad the new sort in order to keep the indexing between the original and new sorts the same.
rc_dataset_u_sorted_new := __common__( if(do_new_u_sort, SORT(Null_ds +  rc_dataset_u_sorted[4..], value, rc)(rc <> rc_business_u.rc), rc_dataset_u_sorted) ) ;

u_rc4  := __common__( IF(do_new_u_sort, rc_business_u.rc, rc_dataset_u_sorted_new[4].rc) ) ;
u_rc5  := __common__( rc_dataset_u_sorted_new[5].rc ) ;
u_rc6  := __common__( rc_dataset_u_sorted_new[6].rc ) ;
u_rc7  := __common__( rc_dataset_u_sorted_new[7].rc ) ;
u_rc8  := __common__( rc_dataset_u_sorted_new[8].rc ) ;
u_rc9  := __common__( rc_dataset_u_sorted_new[9].rc ) ;
u_rc10  := __common__( rc_dataset_u_sorted_new[10].rc ) ;
u_rc11  := __common__( rc_dataset_u_sorted_new[11].rc ) ;
u_rc12  := __common__( rc_dataset_u_sorted_new[12].rc ) ;
u_rc13  := __common__( rc_dataset_u_sorted_new[13].rc ) ;
u_rc14  := __common__( rc_dataset_u_sorted_new[14].rc ) ;
u_rc15  := __common__( rc_dataset_u_sorted_new[15].rc ) ;
u_rc16  := __common__( rc_dataset_u_sorted_new[16].rc ) ;
u_rc17  := __common__( rc_dataset_u_sorted_new[17].rc ) ;
u_rc18  := __common__( rc_dataset_u_sorted_new[18].rc ) ;
u_rc19  := __common__( rc_dataset_u_sorted_new[19].rc ) ;
u_rc20  := __common__( rc_dataset_u_sorted_new[20].rc ) ;
u_rc21  := __common__( rc_dataset_u_sorted_new[21].rc ) ;
u_rc22  := __common__( rc_dataset_u_sorted_new[22].rc ) ;
u_rc23  := __common__( rc_dataset_u_sorted_new[23].rc ) ;
u_rc24  := __common__( rc_dataset_u_sorted_new[24].rc ) ;
u_rc25  := __common__( rc_dataset_u_sorted_new[25].rc ) ;
u_rc26  := __common__( rc_dataset_u_sorted_new[26].rc ) ;
u_rc27  := __common__( rc_dataset_u_sorted_new[27].rc ) ;
u_rc28  := __common__( rc_dataset_u_sorted_new[28].rc ) ;
u_rc29  := __common__( rc_dataset_u_sorted_new[29].rc ) ;
u_rc30  := __common__( rc_dataset_u_sorted_new[30].rc ) ;
u_rc31  := __common__( rc_dataset_u_sorted_new[31].rc ) ;
u_rc32  := __common__( rc_dataset_u_sorted_new[32].rc ) ;
u_rc33  := __common__( rc_dataset_u_sorted_new[33].rc ) ;
u_rc34  := __common__( rc_dataset_u_sorted_new[34].rc ) ;
u_rc35  := __common__( rc_dataset_u_sorted_new[35].rc ) ;
u_rc36  := __common__( rc_dataset_u_sorted_new[36].rc ) ;
u_rc37  := __common__( rc_dataset_u_sorted_new[37].rc ) ;
u_rc38  := __common__( rc_dataset_u_sorted_new[38].rc ) ;
u_rc39  := __common__( rc_dataset_u_sorted_new[39].rc ) ;
u_rc40  := __common__( rc_dataset_u_sorted_new[40].rc ) ;
u_rc41  := __common__( rc_dataset_u_sorted_new[41].rc ) ;
u_rc42  := __common__( rc_dataset_u_sorted_new[42].rc ) ;
u_rc43  := __common__( rc_dataset_u_sorted_new[43].rc ) ;
u_rc44  := __common__( rc_dataset_u_sorted_new[44].rc ) ;
u_rc45  := __common__( rc_dataset_u_sorted_new[45].rc ) ;
u_rc46  := __common__( rc_dataset_u_sorted_new[46].rc ) ;
u_rc47  := __common__( rc_dataset_u_sorted_new[47].rc ) ;
u_rc48  := __common__( rc_dataset_u_sorted_new[48].rc ) ;
u_rc49  := __common__( rc_dataset_u_sorted_new[49].rc ) ;
u_rc50  := __common__( rc_dataset_u_sorted_new[50].rc ) ;

blend_mod_rc10_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc10,
    seg_business_score = 'LN ONLY'   => l_rc10,
                                        u_rc10) ) ;

blend_mod_rc46_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc46,
    seg_business_score = 'LN ONLY'   => l_rc46,
                                        u_rc46) ) ;

blend_mod_rc35_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc35,
    seg_business_score = 'LN ONLY'   => l_rc35,
                                        u_rc35) ) ;

blend_mod_rc7_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc7,
    seg_business_score = 'LN ONLY'   => l_rc7,
                                        u_rc7) ) ;

blend_mod_rc26_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc26,
    seg_business_score = 'LN ONLY'   => l_rc26,
                                        u_rc26) ) ;

blend_mod_rc2_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc2,
    seg_business_score = 'LN ONLY'   => l_rc2,
                                        u_rc2) ) ;

blend_mod_rc40_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc40,
    seg_business_score = 'LN ONLY'   => l_rc40,
                                        u_rc40) ) ;

blend_mod_rc47_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc47,
    seg_business_score = 'LN ONLY'   => l_rc47,
                                        u_rc47) ) ;

blend_mod_rc13_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc13,
    seg_business_score = 'LN ONLY'   => l_rc13,
                                        u_rc13) ) ;

blend_mod_rc21_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc21,
    seg_business_score = 'LN ONLY'   => l_rc21,
                                        u_rc21) ) ;

blend_mod_rc37_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc37,
    seg_business_score = 'LN ONLY'   => l_rc37,
                                        u_rc37) ) ;

blend_mod_rc3_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc3,
    seg_business_score = 'LN ONLY'   => l_rc3,
                                        u_rc3) ) ;

blend_mod_rc18_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc18,
    seg_business_score = 'LN ONLY'   => l_rc18,
                                        u_rc18) ) ;

blend_mod_rc45_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc45,
    seg_business_score = 'LN ONLY'   => l_rc45,
                                        u_rc45) ) ;

blend_mod_rc23_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc23,
    seg_business_score = 'LN ONLY'   => l_rc23,
                                        u_rc23) ) ;

blend_mod_rc44_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc44,
    seg_business_score = 'LN ONLY'   => l_rc44,
                                        u_rc44) ) ;

blend_mod_rc49_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc49,
    seg_business_score = 'LN ONLY'   => l_rc49,
                                        u_rc49) ) ;

blend_mod_rc19_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc19,
    seg_business_score = 'LN ONLY'   => l_rc19,
                                        u_rc19) ) ;

blend_mod_rc30_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc30,
    seg_business_score = 'LN ONLY'   => l_rc30,
                                        u_rc30) ) ;

blend_mod_rc12_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc12,
    seg_business_score = 'LN ONLY'   => l_rc12,
                                        u_rc12) ) ;

blend_mod_rc6_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc6,
    seg_business_score = 'LN ONLY'   => l_rc6,
                                        u_rc6) ) ;

blend_mod_rc48_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc48,
    seg_business_score = 'LN ONLY'   => l_rc48,
                                        u_rc48) ) ;

blend_mod_rc22_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc22,
    seg_business_score = 'LN ONLY'   => l_rc22,
                                        u_rc22) ) ;

blend_mod_rc31_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc31,
    seg_business_score = 'LN ONLY'   => l_rc31,
                                        u_rc31) ) ;

blend_mod_rc9_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc9,
    seg_business_score = 'LN ONLY'   => l_rc9,
                                        u_rc9) ) ;

blend_mod_rc20_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc20,
    seg_business_score = 'LN ONLY'   => l_rc20,
                                        u_rc20) ) ;

blend_mod_rc17_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc17,
    seg_business_score = 'LN ONLY'   => l_rc17,
                                        u_rc17) ) ;

blend_mod_rc11_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc11,
    seg_business_score = 'LN ONLY'   => l_rc11,
                                        u_rc11) ) ;

blend_mod_rc27_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc27,
    seg_business_score = 'LN ONLY'   => l_rc27,
                                        u_rc27) ) ;

blend_mod_rc38_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc38,
    seg_business_score = 'LN ONLY'   => l_rc38,
                                        u_rc38) ) ;

blend_mod_rc42_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc42,
    seg_business_score = 'LN ONLY'   => l_rc42,
                                        u_rc42) ) ;

blend_mod_rc14_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc14,
    seg_business_score = 'LN ONLY'   => l_rc14,
                                        u_rc14) ) ;

blend_mod_rc24_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc24,
    seg_business_score = 'LN ONLY'   => l_rc24,
                                        u_rc24) ) ;

blend_mod_rc5_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc5,
    seg_business_score = 'LN ONLY'   => l_rc5,
                                        u_rc5) ) ;

blend_mod_rc43_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc43,
    seg_business_score = 'LN ONLY'   => l_rc43,
                                        u_rc43) ) ;

blend_mod_rc41_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc41,
    seg_business_score = 'LN ONLY'   => l_rc41,
                                        u_rc41) ) ;

blend_mod_rc25_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc25,
    seg_business_score = 'LN ONLY'   => l_rc25,
                                        u_rc25) ) ;

blend_mod_rc29_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc29,
    seg_business_score = 'LN ONLY'   => l_rc29,
                                        u_rc29) ) ;

blend_mod_rc50_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc50,
    seg_business_score = 'LN ONLY'   => l_rc50,
                                        u_rc50) ) ;

blend_mod_rc28_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc28,
    seg_business_score = 'LN ONLY'   => l_rc28,
                                        u_rc28) ) ;

blend_mod_rc16_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc16,
    seg_business_score = 'LN ONLY'   => l_rc16,
                                        u_rc16) ) ;

blend_mod_rc34_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc34,
    seg_business_score = 'LN ONLY'   => l_rc34,
                                        u_rc34) ) ;

blend_mod_rc36_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc36,
    seg_business_score = 'LN ONLY'   => l_rc36,
                                        u_rc36) ) ;

blend_mod_rc8_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc8,
    seg_business_score = 'LN ONLY'   => l_rc8,
                                        u_rc8) ) ;

blend_mod_rc4_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc4,
    seg_business_score = 'LN ONLY'   => l_rc4,
                                        u_rc4) ) ;

blend_mod_rc15_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc15,
    seg_business_score = 'LN ONLY'   => l_rc15,
                                        u_rc15) ) ;

blend_mod_rc33_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc33,
    seg_business_score = 'LN ONLY'   => l_rc33,
                                        u_rc33) ) ;

blend_mod_rc32_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc32,
    seg_business_score = 'LN ONLY'   => l_rc32,
                                        u_rc32) ) ;

blend_mod_rc39_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc39,
    seg_business_score = 'LN ONLY'   => l_rc39,
                                        u_rc39) ) ;

blend_mod_rc1_1 := __common__( map(
    seg_business_score = 'LN & SBFE' => s_rc1,
    seg_business_score = 'LN ONLY'   => l_rc1,
                                        u_rc1) ) ;

blend_mod_rc17 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc17_1) ) ;

blend_mod_rc11 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc11_1) ) ;

blend_mod_rc20 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc20_1) ) ;

blend_mod_rc9 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc9_1) ) ;

blend_mod_rc24 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc24_1) ) ;

blend_mod_rc38 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc38_1) ) ;

blend_mod_rc14 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc14_1) ) ;

blend_mod_rc27 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc27_1) ) ;

blend_mod_rc42 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc42_1) ) ;

blend_mod_rc5 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc5_1) ) ;

blend_mod_rc12 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc12_1) ) ;

blend_mod_rc30 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc30_1) ) ;

blend_mod_rc19 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc19_1) ) ;

blend_mod_rc49 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc49_1) ) ;

blend_mod_rc6 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc6_1) ) ;

blend_mod_rc31 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc31_1) ) ;

blend_mod_rc48 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc48_1) ) ;

blend_mod_rc22 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc22_1) ) ;

blend_mod_rc33 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc33_1) ) ;

blend_mod_rc15 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc15_1) ) ;

blend_mod_rc4 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc4_1) ) ;

blend_mod_rc8 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc8_1) ) ;

blend_mod_rc32 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc32_1) ) ;

blend_mod_rc39 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc39_1) ) ;

blend_mod_rc1 := __common__( if(blend_mod_final_lgt = -1, 'B068', blend_mod_rc1_1) ) ;

blend_mod_rc43 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc43_1) ) ;

blend_mod_rc25 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc25_1) ) ;

blend_mod_rc29 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc29_1) ) ;

blend_mod_rc41 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc41_1) ) ;

blend_mod_rc16 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc16_1) ) ;

blend_mod_rc28 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc28_1) ) ;

blend_mod_rc50 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc50_1) ) ;

blend_mod_rc36 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc36_1) ) ;

blend_mod_rc34 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc34_1) ) ;

blend_mod_rc47 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc47_1) ) ;

blend_mod_rc40 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc40_1) ) ;

blend_mod_rc13 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc13_1) ) ;

blend_mod_rc21 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc21_1) ) ;

blend_mod_rc46 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc46_1) ) ;

blend_mod_rc10 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc10_1) ) ;

blend_mod_rc35 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc35_1) ) ;

sbbm1601_0_0 := __common__( if(blend_mod_final_lgt = -1, 222, min(if(max(_sbbm1601_0_0, 501) = NULL, -NULL, max(_sbbm1601_0_0, 501)), 900)) ) ;

blend_mod_rc26 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc26_1) ) ;

blend_mod_rc7 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc7_1) ) ;

blend_mod_rc2 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc2_1) ) ;

blend_mod_rc45 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc45_1) ) ;

blend_mod_rc23 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc23_1) ) ;

blend_mod_rc44 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc44_1) ) ;

blend_mod_rc3 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc3_1) ) ;

blend_mod_rc37 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc37_1) ) ;

blend_mod_rc18 := __common__( if(blend_mod_final_lgt = -1, ' ', blend_mod_rc18_1) ) ;

//----------------------------------------------------------------------------------
// Note:  I'll implementation of this piece to Engineering:
// 
// /* loop over the first 4 RCs and check for presence of business RC
//    if not present, make the 4th RC a business RC */
// do bus_rc_idx = 1 to dim(blend_mod_rcs) ) ;
//   if substr(blend_mod_rcs[bus_rc_idx], 1, 1) = "B" then leave ) ;
// end ) ;
// 
// /* If the first business RC is not in the first four RCs, this code does the 
//    following:
//     1. store the fourth reason code in a temporary variable
//     2. put the first business RC in the fourth position
//     3. blank out the position it was found in
//     4. shift the remaining reason codes to fill in the hole
//     5. put the original fourth RC in the fifth position
// */
// if 4 < bus_rc_idx <= dim(blend_mod_rcs) then do ) ;
//   tmp_rc = blend_mod_rcs[4] ) ;
//   blend_mod_rcs[4] = blend_mod_rcs[bus_rc_idx] ) ;
//   blend_mod_rcs[bus_rc_idx] = "" ) ;
// 
//   do i = bus_rc_idx to 5 by -1 ) ;
//     blend_mod_rcs[i] = blend_mod_rcs[i-1] ) ;
//   end ) ;
// 
//   blend_mod_rcs[5] = tmp_rc ) ;
// end ) ;
//----------------------------------------------------------------------------------

sbbm_rc1_1 := __common__( blend_mod_rc1 ) ;

sbbm_rc2_1 := __common__( blend_mod_rc2 ) ;

sbbm_rc3_1 := __common__( blend_mod_rc3 ) ;

sbbm_rc4_1 := __common__( blend_mod_rc4 ) ;

sbbm_rc4 := __common__( if(sbbm1601_0_0 = 900, ' ', sbbm_rc4_1) ) ;

sbbm_rc3 := __common__( if(sbbm1601_0_0 = 900, ' ', sbbm_rc3_1) ) ;

sbbm_rc1 := __common__( if(sbbm1601_0_0 = 900, ' ', sbbm_rc1_1) ) ;

sbbm_rc2 := __common__( if(sbbm1601_0_0 = 900, ' ', sbbm_rc2_1) ) ;

//*************************************************************************************//
//                      Reason Code Overrides 
//*************************************************************************************//
HRILayout := RECORD
	STRING5 HRI := '';
END;

reasons := DATASET([{sbbm_rc1}, {sbbm_rc2}, {sbbm_rc3}, {sbbm_rc4}], HRILayout);

zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasons & zeros, 4); // Keep up to 4 reason codes

	#if(MODEL_DEBUG)
                    self.source_ar                        := source_ar;
                    self.source_ba                        := source_ba;
                    self.source_bm                        := source_bm;
                    self.source_c                         := source_c;
                    self.source_cs                        := source_cs;
                    self.source_dn                        := source_dn;
                    self.source_ef                        := source_ef;
                    self.source_ft                        := source_ft;
                    self.source_i                         := source_i;
                    self.source_ia                        := source_ia;
                    self.source_in                        := source_in;
                    self.source_l2                        := source_l2;
                    self.source_p                         := source_p;
                    self.source_ut                        := source_ut;
                    self.source_v2                        := source_v2;
                    self.source_wk                        := source_wk;
                    self.sysdate                          := sysdate;
                    self._ver_src_id__br                  := _ver_src_id__br;
                    self._ver_src_id_c_pos                := _ver_src_id_c_pos;
                    self._ver_src_id__c                   := _ver_src_id__c;
                    self._ver_src_id_d_pos                := _ver_src_id_d_pos;
                    self._ver_src_id__d                   := _ver_src_id__d;
                    self._ver_src_id_df_pos               := _ver_src_id_df_pos;
                    self._ver_src_id__df                  := _ver_src_id__df;
                    self._ver_src_id_dn_pos               := _ver_src_id_dn_pos;
                    self._ver_src_id__dn                  := _ver_src_id__dn;
                    self._ver_src_id_fb_pos               := _ver_src_id_fb_pos;
                    self._ver_src_id__fb                  := _ver_src_id__fb;
                    self._ver_src_id_l0_pos               := _ver_src_id_l0_pos;
                    self._ver_src_id__l0                  := _ver_src_id__l0;
                    self._ver_src_id_l2_pos               := _ver_src_id_l2_pos;
                    self._ver_src_id__l2                  := _ver_src_id__l2;
                    self._ver_src_id_u2_pos               := _ver_src_id_u2_pos;
                    self._ver_src_id__u2                  := _ver_src_id__u2;
                    self._ver_src_id_ar_pos               := _ver_src_id_ar_pos;
                    self._ver_src_id__ar                  := _ver_src_id__ar;
                    self._ver_src_id_ba_pos               := _ver_src_id_ba_pos;
                    self._ver_src_id__ba                  := _ver_src_id__ba;
                    self._ver_src_id_bm_pos               := _ver_src_id_bm_pos;
                    self._ver_src_id__bm                  := _ver_src_id__bm;
                    self._ver_src_id_bn_pos               := _ver_src_id_bn_pos;
                    self._ver_src_id__bn                  := _ver_src_id__bn;
                    self._ver_src_id_cu_pos               := _ver_src_id_cu_pos;
                    self._ver_src_id__cu                  := _ver_src_id__cu;
                    self._ver_src_id_da_pos               := _ver_src_id_da_pos;
                    self._ver_src_id__da                  := _ver_src_id__da;
                    self._ver_src_id_ef_pos               := _ver_src_id_ef_pos;
                    self._ver_src_id__ef                  := _ver_src_id__ef;
                    self._ver_src_id_fi_pos               := _ver_src_id_fi_pos;
                    self._ver_src_id__fi                  := _ver_src_id__fi;
                    self._ver_src_id_i_pos                := _ver_src_id_i_pos;
                    self._ver_src_id__i                   := _ver_src_id__i;
                    self._ver_src_id_ia_pos               := _ver_src_id_ia_pos;
                    self._ver_src_id__ia                  := _ver_src_id__ia;
                    self._ver_src_id_in_pos               := _ver_src_id_in_pos;
                    self._ver_src_id__in                  := _ver_src_id__in;
                    self._ver_src_id_os_pos               := _ver_src_id_os_pos;
                    self._ver_src_id__os                  := _ver_src_id__os;
                    self._ver_src_id_p_pos                := _ver_src_id_p_pos;
                    self._ver_src_id__p                   := _ver_src_id__p;
                    self._ver_src_id_ldate_p              := _ver_src_id_ldate_p;
                    self._ver_src_id_ldate_p2             := _ver_src_id_ldate_p2;
                    self.mth__ver_src_id_ldate_p          := mth__ver_src_id_ldate_p;
                    self._ver_src_id_pl_pos               := _ver_src_id_pl_pos;
                    self._ver_src_id__pl                  := _ver_src_id__pl;
                    self._ver_src_id_q3_pos               := _ver_src_id_q3_pos;
                    self._ver_src_id__q3                  := _ver_src_id__q3;
                    self._ver_src_id_fdate_q3             := _ver_src_id_fdate_q3;
                    self._ver_src_id_fdate_q32            := _ver_src_id_fdate_q32;
                    self.mth__ver_src_id_fdate_q3         := mth__ver_src_id_fdate_q3;
                    self._ver_src_id_sk_pos               := _ver_src_id_sk_pos;
                    self._ver_src_id__sk                  := _ver_src_id__sk;
                    self._ver_src_id_tx_pos               := _ver_src_id_tx_pos;
                    self._ver_src_id__tx                  := _ver_src_id__tx;
                    self._ver_src_id_v2_pos               := _ver_src_id_v2_pos;
                    self._ver_src_id__v2                  := _ver_src_id__v2;
                    self._ver_src_id_wa_pos               := _ver_src_id_wa_pos;
                    self._ver_src_id__wa                  := _ver_src_id__wa;
                    self._ver_src_id_by_pos               := _ver_src_id_by_pos;
                    self._ver_src_id__by                  := _ver_src_id__by;
                    self._ver_src_id_cf_pos               := _ver_src_id_cf_pos;
                    self._ver_src_id__cf                  := _ver_src_id__cf;
                    self._ver_src_id_e_pos                := _ver_src_id_e_pos;
                    self._ver_src_id__e                   := _ver_src_id__e;
                    self._ver_src_id_ey_pos               := _ver_src_id_ey_pos;
                    self._ver_src_id__ey                  := _ver_src_id__ey;
                    self._ver_src_id_f_pos                := _ver_src_id_f_pos;
                    self._ver_src_id__f                   := _ver_src_id__f;
                    self._ver_src_id_fk_pos               := _ver_src_id_fk_pos;
                    self._ver_src_id__fk                  := _ver_src_id__fk;
                    self._ver_src_id_fr_pos               := _ver_src_id_fr_pos;
                    self._ver_src_id__fr                  := _ver_src_id__fr;
                    self._ver_src_id_ft_pos               := _ver_src_id_ft_pos;
                    self._ver_src_id__ft                  := _ver_src_id__ft;
                    self._ver_src_id_gr_pos               := _ver_src_id_gr_pos;
                    self._ver_src_id__gr                  := _ver_src_id__gr;
                    self._ver_src_id_h7_pos               := _ver_src_id_h7_pos;
                    self._ver_src_id__h7                  := _ver_src_id__h7;
                    self._ver_src_id_ic_pos               := _ver_src_id_ic_pos;
                    self._ver_src_id__ic                  := _ver_src_id__ic;
                    self._ver_src_id_ip_pos               := _ver_src_id_ip_pos;
                    self._ver_src_id__ip                  := _ver_src_id__ip;
                    self._ver_src_id_is_pos               := _ver_src_id_is_pos;
                    self._ver_src_id__is                  := _ver_src_id__is;
                    self._ver_src_id_it_pos               := _ver_src_id_it_pos;
                    self._ver_src_id__it                  := _ver_src_id__it;
                    self._ver_src_id_j2_pos               := _ver_src_id_j2_pos;
                    self._ver_src_id__j2                  := _ver_src_id__j2;
                    self._ver_src_id_kc_pos               := _ver_src_id_kc_pos;
                    self._ver_src_id__kc                  := _ver_src_id__kc;
                    self._ver_src_id_mh_pos               := _ver_src_id_mh_pos;
                    self._ver_src_id__mh                  := _ver_src_id__mh;
                    self._ver_src_id_mw_pos               := _ver_src_id_mw_pos;
                    self._ver_src_id__mw                  := _ver_src_id__mw;
                    self._ver_src_id_np_pos               := _ver_src_id_np_pos;
                    self._ver_src_id__np                  := _ver_src_id__np;
                    self._ver_src_id_nr_pos               := _ver_src_id_nr_pos;
                    self._ver_src_id__nr                  := _ver_src_id__nr;
                    self._ver_src_id_sa_pos               := _ver_src_id_sa_pos;
                    self._ver_src_id__sa                  := _ver_src_id__sa;
                    self._ver_src_id_sb_pos               := _ver_src_id_sb_pos;
                    self._ver_src_id__sb                  := _ver_src_id__sb;
                    self._ver_src_id_sg_pos               := _ver_src_id_sg_pos;
                    self._ver_src_id__sg                  := _ver_src_id__sg;
                    self._ver_src_id_sj_pos               := _ver_src_id_sj_pos;
                    self._ver_src_id__sj                  := _ver_src_id__sj;
                    self._ver_src_id_sp_pos               := _ver_src_id_sp_pos;
                    self._ver_src_id__sp                  := _ver_src_id__sp;
                    self._ver_src_id_ut_pos               := _ver_src_id_ut_pos;
                    self._ver_src_id__ut                  := _ver_src_id__ut;
                    self._ver_src_id_v_pos                := _ver_src_id_v_pos;
                    self._ver_src_id__v                   := _ver_src_id__v;
                    self._ver_src_id_wb_pos               := _ver_src_id_wb_pos;
                    self._ver_src_id__wb                  := _ver_src_id__wb;
                    self._ver_src_id_wc_pos               := _ver_src_id_wc_pos;
                    self._ver_src_id__wc                  := _ver_src_id__wc;
                    self._ver_src_id_wk_pos               := _ver_src_id_wk_pos;
                    self._ver_src_id__wk                  := _ver_src_id__wk;
                    self._ver_src_id_wx_pos               := _ver_src_id_wx_pos;
                    self._ver_src_id__wx                  := _ver_src_id__wx;
                    self._ver_src_id_zo_pos               := _ver_src_id_zo_pos;
                    self._ver_src_id__zo                  := _ver_src_id__zo;
                    self._ver_src_id_y_pos                := _ver_src_id_y_pos;
                    self._ver_src_id__y                   := _ver_src_id__y;
                    self._ver_src_id_gb_pos               := _ver_src_id_gb_pos;
                    self._ver_src_id__gb                  := _ver_src_id__gb;
                    self._ver_src_id_fdate_gb             := _ver_src_id_fdate_gb;
                    self._ver_src_id_fdate_gb2            := _ver_src_id_fdate_gb2;
                    self.mth__ver_src_id_fdate_gb         := mth__ver_src_id_fdate_gb;
                    self._ver_src_id_ldate_gb             := _ver_src_id_ldate_gb;
                    self._ver_src_id_ldate_gb2            := _ver_src_id_ldate_gb2;
                    self.mth__ver_src_id_ldate_gb         := mth__ver_src_id_ldate_gb;
                    self._ver_src_id_cs_pos               := _ver_src_id_cs_pos;
                    self._ver_src_id__cs                  := _ver_src_id__cs;
                    self._ne_ver_src_id_count             := _ne_ver_src_id_count;
                    self.truebiz                          := truebiz;
                    self.ne_bv_truebiz_category           := ne_bv_truebiz_category;
                    self.seg_business_score               := seg_business_score;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.vs_gb_id_mth_fseen               := vs_gb_id_mth_fseen;
                    self.vs_gb_id_mth_lseen               := vs_gb_id_mth_lseen;
                    self.vs_ver_src_id__bm                := vs_ver_src_id__bm;
                    self.vs_ver_src_id__in                := vs_ver_src_id__in;
                    self.vs_adl_util_i                    := vs_adl_util_i;
                    self.vs_util_adl_count                := vs_util_adl_count;
                    self._util_adl_first_seen             := _util_adl_first_seen;
                    self.vs_util_adl_mths_fs              := vs_util_adl_mths_fs;
                    self._gong_did_last_seen              := _gong_did_last_seen;
                    self.vs_gong_adl_mths_ls              := vs_gong_adl_mths_ls;
                    self._header_first_seen               := _header_first_seen;
                    self.vs_header_mths_fs                := vs_header_mths_fs;
                    self._pb_first_seen                   := _pb_first_seen;
                    self.vs_pb_mths_fs                    := vs_pb_mths_fs;
                    self._pb_last_seen                    := _pb_last_seen;
                    self.vs_pb_mths_ls                    := vs_pb_mths_ls;
                    self.vs_pb_number_of_sources          := vs_pb_number_of_sources;
                    self.vs_br_mths_fs                    := vs_br_mths_fs;
                    self.vs_br_business_count             := vs_br_business_count;
                    self.vs_br_dead_business_count        := vs_br_dead_business_count;
                    self.vs_br_active_phone_count         := vs_br_active_phone_count;
                    self.vs_email_count                   := vs_email_count;
                    self.vs_email_domain_free_count       := vs_email_domain_free_count;
                    self.vs_email_domain_edu_count        := vs_email_domain_edu_count;
                    self.vs_historical_count              := vs_historical_count;
                    self.vs_college_tier                  := vs_college_tier;
                    self.vs_prof_license_flag             := vs_prof_license_flag;
                    self.ver_src_cons_vo_pos              := ver_src_cons_vo_pos;
                    self.ver_src_cons_ldate_vo            := ver_src_cons_ldate_vo;
                    self.ver_src_cons_wp_pos              := ver_src_cons_wp_pos;
                    self.ver_src_cons_am_pos              := ver_src_cons_am_pos;
                    self.ver_src_cons_e1_pos              := ver_src_cons_e1_pos;
                    self._ver_src_cons_ldate_vo           := _ver_src_cons_ldate_vo;
                    self.vs_ver_src_cons_vo_mths_ls       := vs_ver_src_cons_vo_mths_ls;
                    self.vs_ver_sources_wp_pop            := vs_ver_sources_wp_pop;
                    self.vs_ver_sources_am_pop            := vs_ver_sources_am_pop;
                    self.vs_ver_sources_e1_pop            := vs_ver_sources_e1_pop;
                    self.c_vs_gb_id_mth_fseen_w           := c_vs_gb_id_mth_fseen_w;
                    self.c_vs_gb_id_mth_lseen_w           := c_vs_gb_id_mth_lseen_w;
                    self.c_vs_ver_src_id__bm_w            := c_vs_ver_src_id__bm_w;
                    self.c_vs_ver_src_id__in_w            := c_vs_ver_src_id__in_w;
                    self.c_vs_util_adl_count_w            := c_vs_util_adl_count_w;
                    self.c_vs_util_adl_mths_fs_w          := c_vs_util_adl_mths_fs_w;
                    self.c_vs_gong_adl_mths_ls_w          := c_vs_gong_adl_mths_ls_w;
                    self.c_vs_header_mths_fs_w            := c_vs_header_mths_fs_w;
                    self.c_vs_pb_mths_fs_w                := c_vs_pb_mths_fs_w;
                    self.c_vs_pb_mths_ls_w                := c_vs_pb_mths_ls_w;
                    self.c_vs_pb_number_of_sources_w      := c_vs_pb_number_of_sources_w;
                    self.c_vs_br_mths_fs_w                := c_vs_br_mths_fs_w;
                    self.c_vs_br_dead_business_count_w    := c_vs_br_dead_business_count_w;
                    self.c_vs_br_active_phone_count_w     := c_vs_br_active_phone_count_w;
                    self.c_vs_email_count_w               := c_vs_email_count_w;
                    self.c_vs_email_domain_free_count_w   := c_vs_email_domain_free_count_w;
                    self.c_vs_email_domain_edu_count_w    := c_vs_email_domain_edu_count_w;
                    self.c_vs_college_tier_w              := c_vs_college_tier_w;
                    self.c_vs_prof_license_flag_w         := c_vs_prof_license_flag_w;
                    self.c_vs_ver_src_cons_vo_mths_ls_w   := c_vs_ver_src_cons_vo_mths_ls_w;
                    self.c_vs_ver_sources_am_pop_w        := c_vs_ver_sources_am_pop_w;
                    self.bv_bus_rep_source_profile        := bv_bus_rep_source_profile;
                    self.r_vs_adl_util_i_w                := r_vs_adl_util_i_w;
                    self.r_vs_util_adl_count_w            := r_vs_util_adl_count_w;
                    self.r_vs_util_adl_mths_fs_w          := r_vs_util_adl_mths_fs_w;
                    self.r_vs_gong_adl_mths_ls_w          := r_vs_gong_adl_mths_ls_w;
                    self.r_vs_header_mths_fs_w            := r_vs_header_mths_fs_w;
                    self.r_vs_pb_mths_fs_w                := r_vs_pb_mths_fs_w;
                    self.r_vs_pb_mths_ls_w                := r_vs_pb_mths_ls_w;
                    self.r_vs_pb_number_of_sources_w      := r_vs_pb_number_of_sources_w;
                    self.r_vs_br_mths_fs_w                := r_vs_br_mths_fs_w;
                    self.r_vs_br_business_count_w         := r_vs_br_business_count_w;
                    self.r_vs_br_dead_business_count_w    := r_vs_br_dead_business_count_w;
                    self.r_vs_br_active_phone_count_w     := r_vs_br_active_phone_count_w;
                    self.r_vs_email_count_w               := r_vs_email_count_w;
                    self.r_vs_email_domain_free_count_w   := r_vs_email_domain_free_count_w;
                    self.r_vs_email_domain_edu_count_w    := r_vs_email_domain_edu_count_w;
                    self.r_vs_historical_count_w          := r_vs_historical_count_w;
                    self.r_vs_college_tier_w              := r_vs_college_tier_w;
                    self.r_vs_prof_license_flag_w         := r_vs_prof_license_flag_w;
                    self.r_vs_ver_src_cons_vo_mths_ls_w   := r_vs_ver_src_cons_vo_mths_ls_w;
                    self.r_vs_ver_sources_wp_pop_w        := r_vs_ver_sources_wp_pop_w;
                    self.r_vs_ver_sources_am_pop_w        := r_vs_ver_sources_am_pop_w;
                    self.r_vs_ver_sources_e1_pop_w        := r_vs_ver_sources_e1_pop_w;
                    self.bv_rep_only_source_profile       := bv_rep_only_source_profile;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self._criminal_last_date              := _criminal_last_date;
                    self.rv_d32_mos_since_crim_ls         := rv_d32_mos_since_crim_ls;
                    self.rv_d31_mostrec_bk                := rv_d31_mostrec_bk;
                    self.rv_a46_curr_avm_autoval          := rv_a46_curr_avm_autoval;
                    self.rv_a49_curr_avm_chg_1yr_pct      := rv_a49_curr_avm_chg_1yr_pct;
                    self.rv_a41_prop_owner                := rv_a41_prop_owner;
                    self.rv_e55_college_ind               := rv_e55_college_ind;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_c18_invalid_addrs_per_adl     := rv_c18_invalid_addrs_per_adl;
                    self.rv_d34_attr_liens_recency        := rv_d34_attr_liens_recency;
                    self.rv_e58_br_dead_business_count    := rv_e58_br_dead_business_count;
                    self.nf_inq_collection_count          := nf_inq_collection_count;
                    self._acc_last_seen                   := _acc_last_seen;
                    self.nf_mos_acc_lseen                 := nf_mos_acc_lseen;
                    self.rv_d31_bk_chapter                := rv_d31_bk_chapter;
                    self.rv_d34_unrel_liens_ct            := rv_d34_unrel_liens_ct;
                    self.rv_a41_a42_prop_owner_history    := rv_a41_a42_prop_owner_history;
                    self.rv_i61_inq_collection_recency    := rv_i61_inq_collection_recency;
                    self.rv_i60_inq_auto_recency          := rv_i60_inq_auto_recency;
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.iv_d34_liens_rel_sc_ct           := iv_d34_liens_rel_sc_ct;
                    self.nf_inq_highriskcredit_count      := nf_inq_highriskcredit_count;
                    self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
                    self.nf_mos_inq_banko_cm_fseen        := nf_mos_inq_banko_cm_fseen;
                    self.nf_fp_vardobcountnew             := nf_fp_vardobcountnew;
                    self.nf_fp_srchfraudsrchcountmo       := nf_fp_srchfraudsrchcountmo;
                    self.nf_fp_prevaddrstatus             := nf_fp_prevaddrstatus;
                    self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
                    self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
                    self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
                    self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
                    self.nf_m_bureau_adl_fs_notu          := nf_m_bureau_adl_fs_notu;
                    self.rv_d31_attr_bankruptcy_recency   := rv_d31_attr_bankruptcy_recency;
                    self.rv_d31_bk_disposed_hist_count    := rv_d31_bk_disposed_hist_count;
                    self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.rv_d34_unrel_lien60_count        := rv_d34_unrel_lien60_count;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.rv_l79_adls_per_addr_curr        := rv_l79_adls_per_addr_curr;
                    self.rv_a50_pb_average_dollars        := rv_a50_pb_average_dollars;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.iv_d34_liens_unrel_cj_ct         := iv_d34_liens_unrel_cj_ct;
                    self.iv_d34_liens_unrel_sc_ct         := iv_d34_liens_unrel_sc_ct;
                    self.nf_inq_auto_count                := nf_inq_auto_count;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self._inq_banko_om_last_seen          := _inq_banko_om_last_seen;
                    self.nf_mos_inq_banko_om_lseen        := nf_mos_inq_banko_om_lseen;
                    self.nf_accident_count                := nf_accident_count;
                    self.nf_fp_srchunvrfdssncount         := nf_fp_srchunvrfdssncount;
                    self.nf_fp_srchunvrfdaddrcount        := nf_fp_srchunvrfdaddrcount;
                    self.nf_fp_curraddractivephonelist    := nf_fp_curraddractivephonelist;
                    self.td_sbfe_avg_util_pct06           := td_sbfe_avg_util_pct06;
                    self.td_acct_dpd_1p_recency           := td_acct_dpd_1p_recency;
                    self._sbfe_acct_datefirstopen         := _sbfe_acct_datefirstopen;
                    self.td_mth_acct_firstopen            := td_mth_acct_firstopen;
                    self.td_sbfe_avg_util_pct_cc          := td_sbfe_avg_util_pct_cc;
                    self.td_sbfe_util_pct_cc              := td_sbfe_util_pct_cc;
                    self._sos_inc_filing_firstseen        := _sos_inc_filing_firstseen;
                    self.bv_sos_mth_fs                    := bv_sos_mth_fs;
                    self.td_sbfe_closed_pct_invol         := td_sbfe_closed_pct_invol;
                    self.num_pos_sources                  := num_pos_sources;
                    self.num_neg_sources                  := num_neg_sources;
                    self.bv_ver_src_derog_ratio           := bv_ver_src_derog_ratio;
                    self.bv_mth_ver_src_q3_fs             := bv_mth_ver_src_q3_fs;
                    self._sbfe_datefirstseen              := _sbfe_datefirstseen;
                    self.td_mth_sbfe_datefirstseen        := td_mth_sbfe_datefirstseen;
                    self.td_acct_pct_closed               := td_acct_pct_closed;
                    self._sbfe_dlq_datelastseen           := _sbfe_dlq_datelastseen;
                    self.td_mth_dlq_lastseen              := td_mth_dlq_lastseen;
                    self._inq_lastseen                    := _inq_lastseen;
                    self.bv_mths_inq_lastseen             := bv_mths_inq_lastseen;
                    self.bv_prop_assessed_value           := bv_prop_assessed_value;
                    self.bv_mth_ver_src_p_ls              := bv_mth_ver_src_p_ls;
                    self.bv_lien_judg_index               := bv_lien_judg_index;
                    self._phn_input_firstseen_id          := _phn_input_firstseen_id;
                    self.bv_src_id_phn_mth_fs             := bv_src_id_phn_mth_fs;
                    self.bv_assoc_bk_tot                  := bv_assoc_bk_tot;
                    self.bv_sos_defunct_status            := bv_sos_defunct_status;
                    self.bv_lien_filed_count              := bv_lien_filed_count;
                    self._ucc_lastseen                    := _ucc_lastseen;
                    self.bv_ucc_mth_ls                    := bv_ucc_mth_ls;
                    self.bv_ucc_index                     := bv_ucc_index;
                    self.td_sbfe_worst_perf06             := td_sbfe_worst_perf06;
                    self.td_sbfe_worst_perf60_loan        := td_sbfe_worst_perf60_loan;
                    self.td_sbfe_worst_perf12_oel         := td_sbfe_worst_perf12_oel;
                    self.td_acct_dpd_31p_recency_cc       := td_acct_dpd_31p_recency_cc;
                    self.td_acct_dpd_91p_recency_lse      := td_acct_dpd_91p_recency_lse;
                    self.td_sbfe_util_pct                 := td_sbfe_util_pct;
                    self.td_sbfe_avg_util_pct24           := td_sbfe_avg_util_pct24;
                    self.td_sbfe_avg_past_due_amt24       := td_sbfe_avg_past_due_amt24;
                    self.td_sbfe_avg_past_due_amt         := td_sbfe_avg_past_due_amt;
                    self.td_sbfe_avg_util_pct12           := td_sbfe_avg_util_pct12;
                    self.td_sbfe_worst_perf84             := td_sbfe_worst_perf84;
                    self.bv_assoc_derog_flag              := bv_assoc_derog_flag;
                    self.s_bv_src_id_phn_mth_fs_w         := s_bv_src_id_phn_mth_fs_w;
                    self.s_aa_dist_1                      := s_aa_dist_1;
                    self.s_aa_code_1                      := s_aa_code_1;
                    self.s_bv_assoc_bk_tot_w              := s_bv_assoc_bk_tot_w;
                    self.s_aa_dist_2                      := s_aa_dist_2;
                    self.s_aa_code_2                      := s_aa_code_2;
                    self.s_bv_sos_defunct_status_w        := s_bv_sos_defunct_status_w;
                    self.s_aa_dist_3                      := s_aa_dist_3;
                    self.s_aa_code_3                      := s_aa_code_3;
                    self.s_bv_lien_filed_count_w          := s_bv_lien_filed_count_w;
                    self.s_aa_dist_4                      := s_aa_dist_4;
                    self.s_aa_code_4                      := s_aa_code_4;
                    self.s_bv_ucc_index_w                 := s_bv_ucc_index_w;
                    self.s_aa_dist_5                      := s_aa_dist_5;
                    self.s_aa_code_5                      := s_aa_code_5;
                    self.s_bv_prop_assessed_value_w       := s_bv_prop_assessed_value_w;
                    self.s_aa_dist_6                      := s_aa_dist_6;
                    self.s_aa_code_6                      := s_aa_code_6;
                    self.s_td_mth_sbfe_datefirstseen_w    := s_td_mth_sbfe_datefirstseen_w;
                    self.s_aa_dist_7                      := s_aa_dist_7;
                    self.s_aa_code_7                      := s_aa_code_7;
                    self.s_td_mth_acct_firstopen_w        := s_td_mth_acct_firstopen_w;
                    self.s_aa_dist_8                      := s_aa_dist_8;
                    self.s_aa_code_8                      := s_aa_code_8;
                    self.s_td_mth_dlq_lastseen_w          := s_td_mth_dlq_lastseen_w;
                    self.s_aa_dist_9                      := s_aa_dist_9;
                    self.s_aa_code_9                      := s_aa_code_9;
                    self.s_td_acct_pct_closed_w           := s_td_acct_pct_closed_w;
                    self.s_aa_dist_10                     := s_aa_dist_10;
                    self.s_aa_code_10                     := s_aa_code_10;
                    self.s_td_sbfe_worst_perf06_w         := s_td_sbfe_worst_perf06_w;
                    self.s_aa_dist_11                     := s_aa_dist_11;
                    self.s_aa_code_11                     := s_aa_code_11;
                    self.s_td_sbfe_worst_perf60_loan_w    := s_td_sbfe_worst_perf60_loan_w;
                    self.s_aa_dist_12                     := s_aa_dist_12;
                    self.s_aa_code_12                     := s_aa_code_12;
                    self.s_td_sbfe_worst_perf12_oel_w     := s_td_sbfe_worst_perf12_oel_w;
                    self.s_aa_dist_13                     := s_aa_dist_13;
                    self.s_aa_code_13                     := s_aa_code_13;
                    self.s_td_acct_dpd_31p_recency_cc_w   := s_td_acct_dpd_31p_recency_cc_w;
                    self.s_aa_dist_14                     := s_aa_dist_14;
                    self.s_aa_code_14                     := s_aa_code_14;
                    self.s_td_acct_dpd_91p_recency_lse_w  := s_td_acct_dpd_91p_recency_lse_w;
                    self.s_aa_dist_15                     := s_aa_dist_15;
                    self.s_aa_code_15                     := s_aa_code_15;
                    self.s_td_sbfe_closed_pct_invol_w     := s_td_sbfe_closed_pct_invol_w;
                    self.s_aa_dist_16                     := s_aa_dist_16;
                    self.s_aa_code_16                     := s_aa_code_16;
                    self.s_td_sbfe_util_pct_w             := s_td_sbfe_util_pct_w;
                    self.s_aa_dist_17                     := s_aa_dist_17;
                    self.s_aa_code_17                     := s_aa_code_17;
                    self.s_td_sbfe_util_pct_cc_w          := s_td_sbfe_util_pct_cc_w;
                    self.s_aa_dist_18                     := s_aa_dist_18;
                    self.s_aa_code_18                     := s_aa_code_18;
                    self.s_td_sbfe_avg_util_pct06_w       := s_td_sbfe_avg_util_pct06_w;
                    self.s_aa_dist_19                     := s_aa_dist_19;
                    self.s_aa_code_19                     := s_aa_code_19;
                    self.s_td_sbfe_avg_util_pct24_w       := s_td_sbfe_avg_util_pct24_w;
                    self.s_aa_dist_20                     := s_aa_dist_20;
                    self.s_aa_code_20                     := s_aa_code_20;
                    self.s_td_sbfe_avg_util_pct_cc_w      := s_td_sbfe_avg_util_pct_cc_w;
                    self.s_aa_dist_21                     := s_aa_dist_21;
                    self.s_aa_code_21                     := s_aa_code_21;
                    self.s_td_sbfe_avg_past_due_amt24_w   := s_td_sbfe_avg_past_due_amt24_w;
                    self.s_aa_dist_22                     := s_aa_dist_22;
                    self.s_aa_code_22                     := s_aa_code_22;
                    self.s_td_sbfe_avg_past_due_amt_w     := s_td_sbfe_avg_past_due_amt_w;
                    self.s_aa_dist_23                     := s_aa_dist_23;
                    self.s_aa_code_23                     := s_aa_code_23;
                    self.s_bv_ver_src_derog_ratio_w       := s_bv_ver_src_derog_ratio_w;
                    self.s_aa_dist_24                     := s_aa_dist_24;
                    self.s_aa_code_24                     := s_aa_code_24;
                    self.s_rv_d30_derog_count_w           := s_rv_d30_derog_count_w;
                    self.s_aa_dist_25                     := s_aa_dist_25;
                    self.s_aa_code_25                     := s_aa_code_25;
                    self.s_rv_d32_mos_since_crim_ls_w     := s_rv_d32_mos_since_crim_ls_w;
                    self.s_aa_dist_26                     := s_aa_dist_26;
                    self.s_aa_code_26                     := s_aa_code_26;
                    self.s_rv_d31_mostrec_bk_w            := s_rv_d31_mostrec_bk_w;
                    self.s_aa_dist_27                     := s_aa_dist_27;
                    self.s_aa_code_27                     := s_aa_code_27;
                    self.s_rv_a46_curr_avm_autoval_w      := s_rv_a46_curr_avm_autoval_w;
                    self.s_aa_dist_28                     := s_aa_dist_28;
                    self.s_aa_code_28                     := s_aa_code_28;
                    self.s_rv_a49_curr_avm_chg_1yr_pct_w  := s_rv_a49_curr_avm_chg_1yr_pct_w;
                    self.s_aa_dist_29                     := s_aa_dist_29;
                    self.s_aa_code_29                     := s_aa_code_29;
                    self.s_rv_a41_prop_owner_w            := s_rv_a41_prop_owner_w;
                    self.s_aa_dist_30                     := s_aa_dist_30;
                    self.s_aa_code_30                     := s_aa_code_30;
                    self.s_rv_e55_college_ind_w           := s_rv_e55_college_ind_w;
                    self.s_aa_dist_31                     := s_aa_dist_31;
                    self.s_aa_code_31                     := s_aa_code_31;
                    self.s_rv_i60_inq_hiriskcred_rec_w    := s_rv_i60_inq_hiriskcred_rec_w;
                    self.s_aa_dist_32                     := s_aa_dist_32;
                    self.s_aa_code_32                     := s_aa_code_32;
                    self.s_rv_c18_inv_addrs_per_adl_w     := s_rv_c18_inv_addrs_per_adl_w;
                    self.s_aa_dist_33                     := s_aa_dist_33;
                    self.s_aa_code_33                     := s_aa_code_33;
                    self.s_rv_d34_attr_liens_recency_w    := s_rv_d34_attr_liens_recency_w;
                    self.s_aa_dist_34                     := s_aa_dist_34;
                    self.s_aa_code_34                     := s_aa_code_34;
                    self.s_rv_e58_br_dead_bus_count_w     := s_rv_e58_br_dead_bus_count_w;
                    self.s_aa_dist_35                     := s_aa_dist_35;
                    self.s_aa_code_35                     := s_aa_code_35;
                    self.s_nf_inq_collection_count_w      := s_nf_inq_collection_count_w;
                    self.s_aa_dist_36                     := s_aa_dist_36;
                    self.s_aa_code_36                     := s_aa_code_36;
                    self.s_nf_mos_acc_lseen_w             := s_nf_mos_acc_lseen_w;
                    self.s_aa_dist_37                     := s_aa_dist_37;
                    self.s_aa_code_37                     := s_aa_code_37;
                    self.s_bv_bus_rep_source_profile_w    := s_bv_bus_rep_source_profile_w;
                    self.s_aa_dist_38                     := s_aa_dist_38;
                    self.s_aa_code_38                     := s_aa_code_38;
                    self.s_bv_rep_only_source_profile_w   := s_bv_rep_only_source_profile_w;
                    self.s_aa_dist_39                     := s_aa_dist_39;
                    self.s_aa_code_39                     := s_aa_code_39;
                    self.s_td_sbfe_avg_util_pct12_w       := s_td_sbfe_avg_util_pct12_w;
                    self.s_aa_dist_40                     := s_aa_dist_40;
                    self.s_aa_code_40                     := s_aa_code_40;
                    self.s_td_acct_dpd_1p_recency_w       := s_td_acct_dpd_1p_recency_w;
                    self.s_aa_dist_41                     := s_aa_dist_41;
                    self.s_aa_code_41                     := s_aa_code_41;
                    self.s_td_sbfe_worst_perf84_w         := s_td_sbfe_worst_perf84_w;
                    self.s_aa_dist_42                     := s_aa_dist_42;
                    self.s_aa_code_42                     := s_aa_code_42;
                    self.s_rcvalueb037                    := s_rcvalueb037;
                    self.s_rcvaluep531                    := s_rcvaluep531;
                    self.s_rcvaluep532                    := s_rcvaluep532;
                    self.s_rcvalueb034                    := s_rcvalueb034;
                    self.s_rcvaluep534                    := s_rcvaluep534;
                    self.s_rcvaluep535                    := s_rcvaluep535;
                    self.s_rcvalueb031                    := s_rcvalueb031;
                    self.s_rcvaluep516                    := s_rcvaluep516;
                    self.s_rcvaluep539                    := s_rcvaluep539;
                    self.s_rcvalueb017                    := s_rcvalueb017;
                    self.s_rcvaluep515                    := s_rcvaluep515;
                    self.s_rcvaluep521                    := s_rcvaluep521;
                    self.s_rcvaluebf142                   := s_rcvaluebf142;
                    self.s_rcvaluep511                    := s_rcvaluep511;
                    self.s_rcvaluebf113                   := s_rcvaluebf113;
                    self.s_rcvaluebf134                   := s_rcvaluebf134;
                    self.s_rcvaluebf110                   := s_rcvaluebf110;
                    self.s_rcvaluebf117                   := s_rcvaluebf117;
                    self.s_rcvaluebf133                   := s_rcvaluebf133;
                    self.s_rcvaluebf136                   := s_rcvaluebf136;
                    self.s_rcvaluep509                    := s_rcvaluep509;
                    self.s_rcvaluebf141                   := s_rcvaluebf141;
                    self.s_rcvalueb026                    := s_rcvalueb026;
                    self.s_rcvaluebf143                   := s_rcvaluebf143;
                    self.s_rcvaluep526                    := s_rcvaluep526;
                    self.s_rcvalueb063                    := s_rcvalueb063;
                    self.s_rcvalueb066                    := s_rcvalueb066;
                    self.s_rcvaluebf126                   := s_rcvaluebf126;
                    self.s_rcvaluebf127                   := s_rcvaluebf127;
                    self.s_rcvaluebf125                   := s_rcvaluebf125;
                    self.s_rcvaluebf120                   := s_rcvaluebf120;
                    self.s_rcvaluebf105                   := s_rcvaluebf105;
                    self.s_rcvaluebf106                   := s_rcvaluebf106;
                    self.s_rcvaluebf128                   := s_rcvaluebf128;
                    self.s_rcvaluebf129                   := s_rcvaluebf129;
                    self.s_rcvaluebf135                   := s_rcvaluebf135;
                    self.s_rcvaluep502                    := s_rcvaluep502;
                    self.s_rcvalueb053                    := s_rcvalueb053;
                    self.s_rcvalueb052                    := s_rcvalueb052;
                    self.s_rcvalueb055                    := s_rcvalueb055;
                    self.s_rcvalueb059                    := s_rcvalueb059;
                    self.s_final_score                    := s_final_score;
                    self.l_bv_src_id_phn_mth_fs_w         := l_bv_src_id_phn_mth_fs_w;
                    self.l_aa_dist_1                      := l_aa_dist_1;
                    self.l_aa_code_1                      := l_aa_code_1;
                    self.l_bv_sos_mth_fs_w                := l_bv_sos_mth_fs_w;
                    self.l_aa_dist_2                      := l_aa_dist_2;
                    self.l_aa_code_2                      := l_aa_code_2;
                    self.l_bv_lien_judg_index_w           := l_bv_lien_judg_index_w;
                    self.l_aa_dist_3                      := l_aa_dist_3;
                    self.l_aa_code_3                      := l_aa_code_3;
                    self.l_bv_prop_assessed_value_w       := l_bv_prop_assessed_value_w;
                    self.l_aa_dist_4                      := l_aa_dist_4;
                    self.l_aa_code_4                      := l_aa_code_4;
                    self.l_bv_mths_inq_lastseen_w         := l_bv_mths_inq_lastseen_w;
                    self.l_aa_dist_5                      := l_aa_dist_5;
                    self.l_aa_code_5                      := l_aa_code_5;
                    self.l_bv_mth_ver_src_p_ls_w          := l_bv_mth_ver_src_p_ls_w;
                    self.l_aa_dist_6                      := l_aa_dist_6;
                    self.l_aa_code_6                      := l_aa_code_6;
                    self.l_bv_mth_ver_src_q3_fs_w         := l_bv_mth_ver_src_q3_fs_w;
                    self.l_aa_dist_7                      := l_aa_dist_7;
                    self.l_aa_code_7                      := l_aa_code_7;
                    self.l_rv_d30_derog_count_w           := l_rv_d30_derog_count_w;
                    self.l_aa_dist_8                      := l_aa_dist_8;
                    self.l_aa_code_8                      := l_aa_code_8;
                    self.l_rv_d31_bk_chapter_w            := l_rv_d31_bk_chapter_w;
                    self.l_aa_dist_9                      := l_aa_dist_9;
                    self.l_aa_code_9                      := l_aa_code_9;
                    self.l_rv_d34_unrel_liens_ct_w        := l_rv_d34_unrel_liens_ct_w;
                    self.l_aa_dist_10                     := l_aa_dist_10;
                    self.l_aa_code_10                     := l_aa_code_10;
                    self.l_rv_a46_curr_avm_autoval_w      := l_rv_a46_curr_avm_autoval_w;
                    self.l_aa_dist_11                     := l_aa_dist_11;
                    self.l_aa_code_11                     := l_aa_code_11;
                    self.l_rv_a41_a42_prop_owner_hist_w   := l_rv_a41_a42_prop_owner_hist_w;
                    self.l_aa_dist_12                     := l_aa_dist_12;
                    self.l_aa_code_12                     := l_aa_code_12;
                    self.l_rv_e55_college_ind_w           := l_rv_e55_college_ind_w;
                    self.l_aa_dist_13                     := l_aa_dist_13;
                    self.l_aa_code_13                     := l_aa_code_13;
                    self.l_rv_i61_inq_collection_rec_w    := l_rv_i61_inq_collection_rec_w;
                    self.l_aa_dist_14                     := l_aa_dist_14;
                    self.l_aa_code_14                     := l_aa_code_14;
                    self.l_rv_i60_inq_auto_recency_w      := l_rv_i60_inq_auto_recency_w;
                    self.l_aa_dist_15                     := l_aa_dist_15;
                    self.l_aa_code_15                     := l_aa_code_15;
                    self.l_rv_d34_attr_liens_recency_w    := l_rv_d34_attr_liens_recency_w;
                    self.l_aa_dist_16                     := l_aa_dist_16;
                    self.l_aa_code_16                     := l_aa_code_16;
                    self.l_rv_mos_since_br_first_seen_w   := l_rv_mos_since_br_first_seen_w;
                    self.l_aa_dist_17                     := l_aa_dist_17;
                    self.l_aa_code_17                     := l_aa_code_17;
                    self.l_iv_d34_liens_rel_sc_ct_w       := l_iv_d34_liens_rel_sc_ct_w;
                    self.l_aa_dist_18                     := l_aa_dist_18;
                    self.l_aa_code_18                     := l_aa_code_18;
                    self.l_nf_inq_highriskcredit_count_w  := l_nf_inq_highriskcredit_count_w;
                    self.l_aa_dist_19                     := l_aa_dist_19;
                    self.l_aa_code_19                     := l_aa_code_19;
                    self.l_nf_mos_inq_banko_cm_fseen_w    := l_nf_mos_inq_banko_cm_fseen_w;
                    self.l_aa_dist_20                     := l_aa_dist_20;
                    self.l_aa_code_20                     := l_aa_code_20;
                    self.l_nf_mos_acc_lseen_w             := l_nf_mos_acc_lseen_w;
                    self.l_aa_dist_21                     := l_aa_dist_21;
                    self.l_aa_code_21                     := l_aa_code_21;
                    self.l_nf_fp_vardobcountnew_w         := l_nf_fp_vardobcountnew_w;
                    self.l_aa_dist_22                     := l_aa_dist_22;
                    self.l_aa_code_22                     := l_aa_code_22;
                    self.l_nf_fp_srchfraudsrchcountmo_w   := l_nf_fp_srchfraudsrchcountmo_w;
                    self.l_aa_dist_23                     := l_aa_dist_23;
                    self.l_aa_code_23                     := l_aa_code_23;
                    self.l_nf_fp_prevaddrstatus_w         := l_nf_fp_prevaddrstatus_w;
                    self.l_aa_dist_24                     := l_aa_dist_24;
                    self.l_aa_code_24                     := l_aa_code_24;
                    self.l_bv_bus_rep_source_profile_w    := l_bv_bus_rep_source_profile_w;
                    self.l_aa_dist_25                     := l_aa_dist_25;
                    self.l_aa_code_25                     := l_aa_code_25;
                    self.l_bv_rep_only_source_profile_w   := l_bv_rep_only_source_profile_w;
                    self.l_aa_dist_26                     := l_aa_dist_26;
                    self.l_aa_code_26                     := l_aa_code_26;
                    self.l_bv_assoc_derog_flag_w          := l_bv_assoc_derog_flag_w;
                    self.l_aa_dist_27                     := l_aa_dist_27;
                    self.l_aa_code_27                     := l_aa_code_27;
                    self.l_nf_m_bureau_adl_fs_notu_w      := l_nf_m_bureau_adl_fs_notu_w;
                    self.l_aa_dist_28                     := l_aa_dist_28;
                    self.l_aa_code_28                     := l_aa_code_28;
                    self.l_aa_code_29                     := l_aa_code_29;
                    self.l_aa_dist_29                     := l_aa_dist_29;
                    self.l_rcvalueb037                    := l_rcvalueb037;
                    self.l_rcvaluep531                    := l_rcvaluep531;
                    self.l_rcvaluep532                    := l_rcvaluep532;
                    self.l_rcvalueb034                    := l_rcvalueb034;
                    self.l_rcvaluep534                    := l_rcvaluep534;
                    self.l_rcvaluep535                    := l_rcvaluep535;
                    self.l_rcvalueb031                    := l_rcvalueb031;
                    self.l_rcvalueb015                    := l_rcvalueb015;
                    self.l_rcvaluep539                    := l_rcvaluep539;
                    self.l_rcvalueb017                    := l_rcvalueb017;
                    self.l_rcvaluep515                    := l_rcvaluep515;
                    self.l_rcvalueb038                    := l_rcvalueb038;
                    self.l_rcvalueb040                    := l_rcvalueb040;
                    self.l_rcvaluep509                    := l_rcvaluep509;
                    self.l_rcvalueb026                    := l_rcvalueb026;
                    self.l_rcvaluep526                    := l_rcvaluep526;
                    self.l_rcvalueb063                    := l_rcvalueb063;
                    self.l_rcvaluep506                    := l_rcvaluep506;
                    self.l_rcvaluebf108                   := l_rcvaluebf108;
                    self.l_rcvaluep562                    := l_rcvaluep562;
                    self.l_rcvalueb053                    := l_rcvalueb053;
                    self.l_rcvalueb052                    := l_rcvalueb052;
                    self.l_rcvalueb055                    := l_rcvalueb055;
                    self.l_rcvalueb057                    := l_rcvalueb057;
                    self.l_rcvaluep523                    := l_rcvaluep523;
                    self.l_final_score                    := l_final_score;
                    self.u_rv_d30_derog_count_w           := u_rv_d30_derog_count_w;
                    self.u_aa_dist_1                      := u_aa_dist_1;
                    self.u_aa_code_1                      := u_aa_code_1;
                    self.u_rv_d31_attr_bk_recency_w       := u_rv_d31_attr_bk_recency_w;
                    self.u_aa_dist_2                      := u_aa_dist_2;
                    self.u_aa_code_2                      := u_aa_code_2;
                    self.u_rv_d31_bk_disposed_hist_cnt_w  := u_rv_d31_bk_disposed_hist_cnt_w;
                    self.u_aa_dist_3                      := u_aa_dist_3;
                    self.u_aa_code_3                      := u_aa_code_3;
                    self.u_rv_c21_stl_inq_count_w         := u_rv_c21_stl_inq_count_w;
                    self.u_aa_dist_4                      := u_aa_dist_4;
                    self.u_aa_code_4                      := u_aa_code_4;
                    self.u_rv_d33_eviction_recency_w      := u_rv_d33_eviction_recency_w;
                    self.u_aa_dist_5                      := u_aa_dist_5;
                    self.u_aa_code_5                      := u_aa_code_5;
                    self.u_rv_d34_unrel_lien60_count_w    := u_rv_d34_unrel_lien60_count_w;
                    self.u_aa_dist_6                      := u_aa_dist_6;
                    self.u_aa_code_6                      := u_aa_code_6;
                    self.u_rv_c20_m_bureau_adl_fs_w       := u_rv_c20_m_bureau_adl_fs_w;
                    self.u_aa_dist_7                      := u_aa_dist_7;
                    self.u_aa_code_7                      := u_aa_code_7;
                    self.u_rv_a46_curr_avm_autoval_w      := u_rv_a46_curr_avm_autoval_w;
                    self.u_aa_dist_8                      := u_aa_dist_8;
                    self.u_aa_code_8                      := u_aa_code_8;
                    self.u_rv_a49_curr_avm_chg_1yr_pct_w  := u_rv_a49_curr_avm_chg_1yr_pct_w;
                    self.u_aa_dist_9                      := u_aa_dist_9;
                    self.u_aa_code_9                      := u_aa_code_9;
                    self.u_rv_a41_prop_owner_w            := u_rv_a41_prop_owner_w;
                    self.u_aa_dist_10                     := u_aa_dist_10;
                    self.u_aa_code_10                     := u_aa_code_10;
                    self.u_rv_e55_college_ind_w           := u_rv_e55_college_ind_w;
                    self.u_aa_dist_11                     := u_aa_dist_11;
                    self.u_aa_code_11                     := u_aa_code_11;
                    self.u_rv_i61_inq_collection_cnt12_w  := u_rv_i61_inq_collection_cnt12_w;
                    self.u_aa_dist_12                     := u_aa_dist_12;
                    self.u_aa_code_12                     := u_aa_code_12;
                    self.u_rv_l79_adls_per_addr_curr_w    := u_rv_l79_adls_per_addr_curr_w;
                    self.u_aa_dist_13                     := u_aa_dist_13;
                    self.u_aa_code_13                     := u_aa_code_13;
                    self.u_rv_d34_attr_liens_recency_w    := u_rv_d34_attr_liens_recency_w;
                    self.u_aa_dist_14                     := u_aa_dist_14;
                    self.u_aa_code_14                     := u_aa_code_14;
                    self.u_rv_a50_pb_average_dollars_w    := u_rv_a50_pb_average_dollars_w;
                    self.u_aa_dist_15                     := u_aa_dist_15;
                    self.u_aa_code_15                     := u_aa_code_15;
                    self.u_iv_c13_avg_lres_w              := u_iv_c13_avg_lres_w;
                    self.u_aa_dist_16                     := u_aa_dist_16;
                    self.u_aa_code_16                     := u_aa_code_16;
                    self.u_rv_i60_inq_other_recency_w     := u_rv_i60_inq_other_recency_w;
                    self.u_aa_dist_17                     := u_aa_dist_17;
                    self.u_aa_code_17                     := u_aa_code_17;
                    self.u_rv_mos_since_br_first_seen_w   := u_rv_mos_since_br_first_seen_w;
                    self.u_aa_dist_18                     := u_aa_dist_18;
                    self.u_aa_code_18                     := u_aa_code_18;
                    self.u_iv_d34_liens_unrel_cj_ct_w     := u_iv_d34_liens_unrel_cj_ct_w;
                    self.u_aa_dist_19                     := u_aa_dist_19;
                    self.u_aa_code_19                     := u_aa_code_19;
                    self.u_iv_d34_liens_unrel_sc_ct_w     := u_iv_d34_liens_unrel_sc_ct_w;
                    self.u_aa_dist_20                     := u_aa_dist_20;
                    self.u_aa_code_20                     := u_aa_code_20;
                    self.u_nf_inq_auto_count_w            := u_nf_inq_auto_count_w;
                    self.u_aa_dist_21                     := u_aa_dist_21;
                    self.u_aa_code_21                     := u_aa_code_21;
                    self.u_nf_inq_collection_count_w      := u_nf_inq_collection_count_w;
                    self.u_aa_dist_22                     := u_aa_dist_22;
                    self.u_aa_code_22                     := u_aa_code_22;
                    self.u_nf_inq_communications_cnt24_w  := u_nf_inq_communications_cnt24_w;
                    self.u_aa_dist_23                     := u_aa_dist_23;
                    self.u_aa_code_23                     := u_aa_code_23;
                    self.u_nf_inq_highriskcredit_count_w  := u_nf_inq_highriskcredit_count_w;
                    self.u_aa_dist_24                     := u_aa_dist_24;
                    self.u_aa_code_24                     := u_aa_code_24;
                    self.u_nf_mos_inq_banko_cm_fseen_w    := u_nf_mos_inq_banko_cm_fseen_w;
                    self.u_aa_dist_25                     := u_aa_dist_25;
                    self.u_aa_code_25                     := u_aa_code_25;
                    self.u_nf_mos_inq_banko_om_lseen_w    := u_nf_mos_inq_banko_om_lseen_w;
                    self.u_aa_dist_26                     := u_aa_dist_26;
                    self.u_aa_code_26                     := u_aa_code_26;
                    self.u_nf_accident_count_w            := u_nf_accident_count_w;
                    self.u_aa_dist_27                     := u_aa_dist_27;
                    self.u_aa_code_27                     := u_aa_code_27;
                    self.u_nf_fp_vardobcountnew_w         := u_nf_fp_vardobcountnew_w;
                    self.u_aa_dist_28                     := u_aa_dist_28;
                    self.u_aa_code_28                     := u_aa_code_28;
                    self.u_nf_fp_srchunvrfdssncount_w     := u_nf_fp_srchunvrfdssncount_w;
                    self.u_aa_dist_29                     := u_aa_dist_29;
                    self.u_aa_code_29                     := u_aa_code_29;
                    self.u_nf_fp_srchunvrfdaddrcount_w    := u_nf_fp_srchunvrfdaddrcount_w;
                    self.u_aa_dist_30                     := u_aa_dist_30;
                    self.u_aa_code_30                     := u_aa_code_30;
                    self.u_nf_fp_curraddractivephnlist_w  := u_nf_fp_curraddractivephnlist_w;
                    self.u_aa_dist_31                     := u_aa_dist_31;
                    self.u_aa_code_31                     := u_aa_code_31;
                    self.u_bv_rep_only_source_profile_w   := u_bv_rep_only_source_profile_w;
                    self.u_aa_dist_32                     := u_aa_dist_32;
                    self.u_aa_code_32                     := u_aa_code_32;
                    self.u_nf_m_bureau_adl_fs_notu_w      := u_nf_m_bureau_adl_fs_notu_w;
                    self.u_aa_dist_33                     := u_aa_dist_33;
                    self.u_aa_code_33                     := u_aa_code_33;
                    self.u_aa_code_34                     := u_aa_code_34;
                    self.u_aa_dist_34                     := u_aa_dist_34;
                    self.u_rcvaluep523                    := u_rcvaluep523;
                    self.u_rcvaluep509                    := u_rcvaluep509;
                    self.u_rcvaluep532                    := u_rcvaluep532;
                    self.u_rcvaluep502                    := u_rcvaluep502;
                    self.u_rcvaluep534                    := u_rcvaluep534;
                    self.u_rcvaluep535                    := u_rcvaluep535;
                    self.u_rcvaluep531                    := u_rcvaluep531;
                    self.u_rcvaluep524                    := u_rcvaluep524;
                    self.u_rcvaluep516                    := u_rcvaluep516;
                    self.u_rcvaluep539                    := u_rcvaluep539;
                    self.u_rcvaluep515                    := u_rcvaluep515;
                    self.u_rcvaluep512                    := u_rcvaluep512;
                    self.u_rcvaluep511                    := u_rcvaluep511;
                    self.u_rcvaluep538                    := u_rcvaluep538;
                    self.u_rcvaluep550                    := u_rcvaluep550;
                    self.u_rcvalueb067                    := u_rcvalueb067;
                    self.u_rcvaluep549                    := u_rcvaluep549;
                    self.u_rcvaluep562                    := u_rcvaluep562;
                    self.u_rcvaluep526                    := u_rcvaluep526;
                    self.u_final_score                    := u_final_score;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.blend_mod_final_lgt              := blend_mod_final_lgt;
                    self._sbbm1601_0_0                    := _sbbm1601_0_0;
                    self.l_rc1                            := l_rc1;
                    self.l_rc2                            := l_rc2;
                    self.l_rc3                            := l_rc3;
                    self.l_rc4                            := l_rc4;
                    self.l_rc5                            := l_rc5;
                    self.l_rc6                            := l_rc6;
                    self.l_rc7                            := l_rc7;
                    self.l_rc8                            := l_rc8;
                    self.l_rc9                            := l_rc9;
                    self.l_rc10                           := l_rc10;
                    self.l_rc11                           := l_rc11;
                    self.l_rc12                           := l_rc12;
                    self.l_rc13                           := l_rc13;
                    self.l_rc14                           := l_rc14;
                    self.l_rc15                           := l_rc15;
                    self.l_rc16                           := l_rc16;
                    self.l_rc17                           := l_rc17;
                    self.l_rc18                           := l_rc18;
                    self.l_rc19                           := l_rc19;
                    self.l_rc20                           := l_rc20;
                    self.l_rc21                           := l_rc21;
                    self.l_rc22                           := l_rc22;
                    self.l_rc23                           := l_rc23;
                    self.l_rc24                           := l_rc24;
                    self.l_rc25                           := l_rc25;
                    self.l_rc26                           := l_rc26;
                    self.l_rc27                           := l_rc27;
                    self.l_rc28                           := l_rc28;
                    self.l_rc29                           := l_rc29;
                    self.l_rc30                           := l_rc30;
                    self.l_rc31                           := l_rc31;
                    self.l_rc32                           := l_rc32;
                    self.l_rc33                           := l_rc33;
                    self.l_rc34                           := l_rc34;
                    self.l_rc35                           := l_rc35;
                    self.l_rc36                           := l_rc36;
                    self.l_rc37                           := l_rc37;
                    self.l_rc38                           := l_rc38;
                    self.l_rc39                           := l_rc39;
                    self.l_rc40                           := l_rc40;
                    self.l_rc41                           := l_rc41;
                    self.l_rc42                           := l_rc42;
                    self.l_rc43                           := l_rc43;
                    self.l_rc44                           := l_rc44;
                    self.l_rc45                           := l_rc45;
                    self.l_rc46                           := l_rc46;
                    self.l_rc47                           := l_rc47;
                    self.l_rc48                           := l_rc48;
                    self.l_rc49                           := l_rc49;
                    self.l_rc50                           := l_rc50;
                    self.s_rc1                            := s_rc1;
                    self.s_rc2                            := s_rc2;
                    self.s_rc3                            := s_rc3;
                    self.s_rc4                            := s_rc4;
                    self.s_rc5                            := s_rc5;
                    self.s_rc6                            := s_rc6;
                    self.s_rc7                            := s_rc7;
                    self.s_rc8                            := s_rc8;
                    self.s_rc9                            := s_rc9;
                    self.s_rc10                           := s_rc10;
                    self.s_rc11                           := s_rc11;
                    self.s_rc12                           := s_rc12;
                    self.s_rc13                           := s_rc13;
                    self.s_rc14                           := s_rc14;
                    self.s_rc15                           := s_rc15;
                    self.s_rc16                           := s_rc16;
                    self.s_rc17                           := s_rc17;
                    self.s_rc18                           := s_rc18;
                    self.s_rc19                           := s_rc19;
                    self.s_rc20                           := s_rc20;
                    self.s_rc21                           := s_rc21;
                    self.s_rc22                           := s_rc22;
                    self.s_rc23                           := s_rc23;
                    self.s_rc24                           := s_rc24;
                    self.s_rc25                           := s_rc25;
                    self.s_rc26                           := s_rc26;
                    self.s_rc27                           := s_rc27;
                    self.s_rc28                           := s_rc28;
                    self.s_rc29                           := s_rc29;
                    self.s_rc30                           := s_rc30;
                    self.s_rc31                           := s_rc31;
                    self.s_rc32                           := s_rc32;
                    self.s_rc33                           := s_rc33;
                    self.s_rc34                           := s_rc34;
                    self.s_rc35                           := s_rc35;
                    self.s_rc36                           := s_rc36;
                    self.s_rc37                           := s_rc37;
                    self.s_rc38                           := s_rc38;
                    self.s_rc39                           := s_rc39;
                    self.s_rc40                           := s_rc40;
                    self.s_rc41                           := s_rc41;
                    self.s_rc42                           := s_rc42;
                    self.s_rc43                           := s_rc43;
                    self.s_rc44                           := s_rc44;
                    self.s_rc45                           := s_rc45;
                    self.s_rc46                           := s_rc46;
                    self.s_rc47                           := s_rc47;
                    self.s_rc48                           := s_rc48;
                    self.s_rc49                           := s_rc49;
                    self.s_rc50                           := s_rc50;
                    self.u_rc1                            := u_rc1;
                    self.u_rc2                            := u_rc2;
                    self.u_rc3                            := u_rc3;
                    self.u_rc4                            := u_rc4;
                    self.u_rc5                            := u_rc5;
                    self.u_rc6                            := u_rc6;
                    self.u_rc7                            := u_rc7;
                    self.u_rc8                            := u_rc8;
                    self.u_rc9                            := u_rc9;
                    self.u_rc10                           := u_rc10;
                    self.u_rc11                           := u_rc11;
                    self.u_rc12                           := u_rc12;
                    self.u_rc13                           := u_rc13;
                    self.u_rc14                           := u_rc14;
                    self.u_rc15                           := u_rc15;
                    self.u_rc16                           := u_rc16;
                    self.u_rc17                           := u_rc17;
                    self.u_rc18                           := u_rc18;
                    self.u_rc19                           := u_rc19;
                    self.u_rc20                           := u_rc20;
                    self.u_rc21                           := u_rc21;
                    self.u_rc22                           := u_rc22;
                    self.u_rc23                           := u_rc23;
                    self.u_rc24                           := u_rc24;
                    self.u_rc25                           := u_rc25;
                    self.u_rc26                           := u_rc26;
                    self.u_rc27                           := u_rc27;
                    self.u_rc28                           := u_rc28;
                    self.u_rc29                           := u_rc29;
                    self.u_rc30                           := u_rc30;
                    self.u_rc31                           := u_rc31;
                    self.u_rc32                           := u_rc32;
                    self.u_rc33                           := u_rc33;
                    self.u_rc34                           := u_rc34;
                    self.u_rc35                           := u_rc35;
                    self.u_rc36                           := u_rc36;
                    self.u_rc37                           := u_rc37;
                    self.u_rc38                           := u_rc38;
                    self.u_rc39                           := u_rc39;
                    self.u_rc40                           := u_rc40;
                    self.u_rc41                           := u_rc41;
                    self.u_rc42                           := u_rc42;
                    self.u_rc43                           := u_rc43;
                    self.u_rc44                           := u_rc44;
                    self.u_rc45                           := u_rc45;
                    self.u_rc46                           := u_rc46;
                    self.u_rc47                           := u_rc47;
                    self.u_rc48                           := u_rc48;
                    self.u_rc49                           := u_rc49;
                    self.u_rc50                           := u_rc50;
                    self.blend_mod_rc41                   := blend_mod_rc41;
                    self.blend_mod_rc36                   := blend_mod_rc36;
                    self.blend_mod_rc45                   := blend_mod_rc45;
                    self.blend_mod_rc35                   := blend_mod_rc35;
                    self.blend_mod_rc3                    := blend_mod_rc3;
                    self.blend_mod_rc42                   := blend_mod_rc42;
                    self.blend_mod_rc46                   := blend_mod_rc46;
                    self.blend_mod_rc19                   := blend_mod_rc19;
                    self.blend_mod_rc2                    := blend_mod_rc2;
                    self.blend_mod_rc33                   := blend_mod_rc33;
                    self.blend_mod_rc16                   := blend_mod_rc16;
                    self.blend_mod_rc8                    := blend_mod_rc8;
                    self.blend_mod_rc40                   := blend_mod_rc40;
                    self.blend_mod_rc32                   := blend_mod_rc32;
                    self.blend_mod_rc38                   := blend_mod_rc38;
                    self.blend_mod_rc29                   := blend_mod_rc29;
                    self.blend_mod_rc20                   := blend_mod_rc20;
                    self.blend_mod_rc9                    := blend_mod_rc9;
                    self.blend_mod_rc26                   := blend_mod_rc26;
                    self.blend_mod_rc34                   := blend_mod_rc34;
                    self.blend_mod_rc39                   := blend_mod_rc39;
                    self.blend_mod_rc5                    := blend_mod_rc5;
                    self.blend_mod_rc30                   := blend_mod_rc30;
                    self.sbbm1601_0_0                     := sbbm1601_0_0;
                    self.blend_mod_rc13                   := blend_mod_rc13;
                    self.blend_mod_rc24                   := blend_mod_rc24;
                    self.blend_mod_rc12                   := blend_mod_rc12;
                    self.blend_mod_rc44                   := blend_mod_rc44;
                    self.blend_mod_rc48                   := blend_mod_rc48;
                    self.blend_mod_rc23                   := blend_mod_rc23;
                    self.blend_mod_rc50                   := blend_mod_rc50;
                    self.blend_mod_rc31                   := blend_mod_rc31;
                    self.blend_mod_rc22                   := blend_mod_rc22;
                    self.blend_mod_rc47                   := blend_mod_rc47;
                    self.blend_mod_rc18                   := blend_mod_rc18;
                    self.blend_mod_rc25                   := blend_mod_rc25;
                    self.blend_mod_rc49                   := blend_mod_rc49;
                    self.blend_mod_rc43                   := blend_mod_rc43;
                    self.blend_mod_rc10                   := blend_mod_rc10;
                    self.blend_mod_rc17                   := blend_mod_rc17;
                    self.blend_mod_rc11                   := blend_mod_rc11;
                    self.blend_mod_rc27                   := blend_mod_rc27;
                    self.blend_mod_rc37                   := blend_mod_rc37;
                    self.blend_mod_rc21                   := blend_mod_rc21;
                    self.blend_mod_rc15                   := blend_mod_rc15;
                    self.blend_mod_rc6                    := blend_mod_rc6;
                    self.blend_mod_rc1                    := blend_mod_rc1;
                    self.blend_mod_rc28                   := blend_mod_rc28;
                    self.blend_mod_rc14                   := blend_mod_rc14;
                    self.blend_mod_rc7                    := blend_mod_rc7;
                    self.blend_mod_rc4                    := blend_mod_rc4;
                    self.sbbm_rc1                         := sbbm_rc1;
                    self.sbbm_rc2                         := sbbm_rc2;
                    self.sbbm_rc4                         := sbbm_rc4;
                    self.sbbm_rc3                         := sbbm_rc3;

										SELF.clam := ri;
										SELF.busShell := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)sbbm1601_0_0;
		SELF.seq := le.input_echo.seq;
	#end
	END;

	//model := PROJECT(clam, doModel(LEFT));
		model := JOIN(BusShell, Clam, LEFT.Input_Echo.seq = RIGHT.seq, doModel(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	RETURN(model);
END;
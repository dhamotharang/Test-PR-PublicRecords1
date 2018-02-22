//Axcess Financial - custom Fraudpoint model FP1404_1

import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1404_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION

FP_DEBUG := false;
	
	#if(FP_DEBUG)
		Layout_Debug := RECORD, maxlength(64236)
		/* Model Input Variables */
		STRING sysdate;
		STRING ssnpop;
		STRING ver_src_ds;
		STRING ver_src_eq;
		STRING ver_src_en;
		STRING ver_src_tn;
		STRING ver_src_tu;
		STRING ver_src_cnt;
		STRING credit_source_cnt;
		STRING bureauonly2;
		STRING _derog;
		STRING iv_add_apt;
		STRING _in_dob;
		STRING yr_in_dob;
		STRING yr_in_dob_int;
		STRING age_estimate;
		STRING iv_vp091_phnzip_mismatch;
		STRING iv_vp001_phn_not_issued;
		STRING iv_vp008_phn_pay_phone;
		STRING iv_vp050_phn_cmp_pcs;
		STRING iv_vp100_phn_prob;
		STRING iv_va001_add_po_box;
		STRING iv_va008_add_throwback;
		STRING add_ec1;
		STRING add_ec3;
		STRING add_ec4;
		STRING iv_va100_add_problem;
		STRING iv_po001_inp_addr_naprop;
		STRING iv_in001_wealth_index;
		STRING iv_in001_college_income;
		STRING iv_ed001_college_ind_26;
		STRING iv_ed001_college_ind_29;
		STRING iv_ed001_college_ind_36;
		STRING iv_ed001_college_ind_37;
		STRING iv_ed001_college_ind_40;
		STRING iv_ed001_college_ind_50;
		STRING iv_ed001_college_ind_60;
		STRING iv_phnpop_x_nap_summary;
		STRING iv_nap_status;
		STRING iv_dl_val_flag;
		STRING nf_bus_name_match;
		STRING nf_bus_phone_match;
		STRING iv_fname_eda_sourced_type;
		STRING iv_lname_eda_sourced_type;
		STRING iv_addr_ver_sources;
		STRING iv_input_dob_match_level;
		STRING iv_ssn_miskey;
		STRING iv_phn_miskey;
		STRING iv_dwelltype;
		STRING nf_adl_util_convenience;
		STRING nf_add1_util_convenience;
		STRING iv_inp_addr_ownership_lvl;
		STRING iv_inp_own_prop_x_addr_naprop;
		STRING iv_inp_addr_mortgage_term;
		STRING iv_inp_addr_mortgage_type;
		STRING iv_inp_addr_financing_type;
		STRING iv_bst_addr_naprop;
		STRING iv_bst_own_prop_x_addr_naprop;
		STRING _add1_mortgage_date;
		STRING _add1_mortgage_due_date;
		STRING iv_bst_addr_mortgage_term;
		STRING iv_bst_addr_mortgage_type;
		STRING iv_bst_addr_financing_type;
		STRING iv_bst_addr_avm_land_use;
		STRING iv_prv_addr_ownership_lvl;
		STRING iv_prv_addr_eda_sourced;
		STRING iv_prv_own_prop_x_addr_naprop;
		STRING _add2_mortgage_date;
		STRING _add2_mortgage_due_date;
		STRING _add3_mortgage_date;
		STRING _add3_mortgage_due_date;
		STRING mortgage_date_diff;
		STRING iv_prv_addr_mortgage_term;
		STRING mortgage_type;
		STRING mortgage_present;
		STRING iv_prv_addr_mortgage_type;
		STRING iv_gong_did_fname_x_lname_ct;
		STRING iv_paw_dead_bus_x_active_phn;
		STRING iv_infutor_nap;
		STRING ver_phn_inf;
		STRING ver_phn_nap;
		STRING inf_phn_ver_lvl;
		STRING nap_phn_ver_lvl;
		STRING iv_nap_phn_ver_x_inf_phn_ver;
		STRING iv_num_purch_x_num_sold_60;
		STRING iv_rec_vehx_level;
		STRING iv_liens_unrel_x_rel;
		STRING iv_criminal_x_felony;
		STRING ams_major_medical;
		STRING ams_major_science;
		STRING ams_major_liberal;
		STRING ams_major_business;
		STRING ams_major_unknown;
		STRING iv_ams_college_major;
		STRING iv_ams_college_tier;
		STRING iv_prof_license_category;
		STRING sum_dols;
		STRING pct_offline_dols;
		STRING pct_retail_dols;
		STRING pct_online_dols;
		STRING iv_pb_profile;
		STRING iv_pb_order_freq;
		STRING nf_fp_idrisktype;
		STRING nf_fp_idverrisktype;
		STRING nf_fp_idveraddressnotcurrent;
		STRING nf_fp_sourcerisktype;
		STRING nf_fp_varrisktype;
		STRING nf_fp_srchvelocityrisktype;
		STRING nf_fp_assocrisktype;
		STRING nf_fp_validationrisktype;
		STRING nf_fp_corrrisktype;
		STRING nf_fp_divrisktype;
		STRING nf_fp_srchcomponentrisktype;
		STRING nf_fp_componentcharrisktype;
		STRING nf_fp_addrchangeecontrajindex;
		STRING nf_fp_prevaddrdwelltype;
		STRING nf_fp_prevaddroccupantowned;
		STRING iv_va060_dist_add_in_bst;
		STRING _criminal_last_date;
		STRING iv_dc001_mos_since_crim_ls;
		STRING _felony_last_date;
		STRING iv_df001_mos_since_fel_ls;
		STRING iv_dg001_derog_count;
		STRING iv_de001_eviction_recency;
		STRING email_src_im;
		STRING iv_ds001_impulse_count;
		STRING iv_dl001_unrel_lien60_count;
		STRING lien_adl_li_lseen_pos;
		STRING lien_adl_lseen_li;
		STRING _lien_adl_lseen_li;
		STRING lien_adl_l2_lseen_pos;
		STRING lien_adl_lseen_l2;
		STRING _lien_adl_lseen_l2;
		STRING _src_lien_adl_lseen;
		STRING iv_dl001_lien_last_seen;
		STRING bureau_adl_tn_fseen_pos;
		STRING bureau_adl_fseen_tn;
		STRING _bureau_adl_fseen_tn;
		STRING bureau_adl_ts_fseen_pos;
		STRING bureau_adl_fseen_ts;
		STRING _bureau_adl_fseen_ts;
		STRING bureau_adl_tu_fseen_pos;
		STRING bureau_adl_fseen_tu;
		STRING _bureau_adl_fseen_tu;
		STRING bureau_adl_en_fseen_pos;
		STRING bureau_adl_fseen_en;
		STRING _bureau_adl_fseen_en;
		STRING bureau_adl_eq_fseen_pos;
		STRING bureau_adl_fseen_eq;
		STRING _bureau_adl_fseen_eq;
		STRING iv_sr001_m_bureau_adl_fs;
		STRING bureau_adl_vo_fseen_pos;
		STRING bureau_adl_fseen_vo;
		STRING _bureau_adl_fseen_vo;
		STRING _src_bureau_adl_fseen;
		STRING mth_ver_src_fdate_vo;
		STRING bureau_adl_vo_lseen_pos;
		STRING bureau_adl_lseen_vo;
		STRING _bureau_adl_lseen_vo;
		STRING mth_ver_src_ldate_vo;
		STRING mth_ver_src_fdate_vo60;
		STRING mth_ver_src_ldate_vo0;
		STRING bureau_adl_w_lseen_pos;
		STRING bureau_adl_lseen_w;
		STRING _bureau_adl_lseen_w;
		STRING mth_ver_src_ldate_w;
		STRING mth_ver_src_ldate_w0;
		STRING bureau_adl_wp_lseen_pos;
		STRING bureau_adl_lseen_wp;
		STRING _bureau_adl_lseen_wp;
		STRING _src_bureau_adl_lseen;
		STRING mth_ver_src_ldate_wp;
		STRING mth_ver_src_ldate_wp0;
		STRING _paw_first_seen;
		STRING mth_paw_first_seen;
		STRING mth_paw_first_seen2;
		STRING ver_src_am;
		STRING ver_src_e1;
		STRING ver_src_e2;
		STRING ver_src_e3;
		STRING ver_src_pl;
		STRING ver_src_w;
		STRING paw_dead_business_count_gt3;
		STRING paw_active_phone_count_0;
		STRING mth_infutor_first_seen;
		STRING mth_infutor_last_seen;
		STRING infutor_i;
		STRING infutor_im;
		STRING white_pages_adl_wp_fseen_pos;
		STRING white_pages_adl_fseen_wp;
		STRING _white_pages_adl_fseen_wp;
		STRING _src_white_pages_adl_fseen;
		STRING iv_sr001_m_wp_adl_fs;
		STRING src_m_wp_adl_fs;
		STRING _header_first_seen;
		STRING iv_sr001_m_hdr_fs;
		STRING src_m_hdr_fs;
		STRING source_mod6;
		STRING iv_sr001_source_profile;
		STRING iv_ms001_ssns_per_adl;
		STRING iv_pv001_inp_avm_autoval;
		STRING iv_pv001_bst_avm_autoval;
		STRING bst_addr_avm_auto_val_2;
		STRING iv_pv001_bst_avm_chg_1yr;
		STRING iv_pv001_bst_avm_chg_1yr_pct;
		STRING inp_addr_date_first_seen;
		STRING iv_pl001_m_snc_in_addr_fs;
		STRING iv_pl001_bst_addr_lres;
		STRING iv_pl002_avg_mo_per_addr;
		STRING iv_iq001_inq_count12;
		STRING bureau_ssn_tn_count_pos;
		STRING bureau_ssn_count_tn;
		STRING bureau_ssn_ts_count_pos;
		STRING bureau_ssn_count_ts;
		STRING bureau_ssn_tu_count_pos;
		STRING bureau_ssn_count_tu;
		STRING bureau_ssn_en_count_pos;
		STRING bureau_ssn_count_en;
		STRING bureau_ssn_eq_count_pos;
		STRING bureau_ssn_count_eq;
		STRING _src_bureau_ssn_count;
		STRING iv_src_bureau_ssn_count;
		STRING bureau_ssn_tn_fseen_pos;
		STRING bureau_ssn_fseen_tn;
		STRING _bureau_ssn_fseen_tn;
		STRING bureau_ssn_ts_fseen_pos;
		STRING bureau_ssn_fseen_ts;
		STRING _bureau_ssn_fseen_ts;
		STRING bureau_ssn_tu_fseen_pos;
		STRING bureau_ssn_fseen_tu;
		STRING _bureau_ssn_fseen_tu;
		STRING bureau_ssn_en_fseen_pos;
		STRING bureau_ssn_fseen_en;
		STRING _bureau_ssn_fseen_en;
		STRING bureau_ssn_eq_fseen_pos;
		STRING bureau_ssn_fseen_eq;
		STRING _bureau_ssn_fseen_eq;
		STRING _src_bureau_ssn_fseen;
		STRING iv_mos_src_bureau_ssn_fseen;
		STRING bureau_addr_tn_count_pos;
		STRING bureau_addr_count_tn;
		STRING bureau_addr_ts_count_pos;
		STRING bureau_addr_count_ts;
		STRING bureau_addr_tu_count_pos;
		STRING bureau_addr_count_tu;
		STRING bureau_addr_en_count_pos;
		STRING bureau_addr_count_en;
		STRING bureau_addr_eq_count_pos;
		STRING bureau_addr_count_eq;
		STRING _src_bureau_addr_count;
		STRING iv_src_bureau_addr_count;
		STRING bureau_addr_tn_fseen_pos;
		STRING bureau_addr_fseen_tn;
		STRING _bureau_addr_fseen_tn;
		STRING bureau_addr_ts_fseen_pos;
		STRING bureau_addr_fseen_ts;
		STRING _bureau_addr_fseen_ts;
		STRING bureau_addr_tu_fseen_pos;
		STRING bureau_addr_fseen_tu;
		STRING _bureau_addr_fseen_tu;
		STRING bureau_addr_en_fseen_pos;
		STRING bureau_addr_fseen_en;
		STRING _bureau_addr_fseen_en;
		STRING bureau_addr_eq_fseen_pos;
		STRING bureau_addr_fseen_eq;
		STRING _bureau_addr_fseen_eq;
		STRING _src_bureau_addr_fseen;
		STRING iv_mos_src_bureau_addr_fseen;
		STRING bureau_lname_tn_count_pos;
		STRING bureau_lname_count_tn;
		STRING bureau_lname_ts_count_pos;
		STRING bureau_lname_count_ts;
		STRING bureau_lname_tu_count_pos;
		STRING bureau_lname_count_tu;
		STRING bureau_lname_en_count_pos;
		STRING bureau_lname_count_en;
		STRING bureau_lname_eq_count_pos;
		STRING bureau_lname_count_eq;
		STRING _src_bureau_lname_count;
		STRING iv_src_bureau_lname_count;
		STRING bureau_lname_tn_fseen_pos;
		STRING bureau_lname_fseen_tn;
		STRING _bureau_lname_fseen_tn;
		STRING bureau_lname_ts_fseen_pos;
		STRING bureau_lname_fseen_ts;
		STRING _bureau_lname_fseen_ts;
		STRING bureau_lname_tu_fseen_pos;
		STRING bureau_lname_fseen_tu;
		STRING _bureau_lname_fseen_tu;
		STRING bureau_lname_en_fseen_pos;
		STRING bureau_lname_fseen_en;
		STRING _bureau_lname_fseen_en;
		STRING bureau_lname_eq_fseen_pos;
		STRING bureau_lname_fseen_eq;
		STRING _bureau_lname_fseen_eq;
		STRING _src_bureau_lname_fseen;
		STRING iv_mos_src_bureau_lname_fseen;
		STRING bureau_dob_tn_count_pos;
		STRING bureau_dob_count_tn;
		STRING bureau_dob_ts_count_pos;
		STRING bureau_dob_count_ts;
		STRING bureau_dob_tu_count_pos;
		STRING bureau_dob_count_tu;
		STRING bureau_dob_en_count_pos;
		STRING bureau_dob_count_en;
		STRING bureau_dob_eq_count_pos;
		STRING bureau_dob_count_eq;
		STRING _src_bureau_dob_count;
		STRING iv_src_bureau_dob_count;
		STRING bureau_dob_tn_fseen_pos;
		STRING bureau_dob_fseen_tn;
		STRING _bureau_dob_fseen_tn;
		STRING bureau_dob_ts_fseen_pos;
		STRING bureau_dob_fseen_ts;
		STRING _bureau_dob_fseen_ts;
		STRING bureau_dob_tu_fseen_pos;
		STRING bureau_dob_fseen_tu;
		STRING _bureau_dob_fseen_tu;
		STRING bureau_dob_en_fseen_pos;
		STRING bureau_dob_fseen_en;
		STRING _bureau_dob_fseen_en;
		STRING bureau_dob_eq_fseen_pos;
		STRING bureau_dob_fseen_eq;
		STRING _bureau_dob_fseen_eq;
		STRING _src_bureau_dob_fseen;
		STRING iv_mos_src_bureau_dob_fseen;
		STRING lien_adl_li_count_pos;
		STRING lien_adl_count_li;
		STRING lien_adl_l2_count_pos;
		STRING lien_adl_count_l2;
		STRING _src_lien_adl_count;
		STRING iv_src_liens_adl_count;
		STRING prop_adl_p_count_pos;
		STRING prop_adl_count_p;
		STRING _src_prop_adl_count;
		STRING iv_src_property_adl_count;
		STRING voter_adl_v_count_pos;
		STRING iv_src_voter_adl_count;
		STRING vote_adl_vo_lseen_pos;
		STRING vote_adl_lseen_vo;
		STRING _vote_adl_lseen_vo;
		STRING _src_vote_adl_lseen;
		STRING iv_mos_src_voter_adl_lseen;
		STRING emerge_adl_em_count_pos;
		STRING emerge_adl_count_em;
		STRING emerge_adl_e1_count_pos;
		STRING emerge_adl_count_e1;
		STRING emerge_adl_e2_count_pos;
		STRING emerge_adl_count_e2;
		STRING emerge_adl_e3_count_pos;
		STRING emerge_adl_count_e3;
		STRING emerge_adl_e4_count_pos;
		STRING emerge_adl_count_e4;
		STRING iv_src_emerge_adl_count;
		STRING nf_bus_addr_match_count;
		STRING iv_fname_non_phn_src_ct;
		STRING iv_full_name_non_phn_src_ct;
		STRING iv_addr_non_phn_src_ct;
		STRING iv_ssn_non_phn_src_ct;
		STRING iv_ssn_score;
		STRING iv_dob_src_ct;
		STRING _reported_dob;
		STRING reported_age;
		STRING _rc_ssnlowissue;
		STRING iv_age_at_low_issue;
		STRING _rc_ssnhighissue;
		STRING iv_age_at_high_issue;
		STRING nf_util_adl_count;
		STRING iv_inp_addr_address_score;
		STRING iv_inp_addr_lres;
		STRING iv_inp_addr_assessed_total_val;
		STRING iv_inp_addr_building_area;
		STRING inp_addr_nhood_properties_sum;
		STRING inp_addr_nhood_vac_props;
		STRING nf_inp_addr_nhood_pct_vacant;
		STRING iv_inp_addr_avm_pct_change_1yr;
		STRING iv_inp_addr_avm_change_1yr;
		STRING iv_inp_addr_avm_pct_change_2yr;
		STRING iv_inp_addr_avm_change_2yr;
		STRING bst_addr_avm_auto_val;
		STRING bst_addr_mortgage_amount;
		STRING iv_bst_addr_mtg_avm_abs_diff;
		STRING iv_bst_addr_assessed_total_val;
		STRING bst_addr_date_first_seen;
		STRING iv_mos_since_bst_addr_fseen;
		STRING bst_addr_nhood_properties_sum;
		STRING bst_addr_nhood_mfd_props;
		STRING nf_bst_addr_nhood_pct_mfd;
		STRING iv_bst_addr_avm_change_2yr;
		STRING bst_addr_avm_auto_val_3;
		STRING iv_bst_addr_avm_pct_change_2yr;
		STRING bst_addr_avm_auto_val_4;
		STRING bst_addr_avm_auto_val_1;
		STRING iv_bst_addr_avm_change_3yr;
		STRING iv_prv_addr_lres;
		STRING iv_prv_addr_avm_auto_val;
		STRING iv_prv_addr_source_count;
		STRING iv_prv_addr_assessed_total_val;
		STRING prv_addr_date_first_seen;
		STRING iv_mos_since_prv_addr_fseen;
		STRING prv_addr_date_last_seen;
		STRING iv_mos_since_prv_addr_lseen;
		STRING iv_purch_sold_val_diff;
		STRING iv_prop2_purch_sale_diff;
		STRING iv_dist_bst_addr_to_prv_addr;
		STRING iv_dist_inp_addr_to_prv_addr;
		STRING iv_avg_lres;
		STRING iv_max_lres;
		STRING iv_addr_lres_6mo_count;
		STRING iv_addr_lres_12mo_count;
		STRING iv_hist_addr_match;
		STRING iv_avg_num_sources_per_addr;
		STRING _gong_did_first_seen;
		STRING iv_mos_since_gong_did_fst_seen;
		STRING iv_gong_did_phone_ct;
		STRING iv_addrs_per_adl;
		STRING iv_lnames_per_adl;
		STRING iv_adls_per_addr;
		STRING iv_adls_per_apt_addr;
		STRING iv_ssns_per_sfd_addr;
		STRING iv_phones_per_sfd_addr;
		STRING iv_adls_per_addr_c6;
		STRING iv_adls_per_sfd_addr_c6;
		STRING iv_ssns_per_addr_c6;
		STRING iv_ssns_per_sfd_addr_c6;
		STRING iv_max_ids_per_sfd_addr_c6;
		STRING iv_dl_addrs_per_adl;
		STRING iv_vo_addrs_per_adl;
		STRING iv_invalid_addrs_per_adl;
		STRING iv_inq_recency;
		STRING iv_inq_collection_count12;
		STRING iv_inq_collection_recency;
		STRING iv_inq_auto_count12;
		STRING iv_inq_auto_recency;
		STRING iv_inq_banking_count12;
		STRING iv_inq_banking_recency;
		STRING iv_inq_highriskcredit_count12;
		STRING iv_inq_highriskcredit_recency;
		STRING iv_inq_communications_recency;
		STRING iv_inq_other_count12;
		STRING iv_inq_other_recency;
		STRING iv_inq_addrs_per_adl;
		STRING iv_inq_num_diff_names_per_adl;
		STRING iv_inq_phones_per_adl;
		STRING iv_inq_per_addr;
		STRING iv_inq_adls_per_addr;
		STRING iv_inq_lnames_per_addr;
		STRING iv_inq_ssns_per_addr;
		STRING iv_inq_adls_per_phone;
		STRING _infutor_first_seen;
		STRING iv_mos_since_infutor_first_seen;
		STRING _infutor_last_seen;
		STRING iv_mos_since_infutor_last_seen;
		STRING _impulse_first_seen;
		STRING iv_mos_since_impulse_first_seen;
		STRING _impulse_last_seen;
		STRING iv_mos_since_impulse_last_seen;
		STRING iv_impulse_annual_income;
		STRING iv_email_count;
		STRING iv_all_email_domain_free;
		STRING iv_attr_purchase_recency;
		STRING iv_attr_felonies_recency;
		STRING iv_attr_arrests_recency;
		STRING iv_attr_rel_liens_recency;
		STRING iv_attr_bankruptcy_recency;
		STRING iv_eviction_count;
		STRING iv_attr_proflic_recency;
		STRING iv_non_derog_count;
		STRING iv_filing_count;
		STRING iv_unreleased_liens_ct;
		STRING iv_liens_unrel_cj_ct;
		STRING iv_criminal_count;
		STRING nf_rel_count;
		STRING nf_average_rel_income;
		STRING nf_lowest_rel_income;
		STRING nf_highest_rel_income;
		STRING nf_average_rel_home_val;
		STRING nf_oldest_rel_age;
		STRING nf_average_rel_criminal_dist;
		STRING nf_average_rel_distance;
		STRING nf_closest_rel_distance;
		STRING nf_rel_felony_count;
		STRING nf_rel_derog_summary;
		STRING nf_accident_recency;
		STRING iv_pb_average_dollars;
		STRING iv_pb_total_dollars;
		STRING nf_fp_varmsrcssncount;
		STRING nf_fp_varmsrcssnunrelcount;
		STRING nf_fp_srchcountwk;
		STRING nf_fp_srchunvrfdaddrcount;
		STRING nf_fp_srchunvrfddobcount;
		STRING nf_fp_srchfraudsrchcount;
		STRING nf_fp_srchfraudsrchcountyr;
		STRING nf_fp_srchfraudsrchcountmo;
		STRING nf_fp_srchfraudsrchcountwk;
		STRING nf_fp_assocsuspicousidcount;
		STRING nf_fp_assoccredbureaucount;
		STRING nf_fp_assoccredbureaucountnew;
		STRING nf_fp_corrssnnamecount;
		STRING nf_fp_corrssnaddrcount;
		STRING nf_fp_corraddrnamecount;
		STRING nf_fp_corraddrphonecount;
		STRING nf_fp_corrphonelastnamecount;
		STRING nf_fp_divaddrsuspidcountnew;
		STRING nf_fp_divsrchaddrsuspidcount;
		STRING nf_fp_srchssnsrchcount;
		STRING nf_fp_srchssnsrchcountmo;
		STRING nf_fp_srchaddrsrchcount;
		STRING nf_fp_srchaddrsrchcountmo;
		STRING nf_fp_srchaddrsrchcountwk;
		STRING nf_fp_srchphonesrchcount;
		STRING nf_fp_srchphonesrchcountmo;
		STRING nf_fp_addrchangeincomediff;
		STRING nf_fp_addrchangevaluediff;
		STRING nf_fp_curraddrmedianincome;
		STRING nf_fp_curraddrmedianvalue;
		STRING nf_fp_curraddrmurderindex;
		STRING nf_fp_curraddrcartheftindex;
		STRING nf_fp_curraddrcrimeindex;
		STRING nf_fp_prevaddrageoldest;
		STRING nf_fp_prevaddrlenofres;
		STRING nf_fp_prevaddrmedianincome;
		STRING nf_fp_prevaddrmedianvalue;
		STRING nf_fp_prevaddrcartheftindex;
		STRING nf_fp_prevaddrburglaryindex;
		STRING nf_fp_prevaddrcrimeindex;
		STRING fp_segment;
		STRING iv_vs002_ssn_prior_dob;
		STRING iv_vs100_ssn_problem;
		STRING iv_db001_bankruptcy;
		STRING iv_nas_summary;
		STRING iv_cvi;
		STRING iv_best_match_address;
		STRING iv_ag001_age;
		STRING iv_pl002_addrs_per_ssn_c6;
		STRING iv_combined_age;
		STRING iv_avg_prop_sold_purch_amt;
		STRING iv_inq_per_ssn;

		// REAL N0_2;
		// REAL N0_3;
		// REAL N0_4;
		// REAL N0_5;
		// REAL N1_2;
		// REAL N1_3;
		// REAL N1_4;
		// REAL N1_5;
		// REAL N1_6;
		// REAL N2_2;
		// REAL N2_3;
		// REAL N2_4;
		// REAL N2_5;
		// REAL N2_6;
		// REAL N3_2;
		// REAL N3_3;
		// REAL N3_4;
		// REAL N3_5;
		// REAL N4_2;
		// REAL N4_3;
		// REAL N4_4;
		// REAL N4_5;
		// REAL N5_2;
		// REAL N5_3;
		// REAL N5_4;
		// REAL N5_5;
		// REAL N5_6;
		// REAL N5_7;
		// REAL N6_2;
		// REAL N6_3;
		// REAL N6_4;
		// REAL N6_5;
		// REAL N6_6;
		// REAL N6_7;
		// REAL N7_2;
		// REAL N7_3;
		// REAL N7_4;
		// REAL N7_5;
		// REAL N8_2;
		// REAL N8_3;
		// REAL N8_4;
		// REAL N8_5;
		// REAL N8_6;
		// REAL N8_7;
		// REAL N8_8;
		// REAL N9_2;
		// REAL N9_3;
		// REAL N9_4;
		// REAL N9_5;
		// REAL N9_6;
		// REAL N10_2;
		// REAL N10_3;
		// REAL N10_4;
		// REAL N10_5;
		// REAL N11_2;
		// REAL N11_3;
		// REAL N11_4;
		// REAL N11_5;
		// REAL N11_6;
		// REAL N11_7;
		// REAL N12_2;
		// REAL N12_3;
		// REAL N12_4;
		// REAL N12_5;
		// REAL N12_6;
		// REAL N12_7;
		// REAL N13_2;
		// REAL N13_3;
		// REAL N13_4;
		// REAL N13_5;
		// REAL N13_6;
		// REAL N13_7;
		// REAL N14_2;
		// REAL N14_3;
		// REAL N14_4;
		// REAL N14_5;
		// REAL N14_6;
		// REAL N14_7;
		// REAL N14_8;
		// REAL N15_2;
		// REAL N15_3;
		// REAL N15_4;
		// REAL N15_5;
		// REAL N15_6;
		// REAL N15_7;
		// REAL N16_2;
		// REAL N16_3;
		// REAL N16_4;
		// REAL N16_5;
		// REAL N16_6;
		// REAL N17_2;
		// REAL N17_3;
		// REAL N17_4;
		// REAL N17_5;
		// REAL N18_2;
		// REAL N18_3;
		// REAL N18_4;
		// REAL N18_5;
		// REAL N18_6;
		// REAL N19_2;
		// REAL N19_3;
		// REAL N19_4;
		// REAL N19_5;
		// REAL N19_6;
		// REAL N19_7;
		// REAL N20_2;
		// REAL N20_3;
		// REAL N20_4;
		// REAL N20_5;
		// REAL N20_6;
		// REAL N20_7;
		// REAL N21_2;
		// REAL N21_3;
		// REAL N21_4;
		// REAL N21_5;
		// REAL N21_6;
		// REAL N21_7;
		// REAL N22_2;
		// REAL N22_3;
		// REAL N22_4;
		// REAL N22_5;
		// REAL N22_6;
		// REAL N23_2;
		// REAL N23_3;
		// REAL N23_4;
		// REAL N23_5;
		// REAL N23_6;
		// REAL N23_7;
		// REAL N24_2;
		// REAL N24_3;
		// REAL N24_4;
		// REAL N24_5;
		// REAL N24_6;
		// REAL N24_7;
		// REAL N25_2;
		// REAL N25_3;
		// REAL N25_4;
		// REAL N25_5;
		// REAL N25_6;
		// REAL N25_7;
		// REAL N26_2;
		// REAL N26_3;
		// REAL N26_4;
		// REAL N26_5;
		// REAL N26_6;
		// REAL N26_7;
		// REAL N27_2;
		// REAL N27_3;
		// REAL N27_4;
		// REAL N27_5;
		// REAL N27_6;
		// REAL N28_2;
		// REAL N28_3;
		// REAL N28_4;
		// REAL N28_5;
		// REAL N28_6;
		// REAL N28_7;
		// REAL N28_8;
		// REAL N29_2;
		// REAL N29_3;
		// REAL N29_4;
		// REAL N29_5;
		// REAL N29_6;
		// REAL N29_7;
		// REAL N29_8;
		// REAL N29_9;
		// REAL N30_2;
		// REAL N30_3;
		// REAL N30_4;
		// REAL N30_5;
		// REAL N30_6;
		// REAL N31_2;
		// REAL N31_3;
		// REAL N31_4;
		// REAL N31_5;
		// REAL N31_6;
		// REAL N31_7;
		// REAL N32_2;
		// REAL N32_3;
		// REAL N32_4;
		// REAL N32_5;
		// REAL N32_6;
		// REAL N33_2;
		// REAL N33_3;
		// REAL N33_4;
		// REAL N33_5;
		// REAL N33_6;
		// REAL N33_7;
		// REAL N34_2;
		// REAL N34_3;
		// REAL N34_4;
		// REAL N34_5;
		// REAL N34_6;
		// REAL N35_2;
		// REAL N35_3;
		// REAL N35_4;
		// REAL N35_5;
		// REAL N35_6;
		// REAL N36_2;
		// REAL N36_3;
		// REAL N36_4;
		// REAL N36_5;
		// REAL N36_6;
		// REAL N36_7;
		// REAL N37_2;
		// REAL N37_3;
		// REAL N37_4;
		// REAL N37_5;
		// REAL N37_6;
		// REAL N37_7;
		// REAL N37_8;
		// REAL N38_2;
		// REAL N38_3;
		// REAL N38_4;
		// REAL N38_5;
		// REAL N38_6;
		// REAL N38_7;
		// REAL N39_2;
		// REAL N39_3;
		// REAL N39_4;
		// REAL N39_5;
		// REAL N39_6;
		// REAL N39_7;
		// REAL N40_2;
		// REAL N40_3;
		// REAL N40_4;
		// REAL N40_5;
		// REAL N40_6;
		// REAL N40_7;
		// REAL N41_2;
		// REAL N41_3;
		// REAL N41_4;
		// REAL N41_5;
		// REAL N41_6;
		// REAL N42_2;
		// REAL N42_3;
		// REAL N42_4;
		// REAL N42_5;
		// REAL N42_6;
		// REAL N42_7;
		// REAL N43_2;
		// REAL N43_3;
		// REAL N43_4;
		// REAL N43_5;
		// REAL N43_6;
		// REAL N43_7;
		// REAL N43_8;
		// REAL N44_2;
		// REAL N44_3;
		// REAL N44_4;
		// REAL N44_5;
		// REAL N44_6;
		// REAL N45_2;
		// REAL N45_3;
		// REAL N45_4;
		// REAL N45_5;
		// REAL N45_6;
		// REAL N45_7;
		// REAL N46_2;
		// REAL N46_3;
		// REAL N46_4;
		// REAL N46_5;
		// REAL N46_6;
		// REAL N46_7;
		// REAL N47_2;
		// REAL N47_3;
		// REAL N47_4;
		// REAL N47_5;
		// REAL N47_6;
		// REAL N48_2;
		// REAL N48_3;
		// REAL N48_4;
		// REAL N48_5;
		// REAL N48_6;
		// REAL N48_7;
		// REAL N49_2;
		// REAL N49_3;
		// REAL N49_4;
		// REAL N49_5;
		// REAL N50_2;
		// REAL N50_3;
		// REAL N50_4;
		// REAL N50_5;
		// REAL N50_6;
		// REAL N51_2;
		// REAL N51_3;
		// REAL N51_4;
		// REAL N51_5;
		// REAL N51_6;
		// REAL N52_2;
		// REAL N52_3;
		// REAL N52_4;
		// REAL N52_5;
		// REAL N52_6;
		// REAL N52_7;
		// REAL N52_8;
		// REAL N52_9;
		// REAL N53_2;
		// REAL N53_3;
		// REAL N53_4;
		// REAL N53_5;
		// REAL N53_6;
		// REAL N53_7;
		// REAL N53_8;
		// REAL N54_2;
		// REAL N54_3;
		// REAL N54_4;
		// REAL N54_5;
		// REAL N54_6;
		// REAL N54_7;
		// REAL N54_8;
		// REAL N54_9;
		// REAL N55_2;
		// REAL N55_3;
		// REAL N55_4;
		// REAL N55_5;
		// REAL N55_6;
		// REAL N55_7;
		// REAL N56_2;
		// REAL N56_3;
		// REAL N56_4;
		// REAL N56_5;
		// REAL N56_6;
		// REAL N56_7;
		// REAL N57_2;
		// REAL N57_3;
		// REAL N57_4;
		// REAL N57_5;
		// REAL N57_6;
		// REAL N57_7;
		// REAL N58_2;
		// REAL N58_3;
		// REAL N58_4;
		// REAL N58_5;
		// REAL N58_6;
		// REAL N59_2;
		// REAL N59_3;
		// REAL N59_4;
		// REAL N59_5;
		// REAL N59_6;
		// REAL N59_7;
		// REAL N59_8;
		// REAL N60_2;
		// REAL N60_3;
		// REAL N60_4;
		// REAL N60_5;
		// REAL N60_6;
		// REAL N60_7;
		// REAL N60_8;
		// REAL N61_2;
		// REAL N61_3;
		// REAL N61_4;
		// REAL N61_5;
		// REAL N61_6;
		// REAL N61_7;
		// REAL N61_8;
		// REAL N62_2;
		// REAL N62_3;
		// REAL N62_4;
		// REAL N62_5;
		// REAL N62_6;
		// REAL N63_2;
		// REAL N63_3;
		// REAL N63_4;
		// REAL N63_5;
		// REAL N63_6;
		// REAL N63_7;
		// REAL N63_8;
		// REAL N64_2;
		// REAL N64_3;
		// REAL N64_4;
		// REAL N64_5;
		// REAL N64_6;
		// REAL N64_7;
		// REAL N65_2;
		// REAL N65_3;
		// REAL N65_4;
		// REAL N65_5;
		// REAL N65_6;
		// REAL N65_7;
		// REAL N66_2;
		// REAL N66_3;
		// REAL N66_4;
		// REAL N66_5;
		// REAL N66_6;
		// REAL N66_7;
		// REAL N67_2;
		// REAL N67_3;
		// REAL N67_4;
		// REAL N67_5;
		// REAL N67_6;
		// REAL N67_7;
		// REAL N67_8;
		// REAL N68_2;
		// REAL N68_3;
		// REAL N68_4;
		// REAL N68_5;
		// REAL N68_6;
		// REAL N68_7;
		// REAL N68_8;
		// REAL N69_2;
		// REAL N69_3;
		// REAL N69_4;
		// REAL N69_5;
		// REAL N69_6;
		// REAL N69_7;
		// REAL N70_2;
		// REAL N70_3;
		// REAL N70_4;
		// REAL N70_5;
		// REAL N70_6;
		// REAL N70_7;
		// REAL N70_8;
		// REAL N71_2;
		// REAL N71_3;
		// REAL N71_4;
		// REAL N71_5;
		// REAL N71_6;
		// REAL N71_7;
		// REAL N72_2;
		// REAL N72_3;
		// REAL N72_4;
		// REAL N72_5;
		// REAL N72_6;
		// REAL N73_2;
		// REAL N73_3;
		// REAL N73_4;
		// REAL N73_5;
		// REAL N73_6;
		// REAL N73_7;
		// REAL N73_8;
		// REAL N74_2;
		// REAL N74_3;
		// REAL N74_4;
		// REAL N74_5;
		// REAL N74_6;
		// REAL N75_2;
		// REAL N75_3;
		// REAL N75_4;
		// REAL N75_5;
		// REAL N75_6;
		// REAL N75_7;
		// REAL N76_2;
		// REAL N76_3;
		// REAL N76_4;
		// REAL N76_5;
		// REAL N76_6;
		// REAL N76_7;
		// REAL N77_2;
		// REAL N77_3;
		// REAL N77_4;
		// REAL N77_5;
		// REAL N77_6;
		// REAL N77_7;
		// REAL N77_8;
		// REAL N78_2;
		// REAL N78_3;
		// REAL N78_4;
		// REAL N78_5;
		// REAL N78_6;
		// REAL N78_7;
		// REAL N78_8;
		// REAL N79_2;
		// REAL N79_3;
		// REAL N79_4;
		// REAL N79_5;
		// REAL N79_6;
		// REAL N79_7;
		// REAL N79_8;
		// REAL N80_2;
		// REAL N80_3;
		// REAL N80_4;
		// REAL N80_5;
		// REAL N80_6;
		// REAL N80_7;
		// REAL N80_8;
		// REAL N81_2;
		// REAL N81_3;
		// REAL N81_4;
		// REAL N81_5;
		// REAL N81_6;
		// REAL N81_7;
		// REAL N81_8;
		// REAL N82_2;
		// REAL N82_3;
		// REAL N82_4;
		// REAL N82_5;
		// REAL N82_6;
		// REAL N83_2;
		// REAL N83_3;
		// REAL N83_4;
		// REAL N83_5;
		// REAL N83_6;
		// REAL N84_2;
		// REAL N84_3;
		// REAL N84_4;
		// REAL N84_5;
		// REAL N84_6;
		// REAL N84_7;
		// REAL N84_8;
		// REAL N84_9;
		// REAL N85_2;
		// REAL N85_3;
		// REAL N85_4;
		// REAL N85_5;
		// REAL N85_6;
		// REAL N85_7;
		// REAL N85_8;
		// REAL N86_2;
		// REAL N86_3;
		// REAL N86_4;
		// REAL N86_5;
		// REAL N86_6;
		// REAL N86_7;
		// REAL N86_8;
		// REAL N86_9;
		// REAL N87_2;
		// REAL N87_3;
		// REAL N87_4;
		// REAL N87_5;
		// REAL N87_6;
		// REAL N87_7;
		// REAL N87_8;
		// REAL N88_2;
		// REAL N88_3;
		// REAL N88_4;
		// REAL N88_5;
		// REAL N88_6;
		// REAL N88_7;
		// REAL N88_8;
		// REAL N88_9;
		// REAL N89_2;
		// REAL N89_3;
		// REAL N89_4;
		// REAL N89_5;
		// REAL N90_2;
		// REAL N90_3;
		// REAL N90_4;
		// REAL N90_5;
		// REAL N90_6;
		// REAL N90_7;
		// REAL N90_8;
		// REAL N91_2;
		// REAL N91_3;
		// REAL N91_4;
		// REAL N91_5;
		// REAL N91_6;
		// REAL N91_7;
		// REAL N92_2;
		// REAL N92_3;
		// REAL N92_4;
		// REAL N92_5;
		// REAL N92_6;
		// REAL N92_7;
		// REAL N92_8;
		// REAL N92_9;
		// REAL N93_2;
		// REAL N93_3;
		// REAL N93_4;
		// REAL N93_5;
		// REAL N93_6;
		// REAL N94_2;
		// REAL N94_3;
		// REAL N94_4;
		// REAL N94_5;
		// REAL N94_6;
		// REAL N94_7;
		// REAL N94_8;
		// REAL N95_2;
		// REAL N95_3;
		// REAL N95_4;
		// REAL N95_5;
		// REAL N95_6;
		// REAL N95_7;
		// REAL N95_8;
		// REAL N96_2;
		// REAL N96_3;
		// REAL N96_4;
		// REAL N96_5;
		// REAL N96_6;
		// REAL N96_7;
		// REAL N96_8;
		// REAL N96_9;
		// REAL N97_2;
		// REAL N97_3;
		// REAL N97_4;
		// REAL N97_5;
		// REAL N97_6;
		// REAL N97_7;
		// REAL N97_8;
		// REAL N97_9;
		// REAL N97_10;
		// REAL N98_2;
		// REAL N98_3;
		// REAL N98_4;
		// REAL N98_5;
		// REAL N98_6;
		// REAL N98_7;
		// REAL N98_8;
		// REAL N98_9;
		// REAL N99_2;
		// REAL N99_3;
		// REAL N99_4;
		// REAL N99_5;
		// REAL N99_6;
		// REAL N99_7;
		// REAL N100_2;
		// REAL N100_3;
		// REAL N100_4;
		// REAL N100_5;
		// REAL N100_6;
		// REAL N100_7;
		// REAL N100_8;
		// REAL N101_2;
		// REAL N101_3;
		// REAL N101_4;
		// REAL N101_5;
		// REAL N101_6;
		// REAL N101_7;
		// REAL N101_8;
		// REAL N102_2;
		// REAL N102_3;
		// REAL N102_4;
		// REAL N102_5;
		// REAL N102_6;
		// REAL N102_7;
		// REAL N103_2;
		// REAL N103_3;
		// REAL N103_4;
		// REAL N103_5;
		// REAL N103_6;
		// REAL N103_7;
		// REAL N103_8;
		// REAL N103_9;
		// REAL N104_2;
		// REAL N104_3;
		// REAL N104_4;
		// REAL N104_5;
		// REAL N104_6;
		// REAL N104_7;
		// REAL N104_8;
		// REAL N104_9;
		// REAL N105_2;
		// REAL N105_3;
		// REAL N105_4;
		// REAL N105_5;
		// REAL N105_6;
		// REAL N106_2;
		// REAL N106_3;
		// REAL N106_4;
		// REAL N106_5;
		// REAL N106_6;
		// REAL N107_2;
		// REAL N107_3;
		// REAL N107_4;
		// REAL N107_5;
		// REAL N107_6;
		// REAL N108_2;
		// REAL N108_3;
		// REAL N108_4;
		// REAL N108_5;
		// REAL N108_6;
		// REAL N108_7;
		// REAL N109_2;
		// REAL N109_3;
		// REAL N109_4;
		// REAL N109_5;
		// REAL N109_6;
		// REAL N109_7;
		// REAL N109_8;
		// REAL N110_2;
		// REAL N110_3;
		// REAL N110_4;
		// REAL N110_5;
		// REAL N110_6;
		// REAL N110_7;
		// REAL N110_8;
		// REAL N111_2;
		// REAL N111_3;
		// REAL N111_4;
		// REAL N111_5;
		// REAL N111_6;
		// REAL N111_7;
		// REAL N111_8;
		// REAL N112_2;
		// REAL N112_3;
		// REAL N112_4;
		// REAL N112_5;
		// REAL N112_6;
		// REAL N112_7;
		// REAL N112_8;
		// REAL N113_2;
		// REAL N113_3;
		// REAL N113_4;
		// REAL N113_5;
		// REAL N113_6;
		// REAL N113_7;
		// REAL N113_8;
		// REAL N114_2;
		// REAL N114_3;
		// REAL N114_4;
		// REAL N114_5;
		// REAL N114_6;
		// REAL N114_7;
		// REAL N115_2;
		// REAL N115_3;
		// REAL N115_4;
		// REAL N115_5;
		// REAL N115_6;
		// REAL N115_7;
		// REAL N115_8;
		// REAL N116_2;
		// REAL N116_3;
		// REAL N116_4;
		// REAL N116_5;
		// REAL N116_6;
		// REAL N116_7;
		// REAL N117_2;
		// REAL N117_3;
		// REAL N117_4;
		// REAL N117_5;
		// REAL N117_6;
		// REAL N117_7;
		// REAL N117_8;
		// REAL N118_2;
		// REAL N118_3;
		// REAL N118_4;
		// REAL N118_5;
		// REAL N118_6;
		// REAL N118_7;
		// REAL N118_8;
		// REAL N119_2;
		// REAL N119_3;
		// REAL N119_4;
		// REAL N119_5;
		// REAL N119_6;
		// REAL N120_2;
		// REAL N120_3;
		// REAL N120_4;
		// REAL N120_5;
		// REAL N120_6;
		// REAL N121_2;
		// REAL N121_3;
		// REAL N121_4;
		// REAL N121_5;
		// REAL N121_6;
		// REAL N121_7;
		// REAL N122_2;
		// REAL N122_3;
		// REAL N122_4;
		// REAL N122_5;
		// REAL N122_6;
		// REAL N122_7;
		// REAL N122_8;
		// REAL N122_9;
		// REAL N123_2;
		// REAL N123_3;
		// REAL N123_4;
		// REAL N123_5;
		// REAL N123_6;
		// REAL N123_7;
		// REAL N124_2;
		// REAL N124_3;
		// REAL N124_4;
		// REAL N124_5;
		// REAL N124_6;
		// REAL N124_7;
		// REAL N124_8;
		// REAL N125_2;
		// REAL N125_3;
		// REAL N125_4;
		// REAL N125_5;
		// REAL N125_6;
		// REAL N126_2;
		// REAL N126_3;
		// REAL N126_4;
		// REAL N126_5;
		// REAL N126_6;
		// REAL N126_7;
		// REAL N126_8;
		// REAL N127_2;
		// REAL N127_3;
		// REAL N127_4;
		// REAL N127_5;
		// REAL N127_6;
		// REAL N127_7;
		// REAL N127_8;
		// REAL N128_2;
		// REAL N128_3;
		// REAL N128_4;
		// REAL N128_5;
		// REAL N128_6;
		// REAL N128_7;
		// REAL N129_2;
		// REAL N129_3;
		// REAL N129_4;
		// REAL N129_5;
		// REAL N129_6;
		// REAL N130_2;
		// REAL N130_3;
		// REAL N130_4;
		// REAL N130_5;
		// REAL N130_6;
		// REAL N130_7;
		// REAL N130_8;
		// REAL N131_2;
		// REAL N131_3;
		// REAL N131_4;
		// REAL N131_5;
		// REAL N131_6;
		// REAL N131_7;
		// REAL N131_8;
		// REAL N132_2;
		// REAL N132_3;
		// REAL N132_4;
		// REAL N132_5;
		// REAL N132_6;
		// REAL N132_7;
		// REAL N132_8;
		// REAL N133_2;
		// REAL N133_3;
		// REAL N133_4;
		// REAL N133_5;
		// REAL N133_6;
		// REAL N133_7;
		// REAL N133_8;
		// REAL N133_9;
		// REAL N133_10;
		// REAL N134_2;
		// REAL N134_3;
		// REAL N134_4;
		// REAL N134_5;
		// REAL N134_6;
		// REAL N134_7;
		// REAL N134_8;
		// REAL N135_2;
		// REAL N135_3;
		// REAL N135_4;
		// REAL N135_5;
		// REAL N135_6;
		// REAL N135_7;
		// REAL N135_8;
		// REAL N135_9;
		// REAL N136_2;
		// REAL N136_3;
		// REAL N136_4;
		// REAL N136_5;
		// REAL N136_6;
		// REAL N136_7;
		// REAL N136_8;
		// REAL N137_2;
		// REAL N137_3;
		// REAL N137_4;
		// REAL N137_5;
		// REAL N137_6;
		// REAL N137_7;
		// REAL N138_2;
		// REAL N138_3;
		// REAL N138_4;
		// REAL N138_5;
		// REAL N138_6;
		// REAL N138_7;
		// REAL N138_8;
		// REAL N139_2;
		// REAL N139_3;
		// REAL N139_4;
		// REAL N139_5;
		// REAL N139_6;
		// REAL N139_7;
		// REAL N139_8;
		// REAL N140_2;
		// REAL N140_3;
		// REAL N140_4;
		// REAL N140_5;
		// REAL N140_6;
		// REAL N140_7;
		// REAL N140_8;
		// REAL N140_9;
		// REAL N141_2;
		// REAL N141_3;
		// REAL N141_4;
		// REAL N141_5;
		// REAL N141_6;
		// REAL N141_7;
		// REAL N141_8;
		// REAL N142_2;
		// REAL N142_3;
		// REAL N142_4;
		// REAL N142_5;
		// REAL N142_6;
		// REAL N142_7;
		// REAL N142_8;
		// REAL N143_2;
		// REAL N143_3;
		// REAL N143_4;
		// REAL N143_5;
		// REAL N143_6;
		// REAL N143_7;
		// REAL N144_2;
		// REAL N144_3;
		// REAL N144_4;
		// REAL N144_5;
		// REAL N144_6;
		// REAL N144_7;
		// REAL N144_8;
		// REAL N145_2;
		// REAL N145_3;
		// REAL N145_4;
		// REAL N145_5;
		// REAL N145_6;
		// REAL N146_2;
		// REAL N146_3;
		// REAL N146_4;
		// REAL N146_5;
		// REAL N146_6;
		// REAL N146_7;
		// REAL N146_8;
		// REAL N147_2;
		// REAL N147_3;
		// REAL N147_4;
		// REAL N147_5;
		// REAL N147_6;
		// REAL N147_7;
		// REAL N147_8;
		// REAL N148_2;
		// REAL N148_3;
		// REAL N148_4;
		// REAL N148_5;
		// REAL N148_6;
		// REAL N148_7;
		// REAL N148_8;
		// REAL N148_9;
		// REAL N149_2;
		// REAL N149_3;
		// REAL N149_4;
		// REAL N149_5;
		// REAL N149_6;
		// REAL N149_7;
		// REAL N150_2;
		// REAL N150_3;
		// REAL N150_4;
		// REAL N150_5;
		// REAL N150_6;
		// REAL N151_2;
		// REAL N151_3;
		// REAL N151_4;
		// REAL N151_5;
		// REAL N151_6;
		// REAL N152_2;
		// REAL N152_3;
		// REAL N152_4;
		// REAL N152_5;
		// REAL N152_6;
		// REAL N152_7;
		// REAL N152_8;
		// REAL N153_2;
		// REAL N153_3;
		// REAL N153_4;
		// REAL N153_5;
		// REAL N153_6;
		// REAL N153_7;
		// REAL N153_8;
		// REAL N154_2;
		// REAL N154_3;
		// REAL N154_4;
		// REAL N154_5;
		// REAL N154_6;
		// REAL N154_7;
		// REAL N154_8;
		// REAL N155_2;
		// REAL N155_3;
		// REAL N155_4;
		// REAL N155_5;
		// REAL N155_6;
		// REAL N156_2;
		// REAL N156_3;
		// REAL N156_4;
		// REAL N156_5;
		// REAL N156_6;
		// REAL N157_2;
		// REAL N157_3;
		// REAL N157_4;
		// REAL N157_5;
		// REAL N157_6;
		// REAL N158_2;
		// REAL N158_3;
		// REAL N158_4;
		// REAL N158_5;
		// REAL N158_6;
		// REAL N158_7;
		// REAL N158_8;
		// REAL N159_2;
		// REAL N159_3;
		// REAL N159_4;
		// REAL N159_5;
		// REAL N159_6;
		// REAL N159_7;
		// REAL N159_8;
		// REAL N159_9;
		// REAL N160_2;
		// REAL N160_3;
		// REAL N160_4;
		// REAL N160_5;
		// REAL N160_6;
		// REAL N160_7;
		// REAL N161_2;
		// REAL N161_3;
		// REAL N161_4;
		// REAL N161_5;
		// REAL N161_6;
		// REAL N162_2;
		// REAL N162_3;
		// REAL N162_4;
		// REAL N162_5;
		// REAL N162_6;
		// REAL N162_7;
		// REAL N162_8;
		// REAL N163_2;
		// REAL N163_3;
		// REAL N163_4;
		// REAL N163_5;
		// REAL N163_6;
		// REAL N163_7;
		// REAL N163_8;
		// REAL N164_2;
		// REAL N164_3;
		// REAL N164_4;
		// REAL N164_5;
		// REAL N164_6;
		// REAL N164_7;
		// REAL N164_8;
		// REAL N165_2;
		// REAL N165_3;
		// REAL N165_4;
		// REAL N165_5;
		// REAL N165_6;
		// REAL N165_7;
		// REAL N165_8;
		// REAL N166_2;
		// REAL N166_3;
		// REAL N166_4;
		// REAL N166_5;
		// REAL N166_6;
		// REAL N166_7;
		// REAL N166_8;
		// REAL N167_2;
		// REAL N167_3;
		// REAL N167_4;
		// REAL N167_5;
		// REAL N167_6;
		// REAL N167_7;
		// REAL N168_2;
		// REAL N168_3;
		// REAL N168_4;
		// REAL N168_5;
		// REAL N168_6;
		// REAL N168_7;
		// REAL N168_8;
		// REAL N168_9;
		// REAL N169_2;
		// REAL N169_3;
		// REAL N169_4;
		// REAL N169_5;
		// REAL N169_6;
		// REAL N169_7;
		// REAL N169_8;
		// REAL N170_2;
		// REAL N170_3;
		// REAL N170_4;
		// REAL N170_5;
		// REAL N170_6;
		// REAL N170_7;
		// REAL N171_2;
		// REAL N171_3;
		// REAL N171_4;
		// REAL N171_5;
		// REAL N171_6;
		// REAL N171_7;
		// REAL N171_8;
		// REAL N172_2;
		// REAL N172_3;
		// REAL N172_4;
		// REAL N172_5;
		// REAL N172_6;
		// REAL N172_7;
		// REAL N172_8;
		// REAL N173_2;
		// REAL N173_3;
		// REAL N173_4;
		// REAL N173_5;
		// REAL N173_6;
		// REAL N173_7;
		// REAL N174_2;
		// REAL N174_3;
		// REAL N174_4;
		// REAL N174_5;
		// REAL N174_6;
		// REAL N174_7;
		// REAL N174_8;
		// REAL N175_2;
		// REAL N175_3;
		// REAL N175_4;
		// REAL N175_5;
		// REAL N175_6;
		// REAL N175_7;
		// REAL N175_8;
		// REAL N176_2;
		// REAL N176_3;
		// REAL N176_4;
		// REAL N176_5;
		// REAL N176_6;
		// REAL N176_7;
		// REAL N176_8;
		// REAL N177_2;
		// REAL N177_3;
		// REAL N177_4;
		// REAL N177_5;
		// REAL N177_6;
		// REAL N177_7;
		// REAL N177_8;
		// REAL N177_9;
		// REAL N178_2;
		// REAL N178_3;
		// REAL N178_4;
		// REAL N178_5;
		// REAL N178_6;
		// REAL N178_7;
		// REAL N178_8;
		// REAL N179_2;
		// REAL N179_3;
		// REAL N179_4;
		// REAL N179_5;
		// REAL N179_6;
		// REAL N180_2;
		// REAL N180_3;
		// REAL N180_4;
		// REAL N180_5;
		// REAL N180_6;
		// REAL N180_7;
		// REAL N180_8;
		// REAL N181_2;
		// REAL N181_3;
		// REAL N181_4;
		// REAL N181_5;
		// REAL N181_6;
		// REAL N182_2;
		// REAL N182_3;
		// REAL N182_4;
		// REAL N182_5;
		// REAL N182_6;
		// REAL N182_7;
		// REAL N183_2;
		// REAL N183_3;
		// REAL N183_4;
		// REAL N183_5;
		// REAL N183_6;
		// REAL N183_7;
		// REAL N184_2;
		// REAL N184_3;
		// REAL N184_4;
		// REAL N184_5;
		// REAL N184_6;
		// REAL N184_7;
		// REAL N184_8;
		// REAL N185_2;
		// REAL N185_3;
		// REAL N185_4;
		// REAL N185_5;
		// REAL N185_6;
		// REAL N185_7;
		// REAL N185_8;
		// REAL N185_9;
		// REAL N186_2;
		// REAL N186_3;
		// REAL N186_4;
		// REAL N186_5;
		// REAL N186_6;
		// REAL N186_7;
		// REAL N187_2;
		// REAL N187_3;
		// REAL N187_4;
		// REAL N187_5;
		// REAL N187_6;
		// REAL N188_2;
		// REAL N188_3;
		// REAL N188_4;
		// REAL N188_5;
		// REAL N188_6;
		// REAL N188_7;
		// REAL N189_2;
		// REAL N189_3;
		// REAL N189_4;
		// REAL N189_5;
		// REAL N189_6;
		// REAL N189_7;
		// REAL N190_2;
		// REAL N190_3;
		// REAL N190_4;
		// REAL N190_5;
		// REAL N190_6;
		// REAL N191_2;
		// REAL N191_3;
		// REAL N191_4;
		// REAL N191_5;
		// REAL N191_6;
		// REAL N191_7;
		// REAL N191_8;
		// REAL N191_9;
		// REAL N192_2;
		// REAL N192_3;
		// REAL N192_4;
		// REAL N192_5;
		// REAL N192_6;
		// REAL N192_7;
		// REAL N192_8;
		// REAL N193_2;
		// REAL N193_3;
		// REAL N193_4;
		// REAL N193_5;
		// REAL N193_6;
		// REAL N194_2;
		// REAL N194_3;
		// REAL N194_4;
		// REAL N194_5;
		// REAL N194_6;
		// REAL N194_7;
		// REAL N194_8;
		// REAL N194_9;
		// REAL N195_2;
		// REAL N195_3;
		// REAL N195_4;
		// REAL N195_5;
		// REAL N195_6;
		// REAL N195_7;
		// REAL N196_2;
		// REAL N196_3;
		// REAL N196_4;
		// REAL N196_5;
		// REAL N197_2;
		// REAL N197_3;
		// REAL N197_4;
		// REAL N197_5;
		// REAL N197_6;
		// REAL N198_2;
		// REAL N198_3;
		// REAL N198_4;
		// REAL N198_5;
		// REAL N198_6;
		// REAL N198_7;
		// REAL N198_8;
		// REAL N199_2;
		// REAL N199_3;
		// REAL N199_4;
		// REAL N199_5;
		// REAL N199_6;
		// REAL N199_7;
		// REAL N199_8;
		// REAL N200_2;
		// REAL N200_3;
		// REAL N200_4;
		// REAL N200_5;
		// REAL N200_6;
		// REAL N200_7;
		// REAL N201_2;
		// REAL N201_3;
		// REAL N201_4;
		// REAL N201_5;
		// REAL N202_2;
		// REAL N202_3;
		// REAL N202_4;
		// REAL N202_5;
		// REAL N202_6;
		// REAL N202_7;
		// REAL N202_8;
		// REAL N203_2;
		// REAL N203_3;
		// REAL N203_4;
		// REAL N203_5;
		// REAL N203_6;
		// REAL N203_7;
		// REAL N204_2;
		// REAL N204_3;
		// REAL N204_4;
		// REAL N204_5;
		// REAL N204_6;
		// REAL N204_7;
		// REAL N205_2;
		// REAL N205_3;
		// REAL N205_4;
		// REAL N205_5;
		// REAL N205_6;
		// REAL N205_7;
		// REAL N205_8;
		// REAL N206_2;
		// REAL N206_3;
		// REAL N206_4;
		// REAL N206_5;
		// REAL N206_6;
		// REAL N206_7;
		// REAL N206_8;
		// REAL N206_9;
		// REAL N206_10;
		// REAL N207_2;
		// REAL N207_3;
		// REAL N207_4;
		// REAL N207_5;
		// REAL N207_6;
		// REAL N207_7;
		// REAL N207_8;
		// REAL N208_2;
		// REAL N208_3;
		// REAL N208_4;
		// REAL N208_5;
		// REAL N208_6;
		// REAL N208_7;
		// REAL N208_8;
		// REAL N209_2;
		// REAL N209_3;
		// REAL N209_4;
		// REAL N209_5;
		// REAL N209_6;
		// REAL N209_7;
		// REAL N209_8;
		// REAL N210_2;
		// REAL N210_3;
		// REAL N210_4;
		// REAL N210_5;
		// REAL N210_6;
		// REAL N211_2;
		// REAL N211_3;
		// REAL N211_4;
		// REAL N211_5;
		// REAL N211_6;
		// REAL N211_7;
		// REAL N211_8;
		// REAL N212_2;
		// REAL N212_3;
		// REAL N212_4;
		// REAL N212_5;
		// REAL N212_6;
		// REAL N213_2;
		// REAL N213_3;
		// REAL N213_4;
		// REAL N213_5;
		// REAL N213_6;
		// REAL N213_7;
		// REAL N213_8;
		// REAL N214_2;
		// REAL N214_3;
		// REAL N214_4;
		// REAL N214_5;
		// REAL N214_6;
		// REAL N214_7;
		// REAL N214_8;
		// REAL N214_9;
		// REAL N215_2;
		// REAL N215_3;
		// REAL N215_4;
		// REAL N215_5;
		// REAL N216_2;
		// REAL N216_3;
		// REAL N216_4;
		// REAL N216_5;
		// REAL N216_6;
		// REAL N217_2;
		// REAL N217_3;
		// REAL N217_4;
		// REAL N217_5;
		// REAL N217_6;
		// REAL N217_7;
		// REAL N217_8;
		// REAL N217_9;
		// REAL N217_10;
		// REAL N218_2;
		// REAL N218_3;
		// REAL N218_4;
		// REAL N218_5;
		// REAL N218_6;
		// REAL N219_2;
		// REAL N219_3;
		// REAL N219_4;
		// REAL N219_5;
		// REAL N219_6;
		// REAL N219_7;
		// REAL N219_8;
		// REAL N219_9;
		// REAL N220_2;
		// REAL N220_3;
		// REAL N220_4;
		// REAL N220_5;
		// REAL N220_6;
		// REAL N220_7;
		// REAL N220_8;
		// REAL N221_2;
		// REAL N221_3;
		// REAL N221_4;
		// REAL N221_5;
		// REAL N221_6;
		// REAL N221_7;
		// REAL N221_8;
		// REAL N222_2;
		// REAL N222_3;
		// REAL N222_4;
		// REAL N222_5;
		// REAL N222_6;
		// REAL N222_7;
		// REAL N223_2;
		// REAL N223_3;
		// REAL N223_4;
		// REAL N223_5;
		// REAL N223_6;
		// REAL N224_2;
		// REAL N224_3;
		// REAL N224_4;
		// REAL N224_5;
		// REAL N224_6;
		// REAL N224_7;
		// REAL N224_8;
		// REAL N224_9;
		// REAL N225_2;
		// REAL N225_3;
		// REAL N225_4;
		// REAL N225_5;
		// REAL N225_6;
		// REAL N226_2;
		// REAL N226_3;
		// REAL N226_4;
		// REAL N226_5;
		// REAL N226_6;
		// REAL N226_7;
		// REAL N226_8;
		// REAL N227_2;
		// REAL N227_3;
		// REAL N227_4;
		// REAL N227_5;
		// REAL N227_6;
		// REAL N227_7;
		// REAL N227_8;
		// REAL N228_2;
		// REAL N228_3;
		// REAL N228_4;
		// REAL N228_5;
		// REAL N228_6;
		// REAL N228_7;
		// REAL N228_8;
		// REAL N229_2;
		// REAL N229_3;
		// REAL N229_4;
		// REAL N229_5;
		// REAL N229_6;
		// REAL N229_7;
		// REAL N229_8;
		// REAL N230_2;
		// REAL N230_3;
		// REAL N230_4;
		// REAL N230_5;
		// REAL N230_6;
		// REAL N230_7;
		// REAL N230_8;
		// REAL N230_9;
		// REAL N231_2;
		// REAL N231_3;
		// REAL N231_4;
		// REAL N231_5;
		// REAL N231_6;
		// REAL N231_7;
		// REAL N231_8;
		// REAL N232_2;
		// REAL N232_3;
		// REAL N232_4;
		// REAL N232_5;
		// REAL N232_6;
		// REAL N233_2;
		// REAL N233_3;
		// REAL N233_4;
		// REAL N233_5;
		// REAL N233_6;
		// REAL N233_7;
		// REAL N234_2;
		// REAL N234_3;
		// REAL N234_4;
		// REAL N234_5;
		// REAL N234_6;
		// REAL N234_7;
		// REAL N234_8;
		// REAL N235_2;
		// REAL N235_3;
		// REAL N235_4;
		// REAL N235_5;
		// REAL N235_6;
		// REAL N235_7;
		// REAL N235_8;
		// REAL N236_2;
		// REAL N236_3;
		// REAL N236_4;
		// REAL N236_5;
		// REAL N236_6;
		// REAL N236_7;
		// REAL N236_8;
		// REAL N237_2;
		// REAL N237_3;
		// REAL N237_4;
		// REAL N237_5;
		// REAL N237_6;
		// REAL N237_7;
		// REAL N237_8;
		// REAL N238_2;
		// REAL N238_3;
		// REAL N238_4;
		// REAL N238_5;
		// REAL N238_6;
		// REAL N238_7;
		// REAL N238_8;
		// REAL N239_2;
		// REAL N239_3;
		// REAL N239_4;
		// REAL N239_5;
		// REAL N239_6;
		// REAL N239_7;
		// REAL N239_8;
		// REAL N240_2;
		// REAL N240_3;
		// REAL N240_4;
		// REAL N240_5;
		// REAL N240_6;
		// REAL N240_7;
		// REAL N240_8;
		// REAL N240_9;
		// REAL N241_2;
		// REAL N241_3;
		// REAL N241_4;
		// REAL N241_5;
		// REAL N241_6;
		// REAL N241_7;
		// REAL N241_8;
		// REAL N242_2;
		// REAL N242_3;
		// REAL N242_4;
		// REAL N242_5;
		// REAL N242_6;
		// REAL N242_7;
		// REAL N243_2;
		// REAL N243_3;
		// REAL N243_4;
		// REAL N243_5;
		// REAL N243_6;
		// REAL N243_7;
		// REAL N244_2;
		// REAL N244_3;
		// REAL N244_4;
		// REAL N244_5;
		// REAL N244_6;
		// REAL N244_7;
		// REAL N245_2;
		// REAL N245_3;
		// REAL N245_4;
		// REAL N245_5;
		// REAL N245_6;
		// REAL N245_7;
		// REAL N246_2;
		// REAL N246_3;
		// REAL N246_4;
		// REAL N246_5;
		// REAL N246_6;
		// REAL N246_7;
		// REAL N246_8;
		// REAL N247_2;
		// REAL N247_3;
		// REAL N247_4;
		// REAL N247_5;
		// REAL N247_6;
		// REAL N247_7;
		// REAL N247_8;
		// REAL N248_2;
		// REAL N248_3;
		// REAL N248_4;
		// REAL N248_5;
		// REAL N248_6;
		// REAL N248_7;
		// REAL N249_2;
		// REAL N249_3;
		// REAL N249_4;
		// REAL N249_5;
		// REAL N249_6;
		// REAL N249_7;
		// REAL N249_8;
		// REAL N250_2;
		// REAL N250_3;
		// REAL N250_4;
		// REAL N250_5;
		// REAL N250_6;
		// REAL N251_2;
		// REAL N251_3;
		// REAL N251_4;
		// REAL N251_5;
		// REAL N251_6;
		// REAL N251_7;
		// REAL N251_8;
		// REAL N251_9;
		// REAL N251_10;
		// REAL N252_2;
		// REAL N252_3;
		// REAL N252_4;
		// REAL N252_5;
		// REAL N252_6;
		// REAL N252_7;
		// REAL N252_8;
		// REAL N253_2;
		// REAL N253_3;
		// REAL N253_4;
		// REAL N253_5;
		// REAL N253_6;
		// REAL N253_7;
		// REAL N253_8;
		// REAL N254_2;
		// REAL N254_3;
		// REAL N254_4;
		// REAL N254_5;
		// REAL N254_6;
		// REAL N254_7;
		// REAL N255_2;
		// REAL N255_3;
		// REAL N255_4;
		// REAL N255_5;
		// REAL N255_6;
		// REAL N255_7;
		// REAL N255_8;
		// REAL N256_2;
		// REAL N256_3;
		// REAL N256_4;
		// REAL N256_5;
		// REAL N256_6;
		// REAL N257_2;
		// REAL N257_3;
		// REAL N257_4;
		// REAL N257_5;
		// REAL N257_6;
		// REAL N257_7;
		// REAL N258_2;
		// REAL N258_3;
		// REAL N258_4;
		// REAL N258_5;
		// REAL N258_6;
		// REAL N258_7;
		// REAL N258_8;
		// REAL N258_9;
		// REAL N259_2;
		// REAL N259_3;
		// REAL N259_4;
		// REAL N259_5;
		// REAL N259_6;
		// REAL N259_7;
		// REAL N259_8;
		// REAL N259_9;
		// REAL N260_2;
		// REAL N260_3;
		// REAL N260_4;
		// REAL N260_5;
		// REAL N260_6;
		// REAL N260_7;
		// REAL N260_8;
		// REAL N260_9;
		// REAL N261_2;
		// REAL N261_3;
		// REAL N261_4;
		// REAL N261_5;
		// REAL N261_6;
		// REAL N261_7;
		// REAL N261_8;
		// REAL N262_2;
		// REAL N262_3;
		// REAL N262_4;
		// REAL N262_5;
		// REAL N262_6;
		// REAL N262_7;
		// REAL N262_8;
		// REAL N263_2;
		// REAL N263_3;
		// REAL N263_4;
		// REAL N263_5;
		// REAL N263_6;
		// REAL N263_7;
		// REAL N263_8;
		// REAL N264_2;
		// REAL N264_3;
		// REAL N264_4;
		// REAL N264_5;
		// REAL N264_6;
		// REAL N265_2;
		// REAL N265_3;
		// REAL N265_4;
		// REAL N265_5;
		// REAL N265_6;
		// REAL N265_7;
		// REAL N265_8;
		// REAL N266_2;
		// REAL N266_3;
		// REAL N266_4;
		// REAL N266_5;
		// REAL N266_6;
		// REAL N266_7;
		// REAL N266_8;
		// REAL N267_2;
		// REAL N267_3;
		// REAL N267_4;
		// REAL N267_5;
		// REAL N267_6;
		// REAL N267_7;
		// REAL N267_8;
		// REAL N267_9;
		// REAL N268_2;
		// REAL N268_3;
		// REAL N268_4;
		// REAL N268_5;
		// REAL N268_6;
		// REAL N268_7;
		// REAL N268_8;
		// REAL N269_2;
		// REAL N269_3;
		// REAL N269_4;
		// REAL N269_5;
		// REAL N269_6;
		// REAL N270_2;
		// REAL N270_3;
		// REAL N270_4;
		// REAL N270_5;
		// REAL N271_2;
		// REAL N271_3;
		// REAL N271_4;
		// REAL N271_5;
		// REAL N271_6;
		// REAL N271_7;
		// REAL N272_2;
		// REAL N272_3;
		// REAL N272_4;
		// REAL N272_5;
		// REAL N272_6;
		// REAL N273_2;
		// REAL N273_3;
		// REAL N273_4;
		// REAL N273_5;
		// REAL N273_6;
		// REAL N273_7;
		// REAL N274_2;
		// REAL N274_3;
		// REAL N274_4;
		// REAL N274_5;
		// REAL N274_6;
		// REAL N275_2;
		// REAL N275_3;
		// REAL N275_4;
		// REAL N275_5;
		// REAL N275_6;
		// REAL N275_7;
		// REAL N275_8;
		// REAL N275_9;
		// REAL N276_2;
		// REAL N276_3;
		// REAL N276_4;
		// REAL N276_5;
		// REAL N276_6;
		// REAL N276_7;
		// REAL N276_8;
		// REAL N277_2;
		// REAL N277_3;
		// REAL N277_4;
		// REAL N277_5;
		// REAL N277_6;
		// REAL N277_7;
		// REAL N277_8;
		// REAL N278_2;
		// REAL N278_3;
		// REAL N278_4;
		// REAL N278_5;
		// REAL N278_6;
		// REAL N278_7;
		// REAL N278_8;
		// REAL N279_2;
		// REAL N279_3;
		// REAL N279_4;
		// REAL N279_5;
		// REAL N279_6;
		// REAL N279_7;
		// REAL N280_2;
		// REAL N280_3;
		// REAL N280_4;
		// REAL N280_5;
		// REAL N280_6;
		// REAL N280_7;
		// REAL N280_8;
		// REAL N281_2;
		// REAL N281_3;
		// REAL N281_4;
		// REAL N281_5;
		// REAL N281_6;
		// REAL N281_7;
		// REAL N282_2;
		// REAL N282_3;
		// REAL N282_4;
		// REAL N282_5;
		// REAL N282_6;
		// REAL N283_2;
		// REAL N283_3;
		// REAL N283_4;
		// REAL N283_5;
		// REAL N283_6;
		// REAL N283_7;
		// REAL N283_8;
		// REAL N283_9;
		// REAL N284_2;
		// REAL N284_3;
		// REAL N284_4;
		// REAL N284_5;
		// REAL N284_6;
		// REAL N284_7;
		// REAL N284_8;
		// REAL N285_2;
		// REAL N285_3;
		// REAL N285_4;
		// REAL N285_5;
		// REAL N285_6;
		// REAL N285_7;
		// REAL N285_8;
		// REAL N285_9;
		// REAL N286_2;
		// REAL N286_3;
		// REAL N286_4;
		// REAL N286_5;
		// REAL N286_6;
		// REAL N286_7;
		// REAL N286_8;
		// REAL N287_2;
		// REAL N287_3;
		// REAL N287_4;
		// REAL N287_5;
		// REAL N287_6;
		// REAL N288_2;
		// REAL N288_3;
		// REAL N288_4;
		// REAL N288_5;
		// REAL N288_6;
		// REAL N288_7;
		// REAL N288_8;
		// REAL N289_2;
		// REAL N289_3;
		// REAL N289_4;
		// REAL N289_5;
		// REAL N289_6;
		// REAL N289_7;
		// REAL N289_8;
		// REAL N290_2;
		// REAL N290_3;
		// REAL N290_4;
		// REAL N290_5;
		// REAL N290_6;
		// REAL N290_7;
		// REAL N290_8;
		// REAL N291_2;
		// REAL N291_3;
		// REAL N291_4;
		// REAL N291_5;
		// REAL N292_2;
		// REAL N292_3;
		// REAL N292_4;
		// REAL N292_5;
		// REAL N292_6;
		// REAL N292_7;
		// REAL N292_8;
		// REAL N293_2;
		// REAL N293_3;
		// REAL N293_4;
		// REAL N293_5;
		// REAL N293_6;
		// REAL N293_7;
		// REAL N294_2;
		// REAL N294_3;
		// REAL N294_4;
		// REAL N294_5;
		// REAL N294_6;
		// REAL N295_2;
		// REAL N295_3;
		// REAL N295_4;
		// REAL N295_5;
		// REAL N295_6;
		// REAL N295_7;
		// REAL N295_8;
		// REAL N296_2;
		// REAL N296_3;
		// REAL N296_4;
		// REAL N296_5;
		// REAL N296_6;
		// REAL N296_7;
		// REAL N296_8;
		// REAL N297_2;
		// REAL N297_3;
		// REAL N297_4;
		// REAL N297_5;
		// REAL N297_6;
		// REAL N297_7;
		// REAL N297_8;
		// REAL N298_2;
		// REAL N298_3;
		// REAL N298_4;
		// REAL N298_5;
		// REAL N298_6;
		// REAL N298_7;
		// REAL N298_8;
		// REAL N298_9;
		// REAL N298_10;
		// REAL N299_2;
		// REAL N299_3;
		// REAL N299_4;
		// REAL N299_5;
		// REAL N299_6;
		// REAL N299_7;
		// REAL N299_8;
		// REAL N300_2;
		// REAL N300_3;
		// REAL N300_4;
		// REAL N300_5;
		// REAL N300_6;
		// REAL N300_7;
		// REAL N300_8;
		// REAL N301_2;
		// REAL N301_3;
		// REAL N301_4;
		// REAL N301_5;
		// REAL N301_6;
		// REAL N301_7;
		// REAL N301_8;
		// REAL N302_2;
		// REAL N302_3;
		// REAL N302_4;
		// REAL N302_5;
		// REAL N302_6;
		// REAL N303_2;
		// REAL N303_3;
		// REAL N303_4;
		// REAL N303_5;
		// REAL N303_6;
		// REAL N303_7;
		// REAL N303_8;
		// REAL N304_2;
		// REAL N304_3;
		// REAL N304_4;
		// REAL N304_5;
		// REAL N304_6;
		// REAL N304_7;
		// REAL N304_8;
		// REAL N305_2;
		// REAL N305_3;
		// REAL N305_4;
		// REAL N305_5;
		// REAL N305_6;
		// REAL N305_7;
		// REAL N305_8;
		// REAL N306_2;
		// REAL N306_3;
		// REAL N306_4;
		// REAL N306_5;
		// REAL N306_6;
		// REAL N306_7;
		// REAL N307_2;
		// REAL N307_3;
		// REAL N307_4;
		// REAL N307_5;
		// REAL N307_6;
		// REAL N307_7;
		// REAL N307_8;
		// REAL N308_2;
		// REAL N308_3;
		// REAL N308_4;
		// REAL N308_5;
		// REAL N308_6;
		// REAL N308_7;
		// REAL N309_2;
		// REAL N309_3;
		// REAL N309_4;
		// REAL N309_5;
		// REAL N309_6;
		// REAL N310_2;
		// REAL N310_3;
		// REAL N310_4;
		// REAL N310_5;
		// REAL N311_2;
		// REAL N311_3;
		// REAL N311_4;
		// REAL N311_5;
		// REAL N311_6;
		// REAL N311_7;
		// REAL N311_8;
		// REAL N312_2;
		// REAL N312_3;
		// REAL N312_4;
		// REAL N312_5;
		// REAL N312_6;
		// REAL N312_7;
		// REAL N312_8;
		// REAL N313_2;
		// REAL N313_3;
		// REAL N313_4;
		// REAL N313_5;
		// REAL N313_6;
		// REAL N313_7;
		// REAL N313_8;
		// REAL N314_2;
		// REAL N314_3;
		// REAL N314_4;
		// REAL N314_5;
		// REAL N314_6;
		// REAL N314_7;
		// REAL N315_2;
		// REAL N315_3;
		// REAL N315_4;
		// REAL N315_5;
		// REAL N315_6;
		// REAL N316_2;
		// REAL N316_3;
		// REAL N316_4;
		// REAL N316_5;
		// REAL N316_6;
		// REAL N316_7;
		// REAL N316_8;
		// REAL N317_2;
		// REAL N317_3;
		// REAL N317_4;
		// REAL N317_5;
		// REAL N317_6;
		// REAL N318_2;
		// REAL N318_3;
		// REAL N318_4;
		// REAL N318_5;
		// REAL N318_6;
		// REAL N318_7;
		// REAL N319_2;
		// REAL N319_3;
		// REAL N319_4;
		// REAL N319_5;
		// REAL N319_6;
		// REAL N319_7;
		// REAL N319_8;
		// REAL N320_2;
		// REAL N320_3;
		// REAL N320_4;
		// REAL N320_5;
		// REAL N320_6;
		// REAL N320_7;
		// REAL N321_2;
		// REAL N321_3;
		// REAL N321_4;
		// REAL N321_5;
		// REAL N321_6;
		// REAL N321_7;
		// REAL N321_8;
		// REAL N322_2;
		// REAL N322_3;
		// REAL N322_4;
		// REAL N322_5;
		// REAL N322_6;
		// REAL N322_7;
		// REAL N322_8;
		// REAL N323_2;
		// REAL N323_3;
		// REAL N323_4;
		// REAL N323_5;
		// REAL N323_6;
		// REAL N324_2;
		// REAL N324_3;
		// REAL N324_4;
		// REAL N324_5;
		// REAL N324_6;
		// REAL N324_7;
		// REAL N325_2;
		// REAL N325_3;
		// REAL N325_4;
		// REAL N325_5;
		// REAL N325_6;
		// REAL N325_7;
		// REAL N325_8;
		// REAL N326_2;
		// REAL N326_3;
		// REAL N326_4;
		// REAL N326_5;
		// REAL N326_6;
		// REAL N326_7;
		// REAL N326_8;
		// REAL N326_9;
		// REAL N326_10;
		// REAL N327_2;
		// REAL N327_3;
		// REAL N327_4;
		// REAL N327_5;
		// REAL N327_6;
		// REAL N327_7;
		// REAL N328_2;
		// REAL N328_3;
		// REAL N328_4;
		// REAL N328_5;
		// REAL N328_6;
		// REAL N328_7;
		// REAL N329_2;
		// REAL N329_3;
		// REAL N329_4;
		// REAL N329_5;
		// REAL N329_6;
		// REAL N329_7;
		// REAL N330_2;
		// REAL N330_3;
		// REAL N330_4;
		// REAL N330_5;
		// REAL N330_6;
		// REAL N330_7;
		// REAL N331_2;
		// REAL N331_3;
		// REAL N331_4;
		// REAL N331_5;
		// REAL N331_6;
		// REAL N331_7;
		// REAL N332_2;
		// REAL N332_3;
		// REAL N332_4;
		// REAL N332_5;
		// REAL N332_6;
		// REAL N332_7;
		// REAL N333_2;
		// REAL N333_3;
		// REAL N333_4;
		// REAL N333_5;
		// REAL N333_6;
		// REAL N333_7;
		// REAL N334_2;
		// REAL N334_3;
		// REAL N334_4;
		// REAL N334_5;
		// REAL N334_6;
		// REAL N334_7;
		// REAL N334_8;
		// REAL N335_2;
		// REAL N335_3;
		// REAL N335_4;
		// REAL N335_5;
		// REAL N335_6;
		// REAL N335_7;
		// REAL N336_2;
		// REAL N336_3;
		// REAL N336_4;
		// REAL N336_5;
		// REAL N336_6;
		// REAL N336_7;
		// REAL N336_8;
		// REAL N337_2;
		// REAL N337_3;
		// REAL N337_4;
		// REAL N337_5;
		// REAL N337_6;
		// REAL N337_7;
		// REAL N338_2;
		// REAL N338_3;
		// REAL N338_4;
		// REAL N338_5;
		// REAL N338_6;
		// REAL N338_7;
		// REAL N338_8;

		REAL N0_1;
		REAL N1_1;
		REAL N2_1;
		REAL N3_1;
		REAL N4_1;
		REAL N5_1;
		REAL N6_1;
		REAL N7_1;
		REAL N8_1;
		REAL N9_1;
		REAL N10_1;
		REAL N11_1;
		REAL N12_1;
		REAL N13_1;
		REAL N14_1;
		REAL N15_1;
		REAL N16_1;
		REAL N17_1;
		REAL N18_1;
		REAL N19_1;
		REAL N20_1;
		REAL N21_1;
		REAL N22_1;
		REAL N23_1;
		REAL N24_1;
		REAL N25_1;
		REAL N26_1;
		REAL N27_1;
		REAL N28_1;
		REAL N29_1;
		REAL N30_1;
		REAL N31_1;
		REAL N32_1;
		REAL N33_1;
		REAL N34_1;
		REAL N35_1;
		REAL N36_1;
		REAL N37_1;
		REAL N38_1;
		REAL N39_1;
		REAL N40_1;
		REAL N41_1;
		REAL N42_1;
		REAL N43_1;
		REAL N44_1;
		REAL N45_1;
		REAL N46_1;
		REAL N47_1;
		REAL N48_1;
		REAL N49_1;
		REAL N50_1;
		REAL N51_1;
		REAL N52_1;
		REAL N53_1;
		REAL N54_1;
		REAL N55_1;
		REAL N56_1;
		REAL N57_1;
		REAL N58_1;
		REAL N59_1;
		REAL N60_1;
		REAL N61_1;
		REAL N62_1;
		REAL N63_1;
		REAL N64_1;
		REAL N65_1;
		REAL N66_1;
		REAL N67_1;
		REAL N68_1;
		REAL N69_1;
		REAL N70_1;
		REAL N71_1;
		REAL N72_1;
		REAL N73_1;
		REAL N74_1;
		REAL N75_1;
		REAL N76_1;
		REAL N77_1;
		REAL N78_1;
		REAL N79_1;
		REAL N80_1;
		REAL N81_1;
		REAL N82_1;
		REAL N83_1;
		REAL N84_1;
		REAL N85_1;
		REAL N86_1;
		REAL N87_1;
		REAL N88_1;
		REAL N89_1;
		REAL N90_1;
		REAL N91_1;
		REAL N92_1;
		REAL N93_1;
		REAL N94_1;
		REAL N95_1;
		REAL N96_1;
		REAL N97_1;
		REAL N98_1;
		REAL N99_1;
		REAL N100_1;
		REAL N101_1;
		REAL N102_1;
		REAL N103_1;
		REAL N104_1;
		REAL N105_1;
		REAL N106_1;
		REAL N107_1;
		REAL N108_1;
		REAL N109_1;
		REAL N110_1;
		REAL N111_1;
		REAL N112_1;
		REAL N113_1;
		REAL N114_1;
		REAL N115_1;
		REAL N116_1;
		REAL N117_1;
		REAL N118_1;
		REAL N119_1;
		REAL N120_1;
		REAL N121_1;
		REAL N122_1;
		REAL N123_1;
		REAL N124_1;
		REAL N125_1;
		REAL N126_1;
		REAL N127_1;
		REAL N128_1;
		REAL N129_1;
		REAL N130_1;
		REAL N131_1;
		REAL N132_1;
		REAL N133_1;
		REAL N134_1;
		REAL N135_1;
		REAL N136_1;
		REAL N137_1;
		REAL N138_1;
		REAL N139_1;
		REAL N140_1;
		REAL N141_1;
		REAL N142_1;
		REAL N143_1;
		REAL N144_1;
		REAL N145_1;
		REAL N146_1;
		REAL N147_1;
		REAL N148_1;
		REAL N149_1;
		REAL N150_1;
		REAL N151_1;
		REAL N152_1;
		REAL N153_1;
		REAL N154_1;
		REAL N155_1;
		REAL N156_1;
		REAL N157_1;
		REAL N158_1;
		REAL N159_1;
		REAL N160_1;
		REAL N161_1;
		REAL N162_1;
		REAL N163_1;
		REAL N164_1;
		REAL N165_1;
		REAL N166_1;
		REAL N167_1;
		REAL N168_1;
		REAL N169_1;
		REAL N170_1;
		REAL N171_1;
		REAL N172_1;
		REAL N173_1;
		REAL N174_1;
		REAL N175_1;
		REAL N176_1;
		REAL N177_1;
		REAL N178_1;
		REAL N179_1;
		REAL N180_1;
		REAL N181_1;
		REAL N182_1;
		REAL N183_1;
		REAL N184_1;
		REAL N185_1;
		REAL N186_1;
		REAL N187_1;
		REAL N188_1;
		REAL N189_1;
		REAL N190_1;
		REAL N191_1;
		REAL N192_1;
		REAL N193_1;
		REAL N194_1;
		REAL N195_1;
		REAL N196_1;
		REAL N197_1;
		REAL N198_1;
		REAL N199_1;
		REAL N200_1;
		REAL N201_1;
		REAL N202_1;
		REAL N203_1;
		REAL N204_1;
		REAL N205_1;
		REAL N206_1;
		REAL N207_1;
		REAL N208_1;
		REAL N209_1;
		REAL N210_1;
		REAL N211_1;
		REAL N212_1;
		REAL N213_1;
		REAL N214_1;
		REAL N215_1;
		REAL N216_1;
		REAL N217_1;
		REAL N218_1;
		REAL N219_1;
		REAL N220_1;
		REAL N221_1;
		REAL N222_1;
		REAL N223_1;
		REAL N224_1;
		REAL N225_1;
		REAL N226_1;
		REAL N227_1;
		REAL N228_1;
		REAL N229_1;
		REAL N230_1;
		REAL N231_1;
		REAL N232_1;
		REAL N233_1;
		REAL N234_1;
		REAL N235_1;
		REAL N236_1;
		REAL N237_1;
		REAL N238_1;
		REAL N239_1;
		REAL N240_1;
		REAL N241_1;
		REAL N242_1;
		REAL N243_1;
		REAL N244_1;
		REAL N245_1;
		REAL N246_1;
		REAL N247_1;
		REAL N248_1;
		REAL N249_1;
		REAL N250_1;
		REAL N251_1;
		REAL N252_1;
		REAL N253_1;
		REAL N254_1;
		REAL N255_1;
		REAL N256_1;
		REAL N257_1;
		REAL N258_1;
		REAL N259_1;
		REAL N260_1;
		REAL N261_1;
		REAL N262_1;
		REAL N263_1;
		REAL N264_1;
		REAL N265_1;
		REAL N266_1;
		REAL N267_1;
		REAL N268_1;
		REAL N269_1;
		REAL N270_1;
		REAL N271_1;
		REAL N272_1;
		REAL N273_1;
		REAL N274_1;
		REAL N275_1;
		REAL N276_1;
		REAL N277_1;
		REAL N278_1;
		REAL N279_1;
		REAL N280_1;
		REAL N281_1;
		REAL N282_1;
		REAL N283_1;
		REAL N284_1;
		REAL N285_1;
		REAL N286_1;
		REAL N287_1;
		REAL N288_1;
		REAL N289_1;
		REAL N290_1;
		REAL N291_1;
		REAL N292_1;
		REAL N293_1;
		REAL N294_1;
		REAL N295_1;
		REAL N296_1;
		REAL N297_1;
		REAL N298_1;
		REAL N299_1;
		REAL N300_1;
		REAL N301_1;
		REAL N302_1;
		REAL N303_1;
		REAL N304_1;
		REAL N305_1;
		REAL N306_1;
		REAL N307_1;
		REAL N308_1;
		REAL N309_1;
		REAL N310_1;
		REAL N311_1;
		REAL N312_1;
		REAL N313_1;
		REAL N314_1;
		REAL N315_1;
		REAL N316_1;
		REAL N317_1;
		REAL N318_1;
		REAL N319_1;
		REAL N320_1;
		REAL N321_1;
		REAL N322_1;
		REAL N323_1;
		REAL N324_1;
		REAL N325_1;
		REAL N326_1;
		REAL N327_1;
		REAL N328_1;
		REAL N329_1;
		REAL N330_1;
		REAL N331_1;
		REAL N332_1;
		REAL N333_1;
		REAL N334_1;
		REAL N335_1;
		REAL N336_1;
		REAL N337_1;
		REAL N338_1;

		STRING class_threshold;
		STRING score0;
		STRING score1;
		STRING expsum;
		STRING prob0;
		STRING prob1;
		STRING base;
		STRING pts;
		STRING odds;
		STRING fp1404_1_0;
		STRING pred;
		
		models.layout_modelout;
		risk_indicators.Layout_Boca_Shell clam;
		END;
		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_z5                           := le.shell_input.z5;
		out_addr_type                    := le.shell_input.addr_type;
		out_addr_status                  := le.shell_input.addr_status;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		nap_status                       := le.iid.nap_status;
		cvi                              := le.iid.cvi;
		rc_dl_val_flag                   := le.iid.drlcvalflag;
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
		rc_ssnlowissue                   := le.iid.socllowissue;
		rc_ssnhighissue                  := le.iid.soclhighissue;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_fnamecount                    := le.iid.firstcount;
		rc_addrcount                     := le.iid.addrcount;
		rc_ssncount                      := le.iid.socscount;
		rc_phoneaddrcount                := le.iid.phoneaddrcount;
		rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
		rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
		rc_hphonemiskeyflag              := le.iid.hphonemiskeyflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		rc_phonetype                     := le.iid.phonetype;
		rc_ziptypeflag                   := le.iid.ziptypeflag;
		rc_zipclass                      := le.iid.zipclass;
		rc_statezipflag                  := le.iid.statezipflag;
		rc_cityzipflag                   := le.iid.cityzipflag;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobcount                   := le.iid.combo_dobcount;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		ver_lname_sources                := le.header_summary.ver_lname_sources;
		ver_lname_sources_first_seen     := le.header_summary.ver_lname_sources_first_seen_date;
		ver_lname_sources_count          := le.header_summary.ver_lname_sources_recordcount;
		ver_addr_sources                 := le.header_summary.ver_addr_sources;
		ver_addr_sources_first_seen      := le.header_summary.ver_addr_sources_first_seen_date;
		ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
		ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
		ver_ssn_sources_first_seen       := le.header_summary.ver_ssn_sources_first_seen_date;
		ver_ssn_sources_count            := le.header_summary.ver_ssn_sources_recordcount;
		ver_dob_sources                  := le.header_summary.ver_dob_sources;
		ver_dob_sources_first_seen       := le.header_summary.ver_dob_sources_first_seen_date;
		ver_dob_sources_count            := le.header_summary.ver_dob_sources_recordcount;
		dl_avail                         := le.available_sources.dl;
		voter_avail                      := le.available_sources.voter;
		bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
		bus_name_match                   := le.business_header_address_summary.bus_name_match;
		bus_phone_match                  := le.business_header_address_summary.bus_phone_match;
		fnamepop                         := le.input_validation.firstname;
		lnamepop                         := le.input_validation.lastname;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		source_count                     := le.name_verification.source_count;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		age                              := le.name_verification.age;
		util_adl_type_list               := le.utility.utili_adl_type;
		util_adl_count                   := le.utility.utili_adl_count;
		util_add1_type_list              := le.utility.utili_addr1_type;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_lres                        := le.lres;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
		add1_advo_college                := le.advo_input_addr.college_indicator;
		add1_advo_drop                   := le.advo_input_addr.drop_indicator;
		add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
		add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
		add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
		add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := le.address_verification.input_address_information.building_area;
		add1_nhood_vacant_properties     := le.addr_risk_summary.n_vacant_properties;
		add1_nhood_business_count        := le.addr_risk_summary.n_business_count;
		add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;
		add1_nhood_mfd_count             := le.addr_risk_summary.n_mfd_count;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
		property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
		property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
		prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
		prop2_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price2;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
		add2_lres                        := le.lres2;
		add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
		add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
		add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
		add2_source_count                := le.address_verification.address_history_1.source_count;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
		add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_financing_type              := le.address_verification.address_history_1.type_financing;
		add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
		add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
		add2_nhood_business_count        := le.addr_risk_summary2.n_business_count;
		add2_nhood_sfd_count             := le.addr_risk_summary2.n_sfd_count;
		add2_nhood_mfd_count             := le.addr_risk_summary2.n_mfd_count;
		add3_isbestmatch                 := le.address_verification.address_history_2.isbestmatch;
		add3_lres                        := le.lres3;
		add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
		add3_source_count                := le.address_verification.address_history_2.source_count;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_occupant_owned              := le.address_verification.address_history_2.occupant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		add3_mortgage_date               := le.address_verification.address_history_2.mortgage_date;
		add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
		add3_mortgage_due_date           := le.address_verification.address_history_2.first_td_due_date;
		add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
		avg_lres                         := le.other_address_info.avg_lres;
		max_lres                         := le.other_address_info.max_lres;
		addrs_prison_history             := le.other_address_info.isprison;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
		addr_count2                      := le.address_history_summary.addr_count2;
		addr_count_ge3                   := le.address_history_summary.addr_count3;
		addr_count_ge6                   := le.address_history_summary.addr_count6;
		addr_count_ge10                  := le.address_history_summary.addr_count10;
		addr_lres_6mo_count              := le.address_history_summary.lres_6mo_count;
		addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
		hist_addr_match                  := le.address_history_summary.hist_addr_match;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		header_first_seen                := le.ssn_verification.header_first_seen;
		inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		lnames_per_adl                   := le.velocity_counters.lnames_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
		invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
		invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
		inq_count                        := le.acc_logs.inquiries.counttotal;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_count24                      := le.acc_logs.inquiries.count24;
		inq_collection_count             := le.acc_logs.collection.counttotal;
		inq_collection_count01           := le.acc_logs.collection.count01;
		inq_collection_count03           := le.acc_logs.collection.count03;
		inq_collection_count06           := le.acc_logs.collection.count06;
		inq_collection_count12           := le.acc_logs.collection.count12;
		inq_collection_count24           := le.acc_logs.collection.count24;
		inq_auto_count                   := le.acc_logs.auto.counttotal;
		inq_auto_count01                 := le.acc_logs.auto.count01;
		inq_auto_count03                 := le.acc_logs.auto.count03;
		inq_auto_count06                 := le.acc_logs.auto.count06;
		inq_auto_count12                 := le.acc_logs.auto.count12;
		inq_auto_count24                 := le.acc_logs.auto.count24;
		inq_banking_count                := le.acc_logs.banking.counttotal;
		inq_banking_count01              := le.acc_logs.banking.count01;
		inq_banking_count03              := le.acc_logs.banking.count03;
		inq_banking_count06              := le.acc_logs.banking.count06;
		inq_banking_count12              := le.acc_logs.banking.count12;
		inq_banking_count24              := le.acc_logs.banking.count24;
		inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
		inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
		inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
		inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
		inq_communications_count         := le.acc_logs.communications.counttotal;
		inq_communications_count01       := le.acc_logs.communications.count01;
		inq_communications_count03       := le.acc_logs.communications.count03;
		inq_communications_count06       := le.acc_logs.communications.count06;
		inq_communications_count12       := le.acc_logs.communications.count12;
		inq_communications_count24       := le.acc_logs.communications.count24;
		inq_other_count                  := le.acc_logs.other.counttotal;
		inq_other_count01                := le.acc_logs.other.count01;
		inq_other_count03                := le.acc_logs.other.count03;
		inq_other_count06                := le.acc_logs.other.count06;
		inq_other_count12                := le.acc_logs.other.count12;
		inq_other_count24                := le.acc_logs.other.count24;
		inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
		inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
		inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
		inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
		inq_perssn                       := le.acc_logs.inquiryperssn;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
		inq_lnamesperaddr                := le.acc_logs.inquirylnamesperaddr;
		inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
		inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
		pb_number_of_sources             := le.ibehavior.number_of_sources;
		pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
		pb_average_dollars               := le.ibehavior.average_amount_per_order;
		pb_total_dollars                 := le.ibehavior.total_dollars;
		pb_offline_dollars               := le.ibehavior.offline_dollars;
		pb_online_dollars                := le.ibehavior.online_dollars;
		pb_retail_dollars                := le.ibehavior.retail_dollars;
		paw_first_seen                   := le.employment.first_seen_date;
		paw_dead_business_count          := le.employment.dead_business_ct;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		impulse_first_seen               := le.impulse.first_seen_date;
		impulse_last_seen                := le.impulse.last_seen_date;
		impulse_annual_income            := le.impulse.annual_income;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_date_first_purchase         := le.other_address_info.date_first_purchase;
		attr_num_purchase30              := le.other_address_info.num_purchase30;
		attr_num_purchase90              := le.other_address_info.num_purchase90;
		attr_num_purchase180             := le.other_address_info.num_purchase180;
		attr_num_purchase12              := le.other_address_info.num_purchase12;
		attr_num_purchase24              := le.other_address_info.num_purchase24;
		attr_num_purchase36              := le.other_address_info.num_purchase36;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_sold60                  := le.other_address_info.num_sold60;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_felonies30                  := le.bjl.criminal_count30;
		attr_felonies90                  := le.bjl.criminal_count90;
		attr_felonies180                 := le.bjl.criminal_count180;
		attr_felonies12                  := le.bjl.criminal_count12;
		attr_felonies24                  := le.bjl.criminal_count24;
		attr_felonies36                  := le.bjl.criminal_count36;
		attr_felonies60                  := le.bjl.criminal_count60;
		attr_arrests                     := le.bjl.arrests_count;
		attr_arrests30                   := le.bjl.arrests_count30;
		attr_arrests90                   := le.bjl.arrests_count90;
		attr_arrests180                  := le.bjl.arrests_count180;
		attr_arrests12                   := le.bjl.arrests_count12;
		attr_arrests24                   := le.bjl.arrests_count24;
		attr_arrests36                   := le.bjl.arrests_count36;
		attr_arrests60                   := le.bjl.arrests_count60;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_num_rel_liens30             := le.bjl.liens_released_count30;
		attr_num_rel_liens90             := le.bjl.liens_released_count90;
		attr_num_rel_liens180            := le.bjl.liens_released_count180;
		attr_num_rel_liens12             := le.bjl.liens_released_count12;
		attr_num_rel_liens24             := le.bjl.liens_released_count24;
		attr_num_rel_liens36             := le.bjl.liens_released_count36;
		attr_num_rel_liens60             := le.bjl.liens_released_count60;
		attr_bankruptcy_count30          := le.bjl.bk_count30;
		attr_bankruptcy_count90          := le.bjl.bk_count90;
		attr_bankruptcy_count180         := le.bjl.bk_count180;
		attr_bankruptcy_count12          := le.bjl.bk_count12;
		attr_bankruptcy_count24          := le.bjl.bk_count24;
		attr_bankruptcy_count36          := le.bjl.bk_count36;
		attr_bankruptcy_count60          := le.bjl.bk_count60;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count90            := le.bjl.eviction_count90;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_proflic30               := le.professional_license.proflic_count30;
		attr_num_proflic90               := le.professional_license.proflic_count90;
		attr_num_proflic180              := le.professional_license.proflic_count180;
		attr_num_proflic12               := le.professional_license.proflic_count12;
		attr_num_proflic24               := le.professional_license.proflic_count24;
		attr_num_proflic36               := le.professional_license.proflic_count36;
		attr_num_proflic60               := le.professional_license.proflic_count60;
		fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
		fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
		fp_idveraddressnotcurrent        := le.fdattributesv2.idveraddressnotcurrent;
		fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
		fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
		fp_varmsrcssncount               := le.fdattributesv2.variationmsourcesssncount;
		fp_varmsrcssnunrelcount          := le.fdattributesv2.variationmsourcesssnunrelcount;
		fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
		fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
		fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
		fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
		fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
		fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
		fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
		fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
		fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
		fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
		fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
		fp_assoccredbureaucountnew       := le.fdattributesv2.assoccreditbureauonlycountnew;
		fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
		fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
		fp_corrssnnamecount              := le.fdattributesv2.correlationssnnamecount;
		fp_corrssnaddrcount              := le.fdattributesv2.correlationssnaddrcount;
		fp_corraddrnamecount             := le.fdattributesv2.correlationaddrnamecount;
		fp_corraddrphonecount            := le.fdattributesv2.correlationaddrphonecount;
		fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
		fp_divrisktype                   := le.fdattributesv2.divrisklevel;
		fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
		fp_divsrchaddrsuspidcount        := le.fdattributesv2.divsearchaddrsuspidentitycount;
		fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
		fp_srchssnsrchcount              := le.fdattributesv2.searchssnsearchcount;
		fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
		fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
		fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
		fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
		fp_srchphonesrchcount            := le.fdattributesv2.searchphonesearchcount;
		fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
		fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
		fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
		fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
		fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
		fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
		fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
		fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
		fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
		fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
		fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
		fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
		fp_prevaddrdwelltype             := le.fdattributesv2.prevaddrdwelltype;
		fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
		fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
		fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
		fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
		fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
		fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		felony_last_date                 := le.bjl.last_felony_date;
		rel_count                        := le.relatives.relative_count;
		rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
		rel_criminal_count               := le.relatives.relative_criminal_count;
		rel_felony_count                 := le.relatives.relative_felony_count;
		crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
		crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
		crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
		crim_rel_withinother             := le.relatives.criminal_relative_withinother;
		rel_within25miles_count          := le.relatives.relative_within25miles_count;
		rel_within100miles_count         := le.relatives.relative_within100miles_count;
		rel_within500miles_count         := le.relatives.relative_within500miles_count;
		rel_withinother_count            := le.relatives.relative_withinother_count;
		rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
		rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
		rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		rel_homeunder50_count            := le.relatives.relative_homeunder50_count;
		rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
		rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
		rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
		rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
		rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
		rel_homeover500_count            := le.relatives.relative_homeover500_count;
		rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
		rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
		rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
		rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
		rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
		rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
		rel_ageover70_count              := le.relatives.relative_ageover70_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		acc_count                        := le.accident_data.acc.num_accidents;
		acc_count_30                     := le.accident_data.acc.numaccidents30;
		acc_count_90                     := le.accident_data.acc.numaccidents90;
		acc_count_180                    := le.accident_data.acc.numaccidents180;
		acc_count_12                     := le.accident_data.acc.numaccidents12;
		acc_count_24                     := le.accident_data.acc.numaccidents24;
		acc_count_36                     := le.accident_data.acc.numaccidents36;
		acc_count_60                     := le.accident_data.acc.numaccidents60;
		ams_date_first_seen              := le.student.date_first_seen;
		ams_age                          := le.student.age;
		ams_class                        := le.student.class;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		ams_file_type                    := le.student.file_type2;
		ams_college_tier                 := le.student.college_tier;
		ams_college_major                := le.student.college_major;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;

		c_ab_av_edu                      := ri.ab_av_edu;
		c_armforce                       := ri.armforce;
		c_asian_lang                     := ri.asian_lang;
		c_bargains                       := ri.bargains;
		c_bel_edu                        := ri.bel_edu;
		c_blue_col                       := ri.blue_col;
		c_blue_empl                      := ri.blue_empl;
		c_burglary                       := ri.burglary;
		c_business                       := ri.business;
		c_cartheft                       := ri.cartheft;
		c_child                          := ri.child;
		c_civ_emp                        := ri.civ_emp;
		c_construction                   := ri.construction;
		c_cpiall                         := ri.cpiall;
		c_easiqlife                      := ri.easiqlife;
		c_exp_prod                       := ri.exp_prod;
		c_families                       := ri.families;
		c_fammar18_p                     := ri.fammar18_p;
		c_fammar_p                       := ri.fammar_p;
		c_famotf18_p                     := ri.famotf18_p;
		c_femdiv_p                       := ri.femdiv_p;
		c_finance                        := ri.finance;
		c_health                         := ri.health;
		c_hh00                           := ri.hh00;
		c_hh1_p                          := ri.hh1_p;
		c_hh2_p                          := ri.hh2_p;
		c_hh3_p                          := ri.hh3_p;
		c_hh4_p                          := ri.hh4_p;
		c_hh5_p                          := ri.hh5_p;
		c_hh6_p                          := ri.hh6_p;
		c_hh7p_p                         := ri.hh7p_p;
		c_hhsize                         := ri.hhsize;
		c_high_ed                        := ri.high_ed;
		c_high_hval                      := ri.high_hval;
		c_highinc                        := ri.highinc;
		c_housingcpi                     := ri.housingcpi;
		c_hval_100k_p                    := ri.hval_100k_p;
		c_hval_125k_p                    := ri.hval_125k_p;
		c_hval_175k_p                    := ri.hval_175k_p;
		c_hval_200k_p                    := ri.hval_200k_p;
		c_hval_250k_p                    := ri.hval_250k_p;
		c_hval_300k_p                    := ri.hval_300k_p;
		c_hval_400k_p                    := ri.hval_400k_p;
		c_hval_40k_p                     := ri.hval_40k_p;
		c_hval_500k_p                    := ri.hval_500k_p;
		c_hval_60k_p                     := ri.hval_60k_p;
		c_hval_80k_p                     := ri.hval_80k_p;
		c_inc_125k_p                     := ri.in125k_p;
		c_inc_15k_p                      := ri.in15k_p;
		c_inc_25k_p                      := ri.in25k_p;
		c_inc_35k_p                      := ri.in35k_p;
		c_inc_50k_p                      := ri.in50k_p;
		c_inc_75k_p                      := ri.in75k_p;
		c_incollege                      := ri.incollege;
		c_larceny                        := ri.larceny;
		c_low_ed                         := ri.low_ed;
		c_low_hval                       := ri.low_hval;
		c_lowinc                         := ri.lowinc;
		c_lowrent                        := ri.lowrent;
		c_manufacturing                  := ri.manufacturing;
		c_many_cars                      := ri.many_cars;
		c_med_age                        := ri.med_age;
		c_med_hhinc                      := ri.med_hhinc;
		c_med_hval                       := ri.med_hval;
		c_med_yearblt                    := ri.med_yearblt;
		c_medi_indx                      := ri.medi_indx;
		c_mining                         := ri.mining;
		c_mort_indx                      := ri.mort_indx;
		c_murders                        := ri.murders;
		c_newhouse                       := ri.newhouse;
		c_no_car                         := ri.no_car;
		c_no_labfor                      := ri.no_labfor;
		c_no_teens                       := ri.no_teens;
		c_occunit_p                      := ri.occunit_p;
		c_old_homes                      := ri.old_homes;
		c_oldhouse                       := ri.oldhouse;
		c_ownocc_p                       := ri.ownocp;
		c_pop00                          := ri.pop00;
		c_pop_0_5_p                      := ri.pop_0_5_p;
		c_pop_12_17_p                    := ri.pop_12_17_p;
		c_pop_18_24_p                    := ri.pop_18_24_p;
		c_pop_25_34_p                    := ri.pop_25_34_p;
		c_pop_35_44_p                    := ri.pop_35_44_p;
		c_pop_45_54_p                    := ri.pop_45_54_p;
		c_pop_55_64_p                    := ri.pop_55_64_p;
		c_pop_75_84_p                    := ri.pop_75_84_p;
		c_pop_85p_p                      := ri.pop_85p_p;
		c_popover18                      := ri.popover18;
		c_popover25                      := ri.popover25;
		c_preschl                        := ri.preschl;
		c_professional                   := ri.professional;
		c_rape                           := ri.rape;
		c_relig_indx                     := ri.relig_indx;
		c_rental                         := ri.rental;
		c_rentocc_p                      := ri.rentocp;
		c_rest_indx                      := ri.rest_indx;
		c_retail                         := ri.retail;
		c_retired                        := ri.retired;
		c_retired2                       := ri.retired2;
		c_rich_fam                       := ri.rich_fam;
		c_rich_hisp                      := ri.rich_hisp;
		c_rich_wht                       := ri.rich_wht;
		c_rnt1000_p                      := ri.rnt1000_p;
		c_rnt1250_p                      := ri.rnt1250_p;
		c_rnt250_p                       := ri.rnt250_p;
		c_rnt750_p                       := ri.rnt750_p;
		c_robbery                        := ri.robbery;
		c_serv_empl                      := ri.serv_empl;
		c_sfdu_p                         := ri.sfdu_p;
		c_span_lang                      := ri.span_lang;
		c_sub_bus                        := ri.sub_bus;
		c_totcrime                       := ri.totcrime;
		c_totsales                       := ri.totsales;
		c_trailer                        := ri.trailer;
		c_transport                      := ri.transport;
		c_unattach                       := ri.unattach;
		c_unemp                          := ri.unemp;
		c_unempl                         := ri.unempl;
		c_very_rich                      := ri.very_rich;
		c_white_col                      := ri.white_col;
		c_wholesale                      := ri.wholesale;
		c_work_home                      := ri.work_home;
		c_young                          := ri.young;

	NULL :=__common__( -999999999);

	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

	string zero_fill(string src_string, integer len) := function
		return ('00000' + src_string)[length(src_string) + 5 - len + 1..];
	end;

	sysdate :=__common__( common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')));

	ssnpop :=__common__( (integer)ssnlength > 0);

	ver_src_ds :=__common__( Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0);

	ver_src_eq :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0);

	ver_src_en :=__common__( Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') > 0);

	ver_src_tn :=__common__( Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') > 0);

	ver_src_tu :=__common__( Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') > 0);

//	ver_src_cnt := sum(if(ver_sources = NULL, 0, 1), if(',' = NULL, 0, 1));
	ver_src_cnt :=__common__( Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') );
	
	credit_source_cnt :=__common__( if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu)));

	bureauonly2 :=__common__( credit_source_cnt > 0 and credit_source_cnt = ver_src_cnt and (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

	_derog :=__common__( felony_count > 0 or addrs_prison_history or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0);

	fp_segment_1 :=__common__( map(
		not ssnpop                                                                    => '0 No SSN         ',
		ver_src_ds or rc_decsflag = '1' or rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1 SSN Prob       ',
		(nas_summary in [4, 7, 9])                                                    => '2 NAS 479        ',
		nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                      => '3 New DID        ',
		bureauonly2                                                                   => '4 Bureau Only    ',
		_derog                                                                        => '5 Derog          ',
		Inq_count03 > 0                                                               => '6 Recent Activity',
																						 '7 Other          '));

	iv_add_apt :=__common__( if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0'));

	_in_dob :=__common__( common.sas_date((string)(in_dob)));

//	yr_in_dob := if(in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);
	yr_in_dob := __common__( map(
			in_dob = '' 	=> -1, 
		 _in_dob = NULL			=> NULL,
			in_dob = '0' 	=> 0, 
											 (sysdate - _in_dob) / 365.25) );   


	yr_in_dob_int :=__common__( if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

	age_estimate :=__common__( map(
		yr_in_dob_int > 0 => yr_in_dob_int,
		inferred_age > 0  => inferred_age,
							 -1));

	iv_ag001_age_1 :=__common__( if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate))));

	iv_vs002_ssn_prior_dob_1 :=__common__( map(
		not((integer)ssnlength > 0 and dobpop)            => ' ',
		rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1',
		rc_ssndobflag = '0' or rc_pwssndobflag = '0' => '0',
													' '));

	iv_vs100_ssn_problem_1 :=__common__( map(
		not((integer)ssnlength > 0)                                                                                                                                                                                                                                                => ' ',
		dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or truedid and invalid_ssns_per_adl >= 2 or truedid and invalid_ssns_per_adl_c6 >= 1                                                                                                                        => '2',
		rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          => '1',
		rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 => '0',
																																																																			 ' '));

	iv_vp091_phnzip_mismatch :=__common__( map(
		not(hphnpop and not(out_z5 = ''))          => ' ',
		rc_phonezipflag = '1' or rc_pwphonezipflag = '1' => '1',
		rc_phonezipflag = '0' or rc_pwphonezipflag = '0' => '0',
														' '));

	iv_vp001_phn_not_issued :=__common__( map(
		not(hphnpop)                 => ' ',
		(rc_pwphonezipflag in ['4']) => '1',
										'0'));

	iv_vp008_phn_pay_phone :=__common__( map(
		not(hphnpop)                                           => ' ',
		trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'A' => '1',
																  '0'));

	iv_vp050_phn_cmp_pcs :=__common__( map(
		not(hphnpop)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => ' ',
		rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60' or rc_hriskphoneflag = '2' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' or rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '57' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '58' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '62' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '63' => '1',
																																																																																																																																																																																																																																																																																		 '0'));

	iv_vp100_phn_prob :=__common__( map(
		not(hphnpop)                                                                                           => '                   ',
		rc_hphonetypeflag = 'A'                                                                                => '8 Pay_Phone        ',
		rc_hriskphoneflag = '3' or rc_hphonetypeflag = '3' or (telcordia_type in ['64', '65', '66', '67', '68']) => '7 PCS              ',
		rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61'])             => '6 Pager            ',
		rc_hriskphoneflag = '1' or rc_hphonetypeflag = '1' or (telcordia_type in ['04', '55', '60'])             => '5 Cell             ',
		rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5'                                        => '4 Invalid          ',
		rc_pwphonezipflag = '4'                                                                                  => '3 Not_Issued       ',
		rc_hriskphoneflag = '5' or nap_status = 'D'                                                              => '2 Disconnected     ',
		rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'        => '1 HiRisk           ',
																												  '0 No Phone Problems'));

	iv_va001_add_po_box :=__common__( map(
		not(add1_pop or not(out_z5 = ''))                                                                                                                                                                                                                          => ' ',
		rc_hriskaddrflag = '1' or rc_ziptypeflag = '1' or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P' => '1',
																																																																		'0'));

	iv_va008_add_throwback :=__common__( map(
		not(add1_pop)                                             => ' ',
		trim(trim(add1_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y' => '1',
																	 '0'));

	add_ec1 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

	add_ec3 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

	add_ec4 :=__common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

	iv_va100_add_problem :=__common__( map(
		not(add1_pop)                                                           => '                        ',
		not(out_z5 = '') and rc_statezipflag = '1'                              => '14 Zip/State Mismatch   ',
		add1_advo_address_vacancy = 'Y'                                         => '13 Vacant               ',
		add1_advo_seasonal_delivery = 'E' or add1_advo_college = 'Y'            => '12 College              ',
		add1_advo_throw_back = 'Y'                                              => '11 Throw Back           ',
		not(out_z5 = '') and rc_statezipflag != '1' and rc_cityzipflag = '1'      => '10 Zip/City Mismatch    ',
		not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2')     => '09 Corporate Zip Code   ',
		not(out_z5 = '') and (rc_hriskaddrflag = '3' or rc_ziptypeflag = '3')     => '08 Military Zip         ',
		(add1_advo_res_or_business in ['B', 'D'])                               => '07 Busines              ',
		rc_addrvalflag = 'N'                                                    => '06 Invalid Address      ',
		add1_advo_drop = 'Y'                                                    => '05 Drop Delivery        ',
		rc_hriskaddrflag = '4' or rc_addrcommflag = '2'                             => '04 HiRisk Commercial    ',
		add_ec1 = 'E'                                                           => '03 Standarization Error ',
		add_ec1 != 'E' and add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '02 Address Standardized ',
		not((add1_advo_mixed_address_usage in ['A', '']))                       => '01 Not Curbside Delivery',
																				   '00 No Address Problems  '));

	iv_db001_bankruptcy_1 :=__common__( map(
		not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
		(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
		(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
		(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																	   '0 - No BK        '));

	iv_po001_inp_addr_naprop :=__common__( if(not(add1_pop), NULL, add1_naprop));

	iv_in001_wealth_index :=__common__( if(not(truedid), ' ', wealth_index));

	iv_in001_college_income :=__common__( map(
		not(truedid)                 => '  ',
		ams_income_level_code = '' => '-1',
										ams_income_level_code));

	iv_ed001_college_ind_26 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 26                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_29 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 29                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_36 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 36                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_37 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 37                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_40 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 40                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_50 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 50                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																												 '0'));

	iv_ed001_college_ind_60 :=__common__( map(
		not(truedid) or (iv_ag001_age_1 in [-1, NULL, 0]) or iv_ag001_age_1 > 60                                                                                              => ' ',
		(ams_college_code != '') or (ams_college_type != '') or ams_college_tier !='' or (ams_college_major != '') or (ams_file_type in ['H', 'C', 'A']) => '1',
		ams_file_type = 'M'                                                                                                                                                   => '0',
		not(ams_class = '') or not(ams_income_level_code = '')                                                                                                            => '1',
																																																																																																																									 '0'));

	iv_phnpop_x_nap_summary :=__common__( map(
		not(hphnpop or addrpop) => '   ',
		hphnpop                 => (string)(nap_summary + 100),
								   zero_fill((string)nap_summary, 3)));

	iv_nap_status :=__common__( if(not(hphnpop or addrpop), ' ', nap_status));

	iv_nas_summary_1 :=__common__( if(not(truedid or (integer)ssnlength > 0), '  ', zero_fill((string)nas_summary, 2)));

	iv_cvi_1 :=__common__( if(not(truedid or (integer)ssnlength > 0) and not(hphnpop or addrpop), '  ', zero_fill((string)cvi, 2)));

	iv_dl_val_flag :=__common__( map(
		not(truedid)         => '         ',
		not(dl_avail)        => 'Not Avail',
		rc_dl_val_flag = '0' => 'Valid    ',
		rc_dl_val_flag = '2' => 'Empty    ',
								'Invalid  '));

	nf_bus_name_match :=__common__( if(not(add1_pop), NULL, bus_name_match));

	nf_bus_phone_match :=__common__( if(not(add1_pop), NULL, bus_phone_match));

	iv_fname_eda_sourced_type :=__common__( map(
		not((hphnpop or addrpop) and fnamepop) => '  ',
		fname_eda_sourced_type = ''          => '-1',
												  fname_eda_sourced_type));

	iv_lname_eda_sourced_type :=__common__( map(
		not((hphnpop or addrpop) and lnamepop) => '  ',
		lname_eda_sourced_type = ''          => '-1',
												  lname_eda_sourced_type));

	iv_addr_ver_sources :=__common__( map(
		not(truedid and add1_pop)                                                  => '             ',
		rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 'Phn & NonPhn ',
		rc_addrcount > 0                                                           => 'NonPhn Only  ',
		rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 'Phn Only     ',
																					  'Addr not Verd'));

	iv_input_dob_match_level :=__common__( if(not(truedid and dobpop), ' ', input_dob_match_level));

	iv_ssn_miskey :=__common__( if(not(truedid and (integer)ssnlength > 0), '', if(rc_ssnmiskeyflag,'1','0')));

	iv_phn_miskey :=__common__( if(not(truedid and (hphnpop or addrpop)), '', if(rc_hphonemiskeyflag,'1','0')));

	iv_dwelltype :=__common__( map(
		not(add1_pop)       => '   ',
		rc_dwelltype = '' => 'SFD',
		rc_dwelltype = 'A'  => 'MFD',
		rc_dwelltype = 'E'  => 'POB',
		rc_dwelltype = 'R'  => 'RR ',
		rc_dwelltype = 'S'  => 'GEN',
							   '   '));

	nf_adl_util_convenience :=__common__( map(
		not(truedid)                            => ' ',
		contains_i(util_adl_type_list, '2') > 0 => '1',
												   '0'));

	nf_add1_util_convenience :=__common__( map(
		not(add1_pop)                            => ' ',
		contains_i(util_add1_type_list, '2') > 0 => '1',
													'0'));

	iv_best_match_address_1 :=__common__( map(
		add1_isbestmatch => 'ADD1',
		add2_isbestmatch => 'ADD2',
		add3_isbestmatch => 'ADD3',
							'NONE'));

	iv_inp_addr_ownership_lvl :=__common__( map(
		not(add1_pop)        => '            ',
		add1_applicant_owned => 'Applicant   ',
		add1_family_owned    => 'Family      ',
		add1_occupant_owned  => 'Occupant    ',
								'No Ownership'));

	iv_inp_own_prop_x_addr_naprop :=__common__( map(
		not(add1_pop)            => '  ',
		property_owned_total > 0 => (string)(add1_naprop + 10),
									zero_fill((string)add1_naprop, 2)));

	_add1_mortgage_date_1 :=__common__( common.sas_date((string)(add1_mortgage_date)));

	_add1_mortgage_due_date_1 :=__common__( common.sas_date((string)(add1_mortgage_due_date)));

	mortgage_date_diff_2 :=__common__( if(not(_add1_mortgage_date_1 = NULL) and not(_add1_mortgage_due_date_1 = NULL), round((_add1_mortgage_due_date_1 - _add1_mortgage_date_1) / 365.25), NULL));

	iv_inp_addr_mortgage_term :=__common__( map(
		not(add1_pop)              => '  ',
		mortgage_date_diff_2 >= 40 => '40',
		mortgage_date_diff_2 >= 30 => '30',
		mortgage_date_diff_2 >= 25 => '25',
		mortgage_date_diff_2 >= 20 => '20',
		mortgage_date_diff_2 >= 15 => '15',
		mortgage_date_diff_2 >= 10 => '10',
		mortgage_date_diff_2 >= 5  => '5',
		mortgage_date_diff_2 >= 0  => '0',
									  '-1'));

	mortgage_type_2 :=__common__( add1_mortgage_type);

	mortgage_present_2 :=__common__( not((add1_mortgage_date in [0, NULL])));

	iv_inp_addr_mortgage_type :=__common__( map(
		not(add1_pop)                                           => '               ',
		(mortgage_type_2 in ['CNV', 'N'])                       => 'Conventional   ',
		(mortgage_type_2 in ['FHA', 'G', 'VA'])                 => 'Government     ',
		(mortgage_type_2 in ['1', 'D'])                         => 'Piggyback      ',
		(mortgage_type_2 in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
		(mortgage_type_2 in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
		(mortgage_type_2 in ['H', 'J'])                         => 'High-Risk      ',
		(mortgage_type_2 in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
		(mortgage_type_2 in ['U'])                              => 'Unknown        ',
		not(mortgage_type_2 = '')                             => 'Other          ',
		mortgage_present_2                                        => 'Unknown        ',
																   'No Mortgage'));

	iv_inp_addr_financing_type :=__common__( map(
		not(add1_pop)              => '     ',
		add1_financing_type = '' => 'NONE ',
									  add1_financing_type));

	iv_bst_addr_naprop :=__common__( map(
		not(truedid)     => ' ',
		add1_isbestmatch => (string)add1_naprop,
							(string)add2_naprop));

	iv_bst_own_prop_x_addr_naprop_c52 :=__common__( if(property_owned_total > 0, (string)(add1_naprop + 10), zero_fill((string)add1_naprop, 2)));

	iv_bst_own_prop_x_addr_naprop_c53 :=__common__( if(property_owned_total > 0, (string)(add2_naprop + 10), zero_fill((string)add2_naprop, 2)));

	iv_bst_own_prop_x_addr_naprop :=__common__( map(
		not(truedid)     => '  ',
		add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c52,
							iv_bst_own_prop_x_addr_naprop_c53));

	_add1_mortgage_date :=__common__( common.sas_date((string)(add1_mortgage_date)));

	_add1_mortgage_due_date :=__common__( common.sas_date((string)(add1_mortgage_due_date)));

	_add2_mortgage_date_1 :=__common__( common.sas_date((string)(add2_mortgage_date)));

	_add2_mortgage_due_date_1 :=__common__( common.sas_date((string)(add2_mortgage_due_date)));
//  iv_bst_addr_mortgage_term_1 not used
/*	iv_bst_addr_mortgage_term_1 := map(
		not(truedid)                                                                                 => '  ',
		add1_isbestmatch and not(_add1_mortgage_date = NULL) and not(_add1_mortgage_due_date = NULL) => NULL,
		add1_isbestmatch                                                                             => NULL,
		not(_add2_mortgage_date_1 = NULL) and not(_add2_mortgage_due_date_1 = NULL)                  => NULL,
																										NULL);
*/
	mortgage_date_diff_1 :=__common__( map(
		not(truedid)                                                                                 => mortgage_date_diff_2,
		add1_isbestmatch and not(_add1_mortgage_date = NULL) and not(_add1_mortgage_due_date = NULL) => round((_add1_mortgage_due_date - _add1_mortgage_date) / 365.25),
		add1_isbestmatch                                                                             => NULL,
		not(_add2_mortgage_date_1 = NULL) and not(_add2_mortgage_due_date_1 = NULL)                  => round((_add2_mortgage_due_date_1 - _add2_mortgage_date_1) / 365.25),
																										NULL));

	iv_bst_addr_mortgage_term :=__common__( map(
		not(truedid)               => '  ',
		mortgage_date_diff_1 >= 40 => '40',
		mortgage_date_diff_1 >= 30 => '30',
		mortgage_date_diff_1 >= 25 => '25',
		mortgage_date_diff_1 >= 20 => '20',
		mortgage_date_diff_1 >= 15 => '15',
		mortgage_date_diff_1 >= 10 => '10',
		mortgage_date_diff_1 >= 5  => '5',
		mortgage_date_diff_1 >= 0  => '0',
									  '-1'));

	mortgage_type_1 :=__common__( if(add1_isbestmatch, add1_mortgage_type, add2_mortgage_type));

	mortgage_present_1 :=__common__( if(add1_isbestmatch, not((add1_mortgage_date in [0, NULL])), not((add2_mortgage_date in [0, NULL]))));

	iv_bst_addr_mortgage_type :=__common__( map(
		not(truedid)                                            => '               ',
		(mortgage_type_1 in ['CNV', 'N'])                       => 'Conventional   ',
		(mortgage_type_1 in ['FHA', 'G', 'VA'])                 => 'Government     ',
		(mortgage_type_1 in ['1', 'D'])                         => 'Piggyback      ',
		(mortgage_type_1 in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
		(mortgage_type_1 in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
		(mortgage_type_1 in ['H', 'J'])                         => 'High-Risk      ',
		(mortgage_type_1 in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
		(mortgage_type_1 in ['U'])                              => 'Unknown        ',
		not(mortgage_type_1 = '')                             => 'Other          ',
		mortgage_present_1                                        => 'Unknown        ',
																   'No Mortgage'));

	iv_bst_addr_financing_type_c59 :=__common__( if(add1_financing_type = '', 'NONE ', add1_financing_type));

	iv_bst_addr_financing_type_c60 :=__common__( if(add2_financing_type = '', 'NONE ', add2_financing_type));

	iv_bst_addr_financing_type :=__common__( map(
		not(truedid)     => '     ',
		add1_isbestmatch => iv_bst_addr_financing_type_c59,
							iv_bst_addr_financing_type_c60));

	iv_bst_addr_avm_land_use :=__common__( map(
		not(truedid)     => ' ',
		add1_isbestmatch => add1_avm_land_use,
							add2_avm_land_use));

	iv_prv_addr_ownership_lvl_c63 :=__common__( map(
		add2_applicant_owned => 'Applicant   ',
		add2_family_owned    => 'Family      ',
		add2_occupant_owned  => 'Occupant    ',
								'No Ownership'));

	iv_prv_addr_ownership_lvl_c64 :=__common__( map(
		add3_applicant_owned => 'Applicant   ',
		add3_family_owned    => 'Family      ',
		add3_occupant_owned  => 'Occupant    ',
								'No Ownership'));

	iv_prv_addr_ownership_lvl :=__common__( map(
		not(truedid)     => '',
		add1_isbestmatch => iv_prv_addr_ownership_lvl_c63,
							iv_prv_addr_ownership_lvl_c64));
// iv_prv_addr_eda_sourced not used
/*	iv_prv_addr_eda_sourced := map(
		not(truedid)     => '            ',
		add1_isbestmatch => NULL,
							NULL);
*/
/*
	iv_prv_own_prop_x_addr_naprop :=__common__( map(
		not(truedid)                                  => '  ',
		add1_isbestmatch and property_owned_total > 0 => (string)add2_naprop,
		add1_isbestmatch                              => zero_fill((string)add2_naprop, 2),
		property_owned_total > 0                      => (string)(add3_naprop + 10),
														 zero_fill((string)add3_naprop, 2)));
														 */
// # warning:  engineer intervention needed -- function put not implemented
iv_prv_own_prop_x_addr_naprop_c122 := __common__( if(property_owned_total > 0, (string2)(add2_naprop + 10), (string2)intformat(add2_naprop, 2,1)) );

// # warning:  engineer intervention needed -- function put not implemented
iv_prv_own_prop_x_addr_naprop_c123 := __common__( if(property_owned_total > 0, (string2)(add3_naprop + 10), (string2)intformat(add3_naprop, 2,1)) );

iv_prv_own_prop_x_addr_naprop := __common__( map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_prv_own_prop_x_addr_naprop_c122,
                        iv_prv_own_prop_x_addr_naprop_c123) );
												
												
	_add2_mortgage_date :=__common__( common.sas_date((string)(add2_mortgage_date)));

	_add2_mortgage_due_date :=__common__( common.sas_date((string)(add2_mortgage_due_date)));

	_add3_mortgage_date :=__common__( common.sas_date((string)(add3_mortgage_date)));

	_add3_mortgage_due_date :=__common__( common.sas_date((string)(add3_mortgage_due_date)));
// iv_prv_addr_mortgage_term_1 not used
/*	iv_prv_addr_mortgage_term_1 := map(
		not(truedid)                                                                                 => '  ',
		add1_isbestmatch and not(_add2_mortgage_date = NULL) and not(_add2_mortgage_due_date = NULL) => NULL,
		add1_isbestmatch                                                                             => NULL,
		not(_add3_mortgage_date = NULL) and not(_add3_mortgage_due_date = NULL)                      => NULL,
																										NULL);
*/
	mortgage_date_diff :=__common__( map(
		not(truedid)                                                                                 => mortgage_date_diff_1,
		add1_isbestmatch and not(_add2_mortgage_date = NULL) and not(_add2_mortgage_due_date = NULL) => round((_add2_mortgage_due_date - _add2_mortgage_date) / 365.25),
		add1_isbestmatch                                                                             => NULL,
		not(_add3_mortgage_date = NULL) and not(_add3_mortgage_due_date = NULL)                      => round((_add3_mortgage_due_date - _add3_mortgage_date) / 365.25),
																										NULL));

	iv_prv_addr_mortgage_term :=__common__( map(
		not(truedid)             => '  ',
		mortgage_date_diff >= 40 => '40',
		mortgage_date_diff >= 30 => '30',
		mortgage_date_diff >= 25 => '25',
		mortgage_date_diff >= 20 => '20',
		mortgage_date_diff >= 15 => '15',
		mortgage_date_diff >= 10 => '10',
		mortgage_date_diff >= 5  => '5',
		mortgage_date_diff >= 0  => '0',
									'-1'));

	mortgage_type :=__common__( if(add1_isbestmatch, add2_mortgage_type, add3_mortgage_type));

	mortgage_present :=__common__( if(add1_isbestmatch, not((add2_mortgage_date in [0, NULL])), not((add3_mortgage_date in [0, NULL]))));

	iv_prv_addr_mortgage_type :=__common__( map(
		not(truedid)                                          => '               ',
		(mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
		(mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
		(mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
		(mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
		(mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
		(mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
		(mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
		(mortgage_type in ['U'])                              => 'Unknown        ',
		not(mortgage_type = '')                             => 'Other          ',
		mortgage_present                                      => 'Unknown        ',
																 'No Mortgage'));

		min_gong_did_first_ct 				:= __common__(	(string)min(if(gong_did_first_ct = NULL, -NULL, gong_did_first_ct), 5) );
		min_gong_did_last_ct					:= __common__(	(string)min(if(gong_did_last_ct = NULL, -NULL, gong_did_last_ct), 3) );
		min_paw_dead_business_count		:= __common__(	(string)min(if(paw_dead_business_count = NULL, -NULL, paw_dead_business_count), 3) );
		min_paw_active_phone_count		:= __common__(	(string)min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 3) );

	//iv_gong_did_fname_x_lname_ct := if(not(truedid), '   ', trim(min(if(gong_did_first_ct = NULL, -NULL, gong_did_first_ct), 5), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min(if(gong_did_last_ct = NULL, -NULL, gong_did_last_ct), 3), LEFT, RIGHT));
	iv_gong_did_fname_x_lname_ct := __common__( if(not(truedid), '   ', trim(min_gong_did_first_ct, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min_gong_did_last_ct, LEFT, RIGHT)) );

	//iv_paw_dead_bus_x_active_phn := if(not(truedid), '   ', trim(min(if(paw_dead_business_count = NULL, -NULL, paw_dead_business_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 3), LEFT, RIGHT));
	iv_paw_dead_bus_x_active_phn := __common__( if(not(truedid), '   ', trim(min_paw_dead_business_count, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min_paw_active_phone_count, LEFT, RIGHT)) );

	iv_infutor_nap :=__common__( if(not(hphnpop), ' ', trim((string)infutor_nap, LEFT)));

	ver_phn_inf :=__common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

	ver_phn_nap :=__common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

	inf_phn_ver_lvl :=__common__( map(
		ver_phn_inf     => 3,
		infutor_nap = 1 => 1,
		infutor_nap = 0 => 0,
						   2));

	nap_phn_ver_lvl :=__common__( map(
		ver_phn_nap     => 3,
		nap_summary = 1 => 1,
		nap_summary = 0 => 0,
						   2));

	iv_nap_phn_ver_x_inf_phn_ver :=__common__( map(
		not(addrpop or hphnpop) => '   ',
		not(hphnpop)            => ' -1',
								   trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT)));

	iv_num_purch_x_num_sold_60 :=__common__( if(not(truedid), '   ', trim((string)min(if(attr_num_purchase60 = NULL, -NULL, attr_num_purchase60), 2), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(attr_num_sold60 = NULL, -NULL, attr_num_sold60), 2), LEFT, RIGHT)));

	iv_rec_vehx_level :=__common__( map(
		not(truedid)                                   => '  ',
		attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
		attr_num_aircraft > 0                          => 'AO',
		watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
														  'XX'));

	//iv_liens_unrel_x_rel := if(not(truedid), '   ', trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim(min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));
	iv_liens_unrel_x_rel := __common__( if(not(truedid), '   ', trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT)) );

	iv_criminal_x_felony :=__common__( if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT)));

	// # warning:  engineer intervention needed -- function indexc not implemented
	ams_major_medical := __common__( if(trim(ams_college_major, ALL) in ['A','E','L','Q','T','V'], '1', '0') );

	// # warning:  engineer intervention needed -- function indexc not implemented
	ams_major_science := __common__( if(trim(ams_college_major, ALL) in ['D','H','M','N'], '1', '0') );

	// # warning:  engineer intervention needed -- function indexc not implemented
	ams_major_liberal := __common__( if(trim(ams_college_major, ALL) in ['C','F','I','J','K','O','W','Y'], '1', '0') );

	// # warning:  engineer intervention needed -- function indexc not implemented
	ams_major_business := __common__( if(trim(ams_college_major, ALL) in ['B','G','P','R','S','Z'], '1', '0') );

	// # warning:  engineer intervention needed -- function indexc not implemented
	ams_major_unknown := __common__( if(trim(ams_college_major, ALL) = 'U', '1', '0') );

	iv_ams_college_major :=__common__( map(
		not(truedid)                             => '                ',
		ams_major_medical <> '0'                        => 'Medical         ',
		ams_major_science <> '0'                       => 'Science         ',
		ams_major_liberal <> '0'                       => 'Liberal Arts    ',
		ams_major_business <> '0'                      => 'Business        ',
		ams_major_unknown  <> '0'                      => 'Unclassified    ',
		not(ams_college_code = '')             => 'Unclassified    ',
		not((ams_date_first_seen in ['0', ' '])) => 'No College Found',
													'No AMS Found'));

	iv_ams_college_tier :=__common__( map(
		not(truedid)            => '  ',
		ams_college_tier = '' => '-1',
								   ams_college_tier));

	iv_prof_license_category :=__common__( map(
		not(truedid)                 => '  ',
		prof_license_category = '' => '-1',
										prof_license_category));

//	sum_dols := if(max((integer)pb_offline_dollars, (integer)pb_online_dollars, (integer)pb_retail_dollars) = NULL, NULL, sum(if((integer)pb_offline_dollars = NULL, 0, (integer)pb_offline_dollars), if((integer)pb_online_dollars = NULL, 0, (integer)pb_online_dollars), if((integer)pb_retail_dollars = NULL, 0, (integer)pb_retail_dollars)));
	sum_dols :=__common__( if(pb_offline_dollars='' and pb_online_dollars = '' and pb_retail_dollars='', NULL, sum(if((integer)pb_offline_dollars = NULL, 0, (integer)pb_offline_dollars), if((integer)pb_online_dollars = NULL, 0, (integer)pb_online_dollars), if((integer)pb_retail_dollars = NULL, 0, (integer)pb_retail_dollars))));

	pct_offline_dols :=__common__( if(sum_dols > 0, (real)pb_offline_dollars / sum_dols, -1));

	pct_retail_dols :=__common__( if(sum_dols > 0, (real)pb_retail_dollars / sum_dols, -1));

	pct_online_dols :=__common__( if(sum_dols > 0, (real)pb_online_dollars / sum_dols, -1));

	iv_pb_profile :=__common__( map(
		not(truedid)                => '                 ',
		(integer)pb_number_of_sources = 0 => '0 No Purch Data  ',
		pct_offline_dols > .50      => '1 Offline Shopper',
		pct_online_dols > .50       => '2 Online Shopper ',
		pct_retail_dols > .50       => '3 Retail Shopper ',
									   '4 Other'));

	iv_pb_order_freq :=__common__( map(
		not(truedid)                     => '                ',
		(integer)pb_number_of_sources = 0      => '0 No Purch Data ',
		pb_average_days_bt_orders = '' => '1 Cant Calculate',
		(integer)pb_average_days_bt_orders <= 7   => '2 Weekly        ',
		(integer)pb_average_days_bt_orders <= 30  => '3 Monthly       ',
		(integer)pb_average_days_bt_orders <= 60  => '4 Semi-monthly  ',
		(integer)pb_average_days_bt_orders <= 90  => '5 Quarterly     ',
		(integer)pb_average_days_bt_orders <= 180 => '6 Semi-yearly   ',
		(integer)pb_average_days_bt_orders <= 365 => '7 Yearly        ',
											'8 Rarely        '));

	nf_fp_idrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_idrisktype, LEFT)));

	nf_fp_idverrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_idverrisktype, LEFT)));

	nf_fp_idveraddressnotcurrent :=__common__( if(not(truedid) , '  ', trim((string)fp_idveraddressnotcurrent, LEFT)));

	nf_fp_sourcerisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_sourcerisktype, LEFT)));

	nf_fp_varrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_varrisktype, LEFT)));

	nf_fp_srchvelocityrisktype :=__common__( if(not(truedid), '  ', trim((string)fp_srchvelocityrisktype, LEFT)));

	nf_fp_assocrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_assocrisktype, LEFT)));

	nf_fp_validationrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_validationrisktype, LEFT)));

	nf_fp_corrrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_corrrisktype, LEFT)));

	nf_fp_divrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_divrisktype, LEFT)));

	nf_fp_srchcomponentrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_srchcomponentrisktype, LEFT)));

	nf_fp_componentcharrisktype :=__common__( if(not(truedid) , '  ', trim((string)fp_componentcharrisktype, LEFT)));

	nf_fp_addrchangeecontrajindex :=__common__( if(not(truedid) , '  ', trim((string)fp_addrchangeecontrajindex, LEFT)));

	nf_fp_prevaddrdwelltype :=__common__( if(not(truedid), '', fp_prevaddrdwelltype));

	nf_fp_prevaddroccupantowned :=__common__( if(not(truedid) , '  ', trim((string)fp_prevaddroccupantowned, LEFT)));

	iv_va060_dist_add_in_bst :=__common__( map(
		not(truedid)       => NULL,
		add1_isbestmatch   => 0,
		dist_a1toa2 = 9999 => NULL,
							  dist_a1toa2));

	_criminal_last_date :=__common__( common.sas_date((string)(criminal_last_date)));

	iv_dc001_mos_since_crim_ls :=__common__( map(
		not(truedid)               => NULL,
		_criminal_last_date = NULL => -1,
									  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

	_felony_last_date :=__common__( common.sas_date((string)(felony_last_date)));

	iv_df001_mos_since_fel_ls :=__common__( map(
		not(truedid)             => NULL,
		_felony_last_date = NULL => -1,
									min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

	iv_dg001_derog_count :=__common__( if(not(truedid), NULL, attr_total_number_derogs));

	iv_de001_eviction_recency :=__common__( map(
		not(truedid)                                                => NULL,
		attr_eviction_count90   >0                                    => 3,
		attr_eviction_count180  >0                                    => 6,
		attr_eviction_count12   >0                                    => 12,
		attr_eviction_count24 >0 and attr_eviction_count >= 2 => 24,
		attr_eviction_count24 >0                                      => 25,
		attr_eviction_count36 >0 and attr_eviction_count >= 2 => 36,
		attr_eviction_count36 >0                                      => 37,
		attr_eviction_count60 >0 and attr_eviction_count >= 2 => 60,
		attr_eviction_count60 >0                                      => 61,
		attr_eviction_count >= 2                                    => 98,
		attr_eviction_count >= 1                                    => 99,
																	   0));

	email_src_im :=__common__( Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0);

	iv_ds001_impulse_count :=__common__( map(
		not(truedid)                           => NULL,
		impulse_count = 0 and email_src_im 		 => 1,
												  impulse_count));

	iv_dl001_unrel_lien60_count :=__common__( if(not(truedid), NULL, attr_num_unrel_liens60));

	lien_adl_li_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'));

	lien_adl_lseen_li :=__common__( if(lien_adl_li_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_li_lseen_pos, ',')));

	_lien_adl_lseen_li :=__common__( common.sas_date((string)(lien_adl_lseen_li)));

	lien_adl_l2_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'));

	lien_adl_lseen_l2 :=__common__( if(lien_adl_l2_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, lien_adl_l2_lseen_pos, ',')));

	_lien_adl_lseen_l2 :=__common__( common.sas_date((string)(lien_adl_lseen_l2)));

	_src_lien_adl_lseen :=__common__( max(_lien_adl_lseen_li, _lien_adl_lseen_l2, -1));

	iv_dl001_lien_last_seen :=__common__( map(
		not(truedid)             => NULL,
		_src_lien_adl_lseen = -1 => -1,
									if ((sysdate - _src_lien_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_lien_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_lien_adl_lseen) / (365.25 / 12)))));

	bureau_adl_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'));

	bureau_adl_fseen_tn :=__common__( if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ',')));

	_bureau_adl_fseen_tn :=__common__( common.sas_date((string)(bureau_adl_fseen_tn)));

	bureau_adl_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'));

	bureau_adl_fseen_ts :=__common__( if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ',')));

	_bureau_adl_fseen_ts :=__common__( common.sas_date((string)(bureau_adl_fseen_ts)));

	bureau_adl_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'));

	bureau_adl_fseen_tu :=__common__( if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ',')));

	_bureau_adl_fseen_tu :=__common__( common.sas_date((string)(bureau_adl_fseen_tu)));

	bureau_adl_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'));

	bureau_adl_fseen_en :=__common__( if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ',')));

	_bureau_adl_fseen_en :=__common__( common.sas_date((string)(bureau_adl_fseen_en)));

	bureau_adl_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'));

	bureau_adl_fseen_eq :=__common__( if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ',')));

	_bureau_adl_fseen_eq :=__common__( common.sas_date((string)(bureau_adl_fseen_eq)));

	_src_bureau_adl_fseen_1 :=__common__( min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999));

	iv_sr001_m_bureau_adl_fs :=__common__( map(
		not(truedid)                     => NULL,
		_src_bureau_adl_fseen_1 = 999999 => -1,
											if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)))));

	bureau_adl_vo_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

	bureau_adl_fseen_vo :=__common__( if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ',')));

	_bureau_adl_fseen_vo :=__common__( common.sas_date((string)(bureau_adl_fseen_vo)));

	_src_bureau_adl_fseen :=__common__( _bureau_adl_fseen_vo);

	mth_ver_src_fdate_vo :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_adl_fseen = NULL => -1,
										if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))));

	bureau_adl_vo_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

	bureau_adl_lseen_vo :=__common__( if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ',')));

	_bureau_adl_lseen_vo :=__common__( common.sas_date((string)(bureau_adl_lseen_vo)));

	_src_bureau_adl_lseen_2 :=__common__( _bureau_adl_lseen_vo);

	mth_ver_src_ldate_vo :=__common__( map(
		not(truedid)                   => NULL,
		_src_bureau_adl_lseen_2 = NULL => -1,
										  if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)))));

	mth_ver_src_fdate_vo60 :=__common__( mth_ver_src_fdate_vo > 60);

	mth_ver_src_ldate_vo0 :=__common__( mth_ver_src_ldate_vo = 0);

	bureau_adl_w_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'));

	bureau_adl_lseen_w :=__common__( if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ',')));

	_bureau_adl_lseen_w :=__common__( common.sas_date((string)(bureau_adl_lseen_w)));

	_src_bureau_adl_lseen_1 :=__common__( _bureau_adl_lseen_w);

	mth_ver_src_ldate_w :=__common__( map(
		not(truedid)                   => NULL,
		_src_bureau_adl_lseen_1 = NULL => -1,
										  if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)))));

	mth_ver_src_ldate_w0 :=__common__( mth_ver_src_ldate_w = 0);

	bureau_adl_wp_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'));

	bureau_adl_lseen_wp :=__common__( if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ',')));

	_bureau_adl_lseen_wp :=__common__( common.sas_date((string)(bureau_adl_lseen_wp)));

	_src_bureau_adl_lseen :=__common__( _bureau_adl_lseen_wp);

	mth_ver_src_ldate_wp :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_adl_lseen = NULL => -1,
										if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)))));

	mth_ver_src_ldate_wp0 :=__common__( mth_ver_src_ldate_wp = 0);

	_paw_first_seen :=__common__( common.sas_date((string)(PAW_first_seen)));

	mth_paw_first_seen :=__common__( map(
		not(truedid)           => NULL,
		_paw_first_seen = NULL => -1,
								  if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))));

	mth_paw_first_seen2 :=__common__( if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen))));

	ver_src_am :=__common__( Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0);

	ver_src_e1 :=__common__( Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0);

	ver_src_e2 :=__common__( Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0);

	ver_src_e3 :=__common__( Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0);

	ver_src_pl :=__common__( Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0);

	ver_src_w :=__common__( Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0);

	paw_dead_business_count_gt3 :=__common__( paw_dead_business_count > 3);

	paw_active_phone_count_0 :=__common__( paw_active_phone_count <= 0);

	_infutor_first_seen_1 :=__common__( common.sas_date((string)(infutor_first_seen)));

	mth_infutor_first_seen :=__common__( map(
		not(truedid)                 => NULL,
		_infutor_first_seen_1 = NULL => NULL,
										if ((sysdate - _infutor_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen_1) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen_1) / (365.25 / 12)))));

	_infutor_last_seen_1 :=__common__( common.sas_date((string)(infutor_last_seen)));

	mth_infutor_last_seen :=__common__( map(
		not(truedid)                => NULL,
		_infutor_last_seen_1 = NULL => NULL,
									   if ((sysdate - _infutor_last_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen_1) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen_1) / (365.25 / 12)))));

	infutor_i :=__common__( map(
		infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
		infutor_nap = 12                                                                 => 4,
		infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
		infutor_nap = 11                                                                 => 5,
		infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
		infutor_nap >= 7                                                                 => 7,
		(infutor_nap in [1, 6])                                                          => 8,
		(infutor_nap in [0])                                                             => 2,
																							7));

	infutor_im :=__common__( map(
		infutor_i = 1 => 7.77,
		infutor_i = 2 => 8.06,
		infutor_i = 3 => 8.38,
		infutor_i = 4 => 8.96,
		infutor_i = 5 => 9.35,
		infutor_i = 6 => 10.19,
		infutor_i = 7 => 13.13,
		infutor_i = 8 => 14.77,
						 9.03));

	white_pages_adl_wp_fseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'));

	white_pages_adl_fseen_wp :=__common__( if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ',')));

	_white_pages_adl_fseen_wp :=__common__( common.sas_date((string)(white_pages_adl_fseen_wp)));

	_src_white_pages_adl_fseen :=__common__( _white_pages_adl_fseen_wp);

	iv_sr001_m_wp_adl_fs :=__common__( map(
		not(truedid)                      => NULL,
		_src_white_pages_adl_fseen = NULL => -1,
											 if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)))));

	src_m_wp_adl_fs :=__common__( map(
		iv_sr001_m_wp_adl_fs = NULL => -1,
		iv_sr001_m_wp_adl_fs = -1   => 10,
		iv_sr001_m_wp_adl_fs >= 24  => 24,
									   iv_sr001_m_wp_adl_fs));

	_header_first_seen :=__common__( common.sas_date((string)(header_first_seen)));

	iv_sr001_m_hdr_fs :=__common__( map(
		not(truedid)                   => NULL,
		not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
										  -1));

	src_m_hdr_fs :=__common__( map(
		iv_sr001_m_hdr_fs = NULL => 15,
		iv_sr001_m_hdr_fs = -1   => 40,
		iv_sr001_m_hdr_fs >= 260 => 260,
									iv_sr001_m_hdr_fs));

	source_mod6_1 :=__common__( -2.350792319 +
		(integer)ver_src_am * -0.611853123 +
		(integer)ver_src_e1 * -0.208450798 +
		(integer)ver_src_e2 * -0.23159296 +
		(integer)ver_src_e3 * -0.415443106 +
		(integer)ver_src_pl * -0.275168358 +
		(integer)mth_ver_src_fdate_vo60 * -0.119660071 +
		(integer)mth_ver_src_ldate_vo0 * -0.322346162 +
		(integer)ver_src_w * -0.232332713 +
		(integer)mth_ver_src_ldate_w0 * -0.371580672 +
		(integer)mth_ver_src_ldate_wp0 * -0.149556634 +
		mth_paw_first_seen2 * -0.002615342 +
		(integer)paw_dead_business_count_gt3 * 1.3423068152 +
		(integer)paw_active_phone_count_0 * 0.3754685927 +
		infutor_im * 0.061827139 +
		src_m_wp_adl_fs * -0.006650973 +
		src_m_hdr_fs * -0.004903484);

	source_mod6 :=__common__( exp(source_mod6_1) / (1 + exp(source_mod6_1)));

	source_profile_temp := __common__( (100 - (500 * source_mod6)) );
	iv_sr001_source_profile := __common__( if(not(truedid), NULL, max(0, round(source_profile_temp * 10) / 10)) );
//	iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round(100 - 500 * source_mod6/0.1)*0.1));

	iv_ms001_ssns_per_adl :=__common__( map(
		not(truedid)     => NULL,
		ssns_per_adl = 0 => 1,
							ssns_per_adl));

	iv_pv001_inp_avm_autoval :=__common__( if(not(add1_pop), NULL, add1_avm_automated_valuation));

	iv_pv001_bst_avm_autoval :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	bst_addr_avm_auto_val_2 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation_2,
							add2_avm_automated_valuation_2));

	iv_pv001_bst_avm_chg_1yr_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => NULL,
							NULL));

	iv_pv001_bst_avm_chg_1yr_pct_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => NULL,
							NULL));

	bst_addr_avm_auto_val_1_3 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	iv_pv001_bst_avm_chg_1yr :=__common__( if(bst_addr_avm_auto_val_1_3 > 0 and bst_addr_avm_auto_val_2 > 0, bst_addr_avm_auto_val_1_3 - bst_addr_avm_auto_val_2, NULL));

	iv_pv001_bst_avm_chg_1yr_pct :=__common__( if(bst_addr_avm_auto_val_1_3 > 0 and bst_addr_avm_auto_val_2 > 0, round(100 * bst_addr_avm_auto_val_1_3 / bst_addr_avm_auto_val_2/0.1)*0.1, NULL));

	inp_addr_date_first_seen :=__common__( common.sas_date((string)(add1_date_first_seen)));

	iv_pl001_m_snc_in_addr_fs :=__common__( map(
		not(add1_pop)                   => NULL,
		inp_addr_date_first_seen = NULL => -1,
										   if ((sysdate - inp_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - inp_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - inp_addr_date_first_seen) / (365.25 / 12)))));

	iv_pl001_bst_addr_lres :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_lres,
							add2_lres));

	iv_pl002_avg_mo_per_addr :=__common__( map(
		not(truedid)            => NULL,
		avg_mo_per_addr = -9999 => -1,
		unique_addr_count = 0   => -1,
								   avg_mo_per_addr));

	iv_pl002_addrs_per_ssn_c6_1 :=__common__( if(not((integer)ssnlength > 0), NULL, addrs_per_ssn_c6));

	iv_iq001_inq_count12 :=__common__( if(not(truedid), NULL, inq_count12));

	bureau_ssn_tn_count_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E'));

	bureau_ssn_count_tn :=__common__( if(bureau_ssn_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_tn_count_pos, ',')));

	bureau_ssn_ts_count_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E'));

	bureau_ssn_count_ts :=__common__( if(bureau_ssn_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_ts_count_pos, ',')));

	bureau_ssn_tu_count_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E'));

	bureau_ssn_count_tu :=__common__( if(bureau_ssn_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_tu_count_pos, ',')));

	bureau_ssn_en_count_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E'));

	bureau_ssn_count_en :=__common__( if(bureau_ssn_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_en_count_pos, ',')));

	bureau_ssn_eq_count_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E'));

	bureau_ssn_count_eq :=__common__( if(bureau_ssn_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_ssn_sources_count, bureau_ssn_eq_count_pos, ',')));

	_src_bureau_ssn_count :=__common__( max(if(max(bureau_ssn_count_tn, bureau_ssn_count_ts, bureau_ssn_count_tu, bureau_ssn_count_en, bureau_ssn_count_eq) = NULL, NULL, sum(if(bureau_ssn_count_tn = NULL, 0, bureau_ssn_count_tn), if(bureau_ssn_count_ts = NULL, 0, bureau_ssn_count_ts), if(bureau_ssn_count_tu = NULL, 0, bureau_ssn_count_tu), if(bureau_ssn_count_en = NULL, 0, bureau_ssn_count_en), if(bureau_ssn_count_eq = NULL, 0, bureau_ssn_count_eq))), (real)0));

	iv_src_bureau_ssn_count :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_ssn_count = NULL => -1,
										_src_bureau_ssn_count));

	bureau_ssn_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TN' , ', ', 'E'));

	bureau_ssn_fseen_tn :=__common__( if(bureau_ssn_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tn_fseen_pos, ',')));

	_bureau_ssn_fseen_tn :=__common__( common.sas_date((string)(bureau_ssn_fseen_tn)));

	bureau_ssn_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TS' , ', ', 'E'));

	bureau_ssn_fseen_ts :=__common__( if(bureau_ssn_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_ts_fseen_pos, ',')));

	_bureau_ssn_fseen_ts :=__common__( common.sas_date((string)(bureau_ssn_fseen_ts)));

	bureau_ssn_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'TU' , ', ', 'E'));

	bureau_ssn_fseen_tu :=__common__( if(bureau_ssn_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_tu_fseen_pos, ',')));

	_bureau_ssn_fseen_tu :=__common__( common.sas_date((string)(bureau_ssn_fseen_tu)));

	bureau_ssn_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'EN' , ', ', 'E'));

	bureau_ssn_fseen_en :=__common__( if(bureau_ssn_en_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_en_fseen_pos, ',')));

	_bureau_ssn_fseen_en :=__common__( common.sas_date((string)(bureau_ssn_fseen_en)));

	bureau_ssn_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , ', ', 'E'));

	bureau_ssn_fseen_eq :=__common__( if(bureau_ssn_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_ssn_sources_first_seen, bureau_ssn_eq_fseen_pos, ',')));

	_bureau_ssn_fseen_eq :=__common__( common.sas_date((string)(bureau_ssn_fseen_eq)));

	_src_bureau_ssn_fseen :=__common__( if(max(_bureau_ssn_fseen_tn, _bureau_ssn_fseen_ts, _bureau_ssn_fseen_tu, _bureau_ssn_fseen_en, _bureau_ssn_fseen_eq) = NULL, NULL, min(if(_bureau_ssn_fseen_tn = NULL, -NULL, _bureau_ssn_fseen_tn), if(_bureau_ssn_fseen_ts = NULL, -NULL, _bureau_ssn_fseen_ts), if(_bureau_ssn_fseen_tu = NULL, -NULL, _bureau_ssn_fseen_tu), if(_bureau_ssn_fseen_en = NULL, -NULL, _bureau_ssn_fseen_en), if(_bureau_ssn_fseen_eq = NULL, -NULL, _bureau_ssn_fseen_eq))));

	iv_mos_src_bureau_ssn_fseen :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_ssn_fseen = NULL => -1,
										if ((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_ssn_fseen) / (365.25 / 12)))));

	bureau_addr_tn_count_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E'));

	bureau_addr_count_tn :=__common__( if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ',')));

	bureau_addr_ts_count_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E'));

	bureau_addr_count_ts :=__common__( if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ',')));

	bureau_addr_tu_count_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E'));

	bureau_addr_count_tu :=__common__( if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ',')));

	bureau_addr_en_count_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E'));

	bureau_addr_count_en :=__common__( if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ',')));

	bureau_addr_eq_count_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E'));

	bureau_addr_count_eq :=__common__( if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ',')));

	_src_bureau_addr_count :=__common__( max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0));

	iv_src_bureau_addr_count :=__common__( map(
		not(truedid)                  => NULL,
		_src_bureau_addr_count = NULL => -1,
										 _src_bureau_addr_count));

	bureau_addr_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E'));

	bureau_addr_fseen_tn :=__common__( if(bureau_addr_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tn_fseen_pos, ',')));

	_bureau_addr_fseen_tn :=__common__( common.sas_date((string)(bureau_addr_fseen_tn)));

	bureau_addr_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E'));

	bureau_addr_fseen_ts :=__common__( if(bureau_addr_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_ts_fseen_pos, ',')));

	_bureau_addr_fseen_ts :=__common__( common.sas_date((string)(bureau_addr_fseen_ts)));

	bureau_addr_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E'));

	bureau_addr_fseen_tu :=__common__( if(bureau_addr_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tu_fseen_pos, ',')));

	_bureau_addr_fseen_tu :=__common__( common.sas_date((string)(bureau_addr_fseen_tu)));

	bureau_addr_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E'));

	bureau_addr_fseen_en :=__common__( if(bureau_addr_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_en_fseen_pos, ',')));

	_bureau_addr_fseen_en :=__common__( common.sas_date((string)(bureau_addr_fseen_en)));

	bureau_addr_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E'));

	bureau_addr_fseen_eq :=__common__( if(bureau_addr_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_eq_fseen_pos, ',')));

	_bureau_addr_fseen_eq :=__common__( common.sas_date((string)(bureau_addr_fseen_eq)));

	_src_bureau_addr_fseen :=__common__( if(max(_bureau_addr_fseen_tn, _bureau_addr_fseen_ts, _bureau_addr_fseen_tu, _bureau_addr_fseen_en, _bureau_addr_fseen_eq) = NULL, NULL, min(if(_bureau_addr_fseen_tn = NULL, -NULL, _bureau_addr_fseen_tn), if(_bureau_addr_fseen_ts = NULL, -NULL, _bureau_addr_fseen_ts), if(_bureau_addr_fseen_tu = NULL, -NULL, _bureau_addr_fseen_tu), if(_bureau_addr_fseen_en = NULL, -NULL, _bureau_addr_fseen_en), if(_bureau_addr_fseen_eq = NULL, -NULL, _bureau_addr_fseen_eq))));

	iv_mos_src_bureau_addr_fseen :=__common__( map(
		not(truedid)                  => NULL,
		_src_bureau_addr_fseen = NULL => -1,
										 if ((sysdate - _src_bureau_addr_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_addr_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_addr_fseen) / (365.25 / 12)))));

	bureau_lname_tn_count_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E'));

	bureau_lname_count_tn :=__common__( if(bureau_lname_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_tn_count_pos, ',')));

	bureau_lname_ts_count_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E'));

	bureau_lname_count_ts :=__common__( if(bureau_lname_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_ts_count_pos, ',')));

	bureau_lname_tu_count_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E'));

	bureau_lname_count_tu :=__common__( if(bureau_lname_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_tu_count_pos, ',')));

	bureau_lname_en_count_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E'));

	bureau_lname_count_en :=__common__( if(bureau_lname_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_en_count_pos, ',')));

	bureau_lname_eq_count_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E'));

	bureau_lname_count_eq :=__common__( if(bureau_lname_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Lname_sources_count, bureau_lname_eq_count_pos, ',')));

	_src_bureau_lname_count :=__common__( max(if(max(bureau_lname_count_tn, bureau_lname_count_ts, bureau_lname_count_tu, bureau_lname_count_en, bureau_lname_count_eq) = NULL, NULL, sum(if(bureau_lname_count_tn = NULL, 0, bureau_lname_count_tn), if(bureau_lname_count_ts = NULL, 0, bureau_lname_count_ts), if(bureau_lname_count_tu = NULL, 0, bureau_lname_count_tu), if(bureau_lname_count_en = NULL, 0, bureau_lname_count_en), if(bureau_lname_count_eq = NULL, 0, bureau_lname_count_eq))), (real)0));

	iv_src_bureau_lname_count :=__common__( map(
		not(truedid)                   => NULL,
		_src_bureau_lname_count = NULL => -1,
										  _src_bureau_lname_count));

	bureau_lname_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E'));

	bureau_lname_fseen_tn :=__common__( if(bureau_lname_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tn_fseen_pos, ',')));

	_bureau_lname_fseen_tn :=__common__( common.sas_date((string)(bureau_lname_fseen_tn)));

	bureau_lname_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E'));

	bureau_lname_fseen_ts :=__common__( if(bureau_lname_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_ts_fseen_pos, ',')));

	_bureau_lname_fseen_ts :=__common__( common.sas_date((string)(bureau_lname_fseen_ts)));

	bureau_lname_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E'));

	bureau_lname_fseen_tu :=__common__( if(bureau_lname_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tu_fseen_pos, ',')));

	_bureau_lname_fseen_tu :=__common__( common.sas_date((string)(bureau_lname_fseen_tu)));

	bureau_lname_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E'));

	bureau_lname_fseen_en :=__common__( if(bureau_lname_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_en_fseen_pos, ',')));

	_bureau_lname_fseen_en :=__common__( common.sas_date((string)(bureau_lname_fseen_en)));

	bureau_lname_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E'));

	bureau_lname_fseen_eq :=__common__( if(bureau_lname_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_eq_fseen_pos, ',')));

	_bureau_lname_fseen_eq :=__common__( common.sas_date((string)(bureau_lname_fseen_eq)));

	_src_bureau_lname_fseen :=__common__( if(max(_bureau_lname_fseen_tn, _bureau_lname_fseen_ts, _bureau_lname_fseen_tu, _bureau_lname_fseen_en, _bureau_lname_fseen_eq) = NULL, NULL, min(if(_bureau_lname_fseen_tn = NULL, -NULL, _bureau_lname_fseen_tn), if(_bureau_lname_fseen_ts = NULL, -NULL, _bureau_lname_fseen_ts), if(_bureau_lname_fseen_tu = NULL, -NULL, _bureau_lname_fseen_tu), if(_bureau_lname_fseen_en = NULL, -NULL, _bureau_lname_fseen_en), if(_bureau_lname_fseen_eq = NULL, -NULL, _bureau_lname_fseen_eq))));

	iv_mos_src_bureau_lname_fseen :=__common__( map(
		not(truedid)                   => NULL,
		_src_bureau_lname_fseen = NULL => -1,
										  if ((sysdate - _src_bureau_lname_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)))));

	bureau_dob_tn_count_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TN' , ', ', 'E'));

	bureau_dob_count_tn :=__common__( if(bureau_dob_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_tn_count_pos, ',')));

	bureau_dob_ts_count_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TS' , ', ', 'E'));

	bureau_dob_count_ts :=__common__( if(bureau_dob_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_ts_count_pos, ',')));

	bureau_dob_tu_count_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TU' , ', ', 'E'));

	bureau_dob_count_tu :=__common__( if(bureau_dob_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_tu_count_pos, ',')));

	bureau_dob_en_count_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'EN' , ', ', 'E'));

	bureau_dob_count_en :=__common__( if(bureau_dob_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_en_count_pos, ',')));

	bureau_dob_eq_count_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'EQ' , ', ', 'E'));

	bureau_dob_count_eq :=__common__( if(bureau_dob_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_DOB_sources_count, bureau_dob_eq_count_pos, ',')));

	_src_bureau_dob_count :=__common__( max(if(max(bureau_dob_count_tn, bureau_dob_count_ts, bureau_dob_count_tu, bureau_dob_count_en, bureau_dob_count_eq) = NULL, NULL, sum(if(bureau_dob_count_tn = NULL, 0, bureau_dob_count_tn), if(bureau_dob_count_ts = NULL, 0, bureau_dob_count_ts), if(bureau_dob_count_tu = NULL, 0, bureau_dob_count_tu), if(bureau_dob_count_en = NULL, 0, bureau_dob_count_en), if(bureau_dob_count_eq = NULL, 0, bureau_dob_count_eq))), (real)0));

	iv_src_bureau_dob_count :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_dob_count = NULL => -1,
										_src_bureau_dob_count));

	bureau_dob_tn_fseen_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TN' , ', ', 'E'));

	bureau_dob_fseen_tn :=__common__( if(bureau_dob_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_tn_fseen_pos, ',')));

	_bureau_dob_fseen_tn :=__common__( common.sas_date((string)(bureau_dob_fseen_tn)));

	bureau_dob_ts_fseen_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TS' , ', ', 'E'));

	bureau_dob_fseen_ts :=__common__( if(bureau_dob_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_ts_fseen_pos, ',')));

	_bureau_dob_fseen_ts :=__common__( common.sas_date((string)(bureau_dob_fseen_ts)));

	bureau_dob_tu_fseen_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'TU' , ', ', 'E'));

	bureau_dob_fseen_tu :=__common__( if(bureau_dob_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_tu_fseen_pos, ',')));

	_bureau_dob_fseen_tu :=__common__( common.sas_date((string)(bureau_dob_fseen_tu)));

	bureau_dob_en_fseen_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'EN' , ', ', 'E'));

	bureau_dob_fseen_en :=__common__( if(bureau_dob_en_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_en_fseen_pos, ',')));

	_bureau_dob_fseen_en :=__common__( common.sas_date((string)(bureau_dob_fseen_en)));

	bureau_dob_eq_fseen_pos :=__common__( Models.Common.findw_cpp(ver_DOB_sources, 'EQ' , ', ', 'E'));

	bureau_dob_fseen_eq :=__common__( if(bureau_dob_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_DOB_sources_first_seen, bureau_dob_eq_fseen_pos, ',')));

	_bureau_dob_fseen_eq :=__common__( common.sas_date((string)(bureau_dob_fseen_eq)));

	_src_bureau_dob_fseen :=__common__( if(max(_bureau_dob_fseen_tn, _bureau_dob_fseen_ts, _bureau_dob_fseen_tu, _bureau_dob_fseen_en, _bureau_dob_fseen_eq) = NULL, NULL, min(if(_bureau_dob_fseen_tn = NULL, -NULL, _bureau_dob_fseen_tn), if(_bureau_dob_fseen_ts = NULL, -NULL, _bureau_dob_fseen_ts), if(_bureau_dob_fseen_tu = NULL, -NULL, _bureau_dob_fseen_tu), if(_bureau_dob_fseen_en = NULL, -NULL, _bureau_dob_fseen_en), if(_bureau_dob_fseen_eq = NULL, -NULL, _bureau_dob_fseen_eq))));

	iv_mos_src_bureau_dob_fseen :=__common__( map(
		not(truedid)                 => NULL,
		_src_bureau_dob_fseen = NULL => -1,
										if ((sysdate - _src_bureau_dob_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_dob_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_dob_fseen) / (365.25 / 12)))));

	lien_adl_li_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'));

	lien_adl_count_li :=__common__( if(lien_adl_li_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_li_count_pos, ',')));

	lien_adl_l2_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'));

	lien_adl_count_l2 :=__common__( if(lien_adl_l2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_l2_count_pos, ',')));

	_src_lien_adl_count :=__common__( max(lien_adl_count_li, lien_adl_count_l2, (real)0));

	iv_src_liens_adl_count :=__common__( map(
		not(truedid)               => NULL,
		_src_lien_adl_count = NULL => -1,
									  _src_lien_adl_count));

	prop_adl_p_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'));

	prop_adl_count_p :=__common__( if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ',')));

	_src_prop_adl_count :=__common__( max(prop_adl_count_p, (real)0));

	iv_src_property_adl_count :=__common__( map(
		not(truedid)               => NULL,
		_src_prop_adl_count = NULL => -1,
									  _src_prop_adl_count));

	voter_adl_v_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

	iv_src_voter_adl_count :=__common__( map(
		not(truedid)              => NULL,
		not(voter_avail)          => -1,
		voter_adl_v_count_pos = 0 => 0,
									 (integer)Models.Common.getw(ver_sources_count, voter_adl_v_count_pos, ',')));

	vote_adl_vo_lseen_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'));

	vote_adl_lseen_vo :=__common__( if(vote_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, vote_adl_vo_lseen_pos, ',')));

	_vote_adl_lseen_vo :=__common__( common.sas_date((string)(vote_adl_lseen_vo)));

	_src_vote_adl_lseen :=__common__( _vote_adl_lseen_vo);

	iv_mos_src_voter_adl_lseen :=__common__( map(
		not(truedid)               => NULL,
		not(voter_avail)           => -1,
		_src_vote_adl_lseen = NULL => -1,
									  if ((sysdate - _src_vote_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vote_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_vote_adl_lseen) / (365.25 / 12)))));

	emerge_adl_em_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'));

	emerge_adl_count_em :=__common__( if(emerge_adl_em_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_em_count_pos, ',')));

	emerge_adl_e1_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'));

	emerge_adl_count_e1 :=__common__( if(emerge_adl_e1_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e1_count_pos, ',')));

	emerge_adl_e2_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'));

	emerge_adl_count_e2 :=__common__( if(emerge_adl_e2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e2_count_pos, ',')));

	emerge_adl_e3_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'));

	emerge_adl_count_e3 :=__common__( if(emerge_adl_e3_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e3_count_pos, ',')));

	emerge_adl_e4_count_pos :=__common__( Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'));

	emerge_adl_count_e4 :=__common__( if(emerge_adl_e4_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, emerge_adl_e4_count_pos, ',')));

	iv_src_emerge_adl_count :=__common__( if(not(truedid), NULL, max(if(max(emerge_adl_count_em, emerge_adl_count_e1, emerge_adl_count_e2, emerge_adl_count_e3, emerge_adl_count_e4) = NULL, NULL, sum(if(emerge_adl_count_em = NULL, 0, emerge_adl_count_em), if(emerge_adl_count_e1 = NULL, 0, emerge_adl_count_e1), if(emerge_adl_count_e2 = NULL, 0, emerge_adl_count_e2), if(emerge_adl_count_e3 = NULL, 0, emerge_adl_count_e3), if(emerge_adl_count_e4 = NULL, 0, emerge_adl_count_e4))), (real)0)));

	nf_bus_addr_match_count :=__common__( if(not(add1_pop), NULL, bus_addr_match_count));

	iv_fname_non_phn_src_ct :=__common__( if(not(truedid and fnamepop), NULL, rc_fnamecount));

	iv_full_name_non_phn_src_ct :=__common__( if(not(truedid and fnamepop and lnamepop), NULL, source_count));

	iv_addr_non_phn_src_ct :=__common__( if(not(truedid) and add1_pop, NULL, rc_addrcount));

	iv_ssn_non_phn_src_ct :=__common__( if(not(truedid), NULL, rc_ssncount));

	iv_ssn_score :=__common__( if(not(truedid and (integer)ssnlength > 0), NULL, combo_ssnscore));

	iv_dob_src_ct :=__common__( if(not(truedid and dobpop), NULL, combo_dobcount));

	_reported_dob :=__common__( common.sas_date((string)(reported_dob)));

	reported_age :=__common__( if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25)));

	iv_combined_age_1 :=__common__( map(
		not(truedid or dobpop) => NULL,
		age > 0                => age,
		(integer)input_dob_age > 0      => (integer)input_dob_age,
		inferred_age > 0       => inferred_age,
		reported_age > 0       => reported_age,
		(integer)ams_age > 0            => (integer)ams_age,
								  -1));

	_rc_ssnlowissue :=__common__( common.sas_date((string)(rc_ssnlowissue)));

//	iv_age_at_low_issue := if(not(truedid and (integer)ssnlength > 0 and age > 0), NULL, if (age - (sysdate - _rc_ssnlowissue) / 365.25 >= 0, truncate(age - (sysdate - _rc_ssnlowissue) / 365.25), roundup(age - (sysdate - _rc_ssnlowissue) / 365.25)));
	iv_age_at_low_issue := __common__( MAP(
		not(truedid and (integer)ssnlength > 0 and age >0)  										=> NULL,
		_rc_ssnlowissue	= NULL															=> NULL,
		age - (sysdate - _rc_ssnlowissue) / 365.25 	>= 0 		=> truncate(age - (sysdate - _rc_ssnlowissue) / 365.25),
																													 roundup(age - (sysdate - _rc_ssnlowissue) / 365.25)) );

	_rc_ssnhighissue :=__common__( common.sas_date((string)(rc_ssnhighissue)));

//	iv_age_at_high_issue := if(not(truedid and (integer)ssnlength > 0 and age > 0), NULL, if (age - (sysdate - _rc_ssnhighissue) / 365.25 >= 0, truncate(age - (sysdate - _rc_ssnhighissue) / 365.25), roundup(age - (sysdate - _rc_ssnhighissue) / 365.25)));

	iv_age_at_high_issue := __common__( MAP(
		not(truedid and (integer)ssnlength > 0 and age >0) 											=> NULL, 
		_rc_ssnhighissue	= NULL														=> NULL,
		age - (sysdate - _rc_ssnhighissue) / 365.25 >= 0		=> truncate(age - (sysdate - _rc_ssnhighissue) / 365.25),
																													 roundup(age - (sysdate - _rc_ssnhighissue) / 365.25)) );

	nf_util_adl_count :=__common__( if(not(truedid), NULL, util_adl_count));

	iv_inp_addr_address_score :=__common__( if(not(add1_pop and truedid), NULL, add1_address_score));

	iv_inp_addr_lres :=__common__( if(not(add1_pop), NULL, add1_lres));

	iv_inp_addr_assessed_total_val :=__common__( if(not(add1_pop), NULL, add1_assessed_total_value));

	iv_inp_addr_building_area :=__common__( if(not(add1_pop), NULL, add1_building_area));

	inp_addr_nhood_properties_sum :=__common__( if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count))));

	inp_addr_nhood_vac_props :=__common__( add1_nhood_vacant_properties);

	nf_inp_addr_nhood_pct_vacant :=__common__( map(
		not(add1_pop)                     => NULL,
		inp_addr_nhood_properties_sum > 0 => if (inp_addr_nhood_vac_props / inp_addr_nhood_properties_sum * 10 >= 0, roundup(inp_addr_nhood_vac_props / inp_addr_nhood_properties_sum * 10), truncate(inp_addr_nhood_vac_props / inp_addr_nhood_properties_sum * 10)) * 10,
											 -1));

	iv_inp_addr_avm_change_1yr_1 :=__common__( map(
		not(add1_pop)                                                           => NULL,
		add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_2,
																				   NULL));

	iv_inp_addr_avm_pct_change_1yr :=__common__( map(
		not(add1_pop)                                                           => NULL,
		add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_2,
																				   NULL));

	iv_inp_addr_avm_change_1yr :=__common__( map(
		not(add1_pop)                                                           => iv_inp_addr_avm_change_1yr_1,
		add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_2 > 0 => iv_inp_addr_avm_change_1yr_1,
																				   NULL));

	iv_inp_addr_avm_pct_change_2yr :=__common__( map(
		not(add1_pop)                                                           => NULL,
		add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_3,
																				   NULL));

	iv_inp_addr_avm_change_2yr :=__common__( map(
		not(add1_pop)                                                           => NULL,
		add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => NULL,
																				   NULL));

	bst_addr_avm_auto_val :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	bst_addr_mortgage_amount :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_mortgage_amount,
							add2_mortgage_amount));

	iv_bst_addr_mtg_avm_abs_diff :=__common__( if(bst_addr_mortgage_amount <= 0 or bst_addr_avm_auto_val <= 0, NULL, bst_addr_avm_auto_val - bst_addr_mortgage_amount));

	iv_bst_addr_assessed_total_val :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_assessed_total_value,
							add2_assessed_total_value));

	bst_addr_date_first_seen :=__common__( if(add1_isbestmatch, common.sas_date((string)(add1_date_first_seen)), common.sas_date((string)(add2_date_first_seen))));

	iv_mos_since_bst_addr_fseen :=__common__( map(
		not(truedid)                    => NULL,
		bst_addr_date_first_seen = NULL => -1,
										   if ((sysdate - bst_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - bst_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - bst_addr_date_first_seen) / (365.25 / 12)))));

	bst_addr_nhood_properties_sum_c235_b1 :=__common__( if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count))));

	bst_addr_nhood_mfd_props_c235_b1 :=__common__( add1_nhood_mfd_count);

	nf_bst_addr_nhood_pct_mfd_c236 :=__common__( map(
		not(truedid)                              => NULL,
		bst_addr_nhood_properties_sum_c235_b1 > 0 => if (bst_addr_nhood_mfd_props_c235_b1 / bst_addr_nhood_properties_sum_c235_b1 * 10 >= 0, roundup(bst_addr_nhood_mfd_props_c235_b1 / bst_addr_nhood_properties_sum_c235_b1 * 10), truncate(bst_addr_nhood_mfd_props_c235_b1 / bst_addr_nhood_properties_sum_c235_b1 * 10)) * 10,
													 -1));

	bst_addr_nhood_properties_sum_c235_b2 :=__common__( if(max(add2_nhood_business_count, add2_nhood_sfd_count, add2_nhood_mfd_count) = NULL, NULL, sum(if(add2_nhood_business_count = NULL, 0, add2_nhood_business_count), if(add2_nhood_sfd_count = NULL, 0, add2_nhood_sfd_count), if(add2_nhood_mfd_count = NULL, 0, add2_nhood_mfd_count))));

	bst_addr_nhood_mfd_props_c235_b2 :=__common__( add2_nhood_mfd_count);

	nf_bst_addr_nhood_pct_mfd_c237 :=__common__( map(
		not(truedid)                              => NULL,
		bst_addr_nhood_properties_sum_c235_b2 > 0 => if (bst_addr_nhood_mfd_props_c235_b2 / bst_addr_nhood_properties_sum_c235_b2 * 10 >= 0, roundup(bst_addr_nhood_mfd_props_c235_b2 / bst_addr_nhood_properties_sum_c235_b2 * 10), truncate(bst_addr_nhood_mfd_props_c235_b2 / bst_addr_nhood_properties_sum_c235_b2 * 10)) * 10,
													 -1));

	bst_addr_nhood_properties_sum :=__common__( if(add1_isbestmatch, if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count))), if(max(add2_nhood_business_count, add2_nhood_sfd_count, add2_nhood_mfd_count) = NULL, NULL, sum(if(add2_nhood_business_count = NULL, 0, add2_nhood_business_count), if(add2_nhood_sfd_count = NULL, 0, add2_nhood_sfd_count), if(add2_nhood_mfd_count = NULL, 0, add2_nhood_mfd_count)))));

	bst_addr_nhood_mfd_props :=__common__( if(add1_isbestmatch, add1_nhood_mfd_count, add2_nhood_mfd_count));

	nf_bst_addr_nhood_pct_mfd :=__common__( if(add1_isbestmatch, nf_bst_addr_nhood_pct_mfd_c236, nf_bst_addr_nhood_pct_mfd_c237));

	iv_bst_addr_avm_change_2yr_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => NULL,
							NULL));

	bst_addr_avm_auto_val_3_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation_3,
							add2_avm_automated_valuation_3));

	bst_addr_avm_auto_val_1_2 :=__common__( map(
		not(truedid)     => bst_addr_avm_auto_val_1_3,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	iv_bst_addr_avm_change_2yr :=__common__( if(bst_addr_avm_auto_val_1_2 > 0 and bst_addr_avm_auto_val_3_1 > 0, bst_addr_avm_auto_val_1_2 - bst_addr_avm_auto_val_3_1, NULL));

	iv_bst_addr_avm_pct_change_2yr_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => NULL,
							NULL));

	bst_addr_avm_auto_val_3 :=__common__( map(
		not(truedid)     => bst_addr_avm_auto_val_3_1,
		add1_isbestmatch => add1_avm_automated_valuation_3,
							add2_avm_automated_valuation_3));

	bst_addr_avm_auto_val_1_1 :=__common__( map(
		not(truedid)     => bst_addr_avm_auto_val_1_2,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	iv_bst_addr_avm_pct_change_2yr :=__common__( if(bst_addr_avm_auto_val_1_1 > 0 and bst_addr_avm_auto_val_3 > 0, bst_addr_avm_auto_val_1_1 / bst_addr_avm_auto_val_3, NULL));

	bst_addr_avm_auto_val_4 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add1_avm_automated_valuation_4,
							add2_avm_automated_valuation_4));

	iv_bst_addr_avm_change_3yr_1 :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => NULL,
							NULL));

	bst_addr_avm_auto_val_1 :=__common__( map(
		not(truedid)     => bst_addr_avm_auto_val_1_1,
		add1_isbestmatch => add1_avm_automated_valuation,
							add2_avm_automated_valuation));

	iv_bst_addr_avm_change_3yr :=__common__( if(bst_addr_avm_auto_val_1 > 0 and bst_addr_avm_auto_val_4 > 0, bst_addr_avm_auto_val_1 - bst_addr_avm_auto_val_4, NULL));

	iv_prv_addr_lres :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add2_lres,
							add3_lres));

	iv_prv_addr_avm_auto_val :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add2_avm_automated_valuation,
							add3_avm_automated_valuation));

	iv_prv_addr_source_count :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add2_source_count,
							add3_source_count));

	iv_prv_addr_assessed_total_val :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => add2_assessed_total_value,
							add3_assessed_total_value));

	prv_addr_date_first_seen :=__common__( if(add1_isbestmatch, common.sas_date((string)(add2_date_first_seen)), common.sas_date((string)(add3_date_first_seen))));

	iv_mos_since_prv_addr_fseen :=__common__( map(
		not(truedid)                    => NULL,
		prv_addr_date_first_seen = NULL => -1,
										   if ((sysdate - prv_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_first_seen) / (365.25 / 12)))));

	prv_addr_date_last_seen :=__common__( if(add1_isbestmatch, common.sas_date((string)(add2_date_last_seen)), common.sas_date((string)(add3_date_last_seen))));

	iv_mos_since_prv_addr_lseen :=__common__( map(
		not(truedid)                   => NULL,
		prv_addr_date_last_seen = NULL => -1,
										  if ((sysdate - prv_addr_date_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_last_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_last_seen) / (365.25 / 12)))));

	iv_avg_prop_sold_purch_amt_1 :=__common__( map(
		not(truedid or add1_pop)         => (real)NULL,
		property_sold_purchase_count > 0 => (real)property_sold_purchase_total / (real)property_sold_purchase_count,
											-1.0));

	iv_purch_sold_val_diff :=__common__( map(
		not(truedid or add1_pop)          => NULL,
		property_owned_purchase_total = 0 => NULL,
		property_sold_purchase_total = 0  => NULL,
											 property_owned_purchase_total - property_sold_purchase_total));

	iv_prop2_purch_sale_diff :=__common__( map(
		not(truedid)                                           => NULL,
		prop2_prev_purchase_price > 0 and prop2_sale_price > 0 => prop2_sale_price - prop2_prev_purchase_price,
																  NULL));

	iv_dist_bst_addr_to_prv_addr :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => dist_a1toa2,
							dist_a2toa3));

	iv_dist_inp_addr_to_prv_addr :=__common__( map(
		not(truedid)     => NULL,
		add1_isbestmatch => dist_a1toa2,
							dist_a1toa3));

	iv_avg_lres :=__common__( if(not(truedid), NULL, avg_lres));

	iv_max_lres :=__common__( if(not(truedid), NULL, max_lres));

	iv_addr_lres_6mo_count :=__common__( map(
		not(truedid)                => NULL,
		addr_lres_6mo_count = -9999 => -1,
									   addr_lres_6mo_count));

	iv_addr_lres_12mo_count :=__common__( map(
		not(truedid)                 => NULL,
		addr_lres_12mo_count = -9999 => -1,
										addr_lres_12mo_count));

	iv_hist_addr_match :=__common__( map(
		not(truedid)            => NULL,
		hist_addr_match = -9999 => -1,
								   hist_addr_match));

	iv_avg_num_sources_per_addr :=__common__( map(
		not(truedid)          => NULL,
		unique_addr_count = 0 => -1,
								 if (if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))) >= 0, truncate(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))), roundup(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))))));

	_gong_did_first_seen :=__common__( common.sas_date((string)(gong_did_first_seen)));

	iv_mos_since_gong_did_fst_seen :=__common__( map(
		not(truedid)                     => NULL,
		not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
											-1));

	iv_gong_did_phone_ct :=__common__( if(not(truedid), NULL, gong_did_phone_ct));

	iv_addrs_per_adl :=__common__( if(not(truedid), NULL, addrs_per_adl));

	iv_lnames_per_adl :=__common__( if(not(truedid), NULL, lnames_per_adl));

	iv_adls_per_addr :=__common__( if(not(add1_pop), NULL, adls_per_addr));

	iv_adls_per_apt_addr :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '0' => -1,
							adls_per_addr));

	iv_ssns_per_sfd_addr :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '1' => -1,
							ssns_per_addr));

	iv_phones_per_sfd_addr :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '1' => -1,
							phones_per_addr));

	iv_adls_per_addr_c6 :=__common__( if(not(add1_pop), NULL, adls_per_addr_c6));

	iv_adls_per_sfd_addr_c6 :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '1' => -1,
							adls_per_addr_c6));

	iv_ssns_per_addr_c6 :=__common__( if(not(add1_pop), NULL, ssns_per_addr_c6));

	iv_ssns_per_sfd_addr_c6 :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '1' => -1,
							ssns_per_addr_c6));

	iv_max_ids_per_sfd_addr_c6 :=__common__( map(
		not(add1_pop)    => NULL,
		iv_add_apt = '1' => -1,
							max(adls_per_addr_c6, ssns_per_addr_c6)));

	iv_dl_addrs_per_adl :=__common__( map(
		not(truedid)  => NULL,
		not(dl_avail) => -1,
						 dl_addrs_per_adl));

	iv_vo_addrs_per_adl :=__common__( map(
		not(truedid)     => NULL,
		not(voter_avail) => -1,
							vo_addrs_per_adl));

	iv_invalid_addrs_per_adl :=__common__( if(not(truedid), NULL, invalid_addrs_per_adl));

	iv_inq_recency :=__common__( map(
		not(truedid) => NULL,
		inq_count01 >0 => 1,
		inq_count03 >0 => 3,
		inq_count06 >0 => 6,
		inq_count12 >0 => 12,
		inq_count24 >0 => 24,
		inq_count   >0 => 99,
						0));

	iv_inq_collection_count12 :=__common__( if(not(truedid), NULL, inq_collection_count12));

	iv_inq_collection_recency :=__common__( map(
		not(truedid)           => NULL,
		inq_collection_count01 >0 => 1,
		inq_collection_count03 >0 => 3,
		inq_collection_count06 >0 => 6,
		inq_collection_count12 >0 => 12,
		inq_collection_count24 >0 => 24,
		inq_collection_count   >0 => 99,
								  0));

	iv_inq_auto_count12 :=__common__( if(not(truedid), NULL, inq_auto_count12));

	iv_inq_auto_recency :=__common__( map(
		not(truedid)     => NULL,
		inq_auto_count01 >0 => 1,
		inq_auto_count03 >0 => 3,
		inq_auto_count06 >0 => 6,
		inq_auto_count12 >0 => 12,
		inq_auto_count24 >0 => 24,
		inq_auto_count   >0 => 99,
							0));

	iv_inq_banking_count12 :=__common__( if(not(truedid), NULL, inq_banking_count12));

	iv_inq_banking_recency :=__common__( map(
		not(truedid)        => NULL,
		inq_banking_count01 >0 => 1,
		inq_banking_count03 >0 => 3,
		inq_banking_count06 >0 => 6,
		inq_banking_count12 >0 => 12,
		inq_banking_count24 >0 => 24,
		inq_banking_count   >0 => 99,
							   0));

	iv_inq_highriskcredit_count12 :=__common__( if(not(truedid), NULL, inq_highRiskCredit_count12));

	iv_inq_highriskcredit_recency :=__common__( map(
		not(truedid)               => NULL,
		inq_highRiskCredit_count01 >0 => 1,
		inq_highRiskCredit_count03 >0 => 3,
		inq_highRiskCredit_count06 >0 => 6,
		inq_highRiskCredit_count12 >0 => 12,
		inq_highRiskCredit_count24 >0 => 24,
		inq_highRiskCredit_count   >0 => 99,
									  0));

	iv_inq_communications_recency :=__common__( map(
		not(truedid)               => NULL,
		inq_communications_count01 >0 => 1,
		inq_communications_count03 >0 => 3,
		inq_communications_count06 >0 => 6,
		inq_communications_count12 >0 => 12,
		inq_communications_count24 >0 => 24,
		inq_communications_count   >0 => 99,
									  0));

	iv_inq_other_count12 :=__common__( if(not(truedid), NULL, inq_other_count12));

	iv_inq_other_recency :=__common__( map(
		not(truedid)      => NULL,
		inq_other_count01 >0 => 1,
		inq_other_count03 >0 => 3,
		inq_other_count06 >0 => 6,
		inq_other_count12 >0 => 12,
		inq_other_count24 >0 => 24,
		inq_other_count   >0 => 99,
							 0));

	iv_inq_addrs_per_adl :=__common__( if(not(truedid), NULL, inq_addrsperadl));

	iv_inq_num_diff_names_per_adl :=__common__( if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl)));

	iv_inq_phones_per_adl :=__common__( if(not(truedid), NULL, inq_phonesperadl));

	iv_inq_per_ssn_1 :=__common__( if(not((integer)ssnlength > 0), NULL, inq_perssn));

	iv_inq_per_addr :=__common__( if(not(add1_pop), NULL, inq_peraddr));

	iv_inq_adls_per_addr_1 :=__common__( if(not(add1_pop), NULL, inq_adlsperaddr));

	iv_inq_lnames_per_addr_1 :=__common__( if(not(add1_pop), NULL, inq_lnamesperaddr));

	iv_inq_ssns_per_addr_1 :=__common__( if(not(add1_pop), NULL, inq_ssnsperaddr));

	iv_inq_adls_per_addr :=__common__( if(not(add1_pop), NULL, inq_adlsperaddr));

	iv_inq_lnames_per_addr :=__common__( if(not(add1_pop), NULL, inq_lnamesperaddr));

	iv_inq_ssns_per_addr :=__common__( if(not(add1_pop), NULL, inq_ssnsperaddr));

	iv_inq_adls_per_phone :=__common__( if(not(hphnpop), NULL, inq_adlsperphone));

	_infutor_first_seen :=__common__( common.sas_date((string)(infutor_first_seen)));

	iv_mos_since_infutor_first_seen :=__common__( map(
		not(hphnpop)                    => NULL,
		not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
										   -1));

	_infutor_last_seen :=__common__( common.sas_date((string)(infutor_last_seen)));

	iv_mos_since_infutor_last_seen :=__common__( map(
		not(hphnpop)                   => NULL,
		not(_infutor_last_seen = NULL) => if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))),
										  -1));

	_impulse_first_seen :=__common__( common.sas_date((string)(impulse_first_seen)));

	iv_mos_since_impulse_first_seen :=__common__( map(
		not(truedid)                    => NULL,
		not(_impulse_first_seen = NULL) => if ((sysdate - _impulse_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_first_seen) / (365.25 / 12)), roundup((sysdate - _impulse_first_seen) / (365.25 / 12))),
										   -1));

	_impulse_last_seen :=__common__( common.sas_date((string)(impulse_last_seen)));

	iv_mos_since_impulse_last_seen :=__common__( map(
		not(truedid)                   => NULL,
		not(_impulse_last_seen = NULL) => if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12))),
										  -1));

	iv_impulse_annual_income :=__common__( if(not(truedid), NULL, impulse_annual_income));

	iv_email_count :=__common__( if(not(truedid), NULL, email_count));

	iv_all_email_domain_free :=__common__( if(not(truedid), NULL, (integer)(email_count = email_domain_free_count) * min(if(email_count = NULL, -NULL, email_count), 5)));

	iv_attr_purchase_recency :=__common__( map(
		not(truedid)                 => NULL,
		attr_num_purchase30 >0          => 1,
		attr_num_purchase90 >0          => 3,
		attr_num_purchase180 >0         => 6,
		attr_num_purchase12  >0         => 12,
		attr_num_purchase24  >0         => 24,
		attr_num_purchase36  >0         => 36,
		attr_num_purchase60  >0         => 60,
		attr_date_first_purchase > 0 => 99,
										0));

	iv_attr_felonies_recency :=__common__( map(
		not(truedid)     => NULL,
		attr_felonies30 >0  => 1,
		attr_felonies90 >0  => 3,
		attr_felonies180>0  => 6,
		attr_felonies12 >0  => 12,
		attr_felonies24 >0  => 24,
		attr_felonies36 >0  => 36,
		attr_felonies60 >0  => 60,
		felony_count > 0 => 99,
							0));

	iv_attr_arrests_recency :=__common__( map(
		not(truedid)     => NULL,
		attr_arrests30  >0  => 1,
		attr_arrests90  >0  => 3,
		attr_arrests180 >0  => 6,
		attr_arrests12  >0  => 12,
		attr_arrests24  >0  => 24,
		attr_arrests36  >0  => 36,
		attr_arrests60  >0  => 60,
		attr_arrests > 0 => 99,
							0));

	iv_attr_rel_liens_recency :=__common__( map(
		not(truedid)                        => NULL,
		attr_num_rel_liens30  >0               => 1,
		attr_num_rel_liens90  >0               => 3,
		attr_num_rel_liens180 >0               => 6,
		attr_num_rel_liens12  >0               => 12,
		attr_num_rel_liens24  >0               => 24,
		attr_num_rel_liens36  >0               => 36,
		attr_num_rel_liens60  >0               => 60,
		liens_historical_released_count > 0 => 99,
											   0));

	iv_attr_bankruptcy_recency :=__common__( map(
		not(truedid)                      => NULL,
		attr_bankruptcy_count30  >0          => 1,
		attr_bankruptcy_count90  >0          => 3,
		attr_bankruptcy_count180 >0          => 6,
		attr_bankruptcy_count12  >0          => 12,
		attr_bankruptcy_count24  >0          => 24,
		attr_bankruptcy_count36  >0          => 36,
		attr_bankruptcy_count60  >0          => 60,
		(rc_bansflag in ['1', '2'])       => 99,
		bankrupt                          => 99,
		contains_i(ver_sources, 'BA') > 0 => 99,
		filing_count > 0                  => 99,
		bk_recent_count > 0               => 99,
											 0));

	iv_eviction_count :=__common__( if(not(truedid), NULL, attr_eviction_count));

	iv_attr_proflic_recency :=__common__( map(
		not(truedid)        => NULL,
		attr_num_proflic30  >0 => 1,
		attr_num_proflic90  >0 => 3,
		attr_num_proflic180 >0 => 6,
		attr_num_proflic12  >0 => 12,
		attr_num_proflic24  >0 => 24,
		attr_num_proflic36  >0 => 36,
		attr_num_proflic60  >0 => 60,
		prof_license_flag   => 99,
							   0));

	iv_non_derog_count :=__common__( if(not(truedid), NULL, attr_num_nonderogs));

	iv_filing_count :=__common__( if(not(truedid), NULL, filing_count));

	iv_unreleased_liens_ct :=__common__( if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))));

	iv_liens_unrel_cj_ct :=__common__( if(not(truedid), NULL, liens_unrel_CJ_ct));

	iv_criminal_count :=__common__( if(not(truedid), NULL, criminal_count));

	nf_rel_count :=__common__( if(not(truedid), NULL, rel_count));

	nf_average_rel_income :=__common__( map(
		not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
		rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
		if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
																																																																																																																										 if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000));

	nf_lowest_rel_income :=__common__( map(
		not(truedid)                 => NULL,
		rel_count = 0                => -1,
		rel_incomeunder25_count > 0  => 25,
		rel_incomeunder50_count > 0  => 50,
		rel_incomeunder75_count > 0  => 75,
		rel_incomeunder100_count > 0 => 100,
		rel_incomeover100_count > 0  => 125,
										0));

	nf_highest_rel_income :=__common__( map(
		not(truedid)                 => NULL,
		rel_count = 0                => -1,
		rel_incomeover100_count > 0  => 125,
		rel_incomeunder100_count > 0 => 100,
		rel_incomeunder75_count > 0  => 75,
		rel_incomeunder50_count > 0  => 50,
		rel_incomeunder25_count > 0  => 25,
										0));

	nf_average_rel_home_val :=__common__( map(
		not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
		rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => -1,
		if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) = 0 => 0,
																																																																																																																																																															 if (if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) >= 0, truncate(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))), roundup(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))))) * 1000));

	nf_oldest_rel_age :=__common__( map(
		not(truedid)             => NULL,
		rel_count = 0            => -1,
		rel_ageover70_count > 0  => 80,
		rel_ageunder70_count > 0 => 70,
		rel_ageunder60_count > 0 => 60,
		rel_ageunder50_count > 0 => 50,
		rel_ageunder40_count > 0 => 40,
		rel_ageunder30_count > 0 => 30,
		rel_ageunder20_count > 0 => 20,
									0));

	nf_average_rel_criminal_dist :=__common__( map(
		not(truedid)                                                                                                                                                                                                                                                                                                                                                                          => NULL,
		rel_count = 0                                                                                                                                                                                                                                                                                                                                                                         => -1,
		if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther))) = 0 => 0,
																																																																																																 if (if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther))) >= 0, truncate(if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther)))), roundup(if(max(crim_rel_within25miles * 25, crim_rel_within100miles * 100, crim_rel_within500miles * 500, crim_rel_withinOther * 1000) = NULL, NULL, sum(if(crim_rel_within25miles * 25 = NULL, 0, crim_rel_within25miles * 25), if(crim_rel_within100miles * 100 = NULL, 0, crim_rel_within100miles * 100), if(crim_rel_within500miles * 500 = NULL, 0, crim_rel_within500miles * 500), if(crim_rel_withinOther * 1000 = NULL, 0, crim_rel_withinOther * 1000))) / if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles, crim_rel_withinOther) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles), if(crim_rel_withinOther = NULL, 0, crim_rel_withinOther)))))));

	nf_average_rel_distance :=__common__( map(
		not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
		rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
		if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
																																																																																																			 if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))))));

	nf_closest_rel_distance :=__common__( map(
		not(truedid)                 => NULL,
		rel_count = 0                => -1,
		rel_within25miles_count > 0  => 25,
		rel_within100miles_count > 0 => 100,
		rel_within500miles_count > 0 => 500,
		rel_withinOther_count > 0    => 1000,
										0));

	nf_rel_felony_count :=__common__( map(
		not(truedid)  => NULL,
		rel_count = 0 => -1,
						 rel_felony_count));

	nf_rel_derog_summary :=__common__( map(
		not(truedid)  => NULL,
		rel_count = 0 => -1,
						 if(max(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3), min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3), min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3)) = NULL, NULL, sum(if(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3) = NULL, 0, min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3)), if(min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3) = NULL, 0, min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3)), if(min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3) = NULL, 0, min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3))))));

	nf_accident_recency :=__common__( map(
		not(truedid)  => NULL,
		acc_count_30 >0 => 1,
		acc_count_90 >0 => 3,
		acc_count_180>0 => 6,
		acc_count_12 >0 => 12,
		acc_count_24 >0 => 24,
		acc_count_36 >0 => 36,
		acc_count_60 >0 => 60,
		acc_count    >0 => 99,
						 0));

	iv_pb_average_dollars :=__common__( map(
		not(truedid)              => NULL,
		pb_average_dollars = '' => -1,
									 (integer)pb_average_dollars));

	iv_pb_total_dollars :=__common__( map(
		not(truedid)            => NULL,
		pb_total_dollars = '' => -1,
								   (integer)pb_total_dollars));

	nf_fp_varmsrcssncount :=__common__( if(not(truedid), NULL, (integer)fp_varmsrcssncount));

	nf_fp_varmsrcssnunrelcount :=__common__( if(not(truedid), NULL, (integer)fp_varmsrcssnunrelcount));

	nf_fp_srchcountwk :=__common__( if(not(truedid), NULL, (integer)fp_srchcountwk));

	nf_fp_srchunvrfdaddrcount :=__common__( if(not(truedid), NULL, (integer)fp_srchunvrfdaddrcount));

	nf_fp_srchunvrfddobcount :=__common__( if(not(truedid), NULL, (integer)fp_srchunvrfddobcount));

	nf_fp_srchfraudsrchcount :=__common__( if(not(truedid), NULL, (integer)fp_srchfraudsrchcount));

	nf_fp_srchfraudsrchcountyr :=__common__( if(not(truedid), NULL, (integer)fp_srchfraudsrchcountyr));

	nf_fp_srchfraudsrchcountmo :=__common__( if(not(truedid), NULL, (integer)fp_srchfraudsrchcountmo));

	nf_fp_srchfraudsrchcountwk :=__common__( if(not(truedid), NULL, (integer)fp_srchfraudsrchcountwk));

	nf_fp_assocsuspicousidcount :=__common__( if(not(truedid), NULL, (integer)fp_assocsuspicousidcount));

	nf_fp_assoccredbureaucount :=__common__( if(not(truedid), NULL, (integer)fp_assoccredbureaucount));

	nf_fp_assoccredbureaucountnew :=__common__( if(not(truedid), NULL, (integer)fp_assoccredbureaucountnew));

	nf_fp_corrssnnamecount :=__common__( if(not(truedid), NULL, (integer)fp_corrssnnamecount));

	nf_fp_corrssnaddrcount :=__common__( if(not(truedid), NULL, (integer)fp_corrssnaddrcount));

	nf_fp_corraddrnamecount :=__common__( if(not(truedid), NULL, (integer)fp_corraddrnamecount));

	nf_fp_corraddrphonecount :=__common__( if(not(truedid), NULL, (integer)fp_corraddrphonecount));

	nf_fp_corrphonelastnamecount :=__common__( if(not(truedid), NULL, (integer)fp_corrphonelastnamecount));

	nf_fp_divaddrsuspidcountnew :=__common__( if(not(truedid), NULL, (integer)fp_divaddrsuspidcountnew));

	nf_fp_divsrchaddrsuspidcount :=__common__( if(not(truedid), NULL, (integer)fp_divsrchaddrsuspidcount));

	nf_fp_srchssnsrchcount :=__common__( if(not(truedid), NULL, (integer)fp_srchssnsrchcount));

	nf_fp_srchssnsrchcountmo :=__common__( if(not(truedid), NULL, (integer)fp_srchssnsrchcountmo));

	nf_fp_srchaddrsrchcount :=__common__( if(not(truedid), NULL, (integer)fp_srchaddrsrchcount));

	nf_fp_srchaddrsrchcountmo :=__common__( if(not(truedid), NULL, (integer)fp_srchaddrsrchcountmo));

	nf_fp_srchaddrsrchcountwk :=__common__( if(not(truedid), NULL, (integer)fp_srchaddrsrchcountwk));

	nf_fp_srchphonesrchcount :=__common__( if(not(truedid), NULL, (integer)fp_srchphonesrchcount));

	nf_fp_srchphonesrchcountmo :=__common__( if(not(truedid), NULL, (integer)fp_srchphonesrchcountmo));

	nf_fp_addrchangeincomediff :=__common__( if(not(truedid), NULL, (integer)fp_addrchangeincomediff));

	nf_fp_addrchangevaluediff :=__common__( if(not(truedid), NULL, (integer)fp_addrchangevaluediff));

	nf_fp_curraddrmedianincome :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmedianincome));

	nf_fp_curraddrmedianvalue :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmedianvalue));

	nf_fp_curraddrmurderindex :=__common__( if(not(truedid), NULL, (integer)fp_curraddrmurderindex));

	nf_fp_curraddrcartheftindex :=__common__( if(not(truedid), NULL, (integer)fp_curraddrcartheftindex));

	nf_fp_curraddrcrimeindex :=__common__( if(not(truedid), NULL, (integer)fp_curraddrcrimeindex));

	nf_fp_prevaddrageoldest :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrageoldest));

	nf_fp_prevaddrlenofres :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrlenofres));

	nf_fp_prevaddrmedianincome :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrmedianincome));

	nf_fp_prevaddrmedianvalue :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue));

	nf_fp_prevaddrcartheftindex :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex));

	nf_fp_prevaddrburglaryindex :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex));

	nf_fp_prevaddrcrimeindex :=__common__( if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex));

	fp_segment :=__common__( if(fp_segment_1 = '', '5 Derog', fp_segment_1));

	iv_vs002_ssn_prior_dob :=__common__( if(iv_vs002_ssn_prior_dob_1 = '', '0', iv_vs002_ssn_prior_dob_1));

	iv_vs100_ssn_problem :=__common__( if(iv_vs100_ssn_problem_1 = '', '0', iv_vs100_ssn_problem_1));

	iv_db001_bankruptcy :=__common__( if(iv_db001_bankruptcy_1 = '', '0 - No BK', iv_db001_bankruptcy_1));

	iv_nas_summary :=__common__( if(iv_nas_summary_1 = '', 12, (integer)iv_nas_summary_1));

	iv_cvi :=__common__( if(iv_cvi_1 = '', 50, (integer)iv_cvi_1));

	iv_best_match_address :=__common__( if(iv_best_match_address_1 = '', 'ADD1', iv_best_match_address_1));

	iv_ag001_age :=__common__( if(iv_ag001_age_1 <= NULL, 41, (integer)iv_ag001_age_1));

	iv_pl002_addrs_per_ssn_c6 :=__common__( if(iv_pl002_addrs_per_ssn_c6_1 <= NULL, 0, iv_pl002_addrs_per_ssn_c6_1));

	iv_combined_age :=__common__( if(iv_combined_age_1 <= NULL, 40, iv_combined_age_1));

	iv_avg_prop_sold_purch_amt :=__common__( if(iv_avg_prop_sold_purch_amt_1 <= NULL, -1, iv_avg_prop_sold_purch_amt_1));

	iv_inq_per_ssn :=__common__( if(iv_inq_per_ssn_1 <= NULL, 1, iv_inq_per_ssn_1));

	N0_5 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '7', '8']) => -1.0825029,
				(nf_fp_varrisktype in ['9'])                                          => -1.0187916,
																						 -1.0825029));

	N0_4 :=__common__( map(((real)iv_combined_age <= NULL) => -1.1064257,
				((real)iv_combined_age < 38.5)  => N0_5,
												   -1.1064257));

	N0_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0']) => -1.1098897,
				(iv_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2', '3-3']) => -1.058047,
																				 -1.058047));

	N0_2 :=__common__( map(((real)iv_ag001_age <= NULL) => -1.1287787,
				((real)iv_ag001_age < 33.5)  => N0_3,
												-1.1287787));

	N0_1 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3'])                      => N0_2,
				(nf_fp_varrisktype in ['-1', '4', '5', '6', '7', '8', '9']) => N0_4,
																			   N0_4));

	N1_6 :=__common__( if(((real)iv_age_at_low_issue < 10.5), 0.032970049, 0.0056475906));

	N1_5 :=__common__( if(((real)iv_age_at_low_issue > NULL), N1_6, 0.04277631));

	N1_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1'])               => -0.014662467,
				(iv_criminal_x_felony in ['1-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.0042951535,
																						0.0042951535));

	N1_3 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.016867599,
				((real)iv_inq_communications_recency < 0.5)   => -0.00017535473,
																 0.016867599));

	N1_2 :=__common__( map(((real)iv_combined_age <= NULL) => N1_4,
				((real)iv_combined_age < 35.5)  => N1_3,
												   N1_4));

	N1_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3'])          => N1_2,
				(nf_fp_varrisktype in ['4', '5', '6', '7', '8', '9']) => N1_5,
																		 N1_5));

	N2_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '7', '8']) => 0.038669466,
				(nf_fp_varrisktype in ['9'])                                          => 0.088190794,
																						 0.038669466));

	N2_5 :=__common__( map(((real)iv_combined_age <= NULL) => 0.014957396,
				((real)iv_combined_age < 32.5)  => N2_6,
												   0.014957396));

	N2_4 :=__common__( if(((real)iv_inq_communications_recency < 0.5), 0.0053450246, N2_5));

	N2_3 :=__common__( if(((real)iv_inq_communications_recency > NULL), N2_4, 0.03636196));

	N2_2 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.013554205,
				((real)iv_ag001_age < 38.5)  => 0.0014999692,
												-0.013554205));

	N2_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2'])                    => N2_2,
				(nf_fp_varrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N2_3,
																			  N2_3));

	N3_5 :=__common__( map((nf_fp_varrisktype in ['4', '5', '6'])                      => 0.015454235,
				(nf_fp_varrisktype in ['-1', '1', '2', '3', '7', '8', '9']) => 0.039068717,
																			   0.039068717));

	N3_4 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.0017626924,
				((real)iv_inq_communications_recency < 0.5)   => -0.014093629,
																 0.0017626924));

	N3_3 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => 0.00030285195,
				((real)iv_addr_non_phn_src_ct < 2.5)   => 0.017508666,
														  0.00030285195));

	N3_2 :=__common__( map(((real)iv_ag001_age <= NULL) => N3_4,
				((real)iv_ag001_age < 32.5)  => N3_3,
												N3_4));

	N3_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3'])          => N3_2,
				(nf_fp_varrisktype in ['4', '5', '6', '7', '8', '9']) => N3_5,
																		 N3_5));

	N4_5 :=__common__( map((iv_ed001_college_ind_36 in ['1']) => 0.0012705332,
				(iv_ed001_college_ind_36 in ['0']) => 0.020315842,
													  0.0012705332));

	N4_4 :=__common__( map((nf_fp_varrisktype in ['3', '4', '5'])                      => N4_5,
				(nf_fp_varrisktype in ['-1', '1', '2', '6', '7', '8', '9']) => 0.034038491,
																			   0.034038491));

	N4_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0', '3-3']) => 0.0024584063,
				(iv_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2'])               => 0.054147028,
																						0.0024584063));

	N4_2 :=__common__( map((iv_ed001_college_ind_36 in ['1']) => -0.012435793,
				(iv_ed001_college_ind_36 in ['0']) => N4_3,
													  -0.012435793));

	N4_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2'])                    => N4_2,
				(nf_fp_varrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N4_4,
																			  N4_4));

	N5_7 :=__common__( map(((real)iv_inq_highriskcredit_recency <= NULL) => 0.03264613,
				((real)iv_inq_highriskcredit_recency < 0.5)   => 0.0087425808,
																 0.03264613));

	N5_6 :=__common__( map(((real)iv_pb_average_dollars <= NULL) => 0.0090095175,
				((real)iv_pb_average_dollars < 13.5)  => N5_7,
														 0.0090095175));

	N5_5 :=__common__( if(((real)iv_age_at_high_issue < 8.5), N5_6, 0.0018240086));

	N5_4 :=__common__( if(((real)iv_age_at_high_issue > NULL), N5_5, 0.024286579));

	N5_3 :=__common__( if(((real)iv_age_at_high_issue < 4.5), 0.0029788836, -0.011794356));

	N5_2 :=__common__( if(((real)iv_age_at_high_issue > NULL), N5_3, 0.0085465785));

	N5_1 :=__common__( map((nf_fp_varrisktype in ['1', '2'])                                => N5_2,
				(nf_fp_varrisktype in ['-1', '3', '4', '5', '6', '7', '8', '9']) => N5_4,
																					N5_4));

	N6_7 :=__common__( map(((real)iv_combined_age <= NULL) => 0.0010650316,
				((real)iv_combined_age < 26.5)  => 0.020047034,
												   0.0010650316));

	N6_6 :=__common__( map(((real)iv_inq_recency <= NULL) => 0.024148308,
				((integer)iv_inq_recency < 2)  => 0.049568186,
												  0.024148308));

	N6_5 :=__common__( if((iv_ed001_college_ind_40 in ['0', '1']), N6_6, 0.011028943));

	N6_4 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => N6_7,
				((real)iv_addr_non_phn_src_ct < 2.5)   => N6_5,
														  N6_7));

	N6_3 :=__common__( map((nf_fp_varrisktype in ['1'])                                          => -0.011731807,
				(nf_fp_varrisktype in ['-1', '2', '3', '4', '5', '6', '7', '8', '9']) => 0.0016738498,
																						 0.0016738498));

	N6_2 :=__common__( if(((real)iv_inq_communications_recency < 0.5), N6_3, N6_4));

	N6_1 :=__common__( if(((real)iv_inq_communications_recency > NULL), N6_2, 0.027878613));

	N7_5 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => 0.00070361581,
				((real)iv_ssn_non_phn_src_ct < 4.5)   => 0.015841602,
														 0.00070361581));

	N7_4 :=__common__( map((nf_fp_varrisktype in ['3', '4', '5', '6'])            => N7_5,
				(nf_fp_varrisktype in ['-1', '1', '2', '7', '8', '9']) => 0.030431399,
																		  0.030431399));

	N7_3 :=__common__( map((iv_ed001_college_ind_37 in ['1']) => -0.0048220646,
				(iv_ed001_college_ind_37 in ['0']) => 0.012719771,
													  -0.0048220646));

	N7_2 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => -0.011031821,
				((real)iv_addr_non_phn_src_ct < 2.5)   => N7_3,
														  -0.011031821));

	N7_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2'])                    => N7_2,
				(nf_fp_varrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N7_4,
																			  N7_4));

	N8_8 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => 0.026230935,
				(nf_fp_idverrisktype in ['7'])                                    => 0.11063383,
																					 0.026230935));

	N8_7 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => 0.0087575561,
				((real)nf_fp_corrssnaddrcount < 2.5)   => N8_8,
														  0.0087575561));

	N8_6 :=__common__( map(((real)iv_combined_age <= NULL) => -0.0023468932,
				((real)iv_combined_age < 39.5)  => N8_7,
												   -0.0023468932));

	N8_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2'])                          => N8_6,
				(nf_fp_srchcomponentrisktype in ['3', '4', '5', '6', '7', '8', '9']) => 0.033251379,
																						0.033251379));

	N8_4 :=__common__( if(((real)iv_age_at_high_issue < 4.5), 0.0028266156, -0.012026649));

	N8_3 :=__common__( if(((real)iv_age_at_high_issue > NULL), N8_4, 0.010588846));

	N8_2 :=__common__( if(((real)iv_inq_communications_recency < 0.5), N8_3, N8_5));

	N8_1 :=__common__( if(((real)iv_inq_communications_recency > NULL), N8_2, 0.024163668));

	N9_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '7', '8']) => 0.012565988,
				(nf_fp_varrisktype in ['9'])                                          => 0.040220172,
																						 0.012565988));

	N9_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2'])               => N9_6,
				(iv_criminal_x_felony in ['1-1', '2-1', '3-0', '3-1', '3-2', '3-3']) => 0.041718506,
																						0.041718506));

	N9_4 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen < 302.5), N9_5, -0.003231188));

	N9_3 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen > NULL), N9_4, 0.015494299));

	N9_2 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.009426554,
				((real)iv_ag001_age < 33.5)  => 0.0061241277,
												-0.009426554));

	N9_1 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3'])                      => N9_2,
				(nf_fp_varrisktype in ['-1', '4', '5', '6', '7', '8', '9']) => N9_3,
																			   N9_3));

	N10_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0'])                                           => 0.011808425,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.03193736,
																									   0.03193736));

	N10_4 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.010508754,
				 ((real)iv_ag001_age < 27.5)  => 0.0058496897,
												 -0.010508754));

	N10_3 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.014593922,
				 ((real)iv_inq_communications_recency < 0.5)   => 0.00071744363,
																  0.014593922));

	N10_2 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => N10_4,
				 ((real)iv_addr_non_phn_src_ct < 2.5)   => N10_3,
														   N10_4));

	N10_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4']) => N10_2,
				 (nf_fp_varrisktype in ['5', '6', '7', '8', '9'])  => N10_5,
																	  N10_5));

	N11_7 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0010776095,
				 ((real)iv_inq_auto_recency < 0.5)   => 0.014834819,
														-0.0010776095));

	N11_6 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N11_7,
				 (nf_fp_srchvelocityrisktype in ['8', '9'])                          => 0.024438635,
																						N11_7));

	N11_5 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 4.5), N11_6, 0.00036359496));

	N11_4 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N11_5, 0.011786949));

	N11_3 :=__common__( if(((real)iv_age_at_high_issue < 2.5), 0.0012232786, -0.012812272));

	N11_2 :=__common__( if(((real)iv_age_at_high_issue > NULL), N11_3, 0.010981336));

	N11_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1'])                              => N11_2,
				 (nf_fp_varrisktype in ['2', '3', '4', '5', '6', '7', '8', '9']) => N11_4,
																					N11_4));

	N12_7 :=__common__( map(((real)iv_va060_dist_add_in_bst <= NULL) => 0.042818757,
				 ((real)iv_va060_dist_add_in_bst < 1.5)   => 0.018067969,
															 0.042818757));

	N12_6 :=__common__( map(((real)iv_inq_phones_per_adl <= NULL) => 0.030119437,
				 ((real)iv_inq_phones_per_adl < 1.5)   => 0.010987761,
														  0.030119437));

	N12_5 :=__common__( map(((real)iv_combined_age <= NULL) => 0.0018704614,
				 ((real)iv_combined_age < 25.5)  => N12_6,
													0.0018704614));

	N12_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0'])                             => N12_5,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N12_7,
																								N12_7));

	N12_3 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => -0.0096059081,
				 ((real)iv_pl002_avg_mo_per_addr < 16.5)  => 0.0050193745,
															 -0.0096059081));

	N12_2 :=__common__( if(((real)iv_inq_communications_recency < 0.5), N12_3, N12_4));

	N12_1 :=__common__( if(((real)iv_inq_communications_recency > NULL), N12_2, 0.017989637));

	N13_7 :=__common__( map((iv_criminal_x_felony in ['0-0'])                                                         => 0.0016724077,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.017312892,
																											  0.017312892));

	N13_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4']) => N13_7,
				 (nf_fp_varrisktype in ['5', '6', '7', '8', '9'])  => 0.020767536,
																	  0.020767536));

	N13_5 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.022636301,
				 ((real)iv_attr_arrests_recency < 0.5)   => -0.010619769,
															0.022636301));

	N13_4 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '6'])                => N13_5,
				 (nf_fp_srchcomponentrisktype in ['3', '4', '5', '7', '8', '9']) => 0.011311903,
																					0.011311903));

	N13_3 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => N13_4,
				 (iv_ed001_college_ind_26 in ['0']) => 0.0091539573,
													   N13_4));

	N13_2 :=__common__( if(((real)iv_inq_communications_recency < 0.5), N13_3, N13_6));

	N13_1 :=__common__( if(((real)iv_inq_communications_recency > NULL), N13_2, 0.013886421));

	N14_8 :=__common__( if(((real)iv_age_at_high_issue < 3.5), 0.021295536, 0.0083033636));

	N14_7 :=__common__( if(((real)iv_age_at_high_issue > NULL), N14_8, -0.010762681));

	N14_6 :=__common__( map((iv_nas_summary in [4, 9, 11, 12])                         => N14_7,
				 (iv_nas_summary in [0, 1, 2, 3, 6, 7, 8, 10]) => 0.089952318,
																						 0.089952318));

	N14_5 :=__common__( if(((real)nf_fp_corrssnaddrcount > NULL), N14_6, 0.015950178));

	N14_4 :=__common__( map(((real)iv_pb_average_dollars <= NULL) => -0.0050659866,
				 ((real)iv_pb_average_dollars < 11.5)  => 0.0079556306,
														  -0.0050659866));

	N14_3 :=__common__( if(((real)iv_age_at_high_issue < 7.5), N14_4, -0.010785281));

	N14_2 :=__common__( if(((real)iv_age_at_high_issue > NULL), N14_3, 0.011552655));

	N14_1 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N14_2,
				 (nf_fp_srchvelocityrisktype in ['8', '9'])                          => N14_5,
																						N14_5));

	N15_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5']) => 0.0075754145,
				 (nf_fp_varrisktype in ['6', '7', '8', '9'])            => 0.020739195,
																		   0.0075754145));

	N15_6 :=__common__( if(((real)iv_age_at_low_issue < 9.5), N15_7, -0.0038326839));

	N15_5 :=__common__( if(((real)iv_age_at_low_issue > NULL), N15_6, 0.018290022));

	N15_4 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N15_5, 0.036462264));

	N15_3 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N15_4, 0.0057455532));

	N15_2 :=__common__( map(((real)iv_src_property_adl_count <= NULL) => -0.014832772,
				 ((real)iv_src_property_adl_count < 0.5)   => -0.0018467105,
															  -0.014832772));

	N15_1 :=__common__( map((nf_fp_varrisktype in ['1'])                                          => N15_2,
				 (nf_fp_varrisktype in ['-1', '2', '3', '4', '5', '6', '7', '8', '9']) => N15_3,
																						  N15_3));

	N16_6 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => 0.002079806,
				 ((real)iv_addr_non_phn_src_ct < 2.5)   => 0.01400563,
														   0.002079806));

	N16_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0']) => -0.00017924709,
				 (iv_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2', '3-3']) => 0.02908082,
																				  0.02908082));

	N16_4 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5']) => -0.0092659704,
				 (nf_fp_corrrisktype in ['6', '7', '8', '9'])      => N16_5,
																	  -0.0092659704));

	N16_3 :=__common__( if(((real)iv_inq_communications_recency < 0.5), N16_4, N16_6));

	N16_2 :=__common__( if(((real)iv_inq_communications_recency > NULL), N16_3, 0.021081698));

	N16_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N16_2,
				 (nf_fp_idverrisktype in ['7', '9'])                          => 0.076297943,
																				 N16_2));

	N17_5 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5']) => -0.011484226,
				 (nf_fp_srchvelocityrisktype in ['6', '7', '8', '9'])      => -5.8125566e-005,
																			  -0.011484226));

	N17_4 :=__common__( map((nf_fp_varrisktype in ['1'])                                          => 0.0041594247,
				 (nf_fp_varrisktype in ['-1', '2', '3', '4', '5', '6', '7', '8', '9']) => 0.015307431,
																						  0.015307431));

	N17_3 :=__common__( map((iv_ed001_college_ind_50 in ['1']) => -0.005279974,
				 (iv_ed001_college_ind_50 in ['0']) => N17_4,
													   -0.005279974));

	N17_2 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => N17_5,
				 ((real)iv_addr_non_phn_src_ct < 2.5)   => N17_3,
														   N17_5));

	N17_1 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '4', '5'])  => N17_2,
				 (nf_fp_varrisktype in ['-1', '6', '7', '8', '9']) => 0.016790434,
																	  0.016790434));

	N18_6 :=__common__( if(((real)iv_addr_non_phn_src_ct < 2.5), 0.012349522, 0.0018033168));

	N18_5 :=__common__( if(((real)iv_addr_non_phn_src_ct > NULL), N18_6, 0.0099911747));

	N18_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0']) => N18_5,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => 0.032279183,
																				  N18_5));

	N18_3 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => -0.0034464985,
				 ((real)iv_addr_non_phn_src_ct < 2.5)   => 0.0081293243,
														   -0.0034464985));

	N18_2 :=__common__( map(((real)iv_pb_average_dollars <= NULL) => -0.0083774812,
				 ((real)iv_pb_average_dollars < 11.5)  => N18_3,
														  -0.0083774812));

	N18_1 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2'])                    => N18_2,
				 (nf_fp_varrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N18_4,
																			   N18_4));

	N19_7 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '6', '7']) => 0.020351196,
				 (nf_fp_srchvelocityrisktype in ['5', '8', '9'])                => 0.045550067,
																				   0.020351196));

	N19_6 :=__common__( map(((real)iv_filing_count <= NULL) => -0.0067265953,
				 ((real)iv_filing_count < 0.5)   => 0.0045160245,
													-0.0067265953));

	N19_5 :=__common__( map((fp_segment in ['7 Other'])                                                                               => -0.0087834594,
				 (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => N19_6,
																															  N19_6));

	N19_4 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => -0.00060814794,
				 ((real)nf_fp_corrphonelastnamecount < 0.5)   => 0.015492616,
																 -0.00060814794));

	N19_3 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => N19_5,
				 ((real)iv_pl002_avg_mo_per_addr < 12.5)  => N19_4,
															 N19_5));

	N19_2 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N19_3, N19_7));

	N19_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N19_2, 0.0086929615));

	N20_7 :=__common__( map((fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => 0.013588216,
				 (fp_segment in ['1 SSN Prob'])                                                                         => 0.10211828,
																														   0.013588216));

	N20_6 :=__common__( if(((real)c_hval_400k_p < 1.15000009537), 0.013877833, 0.0021003997));

	N20_5 :=__common__( if(trim(C_HVAL_400K_P) != '', N20_6, 0.017239499));

	N20_4 :=__common__( if(((real)iv_dg001_derog_count < 8.5), -0.004016171, 0.012418703));

	N20_3 :=__common__( if(((real)iv_dg001_derog_count > NULL), N20_4, 0.0017954381));

	N20_2 :=__common__( map((iv_ed001_college_ind_29 in ['1']) => N20_3,
				 (iv_ed001_college_ind_29 in ['0']) => N20_5,
													   N20_3));

	N20_1 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '4', '5'])  => N20_2,
				 (nf_fp_varrisktype in ['-1', '6', '7', '8', '9']) => N20_7,
																	  N20_2));

	N21_7 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => 0.0029566747,
				 ((real)nf_fp_corrssnaddrcount < 2.5)   => 0.016943123,
														   0.0029566747));

	N21_6 :=__common__( map(((real)iv_combined_age <= NULL) => N21_7,
				 ((real)iv_combined_age < 22.5)  => 0.02485509,
													N21_7));

	N21_5 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.010930217,
				 ((real)nf_fp_srchfraudsrchcount < 4.5)   => -0.0018732496,
															 0.010930217));

	N21_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0095669758,
				 ((real)iv_inq_auto_recency < 0.5)   => N21_5,
														-0.0095669758));

	N21_3 :=__common__( map(((real)iv_inq_highriskcredit_count12 <= NULL) => N21_6,
				 ((real)iv_inq_highriskcredit_count12 < 1.5)   => N21_4,
																  N21_6));

	N21_2 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N21_3, 0.023595459));

	N21_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N21_2, 0.011522157));

	N22_6 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.020731188,
				 ((real)iv_inq_communications_recency < 0.5)   => 0.0068924115,
																  0.020731188));

	N22_5 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.00011311412,
				 ((integer)nf_average_rel_home_val < 132500) => 0.012126747,
																-0.00011311412));

	N22_4 :=__common__( map((iv_ed001_college_ind_29 in ['1']) => -0.0048906964,
				 (iv_ed001_college_ind_29 in ['0']) => N22_5,
													   -0.0048906964));

	N22_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0'])               => N22_4,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.017701296,
																						 0.017701296));

	N22_2 :=__common__( if(((real)iv_attr_felonies_recency > NULL), N22_3, 0.0029713815));

	N22_1 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2'])                          => N22_2,
				 (nf_fp_srchcomponentrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N22_6,
																						 N22_2));

	N23_7 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.017451645,
				 ((real)nf_fp_srchfraudsrchcount < 12.5)  => 0.0044333641,
															 0.017451645));

	N23_6 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '3-1']) => -0.0074202294,
				 (iv_paw_dead_bus_x_active_phn in ['2-2', '2-3', '3-0', '3-2', '3-3'])                                           => 0.18847649,
																																	-0.0074202294));

	N23_5 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged'])                             => N23_6,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => N23_7,
																							   N23_7));

	N23_4 :=__common__( map((iv_nas_summary in [0, 4, 6, 7, 8, 9, 10, 11, 12]) => N23_5,
				 (iv_nas_summary in [1, 2, 3])                                     => 0.091536554,
																							   N23_5));

	N23_3 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => N23_4,
				 ((real)iv_inq_communications_recency < 0.5)   => -0.0030922462,
																  N23_4));

	N23_2 :=__common__( if(((real)iv_attr_arrests_recency < 4.5), N23_3, 0.020769855));

	N23_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N23_2, 0.014461312));

	N24_7 :=__common__( map(((real)nf_fp_srchfraudsrchcountmo <= NULL) => 0.011848207,
				 ((real)nf_fp_srchfraudsrchcountmo < 1.5)   => -0.0049931661,
															   0.011848207));

	N24_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-1']) => 0.012089986,
				 (iv_criminal_x_felony in ['1-1', '2-1', '3-0', '3-2', '3-3']) => 0.033885266,
																				  0.033885266));

	N24_5 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => 0.0043264993,
				 (iv_dl_val_flag in ['Empty'])     => N24_6,
													  N24_6));

	N24_4 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0060159497,
				 ((real)iv_ag001_age < 48.5)  => N24_5,
												 -0.0060159497));

	N24_3 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => N24_7,
				 ((real)iv_addr_non_phn_src_ct < 2.5)   => N24_4,
														   N24_7));

	N24_2 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N24_3, 0.019450444));

	N24_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N24_2, 0.0049482017));

	N25_7 :=__common__( map(((real)nf_fp_srchaddrsrchcountwk <= NULL) => 0.021866417,
				 ((real)nf_fp_srchaddrsrchcountwk < 0.5)   => 0.0058039831,
															  0.021866417));

	N25_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0']) => 0.0018726585,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => 0.024906256,
																				  0.024906256));

	N25_5 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '6', '8', '9']) => N25_6,
				 (nf_fp_idverrisktype in ['5', '7'])                          => 0.052991298,
																				 N25_6));

	N25_4 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0052883419,
				 (nf_fp_corrrisktype in ['7', '8', '9'])                => N25_5,
																		   -0.0052883419));

	N25_3 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2'])                          => N25_4,
				 (nf_fp_srchcomponentrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N25_7,
																						 N25_7));

	N25_2 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N25_3, 0.019882483));

	N25_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N25_2, 0.0039510591));

	N26_7 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => -0.0059381323,
				 ((real)nf_fp_corrssnaddrcount < 4.5)   => 0.0050001192,
														   -0.0059381323));

	N26_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0'])               => N26_7,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.017340312,
																						 0.017340312));

	N26_5 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => N26_6,
				 ((real)iv_inq_communications_recency < 0.5)   => -0.0043083958,
																  N26_6));

	N26_4 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N26_5,
				 (nf_fp_idverrisktype in ['7', '9'])                          => 0.049347189,
																				 N26_5));

	N26_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0'])               => 0.010741514,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.040173574,
																						 0.040173574));

	N26_2 :=__common__( if(((real)iv_pl002_avg_mo_per_addr < 10.5), N26_3, N26_4));

	N26_1 :=__common__( if(((real)iv_pl002_avg_mo_per_addr > NULL), N26_2, 0.0030703916));

	N27_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '3'])                    => 0.0056119989,
				 (nf_fp_varrisktype in ['2', '4', '5', '6', '7', '8', '9']) => 0.020168886,
																			   0.020168886));

	N27_5 :=__common__( if(((real)iv_va060_dist_add_in_bst < 0.5), 0.001756239, N27_6));

	N27_4 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N27_5, 0.0050369037));

	N27_3 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '6', '7']) => N27_4,
				 (nf_fp_srchcomponentrisktype in ['5', '8', '9'])                => 0.027203787,
																					N27_4));

	N27_2 :=__common__( map((iv_nas_summary in [0, 4, 6, 7, 8, 9, 10, 11, 12]) => -0.0035101361,
				 (iv_nas_summary in [1, 2, 3])                                     => 0.070143708,
																							   -0.0035101361));

	N27_1 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '3 Retail Shopper', '4 Other']) => N27_2,
				 (iv_pb_profile in ['0 No Purch Data'])                                                      => N27_3,
																												N27_3));

	N28_8 :=__common__( map(((real)nf_fp_srchfraudsrchcountmo <= NULL) => 0.0086730881,
				 ((real)nf_fp_srchfraudsrchcountmo < 1.5)   => -0.0046193932,
															   0.0086730881));

	N28_7 :=__common__( map((nf_fp_divrisktype in ['1', '5', '9'])                => 0.0037428347,
				 (nf_fp_divrisktype in ['2', '3', '4', '6', '7', '8']) => 0.015025058,
																		  0.015025058));

	N28_6 :=__common__( if(((real)iv_inq_ssns_per_addr > NULL), N28_7, 0.038035644));

	N28_5 :=__common__( map(((real)nf_fp_varmsrcssnunrelcount <= NULL) => 0.024527997,
				 ((real)nf_fp_varmsrcssnunrelcount < 1.5)   => N28_6,
															   0.024527997));

	N28_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1']) => 0.00052251807,
				 (iv_criminal_x_felony in ['3-2', '3-3'])                                           => 0.030198604,
																									   0.00052251807));

	N28_3 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => N28_5,
				 ((real)iv_inq_communications_recency < 0.5)   => N28_4,
																  N28_5));

	N28_2 :=__common__( if(((real)iv_addr_non_phn_src_ct < 2.5), N28_3, N28_8));

	N28_1 :=__common__( if(((real)iv_addr_non_phn_src_ct > NULL), N28_2, -0.0018385164));

	N29_9 :=__common__( map(((real)iv_eviction_count <= NULL) => 0.012565755,
				 ((real)iv_eviction_count < 1.5)   => -0.0023497633,
													  0.012565755));

	N29_8 :=__common__( if(((real)iv_inq_ssns_per_addr < 2.5), 0.0056206241, 0.01873742));

	N29_7 :=__common__( if(((real)iv_inq_ssns_per_addr > NULL), N29_8, 0.089267731));

	N29_6 :=__common__( map(((real)iv_age_at_low_issue <= NULL) => N29_9,
				 ((real)iv_age_at_low_issue < 0.5)   => N29_7,
														N29_9));

	N29_5 :=__common__( map((fp_segment in ['2 NAS 479', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N29_6,
				 (fp_segment in ['1 SSN Prob', '3 New DID'])                                               => 0.05149298,
																											  N29_6));

	N29_4 :=__common__( if(((real)iv_age_at_low_issue > NULL), N29_5, 0.022209959));

	N29_3 :=__common__( map(((real)iv_inq_highriskcredit_recency <= NULL) => N29_4,
				 ((real)iv_inq_highriskcredit_recency < 0.5)   => -0.0059052896,
																  N29_4));

	N29_2 :=__common__( if(((integer)iv_attr_felonies_recency < 2), N29_3, 0.017462936));

	N29_1 :=__common__( if(((real)iv_attr_felonies_recency > NULL), N29_2, 0.0064808125));

	N30_6 :=__common__( if(((real)nf_rel_felony_count < 1.5), 0.0058025071, 0.018784743));

	N30_5 :=__common__( if(((real)nf_rel_felony_count > NULL), N30_6, 0.0021886213));

	N30_4 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N30_5,
				 (iv_vs002_ssn_prior_dob in ['1']) => 0.078687429,
													  0.078687429));

	N30_3 :=__common__( map((nf_fp_varrisktype in ['1'])                                          => -0.00031296875,
				 (nf_fp_varrisktype in ['-1', '2', '3', '4', '5', '6', '7', '8', '9']) => N30_4,
																						  N30_4));

	N30_2 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5']) => -0.011763206,
				 (nf_fp_srchvelocityrisktype in ['6', '7', '8', '9'])      => -0.00036028975,
																			  -0.011763206));

	N30_1 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '3 Retail Shopper', '4 Other']) => N30_2,
				 (iv_pb_profile in ['0 No Purch Data'])                                                      => N30_3,
																												N30_3));

	N31_7 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.0063970876,
				 ((real)iv_inq_communications_recency < 0.5)   => -0.0019675806,
																  0.0063970876));

	N31_6 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '6', '8']) => N31_7,
				 (nf_fp_idverrisktype in ['5', '7', '9'])                => 0.033837435,
																			N31_7));

	N31_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '3', '4'])                => 0.0093325843,
				 (nf_fp_srchcomponentrisktype in ['2', '5', '6', '7', '8', '9']) => 0.030388903,
																					0.030388903));

	N31_4 :=__common__( map(((real)iv_mos_since_bst_addr_fseen <= NULL) => N31_6,
				 ((real)iv_mos_since_bst_addr_fseen < 4.5)   => N31_5,
																N31_6));

	N31_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0', '3-1']) => N31_4,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-2', '3-3'])               => 0.027238952,
																						 N31_4));

	N31_2 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 4.5), N31_3, -0.0035163425));

	N31_1 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N31_2, 0.0025542369));

	N32_6 :=__common__( map(((real)iv_dg001_derog_count <= NULL) => 0.025913557,
				 ((real)iv_dg001_derog_count < 6.5)   => 0.0078912746,
														 0.025913557));

	N32_5 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => 0.0019279424,
				 ((real)iv_pl002_avg_mo_per_addr < 12.5)  => 0.011004045,
															 0.0019279424));

	N32_4 :=__common__( if(((real)nf_fp_corrphonelastnamecount < 0.5), N32_5, -0.0046764069));

	N32_3 :=__common__( if(((real)nf_fp_corrphonelastnamecount > NULL), N32_4, -0.0003533279));

	N32_2 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N32_3,
				 (nf_fp_srchvelocityrisktype in ['8', '9'])                          => N32_6,
																						N32_3));

	N32_1 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.0086609088,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => N32_2,
																				   N32_2));

	N33_7 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.0046254809,
				 ((real)nf_fp_srchfraudsrchcount < 14.5)  => -0.0087182381,
															 0.0046254809));

	N33_6 :=__common__( map(((real)nf_fp_corrssnnamecount <= NULL) => 0.0055710024,
				 ((real)nf_fp_corrssnnamecount < 4.5)   => 0.019416827,
														   0.0055710024));

	N33_5 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0035611203,
				 (nf_fp_corrrisktype in ['7', '8', '9'])                => 0.0053676054,
																		   -0.0035611203));

	N33_4 :=__common__( map(((real)nf_fp_srchfraudsrchcountyr <= NULL) => N33_6,
				 ((real)nf_fp_srchfraudsrchcountyr < 3.5)   => N33_5,
															   N33_6));

	N33_3 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.019657158,
				 ((real)iv_attr_arrests_recency < 0.5)   => N33_4,
															0.019657158));

	N33_2 :=__common__( if(((real)iv_inq_auto_recency < 0.5), N33_3, N33_7));

	N33_1 :=__common__( if(((real)iv_inq_auto_recency > NULL), N33_2, 0.0075339691));

	N34_6 :=__common__( map((nf_fp_corrrisktype in ['2', '3', '4', '5', '6', '7', '8']) => 0.014717741,
				 (nf_fp_corrrisktype in ['1', '9'])                          => 0.038622924,
																				0.014717741));

	N34_5 :=__common__( if(((integer)nf_average_rel_home_val < 140500), N34_6, 0.0033556415));

	N34_4 :=__common__( if(((real)nf_average_rel_home_val > NULL), N34_5, 0.0045077039));

	N34_3 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.017271125,
				 ((real)nf_fp_srchfraudsrchcount < 7.5)   => 0.0015020337,
															 0.017271125));

	N34_2 :=__common__( map(((real)iv_combined_age <= NULL) => -0.0031570563,
				 ((real)iv_combined_age < 25.5)  => N34_3,
													-0.0031570563));

	N34_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0'])                             => N34_2,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N34_4,
																								N34_4));

	N35_6 :=__common__( if((iv_ed001_college_ind_50 in ['0', '1']), 0.012745612, -0.00074851018));

	N35_5 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.016204225,
				 ((integer)iv_attr_arrests_recency < 2)  => -0.00057170628,
															0.016204225));

	N35_4 :=__common__( if(((real)nf_rel_felony_count < 1.5), N35_5, 0.011491666));

	N35_3 :=__common__( if(((real)nf_rel_felony_count > NULL), N35_4, 0.0026176553));

	N35_2 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '4 Semi-monthly', '5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => -0.0058656249,
				 (iv_pb_order_freq in ['0 No Purch Data', '2 Weekly', '3 Monthly'])                                                   => N35_3,
																																		 N35_3));

	N35_1 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2'])                          => N35_2,
				 (nf_fp_srchcomponentrisktype in ['3', '4', '5', '6', '7', '8', '9']) => N35_6,
																						 N35_2));

	N36_7 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => 0.0045996663,
				 ((real)iv_inq_collection_count12 < 0.5)   => -0.0030641071,
															  0.0045996663));

	N36_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0'])                             => N36_7,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 0.0075527138,
																								0.0075527138));

	N36_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '3-2', '3-3', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.014607914,
				 (iv_gong_did_fname_x_lname_ct in ['1-2', '2-2', '2-3', '3-1', '4-1'])                                                         => 0.059962294,
																																				  0.014607914));

	N36_4 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '5', '6', '8', '9']) => N36_5,
				 (nf_fp_idverrisktype in ['4', '7'])                          => 0.048903078,
																				 N36_5));

	N36_3 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-3', '1-1', '2-0', '2-3'])                      => 0.0025898084,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-3', '2-1', '3-0', '3-1', '3-3']) => N36_4,
																											   N36_4));

	N36_2 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 2.5), N36_3, N36_6));

	N36_1 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N36_2, 0.0095224402));

	N37_8 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => -0.00090587348,
				 (iv_ed001_college_ind_26 in ['0']) => 0.011661282,
													   -0.00090587348));

	N37_7 :=__common__( map((iv_nas_summary in [0, 3, 4, 6, 7, 9, 10, 11, 12]) => N37_8,
				 (iv_nas_summary in [1, 2, 8])                                     => 0.049563232,
																							   N37_8));

	N37_6 :=__common__( map(((real)nf_fp_prevaddrcartheftindex <= NULL) => N37_7,
				 ((real)nf_fp_prevaddrcartheftindex < 132.5) => -0.0056688964,
																N37_7));

	N37_5 :=__common__( if(((real)iv_inq_per_addr < 6.5), N37_6, 0.0059552639));

	N37_4 :=__common__( if(((real)iv_inq_per_addr > NULL), N37_5, 0.001291453));

	N37_3 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.017436746,
				 ((real)nf_fp_srchfraudsrchcount < 12.5)  => 0.0049293237,
															 0.017436746));

	N37_2 :=__common__( if(((real)iv_pl002_avg_mo_per_addr < 12.5), N37_3, N37_4));

	N37_1 :=__common__( if(((real)iv_pl002_avg_mo_per_addr > NULL), N37_2, 0.0016203315));

	N38_7 :=__common__( map(((real)iv_pl001_bst_addr_lres <= NULL) => 0.0098292324,
				 ((real)iv_pl001_bst_addr_lres < 5.5)   => 0.025698632,
														   0.0098292324));

	N38_6 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 4.5), N38_7, 0.0036365666));

	N38_5 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N38_6, 0.0037739617));

	N38_4 :=__common__( map((iv_nas_summary in [0, 2, 4, 7, 9, 10, 12]) => 0.0041136201,
				 (iv_nas_summary in [1, 3, 6, 8, 11])             => 0.070180338,
																				   0.0041136201));

	N38_3 :=__common__( if(((real)iv_va060_dist_add_in_bst < 0.5), -0.0034774012, N38_4));

	N38_2 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N38_3, 0.0049991997));

	N38_1 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N38_2,
				 (nf_fp_assocrisktype in ['7', '9'])                          => N38_5,
																				 N38_5));

	N39_7 :=__common__( map(((real)iv_dl001_lien_last_seen <= NULL) => 0.011139141,
				 ((real)iv_dl001_lien_last_seen < 8.5)   => 0.026079406,
															0.011139141));

	N39_6 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '2 Weekly', '4 Semi-monthly', '5 Quarterly', '7 Yearly', '8 Rarely']) => 0.0057237888,
				 (iv_pb_order_freq in ['0 No Purch Data', '3 Monthly', '6 Semi-yearly'])                                         => N39_7,
																																	0.0057237888));

	N39_5 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N39_6,
				 ((real)nf_fp_srchfraudsrchcount < 4.5)   => 0.0032615513,
															 N39_6));

	N39_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0089070901,
				 ((integer)iv_inq_auto_recency < 2)  => 0.0030324911,
														-0.0089070901));

	N39_3 :=__common__( map((fp_segment in ['4 Bureau Only', '6 Recent Activity', '7 Other'])   => N39_4,
				 (fp_segment in ['1 SSN Prob', '2 NAS 479', '3 New DID', '5 Derog']) => N39_5,
																						N39_5));

	N39_2 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 4.5), N39_3, -0.0028336774));

	N39_1 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N39_2, 0.0089067643));

	N40_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '8']) => 0.0090322814,
				 (nf_fp_varrisktype in ['6', '7', '9'])                      => 0.018599611,
																				0.0090322814));

	N40_6 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 9, 10, 11, 12]) => N40_7,
				 (iv_nas_summary in [1, 8])                                                 => 0.068499581,
																									 N40_7));

	N40_5 :=__common__( map(((real)iv_combined_age <= NULL) => -0.0054702144,
				 ((real)iv_combined_age < 49.5)  => N40_6,
													-0.0054702144));

	N40_4 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0028434032,
				 ((integer)nf_average_rel_home_val < 132500) => 0.0042093138,
																-0.0028434032));

	N40_3 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.010388969,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => N40_4,
																				   N40_4));

	N40_2 :=__common__( if(((real)iv_de001_eviction_recency < 1.5), N40_3, N40_5));

	N40_1 :=__common__( if(((real)iv_de001_eviction_recency > NULL), N40_2, 0.0030865191));

	N41_6 :=__common__( map(((real)iv_dc001_mos_since_crim_ls <= NULL) => 0.006815638,
				 ((real)iv_dc001_mos_since_crim_ls < 65.5)  => 0.025304447,
															   0.006815638));

	N41_5 :=__common__( map(((real)iv_dl_addrs_per_adl <= NULL) => N41_6,
				 ((real)iv_dl_addrs_per_adl < -0.5)  => 0.0056032442,
														N41_6));

	N41_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0'])                                           => 0.00093460047,
				 (iv_criminal_x_felony in ['1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N41_5,
																									   N41_5));

	N41_3 :=__common__( if(((real)nf_fp_corrphonelastnamecount < 0.5), N41_4, -0.0043174911));

	N41_2 :=__common__( if(((real)nf_fp_corrphonelastnamecount > NULL), N41_3, 0.0016814606));

	N41_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N41_2,
				 (nf_fp_idverrisktype in ['7', '9'])                          => 0.038825093,
																				 N41_2));

	N42_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '6', '8']) => 0.0051824357,
				 (nf_fp_srchcomponentrisktype in ['3', '5', '7', '9'])      => 0.019767066,
																			   0.0051824357));

	N42_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '8', '9']) => 0.0095780323,
				 (nf_fp_srchcomponentrisktype in ['4', '5', '6', '7'])      => 0.040615941,
																			   0.0095780323));

	N42_5 :=__common__( if((iv_ed001_college_ind_29 in ['0', '1']), N42_6, 0.0010596009));

	N42_4 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0068356234,
				 ((integer)nf_average_rel_home_val < 129500) => 0.00066350218,
																-0.0068356234));

	N42_3 :=__common__( map((iv_criminal_x_felony in ['0-0'])                                                         => N42_4,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N42_5,
																											  N42_5));

	N42_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N42_3, N42_7));

	N42_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N42_2, 0.0024900719));

	N43_8 :=__common__( map((nf_fp_validationrisktype in ['1'])                          => 0.0057752538,
				 (nf_fp_validationrisktype in ['2', '3', '4', '5', '6', '8']) => 0.07876493,
																				 0.07876493));

	N43_7 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => 0.016653949,
				 ((real)iv_inq_collection_count12 < 0.5)   => N43_8,
															  0.016653949));

	N43_6 :=__common__( map(((real)iv_ag001_age <= NULL) => 0.0012375636,
				 ((real)iv_ag001_age < 39.5)  => N43_7,
												 0.0012375636));

	N43_5 :=__common__( if(((real)c_fammar_p < 47.4500007629), 0.0095550127, -0.00048670445));

	N43_4 :=__common__( if(trim(C_FAMMAR_P) != '', N43_5, 0.0019366716));

	N43_3 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '4 Other']) => -0.006817765,
				 (iv_pb_profile in ['0 No Purch Data', '3 Retail Shopper'])              => N43_4,
																							-0.006817765));

	N43_2 :=__common__( if(((real)iv_inq_highriskcredit_count12 < 1.5), N43_3, N43_6));

	N43_1 :=__common__( if(((real)iv_inq_highriskcredit_count12 > NULL), N43_2, 0.0014318796));

	N44_6 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['00', '02', '04', '10', '11', '12', '14']) => 0.0047318156,
				 (iv_inp_own_prop_x_addr_naprop in ['01', '03', '13'])                         => 0.018734179,
																								  0.018734179));

	N44_5 :=__common__( if(((integer)nf_average_rel_home_val < 136500), N44_6, 0.0012966295));

	N44_4 :=__common__( if(((real)nf_average_rel_home_val > NULL), N44_5, 0.0022467686));

	N44_3 :=__common__( map(((real)iv_avg_lres <= NULL) => 0.0019758173,
				 ((real)iv_avg_lres < 24.5)  => 0.016718584,
												0.0019758173));

	N44_2 :=__common__( map(((real)iv_de001_eviction_recency <= NULL) => N44_3,
				 ((real)iv_de001_eviction_recency < 1.5)   => -0.0036067457,
															  N44_3));

	N44_1 :=__common__( map((iv_criminal_x_felony in ['0-0'])                                                         => N44_2,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N44_4,
																											  N44_4));

	N45_7 :=__common__( map(((real)nf_fp_prevaddrageoldest <= NULL) => 0.0056785078,
				 ((real)nf_fp_prevaddrageoldest < 6.5)   => 0.019046185,
															0.0056785078));

	N45_6 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.017384007,
				 ((real)nf_fp_srchfraudsrchcount < 8.5)   => 0.002244199,
															 0.017384007));

	N45_5 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '4'])                => -0.0075481708,
				 (nf_fp_srchvelocityrisktype in ['3', '5', '6', '7', '8', '9']) => 0.003596726,
																				   0.003596726));

	N45_4 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0070521925,
				 ((integer)nf_average_rel_home_val < 163500) => N45_5,
																-0.0070521925));

	N45_3 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => N45_4,
				 (iv_ed001_college_ind_26 in ['0']) => N45_6,
													   N45_4));

	N45_2 :=__common__( if(((real)iv_de001_eviction_recency < 1.5), N45_3, N45_7));

	N45_1 :=__common__( if(((real)iv_de001_eviction_recency > NULL), N45_2, -0.0026173213));

	N46_7 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.0046813175,
				 ((real)nf_fp_srchfraudsrchcount < 11.5)  => -0.0064278636,
															 0.0046813175));

	N46_6 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.017083708,
				 ((real)iv_attr_arrests_recency < 0.5)   => 0.00010677074,
															0.017083708));

	N46_5 :=__common__( map(((real)iv_inq_recency <= NULL) => 0.0013414427,
				 ((real)iv_inq_recency < 4.5)   => 0.010705509,
												   0.0013414427));

	N46_4 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => N46_5,
				 ((real)nf_fp_corrssnaddrcount < 0.5)   => 0.022066285,
														   N46_5));

	N46_3 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => N46_6,
				 ((real)iv_pl002_avg_mo_per_addr < 14.5)  => N46_4,
															 N46_6));

	N46_2 :=__common__( if(((real)nf_fp_corrphonelastnamecount < 0.5), N46_3, N46_7));

	N46_1 :=__common__( if(((real)nf_fp_corrphonelastnamecount > NULL), N46_2, -0.0032547853));

	N47_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.0053619295,
				 (iv_gong_did_fname_x_lname_ct in ['3-1'])                                                                                                                 => 0.09942264,
																																											  0.0053619295));

	N47_5 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.011674309,
				 ((real)iv_attr_arrests_recency < 0.5)   => -0.0033116673,
															0.011674309));

	N47_4 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo < 1.5), N47_5, 0.0090806664));

	N47_3 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo > NULL), N47_4, -0.0074067011));

	N47_2 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => N47_3,
				 (iv_ed001_college_ind_26 in ['0']) => N47_6,
													   N47_3));

	N47_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0']) => N47_2,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => 0.013080607,
																				  N47_2));

	N48_7 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-2'])               => 0.00063417418,
				 (iv_criminal_x_felony in ['2-0', '2-1', '3-0', '3-1', '3-2', '3-3']) => 0.012469944,
																						 0.012469944));

	N48_6 :=__common__( map((iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Unknown']) => 0.011341025,
				 (iv_inp_addr_mortgage_type in ['Commercial', 'Other', 'Piggyback'])                                                                    => 0.071177514,
																																						   0.071177514));

	N48_5 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => N48_7,
				 ((real)nf_fp_corrssnaddrcount < 2.5)   => N48_6,
														   N48_7));

	N48_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.009618916,
				 ((real)iv_inq_auto_recency < 0.5)   => -0.0012804125,
														-0.009618916));

	N48_3 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N48_4,
				 (nf_fp_assocrisktype in ['8', '9'])                          => 0.0050864749,
																				 N48_4));

	N48_2 :=__common__( if(((real)iv_inq_highriskcredit_count12 < 1.5), N48_3, N48_5));

	N48_1 :=__common__( if(((real)iv_inq_highriskcredit_count12 > NULL), N48_2, 0.0010779987));

	N49_5 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2']) => 0.0039977035,
				 (iv_best_match_address in ['ADD3', 'NONE']) => 0.017013332,
																0.017013332));

	N49_4 :=__common__( map(((real)nf_fp_srchaddrsrchcount <= NULL) => 0.019409554,
				 ((real)nf_fp_srchaddrsrchcount < 12.5)  => N49_5,
															0.019409554));

	N49_3 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '7']) => 0.0024488438,
				 (nf_fp_corrrisktype in ['6', '8', '9'])                => N49_4,
																		   0.0024488438));

	N49_2 :=__common__( map(((real)iv_mos_src_bureau_dob_fseen <= NULL) => -0.0036804186,
				 ((real)iv_mos_src_bureau_dob_fseen < 257.5) => N49_3,
																-0.0036804186));

	N49_1 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4'])      => -0.0041347889,
				 (nf_fp_srchvelocityrisktype in ['5', '6', '7', '8', '9']) => N49_2,
																			  -0.0041347889));

	N50_6 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => 0.010431827,
				 ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => -0.00012762568,
															  0.010431827));

	N50_5 :=__common__( map(((real)nf_fp_curraddrcartheftindex <= NULL) => 0.011779401,
				 ((real)nf_fp_curraddrcartheftindex < 177.5) => N50_6,
																0.011779401));

	N50_4 :=__common__( if(((real)iv_dg001_derog_count < 8.5), N50_5, 0.015445855));

	N50_3 :=__common__( if(((real)iv_dg001_derog_count > NULL), N50_4, 0.0076518436));

	N50_2 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '8']) => -0.0063977255,
				 (nf_fp_srchvelocityrisktype in ['6', '7', '9'])                => 0.00081080749,
																				   -0.0063977255));

	N50_1 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6']) => N50_2,
				 (nf_fp_corrrisktype in ['7', '8', '9'])                => N50_3,
																		   N50_3));

	N51_6 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => -0.00062910723,
				 (iv_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                           => 0.012514065,
																											  -0.00062910723));

	N51_5 :=__common__( map(((real)iv_ag001_age <= NULL) => N51_6,
				 ((real)iv_ag001_age < 28.5)  => 0.012195776,
												 N51_6));

	N51_4 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N51_5,
				 ((real)nf_fp_srchfraudsrchcount < 4.5)   => -0.00019274729,
															 N51_5));

	N51_3 :=__common__( if(((real)iv_inq_auto_recency < 0.5), N51_4, -0.0041286882));

	N51_2 :=__common__( if(((real)iv_inq_auto_recency > NULL), N51_3, -0.0018451593));

	N51_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '6'])      => N51_2,
				 (nf_fp_idverrisktype in ['4', '5', '7', '8', '9']) => 0.020431813,
																	   N51_2));

	N52_9 :=__common__( if(((real)c_rnt1000_p < 4.44999980927), 0.015436364, 0.0025260283));

	N52_8 :=__common__( if(trim(C_RNT1000_P) != '', N52_9, -0.00787516));

	N52_7 :=__common__( if(((real)c_business < 15.5), 0.009079961, 0.00076302779));

	N52_6 :=__common__( if(trim(C_BUSINESS) != '', N52_7, -0.0013109962));

	N52_5 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => -0.0027388107,
				 ((real)nf_fp_corrphonelastnamecount < 0.5)   => N52_6,
																 -0.0027388107));

	N52_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0049365326,
				 ((real)iv_inq_auto_recency < 0.5)   => N52_5,
														-0.0049365326));

	N52_3 :=__common__( map(((real)iv_src_property_adl_count <= NULL) => -0.0078593632,
				 ((real)iv_src_property_adl_count < 1.5)   => N52_4,
															  -0.0078593632));

	N52_2 :=__common__( if(((real)iv_dg001_derog_count < 6.5), N52_3, N52_8));

	N52_1 :=__common__( if(((real)iv_dg001_derog_count > NULL), N52_2, -0.0046482418));

	N53_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => 0.011087456,
				 (nf_fp_srchcomponentrisktype in ['7'])                                    => 0.054246257,
																							  0.011087456));

	N53_7 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => 0.0012905316,
				 ((real)iv_inq_auto_recency < 0.5)   => N53_8,
														0.0012905316));

	N53_6 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)    => -0.0024172203,
				 ((integer)nf_fp_curraddrmedianincome < 38785) => 0.0043534603,
																  -0.0024172203));

	N53_5 :=__common__( map(((real)iv_dg001_derog_count <= NULL) => 0.011695465,
				 ((real)iv_dg001_derog_count < 7.5)   => N53_6,
														 0.011695465));

	N53_4 :=__common__( if(((real)iv_inq_per_addr < 5.5), N53_5, N53_7));

	N53_3 :=__common__( if(((real)iv_inq_per_addr > NULL), N53_4, 0.027082637));

	N53_2 :=__common__( if(((real)iv_age_at_low_issue < 10.5), N53_3, -0.0047332511));

	N53_1 :=__common__( if(((real)iv_age_at_low_issue > NULL), N53_2, 0.0089767916));

	N54_9 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-2', '1-3', '2-0', '2-3', '3-1', '3-3']) => 0.010671851,
				 (iv_paw_dead_bus_x_active_phn in ['1-1', '2-1', '2-2', '3-0', '3-2'])                                           => 0.11053902,
																																	0.010671851));

	N54_8 :=__common__( map(((real)nf_fp_varmsrcssnunrelcount <= NULL) => N54_9,
				 ((real)nf_fp_varmsrcssnunrelcount < 1.5)   => 0.0012869171,
															   N54_9));

	N54_7 :=__common__( if(((real)iv_addr_non_phn_src_ct < 2.5), N54_8, -0.0031840012));

	N54_6 :=__common__( if(((real)iv_addr_non_phn_src_ct > NULL), N54_7, 0.0039206531));

	N54_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '5', '6', '7']) => 0.012102455,
				 (nf_fp_srchcomponentrisktype in ['4', '8', '9'])                => 0.037186344,
																					0.012102455));

	N54_4 :=__common__( if(((real)iv_age_at_high_issue < 4.5), N54_5, 0.0023694311));

	N54_3 :=__common__( if(((real)iv_age_at_high_issue > NULL), N54_4, -0.0011909798));

	N54_2 :=__common__( if(((real)c_cpiall < 203.600006104), N54_3, N54_6));

	N54_1 :=__common__( if(trim(C_CPIALL) != '', N54_2, -0.0033275388));

	N55_7 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.0057929073,
				 ((real)iv_inq_communications_recency < 0.5)   => 5.0945624e-005,
																  0.0057929073));

	N55_6 :=__common__( map(((real)iv_pb_average_dollars <= NULL) => -0.0051177305,
				 ((real)iv_pb_average_dollars < 27.5)  => N55_7,
														  -0.0051177305));

	N55_5 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => -0.0051932669,
				 ((real)nf_fp_corrphonelastnamecount < 0.5)   => N55_6,
																 -0.0051932669));

	N55_4 :=__common__( map(((real)nf_fp_srchcountwk <= NULL) => 0.0074000202,
				 ((real)nf_fp_srchcountwk < 0.5)   => N55_5,
													  0.0074000202));

	N55_3 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '6', '8']) => N55_4,
				 (nf_fp_idverrisktype in ['5', '7', '9'])                => 0.023043783,
																			N55_4));

	N55_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 3.5), N55_3, 0.015929967));

	N55_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N55_2, 0.0018086643));

	N56_7 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => 0.002658288,
				 ((real)nf_fp_corrssnaddrcount < 2.5)   => 0.01487516,
														   0.002658288));

	N56_6 :=__common__( map(((real)nf_fp_divaddrsuspidcountnew <= NULL) => 0.0053722687,
				 ((real)nf_fp_divaddrsuspidcountnew < 0.5)   => -0.0032435785,
																0.0053722687));

	N56_5 :=__common__( map(((real)nf_fp_curraddrcartheftindex <= NULL) => 0.0070070716,
				 ((real)nf_fp_curraddrcartheftindex < 171.5) => N56_6,
																0.0070070716));

	N56_4 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '4 Other']) => -0.0056781865,
				 (iv_pb_profile in ['0 No Purch Data', '3 Retail Shopper'])              => N56_5,
																							-0.0056781865));

	N56_3 :=__common__( map(((real)nf_fp_varmsrcssnunrelcount <= NULL) => N56_7,
				 ((real)nf_fp_varmsrcssnunrelcount < 1.5)   => N56_4,
															   N56_7));

	N56_2 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk < 1.5), N56_3, 0.014475125));

	N56_1 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk > NULL), N56_2, 0.00027874358));

	N57_7 :=__common__( map(((real)iv_lnames_per_adl <= NULL) => 0.0033648578,
				 ((real)iv_lnames_per_adl < 2.5)   => 0.018052172,
													  0.0033648578));

	N57_6 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 7, 9, 10, 11, 12]) => 0.0035133416,
				 (iv_nas_summary in [1, 6, 8])                                     => 0.050125978,
																							   0.0035133416));

	N57_5 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '4'])            => N57_6,
				 (nf_fp_varrisktype in ['-1', '5', '6', '7', '8', '9']) => N57_7,
																		   N57_7));

	N57_4 :=__common__( map(((real)nf_average_rel_income <= NULL)    => -0.0028127532,
				 ((integer)nf_average_rel_income < 50500) => 0.0052938315,
															 -0.0028127532));

	N57_3 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '2-3', '3-0', '3-3'])        => -0.0054550731,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '1-0', '1-1', '1-3', '2-0', '2-1', '3-1']) => N57_4,
																										N57_4));

	N57_2 :=__common__( if(((real)iv_va060_dist_add_in_bst < 0.5), N57_3, N57_5));

	N57_1 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N57_2, 0.00015548339));

	N58_6 :=__common__( if(((integer)iv_inq_communications_recency < 2), 0.0041031658, 0.010270437));

	N58_5 :=__common__( if(((real)iv_inq_communications_recency > NULL), N58_6, 0.040524226));

	N58_4 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.0061525416,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => N58_5,
																				   N58_5));

	N58_3 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0011351951,
				 (nf_fp_corrrisktype in ['7', '8', '9'])                => N58_4,
																		   N58_4));

	N58_2 :=__common__( map((fp_segment in ['3 New DID', '6 Recent Activity', '7 Other'])           => -0.0039060937,
				 (fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '5 Derog']) => N58_3,
																							N58_3));

	N58_1 :=__common__( map((iv_nas_summary in [0, 4, 7, 9, 10, 11, 12]) => N58_2,
				 (iv_nas_summary in [1, 2, 3, 6, 8])             => 0.02255998,
																				   N58_2));

	N59_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0', '3-3']) => 0.0077251573,
				 (iv_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2'])               => 0.030967233,
																						 0.0077251573));

	N59_7 :=__common__( if(((real)iv_ssn_non_phn_src_ct < 3.5), N59_8, 0.0010816671));

	N59_6 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N59_7, 0.0010076485));

	N59_5 :=__common__( if(((real)c_work_home < 169.5), N59_6, 0.020577517));

	N59_4 :=__common__( if(trim(C_WORK_HOME) != '', N59_5, 0.011387687));

	N59_3 :=__common__( if(((real)iv_inq_adls_per_addr < 2.5), -0.0023431727, 0.0062663865));

	N59_2 :=__common__( if(((real)iv_inq_adls_per_addr > NULL), N59_3, 0.0018933913));

	N59_1 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6']) => N59_2,
				 (nf_fp_assocrisktype in ['7', '8', '9'])                => N59_4,
																			N59_4));

	N60_8 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.019947236,
				 ((real)nf_fp_srchfraudsrchcount < 13.5)  => 0.0093425389,
															 0.019947236));

	N60_7 :=__common__( map(trim(C_TOTSALES) = ''        => 0.0013202329,
				 ((real)c_totsales < 10305.5) => N60_8,
												 0.0013202329));

	N60_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '3', '4', '5', '6', '8']) => N60_7,
				 (nf_fp_srchcomponentrisktype in ['2', '7', '9'])                => 0.020648298,
																					N60_7));

	N60_5 :=__common__( if(((real)c_easiqlife < 86.5), -0.00047879056, N60_6));

	N60_4 :=__common__( if(trim(C_EASIQLIFE) != '', N60_5, 0.0098973685));

	N60_3 :=__common__( map(((real)iv_inq_other_recency <= NULL) => N60_4,
				 ((real)iv_inq_other_recency < 0.5)   => -0.0010781869,
														 N60_4));

	N60_2 :=__common__( if(((real)iv_addr_non_phn_src_ct < 2.5), N60_3, -0.0027079117));

	N60_1 :=__common__( if(((real)iv_addr_non_phn_src_ct > NULL), N60_2, 0.0019392177));

	N61_8 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '5 Cell', '7 PCS', '8 Pay_Phone']) => 0.0091375117,
				 (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid', '6 Pager'])                  => 0.054820191,
																											0.0091375117));

	N61_7 :=__common__( if(((real)iv_age_at_high_issue < 10.5), 0.0078574112, -0.0029306173));

	N61_6 :=__common__( if(((real)iv_age_at_high_issue > NULL), N61_7, -0.00095358146));

	N61_5 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '4 Other']) => -0.0074318083,
				 (iv_pb_profile in ['0 No Purch Data', '3 Retail Shopper'])              => -0.00022500429,
																							-0.0074318083));

	N61_4 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => N61_6,
				 ((real)iv_inq_collection_count12 < 0.5)   => N61_5,
															  N61_6));

	N61_3 :=__common__( map(((real)iv_ms001_ssns_per_adl <= NULL) => 0.015912073,
				 ((real)iv_ms001_ssns_per_adl < 3.5)   => N61_4,
														  0.015912073));

	N61_2 :=__common__( if(((integer)iv_attr_arrests_recency < 2), N61_3, N61_8));

	N61_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N61_2, 0.00025624678));

	N62_6 :=__common__( map(((real)nf_fp_srchcountwk <= NULL) => 0.0081924233,
				 ((real)nf_fp_srchcountwk < 0.5)   => -0.0019703901,
													  0.0081924233));

	N62_5 :=__common__( map(((real)iv_attr_felonies_recency <= NULL) => 0.011176195,
				 ((integer)iv_attr_felonies_recency < 2)  => N62_6,
															 0.011176195));

	N62_4 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6']) => N62_5,
				 (nf_fp_assocrisktype in ['7', '8', '9'])                => 0.007085477,
																			N62_5));

	N62_3 :=__common__( if(((real)iv_attr_purchase_recency < 0.5), N62_4, -0.0071724382));

	N62_2 :=__common__( if(((real)iv_attr_purchase_recency > NULL), N62_3, -0.005172979));

	N62_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N62_2,
				 (nf_fp_idverrisktype in ['7', '9'])                          => 0.024569916,
																				 N62_2));

	N63_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-1', '3-2']) => 0.0070550841,
				 (iv_criminal_x_felony in ['1-1', '2-1', '3-0', '3-3'])               => 0.027473257,
																						 0.0070550841));

	N63_7 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '4-1', '4-2', '4-3', '5-1']) => -0.0023405416,
				 (iv_gong_did_fname_x_lname_ct in ['0-1', '3-3', '5-2', '5-3'])                                                                       => 0.073670599,
																																						 -0.0023405416));

	N63_6 :=__common__( if(((real)c_many_cars < 92.5), 0.0051920001, N63_7));

	N63_5 :=__common__( if(trim(C_MANY_CARS) != '', N63_6, 0.0056639321));

	N63_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => N63_5,
				 (iv_liens_unrel_x_rel in ['1-2', '3-0'])                                                         => 0.013540753,
																													 N63_5));

	N63_3 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0028899047,
				 (nf_fp_corrrisktype in ['7', '8', '9'])                => N63_4,
																		   -0.0028899047));

	N63_2 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo < 2.5), N63_3, N63_8));

	N63_1 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo > NULL), N63_2, 0.0032413848));

	N64_7 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '003', '005', '008', '100', '102', '103', '104', '105', '106', '107', '108', '109', '110', '112']) => 0.013199878,
				 (iv_phnpop_x_nap_summary in ['000', '101', '111'])                                                                                     => 0.076224381,
																																						   0.013199878));

	N64_6 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '5', '8', '9']) => 0.0036342498,
				 (nf_fp_sourcerisktype in ['6', '7'])                          => N64_7,
																				  0.0036342498));

	N64_5 :=__common__( map(((real)nf_rel_felony_count <= NULL) => 0.0032346969,
				 ((real)nf_rel_felony_count < 1.5)   => -0.0038552989,
														0.0032346969));

	N64_4 :=__common__( map(((real)nf_fp_srchphonesrchcountmo <= NULL) => 0.0070969315,
				 ((real)nf_fp_srchphonesrchcountmo < 0.5)   => N64_5,
															   0.0070969315));

	N64_3 :=__common__( map(((real)iv_ag001_age <= NULL) => N64_4,
				 ((real)iv_ag001_age < 22.5)  => 0.0069721241,
												 N64_4));

	N64_2 :=__common__( if(((real)iv_eviction_count < 1.5), N64_3, N64_6));

	N64_1 :=__common__( if(((real)iv_eviction_count > NULL), N64_2, -0.0046080299));

	N65_7 :=__common__( map((iv_nas_summary in [0, 1, 2, 3, 6, 7, 8, 9, 10, 12]) => 0.0079828043,
				 (iv_nas_summary in [4, 11])                                                 => 0.2068606,
																									 0.0079828043));

	N65_6 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '2 Weekly', '5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => 0.001641428,
				 (iv_pb_order_freq in ['0 No Purch Data', '3 Monthly', '4 Semi-monthly'])                                       => N65_7,
																																   0.001641428));

	N65_5 :=__common__( map(((real)nf_fp_prevaddrageoldest <= NULL) => -0.0003709937,
				 ((real)nf_fp_prevaddrageoldest < 46.5)  => N65_6,
															-0.0003709937));

	N65_4 :=__common__( map(((real)iv_attr_bankruptcy_recency <= NULL) => -0.01187872,
				 ((integer)iv_attr_bankruptcy_recency < 9)  => 0.00054422967,
															   -0.01187872));

	N65_3 :=__common__( map(((real)iv_inq_banking_count12 <= NULL) => -0.012243852,
				 ((real)iv_inq_banking_count12 < 0.5)   => N65_4,
														   -0.012243852));

	N65_2 :=__common__( if(((real)iv_inq_other_recency < 0.5), N65_3, N65_5));

	N65_1 :=__common__( if(((real)iv_inq_other_recency > NULL), N65_2, -0.00098119184));

	N66_7 :=__common__( map((nf_fp_idveraddressnotcurrent in ['2'])            => -0.0030085649,
				 (nf_fp_idveraddressnotcurrent in ['-1', '0', '1']) => 0.00867969,
																	   0.00867969));

	N66_6 :=__common__( if(((real)iv_inq_ssns_per_addr < 2.5), N66_7, 0.014141744));

	N66_5 :=__common__( if(((real)iv_inq_ssns_per_addr > NULL), N66_6, -0.0058931742));

	N66_4 :=__common__( map(((real)nf_fp_prevaddrmedianvalue <= NULL)    => -0.0026485039,
				 ((integer)nf_fp_prevaddrmedianvalue < 77646) => N66_5,
																 -0.0026485039));

	N66_3 :=__common__( if(((integer)iv_ssn_score < 95), 0.015727466, N66_4));

	N66_2 :=__common__( if(((real)iv_ssn_score > NULL), N66_3, -0.0031124212));

	N66_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => 0.0072623494,
				 ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => N66_2,
															  0.0072623494));

	N67_8 :=__common__( if(((real)c_famotf18_p < 19.1000003815), 0.0030231131, 0.015827032));

	N67_7 :=__common__( if(trim(C_FAMOTF18_P) != '', N67_8, 0.0022765145));

	N67_6 :=__common__( map(((real)nf_fp_corrssnnamecount <= NULL) => 0.0021642541,
				 ((real)nf_fp_corrssnnamecount < 4.5)   => 0.013510539,
														   0.0021642541));

	N67_5 :=__common__( map(((real)iv_dl001_unrel_lien60_count <= NULL) => 0.010832929,
				 ((real)iv_dl001_unrel_lien60_count < 3.5)   => -0.0018747681,
																0.010832929));

	N67_4 :=__common__( map((iv_input_dob_match_level in ['3', '4', '6', '7', '8']) => N67_5,
				 (iv_input_dob_match_level in ['0', '1', '2', '5'])      => 0.014945013,
																			N67_5));

	N67_3 :=__common__( map(((real)iv_mos_since_impulse_first_seen <= NULL) => N67_6,
				 ((real)iv_mos_since_impulse_first_seen < 7.5)   => N67_4,
																	N67_6));

	N67_2 :=__common__( if(((real)iv_attr_arrests_recency < 0.5), N67_3, N67_7));

	N67_1 :=__common__( if(((real)iv_attr_arrests_recency > NULL), N67_2, 0.00409607));

	N68_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-3']) => 0.0068807851,
				 (iv_criminal_x_felony in ['2-2', '3-2'])                                           => 0.038050542,
																									   0.0068807851));

	N68_7 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.012770233,
				 ((real)c_oldhouse < 335.649993896) => 0.00068862135,
													   0.012770233));

	N68_6 :=__common__( map(((real)iv_inq_banking_count12 <= NULL) => -0.0063818435,
				 ((real)iv_inq_banking_count12 < 0.5)   => N68_7,
														   -0.0063818435));

	N68_5 :=__common__( map(trim(C_EASIQLIFE) = ''     => N68_6,
				 ((real)c_easiqlife < 88.5) => -0.0056425397,
											   N68_6));

	N68_4 :=__common__( if(((real)c_cpiall < 203.600006104), 0.0067527435, N68_5));

	N68_3 :=__common__( if(trim(C_CPIALL) != '', N68_4, 0.0075646316));

	N68_2 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount < 1.5), N68_3, N68_8));

	N68_1 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount > NULL), N68_2, 0.00083169656));

	N69_7 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['04', '11', '12', '13', '14']) => -0.0091779276,
				 (iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '03', '10']) => 0.011212428,
																					  0.011212428));

	N69_6 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N69_7,
				 (nf_fp_idverrisktype in ['8'])                                    => 0.099556035,
																					  N69_7));

	N69_5 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N69_6,
				 ((real)nf_fp_srchfraudsrchcount < 13.5)  => 0.0025019729,
															 N69_6));

	N69_4 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '4 Other']) => -0.0017087882,
				 (iv_pb_profile in ['0 No Purch Data', '3 Retail Shopper'])              => N69_5,
																							-0.0017087882));

	N69_3 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '6', '8']) => N69_4,
				 (nf_fp_idverrisktype in ['4', '5', '7', '9'])      => 0.022569147,
																	   N69_4));

	N69_2 :=__common__( if(((real)iv_mos_since_prv_addr_lseen < 4.5), N69_3, -0.0045632867));

	N69_1 :=__common__( if(((real)iv_mos_since_prv_addr_lseen > NULL), N69_2, -0.00097279426));

	N70_8 :=__common__( if(((real)c_ownocc_p < 84.3500061035), 0.0041578799, 0.021840533));

	N70_7 :=__common__( if(trim(C_OWNOCC_P) != '', N70_8, 0.0029683725));

	N70_6 :=__common__( if(((integer)iv_inp_addr_building_area < 895), -0.00058591586, 0.010632055));

	N70_5 :=__common__( if(((real)iv_inp_addr_building_area > NULL), N70_6, 0.013670355));

	N70_4 :=__common__( map(((real)iv_sr001_source_profile <= NULL)         => -0.0018890945,
				 ((real)iv_sr001_source_profile < 34.5499992371) => N70_5,
																	-0.0018890945));

	N70_3 :=__common__( if(((real)nf_rel_derog_summary < 5.5), N70_4, N70_7));

	N70_2 :=__common__( if(((real)nf_rel_derog_summary > NULL), N70_3, 0.0056157447));

	N70_1 :=__common__( map((iv_num_purch_x_num_sold_60 in ['0-2', '1-0', '1-1', '2-2'])        => -0.009923913,
				 (iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '1-2', '2-0', '2-1']) => N70_2,
																						N70_2));

	N71_7 :=__common__( map((iv_cvi in [0, 10, 40, 50]) => 0.0062013233,
				 (iv_cvi in [20, 30])             => 0.033414145,
														 0.0062013233));

	N71_6 :=__common__( map(((real)iv_non_derog_count <= NULL) => 0.0010214973,
				 ((real)iv_non_derog_count < 5.5)   => N71_7,
													   0.0010214973));

	N71_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '7'])                => N71_6,
				 (nf_fp_divrisktype in ['3', '4', '5', '6', '8', '9']) => 0.014164081,
																		  0.014164081));

	N71_4 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '6']) => N71_5,
				 (nf_fp_idverrisktype in ['5', '7', '8', '9'])      => 0.029318877,
																	   N71_5));

	N71_3 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.005095491,
				 ((integer)nf_average_rel_home_val < 171500) => 0.00032198554,
																-0.005095491));

	N71_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N71_3, N71_4));

	N71_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N71_2, 0.0019914565));

	N72_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '7'])      => 0.0057762593,
				 (nf_fp_srchcomponentrisktype in ['3', '5', '6', '8', '9']) => 0.01940401,
																			   0.0057762593));

	N72_5 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N72_6,
				 (iv_vs002_ssn_prior_dob in ['1']) => 0.050075355,
													  0.050075355));

	N72_4 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => 0.0018425609,
				 ((real)nf_fp_corrssnaddrcount < 0.5)   => 0.013076015,
														   0.0018425609));

	N72_3 :=__common__( if(((real)iv_va060_dist_add_in_bst < 0.5), -0.001661609, N72_4));

	N72_2 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N72_3, 0.012764537));

	N72_1 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5', '7', '9']) => N72_2,
				 (nf_fp_divrisktype in ['3', '4', '6', '8'])      => N72_5,
																	 N72_5));

	N73_8 :=__common__( map(((real)nf_fp_prevaddrageoldest <= NULL) => 0.0062551504,
				 ((real)nf_fp_prevaddrageoldest < 20.5)  => 0.016698833,
															0.0062551504));

	N73_7 :=__common__( if(((real)iv_age_at_low_issue < 10.5), N73_8, -0.0010510571));

	N73_6 :=__common__( if(((real)iv_age_at_low_issue > NULL), N73_7, -0.009949258));

	N73_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '7']) => -0.0028317629,
				 (nf_fp_divrisktype in ['8', '9'])                          => 0.044827063,
																			   -0.0028317629));

	N73_4 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.0099667452,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => 0.0048820792,
																				   0.0048820792));

	N73_3 :=__common__( map(((real)nf_average_rel_income <= NULL)    => N73_5,
				 ((integer)nf_average_rel_income < 49500) => N73_4,
															 N73_5));

	N73_2 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount < 1.5), N73_3, N73_6));

	N73_1 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount > NULL), N73_2, 0.0014287788));

	N74_6 :=__common__( map(((real)iv_dc001_mos_since_crim_ls <= NULL) => 0.0026277056,
				 ((real)iv_dc001_mos_since_crim_ls < 20.5)  => 0.015532139,
															   0.0026277056));

	N74_5 :=__common__( map((iv_input_dob_match_level in ['2', '3', '4', '7', '8']) => 0.003028218,
				 (iv_input_dob_match_level in ['0', '1', '5', '6'])      => 0.022605992,
																			0.003028218));

	N74_4 :=__common__( map(((real)nf_average_rel_income <= NULL)    => -0.0017777144,
				 ((integer)nf_average_rel_income < 49500) => N74_5,
															 -0.0017777144));

	N74_3 :=__common__( if(((real)iv_inq_auto_recency < 4.5), N74_4, -0.0061507989));

	N74_2 :=__common__( if(((real)iv_inq_auto_recency > NULL), N74_3, -0.0044787152));

	N74_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '3-0', '3-1'])               => N74_2,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-1', '2-2', '3-2', '3-3']) => N74_6,
																						 N74_2));

	N75_7 :=__common__( map(((real)iv_dob_src_ct <= NULL) => 0.001708443,
				 ((real)iv_dob_src_ct < 3.5)   => 0.010428248,
												  0.001708443));

	N75_6 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-1', '3-3']) => -0.00096723425,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '2-1', '3-0'])                                                  => 0.021425111,
																															 -0.00096723425));

	N75_5 :=__common__( if(((real)nf_fp_prevaddrcrimeindex < 190.5), -0.0030238513, N75_6));

	N75_4 :=__common__( if(((real)nf_fp_prevaddrcrimeindex > NULL), N75_5, -0.00025854439));

	N75_3 :=__common__( if(((real)c_cpiall < 203.600006104), 0.0065183838, N75_4));

	N75_2 :=__common__( if(trim(C_CPIALL) != '', N75_3, -0.0045091643));

	N75_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '4', '5', '6']) => N75_2,
				 (nf_fp_idverrisktype in ['3', '7', '8', '9'])      => N75_7,
																	   N75_2));

	N76_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '2-3', '3-3']) => 0.004752374,
				 (iv_paw_dead_bus_x_active_phn in ['1-3', '3-0', '3-1', '3-2'])                                                         => 0.12124259,
																																		   0.004752374));

	N76_6 :=__common__( if(((real)iv_age_at_low_issue < 2.5), N76_7, -0.00043484335));

	N76_5 :=__common__( if(((real)iv_age_at_low_issue > NULL), N76_6, 0.0060715375));

	N76_4 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4'])      => -0.0036405057,
				 (nf_fp_srchvelocityrisktype in ['5', '6', '7', '8', '9']) => N76_5,
																			  N76_5));

	N76_3 :=__common__( if(((real)c_easiqlife < 66.5), -0.0056280522, N76_4));

	N76_2 :=__common__( if(trim(C_EASIQLIFE) != '', N76_3, -0.0010715352));

	N76_1 :=__common__( map((iv_nas_summary in [0, 3, 6, 7, 9, 10, 11, 12]) => N76_2,
				 (iv_nas_summary in [1, 2, 4, 8])                         => 0.016307781,
																						 N76_2));

	N77_8 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0028732699,
				 ((real)c_easiqlife < 85.5) => -0.0024522035,
											   0.0028732699));

	N77_7 :=__common__( map(((real)iv_attr_arrests_recency <= NULL) => 0.0089402439,
				 ((integer)iv_attr_arrests_recency < 2)  => N77_8,
															0.0089402439));

	N77_6 :=__common__( if(trim(C_EASIQLIFE) != '', N77_7, -0.0019321786));

	N77_5 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '10', '15', '20', '25', '30', '40']) => -0.0054190323,
				 (iv_prv_addr_mortgage_term in ['0', '5'])                                 => 0.060842451,
																							  -0.0054190323));

	N77_4 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-0', '2-3', '3-0'])                                    => N77_5,
				 (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '1-1', '1-3', '2-0', '2-1', '3-1', '3-3']) => N77_6,
																													  N77_5));

	N77_3 :=__common__( map(((real)iv_inq_auto_count12 <= NULL) => -0.008038293,
				 ((real)iv_inq_auto_count12 < 1.5)   => N77_4,
														-0.008038293));

	N77_2 :=__common__( if(((integer)iv_ssn_score < 95), 0.013197125, N77_3));

	N77_1 :=__common__( if(((real)iv_ssn_score > NULL), N77_2, 0.004366283));

	N78_8 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => 0.00019514137,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1'])                                                                => 0.008252378,
																																	0.00019514137));

	N78_7 :=__common__( map(((real)iv_inq_per_addr <= NULL) => 0.013464823,
				 ((real)iv_inq_per_addr < 5.5)   => N78_8,
													0.013464823));

	N78_6 :=__common__( map(((real)iv_mos_since_bst_addr_fseen <= NULL) => -0.0016246052,
				 ((real)iv_mos_since_bst_addr_fseen < 41.5)  => N78_7,
																-0.0016246052));

	N78_5 :=__common__( if(((real)c_ab_av_edu < 106.5), N78_6, -0.0037135637));

	N78_4 :=__common__( if(trim(C_AB_AV_EDU) != '', N78_5, 0.0038770419));

	N78_3 :=__common__( map(((real)iv_inq_banking_recency <= NULL) => -0.0033207253,
				 ((real)iv_inq_banking_recency < 0.5)   => N78_4,
														   -0.0033207253));

	N78_2 :=__common__( if(((real)nf_fp_srchcountwk < 0.5), N78_3, 0.0067661936));

	N78_1 :=__common__( if(((real)nf_fp_srchcountwk > NULL), N78_2, -0.006207726));

	N79_8 :=__common__( if(((real)iv_age_at_low_issue > NULL), 0.019903027, 0.10415683));

	N79_7 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => 0.0041187769,
				 ((real)nf_fp_corrphonelastnamecount < 0.5)   => N79_8,
																 0.0041187769));

	N79_6 :=__common__( if(((real)c_old_homes < 102.5), N79_7, 0.0019580946));

	N79_5 :=__common__( if(trim(C_OLD_HOMES) != '', N79_6, 0.021962425));

	N79_4 :=__common__( map(((real)nf_fp_prevaddrcartheftindex <= NULL) => N79_5,
				 ((real)nf_fp_prevaddrcartheftindex < 115.5) => 0.0006601417,
																N79_5));

	N79_3 :=__common__( map(((real)iv_impulse_annual_income <= NULL)    => 0.011096918,
				 ((integer)iv_impulse_annual_income < 22050) => -0.0014128766,
																0.011096918));

	N79_2 :=__common__( if(((real)iv_va060_dist_add_in_bst < 3.5), N79_3, N79_4));

	N79_1 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N79_2, -0.0012283087));

	N80_8 :=__common__( map(((real)iv_combined_age <= NULL) => -0.0054794569,
				 ((real)iv_combined_age < 50.5)  => 0.0064215037,
													-0.0054794569));

	N80_7 :=__common__( if(((real)iv_adls_per_addr_c6 < 4.5), -0.00034961974, 0.01339468));

	N80_6 :=__common__( if(((real)iv_adls_per_addr_c6 > NULL), N80_7, 0.0089645283));

	N80_5 :=__common__( map((iv_pb_profile in ['1 Offline Shopper', '2 Online Shopper', '4 Other']) => -0.0058885654,
				 (iv_pb_profile in ['0 No Purch Data', '3 Retail Shopper'])              => N80_6,
																							-0.0058885654));

	N80_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-0', '2-2', '3-1', '3-2']) => N80_5,
				 (iv_liens_unrel_x_rel in ['1-0', '2-1', '3-0'])                                           => N80_8,
																											  N80_5));

	N80_3 :=__common__( map((iv_vp100_phn_prob in ['2 Disconnected', '5 Cell', '7 PCS'])                                      => N80_4,
				 (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '4 Invalid', '6 Pager', '8 Pay_Phone']) => 0.014483374,
																													  N80_4));

	N80_2 :=__common__( if(((real)iv_inq_collection_count12 < 2.5), N80_3, 0.013778372));

	N80_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N80_2, -0.003333307));

	N81_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '4', '9'])                => 0.0033631362,
				 (nf_fp_srchcomponentrisktype in ['2', '3', '5', '6', '7', '8']) => 0.013552229,
																					0.013552229));

	N81_7 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2', 'NONE']) => -0.002060879,
				 (iv_best_match_address in ['ADD3'])                 => 0.0065382535,
																		-0.002060879));

	N81_6 :=__common__( if(((real)c_hval_80k_p < 8.94999980927), 0.001280115, 0.020992011));

	N81_5 :=__common__( if(trim(C_HVAL_80K_P) != '', N81_6, 0.007185585));

	N81_4 :=__common__( map(((real)nf_average_rel_income <= NULL)    => N81_7,
				 ((integer)nf_average_rel_income < 36500) => N81_5,
															 N81_7));

	N81_3 :=__common__( map(((real)iv_de001_eviction_recency <= NULL) => N81_8,
				 ((real)iv_de001_eviction_recency < 1.5)   => N81_4,
															  N81_8));

	N81_2 :=__common__( if(((real)iv_inq_auto_count12 < 1.5), N81_3, -0.0082263414));

	N81_1 :=__common__( if(((real)iv_inq_auto_count12 > NULL), N81_2, 0.0020967741));

	N82_6 :=__common__( map(((real)iv_dc001_mos_since_crim_ls <= NULL) => 0.0036634882,
				 ((real)iv_dc001_mos_since_crim_ls < 15.5)  => 0.016009432,
															   0.0036634882));

	N82_5 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.0069721104,
				 (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => N82_6,
																				   N82_6));

	N82_4 :=__common__( map((iv_vp050_phn_cmp_pcs in ['1']) => 0.0060630446,
				 (iv_vp050_phn_cmp_pcs in ['0']) => 0.060354671,
													0.0060630446));

	N82_3 :=__common__( if(((real)c_asian_lang < 183.5), -0.0021404271, N82_4));

	N82_2 :=__common__( if(trim(C_ASIAN_LANG) != '', N82_3, -0.0051588839));

	N82_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '3-0', '3-1'])                             => N82_2,
				 (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-2', '3-3']) => N82_5,
																								N82_2));

	N83_6 :=__common__( if(((real)c_easiqlife < 88.5), -0.005075249, 0.0013265091));

	N83_5 :=__common__( if(trim(C_EASIQLIFE) != '', N83_6, -0.0027196396));

	N83_4 :=__common__( map(((real)iv_iq001_inq_count12 <= NULL) => 0.0098632487,
				 ((real)iv_iq001_inq_count12 < 15.5)  => N83_5,
														 0.0098632487));

	N83_3 :=__common__( map(((real)nf_fp_curraddrcartheftindex <= NULL) => 0.0064145377,
				 ((real)nf_fp_curraddrcartheftindex < 167.5) => N83_4,
																0.0064145377));

	N83_2 :=__common__( map((iv_ed001_college_ind_50 in ['1']) => -0.0044269921,
				 (iv_ed001_college_ind_50 in ['0']) => N83_3,
													   -0.0044269921));

	N83_1 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N83_2,
				 (iv_vs002_ssn_prior_dob in ['1']) => 0.026252606,
													  0.026252606));

	N84_9 :=__common__( map(((real)iv_eviction_count <= NULL) => 0.020326115,
				 ((real)iv_eviction_count < 2.5)   => 0.0034070562,
													  0.020326115));

	N84_8 :=__common__( map((iv_phnpop_x_nap_summary in ['100', '101', '104', '105', '107', '109', '112'])                             => -0.0010761774,
				 (iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '102', '103', '106', '108', '110', '111']) => 0.0067618561,
																															   0.0067618561));

	N84_7 :=__common__( map((nf_fp_corrrisktype in ['2', '3'])                          => -0.010921377,
				 (nf_fp_corrrisktype in ['1', '4', '5', '6', '7', '8', '9']) => N84_8,
																				N84_8));

	N84_6 :=__common__( if(((real)c_cpiall < 201.449996948), 0.012484741, N84_7));

	N84_5 :=__common__( if(trim(C_CPIALL) != '', N84_6, 0.0012372296));

	N84_4 :=__common__( if(((real)iv_age_at_low_issue < 2.5), N84_5, -0.0035069991));

	N84_3 :=__common__( if(((real)iv_age_at_low_issue > NULL), N84_4, 0.0054778799));

	N84_2 :=__common__( if(((real)nf_fp_varmsrcssncount < 1.5), N84_3, N84_9));

	N84_1 :=__common__( if(((real)nf_fp_varmsrcssncount > NULL), N84_2, -0.0060566669));

	N85_8 :=__common__( map(((real)nf_rel_count <= NULL) => 0.012197118,
				 ((real)nf_rel_count < 25.5)  => 0.0027414831,
												 0.012197118));

	N85_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => 0.002089914,
				 (nf_fp_divrisktype in ['8'])                                    => 0.091698125,
																					0.002089914));

	N85_6 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '03', '10', '12', '13', '14']) => -0.0030228269,
				 (iv_prv_own_prop_x_addr_naprop in ['01', '02', '04', '11'])             => 0.0096206665,
																							-0.0030228269));

	N85_5 :=__common__( map(((real)iv_va060_dist_add_in_bst <= NULL) => N85_6,
				 ((real)iv_va060_dist_add_in_bst < 0.5)   => -0.005428136,
															 N85_6));

	N85_4 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => N85_5,
				 (iv_dl_val_flag in ['Empty'])     => N85_7,
													  N85_7));

	N85_3 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N85_4, 0.020733185));

	N85_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N85_3, N85_8));

	N85_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N85_2, 0.0021555076));

	N86_9 :=__common__( if(((real)c_hh7p_p < 0.350000023842), 0.014355211, -0.001592012));

	N86_8 :=__common__( if(trim(C_HH7P_P) != '', N86_9, 0.0090504037));

	N86_7 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'C', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => N86_8,
				 (iv_in001_college_income in ['B', 'E'])                                          => 0.037352427,
																									 N86_8));

	N86_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.0062178485,
				 (iv_gong_did_fname_x_lname_ct in ['1-2', '2-2', '2-3', '3-1', '3-2'])                                                         => 0.041586864,
																																				  0.0062178485));

	N86_5 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => 0.0001246893,
				 ((real)iv_ssn_non_phn_src_ct < 2.5)   => N86_6,
														  0.0001246893));

	N86_4 :=__common__( if(trim(C_FAMOTF18_P) != '', N86_5, 0.00076850058));

	N86_3 :=__common__( map(((real)nf_fp_srchssnsrchcountmo <= NULL) => N86_7,
				 ((real)nf_fp_srchssnsrchcountmo < 1.5)   => N86_4,
															 N86_7));

	N86_2 :=__common__( if(((real)iv_inq_auto_recency < 0.5), N86_3, -0.0042378149));

	N86_1 :=__common__( if(((real)iv_inq_auto_recency > NULL), N86_2, 0.003570935));

	N87_8 :=__common__( if(((real)c_old_homes < 109.5), 0.022230336, 0.0043300917));

	N87_7 :=__common__( if(trim(C_OLD_HOMES) != '', N87_8, 0.074964578));

	N87_6 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '1-1', '1-2', '2-0', '2-2', '3-1', '3-2']) => -0.0065558184,
				 (iv_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '2-1', '3-0'])               => N87_7,
																								-0.0065558184));

	N87_5 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '2-1', '2-2', '3-2']) => 8.8781564e-005,
				 (iv_liens_unrel_x_rel in ['0-2', '1-0', '1-2', '2-0', '3-0', '3-1']) => 0.005663513,
																						 0.005663513));

	N87_4 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0074313394,
				 ((real)iv_ag001_age < 55.5)  => N87_5,
												 -0.0074313394));

	N87_3 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '8']) => -0.0038899309,
				 (nf_fp_srchvelocityrisktype in ['5', '6', '7', '9'])      => N87_4,
																			  -0.0038899309));

	N87_2 :=__common__( if(((real)nf_fp_prevaddrcrimeindex < 190.5), N87_3, N87_6));

	N87_1 :=__common__( if(((real)nf_fp_prevaddrcrimeindex > NULL), N87_2, -0.0022742032));

	N88_9 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => 0.0052478115,
				 ((real)iv_ssn_non_phn_src_ct < 4.5)   => 0.016742375,
														  0.0052478115));

	N88_8 :=__common__( if(trim(C_FAMMAR18_P) != '', N88_9, 0.019598984));

	N88_7 :=__common__( map((nf_fp_assocrisktype in ['2', '3'])                          => -0.0046383671,
				 (nf_fp_assocrisktype in ['1', '4', '5', '6', '7', '8', '9']) => N88_8,
																				 N88_8));

	N88_6 :=__common__( map((nf_fp_componentcharrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => 0.0076225264,
				 (nf_fp_componentcharrisktype in ['7'])                                    => 0.043440249,
																							  0.0076225264));

	N88_5 :=__common__( if(((real)iv_inp_addr_assessed_total_val < 66095.5), 0.00058402334, N88_6));

	N88_4 :=__common__( if(((real)iv_inp_addr_assessed_total_val > NULL), N88_5, 0.01885314));

	N88_3 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-1', '2-0', '2-3', '3-0', '3-3']) => -0.0020250359,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-3', '2-1', '3-1'])                      => N88_4,
																											   N88_4));

	N88_2 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo < 2.5), N88_3, N88_7));

	N88_1 :=__common__( if(((real)nf_fp_srchaddrsrchcountmo > NULL), N88_2, 0.0014323625));

	N89_5 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'E', 'F', 'H']) => 0.0066553139,
				 (iv_in001_college_income in ['D', 'G', 'I', 'J', 'K'])            => 0.034096198,
																					  0.0066553139));

	N89_4 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '0', '10', '15', '25', '30', '40']) => -0.0010699057,
				 (iv_inp_addr_mortgage_term in ['20', '5'])                               => 0.067377343,
																							 -0.0010699057));

	N89_3 :=__common__( map(((real)iv_inq_communications_recency <= NULL) => 0.010489605,
				 ((real)iv_inq_communications_recency < 0.5)   => N89_4,
																  0.010489605));

	N89_2 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5', '7', '9']) => -0.0010465594,
				 (nf_fp_divrisktype in ['3', '4', '6', '8'])      => N89_3,
																	 -0.0010465594));

	N89_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-1']) => N89_2,
				 (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-2', '3-3']) => N89_5,
																				  N89_5));

	N90_8 :=__common__( map((iv_input_dob_match_level in ['2', '4', '6', '8'])      => 0.0037858849,
				 (iv_input_dob_match_level in ['0', '1', '3', '5', '7']) => 0.028499534,
																			0.0037858849));

	N90_7 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-1', '1-3', '2-0', '2-1', '2-3', '3-1', '3-3']) => 0.0063388813,
				 (iv_nap_phn_ver_x_inf_phn_ver in ['1-0', '3-0'])                                                                => 0.18767085,
																																	0.0063388813));

	N90_6 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => -0.00077927807,
				 (nf_fp_corrrisktype in ['9'])                                    => N90_7,
																					 -0.00077927807));

	N90_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N90_6,
				 (nf_fp_divrisktype in ['8'])                                    => 0.11686919,
																					N90_6));

	N90_4 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr < 0.5), -0.0052485064, N90_5));

	N90_3 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N90_4, -0.0010582914));

	N90_2 :=__common__( if(((real)iv_inq_ssns_per_addr < 2.5), N90_3, N90_8));

	N90_1 :=__common__( if(((real)iv_inq_ssns_per_addr > NULL), N90_2, -0.00071970258));

	N91_7 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '101', '102', '103', '104', '105', '106', '107', '109', '110', '112']) => -0.0032449686,
				 (iv_phnpop_x_nap_summary in ['003', '100', '108', '111'])                                                                       => 0.016906604,
																																					-0.0032449686));

	N91_6 :=__common__( map((iv_ed001_college_ind_36 in ['1']) => 0.0012835292,
				 (iv_ed001_college_ind_36 in ['0']) => N91_7,
													   0.0012835292));

	N91_5 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '5 Cell', '6 Pager', '7 PCS']) => -0.0013144882,
				 (iv_vp100_phn_prob in ['4 Invalid', '8 Pay_Phone'])                                                        => 0.030543438,
																															   -0.0013144882));

	N91_4 :=__common__( map(((real)nf_fp_srchphonesrchcountmo <= NULL) => 0.0086875379,
				 ((real)nf_fp_srchphonesrchcountmo < 1.5)   => N91_5,
															   0.0086875379));

	N91_3 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5', '7', '9']) => N91_4,
				 (nf_fp_divrisktype in ['3', '4', '6', '8'])      => N91_6,
																	 N91_4));

	N91_2 :=__common__( if(((real)iv_inq_auto_count12 < 1.5), N91_3, -0.0084046969));

	N91_1 :=__common__( if(((real)iv_inq_auto_count12 > NULL), N91_2, -0.0019107548));

	N92_9 :=__common__( map(trim(C_EXP_PROD) = ''      => -0.0072216996,
				 ((real)c_exp_prod < 157.5) => 0.0034940171,
											   -0.0072216996));

	N92_8 :=__common__( if(((real)c_blue_col < 13.1499996185), -0.0026904652, N92_9));

	N92_7 :=__common__( if(trim(C_BLUE_COL) != '', N92_8, 0.0027108005));

	N92_6 :=__common__( if(((real)iv_inq_adls_per_phone < 1.5), N92_7, 0.012307124));

	N92_5 :=__common__( if(((real)iv_inq_adls_per_phone > NULL), N92_6, 0.0020974452));

	N92_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0038661071,
				 ((real)iv_inq_auto_recency < 0.5)   => N92_5,
														-0.0038661071));

	N92_3 :=__common__( map(((real)iv_dg001_derog_count <= NULL) => 0.012452534,
				 ((real)iv_dg001_derog_count < 13.5)  => N92_4,
														 0.012452534));

	N92_2 :=__common__( if(((real)iv_inq_collection_count12 < 2.5), N92_3, 0.013972154));

	N92_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N92_2, 0.011000405));

	N93_6 :=__common__( map((iv_input_dob_match_level in ['2', '4', '6', '8'])      => 0.005912122,
				 (iv_input_dob_match_level in ['0', '1', '3', '5', '7']) => 0.039834302,
																			0.039834302));

	N93_5 :=__common__( map((iv_nas_summary in [0, 1, 2, 3, 4, 6, 7, 9, 10, 11, 12]) => N93_6,
				 (iv_nas_summary in [8])                                                             => 0.046583466,
																										   N93_6));

	N93_4 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '02', '04', '10', '13', '14']) => -0.0011798952,
				 (iv_prv_own_prop_x_addr_naprop in ['01', '03', '11', '12'])             => N93_5,
																							-0.0011798952));

	N93_3 :=__common__( if(((real)iv_va060_dist_add_in_bst < 34.5), N93_4, 0.013502332));

	N93_2 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N93_3, 0.0020285535));

	N93_1 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0013976311,
				 (nf_fp_assocrisktype in ['7', '8', '9'])                => N93_2,
																			N93_2));

	N94_8 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1']) => -0.004709392,
				 (iv_paw_dead_bus_x_active_phn in ['3-2', '3-3'])                                                                                     => 0.15352159,
																																						 -0.004709392));

	N94_7 :=__common__( map(((real)nf_fp_srchaddrsrchcountmo <= NULL) => 0.0082870105,
				 ((real)nf_fp_srchaddrsrchcountmo < 2.5)   => N94_8,
															  0.0082870105));

	N94_6 :=__common__( if(((real)c_child < 15.25), -0.011080382, 0.0011036286));

	N94_5 :=__common__( if(trim(C_CHILD) != '', N94_6, 0.00023831761));

	N94_4 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '5 Cell', '7 PCS'])              => N94_5,
				 (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid', '6 Pager', '8 Pay_Phone']) => 0.016901903,
																										  N94_5));

	N94_3 :=__common__( map(((real)iv_dg001_derog_count <= NULL) => 0.01346582,
				 ((real)iv_dg001_derog_count < 11.5)  => N94_4,
														 0.01346582));

	N94_2 :=__common__( if(((real)nf_fp_corrphonelastnamecount < 0.5), N94_3, N94_7));

	N94_1 :=__common__( if(((real)nf_fp_corrphonelastnamecount > NULL), N94_2, -0.00061685916));

	N95_8 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '4', '5', '7', '9']) => 0.002537106,
				 (nf_fp_srchvelocityrisktype in ['3', '6', '8'])                => 0.025395879,
																				   0.002537106));

	N95_7 :=__common__( map((iv_input_dob_match_level in ['0', '2', '3', '4', '5', '7', '8']) => N95_8,
				 (iv_input_dob_match_level in ['1', '6'])                          => 0.11798917,
																					  N95_8));

	N95_6 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.00057948588,
				 ((real)c_easiqlife < 88.5) => -0.0043351822,
											   0.00057948588));

	N95_5 :=__common__( map(trim(C_TRAILER) = ''      => -0.0042898373,
				 ((real)c_trailer < 149.5) => 0.0094713432,
											  -0.0042898373));

	N95_4 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => N95_6,
				 ((real)iv_ssn_non_phn_src_ct < 2.5)   => N95_5,
														  N95_6));

	N95_3 :=__common__( if(trim(C_EASIQLIFE) != '', N95_4, -0.0050404092));

	N95_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 3.5), N95_3, N95_7));

	N95_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N95_2, -0.00040418793));

	N96_9 :=__common__( if(((real)iv_hist_addr_match < 4.5), -0.0051081403, 0.005214887));

	N96_8 :=__common__( if(((real)iv_hist_addr_match > NULL), N96_9, -0.0073766021));

	N96_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5'])                => N96_8,
				 (nf_fp_divrisktype in ['3', '4', '6', '7', '8', '9']) => 0.0051490085,
																		  N96_8));

	N96_6 :=__common__( if(((real)iv_inq_auto_recency < 4.5), 0.0034542927, -0.0037626361));

	N96_5 :=__common__( if(((real)iv_inq_auto_recency > NULL), N96_6, -0.0028230688));

	N96_4 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '7', '8']) => N96_5,
				 (nf_fp_divrisktype in ['6', '9'])                          => 0.02745518,
																			   N96_5));

	N96_3 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N96_4,
				 (iv_vs002_ssn_prior_dob in ['1']) => 0.032016757,
													  0.032016757));

	N96_2 :=__common__( if(((real)c_hval_300k_p < 0.850000023842), N96_3, N96_7));

	N96_1 :=__common__( if(trim(C_HVAL_300K_P) != '', N96_2, 0.0031757964));

	N97_10 :=__common__( map(((real)iv_dg001_derog_count <= NULL) => 0.011150223,
				  ((real)iv_dg001_derog_count < 10.5)  => -0.0022214587,
														  0.011150223));

	N97_9 :=__common__( if(((real)c_bargains < 139.5), 0.013254825, 0.0015055852));

	N97_8 :=__common__( if(trim(C_BARGAINS) != '', N97_9, 0.0025981609));

	N97_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '7', '8', '9']) => 8.0212242e-005,
				 (nf_fp_divrisktype in ['6'])                                    => 0.056580831,
																					8.0212242e-005));

	N97_6 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), 0.0040427402, N97_7));

	N97_5 :=__common__( map((nf_fp_idveraddressnotcurrent in ['-1', '2']) => N97_6,
				 (nf_fp_idveraddressnotcurrent in ['0', '1'])  => N97_8,
																  N97_8));

	N97_4 :=__common__( if(((real)iv_age_at_low_issue < 2.5), N97_5, N97_10));

	N97_3 :=__common__( if(((real)iv_age_at_low_issue > NULL), N97_4, 0.010469387));

	N97_2 :=__common__( if(((real)iv_inq_highriskcredit_recency < 0.5), -0.0038494326, N97_3));

	N97_1 :=__common__( if(((real)iv_inq_highriskcredit_recency > NULL), N97_2, 0.0078022911));

	N98_9 :=__common__( map(((real)iv_mos_src_bureau_ssn_fseen <= NULL) => -0.0051094178,
				 ((real)iv_mos_src_bureau_ssn_fseen < 267.5) => 0.011780754,
																-0.0051094178));

	N98_8 :=__common__( map((iv_input_dob_match_level in ['2', '3', '4', '5', '6', '7', '8']) => N98_9,
				 (iv_input_dob_match_level in ['0', '1'])                          => 0.10569205,
																					  N98_9));

	N98_7 :=__common__( map(((real)iv_hist_addr_match <= NULL) => N98_8,
				 ((real)iv_hist_addr_match < 4.5)   => -0.0019224759,
													   N98_8));

	N98_6 :=__common__( if(((real)iv_ssns_per_sfd_addr_c6 < 2.5), N98_7, 0.0083438147));

	N98_5 :=__common__( if(((real)iv_ssns_per_sfd_addr_c6 > NULL), N98_6, -0.028337434));

	N98_4 :=__common__( if(((real)c_robbery < 165.5), N98_5, 0.0054703791));

	N98_3 :=__common__( if(trim(C_ROBBERY) != '', N98_4, 0.0047562348));

	N98_2 :=__common__( if(((real)iv_mos_since_prv_addr_lseen < 8.5), N98_3, -0.0049829203));

	N98_1 :=__common__( if(((real)iv_mos_since_prv_addr_lseen > NULL), N98_2, -0.0068639253));

	N99_7 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-1', '1-2', '2-0', '3-1', '3-2']) => 0.0037669961,
				 (iv_liens_unrel_x_rel in ['0-1', '2-1', '2-2', '3-0'])                             => 0.062726235,
																									   0.0037669961));

	N99_6 :=__common__( map(trim(C_EASIQLIFE) = ''      => 0.020083422,
				 ((real)c_easiqlife < 135.5) => N99_7,
												0.020083422));

	N99_5 :=__common__( map((iv_vp091_phnzip_mismatch in ['0']) => N99_6,
				 (iv_vp091_phnzip_mismatch in ['1']) => 0.047538457,
														0.047538457));

	N99_4 :=__common__( if(trim(C_FAMMAR_P) != '', N99_5, 0.020126425));

	N99_3 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen < 16.5), -0.0049715452, N99_4));

	N99_2 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen > NULL), N99_3, -0.0079710491));

	N99_1 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.00040830229,
				 ((real)iv_ag001_age < 22.5)  => N99_2,
												 -0.00040830229));

	N100_8 :=__common__( map(trim(C_POP_45_54_P) = ''              => 0.017530513,
				  ((real)c_pop_45_54_p < 16.0499992371) => 0.0035332623,
														   0.017530513));

	N100_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6']) => N100_8,
				  (nf_fp_srchcomponentrisktype in ['7', '8', '9'])                => 0.025873786,
																					 N100_8));

	N100_6 :=__common__( map(((real)nf_fp_corrssnnamecount <= NULL) => 0.0022543524,
				  ((real)nf_fp_corrssnnamecount < 4.5)   => N100_7,
															0.0022543524));

	N100_5 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N100_6,
				  ((real)nf_fp_srchfraudsrchcount < 4.5)   => 0.0003671249,
															  N100_6));

	N100_4 :=__common__( if(((real)c_easiqlife < 67.5), -0.0041820781, N100_5));

	N100_3 :=__common__( if(trim(C_EASIQLIFE) != '', N100_4, 0.010756962));

	N100_2 :=__common__( if(((real)iv_inq_auto_recency < 0.5), N100_3, -0.0042655279));

	N100_1 :=__common__( if(((real)iv_inq_auto_recency > NULL), N100_2, -0.0012361273));

	N101_8 :=__common__( map(((real)iv_src_voter_adl_count <= NULL) => -0.0059513978,
				  ((real)iv_src_voter_adl_count < 2.5)   => 0.0062809016,
															-0.0059513978));

	N101_7 :=__common__( map((iv_vs100_ssn_problem in ['0', '2']) => 0.0082380608,
				  (iv_vs100_ssn_problem in ['1'])      => 0.080230912,
														  0.0082380608));

	N101_6 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '6'])                => N101_7,
				  (nf_fp_idverrisktype in ['3', '4', '5', '7', '8', '9']) => 0.037120848,
																			 0.037120848));

	N101_5 :=__common__( map(((real)iv_pl001_m_snc_in_addr_fs <= NULL) => 0.001951216,
				  ((real)iv_pl001_m_snc_in_addr_fs < 4.5)   => N101_6,
															   0.001951216));

	N101_4 :=__common__( if(((real)c_famotf18_p < 31.25), -0.0019536972, N101_5));

	N101_3 :=__common__( if(trim(C_FAMOTF18_P) != '', N101_4, 0.0020119569));

	N101_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N101_3, N101_8));

	N101_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N101_2, 0.0004705362));

	N102_7 :=__common__( if(((real)iv_va060_dist_add_in_bst < 36.5), 0.0034512867, 0.014289299));

	N102_6 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N102_7, 0.010688513));

	N102_5 :=__common__( map(((real)nf_fp_assocsuspicousidcount <= NULL) => N102_6,
				  ((real)nf_fp_assocsuspicousidcount < 4.5)   => -2.8642985e-005,
																 N102_6));

	N102_4 :=__common__( map((iv_nas_summary in [3, 4, 7, 8, 9, 10, 11, 12]) => N102_5,
				  (iv_nas_summary in [0, 1, 2, 6])                         => 0.041126943,
																						  N102_5));

	N102_3 :=__common__( if(((real)c_fammar_p < 30.8499984741), 0.010456149, -0.0027366385));

	N102_2 :=__common__( if(trim(C_FAMMAR_P) != '', N102_3, 0.0064674955));

	N102_1 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '6 Recent Activity', '7 Other']) => N102_2,
				  (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog'])                         => N102_4,
																									N102_2));

	N103_9 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0', '3-3']) => 0.010738718,
				  (iv_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2'])               => 0.052861505,
																						  0.010738718));

	N103_8 :=__common__( map((iv_in001_wealth_index in ['1', '2', '3', '4', '5']) => 0.0096097241,
				  (iv_in001_wealth_index in ['6'])                     => 0.15823954,
																		  0.0096097241));

	N103_7 :=__common__( map(trim(C_CPIALL) = ''              => 0.0012031918,
				  ((real)c_cpiall < 203.600006104) => N103_8,
													  0.0012031918));

	N103_6 :=__common__( if(((real)iv_age_at_low_issue < 9.5), N103_7, -0.003207));

	N103_5 :=__common__( if(((real)iv_age_at_low_issue > NULL), N103_6, 0.0054571696));

	N103_4 :=__common__( if(((real)iv_inq_auto_recency < 4.5), N103_5, -0.0045050092));

	N103_3 :=__common__( if(((real)iv_inq_auto_recency > NULL), N103_4, -0.0053411318));

	N103_2 :=__common__( if(((real)c_newhouse < 114.550003052), N103_3, N103_9));

	N103_1 :=__common__( if(trim(C_NEWHOUSE) != '', N103_2, 0.010668725));

	N104_9 :=__common__( if(((real)iv_phones_per_sfd_addr < 1.5), -0.0014868798, 0.010981092));

	N104_8 :=__common__( if(((real)iv_phones_per_sfd_addr > NULL), N104_9, -0.028172329));

	N104_7 :=__common__( if(((real)c_hval_100k_p < 22.5499992371), N104_8, 0.0056722624));

	N104_6 :=__common__( if(trim(C_HVAL_100K_P) != '', N104_7, -0.0028998467));

	N104_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-3']) => 0.010621539,
				  (iv_criminal_x_felony in ['2-1', '3-1', '3-2'])                             => 0.041555748,
																								 0.010621539));

	N104_4 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)   => -0.00040669461,
				  ((real)nf_fp_curraddrmedianincome < 40009.5) => N104_5,
																  -0.00040669461));

	N104_3 :=__common__( map((iv_input_dob_match_level in ['2', '3', '4', '5', '7', '8']) => N104_4,
				  (iv_input_dob_match_level in ['0', '1', '6'])                => 0.035638914,
																				  N104_4));

	N104_2 :=__common__( if(((real)iv_mos_since_bst_addr_fseen < 3.5), N104_3, N104_6));

	N104_1 :=__common__( if(((real)iv_mos_since_bst_addr_fseen > NULL), N104_2, -0.0020996066));

	N105_6 :=__common__( map(((real)iv_addrs_per_adl <= NULL) => 0.0068855526,
				  ((real)iv_addrs_per_adl < 10.5)  => -0.0027150249,
													  0.0068855526));

	N105_5 :=__common__( if(((real)iv_va060_dist_add_in_bst < 10.5), N105_6, 0.012519204));

	N105_4 :=__common__( if(((real)iv_va060_dist_add_in_bst > NULL), N105_5, 0.021298318));

	N105_3 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => -0.0013839511,
				  ((real)iv_ssn_non_phn_src_ct < 4.5)   => N105_4,
														   -0.0013839511));

	N105_2 :=__common__( map(((real)iv_dl001_unrel_lien60_count <= NULL) => 0.014466608,
				  ((real)iv_dl001_unrel_lien60_count < 3.5)   => N105_3,
																 0.014466608));

	N105_1 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '7'])      => -0.0024856337,
				  (nf_fp_assocrisktype in ['4', '5', '6', '8', '9']) => N105_2,
																		-0.0024856337));

	N106_6 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '101', '102', '103', '104', '105', '106', '108', '110', '111', '112']) => 0.0045350085,
				  (iv_phnpop_x_nap_summary in ['003', '107', '109'])                                                                                     => 0.20928562,
																																							0.0045350085));

	N106_5 :=__common__( if(((real)c_inc_50k_p < 8.64999961853), 0.016907226, 0.0017040948));

	N106_4 :=__common__( if(trim(C_INC_50K_P) != '', N106_5, -0.0075843267));

	N106_3 :=__common__( map(((real)nf_fp_prevaddrcartheftindex <= NULL) => 0.00022344051,
				  ((real)nf_fp_prevaddrcartheftindex < 115.5) => -0.0046679835,
																 0.00022344051));

	N106_2 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => N106_3,
				  (iv_liens_unrel_x_rel in ['2-0', '3-0'])                                                         => N106_4,
																													  N106_4));

	N106_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => N106_6,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => N106_2,
															   N106_6));

	N107_6 :=__common__( map((iv_ams_college_tier in ['-1', '0', '1', '4', '5', '6']) => 0.011873731,
				  (iv_ams_college_tier in ['2', '3'])                      => 0.11259565,
																			  0.011873731));

	N107_5 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '2 - BK Dismissed', '3 - BK Other']) => -0.01222747,
				  (iv_db001_bankruptcy in ['0 - No BK'])                                             => N107_6,
																										-0.01222747));

	N107_4 :=__common__( if(((real)c_housingcpi < 186.399993896), N107_5, 0.00098309015));

	N107_3 :=__common__( if(trim(C_HOUSINGCPI) != '', N107_4, 0.00046396383));

	N107_2 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '7', '8', '9']) => N107_3,
				  (nf_fp_idrisktype in ['6'])                                    => 0.053858198,
																					0.053858198));

	N107_1 :=__common__( map((fp_segment in ['3 New DID', '7 Other'])                                                     => -0.0041105784,
				  (fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => N107_2,
																												  N107_2));

	N108_7 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2']) => 0.007827228,
				  (iv_best_match_address in ['ADD3', 'NONE']) => 0.023547511,
																 0.023547511));

	N108_6 :=__common__( map((iv_bst_addr_mortgage_term in ['0', '15', '20', '5'])         => -0.025438464,
				  (iv_bst_addr_mortgage_term in ['-1', '10', '25', '30', '40']) => N108_7,
																				   N108_7));

	N108_5 :=__common__( map(((real)iv_fname_non_phn_src_ct <= NULL) => 2.2745399e-005,
				  ((real)iv_fname_non_phn_src_ct < 6.5)   => N108_6,
															 2.2745399e-005));

	N108_4 :=__common__( map(((real)nf_fp_srchaddrsrchcountmo <= NULL) => 0.012467059,
				  ((real)nf_fp_srchaddrsrchcountmo < 1.5)   => N108_5,
															   0.012467059));

	N108_3 :=__common__( map(((real)iv_inq_auto_count12 <= NULL) => -0.009790284,
				  ((real)iv_inq_auto_count12 < 1.5)   => -0.00030185063,
														 -0.009790284));

	N108_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N108_3, N108_4));

	N108_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N108_2, 0.00139597));

	N109_8 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '8']) => 0.0062140828,
				  (nf_fp_corrrisktype in ['7', '9'])                          => 0.018970969,
																				 0.0062140828));

	N109_7 :=__common__( map((iv_prv_addr_ownership_lvl in ['Applicant', 'Family', 'No Ownership']) => 0.0014547076,
				  (iv_prv_addr_ownership_lvl in ['Occupant'])                            => N109_8,
																							0.0014547076));

	N109_6 :=__common__( if(((real)c_hval_200k_p < 2.34999990463), N109_7, -0.0011887575));

	N109_5 :=__common__( if(trim(C_HVAL_200K_P) != '', N109_6, 0.0031702651));

	N109_4 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.0074977094,
				  (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => N109_5,
																					N109_5));

	N109_3 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0046581418,
				  ((real)iv_inq_auto_recency < 0.5)   => N109_4,
														 -0.0046581418));

	N109_2 :=__common__( if(((real)iv_dl001_unrel_lien60_count < 3.5), N109_3, 0.0090714993));

	N109_1 :=__common__( if(((real)iv_dl001_unrel_lien60_count > NULL), N109_2, -0.0019259541));

	N110_8 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '10', '11', '14']) => 0.0041835789,
				  (iv_prv_own_prop_x_addr_naprop in ['02', '03', '04', '12', '13']) => 0.02876404,
																					   0.02876404));

	N110_7 :=__common__( map((nf_fp_varrisktype in ['-1', '7', '8'])                    => -0.01838851,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '9']) => -0.0036591746,
																				-0.0036591746));

	N110_6 :=__common__( map((nf_fp_corrrisktype in ['2', '3', '4', '5', '9']) => 0.00188828,
				  (nf_fp_corrrisktype in ['1', '6', '7', '8'])      => 0.013260758,
																	   0.00188828));

	N110_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5', '6', '7', '9']) => -0.00030892728,
				  (nf_fp_divrisktype in ['3', '4', '8'])                => N110_6,
																		   -0.00030892728));

	N110_4 :=__common__( if(((real)c_pop_75_84_p < 5.55000019073), N110_5, N110_7));

	N110_3 :=__common__( if(trim(C_POP_75_84_P) != '', N110_4, -0.0030685181));

	N110_2 :=__common__( if(((real)nf_fp_srchphonesrchcountmo < 1.5), N110_3, N110_8));

	N110_1 :=__common__( if(((real)nf_fp_srchphonesrchcountmo > NULL), N110_2, -0.003987323));

	N111_8 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['01', '02', '04', '12', '14']) => -0.00056843658,
				  (iv_inp_own_prop_x_addr_naprop in ['00', '03', '10', '11', '13']) => 0.0093637985,
																					   0.0093637985));

	N111_7 :=__common__( map((iv_input_dob_match_level in ['2', '3', '5', '6', '8']) => N111_8,
				  (iv_input_dob_match_level in ['0', '1', '4', '7'])      => 0.03235843,
																			 N111_8));

	N111_6 :=__common__( map(((real)iv_inq_auto_count12 <= NULL) => -0.012038354,
				  ((real)iv_inq_auto_count12 < 1.5)   => 0.0021223615,
														 -0.012038354));

	N111_5 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-0', '3-1']) => -0.0030726541,
				  (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '2-1', '3-3'])                                    => N111_6,
																													   -0.0030726541));

	N111_4 :=__common__( if(((real)c_asian_lang < 184.5), N111_5, 0.0073518119));

	N111_3 :=__common__( if(trim(C_ASIAN_LANG) != '', N111_4, 0.001745898));

	N111_2 :=__common__( if(((real)iv_mos_since_impulse_first_seen < 7.5), N111_3, N111_7));

	N111_1 :=__common__( if(((real)iv_mos_since_impulse_first_seen > NULL), N111_2, 0.0056995372));

	N112_8 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '6', '7']) => 0.0026992488,
				  (nf_fp_srchvelocityrisktype in ['8', '9'])                          => 0.01140187,
																						 0.0026992488));

	N112_7 :=__common__( if(((real)c_sfdu_p < 69.6499938965), -0.0061759993, 0.0048186245));

	N112_6 :=__common__( if(trim(C_SFDU_P) != '', N112_7, -0.0122222));

	N112_5 :=__common__( map((iv_ssn_miskey in ['0']) => N112_6,
				  (iv_ssn_miskey in ['1']) => 0.040632673,
											  0.040632673));

	N112_4 :=__common__( map(((real)nf_fp_curraddrcrimeindex <= NULL) => 0.010490797,
				  ((real)nf_fp_curraddrcrimeindex < 153.5) => N112_5,
															  0.010490797));

	N112_3 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.001999233,
				  ((real)iv_ag001_age < 23.5)  => N112_4,
												  -0.001999233));

	N112_2 :=__common__( if(((real)nf_rel_count < 30.5), N112_3, N112_8));

	N112_1 :=__common__( if(((real)nf_rel_count > NULL), N112_2, -0.00059489051));

	N113_8 :=__common__( map((iv_infutor_nap in ['12', '4', '9'])                 => -0.0064538229,
				  (iv_infutor_nap in ['0', '1', '10', '11', '6', '7']) => 0.0075157661,
																		  0.0075157661));

	N113_7 :=__common__( map(((real)iv_mos_src_bureau_ssn_fseen <= NULL) => -0.0070352729,
				  ((real)iv_mos_src_bureau_ssn_fseen < 272.5) => 0.018641594,
																 -0.0070352729));

	N113_6 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => -0.0023089681,
				  (nf_fp_corrrisktype in ['9'])                                    => 0.0034744716,
																					  -0.0023089681));

	N113_5 :=__common__( map(((real)iv_hist_addr_match <= NULL) => N113_7,
				  ((real)iv_hist_addr_match < 7.5)   => N113_6,
														N113_7));

	N113_4 :=__common__( if(((real)iv_ds001_impulse_count < 1.5), N113_5, 0.010131839));

	N113_3 :=__common__( if(((real)iv_ds001_impulse_count > NULL), N113_4, -0.00010458166));

	N113_2 :=__common__( if(((real)iv_inq_adls_per_addr < 2.5), N113_3, N113_8));

	N113_1 :=__common__( if(((real)iv_inq_adls_per_addr > NULL), N113_2, 0.014208034));

	N114_7 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant']) => 0.009286824,
				  (iv_va100_add_problem in ['04 HiRisk Commercial'])                                                                                                                                                                                                                                          => 0.15490954,
																																																																												 0.009286824));

	N114_6 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '9']) => N114_7,
				  (nf_fp_idrisktype in ['6', '7', '8'])                => 0.14172435,
																		  N114_7));

	N114_5 :=__common__( map((nf_fp_idrisktype in ['5', '9'])                          => -0.019978268,
				  (nf_fp_idrisktype in ['1', '2', '3', '4', '6', '7', '8']) => 0.00047373406,
																			   -0.019978268));

	N114_4 :=__common__( map((iv_vp100_phn_prob in ['5 Cell', '7 PCS'])                                                                          => N114_5,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '4 Invalid', '6 Pager', '8 Pay_Phone']) => 0.014374536,
																																		 N114_5));

	N114_3 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0068243934,
				  ((real)iv_ag001_age < 53.5)  => N114_4,
												  -0.0068243934));

	N114_2 :=__common__( if(((real)c_transport < 20.5499992371), N114_3, N114_6));

	N114_1 :=__common__( if(trim(C_TRANSPORT) != '', N114_2, -0.0020550072));

	N115_8 :=__common__( map(((real)iv_pb_total_dollars <= NULL) => -0.0015078221,
				  ((real)iv_pb_total_dollars < 11.5)  => 0.0061223673,
														 -0.0015078221));

	N115_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '4', '5', '7', '8', '9']) => N115_8,
				  (nf_fp_divrisktype in ['3', '6'])                          => 0.016507738,
																				N115_8));

	N115_6 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-2', '2-3', '3-2', '3-3']) => N115_7,
				  (iv_paw_dead_bus_x_active_phn in ['1-2', '3-0', '3-1'])                                                                       => 0.13753938,
																																				   N115_7));

	N115_5 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => -0.00021062194,
				  ((real)iv_addr_non_phn_src_ct < 2.5)   => N115_6,
															-0.00021062194));

	N115_4 :=__common__( if(((real)iv_prv_addr_source_count < 4.5), N115_5, -0.0028535911));

	N115_3 :=__common__( if(((real)iv_prv_addr_source_count > NULL), N115_4, -0.0020365939));

	N115_2 :=__common__( if(((real)c_fammar_p < 80.25), N115_3, -0.0035406068));

	N115_1 :=__common__( if(trim(C_FAMMAR_P) != '', N115_2, -0.00075806603));

	N116_7 :=__common__( map(((real)iv_dist_bst_addr_to_prv_addr <= NULL) => 0.0007150014,
				  ((real)iv_dist_bst_addr_to_prv_addr < 33.5)  => 0.013754802,
																  0.0007150014));

	N116_6 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '8', '9']) => N116_7,
				  (nf_fp_idrisktype in ['6', '7'])                          => 0.10590408,
																			   N116_7));

	N116_5 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '4', '8'])      => 0.00091039374,
				  (nf_fp_sourcerisktype in ['3', '5', '6', '7', '9']) => N116_6,
																		 N116_6));

	N116_4 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '7']) => 0.0015630673,
				  (nf_fp_srchvelocityrisktype in ['5', '6', '8', '9'])      => N116_5,
																			   0.0015630673));

	N116_3 :=__common__( map((iv_infutor_nap in ['0', '10', '12', '4', '7', '9']) => -0.00058719415,
				  (iv_infutor_nap in ['1', '11', '6'])                 => N116_4,
																		  N116_4));

	N116_2 :=__common__( if(((real)iv_attr_rel_liens_recency < 4.5), N116_3, -0.0051257523));

	N116_1 :=__common__( if(((real)iv_attr_rel_liens_recency > NULL), N116_2, 0.0064142828));

	N117_8 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '6', '8']) => 0.0037870193,
				  (nf_fp_assocrisktype in ['5', '7', '9'])                => 0.020275011,
																			 0.0037870193));

	N117_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '7', '8']) => 0.0044622028,
				  (nf_fp_varrisktype in ['6', '9'])                                => 0.01935421,
																					  0.0044622028));

	N117_6 :=__common__( map(((real)nf_fp_srchcountwk <= NULL) => N117_7,
				  ((real)nf_fp_srchcountwk < 0.5)   => 0.00023000299,
													   N117_7));

	N117_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '3-2', '3-3'])               => -0.0058011152,
				  (iv_criminal_x_felony in ['1-1', '2-0', '2-1', '2-2', '3-0', '3-1']) => 0.0070530759,
																						  0.0070530759));

	N117_4 :=__common__( if(((real)c_easiqlife < 76.5), N117_5, N117_6));

	N117_3 :=__common__( if(trim(C_EASIQLIFE) != '', N117_4, -0.0042588323));

	N117_2 :=__common__( if(((integer)iv_impulse_annual_income < 25374), N117_3, N117_8));

	N117_1 :=__common__( if(((real)iv_impulse_annual_income > NULL), N117_2, -0.0021187962));

	N118_8 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '0', '15', '20', '25', '30', '40']) => 0.006841158,
				  (iv_inp_addr_mortgage_term in ['10', '5'])                               => 0.078828076,
																							  0.006841158));

	N118_7 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '102', '103', '104', '105', '106', '108', '109', '110', '111', '112']) => N118_8,
				  (iv_phnpop_x_nap_summary in ['003', '101', '107'])                                                                                     => 0.14062303,
																																							N118_8));

	N118_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '7', '8']) => 0.0065635668,
				  (nf_fp_varrisktype in ['4', '5', '6', '9'])            => 0.02183537,
																			0.0065635668));

	N118_5 :=__common__( if(((real)nf_fp_corrssnaddrcount < 0.5), N118_6, 0.001270041));

	N118_4 :=__common__( if(((real)nf_fp_corrssnaddrcount > NULL), N118_5, 0.0021914113));

	N118_3 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '1-0', '2-0', '2-3', '3-0', '3-1', '3-3']) => -0.0014529689,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '1-1', '1-3', '2-1'])                                    => N118_4,
																													   -0.0014529689));

	N118_2 :=__common__( if(((real)c_asian_lang < 184.5), N118_3, N118_7));

	N118_1 :=__common__( if(trim(C_ASIAN_LANG) != '', N118_2, -0.0033220647));

	N119_6 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '008', '100', '102', '104', '105', '107', '108', '109', '110', '111', '112']) => 0.006673625,
				  (iv_phnpop_x_nap_summary in ['005', '101', '103', '106'])                                                                       => 0.047637796,
																																					 0.006673625));

	N119_5 :=__common__( map((iv_in001_college_income in ['-1', 'B', 'C', 'D', 'G', 'I']) => N119_6,
				  (iv_in001_college_income in ['A', 'E', 'F', 'H', 'J', 'K'])  => 0.043598983,
																				  0.043598983));

	N119_4 :=__common__( if(((real)c_fammar_p < 39.5499992371), N119_5, 0.0012445433));

	N119_3 :=__common__( if(trim(C_FAMMAR_P) != '', N119_4, 0.0099387591));

	N119_2 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'G', 'H', 'M', 'P', 'R', 'S']) => -0.0015920402,
				  (nf_fp_prevaddrdwelltype in ['U'])                                     => 0.15366534,
																							-0.0015920402));

	N119_1 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '5', '9']) => N119_2,
				  (nf_fp_sourcerisktype in ['6', '7', '8'])                => N119_3,
																			  N119_3));

	N120_6 :=__common__( map(((real)iv_src_bureau_addr_count <= NULL) => 0.0003205368,
				  ((real)iv_src_bureau_addr_count < 4.5)   => 0.020133682,
															  0.0003205368));

	N120_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '5', '7', '8', '9']) => 0.00045475636,
				  (nf_fp_divrisktype in ['4', '6'])                          => 0.010442389,
																				0.00045475636));

	N120_4 :=__common__( map(((real)iv_hist_addr_match <= NULL) => N120_6,
				  ((real)iv_hist_addr_match < 5.5)   => N120_5,
														N120_6));

	N120_3 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr < 0.5), -0.0033737728, N120_4));

	N120_2 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N120_3, -0.020561669));

	N120_1 :=__common__( map((iv_cvi in [10, 20, 30, 40, 50]) => N120_2,
				  (iv_cvi in [0])                         => 0.021548671,
																N120_2));

	N121_7 :=__common__( if(((real)nf_fp_prevaddrlenofres < 33.5), 0.015446137, 0.00086037061));

	N121_6 :=__common__( if(((real)nf_fp_prevaddrlenofres > NULL), N121_7, 0.0061756328));

	N121_5 :=__common__( map(((real)iv_unreleased_liens_ct <= NULL) => 0.013062746,
				  ((real)iv_unreleased_liens_ct < 3.5)   => 0.0016845754,
															0.013062746));

	N121_4 :=__common__( if(((real)c_pop_18_24_p < 11.4499998093), N121_5, -0.0041395265));

	N121_3 :=__common__( if(trim(C_POP_18_24_P) != '', N121_4, 0.0014657203));

	N121_2 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => N121_3,
				  (nf_fp_corrrisktype in ['9'])                                    => N121_6,
																					  N121_6));

	N121_1 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '02', '03', '10', '13', '14']) => -0.0017342456,
				  (iv_prv_own_prop_x_addr_naprop in ['01', '04', '11', '12'])             => N121_2,
																							 N121_2));

	N122_9 :=__common__( if(((real)iv_purch_sold_val_diff > NULL), 0.069501691, 0.0027718075));

	N122_8 :=__common__( if(((real)c_young < 19.1500015259), 0.018670755, N122_9));

	N122_7 :=__common__( if(trim(C_YOUNG) != '', N122_8, 0.072333425));

	N122_6 :=__common__( map(((real)iv_inq_ssns_per_addr <= NULL) => N122_7,
				  ((real)iv_inq_ssns_per_addr < 1.5)   => -0.00023155318,
														  N122_7));

	N122_5 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '4', '5', '8']) => -0.0037012897,
				  (nf_fp_srchvelocityrisktype in ['6', '7', '9'])                => N122_6,
																					-0.0037012897));

	N122_4 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N122_5, -0.00010195634));

	N122_3 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => 0.011004396,
				  ((real)iv_inq_collection_count12 < 2.5)   => N122_4,
															   0.011004396));

	N122_2 :=__common__( if(((real)iv_sr001_source_profile < 78.4499969482), N122_3, -0.0077008734));

	N122_1 :=__common__( if(((real)iv_sr001_source_profile > NULL), N122_2, -0.0054579746));

	N123_7 :=__common__( map(trim(C_UNEMPL) = ''      => 0.013047317,
				  ((real)c_unempl < 127.5) => 0.0027989208,
											  0.013047317));

	N123_6 :=__common__( map((iv_input_dob_match_level in ['0', '3', '4', '6', '7', '8']) => N123_7,
				  (iv_input_dob_match_level in ['1', '2', '5'])                => 0.056197533,
																				  N123_7));

	N123_5 :=__common__( if(((real)c_pop_18_24_p < 13.5500001907), N123_6, -0.0039176344));

	N123_4 :=__common__( if(trim(C_POP_18_24_P) != '', N123_5, 0.0025416682));

	N123_3 :=__common__( if(((real)iv_de001_eviction_recency < 1.5), -0.002118749, 0.0027733191));

	N123_2 :=__common__( if(((real)iv_de001_eviction_recency > NULL), N123_3, -0.0033828907));

	N123_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => N123_4,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => N123_2,
															   N123_4));

	N124_8 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '111', '112']) => 0.00059191821,
				  (iv_phnpop_x_nap_summary in ['110'])                                                                                                                 => 0.20362176,
																																										  0.00059191821));

	N124_7 :=__common__( map(trim(C_TRAILER) = ''      => N124_8,
				  ((real)c_trailer < 114.5) => 0.011646917,
											   N124_8));

	N124_6 :=__common__( map((iv_nas_summary in [0, 1, 3, 4, 6, 7, 9, 10, 11, 12]) => N124_7,
				  (iv_nas_summary in [2, 8])                                                 => 0.047025773,
																									  N124_7));

	N124_5 :=__common__( if(((real)c_old_homes < 78.5), N124_6, -0.00031506959));

	N124_4 :=__common__( if(trim(C_OLD_HOMES) != '', N124_5, 0.023637563));

	N124_3 :=__common__( map(((real)nf_fp_prevaddrcartheftindex <= NULL) => N124_4,
				  ((real)nf_fp_prevaddrcartheftindex < 149.5) => -0.0011931976,
																 N124_4));

	N124_2 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '5 Cell', '6 Pager', '7 PCS'])      => N124_3,
				  (iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '4 Invalid', '8 Pay_Phone']) => 0.024709636,
																									   N124_3));

	N124_1 :=__common__( if(((real)nf_fp_prevaddrcartheftindex > NULL), N124_2, -0.0018572906));

	N125_6 :=__common__( map(((real)iv_mos_src_bureau_ssn_fseen <= NULL) => -0.0013421448,
				  ((real)iv_mos_src_bureau_ssn_fseen < 245.5) => 0.014911664,
																 -0.0013421448));

	N125_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['1-0', '1-1', '3-1', '3-2', '4-2', '5-3'])                                           => -0.0012735191,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-3', '4-1', '4-3', '5-1', '5-2']) => 0.0045129649,
																																			0.0045129649));

	N125_4 :=__common__( map(((real)iv_inq_other_recency <= NULL) => N125_5,
				  ((real)iv_inq_other_recency < 0.5)   => -0.0033541384,
														  N125_5));

	N125_3 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => 0.0055471573,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => N125_4,
															   0.0055471573));

	N125_2 :=__common__( if(((real)iv_inq_other_recency > NULL), N125_3, -0.0088887873));

	N125_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0', '3-1']) => N125_2,
				  (iv_criminal_x_felony in ['1-1', '2-1', '3-2', '3-3'])               => N125_6,
																						  N125_2));

	N126_8 :=__common__( map(((real)nf_fp_prevaddrcrimeindex <= NULL) => 0.00023738957,
				  ((integer)nf_fp_prevaddrcrimeindex < 88) => -0.0069048631,
															  0.00023738957));

	N126_7 :=__common__( map(trim(C_FINANCE) = ''              => 0.014805852,
				  ((real)c_finance < 11.9499998093) => 0.0028147163,
													   0.014805852));

	N126_6 :=__common__( map(((real)iv_addr_non_phn_src_ct <= NULL) => -0.00077914904,
				  ((real)iv_addr_non_phn_src_ct < 2.5)   => N126_7,
															-0.00077914904));

	N126_5 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '5 Cell', '6 Pager', '7 PCS'])      => N126_6,
				  (iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '4 Invalid', '8 Pay_Phone']) => 0.033960286,
																									   N126_6));

	N126_4 :=__common__( if(((real)c_retail < 12.4499998093), N126_5, N126_8));

	N126_3 :=__common__( if(trim(C_RETAIL) != '', N126_4, -0.0027919165));

	N126_2 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk < 1.5), N126_3, 0.010119747));

	N126_1 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk > NULL), N126_2, 0.0055028974));

	N127_8 :=__common__( map(trim(C_SUB_BUS) = ''      => 0.010337963,
				  ((real)c_sub_bus < 161.5) => 0.0013998849,
											   0.010337963));

	N127_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '7', '8']) => -0.00033012674,
				  (nf_fp_srchcomponentrisktype in ['6', '9'])                          => 0.15459913,
																						  -0.00033012674));

	N127_6 :=__common__( map((nf_fp_srchvelocityrisktype in ['4', '5', '7', '9'])      => -0.012879327,
				  (nf_fp_srchvelocityrisktype in ['1', '2', '3', '6', '8']) => N127_7,
																			   N127_7));

	N127_5 :=__common__( if(((real)c_easiqlife < 63.5), N127_6, N127_8));

	N127_4 :=__common__( if(trim(C_EASIQLIFE) != '', N127_5, 0.008392461));

	N127_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-1', '3-2']) => N127_4,
				  (iv_criminal_x_felony in ['2-1', '3-3'])                                           => 0.013458608,
																										N127_4));

	N127_2 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr < 3.5), -0.0024352599, N127_3));

	N127_1 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N127_2, 0.0062310412));

	N128_7 :=__common__( map((iv_va008_add_throwback in ['0']) => 0.0059926611,
				  (iv_va008_add_throwback in ['1']) => 0.31898212,
													   0.31898212));

	N128_6 :=__common__( if(((real)iv_src_bureau_lname_count < 92.5), 0.00014442269, 0.012062846));

	N128_5 :=__common__( if(((real)iv_src_bureau_lname_count > NULL), N128_6, -0.00053662465));

	N128_4 :=__common__( map(trim(C_TOTSALES) = ''       => -0.0033254605,
				  ((real)c_totsales < 4215.5) => N128_5,
												 -0.0033254605));

	N128_3 :=__common__( if(((real)c_asian_lang < 183.5), N128_4, N128_7));

	N128_2 :=__common__( if(trim(C_ASIAN_LANG) != '', N128_3, 0.0012156471));

	N128_1 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '6', '9']) => N128_2,
				  (nf_fp_idrisktype in ['7', '8'])                          => 0.019527613,
																			   N128_2));

	N129_6 :=__common__( map(trim(C_OLD_HOMES) = ''     => 0.00778243,
				  ((real)c_old_homes < 90.5) => 0.024849239,
												0.00778243));

	N129_5 :=__common__( map(((real)nf_average_rel_criminal_dist <= NULL)  => N129_6,
				  ((integer)nf_average_rel_criminal_dist < 142) => 0.0037505006,
																   N129_6));

	N129_4 :=__common__( if(((real)c_famotf18_p < 23.6500015259), 0.0018575317, N129_5));

	N129_3 :=__common__( if(trim(C_FAMOTF18_P) != '', N129_4, 0.010147826));

	N129_2 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '4', '6', '7', '8']) => -0.00047240519,
				  (nf_fp_varrisktype in ['2', '3', '5', '9'])            => N129_3,
																			-0.00047240519));

	N129_1 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '6 Semi-yearly', '8 Rarely'])                                         => -0.0032341625,
				  (iv_pb_order_freq in ['0 No Purch Data', '2 Weekly', '3 Monthly', '4 Semi-monthly', '5 Quarterly', '7 Yearly']) => N129_2,
																																	 N129_2));

	N130_8 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '10', '15', '25', '30', '5']) => 0.0090089608,
				  (iv_bst_addr_mortgage_term in ['0', '20', '40'])                   => 0.079667201,
																						0.0090089608));

	N130_7 :=__common__( map((iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.00066408868,
				  (iv_inp_addr_mortgage_type in ['High-Risk'])                                                                                                                  => 0.12140884,
																																												   -0.00066408868));

	N130_6 :=__common__( map(((real)iv_inq_highriskcredit_count12 <= NULL) => 0.0060640548,
				  ((real)iv_inq_highriskcredit_count12 < 0.5)   => N130_7,
																   0.0060640548));

	N130_5 :=__common__( if(trim(C_HVAL_80K_P) != '', N130_6, 0.015901119));

	N130_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '2-1'])                             => -0.0020581066,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => N130_5,
																								 N130_5));

	N130_3 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '101', '102', '103', '105', '108', '109', '110', '111', '112']) => N130_4,
				  (iv_phnpop_x_nap_summary in ['003', '104', '106', '107'])                                                                       => 0.02001966,
																																					 0.02001966));

	N130_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 3.5), N130_3, N130_8));

	N130_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N130_2, 0.00072432653));

	N131_8 :=__common__( map((nf_fp_corrrisktype in ['2', '3', '4', '5', '6', '7', '8']) => 0.004162004,
				  (nf_fp_corrrisktype in ['1', '9'])                          => 0.027980699,
																				 0.004162004));

	N131_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '7', '8']) => -0.0038055358,
				  (nf_fp_varrisktype in ['9'])                                          => 0.011891632,
																						   -0.0038055358));

	N131_6 :=__common__( map(trim(C_HVAL_200K_P) = ''              => N131_7,
				  ((real)c_hval_200k_p < 3.04999995232) => 0.00078847445,
														   N131_7));

	N131_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => 0.016460047,
				  ((real)c_hval_175k_p < 5.44999980927) => -0.00095851355,
														   0.016460047));

	N131_4 :=__common__( if(((real)c_oldhouse < 11.6499996185), N131_5, N131_6));

	N131_3 :=__common__( if(trim(C_OLDHOUSE) != '', N131_4, 0.0024609184));

	N131_2 :=__common__( if(((real)iv_dg001_derog_count < 11.5), N131_3, N131_8));

	N131_1 :=__common__( if(((real)iv_dg001_derog_count > NULL), N131_2, 0.0023797044));

	N132_8 :=__common__( map((iv_nas_summary in [0, 3, 4, 6, 7, 8, 9, 10, 11, 12]) => 0.0019826923,
				  (iv_nas_summary in [1, 2])                                                 => 0.062319841,
																									  0.0019826923));

	N132_7 :=__common__( if(((real)c_oldhouse < 110.75), 0.020900679, N132_8));

	N132_6 :=__common__( if(trim(C_OLDHOUSE) != '', N132_7, 0.022506385));

	N132_5 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '3', '4', '7']) => -0.00095185139,
				  (nf_fp_corrrisktype in ['5', '6', '8', '9'])      => 0.014726418,
																	   -0.00095185139));

	N132_4 :=__common__( map((iv_bst_addr_financing_type in ['ADJ', 'CNV', 'NONE']) => N132_5,
				  (iv_bst_addr_financing_type in ['OTH'])                => 0.12755659,
																			N132_5));

	N132_3 :=__common__( map(((real)iv_dl001_unrel_lien60_count <= NULL) => N132_4,
				  ((real)iv_dl001_unrel_lien60_count < 3.5)   => -0.00086596442,
																 N132_4));

	N132_2 :=__common__( if(((real)nf_fp_prevaddrcrimeindex < 190.5), N132_3, N132_6));

	N132_1 :=__common__( if(((real)nf_fp_prevaddrcrimeindex > NULL), N132_2, -0.0014069423));

	N133_10 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.00068728029,
				   ((real)iv_ag001_age < 27.5)  => 0.011917935,
												   -0.00068728029));

	N133_9 :=__common__( if(((real)iv_bst_addr_avm_pct_change_2yr > NULL), N133_10, -0.0020714063));

	N133_8 :=__common__( map((iv_input_dob_match_level in ['0', '2', '4', '5', '6', '7', '8']) => 0.010104259,
				  (iv_input_dob_match_level in ['1', '3'])                          => 0.11055189,
																					   0.010104259));

	N133_7 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => N133_8,
				  (iv_gong_did_fname_x_lname_ct in ['1-2', '3-3'])                                                                                                   => 0.057865153,
																																										N133_8));

	N133_6 :=__common__( if(((real)c_old_homes < 74.5), N133_7, 0.0016033104));

	N133_5 :=__common__( if(trim(C_OLD_HOMES) != '', N133_6, -0.0024483821));

	N133_4 :=__common__( if(((real)nf_fp_prevaddrmedianvalue < 92459.5), N133_5, N133_9));

	N133_3 :=__common__( if(((real)nf_fp_prevaddrmedianvalue > NULL), N133_4, 0.0046398927));

	N133_2 :=__common__( if(((real)iv_inp_addr_building_area < 1047.5), -0.0012875322, N133_3));

	N133_1 :=__common__( if(((real)iv_inp_addr_building_area > NULL), N133_2, 0.0048362494));

	N134_8 :=__common__( map(((real)nf_fp_assoccredbureaucount <= NULL) => 0.0097259312,
				  ((real)nf_fp_assoccredbureaucount < 2.5)   => 0.0018359818,
																0.0097259312));

	N134_7 :=__common__( if(((real)c_rental < 119.5), 0.024199224, 0.0054889085));

	N134_6 :=__common__( if(trim(C_RENTAL) != '', N134_7, -0.028057593));

	N134_5 :=__common__( map((nf_fp_assocrisktype in ['3', '4', '6', '7'])      => -0.0013544948,
				  (nf_fp_assocrisktype in ['1', '2', '5', '8', '9']) => N134_6,
																		N134_6));

	N134_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-1', '2-2', '3-1']) => 0.00016532819,
				  (iv_criminal_x_felony in ['2-0', '3-0', '3-2', '3-3'])               => N134_5,
																						  0.00016532819));

	N134_3 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => -0.0025959561,
				  (iv_dl_val_flag in ['Empty'])     => N134_4,
													   N134_4));

	N134_2 :=__common__( if(((real)nf_fp_srchfraudsrchcount < 12.5), N134_3, N134_8));

	N134_1 :=__common__( if(((real)nf_fp_srchfraudsrchcount > NULL), N134_2, -0.007383103));

	N135_9 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => -0.0019337754,
				  (iv_vs002_ssn_prior_dob in ['1']) => 0.033217002,
													   0.033217002));

	N135_8 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G']) => 0.0010768428,
				  (iv_in001_college_income in ['H', 'I', 'J', 'K'])                      => 0.019486471,
																							0.019486471));

	N135_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.014852174,
				  ((real)c_newhouse < 79.5500030518) => N135_8,
														0.014852174));

	N135_6 :=__common__( if(((real)c_retail < 5.44999980927), N135_7, N135_9));

	N135_5 :=__common__( if(trim(C_RETAIL) != '', N135_6, 0.0030820313));

	N135_4 :=__common__( if(((real)iv_sr001_source_profile < 20.6500015259), 0.0087905939, -0.0011256482));

	N135_3 :=__common__( if(((real)iv_sr001_source_profile > NULL), N135_4, -0.0047557176));

	N135_2 :=__common__( map(((real)iv_pv001_inp_avm_autoval <= NULL)    => N135_3,
				  ((integer)iv_pv001_inp_avm_autoval < 16923) => 0.012736648,
																 N135_3));

	N135_1 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N135_2, N135_5));

	N136_8 :=__common__( map(((real)nf_util_adl_count <= NULL) => 0.018239997,
				  ((real)nf_util_adl_count < 3.5)   => 0.0028476405,
													   0.018239997));

	N136_7 :=__common__( map(((real)iv_prv_addr_avm_auto_val <= NULL)    => 0.014509238,
				  ((real)iv_prv_addr_avm_auto_val < 322446.5) => -0.0013966915,
																 0.014509238));

	N136_6 :=__common__( map(((real)iv_ssn_score <= NULL) => N136_7,
				  ((integer)iv_ssn_score < 95) => 0.0096995695,
												  N136_7));

	N136_5 :=__common__( map(trim(C_POP_35_44_P) = ''              => N136_6,
				  ((real)c_pop_35_44_p < 4.05000019073) => -0.015172647,
														   N136_6));

	N136_4 :=__common__( if(((real)c_hval_400k_p < 37.1500015259), N136_5, 0.010407043));

	N136_3 :=__common__( if(trim(C_HVAL_400K_P) != '', N136_4, 0.00059614274));

	N136_2 :=__common__( if(((real)iv_dl001_unrel_lien60_count < 3.5), N136_3, N136_8));

	N136_1 :=__common__( if(((real)iv_dl001_unrel_lien60_count > NULL), N136_2, 0.0072595033));

	N137_7 :=__common__( map((iv_ams_college_major in ['Liberal Arts'])                                                                       => -0.027162268,
				  (iv_ams_college_major in ['Business', 'Medical', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => 0.0030118742,
																																	  0.0030118742));

	N137_6 :=__common__( map(((real)iv_dist_bst_addr_to_prv_addr <= NULL)  => -0.0076030897,
				  ((integer)iv_dist_bst_addr_to_prv_addr < 297) => N137_7,
																   -0.0076030897));

	N137_5 :=__common__( map(((real)iv_ssns_per_sfd_addr_c6 <= NULL) => 0.01408636,
				  ((real)iv_ssns_per_sfd_addr_c6 < 3.5)   => N137_6,
															 0.01408636));

	N137_4 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '2-0', '3-0', '3-2']) => -0.0013885719,
				  (iv_paw_dead_bus_x_active_phn in ['1-3', '2-1', '2-2', '2-3', '3-1', '3-3'])                             => 0.046245109,
																															  -0.0013885719));

	N137_3 :=__common__( map((iv_pb_profile in ['2 Online Shopper'])                                                    => -0.0092076798,
				  (iv_pb_profile in ['0 No Purch Data', '1 Offline Shopper', '3 Retail Shopper', '4 Other']) => N137_4,
																												N137_4));

	N137_2 :=__common__( if(((real)nf_fp_srchaddrsrchcount < 7.5), N137_3, N137_5));

	N137_1 :=__common__( if(((real)nf_fp_srchaddrsrchcount > NULL), N137_2, -0.0030505471));

	N138_8 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.0042139688,
				  (iv_gong_did_fname_x_lname_ct in ['0-1'])                                                                                                                 => 0.34920526,
																																											   0.0042139688));

	N138_7 :=__common__( map(((real)nf_fp_curraddrcrimeindex <= NULL) => 0.0043063375,
				  ((real)nf_fp_curraddrcrimeindex < 158.5) => -0.0052316212,
															  0.0043063375));

	N138_6 :=__common__( map(((real)iv_sr001_m_bureau_adl_fs <= NULL) => N138_8,
				  ((real)iv_sr001_m_bureau_adl_fs < 111.5) => N138_7,
															  N138_8));

	N138_5 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '4', '5', '9']) => -0.0034714881,
				  (nf_fp_sourcerisktype in ['3', '6', '7', '8'])      => N138_6,
																		 -0.0034714881));

	N138_4 :=__common__( if(((real)iv_inp_addr_avm_pct_change_2yr < 0.902513861656), 0.0036114335, -0.0033553431));

	N138_3 :=__common__( if(((real)iv_inp_addr_avm_pct_change_2yr > NULL), N138_4, N138_5));

	N138_2 :=__common__( if(((real)c_transport < 36.0499992371), N138_3, 0.014476623));

	N138_1 :=__common__( if(trim(C_TRANSPORT) != '', N138_2, -0.00034711066));

	N139_8 :=__common__( map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => 0.014287889,
				  (iv_bst_addr_mortgage_type in ['Piggyback'])                                                                                                                  => 0.19685193,
																																												   0.014287889));

	N139_7 :=__common__( if(((real)c_medi_indx < 96.5), N139_8, 0.0030795264));

	N139_6 :=__common__( if(trim(C_MEDI_INDX) != '', N139_7, -0.005164667));

	N139_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '3-0', '3-2', '3-3']) => 0.0010338598,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-1', '2-2', '3-1']) => N139_6,
																				   N139_6));

	N139_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '1-2', '2-0'])                                           => -0.01545638,
				  (iv_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-1', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.0052801204,
																											   0.0052801204));

	N139_3 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => -0.0034102188,
				  ((real)nf_fp_corrssnaddrcount < 1.5)   => N139_4,
															-0.0034102188));

	N139_2 :=__common__( map((iv_po001_inp_addr_naprop in [0, 2, 4]) => N139_3,
				  (iv_po001_inp_addr_naprop in [1, 3])      => N139_5,
																   N139_5));

	N139_1 :=__common__( if(((real)nf_fp_srchfraudsrchcountwk > NULL), N139_2, 0.0038293721));

	N140_9 :=__common__( if(((real)c_pop_35_44_p < 12.6499996185), 0.00066526964, 0.015102564));

	N140_8 :=__common__( if(trim(C_POP_35_44_P) != '', N140_9, 0.0074798935));

	N140_7 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '4 Invalid', '5 Cell', '7 PCS', '8 Pay_Phone']) => N140_8,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '6 Pager'])                                            => 0.05870319,
																														  N140_8));

	N140_6 :=__common__( if(((real)c_newhouse < 3.84999990463), 0.0052108022, -0.0027964427));

	N140_5 :=__common__( if(trim(C_NEWHOUSE) != '', N140_6, -0.0048983391));

	N140_4 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.0087332815,
				  ((real)nf_fp_srchfraudsrchcount < 10.5)  => N140_5,
															  0.0087332815));

	N140_3 :=__common__( map(((real)iv_mos_src_bureau_lname_fseen <= NULL) => N140_7,
				  ((real)iv_mos_src_bureau_lname_fseen < 98.5)  => N140_4,
																   N140_7));

	N140_2 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.00087207233,
				  ((real)iv_ag001_age < 27.5)  => N140_3,
												  -0.00087207233));

	N140_1 :=__common__( if(((real)iv_ssn_non_phn_src_ct > NULL), N140_2, 0.0047732979));

	N141_8 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['02', '03', '04', '10', '12', '13']) => -0.012323835,
				  (iv_prv_own_prop_x_addr_naprop in ['00', '01', '11', '14'])             => 0.012802221,
																							 -0.012323835));

	N141_7 :=__common__( if(((real)iv_mos_since_impulse_first_seen < -0.5), 0.0017927496, N141_8));

	N141_6 :=__common__( if(((real)iv_mos_since_impulse_first_seen > NULL), N141_7, 0.0078679282));

	N141_5 :=__common__( if(((real)c_retired2 < 131.5), N141_6, -0.0037961861));

	N141_4 :=__common__( if(trim(C_RETIRED2) != '', N141_5, -0.0016993901));

	N141_3 :=__common__( if(((integer)iv_inp_addr_avm_change_1yr < 25698), 0.00054051785, 0.015621035));

	N141_2 :=__common__( if(((real)iv_inp_addr_avm_change_1yr > NULL), N141_3, N141_4));

	N141_1 :=__common__( map((nf_fp_addrchangeecontrajindex in ['2', '3', '6'])       => -0.0021722003,
				  (nf_fp_addrchangeecontrajindex in ['-1', '1', '4', '5']) => N141_2,
																			  N141_2));

	N142_8 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '3-2', '4-1', '4-2', '4-3', '5-1', '5-2']) => 0.010149175,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '2-3', '3-1', '3-3', '5-3'])                                                         => 0.064032922,
																																				   0.010149175));

	N142_7 :=__common__( map((iv_ams_college_tier in ['-1', '0', '1', '2', '3', '4', '5']) => N142_8,
				  (iv_ams_college_tier in ['6'])                                => 0.083695298,
																				   N142_8));

	N142_6 :=__common__( map(((real)iv_bst_addr_assessed_total_val <= NULL)    => 0.013037975,
				  ((integer)iv_bst_addr_assessed_total_val < 66010) => 0.00083706774,
																	   0.013037975));

	N142_5 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '3', '4', '5', '7', '8', '9']) => N142_6,
				  (nf_fp_varrisktype in ['2', '6'])                                => N142_7,
																					  N142_6));

	N142_4 :=__common__( if(((real)iv_age_at_high_issue < 12.5), N142_5, -0.0049957547));

	N142_3 :=__common__( if(((real)iv_age_at_high_issue > NULL), N142_4, 0.0052080101));

	N142_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), -0.0011208267, N142_3));

	N142_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N142_2, 0.00058927086));

	N143_7 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2']) => 0.00028960284,
				  (iv_best_match_address in ['ADD3', 'NONE']) => 0.0055423317,
																 0.0055423317));

	N143_6 :=__common__( map((nf_fp_prevaddrdwelltype in ['F', 'M', 'P', 'R'])       => -0.0080540923,
				  (nf_fp_prevaddrdwelltype in ['-1', 'G', 'H', 'S', 'U']) => N143_7,
																			 N143_7));

	N143_5 :=__common__( if(((real)c_hval_200k_p < 10.6499996185), N143_6, -0.0045099551));

	N143_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N143_5, -0.0028517208));

	N143_3 :=__common__( if(((real)iv_inq_collection_count12 < 2.5), N143_4, 0.008890009));

	N143_2 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N143_3, -0.0051952529));

	N143_1 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '5 Cell', '7 PCS']) => N143_2,
				  (iv_vp100_phn_prob in ['4 Invalid', '6 Pager', '8 Pay_Phone'])                                  => 0.026125054,
																													 N143_2));

	N144_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2'])               => 0.0087945301,
				  (iv_criminal_x_felony in ['1-1', '2-1', '3-0', '3-1', '3-2', '3-3']) => 0.021049159,
																						  0.021049159));

	N144_7 :=__common__( map(((real)iv_avg_num_sources_per_addr <= NULL) => 0.00036476681,
				  ((real)iv_avg_num_sources_per_addr < 3.5)   => N144_8,
																 0.00036476681));

	N144_6 :=__common__( map(((real)iv_dl_addrs_per_adl <= NULL) => N144_7,
				  ((real)iv_dl_addrs_per_adl < -0.5)  => 0.00018736591,
														 N144_7));

	N144_5 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0012429119,
				  ((integer)nf_average_rel_home_val < 135500) => N144_6,
																 -0.0012429119));

	N144_4 :=__common__( if(((real)iv_inq_banking_recency < 0.5), N144_5, -0.0025162071));

	N144_3 :=__common__( if(((real)iv_inq_banking_recency > NULL), N144_4, 0.0031901761));

	N144_2 :=__common__( if(((real)c_hval_400k_p < 36.6500015259), N144_3, 0.010947783));

	N144_1 :=__common__( if(trim(C_HVAL_400K_P) != '', N144_2, -0.0042151049));

	N145_6 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-3', '1-0', '3-0', '3-1', '3-3'])        => -0.0081264952,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-1', '1-3', '2-0', '2-1', '2-3']) => 0.015996294,
																										 0.015996294));

	N145_5 :=__common__( map(trim(C_BEL_EDU) = ''     => 0.0024086222,
				  ((real)c_bel_edu < 82.5) => -0.0084874057,
											  0.0024086222));

	N145_4 :=__common__( if(((real)c_white_col < 43.5499992371), N145_5, N145_6));

	N145_3 :=__common__( if(trim(C_WHITE_COL) != '', N145_4, 0.01284471));

	N145_2 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-3', '3-1', '3-2', '4-1', '4-2', '4-3', '5-1', '5-3']) => N145_3,
				  (iv_gong_did_fname_x_lname_ct in ['2-2', '3-3', '5-2'])                                                                                     => 0.019827591,
																																								 N145_3));

	N145_1 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-2', '3-1'])                             => -0.0013072499,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '3-0', '3-2', '3-3']) => N145_2,
																								 -0.0013072499));

	N146_8 :=__common__( map(((real)nf_oldest_rel_age <= NULL) => -0.00099290236,
				  ((integer)nf_oldest_rel_age < 45) => -0.011544008,
													   -0.00099290236));

	N146_7 :=__common__( map(((real)nf_fp_srchssnsrchcountmo <= NULL) => 0.0096438534,
				  ((real)nf_fp_srchssnsrchcountmo < 1.5)   => 0.0021766825,
															  0.0096438534));

	N146_6 :=__common__( map(((real)iv_inq_lnames_per_addr <= NULL) => 0.0095248026,
				  ((real)iv_inq_lnames_per_addr < 1.5)   => -0.0028256508,
															0.0095248026));

	N146_5 :=__common__( map(trim(C_HVAL_400K_P) = ''              => -0.0088922326,
				  ((real)c_hval_400k_p < 1.65000009537) => N146_6,
														   -0.0088922326));

	N146_4 :=__common__( if(((real)c_easiqlife < 85.5), N146_5, N146_7));

	N146_3 :=__common__( if(trim(C_EASIQLIFE) != '', N146_4, 0.006073377));

	N146_2 :=__common__( if(((real)iv_inq_auto_recency < 0.5), N146_3, N146_8));

	N146_1 :=__common__( if(((real)iv_inq_auto_recency > NULL), N146_2, -0.00044986358));

	N147_8 :=__common__( map(((real)iv_avg_lres <= NULL) => 0.0078732242,
				  ((real)iv_avg_lres < 11.5)  => -0.0059514033,
												 0.0078732242));

	N147_7 :=__common__( map(((real)iv_combined_age <= NULL) => -0.002057258,
				  ((real)iv_combined_age < 21.5)  => N147_8,
													 -0.002057258));

	N147_6 :=__common__( map(((real)iv_impulse_annual_income <= NULL)    => 0.0073247809,
				  ((integer)iv_impulse_annual_income < 22506) => N147_7,
																 0.0073247809));

	N147_5 :=__common__( if(((real)c_transport < 23.9500007629), N147_6, 0.0092801437));

	N147_4 :=__common__( if(trim(C_TRANSPORT) != '', N147_5, -0.0021513366));

	N147_3 :=__common__( map(((real)iv_criminal_count <= NULL) => 0.0088866419,
				  ((real)iv_criminal_count < 9.5)   => N147_4,
													   0.0088866419));

	N147_2 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12]) => N147_3,
				  (iv_nas_summary in [1])                                                             => 0.071474183,
																											N147_3));

	N147_1 :=__common__( if(((real)iv_criminal_count > NULL), N147_2, -0.0023436535));

	N148_9 :=__common__( if(((integer)iv_bst_addr_assessed_total_val < 182950), -0.00096662855, 0.0082586466));

	N148_8 :=__common__( if(((real)iv_bst_addr_assessed_total_val > NULL), N148_9, 0.0026071166));

	N148_7 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '5', '6', '7', '8']) => -0.0023587283,
				  (nf_fp_varrisktype in ['-1', '4', '9'])                    => 0.019448767,
																				-0.0023587283));

	N148_6 :=__common__( map((iv_addr_ver_sources in ['Addr not Verd', 'NonPhn Only']) => 0.0034780603,
				  (iv_addr_ver_sources in ['Phn & NonPhn', 'Phn Only'])     => 0.022726305,
																			   0.022726305));

	N148_5 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '8', '9']) => N148_6,
				  (nf_fp_idrisktype in ['6', '7'])                          => 0.081863964,
																			   0.081863964));

	N148_4 :=__common__( if(((real)c_old_homes < 81.5), N148_5, N148_7));

	N148_3 :=__common__( if(trim(C_OLD_HOMES) != '', N148_4, 0.028727287));

	N148_2 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr < 0.878956198692), N148_3, -0.0020493617));

	N148_1 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N148_2, N148_8));

	N149_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-3']) => -0.0040819154,
				  (iv_paw_dead_bus_x_active_phn in ['0-3', '3-1', '3-2'])                                                                       => 0.088769636,
																																				   -0.0040819154));

	N149_6 :=__common__( map(((real)iv_pb_average_dollars <= NULL) => N149_7,
				  ((real)iv_pb_average_dollars < 19.5)  => 0.011134482,
														   N149_7));

	N149_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '4-1', '4-3', '5-1', '5-2', '5-3']) => N149_6,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '3-2', '3-3', '4-2'])                                                                       => 0.065412977,
																																						  N149_6));

	N149_4 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '005', '100', '106', '109', '112'])                                           => -0.0036301854,
				  (iv_phnpop_x_nap_summary in ['002', '003', '008', '101', '102', '103', '104', '105', '107', '108', '110', '111']) => N149_5,
																																	   N149_5));

	N149_3 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['00', '01', '02', '04', '10', '12', '13', '14']) => -0.0012371385,
				  (iv_inp_own_prop_x_addr_naprop in ['03', '11'])                                     => N149_4,
																										 -0.0012371385));

	N149_2 :=__common__( if(((real)nf_fp_srchaddrsrchcount < 49.5), N149_3, 0.012076723));

	N149_1 :=__common__( if(((real)nf_fp_srchaddrsrchcount > NULL), N149_2, 0.00097264144));

	N150_6 :=__common__( map(trim(C_LOW_HVAL) = ''              => 0.0083605099,
				  ((real)c_low_hval < 52.4500007629) => -0.00046405954,
														0.0083605099));

	N150_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '3-1', '3-2', '3-3']) => 0.0042402417,
				  (iv_criminal_x_felony in ['2-0', '2-1', '2-2', '3-0'])               => 0.017680077,
																						  0.0042402417));

	N150_4 :=__common__( if(((real)c_cpiall < 207.350006104), N150_5, N150_6));

	N150_3 :=__common__( if(trim(C_CPIALL) != '', N150_4, 0.00070986177));

	N150_2 :=__common__( map((nf_fp_varrisktype in ['4', '5', '6', '7', '8'])  => -0.007058955,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '9']) => -0.0012774966,
																	   -0.0012774966));

	N150_1 :=__common__( map((nf_fp_sourcerisktype in ['2', '4', '8', '9'])      => N150_2,
				  (nf_fp_sourcerisktype in ['1', '3', '5', '6', '7']) => N150_3,
																		 N150_3));

	N151_6 :=__common__( if(((real)c_hval_300k_p < 1.75), 0.018697419, 0.0023770954));

	N151_5 :=__common__( if(trim(C_HVAL_300K_P) != '', N151_6, 0.0098819613));

	N151_4 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 12]) => 0.0008884513,
				  (iv_nas_summary in [1, 11])                                                 => 0.026794188,
																									  0.0008884513));

	N151_3 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '5', '7', '8']) => N151_4,
				  (nf_fp_assocrisktype in ['4', '6', '9'])                => N151_5,
																			 N151_4));

	N151_2 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-2']) => N151_3,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '5-1', '5-3'])                                                                                     => 0.17608368,
																																								 N151_3));

	N151_1 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => -0.00074917923,
				  (nf_fp_sourcerisktype in ['7'])                                    => N151_2,
																						N151_2));

	N152_8 :=__common__( map((iv_liens_unrel_x_rel in ['0-2', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => 8.0539857e-005,
				  (iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0'])                                           => 0.011580774,
																											   8.0539857e-005));

	N152_7 :=__common__( map(((real)iv_combined_age <= NULL) => -0.010768465,
				  ((real)iv_combined_age < 54.5)  => N152_8,
													 -0.010768465));

	N152_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => N152_7,
				  ((real)c_hval_80k_p < 20.5499992371) => 2.2236793e-005,
														  N152_7));

	N152_5 :=__common__( if(((integer)nf_accident_recency < 30), N152_6, -0.0052226362));

	N152_4 :=__common__( if(((real)nf_accident_recency > NULL), N152_5, -0.0014391799));

	N152_3 :=__common__( map((iv_vp050_phn_cmp_pcs in ['1']) => N152_4,
				  (iv_vp050_phn_cmp_pcs in ['0']) => 0.010832127,
													 N152_4));

	N152_2 :=__common__( if(((real)c_blue_col < 25.4500007629), N152_3, -0.0099258338));

	N152_1 :=__common__( if(trim(C_BLUE_COL) != '', N152_2, 0.0031684939));

	N153_8 :=__common__( map((iv_nas_summary in [0, 3, 4, 7, 8, 9, 10, 12]) => 0.0032144245,
				  (iv_nas_summary in [1, 2, 6, 11])                         => 0.041479659,
																						  0.0032144245));

	N153_7 :=__common__( map(((real)nf_fp_prevaddrmedianincome <= NULL)    => 0.018452589,
				  ((integer)nf_fp_prevaddrmedianincome < 40168) => -0.00034552872,
																   0.018452589));

	N153_6 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'C', 'E', 'F', 'H', 'J']) => -0.0075999192,
				  (iv_in001_college_income in ['B', 'D', 'G', 'I', 'K'])            => 0.0097280075,
																					   -0.0075999192));

	N153_5 :=__common__( map((nf_fp_varrisktype in ['-1', '5', '7', '8'])          => N153_6,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '6', '9']) => -0.00054283423,
																		   -0.00054283423));

	N153_4 :=__common__( if(((real)c_hval_100k_p < 36.8499984741), N153_5, N153_7));

	N153_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N153_4, 0.0020625976));

	N153_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N153_3, N153_8));

	N153_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N153_2, 0.00020960011));

	N154_8 :=__common__( if(((real)c_unattach < 118.5), -0.0027959704, 0.011255244));

	N154_7 :=__common__( if(trim(C_UNATTACH) != '', N154_8, 0.065675378));

	N154_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '4', '5', '6', '9']) => N154_7,
				  (nf_fp_varrisktype in ['3', '7', '8'])                      => 0.015386711,
																				 N154_7));

	N154_5 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '1-2', '2-2', '3-0', '3-1', '3-2']) => N154_6,
				  (iv_liens_unrel_x_rel in ['0-2', '1-0', '2-0', '2-1'])                             => 0.022977049,
																										N154_6));

	N154_4 :=__common__( map(((real)nf_fp_corrssnnamecount <= NULL) => 0.0021335912,
				  ((real)nf_fp_corrssnnamecount < 4.5)   => N154_5,
															0.0021335912));

	N154_3 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '005', '008', '100', '101', '103', '109'])                             => -0.0020399061,
				  (iv_phnpop_x_nap_summary in ['000', '003', '102', '104', '105', '106', '107', '108', '110', '111', '112']) => N154_4,
																																N154_4));

	N154_2 :=__common__( if(((real)nf_fp_srchaddrsrchcount < 7.5), -0.0015215955, N154_3));

	N154_1 :=__common__( if(((real)nf_fp_srchaddrsrchcount > NULL), N154_2, -0.0072512888));

	N155_6 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112']) => 0.0017413213,
				  (iv_phnpop_x_nap_summary in ['003', '101'])                                                                                                   => 0.040233565,
																																								   0.0017413213));

	N155_5 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)    => -0.0065362841,
				  ((integer)nf_fp_curraddrmedianincome < 80114) => N155_6,
																   -0.0065362841));

	N155_4 :=__common__( if(((real)iv_mos_src_voter_adl_lseen < -0.5), N155_5, -0.0043885497));

	N155_3 :=__common__( if(((real)iv_mos_src_voter_adl_lseen > NULL), N155_4, 0.0080671627));

	N155_2 :=__common__( map((iv_prv_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.0055355551,
				  (iv_prv_addr_mortgage_type in ['Commercial'])                                                                                                                => 0.19667318,
																																												  -0.0055355551));

	N155_1 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3'])                                                  => N155_2,
				  (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-3']) => N155_3,
																															  N155_2));

	N156_6 :=__common__( map(((real)nf_fp_curraddrcartheftindex <= NULL) => 0.013508187,
				  ((integer)nf_fp_curraddrcartheftindex < 97) => -0.0036196957,
																 0.013508187));

	N156_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0']) => N156_6,
				  (iv_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2', '3-3']) => 0.026992789,
																				   0.026992789));

	N156_4 :=__common__( if(((real)c_blue_empl < 68.5), N156_5, 0.0014436608));

	N156_3 :=__common__( if(trim(C_BLUE_EMPL) != '', N156_4, 0.0031619018));

	N156_2 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => -0.00064883912,
				  (iv_dl_val_flag in ['Empty'])     => N156_3,
													   N156_3));

	N156_1 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '6 Semi-yearly', '7 Yearly', '8 Rarely'])                 => -0.0029902612,
				  (iv_pb_order_freq in ['0 No Purch Data', '2 Weekly', '3 Monthly', '4 Semi-monthly', '5 Quarterly']) => N156_2,
																														 N156_2));

	N157_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['3', '6', '9'])                => -0.010052536,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '4', '5', '7', '8']) => 0.0013139024,
																					 0.0013139024));

	N157_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '7', '8', '9']) => 0.0062463673,
				  (nf_fp_divrisktype in ['5', '6'])                          => 0.03568668,
																				0.0062463673));

	N157_4 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2', '4-3', '5-1']) => N157_5,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '2-3', '3-3', '4-1', '4-2', '5-2', '5-3'])                             => 0.048975609,
																																	 N157_5));

	N157_3 :=__common__( if(((real)c_serv_empl < 84.5), N157_4, N157_6));

	N157_2 :=__common__( if(trim(C_SERV_EMPL) != '', N157_3, 0.017758094));

	N157_1 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other']) => -0.0017168562,
				  (iv_prv_addr_mortgage_type in ['Non-Traditional', 'Piggyback', 'Unknown'])                                                      => N157_2,
																																					 -0.0017168562));

	N158_8 :=__common__( map((iv_lname_eda_sourced_type in ['-1', 'A', 'P']) => 0.0053804295,
				  (iv_lname_eda_sourced_type in ['AP'])           => 0.093739143,
																	 0.0053804295));

	N158_7 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '10', '15', '20', '25', '30']) => N158_8,
				  (iv_inp_addr_mortgage_term in ['0', '40', '5'])                     => 0.039117599,
																						 N158_8));

	N158_6 :=__common__( if(((real)iv_mos_since_bst_addr_fseen < 39.5), N158_7, -0.0018020838));

	N158_5 :=__common__( if(((real)iv_mos_since_bst_addr_fseen > NULL), N158_6, 0.00050852999));

	N158_4 :=__common__( map(((real)iv_ms001_ssns_per_adl <= NULL) => 0.0056158241,
				  ((real)iv_ms001_ssns_per_adl < 2.5)   => -0.0013431418,
														   0.0056158241));

	N158_3 :=__common__( map((nf_fp_varrisktype in ['7', '8'])                                => -0.0075547276,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '9']) => N158_4,
																					  -0.0075547276));

	N158_2 :=__common__( if(((real)c_relig_indx < 154.5), N158_3, N158_5));

	N158_1 :=__common__( if(trim(C_RELIG_INDX) != '', N158_2, 0.00313369));

	N159_9 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '03', '04', '10', '11', '13', '14']) => 0.0056898558,
				  (iv_prv_own_prop_x_addr_naprop in ['12'])                                                 => 0.093849884,
																											   0.0056898558));

	N159_8 :=__common__( if(((real)iv_bst_addr_avm_pct_change_2yr < 0.838139772415), 0.01571387, 0.0017411505));

	N159_7 :=__common__( if(((real)iv_bst_addr_avm_pct_change_2yr > NULL), N159_8, N159_9));

	N159_6 :=__common__( map(((real)iv_dist_inp_addr_to_prv_addr <= NULL)  => -0.0042799421,
				  ((integer)iv_dist_inp_addr_to_prv_addr < 428) => N159_7,
																   -0.0042799421));

	N159_5 :=__common__( map((fp_segment in ['3 New DID', '4 Bureau Only', '7 Other'])                   => -0.0015064902,
				  (fp_segment in ['1 SSN Prob', '2 NAS 479', '5 Derog', '6 Recent Activity']) => N159_6,
																								 N159_6));

	N159_4 :=__common__( if(((real)iv_age_at_low_issue < 11.5), N159_5, -0.0030666986));

	N159_3 :=__common__( if(((real)iv_age_at_low_issue > NULL), N159_4, 0.010984564));

	N159_2 :=__common__( if(((real)c_easiqlife < 115.5), -0.0026563781, N159_3));

	N159_1 :=__common__( if(trim(C_EASIQLIFE) != '', N159_2, -0.0068017563));

	N160_7 :=__common__( if(((real)iv_hist_addr_match < 5.5), 0.0010442053, 0.0094409188));

	N160_6 :=__common__( if(((real)iv_hist_addr_match > NULL), N160_7, -0.0012933384));

	N160_5 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0062428124,
				  ((real)iv_ag001_age < 55.5)  => N160_6,
												  -0.0062428124));

	N160_4 :=__common__( if(((real)c_no_car < 127.5), -0.011678833, 0.00021348953));

	N160_3 :=__common__( if(trim(C_NO_CAR) != '', N160_4, 0.0061872001));

	N160_2 :=__common__( map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '10', '11', '14']) => N160_3,
				  (iv_bst_own_prop_x_addr_naprop in ['02', '03', '04', '12', '13']) => 0.016305928,
																					   0.016305928));

	N160_1 :=__common__( map((nf_fp_varrisktype in ['-1', '7', '8', '9'])          => N160_2,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6']) => N160_5,
																		   N160_5));

	N161_6 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '7 PCS', '8 Pay_Phone'])    => -0.0024756781,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid', '5 Cell', '6 Pager']) => 0.0049410512,
																									  0.0049410512));

	N161_5 :=__common__( map(((real)iv_src_bureau_ssn_count <= NULL) => N161_6,
				  ((real)iv_src_bureau_ssn_count < 5.5)   => -0.01010674,
															 N161_6));

	N161_4 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '102', '103', '104', '109', '112']) => -0.0018891152,
				  (iv_phnpop_x_nap_summary in ['003', '101', '105', '106', '107', '108', '110', '111'])               => N161_5,
																														 -0.0018891152));

	N161_3 :=__common__( if(((integer)iv_ssn_score < 95), 0.010910574, N161_4));

	N161_2 :=__common__( if(((real)iv_ssn_score > NULL), N161_3, 0.0053247105));

	N161_1 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '2-2'])                             => -0.0092408906,
				  (iv_liens_unrel_x_rel in ['0-0', '1-0', '1-2', '2-0', '2-1', '3-0', '3-1', '3-2']) => N161_2,
																										N161_2));

	N162_8 :=__common__( map(trim(C_RENTAL) = ''      => 0.015470166,
				  ((real)c_rental < 149.5) => 2.0967066e-005,
											  0.015470166));

	N162_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '5', '6']) => -0.00037086438,
				  (nf_fp_srchcomponentrisktype in ['4', '7', '8', '9'])      => 0.0068906646,
																				-0.00037086438));

	N162_6 :=__common__( map(((real)nf_fp_prevaddrcrimeindex <= NULL) => N162_8,
				  ((real)nf_fp_prevaddrcrimeindex < 190.5) => N162_7,
															  N162_8));

	N162_5 :=__common__( if(((real)c_hval_400k_p < 36.3499984741), N162_6, 0.015422036));

	N162_4 :=__common__( if(trim(C_HVAL_400K_P) != '', N162_5, 0.0028288909));

	N162_3 :=__common__( map((nf_fp_addrchangeecontrajindex in ['1', '2', '3', '6']) => -0.0067519684,
				  (nf_fp_addrchangeecontrajindex in ['-1', '4', '5'])     => 0.00052365595,
																			 -0.0067519684));

	N162_2 :=__common__( if(((integer)nf_fp_prevaddrburglaryindex < 70), N162_3, N162_4));

	N162_1 :=__common__( if(((real)nf_fp_prevaddrburglaryindex > NULL), N162_2, -0.0075163957));

	N163_8 :=__common__( map((nf_fp_varrisktype in ['-1', '4', '6', '7', '9']) => -0.00821797,
				  (nf_fp_varrisktype in ['1', '2', '3', '5', '8'])  => -0.002786618,
																	   -0.002786618));

	N163_7 :=__common__( if(((real)c_pop_18_24_p < 11.4499998093), 0.00060278247, N163_8));

	N163_6 :=__common__( if(trim(C_POP_18_24_P) != '', N163_7, 0.0016255866));

	N163_5 :=__common__( map(((real)iv_prv_addr_avm_auto_val <= NULL)     => 0.012934817,
				  ((integer)iv_prv_addr_avm_auto_val < 282148) => N163_6,
																  0.012934817));

	N163_4 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'G', 'H', 'M', 'P', 'U']) => 0.006147571,
				  (nf_fp_prevaddrdwelltype in ['F', 'R', 'S'])                 => 0.02306518,
																				  0.006147571));

	N163_3 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '3', '5', '7']) => 6.895756e-005,
				  (nf_fp_varrisktype in ['2', '4', '6', '8', '9'])  => N163_4,
																	   N163_4));

	N163_2 :=__common__( if(((real)nf_fp_prevaddrageoldest < 3.5), N163_3, N163_5));

	N163_1 :=__common__( if(((real)nf_fp_prevaddrageoldest > NULL), N163_2, -0.0006889246));

	N164_8 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '4', '7', '9'])      => -0.00316932,
				  (nf_fp_srchvelocityrisktype in ['2', '3', '5', '6', '8']) => 0.018493259,
																			   0.018493259));

	N164_7 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '0', '10', '15', '25', '30', '5']) => N164_8,
				  (iv_inp_addr_mortgage_term in ['20', '40'])                             => 0.095362272,
																							 N164_8));

	N164_6 :=__common__( map((nf_fp_validationrisktype in ['1', '3'])                => 0.0053416346,
				  (nf_fp_validationrisktype in ['2', '4', '5', '6', '8']) => 0.10569227,
																			 0.10569227));

	N164_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-1', '2-1', '2-2', '3-2'])                                                         => N164_6,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '1-0', '1-2', '1-3', '2-3', '3-1', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.037649783,
																																				   0.037649783));

	N164_4 :=__common__( if(((real)c_work_home < 180.5), -0.00027125787, N164_5));

	N164_3 :=__common__( if(trim(C_WORK_HOME) != '', N164_4, 0.0040003573));

	N164_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 3.5), N164_3, N164_7));

	N164_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N164_2, 0.0062580329));

	N165_8 :=__common__( if(((real)c_many_cars < 97.5), 0.0011789669, 0.021055684));

	N165_7 :=__common__( if(trim(C_MANY_CARS) != '', N165_8, 0.0010432506));

	N165_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-1', '3-2', '3-3']) => N165_7,
				  (iv_criminal_x_felony in ['1-1', '2-1', '2-2'])                             => 0.054388434,
																								 N165_7));

	N165_5 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => 0.00055292245,
				  (iv_ed001_college_ind_26 in ['0']) => 0.0091620311,
														0.00055292245));

	N165_4 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-0', '1-1', '2-0', '2-3', '3-1', '3-3']) => N165_5,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '2-1', '3-0'])                                                  => N165_6,
																															  N165_5));

	N165_3 :=__common__( map(((real)iv_liens_unrel_cj_ct <= NULL) => 0.0050490939,
				  ((real)iv_liens_unrel_cj_ct < 2.5)   => -0.0015821232,
														  0.0050490939));

	N165_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), N165_3, N165_4));

	N165_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N165_2, 0.00032564927));

	N166_8 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '106', '107', '108', '110', '111', '112']) => 0.003054074,
				  (iv_phnpop_x_nap_summary in ['109'])                                                                                                                 => 0.37232935,
																																										  0.003054074));

	N166_7 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N166_8,
				  (nf_fp_sourcerisktype in ['7'])                                    => 0.017731947,
																						0.017731947));

	N166_6 :=__common__( map((nf_fp_corrrisktype in ['3', '6', '8', '9'])      => -0.008132678,
				  (nf_fp_corrrisktype in ['1', '2', '4', '5', '7']) => 0.0036813701,
																	   0.0036813701));

	N166_5 :=__common__( map(((real)iv_email_count <= NULL) => N166_6,
				  ((real)iv_email_count < 3.5)   => 0.0057974921,
													N166_6));

	N166_4 :=__common__( if(((real)iv_addrs_per_adl < 15.5), -0.0016172163, N166_5));

	N166_3 :=__common__( if(((real)iv_addrs_per_adl > NULL), N166_4, -0.00065640622));

	N166_2 :=__common__( if(((real)c_rental < 188.5), N166_3, N166_7));

	N166_1 :=__common__( if(trim(C_RENTAL) != '', N166_2, 0.0010483951));

	N167_7 :=__common__( map(((real)iv_prv_addr_lres <= NULL) => 0.0036096902,
				  ((real)iv_prv_addr_lres < 12.5)  => -0.004181146,
													  0.0036096902));

	N167_6 :=__common__( if(((real)c_mining < 0.350000023842), N167_7, -0.011300933));

	N167_5 :=__common__( if(trim(C_MINING) != '', N167_6, -0.00076108807));

	N167_4 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => N167_5,
				  ((real)iv_mos_since_prv_addr_fseen < 3.5)   => 0.012410785,
																 N167_5));

	N167_3 :=__common__( if(((real)nf_util_adl_count < 3.5), -0.0017893696, N167_4));

	N167_2 :=__common__( if(((real)nf_util_adl_count > NULL), N167_3, -0.0034850755));

	N167_1 :=__common__( map((iv_input_dob_match_level in ['0', '2', '3', '4', '5', '6', '7', '8']) => N167_2,
				  (iv_input_dob_match_level in ['1'])                                    => 0.023212709,
																							N167_2));

	N168_9 :=__common__( map((iv_infutor_nap in ['0', '1', '12', '4', '7', '9']) => -0.0080916603,
				  (iv_infutor_nap in ['10', '11', '6'])               => 0.040789302,
																		 -0.0080916603));

	N168_8 :=__common__( map(((real)iv_avg_num_sources_per_addr <= NULL) => -0.00211079,
				  ((real)iv_avg_num_sources_per_addr < 3.5)   => 0.010406908,
																 -0.00211079));

	N168_7 :=__common__( if(((real)iv_mos_since_infutor_last_seen < 3.5), -0.0011824824, 0.0030456647));

	N168_6 :=__common__( if(((real)iv_mos_since_infutor_last_seen > NULL), N168_7, 0.0014146052));

	N168_5 :=__common__( map((nf_fp_divrisktype in ['7'])                                    => -0.026585426,
				  (nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N168_6,
																					 N168_6));

	N168_4 :=__common__( if(((real)c_hval_100k_p < 30.1500015259), N168_5, N168_8));

	N168_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N168_4, -0.0022912106));

	N168_2 :=__common__( if(((real)iv_inq_auto_count12 < 1.5), N168_3, N168_9));

	N168_1 :=__common__( if(((real)iv_inq_auto_count12 > NULL), N168_2, 0.00018435255));

	N169_8 :=__common__( if(((real)c_rnt750_p < 19.4500007629), 0.015975791, 0.00089343651));

	N169_7 :=__common__( if(trim(C_RNT750_P) != '', N169_8, 0.0075184926));

	N169_6 :=__common__( map((iv_rec_vehx_level in ['AO', 'W1', 'W3', 'XX']) => N169_7,
				  (iv_rec_vehx_level in ['W2'])                   => 0.23141837,
																	 N169_7));

	N169_5 :=__common__( map((nf_fp_varrisktype in ['4', '5', '7', '8'])            => -0.0032223958,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '6', '9']) => 0.00094685925,
																			0.00094685925));

	N169_4 :=__common__( map((iv_dwelltype in ['GEN', 'MFD', 'POB', 'SFD']) => -0.0053088965,
				  (iv_dwelltype in ['RR'])                       => 0.15042667,
																	-0.0053088965));

	N169_3 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '2-0', '2-1', '2-2']) => N169_4,
				  (iv_liens_unrel_x_rel in ['0-0', '1-0', '1-2', '3-0', '3-1', '3-2']) => N169_5,
																						  N169_5));

	N169_2 :=__common__( if(((real)nf_fp_srchaddrsrchcount < 35.5), N169_3, N169_6));

	N169_1 :=__common__( if(((real)nf_fp_srchaddrsrchcount > NULL), N169_2, 0.00082520809));

	N170_7 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '6'])                => -0.0059521899,
				  (nf_fp_assocrisktype in ['3', '4', '5', '7', '8', '9']) => 0.01357503,
																			 0.01357503));

	N170_6 :=__common__( map((nf_fp_componentcharrisktype in ['1', '3', '5', '7'])      => -0.0045597104,
				  (nf_fp_componentcharrisktype in ['2', '4', '6', '8', '9']) => N170_7,
																				N170_7));

	N170_5 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)   => 0.015379116,
				  ((real)nf_fp_curraddrmedianincome < 56973.5) => N170_6,
																  0.015379116));

	N170_4 :=__common__( map((iv_input_dob_match_level in ['3', '4', '5', '6', '7', '8']) => N170_5,
				  (iv_input_dob_match_level in ['0', '1', '2'])                => 0.089315122,
																				  N170_5));

	N170_3 :=__common__( map(((real)iv_hist_addr_match <= NULL) => N170_4,
				  ((real)iv_hist_addr_match < 4.5)   => 5.3092814e-005,
														N170_4));

	N170_2 :=__common__( if(((real)nf_fp_srchunvrfdaddrcount < 1.5), N170_3, -0.006543012));

	N170_1 :=__common__( if(((real)nf_fp_srchunvrfdaddrcount > NULL), N170_2, -0.0020454212));

	N171_8 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'G', 'H', 'M', 'P', 'R', 'S']) => -0.0026706537,
				  (nf_fp_prevaddrdwelltype in ['U'])                                     => 0.17610972,
																							-0.0026706537));

	N171_7 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['1-1', '2-1', '2-2', '2-3', '3-2', '3-3', '5-1', '5-2'])               => N171_8,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-2', '1-3', '3-1', '4-1', '4-2', '4-3', '5-3']) => 0.0078745928,
																															  0.0078745928));

	N171_6 :=__common__( map(((real)nf_fp_curraddrmedianvalue <= NULL)    => N171_7,
				  ((integer)nf_fp_curraddrmedianvalue < 63170) => 0.014108644,
																  N171_7));

	N171_5 :=__common__( if(((real)c_cpiall < 205.799987793), N171_6, -0.0010203364));

	N171_4 :=__common__( if(trim(C_CPIALL) != '', N171_5, -9.4287247e-005));

	N171_3 :=__common__( map(((real)iv_inq_addrs_per_adl <= NULL) => -0.0063178308,
				  ((real)iv_inq_addrs_per_adl < 3.5)   => N171_4,
														  -0.0063178308));

	N171_2 :=__common__( if(((integer)iv_ssn_score < 95), 0.0094682416, N171_3));

	N171_1 :=__common__( if(((real)iv_ssn_score > NULL), N171_2, -0.0017876801));

	N172_8 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => 0.0019713734,
				  ((real)iv_mos_since_prv_addr_fseen < 48.5)  => 0.013227635,
																 0.0019713734));

	N172_7 :=__common__( map((iv_input_dob_match_level in ['0', '1', '2', '3', '4', '6', '7', '8']) => N172_8,
				  (iv_input_dob_match_level in ['5'])                                    => 0.08773873,
																							N172_8));

	N172_6 :=__common__( if(((real)c_hh6_p < 4.64999961853), N172_7, -0.0050817842));

	N172_5 :=__common__( if(trim(C_HH6_P) != '', N172_6, 0.0088210334));

	N172_4 :=__common__( map((iv_vp091_phnzip_mismatch in ['0']) => -0.0010715835,
				  (iv_vp091_phnzip_mismatch in ['1']) => 0.015048557,
														 -0.0010715835));

	N172_3 :=__common__( map(((real)iv_src_liens_adl_count <= NULL) => 0.01335741,
				  ((real)iv_src_liens_adl_count < 6.5)   => N172_4,
															0.01335741));

	N172_2 :=__common__( if(((real)nf_fp_srchcountwk < 0.5), N172_3, N172_5));

	N172_1 :=__common__( if(((real)nf_fp_srchcountwk > NULL), N172_2, 0.00098815398));

	N173_7 :=__common__( if(((real)iv_sr001_source_profile < 35.5499992371), 0.0060692097, 0.00084897634));

	N173_6 :=__common__( if(((real)iv_sr001_source_profile > NULL), N173_7, -0.0019037478));

	N173_5 :=__common__( if(((real)c_pop_85p_p < 1.65000009537), N173_6, -0.0027044486));

	N173_4 :=__common__( if(trim(C_POP_85P_P) != '', N173_5, -0.00026983401));

	N173_3 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['1-3', '3-2', '3-3', '4-2', '4-3', '5-2', '5-3'])                             => -0.035087437,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '2-3', '3-1', '4-1', '5-1']) => -0.0020106938,
																																	 -0.0020106938));

	N173_2 :=__common__( map((iv_criminal_x_felony in ['1-0', '1-1', '2-2', '3-1'])               => -0.019760459,
				  (iv_criminal_x_felony in ['0-0', '2-0', '2-1', '3-0', '3-2', '3-3']) => N173_3,
																						  N173_3));

	N173_1 :=__common__( map((nf_fp_varrisktype in ['7', '8', '9'])                      => N173_2,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6']) => N173_4,
																				 N173_4));

	N174_8 :=__common__( map(((real)nf_fp_srchfraudsrchcountmo <= NULL) => -0.0063264837,
				  ((real)nf_fp_srchfraudsrchcountmo < 0.5)   => -0.00045610227,
																-0.0063264837));

	N174_7 :=__common__( map(trim(C_NEWHOUSE) = ''              => 0.01096763,
				  ((real)c_newhouse < 98.3500061035) => N174_8,
														0.01096763));

	N174_6 :=__common__( map(trim(C_POP_12_17_P) = ''              => 0.0035317756,
				  ((real)c_pop_12_17_p < 5.44999980927) => -0.0031836298,
														   0.0035317756));

	N174_5 :=__common__( map(((real)iv_ssns_per_addr_c6 <= NULL) => 0.011761031,
				  ((real)iv_ssns_per_addr_c6 < 2.5)   => N174_6,
														 0.011761031));

	N174_4 :=__common__( if(((real)c_hh6_p < 1.65000009537), N174_5, N174_7));

	N174_3 :=__common__( if(trim(C_HH6_P) != '', N174_4, 0.0060273053));

	N174_2 :=__common__( if(((real)iv_attr_purchase_recency < 0.5), N174_3, -0.0050204995));

	N174_1 :=__common__( if(((real)iv_attr_purchase_recency > NULL), N174_2, 0.00079845492));

	N175_8 :=__common__( map((iv_ed001_college_ind_29 in ['0']) => 0.0087700221,
				  (iv_ed001_college_ind_29 in ['1']) => 0.092473276,
														0.0087700221));

	N175_7 :=__common__( map(trim(C_REST_INDX) = ''     => 0.00062412618,
				  ((real)c_rest_indx < 65.5) => N175_8,
												0.00062412618));

	N175_6 :=__common__( map(((real)iv_sr001_source_profile <= NULL) => -0.0018828633,
				  ((real)iv_sr001_source_profile < 35.25) => 0.0030522148,
															 -0.0018828633));

	N175_5 :=__common__( map(trim(C_RAPE) = ''     => N175_6,
				  ((real)c_rape < 32.5) => -0.0083142981,
										   N175_6));

	N175_4 :=__common__( if(((real)iv_addrs_per_adl < 15.5), N175_5, N175_7));

	N175_3 :=__common__( if(((real)iv_addrs_per_adl > NULL), N175_4, -0.0043977376));

	N175_2 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N175_3,
				  (iv_vs002_ssn_prior_dob in ['1']) => 0.01784376,
													   0.01784376));

	N175_1 :=__common__( if(trim(C_WORK_HOME) != '', N175_2, 0.003234914));

	N176_8 :=__common__( map(((real)iv_adls_per_addr <= NULL) => -0.0066633022,
				  ((real)iv_adls_per_addr < 11.5)  => 0.010364707,
													  -0.0066633022));

	N176_7 :=__common__( if(((real)iv_mos_since_gong_did_fst_seen < 100.5), -0.0068557836, N176_8));

	N176_6 :=__common__( if(((real)iv_mos_since_gong_did_fst_seen > NULL), N176_7, -0.0035679344));

	N176_5 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '10', '15', '25'])     => N176_6,
				  (iv_bst_addr_mortgage_term in ['0', '20', '30', '40', '5']) => 0.0083537082,
																				 N176_6));

	N176_4 :=__common__( map((iv_ams_college_major in ['Business', 'Liberal Arts', 'No AMS Found', 'No College Found', 'Unclassified']) => N176_5,
				  (iv_ams_college_major in ['Medical', 'Science'])                                                           => 0.055229838,
																																N176_5));

	N176_3 :=__common__( map((nf_fp_varrisktype in ['-1', '4', '5', '7', '8']) => N176_4,
				  (nf_fp_varrisktype in ['1', '2', '3', '6', '9'])  => 0.0019702763,
																	   N176_4));

	N176_2 :=__common__( if(((real)c_old_homes < 155.5), N176_3, -0.0045433449));

	N176_1 :=__common__( if(trim(C_OLD_HOMES) != '', N176_2, 0.0050642431));

	N177_9 :=__common__( if(((real)iv_inq_lnames_per_addr < 1.5), 0.0014218246, 0.0058691582));

	N177_8 :=__common__( if(((real)iv_inq_lnames_per_addr > NULL), N177_9, 0.056562997));

	N177_7 :=__common__( map(trim(C_LOW_ED) = ''              => -0.010430935,
				  ((real)c_low_ed < 37.1500015259) => 0.0052694587,
													  -0.010430935));

	N177_6 :=__common__( if(((real)c_rape < 34.5), N177_7, N177_8));

	N177_5 :=__common__( if(trim(C_RAPE) != '', N177_6, -0.0016298603));

	N177_4 :=__common__( map(((real)nf_average_rel_criminal_dist <= NULL) => -0.0034274122,
				  ((real)nf_average_rel_criminal_dist < 502.5) => N177_5,
																  -0.0034274122));

	N177_3 :=__common__( map(((real)iv_src_property_adl_count <= NULL) => -0.0053048318,
				  ((real)iv_src_property_adl_count < 3.5)   => N177_4,
															   -0.0053048318));

	N177_2 :=__common__( if(((real)iv_criminal_count < 10.5), N177_3, 0.011255369));

	N177_1 :=__common__( if(((real)iv_criminal_count > NULL), N177_2, 0.0018786956));

	N178_8 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '4 Invalid', '5 Cell', '6 Pager', '7 PCS']) => -0.0074266449,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '8 Pay_Phone'])                                    => 0.030044262,
																													  -0.0074266449));

	N178_7 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => 0.0091017306,
				  (iv_va100_add_problem in ['03 Standarization Error', '06 Invalid Address', '07 Busines', '13 Vacant'])                                                                                                                                  => 0.040431395,
																																																															 0.0091017306));

	N178_6 :=__common__( map(((real)nf_fp_corraddrnamecount <= NULL) => 0.0002213917,
				  ((real)nf_fp_corraddrnamecount < 3.5)   => -0.0055164615,
															 0.0002213917));

	N178_5 :=__common__( map(((real)nf_fp_corrssnaddrcount <= NULL) => N178_6,
				  ((real)nf_fp_corrssnaddrcount < 2.5)   => 0.002846033,
															N178_6));

	N178_4 :=__common__( if(trim(C_RAPE) != '', N178_5, -0.0057487437));

	N178_3 :=__common__( map(((real)iv_mos_src_voter_adl_lseen <= NULL) => N178_7,
				  ((integer)iv_mos_src_voter_adl_lseen < 49) => N178_4,
																N178_7));

	N178_2 :=__common__( if(((real)iv_vo_addrs_per_adl < 2.5), N178_3, N178_8));

	N178_1 :=__common__( if(((real)iv_vo_addrs_per_adl > NULL), N178_2, 0.006770888));

	N179_6 :=__common__( map((nf_fp_componentcharrisktype in ['1', '7', '8'])                => -0.015506996,
				  (nf_fp_componentcharrisktype in ['2', '3', '4', '5', '6', '9']) => 0.013236945,
																					 0.013236945));

	N179_5 :=__common__( map(((real)iv_avg_num_sources_per_addr <= NULL) => -2.4871226e-005,
				  ((real)iv_avg_num_sources_per_addr < 3.5)   => N179_6,
																 -2.4871226e-005));

	N179_4 :=__common__( map(((real)nf_fp_prevaddrcrimeindex <= NULL) => 0.0093612699,
				  ((real)nf_fp_prevaddrcrimeindex < 194.5) => -0.00090170004,
															  0.0093612699));

	N179_3 :=__common__( if(((real)iv_hist_addr_match < 4.5), N179_4, N179_5));

	N179_2 :=__common__( if(((real)iv_hist_addr_match > NULL), N179_3, -0.0013998255));

	N179_1 :=__common__( map((iv_va001_add_po_box in ['1']) => -0.012565713,
				  (iv_va001_add_po_box in ['0']) => N179_2,
													N179_2));

	N180_8 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '4 Invalid', '5 Cell', '7 PCS', '8 Pay_Phone']) => 0.0064540247,
				  (iv_vp100_phn_prob in ['2 Disconnected', '6 Pager'])                                                      => 0.11982666,
																															   0.0064540247));

	N180_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '8']) => N180_8,
				  (nf_fp_varrisktype in ['5', '6', '7', '9'])            => 0.01603788,
																			N180_8));

	N180_6 :=__common__( if(((real)c_murders < 137.5), 0.00055295171, N180_7));

	N180_5 :=__common__( if(trim(C_MURDERS) != '', N180_6, 0.01517068));

	N180_4 :=__common__( map((iv_prv_addr_ownership_lvl in ['Applicant', 'Family', 'No Ownership']) => -0.00037477379,
				  (iv_prv_addr_ownership_lvl in ['Occupant'])                            => N180_5,
																							-0.00037477379));

	N180_3 :=__common__( map(((real)nf_fp_assoccredbureaucountnew <= NULL) => 0.0098351975,
				  ((real)nf_fp_assoccredbureaucountnew < 0.5)   => N180_4,
																   0.0098351975));

	N180_2 :=__common__( if(((real)iv_inq_auto_count12 < 1.5), N180_3, -0.0063966818));

	N180_1 :=__common__( if(((real)iv_inq_auto_count12 > NULL), N180_2, 0.0024523984));

	N181_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2']) => -0.0066341754,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '5-3'])                                                                                                   => 0.24050058,
																																										-0.0066341754));

	N181_5 :=__common__( map((iv_in001_college_income in ['-1', 'E', 'F', 'J', 'K'])          => -0.01255446,
				  (iv_in001_college_income in ['A', 'B', 'C', 'D', 'G', 'H', 'I']) => 0.039264667,
																					  0.039264667));

	N181_4 :=__common__( if(((real)iv_age_at_low_issue < 18.5), 0.0011916379, N181_5));

	N181_3 :=__common__( if(((real)iv_age_at_low_issue > NULL), N181_4, -7.2165451e-005));

	N181_2 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '4 Invalid', '5 Cell', '7 PCS']) => N181_3,
				  (iv_vp100_phn_prob in ['6 Pager', '8 Pay_Phone'])                                                            => 0.05257802,
																																  N181_3));

	N181_1 :=__common__( map(((real)iv_ag001_age <= NULL) => N181_6,
				  ((real)iv_ag001_age < 55.5)  => N181_2,
												  N181_6));

	N182_7 :=__common__( map((iv_cvi in [10, 20, 30, 40, 50]) => 0.00035490952,
				  (iv_cvi in [0])                         => 0.017758747,
																0.00035490952));

	N182_6 :=__common__( map((iv_prof_license_category in ['1', '2', '4', '5']) => -0.011657457,
				  (iv_prof_license_category in ['-1', '0', '3'])     => N182_7,
																		N182_7));

	N182_5 :=__common__( map(trim(C_EASIQLIFE) = ''     => N182_6,
				  ((real)c_easiqlife < 69.5) => -0.0049644087,
												N182_6));

	N182_4 :=__common__( map((nf_fp_corrrisktype in ['4', '5', '6', '7'])      => 0.00027463707,
				  (nf_fp_corrrisktype in ['1', '2', '3', '8', '9']) => 0.019307174,
																	   0.019307174));

	N182_3 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '3', '5', '9']) => 0.00048553412,
				  (nf_fp_varrisktype in ['2', '4', '6', '7', '8'])  => N182_4,
																	   0.00048553412));

	N182_2 :=__common__( if(((real)c_cpiall < 203.600006104), N182_3, N182_5));

	N182_1 :=__common__( if(trim(C_CPIALL) != '', N182_2, -0.0034673193));

	N183_7 :=__common__( map(trim(C_HH5_P) = ''              => 0.022278596,
				  ((real)c_hh5_p < 10.5500001907) => 0.0049487448,
													 0.022278596));

	N183_6 :=__common__( map(trim(C_INC_75K_P) = ''              => N183_7,
				  ((real)c_inc_75k_p < 13.5500001907) => -0.0053331406,
														 N183_7));

	N183_5 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '103', '104', '105', '106', '108', '109', '110', '111', '112']) => N183_6,
				  (iv_phnpop_x_nap_summary in ['101', '102', '107'])                                                                                     => 0.11044318,
																																							N183_6));

	N183_4 :=__common__( map(trim(C_BLUE_COL) = ''      => -0.009876669,
				  ((real)c_blue_col < 25.75) => 0.00031357496,
												-0.009876669));

	N183_3 :=__common__( map((iv_prof_license_category in ['1', '2', '4', '5']) => -0.010074736,
				  (iv_prof_license_category in ['-1', '0', '3'])     => N183_4,
																		-0.010074736));

	N183_2 :=__common__( if(((real)c_asian_lang < 183.5), N183_3, N183_5));

	N183_1 :=__common__( if(trim(C_ASIAN_LANG) != '', N183_2, 0.00020523677));

	N184_8 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-3', '2-0', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => -0.0018994275,
				  (iv_paw_dead_bus_x_active_phn in ['0-3', '1-1', '1-2', '2-1'])                                                         => 0.088136708,
																																			-0.0018994275));

	N184_7 :=__common__( map((nf_adl_util_convenience in ['0']) => -0.013129479,
				  (nf_adl_util_convenience in ['1']) => N184_8,
														N184_8));

	N184_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '2-3', '3-1', '3-2', '4-1', '4-3']) => 0.00069073615,
				  (iv_gong_did_fname_x_lname_ct in ['1-2', '2-2', '3-3', '4-2', '5-1', '5-2', '5-3'])                             => 0.0072874554,
																																	 0.00069073615));

	N184_5 :=__common__( if(((integer)iv_inp_addr_address_score < 11), -0.0099300367, N184_6));

	N184_4 :=__common__( if(((real)iv_inp_addr_address_score > NULL), N184_5, 0.0069041573));

	N184_3 :=__common__( map((iv_infutor_nap in ['10', '4', '6'])                 => -0.011069101,
				  (iv_infutor_nap in ['0', '1', '11', '12', '7', '9']) => N184_4,
																		  N184_4));

	N184_2 :=__common__( if(((real)nf_fp_prevaddrburglaryindex < 186.5), N184_3, N184_7));

	N184_1 :=__common__( if(((real)nf_fp_prevaddrburglaryindex > NULL), N184_2, 0.0010994417));

	N185_9 :=__common__( if(((real)c_lowinc < 29.6500015259), 0.011041992, -0.0040832515));

	N185_8 :=__common__( if(trim(C_LOWINC) != '', N185_9, 0.031109384));

	N185_7 :=__common__( map(((real)iv_pv001_inp_avm_autoval <= NULL)    => N185_8,
				  ((integer)iv_pv001_inp_avm_autoval < 37619) => 0.016914368,
																 N185_8));

	N185_6 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '2 Weekly', '3 Monthly', '4 Semi-monthly', '5 Quarterly']) => -0.0029750312,
				  (iv_pb_order_freq in ['0 No Purch Data', '6 Semi-yearly', '7 Yearly', '8 Rarely'])                   => N185_7,
																														  -0.0029750312));

	N185_5 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N185_6, 0.0027546325));

	N185_4 :=__common__( map(((real)iv_ssns_per_sfd_addr <= NULL) => -0.001744385,
				  ((real)iv_ssns_per_sfd_addr < 21.5)  => N185_5,
														  -0.001744385));

	N185_3 :=__common__( map(((real)iv_mos_src_voter_adl_lseen <= NULL) => 0.014021927,
				  ((real)iv_mos_src_voter_adl_lseen < 51.5)  => N185_4,
																0.014021927));

	N185_2 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['00', '02', '04', '10', '12', '13', '14']) => -0.0013717839,
				  (iv_inp_own_prop_x_addr_naprop in ['01', '03', '11'])                         => N185_3,
																								   -0.0013717839));

	N185_1 :=__common__( if(((real)iv_mos_src_voter_adl_lseen > NULL), N185_2, 0.001317222));

	N186_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '6', '7', '8']) => 0.0044649546,
				  (nf_fp_varrisktype in ['3', '4', '5', '9'])            => 0.014437432,
																			0.0044649546));

	N186_6 :=__common__( map(((real)iv_src_bureau_ssn_count <= NULL) => -0.0057222675,
				  ((real)iv_src_bureau_ssn_count < 89.5)  => N186_7,
															 -0.0057222675));

	N186_5 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-2']) => -0.0045680506,
				  (iv_liens_unrel_x_rel in ['3-0', '3-1'])                                                         => 0.0037748149,
																													  -0.0045680506));

	N186_4 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '3', '4', '6', '7', '8']) => -0.00099344049,
				  (nf_fp_varrisktype in ['2', '5', '9'])                      => 0.0047755756,
																				 -0.00099344049));

	N186_3 :=__common__( map(((real)iv_lnames_per_adl <= NULL) => N186_5,
				  ((real)iv_lnames_per_adl < 2.5)   => N186_4,
													   N186_5));

	N186_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 2.5), N186_3, N186_6));

	N186_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N186_2, 0.003567011));

	N187_6 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '8']) => 0.010885331,
				  (nf_fp_varrisktype in ['7', '9'])                                => 0.033222032,
																					  0.010885331));

	N187_5 :=__common__( map(((real)iv_invalid_addrs_per_adl <= NULL) => -0.0038899352,
				  ((real)iv_invalid_addrs_per_adl < 1.5)   => 0.007081208,
															  -0.0038899352));

	N187_4 :=__common__( if(((integer)nf_fp_addrchangeincomediff < 2690), N187_5, N187_6));

	N187_3 :=__common__( if(((real)nf_fp_addrchangeincomediff > NULL), N187_4, 0.00095007111));

	N187_2 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '106', '107', '108', '110', '111', '112']) => N187_3,
				  (iv_phnpop_x_nap_summary in ['109'])                                                                                                                 => 0.17103863,
																																										  N187_3));

	N187_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => N187_2,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => -0.0011223133,
															   N187_2));

	N188_7 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '0', '15', '20', '30', '40']) => 0.008696779,
				  (iv_prv_addr_mortgage_term in ['10', '25', '5'])                   => 0.11759889,
																						0.008696779));

	N188_6 :=__common__( map((nf_fp_varrisktype in ['6', '8'])                                => -0.018933575,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '7', '9']) => N188_7,
																					  N188_7));

	N188_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N188_6,
				  (nf_fp_divrisktype in ['7', '9'])                          => 0.066093665,
																				N188_6));

	N188_4 :=__common__( map((nf_fp_corrrisktype in ['2', '3', '4', '5', '6', '7', '8']) => -0.00050882283,
				  (nf_fp_corrrisktype in ['1', '9'])                          => 0.0047691188,
																				 -0.00050882283));

	N188_3 :=__common__( map(((real)iv_dist_inp_addr_to_prv_addr <= NULL) => N188_4,
				  ((real)iv_dist_inp_addr_to_prv_addr < 0.5)   => -0.0035350796,
																  N188_4));

	N188_2 :=__common__( if(((real)iv_ms001_ssns_per_adl < 3.5), N188_3, N188_5));

	N188_1 :=__common__( if(((real)iv_ms001_ssns_per_adl > NULL), N188_2, -0.0017221143));

	N189_7 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12]) => -0.00094156713,
				  (iv_nas_summary in [1])                                                             => 0.062827015,
																											-0.00094156713));

	N189_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-1', '3-0', '3-1', '3-3']) => 0.0094721284,
				  (iv_criminal_x_felony in ['1-0', '2-0', '2-1', '2-2', '3-2']) => 0.031945997,
																				   0.031945997));

	N189_5 :=__common__( map(((real)iv_inq_other_count12 <= NULL) => N189_6,
				  ((real)iv_inq_other_count12 < 0.5)   => 0.0049520616,
														  N189_6));

	N189_4 :=__common__( map(((real)nf_fp_corraddrphonecount <= NULL) => -0.0033691921,
				  ((real)nf_fp_corraddrphonecount < 0.5)   => N189_5,
															  -0.0033691921));

	N189_3 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0056069627,
				  ((real)iv_inq_auto_recency < 0.5)   => N189_4,
														 -0.0056069627));

	N189_2 :=__common__( if(((real)iv_email_count < 0.5), N189_3, N189_7));

	N189_1 :=__common__( if(((real)iv_email_count > NULL), N189_2, 0.00093554698));

	N190_6 :=__common__( map(trim(C_RETIRED) = ''              => -0.0051594001,
				  ((real)c_retired < 8.35000038147) => 0.0072239166,
													   -0.0051594001));

	N190_5 :=__common__( map(trim(C_REST_INDX) = ''     => N190_6,
				  ((real)c_rest_indx < 72.5) => 0.012052336,
												N190_6));

	N190_4 :=__common__( if(((real)c_popover25 < 625.5), 0.012722109, N190_5));

	N190_3 :=__common__( if(trim(C_POPOVER25) != '', N190_4, -0.0055934853));

	N190_2 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '2-3'])                                    => -0.0037921085,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '1-0', '1-1', '1-3', '2-0', '2-1', '3-0', '3-1', '3-3']) => 0.00046077252,
																													   -0.0037921085));

	N190_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => N190_3,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => N190_2,
															   N190_3));

	N191_9 :=__common__( map((nf_fp_varrisktype in ['3', '5', '6', '7', '8'])  => -0.01294571,
				  (nf_fp_varrisktype in ['-1', '1', '2', '4', '9']) => -0.0031614274,
																	   -0.0031614274));

	N191_8 :=__common__( if(trim(C_RNT1250_P) != '', N191_9, -0.00054927182));

	N191_7 :=__common__( if(((real)c_asian_lang < 184.5), -0.00069864003, 0.0067648254));

	N191_6 :=__common__( if(trim(C_ASIAN_LANG) != '', N191_7, -0.0028765686));

	N191_5 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)    => 0.015872654,
				  ((integer)nf_fp_curraddrmedianincome < 18100) => 0.0036119966,
																   0.015872654));

	N191_4 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['02', '04', '10', '12', '13', '14']) => -0.011386141,
				  (iv_prv_own_prop_x_addr_naprop in ['00', '01', '03', '11'])             => N191_5,
																							 -0.011386141));

	N191_3 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)   => N191_6,
				  ((real)nf_fp_curraddrmedianincome < 23102.5) => N191_4,
																  N191_6));

	N191_2 :=__common__( if(((real)iv_dist_bst_addr_to_prv_addr < 719.5), N191_3, N191_8));

	N191_1 :=__common__( if(((real)iv_dist_bst_addr_to_prv_addr > NULL), N191_2, 0.0010002731));

	N192_8 :=__common__( map((iv_infutor_nap in ['0', '1', '10', '12', '4', '6', '9']) => 0.011228594,
				  (iv_infutor_nap in ['11', '7'])                           => 0.056503986,
																			   0.056503986));

	N192_7 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'K']) => N192_8,
				  (iv_in001_college_income in ['H', 'J'])                                          => 0.18076666,
																									  N192_8));

	N192_6 :=__common__( map(((real)nf_fp_varmsrcssncount <= NULL) => N192_7,
				  ((real)nf_fp_varmsrcssncount < 1.5)   => 0.0038270665,
														   N192_7));

	N192_5 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => -0.0062058882,
				  ((real)iv_inq_auto_recency < 0.5)   => N192_6,
														 -0.0062058882));

	N192_4 :=__common__( if(((real)iv_email_count < 0.5), N192_5, -0.00086863888));

	N192_3 :=__common__( if(((real)iv_email_count > NULL), N192_4, 0.0033512623));

	N192_2 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2']) => N192_3,
				  (iv_gong_did_fname_x_lname_ct in ['5-3'])                                                                                                                 => 0.12750656,
																																											   N192_3));

	N192_1 :=__common__( if(((real)iv_bst_addr_mtg_avm_abs_diff > NULL), -0.0011929381, N192_2));

	N193_6 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '0', '10', '30', '5']) => 0.0065169117,
				  (iv_bst_addr_mortgage_term in ['15', '20', '25', '40'])     => 0.038323956,
																				 0.038323956));

	N193_5 :=__common__( map((iv_pb_order_freq in ['5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely'])                           => -0.012615905,
				  (iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '2 Weekly', '3 Monthly', '4 Semi-monthly']) => N193_6,
																															  N193_6));

	N193_4 :=__common__( if(((real)c_hval_100k_p < 30.0499992371), -0.00051703681, N193_5));

	N193_3 :=__common__( if(trim(C_HVAL_100K_P) != '', N193_4, -0.0022855762));

	N193_2 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.008914918,
				  (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-1'])                                    => 0.0037075055,
																													   -0.008914918));

	N193_1 :=__common__( map((nf_fp_varrisktype in ['-1', '6', '7'])                    => N193_2,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '8', '9']) => N193_3,
																				N193_3));

	N194_9 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '0', '10', '15', '25', '30', '40']) => -0.0010627526,
				  (iv_bst_addr_mortgage_term in ['20', '5'])                               => 0.14618201,
																							  -0.0010627526));

	N194_8 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-2', '1-1', '1-2', '2-0', '2-2', '3-0']) => -0.010610094,
				  (iv_liens_unrel_x_rel in ['0-1', '1-0', '2-1', '3-1', '3-2'])               => 0.0036438884,
																								 -0.010610094));

	N194_7 :=__common__( if(((real)nf_fp_srchphonesrchcountmo < 2.5), -0.00057447093, 0.0086205488));

	N194_6 :=__common__( if(((real)nf_fp_srchphonesrchcountmo > NULL), N194_7, 0.002205307));

	N194_5 :=__common__( if(((real)iv_mos_since_infutor_first_seen < 77.5), N194_6, N194_8));

	N194_4 :=__common__( if(((real)iv_mos_since_infutor_first_seen > NULL), N194_5, N194_9));

	N194_3 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '5 Cell', '7 PCS'])                                                  => N194_4,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '2 Disconnected', '4 Invalid', '6 Pager', '8 Pay_Phone']) => 0.0086858541,
																															 N194_4));

	N194_2 :=__common__( if(((integer)iv_bst_addr_mtg_avm_abs_diff < -76969), 0.012208786, -0.0018139613));

	N194_1 :=__common__( if(((real)iv_bst_addr_mtg_avm_abs_diff > NULL), N194_2, N194_3));

	N195_7 :=__common__( if(((real)iv_addrs_per_adl < 11.5), -0.00019566357, 0.0064192814));

	N195_6 :=__common__( if(((real)iv_addrs_per_adl > NULL), N195_7, 0.012063063));

	N195_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2']) => N195_6,
				  (iv_gong_did_fname_x_lname_ct in ['5-3'])                                                                                                                 => 0.10353159,
																																											   N195_6));

	N195_4 :=__common__( if(((real)c_retail < 2.34999990463), N195_5, -0.0012240374));

	N195_3 :=__common__( if(trim(C_RETAIL) != '', N195_4, 0.0089367726));

	N195_2 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'H', 'M', 'P', 'R', 'S', 'U']) => -0.0063084108,
				  (nf_fp_prevaddrdwelltype in ['G'])                                     => 0.22973071,
																							-0.0063084108));

	N195_1 :=__common__( map((iv_inp_addr_mortgage_type in ['Equity Loan', 'Government', 'High-Risk', 'Non-Traditional'])                  => N195_2,
				  (iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'No Mortgage', 'Other', 'Piggyback', 'Unknown']) => N195_3,
																																   N195_2));

	N196_5 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '4', '5', '6', '9']) => -0.00078809774,
				  (nf_fp_sourcerisktype in ['3', '7', '8'])                => 0.0026314049,
																			  -0.00078809774));

	N196_4 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '7', '8']) => N196_5,
				  (nf_fp_divrisktype in ['6', '9'])                          => 0.016077721,
																				N196_5));

	N196_3 :=__common__( map((iv_vp091_phnzip_mismatch in ['0']) => N196_4,
				  (iv_vp091_phnzip_mismatch in ['1']) => 0.017292753,
														 N196_4));

	N196_2 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112']) => -0.0070309266,
				  (iv_phnpop_x_nap_summary in ['101'])                                                                                                                 => 0.10730894,
																																										  -0.0070309266));

	N196_1 :=__common__( map((iv_pb_order_freq in ['6 Semi-yearly', '7 Yearly', '8 Rarely'])                                                         => N196_2,
				  (iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '2 Weekly', '3 Monthly', '4 Semi-monthly', '5 Quarterly']) => N196_3,
																																			 N196_3));

	N197_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => 0.006114353,
				  (iv_va100_add_problem in ['03 Standarization Error', '13 Vacant'])                                                                                                                                                                                                          => 0.060495388,
																																																																								 0.006114353));

	N197_5 :=__common__( map(trim(C_POP_18_24_P) = ''              => -0.0017113702,
				  ((real)c_pop_18_24_p < 5.94999980927) => N197_6,
														   -0.0017113702));

	N197_4 :=__common__( if(((real)c_construction < 21.9500007629), N197_5, 0.011209204));

	N197_3 :=__common__( if(trim(C_CONSTRUCTION) != '', N197_4, -0.0047853822));

	N197_2 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'D', 'E', 'F', 'H', 'I', 'J']) => N197_3,
				  (iv_in001_college_income in ['C', 'G', 'K'])                                => 0.018168975,
																								 N197_3));

	N197_1 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => N197_2,
				  ((real)iv_inq_per_ssn < 4.5)   => -0.001061749,
													N197_2));

	N198_8 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '3-0', '3-3']) => 0.0010144736,
				  (iv_paw_dead_bus_x_active_phn in ['2-3', '3-1', '3-2'])                                                                       => 0.055074643,
																																				   0.0010144736));

	N198_7 :=__common__( if(((real)iv_inq_collection_count12 < 2.5), N198_8, 0.01138028));

	N198_6 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N198_7, -0.0014319833));

	N198_5 :=__common__( map(((real)iv_all_email_domain_free <= NULL) => 0.0095577891,
				  ((real)iv_all_email_domain_free < 1.5)   => -0.0025548009,
															  0.0095577891));

	N198_4 :=__common__( map((nf_fp_sourcerisktype in ['4', '8'])                          => -0.0093217594,
				  (nf_fp_sourcerisktype in ['1', '2', '3', '5', '6', '7', '9']) => N198_5,
																				   -0.0093217594));

	N198_3 :=__common__( map((iv_dwelltype in ['GEN', 'MFD', 'POB', 'SFD']) => N198_4,
				  (iv_dwelltype in ['RR'])                       => 0.12267806,
																	0.12267806));

	N198_2 :=__common__( if(((real)c_easiqlife < 84.5), N198_3, N198_6));

	N198_1 :=__common__( if(trim(C_EASIQLIFE) != '', N198_2, -0.0029345241));

	N199_8 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => -0.0084034821,
				  (nf_fp_idverrisktype in ['8'])                                    => 0.086416866,
																					   -0.0084034821));

	N199_7 :=__common__( map(trim(C_MED_HVAL) = ''         => N199_8,
				  ((real)c_med_hval < 158103.5) => 0.0055523308,
												   N199_8));

	N199_6 :=__common__( map(trim(C_MEDI_INDX) = ''     => N199_7,
				  ((real)c_medi_indx < 99.5) => 0.0083522887,
												N199_7));

	N199_5 :=__common__( if(((real)c_highinc < 1.25), -0.0060719237, N199_6));

	N199_4 :=__common__( if(trim(C_HIGHINC) != '', N199_5, -0.0079464541));

	N199_3 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => N199_4,
				  (iv_in001_college_income in ['E'])                                                    => 0.020353173,
																										   N199_4));

	N199_2 :=__common__( if(((real)iv_inq_collection_count12 < 0.5), -0.0012485902, N199_3));

	N199_1 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N199_2, -0.0070610299));

	N200_7 :=__common__( map((nf_fp_corrrisktype in ['3', '4', '5', '6', '7']) => 0.0034153199,
				  (nf_fp_corrrisktype in ['1', '2', '8', '9'])      => 0.018260216,
																	   0.0034153199));

	N200_6 :=__common__( map(((real)iv_inq_other_count12 <= NULL) => N200_7,
				  ((real)iv_inq_other_count12 < 0.5)   => 0.00050938885,
														  N200_7));

	N200_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-1', '3-2']) => N200_6,
				  (iv_criminal_x_felony in ['2-1', '3-3'])                                           => 0.027800831,
																										N200_6));

	N200_4 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2']) => -0.00010593033,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '5-3'])                                                                                                   => 0.087810695,
																																										-0.00010593033));

	N200_3 :=__common__( map(((real)nf_fp_srchunvrfddobcount <= NULL) => -0.0056838589,
				  ((real)nf_fp_srchunvrfddobcount < 0.5)   => N200_4,
															  -0.0056838589));

	N200_2 :=__common__( if(((real)nf_highest_rel_income < 112.5), N200_3, N200_5));

	N200_1 :=__common__( if(((real)nf_highest_rel_income > NULL), N200_2, -0.0034572145));

	N201_5 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '2 Disconnected', '5 Cell', '6 Pager', '7 PCS']) => 0.01216364,
				  (iv_vp100_phn_prob in ['1 HiRisk', '4 Invalid', '8 Pay_Phone'])                                => 0.075017124,
																													0.01216364));

	N201_4 :=__common__( map((iv_in001_college_income in ['A', 'D', 'F', 'G'])                      => -0.010903646,
				  (iv_in001_college_income in ['-1', 'B', 'C', 'E', 'H', 'I', 'J', 'K']) => 0.0042144423,
																							0.0042144423));

	N201_3 :=__common__( map(((real)nf_fp_addrchangeincomediff <= NULL)  => N201_5,
				  ((real)nf_fp_addrchangeincomediff < 1437.5) => N201_4,
																 N201_5));

	N201_2 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)   => -0.00048637856,
				  ((real)nf_fp_curraddrmedianincome < 38601.5) => N201_3,
																  -0.00048637856));

	N201_1 :=__common__( map((iv_ed001_college_ind_50 in ['1']) => -0.0036698764,
				  (iv_ed001_college_ind_50 in ['0']) => N201_2,
														-0.0036698764));

	N202_8 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '13 Vacant']) => 0.0081331838,
				  (iv_va100_add_problem in ['04 HiRisk Commercial', '11 Throw Back', '12 College'])                                                                                                                                                                            => 0.17082685,
																																																																				  0.0081331838));

	N202_7 :=__common__( map(trim(C_HVAL_400K_P) = ''              => N202_8,
				  ((real)c_hval_400k_p < 27.5499992371) => -0.0022422996,
														   N202_8));

	N202_6 :=__common__( map(((real)iv_adls_per_addr_c6 <= NULL) => 0.0039046286,
				  ((real)iv_adls_per_addr_c6 < 0.5)   => -0.0013979124,
														 0.0039046286));

	N202_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-2', '3-0', '3-2']) => N202_6,
				  (iv_criminal_x_felony in ['2-1', '3-1', '3-3'])                             => 0.010763626,
																								 N202_6));

	N202_4 :=__common__( if(((real)c_inc_50k_p < 14.4499998093), N202_5, N202_7));

	N202_3 :=__common__( if(trim(C_INC_50K_P) != '', N202_4, -0.00095445372));

	N202_2 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk < 1.5), N202_3, 0.0081711753));

	N202_1 :=__common__( if(((real)nf_fp_srchaddrsrchcountwk > NULL), N202_2, -0.0028600537));

	N203_7 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '101', '102', '103', '105', '106', '108', '109', '111', '112']) => 0.0037246642,
				  (iv_phnpop_x_nap_summary in ['003', '104', '107', '110'])                                                                       => 0.059292162,
																																					 0.0037246642));

	N203_6 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N203_7,
				  (nf_fp_divrisktype in ['8'])                                    => 0.063433573,
																					 N203_7));

	N203_5 :=__common__( map(((real)nf_fp_srchphonesrchcountmo <= NULL) => 0.0083384992,
				  ((real)nf_fp_srchphonesrchcountmo < 1.5)   => -0.0013584012,
																0.0083384992));

	N203_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '2-1', '2-2', '3-2']) => N203_5,
				  (iv_liens_unrel_x_rel in ['1-0', '1-1', '1-2', '2-0', '3-0', '3-1']) => N203_6,
																						  N203_6));

	N203_3 :=__common__( map((nf_fp_divrisktype in ['5', '6', '7', '8', '9']) => -0.016032835,
				  (nf_fp_divrisktype in ['1', '2', '3', '4'])      => -0.0023195055,
																	  -0.016032835));

	N203_2 :=__common__( if(((real)c_easiqlife < 87.5), N203_3, N203_4));

	N203_1 :=__common__( if(trim(C_EASIQLIFE) != '', N203_2, -0.0064886968));

	N204_7 :=__common__( map(((real)nf_average_rel_distance <= NULL) => -0.0075576964,
				  ((real)nf_average_rel_distance < 133.5) => 0.0048275429,
															 -0.0075576964));

	N204_6 :=__common__( map((nf_fp_varrisktype in ['-1', '5', '6', '7', '8']) => -0.012294714,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '9'])  => -0.0012459884,
																	   -0.0012459884));

	N204_5 :=__common__( map(trim(C_EASIQLIFE) = ''     => 0.0018331692,
				  ((real)c_easiqlife < 66.5) => N204_6,
												0.0018331692));

	N204_4 :=__common__( if(((integer)nf_accident_recency < 48), N204_5, N204_7));

	N204_3 :=__common__( if(((real)nf_accident_recency > NULL), N204_4, -0.006237473));

	N204_2 :=__common__( if(trim(C_EASIQLIFE) != '', N204_3, -0.00053277117));

	N204_1 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12]) => N204_2,
				  (iv_nas_summary in [1])                                                             => 0.031935357,
																											N204_2));

	N205_8 :=__common__( map((nf_fp_varrisktype in ['-1', '5', '8'])                    => -0.010193261,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '6', '7', '9']) => 0.0080464099,
																				0.0080464099));

	N205_7 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'H', 'J', 'K']) => N205_8,
				  (iv_in001_college_income in ['G', 'I'])                                          => 0.052331564,
																									  N205_8));

	N205_6 :=__common__( map(((real)iv_src_bureau_addr_count <= NULL) => -9.1138106e-005,
				  ((real)iv_src_bureau_addr_count < 3.5)   => N205_7,
															  -9.1138106e-005));

	N205_5 :=__common__( map(((real)iv_email_count <= NULL) => -0.0012631504,
				  ((real)iv_email_count < 0.5)   => N205_6,
													-0.0012631504));

	N205_4 :=__common__( if(((real)nf_average_rel_criminal_dist < 12.5), -0.0041759222, N205_5));

	N205_3 :=__common__( if(((real)nf_average_rel_criminal_dist > NULL), N205_4, 0.0015593119));

	N205_2 :=__common__( if(((real)iv_ssns_per_sfd_addr_c6 < 3.5), N205_3, 0.007399141));

	N205_1 :=__common__( if(((real)iv_ssns_per_sfd_addr_c6 > NULL), N205_2, 0.0047387662));

	N206_10 :=__common__( if(((integer)iv_mos_src_bureau_lname_fseen < 179), -0.013367846, 0.0002975872));

	N206_9 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen > NULL), N206_10, 0.01076282));

	N206_8 :=__common__( map(((real)iv_dob_src_ct <= NULL) => 0.0019678525,
				  ((real)iv_dob_src_ct < 2.5)   => 0.0094527507,
												   0.0019678525));

	N206_7 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => -0.00024614483,
				  (iv_dl_val_flag in ['Empty'])     => N206_8,
													   N206_8));

	N206_6 :=__common__( if(((real)iv_age_at_high_issue < 15.5), N206_7, -0.004190988));

	N206_5 :=__common__( if(((real)iv_age_at_high_issue > NULL), N206_6, 0.0016255264));

	N206_4 :=__common__( if(((real)iv_inq_addrs_per_adl < 3.5), N206_5, -0.0064569512));

	N206_3 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N206_4, -0.0070176325));

	N206_2 :=__common__( if(((integer)c_larceny < 195), N206_3, N206_9));

	N206_1 :=__common__( if(trim(C_LARCENY) != '', N206_2, -0.00027486857));

	N207_8 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '6', '9']) => -0.0098900341,
				  (nf_fp_idrisktype in ['7', '8'])                          => 0.040975622,
																			   0.040975622));

	N207_7 :=__common__( if(((real)c_sfdu_p < 82.1499938965), -0.002132545, 0.008791262));

	N207_6 :=__common__( if(trim(C_SFDU_P) != '', N207_7, 0.017313715));

	N207_5 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-3']) => N207_6,
				  (iv_paw_dead_bus_x_active_phn in ['1-1', '3-2'])                                                                                     => 0.089553616,
																																						  N207_6));

	N207_4 :=__common__( map(((real)iv_dc001_mos_since_crim_ls <= NULL) => N207_5,
				  ((real)iv_dc001_mos_since_crim_ls < 20.5)  => 0.012653658,
																N207_5));

	N207_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => -3.4839472e-005,
				  (iv_criminal_x_felony in ['1-0', '1-1', '3-3'])                             => N207_4,
																								 -3.4839472e-005));

	N207_2 :=__common__( if(((integer)nf_inp_addr_nhood_pct_vacant < 75), N207_3, N207_8));

	N207_1 :=__common__( if(((real)nf_inp_addr_nhood_pct_vacant > NULL), N207_2, 0.0066272736));

	N208_8 :=__common__( map(((real)iv_sr001_source_profile <= NULL)         => -0.0061082741,
				  ((real)iv_sr001_source_profile < 73.6499938965) => 0.0067944103,
																	 -0.0061082741));

	N208_7 :=__common__( map(trim(C_POP_25_34_P) = ''              => -0.010625519,
				  ((real)c_pop_25_34_p < 25.0499992371) => N208_8,
														   -0.010625519));

	N208_6 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '5', '6', '8']) => N208_7,
				  (nf_fp_idverrisktype in ['4', '7', '9'])                => 0.027030607,
																			 0.027030607));

	N208_5 :=__common__( if(((integer)nf_average_rel_home_val < 131500), 0.0016301443, -0.002328055));

	N208_4 :=__common__( if(((real)nf_average_rel_home_val > NULL), N208_5, -0.0067298676));

	N208_3 :=__common__( map(trim(C_BLUE_COL) = ''              => -0.013787634,
				  ((real)c_blue_col < 26.6500015259) => N208_4,
														-0.013787634));

	N208_2 :=__common__( if(((real)c_sub_bus < 155.5), N208_3, N208_6));

	N208_1 :=__common__( if(trim(C_SUB_BUS) != '', N208_2, 0.0014475724));

	N209_8 :=__common__( map(((real)iv_combined_age <= NULL) => 0.0024560397,
				  ((real)iv_combined_age < 23.5)  => 0.011274024,
													 0.0024560397));

	N209_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '6', '9']) => N209_8,
				  (nf_fp_srchcomponentrisktype in ['5', '7', '8'])                => 0.027228524,
																					 N209_8));

	N209_6 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '003', '102', '103', '104', '105', '107', '109', '110', '112']) => -0.003985026,
				  (iv_phnpop_x_nap_summary in ['000', '005', '008', '100', '101', '106', '108', '111'])               => N209_7,
																														 -0.003985026));

	N209_5 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-3']) => N209_6,
				  (iv_paw_dead_bus_x_active_phn in ['1-2', '2-2', '3-1', '3-2'])                                                         => 0.11299826,
																																			N209_6));

	N209_4 :=__common__( if(((real)c_hh3_p < 19.75), -0.0012847112, N209_5));

	N209_3 :=__common__( if(trim(C_HH3_P) != '', N209_4, -0.0041688785));

	N209_2 :=__common__( if(((real)iv_inq_addrs_per_adl < 3.5), N209_3, -0.0072942403));

	N209_1 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N209_2, 0.0010842174));

	N210_6 :=__common__( map(((real)iv_ssn_non_phn_src_ct <= NULL) => 0.0013209958,
				  ((real)iv_ssn_non_phn_src_ct < 4.5)   => 0.0083030781,
														   0.0013209958));

	N210_5 :=__common__( map((iv_va100_add_problem in ['07 Busines'])                                                                                                                                                                                                                                                              => -0.028217933,
				  (iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant']) => N210_6,
																																																																														   N210_6));

	N210_4 :=__common__( map((iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => N210_5,
				  (iv_inp_addr_mortgage_type in ['Commercial'])                                                                                                                => 0.13561395,
																																												  N210_5));

	N210_3 :=__common__( if(((real)c_business < 79.5), 0.00016315156, -0.0061192981));

	N210_2 :=__common__( if(trim(C_BUSINESS) != '', N210_3, -0.00018438212));

	N210_1 :=__common__( map((nf_fp_divrisktype in ['1', '2', '5', '7'])      => N210_2,
				  (nf_fp_divrisktype in ['3', '4', '6', '8', '9']) => N210_4,
																	  N210_2));

	N211_8 :=__common__( map((nf_fp_assocrisktype in ['3', '7'])                          => -0.0088656572,
				  (nf_fp_assocrisktype in ['1', '2', '4', '5', '6', '8', '9']) => 0.009866646,
																				  0.009866646));

	N211_7 :=__common__( map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Government', 'High-Risk', 'No Mortgage', 'Piggyback', 'Unknown']) => N211_8,
				  (iv_bst_addr_mortgage_type in ['Equity Loan', 'Non-Traditional', 'Other'])                                                      => 0.047653931,
																																					 N211_8));

	N211_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '5', '6', '7']) => 0.0017407268,
				  (nf_fp_srchcomponentrisktype in ['3', '8', '9'])                => N211_7,
																					 0.0017407268));

	N211_5 :=__common__( if(((real)c_hh00 < 356.5), -0.0030534044, N211_6));

	N211_4 :=__common__( if(trim(C_HH00) != '', N211_5, -0.0018274218));

	N211_3 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '008', '100', '102', '103', '105', '106', '108', '111', '112']) => N211_4,
				  (iv_phnpop_x_nap_summary in ['000', '003', '005', '101', '104', '107', '109', '110'])               => 0.014807921,
																														 N211_4));

	N211_2 :=__common__( if(((real)iv_inq_other_recency < 0.5), -0.0019429189, N211_3));

	N211_1 :=__common__( if(((real)iv_inq_other_recency > NULL), N211_2, -0.0062203438));

	N212_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => -0.0013685685,
				  (iv_va100_add_problem in ['05 Drop Delivery', '13 Vacant'])                                                                                                                                                                                                                        => 0.055319522,
																																																																										-0.0013685685));

	N212_5 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '3-1', '3-2', '3-3', '4-1', '4-3', '5-1', '5-2']) => N212_6,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '2-3', '4-2', '5-3'])                                                                       => 0.018117855,
																																						  N212_6));

	N212_4 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '0', '10', '15', '20', '25', '30', '40']) => N212_5,
				  (iv_prv_addr_mortgage_term in ['5'])                                           => 0.078576277,
																									0.078576277));

	N212_3 :=__common__( if(((integer)c_larceny < 195), -0.00011880256, -0.0079942058));

	N212_2 :=__common__( if(trim(C_LARCENY) != '', N212_3, -0.0022966874));

	N212_1 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '003', '100', '102', '103', '105', '107', '108', '111', '112']) => N212_2,
				  (iv_phnpop_x_nap_summary in ['000', '005', '008', '101', '104', '106', '109', '110'])               => N212_4,
																														 N212_2));

	N213_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '9']) => 0.0074780187,
				  (nf_fp_srchcomponentrisktype in ['6', '7', '8'])                => 0.041684537,
																					 0.0074780187));

	N213_7 :=__common__( if(((real)c_inc_75k_p < 16.1500015259), -0.0036057081, N213_8));

	N213_6 :=__common__( if(trim(C_INC_75K_P) != '', N213_7, 0.0216932));

	N213_5 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '9']) => N213_6,
				  (nf_fp_idverrisktype in ['6', '7', '8'])                => 0.024720743,
																			 N213_6));

	N213_4 :=__common__( map(((real)iv_hist_addr_match <= NULL) => N213_5,
				  ((real)iv_hist_addr_match < 4.5)   => -0.00052239322,
														N213_5));

	N213_3 :=__common__( map(((real)nf_fp_srchaddrsrchcountwk <= NULL) => 0.0088174589,
				  ((real)nf_fp_srchaddrsrchcountwk < 1.5)   => N213_4,
															   0.0088174589));

	N213_2 :=__common__( if(((real)iv_inq_addrs_per_adl < 3.5), N213_3, -0.0066741723));

	N213_1 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N213_2, 0.0005590949));

	N214_9 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '3-0', '3-3']) => 0.0064842355,
				  (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2']) => 0.038969355,
																				   0.038969355));

	N214_8 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '0', '10', '15', '20', '25', '30']) => 0.003401558,
				  (iv_bst_addr_mortgage_term in ['40', '5'])                               => 0.084564794,
																							  0.003401558));

	N214_7 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr < 0.912493944168), 0.013492657, -0.00089307415));

	N214_6 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N214_7, N214_8));

	N214_5 :=__common__( map((iv_criminal_x_felony in ['3-1', '3-2'])                                           => -0.0088492691,
				  (iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-3']) => N214_6,
																										N214_6));

	N214_4 :=__common__( map(((real)iv_addrs_per_adl <= NULL) => N214_5,
				  ((real)iv_addrs_per_adl < 15.5)  => -0.0011831544,
													  N214_5));

	N214_3 :=__common__( if(((real)c_newhouse < 114.75), N214_4, N214_9));

	N214_2 :=__common__( if(trim(C_NEWHOUSE) != '', N214_3, -0.0044492363));

	N214_1 :=__common__( if(((real)iv_inq_other_recency > NULL), N214_2, -0.0033860745));

	N215_5 :=__common__( if(((real)iv_prop2_purch_sale_diff > NULL), 0.15893803, 0.0022683171));

	N215_4 :=__common__( map(((real)nf_fp_prevaddrageoldest <= NULL) => N215_5,
				  ((real)nf_fp_prevaddrageoldest < 86.5)  => -0.0058897779,
															 N215_5));

	N215_3 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1']) => N215_4,
				  (iv_paw_dead_bus_x_active_phn in ['1-2', '2-2', '3-2', '3-3'])                                                         => 0.10590301,
																																			N215_4));

	N215_2 :=__common__( map(((real)iv_src_bureau_addr_count <= NULL) => N215_3,
				  ((real)iv_src_bureau_addr_count < 6.5)   => 0.0015666328,
															  N215_3));

	N215_1 :=__common__( map((nf_fp_idrisktype in ['3', '9'])                          => -0.011880276,
				  (nf_fp_idrisktype in ['1', '2', '4', '5', '6', '7', '8']) => N215_2,
																			   -0.011880276));

	N216_6 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'E', 'F', 'G', 'H', 'J']) => 0.0016795757,
				  (iv_in001_college_income in ['C', 'D', 'I', 'K'])                      => 0.012791887,
																							0.0016795757));

	N216_5 :=__common__( map(((real)iv_inq_other_recency <= NULL) => N216_6,
				  ((real)iv_inq_other_recency < 4.5)   => -0.0014629816,
														  N216_6));

	N216_4 :=__common__( if(((real)nf_closest_rel_distance < 62.5), N216_5, 0.010641878));

	N216_3 :=__common__( if(((real)nf_closest_rel_distance > NULL), N216_4, 0.0084406977));

	N216_2 :=__common__( map((iv_vp008_phn_pay_phone in ['0']) => -0.0027119113,
				  (iv_vp008_phn_pay_phone in ['1']) => 0.13436826,
													   -0.0027119113));

	N216_1 :=__common__( map((nf_fp_assocrisktype in ['2', '3', '7'])                => N216_2,
				  (nf_fp_assocrisktype in ['1', '4', '5', '6', '8', '9']) => N216_3,
																			 N216_3));

	N217_10 :=__common__( map((iv_pb_order_freq in ['1 Cant Calculate', '2 Weekly', '4 Semi-monthly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => 0.002521816,
				   (iv_pb_order_freq in ['0 No Purch Data', '3 Monthly', '5 Quarterly'])                                             => 0.016902792,
																																		0.002521816));

	N217_9 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => 0.0013191342,
				  (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid'])                                                  => 0.05151218,
																															 0.0013191342));

	N217_8 :=__common__( if(((real)iv_addr_lres_6mo_count < 5.5), N217_9, N217_10));

	N217_7 :=__common__( if(((real)iv_addr_lres_6mo_count > NULL), N217_8, -0.0054341528));

	N217_6 :=__common__( if(((real)c_retail < 2.45000004768), N217_7, -0.0014223498));

	N217_5 :=__common__( if(trim(C_RETAIL) != '', N217_6, -0.0038598783));

	N217_4 :=__common__( if(((real)c_rentocc_p < 35.5499992371), 0.012820044, -0.0048399868));

	N217_3 :=__common__( if(trim(C_RENTOCC_P) != '', N217_4, -0.034480602));

	N217_2 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr < 0.78776049614), N217_3, -0.001858739));

	N217_1 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N217_2, N217_5));

	N218_6 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '108', '110', '111', '112']) => -0.0044450975,
				  (iv_phnpop_x_nap_summary in ['106', '107', '109'])                                                                                     => 0.044087243,
																																							-0.0044450975));

	N218_5 :=__common__( map(trim(C_RAPE) = ''     => 0.0015080442,
				  ((real)c_rape < 38.5) => N218_6,
										   0.0015080442));

	N218_4 :=__common__( map((nf_fp_varrisktype in ['-1', '7'])                              => -0.0084625799,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N218_5,
																					 N218_5));

	N218_3 :=__common__( map((nf_fp_componentcharrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N218_4,
				  (nf_fp_componentcharrisktype in ['8'])                                    => 0.0074841262,
																							   N218_4));

	N218_2 :=__common__( if(trim(C_RAPE) != '', N218_3, -0.00043188948));

	N218_1 :=__common__( map((iv_va001_add_po_box in ['1']) => -0.011765378,
				  (iv_va001_add_po_box in ['0']) => N218_2,
													N218_2));

	N219_9 :=__common__( if(((integer)nf_fp_curraddrmedianvalue < 188424), 0.0089584703, -0.0021108689));

	N219_8 :=__common__( if(((real)nf_fp_curraddrmedianvalue > NULL), N219_9, 0.010158756));

	N219_7 :=__common__( map((iv_vp001_phn_not_issued in ['0']) => N219_8,
				  (iv_vp001_phn_not_issued in ['1']) => 0.069309184,
														N219_8));

	N219_6 :=__common__( map(trim(C_HH6_P) = ''              => -0.00021150551,
				  ((real)c_hh6_p < 1.45000004768) => 0.01486302,
													 -0.00021150551));

	N219_5 :=__common__( if(((real)iv_max_ids_per_sfd_addr_c6 < 4.5), -0.00046558076, N219_6));

	N219_4 :=__common__( if(((real)iv_max_ids_per_sfd_addr_c6 > NULL), N219_5, -0.027181856));

	N219_3 :=__common__( map((nf_fp_idrisktype in ['3', '6', '9'])                => -0.017765739,
				  (nf_fp_idrisktype in ['1', '2', '4', '5', '7', '8']) => N219_4,
																		  N219_4));

	N219_2 :=__common__( if(((real)c_construction < 27.25), N219_3, N219_7));

	N219_1 :=__common__( if(trim(C_CONSTRUCTION) != '', N219_2, 0.0028547693));

	N220_8 :=__common__( map(((real)nf_average_rel_criminal_dist <= NULL) => -0.0028476898,
				  ((real)nf_average_rel_criminal_dist < 214.5) => 0.0011455826,
																  -0.0028476898));

	N220_7 :=__common__( map((iv_va100_add_problem in ['01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '09 Corporate Zip Code', '11 Throw Back', '12 College']) => 0.00020492435,
				  (iv_va100_add_problem in ['00 No Address Problems', '06 Invalid Address', '07 Busines', '10 Zip/City Mismatch', '13 Vacant'])                                                                                    => 0.015479823,
																																																									  0.00020492435));

	N220_6 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '20', '25', '30', '40']) => N220_7,
				  (iv_prv_addr_mortgage_term in ['0', '10', '15', '5'])         => 0.057404327,
																				   N220_7));

	N220_5 :=__common__( map(((real)nf_fp_corrssnnamecount <= NULL) => N220_8,
				  ((real)nf_fp_corrssnnamecount < 0.5)   => N220_6,
															N220_8));

	N220_4 :=__common__( map(trim(C_HH00) = ''      => N220_5,
				  ((real)c_hh00 < 235.5) => -0.011903522,
											N220_5));

	N220_3 :=__common__( if(((real)nf_fp_corrssnnamecount > NULL), N220_4, -0.0061737666));

	N220_2 :=__common__( if(((real)c_civ_emp < 34.75), 0.013858566, N220_3));

	N220_1 :=__common__( if(trim(C_CIV_EMP) != '', N220_2, 0.00092532187));

	N221_8 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'G', 'H', 'M', 'P', 'S', 'U']) => 0.0067203251,
				  (nf_fp_prevaddrdwelltype in ['R'])                                     => 0.1453693,
																							0.0067203251));

	N221_7 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.00065520527,
				  ((real)iv_ag001_age < 27.5)  => N221_8,
												  -0.00065520527));

	N221_6 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => 0.0051225795,
				  ((real)iv_pl002_avg_mo_per_addr < 30.5)  => -0.0050576848,
															  0.0051225795));

	N221_5 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen < 98.5), N221_6, N221_7));

	N221_4 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen > NULL), N221_5, 0.0042012217));

	N221_3 :=__common__( map(((real)iv_ag001_age <= NULL) => N221_4,
				  ((real)iv_ag001_age < 20.5)  => 0.0064608222,
												  N221_4));

	N221_2 :=__common__( if(((real)c_hval_500k_p < 35.9500007629), N221_3, 0.011216142));

	N221_1 :=__common__( if(trim(C_HVAL_500K_P) != '', N221_2, 0.005267508));

	N222_7 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen < 77.5), -0.0034161247, 0.00061628491));

	N222_6 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen > NULL), N222_7, -0.0017068764));

	N222_5 :=__common__( map(trim(C_POP00) = ''        => 0.010676913,
				  ((integer)c_pop00 < 3240) => N222_6,
											   0.010676913));

	N222_4 :=__common__( if(((real)c_business < 79.5), N222_5, -0.0052741174));

	N222_3 :=__common__( if(trim(C_BUSINESS) != '', N222_4, 0.0037720912));

	N222_2 :=__common__( map((iv_inp_addr_financing_type in ['ADJ'])                => -0.0095632035,
				  (iv_inp_addr_financing_type in ['CNV', 'NONE', 'OTH']) => N222_3,
																			N222_3));

	N222_1 :=__common__( map((iv_bst_addr_avm_land_use in ['', '1']) => N222_2,
				  (iv_bst_addr_avm_land_use in ['2'])      => 0.012617161,
															  N222_2));

	N223_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '2-3', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => -0.0032416828,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '3-1', '3-2'])                                                                                     => 0.123248,
																																								 -0.0032416828));

	N223_5 :=__common__( map(trim(C_MANY_CARS) = ''     => N223_6,
				  ((real)c_many_cars < 62.5) => 0.0094020468,
												N223_6));

	N223_4 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-0', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => N223_5,
				  (iv_paw_dead_bus_x_active_phn in ['0-1', '1-1'])                                                                                     => 0.12627398,
																																						  N223_5));

	N223_3 :=__common__( if(((real)c_inc_25k_p < 6.55000019073), 0.01777779, N223_4));

	N223_2 :=__common__( if(trim(C_INC_25K_P) != '', N223_3, 0.010719085));

	N223_1 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0008900201,
				  ((real)iv_ag001_age < 22.5)  => N223_2,
												  -0.0008900201));

	N224_9 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '2-1', '3-0', '3-1', '3-2']) => 0.0047821058,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-2', '3-3'])               => 0.026362302,
																						  0.0047821058));

	N224_8 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr < 0.878501594067), N224_9, -0.0011221022));

	N224_7 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N224_8, 0.0033212817));

	N224_6 :=__common__( if(((real)c_hval_200k_p < 7.55000019073), N224_7, -0.0021290752));

	N224_5 :=__common__( if(trim(C_HVAL_200K_P) != '', N224_6, 0.00280716));

	N224_4 :=__common__( map(((real)iv_mos_src_bureau_lname_fseen <= NULL) => N224_5,
				  ((real)iv_mos_src_bureau_lname_fseen < 35.5)  => 0.0099807232,
																   N224_5));

	N224_3 :=__common__( map(((real)iv_age_at_low_issue <= NULL) => -0.0028921079,
				  ((real)iv_age_at_low_issue < 11.5)  => N224_4,
														 -0.0028921079));

	N224_2 :=__common__( map(((real)iv_src_bureau_lname_count <= NULL) => N224_3,
				  ((real)iv_src_bureau_lname_count < 6.5)   => -0.0074119491,
															   N224_3));

	N224_1 :=__common__( if(((real)iv_age_at_low_issue > NULL), N224_2, -0.00086984307));

	N225_6 :=__common__( map((iv_phn_miskey in ['0']) => 0.0035449957,
				  (iv_phn_miskey in ['1']) => 0.074014847,
											  0.074014847));

	N225_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '8']) => N225_6,
				  (nf_fp_srchcomponentrisktype in ['6', '7', '9'])                => 0.029321637,
																					 N225_6));

	N225_4 :=__common__( if(((real)nf_fp_prevaddrageoldest < 4.5), N225_5, -0.00080062645));

	N225_3 :=__common__( if(((real)nf_fp_prevaddrageoldest > NULL), N225_4, 0.0090605997));

	N225_2 :=__common__( map(((real)iv_prv_addr_lres <= NULL) => 0.0067272033,
				  ((real)iv_prv_addr_lres < 119.5) => -0.0051394295,
													  0.0067272033));

	N225_1 :=__common__( map((nf_fp_varrisktype in ['-1', '4', '5', '7', '8']) => N225_2,
				  (nf_fp_varrisktype in ['1', '2', '3', '6', '9'])  => N225_3,
																	   N225_3));

	N226_8 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '2-1', '2-2'])               => 0.00024461527,
				  (iv_liens_unrel_x_rel in ['0-2', '1-0', '1-2', '2-0', '3-0', '3-1', '3-2']) => 0.012809946,
																								 0.012809946));

	N226_7 :=__common__( map((iv_nap_status in ['C']) => 0.00072391113,
				  (iv_nap_status in ['D']) => 0.13187191,
											  0.00072391113));

	N226_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-3', '2-3', '3-1', '4-1', '4-2', '4-3', '5-2']) => -0.0056543545,
				  (iv_gong_did_fname_x_lname_ct in ['1-1', '1-2', '2-1', '2-2', '3-2', '3-3', '5-1', '5-3'])               => -0.00094393613,
																															  -0.0056543545));

	N226_5 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => N226_6,
				  ((real)iv_mos_since_prv_addr_fseen < 2.5)   => 0.0060723917,
																 N226_6));

	N226_4 :=__common__( if(((real)iv_pl002_avg_mo_per_addr < 21.5), N226_5, N226_7));

	N226_3 :=__common__( if(((real)iv_pl002_avg_mo_per_addr > NULL), N226_4, -0.0038508067));

	N226_2 :=__common__( if(((real)c_no_labfor < 165.5), N226_3, N226_8));

	N226_1 :=__common__( if(trim(C_NO_LABFOR) != '', N226_2, 0.0017058647));

	N227_8 :=__common__( map(((real)iv_inq_num_diff_names_per_adl <= NULL) => 0.0060666021,
				  ((real)iv_inq_num_diff_names_per_adl < 1.5)   => 0.00064752669,
																   0.0060666021));

	N227_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.0075072195,
				  ((real)c_famotf18_p < 48.9500007629) => N227_8,
														  -0.0075072195));

	N227_6 :=__common__( if(((real)c_rnt250_p < 41.3499984741), N227_7, 0.01123795));

	N227_5 :=__common__( if(trim(C_RNT250_P) != '', N227_6, 0.006421862));

	N227_4 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => 0.006881616,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => -0.003775349,
															   0.006881616));

	N227_3 :=__common__( map(((real)iv_dist_inp_addr_to_prv_addr <= NULL) => N227_5,
				  ((real)iv_dist_inp_addr_to_prv_addr < 0.5)   => N227_4,
																  N227_5));

	N227_2 :=__common__( if(((integer)iv_attr_proflic_recency < 48), N227_3, -0.0092546735));

	N227_1 :=__common__( if(((real)iv_attr_proflic_recency > NULL), N227_2, -0.00045971844));

	N228_8 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '0', '20', '25', '30']) => -0.0045537971,
				  (iv_inp_addr_mortgage_term in ['10', '15', '40', '5'])       => 0.037145392,
																				  -0.0045537971));

	N228_7 :=__common__( map(trim(C_PRESCHL) = ''      => -0.0067559527,
				  ((real)c_preschl < 130.5) => 0.0098693057,
											   -0.0067559527));

	N228_6 :=__common__( map(trim(C_POP_18_24_P) = ''              => N228_7,
				  ((real)c_pop_18_24_p < 9.35000038147) => 0.013261486,
														   N228_7));

	N228_5 :=__common__( map((nf_fp_assocrisktype in ['3'])                                    => -0.013214359,
				  (nf_fp_assocrisktype in ['1', '2', '4', '5', '6', '7', '8', '9']) => N228_6,
																					   N228_6));

	N228_4 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount < 1.5), 0.00020855419, N228_5));

	N228_3 :=__common__( if(((real)nf_fp_varmsrcssnunrelcount > NULL), N228_4, -0.00131524));

	N228_2 :=__common__( if(((real)c_burglary < 183.5), N228_3, N228_8));

	N228_1 :=__common__( if(trim(C_BURGLARY) != '', N228_2, 0.0012252845));

	N229_8 :=__common__( if(((real)iv_adls_per_apt_addr < 14.5), -0.0016366646, 0.0098849952));

	N229_7 :=__common__( if(((real)iv_adls_per_apt_addr > NULL), N229_8, 0.083226509));

	N229_6 :=__common__( map(trim(C_HVAL_250K_P) = ''     => -0.0031756828,
				  ((real)c_hval_250k_p < 6.25) => 0.010726483,
												  -0.0031756828));

	N229_5 :=__common__( map(trim(C_HVAL_175K_P) = ''              => N229_6,
				  ((real)c_hval_175k_p < 2.34999990463) => 0.01472395,
														   N229_6));

	N229_4 :=__common__( map((iv_ed001_college_ind_26 in ['1']) => 0.0011459755,
				  (iv_ed001_college_ind_26 in ['0']) => N229_5,
														0.0011459755));

	N229_3 :=__common__( map(trim(C_RETIRED2) = ''     => N229_7,
				  ((real)c_retired2 < 75.5) => N229_4,
											   N229_7));

	N229_2 :=__common__( if(((real)c_popover25 < 374.5), -0.010204306, N229_3));

	N229_1 :=__common__( if(trim(C_POPOVER25) != '', N229_2, -0.0016404102));

	N230_9 :=__common__( map((iv_input_dob_match_level in ['4', '6', '7', '8'])      => 0.0070172592,
				  (iv_input_dob_match_level in ['0', '1', '2', '3', '5']) => 0.077024155,
																			 0.0070172592));

	N230_8 :=__common__( map(trim(C_INC_35K_P) = ''              => -0.00010395193,
				  ((real)c_inc_35k_p < 10.5500001907) => N230_9,
														 -0.00010395193));

	N230_7 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-2', '2-1', '2-2', '3-1', '3-2']) => -3.2845144e-005,
				  (iv_liens_unrel_x_rel in ['1-0', '1-1', '2-0', '3-0'])                             => N230_8,
																										N230_8));

	N230_6 :=__common__( if(((integer)nf_inp_addr_nhood_pct_vacant < 95), N230_7, -0.010586249));

	N230_5 :=__common__( if(((real)nf_inp_addr_nhood_pct_vacant > NULL), N230_6, 0.027954253));

	N230_4 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen < 137.5), -0.013194073, -0.0015624778));

	N230_3 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen > NULL), N230_4, -0.0045419145));

	N230_2 :=__common__( if(((real)c_families < 160.5), N230_3, N230_5));

	N230_1 :=__common__( if(trim(C_FAMILIES) != '', N230_2, -0.0044966291));

	N231_8 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => 0.0083100451,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '2-3'])                                                                                                   => 0.11536071,
																																										0.0083100451));

	N231_7 :=__common__( map(((real)iv_adls_per_addr <= NULL) => N231_8,
				  ((real)iv_adls_per_addr < 5.5)   => -0.0050518913,
													  N231_8));

	N231_6 :=__common__( map((nf_fp_validationrisktype in ['1'])                          => N231_7,
				  (nf_fp_validationrisktype in ['2', '3', '4', '5', '6', '8']) => 0.077445686,
																				  0.077445686));

	N231_5 :=__common__( if(((real)c_totcrime < 185.5), -0.00070839366, N231_6));

	N231_4 :=__common__( if(trim(C_TOTCRIME) != '', N231_5, -0.0025556956));

	N231_3 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '5 Cell', '7 PCS'])              => N231_4,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid', '6 Pager', '8 Pay_Phone']) => 0.0092267657,
																										   N231_4));

	N231_2 :=__common__( if(((real)iv_src_liens_adl_count < 6.5), N231_3, 0.012298777));

	N231_1 :=__common__( if(((real)iv_src_liens_adl_count > NULL), N231_2, -0.0022145612));

	N232_6 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-2', '2-1', '2-2', '2-3', '3-0', '3-2', '3-3']) => -0.0042683488,
				  (iv_paw_dead_bus_x_active_phn in ['1-1', '1-3', '2-0', '3-1'])                                                         => 0.056570888,
																																			-0.0042683488));

	N232_5 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '10', '15', '20', '25', '30', '40', '5']) => N232_6,
				  (iv_bst_addr_mortgage_term in ['0'])                                           => 0.073490006,
																									N232_6));

	N232_4 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => 0.00079879695,
				  (nf_fp_idverrisktype in ['9'])                                    => 0.07178391,
																					   0.00079879695));

	N232_3 :=__common__( if(((real)nf_lowest_rel_income < 37.5), N232_4, N232_5));

	N232_2 :=__common__( if(((real)nf_lowest_rel_income > NULL), N232_3, 0.00091107435));

	N232_1 :=__common__( map((iv_vp008_phn_pay_phone in ['0']) => N232_2,
				  (iv_vp008_phn_pay_phone in ['1']) => 0.083068423,
													   N232_2));

	N233_7 :=__common__( map(((real)iv_src_voter_adl_count <= NULL) => 0.0044629662,
				  ((real)iv_src_voter_adl_count < -0.5)  => -0.00022996125,
															0.0044629662));

	N233_6 :=__common__( map(((real)iv_inq_collection_recency <= NULL) => N233_7,
				  ((real)iv_inq_collection_recency < 0.5)   => -0.0022368198,
															   N233_7));

	N233_5 :=__common__( map(((real)iv_src_bureau_ssn_count <= NULL) => -0.0050101016,
				  ((real)iv_src_bureau_ssn_count < 85.5)  => N233_6,
															 -0.0050101016));

	N233_4 :=__common__( map((nf_fp_prevaddrdwelltype in ['F', 'M', 'U'])                 => -0.016021441,
				  (nf_fp_prevaddrdwelltype in ['-1', 'G', 'H', 'P', 'R', 'S']) => N233_5,
																				  -0.016021441));

	N233_3 :=__common__( map((nf_fp_varrisktype in ['5', '6', '7', '8', '9'])  => -0.019752468,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4']) => -0.0045452336,
																	   -0.0045452336));

	N233_2 :=__common__( if(((real)c_popover18 < 534.5), N233_3, N233_4));

	N233_1 :=__common__( if(trim(C_POPOVER18) != '', N233_2, 0.0013998827));

	N234_8 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-2', '3-0', '3-1']) => 0.00030897446,
				  (iv_liens_unrel_x_rel in ['0-0', '2-1', '3-2'])                                           => 0.007810587,
																											   0.00030897446));

	N234_7 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0013861241,
				  ((integer)nf_average_rel_home_val < 132500) => N234_8,
																 -0.0013861241));

	N234_6 :=__common__( map((fp_segment in ['1 SSN Prob', '7 Other'])                                                   => -0.0061008142,
				  (fp_segment in ['2 NAS 479', '3 New DID', '4 Bureau Only', '5 Derog', '6 Recent Activity']) => N234_7,
																												 N234_7));

	N234_5 :=__common__( map(trim(C_HH00) = ''      => 0.0045861926,
				  ((real)c_hh00 < 278.5) => -0.0070773067,
											0.0045861926));

	N234_4 :=__common__( if(((real)c_newhouse < 3.65000009537), N234_5, N234_6));

	N234_3 :=__common__( if(trim(C_NEWHOUSE) != '', N234_4, 0.00011336318));

	N234_2 :=__common__( if(((real)iv_prv_addr_lres < 0.5), -0.0059909422, N234_3));

	N234_1 :=__common__( if(((real)iv_prv_addr_lres > NULL), N234_2, 0.0036953585));

	N235_8 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '103', '105', '107', '108', '109', '110', '112']) => -0.0070332553,
				  (iv_phnpop_x_nap_summary in ['101', '102', '104', '106', '111'])                                                         => 0.038850444,
																																			  0.038850444));

	N235_7 :=__common__( map((iv_liens_unrel_x_rel in ['0-2', '1-0', '2-1', '3-0'])                             => -0.00022555854,
				  (iv_liens_unrel_x_rel in ['0-0', '0-1', '1-1', '1-2', '2-0', '2-2', '3-1', '3-2']) => 0.014267556,
																										0.014267556));

	N235_6 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N235_7,
				  ((real)nf_fp_srchfraudsrchcount < 12.5)  => 0.0026885965,
															  N235_7));

	N235_5 :=__common__( if(((real)c_oldhouse < 149.75), -0.0018861469, 0.0026458539));

	N235_4 :=__common__( if(trim(C_OLDHOUSE) != '', N235_5, 0.0049172535));

	N235_3 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => N235_6,
				  ((real)iv_inq_collection_count12 < 0.5)   => N235_4,
															   N235_6));

	N235_2 :=__common__( if(((real)iv_sr001_source_profile < 76.25), N235_3, N235_8));

	N235_1 :=__common__( if(((real)iv_sr001_source_profile > NULL), N235_2, -0.0048200992));

	N236_8 :=__common__( if(((real)nf_fp_prevaddrburglaryindex < 118.5), 0.016206364, -0.0018982519));

	N236_7 :=__common__( if(((real)nf_fp_prevaddrburglaryindex > NULL), N236_8, -0.033320006));

	N236_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '4-2', '4-3', '5-1', '5-3']) => N236_7,
				  (iv_gong_did_fname_x_lname_ct in ['3-3', '4-1', '5-2'])                                                                                     => 0.083921887,
																																								 N236_7));

	N236_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-3']) => N236_6,
				  (iv_criminal_x_felony in ['1-1', '3-2'])                                           => 0.050002491,
																										N236_6));

	N236_4 :=__common__( map((nf_fp_varrisktype in ['5', '6', '7', '8'])            => -0.0030984809,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '9']) => 0.00060421956,
																			-0.0030984809));

	N236_3 :=__common__( map((nf_fp_divrisktype in ['7'])                                    => -0.022358914,
				  (nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N236_4,
																					 N236_4));

	N236_2 :=__common__( if(((real)c_newhouse < 112.25), N236_3, N236_5));

	N236_1 :=__common__( if(trim(C_NEWHOUSE) != '', N236_2, 0.00035962939));

	N237_8 :=__common__( map((iv_fname_eda_sourced_type in ['-1', 'A']) => 0.0027877409,
				  (iv_fname_eda_sourced_type in ['AP', 'P']) => 0.077721562,
																0.077721562));

	N237_7 :=__common__( map(((real)iv_sr001_source_profile <= NULL)         => N237_8,
				  ((real)iv_sr001_source_profile < 62.5499992371) => 0.017283584,
																	 N237_8));

	N237_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '12 College', '13 Vacant']) => -0.0032037072,
				  (iv_va100_add_problem in ['04 HiRisk Commercial', '11 Throw Back'])                                                                                                                                                                                                        => 0.072203454,
																																																																								-0.0032037072));

	N237_5 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['00', '01', '04', '10', '11', '12']) => N237_6,
				  (iv_inp_own_prop_x_addr_naprop in ['02', '03', '13', '14'])             => 0.014602341,
																							 N237_6));

	N237_4 :=__common__( if(((real)c_med_hval < 154386.5), N237_5, N237_7));

	N237_3 :=__common__( if(trim(C_MED_HVAL) != '', N237_4, 0.00063490369));

	N237_2 :=__common__( if(((real)iv_addrs_per_adl < 16.5), -0.001339248, N237_3));

	N237_1 :=__common__( if(((real)iv_addrs_per_adl > NULL), N237_2, 0.0013969632));

	N238_8 :=__common__( if(((real)c_med_hhinc < 53594.5), -0.007353995, 0.0075502624));

	N238_7 :=__common__( if(trim(C_MED_HHINC) != '', N238_8, -0.03199567));

	N238_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '5', '7', '8']) => 0.0022669417,
				  (nf_fp_srchcomponentrisktype in ['3', '6', '9'])                => 0.0210366,
																					 0.0022669417));

	N238_5 :=__common__( if(((real)c_hh7p_p < 1.65000009537), N238_6, 0.017710866));

	N238_4 :=__common__( if(trim(C_HH7P_P) != '', N238_5, 0.012211518));

	N238_3 :=__common__( if(((real)nf_fp_prevaddrmedianincome < 44171.5), N238_4, N238_7));

	N238_2 :=__common__( if(((real)nf_fp_prevaddrmedianincome > NULL), N238_3, 0.0020862674));

	N238_1 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => N238_2,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => -0.00025595009,
															   N238_2));

	N239_8 :=__common__( map(trim(C_OWNOCC_P) = ''              => 0.002704488,
				  ((real)c_ownocc_p < 77.9499969482) => -0.0075802243,
														0.002704488));

	N239_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '5', '6', '7']) => 0.0048436045,
				  (nf_fp_divrisktype in ['4', '8', '9'])                => 0.03899679,
																		   0.0048436045));

	N239_6 :=__common__( map(trim(C_POPOVER18) = ''       => N239_8,
				  ((real)c_popover18 < 1050.5) => N239_7,
												  N239_8));

	N239_5 :=__common__( map(trim(C_POPOVER18) = ''      => N239_6,
				  ((real)c_popover18 < 733.5) => -0.011390649,
												 N239_6));

	N239_4 :=__common__( if(((real)c_fammar_p < 79.9499969482), 0.0015117143, N239_5));

	N239_3 :=__common__( if(trim(C_FAMMAR_P) != '', N239_4, 0.00022186481));

	N239_2 :=__common__( if(((real)iv_inq_addrs_per_adl < 3.5), N239_3, -0.0052794725));

	N239_1 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N239_2, 0.0035022044));

	N240_9 :=__common__( map(((real)nf_fp_prevaddrlenofres <= NULL) => -0.0019216955,
				  ((real)nf_fp_prevaddrlenofres < 6.5)   => 0.0070012927,
															-0.0019216955));

	N240_8 :=__common__( if(((real)iv_mos_since_infutor_last_seen < 1.5), N240_9, 0.0068156828));

	N240_7 :=__common__( if(((real)iv_mos_since_infutor_last_seen > NULL), N240_8, 0.0014899835));

	N240_6 :=__common__( map(((real)iv_src_voter_adl_count <= NULL) => N240_7,
				  ((real)iv_src_voter_adl_count < -0.5)  => -0.00088372321,
															N240_7));

	N240_5 :=__common__( if(((real)c_no_teens < 180.5), N240_6, -0.0071939985));

	N240_4 :=__common__( if(trim(C_NO_TEENS) != '', N240_5, 9.0629774e-005));

	N240_3 :=__common__( map(((real)nf_fp_srchaddrsrchcountwk <= NULL) => 0.0087329681,
				  ((real)nf_fp_srchaddrsrchcountwk < 1.5)   => N240_4,
															   0.0087329681));

	N240_2 :=__common__( if(((real)iv_inq_addrs_per_adl < 3.5), N240_3, -0.0063751325));

	N240_1 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N240_2, 0.001425895));

	N241_8 :=__common__( map((nf_fp_componentcharrisktype in ['1', '2', '4', '5', '8', '9']) => 0.00075038206,
				  (nf_fp_componentcharrisktype in ['3', '6', '7'])                => 0.01951961,
																					 0.00075038206));

	N241_7 :=__common__( map((nf_fp_componentcharrisktype in ['2', '3', '4', '8'])      => 0.002066883,
				  (nf_fp_componentcharrisktype in ['1', '5', '6', '7', '9']) => 0.019550077,
																				0.019550077));

	N241_6 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => N241_7,
				  ((integer)nf_average_rel_home_val < 330500) => -0.00011103743,
																 N241_7));

	N241_5 :=__common__( map(trim(C_SUB_BUS) = ''      => -0.0061860614,
				  ((real)c_sub_bus < 111.5) => 0.00025196956,
											   -0.0061860614));

	N241_4 :=__common__( if(((real)nf_fp_prevaddrburglaryindex < 88.5), N241_5, N241_6));

	N241_3 :=__common__( if(((real)nf_fp_prevaddrburglaryindex > NULL), N241_4, 0.0002492726));

	N241_2 :=__common__( if(((real)c_work_home < 180.5), N241_3, N241_8));

	N241_1 :=__common__( if(trim(C_WORK_HOME) != '', N241_2, -0.0025033903));

	N242_7 :=__common__( map(trim(C_FAMOTF18_P) = ''              => -0.010782716,
				  ((real)c_famotf18_p < 46.6500015259) => 0.003284995,
														  -0.010782716));

	N242_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '3-1', '4-1', '4-2', '5-1', '5-2', '5-3']) => -0.0044455485,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '2-1', '2-2', '2-3', '3-2', '3-3', '4-3'])                             => 0.0057029863,
																																	 -0.0044455485));

	N242_5 :=__common__( map(trim(C_BEL_EDU) = ''      => N242_7,
				  ((real)c_bel_edu < 132.5) => N242_6,
											   N242_7));

	N242_4 :=__common__( map((nf_fp_varrisktype in ['-1', '6', '8'])                    => -0.0098314899,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '7', '9']) => N242_5,
																				N242_5));

	N242_3 :=__common__( map(trim(C_WHITE_COL) = ''              => 0.0034608329,
				  ((real)c_white_col < 20.4500007629) => -0.004257368,
														 0.0034608329));

	N242_2 :=__common__( if(((real)c_retired < 8.75), N242_3, N242_4));

	N242_1 :=__common__( if(trim(C_RETIRED) != '', N242_2, -0.0027492964));

	N243_7 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '4', '8'])      => -0.0076257113,
				  (nf_fp_assocrisktype in ['3', '5', '6', '7', '9']) => 0.0069130288,
																		-0.0076257113));

	N243_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['4', '5'])                          => -0.023909321,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '3', '6', '7', '8', '9']) => -0.0033190849,
																						  -0.023909321));

	N243_5 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => -0.014527258,
				  ((real)iv_inq_per_ssn < 8.5)   => N243_6,
													-0.014527258));

	N243_4 :=__common__( map(trim(C_HIGH_HVAL) = ''              => N243_7,
				  ((real)c_high_hval < 1.04999995232) => N243_5,
														 N243_7));

	N243_3 :=__common__( map((nf_fp_varrisktype in ['3', '4', '6', '7', '8', '9']) => N243_4,
				  (nf_fp_varrisktype in ['-1', '1', '2', '5'])          => 0.00031316564,
																		   N243_4));

	N243_2 :=__common__( if(((real)c_span_lang < 125.5), 0.0019099737, N243_3));

	N243_1 :=__common__( if(trim(C_SPAN_LANG) != '', N243_2, -0.0005351929));

	N244_7 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '106', '108', '110', '111', '112']) => -0.0061878408,
				  (iv_phnpop_x_nap_summary in ['107', '109'])                                                                                                   => 0.084145716,
																																								   -0.0061878408));

	N244_6 :=__common__( map(trim(C_SERV_EMPL) = ''     => N244_7,
				  ((real)c_serv_empl < 70.5) => 0.0039948847,
												N244_7));

	N244_5 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N244_6,
				  (nf_fp_divrisktype in ['8', '9'])                          => 0.080287065,
																				N244_6));

	N244_4 :=__common__( map(((real)nf_accident_recency <= NULL) => N244_5,
				  ((real)nf_accident_recency < 4.5)   => 0.0011745064,
														 N244_5));

	N244_3 :=__common__( if(trim(C_LARCENY) != '', N244_4, 0.0013110709));

	N244_2 :=__common__( if(((real)nf_accident_recency > NULL), N244_3, -0.0055583521));

	N244_1 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N244_2,
				  (nf_fp_idverrisktype in ['7', '9'])                          => 0.013228065,
																				  N244_2));

	N245_7 :=__common__( map(((real)iv_inp_addr_address_score <= NULL) => -0.0036042319,
				  ((integer)iv_inp_addr_address_score < 95) => -0.015469847,
															   -0.0036042319));

	N245_6 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => N245_7,
				  (iv_vp100_phn_prob in ['4 Invalid'])                                                                                      => 0.070948077,
																																			   N245_7));

	N245_5 :=__common__( map(((real)iv_mos_src_bureau_dob_fseen <= NULL) => 7.8212304e-005,
				  ((real)iv_mos_src_bureau_dob_fseen < 16.5)  => -0.010368761,
																 7.8212304e-005));

	N245_4 :=__common__( map((nf_fp_idrisktype in ['3', '4', '9'])                => N245_5,
				  (nf_fp_idrisktype in ['1', '2', '5', '6', '7', '8']) => 0.00075132455,
																		  0.00075132455));

	N245_3 :=__common__( map(((real)iv_vo_addrs_per_adl <= NULL) => N245_6,
				  ((real)iv_vo_addrs_per_adl < 2.5)   => N245_4,
														 N245_6));

	N245_2 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12]) => N245_3,
				  (iv_nas_summary in [1])                                                             => 0.057559955,
																											N245_3));

	N245_1 :=__common__( if(((real)iv_vo_addrs_per_adl > NULL), N245_2, -0.0025959563));

	N246_8 :=__common__( map((iv_ssn_miskey in ['0']) => 0.0013895406,
				  (iv_ssn_miskey in ['1']) => 0.026635016,
											  0.026635016));

	N246_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '8'])      => N246_8,
				  (nf_fp_srchcomponentrisktype in ['3', '5', '6', '7', '9']) => 0.012087843,
																				0.012087843));

	N246_6 :=__common__( map(((real)iv_src_voter_adl_count <= NULL) => -0.0087267169,
				  ((real)iv_src_voter_adl_count < 3.5)   => 0.0027828039,
															-0.0087267169));

	N246_5 :=__common__( if(((real)c_fammar18_p < 27.3499984741), N246_6, -0.0018984367));

	N246_4 :=__common__( if(trim(C_FAMMAR18_P) != '', N246_5, -0.0066835409));

	N246_3 :=__common__( map((iv_pb_profile in ['2 Online Shopper', '4 Other'])                              => -0.0081588969,
				  (iv_pb_profile in ['0 No Purch Data', '1 Offline Shopper', '3 Retail Shopper']) => N246_4,
																									 N246_4));

	N246_2 :=__common__( if(((real)nf_highest_rel_income < 112.5), N246_3, N246_7));

	N246_1 :=__common__( if(((real)nf_highest_rel_income > NULL), N246_2, 0.00021849603));

	N247_8 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0']) => 0.0022518714,
				  (iv_paw_dead_bus_x_active_phn in ['2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3'])               => 0.040264586,
																													   0.0022518714));

	N247_7 :=__common__( map(((real)iv_dist_bst_addr_to_prv_addr <= NULL) => -0.010035799,
				  ((real)iv_dist_bst_addr_to_prv_addr < 205.5) => N247_8,
																  -0.010035799));

	N247_6 :=__common__( map(((real)iv_src_bureau_lname_count <= NULL) => N247_7,
				  ((real)iv_src_bureau_lname_count < 59.5)  => -0.0052849312,
															   N247_7));

	N247_5 :=__common__( if(((real)c_white_col < 29.8499984741), -0.0018368044, 0.0031939687));

	N247_4 :=__common__( if(trim(C_WHITE_COL) != '', N247_5, -0.0052212734));

	N247_3 :=__common__( map(((real)iv_src_bureau_dob_count <= NULL) => 0.0098327713,
				  ((real)iv_src_bureau_dob_count < 32.5)  => N247_4,
															 0.0098327713));

	N247_2 :=__common__( if(((real)iv_src_bureau_ssn_count < 49.5), N247_3, N247_6));

	N247_1 :=__common__( if(((real)iv_src_bureau_ssn_count > NULL), N247_2, 0.0061161106));

	N248_7 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2', 'NONE']) => 0.002646023,
				  (iv_best_match_address in ['ADD3'])                 => 0.029467713,
																		 0.002646023));

	N248_6 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '15', '25', '30', '40', '5']) => N248_7,
				  (iv_inp_addr_mortgage_term in ['0', '10', '20'])                   => 0.052021014,
																						N248_7));

	N248_5 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.00051487978,
				  ((real)c_oldhouse < 10.9499998093) => N248_6,
														-0.00051487978));

	N248_4 :=__common__( map((nf_fp_varrisktype in ['6', '8', '9'])                      => -0.0263426,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '7']) => -0.0096095656,
																				 -0.0096095656));

	N248_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '3-0', '3-1', '3-2', '3-3']) => N248_4,
				  (iv_criminal_x_felony in ['2-0', '2-1', '2-2'])                             => 0.03858573,
																								 N248_4));

	N248_2 :=__common__( if(((real)c_easiqlife < 51.5), N248_3, N248_5));

	N248_1 :=__common__( if(trim(C_EASIQLIFE) != '', N248_2, 0.0038917136));

	N249_8 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '9']) => -0.0010679062,
				  (nf_fp_idverrisktype in ['7', '8'])                          => 0.031652082,
																				  -0.0010679062));

	N249_7 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-1']) => 0.0049633991,
				  (iv_criminal_x_felony in ['1-1', '3-2', '3-3'])                             => 0.020498947,
																								 0.0049633991));

	N249_6 :=__common__( map(trim(C_RENTAL) = ''      => N249_8,
				  ((real)c_rental < 101.5) => N249_7,
											  N249_8));

	N249_5 :=__common__( map(((real)nf_rel_derog_summary <= NULL) => N249_6,
				  ((real)nf_rel_derog_summary < 5.5)   => -0.0012090278,
														  N249_6));

	N249_4 :=__common__( map(trim(C_POP_0_5_P) = ''              => -0.0083033578,
				  ((real)c_pop_0_5_p < 17.0499992371) => N249_5,
														 -0.0083033578));

	N249_3 :=__common__( if(((real)nf_rel_derog_summary > NULL), N249_4, 0.0042889857));

	N249_2 :=__common__( if(((real)c_hval_100k_p < 45.75), N249_3, 0.0093625594));

	N249_1 :=__common__( if(trim(C_HVAL_100K_P) != '', N249_2, -0.0016159221));

	N250_6 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => 0.0042349499,
				  (iv_liens_unrel_x_rel in ['1-0', '1-2', '3-0'])                                           => 0.021546807,
																											   0.0042349499));

	N250_5 :=__common__( map((nf_bus_name_match in [0, 1])      => N250_6,
				  (nf_bus_name_match in [2, 3, 4]) => 0.057512074,
															0.057512074));

	N250_4 :=__common__( map((nf_fp_prevaddroccupantowned in ['0'])       => 0.00063686011,
				  (nf_fp_prevaddroccupantowned in ['-1', '1']) => N250_5,
																  N250_5));

	N250_3 :=__common__( if(((real)c_relig_indx < 161.5), -0.00064645067, N250_4));

	N250_2 :=__common__( if(trim(C_RELIG_INDX) != '', N250_3, -0.00077498466));

	N250_1 :=__common__( map((iv_ssn_miskey in ['0']) => N250_2,
				  (iv_ssn_miskey in ['1']) => 0.01068744,
											  0.01068744));

	N251_10 :=__common__( if(((real)c_pop_35_44_p < 16.8499984741), -0.0078355459, 0.0029418785));

	N251_9 :=__common__( if(trim(C_POP_35_44_P) != '', N251_10, 0.027539324));

	N251_8 :=__common__( if(((real)iv_adls_per_sfd_addr_c6 < 3.5), -0.00010930216, 0.0054344711));

	N251_7 :=__common__( if(((real)iv_adls_per_sfd_addr_c6 > NULL), N251_8, 0.040113244));

	N251_6 :=__common__( if(((real)c_med_yearblt < 1999.5), N251_7, 0.011192228));

	N251_5 :=__common__( if(trim(C_MED_YEARBLT) != '', N251_6, -0.0056575098));

	N251_4 :=__common__( map(((real)nf_fp_addrchangeincomediff <= NULL)   => -0.011159695,
				  ((real)nf_fp_addrchangeincomediff < 48885.5) => N251_5,
																  -0.011159695));

	N251_3 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '6', '7']) => N251_4,
				  (nf_fp_idverrisktype in ['5', '8', '9'])                => 0.014240182,
																			 N251_4));

	N251_2 :=__common__( if(((integer)nf_accident_recency < 30), N251_3, N251_9));

	N251_1 :=__common__( if(((real)nf_accident_recency > NULL), N251_2, -0.0038528124));

	N252_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.00086031816,
				  (iv_criminal_x_felony in ['3-3'])                                                         => 0.029297484,
																											   0.00086031816));

	N252_7 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '003', '005', '008', '100', '101', '102', '103', '104', '105', '106', '107', '109', '112']) => 0.004588321,
				  (iv_phnpop_x_nap_summary in ['000', '108', '110', '111'])                                                                       => 0.022440001,
																																					 0.004588321));

	N252_6 :=__common__( map(((real)iv_dob_src_ct <= NULL) => N252_8,
				  ((real)iv_dob_src_ct < 2.5)   => N252_7,
												   N252_8));

	N252_5 :=__common__( if(((real)c_inc_25k_p < 5.44999980927), N252_6, -0.0008106195));

	N252_4 :=__common__( if(trim(C_INC_25K_P) != '', N252_5, -0.0053388756));

	N252_3 :=__common__( map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => N252_4,
				  (iv_vp100_phn_prob in ['4 Invalid'])                                                                                      => 0.023788653,
																																			   N252_4));

	N252_2 :=__common__( if(((real)iv_dist_bst_addr_to_prv_addr < 882.5), N252_3, -0.0057860177));

	N252_1 :=__common__( if(((real)iv_dist_bst_addr_to_prv_addr > NULL), N252_2, -0.00420524));

	N253_8 :=__common__( map((iv_in001_wealth_index in ['2', '4'])           => -0.0010813804,
				  (iv_in001_wealth_index in ['1', '3', '5', '6']) => 0.012131603,
																	 0.012131603));

	N253_7 :=__common__( if(((real)iv_inq_phones_per_adl < 2.5), -0.00011158317, N253_8));

	N253_6 :=__common__( if(((real)iv_inq_phones_per_adl > NULL), N253_7, -0.0094688525));

	N253_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N253_6,
				  (iv_criminal_x_felony in ['1-1', '3-3'])                                           => 0.011957265,
																										N253_6));

	N253_4 :=__common__( map((iv_inp_own_prop_x_addr_naprop in ['01', '04', '11', '13'])             => -0.0047269186,
				  (iv_inp_own_prop_x_addr_naprop in ['00', '02', '03', '10', '12', '14']) => 0.015330212,
																							 0.015330212));

	N253_3 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '3-1', '3-2', '4-1', '4-2', '4-3', '5-1', '5-3']) => -0.0035812149,
				  (iv_gong_did_fname_x_lname_ct in ['1-2', '2-2', '2-3', '3-3', '5-2'])                                                         => N253_4,
																																				   N253_4));

	N253_2 :=__common__( if(((real)c_very_rich < 58.5), N253_3, N253_5));

	N253_1 :=__common__( if(trim(C_VERY_RICH) != '', N253_2, -0.0019059463));

	N254_7 :=__common__( map((nf_fp_idverrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => -0.0038277258,
				  (nf_fp_idverrisktype in ['8'])                                    => 0.029302112,
																					   -0.0038277258));

	N254_6 :=__common__( map((nf_fp_corrrisktype in ['2', '3', '7'])                => -0.0033671846,
				  (nf_fp_corrrisktype in ['1', '4', '5', '6', '8', '9']) => 0.011171315,
																			0.011171315));

	N254_5 :=__common__( map(trim(C_SUB_BUS) = ''      => N254_6,
				  ((real)c_sub_bus < 158.5) => 0.0016751939,
											   N254_6));

	N254_4 :=__common__( map(trim(C_POP_12_17_P) = ''              => N254_5,
				  ((real)c_pop_12_17_p < 3.15000009537) => -0.0063346274,
														   N254_5));

	N254_3 :=__common__( map(trim(C_MANUFACTURING) = ''              => N254_7,
				  ((real)c_manufacturing < 2.84999990463) => N254_4,
															 N254_7));

	N254_2 :=__common__( if(((real)c_rape < 38.5), -0.0042518216, N254_3));

	N254_1 :=__common__( if(trim(C_RAPE) != '', N254_2, 0.0011170693));

	N255_8 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-1']) => 0.0057258806,
				  (iv_criminal_x_felony in ['1-1', '2-2', '3-0', '3-2', '3-3']) => 0.022210737,
																				   0.022210737));

	N255_7 :=__common__( map(((real)nf_util_adl_count <= NULL) => N255_8,
				  ((real)nf_util_adl_count < 2.5)   => -0.0034418918,
													   N255_8));

	N255_6 :=__common__( map((iv_input_dob_match_level in ['1', '3', '8'])                => N255_7,
				  (iv_input_dob_match_level in ['0', '2', '4', '5', '6', '7']) => 0.028733216,
																				  0.028733216));

	N255_5 :=__common__( map(((real)iv_mos_since_impulse_first_seen <= NULL) => N255_6,
				  ((real)iv_mos_since_impulse_first_seen < 7.5)   => 4.0054877e-005,
																	 N255_6));

	N255_4 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '7 PCS'])                                  => -0.003170488,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid', '5 Cell', '6 Pager', '8 Pay_Phone']) => N255_5,
																													 N255_5));

	N255_3 :=__common__( if(((real)iv_inq_addrs_per_adl > NULL), N255_4, -0.0014366509));

	N255_2 :=__common__( if(((real)c_transport < 24.0499992371), N255_3, 0.008727843));

	N255_1 :=__common__( if(trim(C_TRANSPORT) != '', N255_2, -0.0023508249));

	N256_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2']) => -0.0041239874,
				  (iv_criminal_x_felony in ['2-2', '3-3'])                                           => 0.038109267,
																										-0.0041239874));

	N256_5 :=__common__( map((nf_fp_varrisktype in ['5', '6', '7', '8'])            => -0.016521449,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '9']) => N256_6,
																			N256_6));

	N256_4 :=__common__( map(((real)iv_src_liens_adl_count <= NULL) => 0.012058381,
				  ((real)iv_src_liens_adl_count < 6.5)   => 0.00084764345,
															0.012058381));

	N256_3 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr < 884.5), N256_4, N256_5));

	N256_2 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N256_3, 0.00076756707));

	N256_1 :=__common__( map((nf_fp_srchcomponentrisktype in ['8', '9'])                          => -0.0066926878,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '7']) => N256_2,
																						  N256_2));

	N257_7 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-0', '1-3', '2-1', '2-3', '3-0', '3-1']) => -0.0009013946,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['1-1', '2-0', '3-3'])                                                  => 0.010473453,
																															  -0.0009013946));

	N257_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '4', '5', '7', '8', '9']) => N257_7,
				  (nf_fp_srchcomponentrisktype in ['2', '3', '6'])                => 0.013509826,
																					 0.013509826));

	N257_5 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 6, 7, 8, 9, 10, 12]) => N257_6,
				  (iv_nas_summary in [1, 11])                                                 => 0.084000662,
																									  N257_6));

	N257_4 :=__common__( map((nf_fp_varrisktype in ['-1', '7', '8'])                    => -0.0074943701,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '9']) => -0.00090069769,
																				-0.00090069769));

	N257_3 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '13 Vacant']) => N257_4,
				  (iv_va100_add_problem in ['11 Throw Back', '12 College'])                                                                                                                                                                                                                            => 0.031393889,
																																																																										  0.031393889));

	N257_2 :=__common__( if(((real)c_armforce < 132.5), N257_3, N257_5));

	N257_1 :=__common__( if(trim(C_ARMFORCE) != '', N257_2, 0.0045851569));

	N258_9 :=__common__( map(((real)nf_average_rel_criminal_dist <= NULL) => -0.0039623115,
				  ((real)nf_average_rel_criminal_dist < 211.5) => 0.0012855433,
																  -0.0039623115));

	N258_8 :=__common__( if(((real)c_pop_18_24_p < 12.5500001907), 0.010819101, -0.0044286037));

	N258_7 :=__common__( if(trim(C_POP_18_24_P) != '', N258_8, 0.0086860735));

	N258_6 :=__common__( if(((real)iv_mos_since_bst_addr_fseen < 2.5), N258_7, N258_9));

	N258_5 :=__common__( if(((real)iv_mos_since_bst_addr_fseen > NULL), N258_6, -0.0055772287));

	N258_4 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '12 College', '13 Vacant']) => 0.0021581589,
				  (iv_va100_add_problem in ['04 HiRisk Commercial', '11 Throw Back'])                                                                                                                                                                                                        => 0.070576435,
																																																																								0.0021581589));

	N258_3 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '5', '7', '8']) => N258_4,
				  (nf_fp_srchcomponentrisktype in ['4', '6', '9'])                => 0.016030398,
																					 0.016030398));

	N258_2 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '6', '9']) => -0.0032742316,
				  (nf_fp_sourcerisktype in ['5', '7', '8'])                => N258_3,
																			  N258_3));

	N258_1 :=__common__( if(((real)iv_inp_addr_avm_pct_change_1yr > NULL), N258_2, N258_5));

	N259_9 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '13 Vacant']) => 0.00036614136,
				  (iv_va100_add_problem in ['03 Standarization Error', '12 College'])                                                                                                                                                                                                        => 0.10159331,
																																																																								0.00036614136));

	N259_8 :=__common__( map(trim(C_RETAIL) = ''              => N259_9,
				  ((real)c_retail < 0.15000000596) => 0.016291041,
													  N259_9));

	N259_7 :=__common__( map((nf_bus_phone_match in [1])           => -0.0041107635,
				  (nf_bus_phone_match in [0, 2, 3]) => 0.00056610985,
															 0.00056610985));

	N259_6 :=__common__( if(((integer)nf_bst_addr_nhood_pct_mfd < 75), N259_7, N259_8));

	N259_5 :=__common__( if(((real)nf_bst_addr_nhood_pct_mfd > NULL), N259_6, -0.00056155669));

	N259_4 :=__common__( if(((real)iv_addr_lres_12mo_count < 9.5), -0.0077071172, 0.0056432182));

	N259_3 :=__common__( if(((real)iv_addr_lres_12mo_count > NULL), N259_4, -0.0026811909));

	N259_2 :=__common__( if(((real)c_rape < 34.5), N259_3, N259_5));

	N259_1 :=__common__( if(trim(C_RAPE) != '', N259_2, 0.00053402708));

	N260_9 :=__common__( map((nf_fp_corrrisktype in ['1', '2', '4', '5', '8', '9']) => 0.004053012,
				  (nf_fp_corrrisktype in ['3', '6', '7'])                => 0.019778272,
																			0.004053012));

	N260_8 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N260_9,
				  (iv_prv_addr_mortgage_type in ['Piggyback'])                                                                                                                  => 0.28287533,
																																												   N260_9));

	N260_7 :=__common__( if(((real)c_hval_60k_p < 16.3499984741), 2.0773357e-005, N260_8));

	N260_6 :=__common__( if(trim(C_HVAL_60K_P) != '', N260_7, 0.0029564449));

	N260_5 :=__common__( if(((integer)iv_pv001_bst_avm_chg_1yr < -16304), 0.014175629, -0.00010095615));

	N260_4 :=__common__( if(((real)iv_pv001_bst_avm_chg_1yr > NULL), N260_5, N260_6));

	N260_3 :=__common__( map((nf_fp_validationrisktype in ['1', '8'])                => -0.0017119156,
				  (nf_fp_validationrisktype in ['2', '3', '4', '5', '6']) => 0.018595332,
																			 -0.0017119156));

	N260_2 :=__common__( if(((real)iv_inp_addr_lres < 22.5), N260_3, N260_4));

	N260_1 :=__common__( if(((real)iv_inp_addr_lres > NULL), N260_2, 0.00010744591));

	N261_8 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => -0.00062653119,
				  ((real)iv_mos_since_prv_addr_fseen < 11.5)  => -0.010472588,
																 -0.00062653119));

	N261_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '6', '7', '8', '9']) => 0.010903113,
				  (nf_fp_srchcomponentrisktype in ['3', '4', '5'])                => 0.060349043,
																					 0.010903113));

	N261_6 :=__common__( map(trim(C_MED_AGE) = ''              => N261_7,
				  ((real)c_med_age < 40.0499992371) => 0.0020530052,
													   N261_7));

	N261_5 :=__common__( map(((real)nf_fp_srchssnsrchcountmo <= NULL) => N261_8,
				  ((real)nf_fp_srchssnsrchcountmo < 0.5)   => N261_6,
															  N261_8));

	N261_4 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '5', '6'])      => -0.0028031304,
				  (nf_fp_srchcomponentrisktype in ['3', '4', '7', '8', '9']) => 0.0059737184,
																				0.0059737184));

	N261_3 :=__common__( if(((real)c_child < 24.25), N261_4, N261_5));

	N261_2 :=__common__( if(trim(C_CHILD) != '', N261_3, 0.0018087878));

	N261_1 :=__common__( if(((real)iv_inq_other_recency > NULL), N261_2, 0.0035221088));

	N262_8 :=__common__( map(((real)nf_fp_prevaddrmedianincome <= NULL)   => -0.00080971739,
				  ((real)nf_fp_prevaddrmedianincome < 48050.5) => 0.012735225,
																  -0.00080971739));

	N262_7 :=__common__( map(trim(C_HVAL_400K_P) = ''              => 0.0094049429,
				  ((real)c_hval_400k_p < 18.3499984741) => -0.0024479241,
														   0.0094049429));

	N262_6 :=__common__( map(trim(C_EXP_PROD) = ''      => N262_8,
				  ((real)c_exp_prod < 110.5) => N262_7,
												N262_8));

	N262_5 :=__common__( map((nf_fp_validationrisktype in ['1', '2', '3', '4', '8']) => N262_6,
				  (nf_fp_validationrisktype in ['5', '6'])                => 0.10843862,
																			 N262_6));

	N262_4 :=__common__( if(((real)c_cartheft < 114.5), -0.0046147994, N262_5));

	N262_3 :=__common__( if(trim(C_CARTHEFT) != '', N262_4, 0.0027479388));

	N262_2 :=__common__( if(((real)iv_mos_src_bureau_addr_fseen < 16.5), N262_3, 0.0018469635));

	N262_1 :=__common__( if(((real)iv_mos_src_bureau_addr_fseen > NULL), N262_2, -0.00020330627));

	N263_8 :=__common__( map(trim(C_EXP_PROD) = ''     => 0.0038129541,
				  ((real)c_exp_prod < 31.5) => 0.011763758,
											   0.0038129541));

	N263_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-1', '2-2', '2-3', '3-3']) => N263_8,
				  (iv_paw_dead_bus_x_active_phn in ['1-2', '2-0', '3-0', '3-1', '3-2'])                                           => 0.042360817,
																																	 N263_8));

	N263_6 :=__common__( map((iv_ed001_college_ind_60 in ['1']) => -0.0046910492,
				  (iv_ed001_college_ind_60 in ['0']) => N263_7,
														-0.0046910492));

	N263_5 :=__common__( map(((real)nf_fp_srchphonesrchcount <= NULL) => -0.0051336402,
				  ((real)nf_fp_srchphonesrchcount < 5.5)   => N263_6,
															  -0.0051336402));

	N263_4 :=__common__( if(((real)iv_addr_non_phn_src_ct < 2.5), N263_5, -0.00054027103));

	N263_3 :=__common__( if(((real)iv_addr_non_phn_src_ct > NULL), N263_4, 0.0038115486));

	N263_2 :=__common__( if(((real)c_pop_85p_p < 1.75), N263_3, -0.0025969604));

	N263_1 :=__common__( if(trim(C_POP_85P_P) != '', N263_2, 0.0030267377));

	N264_6 :=__common__( map(trim(C_LOW_ED) = ''              => 0.0067375372,
				  ((real)c_low_ed < 53.8499984741) => -0.00096600744,
													  0.0067375372));

	N264_5 :=__common__( map(((real)nf_fp_addrchangeincomediff <= NULL)     => N264_6,
				  ((integer)nf_fp_addrchangeincomediff < -17321) => -0.0085235651,
																	N264_6));

	N264_4 :=__common__( map(trim(C_HH6_P) = ''              => -0.0070058696,
				  ((real)c_hh6_p < 5.44999980927) => N264_5,
													 -0.0070058696));

	N264_3 :=__common__( if(((real)c_hh00 < 326.5), -0.0091879146, N264_4));

	N264_2 :=__common__( if(trim(C_HH00) != '', N264_3, -0.0067460045));

	N264_1 :=__common__( map((nf_fp_varrisktype in ['-1', '4', '5', '6', '7', '8', '9']) => N264_2,
				  (nf_fp_varrisktype in ['1', '2', '3'])                      => 0.0012163164,
																				 0.0012163164));

	N265_8 :=__common__( map((iv_phnpop_x_nap_summary in ['005', '103', '106'])                                                                                     => -0.018550505,
				  (iv_phnpop_x_nap_summary in ['000', '002', '003', '008', '100', '101', '102', '104', '105', '107', '108', '109', '110', '111', '112']) => 0.0021726392,
																																							0.0021726392));

	N265_7 :=__common__( map(((real)iv_bst_addr_assessed_total_val <= NULL)     => 0.01462452,
				  ((integer)iv_bst_addr_assessed_total_val < 184650) => N265_8,
																		0.01462452));

	N265_6 :=__common__( map(trim(C_MED_AGE) = ''              => -0.0007092396,
				  ((real)c_med_age < 24.0499992371) => -0.010045655,
													   -0.0007092396));

	N265_5 :=__common__( if(((real)nf_util_adl_count < 5.5), N265_6, N265_7));

	N265_4 :=__common__( if(((real)nf_util_adl_count > NULL), N265_5, -0.00016918039));

	N265_3 :=__common__( map((nf_fp_validationrisktype in ['1', '2', '3', '4', '8']) => N265_4,
				  (nf_fp_validationrisktype in ['5', '6'])                => 0.048826429,
																			 N265_4));

	N265_2 :=__common__( if(((real)c_pop_85p_p < 8.35000038147), N265_3, 0.013374493));

	N265_1 :=__common__( if(trim(C_POP_85P_P) != '', N265_2, -0.0031063761));

	N266_8 :=__common__( map(((real)nf_fp_srchphonesrchcount <= NULL) => -0.0029559465,
				  ((real)nf_fp_srchphonesrchcount < 6.5)   => 0.011373887,
															  -0.0029559465));

	N266_7 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N266_8,
				  (iv_prv_addr_mortgage_type in ['Piggyback'])                                                                                                                  => 0.13341142,
																																												   N266_8));

	N266_6 :=__common__( if(((real)c_sub_bus < 152.5), -0.00060393918, 0.0037955184));

	N266_5 :=__common__( if(trim(C_SUB_BUS) != '', N266_6, 0.0030719339));

	N266_4 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => N266_7,
				  ((real)nf_fp_srchfraudsrchcount < 22.5)  => N266_5,
															  N266_7));

	N266_3 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => -0.0087943257,
				  ((real)iv_inq_per_ssn < 18.5)  => N266_4,
													-0.0087943257));

	N266_2 :=__common__( if(((real)nf_fp_srchfraudsrchcountwk < 1.5), N266_3, 0.008120912));

	N266_1 :=__common__( if(((real)nf_fp_srchfraudsrchcountwk > NULL), N266_2, 0.0062809029));

	N267_9 :=__common__( if(((real)c_preschl < 118.5), 0.014146685, -0.00093374834));

	N267_8 :=__common__( if(trim(C_PRESCHL) != '', N267_9, -0.001140849));

	N267_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-2', '3-3']) => 0.0077251912,
				  (iv_paw_dead_bus_x_active_phn in ['0-3', '3-1'])                                                                                     => 0.13750694,
																																						  0.0077251912));

	N267_6 :=__common__( map(trim(C_INC_15K_P) = ''              => -0.0025276121,
				  ((real)c_inc_15k_p < 4.05000019073) => N267_7,
														 -0.0025276121));

	N267_5 :=__common__( if(((real)c_inc_50k_p < 13.6499996185), 0.0032735134, N267_6));

	N267_4 :=__common__( if(trim(C_INC_50K_P) != '', N267_5, 0.001874281));

	N267_3 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => -0.0030794115,
				  ((real)nf_fp_corrphonelastnamecount < 0.5)   => N267_4,
																  -0.0030794115));

	N267_2 :=__common__( if(((real)nf_fp_srchphonesrchcountmo < 1.5), N267_3, N267_8));

	N267_1 :=__common__( if(((real)nf_fp_srchphonesrchcountmo > NULL), N267_2, 0.0035463671));

	N268_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '5', '6', '8']) => -0.0093816032,
				  (nf_fp_srchcomponentrisktype in ['4', '7', '9'])                => 0.019527821,
																					 -0.0093816032));

	N268_7 :=__common__( map((nf_fp_idverrisktype in ['2', '3', '4', '5', '6', '7']) => 0.0031575956,
				  (nf_fp_idverrisktype in ['1', '8', '9'])                => 0.038344995,
																			 0.0031575956));

	N268_6 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)    => N268_7,
				  ((integer)nf_fp_curraddrmedianincome < 33741) => -0.0080845611,
																   N268_7));

	N268_5 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Non-Traditional', 'Piggyback']) => N268_6,
				  (iv_prv_addr_mortgage_type in ['High-Risk', 'Other', 'Unknown'])                                                                          => 0.013620381,
																																							   N268_6));

	N268_4 :=__common__( if(((real)nf_fp_corrssnaddrcount < 0.5), N268_5, 0.00032610196));

	N268_3 :=__common__( if(((real)nf_fp_corrssnaddrcount > NULL), N268_4, -0.003032138));

	N268_2 :=__common__( if(((real)c_hh1_p < 54.6500015259), N268_3, N268_8));

	N268_1 :=__common__( if(trim(C_HH1_P) != '', N268_2, -0.0012110814));

	N269_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '06 Invalid Address', '09 Corporate Zip Code', '10 Zip/City Mismatch', '12 College']) => 0.0081698088,
				  (iv_va100_add_problem in ['03 Standarization Error', '05 Drop Delivery', '07 Busines', '11 Throw Back', '13 Vacant'])                                                                                                    => 0.038654042,
																																																											  0.0081698088));

	N269_5 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => 0.0034947756,
				  ((real)iv_mos_since_prv_addr_fseen < 11.5)  => N269_6,
																 0.0034947756));

	N269_4 :=__common__( map((iv_bst_addr_naprop in ['2', '4'])      => -0.008970144,
				  (iv_bst_addr_naprop in ['0', '1', '3']) => N269_5,
															 N269_5));

	N269_3 :=__common__( if(((real)nf_fp_prevaddrcartheftindex < 137.5), -0.00063725506, N269_4));

	N269_2 :=__common__( if(((real)nf_fp_prevaddrcartheftindex > NULL), N269_3, -0.0011731648));

	N269_1 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '0-3', '1-0', '1-1', '2-3'])                      => -0.0029616308,
				  (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '1-3', '2-0', '2-1', '3-0', '3-1', '3-3']) => N269_2,
																												N269_2));

	N270_5 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant']) => 0.005473922,
				  (iv_va100_add_problem in ['03 Standarization Error'])                                                                                                                                                                                                                                    => 0.08073814,
																																																																											  0.08073814));

	N270_4 :=__common__( map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1', '2-2']) => N270_5,
				  (iv_num_purch_x_num_sold_60 in ['0-2', '1-2'])                                    => 0.16043258,
																									   N270_5));

	N270_3 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => N270_4,
				  ((real)iv_inq_per_ssn < 13.5)  => -0.00043928432,
													N270_4));

	N270_2 :=__common__( map((iv_cvi in [10, 20, 30, 40, 50]) => N270_3,
				  (iv_cvi in [0])                         => 0.016945456,
																N270_3));

	N270_1 :=__common__( map((nf_fp_varrisktype in ['7', '9'])                                => -0.0055852051,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6', '8']) => N270_2,
																					  N270_2));

	N271_7 :=__common__( map((iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '3 Monthly', '5 Quarterly', '6 Semi-yearly', '7 Yearly']) => -0.0063025546,
				  (iv_pb_order_freq in ['2 Weekly', '4 Semi-monthly', '8 Rarely'])                                                       => 0.041296552,
																																			-0.0063025546));

	N271_6 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-1', '2-0', '3-2'])               => N271_7,
				  (iv_criminal_x_felony in ['1-0', '2-1', '2-2', '3-0', '3-1', '3-3']) => 0.0152175,
																						  0.0152175));

	N271_5 :=__common__( map(((real)iv_src_bureau_dob_count <= NULL) => -0.0142036,
				  ((real)iv_src_bureau_dob_count < 29.5)  => N271_6,
															 -0.0142036));

	N271_4 :=__common__( map((nf_fp_divrisktype in ['1', '2', '4', '5', '6', '7', '9']) => 0.0021543989,
				  (nf_fp_divrisktype in ['3', '8'])                          => 0.016394376,
																				0.0021543989));

	N271_3 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '3-1', '3-2', '4-3', '5-1', '5-3'])               => -0.00046584058,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-3', '4-1', '4-2', '5-2']) => N271_4,
																															  N271_4));

	N271_2 :=__common__( if(((integer)iv_dist_inp_addr_to_prv_addr < 757), N271_3, N271_5));

	N271_1 :=__common__( if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N271_2, 0.0045435935));

	N272_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => -0.0057537626,
				  (iv_gong_did_fname_x_lname_ct in ['0-1'])                                                                                                                 => 0.12398919,
																																											   -0.0057537626));

	N272_5 :=__common__( map((nf_fp_varrisktype in ['1', '4', '5', '8'])            => -0.00039567989,
				  (nf_fp_varrisktype in ['-1', '2', '3', '6', '7', '9']) => 0.003372541,
																			0.003372541));

	N272_4 :=__common__( map(trim(C_MORT_INDX) = ''      => -0.0031921587,
				  ((real)c_mort_indx < 129.5) => N272_5,
												 -0.0031921587));

	N272_3 :=__common__( if(((real)c_rich_fam < 182.5), N272_4, N272_6));

	N272_2 :=__common__( if(trim(C_RICH_FAM) != '', N272_3, -0.0010484456));

	N272_1 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '6', '8', '9']) => N272_2,
				  (nf_fp_srchcomponentrisktype in ['5', '7'])                          => 0.0082431684,
																						  0.0082431684));

	N273_7 :=__common__( map((nf_fp_varrisktype in ['-1', '1', '2', '3', '5', '8', '9']) => 0.0051273189,
				  (nf_fp_varrisktype in ['4', '6', '7'])                      => 0.020909087,
																				 0.0051273189));

	N273_6 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '003', '005', '100', '102', '104', '105', '106', '107', '108', '111', '112']) => N273_7,
				  (iv_phnpop_x_nap_summary in ['000', '008', '101', '103', '109', '110'])                                           => 0.05060624,
																																	   N273_7));

	N273_5 :=__common__( map((iv_cvi in [0, 10, 40]) => -0.0048099713,
				  (iv_cvi in [20, 30, 50]) => N273_6,
													N273_6));

	N273_4 :=__common__( map((iv_nas_summary in [0, 1, 3, 4, 6, 7, 9, 10, 12]) => N273_5,
				  (iv_nas_summary in [2, 8, 11])                                     => 0.059050124,
																								N273_5));

	N273_3 :=__common__( map((iv_nas_summary in [2, 6, 7, 8, 10, 11]) => -0.011255183,
				  (iv_nas_summary in [0, 1, 3, 4, 9, 12]) => 0.00018404404,
																			  0.00018404404));

	N273_2 :=__common__( if(((real)c_newhouse < 90.1499938965), N273_3, N273_4));

	N273_1 :=__common__( if(trim(C_NEWHOUSE) != '', N273_2, 0.0016782142));

	N274_6 :=__common__( map(((real)iv_combined_age <= NULL) => -0.002347073,
				  ((real)iv_combined_age < 25.5)  => 0.0079816805,
													 -0.002347073));

	N274_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1']) => N274_6,
				  (iv_criminal_x_felony in ['3-2', '3-3'])                                           => 0.02619111,
																										N274_6));

	N274_4 :=__common__( map(((real)iv_mos_src_bureau_addr_fseen <= NULL) => N274_5,
				  ((real)iv_mos_src_bureau_addr_fseen < 26.5)  => -0.0032383638,
																  N274_5));

	N274_3 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen < 182.5), N274_4, 0.001745484));

	N274_2 :=__common__( if(((real)iv_mos_src_bureau_lname_fseen > NULL), N274_3, -0.0055485405));

	N274_1 :=__common__( map((iv_vs002_ssn_prior_dob in ['0']) => N274_2,
				  (iv_vs002_ssn_prior_dob in ['1']) => 0.018505099,
													   0.018505099));

	N275_9 :=__common__( map((iv_bst_addr_financing_type in ['NONE'])              => -0.0069543381,
				  (iv_bst_addr_financing_type in ['ADJ', 'CNV', 'OTH']) => 0.047121017,
																		   -0.0069543381));

	N275_8 :=__common__( if(((real)iv_bst_addr_avm_pct_change_2yr < 0.938523411751), 0.0034582798, -0.013859378));

	N275_7 :=__common__( if(((real)iv_bst_addr_avm_pct_change_2yr > NULL), N275_8, N275_9));

	N275_6 :=__common__( map(trim(C_OLDHOUSE) = ''              => -0.00018455879,
				  ((real)c_oldhouse < 103.350006104) => N275_7,
														-0.00018455879));

	N275_5 :=__common__( map(trim(C_PROFESSIONAL) = ''              => -0.012729256,
				  ((real)c_professional < 14.4499998093) => N275_6,
															-0.012729256));

	N275_4 :=__common__( if(((real)c_white_col < 42.5499992371), N275_5, 0.0032754913));

	N275_3 :=__common__( if(trim(C_WHITE_COL) != '', N275_4, -0.005445545));

	N275_2 :=__common__( if(((real)iv_inp_addr_lres < 22.5), N275_3, 0.0014472694));

	N275_1 :=__common__( if(((real)iv_inp_addr_lres > NULL), N275_2, 0.00029435064));

	N276_8 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '101', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112']) => -0.0077592252,
				  (iv_phnpop_x_nap_summary in ['003', '102'])                                                                                                   => 0.12763853,
																																								   -0.0077592252));

	N276_7 :=__common__( if(((real)nf_fp_addrchangevaluediff < -152843.5), -0.0083862963, 0.00054413122));

	N276_6 :=__common__( if(((real)nf_fp_addrchangevaluediff > NULL), N276_7, -0.005424711));

	N276_5 :=__common__( map(trim(C_LARCENY) = ''      => N276_8,
				  ((real)c_larceny < 193.5) => N276_6,
											   N276_8));

	N276_4 :=__common__( map(trim(C_OLDHOUSE) = ''              => 0.0092080316,
				  ((real)c_oldhouse < 706.650024414) => N276_5,
														0.0092080316));

	N276_3 :=__common__( map(trim(C_WHITE_COL) = ''              => N276_4,
				  ((real)c_white_col < 12.4499998093) => 0.010383931,
														 N276_4));

	N276_2 :=__common__( if(((real)c_pop_0_5_p < 17.75), N276_3, -0.008593734));

	N276_1 :=__common__( if(trim(C_POP_0_5_P) != '', N276_2, 0.00043797713));

	N277_8 :=__common__( map(((real)nf_fp_prevaddrmedianvalue <= NULL)     => -0.00068726753,
				  ((integer)nf_fp_prevaddrmedianvalue < 101820) => 0.017192764,
																   -0.00068726753));

	N277_7 :=__common__( map((nf_fp_idrisktype in ['1', '3', '9'])                => N277_8,
				  (nf_fp_idrisktype in ['2', '4', '5', '6', '7', '8']) => 0.042930885,
																		  0.042930885));

	N277_6 :=__common__( map(trim(C_PRESCHL) = ''      => 0.0092170685,
				  ((real)c_preschl < 162.5) => -0.0028644114,
											   0.0092170685));

	N277_5 :=__common__( map((iv_prv_addr_ownership_lvl in ['Applicant', 'Family', 'No Ownership']) => N277_6,
				  (iv_prv_addr_ownership_lvl in ['Occupant'])                            => N277_7,
																							N277_6));

	N277_4 :=__common__( if(((real)iv_dl_addrs_per_adl < 5.5), -0.0010076598, -0.0097619167));

	N277_3 :=__common__( if(((real)iv_dl_addrs_per_adl > NULL), N277_4, -0.0012503267));

	N277_2 :=__common__( if(((real)c_relig_indx < 166.5), N277_3, N277_5));

	N277_1 :=__common__( if(trim(C_RELIG_INDX) != '', N277_2, 0.00229725));

	N278_8 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'H', 'M', 'P', 'R', 'S', 'U']) => -0.0028235456,
				  (nf_fp_prevaddrdwelltype in ['G'])                                     => 0.14348443,
																							-0.0028235456));

	N278_7 :=__common__( map((nf_fp_varrisktype in ['-1', '8'])                              => -0.019105632,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N278_8,
																					 -0.019105632));

	N278_6 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '03', '04', '10', '13']) => -0.0067097375,
				  (iv_prv_own_prop_x_addr_naprop in ['02', '11', '12', '14'])             => 0.012348696,
																							 0.012348696));

	N278_5 :=__common__( map((iv_inp_addr_mortgage_type in ['Commercial', 'Government', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback']) => -0.00063399181,
				  (iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'High-Risk', 'Unknown'])                              => 0.003817968,
																																		 -0.00063399181));

	N278_4 :=__common__( if(((real)c_blue_col < 21.1500015259), N278_5, N278_6));

	N278_3 :=__common__( if(trim(C_BLUE_COL) != '', N278_4, -0.0029965616));

	N278_2 :=__common__( if(((real)iv_ssns_per_sfd_addr < 21.5), N278_3, N278_7));

	N278_1 :=__common__( if(((real)iv_ssns_per_sfd_addr > NULL), N278_2, -0.0012920649));

	N279_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '2-0', '2-2', '2-3', '3-0', '3-2', '3-3']) => -0.0027780577,
				  (iv_paw_dead_bus_x_active_phn in ['1-2', '1-3', '2-1', '3-1'])                                                         => 0.068919308,
																																			-0.0027780577));

	N279_6 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '5', '7']) => 0.0055921844,
				  (nf_fp_divrisktype in ['6', '8', '9'])                => 0.033457848,
																		   0.0055921844));

	N279_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '3-1'])                                           => 0.001188468,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-2', '3-3']) => N279_6,
																										N279_6));

	N279_4 :=__common__( map(((real)iv_inq_auto_recency <= NULL) => N279_7,
				  ((real)iv_inq_auto_recency < 0.5)   => N279_5,
														 N279_7));

	N279_3 :=__common__( map((iv_pb_order_freq in ['5 Quarterly', '6 Semi-yearly', '8 Rarely'])                                                   => -0.0074910816,
				  (iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '2 Weekly', '3 Monthly', '4 Semi-monthly', '7 Yearly']) => N279_4,
																																		  N279_4));

	N279_2 :=__common__( if(((real)nf_fp_corrphonelastnamecount < 0.5), N279_3, -0.0029042748));

	N279_1 :=__common__( if(((real)nf_fp_corrphonelastnamecount > NULL), N279_2, -0.0053100359));

	N280_8 :=__common__( map(((real)nf_fp_srchfraudsrchcount <= NULL) => 0.0068247587,
				  ((real)nf_fp_srchfraudsrchcount < 22.5)  => -0.00062692192,
															  0.0068247587));

	N280_7 :=__common__( map((iv_input_dob_match_level in ['0', '2', '3', '4', '6', '7', '8']) => N280_8,
				  (iv_input_dob_match_level in ['1', '5'])                          => 0.026415793,
																					   N280_8));

	N280_6 :=__common__( map(trim(C_HH5_P) = ''              => -0.0051041135,
				  ((real)c_hh5_p < 10.9499998093) => N280_7,
													 -0.0051041135));

	N280_5 :=__common__( map(((real)iv_vo_addrs_per_adl <= NULL) => -0.0079332554,
				  ((real)iv_vo_addrs_per_adl < 2.5)   => N280_6,
														 -0.0079332554));

	N280_4 :=__common__( if(trim(C_HH5_P) != '', N280_5, 0.0018115007));

	N280_3 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N280_4,
				  (fp_segment in ['3 New DID'])                                                                           => 0.029650501,
																															 N280_4));

	N280_2 :=__common__( if(((real)iv_email_count < 0.5), 0.0023751909, N280_3));

	N280_1 :=__common__( if(((real)iv_email_count > NULL), N280_2, -0.0080528451));

	N281_7 :=__common__( if(((real)c_fammar18_p < 26.3499984741), 0.008701344, 0.0008214378));

	N281_6 :=__common__( if(trim(C_FAMMAR18_P) != '', N281_7, -0.007717353));

	N281_5 :=__common__( map(((real)iv_src_bureau_ssn_count <= NULL) => -8.9594263e-005,
				  ((real)iv_src_bureau_ssn_count < 20.5)  => N281_6,
															 -8.9594263e-005));

	N281_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-2', '3-2']) => -0.011644765,
				  (iv_liens_unrel_x_rel in ['0-2', '1-2', '2-1', '3-0', '3-1'])               => 0.014259119,
																								 -0.011644765));

	N281_3 :=__common__( if(((integer)nf_fp_addrchangevaluediff < -140641), N281_4, N281_5));

	N281_2 :=__common__( if(((real)nf_fp_addrchangevaluediff > NULL), N281_3, 0.0024414288));

	N281_1 :=__common__( map((iv_pb_profile in ['2 Online Shopper', '4 Other'])                              => -0.0060487667,
				  (iv_pb_profile in ['0 No Purch Data', '1 Offline Shopper', '3 Retail Shopper']) => N281_2,
																									 N281_2));

	N282_6 :=__common__( map((nf_fp_validationrisktype in ['1', '2', '3', '4', '8']) => 0.0040836234,
				  (nf_fp_validationrisktype in ['5', '6'])                => 0.079391643,
																			 0.0040836234));

	N282_5 :=__common__( map((iv_vp001_phn_not_issued in ['0']) => N282_6,
				  (iv_vp001_phn_not_issued in ['1']) => 0.049718632,
														N282_6));

	N282_4 :=__common__( map(((real)nf_fp_srchphonesrchcount <= NULL) => -0.0096866679,
				  ((real)nf_fp_srchphonesrchcount < 5.5)   => N282_5,
															  -0.0096866679));

	N282_3 :=__common__( if(((integer)nf_average_rel_income < 45500), N282_4, -0.00074258744));

	N282_2 :=__common__( if(((real)nf_average_rel_income > NULL), N282_3, 0.0044889584));

	N282_1 :=__common__( map((iv_infutor_nap in ['10', '12', '4', '7'])     => -0.0059537612,
				  (iv_infutor_nap in ['0', '1', '11', '6', '9']) => N282_2,
																	N282_2));

	N283_9 :=__common__( map(((real)nf_fp_prevaddrmedianvalue <= NULL)    => -0.0056660783,
				  ((real)nf_fp_prevaddrmedianvalue < 106472.5) => 0.0085198968,
																  -0.0056660783));

	N283_8 :=__common__( if(((real)c_larceny < 142.5), N283_9, -0.010831311));

	N283_7 :=__common__( if(trim(C_LARCENY) != '', N283_8, 0.002252569));

	N283_6 :=__common__( map(((real)nf_bus_addr_match_count <= NULL) => -0.0030012773,
				  ((real)nf_bus_addr_match_count < 3.5)   => 0.0038243067,
															 -0.0030012773));

	N283_5 :=__common__( if(((real)iv_inq_per_addr < 1.5), -0.0013868175, N283_6));

	N283_4 :=__common__( if(((real)iv_inq_per_addr > NULL), N283_5, 0.0018693465));

	N283_3 :=__common__( map(((real)nf_fp_srchphonesrchcount <= NULL) => N283_7,
				  ((real)nf_fp_srchphonesrchcount < 6.5)   => N283_4,
															  N283_7));

	N283_2 :=__common__( if(((real)iv_mos_since_bst_addr_fseen < 0.5), 0.011028041, N283_3));

	N283_1 :=__common__( if(((real)iv_mos_since_bst_addr_fseen > NULL), N283_2, 0.0016728109));

	N284_8 :=__common__( if(((integer)iv_impulse_annual_income < 25902), -0.0002884955, 0.0096775997));

	N284_7 :=__common__( if(((real)iv_impulse_annual_income > NULL), N284_8, 0.0017368786));

	N284_6 :=__common__( map((iv_inp_addr_mortgage_term in ['10', '25', '40'])                 => -0.01555117,
				  (iv_inp_addr_mortgage_term in ['-1', '0', '15', '20', '30', '5']) => N284_7,
																					   N284_7));

	N284_5 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-2']) => 0.0026069132,
				  (iv_criminal_x_felony in ['1-1', '3-1', '3-3'])                             => 0.027925628,
																								 0.0026069132));

	N284_4 :=__common__( map((iv_inp_addr_mortgage_term in ['-1', '15', '25', '30', '40']) => N284_5,
				  (iv_inp_addr_mortgage_term in ['0', '10', '20', '5'])         => 0.054826517,
																				   N284_5));

	N284_3 :=__common__( map((iv_best_match_address in ['ADD1', 'ADD2', 'NONE']) => N284_4,
				  (iv_best_match_address in ['ADD3'])                 => 0.035703819,
																		 N284_4));

	N284_2 :=__common__( if(((real)c_oldhouse < 11.6499996185), N284_3, N284_6));

	N284_1 :=__common__( if(trim(C_OLDHOUSE) != '', N284_2, -0.0052022421));

	N285_9 :=__common__( map(((real)nf_fp_srchssnsrchcount <= NULL) => -0.0066087385,
				  ((real)nf_fp_srchssnsrchcount < 12.5)  => 0.006312844,
															-0.0066087385));

	N285_8 :=__common__( map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '04', '10', '12', '13', '14']) => N285_9,
				  (iv_bst_own_prop_x_addr_naprop in ['02', '03', '11'])                         => 0.016239586,
																								   N285_9));

	N285_7 :=__common__( if(((real)c_pop_18_24_p < 12.9499998093), N285_8, -0.0035221432));

	N285_6 :=__common__( if(trim(C_POP_18_24_P) != '', N285_7, -0.007005766));

	N285_5 :=__common__( if(((real)c_pop00 < 689.5), -0.0098246099, -0.00040766978));

	N285_4 :=__common__( if(trim(C_POP00) != '', N285_5, 0.0053381738));

	N285_3 :=__common__( map((nf_fp_assocrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => N285_4,
				  (nf_fp_assocrisktype in ['9'])                                    => N285_6,
																					   N285_4));

	N285_2 :=__common__( if(((real)iv_src_liens_adl_count < 6.5), N285_3, 0.012081427));

	N285_1 :=__common__( if(((real)iv_src_liens_adl_count > NULL), N285_2, 0.0026380969));

	N286_8 :=__common__( if(((real)c_easiqlife < 61.5), -0.0037744081, 0.003874447));

	N286_7 :=__common__( if(trim(C_EASIQLIFE) != '', N286_8, 0.010366944));

	N286_6 :=__common__( if(((real)nf_fp_srchphonesrchcount < 11.5), N286_7, -0.0092822025));

	N286_5 :=__common__( if(((real)nf_fp_srchphonesrchcount > NULL), N286_6, 0.0035232463));

	N286_4 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '10', '15', '20', '30', '40']) => 0.0059220053,
				  (iv_prv_addr_mortgage_term in ['0', '25', '5'])                     => 0.074391603,
																						 0.0059220053));

	N286_3 :=__common__( if(((real)iv_mos_since_impulse_last_seen < 35.5), -0.0020706121, N286_4));

	N286_2 :=__common__( if(((real)iv_mos_since_impulse_last_seen > NULL), N286_3, -0.011939361));

	N286_1 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-0']) => N286_2,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '2-1', '3-1', '3-3'])                                    => N286_5,
																													   N286_5));

	N287_6 :=__common__( map((iv_ams_college_major in ['Business', 'Liberal Arts', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => 0.0068935715,
				  (iv_ams_college_major in ['Medical'])                                                                                 => 0.11772297,
																																		   0.0068935715));

	N287_5 :=__common__( map(trim(C_FEMDIV_P) = ''              => -0.0024203962,
				  ((real)c_femdiv_p < 3.65000009537) => N287_6,
														-0.0024203962));

	N287_4 :=__common__( map((iv_ed001_college_ind_26 in ['0']) => N287_5,
				  (iv_ed001_college_ind_26 in ['1']) => 0.037487679,
														N287_5));

	N287_3 :=__common__( if(((real)c_pop_18_24_p < 5.64999961853), 0.012715702, N287_4));

	N287_2 :=__common__( if(trim(C_POP_18_24_P) != '', N287_3, -0.0088587867));

	N287_1 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1', '2-1', '2-2', '3-1', '3-2']) => -0.0013019548,
				  (iv_liens_unrel_x_rel in ['0-2', '1-2', '2-0', '3-0'])                             => N287_2,
																										-0.0013019548));

	N288_8 :=__common__( map(((real)iv_dob_src_ct <= NULL) => 0.0023207327,
				  ((real)iv_dob_src_ct < 8.5)   => 0.014142429,
												   0.0023207327));

	N288_7 :=__common__( map(((real)iv_src_bureau_lname_count <= NULL) => 0.01210608,
				  ((real)iv_src_bureau_lname_count < 77.5)  => -0.00032037366,
															   0.01210608));

	N288_6 :=__common__( map(trim(C_HVAL_100K_P) = ''              => 0.012409746,
				  ((real)c_hval_100k_p < 35.0499992371) => N288_7,
														   0.012409746));

	N288_5 :=__common__( if(((real)c_pop_12_17_p < 3.34999990463), -0.010706344, N288_6));

	N288_4 :=__common__( if(trim(C_POP_12_17_P) != '', N288_5, 0.00041743135));

	N288_3 :=__common__( map(((real)iv_gong_did_phone_ct <= NULL) => N288_8,
				  ((real)iv_gong_did_phone_ct < 2.5)   => N288_4,
														  N288_8));

	N288_2 :=__common__( if(((real)iv_inq_banking_recency < 0.5), N288_3, -0.0017542794));

	N288_1 :=__common__( if(((real)iv_inq_banking_recency > NULL), N288_2, -0.0061637063));

	N289_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['4', '5', '6', '7', '8', '9']) => -0.016136287,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '3'])                => -0.00097860634,
																					 -0.016136287));

	N289_7 :=__common__( map((iv_criminal_x_felony in ['3-0', '3-1', '3-2', '3-3'])               => -0.0063401858,
				  (iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2']) => 0.004540209,
																						  0.004540209));

	N289_6 :=__common__( map(trim(C_HVAL_80K_P) = ''              => 0.014089325,
				  ((real)c_hval_80k_p < 20.4500007629) => N289_7,
														  0.014089325));

	N289_5 :=__common__( if(((real)iv_ssns_per_sfd_addr < 18.5), N289_6, N289_8));

	N289_4 :=__common__( if(((real)iv_ssns_per_sfd_addr > NULL), N289_5, -0.02664566));

	N289_3 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N289_4,
				  (nf_fp_srchcomponentrisktype in ['7'])                                    => 0.022478182,
																							   0.022478182));

	N289_2 :=__common__( if(((real)c_hval_125k_p < 14.1499996185), -0.00095093525, N289_3));

	N289_1 :=__common__( if(trim(C_HVAL_125K_P) != '', N289_2, 0.00065811351));

	N290_8 :=__common__( map(trim(C_INCOLLEGE) = ''              => -0.0024066685,
				  ((real)c_incollege < 5.85000038147) => 0.0027581023,
														 -0.0024066685));

	N290_7 :=__common__( if(((real)c_hval_400k_p < 34.4500007629), N290_8, 0.013739565));

	N290_6 :=__common__( if(trim(C_HVAL_400K_P) != '', N290_7, 0.0034037786));

	N290_5 :=__common__( map(((real)iv_inq_other_recency <= NULL) => N290_6,
				  ((real)iv_inq_other_recency < 0.5)   => -0.0024268518,
														  N290_6));

	N290_4 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N290_5,
				  (nf_fp_idrisktype in ['7'])                                    => 0.025801539,
																					N290_5));

	N290_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-0', '2-1', '3-1', '3-3']) => 0.0057756623,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-2', '3-0', '3-2']) => 0.028831602,
																				   0.028831602));

	N290_2 :=__common__( if(((real)nf_rel_count < 2.5), N290_3, N290_4));

	N290_1 :=__common__( if(((real)nf_rel_count > NULL), N290_2, -0.0048705226));

	N291_5 :=__common__( map((nf_fp_divrisktype in ['3', '5', '9'])                => -0.020218931,
				  (nf_fp_divrisktype in ['1', '2', '4', '6', '7', '8']) => -0.0066414693,
																		   -0.020218931));

	N291_4 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '005', '008', '100', '101', '102', '103', '104', '105', '106', '108', '110', '111', '112']) => N291_5,
				  (iv_phnpop_x_nap_summary in ['003', '107', '109'])                                                                                     => 0.068604685,
																																							N291_5));

	N291_3 :=__common__( map((nf_fp_addrchangeecontrajindex in ['-1', '2', '4'])     => N291_4,
				  (nf_fp_addrchangeecontrajindex in ['1', '3', '5', '6']) => 0.0024237247,
																			 N291_4));

	N291_2 :=__common__( map((nf_fp_varrisktype in ['-1', '6', '7', '9'])          => N291_3,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '5', '8']) => -0.00022721981,
																		   N291_3));

	N291_1 :=__common__( map((iv_cvi in [10, 20, 30, 40, 50]) => N291_2,
				  (iv_cvi in [0])                         => 0.020166701,
																N291_2));

	N292_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '4', '5', '6', '7', '9']) => -0.0022816034,
				  (nf_fp_srchcomponentrisktype in ['3', '8'])                          => 0.0080664276,
																						  -0.0022816034));

	N292_7 :=__common__( if(((real)c_pop_55_64_p < 9.55000019073), 0.0076010958, -0.0009598305));

	N292_6 :=__common__( if(trim(C_POP_55_64_P) != '', N292_7, 0.012139272));

	N292_5 :=__common__( map(((real)iv_dc001_mos_since_crim_ls <= NULL) => N292_6,
				  ((real)iv_dc001_mos_since_crim_ls < 10.5)  => 0.015782817,
																N292_6));

	N292_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '2-1', '3-1', '3-2'])               => 0.00092156444,
				  (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-2', '3-0', '3-3']) => N292_5,
																						  N292_5));

	N292_3 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '2-1', '2-2'])               => -0.007928829,
				  (iv_liens_unrel_x_rel in ['0-0', '1-0', '1-2', '2-0', '3-0', '3-1', '3-2']) => N292_4,
																								 N292_4));

	N292_2 :=__common__( if(((real)iv_inq_banking_recency < 0.5), N292_3, N292_8));

	N292_1 :=__common__( if(((real)iv_inq_banking_recency > NULL), N292_2, -0.00020107433));

	N293_7 :=__common__( map((iv_input_dob_match_level in ['0', '2', '4', '5', '6', '7', '8']) => -0.0032133131,
				  (iv_input_dob_match_level in ['1', '3'])                          => 0.03828171,
																					   -0.0032133131));

	N293_6 :=__common__( if(((real)c_rest_indx < 135.5), 0.00083596371, N293_7));

	N293_5 :=__common__( if(trim(C_REST_INDX) != '', N293_6, 0.0027121389));

	N293_4 :=__common__( map(((real)iv_pv001_bst_avm_autoval <= NULL)     => 0.011732063,
				  ((integer)iv_pv001_bst_avm_autoval < 303875) => N293_5,
																  0.011732063));

	N293_3 :=__common__( if(((integer)iv_ssn_score < 95), 0.0090397257, N293_4));

	N293_2 :=__common__( if(((real)iv_ssn_score > NULL), N293_3, 0.0039104001));

	N293_1 :=__common__( map((iv_num_purch_x_num_sold_60 in ['1-0', '1-1', '2-0', '2-2'])        => -0.0071118303,
				  (iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-2', '2-1']) => N293_2,
																						 N293_2));

	N294_6 :=__common__( map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2']) => 0.0038679371,
				  (iv_num_purch_x_num_sold_60 in ['1-2'])                                                  => 0.17154769,
																											  0.0038679371));

	N294_5 :=__common__( if(((real)iv_inp_addr_building_area < 1355.5), -1.1038468e-005, N294_6));

	N294_4 :=__common__( if(((real)iv_inp_addr_building_area > NULL), N294_5, 0.0043595526));

	N294_3 :=__common__( map((iv_nas_summary in [0, 2, 4, 7, 8, 9, 10, 11, 12]) => N294_4,
				  (iv_nas_summary in [1, 3, 6])                                     => 0.04248329,
																								N294_4));

	N294_2 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'Non-Traditional', 'Other', 'Piggyback']) => -0.0033735386,
				  (iv_prv_addr_mortgage_type in ['No Mortgage', 'Unknown'])                                                                                        => N294_3,
																																									  -0.0033735386));

	N294_1 :=__common__( map((nf_fp_idrisktype in ['3', '5', '9'])                => -0.017913792,
				  (nf_fp_idrisktype in ['1', '2', '4', '6', '7', '8']) => N294_2,
																		  N294_2));

	N295_8 :=__common__( map(((real)iv_mos_src_bureau_addr_fseen <= NULL) => 0.0046424841,
				  ((real)iv_mos_src_bureau_addr_fseen < 58.5)  => -0.0058689726,
																  0.0046424841));

	N295_7 :=__common__( map(((real)iv_avg_prop_sold_purch_amt <= NULL)     => 0.014631293,
				  ((integer)iv_avg_prop_sold_purch_amt < 169950) => -0.00050772898,
																	0.014631293));

	N295_6 :=__common__( map((nf_fp_varrisktype in ['1', '3', '4', '5', '6', '7', '8', '9']) => N295_7,
				  (nf_fp_varrisktype in ['-1', '2'])                              => 0.0050963595,
																					 N295_7));

	N295_5 :=__common__( map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '103', '105', '106', '107', '108', '109', '110', '111', '112']) => N295_6,
				  (iv_phnpop_x_nap_summary in ['104'])                                                                                                                 => 0.16476564,
																																										  N295_6));

	N295_4 :=__common__( if(((real)c_fammar_p < 80.25), N295_5, N295_8));

	N295_3 :=__common__( if(trim(C_FAMMAR_P) != '', N295_4, -0.002735743));

	N295_2 :=__common__( if(((real)iv_max_lres < 7.5), 0.0089271669, N295_3));

	N295_1 :=__common__( if(((real)iv_max_lres > NULL), N295_2, -0.0024864505));

	N296_8 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'No Mortgage', 'Piggyback', 'Unknown']) => 0.0054172413,
				  (iv_prv_addr_mortgage_type in ['Government', 'High-Risk', 'Non-Traditional', 'Other'])                              => 0.03579296,
																																		 0.0054172413));

	N296_7 :=__common__( map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '03', '04', '10', '11', '14']) => N296_8,
				  (iv_bst_own_prop_x_addr_naprop in ['02', '12', '13'])                         => 0.060698913,
																								   N296_8));

	N296_6 :=__common__( map(((real)iv_pl002_addrs_per_ssn_c6 <= NULL) => 0.0090260968,
				  ((real)iv_pl002_addrs_per_ssn_c6 < 0.5)   => 0.0011386322,
															   0.0090260968));

	N296_5 :=__common__( if(((real)iv_inq_phones_per_adl < 2.5), N296_6, N296_7));

	N296_4 :=__common__( if(((real)iv_inq_phones_per_adl > NULL), N296_5, -0.0054034855));

	N296_3 :=__common__( map(trim(C_HIGHINC) = ''              => N296_4,
				  ((real)c_highinc < 7.94999980927) => -0.00076651116,
													   N296_4));

	N296_2 :=__common__( if(((real)c_rich_wht < 191.5), N296_3, -0.0096330586));

	N296_1 :=__common__( if(trim(C_RICH_WHT) != '', N296_2, -0.003204796));

	N297_8 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-1', '1-0', '4-1', '4-3', '5-1', '5-2', '5-3'])                             => -0.024061457,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-2']) => 0.0007377031,
																																	 0.0007377031));

	N297_7 :=__common__( map(trim(C_RENTAL) = ''      => 0.011205037,
				  ((real)c_rental < 195.5) => N297_8,
											  0.011205037));

	N297_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '5-1']) => -0.0027549085,
				  (iv_gong_did_fname_x_lname_ct in ['4-3', '5-2', '5-3'])                                                                                     => 0.086578697,
																																								 -0.0027549085));

	N297_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['2', '3', '5', '7', '8']) => -0.012639849,
				  (nf_fp_srchcomponentrisktype in ['1', '4', '6', '9'])      => N297_6,
																				-0.012639849));

	N297_4 :=__common__( map((iv_input_dob_match_level in ['2', '3', '4', '7', '8']) => N297_5,
				  (iv_input_dob_match_level in ['0', '1', '5', '6'])      => 0.014782898,
																			 N297_5));

	N297_3 :=__common__( if(((real)c_highinc < 1.25), N297_4, N297_7));

	N297_2 :=__common__( if(trim(C_HIGHINC) != '', N297_3, -0.0023705259));

	N297_1 :=__common__( if(((real)iv_inq_auto_count12 > NULL), N297_2, 0.0021892022));

	N298_10 :=__common__( map((nf_fp_idverrisktype in ['1', '3', '8'])                => -0.014544813,
				   (nf_fp_idverrisktype in ['2', '4', '5', '6', '7', '9']) => -0.0012509321,
																			  -0.0012509321));

	N298_9 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '0', '15', '20', '25', '30', '40', '5']) => N298_10,
				  (iv_bst_addr_mortgage_term in ['10'])                                         => 0.1622338,
																								   N298_10));

	N298_8 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => 0.0085590536,
				  ((real)iv_inq_per_ssn < 15.5)  => 0.0011724175,
													0.0085590536));

	N298_7 :=__common__( if(((real)iv_age_at_low_issue < 10.5), N298_8, -0.0023203557));

	N298_6 :=__common__( if(((real)iv_age_at_low_issue > NULL), N298_7, -0.0011559291));

	N298_5 :=__common__( if(((integer)nf_inp_addr_nhood_pct_vacant < 85), N298_6, -0.0091062389));

	N298_4 :=__common__( if(((real)nf_inp_addr_nhood_pct_vacant > NULL), N298_5, -0.028989574));

	N298_3 :=__common__( if(trim(C_POP_0_5_P) != '', N298_4, 0.005242357));

	N298_2 :=__common__( if(((real)iv_df001_mos_since_fel_ls < 55.5), N298_3, N298_9));

	N298_1 :=__common__( if(((real)iv_df001_mos_since_fel_ls > NULL), N298_2, -0.0066936622));

	N299_8 :=__common__( map((iv_criminal_x_felony in ['2-2', '3-3'])                                           => -0.036391522,
				  (iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2']) => -0.0014236901,
																										-0.0014236901));

	N299_7 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-3', '2-1', '2-2', '3-1', '3-2', '4-3', '5-3']) => N299_8,
				  (iv_gong_did_fname_x_lname_ct in ['1-2', '2-3', '3-3', '4-1', '4-2', '5-1', '5-2'])                             => 0.021304217,
																																	 N299_8));

	N299_6 :=__common__( map(trim(C_INC_125K_P) = ''              => 0.013946552,
				  ((real)c_inc_125k_p < 10.9499998093) => N299_7,
														  0.013946552));

	N299_5 :=__common__( if(((integer)c_robbery < 73), -0.0070607621, N299_6));

	N299_4 :=__common__( if(trim(C_ROBBERY) != '', N299_5, -0.0085809525));

	N299_3 :=__common__( map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '4 Invalid', '6 Pager', '7 PCS']) => -0.00855562,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '5 Cell', '8 Pay_Phone'])                => N299_4,
																											N299_4));

	N299_2 :=__common__( if(((real)iv_inq_auto_recency < 0.5), 0.0010721851, N299_3));

	N299_1 :=__common__( if(((real)iv_inq_auto_recency > NULL), N299_2, 1.2514835e-005));

	N300_8 :=__common__( if(((real)nf_fp_prevaddrburglaryindex < 85.5), -0.011229085, 0.00050937862));

	N300_7 :=__common__( if(((real)nf_fp_prevaddrburglaryindex > NULL), N300_8, -0.003669152));

	N300_6 :=__common__( map((nf_fp_varrisktype in ['7', '8', '9'])                      => -0.0243467,
				  (nf_fp_varrisktype in ['-1', '1', '2', '3', '4', '5', '6']) => N300_7,
																				 N300_7));

	N300_5 :=__common__( if(((real)c_hh5_p < 16.25), 0.00064697624, N300_6));

	N300_4 :=__common__( if(trim(C_HH5_P) != '', N300_5, -0.0012083841));

	N300_3 :=__common__( if(((integer)nf_inp_addr_nhood_pct_vacant < 95), N300_4, -0.011290477));

	N300_2 :=__common__( if(((real)nf_inp_addr_nhood_pct_vacant > NULL), N300_3, -0.010284979));

	N300_1 :=__common__( map((iv_nas_summary in [0, 3, 4, 7, 8, 9, 10, 11, 12]) => N300_2,
				  (iv_nas_summary in [1, 2, 6])                                     => 0.017666079,
																								N300_2));

	N301_8 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back']) => -0.0049891929,
				  (iv_va100_add_problem in ['05 Drop Delivery', '06 Invalid Address', '12 College', '13 Vacant'])                                                                                                                                                => 0.01472159,
																																																																	-0.0049891929));

	N301_7 :=__common__( map(((real)nf_fp_prevaddrburglaryindex <= NULL) => 0.0038481884,
				  ((real)nf_fp_prevaddrburglaryindex < 13.5)  => 0.01647339,
																 0.0038481884));

	N301_6 :=__common__( if(((real)c_high_ed < 20.6500015259), -0.009528485, 0.0029984665));

	N301_5 :=__common__( if(trim(C_HIGH_ED) != '', N301_6, 0.017146958));

	N301_4 :=__common__( map(((real)iv_mos_src_bureau_lname_fseen <= NULL) => N301_7,
				  ((real)iv_mos_src_bureau_lname_fseen < 67.5)  => N301_5,
																   N301_7));

	N301_3 :=__common__( map(((real)iv_src_voter_adl_count <= NULL) => N301_4,
				  ((real)iv_src_voter_adl_count < -0.5)  => -0.0010459584,
															N301_4));

	N301_2 :=__common__( if(((real)iv_mos_src_voter_adl_lseen < -0.5), N301_3, N301_8));

	N301_1 :=__common__( if(((real)iv_mos_src_voter_adl_lseen > NULL), N301_2, -0.0043295162));

	N302_6 :=__common__( map((nf_fp_corrrisktype in ['5', '6', '7'])                => -0.0067677618,
				  (nf_fp_corrrisktype in ['1', '2', '3', '4', '8', '9']) => 0.007133707,
																			-0.0067677618));

	N302_5 :=__common__( map(trim(C_POP_85P_P) = ''               => N302_6,
				  ((real)c_pop_85p_p < 0.850000023842) => 0.011154694,
														  N302_6));

	N302_4 :=__common__( map(trim(C_FEMDIV_P) = ''              => N302_5,
				  ((real)c_femdiv_p < 6.44999980927) => 0.00045411825,
														N302_5));

	N302_3 :=__common__( if(((real)c_popover18 < 515.5), -0.0083693929, N302_4));

	N302_2 :=__common__( if(trim(C_POPOVER18) != '', N302_3, 9.5961046e-005));

	N302_1 :=__common__( map(((real)iv_inq_per_ssn <= NULL) => N302_2,
				  ((real)iv_inq_per_ssn < 1.5)   => -0.001725347,
													N302_2));

	N303_8 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '3-2', '3-3', '4-1', '4-2', '4-3', '5-1', '5-2', '5-3']) => -0.0011410991,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '2-3', '3-1'])                                                                                     => 0.064652865,
																																								 -0.0011410991));

	N303_7 :=__common__( if(((real)iv_pl001_m_snc_in_addr_fs < 4.5), 0.010839326, N303_8));

	N303_6 :=__common__( if(((real)iv_pl001_m_snc_in_addr_fs > NULL), N303_7, 0.043775644));

	N303_5 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '9']) => N303_6,
				  (nf_fp_srchcomponentrisktype in ['7', '8'])                          => 0.055976784,
																						  N303_6));

	N303_4 :=__common__( map(((real)iv_mos_since_prv_addr_fseen <= NULL) => -0.00076135248,
				  ((real)iv_mos_since_prv_addr_fseen < 4.5)   => N303_5,
																 -0.00076135248));

	N303_3 :=__common__( map(((real)iv_full_name_non_phn_src_ct <= NULL) => 0.011152195,
				  ((real)iv_full_name_non_phn_src_ct < 12.5)  => N303_4,
																 0.011152195));

	N303_2 :=__common__( if(((real)nf_fp_srchfraudsrchcountwk < 1.5), N303_3, 0.0082919134));

	N303_1 :=__common__( if(((real)nf_fp_srchfraudsrchcountwk > NULL), N303_2, -0.004617022));

	N304_8 :=__common__( map((nf_fp_srchcomponentrisktype in ['4', '5', '8', '9'])      => -0.010664019,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '3', '6', '7']) => -0.0017714867,
																				-0.010664019));

	N304_7 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => 0.0059216576,
				  (iv_paw_dead_bus_x_active_phn in ['1-2'])                                                                                                   => 0.16095976,
																																								 0.0059216576));

	N304_6 :=__common__( if(((real)iv_inq_phones_per_adl < 2.5), 0.0019389831, 0.0096721179));

	N304_5 :=__common__( if(((real)iv_inq_phones_per_adl > NULL), N304_6, 0.012274261));

	N304_4 :=__common__( map(trim(C_RETAIL) = ''              => -0.0019758846,
				  ((real)c_retail < 6.05000019073) => N304_5,
													  -0.0019758846));

	N304_3 :=__common__( map(trim(C_HH4_P) = ''              => N304_7,
				  ((real)c_hh4_p < 14.6499996185) => N304_4,
													 N304_7));

	N304_2 :=__common__( if(((real)c_hh4_p < 17.25), N304_3, N304_8));

	N304_1 :=__common__( if(trim(C_HH4_P) != '', N304_2, 0.0025031643));

	N305_8 :=__common__( if(((integer)c_lowrent < 84), -0.002916992, 0.010947438));

	N305_7 :=__common__( if(trim(C_LOWRENT) != '', N305_8, -0.0048566616));

	N305_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N305_7,
				  (nf_fp_srchcomponentrisktype in ['8'])                                    => 0.035484251,
																							   N305_7));

	N305_5 :=__common__( map(((real)iv_dist_inp_addr_to_prv_addr <= NULL) => 0.0023223677,
				  ((real)iv_dist_inp_addr_to_prv_addr < 0.5)   => N305_6,
																  0.0023223677));

	N305_4 :=__common__( map((iv_nap_status in ['C']) => N305_5,
				  (iv_nap_status in ['D']) => 0.050694942,
											  N305_5));

	N305_3 :=__common__( map((iv_num_purch_x_num_sold_60 in ['0-1', '1-0', '1-1', '1-2'])        => -0.0059057806,
				  (iv_num_purch_x_num_sold_60 in ['0-0', '0-2', '2-0', '2-1', '2-2']) => N305_4,
																						 N305_4));

	N305_2 :=__common__( if(((real)iv_src_bureau_lname_count < 6.5), -0.0059943794, N305_3));

	N305_1 :=__common__( if(((real)iv_src_bureau_lname_count > NULL), N305_2, -0.0038636796));

	N306_7 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-3', '5-1', '5-2', '5-3']) => -0.0041658549,
				  (iv_gong_did_fname_x_lname_ct in ['4-2'])                                                                                                                 => 0.20193854,
																																											   -0.0041658549));

	N306_6 :=__common__( map((iv_db001_bankruptcy in ['1 - BK Discharged'])                             => -0.0032334643,
				  (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed', '3 - BK Other']) => 0.0022234211,
																								0.0022234211));

	N306_5 :=__common__( map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Piggyback', 'Unknown']) => N306_6,
				  (iv_bst_addr_mortgage_type in ['Other'])                                                                                                                          => 0.019233949,
																																													   N306_6));

	N306_4 :=__common__( map(((real)iv_mos_since_prv_addr_lseen <= NULL) => N306_7,
				  ((real)iv_mos_since_prv_addr_lseen < 16.5)  => N306_5,
																 N306_7));

	N306_3 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '2-2'])                                                         => -0.0098677671,
				  (iv_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '3-0', '3-1', '3-2']) => N306_4,
																													  -0.0098677671));

	N306_2 :=__common__( if(((real)c_blue_col < 26.75), N306_3, -0.0098980261));

	N306_1 :=__common__( if(trim(C_BLUE_COL) != '', N306_2, -0.0061783974));

	N307_8 :=__common__( map((iv_bst_addr_avm_land_use in ['', '1']) => -0.00405873,
				  (iv_bst_addr_avm_land_use in ['2'])      => 0.071604749,
															  -0.00405873));

	N307_7 :=__common__( map((nf_fp_assocrisktype in ['2', '4', '5', '6', '7', '8', '9']) => N307_8,
				  (nf_fp_assocrisktype in ['1', '3'])                          => 0.011554914,
																				  N307_8));

	N307_6 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N307_7,
				  (iv_paw_dead_bus_x_active_phn in ['2-3', '3-3'])                                                                                     => 0.15337534,
																																						  N307_7));

	N307_5 :=__common__( map(trim(C_BEL_EDU) = ''      => N307_6,
				  ((real)c_bel_edu < 136.5) => -0.0070090799,
											   N307_6));

	N307_4 :=__common__( if(((real)iv_hist_addr_match < 4.5), -3.1491939e-006, 0.0053801115));

	N307_3 :=__common__( if(((real)iv_hist_addr_match > NULL), N307_4, 0.0053243988));

	N307_2 :=__common__( if(((real)c_health < 22.9500007629), N307_3, N307_5));

	N307_1 :=__common__( if(trim(C_HEALTH) != '', N307_2, 0.00065551038));

	N308_7 :=__common__( map((nf_fp_divrisktype in ['1', '2', '3', '4', '6', '7', '9']) => 0.0028952156,
				  (nf_fp_divrisktype in ['5', '8'])                          => 0.025740477,
																				0.0028952156));

	N308_6 :=__common__( map(((real)nf_average_rel_distance <= NULL) => -0.0059141475,
				  ((real)nf_average_rel_distance < 485.5) => N308_7,
															 -0.0059141475));

	N308_5 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other']) => -0.0014278054,
				  (iv_prv_addr_mortgage_type in ['Government', 'Piggyback', 'Unknown'])                                                                => N308_6,
																																						  -0.0014278054));

	N308_4 :=__common__( map((iv_vs100_ssn_problem in ['2'])      => -0.015484629,
				  (iv_vs100_ssn_problem in ['0', '1']) => N308_5,
														  N308_5));

	N308_3 :=__common__( map(((real)iv_inq_addrs_per_adl <= NULL) => -0.0059474281,
				  ((real)iv_inq_addrs_per_adl < 3.5)   => N308_4,
														  -0.0059474281));

	N308_2 :=__common__( if(((real)iv_src_liens_adl_count < 6.5), N308_3, 0.009165922));

	N308_1 :=__common__( if(((real)iv_src_liens_adl_count > NULL), N308_2, -0.0021728426));

	N309_6 :=__common__( map((iv_in001_college_income in ['-1', 'D', 'E', 'G', 'I'])          => 0.00052292529,
				  (iv_in001_college_income in ['A', 'B', 'C', 'F', 'H', 'J', 'K']) => 0.017581889,
																					  0.017581889));

	N309_5 :=__common__( map((iv_inp_addr_mortgage_type in ['Equity Loan', 'Government', 'No Mortgage', 'Other', 'Piggyback', 'Unknown']) => N309_6,
				  (iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'High-Risk', 'Non-Traditional'])                => 0.033896313,
																																  0.033896313));

	N309_4 :=__common__( map(((real)nf_fp_prevaddrcartheftindex <= NULL) => N309_5,
				  ((real)nf_fp_prevaddrcartheftindex < 114.5) => -0.0065293469,
																 N309_5));

	N309_3 :=__common__( if(((real)nf_fp_divaddrsuspidcountnew < 0.5), N309_4, -0.0086535283));

	N309_2 :=__common__( if(((real)nf_fp_divaddrsuspidcountnew > NULL), N309_3, -0.0011649764));

	N309_1 :=__common__( map((nf_fp_varrisktype in ['-1', '5', '6', '8', '9']) => N309_2,
				  (nf_fp_varrisktype in ['1', '2', '3', '4', '7'])  => 0.00082809629,
																	   N309_2));

	N310_5 :=__common__( map((iv_bst_addr_mortgage_type in ['Government', 'No Mortgage', 'Non-Traditional', 'Unknown'])                      => 0.0045444856,
				  (iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'High-Risk', 'Other', 'Piggyback']) => 0.028061801,
																																	 0.028061801));

	N310_4 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2']) => N310_5,
				  (iv_criminal_x_felony in ['2-2', '3-3'])                                           => 0.039421741,
																										N310_5));

	N310_3 :=__common__( map(((real)nf_average_rel_distance <= NULL) => N310_4,
				  ((real)nf_average_rel_distance < 189.5) => -0.0033348057,
															 N310_4));

	N310_2 :=__common__( map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => N310_3,
				  (iv_num_purch_x_num_sold_60 in ['0-2', '1-2', '2-2'])                      => 0.12110368,
																								N310_3));

	N310_1 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '1-0', '1-1', '1-3', '2-1', '3-1', '3-2', '4-1', '4-3', '5-1', '5-3']) => -0.00039592671,
				  (iv_gong_did_fname_x_lname_ct in ['0-1', '1-2', '2-2', '2-3', '3-3', '4-2', '5-2'])                             => N310_2,
																																	 -0.00039592671));

	N311_8 :=__common__( map((nf_fp_componentcharrisktype in ['1', '4', '5', '7', '9']) => -0.0047055185,
				  (nf_fp_componentcharrisktype in ['2', '3', '6', '8'])      => 0.0020188651,
																				-0.0047055185));

	N311_7 :=__common__( map(((real)iv_inq_banking_recency <= NULL) => N311_8,
				  ((real)iv_inq_banking_recency < 0.5)   => 0.0023691528,
															N311_8));

	N311_6 :=__common__( map(((real)iv_inq_collection_count12 <= NULL) => 0.010355014,
				  ((real)iv_inq_collection_count12 < 2.5)   => N311_7,
															   0.010355014));

	N311_5 :=__common__( if(((real)iv_dl001_unrel_lien60_count < 3.5), N311_6, 0.010261811));

	N311_4 :=__common__( if(((real)iv_dl001_unrel_lien60_count > NULL), N311_5, 0.0034433263));

	N311_3 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-2', '3-1', '3-2', '3-3']) => -0.0048439604,
				  (iv_criminal_x_felony in ['2-0', '2-1', '3-0'])                             => 0.0098715269,
																								 -0.0048439604));

	N311_2 :=__common__( if(((real)c_easiqlife < 66.5), N311_3, N311_4));

	N311_1 :=__common__( if(trim(C_EASIQLIFE) != '', N311_2, 0.001529614));

	N312_8 :=__common__( map((iv_bst_addr_mortgage_term in ['-1', '10', '25', '30', '40']) => 0.0052786936,
				  (iv_bst_addr_mortgage_term in ['0', '15', '20', '5'])         => 0.046119885,
																				   0.0052786936));

	N312_7 :=__common__( map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-3']) => N312_8,
				  (iv_criminal_x_felony in ['3-2'])                                                         => 0.041955727,
																											   N312_8));

	N312_6 :=__common__( map(trim(C_RETIRED) = ''              => -0.00083267983,
				  ((real)c_retired < 4.14999961853) => N312_7,
													   -0.00083267983));

	N312_5 :=__common__( if(((real)c_housingcpi < 239.450012207), N312_6, 0.011936827));

	N312_4 :=__common__( if(trim(C_HOUSINGCPI) != '', N312_5, -0.0060879374));

	N312_3 :=__common__( map(((real)iv_mos_src_bureau_ssn_fseen <= NULL) => N312_4,
				  ((real)iv_mos_src_bureau_ssn_fseen < 31.5)  => 0.010855257,
																 N312_4));

	N312_2 :=__common__( if(((real)nf_fp_curraddrcartheftindex < 136.5), -0.0018529084, N312_3));

	N312_1 :=__common__( if(((real)nf_fp_curraddrcartheftindex > NULL), N312_2, 0.005267412));

	N313_8 :=__common__( map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-0', '1-3', '2-0', '2-1', '2-3', '3-0', '3-3']) => 0.0045396026,
				  (iv_nap_phn_ver_x_inf_phn_ver in ['1-1', '3-1'])                                                                => 0.057845956,
																																	 0.0045396026));

	N313_7 :=__common__( map(trim(C_FAMMAR18_P) = ''              => -0.0042602768,
				  ((real)c_fammar18_p < 25.5499992371) => 0.00063774717,
														  -0.0042602768));

	N313_6 :=__common__( map(trim(C_HH3_P) = ''              => N313_8,
				  ((real)c_hh3_p < 27.6500015259) => N313_7,
													 N313_8));

	N313_5 :=__common__( map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '03', '10', '11', '13', '14']) => N313_6,
				  (iv_prv_own_prop_x_addr_naprop in ['04', '12'])                                     => 0.019761206,
																										 N313_6));

	N313_4 :=__common__( if(((real)iv_mos_src_bureau_addr_fseen < 18.5), N313_5, 0.0012651892));

	N313_3 :=__common__( if(((real)iv_mos_src_bureau_addr_fseen > NULL), N313_4, -0.00083206237));

	N313_2 :=__common__( if(((real)c_femdiv_p < 14.1499996185), N313_3, 0.010736921));

	N313_1 :=__common__( if(trim(C_FEMDIV_P) != '', N313_2, 0.0041977101));

	N314_7 :=__common__( map(((real)iv_mos_since_bst_addr_fseen <= NULL) => 0.0084431259,
				  ((real)iv_mos_since_bst_addr_fseen < 18.5)  => -0.0042379658,
																 0.0084431259));

	N314_6 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other', 'Piggyback', 'Unknown']) => N314_7,
				  (iv_prv_addr_mortgage_type in ['Conventional', 'Non-Traditional'])                                                                      => 0.02354402,
																																							 N314_7));

	N314_5 :=__common__( map((iv_input_dob_match_level in ['7', '8'])                          => N314_6,
				  (iv_input_dob_match_level in ['0', '1', '2', '3', '4', '5', '6']) => 0.01869052,
																					   0.01869052));

	N314_4 :=__common__( map(((real)iv_sr001_source_profile <= NULL)         => -0.0008832949,
				  ((real)iv_sr001_source_profile < 19.3499984741) => N314_5,
																	 -0.0008832949));

	N314_3 :=__common__( if(trim(C_LOWINC) != '', N314_4, 0.0047202155));

	N314_2 :=__common__( if(((real)iv_sr001_source_profile > NULL), N314_3, -0.0049438339));

	N314_1 :=__common__( map((nf_fp_idrisktype in ['3', '9'])                          => -0.019133739,
				  (nf_fp_idrisktype in ['1', '2', '4', '5', '6', '7', '8']) => N314_2,
																			   N314_2));

	N315_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '09 Corporate Zip Code', '12 College']) => 0.0041785213,
				  (iv_va100_add_problem in ['02 Address Standardized', '07 Busines', '10 Zip/City Mismatch', '11 Throw Back', '13 Vacant'])                                                                                            => 0.018424674,
																																																										  0.018424674));

	N315_5 :=__common__( map((iv_nas_summary in [0, 2, 3, 4, 7, 9, 10, 12]) => N315_6,
				  (iv_nas_summary in [1, 6, 8, 11])                         => 0.061805373,
																						  N315_6));

	N315_4 :=__common__( map((iv_input_dob_match_level in ['0', '1', '2', '3', '5', '6', '7', '8']) => 0.0010115514,
				  (iv_input_dob_match_level in ['4'])                                    => 0.048659031,
																							0.0010115514));

	N315_3 :=__common__( if(((real)iv_mos_since_infutor_last_seen < 4.5), N315_4, N315_5));

	N315_2 :=__common__( if(((real)iv_mos_since_infutor_last_seen > NULL), N315_3, 0.0019698352));

	N315_1 :=__common__( map((nf_fp_sourcerisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => -0.00087763776,
				  (nf_fp_sourcerisktype in ['7'])                                    => N315_2,
																						-0.00087763776));

	N316_8 :=__common__( map((nf_fp_assocrisktype in ['3', '5', '6'])                => -0.0080167843,
				  (nf_fp_assocrisktype in ['1', '2', '4', '7', '8', '9']) => 0.012915493,
																			 0.012915493));

	N316_7 :=__common__( map(trim(C_INC_15K_P) = ''              => 0.0067810741,
				  ((real)c_inc_15k_p < 5.44999980927) => -0.0034068722,
														 0.0067810741));

	N316_6 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '4', '5', '8']) => N316_7,
				  (nf_fp_varrisktype in ['-1', '6', '7', '9'])          => 0.016165496,
																		   N316_7));

	N316_5 :=__common__( map(trim(C_RETAIL) = ''              => -0.00099130982,
				  ((real)c_retail < 5.35000038147) => N316_6,
													  -0.00099130982));

	N316_4 :=__common__( if(((real)c_asian_lang < 113.5), -0.0018780396, N316_5));

	N316_3 :=__common__( if(trim(C_ASIAN_LANG) != '', N316_4, -0.0025418807));

	N316_2 :=__common__( if(((real)iv_mos_src_voter_adl_lseen < 50.5), N316_3, N316_8));

	N316_1 :=__common__( if(((real)iv_mos_src_voter_adl_lseen > NULL), N316_2, -0.0030156697));

	N317_6 :=__common__( map((nf_fp_varrisktype in ['-1', '3', '6', '9'])          => -0.0044459438,
				  (nf_fp_varrisktype in ['1', '2', '4', '5', '7', '8']) => 0.015117724,
																		   0.015117724));

	N317_5 :=__common__( map((iv_nas_summary in [8, 9, 12])                                     => N317_6,
				  (iv_nas_summary in [0, 1, 2, 3, 4, 6, 7, 10, 11]) => 0.057169208,
																								0.057169208));

	N317_4 :=__common__( map((iv_liens_unrel_x_rel in ['0-2', '2-0', '2-2', '3-1', '3-2'])               => -0.0062512533,
				  (iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '3-0']) => N317_5,
																								 N317_5));

	N317_3 :=__common__( if(((real)nf_fp_prevaddrcrimeindex < 190.5), 0.00069128525, N317_4));

	N317_2 :=__common__( if(((real)nf_fp_prevaddrcrimeindex > NULL), N317_3, -0.0012023005));

	N317_1 :=__common__( map(((real)iv_ag001_age <= NULL) => -0.0059542418,
				  ((real)iv_ag001_age < 55.5)  => N317_2,
												  -0.0059542418));

	N318_7 :=__common__( map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-2', '2-1', '2-2', '3-0', '3-1']) => 0.00237398,
				  (iv_liens_unrel_x_rel in ['1-0', '1-1', '2-0', '3-2'])                             => 0.025602111,
																										0.025602111));

	N318_6 :=__common__( map((nf_fp_idrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => -0.0032676439,
				  (nf_fp_idrisktype in ['7'])                                    => 0.090774432,
																					-0.0032676439));

	N318_5 :=__common__( map((nf_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => N318_6,
				  (nf_fp_varrisktype in ['-1', '8'])                              => 0.023596902,
																					 0.023596902));

	N318_4 :=__common__( map((nf_fp_srchvelocityrisktype in ['4', '9'])                          => -0.014188846,
				  (nf_fp_srchvelocityrisktype in ['1', '2', '3', '5', '6', '7', '8']) => N318_5,
																						 N318_5));

	N318_3 :=__common__( map(trim(C_OCCUNIT_P) = ''              => 6.1685343e-005,
				  ((real)c_occunit_p < 82.5500030518) => N318_4,
														 6.1685343e-005));

	N318_2 :=__common__( if(((real)c_work_home < 181.5), N318_3, N318_7));

	N318_1 :=__common__( if(trim(C_WORK_HOME) != '', N318_2, 0.00019382458));

	N319_8 :=__common__( if(((integer)iv_inq_collection_recency < 18), -0.014233331, -0.00071003212));

	N319_7 :=__common__( if(((real)iv_inq_collection_recency > NULL), N319_8, -0.019229056));

	N319_6 :=__common__( map(trim(C_OLD_HOMES) = ''      => N319_7,
				  ((real)c_old_homes < 158.5) => -0.00068765723,
												 N319_7));

	N319_5 :=__common__( if(((real)iv_src_emerge_adl_count < 1.5), 0.0015205826, -0.011388972));

	N319_4 :=__common__( if(((real)iv_src_emerge_adl_count > NULL), N319_5, -0.0025736374));

	N319_3 :=__common__( if(((real)c_hval_40k_p < 2.15000009537), N319_4, N319_6));

	N319_2 :=__common__( if(trim(C_HVAL_40K_P) != '', N319_3, 0.0044079203));

	N319_1 :=__common__( map((nf_fp_divrisktype in ['7', '9'])                          => -0.017410753,
				  (nf_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '8']) => N319_2,
																				N319_2));

	N320_7 :=__common__( map(((real)iv_pl001_bst_addr_lres <= NULL) => -0.0033092757,
				  ((real)iv_pl001_bst_addr_lres < 2.5)   => 0.0052121022,
															-0.0033092757));

	N320_6 :=__common__( if(((real)iv_pv001_bst_avm_chg_1yr > NULL), -0.0034468498, N320_7));

	N320_5 :=__common__( map((iv_infutor_nap in ['0', '1', '10', '12', '4', '6', '7', '9']) => N320_6,
				  (iv_infutor_nap in ['11'])                                     => 0.022354244,
																					N320_6));

	N320_4 :=__common__( if(((real)iv_pl001_m_snc_in_addr_fs < 22.5), N320_5, 0.00097085754));

	N320_3 :=__common__( if(((real)iv_pl001_m_snc_in_addr_fs > NULL), N320_4, 0.00088639653));

	N320_2 :=__common__( map((iv_input_dob_match_level in ['2', '6', '7', '8'])      => N320_3,
				  (iv_input_dob_match_level in ['0', '1', '3', '4', '5']) => 0.0084468159,
																			 0.0084468159));

	N320_1 :=__common__( map((iv_bst_addr_mortgage_term in ['10', '15', '25'])                 => -0.0096031311,
				  (iv_bst_addr_mortgage_term in ['-1', '0', '20', '30', '40', '5']) => N320_2,
																					   -0.0096031311));

	N321_8 :=__common__( map((iv_criminal_x_felony in ['2-0', '2-1', '2-2', '3-0', '3-1']) => -0.016207549,
				  (iv_criminal_x_felony in ['0-0', '1-0', '1-1', '3-2', '3-3']) => -0.0041894903,
																				   -0.0041894903));

	N321_7 :=__common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => -0.00075481277,
				  ((real)iv_pl002_avg_mo_per_addr < 14.5)  => N321_8,
															  -0.00075481277));

	N321_6 :=__common__( map(((real)nf_closest_rel_distance <= NULL) => 0.011359708,
				  ((real)nf_closest_rel_distance < 62.5)  => 0.0004472484,
															 0.011359708));

	N321_5 :=__common__( map(((real)nf_fp_corrphonelastnamecount <= NULL) => N321_7,
				  ((real)nf_fp_corrphonelastnamecount < 0.5)   => N321_6,
																  N321_7));

	N321_4 :=__common__( if(((real)iv_inq_collection_count12 < 2.5), N321_5, 0.0079103338));

	N321_3 :=__common__( if(((real)iv_inq_collection_count12 > NULL), N321_4, -0.00033290953));

	N321_2 :=__common__( if(((real)c_families < 1224.5), N321_3, -0.010873037));

	N321_1 :=__common__( if(trim(C_FAMILIES) != '', N321_2, -0.0021402715));

	N322_8 :=__common__( map((iv_prv_addr_mortgage_term in ['-1', '15', '30', '5'])       => -0.0018711546,
				  (iv_prv_addr_mortgage_term in ['0', '10', '20', '25', '40']) => 0.07595259,
																				  0.07595259));

	N322_7 :=__common__( map(trim(C_HVAL_60K_P) = ''              => N322_8,
				  ((real)c_hval_60k_p < 1.15000009537) => -0.013050604,
														  N322_8));

	N322_6 :=__common__( map((nf_fp_varrisktype in ['-1', '3', '4', '5', '6', '8']) => N322_7,
				  (nf_fp_varrisktype in ['1', '2', '7', '9'])            => 0.00090488527,
																			N322_7));

	N322_5 :=__common__( map((iv_in001_college_income in ['-1', 'D', 'G', 'J'])                    => N322_6,
				  (iv_in001_college_income in ['A', 'B', 'C', 'E', 'F', 'H', 'I', 'K']) => 0.0073726317,
																						   0.0073726317));

	N322_4 :=__common__( if(((real)iv_inp_addr_lres < 50.5), N322_5, 0.0060653327));

	N322_3 :=__common__( if(((real)iv_inp_addr_lres > NULL), N322_4, 0.048914555));

	N322_2 :=__common__( if(((real)c_medi_indx < 91.5), N322_3, -0.0012443792));

	N322_1 :=__common__( if(trim(C_MEDI_INDX) != '', N322_2, -0.00029078795));

	N323_6 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'K']) => 0.010717038,
				  (iv_in001_college_income in ['H', 'I', 'J'])                                => 0.075683693,
																								 0.010717038));

	N323_5 :=__common__( if(((real)iv_bst_addr_avm_change_2yr > NULL), -0.0073321263, N323_6));

	N323_4 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-2', '4-3', '5-1', '5-2']) => N323_5,
				  (iv_gong_did_fname_x_lname_ct in ['4-1', '5-3'])                                                                                                   => 0.099178307,
																																										N323_5));

	N323_3 :=__common__( if(((real)c_low_hval < 61.6500015259), 0.00018716667, N323_4));

	N323_2 :=__common__( if(trim(C_LOW_HVAL) != '', N323_3, 0.0002258971));

	N323_1 :=__common__( map((nf_fp_prevaddrdwelltype in ['F', 'G', 'M', 'P'])       => -0.0075471193,
				  (nf_fp_prevaddrdwelltype in ['-1', 'H', 'R', 'S', 'U']) => N323_2,
																			 N323_2));

	N324_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '6', '9']) => 0.0028399161,
				  (nf_fp_srchcomponentrisktype in ['5', '7', '8'])                => 0.024703307,
																					 0.0028399161));

	N324_6 :=__common__( map(trim(C_RICH_HISP) = ''      => 0.018051067,
				  ((real)c_rich_hisp < 175.5) => N324_7,
												 0.018051067));

	N324_5 :=__common__( map((iv_criminal_x_felony in ['2-2', '3-1', '3-2'])                             => -0.031849819,
				  (iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-3']) => -0.0025766258,
																								 -0.031849819));

	N324_4 :=__common__( map(trim(C_HVAL_100K_P) = ''              => N324_6,
				  ((real)c_hval_100k_p < 1.34999990463) => N324_5,
														   N324_6));

	N324_3 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-1', '3-2', '3-3', '4-1', '4-2', '5-1', '5-3']) => N324_4,
				  (iv_gong_did_fname_x_lname_ct in ['4-3', '5-2'])                                                                                                   => 0.12544638,
																																										N324_4));

	N324_2 :=__common__( if(((real)c_ownocc_p < 75.1499938965), -0.0010301701, N324_3));

	N324_1 :=__common__( if(trim(C_OWNOCC_P) != '', N324_2, 0.0012686349));

	N325_8 :=__common__( map((iv_bst_addr_mortgage_term in ['15', '25'])                             => -0.02435655,
				  (iv_bst_addr_mortgage_term in ['-1', '0', '10', '20', '30', '40', '5']) => 0.00031910144,
																							 0.00031910144));

	N325_7 :=__common__( map(((real)nf_fp_srchfraudsrchcountyr <= NULL) => 0.0097452557,
				  ((real)nf_fp_srchfraudsrchcountyr < 8.5)   => 0.0012069716,
																0.0097452557));

	N325_6 :=__common__( map((nf_fp_srchcomponentrisktype in ['4', '6', '7', '9'])      => -0.022936122,
				  (nf_fp_srchcomponentrisktype in ['1', '2', '3', '5', '8']) => -0.003723311,
																				-0.003723311));

	N325_5 :=__common__( map((iv_liens_unrel_x_rel in ['0-1', '1-1', '2-1', '2-2', '3-1', '3-2']) => N325_6,
				  (iv_liens_unrel_x_rel in ['0-0', '0-2', '1-0', '1-2', '2-0', '3-0']) => N325_7,
																						  N325_7));

	N325_4 :=__common__( map((nf_fp_validationrisktype in ['1', '2', '3', '4', '6', '8']) => N325_5,
				  (nf_fp_validationrisktype in ['5'])                          => 0.10587905,
																				  N325_5));

	N325_3 :=__common__( if(((real)iv_bst_addr_avm_change_3yr > NULL), N325_4, N325_8));

	N325_2 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen < 16.5), -0.0070826001, N325_3));

	N325_1 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen > NULL), N325_2, 0.00022999875));

	N326_10 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'D', 'E', 'F', 'G', 'K']) => -0.0045931515,
				   (iv_in001_college_income in ['B', 'C', 'H', 'I', 'J'])            => 0.023941803,
																						-0.0045931515));

	N326_9 :=__common__( if(((real)c_medi_indx < 91.5), 0.009757226, 0.0013859826));

	N326_8 :=__common__( if(trim(C_MEDI_INDX) != '', N326_9, 0.0086967635));

	N326_7 :=__common__( if(((real)iv_ssns_per_sfd_addr < 19.5), N326_8, N326_10));

	N326_6 :=__common__( if(((real)iv_ssns_per_sfd_addr > NULL), N326_7, -0.0007129267));

	N326_5 :=__common__( map(((real)nf_fp_curraddrmedianincome <= NULL)   => -0.0011859587,
				  ((real)nf_fp_curraddrmedianincome < 40895.5) => N326_6,
																  -0.0011859587));

	N326_4 :=__common__( map((nf_fp_validationrisktype in ['1', '2', '3', '4', '6', '8']) => 0.0008843311,
				  (nf_fp_validationrisktype in ['5'])                          => 0.13796832,
																				  0.0008843311));

	N326_3 :=__common__( if(((real)iv_pv001_bst_avm_chg_1yr > NULL), N326_4, N326_5));

	N326_2 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen < 10.5), -0.0081649672, N326_3));

	N326_1 :=__common__( if(((real)iv_mos_src_bureau_ssn_fseen > NULL), N326_2, -0.0010080966));

	N327_7 :=__common__( map((nf_fp_srchcomponentrisktype in ['1', '2', '3', '4', '8', '9']) => 0.0036295674,
				  (nf_fp_srchcomponentrisktype in ['5', '6', '7'])                => 0.018540374,
																					 0.0036295674));

	N327_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['1-2', '1-3', '2-2', '2-3', '3-2', '4-2', '4-3'])                             => -0.020085757,
				  (iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '2-1', '3-1', '3-3', '4-1', '5-1', '5-2', '5-3']) => -0.0014861017,
																																	 -0.0014861017));

	N327_5 :=__common__( map((nf_fp_varrisktype in ['-1', '4', '7', '8'])          => N327_6,
				  (nf_fp_varrisktype in ['1', '2', '3', '5', '6', '9']) => N327_7,
																		   N327_7));

	N327_4 :=__common__( map(((real)nf_fp_srchaddrsrchcount <= NULL) => -0.0062509155,
				  ((real)nf_fp_srchaddrsrchcount < 24.5)  => N327_5,
															 -0.0062509155));

	N327_3 :=__common__( map((iv_in001_wealth_index in ['1', '2', '3', '4', '6']) => -0.0020200164,
				  (iv_in001_wealth_index in ['5'])                     => 0.014392771,
																		  -0.0020200164));

	N327_2 :=__common__( map((iv_dl_val_flag in ['Not Avail']) => N327_3,
				  (iv_dl_val_flag in ['Empty'])     => N327_4,
													   N327_4));

	N327_1 :=__common__( if(((real)iv_dl_addrs_per_adl > NULL), N327_2, 5.1064237e-005));

	N328_7 :=__common__( map(trim(C_RNT250_P) = ''              => 0.00014707585,
				  ((real)c_rnt250_p < 5.94999980927) => -0.016591908,
														0.00014707585));

	N328_6 :=__common__( map((nf_fp_prevaddrdwelltype in ['-1', 'F', 'G', 'H', 'M', 'P', 'R', 'S']) => -0.00087402424,
				  (nf_fp_prevaddrdwelltype in ['U'])                                     => 0.17251927,
																							-0.00087402424));

	N328_5 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => 0.0073998936,
				  (iv_prv_addr_mortgage_type in ['Equity Loan', 'Government'])                                                                                  => 0.049178891,
																																								   0.0073998936));

	N328_4 :=__common__( map(trim(C_HIGH_ED) = ''              => N328_5,
				  ((real)c_high_ed < 28.1500015259) => 0.0013467109,
													   N328_5));

	N328_3 :=__common__( map(trim(C_OCCUNIT_P) = ''              => N328_6,
				  ((real)c_occunit_p < 90.3500061035) => N328_4,
														 N328_6));

	N328_2 :=__common__( if(((real)c_hh1_p < 55.1500015259), N328_3, N328_7));

	N328_1 :=__common__( if(trim(C_HH1_P) != '', N328_2, 0.004000886));

	N329_7 :=__common__( map(trim(C_HHSIZE) = ''              => 0.0012973654,
				  ((real)c_hhsize < 2.41499996185) => -0.0026237298,
													  0.0012973654));

	N329_6 :=__common__( map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other', 'Unknown']) => N329_7,
				  (iv_prv_addr_mortgage_type in ['Non-Traditional', 'Piggyback'])                                                                            => 0.012792364,
																																								0.012792364));

	N329_5 :=__common__( map((nf_fp_componentcharrisktype in ['7', '8', '9'])                => -0.019774236,
				  (nf_fp_componentcharrisktype in ['1', '2', '3', '4', '5', '6']) => -0.0054776217,
																					 -0.019774236));

	N329_4 :=__common__( map(trim(C_HH3_P) = ''      => N329_5,
				  ((real)c_hh3_p < 10.75) => 0.0055558556,
											 N329_5));

	N329_3 :=__common__( map((iv_phnpop_x_nap_summary in ['002', '101', '102', '103', '105', '107'])                                           => N329_4,
				  (iv_phnpop_x_nap_summary in ['000', '003', '005', '008', '100', '104', '106', '108', '109', '110', '111', '112']) => N329_6,
																																	   N329_6));

	N329_2 :=__common__( if(((real)c_wholesale < 26.3499984741), N329_3, 0.011867884));

	N329_1 :=__common__( if(trim(C_WHOLESALE) != '', N329_2, 0.0021039926));

	N330_7 :=__common__( map(trim(C_LOWRENT) = ''               => 0.0028054829,
				  ((real)c_lowrent < 0.350000023842) => -0.0047844331,
														0.0028054829));

	N330_6 :=__common__( map(trim(C_BUSINESS) = ''     => -0.0058192351,
				  ((real)c_business < 71.5) => N330_7,
											   -0.0058192351));

	N330_5 :=__common__( map(((real)iv_prv_addr_assessed_total_val <= NULL)     => 0.015037018,
				  ((integer)iv_prv_addr_assessed_total_val < 244836) => -0.00015441875,
																		0.015037018));

	N330_4 :=__common__( if(((real)iv_bst_addr_avm_change_3yr > NULL), N330_5, N330_6));

	N330_3 :=__common__( if(((real)c_hval_250k_p < 17.4500007629), N330_4, -0.0036399636));

	N330_2 :=__common__( if(trim(C_HVAL_250K_P) != '', N330_3, -0.0012463087));

	N330_1 :=__common__( map((iv_va100_add_problem in ['04 HiRisk Commercial', '05 Drop Delivery', '07 Busines', '09 Corporate Zip Code', '12 College'])                                                                                        => -0.0080068252,
				  (iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '06 Invalid Address', '10 Zip/City Mismatch', '11 Throw Back', '13 Vacant']) => N330_2,
																																																										N330_2));

	N331_7 :=__common__( map(((real)nf_fp_curraddrmurderindex <= NULL)  => 0.010195017,
				  ((integer)nf_fp_curraddrmurderindex < 103) => -0.0016144559,
																0.010195017));

	N331_6 :=__common__( map(((real)nf_fp_srchaddrsrchcount <= NULL) => 0.0077897314,
				  ((real)nf_fp_srchaddrsrchcount < 42.5)  => -0.0012668112,
															 0.0077897314));

	N331_5 :=__common__( if(((real)c_hval_200k_p < 20.5499992371), N331_6, -0.0090197838));

	N331_4 :=__common__( if(trim(C_HVAL_200K_P) != '', N331_5, -0.00095470762));

	N331_3 :=__common__( if(((real)nf_fp_srchphonesrchcountmo < 1.5), N331_4, N331_7));

	N331_2 :=__common__( if(((real)nf_fp_srchphonesrchcountmo > NULL), N331_3, -0.00099064937));

	N331_1 :=__common__( map((iv_input_dob_match_level in ['1', '2', '3', '6', '7', '8']) => N331_2,
				  (iv_input_dob_match_level in ['0', '4', '5'])                => 0.0085186689,
																				  N331_2));

	N332_7 :=__common__( map((iv_in001_college_income in ['B', 'D', 'G'])                                => -0.013863227,
				  (iv_in001_college_income in ['-1', 'A', 'C', 'E', 'F', 'H', 'I', 'J', 'K']) => 0.012744933,
																								 0.012744933));

	N332_6 :=__common__( map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '06 Invalid Address', '07 Busines', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => N332_7,
				  (iv_va100_add_problem in ['04 HiRisk Commercial', '05 Drop Delivery', '13 Vacant'])                                                                                                                                                                        => 0.043056913,
																																																																				N332_7));

	N332_5 :=__common__( map((nf_fp_srchvelocityrisktype in ['1', '2', '3', '5', '7', '9']) => -0.0048219701,
				  (nf_fp_srchvelocityrisktype in ['4', '6', '8'])                => 0.0096637266,
																					-0.0048219701));

	N332_4 :=__common__( map((nf_fp_assocrisktype in ['2', '3', '4', '7', '9']) => N332_5,
				  (nf_fp_assocrisktype in ['1', '5', '6', '8'])      => N332_6,
																		N332_5));

	N332_3 :=__common__( map((fp_segment in ['1 SSN Prob', '2 NAS 479', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => N332_4,
				  (fp_segment in ['3 New DID'])                                                                           => 0.059726616,
																															 N332_4));

	N332_2 :=__common__( if(((real)c_unemp < 9.94999980927), -0.00014225224, N332_3));

	N332_1 :=__common__( if(trim(C_UNEMP) != '', N332_2, -0.0067780876));

	N333_7 :=__common__( map(trim(C_LOWINC) = ''              => 0.0064697744,
				  ((real)c_lowinc < 22.4500007629) => 0.02053142,
													  0.0064697744));

	N333_6 :=__common__( map(trim(C_NO_CAR) = ''     => N333_7,
				  ((real)c_no_car < 41.5) => -0.0015521938,
											 N333_7));

	N333_5 :=__common__( if(((real)c_no_car < 167.5), N333_6, -0.0048859545));

	N333_4 :=__common__( if(trim(C_NO_CAR) != '', N333_5, -0.00026269158));

	N333_3 :=__common__( if(((real)iv_src_bureau_addr_count < 3.5), N333_4, -0.0006180518));

	N333_2 :=__common__( if(((real)iv_src_bureau_addr_count > NULL), N333_3, 0.0046935369));

	N333_1 :=__common__( map((iv_inp_addr_ownership_lvl in ['Applicant', 'No Ownership']) => -0.0015859425,
				  (iv_inp_addr_ownership_lvl in ['Family', 'Occupant'])        => N333_2,
																				  N333_2));

	N334_8 :=__common__( if(((real)iv_sr001_source_profile < 70.5500030518), 0.010016097, -0.001774165));

	N334_7 :=__common__( if(((real)iv_sr001_source_profile > NULL), N334_8, -9.6361246e-007));

	N334_6 :=__common__( map((iv_gong_did_fname_x_lname_ct in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-1', '2-2', '3-1', '4-1', '5-1', '5-2', '5-3']) => N334_7,
				  (iv_gong_did_fname_x_lname_ct in ['1-3', '2-3', '3-2', '3-3', '4-2', '4-3'])                                           => 0.040253043,
																																			N334_7));

	N334_5 :=__common__( map((iv_vp100_phn_prob in ['6 Pager', '7 PCS'])                                                                        => -0.0021755695,
				  (iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '4 Invalid', '5 Cell', '8 Pay_Phone']) => N334_6,
																																		-0.0021755695));

	N334_4 :=__common__( map((iv_prv_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N334_5,
				  (iv_prv_addr_mortgage_type in ['Commercial', 'High-Risk', 'Piggyback'])                                                            => 0.063149364,
																																						N334_5));

	N334_3 :=__common__( map((iv_dwelltype in ['GEN', 'MFD', 'POB', 'RR']) => -0.0020566424,
				  (iv_dwelltype in ['SFD'])                     => N334_4,
																   -0.0020566424));

	N334_2 :=__common__( if(((real)c_high_ed < 24.8499984741), -0.001687068, N334_3));

	N334_1 :=__common__( if(trim(C_HIGH_ED) != '', N334_2, -0.0020154554));

	N335_7 :=__common__( map(((real)iv_mos_src_bureau_lname_fseen <= NULL) => -0.0067453797,
				  ((real)iv_mos_src_bureau_lname_fseen < 82.5)  => -0.016294298,
																   -0.0067453797));

	N335_6 :=__common__( if(((real)iv_mos_since_infutor_last_seen < 0.5), N335_7, 0.0008133307));

	N335_5 :=__common__( if(((real)iv_mos_since_infutor_last_seen > NULL), N335_6, -0.00028884147));

	N335_4 :=__common__( map((nf_fp_sourcerisktype in ['4', '7', '8', '9'])      => N335_5,
				  (nf_fp_sourcerisktype in ['1', '2', '3', '5', '6']) => 0.00054417051,
																		 0.00054417051));

	N335_3 :=__common__( if(((real)c_hh5_p < 3.84999990463), N335_4, 0.0014726205));

	N335_2 :=__common__( if(trim(C_HH5_P) != '', N335_3, -0.0017543256));

	N335_1 :=__common__( map((nf_fp_divrisktype in ['5', '7', '9'])                => -0.0076092144,
				  (nf_fp_divrisktype in ['1', '2', '3', '4', '6', '8']) => N335_2,
																		   -0.0076092144));

	N336_8 :=__common__( map((nf_add1_util_convenience in ['0']) => -0.0028951693,
				  (nf_add1_util_convenience in ['1']) => 0.0031326467,
														 0.0031326467));

	N336_7 :=__common__( map(((real)nf_average_rel_home_val <= NULL)     => -0.0045503284,
				  ((integer)nf_average_rel_home_val < 155500) => 0.00081586068,
																 -0.0045503284));

	N336_6 :=__common__( map(trim(C_OLDHOUSE) = ''              => N336_8,
				  ((real)c_oldhouse < 122.449996948) => N336_7,
														N336_8));

	N336_5 :=__common__( if(((real)c_pop_0_5_p < 17.1500015259), N336_6, -0.0080780488));

	N336_4 :=__common__( if(trim(C_POP_0_5_P) != '', N336_5, 0.0028899127));

	N336_3 :=__common__( map((iv_inp_addr_financing_type in ['ADJ', 'CNV', 'NONE']) => N336_4,
				  (iv_inp_addr_financing_type in ['OTH'])                => 0.022845705,
																			0.022845705));

	N336_2 :=__common__( if(((real)nf_fp_divsrchaddrsuspidcount < 1.5), N336_3, 0.0078696698));

	N336_1 :=__common__( if(((real)nf_fp_divsrchaddrsuspidcount > NULL), N336_2, 0.0012908815));

	N337_7 :=__common__( map((iv_pb_order_freq in ['0 No Purch Data', '3 Monthly', '5 Quarterly'])                                             => -0.017075322,
				  (iv_pb_order_freq in ['1 Cant Calculate', '2 Weekly', '4 Semi-monthly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => -0.0030300152,
																																	   -0.0030300152));

	N337_6 :=__common__( map((iv_in001_college_income in ['-1', 'A', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K']) => N337_7,
				  (iv_in001_college_income in ['B', 'I'])                                          => 0.034354171,
																									  N337_7));

	N337_5 :=__common__( map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '2-3', '3-0', '3-2']) => 0.0024532348,
				  (iv_paw_dead_bus_x_active_phn in ['1-3', '3-1', '3-3'])                                                                       => 0.058982737,
																																				   0.0024532348));

	N337_4 :=__common__( map((nf_bus_phone_match in [1])           => -0.003552563,
				  (nf_bus_phone_match in [0, 2, 3]) => N337_5,
															 -0.003552563));

	N337_3 :=__common__( map(((real)iv_inq_other_recency <= NULL) => N337_4,
				  ((real)iv_inq_other_recency < 0.5)   => -0.0020872326,
														  N337_4));

	N337_2 :=__common__( if(((real)iv_email_count < 8.5), N337_3, N337_6));

	N337_1 :=__common__( if(((real)iv_email_count > NULL), N337_2, -0.00019372817));

	N338_8 :=__common__( map(trim(C_NO_TEENS) = ''     => -0.0043025994,
				  ((real)c_no_teens < 57.5) => 0.012161769,
											   -0.0043025994));

	N338_7 :=__common__( if(((real)iv_mos_since_infutor_first_seen < 77.5), 0.00081828712, -0.0049164512));

	N338_6 :=__common__( if(((real)iv_mos_since_infutor_first_seen > NULL), N338_7, N338_8));

	N338_5 :=__common__( map((iv_ams_college_major in ['Liberal Arts', 'Medical', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => -0.0033788981,
				  (iv_ams_college_major in ['Business'])                                                                               => 0.08866368,
																																		  -0.0033788981));

	N338_4 :=__common__( map((nf_fp_varrisktype in ['-1', '3', '5', '6', '9']) => -0.015778477,
				  (nf_fp_varrisktype in ['1', '2', '4', '7', '8'])  => N338_5,
																	   -0.015778477));

	N338_3 :=__common__( map(trim(C_HH2_P) = ''      => N338_6,
				  ((real)c_hh2_p < 14.75) => N338_4,
											 N338_6));

	N338_2 :=__common__( if(((real)c_pop_45_54_p < 6.35000038147), -0.0080712841, N338_3));

	N338_1 :=__common__( if(trim(C_POP_45_54_P) != '', N338_2, 0.0049760083));


	tnscore :=__common__( sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, 
		N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, 
		N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, 
		N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, 
		N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, 
		N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, 
		N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, 
		N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1, N79_1, 
		N80_1, N81_1, N82_1, N83_1, N84_1, N85_1, N86_1, N87_1, N88_1, N89_1, 
		N90_1, N91_1, N92_1, N93_1, N94_1, N95_1, N96_1, N97_1, N98_1, N99_1, 
		N100_1, N101_1, N102_1, N103_1, N104_1, N105_1, N106_1, N107_1, N108_1, N109_1, 
		N110_1, N111_1, N112_1, N113_1, N114_1, N115_1, N116_1, N117_1, N118_1, N119_1, 
		N120_1, N121_1, N122_1, N123_1, N124_1, N125_1, N126_1, N127_1, N128_1, N129_1, 
		N130_1, N131_1, N132_1, N133_1, N134_1, N135_1, N136_1, N137_1, N138_1, N139_1, 
		N140_1, N141_1, N142_1, N143_1, N144_1, N145_1, N146_1, N147_1, N148_1, N149_1, 
		N150_1, N151_1, N152_1, N153_1, N154_1, N155_1, N156_1, N157_1, N158_1, N159_1, 
		N160_1, N161_1, N162_1, N163_1, N164_1, N165_1, N166_1, N167_1, N168_1, N169_1, 
		N170_1, N171_1, N172_1, N173_1, N174_1, N175_1, N176_1, N177_1, N178_1, N179_1, 
		N180_1, N181_1, N182_1, N183_1, N184_1, N185_1, N186_1, N187_1, N188_1, N189_1, 
		N190_1, N191_1, N192_1, N193_1, N194_1, N195_1, N196_1, N197_1, N198_1, N199_1, 
		N200_1, N201_1, N202_1, N203_1, N204_1, N205_1, N206_1, N207_1, N208_1, N209_1, 
		N210_1, N211_1, N212_1, N213_1, N214_1, N215_1, N216_1, N217_1, N218_1, N219_1, 
		N220_1, N221_1, N222_1, N223_1, N224_1, N225_1, N226_1, N227_1, N228_1, N229_1, 
		N230_1, N231_1, N232_1, N233_1, N234_1, N235_1, N236_1, N237_1, N238_1, N239_1, 
		N240_1, N241_1, N242_1, N243_1, N244_1, N245_1, N246_1, N247_1, N248_1, N249_1, 
		N250_1, N251_1, N252_1, N253_1, N254_1, N255_1, N256_1, N257_1, N258_1, N259_1, 
		N260_1, N261_1, N262_1, N263_1, N264_1, N265_1, N266_1, N267_1, N268_1, N269_1, 
		N270_1, N271_1, N272_1, N273_1, N274_1, N275_1, N276_1, N277_1, N278_1, N279_1, 
		N280_1, N281_1, N282_1, N283_1, N284_1, N285_1, N286_1, N287_1, N288_1, N289_1, 
		N290_1, N291_1, N292_1, N293_1, N294_1, N295_1, N296_1, N297_1, N298_1, N299_1, 
		N300_1, N301_1, N302_1, N303_1, N304_1, N305_1, N306_1, N307_1, N308_1, N309_1, 
		N310_1, N311_1, N312_1, N313_1, N314_1, N315_1, N316_1, N317_1, N318_1, N319_1, 
		N320_1, N321_1, N322_1, N323_1, N324_1, N325_1, N326_1, N327_1, N328_1, N329_1, 
		N330_1, N331_1, N332_1, N333_1, N334_1, N335_1, N336_1, N337_1, N338_1));

	expsum_2 :=__common__( 0.0);

	class_threshold :=__common__( 0.5);

	score0 :=__common__( exp(-tnscore));

	expsum_1 :=__common__( expsum_2 + score0);

	score1 :=__common__( exp(tnscore));

	expsum :=__common__( expsum_1 + score1);

	prob0 :=__common__( score0 / expsum);

	prob1 :=__common__( score1 / expsum);

	base :=__common__( 700);

	pts :=__common__( -50);

	odds :=__common__( .0956 / (1 - .0956));

	fp1404_1_0 :=__common__( min(if(max(round(pts * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base), 300)), 999));

	pred_1 :=__common__( 0);

	pred :=__common__( if(prob1 > class_threshold, 1, pred_1));


#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam															:= le;
                    self.sysdate                          := (string)sysdate;
                    self.ssnpop                           := (string)ssnpop;
                    self.ver_src_ds                       := (string)(integer)ver_src_ds;
                    self.ver_src_eq                       := (string)(integer)ver_src_eq;
                    self.ver_src_en                       := (string)(integer)ver_src_en;
                    self.ver_src_tn                       := (string)(integer)ver_src_tn;
                    self.ver_src_tu                       := (string)(integer)ver_src_tu;
                    self.ver_src_cnt                      := (string)ver_src_cnt;
                    self.credit_source_cnt                := (string)credit_source_cnt;
                    self.bureauonly2                      := (string)(integer)bureauonly2;
                    self._derog                           := (string)(integer)_derog;
                    self.iv_add_apt                       := (string)iv_add_apt;
                    self._in_dob                          := (string)_in_dob;
                    self.yr_in_dob                        := (string)yr_in_dob;
                    self.yr_in_dob_int                    := (string)yr_in_dob_int;
                    self.age_estimate                     := (string)age_estimate;
                    self.iv_vp091_phnzip_mismatch         := (string)iv_vp091_phnzip_mismatch;
                    self.iv_vp001_phn_not_issued          := (string)iv_vp001_phn_not_issued;
                    self.iv_vp008_phn_pay_phone           := (string)iv_vp008_phn_pay_phone;
                    self.iv_vp050_phn_cmp_pcs             := (string)iv_vp050_phn_cmp_pcs;
                    self.iv_vp100_phn_prob                := (string)iv_vp100_phn_prob;
                    self.iv_va001_add_po_box              := (string)iv_va001_add_po_box;
                    self.iv_va008_add_throwback           := (string)iv_va008_add_throwback;
                    self.add_ec1                          := (string)add_ec1;
                    self.add_ec3                          := (string)add_ec3;
                    self.add_ec4                          := (string)add_ec4;
                    self.iv_va100_add_problem             := (string)iv_va100_add_problem;
                    self.iv_po001_inp_addr_naprop         := (string)iv_po001_inp_addr_naprop;
                    self.iv_in001_wealth_index            := (string)iv_in001_wealth_index;
                    self.iv_in001_college_income          := (string)iv_in001_college_income;
                    self.iv_ed001_college_ind_26          := (string)iv_ed001_college_ind_26;
                    self.iv_ed001_college_ind_29          := (string)iv_ed001_college_ind_29;
                    self.iv_ed001_college_ind_36          := (string)iv_ed001_college_ind_36;
                    self.iv_ed001_college_ind_37          := (string)iv_ed001_college_ind_37;
                    self.iv_ed001_college_ind_40          := (string)iv_ed001_college_ind_40;
                    self.iv_ed001_college_ind_50          := (string)iv_ed001_college_ind_50;
                    self.iv_ed001_college_ind_60          := (string)iv_ed001_college_ind_60;
                    self.iv_phnpop_x_nap_summary          := (string)iv_phnpop_x_nap_summary;
                    self.iv_nap_status                    := (string)iv_nap_status;
                    self.iv_dl_val_flag                   := (string)iv_dl_val_flag;
                    self.nf_bus_name_match                := (string)nf_bus_name_match;
                    self.nf_bus_phone_match               := (string)nf_bus_phone_match;
                    self.iv_fname_eda_sourced_type        := (string)iv_fname_eda_sourced_type;
                    self.iv_lname_eda_sourced_type        := (string)iv_lname_eda_sourced_type;
                    self.iv_addr_ver_sources              := (string)iv_addr_ver_sources;
                    self.iv_input_dob_match_level         := (string)iv_input_dob_match_level;
                    self.iv_ssn_miskey                    := (string)iv_ssn_miskey;
                    self.iv_phn_miskey                    := (string)iv_phn_miskey;
                    self.iv_dwelltype                     := (string)iv_dwelltype;
                    self.nf_adl_util_convenience          := (string)nf_adl_util_convenience;
                    self.nf_add1_util_convenience         := (string)nf_add1_util_convenience;
                    self.iv_inp_addr_ownership_lvl        := (string)iv_inp_addr_ownership_lvl;
                    self.iv_inp_own_prop_x_addr_naprop    := (string)iv_inp_own_prop_x_addr_naprop;
                    self.iv_inp_addr_mortgage_term        := (string)iv_inp_addr_mortgage_term;
                    self.iv_inp_addr_mortgage_type        := (string)iv_inp_addr_mortgage_type;
                    self.iv_inp_addr_financing_type       := (string)iv_inp_addr_financing_type;
                    self.iv_bst_addr_naprop               := (string)iv_bst_addr_naprop;
                    self.iv_bst_own_prop_x_addr_naprop    := (string)iv_bst_own_prop_x_addr_naprop;
                    self._add1_mortgage_date              := (string)_add1_mortgage_date;
                    self._add1_mortgage_due_date          := (string)_add1_mortgage_due_date;
                    self.iv_bst_addr_mortgage_term        := (string)iv_bst_addr_mortgage_term;
                    self.iv_bst_addr_mortgage_type        := (string)iv_bst_addr_mortgage_type;
                    self.iv_bst_addr_financing_type       := (string)iv_bst_addr_financing_type;
                    self.iv_bst_addr_avm_land_use         := (string)iv_bst_addr_avm_land_use;
                    self.iv_prv_addr_ownership_lvl        := (string)iv_prv_addr_ownership_lvl;
                    self.iv_prv_addr_eda_sourced          := ''; //(string)iv_prv_addr_eda_sourced;
                    self.iv_prv_own_prop_x_addr_naprop    := (string)iv_prv_own_prop_x_addr_naprop;
                    self._add2_mortgage_date              := (string)_add2_mortgage_date;
                    self._add2_mortgage_due_date          := (string)_add2_mortgage_due_date;
                    self._add3_mortgage_date              := (string)_add3_mortgage_date;
                    self._add3_mortgage_due_date          := (string)_add3_mortgage_due_date;
                    self.mortgage_date_diff               := (string)mortgage_date_diff;
                    self.iv_prv_addr_mortgage_term        := (string)iv_prv_addr_mortgage_term;
                    self.mortgage_type                    := (string)mortgage_type;
                    self.mortgage_present                 := (string)(integer)mortgage_present;
                    self.iv_prv_addr_mortgage_type        := (string)iv_prv_addr_mortgage_type;
                    self.iv_gong_did_fname_x_lname_ct     := (string)iv_gong_did_fname_x_lname_ct;
                    self.iv_paw_dead_bus_x_active_phn     := (string)iv_paw_dead_bus_x_active_phn;
                    self.iv_infutor_nap                   := (string)iv_infutor_nap;
                    self.ver_phn_inf                      := (string)(integer)ver_phn_inf;
                    self.ver_phn_nap                      := (string)(integer)ver_phn_nap;
                    self.inf_phn_ver_lvl                  := (string)inf_phn_ver_lvl;
                    self.nap_phn_ver_lvl                  := (string)nap_phn_ver_lvl;
                    self.iv_nap_phn_ver_x_inf_phn_ver     := (string)iv_nap_phn_ver_x_inf_phn_ver;
                    self.iv_num_purch_x_num_sold_60       := (string)iv_num_purch_x_num_sold_60;
                    self.iv_rec_vehx_level                := (string)iv_rec_vehx_level;
                    self.iv_liens_unrel_x_rel             := (string)iv_liens_unrel_x_rel;
                    self.iv_criminal_x_felony             := (string)iv_criminal_x_felony;
                    self.ams_major_medical                := (string)ams_major_medical;
                    self.ams_major_science                := (string)ams_major_science;
                    self.ams_major_liberal                := (string)ams_major_liberal;
                    self.ams_major_business               := (string)ams_major_business;
                    self.ams_major_unknown                := (string)ams_major_unknown;
                    self.iv_ams_college_major             := (string)iv_ams_college_major;
                    self.iv_ams_college_tier              := (string)iv_ams_college_tier;
                    self.iv_prof_license_category         := (string)iv_prof_license_category;
                    self.sum_dols                         := (string)sum_dols;
                    self.pct_offline_dols                 := (string)pct_offline_dols;
                    self.pct_retail_dols                  := (string)pct_retail_dols;
                    self.pct_online_dols                  := (string)pct_online_dols;
                    self.iv_pb_profile                    := (string)iv_pb_profile;
                    self.iv_pb_order_freq                 := (string)iv_pb_order_freq;
                    self.nf_fp_idrisktype                 := (string)nf_fp_idrisktype;
                    self.nf_fp_idverrisktype              := (string)nf_fp_idverrisktype;
                    self.nf_fp_idveraddressnotcurrent     := (string)nf_fp_idveraddressnotcurrent;
                    self.nf_fp_sourcerisktype             := (string)nf_fp_sourcerisktype;
                    self.nf_fp_varrisktype                := (string)nf_fp_varrisktype;
                    self.nf_fp_srchvelocityrisktype       := (string)nf_fp_srchvelocityrisktype;
                    self.nf_fp_assocrisktype              := (string)nf_fp_assocrisktype;
                    self.nf_fp_validationrisktype         := (string)nf_fp_validationrisktype;
                    self.nf_fp_corrrisktype               := (string)nf_fp_corrrisktype;
                    self.nf_fp_divrisktype                := (string)nf_fp_divrisktype;
                    self.nf_fp_srchcomponentrisktype      := (string)nf_fp_srchcomponentrisktype;
                    self.nf_fp_componentcharrisktype      := (string)nf_fp_componentcharrisktype;
                    self.nf_fp_addrchangeecontrajindex    := (string)nf_fp_addrchangeecontrajindex;
                    self.nf_fp_prevaddrdwelltype          := (string)nf_fp_prevaddrdwelltype;
                    self.nf_fp_prevaddroccupantowned      := (string)nf_fp_prevaddroccupantowned;
                    self.iv_va060_dist_add_in_bst         := (string)iv_va060_dist_add_in_bst;
                    self._criminal_last_date              := (string)_criminal_last_date;
                    self.iv_dc001_mos_since_crim_ls       := (string)iv_dc001_mos_since_crim_ls;
                    self._felony_last_date                := (string)_felony_last_date;
                    self.iv_df001_mos_since_fel_ls        := (string)iv_df001_mos_since_fel_ls;
                    self.iv_dg001_derog_count             := (string)iv_dg001_derog_count;
                    self.iv_de001_eviction_recency        := (string)iv_de001_eviction_recency;
                    self.email_src_im                     := (string)(integer)email_src_im;
                    self.iv_ds001_impulse_count           := (string)iv_ds001_impulse_count;
                    self.iv_dl001_unrel_lien60_count      := (string)iv_dl001_unrel_lien60_count;
                    self.lien_adl_li_lseen_pos            := (string)lien_adl_li_lseen_pos;
                    self.lien_adl_lseen_li                := (string)lien_adl_lseen_li;
                    self._lien_adl_lseen_li               := (string)_lien_adl_lseen_li;
                    self.lien_adl_l2_lseen_pos            := (string)lien_adl_l2_lseen_pos;
                    self.lien_adl_lseen_l2                := (string)lien_adl_lseen_l2;
                    self._lien_adl_lseen_l2               := (string)_lien_adl_lseen_l2;
                    self._src_lien_adl_lseen              := (string)_src_lien_adl_lseen;
                    self.iv_dl001_lien_last_seen          := (string)iv_dl001_lien_last_seen;
                    self.bureau_adl_tn_fseen_pos          := (string)bureau_adl_tn_fseen_pos;
                    self.bureau_adl_fseen_tn              := (string)bureau_adl_fseen_tn;
                    self._bureau_adl_fseen_tn             := (string)_bureau_adl_fseen_tn;
                    self.bureau_adl_ts_fseen_pos          := (string)bureau_adl_ts_fseen_pos;
                    self.bureau_adl_fseen_ts              := (string)bureau_adl_fseen_ts;
                    self._bureau_adl_fseen_ts             := (string)_bureau_adl_fseen_ts;
                    self.bureau_adl_tu_fseen_pos          := (string)bureau_adl_tu_fseen_pos;
                    self.bureau_adl_fseen_tu              := (string)bureau_adl_fseen_tu;
                    self._bureau_adl_fseen_tu             := (string)_bureau_adl_fseen_tu;
                    self.bureau_adl_en_fseen_pos          := (string)bureau_adl_en_fseen_pos;
                    self.bureau_adl_fseen_en              := (string)bureau_adl_fseen_en;
                    self._bureau_adl_fseen_en             := (string)_bureau_adl_fseen_en;
                    self.bureau_adl_eq_fseen_pos          := (string)bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := (string)bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := (string)_bureau_adl_fseen_eq;
                    self.iv_sr001_m_bureau_adl_fs         := (string)iv_sr001_m_bureau_adl_fs;
                    self.bureau_adl_vo_fseen_pos          := (string)bureau_adl_vo_fseen_pos;
                    self.bureau_adl_fseen_vo              := (string)bureau_adl_fseen_vo;
                    self._bureau_adl_fseen_vo             := (string)_bureau_adl_fseen_vo;
                    self._src_bureau_adl_fseen            := (string)_src_bureau_adl_fseen;
                    self.mth_ver_src_fdate_vo             := (string)mth_ver_src_fdate_vo;
                    self.bureau_adl_vo_lseen_pos          := (string)bureau_adl_vo_lseen_pos;
                    self.bureau_adl_lseen_vo              := (string)bureau_adl_lseen_vo;
                    self._bureau_adl_lseen_vo             := (string)_bureau_adl_lseen_vo;
                    self.mth_ver_src_ldate_vo             := (string)mth_ver_src_ldate_vo;
                    self.mth_ver_src_fdate_vo60           := (string)(integer)mth_ver_src_fdate_vo60;
                    self.mth_ver_src_ldate_vo0            := (string)(integer)mth_ver_src_ldate_vo0;
                    self.bureau_adl_w_lseen_pos           := (string)bureau_adl_w_lseen_pos;
                    self.bureau_adl_lseen_w               := (string)bureau_adl_lseen_w;
                    self._bureau_adl_lseen_w              := (string)_bureau_adl_lseen_w;
                    self.mth_ver_src_ldate_w              := (string)mth_ver_src_ldate_w;
                    self.mth_ver_src_ldate_w0             := (string)(integer)mth_ver_src_ldate_w0;
                    self.bureau_adl_wp_lseen_pos          := (string)bureau_adl_wp_lseen_pos;
                    self.bureau_adl_lseen_wp              := (string)bureau_adl_lseen_wp;
                    self._bureau_adl_lseen_wp             := (string)_bureau_adl_lseen_wp;
                    self._src_bureau_adl_lseen            := (string)_src_bureau_adl_lseen;
                    self.mth_ver_src_ldate_wp             := (string)mth_ver_src_ldate_wp;
                    self.mth_ver_src_ldate_wp0            := (string)(integer)mth_ver_src_ldate_wp0;
                    self._paw_first_seen                  := (string)_paw_first_seen;
                    self.mth_paw_first_seen               := (string)mth_paw_first_seen;
                    self.mth_paw_first_seen2              := (string)mth_paw_first_seen2;
                    self.ver_src_am                       := (string)(integer)ver_src_am;
                    self.ver_src_e1                       := (string)(integer)ver_src_e1;
                    self.ver_src_e2                       := (string)(integer)ver_src_e2;
                    self.ver_src_e3                       := (string)(integer)ver_src_e3;
                    self.ver_src_pl                       := (string)(integer)ver_src_pl;
                    self.ver_src_w                        := (string)(integer)ver_src_w;
                    self.paw_dead_business_count_gt3      := (string)(integer)paw_dead_business_count_gt3;
                    self.paw_active_phone_count_0         := (string)(integer)paw_active_phone_count_0;
                    self.mth_infutor_first_seen           := (string)mth_infutor_first_seen;
                    self.mth_infutor_last_seen            := (string)mth_infutor_last_seen;
                    self.infutor_i                        := (string)infutor_i;
                    self.infutor_im                       := (string)infutor_im;
                    self.white_pages_adl_wp_fseen_pos     := (string)white_pages_adl_wp_fseen_pos;
                    self.white_pages_adl_fseen_wp         := (string)white_pages_adl_fseen_wp;
                    self._white_pages_adl_fseen_wp        := (string)_white_pages_adl_fseen_wp;
                    self._src_white_pages_adl_fseen       := (string)_src_white_pages_adl_fseen;
                    self.iv_sr001_m_wp_adl_fs             := (string)iv_sr001_m_wp_adl_fs;
                    self.src_m_wp_adl_fs                  := (string)src_m_wp_adl_fs;
                    self._header_first_seen               := (string)_header_first_seen;
                    self.iv_sr001_m_hdr_fs                := (string)iv_sr001_m_hdr_fs;
                    self.src_m_hdr_fs                     := (string)src_m_hdr_fs;
                    self.source_mod6                      := (string)source_mod6;
                    self.iv_sr001_source_profile          := (string)iv_sr001_source_profile;
                    self.iv_ms001_ssns_per_adl            := (string)iv_ms001_ssns_per_adl;
                    self.iv_pv001_inp_avm_autoval         := (string)iv_pv001_inp_avm_autoval;
                    self.iv_pv001_bst_avm_autoval         := (string)iv_pv001_bst_avm_autoval;
                    self.bst_addr_avm_auto_val_2          := (string)bst_addr_avm_auto_val_2;
                    self.iv_pv001_bst_avm_chg_1yr         := (string)iv_pv001_bst_avm_chg_1yr;
                    self.iv_pv001_bst_avm_chg_1yr_pct     := (string)iv_pv001_bst_avm_chg_1yr_pct;
                    self.inp_addr_date_first_seen         := (string)inp_addr_date_first_seen;
                    self.iv_pl001_m_snc_in_addr_fs        := (string)iv_pl001_m_snc_in_addr_fs;
                    self.iv_pl001_bst_addr_lres           := (string)iv_pl001_bst_addr_lres;
                    self.iv_pl002_avg_mo_per_addr         := (string)iv_pl002_avg_mo_per_addr;
                    self.iv_iq001_inq_count12             := (string)iv_iq001_inq_count12;
                    self.bureau_ssn_tn_count_pos          := (string)bureau_ssn_tn_count_pos;
                    self.bureau_ssn_count_tn              := (string)bureau_ssn_count_tn;
                    self.bureau_ssn_ts_count_pos          := (string)bureau_ssn_ts_count_pos;
                    self.bureau_ssn_count_ts              := (string)bureau_ssn_count_ts;
                    self.bureau_ssn_tu_count_pos          := (string)bureau_ssn_tu_count_pos;
                    self.bureau_ssn_count_tu              := (string)bureau_ssn_count_tu;
                    self.bureau_ssn_en_count_pos          := (string)bureau_ssn_en_count_pos;
                    self.bureau_ssn_count_en              := (string)bureau_ssn_count_en;
                    self.bureau_ssn_eq_count_pos          := (string)bureau_ssn_eq_count_pos;
                    self.bureau_ssn_count_eq              := (string)bureau_ssn_count_eq;
                    self._src_bureau_ssn_count            := (string)_src_bureau_ssn_count;
                    self.iv_src_bureau_ssn_count          := (string)iv_src_bureau_ssn_count;
                    self.bureau_ssn_tn_fseen_pos          := (string)bureau_ssn_tn_fseen_pos;
                    self.bureau_ssn_fseen_tn              := (string)bureau_ssn_fseen_tn;
                    self._bureau_ssn_fseen_tn             := (string)_bureau_ssn_fseen_tn;
                    self.bureau_ssn_ts_fseen_pos          := (string)bureau_ssn_ts_fseen_pos;
                    self.bureau_ssn_fseen_ts              := (string)bureau_ssn_fseen_ts;
                    self._bureau_ssn_fseen_ts             := (string)_bureau_ssn_fseen_ts;
                    self.bureau_ssn_tu_fseen_pos          := (string)bureau_ssn_tu_fseen_pos;
                    self.bureau_ssn_fseen_tu              := (string)bureau_ssn_fseen_tu;
                    self._bureau_ssn_fseen_tu             := (string)_bureau_ssn_fseen_tu;
                    self.bureau_ssn_en_fseen_pos          := (string)bureau_ssn_en_fseen_pos;
                    self.bureau_ssn_fseen_en              := (string)bureau_ssn_fseen_en;
                    self._bureau_ssn_fseen_en             := (string)_bureau_ssn_fseen_en;
                    self.bureau_ssn_eq_fseen_pos          := (string)bureau_ssn_eq_fseen_pos;
                    self.bureau_ssn_fseen_eq              := (string)bureau_ssn_fseen_eq;
                    self._bureau_ssn_fseen_eq             := (string)_bureau_ssn_fseen_eq;
                    self._src_bureau_ssn_fseen            := (string)_src_bureau_ssn_fseen;
                    self.iv_mos_src_bureau_ssn_fseen      := (string)iv_mos_src_bureau_ssn_fseen;
                    self.bureau_addr_tn_count_pos         := (string)bureau_addr_tn_count_pos;
                    self.bureau_addr_count_tn             := (string)bureau_addr_count_tn;
                    self.bureau_addr_ts_count_pos         := (string)bureau_addr_ts_count_pos;
                    self.bureau_addr_count_ts             := (string)bureau_addr_count_ts;
                    self.bureau_addr_tu_count_pos         := (string)bureau_addr_tu_count_pos;
                    self.bureau_addr_count_tu             := (string)bureau_addr_count_tu;
                    self.bureau_addr_en_count_pos         := (string)bureau_addr_en_count_pos;
                    self.bureau_addr_count_en             := (string)bureau_addr_count_en;
                    self.bureau_addr_eq_count_pos         := (string)bureau_addr_eq_count_pos;
                    self.bureau_addr_count_eq             := (string)bureau_addr_count_eq;
                    self._src_bureau_addr_count           := (string)_src_bureau_addr_count;
                    self.iv_src_bureau_addr_count         := (string)iv_src_bureau_addr_count;
                    self.bureau_addr_tn_fseen_pos         := (string)bureau_addr_tn_fseen_pos;
                    self.bureau_addr_fseen_tn             := (string)bureau_addr_fseen_tn;
                    self._bureau_addr_fseen_tn            := (string)_bureau_addr_fseen_tn;
                    self.bureau_addr_ts_fseen_pos         := (string)bureau_addr_ts_fseen_pos;
                    self.bureau_addr_fseen_ts             := (string)bureau_addr_fseen_ts;
                    self._bureau_addr_fseen_ts            := (string)_bureau_addr_fseen_ts;
                    self.bureau_addr_tu_fseen_pos         := (string)bureau_addr_tu_fseen_pos;
                    self.bureau_addr_fseen_tu             := (string)bureau_addr_fseen_tu;
                    self._bureau_addr_fseen_tu            := (string)_bureau_addr_fseen_tu;
                    self.bureau_addr_en_fseen_pos         := (string)bureau_addr_en_fseen_pos;
                    self.bureau_addr_fseen_en             := (string)bureau_addr_fseen_en;
                    self._bureau_addr_fseen_en            := (string)_bureau_addr_fseen_en;
                    self.bureau_addr_eq_fseen_pos         := (string)bureau_addr_eq_fseen_pos;
                    self.bureau_addr_fseen_eq             := (string)bureau_addr_fseen_eq;
                    self._bureau_addr_fseen_eq            := (string)_bureau_addr_fseen_eq;
                    self._src_bureau_addr_fseen           := (string)_src_bureau_addr_fseen;
                    self.iv_mos_src_bureau_addr_fseen     := (string)iv_mos_src_bureau_addr_fseen;
                    self.bureau_lname_tn_count_pos        := (string)bureau_lname_tn_count_pos;
                    self.bureau_lname_count_tn            := (string)bureau_lname_count_tn;
                    self.bureau_lname_ts_count_pos        := (string)bureau_lname_ts_count_pos;
                    self.bureau_lname_count_ts            := (string)bureau_lname_count_ts;
                    self.bureau_lname_tu_count_pos        := (string)bureau_lname_tu_count_pos;
                    self.bureau_lname_count_tu            := (string)bureau_lname_count_tu;
                    self.bureau_lname_en_count_pos        := (string)bureau_lname_en_count_pos;
                    self.bureau_lname_count_en            := (string)bureau_lname_count_en;
                    self.bureau_lname_eq_count_pos        := (string)bureau_lname_eq_count_pos;
                    self.bureau_lname_count_eq            := (string)bureau_lname_count_eq;
                    self._src_bureau_lname_count          := (string)_src_bureau_lname_count;
                    self.iv_src_bureau_lname_count        := (string)iv_src_bureau_lname_count;
                    self.bureau_lname_tn_fseen_pos        := (string)bureau_lname_tn_fseen_pos;
                    self.bureau_lname_fseen_tn            := (string)bureau_lname_fseen_tn;
                    self._bureau_lname_fseen_tn           := (string)_bureau_lname_fseen_tn;
                    self.bureau_lname_ts_fseen_pos        := (string)bureau_lname_ts_fseen_pos;
                    self.bureau_lname_fseen_ts            := (string)bureau_lname_fseen_ts;
                    self._bureau_lname_fseen_ts           := (string)_bureau_lname_fseen_ts;
                    self.bureau_lname_tu_fseen_pos        := (string)bureau_lname_tu_fseen_pos;
                    self.bureau_lname_fseen_tu            := (string)bureau_lname_fseen_tu;
                    self._bureau_lname_fseen_tu           := (string)_bureau_lname_fseen_tu;
                    self.bureau_lname_en_fseen_pos        := (string)bureau_lname_en_fseen_pos;
                    self.bureau_lname_fseen_en            := (string)bureau_lname_fseen_en;
                    self._bureau_lname_fseen_en           := (string)_bureau_lname_fseen_en;
                    self.bureau_lname_eq_fseen_pos        := (string)bureau_lname_eq_fseen_pos;
                    self.bureau_lname_fseen_eq            := (string)bureau_lname_fseen_eq;
                    self._bureau_lname_fseen_eq           := (string)_bureau_lname_fseen_eq;
                    self._src_bureau_lname_fseen          := (string)_src_bureau_lname_fseen;
                    self.iv_mos_src_bureau_lname_fseen    := (string)iv_mos_src_bureau_lname_fseen;
                    self.bureau_dob_tn_count_pos          := (string)bureau_dob_tn_count_pos;
                    self.bureau_dob_count_tn              := (string)bureau_dob_count_tn;
                    self.bureau_dob_ts_count_pos          := (string)bureau_dob_ts_count_pos;
                    self.bureau_dob_count_ts              := (string)bureau_dob_count_ts;
                    self.bureau_dob_tu_count_pos          := (string)bureau_dob_tu_count_pos;
                    self.bureau_dob_count_tu              := (string)bureau_dob_count_tu;
                    self.bureau_dob_en_count_pos          := (string)bureau_dob_en_count_pos;
                    self.bureau_dob_count_en              := (string)bureau_dob_count_en;
                    self.bureau_dob_eq_count_pos          := (string)bureau_dob_eq_count_pos;
                    self.bureau_dob_count_eq              := (string)bureau_dob_count_eq;
                    self._src_bureau_dob_count            := (string)_src_bureau_dob_count;
                    self.iv_src_bureau_dob_count          := (string)iv_src_bureau_dob_count;
                    self.bureau_dob_tn_fseen_pos          := (string)bureau_dob_tn_fseen_pos;
                    self.bureau_dob_fseen_tn              := (string)bureau_dob_fseen_tn;
                    self._bureau_dob_fseen_tn             := (string)_bureau_dob_fseen_tn;
                    self.bureau_dob_ts_fseen_pos          := (string)bureau_dob_ts_fseen_pos;
                    self.bureau_dob_fseen_ts              := (string)bureau_dob_fseen_ts;
                    self._bureau_dob_fseen_ts             := (string)_bureau_dob_fseen_ts;
                    self.bureau_dob_tu_fseen_pos          := (string)bureau_dob_tu_fseen_pos;
                    self.bureau_dob_fseen_tu              := (string)bureau_dob_fseen_tu;
                    self._bureau_dob_fseen_tu             := (string)_bureau_dob_fseen_tu;
                    self.bureau_dob_en_fseen_pos          := (string)bureau_dob_en_fseen_pos;
                    self.bureau_dob_fseen_en              := (string)bureau_dob_fseen_en;
                    self._bureau_dob_fseen_en             := (string)_bureau_dob_fseen_en;
                    self.bureau_dob_eq_fseen_pos          := (string)bureau_dob_eq_fseen_pos;
                    self.bureau_dob_fseen_eq              := (string)bureau_dob_fseen_eq;
                    self._bureau_dob_fseen_eq             := (string)_bureau_dob_fseen_eq;
                    self._src_bureau_dob_fseen            := (string)_src_bureau_dob_fseen;
                    self.iv_mos_src_bureau_dob_fseen      := (string)iv_mos_src_bureau_dob_fseen;
                    self.lien_adl_li_count_pos            := (string)lien_adl_li_count_pos;
                    self.lien_adl_count_li                := (string)lien_adl_count_li;
                    self.lien_adl_l2_count_pos            := (string)lien_adl_l2_count_pos;
                    self.lien_adl_count_l2                := (string)lien_adl_count_l2;
                    self._src_lien_adl_count              := (string)_src_lien_adl_count;
                    self.iv_src_liens_adl_count           := (string)iv_src_liens_adl_count;
                    self.prop_adl_p_count_pos             := (string)prop_adl_p_count_pos;
                    self.prop_adl_count_p                 := (string)prop_adl_count_p;
                    self._src_prop_adl_count              := (string)_src_prop_adl_count;
                    self.iv_src_property_adl_count        := (string)iv_src_property_adl_count;
                    self.voter_adl_v_count_pos            := (string)voter_adl_v_count_pos;
                    self.iv_src_voter_adl_count           := (string)iv_src_voter_adl_count;
                    self.vote_adl_vo_lseen_pos            := (string)vote_adl_vo_lseen_pos;
                    self.vote_adl_lseen_vo                := (string)vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := (string)_vote_adl_lseen_vo;
                    self._src_vote_adl_lseen              := (string)_src_vote_adl_lseen;
                    self.iv_mos_src_voter_adl_lseen       := (string)iv_mos_src_voter_adl_lseen;
                    self.emerge_adl_em_count_pos          := (string)emerge_adl_em_count_pos;
                    self.emerge_adl_count_em              := (string)emerge_adl_count_em;
                    self.emerge_adl_e1_count_pos          := (string)emerge_adl_e1_count_pos;
                    self.emerge_adl_count_e1              := (string)emerge_adl_count_e1;
                    self.emerge_adl_e2_count_pos          := (string)emerge_adl_e2_count_pos;
                    self.emerge_adl_count_e2              := (string)emerge_adl_count_e2;
                    self.emerge_adl_e3_count_pos          := (string)emerge_adl_e3_count_pos;
                    self.emerge_adl_count_e3              := (string)emerge_adl_count_e3;
                    self.emerge_adl_e4_count_pos          := (string)emerge_adl_e4_count_pos;
                    self.emerge_adl_count_e4              := (string)emerge_adl_count_e4;
                    self.iv_src_emerge_adl_count          := (string)iv_src_emerge_adl_count;
                    self.nf_bus_addr_match_count          := (string)nf_bus_addr_match_count;
                    self.iv_fname_non_phn_src_ct          := (string)iv_fname_non_phn_src_ct;
                    self.iv_full_name_non_phn_src_ct      := (string)iv_full_name_non_phn_src_ct;
                    self.iv_addr_non_phn_src_ct           := (string)iv_addr_non_phn_src_ct;
                    self.iv_ssn_non_phn_src_ct            := (string)iv_ssn_non_phn_src_ct;
                    self.iv_ssn_score                     := (string)iv_ssn_score;
                    self.iv_dob_src_ct                    := (string)iv_dob_src_ct;
                    self._reported_dob                    := (string)_reported_dob;
                    self.reported_age                     := (string)reported_age;
                    self._rc_ssnlowissue                  := (string)_rc_ssnlowissue;
                    self.iv_age_at_low_issue              := (string)iv_age_at_low_issue;
                    self._rc_ssnhighissue                 := (string)_rc_ssnhighissue;
                    self.iv_age_at_high_issue             := (string)iv_age_at_high_issue;
                    self.nf_util_adl_count                := (string)nf_util_adl_count;
                    self.iv_inp_addr_address_score        := (string)iv_inp_addr_address_score;
                    self.iv_inp_addr_lres                 := (string)iv_inp_addr_lres;
                    self.iv_inp_addr_assessed_total_val   := (string)iv_inp_addr_assessed_total_val;
                    self.iv_inp_addr_building_area        := (string)iv_inp_addr_building_area;
                    self.inp_addr_nhood_properties_sum    := (string)inp_addr_nhood_properties_sum;
                    self.inp_addr_nhood_vac_props         := (string)inp_addr_nhood_vac_props;
                    self.nf_inp_addr_nhood_pct_vacant     := (string)nf_inp_addr_nhood_pct_vacant;
                    self.iv_inp_addr_avm_pct_change_1yr   := (string)iv_inp_addr_avm_pct_change_1yr;
                    self.iv_inp_addr_avm_change_1yr       := (string)iv_inp_addr_avm_change_1yr;
                    self.iv_inp_addr_avm_pct_change_2yr   := (string)iv_inp_addr_avm_pct_change_2yr;
                    self.iv_inp_addr_avm_change_2yr       := (string)iv_inp_addr_avm_change_2yr;
                    self.bst_addr_avm_auto_val            := (string)bst_addr_avm_auto_val;
                    self.bst_addr_mortgage_amount         := (string)bst_addr_mortgage_amount;
                    self.iv_bst_addr_mtg_avm_abs_diff     := (string)iv_bst_addr_mtg_avm_abs_diff;
                    self.iv_bst_addr_assessed_total_val   := (string)iv_bst_addr_assessed_total_val;
                    self.bst_addr_date_first_seen         := (string)bst_addr_date_first_seen;
                    self.iv_mos_since_bst_addr_fseen      := (string)iv_mos_since_bst_addr_fseen;
                    self.bst_addr_nhood_properties_sum    := (string)bst_addr_nhood_properties_sum;
                    self.bst_addr_nhood_mfd_props         := (string)bst_addr_nhood_mfd_props;
                    self.nf_bst_addr_nhood_pct_mfd        := (string)nf_bst_addr_nhood_pct_mfd;
                    self.iv_bst_addr_avm_change_2yr       := (string)iv_bst_addr_avm_change_2yr;
                    self.bst_addr_avm_auto_val_3          := (string)bst_addr_avm_auto_val_3;
                    self.iv_bst_addr_avm_pct_change_2yr   := (string)iv_bst_addr_avm_pct_change_2yr;
                    self.bst_addr_avm_auto_val_4          := (string)bst_addr_avm_auto_val_4;
                    self.bst_addr_avm_auto_val_1          := (string)bst_addr_avm_auto_val_1;
                    self.iv_bst_addr_avm_change_3yr       := (string)iv_bst_addr_avm_change_3yr;
                    self.iv_prv_addr_lres                 := (string)iv_prv_addr_lres;
                    self.iv_prv_addr_avm_auto_val         := (string)iv_prv_addr_avm_auto_val;
                    self.iv_prv_addr_source_count         := (string)iv_prv_addr_source_count;
                    self.iv_prv_addr_assessed_total_val   := (string)iv_prv_addr_assessed_total_val;
                    self.prv_addr_date_first_seen         := (string)prv_addr_date_first_seen;
                    self.iv_mos_since_prv_addr_fseen      := (string)iv_mos_since_prv_addr_fseen;
                    self.prv_addr_date_last_seen          := (string)prv_addr_date_last_seen;
                    self.iv_mos_since_prv_addr_lseen      := (string)iv_mos_since_prv_addr_lseen;
                    self.iv_purch_sold_val_diff           := (string)iv_purch_sold_val_diff;
                    self.iv_prop2_purch_sale_diff         := (string)iv_prop2_purch_sale_diff;
                    self.iv_dist_bst_addr_to_prv_addr     := (string)iv_dist_bst_addr_to_prv_addr;
                    self.iv_dist_inp_addr_to_prv_addr     := (string)iv_dist_inp_addr_to_prv_addr;
                    self.iv_avg_lres                      := (string)iv_avg_lres;
                    self.iv_max_lres                      := (string)iv_max_lres;
                    self.iv_addr_lres_6mo_count           := (string)iv_addr_lres_6mo_count;
                    self.iv_addr_lres_12mo_count          := (string)iv_addr_lres_12mo_count;
                    self.iv_hist_addr_match               := (string)iv_hist_addr_match;
                    self.iv_avg_num_sources_per_addr      := (string)iv_avg_num_sources_per_addr;
                    self._gong_did_first_seen             := (string)_gong_did_first_seen;
                    self.iv_mos_since_gong_did_fst_seen   := (string)iv_mos_since_gong_did_fst_seen;
                    self.iv_gong_did_phone_ct             := (string)iv_gong_did_phone_ct;
                    self.iv_addrs_per_adl                 := (string)iv_addrs_per_adl;
                    self.iv_lnames_per_adl                := (string)iv_lnames_per_adl;
                    self.iv_adls_per_addr                 := (string)iv_adls_per_addr;
                    self.iv_adls_per_apt_addr             := (string)iv_adls_per_apt_addr;
                    self.iv_ssns_per_sfd_addr             := (string)iv_ssns_per_sfd_addr;
                    self.iv_phones_per_sfd_addr           := (string)iv_phones_per_sfd_addr;
                    self.iv_adls_per_addr_c6              := (string)iv_adls_per_addr_c6;
                    self.iv_adls_per_sfd_addr_c6          := (string)iv_adls_per_sfd_addr_c6;
                    self.iv_ssns_per_addr_c6              := (string)iv_ssns_per_addr_c6;
                    self.iv_ssns_per_sfd_addr_c6          := (string)iv_ssns_per_sfd_addr_c6;
                    self.iv_max_ids_per_sfd_addr_c6       := (string)iv_max_ids_per_sfd_addr_c6;
                    self.iv_dl_addrs_per_adl              := (string)iv_dl_addrs_per_adl;
                    self.iv_vo_addrs_per_adl              := (string)iv_vo_addrs_per_adl;
                    self.iv_invalid_addrs_per_adl         := (string)iv_invalid_addrs_per_adl;
                    self.iv_inq_recency                   := (string)iv_inq_recency;
                    self.iv_inq_collection_count12        := (string)iv_inq_collection_count12;
                    self.iv_inq_collection_recency        := (string)iv_inq_collection_recency;
                    self.iv_inq_auto_count12              := (string)iv_inq_auto_count12;
                    self.iv_inq_auto_recency              := (string)iv_inq_auto_recency;
                    self.iv_inq_banking_count12           := (string)iv_inq_banking_count12;
                    self.iv_inq_banking_recency           := (string)iv_inq_banking_recency;
                    self.iv_inq_highriskcredit_count12    := (string)iv_inq_highriskcredit_count12;
                    self.iv_inq_highriskcredit_recency    := (string)iv_inq_highriskcredit_recency;
                    self.iv_inq_communications_recency    := (string)iv_inq_communications_recency;
                    self.iv_inq_other_count12             := (string)iv_inq_other_count12;
                    self.iv_inq_other_recency             := (string)iv_inq_other_recency;
                    self.iv_inq_addrs_per_adl             := (string)iv_inq_addrs_per_adl;
                    self.iv_inq_num_diff_names_per_adl    := (string)iv_inq_num_diff_names_per_adl;
                    self.iv_inq_phones_per_adl            := (string)iv_inq_phones_per_adl;
                    self.iv_inq_per_addr                  := (string)iv_inq_per_addr;
                    self.iv_inq_adls_per_addr             := (string)iv_inq_adls_per_addr;
                    self.iv_inq_lnames_per_addr           := (string)iv_inq_lnames_per_addr;
                    self.iv_inq_ssns_per_addr             := (string)iv_inq_ssns_per_addr;
                    self.iv_inq_adls_per_phone            := (string)iv_inq_adls_per_phone;
                    self._infutor_first_seen              := (string)_infutor_first_seen;
                    self.iv_mos_since_infutor_first_seen  := (string)iv_mos_since_infutor_first_seen;
                    self._infutor_last_seen               := (string)_infutor_last_seen;
                    self.iv_mos_since_infutor_last_seen   := (string)iv_mos_since_infutor_last_seen;
                    self._impulse_first_seen              := (string)_impulse_first_seen;
                    self.iv_mos_since_impulse_first_seen  := (string)iv_mos_since_impulse_first_seen;
                    self._impulse_last_seen               := (string)_impulse_last_seen;
                    self.iv_mos_since_impulse_last_seen   := (string)iv_mos_since_impulse_last_seen;
                    self.iv_impulse_annual_income         := (string)iv_impulse_annual_income;
                    self.iv_email_count                   := (string)iv_email_count;
                    self.iv_all_email_domain_free         := (string)iv_all_email_domain_free;
                    self.iv_attr_purchase_recency         := (string)iv_attr_purchase_recency;
                    self.iv_attr_felonies_recency         := (string)iv_attr_felonies_recency;
                    self.iv_attr_arrests_recency          := (string)iv_attr_arrests_recency;
                    self.iv_attr_rel_liens_recency        := (string)iv_attr_rel_liens_recency;
                    self.iv_attr_bankruptcy_recency       := (string)iv_attr_bankruptcy_recency;
                    self.iv_eviction_count                := (string)iv_eviction_count;
                    self.iv_attr_proflic_recency          := (string)iv_attr_proflic_recency;
                    self.iv_non_derog_count               := (string)iv_non_derog_count;
                    self.iv_filing_count                  := (string)iv_filing_count;
                    self.iv_unreleased_liens_ct           := (string)iv_unreleased_liens_ct;
                    self.iv_liens_unrel_cj_ct             := (string)iv_liens_unrel_cj_ct;
                    self.iv_criminal_count                := (string)iv_criminal_count;
                    self.nf_rel_count                     := (string)nf_rel_count;
                    self.nf_average_rel_income            := (string)nf_average_rel_income;
                    self.nf_lowest_rel_income             := (string)nf_lowest_rel_income;
                    self.nf_highest_rel_income            := (string)nf_highest_rel_income;
                    self.nf_average_rel_home_val          := (string)nf_average_rel_home_val;
                    self.nf_oldest_rel_age                := (string)nf_oldest_rel_age;
                    self.nf_average_rel_criminal_dist     := (string)nf_average_rel_criminal_dist;
                    self.nf_average_rel_distance          := (string)nf_average_rel_distance;
                    self.nf_closest_rel_distance          := (string)nf_closest_rel_distance;
                    self.nf_rel_felony_count              := (string)nf_rel_felony_count;
                    self.nf_rel_derog_summary             := (string)nf_rel_derog_summary;
                    self.nf_accident_recency              := (string)nf_accident_recency;
                    self.iv_pb_average_dollars            := (string)iv_pb_average_dollars;
                    self.iv_pb_total_dollars              := (string)iv_pb_total_dollars;
                    self.nf_fp_varmsrcssncount            := (string)nf_fp_varmsrcssncount;
                    self.nf_fp_varmsrcssnunrelcount       := (string)nf_fp_varmsrcssnunrelcount;
                    self.nf_fp_srchcountwk                := (string)nf_fp_srchcountwk;
                    self.nf_fp_srchunvrfdaddrcount        := (string)nf_fp_srchunvrfdaddrcount;
                    self.nf_fp_srchunvrfddobcount         := (string)nf_fp_srchunvrfddobcount;
                    self.nf_fp_srchfraudsrchcount         := (string)nf_fp_srchfraudsrchcount;
                    self.nf_fp_srchfraudsrchcountyr       := (string)nf_fp_srchfraudsrchcountyr;
                    self.nf_fp_srchfraudsrchcountmo       := (string)nf_fp_srchfraudsrchcountmo;
                    self.nf_fp_srchfraudsrchcountwk       := (string)nf_fp_srchfraudsrchcountwk;
                    self.nf_fp_assocsuspicousidcount      := (string)nf_fp_assocsuspicousidcount;
                    self.nf_fp_assoccredbureaucount       := (string)nf_fp_assoccredbureaucount;
                    self.nf_fp_assoccredbureaucountnew    := (string)nf_fp_assoccredbureaucountnew;
                    self.nf_fp_corrssnnamecount           := (string)nf_fp_corrssnnamecount;
                    self.nf_fp_corrssnaddrcount           := (string)nf_fp_corrssnaddrcount;
                    self.nf_fp_corraddrnamecount          := (string)nf_fp_corraddrnamecount;
                    self.nf_fp_corraddrphonecount         := (string)nf_fp_corraddrphonecount;
                    self.nf_fp_corrphonelastnamecount     := (string)nf_fp_corrphonelastnamecount;
                    self.nf_fp_divaddrsuspidcountnew      := (string)nf_fp_divaddrsuspidcountnew;
                    self.nf_fp_divsrchaddrsuspidcount     := (string)nf_fp_divsrchaddrsuspidcount;
                    self.nf_fp_srchssnsrchcount           := (string)nf_fp_srchssnsrchcount;
                    self.nf_fp_srchssnsrchcountmo         := (string)nf_fp_srchssnsrchcountmo;
                    self.nf_fp_srchaddrsrchcount          := (string)nf_fp_srchaddrsrchcount;
                    self.nf_fp_srchaddrsrchcountmo        := (string)nf_fp_srchaddrsrchcountmo;
                    self.nf_fp_srchaddrsrchcountwk        := (string)nf_fp_srchaddrsrchcountwk;
                    self.nf_fp_srchphonesrchcount         := (string)nf_fp_srchphonesrchcount;
                    self.nf_fp_srchphonesrchcountmo       := (string)nf_fp_srchphonesrchcountmo;
                    self.nf_fp_addrchangeincomediff       := (string)nf_fp_addrchangeincomediff;
                    self.nf_fp_addrchangevaluediff        := (string)nf_fp_addrchangevaluediff;
                    self.nf_fp_curraddrmedianincome       := (string)nf_fp_curraddrmedianincome;
                    self.nf_fp_curraddrmedianvalue        := (string)nf_fp_curraddrmedianvalue;
                    self.nf_fp_curraddrmurderindex        := (string)nf_fp_curraddrmurderindex;
                    self.nf_fp_curraddrcartheftindex      := (string)nf_fp_curraddrcartheftindex;
                    self.nf_fp_curraddrcrimeindex         := (string)nf_fp_curraddrcrimeindex;
                    self.nf_fp_prevaddrageoldest          := (string)nf_fp_prevaddrageoldest;
                    self.nf_fp_prevaddrlenofres           := (string)nf_fp_prevaddrlenofres;
                    self.nf_fp_prevaddrmedianincome       := (string)nf_fp_prevaddrmedianincome;
                    self.nf_fp_prevaddrmedianvalue        := (string)nf_fp_prevaddrmedianvalue;
                    self.nf_fp_prevaddrcartheftindex      := (string)nf_fp_prevaddrcartheftindex;
                    self.nf_fp_prevaddrburglaryindex      := (string)nf_fp_prevaddrburglaryindex;
                    self.nf_fp_prevaddrcrimeindex         := (string)nf_fp_prevaddrcrimeindex;
                    self.fp_segment                       := (string)fp_segment;
                    self.iv_vs002_ssn_prior_dob           := (string)iv_vs002_ssn_prior_dob;
                    self.iv_vs100_ssn_problem             := (string)iv_vs100_ssn_problem;
                    self.iv_db001_bankruptcy              := (string)iv_db001_bankruptcy;
                    self.iv_nas_summary                   := (string)iv_nas_summary;
                    self.iv_cvi                           := (string)iv_cvi;
                    self.iv_best_match_address            := (string)iv_best_match_address;
                    self.iv_ag001_age                     := (string)iv_ag001_age;
                    self.iv_pl002_addrs_per_ssn_c6        := (string)iv_pl002_addrs_per_ssn_c6;
                    self.iv_combined_age                  := (string)iv_combined_age;
                    self.iv_avg_prop_sold_purch_amt       := (string)iv_avg_prop_sold_purch_amt;
                    self.iv_inq_per_ssn                   := (string)iv_inq_per_ssn;

                    // self.N0_2                             := N0_2;
                    // self.N0_3                             := N0_3;
                    // self.N0_4                             := N0_4;
                    // self.N0_5                             := N0_5;
                    // self.N1_2                             := N1_2;
                    // self.N1_3                             := N1_3;
                    // self.N1_4                             := N1_4;
                    // self.N1_5                             := N1_5;
                    // self.N1_6                             := N1_6;
                    // self.N2_2                             := N2_2;
                    // self.N2_3                             := N2_3;
                    // self.N2_4                             := N2_4;
                    // self.N2_5                             := N2_5;
                    // self.N2_6                             := N2_6;
                    // self.N3_2                             := N3_2;
                    // self.N3_3                             := N3_3;
                    // self.N3_4                             := N3_4;
                    // self.N3_5                             := N3_5;
                    // self.N4_2                             := N4_2;
                    // self.N4_3                             := N4_3;
                    // self.N4_4                             := N4_4;
                    // self.N4_5                             := N4_5;
                    // self.N5_2                             := N5_2;
                    // self.N5_3                             := N5_3;
                    // self.N5_4                             := N5_4;
                    // self.N5_5                             := N5_5;
                    // self.N5_6                             := N5_6;
                    // self.N5_7                             := N5_7;
                    // self.N6_2                             := N6_2;
                    // self.N6_3                             := N6_3;
                    // self.N6_4                             := N6_4;
                    // self.N6_5                             := N6_5;
                    // self.N6_6                             := N6_6;
                    // self.N6_7                             := N6_7;
                    // self.N7_2                             := N7_2;
                    // self.N7_3                             := N7_3;
                    // self.N7_4                             := N7_4;
                    // self.N7_5                             := N7_5;
                    // self.N8_2                             := N8_2;
                    // self.N8_3                             := N8_3;
                    // self.N8_4                             := N8_4;
                    // self.N8_5                             := N8_5;
                    // self.N8_6                             := N8_6;
                    // self.N8_7                             := N8_7;
                    // self.N8_8                             := N8_8;
                    // self.N9_2                             := N9_2;
                    // self.N9_3                             := N9_3;
                    // self.N9_4                             := N9_4;
                    // self.N9_5                             := N9_5;
                    // self.N9_6                             := N9_6;
                    // self.N10_2                            := N10_2;
                    // self.N10_3                            := N10_3;
                    // self.N10_4                            := N10_4;
                    // self.N10_5                            := N10_5;
                    // self.N11_2                            := N11_2;
                    // self.N11_3                            := N11_3;
                    // self.N11_4                            := N11_4;
                    // self.N11_5                            := N11_5;
                    // self.N11_6                            := N11_6;
                    // self.N11_7                            := N11_7;
                    // self.N12_2                            := N12_2;
                    // self.N12_3                            := N12_3;
                    // self.N12_4                            := N12_4;
                    // self.N12_5                            := N12_5;
                    // self.N12_6                            := N12_6;
                    // self.N12_7                            := N12_7;
                    // self.N13_2                            := N13_2;
                    // self.N13_3                            := N13_3;
                    // self.N13_4                            := N13_4;
                    // self.N13_5                            := N13_5;
                    // self.N13_6                            := N13_6;
                    // self.N13_7                            := N13_7;
                    // self.N14_2                            := N14_2;
                    // self.N14_3                            := N14_3;
                    // self.N14_4                            := N14_4;
                    // self.N14_5                            := N14_5;
                    // self.N14_6                            := N14_6;
                    // self.N14_7                            := N14_7;
                    // self.N14_8                            := N14_8;
                    // self.N15_2                            := N15_2;
                    // self.N15_3                            := N15_3;
                    // self.N15_4                            := N15_4;
                    // self.N15_5                            := N15_5;
                    // self.N15_6                            := N15_6;
                    // self.N15_7                            := N15_7;
                    // self.N16_2                            := N16_2;
                    // self.N16_3                            := N16_3;
                    // self.N16_4                            := N16_4;
                    // self.N16_5                            := N16_5;
                    // self.N16_6                            := N16_6;
                    // self.N17_2                            := N17_2;
                    // self.N17_3                            := N17_3;
                    // self.N17_4                            := N17_4;
                    // self.N17_5                            := N17_5;
                    // self.N18_2                            := N18_2;
                    // self.N18_3                            := N18_3;
                    // self.N18_4                            := N18_4;
                    // self.N18_5                            := N18_5;
                    // self.N18_6                            := N18_6;
                    // self.N19_2                            := N19_2;
                    // self.N19_3                            := N19_3;
                    // self.N19_4                            := N19_4;
                    // self.N19_5                            := N19_5;
                    // self.N19_6                            := N19_6;
                    // self.N19_7                            := N19_7;
                    // self.N20_2                            := N20_2;
                    // self.N20_3                            := N20_3;
                    // self.N20_4                            := N20_4;
                    // self.N20_5                            := N20_5;
                    // self.N20_6                            := N20_6;
                    // self.N20_7                            := N20_7;
                    // self.N21_2                            := N21_2;
                    // self.N21_3                            := N21_3;
                    // self.N21_4                            := N21_4;
                    // self.N21_5                            := N21_5;
                    // self.N21_6                            := N21_6;
                    // self.N21_7                            := N21_7;
                    // self.N22_2                            := N22_2;
                    // self.N22_3                            := N22_3;
                    // self.N22_4                            := N22_4;
                    // self.N22_5                            := N22_5;
                    // self.N22_6                            := N22_6;
                    // self.N23_2                            := N23_2;
                    // self.N23_3                            := N23_3;
                    // self.N23_4                            := N23_4;
                    // self.N23_5                            := N23_5;
                    // self.N23_6                            := N23_6;
                    // self.N23_7                            := N23_7;
                    // self.N24_2                            := N24_2;
                    // self.N24_3                            := N24_3;
                    // self.N24_4                            := N24_4;
                    // self.N24_5                            := N24_5;
                    // self.N24_6                            := N24_6;
                    // self.N24_7                            := N24_7;
                    // self.N25_2                            := N25_2;
                    // self.N25_3                            := N25_3;
                    // self.N25_4                            := N25_4;
                    // self.N25_5                            := N25_5;
                    // self.N25_6                            := N25_6;
                    // self.N25_7                            := N25_7;
                    // self.N26_2                            := N26_2;
                    // self.N26_3                            := N26_3;
                    // self.N26_4                            := N26_4;
                    // self.N26_5                            := N26_5;
                    // self.N26_6                            := N26_6;
                    // self.N26_7                            := N26_7;
                    // self.N27_2                            := N27_2;
                    // self.N27_3                            := N27_3;
                    // self.N27_4                            := N27_4;
                    // self.N27_5                            := N27_5;
                    // self.N27_6                            := N27_6;
                    // self.N28_2                            := N28_2;
                    // self.N28_3                            := N28_3;
                    // self.N28_4                            := N28_4;
                    // self.N28_5                            := N28_5;
                    // self.N28_6                            := N28_6;
                    // self.N28_7                            := N28_7;
                    // self.N28_8                            := N28_8;
                    // self.N29_2                            := N29_2;
                    // self.N29_3                            := N29_3;
                    // self.N29_4                            := N29_4;
                    // self.N29_5                            := N29_5;
                    // self.N29_6                            := N29_6;
                    // self.N29_7                            := N29_7;
                    // self.N29_8                            := N29_8;
                    // self.N29_9                            := N29_9;
                    // self.N30_2                            := N30_2;
                    // self.N30_3                            := N30_3;
                    // self.N30_4                            := N30_4;
                    // self.N30_5                            := N30_5;
                    // self.N30_6                            := N30_6;
                    // self.N31_2                            := N31_2;
                    // self.N31_3                            := N31_3;
                    // self.N31_4                            := N31_4;
                    // self.N31_5                            := N31_5;
                    // self.N31_6                            := N31_6;
                    // self.N31_7                            := N31_7;
                    // self.N32_2                            := N32_2;
                    // self.N32_3                            := N32_3;
                    // self.N32_4                            := N32_4;
                    // self.N32_5                            := N32_5;
                    // self.N32_6                            := N32_6;
                    // self.N33_2                            := N33_2;
                    // self.N33_3                            := N33_3;
                    // self.N33_4                            := N33_4;
                    // self.N33_5                            := N33_5;
                    // self.N33_6                            := N33_6;
                    // self.N33_7                            := N33_7;
                    // self.N34_2                            := N34_2;
                    // self.N34_3                            := N34_3;
                    // self.N34_4                            := N34_4;
                    // self.N34_5                            := N34_5;
                    // self.N34_6                            := N34_6;
                    // self.N35_2                            := N35_2;
                    // self.N35_3                            := N35_3;
                    // self.N35_4                            := N35_4;
                    // self.N35_5                            := N35_5;
                    // self.N35_6                            := N35_6;
                    // self.N36_2                            := N36_2;
                    // self.N36_3                            := N36_3;
                    // self.N36_4                            := N36_4;
                    // self.N36_5                            := N36_5;
                    // self.N36_6                            := N36_6;
                    // self.N36_7                            := N36_7;
                    // self.N37_2                            := N37_2;
                    // self.N37_3                            := N37_3;
                    // self.N37_4                            := N37_4;
                    // self.N37_5                            := N37_5;
                    // self.N37_6                            := N37_6;
                    // self.N37_7                            := N37_7;
                    // self.N37_8                            := N37_8;
                    // self.N38_2                            := N38_2;
                    // self.N38_3                            := N38_3;
                    // self.N38_4                            := N38_4;
                    // self.N38_5                            := N38_5;
                    // self.N38_6                            := N38_6;
                    // self.N38_7                            := N38_7;
                    // self.N39_2                            := N39_2;
                    // self.N39_3                            := N39_3;
                    // self.N39_4                            := N39_4;
                    // self.N39_5                            := N39_5;
                    // self.N39_6                            := N39_6;
                    // self.N39_7                            := N39_7;
                    // self.N40_2                            := N40_2;
                    // self.N40_3                            := N40_3;
                    // self.N40_4                            := N40_4;
                    // self.N40_5                            := N40_5;
                    // self.N40_6                            := N40_6;
                    // self.N40_7                            := N40_7;
                    // self.N41_2                            := N41_2;
                    // self.N41_3                            := N41_3;
                    // self.N41_4                            := N41_4;
                    // self.N41_5                            := N41_5;
                    // self.N41_6                            := N41_6;
                    // self.N42_2                            := N42_2;
                    // self.N42_3                            := N42_3;
                    // self.N42_4                            := N42_4;
                    // self.N42_5                            := N42_5;
                    // self.N42_6                            := N42_6;
                    // self.N42_7                            := N42_7;
                    // self.N43_2                            := N43_2;
                    // self.N43_3                            := N43_3;
                    // self.N43_4                            := N43_4;
                    // self.N43_5                            := N43_5;
                    // self.N43_6                            := N43_6;
                    // self.N43_7                            := N43_7;
                    // self.N43_8                            := N43_8;
                    // self.N44_2                            := N44_2;
                    // self.N44_3                            := N44_3;
                    // self.N44_4                            := N44_4;
                    // self.N44_5                            := N44_5;
                    // self.N44_6                            := N44_6;
                    // self.N45_2                            := N45_2;
                    // self.N45_3                            := N45_3;
                    // self.N45_4                            := N45_4;
                    // self.N45_5                            := N45_5;
                    // self.N45_6                            := N45_6;
                    // self.N45_7                            := N45_7;
                    // self.N46_2                            := N46_2;
                    // self.N46_3                            := N46_3;
                    // self.N46_4                            := N46_4;
                    // self.N46_5                            := N46_5;
                    // self.N46_6                            := N46_6;
                    // self.N46_7                            := N46_7;
                    // self.N47_2                            := N47_2;
                    // self.N47_3                            := N47_3;
                    // self.N47_4                            := N47_4;
                    // self.N47_5                            := N47_5;
                    // self.N47_6                            := N47_6;
                    // self.N48_2                            := N48_2;
                    // self.N48_3                            := N48_3;
                    // self.N48_4                            := N48_4;
                    // self.N48_5                            := N48_5;
                    // self.N48_6                            := N48_6;
                    // self.N48_7                            := N48_7;
                    // self.N49_2                            := N49_2;
                    // self.N49_3                            := N49_3;
                    // self.N49_4                            := N49_4;
                    // self.N49_5                            := N49_5;
                    // self.N50_2                            := N50_2;
                    // self.N50_3                            := N50_3;
                    // self.N50_4                            := N50_4;
                    // self.N50_5                            := N50_5;
                    // self.N50_6                            := N50_6;
                    // self.N51_2                            := N51_2;
                    // self.N51_3                            := N51_3;
                    // self.N51_4                            := N51_4;
                    // self.N51_5                            := N51_5;
                    // self.N51_6                            := N51_6;
                    // self.N52_2                            := N52_2;
                    // self.N52_3                            := N52_3;
                    // self.N52_4                            := N52_4;
                    // self.N52_5                            := N52_5;
                    // self.N52_6                            := N52_6;
                    // self.N52_7                            := N52_7;
                    // self.N52_8                            := N52_8;
                    // self.N52_9                            := N52_9;
                    // self.N53_2                            := N53_2;
                    // self.N53_3                            := N53_3;
                    // self.N53_4                            := N53_4;
                    // self.N53_5                            := N53_5;
                    // self.N53_6                            := N53_6;
                    // self.N53_7                            := N53_7;
                    // self.N53_8                            := N53_8;
                    // self.N54_2                            := N54_2;
                    // self.N54_3                            := N54_3;
                    // self.N54_4                            := N54_4;
                    // self.N54_5                            := N54_5;
                    // self.N54_6                            := N54_6;
                    // self.N54_7                            := N54_7;
                    // self.N54_8                            := N54_8;
                    // self.N54_9                            := N54_9;
                    // self.N55_2                            := N55_2;
                    // self.N55_3                            := N55_3;
                    // self.N55_4                            := N55_4;
                    // self.N55_5                            := N55_5;
                    // self.N55_6                            := N55_6;
                    // self.N55_7                            := N55_7;
                    // self.N56_2                            := N56_2;
                    // self.N56_3                            := N56_3;
                    // self.N56_4                            := N56_4;
                    // self.N56_5                            := N56_5;
                    // self.N56_6                            := N56_6;
                    // self.N56_7                            := N56_7;
                    // self.N57_2                            := N57_2;
                    // self.N57_3                            := N57_3;
                    // self.N57_4                            := N57_4;
                    // self.N57_5                            := N57_5;
                    // self.N57_6                            := N57_6;
                    // self.N57_7                            := N57_7;
                    // self.N58_2                            := N58_2;
                    // self.N58_3                            := N58_3;
                    // self.N58_4                            := N58_4;
                    // self.N58_5                            := N58_5;
                    // self.N58_6                            := N58_6;
                    // self.N59_2                            := N59_2;
                    // self.N59_3                            := N59_3;
                    // self.N59_4                            := N59_4;
                    // self.N59_5                            := N59_5;
                    // self.N59_6                            := N59_6;
                    // self.N59_7                            := N59_7;
                    // self.N59_8                            := N59_8;
                    // self.N60_2                            := N60_2;
                    // self.N60_3                            := N60_3;
                    // self.N60_4                            := N60_4;
                    // self.N60_5                            := N60_5;
                    // self.N60_6                            := N60_6;
                    // self.N60_7                            := N60_7;
                    // self.N60_8                            := N60_8;
                    // self.N61_2                            := N61_2;
                    // self.N61_3                            := N61_3;
                    // self.N61_4                            := N61_4;
                    // self.N61_5                            := N61_5;
                    // self.N61_6                            := N61_6;
                    // self.N61_7                            := N61_7;
                    // self.N61_8                            := N61_8;
                    // self.N62_2                            := N62_2;
                    // self.N62_3                            := N62_3;
                    // self.N62_4                            := N62_4;
                    // self.N62_5                            := N62_5;
                    // self.N62_6                            := N62_6;
                    // self.N63_2                            := N63_2;
                    // self.N63_3                            := N63_3;
                    // self.N63_4                            := N63_4;
                    // self.N63_5                            := N63_5;
                    // self.N63_6                            := N63_6;
                    // self.N63_7                            := N63_7;
                    // self.N63_8                            := N63_8;
                    // self.N64_2                            := N64_2;
                    // self.N64_3                            := N64_3;
                    // self.N64_4                            := N64_4;
                    // self.N64_5                            := N64_5;
                    // self.N64_6                            := N64_6;
                    // self.N64_7                            := N64_7;
                    // self.N65_2                            := N65_2;
                    // self.N65_3                            := N65_3;
                    // self.N65_4                            := N65_4;
                    // self.N65_5                            := N65_5;
                    // self.N65_6                            := N65_6;
                    // self.N65_7                            := N65_7;
                    // self.N66_2                            := N66_2;
                    // self.N66_3                            := N66_3;
                    // self.N66_4                            := N66_4;
                    // self.N66_5                            := N66_5;
                    // self.N66_6                            := N66_6;
                    // self.N66_7                            := N66_7;
                    // self.N67_2                            := N67_2;
                    // self.N67_3                            := N67_3;
                    // self.N67_4                            := N67_4;
                    // self.N67_5                            := N67_5;
                    // self.N67_6                            := N67_6;
                    // self.N67_7                            := N67_7;
                    // self.N67_8                            := N67_8;
                    // self.N68_2                            := N68_2;
                    // self.N68_3                            := N68_3;
                    // self.N68_4                            := N68_4;
                    // self.N68_5                            := N68_5;
                    // self.N68_6                            := N68_6;
                    // self.N68_7                            := N68_7;
                    // self.N68_8                            := N68_8;
                    // self.N69_2                            := N69_2;
                    // self.N69_3                            := N69_3;
                    // self.N69_4                            := N69_4;
                    // self.N69_5                            := N69_5;
                    // self.N69_6                            := N69_6;
                    // self.N69_7                            := N69_7;
                    // self.N70_2                            := N70_2;
                    // self.N70_3                            := N70_3;
                    // self.N70_4                            := N70_4;
                    // self.N70_5                            := N70_5;
                    // self.N70_6                            := N70_6;
                    // self.N70_7                            := N70_7;
                    // self.N70_8                            := N70_8;
                    // self.N71_2                            := N71_2;
                    // self.N71_3                            := N71_3;
                    // self.N71_4                            := N71_4;
                    // self.N71_5                            := N71_5;
                    // self.N71_6                            := N71_6;
                    // self.N71_7                            := N71_7;
                    // self.N72_2                            := N72_2;
                    // self.N72_3                            := N72_3;
                    // self.N72_4                            := N72_4;
                    // self.N72_5                            := N72_5;
                    // self.N72_6                            := N72_6;
                    // self.N73_2                            := N73_2;
                    // self.N73_3                            := N73_3;
                    // self.N73_4                            := N73_4;
                    // self.N73_5                            := N73_5;
                    // self.N73_6                            := N73_6;
                    // self.N73_7                            := N73_7;
                    // self.N73_8                            := N73_8;
                    // self.N74_2                            := N74_2;
                    // self.N74_3                            := N74_3;
                    // self.N74_4                            := N74_4;
                    // self.N74_5                            := N74_5;
                    // self.N74_6                            := N74_6;
                    // self.N75_2                            := N75_2;
                    // self.N75_3                            := N75_3;
                    // self.N75_4                            := N75_4;
                    // self.N75_5                            := N75_5;
                    // self.N75_6                            := N75_6;
                    // self.N75_7                            := N75_7;
                    // self.N76_2                            := N76_2;
                    // self.N76_3                            := N76_3;
                    // self.N76_4                            := N76_4;
                    // self.N76_5                            := N76_5;
                    // self.N76_6                            := N76_6;
                    // self.N76_7                            := N76_7;
                    // self.N77_2                            := N77_2;
                    // self.N77_3                            := N77_3;
                    // self.N77_4                            := N77_4;
                    // self.N77_5                            := N77_5;
                    // self.N77_6                            := N77_6;
                    // self.N77_7                            := N77_7;
                    // self.N77_8                            := N77_8;
                    // self.N78_2                            := N78_2;
                    // self.N78_3                            := N78_3;
                    // self.N78_4                            := N78_4;
                    // self.N78_5                            := N78_5;
                    // self.N78_6                            := N78_6;
                    // self.N78_7                            := N78_7;
                    // self.N78_8                            := N78_8;
                    // self.N79_2                            := N79_2;
                    // self.N79_3                            := N79_3;
                    // self.N79_4                            := N79_4;
                    // self.N79_5                            := N79_5;
                    // self.N79_6                            := N79_6;
                    // self.N79_7                            := N79_7;
                    // self.N79_8                            := N79_8;
                    // self.N80_2                            := N80_2;
                    // self.N80_3                            := N80_3;
                    // self.N80_4                            := N80_4;
                    // self.N80_5                            := N80_5;
                    // self.N80_6                            := N80_6;
                    // self.N80_7                            := N80_7;
                    // self.N80_8                            := N80_8;
                    // self.N81_2                            := N81_2;
                    // self.N81_3                            := N81_3;
                    // self.N81_4                            := N81_4;
                    // self.N81_5                            := N81_5;
                    // self.N81_6                            := N81_6;
                    // self.N81_7                            := N81_7;
                    // self.N81_8                            := N81_8;
                    // self.N82_2                            := N82_2;
                    // self.N82_3                            := N82_3;
                    // self.N82_4                            := N82_4;
                    // self.N82_5                            := N82_5;
                    // self.N82_6                            := N82_6;
                    // self.N83_2                            := N83_2;
                    // self.N83_3                            := N83_3;
                    // self.N83_4                            := N83_4;
                    // self.N83_5                            := N83_5;
                    // self.N83_6                            := N83_6;
                    // self.N84_2                            := N84_2;
                    // self.N84_3                            := N84_3;
                    // self.N84_4                            := N84_4;
                    // self.N84_5                            := N84_5;
                    // self.N84_6                            := N84_6;
                    // self.N84_7                            := N84_7;
                    // self.N84_8                            := N84_8;
                    // self.N84_9                            := N84_9;
                    // self.N85_2                            := N85_2;
                    // self.N85_3                            := N85_3;
                    // self.N85_4                            := N85_4;
                    // self.N85_5                            := N85_5;
                    // self.N85_6                            := N85_6;
                    // self.N85_7                            := N85_7;
                    // self.N85_8                            := N85_8;
                    // self.N86_2                            := N86_2;
                    // self.N86_3                            := N86_3;
                    // self.N86_4                            := N86_4;
                    // self.N86_5                            := N86_5;
                    // self.N86_6                            := N86_6;
                    // self.N86_7                            := N86_7;
                    // self.N86_8                            := N86_8;
                    // self.N86_9                            := N86_9;
                    // self.N87_2                            := N87_2;
                    // self.N87_3                            := N87_3;
                    // self.N87_4                            := N87_4;
                    // self.N87_5                            := N87_5;
                    // self.N87_6                            := N87_6;
                    // self.N87_7                            := N87_7;
                    // self.N87_8                            := N87_8;
                    // self.N88_2                            := N88_2;
                    // self.N88_3                            := N88_3;
                    // self.N88_4                            := N88_4;
                    // self.N88_5                            := N88_5;
                    // self.N88_6                            := N88_6;
                    // self.N88_7                            := N88_7;
                    // self.N88_8                            := N88_8;
                    // self.N88_9                            := N88_9;
                    // self.N89_2                            := N89_2;
                    // self.N89_3                            := N89_3;
                    // self.N89_4                            := N89_4;
                    // self.N89_5                            := N89_5;
                    // self.N90_2                            := N90_2;
                    // self.N90_3                            := N90_3;
                    // self.N90_4                            := N90_4;
                    // self.N90_5                            := N90_5;
                    // self.N90_6                            := N90_6;
                    // self.N90_7                            := N90_7;
                    // self.N90_8                            := N90_8;
                    // self.N91_2                            := N91_2;
                    // self.N91_3                            := N91_3;
                    // self.N91_4                            := N91_4;
                    // self.N91_5                            := N91_5;
                    // self.N91_6                            := N91_6;
                    // self.N91_7                            := N91_7;
                    // self.N92_2                            := N92_2;
                    // self.N92_3                            := N92_3;
                    // self.N92_4                            := N92_4;
                    // self.N92_5                            := N92_5;
                    // self.N92_6                            := N92_6;
                    // self.N92_7                            := N92_7;
                    // self.N92_8                            := N92_8;
                    // self.N92_9                            := N92_9;
                    // self.N93_2                            := N93_2;
                    // self.N93_3                            := N93_3;
                    // self.N93_4                            := N93_4;
                    // self.N93_5                            := N93_5;
                    // self.N93_6                            := N93_6;
                    // self.N94_2                            := N94_2;
                    // self.N94_3                            := N94_3;
                    // self.N94_4                            := N94_4;
                    // self.N94_5                            := N94_5;
                    // self.N94_6                            := N94_6;
                    // self.N94_7                            := N94_7;
                    // self.N94_8                            := N94_8;
                    // self.N95_2                            := N95_2;
                    // self.N95_3                            := N95_3;
                    // self.N95_4                            := N95_4;
                    // self.N95_5                            := N95_5;
                    // self.N95_6                            := N95_6;
                    // self.N95_7                            := N95_7;
                    // self.N95_8                            := N95_8;
                    // self.N96_2                            := N96_2;
                    // self.N96_3                            := N96_3;
                    // self.N96_4                            := N96_4;
                    // self.N96_5                            := N96_5;
                    // self.N96_6                            := N96_6;
                    // self.N96_7                            := N96_7;
                    // self.N96_8                            := N96_8;
                    // self.N96_9                            := N96_9;
                    // self.N97_2                            := N97_2;
                    // self.N97_3                            := N97_3;
                    // self.N97_4                            := N97_4;
                    // self.N97_5                            := N97_5;
                    // self.N97_6                            := N97_6;
                    // self.N97_7                            := N97_7;
                    // self.N97_8                            := N97_8;
                    // self.N97_9                            := N97_9;
                    // self.N97_10                           := N97_10;
                    // self.N98_2                            := N98_2;
                    // self.N98_3                            := N98_3;
                    // self.N98_4                            := N98_4;
                    // self.N98_5                            := N98_5;
                    // self.N98_6                            := N98_6;
                    // self.N98_7                            := N98_7;
                    // self.N98_8                            := N98_8;
                    // self.N98_9                            := N98_9;
                    // self.N99_2                            := N99_2;
                    // self.N99_3                            := N99_3;
                    // self.N99_4                            := N99_4;
                    // self.N99_5                            := N99_5;
                    // self.N99_6                            := N99_6;
                    // self.N99_7                            := N99_7;
                    // self.N100_2                           := N100_2;
                    // self.N100_3                           := N100_3;
                    // self.N100_4                           := N100_4;
                    // self.N100_5                           := N100_5;
                    // self.N100_6                           := N100_6;
                    // self.N100_7                           := N100_7;
                    // self.N100_8                           := N100_8;
                    // self.N101_2                           := N101_2;
                    // self.N101_3                           := N101_3;
                    // self.N101_4                           := N101_4;
                    // self.N101_5                           := N101_5;
                    // self.N101_6                           := N101_6;
                    // self.N101_7                           := N101_7;
                    // self.N101_8                           := N101_8;
                    // self.N102_2                           := N102_2;
                    // self.N102_3                           := N102_3;
                    // self.N102_4                           := N102_4;
                    // self.N102_5                           := N102_5;
                    // self.N102_6                           := N102_6;
                    // self.N102_7                           := N102_7;
                    // self.N103_2                           := N103_2;
                    // self.N103_3                           := N103_3;
                    // self.N103_4                           := N103_4;
                    // self.N103_5                           := N103_5;
                    // self.N103_6                           := N103_6;
                    // self.N103_7                           := N103_7;
                    // self.N103_8                           := N103_8;
                    // self.N103_9                           := N103_9;
                    // self.N104_2                           := N104_2;
                    // self.N104_3                           := N104_3;
                    // self.N104_4                           := N104_4;
                    // self.N104_5                           := N104_5;
                    // self.N104_6                           := N104_6;
                    // self.N104_7                           := N104_7;
                    // self.N104_8                           := N104_8;
                    // self.N104_9                           := N104_9;
                    // self.N105_2                           := N105_2;
                    // self.N105_3                           := N105_3;
                    // self.N105_4                           := N105_4;
                    // self.N105_5                           := N105_5;
                    // self.N105_6                           := N105_6;
                    // self.N106_2                           := N106_2;
                    // self.N106_3                           := N106_3;
                    // self.N106_4                           := N106_4;
                    // self.N106_5                           := N106_5;
                    // self.N106_6                           := N106_6;
                    // self.N107_2                           := N107_2;
                    // self.N107_3                           := N107_3;
                    // self.N107_4                           := N107_4;
                    // self.N107_5                           := N107_5;
                    // self.N107_6                           := N107_6;
                    // self.N108_2                           := N108_2;
                    // self.N108_3                           := N108_3;
                    // self.N108_4                           := N108_4;
                    // self.N108_5                           := N108_5;
                    // self.N108_6                           := N108_6;
                    // self.N108_7                           := N108_7;
                    // self.N109_2                           := N109_2;
                    // self.N109_3                           := N109_3;
                    // self.N109_4                           := N109_4;
                    // self.N109_5                           := N109_5;
                    // self.N109_6                           := N109_6;
                    // self.N109_7                           := N109_7;
                    // self.N109_8                           := N109_8;
                    // self.N110_2                           := N110_2;
                    // self.N110_3                           := N110_3;
                    // self.N110_4                           := N110_4;
                    // self.N110_5                           := N110_5;
                    // self.N110_6                           := N110_6;
                    // self.N110_7                           := N110_7;
                    // self.N110_8                           := N110_8;
                    // self.N111_2                           := N111_2;
                    // self.N111_3                           := N111_3;
                    // self.N111_4                           := N111_4;
                    // self.N111_5                           := N111_5;
                    // self.N111_6                           := N111_6;
                    // self.N111_7                           := N111_7;
                    // self.N111_8                           := N111_8;
                    // self.N112_2                           := N112_2;
                    // self.N112_3                           := N112_3;
                    // self.N112_4                           := N112_4;
                    // self.N112_5                           := N112_5;
                    // self.N112_6                           := N112_6;
                    // self.N112_7                           := N112_7;
                    // self.N112_8                           := N112_8;
                    // self.N113_2                           := N113_2;
                    // self.N113_3                           := N113_3;
                    // self.N113_4                           := N113_4;
                    // self.N113_5                           := N113_5;
                    // self.N113_6                           := N113_6;
                    // self.N113_7                           := N113_7;
                    // self.N113_8                           := N113_8;
                    // self.N114_2                           := N114_2;
                    // self.N114_3                           := N114_3;
                    // self.N114_4                           := N114_4;
                    // self.N114_5                           := N114_5;
                    // self.N114_6                           := N114_6;
                    // self.N114_7                           := N114_7;
                    // self.N115_2                           := N115_2;
                    // self.N115_3                           := N115_3;
                    // self.N115_4                           := N115_4;
                    // self.N115_5                           := N115_5;
                    // self.N115_6                           := N115_6;
                    // self.N115_7                           := N115_7;
                    // self.N115_8                           := N115_8;
                    // self.N116_2                           := N116_2;
                    // self.N116_3                           := N116_3;
                    // self.N116_4                           := N116_4;
                    // self.N116_5                           := N116_5;
                    // self.N116_6                           := N116_6;
                    // self.N116_7                           := N116_7;
                    // self.N117_2                           := N117_2;
                    // self.N117_3                           := N117_3;
                    // self.N117_4                           := N117_4;
                    // self.N117_5                           := N117_5;
                    // self.N117_6                           := N117_6;
                    // self.N117_7                           := N117_7;
                    // self.N117_8                           := N117_8;
                    // self.N118_2                           := N118_2;
                    // self.N118_3                           := N118_3;
                    // self.N118_4                           := N118_4;
                    // self.N118_5                           := N118_5;
                    // self.N118_6                           := N118_6;
                    // self.N118_7                           := N118_7;
                    // self.N118_8                           := N118_8;
                    // self.N119_2                           := N119_2;
                    // self.N119_3                           := N119_3;
                    // self.N119_4                           := N119_4;
                    // self.N119_5                           := N119_5;
                    // self.N119_6                           := N119_6;
                    // self.N120_2                           := N120_2;
                    // self.N120_3                           := N120_3;
                    // self.N120_4                           := N120_4;
                    // self.N120_5                           := N120_5;
                    // self.N120_6                           := N120_6;
                    // self.N121_2                           := N121_2;
                    // self.N121_3                           := N121_3;
                    // self.N121_4                           := N121_4;
                    // self.N121_5                           := N121_5;
                    // self.N121_6                           := N121_6;
                    // self.N121_7                           := N121_7;
                    // self.N122_2                           := N122_2;
                    // self.N122_3                           := N122_3;
                    // self.N122_4                           := N122_4;
                    // self.N122_5                           := N122_5;
                    // self.N122_6                           := N122_6;
                    // self.N122_7                           := N122_7;
                    // self.N122_8                           := N122_8;
                    // self.N122_9                           := N122_9;
                    // self.N123_2                           := N123_2;
                    // self.N123_3                           := N123_3;
                    // self.N123_4                           := N123_4;
                    // self.N123_5                           := N123_5;
                    // self.N123_6                           := N123_6;
                    // self.N123_7                           := N123_7;
                    // self.N124_2                           := N124_2;
                    // self.N124_3                           := N124_3;
                    // self.N124_4                           := N124_4;
                    // self.N124_5                           := N124_5;
                    // self.N124_6                           := N124_6;
                    // self.N124_7                           := N124_7;
                    // self.N124_8                           := N124_8;
                    // self.N125_2                           := N125_2;
                    // self.N125_3                           := N125_3;
                    // self.N125_4                           := N125_4;
                    // self.N125_5                           := N125_5;
                    // self.N125_6                           := N125_6;
                    // self.N126_2                           := N126_2;
                    // self.N126_3                           := N126_3;
                    // self.N126_4                           := N126_4;
                    // self.N126_5                           := N126_5;
                    // self.N126_6                           := N126_6;
                    // self.N126_7                           := N126_7;
                    // self.N126_8                           := N126_8;
                    // self.N127_2                           := N127_2;
                    // self.N127_3                           := N127_3;
                    // self.N127_4                           := N127_4;
                    // self.N127_5                           := N127_5;
                    // self.N127_6                           := N127_6;
                    // self.N127_7                           := N127_7;
                    // self.N127_8                           := N127_8;
                    // self.N128_2                           := N128_2;
                    // self.N128_3                           := N128_3;
                    // self.N128_4                           := N128_4;
                    // self.N128_5                           := N128_5;
                    // self.N128_6                           := N128_6;
                    // self.N128_7                           := N128_7;
                    // self.N129_2                           := N129_2;
                    // self.N129_3                           := N129_3;
                    // self.N129_4                           := N129_4;
                    // self.N129_5                           := N129_5;
                    // self.N129_6                           := N129_6;
                    // self.N130_2                           := N130_2;
                    // self.N130_3                           := N130_3;
                    // self.N130_4                           := N130_4;
                    // self.N130_5                           := N130_5;
                    // self.N130_6                           := N130_6;
                    // self.N130_7                           := N130_7;
                    // self.N130_8                           := N130_8;
                    // self.N131_2                           := N131_2;
                    // self.N131_3                           := N131_3;
                    // self.N131_4                           := N131_4;
                    // self.N131_5                           := N131_5;
                    // self.N131_6                           := N131_6;
                    // self.N131_7                           := N131_7;
                    // self.N131_8                           := N131_8;
                    // self.N132_2                           := N132_2;
                    // self.N132_3                           := N132_3;
                    // self.N132_4                           := N132_4;
                    // self.N132_5                           := N132_5;
                    // self.N132_6                           := N132_6;
                    // self.N132_7                           := N132_7;
                    // self.N132_8                           := N132_8;
                    // self.N133_2                           := N133_2;
                    // self.N133_3                           := N133_3;
                    // self.N133_4                           := N133_4;
                    // self.N133_5                           := N133_5;
                    // self.N133_6                           := N133_6;
                    // self.N133_7                           := N133_7;
                    // self.N133_8                           := N133_8;
                    // self.N133_9                           := N133_9;
                    // self.N133_10                          := N133_10;
                    // self.N134_2                           := N134_2;
                    // self.N134_3                           := N134_3;
                    // self.N134_4                           := N134_4;
                    // self.N134_5                           := N134_5;
                    // self.N134_6                           := N134_6;
                    // self.N134_7                           := N134_7;
                    // self.N134_8                           := N134_8;
                    // self.N135_2                           := N135_2;
                    // self.N135_3                           := N135_3;
                    // self.N135_4                           := N135_4;
                    // self.N135_5                           := N135_5;
                    // self.N135_6                           := N135_6;
                    // self.N135_7                           := N135_7;
                    // self.N135_8                           := N135_8;
                    // self.N135_9                           := N135_9;
                    // self.N136_2                           := N136_2;
                    // self.N136_3                           := N136_3;
                    // self.N136_4                           := N136_4;
                    // self.N136_5                           := N136_5;
                    // self.N136_6                           := N136_6;
                    // self.N136_7                           := N136_7;
                    // self.N136_8                           := N136_8;
                    // self.N137_2                           := N137_2;
                    // self.N137_3                           := N137_3;
                    // self.N137_4                           := N137_4;
                    // self.N137_5                           := N137_5;
                    // self.N137_6                           := N137_6;
                    // self.N137_7                           := N137_7;
                    // self.N138_2                           := N138_2;
                    // self.N138_3                           := N138_3;
                    // self.N138_4                           := N138_4;
                    // self.N138_5                           := N138_5;
                    // self.N138_6                           := N138_6;
                    // self.N138_7                           := N138_7;
                    // self.N138_8                           := N138_8;
                    // self.N139_2                           := N139_2;
                    // self.N139_3                           := N139_3;
                    // self.N139_4                           := N139_4;
                    // self.N139_5                           := N139_5;
                    // self.N139_6                           := N139_6;
                    // self.N139_7                           := N139_7;
                    // self.N139_8                           := N139_8;
                    // self.N140_2                           := N140_2;
                    // self.N140_3                           := N140_3;
                    // self.N140_4                           := N140_4;
                    // self.N140_5                           := N140_5;
                    // self.N140_6                           := N140_6;
                    // self.N140_7                           := N140_7;
                    // self.N140_8                           := N140_8;
                    // self.N140_9                           := N140_9;
                    // self.N141_2                           := N141_2;
                    // self.N141_3                           := N141_3;
                    // self.N141_4                           := N141_4;
                    // self.N141_5                           := N141_5;
                    // self.N141_6                           := N141_6;
                    // self.N141_7                           := N141_7;
                    // self.N141_8                           := N141_8;
                    // self.N142_2                           := N142_2;
                    // self.N142_3                           := N142_3;
                    // self.N142_4                           := N142_4;
                    // self.N142_5                           := N142_5;
                    // self.N142_6                           := N142_6;
                    // self.N142_7                           := N142_7;
                    // self.N142_8                           := N142_8;
                    // self.N143_2                           := N143_2;
                    // self.N143_3                           := N143_3;
                    // self.N143_4                           := N143_4;
                    // self.N143_5                           := N143_5;
                    // self.N143_6                           := N143_6;
                    // self.N143_7                           := N143_7;
                    // self.N144_2                           := N144_2;
                    // self.N144_3                           := N144_3;
                    // self.N144_4                           := N144_4;
                    // self.N144_5                           := N144_5;
                    // self.N144_6                           := N144_6;
                    // self.N144_7                           := N144_7;
                    // self.N144_8                           := N144_8;
                    // self.N145_2                           := N145_2;
                    // self.N145_3                           := N145_3;
                    // self.N145_4                           := N145_4;
                    // self.N145_5                           := N145_5;
                    // self.N145_6                           := N145_6;
                    // self.N146_2                           := N146_2;
                    // self.N146_3                           := N146_3;
                    // self.N146_4                           := N146_4;
                    // self.N146_5                           := N146_5;
                    // self.N146_6                           := N146_6;
                    // self.N146_7                           := N146_7;
                    // self.N146_8                           := N146_8;
                    // self.N147_2                           := N147_2;
                    // self.N147_3                           := N147_3;
                    // self.N147_4                           := N147_4;
                    // self.N147_5                           := N147_5;
                    // self.N147_6                           := N147_6;
                    // self.N147_7                           := N147_7;
                    // self.N147_8                           := N147_8;
                    // self.N148_2                           := N148_2;
                    // self.N148_3                           := N148_3;
                    // self.N148_4                           := N148_4;
                    // self.N148_5                           := N148_5;
                    // self.N148_6                           := N148_6;
                    // self.N148_7                           := N148_7;
                    // self.N148_8                           := N148_8;
                    // self.N148_9                           := N148_9;
                    // self.N149_2                           := N149_2;
                    // self.N149_3                           := N149_3;
                    // self.N149_4                           := N149_4;
                    // self.N149_5                           := N149_5;
                    // self.N149_6                           := N149_6;
                    // self.N149_7                           := N149_7;
                    // self.N150_2                           := N150_2;
                    // self.N150_3                           := N150_3;
                    // self.N150_4                           := N150_4;
                    // self.N150_5                           := N150_5;
                    // self.N150_6                           := N150_6;
                    // self.N151_2                           := N151_2;
                    // self.N151_3                           := N151_3;
                    // self.N151_4                           := N151_4;
                    // self.N151_5                           := N151_5;
                    // self.N151_6                           := N151_6;
                    // self.N152_2                           := N152_2;
                    // self.N152_3                           := N152_3;
                    // self.N152_4                           := N152_4;
                    // self.N152_5                           := N152_5;
                    // self.N152_6                           := N152_6;
                    // self.N152_7                           := N152_7;
                    // self.N152_8                           := N152_8;
                    // self.N153_2                           := N153_2;
                    // self.N153_3                           := N153_3;
                    // self.N153_4                           := N153_4;
                    // self.N153_5                           := N153_5;
                    // self.N153_6                           := N153_6;
                    // self.N153_7                           := N153_7;
                    // self.N153_8                           := N153_8;
                    // self.N154_2                           := N154_2;
                    // self.N154_3                           := N154_3;
                    // self.N154_4                           := N154_4;
                    // self.N154_5                           := N154_5;
                    // self.N154_6                           := N154_6;
                    // self.N154_7                           := N154_7;
                    // self.N154_8                           := N154_8;
                    // self.N155_2                           := N155_2;
                    // self.N155_3                           := N155_3;
                    // self.N155_4                           := N155_4;
                    // self.N155_5                           := N155_5;
                    // self.N155_6                           := N155_6;
                    // self.N156_2                           := N156_2;
                    // self.N156_3                           := N156_3;
                    // self.N156_4                           := N156_4;
                    // self.N156_5                           := N156_5;
                    // self.N156_6                           := N156_6;
                    // self.N157_2                           := N157_2;
                    // self.N157_3                           := N157_3;
                    // self.N157_4                           := N157_4;
                    // self.N157_5                           := N157_5;
                    // self.N157_6                           := N157_6;
                    // self.N158_2                           := N158_2;
                    // self.N158_3                           := N158_3;
                    // self.N158_4                           := N158_4;
                    // self.N158_5                           := N158_5;
                    // self.N158_6                           := N158_6;
                    // self.N158_7                           := N158_7;
                    // self.N158_8                           := N158_8;
                    // self.N159_2                           := N159_2;
                    // self.N159_3                           := N159_3;
                    // self.N159_4                           := N159_4;
                    // self.N159_5                           := N159_5;
                    // self.N159_6                           := N159_6;
                    // self.N159_7                           := N159_7;
                    // self.N159_8                           := N159_8;
                    // self.N159_9                           := N159_9;
                    // self.N160_2                           := N160_2;
                    // self.N160_3                           := N160_3;
                    // self.N160_4                           := N160_4;
                    // self.N160_5                           := N160_5;
                    // self.N160_6                           := N160_6;
                    // self.N160_7                           := N160_7;
                    // self.N161_2                           := N161_2;
                    // self.N161_3                           := N161_3;
                    // self.N161_4                           := N161_4;
                    // self.N161_5                           := N161_5;
                    // self.N161_6                           := N161_6;
                    // self.N162_2                           := N162_2;
                    // self.N162_3                           := N162_3;
                    // self.N162_4                           := N162_4;
                    // self.N162_5                           := N162_5;
                    // self.N162_6                           := N162_6;
                    // self.N162_7                           := N162_7;
                    // self.N162_8                           := N162_8;
                    // self.N163_2                           := N163_2;
                    // self.N163_3                           := N163_3;
                    // self.N163_4                           := N163_4;
                    // self.N163_5                           := N163_5;
                    // self.N163_6                           := N163_6;
                    // self.N163_7                           := N163_7;
                    // self.N163_8                           := N163_8;
                    // self.N164_2                           := N164_2;
                    // self.N164_3                           := N164_3;
                    // self.N164_4                           := N164_4;
                    // self.N164_5                           := N164_5;
                    // self.N164_6                           := N164_6;
                    // self.N164_7                           := N164_7;
                    // self.N164_8                           := N164_8;
                    // self.N165_2                           := N165_2;
                    // self.N165_3                           := N165_3;
                    // self.N165_4                           := N165_4;
                    // self.N165_5                           := N165_5;
                    // self.N165_6                           := N165_6;
                    // self.N165_7                           := N165_7;
                    // self.N165_8                           := N165_8;
                    // self.N166_2                           := N166_2;
                    // self.N166_3                           := N166_3;
                    // self.N166_4                           := N166_4;
                    // self.N166_5                           := N166_5;
                    // self.N166_6                           := N166_6;
                    // self.N166_7                           := N166_7;
                    // self.N166_8                           := N166_8;
                    // self.N167_2                           := N167_2;
                    // self.N167_3                           := N167_3;
                    // self.N167_4                           := N167_4;
                    // self.N167_5                           := N167_5;
                    // self.N167_6                           := N167_6;
                    // self.N167_7                           := N167_7;
                    // self.N168_2                           := N168_2;
                    // self.N168_3                           := N168_3;
                    // self.N168_4                           := N168_4;
                    // self.N168_5                           := N168_5;
                    // self.N168_6                           := N168_6;
                    // self.N168_7                           := N168_7;
                    // self.N168_8                           := N168_8;
                    // self.N168_9                           := N168_9;
                    // self.N169_2                           := N169_2;
                    // self.N169_3                           := N169_3;
                    // self.N169_4                           := N169_4;
                    // self.N169_5                           := N169_5;
                    // self.N169_6                           := N169_6;
                    // self.N169_7                           := N169_7;
                    // self.N169_8                           := N169_8;
                    // self.N170_2                           := N170_2;
                    // self.N170_3                           := N170_3;
                    // self.N170_4                           := N170_4;
                    // self.N170_5                           := N170_5;
                    // self.N170_6                           := N170_6;
                    // self.N170_7                           := N170_7;
                    // self.N171_2                           := N171_2;
                    // self.N171_3                           := N171_3;
                    // self.N171_4                           := N171_4;
                    // self.N171_5                           := N171_5;
                    // self.N171_6                           := N171_6;
                    // self.N171_7                           := N171_7;
                    // self.N171_8                           := N171_8;
                    // self.N172_2                           := N172_2;
                    // self.N172_3                           := N172_3;
                    // self.N172_4                           := N172_4;
                    // self.N172_5                           := N172_5;
                    // self.N172_6                           := N172_6;
                    // self.N172_7                           := N172_7;
                    // self.N172_8                           := N172_8;
                    // self.N173_2                           := N173_2;
                    // self.N173_3                           := N173_3;
                    // self.N173_4                           := N173_4;
                    // self.N173_5                           := N173_5;
                    // self.N173_6                           := N173_6;
                    // self.N173_7                           := N173_7;
                    // self.N174_2                           := N174_2;
                    // self.N174_3                           := N174_3;
                    // self.N174_4                           := N174_4;
                    // self.N174_5                           := N174_5;
                    // self.N174_6                           := N174_6;
                    // self.N174_7                           := N174_7;
                    // self.N174_8                           := N174_8;
                    // self.N175_2                           := N175_2;
                    // self.N175_3                           := N175_3;
                    // self.N175_4                           := N175_4;
                    // self.N175_5                           := N175_5;
                    // self.N175_6                           := N175_6;
                    // self.N175_7                           := N175_7;
                    // self.N175_8                           := N175_8;
                    // self.N176_2                           := N176_2;
                    // self.N176_3                           := N176_3;
                    // self.N176_4                           := N176_4;
                    // self.N176_5                           := N176_5;
                    // self.N176_6                           := N176_6;
                    // self.N176_7                           := N176_7;
                    // self.N176_8                           := N176_8;
                    // self.N177_2                           := N177_2;
                    // self.N177_3                           := N177_3;
                    // self.N177_4                           := N177_4;
                    // self.N177_5                           := N177_5;
                    // self.N177_6                           := N177_6;
                    // self.N177_7                           := N177_7;
                    // self.N177_8                           := N177_8;
                    // self.N177_9                           := N177_9;
                    // self.N178_2                           := N178_2;
                    // self.N178_3                           := N178_3;
                    // self.N178_4                           := N178_4;
                    // self.N178_5                           := N178_5;
                    // self.N178_6                           := N178_6;
                    // self.N178_7                           := N178_7;
                    // self.N178_8                           := N178_8;
                    // self.N179_2                           := N179_2;
                    // self.N179_3                           := N179_3;
                    // self.N179_4                           := N179_4;
                    // self.N179_5                           := N179_5;
                    // self.N179_6                           := N179_6;
                    // self.N180_2                           := N180_2;
                    // self.N180_3                           := N180_3;
                    // self.N180_4                           := N180_4;
                    // self.N180_5                           := N180_5;
                    // self.N180_6                           := N180_6;
                    // self.N180_7                           := N180_7;
                    // self.N180_8                           := N180_8;
                    // self.N181_2                           := N181_2;
                    // self.N181_3                           := N181_3;
                    // self.N181_4                           := N181_4;
                    // self.N181_5                           := N181_5;
                    // self.N181_6                           := N181_6;
                    // self.N182_2                           := N182_2;
                    // self.N182_3                           := N182_3;
                    // self.N182_4                           := N182_4;
                    // self.N182_5                           := N182_5;
                    // self.N182_6                           := N182_6;
                    // self.N182_7                           := N182_7;
                    // self.N183_2                           := N183_2;
                    // self.N183_3                           := N183_3;
                    // self.N183_4                           := N183_4;
                    // self.N183_5                           := N183_5;
                    // self.N183_6                           := N183_6;
                    // self.N183_7                           := N183_7;
                    // self.N184_2                           := N184_2;
                    // self.N184_3                           := N184_3;
                    // self.N184_4                           := N184_4;
                    // self.N184_5                           := N184_5;
                    // self.N184_6                           := N184_6;
                    // self.N184_7                           := N184_7;
                    // self.N184_8                           := N184_8;
                    // self.N185_2                           := N185_2;
                    // self.N185_3                           := N185_3;
                    // self.N185_4                           := N185_4;
                    // self.N185_5                           := N185_5;
                    // self.N185_6                           := N185_6;
                    // self.N185_7                           := N185_7;
                    // self.N185_8                           := N185_8;
                    // self.N185_9                           := N185_9;
                    // self.N186_2                           := N186_2;
                    // self.N186_3                           := N186_3;
                    // self.N186_4                           := N186_4;
                    // self.N186_5                           := N186_5;
                    // self.N186_6                           := N186_6;
                    // self.N186_7                           := N186_7;
                    // self.N187_2                           := N187_2;
                    // self.N187_3                           := N187_3;
                    // self.N187_4                           := N187_4;
                    // self.N187_5                           := N187_5;
                    // self.N187_6                           := N187_6;
                    // self.N188_2                           := N188_2;
                    // self.N188_3                           := N188_3;
                    // self.N188_4                           := N188_4;
                    // self.N188_5                           := N188_5;
                    // self.N188_6                           := N188_6;
                    // self.N188_7                           := N188_7;
                    // self.N189_2                           := N189_2;
                    // self.N189_3                           := N189_3;
                    // self.N189_4                           := N189_4;
                    // self.N189_5                           := N189_5;
                    // self.N189_6                           := N189_6;
                    // self.N189_7                           := N189_7;
                    // self.N190_2                           := N190_2;
                    // self.N190_3                           := N190_3;
                    // self.N190_4                           := N190_4;
                    // self.N190_5                           := N190_5;
                    // self.N190_6                           := N190_6;
                    // self.N191_2                           := N191_2;
                    // self.N191_3                           := N191_3;
                    // self.N191_4                           := N191_4;
                    // self.N191_5                           := N191_5;
                    // self.N191_6                           := N191_6;
                    // self.N191_7                           := N191_7;
                    // self.N191_8                           := N191_8;
                    // self.N191_9                           := N191_9;
                    // self.N192_2                           := N192_2;
                    // self.N192_3                           := N192_3;
                    // self.N192_4                           := N192_4;
                    // self.N192_5                           := N192_5;
                    // self.N192_6                           := N192_6;
                    // self.N192_7                           := N192_7;
                    // self.N192_8                           := N192_8;
                    // self.N193_2                           := N193_2;
                    // self.N193_3                           := N193_3;
                    // self.N193_4                           := N193_4;
                    // self.N193_5                           := N193_5;
                    // self.N193_6                           := N193_6;
                    // self.N194_2                           := N194_2;
                    // self.N194_3                           := N194_3;
                    // self.N194_4                           := N194_4;
                    // self.N194_5                           := N194_5;
                    // self.N194_6                           := N194_6;
                    // self.N194_7                           := N194_7;
                    // self.N194_8                           := N194_8;
                    // self.N194_9                           := N194_9;
                    // self.N195_2                           := N195_2;
                    // self.N195_3                           := N195_3;
                    // self.N195_4                           := N195_4;
                    // self.N195_5                           := N195_5;
                    // self.N195_6                           := N195_6;
                    // self.N195_7                           := N195_7;
                    // self.N196_2                           := N196_2;
                    // self.N196_3                           := N196_3;
                    // self.N196_4                           := N196_4;
                    // self.N196_5                           := N196_5;
                    // self.N197_2                           := N197_2;
                    // self.N197_3                           := N197_3;
                    // self.N197_4                           := N197_4;
                    // self.N197_5                           := N197_5;
                    // self.N197_6                           := N197_6;
                    // self.N198_2                           := N198_2;
                    // self.N198_3                           := N198_3;
                    // self.N198_4                           := N198_4;
                    // self.N198_5                           := N198_5;
                    // self.N198_6                           := N198_6;
                    // self.N198_7                           := N198_7;
                    // self.N198_8                           := N198_8;
                    // self.N199_2                           := N199_2;
                    // self.N199_3                           := N199_3;
                    // self.N199_4                           := N199_4;
                    // self.N199_5                           := N199_5;
                    // self.N199_6                           := N199_6;
                    // self.N199_7                           := N199_7;
                    // self.N199_8                           := N199_8;
                    // self.N200_2                           := N200_2;
                    // self.N200_3                           := N200_3;
                    // self.N200_4                           := N200_4;
                    // self.N200_5                           := N200_5;
                    // self.N200_6                           := N200_6;
                    // self.N200_7                           := N200_7;
                    // self.N201_2                           := N201_2;
                    // self.N201_3                           := N201_3;
                    // self.N201_4                           := N201_4;
                    // self.N201_5                           := N201_5;
                    // self.N202_2                           := N202_2;
                    // self.N202_3                           := N202_3;
                    // self.N202_4                           := N202_4;
                    // self.N202_5                           := N202_5;
                    // self.N202_6                           := N202_6;
                    // self.N202_7                           := N202_7;
                    // self.N202_8                           := N202_8;
                    // self.N203_2                           := N203_2;
                    // self.N203_3                           := N203_3;
                    // self.N203_4                           := N203_4;
                    // self.N203_5                           := N203_5;
                    // self.N203_6                           := N203_6;
                    // self.N203_7                           := N203_7;
                    // self.N204_2                           := N204_2;
                    // self.N204_3                           := N204_3;
                    // self.N204_4                           := N204_4;
                    // self.N204_5                           := N204_5;
                    // self.N204_6                           := N204_6;
                    // self.N204_7                           := N204_7;
                    // self.N205_2                           := N205_2;
                    // self.N205_3                           := N205_3;
                    // self.N205_4                           := N205_4;
                    // self.N205_5                           := N205_5;
                    // self.N205_6                           := N205_6;
                    // self.N205_7                           := N205_7;
                    // self.N205_8                           := N205_8;
                    // self.N206_2                           := N206_2;
                    // self.N206_3                           := N206_3;
                    // self.N206_4                           := N206_4;
                    // self.N206_5                           := N206_5;
                    // self.N206_6                           := N206_6;
                    // self.N206_7                           := N206_7;
                    // self.N206_8                           := N206_8;
                    // self.N206_9                           := N206_9;
                    // self.N206_10                          := N206_10;
                    // self.N207_2                           := N207_2;
                    // self.N207_3                           := N207_3;
                    // self.N207_4                           := N207_4;
                    // self.N207_5                           := N207_5;
                    // self.N207_6                           := N207_6;
                    // self.N207_7                           := N207_7;
                    // self.N207_8                           := N207_8;
                    // self.N208_2                           := N208_2;
                    // self.N208_3                           := N208_3;
                    // self.N208_4                           := N208_4;
                    // self.N208_5                           := N208_5;
                    // self.N208_6                           := N208_6;
                    // self.N208_7                           := N208_7;
                    // self.N208_8                           := N208_8;
                    // self.N209_2                           := N209_2;
                    // self.N209_3                           := N209_3;
                    // self.N209_4                           := N209_4;
                    // self.N209_5                           := N209_5;
                    // self.N209_6                           := N209_6;
                    // self.N209_7                           := N209_7;
                    // self.N209_8                           := N209_8;
                    // self.N210_2                           := N210_2;
                    // self.N210_3                           := N210_3;
                    // self.N210_4                           := N210_4;
                    // self.N210_5                           := N210_5;
                    // self.N210_6                           := N210_6;
                    // self.N211_2                           := N211_2;
                    // self.N211_3                           := N211_3;
                    // self.N211_4                           := N211_4;
                    // self.N211_5                           := N211_5;
                    // self.N211_6                           := N211_6;
                    // self.N211_7                           := N211_7;
                    // self.N211_8                           := N211_8;
                    // self.N212_2                           := N212_2;
                    // self.N212_3                           := N212_3;
                    // self.N212_4                           := N212_4;
                    // self.N212_5                           := N212_5;
                    // self.N212_6                           := N212_6;
                    // self.N213_2                           := N213_2;
                    // self.N213_3                           := N213_3;
                    // self.N213_4                           := N213_4;
                    // self.N213_5                           := N213_5;
                    // self.N213_6                           := N213_6;
                    // self.N213_7                           := N213_7;
                    // self.N213_8                           := N213_8;
                    // self.N214_2                           := N214_2;
                    // self.N214_3                           := N214_3;
                    // self.N214_4                           := N214_4;
                    // self.N214_5                           := N214_5;
                    // self.N214_6                           := N214_6;
                    // self.N214_7                           := N214_7;
                    // self.N214_8                           := N214_8;
                    // self.N214_9                           := N214_9;
                    // self.N215_2                           := N215_2;
                    // self.N215_3                           := N215_3;
                    // self.N215_4                           := N215_4;
                    // self.N215_5                           := N215_5;
                    // self.N216_2                           := N216_2;
                    // self.N216_3                           := N216_3;
                    // self.N216_4                           := N216_4;
                    // self.N216_5                           := N216_5;
                    // self.N216_6                           := N216_6;
                    // self.N217_2                           := N217_2;
                    // self.N217_3                           := N217_3;
                    // self.N217_4                           := N217_4;
                    // self.N217_5                           := N217_5;
                    // self.N217_6                           := N217_6;
                    // self.N217_7                           := N217_7;
                    // self.N217_8                           := N217_8;
                    // self.N217_9                           := N217_9;
                    // self.N217_10                          := N217_10;
                    // self.N218_2                           := N218_2;
                    // self.N218_3                           := N218_3;
                    // self.N218_4                           := N218_4;
                    // self.N218_5                           := N218_5;
                    // self.N218_6                           := N218_6;
                    // self.N219_2                           := N219_2;
                    // self.N219_3                           := N219_3;
                    // self.N219_4                           := N219_4;
                    // self.N219_5                           := N219_5;
                    // self.N219_6                           := N219_6;
                    // self.N219_7                           := N219_7;
                    // self.N219_8                           := N219_8;
                    // self.N219_9                           := N219_9;
                    // self.N220_2                           := N220_2;
                    // self.N220_3                           := N220_3;
                    // self.N220_4                           := N220_4;
                    // self.N220_5                           := N220_5;
                    // self.N220_6                           := N220_6;
                    // self.N220_7                           := N220_7;
                    // self.N220_8                           := N220_8;
                    // self.N221_2                           := N221_2;
                    // self.N221_3                           := N221_3;
                    // self.N221_4                           := N221_4;
                    // self.N221_5                           := N221_5;
                    // self.N221_6                           := N221_6;
                    // self.N221_7                           := N221_7;
                    // self.N221_8                           := N221_8;
                    // self.N222_2                           := N222_2;
                    // self.N222_3                           := N222_3;
                    // self.N222_4                           := N222_4;
                    // self.N222_5                           := N222_5;
                    // self.N222_6                           := N222_6;
                    // self.N222_7                           := N222_7;
                    // self.N223_2                           := N223_2;
                    // self.N223_3                           := N223_3;
                    // self.N223_4                           := N223_4;
                    // self.N223_5                           := N223_5;
                    // self.N223_6                           := N223_6;
                    // self.N224_2                           := N224_2;
                    // self.N224_3                           := N224_3;
                    // self.N224_4                           := N224_4;
                    // self.N224_5                           := N224_5;
                    // self.N224_6                           := N224_6;
                    // self.N224_7                           := N224_7;
                    // self.N224_8                           := N224_8;
                    // self.N224_9                           := N224_9;
                    // self.N225_2                           := N225_2;
                    // self.N225_3                           := N225_3;
                    // self.N225_4                           := N225_4;
                    // self.N225_5                           := N225_5;
                    // self.N225_6                           := N225_6;
                    // self.N226_2                           := N226_2;
                    // self.N226_3                           := N226_3;
                    // self.N226_4                           := N226_4;
                    // self.N226_5                           := N226_5;
                    // self.N226_6                           := N226_6;
                    // self.N226_7                           := N226_7;
                    // self.N226_8                           := N226_8;
                    // self.N227_2                           := N227_2;
                    // self.N227_3                           := N227_3;
                    // self.N227_4                           := N227_4;
                    // self.N227_5                           := N227_5;
                    // self.N227_6                           := N227_6;
                    // self.N227_7                           := N227_7;
                    // self.N227_8                           := N227_8;
                    // self.N228_2                           := N228_2;
                    // self.N228_3                           := N228_3;
                    // self.N228_4                           := N228_4;
                    // self.N228_5                           := N228_5;
                    // self.N228_6                           := N228_6;
                    // self.N228_7                           := N228_7;
                    // self.N228_8                           := N228_8;
                    // self.N229_2                           := N229_2;
                    // self.N229_3                           := N229_3;
                    // self.N229_4                           := N229_4;
                    // self.N229_5                           := N229_5;
                    // self.N229_6                           := N229_6;
                    // self.N229_7                           := N229_7;
                    // self.N229_8                           := N229_8;
                    // self.N230_2                           := N230_2;
                    // self.N230_3                           := N230_3;
                    // self.N230_4                           := N230_4;
                    // self.N230_5                           := N230_5;
                    // self.N230_6                           := N230_6;
                    // self.N230_7                           := N230_7;
                    // self.N230_8                           := N230_8;
                    // self.N230_9                           := N230_9;
                    // self.N231_2                           := N231_2;
                    // self.N231_3                           := N231_3;
                    // self.N231_4                           := N231_4;
                    // self.N231_5                           := N231_5;
                    // self.N231_6                           := N231_6;
                    // self.N231_7                           := N231_7;
                    // self.N231_8                           := N231_8;
                    // self.N232_2                           := N232_2;
                    // self.N232_3                           := N232_3;
                    // self.N232_4                           := N232_4;
                    // self.N232_5                           := N232_5;
                    // self.N232_6                           := N232_6;
                    // self.N233_2                           := N233_2;
                    // self.N233_3                           := N233_3;
                    // self.N233_4                           := N233_4;
                    // self.N233_5                           := N233_5;
                    // self.N233_6                           := N233_6;
                    // self.N233_7                           := N233_7;
                    // self.N234_2                           := N234_2;
                    // self.N234_3                           := N234_3;
                    // self.N234_4                           := N234_4;
                    // self.N234_5                           := N234_5;
                    // self.N234_6                           := N234_6;
                    // self.N234_7                           := N234_7;
                    // self.N234_8                           := N234_8;
                    // self.N235_2                           := N235_2;
                    // self.N235_3                           := N235_3;
                    // self.N235_4                           := N235_4;
                    // self.N235_5                           := N235_5;
                    // self.N235_6                           := N235_6;
                    // self.N235_7                           := N235_7;
                    // self.N235_8                           := N235_8;
                    // self.N236_2                           := N236_2;
                    // self.N236_3                           := N236_3;
                    // self.N236_4                           := N236_4;
                    // self.N236_5                           := N236_5;
                    // self.N236_6                           := N236_6;
                    // self.N236_7                           := N236_7;
                    // self.N236_8                           := N236_8;
                    // self.N237_2                           := N237_2;
                    // self.N237_3                           := N237_3;
                    // self.N237_4                           := N237_4;
                    // self.N237_5                           := N237_5;
                    // self.N237_6                           := N237_6;
                    // self.N237_7                           := N237_7;
                    // self.N237_8                           := N237_8;
                    // self.N238_2                           := N238_2;
                    // self.N238_3                           := N238_3;
                    // self.N238_4                           := N238_4;
                    // self.N238_5                           := N238_5;
                    // self.N238_6                           := N238_6;
                    // self.N238_7                           := N238_7;
                    // self.N238_8                           := N238_8;
                    // self.N239_2                           := N239_2;
                    // self.N239_3                           := N239_3;
                    // self.N239_4                           := N239_4;
                    // self.N239_5                           := N239_5;
                    // self.N239_6                           := N239_6;
                    // self.N239_7                           := N239_7;
                    // self.N239_8                           := N239_8;
                    // self.N240_2                           := N240_2;
                    // self.N240_3                           := N240_3;
                    // self.N240_4                           := N240_4;
                    // self.N240_5                           := N240_5;
                    // self.N240_6                           := N240_6;
                    // self.N240_7                           := N240_7;
                    // self.N240_8                           := N240_8;
                    // self.N240_9                           := N240_9;
                    // self.N241_2                           := N241_2;
                    // self.N241_3                           := N241_3;
                    // self.N241_4                           := N241_4;
                    // self.N241_5                           := N241_5;
                    // self.N241_6                           := N241_6;
                    // self.N241_7                           := N241_7;
                    // self.N241_8                           := N241_8;
                    // self.N242_2                           := N242_2;
                    // self.N242_3                           := N242_3;
                    // self.N242_4                           := N242_4;
                    // self.N242_5                           := N242_5;
                    // self.N242_6                           := N242_6;
                    // self.N242_7                           := N242_7;
                    // self.N243_2                           := N243_2;
                    // self.N243_3                           := N243_3;
                    // self.N243_4                           := N243_4;
                    // self.N243_5                           := N243_5;
                    // self.N243_6                           := N243_6;
                    // self.N243_7                           := N243_7;
                    // self.N244_2                           := N244_2;
                    // self.N244_3                           := N244_3;
                    // self.N244_4                           := N244_4;
                    // self.N244_5                           := N244_5;
                    // self.N244_6                           := N244_6;
                    // self.N244_7                           := N244_7;
                    // self.N245_2                           := N245_2;
                    // self.N245_3                           := N245_3;
                    // self.N245_4                           := N245_4;
                    // self.N245_5                           := N245_5;
                    // self.N245_6                           := N245_6;
                    // self.N245_7                           := N245_7;
                    // self.N246_2                           := N246_2;
                    // self.N246_3                           := N246_3;
                    // self.N246_4                           := N246_4;
                    // self.N246_5                           := N246_5;
                    // self.N246_6                           := N246_6;
                    // self.N246_7                           := N246_7;
                    // self.N246_8                           := N246_8;
                    // self.N247_2                           := N247_2;
                    // self.N247_3                           := N247_3;
                    // self.N247_4                           := N247_4;
                    // self.N247_5                           := N247_5;
                    // self.N247_6                           := N247_6;
                    // self.N247_7                           := N247_7;
                    // self.N247_8                           := N247_8;
                    // self.N248_2                           := N248_2;
                    // self.N248_3                           := N248_3;
                    // self.N248_4                           := N248_4;
                    // self.N248_5                           := N248_5;
                    // self.N248_6                           := N248_6;
                    // self.N248_7                           := N248_7;
                    // self.N249_2                           := N249_2;
                    // self.N249_3                           := N249_3;
                    // self.N249_4                           := N249_4;
                    // self.N249_5                           := N249_5;
                    // self.N249_6                           := N249_6;
                    // self.N249_7                           := N249_7;
                    // self.N249_8                           := N249_8;
                    // self.N250_2                           := N250_2;
                    // self.N250_3                           := N250_3;
                    // self.N250_4                           := N250_4;
                    // self.N250_5                           := N250_5;
                    // self.N250_6                           := N250_6;
                    // self.N251_2                           := N251_2;
                    // self.N251_3                           := N251_3;
                    // self.N251_4                           := N251_4;
                    // self.N251_5                           := N251_5;
                    // self.N251_6                           := N251_6;
                    // self.N251_7                           := N251_7;
                    // self.N251_8                           := N251_8;
                    // self.N251_9                           := N251_9;
                    // self.N251_10                          := N251_10;
                    // self.N252_2                           := N252_2;
                    // self.N252_3                           := N252_3;
                    // self.N252_4                           := N252_4;
                    // self.N252_5                           := N252_5;
                    // self.N252_6                           := N252_6;
                    // self.N252_7                           := N252_7;
                    // self.N252_8                           := N252_8;
                    // self.N253_2                           := N253_2;
                    // self.N253_3                           := N253_3;
                    // self.N253_4                           := N253_4;
                    // self.N253_5                           := N253_5;
                    // self.N253_6                           := N253_6;
                    // self.N253_7                           := N253_7;
                    // self.N253_8                           := N253_8;
                    // self.N254_2                           := N254_2;
                    // self.N254_3                           := N254_3;
                    // self.N254_4                           := N254_4;
                    // self.N254_5                           := N254_5;
                    // self.N254_6                           := N254_6;
                    // self.N254_7                           := N254_7;
                    // self.N255_2                           := N255_2;
                    // self.N255_3                           := N255_3;
                    // self.N255_4                           := N255_4;
                    // self.N255_5                           := N255_5;
                    // self.N255_6                           := N255_6;
                    // self.N255_7                           := N255_7;
                    // self.N255_8                           := N255_8;
                    // self.N256_2                           := N256_2;
                    // self.N256_3                           := N256_3;
                    // self.N256_4                           := N256_4;
                    // self.N256_5                           := N256_5;
                    // self.N256_6                           := N256_6;
                    // self.N257_2                           := N257_2;
                    // self.N257_3                           := N257_3;
                    // self.N257_4                           := N257_4;
                    // self.N257_5                           := N257_5;
                    // self.N257_6                           := N257_6;
                    // self.N257_7                           := N257_7;
                    // self.N258_2                           := N258_2;
                    // self.N258_3                           := N258_3;
                    // self.N258_4                           := N258_4;
                    // self.N258_5                           := N258_5;
                    // self.N258_6                           := N258_6;
                    // self.N258_7                           := N258_7;
                    // self.N258_8                           := N258_8;
                    // self.N258_9                           := N258_9;
                    // self.N259_2                           := N259_2;
                    // self.N259_3                           := N259_3;
                    // self.N259_4                           := N259_4;
                    // self.N259_5                           := N259_5;
                    // self.N259_6                           := N259_6;
                    // self.N259_7                           := N259_7;
                    // self.N259_8                           := N259_8;
                    // self.N259_9                           := N259_9;
                    // self.N260_2                           := N260_2;
                    // self.N260_3                           := N260_3;
                    // self.N260_4                           := N260_4;
                    // self.N260_5                           := N260_5;
                    // self.N260_6                           := N260_6;
                    // self.N260_7                           := N260_7;
                    // self.N260_8                           := N260_8;
                    // self.N260_9                           := N260_9;
                    // self.N261_2                           := N261_2;
                    // self.N261_3                           := N261_3;
                    // self.N261_4                           := N261_4;
                    // self.N261_5                           := N261_5;
                    // self.N261_6                           := N261_6;
                    // self.N261_7                           := N261_7;
                    // self.N261_8                           := N261_8;
                    // self.N262_2                           := N262_2;
                    // self.N262_3                           := N262_3;
                    // self.N262_4                           := N262_4;
                    // self.N262_5                           := N262_5;
                    // self.N262_6                           := N262_6;
                    // self.N262_7                           := N262_7;
                    // self.N262_8                           := N262_8;
                    // self.N263_2                           := N263_2;
                    // self.N263_3                           := N263_3;
                    // self.N263_4                           := N263_4;
                    // self.N263_5                           := N263_5;
                    // self.N263_6                           := N263_6;
                    // self.N263_7                           := N263_7;
                    // self.N263_8                           := N263_8;
                    // self.N264_2                           := N264_2;
                    // self.N264_3                           := N264_3;
                    // self.N264_4                           := N264_4;
                    // self.N264_5                           := N264_5;
                    // self.N264_6                           := N264_6;
                    // self.N265_2                           := N265_2;
                    // self.N265_3                           := N265_3;
                    // self.N265_4                           := N265_4;
                    // self.N265_5                           := N265_5;
                    // self.N265_6                           := N265_6;
                    // self.N265_7                           := N265_7;
                    // self.N265_8                           := N265_8;
                    // self.N266_2                           := N266_2;
                    // self.N266_3                           := N266_3;
                    // self.N266_4                           := N266_4;
                    // self.N266_5                           := N266_5;
                    // self.N266_6                           := N266_6;
                    // self.N266_7                           := N266_7;
                    // self.N266_8                           := N266_8;
                    // self.N267_2                           := N267_2;
                    // self.N267_3                           := N267_3;
                    // self.N267_4                           := N267_4;
                    // self.N267_5                           := N267_5;
                    // self.N267_6                           := N267_6;
                    // self.N267_7                           := N267_7;
                    // self.N267_8                           := N267_8;
                    // self.N267_9                           := N267_9;
                    // self.N268_2                           := N268_2;
                    // self.N268_3                           := N268_3;
                    // self.N268_4                           := N268_4;
                    // self.N268_5                           := N268_5;
                    // self.N268_6                           := N268_6;
                    // self.N268_7                           := N268_7;
                    // self.N268_8                           := N268_8;
                    // self.N269_2                           := N269_2;
                    // self.N269_3                           := N269_3;
                    // self.N269_4                           := N269_4;
                    // self.N269_5                           := N269_5;
                    // self.N269_6                           := N269_6;
                    // self.N270_2                           := N270_2;
                    // self.N270_3                           := N270_3;
                    // self.N270_4                           := N270_4;
                    // self.N270_5                           := N270_5;
                    // self.N271_2                           := N271_2;
                    // self.N271_3                           := N271_3;
                    // self.N271_4                           := N271_4;
                    // self.N271_5                           := N271_5;
                    // self.N271_6                           := N271_6;
                    // self.N271_7                           := N271_7;
                    // self.N272_2                           := N272_2;
                    // self.N272_3                           := N272_3;
                    // self.N272_4                           := N272_4;
                    // self.N272_5                           := N272_5;
                    // self.N272_6                           := N272_6;
                    // self.N273_2                           := N273_2;
                    // self.N273_3                           := N273_3;
                    // self.N273_4                           := N273_4;
                    // self.N273_5                           := N273_5;
                    // self.N273_6                           := N273_6;
                    // self.N273_7                           := N273_7;
                    // self.N274_2                           := N274_2;
                    // self.N274_3                           := N274_3;
                    // self.N274_4                           := N274_4;
                    // self.N274_5                           := N274_5;
                    // self.N274_6                           := N274_6;
                    // self.N275_2                           := N275_2;
                    // self.N275_3                           := N275_3;
                    // self.N275_4                           := N275_4;
                    // self.N275_5                           := N275_5;
                    // self.N275_6                           := N275_6;
                    // self.N275_7                           := N275_7;
                    // self.N275_8                           := N275_8;
                    // self.N275_9                           := N275_9;
                    // self.N276_2                           := N276_2;
                    // self.N276_3                           := N276_3;
                    // self.N276_4                           := N276_4;
                    // self.N276_5                           := N276_5;
                    // self.N276_6                           := N276_6;
                    // self.N276_7                           := N276_7;
                    // self.N276_8                           := N276_8;
                    // self.N277_2                           := N277_2;
                    // self.N277_3                           := N277_3;
                    // self.N277_4                           := N277_4;
                    // self.N277_5                           := N277_5;
                    // self.N277_6                           := N277_6;
                    // self.N277_7                           := N277_7;
                    // self.N277_8                           := N277_8;
                    // self.N278_2                           := N278_2;
                    // self.N278_3                           := N278_3;
                    // self.N278_4                           := N278_4;
                    // self.N278_5                           := N278_5;
                    // self.N278_6                           := N278_6;
                    // self.N278_7                           := N278_7;
                    // self.N278_8                           := N278_8;
                    // self.N279_2                           := N279_2;
                    // self.N279_3                           := N279_3;
                    // self.N279_4                           := N279_4;
                    // self.N279_5                           := N279_5;
                    // self.N279_6                           := N279_6;
                    // self.N279_7                           := N279_7;
                    // self.N280_2                           := N280_2;
                    // self.N280_3                           := N280_3;
                    // self.N280_4                           := N280_4;
                    // self.N280_5                           := N280_5;
                    // self.N280_6                           := N280_6;
                    // self.N280_7                           := N280_7;
                    // self.N280_8                           := N280_8;
                    // self.N281_2                           := N281_2;
                    // self.N281_3                           := N281_3;
                    // self.N281_4                           := N281_4;
                    // self.N281_5                           := N281_5;
                    // self.N281_6                           := N281_6;
                    // self.N281_7                           := N281_7;
                    // self.N282_2                           := N282_2;
                    // self.N282_3                           := N282_3;
                    // self.N282_4                           := N282_4;
                    // self.N282_5                           := N282_5;
                    // self.N282_6                           := N282_6;
                    // self.N283_2                           := N283_2;
                    // self.N283_3                           := N283_3;
                    // self.N283_4                           := N283_4;
                    // self.N283_5                           := N283_5;
                    // self.N283_6                           := N283_6;
                    // self.N283_7                           := N283_7;
                    // self.N283_8                           := N283_8;
                    // self.N283_9                           := N283_9;
                    // self.N284_2                           := N284_2;
                    // self.N284_3                           := N284_3;
                    // self.N284_4                           := N284_4;
                    // self.N284_5                           := N284_5;
                    // self.N284_6                           := N284_6;
                    // self.N284_7                           := N284_7;
                    // self.N284_8                           := N284_8;
                    // self.N285_2                           := N285_2;
                    // self.N285_3                           := N285_3;
                    // self.N285_4                           := N285_4;
                    // self.N285_5                           := N285_5;
                    // self.N285_6                           := N285_6;
                    // self.N285_7                           := N285_7;
                    // self.N285_8                           := N285_8;
                    // self.N285_9                           := N285_9;
                    // self.N286_2                           := N286_2;
                    // self.N286_3                           := N286_3;
                    // self.N286_4                           := N286_4;
                    // self.N286_5                           := N286_5;
                    // self.N286_6                           := N286_6;
                    // self.N286_7                           := N286_7;
                    // self.N286_8                           := N286_8;
                    // self.N287_2                           := N287_2;
                    // self.N287_3                           := N287_3;
                    // self.N287_4                           := N287_4;
                    // self.N287_5                           := N287_5;
                    // self.N287_6                           := N287_6;
                    // self.N288_2                           := N288_2;
                    // self.N288_3                           := N288_3;
                    // self.N288_4                           := N288_4;
                    // self.N288_5                           := N288_5;
                    // self.N288_6                           := N288_6;
                    // self.N288_7                           := N288_7;
                    // self.N288_8                           := N288_8;
                    // self.N289_2                           := N289_2;
                    // self.N289_3                           := N289_3;
                    // self.N289_4                           := N289_4;
                    // self.N289_5                           := N289_5;
                    // self.N289_6                           := N289_6;
                    // self.N289_7                           := N289_7;
                    // self.N289_8                           := N289_8;
                    // self.N290_2                           := N290_2;
                    // self.N290_3                           := N290_3;
                    // self.N290_4                           := N290_4;
                    // self.N290_5                           := N290_5;
                    // self.N290_6                           := N290_6;
                    // self.N290_7                           := N290_7;
                    // self.N290_8                           := N290_8;
                    // self.N291_2                           := N291_2;
                    // self.N291_3                           := N291_3;
                    // self.N291_4                           := N291_4;
                    // self.N291_5                           := N291_5;
                    // self.N292_2                           := N292_2;
                    // self.N292_3                           := N292_3;
                    // self.N292_4                           := N292_4;
                    // self.N292_5                           := N292_5;
                    // self.N292_6                           := N292_6;
                    // self.N292_7                           := N292_7;
                    // self.N292_8                           := N292_8;
                    // self.N293_2                           := N293_2;
                    // self.N293_3                           := N293_3;
                    // self.N293_4                           := N293_4;
                    // self.N293_5                           := N293_5;
                    // self.N293_6                           := N293_6;
                    // self.N293_7                           := N293_7;
                    // self.N294_2                           := N294_2;
                    // self.N294_3                           := N294_3;
                    // self.N294_4                           := N294_4;
                    // self.N294_5                           := N294_5;
                    // self.N294_6                           := N294_6;
                    // self.N295_2                           := N295_2;
                    // self.N295_3                           := N295_3;
                    // self.N295_4                           := N295_4;
                    // self.N295_5                           := N295_5;
                    // self.N295_6                           := N295_6;
                    // self.N295_7                           := N295_7;
                    // self.N295_8                           := N295_8;
                    // self.N296_2                           := N296_2;
                    // self.N296_3                           := N296_3;
                    // self.N296_4                           := N296_4;
                    // self.N296_5                           := N296_5;
                    // self.N296_6                           := N296_6;
                    // self.N296_7                           := N296_7;
                    // self.N296_8                           := N296_8;
                    // self.N297_2                           := N297_2;
                    // self.N297_3                           := N297_3;
                    // self.N297_4                           := N297_4;
                    // self.N297_5                           := N297_5;
                    // self.N297_6                           := N297_6;
                    // self.N297_7                           := N297_7;
                    // self.N297_8                           := N297_8;
                    // self.N298_2                           := N298_2;
                    // self.N298_3                           := N298_3;
                    // self.N298_4                           := N298_4;
                    // self.N298_5                           := N298_5;
                    // self.N298_6                           := N298_6;
                    // self.N298_7                           := N298_7;
                    // self.N298_8                           := N298_8;
                    // self.N298_9                           := N298_9;
                    // self.N298_10                          := N298_10;
                    // self.N299_2                           := N299_2;
                    // self.N299_3                           := N299_3;
                    // self.N299_4                           := N299_4;
                    // self.N299_5                           := N299_5;
                    // self.N299_6                           := N299_6;
                    // self.N299_7                           := N299_7;
                    // self.N299_8                           := N299_8;
                    // self.N300_2                           := N300_2;
                    // self.N300_3                           := N300_3;
                    // self.N300_4                           := N300_4;
                    // self.N300_5                           := N300_5;
                    // self.N300_6                           := N300_6;
                    // self.N300_7                           := N300_7;
                    // self.N300_8                           := N300_8;
                    // self.N301_2                           := N301_2;
                    // self.N301_3                           := N301_3;
                    // self.N301_4                           := N301_4;
                    // self.N301_5                           := N301_5;
                    // self.N301_6                           := N301_6;
                    // self.N301_7                           := N301_7;
                    // self.N301_8                           := N301_8;
                    // self.N302_2                           := N302_2;
                    // self.N302_3                           := N302_3;
                    // self.N302_4                           := N302_4;
                    // self.N302_5                           := N302_5;
                    // self.N302_6                           := N302_6;
                    // self.N303_2                           := N303_2;
                    // self.N303_3                           := N303_3;
                    // self.N303_4                           := N303_4;
                    // self.N303_5                           := N303_5;
                    // self.N303_6                           := N303_6;
                    // self.N303_7                           := N303_7;
                    // self.N303_8                           := N303_8;
                    // self.N304_2                           := N304_2;
                    // self.N304_3                           := N304_3;
                    // self.N304_4                           := N304_4;
                    // self.N304_5                           := N304_5;
                    // self.N304_6                           := N304_6;
                    // self.N304_7                           := N304_7;
                    // self.N304_8                           := N304_8;
                    // self.N305_2                           := N305_2;
                    // self.N305_3                           := N305_3;
                    // self.N305_4                           := N305_4;
                    // self.N305_5                           := N305_5;
                    // self.N305_6                           := N305_6;
                    // self.N305_7                           := N305_7;
                    // self.N305_8                           := N305_8;
                    // self.N306_2                           := N306_2;
                    // self.N306_3                           := N306_3;
                    // self.N306_4                           := N306_4;
                    // self.N306_5                           := N306_5;
                    // self.N306_6                           := N306_6;
                    // self.N306_7                           := N306_7;
                    // self.N307_2                           := N307_2;
                    // self.N307_3                           := N307_3;
                    // self.N307_4                           := N307_4;
                    // self.N307_5                           := N307_5;
                    // self.N307_6                           := N307_6;
                    // self.N307_7                           := N307_7;
                    // self.N307_8                           := N307_8;
                    // self.N308_2                           := N308_2;
                    // self.N308_3                           := N308_3;
                    // self.N308_4                           := N308_4;
                    // self.N308_5                           := N308_5;
                    // self.N308_6                           := N308_6;
                    // self.N308_7                           := N308_7;
                    // self.N309_2                           := N309_2;
                    // self.N309_3                           := N309_3;
                    // self.N309_4                           := N309_4;
                    // self.N309_5                           := N309_5;
                    // self.N309_6                           := N309_6;
                    // self.N310_2                           := N310_2;
                    // self.N310_3                           := N310_3;
                    // self.N310_4                           := N310_4;
                    // self.N310_5                           := N310_5;
                    // self.N311_2                           := N311_2;
                    // self.N311_3                           := N311_3;
                    // self.N311_4                           := N311_4;
                    // self.N311_5                           := N311_5;
                    // self.N311_6                           := N311_6;
                    // self.N311_7                           := N311_7;
                    // self.N311_8                           := N311_8;
                    // self.N312_2                           := N312_2;
                    // self.N312_3                           := N312_3;
                    // self.N312_4                           := N312_4;
                    // self.N312_5                           := N312_5;
                    // self.N312_6                           := N312_6;
                    // self.N312_7                           := N312_7;
                    // self.N312_8                           := N312_8;
                    // self.N313_2                           := N313_2;
                    // self.N313_3                           := N313_3;
                    // self.N313_4                           := N313_4;
                    // self.N313_5                           := N313_5;
                    // self.N313_6                           := N313_6;
                    // self.N313_7                           := N313_7;
                    // self.N313_8                           := N313_8;
                    // self.N314_2                           := N314_2;
                    // self.N314_3                           := N314_3;
                    // self.N314_4                           := N314_4;
                    // self.N314_5                           := N314_5;
                    // self.N314_6                           := N314_6;
                    // self.N314_7                           := N314_7;
                    // self.N315_2                           := N315_2;
                    // self.N315_3                           := N315_3;
                    // self.N315_4                           := N315_4;
                    // self.N315_5                           := N315_5;
                    // self.N315_6                           := N315_6;
                    // self.N316_2                           := N316_2;
                    // self.N316_3                           := N316_3;
                    // self.N316_4                           := N316_4;
                    // self.N316_5                           := N316_5;
                    // self.N316_6                           := N316_6;
                    // self.N316_7                           := N316_7;
                    // self.N316_8                           := N316_8;
                    // self.N317_2                           := N317_2;
                    // self.N317_3                           := N317_3;
                    // self.N317_4                           := N317_4;
                    // self.N317_5                           := N317_5;
                    // self.N317_6                           := N317_6;
                    // self.N318_2                           := N318_2;
                    // self.N318_3                           := N318_3;
                    // self.N318_4                           := N318_4;
                    // self.N318_5                           := N318_5;
                    // self.N318_6                           := N318_6;
                    // self.N318_7                           := N318_7;
                    // self.N319_2                           := N319_2;
                    // self.N319_3                           := N319_3;
                    // self.N319_4                           := N319_4;
                    // self.N319_5                           := N319_5;
                    // self.N319_6                           := N319_6;
                    // self.N319_7                           := N319_7;
                    // self.N319_8                           := N319_8;
                    // self.N320_2                           := N320_2;
                    // self.N320_3                           := N320_3;
                    // self.N320_4                           := N320_4;
                    // self.N320_5                           := N320_5;
                    // self.N320_6                           := N320_6;
                    // self.N320_7                           := N320_7;
                    // self.N321_2                           := N321_2;
                    // self.N321_3                           := N321_3;
                    // self.N321_4                           := N321_4;
                    // self.N321_5                           := N321_5;
                    // self.N321_6                           := N321_6;
                    // self.N321_7                           := N321_7;
                    // self.N321_8                           := N321_8;
                    // self.N322_2                           := N322_2;
                    // self.N322_3                           := N322_3;
                    // self.N322_4                           := N322_4;
                    // self.N322_5                           := N322_5;
                    // self.N322_6                           := N322_6;
                    // self.N322_7                           := N322_7;
                    // self.N322_8                           := N322_8;
                    // self.N323_2                           := N323_2;
                    // self.N323_3                           := N323_3;
                    // self.N323_4                           := N323_4;
                    // self.N323_5                           := N323_5;
                    // self.N323_6                           := N323_6;
                    // self.N324_2                           := N324_2;
                    // self.N324_3                           := N324_3;
                    // self.N324_4                           := N324_4;
                    // self.N324_5                           := N324_5;
                    // self.N324_6                           := N324_6;
                    // self.N324_7                           := N324_7;
                    // self.N325_2                           := N325_2;
                    // self.N325_3                           := N325_3;
                    // self.N325_4                           := N325_4;
                    // self.N325_5                           := N325_5;
                    // self.N325_6                           := N325_6;
                    // self.N325_7                           := N325_7;
                    // self.N325_8                           := N325_8;
                    // self.N326_2                           := N326_2;
                    // self.N326_3                           := N326_3;
                    // self.N326_4                           := N326_4;
                    // self.N326_5                           := N326_5;
                    // self.N326_6                           := N326_6;
                    // self.N326_7                           := N326_7;
                    // self.N326_8                           := N326_8;
                    // self.N326_9                           := N326_9;
                    // self.N326_10                          := N326_10;
                    // self.N327_2                           := N327_2;
                    // self.N327_3                           := N327_3;
                    // self.N327_4                           := N327_4;
                    // self.N327_5                           := N327_5;
                    // self.N327_6                           := N327_6;
                    // self.N327_7                           := N327_7;
                    // self.N328_2                           := N328_2;
                    // self.N328_3                           := N328_3;
                    // self.N328_4                           := N328_4;
                    // self.N328_5                           := N328_5;
                    // self.N328_6                           := N328_6;
                    // self.N328_7                           := N328_7;
                    // self.N329_2                           := N329_2;
                    // self.N329_3                           := N329_3;
                    // self.N329_4                           := N329_4;
                    // self.N329_5                           := N329_5;
                    // self.N329_6                           := N329_6;
                    // self.N329_7                           := N329_7;
                    // self.N330_2                           := N330_2;
                    // self.N330_3                           := N330_3;
                    // self.N330_4                           := N330_4;
                    // self.N330_5                           := N330_5;
                    // self.N330_6                           := N330_6;
                    // self.N330_7                           := N330_7;
                    // self.N331_2                           := N331_2;
                    // self.N331_3                           := N331_3;
                    // self.N331_4                           := N331_4;
                    // self.N331_5                           := N331_5;
                    // self.N331_6                           := N331_6;
                    // self.N331_7                           := N331_7;
                    // self.N332_2                           := N332_2;
                    // self.N332_3                           := N332_3;
                    // self.N332_4                           := N332_4;
                    // self.N332_5                           := N332_5;
                    // self.N332_6                           := N332_6;
                    // self.N332_7                           := N332_7;
                    // self.N333_2                           := N333_2;
                    // self.N333_3                           := N333_3;
                    // self.N333_4                           := N333_4;
                    // self.N333_5                           := N333_5;
                    // self.N333_6                           := N333_6;
                    // self.N333_7                           := N333_7;
                    // self.N334_2                           := N334_2;
                    // self.N334_3                           := N334_3;
                    // self.N334_4                           := N334_4;
                    // self.N334_5                           := N334_5;
                    // self.N334_6                           := N334_6;
                    // self.N334_7                           := N334_7;
                    // self.N334_8                           := N334_8;
                    // self.N335_2                           := N335_2;
                    // self.N335_3                           := N335_3;
                    // self.N335_4                           := N335_4;
                    // self.N335_5                           := N335_5;
                    // self.N335_6                           := N335_6;
                    // self.N335_7                           := N335_7;
                    // self.N336_2                           := N336_2;
                    // self.N336_3                           := N336_3;
//                    self.N336_4                           := N336_4;
//                    self.N336_5                           := N336_5;
//                    self.N336_6                           := N336_6;
//                    self.N336_7                           := N336_7;
//                    self.N336_8                           := N336_8;
//                    self.N337_2                           := N337_2;
//                    self.N337_3                           := N337_3;
//                    self.N337_4                           := N337_4;
//                    self.N337_5                           := N337_5;
//                    self.N337_6                           := N337_6;
//                    self.N337_7                           := N337_7;
//                    self.N338_2                           := N338_2;
//                    self.N338_3                           := N338_3;
//                    self.N338_4                           := N338_4;
//                    self.N338_5                           := N338_5;
//                    self.N338_6                           := N338_6;
//                    self.N338_7                           := N338_7;
//                    self.N338_8                           := N338_8;

                    self.N0_1                             := N0_1;
                    self.N1_1                             := N1_1;
                    self.N2_1                             := N2_1;
                    self.N3_1                             := N3_1;
                    self.N4_1                             := N4_1;
                    self.N5_1                             := N5_1;
                    self.N6_1                             := N6_1;
                    self.N7_1                             := N7_1;
                    self.N8_1                             := N8_1;
                    self.N9_1                             := N9_1;
                    self.N10_1                            := N10_1;
                    self.N11_1                            := N11_1;
                    self.N12_1                            := N12_1;
                    self.N13_1                            := N13_1;
                    self.N14_1                            := N14_1;
                    self.N15_1                            := N15_1;
                    self.N16_1                            := N16_1;
                    self.N17_1                            := N17_1;
                    self.N18_1                            := N18_1;
                    self.N19_1                            := N19_1;
                    self.N20_1                            := N20_1;
                    self.N21_1                            := N21_1;
                    self.N22_1                            := N22_1;
                    self.N23_1                            := N23_1;
                    self.N24_1                            := N24_1;
                    self.N25_1                            := N25_1;
                    self.N26_1                            := N26_1;
                    self.N27_1                            := N27_1;
                    self.N28_1                            := N28_1;
                    self.N29_1                            := N29_1;
                    self.N30_1                            := N30_1;
                    self.N31_1                            := N31_1;
                    self.N32_1                            := N32_1;
                    self.N33_1                            := N33_1;
                    self.N34_1                            := N34_1;
                    self.N35_1                            := N35_1;
                    self.N36_1                            := N36_1;
                    self.N37_1                            := N37_1;
                    self.N38_1                            := N38_1;
                    self.N39_1                            := N39_1;
                    self.N40_1                            := N40_1;
                    self.N41_1                            := N41_1;
                    self.N42_1                            := N42_1;
                    self.N43_1                            := N43_1;
                    self.N44_1                            := N44_1;
                    self.N45_1                            := N45_1;
                    self.N46_1                            := N46_1;
                    self.N47_1                            := N47_1;
                    self.N48_1                            := N48_1;
                    self.N49_1                            := N49_1;
                    self.N50_1                            := N50_1;
                    self.N51_1                            := N51_1;
                    self.N52_1                            := N52_1;
                    self.N53_1                            := N53_1;
                    self.N54_1                            := N54_1;
                    self.N55_1                            := N55_1;
                    self.N56_1                            := N56_1;
                    self.N57_1                            := N57_1;
                    self.N58_1                            := N58_1;
                    self.N59_1                            := N59_1;
                    self.N60_1                            := N60_1;
                    self.N61_1                            := N61_1;
                    self.N62_1                            := N62_1;
                    self.N63_1                            := N63_1;
                    self.N64_1                            := N64_1;
                    self.N65_1                            := N65_1;
                    self.N66_1                            := N66_1;
                    self.N67_1                            := N67_1;
                    self.N68_1                            := N68_1;
                    self.N69_1                            := N69_1;
                    self.N70_1                            := N70_1;
                    self.N71_1                            := N71_1;
                    self.N72_1                            := N72_1;
                    self.N73_1                            := N73_1;
                    self.N74_1                            := N74_1;
                    self.N75_1                            := N75_1;
                    self.N76_1                            := N76_1;
                    self.N77_1                            := N77_1;
                    self.N78_1                            := N78_1;
                    self.N79_1                            := N79_1;
                    self.N80_1                            := N80_1;
                    self.N81_1                            := N81_1;
                    self.N82_1                            := N82_1;
                    self.N83_1                            := N83_1;
                    self.N84_1                            := N84_1;
                    self.N85_1                            := N85_1;
                    self.N86_1                            := N86_1;
                    self.N87_1                            := N87_1;
                    self.N88_1                            := N88_1;
                    self.N89_1                            := N89_1;
                    self.N90_1                            := N90_1;
                    self.N91_1                            := N91_1;
                    self.N92_1                            := N92_1;
                    self.N93_1                            := N93_1;
                    self.N94_1                            := N94_1;
                    self.N95_1                            := N95_1;
                    self.N96_1                            := N96_1;
                    self.N97_1                            := N97_1;
                    self.N98_1                            := N98_1;
                    self.N99_1                            := N99_1;
                    self.N100_1                           := N100_1;
                    self.N101_1                           := N101_1;
                    self.N102_1                           := N102_1;
                    self.N103_1                           := N103_1;
                    self.N104_1                           := N104_1;
                    self.N105_1                           := N105_1;
                    self.N106_1                           := N106_1;
                    self.N107_1                           := N107_1;
                    self.N108_1                           := N108_1;
                    self.N109_1                           := N109_1;
                    self.N110_1                           := N110_1;
                    self.N111_1                           := N111_1;
                    self.N112_1                           := N112_1;
                    self.N113_1                           := N113_1;
                    self.N114_1                           := N114_1;
                    self.N115_1                           := N115_1;
                    self.N116_1                           := N116_1;
                    self.N117_1                           := N117_1;
                    self.N118_1                           := N118_1;
                    self.N119_1                           := N119_1;
                    self.N120_1                           := N120_1;
                    self.N121_1                           := N121_1;
                    self.N122_1                           := N122_1;
                    self.N123_1                           := N123_1;
                    self.N124_1                           := N124_1;
                    self.N125_1                           := N125_1;
                    self.N126_1                           := N126_1;
                    self.N127_1                           := N127_1;
                    self.N128_1                           := N128_1;
                    self.N129_1                           := N129_1;
                    self.N130_1                           := N130_1;
                    self.N131_1                           := N131_1;
                    self.N132_1                           := N132_1;
                    self.N133_1                           := N133_1;
                    self.N134_1                           := N134_1;
                    self.N135_1                           := N135_1;
                    self.N136_1                           := N136_1;
                    self.N137_1                           := N137_1;
                    self.N138_1                           := N138_1;
                    self.N139_1                           := N139_1;
                    self.N140_1                           := N140_1;
                    self.N141_1                           := N141_1;
                    self.N142_1                           := N142_1;
                    self.N143_1                           := N143_1;
                    self.N144_1                           := N144_1;
                    self.N145_1                           := N145_1;
                    self.N146_1                           := N146_1;
                    self.N147_1                           := N147_1;
                    self.N148_1                           := N148_1;
                    self.N149_1                           := N149_1;
                    self.N150_1                           := N150_1;
                    self.N151_1                           := N151_1;
                    self.N152_1                           := N152_1;
                    self.N153_1                           := N153_1;
                    self.N154_1                           := N154_1;
                    self.N155_1                           := N155_1;
                    self.N156_1                           := N156_1;
                    self.N157_1                           := N157_1;
                    self.N158_1                           := N158_1;
                    self.N159_1                           := N159_1;
                    self.N160_1                           := N160_1;
                    self.N161_1                           := N161_1;
                    self.N162_1                           := N162_1;
                    self.N163_1                           := N163_1;
                    self.N164_1                           := N164_1;
                    self.N165_1                           := N165_1;
                    self.N166_1                           := N166_1;
                    self.N167_1                           := N167_1;
                    self.N168_1                           := N168_1;
                    self.N169_1                           := N169_1;
                    self.N170_1                           := N170_1;
                    self.N171_1                           := N171_1;
                    self.N172_1                           := N172_1;
                    self.N173_1                           := N173_1;
                    self.N174_1                           := N174_1;
                    self.N175_1                           := N175_1;
                    self.N176_1                           := N176_1;
                    self.N177_1                           := N177_1;
                    self.N178_1                           := N178_1;
                    self.N179_1                           := N179_1;
                    self.N180_1                           := N180_1;
                    self.N181_1                           := N181_1;
                    self.N182_1                           := N182_1;
                    self.N183_1                           := N183_1;
                    self.N184_1                           := N184_1;
                    self.N185_1                           := N185_1;
                    self.N186_1                           := N186_1;
                    self.N187_1                           := N187_1;
                    self.N188_1                           := N188_1;
                    self.N189_1                           := N189_1;
                    self.N190_1                           := N190_1;
                    self.N191_1                           := N191_1;
                    self.N192_1                           := N192_1;
                    self.N193_1                           := N193_1;
                    self.N194_1                           := N194_1;
                    self.N195_1                           := N195_1;
                    self.N196_1                           := N196_1;
                    self.N197_1                           := N197_1;
                    self.N198_1                           := N198_1;
                    self.N199_1                           := N199_1;
                    self.N200_1                           := N200_1;
                    self.N201_1                           := N201_1;
                    self.N202_1                           := N202_1;
                    self.N203_1                           := N203_1;
                    self.N204_1                           := N204_1;
                    self.N205_1                           := N205_1;
                    self.N206_1                           := N206_1;
                    self.N207_1                           := N207_1;
                    self.N208_1                           := N208_1;
                    self.N209_1                           := N209_1;
                    self.N210_1                           := N210_1;
                    self.N211_1                           := N211_1;
                    self.N212_1                           := N212_1;
                    self.N213_1                           := N213_1;
                    self.N214_1                           := N214_1;
                    self.N215_1                           := N215_1;
                    self.N216_1                           := N216_1;
                    self.N217_1                           := N217_1;
                    self.N218_1                           := N218_1;
                    self.N219_1                           := N219_1;
                    self.N220_1                           := N220_1;
                    self.N221_1                           := N221_1;
                    self.N222_1                           := N222_1;
                    self.N223_1                           := N223_1;
                    self.N224_1                           := N224_1;
                    self.N225_1                           := N225_1;
                    self.N226_1                           := N226_1;
                    self.N227_1                           := N227_1;
                    self.N228_1                           := N228_1;
                    self.N229_1                           := N229_1;
                    self.N230_1                           := N230_1;
                    self.N231_1                           := N231_1;
                    self.N232_1                           := N232_1;
                    self.N233_1                           := N233_1;
                    self.N234_1                           := N234_1;
                    self.N235_1                           := N235_1;
                    self.N236_1                           := N236_1;
                    self.N237_1                           := N237_1;
                    self.N238_1                           := N238_1;
                    self.N239_1                           := N239_1;
                    self.N240_1                           := N240_1;
                    self.N241_1                           := N241_1;
                    self.N242_1                           := N242_1;
                    self.N243_1                           := N243_1;
                    self.N244_1                           := N244_1;
                    self.N245_1                           := N245_1;
                    self.N246_1                           := N246_1;
                    self.N247_1                           := N247_1;
                    self.N248_1                           := N248_1;
                    self.N249_1                           := N249_1;
                    self.N250_1                           := N250_1;
                    self.N251_1                           := N251_1;
                    self.N252_1                           := N252_1;
                    self.N253_1                           := N253_1;
                    self.N254_1                           := N254_1;
                    self.N255_1                           := N255_1;
                    self.N256_1                           := N256_1;
                    self.N257_1                           := N257_1;
                    self.N258_1                           := N258_1;
                    self.N259_1                           := N259_1;
                    self.N260_1                           := N260_1;
                    self.N261_1                           := N261_1;
                    self.N262_1                           := N262_1;
                    self.N263_1                           := N263_1;
                    self.N264_1                           := N264_1;
                    self.N265_1                           := N265_1;
                    self.N266_1                           := N266_1;
                    self.N267_1                           := N267_1;
                    self.N268_1                           := N268_1;
                    self.N269_1                           := N269_1;
                    self.N270_1                           := N270_1;
                    self.N271_1                           := N271_1;
                    self.N272_1                           := N272_1;
                    self.N273_1                           := N273_1;
                    self.N274_1                           := N274_1;
                    self.N275_1                           := N275_1;
                    self.N276_1                           := N276_1;
                    self.N277_1                           := N277_1;
                    self.N278_1                           := N278_1;
                    self.N279_1                           := N279_1;
                    self.N280_1                           := N280_1;
                    self.N281_1                           := N281_1;
                    self.N282_1                           := N282_1;
                    self.N283_1                           := N283_1;
                    self.N284_1                           := N284_1;
                    self.N285_1                           := N285_1;
                    self.N286_1                           := N286_1;
                    self.N287_1                           := N287_1;
                    self.N288_1                           := N288_1;
                    self.N289_1                           := N289_1;
                    self.N290_1                           := N290_1;
                    self.N291_1                           := N291_1;
                    self.N292_1                           := N292_1;
                    self.N293_1                           := N293_1;
                    self.N294_1                           := N294_1;
                    self.N295_1                           := N295_1;
                    self.N296_1                           := N296_1;
                    self.N297_1                           := N297_1;
                    self.N298_1                           := N298_1;
                    self.N299_1                           := N299_1;
                    self.N300_1                           := N300_1;
                    self.N301_1                           := N301_1;
                    self.N302_1                           := N302_1;
                    self.N303_1                           := N303_1;
                    self.N304_1                           := N304_1;
                    self.N305_1                           := N305_1;
                    self.N306_1                           := N306_1;
                    self.N307_1                           := N307_1;
                    self.N308_1                           := N308_1;
                    self.N309_1                           := N309_1;
                    self.N310_1                           := N310_1;
                    self.N311_1                           := N311_1;
                    self.N312_1                           := N312_1;
                    self.N313_1                           := N313_1;
                    self.N314_1                           := N314_1;
                    self.N315_1                           := N315_1;
                    self.N316_1                           := N316_1;
                    self.N317_1                           := N317_1;
                    self.N318_1                           := N318_1;
                    self.N319_1                           := N319_1;
                    self.N320_1                           := N320_1;
                    self.N321_1                           := N321_1;
                    self.N322_1                           := N322_1;
                    self.N323_1                           := N323_1;
                    self.N324_1                           := N324_1;
                    self.N325_1                           := N325_1;
                    self.N326_1                           := N326_1;
                    self.N327_1                           := N327_1;
                    self.N328_1                           := N328_1;
                    self.N329_1                           := N329_1;
                    self.N330_1                           := N330_1;
                    self.N331_1                           := N331_1;
                    self.N332_1                           := N332_1;
                    self.N333_1                           := N333_1;
                    self.N334_1                           := N334_1;
                    self.N335_1                           := N335_1;
                    self.N336_1                           := N336_1;
                    self.N337_1                           := N337_1;
                    self.N338_1                           := N338_1;

                    self.class_threshold                  := (string)class_threshold;
                    self.score0                           := (string)score0;
                    self.score1                           := (string)score1;
                    self.expsum                           := (string)expsum;
                    self.prob0                            := (string)prob0;
                    self.prob1                            := (string)prob1;
                    self.base                             := (string)base;
                    self.pts                              := (string)pts;
                    self.odds                             := (string)odds;
                    self.fp1404_1_0                       := (string)fp1404_1_0;
                    self.pred                             := (string)pred;
#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(fp1404_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1404_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;
